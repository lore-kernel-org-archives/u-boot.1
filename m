Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA38C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02CD8802E;
	Tue, 26 Mar 2024 21:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9U3Gxh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467CC8803A; Tue, 26 Mar 2024 21:25:12 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AD08803B
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a4817189c8so3529627eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711484708; x=1712089508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buRxu6qzxAA3wHZ+xkqtpdjqW9qBjLZY5lKbnzTdS8k=;
 b=H9U3Gxh9iuEuByoSPZCAez6XGqUa+9ycAt0hd9K2EfttLdSmYkteZuCicyqwTpyloQ
 6wufHfvbd06vfygMz1Q3aWCV1IrHj9mA1eavzZi+Xh2V8Z/FjtVrZNp614F0t9zof/bu
 gUj9IYlt2QNy+9bpXaiakzZ32S5euMYvVcAjpmu6k+NmR2D2Ycd9ZH+wZcTrrAzbxtUP
 wdWJc8Kw4f8ZDKTC6uuUNzGBMkhFhBMzWhFXVsO5tQvR2Kwqt2RPT+mSe1PvjruxEzGK
 2Bx7KrVLbnixMTQcrTxfBpWR/YJ3c8JLvEI/Y+11IzJ5+gcKCUsPQc3JQlYuThdaRYc1
 mdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711484708; x=1712089508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buRxu6qzxAA3wHZ+xkqtpdjqW9qBjLZY5lKbnzTdS8k=;
 b=fSbLoKKyGWXk+QDYRE59d9VV73YreFB64LffsUJNPxy9y8HXNCQARWKqdl1Vw9lcIg
 YFpdACu4RkoWgijK4weg3Xj6NACfA2dsvNJEwb3kEyakoPDjSeeQAfuGLhg3WJTluqzN
 6zykYrXHu6F2IYEExB/fUKzEA9C8jMmCo3Je/AyZgRZrJ+81wYjZ9+LG0l8qBiBHK0HY
 a/8jEeEYIj41WMh2Rv3FyKdpXk9J2vCly1lmwqgKdirWha3k2Ecxjzw2J2TXwqHXPtE9
 dutTN0PNVVc0+wio+EI7Btx/b73c4VL6zSB71+V4XBRyOkC7St58MIFButxW5FyeB6Yh
 e3Jw==
X-Gm-Message-State: AOJu0YwKyaI44bRwYJbQn1bvE9bUUIvaQHvjq5JGqyG4TRR/z9+eo+m7
 lxbXubYo+pj5viIKdKB4ZjbeB+uNq/g9TB7uNmuV7oP+WbrzDxNcS84u/Zy11Cc=
X-Google-Smtp-Source: AGHT+IFEVGVaJ0BuMg4RV/5JhYwty2anV0dO9+G+cwXq/MJ8SGv6gU4t34xhzn2DAYTm9jMz5y7LHw==
X-Received: by 2002:a05:6358:281:b0:17f:5a04:13e with SMTP id
 w1-20020a056358028100b0017f5a04013emr3859209rwj.32.1711484707626; 
 Tue, 26 Mar 2024 13:25:07 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:6f52:cf6f:a4b1:c71f])
 by smtp.gmail.com with ESMTPSA id
 fq9-20020a056214258900b00690d5310c55sm5530674qvb.114.2024.03.26.13.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:25:07 -0700 (PDT)
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
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH 3/7] arm: ti: logicpd-som-lv: Migrate to OF_UPSTREAM
Date: Tue, 26 Mar 2024 15:23:41 -0500
Message-ID: <20240326202439.46707-3-aford173@gmail.com>
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

