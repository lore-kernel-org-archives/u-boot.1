Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73AFC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 16:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98283806DC;
	Sun, 19 Jan 2025 17:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA297806C9; Sun, 19 Jan 2025 17:43:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 329FD80141
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 17:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1647F1063;
 Sun, 19 Jan 2025 08:44:03 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF5E3F66E;
 Sun, 19 Jan 2025 08:43:33 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
Date: Sun, 19 Jan 2025 16:41:54 +0000
Message-ID: <20250119164157.23648-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250119164157.23648-1-andre.przywara@arm.com>
References: <20250119164157.23648-1-andre.przywara@arm.com>
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

In contrast to some other Allwinner SoCs, there is no difference between
the DTs for the Allwinner F1C100/F1C200 SoCs (sunvi) between the U-Boot
and the Linux kernel repository.

Remove the old copies of the F1Cx00 related .dts and .dtsi files, and
switch the whole suniv SoC over to use OF_UPSTREAM.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile                        |   2 -
 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts |  73 ----
 arch/arm/dts/suniv-f1c100s.dtsi              | 330 -------------------
 arch/arm/dts/suniv-f1c200s-lctech-pi.dts     |  76 -----
 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts |  81 -----
 arch/arm/mach-sunxi/Kconfig                  |   1 +
 configs/lctech_pi_f1c200s_defconfig          |   2 +-
 configs/licheepi_nano_defconfig              |   2 +-
 8 files changed, 3 insertions(+), 564 deletions(-)
 delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
 delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
 delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
 delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aef0425c967..5627daa94db 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -530,8 +530,6 @@ dtb-$(CONFIG_STM32H7) += stm32h743i-disco.dtb \
 	stm32h743i-eval.dtb \
 	stm32h750i-art-pi.dtb
 
