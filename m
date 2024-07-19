Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05DC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 20:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA9B88BC4;
	Fri, 19 Jul 2024 22:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OmVN07UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA77E88C30; Fri, 19 Jul 2024 22:33:28 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F40E688204
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 22:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb5a947b7dso251605a91.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721421204; x=1722026004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWof1NJQXwyvCM04Kf+0i82roYq6GM2nIPoRIIecd7U=;
 b=OmVN07UXqUopS0eM4XWs3WdHMkXwLo7t0ABzNwpVhha95VpBmoanYEiQXlmIyFTvvc
 DZBNfuGeFwugrUluMgj8OYuf/Cry2V0iMwQK84FcR2uFgXUYlVIJA16tf/q9MeZBGu0q
 7GGMrlfUAJSGYA4iVSRT77kxbcdJM3KXCmjVCyoDsue/DkCHCqybOfbUV2KQD3XNshQN
 bZcOZTE4lCi8324GYlDVSw5gIjB77sqwF3H5kg2vZNoPOfjDQH5AoLS3ybpbixSLYDdx
 edZ/YSz//Ycng32WNinqqc02D9B4FgU0yFe2dHkUmilqOs3hxL7B7DwZQAS2slsYTjdU
 i7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721421204; x=1722026004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWof1NJQXwyvCM04Kf+0i82roYq6GM2nIPoRIIecd7U=;
 b=QCoX0Vrm9qkZeixBUR9cDCoUvDltVL3LUkxaYdT0YwVMQBmu2PJMj7Ky1JoZYuOdlb
 E54Kp4AGA0nmUgHmOm/DHXLqL1TWaUNOxIURjFYKTLUltWO+U5cEToOeTzJQwx4sKH42
 hUiRcfb3ZxFfAlsXJ/g75QaNnt+FO1c+tWy9NruOckvTmSaQtl4Lpp0HyWzKC7sUiju7
 zmNpaRrXjmhuLkGMI7GsJAMAZjC3NGU8FZPFVC3ZxchIZ7eGiWLBYxN6ugEPPHhWmuv2
 39bdDc8EU0m+yLsr6NaUFj00XaKvIM2Cm+BfoQKVNYFfPzIIsV7pgOEnD6z+j8hzh3aS
 vmHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAnI9k31JOI6ABjn0ANmeruZmWaxEjXaxE766UHXPyx2eGwG0cMFGDVWmjQ6MIQbGlu/Pt/bo9J7LeqZhtw4WITn4VGA==
X-Gm-Message-State: AOJu0YzWtrBwpzdsjdvu8ulPPRPv6Yl5irrSJfMIR/uyTLXXUPL+lcqt
 7ToC655z8wSaJ4ZFe4fq0mGAzwO1qBKKW0IwSCil5+EcaUOun8x1
X-Google-Smtp-Source: AGHT+IEGo3pmA/Da3EoUiQ0lqxRUuXp+K+x4KibE54zFUrhrv7+9MbHfK1M9LbMLaTPvwky9sekT4w==
X-Received: by 2002:a17:90b:4b0e:b0:2cb:4382:9eff with SMTP id
 98e67ed59e1d1-2cd1608dc4bmr732531a91.6.1721421204319; 
 Fri, 19 Jul 2024 13:33:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:27e4:cf37:80d4:17f5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf8092da9sm2138230a91.37.2024.07.19.13.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 13:33:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 4/4] udoo-neo: Convert to OF_UPSTREAM
Date: Fri, 19 Jul 2024 17:33:11 -0300
Message-Id: <20240719203311.1695523-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719203311.1695523-1-festevam@gmail.com>
References: <20240719203311.1695523-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Instead of using the local imx6sx-udoo-neo  devicetree copies from U-Boot,
convert the imx6sx-udoo-neo boards to OF_UPSTREAM so that the upstream
kernel devicetrees can be used instead.
    
Tested on a imx6sx-udoo-neo-full board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Newly introduced.

 arch/arm/dts/Makefile                     |   5 +-
 arch/arm/dts/imx6sx-udoo-neo-basic.dts    |  33 --
 arch/arm/dts/imx6sx-udoo-neo-extended.dts |  26 --
 arch/arm/dts/imx6sx-udoo-neo-full.dts     |  41 --
 arch/arm/dts/imx6sx-udoo-neo.dtsi         | 482 ----------------------
 arch/arm/mach-imx/mx6/Kconfig             |   1 +
 configs/udoo_neo_defconfig                |   2 +-
 7 files changed, 3 insertions(+), 587 deletions(-)
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-basic.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-extended.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo-full.dts
 delete mode 100644 arch/arm/dts/imx6sx-udoo-neo.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7265e5542574..a4d95c8306bb 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -840,10 +840,7 @@ dtb-$(CONFIG_MX6SLL) += imx6sll-evk.dtb
 dtb-$(CONFIG_MX6SX) += \
 	imx6sx-sabreauto.dtb \
 	imx6sx-sdb.dtb \
