Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3EFC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01857869D8;
	Wed, 16 Aug 2023 11:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lDbhpPAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80094869C4; Wed, 16 Aug 2023 11:23:37 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7582869C4
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NV9l031867;
 Wed, 16 Aug 2023 04:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692177811;
 bh=vUhb6swwbm5I45Ud+VhnrwieNALiIn9XCeo6JH9Bszw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=lDbhpPAQqBgGxvNLrEA2QxKa26LEkYzP91lBC/ipAYvyKxyc1Xo30HKTnXsYYOvhF
 tua3cHr6/wIYeR0Pmpfei0QqX2XjrfeFNouE46mPg+OrlcPlpu1R/eYP3xJegjfWwb
 mDTdq6VZmORUeFcYtge5RZOjDr3cABjg7iCclxG0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37G9NVw1075985
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 04:23:31 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 04:23:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 04:23:31 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NJBk059893;
 Wed, 16 Aug 2023 04:23:28 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 16 Aug 2023 14:53:10 +0530
Subject: [PATCH 2/3] k3-am68: Sync from linux-next tag next-20230815
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v1-2-f4548452760a@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692177800; l=31547;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=gN0BvGYpq7Bmf1q7v/BUsOm58o0f9PV6/lYnMtuvWWA=;
 b=sllowSSSS4fQWu2qy70AfwBkq64DNb1yLg9zP532rDIFLJ9WjZJXLs/+bZLW1RZ2LJ8I8kiiH
 jRI1rnOJ5r8CoZG2HTlfyiTK2I5uA1CIlomcVdh8QeexM0climS5thz
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

The following commit syncs the device tree from Linux tag
next-20230815 to U-boot and fixes the following to be compatible with
the future syncs -

- Include k3-am68-sk-base-board.dts file

    Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
    include k3-am68-sk-common-proc-board.dts for Linux fixes to propagate
    to U-boot.

- Fixing the mcu_timer0

    Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi

    The device manager is not functional at this point so we can't
    configure the clocks for the mcu_timer0, delete the properties
    that enable the clocks and power domains for it.

- Fixing secure proxy nodes

    Linux DT now have these nodes defined so remove them and rename to
    use the Linux DT ones.

- Remove cpsw node

    The compatible is now fixed and the node is not required in
    -u-boot specifically

- Remove aliases and chosen node

    Use these from Linux and don't override when not required.

- Remove dummy_clock_19_2mhz

    This wasn't being used anywhere so remove it.

All these have been put in a single commit to not break the
bisectability.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  57 +--
 arch/arm/dts/k3-am68-sk-base-board.dts         | 524 +++++++++++++++++--------
 arch/arm/dts/k3-am68-sk-r5-base-board.dts      | 109 +----
 arch/arm/dts/k3-am68-sk-som.dtsi               | 112 +-----
 4 files changed, 404 insertions(+), 398 deletions(-)

diff --git a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
index 79faa1b5737d..e3483a4bb52b 100644
--- a/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi
@@ -5,25 +5,6 @@
 
 #include "k3-j721s2-binman.dtsi"
 
-/ {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &timer1;
-	};
-
-	aliases {
-		serial0 = &wkup_uart0;
-		serial1 = &mcu_uart0;
-		serial2 = &main_uart8;
-		i2c0 = &wkup_i2c0;
-		i2c1 = &mcu_i2c0;
-		i2c2 = &mcu_i2c1;
-		i2c3 = &main_i2c0;
-		ethernet0 = &cpsw_port1;
-		mmc1 = &main_sdhci1;
-	};
-};
-
 &wkup_i2c0 {
 	bootph-pre-ram;
 };
@@ -36,16 +17,17 @@
 	bootph-pre-ram;
 };
 
