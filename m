Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E2C5320E
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 21:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35F38877E;
	Sat, 24 Aug 2024 23:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcJ0hkr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E6488975; Sat, 24 Aug 2024 23:48:40 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01E38852A
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 23:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=woods.technical@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6b59a67ba12so29238327b3.1
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724536116; x=1725140916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6IfeQb8kTRVhWuPP1jI9zRdd8aptZRk+jG7IOteannA=;
 b=hcJ0hkr4ZAlzEk9M+RJsak4r2rL3cxKg9nR4L6Fa3gPJLOLbhkWafU812Af4AwngzW
 asatMyRvpuI7OIBOEjcSQ8WQWgcZAh0+AqWUdxeNIHDffNOo5fcmYVbAOKVUoAGFcIDr
 Zwg7kSCFlolmmnnxn0aJ8oLX8IPN8NOqsBfzYPg2VVcYKBFTg0bniZ+TH7Bh1um2qXuf
 Z0CQHwEwwvwK7mTjeM/I6oAp2fughLoLRDDg7suYVZ4fGrWP8uoutF7bfTnKFloZfYfW
 V0koj78MdhPm+WxXuG5inMKGKe0D0f3xYMHuANuZIDRw9noAMgSd8afa6LUhcW39gR2I
 Wo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724536116; x=1725140916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IfeQb8kTRVhWuPP1jI9zRdd8aptZRk+jG7IOteannA=;
 b=ftYYCJMlGugGWgyvtHNkRQIQEi2Evh/t1YBdYrSI0rzXBxkQCM4Q2QghC4bJuxhJ4q
 4DsPWYDpX5aG8EAZAq5DZtZ+tuUqJnbxVh/c9W5szjxl9cBPbF7cloB/HcIVjfmXJkc6
 45mSCk5IDsGUTtu5PtMQz3I1WYyM+W96nJLcspoGqm/kSGzfreuBfh1fq4IdpvIZFwY9
 /yS7ZaEtiiavTxSx7Nmzb519fgmx5Au4eE64XYSyb9k8A9fGHIw9KVI/0fpH10vel9YP
 DdLKe9+f+wHMj9oq4RzEpumKm/4pVbiMq5ShuSk1e6oHKUWBtBOYcykysVmysb2SrgoU
 dh1g==
X-Gm-Message-State: AOJu0YyDITEqwHpxfgpNUnl5E7zfxZfxjl4AU1Ph+uIXh579VMWWGuSj
 n1JXTR+wzN2b8vvCd0YeGhWL8q0Nq9U1MlyfWvRCr9iWKFU3px1QzEYaJA==
X-Google-Smtp-Source: AGHT+IH59Z9C7A8UA7TNL68OkzrvIa9XYn/cGqi4VA3yOTkhDHPDPmDjO8UnV/VXkZU1E0Dt7WVoZA==
X-Received: by 2002:a05:690c:d85:b0:6be:28ab:d87f with SMTP id
 00721157ae682-6c62538cf94mr74985267b3.2.1724536115563; 
 Sat, 24 Aug 2024 14:48:35 -0700 (PDT)
Received: from africa.woodsts.org
 (162-228-215-203.lightspeed.tukrga.sbcglobal.net. [162.228.215.203])
 by smtp.googlemail.com with ESMTPSA id
 00721157ae682-6c39e500a6csm10060457b3.139.2024.08.24.14.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 14:48:34 -0700 (PDT)
From: "Derald D. Woods" <woods.technical@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	"Derald D. Woods" <woods.technical@gmail.com>
Subject: [PATCH] omap3: omap3evm: Migrate to OF_UPSTREAM
Date: Sat, 24 Aug 2024 17:48:22 -0400
Message-ID: <20240824214822.35991-1-woods.technical@gmail.com>
X-Mailer: git-send-email 2.46.0
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

This commit brings the omap3evm inline with the remaining OMAP3XXX variants.

