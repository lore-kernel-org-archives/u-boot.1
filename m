Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A0AC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B50586F5F;
	Mon,  6 Nov 2023 09:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4ffLRdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A660086F5F; Mon,  6 Nov 2023 09:33:17 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4669B86F95
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso611144466b.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259577; x=1699864377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfpbebHmj3SbuVDSsc+mIfZFL/vs0g9TApfxj78EOH8=;
 b=i4ffLRdCJc+VoYO3cApuUXBZdKwDHeDMmP9fxV73tVuQcF19nWyH3/QcMLBmXoZNqA
 l3tff8eQWpq5zUgw0NgTP+gbUXl+l+YFWp6wvLbCOeGy2k63vvzS1FvalJFIcsE/Vd9F
 Sy+2aEmevzdioJCfyT+sxXu2/LFUvsEbMB8nTzKMMN+IGoW7gAbJp9gC+W3/hokxh7OO
 41LvjAdzhfPWAjDB+Qefxbp/JyTN9g5iykmGv7VxiEfDIE29VLlS9HT47f8t68BSzION
 eN2ZuYi18Oe+PigWXb2Bit2Qzd6maDdJdq/+QDtrXq8hgDJ1rra0t7MqbFC9GwAfgqDM
 vk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259577; x=1699864377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfpbebHmj3SbuVDSsc+mIfZFL/vs0g9TApfxj78EOH8=;
 b=A9SwqiUC85szWwso3gvvJhiXg3i0jpejLnjMzNyiExE1xWxjNhdTadkygqcHCK9sAT
 l9UPR8YL3OqhNaHumXmVeAxPYF2jFk8eHuOe83Sr5pgoHs+dYZWL4hZ3KvRV6gGFvDmD
 roc3N31mgcXObjhAxv+iNjXk/04NR4PrxpS6RMSQ/K9MTcKPgkvXK5vpcCkknoQw7qI5
 S7EnjKwdG2dCyzjrsTQgD3ZjfSj/4sIL1hWauldKMYmBFCHIg67sN3z4LdvhNt/+ERwc
 tW+P+ALudIB7BUh+vUDcOKNi607wqhXOgSEXhVWh3ZqpTFzMhG5WUbUdzhqEVaFsEy4T
 JhBg==
X-Gm-Message-State: AOJu0YznprRq09ZjBy5R1govRcpfQSXPZ/vmTFpZLfF0Ne24Bh9bDCbK
 8wf3kymYX1oEwnXIMpacJ3O30lbyy10=
X-Google-Smtp-Source: AGHT+IE/kFZYftVsHDeY+4GmDahZFLfj+uJ9fDNqTqu6reLf6HhfYzbwLrad5+IbsCug2lnNZpn9EA==
X-Received: by 2002:a17:907:3ea7:b0:9d3:afe1:b3e5 with SMTP id
 hs39-20020a1709073ea700b009d3afe1b3e5mr12924894ejc.75.1699259576757; 
 Mon, 06 Nov 2023 00:32:56 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] board: grouper: convert ASUS Google Nexus 7 (2012) to
 use DM PMIC
Date: Mon,  6 Nov 2023 10:32:28 +0200
Message-Id: <20231106083229.256322-5-clamor95@gmail.com>
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
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
 board/asus/grouper/Kconfig                    |   8 -
 board/asus/grouper/Makefile                   |   4 +-
 .../asus/grouper/configs/grouper_E1565.config |   6 +-
 .../asus/grouper/configs/grouper_PM269.config |   6 +-
 board/asus/grouper/configs/tilapia.config     |   6 +-
 board/asus/grouper/grouper-spl-max.c          |   2 +-
 board/asus/grouper/grouper-spl-ti.c           |   2 +-
 board/asus/grouper/grouper.c                  | 154 +-----------------
 configs/grouper_common_defconfig              |   1 +
 12 files changed, 29 insertions(+), 163 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
index 945ae404ac..bfc675ca92 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
@@ -35,6 +35,7 @@
 					regulator-name = "vcore_emmc";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
index 4363bfc87d..cf03011bc1 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
@@ -36,6 +36,7 @@
 					regulator-name = "vdd_emmc_core";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
