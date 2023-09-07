Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C995EC8743
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 17:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B54869F7;
	Thu,  7 Sep 2023 19:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ox+g/znE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D30869F1; Thu,  7 Sep 2023 16:14:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BCFE86A02
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EEfGr008751;
 Thu, 7 Sep 2023 09:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694096081;
 bh=PV2aiyRWA8HPsuZy2uksXcwOAyBG+WltB80/JrqAuac=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ox+g/znEH7zT+CpJLEbfRKq1fWDQt6yCjCkhme4tCbBiLpvHJK0E/zJxFzwEKlcTk
 u0aoNTjJ1mDgHteb2CZ/CfMxfwyB6KEiXZu5ABzU5P7symTVAlmvbi3hRlCEVzj+fy
 2l2N7at7+VMIpbD9qdUiQHBVYJmjUr5bc50abnmw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EEfKj027391
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 09:14:41 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:14:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:14:40 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EE70l046139;
 Thu, 7 Sep 2023 09:14:37 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 7/7] arm: dts: k3-j721e: Sync with v6.5-rc1
Date: Thu, 7 Sep 2023 19:44:07 +0530
Message-ID: <20230907141407.382215-8-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907141407.382215-1-n-francis@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 07 Sep 2023 19:09:23 +0200
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

Sync k3-j721e DTS with kernel.org v6.5-rc1.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../k3-j721e-common-proc-board-u-boot.dtsi    | 146 +--
 arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
 arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
 .../arm/dts/k3-j721e-r5-common-proc-board.dts | 302 +-----
 arch/arm/dts/k3-j721e-r5-sk.dts               | 522 +---------
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 177 +---
 arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
 arch/arm/dts/k3-j721e-som-p0.dtsi             | 226 ++--
 arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
 arch/arm/dts/k3-j721e.dtsi                    |  32 +-
 11 files changed, 2365 insertions(+), 1515 deletions(-)
 create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi

diff --git a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
index 540c847eb3..4cca01be61 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-common-proc-board-u-boot.dtsi
@@ -7,15 +7,7 @@
 #include "k3-j721e-binman.dtsi"
 
 / {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
 	aliases {
-		ethernet0 = &cpsw_port1;
-		spi0 = &ospi0;
-		spi1 = &ospi1;
 		remoteproc0 = &mcu_r5fss0_core0;
 		remoteproc1 = &mcu_r5fss0_core1;
 		remoteproc2 = &main_r5fss0_core0;
@@ -25,61 +17,49 @@
 		remoteproc6 = &c66_0;
 		remoteproc7 = &c66_1;
 		remoteproc8 = &c71_0;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &mcu_i2c1;
-		i2c3 = &main_i2c0;
 	};
 };
 
-&cbass_main{
+&cbass_main {
 	bootph-pre-ram;
+};
 
-	main_navss: bus@30000000 {
-		bootph-pre-ram;
-	};
+&main_navss {
+	bootph-pre-ram;
 };
 
 &cbass_mcu_wakeup {
 	bootph-pre-ram;
 
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <250000000>;
+	chipid@43000014 {
 		bootph-pre-ram;
 	};
+};
 
-	mcu_navss: bus@28380000 {
-		bootph-pre-ram;
+&mcu_navss {
+	bootph-pre-ram;
+};
 
-		ringacc@2b800000 {
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>,
-				<0x0 0x28440000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			bootph-pre-ram;
-		};
-
-		dma-controller@285c0000 {
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x284c0000 0x0 0x4000>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x284a0000 0x0 0x4000>,
-				<0x0 0x2aa00000 0x0 0x40000>,
-				<0x0 0x28400000 0x0 0x2000>;
-			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-					    "tchanrt", "rflow";
-			bootph-pre-ram;
-		};
-	};
+&mcu_ringacc {
+	reg =	<0x0 0x2b800000 0x0 0x400000>,
+		<0x0 0x2b000000 0x0 0x400000>,
+		<0x0 0x28590000 0x0 0x100>,
+		<0x0 0x2a500000 0x0 0x40000>,
+		<0x0 0x28440000 0x0 0x40000>;
+	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+	bootph-pre-ram;
+};
 
-	chipid@43000014 {
-		bootph-pre-ram;
-	};
+&mcu_udmap {
+	reg =	<0x0 0x285c0000 0x0 0x100>,
+		<0x0 0x284c0000 0x0 0x4000>,
+		<0x0 0x2a800000 0x0 0x40000>,
+		<0x0 0x284a0000 0x0 0x4000>,
+		<0x0 0x2aa00000 0x0 0x40000>,
+		<0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+		    "tchanrt", "rflow";
+	bootph-pre-ram;
 };
 
 &secure_proxy_main {
@@ -130,9 +110,16 @@
 	bootph-pre-ram;
 };
 
-&wiz3_pll1_refclk {
-	assigned-clocks = <&wiz3_pll1_refclk>, <&wiz3_pll0_refclk>;
-	assigned-clock-parents = <&k3_clks 295 0>, <&k3_clks 295 9>;
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&mcu_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&main_uart0_pins_default {
+	bootph-pre-ram;
 };
 
 &main_usbss0_pins_default {
@@ -148,19 +135,6 @@
 	bootph-pre-ram;
 };
 
-&mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x2>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
-
-	cpsw-phy-sel@40f04040 {
-		compatible = "ti,am654-cpsw-phy-sel";
-		reg= <0x0 0x40f04040 0x0 0x4>;
-		reg-names = "gmii-sel";
-	};
-};
-
 &main_mmc1_pins_default {
 	bootph-pre-ram;
 };
@@ -169,8 +143,14 @@
 	bootph-pre-ram;
 };
 
+&wkup_uart0 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
 &wkup_i2c0 {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &main_i2c0 {
@@ -181,6 +161,10 @@
 	bootph-pre-ram;
 };
 
+&main_esm {
+	bootph-pre-ram;
+};
+
 &exp2 {
 	bootph-pre-ram;
 };
@@ -194,11 +178,7 @@
 };
 
 &hbmc {
-	bootph-pre-ram;
-
-	flash@0,0 {
-		bootph-pre-ram;
-	};
+	status = "disabled";
 };
 
 &hbmc_mux {
@@ -244,31 +224,3 @@
 &main_r5fss1 {
 	ti,cluster-mode = <0>;
 };
-
-&wiz3_pll1_refclk {
-	assigned-clocks = <&wiz3_pll1_refclk>, <&wiz3_pll0_refclk>;
-	assigned-clock-parents = <&k3_clks 295 0>, <&k3_clks 295 9>;
-};
-
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
-&usb_serdes_mux {
-	u-boot,mux-autoprobe;
-};
-
-&serdes0 {
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-};
-
-&serdes0_pcie_link {
-	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
-	assigned-clock-parents = <&wiz0_pll1_refclk>;
-};
-
-&serdes0_qsgmii_link {
-	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
-	assigned-clock-parents = <&wiz0_pll1_refclk>;
-};
diff --git a/arch/arm/dts/k3-j721e-common-proc-board.dts b/arch/arm/dts/k3-j721e-common-proc-board.dts
index 1b600547c0..c1cbbae761 100644
--- a/arch/arm/dts/k3-j721e-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-common-proc-board.dts
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Product Link: https://www.ti.com/tool/J721EXCPXEVM
  */
 
 /dts-v1/;
@@ -12,24 +14,38 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 / {
+	compatible = "ti,j721e-evm", "ti,j721e";
+	model = "Texas Instruments J721e EVM";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial6 = &main_uart4;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 		pinctrl-names = "default";
-		pinctrl-0 = <&sw10_button_pins_default &sw11_button_pins_default>;
+		pinctrl-0 = <&sw10_button_pins_default>, <&sw11_button_pins_default>;
 
-		sw10: sw10 {
+		sw10: switch-10 {
 			label = "GPIO Key USER1";
 			linux,code = <BTN_0>;
 			gpios = <&main_gpio0 0 GPIO_ACTIVE_LOW>;
 		};
 
-		sw11: sw11 {
+		sw11: switch-11 {
 			label = "GPIO Key USER2";
 			linux,code = <BTN_1>;
 			gpios = <&wkup_gpio0 7 GPIO_ACTIVE_LOW>;
@@ -93,7 +109,7 @@
 			 <3300000 0x1>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound-0 {
 		compatible = "ti,j721e-cpb-audio";
 		model = "j721e-cpb";
 
@@ -109,16 +125,104 @@
 			      "cpb-codec-scki",
 			      "cpb-codec-scki-48000", "cpb-codec-scki-44100";
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 54 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&wkup_gpio0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp2 7 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&exp2 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
+		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
+	};
+
+	dp_pwr_3v3: regulator-dp-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "dp-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>; /* P0 - DP0_PWR_SW_EN */
+		enable-active-high;
+	};
+
+	dp0: connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp_pwr_3v3>;
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
-	sw10_button_pins_default: sw10-button-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1d4, PIN_INPUT, 1) /* (Y3) SPI1_CS0.UART0_CTSn */
+			J721E_IOPAD(0x1c0, PIN_OUTPUT, 1) /* (AA2) SPI0_CS0.UART0_RTSn */
+			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
+			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1f8, PIN_INPUT, 0) /* (AA4) UART1_RXD */
+			J721E_IOPAD(0x1fc, PIN_OUTPUT, 0) /* (AB4) UART1_TXD */
+		>;
+	};
+
+	main_uart2_pins_default: main-uart2-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_INPUT, 3) /* (Y1) SPI1_CLK.UART2_RXD */
+			J721E_IOPAD(0x1e0, PIN_OUTPUT, 3) /* (Y5) SPI1_D0.UART2_TXD */
+		>;
+	};
+
+	main_uart4_pins_default: main-uart4-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x190, PIN_INPUT, 1) /* (W23) RGMII6_TD3.UART4_RXD */
+			J721E_IOPAD(0x194, PIN_OUTPUT, 1) /* (W28) RGMII6_TD2.UART4_TXD */
+		>;
+	};
+
+	sw10_button_pins_default: sw10-button-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x0, PIN_INPUT, 7) /* (AC18) EXTINTn.GPIO0_0 */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
 			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
@@ -132,60 +236,66 @@
 		>;
 	};
 
-	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-pins-default {
+	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1d8, PIN_INPUT, 7) /* (W4) SPI1_CS1.GPIO0_117 */
 		>;
 	};
 
-	main_usbss0_pins_default: main-usbss0-pins-default {
+	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
 			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
 	};
 
-	main_usbss1_pins_default: main-usbss1-pins-default {
+	main_usbss1_pins_default: main-usbss1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
 	};
 
