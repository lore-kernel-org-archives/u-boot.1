Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59907C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD1598870E;
	Wed, 17 Jul 2024 16:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2A8886DB; Wed, 17 Jul 2024 16:34:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7F43988AA4
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262CC1063;
 Wed, 17 Jul 2024 07:34:46 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3E53F73F;
 Wed, 17 Jul 2024 07:34:19 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: dts: arm/arm64: update devicetree files from
 Linux-v6.10
Date: Wed, 17 Jul 2024 15:34:15 +0100
Message-Id: <20240717143415.343827-1-andre.przywara@arm.com>
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

Sync the devicetree files from the official Linux kernel tree, v6.10.
This is covering Allwinner SoCs with 32-bit and 64-bit ARM cores.

Besides mostly cosmectic changes, this adds cpufreq support to H616
boards, Nothing that U-Boot needs for itself, but helpful to pass on
to kernels. We also get the .dts files for the Tanix TX1 TV box and
three Anbernic handheld gaming devices.

As before, this omits the non-backwards compatible changes to the R_INTC
controller, to remain compatible with older kernels.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/sun50i-a64-bananapi-m64.dts      |   2 +-
 arch/arm/dts/sun50i-a64-nanopi-a64.dts        |   2 +-
 arch/arm/dts/sun50i-a64-olinuxino.dts         |   2 +-
 arch/arm/dts/sun50i-a64-orangepi-win.dts      |   2 +-
 arch/arm/dts/sun50i-a64-pinebook.dts          |   2 +-
 arch/arm/dts/sun50i-a64-pinephone.dtsi        |  16 +-
 arch/arm/dts/sun50i-a64-pinetab.dts           |   2 +-
 arch/arm/dts/sun50i-a64-teres-i.dts           |   2 +-
 arch/arm/dts/sun50i-a64.dtsi                  |  18 +-
 arch/arm/dts/sun50i-h313-tanix-tx1.dts        | 183 ++++++++++
 arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts   |   2 +-
 arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts      |   4 +-
 arch/arm/dts/sun50i-h5-orangepi-prime.dts     |   2 +-
 arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts |   2 +-
 .../arm/dts/sun50i-h5-orangepi-zero-plus2.dts |   2 +-
 arch/arm/dts/sun50i-h6-beelink-gs1.dts        |   2 +-
 arch/arm/dts/sun50i-h6-orangepi-3.dts         |   2 +-
 arch/arm/dts/sun50i-h6-orangepi-lite2.dts     |   2 +-
 arch/arm/dts/sun50i-h6-orangepi.dtsi          |   2 +-
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts   |   6 +-
 arch/arm/dts/sun50i-h6-pine-h64.dts           |   2 +-
 arch/arm/dts/sun50i-h6.dtsi                   |   2 +-
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi |   5 +
 arch/arm/dts/sun50i-h616-cpu-opp.dtsi         | 115 ++++++
 arch/arm/dts/sun50i-h616-orangepi-zero2.dts   |   5 +
 arch/arm/dts/sun50i-h616-x96-mate.dts         |   5 +
 arch/arm/dts/sun50i-h616.dtsi                 |  19 +-
 .../arm/dts/sun50i-h618-longan-module-3h.dtsi |   5 +
 arch/arm/dts/sun50i-h618-orangepi-zero2w.dts  |   5 +
 arch/arm/dts/sun50i-h618-orangepi-zero3.dts   |   5 +
 .../arm/dts/sun50i-h618-transpeed-8k618-t.dts |   7 +-
 arch/arm/dts/sun50i-h64-remix-mini-pc.dts     |   2 +-
 .../dts/sun50i-h700-anbernic-rg35xx-2024.dts  | 327 ++++++++++++++++++
 .../arm/dts/sun50i-h700-anbernic-rg35xx-h.dts |  36 ++
 .../dts/sun50i-h700-anbernic-rg35xx-plus.dts  |  53 +++
 arch/arm/dts/sun5i-a13.dtsi                   |   4 +-
 arch/arm/dts/sun5i-gr8-chip-pro.dts           |   2 +-
 arch/arm/dts/sun5i-r8-chip.dts                |   2 +-
 arch/arm/dts/sun6i-a31-hummingbird.dts        |   4 +-
 arch/arm/dts/sun6i-a31.dtsi                   |  16 +-
 arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   2 +-
 arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts   |   2 +-
 arch/arm/dts/sun7i-a20-cubietruck.dts         |   2 +-
 arch/arm/dts/sun7i-a20-hummingbird.dts        |   4 +-
 .../arm/dts/sun7i-a20-olimex-som-evb-emmc.dts |   2 +-
 .../dts/sun7i-a20-olimex-som204-evb-emmc.dts  |   2 +-
 arch/arm/dts/sun7i-a20-olimex-som204-evb.dts  |   4 +-
 arch/arm/dts/sun7i-a20-olinuxino-lime2.dts    |   2 +-
 arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts   |   2 +-
 arch/arm/dts/sun7i-a20.dtsi                   |   4 +-
 arch/arm/dts/sun8i-a23-a33.dtsi               |  14 +-
 .../dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   4 +-
 .../dts/sun8i-a23-polaroid-mid2809pxe04.dts   |   4 +-
 arch/arm/dts/sun8i-a33-ga10h-v1.1.dts         |   2 +-
 arch/arm/dts/sun8i-a33-inet-d978-rev2.dts     |   2 +-
 arch/arm/dts/sun8i-a33.dtsi                   |  10 +-
 arch/arm/dts/sun8i-a83t-bananapi-m3.dts       |   2 +-
 arch/arm/dts/sun8i-a83t-cubietruck-plus.dts   |   2 +-
 arch/arm/dts/sun8i-a83t-tbs-a711.dts          |   2 +-
 arch/arm/dts/sun8i-a83t.dtsi                  |   8 +-
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |   2 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts    |   5 +-
 arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts  |   6 +-
 arch/arm/dts/sun8i-h3-beelink-x2.dts          |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-duo2.dts         |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts      |   4 +-
 arch/arm/dts/sun8i-h3-nanopi-neo-air.dts      |   2 +-
 arch/arm/dts/sun8i-h3-nanopi-r1.dts           |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-2.dts          |   4 +-
 arch/arm/dts/sun8i-h3-orangepi-lite.dts       |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts    |   2 +-
 arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts |   2 +-
 arch/arm/dts/sun8i-q8-common.dtsi             |   4 +-
 arch/arm/dts/sun8i-r16-bananapi-m2m.dts       |   2 +-
 arch/arm/dts/sun8i-r16-parrot.dts             |   2 +-
 arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts  |   2 +-
 arch/arm/dts/sun8i-r40-oka40i-c.dts           |   2 +-
 arch/arm/dts/sun8i-s3-pinecube.dts            |   2 +-
 arch/arm/dts/sun8i-v3s.dtsi                   |   4 +-
 arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts  |   2 +-
 arch/arm/dts/sun9i-a80.dtsi                   |   4 +-
 arch/arm/dts/sunxi-bananapi-m2-plus.dtsi      |   2 +-
 arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi    |   2 +-
 arch/arm/dts/sunxi-h3-h5.dtsi                 |   4 +-
 84 files changed, 897 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h313-tanix-tx1.dts
 create mode 100644 arch/arm/dts/sun50i-h616-cpu-opp.dtsi
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts
 create mode 100644 arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts

diff --git a/arch/arm/dts/sun50i-a64-bananapi-m64.dts b/arch/arm/dts/sun50i-a64-bananapi-m64.dts
index bf66b640816..92bc4e7864e 100644
--- a/arch/arm/dts/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm/dts/sun50i-a64-bananapi-m64.dts
@@ -53,7 +53,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sun50i-a64-nanopi-a64.dts b/arch/arm/dts/sun50i-a64-nanopi-a64.dts
index ffc3b4c7068..69dfe3bc4d8 100644
--- a/arch/arm/dts/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm/dts/sun50i-a64-nanopi-a64.dts
@@ -41,7 +41,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/dts/sun50i-a64-olinuxino.dts b/arch/arm/dts/sun50i-a64-olinuxino.dts
index 22d350249c1..75217668382 100644
--- a/arch/arm/dts/sun50i-a64-olinuxino.dts
+++ b/arch/arm/dts/sun50i-a64-olinuxino.dts
@@ -52,7 +52,7 @@
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm/dts/sun50i-a64-orangepi-win.dts b/arch/arm/dts/sun50i-a64-orangepi-win.dts
index 714a270a558..a037e15ab9d 100644
--- a/arch/arm/dts/sun50i-a64-orangepi-win.dts
+++ b/arch/arm/dts/sun50i-a64-orangepi-win.dts
@@ -68,7 +68,7 @@
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sun50i-a64-pinebook.dts b/arch/arm/dts/sun50i-a64-pinebook.dts
index 576eae13223..1a85d5f60c3 100644
--- a/arch/arm/dts/sun50i-a64-pinebook.dts
+++ b/arch/arm/dts/sun50i-a64-pinebook.dts
@@ -79,7 +79,7 @@
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm/dts/sun50i-a64-pinephone.dtsi b/arch/arm/dts/sun50i-a64-pinephone.dtsi
index b25e7913f55..c62dc937def 100644
--- a/arch/arm/dts/sun50i-a64-pinephone.dtsi
+++ b/arch/arm/dts/sun50i-a64-pinephone.dtsi
@@ -39,25 +39,35 @@
 	leds {
 		compatible = "gpio-leds";
 
-		led-0 {
+		led0: led-0 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+			retain-state-suspended;
 		};
 
-		led-1 {
+		led1: led-1 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
+			retain-state-suspended;
 		};
 
-		led-2 {
+		led2: led-2 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+			retain-state-suspended;
 		};
 	};
 
+	multi-led {
+		compatible = "leds-group-multicolor";
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_INDICATOR;
+		leds = <&led0>, <&led1>, <&led2>;
+	};
+
 	reg_ps: ps-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "ps";
diff --git a/arch/arm/dts/sun50i-a64-pinetab.dts b/arch/arm/dts/sun50i-a64-pinetab.dts
index 0b2258ef88f..b6f42357b45 100644
--- a/arch/arm/dts/sun50i-a64-pinetab.dts
+++ b/arch/arm/dts/sun50i-a64-pinetab.dts
@@ -98,7 +98,7 @@
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun50i-a64-teres-i.dts b/arch/arm/dts/sun50i-a64-teres-i.dts
index 945afdb508d..065b1861633 100644
--- a/arch/arm/dts/sun50i-a64-teres-i.dts
+++ b/arch/arm/dts/sun50i-a64-teres-i.dts
@@ -74,7 +74,7 @@
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
diff --git a/arch/arm/dts/sun50i-a64.dtsi b/arch/arm/dts/sun50i-a64.dtsi
index 2240eaec5dd..b6928cc668d 100644
--- a/arch/arm/dts/sun50i-a64.dtsi
+++ b/arch/arm/dts/sun50i-a64.dtsi
@@ -107,27 +107,19 @@
 	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
-		opp-120000000 {
-			opp-hz = /bits/ 64 <120000000>;
-		};
-
-		opp-312000000 {
-			opp-hz = /bits/ 64 <312000000>;
-		};
-
 		opp-432000000 {
 			opp-hz = /bits/ 64 <432000000>;
 		};
 	};
 
-	osc24M: osc24M_clk {
+	osc24M: osc24M-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
 		clock-output-names = "osc24M";
 	};
 
