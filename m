Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEBBE7D0A4
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 18:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBB3865D0;
	Thu, 21 Sep 2023 20:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695321911;
	bh=d39CxmZwGylb6BAvAFLCe3v8+xW9mf2o8jP8camGMQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOTRMf67CZg75lICtjKY9O0qc+8pl+N8x9rudGAIEjhen4O9mPItIvMEJmBrc866F
	 ee+WfryjETti3EuUfOcBdxXmxGGqRnXiYzvscOJnskr5VyFFreHrmIS4rnvVmSNw5N
	 mVmP0BMDP4S3RF7YPXFV7eh8dFjZvJVwWOmTyjkiPQR3puQcERovRLrUEcn/gi4DJs
	 9WK8hEK94TtQ/GKKuL5TkWy6hDi+tk+ShVjqFOsXfCg6HXy0YQpg4o0Y6sirKTzCQi
	 HAPTmQdEGgDDz8/AoIXJPgVnPhWof48CqkjTPCPL/P8mM/1TTRA42e86UMyzGZrHI5
	 CqKJ57+9vLmwQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBF3386661;
 Thu, 21 Sep 2023 20:45:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695321910;
 bh=d39CxmZwGylb6BAvAFLCe3v8+xW9mf2o8jP8camGMQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XWd1IAvK5EUFu2jiucgLvSsJDhcCFHE5HdMsHg7McuyuGk/9uGP0WvZaTYExz4rfz
 PPcDEjMr+sD4vRWYHpTTSw4WFOQFzEGK6hSzaZkXcdqMhDhw8qKOkyIS0FCXjowaWk
 HjKs6Wm32HyP/XvyB7BF0rLrBekOKhXWRztx9J3hZOUE/2+ULGeEccqfRP2nBfFJ6G
 hL6Vwe0dkXZddVfYkhVQuwk3vSX8AbUTOu4bz4ow4GhOfMnL953bUbfj6Gx/Tm0Vqd
 55tiiYIL/v0kMXA4oqfKjHLv+biihE7o6FzcHJj0fHNUaSCNN2MHMaZhCJ3Kva0zJ2
 WE+1yPioMFl2Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Fabio Estevam <festevam@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 3/5] arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to
 production rev.200
Date: Thu, 21 Sep 2023 20:44:18 +0200
Message-Id: <20230921184420.45186-3-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230921184420.45186-1-marex@denx.de>
References: <20230921184420.45186-1-marex@denx.de>
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

The current imx8mp-dhcom-som.dtsi describes prototype rev.100 SoM,
update the DT to describe production rev.200 SoM which brings the
following changes:
- Fast SoC GPIOs exposed on the SoM edge connector
- Slow GPIOs like component resets moved to I2C GPIO expander
- ADC upgraded from TLA2024 to ADS1015 with conversion interrupt
- EEPROM size increased from 256 B to 4 kiB

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 arch/arm/dts/imx8mp-dhcom-som.dtsi    | 176 +++++++++++++++++++-------
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi |  24 +++-
 configs/imx8mp_dhcom_pdk3_defconfig   |   1 +
 3 files changed, 152 insertions(+), 49 deletions(-)

diff --git a/arch/arm/dts/imx8mp-dhcom-som.dtsi b/arch/arm/dts/imx8mp-dhcom-som.dtsi
index 9fd8bce8065..ea2a567447a 100644
--- a/arch/arm/dts/imx8mp-dhcom-som.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-som.dtsi
@@ -25,9 +25,7 @@
 
 	reg_eth_vio: regulator-eth-vio {
 		compatible = "regulator-fixed";
-		gpio = <&gpio2 10 GPIO_ACTIVE_LOW>;
-		pinctrl-0 = <&pinctrl_enet_vio>;
-		pinctrl-names = "default";
+		gpio = <&ioexp 2 GPIO_ACTIVE_LOW>;
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
@@ -49,6 +47,14 @@
 		startup-delay-us = <100>;
 		vin-supply = <&buck4>;
 	};
+
+	reg_vdd_3p3v_awo: regulator-vdd-3p3v-awo {	/* VDD_3V3_AWO */
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VDD_3P3V_AWO";
+	};
 };
 
 &A53_0 {
@@ -104,7 +110,7 @@
 			reg = <0>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
-			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
 			/* Non-default PHY population option. */
 			status = "disabled";
 		};
@@ -120,7 +126,7 @@
 			reg = <5>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
