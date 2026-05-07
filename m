Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEECD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 18:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4238484F;
	Thu,  7 May 2026 20:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGHFpUNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2402C84099; Thu,  7 May 2026 20:38:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA6884BDE
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bc1efa13e30so13569166b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778179101; x=1778783901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3EPxjE6AEY7h5lOBn/VLnitrUpHcJSWofAvY3sOxNUw=;
 b=gGHFpUNz1/Wi0s3zH2XBzmMjrLiQjl35BQ2F68ysy/lVJ6yjahqilx/Esss28Lh78b
 zTATXvSnQ+5R/0O1NKoWyLd3nEEaUY+isxD+VuJG8XmVtP+4mGhrCu0Ih4uSolKW09cE
 8Fnrzri89NwgPRLkiETuAih4zgUdWD1ePIla0kRR8fx5jPiuMP/O6VGzlyCHSxRBJ3xg
 +8tScRjB1+eRDDP49mE3yutM7kJRRNj20aFxVvyBftXMxpd16Wdpo2GFgD9r14Qa3w0D
 QKH5xNAQhAt8jjKf6njvDEmmeiKF5tbWuN9lZHXSKq14/wF5ZzLPN4vq6nAk+Qmn3VoD
 pknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778179101; x=1778783901;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3EPxjE6AEY7h5lOBn/VLnitrUpHcJSWofAvY3sOxNUw=;
 b=UytOKSU25V/mND9SuCaT1Bj5gkX06L6hKHHZl1UIDUP8pHt9lgBk+xhgGMZO3Rsope
 gNvt4QbP5g9u4i1X5N7bt8EPn2QtfijqR6ihNW7LnRxi+Iak6wPuCUkP5fV0Xd8yRF7Q
 WEw9U8E6sn4pjDovalkOk0LE+PfE41aX/1hfapimcV9Z7waJ2Llv3tTvfG5huj7UjyQE
 4Ak5WiiJOD9m4NBLkJhuzd6lRbaWHNt5UqOlHKu4yAlYh9ESeJlxrKhXrC56G8BuWnQn
 UdSpt5AC4g/7c0r25L+bZMD20/mli4r8FuyI4WVwtI3kSL7FpB5aUrU6vG4dTUl2GWsv
 23Mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HyBZPX25hIZTsN6yRZngYgo4XKdszTDKKaSv++EleqqqujHZ9L1KD0tSHa9OIcDlXY37pkIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YznRVXUKF99N2GgCHzpwEbDFBEGD0TyyY+5yGzVX5kf6i4CzuRL
 bBO6n40Cu0bpmL3HtvYOETeAIhnwVu9oMSsW0KGYNwPIYFnThTikJlgt
X-Gm-Gg: AeBDievYfGuT2FAsDRcwuyumsV2WgqwUrQI4BACa30/e1Rma21GYc3KifCwKSSW9eWo
 D5P/FQU55mkMJ0tTi9DNQz72wsohHNPgQHUIByvhmUtMN6GC6pATuvSSnJErZD1jPsZfUgO+gyQ
 woMHKZF+DEtPPLZmhRkw19v7rpAuOzCoPtwDYTarpWMFuw6x8Wg9pANH9YI2hsjeoSMQ6lmNCRv
 ShXlgNcgGBYJAGpTN/pV/9/m0Vfia1TwPLXhppQ5Wrjg6qcDjQXUOYr7G4hq5D5t0fGB67WVOBc
 VMC75OQjVvXEBkaSGrv6SvmPw8MUmMcwyIg4oARJwIOp1XKob4UmGWdD2E2HJq0YZEWfvyJrkf0
 r/hwbY7tihOm7n5nWYcVHNwVwzWmzKHVaFI3fLyh1YgQzY0aumuvjxc8Uem6IWI8kUiwAeJlgS5
 JH+F6gtzj7cXVMX/Iz0PN3UEXX6AiGBOUowx+rARb70tyJplhvgsKSIQR0gtcIMQ==
X-Received: by 2002:a17:907:9626:b0:b97:9524:d6d0 with SMTP id
 a640c23a62f3a-bc5670676e0mr213570566b.0.1778179100495; 
 Thu, 07 May 2026 11:38:20 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bca53ddda1bsm18111866b.11.2026.05.07.11.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 11:38:20 -0700 (PDT)