Signed-off-by: Derald D. Woods <woods.technical@gmail.com>
---
 arch/arm/dts/Makefile                         |   4 -
 arch/arm/dts/omap3-evm-37xx.dts               | 107 ---------
 arch/arm/dts/omap3-evm-common.dtsi            | 198 ----------------
 arch/arm/dts/omap3-evm-processor-common.dtsi  | 224 ------------------
 arch/arm/dts/omap3-evm.dts                    |  86 -------
 .../dts/omap3-panel-sharp-ls037v7dw01.dtsi    |  73 ------
 configs/omap3_evm_defconfig                   |   5 +-
 7 files changed, 2 insertions(+), 695 deletions(-)
 delete mode 100644 arch/arm/dts/omap3-evm-37xx.dts
 delete mode 100644 arch/arm/dts/omap3-evm-common.dtsi
 delete mode 100644 arch/arm/dts/omap3-evm-processor-common.dtsi
 delete mode 100644 arch/arm/dts/omap3-evm.dts
 delete mode 100644 arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 2d931c23fc8..03264cbd17a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -998,10 +998,6 @@ dtb-$(CONFIG_TARGET_ETHERNUT5) += ethernut5.dtb
 
 dtb-$(CONFIG_TARGET_USB_A9263) += usb_a9263.dtb
 
-dtb-$(CONFIG_TARGET_OMAP3_EVM) += \
-	omap3-evm-37xx.dtb \
-	omap3-evm.dtb
-
 dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
 
 dtb-$(CONFIG_TARGET_SAMA7G5EK) += \
