Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543ECD277CA
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 00:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BC4843E8;
	Sat, 10 Jan 2026 01:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVDV7Zp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F06B843FA; Sat, 10 Jan 2026 01:00:42 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01A38437C
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 01:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b84417a96a0so61103866b.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 16:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768003238; x=1768608038; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuE4BQHdlLNKmMgixT6SS5gOchyjnMrgLUJ0iZ8l72c=;
 b=MVDV7Zp68yl9fc4vo6/j8D0Kn6cAni4Imh7KN/qk1odrOnBY2s8lZoEiKcqca2muCe
 fzHFYLQnniayQ5sDNOeB8+heKdodhLP29//ucO73kQNRyH8ex9alURpLBmuj4sZo8Ey0
 bDlXjYJaNe+oVmUhqwQ2JRsgTrKwLjrY7qxGhw8CfYG6qaECfGewO95zC16NhQtH9Hvt
 oTsJTsqtnvSCvD1pxTbaCLqaqeiwkDqwSZckIobe9T8mww8h0eASwhxU0YMM9bQUH2WQ
 Gn8IxxQLGtBahbaYr8mQ1opsJDzRxYpGNKCGwUzrEviF1vvj/UqEEDa7RTVG1iDP9RbU
 Cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768003238; x=1768608038;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NuE4BQHdlLNKmMgixT6SS5gOchyjnMrgLUJ0iZ8l72c=;
 b=lO/+fot458scA+YNCI2SM7ul9pAv1yKHAaMTDhtNz6zuOA2l2KN6r8hshgid9YJlSw
 tn6MKyyKbeIVuoFUEbOGCJgaI2qbvStPvrImxHuDKnOycHoVPAivalnsrBJyND+DrfHQ
 NhQ8iSz78vdGUSYm/L3ggZyRCjekDLnuTrZaDVRPbnMQrGTaPS+Da/MrLOImaRqmMHtn
 RsA/EXue14rgXd/jqwypu6zPj0Y5GaYSqkBQGvX0TQxl8F+MNdsQspLAxnST9tIwNLPv
 CQqObsHdCNveALyWm/8SSHfM41ig07DAM+DW98oqYy24cxAtKf/7alWg4jRQzHmPuR5b
 Xp/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+zQAR4w8yBvohgI6emtYxrGCBYd3/p1PwPXSV2nxJ0t9B7AZbeudYMrxEkrWUG44f68NO7tc=@lists.denx.de
X-Gm-Message-State: AOJu0YxkR9ISAjFda7WJqDQwYmueqqU9MZ2+2XmH5bVqSgh+3n9UFecP
 mDfvYUS4GNUFPMQbVaEUvjQPVcr/fcycwSsZiGZssl8gy/Za0e0Mz1PcZDmIww==
X-Gm-Gg: AY/fxX4U3sfGrLmxmG9MJnCGTZhxBXgZeolwpOgcYVF+8s4DGDvlYarThYPq/muQuZS
 1CV9gGIUhZAiuzfQNEjHss93LfC0PLM+HUkIXJoJIccyzk28Ny1Rt7sVdXZgh/J6j95cNa9bLSt
 WdDZa0P1byWAj+C5RYygk/yzpHcKFj5m+N7yyyGlQBlkqIZHMFl24p4tHQkNrPYOkzAeg2M47mi
 jJQF9mV+zzqneX/uU1/cs4IvfsWPQoUqgq0j1rVhBwNkDamRs90be6x7m4xlN0ROpSWnq9XbccC
 avVPd58eUXNurMsRvk6IQ80lo+Q2ixh67Pn8uakYiJQ5G9J7N5KmTFCFe2Nu8t2Mh3b2RuSN1Nl
 c2VW3F/vbpdp4U7Z16nqhp/lARCDN8BEOh/8wolaPLXfzWm3T7zT8D43gGSdXSNzGtyTseWBWxD
 O6d28jzdkniDOAZQC6wSkh9BzrgCrM3xbnzHP+4kn24AYGf5g2ng==
X-Google-Smtp-Source: AGHT+IFwagApN6znDeYtr8j26FNGTldBcookmRFm5XM1Jz75067t6WFwuOY3lKO+zPN73uwVb6e5ng==
X-Received: by 2002:a05:6402:4404:b0:64d:46f:331 with SMTP id
 4fb4d7f45d1cf-65098000b09mr6568755a12.8.1768003237454; 
 Fri, 09 Jan 2026 16:00:37 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a22fa1dsm1284052366b.8.2026.01.09.16.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 16:00:36 -0800 (PST)
Message-ID: <63ff76d9-3429-48cb-80ad-0c0d45702e6b@gmail.com>
Date: Sat, 10 Jan 2026 01:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] rockchip: Switch rk3288-veyron boards to upstream
 devicetree
To: sjg@chromium.org
Cc: philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Switch rk3288-veyron boards to upstream devicetree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/cros-ec-sbs.dtsi                 |  52 --
 arch/arm/dts/rk3288-veyron-chromebook.dtsi    | 205 -----
 arch/arm/dts/rk3288-veyron-jerry.dts          | 208 -----
 arch/arm/dts/rk3288-veyron-mickey.dts         | 266 ------
 arch/arm/dts/rk3288-veyron-minnie.dts         | 302 -------
 arch/arm/dts/rk3288-veyron-speedy.dts         | 143 ----
 arch/arm/dts/rk3288-veyron.dtsi               | 795 ------------------
 board/google/veyron/MAINTAINERS               |  13 -
 configs/chromebit_mickey_defconfig            |   5 +-
 configs/chromebook_jerry_defconfig            |   5 +-
 configs/chromebook_minnie_defconfig           |   5 +-
 configs/chromebook_speedy_defconfig           |   5 +-
 .../src/arm/rockchip/rk3288-veyron.dtsi       |   2 +-
 dts/upstream/src/arm/rockchip/rk3288.dtsi     |   9 +-
 14 files changed, 15 insertions(+), 2000 deletions(-)
 delete mode 100644 arch/arm/dts/cros-ec-sbs.dtsi
 delete mode 100644 arch/arm/dts/rk3288-veyron-chromebook.dtsi
 delete mode 100644 arch/arm/dts/rk3288-veyron-jerry.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-mickey.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-minnie.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron-speedy.dts
 delete mode 100644 arch/arm/dts/rk3288-veyron.dtsi

