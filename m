Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B07C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5519A87C62;
	Tue, 26 Mar 2024 21:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwRUJTG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D716C8772A; Tue, 26 Mar 2024 21:25:02 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B869187D09
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-690caa6438aso33984876d6.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711484698; x=1712089498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAXM3N2DW3UYzALQ+gCDB9FBLGVCurtGmVDoXRE6L1M=;
 b=mwRUJTG1ALXYgs+CLPIOkgF8tLCWmtOcOMpn5Kk1GGma7tY22Uh5IHNsPvKjzBueRk
 YsUgX750Ik3LRF/5S7mSgiC5OWAuLZxCXqUU6k+1C+17xGe4Myad5eRu2RbZ3FnKJ8+K
 TX5Vo5RnvVfHlclHp3MFJu9idNQrR4L8iRsRdYwDhbS+MEcddI2ElhE3Uy49d4eorqF0
 N12u1/hEZIMUmYbm5ncIY26LqfFwqQ5v5lrMG4x3NiyFg7rd1hSXH8NzIJJGyFNZ+aHQ
 ixFRm0hiZcLalLp/zM5+8ba9xJfMdkiLN0U5wtapX2Vx8ZTNDxLQwTD4kmRSpHMIFsml
 klXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711484698; x=1712089498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAXM3N2DW3UYzALQ+gCDB9FBLGVCurtGmVDoXRE6L1M=;
 b=n7cfs95JOvmzhiEnUAPKOpuUPYuXpRAH9Gq5mWurtiX7LtvmXJJJwEcg4e1VAN5t70
 yb2fFGc9y1TPPSlKkrpEQTAdeUtJW8PDJW+yvxVGl7n6kzdkuS4eeT/r6WkjaUpskePx
 DnkK43elFgHle0xIa/gGQRzPs9LZrjlwjaihaZhGz1Hih5mlJsQcxAbhznk339VPO4mx
 hTlSavRwuh7WMj/MWGKfp8j7x89w/Yt7qtNKWTbjXCSJ0cmz5vb3iD2fwfTIOWYWIwzv
 no3BRmCyrb4G38oL10iSTA/i/NuUeDdKzI8G9DRLRU4NtIX36McLos1DdkiF1Wf9ArRP
 Z8aA==
X-Gm-Message-State: AOJu0YwY6+w7wK4XKLgLI9FuYLpLVYt6o/pxPmhHG8yz10oBbV3Yx1HN
 Ccc6r3p3vKxf0096La4WhoWtvuzPS61kg0DWgW7tdwFOMQX5E7lmRV7/PWFipyA=
X-Google-Smtp-Source: AGHT+IH/lDfiVoZ8/Us09Wqf9YuvQwq8KcZjvG8+Mpyb4byKD6H2jV6fMKRn2shDsskPvj6dCLzFPQ==
X-Received: by 2002:a05:6214:248f:b0:690:cbd1:85d6 with SMTP id
 gi15-20020a056214248f00b00690cbd185d6mr2192561qvb.33.1711484698003; 
 Tue, 26 Mar 2024 13:24:58 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:6f52:cf6f:a4b1:c71f])
 by smtp.gmail.com with ESMTPSA id
 fq9-20020a056214258900b00690d5310c55sm5530674qvb.114.2024.03.26.13.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:24:57 -0700 (PDT)
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
 Patrick Wildt <patrick@blueri.se>, Gilles Talis <gilles.talis@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 2/7] arm: ti: logicpd-torpedo: Migrate to OF_UPSTREAM
Date: Tue, 26 Mar 2024 15:23:40 -0500
Message-ID: <20240326202439.46707-2-aford173@gmail.com>
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