Message-ID: <6249d635-512c-4e66-893a-dcc5834cae86@gmail.com>
Date: Thu, 7 May 2026 20:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/5] rockchip: Remove rk3368-sheep board
To: kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, andy.yan@rock-chips.com, u-boot@lists.denx.de,
 quentin.schulz@cherry.de
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
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

Remove rk3368-sheep board due lack of upstream support.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
removal in a separate patch
remove README links
---
 arch/arm/dts/Makefile                   |   1 -
 arch/arm/dts/rk3368-sheep-u-boot.dtsi   |  35 ---
 arch/arm/dts/rk3368-sheep.dts           | 286 ------------------------
 arch/arm/mach-rockchip/rk3368/Kconfig   |   7 -
 board/geekbuying/geekbox/README         |   1 -
 board/rockchip/evb_px5/README           |   1 -
 board/rockchip/sheep_rk3368/Kconfig     |  12 -
 board/rockchip/sheep_rk3368/MAINTAINERS |   6 -
 board/rockchip/sheep_rk3368/README      |  44 ----
 configs/sheep-rk3368_defconfig          |  32 ---
 doc/board/rockchip/rockchip.rst         |   1 -
 include/configs/sheep_rk3368.h          |  15 --
 12 files changed, 441 deletions(-)
 delete mode 100644 arch/arm/dts/rk3368-sheep-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3368-sheep.dts
 delete mode 100644 board/geekbuying/geekbox/README
 delete mode 100644 board/rockchip/evb_px5/README
 delete mode 100644 board/rockchip/sheep_rk3368/Kconfig
 delete mode 100644 board/rockchip/sheep_rk3368/MAINTAINERS
 delete mode 100644 board/rockchip/sheep_rk3368/README
 delete mode 100644 configs/sheep-rk3368_defconfig
 delete mode 100644 include/configs/sheep_rk3368.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7b2847804835..39ab188c5435 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -53,7 +53,6 @@ dtb-$(CONFIG_MACH_S700) += \
 	s700-cubieboard7.dtb

 dtb-$(CONFIG_ROCKCHIP_RK3368) += \
-	rk3368-sheep.dtb \
 	rk3368-geekbox.dtb \
 	rk3368-px5-evb.dtb \

