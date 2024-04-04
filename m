Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71195CD128A
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 03:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419E8883A3;
	Thu,  4 Apr 2024 05:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLqsjILi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EEA882A5; Thu,  4 Apr 2024 05:00:58 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147DC882B4
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 05:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-430bf84977dso3166711cf.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712199652; x=1712804452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Enym2rFQueanytIHMMPxpsKXPuhHnpTaE/XGhiXzow=;
 b=OLqsjILiE7FLNis9CxsCk25+KuzpRUl0VtCRGSuRpj8985GT613ybw6H7U9iJsfYGa
 bfXtPi+uCVFDO1PN/KFkA/wGlhKHtjcn4hQTNv+18QjXHSuQsjA/NYcOiq8fsaA8b7FH
 qgcNxvUsvNeOZo1IWtstTngVwDtvIv8RUYW0qXuHu/NXB3kvpzJDyNxAyGPtyLJWY2iH
 SW6D6vemryLEEDqZnYDdA3zLC/IAtV2ZzKJVanz34kSU9AvcswO9HUgkOmjq9hE2Iabg
 9cil+Oo2cqBhWbm1gb1qF8GTwyb9jJTu7Pb9yQwKbLhI0N9P4x0iaqlJvAVclwZYWEH5
 LaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712199652; x=1712804452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Enym2rFQueanytIHMMPxpsKXPuhHnpTaE/XGhiXzow=;
 b=n132iqETnGIFn6F/lzVMyDbASpzjD9C7sFgQ6TaMvO3uuOg0uyKg425IBB1J+thHDv
 7k2F0Y0S3eMKLb1J39ig2LV8Z9HuCJLXXD9D0s0WxryVsHPTZKQz48FkcE4pp8h3jkx/
 OWs8jiyRCRlFrci/lnexj30qYzvlcdLQIl7z4pSuRwA8+TlxOx84QmwSgM45/uOjQBkR
 KosrRYZEu+Pai2XIwnc28Cp8rM6XVJFKvHa13Sw133Hqlxw83HvPOCf+jNZev9az7j3w
 0sZdl3lwXTdLRpC0yMo2HhBtG+n1YE2/rHO/jSY6TCU10krfjGSuIbrvvqsvo0YJTj/F
 06Ng==
X-Gm-Message-State: AOJu0YzZX6e4YRSK57U2zA2CngiW40B2cp8O+pcL2JTG3B1EPU+qiGi9
 aGT2jrgvIC5EZdf8oEXyrxvsTdzdWlICDvRe4/4wwmM6KgWvjrnsNB8z3ip5
X-Google-Smtp-Source: AGHT+IFbHdNce7iUlcNEN7SpjH3h+9YQRjLlJX/KYwkPqISyY8uLAEE46Wovh5REAoISXfAYLy48pw==
X-Received: by 2002:ac8:5dd0:0:b0:432:d304:25bd with SMTP id
 e16-20020ac85dd0000000b00432d30425bdmr1189769qtx.18.1712199652278; 
 Wed, 03 Apr 2024 20:00:52 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:85bc:852d:ae70:b16a])
 by smtp.gmail.com with ESMTPSA id
 ci20-20020a05622a261400b0042efe24b76esm7155409qtb.58.2024.04.03.20.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 20:00:51 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH 2/4] arm: ti: am3517_evm: Migrate to OF_UPSTREAM
Date: Wed,  3 Apr 2024 22:00:10 -0500
Message-ID: <20240404030031.4726-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404030031.4726-1-aford173@gmail.com>
References: <20240404030031.4726-1-aford173@gmail.com>
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