-	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
+	dp0_pins_default: dp0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
+		>;
+	};
+
+	main_i2c1_exp4_pins_default: main-i2c1-exp4-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
 		>;
 	};
 
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
 			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
 			J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
 		>;
 	};
 
-	main_i2c3_pins_default: main-i2c3-pins-default {
+	main_i2c3_pins_default: main-i2c3-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
 			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
 		>;
 	};
 
-	main_i2c6_pins_default: main-i2c6-pins-default {
+	main_i2c6_pins_default: main-i2c6-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
 			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
 		>;
 	};
 
-	mcasp10_pins_default: mcasp10-pins-default {
+	mcasp10_pins_default: mcasp10-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x158, PIN_OUTPUT_PULLDOWN, 12) /* (U23) RGMII5_TX_CTL.MCASP10_ACLKX */
 			J721E_IOPAD(0x15c, PIN_OUTPUT_PULLDOWN, 12) /* (U26) RGMII5_RX_CTL.MCASP10_AFSX */
@@ -199,27 +309,57 @@
 		>;
 	};
 
-	audi_ext_refclk2_pins_default: audi-ext-refclk2-pins-default {
+	audi_ext_refclk2_pins_default: audi-ext-refclk2-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1a4, PIN_OUTPUT, 3) /* (W26) RGMII6_RXC.AUDIO_EXT_REFCLK2 */
 		>;
 	};
+
+	main_mcan0_pins_default: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x208, PIN_INPUT, 0) /* (W5) MCAN0_RX */
+			J721E_IOPAD(0x20c, PIN_OUTPUT, 0) /* (W6) MCAN0_TX */
+		>;
+	};
+
+	main_mcan2_pins_default: main-mcan2-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x01f0, PIN_INPUT, 3) /* (AC2) MCAN2_RX.GPIO0_123 */
+			J721E_IOPAD(0x01f4, PIN_OUTPUT, 3) /* (AB1) MCAN2_TX.GPIO0_124 */
+		>;
+	};
+
+	main_mcan2_gpio_pins_default: main-mcan2-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x200, PIN_INPUT, 7) /* (AC4) UART1_CTSn.GPIO0_127 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
-	sw11_button_pins_default: sw11-button-pins-default {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xcc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
+			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
 		>;
 	};
 
-	wkup_gpio_pins_default: wkup-gpio-pins-default {
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_8 */
+			J721E_WKUP_IOPAD(0xe8, PIN_INPUT, 0) /* (H29) WKUP_GPIO0_14.MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xec, PIN_OUTPUT, 0) /* (J27) WKUP_GPIO0_15.MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0) /* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
 	};
 
-	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
+	sw11_button_pins_default: sw11-button-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xcc, PIN_INPUT, 7) /* (G28) WKUP_GPIO0_7 */
+		>;
+	};
+
+	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x34, PIN_OUTPUT, 0) /* (F22) MCU_OSPI1_CLK */
 			J721E_WKUP_IOPAD(0x50, PIN_OUTPUT, 0) /* (C22) MCU_OSPI1_CSn0 */
@@ -232,7 +372,7 @@
 		>;
 	};
 
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0058, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
 			J721E_WKUP_IOPAD(0x005c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
@@ -249,51 +389,84 @@
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+	mcu_mdio_pins_default: mcu-mdio1-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x008c, PIN_OUTPUT, 0) /* MCU_MDIO0_MDC */
 			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xac, PIN_INPUT, 0) /* (C29) MCU_MCAN0_RX */
+			J721E_WKUP_IOPAD(0xa8, PIN_OUTPUT, 0) /* (D29) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 7) /* (F26) WKUP_GPIO0_0 */
+			J721E_WKUP_IOPAD(0x98, PIN_INPUT, 7) /* (E28) MCU_SPI0_D1.WKUP_GPIO0_54 */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xc4, PIN_INPUT, 0) /* (G24) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721E_WKUP_IOPAD(0xc0, PIN_OUTPUT, 0) /* (G25) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* (F28) WKUP_GPIO0_2 */
+		>;
+	};
+
+	wkup_gpio_pins_default: wkup-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* (C14) WKUP_GPIO0_8 */
+		>;
+	};
 };
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
-&main_uart0 {
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-};
-
-&main_uart3 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart5 {
-	/* UART not brought out */
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
-&main_uart6 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	/* Shared with ATF on this platform */
+	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
-&main_uart7 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
-&main_uart8 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart2_pins_default>;
 };
 
-&main_uart9 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart4_pins_default>;
 };
 
 &main_gpio2 {
@@ -320,6 +493,11 @@
 	status = "disabled";
 };
 
+&wkup_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_gpio_pins_default>;
+};
+
 &wkup_gpio1 {
 	status = "disabled";
 };
@@ -351,7 +529,7 @@
 };
 
 &serdes_ln_ctrl {
-	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_QSGMII_LANE2>,
+	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
 		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
 		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
 		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
@@ -387,11 +565,6 @@
 	phy-names = "cdns3,usb3-phy";
 };
 
-&wkup_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_gpio_pins_default>;
-};
-
 &usbss1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss1_pins_default>;
@@ -407,7 +580,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
@@ -418,8 +591,52 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "qspi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "qspi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "qspi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "qspi.env";
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "qspi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@6c0000 {
+				label = "qspi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "qspi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fe0000 {
+				label = "qspi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+			};
+		};
 	};
 };
 
@@ -436,6 +653,7 @@
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -472,6 +690,7 @@
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
@@ -497,6 +716,7 @@
 };
 
 &main_i2c3 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c3_pins_default>;
 	clock-frequency = <400000>;
@@ -535,6 +755,7 @@
 };
 
 &main_i2c6 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c6_pins_default>;
 	clock-frequency = <400000>;
@@ -549,7 +770,7 @@
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
@@ -585,47 +806,35 @@
 				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
 };
 
-&mcasp0 {
-	status = "disabled";
-};
-
-&mcasp1 {
-	status = "disabled";
-};
-
-&mcasp2 {
-	status = "disabled";
-};
-
-&mcasp3 {
-	status = "disabled";
-};
-
-&mcasp4 {
-	status = "disabled";
-};
-
-&mcasp5 {
-	status = "disabled";
-};
-
-&mcasp6 {
-	status = "disabled";
+&dss_ports {
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
 };
 
-&mcasp7 {
-	status = "disabled";
-};
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-&mcasp8 {
-	status = "disabled";
-};
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
 
-&mcasp9 {
-	status = "disabled";
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp_connector_in>;
+		};
+	};
 };
 
 &mcasp10 {
+	status = "okay";
 	#sound-dai-cells = <0>;
 
 	pinctrl-names = "default";
@@ -643,10 +852,6 @@
 	rx-num-evt = <0>;
 };
 
-&mcasp11 {
-	status = "disabled";
-};
-
 &cmn_refclk1 {
 	clock-frequency = <100000000>;
 };
@@ -682,8 +887,8 @@
 };
 
 &serdes0 {
-	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
-	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
+	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
+	assigned-clock-parents = <&wiz0_pll1_refclk>;
 
 	serdes0_pcie_link: phy@0 {
 		reg = <0>;
@@ -692,14 +897,6 @@
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>;
 	};
-
-	serdes0_qsgmii_link: phy@1 {
-		reg = <1>;
-		cdns,num-lanes = <1>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_QSGMII>;
-		resets = <&serdes_wiz0 2>;
-	};
 };
 
 &serdes1 {
@@ -728,7 +925,26 @@
 	};
 };
 
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+};
+
 &pcie0_rc {
+	status = "okay";
 	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
@@ -736,6 +952,7 @@
 };
 
 &pcie1_rc {
+	status = "okay";
 	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
@@ -743,49 +960,37 @@
 };
 
 &pcie2_rc {
+	status = "okay";
 	reset-gpios = <&exp2 20 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes2_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
 };
 
-&pcie0_ep {
-	phys = <&serdes0_pcie_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <1>;
-	status = "disabled";
-};
-
-&pcie1_ep {
-	phys = <&serdes1_pcie_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <2>;
-	status = "disabled";
-};
-
-&pcie2_ep {
-	phys = <&serdes2_pcie_link>;
-	phy-names = "pcie-phy";
-	num-lanes = <2>;
-	status = "disabled";
-};
-
-&pcie3_rc {
-	status = "disabled";
-};
-
-&pcie3_ep {
-	status = "disabled";
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
 };
 
-&dss {
-	status = "disabled";
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
+&main_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver3>;
 };
 
-&icssg1_mdio {
-	status = "disabled";
+&main_mcan2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan2_pins_default>;
+	phys = <&transceiver4>;
 };
diff --git a/arch/arm/dts/k3-j721e-main.dtsi b/arch/arm/dts/k3-j721e-main.dtsi
index cf3482376c..2ded1ee1a8 100644
--- a/arch/arm/dts/k3-j721e-main.dtsi
+++ b/arch/arm/dts/k3-j721e-main.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/mux/ti-serdes.h>
 
@@ -42,7 +43,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		serdes_ln_ctrl: mux@4080 {
+		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
@@ -60,12 +61,85 @@
 				      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j721e-cpsw9g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <2>, <2>;
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+		};
+
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
 					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
-	    };
+		};
+
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -76,7 +150,10 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
-		      <0x00 0x01900000 0x00 0x100000>;	/* GICR */
+		      <0x00 0x01900000 0x00 0x100000>,	/* GICR */
+		      <0x00 0x6f000000 0x00 0x2000>,	/* GICC */
+		      <0x00 0x6f010000 0x00 0x1000>,	/* GICH */
+		      <0x00 0x6f020000 0x00 0x2000>;	/* GICV */
 
 		/* vcpumntirq: virtual CPU interface maintenance interrupt */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -172,6 +249,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -181,6 +259,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -190,6 +269,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -199,6 +279,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -208,6 +289,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -217,6 +299,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -226,6 +309,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -235,6 +319,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -244,6 +329,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -253,6 +339,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -262,6 +349,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -271,6 +359,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
@@ -322,6 +411,115 @@
 		};
 	};
 
