Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5E5EE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9277083BE1;
	Fri,  6 Feb 2026 21:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="sdUQmGD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB5F83BFE; Fri,  6 Feb 2026 21:55:49 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6BE83642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=dZ2NfcTkQ59gIxMgqf2a/Y5CTDkJYJHXlyv1v7CAPkg=; b=sdUQmGD9G7JczqAdkh2FQKQqDF
 3pqgx+FNvO92lddGyf+iCTlkyVUVmYyn2wjJe1UuK/O9JqHOMM21NJ9ckUlWyn6lS3zrQ8bwCafnO
 KD295PeVwc7Y2rTfIFfZQyjzSaD4piPk0Vt8A5L2mne/MnNiJncpynHz0Q7Ou6A59cow=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSrf-0001FX-Q3; Fri, 06 Feb 2026 15:55:44 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:26 -0500
Message-ID: <20260206205537.2906980-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 3/6] arm: dts: imx8mn-var-som-symphony: migrate to OF_UPSTREAM
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Switch to OF_UPSTREAM to make use of the upstream device trees.

Remove the now obsolete device tree files:
- imx8mn-var-som-symphony.dts
- imx8mn-var-som.dtsi

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx8mn-var-som-symphony.dts | 236 ----------
 arch/arm/dts/imx8mn-var-som.dtsi         | 564 -----------------------
 arch/arm/mach-imx/imx8m/Kconfig          |   1 +
 configs/imx8mn_var_som_defconfig         |   2 +-
 5 files changed, 2 insertions(+), 802 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mn-var-som-symphony.dts
 delete mode 100644 arch/arm/dts/imx8mn-var-som.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3cd762977cb..82ad3035308 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -888,7 +888,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
-	imx8mn-var-som-symphony.dtb \
 	imx8mq-mnt-reform2.dtb \
 	imx8mq-phanbell.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
