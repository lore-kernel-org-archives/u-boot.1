Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D80C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 03:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE748722C;
	Wed, 15 Nov 2023 04:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ogppzdb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340748729D; Wed, 15 Nov 2023 04:29:14 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9A1871E9
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3T2uG045189;
 Tue, 14 Nov 2023 21:29:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700018942;
 bh=FIYLZPHK9+XDYAPAZCncUln6Lre3i+RsAxiUixyK3tQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ogppzdb/6jc02L1MvtEy6c9mHymX/rolRCdrt9nd7pr3oPrJ0ppptbqsF1fDpiYSz
 HifJL08WbuPJ/d6v/Gez0Gq+2LYaTBC6HZol76HBBVC4KjOkDJgrJ2lC7WPPkqBxuw
 BDn2e/z/CQu3B+6RkzENLjwqQYz7TKXz64/2jGlM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF3T2er009464
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 21:29:02 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 21:29:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 21:29:02 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3T29N021923;
 Tue, 14 Nov 2023 21:29:02 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>,
 Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/4] arm: dts: k3-am625*: Sync with kernel v6.7-rc1
Date: Tue, 14 Nov 2023 21:28:54 -0600
Message-ID: <20231115032857.3071474-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231115032857.3071474-1-nm@ti.com>
References: <20231115032857.3071474-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Sync with kernel v6.7-rc1 and sync up the u-boot dts files accordingly.

Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since v1:
- just tested-by tag.

V1: https://lore.kernel.org/r/20231113145919.1928812-2-nm@ti.com

 arch/arm/dts/k3-am62-main.dtsi        |  12 ++-
 arch/arm/dts/k3-am62-mcu.dtsi         |   2 +
 arch/arm/dts/k3-am62-verdin-wifi.dtsi |   6 ++
 arch/arm/dts/k3-am62-verdin.dtsi      |   1 +
 arch/arm/dts/k3-am62-wakeup.dtsi      |   2 +
 arch/arm/dts/k3-am62.dtsi             |   3 +
 arch/arm/dts/k3-am625-beagleplay.dts  |  34 +++++++-
 arch/arm/dts/k3-am625-sk.dts          |  27 +++++++
 arch/arm/dts/k3-am62x-sk-common.dtsi  | 109 +++++++++++++++++++++++++-
 9 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/k3-am62-main.dtsi b/arch/arm/dts/k3-am62-main.dtsi
index 284b90c94da8..e5c64c86d1d5 100644
--- a/arch/arm/dts/k3-am62-main.dtsi
+++ b/arch/arm/dts/k3-am62-main.dtsi
@@ -81,7 +81,8 @@
 	};
 
 	dmss: bus@48000000 {
-		compatible = "simple-mfd";
+		bootph-all;
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
@@ -90,6 +91,7 @@
 		ti,sci-dev-id = <25>;
 
 		secure_proxy_main: mailbox@4d000000 {
+			bootph-all;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
@@ -165,6 +167,7 @@
 	};
 
 	dmsc: system-controller@44043000 {
+		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
@@ -174,16 +177,19 @@
 		reg = <0x00 0x44043000 0x00 0xfe0>;
 
 		k3_pds: power-controller {
+			bootph-all;
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
 		};
 
 		k3_clks: clock-controller {
+			bootph-all;
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
 		};
 
 		k3_reset: reset-controller {
+			bootph-all;
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
 		};
@@ -202,6 +208,7 @@
 	};
 
 	secure_proxy_sa3: mailbox@43600000 {
+		bootph-pre-ram;
 		compatible = "ti,am654-secure-proxy";
 		#mbox-cells = <1>;
 		reg-names = "target_data", "rt", "scfg";
@@ -217,6 +224,7 @@
 	};
 
 	main_pmx0: pinctrl@f4000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2ac>;
 		#pinctrl-cells = <1>;
@@ -225,12 +233,14 @@
 	};
 
 	main_esm: esm@420000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
 		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
 	};
 
 	main_timer0: timer@2400000 {
+		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/dts/k3-am62-mcu.dtsi b/arch/arm/dts/k3-am62-mcu.dtsi
index 80a3e1db26a9..0e0b234581c6 100644
--- a/arch/arm/dts/k3-am62-mcu.dtsi
+++ b/arch/arm/dts/k3-am62-mcu.dtsi
@@ -7,6 +7,7 @@
 
 &cbass_mcu {
 	mcu_pmx0: pinctrl@4084000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0x04084000 0x00 0x88>;
 		#pinctrl-cells = <1>;
@@ -15,6 +16,7 @@
 	};
 
 	mcu_esm: esm@4100000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
 		ti,esm-pins = <0>, <1>, <2>, <85>;
diff --git a/arch/arm/dts/k3-am62-verdin-wifi.dtsi b/arch/arm/dts/k3-am62-verdin-wifi.dtsi
index 90ddc71bcd30..a6808b10c7b2 100644
--- a/arch/arm/dts/k3-am62-verdin-wifi.dtsi
+++ b/arch/arm/dts/k3-am62-verdin-wifi.dtsi
@@ -35,5 +35,11 @@
 &main_uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+		fw-init-baudrate = <3000000>;
+	};
 };
