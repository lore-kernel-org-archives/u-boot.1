Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA586C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE7F8880F;
	Mon, 15 Jul 2024 21:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cp9iqUs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887E2888B4; Mon, 15 Jul 2024 21:36:02 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC43287EFA
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d93147ac6bso2763014b6e.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721072157; x=1721676957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BqmBTV7ObgpBhxvGZ6azmoN4Cs5X7brSEqb9vEHxVWc=;
 b=Cp9iqUs5VIg2yeW/ey/jT/KnNyTphjSDb1E0jXZVYMmkJFzCdpNU/++uFV3YOOdMzI
 FYXTTjz3b2sZ56wuV06FsPWrzP/XcNjJW2LgEukeLikHYhAAusyca0NA/uikFeQVfDdp
 tlwC/Bc9gZ+H1RfzViHVQPR7xLWzCHNiWScsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721072157; x=1721676957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqmBTV7ObgpBhxvGZ6azmoN4Cs5X7brSEqb9vEHxVWc=;
 b=fASM2KygIA9a2SPykACOlVYnSYruIxAe343WlW04HLzNW9ztO7QWpG1muHfJpH6CMh
 VEbhrh80NdBFaSRARso9BY90bGlwE3eFLNR+8BWwfX/AWErpzaYiY+DuPSKHKm/LPruW
 E28RK7/y31yyGn/ln9maGLgMeo5bAE+gejNNYJS9AAer8isNsW3TS22Rm0fGfwJdic0Q
 80EMvph7CJMDUTEmwnN8C/60qNeJsdWU1t5LpTnykxz6Z3r7RAVCyoKdjrNA29TJeZ3A
 rxngrqYS+cwV6ybCcfH13gLXyMaVDeCxX9XUCVUdhb3dTk4keDBI2SpS651WTsR4UxbM
 jGeA==
X-Gm-Message-State: AOJu0Yx/gRWTzZdcGCtcS1aiwhbGFkpDrzs/LhSQz/VN34Eykymv6VMQ
 pHh8c5RbaOmoMg/m7KywNiQRKEveV1mFlUQXbn+pYjaJ7VQi6TPdjeLxrQnZNpoCV5cisx4V800
 E
X-Google-Smtp-Source: AGHT+IFN9lUnlG5TyesYoCQow6iZ2dJuA6Z7EC2XmzqIGu1vMN/nLAEANI3ovxfF3pANdNUHPkZIXA==
X-Received: by 2002:a05:6870:d892:b0:25e:14f0:62c4 with SMTP id
 586e51a60fabf-25eae7f1ea4mr16718976fac.18.1721072157253; 
 Mon, 15 Jul 2024 12:35:57 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260752a6059sm1084531fac.37.2024.07.15.12.35.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 12:35:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] arm: Remove omap4_panda board
Date: Mon, 15 Jul 2024 13:35:51 -0600
Message-Id: <20240715193555.564528-1-trini@konsulko.com>
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

This board has not been converted to CONFIG_DM_I2C by the deadline.
Remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/dts/Makefile                |   4 -
 arch/arm/dts/omap4-panda-common.dtsi | 573 ---------------------------
 arch/arm/dts/omap4-panda-es.dts      |  82 ----
 arch/arm/dts/omap4-panda.dts         |  13 -
 arch/arm/mach-omap2/omap4/Kconfig    |   4 -
 board/ti/panda/Kconfig               |  14 -
 board/ti/panda/MAINTAINERS           |   6 -
 board/ti/panda/Makefile              |   6 -
 board/ti/panda/panda.c               | 322 ---------------
 board/ti/panda/panda_mux_data.h      |  86 ----
 configs/omap4_panda_defconfig        |  54 ---
 include/configs/omap4_panda.h        |  16 -
 12 files changed, 1180 deletions(-)
 delete mode 100644 arch/arm/dts/omap4-panda-common.dtsi
 delete mode 100644 arch/arm/dts/omap4-panda-es.dts
 delete mode 100644 arch/arm/dts/omap4-panda.dts
 delete mode 100644 board/ti/panda/Kconfig
 delete mode 100644 board/ti/panda/MAINTAINERS
 delete mode 100644 board/ti/panda/Makefile
 delete mode 100644 board/ti/panda/panda.c
 delete mode 100644 board/ti/panda/panda_mux_data.h
 delete mode 100644 configs/omap4_panda_defconfig
 delete mode 100644 include/configs/omap4_panda.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 4a4d5be2bd63..67b978470f4c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1017,10 +1017,6 @@ dtb-$(CONFIG_TARGET_OMAP3_BEAGLE) += \
 
 dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
 
-dtb-$(CONFIG_TARGET_OMAP4_PANDA) += \
-	omap4-panda.dtb \
-	omap4-panda-es.dtb
-
 dtb-$(CONFIG_TARGET_OMAP4_SDP4430) += \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb
