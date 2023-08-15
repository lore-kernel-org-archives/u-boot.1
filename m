Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDC6C001DF
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 22:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00BE869B9;
	Wed, 16 Aug 2023 00:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40145869AB; Wed, 16 Aug 2023 00:01:28 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FF4869AE
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 00:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qW26J-0085bD-Gm; Tue, 15 Aug 2023 22:01:19 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 6/6] board: gateworks: venice: updates for
 imx8mp-venice-gw74xx revB PCB
Date: Tue, 15 Aug 2023 15:01:15 -0700
Message-Id: <20230815220115.2000851-6-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815220115.2000851-1-tharvey@gateworks.com>
References: <20230815220115.2000851-1-tharvey@gateworks.com>
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

Update the imx8mp-venice-gw74xx for revB:
 - add CAN1
 - add TIS-TPM on SPI2
 - add FAN controller
 - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
   backward compatible option)
 - M2 socket GPIO's moved

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi |  70 +++--
 arch/arm/dts/imx8mp-venice-gw74xx.dts         | 263 +++++++++++-------
 arch/arm/dts/imx8mp-venice-u-boot.dtsi        |   8 +
 arch/arm/dts/imx8mp-venice.dts                |  14 +
 board/gateworks/venice/spl.c                  |   4 +-
 5 files changed, 227 insertions(+), 132 deletions(-)

diff --git a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
index c3fb040080b6..501bc0ce200e 100644
--- a/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi
@@ -53,67 +53,81 @@
 &gpio2 {
 	bootph-pre-ram;
 
-	pcie1_wdis_hog {
+	m2_pin20 {
+		gpio-hog;
+		input;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "m2_pin20";
+	};
+
+	m2_pin22 {
+		gpio-hog;
+		input;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		line-name = "m2_pin22";
+	};
+
+	tpm_rst_hog {
 		gpio-hog;
-		gpios = <17 GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "pcie1_wdis#";
+		gpios = <12 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
 	};
 
-	pcie2_wdis_hog {
+	pcie1_wdis_hog {
 		gpio-hog;
-		gpios = <18 GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "pcie2_wdis#";
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		line-name = "pcie1_wdis#";
 	};
 
 	pcie3_wdis_hog {
 		gpio-hog;
-		gpios = <14 GPIO_ACTIVE_HIGH>;
 		output-high;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
 		line-name = "pcie3_wdis#";
 	};
-};
 
-&gpio3 {
-	bootph-pre-ram;
-
-	m2_dis2_hog {
+	pcie2_wdis_hog {
 		gpio-hog;
-		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "m2_gdis#";
+		gpios = <18 GPIO_ACTIVE_HIGH>;
+		line-name = "pcie2_wdis#";
 	};
+};
+
+&gpio3 {
+	bootph-pre-ram;
 
-	m2rst_hog {
+	m2_rst {
 		gpio-hog;
+		output-low;
 		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "m2_rst#";
+		line-name = "m2_rst";
 	};
+};
+
+&gpio4 {
+	bootph-pre-ram;
 
-	m2_off_hog {
+	m2_off {
 		gpio-hog;
-		gpios = <14 GPIO_ACTIVE_HIGH>;
 		output-high;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
 		line-name = "m2_off#";
 	};
-};
-
-&gpio4 {
-	bootph-pre-ram;
 
-	m2_dis1_hog {
+	m2_wdis {
 		gpio-hog;
-		gpios = <18 GPIO_ACTIVE_HIGH>;
 		output-high;
+		gpios = <18 GPIO_ACTIVE_HIGH>;
 		line-name = "m2_wdis#";
 	};
 
 	rs485_en {
 		gpio-hog;
-		gpios = <31 GPIO_ACTIVE_HIGH>;
 		output-low;
+		gpios = <31 GPIO_ACTIVE_HIGH>;
 		line-name = "rs485_en";
 	};
 };
@@ -123,15 +137,15 @@
 
 	rs485_half {
 		gpio-hog;
-		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
 		line-name = "rs485_hd";
 	};
 
 	rs485_term {
 		gpio-hog;
-		gpios = <1 GPIO_ACTIVE_HIGH>;
 		output-low;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
 		line-name = "rs485_term";
 	};
 };
diff --git a/arch/arm/dts/imx8mp-venice-gw74xx.dts b/arch/arm/dts/imx8mp-venice-gw74xx.dts
index ceeca4966fc5..7eb285315739 100644
--- a/arch/arm/dts/imx8mp-venice-gw74xx.dts
+++ b/arch/arm/dts/imx8mp-venice-gw74xx.dts
@@ -125,12 +125,22 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_can1>;
+		regulator-name = "can1_stby";
+		gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_can2_stby: regulator-can2-stby {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_can>;
+		pinctrl-0 = <&pinctrl_reg_can2>;
 		regulator-name = "can2_stby";
-		gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio5 5 GPIO_ACTIVE_LOW>;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -164,6 +174,21 @@
 	cpu-supply = <&reg_arm>;
 };
 
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	tpm@0 {
+		compatible = "tcg,tpm_tis-spi";
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		reg = <0x0>;
+		spi-max-frequency = <36000000>;
+	};
+};
+
 /* off-board header */
 &ecspi2 {
 	pinctrl-names = "default";
@@ -204,6 +229,13 @@
 	};
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
@@ -214,38 +246,38 @@
 &gpio1 {
 	gpio-line-names =
 		"", "", "", "", "", "", "", "",
-		"", "", "dio0", "", "dio1", "", "", "",
+		"", "dio0", "", "dio1", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 };
 
 &gpio2 {
 	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "pcie3_wdis#", "",
+		"", "", "", "", "", "", "m2_pin20", "",
+		"", "", "", "", "", "pcie1_wdis#", "pcie3_wdis#", "",
 		"", "", "pcie2_wdis#", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 };
 
 &gpio3 {
 	gpio-line-names =
-		"m2_gdis#", "", "", "", "", "", "", "m2_rst#",
+		"", "", "", "", "", "", "m2_rst", "",
+		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
-		"m2_off#", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 };
 
 &gpio4 {
 	gpio-line-names =
+		"", "", "m2_off#", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "m2_wdis#", "", "", "",
-		"", "", "", "", "", "", "", "uart_rs485";
+		"", "", "m2_wdis#", "", "", "", "", "",
+		"", "", "", "", "", "", "", "rs485_en";
 };
 
 &gpio5 {
 	gpio-line-names =
-		"uart_half", "uart_term", "", "", "", "", "", "",
+		"rs485_hd", "rs485_term", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
@@ -268,6 +300,8 @@
 		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
@@ -286,6 +320,12 @@
 				label = "vdd_bat";
 			};
 
+			channel@16 {
+				gw,mode = <4>;
+				reg = <0x16>;
+				label = "fan_tach";
+			};
+
 			channel@82 {
 				gw,mode = <2>;
 				reg = <0x82>;
@@ -358,6 +398,11 @@
 				gw,voltage-divider-ohms = <10000 10000>;
 			};
 		};
+
+		fan-controller@a {
+			compatible = "gw,gsc-fan";
+			reg = <0x0a>;
+		};
 	};
 
 	gpio: gpio@23 {
@@ -369,85 +414,6 @@
 		interrupts = <4>;
 	};
 
-	pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			reg_arm: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1025000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			BUCK4 {
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK5 {
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1045000>;
-				regulator-max-microvolt = <1155000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1650000>;
-				regulator-max-microvolt = <1950000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO3 {
-				regulator-name = "LDO3";
-				regulator-min-microvolt = <1710000>;
-				regulator-max-microvolt = <1890000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
 	eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
@@ -559,7 +525,6 @@
 	};
 };
 
-/* off-board header */
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -568,6 +533,85 @@
 	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <720000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_arm: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <720000>;
+				regulator-max-microvolt = <1025000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1045000>;
+				regulator-max-microvolt = <1155000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 /* off-board header */
@@ -734,12 +778,14 @@
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09	0x40000040 /* DIO0 */
 			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x40000040 /* DIO1 */
-			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x40000040 /* M2SKT_OFF# */
-			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000150 /* PCIE2_WDIS# */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x40000040 /* M2SKT_OFF# */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000150 /* M2SKT_WDIS# */
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40000040 /* M2SKT_PIN20 */
+			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11	0x40000040 /* M2SKT_PIN22 */
+			MX8MP_IOMUXC_SD2_CLK__GPIO2_IO13	0x40000150 /* PCIE1_WDIS# */
 			MX8MP_IOMUXC_SD2_CMD__GPIO2_IO14	0x40000150 /* PCIE3_WDIS# */
+			MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18	0x40000150 /* PCIE2_WDIS# */
 			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x40000040 /* M2SKT_RST# */
-			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x40000150 /* M2SKT_WDIS# */
-			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00	0x40000150 /* M2SKT_GDIS# */
 			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x40000104 /* UART_TERM */
 			MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31	0x40000104 /* UART_RS485 */
 			MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00	0x40000104 /* UART_HALF */
@@ -792,6 +838,13 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX		0x154
+			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX		0x154
+		>;
+	};
+
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
@@ -877,7 +930,7 @@
 
 	pinctrl_pcie0: pciegrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x110
+			MX8MP_IOMUXC_SD2_DATA2__GPIO2_IO17	0x106
 		>;
 	};
 
@@ -893,12 +946,18 @@
 		>;
 	};
 