-			reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
 			/* Default PHY population option. */
 			status = "okay";
 		};
@@ -320,8 +326,9 @@
 	};
 
 	adc@48 {
-		compatible = "ti,tla2024";
+		compatible = "ti,ads1015";
 		reg = <0x48>;
+		interrupts-extended = <&ioexp 7 IRQ_TYPE_EDGE_FALLING>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -368,24 +375,40 @@
 	};
 
 	eeprom0: eeprom@50 {	/* EEPROM with EQoS MAC address */
-		compatible = "atmel,24c02";
-		pagesize = <16>;
+		compatible = "atmel,24c32";	/* M24C32-D */
+		pagesize = <32>;
 		reg = <0x50>;
 	};
 
 	rv3032: rtc@51 {
 		compatible = "microcrystal,rv3032";
 		reg = <0x51>;
-		interrupts-extended = <&gpio5 5 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
+		interrupts-extended = <&ioexp 3 IRQ_TYPE_EDGE_FALLING>;
 	};
 
 	eeprom1: eeprom@53 {	/* EEPROM with FEC MAC address */
-		compatible = "atmel,24c02";
-		pagesize = <16>;
+		compatible = "atmel,24c32";	/* M24C32-D */
+		pagesize = <32>;
 		reg = <0x53>;
 	};
+
+	ioexp: gpio@74 {
+		compatible = "nxp,pca9539";
+		reg = <0x74>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ioexp>;
+
+		gpio-line-names =
+			"BT_REG_EN", "WL_REG_EN", "VIO_SWITCHED_#EN", "RTC_#INT",
+			"ENET_QOS_#RST", "RGB_OSZ_ENABLE", "USB1_ID", "ADC_ALTER_RDY",
+			"DHCOM-W", "DHCOM-V", "DHCOM-U", "DHCOM-T",
+			"BT_HOST_WAKE", "BT_DEV_WAKE", "", "";
+	};
 };
 
 &i2c4 {
@@ -427,6 +450,23 @@
 	pinctrl-0 = <&pinctrl_uart2>;
 	uart-has-rtscts;
 	status = "okay";
+
+	/*
+	 * PLL1 at 80 MHz supplies UART2 root with 80 MHz clock,
+	 * which with 16x oversampling yields 5 Mbdps baud base,
+	 * which can be well divided by 5/4 to achieve 4 Mbdps,
+	 * which is exactly the maximum rate supported by muRata
+	 * 2AE bluetooth UART.
+	 */
+	assigned-clocks = <&clk IMX8MP_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	assigned-clock-rates = <80000000>;
+
+	bluetooth {
+		compatible = "cypress,cyw4373a0-bt";
+		shutdown-gpios = <&ioexp 0 GPIO_ACTIVE_HIGH>;
+		max-speed = <4000000>;
+	};
 };
 
 &uart3 {
@@ -451,8 +491,6 @@
 };
 
 &usb_dwc3_0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb0_vbus>;
 	dr_mode = "otg";
 	status = "okay";
 };
@@ -496,7 +534,7 @@
 		 * connected to the SoC, but can be connected on to
 		 * SoC pin on the carrier board.
 		 */
-		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&ioexp 1 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -538,8 +576,9 @@
 		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
 		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_i
 		     &pinctrl_dhcom_j &pinctrl_dhcom_k &pinctrl_dhcom_l
-		     /* GPIO_M is connected to CLKOUT2 */
-		     &pinctrl_dhcom_int>;
+		     &pinctrl_dhcom_m &pinctrl_dhcom_n &pinctrl_dhcom_o
+		     &pinctrl_dhcom_p &pinctrl_dhcom_q &pinctrl_dhcom_r
+		     &pinctrl_dhcom_s &pinctrl_dhcom_int>;
 	pinctrl-names = "default";
 
 	pinctrl_dhcom_a: dhcom-a-grp {
@@ -626,6 +665,55 @@
 		>;
 	};
 
