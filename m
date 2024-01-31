Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2779C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385C8877D0;
	Wed, 31 Jan 2024 09:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="W0tvBHEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4655487729; Wed, 31 Jan 2024 09:46:04 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8689F87A00
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706690761; x=1709282761;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eVFHJvtghKo5F0TpB1WY/m6pWa9zA4PiqeKziUCKaAc=;
 b=W0tvBHEXLCqwPnjpFCgO1kRlSQHD4jE7WFoy+CF2HGUvcaktX5C4fn+29Rtyc8fx
 pH3f1ANI4AOumD6I1T1drq5qYlsw4cl8HtRgtPPiguyjjPFLanlFDNDX3xRoK/ix
 usUW9ok7eYxQEAwvaER1gb1kHmlCnr2Xa5zf2S5NRdo=;
X-AuditID: ac14000a-fadff7000000290d-a6-65ba08c90ff4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AA.0E.10509.9C80AB56;
 Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jan
 2024 09:46:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 31 Jan 2024 09:45:37 +0100
Subject: [PATCH v2 1/4] imx8mp-phyboard-pollux-rdk: sync with kernel
 devicetree from v6.8-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-usb_support-v2-1-7521c554b597@phytec.de>
References: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
In-Reply-To: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706690760; l=5229;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=eVFHJvtghKo5F0TpB1WY/m6pWa9zA4PiqeKziUCKaAc=;
 b=AzjTUQe8MnWKx4b2UGw3Xu+XcDhqQ75tI1KC4rJUf1m2MdwNZZuPJ3vfZZ+mynb5g3E+MnQDZ
 /6oUsXVmWK/BThZZWhP0Mw2C5UFq8LOsPZEX4HyLCXsUjrOwkP7nriv
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR/ckx65UgxdTBS0eXvW3aD/lYzF1
 0mZ2i7d7O9ktpjxez27R/U7dgc1j3qwTLB47Z91l93h1YBW7x9k7Oxg9+rtbWD02vtvBFMAW
 xWWTkpqTWZZapG+XwJWx/tVz9oL3GhWd026yNzDOUehi5OSQEDCReH6gm72LkYtDSGAxk8S+
 XZdZQBJCAg8ZJY4fVwWx2QTUJHa9ec0KYrMIqEqsvDONHcQWFoiXmLy2EayeV0BQ4uTMJ0A2
 BwezgKbE+l36IGFmAXmJ7W/nMIOEeQXsJPZ2RYKYQkDmrvuxIBWcAvYSv78cBLtARGA7o8S1
 xb8YIaZESbybGARiSggIS2zaqQVSIiGwm0ni+tvlzBDxRImdr+Ug7pWVuHl+CxvEU/IS0869
 ZoawQyWObFrNNIFRZBaSM2chnDkLyZkLGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgRFjAgD
 1w7GvjkehxiZOBgPMUpwMCuJ8K6U25kqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6
 YklqdmpqQWoRTJaJg1OqgTFDcX/Uwq9Wi++veOTyqv3p7sL2uonqXPphsnf/aDj9cBN+VRyn
 rzY7fgIrR0SfzYSS5sfvLldpFu6b0v9B7Fq2z/1/jnsTFxo7Wz98dVzuokj+pWiJd6F2/qrH
 299NV3dK5Li9/32Jqva2o1H6Nw/8WnL+X/PW9gWK4twsYuJzGhvYl3+Yxq/EUpyRaKjFXFSc
 CAAdDx3thgIAAA==
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

