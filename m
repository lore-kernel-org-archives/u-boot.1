Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A240BC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279A883923;
	Tue,  5 Aug 2025 19:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD6383923; Tue,  5 Aug 2025 19:51:18 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE5183885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 4A1981F00036
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:51:14 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id BDC3FB011F6; Tue,  5 Aug 2025 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 8F373B011EB;
 Tue,  5 Aug 2025 17:48:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 05/11] sunxi: Switch V3/V3s device-tree source to
 OF_UPSTREAM
Date: Tue,  5 Aug 2025 19:48:21 +0200
Message-ID: <20250805174827.3696191-6-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

There is nothing special for u-boot in the V3/V3s device-tree files,
they are just copies of the upstream ones.

Remove the copies and switch to OF_UPSTREAM for supported boards.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/dts/Makefile                         |   5 -
 arch/arm/dts/sun8i-s3-elimo-impetus.dtsi      |  44 --
 arch/arm/dts/sun8i-s3-elimo-initium.dts       |  29 -
 arch/arm/dts/sun8i-s3-lichee-zero-plus.dts    |  53 --
 arch/arm/dts/sun8i-s3-pinecube.dts            | 228 ------
 arch/arm/dts/sun8i-v3-sl631-imx179.dts        |  12 -
 arch/arm/dts/sun8i-v3-sl631.dtsi              | 138 ----
 arch/arm/dts/sun8i-v3.dtsi                    |  63 --
 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts   | 276 --------
 arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts | 105 ---
 arch/arm/dts/sun8i-v3s-licheepi-zero.dts      | 101 ---
 arch/arm/dts/sun8i-v3s.dtsi                   | 656 ------------------
 arch/arm/mach-sunxi/Kconfig                   |   1 +
 configs/LicheePi_Zero_defconfig               |   2 +-
 configs/pinecube_defconfig                    |   2 +-
 15 files changed, 3 insertions(+), 1712 deletions(-)
 delete mode 100644 arch/arm/dts/sun8i-s3-elimo-impetus.dtsi
 delete mode 100644 arch/arm/dts/sun8i-s3-elimo-initium.dts
 delete mode 100644 arch/arm/dts/sun8i-s3-lichee-zero-plus.dts
 delete mode 100644 arch/arm/dts/sun8i-s3-pinecube.dts
 delete mode 100644 arch/arm/dts/sun8i-v3-sl631-imx179.dts
 delete mode 100644 arch/arm/dts/sun8i-v3-sl631.dtsi
 delete mode 100644 arch/arm/dts/sun8i-v3.dtsi
 delete mode 100644 arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s-licheepi-zero.dts
 delete mode 100644 arch/arm/dts/sun8i-v3s.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3d93679058c8..d0d25aac1b25 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -646,11 +646,6 @@ dtb-$(CONFIG_MACH_SUN8I_R40) += \
 	sun8i-r40-oka40i-c.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
-dtb-$(CONFIG_MACH_SUN8I_V3_V3S) += \
-	sun8i-s3-elimo-initium.dtb \
-	sun8i-s3-pinecube.dtb \
-	sun8i-v3-sl631-imx179.dtb \
-	sun8i-v3s-licheepi-zero.dtb
 dtb-$(CONFIG_MACH_SUN8I_R528) += \
 	sun8i-t113s-mangopi-mq-r-t113.dtb
 dtb-$(CONFIG_MACH_SUN50I_H5) += \
