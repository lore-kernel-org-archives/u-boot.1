Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB4C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EC988010;
	Thu, 16 May 2024 01:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8D988315; Thu, 16 May 2024 01:21:46 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C1C8800C
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1s7NwK-004s0j-Q7;
 Wed, 15 May 2024 23:21:40 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3] tpm: display warning if using gpio reset with TPM
Date: Wed, 15 May 2024 16:21:38 -0700
Message-Id: <20240515232138.3065987-1-tharvey@gateworks.com>
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

Additionally restructure the code for improved readability allowing for
removal of the init label.

Before:
 - board with no reset gpio
u-boot=> tpm init && tpm info
tpm_tis_spi_probe: missing reset GPIO
tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
 - board with a reset gpio
u-boot=> tpm init && tpm info
tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]

After:
 - board with no reset gpio
u-boot=> tpm init && tpm info
tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
 - board with a reset gpio
u-boot=> tpm init && tpm info
tpm@1: TPM gpio reset should not be used on secure production devices
tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3: restructure code for improved readability (recommended by Miquel)
v2: change the message to a warning
---
 drivers/tpm/tpm2_tis_spi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index 28079b5039a3..b0fe97ab1d08 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -237,19 +237,22 @@ static int tpm_tis_spi_probe(struct udevice *dev)
 			/* legacy reset */
 			ret = gpio_request_by_name(dev, "gpio-reset", 0,
 						   &reset_gpio, GPIOD_IS_OUT);
-			if (ret) {
+			if (!ret) {
 				log(LOGC_NONE, LOGL_NOTICE,
-				    "%s: missing reset GPIO\n", __func__);
-				goto init;
+				    "%s: gpio-reset is deprecated\n", __func__);
 			}
-			log(LOGC_NONE, LOGL_NOTICE,
-			    "%s: gpio-reset is deprecated\n", __func__);
 		}
-		dm_gpio_set_value(&reset_gpio, 1);
-		mdelay(1);
-		dm_gpio_set_value(&reset_gpio, 0);
+
+		if (!ret) {
+			log(LOGC_NONE, LOGL_WARNING,
+			    "%s: TPM gpio reset should not be used on secure production devices\n",
+			    dev->name);
+			dm_gpio_set_value(&reset_gpio, 1);
+			mdelay(1);
+			dm_gpio_set_value(&reset_gpio, 0);
+		}
 	}
-init:
+
 	/* Ensure a minimum amount of time elapsed since reset of the TPM */
 	mdelay(drv_data->time_before_first_cmd_ms);
 
-- 
2.25.1

