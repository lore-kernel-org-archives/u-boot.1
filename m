Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BB7CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A37836F0;
	Sun, 26 Oct 2025 02:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB1883835; Sun, 26 Oct 2025 02:24:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 942AD8329F
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3671D176A;
 Sat, 25 Oct 2025 18:24:36 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A53E3F59E;
 Sat, 25 Oct 2025 18:24:42 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH 4/4] sunxi: dts: arm: update devicetree files from Linux
 kernel tree
Date: Sun, 26 Oct 2025 01:23:56 +0000
Message-ID: <20251026012357.16773-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20251026012357.16773-1-andre.przywara@arm.com>
References: <20251026012357.16773-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Sync the kernel devicetree source files for the Allwinner SoCs with
32-bit cores that do not use OF_UPSTREAM yet. The files were taken
from a v6.18-rc1 tree.

To maintain ABI compatibility with existing LTS kernels, one change
moving some IP blocks to the r_intc interrupt controller is excluded.
This effectively reverts Linux commits 994e5818392c and 9fdef3c3d8c2.

This commit also adds a new board devicetree for the A33 Vstar board,
plus one DT overlay for the OrangePi Zero interface board.

This update should not impact any existing U-Boot functionality.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/sun7i-a20-bananapi.dts           |  27 +++
 arch/arm/dts/sun8i-a23-a33.dtsi               |  20 ++
 arch/arm/dts/sun8i-a33-vstar-core1.dtsi       |  96 ++++++++
 arch/arm/dts/sun8i-a33-vstar.dts              | 205 ++++++++++++++++++
 arch/arm/dts/sun8i-a83t.dtsi                  |   4 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts  |  14 ++
 arch/arm/dts/sun8i-h3-nanopi-neo-air.dts      |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts |  14 ++
 arch/arm/dts/sun8i-h3.dtsi                    |   2 +-
 .../sun8i-orangepi-zero-interface-board.dtso  |  46 ++++
 arch/arm/dts/sun8i-q8-common.dtsi             |   2 +-
 arch/arm/dts/sun8i-r40.dtsi                   |   4 +-
 12 files changed, 429 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/sun8i-a33-vstar-core1.dtsi
 create mode 100644 arch/arm/dts/sun8i-a33-vstar.dts
 create mode 100644 arch/arm/dts/sun8i-orangepi-zero-interface-board.dtso

