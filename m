Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441FAC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EBF80077;
	Mon,  3 Feb 2025 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaeDPrR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F4E80087; Mon,  3 Feb 2025 14:00:16 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357A38004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 14:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so85339105ad.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 05:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738587611; x=1739192411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObGGL73wZ1fRWGzL/Rk/qyH9zbRticGmx0l4+ehNimw=;
 b=AaeDPrR2NUrYTGX07ofPkEAo1mCN4lysuPO+vwxCSgnmRdoVs+J2mfUNIyYJtNhHmV
 rHVYj/QBONpJVQbs64CXXH/J6bduKuiKglF9B9nGheNOJzVEfFaR7TKp/egroQ+M6cL7
 Pv52IdMEBvLAH7G9FKqm1O4j6UMgRAdiVuWvfX3eduZYayiJBlbyeWrd76R9pL/Y5/GW
 YLggqB/dUSFmV5DjH/ISurXiKBdu42lZUMKXf0DkVAtJjdIbGlDrbY2C1dv6dg23wYUS
 yHkBa7/1mn7jy75+eTrx3pLAFq8It6KhWgp3/KvEp1qUDxQYXcuhsvdBn2GsdiYDyJV+
 5jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738587611; x=1739192411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ObGGL73wZ1fRWGzL/Rk/qyH9zbRticGmx0l4+ehNimw=;
 b=Pn/HrFqndbbIVNzMDP3JlfFc+yqWbmqS1qMgp8E9iKzbW/bjciK1uTofgDHMH250De
 1dCQpeK6ZY36MCJXwQGC7bHetY/eCYgHWEWBMi06/bx5FomibQx1spAiWoLnvwlqcEUp
 yS6tUkffLYq4DMIoDTKleFDKKzmUd6mFCH0u3ay+2Pn5avh+4gSgbQ3ppHTRhSEXi+uO
 VMJ1ky/RpKjL6bgzDWw6KbLizIwwGWZAYT1uGvfVb8WzyR6q5WW+qaLyRcLYkjjbUEJ5
 xEU9Gv0PdWxFOrmYQud7Cl2wtdvaJuZ2C9iYG12vE7gOS3Q063/GxYo0Ugddz3jeHasO
 prTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxjhZXnuUGLNguQdqA3f/PoSilz7OLwBelSh2qBXnQnxo9pXo2iByW/o3lIFuwdrHZT+rYkrg=@lists.denx.de
X-Gm-Message-State: AOJu0YxcLcOfC+8tHgU3nl1SfPTNaJE7IkEWPg7EAxPYS4kH/gMwfsH0
 Ytw4DIbNV3dgBFpkwTdtTt4z8mG1RC2LoE9Wj1NIJ4kRcFi98OKp
X-Gm-Gg: ASbGnctVI+tPkArAzTeNUiT6gYpU5c9ytRBoAz/UOsnmU9qvufUbAk7ramVeTvCxYaI
 lnkfCx3PiSobPg4H+mpzuszE3cnKxvwbz5XRR+g5OtHsgbxPAQ+Dy3oWthDDt4yULSAyBUAC+15
 BySLp76517ObBHI7qqnrBT48E9nXxnpde1Tpf5L+uQaoofJa255+SwP0IO1GtrEON8Zmox1yO6g
 s6ESqlrJMNotPj+0nQT3EyYUbzA2xu+hL36c7RXlhQ9Gpvlq03L7hD55qyRQ0LQM7z2dug1N85e
 XFhPRLnhwLmlMjILslfYd1I+Oqzrsg==
X-Google-Smtp-Source: AGHT+IGMWKYt/o3GhHwaG3cuJYheX6UqMbhfi0BuWT20JgBhtXk+Ji6b+G7IAEm2cIbpGkUCKVWxOQ==
X-Received: by 2002:a05:6a21:32a2:b0:1e0:d4f4:5b39 with SMTP id
 adf61e73a8af0-1ed7a52dc3cmr37162309637.24.1738587611315; 
 Mon, 03 Feb 2025 05:00:11 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a8ad:598f:ed94:a9df])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73001ed4cdasm4877529b3a.131.2025.02.03.05.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 05:00:10 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx6q-lxr: Convert to OF_UPSTREAM
Date: Mon,  3 Feb 2025 09:59:49 -0300
Message-Id: <20250203125949.1622368-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The imx6q-lxr devicetree has landed in kernel 6.13.