diff --git a/arch/arm/dts/k3-am62-verdin.dtsi b/arch/arm/dts/k3-am62-verdin.dtsi
index 40992e7e4c30..5db52f237253 100644
--- a/arch/arm/dts/k3-am62-verdin.dtsi
+++ b/arch/arm/dts/k3-am62-verdin.dtsi
@@ -1061,6 +1061,7 @@
 		vddc-supply = <&reg_1v2_dsi>;
 		vddmipi-supply = <&reg_1v2_dsi>;
 		vddio-supply = <&reg_1v8_dsi>;
+		status = "disabled";
 
 		dsi_bridge_ports: ports {
 			#address-cells = <1>;
diff --git a/arch/arm/dts/k3-am62-wakeup.dtsi b/arch/arm/dts/k3-am62-wakeup.dtsi
index eae052887186..fef76f52a52e 100644
--- a/arch/arm/dts/k3-am62-wakeup.dtsi
+++ b/arch/arm/dts/k3-am62-wakeup.dtsi
@@ -7,6 +7,7 @@
 
 &cbass_wakeup {
 	wkup_conf: syscon@43000000 {
+		bootph-all;
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x43000000 0x00 0x20000>;
 		#address-cells = <1>;
@@ -14,6 +15,7 @@
 		ranges = <0x0 0x00 0x43000000 0x20000>;
 
 		chipid: chipid@14 {
+			bootph-all;
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
 		};
diff --git a/arch/arm/dts/k3-am62.dtsi b/arch/arm/dts/k3-am62.dtsi
index 11f14eef2d44..f1e15206e1ce 100644
--- a/arch/arm/dts/k3-am62.dtsi
+++ b/arch/arm/dts/k3-am62.dtsi
@@ -47,6 +47,7 @@
 	};
 
 	cbass_main: bus@f0000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -86,6 +87,7 @@
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 
 		cbass_mcu: bus@4000000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -93,6 +95,7 @@
 		};
 
 		cbass_wakeup: bus@b00000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
diff --git a/arch/arm/dts/k3-am625-beagleplay.dts b/arch/arm/dts/k3-am625-beagleplay.dts
index 7cfdf562b53b..9a6bd0a3c94f 100644
--- a/arch/arm/dts/k3-am625-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-beagleplay.dts
@@ -46,6 +46,7 @@
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -58,7 +59,7 @@
 
 		ramoops: ramoops@9ca00000 {
 			compatible = "ramoops";
-			reg = <0x00 0x9c700000 0x00 0x00100000>;
+			reg = <0x00 0x9ca00000 0x00 0x00100000>;
 			record-size = <0x8000>;
 			console-size = <0x8000>;
 			ftrace-size = <0x00>;
@@ -83,6 +84,7 @@
 	};
 
 	vsys_5v0: regulator-1 {
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -93,6 +95,7 @@
 
 	vdd_3v3: regulator-2 {
 		/* output of TLV62595DMQR-U12 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -118,6 +121,7 @@
 
 	vdd_3v3_sd: regulator-4 {
 		/* output of TPS22918DBVR-U21 */
+		bootph-all;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
 
@@ -132,6 +136,7 @@
 	};
 
 	vdd_sd_dv: regulator-5 {
+		bootph-all;
 		compatible = "regulator-gpio";
 		regulator-name = "sd_hs200_switch";
 		pinctrl-names = "default";
@@ -146,9 +151,11 @@
 	};
 
 	leds {
+		bootph-all;
 		compatible = "gpio-leds";
 
 		led-0 {
+			bootph-all;
 			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			function = LED_FUNCTION_HEARTBEAT;
@@ -156,6 +163,7 @@
 		};
 
 		led-1 {
+			bootph-all;
 			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "disk-activity";
 			function = LED_FUNCTION_DISK_ACTIVITY;
@@ -163,16 +171,19 @@
 		};
 
 		led-2 {
+			bootph-all;
 			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_CPU;
 		};
 
 		led-3 {
+			bootph-all;
 			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_LAN;
 		};
 
 		led-4 {
+			bootph-all;
 			gpios = <&main_gpio0 9 GPIO_ACTIVE_HIGH>;
 			function = LED_FUNCTION_WLAN;
 		};
@@ -245,6 +256,7 @@
 
 &main_pmx0 {
 	gpio0_pins_default: gpio0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0004, PIN_INPUT, 7) /* (G25) OSPI0_LBCLKO.GPIO0_1 */
 			AM62X_IOPAD(0x0008, PIN_INPUT, 7) /* (J24) OSPI0_DQS.GPIO0_2 */
@@ -264,6 +276,7 @@
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0244, PIN_OUTPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
 		>;
@@ -283,6 +296,7 @@
 	};
 
 	local_i2c_pins_default: local-i2c-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
 			AM62X_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
@@ -321,6 +335,7 @@
 	};
 
 	emmc_pins_default: emmc-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
 			AM62X_IOPAD(0x0218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
@@ -336,12 +351,14 @@
 	};
 
 	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c4, PIN_INPUT, 7) /* (B14) SPI0_D1_GPIO1_19 */
 		>;
 	};
 
 	sd_pins_default: sd-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
 			AM62X_IOPAD(0x0234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
@@ -418,6 +435,7 @@
 	};
 
 	mikrobus_gpio_pins_default: mikrobus-gpio-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x019c, PIN_INPUT, 7) /* (B18) MCASP0_AXR1.GPIO1_9 */
 			AM62X_IOPAD(0x01a0, PIN_INPUT, 7) /* (E18) MCASP0_AXR0.GPIO1_10 */