diff --git a/arch/arm/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/dts/sun8i-s3-elimo-impetus.dtsi
deleted file mode 100644
index 052b010a5607..000000000000
--- a/arch/arm/dts/sun8i-s3-elimo-impetus.dtsi
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
- */
-
-/dts-v1/;
-#include "sun8i-v3.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-/ {
-	model = "Elimo Impetus SoM";
-	compatible = "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pb_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-s3-elimo-initium.dts b/arch/arm/dts/sun8i-s3-elimo-initium.dts
deleted file mode 100644
index 039677c2cc65..000000000000
--- a/arch/arm/dts/sun8i-s3-elimo-initium.dts
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
- */
-
-/dts-v1/;
-#include "sun8i-s3-elimo-impetus.dtsi"
-
-/ {
-	model = "Elimo Initium";
-	compatible = "elimo,initium", "elimo,impetus", "sochip,s3",
-		     "allwinner,sun8i-v3";
-
-	aliases {
-		serial1 = &uart1;
-	};
-};
-
-&uart1 {
-	pinctrl-0 = <&uart1_pg_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-s3-lichee-zero-plus.dts b/arch/arm/dts/sun8i-s3-lichee-zero-plus.dts
deleted file mode 100644
index d18192d51d1b..000000000000
--- a/arch/arm/dts/sun8i-s3-lichee-zero-plus.dts
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
- */
-
-/dts-v1/;
-#include "sun8i-v3.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Sipeed Lichee Zero Plus";
-	compatible = "sipeed,lichee-zero-plus", "sochip,s3",
-		     "allwinner,sun8i-v3";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pb_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-s3-pinecube.dts b/arch/arm/dts/sun8i-s3-pinecube.dts
deleted file mode 100644
index e0d4404b5957..000000000000
--- a/arch/arm/dts/sun8i-s3-pinecube.dts
+++ /dev/null
@@ -1,228 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright 2019 Icenowy Zheng <icenowy@aosc.io>
- */
-
-/dts-v1/;
-#include "sun8i-v3.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "PineCube IP Camera";
-	compatible = "pine64,pinecube", "sochip,s3", "allwinner,sun8i-v3";
-
-	aliases {
-		serial0 = &uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led1 {
-			label = "pine64:ir:led1";
-			gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
-		};
-
-		led2 {
-			label = "pine64:ir:led2";
-			gpios = <&pio 1 12 GPIO_ACTIVE_LOW>; /* PB12 */
-		};
-	};
-
-	reg_vcc5v0: vcc5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_vcc_wifi: vcc-wifi {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-wifi";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pio 1 2 GPIO_ACTIVE_LOW>; /* PB2 WIFI-EN */
-		vin-supply = <&reg_dcdc3>;
-		startup-delay-us = <200000>;
-	};
-
-	wifi_pwrseq: pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 WIFI-RST */
-		post-power-on-delay-ms = <200>;
-	};
-};
-
-&csi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&csi1_8bit_pins>;
-	status = "okay";
-
-	port {
-		csi1_ep: endpoint {
-			remote-endpoint = <&ov5640_ep>;
-			bus-width = <8>;
-			hsync-active = <1>; /* Active high */
-			vsync-active = <0>; /* Active low */
-			data-active = <1>;  /* Active high */
-			pclk-sample = <1>;  /* Rising */
-		};
-	};
-};
-
-&emac {
-	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pe_pins>;
-	status = "okay";
-
-	ov5640: camera@3c {
-		compatible = "ovti,ov5640";
-		reg = <0x3c>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&csi1_mclk_pin>;
-		clocks = <&ccu CLK_CSI1_MCLK>;
-		clock-names = "xclk";
-
-		AVDD-supply = <&reg_ldo3>;
-		DOVDD-supply = <&reg_ldo3>;
-		DVDD-supply = <&reg_ldo4>;
-		reset-gpios = <&pio 4 23 GPIO_ACTIVE_LOW>; /* PE23 */
-		powerdown-gpios = <&pio 4 24 GPIO_ACTIVE_HIGH>; /* PE24 */
-
-		port {
-			ov5640_ep: endpoint {
-				remote-endpoint = <&csi1_ep>;
-				bus-width = <8>;
-				hsync-active = <1>; /* Active high */
-				vsync-active = <0>; /* Active low */
-				data-active = <1>;  /* Active high */
-				pclk-sample = <1>;  /* Rising */
-			};
-		};
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-200 {
-		label = "Setup";
-		linux,code = <KEY_SETUP>;
-		channel = <0>;
-		voltage = <190000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_dcdc3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc_wifi>;
-	vqmmc-supply = <&reg_dcdc3>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
-&pio {
-	vcc-pd-supply = <&reg_dcdc3>;
-	vcc-pe-supply = <&reg_ldo3>;
-};
-
-#include "axp209.dtsi"
-
-&ac_power_supply {
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-sys-cpu-ephy";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-3v3";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_ldo3 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-	regulator-name = "avdd-dovdd-2v8-csi";
-	regulator-soft-start;
-	regulator-ramp-delay = <1600>;
-};
-
-&reg_ldo4 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-name = "dvdd-1v8-csi";
-};
-
-&spi0 {
-	status = "okay";
-
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "winbond,w25q128", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-v3-sl631-imx179.dts b/arch/arm/dts/sun8i-v3-sl631-imx179.dts
deleted file mode 100644
index 117aeece4e55..000000000000
--- a/arch/arm/dts/sun8i-v3-sl631-imx179.dts
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
- */
-
-#include "sun8i-v3-sl631.dtsi"
-
-/ {
-	model = "SL631 Action Camera with IMX179";
-	compatible = "allwinner,sl631-imx179", "allwinner,sl631",
-		     "allwinner,sun8i-v3";
-};
diff --git a/arch/arm/dts/sun8i-v3-sl631.dtsi b/arch/arm/dts/sun8i-v3-sl631.dtsi
deleted file mode 100644
index 6f93f8c49f84..000000000000
--- a/arch/arm/dts/sun8i-v3-sl631.dtsi
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR X11)
-/*
- * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
- */
-
-/dts-v1/;
-
-#include "sun8i-v3.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "SL631 Action Camera";
-	compatible = "allwinner,sl631", "allwinner,sun8i-v3";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pb_pins>;
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-174 {
-		label = "Down";
-		linux,code = <KEY_DOWN>;
-		channel = <0>;
-		voltage = <174603>;
-	};
-
-	button-384 {
-		label = "Up";
-		linux,code = <KEY_UP>;
-		channel = <0>;
-		voltage = <384126>;
-	};
-
-	button-593 {
-		label = "OK";
-		linux,code = <KEY_OK>;
-		channel = <0>;
-		voltage = <593650>;
-	};
-};
-
-&mmc0 {
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-	bus-width = <4>;
-	vmmc-supply = <&reg_dcdc3>;
-	status = "okay";
-};
-
-&pio {
-	vcc-pd-supply = <&reg_dcdc3>;
-	vcc-pe-supply = <&reg_dcdc3>;
-};
-
-#include "axp209.dtsi"
-
-&ac_power_supply {
-	status = "okay";
-};
-
-&battery_power_supply {
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-sys-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vdd-3v3";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&spi0 {
-	status = "okay";
-
-	flash@0 {
-		reg = <0>;
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-	};
-};
-
-&uart1 {
-	pinctrl-0 = <&uart1_pg_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-v3.dtsi b/arch/arm/dts/sun8i-v3.dtsi
deleted file mode 100644
index 186c30cbe6ee..000000000000
--- a/arch/arm/dts/sun8i-v3.dtsi
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
- * Copyright (C) 2021 Tobias Schramm <t.schramm@manjaro.org>
- */
-
-#include "sun8i-v3s.dtsi"
-
-/ {
-	soc {
-		i2s0: i2s@1c22000 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun8i-v3-i2s",
-				     "allwinner,sun8i-h3-i2s";
-			reg = <0x01c22000 0x400>;
-			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
-			clock-names = "apb", "mod";
-			dmas = <&dma 3>, <&dma 3>;
-			dma-names = "rx", "tx";
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2s0_pins>;
-			resets = <&ccu RST_BUS_I2S0>;
-			status = "disabled";
-		};
-	};
-};
-
-&ccu {
-	compatible = "allwinner,sun8i-v3-ccu";
-};
-
-&codec_analog {
-	compatible = "allwinner,sun8i-v3-codec-analog",
-		     "allwinner,sun8i-h3-codec-analog";
-};
-
-&emac {
-	/delete-property/ phy-handle;
-	/delete-property/ phy-mode;
-};
-
-&mdio_mux {
-	external_mdio: mdio@2 {
-		reg = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-};
-
-&pio {
-	compatible = "allwinner,sun8i-v3-pinctrl";
-
-	i2s0_pins: i2s0-pins {
-		pins = "PG10", "PG11", "PG12", "PG13";
-		function = "i2s";
-	};
-
-	uart1_pg_pins: uart1-pg-pins {
-		pins = "PG6", "PG7";
-		function = "uart1";
-	};
-};
diff --git a/arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts b/arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts
deleted file mode 100644
index f34dfdf1566d..000000000000
--- a/arch/arm/dts/sun8i-v3s-anbernic-rg-nano.dts
+++ /dev/null
@@ -1,276 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-/dts-v1/;
-#include <dt-bindings/input/linux-event-codes.h>
-#include "sun8i-v3s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-/ {
-	model = "Anbernic RG Nano";
-	compatible = "anbernic,rg-nano", "allwinner,sun8i-v3s";
-
-	aliases {
-		rtc0 = &pcf8563;
-		rtc1 = &rtc;
-		serial0 = &uart0;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		brightness-levels = <0 1 2 3 8 14 21 32 46 60 80 100>;
-		default-brightness-level = <11>;
-		power-supply = <&reg_vcc5v0>;
-		pwms = <&pwm 0 40000 1>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio_keys: gpio-keys {
-		compatible = "gpio-keys";
-
-		button-a {
-			gpios = <&gpio_expander 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-A";
-			linux,code = <BTN_EAST>;
-		};
-
-		button-b {
-			gpios = <&gpio_expander 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-B";
-			linux,code = <BTN_SOUTH>;
-		};
-
-		button-down {
-			gpios = <&gpio_expander 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "DPAD-DOWN";
-			linux,code = <BTN_DPAD_DOWN>;
-		};
-
-		button-left {
-			gpios = <&gpio_expander 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "DPAD-LEFT";
-			linux,code = <BTN_DPAD_LEFT>;
-		};
-
-		button-right {
-			gpios = <&gpio_expander 0 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "DPAD-RIGHT";
-			linux,code = <BTN_DPAD_RIGHT>;
-		};
-
-		button-se {
-			gpios = <&gpio_expander 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-SELECT";
-			linux,code = <BTN_SELECT>;
-		};
-
-		button-st {
-			gpios = <&gpio_expander 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-START";
-			linux,code = <BTN_START>;
-		};
-
-		button-tl {
-			gpios = <&gpio_expander 2 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-L";
-			linux,code = <BTN_TL>;
-		};
-
-		button-tr {
-			gpios = <&gpio_expander 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-R";
-			linux,code = <BTN_TR>;
-		};
-
-		button-up {
-			gpios = <&gpio_expander 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "DPAD-UP";
-			linux,code = <BTN_DPAD_UP>;
-		};
-
-		button-x {
-			gpios = <&gpio_expander 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-X";
-			linux,code = <BTN_NORTH>;
-		};
-
-		button-y {
-			gpios = <&gpio_expander 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
-			label = "BTN-Y";
-			linux,code = <BTN_WEST>;
-		};
-	};
-};
-
-&codec {
-	allwinner,audio-routing = "Speaker", "HP",
-				  "MIC1", "Mic",
-				  "Mic", "HBIAS";
-	allwinner,pa-gpios = <&pio 5 6 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PF6 */
-	status = "okay";
-};
-
-&ehci {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	gpio_expander: gpio@20 {
-		compatible = "nxp,pcal6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		interrupt-parent = <&pio>;
-		interrupts = <1 3 IRQ_TYPE_EDGE_BOTH>; /* PB3/EINT3 */
-		vcc-supply = <&reg_vcc3v3>;
-	};
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupt-parent = <&pio>;
-		interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5/EINT5 */
-	};
-
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&battery_power_supply {
-	status = "okay";
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	disable-wp;
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&ohci {
-	status = "okay";
-};
-
-&pio {
-	vcc-pb-supply = <&reg_vcc3v3>;
-	vcc-pc-supply = <&reg_vcc3v3>;
-	vcc-pf-supply = <&reg_vcc3v3>;
-	vcc-pg-supply = <&reg_vcc3v3>;
-
-	spi0_no_miso_pins: spi0-no-miso-pins {
-		pins = "PC1", "PC2", "PC3";
-		function = "spi0";
-	};
-};
-
-&pwm {
-	pinctrl-0 = <&pwm0_pin>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-/* DCDC2 wired into vdd-cpu, vdd-sys, and vdd-ephy. */
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-max-microvolt = <1250000>;
-	regulator-min-microvolt = <1250000>;
-	regulator-name = "vdd-cpu";
-};
-
-/* DCDC3 wired into every 3.3v input that isn't the RTC. */
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-max-microvolt = <3300000>;
-	regulator-min-microvolt = <3300000>;
-	regulator-name = "vcc-io";
-};
-
-/* LDO1 wired into RTC, voltage is hard-wired at 3.3v. */
-&reg_ldo1 {
-	regulator-always-on;
-	regulator-name = "vcc-rtc";
-};
-
-/* LDO2 wired into VCC-PLL and audio codec. */
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-max-microvolt = <3000000>;
-	regulator-min-microvolt = <3000000>;
-	regulator-name = "vcc-pll";
-};
-
-/* LDO3, LDO4, and LDO5 unused. */
-&reg_ldo3 {
-	status = "disabled";
-};
-
-&reg_ldo4 {
-	status = "disabled";
-};
-
-/* RTC uses internal oscillator */
-&rtc {
-	/delete-property/ clocks;
-};
-
-&spi0 {
-	pinctrl-0 = <&spi0_no_miso_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	display@0 {
-		compatible = "saef,sftc154b", "panel-mipi-dbi-spi";
-		reg = <0>;
-		backlight = <&backlight>;
-		dc-gpios = <&pio 2 0 GPIO_ACTIVE_HIGH>; /* PC0 */
-		reset-gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
-		spi-max-frequency = <100000000>;
-
-		height-mm = <39>;
-		width-mm = <39>;
-
-		/* Set hb-porch to compensate for non-visible area */
-		panel-timing {
-			hactive = <240>;
-			vactive = <240>;
-			hback-porch = <80>;
-			vback-porch = <0>;
-			clock-frequency = <0>;
-			hfront-porch = <0>;
-			hsync-len = <0>;
-			vfront-porch = <0>;
-			vsync-len = <0>;
-		};
-	};
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pb_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PG5 */
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts
deleted file mode 100644
index 752ad05c8f83..000000000000
--- a/arch/arm/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include "sun8i-v3s-licheepi-zero.dts"
-
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Lichee Pi Zero with Dock";
-	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
-		     "allwinner,sun8i-v3s";
-
-	aliases {
-		ethernet0 = &emac;
-	};
-
-	leds {
-		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
-		status = "disabled";
-	};
-};
-
-&emac {
-	allwinner,leds-active-low;
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button-200 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button-400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-
-	button-600 {
-		label = "Select";
-		linux,code = <KEY_SELECT>;
-		channel = <0>;
-		voltage = <600000>;
-	};
-
-	button-800 {
-		label = "Start";
-		linux,code = <KEY_OK>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-};
-
-&mmc1 {
-	broken-cd;
-	bus-width = <4>;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
deleted file mode 100644
index 2e4587d26ce5..000000000000
--- a/arch/arm/dts/sun8i-v3s-licheepi-zero.dts
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-#include "sun8i-v3s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-/ {
-	model = "Lichee Pi Zero";
-	compatible = "licheepi,licheepi-zero", "allwinner,sun8i-v3s";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		blue_led {
-			label = "licheepi:blue:usr";
-			gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
-		};
-
-		green_led {
-			label = "licheepi:green:usr";
-			gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
-			default-state = "on";
-		};
-
-		red_led {
-			label = "licheepi:red:usr";
-			gpios = <&pio 6 2 GPIO_ACTIVE_LOW>; /* PG2 */
-		};
-	};
-};
-
-&mmc0 {
-	broken-cd;
-	bus-width = <4>;
-	vmmc-supply = <&reg_vcc3v3>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pb_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun8i-v3s.dtsi b/arch/arm/dts/sun8i-v3s.dtsi
deleted file mode 100644
index 9e13c2aa8911..000000000000
--- a/arch/arm/dts/sun8i-v3s.dtsi
+++ /dev/null
@@ -1,656 +0,0 @@
-/*
- * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
- * Copyright (C) 2021 Tobias Schramm <t.schramm@manjaro.org>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/sun6i-rtc.h>
-#include <dt-bindings/clock/sun8i-v3s-ccu.h>
-#include <dt-bindings/reset/sun8i-v3s-ccu.h>
-#include <dt-bindings/clock/sun8i-de2.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&gic>;
-
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer-lcd {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "mixer0-lcd0";
-			clocks = <&display_clocks CLK_MIXER0>,
-				 <&ccu CLK_TCON0>;
-			status = "disabled";
-		};
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <0>;
-			clocks = <&ccu CLK_CPU>;
-		};
-	};
-
-	de: display-engine {
-		compatible = "allwinner,sun8i-v3s-display-engine";
-		allwinner,pipelines = <&mixer0>;
-		status = "disabled";
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		osc24M: osc24M-clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-			clock-accuracy = <50000>;
-			clock-output-names = "osc24M";
-		};
-
-		osc32k: osc32k-clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-accuracy = <50000>;
-			clock-output-names = "ext-osc32k";
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		display_clocks: clock@1000000 {
-			compatible = "allwinner,sun8i-v3s-de2-clk";
-			reg = <0x01000000 0x10000>;
-			clocks = <&ccu CLK_BUS_DE>,
-				 <&ccu CLK_DE>;
-			clock-names = "bus",
-				      "mod";
-			resets = <&ccu RST_BUS_DE>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		mixer0: mixer@1100000 {
-			compatible = "allwinner,sun8i-v3s-de2-mixer";
-			reg = <0x01100000 0x100000>;
-			clocks = <&display_clocks 0>,
-				 <&display_clocks 6>;
-			clock-names = "bus",
-				      "mod";
-			resets = <&display_clocks 0>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				mixer0_out: port@1 {
-					reg = <1>;
-
-					mixer0_out_tcon0: endpoint {
-						remote-endpoint = <&tcon0_in_mixer0>;
-					};
-				};
-			};
-		};
-
-		syscon: system-control@1c00000 {
-			compatible = "allwinner,sun8i-v3s-system-control",
-				     "allwinner,sun8i-h3-system-control";
-			reg = <0x01c00000 0xd0>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-		};
-
-		nmi_intc: interrupt-controller@1c000d0 {
-			compatible = "allwinner,sun8i-v3s-nmi",
-				     "allwinner,sun9i-a80-nmi";
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x01c000d0 0x0c>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		dma: dma-controller@1c02000 {
-			compatible = "allwinner,sun8i-v3s-dma";
-			reg = <0x01c02000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_DMA>;
-			resets = <&ccu RST_BUS_DMA>;
-			#dma-cells = <1>;
-		};
-
-		tcon0: lcd-controller@1c0c000 {
-			compatible = "allwinner,sun8i-v3s-tcon";
-			reg = <0x01c0c000 0x1000>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_TCON0>,
-				 <&ccu CLK_TCON0>;
-			clock-names = "ahb",
-				      "tcon-ch0";
-			clock-output-names = "tcon-data-clock";
-			#clock-cells = <0>;
-			resets = <&ccu RST_BUS_TCON0>;
-			reset-names = "lcd";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tcon0_in: port@0 {
-					reg = <0>;
-
-					tcon0_in_mixer0: endpoint {
-						remote-endpoint = <&mixer0_out_tcon0>;
-					};
-				};
-
-				tcon0_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-			};
-		};
-
-
-		mmc0: mmc@1c0f000 {
-			compatible = "allwinner,sun7i-a20-mmc";
-			reg = <0x01c0f000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC0>,
-				 <&ccu CLK_MMC0>,
-				 <&ccu CLK_MMC0_OUTPUT>,
-				 <&ccu CLK_MMC0_SAMPLE>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ccu RST_BUS_MMC0>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc1: mmc@1c10000 {
-			compatible = "allwinner,sun7i-a20-mmc";
-			reg = <0x01c10000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC1>,
-				 <&ccu CLK_MMC1>,
-				 <&ccu CLK_MMC1_OUTPUT>,
-				 <&ccu CLK_MMC1_SAMPLE>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ccu RST_BUS_MMC1>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc1_pins>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		mmc2: mmc@1c11000 {
-			compatible = "allwinner,sun7i-a20-mmc";
-			reg = <0x01c11000 0x1000>;
-			clocks = <&ccu CLK_BUS_MMC2>,
-				 <&ccu CLK_MMC2>,
-				 <&ccu CLK_MMC2_OUTPUT>,
-				 <&ccu CLK_MMC2_SAMPLE>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			resets = <&ccu RST_BUS_MMC2>;
-			reset-names = "ahb";
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		crypto@1c15000 {
-			compatible = "allwinner,sun8i-v3s-crypto",
-				     "allwinner,sun8i-a33-crypto";
-			reg = <0x01c15000 0x1000>;
-			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma 16>, <&dma 16>;
-			dma-names = "rx", "tx";
-			resets = <&ccu RST_BUS_CE>;
-			reset-names = "ahb";
-		};
-
-		usb_otg: usb@1c19000 {
-			compatible = "allwinner,sun8i-h3-musb";
-			reg = <0x01c19000 0x0400>;
-			clocks = <&ccu CLK_BUS_OTG>;
-			resets = <&ccu RST_BUS_OTG>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mc";
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			extcon = <&usbphy 0>;
-			status = "disabled";
-		};
-
-		usbphy: phy@1c19400 {
-			compatible = "allwinner,sun8i-v3s-usb-phy";
-			reg = <0x01c19400 0x2c>,
-			      <0x01c1a800 0x4>;
-			reg-names = "phy_ctrl",
-				    "pmu0";
-			clocks = <&ccu CLK_USB_PHY0>;
-			clock-names = "usb0_phy";
-			resets = <&ccu RST_USB_PHY0>;
-			reset-names = "usb0_reset";
-			status = "disabled";
-			#phy-cells = <1>;
-		};
-
-		ehci: usb@1c1a000 {
-			compatible = "allwinner,sun8i-v3s-ehci", "generic-ehci";
-			reg = <0x01c1a000 0x100>;
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>;
-			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		ohci: usb@1c1a400 {
-			compatible = "allwinner,sun8i-v3s-ohci", "generic-ohci";
-			reg = <0x01c1a400 0x100>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_EHCI0>, <&ccu CLK_BUS_OHCI0>,
-				 <&ccu CLK_USB_OHCI0>;
-			resets = <&ccu RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
-			phys = <&usbphy 0>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		ccu: clock@1c20000 {
-			compatible = "allwinner,sun8i-v3s-ccu";
-			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
-			clock-names = "hosc", "losc";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		rtc: rtc@1c20400 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-v3-rtc";
-			reg = <0x01c20400 0x54>;
-			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc32k>;
-			clock-output-names = "osc32k", "osc32k-out";
-		};
-
-		pio: pinctrl@1c20800 {
-			compatible = "allwinner,sun8i-v3s-pinctrl";
-			reg = <0x01c20800 0x400>;
-			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>,
-				 <&rtc CLK_OSC32K>;
-			clock-names = "apb", "hosc", "losc";
-			gpio-controller;
-			#gpio-cells = <3>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-
-			/omit-if-no-ref/
-			csi0_mclk_pin: csi0-mclk-pin {
-				pins = "PE20";
-				function = "csi_mipi";
-			};
-
-			/omit-if-no-ref/
-			csi1_8bit_pins: csi1-8bit-pins {
-				pins = "PE0", "PE2", "PE3", "PE8", "PE9",
-				       "PE10", "PE11", "PE12", "PE13", "PE14",
-				       "PE15";
-				function = "csi";
-			};
-
-			/omit-if-no-ref/
-			csi1_mclk_pin: csi1-mclk-pin {
-				pins = "PE1";
-				function = "csi";
-			};
-
-			i2c0_pins: i2c0-pins {
-				pins = "PB6", "PB7";
-				function = "i2c0";
-			};
-
-			/omit-if-no-ref/
-			i2c1_pb_pins: i2c1-pb-pins {
-				pins = "PB8", "PB9";
-				function = "i2c1";
-			};
-
-			/omit-if-no-ref/
-			i2c1_pe_pins: i2c1-pe-pins {
-				pins = "PE21", "PE22";
-				function = "i2c1";
-			};
-
-			uart0_pb_pins: uart0-pb-pins {
-				pins = "PB8", "PB9";
-				function = "uart0";
-			};
-
-			uart2_pins: uart2-pins {
-				pins = "PB0", "PB1";
-				function = "uart2";
-			};
-
-			mmc0_pins: mmc0-pins {
-				pins = "PF0", "PF1", "PF2", "PF3",
-				       "PF4", "PF5";
-				function = "mmc0";
-				drive-strength = <30>;
-				bias-pull-up;
-			};
-
-			mmc1_pins: mmc1-pins {
-				pins = "PG0", "PG1", "PG2", "PG3",
-				       "PG4", "PG5";
-				function = "mmc1";
-				drive-strength = <30>;
-				bias-pull-up;
-			};
-
-			/omit-if-no-ref/
-			pwm0_pin: pwm0-pin {
-				pins = "PB4";
-				function = "pwm0";
-			};
-
-			/omit-if-no-ref/
-			pwm1_pin: pwm1-pin {
-				pins = "PB5";
-				function = "pwm1";
-			};
-
-			spi0_pins: spi0-pins {
-				pins = "PC0", "PC1", "PC2", "PC3";
-				function = "spi0";
-			};
-		};
-
-		timer@1c20c00 {
-			compatible = "allwinner,sun8i-v3s-timer";
-			reg = <0x01c20c00 0xa0>;
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc24M>;
-		};
-
-		wdt0: watchdog@1c20ca0 {
-			compatible = "allwinner,sun6i-a31-wdt";
-			reg = <0x01c20ca0 0x20>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc24M>;
-		};
-
-		pwm: pwm@1c21400 {
-			compatible = "allwinner,sun8i-v3s-pwm",
-				     "allwinner,sun7i-a20-pwm";
-			reg = <0x01c21400 0xc>;
-			clocks = <&osc24M>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		lradc: lradc@1c22800 {
-			compatible = "allwinner,sun4i-a10-lradc-keys";
-			reg = <0x01c22800 0x400>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		codec: codec@1c22c00 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun8i-v3s-codec";
-			reg = <0x01c22c00 0x400>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
-			clock-names = "apb", "codec";
-			resets = <&ccu RST_BUS_CODEC>;
-			dmas = <&dma 15>, <&dma 15>;
-			dma-names = "rx", "tx";
-			allwinner,codec-analog-controls = <&codec_analog>;
-			status = "disabled";
-		};
-
-		codec_analog: codec-analog@1c23000 {
-			compatible = "allwinner,sun8i-v3s-codec-analog";
-			reg = <0x01c23000 0x4>;
-		};
-
-		uart0: serial@1c28000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28000 0x400>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART0>;
-			dmas = <&dma 6>, <&dma 6>;
-			dma-names = "tx", "rx";
-			resets = <&ccu RST_BUS_UART0>;
-			status = "disabled";
-		};
-
-		uart1: serial@1c28400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28400 0x400>;
-			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART1>;
-			dmas = <&dma 7>, <&dma 7>;
-			dma-names = "tx", "rx";
-			resets = <&ccu RST_BUS_UART1>;
-			status = "disabled";
-		};
-
-		uart2: serial@1c28800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28800 0x400>;
-			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_BUS_UART2>;
-			dmas = <&dma 8>, <&dma 8>;
-			dma-names = "tx", "rx";
-			resets = <&ccu RST_BUS_UART2>;
-			pinctrl-0 = <&uart2_pins>;
-			pinctrl-names = "default";
-			status = "disabled";
-		};
-
-		i2c0: i2c@1c2ac00 {
-			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2ac00 0x400>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_I2C0>;
-			resets = <&ccu RST_BUS_I2C0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		i2c1: i2c@1c2b000 {
-			compatible = "allwinner,sun6i-a31-i2c";
-			reg = <0x01c2b000 0x400>;
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_I2C1>;
-			resets = <&ccu RST_BUS_I2C1>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		emac: ethernet@1c30000 {
-			compatible = "allwinner,sun8i-v3s-emac";
-			syscon = <&syscon>;
-			reg = <0x01c30000 0x10000>;
-			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
-			resets = <&ccu RST_BUS_EMAC>;
-			reset-names = "stmmaceth";
-			clocks = <&ccu CLK_BUS_EMAC>;
-			clock-names = "stmmaceth";
-			phy-handle = <&int_mii_phy>;
-			phy-mode = "mii";
-			status = "disabled";
-
-			mdio: mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "snps,dwmac-mdio";
-			};
-
-			mdio_mux: mdio-mux {
-				compatible = "allwinner,sun8i-h3-mdio-mux";
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				mdio-parent-bus = <&mdio>;
-				/* Only one MDIO is usable at the time */
-				internal_mdio: mdio@1 {
-					compatible = "allwinner,sun8i-h3-mdio-internal";
-					reg = <1>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					int_mii_phy: ethernet-phy@1 {
-						compatible = "ethernet-phy-ieee802.3-c22";
-						reg = <1>;
-						clocks = <&ccu CLK_BUS_EPHY>;
-						resets = <&ccu RST_BUS_EPHY>;
-					};
-				};
-			};
-		};
-
-		spi0: spi@1c68000 {
-			compatible = "allwinner,sun8i-h3-spi";
-			reg = <0x01c68000 0x1000>;
-			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma 23>, <&dma 23>;
-			dma-names = "rx", "tx";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi0_pins>;
-			resets = <&ccu RST_BUS_SPI0>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		gic: interrupt-controller@1c81000 {
-			compatible = "arm,gic-400";
-			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x2000>,
-			      <0x01c84000 0x2000>,
-			      <0x01c86000 0x2000>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		csi1: camera@1cb4000 {
-			compatible = "allwinner,sun8i-v3s-csi";
-			reg = <0x01cb4000 0x3000>;
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CSI>,
-				 <&ccu CLK_CSI1_SCLK>,
-				 <&ccu CLK_DRAM_CSI>;
-			clock-names = "bus", "mod", "ram";
-			resets = <&ccu RST_BUS_CSI>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f0faa9f80a23..12981adbd042 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -572,6 +572,7 @@ config MACH_SUN8I_V3_V3S
 	select SUNXI_DRAM_DW_16BIT
 	select SUPPORT_SPL
 	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
+	imply OF_UPSTREAM
 
 config RESERVE_ALLWINNER_BOOT0_HEADER
 	bool "reserve space for Allwinner boot0 header"
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index 299deb0195a2..de695b362b44 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-licheepi-zero"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
 CONFIG_NO_NET=y
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index ac3e7fbb4317..2b2fb88c4933 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun8i-s3-pinecube"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-s3-pinecube"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3=y
 CONFIG_DRAM_CLK=504
-- 
2.49.0