-	osc32k: osc32k_clk {
+	osc32k: osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
@@ -216,21 +208,21 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_alert1: cpu_alert1 {
+				cpu_alert1: cpu-alert1 {
 					/* milliCelsius */
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <110000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/dts/sun50i-h313-tanix-tx1.dts b/arch/arm/dts/sun50i-h313-tanix-tx1.dts
new file mode 100644
index 00000000000..bb2cde59bd0
--- /dev/null
+++ b/arch/arm/dts/sun50i-h313-tanix-tx1.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Arm Ltd.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Tanix TX1";
+	compatible = "oranth,tanix-tx1", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &sdio_wifi;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key {
+			label = "hidden";
+			linux,code = <BTN_0>;
+			gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+			default-state = "on";
+		};
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		pinctrl-0 = <&x32clk_fanout_pin>;
+		pinctrl-names = "default";
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	bus-width = <8>;
+	non-removable;
+	max-frequency = <100000000>;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_aldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies VCC-PLL, so needs to be always on. */
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Supplies VCC-IO, so needs to be always on. */
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1120000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";       /* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
index 4c3921ac236..b69032c4455 100644
--- a/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
@@ -68,7 +68,7 @@
 		states = <1100000 0>, <1300000 1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
index a3e040da38a..3a7ee44708a 100644
--- a/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
@@ -103,7 +103,7 @@
 		states = <1100000 0x0>, <1300000 0x1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		post-power-on-delay-ms = <200>;
@@ -170,7 +170,7 @@
 	non-removable;
 	status = "okay";
 
-	rtl8189etv: sdio_wifi@1 {
+	rtl8189etv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun50i-h5-orangepi-prime.dts b/arch/arm/dts/sun50i-h5-orangepi-prime.dts
index d7f8bad6bb9..b699bb900e1 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-prime.dts
@@ -85,7 +85,7 @@
 		status = "okay";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 14 GPIO_ACTIVE_LOW>; /* PC14 */
 	};
diff --git a/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts b/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
index 7ec5ac850a0..ae85131aac9 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
@@ -97,7 +97,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
index 22530ace12d..734481e998b 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
@@ -52,7 +52,7 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun50i-h6-beelink-gs1.dts b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
index 87432c4f1ff..529285fc34f 100644
--- a/arch/arm/dts/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
@@ -34,7 +34,7 @@
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm/dts/sun50i-h6-orangepi-3.dts b/arch/arm/dts/sun50i-h6-orangepi-3.dts
index f1957bb1edb..bdcec466246 100644
--- a/arch/arm/dts/sun50i-h6-orangepi-3.dts
+++ b/arch/arm/dts/sun50i-h6-orangepi-3.dts
@@ -33,7 +33,7 @@
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm/dts/sun50i-h6-orangepi-lite2.dts b/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
index fb31dcb1cb6..a3f65a45bd2 100644
--- a/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
@@ -11,7 +11,7 @@
 		serial1 = &uart1; /* BT-UART */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/dts/sun50i-h6-orangepi.dtsi b/arch/arm/dts/sun50i-h6-orangepi.dtsi
index a5811d55bbe..4403769fc36 100644
--- a/arch/arm/dts/sun50i-h6-orangepi.dtsi
+++ b/arch/arm/dts/sun50i-h6-orangepi.dtsi
@@ -32,7 +32,7 @@
 		};
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts b/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
index b710f1a0f53..66fe03910d5 100644
--- a/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
@@ -5,13 +5,13 @@
 
 #include "sun50i-h6-pine-h64.dts"
 
+/delete-node/ &reg_gmac_3v3;
+
 / {
 	model = "Pine H64 model B";
 	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
 
-	/delete-node/ reg_gmac_3v3;
-
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun50i-h6-pine-h64.dts b/arch/arm/dts/sun50i-h6-pine-h64.dts
index b868ad17af8..bfb46572bda 100644
--- a/arch/arm/dts/sun50i-h6-pine-h64.dts
+++ b/arch/arm/dts/sun50i-h6-pine-h64.dts
@@ -22,7 +22,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	ext_osc32k: ext_osc32k_clk {
+	ext_osc32k: ext-osc32k-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm/dts/sun50i-h6.dtsi b/arch/arm/dts/sun50i-h6.dtsi
index 09e21689284..82aa5679fc4 100644
--- a/arch/arm/dts/sun50i-h6.dtsi
+++ b/arch/arm/dts/sun50i-h6.dtsi
@@ -68,7 +68,7 @@
 		status = "disabled";
 	};
 
-	osc24M: osc24M_clk {
+	osc24M: osc24M-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
diff --git a/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
index af421ba24ce..d12b01c5f41 100644
--- a/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -62,6 +63,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dldo1>;
 	/* Card detection pin is not connected */
diff --git a/arch/arm/dts/sun50i-h616-cpu-opp.dtsi b/arch/arm/dts/sun50i-h616-cpu-opp.dtsi
new file mode 100644
index 00000000000..aca22a7f019
--- /dev/null
+++ b/arch/arm/dts/sun50i-h616-cpu-opp.dtsi
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2023 Martin Botka <martin@somainline.org>
+
+/ {
+	cpu_opp_table: opp-table-cpu {
+		compatible = "allwinner,sun50i-h616-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		opp-shared;
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt-speed1 = <900000>;
+			opp-microvolt-speed4 = <940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x12>;
+		};
+
+		opp-936000000 {
+			opp-hz = /bits/ 64 <936000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt-speed0 = <950000>;
+			opp-microvolt-speed1 = <940000>;
+			opp-microvolt-speed2 = <950000>;
+			opp-microvolt-speed3 = <950000>;
+			opp-microvolt-speed4 = <1020000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt-speed0 = <1000000>;
+			opp-microvolt-speed2 = <1000000>;
+			opp-microvolt-speed3 = <1000000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0 = <1050000>;
+			opp-microvolt-speed1 = <1020000>;
+			opp-microvolt-speed2 = <1050000>;
+			opp-microvolt-speed3 = <1050000>;
+			opp-microvolt-speed4 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1f>;
+		};
+
+		opp-1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x1d>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0d>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-microvolt-speed1 = <1100000>;
+			opp-microvolt-speed3 = <1100000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+			opp-supported-hw = <0x0a>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu_opp_table>;
+};
diff --git a/arch/arm/dts/sun50i-h616-orangepi-zero2.dts b/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
index b5d713926a3..a360d8567f9 100644
--- a/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm/dts/sun50i-h616-orangepi-zero2.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
 
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 / {
 	model = "OrangePi Zero2";
 	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &emac0 {
 	allwinner,rx-delay-ps = <3100>;
 	allwinner,tx-delay-ps = <700>;
diff --git a/arch/arm/dts/sun50i-h616-x96-mate.dts b/arch/arm/dts/sun50i-h616-x96-mate.dts
index 959b6fd1848..26d25b5b59e 100644
--- a/arch/arm/dts/sun50i-h616-x96-mate.dts
+++ b/arch/arm/dts/sun50i-h616-x96-mate.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -32,6 +33,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
index b2e85e52d1a..921d5f61d8d 100644
--- a/arch/arm/dts/sun50i-h616.dtsi
+++ b/arch/arm/dts/sun50i-h616.dtsi
@@ -26,6 +26,7 @@
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -34,6 +35,7 @@
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -42,6 +44,7 @@
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -50,6 +53,7 @@
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -156,6 +160,10 @@
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@0 {
+				reg = <0x0 2>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -194,7 +202,7 @@
 			};
 
 			i2c0_pins: i2c0-pins {
-				pins = "PI6", "PI7";
+				pins = "PI5", "PI6";
 				function = "i2c0";
 			};
 
@@ -775,6 +783,15 @@
 			#reset-cells = <1>;
 		};
 
+		nmi_intc: interrupt-controller@7010320 {
+			compatible = "allwinner,sun50i-h616-nmi",
+				     "allwinner,sun9i-a80-nmi";
+			reg = <0x07010320 0xc>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h616-r-pinctrl";
 			reg = <0x07022000 0x400>;
diff --git a/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi b/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
index 8c1263a3939..e92d150aaf1 100644
--- a/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
+++ b/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
@@ -4,6 +4,11 @@
  */
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
 
 &mmc2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/sun50i-h618-orangepi-zero2w.dts b/arch/arm/dts/sun50i-h618-orangepi-zero2w.dts
index 21ca1977055..6a4f0da9723 100644
--- a/arch/arm/dts/sun50i-h618-orangepi-zero2w.dts
+++ b/arch/arm/dts/sun50i-h618-orangepi-zero2w.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -53,6 +54,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci1 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-h618-orangepi-zero3.dts b/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
index b3b1b869212..e1cd7572a14 100644
--- a/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm/dts/sun50i-h618-orangepi-zero3.dts
@@ -6,12 +6,17 @@
 /dts-v1/;
 
 #include "sun50i-h616-orangepi-zero.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 / {
 	model = "OrangePi Zero3";
 	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &emac0 {
 	allwinner,tx-delay-ps = <700>;
 	phy-mode = "rgmii-rxid";
diff --git a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
index ac0a2b7ea6f..d6631bfe629 100644
--- a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -41,7 +42,7 @@
 		regulator-always-on;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
 		clock-names = "ext_clock";
@@ -51,6 +52,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-h64-remix-mini-pc.dts b/arch/arm/dts/sun50i-h64-remix-mini-pc.dts
index c1a15d60bf3..464a3078afd 100644
--- a/arch/arm/dts/sun50i-h64-remix-mini-pc.dts
+++ b/arch/arm/dts/sun50i-h64-remix-mini-pc.dts
@@ -42,7 +42,7 @@
 		regulator-always-on;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
new file mode 100644
index 00000000000..ee30584b6ad
--- /dev/null
+++ b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) 2024 Ryan Walklin <ryan@testtoast.com>.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Anbernic RG35XX 2024";
+	chassis-type = "handset";
+	compatible = "anbernic,rg35xx-2024", "allwinner,sun50i-h700";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio_keys_gamepad: gpio-keys-gamepad {
+		compatible = "gpio-keys";
+
+		button-a {
+			label = "Action-Pad A";
+			gpios = <&pio 0 0 GPIO_ACTIVE_LOW>; /* PA0 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_EAST>;
+		};
+
+		button-b {
+			label = "Action-Pad B";
+			gpios = <&pio 0 1 GPIO_ACTIVE_LOW>; /* PA1 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_SOUTH>;
+		};
+
+		button-down {
+			label = "D-Pad Down";
+			gpios = <&pio 4 0 GPIO_ACTIVE_LOW>; /* PE0 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_DPAD_DOWN>;
+		};
+
+		button-l1 {
+			label = "Key L1";
+			gpios = <&pio 0 10 GPIO_ACTIVE_LOW>; /* PA10 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_TL>;
+		};
+
+		button-l2 {
+			label = "Key L2";
+			gpios = <&pio 0 11 GPIO_ACTIVE_LOW>; /* PA11 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_TL2>;
+		};
+
+		button-left {
+			label = "D-Pad left";
+			gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_DPAD_LEFT>;
+		};
+
+		button-menu {
+			label = "Key Menu";
+			gpios = <&pio 4 3 GPIO_ACTIVE_LOW>; /* PE3 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_MODE>;
+		};
+
+		button-r1 {
+			label = "Key R1";
+			gpios = <&pio 0 12 GPIO_ACTIVE_LOW>; /* PA12 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_TR>;
+		};
+
+		button-r2 {
+			label = "Key R2";
+			gpios = <&pio 0 7 GPIO_ACTIVE_LOW>; /* PA7 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_TR2>;
+		};
+
+		button-right {
+			label = "D-Pad Right";
+			gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_DPAD_RIGHT>;
+		};
+
+		button-select {
+			label = "Key Select";
+			gpios = <&pio 0 5 GPIO_ACTIVE_LOW>; /* PA5 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_SELECT>;
+		};
+		button-start {
+			label = "Key Start";
+			gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_START>;
+		};
+
+		button-up {
+			label = "D-Pad Up";
+			gpios = <&pio 0 6 GPIO_ACTIVE_LOW>; /* PA6 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_DPAD_UP>;
+		};
+
+		button-x {
+			label = "Action-Pad X";
+			gpios = <&pio 0 3 GPIO_ACTIVE_LOW>; /* PA3 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_NORTH>;
+		};
+
+		button-y {
+			label = "Action Pad Y";
+			gpios = <&pio 0 2 GPIO_ACTIVE_LOW>; /* PA2 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <BTN_WEST>;
+		};
+	};
+
+	gpio-keys-volume {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		button-vol-up {
+			label = "Key Volume Up";
+			gpios = <&pio 4 1 GPIO_ACTIVE_LOW>; /* PE1 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-vol-down {
+			label = "Key Volume Down";
+			gpios = <&pio 4 2 GPIO_ACTIVE_LOW>; /* PE2 */
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 8 12 GPIO_ACTIVE_HIGH>; /* PI12 */
+			default-state = "on";
+		};
+	};
+
+	reg_vcc5v: regulator-vcc5v { /* USB-C power input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc1>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_cldo3>;
+	disable-wp;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pa-supply = <&reg_cldo3>;
+	vcc-pc-supply = <&reg_cldo3>;
+	vcc-pe-supply = <&reg_cldo3>;
+	vcc-pf-supply = <&reg_cldo3>;
+	vcc-pg-supply = <&reg_aldo4>;
+	vcc-ph-supply = <&reg_cldo3>;
+	vcc-pi-supply = <&reg_cldo3>;
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp717: pmic@3a3 {
+		compatible = "x-powers,axp717";
+		reg = <0x3a3>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+		vin4-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <940000>;
+				regulator-max-microvolt = <940000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+
+			reg_aldo1: aldo1 {
+				/* 1.8v - unused */
+			};
+
+			reg_aldo2: aldo2 {
+				/* 1.8v - unused */
+			};
+
+			reg_aldo3: aldo3 {
+				/* 1.8v - unused */
+			};
+
+			reg_aldo4: aldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pg";
+			};
+
+			reg_bldo1: bldo1 {
+				/* 1.8v - unused */
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pll";
+			};
+
+			reg_bldo3: bldo3 {
+				/* 2.8v - unused */
+			};
+
+			reg_bldo4: bldo4 {
+				/* 1.2v - unused */
+			};
+
+			reg_cldo1: cldo1 {
+				/* 3.3v - audio codec - not yet implemented */
+			};
+
+			reg_cldo2: cldo2 {
+				/* 3.3v - unused */
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-io";
+			};
+
+			reg_cldo4: cldo4 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi";
+			};
+
+			reg_boost: boost {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5200000>;
+				regulator-name = "boost";
+			};
+
+			reg_cpusldo: cpusldo {
+				/* unused */
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+/* the AXP717 has USB type-C role switch functionality, not yet described by the binding */
+&usbotg {
+	dr_mode = "peripheral";   /* USB type-C receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts
new file mode 100644
index 00000000000..63036256917
--- /dev/null
+++ b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-h.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) 2024 Ryan Walklin <ryan@testtoast.com>.
+ * Copyright (C) 2024 Chris Morgan <macroalpha82@gmail.com>.
+ */
+
+#include "sun50i-h700-anbernic-rg35xx-plus.dts"
+
+/ {
+	model = "Anbernic RG35XX H";
+	compatible = "anbernic,rg35xx-h", "allwinner,sun50i-h700";
+};
+
+&gpio_keys_gamepad {
+	button-thumbl {
+		label = "GPIO Thumb Left";
+		gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
+		linux,input-type = <EV_KEY>;
+		linux,code = <BTN_THUMBL>;
+	};
+
+	button-thumbr {
+		label = "GPIO Thumb Right";
+		gpios = <&pio 4 9 GPIO_ACTIVE_LOW>; /* PE9 */
+		linux,input-type = <EV_KEY>;
+		linux,code = <BTN_THUMBR>;
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts
new file mode 100644
index 00000000000..60a8e492210
--- /dev/null
+++ b/arch/arm/dts/sun50i-h700-anbernic-rg35xx-plus.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) 2024 Ryan Walklin <ryan@testtoast.com>.
+ */
+
+#include "sun50i-h700-anbernic-rg35xx-2024.dts"
+
+/ {
+	model = "Anbernic RG35XX Plus";
+	compatible = "anbernic,rg35xx-plus", "allwinner,sun50i-h700";
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		pinctrl-0 = <&x32clk_fanout_pin>;
+		pinctrl-names = "default";
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+	};
+};
+
+/* SDIO WiFi RTL8821CS */
+&mmc1 {
+	vmmc-supply = <&reg_cldo4>;
+	vqmmc-supply = <&reg_aldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 15 IRQ_TYPE_LEVEL_LOW>; /* PG15 */
+		interrupt-names = "host-wake";
+	};
+};
+
+/* Bluetooth RTL8821CS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8821cs-bt", "realtek,rtl8723bs-bt";
+		device-wake-gpios = <&pio 6 17 GPIO_ACTIVE_HIGH>; /* PG17 */
+		enable-gpios = <&pio 6 19 GPIO_ACTIVE_HIGH>; /* PG19 */
+		host-wake-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16 */
+	};
+};
diff --git a/arch/arm/dts/sun5i-a13.dtsi b/arch/arm/dts/sun5i-a13.dtsi
index 3325ab07094..2c9152b151b 100644
--- a/arch/arm/dts/sun5i-a13.dtsi
+++ b/arch/arm/dts/sun5i-a13.dtsi
@@ -62,14 +62,14 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/dts/sun5i-gr8-chip-pro.dts b/arch/arm/dts/sun5i-gr8-chip-pro.dts
index 5c3562b85a5..ffbd99c176d 100644
--- a/arch/arm/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/dts/sun5i-gr8-chip-pro.dts
@@ -77,7 +77,7 @@
 		};
 	};
 
-	mmc0_pwrseq: mmc0_pwrseq {
+	mmc0_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
 	};
diff --git a/arch/arm/dts/sun5i-r8-chip.dts b/arch/arm/dts/sun5i-r8-chip.dts
index 4192c23848c..8c784a2c086 100644
--- a/arch/arm/dts/sun5i-r8-chip.dts
+++ b/arch/arm/dts/sun5i-r8-chip.dts
@@ -77,7 +77,7 @@
 		};
 	};
 