-&cbass_mcu_wakeup {
-	bootph-pre-ram;
-
-	timer1: timer@40400000 {
-		compatible = "ti,omap5430-timer";
-		reg = <0x0 0x40400000 0x0 0x80>;
+&mcu_timer0 {
+		/delete-property/ power-domains;
+		/delete-property/ assigned-clocks;
+		/delete-property/ assigned-clock-parents;
 		ti,timer-alwon;
 		clock-frequency = <250000000>;
 		bootph-pre-ram;
-	};
+};
+
+&cbass_mcu_wakeup {
+	bootph-pre-ram;
 
 	chipid@43000014 {
 		bootph-pre-ram;
@@ -57,24 +39,18 @@
 };
 
 &mcu_ringacc {
-	reg =   <0x0 0x2b800000 0x0 0x400000>,
-		<0x0 0x2b000000 0x0 0x400000>,
-		<0x0 0x28590000 0x0 0x100>,
-		<0x0 0x2a500000 0x0 0x40000>,
-		<0x0 0x28440000 0x0 0x40000>;
-	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 	bootph-pre-ram;
 };
 
 &mcu_udmap {
-	reg =   <0x0 0x285c0000 0x0 0x100>,
+	reg =	<0x0 0x285c0000 0x0 0x100>,
 		<0x0 0x284c0000 0x0 0x4000>,
 		<0x0 0x2a800000 0x0 0x40000>,
 		<0x0 0x284a0000 0x0 0x4000>,
 		<0x0 0x2aa00000 0x0 0x40000>,
 		<0x0 0x28400000 0x0 0x2000>;
 	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
-		    "tchanrt", "rflow";
+			"tchanrt", "rflow";
 	bootph-pre-ram;
 };
 
@@ -130,19 +106,6 @@
 	bootph-pre-ram;
 };
 
-&mcu_cpsw {
-	reg = <0x0 0x46000000 0x0 0x200000>,
-	      <0x0 0x40f00200 0x0 0x8>;
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
 &main_sdhci0 {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-am68-sk-base-board.dts b/arch/arm/dts/k3-am68-sk-base-board.dts
index 8fc03324ab8a..5df5946687b3 100644
--- a/arch/arm/dts/k3-am68-sk-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-base-board.dts
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  *
- * Base Board: **Yet to Add**
+ * Base Board: https://www.ti.com/lit/zip/SPRR463
  */
 
 /dts-v1/;
@@ -12,21 +12,28 @@
 #include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy.h>
 
+#include "k3-serdes.h"
+
 / {
 	compatible = "ti,am68-sk", "ti,j721s2";
 	model = "Texas Instruments AM68 SK";
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
 	};
 
 	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
 		serial2 = &main_uart8;
 		mmc1 = &main_sdhci1;
+		can0 = &mcu_mcan0;
+		can1 = &mcu_mcan1;
+		can2 = &main_mcan6;
+		can3 = &main_mcan7;
 	};
 
-	vusb_main: fixedregulator-vusb-main5v0 {
+	vusb_main: regulator-vusb-main5v0 {
 		/* USB MAIN INPUT 5V DC */
 		compatible = "regulator-fixed";
 		regulator-name = "vusb-main5v0";
@@ -36,7 +43,7 @@
 		regulator-boot-on;
 	};
 
-	vsys_3v3: fixedregulator-vsys3v3 {
+	vsys_3v3: regulator-vsys3v3 {
 		/* Output of LM5141 */
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
@@ -47,7 +54,7 @@
 		regulator-boot-on;
 	};
 
-	vdd_mmc1: fixedregulator-sd {
+	vdd_mmc1: regulator-sd {
 		/* Output of TPS22918 */
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
@@ -56,10 +63,10 @@
 		regulator-boot-on;
 		enable-active-high;
 		vin-supply = <&vsys_3v3>;
-		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 8 GPIO_ACTIVE_HIGH>;
 	};
 
-	vdd_sd_dv: gpio-regulator-TLV71033 {
+	vdd_sd_dv: regulator-tlv71033 {
 		/* Output of TLV71033 */
 		compatible = "regulator-gpio";
 		regulator-name = "tlv71033";
@@ -73,30 +80,115 @@
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	vsys_io_1v8: regulator-vsys-io-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_io_1v2: regulator-vsys-io-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver3: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver4: can-phy3 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins_default>;
+		ddc-i2c-bus = <&mcu_i2c1>;
+		/* HDMI_HPD */
+		hpd-gpios = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	bridge-dvi {
+		compatible = "ti,tfp410";
+		/* HDMI_PDn */
+		powerdown-gpios = <&exp2 0 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&dpi_out0>;
+					pclk-sample = <1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_pmx0 {
-	main_uart8_pins_default: main-uart8-pins-default {
+	main_uart8_pins_default: main-uart8-default-pins {
 		pinctrl-single,pins = <
-			J721S2_IOPAD(0x040, PIN_INPUT, 14) /* (AC28) MCASP0_AXR0.UART8_CTSn */
-			J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
 			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
 			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
 		>;
 	};
 
-	main_i2c0_pins_default: i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_IOPAD(0x0e0, PIN_INPUT_PULLUP, 0) /* (AH25) I2C0_SCL */
-			J721S2_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AE24) I2C0_SDA */
+			J721S2_IOPAD(0x0e0, PIN_INPUT, 0) /* (AH25) I2C0_SCL */
+			J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
 			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
-			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
 			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
 			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
 			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
@@ -105,102 +197,222 @@
 		>;
 	};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x0c4, PIN_INPUT, 7) /* (AB26) ECAP0_IN_APWM_OUT.GPIO0_49 */
 		>;
 	};
-};
 
-&wkup_pmx0 {
-	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
-			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
-			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
-			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
-			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
-			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
-			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
-			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
-			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
-			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
-			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
 	};
 
-	mcu_mdio_pins_default: mcu-mdio-pins-default {
+	main_mcan6_pins_default: main-mcan6-default-pins {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
-			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+			J721S2_IOPAD(0x098, PIN_INPUT, 0) /* (V25) MCASP0_AXR10.MCAN6_RX */
+			J721S2_IOPAD(0x094, PIN_INPUT, 0) /* (AA25) MCASP0_AXR9.MCAN6_TX */
 		>;
 	};
-};
 
-&main_gpio2 {
-	status = "disabled";
-};
+	main_mcan7_pins_default: main-mcan7-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
+			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
+		>;
+	};
 
-&main_gpio4 {
-	status = "disabled";
-};
+	main_i2c4_pins_default: main-i2c4-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AF28) MCAN13_RX.I2C4_SDA */
+			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AD25) MCAN14_TX.I2C4_SCL */
+		>;
+	};
 
-&main_gpio6 {
-	status = "disabled";
-};
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0a8, PIN_INPUT, 7) /* (U24)  MCASP0_AXR14.GPIO0_42 */
+			J721S2_IOPAD(0x090, PIN_INPUT, 7) /* (W24) MCASP0_AXR8.GPIO0_36 */
+			J721S2_IOPAD(0x0bc, PIN_INPUT, 7) /* (V28) MCASP1_AFSX.GPIO0_47 */
+			J721S2_IOPAD(0x06c, PIN_INPUT, 7) /* (V26) MCAN1_TX.GPIO0_27 */
+			J721S2_IOPAD(0x004, PIN_INPUT, 7) /* (W25) MCAN12_TX.GPIO0_1 */
+			J721S2_IOPAD(0x008, PIN_INPUT, 7) /* (AC24) MCAN12_RX.GPIO0_2 */
+			J721S2_IOPAD(0x0b8, PIN_INPUT, 7) /* (AA24) MCASP1_ACLKX.GPIO0_46 */
+			J721S2_IOPAD(0x00c, PIN_INPUT, 7) /* (AE28) MCAN13_TX.GPIO0_3 */
+			J721S2_IOPAD(0x034, PIN_INPUT, 7) /* (AD24) PMIC_WAKE0.GPIO0_13 */
+			J721S2_IOPAD(0x0a4, PIN_INPUT, 7) /* (T23) MCASP0_AXR13.GPIO0_41 */
+			J721S2_IOPAD(0x0c0, PIN_INPUT, 7) /* (T28) MCASP1_AXR0.GPIO0_48 */
+			J721S2_IOPAD(0x0b4, PIN_INPUT, 7) /* (U25) MCASP1_AXR4.GPIO0_45 */
+			J721S2_IOPAD(0x0cc, PIN_INPUT, 7) /* (AE27) SPI0_CS0.GPIO0_51 */
+			J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
+		>;
+	};
 