+	cpsw0: ethernet@c000000 {
+		compatible = "ti,j721e-cpswxg-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0xc000000 0x0 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0x0c000000 0x0 0x200000>;
+		clocks = <&k3_clks 19 89>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 19 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cpsw0_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				status = "disabled";
+			};
+
+			cpsw0_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+				status = "disabled";
+			};
+
+			cpsw0_port3: port@3 {
+				reg = <3>;
+				ti,mac-only;
+				label = "port3";
+				status = "disabled";
+			};
+
+			cpsw0_port4: port@4 {
+				reg = <4>;
+				ti,mac-only;
+				label = "port4";
+				status = "disabled";
+			};
+
+			cpsw0_port5: port@5 {
+				reg = <5>;
+				ti,mac-only;
+				label = "port5";
+				status = "disabled";
+			};
+
+			cpsw0_port6: port@6 {
+				reg = <6>;
+				ti,mac-only;
+				label = "port6";
+				status = "disabled";
+			};
+
+			cpsw0_port7: port@7 {
+				reg = <7>;
+				ti,mac-only;
+				label = "port7";
+				status = "disabled";
+			};
+
+			cpsw0_port8: port@8 {
+				reg = <8>;
+				ti,mac-only;
+				label = "port8";
+				status = "disabled";
+			};
+		};
+
+		cpsw9g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x0 0xf00 0x0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 19 89>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x0 0x3d000 0x0 0x400>;
+			clocks = <&k3_clks 19 16>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_crypto: crypto@4e00000 {
 		compatible = "ti,j721e-sa2ul";
 		reg = <0x0 0x4e00000 0x0 0x1200>;
@@ -333,13 +531,11 @@
 		dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>,
 				<&main_udmap 0x4001>;
 		dma-names = "tx", "rx1", "rx2";
-		dma-coherent;
 
 		rng: rng@4e10000 {
 			compatible = "inside-secure,safexcel-eip76";
 			reg = <0x0 0x4e10000 0x0 0x7d>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&k3_clks 264 1>;
 		};
 	};
 
@@ -352,6 +548,24 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	/* TIMERIO pad input CTRLMMR_TIMER*_CTRL registers */
+	main_timerio_input: pinctrl@104200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104200 0x00 0x50>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x00000007>;
+	};
+
+	/* TIMERIO pad output CTCTRLMMR_TIMERIO*_CTRL registers */
+	main_timerio_output: pinctrl@104280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x104280 0x00 0x20>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000001f>;
+	};
+
 	serdes_wiz0: wiz@5000000 {
 		compatible = "ti,j721e-wiz-16g";
 		#address-cells = <1>;
@@ -610,7 +824,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
@@ -618,26 +832,7 @@
 		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-	};
-
-	pcie0_ep: pcie-ep@2900000 {
-		compatible = "ti,j721e-pcie-ep";
-		reg = <0x00 0x02900000 0x00 0x1000>,
-		      <0x00 0x02907000 0x00 0x400>,
-		      <0x00 0x0d000000 0x00 0x00800000>,
-		      <0x00 0x10000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 239 1>;
-		clock-names = "fck";
-		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
-		dma-coherent;
+		status = "disabled";
 	};
 
 	pcie1_rc: pcie@2910000 {
@@ -658,7 +853,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x10000 0x10000>;
@@ -666,26 +861,7 @@
 		ranges = <0x01000000 0x0 0x18001000 0x0 0x18001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x18011000 0x0 0x18011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-	};