diff --git a/arch/arm/dts/omap4-panda-common.dtsi b/arch/arm/dts/omap4-panda-common.dtsi
deleted file mode 100644
index 6174fbe28034..000000000000
--- a/arch/arm/dts/omap4-panda-common.dtsi
+++ /dev/null
@@ -1,573 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011-2013 Texas Instruments Incorporated - https://www.ti.com/
- */
-#include <dt-bindings/input/input.h>
-#include "elpida_ecb240abacn.dtsi"
-#include "omap4-mcpdm.dtsi"
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x40000000>; /* 1 GB */
-	};
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	aliases {
-		display0 = &dvi0;
-		display1 = &hdmi0;
-		ethernet = &ethernet;
-	};
-
-	leds: leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <
-			&led_wkgpio_pins
-		>;
-
-		led-heartbeat {
-			label = "pandaboard::status1";
-			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		led-mmc {
-			label = "pandaboard::status2";
-			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-		};
-	};
-
-	gpio_keys: gpio_keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <
-			&button_pins
-		>;
-
-		buttonS2 {
-			label = "button S2";
-			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
-			linux,code = <BTN_0>;
-			wakeup-source;
-		};
-	};
-
-	sound: sound {
-		compatible = "ti,abe-twl6040";
-		ti,model = "PandaBoard";
-
-		ti,mclk-freq = <38400000>;
-
-		ti,mcpdm = <&mcpdm>;
-
-		ti,twl6040 = <&twl6040>;
-
-		/* Audio routing */
-		ti,audio-routing =
-			"Headset Stereophone", "HSOL",
-			"Headset Stereophone", "HSOR",
-			"Ext Spk", "HFL",
-			"Ext Spk", "HFR",
-			"Line Out", "AUXL",
-			"Line Out", "AUXR",
-			"HSMIC", "Headset Mic",
-			"Headset Mic", "Headset Mic Bias",
-			"AFML", "Line In",
-			"AFMR", "Line In";
-	};
-
-	/* HS USB Port 1 Power */
-	hsusb1_power: hsusb1_power_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb1_vbus";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;	/* gpio_1 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-		/*
-		 * boot-on is required along with always-on as the
-		 * regulator framework doesn't enable the regulator
-		 * if boot-on is not there.
-		 */
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	/* HS USB Host PHY on PORT 1 */
-	hsusb1_phy: hsusb1_phy {
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;   /* gpio_62 */
-		#phy-cells = <0>;
-		vcc-supply = <&hsusb1_power>;
-		clocks = <&auxclk3_ck>;
-		clock-names = "main_clk";
-		clock-frequency = <19200000>;
-	};
-
-	/* regulator for wl12xx on sdio5 */
-	wl12xx_vmmc: wl12xx_vmmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl12xx_gpio>;
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <70000>;
-		enable-active-high;
-	};
-
-	tfp410: encoder0 {
-		compatible = "ti,tfp410";
-		powerdown-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;	/* gpio_0 */
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				tfp410_in: endpoint {
-					remote-endpoint = <&dpi_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				tfp410_out: endpoint {
-					remote-endpoint = <&dvi_connector_in>;
-				};
-			};
-		};
-	};
-
-	dvi0: connector0 {
-		compatible = "dvi-connector";
-		label = "dvi";
-
-		digital;
-
-		ddc-i2c-bus = <&i2c3>;
-
-		port {
-			dvi_connector_in: endpoint {
-				remote-endpoint = <&tfp410_out>;
-			};
-		};
-	};
-
-	tpd12s015: encoder1 {
-		compatible = "ti,tpd12s015";
-
-		gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
-			<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
-			<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				tpd12s015_in: endpoint {
-					remote-endpoint = <&hdmi_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				tpd12s015_out: endpoint {
-					remote-endpoint = <&hdmi_connector_in>;
-				};
-			};
-		};
-	};
-
-	hdmi0: connector1 {
-		compatible = "hdmi-connector";
-		label = "hdmi";
-
-		type = "a";
-
-		port {
-			hdmi_connector_in: endpoint {
-				remote-endpoint = <&tpd12s015_out>;
-			};
-		};
-	};
-};
-
-&omap4_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <
-			&dss_dpi_pins
-			&tfp410_pins
-			&dss_hdmi_pins
-			&tpd12s015_pins
-			&hsusbb1_pins
-	>;
-
-	twl6040_pins: pinmux_twl6040_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x120, PIN_OUTPUT | MUX_MODE3)	/* hdq_sio.gpio_127 */
-			OMAP4_IOPAD(0x1a0, PIN_INPUT | MUX_MODE0)	/* sys_nirq2.sys_nirq2 */
-		>;
-	};
-
-	mcbsp1_pins: pinmux_mcbsp1_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x0fe, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_clkx.abe_mcbsp1_clkx */
-			OMAP4_IOPAD(0x100, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dr.abe_mcbsp1_dr */
-			OMAP4_IOPAD(0x102, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* abe_mcbsp1_dx.abe_mcbsp1_dx */
-			OMAP4_IOPAD(0x104, PIN_INPUT | MUX_MODE0)		/* abe_mcbsp1_fsx.abe_mcbsp1_fsx */
-		>;
-	};
-
-	dss_dpi_pins: pinmux_dss_dpi_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x162, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data23 */
-			OMAP4_IOPAD(0x164, PIN_OUTPUT | MUX_MODE5) 	/* dispc2_data22 */
-			OMAP4_IOPAD(0x166, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data21 */
-			OMAP4_IOPAD(0x168, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data20 */
-			OMAP4_IOPAD(0x16a, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data19 */
-			OMAP4_IOPAD(0x16c, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data18 */
-			OMAP4_IOPAD(0x16e, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data15 */
-			OMAP4_IOPAD(0x170, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data14 */
-			OMAP4_IOPAD(0x172, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data13 */
-			OMAP4_IOPAD(0x174, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data12 */
-			OMAP4_IOPAD(0x176, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data11 */
-
-			OMAP4_IOPAD(0x1b4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data10 */
-			OMAP4_IOPAD(0x1b6, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data9 */
-			OMAP4_IOPAD(0x1b8, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data16 */
-			OMAP4_IOPAD(0x1ba, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data17 */
-			OMAP4_IOPAD(0x1bc, PIN_OUTPUT | MUX_MODE5)	/* dispc2_hsync */
-			OMAP4_IOPAD(0x1be, PIN_OUTPUT | MUX_MODE5)	/* dispc2_pclk */
-			OMAP4_IOPAD(0x1c0, PIN_OUTPUT | MUX_MODE5)	/* dispc2_vsync */
-			OMAP4_IOPAD(0x1c2, PIN_OUTPUT | MUX_MODE5)	/* dispc2_de */
-			OMAP4_IOPAD(0x1c4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data8 */
-			OMAP4_IOPAD(0x1c6, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data7 */
-			OMAP4_IOPAD(0x1c8, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data6 */
-			OMAP4_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data5 */
-			OMAP4_IOPAD(0x1cc, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data4 */
-			OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data3 */
-
-			OMAP4_IOPAD(0x1d0, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data2 */
-			OMAP4_IOPAD(0x1d2, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data1 */
-			OMAP4_IOPAD(0x1d4, PIN_OUTPUT | MUX_MODE5)	/* dispc2_data0 */
-		>;
-	};
-
-	tfp410_pins: pinmux_tfp410_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x184, PIN_OUTPUT | MUX_MODE3)	/* gpio_0 */
-		>;
-	};
-
-	dss_hdmi_pins: pinmux_dss_hdmi_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
-			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl */
-			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda */
-		>;
-	};
-
-	tpd12s015_pins: pinmux_tpd12s015_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x062, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a17.gpio_41 */
-			OMAP4_IOPAD(0x088, PIN_OUTPUT | MUX_MODE3)		/* gpmc_nbe1.gpio_60 */
-			OMAP4_IOPAD(0x098, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* hdmi_hpd.gpio_63 */
-		>;
-	};
-
-	hsusbb1_pins: pinmux_hsusbb1_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x0c2, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_clk.usbb1_ulpiphy_clk */
-			OMAP4_IOPAD(0x0c4, PIN_OUTPUT | MUX_MODE4)		/* usbb1_ulpitll_stp.usbb1_ulpiphy_stp */
-			OMAP4_IOPAD(0x0c6, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dir.usbb1_ulpiphy_dir */
-			OMAP4_IOPAD(0x0c8, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_nxt.usbb1_ulpiphy_nxt */
-			OMAP4_IOPAD(0x0ca, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat0.usbb1_ulpiphy_dat0 */
-			OMAP4_IOPAD(0x0cc, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat1.usbb1_ulpiphy_dat1 */
-			OMAP4_IOPAD(0x0ce, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat2.usbb1_ulpiphy_dat2 */
-			OMAP4_IOPAD(0x0d0, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat3.usbb1_ulpiphy_dat3 */
-			OMAP4_IOPAD(0x0d2, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat4.usbb1_ulpiphy_dat4 */
-			OMAP4_IOPAD(0x0d4, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat5.usbb1_ulpiphy_dat5 */
-			OMAP4_IOPAD(0x0d6, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat6.usbb1_ulpiphy_dat6 */
-			OMAP4_IOPAD(0x0d8, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* usbb1_ulpitll_dat7.usbb1_ulpiphy_dat7 */
-		>;
-	};
-
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
-			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_scl */
-			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c2_sda */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
-			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
-		>;
-	};
-
-	i2c4_pins: pinmux_i2c4_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
-			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
-		>;
-	};
-
-	/*
-	 * wl12xx GPIO outputs for WLAN_EN, BT_EN, FM_EN, BT_WAKEUP
-	 * REVISIT: Are the pull-ups needed for GPIO 48 and 49?
-	 */
-	wl12xx_gpio: pinmux_wl12xx_gpio {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x066, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
-			OMAP4_IOPAD(0x06c, PIN_OUTPUT | MUX_MODE3)		/* gpmc_a22.gpio_46 */
-			OMAP4_IOPAD(0x070, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48 */
-			OMAP4_IOPAD(0x072, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a25.gpio_49 */
-		>;
-	};
-
-	/* wl12xx GPIO inputs and SDIO pins */
-	wl12xx_pins: pinmux_wl12xx_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x078, PIN_INPUT | MUX_MODE3)		/* gpmc_ncs2.gpio_52 */
-			OMAP4_IOPAD(0x07a, PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
-			OMAP4_IOPAD(0x148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_clk.sdmmc5_clk */
-			OMAP4_IOPAD(0x14a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
-			OMAP4_IOPAD(0x14c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
-			OMAP4_IOPAD(0x14e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
-			OMAP4_IOPAD(0x150, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
-			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
-		>;
-	};
-
-	button_pins: pinmux_button_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x114, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpio_121 */
-		>;
-	};
-};
-
-&omap4_pmx_wkup {
-	led_wkgpio_pins: pinmux_leds_wkpins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x05a, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk7 */
-			OMAP4_IOPAD(0x05c, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
-		>;
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-
-	clock-frequency = <400000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		/* IRQ# = 7 */
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-	};
-
-	twl6040: twl@4b {
-		compatible = "ti,twl6040";
-		#clock-cells = <0>;
-		reg = <0x4b>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&twl6040_pins>;
-
-		/* IRQ# = 119 */
-		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
-
-		vio-supply = <&v1v8>;
-		v2v1-supply = <&v2v1>;
-		enable-active-high;
-	};
-};
-
-#include "twl6030.dtsi"
-#include "twl6030_omap4.dtsi"
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-
-	clock-frequency = <100000>;
-
-	/*
-	 * Display monitor features are burnt in their EEPROM as EDID data.
-	 * The EEPROM is connected as I2C slave device.
-	 */
-	eeprom@50 {
-		compatible = "ti,eeprom";
-		reg = <0x50>;
-	};
-};
-
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c4_pins>;
-
-	clock-frequency = <400000>;
-};
-
-&mmc1 {
-	vmmc-supply = <&vmmc>;
-	bus-width = <8>;
-};
-
-&mmc2 {
-	status = "disabled";
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&mmc4 {
-	status = "disabled";
-};
-
-&mmc5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&wl12xx_pins>;
-	vmmc-supply = <&wl12xx_vmmc>;
-	interrupts-extended = <&wakeupgen GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH
-			       &omap4_pmx_core 0x10e>;
-	non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1271";
-		reg = <2>;
-		/* gpio_53 with gpmc_ncs3 pad as wakeup */
-		interrupts-extended = <&gpio2 21 IRQ_TYPE_LEVEL_HIGH>,
-				      <&omap4_pmx_core 0x3a>;
-		interrupt-names = "irq", "wakeup";
-		ref-clock-frequency = <38400000>;
-	};
-};
-
-&emif1 {
-	cs1-used;
-	device-handle = <&elpida_ECB240ABACN>;
-};
-
-&emif2 {
-	cs1-used;
-	device-handle = <&elpida_ECB240ABACN>;
-};
-
-&mcbsp1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp1_pins>;
-	status = "okay";
-};
-
-&twl_usb_comparator {
-	usb-supply = <&vusb>;
-};
-
-&uart2 {
-	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
-			       &omap4_pmx_core OMAP4_UART2_RX>;
-};
-
-&uart3 {
-	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
-			       &omap4_pmx_core OMAP4_UART3_RX>;
-};
-
-&uart4 {
-	interrupts-extended = <&wakeupgen GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
-			       &omap4_pmx_core OMAP4_UART4_RX>;
-};
-
-&usb_otg_hs {
-	interface-type = <1>;
-	mode = <3>;
-	power = <50>;
-};
-
-&usbhshost {
-	port1-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <&hsusb1_phy>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	hub@1 {
-		compatible = "usb424,9514";
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethernet: ethernet@1 {
-			compatible = "usb424,ec00";
-			reg = <1>;
-		};
-	};
-};
-
-&dss {
-	status = "okay";
-
-	port {
-		dpi_out: endpoint {
-			remote-endpoint = <&tfp410_in>;
-			data-lines = <24>;
-		};
-	};
-};
-
-&dsi2 {
-	status = "okay";
-	vdd-supply = <&vcxio>;
-};
-
-&hdmi {
-	status = "okay";
-	vdda-supply = <&vdac>;
-
-	port {
-		hdmi_out: endpoint {
-			remote-endpoint = <&tpd12s015_in>;
-		};
-	};
-};
diff --git a/arch/arm/dts/omap4-panda-es.dts b/arch/arm/dts/omap4-panda-es.dts
deleted file mode 100644
index 35e4f345a134..000000000000
--- a/arch/arm/dts/omap4-panda-es.dts
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "omap4460.dtsi"
-#include "omap4-panda-common.dtsi"
-
-/ {
-	model = "TI OMAP4 PandaBoard-ES";
-	compatible = "ti,omap4-panda-es", "ti,omap4-panda", "ti,omap4460", "ti,omap4430", "ti,omap4";
-};
-
-/* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
-&sound {
-	ti,model = "PandaBoardES";
-
-	/* Audio routing */
-	ti,audio-routing =
-		"Headset Stereophone", "HSOL",
-		"Headset Stereophone", "HSOR",
-		"Ext Spk", "HFL",
-		"Ext Spk", "HFR",
-		"Line Out", "AUXL",
-		"Line Out", "AUXR",
-		"AFML", "Line In",
-		"AFMR", "Line In";
-};
-
-/* PandaboardES has external pullups on SCL & SDA */
-&dss_hdmi_pins {
-	pinctrl-single,pins = <
-		OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
-		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
-		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
-		>;
-};
-
-&omap4_pmx_core {
-	led_gpio_pins: gpio_led_pmx {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x0f6, PIN_OUTPUT | MUX_MODE3)	/* gpio_110 */
-		>;
-	};
-
-	button_pins: pinmux_button_pins {
-		pinctrl-single,pins = <
-			OMAP4_IOPAD(0x11b, PIN_INPUT_PULLUP | MUX_MODE3) /* gpio_113 */
-		>;
-	};
-};
-
-&led_wkgpio_pins {
-	pinctrl-single,pins = <
-		OMAP4_IOPAD(0x05c, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
-	>;
-};
-
-&leds {
-	pinctrl-0 = <
-		&led_gpio_pins
-		&led_wkgpio_pins
-	>;
-
-	led-heartbeat {
-		gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
-	};
-	led-mmc {
-		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&gpio_keys {
-	buttonS2 {
-		gpios = <&gpio4 17 GPIO_ACTIVE_LOW>; /* gpio_113 */
-	};
-};
-
-&gpio1_target {
-	 ti,no-reset-on-init;
-};
diff --git a/arch/arm/dts/omap4-panda.dts b/arch/arm/dts/omap4-panda.dts
deleted file mode 100644
index 529d5bcceaaf..000000000000
--- a/arch/arm/dts/omap4-panda.dts
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "omap443x.dtsi"
-#include "omap4-panda-common.dtsi"
-
-/ {
-	model = "TI OMAP4 PandaBoard";
-	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
-};
diff --git a/arch/arm/mach-omap2/omap4/Kconfig b/arch/arm/mach-omap2/omap4/Kconfig
index cdac11c6b62b..5c5ac4ff33dd 100644
--- a/arch/arm/mach-omap2/omap4/Kconfig
+++ b/arch/arm/mach-omap2/omap4/Kconfig
@@ -4,9 +4,6 @@ choice
 	prompt "OMAP4 board select"
 	optional
 
-config TARGET_OMAP4_PANDA
-	bool "TI OMAP4 PandaBoard"
-
 config TARGET_OMAP4_SDP4430
 	bool "TI OMAP4 SDP4430"
 
@@ -15,7 +12,6 @@ endchoice
 config SYS_SOC
 	default "omap4"
 
-source "board/ti/panda/Kconfig"
 source "board/ti/sdp4430/Kconfig"
 
 endif
diff --git a/board/ti/panda/Kconfig b/board/ti/panda/Kconfig
deleted file mode 100644
index 5912f69babe2..000000000000
--- a/board/ti/panda/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-if TARGET_OMAP4_PANDA
-
-config SYS_BOARD
-	default "panda"
-
-config SYS_VENDOR
-	default "ti"
-
-config SYS_CONFIG_NAME
-	default "omap4_panda"
-
-source "board/ti/common/Kconfig"
-
-endif
diff --git a/board/ti/panda/MAINTAINERS b/board/ti/panda/MAINTAINERS
deleted file mode 100644
index 8b8cf7daf6d3..000000000000
--- a/board/ti/panda/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-PANDA BOARD
-M:	Tom Rini <trini@konsulko.com>
-S:	Maintained
-F:	board/ti/panda/
-F:	include/configs/omap4_panda.h
-F:	configs/omap4_panda_defconfig
diff --git a/board/ti/panda/Makefile b/board/ti/panda/Makefile
deleted file mode 100644
index dd2ff33afaa4..000000000000
--- a/board/ti/panda/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2000, 2001, 2002
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y	:= panda.o
diff --git a/board/ti/panda/panda.c b/board/ti/panda/panda.c
deleted file mode 100644
index e47d3a952d5c..000000000000
--- a/board/ti/panda/panda.c
+++ /dev/null
@@ -1,322 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2010
- * Texas Instruments Incorporated, <www.ti.com>
- * Steve Sakoman  <steve@sakoman.com>
- */
-#include <init.h>
-#include <log.h>
-#include <net.h>
-#include <serial.h>
-#include <asm/global_data.h>
-#include <asm/mach-types.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch/mmc_host_def.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/gpio.h>
-#include <asm/gpio.h>
-#include <env.h>
-#include <twl6030.h>
-
-#include "panda_mux_data.h"
-
-#define PANDA_ULPI_PHY_TYPE_GPIO       182
-#define PANDA_BOARD_ID_1_GPIO          101
-#define PANDA_ES_BOARD_ID_1_GPIO        48
-#define PANDA_BOARD_ID_2_GPIO          171
-#define PANDA_ES_BOARD_ID_3_GPIO         3
-#define PANDA_ES_BOARD_ID_4_GPIO         2
-
-DECLARE_GLOBAL_DATA_PTR;
-
-const struct omap_sysinfo sysinfo = {
-	"Board: OMAP4 Panda\n"
-};
-
-struct omap4_scrm_regs *const scrm = (struct omap4_scrm_regs *)0x4a30a000;
-
-/**
- * @brief board_init
- *
- * Return: 0
- */
-int board_init(void)
-{
-	gpmc_init();
-
-	gd->bd->bi_arch_number = MACH_TYPE_OMAP4_PANDA;
-	gd->bd->bi_boot_params = (0x80000000 + 0x100); /* boot param addr */
-
-	return 0;
-}
-
-#if defined(CONFIG_SPL_OS_BOOT)
-int spl_start_uboot(void)
-{
-	/* break into full u-boot on 'c' */
-	if (serial_tstc() && serial_getc() == 'c')
-		return 1;
-
-	return 0;
-}
-#endif /* CONFIG_SPL_OS_BOOT */
-
-int board_eth_init(struct bd_info *bis)
-{
-	return 0;
-}
-
-/*
-* Routine: get_board_revision
-* Description: Detect if we are running on a panda revision A1-A6,
-*              or an ES panda board. This can be done by reading
-*              the level of GPIOs and checking the processor revisions.
-*              This should result in:
-*			Panda 4430:
-*              GPIO171, GPIO101, GPIO182: 0 1 1 => A1-A5
-*              GPIO171, GPIO101, GPIO182: 1 0 1 => A6
-*			Panda ES:
-*              GPIO2, GPIO3, GPIO171, GPIO48, GPIO182: 0 0 0 1 1 => B1/B2
-*              GPIO2, GPIO3, GPIO171, GPIO48, GPIO182: 0 0 1 1 1 => B3
-*/
-int get_board_revision(void)
-{
-	int board_id0, board_id1, board_id2;
-	int board_id3, board_id4;
-	int board_id;
-
-	int processor_rev = omap_revision();
-
-	/* Setup the mux for the common board ID pins (gpio 171 and 182) */
-	writew((IEN | M3), (*ctrl)->control_padconf_core_base + UNIPRO_TX0);
-	writew((IEN | M3), (*ctrl)->control_padconf_core_base + FREF_CLK2_OUT);
-
-	board_id0 = gpio_get_value(PANDA_ULPI_PHY_TYPE_GPIO);
-	board_id2 = gpio_get_value(PANDA_BOARD_ID_2_GPIO);
-
-	if ((processor_rev >= OMAP4460_ES1_0 &&
-	     processor_rev <= OMAP4460_ES1_1)) {
-		/*
-		 * Setup the mux for the ES specific board ID pins (gpio 101,
-		 * 2 and 3.
-		 */
-		writew((IEN | M3), (*ctrl)->control_padconf_core_base +
-				GPMC_A24);
-		writew((IEN | M3), (*ctrl)->control_padconf_core_base +
-				UNIPRO_RY0);
-		writew((IEN | M3), (*ctrl)->control_padconf_core_base +
-				UNIPRO_RX1);
-
-		board_id1 = gpio_get_value(PANDA_ES_BOARD_ID_1_GPIO);
-		board_id3 = gpio_get_value(PANDA_ES_BOARD_ID_3_GPIO);
-		board_id4 = gpio_get_value(PANDA_ES_BOARD_ID_4_GPIO);
-
-#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
-		env_set("board_name", "panda-es");
-#endif
-		board_id = ((board_id4 << 4) | (board_id3 << 3) |
-			(board_id2 << 2) | (board_id1 << 1) | (board_id0));
-	} else {
-		/* Setup the mux for the Ax specific board ID pins (gpio 101) */
-		writew((IEN | M3), (*ctrl)->control_padconf_core_base +
-				FREF_CLK2_OUT);
-
-		board_id1 = gpio_get_value(PANDA_BOARD_ID_1_GPIO);
-		board_id = ((board_id2 << 2) | (board_id1 << 1) | (board_id0));
-
-#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
-		if ((board_id >= 0x3) && (processor_rev == OMAP4430_ES2_3))
-			env_set("board_name", "panda-a4");
-#endif
-	}
-
-	return board_id;
-}
-
-/**
- * is_panda_es_rev_b3() - Detect if we are running on rev B3 of panda board ES
- *
- *
- * Detect if we are running on B3 version of ES panda board,
- * This can be done by reading the level of GPIO 171 and checking the
- * processor revisions.
- * GPIO171: 1 => Panda ES Rev B3
- *
- * Return : return 1 if Panda ES Rev B3 , else return 0
- */
-u8 is_panda_es_rev_b3(void)
-{
-        int processor_rev = omap_revision();
-        int ret = 0;
-
-        if ((processor_rev >= OMAP4460_ES1_0 &&
-             processor_rev <= OMAP4460_ES1_1)) {
-
-                /* Setup the mux for the common board ID pins (gpio 171) */
-                writew((IEN | M3),
-			(*ctrl)->control_padconf_core_base + UNIPRO_TX0);
-
-                /* if processor_rev is panda ES and GPIO171 is 1,it is rev b3 */
-                ret = gpio_get_value(PANDA_BOARD_ID_2_GPIO);
-        }
-        return ret;
-}
-
-#ifdef CONFIG_SYS_EMIF_PRECALCULATED_TIMING_REGS
-/*
- * emif_get_reg_dump() - emif_get_reg_dump strong function
- *
- * @emif_nr - emif base
- * @regs - reg dump of timing values
- *
- * Strong function to override emif_get_reg_dump weak function in sdram_elpida.c
- */
-void emif_get_reg_dump(u32 emif_nr, const struct emif_regs **regs)
-{
-	u32 omap4_rev = omap_revision();
-
-	/* Same devices and geometry on both EMIFs */
-	if (omap4_rev == OMAP4430_ES1_0)
-		*regs = &emif_regs_elpida_380_mhz_1cs;
-	else if (omap4_rev == OMAP4430_ES2_0)
-		*regs = &emif_regs_elpida_200_mhz_2cs;
-	else if (omap4_rev == OMAP4430_ES2_3)
-		*regs = &emif_regs_elpida_400_mhz_1cs;
-	else if (omap4_rev < OMAP4470_ES1_0) {
-		if(is_panda_es_rev_b3())
-			*regs = &emif_regs_elpida_400_mhz_1cs;
-		else
-			*regs = &emif_regs_elpida_400_mhz_2cs;
-	}
-	else
-		*regs = &emif_regs_elpida_400_mhz_1cs;
-}
-
-void emif_get_dmm_regs(const struct dmm_lisa_map_regs
-						**dmm_lisa_regs)
-{
-	u32 omap_rev = omap_revision();
-
-	if (omap_rev == OMAP4430_ES1_0)
-		*dmm_lisa_regs = &lisa_map_2G_x_1_x_2;
-	else if (omap_rev == OMAP4430_ES2_3)
-		*dmm_lisa_regs = &lisa_map_2G_x_2_x_2;
-	else if (omap_rev < OMAP4460_ES1_0)
-		*dmm_lisa_regs = &lisa_map_2G_x_2_x_2;
-	else
-		*dmm_lisa_regs = &ma_lisa_map_2G_x_2_x_2;
-}
-
-#endif
-
-/**
- * @brief misc_init_r - Configure Panda board specific configurations
- * such as power configurations, ethernet initialization as phase2 of
- * boot sequence
- *
- * Return: 0
- */
-int misc_init_r(void)
-{
-	int phy_type;
-	u32 auxclk, altclksrc;
-
-	/* EHCI is not supported on ES1.0 */
-	if (omap_revision() == OMAP4430_ES1_0)
-		return 0;
-
-	get_board_revision();
-
-	gpio_direction_input(PANDA_ULPI_PHY_TYPE_GPIO);
-	phy_type = gpio_get_value(PANDA_ULPI_PHY_TYPE_GPIO);
-
-	if (phy_type == 1) {
-		/* ULPI PHY supplied by auxclk3 derived from sys_clk */
-		debug("ULPI PHY supplied by auxclk3\n");
-
-		auxclk = readl(&scrm->auxclk3);
-		/* Select sys_clk */
-		auxclk &= ~AUXCLK_SRCSELECT_MASK;
-		auxclk |=  AUXCLK_SRCSELECT_SYS_CLK << AUXCLK_SRCSELECT_SHIFT;
-		/* Set the divisor to 2 */
-		auxclk &= ~AUXCLK_CLKDIV_MASK;
-		auxclk |= AUXCLK_CLKDIV_2 << AUXCLK_CLKDIV_SHIFT;
-		/* Request auxilary clock #3 */
-		auxclk |= AUXCLK_ENABLE_MASK;
-
-		writel(auxclk, &scrm->auxclk3);
-	} else {
-		/* ULPI PHY supplied by auxclk1 derived from PER dpll */
-		debug("ULPI PHY supplied by auxclk1\n");
-
-		auxclk = readl(&scrm->auxclk1);
-		/* Select per DPLL */
-		auxclk &= ~AUXCLK_SRCSELECT_MASK;
-		auxclk |=  AUXCLK_SRCSELECT_PER_DPLL << AUXCLK_SRCSELECT_SHIFT;
-		/* Set the divisor to 16 */
-		auxclk &= ~AUXCLK_CLKDIV_MASK;
-		auxclk |= AUXCLK_CLKDIV_16 << AUXCLK_CLKDIV_SHIFT;
-		/* Request auxilary clock #3 */
-		auxclk |= AUXCLK_ENABLE_MASK;
-
-		writel(auxclk, &scrm->auxclk1);
-	}
-
-	altclksrc = readl(&scrm->altclksrc);
-
-	/* Activate alternate system clock supplier */
-	altclksrc &= ~ALTCLKSRC_MODE_MASK;
-	altclksrc |= ALTCLKSRC_MODE_ACTIVE;
-
-	/* enable clocks */
-	altclksrc |= ALTCLKSRC_ENABLE_INT_MASK | ALTCLKSRC_ENABLE_EXT_MASK;
-
-	writel(altclksrc, &scrm->altclksrc);
-
-	omap_die_id_usbethaddr();
-
-	return 0;
-}
-
-void set_muxconf_regs(void)
-{
-	do_set_mux((*ctrl)->control_padconf_core_base,
-		   core_padconf_array_essential,
-		   sizeof(core_padconf_array_essential) /
-		   sizeof(struct pad_conf_entry));
-
-	do_set_mux((*ctrl)->control_padconf_wkup_base,
-		   wkup_padconf_array_essential,
-		   sizeof(wkup_padconf_array_essential) /
-		   sizeof(struct pad_conf_entry));
-
-	if (omap_revision() >= OMAP4460_ES1_0)
-		do_set_mux((*ctrl)->control_padconf_wkup_base,
-			   wkup_padconf_array_essential_4460,
-			   sizeof(wkup_padconf_array_essential_4460) /
-			   sizeof(struct pad_conf_entry));
-}
-
-#if defined(CONFIG_MMC)
-int board_mmc_init(struct bd_info *bis)
-{
-	return omap_mmc_init(0, 0, 0, -1, -1);
-}
-
-#if !defined(CONFIG_SPL_BUILD)
-void board_mmc_power_init(void)
-{
-	twl6030_power_mmc_init(0);
-}
-#endif
-#endif
-
-#ifdef CONFIG_REVISION_TAG
-/*
- * get_board_rev() - get board revision
- */
-u32 get_board_rev(void)
-{
-	return 0x20;
-}
-#endif
diff --git a/board/ti/panda/panda_mux_data.h b/board/ti/panda/panda_mux_data.h
deleted file mode 100644
index ad9e36525b46..000000000000
--- a/board/ti/panda/panda_mux_data.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2010
- * Texas Instruments Incorporated, <www.ti.com>
- *
- *	Balaji Krishnamoorthy	<balajitk@ti.com>
- *	Aneesh V		<aneesh@ti.com>
- */
-#ifndef _PANDA_MUX_DATA_H_
-#define _PANDA_MUX_DATA_H_
-
-#include <asm/arch/mux_omap4.h>
-
-
-const struct pad_conf_entry core_padconf_array_essential[] = {
-
-{GPMC_AD0, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat0 */
-{GPMC_AD1, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat1 */
-{GPMC_AD2, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat2 */
-{GPMC_AD3, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat3 */
-{GPMC_AD4, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat4 */
-{GPMC_AD5, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat5 */
-{GPMC_AD6, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat6 */
-{GPMC_AD7, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat7 */
-{GPMC_NOE, (PTU | IEN | OFF_EN | OFF_OUT_PTD | M1)},	 /* sdmmc2_clk */
-{GPMC_NWE, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_cmd */
-{SDMMC1_CLK, (PTU | OFF_EN | OFF_OUT_PTD | M0)},	 /* sdmmc1_clk */
-{SDMMC1_CMD, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_cmd */
-{SDMMC1_DAT0, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat0 */
-{SDMMC1_DAT1, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat1 */
-{SDMMC1_DAT2, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat2 */
-{SDMMC1_DAT3, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat3 */
-{SDMMC1_DAT4, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat4 */
-{SDMMC1_DAT5, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat5 */
-{SDMMC1_DAT6, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat6 */
-{SDMMC1_DAT7, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M0)}, /* sdmmc1_dat7 */
-{I2C1_SCL, (PTU | IEN | M0)},				/* i2c1_scl */
-{I2C1_SDA, (PTU | IEN | M0)},				/* i2c1_sda */
-{I2C2_SCL, (PTU | IEN | M0)},				/* i2c2_scl */
-{I2C2_SDA, (PTU | IEN | M0)},				/* i2c2_sda */
-{I2C3_SCL, (PTU | IEN | M0)},				/* i2c3_scl */
-{I2C3_SDA, (PTU | IEN | M0)},				/* i2c3_sda */
-{I2C4_SCL, (PTU | IEN | M0)},				/* i2c4_scl */
-{I2C4_SDA, (PTU | IEN | M0)},				/* i2c4_sda */
-{UART3_CTS_RCTX, (PTU | IEN | M0)},			/* uart3_tx */
-{UART3_RTS_SD, (M0)},					/* uart3_rts_sd */
-{UART3_RX_IRRX, (IEN | M0)},				/* uart3_rx */
-{UART3_TX_IRTX, (M0)},					/* uart3_tx */
-{USBB1_ULPITLL_CLK, (PTD | IEN | OFF_EN | OFF_PD | OFF_IN | M4)},/* usbb1_ulpiphy_clk */
-{USBB1_ULPITLL_STP, (OFF_EN | OFF_OUT_PTD | M4)},		/* usbb1_ulpiphy_stp */
-{USBB1_ULPITLL_DIR, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dir */
-{USBB1_ULPITLL_NXT, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_nxt */
-{USBB1_ULPITLL_DAT0, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat0 */
-{USBB1_ULPITLL_DAT1, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat1 */
-{USBB1_ULPITLL_DAT2, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat2 */
-{USBB1_ULPITLL_DAT3, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat3 */
-{USBB1_ULPITLL_DAT4, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat4 */
-{USBB1_ULPITLL_DAT5, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat5 */
-{USBB1_ULPITLL_DAT6, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat6 */
-{USBB1_ULPITLL_DAT7, (IEN | OFF_EN | OFF_PD | OFF_IN | M4)},	/* usbb1_ulpiphy_dat7 */
-{USBB1_HSIC_DATA, (IEN | OFF_EN | OFF_PD | OFF_IN | M0)},	/* usbb1_hsic_data */
-{USBB1_HSIC_STROBE, (IEN | OFF_EN | OFF_PD | OFF_IN | M0)},	/* usbb1_hsic_strobe */
-{USBC1_ICUSB_DP, (IEN | M0)},					/* usbc1_icusb_dp */
-{USBC1_ICUSB_DM, (IEN | M0)},					/* usbc1_icusb_dm */
-{UNIPRO_TY2, (PTU | IEN | M3)},					/* gpio_1 */
-{GPMC_WAIT1,  (PTD | OFF_EN | OFF_PD | OFF_OUT_PTD | M3)},	/* gpio_62 */
-{FREF_CLK2_OUT, (PTU | IEN | M3)},				/* gpio_182 */
-
-};
-
-const struct pad_conf_entry wkup_padconf_array_essential[] = {
-
-{PAD1_SR_SCL, (PTU | IEN | M0)}, /* sr_scl */
-{PAD0_SR_SDA, (PTU | IEN | M0)}, /* sr_sda */
-{PAD1_SYS_32K, (IEN | M0)},	 /* sys_32k */
-{PAD0_FREF_CLK3_OUT, (M0)}, /* fref_clk3_out */
-
-};
-
-const struct pad_conf_entry wkup_padconf_array_essential_4460[] = {
-
-{PAD1_FREF_CLK4_REQ, (M3)}, /* gpio_wk7 for TPS: Mode 3 */
-
-};
-
-#endif /* _PANDA_MUX_DATA_H_ */
diff --git a/configs/omap4_panda_defconfig b/configs/omap4_panda_defconfig
deleted file mode 100644
index 131056be634a..000000000000
--- a/configs/omap4_panda_defconfig
+++ /dev/null
@@ -1,54 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_L2_PL310=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030df00
-CONFIG_DEFAULT_DEVICE_TREE="omap4-panda"
-CONFIG_SPL_TEXT_BASE=0x40300000
-CONFIG_OMAP44XX=y
-CONFIG_TARGET_OMAP4_PANDA=y
-CONFIG_SPL=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTCOMMAND="if test ${boot_fit} -eq 1; then run update_to_fit; fi; run findfdt; run init_console; run envboot; run distro_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="omap4-panda.dtb"
-CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xbc00
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-# CONFIG_SPL_FS_EXT4 is not set
-# CONFIG_SPL_I2C is not set
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
-CONFIG_CMD_SPL=y
-CONFIG_CMD_ASKENV=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FAT=y
-CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_MMC_OMAP_HS=y
-CONFIG_TWL6030_POWER=y
-CONFIG_CONS_INDEX=3
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_OMAP3=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_USB_GADGET=y
diff --git a/include/configs/omap4_panda.h b/include/configs/omap4_panda.h
deleted file mode 100644
index 69749ab63022..000000000000
--- a/include/configs/omap4_panda.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2010
- * Texas Instruments Incorporated.
- * Steve Sakoman  <steve@sakoman.com>
- *
- * Configuration settings for the TI OMAP4 Panda board.
- * See ti_omap4_common.h for OMAP4 common part
- */
-
-#ifndef __CONFIG_PANDA_H
-#define __CONFIG_PANDA_H
-
-#include <configs/ti_omap4_common.h>
-
-#endif /* __CONFIG_PANDA_H */
-- 
2.34.1