The DM37 and OMAP35 SOM-LV share a few files, but both of them
can be migrated to OF_UPSTREAM with a small update to their
respective u-boot.dtsi files to address changes made the aliases.
Both defconfigs need to properly point to the upstream directory
structure for the device trees.  With those updated, the U-Boot
device tree files can be deleted.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
index 6f11852a33..d77fa38746 100644
--- a/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
+++ b/arch/arm/dts/logicpd-som-lv-35xx-devkit-u-boot.dtsi
@@ -14,6 +14,8 @@
 	aliases {
 		/delete-property/ serial1;
 		/delete-property/ serial2;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
 	};
 
 	ethernet@08000000 {
diff --git a/arch/arm/dts/logicpd-som-lv-35xx-devkit.dts b/arch/arm/dts/logicpd-som-lv-35xx-devkit.dts
deleted file mode 100644
index f690bc83bf..0000000000
--- a/arch/arm/dts/logicpd-som-lv-35xx-devkit.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/dts-v1/;
-
-#include "omap34xx.dtsi"
-#include "logicpd-som-lv.dtsi"
-#include "logicpd-som-lv-baseboard.dtsi"
-#include "omap-gpmc-smsc9221.dtsi"
-
-/ {
-	model = "LogicPD Zoom OMAP35xx SOM-LV Development Kit";
-	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3430", "ti,omap3";
-};
-
-&omap3_pmx_core2 {
-
-	hsusb2_2_pins: pinmux_hsusb2_2_pins {
-		pinctrl-single,pins = <
-			OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)            /* etk_d10.hsusb2_clk */
-			OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)            /* etk_d11.hsusb2_stp */
-			OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d12.hsusb2_dir */
-			OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d13.hsusb2_nxt */
-			OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d14.hsusb2_data0 */
-			OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d15.hsusb2_data1 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
index 6f11852a33..d77fa38746 100644
--- a/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
+++ b/arch/arm/dts/logicpd-som-lv-37xx-devkit-u-boot.dtsi
@@ -14,6 +14,8 @@
 	aliases {
 		/delete-property/ serial1;
 		/delete-property/ serial2;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
 	};
 
 	ethernet@08000000 {
diff --git a/arch/arm/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/dts/logicpd-som-lv-37xx-devkit.dts
deleted file mode 100644
index e28e9625be..0000000000
--- a/arch/arm/dts/logicpd-som-lv-37xx-devkit.dts
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/dts-v1/;
-
-#include "omap36xx.dtsi"
-#include "logicpd-som-lv.dtsi"
-#include "logicpd-som-lv-baseboard.dtsi"
-#include "omap-gpmc-smsc9221.dtsi"
-
-/ {
-	model = "LogicPD Zoom DM3730 SOM-LV Development Kit";
-	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3";
-};
-
-&omap3_pmx_core2 {
-
-	hsusb2_2_pins: pinmux_hsusb2_2_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)            /* etk_d10.hsusb2_clk */
-			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)            /* etk_d11.hsusb2_stp */
-			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d12.hsusb2_dir */
-			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d13.hsusb2_nxt */
-			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d14.hsusb2_data0 */
-			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d15.hsusb2_data1 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/logicpd-som-lv-baseboard.dtsi b/arch/arm/dts/logicpd-som-lv-baseboard.dtsi
deleted file mode 100644
index 7d0468a237..0000000000
--- a/arch/arm/dts/logicpd-som-lv-baseboard.dtsi
+++ /dev/null
@@ -1,237 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/ {
-	gpio_keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_key_pins>;
-
-		sysboot2 {
-			label = "gpio3";
-			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;	/* gpio_111 / uP_GPIO_3 */
-			linux,code = <BTN_0>;
-			wakeup-source;
-		};
-	};
-
-	sound {
-		compatible = "ti,omap-twl4030";
-		ti,model = "omap3logic";
-		ti,mcbsp = <&mcbsp2>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins &led_pins_wkup>;
-
-		led1 {
-			label = "led1";
-			gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;	/* gpio133 */
-			linux,default-trigger = "cpu0";
-		};
-
-		led2 {
-			label = "led2";
-			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;	/* gpio11 */
-			linux,default-trigger = "none";
-		};
-	};
-};
-
-&vaux1 {
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-};
-
-&vaux4 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-};
-
-&mcbsp2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp2_pins>;
-};
-
-&charger {
-	ti,bb-uvolt = <3200000>;
-	ti,bb-uamp = <150>;
-};
-
-&gpmc {
-	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
-		  1 0 0x2c000000 0x1000000	/* CS1: 16MB for LAN9221 */
-		  2 0 0x10000000 0x2000000>;    /* CS2: 32MB for NOR */
-
-	ethernet@gpmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&lan9221_pins>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;		/* gpio_152 */
-		reg = <1 0 0xff>;
-	};
-};
-
-&vpll2 {
-	regulator-always-on;
-};
-
-&dss {
-	status = "okay";
-	vdds_dsi-supply = <&vpll2>;
-	vdda_video-supply = <&video_reg>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&dss_dpi_pins1>;
-	port {
-		dpi_out: endpoint {
-			remote-endpoint = <&lcd_in>;
-			data-lines = <16>;
-		};
-	};
-};
-
-/ {
-	aliases {
-		display0 = &lcd0;
-	};
-
-	video_reg: video_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	lcd0: display {
-		/* This isn't the exact LCD, but the timings meet spec */
-		compatible = "logicpd,type28";
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_enable_pin>;
-		backlight = <&bl>;
-		enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
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
-		pinctrl-0 = <&backlight_pins>;
-		pwms = <&twl_pwm 0 5000000>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <7>;
-		enable-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>; /* gpio_8 */
-	};
-};
-
-&mmc1 {
-	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;		/* gpio_126 */
-	cd-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;			/* gpio_110 */
-	vmmc-supply = <&vmmc1>;
-	bus-width = <4>;
-	cap-power-off-card;
-};
-
-&omap3_pmx_core {
-	gpio_key_pins: pinmux_gpio_key_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x212e, PIN_INPUT_PULLUP | MUX_MODE4)	/* cam_xclkb.gpio_111 / uP_GPIO_3*/
-		>;
-	};
-
-	led_pins: pinmux_led_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x215e, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* sdmmc2_dat1.gpio_133 / uP_GPIO_0 */
-		>;
-	};
-
-	lan9221_pins: pinmux_lan9221_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 */
-		>;
-	};
-
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
-			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
-			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
-			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
-			OMAP3_CORE1_IOPAD(0x2132, PIN_INPUT_PULLUP | MUX_MODE4)	/* cam_strobe.gpio_126 */
-			OMAP3_CORE1_IOPAD(0x212c, PIN_INPUT_PULLUP | MUX_MODE4)	/* cam_d11.gpio_110 */
-		>;
-	};
-
-	lcd_enable_pin: pinmux_lcd_enable_pin {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x218a, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE4)       /* mcbsp4_fs.gpio_155 */
-		>;
-	};
-
-	dss_dpi_pins1: pinmux_dss_dpi_pins1 {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_pclk.dss_pclk */
-			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_hsync.dss_hsync */
-			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_vsync.dss_vsync */
-			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_acbias.dss_acbias */
-
-			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data0.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data1.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data2.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data3.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data4.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data5.dss_data5 */
-			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data6.dss_data6 */
-			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data7.dss_data7 */
-			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data8.dss_data8 */
-			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data9.dss_data9 */
-			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data10.dss_data10 */
-			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data11.dss_data11 */
-			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data12.dss_data12 */
-			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data13.dss_data13 */
-			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data14.dss_data14 */
-			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data15.dss_data15 */
-		>;
-	};
-};
-
-&omap3_pmx_wkup {
-	led_pins_wkup: pinmux_led_pins_wkup {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 / uP_GPIO_1 */
-		>;
-	};
-
-	backlight_pins: pinmux_backlight_pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a16, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE4)       /* sys_boot6.gpio_8 */
-		>;
-	};
-};
-
-
-&uart1 {
-	interrupts-extended = <&intc 72 &omap3_pmx_core OMAP3_UART1_RX>;
-};
-
-/* Wired to the tps65950 on the SOM, only the USB connector is on the devkit */
-&usb_otg_hs {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb_otg_pins>;
-	interface-type = <0>;
-	usb-phy = <&usb2_phy>;
-	phys = <&usb2_phy>;
-	phy-names = "usb2-phy";
-	mode = <3>;
-	power = <50>;
-};
diff --git a/arch/arm/dts/logicpd-som-lv.dtsi b/arch/arm/dts/logicpd-som-lv.dtsi
deleted file mode 100644
index 385bc8d793..0000000000
--- a/arch/arm/dts/logicpd-som-lv.dtsi
+++ /dev/null
@@ -1,300 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include <dt-bindings/input/input.h>
-
-/ {
-	cpus {
-		cpu@0 {
-			cpu0-supply = <&vcc>;
-		};
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0>;
-	};
-
-	wl12xx_vmmc: wl12xx_vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio1 3 0>;   /* gpio_3 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-		vin-supply = <&vaux3>;
-	};
-
-	/* HS USB Host PHY on PORT 1 */
-	hsusb2_phy: hsusb2_phy {
-		pinctrl-names = "default";
-		pinctrl-0 = <&hsusb2_reset_pin>;
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>; /* gpio_4 */
-		#phy-cells = <0>;
-	};
-
-	/* fixed 26MHz oscillator */
-	hfclk_26m: oscillator {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
-	};
-};
-
-&gpmc {
-	ranges = <0 0 0x30000000 0x1000000>;	/* CS0: 16MB for NAND */
-
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		interrupt-parent = <&gpmc>;
-		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name = "micron,mt29f4g16abbda3w";
-		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
-		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
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
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-		clocks = <&hfclk_26m>;
-		clock-names = "fck";
-		twl_audio: audio {
-			compatible = "ti,twl4030-audio";
-			codec {
-				ti,hs_extmute_gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-	clock-frequency = <400000>;
-
-	touchscreen: tsc2004@48 {
-		compatible = "ti,tsc2004";
-		reg = <0x48>;
-		vio-supply = <&vaux1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&tsc2004_pins>;
-		interrupts-extended = <&gpio5 25 IRQ_TYPE_EDGE_RISING>; /* gpio 153 */
-
-		touchscreen-fuzz-x = <4>;
-		touchscreen-fuzz-y = <7>;
-		touchscreen-fuzz-pressure = <2>;
-		touchscreen-size-x = <4096>;
-		touchscreen-size-y = <4096>;
-		touchscreen-max-pressure = <2048>;
-
-		ti,x-plate-ohms = <280>;
-		ti,esd-recovery-timeout-ms = <8000>;
-	};
-};
-
-&mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
-	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
-	pinctrl-names = "default";
-	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1273";
-		reg = <2>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <2 IRQ_TYPE_EDGE_RISING>; /* gpio 2 */
-		ref-clock-frequency = <26000000>;
-	};
-};
-
-&usbhshost {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_pins>, <&hsusb2_2_pins>;
-	port2-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <0 &hsusb2_phy>;
-};
-
-
-&omap3_pmx_core {
-
-	mmc3_pins: pinmux_mm3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat4.sdmmc3_dat0 */
-			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat5.sdmmc3_dat1 */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat2 */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat3 */
-			OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3) /* mcspi1_cs1.sdmmc3_cmd */
-			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs2.sdmmc_clk */
-		>;
-	};
-
-	mcbsp2_pins: pinmux_mcbsp2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)        /* mcbsp2_fsx */
-			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)        /* mcbsp2_clkx */
-			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)        /* mcbsp2_dr */
-			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)       /* mcbsp2_dx */
-		>;
-	};
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)	/* uart2_cts.uart2_cts */
-			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)	/* uart2_rts .uart2_rts*/
-			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)	/* uart2_tx.uart2_tx */
-			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)	/* uart2_rx.uart2_rx */
-			OMAP3_CORE1_IOPAD(0x2198, PIN_OUTPUT | MUX_MODE4)	/* GPIO_162,BT_EN */
-		>;
-	};
-
-	mcspi1_pins: pinmux_mcspi1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c8, PIN_INPUT | MUX_MODE0)        /* mcspi1_clk.mcspi1_clk */
-			OMAP3_CORE1_IOPAD(0x21ca, PIN_OUTPUT | MUX_MODE0)       /* mcspi1_simo.mcspi1_simo */
-			OMAP3_CORE1_IOPAD(0x21cc, PIN_INPUT_PULLUP | MUX_MODE0) /* mcspi1_somi.mcspi1_somi */
-			OMAP3_CORE1_IOPAD(0x21ce, PIN_OUTPUT | MUX_MODE0)       /* mcspi1_cs0.mcspi1_cs0 */
-		>;
-	};
-
-	hsusb2_pins: pinmux_hsusb2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi1_cs3.hsusb2_data2 */
-			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi2_clk.hsusb2_data7 */
-			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi2_simo.hsusb2_data4 */
-			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi2_somi.hsusb2_data5 */
-			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi2_cs0.hsusb2_data6 */
-			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)       /* mcspi2_cs1.hsusb2_data3 */
-		>;
-	};
-
-	hsusb_otg_pins: pinmux_hsusb_otg_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21a2, PIN_INPUT | MUX_MODE0)	/* hsusb0_clk.hsusb0_clk */
-			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
-			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
-			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
-			OMAP3_CORE1_IOPAD(0x21aa, PIN_INPUT | MUX_MODE0)	/* hsusb0_data0.hsusb0_data0 */
-			OMAP3_CORE1_IOPAD(0x21ac, PIN_INPUT | MUX_MODE0)	/* hsusb0_data1.hsusb0_data1 */
-			OMAP3_CORE1_IOPAD(0x21ae, PIN_INPUT | MUX_MODE0)	/* hsusb0_data2.hsusb0_data2 */
-			OMAP3_CORE1_IOPAD(0x21b0, PIN_INPUT | MUX_MODE0)	/* hsusb0_data3.hsusb0_data3 */
-			OMAP3_CORE1_IOPAD(0x21b2, PIN_INPUT | MUX_MODE0)	/* hsusb0_data4.hsusb0_data4 */
-			OMAP3_CORE1_IOPAD(0x21b4, PIN_INPUT | MUX_MODE0)	/* hsusb0_data5.hsusb0_data5 */
-			OMAP3_CORE1_IOPAD(0x21b6, PIN_INPUT | MUX_MODE0)	/* hsusb0_data6.hsusb0_data6 */
-			OMAP3_CORE1_IOPAD(0x21b8, PIN_INPUT | MUX_MODE0)	/* hsusb0_data7.hsusb0_data7 */
-		>;
-	};
-
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
-			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
-			OMAP3_CORE1_IOPAD(0x20ba, PIN_OUTPUT | MUX_MODE4)        /* gpmc_ncs6.gpio_57 */
-		>;
-	};
-
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
-			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
-		>;
-	};
-
-	tsc2004_pins: pinmux_tsc2004_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE4)	/* mcbsp4_dr.gpio_153 */
-		>;
-	};
-};
-
-&omap3_pmx_wkup {
-
-	hsusb2_reset_pin: pinmux_hsusb1_reset_pin {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0e, PIN_OUTPUT | MUX_MODE4)	/* sys_boot2.gpio_4 */
-		>;
-	};
-
-	wl127x_gpio: pinmux_wl127x_gpio_pin {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0a, PIN_INPUT | MUX_MODE4)		/* sys_boot0.gpio_2 */
-			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
-		>;
-	};
-};
-
-&uart2 {
-	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-};
-
-&mcspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcspi1_pins>;
-};
-
-#include "twl4030.dtsi"
-#include "twl4030_omap3.dtsi"
-
-&vaux3 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-};
-
-&twl {
-	twl_power: power {
-		compatible = "ti,twl4030-power-idle-osc-off", "ti,twl4030-power-idle";
-		ti,use_poweroff;
-	};
-};
-
-&twl_gpio {
-	ti,use-leds;
-};
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index 256ca9921d..a5f242ff40 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -9,7 +9,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="logicpd-som-lv-35xx-devkit"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-35xx-devkit"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
@@ -61,6 +61,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_NAND=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 04ba40111e..68e89d245e 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -9,7 +9,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="logicpd-som-lv-37xx-devkit"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-37xx-devkit"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
@@ -61,6 +61,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.43.0

