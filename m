Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1226ECD1280
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929C587D09;
	Tue, 26 Mar 2024 21:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPtlFpLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99BCB87C62; Tue, 26 Mar 2024 21:25:47 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC93188065
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a550ce1a41so1384919eaf.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711484743; x=1712089543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmXEj2yJnQ36jsg4buAMowcusveS1FPvhef06zjjGpE=;
 b=hPtlFpLLuwI3OE7TpTsaN1NmS7aWr1feaqXAP4Bez+0pmttbyYIQ4N1InuxpKTdVl0
 yV3gSjTTJeUnaeONASD1JAPAEvLFdbeQmngio53o/GZl8lomYa19MkKi2xFBGsF+C+qD
 Pp7bv42HdCkPD6Hx/2QYBCeqs0IUQP3M3/d9b1HoUhfgD8+Nq/Rk6xgKp/ZLnHn/yhmN
 nQoK4pNKPy5uUMUcKj+6ODLkutnfU+beu9897bhJ0Ac3Gd+zsD7WKVZ674Mw2CPg3WM/
 w/0bXqeKi1X8B2zqO3ZGt5N/YeOIX4DJb/BlWnnemDeVJIgbcewJ60GMZMmmKrVsNv99
 NwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711484743; x=1712089543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LmXEj2yJnQ36jsg4buAMowcusveS1FPvhef06zjjGpE=;
 b=QNdkOoGCxhMq+z5+6SqbwT1iDqZn4O1fBfooSwIZNNwO/FFn3ssgxB/4YfxRxZ6Igz
 LWczSvzCOfnT5ownLacvn/dfDLGljJTE8MJEj4JD92xlshqvUmliSJeCHSk2+emZQTrO
 7yR7LLDdJ6/ByqS1Vxpv/GWOeKkTLZ/zC9N3IkUDsb/apYecRkWs/3lvQRA2rx7e5gDO
 OVzyfbxJlmMuQw0+V+5d3500IzaL7X7BA6bvM6r3rzbi9iEu5SrJzvoY1g2/rmwyk4R4
 802pQ9Z8C0cssNza3iwPNedBHLb0/dP9kxNx704qmHplpy00q/p30fY3qsaj/5W2BTHh
 8S0Q==
X-Gm-Message-State: AOJu0YwlTSBq+hOH/ndx1fBbcD/coF/XK074EhvfsY6hOM6Rl//p0Mgw
 A6EXU7+MA2O302Kp54xkM6TcSxftfUkGLmrzrPxJJ2ZUutivzUJnaAkRuZ0xdNs=
X-Google-Smtp-Source: AGHT+IGJ4pWz9pdQqXUHnLTJPlJ2IWOUxdeqhC+Pjs/ZQ/YI3vbArAOcxOCMlPnZx7yKJ6NEmcptow==
X-Received: by 2002:a05:6359:5f90:b0:17f:28c1:cced with SMTP id
 lh16-20020a0563595f9000b0017f28c1ccedmr2565168rwc.22.1711484743059; 
 Tue, 26 Mar 2024 13:25:43 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:6f52:cf6f:a4b1:c71f])
 by smtp.gmail.com with ESMTPSA id
 fq9-20020a056214258900b00690d5310c55sm5530674qvb.114.2024.03.26.13.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:25:42 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>,
 Andrew Davis <afd@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Gilles Talis <gilles.talis@gmail.com>, Patrick Wildt <patrick@blueri.se>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 7/7] arm: davinci:  Migrate da850-evm to OF_UPSTREAM
Date: Tue, 26 Mar 2024 15:23:45 -0500
Message-ID: <20240326202439.46707-7-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326202439.46707-1-aford173@gmail.com>
References: <20240326202439.46707-1-aford173@gmail.com>
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