diff --git a/arch/arm/dts/omap3-evm-37xx.dts b/arch/arm/dts/omap3-evm-37xx.dts
deleted file mode 100644
index abd403c228c..00000000000
--- a/arch/arm/dts/omap3-evm-37xx.dts
+++ /dev/null
@@ -1,107 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "omap36xx.dtsi"
-#include "omap3-evm-common.dtsi"
-#include "omap3-evm-processor-common.dtsi"
-
-/ {
-	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
-};
-
-&omap3_pmx_core2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_2_pins>;
-
-	ehci_phy_pins: pinmux_ehci_phy_pins {
-		pinctrl-single,pins = <
-
-		/* EHCI PHY reset GPIO etk_d7.gpio_21 */
-		OMAP3630_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)
-
-		/* EHCI VBUS etk_d8.gpio_22 */
-		OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)
-		>;
-	};
-
-	/* Used by OHCI and EHCI. OHCI won't work without external phy */
-	hsusb2_2_pins: pinmux_hsusb2_2_pins {
-		pinctrl-single,pins = <
-
-		/* etk_d10.hsusb2_clk */
-		OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)
-
-		/* etk_d11.hsusb2_stp */
-		OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)
-
-		/* etk_d12.hsusb2_dir */
-		OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d13.hsusb2_nxt */
-		OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d14.hsusb2_data0 */
-		OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d15.hsusb2_data1 */
-		OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
-};
-
-&gpmc {
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		interrupt-parent = <&gpmc>;
-		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name = "hynix,h8kds0un0mer-4em";
-		nand-bus-width = <16>;
-		gpmc,device-width = <2>;
-		ti,nand-ecc-opt = "bch8";
-
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "X-Loader";
-			reg = <0 0x80000>;
-		};
-		partition@80000 {
-			label = "U-Boot";
-			reg = <0x80000 0x1c0000>;
-		};
-		partition@1c0000 {
-			label = "Environment";
-			reg = <0x240000 0x40000>;
-		};
-		partition@280000 {
-			label = "Kernel";
-			reg = <0x280000 0x500000>;
-		};
-		partition@780000 {
-			label = "Filesystem";
-			reg = <0x780000 0x1f880000>;
-		};
-	};
-};
diff --git a/arch/arm/dts/omap3-evm-common.dtsi b/arch/arm/dts/omap3-evm-common.dtsi
deleted file mode 100644
index 17c89df6ce6..00000000000
--- a/arch/arm/dts/omap3-evm-common.dtsi
+++ /dev/null
@@ -1,198 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Common support for omap3 EVM boards
- */
-
-#include <dt-bindings/input/input.h>
-#include "omap-gpmc-smsc911x.dtsi"
-
-/ {
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&vcc>;
-		};
-	};
-
-	/* HS USB Port 2 Power */
-	hsusb2_power: hsusb2_power_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb2_vbus";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>; /* gpio_22 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
-	/* HS USB Host PHY on PORT 2 */
-	hsusb2_phy: hsusb2_phy {
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio1 21 GPIO_ACTIVE_LOW>; /* gpio_21 */
-		vcc-supply = <&hsusb2_power>;
-		#phy-cells = <0>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		ledb {
-			label = "omap3evm::ledb";
-			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
-			linux,default-trigger = "default-on";
-		};
-	};
-
-	wl12xx_vmmc: wl12xx_vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio5 22 GPIO_ACTIVE_HIGH>;	/* gpio150 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-		vin-supply = <&vmmc2>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-	};
-};
-
-#include "twl4030.dtsi"
-#include "twl4030_omap3.dtsi"
-#include "omap3-panel-sharp-ls037v7dw01.dtsi"
-
-&backlight0 {
-	gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;
-};
-
-&twl {
-	twl_power: power {
-		compatible = "ti,twl4030-power-omap3-evm", "ti,twl4030-power-idle";
-		ti,use_poweroff;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-
-	/*
-	 * TVP5146 Video decoder-in for analog input support.
-	 */
-	tvp5146@5c {
-		compatible = "ti,tvp5146m2";
-		reg = <0x5c>;
-	};
-};
-
-&lcd_3v3 {
-	gpio = <&gpio5 25 GPIO_ACTIVE_LOW>;	/* gpio153 */
-};
-
-&lcd0 {
-	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
-	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
-	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
-		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
-		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
-};
-
-&mcspi1 {
-	tsc2046@0 {
-		interrupt-parent = <&gpio6>;
-		interrupts = <15 0>;		/* gpio175 */
-		pendown-gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&mmc1 {
-	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
-	vmmc-supply = <&vmmc1>;
-	vqmmc-supply = <&vsim>;
-	bus-width = <8>;
-};
-
-&mmc2 {
-	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
-	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1271";
-		reg = <2>;
-		/* gpio_149 with uart1_rts pad as wakeirq */
-		interrupts-extended = <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
-				      <&omap3_pmx_core 0x14e>;
-		interrupt-names = "irq", "wakeup";
-		ref-clock-frequency = <38400000>;
-	};
-};
-
-&twl_gpio {
-	ti,use-leds;
-};
-
-&twl_keypad {
-	linux,keymap = <
-			MATRIX_KEY(2, 2, KEY_1)
-			MATRIX_KEY(1, 1, KEY_2)
-			MATRIX_KEY(0, 0, KEY_3)
-			MATRIX_KEY(3, 2, KEY_4)
-			MATRIX_KEY(2, 1, KEY_5)
-			MATRIX_KEY(1, 0, KEY_6)
-			MATRIX_KEY(1, 3, KEY_7)
-			MATRIX_KEY(3, 1, KEY_8)
-			MATRIX_KEY(2, 0, KEY_9)
-			MATRIX_KEY(2, 3, KEY_KPASTERISK)
-			MATRIX_KEY(0, 2, KEY_0)
-			MATRIX_KEY(3, 0, KEY_KPDOT)
-			/* s4 not wired */
-			MATRIX_KEY(1, 2, KEY_BACKSPACE)
-			MATRIX_KEY(0, 1, KEY_ENTER)
-			>;
-};
-
-&usbhshost {
-	port2-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <0 &hsusb2_phy>;
-};
-
-&usb_otg_hs {
-	interface-type = <0>;
-	usb-phy = <&usb2_phy>;
-	phys = <&usb2_phy>;
-	phy-names = "usb2-phy";
-	mode = <3>;
-	power = <50>;
-};
-
-&gpmc {
-	ethernet@gpmc {
-		interrupt-parent = <&gpio6>;
-		interrupts = <16 8>;
-		reg = <5 0 0xff>;
-	};
-};
-
-&vaux2 {
-	regulator-name = "usb_1v8";
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-always-on;
-};
diff --git a/arch/arm/dts/omap3-evm-processor-common.dtsi b/arch/arm/dts/omap3-evm-processor-common.dtsi
deleted file mode 100644
index e6ba30a2116..00000000000
--- a/arch/arm/dts/omap3-evm-processor-common.dtsi
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- * Common support for omap3 EVM 35xx/37xx processor modules
- */
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
-	};
-
-	wl12xx_vmmc: wl12xx_vmmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl12xx_gpio>;
-	};
-};
-
-&dss {
-	vdds_dsi-supply = <&vpll2>;
-	vdda_video-supply = <&lcd_3v3>;
-	pinctrl-names = "default";
-	pinctrl-0 = <
-		&dss_dpi_pins1
-		&dss_dpi_pins2
-	>;
-};
-
-&hsusb2_phy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ehci_phy_pins>;
-};
-
-&omap3_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <&on_board_gpio_61 &hsusb2_pins>;
-
-	dss_dpi_pins1: pinmux_dss_dpi_pins2 {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
-			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
-			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
-			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
-
-			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
-			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
-			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
-			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
-			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
-			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
-			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
-			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
-			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
-			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
-			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
-			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
-
-			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE3)   /* dss_data18.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE3)   /* dss_data19.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE3)   /* dss_data20.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE3)   /* dss_data21.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE3)   /* dss_data22.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE3)   /* dss_data23.dss_data5 */
-		>;
-	};
-
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_cmd.sdmmc1_cmd */
-			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
-			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
-			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
-			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
-			OMAP3_CORE1_IOPAD(0x2150, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat4.sdmmc1_dat4 */
-			OMAP3_CORE1_IOPAD(0x2152, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat5.sdmmc1_dat5 */
-			OMAP3_CORE1_IOPAD(0x2154, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat6.sdmmc1_dat6 */
-			OMAP3_CORE1_IOPAD(0x2156, PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat7.sdmmc1_dat7 */
-		>;
-	};
-
-	/* NOTE: Clocked externally, needs INPUT also for sdmmc2_clk.sdmmc2_clk */
-	mmc2_pins: pinmux_mmc2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1.sdmmc2_dat1 */
-			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
-			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
-			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */
-			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat5.sdmmc2_dir_dat1 */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat6.sdmmc2_dir_cmd */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)	/* sdmmc2_dat7.sdmmc2_clkin */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-
-	/* Devices are routed with gpmc_nbe1.gpio_61 to on-board devices */
-	on_board_gpio_61: pinmux_ehci_port_select_pins {
-		pinctrl-single,pins = <
-		OMAP3_CORE1_IOPAD(0x20c8, PIN_OUTPUT | MUX_MODE4)
-		>;
-	};
-
-	/* Used by OHCI and EHCI. OHCI won't work without external phy */
-	hsusb2_pins: pinmux_hsusb2_pins {
-		pinctrl-single,pins = <
-
-		/* mcspi1_cs3.hsusb2_data2 */
-		OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* mcspi2_clk.hsusb2_data7 */
-		OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* mcspi2_simo.hsusb2_data4 */
-		OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* mcspi2_somi.hsusb2_data5 */
-		OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* mcspi2_cs0.hsusb2_data6 */
-		OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* mcspi2_cs1.hsusb2_data3 */
-		OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
-
-	/*
-	 * Note that gpio_150 pulled high with internal pull to prevent wlcore
-	 * reset on return from off mode in idle.
-	 */
-	wl12xx_gpio: pinmux_wl12xx_gpio {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT_PULLUP | MUX_MODE7)		/* uart1_cts.gpio_150 */
-			OMAP3_CORE1_IOPAD(0x217e, PIN_INPUT | MUX_MODE4)		/* uart1_rts.gpio_149 */
-		>;
-	};
-
-	smsc911x_pins: pinmux_smsc911x_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
-		>;
-	};
-};
-
-&omap3_pmx_wkup {
-	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0a, PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
-			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
-			OMAP3_WKUP_IOPAD(0x2a10, PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
-			OMAP3_WKUP_IOPAD(0x2a12, PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
-			OMAP3_WKUP_IOPAD(0x2a14, PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
-			OMAP3_WKUP_IOPAD(0x2a16, PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
-		>;
-	};
-};
-
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-};
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&uart1 {
-	interrupts-extended = <&intc 72 &omap3_pmx_core OMAP3_UART1_RX>;
-};
-
-&uart2 {
-	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
-};
-
-&uart3 {
-	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
-
-/*
- * GPIO_61 (nUSB2_EN_1V8) must be low to enable on-board EHCI USB2 interface
- * for bus switch SN74CB3Q3384A, level-shifter SN74AVC16T245DGGR, and 1.8V.
- */
-&gpio2 {
-	en-usb2-port-hog {
-		gpio-hog;
-		gpios = <29 GPIO_ACTIVE_HIGH>;	/* gpio_61 */
-		output-low;
-		line-name = "enable usb2 port";
-	};
-};
-
-/* T2_GPIO_2 low to route GPIO_61 to on-board devices */
-&twl_gpio {
-	en_on_board_gpio_61 {
-		gpio-hog;
-		gpios = <2 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "en_hsusb2_clk";
-	};
-};
-
-&gpmc {
-	ranges = <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
-		 <5 0 0x2c000000 0x01000000>;	/* CS5: 16MB for LAN9220 */
-
-	ethernet@gpmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&smsc911x_pins>;
-	};
-};
diff --git a/arch/arm/dts/omap3-evm.dts b/arch/arm/dts/omap3-evm.dts
deleted file mode 100644
index f95eea63b35..00000000000
--- a/arch/arm/dts/omap3-evm.dts
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "omap34xx.dtsi"
-#include "omap3-evm-common.dtsi"
-#include "omap3-evm-processor-common.dtsi"
-
-/ {
-	model = "TI OMAP35XX EVM (TMDSEVM3530)";
-	compatible = "ti,omap3-evm", "ti,omap3430", "ti,omap3";
-};
-
-&omap3_pmx_core2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_2_pins>;
-
-	ehci_phy_pins: pinmux_ehci_phy_pins {
-		pinctrl-single,pins = <
-
-		/* EHCI PHY reset GPIO etk_d7.gpio_21 */
-		OMAP3430_CORE2_IOPAD(0x25ea, PIN_OUTPUT | MUX_MODE4)
-
-		/* EHCI VBUS etk_d8.gpio_22 */
-		OMAP3430_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX_MODE4)
-		>;
-	};
-
-	/* Used by OHCI and EHCI. OHCI won't work without external phy */
-	hsusb2_2_pins: pinmux_hsusb2_2_pins {
-		pinctrl-single,pins = <
-
-		/* etk_d10.hsusb2_clk */
-		OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)
-
-		/* etk_d11.hsusb2_stp */
-		OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)
-
-		/* etk_d12.hsusb2_dir */
-		OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d13.hsusb2_nxt */
-		OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d14.hsusb2_data0 */
-		OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)
-
-		/* etk_d15.hsusb2_data1 */
-		OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)
-		>;
-	};
-};
-
-&gpmc {
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		interrupt-parent = <&gpmc>;
-		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name = "micron,mt29f2g16abdhc";
-		nand-bus-width = <16>;
-		gpmc,device-width = <2>;
-		ti,nand-ecc-opt = "bch8";
-
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-};
diff --git a/arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi
deleted file mode 100644
index 2dbb687d4df..00000000000
--- a/arch/arm/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Common file for omap dpi panels with QVGA and reset pins
- *
- * Note that the board specifc DTS file needs to specify
- * at minimum the GPIO enable-gpios for display, and
- * gpios for gpio-backlight.
- */
-
-/ {
-	aliases {
-		display0 = &lcd0;
-	};
-
-	backlight0: backlight {
-		compatible = "gpio-backlight";
-		default-on;
-	};
-
-	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
-	lcd_3v3: regulator-lcd-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "lcd_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <70000>;
-	};
-
-	lcd0: display {
-		compatible = "sharp,ls037v7dw01";
-		label = "lcd";
-		power-supply = <&lcd_3v3>;
-		envdd-supply = <&lcd_3v3>;
-
-		port {
-			lcd_in: endpoint {
-				remote-endpoint = <&dpi_out>;
-			};
-		};
-	};
-};
-
-/* Needed to power the DPI pins */
-&vpll2 {
-	regulator-always-on;
-};
-
-&dss {
-	status = "okay";
-	port {
-		dpi_out: endpoint {
-			remote-endpoint = <&lcd_in>;
-			data-lines = <18>;
-		};
-	};
-};
-
-&mcspi1 {
-	tsc2046@0 {
-		reg = <0>;			/* CS0 */
-		compatible = "ti,tsc2046";
-		spi-max-frequency = <1000000>;
-		vcc-supply = <&lcd_3v3>;
-		ti,x-min = /bits/ 16 <0>;
-		ti,x-max = /bits/ 16 <8000>;
-		ti,y-min = /bits/ 16 <0>;
-		ti,y-max = /bits/ 16 <4800>;
-		ti,x-plate-ohms = /bits/ 16 <40>;
-		ti,pressure-max = /bits/ 16 <255>;
-		ti,swap-xy;
-		wakeup-source;
-	};
-};
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 3c8d974fbd0..d118cf36c5e 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="omap3-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-evm"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_EVM=y
 CONFIG_SYS_MONITOR_LEN=262144
@@ -48,10 +48,9 @@ CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(spl),1920k(u-boot),128k(u-boot-env),128k(dtb),6m(kernel),-(rootfs)"
 CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_SPL_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
-- 
2.46.0