@@ -426,6 +444,7 @@
 	};
 
 	console_pins_default: console-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
 			AM62X_IOPAD(0x01cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
@@ -597,6 +616,7 @@
 };
 
 &main_gpio0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio0_pins_default>;
 	gpio-line-names = "BL_EN_3V3", "SPE_PO_EN", "RTC_INT",	/* 0-2 */
@@ -616,6 +636,7 @@
 };
 
 &main_gpio1 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mikrobus_gpio_pins_default>;
 	gpio-line-names = "", "", "", "", "",			/* 0-4 */
@@ -633,6 +654,7 @@
 };
 
 &main_i2c0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&local_i2c_pins_default>;
 	clock-frequency = <400000>;
@@ -651,6 +673,7 @@
 	};
 
 	tps65219: pmic@30 {
+		bootph-all;
 		compatible = "ti,tps65219";
 		reg = <0x30>;
 		buck1-supply = <&vsys_5v0>;
@@ -801,6 +824,7 @@
 };
 
 &sdhci0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
 	ti,driver-strength-ohm = <50>;
@@ -810,6 +834,7 @@
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd_pins_default>;
 
@@ -850,6 +875,7 @@
 };
 
 &main_uart0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&console_pins_default>;
 	status = "okay";
@@ -870,6 +896,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	mcu {
+		compatible = "ti,cc1352p7";
+		reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
+		vdds-supply = <&vdd_3v3>;
+	};
 };
 
 &dss {
diff --git a/arch/arm/dts/k3-am625-sk.dts b/arch/arm/dts/k3-am625-sk.dts
index 7c98c1b855d1..b18092497c9a 100644
--- a/arch/arm/dts/k3-am625-sk.dts
+++ b/arch/arm/dts/k3-am625-sk.dts
@@ -31,6 +31,7 @@
 
 	vmain_pd: regulator-0 {
 		/* TPS65988 PD CONTROLLER OUTPUT */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vmain_pd";
 		regulator-min-microvolt = <5000000>;
@@ -41,6 +42,7 @@
 
 	vcc_5v0: regulator-1 {
 		/* Output of LM34936 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -52,6 +54,7 @@
 
 	vcc_3v3_sys: regulator-2 {
 		/* output of LM61460-Q1 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -63,6 +66,7 @@
 
 	vdd_mmc1: regulator-3 {
 		/* TPS22918DBVR */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -75,6 +79,7 @@
 
 	vdd_sd_dv: regulator-4 {
 		/* Output of TLV71033 */
+		bootph-all;
 		compatible = "regulator-gpio";
 		regulator-name = "tlv71033";
 		pinctrl-names = "default";
@@ -102,6 +107,7 @@
 
 &main_pmx0 {
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
 			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
@@ -119,6 +125,7 @@
 	};
 
 	ospi0_pins_default: ospi0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
 			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
@@ -135,20 +142,32 @@
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &main_i2c1 {
+	bootph-all;
 	exp1: gpio@22 {
+		bootph-all;
 		compatible = "ti,tca6424";
 		reg = <0x22>;
 		gpio-controller;
@@ -207,12 +226,18 @@
 	};
 };
 
+&fss {
+	bootph-all;
+};
+
 &ospi0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
 	flash@0 {
+		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -225,6 +250,7 @@
 		cdns,read-delay = <4>;
 
 		partitions {
+			bootph-all;
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -260,6 +286,7 @@
 			};
 
 			partition@3fc0000 {
+				bootph-pre-ram;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
 			};
diff --git a/arch/arm/dts/k3-am62x-sk-common.dtsi b/arch/arm/dts/k3-am62x-sk-common.dtsi
index 34c8ffc553ec..19f57ead4ebd 100644
--- a/arch/arm/dts/k3-am62x-sk-common.dtsi
+++ b/arch/arm/dts/k3-am62x-sk-common.dtsi
@@ -28,6 +28,7 @@
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -114,11 +115,23 @@
 			clocks = <&tlv320_mclk>;
 		};
 	};
+
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
 			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
@@ -126,6 +139,7 @@
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19/B18) MCASP0_AXR3.UART1_CTSn */
 			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19/B17) MCASP0_AXR2.UART1_RTSn */
@@ -156,6 +170,7 @@
 	};
 
 	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
 			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
