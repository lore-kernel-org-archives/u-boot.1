Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44D4C001E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C8487206;
	Fri, 20 Oct 2023 02:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98991871E8; Fri, 20 Oct 2023 02:27:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C9C68871CE
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2633C1480;
 Thu, 19 Oct 2023 17:28:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA303F64C;
 Thu, 19 Oct 2023 17:27:20 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ludwig Kormann <ludwig.kormann@ict42.de>
Subject: [PATCH 2/3] sunxi: dts: arm: update devicetree files from
 Linux-v6.6-rc6
Date: Fri, 20 Oct 2023 01:26:07 +0100
Message-Id: <20231020002608.18606-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231020002608.18606-1-andre.przywara@arm.com>
References: <20231020002608.18606-1-andre.przywara@arm.com>
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

Sync the devicetree files from the official Linux kernel tree, v6.6-rc6.
This is covering Allwinner SoCs with 32-bit ARM cores, minus the T113s
board and related .dtsi files, which come separately.

Only small changes: Bluetooth got enabled on the C.H.I.P., and a clock
got renamed. More interesting is the addition of a board, for which
U-Boot enablement patches are pending.

As before, this omits the non-backwards compatible changes to the R_INTC
controller, to remain compatible with older kernels.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/axp209.dtsi                      |   7 +
 arch/arm/dts/sun5i-r8-chip.dts                |   6 +
 arch/arm/dts/sun5i.dtsi                       |  11 +-
 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
 arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++++++++
 arch/arm/dts/sun8i-a23-a33.dtsi               |   2 +-
 arch/arm/dts/sun8i-a83t.dtsi                  |   2 +-
 arch/arm/dts/sun8i-v3s.dtsi                   |   2 +-
 8 files changed, 225 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi

diff --git a/arch/arm/dts/axp209.dtsi b/arch/arm/dts/axp209.dtsi
index ca240cd6f6c..469d0f7d518 100644
--- a/arch/arm/dts/axp209.dtsi
+++ b/arch/arm/dts/axp209.dtsi
@@ -48,6 +48,13 @@
  * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
  */
 
+/ {
+	pmic-temp {
+		compatible = "iio-hwmon";
+		io-channels = <&axp_adc 4>; /* Internal temperature */
+	};
+};
+
 &axp209 {
 	compatible = "x-powers,axp209";
 	interrupt-controller;
diff --git a/arch/arm/dts/sun5i-r8-chip.dts b/arch/arm/dts/sun5i-r8-chip.dts
index fd37bd1f392..4192c23848c 100644
--- a/arch/arm/dts/sun5i-r8-chip.dts
+++ b/arch/arm/dts/sun5i-r8-chip.dts
@@ -255,6 +255,12 @@
 	pinctrl-0 = <&uart3_pg_pins>,
 		    <&uart3_cts_rts_pg_pins>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
+	};
 };
 
 &usb_otg {
diff --git a/arch/arm/dts/sun5i.dtsi b/arch/arm/dts/sun5i.dtsi
index 250d6b87ab4..d7c7b454a11 100644
--- a/arch/arm/dts/sun5i.dtsi
+++ b/arch/arm/dts/sun5i.dtsi
@@ -286,7 +286,7 @@
 			clock-names = "ahb",
 				      "tcon-ch0",
 				      "tcon-ch1";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			status = "disabled";
 
@@ -517,6 +517,15 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			mmc2_4bit_pe_pins: mmc2-4bit-pe-pins {
+				pins = "PE4", "PE5", "PE6", "PE7",
+				       "PE8", "PE9";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_8bit_pins: mmc2-8bit-pins {
 				pins = "PC6", "PC7", "PC8", "PC9",
 				       "PC10", "PC11", "PC12", "PC13",
diff --git a/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
new file mode 100644
index 00000000000..577ead1d02a
--- /dev/null
+++ b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+/dts-v1/;
+
+#include "sun7i-a20-icnova-a20.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "In-Circuit ICnova A20 ADB4006";
+	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
+		     "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
+			default-state = "on";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
new file mode 100644
index 00000000000..46616c6bc89
--- /dev/null
+++ b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&gmac_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
diff --git a/arch/arm/dts/sun8i-a23-a33.dtsi b/arch/arm/dts/sun8i-a23-a33.dtsi
index 84c6d9379a3..a0cac966af3 100644
--- a/arch/arm/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/dts/sun8i-a23-a33.dtsi
@@ -190,7 +190,7 @@
 			clock-names = "ahb",
 				      "tcon-ch0",
 				      "lvds-alt";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_LCD>,
 				 <&ccu RST_BUS_LVDS>;
diff --git a/arch/arm/dts/sun8i-a83t.dtsi b/arch/arm/dts/sun8i-a83t.dtsi
index 9c07660080d..cc40622466a 100644
--- a/arch/arm/dts/sun8i-a83t.dtsi
+++ b/arch/arm/dts/sun8i-a83t.dtsi
@@ -456,7 +456,7 @@
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
 			clock-names = "ahb", "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
diff --git a/arch/arm/dts/sun8i-v3s.dtsi b/arch/arm/dts/sun8i-v3s.dtsi
index b001251644f..3b9a282c274 100644
--- a/arch/arm/dts/sun8i-v3s.dtsi
+++ b/arch/arm/dts/sun8i-v3s.dtsi
@@ -191,7 +191,7 @@
 				 <&ccu CLK_TCON0>;
 			clock-names = "ahb",
 				      "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
+			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
 			resets = <&ccu RST_BUS_TCON0>;
 			reset-names = "lcd";
-- 
2.35.8

