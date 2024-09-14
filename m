Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B052FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 00:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F62888A43;
	Sat, 14 Sep 2024 02:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WWAdNlGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7727F88B6D; Sat, 14 Sep 2024 02:56:22 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F36E88915
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 02:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2068a7c9286so16178515ad.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726275377; x=1726880177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x47h2P9THXfhvC3nIWk0+/HLY9jorHNOSjY+I1nLu8U=;
 b=WWAdNlGLpMGJFvgfYmdoUdW5+De7XrFBsmHxAZgXStzjfO7OTdyREuLvm7nCyb6rAX
 XsAtnt92pF/dmHs2sfnuM5VGxIwh7VUn3hYYEQ05rBAmEopbf9syrOSWhxqM6WGH26HW
 Cq0LqpY2tIiluO/YeQI7gAicnD84ebExbBvQ7JC5Jl09si2IjUTkk2CIyVyg/67kXhi7
 aBSsjAzBQRaDB9gTgJSr7P7Aku+KDjw0ii3QX6SBmdJ8OKC4paC0ByGuGSPpaDYpOLBj
 rIs8BmbBDOvlVpq657vmatjZPwpaFAO/k46LePe6clY+X7qL1deJEAhliH7QTTFov56X
 b7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726275377; x=1726880177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x47h2P9THXfhvC3nIWk0+/HLY9jorHNOSjY+I1nLu8U=;
 b=MIdfZ9YAXDvJ4fiAsVDkqL1O8JjJVqWFEie//7R4ePPa3fc2f39VlF4FnkaZ0TJx0T
 VwGo7mDncJDZeOp10Uk0QxWZStQPfd2/W9SpuQxNV6ivkrT1CoMhJmilwYbnxkZyf0Rl
 Iz+WkJsHWTkw/cOOOzCJvwmU51Fq09JO0fcxOzy0+kT86bYB4WyskgybS5o/5vNrsU6K
 N+in1CGnIydbFb9LXxRnriddUEw+AXZyk1igkx/pmWRwFkyeEYClpHLxst7nswjPSX7M
 XpUuXHoesusifCMQwE2m9qXcuZ/65sfvpqM2nwMBiTIAihOcZqevQLvHqhNhi1TPEQft
 jESQ==
X-Gm-Message-State: AOJu0YwVeAMr4nJDBFvs6jNsS9Oe/3FN3UqmUKREFhY/hKL+2RsPbPIV
 Bod7FUbVM4u94oOC0L0TBaU5YUWDP230TefxcQf1RDa7qews2pZUSxCGCg==
X-Google-Smtp-Source: AGHT+IHq40wO4t/4F+YwoAz20eGkLXT/wk/k5EBaCnFBMtiXP5lZjz9zNEAJr6BXmsl1iMnTrlNShQ==
X-Received: by 2002:a17:902:da91:b0:202:3432:230c with SMTP id
 d9443c01a7336-20781d62ac4mr66349305ad.18.1726275376840; 
 Fri, 13 Sep 2024 17:56:16 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f375:804a:5c89:62a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207945db10csm1951195ad.53.2024.09.13.17.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 17:56:16 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx6q-lxr: Add board support
Date: Fri, 13 Sep 2024 21:56:05 -0300
Message-Id: <20240914005605.1827759-1-festevam@gmail.com>
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

Add support for the Comvetia i.MX6Q LXR2 board, which is
uses the Phytec PFLA02 SoM.

Based on the original work from Stefano Babic <sbabic@denx.de>.

The Phytec PFLA02 devicetrees are taken from kernel 6.11-rc7.

The imx6q-lxr.dts has been submitted upstream:

https://lore.kernel.org/linux-devicetree/20240913200906.1753458-3-festevam@gmail.com/