@@ -171,6 +186,7 @@
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
 			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
@@ -196,6 +212,7 @@
 	};
 
 	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17/W15) RGMII1_RD0 */
 			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17/Y16) RGMII1_RD1 */
@@ -226,10 +243,44 @@
 			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23/K20) GPMC0_ADVN_ALE.MCASP1_AXR2 */
 		>;
 	};
+
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x05c, PIN_OUTPUT, 1) /* (R24) GPMC0_AD8.VOUT0_DATA16 */
+			AM62X_IOPAD(0x060, PIN_OUTPUT, 1) /* (R25) GPMC0_AD9.VOUT0_DATA17 */
+			AM62X_IOPAD(0x064, PIN_OUTPUT, 1) /* (T25) GPMC0_AD10.VOUT0_DATA18 */
+			AM62X_IOPAD(0x068, PIN_OUTPUT, 1) /* (R21) GPMC0_AD11.VOUT0_DATA19 */
+			AM62X_IOPAD(0x06c, PIN_OUTPUT, 1) /* (T22) GPMC0_AD12.VOUT0_DATA20 */
+			AM62X_IOPAD(0x070, PIN_OUTPUT, 1) /* (T24) GPMC0_AD13.VOUT0_DATA21 */
+			AM62X_IOPAD(0x074, PIN_OUTPUT, 1) /* (U25) GPMC0_AD14.VOUT0_DATA22 */
+			AM62X_IOPAD(0x078, PIN_OUTPUT, 1) /* (U24) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
 };
 
 &mcu_pmx0 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0) /* (C6/A7) WKUP_UART0_CTSn */
 			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0) /* (A4/B4) WKUP_UART0_RTSn */
@@ -241,12 +292,14 @@
 
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -254,6 +307,7 @@
 
 &main_uart1 {
 	/* Main UART1 is used by TIFS firmware */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
@@ -300,7 +354,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	tlv320aic3106: audio-codec@1b {
 		#sound-dai-cells = <0>;
@@ -313,9 +367,40 @@
 		IOVDD-supply = <&vcc_3v3_sys>;
 		DRVDD-supply = <&vcc_3v3_sys>;
 	};
+
+	sii9022: bridge-hdmi@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+		sil,i2s-data-lanes = < 0 >;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
@@ -325,6 +410,7 @@
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
@@ -333,21 +419,25 @@
 };
 
 &cpsw3g {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
 };
 
 &cpsw_port1 {
+	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
 
 &cpsw3g_mdio {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mdio1_pins_default>;
 
 	cpsw3g_phy0: ethernet-phy@0 {
+		bootph-all;
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
@@ -410,3 +500,20 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+};
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
-- 
2.40.0