-	mmc0_pwrseq: mmc0_pwrseq {
+	mmc0_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
 	};
diff --git a/arch/arm/dts/sun6i-a31-hummingbird.dts b/arch/arm/dts/sun6i-a31-hummingbird.dts
index 486cec6f71e..41955fe5490 100644
--- a/arch/arm/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/dts/sun6i-a31-hummingbird.dts
@@ -109,7 +109,7 @@
 		};
 	};
 
-	reg_vga_3v3: vga_3v3_regulator {
+	reg_vga_3v3: vga-3v3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vga-3v3";
 		regulator-min-microvolt = <3300000>;
@@ -119,7 +119,7 @@
 		gpio = <&pio 7 25 GPIO_ACTIVE_HIGH>; /* PH25 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
 	};
diff --git a/arch/arm/dts/sun6i-a31.dtsi b/arch/arm/dts/sun6i-a31.dtsi
index b32d2ab6aa2..a65c09ec054 100644
--- a/arch/arm/dts/sun6i-a31.dtsi
+++ b/arch/arm/dts/sun6i-a31.dtsi
@@ -179,14 +179,14 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <70000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1315,7 +1315,7 @@
 			compatible = "allwinner,sun6i-a31-prcm";
 			reg = <0x01f01400 0x200>;
 
-			ar100: ar100_clk {
+			ar100: ar100-clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
 				clocks = <&rtc CLK_OSC32K>, <&osc24M>,
@@ -1324,7 +1324,7 @@
 				clock-output-names = "ar100";
 			};
 
-			ahb0: ahb0_clk {
+			ahb0: ahb0-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -1333,14 +1333,14 @@
 				clock-output-names = "ahb0";
 			};
 
-			apb0: apb0_clk {
+			apb0: apb0-clk {
 				compatible = "allwinner,sun6i-a31-apb0-clk";
 				#clock-cells = <0>;
 				clocks = <&ahb0>;
 				clock-output-names = "apb0";
 			};
 
-			apb0_gates: apb0_gates_clk {
+			apb0_gates: apb0-gates-clk {
 				compatible = "allwinner,sun6i-a31-apb0-gates-clk";
 				#clock-cells = <1>;
 				clocks = <&apb0>;
@@ -1350,14 +1350,14 @@
 						"apb0_i2c";
 			};
 
-			ir_clk: ir_clk {
+			ir_clk: ir-clk {
 				#clock-cells = <0>;
 				compatible = "allwinner,sun4i-a10-mod0-clk";
 				clocks = <&rtc CLK_OSC32K>, <&osc24M>;
 				clock-output-names = "ir";
 			};
 
-			apb0_rst: apb0_rst {
+			apb0_rst: apb0-rst {
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index efb25b949f3..2f3d93e56d7 100644
--- a/arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -75,7 +75,7 @@
 		};
 	};
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 WIFI_EN */
 	};