index 89348fde13..ef8b2b5049 100644
--- a/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
+++ b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
@@ -35,6 +35,7 @@
 					regulator-name = "vcore_emmc";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
index 47d9bae946..f935cce422 100644
--- a/board/asus/grouper/Kconfig
+++ b/board/asus/grouper/Kconfig
@@ -9,12 +9,4 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "grouper"
 
-config GROUPER_TPS65911
-	bool "Enable support TI TPS65911 PMIC"
-	select CMD_POWEROFF
-
-config GROUPER_MAX77663
-	bool "Enable support MAXIM MAX77663 PMIC"
-	select CMD_POWEROFF
-
 endif
diff --git a/board/asus/grouper/Makefile b/board/asus/grouper/Makefile
index e4a477a366..d041cf8087 100644
--- a/board/asus/grouper/Makefile
+++ b/board/asus/grouper/Makefile
@@ -7,8 +7,8 @@
 #  Svyatoslav Ryhel <clamor95@gmail.com>
 
 ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_GROUPER_MAX77663) += grouper-spl-max.o
-obj-$(CONFIG_GROUPER_TPS65911) += grouper-spl-ti.o
+obj-$(CONFIG_DM_PMIC_MAX77663) += grouper-spl-max.o
+obj-$(CONFIG_DM_PMIC_TPS65910) += grouper-spl-ti.o
 endif
 
 obj-y += grouper.o
diff --git a/board/asus/grouper/configs/grouper_E1565.config b/board/asus/grouper/configs/grouper_E1565.config
index 4d8d5263fa..265295c8b3 100644
--- a/board/asus/grouper/configs/grouper_E1565.config
+++ b/board/asus/grouper/configs/grouper_E1565.config
@@ -1,2 +1,6 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-E1565"
-CONFIG_GROUPER_MAX77663=y
+CONFIG_CMD_POWEROFF=y
+# CONFIG_MAX77663_GPIO is not set
+CONFIG_DM_PMIC_MAX77663=y
+CONFIG_DM_REGULATOR_MAX77663=y
+CONFIG_SYSRESET_MAX77663=y
diff --git a/board/asus/grouper/configs/grouper_PM269.config b/board/asus/grouper/configs/grouper_PM269.config
index fc768b2051..a7ee3587ed 100644
--- a/board/asus/grouper/configs/grouper_PM269.config
+++ b/board/asus/grouper/configs/grouper_PM269.config
@@ -1,2 +1,6 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-PM269"
-CONFIG_GROUPER_TPS65911=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_DM_PMIC_TPS65910=y
+# CONFIG_DM_REGULATOR_TPS65910 is not set
+CONFIG_DM_REGULATOR_TPS65911=y
+CONFIG_SYSRESET_TPS65910=y
diff --git a/board/asus/grouper/configs/tilapia.config b/board/asus/grouper/configs/tilapia.config
index 1fb0633e3a..d461b4752a 100644
--- a/board/asus/grouper/configs/tilapia.config
+++ b/board/asus/grouper/configs/tilapia.config
@@ -1,3 +1,7 @@
 CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-tilapia-E1565"
-CONFIG_GROUPER_MAX77663=y
 CONFIG_SYS_PROMPT="Tegra30 (Tilapia) # "