After it gets accepted in mainline (most likely in kernel 6.13),
the lxr2 board can then be switched to OF_UPSTREAM and these device trees
can be removed from U-Boot.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/Makefile                   |   1 +
 arch/arm/dts/imx6q-lxr.dts              |  87 +++++
 arch/arm/dts/imx6q-phytec-pfla02.dtsi   |  17 +
 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi | 467 ++++++++++++++++++++++++
 arch/arm/mach-imx/mx6/Kconfig           |  11 +
 board/comvetia/lxr2/Kconfig             |  12 +
 board/comvetia/lxr2/MAINTAINERS         |   6 +
 board/comvetia/lxr2/Makefile            |   3 +
 board/comvetia/lxr2/lxr2.c              | 388 ++++++++++++++++++++
 board/comvetia/lxr2/lxr2.env            |  34 ++
 configs/lxr2_defconfig                  | 118 ++++++
 include/configs/lxr2.h                  |  23 ++
 12 files changed, 1167 insertions(+)
 create mode 100644 arch/arm/dts/imx6q-lxr.dts
 create mode 100644 arch/arm/dts/imx6q-phytec-pfla02.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
 create mode 100644 board/comvetia/lxr2/Kconfig
 create mode 100644 board/comvetia/lxr2/MAINTAINERS
 create mode 100644 board/comvetia/lxr2/Makefile
 create mode 100644 board/comvetia/lxr2/lxr2.c
 create mode 100644 board/comvetia/lxr2/lxr2.env
 create mode 100644 configs/lxr2_defconfig
 create mode 100644 include/configs/lxr2.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 56d4af518d..05a00e4435 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -812,6 +812,7 @@ dtb-y += \
 	imx6q-icore-rqs.dtb \
 	imx6q-kp.dtb \
 	imx6q-logicpd.dtb \
+	imx6q-lxr.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb\
 	imx6q-nitrogen6x.dtb \