-	pinctrl_reg_can: regcangrp {
+	pinctrl_reg_can1: regcan1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x154
 		>;
 	};
 
+	pinctrl_reg_can2: regcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x154
+		>;
+	};
+
 	pinctrl_reg_usb2: regusb2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06	0x140
@@ -911,12 +970,12 @@
 		>;
 	};
 
-	pinctrl_sai2: sai2grp {
+	pinctrl_spi1: spi1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
-			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
-			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
-			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK	0x82
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI	0x82
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO	0x82
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x140
 		>;
 	};
 
diff --git a/arch/arm/dts/imx8mp-venice-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-u-boot.dtsi
index 99d76393d336..07813d03065a 100644
--- a/arch/arm/dts/imx8mp-venice-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-u-boot.dtsi
@@ -73,6 +73,14 @@
 	bootph-pre-ram;
 };
 
+&i2c3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c3 {
+	bootph-pre-ram;
+};
+
 &wdog1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-venice.dts b/arch/arm/dts/imx8mp-venice.dts
index 77e5ac423db3..372db26cc09c 100644
--- a/arch/arm/dts/imx8mp-venice.dts
+++ b/arch/arm/dts/imx8mp-venice.dts
@@ -57,6 +57,13 @@
 	};
 };
 
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
 /* console */
 &uart2 {
 	pinctrl-names = "default";
@@ -106,6 +113,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index 5aa209578b21..41de2af861e2 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -158,9 +158,9 @@ static int power_init_board(void)
 	}
 
 	else if (!strncmp(model, "GW74", 4)) {
-		ret = uclass_get_device_by_seq(UCLASS_I2C, 0, &bus);
+		ret = uclass_get_device_by_seq(UCLASS_I2C, 2, &bus);
 		if (ret) {
-			printf("PMIC    : failed I2C1 probe: %d\n", ret);
+			printf("PMIC    : failed I2C3 probe: %d\n", ret);
 			return ret;
 		}
 		ret = dm_i2c_probe(bus, 0x25, 0, &dev);
-- 
2.25.1

