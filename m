Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFE4C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 22:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8023F87D07;
	Thu,  1 Feb 2024 23:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h2cUuZsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E850B87CDB; Thu,  1 Feb 2024 23:27:49 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDB987CA4
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 23:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411MRhLI064115;
 Thu, 1 Feb 2024 16:27:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706826463;
 bh=h491Ubgl7lzXg4OJfdIFkWNeQvW2LL42lyZC3pmkL60=;
 h=From:To:CC:Subject:Date;
 b=h2cUuZsJeWE1Lm17k+YhINoGOl0LGGiVWk8w43AvA3iB5gWP+7GCrBdLD+NhfZeOU
 oMrj+8Cc/BJbn2sVgbSyxz7lZ9E/RzJCPa9afiFoi/ynLjzagvKDotuBmz9esxjbI5
 2PahrPpwpKHmx3zAtwQ35pyU8YPE5di+0DD6Sx8o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411MRhaZ012648
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 16:27:43 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 16:27:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 16:27:43 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411MRgJd076123;
 Thu, 1 Feb 2024 16:27:42 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-am64: Sync with kernel v6.7-rc1
Date: Thu, 1 Feb 2024 16:27:40 -0600
Message-ID: <20240201222741.141074-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

From: Nishanth Menon <nm@ti.com>

Sync with kernel v6.7-rc1 and sync up the u-boot dts files accordingly.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/k3-am64-main.dtsi        |  37 ++++++---
 arch/arm/dts/k3-am64-mcu.dtsi         |   2 +
 arch/arm/dts/k3-am64.dtsi             |   2 +
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 110 --------------------------
 arch/arm/dts/k3-am642-evm.dts         |  37 +++++++++
 arch/arm/dts/k3-am642-r5-evm.dts      |  24 ------
 arch/arm/dts/k3-am642-r5-sk.dts       |  12 ---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  |  98 -----------------------
 arch/arm/dts/k3-am642-sk.dts          |  29 +++++++
 9 files changed, 94 insertions(+), 257 deletions(-)

diff --git a/arch/arm/dts/k3-am64-main.dtsi b/arch/arm/dts/k3-am64-main.dtsi
index 0df54a74182..0be642bc1b8 100644
--- a/arch/arm/dts/k3-am64-main.dtsi
+++ b/arch/arm/dts/k3-am64-main.dtsi
@@ -38,6 +38,7 @@
 	};
 
 	main_conf: syscon@43000000 {
+		bootph-all;
 		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
 		reg = <0x0 0x43000000 0x0 0x20000>;
 		#address-cells = <1>;
@@ -45,6 +46,7 @@
 		ranges = <0x0 0x0 0x43000000 0x20000>;
 
 		chipid@14 {
+			bootph-all;
 			compatible = "ti,am654-chipid";
 			reg = <0x00000014 0x4>;
 		};
@@ -96,7 +98,8 @@
 	};
 
 	dmss: bus@48000000 {
-		compatible = "simple-mfd";
+		bootph-all;
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		dma-ranges;
@@ -105,6 +108,7 @@
 		ti,sci-dev-id = <25>;
 
 		secure_proxy_main: mailbox@4d000000 {
+			bootph-all;
 			compatible = "ti,am654-secure-proxy";
 			#mbox-cells = <1>;
 			reg-names = "target_data", "rt", "scfg";
@@ -188,6 +192,7 @@
 	};
 
 	dmsc: system-controller@44043000 {
+		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
@@ -197,22 +202,26 @@
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
 	};
 
 	main_pmx0: pinctrl@f4000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2d0>;
 		#pinctrl-cells = <1>;
@@ -221,6 +230,7 @@
 	};
 
 	main_timer0: timer@2400000 {
+		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -365,6 +375,7 @@
 	};
 
 	main_esm: esm@420000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
 		ti,esm-pins = <160>, <161>;