-&wkup_gpio1 {
-	status = "disabled";
-};
+	dss_vout0_pins_default: dss-vout0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x074, PIN_OUTPUT, 2) /* (R28) MCAN2_TX.VOUT0_DATA0 */
+			J721S2_IOPAD(0x070, PIN_OUTPUT, 2) /* (R27) MCAN1_RX.VOUT0_DATA1 */
+			J721S2_IOPAD(0x04c, PIN_OUTPUT, 2) /* (V27) MCASP1_AXR1.VOUT0_DATA10 */
+			J721S2_IOPAD(0x048, PIN_OUTPUT, 2) /* (AB27) MCASP0_AXR2.VOUT0_DATA11 */
+			J721S2_IOPAD(0x044, PIN_OUTPUT, 2) /* (Y26) MCASP0_AXR1.VOUT0_DATA12 */
+			J721S2_IOPAD(0x040, PIN_OUTPUT, 2) /* (AC28) MCASP0_AXR0.VOUT0_DATA13 */
+			J721S2_IOPAD(0x03c, PIN_OUTPUT, 2) /* (U27) MCASP0_AFSX.VOUT0_DATA14 */
+			J721S2_IOPAD(0x038, PIN_OUTPUT, 2) /* (AB28) MCASP0_ACLKX.VOUT0_DATA15 */
+			J721S2_IOPAD(0x0c8, PIN_OUTPUT, 2) /* (AD28) EXT_REFCLK1.VOUT0_DATA16 */
+			J721S2_IOPAD(0x030, PIN_OUTPUT, 2) /* (T26) GPIO0_12.VOUT0_DATA17 */
+			J721S2_IOPAD(0x02c, PIN_OUTPUT, 2) /* (V23) GPIO0_11.VOUT0_DATA18 */
+			J721S2_IOPAD(0x028, PIN_OUTPUT, 2) /* (AB24) MCAN16_RX.VOUT0_DATA19 */
+			J721S2_IOPAD(0x07c, PIN_OUTPUT, 2) /* (T27) MCASP0_AXR3.VOUT0_DATA2 */
+			J721S2_IOPAD(0x024, PIN_OUTPUT, 2) /* (Y28) MCAN16_TX.VOUT0_DATA20 */
+			J721S2_IOPAD(0x020, PIN_OUTPUT, 2) /* (AA23) MCAN15_RX.VOUT0_DATA21 */
+			J721S2_IOPAD(0x01c, PIN_OUTPUT, 2) /* (Y24) MCAN15_TX.VOUT0_DATA22 */
+			J721S2_IOPAD(0x018, PIN_OUTPUT, 2) /* (W23) MCAN14_RX.VOUT0_DATA23 */
+			J721S2_IOPAD(0x068, PIN_OUTPUT, 2) /* (U28) MCAN0_RX.VOUT0_DATA3 */
+			J721S2_IOPAD(0x064, PIN_OUTPUT, 2) /* (W28) MCAN0_TX.VOUT0_DATA4 */
+			J721S2_IOPAD(0x060, PIN_OUTPUT, 2) /* (AC27) MCASP2_AXR1.VOUT0_DATA5 */
+			J721S2_IOPAD(0x05c, PIN_OUTPUT, 2) /* (AA26) MCASP2_AXR0.VOUT0_DATA6 */
+			J721S2_IOPAD(0x058, PIN_OUTPUT, 2) /* (AA27) MCASP2_AFSX.VOUT0_DATA7 */
+			J721S2_IOPAD(0x054, PIN_OUTPUT, 2) /* (Y27) MCASP2_ACLKX.VOUT0_DATA8 */
+			J721S2_IOPAD(0x050, PIN_OUTPUT, 2) /* (W27) MCASP1_AXR2.VOUT0_DATA9 */
+			J721S2_IOPAD(0x084, PIN_OUTPUT, 2) /* (AA28) MCASP0_AXR5.VOUT0_DE */
+			J721S2_IOPAD(0x080, PIN_OUTPUT, 2) /* (U26) MCASP0_AXR4.VOUT0_HSYNC */
+			J721S2_IOPAD(0x078, PIN_OUTPUT, 2) /* (Y25) MCAN2_RX.VOUT0_PCLK */
+			J721S2_IOPAD(0x088, PIN_OUTPUT, 2) /* (AD27) MCASP0_AXR6.VOUT0_VP0_VSYNC */
+		>;
+	};
 
