Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70608C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F4786C56;
	Mon,  6 Nov 2023 09:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QqmVVg2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DC786EF2; Mon,  6 Nov 2023 09:33:09 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3677E86F84
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so7141264a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259576; x=1699864376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RD3h8FEYdBzbZnTVOzlD4UahitmDFo/XfOTOXJE2/0=;
 b=QqmVVg2RhhT0Mb8v8+IryVI+KWg4Wu9uNa22Pc9tMhiVzgY+SdrKfdCSH2mFKFNFHe
 S3B1ZXunnxfS9h1yeC6KWuGjtAIo29YcA+jB3fRcQooPljq0SEN6BwJHseIA4a//ibez
 7LrtrnpcTvx8A1Bv26sewtKG86q4jYe8z7kxFBHx9T+sT0Yo0sJ8h/nM90JR92dvBKYV
 sH47s1YiKnUdk0V/M0tTVSBCTuPc3CYj0rJ81eRNtEHLXCuZu0Zyl2XMZgzWb2oXtkLK
 U5no7bKYVUPtx0tBdyicKG1P05bUe/uMGayRzSms7h9Xu1g7wrx7alQEFFnoPG5mIAbJ
 YKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259576; x=1699864376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RD3h8FEYdBzbZnTVOzlD4UahitmDFo/XfOTOXJE2/0=;
 b=BFqabRljzW9i1rgY+9WVno5sYDVkJNo1DvJore4zXeileYlp+GgXKQYC3LJ3hWQmKA
 EYDUVH4eFzu9Kds/aGacB5L52TiFJTk/qmOzN5rZuEwYATNsFfPOOXThx5G0bzlIzgFL
 P7W4pPtdL3TZepBH+hXSVPUZS51YhZmJQPkBYkCrBOl/d8C95Ip/6JnljOKetbiBgs1e
 qknGd5JVHQcWmDFwphNu3hUd4QPtiRN2ve9IsdlUXXdvHmTnuLjjNxygIgaBytGziqOf
 sSKZ3l8f+sNKVONO3EwnnZQ89RrRY9cRutTkXId4+3KwVTOIavT6Nhafg18bITGwgUHV
 JXKQ==
X-Gm-Message-State: AOJu0YyKlZsy95ZsKMF7zpP5/MK/jGClGjobBy+K96Y9gYYXcINSmgHC
 yzyOSyFCQeERgwupFFnRQrM=
X-Google-Smtp-Source: AGHT+IGN3kN7Pj7+b3f5MmR6eoUjbu3YaQOvSViEElaUGaVhlvaWkAIYHMIyI+l4jFqMMxB05jcdkA==
X-Received: by 2002:a17:907:2cc3:b0:9bd:7f40:caa5 with SMTP id
 hg3-20020a1709072cc300b009bd7f40caa5mr11856159ejc.77.1699259575562; 
 Mon, 06 Nov 2023 00:32:55 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:54 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] board: transformer-t30: convert ASUS Transformers to
 use DM PMIC
Date: Mon,  6 Nov 2023 10:32:27 +0200
Message-Id: <20231106083229.256322-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106083229.256322-1-clamor95@gmail.com>
References: <20231106083229.256322-1-clamor95@gmail.com>
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

Since required drivers were merged, we can safely clean up the
board and switch to DM based driver with device tree support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-p1801-t.dts         |   2 +
 arch/arm/dts/tegra30-asus-tf600t.dts          |   4 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    |   2 +
 board/asus/transformer-t30/Kconfig            |  10 --
 .../transformer-t30/configs/tf600t.config     |   2 +-
 .../transformer-t30/transformer-t30-spl.c     |   2 +-
 board/asus/transformer-t30/transformer-t30.c  | 121 +-----------------
 configs/transformer_t30_defconfig             |   5 +
 8 files changed, 21 insertions(+), 127 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 39f7caf8d0..d62d43268b 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -101,6 +101,7 @@
 					regulator-name = "vdd_emmc_core";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
 				};
 
 				/* uSD slot VDD */