diff --git a/arch/arm/dts/sun7i-a20-bananapi.dts b/arch/arm/dts/sun7i-a20-bananapi.dts
index 46ecf9db232..d8b362c9661 100644
--- a/arch/arm/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/dts/sun7i-a20-bananapi.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "LeMaker Banana Pi";
@@ -169,6 +170,32 @@
 &gmac_mdio {
 	phy1: ethernet-phy@1 {
 		reg = <1>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				linux,default-trigger = "netdev";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_AMBER>;
+				function = LED_FUNCTION_LAN;
+				linux,default-trigger = "netdev";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+				function = LED_FUNCTION_LAN;
+				linux,default-trigger = "netdev";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/sun8i-a23-a33.dtsi b/arch/arm/dts/sun8i-a23-a33.dtsi
index 4ebb0a7a78f..cca585c3829 100644
--- a/arch/arm/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/dts/sun8i-a23-a33.dtsi
@@ -433,6 +433,11 @@
 				function = "pwm0";
 			};
 
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
+
 			uart0_pf_pins: uart0-pf-pins {
 				pins = "PF2", "PF4";
 				function = "uart0";
@@ -610,6 +615,21 @@
 			assigned-clock-rates = <384000000>;
 		};
 
+		spi0: spi@1c68000 {
+			compatible = "allwinner,sun8i-a23-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
diff --git a/arch/arm/dts/sun8i-a33-vstar-core1.dtsi b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
new file mode 100644
index 00000000000..ba794b842ec
--- /dev/null
+++ b/arch/arm/dts/sun8i-a33-vstar-core1.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+#include "sun8i-a33.dtsi"
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	drive-strength = <40>;
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic@3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp223.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2350000>;
+	regulator-max-microvolt = <2650000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-avcc";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
diff --git a/arch/arm/dts/sun8i-a33-vstar.dts b/arch/arm/dts/sun8i-a33-vstar.dts
new file mode 100644
index 00000000000..9f5c29b3df4
--- /dev/null
+++ b/arch/arm/dts/sun8i-a33-vstar.dts
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+/dts-v1/;
+#include "sun8i-a33-vstar-core1.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Rervision A33-Vstar";
+	compatible = "rervision,a33-vstar",
+		     "rervision,a33-core1",
+		     "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &r8152;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+	};
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
+&ehci0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub@1 {
+		/* Onboard GL850G hub which needs no extra power sequence */
+		compatible = "usb5e3,608";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		r8152: ethernet@4 {
+			/*
+			 * Onboard Realtek RTL8152 USB Ethernet,
+			 * with no MAC address programmed
+			 */
+			compatible = "usbbda,8152";
+			reg = <4>;
+		};
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button-191 {
+		label = "V+";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <191011>;
+	};
+
+	button-391 {
+		label = "V-";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <391304>;
+	};
+
+	button-600 {
+		label = "BACK";
+		linux,code = <KEY_BACK>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pg_pins>;
+	vmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+/*
+ * Our WiFi chip needs both DLDO1 and DLDO2 to be powered at the same
+ * time, with the two being in sync. Since this is not really
+ * supported right now, just use the two as always on, and we will fix
+ * it later.
+ */
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi0";
+};
+
+&reg_dldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi1";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&sound {
+	/* TODO: on-board microphone */
+
+	simple-audio-card,widgets = "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+		"Left DAC", "DACL",
+		"Right DAC", "DACR",
+		"Headphone Jack", "HP";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+		host-wakeup-gpios = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		shutdown-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun8i-a83t.dtsi b/arch/arm/dts/sun8i-a83t.dtsi
index 90f2c08d051..be01620a2c5 100644
--- a/arch/arm/dts/sun8i-a83t.dtsi
+++ b/arch/arm/dts/sun8i-a83t.dtsi
@@ -1222,7 +1222,7 @@
 			};
 
 			cooling-maps {
-				cpu-hot-limit {
+				map0 {
 					trip = <&cpu0_hot>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -1252,7 +1252,7 @@
 			};
 
 			cooling-maps {
-				cpu-hot-limit {
+				map0 {
 					trip = <&cpu1_hot>;
 					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
diff --git a/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
index 1b001f2ad0e..b23cec5b89e 100644
--- a/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -112,6 +112,20 @@
 	};
 };
 
+/*
+ * Audio input/output is exposed on the 13-pin header and can't be used for
+ * anything else. However, adapter boards may use different audio routing.
+ * - https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
+ * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
+ */
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "disabled";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_vdd_cpux>;
 };
diff --git a/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
index 6d85370e04f..9a2742363cd 100644
--- a/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
@@ -94,7 +94,7 @@
 	non-removable;
 	status = "okay";
 
-	brcmf: bcrmf@1 {
+	brcmf: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
index 7a6444a10e2..97a3565ac7a 100644
--- a/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -99,6 +99,20 @@
 	};
 };
 
+/*
+ * Audio input/output is exposed on the 13-pin header and can't be used for
+ * anything else. However, adapter boards may use different audio routing.
+ * - http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
+ * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
+ */
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "disabled";
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun8i-h3.dtsi b/arch/arm/dts/sun8i-h3.dtsi
index eac2349a238..cfd039840b4 100644
--- a/arch/arm/dts/sun8i-h3.dtsi
+++ b/arch/arm/dts/sun8i-h3.dtsi
@@ -262,7 +262,7 @@
 			};
 
 			cooling-maps {
-				cpu-hot-limit {
+				map0 {
 					trip = <&cpu_hot_trip>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
diff --git a/arch/arm/dts/sun8i-orangepi-zero-interface-board.dtso b/arch/arm/dts/sun8i-orangepi-zero-interface-board.dtso
new file mode 100644
index 00000000000..e137eefee34
--- /dev/null
+++ b/arch/arm/dts/sun8i-orangepi-zero-interface-board.dtso
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
+ *
+ * Devicetree overlay for the Orange Pi Zero Interface board (OP0014).
+ *
+ *   https://orangepi.com/index.php?route=product/product&product_id=871
+ *
+ * This overlay applies to the following base files:
+ *
+ * - arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
+ * - arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
+ */
+
+/dts-v1/;
+/plugin/;
+
+&codec {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_ir_rx_pin>;
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun8i-q8-common.dtsi b/arch/arm/dts/sun8i-q8-common.dtsi
index 272584881bb..a0f787581dd 100644
--- a/arch/arm/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/dts/sun8i-q8-common.dtsi
@@ -82,7 +82,7 @@
 };
 
 &ehci0 {
-	status  = "okay";
+	status = "okay";
 };
 
 &mmc1 {
diff --git a/arch/arm/dts/sun8i-r40.dtsi b/arch/arm/dts/sun8i-r40.dtsi
index a5b1f1e3900..f0ed802a9d0 100644
--- a/arch/arm/dts/sun8i-r40.dtsi
+++ b/arch/arm/dts/sun8i-r40.dtsi
@@ -146,7 +146,7 @@
 			};
 
 			cooling-maps {
-				cpu-hot-limit {
+				map0 {
 					trip = <&cpu_hot_trip>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -705,7 +705,7 @@
 			};
 
 			/omit-if-no-ref/
-			uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins{
+			uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins {
 				pins = "PI16", "PI17";
 				function = "uart2";
 			};
-- 
2.46.4