-
-	pcie1_ep: pcie-ep@2910000 {
-		compatible = "ti,j721e-pcie-ep";
-		reg = <0x00 0x02910000 0x00 0x1000>,
-		      <0x00 0x02917000 0x00 0x400>,
-		      <0x00 0x0d800000 0x00 0x00800000>,
-		      <0x00 0x18000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 240 1>;
-		clock-names = "fck";
-		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
-		dma-coherent;
+		status = "disabled";
 	};
 
 	pcie2_rc: pcie@2920000 {
@@ -706,7 +882,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x20000 0x10000>;
@@ -714,26 +890,7 @@
 		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
-	};
-
-	pcie2_ep: pcie-ep@2920000 {
-		compatible = "ti,j721e-pcie-ep";
-		reg = <0x00 0x02920000 0x00 0x1000>,
-		      <0x00 0x02927000 0x00 0x400>,
-		      <0x00 0x0e000000 0x00 0x00800000>,
-		      <0x44 0x00000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 241 1>;
-		clock-names = "fck";
-		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
-		dma-coherent;
+		status = "disabled";
 	};
 
 	pcie3_rc: pcie@2930000 {
@@ -754,7 +911,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00d>;
 		msi-map = <0x0 &gic_its 0x30000 0x10000>;
@@ -762,28 +919,288 @@
 		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
-	pcie3_ep: pcie-ep@2930000 {
-		compatible = "ti,j721e-pcie-ep";
-		reg = <0x00 0x02930000 0x00 0x1000>,
-		      <0x00 0x02937000 0x00 0x400>,
-		      <0x00 0x0e800000 0x00 0x00800000>,
-		      <0x44 0x10000000 0x00 0x08000000>;
-		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
-		interrupt-names = "link_state";
-		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
-		max-link-speed = <3>;
-		num-lanes = <2>;
-		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 242 1>;
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,am64-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 297 1>, <&k3_clks 297 9>, <&cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 297 9>;
+		assigned-clock-parents = <&k3_clks 297 10>;
+		assigned-clock-rates = <19200000>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05050000 0x00 0x05050000 0x010000>,
+			<0x0a030a00 0x00 0x0a030a00 0x40>;
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05050000 0x010000>,
+			      <0x0a030a00 0x40>; /* DPTX PHY */
+			reg-names = "torrent_phy", "dptx_phy";
+
+			resets = <&serdes_wiz4 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>;
+			clock-names = "refclk";
+			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 297 9>,
+						 <&k3_clks 297 9>,
+						 <&k3_clks 297 9>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 49 1>;
 		clock-names = "fck";
-		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
-		dma-coherent;
-		#address-cells = <2>;
-		#size-cells = <2>;
+		assigned-clocks = <&k3_clks 49 1>;
+		assigned-clock-parents = <&k3_clks 49 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 50 1>, <&k3_clks 327 0>;
+		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 327 1>;
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 51 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 51 1>;
+		assigned-clock-parents = <&k3_clks 51 2>;
+		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 52 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 52 1>, <&k3_clks 328 0>;
+		assigned-clock-parents = <&k3_clks 52 2>, <&k3_clks 328 1>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 53 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 53 1>;
+		assigned-clock-parents = <&k3_clks 53 2>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 54 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 54 1>, <&k3_clks 329 0>;
+		assigned-clock-parents = <&k3_clks 54 2>, <&k3_clks 329 1>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 55 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 55 1>;
+		assigned-clock-parents = <&k3_clks 55 2>;
+		power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 57 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 57 1>, <&k3_clks 330 0>;
+		assigned-clock-parents = <&k3_clks 57 2>, <&k3_clks 330 1>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 58 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 58 1>;
+		assigned-clock-parents = <&k3_clks 58 2>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 59 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 59 1>, <&k3_clks 331 0>;
+		assigned-clock-parents = <&k3_clks 59 2>, <&k3_clks 331 1>;
+		power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 60 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 60 1>;
+		assigned-clock-parents = <&k3_clks 60 2>;
+		power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 62 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 62 1>, <&k3_clks 332 0>;
+		assigned-clock-parents = <&k3_clks 62 2>, <&k3_clks 332 1>;
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 63 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 63 1>;
+		assigned-clock-parents = <&k3_clks 63 2>;
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 64 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 64 1>, <&k3_clks 333 0>;
+		assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 333 1>;
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 65 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 65 1>;
+		assigned-clock-parents = <&k3_clks 65 2>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 66 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 66 1>, <&k3_clks 334 0>;
+		assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 334 1>;
+		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 67 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 67 1>;
+		assigned-clock-parents = <&k3_clks 67 2>;
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 68 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 68 1>, <&k3_clks 335 0>;
+		assigned-clock-parents = <&k3_clks 68 2>, <&k3_clks 335 1>;
+		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 69 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 69 1>;
+		assigned-clock-parents = <&k3_clks 69 2>;
+		power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 70 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 70 1>, <&k3_clks 336 0>;
+		assigned-clock-parents = <&k3_clks 70 2>, <&k3_clks 336 1>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
 	};
 
 	main_uart0: serial@2800000 {
@@ -795,6 +1212,7 @@
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -806,6 +1224,7 @@
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -817,6 +1236,7 @@
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -828,6 +1248,7 @@
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -839,6 +1260,7 @@
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -850,6 +1272,7 @@
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -861,6 +1284,7 @@
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -872,6 +1296,7 @@
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -883,6 +1308,7 @@
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -894,6 +1320,7 @@
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_gpio0: gpio@600000 {
@@ -1040,8 +1467,8 @@
 		bus-width = <8>;
 		mmc-hs200-1_8v;
 		mmc-ddr-1_8v;
-		ti,otap-del-sel-legacy = <0xf>;
-		ti,otap-del-sel-mmc-hs = <0xf>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x6>;
 		ti,otap-del-sel-hs400 = <0x0>;
@@ -1049,7 +1476,6 @@
 		ti,itap-del-sel-mmc-hs = <0xa>;
 		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
-		ti,strobe-sel = <0x77>;
 		dma-coherent;
 	};
 
@@ -1063,11 +1489,12 @@
 		assigned-clocks = <&k3_clks 92 0>;
 		assigned-clock-parents = <&k3_clks 92 1>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0xf>;
+		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
 		ti,itap-del-sel-legacy = <0x0>;
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
@@ -1089,11 +1516,12 @@
 		assigned-clocks = <&k3_clks 93 0>;
 		assigned-clock-parents = <&k3_clks 93 1>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0xf>;
+		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
 		ti,itap-del-sel-legacy = <0x0>;
 		ti,itap-del-sel-sd-hs = <0x0>;
 		ti,itap-del-sel-sdr12 = <0x0>;
@@ -1174,6 +1602,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 187 0>;
 		power-domains = <&k3_pds 187 TI_SCI_PD_SHARED>;
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@2010000 {
@@ -1185,6 +1614,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 188 0>;
 		power-domains = <&k3_pds 188 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -1196,6 +1626,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 189 0>;
 		power-domains = <&k3_pds 189 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -1207,6 +1638,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 190 0>;
 		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c4: i2c@2040000 {
@@ -1218,6 +1650,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 191 0>;
 		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c5: i2c@2050000 {
@@ -1229,6 +1662,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 192 0>;
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c6: i2c@2060000 {
@@ -1240,6 +1674,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 193 0>;
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	ufs_wrapper: ufs-wrapper@4e80000 {
@@ -1264,6 +1699,37 @@
 		};
 	};
 
+	mhdp: dp-bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+		/*
+		 * Note: we do not map DPTX PHY area, as that is handled by
+		 * the PHY driver.
+		 */
+		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
+		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
+		reg-names = "mhdptx", "j721e-intg";
+
+		clocks = <&k3_clks 151 36>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+
+		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+			    reg = <0>;
+			};
+
+			port@4 {
+			    reg = <4>;
+			};
+		};
+	};
+
 	dss: dss@4a00000 {
 		compatible = "ti,j721e-dss";
 		reg =
@@ -1314,8 +1780,6 @@
 				  "common_s2";
 
 		dss_ports: ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
 		};
 	};
 
@@ -1334,6 +1798,7 @@
 		clocks = <&k3_clks 174 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -1351,6 +1816,7 @@
 		clocks = <&k3_clks 175 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 175 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -1368,6 +1834,7 @@
 		clocks = <&k3_clks 176 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 176 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp3: mcasp@2b30000 {
@@ -1385,6 +1852,7 @@
 		clocks = <&k3_clks 177 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 177 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp4: mcasp@2b40000 {
@@ -1402,6 +1870,7 @@
 		clocks = <&k3_clks 178 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp5: mcasp@2b50000 {
@@ -1419,6 +1888,7 @@
 		clocks = <&k3_clks 179 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp6: mcasp@2b60000 {
@@ -1436,6 +1906,7 @@
 		clocks = <&k3_clks 180 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 180 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp7: mcasp@2b70000 {
@@ -1453,6 +1924,7 @@
 		clocks = <&k3_clks 181 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp8: mcasp@2b80000 {
@@ -1470,6 +1942,7 @@
 		clocks = <&k3_clks 182 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp9: mcasp@2b90000 {
@@ -1487,6 +1960,7 @@
 		clocks = <&k3_clks 183 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 183 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp10: mcasp@2ba0000 {
@@ -1504,6 +1978,7 @@
 		clocks = <&k3_clks 184 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcasp11: mcasp@2bb0000 {
@@ -1521,6 +1996,7 @@
 		clocks = <&k3_clks 185 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	watchdog0: watchdog@2200000 {
@@ -1797,6 +2273,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1938,6 +2415,311 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
-		};
+			status = "disabled";
+		};
+	};
+
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 156 0>, <&k3_clks 156 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 158 0>, <&k3_clks 158 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 160 0>, <&k3_clks 160 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 161 0>, <&k3_clks 161 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 162 0>, <&k3_clks 162 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 163 0>, <&k3_clks 163 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 164 0>, <&k3_clks 164 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 165 0>, <&k3_clks 165 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 166 0>, <&k3_clks 166 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 167 0>, <&k3_clks 167 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 168 0>, <&k3_clks 168 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 169 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 169 0>, <&k3_clks 169 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 170 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 170 0>, <&k3_clks 170 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 171 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 171 0>, <&k3_clks 171 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 266 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 267 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 268 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 269 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 270 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 271 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 272 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 273 1>;
+		status = "disabled";
+	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x700000 0x0 0x1000>;
+		ti,esm-pins = <344>, <345>;
 	};
 };
diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
index 22166c7942..ea5b9e1044 100644
--- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
@@ -12,8 +12,8 @@
 
 		mbox-names = "rx", "tx";
 
-		mboxes= <&secure_proxy_main 11>,
-			<&secure_proxy_main 13>;
+		mboxes = <&secure_proxy_main 11>,
+			 <&secure_proxy_main 13>;
 
 		reg-names = "debug_messages";
 		reg = <0x00 0x44083000 0x0 0x1000>;
@@ -62,6 +62,28 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
+	mcu_timerio_input: pinctrl@40f04200 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04200 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	/* MCU_TIMERIO pad output CTRLMMR_MCU_TIMERIO*_CTRL registers */
+	mcu_timerio_output: pinctrl@40f04280 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x40f04280 0x00 0x28>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x0000000f>;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
 	mcu_ram: sram@41c00000 {
 		compatible = "mmio-sram";
 		reg = <0x00 0x41c00000 0x00 0x100000>;
@@ -70,6 +92,145 @@
 		#size-cells = <1>;
 	};
 
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 1>;
+		assigned-clock-parents = <&k3_clks 35 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 71 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 71 1>, <&k3_clks 322 0>;
+		assigned-clock-parents = <&k3_clks 71 2>, <&k3_clks 322 1>;
+		power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 72 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 72 1>;
+		assigned-clock-parents = <&k3_clks 72 2>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 73 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 73 1>, <&k3_clks 323 0>;
+		assigned-clock-parents = <&k3_clks 73 2>, <&k3_clks 323 1>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 74 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 74 1>;
+		assigned-clock-parents = <&k3_clks 74 2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 75 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 75 1>, <&k3_clks 324 0>;
+		assigned-clock-parents = <&k3_clks 75 2>, <&k3_clks 324 1>;
+		power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 76 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 76 1>;
+		assigned-clock-parents = <&k3_clks 76 2>;
+		power-domains = <&k3_pds 76 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 77 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 77 1>, <&k3_clks 325 0>;
+		assigned-clock-parents = <&k3_clks 77 2>, <&k3_clks 325 1>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 78 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 78 1>;
+		assigned-clock-parents = <&k3_clks 78 2>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 79 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 79 1>, <&k3_clks 326 0>;
+		assigned-clock-parents = <&k3_clks 79 2>, <&k3_clks 326 1>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x100>;
@@ -79,6 +240,7 @@
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -90,6 +252,7 @@
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	wkup_gpio_intr: interrupt-controller@42200000 {
@@ -145,6 +308,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 194 0>;
 		power-domains = <&k3_pds 194 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@40b10000 {
@@ -156,6 +320,7 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 195 0>;
 		power-domains = <&k3_pds 195 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
@@ -167,31 +332,35 @@
 		clock-names = "fck";
 		clocks = <&k3_clks 197 0>;
 		power-domains = <&k3_pds 197 TI_SCI_PD_SHARED>;
+		status = "disabled";
 	};
 
 	fss: fss@47000000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "simple-bus";
 		reg = <0x0 0x47000000 0x0 0x100>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		hbmc_mux: hbmc-mux {
-			compatible = "mmio-mux";
+		hbmc_mux: mux-controller@47000004 {
+			compatible = "reg-mux";
+			reg = <0x00 0x47000004 0x00 0x2>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4 0x2>; /* HBMC select */
 		};
 
 		hbmc: hyperbus@47034000 {
-			compatible = "ti,j721e-hbmc", "ti,am654-hbmc";
-			reg = <0x0 0x47034000 0x0 0x100>,
-				<0x5 0x00000000 0x1 0x0000000>;
+			compatible = "ti,am654-hbmc";
+			reg = <0x00 0x47034000 0x00 0x100>,
+				<0x05 0x00000000 0x01 0x0000000>;
 			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+			clocks = <&k3_clks 102 0>;
+			assigned-clocks = <&k3_clks 102 5>;
+			assigned-clock-rates = <333333333>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			mux-controls = <&hbmc_mux 0>;
-			assigned-clocks = <&k3_clks 102 0>;
-			assigned-clock-rates = <250000000>;
+			status = "disabled";
 		};
 
 		ospi0: spi@47040000 {
@@ -234,7 +403,7 @@
 		clocks = <&k3_clks 0 1>;
 		assigned-clocks = <&k3_clks 0 3>;
 		assigned-clock-rates = <60000000>;
-		clock-names = "adc_tsc_fck";
+		clock-names = "fck";
 		dmas = <&main_udmap 0x7400>,
 			<&main_udmap 0x7401>;
 		dma-names = "fifo0", "fifo1";
@@ -253,7 +422,7 @@
 		clocks = <&k3_clks 1 1>;
 		assigned-clocks = <&k3_clks 1 3>;
 		assigned-clock-rates = <60000000>;
-		clock-names = "adc_tsc_fck";
+		clock-names = "fck";
 		dmas = <&main_udmap 0x7402>,
 			<&main_udmap 0x7403>;
 		dma-names = "fifo0", "fifo1";
@@ -309,6 +478,21 @@
 		};
 	};
 
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x2a480000 0x0 0x80000>,
+		      <0x0 0x2a380000 0x0 0x80000>,
+		      <0x0 0x2a400000 0x0 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_cpsw: ethernet@46000000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		#address-cells = <2>;
@@ -408,4 +592,76 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 172 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 172 0>, <&k3_clks 172 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 173 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 173 0>, <&k3_clks 173 1>;
+		clock-names = "hclk", "cclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
+	};
+
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 274 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 275 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 276 0>;
+		status = "disabled";
+	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j721e-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>,
+		      <0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index 7bb5ce775c..0452e94b6d 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -12,16 +12,15 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 / {
+	chosen {
+		tick-timer = &mcu_timer0;
+	};
+
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
 	};
 
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
 	a72_0: a72@0 {
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
@@ -38,223 +37,55 @@
 		bootph-pre-ram;
 	};
 
-	clk_200mhz: dummy_clock_200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-
-	clk_19_2mhz: dummy_clock_19_2mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <19200000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_mcu_wakeup {
-	mcu_secproxy: secproxy@28380000 {
-		bootph-pre-ram;
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-	};
-
-	sysctrler: sysctrler {
-		bootph-pre-ram;
-		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
-		mbox-names = "tx", "rx";
-	};
-
-	wkup_vtm0: wkup_vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
-
 	dm_tifs: dm-tifs {
 		compatible = "ti,j721e-dm-sci";
 		ti,host-id = <3>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&mcu_secproxy 21>,
-			<&mcu_secproxy 23>;
+		mboxes= <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
 		bootph-pre-ram;
 	};
 };
 
-&cbass_main {
-	main_esm: esm@700000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x700000 0x0 0x1000>;
-		ti,esm-pins = <344>, <345>;
-		bootph-pre-ram;
-	};
+&mcu_timer0 {
+	status = "okay";
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
 };
 
 &dmsc {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
+	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
 };
 
-&wkup_pmx0 {
-	wkup_uart0_pins_default: wkup_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
-			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
-		>;
-	};
-
-	mcu_uart0_pins_default: mcu_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xe8, PIN_INPUT, 0) /* (H29) WKUP_GPIO0_14.MCU_UART0_CTSn */
-			J721E_WKUP_IOPAD(0xec, PIN_OUTPUT, 0) /* (J27) WKUP_GPIO0_15.MCU_UART0_RTSn */
-			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
-			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0) /* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
-		>;
-	};
-
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
-			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
-		>;
-	};
-
-	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (E20) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
-			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C21) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
-			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (F19) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
-			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* (E22) MCU_OSPI1_CSn1.MCU_HYPERBUS0_CSn1 */
-			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (E19) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
-			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (D21) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
-			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D20) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
-			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (G19) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
-			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (G20) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
-			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (F20) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
-			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (F21) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
-			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (E21) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
-			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (B22) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
-			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (G21) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
-		>;
-	};
-
-	wkup_gpio_pins_default: wkup-gpio-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* WKUP_GPIO0_8 */
-		>;
-	};
-
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
-			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
-			J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
-			J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
-			J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
-			J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
-			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
-			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
-			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
-			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
-			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
-		>;
-	};
-
-	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x34, PIN_OUTPUT, 0) /* (F22) MCU_OSPI1_CLK */
-			J721E_WKUP_IOPAD(0x50, PIN_OUTPUT, 0) /* (C22) MCU_OSPI1_CSn0 */
-			J721E_WKUP_IOPAD(0x40, PIN_INPUT, 0) /* (D22) MCU_OSPI1_D0 */
-			J721E_WKUP_IOPAD(0x44, PIN_INPUT, 0) /* (G22) MCU_OSPI1_D1 */
-			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (D23) MCU_OSPI1_D2 */
-			J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 0) /* (C23) MCU_OSPI1_D3 */
-			J721E_WKUP_IOPAD(0x3c, PIN_INPUT, 0) /* (B23) MCU_OSPI1_DQS */
-			J721E_WKUP_IOPAD(0x38, PIN_INPUT, 0) /* (A23) MCU_OSPI1_LBCLKO */
-		>;
-	};
-};
-
-&main_pmx0 {
-	main_uart0_pins_default: main_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x1d4, PIN_INPUT, 1) /* (Y3) SPI1_CS0.UART0_CTSn */
-			J721E_IOPAD(0x1c0, PIN_OUTPUT, 1) /* (AA2) SPI0_CS0.UART0_RTSn */
-			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
-			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
-			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
-		>;
-	};
-};
-
-&wkup_uart0 {
+&secure_proxy_mcu {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
 	status = "okay";
 };
 
-&wkup_gpio0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_gpio_pins_default>;
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		bootph-pre-ram;
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
+		mbox-names = "tx", "rx";
+	};
 };
 
 &mcu_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