@@ -108,6 +109,7 @@
 					regulator-name = "vdd_usd";
 					regulator-min-microvolt = <3100000>;
 					regulator-max-microvolt = <3100000>;
+					regulator-boot-on;
 				};
 
 				/* uSD slot VDDIO */
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index fd9d11ca19..efc6a83b9d 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -84,12 +84,14 @@
 					regulator-name = "vdd_1v2_backlight";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
 				};
 
 				vcore_lcd: vdd2 {
 					regulator-name = "vcore_lcd";
 					regulator-min-microvolt = <1500000>;
 					regulator-max-microvolt = <1500000>;
+					regulator-boot-on;
 				};
 
 				vdd_1v8_vio: vddio {
@@ -105,6 +107,7 @@
 					regulator-name = "vdd_emmc_core";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
 				};
 
 				/* uSD slot VDDIO */
@@ -119,6 +122,7 @@
 					regulator-name = "avdd_dsi_csi";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index 888f9ca74e..afddb83983 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -82,6 +82,7 @@
 					regulator-name = "vdd_emmc_core";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
 				};
 
 				/* uSD slot VDD */
@@ -89,6 +90,7 @@
 					regulator-name = "vdd_usd";
 					regulator-min-microvolt = <3100000>;
 					regulator-max-microvolt = <3100000>;
+					regulator-boot-on;
 				};
 
 				/* uSD slot VDDIO */
diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
index accc999c43..915436ba6c 100644
--- a/board/asus/transformer-t30/Kconfig
+++ b/board/asus/transformer-t30/Kconfig
@@ -9,14 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "transformer-t30"
 
-config TRANSFORMER_SPI_BOOT
-	bool "Enable support for SPI based flash"
-	select TEGRA20_SLINK
-	select DM_SPI_FLASH
-	select SPI_FLASH_WINBOND
-	help
-	  Tegra 3 based Transformers with Windows RT have core
-	  boot sequence (BCT and EBT) on separate SPI FLASH
-	  memory with 4MB size.
-
 endif
diff --git a/board/asus/transformer-t30/configs/tf600t.config b/board/asus/transformer-t30/configs/tf600t.config
index 18ab4fbd87..e40d0fdd47 100644
--- a/board/asus/transformer-t30/configs/tf600t.config
+++ b/board/asus/transformer-t30/configs/tf600t.config
@@ -1,4 +1,4 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
-CONFIG_TRANSFORMER_SPI_BOOT=y
 CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/board/asus/transformer-t30/transformer-t30-spl.c b/board/asus/transformer-t30/transformer-t30-spl.c
index 89819b2b92..952e2c8224 100644
--- a/board/asus/transformer-t30/transformer-t30-spl.c
+++ b/board/asus/transformer-t30/transformer-t30-spl.c
@@ -9,7 +9,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
+#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index ba795a802e..29d77146bb 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -9,70 +9,13 @@
 
 /* T30 Transformers derive from Cardhu board */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
-#include <i2c.h>
-#include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/gp_padctrl.h>
-#include <asm/arch/gpio.h>
-#include <asm/gpio.h>
-#include <linux/delay.h>
-#include "pinmux-config-transformer.h"
-
-#define TPS65911_I2C_ADDRESS		0x2D
-
-#define TPS65911_VDD1			0x21
-#define TPS65911_VDD1_OP		0x22
-#define TPS65911_LDO1			0x30
-#define TPS65911_LDO2			0x31
-#define TPS65911_LDO3			0x37
-#define TPS65911_LDO5			0x32
-#define TPS65911_LDO6			0x35
-
-#define TPS65911_DEVCTRL		0x3F
-#define   DEVCTRL_PWR_OFF_MASK		BIT(7)
-#define   DEVCTRL_DEV_ON_MASK		BIT(2)
-#define   DEVCTRL_DEV_OFF_MASK		BIT(0)
-
-#ifdef CONFIG_CMD_POWEROFF
-int do_poweroff(struct cmd_tbl *cmdtp, int flag,
-		int argc, char *const argv[])
-{
-	struct udevice *dev;
-	uchar data_buffer[1];
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, TPS65911_I2C_ADDRESS, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return 0;
-	}
+#include <power/regulator.h>
 
