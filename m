Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6AFCF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD3E891B9;
	Thu, 10 Oct 2024 07:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="loLJVqMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D5E89196; Thu, 10 Oct 2024 07:56:06 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821D08908A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20241010055558ec9b6e350660bff040 for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mFSLz5ADlY8kVaYQC9wF9+mmkTIOjlSq2XqI63H619o=;
 b=loLJVqMS9dImAA3tySpLQQ4OHxUHVLfFh1+mTSSDW9idJj8wEehF+E+UjMCQqEbSxu0DPs
 nySJ++DbOkTmJwusgbF2ce+20UadFMShaaLf21gwslp/kXrmpJ2GTlzOTzmBm/ywKImVdg5Z
 EUdd3C2bdAKGYtHNl3F12tE0n5yU3qG9SadkA1NU3QGUTMHCZ50rYK8yzvDmyDGU51P7NzEa
 tXp+gSo01PoHRKfBGtZfOnlgak8zlOxFU0EQA+2ysDqn/thue88JPiP1GcbAWLrq396+eYrA
 Ud595jbH/AHh5UL+5jihVZbYFs2MyzTD0NVqG62Sd2+WbEWnDybK+ekQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 07/11] board: siemens: iot2050: Migrate to OF_UPSTREAM
Date: Thu, 10 Oct 2024 07:55:51 +0200
Message-ID: <648ebfedc78fc7556f8832312c9b7138ecac8c93.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This requires some tweaking of the defconfig and
board_fit_config_name_match so that the new sources are taken into
account.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/dts/Makefile                         |   7 -
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  16 +-
 arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi  |  46 --
 arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi  |  51 --
 arch/arm/dts/k3-am65-iot2050-common.dtsi      | 738 ------------------
 .../dts/k3-am6528-iot2050-basic-common.dtsi   |  61 --
 arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts  |  24 -
 arch/arm/dts/k3-am6528-iot2050-basic.dts      |  24 -
 .../k3-am6548-iot2050-advanced-common.dtsi    |  52 --
 ...50-advanced-m2-bkey-ekey-pcie-overlay.dtso |  27 -
 ...iot2050-advanced-m2-bkey-usb3-overlay.dtso |  47 --
 .../arm/dts/k3-am6548-iot2050-advanced-m2.dts | 119 ---
 .../dts/k3-am6548-iot2050-advanced-pg2.dts    |  29 -
 arch/arm/dts/k3-am6548-iot2050-advanced.dts   |  24 -
 board/siemens/iot2050/board.c                 |   4 +-
 configs/iot2050_defconfig                     |   6 +-
 16 files changed, 15 insertions(+), 1260 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts
 delete mode 100644 arch/arm/dts/k3-am6528-iot2050-basic.dts
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced-pg2.dts
 delete mode 100644 arch/arm/dts/k3-am6548-iot2050-advanced.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index ab7705e5ed9..ef960ac8b5a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1180,13 +1180,6 @@ dtb-$(CONFIG_STM32MP25X) += \
 dtb-$(CONFIG_SOC_K3_AM654) += \
 	k3-am654-base-board.dtb \
 	k3-am654-r5-base-board.dtb \
-	k3-am6528-iot2050-basic.dtb \
-	k3-am6528-iot2050-basic-pg2.dtb \
-	k3-am6548-iot2050-advanced.dtb \
-	k3-am6548-iot2050-advanced-pg2.dtb \
-	k3-am6548-iot2050-advanced-m2.dtb \
-	k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtbo \
-	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo \
 	k3-am654-icssg2.dtbo
 
 dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-r5-common-proc-board.dtb \
diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index e17cd78e56c..1b31d412b4c 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -84,12 +84,12 @@
 				};
 
 				fdt-0 {
-					description = "k3-am6528-iot2050-basic.dtb";
+					description = "ti/k3-am6528-iot2050-basic.dtb";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
 					blob-ext {
-						filename = "spl/dts/k3-am6528-iot2050-basic.dtb";
+						filename = "spl/dts/ti/k3-am6528-iot2050-basic.dtb";
 					};
 				};
 			};
