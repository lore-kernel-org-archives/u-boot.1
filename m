Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03641D44D43
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 10:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9587E891E3;
	Wed,  6 Nov 2024 11:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QBWJ6hXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67475891E4; Wed,  6 Nov 2024 11:22:39 +0100 (CET)
Received: from mail-m10129.netease.com (mail-m10129.netease.com
 [154.81.10.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415DC891CF
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 11:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1f8011ef;
 Wed, 6 Nov 2024 18:22:32 +0800 (GMT+08:00)
Message-ID: <152e25d3-e717-4cf5-81cd-2b5419dd976c@rock-chips.com>
Date: Wed, 6 Nov 2024 18:22:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] rockchip: rk3288-tinker: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20241105160054.1373319-1-jonas@kwiboo.se>
 <20241105160054.1373319-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241105160054.1373319-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JIQ1ZJTx4fQ0JPQklCSE1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9300ff518a03afkunm1f8011ef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6MCo6STIaPDEpTg8WTAgJ
 IkkwCSNVSlVKTEhLQ0NDTk5IQkJMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSkhJSjcG
DKIM-Signature: a=rsa-sha256;
 b=QBWJ6hXZZ8Crw67t4G+d6J97Bje4AbPY9w53L7uf7/tRXVy9ICrily8wg6vFWEf+Z6hDa5CF0XWAQdKwQpG6m5r9qiKRewEI6uBkJZZqJR0FigsqmrFM8oEqT8Z9MGe3L3bBOoIzRxyP+3axr2FrIfwLIQzJBbRZDWTta8fElsw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=NHs8R1FWhVYRbxRKgEvaLg3DJqCIoZxfKzJ8zqaVCPM=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/11/6 00:00, Jonas Karlman wrote:
> The device tree for ASUS Tinker Board and S variant in dts/upstream can
> be used as-is by U-Boot, migrate board to OF_UPSTREAM.
>
> The change to use DT from dts/upstream will include minor changes and
> fixes related to leds and regulators.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/Makefile                    |   2 -
>   arch/arm/dts/rk3288-tinker-s.dts         |  29 --
>   arch/arm/dts/rk3288-tinker.dts           |  33 --
>   arch/arm/dts/rk3288-tinker.dtsi          | 533 -----------------------
>   board/rockchip/tinker_rk3288/MAINTAINERS |   5 +-
>   configs/tinker-rk3288_defconfig          |   6 +-
>   configs/tinker-s-rk3288_defconfig        |   6 +-
>   7 files changed, 9 insertions(+), 605 deletions(-)
>   delete mode 100644 arch/arm/dts/rk3288-tinker-s.dts
>   delete mode 100644 arch/arm/dts/rk3288-tinker.dts
>   delete mode 100644 arch/arm/dts/rk3288-tinker.dtsi
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index aeccfa93fc53..40f2f768fc69 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -74,8 +74,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3288) += \
>   	rk3288-popmetal.dtb \
>   	rk3288-rock2-square.dtb \
>   	rk3288-rock-pi-n8.dtb \
> -	rk3288-tinker.dtb \
> -	rk3288-tinker-s.dtb \
>   	rk3288-veyron-jerry.dtb \
>   	rk3288-veyron-mickey.dtb \
>   	rk3288-veyron-minnie.dtb \
> diff --git a/arch/arm/dts/rk3288-tinker-s.dts b/arch/arm/dts/rk3288-tinker-s.dts
> deleted file mode 100644
> index cc7ac5f8811c..000000000000
> --- a/arch/arm/dts/rk3288-tinker-s.dts
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> - */
> -
> -/dts-v1/;
> -
> -#include "rk3288-tinker.dtsi"
> -
> -/ {
> -	model = "Rockchip RK3288 Asus Tinker Board S";
> -	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
> -
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
> -&emmc {
> -	bus-width = <8>;
> -	cap-mmc-highspeed;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
> -	max-frequency = <150000000>;
> -	mmc-hs200-1_8v;
> -	mmc-ddr-1_8v;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3288-tinker.dts b/arch/arm/dts/rk3288-tinker.dts
> deleted file mode 100644
> index 8b1848c310ee..000000000000
> --- a/arch/arm/dts/rk3288-tinker.dts
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR X11
> -/*
> - * (C) Copyright 2016 Rockchip Electronics Co., Ltd
> - */
> -
> -/dts-v1/;
> -#include "rk3288-tinker.dtsi"
> -
> -/ {
> -	model = "Tinker-RK3288";
> -	compatible = "rockchip,rk3288-tinker", "rockchip,rk3288";
> -
> -	chosen {
> -		stdout-path = &uart2;
> -	};
> -};
> -
> -&pinctrl {
> -	usb {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&usb_host1 {
> -	vbus-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3288-tinker.dtsi b/arch/arm/dts/rk3288-tinker.dtsi
> deleted file mode 100644
> index 62b4beb25100..000000000000
> --- a/arch/arm/dts/rk3288-tinker.dtsi
> +++ /dev/null
> @@ -1,533 +0,0 @@
> -/*
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -#include <dt-bindings/input/input.h>
> -#include "rk3288.dtsi"
> -
> -/ {
> -	memory {
> -		device_type = "memory";
> -		reg = <0x0 0x0 0x0 0x80000000>;
> -	};
> -
> -	ext_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "ext_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwrbtn>;
> -
> -		button@0 {
> -			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
> -			label = "GPIO Key Power";
> -			linux,code = <KEY_POWER>;
> -			linux,input-type = <1>;
> -			gpio-key,wakeup = <1>;
> -			debounce-interval = <100>;
> -		};
> -	};
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -
> -		pwr-led {
> -			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "default-on";
> -		};
> -
> -		act-led {
> -			gpios=<&gpio2 3 GPIO_ACTIVE_LOW>;
> -			linux,default-trigger="mmc0";
> -		};
> -	};
> -
> -	vcc_sys: vsys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_sys";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	/*
> -	 * NOTE: vcc_sd isn't hooked up on v1.0 boards where power comes from
> -	 * vcc_io directly.  Those boards won't be able to power cycle SD cards
> -	 * but it shouldn't hurt to toggle this pin there anyway.
> -	 */
> -	vcc_sd: sdmmc-regulator {
> -		compatible = "regulator-fixed";
> -		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc_pwr>;
> -		regulator-name = "vcc_sd";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -
> -	vcc5v0_host: usb-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&host_vbus_drv>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -	};
> -};
> -
> -&cpu0 {
> -	cpu0-supply = <&vdd_cpu>;
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	card-detect-delay = <200>;
> -	disable-wp;			/* wp not hooked up */
> -	num-slots = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> -	status = "okay";
> -	supports-sd;
> -	vmmc-supply = <&vcc_sd>;
> -	vqmmc-supply = <&vccio_sd>;
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_gpu>;
> -	status = "okay";
> -};
> -
> -&gmac {
> -	phy-supply = <&vcc33_lan>;
> -	phy-mode = "rgmii";
> -	clock_in_out = "input";
> -	snps,reset-gpio = <&gpio4 7 0>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 1000000>;
> -	assigned-clocks = <&cru SCLK_MAC>;
> -	assigned-clock-parents = <&ext_gmac>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii_pins>;
> -	tx_delay = <0x30>;
> -	rx_delay = <0x10>;
> -	status = "okay";
> -};
> -
> -&hdmi {
> -	ddc-i2c-bus = <&i2c5>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	rk808: pmic@1b {
> -		compatible = "rockchip,rk808";
> -		reg = <0x1b>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int &global_pwroff>;
> -		rockchip,system-power-controller;
> -		wakeup-source;
> -		#clock-cells = <1>;
> -		clock-output-names = "xin32k", "rk808-clkout2";
> -
> -		vcc1-supply = <&vcc_sys>;
> -		vcc2-supply = <&vcc_sys>;
> -		vcc3-supply = <&vcc_sys>;
> -		vcc4-supply = <&vcc_sys>;
> -		vcc6-supply = <&vcc_sys>;
> -		vcc7-supply = <&vcc_sys>;
> -		vcc8-supply = <&vcc_18>;
> -		vcc9-supply = <&vcc_io>;
> -		vcc10-supply = <&vcc_io>;
> -		vcc11-supply = <&vcc_sys>;
> -		vcc12-supply = <&vcc_io>;
> -		vddio-supply = <&vcc18_ldo1>;
> -
> -		regulators {
> -			vdd_cpu: DCDC_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-name = "vdd_arm";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_gpu: DCDC_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <1250000>;
> -				regulator-name = "vdd_gpu";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc_ddr";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_io: DCDC_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_io";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc18_ldo1: LDO_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc18_ldo1";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc33_mipi: LDO_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc33_mipi";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_10: LDO_REG3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-name = "vdd_10";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc18_codec: LDO_REG4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc18_codec";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vccio_sd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vdd10_lcd: LDO_REG6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-name = "vdd10_lcd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc_18: LDO_REG7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_18";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc18_lcd: LDO_REG8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc18_lcd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcc33_sd: SWITCH_REG1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc33_sd";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc33_lan: SWITCH_REG2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vcc33_lan";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -	headset: nau8825@1a {
> -		compatible = "nuvoton,nau8825";
> -		#sound-dai-cells = <0>;
> -		reg = <0x1a>;
> -		interrupt-parent = <&gpio6>;
> -		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> -		nuvoton,jkdet-enable = <1>;
> -		nuvoton,jkdet-pull-enable = <1>;
> -		nuvoton,jkdet-pull-up = <0>;
> -		nuvoton,jkdet-polarity = <1>;
> -		nuvoton,vref-impedance = <2>;
> -		nuvoton,micbias-voltage = <6>;
> -		nuvoton,sar-threshold-num = <4>;
> -		nuvoton,sar-threshold = <0xa 0x14 0x26 0x73>;
> -		nuvoton,sar-hysteresis = <0>;
> -		nuvoton,sar-voltage = <6>;
> -		nuvoton,sar-compare-time = <0>;
> -		nuvoton,sar-sampling-time = <0>;
> -		nuvoton,short-key-debounce = <3>;
> -		nuvoton,jack-insert-debounce = <7>;
> -		nuvoton,jack-eject-debounce = <7>;
> -		clock-names = "mclk";
> -		clocks = <&cru SCLK_I2S0_OUT>;
> -	};
> -};
> -
> -&i2c5 {
> -	status = "okay";
> -};
> -
> -&wdt {
> -	status = "okay";
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc18_ldo1>;
> -	status ="okay";
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&uart3 {
> -	status = "okay";
> -};
> -
> -&uart4 {
> -	status = "okay";
> -};
> -
> -&tsadc {
> -	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
> -	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> -	status = "okay";
> -};
> -
> -&usbphy {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1 {
> -	status = "okay";
> -};
> -
> -&usb_otg {
> -	status= "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&vopl {
> -	status = "okay";
> -};
> -
> -&vopl_mmu {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
> -		drive-strength = <8>;
> -	};
> -
> -	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
> -		bias-pull-up;
> -		drive-strength = <8>;
> -	};
> -
> -	backlight {
> -		bl_en: bl-en {
> -			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	buttons {
> -		pwrbtn: pwrbtn {
> -			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	eth_phy {
> -		eth_phy_pwr: eth-phy-pwr {
> -			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		pmic_int: pmic-int {
> -			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	sdmmc {
> -		/*
> -		 * Default drive strength isn't enough to achieve even
> -		 * high-speed mode on EVB board so bump up to 8ma.
> -		 */
> -		sdmmc_bus4: sdmmc-bus4 {
> -			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> -					<6 17 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> -					<6 18 RK_FUNC_1 &pcfg_pull_up_drv_8ma>,
> -					<6 19 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> -		};
> -
> -		sdmmc_clk: sdmmc-clk {
> -			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_drv_8ma>;
> -		};
> -
> -		sdmmc_cmd: sdmmc-cmd {
> -			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_8ma>;
> -		};
> -
> -		sdmmc_pwr: sdmmc-pwr {
> -			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pwr_3g: pwr-3g {
> -			rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> diff --git a/board/rockchip/tinker_rk3288/MAINTAINERS b/board/rockchip/tinker_rk3288/MAINTAINERS
> index a5cae55d4286..ab1ce72a77b2 100644
> --- a/board/rockchip/tinker_rk3288/MAINTAINERS
> +++ b/board/rockchip/tinker_rk3288/MAINTAINERS
> @@ -2,10 +2,6 @@ TINKER-RK3288
>   M:	Lin Huang <hl@rock-chips.com>
>   R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> -F:	arch/arm/dts/rk3288-tinker.dts
> -F:	arch/arm/dts/rk3288-tinker.dtsi
> -F:	arch/arm/dts/rk3288-tinker-s.dts
> -F:	arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
>   F:	arch/arm/dts/rk3288-tinker-u-boot.dtsi
>   F:	board/rockchip/tinker_rk3288
>   F:	include/configs/tinker_rk3288.h
> @@ -15,6 +11,7 @@ TINKER-S-RK3288
>   M:	Michael Trimarchi <michael@amarulasolutions.com>
>   R:	Jonas Karlman <jonas@kwiboo.se>
>   S:	Maintained
> +F:	arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
>   F:	board/rockchip/tinker_rk3288
>   F:	include/configs/tinker_rk3288.h
>   F:	configs/tinker-s-rk3288_defconfig
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index 1007d9ca9e15..b7636fe581f4 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3288-tinker"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-tinker"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3288=y
>   CONFIG_TARGET_TINKER_RK3288=y
> @@ -17,7 +17,7 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_CMD_GPIO=y
> @@ -36,6 +36,8 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index 47d089ff4780..e50424746c81 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x01000000
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_SF_DEFAULT_SPEED=20000000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3288-tinker-s"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-tinker-s"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3288=y
>   CONFIG_TARGET_TINKER_RK3288=y
> @@ -17,7 +17,7 @@ CONFIG_DEBUG_UART_BASE=0xff690000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
> -CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker-s.dtb"
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_CMD_GPIO=y
> @@ -36,6 +36,8 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