diff --git a/arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts
index caa935ca4f1..f2d7fab9978 100644
--- a/arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -86,7 +86,7 @@
 		};
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 WL-PMU-EN */
 	};
diff --git a/arch/arm/dts/sun7i-a20-cubietruck.dts b/arch/arm/dts/sun7i-a20-cubietruck.dts
index 52160e36830..be9b31d0f4b 100644
--- a/arch/arm/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/dts/sun7i-a20-cubietruck.dts
@@ -96,7 +96,7 @@
 		};
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 		clocks = <&ccu CLK_OUT_A>;
diff --git a/arch/arm/dts/sun7i-a20-hummingbird.dts b/arch/arm/dts/sun7i-a20-hummingbird.dts
index 3def2a33059..f1e26b75cd9 100644
--- a/arch/arm/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/dts/sun7i-a20-hummingbird.dts
@@ -65,7 +65,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	reg_mmc3_vdd: mmc3_vdd {
+	reg_mmc3_vdd: regulator-mmc3-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc3_vdd";
 		regulator-min-microvolt = <3000000>;
@@ -74,7 +74,7 @@
 		gpio = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
 	};
 
-	reg_gmac_vdd: gmac_vdd {
+	reg_gmac_vdd: regulator-gmac-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "gmac_vdd";
 		regulator-min-microvolt = <3000000>;
diff --git a/arch/arm/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/dts/sun7i-a20-olimex-som-evb-emmc.dts
index 20bf09b2226..fb835730bbc 100644
--- a/arch/arm/dts/sun7i-a20-olimex-som-evb-emmc.dts
+++ b/arch/arm/dts/sun7i-a20-olimex-som-evb-emmc.dts
@@ -14,7 +14,7 @@
 	model = "Olimex A20-Olimex-SOM-EVB-eMMC";
 	compatible = "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a20";
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&pio 2 18 GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/dts/sun7i-a20-olimex-som204-evb-emmc.dts b/arch/arm/dts/sun7i-a20-olimex-som204-evb-emmc.dts
index a59755a2e7a..e8977c2fe79 100644
--- a/arch/arm/dts/sun7i-a20-olimex-som204-evb-emmc.dts
+++ b/arch/arm/dts/sun7i-a20-olimex-som204-evb-emmc.dts
@@ -13,7 +13,7 @@
 	model = "Olimex A20-SOM204-EVB-eMMC";
 	compatible = "olimex,a20-olimex-som204-evb-emmc", "allwinner,sun7i-a20";
 
-	mmc2_pwrseq: mmc2_pwrseq {
+	mmc2_pwrseq: pwrseq-1 {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/dts/sun7i-a20-olimex-som204-evb.dts
index 54af6c18075..a5540665744 100644
--- a/arch/arm/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/dts/sun7i-a20-olimex-som204-evb.dts
@@ -65,7 +65,7 @@
 		};
 	};
 
-	rtl_pwrseq: rtl_pwrseq {
+	rtl_pwrseq: pwrseq-0 {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 9 GPIO_ACTIVE_LOW>;
 	};
@@ -177,7 +177,7 @@
 	non-removable;
 	status = "okay";
 
-	rtl8723bs: sdio_wifi@1 {
+	rtl8723bs: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/dts/sun7i-a20-olinuxino-lime2.dts
index ecb91fb899f..435a189332e 100644
--- a/arch/arm/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/dts/sun7i-a20-olinuxino-lime2.dts
@@ -82,7 +82,7 @@
 		};
 	};
 
-	reg_axp_ipsout: axp_ipsout {
+	reg_axp_ipsout: regulator-axp-ipsout {
 		compatible = "regulator-fixed";
 		regulator-name = "axp-ipsout";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 3bfae98f3cc..29199b6a3b4 100644
--- a/arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -60,7 +60,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	mmc3_pwrseq: mmc3_pwrseq {
+	mmc3_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 	};
diff --git a/arch/arm/dts/sun7i-a20.dtsi b/arch/arm/dts/sun7i-a20.dtsi
index 5574299685a..5f44f09c554 100644
--- a/arch/arm/dts/sun7i-a20.dtsi
+++ b/arch/arm/dts/sun7i-a20.dtsi
@@ -153,14 +153,14 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/dts/sun8i-a23-a33.dtsi b/arch/arm/dts/sun8i-a23-a33.dtsi
index a0cac966af3..4ebb0a7a78f 100644
--- a/arch/arm/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/dts/sun8i-a23-a33.dtsi
@@ -108,7 +108,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -116,7 +116,7 @@
 			clock-output-names = "osc24M";
 		};
 
-		ext_osc32k: ext_osc32k_clk {
+		ext_osc32k: ext-osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
@@ -730,7 +730,7 @@
 			compatible = "allwinner,sun8i-a23-prcm";
 			reg = <0x01f01400 0x200>;
 
-			ar100: ar100_clk {
+			ar100: ar100-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -739,7 +739,7 @@
 				clock-output-names = "ar100";
 			};
 
-			ahb0: ahb0_clk {
+			ahb0: ahb0-clk {
 				compatible = "fixed-factor-clock";
 				#clock-cells = <0>;
 				clock-div = <1>;
@@ -748,14 +748,14 @@
 				clock-output-names = "ahb0";
 			};
 
-			apb0: apb0_clk {
+			apb0: apb0-clk {
 				compatible = "allwinner,sun8i-a23-apb0-clk";
 				#clock-cells = <0>;
 				clocks = <&ahb0>;
 				clock-output-names = "apb0";
 			};
 
-			apb0_gates: apb0_gates_clk {
+			apb0_gates: apb0-gates-clk {
 				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
 				#clock-cells = <1>;
 				clocks = <&apb0>;
@@ -764,7 +764,7 @@
 						"apb0_i2c";
 			};
 
-			apb0_rst: apb0_rst {
+			apb0_rst: apb0-rst {
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm/dts/sun8i-a23-polaroid-mid2407pxe03.dts b/arch/arm/dts/sun8i-a23-polaroid-mid2407pxe03.dts
index d5f6aebd721..0c585a6d990 100644
--- a/arch/arm/dts/sun8i-a23-polaroid-mid2407pxe03.dts
+++ b/arch/arm/dts/sun8i-a23-polaroid-mid2407pxe03.dts
@@ -52,7 +52,7 @@
 		ethernet0 = &esp8089;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
@@ -76,7 +76,7 @@
 	non-removable;
 	status = "okay";
 
-	esp8089: sdio_wifi@1 {
+	esp8089: wifi@1 {
 		compatible = "esp,esp8089";
 		reg = <1>;
 		esp,crystal-26M-en = <2>;
diff --git a/arch/arm/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index 9f9232a2fef..63cb4e194a0 100644
--- a/arch/arm/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -52,7 +52,7 @@
 		ethernet0 = &esp8089;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
 		/* The esp8089 needs 200 ms after driving wifi-en high */
@@ -69,7 +69,7 @@
 	non-removable;
 	status = "okay";
 
-	esp8089: sdio_wifi@1 {
+	esp8089: wifi@1 {
 		compatible = "esp,esp8089";
 		reg = <1>;
 		esp,crystal-26M-en = <2>;
diff --git a/arch/arm/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/dts/sun8i-a33-ga10h-v1.1.dts
index 2dfdd0a3151..f00ce03ffc8 100644
--- a/arch/arm/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/dts/sun8i-a33-ga10h-v1.1.dts
@@ -85,7 +85,7 @@
 	non-removable;
 	status = "okay";
 
-	rtl8703as: sdio_wifi@1 {
+	rtl8703as: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/dts/sun8i-a33-inet-d978-rev2.dts
index 065cb620aa9..162ba93f748 100644
--- a/arch/arm/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/dts/sun8i-a33-inet-d978-rev2.dts
@@ -78,7 +78,7 @@
 	non-removable;
 	status = "okay";
 
-	rtl8723bs: sdio_wifi@1 {
+	rtl8723bs: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-a33.dtsi b/arch/arm/dts/sun8i-a33.dtsi
index 30fdd2703b1..36b2d78cdab 100644
--- a/arch/arm/dts/sun8i-a33.dtsi
+++ b/arch/arm/dts/sun8i-a33.dtsi
@@ -323,35 +323,35 @@
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				gpu_alert0: gpu_alert0 {
+				gpu_alert0: gpu-alert0 {
 					/* milliCelsius */
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_alert1: cpu_alert1 {
+				cpu_alert1: cpu-alert1 {
 					/* milliCelsius */
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
-				gpu_alert1: gpu_alert1 {
+				gpu_alert1: gpu-alert1 {
 					/* milliCelsius */
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "hot";
 				};
 
-				cpu_crit: cpu_crit {
+				cpu_crit: cpu-crit {
 					/* milliCelsius */
 					temperature = <110000>;
 					hysteresis = <2000>;
diff --git a/arch/arm/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/dts/sun8i-a83t-bananapi-m3.dts
index 197cf6959b5..582b919336f 100644
--- a/arch/arm/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/dts/sun8i-a83t-bananapi-m3.dts
@@ -95,7 +95,7 @@
 		gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/dts/sun8i-a83t-cubietruck-plus.dts
index e26af7cf10e..c5677f99e15 100644
--- a/arch/arm/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/dts/sun8i-a83t-cubietruck-plus.dts
@@ -144,7 +144,7 @@
 		compatible = "linux,spdif-dit";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&ac100_rtc 1>;
 		clock-names = "ext_clock";
diff --git a/arch/arm/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/dts/sun8i-a83t-tbs-a711.dts
index 13ae10f60d5..a2685fb53e3 100644
--- a/arch/arm/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/dts/sun8i-a83t-tbs-a711.dts
@@ -123,7 +123,7 @@
 		vin-supply = <&reg_vbat>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 WL-PMU-EN */
 
diff --git a/arch/arm/dts/sun8i-a83t.dtsi b/arch/arm/dts/sun8i-a83t.dtsi
index cc40622466a..90f2c08d051 100644
--- a/arch/arm/dts/sun8i-a83t.dtsi
+++ b/arch/arm/dts/sun8i-a83t.dtsi
@@ -164,7 +164,7 @@
 		ranges;
 
 		/* TODO: PRCM block has a mux for this. */
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -177,14 +177,14 @@
 		 * It is an internal RC-based oscillator.
 		 * TODO: Its controls are in the PRCM block.
 		 */
-		osc16M: osc16M_clk {
+		osc16M: osc16M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <16000000>;
 			clock-output-names = "osc16M";
 		};
 
-		osc16Md512: osc16Md512_clk {
+		osc16Md512: osc16Md512-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <512>;
@@ -1126,7 +1126,7 @@
 			#reset-cells = <1>;
 		};
 
-		r_cpucfg@1f01c00 {
+		cpucfg@1f01c00 {
 			compatible = "allwinner,sun8i-a83t-r-cpucfg";
 			reg = <0x1f01c00 0x400>;
 		};
diff --git a/arch/arm/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d729b7c705d..d3a7c9fa23e 100644
--- a/arch/arm/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -103,7 +103,7 @@
 		cpu-supply = <&reg_vcc1v2>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts
index 3356f4210d4..79b03b31c5e 100644
--- a/arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/dts/sun8i-h2-plus-orangepi-r1.dts
@@ -43,11 +43,12 @@
 /* Orange Pi R1 is based on Orange Pi Zero design */
 #include "sun8i-h2-plus-orangepi-zero.dts"
 
+/delete-node/ &reg_vcc_wifi;
+
 / {
 	model = "Xunlong Orange Pi R1";
 	compatible = "xunlong,orangepi-r1", "allwinner,sun8i-h2-plus";
 
-	/delete-node/ reg_vcc_wifi;
 
 	/*
 	 * Ths pin of this regulator is the same with the Wi-Fi extra
@@ -89,7 +90,7 @@
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 
-	rtl8189etv: sdio_wifi@1 {
+	rtl8189etv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
index 3706216ffb4..1b001f2ad0e 100644
--- a/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -80,7 +80,7 @@
 		};
 	};
 
-	reg_vcc_wifi: reg_vcc_wifi {
+	reg_vcc_wifi: reg-vcc-wifi {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -105,7 +105,7 @@
 		states = <1100000 0>, <1300000 1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
 		post-power-on-delay-ms = <200>;
@@ -149,7 +149,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	xr819: sdio_wifi@1 {
+	xr819: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h3-beelink-x2.dts b/arch/arm/dts/sun8i-h3-beelink-x2.dts
index a6d38ecee14..5b77300307d 100644
--- a/arch/arm/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/dts/sun8i-h3-beelink-x2.dts
@@ -122,7 +122,7 @@
 		compatible = "linux,spdif-dit";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
@@ -185,7 +185,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	sdiowifi: sdio_wifi@1 {
+	sdiowifi: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/dts/sun8i-h3-nanopi-duo2.dts
index 343b02b9715..2b0566d4b38 100644
--- a/arch/arm/dts/sun8i-h3-nanopi-duo2.dts
+++ b/arch/arm/dts/sun8i-h3-nanopi-duo2.dts
@@ -87,7 +87,7 @@
 		vin-supply = <&reg_vcc5v0>;
         };
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
@@ -119,7 +119,7 @@
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts
index 4ba533b0340..59bd0746acf 100644
--- a/arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -62,7 +62,7 @@
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
@@ -132,7 +132,7 @@
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&pio>;
diff --git a/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
index 9e1a33f94ca..6d85370e04f 100644
--- a/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/dts/sun8i-h3-nanopi-neo-air.dts
@@ -73,7 +73,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
diff --git a/arch/arm/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/dts/sun8i-h3-nanopi-r1.dts
index 42cd1131adf..870649760f7 100644
--- a/arch/arm/dts/sun8i-h3-nanopi-r1.dts
+++ b/arch/arm/dts/sun8i-h3-nanopi-r1.dts
@@ -43,7 +43,7 @@
 			 <1300000 0x1>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sun8i-h3-orangepi-2.dts b/arch/arm/dts/sun8i-h3-orangepi-2.dts
index f1f9dbead32..d2ae47b074b 100644
--- a/arch/arm/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/dts/sun8i-h3-orangepi-2.dts
@@ -105,7 +105,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 WIFI_EN */
 	};
@@ -169,7 +169,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189: sdio_wifi@1 {
+	rtl8189: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/dts/sun8i-h3-orangepi-lite.dts
index 305b34a321f..6a4316a5246 100644
--- a/arch/arm/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/dts/sun8i-h3-orangepi-lite.dts
@@ -143,7 +143,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts
index babf4cf1b2f..8a49b3376df 100644
--- a/arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -63,7 +63,7 @@
 	 * Explicitly define the sdio device, so that we can add an ethernet
 	 * alias for it (which e.g. makes u-boot set a mac-address).
 	 */
-	rtl8189ftv: sdio_wifi@1 {
+	rtl8189ftv: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
index 561ea1d2f86..7a6444a10e2 100644
--- a/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -92,7 +92,7 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun8i-q8-common.dtsi b/arch/arm/dts/sun8i-q8-common.dtsi
index 3d9a1524e17..272584881bb 100644
--- a/arch/arm/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/dts/sun8i-q8-common.dtsi
@@ -62,7 +62,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		/*
 		 * Q8 boards use various PL# pins as wifi-en. On other boards
@@ -94,7 +94,7 @@
 	non-removable;
 	status = "okay";
 
-	sdio_wifi: sdio_wifi@1 {
+	sdio_wifi: wifi@1 {
 		reg = <1>;
 	};
 };
diff --git a/arch/arm/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/dts/sun8i-r16-bananapi-m2m.dts
index f97218e70c1..5001f10c27a 100644
--- a/arch/arm/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/dts/sun8i-r16-bananapi-m2m.dts
@@ -88,7 +88,7 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sun8i-r16-parrot.dts b/arch/arm/dts/sun8i-r16-parrot.dts
index 2be1b76fe2f..40109969cc8 100644
--- a/arch/arm/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/dts/sun8i-r16-parrot.dts
@@ -75,7 +75,7 @@
 		};
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
 	};
diff --git a/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts
index 28197bbcb1d..cd2351acc32 100644
--- a/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -100,7 +100,7 @@
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/dts/sun8i-r40-oka40i-c.dts b/arch/arm/dts/sun8i-r40-oka40i-c.dts
index 0bd1336206b..15b0b4de626 100644
--- a/arch/arm/dts/sun8i-r40-oka40i-c.dts
+++ b/arch/arm/dts/sun8i-r40-oka40i-c.dts
@@ -62,7 +62,7 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; // PB10 WIFI_EN
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/dts/sun8i-s3-pinecube.dts b/arch/arm/dts/sun8i-s3-pinecube.dts
index 20966e954ed..e0d4404b595 100644
--- a/arch/arm/dts/sun8i-s3-pinecube.dts
+++ b/arch/arm/dts/sun8i-s3-pinecube.dts
@@ -51,7 +51,7 @@
 		startup-delay-us = <200000>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 WIFI-RST */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sun8i-v3s.dtsi b/arch/arm/dts/sun8i-v3s.dtsi
index e8a04476b77..9e13c2aa891 100644
--- a/arch/arm/dts/sun8i-v3s.dtsi
+++ b/arch/arm/dts/sun8i-v3s.dtsi
@@ -98,7 +98,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -106,7 +106,7 @@
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		osc32k: osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
diff --git a/arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts
index 434871040ac..6575ef27445 100644
--- a/arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -94,7 +94,7 @@
 		enable-active-high;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
 		clocks = <&ccu CLK_OUTA>;
diff --git a/arch/arm/dts/sun9i-a80.dtsi b/arch/arm/dts/sun9i-a80.dtsi
index 7d3f3300f43..a1ae0929cec 100644
--- a/arch/arm/dts/sun9i-a80.dtsi
+++ b/arch/arm/dts/sun9i-a80.dtsi
@@ -196,14 +196,14 @@
 		 * The actual TX clock rate is not controlled by the
 		 * gmac_tx clock.
 		 */
-		mii_phy_tx_clk: mii_phy_tx_clk {
+		mii_phy_tx_clk: mii-phy-tx-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <25000000>;
 			clock-output-names = "mii_phy_tx";
 		};
 
-		gmac_int_tx_clk: gmac_int_tx_clk {
+		gmac_int_tx_clk: gmac-int-tx-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <125000000>;
diff --git a/arch/arm/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/dts/sunxi-bananapi-m2-plus.dtsi
index 1d1d127cf38..873817ddb4e 100644
--- a/arch/arm/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/dts/sunxi-bananapi-m2-plus.dtsi
@@ -98,7 +98,7 @@
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 		clocks = <&rtc CLK_OSC32K_FANOUT>;
diff --git a/arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi
index 60804b0e6c5..be5f5528a11 100644
--- a/arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi
+++ b/arch/arm/dts/sunxi-h3-h5-emlid-neutis.dtsi
@@ -18,7 +18,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	wifi_pwrseq: wifi_pwrseq {
+	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 2 7 GPIO_ACTIVE_LOW>; /* PC7 */
 		post-power-on-delay-ms = <200>;
diff --git a/arch/arm/dts/sunxi-h3-h5.dtsi b/arch/arm/dts/sunxi-h3-h5.dtsi
index bdc796f4622..43f6938381c 100644
--- a/arch/arm/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/dts/sunxi-h3-h5.dtsi
@@ -83,7 +83,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: osc24M_clk {
+		osc24M: osc24M-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -91,7 +91,7 @@
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		osc32k: osc32k-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
-- 
2.25.1