+	pinctrl_dhcom_m: dhcom-m-grp {
+		fsl,pins = <
+			/* CSIx_MCLK */
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x2
+		>;
+	};
+
+	pinctrl_dhcom_n: dhcom-n-grp {
+		fsl,pins = <
+			/* CSI2_D3- */
+			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x2
+		>;
+	};
+
+	pinctrl_dhcom_o: dhcom-o-grp {
+		fsl,pins = <
+			/* CSI2_D3+ */
+			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x2
+		>;
+	};
+
+	pinctrl_dhcom_p: dhcom-p-grp {
+		fsl,pins = <
+			/* CSI2_D2- */
+			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x2
+		>;
+	};
+
+	pinctrl_dhcom_q: dhcom-q-grp {
+		fsl,pins = <
+			/* CSI2_D2+ */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x2
+		>;
+	};
+
+	pinctrl_dhcom_r: dhcom-r-grp {
+		fsl,pins = <
+			/* CSI2_D1- */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x2
+		>;
+	};
+
+	pinctrl_dhcom_s: dhcom-s-grp {
+		fsl,pins = <
+			/* CSI2_D1+ */
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x2
+		>;
+	};
+
 	pinctrl_dhcom_int: dhcom-int-grp {
 		fsl,pins = <
 			/* INT_HIGHEST_PRIO */
@@ -699,17 +787,9 @@
 		>;
 	};
 
-	pinctrl_enet_vio: dhcom-enet-vio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x22
-		>;
-	};
-
 	pinctrl_ethphy0: dhcom-ethphy0-grp {
 		fsl,pins = <
-			/* ENET1_#RST Reset */
-			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x22
-			/* ENET1_#INT Interrupt */
+			/* ENET_QOS_#INT Interrupt */
 			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19		0x22
 		>;
 	};
@@ -834,6 +914,13 @@
 		>;
 	};
 
+	pinctrl_ioexp: dhcom-ioexp-grp {
+		fsl,pins = <
+			/* #GPIO_EXP_INT */
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x22
+		>;
+	};
+
 	pinctrl_pmic: dhcom-pmic-grp {
 		fsl,pins = <
 			/* PMIC_nINT */
@@ -847,10 +934,21 @@
 		>;
 	};
 
-	pinctrl_rtc: dhcom-rtc-grp {
+	pinctrl_tc9595: dhcom-tc9595-grp {
 		fsl,pins = <
-			/* RTC_#INT Interrupt */
-			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x40000080
+			/* RESET_DSIBRIDGE */
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01		0x40000146
+			/* DSI-CONV_INT Interrupt */
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x141
+		>;
+	};
+
+	pinctrl_sai3: dhcom-sai3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
 		>;
 	};
 
@@ -897,12 +995,6 @@
 		>;
 	};
 
-	pinctrl_usb0_vbus: dhcom-usb0-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO10__USB1_OTG_ID		0x0
-		>;
-	};
-
 	pinctrl_usb1_vbus: dhcom-usb1-grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR		0x6
@@ -918,10 +1010,6 @@
 			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
 			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
 			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
-			/* BT_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x144
-			/* WL_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x144
 		>;
 	};
 
@@ -933,10 +1021,6 @@
 			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
 			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
 			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
-			/* BT_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x144
-			/* WL_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x144
 		>;
 	};
 
@@ -948,10 +1032,6 @@
 			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
 			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
 			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
-			/* BT_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x144
-			/* WL_REG_EN */
-			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x144
 		>;
 	};
 
diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index 00e1db66568..6f21fbe1151 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -167,6 +167,26 @@
 						filename = "imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo";
 					};
 				};
+
+				fdt-dto-imx8mp-dhcom-som-overlay-rev100 {
+					description = "imx8mp-dhcom-som-overlay-rev100";
+					type = "flat_dt";
+					compression = "none";
+
+					blob-ext {
+						filename = "imx8mp-dhcom-som-overlay-rev100.dtbo";
+					};
+				};
+
+				fdt-dto-imx8mp-dhcom-pdk-overlay-rev100 {
+					description = "imx8mp-dhcom-pdk-overlay-rev100";
+					type = "flat_dt";
+					compression = "none";
+
+					blob-ext {
+						filename = "imx8mp-dhcom-pdk-overlay-rev100.dtbo";
+					};
+				};
 			};
 
 			configurations {
@@ -176,7 +196,9 @@
 					fdt = "fdt-1",
 					      "fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast",
 					      "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
-					      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast";
+					      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast",
+					      "fdt-dto-imx8mp-dhcom-som-overlay-rev100",
+					      "fdt-dto-imx8mp-dhcom-pdk-overlay-rev100";
 				};
 			};
 		};
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 55fdde4acd1..b3720c1acbb 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -262,3 +262,4 @@ CONFIG_USB_FUNCTION_ACM=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_DM_PCA953X=y
-- 
2.40.1