The DM37 and OMAP35 Torpedo share a few files, but both of them
can be migrated to OF_UPSTREAM with a small update to their
respective u-boot.dtsi files to address changes made the aliases.
Both defconfigs need to properly point to the upstream directory
structure for the device trees.  With those updated, the U-Boot
device tree files can be deleted.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
index 4744872f7c..d14d68e458 100644
--- a/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
+++ b/arch/arm/dts/logicpd-torpedo-35xx-devkit-u-boot.dtsi
@@ -14,6 +14,8 @@
 	aliases {
 		/delete-property/ serial1;
 		/delete-property/ serial2;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
 	};
 
 	ethernet@08000000 {
diff --git a/arch/arm/dts/logicpd-torpedo-35xx-devkit.dts b/arch/arm/dts/logicpd-torpedo-35xx-devkit.dts
deleted file mode 100644
index cb08aa62d9..0000000000
--- a/arch/arm/dts/logicpd-torpedo-35xx-devkit.dts
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/dts-v1/;
-
-#include "omap34xx.dtsi"
-#include "logicpd-torpedo-som.dtsi"
-#include "logicpd-torpedo-baseboard.dtsi"
-#include "omap-gpmc-smsc9221.dtsi"
-
-/ {
-	model = "LogicPD Zoom OMAP35xx Torpedo Development Kit";
-	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3430", "ti,omap3";
-};
-
-&omap3_pmx_core {
-	isp1763_pins: pinmux_isp1763_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2154,  PIN_INPUT_PULLUP | MUX_MODE4)	/* sdmmc1_dat6.gpio_128 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi b/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
index 2c34344504..8e8e2e4096 100644
--- a/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
+++ b/arch/arm/dts/logicpd-torpedo-37xx-devkit-u-boot.dtsi
@@ -10,6 +10,8 @@
 	aliases {
 		/delete-property/ serial1;
 		/delete-property/ serial2;
+		/delete-property/ mmc1;
+		/delete-property/ mmc2;
 	};
 
 	ethernet@08000000 {
diff --git a/arch/arm/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/dts/logicpd-torpedo-37xx-devkit.dts
deleted file mode 100644
index 07ea822fe4..0000000000
--- a/arch/arm/dts/logicpd-torpedo-37xx-devkit.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/dts-v1/;
-
-#include "omap36xx.dtsi"
-#include "logicpd-torpedo-som.dtsi"
-#include "omap-gpmc-smsc9221.dtsi"
-#include "logicpd-torpedo-baseboard.dtsi"
-
-/ {
-	model = "LogicPD Zoom DM3730 Torpedo + Wireless Development Kit";
-	compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3";
-
-	wl12xx_vmmc: wl12xx_vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "vwl1271";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio5 29 0>;   /* gpio157 */
-		startup-delay-us = <70000>;
-		enable-active-high;
-		vin-supply = <&vmmc2>;
-	};
-};
-
-/*
- * Only found on the wireless SOM. For the SOM without wireless, the pins for
- * MMC3 can be routed with jumpers to the second MMC slot on the devkit and
- * gpio157 is not connected. So this should be OK to keep common for now,
- * probably device tree overlays is the way to go with the various SOM and
- * jumpering combinations for the long run.
- */
-&mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
-	pinctrl-0 = <&mmc3_pins &mmc3_core2_pins>;
-	pinctrl-names = "default";
-	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
-	bus-width = <4>;
-	cap-power-off-card;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	wlcore: wlcore@2 {
-		compatible = "ti,wl1283";
-		reg = <2>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <24 IRQ_TYPE_EDGE_RISING>; /* gpio 152 */
-		ref-clock-frequency = <26000000>;
-		tcxo-clock-frequency = <26000000>;
-	};
-};
-
-&uart2 {
-	/delete-property/dma-names;
-	bluetooth {
-		compatible = "ti,wl1283-st";
-		enable-gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>; /* gpio 162 */
-		max-speed = <3000000>;
-	};
-};
-
-/* The DM3730 has a faster L3 than OMAP35, so increase pixel clock */
-&mt9p031_out {
-	pixel-clock-frequency = <90000000>;
-};
-
-&omap3_pmx_core {
-	mmc3_pins: pinmux_mm3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2164, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat4.sdmmc3_dat0 */
-			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat5.sdmmc3_dat1 */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat2 */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat3 */
-			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 */
-			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_fsr.gpio_157 */
-		>;
-	};
-};
-
-&omap3_pmx_core2 {
-	mmc3_core2_pins: pinmux_mmc3_core2_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_clk.sdmmc3_clk */
-			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
-		>;
-	};
-};
-
-/* The gpio muxing between omap3530 and dm3730 is different for GPIO_128 */
-&omap3_pmx_wkup {
-	isp1763_pins: pinmux_isp1763_pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a58, PIN_INPUT_PULLUP | MUX_MODE4)	/* reserved.gpio_128 */
-		>;
-	};
-};
diff --git a/arch/arm/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/dts/logicpd-torpedo-baseboard.dtsi
deleted file mode 100644
index b4664ab002..0000000000
--- a/arch/arm/dts/logicpd-torpedo-baseboard.dtsi
+++ /dev/null
@@ -1,420 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-/ {
-	gpio_keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_key_pins &gpio_key_pins_wkup>;
-
-		sysboot2 {
-			label = "sysboot2";
-			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;	/* gpio2 */
-			linux,code = <BTN_0>;
-			wakeup-source;
-		};
-
-		sysboot5 {
-			label = "sysboot5";
-			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;	/* gpio7 */
-			linux,code = <BTN_1>;
-			wakeup-source;
-		};
-
-		gpio1 {
-			label = "gpio1";
-			gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;	/* gpio181 */
-			linux,code = <BTN_2>;
-			wakeup-source;
-		};
-
-		gpio2 {
-			label = "gpio2";
-			gpios = <&gpio6 18 GPIO_ACTIVE_LOW>;	/* gpio178 */
-			linux,code = <BTN_3>;
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
-		pinctrl-0 = <&led_pins>;
-
-		led1 {
-			label = "led1";
-			gpios = <&gpio6 20 GPIO_ACTIVE_HIGH>;	/* gpio180 */
-			linux,default-trigger = "cpu0";
-		};
-
-		led2 {
-			label = "led2";
-			gpios = <&gpio6 19 GPIO_ACTIVE_HIGH>;	/* gpio179 */
-			linux,default-trigger = "none";
-		};
-	};
-
-	pwm10: dmtimer-pwm {
-		compatible = "ti,omap-dmtimer-pwm";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm_pins>;
-		ti,timers = <&timer10>;
-		#pwm-cells = <3>;
-		ti,clock-source = <0x01>;
-	};
-
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
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp2_pins>;
-	status = "okay";
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
-		  6 0 0x28000000 0x1000000>;	/* CS6: 16MB for ISP1763 */
-
-	ethernet@gpmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&lan9221_pins>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;		/* gpio129 */
-		reg = <1 0 0xff>;
-	};
-
-	usb@6,0 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&isp1763_pins>;
-		compatible = "nxp,usb-isp1763";
-		reg = <0x6 0x0 0xff>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "host";
-		bus-width = <16>;
-		dr_mode = "host";
-		gpmc,mux-add-data = <0>;
-		gpmc,device-width = <2>;
-		gpmc,wait-pin = <0>;
-		gpmc,burst-length = <4>;
-		gpmc,cycle2cycle-samecsen = <1>;
-		gpmc,cycle2cycle-diffcsen = <1>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <45>;
-		gpmc,cs-wr-off-ns = <45>;
-		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <0>;
-		gpmc,adv-wr-off-ns = <0>;
-		gpmc,oe-on-ns = <0>;
-		gpmc,oe-off-ns = <45>;
-		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <25>;
-		gpmc,rd-cycle-ns = <60>;
-		gpmc,wr-cycle-ns = <45>;
-		gpmc,access-ns = <35>;
-		gpmc,page-burst-access-ns = <0>;
-		gpmc,bus-turnaround-ns = <0>;
-		gpmc,cycle2cycle-delay-ns = <60>;
-		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <0>;
-		gpmc,wr-data-mux-bus-ns = <5>;
-		gpmc,wr-access-ns = <20>;
-	};
-};
-
-&hdqw1w {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdq_pins>;
-};
-
-
-&vpll2 {
-	regulator-always-on;
-};
-
-&dss {
-	status = "okay";
-	vdds_dsi-supply = <&vpll2>;
-	vdda_video-supply = <&vpll2>;
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
-	lcd0: display {
-		/* This isn't the exact LCD, but the timings meet spec */
-		compatible = "newhaven,nhd-4.3-480272ef-atxl";
-		label = "15";
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_pwr_pins>;
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
-		pwms = <&pwm10 0 5000000 0>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <7>;
-		enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>; /* gpio_154 */
-	};
-};
-
-&mmc1 {
-	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins &mmc1_cd>;
-	cd-gpios = <&gpio4 31 GPIO_ACTIVE_LOW>;		/* gpio127 */
-	vmmc-supply = <&vmmc1>;
-	bus-width = <4>;
-	cap-power-off-card;
-};
-
-&omap3_pmx_core {
-	gpio_key_pins: pinmux_gpio_key_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcspi2_clk.gpio_178 */
-			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcspi2_cs0.gpio_181 */
-		>;
-	};
-
-	hdq_pins: hdq_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* hdq_sio */
-		>;
-	};
-
-	pwm_pins: pinmux_pwm_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20B8, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE3)       /* gpmc_ncs5.gpt_10_pwm_evt */
-		>;
-	};
-
-	led_pins: pinmux_led_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d8, PIN_OUTPUT | MUX_MODE4)	/* gpio_179 */
-			OMAP3_CORE1_IOPAD(0x21da, PIN_OUTPUT | MUX_MODE4)	/* gpio_180 */
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
-		>;
-	};
-
-	tsc2004_pins: pinmux_tsc2004_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE4)	/* mcbsp4_dr.gpio_153 */
-		>;
-	};
-
-	backlight_pins: pinmux_backlight_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2188, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE4)       /* mcbsp4_dx.gpio_154 */
-		>;
-	};
-
-	isp_pins: pinmux_isp_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x210c, PIN_INPUT | MUX_MODE0)   /* cam_hs.cam_hs */
-			OMAP3_CORE1_IOPAD(0x210e, PIN_INPUT | MUX_MODE0)   /* cam_vs.cam_vs */
-			OMAP3_CORE1_IOPAD(0x2110, PIN_INPUT | MUX_MODE0)   /* cam_xclka.cam_xclka */
-			OMAP3_CORE1_IOPAD(0x2112, PIN_INPUT | MUX_MODE0)   /* cam_pclk.cam_pclk */
-
-			OMAP3_CORE1_IOPAD(0x2116, PIN_INPUT | MUX_MODE0)   /* cam_d0.cam_d0 */
-			OMAP3_CORE1_IOPAD(0x2118, PIN_INPUT | MUX_MODE0)   /* cam_d1.cam_d1 */
-			OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT | MUX_MODE0)   /* cam_d2.cam_d2 */
-			OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT | MUX_MODE0)   /* cam_d3.cam_d3 */
-			OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT | MUX_MODE0)   /* cam_d4.cam_d4 */
-			OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT | MUX_MODE0)   /* cam_d5.cam_d5 */
-			OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT | MUX_MODE0)   /* cam_d6.cam_d6 */
-			OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT | MUX_MODE0)   /* cam_d7.cam_d7 */
-		>;
-	};
-
-	panel_pwr_pins: pinmux_panel_pwr_pins {
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
-			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data16.dss_data16 */
-			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE0)   /* dss_data17.dss_data17 */
-
-			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data18.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data19.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data20.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data21.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data22.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT_PULLDOWN | PIN_OFF_OUTPUT_LOW | MUX_MODE3)   /* dss_data23.dss_data5 */
-		>;
-	};
-};
-
-&omap3_pmx_wkup {
-	gpio_key_pins_wkup: pinmux_gpio_key_pins_wkup {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a0a, PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_boot0.gpio_2 */
-			OMAP3_WKUP_IOPAD(0x2a14, PIN_INPUT_PULLUP | MUX_MODE4)	/* sys_boot5.gpio_7 */
-		>;
-	};
-
-	lan9221_pins: pinmux_lan9221_pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a5a, PIN_INPUT | MUX_MODE4)		/* reserved.gpio_129 */
-		>;
-	};
-
-	mmc1_cd: pinmux_mmc1_cd {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a54, PIN_INPUT_PULLUP | MUX_MODE4)	/* reserved.gpio_127 */
-		>;
-	};
-};
-
-&i2c2 {
-	mt9p031@48 {
-		compatible = "aptina,mt9p031";
-		reg = <0x48>;
-		clocks = <&isp 0>;
-		vaa-supply = <&vaux4>;
-		vdd-supply = <&vaux4>;
-		vdd_io-supply = <&vaux4>;
-		port {
-			mt9p031_out: endpoint {
-				input-clock-frequency = <24000000>;
-				pixel-clock-frequency = <72000000>;
-				remote-endpoint = <&ccdc_ep>;
-			};
-		};
-	};
-};
-
-&i2c3 {
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
-&mcspi1 {
-	at25@0 {
-		compatible = "atmel,at25";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpha;
-		spi-cpol;
-
-		pagesize = <64>;
-		size = <32768>;
-		address-width = <16>;
-	};
-};
-
-&isp {
-	pinctrl-names = "default";
-	pinctrl-0 = <&isp_pins>;
-	ports {
-		port@0 {
-			reg = <0>;
-			ccdc_ep: endpoint {
-				remote-endpoint = <&mt9p031_out>;
-				bus-width = <8>;
-				hsync-active = <1>;
-				vsync-active = <1>;
-				pclk-sample = <0>;
-			};
-		};
-	};
-};
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
diff --git a/arch/arm/dts/logicpd-torpedo-som.dtsi b/arch/arm/dts/logicpd-torpedo-som.dtsi
deleted file mode 100644
index 3a5228562b..0000000000
--- a/arch/arm/dts/logicpd-torpedo-som.dtsi
+++ /dev/null
@@ -1,203 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include <dt-bindings/input/input.h>
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
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
-	leds {
-		compatible = "gpio-leds";
-		user0 {
-			label = "user0";
-			gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* LEDA */
-			linux,default-trigger = "none";
-		};
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
-/* The Torpedo doesn't route the USB host pins */
-&usbhshost {
-	status = "disabled";
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
-
-		twl_audio: audio {
-			compatible = "ti,twl4030-audio";
-			codec {
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
-	at24@50 {
-		compatible = "atmel,24c64";
-		readonly;
-		reg = <0x50>;
-	};
-};
-
-&omap3_pmx_core {
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
-	mcspi1_pins: pinmux_mcspi1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c8, PIN_INPUT | MUX_MODE0)        /* mcspi1_clk.mcspi1_clk */
-			OMAP3_CORE1_IOPAD(0x21ca, PIN_OUTPUT | MUX_MODE0)       /* mcspi1_simo.mcspi1_simo */
-			OMAP3_CORE1_IOPAD(0x21cc, PIN_INPUT_PULLUP | MUX_MODE0) /* mcspi1_somi.mcspi1_somi */
-			OMAP3_CORE1_IOPAD(0x21ce, PIN_OUTPUT | MUX_MODE0)       /* mcspi1_cs0.mcspi1_cs0 */
-		>;
-	};
-	hsusb_otg_pins: pinmux_hsusb_otg_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21a2, PIN_INPUT | MUX_MODE0)	/* hsusb0_clk.hsusb0_clk */
-			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)	/* hsusb0_stp.hsusb0_stp */
-			OMAP3_CORE1_IOPAD(0x21a6, PIN_INPUT | MUX_MODE0)	/* hsusb0_dir.hsusb0_dir */
-			OMAP3_CORE1_IOPAD(0x21a8, PIN_INPUT | MUX_MODE0)	/* hsusb0_nxt.hsusb0_nxt */
-
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
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
-			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
-		>;
-	};
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
-			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
-		>;
-	};
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
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
-
-&twl_keypad {
-	status = "disabled";
-};
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index f9b8ac5c07..23b2e50338 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -9,7 +9,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="logicpd-torpedo-35xx-devkit"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-35xx-devkit"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
@@ -59,6 +59,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_NAND=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 00c4d847d2..d081d4e0fb 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -9,7 +9,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
-CONFIG_DEFAULT_DEVICE_TREE="logicpd-torpedo-37xx-devkit"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-37xx-devkit"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
@@ -58,6 +58,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:512k(MLO),1792k(u-boot),128k(spl-
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.43.0

