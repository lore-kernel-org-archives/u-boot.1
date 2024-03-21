Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241E9C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DD087F33;
	Thu, 21 Mar 2024 19:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D765488095; Thu, 21 Mar 2024 19:02:25 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C60B87D91
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rnMk9-00AbsO-Cm;
 Thu, 21 Mar 2024 18:02:21 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] tpm: display message when using gpio-reset instead of when
 missing it
Date: Thu, 21 Mar 2024 11:02:19 -0700
Message-Id: <20240321180219.1039622-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Instead of displaying what looks like an error message if a
gpio-reset dt prop is missing for a TPM dipslay a more
informative message about resetting the TPM if the gpio is found:

before:
tpm_tis_spi_probe: missing reset GPIO

after:
tpm@0: performing 1ms reset on gpio@30210000:12

Note that the reset dt binding prop used in this driver is not
dt-compliant; it does not exist in the Linux dt-bindings documentation
and the reset is not done by the Linux driver.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/tpm/tpm2_tis_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index de9cf8f21e07..944540f7a711 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *dev)
 			/* legacy reset */
 			ret = gpio_request_by_name(dev, "gpio-reset", 0,
 						   &reset_gpio, GPIOD_IS_OUT);
-			if (ret) {
-				log(LOGC_NONE, LOGL_NOTICE,
-				    "%s: missing reset GPIO\n", __func__);
+			if (ret)
 				goto init;
-			}
 			log(LOGC_NONE, LOGL_NOTICE,
 			    "%s: gpio-reset is deprecated\n", __func__);
 		}
+		log(LOGC_NONE, LOGL_NOTICE,
+		    "%s: performing 1ms reset on %s:%d\n", dev->name,
+		    reset_gpio.dev->name, reset_gpio.offset);
 		dm_gpio_set_value(&reset_gpio, 1);
 		mdelay(1);
 		dm_gpio_set_value(&reset_gpio, 0);
-- 
2.25.1

