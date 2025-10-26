Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B723ACCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C7B83700;
	Sun, 26 Oct 2025 02:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62EB4807C0; Sun, 26 Oct 2025 02:24:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8A79983623
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FCE1764;
 Sat, 25 Oct 2025 18:24:35 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE42F3F59E;
 Sat, 25 Oct 2025 18:24:41 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH 3/4] sunxi: dts: arm64: update devicetree files from Linux
 kernel tree
Date: Sun, 26 Oct 2025 01:23:55 +0000
Message-ID: <20251026012357.16773-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20251026012357.16773-1-andre.przywara@arm.com>
References: <20251026012357.16773-1-andre.przywara@arm.com>
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

Sync the devicetree files from the official Linux kernel tree, v6.18-rc1.
This is covering Allwinner SoCs with 64-bit ARM cores.

The bulk is cosmetic changes: board model name changes, DT node renames,
whitespace fixes.
The actual changes are not dramatic: the CPU cores get their caches
described properly, some A64 video clocks get fixed, some A64 boards
describe the header pins for the WiFi module, the Pinephone adds an
alternative magnetometer used on some board revisions.
On the H5 side the microSD slots get marked as having no write-protect
detection, and the NanoPi Neo Plus2 board describes its regulators better.
The H6 boards switch from RSB to I2C for their PMIC connection.

As before, this omits the non-backwards compatible changes to the R_INTC
controller, to remain compatible with older kernels.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/sun50i-a64-pine64-lts.dts        |  2 +-
 arch/arm/dts/sun50i-a64-pine64-plus.dts       |  2 +-
 arch/arm/dts/sun50i-a64-pine64.dts            | 14 ++++-
 arch/arm/dts/sun50i-a64-pinebook.dts          |  4 +-
 arch/arm/dts/sun50i-a64-pinephone.dtsi        | 21 +++++++
 .../dts/sun50i-a64-pinetab-early-adopter.dts  |  2 +-
 arch/arm/dts/sun50i-a64-pinetab.dts           |  2 +-
 arch/arm/dts/sun50i-a64-sopine-baseboard.dts  | 21 ++++++-
 arch/arm/dts/sun50i-a64-teres-i.dts           |  2 +
 arch/arm/dts/sun50i-a64.dtsi                  | 55 +++++++++++++++++--
 arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts   | 38 +++++++++++++
 arch/arm/dts/sun50i-h5-nanopi-neo2.dts        |  1 +
 arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts      |  1 +
 arch/arm/dts/sun50i-h5-orangepi-pc2.dts       |  1 +
 arch/arm/dts/sun50i-h5-orangepi-prime.dts     |  1 +
 arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts |  1 +
 .../arm/dts/sun50i-h5-orangepi-zero-plus2.dts |  1 +
 arch/arm/dts/sun50i-h5.dtsi                   |  6 +-
 arch/arm/dts/sun50i-h6-beelink-gs1.dts        | 39 ++++++-------
 arch/arm/dts/sun50i-h6-orangepi-3.dts         | 17 +++---
 arch/arm/dts/sun50i-h6-orangepi-lite2.dts     |  2 +-
 arch/arm/dts/sun50i-h6-orangepi.dtsi          | 23 ++++----
 arch/arm/dts/sun50i-h6-pine-h64-model-b.dts   |  2 +-
 arch/arm/dts/sun50i-h6-pine-h64.dts           |  3 +-
 arch/arm/dts/sun50i-h6-tanix.dtsi             |  1 +
 arch/arm/dts/sun50i-h6.dtsi                   | 41 ++++++++++++--
 26 files changed, 241 insertions(+), 62 deletions(-)