-&wkup_uart0 {
-	status = "reserved";
+	hdmi_hpd_pins_default: hdmi-hpd-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x000, PIN_INPUT, 7) /* (AG24) EXTINTN.GPIO0_0  */
+		>;
+	};
 };
 
-&main_uart0 {
-	status = "disabled";
-};
+&wkup_pmx2 {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
+			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
+			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
+		>;
+	};
 
-&main_uart1 {
-	status = "disabled";
-};
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x02C, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x00C, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+		>;
+	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x06C, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
+		>;
+	};
+
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0a0, PIN_INPUT, 0) /* (G24) MCU_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x0a4, PIN_INPUT, 0) /* (J25) MCU_I2C0_SDA */
+		>;
+	};
 
-&main_uart2 {
-	status = "disabled";
+	mcu_i2c1_pins_default: mcu-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x078, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
+			J721S2_WKUP_IOPAD(0x07c, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
+		>;
+	};
+
+	mcu_uart0_pins_default: mcu-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
+			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
+		>;
+	};
+
+	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-default-pins-0 {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x118, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
+			J721S2_WKUP_IOPAD(0x05C, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
+			J721S2_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (C28) MCU_SPI1_D1.WKUP_GPIO0_2 */
+			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 7) /* (D26) MCU_SPI1_CLK.WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 7) /* (D25) MCU_SPI1_CS2.WKUP_GPIO0_15*/
+			J721S2_WKUP_IOPAD(0x0B8, PIN_INPUT, 7) /* (G27) WKUP_GPIO0_56 */
+			J721S2_WKUP_IOPAD(0x114, PIN_INPUT, 7) /* (J26) WKUP_GPIO0_57 */
+			J721S2_WKUP_IOPAD(0x11C, PIN_INPUT, 7) /* (J27) WKUP_GPIO0_67 */
+			J721S2_WKUP_IOPAD(0x064, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
+		>;
+	};
 };
 