Switch to OF_UPSTREAM to make use of the upstream devicetree.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/Makefile                   |   1 -
 arch/arm/dts/imx6q-lxr.dts              |  87 -----
 arch/arm/dts/imx6q-phytec-pfla02.dtsi   |  17 -
 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi | 467 ------------------------
 arch/arm/mach-imx/mx6/Kconfig           |   1 +
 configs/lxr2_defconfig                  |   2 +-
 6 files changed, 2 insertions(+), 573 deletions(-)
 delete mode 100644 arch/arm/dts/imx6q-lxr.dts
 delete mode 100644 arch/arm/dts/imx6q-phytec-pfla02.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0bf3697bdbe0..b95790e30163 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -797,7 +797,6 @@ dtb-y += \
 	imx6q-icore-rqs.dtb \
 	imx6q-kp.dtb \
 	imx6q-logicpd.dtb \
-	imx6q-lxr.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb\
 	imx6q-nitrogen6x.dtb \
diff --git a/arch/arm/dts/imx6q-lxr.dts b/arch/arm/dts/imx6q-lxr.dts
deleted file mode 100644
index ae4f8eeb105d..000000000000
--- a/arch/arm/dts/imx6q-lxr.dts
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-//
-// Copyright 2024 Comvetia AG
-
-/dts-v1/;
-#include "imx6q-phytec-pfla02.dtsi"
-
-/ {
-	model = "COMVETIA QSoIP LXR-2";
-	compatible = "comvetia,imx6q-lxr", "phytec,imx6q-pfla02", "fsl,imx6q";
-
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	spi {
-		compatible = "spi-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_spi_gpio>;
-		sck-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio5 7 GPIO_ACTIVE_HIGH>;
-		num-chipselects = <0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		fpga@0 {
-			compatible = "altr,fpga-passive-serial";
-			reg = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_fpga>;
-			nconfig-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
-			nstat-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
-			confd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-		};
-	};
-};
-
-&ecspi3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-	};
-};
-
-&fec {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-&usdhc3 {
-	no-1-8-v;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fpga: fpgagrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06       0x1b0b0
-			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18     0x1b0b0
-			MX6QDL_PAD_DI0_PIN3__GPIO4_IO19     0x1b0b0
-		>;
-	};
-
-	pinctrl_spi_gpio: spigpiogrp {
-		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT14__GPIO5_IO08  0x1b0b0
-			MX6QDL_PAD_DISP0_DAT13__GPIO5_IO07  0x1b0b0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/dts/imx6q-phytec-pfla02.dtsi
deleted file mode 100644
index 500944bd2a05..000000000000
--- a/arch/arm/dts/imx6q-phytec-pfla02.dtsi
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
- */
-
-#include "imx6q.dtsi"
-#include "imx6qdl-phytec-pfla02.dtsi"
-
-/ {
-	model = "Phytec phyFLEX-i.MX6 Quad";
-	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
-
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x80000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
deleted file mode 100644
index c0c47adc5866..000000000000
--- a/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
+++ /dev/null
@@ -1,467 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
- */
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Phytec phyFLEX-i.MX6 Quad";
-	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
-
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x80000000>;
-	};
-
-	reg_usb_otg_vbus: regulator-usb-otg-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 15 0>;
-		enable-active-high;
-	};
-
-	reg_usb_h1_vbus: regulator-usb-h1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbh1_vbus>;
-		regulator-name = "usb_h1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 0 0>;
-		enable-active-high;
-	};
-
-	gpio_leds: leds {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-		compatible = "gpio-leds";
-
-		led_green: led-green {
-			label = "phyflex:green";
-			gpios = <&gpio1 30 0>;
-		};
-
-		led_red: led-red {
-			label = "phyflex:red";
-			gpios = <&gpio2 31 0>;
-		};
-	};
-};
-
-&audmux {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux>;
-	status = "disabled";
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "disabled";
-};
-
-&ecspi3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	status = "okay";
-	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
-
-	som_flash: flash@0 {
-		compatible = "m25p80", "jedec,spi-nor";
-		spi-max-frequency = <20000000>;
-		reg = <0>;
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-handle = <&ethphy>;
-	phy-mode = "rgmii";
-	phy-reset-duration = <10>; /* in msecs */
-	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
-	phy-supply = <&vdd_eth_io_reg>;
-	status = "disabled";
-
-	fec_mdio: mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			txc-skew-ps = <1680>;
-			rxc-skew-ps = <1860>;
-		};
-	};
-};
-
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	som_eeprom: eeprom@50 {
-		compatible = "catalyst,24c32", "atmel,24c32";
-		pagesize = <32>;
-		reg = <0x50>;
-	};
-
-	pmic@58 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		compatible = "dlg,da9063";
-		reg = <0x58>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <9 IRQ_TYPE_LEVEL_LOW>; /* active-low GPIO2_9 */
-		#interrupt-cells = <2>;
-		interrupt-controller;
-
-		regulators {
-			vddcore_reg: bcore1 {
-				regulator-min-microvolt = <730000>;
-				regulator-max-microvolt = <1380000>;
-				regulator-always-on;
-			};
-
-			vddsoc_reg: bcore2 {
-				regulator-min-microvolt = <730000>;
-				regulator-max-microvolt = <1380000>;
-				regulator-always-on;
-			};
-
-			vdd_ddr3_reg: bpro {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-always-on;
-			};
-
-			vdd_3v3_reg: bperi {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_buckmem_reg: bmem {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_eth_reg: bio {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-			};
-
-			vdd_eth_io_reg: ldo4 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-			};
-
-			vdd_mx6_snvs_reg: ldo5 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-
-			vdd_3v3_pmic_io_reg: ldo6 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_sd0_reg: ldo9 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vdd_sd1_reg: ldo10 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vdd_mx6_high_reg: ldo11 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-			};
-		};
-
-		da9063_rtc: rtc {
-			compatible = "dlg,da9063-rtc";
-		};
-
-		da9063_wdog: watchdog {
-			compatible = "dlg,da9063-watchdog";
-		};
-
-		onkey {
-			compatible = "dlg,da9063-onkey";
-			status = "disabled";
-		};
-	};
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	clock-frequency = <100000>;
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	clock-frequency = <100000>;
-};
-
-&iomuxc {
-	imx6q-phytec-pfla02 {
-		pinctrl_ecspi3: ecspi3grp {
-			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
-				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
-				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
-				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x80000000 /* CS0 */
-			>;
-		};
-
-		pinctrl_enet: enetgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
-				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
-				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
-				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
-				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
-				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
-				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
-				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
-				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
-				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
-				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
-				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
-				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
-				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
-				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x80000000 /* Reset GPIO */
-			>;
-		};
-
-		pinctrl_flexcan1: flexcan1grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
-				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
-			>;
-		};
-
-		pinctrl_gpmi_nand: gpminandgrp {
-			fsl,pins = <
-				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
-				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
-				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
-				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
-				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
-				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
-				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
-				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
-				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
-				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
-				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
-				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
-				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
-				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
-				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
-				MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
-			>;
-		};
-
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
-			>;
-		};
-
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
-				MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
-			>;
-		};
-
-		pinctrl_i2c3: i2c3grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
-				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
-			>;
-		};
-
-		pinctrl_leds: ledsgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000 /* Green LED */
-				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x80000000 /* Red LED */
-			>;
-		};
-
-		pinctrl_pcie: pciegrp {
-			fsl,pins = <MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000>;
-		};
-
-		pinctrl_pmic: pmicgrp {
-			fsl,pins = <MX6QDL_PAD_SD4_DAT1__GPIO2_IO09	0x80000000>; /* PMIC interrupt */
-		};
-
-		pinctrl_uart3: uart3grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
-				MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
-				MX6QDL_PAD_EIM_D30__UART3_CTS_B		0x1b0b1
-			>;
-		};
-
-		pinctrl_uart4: uart4grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
-				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
-			>;
-		};
-
-		pinctrl_usbh1_vbus: usbh1vbusgrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
-			>;
-		};
-
-		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
-				MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
-			>;
-		};
-
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
-				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
-				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
-				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
-				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
-				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			>;
-		};
-
-		pinctrl_usdhc3_cdwp: usdhc3cdwp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x80000000
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
-			>;
-		};
-
-		pinctrl_audmux: audmuxgrp {
-			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT16__AUD5_TXC	0x130b0
-				MX6QDL_PAD_DISP0_DAT17__AUD5_TXD	0x110b0
-				MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS	0x130b0
-				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
-			>;
-		};
-	};
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio4 17 GPIO_ACTIVE_LOW>;
-	status = "disabled";
-};
-
-&reg_arm {
-	vin-supply = <&vddcore_reg>;
-};
-
-&reg_pu {
-	vin-supply = <&vddsoc_reg>;
-};
-
-&reg_soc {
-	vin-supply = <&vddsoc_reg>;
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "disabled";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "disabled";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_h1_vbus>;
-	status = "disabled";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "disabled";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&vdd_sd1_reg>;
-	status = "disabled";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3
-		     &pinctrl_usdhc3_cdwp>;
-	cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&vdd_sd0_reg>;
-	status = "disabled";
-};
-
-&wdog1 {
-	/*
-	 * Rely on PMIC reboot handler. Internal i.MX6 watchdog, that is also
-	 * used for reboot, does not reset all external PMIC voltages on reset.
-	 */
-	status = "disabled";
-};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 4020e16d92dc..2f873ed6ddf1 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -550,6 +550,7 @@ config TARGET_LXR2
 	select DM_THERMAL/
 	select SUPPORT_SPL
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 config TARGET_PCM058
 	bool "Phytec PCM058 i.MX6 Quad"
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index 7ab817960a2c..8db09a53191f 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -13,7 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6Q=y
 CONFIG_TARGET_LXR2=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-lxr"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-lxr"
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-- 
2.34.1