diff --git a/arch/arm/dts/sun50i-a64-pine64-lts.dts b/arch/arm/dts/sun50i-a64-pine64-lts.dts
index 596a2590743..709fe650a36 100644
--- a/arch/arm/dts/sun50i-a64-pine64-lts.dts
+++ b/arch/arm/dts/sun50i-a64-pine64-lts.dts
@@ -5,7 +5,7 @@
 #include "sun50i-a64-sopine-baseboard.dts"
 
 / {
-	model = "Pine64 LTS";
+	model = "Pine64 PINE A64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
 
diff --git a/arch/arm/dts/sun50i-a64-pine64-plus.dts b/arch/arm/dts/sun50i-a64-pine64-plus.dts
index b54099b654c..026d843cd7e 100644
--- a/arch/arm/dts/sun50i-a64-pine64-plus.dts
+++ b/arch/arm/dts/sun50i-a64-pine64-plus.dts
@@ -4,7 +4,7 @@
 #include "sun50i-a64-pine64.dts"
 
 / {
-	model = "Pine64+";
+	model = "Pine64 PINE A64+";
 	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
 
 	/* TODO: Camera, touchscreen, etc. */
diff --git a/arch/arm/dts/sun50i-a64-pine64.dts b/arch/arm/dts/sun50i-a64-pine64.dts
index 329cf276561..a406e8f92d0 100644
--- a/arch/arm/dts/sun50i-a64-pine64.dts
+++ b/arch/arm/dts/sun50i-a64-pine64.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine64";
+	model = "Pine64 PINE A64";
 	compatible = "pine64,pine64", "allwinner,sun50i-a64";
 
 	aliases {
@@ -124,6 +124,17 @@
 	status = "okay";
 };
 
+/* On Wifi/BT connector */
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo4>;
+	vqmmc-supply = <&reg_eldo1>;
+	bus-width = <4>;
+	non-removable;
+	status = "disabled";
+};
+
 &ohci0 {
 	status = "okay";
 };
@@ -286,6 +297,7 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "disabled";
 };
 
diff --git a/arch/arm/dts/sun50i-a64-pinebook.dts b/arch/arm/dts/sun50i-a64-pinebook.dts
index 1a85d5f60c3..5b7568edc32 100644
--- a/arch/arm/dts/sun50i-a64-pinebook.dts
+++ b/arch/arm/dts/sun50i-a64-pinebook.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "Pinebook";
+	model = "Pine64 Pinebook";
 	compatible = "pine64,pinebook", "allwinner,sun50i-a64";
 	chassis-type = "laptop";
 
@@ -390,6 +390,8 @@
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-a64-pinephone.dtsi b/arch/arm/dts/sun50i-a64-pinephone.dtsi
index c62dc937def..31b1f99898c 100644
--- a/arch/arm/dts/sun50i-a64-pinephone.dtsi
+++ b/arch/arm/dts/sun50i-a64-pinephone.dtsi
@@ -188,12 +188,30 @@
 &i2c1 {
 	status = "okay";
 
+	/* Alternative magnetometer */
+	af8133j: magnetometer@1c {
+		compatible = "voltafield,af8133j";
+		reg = <0x1c>;
+		reset-gpios = <&pio 1 1 GPIO_ACTIVE_LOW>;
+		avdd-supply = <&reg_dldo1>;
+		dvdd-supply = <&reg_dldo1>;
+		mount-matrix = "0", "-1", "0",
+				"-1", "0", "0",
+				"0", "0", "-1";
+
+		/* status will be fixed up in firmware */
+		status = "disabled";
+	};
+
 	/* Magnetometer */
 	lis3mdl: magnetometer@1e {
 		compatible = "st,lis3mdl-magn";
 		reg = <0x1e>;
 		vdd-supply = <&reg_dldo1>;
 		vddio-supply = <&reg_dldo1>;
+		mount-matrix = "0", "1", "0",
+				"-1", "0", "0",
+				"0", "0", "1";
 	};
 
 	/* Light/proximity sensor */
@@ -212,6 +230,9 @@
 		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
 		vdd-supply = <&reg_dldo1>;
 		vddio-supply = <&reg_dldo1>;
+		mount-matrix = "0", "1", "0",
+			       "-1", "0", "0",
+			       "0", "0", "1";
 	};
 };
 