-dtb-$(CONFIG_MACH_SUNIV) += \
-	suniv-f1c100s-licheepi-nano.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
deleted file mode 100644
index 43896723a99..00000000000
--- a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
- */
-
-/dts-v1/;
-#include "suniv-f1c100s.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Lichee Pi Nano";
-	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
-
-	aliases {
-		mmc0 = &mmc0;
-		serial0 = &uart0;
-		spi0 = &spi0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	disable-wp;
-	status = "okay";
-	vmmc-supply = <&reg_vcc3v3>;
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pc_pins>;
-	status = "okay";
-
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "winbond,w25q128", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pe_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 4 2 GPIO_ACTIVE_HIGH>; /* PE2 */
-	status = "okay";
-};
diff --git a/arch/arm/dts/suniv-f1c100s.dtsi b/arch/arm/dts/suniv-f1c100s.dtsi
deleted file mode 100644
index 3c61d59ab5f..00000000000
--- a/arch/arm/dts/suniv-f1c100s.dtsi
+++ /dev/null
@@ -1,330 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
- * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
- */
-
-#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
-#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&intc>;
-
-	clocks {
-		osc24M: clk-24M {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			clock-output-names = "osc24M";
-		};
-
-		osc32k: clk-32k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
-		};
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			compatible = "arm,arm926ej-s";
-			device_type = "cpu";
-			reg = <0x0>;
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		sram-controller@1c00000 {
-			compatible = "allwinner,suniv-f1c100s-system-control",
-				     "allwinner,sun4i-a10-system-control";
-			reg = <0x01c00000 0x30>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			sram_d: sram@10000 {
-				compatible = "mmio-sram";
-				reg = <0x00010000 0x1000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x00010000 0x1000>;
-
-				otg_sram: sram-section@0 {
-					compatible = "allwinner,suniv-f1c100s-sram-d",
-						     "allwinner,sun4i-a10-sram-d";
-					reg = <0x0000 0x1000>;
-					status = "disabled";
-				};
-			};
-		};
-
-		spi0: spi@1c05000 {
-			compatible = "allwinner,suniv-f1c100s-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c05000 0x1000>;
-			interrupts = <10>;
-			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI0>;
-			status = "disabled";
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi1: spi@1c06000 {
-			compatible = "allwinner,suniv-f1c100s-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c06000 0x1000>;
-			interrupts = <11>;
-			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI1>;
-			status = "disabled";
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc0: mmc@1c0f000 {
-			compatible = "allwinner,suniv-f1c100s-mmc",
-				     "allwinner,sun7i-a20-mmc";
-			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC0>,
-				 <&ccu CLK_MMC0>,
-				 <&ccu CLK_MMC0_OUTPUT>,
-				 <&ccu CLK_MMC0_SAMPLE>;
-			clock-names = "ahb", "mmc", "output", "sample";
-			resets = <&ccu RST_BUS_MMC0>;
-			reset-names = "ahb";
-			interrupts = <23>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc1: mmc@1c10000 {
-			compatible = "allwinner,suniv-f1c100s-mmc",
-				     "allwinner,sun7i-a20-mmc";
-			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC1>,
-				 <&ccu CLK_MMC1>,
-				 <&ccu CLK_MMC1_OUTPUT>,
-				 <&ccu CLK_MMC1_SAMPLE>;
-			clock-names = "ahb", "mmc", "output", "sample";
-			resets = <&ccu RST_BUS_MMC1>;
-			reset-names = "ahb";
-			interrupts = <24>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		usb_otg: usb@1c13000 {
-			compatible = "allwinner,suniv-f1c100s-musb";
-			reg = <0x01c13000 0x0400>;
-			clocks = <&ccu CLK_BUS_OTG>;
-			resets = <&ccu RST_BUS_OTG>;
-			interrupts = <26>;
-			interrupt-names = "mc";
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			extcon = <&usbphy 0>;
-			allwinner,sram = <&otg_sram 1>;
-			status = "disabled";
-		};
-
-		usbphy: phy@1c13400 {
-			compatible = "allwinner,suniv-f1c100s-usb-phy";
-			reg = <0x01c13400 0x10>;
-			reg-names = "phy_ctrl";
-			clocks = <&ccu CLK_USB_PHY0>;
-			clock-names = "usb0_phy";
-			resets = <&ccu RST_USB_PHY0>;
-			reset-names = "usb0_reset";
-			#phy-cells = <1>;
-			status = "disabled";
-		};
-
-		ccu: clock@1c20000 {
-			compatible = "allwinner,suniv-f1c100s-ccu";
-			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
-			clock-names = "hosc", "losc";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		intc: interrupt-controller@1c20400 {
-			compatible = "allwinner,suniv-f1c100s-ic";
-			reg = <0x01c20400 0x400>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-		};
-
-		pio: pinctrl@1c20800 {
-			compatible = "allwinner,suniv-f1c100s-pinctrl";
-			reg = <0x01c20800 0x400>;
-			interrupts = <38>, <39>, <40>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
-			clock-names = "apb", "hosc", "losc";
-			gpio-controller;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			#gpio-cells = <3>;
-
-			mmc0_pins: mmc0-pins {
-				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
-				function = "mmc0";
-				drive-strength = <30>;
-			};
-
-			/omit-if-no-ref/
-			i2c0_pd_pins: i2c0-pd-pins {
-				pins = "PD0", "PD12";
-				function = "i2c0";
-			};
-
-			spi0_pc_pins: spi0-pc-pins {
-				pins = "PC0", "PC1", "PC2", "PC3";
-				function = "spi0";
-			};
-
-			uart0_pe_pins: uart0-pe-pins {
-				pins = "PE0", "PE1";
-				function = "uart0";
-			};
-
-			/omit-if-no-ref/
-			uart1_pa_pins: uart1-pa-pins {
-				pins = "PA2", "PA3";
-				function = "uart1";
-			};
-		};
-
-		i2c0: i2c@1c27000 {
-			compatible = "allwinner,suniv-f1c100s-i2c",
-				     "allwinner,sun6i-a31-i2c";
-			reg = <0x01c27000 0x400>;
-			interrupts = <7>;
-			clocks = <&ccu CLK_BUS_I2C0>;
-			resets = <&ccu RST_BUS_I2C0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@1c27400 {
-			compatible = "allwinner,suniv-f1c100s-i2c",
-				     "allwinner,sun6i-a31-i2c";
-			reg = <0x01c27400 0x400>;
-			interrupts = <8>;
-			clocks = <&ccu CLK_BUS_I2C1>;
-			resets = <&ccu RST_BUS_I2C1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@1c27800 {
-			compatible = "allwinner,suniv-f1c100s-i2c",
-				     "allwinner,sun6i-a31-i2c";
-			reg = <0x01c27800 0x400>;
-			interrupts = <9>;
-			clocks = <&ccu CLK_BUS_I2C2>;
-			resets = <&ccu RST_BUS_I2C2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		timer@1c20c00 {
-			compatible = "allwinner,suniv-f1c100s-timer";
-			reg = <0x01c20c00 0x90>;
-			interrupts = <13>, <14>, <15>;
-			clocks = <&osc24M>;
-		};
-
-		wdt: watchdog@1c20ca0 {
-			compatible = "allwinner,suniv-f1c100s-wdt",
-				     "allwinner,sun6i-a31-wdt";
-			reg = <0x01c20ca0 0x20>;
-			interrupts = <16>;
-			clocks = <&osc32k>;
-		};
-
-		pwm: pwm@1c21000 {
-			compatible = "allwinner,suniv-f1c100s-pwm",
-				     "allwinner,sun7i-a20-pwm";
-			reg = <0x01c21000 0x400>;
-			clocks = <&osc24M>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		ir: ir@1c22c00 {
-			compatible = "allwinner,suniv-f1c100s-ir",
-				     "allwinner,sun6i-a31-ir";
-			reg = <0x01c22c00 0x400>;
-			clocks = <&ccu CLK_BUS_IR>, <&ccu CLK_IR>;
-			clock-names = "apb", "ir";
-			resets = <&ccu RST_BUS_IR>;
-			interrupts = <6>;
-			status = "disabled";
-		};
-
-		lradc: lradc@1c23400 {
-			compatible = "allwinner,suniv-f1c100s-lradc",
-				     "allwinner,sun8i-a83t-r-lradc";
-			reg = <0x01c23400 0x400>;
-			interrupts = <22>;
-			status = "disabled";
-		};
-
-		uart0: serial@1c25000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c25000 0x400>;
-			interrupts = <1>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART0>;
-			resets = <&ccu RST_BUS_UART0>;
-			status = "disabled";
-		};
-
-		uart1: serial@1c25400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c25400 0x400>;
-			interrupts = <2>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART1>;
-			resets = <&ccu RST_BUS_UART1>;
-			status = "disabled";
-		};
-
-		uart2: serial@1c25800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c25800 0x400>;
-			interrupts = <3>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART2>;
-			resets = <&ccu RST_BUS_UART2>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts b/arch/arm/dts/suniv-f1c200s-lctech-pi.dts
deleted file mode 100644
index 2d2a3f026df..00000000000
--- a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Arm Ltd,
- * based on work:
- *   Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
- */
-
-/dts-v1/;
-#include "suniv-f1c100s.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Lctech Pi F1C200s";
-	compatible = "lctech,pi-f1c200s", "allwinner,suniv-f1c200s",
-		     "allwinner,suniv-f1c100s";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reg_vcc3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	disable-wp;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pc_pins>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "spi-nand";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pa_pins>;
-	status = "okay";
-};
-
-/*
- * This is a Type-C socket, but CC1/2 are not connected, and VBUS is connected
- * to Vin, which supplies the board. Host mode works (if the board is powered
- * otherwise), but peripheral is probably the intention.
- */
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts b/arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
deleted file mode 100644
index 184c245041a..00000000000
--- a/arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Icenowy Zheng <uwu@icenowy.me>
- */
-
-/dts-v1/;
-#include "suniv-f1c100s.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-
-/ {
-	model = "Popcorn Computer PopStick v1.1";
-	compatible = "sourceparts,popstick-v1.1", "sourceparts,popstick",
-		     "allwinner,suniv-f1c200s", "allwinner,suniv-f1c100s";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&pio 4 6 GPIO_ACTIVE_HIGH>; /* PE6 */
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	reg_vcc3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&mmc0 {
-	cd-gpios = <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
-	bus-width = <4>;
-	disable-wp;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pc_pins>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "spi-nand";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pe_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 8065161e61e..866b55833c0 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -279,6 +279,7 @@ config MACH_SUNIV
 	select SUPPORT_SPL
 	select SKIP_LOWLEVEL_INIT_ONLY
 	select SPL_SKIP_LOWLEVEL_INIT_ONLY
+	imply OF_UPSTREAM
 
 config MACH_SUN4I
 	bool "sun4i (Allwinner A10)"
diff --git a/configs/lctech_pi_f1c200s_defconfig b/configs/lctech_pi_f1c200s_defconfig
index e1e8d3aaaa3..1588b3b4955 100644
--- a/configs/lctech_pi_f1c200s_defconfig
+++ b/configs/lctech_pi_f1c200s_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="suniv-f1c200s-lctech-pi"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/suniv-f1c200s-lctech-pi"
 CONFIG_SPL=y
 CONFIG_MACH_SUNIV=y
 CONFIG_DRAM_CLK=156
diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_defconfig
index d59affb0d9c..051b1901f20 100644
--- a/configs/licheepi_nano_defconfig
+++ b/configs/licheepi_nano_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="suniv-f1c100s-licheepi-nano"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/suniv-f1c100s-licheepi-nano"
 CONFIG_SPL=y
 CONFIG_MACH_SUNIV=y
 CONFIG_DRAM_CLK=156
-- 
2.46.2

