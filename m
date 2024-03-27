Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6150C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 22:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170C98803A;
	Wed, 27 Mar 2024 23:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405018803F; Wed, 27 Mar 2024 23:12:13 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447F18801A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 23:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rpbV9-003MOX-BS;
 Wed, 27 Mar 2024 22:12:07 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] tpm: display warning if using gpio reset with TPM
Date: Wed, 27 Mar 2024 15:12:05 -0700
Message-Id: <20240327221205.1871317-1-tharvey@gateworks.com>
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
gpio-reset dt prop is missing for a TPM display a warning that
having a gpio reset on a TPM should not be used for a secure production
device.

TCG TIS spec [1] says:
"The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
platform CPU Reset signal such that it complies with the requirements
specified in section 1.2.7 HOST Platform Reset in the PC Client
Implementation Specification for Conventional BIOS."

The reasoning is that you should not be able to toggle a GPIO and reset
the TPM without resetting the CPU as well because if an attacker can
break into your OS via an OS level security flaw they can then reset the
TPM via GPIO and replay the measurements required to unseal keys
that you have otherwise protected.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: change the message to a warning and update commit desc/log
---
 drivers/tpm/tpm2_tis_spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index de9cf8f21e07..c9c83f6f0fc8 100644
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
+		log(LOGC_NONE, LOGL_WARNING,
+		    "%s: TPM gpio reset should not be used on secure production devices\n",
+		    dev->name);
 		dm_gpio_set_value(&reset_gpio, 1);
 		mdelay(1);
 		dm_gpio_set_value(&reset_gpio, 0);
-- 
2.25.1