@@ -1158,21 +1169,21 @@
 	};
 
 	main_rti0: watchdog@e000000 {
-			compatible = "ti,j7-rti-wdt";
-			reg = <0x00 0xe000000 0x00 0x100>;
-			clocks = <&k3_clks 125 0>;
-			power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
-			assigned-clocks = <&k3_clks 125 0>;
-			assigned-clock-parents = <&k3_clks 125 2>;
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0xe000000 0x00 0x100>;
+		clocks = <&k3_clks 125 0>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 125 0>;
+		assigned-clock-parents = <&k3_clks 125 2>;
 	};
 
 	main_rti1: watchdog@e010000 {
-			compatible = "ti,j7-rti-wdt";
-			reg = <0x00 0xe010000 0x00 0x100>;
-			clocks = <&k3_clks 126 0>;
-			power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
-			assigned-clocks = <&k3_clks 126 0>;
-			assigned-clock-parents = <&k3_clks 126 2>;
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0xe010000 0x00 0x100>;
+		clocks = <&k3_clks 126 0>;
+		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 126 0>;
+		assigned-clock-parents = <&k3_clks 126 2>;
 	};
 
 	icssg0: icssg@30000000 {
diff --git a/arch/arm/dts/k3-am64-mcu.dtsi b/arch/arm/dts/k3-am64-mcu.dtsi
index 686d4979072..b9508072beb 100644
--- a/arch/arm/dts/k3-am64-mcu.dtsi
+++ b/arch/arm/dts/k3-am64-mcu.dtsi
@@ -146,6 +146,7 @@
 	};
 
 	mcu_pmx0: pinctrl@4084000 {
+		bootph-all;
 		compatible = "pinctrl-single";
 		reg = <0x00 0x4084000 0x00 0x84>;
 		#pinctrl-cells = <1>;
@@ -154,6 +155,7 @@
 	};
 
 	mcu_esm: esm@4100000 {
+		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
 		ti,esm-pins = <0>, <1>;
diff --git a/arch/arm/dts/k3-am64.dtsi b/arch/arm/dts/k3-am64.dtsi
index 8e9c2bc70f4..0187c42aed4 100644
--- a/arch/arm/dts/k3-am64.dtsi
+++ b/arch/arm/dts/k3-am64.dtsi
@@ -47,6 +47,7 @@
 	};
 
 	cbass_main: bus@f4000 {
+		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -85,6 +86,7 @@
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
 
 		cbass_mcu: bus@4000000 {
+			bootph-all;
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index b8430782436..a052941e235 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -9,97 +9,27 @@
 	chosen {
 		tick-timer = &main_timer0;
 	};
-
-	memory@80000000 {
-		bootph-all;
-	};
-};
-
-&cbass_main {
-	bootph-all;
 };
 
 &main_timer0 {
-	bootph-all;
 	clock-frequency = <200000000>;
 };
 
-&main_conf {
-	bootph-all;
-	chipid@14 {
-		bootph-all;
-	};
-};
-
-&main_pmx0 {
-	bootph-all;
-};
-
-&main_i2c0_pins_default {
-	bootph-all;
-};
-
-&main_i2c0 {
-	bootph-all;
-};
-
-&main_uart0_pins_default {
-	bootph-all;
-};
-
-&main_uart0 {
-	bootph-all;
-};
-
-&main_usb0_pins_default {
-	bootph-all;
-};
-
 &usb0 {
 	dr_mode="peripheral";
-	bootph-all;
-};
-
-&usbss0 {
-	bootph-all;
 };
 
 &main_mmc1_pins_default {
 	bootph-all;
 };
 
-&main_usb0_pins_default {
-	bootph-all;
-};
-
-&dmss {
-	bootph-all;
-};
-
-&secure_proxy_main {
-	bootph-all;
-};
-
 &dmsc {
-	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
 		bootph-all;
 	};
 };
 
-&k3_pds {
-	bootph-all;
-};
-
-&k3_clks {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
-};
-
 &sdhci0 {
 	bootph-all;
 };
@@ -108,10 +38,6 @@
 	bootph-all;
 };
 
-&sdhci1 {
-	bootph-all;
-};
-
 &inta_main_dmss {
 	bootph-all;
 };
@@ -143,42 +69,6 @@
 	bootph-all;
 };
 