diff --git a/arch/arm/dts/rk3368-sheep-u-boot.dtsi b/arch/arm/dts/rk3368-sheep-u-boot.dtsi
deleted file mode 100644
index cfc8b9340a8f..000000000000
--- a/arch/arm/dts/rk3368-sheep-u-boot.dtsi
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
- */
-
-#include "rk3368-u-boot.dtsi"
-
-&pinctrl {
-	bootph-all;
-};
-
-&service_msch {
-	bootph-all;
-};
-
-&dmc {
-	bootph-all;
-	status = "okay";
-};
-
-&pmugrf {
-	bootph-all;
-};
-
-&cru {
-	bootph-all;
-};
-
-&grf {
-	bootph-all;
-};
-
-&uart2 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/rk3368-sheep.dts b/arch/arm/dts/rk3368-sheep.dts
deleted file mode 100644
index 120dec1a3de9..000000000000
--- a/arch/arm/dts/rk3368-sheep.dts
+++ /dev/null
@@ -1,286 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2017 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-#include "rk3368.dtsi"
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Rockchip sheep board";
-	compatible = "rockchip,sheep", "rockchip,rk3368";
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	ext_gmac: gmac-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-		#clock-cells = <0>;
-	};
-
-	ir: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ir_int>;
-	};
-
-	keys: gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwr_key>;
-
-		power {
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
-			label = "GPIO Power";
-			linux,code = <KEY_POWER>;
-			wakeup-source;
-		};
-	};
-
-	leds: gpio-leds {
-		compatible = "gpio-leds";
-
-		blue {
-			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
-			label = "geekbox:blue:led";
-			default-state = "on";
-		};
-
-		red {
-			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
-			label = "geekbox:red:led";
-			default-state = "off";
-		};
-	};
-
-	vcc_sys: vcc-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&emmc {
-	status = "okay";
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	clock-frequency = <150000000>;
-	disable-wp;
-	keep-power-in-suspend;
-	non-removable;
-	num-slots = <1>;
-	vmmc-supply = <&vcc_io>;
-	vqmmc-supply = <&vcc18_flash>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
-};
-
-&gmac {
-	status = "okay";
-	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	clock_in_out = "input";
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-};
-
-&i2c0 {
-	status = "okay";
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>, <&pmic_sleep>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
-		rockchip,system-power-controller;
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
-		vcc8-supply = <&vcc_io>;
-		vcc9-supply = <&vcc_sys>;
-		vcc10-supply = <&vcc_sys>;
-		vcc11-supply = <&vcc_sys>;
-		vcc12-supply = <&vcc_io>;
-		clock-output-names = "xin32k", "rk808-clkout2";
-		#clock-cells = <1>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-name = "vdd_cpu";
-			};
-
-			vdd_log: DCDC_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-name = "vdd_log";
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_ddr";
-			};
-
-			vcc_io: DCDC_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_io";
-			};
-
-			vcc18_flash: LDO_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc18_flash";
-			};
-
-			vcc33_lcd: LDO_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc33_lcd";
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd_10";
-			};
-
-			vcca_18: LDO_REG4 {
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcca_18";
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vccio_sd";
-			};
-
-			vdd10_lcd: LDO_REG6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd10_lcd";
-			};
-
-			vcc_18: LDO_REG7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_18";
-			};
-
-			vcc18_lcd: LDO_REG8 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc18_lcd";
-			};
-
-			vcc_sd: SWITCH_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_sd";
-			};
-
-			vcc_lan: SWITCH_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_lan";
-			};
-		};
-	};
-};
-
-&pinctrl {
-	ir {
-		ir_int: ir-int {
-			rockchip,pins = <3 30 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	keys {
-		pwr_key: pwr-key {
-			rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		pmic_sleep: pmic-sleep {
-			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-		};
-
-		pmic_int: pmic-int {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
-
-&saradc {
-	status = "okay";
-};
-
-&tsadc {
-	status = "okay";
-	rockchip,hw-tshut-mode = <0>; /* CRU */
-	rockchip,hw-tshut-polarity = <1>; /* high */
-};
-
-&uart4 {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig b/arch/arm/mach-rockchip/rk3368/Kconfig
index a7be30bbd897..4c28d26d4607 100644
--- a/arch/arm/mach-rockchip/rk3368/Kconfig
+++ b/arch/arm/mach-rockchip/rk3368/Kconfig
@@ -3,12 +3,6 @@ if ROCKCHIP_RK3368
 choice
 	prompt "RK3368 board"

-config TARGET_SHEEP
-	bool "Sheep board"
-	help
-	  Sheep board is designed by Rockchip as a EVB board
-	  for rk3368.
-
 config TARGET_GEEKBOX
 	bool "GeekBox"

@@ -41,7 +35,6 @@ config SPL_LIBCOMMON_SUPPORT
 config SPL_LIBGENERIC_SUPPORT
 	default y

-source "board/rockchip/sheep_rk3368/Kconfig"
 source "board/geekbuying/geekbox/Kconfig"
 source "board/rockchip/evb_px5/Kconfig"

diff --git a/board/geekbuying/geekbox/README b/board/geekbuying/geekbox/README
deleted file mode 100644
index de980f2f2337..000000000000
--- a/board/geekbuying/geekbox/README
+++ /dev/null
@@ -1 +0,0 @@
-see board/rockchip/sheep_rk3368/README
diff --git a/board/rockchip/evb_px5/README b/board/rockchip/evb_px5/README
deleted file mode 100644
index de980f2f2337..000000000000
--- a/board/rockchip/evb_px5/README
+++ /dev/null
@@ -1 +0,0 @@
-see board/rockchip/sheep_rk3368/README
diff --git a/board/rockchip/sheep_rk3368/Kconfig b/board/rockchip/sheep_rk3368/Kconfig
deleted file mode 100644
index 321bf814859a..000000000000
--- a/board/rockchip/sheep_rk3368/Kconfig
+++ /dev/null
@@ -1,12 +0,0 @@
-if TARGET_SHEEP
-
-config SYS_BOARD
-	default "sheep_rk3368"
-
-config SYS_VENDOR
-	default "rockchip"
-
-config SYS_CONFIG_NAME
-	default "sheep_rk3368"
-
-endif
diff --git a/board/rockchip/sheep_rk3368/MAINTAINERS b/board/rockchip/sheep_rk3368/MAINTAINERS
deleted file mode 100644
index cd5de9923e02..000000000000
--- a/board/rockchip/sheep_rk3368/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-RK3368 Sheep Board
-M:	Andy Yan <andy.yan@rock-chips.com>
-S:	Maintained
-F:	board/rockchip/sheep_rk3368
-F:	include/configs/sheep_rk3368.h
-F:	configs/sheep-rk3368_defconfig
diff --git a/board/rockchip/sheep_rk3368/README b/board/rockchip/sheep_rk3368/README
deleted file mode 100644
index 2d078cbe5c09..000000000000
--- a/board/rockchip/sheep_rk3368/README
+++ /dev/null
@@ -1,44 +0,0 @@
-Here is the step-by-step to boot to U-Boot on rk3368.
-
-Get miniloader and trust.img form rockchip vendor u-boot source code
-==============================================================================
-  > git clone  https://github.com/rockchip-linux/u-boot.git rockchip-uboot
-  > cd rockchip-uboot
-  > make rk3368_defconfig /*chose px5_defconfig if you run a px5 platform here*/
-  > ./mkv8.sh
-
-Compile the upstream U-Boot
-===========================
-  > cd u-boot
-  > make CROSS_COMPILE=aarch64-linux-gnu- sheep-rk3368_defconfig  all
-
-Package u-boot for miniloader
-================================
-  > ../rockchip-uboot/tools/loaderimage --pack --uboot u-boot.bin u-boot.img
-
-Flash the image by rkdeveloptool
-================================
-rkdeveloptool can get from https://github.com/rockchip-linux/rkdeveloptool.git
-
-Power on(or reset with RESET KEY) with MASKROM KEY preesed, and then:
-  > rkdeveloptool db ./rockchip-uboot/rk3368_loader_v2.00.256.bin
-  > rkdeveloptool wl 0x6000 ./rockchip-uboot/trust.img
-  > rkdeveloptool wl 0x4000 ./u-boot/u-boot.img
-  > rkdeveloptool RD
-
-You should be able to get U-Boot log message from boot console:
-
-U-Boot 2017.05-rc3-01094-g9ddd1e8-dirty (May 15 2017 - 15:57:23 +0800)
-
-Model: Rockchip sheep board
-DRAM:  2 GiB
-MMC:   dwmmc@ff0f0000: 0
-Using default environment
-
-In:    serial@ff690000
-Out:   serial@ff690000
-Err:   serial@ff690000
-Net:   Net Initialization Skipped
-No ethernet found.
-Hit any key to stop autoboot:  0
-=>
diff --git a/configs/sheep-rk3368_defconfig b/configs/sheep-rk3368_defconfig
deleted file mode 100644
index bbaee0f147f8..000000000000
--- a/configs/sheep-rk3368_defconfig
+++ /dev/null
@@ -1,32 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=24000000
-CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_DEFAULT_DEVICE_TREE="rk3368-sheep"
-CONFIG_ROCKCHIP_RK3368=y
-CONFIG_SYS_LOAD_ADDR=0x800800
-CONFIG_DEBUG_UART_BASE=0xFF1b0000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_DEBUG_UART=y
-CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-sheep.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_CMD_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_CLK=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PINCTRL=y
-CONFIG_RAM=y
-CONFIG_DEBUG_UART_SHIFT=2
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SYSRESET=y
-CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 141071f528a3..f369f2a8376e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -76,7 +76,6 @@ List of mainline supported Rockchip boards:
 * rk3368
      - GeekBox (geekbox)
      - PX5 EVB (evb-px5)
-     - Rockchip Sheep (sheep-rk3368)
 * rk3399
      - 96boards RK3399 Ficus (ficus-rk3399)
      - 96boards Rock960 (rock960-rk3399)
diff --git a/include/configs/sheep_rk3368.h b/include/configs/sheep_rk3368.h
deleted file mode 100644
index 08cc4bf356d9..000000000000
--- a/include/configs/sheep_rk3368.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2017 Rockchip Electronics Co., Ltd
- */
-
-#ifndef __CONFIGS_PX5_EVB_H
-#define __CONFIGS_PX5_EVB_H
-
-#include <configs/rk3368_common.h>
-
-#define KERNEL_LOAD_ADDR		0x280000
-#define DTB_LOAD_ADDR			0x5600000
-#define INITRD_LOAD_ADDR		0x5bf0000
-
-#endif
--
2.39.5