diff --git a/arch/arm/dts/imx6q-lxr.dts b/arch/arm/dts/imx6q-lxr.dts
new file mode 100644
index 0000000000..ae4f8eeb10
--- /dev/null
+++ b/arch/arm/dts/imx6q-lxr.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+//
+// Copyright 2024 Comvetia AG
+
+/dts-v1/;
+#include "imx6q-phytec-pfla02.dtsi"
+
+/ {
+	model = "COMVETIA QSoIP LXR-2";
+	compatible = "comvetia,imx6q-lxr", "phytec,imx6q-pfla02", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	spi {
+		compatible = "spi-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_spi_gpio>;
+		sck-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio5 7 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fpga@0 {
+			compatible = "altr,fpga-passive-serial";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fpga>;
+			nconfig-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+			nstat-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+			confd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&fec {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&usdhc3 {
+	no-1-8-v;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_fpga: fpgagrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06       0x1b0b0
+			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18     0x1b0b0
+			MX6QDL_PAD_DI0_PIN3__GPIO4_IO19     0x1b0b0
+		>;
+	};
+
+	pinctrl_spi_gpio: spigpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT14__GPIO5_IO08  0x1b0b0
+			MX6QDL_PAD_DISP0_DAT13__GPIO5_IO07  0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/dts/imx6q-phytec-pfla02.dtsi
new file mode 100644
index 0000000000..500944bd2a
--- /dev/null
+++ b/arch/arm/dts/imx6q-phytec-pfla02.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
+ */
+
+#include "imx6q.dtsi"
+#include "imx6qdl-phytec-pfla02.dtsi"
+
+/ {
+	model = "Phytec phyFLEX-i.MX6 Quad";
+	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x80000000>;
+	};
+};
diff --git a/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
new file mode 100644
index 0000000000..c0c47adc58
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-phytec-pfla02.dtsi
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Phytec phyFLEX-i.MX6 Quad";
+	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x80000000>;
+	};
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 15 0>;
+		enable-active-high;
+	};
+
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1_vbus>;
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 0 0>;
+		enable-active-high;
+	};
+
+	gpio_leds: leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+		compatible = "gpio-leds";
+
+		led_green: led-green {
+			label = "phyflex:green";
+			gpios = <&gpio1 30 0>;
+		};
+
+		led_red: led-red {
+			label = "phyflex:red";
+			gpios = <&gpio2 31 0>;
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "disabled";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "disabled";
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+
+	som_flash: flash@0 {
+		compatible = "m25p80", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-handle = <&ethphy>;
+	phy-mode = "rgmii";
+	phy-reset-duration = <10>; /* in msecs */
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
+	phy-supply = <&vdd_eth_io_reg>;
+	status = "disabled";
+
+	fec_mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			txc-skew-ps = <1680>;
+			rxc-skew-ps = <1860>;
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	som_eeprom: eeprom@50 {
+		compatible = "catalyst,24c32", "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+
+	pmic@58 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>; /* active-low GPIO2_9 */
+		#interrupt-cells = <2>;
+		interrupt-controller;
+
+		regulators {
+			vddcore_reg: bcore1 {
+				regulator-min-microvolt = <730000>;
+				regulator-max-microvolt = <1380000>;
+				regulator-always-on;
+			};
+
+			vddsoc_reg: bcore2 {
+				regulator-min-microvolt = <730000>;
+				regulator-max-microvolt = <1380000>;
+				regulator-always-on;
+			};
+
+			vdd_ddr3_reg: bpro {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_reg: bperi {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_buckmem_reg: bmem {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_eth_reg: bio {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			vdd_eth_io_reg: ldo4 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+			};
+
+			vdd_mx6_snvs_reg: ldo5 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vdd_3v3_pmic_io_reg: ldo6 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_sd0_reg: ldo9 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vdd_sd1_reg: ldo10 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vdd_mx6_high_reg: ldo11 {
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+		};
+
+		da9063_rtc: rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		da9063_wdog: watchdog {
+			compatible = "dlg,da9063-watchdog";
+		};
+
+		onkey {
+			compatible = "dlg,da9063-onkey";
+			status = "disabled";
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+};
+
+&iomuxc {
+	imx6q-phytec-pfla02 {
+		pinctrl_ecspi3: ecspi3grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
+				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
+				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
+				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x80000000 /* CS0 */
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x80000000 /* Reset GPIO */
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
+			>;
+		};
+
+		pinctrl_gpmi_nand: gpminandgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+				MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_leds: ledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000 /* Green LED */
+				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x80000000 /* Red LED */
+			>;
+		};
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000>;
+		};
+
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <MX6QDL_PAD_SD4_DAT1__GPIO2_IO09	0x80000000>; /* PMIC interrupt */
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D30__UART3_CTS_B		0x1b0b1
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
+			>;
+		};
+
+		pinctrl_usbh1_vbus: usbh1vbusgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			>;
+		};
+
+		pinctrl_usdhc3_cdwp: usdhc3cdwp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x80000000
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
+			>;
+		};
+
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT16__AUD5_TXC	0x130b0
+				MX6QDL_PAD_DISP0_DAT17__AUD5_TXD	0x110b0
+				MX6QDL_PAD_DISP0_DAT18__AUD5_TXFS	0x130b0
+				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
+			>;
+		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio4 17 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
+&reg_arm {
+	vin-supply = <&vddcore_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&vddsoc_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&vddsoc_reg>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "disabled";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "disabled";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "disabled";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&vdd_sd1_reg>;
+	status = "disabled";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3
+		     &pinctrl_usdhc3_cdwp>;
+	cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&vdd_sd0_reg>;
+	status = "disabled";
+};
+
+&wdog1 {
+	/*
+	 * Rely on PMIC reboot handler. Internal i.MX6 watchdog, that is also
+	 * used for reboot, does not reset all external PMIC voltages on reset.
+	 */
+	status = "disabled";
+};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 7a56767225..1f8022ee68 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -541,6 +541,16 @@ config TARGET_LITEBOARD
 	select BOARD_LATE_INIT
 	select MX6UL_LITESOM
 
+config TARGET_LXR2
+	bool "Comvetia i.MX6Q LXR2"
+	depends on MX6Q
+	select BOARD_EARLY_INIT_F
+	select BOARD_LATE_INIT
+	select DM
+	select DM_THERMAL
+	select SUPPORT_SPL
+	imply CMD_DM
+
 config TARGET_PCM058
 	bool "Phytec PCM058 i.MX6 Quad"
 	depends on MX6Q
@@ -696,6 +706,7 @@ source "board/boundary/nitrogen6x/Kconfig"
 source "board/bsh/imx6ulz_smm_m2/Kconfig"
 source "board/bticino/mamoj/Kconfig"
 source "board/compulab/cm_fx6/Kconfig"
+source "board/comvetia/lxr2/Kconfig"
 source "board/dhelectronics/dh_imx6/Kconfig"
 source "board/embest/mx6boards/Kconfig"
 source "board/engicam/imx6q/Kconfig"
diff --git a/board/comvetia/lxr2/Kconfig b/board/comvetia/lxr2/Kconfig
new file mode 100644
index 0000000000..93c7f49071
--- /dev/null
+++ b/board/comvetia/lxr2/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_LXR2
+
+config SYS_BOARD
+	default "lxr2"
+
+config SYS_VENDOR
+	default "comvetia"
+
+config SYS_CONFIG_NAME
+	default "lxr2"
+
+endif
diff --git a/board/comvetia/lxr2/MAINTAINERS b/board/comvetia/lxr2/MAINTAINERS
new file mode 100644
index 0000000000..25db90bb79
--- /dev/null
+++ b/board/comvetia/lxr2/MAINTAINERS
@@ -0,0 +1,6 @@
+COMVETIA LXR2
+M:	Fabio Estevam <festevam@denx.de>
+S:	Maintained
+F:	board/comvetia/lxr2/
+F:	include/configs/lxr2.h
+F:	configs/lxr2_defconfig
diff --git a/board/comvetia/lxr2/Makefile b/board/comvetia/lxr2/Makefile
new file mode 100644
index 0000000000..86b9284521
--- /dev/null
+++ b/board/comvetia/lxr2/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0+
+
+obj-y  := lxr2.o
diff --git a/board/comvetia/lxr2/lxr2.c b/board/comvetia/lxr2/lxr2.c
new file mode 100644
index 0000000000..173263522b
--- /dev/null
+++ b/board/comvetia/lxr2/lxr2.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2017 Stefano Babic <sbabic@denx.de>
+// Copyright (C) 2024 Fabio Estevam <festevam@denx.de>
+
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/iomux.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/boot_mode.h>
+
+#include <asm/mach-imx/spi.h>
+#include <linux/errno.h>
+#include <asm/gpio.h>
+#include <nand.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/sections.h>
+#include <linux/delay.h>
+
+#include <image.h>
+#include <init.h>
+#include <serial.h>
+#include <spl.h>
+#include <linux/sizes.h>
+#include <mmc.h>
+#include <fsl_esdhc_imx.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define UART_PAD_CTRL  (PAD_CTL_PUS_100K_UP |			\
+	PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm |			\
+	PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define SPI_PAD_CTRL (PAD_CTL_HYS | PAD_CTL_SPEED_MED | \
+		      PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST)
+
+#define NAND_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
+	       PAD_CTL_DSE_40ohm | PAD_CTL_SRE_FAST)
+
+int dram_init(void)
+{
+	gd->ram_size = imx_ddr_size();
+	return 0;
+}
+
+static const iomux_v3_cfg_t uart4_pads[] = {
+	MX6_PAD_KEY_COL0__UART4_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+	MX6_PAD_KEY_ROW0__UART4_RX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+};
+
+static void setup_iomux_uart(void)
+{
+	imx_iomux_v3_setup_multiple_pads(uart4_pads, ARRAY_SIZE(uart4_pads));
+}
+
+static void setup_gpmi_nand(void)
+{
+	struct mxc_ccm_reg *mxc_ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	/* gate ENFC_CLK_ROOT clock first,before clk source switch */
+	clrbits_le32(&mxc_ccm->CCGR2, MXC_CCM_CCGR2_IOMUX_IPT_CLK_IO_MASK);
+
+	/* config gpmi and bch clock to 100 MHz */
+	clrsetbits_le32(&mxc_ccm->cs2cdr,
+			MXC_CCM_CS2CDR_ENFC_CLK_PODF_MASK |
+			MXC_CCM_CS2CDR_ENFC_CLK_PRED_MASK |
+			MXC_CCM_CS2CDR_ENFC_CLK_SEL_MASK,
+			MXC_CCM_CS2CDR_ENFC_CLK_PODF(0) |
+			MXC_CCM_CS2CDR_ENFC_CLK_PRED(3) |
+			MXC_CCM_CS2CDR_ENFC_CLK_SEL(3));
+
+	/* enable ENFC_CLK_ROOT clock */
+	setbits_le32(&mxc_ccm->CCGR2, MXC_CCM_CCGR2_IOMUX_IPT_CLK_IO_MASK);
+
+	/* enable gpmi and bch clock gating */
+	setbits_le32(&mxc_ccm->CCGR4,
+		     MXC_CCM_CCGR4_RAWNAND_U_BCH_INPUT_APB_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_BCH_INPUT_BCH_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_BCH_INPUT_GPMI_IO_MASK |
+		     MXC_CCM_CCGR4_RAWNAND_U_GPMI_INPUT_APB_MASK |
+		     MXC_CCM_CCGR4_PL301_MX6QPER1_BCH_OFFSET);
+
+	/* enable apbh clock gating */
+	setbits_le32(&mxc_ccm->CCGR0, MXC_CCM_CCGR0_APBHDMA_MASK);
+}
+
+int board_spi_cs_gpio(unsigned int bus, unsigned int cs)
+{
+	return IMX_GPIO_NR(4, 24);
+}
+
+int board_early_init_f(void)
+{
+	setup_iomux_uart();
+
+	return 0;
+}
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
+
+	setup_gpmi_nand();
+
+	return 0;
+}
+
+/*
+ * BOOT_CFG1, BOOT_CFG2, BOOT_CFG3, BOOT_CFG4
+ * see Table 8-11 and Table 5-9
+ *  BOOT_CFG1[7] = 1 (boot from NAND)
+ *  BOOT_CFG1[5] = 0 - raw NAND
+ *  BOOT_CFG1[4] = 0 - default pad settings
+ *  BOOT_CFG1[3:2] = 00 - devices = 1
+ *  BOOT_CFG1[1:0] = 00 - Row Address Cycles = 3
+ *  BOOT_CFG2[4:3] = 00 - Boot Search Count = 2
+ *  BOOT_CFG2[2:1] = 01 - Pages In Block = 64
+ *  BOOT_CFG2[0] = 0 - Reset time 12ms
+ */
+static const struct boot_mode board_boot_modes[] = {
+	/* NAND: 64pages per block, 3 row addr cycles, 2 copies of FCB/DBBT */
+	{"nand", MAKE_CFGVAL(0x80, 0x02, 0x00, 0x00)},
+	{"mmc0",  MAKE_CFGVAL(0x40, 0x20, 0x00, 0x00)},
+	{NULL, 0},
+};
+
+int board_late_init(void)
+{
+	add_board_boot_modes(board_boot_modes);
+
+	return 0;
+}
+
+#ifdef CONFIG_SPL_BUILD
+#include <spl.h>
+
+#define MX6_PHYFLEX_ERR006282	IMX_GPIO_NR(2, 11)
+static void phyflex_err006282_workaround(void)
+{
+	/*
+	 * Boards beginning with 1362.2 have the SD4_DAT3 pin connected
+	 * to the CMIC. If this pin isn't toggled within 10s the boards
+	 * reset. The pin is unconnected on older boards, so we do not
+	 * need a check for older boards before applying this fixup.
+	 */
+
+	gpio_request(MX6_PHYFLEX_ERR006282, "errata_gpio");
+	gpio_direction_output(MX6_PHYFLEX_ERR006282, 0);
+	mdelay(2);
+	gpio_direction_output(MX6_PHYFLEX_ERR006282, 1);
+	mdelay(2);
+	gpio_set_value(MX6_PHYFLEX_ERR006282, 0);
+
+	imx_iomux_v3_setup_pad(MX6_PAD_SD4_DAT3__GPIO2_IO11);
+
+	gpio_direction_input(MX6_PHYFLEX_ERR006282);
+}
+
+static const iomux_v3_cfg_t gpios_pads[] = {
+	MX6_PAD_SD4_DAT3__GPIO2_IO11 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_DAT4__GPIO2_IO12 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_DAT5__GPIO2_IO13 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_DAT6__GPIO2_IO14 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_SD4_DAT7__GPIO2_IO15 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_EIM_EB3__GPIO2_IO31 | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX6_PAD_ENET_TXD0__GPIO1_IO30 | MUX_PAD_CTRL(NO_PAD_CTRL),
+};
+
+static void setup_gpios(void)
+{
+	imx_iomux_v3_setup_multiple_pads(gpios_pads, ARRAY_SIZE(gpios_pads));
+}
+
+static const struct mx6dq_iomux_ddr_regs mx6_ddr_ioregs = {
+	.dram_sdclk_0 = 0x00000030,
+	.dram_sdclk_1 = 0x00000030,
+	.dram_cas = 0x00000030,
+	.dram_ras = 0x00000030,
+	.dram_reset = 0x00000030,
+	.dram_sdcke0 = 0x00003000,
+	.dram_sdcke1 = 0x00003000,
+	.dram_sdba2 = 0x00000030,
+	.dram_sdodt0 = 0x00000030,
+	.dram_sdodt1 = 0x00000030,
+
+	.dram_sdqs0 = 0x00000028,
+	.dram_sdqs1 = 0x00000028,
+	.dram_sdqs2 = 0x00000028,
+	.dram_sdqs3 = 0x00000028,
+	.dram_sdqs4 = 0x00000028,
+	.dram_sdqs5 = 0x00000028,
+	.dram_sdqs6 = 0x00000028,
+	.dram_sdqs7 = 0x00000028,
+	.dram_dqm0 = 0x00000028,
+	.dram_dqm1 = 0x00000028,
+	.dram_dqm2 = 0x00000028,
+	.dram_dqm3 = 0x00000028,
+	.dram_dqm4 = 0x00000028,
+	.dram_dqm5 = 0x00000028,
+	.dram_dqm6 = 0x00000028,
+	.dram_dqm7 = 0x00000028,
+};
+
+static const struct mx6dq_iomux_grp_regs mx6_grp_ioregs = {
+	.grp_ddr_type =  0x000C0000,
+	.grp_ddrmode_ctl =  0x00020000,
+	.grp_ddrpke =  0x00000000,
+	.grp_addds = 0x30,
+	.grp_ctlds = 0x30,
+	.grp_ddrmode =  0x00020000,
+	.grp_b0ds = 0x00000028,
+	.grp_b1ds = 0x00000028,
+	.grp_b2ds = 0x00000028,
+	.grp_b3ds = 0x00000028,
+	.grp_b4ds = 0x00000028,
+	.grp_b5ds = 0x00000028,
+	.grp_b6ds = 0x00000028,
+	.grp_b7ds = 0x00000028,
+};
+
+static const struct mx6_mmdc_calibration mx6_mmcd_calib = {
+	.p0_mpwldectrl0 =  0x00170018,
+	.p0_mpwldectrl1 =  0x003B0039,
+	.p1_mpwldectrl0 =  0x00350048,
+	.p1_mpwldectrl1 =  0x00410052,
+	.p0_mpdgctrl0 =  0x03600374,
+	.p0_mpdgctrl1 =  0x03680360,
+	.p1_mpdgctrl0 =  0x0370037C,
+	.p1_mpdgctrl1 =  0x03700350,
+	.p0_mprddlctl =  0x3A363234,
+	.p1_mprddlctl =  0x3634363C,
+	.p0_mpwrdlctl =  0x38383E3C,
+	.p1_mpwrdlctl =  0x422A483C,
+};
+
+/* MT41K64M16JT-125 (1Gb density) */
+static struct mx6_ddr3_cfg mem_ddr = {
+	.mem_speed = 1600,
+	.density = 1,
+	.width = 16,
+	.banks = 8,
+	.rowaddr = 13,
+	.coladdr = 10,
+	.pagesz = 2,
+	.trcd = 1375,
+	.trcmin = 4875,
+	.trasmin = 3500,
+	.SRT       = 1,
+};
+
+static void ccgr_init(void)
+{
+	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	writel(0x00C03F3F, &ccm->CCGR0);
+	writel(0x0030FC03, &ccm->CCGR1);
+	writel(0x0FFFC000, &ccm->CCGR2);
+	writel(0x3FF00000, &ccm->CCGR3);
+	writel(0x00FFF300, &ccm->CCGR4);
+	writel(0x0F0000C3, &ccm->CCGR5);
+	writel(0x000003FF, &ccm->CCGR6);
+}
+
+static void spl_dram_init(void)
+{
+	struct mx6_ddr_sysinfo sysinfo = {
+		.dsize = 2,
+		.cs_density = 6,
+		.ncs = 2,
+		.cs1_mirror = 1,
+		.rtt_wr = 1,
+		.rtt_nom = 1,
+		.walat = 1,
+		.ralat = 5,
+		.mif3_mode = 3,
+		.bi_on = 1,
+		.sde_to_rst = 0x10,
+		.rst_to_cke = 0x23,
+		.ddr_type = DDR_TYPE_DDR3,
+		.refsel = 1,
+		.refr = 7,
+	};
+
+	mx6dq_dram_iocfg(64, &mx6_ddr_ioregs, &mx6_grp_ioregs);
+	mx6_dram_cfg(&sysinfo, &mx6_mmcd_calib, &mem_ddr);
+}
+
+#define USDHC_PAD_CTRL (PAD_CTL_PUS_47K_UP |			\
+	PAD_CTL_SPEED_LOW | PAD_CTL_DSE_80ohm |			\
+	PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+struct fsl_esdhc_cfg usdhc_cfg[1] = {
+	{USDHC3_BASE_ADDR},
+};
+
+static const iomux_v3_cfg_t usdhc3_pads[] = {
+	MX6_PAD_SD3_CLK__SD3_CLK	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_CMD__SD3_CMD	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT0__SD3_DATA0	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT1__SD3_DATA1	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT2__SD3_DATA2	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT3__SD3_DATA3	| MUX_PAD_CTRL(USDHC_PAD_CTRL),
+};
+
+int board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(usdhc3_pads, ARRAY_SIZE(usdhc3_pads));
+	usdhc_cfg[0].esdhc_base = USDHC3_BASE_ADDR;
+	usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+	usdhc_cfg[0].max_bus_width = 4;
+	gd->arch.sdhc_clk = usdhc_cfg[0].sdhc_clk;
+
+	return fsl_esdhc_initialize(bis, &usdhc_cfg[0]);
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	spl_boot_list[0] = spl_boot_device();
+
+	switch (spl_boot_list[0]) {
+	case BOOT_DEVICE_SPI:
+		spl_boot_list[1] = BOOT_DEVICE_UART;
+		break;
+	case BOOT_DEVICE_MMC1:
+		spl_boot_list[1] = BOOT_DEVICE_SPI;
+		spl_boot_list[2] = BOOT_DEVICE_UART;
+		break;
+	default:
+		printf("Boot device %x\n", spl_boot_list[0]);
+	}
+}
+
+static const iomux_v3_cfg_t ecspi3_pads[] = {
+	MX6_PAD_DISP0_DAT0__ECSPI3_SCLK | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_DISP0_DAT1__ECSPI3_MOSI | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_DISP0_DAT2__ECSPI3_MISO | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_DISP0_DAT3__GPIO4_IO24 | MUX_PAD_CTRL(NO_PAD_CTRL),
+};
+
+static void setup_spi(void)
+{
+	imx_iomux_v3_setup_multiple_pads(ecspi3_pads, ARRAY_SIZE(ecspi3_pads));
+
+	enable_spi_clk(true, 2);
+}
+
+void board_init_f(ulong dummy)
+{
+	/* setup clock gating */
+	ccgr_init();
+
+	/* setup AIPS and disable watchdog */
+	arch_cpu_init();
+
+	/* setup AXI */
+	gpr_init();
+
+	board_early_init_f();
+
+	/* setup GP timer */
+	timer_init();
+
+	/* UART clocks enabled and gd valid - init serial console */
+	preloader_console_init();
+
+	setup_spi();
+
+	setup_gpios();
+
+	/* DDR initialization */
+	spl_dram_init();
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	phyflex_err006282_workaround();
+
+	/* load/boot image from boot device */
+	board_init_r(NULL, 0);
+}
+#endif
diff --git a/board/comvetia/lxr2/lxr2.env b/board/comvetia/lxr2/lxr2.env
new file mode 100644
index 0000000000..ec21380022
--- /dev/null
+++ b/board/comvetia/lxr2/lxr2.env
@@ -0,0 +1,34 @@
+addcons=setenv bootargs ${bootargs} console=${console},${baudrate}
+addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
+addmisc=setenv bootargs ${bootargs} ${miscargs}
+addmtd=run mtdnand;run mtdspi;setenv bootargs ${bootargs} ${mtdparts}
+altbootcmd=run swupdate
+bootcmd=run nandboot;run swupdate
+bootcount=2
+bootlimit=3
+console=ttymxc3
+cpu=armv7
+ethprime=FEC
+fdt_addr_r=0x18000000
+fitfile=fitImage
+flash-all-from-sd-card=env default -f -a;load mmc 0:1 10000000 u-boot.scr;source 10000000;saveenv
+initrd_high=0xffffffff
+kernel_addr_r=0x12000000
+loadaddr=0x12000000
+miscargs=panic=1
+mmcargs=setenv bootargs root=${mmcroot} rw rootwait
+mmcboot=if run mmcload;then run mmcargs addcons addmisc;bootm;fi
+mmcload=mmc rescan;load mmc 0:${mmcpart} ${kernel_addr_r} boot/fitImage
+mmcpart=1
+mmcroot=/dev/mmcblk0p1
+mtdnand=setenv mtdparts mtdparts=gpmi-nand:40m(Kernels),860m(root),-(nand)
+mtdspi=setenv mtdparts ${mtdparts}';spi2.0:1024k(bootloader),64k(env1),64k(env2),-(rescue)'
+nanboot_fit=tftp ${kernel_addr_r} ${board_name}/${fitfile};run nandargs addip addcons addmtd addmisc;bootm
+nandargs=setenv bootargs ubi.mtd=1 root=ubi0:rootfs${ubiroot} rootfstype=ubifs
+nandboot=run mtdnand;ubi part Kernels;ubi readvol ${kernel_addr_r} kernel${ubiroot};run nandargs addip addcons addmtd addmisc;bootm ${kernel_addr_r}
+net_nfs=tftp ${kernel_addr_r} ${board_name}/${bootfile};tftp ${fdt_addr_r} ${board_name}/${fdt_file};run nfsargs addip addcons addmtd addmisc;bootm ${kernel_addr_r} - ${fdt_addr_r}
+net_nfs_fit=tftp ${kernel_addr_r} ${board_name}/${fitfile};run nfsargs addip addcons addmtd addmisc;bootm ${kernel_addr_r}
+netmask=255.255.255.0
+nfsargs=setenv bootargs root=/dev/nfs nfsroot=${serverip}:${nfsroot},v3 panic=1
+swupdate=setenv bootargs root=/dev/ram;run addip addcons addmtd addmisc;sf probe;sf read ${kernel_addr_r} 120000 600000;sf read 14000000 730000 800000;bootm ${kernel_addr_r} 14000000
+ubiroot=1
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
new file mode 100644
index 0000000000..855366d421
--- /dev/null
+++ b/configs/lxr2_defconfig
@@ -0,0 +1,118 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_TEXT_BASE=0x17800000
+CONFIG_SYS_MALLOC_LEN=0xa00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_MX6Q=y
+CONFIG_TARGET_LXR2=y
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx6q-lxr"
+CONFIG_SPL_TEXT_BASE=0x00908000
+CONFIG_SYS_MONITOR_LEN=409600
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_BOOTCOUNT_ADDR=0x020CC068
+CONFIG_SPL=y
+CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
+CONFIG_ENV_OFFSET_REDUND=0x110000
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_LTO=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=715766
+CONFIG_FIT=y
+CONFIG_SPL_FIT_PRINT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYS_PBSIZE=532
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_SPL=y
+CONFIG_CMD_SPL_WRITE_SIZE=0x20000
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_BOOTCOUNT=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=gpmi-nand:40m(Kernels),860m(root),-(nand)"
+CONFIG_CMD_UBI=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
+CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MXC=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_MXS=y
+CONFIG_NAND_MXS_DT=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0xe00000
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_BUS=2
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MXC_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
+CONFIG_IMX_THERMAL=y
diff --git a/include/configs/lxr2.h b/include/configs/lxr2.h
new file mode 100644
index 0000000000..d8d37a4222
--- /dev/null
+++ b/include/configs/lxr2.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+// Copyright (C) Stefano Babic <sbabic@denx.de>
+
+#ifndef __LXR2_CONFIG_H
+#define __LXR2_CONFIG_H
+
+#include <config_distro_bootcmd.h>
+
+#include "mx6_common.h"
+
+#define PHYS_SDRAM_SIZE			SZ_1G
+
+/* Physical Memory Map */
+#define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
+
+#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_ADDR		IRAM_BASE_ADDR
+#define CFG_SYS_INIT_RAM_SIZE		IRAM_SIZE
+
+#define CFG_SYS_FSL_ESDHC_ADDR		0
+#define CFG_MXC_UART_BASE		UART4_BASE
+
+#endif
-- 
2.34.1