-	status = "okay";
 	clock-frequency = <48000000>;
 };
 
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-};
-
 &main_sdhci0 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
-	non-removable;
+	clock-frequency = <200000000>;
 	bus-width = <8>;
 };
 
 &main_sdhci1 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
+	clock-frequency = <19200000>;
 };
 
 &wkup_i2c0 {
@@ -293,96 +124,35 @@
 };
 
 &usbss0 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clocks = <&clk_19_2mhz>;
-	clock-names = "ref";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss0_pins_default>;
-	ti,vbus-divider;
-};
-
-&main_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
-	exp1: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	exp2: gpio@22 {
-		compatible = "ti,tca6424";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
+	clock-frequency = <19200000>;
 };
 
 &hbmc {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
 	reg = <0x0 0x47040000 0x0 0x100>,
 		<0x0 0x50000000 0x0 0x8000000>;
 	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>, /* 64MB Flash on CS0 */
 		 <0x1 0x0 0x0 0x54000000 0x800000>; /* 8MB flash on CS1 */
-
-	flash@0,0 {
-		compatible = "cypress,hyperflash", "cfi-flash";
-		reg = <0x0 0x0 0x4000000>;
-	};
 };
 
 &ospi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-
 	reg = <0x0 0x47040000 0x0 0x100>,
 	      <0x0 0x50000000 0x0 0x8000000>;
 
 	flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
 		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <8>;
 		spi-max-frequency = <50000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
 };
 
 &ospi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
-	bootph-pre-ram;
-
 	reg = <0x0 0x47050000 0x0 0x100>,
 	      <0x0 0x58000000 0x0 0x8000000>;
 
 	flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-		spi-max-frequency = <40000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		bootph-pre-ram;
 	};
 };
 
@@ -393,31 +163,3 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
-
-&wiz0_pll1_refclk {
-	assigned-clocks = <&wiz0_pll1_refclk>;
-	assigned-clock-parents = <&cmn_refclk1>;
-};
-
-&wiz0_refclk_dig {
-	assigned-clocks = <&wiz0_refclk_dig>;
-	assigned-clock-parents = <&cmn_refclk1>;
-};
-
-&serdes0 {
-	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
-	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
-
-	serdes0_qsgmii_link: phy@1 {
-		reg = <1>;
-		cdns,num-lanes = <1>;
-		#phy-cells = <0>;
-		cdns,phy-type = <PHY_TYPE_QSGMII>;
-		resets = <&serdes_wiz0 2>;
-	};
-};
-
-/* EEPROM might be read before SYSFW is available */
-&wkup_i2c0 {
-	/delete-property/ power-domains;
-};
diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
index 1cc64d07f7..f5eb29a861 100644
--- a/arch/arm/dts/k3-j721e-r5-sk.dts
+++ b/arch/arm/dts/k3-j721e-r5-sk.dts
@@ -11,151 +11,13 @@
 #include "k3-j721e-sk-u-boot.dtsi"
 
 / {
-	model = "Texas Instruments J721E SK R5";
+	chosen {
+		tick-timer = &mcu_timer0;
+	};
 
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
-		remoteproc2 = &main_r5fss0_core0;
-		remoteproc3 = &main_r5fss0_core1;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		/* 4G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
-		      <0x00000008 0x80000000 0x00000000 0x80000000>;
-	};
-
-	reserved_memory: reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		secure_ddr: optee@9e800000 {
-			reg = <0x00 0x9e800000 0x00 0x01800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_0_memory_region: c66-memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_1_memory_region: c66-memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: c71-memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@aa000000 {
-			reg = <0x00 0xaa000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	a72_0: a72@0 {
@@ -174,196 +36,50 @@
 		bootph-pre-ram;
 	};
 
-	clk_200mhz: dummy_clock_200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-
-	clk_19_2mhz: dummy_clock_19_2mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <19200000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_mcu_wakeup {
-	mcu_secproxy: secproxy@28380000 {
-		bootph-pre-ram;
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-	};
-
-	sysctrler: sysctrler {
-		bootph-pre-ram;
-		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>;
-		mbox-names = "tx", "rx";
-	};
-
-	wkup_vtm0: wkup_vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
-
 	dm_tifs: dm-tifs {
 		compatible = "ti,j721e-dm-sci";
 		ti,host-id = <3>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&mcu_secproxy 21>,
-				<&mcu_secproxy 23>;
+		mboxes= <&secure_proxy_mcu 21>,
+				<&secure_proxy_mcu 23>;
 		bootph-pre-ram;
 	};
 };
 
-&cbass_main {
-	main_esm: esm@700000 {
-		compatible = "ti,j721e-esm";
-		reg = <0x0 0x700000 0x0 0x1000>;
-		ti,esm-pins = <344>, <345>;
-		bootph-pre-ram;
-	};
+&mcu_timer0 {
+	status = "okay";
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
 };
 
-&dmsc {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
-	mbox-names = "tx", "rx", "notify";
-	ti,host-id = <4>;
-	ti,secure-host;
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	status = "okay";
 };
 
-&wkup_pmx0 {
-	wkup_uart0_pins_default: wkup_uart0_pins_default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
-			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
-		>;
-	};
-
-	mcu_uart0_pins_default: mcu_uart0_pins_default {
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
 		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf0, PIN_INPUT, 2) /* (D26) MCU_I3C0_SCL.MCU_UART0_CTSn */
-			J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
-			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
-			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
-		>;
-	};
-
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
-			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
-		>;
-	};
-
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 0) /* (E20) MCU_OSPI0_CLK */
-			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 0) /* (F19) MCU_OSPI0_CSn0 */
-			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 0) /* (D20) MCU_OSPI0_D0 */
-			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 0) /* (G19) MCU_OSPI0_D1 */
-			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 0) /* (G20) MCU_OSPI0_D2 */
-			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D3 */
-			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 0) /* (F21) MCU_OSPI0_D4 */
-			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 0) /* (E21) MCU_OSPI0_D5 */
-			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 0) /* (B22) MCU_OSPI0_D6 */
-			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 0) /* (G21) MCU_OSPI0_D7 */
-			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 0) /* (D21) MCU_OSPI0_DQS */
-		>;
-	};
-};
-
-&main_pmx0 {
-	main_usbss1_pins_default: main-usbss1-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
-		>;
-	};
-
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
-			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
-			J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
-		>;
-	};
-
-	main_i2c2_pins_default: main-i2c2-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x158, PIN_INPUT_PULLUP, 2) /* (U23) RGMII5_TX_CTL.I2C2_SCL */
-			J721E_IOPAD(0x15c, PIN_INPUT_PULLUP, 2) /* (U26) RGMII5_RX_CTL.I2C2_SDA */
-		>;
-	};
-
-	main_i2c3_pins_default: main-i2c3-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
-			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
-		>;
-	};
-
-	main_i2c5_pins_default: main-i2c5-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
-			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
-		>;
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
+		mbox-names = "tx", "rx";
 	};
 };
 
-&wkup_uart0 {
-	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
-	status = "okay";
+&dmsc {
+	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
+	mbox-names = "tx", "rx", "notify";
+	ti,host-id = <4>;
+	ti,secure-host;
 };
 
 &mcu_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
-	status = "okay";
 	clock-frequency = <48000000>;
 };
 
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-};
-
-&main_sdhci0 {
-	status = "disabled";
-};
-
 &main_sdhci1 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	clock-names = "clk_xin";
-	clocks = <&clk_200mhz>;
-	ti,driver-strength-ohm = <50>;
+	clock-frequency = <200000000>;
 };
 
 &wkup_i2c0 {
@@ -403,60 +119,24 @@
 };
 
 &usbss0 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clocks = <&clk_19_2mhz>;
-	clock-names = "usb2_refclk";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss0_pins_default>;
-	ti,vbus-divider;
+	clock-frequency = <19200000>;
 };
 
 &usbss1 {
-	/delete-property/ power-domains;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clocks = <&clk_19_2mhz>;
-	clock-names = "usb2_refclk";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usbss1_pins_default>;
-};
-
-&main_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <19200000>;
 };
 
 &ospi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
-
 	reg = <0x0 0x47040000 0x0 0x100>,
 	      <0x0 0x50000000 0x0 0x8000000>;
 
 	flash@0{
-		compatible = "jedec,spi-nor";
-		reg = <0x0>;
-		spi-tx-bus-width = <8>;
-		spi-rx-bus-width = <8>;
-		spi-max-frequency = <25000000>;
-		cdns,tshsl-ns = <60>;
-		cdns,tsd2d-ns = <60>;
-		cdns,tchsh-ns = <60>;
-		cdns,tslch-ns = <60>;
-		cdns,read-delay = <4>;
 		cdns,phy-mode;
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
 };
 
-&ospi1 {
-	status = "disabled";
-};
-
 &mcu_ringacc {
 	ti,sci = <&dm_tifs>;
 };