-&main_uart3 {
-	status = "disabled";
+&wkup_pmx3 {
+	mcu_rpi_header_gpio0_pins1_default: mcu-rpi-header-gpio0-default-pins-1 {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x000, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
+		>;
+	};
 };
 
-&main_uart4 {
-	status = "disabled";
+&main_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
 };
 
-&main_uart5 {
-	status = "disabled";
+&wkup_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_header_gpio0_pins0_default>, <&mcu_rpi_header_gpio0_pins1_default>;
 };
 
-&main_uart6 {
-	status = "disabled";
+&wkup_uart0 {
+	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
-&main_uart7 {
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins_default>;
 };
 
 &main_uart8 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
 };
 
-&main_uart9 {
-	status = "disabled";
-};
-
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -211,45 +423,47 @@
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPN", "HDMI_PDN",
-				  "HDMI_LS_OE", "DP0_3V3_EN", "BOARDID_EEPROM_WP",
-				  "CAN_STB", "","GPIO_uSD_PWR_EN", "EDP_ENABLE",
-				  "IO_EXP_PCIE1_M2_RSTZ", "IO_EXP_MCU_RGMII_RSTZ",
-				  "IO_EXP_CSI1_EXP_RSTZ", "","CSI0_B_GPIO1",
-				  "CSI1_B_GPIO1";
+		gpio-line-names = " ", " ", " ", " ", " ",
+				  "BOARDID_EEPROM_WP", "CAN_STB", " ",
+				  "GPIO_uSD_PWR_EN", " ", "IO_EXP_PCIe1_M.2_RTSz",
+				  "IO_EXP_MCU_RGMII_RST#", " ", " ", " ", " ";
 	};
 };
 
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
 &main_i2c4 {
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
 };
 
-&main_i2c5 {
-	status = "disabled";
+&mcu_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
 };
 
-&main_i2c6 {
-	status = "disabled";
-};
+&mcu_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c1_pins_default>;
+	/* i2c1 is used for DVI DDC, so we need to use 100kHz */
+	clock-frequency = <100000>;
 
