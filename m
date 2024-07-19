Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7CDC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 21:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBDB88C20;
	Fri, 19 Jul 2024 23:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721425899;
	bh=9j301ztMybjUtPgr0DlzYbPuGUn/veqW+3PYMpVp/dY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o984jmdDGaDqTMpakFgOsp8T4KCZVOcWWCHPr+abOJERur3o0/LZRoPzoB8DqJf/Q
	 7HRyDIaGFUdOn9WMCrC+iYNJuaaVeMo97WZX3ihFQCy0GhJxh9mieE4M2B0hZR+Sg+
	 y8fj5GCcQgRvsMqLZzOW+xx4yfzZ5JS9MF/Vm6EAIZxt2HZor/vSGmOLOX64rxkeaD
	 n8oka7Ae62eeQAYx2d3bodaoX99mjI2r8802et+8hAb4ltAwRP9TSOBN572BjFyJ6p
	 n+m5iIXhd6hEfC7vxsAtvqPKtY1LjTDKEKG57tQ6i3jtFdWLdOmThhIcHOMkE97oiV
	 Hgeeu7sqal/4Q==
Received: from crub.agik.hopto.org (p508b6272.dip0.t-ipconnect.de
 [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6061988BFD;
 Fri, 19 Jul 2024 23:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721425898;
 bh=9j301ztMybjUtPgr0DlzYbPuGUn/veqW+3PYMpVp/dY=;
 h=From:To:Cc:Subject:Date:From;
 b=FPZ5IqrOpJXW940TI8zcanzkBze5ABgDQd+n58cvQQepM5GREwqatYqMYy5/PWMRb
 KXkM9TsL3MfX5hlT7nldGdsHWlo4FgFWzxn/UU9/KYR2aud9HMm3W39T+WHLNeg2+g
 9pGtpSTtcKq/BfOOxnaGpQe/u7+q24gUe/cXebsWyIKAoNKqhAMXCJawSKA7sDR7/9
 RayRdzWyz3V3hL/C309JF7fD/+PCZT8Idp6xQCo++c8YhpAGX1SCEFCdXnb30GZygf
 +RNnpabOEqpgR3m5W1YUd1dG0SIIj0bbbYpaNzodFEnKq4Bmhgno4AvrukPBqFySu/
 SNIosuwqfr3xg==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: beagle: convert to CONFIG_DM_I2C
Date: Fri, 19 Jul 2024 23:51:23 +0200
Message-Id: <20240719215123.3358410-1-agust@denx.de>
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

Rework to remove use of legacy I2C API.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 board/beagle/beagle/beagle.c   | 41 +++++++++++++++++++++-------------
 configs/omap3_beagle_defconfig |  2 +-
 include/configs/omap3_beagle.h |  3 ---
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/board/beagle/beagle/beagle.c b/board/beagle/beagle/beagle.c
index ac2f89cf21..ae258817e9 100644
--- a/board/beagle/beagle/beagle.c
+++ b/board/beagle/beagle/beagle.c
@@ -41,7 +41,6 @@
 #include "beagle.h"
 #include <command.h>
 
-#define TWL4030_I2C_BUS			0
 #define EXPANSION_EEPROM_I2C_BUS	1
 #define EXPANSION_EEPROM_I2C_ADDRESS	0x50
 
@@ -213,27 +212,37 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
  */
 static unsigned int get_expansion_id(void)
 {
-	i2c_set_bus_num(EXPANSION_EEPROM_I2C_BUS);
+	struct udevice *eeprom = NULL;
+	int ret;
 
-	/* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
-	if (i2c_probe(EXPANSION_EEPROM_I2C_ADDRESS) == 1) {
-		i2c_set_bus_num(TWL4030_I2C_BUS);
+	ret = i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
+				      EXPANSION_EEPROM_I2C_ADDRESS, 1, &eeprom);
+	if (ret)
 		return BEAGLE_NO_EEPROM;
-	}
 
 	/* read configuration data */
-	i2c_read(EXPANSION_EEPROM_I2C_ADDRESS, 0, 1, (u8 *)&expansion_config,
-		 sizeof(expansion_config));
+	ret = dm_i2c_read(eeprom, 0, (uint8_t *)&expansion_config,
+			  sizeof(expansion_config));
+	if (ret != 0) {
+		/* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
+		return BEAGLE_NO_EEPROM;
+	}
 
-	/* retry reading configuration data with 16bit addressing */
 	if ((expansion_config.device_vendor == 0xFFFFFF00) ||
 	    (expansion_config.device_vendor == 0xFFFFFFFF)) {
 		printf("EEPROM is blank or 8bit addressing failed: retrying with 16bit:\n");
-		i2c_read(EXPANSION_EEPROM_I2C_ADDRESS, 0, 2, (u8 *)&expansion_config,
-			 sizeof(expansion_config));
 	}
 
-	i2c_set_bus_num(TWL4030_I2C_BUS);
+	/* retry reading configuration data with 16bit addressing */
+	ret = i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
+				      EXPANSION_EEPROM_I2C_ADDRESS, 2, &eeprom);
+	if (ret)
+		return BEAGLE_NO_EEPROM;
+
+	ret = dm_i2c_read(eeprom, 0, (uint8_t *)&expansion_config,
+			  sizeof(expansion_config));
+	if (ret != 0)
+		return BEAGLE_NO_EEPROM;
 
 	return expansion_config.device_vendor;
 }
@@ -281,13 +290,13 @@ static void beagle_dvi_pup(void)
 		#define GPIODATADIR1 (TWL4030_BASEADD_GPIO+3)
 		#define GPIODATAOUT1 (TWL4030_BASEADD_GPIO+6)
 
-		i2c_read(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
+		twl4030_i2c_read_u8(TWL4030_CHIP_GPIO, GPIODATADIR1, &val);
 		val |= 4;
-		i2c_write(TWL4030_CHIP_GPIO, GPIODATADIR1, 1, &val, 1);
+		twl4030_i2c_write_u8(TWL4030_CHIP_GPIO, GPIODATADIR1, val);
 
-		i2c_read(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
+		twl4030_i2c_read_u8(TWL4030_CHIP_GPIO, GPIODATAOUT1, &val);
 		val |= 4;
-		i2c_write(TWL4030_CHIP_GPIO, GPIODATAOUT1, 1, &val, 1);
+		twl4030_i2c_write_u8(TWL4030_CHIP_GPIO, GPIODATAOUT1, val);
 		break;
 	}
 }
diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
index 8a709243a9..f76709389c 100644
--- a/configs/omap3_beagle_defconfig
+++ b/configs/omap3_beagle_defconfig
@@ -61,7 +61,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED_STATUS=y
 CONFIG_LED_STATUS0=y
diff --git a/include/configs/omap3_beagle.h b/include/configs/omap3_beagle.h
index af7cb3513f..b616dd2608 100644
--- a/include/configs/omap3_beagle.h
+++ b/include/configs/omap3_beagle.h
@@ -28,9 +28,6 @@
 /* NAND: SPL falcon mode configs */
 #endif /* CONFIG_MTD_RAW_NAND */
 
-/* Enable Multi Bus support for I2C */
-#define CFG_I2C_MULTI_BUS
-
 /* DSS Support */
 
 /* TWL4030 LED Support */
-- 
2.25.1