@@ -464,155 +144,3 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
-
-&mailbox0_cluster0 {
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	interrupts = <432>;
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	interrupts = <428>;
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	interrupts = <424>;
-
-	mbox_c66_0: mbox-c66-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c66_1: mbox-c66-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster4 {
-	interrupts = <420>;
-
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-};
-
-&mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-};
-
-&c66_0 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
-	memory-region = <&c66_0_dma_memory_region>,
-			<&c66_0_memory_region>;
-};
-
-&c66_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
-	memory-region = <&c66_1_dma_memory_region>,
-			<&c66_1_memory_region>;
-};
-
-&c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
-
-/* EEPROM might be read before SYSFW is available */
-&wkup_i2c0 {
-	/delete-property/ power-domains;
-};
diff --git a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
index 205dacff4d..e4bd71913c 100644
--- a/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-sk-u-boot.dtsi
@@ -7,14 +7,7 @@
 #include "k3-j721e-binman.dtsi"
 
 / {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
 	aliases {
-		ethernet0 = &cpsw_port1;
-		spi0 = &ospi0;
 		remoteproc0 = &mcu_r5fss0_core0;
 		remoteproc1 = &mcu_r5fss0_core1;
 		remoteproc2 = &main_r5fss0_core0;
@@ -24,61 +17,49 @@
 		remoteproc6 = &c66_0;
 		remoteproc7 = &c66_1;
 		remoteproc8 = &c71_0;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &main_i2c0;
-		mmc1 = &main_sdhci1;  /* SD Card */
 	};
 };
 
-&cbass_main{
+&cbass_main {
 	bootph-pre-ram;
+};
 
-	main_navss: bus@30000000 {
-		bootph-pre-ram;
-	};
+&main_navss {
+	bootph-pre-ram;
 };
 
 &cbass_mcu_wakeup {
 	bootph-pre-ram;
 
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
-		ti,timer-alwon;
-		clock-frequency = <25000000>;
+	chipid@43000014 {
 		bootph-pre-ram;
 	};
+};
 
-	mcu_navss: bus@28380000 {
-		bootph-pre-ram;
-
-		ringacc@2b800000 {
-			reg =	<0x0 0x2b800000 0x0 0x400000>,
-				<0x0 0x2b000000 0x0 0x400000>,
-				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>,
-				<0x0 0x28440000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
-			bootph-pre-ram;
-		};
+&mcu_navss {
+	bootph-pre-ram;
+};
 
-		dma-controller@285c0000 {
-			reg =	<0x0 0x285c0000 0x0 0x100>,
-				<0x0 0x284c0000 0x0 0x4000>,
-				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x284a0000 0x0 0x4000>,
-				<0x0 0x2aa00000 0x0 0x40000>,
-				<0x0 0x28400000 0x0 0x2000>;
-			reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-					    "tchanrt", "rflow";
-			bootph-pre-ram;
-		};
-	};
+&mcu_ringacc {
+	reg =	<0x0 0x2b800000 0x0 0x400000>,
+		<0x0 0x2b000000 0x0 0x400000>,
+		<0x0 0x28590000 0x0 0x100>,
+		<0x0 0x2a500000 0x0 0x40000>,
+		<0x0 0x28440000 0x0 0x40000>;
+		reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+		bootph-pre-ram;
+};
 
-	chipid@43000014 {
+&mcu_udmap {
+	reg =	<0x0 0x285c0000 0x0 0x100>,
+		<0x0 0x284c0000 0x0 0x4000>,
+		<0x0 0x2a800000 0x0 0x40000>,
+		<0x0 0x284a0000 0x0 0x4000>,
+		<0x0 0x2aa00000 0x0 0x40000>,
+		<0x0 0x28400000 0x0 0x2000>;
+		reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+			    "tchanrt", "rflow";
 		bootph-pre-ram;
-	};
 };
 
 &secure_proxy_main {
@@ -121,17 +102,20 @@
 	bootph-pre-ram;
 };
 
-&main_sdhci0 {
-	status = "disabled";
+&main_sdhci1 {
+	bootph-pre-ram;
 };
 
-&main_sdhci1 {
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&mcu_uart0_pins_default {
 	bootph-pre-ram;
 };
 
-&wiz3_pll1_refclk {
-	assigned-clocks = <&wiz3_pll1_refclk>, <&wiz3_pll0_refclk>;
-	assigned-clock-parents = <&k3_clks 295 0>, <&k3_clks 295 9>;
+&main_uart0_pins_default {
+	bootph-pre-ram;
 };
 
 &main_usbss0_pins_default {
@@ -147,11 +131,6 @@
 	bootph-pre-ram;
 };
 
-&wiz2_pll1_refclk {
-	assigned-clocks = <&wiz2_pll1_refclk>, <&wiz2_pll0_refclk>;
-	assigned-clock-parents = <&k3_clks 294 0>, <&k3_clks 294 11>;
-};
-
 &main_usbss1_pins_default {
 	bootph-pre-ram;
 };
@@ -165,19 +144,6 @@
 	bootph-pre-ram;
 };
 
-&mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x2>;
-	reg-names = "cpsw_nuss", "mac_efuse";
-	/delete-property/ ranges;
-
-	cpsw-phy-sel@40f04040 {
-		compatible = "ti,am654-cpsw-phy-sel";
-		reg= <0x0 0x40f04040 0x0 0x4>;
-		reg-names = "gmii-sel";
-	};
-};
-
 &main_mmc1_pins_default {
 	bootph-pre-ram;
 };
@@ -190,44 +156,9 @@
 	bootph-pre-ram;
 };
 
-&mcu_i2c0 {
-	bootph-pre-ram;
-};
-
-&mcu_i2c1 {
-	status = "disabled";
-};
-
-&main_i2c0 {
-	status = "disabled";
-};
-
-&main_i2c1 {
-	status = "disabled";
-};
-
-&main_i2c2 {
-	status = "disabled";
-};
-
-&main_i2c3 {
-	status = "disabled";
-};
-
-&main_i2c4 {
-	status = "disabled";
-};
-
-&main_i2c5 {
-	status = "disabled";
-};
-
-&main_i2c6 {
-	status = "disabled";
-};
-
-&mcu_i2c0_pins_default {
+&wkup_uart0 {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &mcu_fss0_ospi0_pins_default {
@@ -238,8 +169,8 @@
 	bootph-pre-ram;
 };
 
-&hbmc {
-	status = "disabled";
+&main_esm {
+	bootph-pre-ram;
 };
 
 &ospi0 {
@@ -249,37 +180,11 @@
 		bootph-pre-ram;
 
 		partition@3fc0000 {
-			label = "ospi.phypattern";
-			reg = <0x3fc0000 0x40000>;
 			bootph-pre-ram;
 		};
 	};
 };
 
-&serdes_ln_ctrl {
-	u-boot,mux-autoprobe;
-};
-
-&usb_serdes_mux {
-	u-boot,mux-autoprobe;
-};
-
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie1_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
-&pcie1_ep {
-	status = "disabled";
-};
-
-&dss {
+&hbmc {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-j721e-sk.dts b/arch/arm/dts/k3-j721e-sk.dts
index 4443cd0128..0ee4f38ec8 100644
--- a/arch/arm/dts/k3-j721e-sk.dts
+++ b/arch/arm/dts/k3-j721e-sk.dts
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * J721E SK URL: https://www.ti.com/tool/SK-TDA4VM
  */
 
 /dts-v1/;
@@ -12,11 +14,19 @@
 
 / {
 	compatible = "ti,j721e-sk", "ti,j721e";
-	model = "Texas Instruments J721E SK A72";
+	model = "Texas Instruments J721E SK";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		ethernet0 = &cpsw_port1;
+		mmc1 = &main_sdhci1;
+	};
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	memory@80000000 {
@@ -195,14 +205,91 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&vsys_3v3>;
-		gpios = <&wkup_gpio0 9 GPIO_ACTIVE_LOW>;
-		states = <3300000 0x0>,
-			 <1800000 0x1>;
+		gpios = <&wkup_gpio0 9 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	dp_pwr_3v3: fixedregulator-dp-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_pwr_en_pins_default>;
+		gpio = <&main_gpio0 111 0>;	/* DP0_3V3 _EN */
+		enable-active-high;
+	};
+
+	dp0: connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp_pwr_3v3>;
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins_default>;
+
+		ddc-i2c-bus = <&main_i2c1>;
+
+		/* HDMI_HPD */
+		hpd-gpios = <&main_gpio1 0 GPIO_ACTIVE_HIGH>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	dvi-bridge {
+		compatible = "ti,tfp410";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_pdn_pins_default>;
+
+		powerdown-gpios = <&main_gpio0 127 GPIO_ACTIVE_LOW>;
+		ti,deskew = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+					pclk-sample = <1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint {
+					remote-endpoint =
+						<&hdmi_connector_in>;
+				};
+			};
+		};
 	};
 };
 
 &main_pmx0 {
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
 			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
@@ -215,7 +302,7 @@
 		>;
 	};
 
-	main_uart0_pins_default: main-uart0-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x1f0, PIN_INPUT, 0) /* (AC2) UART0_CTSn */
 			J721E_IOPAD(0x1f4, PIN_OUTPUT, 0) /* (AB1) UART0_RTSn */
@@ -224,50 +311,155 @@
 		>;
 	};
 
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1f8, PIN_INPUT, 0) /* (AA4) UART1_RXD */
+			J721E_IOPAD(0x1fc, PIN_OUTPUT, 0) /* (AB4) UART1_TXD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
 			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
 			J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
 		>;
 	};
 
-	main_i2c3_pins_default: main-i2c3-pins-default {
+	main_i2c3_pins_default: main-i2c3-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
 			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
 		>;
 	};
 
-	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (J26) MCU_I2C0_SCL */
-			J721E_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (H25) MCU_I2C0_SDA */
+			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
+			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
 	};
 