-&mdio1_pins_default {
-	bootph-all;
-};
-
-&cpsw3g_mdio {
-	bootph-all;
-};
-
-&cpsw3g_phy0 {
-	bootph-all;
-};
-
-&rgmii1_pins_default {
-	bootph-all;
-};
-
-&rgmii2_pins_default {
-	bootph-all;
-};
-
-&cpsw3g {
-	bootph-all;
-
-	ethernet-ports {
-		bootph-all;
-	};
-};
-
-&phy_gmii_sel {
-	bootph-all;
-};
-
-&cpsw_port1 {
-	bootph-all;
-};
-
 &cpsw_port2 {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-am642-evm.dts b/arch/arm/dts/k3-am642-evm.dts
index b4a1f73d4fb..4dba1894101 100644
--- a/arch/arm/dts/k3-am642-evm.dts
+++ b/arch/arm/dts/k3-am642-evm.dts
@@ -35,6 +35,7 @@
 	};
 
 	memory@80000000 {
+		bootph-all;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -108,6 +109,7 @@
 
 	evm_12v0: regulator-0 {
 		/* main DC jack */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
 		regulator-min-microvolt = <12000000>;
@@ -129,6 +131,7 @@
 
 	vsys_3v3: regulator-2 {
 		/* output of LM5140 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -140,6 +143,7 @@
 
 	vdd_mmc1: regulator-3 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -161,6 +165,7 @@
 	};
 
 	vtt_supply: regulator-5 {
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vtt";
 		pinctrl-names = "default";
@@ -251,6 +256,7 @@
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -269,6 +275,7 @@
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -276,6 +283,7 @@
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -283,6 +291,7 @@
 	};
 
 	mdio1_pins_default: mdio1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
@@ -290,6 +299,7 @@
 	};
 
 	rgmii1_pins_default: rgmii1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
 			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
@@ -307,6 +317,7 @@
 	};
 
        rgmii2_pins_default: rgmii2-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
 			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
@@ -324,6 +335,7 @@
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
@@ -366,6 +378,7 @@
 	};
 
 	ddr_vtt_pins_default: ddr-vtt-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 		>;
@@ -373,6 +386,7 @@
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -387,11 +401,21 @@
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
+	gpio@38 {
+		/* TCA9554 */
+		compatible = "nxp,pca9554";
+		reg = <0x38>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "HSE_DETECT";
+	};
+
 	eeprom@50 {
 		/* AT24CM01 */
 		compatible = "atmel,24c1024";
@@ -400,12 +424,14 @@
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@22 {
+		bootph-all;
 		compatible = "ti,tca6424";
 		reg = <0x22>;
 		gpio-controller;
@@ -438,6 +464,10 @@
 	};
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
 /* mcu_gpio0 is reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
@@ -467,6 +497,7 @@
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -476,11 +507,13 @@
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
 	pinctrl-names = "default";
@@ -488,11 +521,13 @@
 };
 
 &cpsw3g {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
+	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
@@ -503,11 +538,13 @@
 };
 
 &cpsw3g_mdio {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default>;
 
 	cpsw3g_phy0: ethernet-phy@0 {
+		bootph-all;
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 64b3c3af630..19fc1766b57 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -40,10 +40,6 @@
 	};
 };
 
-&vtt_supply {
-	bootph-pre-ram;
-};
-
 &cbass_main {
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
@@ -53,18 +49,6 @@
 	};
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
-&cbass_mcu {
-	bootph-pre-ram;
-};
-
-&mcu_esm {
-	bootph-pre-ram;
-};
-
 &dmsc {
 	mboxes= <&secure_proxy_main 0>,
 		<&secure_proxy_main 1>,
@@ -74,10 +58,6 @@
 	ti,secure-host;
 };
 
-&vtt_supply {
-	bootph-pre-ram;
-};
-
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
 };
@@ -92,10 +72,6 @@
 	clock-names = "clk_xin";
 };
 
-&main_gpio0 {
-	bootph-pre-ram;
-};
-
 /* UART is initialized before SYSFW is started
  * so we can't do any power-domain/clock operations.
  * Delete clock/power-domain properties to avoid
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index daa483a7811..6032a6f8fef 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -49,18 +49,6 @@
 	};
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
-&cbass_mcu {
-	bootph-pre-ram;
-};
-
-&mcu_esm {
-	bootph-pre-ram;
-};
-
 &dmsc {
 	mboxes= <&secure_proxy_main 0>,
 		<&secure_proxy_main 1>,
diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 2eb227c1d00..818867df8d9 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -9,87 +9,21 @@
 	chosen {
 		tick-timer = &main_timer0;
 	};
-
-	memory@80000000 {
-		bootph-all;
-	};
-};
-
-&cbass_main{
-	bootph-all;
 };
 
 &main_timer0 {
-	bootph-all;
 	clock-frequency = <200000000>;
 };
 
-&main_conf {
-	bootph-all;
-	chipid@14 {
-		bootph-all;
-	};
-};
-
-&main_pmx0 {
-	bootph-all;
-};
-
-&main_i2c0_pins_default {
-	bootph-all;
-};
-
-&main_i2c0 {
-	bootph-all;
-};
-
-&main_uart0_pins_default {
-	bootph-all;
-};
-
-&main_uart0 {
-	bootph-all;
-};
-
-&dmss {
-	bootph-all;
-};
-
-&secure_proxy_main {
-	bootph-all;
-};
-
 &dmsc {
-	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
 		bootph-all;
 	};
 };
 
-&k3_pds {
-	bootph-all;
-};
-
-&k3_clks {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
-};
-
 &sdhci0 {
 	status = "disabled";
-	bootph-all;
-};
-
-&sdhci1 {
-	bootph-all;
-};
-
-&main_mmc1_pins_default {
-	bootph-all;
 };
 
 &inta_main_dmss {
@@ -179,35 +113,3 @@
 &cpsw3g_phy1 {
 	bootph-all;
 };
-
-&main_usb0_pins_default {
-	bootph-all;
-};
-
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
-&usbss0 {
-	bootph-all;
-};
-
-&usb0 {
-	bootph-all;
-};
-
-&serdes_wiz0 {
-	bootph-all;
-};
-
-&serdes0_usb_link {
-	bootph-all;
-};
-
-&serdes0 {
-	bootph-all;
-};
-
-&serdes_refclk {
-	bootph-all;
-};
diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index 722fd285a34..f29c8a9b59b 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -34,6 +34,7 @@
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -107,6 +108,7 @@
 
 	vusb_main: regulator-0 {
 		/* USB MAIN INPUT 5V DC */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vusb_main5v0";
 		regulator-min-microvolt = <5000000>;
@@ -117,6 +119,7 @@
 
 	vcc_3v3_sys: regulator-1 {
 		/* output of LP8733xx */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
 		regulator-min-microvolt = <3300000>;
@@ -128,6 +131,7 @@
 
 	vdd_mmc1: regulator-2 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -234,6 +238,7 @@
 
 &main_pmx0 {
 	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x029c, PIN_INPUT_PULLUP, 0) /* (C20) MMC1_SDWP */
 			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0) /* (D19) MMC1_SDCD */
@@ -248,6 +253,7 @@
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -257,6 +263,7 @@
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0248, PIN_INPUT, 0) /* (D16) UART1_CTSn */
 			AM64X_IOPAD(0x024c, PIN_OUTPUT, 0) /* (E16) UART1_RTSn */
@@ -266,12 +273,14 @@
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -279,6 +288,7 @@
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -367,6 +377,7 @@
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -375,12 +386,14 @@
 
 &main_uart1 {
 	/* main_uart1 is reserved for firmware usage */
+	bootph-pre-ram;
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -393,12 +406,14 @@
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@70 {
+		bootph-all;
 		compatible = "nxp,pca9538";
 		reg = <0x70>;
 		gpio-controller;
@@ -445,6 +460,7 @@
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -454,11 +470,22 @@
 };
 
 &serdes_ln_ctrl {
+	bootph-all;
 	idle-states = <AM64_SERDES0_LANE0_USB>;
 };
 
+&serdes_refclk {
+	bootph-all;
+};
+
+&serdes_wiz0 {
+	bootph-all;
+};
+
 &serdes0 {
+	bootph-all;
 	serdes0_usb_link: phy@0 {
+		bootph-all;
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -468,10 +495,12 @@
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "host";
 	maximum-speed = "super-speed";
 	pinctrl-names = "default";
-- 
2.39.2