The da850-evm can remove the U-Boot device trees if migrated
to OF_UPSTREAM.  This means pointing the device trees to the
ti/davinci directory.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/da850-evm.dts b/arch/arm/dts/da850-evm.dts
deleted file mode 100644
index 378af9f344..0000000000
--- a/arch/arm/dts/da850-evm.dts
+++ /dev/null
@@ -1,453 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree for DA850 EVM board
- *
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- */
-/dts-v1/;
-#include "da850.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	compatible = "ti,da850-evm", "ti,da850";
-	model = "DA850/AM1808/OMAP-L138 EVM";
-
-	chosen {
-		stdout-path = &serial2;
-	};
-
-	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		ethernet0 = &eth0;
-		spi0 = &spi1;
-	};
-
-	backlight: backlight-pwm {
-		pinctrl-names = "default";
-		pinctrl-0 = <&ecap2_pins>;
-		power-supply = <&backlight_lcd>;
-		compatible = "pwm-backlight";
-		/*
-		 * The PWM here corresponds to production hardware. The
-		 * schematic needs to be 1015171 (15 March 2010), Rev A
-		 * or newer.
-		 */
-		pwms = <&ecap2 0 50000 0>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
-		default-brightness-level = <7>;
-	};
-
-	panel {
-		compatible = "ti,tilcdc,panel";
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_pins>;
-		/*
-		 * The vpif and the LCD are mutually exclusive.
-		 * To enable VPIF, change the status below to 'disabled' then
-		 * then change the status of the vpif below to 'okay'
-		 */
-		status = "okay";
-		enable-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>; /* lcd_panel_pwr */
-
-		panel-info {
-			ac-bias = <255>;
-			ac-bias-intrpt = <0>;
-			dma-burst-sz = <16>;
-			bpp = <16>;
-			fdd = <0x80>;
-			sync-edge = <0>;
-			sync-ctrl = <1>;
-			raster-order = <0>;
-			fifo-th = <0>;
-		};
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: 480x272 {
-				clock-frequency = <9000000>;
-				hactive = <480>;
-				vactive = <272>;
-				hfront-porch = <3>;
-				hback-porch = <2>;
-				hsync-len = <42>;
-				vback-porch = <3>;
-				vfront-porch = <4>;
-				vsync-len = <11>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-
-	vbat: fixedregulator0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vbat";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
-	};
-
-	baseboard_3v3: fixedregulator-3v3 {
-		/* TPS73701DCQ */
-		compatible = "regulator-fixed";
-		regulator-name = "baseboard_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vbat>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	baseboard_1v8: fixedregulator-1v8 {
-		/* TPS73701DCQ */
-		compatible = "regulator-fixed";
-		regulator-name = "baseboard_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vbat>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	backlight_lcd: backlight-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "lcd_backlight_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* lcd_backlight_pwr */
-		enable-active-high;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "DA850-OMAPL138 EVM";
-		simple-audio-card,widgets =
-			"Line", "Line In",
-			"Line", "Line Out";
-		simple-audio-card,routing =
-			"LINE1L", "Line In",
-			"LINE1R", "Line In",
-			"Line Out", "LLOUT",
-			"Line Out", "RLOUT";
-		simple-audio-card,format = "dsp_b";
-		simple-audio-card,bitclock-master = <&link0_codec>;
-		simple-audio-card,frame-master = <&link0_codec>;
-		simple-audio-card,bitclock-inversion;
-
-		simple-audio-card,cpu {
-			sound-dai = <&mcasp0>;
-			system-clock-frequency = <24576000>;
-		};
-
-		link0_codec: simple-audio-card,codec {
-			sound-dai = <&tlv320aic3106>;
-			system-clock-frequency = <24576000>;
-		};
-	};
-};
-
-&ecap2 {
-	status = "okay";
-};
-
-&ref_clk {
-	clock-frequency = <24000000>;
-};
-
-&pmx_core {
-	status = "okay";
-
-	mcasp0_pins: pinmux_mcasp0_pins {
-		pinctrl-single,bits = <
-			/*
-			 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
-			 * AFSR, AMUTE
-			 */
-			0x00 0x11111111 0xffffffff
-			/* AXR11, AXR12 */
-			0x04 0x00011000 0x000ff000
-		>;
-	};
-	nand_pins: nand_pins {
-		pinctrl-single,bits = <
-			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
-			0x1c 0x10110110  0xf0ff0ff0
-			/*
-			 * EMA_D[0], EMA_D[1], EMA_D[2],
-			 * EMA_D[3], EMA_D[4], EMA_D[5],
-			 * EMA_D[6], EMA_D[7]
-			 */
-			0x24 0x11111111  0xffffffff
-			/* EMA_A[1], EMA_A[2] */
-			0x30 0x01100000  0x0ff00000
-		>;
-	};
-};
-
-&sata {
-	status = "okay";
-};
-
-&serial0 {
-	status = "okay";
-};
-
-&serial1 {
-	status = "okay";
-};
-
-&serial2 {
-	status = "okay";
-};
-
-&rtc0 {
-	status = "okay";
-};
-
-&lcdc {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-
-	tps: tps@48 {
-		reg = <0x48>;
-	};
-	tlv320aic3106: tlv320aic3106@18 {
-		#sound-dai-cells = <0>;
-		compatible = "ti,tlv320aic3106";
-		reg = <0x18>;
-		status = "okay";
-
-		/* Regulators */
-		IOVDD-supply = <&vdcdc2_reg>;
-		AVDD-supply = <&baseboard_3v3>;
-		DRVDD-supply = <&baseboard_3v3>;
-		DVDD-supply = <&baseboard_1v8>;
-	};
-	tca6416: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-	tca6416_bb: gpio@21 {
-		compatible = "ti,tca6416";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&wdt {
-	status = "okay";
-};
-
-&mmc0 {
-	max-frequency = <50000000>;
-	bus-width = <4>;
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio 65 GPIO_ACTIVE_HIGH>;
-};
-
-&spi1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
-	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "m25p64";
-		spi-max-frequency = <30000000>;
-		m25p,fast-read;
-		reg = <0>;
-		partition@0 {
-			label = "U-Boot-SPL";
-			reg = <0x00000000 0x00010000>;
-			read-only;
-		};
-		partition@1 {
-			label = "U-Boot";
-			reg = <0x00010000 0x00080000>;
-			read-only;
-		};
-		partition@2 {
-			label = "U-Boot-Env";
-			reg = <0x00090000 0x00010000>;
-			read-only;
-		};
-		partition@3 {
-			label = "Kernel";
-			reg = <0x000a0000 0x00280000>;
-		};
-		partition@4 {
-			label = "Filesystem";
-			reg = <0x00320000 0x00400000>;
-		};
-		partition@5 {
-			label = "MAC-Address";
-			reg = <0x007f0000 0x00010000>;
-			read-only;
-		};
-	};
-};
-
-&mdio {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mdio_pins>;
-	bus_freq = <2200000>;
-};
-
-&eth0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mii_pins>;
-};
-
-&gpio {
-	status = "okay";
-};
-
-/include/ "tps6507x.dtsi"
-
-&tps {
-	vdcdc1_2-supply = <&vbat>;
-	vdcdc3-supply = <&vbat>;
-	vldo1_2-supply = <&vbat>;
-
-	regulators {
-		vdcdc1_reg: regulator@0 {
-			regulator-name = "VDCDC1_3.3V";
-			regulator-min-microvolt = <3150000>;
-			regulator-max-microvolt = <3450000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		vdcdc2_reg: regulator@1 {
-			regulator-name = "VDCDC2_3.3V";
-			regulator-min-microvolt = <1710000>;
-			regulator-max-microvolt = <3450000>;
-			regulator-always-on;
-			regulator-boot-on;
-			ti,defdcdc_default = <1>;
-		};
-
-		vdcdc3_reg: regulator@2 {
-			regulator-name = "VDCDC3_1.2V";
-			regulator-min-microvolt = <950000>;
-			regulator-max-microvolt = <1350000>;
-			regulator-always-on;
-			regulator-boot-on;
-			ti,defdcdc_default = <1>;
-		};
-
-		ldo1_reg: regulator@3 {
-			regulator-name = "LDO1_1.8V";
-			regulator-min-microvolt = <1710000>;
-			regulator-max-microvolt = <1890000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo2_reg: regulator@4 {
-			regulator-name = "LDO2_1.2V";
-			regulator-min-microvolt = <1140000>;
-			regulator-max-microvolt = <1320000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
-};
-
-&mcasp0 {
-	#sound-dai-cells = <0>;
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcasp0_pins>;
-
-	op-mode = <0>;          /* MCASP_IIS_MODE */
-	tdm-slots = <2>;
-	/* 4 serializer */
-	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
-		0 0 0 0
-		0 0 0 0
-		0 0 0 1
-		2 0 0 0
-	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
-};
-
-&edma0 {
-	ti,edma-reserved-slot-ranges = <32 50>;
-};
-
-&edma1 {
-	ti,edma-reserved-slot-ranges = <32 90>;
-};
-
-&aemif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins>;
-	status = "okay";
-	cs3 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		clock-ranges;
-		ranges;
-
-		ti,cs-chipselect = <3>;
-
-		nand@2000000,0 {
-			compatible = "ti,davinci-nand";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0 0x02000000 0x02000000
-			       1 0x00000000 0x00008000>;
-
-			ti,davinci-chipselect = <1>;
-			ti,davinci-mask-ale = <0>;
-			ti,davinci-mask-cle = <0>;
-			ti,davinci-mask-chipsel = <0>;
-			ti,davinci-ecc-mode = "hw";
-			ti,davinci-ecc-bits = <4>;
-			ti,davinci-nand-use-bbt;
-		};
-	};
-};
-
-&usb_phy {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-};
-
-&usb1 {
-	status = "okay";
-};
-
-&vpif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
-	/*
-	 * The vpif and the LCD are mutually exclusive.
-	 * To enable VPIF, disable the ti,tilcdc,panel then
-	 * change the status below to 'okay'
-	 */
-	status = "disabled";
-};
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 25c5db4991..8fa2660a0c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -9,6 +9,7 @@ config TARGET_DA850EVM
 	select MACH_DAVINCI_DA850_EVM
 	select SOC_DA850
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_OMAPL138_LCDK
 	bool "OMAPL138 LCDK"
diff --git a/configs/da850evm_defconfig b/configs/da850evm_defconfig
index 8130575926..05f29337dc 100644
--- a/configs/da850evm_defconfig
+++ b/configs/da850evm_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x80000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="da850-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x8001ff00
diff --git a/configs/da850evm_direct_nor_defconfig b/configs/da850evm_direct_nor_defconfig
index 4d6efbebf3..936de61071 100644
--- a/configs/da850evm_direct_nor_defconfig
+++ b/configs/da850evm_direct_nor_defconfig
@@ -14,7 +14,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8001ff00
 CONFIG_ENV_SIZE=0x2800
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="da850-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
 CONFIG_SYS_LOAD_ADDR=0xc0700000
 CONFIG_ENV_ADDR=0x60100000
 CONFIG_LTO=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
index 330f88183c..2a4ea808f4 100644
--- a/configs/da850evm_nand_defconfig
+++ b/configs/da850evm_nand_defconfig
@@ -15,7 +15,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0000f20
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="da850-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/davinci/da850-evm"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x8001ff00
-- 
2.43.0

