Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5709CC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6C0884A0;
	Tue, 28 May 2024 13:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BXxbC3VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353A288489; Tue, 28 May 2024 13:25:08 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9450E884A4
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716895503; x=1719487503;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LldnNxqQg/pXPJq/RF0ON3vWc+APfDcLFLpUjIcC0xo=;
 b=BXxbC3VIiWFwCSDYHYAV9Y6iCc+V2xF/D0StVRsGd5chw76oJs5kKNA+SeVurgaU
 2m9jLXGecxha4Z2byNuqQcu7757hMdpYvXEd0gKDTzX2OOwIetIqal+tKMbbsO1u
 Ow6l8M9lBCvwuPJrTnc7iRQQHLFsiERKxr2fg9FQpoo=;
X-AuditID: ac14000a-03251700000021bc-7f-6655bf0fba13
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C2.F7.08636.F0FB5566;
 Tue, 28 May 2024 13:25:03 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 13:25:03 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 28 May 2024 13:25:00 +0200
Subject: [PATCH 2/2] arm: imx8mp-phycore: move to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-phytec_imx8_of_upstream-v1-2-c884c1ddca5f@phytec.de>
References: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
In-Reply-To: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
To: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.13.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR5d/f2iawc6F0hYPr/pbtJ/ysXi7
 t5PdYsrj9ewW3e/UHVg95s06weKxc9Zddo+zd3YwevR3t7B6bHy3gymANYrLJiU1J7MstUjf
 LoEr4+Jiw4Jnixkrjhz6wNjA+KCVsYuRk0NCwERiysldQDYXh5DAEiaJe70fWSGch4wS06e1
 MoNUsQmoSDx+cY8VxGYRUJU4vGgBWFxYwFZix4GpYHFeAUGJkzOfsHQxcnAwC2hKrN+lDxJm
 FpCX2P52DjNEiZfEnUl9LCC2EJDdve8oWJxTwFviy7mn7CB7RQSmAe3dNZ8VojlC4trNJewQ
 lwpLnF8whQ2iWVbixfleqLi8xLRzr5kh7FCJrV+2M01gFJqF5KRZCCfNQnLSAkbmVYxCuZnJ
 2alFmdl6BRmVJanJeimpmxhBgS/CwLWDsW+OxyFGJg7GQ4wSHMxKIrxnJoWmCfGmJFZWpRbl
 xxeV5qQWH2KU5mBREudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamBs1blyb5FlllnMqfKNItVv
 13ByTa31vlGx61qWx6+PhzV/XGDwenN2/63PtQlnyqc6vGGsPfBBKzO1/Jm/0UQZhgC1vblN
 nKeZjj1OWcXl0M4ttOJRdGbTeflDonX/JN8+ktGP71b5UptUbOQe9eZ7TNbtex/368afNJ0h
 mrz7Y1FZh8Oj57FKLMUZiYZazEXFiQCk4aq2agIAAA==
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

The PHYCORE_IMX8MP is used by the phyBOARD-Pollux. Migrate board to
OF_UPSTREAM. Linux kernel device tree for the board can be used as is,
corresponding U-Boot device tree files are removed. U-Boot tweaks are
kept unchanged.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/Makefile                       |   1 -
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts | 361 ----------------------------
 arch/arm/dts/imx8mp-phycore-som.dtsi        | 323 -------------------------
 arch/arm/mach-imx/imx8m/Kconfig             |   1 +
 board/phytec/phycore_imx8mp/MAINTAINERS     |   1 -
 configs/phycore-imx8mp_defconfig            |   2 +-
 6 files changed, 2 insertions(+), 687 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 480f8ff569d..d09d0d84bec 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1033,7 +1033,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
-	imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mq-pico-pi.dtb \
 	imx8mq-kontron-pitx-imx8m.dtb \
 	imx8mq-librem5-r4.dtb
diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts b/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
deleted file mode 100644
index c8640cac3ed..00000000000
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
+++ /dev/null
@@ -1,361 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
-#include "imx8mp-phycore-som.dtsi"
-
-/ {
-	model = "PHYTEC phyBOARD-Pollux i.MX8MP";
-	compatible = "phytec,imx8mp-phyboard-pollux-rdk",
-		     "phytec,imx8mp-phycore-som", "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can1-stby";
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		gpio = <&gpio3 21 GPIO_ACTIVE_LOW>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-	};
-
-	reg_usb1_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb1_vbus>;
-		gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-		regulator-name = "usb1_host_vbus";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100>;
-		off-on-delay-us = <12000>;
-	};
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0x1>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-			enet-phy-lane-no-swap;
-		};
-	};
-};
-
-/* CAN FD */
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
-	status = "okay";
-};
-
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	eeprom@51 {
-		compatible = "atmel,24c02";
-		reg = <0x51>;
-		pagesize = <16>;
-	};
-
-	leds@62 {
-		compatible = "nxp,pca9533";
-		reg = <0x62>;
-
-		led-1 {
-			type = <PCA9532_TYPE_LED>;
-		};
-
-		led-2 {
-			type = <PCA9532_TYPE_LED>;
-		};
-
-		led-3 {
-			type = <PCA9532_TYPE_LED>;
-		};
-	};
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-/* debug console */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* USB1 Host mode Type-A */
-&usb3_phy0 {
-	vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
-
-&usb3_0 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-/* USB2 4-port USB3.0 HUB */
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	fsl,permanently-attached;
-	fsl,disable-port-power-control;
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-/* RS232/RS485 */
-&uart2 {
-	assigned-clocks = <&clk IMX8MP_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-/* SD-Card */
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_pins>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_pins>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_pins>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&gpio1 {
-	gpio-line-names = "", "", "X_PMIC_WDOG_B", "",
-		"PMIC_SD_VSEL", "", "", "", "", "",
-		"", "", "USB1_OTG_PWR", "", "", "X_nETHPHY_INT";
-};
-
-&gpio2 {
-	gpio-line-names = "", "", "", "",
-		"", "", "", "", "", "",
-		"", "", "X_SD2_CD_B", "", "", "",
-		"", "", "", "SD2_RESET_B";
-};
-
-&gpio3 {
-	gpio-line-names = "", "", "", "",
-		"", "", "", "", "", "",
-		"", "", "", "", "", "",
-		"", "", "", "", "nCAN1_EN", "nCAN2_EN";
-};
-
-&gpio4 {
-	gpio-line-names = "", "", "", "",
-		"", "", "", "", "", "",
-		"", "", "", "", "", "",
-		"", "", "X_PMIC_IRQ_B", "", "nENET0_INT_PWDN";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x2
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO			0x2
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0		0x90
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1		0x90
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2		0x90
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3		0x90
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x90
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0		0x16
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x16
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x16
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x16
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
-			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20			0x10
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154
-			MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
-			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
-		>;
-	};
-
-	pinctrl_flexcan1_reg: flexcan1reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x154
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x154
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
-		>;
-	};
-
-	pinctrl_i2c2_gpio: i2c2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1e2
-			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x40
-			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x40
-		>;
-	};
-
-	pinctrl_usb1_vbus: usb1vbusgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12     0x10
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
-			MX8MP_IOMUXC_SAI3_RXC__UART2_DCE_CTS	0x140
-			MX8MP_IOMUXC_SAI3_RXD__UART2_DCE_RTS	0x140
-		>;
-	};
-
-	pinctrl_usdhc2_pins: usdhc2-gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mp-phycore-som.dtsi b/arch/arm/dts/imx8mp-phycore-som.dtsi
deleted file mode 100644
index 79b290a002c..00000000000
--- a/arch/arm/dts/imx8mp-phycore-som.dtsi
+++ /dev/null
@@ -1,323 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
- */
-
-#include <dt-bindings/net/ti-dp83867.h>
-#include "imx8mp.dtsi"
-
-/ {
-	model = "PHYTEC phyCORE-i.MX8MP";
-	compatible = "phytec,imx8mp-phycore-som", "fsl,imx8mp";
-
-	aliases {
-		rtc0 = &rv3028;
-		rtc1 = &snvs_rtc;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-/* ethernet 1 */
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			interrupt-parent = <&gpio1>;
-			interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-			ti,min-output-impedance;
-			enet-phy-lane-no-swap;
-		};
-	};
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi0>;
-	status = "okay";
-
-	som_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	pmic: pmic@25 {
-		reg = <0x25>;
-		compatible = "nxp,pca9450c";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-compatible = "BUCK1";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-compatible = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-			};
-
-			buck4: BUCK4 {
-				regulator-compatible = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5 {
-				regulator-compatible = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-compatible = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-compatible = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2: LDO2 {
-				regulator-compatible = "LDO2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3: LDO3 {
-				regulator-compatible = "LDO3";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-compatible = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo5: LDO5 {
-				regulator-compatible = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c32";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
-
-	rv3028: rtc@52 {
-		compatible = "microcrystal,rv3028";
-		reg = <0x52>;
-		trickle-resistor-ohms = <3000>;
-	};
-};
-
-/* eMMC */
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3_ROOT>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x12
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x12
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x14
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x14
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x14
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x14
-			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x11
-		>;
-	};
-
-	pinctrl_flexspi0: flexspi0grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2
-			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82
-			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82
-			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82
-			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82
-			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x1e3
-			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x1e3
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x141
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d2
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d2
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d2
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d2
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d2
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d2
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d2
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d2
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xe6
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index f81be42d5b0..046c78547b2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -303,6 +303,7 @@ config TARGET_PHYCORE_IMX8MP
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_CL_IOT_GATE
 	bool "CompuLab iot-gate-imx8"
diff --git a/board/phytec/phycore_imx8mp/MAINTAINERS b/board/phytec/phycore_imx8mp/MAINTAINERS
index d3beb978d3a..645476ae30a 100644
--- a/board/phytec/phycore_imx8mp/MAINTAINERS
+++ b/board/phytec/phycore_imx8mp/MAINTAINERS
@@ -2,7 +2,6 @@ phyCORE-i.MX8M Plus
 M:      Teresa Remmet <t.remmet@phytec.de>
 W:      https://www.phytec.eu/product-eu/system-on-modules/phycore-imx-8m-plus/
 S:      Maintained
-F:      arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
 F:      arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
 F:      board/phytec/phycore_imx8mp/
 F:      configs/phycore-imx8mp_defconfig
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index e9a287cb441..6a59a27e3d4 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-phyboard-pollux-rdk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
 CONFIG_PHYTEC_SOM_DETECTION=y

-- 
2.34.1