diff --git a/arch/arm/dts/sun50i-a64-pinetab-early-adopter.dts b/arch/arm/dts/sun50i-a64-pinetab-early-adopter.dts
index 6265360ce62..86cc85eb3d4 100644
--- a/arch/arm/dts/sun50i-a64-pinetab-early-adopter.dts
+++ b/arch/arm/dts/sun50i-a64-pinetab-early-adopter.dts
@@ -9,7 +9,7 @@
 #include "sun50i-a64-pinetab.dts"
 
 / {
-	model = "PineTab, Early Adopter's version";
+	model = "Pine64 PineTab Early Adopter";
 	compatible = "pine64,pinetab-early-adopter", "allwinner,sun50i-a64";
 };
 
diff --git a/arch/arm/dts/sun50i-a64-pinetab.dts b/arch/arm/dts/sun50i-a64-pinetab.dts
index b6f42357b45..c66e0bd52ab 100644
--- a/arch/arm/dts/sun50i-a64-pinetab.dts
+++ b/arch/arm/dts/sun50i-a64-pinetab.dts
@@ -14,7 +14,7 @@
 #include <dt-bindings/pwm/pwm.h>
 
 / {
-	model = "PineTab, Development Sample";
+	model = "Pine64 PineTab Developer Sample";
 	compatible = "pine64,pinetab", "allwinner,sun50i-a64";
 	chassis-type = "tablet";
 
diff --git a/arch/arm/dts/sun50i-a64-sopine-baseboard.dts b/arch/arm/dts/sun50i-a64-sopine-baseboard.dts
index 5e66ce1a334..231e652cab6 100644
--- a/arch/arm/dts/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm/dts/sun50i-a64-sopine-baseboard.dts
@@ -8,7 +8,7 @@
 #include "sun50i-a64-sopine.dtsi"
 
 / {
-	model = "SoPine with baseboard";
+	model = "Pine64 SOPINE on Baseboard carrier board";
 	compatible = "pine64,sopine-baseboard", "pine64,sopine",
 		     "allwinner,sun50i-a64";
 
@@ -103,6 +103,17 @@
 	};
 };
 
+/* On Wifi/BT connector */
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo4>;
+	vqmmc-supply = <&reg_eldo1>;
+	bus-width = <4>;
+	non-removable;
+	status = "disabled";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -175,6 +186,14 @@
 	status = "okay";
 };
 
+/* On Wifi/BT connector, with RTS/CTS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
 /* On Pi-2 connector */
 &uart2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/sun50i-a64-teres-i.dts b/arch/arm/dts/sun50i-a64-teres-i.dts
index 065b1861633..527bc4b46cd 100644
--- a/arch/arm/dts/sun50i-a64-teres-i.dts
+++ b/arch/arm/dts/sun50i-a64-teres-i.dts
@@ -369,6 +369,8 @@
 &tcon0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_rgb666_pins>;