-	main_usbss0_pins_default: main-usbss0-pins-default {
+	main_usbss1_pins_default: main-usbss1-default-pins {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
-			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
+			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
 		>;
 	};
 
-	main_usbss1_pins_default: main-usbss1-pins-default {
+	dp0_pins_default: dp0-default-pins {
 		pinctrl-single,pins = <
-			J721E_IOPAD(0x214, PIN_OUTPUT, 4) /* (V4) MCAN1_TX.USB1_DRVVBUS */
+			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
+		>;
+	};
+
+	dp_pwr_en_pins_default: dp-pwr-en-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1c0, PIN_INPUT, 7) /* (AA2) SPI0_CS0.GPIO0_111 */
+		>;
+	};
+
+	dss_vout0_pins_default: dss-vout0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x58, PIN_OUTPUT, 10) /* (AE22) PRG1_PRU1_GPO0.VOUT0_DATA0 */
+			J721E_IOPAD(0x5c, PIN_OUTPUT, 10) /* (AG23) PRG1_PRU1_GPO1.VOUT0_DATA1 */
+			J721E_IOPAD(0x60, PIN_OUTPUT, 10) /* (AF23) PRG1_PRU1_GPO2.VOUT0_DATA2 */
+			J721E_IOPAD(0x64, PIN_OUTPUT, 10) /* (AD23) PRG1_PRU1_GPO3.VOUT0_DATA3 */
+			J721E_IOPAD(0x68, PIN_OUTPUT, 10) /* (AH24) PRG1_PRU1_GPO4.VOUT0_DATA4 */
+			J721E_IOPAD(0x6c, PIN_OUTPUT, 10) /* (AG21) PRG1_PRU1_GPO5.VOUT0_DATA5 */
+			J721E_IOPAD(0x70, PIN_OUTPUT, 10) /* (AE23) PRG1_PRU1_GPO6.VOUT0_DATA6 */
+			J721E_IOPAD(0x74, PIN_OUTPUT, 10) /* (AC21) PRG1_PRU1_GPO7.VOUT0_DATA7 */
+			J721E_IOPAD(0x78, PIN_OUTPUT, 10) /* (Y23) PRG1_PRU1_GPO8.VOUT0_DATA8 */
+			J721E_IOPAD(0x7c, PIN_OUTPUT, 10) /* (AF21) PRG1_PRU1_GPO9.VOUT0_DATA9 */
+			J721E_IOPAD(0x80, PIN_OUTPUT, 10) /* (AB23) PRG1_PRU1_GPO10.VOUT0_DATA10 */
+			J721E_IOPAD(0x84, PIN_OUTPUT, 10) /* (AJ25) PRG1_PRU1_GPO11.VOUT0_DATA11 */
+			J721E_IOPAD(0x88, PIN_OUTPUT, 10) /* (AH25) PRG1_PRU1_GPO12.VOUT0_DATA12 */
+			J721E_IOPAD(0x8c, PIN_OUTPUT, 10) /* (AG25) PRG1_PRU1_GPO13.VOUT0_DATA13 */
+			J721E_IOPAD(0x90, PIN_OUTPUT, 10) /* (AH26) PRG1_PRU1_GPO14.VOUT0_DATA14 */
+			J721E_IOPAD(0x94, PIN_OUTPUT, 10) /* (AJ27) PRG1_PRU1_GPO15.VOUT0_DATA15 */
+			J721E_IOPAD(0x30, PIN_OUTPUT, 10) /* (AF24) PRG1_PRU0_GPO11.VOUT0_DATA16 */
+			J721E_IOPAD(0x34, PIN_OUTPUT, 10) /* (AJ24) PRG1_PRU0_GPO12.VOUT0_DATA17 */
+			J721E_IOPAD(0x38, PIN_OUTPUT, 10) /* (AG24) PRG1_PRU0_GPO13.VOUT0_DATA18 */
+			J721E_IOPAD(0x3c, PIN_OUTPUT, 10) /* (AD24) PRG1_PRU0_GPO14.VOUT0_DATA19 */
+			J721E_IOPAD(0x40, PIN_OUTPUT, 10) /* (AC24) PRG1_PRU0_GPO15.VOUT0_DATA20 */
+			J721E_IOPAD(0x44, PIN_OUTPUT, 10) /* (AE24) PRG1_PRU0_GPO16.VOUT0_DATA21 */
+			J721E_IOPAD(0x24, PIN_OUTPUT, 10) /* (AJ20) PRG1_PRU0_GPO8.VOUT0_DATA22 */
+			J721E_IOPAD(0x28, PIN_OUTPUT, 10) /* (AG20) PRG1_PRU0_GPO9.VOUT0_DATA23 */
+			J721E_IOPAD(0x9c, PIN_OUTPUT, 10) /* (AC22) PRG1_PRU1_GPO17.VOUT0_DE */
+			J721E_IOPAD(0x98, PIN_OUTPUT, 10) /* (AJ26) PRG1_PRU1_GPO16.VOUT0_HSYNC */
+			J721E_IOPAD(0xa4, PIN_OUTPUT, 10) /* (AH22) PRG1_PRU1_GPO19.VOUT0_PCLK */
+			J721E_IOPAD(0xa0, PIN_OUTPUT, 10) /* (AJ22) PRG1_PRU1_GPO18.VOUT0_VSYNC */
+		>;
+	};
+
+	hdmi_hpd_pins_default: hdmi-hpd-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x204, PIN_INPUT, 7) /* (AD5) UART1_RTSn.GPIO1_0 */
+		>;
+	};
+
+	hdmi_pdn_pins_default: hdmi-pdn-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x200, PIN_INPUT, 7) /* (AC4) UART1_CTSn.GPIO0_127 */
+		>;
+	};
+
+	/* Reset for M.2 E Key slot on PCIe0  */
+	ekey_reset_pins_default: ekey-reset-pns-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x124, PIN_INPUT, 7) /* (Y24) PRG0_PRU1_GPO9.GPIO0_72 */
+		>;
+	};
+
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
+			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
+		>;
+	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x01C, PIN_INPUT, 7) /* (AD22) PRG1_PRU0_GPO6.GPIO0_7 */
+			J721E_IOPAD(0x120, PIN_INPUT, 7) /* (AA28) PRG0_PRU1_GPO8.GPIO0_71 */
+			J721E_IOPAD(0x14C, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
+			J721E_IOPAD(0x02C, PIN_INPUT, 7) /* (AD21) PRG1_PRU0_GPO10.GPIO0_11 */
+			J721E_IOPAD(0x198, PIN_INPUT, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
+			J721E_IOPAD(0x1B0, PIN_INPUT, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
+			J721E_IOPAD(0x1A0, PIN_INPUT, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
+			J721E_IOPAD(0x008, PIN_INPUT, 7) /* (AG22) PRG1_PRU0_GPO1.GPIO0_2 */
+			J721E_IOPAD(0x1D0, PIN_INPUT, 7) /* (AA3) SPI0_D1.GPIO0_115 */
+			J721E_IOPAD(0x11C, PIN_INPUT, 7) /* (AA24) PRG0_PRU1_GPO7.GPIO0_70 */
+			J721E_IOPAD(0x148, PIN_INPUT, 7) /* (AA26) PRG0_PRU1_GPO18.GPIO0_81 */
+			J721E_IOPAD(0x004, PIN_INPUT, 7) /* (AC23) PRG1_PRU0_GPO0.GPIO0_1 */
+			J721E_IOPAD(0x014, PIN_INPUT, 7) /* (AH23) PRG1_PRU0_GPO4.GPIO0_5 */
+			J721E_IOPAD(0x020, PIN_INPUT, 7) /* (AE20) PRG1_PRU0_GPO7.GPIO0_8 */
+			J721E_IOPAD(0x19C, PIN_INPUT, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
+			J721E_IOPAD(0x1B4, PIN_INPUT, 7) /* (W25) RGMII6_RD0.GPIO0_108 */
+			J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
+			J721E_IOPAD(0x00C, PIN_INPUT, 7) /* (AF22) PRG1_PRU0_GPO2.GPIO0_3 */
+			J721E_IOPAD(0x010, PIN_INPUT, 7) /* (AJ23) PRG1_PRU0_GPO3.GPIO0_4 */
+			J721E_IOPAD(0x178, PIN_INPUT, 7) /* (U27) RGMII5_RD3.GPIO0_93 */
+			J721E_IOPAD(0x17C, PIN_INPUT, 7) /* (U24) RGMII5_RD2.GPIO0_94 */
+			J721E_IOPAD(0x190, PIN_INPUT, 7) /* (W23) RGMII6_TD3.GPIO0_99 */
+			J721E_IOPAD(0x18C, PIN_INPUT, 7) /* (V23) RGMII6_RX_CTL.GPIO0_98 */
+		>;
+	};
+
+	rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
 		>;
 	};
 };
 
 &wkup_pmx0 {
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
 			J721E_WKUP_IOPAD(0x80, PIN_INPUT, 0) /* (A24) MCU_RGMII1_RD1 */
@@ -284,14 +476,14 @@
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+	mcu_mdio_pins_default: mcu-mdio1-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x8c, PIN_OUTPUT, 0) /* (F23) MCU_MDIO0_MDC */
 			J721E_WKUP_IOPAD(0x88, PIN_INPUT, 0) /* (E23) MCU_MDIO0_MDIO */
 		>;
 	};
 
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 0) /* (E20) MCU_OSPI0_CLK */
 			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 0) /* (F19) MCU_OSPI0_CSn0 */
@@ -307,71 +499,87 @@
 		>;
 	};
 
-	vdd_mmc1_en_pins_default: vdd-mmc1-en-pins-default {
+	vdd_mmc1_en_pins_default: vdd-mmc1-en-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xd0, PIN_OUTPUT, 7) /* (G27) WKUP_GPIO0_8 */
 		>;
 	};
 