@@ -205,10 +205,10 @@
 		};
 
 		fit@380000 {
-			fit,fdt-list-val = "k3-am6528-iot2050-basic", "k3-am6548-iot2050-advanced";
+			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic", "ti/k3-am6548-iot2050-advanced";
 
 			configurations {
-				default = "k3-am6528-iot2050-basic";
+				default = "ti/k3-am6528-iot2050-basic";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
@@ -229,7 +229,7 @@
 		};
 
 		fit@380000 {
-			fit,fdt-list-val = "k3-am6528-iot2050-basic-pg2", "k3-am6548-iot2050-advanced-pg2", "k3-am6548-iot2050-advanced-m2";
+			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic-pg2", "ti/k3-am6548-iot2050-advanced-pg2", "ti/k3-am6548-iot2050-advanced-m2";
 
 			images {
 				bkey-usb3-overlay {
@@ -239,7 +239,7 @@
 					arch = "arm64";
 					compression = "none";
 					blob-ext {
-						filename = "k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtbo";
+						filename = "ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo";
 					};
 					hash {
 						algo = "sha256";
@@ -253,7 +253,7 @@
 					arch = "arm64";
 					compression = "none";
 					blob-ext {
-						filename = "k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo";
+						filename = "ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo";
 					};
 					hash {
 						algo = "sha256";
@@ -262,7 +262,7 @@
 			};
 
 			configurations {
-				default = "k3-am6528-iot2050-basic-pg2";
+				default = "ti/k3-am6528-iot2050-basic-pg2";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
diff --git a/arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi b/arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi
deleted file mode 100644
index 51f902fa35a..00000000000
--- a/arch/arm/dts/k3-am65-iot2050-common-pg1.dtsi
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2021
- *
- * Authors:
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * Common bits of the IOT2050 Basic and Advanced variants, PG1
- */
-
-&dss {
-	assigned-clocks = <&k3_clks 67 2>;
-	assigned-clock-parents = <&k3_clks 67 5>;
-};
-
-&serdes0 {
-	status = "disabled";
-};
-
-&sdhci1 {
-	no-1-8-v;
-};
-
-&tx_pru0_0 {
-	status = "disabled";
-};
-
-&tx_pru0_1 {
-	status = "disabled";
-};
-
-&tx_pru1_0 {
-	status = "disabled";
-};
-
-&tx_pru1_1 {
-	status = "disabled";
-};
-
-&tx_pru2_0 {
-	status = "disabled";
-};
-
-&tx_pru2_1 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi b/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
deleted file mode 100644
index e9419c4fe60..00000000000
--- a/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2021
- *
- * Authors:
- *   Chao Zeng <chao.zeng@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * Common bits of the IOT2050 Basic and Advanced variants, PG2
- */
-
-&main_pmx0 {
-	cp2102n_reset_pin_default: cp2102n-reset-default-pins {
-		pinctrl-single,pins = <
-			/* (AF12) GPIO1_24, used as cp2102 reset */
-			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
-		>;
-	};
-};
-
-&main_gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cp2102n_reset_pin_default>;
-	gpio-line-names =
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "CP2102N-RESET";
-};
-
-&dss {
-	/* Workaround needed to get DP clock of 154Mhz */
-	assigned-clocks = <&k3_clks 67 0>;
-};
-
-&serdes0 {
-	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
-	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
-};
-
-&dwc3_0 {
-	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
-				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
-	phys = <&serdes0 PHY_TYPE_USB3 0>;
-	phy-names = "usb3-phy";
-};
-
-&usb0 {
-	maximum-speed = "super-speed";
-	snps,dis-u1-entry-quirk;
-	snps,dis-u2-entry-quirk;
-};
diff --git a/arch/arm/dts/k3-am65-iot2050-common.dtsi b/arch/arm/dts/k3-am65-iot2050-common.dtsi
deleted file mode 100644
index fa7178144b8..00000000000
--- a/arch/arm/dts/k3-am65-iot2050-common.dtsi
+++ /dev/null
@@ -1,738 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * Common bits of the IOT2050 Basic and Advanced variants, PG1 and PG2
- */
-
-#include "k3-am654.dtsi"
-#include <dt-bindings/phy/phy.h>
-
-/ {
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &main_i2c0;
-		i2c3 = &main_i2c1;
-		i2c4 = &main_i2c2;
-		i2c5 = &main_i2c3;
-		spi0 = &mcu_spi0;
-		mmc0 = &sdhci1;
-		mmc1 = &sdhci0;
-	};
-
-	chosen {
-		stdout-path = "serial3:115200n8";
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		secure_ddr: secure-ddr@9e800000 {
-			reg = <0 0x9e800000 0 0x01800000>; /* for OP-TEE */
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa0000000 0 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa0100000 0 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1000000 0 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1100000 0 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a2000000 {
-			reg = <0x00 0xa2000000 0x00 0x00200000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		/* To reserve the power-on(PON) reason for watchdog reset */
-		wdt_reset_memory_region: wdt-memory@a2200000 {
-			reg = <0x00 0xa2200000 0x00 0x00001000>;
-			no-map;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>;
-
-		status-led-red {
-			gpios = <&wkup_gpio0 32 GPIO_ACTIVE_HIGH>;
-			panic-indicator;
-		};
-
-		status-led-green {
-			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_HIGH>;
-		};
-
-		user-led1-red {
-			gpios = <&pcal9535_3 14 GPIO_ACTIVE_HIGH>;
-		};
-
-		user-led1-green {
-			gpios = <&pcal9535_2 15 GPIO_ACTIVE_HIGH>;
-		};
-
-		user-led2-red {
-			gpios = <&wkup_gpio0 17 GPIO_ACTIVE_HIGH>;
-		};
-
-		user-led2-green {
-			gpios = <&wkup_gpio0 22 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	dp_refclk: clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <19200000>;
-	};
-};
-
-&wkup_pmx0 {
-	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
-		pinctrl-single,pins = <
-			/* (AC7) WKUP_I2C0_SCL */
-			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT,  0)
-			/* (AD6) WKUP_I2C0_SDA */
-			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT,  0)
-		>;
-	};
-
-	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
-		pinctrl-single,pins = <
-			/* (AD8) MCU_I2C0_SCL */
-			AM65X_WKUP_IOPAD(0x00e8, PIN_INPUT,  0)
-			/* (AD7) MCU_I2C0_SDA */
-			AM65X_WKUP_IOPAD(0x00ec, PIN_INPUT,  0)
-		>;
-	};
-
-	arduino_i2c_aio_switch_pins_default: arduino-i2c-aio-switch-default-pins {
-		pinctrl-single,pins = <
-			/* (R2) WKUP_GPIO0_21 */
-			AM65X_WKUP_IOPAD(0x0024, PIN_OUTPUT, 7)
-		>;
-	};
-
-	push_button_pins_default: push-button-default-pins {
-		pinctrl-single,pins = <
-			/* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
-			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT,  7)
-		>;
-	};
-
-	arduino_uart_pins_default: arduino-uart-default-pins {
-		pinctrl-single,pins = <
-			/* (P4) MCU_UART0_RXD */
-			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT,  4)
-			/* (P5) MCU_UART0_TXD */
-			AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)
-		>;
-	};
-
-	arduino_io_d2_to_d3_pins_default: arduino-io-d2-to-d3-default-pins {
-		pinctrl-single,pins = <
-			/* (P1) WKUP_GPIO0_31 */
-			AM65X_WKUP_IOPAD(0x004C, PIN_OUTPUT, 7)
-			/* (N3) WKUP_GPIO0_33 */
-			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 7)
-		>;
-	};
-
-	arduino_io_oe_pins_default: arduino-io-oe-default-pins {
-		pinctrl-single,pins = <
-			/* (N4) WKUP_GPIO0_34 */
-			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 7)
-			/* (M2) WKUP_GPIO0_36 */
-			AM65X_WKUP_IOPAD(0x0060, PIN_OUTPUT, 7)
-			/* (M3) WKUP_GPIO0_37 */
-			AM65X_WKUP_IOPAD(0x0064, PIN_OUTPUT, 7)
-			/* (M4) WKUP_GPIO0_38 */
-			AM65X_WKUP_IOPAD(0x0068, PIN_OUTPUT, 7)
-			/* (M1) WKUP_GPIO0_41 */
-			AM65X_WKUP_IOPAD(0x0074, PIN_OUTPUT, 7)
-		>;
-	};
-
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
-		pinctrl-single,pins = <
-			/* (V1) MCU_OSPI0_CLK */
-			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0)
-			/* (U2) MCU_OSPI0_DQS */
-			AM65X_WKUP_IOPAD(0x0008, PIN_INPUT,  0)
-			/* (U4) MCU_OSPI0_D0 */
-			AM65X_WKUP_IOPAD(0x000c, PIN_INPUT,  0)
-			/* (U5) MCU_OSPI0_D1 */
-			AM65X_WKUP_IOPAD(0x0010, PIN_INPUT,  0)
-			/* (R4) MCU_OSPI0_CSn0 */
-			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0)
-		>;
-	};
-
-	db9_com_mode_pins_default: db9-com-mode-default-pins {
-		pinctrl-single,pins = <
-			/* (AD3) WKUP_GPIO0_5, used as uart0 mode 0 */
-			AM65X_WKUP_IOPAD(0x00c4, PIN_OUTPUT, 7)
-			/* (AC3) WKUP_GPIO0_4, used as uart0 mode 1 */
-			AM65X_WKUP_IOPAD(0x00c0, PIN_OUTPUT, 7)
-			/* (AC1) WKUP_GPIO0_7, used as uart0 term */
-			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 7)
-			/* (AC2) WKUP_GPIO0_6, used as uart0 en */
-			AM65X_WKUP_IOPAD(0x00c8, PIN_OUTPUT, 7)
-		>;
-	};
-
-	leds_pins_default: leds-default-pins {
-		pinctrl-single,pins = <
-			/* (T2) WKUP_GPIO0_17, used as user led1 red */
-			AM65X_WKUP_IOPAD(0x0014, PIN_OUTPUT, 7)
-			/* (R3) WKUP_GPIO0_22, used as user led1 green */
-			AM65X_WKUP_IOPAD(0x0028, PIN_OUTPUT, 7)
-			/* (R5) WKUP_GPIO0_24, used as status led red */
-			AM65X_WKUP_IOPAD(0x0030, PIN_OUTPUT, 7)
-			/* (N2) WKUP_GPIO0_32, used as status led green */
-			AM65X_WKUP_IOPAD(0x0050, PIN_OUTPUT, 7)
-		>;
-	};
-
-	mcu_spi0_pins_default: mcu-spi0-default-pins {
-		pinctrl-single,pins = <
-			/* (Y1) MCU_SPI0_CLK */
-			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT,  0)
-			/* (Y3) MCU_SPI0_D0 */
-			AM65X_WKUP_IOPAD(0x0094, PIN_INPUT,  0)
-			/* (Y2) MCU_SPI0_D1 */
-			AM65X_WKUP_IOPAD(0x0098, PIN_INPUT,  0)
-			/* (Y4) MCU_SPI0_CS0 */
-			AM65X_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0)
-		>;
-	};
-
-	minipcie_pins_default: minipcie-default-pins {
-		pinctrl-single,pins = <
-			/* (P2) MCU_OSPI1_DQS.WKUP_GPIO0_27 */
-			AM65X_WKUP_IOPAD(0x003C, PIN_OUTPUT, 7)
-		>;
-	};
-};
-
-&main_pmx0 {
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0174, PIN_INPUT,  6)  /* (AE23) UART1_RXD */
-			AM65X_IOPAD(0x014c, PIN_OUTPUT, 6)  /* (AD23) UART1_TXD */
-			AM65X_IOPAD(0x0178, PIN_INPUT,  6)  /* (AD22) UART1_CTSn */
-			AM65X_IOPAD(0x017c, PIN_OUTPUT, 6)  /* (AC21) UART1_RTSn */
-		>;
-	};
-
-	main_i2c3_pins_default: main-i2c3-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01c0, PIN_INPUT,  2)  /* (AF13) I2C3_SCL */
-			AM65X_IOPAD(0x01d4, PIN_INPUT,  2)  /* (AG12) I2C3_SDA */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)  /* (C27) MMC1_CLK */
-			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP,   0)  /* (C28) MMC1_CMD */
-			AM65X_IOPAD(0x02d0, PIN_INPUT_PULLUP,   0)  /* (D28) MMC1_DAT0 */
-			AM65X_IOPAD(0x02cc, PIN_INPUT_PULLUP,   0)  /* (E27) MMC1_DAT1 */
-			AM65X_IOPAD(0x02c8, PIN_INPUT_PULLUP,   0)  /* (D26) MMC1_DAT2 */
-			AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP,   0)  /* (D27) MMC1_DAT3 */
-			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP,   0)  /* (B24) MMC1_SDCD */
-			AM65X_IOPAD(0x02e0, PIN_INPUT_PULLUP,   0)  /* (C24) MMC1_SDWP */
-		>;
-	};
-
-	usb0_pins_default: usb0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0)  /* (AD9) USB0_DRVVBUS */
-		>;
-	};
-
-	usb1_pins_default: usb1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0)  /* (AC8) USB1_DRVVBUS */
-		>;
-	};
-
-	arduino_io_d4_to_d9_pins_default: arduino-io-d4-to-d9-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0084, PIN_OUTPUT, 7)  /* (AG18) GPIO0_33 */
-			AM65X_IOPAD(0x008C, PIN_OUTPUT, 7)  /* (AF17) GPIO0_35 */
-			AM65X_IOPAD(0x0098, PIN_OUTPUT, 7)  /* (AH16) GPIO0_38 */
-			AM65X_IOPAD(0x00AC, PIN_OUTPUT, 7)  /* (AH15) GPIO0_43 */
-			AM65X_IOPAD(0x00C0, PIN_OUTPUT, 7)  /* (AG15) GPIO0_48 */
-			AM65X_IOPAD(0x00CC, PIN_OUTPUT, 7)  /* (AD15) GPIO0_51 */
-		>;
-	};
-
-	dss_vout1_pins_default: dss-vout1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0000, PIN_OUTPUT, 1)  /* VOUT1_DATA0 */
-			AM65X_IOPAD(0x0004, PIN_OUTPUT, 1)  /* VOUT1_DATA1 */
-			AM65X_IOPAD(0x0008, PIN_OUTPUT, 1)  /* VOUT1_DATA2 */
-			AM65X_IOPAD(0x000c, PIN_OUTPUT, 1)  /* VOUT1_DATA3 */
-			AM65X_IOPAD(0x0010, PIN_OUTPUT, 1)  /* VOUT1_DATA4 */
-			AM65X_IOPAD(0x0014, PIN_OUTPUT, 1)  /* VOUT1_DATA5 */
-			AM65X_IOPAD(0x0018, PIN_OUTPUT, 1)  /* VOUT1_DATA6 */
-			AM65X_IOPAD(0x001c, PIN_OUTPUT, 1)  /* VOUT1_DATA7 */
-			AM65X_IOPAD(0x0020, PIN_OUTPUT, 1)  /* VOUT1_DATA8 */
-			AM65X_IOPAD(0x0024, PIN_OUTPUT, 1)  /* VOUT1_DATA9 */
-			AM65X_IOPAD(0x0028, PIN_OUTPUT, 1)  /* VOUT1_DATA10 */
-			AM65X_IOPAD(0x002c, PIN_OUTPUT, 1)  /* VOUT1_DATA11 */
-			AM65X_IOPAD(0x0030, PIN_OUTPUT, 1)  /* VOUT1_DATA12 */
-			AM65X_IOPAD(0x0034, PIN_OUTPUT, 1)  /* VOUT1_DATA13 */
-			AM65X_IOPAD(0x0038, PIN_OUTPUT, 1)  /* VOUT1_DATA14 */
-			AM65X_IOPAD(0x003c, PIN_OUTPUT, 1)  /* VOUT1_DATA15 */
-			AM65X_IOPAD(0x0040, PIN_OUTPUT, 1)  /* VOUT1_DATA16 */
-			AM65X_IOPAD(0x0044, PIN_OUTPUT, 1)  /* VOUT1_DATA17 */
-			AM65X_IOPAD(0x0048, PIN_OUTPUT, 1)  /* VOUT1_DATA18 */
-			AM65X_IOPAD(0x004c, PIN_OUTPUT, 1)  /* VOUT1_DATA19 */
-			AM65X_IOPAD(0x0050, PIN_OUTPUT, 1)  /* VOUT1_DATA20 */
-			AM65X_IOPAD(0x0054, PIN_OUTPUT, 1)  /* VOUT1_DATA21 */
-			AM65X_IOPAD(0x0058, PIN_OUTPUT, 1)  /* VOUT1_DATA22 */
-			AM65X_IOPAD(0x005c, PIN_OUTPUT, 1)  /* VOUT1_DATA23 */
-			AM65X_IOPAD(0x0060, PIN_OUTPUT, 1)  /* VOUT1_VSYNC */
-			AM65X_IOPAD(0x0064, PIN_OUTPUT, 1)  /* VOUT1_HSYNC */
-			AM65X_IOPAD(0x0068, PIN_OUTPUT, 1)  /* VOUT1_PCLK */
-			AM65X_IOPAD(0x006c, PIN_OUTPUT, 1)  /* VOUT1_DE */
-		>;
-	};
-
-	dp_pins_default: dp-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0078, PIN_OUTPUT, 7)  /* (AF18) DP rst_n */
-		>;
-	};
-
-	main_i2c2_pins_default: main-i2c2-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0074, PIN_INPUT,  5)  /* (T27) I2C2_SCL */
-			AM65X_IOPAD(0x0070, PIN_INPUT,  5)  /* (R25) I2C2_SDA */
-		>;
-	};
-};
-
-&main_pmx1 {
-	main_i2c0_pins_default: main-i2c0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0000, PIN_INPUT,  0)  /* (D20) I2C0_SCL */
-			AM65X_IOPAD(0x0004, PIN_INPUT,  0)  /* (C21) I2C0_SDA */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0008, PIN_INPUT,  0)  /* (B21) I2C1_SCL */
-			AM65X_IOPAD(0x000c, PIN_INPUT,  0)  /* (E21) I2C1_SDA */
-		>;
-	};
-
-	ecap0_pins_default: ecap0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0010, PIN_INPUT,  0)  /* (D21) ECAP0_IN_APWM_OUT */
-		>;
-	};
-};
-
-&wkup_uart0 {
-	/* Wakeup UART is used by System firmware */
-	status = "reserved";
-};
-
-&main_uart1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-};
-
-&mcu_uart0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&arduino_uart_pins_default>;
-};
-
-&main_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&arduino_io_d4_to_d9_pins_default>;
-	gpio-line-names =
-		"main_gpio0-base", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "", "", "",
-		"", "", "", "IO4", "", "IO5", "", "", "IO6", "",
-		"", "", "", "IO7", "", "", "", "", "IO8", "",
-		"", "IO9";
-};
-
-&wkup_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 =
-		<&arduino_io_d2_to_d3_pins_default>,
-		<&arduino_i2c_aio_switch_pins_default>,
-		<&arduino_io_oe_pins_default>,
-		<&push_button_pins_default>,
-		<&db9_com_mode_pins_default>;
-	gpio-line-names =
-		/* 0..9 */
-		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
-		"UART0-enable", "UART0-terminate", "", "WIFI-disable",
-		/* 10..19 */
-		"", "", "", "", "", "", "", "", "", "",
-		/* 20..29 */
-		"", "A4A5-I2C-mux", "", "", "", "USER-button", "", "", "","IO0",
-		/* 30..39 */
-		"IO1", "IO2", "", "IO3", "IO17-direction", "A5",
-		"IO16-direction", "IO15-direction", "IO14-direction", "A3",
-		/* 40..49 */
-		"", "IO18-direction", "A4", "A2", "A1", "A0", "", "", "IO13",
-		"IO11",
-		/* 50..51 */
-		"IO12", "IO10";
-};
-
-&wkup_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default>;
-	clock-frequency = <400000>;
-};
-
-&mcu_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	psu: regulator@60 {
-		compatible = "ti,tps62363";
-		reg = <0x60>;
-		regulator-name = "tps62363-vout";
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-boot-on;
-		ti,vsel0-state-high;
-		ti,vsel1-state-high;
-		ti,enable-vout-discharge;
-	};
-
-	/* D4200 */
-	pcal9535_1: gpio@20 {
-		compatible = "nxp,pcal9535";
-		reg = <0x20>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"A0-pull", "A1-pull", "A2-pull", "A3-pull", "A4-pull",
-			"A5-pull", "", "",
-			"IO14-enable", "IO15-enable", "IO16-enable",
-			"IO17-enable", "IO18-enable", "IO19-enable";
-	};
-
-	/* D4201 */
-	pcal9535_2: gpio@21 {
-		compatible = "nxp,pcal9535";
-		reg = <0x21>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"IO0-direction", "IO1-direction", "IO2-direction",
-			"IO3-direction", "IO4-direction", "IO5-direction",
-			"IO6-direction", "IO7-direction",
-			"IO8-direction", "IO9-direction", "IO10-direction",
-			"IO11-direction", "IO12-direction", "IO13-direction",
-			"IO19-direction";
-	};
-
-	/* D4202 */
-	pcal9535_3: gpio@25 {
-		compatible = "nxp,pcal9535";
-		reg = <0x25>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-line-names =
-			"IO0-pull", "IO1-pull", "IO2-pull", "IO3-pull",
-			"IO4-pull", "IO5-pull", "IO6-pull", "IO7-pull",
-			"IO8-pull", "IO9-pull", "IO10-pull", "IO11-pull",
-			"IO12-pull", "IO13-pull";
-	};
-};
-
-&main_i2c0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	rtc: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-
-	eeprom: eeprom@54 {
-		compatible = "atmel,24c08";
-		reg = <0x54>;
-		pagesize = <16>;
-	};
-};
-
-&main_i2c1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
-};
-
-&main_i2c2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c2_pins_default>;
-	clock-frequency = <400000>;
-};
-
-&main_i2c3 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c3_pins_default>;
-	clock-frequency = <400000>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	edp-bridge@f {
-		compatible = "toshiba,tc358767";
-		reg = <0x0f>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&dp_pins_default>;
-		reset-gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
-
-		clock-names = "ref";
-		clocks = <&dp_refclk>;
-
-		toshiba,hpd-pin = <0>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@1 {
-				reg = <1>;
-
-				bridge_in: endpoint {
-					remote-endpoint = <&dpi_out>;
-				};
-			};
-		};
-	};
-};
-
-&mcu_cpsw {
-	status = "disabled";
-};
-
-&ecap0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&ecap0_pins_default>;
-};
-
-&sdhci1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-};
-
-&usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_pins_default>;
-	dr_mode = "host";
-};
-
-&usb1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_pins_default>;
-	dr_mode = "host";
-};
-
-&mcu_spi0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_spi0_pins_default>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	ti,pindir-d0-out-d1-in;
-};
-
-&tscadc1 {
-	status = "okay";
-	adc {
-		ti,adc-channels = <0 1 2 3 4 5>;
-	};
-};
-
-&ospi0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <1>;
-		spi-max-frequency = <50000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <2>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			seboot@0 {
-				label = "seboot";
-				reg = <0x0 0x180000>; /* 1.5M */
-			};
-
-			tispl@180000 {
-				label = "tispl";
-				reg = <0x180000 0x200000>; /* 2M */
-			};
-
-			u-boot@380000 {
-				label = "u-boot";
-				reg = <0x380000 0x300000>; /* 3M */
-			};
-
-			env@680000 {
-				label = "env";
-				reg = <0x680000 0x20000>; /* 128K */
-			};
-
-			env-backup@6a0000 {
-				label = "env.backup";
-				reg = <0x6a0000 0x20000>; /* 128K */
-			};
-
-			otpcmd@6c0000 {
-				label = "otpcmd";
-				reg = <0x6c0000 0x10000>; /* 64K */
-			};
-
-			unused@6d0000 {
-				label = "unused";
-				reg = <0x6d0000 0x7b0000>; /* 7872K */
-			};
-
-			seboot-backup@e80000 {
-				label = "seboot.backup";
-				reg = <0xe80000 0x180000>; /* 1.5M */
-			};
-		};
-	};
-};
-
-&dss {
-	pinctrl-names = "default";
-	pinctrl-0 = <&dss_vout1_pins_default>;
-
-	assigned-clocks = <&k3_clks 67 2>;
-	assigned-clock-parents = <&k3_clks 67 5>;
-};
-
-&dss_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	port@1 {
-		reg = <1>;
-
-		dpi_out: endpoint {
-			remote-endpoint = <&bridge_in>;
-		};
-	};
-};
-
-&pcie1_rc {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&minipcie_pins_default>;
-
-	num-lanes = <1>;
-	phys = <&serdes1 PHY_TYPE_PCIE 0>;
-	phy-names = "pcie-phy0";
-	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
-};
-
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mcu_r5fss0_core0 {
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
-};
-
-&mcu_r5fss0_core1 {
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
-};
-
-&mcu_rti1 {
-	memory-region = <&wdt_reset_memory_region>;
-};
diff --git a/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi b/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
deleted file mode 100644
index 5ab434c02ab..00000000000
--- a/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * Common bits of the IOT2050 Basic variant, PG1 and PG2
- */
-
-#include "k3-am65-iot2050-common.dtsi"
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		/* 1G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
-	};
-
-	cpus {
-		cpu-map {
-			/delete-node/ cluster1;
-		};
-		/delete-node/ cpu@100;
-		/delete-node/ cpu@101;
-	};
-
-	/delete-node/ l2-cache1;
-};
-
-/* eMMC */
-&sdhci0 {
-	status = "disabled";
-};
-
-&main_pmx0 {
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
-			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
-			AM65X_IOPAD(0x01ec, PIN_INPUT,  0)  /* (AG11) UART0_CTSn */
-			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)  /* (AD11) UART0_RTSn */
-			AM65X_IOPAD(0x0188, PIN_INPUT,  1)  /* (D25) UART0_DCDn */
-			AM65X_IOPAD(0x018c, PIN_INPUT,  1)  /* (B26) UART0_DSRn */
-			AM65X_IOPAD(0x0190, PIN_OUTPUT, 1)  /* (A24) UART0_DTRn */
-			AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
-		>;
-	};
-};
-
-&main_uart0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-};
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on Basic boards */
-	ti,cluster-mode = <0>;
-};
diff --git a/arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts b/arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts
deleted file mode 100644
index c62549a4b43..00000000000
--- a/arch/arm/dts/k3-am6528-iot2050-basic-pg2.dts
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 2
- * 1 GB RAM, no eMMC, main_uart0 on connector X30
- *
- * Product homepage:
- * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
- */
-
-/dts-v1/;
-
-#include "k3-am6528-iot2050-basic-common.dtsi"
-#include "k3-am65-iot2050-common-pg2.dtsi"
-
-/ {
-	compatible = "siemens,iot2050-basic-pg2", "ti,am654";
-	model = "SIMATIC IOT2050 Basic PG2";
-};
diff --git a/arch/arm/dts/k3-am6528-iot2050-basic.dts b/arch/arm/dts/k3-am6528-iot2050-basic.dts
deleted file mode 100644
index 87928ff2821..00000000000
--- a/arch/arm/dts/k3-am6528-iot2050-basic.dts
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * AM6528-based (dual-core) IOT2050 Basic variant, Product Generation 1
- * 1 GB RAM, no eMMC, main_uart0 on connector X30
- *
- * Product homepage:
- * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
- */
-
-/dts-v1/;
-
-#include "k3-am6528-iot2050-basic-common.dtsi"
-#include "k3-am65-iot2050-common-pg1.dtsi"
-
-/ {
-	compatible = "siemens,iot2050-basic", "ti,am654";
-	model = "SIMATIC IOT2050 Basic";
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
deleted file mode 100644
index be55494b1f3..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * Common bits of the IOT2050 Advanced variant, PG1 and PG2
- */
-
-/dts-v1/;
-
-#include "k3-am65-iot2050-common.dtsi"
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-};
-
-&main_pmx0 {
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)  /* (B25) MMC0_CLK */
-			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP,   0)  /* (B27) MMC0_CMD */
-			AM65X_IOPAD(0x01a4, PIN_INPUT_PULLUP,   0)  /* (A26) MMC0_DAT0 */
-			AM65X_IOPAD(0x01a0, PIN_INPUT_PULLUP,   0)  /* (E25) MMC0_DAT1 */
-			AM65X_IOPAD(0x019c, PIN_INPUT_PULLUP,   0)  /* (C26) MMC0_DAT2 */
-			AM65X_IOPAD(0x0198, PIN_INPUT_PULLUP,   0)  /* (A25) MMC0_DAT3 */
-			AM65X_IOPAD(0x0194, PIN_INPUT_PULLUP,   0)  /* (E24) MMC0_DAT4 */
-			AM65X_IOPAD(0x0190, PIN_INPUT_PULLUP,   0)  /* (A24) MMC0_DAT5 */
-			AM65X_IOPAD(0x018c, PIN_INPUT_PULLUP,   0)  /* (B26) MMC0_DAT6 */
-			AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP,   0)  /* (D25) MMC0_DAT7 */
-			AM65X_IOPAD(0x01b8, PIN_OUTPUT_PULLUP,  7)  /* (B23) MMC0_SDWP */
-			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP,   0)  /* (A23) MMC0_SDCD */
-			AM65X_IOPAD(0x01b0, PIN_INPUT,          0)  /* (C25) MMC0_DS */
-		>;
-	};
-};
-
-/* eMMC */
-&sdhci0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	bus-width = <8>;
-	non-removable;
-	ti,driver-strength-ohm = <50>;
-	disable-wp;
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
deleted file mode 100644
index c9e736098f9..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * IOT2050 M.2 variant, overlay for B-key PCIE0_LANE0 + E-key PCIE1_LANE0
- * Copyright (c) Siemens AG, 2022
- *
- * Authors:
- *   Chao Zeng <chao.zeng@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- */
-
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/gpio/gpio.h>
-
-&pcie0_rc {
-	num-lanes = <1>;
-	phys = <&serdes0 PHY_TYPE_PCIE 1>;
-	phy-names = "pcie-phy0";
-	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&pcie1_rc {
-	status = "okay";
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
deleted file mode 100644
index 72fc011bd54..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * IOT2050 M.2 variant, overlay for B-key USB3.0 + E-key PCIE1_LANE0
- * Copyright (c) Siemens AG, 2022
- *
- * Authors:
- *   Chao Zeng <chao.zeng@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- */
-
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/gpio/gpio.h>
-
-&serdes0 {
-	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
-};
-
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie1_rc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&minipcie_pins_default>;
-
-	num-lanes = <1>;
-	phys = <&serdes1 PHY_TYPE_PCIE 0>;
-	phy-names = "pcie-phy0";
-	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&dwc3_0 {
-	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
-				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
-	phys = <&serdes0 PHY_TYPE_USB3 0>;
-	phy-names = "usb3-phy";
-};
-
-&usb0 {
-	maximum-speed = "super-speed";
-	snps,dis-u1-entry-quirk;
-	snps,dis-u2-entry-quirk;
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
deleted file mode 100644
index 774eb14ac90..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
+++ /dev/null
@@ -1,119 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2023
- *
- * Authors:
- *   Chao Zeng <chao.zeng@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * AM6548-based (quad-core) IOT2050 M.2 variant (based on Advanced Product
- * Generation 2), 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
- *
- * Product homepage:
- * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
- */
-
-#include "k3-am6548-iot2050-advanced-common.dtsi"
-#include "k3-am65-iot2050-common-pg2.dtsi"
-
-/ {
-	compatible = "siemens,iot2050-advanced-m2", "ti,am654";
-	model = "SIMATIC IOT2050 Advanced M2";
-};
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
-};
-
-&main_pmx0 {
-	main_m2_enable_pins_default: main-m2-enable-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01c4, PIN_INPUT_PULLUP, 7)  /* (AH13) GPIO1_17 */
-		>;
-	};
-
-	main_bkey_pcie_reset: main-bkey-pcie-reset-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01bc, PIN_OUTPUT_PULLUP, 7)  /* (AG13) GPIO1_15 */
-		>;
-	};
-
-	main_pmx0_m2_config_pins_default: main-pmx0-m2-config-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x01c8, PIN_INPUT_PULLUP, 7)  /* (AE13) GPIO1_18 */
-			AM65X_IOPAD(0x01cc, PIN_INPUT_PULLUP, 7)  /* (AD13) GPIO1_19 */
-		>;
-	};
-
-	main_m2_pcie_mux_control: main-m2-pcie-mux-control-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0148, PIN_INPUT_PULLUP, 7)  /* (AG22) GPIO0_82 */
-			AM65X_IOPAD(0x0160, PIN_INPUT_PULLUP, 7)  /* (AE20) GPIO0_88 */
-			AM65X_IOPAD(0x0164, PIN_INPUT_PULLUP, 7)  /* (AF19) GPIO0_89 */
-		>;
-	};
-};
-
-&main_pmx1 {
-	main_pmx1_m2_config_pins_default: main-pmx1-m2-config-default-pins {
-		pinctrl-single,pins = <
-			AM65X_IOPAD(0x0018, PIN_INPUT_PULLUP, 7)  /* (B22) GPIO1_88 */
-			AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
-		>;
-	};
-};
-
-&main_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 =
-		<&main_m2_pcie_mux_control>,
-		<&arduino_io_d4_to_d9_pins_default>;
-};
-
-&main_gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 =
-		<&main_m2_enable_pins_default>,
-		<&main_pmx0_m2_config_pins_default>,
-		<&main_pmx1_m2_config_pins_default>,
-		<&cp2102n_reset_pin_default>;
-};
-
-/*
- * Base configuration for B-key slot with PCIe x2, E-key with USB 2.0 only.
- * Firmware switches to other modes via device tree overlays.
- */
-
-&serdes0 {
-	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
-	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
-};
-
-&pcie0_rc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_bkey_pcie_reset>;
-
-	num-lanes = <2>;
-	phys = <&serdes0 PHY_TYPE_PCIE 1>, <&serdes1 PHY_TYPE_PCIE 1>;
-	phy-names = "pcie-phy0","pcie-phy1";
-	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&pcie1_rc {
-	status = "disabled";
-};
-
-&dwc3_0 {
-	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
-				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
-	/delete-property/ phys;
-	/delete-property/ phy-names;
-};
-
-&usb0 {
-	maximum-speed = "high-speed";
-	/delete-property/ snps,dis-u1-entry-quirk;
-	/delete-property/ snps,dis-u2-entry-quirk;
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-pg2.dts
deleted file mode 100644
index f00dc86d01b..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-pg2.dts
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 2
- * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
- *
- * Product homepage:
- * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
- */
-
-/dts-v1/;
-
-#include "k3-am6548-iot2050-advanced-common.dtsi"
-#include "k3-am65-iot2050-common-pg2.dtsi"
-
-/ {
-	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";
-	model = "SIMATIC IOT2050 Advanced PG2";
-};
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced.dts b/arch/arm/dts/k3-am6548-iot2050-advanced.dts
deleted file mode 100644
index 077f165bdc6..00000000000
--- a/arch/arm/dts/k3-am6548-iot2050-advanced.dts
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Le Jin <le.jin@siemens.com>
- *   Jan Kiszka <jan.kiszka@siemens.com>
- *
- * AM6548-based (quad-core) IOT2050 Advanced variant, Product Generation 1
- * 2 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
- *
- * Product homepage:
- * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
- */
-
-/dts-v1/;
-
-#include "k3-am6548-iot2050-advanced-common.dtsi"
-#include "k3-am65-iot2050-common-pg1.dtsi"
-
-/ {
-	compatible = "siemens,iot2050-advanced", "ti,am654";
-	model = "SIMATIC IOT2050 Advanced";
-};
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index fad6bc04735..9d4c9cf1b31 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -395,8 +395,8 @@ int board_fit_config_name_match(const char *name)
 	struct iot2050_info *info = IOT2050_INFO_DATA;
 	char upper_name[32];
 
-	/* skip the prefix "k3-am65x8-" */
-	name += 10;
+	/* skip the prefix "ti/k3-am65x8-" */
+	name += 13;
 
 	if (info->magic != IOT2050_INFO_MAGIC ||
 	    strlen(name) >= sizeof(upper_name))
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 22990ba1f96..78db6d21099 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -17,7 +17,7 @@ CONFIG_ENV_OFFSET=0x680000
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="k3-am6528-iot2050-basic"
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am6528-iot2050-basic"
 CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
@@ -79,7 +79,11 @@ CONFIG_CMD_TIME=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/k3-am6528-iot2050-basic ti/k3-am6528-iot2050-basic-pg2 ti/k3-am6548-iot2050-advanced ti/k3-am6548-iot2050-advanced-pg2 ti/k3-am6548-iot2050-advanced-m2"
+CONFIG_OF_OVERLAY_LIST="ti/k3-am6548-iot2050-advanced-m2-bkey-usb3 ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie"
 CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_OF_LIST="ti/k3-am6528-iot2050-basic"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.43.0