-	imx6sx-softing-vining-2000.dtb \
-	imx6sx-udoo-neo-basic.dtb \
-	imx6sx-udoo-neo-extended.dtb \
-	imx6sx-udoo-neo-full.dtb
+	imx6sx-softing-vining-2000.dtb
 
 dtb-$(CONFIG_MX6UL) += \
 	imx6ul-geam.dtb \
diff --git a/arch/arm/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/dts/imx6sx-udoo-neo-basic.dts
deleted file mode 100644
index 205ea26484e3..000000000000
--- a/arch/arm/dts/imx6sx-udoo-neo-basic.dts
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 Andreas Färber
- */
-
-/dts-v1/;
-
-#include "imx6sx-udoo-neo.dtsi"
-
-/ {
-	model = "UDOO Neo Basic";
-	compatible = "udoo,neobasic", "fsl,imx6sx";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>;
-	};
-};
-
-&fec1 {
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-		};
-	};
-};
diff --git a/arch/arm/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/dts/imx6sx-udoo-neo-extended.dts
deleted file mode 100644
index 5817b4985391..000000000000
--- a/arch/arm/dts/imx6sx-udoo-neo-extended.dts
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 Andreas Färber
- */
-
-/dts-v1/;
-
-#include "imx6sx-udoo-neo.dtsi"
-
-/ {
-	model = "UDOO Neo Extended";
-	compatible = "udoo,neoextended", "fsl,imx6sx";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x40000000>;
-	};
-};
-
-&i2c4 { /* Onboard Motion sensors */
-	status = "okay";
-};
-
-&uart3 { /* Bluetooth */
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx6sx-udoo-neo-full.dts b/arch/arm/dts/imx6sx-udoo-neo-full.dts
deleted file mode 100644
index 96f4d89848a3..000000000000
--- a/arch/arm/dts/imx6sx-udoo-neo-full.dts
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 Andreas Färber
- */
-
-/dts-v1/;
-
-#include "imx6sx-udoo-neo.dtsi"
-
-/ {
-	model = "UDOO Neo Full";
-	compatible = "udoo,neofull", "fsl,imx6sx";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x40000000>;
-	};
-};
-
-&fec1 {
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-		};
-	};
-};
-
-&i2c4 { /* Onboard Motion sensors */
-	status = "okay";
-};
-
-&uart3 { /* Bluetooth */
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx6sx-udoo-neo.dtsi b/arch/arm/dts/imx6sx-udoo-neo.dtsi
deleted file mode 100644
index c84ea1fac5e9..000000000000
--- a/arch/arm/dts/imx6sx-udoo-neo.dtsi
+++ /dev/null
@@ -1,482 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2016 Andreas Färber
- */
-
-#include "imx6sx.dtsi"
-
-/ {
-	compatible = "fsl,imx6sx";
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		red {
-			label = "udoo-neo:red:mmc";
-			gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "mmc0";
-		};
-
-		orange {
-			label = "udoo-neo:orange:user";
-			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
-			default-state = "keep";
-		};
-	};
-
-	reg_sdio_pwr: regulator-sdio-pwr {
-		compatible = "regulator-fixed";
-		gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-name = "SDIO_PWR";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-	};
-
-	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_otg1_reg>;
-		regulator-name = "usb_otg1_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_otg2_reg>;
-		regulator-name = "usb_otg2_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_wlan: regulator-wlan {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
-	phy-mode = "rmii";
-	phy-reset-duration = <10>;
-	phy-reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	pmic: pmic@8 {
-		compatible = "fsl,pfuze3000";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1a {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw1c_reg: sw1b {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1850000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1650000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vldo1 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen2_reg: vldo2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vccsd {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: v33 {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 { /* Brick snap in sensors connector */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	clock-frequency = <100000>;
-	status = "okay";
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	hdmi-transmitter@70 {
-		compatible = "nxp,tda998x";
-		reg = <0x70>;
-		interrupts-extended = <&gpio3 27 IRQ_TYPE_LEVEL_LOW>;
-
-		ports {
-			port {
-				hdmi: endpoint {
-					remote-endpoint = <&lcdc>;
-				};
-			};
-		};
-	};
-};
-
-&i2c4 { /* Onboard Motion sensors */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	clock-frequency = <100000>;
-	status = "disabled";
-};
-
-&lcdif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcd>;
-	status = "okay";
-
-	port {
-		lcdc: endpoint {
-			remote-endpoint = <&hdmi>;
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_bt_reg: btreggrp {
-		fsl,pins =
-			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17	0x15059>;
-	};
-
-	pinctrl_enet1: enet1grp {
-		fsl,pins =
-			<MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0xa0b1>,
-			<MX6SX_PAD_ENET1_MDC__ENET1_MDC		0xa0b1>,
-			<MX6SX_PAD_ENET1_MDIO__ENET1_MDIO	0xa0b1>,
-			<MX6SX_PAD_RGMII1_TD0__ENET1_TX_DATA_0	0xa0b1>,
-			<MX6SX_PAD_RGMII1_TD1__ENET1_TX_DATA_1	0xa0b1>,
-			<MX6SX_PAD_RGMII1_TX_CTL__ENET1_TX_EN	0xa0b1>,
-
-			<MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x3081>,
-			<MX6SX_PAD_ENET2_TX_CLK__GPIO2_IO_9	0x3081>,
-			<MX6SX_PAD_RGMII1_RD0__ENET1_RX_DATA_0	0x3081>,
-			<MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1	0x3081>,
-			<MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN	0x3081>,
-			<MX6SX_PAD_RGMII1_RXC__ENET1_RX_ER	0x3081>,
-
-			<MX6SX_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M	0x91>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO00__I2C1_SCL		0x4001b8b1>,
-			<MX6SX_PAD_GPIO1_IO01__I2C1_SDA		0x4001b8b1>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO03__I2C2_SDA		0x4001b8b1>,
-			<MX6SX_PAD_GPIO1_IO02__I2C2_SCL		0x4001b8b1>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins =
-			<MX6SX_PAD_KEY_ROW4__I2C3_SDA			0x4001b8b1>,
-			<MX6SX_PAD_KEY_COL4__I2C3_SCL			0x4001b8b1>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins =
-			<MX6SX_PAD_USB_H_DATA__I2C4_SDA		0x4001b8b1>,
-			<MX6SX_PAD_USB_H_STROBE__I2C4_SCL	0x4001b8b1>;
-	};
-
-	pinctrl_lcd: lcdgrp {
-		fsl,pins = <
-			MX6SX_PAD_LCD1_DATA00__LCDIF1_DATA_0		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA01__LCDIF1_DATA_1		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA02__LCDIF1_DATA_2		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA03__LCDIF1_DATA_3		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA04__LCDIF1_DATA_4		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA05__LCDIF1_DATA_5		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA06__LCDIF1_DATA_6		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA07__LCDIF1_DATA_7		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA08__LCDIF1_DATA_8		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA09__LCDIF1_DATA_9		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA10__LCDIF1_DATA_10		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA11__LCDIF1_DATA_11		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA12__LCDIF1_DATA_12		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA13__LCDIF1_DATA_13		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA14__LCDIF1_DATA_14		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA15__LCDIF1_DATA_15		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA16__LCDIF1_DATA_16		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA17__LCDIF1_DATA_17		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA18__LCDIF1_DATA_18		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA19__LCDIF1_DATA_19		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA20__LCDIF1_DATA_20		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA21__LCDIF1_DATA_21		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA22__LCDIF1_DATA_22		0x4001b0b0
-			MX6SX_PAD_LCD1_DATA23__LCDIF1_DATA_23		0x4001b0b0
-			MX6SX_PAD_LCD1_CLK__LCDIF1_CLK		0x4001b0b0
-			MX6SX_PAD_LCD1_ENABLE__LCDIF1_ENABLE		0x4001b0b0
-			MX6SX_PAD_LCD1_VSYNC__LCDIF1_VSYNC		0x4001b0b0
-			MX6SX_PAD_LCD1_HSYNC__LCDIF1_HSYNC		0x4001b0b0
-			MX6SX_PAD_LCD1_RESET__GPIO3_IO_27		0x4001b0b0
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX	0x1b0b1>,
-			<MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX	0x1b0b1>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO06__UART2_DCE_TX	0x1b0b1>,
-			<MX6SX_PAD_GPIO1_IO07__UART2_DCE_RX	0x1b0b1>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins =
-			<MX6SX_PAD_SD3_DATA4__UART3_DCE_RX	0x13059>,
-			<MX6SX_PAD_SD3_DATA5__UART3_DCE_TX	0x13059>,
-			<MX6SX_PAD_SD3_DATA6__UART3_DCE_RTS	0x13059>,
-			<MX6SX_PAD_SD3_DATA7__UART3_DCE_CTS	0x13059>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins =
-			<MX6SX_PAD_SD4_DATA4__UART5_DCE_RX	0x1b0b1>,
-			<MX6SX_PAD_SD4_DATA5__UART5_DCE_TX	0x1b0b1>;
-	};
-
-	pinctrl_uart6: uart6grp {
-		fsl,pins =
-			<MX6SX_PAD_CSI_DATA00__UART6_RI_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA01__UART6_DSR_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA02__UART6_DTR_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA03__UART6_DCD_B	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA04__UART6_DCE_RX	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA05__UART6_DCE_TX	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA06__UART6_DCE_RTS	0x1b0b1>,
-			<MX6SX_PAD_CSI_DATA07__UART6_DCE_CTS	0x1b0b1>;
-	};
-
-	pinctrl_otg1_reg: otg1grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9	0x10b0>;
-	};
-
-	pinctrl_otg2_reg: otg2grp {
-		fsl,pins =
-			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12	0x10b0>;
-	};
-
-	pinctrl_usb_otg1: usbotg1grp {
-		fsl,pins =
-			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID	0x17059>,
-			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC	0x10b0>;
-	};
-
-	pinctrl_usb_otg2: usbot2ggrp {
-		fsl,pins =
-			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC	0x10b0>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins =
-			<MX6SX_PAD_SD2_CMD__USDHC2_CMD		0x17059>,
-			<MX6SX_PAD_SD2_CLK__USDHC2_CLK		0x10059>,
-			<MX6SX_PAD_SD2_DATA0__USDHC2_DATA0	0x17059>,
-			<MX6SX_PAD_SD2_DATA1__USDHC2_DATA1	0x17059>,
-			<MX6SX_PAD_SD2_DATA2__USDHC2_DATA2	0x17059>,
-			<MX6SX_PAD_SD2_DATA3__USDHC2_DATA3	0x17059>,
-			<MX6SX_PAD_SD1_DATA0__GPIO6_IO_2	0x17059>; /* CD */
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins =
-			<MX6SX_PAD_KEY_COL2__GPIO2_IO_12	0x15059>,
-			<MX6SX_PAD_KEY_ROW1__GPIO2_IO_16	0x13059>,
-			<MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x17069>,
-			<MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x17069>,
-			<MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x17069>,
-			<MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x17069>,
-			<MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x17069>,
-			<MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x10069>,
-			<MX6SX_PAD_CSI_MCLK__OSC32K_32K_OUT	0x10059>;
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* Cortex-M4 serial */
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "disabled";
-};
-
-&uart3 { /* Bluetooth - only on Extended/Full versions */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "disabled";
-
-	bluetooth {
-		compatible = "ti,wl1831-st";
-		enable-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_bt_reg>;
-		max-speed = <921600>;
-	};
-};
-
-/* Arduino serial */
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "disabled";
-};
-
-&uart6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart6>;
-	uart-has-rtscts;
-	status = "disabled";
-};
-
-&usbotg1 { /* J2 micro USB port */
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_otg1>;
-	status = "okay";
-};
-
-&usbotg2 { /* J3 host USB port */
-	vbus-supply = <&reg_usb_otg2_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_otg2>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	vmmc-supply = <&reg_sdio_pwr>;
-	bus-width = <4>;
-	cd-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	wakeup-source;
-	status = "okay";
-};
-
-&usdhc3 { /* Wi-Fi */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	non-removable;
-	vmmc-supply = <&reg_wlan>;
-	cap-power-off-card;
-	wakeup-source;
-	keep-power-in-suspend;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1831";
-		reg = <2>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <16 IRQ_TYPE_EDGE_RISING>;
-		ref-clock-frequency = <38400000>;
-		tcxo-clock-frequency = <26000000>;
-	};
-};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 7800553ae8d9..bee9d5f4877c 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -636,6 +636,7 @@ config TARGET_UDOO_NEO
 	select DM_THERMAL
 	select SUPPORT_SPL
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 config TARGET_SOFTING_VINING_2000
 	bool "Softing VIN|ING 2000"
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 826d5a115043..0c76b005557b 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_MX6SX=y
 CONFIG_TARGET_UDOO_NEO=y
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6sx-udoo-neo-basic"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6sx-udoo-neo-basic"
 CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
-- 
2.34.1

