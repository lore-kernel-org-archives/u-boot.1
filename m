Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBACC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563C086FB7;
	Mon,  6 Nov 2023 09:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjdVfi85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537CD86F9E; Mon,  6 Nov 2023 09:32:58 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9253B86EF2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso637232466b.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259573; x=1699864373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weAEhBrGe+j/hdO8KCxg6DCxB9TdEm3TAHPNZMUmMSA=;
 b=ZjdVfi85Olq2q4IlE6Wza/YUo1ddq22gB6VFVrJBYi+hU3kPYtgeeNFenHDP7WLv2D
 G1ug1OUIiqWZf8u4d1wDV7H43v/0fixHsyoTUOVpqQbSyqYFnOPIND75b7lw+q4NJcsh
 ApII4Bavbdc6q5L/uV0xt9o3psa3kDdWR84wBT0PoNbuSjjml1mXxeidE3pIYt1H6IQ2
 oqFY5KESCwyhqhfgQe9XwsSOcPJWlJfN7FwYCXIyoigPfSIGhi90BG7PZq7Frd7OM/3O
 iRoT7ehiKz4wILfXlO4IBfv3bkkn0O42egdSNPhYNlI2rPgHlzM+/07WBm3EGlqn/fBr
 5yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259573; x=1699864373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weAEhBrGe+j/hdO8KCxg6DCxB9TdEm3TAHPNZMUmMSA=;
 b=VtbTvw4WXi3ebCe2m9BN4JZkRs1rLL/QqSQ34n+p8HCLYRHjiK79q91cRJPtgP74M0
 BwhTH94kVYGrGAojyfBI6rgXL1EwP4ZvZEV9NH1drSHKhc7uKvWhFd30PS+D/rXp9tLi
 IR3+XHqHh/6R+yTtEQ5ERgWfrjSNw1zTa3rTlfcV9VHeQC3aEFB9eYTYgsC+a3Kdwmo9
 IyG4n5QVVj3GNG0tDTvtJajI6C9yKpqdrymU10JxTGhf6qghfISoWeRsFGPWNERlSGa7
 P5bKAkG5k56Z/1CiLeEwU3R5g3rZPs8/3ijxiP6xZ++pBi/biJBQFtnkODkIIEo/ZJw5
 OCKg==
X-Gm-Message-State: AOJu0YwQaallPee4VJtoBABC+dWd3xyQcNqEs5vKYCGFAIq+5uz+zWK7
 MrGk060esThASogw2oMCEXReOoNI20w=
X-Google-Smtp-Source: AGHT+IFNnll3qOLjThgZnx3dxOoDlXKEAa7biToKx7YP5UHJAtRABzjAvYWalhg9iDI3/heJ5UeONg==
X-Received: by 2002:a17:907:9625:b0:9c3:70d5:dc57 with SMTP id
 gb37-20020a170907962500b009c370d5dc57mr16151957ejc.40.1699259573084; 
 Mon, 06 Nov 2023 00:32:53 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] board: lg-x3: convert LG Optimus 4X and Vu to use DM
 PMIC
Date: Mon,  6 Nov 2023 10:32:25 +0200
Message-Id: <20231106083229.256322-2-clamor95@gmail.com>
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
 arch/arm/dts/tegra30-lg-x3.dtsi |  1 +
 board/lg/x3-t30/x3-t30-spl.c    |  2 +-
 board/lg/x3-t30/x3-t30.c        | 97 ++-------------------------------
 configs/x3_t30_defconfig        |  4 ++
 4 files changed, 11 insertions(+), 93 deletions(-)

diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 6e52fc5a53..aa207a70c7 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -110,6 +110,7 @@
 					regulator-name = "vdd_ddr_rx";
 					regulator-min-microvolt = <2850000>;
 					regulator-max-microvolt = <2850000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/board/lg/x3-t30/x3-t30-spl.c b/board/lg/x3-t30/x3-t30-spl.c
index 864f2de45f..00f79dd1db 100644
--- a/board/lg/x3-t30/x3-t30-spl.c
+++ b/board/lg/x3-t30/x3-t30-spl.c
@@ -9,7 +9,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
+#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/lg/x3-t30/x3-t30.c b/board/lg/x3-t30/x3-t30.c
index a08e00dd87..2eaf16ded4 100644
--- a/board/lg/x3-t30/x3-t30.c
+++ b/board/lg/x3-t30/x3-t30.c
@@ -7,60 +7,14 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
-#include <i2c.h>
-#include <log.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/fuse.h>
-#include <asm/gpio.h>
-#include <linux/delay.h>
-#include "pinmux-config-x3.h"
-
-#define MAX77663_I2C_ADDR		0x1C
-
-#define MAX77663_REG_SD2		0x18
-#define MAX77663_REG_LDO2		0x27
-#define MAX77663_REG_LDO3		0x29
-#define MAX77663_REG_LDO5		0x2D
-#define MAX77663_REG_ONOFF_CFG1		0x41
-#define   ONOFF_PWR_OFF			BIT(1)
-
-#ifdef CONFIG_CMD_POWEROFF
-int do_poweroff(struct cmd_tbl *cmdtp, int flag,
-		int argc, char *const argv[])
-{
-	struct udevice *dev;
-	uchar data_buffer[1];
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDR, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return 0;
-	}
-
-	ret = dm_i2c_read(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
-	if (ret)
-		return ret;
+#include <power/regulator.h>
 
-	data_buffer[0] |= ONOFF_PWR_OFF;
-
-	ret = dm_i2c_write(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
-	if (ret)
-		return ret;
-
-	/* wait some time and then print error */
-	mdelay(5000);
-
-	printf("Failed to power off!!!\n");
-	return 1;
-}
-#endif
+#include "pinmux-config-x3.h"
 
 /*
  * Routine: pinmux_init
@@ -82,52 +36,11 @@ void pinmux_init(void)
 #endif
 }
 
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-static void max77663_voltage_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDR, 1, &dev);
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
-	/* 0xF2 for 3.30v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
-	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO2, 0xF2);
-	if (ret)
-		log_debug("avdd_usb set failed: %d\n", ret);
-
-	/* 0xEC for 3.00v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
-	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO3, 0xEC);
-	if (ret)
-		log_debug("vdd_usd set failed: %d\n", ret);
-
-	/* 0xE9 for 2.85v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
-	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO5, 0xE9);
-	if (ret)
-		log_debug("vcore_emmc set failed: %d\n", ret);
-}
-
-/*
- * Routine: pin_mux_mmc
- * Description: setup the MMC muxes, power rails, etc.
- */
-void pin_mux_mmc(void)
-{
-	/* Bring up uSD and eMMC power */
-	max77663_voltage_init();
-}
-#endif	/* MMC */
-
 int nvidia_board_init(void)
 {
+	/* Set up boot-on regulators */
+	regulators_enable_boot_on(true);
+
 	/* Set up panel bridge clocks */
 	clock_start_periph_pll(PERIPH_ID_EXTPERIPH3, CLOCK_ID_PERIPH,
 			       24 * 1000000);
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index a151f58524..90cbc2078a 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PAUSE=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -64,11 +65,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MAX77663=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MAX77663=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_PWM_TEGRA=y
 CONFIG_SYS_NS16550=y
 CONFIG_TEGRA20_SLINK=y
+CONFIG_SYSRESET_MAX77663=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
-- 
2.40.1