diff --git a/arch/arm/dts/cros-ec-sbs.dtsi b/arch/arm/dts/cros-ec-sbs.dtsi
deleted file mode 100644
index 71f5c5ecce46..000000000000
--- a/arch/arm/dts/cros-ec-sbs.dtsi
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Smart battery dts fragment for devices that use cros-ec-sbs
- *
- * Copyright (c) 2015 Google, Inc
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
-&i2c_tunnel {
-	battery: sbs-battery@b {
-		compatible = "sbs,sbs-battery";
-		reg = <0xb>;
-		sbs,i2c-retry-count = <2>;
-		sbs,poll-retry-count = <1>;
-	};
-};
diff --git a/arch/arm/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/dts/rk3288-veyron-chromebook.dtsi
deleted file mode 100644
index 143eaae26db5..000000000000
--- a/arch/arm/dts/rk3288-veyron-chromebook.dtsi
+++ /dev/null
@@ -1,205 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Google Veyron (and derivatives) board device tree source
- *
- * Copyright 2014 Google, Inc
- */
-
-#include <dt-bindings/clock/rockchip,rk808.h>
-#include <dt-bindings/input/input.h>
-#include "rk3288-veyron.dtsi"
-
-/ {
-	aliases {
-		i2c20 = &i2c_tunnel;
-		video0 = &vopl;
-		video1 = &vopb;
-	};
-
-	gpio_keys: gpio-keys {
-		pinctrl-0 = <&pwr_key_h &ap_lid_int_l>;
-		lid {
-			label = "Lid";
-			gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-			linux,code = <0>; /* SW_LID */
-			linux,input-type = <5>; /* EV_SW */
-			debounce-interval = <1>;
-			gpio-key,wakeup;
-                };
-	};
-
-	gpio-charger {
-		compatible = "gpio-charger";
-		gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ac_present_ap>;
-		charger-type = "mains";
-	};
-
-	/* A non-regulated voltage from power supply or battery */
-	vccsys: vccsys {
-		compatible = "regulator-fixed";
-		regulator-name = "vccsys";
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	vcc33_sys: vcc33-sys {
-		vin-supply = <&vccsys>;
-	};
-
-	vcc_5v: vcc-5v {
-		vin-supply = <&vccsys>;
-	};
-
-	/* This turns on vbus for host1 (dwc2) */
-	vcc5_host1: vcc5-host1-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host1_pwr_en>;
-		regulator-name = "vcc5_host1";
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	/* This turns on vbus for otg for host mode (dwc2) */
-	vcc5v_otg: vcc5v-otg-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usbotg_pwren_h>;
-		regulator-name = "vcc5_host2";
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&rk808 {
-	regulators {
-		vcc33_ccd: LDO_REG8 {
-			regulator-always-on;
-			regulator-boot-on;
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-name = "vcc33_ccd";
-			regulator-suspend-mem-disabled;
-		};
-	};
-};
-
-&spi0 {
-	status = "okay";
-	spi-activate-delay = <100>;
-	spi-max-frequency = <3000000>;
-	spi-deactivate-delay = <200>;
-
-	cros_ec: ec@0 {
-		compatible = "google,cros-ec-spi";
-		spi-max-frequency = <3000000>;
-		interrupt-parent = <&gpio7>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-		ec-interrupt = <&gpio7 7 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ec_int>;
-		reg = <0>;
-		google,cros-ec-spi-pre-delay = <30>;
-
-		i2c_tunnel: i2c-tunnel {
-			compatible = "google,cros-ec-i2c-tunnel";
-			google,remote-bus = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-};
-
-&i2c4 {
-	trackpad@15 {
-		compatible = "elan,i2c_touchpad";
-		interrupt-parent = <&gpio7>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&trackpad_int>;
-		reg = <0x15>;
-		vcc-supply = <&vcc33_io>;
-		wakeup-source;
-	};
-};
-
-&pinctrl {
-	pinctrl-0 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Wake only */
-		&suspend_l_wake
-		&bt_dev_wake_awake
-	>;
-	pinctrl-1 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Sleep only */
-		&suspend_l_sleep
-		&bt_dev_wake_sleep
-	>;
-
-	buttons {
-		ap_lid_int_l: ap-lid-int-l {
-			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	charger {
-		ac_present_ap: ac-present-ap {
-			rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	cros-ec {
-		ec_int: ec-int {
-			rockchip,pins = <7 7 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_wp_gpio: sdmmc-wp-gpio {
-			rockchip,pins = <7 10 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	suspend {
-		suspend_l_wake: suspend-l-wake {
-			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		suspend_l_sleep: suspend-l-sleep {
-			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	trackpad {
-		trackpad_int: trackpad-int {
-			rockchip,pins = <7 3 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb-host {
-		host1_pwr_en: host1-pwr-en {
-			rockchip,pins = <0 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		usbotg_pwren_h: usbotg-pwren-h {
-			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-#include "cros-ec-keyboard.dtsi"
diff --git a/arch/arm/dts/rk3288-veyron-jerry.dts b/arch/arm/dts/rk3288-veyron-jerry.dts
deleted file mode 100644
index 40fee55c7507..000000000000
--- a/arch/arm/dts/rk3288-veyron-jerry.dts
+++ /dev/null
@@ -1,208 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Google Veyron Jerry Rev 3+ board device tree source
- *
- * Copyright 2014 Google, Inc
- */
-
-/dts-v1/;
-#include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
-
-/ {
-	model = "Google Jerry";
-	compatible = "google,veyron-jerry-rev7", "google,veyron-jerry-rev6",
-		     "google,veyron-jerry-rev5", "google,veyron-jerry-rev4",
-		     "google,veyron-jerry-rev3", "google,veyron-jerry",
-		     "google,veyron", "rockchip,rk3288";
-
-        chosen {
-                stdout-path = &uart2;
-        };
-
-	panel_regulator: panel-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_enable_h>;
-		regulator-name = "panel_regulator";
-		vin-supply = <&vcc33_sys>;
-	};
-
-	vcc18_lcd: vcc18-lcd {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&avdd_1v8_disp_en>;
-		regulator-name = "vcc18_lcd";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc18_wl>;
-	};
-
-	backlight_regulator: backlight-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_pwr_en>;
-		regulator-name = "backlight_regulator";
-		vin-supply = <&vcc33_sys>;
-		startup-delay-us = <15000>;
-	};
-
-	sound {
-		compatible = "rockchip,audio-max98090-jerry";
-
-		cpu {
-			sound-dai = <&i2s 0>;
-		};
-
-		codec {
-			sound-dai = <&max98090 0>;
-		};
-	};
-};
-
-&gpio_keys {
-	power {
-		gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&backlight {
-	power-supply = <&backlight_regulator>;
-};
-
-&panel {
-	power-supply= <&panel_regulator>;
-};
-
-&rk808 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
-		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
-
-	regulators {
-		mic_vcc: LDO_REG2 {
-			regulator-always-on;
-			regulator-boot-on;
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-name = "mic_vcc";
-			regulator-suspend-mem-disabled;
-		};
-	};
-};
-
-&sdmmc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
-			&sdmmc_bus4>;
-	disable-wp;
-};
-
-&vcc_5v {
-	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&drv_5v>;
-};
-
-&vcc50_hdmi {
-	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&vcc50_hdmi_en>;
-};
-
-&edp {
-	pinctrl-names = "default";
-	pinctrl-0 = <&edp_hpd>;
-};
-
-&pinctrl {
-	backlight {
-		bl_pwr_en: bl_pwr_en {
-			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	buck-5v {
-		drv_5v: drv-5v {
-			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	emmc {
-		/* Make sure eMMC is not in reset */
-		emmc_deassert_reset: emmc-deassert-reset {
-			rockchip,pins = <2 9 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	hdmi {
-		vcc50_hdmi_en: vcc50-hdmi-en {
-			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	lcd {
-		lcd_enable_h: lcd-en {
-			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		avdd_1v8_disp_en: avdd-1v8-disp-en {
-			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dvs_1: dvs-1 {
-			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		dvs_2: dvs-2 {
-			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-};
-
-&i2c4 {
-	status = "okay";
-
-	/*
-	 * Trackpad pin control is shared between Elan and Synaptics devices
-	 * so we have to pull it up to the bus level.
-	 */
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c4_xfer &trackpad_int>;
-
-	trackpad@15 {
-		compatible = "elan,i2c_touchpad";
-		interrupt-parent = <&gpio7>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		/*
-		 * Remove the inherited pinctrl settings to avoid clashing
-		 * with bus-wide ones.
-		 */
-		/delete-property/pinctrl-names;
-		/delete-property/pinctrl-0;
-		reg = <0x15>;
-		vcc-supply = <&vcc33_io>;
-		wakeup-source;
-	};
-
-	trackpad@2c {
-		compatible = "hid-over-i2c";
-		interrupt-parent = <&gpio7>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		reg = <0x2c>;
-		hid-descr-addr = <0x0020>;
-		vcc-supply = <&vcc33_io>;
-		wakeup-source;
-	};
-};
diff --git a/arch/arm/dts/rk3288-veyron-mickey.dts b/arch/arm/dts/rk3288-veyron-mickey.dts
deleted file mode 100644
index 0521d9e0e9a2..000000000000
--- a/arch/arm/dts/rk3288-veyron-mickey.dts
+++ /dev/null
@@ -1,266 +0,0 @@
-/*
- * Google Veyron Mickey Rev 0 board device tree source
- *
- * Copyright 2015 Google, Inc
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
- *  Or, alternatively,
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
-#include "rk3288-veyron-chromebook.dtsi"
-
-/ {
-	model = "Google Mickey";
-	compatible = "google,veyron-mickey-rev8", "google,veyron-mickey-rev7",
-		     "google,veyron-mickey-rev6", "google,veyron-mickey-rev5",
-		     "google,veyron-mickey-rev4", "google,veyron-mickey-rev3",
-		     "google,veyron-mickey-rev2", "google,veyron-mickey-rev1",
-		     "google,veyron-mickey-rev0", "google,veyron-mickey",
-		     "google,veyron", "rockchip,rk3288";
-
-	vcc_5v: vcc-5v {
-		vin-supply = <&vcc33_sys>;
-	};
-
-	vcc33_io: vcc33_io {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc33_io";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc33_sys>;
-	};
-};
-
-&cpu_thermal {
-	/delete-node/ trips;
-	/delete-node/ cooling-maps;
-
-	trips {
-		cpu_alert_almost_warm: cpu_alert_almost_warm {
-			temperature = <63000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert_warm: cpu_alert_warm {
-			temperature = <65000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert_almost_hot: cpu_alert_almost_hot {
-			temperature = <80000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert_hot: cpu_alert_hot {
-			temperature = <82000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert_hotter: cpu_alert_hotter {
-			temperature = <84000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_alert_very_hot: cpu_alert_very_hot {
-			temperature = <85000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "passive";
-		};
-		cpu_crit: cpu_crit {
-			temperature = <90000>; /* millicelsius */
-			hysteresis = <2000>; /* millicelsius */
-			type = "critical";
-		};
-	};
-
-	cooling-maps {
-		/*
-		 * After 1st level, throttle the CPU down to as low as 1.4 GHz
-		 * and don't let the GPU go faster than 400 MHz.  Note that we
-		 * won't throttle the GPU lower than 400 MHz due to CPU
-		 * heat--we'll let the GPU do the rest itself.
-		 */
-		cpu_warm_limit_cpu {
-			trip = <&cpu_alert_warm>;
-			cooling-device =
-				<&cpu0 THERMAL_NO_LIMIT 4>;
-		};
-
-		/*
-		 * Add some discrete steps to help throttling system deal
-		 * with the fact that there are two passive cooling devices:
-		 * the CPU and the GPU.
-		 *
-		 * - 1.2 GHz - 1.0 GHz (almost hot)
-		 * - 800 MHz           (hot)
-		 * - 800 MHz - 696 MHz (hotter)
-		 * - 696 MHz - min     (very hot)
-		 *
-		 * Note:
-		 * - 800 MHz appears to be a "sweet spot" for me.  I can run
-		 *   some pretty serious workload here and be happy.
-		 * - After 696 MHz we stop lowering voltage, so throttling
-		 *   past there is less effective.
-		 */
-		cpu_almost_hot_limit_cpu {
-			trip = <&cpu_alert_almost_hot>;
-			cooling-device =
-				<&cpu0 5 6>;
-		};
-		cpu_hot_limit_cpu {
-			trip = <&cpu_alert_hot>;
-			cooling-device =
-				<&cpu0 7 7>;
-		};
-		cpu_hotter_limit_cpu {
-			trip = <&cpu_alert_hotter>;
-			cooling-device =
-				<&cpu0 7 8>;
-		};
-		cpu_very_hot_limit_cpu {
-			trip = <&cpu_alert_very_hot>;
-			cooling-device =
-				<&cpu0 8 THERMAL_NO_LIMIT>;
-		};
-	};
-};
-
-&emmc {
-	/delete-property/mmc-hs200-1_8v;
-};
-
-&i2c2 {
-	status = "disabled";
-};
-
-&i2c4 {
-	status = "disabled";
-};
-
-&i2s {
-	status = "okay";
-	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
-};
-
-&rk808 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
-		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
-
-	/delete-property/ vcc6-supply;
-	/delete-property/ vcc12-supply;
-
-	vcc11-supply = <&vcc33_sys>;
-
-	regulators {
-		/* vcc33_io is sourced directly from vcc33_sys */
-		/delete-node/ LDO_REG1;
-		/delete-node/ LDO_REG7;
-
-		/* This is not a pwren anymore, but the real power supply */
-		vdd10_lcd: LDO_REG7 {
-			regulator-always-on;
-			regulator-boot-on;
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-name = "vdd10_lcd";
-			regulator-suspend-mem-disabled;
-		};
-
-		vcc18_lcd: LDO_REG8 {
-			regulator-always-on;
-			regulator-boot-on;
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-name = "vcc18_lcd";
-			regulator-suspend-mem-disabled;
-		};
-	};
-};
-
-&pinctrl {
-	hdmi {
-		power_hdmi_on: power-hdmi-on {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dvs_1: dvs-1 {
-			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		dvs_2: dvs-2 {
-			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-};
-
-&sdmmc {
-	status = "disabled";
-};
-
-&sdio0 {
-	status = "disabled";
-};
-
-&sdmmc {
-	status = "disabled";
-};
-
-&spi0 {
-	status = "disabled";
-};
-
-&usb_host0_ehci {
-	status = "disabled";
-};
-
-&usb_host1 {
-	status = "disabled";
-};
-
-&vcc50_hdmi {
-	enable-active-high;
-	gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&power_hdmi_on>;
-};
diff --git a/arch/arm/dts/rk3288-veyron-minnie.dts b/arch/arm/dts/rk3288-veyron-minnie.dts
deleted file mode 100644
index b56a3f4f51af..000000000000
--- a/arch/arm/dts/rk3288-veyron-minnie.dts
+++ /dev/null
@@ -1,302 +0,0 @@
-/*
- * Google Veyron Minnie Rev 0+ board device tree source
- *
- * Copyright 2015 Google, Inc
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
- *  Or, alternatively,
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
-#include "rk3288-veyron-chromebook.dtsi"
-
-/ {
-	model = "Google Minnie";
-	compatible = "google,veyron-minnie-rev4", "google,veyron-minnie-rev3",
-		     "google,veyron-minnie-rev2", "google,veyron-minnie-rev1",
-		     "google,veyron-minnie-rev0", "google,veyron-minnie",
-		     "google,veyron", "rockchip,rk3288";
-
-	backlight_regulator: backlight-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_pwr_en>;
-		regulator-name = "backlight_regulator";
-		vin-supply = <&vcc33_sys>;
-		startup-delay-us = <15000>;
-	};
-
-	panel_regulator: panel-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_enable_h>;
-		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
-		vin-supply = <&vcc33_sys>;
-	};
-
-	vcc18_lcd: vcc18-lcd {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&avdd_1v8_disp_en>;
-		regulator-name = "vcc18_lcd";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc18_wl>;
-	};
-
-	sound {
-		compatible = "rockchip,audio-max98090-jerry";
-
-		cpu {
-			sound-dai = <&i2s 0>;
-		};
-
-		codec {
-			sound-dai = <&max98090 0>;
-		};
-	};
-};
-
-&backlight {
-	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <
-			  0   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
-	power-supply = <&backlight_regulator>;
-};
-
-&emmc {
-	/delete-property/mmc-hs200-1_8v;
-};
-
-&gpio_keys {
-	pinctrl-0 = <&pwr_key_h &ap_lid_int_l &volum_down_l &volum_up_l>;
-
-	volum_down {
-		label = "Volum_down";
-		gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
-		linux,code = <KEY_VOLUMEDOWN>;
-		debounce-interval = <100>;
-	};
-
-	volum_up {
-		label = "Volum_up";
-		gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
-		linux,code = <KEY_VOLUMEUP>;
-		debounce-interval = <100>;
-	};
-};
-
-&i2c_tunnel {
-	battery: bq27500@55 {
-		compatible = "ti,bq27500";
-		reg = <0x55>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <50>;
-	i2c-scl-rising-time-ns = <300>;
-
-	touchscreen@10 {
-		compatible = "elan,ekth3500";
-		reg = <0x10>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&touch_int &touch_rst>;
-		reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
-		vcc33-supply = <&vcc33_touch>;
-		vccio-supply = <&vcc33_touch>;
-	};
-};
-
-&panel {
-	compatible = "auo,b101ean01", "simple-panel";
-	power-supply= <&panel_regulator>;
-};
-
-&rk808 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-
-	regulators {
-		vcc33_touch: LDO_REG2 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-name = "vcc33_touch";
-			regulator-state-mem {
-				regulator-off-in-suspend;
-			};
-		};
-
-		vcc5v_touch: SWITCH_REG2 {
-			regulator-name = "vcc5v_touch";
-			regulator-state-mem {
-				regulator-off-in-suspend;
-			};
-		};
-	};
-};
-
-&sdmmc {
-	disable-wp;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
-			&sdmmc_bus4>;
-};
-
-&vcc_5v {
-	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&drv_5v>;
-};
-
-&vcc50_hdmi {
-	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&vcc50_hdmi_en>;
-};
-
-&pinctrl {
-	backlight {
-		bl_pwr_en: bl_pwr_en {
-			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	buck-5v {
-		drv_5v: drv-5v {
-			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	buttons {
-		volum_down_l: volum-down-l {
-			rockchip,pins = <5 11 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		volum_up_l: volum-up-l {
-			rockchip,pins = <5 10 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	hdmi {
-		vcc50_hdmi_en: vcc50-hdmi-en {
-			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	lcd {
-		lcd_enable_h: lcd-en {
-			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		avdd_1v8_disp_en: avdd-1v8-disp-en {
-			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dvs_1: dvs-1 {
-			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		dvs_2: dvs-2 {
-			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
-	prochot {
-		gpio_prochot: gpio-prochot {
-			rockchip,pins = <2 8 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	touchscreen {
-		touch_int: touch-int {
-			rockchip,pins = <2 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		touch_rst: touch-rst {
-			rockchip,pins = <2 15 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
diff --git a/arch/arm/dts/rk3288-veyron-speedy.dts b/arch/arm/dts/rk3288-veyron-speedy.dts
deleted file mode 100644
index 58c1fe96eea2..000000000000
--- a/arch/arm/dts/rk3288-veyron-speedy.dts
+++ /dev/null
@@ -1,143 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Veyron Speedy Rev 1+ board device tree source
- *
- * Copyright 2015 Google, Inc
- */
-
-/dts-v1/;
-#include "rk3288-veyron-chromebook.dtsi"
-#include "cros-ec-sbs.dtsi"
-#include "rk3288-veyron-speedy-u-boot.dtsi"
-
-/ {
-	model = "Google Speedy";
-	compatible = "google,veyron-speedy-rev9", "google,veyron-speedy-rev8",
-		     "google,veyron-speedy-rev7", "google,veyron-speedy-rev6",
-		     "google,veyron-speedy-rev5", "google,veyron-speedy-rev4",
-		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
-		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
-
-	panel_regulator: panel-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcd_enable_h>;
-		regulator-name = "panel_regulator";
-		startup-delay-us = <100000>;
-		vin-supply = <&vcc33_sys>;
-	};
-
-	vcc18_lcd: vcc18-lcd {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&avdd_1v8_disp_en>;
-		regulator-name = "vcc18_lcd";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc18_wl>;
-	};
-
-	backlight_regulator: backlight-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_pwr_en>;
-		regulator-name = "backlight_regulator";
-		vin-supply = <&vcc33_sys>;
-		startup-delay-us = <15000>;
-	};
-};
-
-&backlight {
-	power-supply = <&backlight_regulator>;
-};
-
-&cpu_alert0 {
-	temperature = <65000>;
-};
-
-&cpu_alert1 {
-	temperature = <70000>;
-};
-
-&edp {
-	/delete-property/pinctrl-names;
-	/delete-property/pinctrl-0;
-
-	force-hpd;
-};
-
-&panel {
-	power-supply = <&panel_regulator>;
-};
-
-&rk808 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pmic_int_l>;
-};
-
-&sdmmc {
-	disable-wp;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
-			&sdmmc_bus4>;
-};
-
-&vcc_5v {
-	enable-active-high;
-	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&drv_5v>;
-};
-
-&vcc50_hdmi {
-	enable-active-high;
-	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&vcc50_hdmi_en>;
-};
-
-&pinctrl {
-	backlight {
-		bl_pwr_en: bl_pwr_en {
-			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	buck-5v {
-		drv_5v: drv-5v {
-			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	hdmi {
-		vcc50_hdmi_en: vcc50-hdmi-en {
-			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	lcd {
-		lcd_enable_h: lcd-en {
-			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		avdd_1v8_disp_en: avdd-1v8-disp-en {
-			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dvs_1: dvs-1 {
-			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		dvs_2: dvs-2 {
-			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-};
diff --git a/arch/arm/dts/rk3288-veyron.dtsi b/arch/arm/dts/rk3288-veyron.dtsi
deleted file mode 100644
index 99406151bf59..000000000000
--- a/arch/arm/dts/rk3288-veyron.dtsi
+++ /dev/null
@@ -1,795 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Google Veyron (and derivatives) board device tree source
- *
- * Copyright 2014 Google, Inc
- */
-
-#include <dt-bindings/clock/rockchip,rk808.h>
-#include <dt-bindings/input/input.h>
-#include "rk3288.dtsi"
-
-/ {
-	memory {
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	firmware {
-		chromeos {
-			pinctrl-names = "default";
-			pinctrl-0 = <&fw_wp_ap>;
-			write-protect-gpio = <&gpio7 6 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		brightness-levels = <
-			  0   1   2   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
-		default-brightness-level = <128>;
-		enable-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
-		backlight-boot-off;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en>;
-		pwms = <&pwm0 0 1000000 0>;
-	};
-
-	panel: panel {
-		compatible ="cnm,n116bgeea2","simple-panel";
-		status = "okay";
-		power-supply = <&vcc33_lcd>;
-		backlight = <&backlight>;
-	};
-
-	gpio_keys: gpio-keys {
-		compatible = "gpio-keys";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwr_key_h>;
-		power {
-			label = "Power";
-			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_POWER>;
-			debounce-interval = <100>;
-			gpio-key,wakeup;
-		};
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ap_warm_reset_h>;
-		priority = /bits/ 8 <200>;
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		pinctrl-0 = <&emmc_reset>;
-		pinctrl-names = "default";
-		reset-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
-	};
-
-	sound {
-		compatible = "rockchip,rockchip-audio-max98090";
-		rockchip,model = "ROCKCHIP-I2S";
-		rockchip,i2s-controller = <&i2s>;
-		rockchip,audio-codec = <&max98090>;
-		rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
-		rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
-		rockchip,headset-codec = <&headsetcodec>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&mic_det>, <&hp_det>;
-	};
-
-	vdd_logic: pwm-regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 2000 0>;
-
-		voltage-table = <1350000 0>,
-				<1300000 10>,
-				<1250000 20>,
-				<1200000 31>,
-				<1150000 41>,
-				<1100000 52>,
-				<1050000 62>,
-				<1000000 72>,
-				< 950000 83>;
-
-		regulator-min-microvolt = <950000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-name = "vdd_logic";
-		regulator-ramp-delay = <4000>;
-	};
-
-	vcc33_sys: vcc33-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc33_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vccsys>;
-	};
-
-	vcc_5v: vcc-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	vcc50_hdmi: vcc50-hdmi {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc50_hdmi";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_5v>;
-	};
-
-	bt_regulator: bt-regulator {
-		/*
-		 * On the module itself this is one of these (depending
-		 * on the actual card pouplated):
-		 * - BT_I2S_WS_BT_RFDISABLE_L
-		 * - No connect
-		 */
-
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_enable_l>;
-		regulator-name = "bt_regulator";
-	};
-
-	wifi_regulator: wifi-regulator {
-		/*
-		 * On the module itself this is one of these (depending
-		 * on the actual card populated):
-		 * - SDIO_RESET_L_WL_REG_ON
-		 * - PDN (power down when low)
-		 */
-
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_enable_h>;
-		regulator-name = "wifi_regulator";
-
-		/* Faux input supply.  See bt_regulator description. */
-		vin-supply = <&bt_regulator>;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&efuse {
-	status = "okay";
-};
-
-&emmc {
-	broken-cd;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	mmc-pwrseq = <&emmc_pwrseq>;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8 &emmc_pwr>;
-	status = "okay";
-};
-
-&sdio0 {
-	broken-cd;
-	bus-width = <4>;
-	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	cap-sdio-irq;
-	card-external-vcc-supply = <&wifi_regulator>;
-	clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>, <&cru SCLK_SDIO0_DRV>,
-		 <&cru SCLK_SDIO0_SAMPLE>, <&rk808 RK808_CLKOUT1>;
-	clock-names = "biu", "ciu", "ciu_drv", "ciu_sample", "card_ext_clock";
-	keep-power-in-suspend;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_clk &sdio0_cmd &sdio0_bus4>;
-	status = "okay";
-	vmmc-supply = <&vcc33_sys>;
-	vqmmc-supply = <&vcc18_wl>;
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	card-detect-delay = <200>;
-	cd-gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
-	num-slots = <1>;
-	status = "okay";
-	vmmc-supply = <&vcc33_sd>;
-	vqmmc-supply = <&vccio_sd>;
-};
-
-&spi2 {
-	status = "okay";
-
-	spi_flash: spiflash@0 {
-		compatible = "spidev", "jedec,spi-nor";
-		spi-max-frequency = <20000000>; /* Reduce for Dediprog em100 pro */
-		reg = <0>;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <50>;		/* 2.5ns measured */
-	i2c-scl-rising-time-ns = <100>;		/* 45ns measured */
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		clock-output-names = "xin32k", "wifibt_32kin";
-		interrupt-parent = <&gpio0>;
-		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
-		reg = <0x1b>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-
-		vcc1-supply = <&vcc33_sys>;
-		vcc2-supply = <&vcc33_sys>;
-		vcc3-supply = <&vcc33_sys>;
-		vcc4-supply = <&vcc33_sys>;
-		vcc6-supply = <&vcc_5v>;
-		vcc7-supply = <&vcc33_sys>;
-		vcc8-supply = <&vcc33_sys>;
-		vcc9-supply = <&vcc_5v>;
-		vcc10-supply = <&vcc33_sys>;
-		vcc11-supply = <&vcc_5v>;
-		vcc12-supply = <&vcc_18>;
-
-		vddio-supply = <&vcc33_io>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1450000>;
-				regulator-name = "vdd_arm";
-				regulator-ramp-delay = <6001>;
-				regulator-suspend-mem-disabled;
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-name = "vdd_gpu";
-				regulator-ramp-delay = <6001>;
-				regulator-suspend-mem-disabled;
-			};
-
-			vcc135_ddr: DCDC_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc135_ddr";
-				regulator-suspend-mem-enabled;
-			};
-
-			/*
-			 * vcc_18 has several aliases.  (vcc18_flashio and
-			 * vcc18_wl).  We'll add those aliases here just to
-			 * make it easier to follow the schematic.  The signals
-			 * are actually hooked together and only separated for
-			 * power measurement purposes).
-			 */
-			vcc18_wl: vcc18_flashio: vcc_18: DCDC_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_18";
-				regulator-suspend-mem-microvolt = <1800000>;
-			};
-
-			/*
-			 * Note that both vcc33_io and vcc33_pmuio are always
-			 * powered together. To simplify the logic in the dts
-			 * we just refer to vcc33_io every time something is
-			 * powered from vcc33_pmuio. In fact, on later boards
-			 * (such as danger) they're the same net.
-			 */
-			vcc33_io: LDO_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc33_io";
-				regulator-suspend-mem-microvolt = <3300000>;
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd_10";
-				regulator-suspend-mem-microvolt = <1000000>;
-			};
-
-			vccio_sd: LDO_REG4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vccio_sd";
-				regulator-suspend-mem-disabled;
-			};
-
-			vcc33_sd: LDO_REG5 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc33_sd";
-				regulator-suspend-mem-disabled;
-			};
-
-			vcc18_codec: LDO_REG6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc18_codec";
-				regulator-suspend-mem-disabled;
-			};
-
-			vdd10_lcd_pwren_h: LDO_REG7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-name = "vdd10_lcd_pwren_h";
-				regulator-suspend-mem-disabled;
-			};
-
-			vcc33_lcd: SWITCH_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc33_lcd";
-				regulator-suspend-mem-disabled;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <50>;		/* 2.5ns measured */
-	i2c-scl-rising-time-ns = <100>;		/* 40ns measured */
-
-	tpm: tpm@20 {
-		compatible = "infineon,slb9645tt";
-		reg = <0x20>;
-		powered-while-suspended;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	/* 100kHz since 4.7k resistors don't rise fast enough */
-	clock-frequency = <100000>;
-	i2c-scl-falling-time-ns = <50>;		/* 10ns measured */
-	i2c-scl-rising-time-ns = <800>;		/* 600ns measured */
-
-	max98090: max98090@10 {
-		compatible = "maxim,max98090";
-		reg = <0x10>;
-		#sound-dai-cells = <0>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&int_codec>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <50>;
-	i2c-scl-rising-time-ns = <300>;
-};
-
-&i2c4 {
-	status = "okay";
-
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <50>;		/* 11ns measured */
-	i2c-scl-rising-time-ns = <300>;		/* 225ns measured */
-
-	headsetcodec: ts3a227e@3b {
-		compatible = "ti,ts3a227e";
-		reg = <0x3b>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts3a227e_int_l>;
-		ti,micbias = <7>;		/* MICBIAS = 2.8V */
-	};
-};
-
-&i2c5 {
-	status = "okay";
-
-	clock-frequency = <100000>;
-	i2c-scl-falling-time-ns = <300>;
-	i2c-scl-rising-time-ns = <1000>;
-};
-
-&i2s {
-	status = "okay";
-	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
-};
-
-&io_domains {
-	audio-supply = <&vcc18_codec>;
-	bb-supply = <&vcc33_io>;
-	dvp-supply = <&vcc_18>;
-	flash0-supply = <&vcc18_flashio>;
-	gpio1830-supply = <&vcc33_io>;
-	gpio30-supply = <&vcc33_io>;
-	lcdc-supply = <&vcc33_lcd>;
-	sdcard-supply = <&vccio_sd>;
-	wifi-supply = <&vcc18_wl>;
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-
-	/* Pins don't include flow control by default; add that in */
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	/* We need to go faster than 24MHz, so adjust clock parents / rates */
-	assigned-clocks = <&cru SCLK_UART0>;
-	assigned-clock-rates = <48000000>;
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-	reg-shift = <2>;
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&edp {
-	status = "okay";
-	rockchip,panel = <&panel>;
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&gpu {
-	status = "okay";
-};
-
-&tsadc {
-	tsadc-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
-	tsadc-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
-	status = "okay";
-};
-
-&pinctrl {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Wake only */
-		&bt_dev_wake_awake
-	>;
-	pinctrl-1 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Sleep only */
-		&bt_dev_wake_sleep
-	>;
-
-	/* Add this for sdmmc pins to SD card */
-	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
-		drive-strength = <8>;
-	};
-
-	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
-		bias-pull-up;
-		drive-strength = <8>;
-	};
-
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	pcfg_output_low: pcfg-output-low {
-		output-low;
-	};
-
-	backlight {
-		bl_en: bl-en {
-			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	buttons {
-		pwr_key_h: pwr-key-h {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	codec {
-		hp_det: hp-det {
-			rockchip,pins = <6 5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-		int_codec: int-codec {
-			rockchip,pins = <6 7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-		mic_det: mic-det {
-			rockchip,pins = <6 11 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	emmc {
-		emmc_reset: emmc-reset {
-			rockchip,pins = <2 9 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		/*
-		 * We run eMMC at max speed; bump up drive strength.
-		 * We also have external pulls, so disable the internal ones.
-		 */
-		emmc_clk: emmc-clk {
-			rockchip,pins = <3 18 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
-		};
-
-		emmc_cmd: emmc-cmd {
-			rockchip,pins = <3 16 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
-		};
-
-		emmc_bus8: emmc-bus8 {
-			rockchip,pins = <3 0 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 1 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 2 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 3 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 4 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 5 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 6 RK_FUNC_2 &pcfg_pull_none_drv_8ma>,
-					<3 7 RK_FUNC_2 &pcfg_pull_none_drv_8ma>;
-		};
-	};
-
-	headset {
-		ts3a227e_int_l: ts3a227e-int-l {
-			rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	pmic {
-		pmic_int_l: pmic-int-l {
-			/*
-			 * Causes jerry to hang when probing bus 0
-			 * rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-			 */
-		};
-	};
-
-	reboot {
-		ap_warm_reset_h: ap-warm-reset-h {
-			rockchip,pins = <RK_GPIO0 13 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdio0 {
-		wifi_enable_h: wifienable-h {
-			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		/* NOTE: mislabelled on schematic; should be bt_enable_h */
-		bt_enable_l: bt-enable-l {
-			rockchip,pins = <4 29 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		/*
-		 * We run sdio0 at max speed; bump up drive strength.
-		 * We also have external pulls, so disable the internal ones.
-		 */
-		sdio0_bus4: sdio0-bus4 {
-			rockchip,pins = <4 20 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<4 21 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<4 22 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<4 23 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		sdio0_cmd: sdio0-cmd {
-			rockchip,pins = <4 24 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		sdio0_clk: sdio0-clk {
-			rockchip,pins = <4 25 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		/*
-		 * These pins are only present on very new veyron boards; on
-		 * older boards bt_dev_wake is simply always high.  Note that
-		 * gpio4_26 is a NC on old veyron boards, so it doesn't hurt
-		 * to map this pin everywhere
-		 */
-		bt_dev_wake_sleep: bt-dev-wake-sleep {
-			rockchip,pins = <4 26 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		bt_dev_wake_awake: bt-dev-wake-awake {
-			rockchip,pins = <4 26 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	sdmmc {
-		/*
-		 * We run sdmmc at max speed; bump up drive strength.
-		 * We also have external pulls, so disable the internal ones.
-		 */
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<6 17 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<6 18 RK_FUNC_1 &pcfg_pull_none_drv_8ma>,
-					<6 19 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		/*
-		 * Builtin CD line is hooked to ground to prevent JTAG at boot
-		 * (and also to get the voltage rail correct).  Make we
-		 * configure gpio6_C6 as GPIO so dw_mmc builtin CD doesn't
-		 * think there's a card inserted
-		 */
-		sdmmc_cd_disabled: sdmmc-cd-disabled {
-			rockchip,pins = <6 22 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		/* This is where we actually hook up CD */
-		sdmmc_cd_gpio: sdmmc-cd-gpio {
-			rockchip,pins = <7 5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	tpm {
-		tpm_int_h: tpm-int-h {
-			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	write-protect {
-		fw_wp_ap: fw-wp-ap {
-			rockchip,pins = <7 6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&usbphy {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-	needs-reset-on-resume;
-};
-
-&usb_host1 {
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-	assigned-clocks = <&cru SCLK_USBPHY480M_SRC>;
-	assigned-clock-parents = <&cru SCLK_OTGPHY0>;
-};
diff --git a/board/google/veyron/MAINTAINERS b/board/google/veyron/MAINTAINERS
index 67341b5d5564..c9d0a74bb904 100644
--- a/board/google/veyron/MAINTAINERS
+++ b/board/google/veyron/MAINTAINERS
@@ -1,7 +1,6 @@
 CHROMEBOOK JERRY BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-veyron-jerry.dts
 F:	arch/arm/dts/rk3288-veyron-jerry-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
@@ -10,7 +9,6 @@ F:	configs/chromebook_jerry_defconfig
 CHROMEBIT MICKEY BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-veyron-mickey.dts
 F:	arch/arm/dts/rk3288-veyron-mickey-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
@@ -19,7 +17,6 @@ F:	configs/chromebit_mickey_defconfig
 CHROMEBOOK MINNIE BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-veyron-minnie.dts
 F:	arch/arm/dts/rk3288-veyron-minnie-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
@@ -28,17 +25,7 @@ F:	configs/chromebook_minnie_defconfig
 CHROMEBOOK SPEEDY BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-veyron-speedy.dts
 F:	arch/arm/dts/rk3288-veyron-speedy-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
 F:	configs/chromebook_speedy_defconfig
-
-CHROMEBOOK VEYRON COMMON FILES
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	arch/arm/dts/rk3288-veyron.dtsi
-F:	arch/arm/dts/rk3288-veyron-analog-audio.dtsi
-F:	arch/arm/dts/rk3288-veyron-broadcom-bluetooth.dtsi
-F:	arch/arm/dts/rk3288-veyron-chromebook.dtsi
-F:	arch/arm/dts/rk3288-veyron-edp.dtsi
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 02f7876f2dc1..1ae596b4f4f6 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-veyron-mickey"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-veyron-mickey"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -29,7 +29,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-mickey.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-veyron-mickey.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -56,6 +56,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 928a713cd1fd..5151af8838e4 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-veyron-jerry"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-veyron-jerry"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -28,7 +28,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-jerry.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-veyron-jerry.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -56,6 +56,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 7a875d42c3f1..3ab1e90746f5 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-veyron-minnie"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-veyron-minnie"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -29,7 +29,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-minnie.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-veyron-minnie.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -57,6 +57,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index d890a344f521..796d29604242 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-veyron-speedy"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-veyron-speedy"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -29,7 +29,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_PAYLOAD="u-boot.img"
 CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-speedy.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-veyron-speedy.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -57,6 +57,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
index 260d6c92cfd1..2d6cf08d00f9 100644
--- a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
@@ -388,7 +388,7 @@

 	rx-sample-delay-ns = <12>;

-	flash@0 {
+	spi_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
index 42d705b544ec..7477fc5da3ec 100644
--- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
@@ -34,10 +34,6 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -745,9 +741,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;

-			assigned-clocks = <&cru SCLK_EDP_24M>;
-			assigned-clock-parents = <&xin24m>;
-
 			/*
 			 * Note: Although SCLK_* are the working clocks
 			 * of device without including on the NOC, needed for
@@ -1197,6 +1190,8 @@
 		compatible = "rockchip,rk3288-dp";
 		reg = <0x0 0xff970000 0x0 0x4000>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru SCLK_EDP_24M>;
+		assigned-clock-parents = <&xin24m>;
 		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
 		clock-names = "dp", "pclk";
 		phys = <&edp_phy>;
--
2.39.5