-&main_sdhci0 {
-	status = "disabled";
+	exp2: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "HDMI_PDn","HDMI_LS_OE",
+				  "DP0_3V3_EN","eDP_ENABLE";
+	};
 };
 
 &main_sdhci1 {
 	/* SD card */
+	status = "okay";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	disable-wp;
@@ -259,7 +473,7 @@
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
@@ -277,77 +491,65 @@
 };
 
 &mcu_mcan0 {
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
 };
 
 &mcu_mcan1 {
-	status = "disabled";
-};
-
-&main_mcan0 {
-	status = "disabled";
-};
-
-&main_mcan1 {
-	status = "disabled";
-};
-
-&main_mcan2 {
-	status = "disabled";
-};
-
-&main_mcan3 {
-	status = "disabled";
-};
-
-&main_mcan4 {
-	status = "disabled";
-};
-
-&main_mcan5 {
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
 };
 
 &main_mcan6 {
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan6_pins_default>;
+	phys = <&transceiver3>;
 };
 
 &main_mcan7 {
-	status = "disabled";
-};
-
-&main_mcan8 {
-	status = "disabled";
-};
-
-&main_mcan9 {
-	status = "disabled";
-};
-
-&main_mcan10 {
-	status = "disabled";
-};
-
-&main_mcan11 {
-	status = "disabled";
-};
-
-&main_mcan12 {
-	status = "disabled";
-};
-
-&main_mcan13 {
-	status = "disabled";
-};
-
-&main_mcan14 {
-	status = "disabled";
-};
-
-&main_mcan15 {
-	status = "disabled";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan7_pins_default>;
+	phys = <&transceiver4>;
 };
 
-&main_mcan17 {
-	status = "disabled";
+&dss {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_vout0_pins_default>;
+	/*
+	 * These clock assignments are chosen to enable the following outputs:
+	 *
+	 * VP0 - DisplayPort SST
+	 * VP1 - DPI0
+	 * VP2 - DSI
+	 * VP3 - DPI1
+	 */
+	assigned-clocks = <&k3_clks 158 2>,
+			  <&k3_clks 158 5>,
+			  <&k3_clks 158 14>,
+			  <&k3_clks 158 18>;
+	assigned-clock-parents = <&k3_clks 158 3>,
+				 <&k3_clks 158 7>,
+				 <&k3_clks 158 16>,
+				 <&k3_clks 158 22>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* HDMI */
+	port@1 {
+		reg = <1>;
+
+		dpi_out0: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
 };
diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
index a64baba14986..3195451d7b14 100644
--- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
@@ -5,15 +5,14 @@
 
 /dts-v1/;
 
-#include "k3-am68-sk-som.dtsi"
+#include <k3-am68-sk-base-board.dts>
 #include "k3-j721s2-ddr-evm-lp4-4266.dtsi"
 #include "k3-j721s2-ddr.dtsi"
 
 / {
 	chosen {
 		firmware-loader = &fs_loader0;
-		stdout-path = &main_uart8;
-		tick-timer = &timer1;
+		tick-timer = &mcu_timer0;
 	};
 
 	aliases {
@@ -49,38 +48,20 @@
 		bootph-pre-ram;
 	};
 
-	clk_19_2mhz: dummy_clock_19_2mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <19200000>;
-		bootph-pre-ram;
-	};
 };
 
-&cbass_mcu_wakeup {
-	sa3_secproxy: secproxy@44880000 {
-		bootph-pre-ram;
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x44880000 0x0 0x20000>,
-		      <0x0 0x44860000 0x0 0x20000>,
-		      <0x0 0x43600000 0x0 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-	};
+&secure_proxy_mcu {
+	bootph-pre-ram;
+};
 
-	mcu_secproxy: secproxy@2a380000 {
-		compatible = "ti,am654-secure-proxy";
-		reg = <0x0 0x2a380000 0x0 0x80000>,
-		      <0x0 0x2a400000 0x0 0x80000>,
-		      <0x0 0x2a480000 0x0 0x80000>;
-		reg-names = "rt", "scfg", "target_data";
-		#mbox-cells = <1>;
-		bootph-pre-ram;
-	};
+&secure_proxy_sa3 {
+	bootph-pre-ram;
+};
 
+&cbass_mcu_wakeup {
 	sysctrler: sysctrler {
 		compatible = "ti,am654-system-controller";
-		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>, <&sa3_secproxy 5>;
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
 		mbox-names = "tx", "rx", "boot_notify";
 		bootph-pre-ram;
 	};
@@ -90,84 +71,20 @@
 		ti,host-id = <3>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&mcu_secproxy 21>,
-			<&mcu_secproxy 23>;
-		bootph-pre-ram;
-	};
-};
-
-&main_pmx0 {
-	main_uart8_pins_default: main-uart8-pins-default {
-		pinctrl-single,pins = <
-			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
-			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-pins-default {
-		pinctrl-single,pins = <
-			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
-			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
-			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
-			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
-			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
-			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
-			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
-			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
-		>;
-	};
-
-	main_usbss0_pins_default: main-usbss0-pins-default {
-		pinctrl-single,pins = <
-			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
-		>;
-	};
-};
-
-&wkup_pmx0 {
-	mcu_uart0_pins_default: mcu-uart0-pins-default {
+		mboxes= <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
 		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /*(C24) WKUP_GPIO0_13.MCU_UART0_RXD*/
-			J721S2_WKUP_IOPAD(0x0f0, PIN_OUTPUT, 0) /*(C25) WKUP_GPIO0_12.MCU_UART0_TXD*/
-		>;
 	};
-
-	wkup_uart0_pins_default: wkup-uart0-pins-default {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /*(E25) WKUP_GPIO0_6.WKUP_UART0_CTSn*/
-			J721S2_WKUP_IOPAD(0x0dc, PIN_OUTPUT, 0) /*(F28) WKUP_GPIO0_7.WKUP_UART0_RTSn*/
-			J721S2_WKUP_IOPAD(0x0b0, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x0b4, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
-		>;
-	};
-
 };
 
 &sms {
-	mboxes= <&mcu_secproxy 8>, <&mcu_secproxy 6>, <&mcu_secproxy 5>;
+	mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
 	mbox-names = "tx", "rx", "notify";
 	ti,host-id = <4>;
 	ti,secure-host;
 	bootph-pre-ram;
 };
 
-&wkup_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_uart0_pins_default>;
-};
-
-&mcu_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_uart0_pins_default>;
-};
-
-&main_uart8 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart8_pins_default>;
-};
-
 &main_sdhci0 {
 	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-am68-sk-som.dtsi b/arch/arm/dts/k3-am68-sk-som.dtsi
index cb1c58fcd154..6c9139f73201 100644
--- a/arch/arm/dts/k3-am68-sk-som.dtsi
+++ b/arch/arm/dts/k3-am68-sk-som.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
@@ -16,7 +16,6 @@
 		      <0x08 0x80000000 0x03 0x80000000>;
 	};
 