-	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-pins-default {
+	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xf0, PIN_INPUT, 2) /* (D26) MCU_I3C0_SCL.MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0xf4, PIN_OUTPUT, 2)/* (D25) MCU_I3C0_SDA.MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0xe4, PIN_INPUT, 0) /* (H28) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0xe0, PIN_OUTPUT, 0)/* (G29) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
 	};
+
+	/* Reset for M.2 M Key slot on PCIe1  */
+	mkey_reset_pins_default: mkey-reset-pns-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xdc, PIN_INPUT, 7) /* (H27) WKUP_GPIO0_11 */
+		>;
+	};
 };
 
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "reserved";
-};
-
-&main_uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	/* Shared with ATF on this platform */
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-};
-
-&main_uart2 {
-	/* Brought out on RPi header */
-	status = "disabled";
-};
-
-&main_uart3 {
-	/* UART not brought out */
-	status = "disabled";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
-&main_uart5 {
-	/* UART not brought out */
-	status = "disabled";
-};
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
 
-&main_uart6 {
-	/* UART not brought out */
-	status = "disabled";
+	eeprom@51 {
+		/* AT24C512C-MAHM-T */
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+	};
 };
 
-&main_uart7 {
-	/* UART not brought out */
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
-&main_uart8 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	/* Shared with ATF on this platform */
+	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
-&main_uart9 {
-	/* Brought out on M.2 E Key */
-	status = "disabled";
+&main_uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
 &main_sdhci0 {
@@ -398,7 +606,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -409,10 +617,52 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <4>;
-		cdns,phy-mode;
-		cdns,phy-tx-start = <18>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@7c0000 {
+				label = "ospi.env.backup";
+				reg = <0x7c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
 	};
 };
 
@@ -422,42 +672,113 @@
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		/* PCIe1 M.2 M Key I2C */
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		/* PCIe0 M.2 E Key I2C */
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	/* i2c1 is used for DVI DDC, so we need to use 100kHz */
+	clock-frequency = <100000>;
 };
 
 &main_i2c3 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c3_pins_default>;
 	clock-frequency = <400000>;
-};
 
-&main_i2c4 {
-	/* Unused */
-	status = "disabled";
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		/* CSI0 I2C */
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		/* CSI1 I2C */
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &main_i2c5 {
 	/* Brought out on RPi Header */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
+};
+
+&main_gpio2 {
 	status = "disabled";
 };
 
-&main_i2c6 {
-	/* Unused */
+&main_gpio3 {
 	status = "disabled";
 };
 
-&mcu_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_i2c0_pins_default>;
-	clock-frequency = <400000>;
+&main_gpio4 {
+	status = "disabled";
+};
+
+&main_gpio5 {
+	status = "disabled";
+};
+
+&main_gpio6 {
+	status = "disabled";
+};
+
+&main_gpio7 {
+	status = "disabled";
+};
+
+&wkup_gpio1 {
+	status = "disabled";
 };
 
 &usb_serdes_mux {
@@ -479,7 +800,7 @@
 };
 
 &serdes3 {
-	serdes3_usb_link: link@0 {
+	serdes3_usb_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
@@ -488,6 +809,24 @@
 	};
 };
 
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+};
+
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
@@ -502,7 +841,7 @@
 };
 
 &serdes2 {
-	serdes2_usb_link: link@1 {
+	serdes2_usb_link: phy@1 {
 		reg = <1>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -536,7 +875,7 @@
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
@@ -553,6 +892,9 @@
 };
 
 &dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout0_pins_default>;
+
 	assigned-clocks = <&k3_clks 152 1>,	/* VP 1 pixel clock */
 			  <&k3_clks 152 4>,	/* VP 2 pixel clock */
 			  <&k3_clks 152 9>,	/* VP 3 pixel clock */
@@ -563,87 +905,94 @@
 				 <&k3_clks 152 18>;	/* DPI1_EXT_CLKSEL_OUT0 */
 };
 
-&mcasp0 {
-	/* Unused */
-	status = "disabled";
-};
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-&mcasp1 {
-	/* Unused */
-	status = "disabled";
-};
-
-&mcasp2 {
-	/* Unused */
-	status = "disabled";
-};
+	port@0  {
+		reg = <0>;
 
-&mcasp3 {
-	/* Unused */
-	status = "disabled";
-};
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
 
-&mcasp4 {
-	/* Unused */
-	status = "disabled";
-};
+	port@1 {
+		reg = <1>;
 
-&mcasp5 {
-	/* Unused */
-	status = "disabled";
+		dpi1_out: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
 };
 
-&mcasp6 {
-	/* Brought out on RPi header */
-	status = "disabled";
-};
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-&mcasp7 {
-	/* Unused */
-	status = "disabled";
-};
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
 
-&mcasp8 {
-	/* Unused */
-	status = "disabled";
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp_connector_in>;
+		};
+	};
 };
 
-&mcasp9 {
-	/* Unused */
-	status = "disabled";
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
 };
 
-&mcasp10 {
-	/* Unused */
-	status = "disabled";
+&serdes1 {
+	serdes1_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+	};
 };
 
-&mcasp11 {
-	/* Brought out on M.2 E Key */
-	status = "disabled";
-};
+&pcie0_rc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ekey_reset_pins_default>;
+	reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_HIGH>;
 
-&pcie2_rc {
-	/* Unused */
-	status = "disabled";
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
 };
 
-&pcie2_ep {
-	/* Unused */
-	status = "disabled";
-};
+&pcie1_rc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mkey_reset_pins_default>;
+	reset-gpios = <&wkup_gpio0 11 GPIO_ACTIVE_HIGH>;
 
-&pcie3_rc {
-	/* Unused */
-	status = "disabled";
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
 };
 
-&pcie3_ep {
-	/* Unused */
+&ufs_wrapper {
 	status = "disabled";
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -658,6 +1007,7 @@
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
@@ -672,6 +1022,7 @@
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
 	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
@@ -686,6 +1037,7 @@
 };
 
 &mailbox0_cluster3 {
+	status = "okay";
 	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
@@ -700,6 +1052,7 @@
 };
 
 &mailbox0_cluster4 {
+	status = "okay";
 	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
@@ -708,84 +1061,56 @@
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
 
 &c66_0 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
 };
 
 &c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
diff --git a/arch/arm/dts/k3-j721e-som-p0.dtsi b/arch/arm/dts/k3-j721e-som-p0.dtsi
index a725435849..38ae13cc3a 100644
--- a/arch/arm/dts/k3-j721e-som-p0.dtsi
+++ b/arch/arm/dts/k3-j721e-som-p0.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019-2020 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Product Link: https://www.ti.com/tool/J721EXSOMXEVM
  */
 
 /dts-v1/;
@@ -143,33 +145,14 @@
 };
 
 &wkup_pmx0 {
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
 			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
 		>;
 	};
 
-	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
-		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (E20) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
-			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C21) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
-			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (F19) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
-			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* (E22) MCU_OSPI1_CSn1.MCU_HYPERBUS0_CSn1 */
-			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (E19) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
-			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (D21) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
-			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D20) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
-			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (G19) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
-			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (G20) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
-			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (F20) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
-			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (F21) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
-			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (E21) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
-			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (B22) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
-			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (G21) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
-		>;
-	};
-
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
 			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
@@ -184,18 +167,50 @@
 			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
 		>;
 	};
+
+	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1)  /* MCU_HYPERBUS0_CK */
+			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1)  /* MCU_HYPERBUS0_CKn */
+			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* MCU_HYPERBUS0_CSn0 */
+			J721E_WKUP_IOPAD(0x54, PIN_OUTPUT, 3) /* MCU_HYPERBUS0_CSn1 */
+			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* MCU_HYPERBUS0_RESETn */
+			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1)   /* MCU_HYPERBUS0_RWDS */
+			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1)   /* MCU_HYPERBUS0_DQ0 */
+			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ1 */
+			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ2 */
+			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ3 */
+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ4 */
+			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ5 */
+			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ6 */
+			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1)  /* MCU_HYPERBUS0_DQ7 */
+		>;
+	};
 };
 
-&hbmc {
-	status = "disabled";
+&wkup_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
-	ranges = <0x0 0x0 0x5 0x0 0x4000000>, /* 64MB Flash on CS0 */
-		 <0x1 0x0 0x5 0x4000000 0x800000>; /* 8MB RAM on CS1 */
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
 
-	flash@0,0 {
-		compatible = "cypress,hyperflash", "cfi-flash";
-		reg = <0x0 0x0 0x4000000>;
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		/* CAV24C256WE-GT3 */
+		compatible = "atmel,24c256";
+		reg = <0x50>;
 	};
 };
 
@@ -203,7 +218,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -214,12 +229,109 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "ospi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fe0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+			};
+		};
+	};
+};
+
+&hbmc {
+	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
+	 * appropriate node based on board detection
+	 */
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
+	ranges = <0x00 0x00 0x05 0x00000000 0x4000000>, /* 64MB Flash on CS0 */
+		 <0x01 0x00 0x05 0x04000000 0x800000>; /* 8MB RAM on CS1 */
+
+	flash@0,0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x00 0x00 0x4000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "hbmc.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "hbmc.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "hbmc.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "hbmc.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "hbmc.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "hbmc.rootfs";
+				reg = <0x800000 0x3800000>;
+			};
+		};
 	};
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -234,6 +346,7 @@
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
@@ -248,6 +361,7 @@
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
 	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
@@ -262,6 +376,7 @@
 };
 
 &mailbox0_cluster3 {
+	status = "okay";
 	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
@@ -276,6 +391,7 @@
 };
 
 &mailbox0_cluster4 {
+	status = "okay";
 	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
@@ -284,84 +400,56 @@
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
 
 &c66_0 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
 	memory-region = <&c66_0_dma_memory_region>,
 			<&c66_0_memory_region>;
 };
 
 &c66_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
 	memory-region = <&c66_1_dma_memory_region>,
 			<&c66_1_memory_region>;
 };
 
 &c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
diff --git a/arch/arm/dts/k3-j721e-thermal.dtsi b/arch/arm/dts/k3-j721e-thermal.dtsi
new file mode 100644
index 0000000000..c252327900
--- /dev/null
+++ b/arch/arm/dts/k3-j721e-thermal.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup_thermal: wkup-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	c7x_thermal: c7x-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	gpu_thermal: gpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 3>;
+
+		trips {
+			gpu_crit: gpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	r5f_thermal: r5f-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 4>;
+
+		trips {
+			r5f_crit: r5f-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-j721e.dtsi b/arch/arm/dts/k3-j721e.dtsi
index f0587fde14..a200810df5 100644
--- a/arch/arm/dts/k3-j721e.dtsi
+++ b/arch/arm/dts/k3-j721e.dtsi
@@ -7,9 +7,10 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/k3.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
+#include "k3-pinctrl.h"
+
 / {
 	model = "Texas Instruments K3 J721E SoC";
 	compatible = "ti,j721e";
@@ -17,22 +18,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		serial4 = &main_uart2;
-		serial5 = &main_uart3;
-		serial6 = &main_uart4;
-		serial7 = &main_uart5;
-		serial8 = &main_uart6;
-		serial9 = &main_uart7;
-		serial10 = &main_uart8;
-		serial11 = &main_uart9;
-		ethernet0 = &cpsw_port1;
-	};
-
 	chosen { };
 
 	cpus {
@@ -61,7 +46,7 @@
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -75,7 +60,7 @@
 			i-cache-sets = <256>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
+			d-cache-sets = <256>;
 			next-level-cache = <&L2_0>;
 		};
 	};
@@ -83,15 +68,17 @@
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
-		cache-sets = <2048>;
+		cache-sets = <1024>;
 		next-level-cache = <&msmc_l3>;
 	};
 
 	msmc_l3: l3-cache0 {
 		compatible = "cache";
 		cache-level = <3>;
+		cache-unified;
 	};
 
 	firmware {
@@ -126,16 +113,19 @@
 		#size-cells = <2>;
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
 			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
+			 <0x00 0x0c000000 0x00 0x0c000000 0x00 0x0d000000>, /* CPSW9G */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* PCIe Core*/
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* PCIe Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71 */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
 			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT */
 			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT */
 			 <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
@@ -177,6 +167,8 @@
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
 		};
 	};
+
+	#include "k3-j721e-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.34.1