+	assigned-clocks = <&ccu CLK_TCON0>;
+	assigned-clock-parents = <&ccu CLK_PLL_VIDEO0_2X>;
 
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-a64.dtsi b/arch/arm/dts/sun50i-a64.dtsi
index b6928cc668d..7c978b38f5b 100644
--- a/arch/arm/dts/sun50i-a64.dtsi
+++ b/arch/arm/dts/sun50i-a64.dtsi
@@ -51,10 +51,16 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,10 +68,16 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu2: cpu@2 {
@@ -73,10 +85,16 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu3: cpu@3 {
@@ -84,16 +102,25 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
-			next-level-cache = <&L2>;
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
-		L2: l2-cache {
+		l2_cache: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
@@ -236,6 +263,14 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu0_crit: gpu0-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		gpu1_thermal: gpu1-thermal {
@@ -243,6 +278,14 @@
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu1_crit: gpu1-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
@@ -402,6 +445,8 @@
 			clock-names = "ahb", "tcon-ch0";
 			clock-output-names = "tcon-data-clock";
 			#clock-cells = <0>;
+			assigned-clocks = <&ccu CLK_TCON0>;
+			assigned-clock-parents = <&ccu CLK_PLL_MIPI>;
 			resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
 			reset-names = "lcd", "lvds";
 
diff --git a/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
index b69032c4455..18fa541795a 100644
--- a/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm/dts/sun50i-h5-nanopi-neo-plus2.dts
@@ -45,16 +45,40 @@
 		startup-delay-us = <100000>;
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_vcc3v3>;
+	};
+
+	reg_gmac_2v5: gmac-2v5 {
+		/* 2V5 supply for GMAC PHY IO */
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc3v3>;
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		/* board 5V supply from micro USB or pin headers */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
 	reg_vcc3v3: vcc3v3 {
+		/* board 3V3 supply by SY8089A */
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
 	};
 
 	vdd_cpux: gpio-regulator {
+		/* cpu voltage regulator MP2143DJ */
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-cpux";
 		regulator-type = "voltage";
@@ -66,6 +90,7 @@
 		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
+		vin-supply = <&reg_vcc5v>;
 	};
 
 	wifi_pwrseq: pwrseq {
@@ -111,6 +136,7 @@
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
 	status = "okay";
 };
 
@@ -146,6 +172,18 @@
 	status = "okay";
 };
 
+&pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pd-supply = <&reg_gmac_2v5>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc3v3>;
+};
+
+&r_pio {
+	vcc-pl-supply = <&reg_vcc3v3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;
diff --git a/arch/arm/dts/sun50i-h5-nanopi-neo2.dts b/arch/arm/dts/sun50i-h5-nanopi-neo2.dts
index 05486cccee1..128295f5a5d 100644
--- a/arch/arm/dts/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm/dts/sun50i-h5-nanopi-neo2.dts
@@ -88,6 +88,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
index 3a7ee44708a..44fdc8b3f79 100644
--- a/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm/dts/sun50i-h5-nanopi-r1s-h5.dts
@@ -157,6 +157,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5-orangepi-pc2.dts b/arch/arm/dts/sun50i-h5-orangepi-pc2.dts
index ce3ae19e72d..0f29da7d51e 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-pc2.dts
@@ -153,6 +153,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5-orangepi-prime.dts b/arch/arm/dts/sun50i-h5-orangepi-prime.dts
index b699bb900e1..d4fc4e60e4e 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-prime.dts
@@ -153,6 +153,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts b/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
index ae85131aac9..3322cc4d9aa 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-zero-plus.dts
@@ -82,6 +82,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
index 734481e998b..3eb986c354a 100644
--- a/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm/dts/sun50i-h5-orangepi-zero-plus2.dts
@@ -79,6 +79,7 @@
 
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
+	disable-wp;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
diff --git a/arch/arm/dts/sun50i-h5.dtsi b/arch/arm/dts/sun50i-h5.dtsi
index 9b3462b13cc..14c7c74c4ad 100644
--- a/arch/arm/dts/sun50i-h5.dtsi
+++ b/arch/arm/dts/sun50i-h5.dtsi
@@ -16,7 +16,6 @@
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -26,7 +25,6 @@
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -36,7 +34,6 @@
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 
@@ -46,7 +43,6 @@
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
 		};
 	};
@@ -207,7 +203,7 @@
 			};
 
 			cooling-maps {
-				cpu-hot-limit {
+				map0 {
 					trip = <&cpu_hot_trip>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
diff --git a/arch/arm/dts/sun50i-h6-beelink-gs1.dts b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
index 529285fc34f..6b4b621ef38 100644
--- a/arch/arm/dts/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
@@ -129,6 +129,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -151,28 +152,12 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
-&r_ir {
-	linux,rc-map-name = "rc-beelink-gs1";
-	status = "okay";
-};
-
-&r_pio {
-	/*
-	 * FIXME: We can't add that supply for now since it would
-	 * create a circular dependency between pinctrl, the regulator
-	 * and the RSB Bus.
-	 *
-	 * vcc-pl-supply = <&reg_aldo1>;
-	 */
-	vcc-pm-supply = <&reg_aldo1>;
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -290,6 +275,22 @@
 	};
 };
 
+&r_ir {
+	linux,rc-map-name = "rc-beelink-gs1";
+	status = "okay";
+};
+
+&r_pio {
+	/*
+	 * PL0 and PL1 are used for PMIC I2C
+	 * don't enable the pl-supply else
+	 * it will fail at boot
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+	vcc-pm-supply = <&reg_aldo1>;
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spdif_tx_pin>;
diff --git a/arch/arm/dts/sun50i-h6-orangepi-3.dts b/arch/arm/dts/sun50i-h6-orangepi-3.dts
index bdcec466246..007e74e9604 100644
--- a/arch/arm/dts/sun50i-h6-orangepi-3.dts
+++ b/arch/arm/dts/sun50i-h6-orangepi-3.dts
@@ -131,6 +131,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -143,7 +144,7 @@
 	non-removable;
 	status = "okay";
 
-	brcm: sdio-wifi@1 {
+	brcm: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&r_pio>;
@@ -175,16 +176,12 @@
 	vcc-pg-supply = <&reg_vcc_wifi_io>;
 };
 
-&r_ir {
-	status = "okay";
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -295,6 +292,10 @@
 	};
 };
 
+&r_ir {
+	status = "okay";
+};
+
 &rtc {
 	clocks = <&ext_osc32k>;
 };
diff --git a/arch/arm/dts/sun50i-h6-orangepi-lite2.dts b/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
index a3f65a45bd2..0911c537cc6 100644
--- a/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm/dts/sun50i-h6-orangepi-lite2.dts
@@ -28,7 +28,7 @@
 	non-removable;
 	status = "okay";
 
-	brcm: sdio-wifi@1 {
+	brcm: wifi@1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&r_pio>;
diff --git a/arch/arm/dts/sun50i-h6-orangepi.dtsi b/arch/arm/dts/sun50i-h6-orangepi.dtsi
index 4403769fc36..f69658bde88 100644
--- a/arch/arm/dts/sun50i-h6-orangepi.dtsi
+++ b/arch/arm/dts/sun50i-h6-orangepi.dtsi
@@ -94,6 +94,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
@@ -112,20 +113,12 @@
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
-&r_ir {
-	status = "okay";
-};
-
-&r_pio {
-	vcc-pm-supply = <&reg_bldo3>;
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -240,6 +233,14 @@
 	};
 };
 
+&r_ir {
+	status = "okay";
+};
+
+&r_pio {
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
 &rtc {
 	clocks = <&ext_osc32k>;
 };
diff --git a/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts b/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
index 66fe03910d5..066fbeff8bf 100644
--- a/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
+++ b/arch/arm/dts/sun50i-h6-pine-h64-model-b.dts
@@ -8,7 +8,7 @@
 /delete-node/ &reg_gmac_3v3;
 
 / {
-	model = "Pine H64 model B";
+	model = "Pine64 PINE H64 Model B";
 	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
 
 	wifi_pwrseq: pwrseq {
diff --git a/arch/arm/dts/sun50i-h6-pine-h64.dts b/arch/arm/dts/sun50i-h6-pine-h64.dts
index bfb46572bda..108dad2b072 100644
--- a/arch/arm/dts/sun50i-h6-pine-h64.dts
+++ b/arch/arm/dts/sun50i-h6-pine-h64.dts
@@ -9,7 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64 model A";
+	model = "Pine64 PINE H64 Model A";
 	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
 
 	aliases {
@@ -133,6 +133,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-h6-tanix.dtsi b/arch/arm/dts/sun50i-h6-tanix.dtsi
index 855b7d43bc5..bb7de37c0d5 100644
--- a/arch/arm/dts/sun50i-h6-tanix.dtsi
+++ b/arch/arm/dts/sun50i-h6-tanix.dtsi
@@ -124,6 +124,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/sun50i-h6.dtsi b/arch/arm/dts/sun50i-h6.dtsi
index 82aa5679fc4..6febed20cb4 100644
--- a/arch/arm/dts/sun50i-h6.dtsi
+++ b/arch/arm/dts/sun50i-h6.dtsi
@@ -27,8 +27,14 @@
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu1: cpu@1 {
@@ -37,8 +43,14 @@
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu2: cpu@2 {
@@ -47,8 +59,14 @@
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu3: cpu@3 {
@@ -57,8 +75,23 @@
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
 			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.46.4