+CONFIG_CMD_POWEROFF=y
+# CONFIG_MAX77663_GPIO is not set
+CONFIG_DM_PMIC_MAX77663=y
+CONFIG_DM_REGULATOR_MAX77663=y
+CONFIG_SYSRESET_MAX77663=y
diff --git a/board/asus/grouper/grouper-spl-max.c b/board/asus/grouper/grouper-spl-max.c
index 844383766a..3e58bf97cc 100644
--- a/board/asus/grouper/grouper-spl-max.c
+++ b/board/asus/grouper/grouper-spl-max.c
@@ -9,7 +9,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
+#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/asus/grouper/grouper-spl-ti.c b/board/asus/grouper/grouper-spl-ti.c
index e5b78f0121..1dcce80b48 100644
--- a/board/asus/grouper/grouper-spl-ti.c
+++ b/board/asus/grouper/grouper-spl-ti.c
@@ -9,7 +9,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
+#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/asus/grouper/grouper.c b/board/asus/grouper/grouper.c
index 5398ec8b9f..839a95ae15 100644
--- a/board/asus/grouper/grouper.c
+++ b/board/asus/grouper/grouper.c
@@ -7,105 +7,13 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
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
-#include "pinmux-config-grouper.h"
-
-#define TPS65911_I2C_ADDRESS		0x2D
-
-#define TPS65911_REG_LDO1		0x30
-#define TPS65911_REG_DEVCTRL		0x3F
-#define   DEVCTRL_PWR_OFF_MASK		BIT(7)
-#define   DEVCTRL_DEV_ON_MASK		BIT(2)
-#define   DEVCTRL_DEV_OFF_MASK		BIT(0)
-
-#define MAX77663_I2C_ADDRESS		0x3C
-
-#define MAX77663_REG_SD2		0x18
-#define MAX77663_REG_LDO3		0x29
-#define MAX77663_REG_ONOFF_CFG1		0x41
-#define   ONOFF_PWR_OFF			BIT(1)
-
-#ifdef CONFIG_CMD_POWEROFF
-#ifdef CONFIG_GROUPER_TPS65911
-int do_poweroff(struct cmd_tbl *cmdtp,
-		int flag, int argc, char *const argv[])
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
-
-	ret = dm_i2c_read(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	data_buffer[0] |= DEVCTRL_PWR_OFF_MASK;
-
-	ret = dm_i2c_write(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	data_buffer[0] |= DEVCTRL_DEV_OFF_MASK;
-	data_buffer[0] &= ~DEVCTRL_DEV_ON_MASK;
-
-	ret = dm_i2c_write(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	// wait some time and then print error
-	mdelay(5000);
-
-	printf("Failed to power off!!!\n");
-	return 1;
-}
-#endif /* CONFIG_GROUPER_TPS65911 */
-
-#ifdef CONFIG_GROUPER_MAX77663
-int do_poweroff(struct cmd_tbl *cmdtp,
-		int flag, int argc, char *const argv[])
-{
-	struct udevice *dev;
-	uchar data_buffer[1];
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDRESS, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return 0;
-	}
-
-	ret = dm_i2c_read(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	data_buffer[0] |= ONOFF_PWR_OFF;
+#include <power/regulator.h>
 
-	ret = dm_i2c_write(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	// wait some time and then print error
-	mdelay(5000);
-
-	printf("Failed to power off!!!\n");
-	return 1;
-}
-#endif /* CONFIG_GROUPER_MAX77663 */
-#endif /* CONFIG_CMD_POWEROFF */
+#include "pinmux-config-grouper.h"
 
 /*
  * Routine: pinmux_init
@@ -120,63 +28,13 @@ void pinmux_init(void)
 		ARRAY_SIZE(grouper_padctrl));
 }
 
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-static void __maybe_unused tps65911_voltage_init(void)
-{
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
-	ret = dm_i2c_reg_write(dev, TPS65911_REG_LDO1, 0xC9);
-	if (ret)
-		log_debug("vcore_emmc set failed: %d\n", ret);
-}
-
-static void __maybe_unused max77663_voltage_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDRESS, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return;
-	}
-
-	/* 0x60 for 1.8v, bit7:0 = voltage */
-	ret = dm_i2c_reg_write(dev, MAX77663_REG_SD2, 0x60);
-	if (ret)
-		log_debug("vdd_1v8_vio set failed: %d\n", ret);
-
-	/* 0xEC for 3.00v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
-	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO3, 0xEC);
-	if (ret)
-		log_debug("vcore_emmc set failed: %d\n", ret);
-}
-
-/*
- * Routine: pin_mux_mmc
- * Description: setup the MMC muxes, power rails, etc.
- */
-void pin_mux_mmc(void)
+int nvidia_board_init(void)
 {
-#ifdef CONFIG_GROUPER_MAX77663
-	/* Bring up eMMC power on MAX PMIC */
-	max77663_voltage_init();
-#endif
+	/* Set up boot-on regulators */
+	regulators_enable_boot_on(true);
 
-#ifdef CONFIG_GROUPER_TPS65911
-	/* Bring up eMMC power on TI PMIC */
-	tps65911_voltage_init();
-#endif
+	return 0;
 }
-#endif	/* MMC */
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 258d7b1139..616540f7d5 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PAUSE=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
-- 
2.40.1

