Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8BC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBD187E4D;
	Thu,  8 Feb 2024 13:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Uyg1VN+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04BD87E37; Thu,  8 Feb 2024 13:03:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B6087E38
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1707393800; x=1709985800;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KSiwRz3IVLa9L6/Wufr09Rfi2Cvg5yG0y/kvEFpJzkQ=;
 b=Uyg1VN+lVYpDIGEYjMGivBkbSRngvHFB08Jjj15OTbeCpsfxFZwzCA+gPJRhxcIA
 iDBbha5dEGzoAaVg+gVbu/4TC/UU4rLxhoaAkzy/WTcTA8DsZluk+oK9L7xePY0t
 23i729fNyGEK7Y5u1WKzLvgGwvpxWDCMcYXf+4Q2Fpc=;
X-AuditID: ac14000a-fadff7000000290d-7b-65c4c308266a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BD.80.10509.803C4C56;
 Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 13:03:19 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 8 Feb 2024 13:03:08 +0100
Subject: [PATCH v3 1/4] imx8mp-phyboard-pollux-rdk: sync with kernel
 devicetree from v6.8-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240208-usb_support-v3-1-e605efd50512@phytec.de>
References: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
In-Reply-To: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707393799; l=5755;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=KSiwRz3IVLa9L6/Wufr09Rfi2Cvg5yG0y/kvEFpJzkQ=;
 b=lg5m4u1ihmr9PccHePv3/SudE5ChLXDA7kfNIMd8fMkrqWlQHRkwzzEdk+j7MzPYHyJTO1Te1
 UG6asqVIUKmDQDhU1dY7LLh0Z9uBDwrsQOTTdSEakbO0Cmds9ppi0ie
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8nAo8tx+EiqwbeV3BYf5rWyWzy86m/R
 fsrHYuqkzewWb/d2sltMebye3aL7nboDu8e8WSdYPHbOusvu8erAKnaPO9f2sHmcvbOD0aO/
 u4XVY+O7HUwB7FFcNimpOZllqUX6dglcGX8mz2Qs+KtT8bJ3L1MD43PlLkZODgkBE4nZLyax
 dTFycQgJLGaSmDXzNAtIQkjgAaPEnHv+IDabgJrErjevWUFsFgEVid1XF4PZwgLxEv+bm8Bs
 XgFBiZMznwD1cnAwC2hKrN+lDxJmFpCX2P52DjNEiZ1Ed8MsdojxdhLLGnaCreIUsJfYc+Ql
 2A0iAtsZJa4t/sUI4jALtDBKTPrfxQgyVEJAWGLTTi2QuITAbiaJmfPXMkPEEyV2vpaDGCor
 cfP8FjaIx+Qlpp17zQxhh0ps/bKdaQKjyCwkp85COHUWklMXMDKvYhTKzUzOTi3KzNYryKgs
 SU3WS0ndxAiKJhEGrh2MfXM8DjEycTAeYpTgYFYS4Q1ZciRViDclsbIqtSg/vqg0J7X4EKM0
 B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA+OiK1s979e+3qnhlOEjOWmCzu388ocMn62P
 /AptLz50XHzD5qzz+ZefbQm6cz/qinpr5drfLTpHV6xPjNtaWdnuETHxeryxAMeUpx1ZD75P
 NuTgaCpdt/CO4zzD1jrLnkvTGC0//H6/SMrZVtJciKnkzb0NCpl7BaVm7fQWVWK89TA3dNKv
 HYpKLMUZiYZazEXFiQCrVuhwlAIAAA==
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

sync devicetree with kernel v6.8-rc2.

New commits on kernel v6.8-rc2:
4a58fcdb1818 arm64: dts: imx8mp-phyboard-pollux: Add support for RS232/RS485
3bd7fdcc359e arm64: dts: imx8mp-phyboard-pollux: Add gpio-line-names
f5faa633daf8 arm64: dts: imx8mp-phyboard-pollux: Enable USB support
27c0dc128d04 arm64: dts: imx8mp-phyboard-pollux: Add flexcan support
fa2a1ec50456 arm64: dts: imx8mp-phyboard-pollux: Add missing usdhc clocks assignment
055e38c76388 arm64: dts: imx8mp-phyboard-pollux-rdk: Fix led sub-node names

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts | 162 +++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts b/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
index 6aa720bafe..c8640cac3e 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
@@ -19,6 +19,36 @@
 		stdout-path = &uart1;
 	};
 
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan1_reg>;
+		gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can1-stby";
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		gpio = <&gpio3 21 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can2-stby";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1_vbus>;
+		gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb1_host_vbus";
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -57,6 +87,21 @@
 	};
 };
 
+/* CAN FD */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -76,15 +121,15 @@
 		compatible = "nxp,pca9533";
 		reg = <0x62>;
 
-		led1 {
+		led-1 {
 			type = <PCA9532_TYPE_LED>;
 		};
 
-		led2 {
+		led-2 {
 			type = <PCA9532_TYPE_LED>;
 		};
 
-		led3 {
+		led-3 {
 			type = <PCA9532_TYPE_LED>;
 		};
 	};
@@ -101,8 +146,51 @@
 	status = "okay";
 };
 
+/* USB1 Host mode Type-A */
+&usb3_phy0 {
+	vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB2 4-port USB3.0 HUB */
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb3_1 {
+	fsl,permanently-attached;
+	fsl,disable-port-power-control;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* RS232/RS485 */
+&uart2 {
+	assigned-clocks = <&clk IMX8MP_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 /* SD-Card */
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_pins>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_pins>;
@@ -113,6 +201,33 @@
 	status = "okay";
 };
 
+&gpio1 {
+	gpio-line-names = "", "", "X_PMIC_WDOG_B", "",
+		"PMIC_SD_VSEL", "", "", "", "", "",
+		"", "", "USB1_OTG_PWR", "", "", "X_nETHPHY_INT";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "",
+		"", "", "", "", "", "",
+		"", "", "X_SD2_CD_B", "", "", "",
+		"", "", "", "SD2_RESET_B";
+};
+
+&gpio3 {
+	gpio-line-names = "", "", "", "",
+		"", "", "", "", "", "",
+		"", "", "", "", "", "",
+		"", "", "", "", "nCAN1_EN", "nCAN2_EN";
+};
+
+&gpio4 {
+	gpio-line-names = "", "", "", "",
+		"", "", "", "", "", "",
+		"", "", "", "", "", "",
+		"", "", "X_PMIC_IRQ_B", "", "nENET0_INT_PWDN";
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -134,6 +249,32 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154
+			MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154
+			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154
+		>;
+	};
+
+	pinctrl_flexcan1_reg: flexcan1reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x154
+		>;
+	};
+
+	pinctrl_flexcan2_reg: flexcan2reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x154
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
@@ -161,6 +302,21 @@
 		>;
 	};
 
+	pinctrl_usb1_vbus: usb1vbusgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12     0x10
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
+			MX8MP_IOMUXC_SAI3_RXC__UART2_DCE_CTS	0x140
+			MX8MP_IOMUXC_SAI3_RXD__UART2_DCE_RTS	0x140
+		>;
+	};
+
 	pinctrl_usdhc2_pins: usdhc2-gpiogrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4

-- 
2.34.1