-	ret = dm_i2c_read(dev, TPS65911_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	data_buffer[0] |= DEVCTRL_PWR_OFF_MASK;
-
-	ret = dm_i2c_write(dev, TPS65911_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	data_buffer[0] |= DEVCTRL_DEV_OFF_MASK;
-	data_buffer[0] &= ~DEVCTRL_DEV_ON_MASK;
-
-	ret = dm_i2c_write(dev, TPS65911_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	// wait some time and then print error
-	mdelay(5000);
-	printf("Failed to power off!!!\n");
-	return 1;
-}
-#endif
+#include "pinmux-config-transformer.h"
 
 /*
  * Routine: pinmux_init
@@ -92,65 +35,13 @@ void pinmux_init(void)
 	}
 }
 
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-static void tps65911_voltage_init(void)
+int nvidia_board_init(void)
 {
-	struct udevice *dev;
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, TPS65911_I2C_ADDRESS, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return;
-	}
-
-	/* TPS659110: LDO1_REG = 3.3v, ACTIVE to SDMMC4 */
-	ret = dm_i2c_reg_write(dev, TPS65911_LDO1, 0xc9);
-	if (ret)
-		log_debug("vcore_emmc set failed: %d\n", ret);
-
-	if (of_machine_is_compatible("asus,tf600t")) {
-		/* TPS659110: VDD1_REG = 1.2v, ACTIVE to backlight */
-		ret = dm_i2c_reg_write(dev, TPS65911_VDD1_OP, 0x33);
-		if (ret)
-			log_debug("vdd_bl set failed: %d\n", ret);
-
-		ret = dm_i2c_reg_write(dev, TPS65911_VDD1, 0x0d);
-		if (ret)
-			log_debug("vdd_bl enable failed: %d\n", ret);
-
-		/* TPS659110: LDO5_REG = 3.3v, ACTIVE to SDMMC1 VIO */
-		ret = dm_i2c_reg_write(dev, TPS65911_LDO5, 0x65);
-		if (ret)
-			log_debug("vdd_usd set failed: %d\n", ret);
-
-		/* TPS659110: LDO6_REG = 1.2v, ACTIVE to MIPI */
-		ret = dm_i2c_reg_write(dev, TPS65911_LDO6, 0x11);
-		if (ret)
-			log_debug("vdd_mipi set failed: %d\n", ret);
-	} else {
-		/* TPS659110: LDO2_REG = 3.1v, ACTIVE to SDMMC1 */
-		ret = dm_i2c_reg_write(dev, TPS65911_LDO2, 0xb9);
-		if (ret)
-			log_debug("vdd_usd set failed: %d\n", ret);
+	/* Set up boot-on regulators */
+	regulators_enable_boot_on(true);
 
-		/* TPS659110: LDO3_REG = 3.1v, ACTIVE to SDMMC1 VIO */
-		ret = dm_i2c_reg_write(dev, TPS65911_LDO3, 0x5d);
-		if (ret)
-			log_debug("vddio_usd set failed: %d\n", ret);
-	}
-}
-
-/*
- * Routine: pin_mux_mmc
- * Description: setup the MMC muxes, power rails, etc.
- */
-void pin_mux_mmc(void)
-{
-	/* Bring up uSD and eMMC power */
-	tps65911_voltage_init();
+	return 0;
 }
-#endif	/* MMC */
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 092c0aa2b0..8d828c1fa6 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PAUSE=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -65,10 +66,14 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_GPIO=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_TPS65910=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_TPS65911=y
 CONFIG_PWM_TEGRA=y
 CONFIG_SYS_NS16550=y
+CONFIG_TEGRA20_SLINK=y
+CONFIG_SYSRESET_TPS65910=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
-- 
2.40.1