-	/* Reserving memory regions still pending */
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -24,104 +23,29 @@
 
 		secure_ddr: optee@9e800000 {
 			reg = <0x00 0x9e800000 0x00 0x01800000>;
-			alignment = <0x1000>;
 			no-map;
 		};
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "disabled";
-};
-
-&mailbox0_cluster1 {
-	status = "disabled";
-};
-
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
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
-&mailbox1_cluster0 {
-	status = "disabled";
-};
-
-&mailbox1_cluster1 {
-	status = "disabled";
-};
-
-&mailbox1_cluster2 {
-	status = "disabled";
-};
-
-&mailbox1_cluster3 {
-	status = "disabled";
-};
-
-&mailbox1_cluster4 {
-	status = "disabled";
-};
-
-&mailbox1_cluster5 {
-	status = "disabled";
-};
-
-&mailbox1_cluster6 {
-	status = "disabled";
-};
-
-&mailbox1_cluster7 {
-	status = "disabled";
-};
-
-&mailbox1_cluster8 {
-	status = "disabled";
+&wkup_pmx2 {
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
+			J721S2_WKUP_IOPAD(0x09c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
+		>;
+	};
 };
 
-&mailbox1_cluster9 {
-	status = "disabled";
-};
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
 
-&mailbox1_cluster10 {
-	status = "disabled";
-};
-
-&mailbox1_cluster11 {
-	status = "disabled";
+	eeprom@51 {
+		/* AT24C512C-MAHM-T */
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+	};
 };

-- 
2.41.0