With the feature of OF_UPSTREAM now available, the device trees
for the SOM and baseboard can now deleted and the device tree
locations need to point to the ti/omap directory.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/am3517-evm.dts b/arch/arm/dts/am3517-evm.dts
deleted file mode 100644
index d21bb2ccd0..0000000000
--- a/arch/arm/dts/am3517-evm.dts
+++ /dev/null
@@ -1,339 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-
-#include "am3517.dtsi"
-#include "am3517-som.dtsi"
-#include "am3517-evm-ui.dtsi"
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "TI AM3517 EVM (AM3517/05 TMDSEVM3517)";
-	compatible = "ti,am3517-evm", "ti,am3517", "ti,omap3";
-
-	aliases {
-		display0 = &lcd0;
-	};
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
-	};
-
-	vmmc_fixed: vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmc_fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys-polled";
-		poll-interval = <100>;
-
-		button-user {
-			label = "User Push Button";
-			linux,code = <BTN_0>;
-			gpios = <&tca6416 5 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-1 {
-			label = "User Switch 1";
-			linux,code = <BTN_1>;
-			gpios = <&tca6416 8 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-2 {
-			label = "User Switch 2";
-			linux,code = <BTN_2>;
-			gpios = <&tca6416 9 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-3 {
-			label = "User Switch 3";
-			linux,code = <BTN_3>;
-			gpios = <&tca6416 10 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-4 {
-			label = "User Switch 4";
-			linux,code = <BTN_4>;
-			gpios = <&tca6416 11 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-5 {
-			label = "User Switch 5";
-			linux,code = <BTN_5>;
-			gpios = <&tca6416 12 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-6 {
-			label = "User Switch 6";
-			linux,code = <BTN_6>;
-			gpios = <&tca6416 13 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-7 {
-			label = "User Switch 7";
-			linux,code = <BTN_7>;
-			gpios = <&tca6416 14 GPIO_ACTIVE_LOW>;
-		};
-
-		switch-8 {
-			label = "User Switch 8";
-			linux,code = <BTN_8>;
-			gpios = <&tca6416 15 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins>;
-
-		user_led_1 {
-			label = "am3517evm:green:user_led_1";
-			gpios = <&tca6416 7 GPIO_ACTIVE_LOW>;
-			default-state = "on";
-		};
-
-		user_led_2 {
-			label = "am3517evm:green:user_led_2";
-			gpios = <&tca6416 6 GPIO_ACTIVE_LOW>;
-			default-state = "on";
-		};
-
-		user_led_3 {
-			label = "am3517evm:green:user_led_3";
-			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0"; /* SD/MMC card activity */
-		};
-
-		user_led_4 {
-			label = "am3517evm:green:user_led_4";
-			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	lcd0: display@0 {
-		/* This isn't the exact LCD, but the timings meet spec */
-		/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
-		compatible = "newhaven,nhd-4.3-480272ef-atxl";
-		label = "15";
-		backlight = <&bl>;
-		enable-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;	/* gpio176, lcd INI */
-		vcc-supply = <&vdd_io_reg>;
-
-		port {
-			lcd_in: endpoint {
-				remote-endpoint = <&dpi_out>;
-			};
-		};
-	};
-
-	bl: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		power-supply = <&vdd_io_reg>;
-		pinctrl-0 = <&backlight_pins>;
-		pwms = <&pwm11 0 5000000 0>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <7>;
-		enable-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* gpio_182 */
-	};
-
-	pwm11: pwm-11 {
-		compatible = "ti,omap-dmtimer-pwm";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm_pins>;
-		ti,timers = <&timer11>;
-		#pwm-cells = <3>;
-		ti,clock-source = <0x01>;
-	};
-
-	/* HS USB Host PHY on PORT 1 */
-	hsusb1_phy: hsusb1_phy {
-		pinctrl-names = "default";
-		pinctrl-0 = <&hsusb1_rst_pins>;
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>; /* gpio_57 */
-		#phy-cells = <0>;
-	};
-};
-
-&davinci_emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ethernet_pins>;
-	status = "okay";
-};
-
-&davinci_mdio {
-	status = "okay";
-};
-
-&dss {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&dss_dpi_pins>;
-
-	vdds_dsi-supply = <&vdd_io_reg>;
-	vdda_video-supply = <&vdd_io_reg>;
-
-	port {
-		dpi_out: endpoint {
-			remote-endpoint = <&lcd_in>;
-			data-lines = <16>;
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	/* User DIP swithes [1:8] / User LEDS [1:2] */
-	tca6416: gpio@21 {
-		compatible = "ti,tca6416";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		vcc-supply = <&vdd_io_reg>;
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-};
-
-&mmc1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	vmmc-supply = <&vmmc_fixed>;
-	bus-width = <4>;
-	wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>; /* gpio_126 */
-	cd-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>; /* gpio_127 */
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&usbhshost {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb1_pins>;
-	port1-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <&hsusb1_phy>;
-};
-
-&omap3_pmx_core {
-
-	ethernet_pins: pinmux_ethernet_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21fe, PIN_INPUT | MUX_MODE0) /* rmii_mdio_data */
-			OMAP3_CORE1_IOPAD(0x2200, MUX_MODE0) /* rmii_mdio_clk */
-			OMAP3_CORE1_IOPAD(0x2202, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_rxd0 */
-			OMAP3_CORE1_IOPAD(0x2204, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_rxd1 */
-			OMAP3_CORE1_IOPAD(0x2206, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_crs_dv */
-			OMAP3_CORE1_IOPAD(0x2208, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_rxer */
-			OMAP3_CORE1_IOPAD(0x220a, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_txd0 */
-			OMAP3_CORE1_IOPAD(0x220c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* rmii_txd1 */
-			OMAP3_CORE1_IOPAD(0x220e, PIN_OUTPUT_PULLDOWN |MUX_MODE0) /* rmii_txen */
-			OMAP3_CORE1_IOPAD(0x2210, PIN_INPUT_PULLDOWN | MUX_MODE0) /* rmii_50mhz_clk */
-		>;
-	};
-
-	leds_pins: pinmux_leds_pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
-			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
-		>;
-	};
-
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
-			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
-			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
-			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
-			OMAP3_CORE1_IOPAD(0x2150, PIN_INPUT_PULLUP | MUX_MODE4) /* sdmmc1_dat4.gpio_126 */
-			OMAP3_CORE1_IOPAD(0x2152, PIN_INPUT_PULLUP | MUX_MODE4) /* sdmmc1_dat5.gpio_127 */
-		>;
-	};
-
-	pwm_pins: pinmux_pwm_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21dc, PIN_OUTPUT | MUX_MODE1)       /* mcspi2_cs0.gpt11_pwm */
-		>;
-	};
-
-	backlight_pins: pinmux_backlight_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21de, PIN_OUTPUT | MUX_MODE4)       /* mcspi2_cs1.gpio_182 */
-		>;
-	};
-
-	dss_dpi_pins: pinmux_dss_dpi_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d2, PIN_OUTPUT | MUX_MODE4)       /* mcspi1_cs2.gpio_176 */
-			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)       /* dss_pclk.dss_pclk */
-			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)       /* dss_hsync.dss_hsync */
-			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)       /* dss_vsync.dss_vsync */
-			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)       /* dss_acbias.dss_acbias */
-			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)       /* dss_data0.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)       /* dss_data1.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)       /* dss_data2.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)       /* dss_data3.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)       /* dss_data4.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)       /* dss_data5.dss_data5 */
-			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)       /* dss_data6.dss_data6 */
-			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)       /* dss_data7.dss_data7 */
-			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)       /* dss_data8.dss_data8 */
-			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)       /* dss_data9.dss_data9 */
-			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)       /* dss_data10.dss_data10 */
-			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)       /* dss_data11.dss_data11 */
-			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)       /* dss_data12.dss_data12 */
-			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)       /* dss_data13.dss_data13 */
-			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)       /* dss_data14.dss_data14 */
-			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)       /* dss_data15.dss_data15 */
-		>;
-	};
-
-	hsusb1_rst_pins: pinmux_hsusb1_rst_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20ba, PIN_OUTPUT | MUX_MODE4)	/* gpmc_ncs6.gpio_57 */
-		>;
-	};
-};
-
-&omap3_pmx_core2 {
-
-	hsusb1_pins: pinmux_hsusb1_pins {
-		pinctrl-single,pins = <
-			OMAP3430_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE3)	/* etk_clk.hsusb1_stp */
-			OMAP3430_CORE2_IOPAD(0x25da, PIN_OUTPUT | MUX_MODE3)	/* etk_ctl.hsusb1_clk */
-			OMAP3430_CORE2_IOPAD(0x25ec, PIN_INPUT | MUX_MODE3)	/* etk_d8.hsusb1_dir */
-			OMAP3430_CORE2_IOPAD(0x25ee, PIN_INPUT | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
-			OMAP3430_CORE2_IOPAD(0x25dc, PIN_INPUT | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
-			OMAP3430_CORE2_IOPAD(0x25de, PIN_INPUT | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
-			OMAP3430_CORE2_IOPAD(0x25e0, PIN_INPUT | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
-			OMAP3430_CORE2_IOPAD(0x25ea, PIN_INPUT | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
-			OMAP3430_CORE2_IOPAD(0x25e4, PIN_INPUT | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
-			OMAP3430_CORE2_IOPAD(0x25e6, PIN_INPUT | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
-			OMAP3430_CORE2_IOPAD(0x25e8, PIN_INPUT | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
-			OMAP3430_CORE2_IOPAD(0x25e2, PIN_INPUT | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/am3517-som.dtsi b/arch/arm/dts/am3517-som.dtsi
deleted file mode 100644
index 8b669e2eaf..0000000000
--- a/arch/arm/dts/am3517-som.dtsi
+++ /dev/null
@@ -1,234 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2016 Derald D. Woods <woods.technical@gmail.com>
- *
- * Based on am3517-evm.dts
- */
-
-/ {
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&vdd_core_reg>;
-		};
-	};
-
-	wl12xx_buffer: wl12xx_buf {
-		compatible = "regulator-fixed";
-		regulator-name = "wl1271_buf";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl12xx_buffer_pins>;
-		gpio = <&gpio5 1 GPIO_ACTIVE_LOW>; /* gpio 129 */
-		regulator-always-on;
-		vin-supply = <&vdd_1v8_reg>;
-	};
-
-	wl12xx_vmmc2: wl12xx_vmmc2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl12xx_wkup_pins>;
-		gpio = <&gpio1 3 GPIO_ACTIVE_HIGH >; /* gpio 3 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&wl12xx_buffer>;
-	};
-};
-
-&gpmc {
-	ranges = <0 0 0x30000000 0x1000000>;	/* CS0: 16MB for NAND */
-
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		linux,mtd-name = "micron,mt29f4g16abchch";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
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
-		gpmc,device-width = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-
-	s35390a: s35390a@30 {
-		compatible = "sii,s35390a";
-		reg = <0x30>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_pins>;
-		interrupts-extended = <&gpio2 23 IRQ_TYPE_EDGE_FALLING>; /* gpio_55 */
-	};
-
-	tps: tps65023@48 {
-		compatible = "ti,tps65023";
-		reg = <0x48>;
-
-		regulators {
-			vdd_core_reg: VDCDC1 {
-				regulator-name = "vdd_core";
-				regulator-always-on;
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-			};
-
-			vdd_io_reg: VDCDC2 {
-				regulator-name = "vdd_io";
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vdd_1v8_reg: VDCDC3 {
-				regulator-name = "vdd_1v8";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vdd_usb18_reg: LDO1 {
-				regulator-name = "vdd_usb18";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vdd_usb33_reg: LDO2 {
-				regulator-name = "vdd_usb33";
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-
-	touchscreen: tsc2004@4b {
-		compatible = "ti,tsc2004";
-		reg = <0x4b>;
-
-		vio-supply = <&vdd_io_reg>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsc2004_pins>;
-		interrupts-extended = <&gpio3 1 IRQ_TYPE_EDGE_RISING>; /* gpio_65 */
-
-		touchscreen-fuzz-x = <4>;
-		touchscreen-fuzz-y = <7>;
-		touchscreen-fuzz-pressure = <2>;
-		touchscreen-size-x = <480>;
-		touchscreen-size-y = <272>;
-		touchscreen-max-pressure = <2048>;
-
-		ti,x-plate-ohms = <280>;
-		ti,esd-recovery-timeout-ms = <8000>;
-	};
-};
-
-&mmc2 {
-	interrupts-extended = <&intc 86 /* &omap3_pmx_core 0x12c */>;
-
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins>;
-	vmmc-supply = <&wl12xx_vmmc2>;
-	non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1271";
-		reg = <2>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_RISING>; /* gpio_170 */
-		ref-clock-frequency = <26000000>;
-		tcxo-clock-frequency = <26000000>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-
-	bluetooth {
-		compatible = "ti,wl1271-st";
-		enable-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>; /* gpio 56 */
-		max-speed = <3000000>;
-	};
-};
-
-&omap3_pmx_core {
-
-	wl12xx_buffer_pins: pinmux_wl12xx_buffer_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MODE4)  /* mmc1_dat7.gpio_129 */
-		>;
-	};
-
-	mmc2_pins: pinmux_mmc2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_clk.mmc2_clk */
-			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_cmd.mmc2_cmd */
-			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat0.mmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat1.mmc2_dat1 */
-			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat2.mmc2_dat2 */
-			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat3.mmc2_dat3 */
-			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat4.mmc2_dir_dat0 */
-			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat5.mmc2_dir_dat1 */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat6.mmc2_dir_cmd */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1) /* mmc2_dat7.mmc2_clkin */
-			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE4)	/* hdq_sio.gpio_170 */
-		>;
-	};
-
-	rtc_pins: pinmux_rtc_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20b6, PIN_INPUT_PULLUP | MUX_MODE4) /* gpmc_ncs4.gpio_55 */
-		>;
-	};
-
-	tsc2004_pins: pinmux_tsc2004_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT | MUX_MODE4) /* gpmc_wait3.gpio_65 */
-		>;
-	};
-
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)		/* uart2_cts */
-			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* uart2_rts */
-			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
-			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
-			OMAP3_CORE1_IOPAD(0x20b8, PIN_INPUT | MUX_MODE0)		/* gpio_56 */
-		>;
-	};
-};
-
-&omap3_pmx_wkup {
-
-	wl12xx_wkup_pins: pinmux_wl12xx_wkup_pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/am3517.dtsi b/arch/arm/dts/am3517.dtsi
deleted file mode 100644
index 2633fae14b..0000000000
--- a/arch/arm/dts/am3517.dtsi
+++ /dev/null
@@ -1,109 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree Source for am3517 SoC
- *
- * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include "omap3.dtsi"
-
-/ {
-	aliases {
-		serial3 = &uart4;
-		can = &hecc;
-	};
-
-	ocp@68000000 {
-		am35x_otg_hs: am35x_otg_hs@5c040000 {
-			compatible = "ti,omap3-musb";
-			ti,hwmods = "am35x_otg_hs";
-			status = "disabled";
-			reg = <0x5c040000 0x1000>;
-			interrupts = <71>;
-			interrupt-names = "mc";
-		};
-
-		davinci_emac: ethernet@5c000000 {
-			compatible = "ti,am3517-emac";
-			ti,hwmods = "davinci_emac";
-			status = "disabled";
-			reg = <0x5c000000 0x30000>;
-			interrupts = <67 68 69 70>;
-			syscon = <&scm_conf>;
-			ti,davinci-ctrl-reg-offset = <0x10000>;
-			ti,davinci-ctrl-mod-reg-offset = <0>;
-			ti,davinci-ctrl-ram-offset = <0x20000>;
-			ti,davinci-ctrl-ram-size = <0x2000>;
-			ti,davinci-rmii-en = /bits/ 8 <1>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			clocks = <&emac_ick>;
-			clock-names = "ick";
-		};
-
-		davinci_mdio: mdio@5c030000 {
-			compatible = "ti,davinci_mdio";
-			ti,hwmods = "davinci_mdio";
-			status = "disabled";
-			reg = <0x5c030000 0x1000>;
-			bus_freq = <1000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&emac_fck>;
-			clock-names = "fck";
-		};
-
-		uart4: serial@4809e000 {
-			compatible = "ti,omap3-uart";
-			ti,hwmods = "uart4";
-			status = "disabled";
-			reg = <0x4809e000 0x400>;
-			interrupts = <84>;
-			dmas = <&sdma 55 &sdma 54>;
-			dma-names = "tx", "rx";
-			clock-frequency = <48000000>;
-		};
-
-		omap3_pmx_core2: pinmux@480025d8 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x480025d8 0x24>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#pinctrl-cells = <1>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-
-		hecc: can@5c050000 {
-			compatible = "ti,am3517-hecc";
-			status = "disabled";
-			reg = <0x5c050000 0x80>,
-			      <0x5c053000 0x180>,
-			      <0x5c052000 0x200>;
-			reg-names = "hecc", "hecc-ram", "mbx";
-			interrupts = <24>;
-			clocks = <&hecc_ck>;
-		};
-	};
-};
-
-/* Table Table 5-79 of the TRM shows 480ab000 is reserved */
-&usb_otg_hs {
-	status = "disabled";
-};
-
-&iva {
-	status = "disabled";
-};
-
-&mailbox {
-	status = "disabled";
-};
-
-&mmu_isp {
-	status = "disabled";
-};
-
-/include/ "am35xx-clocks.dtsi"
-/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/dts/am35xx-clocks.dtsi b/arch/arm/dts/am35xx-clocks.dtsi
deleted file mode 100644
index 220d0a5279..0000000000
--- a/arch/arm/dts/am35xx-clocks.dtsi
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree Source for OMAP3 clock data
- *
- * Copyright (C) 2013 Texas Instruments, Inc.
- */
-&scm_clocks {
-	emac_ick: emac_ick@32c {
-		#clock-cells = <0>;
-		compatible = "ti,am35xx-gate-clock";
-		clocks = <&ipss_ick>;
-		reg = <0x032c>;
-		ti,bit-shift = <1>;
-	};
-
-	emac_fck: emac_fck@32c {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&rmii_ck>;
-		reg = <0x032c>;
-		ti,bit-shift = <9>;
-	};
-
-	vpfe_ick: vpfe_ick@32c {
-		#clock-cells = <0>;
-		compatible = "ti,am35xx-gate-clock";
-		clocks = <&ipss_ick>;
-		reg = <0x032c>;
-		ti,bit-shift = <2>;
-	};
-
-	vpfe_fck: vpfe_fck@32c {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&pclk_ck>;
-		reg = <0x032c>;
-		ti,bit-shift = <10>;
-	};
-
-	hsotgusb_ick_am35xx: hsotgusb_ick_am35xx@32c {
-		#clock-cells = <0>;
-		compatible = "ti,am35xx-gate-clock";
-		clocks = <&ipss_ick>;
-		reg = <0x032c>;
-		ti,bit-shift = <0>;
-	};
-
-	hsotgusb_fck_am35xx: hsotgusb_fck_am35xx@32c {
-		#clock-cells = <0>;
-		compatible = "ti,gate-clock";
-		clocks = <&sys_ck>;
-		reg = <0x032c>;
-		ti,bit-shift = <8>;
-	};
-
-	hecc_ck: hecc_ck@32c {
-		#clock-cells = <0>;
-		compatible = "ti,am35xx-gate-clock";
-		clocks = <&sys_ck>;
-		reg = <0x032c>;
-		ti,bit-shift = <3>;
-	};
-};
-&cm_clocks {
-	ipss_ick: ipss_ick@a10 {
-		#clock-cells = <0>;
-		compatible = "ti,am35xx-interface-clock";
-		clocks = <&core_l3_ick>;
-		reg = <0x0a10>;
-		ti,bit-shift = <4>;
-	};
-
-	rmii_ck: rmii_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-	};
-
-	pclk_ck: pclk_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <27000000>;
-	};
-
-	uart4_ick_am35xx: uart4_ick_am35xx@a10 {
-		#clock-cells = <0>;
-		compatible = "ti,omap3-interface-clock";
-		clocks = <&core_l4_ick>;
-		reg = <0x0a10>;
-		ti,bit-shift = <23>;
-	};
-
-	uart4_fck_am35xx: uart4_fck_am35xx@a00 {
-		#clock-cells = <0>;
-		compatible = "ti,wait-gate-clock";
-		clocks = <&core_48m_fck>;
-		reg = <0x0a00>;
-		ti,bit-shift = <23>;
-	};
-};
-
-&cm_clockdomains {
-	core_l3_clkdm: core_l3_clkdm {
-		compatible = "ti,clockdomain";
-		clocks = <&sdrc_ick>, <&ipss_ick>, <&emac_ick>, <&vpfe_ick>,
-			 <&hsotgusb_ick_am35xx>, <&hsotgusb_fck_am35xx>,
-			 <&hecc_ck>;
-	};
-
-	core_l4_clkdm: core_l4_clkdm {
-		compatible = "ti,clockdomain";
-		clocks = <&cpefuse_fck>, <&ts_fck>, <&usbtll_fck>,
-			 <&usbtll_ick>, <&mmchs3_ick>, <&mmchs3_fck>,
-			 <&mmchs2_fck>, <&mmchs1_fck>, <&i2c3_fck>, <&i2c2_fck>,
-			 <&i2c1_fck>, <&mcspi4_fck>, <&mcspi3_fck>,
-			 <&mcspi2_fck>, <&mcspi1_fck>, <&uart2_fck>,
-			 <&uart1_fck>, <&hdq_fck>, <&mmchs2_ick>, <&mmchs1_ick>,
-			 <&hdq_ick>, <&mcspi4_ick>, <&mcspi3_ick>,
-			 <&mcspi2_ick>, <&mcspi1_ick>, <&i2c3_ick>, <&i2c2_ick>,
-			 <&i2c1_ick>, <&uart2_ick>, <&uart1_ick>, <&gpt11_ick>,
-			 <&gpt10_ick>, <&mcbsp5_ick>, <&mcbsp1_ick>,
-			 <&omapctrl_ick>, <&aes2_ick>, <&sha12_ick>,
-			 <&uart4_ick_am35xx>, <&uart4_fck_am35xx>;
-	};
-};
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 66bb4f6371..70498ca7fb 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -8,7 +8,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="am3517-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am3517-evm"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_AM3517_EVM=y
 CONFIG_EMIF4=y
@@ -58,6 +58,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1920k(u-boot),256k(u-bo
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.43.0