diff --git a/arch/arm/dts/imx8mn-var-som-symphony.dts b/arch/arm/dts/imx8mn-var-som-symphony.dts
deleted file mode 100644
index 5c8e4e81752..00000000000
--- a/arch/arm/dts/imx8mn-var-som-symphony.dts
+++ /dev/null
@@ -1,236 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019-2020 Variscite Ltd.
- * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-/dts-v1/;
-
-#include "imx8mn-var-som.dtsi"
-
-/ {
-	model = "Variscite VAR-SOM-MX8MN Symphony evaluation board";
-	compatible = "variscite,var-som-mx8mn-symphony", "variscite,var-som-mx8mn", "fsl,imx8mn";
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		key-back {
-			label = "Back";
-			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_BACK>;
-		};
-
-		key-home {
-			label = "Home";
-			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_HOME>;
-		};
-
-		key-menu {
-			label = "Menu";
-			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_MENU>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led {
-			label = "Heartbeat";
-			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	pca9534: gpio@20 {
-		compatible = "nxp,pca9534";
-		reg = <0x20>;
-		gpio-controller;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pca9534>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		#gpio-cells = <2>;
-		wakeup-source;
-
-		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
-		usb3-sata-sel-hog {
-			gpio-hog;
-			gpios = <4 GPIO_ACTIVE_HIGH>;
-			output-low;
-			line-name = "usb3_sata_sel";
-		};
-
-		som-vselect-hog {
-			gpio-hog;
-			gpios = <6 GPIO_ACTIVE_HIGH>;
-			output-low;
-			line-name = "som_vselect";
-		};
-
-		enet-sel-hog {
-			gpio-hog;
-			gpios = <7 GPIO_ACTIVE_HIGH>;
-			output-low;
-			line-name = "enet_sel";
-		};
-	};
-
-	extcon_usbotg1: typec@3d {
-		compatible = "nxp,ptn5150";
-		reg = <0x3d>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ptn5150>;
-		status = "okay";
-	};
-};
-
-&i2c3 {
-	/* Capacitive touch controller */
-	ft5x06_ts: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_captouch>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
-
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-		touchscreen-inverted-x;
-		touchscreen-inverted-y;
-	};
-
-	rtc@68 {
-		compatible = "dallas,ds1337";
-		reg = <0x68>;
-	};
-};
-
-/* Header */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* Header */
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&usbotg1 {
-	disable-over-current;
-	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
-};
-
-&pinctrl_fec1 {
-	fsl,pins = <
-		MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-		MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-		MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-		MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-		MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-		MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-		MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-		MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-		MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-		MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-		MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-		MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-		MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-		MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
-	>;
-};
-
-&pinctrl_fec1_sleep {
-	fsl,pins = <
-		MX8MN_IOMUXC_ENET_MDC_GPIO1_IO16		0x120
-		MX8MN_IOMUXC_ENET_MDIO_GPIO1_IO17		0x120
-		MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x120
-		MX8MN_IOMUXC_ENET_TD2_GPIO1_IO19		0x120
-		MX8MN_IOMUXC_ENET_TD1_GPIO1_IO20		0x120
-		MX8MN_IOMUXC_ENET_TD0_GPIO1_IO21		0x120
-		MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x120
-		MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x120
-		MX8MN_IOMUXC_ENET_RD1_GPIO1_IO27		0x120
-		MX8MN_IOMUXC_ENET_RD0_GPIO1_IO26		0x120
-		MX8MN_IOMUXC_ENET_TXC_GPIO1_IO23		0x120
-		MX8MN_IOMUXC_ENET_RXC_GPIO1_IO25		0x120
-		MX8MN_IOMUXC_ENET_RX_CTL_GPIO1_IO24		0x120
-		MX8MN_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x120
-		/* Remove the MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9 as not used */
-	>;
-};
-
-&iomuxc {
-	pinctrl_captouch: captouchgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SPDIF_RX_GPIO5_IO4		0x16
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_pca9534: pca9534grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16
-		>;
-	};
-
-	pinctrl_ptn5150: ptn5150grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x16
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x41
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
-			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
-			MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-var-som.dtsi b/arch/arm/dts/imx8mn-var-som.dtsi
deleted file mode 100644
index 4eb578a03fc..00000000000
--- a/arch/arm/dts/imx8mn-var-som.dtsi
+++ /dev/null
@@ -1,564 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- * Copyright 2019-2020 Variscite Ltd.
- * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include "imx8mn.dtsi"
-
-/ {
-	model = "Variscite VAR-SOM-MX8MN module";
-	compatible = "variscite,var-som-mx8mn", "fsl,imx8mn";
-
-	aliases {
-		eeprom-som = &eeprom_som;
-	};
-
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x40000000>;
-	};
-
-	reg_eth_phy: regulator-eth-phy {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_eth_phy>;
-		regulator-name = "eth_phy_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>,
-		   <&gpio1  0 GPIO_ACTIVE_LOW>;
-	/delete-property/ dmas;
-	/delete-property/ dma-names;
-	status = "okay";
-
-	/* Resistive touch controller */
-	touchscreen@0 {
-		reg = <0>;
-		compatible = "ti,ads7846";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_restouch>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-
-		spi-max-frequency = <1500000>;
-		pendown-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
-
-		ti,x-min = /bits/ 16 <125>;
-		touchscreen-size-x = <4008>;
-		ti,y-min = /bits/ 16 <282>;
-		touchscreen-size-y = <3864>;
-		ti,x-plate-ohms = /bits/ 16 <180>;
-		touchscreen-max-pressure = <255>;
-		touchscreen-average-samples = <10>;
-		ti,debounce-tol = /bits/ 16 <3>;
-		ti,debounce-rep = /bits/ 16 <1>;
-		ti,settle-delay-usec = /bits/ 16 <150>;
-		ti,keep-vref-on;
-		wakeup-source;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_fec1>;
-	pinctrl-1 = <&pinctrl_fec1_sleep>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy>;
-	phy-supply = <&reg_eth_phy>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@4 { /* AR8033 or ADIN1300 */
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <4>;
-			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			/*
-			 * Deassert delay:
-			 * ADIN1300 requires 5ms.
-			 * AR8033   requires 1ms.
-			 */
-			reset-deassert-us = <20000>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@4b {
-		compatible = "rohm,bd71847";
-		reg = <0x4b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-		rohm,reset-snvs-powered;
-
-		regulators {
-			buck1_reg: BUCK1 {
-				regulator-name = "buck1";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "buck2";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
-			};
-
-			buck3_reg: BUCK3 {
-				regulator-name = "buck3";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck4_reg: BUCK4 {
-				regulator-name = "buck4";
-				regulator-min-microvolt = <2600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5_reg: BUCK5 {
-				regulator-name = "buck5";
-				regulator-min-microvolt = <1605000>;
-				regulator-max-microvolt = <1995000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6_reg: BUCK6 {
-				regulator-name = "buck6";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1_reg: LDO1 {
-				regulator-name = "ldo1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "ldo2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: LDO3 {
-				regulator-name = "ldo3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: LDO4 {
-				regulator-name = "ldo4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			ldo5_reg: LDO5 {
-				regulator-compatible = "ldo5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			ldo6_reg: LDO6 {
-				regulator-name = "ldo6";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	eeprom_som: eeprom@52 {
-		compatible = "atmel,24c04";
-		reg = <0x52>;
-		pagesize = <16>;
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	/* TODO: configure audio, as of now just put a placeholder */
-	wm8904: codec@1a {
-		compatible = "wlf,wm8904";
-		reg = <0x1a>;
-		status = "disabled";
-	};
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-/* Bluetooth */
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	assigned-clocks = <&clk IMX8MN_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-/* Console */
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	usb-role-switch;
-	status = "okay";
-};
-
-/* WIFI */
-&usdhc1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	bus-width = <4>;
-	non-removable;
-	keep-power-in-suspend;
-	status = "okay";
-
-	brcmf: bcrmf@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
-/* SD */
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MN_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MN_CLK_USDHC3_ROOT>;
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
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x13
-			MX8MN_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x13
-			MX8MN_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x13
-			MX8MN_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x13
-			MX8MN_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x13
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
-		>;
-	};
-
-	pinctrl_fec1_sleep: fec1sleepgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ENET_MDC_GPIO1_IO16		0x120
-			MX8MN_IOMUXC_ENET_MDIO_GPIO1_IO17		0x120
-			MX8MN_IOMUXC_ENET_TD3_GPIO1_IO18		0x120
-			MX8MN_IOMUXC_ENET_TD2_GPIO1_IO19		0x120
-			MX8MN_IOMUXC_ENET_TD1_GPIO1_IO20		0x120
-			MX8MN_IOMUXC_ENET_TD0_GPIO1_IO21		0x120
-			MX8MN_IOMUXC_ENET_RD3_GPIO1_IO29		0x120
-			MX8MN_IOMUXC_ENET_RD2_GPIO1_IO28		0x120
-			MX8MN_IOMUXC_ENET_RD1_GPIO1_IO27		0x120
-			MX8MN_IOMUXC_ENET_RD0_GPIO1_IO26		0x120
-			MX8MN_IOMUXC_ENET_TXC_GPIO1_IO23		0x120
-			MX8MN_IOMUXC_ENET_RXC_GPIO1_IO25		0x120
-			MX8MN_IOMUXC_ENET_RX_CTL_GPIO1_IO24		0x120
-			MX8MN_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x120
-			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x120
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x141
-		>;
-	};
-
-	pinctrl_reg_eth_phy: regethphygrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9	0x41
-		>;
-	};
-
-	pinctrl_restouch: restouchgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x1c0
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_TXFS_UART2_DCE_RX	0x140
-			MX8MN_IOMUXC_SAI3_TXC_UART2_DCE_TX	0x140
-			MX8MN_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B	0x140
-			MX8MN_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B	0x140
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART4_RXD_UART4_DCE_RX	0x140
-			MX8MN_IOMUXC_UART4_TXD_UART4_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
-			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
-			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
-			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
-			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
-			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK	0x190
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d0
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d0
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d0
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d0
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d0
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d0
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d0
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d0
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d0
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK	0x194
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d4
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d4
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d4
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK	0x196
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d6
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d6
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d6
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d6
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d6
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4	0x1d6
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d6
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d6
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7	0x1d6
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index d25e0910328..8b0d48b07b3 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -318,6 +318,7 @@ config TARGET_IMX8MN_VAR_SOM
 	select I2C_EEPROM
 	select DM_ETH_PHY
 	select NVMEM
+	imply OF_UPSTREAM
 
 config TARGET_KONTRON_PITX_IMX8M
 	bool "Support Kontron pITX-imx8m"
diff --git a/configs/imx8mn_var_som_defconfig b/configs/imx8mn_var_som_defconfig
index b9f3b9b8999..95c442389d0 100644
--- a/configs/imx8mn_var_som_defconfig
+++ b/configs/imx8mn_var_som_defconfig
@@ -9,7 +9,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mn-var-som-symphony"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-var-som-symphony"
 CONFIG_TARGET_IMX8MN_VAR_SOM=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
-- 
2.47.3

