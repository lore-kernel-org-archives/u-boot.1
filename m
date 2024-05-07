Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ECAC25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 12:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E8C88753;
	Tue,  7 May 2024 14:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NmbT+9s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2735588734; Tue,  7 May 2024 09:20:12 +0200 (CEST)
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com
 [220.197.32.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838638872A
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NmbT+9s3eNLRo8VvvJI5/7y/QSTczRN5Oz+i1CwQrESkNjF5uAkCo1hSo9Cu9KWz5ni5i80EvwnNmNR6+sF3eb9Xk46fb3p8y1TV2U2w+6yFFWhKEH1bC3kkLiZGXoS7lzUuS+P2/PbE7ox51NhFGPV0iaq0vfrbP7iRFZqmMIM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=l2xr+CiMQmgDNSRKhG6n2xU0SnRPO4I7qSn10Uzf8GE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A9E7B90033D;
 Tue,  7 May 2024 15:19:52 +0800 (CST)
Message-ID: <a2d186e2-7f56-45c5-96a2-69c6d3d2ed02@rock-chips.com>
Date: Tue, 7 May 2024 15:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 16/16] rockchip: rk3588: Remove redundant device tree files
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-17-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20240504194346.2462489-17-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlKHVZMTk1NGEpDGR8ZGh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f51ec50d803a9kunma9e7b90033d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6OSo4FzNKNgsVFjowFSMt
 Ix9PCxRVSlVKTEpOS01NSEJIQ0lDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQk9NSU43Bg++
X-Mailman-Approved-At: Tue, 07 May 2024 14:27:34 +0200
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


On 2024/5/5 03:43, Jonas Karlman wrote:
> Remove redundant device tree files now that RK3588 boards have been
> migrated to use OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-coolpi-cm5-evb.dts        |  216 --
>   arch/arm/dts/rk3588-coolpi-cm5.dtsi           |  649 ----
>   arch/arm/dts/rk3588-edgeble-neu6a-io.dts      |   23 -
>   arch/arm/dts/rk3588-edgeble-neu6a.dtsi        |   31 -
>   arch/arm/dts/rk3588-edgeble-neu6b-io.dts      |   89 -
>   arch/arm/dts/rk3588-edgeble-neu6b.dtsi        |  389 --
>   arch/arm/dts/rk3588-evb1-v10.dts              | 1080 ------
>   arch/arm/dts/rk3588-jaguar.dts                |  803 ----
>   arch/arm/dts/rk3588-nanopc-t6.dts             |  916 -----
>   arch/arm/dts/rk3588-orangepi-5-plus.dts       |  847 ----
>   arch/arm/dts/rk3588-pinctrl.dtsi              |  516 ---
>   arch/arm/dts/rk3588-quartzpro64.dts           | 1137 ------
>   arch/arm/dts/rk3588-rock-5b.dts               |  776 ----
>   arch/arm/dts/rk3588-turing-rk1.dts            |   21 -
>   arch/arm/dts/rk3588-turing-rk1.dtsi           |  612 ---
>   arch/arm/dts/rk3588.dtsi                      |  341 --
>   arch/arm/dts/rk3588j.dtsi                     |    7 -
>   arch/arm/dts/rk3588s-coolpi-4b.dts            |  812 ----
>   arch/arm/dts/rk3588s-orangepi-5.dts           |  667 ----
>   arch/arm/dts/rk3588s-pinctrl.dtsi             | 3447 -----------------
>   arch/arm/dts/rk3588s-rock-5a.dts              |  744 ----
>   arch/arm/dts/rk3588s.dtsi                     | 2485 ------------
>   .../dt-bindings/clock/rockchip,rk3588-cru.h   |  766 ----
>   include/dt-bindings/power/rk3588-power.h      |   69 -
>   .../dt-bindings/reset/rockchip,rk3588-cru.h   |  754 ----
>   25 files changed, 18197 deletions(-)
>   delete mode 100644 arch/arm/dts/rk3588-coolpi-cm5-evb.dts
>   delete mode 100644 arch/arm/dts/rk3588-coolpi-cm5.dtsi
>   delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6a-io.dts
>   delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6a.dtsi
>   delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6b-io.dts
>   delete mode 100644 arch/arm/dts/rk3588-edgeble-neu6b.dtsi
>   delete mode 100644 arch/arm/dts/rk3588-evb1-v10.dts
>   delete mode 100644 arch/arm/dts/rk3588-jaguar.dts
>   delete mode 100644 arch/arm/dts/rk3588-nanopc-t6.dts
>   delete mode 100644 arch/arm/dts/rk3588-orangepi-5-plus.dts
>   delete mode 100644 arch/arm/dts/rk3588-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
>   delete mode 100644 arch/arm/dts/rk3588-rock-5b.dts
>   delete mode 100644 arch/arm/dts/rk3588-turing-rk1.dts
>   delete mode 100644 arch/arm/dts/rk3588-turing-rk1.dtsi
>   delete mode 100644 arch/arm/dts/rk3588.dtsi
>   delete mode 100644 arch/arm/dts/rk3588j.dtsi
>   delete mode 100644 arch/arm/dts/rk3588s-coolpi-4b.dts
>   delete mode 100644 arch/arm/dts/rk3588s-orangepi-5.dts
>   delete mode 100644 arch/arm/dts/rk3588s-pinctrl.dtsi
>   delete mode 100644 arch/arm/dts/rk3588s-rock-5a.dts
>   delete mode 100644 arch/arm/dts/rk3588s.dtsi
>   delete mode 100644 include/dt-bindings/clock/rockchip,rk3588-cru.h
>   delete mode 100644 include/dt-bindings/power/rk3588-power.h
>   delete mode 100644 include/dt-bindings/reset/rockchip,rk3588-cru.h
>
> diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb.dts b/arch/arm/dts/rk3588-coolpi-cm5-evb.dts
> deleted file mode 100644
> index a4946cdc3bb3..000000000000
> --- a/arch/arm/dts/rk3588-coolpi-cm5-evb.dts
> +++ /dev/null
> @@ -1,216 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/common.h>
> -#include "rk3588-coolpi-cm5.dtsi"
> -
> -/ {
> -	model = "RK3588 CoolPi CM5 EVB";
> -	compatible = "coolpi,pi-cm5-evb", "coolpi,pi-cm5", "rockchip,rk3588";
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bl_en>;
> -		power-supply = <&vcc12v_dcin>;
> -		pwms = <&pwm2 0 25000 0>;
> -	};
> -
> -	leds: leds {
> -		compatible = "gpio-leds";
> -
> -		green_led: led-0 {
> -			color = <LED_COLOR_ID_GREEN>;
> -			function = LED_FUNCTION_STATUS;
> -			gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc3v3_sys: vcc3v3-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc3v3_lcd: vcc3v3-lcd-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_lcd";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&lcdpwr_en>;
> -		vin-supply = <&vcc3v3_sys>;
> -	};
> -
> -	vcc5v0_usb_host1: vcc5v0_usb_host2: vcc5v0-usb-host-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		enable-active-high;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usb_host_pwren>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_usb30_otg: vcc5v0-usb30-otg-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_otg";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		enable-active-high;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&usb_otg_pwren>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -/* M.2 E-Key */
> -&pcie2x1l1 {
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreq &pcie_wake &pcie_rst &wifi_pwron &bt_pwron>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -/* Standard pcie */
> -&pcie3x2 {
> -	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -	status = "okay";
> -};
> -
> -/* M.2 M-Key ssd */
> -&pcie3x4 {
> -	num-lanes = <2>;
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	lcd {
> -		lcdpwr_en: lcdpwr-en {
> -			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		bl_en: bl-en {
> -			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		usb_host_pwren: usb-host-pwren {
> -			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		usb_otg_pwren: usb-otg-pwren {
> -			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	wifi {
> -		bt_pwron: bt-pwron {
> -			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		pcie_clkreq: pcie-clkreq {
> -			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		pcie_rst: pcie-rst {
> -			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		wifi_pwron: wifi-pwron {
> -			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		pcie_wake: pcie-wake {
> -			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&sata1 {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_usb_host1>;
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_usb_host2>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-coolpi-cm5.dtsi b/arch/arm/dts/rk3588-coolpi-cm5.dtsi
> deleted file mode 100644
> index 9cb6d566da6e..000000000000
> --- a/arch/arm/dts/rk3588-coolpi-cm5.dtsi
> +++ /dev/null
> @@ -1,649 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pwm/pwm.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	compatible = "coolpi,pi-cm5", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdio;
> -	};
> -
> -	analog-sound {
> -		compatible = "audio-graph-card";
> -		dais = <&i2s0_8ch_p0>;
> -		label = "rk3588-es8316";
> -		routing = "MIC2", "Mic Jack",
> -			  "Headphones", "HPOL",
> -			  "Headphones", "HPOR";
> -		widgets = "Microphone", "Mic Jack",
> -			  "Headphone", "Headphones";
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	avdd0v85_pcie20: avdd0v85-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd0v85_pcie20";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <850000>;
> -		regulator-max-microvolt = <850000>;
> -		vin-supply = <&vdd_0v85_s0>;
> -	};
> -
> -	avdd1v8_pcie20: avdd1v8-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd1v8_pcie20";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	avdd0v75_pcie30: avdd0v75-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd0v75_pcie30";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <750000>;
> -		regulator-max-microvolt = <750000>;
> -		vin-supply = <&avdd_0v75_s0>;
> -	};
> -
> -	pcie30_avdd1v8: avdd1v8-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie30_avdd1v8";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac0 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-0 = <&gmac0_miim
> -		     &gmac0_tx_bus2
> -		     &gmac0_rx_bus2
> -		     &gmac0_rgmii_clk
> -		     &gmac0_rgmii_bus>;
> -	pinctrl-names = "default";
> -	rx_delay = <0x00>;
> -	tx_delay = <0x43>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	pinctrl-0 = <&i2c7m0_xfer>;
> -	status = "okay";
> -
> -	es8316: audio-codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_8ch_p0_0>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -
> -	i2s0_8ch_p0: port {
> -		i2s0_8ch_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&mdio0 {
> -	rgmii_phy: ethernet-phy@1 {
> -		/* YT8531C/H */
> -		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&yt8531_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -/* ethernet */
> -&pcie2x1l2 {
> -	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_sys>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&yt6801_isolate>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	yt6801 {
> -		yt6801_isolate: yt6801-isolate {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	yt8531 {
> -		yt8531_rst: yt8531-rst {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	max-frequency = <200000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_2v0_pldo_s3>;
> -		vcc14-supply = <&vcc_2v0_pldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_log_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vdd2_ddr_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_2v0_pldo_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_3v3_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vddq_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "avcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-name = "avdd_1v2_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_sd_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "pldo6_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_ddr_pll_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "avdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_0v85_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io.dts b/arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> deleted file mode 100644
> index be6a4f4f90f6..000000000000
> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
> - */
> -
> -/dts-v1/;
> -#include "rk3588.dtsi"
> -#include "rk3588-edgeble-neu6a.dtsi"
> -
> -/ {
> -	model = "Edgeble Neu6A IO Board";
> -	compatible = "edgeble,neural-compute-module-6a-io",
> -		     "edgeble,neural-compute-module-6a", "rockchip,rk3588";
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> deleted file mode 100644
> index 727580aaa105..000000000000
> --- a/arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
> - */
> -
> -/ {
> -	compatible = "edgeble,neural-compute-module-6a", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io.dts b/arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> deleted file mode 100644
> index 070baeb63431..000000000000
> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> - */
> -
> -/dts-v1/;
> -#include "rk3588j.dtsi"
> -#include "rk3588-edgeble-neu6b.dtsi"
> -
> -/ {
> -	model = "Edgeble Neu6B IO Board";
> -	compatible = "edgeble,neural-compute-module-6a-io",
> -		     "edgeble,neural-compute-module-6b", "rockchip,rk3588";
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&i2c6 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		wakeup-source;
> -	};
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -/* FAN */
> -&pwm2 {
> -	pinctrl-0 = <&pwm2m1_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&sata0 {
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -/* RS232 */
> -&uart6 {
> -	pinctrl-0 = <&uart6m0_xfer>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -/* RS485 */
> -&uart7 {
> -	pinctrl-0 = <&uart7m2_xfer>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> deleted file mode 100644
> index 017559bba37f..000000000000
> --- a/arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> +++ /dev/null
> @@ -1,389 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
> - */
> -
> -/ {
> -	compatible = "edgeble,neural-compute-module-6b", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		spi-max-frequency = <1000000>;
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-init-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588-evb1-v10.dts b/arch/arm/dts/rk3588-evb1-v10.dts
> deleted file mode 100644
> index ac7c677b0fb9..000000000000
> --- a/arch/arm/dts/rk3588-evb1-v10.dts
> +++ /dev/null
> @@ -1,1080 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "Rockchip RK3588 EVB1 V10 Board";
> -	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> -
> -	aliases {
> -		ethernet0 = &gmac0;
> -		mmc0 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-vol-up {
> -			label = "Volume Up";
> -			linux,code = <KEY_VOLUMEUP>;
> -			press-threshold-microvolt = <17000>;
> -		};
> -
> -		button-vol-down {
> -			label = "Volume Down";
> -			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <417000>;
> -		};
> -
> -		button-menu {
> -			label = "Menu";
> -			linux,code = <KEY_MENU>;
> -			press-threshold-microvolt = <890000>;
> -		};
> -
> -		button-escape {
> -			label = "Escape";
> -			linux,code = <KEY_ESC>;
> -			press-threshold-microvolt = <1235000>;
> -		};
> -	};
> -
> -	analog-sound {
> -		compatible = "simple-audio-card";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_detect>;
> -		simple-audio-card,name = "RK3588 EVB1 Audio";
> -		simple-audio-card,aux-devs = <&amp_headphone>, <&amp_speaker>;
> -		simple-audio-card,bitclock-master = <&masterdai>;
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,frame-master = <&masterdai>;
> -		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,pin-switches = "Headphones", "Speaker";
> -		simple-audio-card,routing =
> -			"Speaker Amplifier INL", "LOUT2",
> -			"Speaker Amplifier INR", "ROUT2",
> -			"Speaker", "Speaker Amplifier OUTL",
> -			"Speaker", "Speaker Amplifier OUTR",
> -			"Headphones Amplifier INL", "LOUT1",
> -			"Headphones Amplifier INR", "ROUT1",
> -			"Headphones", "Headphones Amplifier OUTL",
> -			"Headphones", "Headphones Amplifier OUTR",
> -			"LINPUT1", "Onboard Microphone",
> -			"RINPUT1", "Onboard Microphone",
> -			"LINPUT2", "Microphone Jack",
> -			"RINPUT2", "Microphone Jack";
> -		simple-audio-card,widgets =
> -			"Microphone", "Microphone Jack",
> -			"Microphone", "Onboard Microphone",
> -			"Headphone", "Headphones",
> -			"Speaker", "Speaker";
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s0_8ch>;
> -		};
> -
> -		masterdai: simple-audio-card,codec {
> -			sound-dai = <&es8388>;
> -			system-clock-frequency = <12288000>;
> -		};
> -	};
> -
> -	amp_headphone: headphone-amplifier {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&headphone_amplifier_en>;
> -		sound-name-prefix = "Headphones Amplifier";
> -	};
> -
> -	amp_speaker: speaker-amplifier {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&speaker_amplifier_en>;
> -		sound-name-prefix = "Speaker Amplifier";
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		power-supply = <&vcc12v_dcin>;
> -		pwms = <&pwm2 0 25000 0>;
> -	};
> -
> -	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie20_avdd0v85";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <850000>;
> -		regulator-max-microvolt = <850000>;
> -		vin-supply = <&avdd_0v85_s0>;
> -	};
> -
> -	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie20_avdd1v8";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie30_avdd0v75";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <750000>;
> -		regulator-max-microvolt = <750000>;
> -		vin-supply = <&avdd_0v75_s0>;
> -	};
> -
> -	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie30_avdd1v8";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		enable-active-high;
> -		gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> -		startup-delay-us = <5000>;
> -		vin-supply = <&vcc12v_dcin>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc3v3_pcie30_en>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		vin-supply = <&vcc5v0_usb>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usbdcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usbdcin>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac0 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-0 = <&gmac0_miim
> -		     &gmac0_tx_bus2
> -		     &gmac0_rx_bus2
> -		     &gmac0_rgmii_clk
> -		     &gmac0_rgmii_bus>;
> -	pinctrl-names = "default";
> -	rx_delay = <0x00>;
> -	tx_delay = <0x43>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	es8388: audio-codec@11 {
> -		compatible = "everest,es8388";
> -		reg = <0x11>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		AVDD-supply = <&avcc_1v8_codec_s0>;
> -		DVDD-supply = <&avcc_1v8_codec_s0>;
> -		HPVDD-supply = <&vcc_3v3_s0>;
> -		PVDD-supply = <&vcc_3v3_s0>;
> -		#sound-dai-cells = <0>;
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -};
> -
> -&mdio0 {
> -	rgmii_phy: ethernet-phy@1 {
> -		/* RTL8211F */
> -		compatible = "ethernet-phy-id001c.c916";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtl8211f_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pcie2x1l1 {
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_reset>;
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	audio {
> -		hp_detect: headphone-detect {
> -			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		headphone_amplifier_en: headphone-amplifier-en {
> -			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		speaker_amplifier_en: speaker-amplifier-en {
> -			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	rtl8111 {
> -		rtl8111_isolate: rtl8111-isolate {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	rtl8211f {
> -		rtl8211f_rst: rtl8211f-rst {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pcie2 {
> -		pcie2_1_rst: pcie2-1-rst {
> -			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie3 {
> -		pcie3_reset: pcie3-reset {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc3v3_pcie30_en: vcc3v3-pcie30-en {
> -			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <2>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		pinctrl-names = "default";
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc5v0_sys>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -
> -		regulators {
> -			vdd_gpu_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_npu_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_npu_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_log_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vdd_gpu_mem_s0: dcdc-reg5 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-name = "vdd_gpu_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vdd_npu_mem_s0: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_npu_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vdd_vdenc_mem_s0: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v1_nldo_s3: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1100000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_1v1_nldo_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1100000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd1_1v8_ddr_s3: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd1_1v8_ddr_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_codec_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avcc_1v8_codec_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s3: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_sd_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_1v8_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_1v8_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd2l_0v9_ddr_s3: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-name = "vdd2l_0v9_ddr_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vdd_0v75_hdmi_edp_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_hdmi_edp_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	pmic@1 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x01>;
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-0 = <&rk806_slave_dvs1_null>, <&rk806_slave_dvs2_null>,
> -			    <&rk806_slave_dvs3_null>;
> -		pinctrl-names = "default";
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_2v0_pldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_slave_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_slave_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_slave_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_cpu_big1_s0: dcdc-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_big1_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_big0_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_big0_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_big1_mem_s0: dcdc-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_big1_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -
> -			vdd_cpu_big0_mem_s0: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_big0_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_mem_s0: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_mem_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_cam_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_1v8_cam_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd1v8_ddr_pll_s0: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avdd1v8_ddr_pll_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_1v8_pll_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_1v8_pll_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_sd_s0: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_sd_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v8_cam_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_2v8_cam_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "pldo6_s3";
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_pll_s0: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_0v75_pll_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_0v85_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avdd_0v85_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_1v2_cam_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avdd_1v2_cam_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_1v2_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&sata0 {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-jaguar.dts b/arch/arm/dts/rk3588-jaguar.dts
> deleted file mode 100644
> index 4ce70fb75a30..000000000000
> --- a/arch/arm/dts/rk3588-jaguar.dts
> +++ /dev/null
> @@ -1,803 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "Theobroma Systems RK3588-SBC Jaguar";
> -	compatible = "tsd,rk3588-jaguar", "rockchip,rk3588";
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 0>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		/* Can be controlled through SW2 but also GPIO1 on CP2102 on P20 */
> -		button-bios-disable {
> -			label = "BIOS_DISABLE";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <0>;
> -		};
> -	};
> -
> -	aliases {
> -		ethernet0 = &gmac0;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -		rtc0 = &rtc_twi;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	/* DCIN is 12-24V but standard is 12V */
> -	dc_12v: dc-12v-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "dc_12v";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	emmc_pwrseq: emmc-pwrseq {
> -		compatible = "mmc-pwrseq-emmc";
> -		pinctrl-0 = <&emmc_reset>;
> -		pinctrl-names = "default";
> -		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&led1_pin>;
> -		status = "okay";
> -
> -		/* LED1 on PCB */
> -		led-1 {
> -			gpios = <&gpio1 RK_PD4 GPIO_ACTIVE_HIGH>;
> -			function = LED_FUNCTION_HEARTBEAT;
> -			linux,default-trigger = "heartbeat";
> -			color = <LED_COLOR_ID_AMBER>;
> -		};
> -	};
> -
> -	pps {
> -		compatible = "pps-gpio";
> -		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc_1v2_s3: vcc-1v2-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v2_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1200000>;
> -		regulator-max-microvolt = <1200000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	/* Exposed on P14 and P15 */
> -	vcc_2v8_s3: vcc-2v8-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_2v8_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <2800000>;
> -		regulator-max-microvolt = <2800000>;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
> -	vcc_5v0_usb_a: vcc-5v0-usb-a-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_a_vcc";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -		gpio = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	vcc_5v0_usb_c1: vcc-5v0-usb-c1-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "5v_usbc1";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	vcc_5v0_usb_c2: vcc-5v0-usb-c2-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "5v_usbc2";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -		gpio = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	vcc3v3_mdot2: vcc3v3-mdot2-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_mdot2";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&dc_12v>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac0 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii";
> -	phy-supply = <&vcc_1v2_s3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&gmac0_miim
> -		     &gmac0_rx_bus2
> -		     &gmac0_tx_bus2
> -		     &gmac0_rgmii_clk
> -		     &gmac0_rgmii_bus
> -		     &eth0_pins
> -		     &eth_reset>;
> -	tx_delay = <0x10>;
> -	rx_delay = <0x10>;
> -	snps,reset-gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 10000 100000>;
> -
> -	status = "okay";
> -};
> -
> -&gpio1 {
> -	mdot2e-w-disable1-n-hog {
> -		gpios = <RK_PB1 GPIO_ACTIVE_LOW>;
> -		output-low;
> -		line-name = "m.2 E-key W_DISABLE1#";
> -		gpio-hog;
> -	};
> -};
> -
> -&gpio4 {
> -	mdot2e-w-disable2-n-hog {
> -		gpios = <RK_PC1 GPIO_ACTIVE_LOW>;
> -		output-low;
> -		line-name = "m.2 E-key W_DISABLE2#";
> -		gpio-hog;
> -	};
> -};
> -
> -&i2c0 {
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	fan@18 {
> -		compatible = "ti,amc6821";
> -		reg = <0x18>;
> -	};
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	rtc_twi: rtc@6f {
> -		compatible = "isil,isl1208";
> -		reg = <0x6f>;
> -	};
> -};
> -
> -&i2c1 {
> -	pinctrl-0 = <&i2c1m4_xfer>;
> -};
> -
> -&i2c6 {
> -	pinctrl-0 = <&i2c6m4_xfer>;
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	/* SE050 Secure Element at 0x48; GPIO1_A4 for enable pin */
> -
> -	/* Also on 0x55 */
> -	eeprom@54 {
> -		compatible = "st,24c04", "atmel,24c04";
> -		reg = <0x54>;
> -		pagesize = <16>;
> -		vcc-supply = <&vcc_3v3_s3>;
> -	};
> -};
> -
> -&i2c8 {
> -	pinctrl-0 = <&i2c8m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&mdio0 {
> -	rgmii_phy: ethernet-phy@6 {
> -		/* KSZ9031 or KSZ9131 */
> -		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <0x6>;
> -		clocks = <&cru REFCLKO25M_ETH0_OUT>;
> -	};
> -};
> -
> -&pcie2x1l0 {
> -	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>; /* WIFI_PERST0# */
> -	vpcie3v3-supply = <&vcc3v3_mdot2>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	emmc {
> -		emmc_reset: emmc-reset {
> -			rockchip,pins = <2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	ethernet {
> -		eth_reset: eth-reset {
> -			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		led1_pin: led1-pin {
> -			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	mmc-pwrseq = <&emmc_pwrseq>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
> -	supports-cqe;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vcc_1v8_s3>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	broken-cd;
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cmd &sdmmc_clk>;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-ddr50;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -		system-power-controller;
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vcca_1v8_s0: pldo-reg1 {
> -				regulator-name = "vcca_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdda_1v2_s0: pldo-reg3 {
> -				regulator-name = "vdda_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcca_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcca_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdda_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdda_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdda_0v75_s0: nldo-reg3 {
> -				regulator-name = "vdda_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdda_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdda_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc_5v0_usb_a>;
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	status = "okay";
> -};
> -
> -/* Mule-ATtiny debug UART; typically baudrate 9600 */
> -&uart0 {
> -	pinctrl-0 = <&uart0m0_xfer>;
> -	status = "okay";
> -};
> -
> -/* Main debug interface on P20 micro-USB B port and P21 header */
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -/* RS485 on P19 */
> -&uart3 {
> -	pinctrl-0 = <&uart3m2_xfer &uart3_rtsn>;
> -	linux,rs485-enabled-at-boot-time;
> -	status = "okay";
> -};
> -
> -/* Mule-ATtiny UPDI flashing UART */
> -&uart7 {
> -	pinctrl-0 = <&uart7m0_xfer>;
> -	status = "okay";
> -};
> -
> -/* host0 on P10 USB-A */
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -/* host0 on P10 USB-A */
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -/* host1 on M.2 E-key */
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -/* host1 on M.2 E-key */
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-nanopc-t6.dts b/arch/arm/dts/rk3588-nanopc-t6.dts
> deleted file mode 100644
> index d7722772ecd8..000000000000
> --- a/arch/arm/dts/rk3588-nanopc-t6.dts
> +++ /dev/null
> @@ -1,916 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - * Copyright (c) 2023 Thomas McKahan
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "FriendlyElec NanoPC-T6";
> -	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		sys_led: led-0 {
> -			gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> -			label = "system-led";
> -			linux,default-trigger = "heartbeat";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sys_led_pin>;
> -		};
> -
> -		usr_led: led-1 {
> -			gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> -			label = "user-led";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&usr_led_pin>;
> -		};
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_det>;
> -
> -		simple-audio-card,name = "realtek,rt5616-codec";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -
> -		simple-audio-card,hp-det-gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_LOW>;
> -		simple-audio-card,hp-pin-name = "Headphones";
> -
> -		simple-audio-card,widgets =
> -			"Headphone", "Headphones",
> -			"Microphone", "Microphone Jack";
> -		simple-audio-card,routing =
> -			"Headphones", "HPOL",
> -			"Headphones", "HPOR",
> -			"MIC1", "Microphone Jack",
> -			"Microphone Jack", "micbias1";
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s0_8ch>;
> -		};
> -		simple-audio-card,codec {
> -			sound-dai = <&rt5616>;
> -		};
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	/* vcc5v0_sys powers peripherals */
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	/* vcc4v0_sys powers the RK806, RK860's */
> -	vcc4v0_sys: vcc4v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc4v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <4000000>;
> -		regulator-max-microvolt = <4000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc-1v1-nldo-s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc4v0_sys>;
> -	};
> -
> -	vcc_3v3_pcie20: vcc3v3-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_3v3_pcie20";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
> -	vbus5v0_typec: vbus5v0-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&typec5v_pwren>;
> -		regulator-name = "vbus5v0_typec";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_m2_1_pwren>;
> -		regulator-name = "vcc3v3_pcie2x1l0";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie_m2_0_pwren>;
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_b0{
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1{
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2{
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3{
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&gpio0 {
> -	gpio-line-names = /* GPIO0 A0-A7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO0 B0-B7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO0 C0-C7 */
> -			  "", "", "", "",
> -			  "HEADER_10", "HEADER_08", "HEADER_32", "",
> -			  /* GPIO0 D0-D7 */
> -			  "", "", "", "",
> -			  "", "", "", "";
> -};
> -
> -&gpio1 {
> -	gpio-line-names = /* GPIO1 A0-A7 */
> -			  "HEADER_27", "HEADER_28", "", "",
> -			  "", "", "", "HEADER_15",
> -			  /* GPIO1 B0-B7 */
> -			  "HEADER_26", "HEADER_21", "HEADER_19", "HEADER_23",
> -			  "HEADER_24", "HEADER_22", "", "",
> -			  /* GPIO1 C0-C7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO1 D0-D7 */
> -			  "", "", "", "",
> -			  "", "", "HEADER_05", "HEADER_03";
> -};
> -
> -&gpio2 {
> -	gpio-line-names = /* GPIO2 A0-A7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO2 B0-B7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO2 C0-C7 */
> -			  "", "CSI1_11", "CSI1_12", "",
> -			  "", "", "", "",
> -			  /* GPIO2 D0-D7 */
> -			  "", "", "", "",
> -			  "", "", "", "";
> -};
> -
> -&gpio3 {
> -	gpio-line-names = /* GPIO3 A0-A7 */
> -			  "HEADER_35", "HEADER_38", "HEADER_40", "HEADER_36",
> -			  "HEADER_37", "", "DSI0_12", "",
> -			  /* GPIO3 B0-B7 */
> -			  "HEADER_33", "DSI0_10", "HEADER_07", "HEADER_16",
> -			  "HEADER_18", "HEADER_29", "HEADER_31", "HEADER_12",
> -			  /* GPIO3 C0-C7 */
> -			  "DSI0_08", "DSI0_14", "HEADER_11", "HEADER_13",
> -			  "", "", "", "",
> -			  /* GPIO3 D0-D7 */
> -			  "", "", "", "",
> -			  "", "DSI1_10", "", "";
> -};
> -
> -&gpio4 {
> -	gpio-line-names = /* GPIO4 A0-A7 */
> -			  "DSI1_08", "DSI1_14", "", "DSI1_12",
> -			  "", "", "", "",
> -			  /* GPIO4 B0-B7 */
> -			  "", "", "", "",
> -			  "", "", "", "",
> -			  /* GPIO4 C0-C7 */
> -			  "", "", "", "",
> -			  "CSI0_11", "CSI0_12", "", "",
> -			  /* GPIO4 D0-D7 */
> -			  "", "", "", "",
> -			  "", "", "", "";
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc4v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc4v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		rockchip,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc4v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	clock-frequency = <200000>;
> -	status = "okay";
> -
> -	fusb302: typec-portc@22 {
> -		compatible = "fcs,fusb302";
> -		reg = <0x22>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-0 = <&usbc0_int>;
> -		pinctrl-names = "default";
> -		vbus-supply = <&vbus5v0_typec>;
> -
> -		connector {
> -			compatible = "usb-c-connector";
> -			data-role = "dual";
> -			label = "USB-C";
> -			power-role = "dual";
> -			try-power-role = "sink";
> -			source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
> -			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> -			op-sink-microwatt = <1000000>;
> -		};
> -	};
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	clock-frequency = <200000>;
> -	status = "okay";
> -
> -	rt5616: codec@1b {
> -		compatible = "realtek,rt5616";
> -		reg = <0x1b>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -
> -		port {
> -			rt5616_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_8ch_p0_0>;
> -			};
> -		};
> -	};
> -
> -	/* connected with MIPI-CSI1 */
> -};
> -
> -&i2c8 {
> -	pinctrl-0 = <&i2c8m2_xfer>;
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -
> -	i2s0_8ch_p0: port {
> -		i2s0_8ch_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&rt5616_p0_0>;
> -		};
> -	};
> -};
> -
> -&pcie2x1l0 {
> -	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc_3v3_pcie20>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_0_rst>;
> -	status = "okay";
> -};
> -
> -&pcie2x1l1 {
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_1_rst>;
> -	status = "okay";
> -};
> -
> -&pcie2x1l2 {
> -	reset-gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc_3v3_pcie20>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_2_rst>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	gpio-leds {
> -		sys_led_pin: sys-led-pin {
> -			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		usr_led_pin: usr-led-pin {
> -			rockchip,pins = <2 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	headphone {
> -		hp_det: hp-det {
> -			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pcie {
> -		pcie2_0_rst: pcie2-0-rst {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie2_1_rst: pcie2-1-rst {
> -			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie2_2_rst: pcie2-2-rst {
> -			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie_m2_0_pwren: pcie-m20-pwren {
> -			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie_m2_1_pwren: pcie-m21-pwren {
> -			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		typec5v_pwren: typec5v-pwren {
> -			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		usbc0_int: usbc0-int {
> -			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	pinctrl-0 = <&pwm1m1_pins>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&avcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	max-frequency = <200000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	no-mmc;
> -	no-sdio;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	num-cs = <1>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		spi-max-frequency = <1000000>;
> -		reg = <0x0>;
> -
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -
> -		system-power-controller;
> -
> -		vcc1-supply = <&vcc4v0_sys>;
> -		vcc2-supply = <&vcc4v0_sys>;
> -		vcc3-supply = <&vcc4v0_sys>;
> -		vcc4-supply = <&vcc4v0_sys>;
> -		vcc5-supply = <&vcc4v0_sys>;
> -		vcc6-supply = <&vcc4v0_sys>;
> -		vcc7-supply = <&vcc4v0_sys>;
> -		vcc8-supply = <&vcc4v0_sys>;
> -		vcc9-supply = <&vcc4v0_sys>;
> -		vcc10-supply = <&vcc4v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc4v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc4v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_log_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-init-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vdd2_ddr_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_2v0_pldo_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_3v3_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vddq_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "avcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-name = "avdd_1v2_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_sd_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "pldo6_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_ddr_pll_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "avdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_0v85_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-orangepi-5-plus.dts b/arch/arm/dts/rk3588-orangepi-5-plus.dts
> deleted file mode 100644
> index 3e660ff6cd5f..000000000000
> --- a/arch/arm/dts/rk3588-orangepi-5-plus.dts
> +++ /dev/null
> @@ -1,847 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Ondřej Jirman <megi@xff.cz>
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "Xunlong Orange Pi 5 Plus";
> -	compatible = "xunlong,orangepi-5-plus", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	adc-keys-0 {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 0>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-maskrom {
> -			label = "Mask Rom";
> -			linux,code = <KEY_SETUP>;
> -			press-threshold-microvolt = <2000>;
> -		};
> -	};
> -
> -	adc-keys-1 {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <2000>;
> -		};
> -	};
> -
> -	speaker_amp: speaker-audio-amplifier {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> -		sound-name-prefix = "Speaker Amp";
> -	};
> -
> -	headphone_amp: headphones-audio-amplifier {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
> -		sound-name-prefix = "Headphones Amp";
> -	};
> -
> -	ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ir_receiver_pin>;
> -	};
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&blue_led_pin>;
> -
> -		led {
> -			color = <LED_COLOR_ID_BLUE>;
> -			function = LED_FUNCTION_INDICATOR;
> -			function-enumerator = <1>;
> -			gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 70 75 80 100>;
> -		fan-supply = <&vcc5v0_sys>;
> -		pwms = <&pwm3 0 50000 0>;
> -		#cooling-cells = <2>;
> -	};
> -
> -	pwm-leds {
> -		compatible = "pwm-leds";
> -
> -		led {
> -			color = <LED_COLOR_ID_GREEN>;
> -			function = LED_FUNCTION_INDICATOR;
> -			function-enumerator = <2>;
> -			max-brightness = <255>;
> -			pwms = <&pwm2 0 25000 0>;
> -		};
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_detect>;
> -		simple-audio-card,name = "Analog";
> -		simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
> -		simple-audio-card,bitclock-master = <&daicpu>;
> -		simple-audio-card,frame-master = <&daicpu>;
> -		/*TODO: SARADC_IN3 is used as MIC detection / key input */
> -
> -		simple-audio-card,widgets =
> -			"Microphone", "Onboard Microphone",
> -			"Microphone", "Microphone Jack",
> -			"Speaker", "Speaker",
> -			"Headphone", "Headphones";
> -
> -		simple-audio-card,routing =
> -			"Headphones", "LOUT1",
> -			"Headphones", "ROUT1",
> -			"Speaker", "LOUT2",
> -			"Speaker", "ROUT2",
> -
> -			"Headphones", "Headphones Amp OUTL",
> -			"Headphones", "Headphones Amp OUTR",
> -			"Headphones Amp INL", "LOUT1",
> -			"Headphones Amp INR", "ROUT1",
> -
> -			"Speaker", "Speaker Amp OUTL",
> -			"Speaker", "Speaker Amp OUTR",
> -			"Speaker Amp INL", "LOUT2",
> -			"Speaker Amp INR", "ROUT2",
> -
> -			/* single ended signal to LINPUT1 */
> -			"LINPUT1", "Microphone Jack",
> -			"RINPUT1", "Microphone Jack",
> -			/* differential signal */
> -			"LINPUT2", "Onboard Microphone",
> -			"RINPUT2", "Onboard Microphone";
> -
> -		daicpu: simple-audio-card,cpu {
> -			sound-dai = <&i2s0_8ch>;
> -			system-clock-frequency = <12288000>;
> -		};
> -
> -		daicodec: simple-audio-card,codec {
> -			sound-dai = <&es8388>;
> -			system-clock-frequency = <12288000>;
> -		};
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <5000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_pcie_eth: vcc3v3-pcie-eth-regulator {
> -		compatible = "regulator-fixed";
> -		gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
> -		regulator-name = "vcc3v3_pcie_eth";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_wf: vcc3v3-wf-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_wf";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc5v0_usb20: vcc5v0-usb20-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_usb20_en>;
> -		regulator-name = "vcc5v0_usb20";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	clock-frequency = <400000>;
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	/* PLDO2 vcca 1.8V, BUCK8 gated by PLDO2 being enabled */
> -	es8388: audio-codec@11 {
> -		compatible = "everest,es8388";
> -		reg = <0x11>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		AVDD-supply = <&vcc_1v8_s0>;
> -		DVDD-supply = <&vcc_1v8_s0>;
> -		HPVDD-supply = <&vcc_3v3_s0>;
> -		PVDD-supply = <&vcc_3v3_s0>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		#sound-dai-cells = <0>;
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -};
> -
> -&i2s2_2ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s2m0_lrck
> -		     &i2s2m0_sclk
> -		     &i2s2m0_sdi
> -		     &i2s2m0_sdo>;
> -	status = "okay";
> -};
> -
> -/* phy1 - M.KEY socket */
> -&pcie2x1l0 {
> -	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_wf>;
> -	status = "okay";
> -};
> -
> -/* phy2 - right ethernet port */
> -&pcie2x1l1 {
> -	reset-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie_eth>;
> -	status = "okay";
> -};
> -
> -/* phy0 - left ethernet port */
> -&pcie2x1l2 {
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie_eth>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		blue_led_pin: blue-led {
> -			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir-receiver {
> -		ir_receiver_pin: ir-receiver-pin {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sound {
> -		hp_detect: hp-detect {
> -			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_usb20_en: vcc5v0-usb20-en {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	pinctrl-0 = <&pwm2m1_pins>;
> -	pinctrl-names = "default";
> -	status = "okay";
> -};
> -
> -&pwm3 {
> -	pinctrl-0 = <&pwm3m1_pins>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	max-frequency = <200000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&sfc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&fspim1_pins>;
> -	status = "okay";
> -
> -	spi_flash: flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0x0>;
> -		spi-max-frequency = <100000000>;
> -		spi-rx-bus-width = <4>;
> -		spi-tx-bus-width = <1>;
> -	};
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vdd2_ddr_s3>;
> -		vcc14-supply = <&vdd2_ddr_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <825000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <825000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			/* shorted to avcc_1v8_s0 on the board */
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				/*
> -				 * The schematic mentions that actual setting
> -				 * should be 0.8375V. RK3588 datasheet specifies
> -				 * maximum as 0.825V. So we set datasheet max
> -				 * here.
> -				 */
> -				regulator-min-microvolt = <825000>;
> -				regulator-max-microvolt = <825000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_usb20>;
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_usb20>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&uart9 {
> -	pinctrl-0 = <&uart9m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-pinctrl.dtsi b/arch/arm/dts/rk3588-pinctrl.dtsi
> deleted file mode 100644
> index 244c66faa161..000000000000
> --- a/arch/arm/dts/rk3588-pinctrl.dtsi
> +++ /dev/null
> @@ -1,516 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - */
> -
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rockchip-pinconf.dtsi"
> -
> -/*
> - * This file is auto generated by pin2dts tool, please keep these code
> - * by adding changes at end of this file.
> - */
> -&pinctrl {
> -	clk32k {
> -		/omit-if-no-ref/
> -		clk32k_out1: clk32k-out1 {
> -			rockchip,pins =
> -				/* clk32k_out1 */
> -				<2 RK_PC5 1 &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	eth0 {
> -		/omit-if-no-ref/
> -		eth0_pins: eth0-pins {
> -			rockchip,pins =
> -				/* eth0_refclko_25m */
> -				<2 RK_PC3 1 &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	fspi {
> -		/omit-if-no-ref/
> -		fspim1_pins: fspim1-pins {
> -			rockchip,pins =
> -				/* fspi_clk_m1 */
> -				<2 RK_PB3 3 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_cs0n_m1 */
> -				<2 RK_PB4 3 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d0_m1 */
> -				<2 RK_PA6 3 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d1_m1 */
> -				<2 RK_PA7 3 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d2_m1 */
> -				<2 RK_PB0 3 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d3_m1 */
> -				<2 RK_PB1 3 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		fspim1_cs1: fspim1-cs1 {
> -			rockchip,pins =
> -				/* fspi_cs1n_m1 */
> -				<2 RK_PB5 3 &pcfg_pull_up_drv_level_2>;
> -		};
> -	};
> -
> -	gmac0 {
> -		/omit-if-no-ref/
> -		gmac0_miim: gmac0-miim {
> -			rockchip,pins =
> -				/* gmac0_mdc */
> -				<4 RK_PC4 1 &pcfg_pull_none>,
> -				/* gmac0_mdio */
> -				<4 RK_PC5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_clkinout: gmac0-clkinout {
> -			rockchip,pins =
> -				/* gmac0_mclkinout */
> -				<4 RK_PC3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_rx_bus2: gmac0-rx-bus2 {
> -			rockchip,pins =
> -				/* gmac0_rxd0 */
> -				<2 RK_PC1 1 &pcfg_pull_none>,
> -				/* gmac0_rxd1 */
> -				<2 RK_PC2 1 &pcfg_pull_none>,
> -				/* gmac0_rxdv_crs */
> -				<4 RK_PC2 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_tx_bus2: gmac0-tx-bus2 {
> -			rockchip,pins =
> -				/* gmac0_txd0 */
> -				<2 RK_PB6 1 &pcfg_pull_none>,
> -				/* gmac0_txd1 */
> -				<2 RK_PB7 1 &pcfg_pull_none>,
> -				/* gmac0_txen */
> -				<2 RK_PC0 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_rgmii_clk: gmac0-rgmii-clk {
> -			rockchip,pins =
> -				/* gmac0_rxclk */
> -				<2 RK_PB0 1 &pcfg_pull_none>,
> -				/* gmac0_txclk */
> -				<2 RK_PB3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_rgmii_bus: gmac0-rgmii-bus {
> -			rockchip,pins =
> -				/* gmac0_rxd2 */
> -				<2 RK_PA6 1 &pcfg_pull_none>,
> -				/* gmac0_rxd3 */
> -				<2 RK_PA7 1 &pcfg_pull_none>,
> -				/* gmac0_txd2 */
> -				<2 RK_PB1 1 &pcfg_pull_none>,
> -				/* gmac0_txd3 */
> -				<2 RK_PB2 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_ppsclk: gmac0-ppsclk {
> -			rockchip,pins =
> -				/* gmac0_ppsclk */
> -				<2 RK_PC4 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_ppstring: gmac0-ppstring {
> -			rockchip,pins =
> -				/* gmac0_ppstring */
> -				<2 RK_PB5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_ptp_refclk: gmac0-ptp-refclk {
> -			rockchip,pins =
> -				/* gmac0_ptp_refclk */
> -				<2 RK_PB4 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac0_txer: gmac0-txer {
> -			rockchip,pins =
> -				/* gmac0_txer */
> -				<4 RK_PC6 1 &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	hdmi {
> -		/omit-if-no-ref/
> -		hdmim0_tx1_cec: hdmim0-tx1-cec {
> -			rockchip,pins =
> -				/* hdmim0_tx1_cec */
> -				<2 RK_PC4 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx1_scl: hdmim0-tx1-scl {
> -			rockchip,pins =
> -				/* hdmim0_tx1_scl */
> -				<2 RK_PB5 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx1_sda: hdmim0-tx1-sda {
> -			rockchip,pins =
> -				/* hdmim0_tx1_sda */
> -				<2 RK_PB4 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	i2c0 {
> -		/omit-if-no-ref/
> -		i2c0m1_xfer: i2c0m1-xfer {
> -			rockchip,pins =
> -				/* i2c0_scl_m1 */
> -				<4 RK_PC5 9 &pcfg_pull_none_smt>,
> -				/* i2c0_sda_m1 */
> -				<4 RK_PC6 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c2 {
> -		/omit-if-no-ref/
> -		i2c2m1_xfer: i2c2m1-xfer {
> -			rockchip,pins =
> -				/* i2c2_scl_m1 */
> -				<2 RK_PC1 9 &pcfg_pull_none_smt>,
> -				/* i2c2_sda_m1 */
> -				<2 RK_PC0 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c3 {
> -		/omit-if-no-ref/
> -		i2c3m3_xfer: i2c3m3-xfer {
> -			rockchip,pins =
> -				/* i2c3_scl_m3 */
> -				<2 RK_PB2 9 &pcfg_pull_none_smt>,
> -				/* i2c3_sda_m3 */
> -				<2 RK_PB3 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c4 {
> -		/omit-if-no-ref/
> -		i2c4m1_xfer: i2c4m1-xfer {
> -			rockchip,pins =
> -				/* i2c4_scl_m1 */
> -				<2 RK_PB5 9 &pcfg_pull_none_smt>,
> -				/* i2c4_sda_m1 */
> -				<2 RK_PB4 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c5 {
> -		/omit-if-no-ref/
> -		i2c5m4_xfer: i2c5m4-xfer {
> -			rockchip,pins =
> -				/* i2c5_scl_m4 */
> -				<2 RK_PB6 9 &pcfg_pull_none_smt>,
> -				/* i2c5_sda_m4 */
> -				<2 RK_PB7 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c6 {
> -		/omit-if-no-ref/
> -		i2c6m2_xfer: i2c6m2-xfer {
> -			rockchip,pins =
> -				/* i2c6_scl_m2 */
> -				<2 RK_PC3 9 &pcfg_pull_none_smt>,
> -				/* i2c6_sda_m2 */
> -				<2 RK_PC2 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c7 {
> -		/omit-if-no-ref/
> -		i2c7m1_xfer: i2c7m1-xfer {
> -			rockchip,pins =
> -				/* i2c7_scl_m1 */
> -				<4 RK_PC3 9 &pcfg_pull_none_smt>,
> -				/* i2c7_sda_m1 */
> -				<4 RK_PC4 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c8 {
> -		/omit-if-no-ref/
> -		i2c8m1_xfer: i2c8m1-xfer {
> -			rockchip,pins =
> -				/* i2c8_scl_m1 */
> -				<2 RK_PB0 9 &pcfg_pull_none_smt>,
> -				/* i2c8_sda_m1 */
> -				<2 RK_PB1 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2s2 {
> -		/omit-if-no-ref/
> -		i2s2m0_lrck: i2s2m0-lrck {
> -			rockchip,pins =
> -				/* i2s2m0_lrck */
> -				<2 RK_PC0 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_mclk: i2s2m0-mclk {
> -			rockchip,pins =
> -				/* i2s2m0_mclk */
> -				<2 RK_PB6 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sclk: i2s2m0-sclk {
> -			rockchip,pins =
> -				/* i2s2m0_sclk */
> -				<2 RK_PB7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sdi: i2s2m0-sdi {
> -			rockchip,pins =
> -				/* i2s2m0_sdi */
> -				<2 RK_PC3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sdo: i2s2m0-sdo {
> -			rockchip,pins =
> -				/* i2s2m0_sdo */
> -				<4 RK_PC3 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm2 {
> -		/omit-if-no-ref/
> -		pwm2m2_pins: pwm2m2-pins {
> -			rockchip,pins =
> -				/* pwm2_m2 */
> -				<4 RK_PC2 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm4 {
> -		/omit-if-no-ref/
> -		pwm4m1_pins: pwm4m1-pins {
> -			rockchip,pins =
> -				/* pwm4_m1 */
> -				<4 RK_PC3 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm5 {
> -		/omit-if-no-ref/
> -		pwm5m2_pins: pwm5m2-pins {
> -			rockchip,pins =
> -				/* pwm5_m2 */
> -				<4 RK_PC4 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm6 {
> -		/omit-if-no-ref/
> -		pwm6m2_pins: pwm6m2-pins {
> -			rockchip,pins =
> -				/* pwm6_m2 */
> -				<4 RK_PC5 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm7 {
> -		/omit-if-no-ref/
> -		pwm7m3_pins: pwm7m3-pins {
> -			rockchip,pins =
> -				/* pwm7_ir_m3 */
> -				<4 RK_PC6 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdio {
> -		/omit-if-no-ref/
> -		sdiom0_pins: sdiom0-pins {
> -			rockchip,pins =
> -				/* sdio_clk_m0 */
> -				<2 RK_PB3 2 &pcfg_pull_none>,
> -				/* sdio_cmd_m0 */
> -				<2 RK_PB2 2 &pcfg_pull_none>,
> -				/* sdio_d0_m0 */
> -				<2 RK_PA6 2 &pcfg_pull_none>,
> -				/* sdio_d1_m0 */
> -				<2 RK_PA7 2 &pcfg_pull_none>,
> -				/* sdio_d2_m0 */
> -				<2 RK_PB0 2 &pcfg_pull_none>,
> -				/* sdio_d3_m0 */
> -				<2 RK_PB1 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	spi1 {
> -		/omit-if-no-ref/
> -		spi1m0_pins: spi1m0-pins {
> -			rockchip,pins =
> -				/* spi1_clk_m0 */
> -				<2 RK_PC0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_miso_m0 */
> -				<2 RK_PC1 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_mosi_m0 */
> -				<2 RK_PC2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m0_cs0: spi1m0-cs0 {
> -			rockchip,pins =
> -				/* spi1_cs0_m0 */
> -				<2 RK_PC3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m0_cs1: spi1m0-cs1 {
> -			rockchip,pins =
> -				/* spi1_cs1_m0 */
> -				<2 RK_PC4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	spi3 {
> -		/omit-if-no-ref/
> -		spi3m0_pins: spi3m0-pins {
> -			rockchip,pins =
> -				/* spi3_clk_m0 */
> -				<4 RK_PC6 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_miso_m0 */
> -				<4 RK_PC4 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_mosi_m0 */
> -				<4 RK_PC5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m0_cs0: spi3m0-cs0 {
> -			rockchip,pins =
> -				/* spi3_cs0_m0 */
> -				<4 RK_PC2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m0_cs1: spi3m0-cs1 {
> -			rockchip,pins =
> -				/* spi3_cs1_m0 */
> -				<4 RK_PC3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	uart1 {
> -		/omit-if-no-ref/
> -		uart1m0_xfer: uart1m0-xfer {
> -			rockchip,pins =
> -				/* uart1_rx_m0 */
> -				<2 RK_PB6 10 &pcfg_pull_up>,
> -				/* uart1_tx_m0 */
> -				<2 RK_PB7 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m0_ctsn: uart1m0-ctsn {
> -			rockchip,pins =
> -				/* uart1m0_ctsn */
> -				<2 RK_PC1 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m0_rtsn: uart1m0-rtsn {
> -			rockchip,pins =
> -				/* uart1m0_rtsn */
> -				<2 RK_PC0 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart6 {
> -		/omit-if-no-ref/
> -		uart6m0_xfer: uart6m0-xfer {
> -			rockchip,pins =
> -				/* uart6_rx_m0 */
> -				<2 RK_PA6 10 &pcfg_pull_up>,
> -				/* uart6_tx_m0 */
> -				<2 RK_PA7 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart6m0_ctsn: uart6m0-ctsn {
> -			rockchip,pins =
> -				/* uart6m0_ctsn */
> -				<2 RK_PB1 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart6m0_rtsn: uart6m0-rtsn {
> -			rockchip,pins =
> -				/* uart6m0_rtsn */
> -				<2 RK_PB0 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart7 {
> -		/omit-if-no-ref/
> -		uart7m0_xfer: uart7m0-xfer {
> -			rockchip,pins =
> -				/* uart7_rx_m0 */
> -				<2 RK_PB4 10 &pcfg_pull_up>,
> -				/* uart7_tx_m0 */
> -				<2 RK_PB5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart7m0_ctsn: uart7m0-ctsn {
> -			rockchip,pins =
> -				/* uart7m0_ctsn */
> -				<4 RK_PC6 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart7m0_rtsn: uart7m0-rtsn {
> -			rockchip,pins =
> -				/* uart7m0_rtsn */
> -				<4 RK_PC2 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart9 {
> -		/omit-if-no-ref/
> -		uart9m0_xfer: uart9m0-xfer {
> -			rockchip,pins =
> -				/* uart9_rx_m0 */
> -				<2 RK_PC4 10 &pcfg_pull_up>,
> -				/* uart9_tx_m0 */
> -				<2 RK_PC2 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m0_ctsn: uart9m0-ctsn {
> -			rockchip,pins =
> -				/* uart9m0_ctsn */
> -				<4 RK_PC5 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m0_rtsn: uart9m0-rtsn {
> -			rockchip,pins =
> -				/* uart9m0_rtsn */
> -				<4 RK_PC4 10 &pcfg_pull_none>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588-quartzpro64.dts b/arch/arm/dts/rk3588-quartzpro64.dts
> deleted file mode 100644
> index 87a0abf95f7d..000000000000
> --- a/arch/arm/dts/rk3588-quartzpro64.dts
> +++ /dev/null
> @@ -1,1137 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Ondřej Jirman <megi@xff.cz>
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/usb/pd.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "PINE64 QuartzPro64";
> -	compatible = "pine64,quartzpro64", "rockchip,rk3588";
> -
> -	aliases {
> -		ethernet0 = &gmac0;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	adc-keys-0 {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 0>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-maskrom {
> -			label = "Mask Rom";
> -			linux,code = <KEY_SETUP>;
> -			press-threshold-microvolt = <393>;
> -		};
> -	};
> -
> -	adc-keys-1 {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-volume-up {
> -			label = "V+/REC";
> -			linux,code = <KEY_VOLUMEUP>;
> -			press-threshold-microvolt = <17821>;
> -		};
> -
> -		button-volume-down {
> -			label = "V-";
> -			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <415384>;
> -		};
> -
> -		button-menu {
> -			label = "MENU";
> -			linux,code = <KEY_MENU>;
> -			press-threshold-microvolt = <890909>;
> -		};
> -
> -		button-esc {
> -			label = "ESC";
> -			linux,code = <KEY_ESC>;
> -			press-threshold-microvolt = <1233962>;
> -		};
> -	};
> -
> -	headphone_amp: audio-amplifier-headphone {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		sound-name-prefix = "Headphones Amp";
> -	};
> -
> -	speaker_amp: audio-amplifier-speaker {
> -		compatible = "simple-audio-amplifier";
> -		enable-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
> -		sound-name-prefix = "Speaker Amp";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&led_pins>;
> -
> -		led-1 {
> -			color = <LED_COLOR_ID_ORANGE>;
> -			function = LED_FUNCTION_INDICATOR;
> -			gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_detect>;
> -		simple-audio-card,name = "Analog";
> -		simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
> -		simple-audio-card,bitclock-master = <&daicpu>;
> -		simple-audio-card,frame-master = <&daicpu>;
> -		/* SARADC_IN3 is used as MIC detection / key input */
> -
> -		simple-audio-card,widgets =
> -			"Microphone", "Onboard Microphone",
> -			"Microphone", "Microphone Jack",
> -			"Speaker", "Speaker",
> -			"Headphone", "Headphones";
> -
> -		simple-audio-card,routing =
> -			"Headphones", "LOUT1",
> -			"Headphones", "ROUT1",
> -			"Speaker", "LOUT2",
> -			"Speaker", "ROUT2",
> -
> -			"Headphones", "Headphones Amp OUTL",
> -			"Headphones", "Headphones Amp OUTR",
> -			"Headphones Amp INL", "LOUT1",
> -			"Headphones Amp INR", "ROUT1",
> -
> -			"Speaker", "Speaker Amp OUTL",
> -			"Speaker", "Speaker Amp OUTR",
> -			"Speaker Amp INL", "LOUT2",
> -			"Speaker Amp INR", "ROUT2",
> -
> -			/* single ended signal to LINPUT1 */
> -			"LINPUT1", "Microphone Jack",
> -			"RINPUT1", "Microphone Jack",
> -			/* differential signal */
> -			"LINPUT2", "Onboard Microphone",
> -			"RINPUT2", "Onboard Microphone";
> -
> -		daicpu: simple-audio-card,cpu {
> -			sound-dai = <&i2s0_8ch>;
> -			system-clock-frequency = <12288000>;
> -		};
> -
> -		daicodec: simple-audio-card,codec {
> -			sound-dai = <&es8388>;
> -			system-clock-frequency = <12288000>;
> -		};
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc3v3_bt: vcc3v3-bt-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_bt";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc_3v3_s0>;
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <5000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc3v3_wf: vcc3v3-wf-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_wf";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc_3v3_s0>;
> -	};
> -
> -	vcc4v0_sys: vcc4v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc4v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <4000000>;
> -		regulator-max-microvolt = <4000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac0 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&gmac0_miim
> -		     &gmac0_tx_bus2
> -		     &gmac0_rx_bus2
> -		     &gmac0_rgmii_clk
> -		     &gmac0_rgmii_bus>;
> -	rx_delay = <0x00>;
> -	tx_delay = <0x43>;
> -	status = "okay";
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	es8388: audio-codec@11 {
> -		compatible = "everest,es8388";
> -		reg = <0x11>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		AVDD-supply = <&avcc_1v8_codec_s0>;
> -		DVDD-supply = <&avcc_1v8_codec_s0>;
> -		HPVDD-supply = <&vcc_3v3_s0>;
> -		PVDD-supply = <&vcc_3v3_s0>;
> -		#sound-dai-cells = <0>;
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -};
> -
> -&mdio0 {
> -	rgmii_phy: ethernet-phy@1 {
> -		/* RTL8211F */
> -		compatible = "ethernet-phy-id001c.c916";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtl8211f_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	leds {
> -		led_pins: led-pins {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	rtl8111 {
> -		rtl8111_isolate: rtl8111-isolate {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	rtl8211f {
> -		rtl8211f_rst: rtl8211f-rst {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	sound {
> -		hp_detect: hp-detect {
> -			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -/* WIFI */
> -&pcie2x1l0 {
> -	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_wf>;
> -	status = "okay";
> -};
> -
> -/* GMAC1 */
> -&pcie2x1l1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rtl8111_isolate>;
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sata0 {
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	max-frequency = <150000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <2>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		pinctrl-names = "default";
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc4v0_sys>;
> -		vcc2-supply = <&vcc4v0_sys>;
> -		vcc3-supply = <&vcc4v0_sys>;
> -		vcc4-supply = <&vcc4v0_sys>;
> -		vcc5-supply = <&vcc4v0_sys>;
> -		vcc6-supply = <&vcc4v0_sys>;
> -		vcc7-supply = <&vcc4v0_sys>;
> -		vcc8-supply = <&vcc4v0_sys>;
> -		vcc9-supply = <&vcc4v0_sys>;
> -		vcc10-supply = <&vcc4v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc4v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc4v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_npu_s0: dcdc-reg2 {
> -				regulator-name = "vdd_npu_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vdd_gpu_mem_s0: dcdc-reg5 {
> -				regulator-name = "vdd_gpu_mem_s0";
> -				regulator-boot-on;
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vdd_npu_mem_s0: dcdc-reg6 {
> -				regulator-name = "vdd_npu_mem_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vdd_vdenc_mem_s0: dcdc-reg8 {
> -				regulator-name = "vdd_vdenc_mem_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg9 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v1_nldo_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v1_nldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1100000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1100000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd1_1v8_ddr_s3: pldo-reg2 {
> -				regulator-name = "vdd1_1v8_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_codec_s0: pldo-reg3 {
> -				regulator-name = "avcc_1v8_codec_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s3: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: pldo-reg6 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			/* reserved for LPDDR5, unused? */
> -			vdd2l_0v9_ddr_s3: nldo-reg2 {
> -				regulator-name = "vdd2l_0v9_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <900000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <900000>;
> -				};
> -			};
> -
> -			vdd_0v75_hdmi_edp_s0: nldo-reg3 {
> -				regulator-name = "vdd_0v75_hdmi_edp_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg4 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -
> -	pmic@1 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x01>;
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-0 = <&rk806_slave_dvs1_null>, <&rk806_slave_dvs2_null>,
> -			    <&rk806_slave_dvs3_null>;
> -		pinctrl-names = "default";
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc4v0_sys>;
> -		vcc2-supply = <&vcc4v0_sys>;
> -		vcc3-supply = <&vcc4v0_sys>;
> -		vcc4-supply = <&vcc4v0_sys>;
> -		vcc5-supply = <&vcc4v0_sys>;
> -		vcc6-supply = <&vcc4v0_sys>;
> -		vcc7-supply = <&vcc4v0_sys>;
> -		vcc8-supply = <&vcc4v0_sys>;
> -		vcc9-supply = <&vcc4v0_sys>;
> -		vcc10-supply = <&vcc4v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc4v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_2v0_pldo_s3>;
> -		vcca-supply = <&vcc4v0_sys>;
> -
> -		rk806_slave_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_slave_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_slave_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_cpu_big1_s0: dcdc-reg1 {
> -				regulator-name = "vdd_cpu_big1_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_big0_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_big0_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: dcdc-reg3 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: dcdc-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_big1_mem_s0: dcdc-reg5 {
> -				regulator-name = "vdd_cpu_big1_mem_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -
> -			vdd_cpu_big0_mem_s0: dcdc-reg6 {
> -				regulator-name = "vdd_cpu_big0_mem_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <1050000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: dcdc-reg7 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_mem_s0: dcdc-reg8 {
> -				regulator-name = "vdd_cpu_lit_mem_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg10 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/* reserved, unused? */
> -			vcc_1v8_cam_s0: pldo-reg1 {
> -				regulator-name = "vcc_1v8_cam_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd1v8_ddr_pll_s0: pldo-reg2 {
> -				regulator-name = "avdd1v8_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_1v8_pll_s0: pldo-reg3 {
> -				regulator-name = "vdd_1v8_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/* reserved, unused? */
> -			vcc_3v3_sd_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/* reserved, unused? */
> -			vcc_2v8_cam_s0: pldo-reg5 {
> -				regulator-name = "vcc_2v8_cam_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/* unused */
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_pll_s0: nldo-reg1 {
> -				regulator-name = "vdd_0v75_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_0v85_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			/* reserved, unused */
> -			avdd_1v2_cam_s0: nldo-reg4 {
> -				regulator-name = "avdd_1v2_cam_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			avdd_1v2_s0: nldo-reg5 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-rock-5b.dts b/arch/arm/dts/rk3588-rock-5b.dts
> deleted file mode 100644
> index a0e303c3a1dc..000000000000
> --- a/arch/arm/dts/rk3588-rock-5b.dts
> +++ /dev/null
> @@ -1,776 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK 5 Model B";
> -	compatible = "radxa,rock-5b", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdio;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	analog-sound {
> -		compatible = "audio-graph-card";
> -		label = "rk3588-es8316";
> -
> -		widgets = "Microphone", "Mic Jack",
> -			  "Headphone", "Headphones";
> -
> -		routing = "MIC2", "Mic Jack",
> -			  "Headphones", "HPOL",
> -			  "Headphones", "HPOR";
> -
> -		dais = <&i2s0_8ch_p0>;
> -		hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hp_detect>;
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&led_rgb_b>;
> -
> -		led_rgb_b {
> -			function = LED_FUNCTION_STATUS;
> -			color = <LED_COLOR_ID_BLUE>;
> -			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 95 145 195 255>;
> -		fan-supply = <&vcc5v0_sys>;
> -		pwms = <&pwm1 0 50000 0>;
> -		#cooling-cells = <2>;
> -	};
> -
> -	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie2_0_vcc3v3_en>;
> -		regulator-name = "vcc3v3_pcie2x1l0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_pcie2x1l2";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <5000>;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pcie3_vcc3v3_en>;
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <5000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy1_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	es8316: audio-codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_8ch_p0_0>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -
> -	i2s0_8ch_p0: port {
> -		i2s0_8ch_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&pcie2x1l0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_0_rst>;
> -	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
> -	status = "okay";
> -};
> -
> -&pcie2x1l2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_2_rst>;
> -	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_rst>;
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	leds {
> -		led_rgb_b: led-rgb-b {
> -			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sound {
> -		hp_detect: hp-detect {
> -			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie2 {
> -		pcie2_0_rst: pcie2-0-rst {
> -			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
> -			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie2_2_rst: pcie2-2-rst {
> -			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie3 {
> -		pcie3_rst: pcie3-rst {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&avcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	max-frequency = <200000000>;
> -	no-sdio;
> -	no-mmc;
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&sdio {
> -	max-frequency = <200000000>;
> -	no-sd;
> -	no-mmc;
> -	non-removable;
> -	bus-width = <4>;
> -	cap-sdio-irq;
> -	disable-wp;
> -	keep-power-in-suspend;
> -	wakeup-source;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc3v3_pcie2x1l0>;
> -	vqmmc-supply = <&vcc_1v8_s3>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdiom0_pins>;
> -	status = "okay";
> -};
> -
> -&uart6 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	num-cs = <1>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		spi-max-frequency = <1000000>;
> -		reg = <0x0>;
> -
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -
> -		system-power-controller;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_log_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vdd2_ddr_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_2v0_pldo_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_3v3_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vddq_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "avcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-name = "avdd_1v2_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_sd_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "pldo6_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_ddr_pll_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "avdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_0v85_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	/* connected to USB hub, which is powered by vcc5v0_sys */
> -	phy-supply = <&vcc5v0_sys>;
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host2_xhci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-turing-rk1.dts b/arch/arm/dts/rk3588-turing-rk1.dts
> deleted file mode 100644
> index 7bcad28d73b8..000000000000
> --- a/arch/arm/dts/rk3588-turing-rk1.dts
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * This device tree covers the common case where the RK1 is used as a
> - * "compute node" system, where the carrier board is functioning more like a
> - * generic backplane (with no non-autoenumerable peripherals of its own) than
> - * like a device that the SoM is meant to enable.
> - *
> - * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
> - */
> -
> -/dts-v1/;
> -#include "rk3588-turing-rk1.dtsi"
> -
> -/ {
> -	model = "Turing Machines RK1";
> -	compatible = "turing,rk1", "rockchip,rk3588";
> -
> -	chosen {
> -		stdout-path = "serial9:115200n8";
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588-turing-rk1.dtsi b/arch/arm/dts/rk3588-turing-rk1.dtsi
> deleted file mode 100644
> index dc08da518a76..000000000000
> --- a/arch/arm/dts/rk3588-turing-rk1.dtsi
> +++ /dev/null
> @@ -1,612 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Device tree definitions for the Turing RK1 SoM.
> - *
> - * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
> - *
> - * Based on RK3588-EVB1 devicetree
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	compatible = "turing,rk1", "rockchip,rk3588";
> -
> -	aliases {
> -		ethernet0 = &gmac1;
> -		mmc0 = &sdhci;
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 25 95 145 195 255>;
> -		fan-supply = <&vcc5v0_sys>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pwm0m2_pins &fan_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PA4 IRQ_TYPE_EDGE_FALLING>;
> -		pwms = <&pwm0 0 50000 0>;
> -		#cooling-cells = <2>;
> -	};
> -
> -	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v3_pcie30";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		enable-active-high;
> -		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc3v3_pcie30_en>;
> -		startup-delay-us = <5000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac1 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-0 = <&gmac1_miim
> -		     &gmac1_tx_bus2
> -		     &gmac1_rx_bus2
> -		     &gmac1_rgmii_clk
> -		     &gmac1_rgmii_bus>;
> -	pinctrl-names = "default";
> -	rx_delay = <0x00>;
> -	tx_delay = <0x43>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1m2_xfer>;
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&mdio1 {
> -	rgmii_phy: ethernet-phy@1 {
> -		/* RTL8211F */
> -		compatible = "ethernet-phy-id001c.c916",
> -			     "ethernet-phy-ieee802.3-c22";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtl8211f_rst>;
> -		reset-assert-us = <15000>;
> -		reset-deassert-us = <50000>;
> -		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pcie2x1l1 {
> -	linux,pci-domain = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_reset>;
> -	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> -	status = "okay";
> -};
> -
> -&pcie30phy {
> -	status = "okay";
> -};
> -
> -&pcie3x4 {
> -	linux,pci-domain = <0>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_reset>;
> -	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie30>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	fan {
> -		fan_int: fan-int {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	pcie2 {
> -		pcie2_reset: pcie2-reset {
> -			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie3 {
> -		pcie3_reset: pcie3-reset {
> -			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		vcc3v3_pcie30_en: pcie3-reg {
> -			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	rtl8211f {
> -		rtl8211f_rst: rtl8211f-rst {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	num-cs = <1>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		spi-max-frequency = <1000000>;
> -		reg = <0x0>;
> -
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_cpu_lit_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_log_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_vdenc_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vdd2_ddr_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vdd_2v0_pldo_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_3v3_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-name = "vddq_ddr_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "avcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "vcc_1v8_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-name = "avdd_1v2_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vcc_3v3_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-name = "vccio_sd_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-name = "pldo6_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s3";
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_ddr_pll_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "avdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -				regulator-name = "vdd_0v85_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-name = "vdd_0v75_s0";
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&uart9 {
> -	pinctrl-0 = <&uart9m0_xfer>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588.dtsi b/arch/arm/dts/rk3588.dtsi
> deleted file mode 100644
> index 5519c1430cb7..000000000000
> --- a/arch/arm/dts/rk3588.dtsi
> +++ /dev/null
> @@ -1,341 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - */
> -
> -#include "rk3588s.dtsi"
> -#include "rk3588-pinctrl.dtsi"
> -
> -/ {
> -	pcie30_phy_grf: syscon@fd5b8000 {
> -		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
> -		reg = <0x0 0xfd5b8000 0x0 0x10000>;
> -	};
> -
> -	pipe_phy1_grf: syscon@fd5c0000 {
> -		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
> -		reg = <0x0 0xfd5c0000 0x0 0x100>;
> -	};
> -
> -	i2s8_8ch: i2s@fddc8000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddc8000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S8_8CH_TX>, <&cru MCLK_I2S8_8CH_TX>, <&cru HCLK_I2S8_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S8_8CH_TX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 22>;
> -		dma-names = "tx";
> -		power-domains = <&power RK3588_PD_VO0>;
> -		resets = <&cru SRST_M_I2S8_8CH_TX>;
> -		reset-names = "tx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s6_8ch: i2s@fddf4000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddf4000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S6_8CH_TX>, <&cru MCLK_I2S6_8CH_TX>, <&cru HCLK_I2S6_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S6_8CH_TX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 4>;
> -		dma-names = "tx";
> -		power-domains = <&power RK3588_PD_VO1>;
> -		resets = <&cru SRST_M_I2S6_8CH_TX>;
> -		reset-names = "tx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s7_8ch: i2s@fddf8000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddf8000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S7_8CH_RX>, <&cru MCLK_I2S7_8CH_RX>, <&cru HCLK_I2S7_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S7_8CH_RX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 21>;
> -		dma-names = "rx";
> -		power-domains = <&power RK3588_PD_VO1>;
> -		resets = <&cru SRST_M_I2S7_8CH_RX>;
> -		reset-names = "rx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s10_8ch: i2s@fde00000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfde00000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S10_8CH_RX>, <&cru MCLK_I2S10_8CH_RX>, <&cru HCLK_I2S10_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S10_8CH_RX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 24>;
> -		dma-names = "rx";
> -		power-domains = <&power RK3588_PD_VO1>;
> -		resets = <&cru SRST_M_I2S10_8CH_RX>;
> -		reset-names = "rx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	pcie3x4: pcie@fe150000 {
> -		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		bus-range = <0x00 0x0f>;
> -		clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> -			 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> -			 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> -		clock-names = "aclk_mst", "aclk_slv",
> -			      "aclk_dbi", "pclk",
> -			      "aux", "pipe";
> -		device_type = "pci";
> -		interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie3x4_intc 0>,
> -				<0 0 0 2 &pcie3x4_intc 1>,
> -				<0 0 0 3 &pcie3x4_intc 2>,
> -				<0 0 0 4 &pcie3x4_intc 3>;
> -		linux,pci-domain = <0>;
> -		max-link-speed = <3>;
> -		msi-map = <0x0000 &its1 0x0000 0x1000>;
> -		num-lanes = <4>;
> -		phys = <&pcie30phy>;
> -		phy-names = "pcie-phy";
> -		power-domains = <&power RK3588_PD_PCIE>;
> -		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
> -			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
> -			 <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
> -		reg = <0xa 0x40000000 0x0 0x00400000>,
> -		      <0x0 0xfe150000 0x0 0x00010000>,
> -		      <0x0 0xf0000000 0x0 0x00100000>;
> -		reg-names = "dbi", "apb", "config";
> -		resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
> -		reset-names = "pwr", "pipe";
> -		status = "disabled";
> -
> -		pcie3x4_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 260 IRQ_TYPE_EDGE_RISING 0>;
> -		};
> -	};
> -
> -	pcie3x2: pcie@fe160000 {
> -		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		bus-range = <0x10 0x1f>;
> -		clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
> -			 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
> -			 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>;
> -		clock-names = "aclk_mst", "aclk_slv",
> -			      "aclk_dbi", "pclk",
> -			      "aux", "pipe";
> -		device_type = "pci";
> -		interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie3x2_intc 0>,
> -				<0 0 0 2 &pcie3x2_intc 1>,
> -				<0 0 0 3 &pcie3x2_intc 2>,
> -				<0 0 0 4 &pcie3x2_intc 3>;
> -		linux,pci-domain = <1>;
> -		max-link-speed = <3>;
> -		msi-map = <0x1000 &its1 0x1000 0x1000>;
> -		num-lanes = <2>;
> -		phys = <&pcie30phy>;
> -		phy-names = "pcie-phy";
> -		power-domains = <&power RK3588_PD_PCIE>;
> -		ranges = <0x01000000 0x0 0xf1100000 0x0 0xf1100000 0x0 0x00100000>,
> -			 <0x02000000 0x0 0xf1200000 0x0 0xf1200000 0x0 0x00e00000>,
> -			 <0x03000000 0x0 0x40000000 0x9 0x40000000 0x0 0x40000000>;
> -		reg = <0xa 0x40400000 0x0 0x00400000>,
> -		      <0x0 0xfe160000 0x0 0x00010000>,
> -		      <0x0 0xf1000000 0x0 0x00100000>;
> -		reg-names = "dbi", "apb", "config";
> -		resets = <&cru SRST_PCIE1_POWER_UP>, <&cru SRST_P_PCIE1>;
> -		reset-names = "pwr", "pipe";
> -		status = "disabled";
> -
> -		pcie3x2_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 255 IRQ_TYPE_EDGE_RISING 0>;
> -		};
> -	};
> -
> -	pcie2x1l0: pcie@fe170000 {
> -		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> -		bus-range = <0x20 0x2f>;
> -		clocks = <&cru ACLK_PCIE_1L0_MSTR>, <&cru ACLK_PCIE_1L0_SLV>,
> -			 <&cru ACLK_PCIE_1L0_DBI>, <&cru PCLK_PCIE_1L0>,
> -			 <&cru CLK_PCIE_AUX2>, <&cru CLK_PCIE1L0_PIPE>;
> -		clock-names = "aclk_mst", "aclk_slv",
> -			      "aclk_dbi", "pclk",
> -			      "aux", "pipe";
> -		device_type = "pci";
> -		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie2x1l0_intc 0>,
> -				<0 0 0 2 &pcie2x1l0_intc 1>,
> -				<0 0 0 3 &pcie2x1l0_intc 2>,
> -				<0 0 0 4 &pcie2x1l0_intc 3>;
> -		linux,pci-domain = <2>;
> -		max-link-speed = <2>;
> -		msi-map = <0x2000 &its0 0x2000 0x1000>;
> -		num-lanes = <1>;
> -		phys = <&combphy1_ps PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy";
> -		power-domains = <&power RK3588_PD_PCIE>;
> -		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
> -			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x00e00000>,
> -			 <0x03000000 0x0 0x40000000 0x9 0x80000000 0x0 0x40000000>;
> -		reg = <0xa 0x40800000 0x0 0x00400000>,
> -		      <0x0 0xfe170000 0x0 0x00010000>,
> -		      <0x0 0xf2000000 0x0 0x00100000>;
> -		reg-names = "dbi", "apb", "config";
> -		resets = <&cru SRST_PCIE2_POWER_UP>, <&cru SRST_P_PCIE2>;
> -		reset-names = "pwr", "pipe";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		status = "disabled";
> -
> -		pcie2x1l0_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 240 IRQ_TYPE_EDGE_RISING 0>;
> -		};
> -	};
> -
> -	gmac0: ethernet@fe1b0000 {
> -		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
> -		reg = <0x0 0xfe1b0000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "macirq", "eth_wake_irq";
> -		clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
> -			 <&cru PCLK_GMAC0>, <&cru ACLK_GMAC0>,
> -			 <&cru CLK_GMAC0_PTP_REF>;
> -		clock-names = "stmmaceth", "clk_mac_ref",
> -			      "pclk_mac", "aclk_mac",
> -			      "ptp_ref";
> -		power-domains = <&power RK3588_PD_GMAC>;
> -		resets = <&cru SRST_A_GMAC0>;
> -		reset-names = "stmmaceth";
> -		rockchip,grf = <&sys_grf>;
> -		rockchip,php-grf = <&php_grf>;
> -		snps,axi-config = <&gmac0_stmmac_axi_setup>;
> -		snps,mixed-burst;
> -		snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> -		snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> -		snps,tso;
> -		status = "disabled";
> -
> -		mdio0: mdio {
> -			compatible = "snps,dwmac-mdio";
> -			#address-cells = <0x1>;
> -			#size-cells = <0x0>;
> -		};
> -
> -		gmac0_stmmac_axi_setup: stmmac-axi-config {
> -			snps,blen = <0 0 0 0 16 8 4>;
> -			snps,wr_osr_lmt = <4>;
> -			snps,rd_osr_lmt = <8>;
> -		};
> -
> -		gmac0_mtl_rx_setup: rx-queues-config {
> -			snps,rx-queues-to-use = <2>;
> -			queue0 {};
> -			queue1 {};
> -		};
> -
> -		gmac0_mtl_tx_setup: tx-queues-config {
> -			snps,tx-queues-to-use = <2>;
> -			queue0 {};
> -			queue1 {};
> -		};
> -	};
> -
> -	sata1: sata@fe220000 {
> -		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
> -		reg = <0 0xfe220000 0 0x1000>;
> -		interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_SATA1>, <&cru CLK_PMALIVE1>,
> -			 <&cru CLK_RXOOB1>, <&cru CLK_PIPEPHY1_REF>,
> -			 <&cru CLK_PIPEPHY1_PIPE_ASIC_G>;
> -		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
> -		ports-implemented = <0x1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		sata-port@0 {
> -			reg = <0>;
> -			hba-port-cap = <HBA_PORT_FBSCP>;
> -			phys = <&combphy1_ps PHY_TYPE_SATA>;
> -			phy-names = "sata-phy";
> -			snps,rx-ts-max = <32>;
> -			snps,tx-ts-max = <32>;
> -		};
> -	};
> -
> -	combphy1_ps: phy@fee10000 {
> -		compatible = "rockchip,rk3588-naneng-combphy";
> -		reg = <0x0 0xfee10000 0x0 0x100>;
> -		clocks = <&cru CLK_REF_PIPE_PHY1>, <&cru PCLK_PCIE_COMBO_PIPE_PHY1>,
> -			 <&cru PCLK_PHP_ROOT>;
> -		clock-names = "ref", "apb", "pipe";
> -		assigned-clocks = <&cru CLK_REF_PIPE_PHY1>;
> -		assigned-clock-rates = <100000000>;
> -		#phy-cells = <1>;
> -		resets = <&cru SRST_REF_PIPE_PHY1>, <&cru SRST_P_PCIE2_PHY1>;
> -		reset-names = "phy", "apb";
> -		rockchip,pipe-grf = <&php_grf>;
> -		rockchip,pipe-phy-grf = <&pipe_phy1_grf>;
> -		status = "disabled";
> -	};
> -
> -	pcie30phy: phy@fee80000 {
> -		compatible = "rockchip,rk3588-pcie3-phy";
> -		reg = <0x0 0xfee80000 0x0 0x20000>;
> -		#phy-cells = <0>;
> -		clocks = <&cru PCLK_PCIE_COMBO_PIPE_PHY>;
> -		clock-names = "pclk";
> -		resets = <&cru SRST_PCIE30_PHY>;
> -		reset-names = "phy";
> -		rockchip,pipe-grf = <&php_grf>;
> -		rockchip,phy-grf = <&pcie30_phy_grf>;
> -		status = "disabled";
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588j.dtsi b/arch/arm/dts/rk3588j.dtsi
> deleted file mode 100644
> index 38b9dbf38a21..000000000000
> --- a/arch/arm/dts/rk3588j.dtsi
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> - *
> - */
> -
> -#include "rk3588.dtsi"
> diff --git a/arch/arm/dts/rk3588s-coolpi-4b.dts b/arch/arm/dts/rk3588s-coolpi-4b.dts
> deleted file mode 100644
> index e037bf9db75a..000000000000
> --- a/arch/arm/dts/rk3588s-coolpi-4b.dts
> +++ /dev/null
> @@ -1,812 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
> - *
> - * https://cool-pi.com/topic/130/coolpi-4b-product-spec-introduction
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588s.dtsi"
> -
> -/ {
> -	model = "RK3588S CoolPi 4 Model B";
> -	compatible = "coolpi,pi-4b", "rockchip,rk3588s";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -		mmc2 = &sdio;
> -	};
> -
> -	analog-sound {
> -		compatible = "audio-graph-card";
> -		dais = <&i2s0_8ch_p0>;
> -		label = "rk3588-es8316";
> -		routing = "MIC2", "Mic Jack",
> -			  "Headphones", "HPOL",
> -			  "Headphones", "HPOR";
> -		widgets = "Microphone", "Mic Jack",
> -			  "Headphone", "Headphones";
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	leds: leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpio_leds>;
> -
> -		led0: led-green {
> -			color = <LED_COLOR_ID_GREEN>;
> -			function = LED_FUNCTION_STATUS;
> -			gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		led1: led-red {
> -			color = <LED_COLOR_ID_RED>;
> -			default-state = "off";
> -			function = LED_FUNCTION_WLAN;
> -			gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0tx";
> -		};
> -	};
> -
> -	sdio_pwrseq: sdio-pwrseq {
> -		compatible = "mmc-pwrseq-simple";
> -		clocks = <&hym8563>;
> -		clock-names = "ext_clock";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_enable_h>;
> -		/*
> -		 * On the module itself this is one of these (depending
> -		 * on the actual card populated):
> -		 * - SDIO_RESET_L_WL_REG_ON
> -		 * - PDN (power down when low)
> -		 */
> -		post-power-on-delay-ms = <200>;
> -		reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usbdcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usbdcin>;
> -	};
> -
> -	avdd0v85_pcie20: avdd0v85-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd0v85_pcie20";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <850000>;
> -		regulator-max-microvolt = <850000>;
> -		vin-supply = <&vdd_0v85_s0>;
> -	};
> -
> -	avdd1v8_pcie20: avdd1v8-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "avdd1v8_pcie20";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	vcc3v3_mipi: vcc3v3-mipi-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_mipi";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_otg: vcc5v0-otg-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_u3host_en>;
> -		regulator-name = "vcc5v0_otg";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&i2c0 {
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	pinctrl-0 = <&i2c6m3_xfer>;
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -	};
> -};
> -
> -&i2c7 {
> -	pinctrl-0 = <&i2c7m0_xfer>;
> -	status = "okay";
> -
> -	es8316: audio-codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_8ch_p0_0>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -
> -	i2s0_8ch_p0: port {
> -		i2s0_8ch_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&pcie2x1l2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&rtl8111_isolate>;
> -	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	led {
> -		gpio_leds: gpio-leds {
> -			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>,
> -					<0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	rtl8111 {
> -		rtl8111_isolate: rtl8111-isolate {
> -			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	sdio-pwrseq {
> -		wifi_enable_h: wifi-enable-h {
> -			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>,
> -					<4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		vcc5v0_u3host_en: vcc5v0-u3host-en {
> -			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wireless-bluetooth {
> -		bt_reset_gpio: bt-reset-pin {
> -			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_gpio: bt-wake-pin {
> -			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		bt_wake_host_irq: bt-wake-host-irq {
> -			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	wireless-wlan {
> -		wifi_host_wake_irq: wifi-host-wake-irq {
> -			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -
> -		wifi_poweren_pin: wifi-poweren-pin {
> -			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	pinctrl-0 = <&pwm2m1_pins>;
> -	status = "okay";
> -};
> -
> -&pwm13 {
> -	pinctrl-names = "active";
> -	pinctrl-0 = <&pwm13m2_pins>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	max-frequency = <200000000>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&sdio {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	cap-sdio-irq;
> -	disable-wp;
> -	keep-power-in-suspend;
> -	max-frequency = <150000000>;
> -	mmc-pwrseq = <&sdio_pwrseq>;
> -	no-sd;
> -	no-mmc;
> -	non-removable;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdiom1_pins>,<&wifi_poweren_pin>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s3>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -/* bt */
> -&uart9 {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588s-orangepi-5.dts b/arch/arm/dts/rk3588s-orangepi-5.dts
> deleted file mode 100644
> index 25de4362af38..000000000000
> --- a/arch/arm/dts/rk3588s-orangepi-5.dts
> +++ /dev/null
> @@ -1,667 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588s.dtsi"
> -
> -/ {
> -	model = "Xunlong Orange Pi 5";
> -	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
> -
> -	aliases {
> -		ethernet0 = &gmac1;
> -		mmc0 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "Recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <1800>;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&leds_gpio>;
> -
> -		led-1 {
> -			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> -			label = "status_led";
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	vbus_typec: vbus-typec-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&typec5v_pwren>;
> -		regulator-name = "vbus_typec";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -	};
> -
> -	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-low;
> -		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
> -		regulator-name = "vcc_3v3_sd_s0";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
> -	vcc3v3_pcie20: vcc3v3-pcie20-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> -		regulator-name = "vcc3v3_pcie20";
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		startup-delay-us = <50000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac1 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy1>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-0 = <&gmac1_miim
> -		     &gmac1_tx_bus2
> -		     &gmac1_rx_bus2
> -		     &gmac1_rgmii_clk
> -		     &gmac1_rgmii_bus>;
> -	pinctrl-names = "default";
> -	tx_delay = <0x42>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c6 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c6m3_xfer>;
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> -		wakeup-source;
> -	};
> -};
> -
> -&mdio1 {
> -	rgmii_phy1: ethernet-phy@1 {
> -		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <0x1>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pcie2x1l2 {
> -	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply = <&vcc3v3_pcie20>;
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	gpio-func {
> -		leds_gpio: leds-gpio {
> -			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb-typec {
> -		usbc0_int: usbc0-int {
> -			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		typec5v_pwren: typec5v-pwren {
> -			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&saradc {
> -	vref-supply = <&avcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-mmc;
> -	no-sdio;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_sd_s0>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&sfc {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&fspim0_pins>;
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0x0>;
> -		spi-max-frequency = <100000000>;
> -		spi-rx-bus-width = <4>;
> -		spi-tx-bus-width = <1>;
> -	};
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -				<&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -		system-power-controller;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-max-microvolt = <1100000>;
> -				regulator-min-microvolt = <1100000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host2_xhci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588s-pinctrl.dtsi b/arch/arm/dts/rk3588s-pinctrl.dtsi
> deleted file mode 100644
> index 30db12c4fc82..000000000000
> --- a/arch/arm/dts/rk3588s-pinctrl.dtsi
> +++ /dev/null
> @@ -1,3447 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - */
> -
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rockchip-pinconf.dtsi"
> -
> -/*
> - * This file is auto generated by pin2dts tool, please keep these code
> - * by adding changes at end of this file.
> - */
> -&pinctrl {
> -	auddsm {
> -		/omit-if-no-ref/
> -		auddsm_pins: auddsm-pins {
> -			rockchip,pins =
> -				/* auddsm_ln */
> -				<3 RK_PA1 4 &pcfg_pull_none>,
> -				/* auddsm_lp */
> -				<3 RK_PA2 4 &pcfg_pull_none>,
> -				/* auddsm_rn */
> -				<3 RK_PA3 4 &pcfg_pull_none>,
> -				/* auddsm_rp */
> -				<3 RK_PA4 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	bt1120 {
> -		/omit-if-no-ref/
> -		bt1120_pins: bt1120-pins {
> -			rockchip,pins =
> -				/* bt1120_clkout */
> -				<4 RK_PB0 2 &pcfg_pull_none>,
> -				/* bt1120_d0 */
> -				<4 RK_PA0 2 &pcfg_pull_none>,
> -				/* bt1120_d1 */
> -				<4 RK_PA1 2 &pcfg_pull_none>,
> -				/* bt1120_d2 */
> -				<4 RK_PA2 2 &pcfg_pull_none>,
> -				/* bt1120_d3 */
> -				<4 RK_PA3 2 &pcfg_pull_none>,
> -				/* bt1120_d4 */
> -				<4 RK_PA4 2 &pcfg_pull_none>,
> -				/* bt1120_d5 */
> -				<4 RK_PA5 2 &pcfg_pull_none>,
> -				/* bt1120_d6 */
> -				<4 RK_PA6 2 &pcfg_pull_none>,
> -				/* bt1120_d7 */
> -				<4 RK_PA7 2 &pcfg_pull_none>,
> -				/* bt1120_d8 */
> -				<4 RK_PB2 2 &pcfg_pull_none>,
> -				/* bt1120_d9 */
> -				<4 RK_PB3 2 &pcfg_pull_none>,
> -				/* bt1120_d10 */
> -				<4 RK_PB4 2 &pcfg_pull_none>,
> -				/* bt1120_d11 */
> -				<4 RK_PB5 2 &pcfg_pull_none>,
> -				/* bt1120_d12 */
> -				<4 RK_PB6 2 &pcfg_pull_none>,
> -				/* bt1120_d13 */
> -				<4 RK_PB7 2 &pcfg_pull_none>,
> -				/* bt1120_d14 */
> -				<4 RK_PC0 2 &pcfg_pull_none>,
> -				/* bt1120_d15 */
> -				<4 RK_PC1 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	can0 {
> -		/omit-if-no-ref/
> -		can0m0_pins: can0m0-pins {
> -			rockchip,pins =
> -				/* can0_rx_m0 */
> -				<0 RK_PC0 11 &pcfg_pull_none>,
> -				/* can0_tx_m0 */
> -				<0 RK_PB7 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		can0m1_pins: can0m1-pins {
> -			rockchip,pins =
> -				/* can0_rx_m1 */
> -				<4 RK_PD5 9 &pcfg_pull_none>,
> -				/* can0_tx_m1 */
> -				<4 RK_PD4 9 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	can1 {
> -		/omit-if-no-ref/
> -		can1m0_pins: can1m0-pins {
> -			rockchip,pins =
> -				/* can1_rx_m0 */
> -				<3 RK_PB5 9 &pcfg_pull_none>,
> -				/* can1_tx_m0 */
> -				<3 RK_PB6 9 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		can1m1_pins: can1m1-pins {
> -			rockchip,pins =
> -				/* can1_rx_m1 */
> -				<4 RK_PB2 12 &pcfg_pull_none>,
> -				/* can1_tx_m1 */
> -				<4 RK_PB3 12 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	can2 {
> -		/omit-if-no-ref/
> -		can2m0_pins: can2m0-pins {
> -			rockchip,pins =
> -				/* can2_rx_m0 */
> -				<3 RK_PC4 9 &pcfg_pull_none>,
> -				/* can2_tx_m0 */
> -				<3 RK_PC5 9 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		can2m1_pins: can2m1-pins {
> -			rockchip,pins =
> -				/* can2_rx_m1 */
> -				<0 RK_PD4 10 &pcfg_pull_none>,
> -				/* can2_tx_m1 */
> -				<0 RK_PD5 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	cif {
> -		/omit-if-no-ref/
> -		cif_clk: cif-clk {
> -			rockchip,pins =
> -				/* cif_clkout */
> -				<4 RK_PB4 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		cif_dvp_clk: cif-dvp-clk {
> -			rockchip,pins =
> -				/* cif_clkin */
> -				<4 RK_PB0 1 &pcfg_pull_none>,
> -				/* cif_href */
> -				<4 RK_PB2 1 &pcfg_pull_none>,
> -				/* cif_vsync */
> -				<4 RK_PB3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		cif_dvp_bus16: cif-dvp-bus16 {
> -			rockchip,pins =
> -				/* cif_d8 */
> -				<3 RK_PC4 1 &pcfg_pull_none>,
> -				/* cif_d9 */
> -				<3 RK_PC5 1 &pcfg_pull_none>,
> -				/* cif_d10 */
> -				<3 RK_PC6 1 &pcfg_pull_none>,
> -				/* cif_d11 */
> -				<3 RK_PC7 1 &pcfg_pull_none>,
> -				/* cif_d12 */
> -				<3 RK_PD0 1 &pcfg_pull_none>,
> -				/* cif_d13 */
> -				<3 RK_PD1 1 &pcfg_pull_none>,
> -				/* cif_d14 */
> -				<3 RK_PD2 1 &pcfg_pull_none>,
> -				/* cif_d15 */
> -				<3 RK_PD3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		cif_dvp_bus8: cif-dvp-bus8 {
> -			rockchip,pins =
> -				/* cif_d0 */
> -				<4 RK_PA0 1 &pcfg_pull_none>,
> -				/* cif_d1 */
> -				<4 RK_PA1 1 &pcfg_pull_none>,
> -				/* cif_d2 */
> -				<4 RK_PA2 1 &pcfg_pull_none>,
> -				/* cif_d3 */
> -				<4 RK_PA3 1 &pcfg_pull_none>,
> -				/* cif_d4 */
> -				<4 RK_PA4 1 &pcfg_pull_none>,
> -				/* cif_d5 */
> -				<4 RK_PA5 1 &pcfg_pull_none>,
> -				/* cif_d6 */
> -				<4 RK_PA6 1 &pcfg_pull_none>,
> -				/* cif_d7 */
> -				<4 RK_PA7 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	clk32k {
> -		/omit-if-no-ref/
> -		clk32k_in: clk32k-in {
> -			rockchip,pins =
> -				/* clk32k_in */
> -				<0 RK_PB2 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		clk32k_out0: clk32k-out0 {
> -			rockchip,pins =
> -				/* clk32k_out0 */
> -				<0 RK_PB2 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	cpu {
> -		/omit-if-no-ref/
> -		cpu_pins: cpu-pins {
> -			rockchip,pins =
> -				/* cpu_big0_avs */
> -				<0 RK_PD1 2 &pcfg_pull_none>,
> -				/* cpu_big1_avs */
> -				<0 RK_PD5 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	ddrphych0 {
> -		/omit-if-no-ref/
> -		ddrphych0_pins: ddrphych0-pins {
> -			rockchip,pins =
> -				/* ddrphych0_dtb0 */
> -				<4 RK_PA0 7 &pcfg_pull_none>,
> -				/* ddrphych0_dtb1 */
> -				<4 RK_PA1 7 &pcfg_pull_none>,
> -				/* ddrphych0_dtb2 */
> -				<4 RK_PA2 7 &pcfg_pull_none>,
> -				/* ddrphych0_dtb3 */
> -				<4 RK_PA3 7 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	ddrphych1 {
> -		/omit-if-no-ref/
> -		ddrphych1_pins: ddrphych1-pins {
> -			rockchip,pins =
> -				/* ddrphych1_dtb0 */
> -				<4 RK_PA4 7 &pcfg_pull_none>,
> -				/* ddrphych1_dtb1 */
> -				<4 RK_PA5 7 &pcfg_pull_none>,
> -				/* ddrphych1_dtb2 */
> -				<4 RK_PA6 7 &pcfg_pull_none>,
> -				/* ddrphych1_dtb3 */
> -				<4 RK_PA7 7 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	ddrphych2 {
> -		/omit-if-no-ref/
> -		ddrphych2_pins: ddrphych2-pins {
> -			rockchip,pins =
> -				/* ddrphych2_dtb0 */
> -				<4 RK_PB0 7 &pcfg_pull_none>,
> -				/* ddrphych2_dtb1 */
> -				<4 RK_PB1 7 &pcfg_pull_none>,
> -				/* ddrphych2_dtb2 */
> -				<4 RK_PB2 7 &pcfg_pull_none>,
> -				/* ddrphych2_dtb3 */
> -				<4 RK_PB3 7 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	ddrphych3 {
> -		/omit-if-no-ref/
> -		ddrphych3_pins: ddrphych3-pins {
> -			rockchip,pins =
> -				/* ddrphych3_dtb0 */
> -				<4 RK_PB4 7 &pcfg_pull_none>,
> -				/* ddrphych3_dtb1 */
> -				<4 RK_PB5 7 &pcfg_pull_none>,
> -				/* ddrphych3_dtb2 */
> -				<4 RK_PB6 7 &pcfg_pull_none>,
> -				/* ddrphych3_dtb3 */
> -				<4 RK_PB7 7 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	dp0 {
> -		/omit-if-no-ref/
> -		dp0m0_pins: dp0m0-pins {
> -			rockchip,pins =
> -				/* dp0_hpdin_m0 */
> -				<4 RK_PB4 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		dp0m1_pins: dp0m1-pins {
> -			rockchip,pins =
> -				/* dp0_hpdin_m1 */
> -				<0 RK_PC4 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		dp0m2_pins: dp0m2-pins {
> -			rockchip,pins =
> -				/* dp0_hpdin_m2 */
> -				<1 RK_PA0 5 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	dp1 {
> -		/omit-if-no-ref/
> -		dp1m0_pins: dp1m0-pins {
> -			rockchip,pins =
> -				/* dp1_hpdin_m0 */
> -				<3 RK_PD5 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		dp1m1_pins: dp1m1-pins {
> -			rockchip,pins =
> -				/* dp1_hpdin_m1 */
> -				<0 RK_PC5 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		dp1m2_pins: dp1m2-pins {
> -			rockchip,pins =
> -				/* dp1_hpdin_m2 */
> -				<1 RK_PA1 5 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	emmc {
> -		/omit-if-no-ref/
> -		emmc_rstnout: emmc-rstnout {
> -			rockchip,pins =
> -				/* emmc_rstn */
> -				<2 RK_PA3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		emmc_bus8: emmc-bus8 {
> -			rockchip,pins =
> -				/* emmc_d0 */
> -				<2 RK_PD0 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d1 */
> -				<2 RK_PD1 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d2 */
> -				<2 RK_PD2 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d3 */
> -				<2 RK_PD3 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d4 */
> -				<2 RK_PD4 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d5 */
> -				<2 RK_PD5 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d6 */
> -				<2 RK_PD6 1 &pcfg_pull_up_drv_level_2>,
> -				/* emmc_d7 */
> -				<2 RK_PD7 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		emmc_clk: emmc-clk {
> -			rockchip,pins =
> -				/* emmc_clkout */
> -				<2 RK_PA1 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		emmc_cmd: emmc-cmd {
> -			rockchip,pins =
> -				/* emmc_cmd */
> -				<2 RK_PA0 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		emmc_data_strobe: emmc-data-strobe {
> -			rockchip,pins =
> -				/* emmc_data_strobe */
> -				<2 RK_PA2 1 &pcfg_pull_down>;
> -		};
> -	};
> -
> -	eth1 {
> -		/omit-if-no-ref/
> -		eth1_pins: eth1-pins {
> -			rockchip,pins =
> -				/* eth1_refclko_25m */
> -				<3 RK_PA6 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	fspi {
> -		/omit-if-no-ref/
> -		fspim0_pins: fspim0-pins {
> -			rockchip,pins =
> -				/* fspi_clk_m0 */
> -				<2 RK_PA0 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_cs0n_m0 */
> -				<2 RK_PD6 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d0_m0 */
> -				<2 RK_PD0 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d1_m0 */
> -				<2 RK_PD1 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d2_m0 */
> -				<2 RK_PD2 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d3_m0 */
> -				<2 RK_PD3 2 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		fspim0_cs1: fspim0-cs1 {
> -			rockchip,pins =
> -				/* fspi_cs1n_m0 */
> -				<2 RK_PD7 2 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		fspim2_pins: fspim2-pins {
> -			rockchip,pins =
> -				/* fspi_clk_m2 */
> -				<3 RK_PA5 5 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_cs0n_m2 */
> -				<3 RK_PC4 2 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d0_m2 */
> -				<3 RK_PA0 5 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d1_m2 */
> -				<3 RK_PA1 5 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d2_m2 */
> -				<3 RK_PA2 5 &pcfg_pull_up_drv_level_2>,
> -				/* fspi_d3_m2 */
> -				<3 RK_PA3 5 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		fspim2_cs1: fspim2-cs1 {
> -			rockchip,pins =
> -				/* fspi_cs1n_m2 */
> -				<3 RK_PC5 2 &pcfg_pull_up_drv_level_2>;
> -		};
> -	};
> -
> -	gmac1 {
> -		/omit-if-no-ref/
> -		gmac1_miim: gmac1-miim {
> -			rockchip,pins =
> -				/* gmac1_mdc */
> -				<3 RK_PC2 1 &pcfg_pull_none>,
> -				/* gmac1_mdio */
> -				<3 RK_PC3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_clkinout: gmac1-clkinout {
> -			rockchip,pins =
> -				/* gmac1_mclkinout */
> -				<3 RK_PB6 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_rx_bus2: gmac1-rx-bus2 {
> -			rockchip,pins =
> -				/* gmac1_rxd0 */
> -				<3 RK_PA7 1 &pcfg_pull_none>,
> -				/* gmac1_rxd1 */
> -				<3 RK_PB0 1 &pcfg_pull_none>,
> -				/* gmac1_rxdv_crs */
> -				<3 RK_PB1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_tx_bus2: gmac1-tx-bus2 {
> -			rockchip,pins =
> -				/* gmac1_txd0 */
> -				<3 RK_PB3 1 &pcfg_pull_none>,
> -				/* gmac1_txd1 */
> -				<3 RK_PB4 1 &pcfg_pull_none>,
> -				/* gmac1_txen */
> -				<3 RK_PB5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_rgmii_clk: gmac1-rgmii-clk {
> -			rockchip,pins =
> -				/* gmac1_rxclk */
> -				<3 RK_PA5 1 &pcfg_pull_none>,
> -				/* gmac1_txclk */
> -				<3 RK_PA4 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_rgmii_bus: gmac1-rgmii-bus {
> -			rockchip,pins =
> -				/* gmac1_rxd2 */
> -				<3 RK_PA2 1 &pcfg_pull_none>,
> -				/* gmac1_rxd3 */
> -				<3 RK_PA3 1 &pcfg_pull_none>,
> -				/* gmac1_txd2 */
> -				<3 RK_PA0 1 &pcfg_pull_none>,
> -				/* gmac1_txd3 */
> -				<3 RK_PA1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_ppsclk: gmac1-ppsclk {
> -			rockchip,pins =
> -				/* gmac1_ppsclk */
> -				<3 RK_PC1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_ppstrig: gmac1-ppstrig {
> -			rockchip,pins =
> -				/* gmac1_ppstrig */
> -				<3 RK_PC0 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_ptp_ref_clk: gmac1-ptp-ref-clk {
> -			rockchip,pins =
> -				/* gmac1_ptp_ref_clk */
> -				<3 RK_PB7 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		gmac1_txer: gmac1-txer {
> -			rockchip,pins =
> -				/* gmac1_txer */
> -				<3 RK_PB2 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	gpu {
> -		/omit-if-no-ref/
> -		gpu_pins: gpu-pins {
> -			rockchip,pins =
> -				/* gpu_avs */
> -				<0 RK_PC5 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	hdmi {
> -		/omit-if-no-ref/
> -		hdmim0_rx_cec: hdmim0-rx-cec {
> -			rockchip,pins =
> -				/* hdmim0_rx_cec */
> -				<4 RK_PB5 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_rx_hpdin: hdmim0-rx-hpdin {
> -			rockchip,pins =
> -				/* hdmim0_rx_hpdin */
> -				<4 RK_PB6 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_rx_scl: hdmim0-rx-scl {
> -			rockchip,pins =
> -				/* hdmim0_rx_scl */
> -				<0 RK_PD2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_rx_sda: hdmim0-rx-sda {
> -			rockchip,pins =
> -				/* hdmim0_rx_sda */
> -				<0 RK_PD1 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx0_cec: hdmim0-tx0-cec {
> -			rockchip,pins =
> -				/* hdmim0_tx0_cec */
> -				<4 RK_PC1 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx0_hpd: hdmim0-tx0-hpd {
> -			rockchip,pins =
> -				/* hdmim0_tx0_hpd */
> -				<1 RK_PA5 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx0_scl: hdmim0-tx0-scl {
> -			rockchip,pins =
> -				/* hdmim0_tx0_scl */
> -				<4 RK_PB7 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx0_sda: hdmim0-tx0-sda {
> -			rockchip,pins =
> -				/* hdmim0_tx0_sda */
> -				<4 RK_PC0 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim0_tx1_hpd: hdmim0-tx1-hpd {
> -			rockchip,pins =
> -				/* hdmim0_tx1_hpd */
> -				<1 RK_PA6 5 &pcfg_pull_none>;
> -		};
> -		/omit-if-no-ref/
> -		hdmim1_rx_cec: hdmim1-rx-cec {
> -			rockchip,pins =
> -				/* hdmim1_rx_cec */
> -				<3 RK_PD1 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_rx_hpdin: hdmim1-rx-hpdin {
> -			rockchip,pins =
> -				/* hdmim1_rx_hpdin */
> -				<3 RK_PD4 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_rx_scl: hdmim1-rx-scl {
> -			rockchip,pins =
> -				/* hdmim1_rx_scl */
> -				<3 RK_PD2 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_rx_sda: hdmim1-rx-sda {
> -			rockchip,pins =
> -				/* hdmim1_rx_sda */
> -				<3 RK_PD3 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx0_cec: hdmim1-tx0-cec {
> -			rockchip,pins =
> -				/* hdmim1_tx0_cec */
> -				<0 RK_PD1 13 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx0_hpd: hdmim1-tx0-hpd {
> -			rockchip,pins =
> -				/* hdmim1_tx0_hpd */
> -				<3 RK_PD4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx0_scl: hdmim1-tx0-scl {
> -			rockchip,pins =
> -				/* hdmim1_tx0_scl */
> -				<0 RK_PD5 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx0_sda: hdmim1-tx0-sda {
> -			rockchip,pins =
> -				/* hdmim1_tx0_sda */
> -				<0 RK_PD4 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx1_cec: hdmim1-tx1-cec {
> -			rockchip,pins =
> -				/* hdmim1_tx1_cec */
> -				<0 RK_PD2 13 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx1_hpd: hdmim1-tx1-hpd {
> -			rockchip,pins =
> -				/* hdmim1_tx1_hpd */
> -				<3 RK_PB7 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx1_scl: hdmim1-tx1-scl {
> -			rockchip,pins =
> -				/* hdmim1_tx1_scl */
> -				<3 RK_PC6 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim1_tx1_sda: hdmim1-tx1-sda {
> -			rockchip,pins =
> -				/* hdmim1_tx1_sda */
> -				<3 RK_PC5 5 &pcfg_pull_none>;
> -		};
> -		/omit-if-no-ref/
> -		hdmim2_rx_cec: hdmim2-rx-cec {
> -			rockchip,pins =
> -				/* hdmim2_rx_cec */
> -				<1 RK_PB7 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_rx_hpdin: hdmim2-rx-hpdin {
> -			rockchip,pins =
> -				/* hdmim2_rx_hpdin */
> -				<1 RK_PB6 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_rx_scl: hdmim2-rx-scl {
> -			rockchip,pins =
> -				/* hdmim2_rx_scl */
> -				<1 RK_PD6 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_rx_sda: hdmim2-rx-sda {
> -			rockchip,pins =
> -				/* hdmim2_rx_sda */
> -				<1 RK_PD7 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_tx0_scl: hdmim2-tx0-scl {
> -			rockchip,pins =
> -				/* hdmim2_tx0_scl */
> -				<3 RK_PC7 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_tx0_sda: hdmim2-tx0-sda {
> -			rockchip,pins =
> -				/* hdmim2_tx0_sda */
> -				<3 RK_PD0 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_tx1_cec: hdmim2-tx1-cec {
> -			rockchip,pins =
> -				/* hdmim2_tx1_cec */
> -				<3 RK_PC4 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_tx1_scl: hdmim2-tx1-scl {
> -			rockchip,pins =
> -				/* hdmim2_tx1_scl */
> -				<1 RK_PA4 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmim2_tx1_sda: hdmim2-tx1-sda {
> -			rockchip,pins =
> -				/* hdmim2_tx1_sda */
> -				<1 RK_PA3 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug0: hdmi-debug0 {
> -			rockchip,pins =
> -				/* hdmi_debug0 */
> -				<1 RK_PA7 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug1: hdmi-debug1 {
> -			rockchip,pins =
> -				/* hdmi_debug1 */
> -				<1 RK_PB0 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug2: hdmi-debug2 {
> -			rockchip,pins =
> -				/* hdmi_debug2 */
> -				<1 RK_PB1 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug3: hdmi-debug3 {
> -			rockchip,pins =
> -				/* hdmi_debug3 */
> -				<1 RK_PB2 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug4: hdmi-debug4 {
> -			rockchip,pins =
> -				/* hdmi_debug4 */
> -				<1 RK_PB3 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug5: hdmi-debug5 {
> -			rockchip,pins =
> -				/* hdmi_debug5 */
> -				<1 RK_PB4 7 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		hdmi_debug6: hdmi-debug6 {
> -			rockchip,pins =
> -				/* hdmi_debug6 */
> -				<1 RK_PA0 7 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	i2c0 {
> -		/omit-if-no-ref/
> -		i2c0m0_xfer: i2c0m0-xfer {
> -			rockchip,pins =
> -				/* i2c0_scl_m0 */
> -				<0 RK_PB3 2 &pcfg_pull_none_smt>,
> -				/* i2c0_sda_m0 */
> -				<0 RK_PA6 2 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c0m2_xfer: i2c0m2-xfer {
> -			rockchip,pins =
> -				/* i2c0_scl_m2 */
> -				<0 RK_PD1 3 &pcfg_pull_none_smt>,
> -				/* i2c0_sda_m2 */
> -				<0 RK_PD2 3 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c1 {
> -		/omit-if-no-ref/
> -		i2c1m0_xfer: i2c1m0-xfer {
> -			rockchip,pins =
> -				/* i2c1_scl_m0 */
> -				<0 RK_PB5 9 &pcfg_pull_none_smt>,
> -				/* i2c1_sda_m0 */
> -				<0 RK_PB6 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c1m1_xfer: i2c1m1-xfer {
> -			rockchip,pins =
> -				/* i2c1_scl_m1 */
> -				<0 RK_PB0 2 &pcfg_pull_none_smt>,
> -				/* i2c1_sda_m1 */
> -				<0 RK_PB1 2 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c1m2_xfer: i2c1m2-xfer {
> -			rockchip,pins =
> -				/* i2c1_scl_m2 */
> -				<0 RK_PD4 9 &pcfg_pull_none_smt>,
> -				/* i2c1_sda_m2 */
> -				<0 RK_PD5 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c1m3_xfer: i2c1m3-xfer {
> -			rockchip,pins =
> -				/* i2c1_scl_m3 */
> -				<2 RK_PD4 9 &pcfg_pull_none_smt>,
> -				/* i2c1_sda_m3 */
> -				<2 RK_PD5 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c1m4_xfer: i2c1m4-xfer {
> -			rockchip,pins =
> -				/* i2c1_scl_m4 */
> -				<1 RK_PD2 9 &pcfg_pull_none_smt>,
> -				/* i2c1_sda_m4 */
> -				<1 RK_PD3 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c2 {
> -		/omit-if-no-ref/
> -		i2c2m0_xfer: i2c2m0-xfer {
> -			rockchip,pins =
> -				/* i2c2_scl_m0 */
> -				<0 RK_PB7 9 &pcfg_pull_none_smt>,
> -				/* i2c2_sda_m0 */
> -				<0 RK_PC0 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c2m2_xfer: i2c2m2-xfer {
> -			rockchip,pins =
> -				/* i2c2_scl_m2 */
> -				<2 RK_PA3 9 &pcfg_pull_none_smt>,
> -				/* i2c2_sda_m2 */
> -				<2 RK_PA2 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c2m3_xfer: i2c2m3-xfer {
> -			rockchip,pins =
> -				/* i2c2_scl_m3 */
> -				<1 RK_PC5 9 &pcfg_pull_none_smt>,
> -				/* i2c2_sda_m3 */
> -				<1 RK_PC4 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c2m4_xfer: i2c2m4-xfer {
> -			rockchip,pins =
> -				/* i2c2_scl_m4 */
> -				<1 RK_PA1 9 &pcfg_pull_none_smt>,
> -				/* i2c2_sda_m4 */
> -				<1 RK_PA0 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c3 {
> -		/omit-if-no-ref/
> -		i2c3m0_xfer: i2c3m0-xfer {
> -			rockchip,pins =
> -				/* i2c3_scl_m0 */
> -				<1 RK_PC1 9 &pcfg_pull_none_smt>,
> -				/* i2c3_sda_m0 */
> -				<1 RK_PC0 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c3m1_xfer: i2c3m1-xfer {
> -			rockchip,pins =
> -				/* i2c3_scl_m1 */
> -				<3 RK_PB7 9 &pcfg_pull_none_smt>,
> -				/* i2c3_sda_m1 */
> -				<3 RK_PC0 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c3m2_xfer: i2c3m2-xfer {
> -			rockchip,pins =
> -				/* i2c3_scl_m2 */
> -				<4 RK_PA4 9 &pcfg_pull_none_smt>,
> -				/* i2c3_sda_m2 */
> -				<4 RK_PA5 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c3m4_xfer: i2c3m4-xfer {
> -			rockchip,pins =
> -				/* i2c3_scl_m4 */
> -				<4 RK_PD0 9 &pcfg_pull_none_smt>,
> -				/* i2c3_sda_m4 */
> -				<4 RK_PD1 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c4 {
> -		/omit-if-no-ref/
> -		i2c4m0_xfer: i2c4m0-xfer {
> -			rockchip,pins =
> -				/* i2c4_scl_m0 */
> -				<3 RK_PA6 9 &pcfg_pull_none_smt>,
> -				/* i2c4_sda_m0 */
> -				<3 RK_PA5 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c4m2_xfer: i2c4m2-xfer {
> -			rockchip,pins =
> -				/* i2c4_scl_m2 */
> -				<0 RK_PC5 9 &pcfg_pull_none_smt>,
> -				/* i2c4_sda_m2 */
> -				<0 RK_PC4 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c4m3_xfer: i2c4m3-xfer {
> -			rockchip,pins =
> -				/* i2c4_scl_m3 */
> -				<1 RK_PA3 9 &pcfg_pull_none_smt>,
> -				/* i2c4_sda_m3 */
> -				<1 RK_PA2 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c4m4_xfer: i2c4m4-xfer {
> -			rockchip,pins =
> -				/* i2c4_scl_m4 */
> -				<1 RK_PC7 9 &pcfg_pull_none_smt>,
> -				/* i2c4_sda_m4 */
> -				<1 RK_PC6 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c5 {
> -		/omit-if-no-ref/
> -		i2c5m0_xfer: i2c5m0-xfer {
> -			rockchip,pins =
> -				/* i2c5_scl_m0 */
> -				<3 RK_PC7 9 &pcfg_pull_none_smt>,
> -				/* i2c5_sda_m0 */
> -				<3 RK_PD0 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c5m1_xfer: i2c5m1-xfer {
> -			rockchip,pins =
> -				/* i2c5_scl_m1 */
> -				<4 RK_PB6 9 &pcfg_pull_none_smt>,
> -				/* i2c5_sda_m1 */
> -				<4 RK_PB7 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c5m2_xfer: i2c5m2-xfer {
> -			rockchip,pins =
> -				/* i2c5_scl_m2 */
> -				<4 RK_PA6 9 &pcfg_pull_none_smt>,
> -				/* i2c5_sda_m2 */
> -				<4 RK_PA7 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c5m3_xfer: i2c5m3-xfer {
> -			rockchip,pins =
> -				/* i2c5_scl_m3 */
> -				<1 RK_PB6 9 &pcfg_pull_none_smt>,
> -				/* i2c5_sda_m3 */
> -				<1 RK_PB7 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c6 {
> -		/omit-if-no-ref/
> -		i2c6m0_xfer: i2c6m0-xfer {
> -			rockchip,pins =
> -				/* i2c6_scl_m0 */
> -				<0 RK_PD0 9 &pcfg_pull_none_smt>,
> -				/* i2c6_sda_m0 */
> -				<0 RK_PC7 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c6m1_xfer: i2c6m1-xfer {
> -			rockchip,pins =
> -				/* i2c6_scl_m1 */
> -				<1 RK_PC3 9 &pcfg_pull_none_smt>,
> -				/* i2c6_sda_m1 */
> -				<1 RK_PC2 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c6m3_xfer: i2c6m3-xfer {
> -			rockchip,pins =
> -				/* i2c6_scl_m3 */
> -				<4 RK_PB1 9 &pcfg_pull_none_smt>,
> -				/* i2c6_sda_m3 */
> -				<4 RK_PB0 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c6m4_xfer: i2c6m4-xfer {
> -			rockchip,pins =
> -				/* i2c6_scl_m4 */
> -				<3 RK_PA1 9 &pcfg_pull_none_smt>,
> -				/* i2c6_sda_m4 */
> -				<3 RK_PA0 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c7 {
> -		/omit-if-no-ref/
> -		i2c7m0_xfer: i2c7m0-xfer {
> -			rockchip,pins =
> -				/* i2c7_scl_m0 */
> -				<1 RK_PD0 9 &pcfg_pull_none_smt>,
> -				/* i2c7_sda_m0 */
> -				<1 RK_PD1 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c7m2_xfer: i2c7m2-xfer {
> -			rockchip,pins =
> -				/* i2c7_scl_m2 */
> -				<3 RK_PD2 9 &pcfg_pull_none_smt>,
> -				/* i2c7_sda_m2 */
> -				<3 RK_PD3 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c7m3_xfer: i2c7m3-xfer {
> -			rockchip,pins =
> -				/* i2c7_scl_m3 */
> -				<4 RK_PB2 9 &pcfg_pull_none_smt>,
> -				/* i2c7_sda_m3 */
> -				<4 RK_PB3 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2c8 {
> -		/omit-if-no-ref/
> -		i2c8m0_xfer: i2c8m0-xfer {
> -			rockchip,pins =
> -				/* i2c8_scl_m0 */
> -				<4 RK_PD2 9 &pcfg_pull_none_smt>,
> -				/* i2c8_sda_m0 */
> -				<4 RK_PD3 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c8m2_xfer: i2c8m2-xfer {
> -			rockchip,pins =
> -				/* i2c8_scl_m2 */
> -				<1 RK_PD6 9 &pcfg_pull_none_smt>,
> -				/* i2c8_sda_m2 */
> -				<1 RK_PD7 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c8m3_xfer: i2c8m3-xfer {
> -			rockchip,pins =
> -				/* i2c8_scl_m3 */
> -				<4 RK_PC0 9 &pcfg_pull_none_smt>,
> -				/* i2c8_sda_m3 */
> -				<4 RK_PC1 9 &pcfg_pull_none_smt>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2c8m4_xfer: i2c8m4-xfer {
> -			rockchip,pins =
> -				/* i2c8_scl_m4 */
> -				<3 RK_PC2 9 &pcfg_pull_none_smt>,
> -				/* i2c8_sda_m4 */
> -				<3 RK_PC3 9 &pcfg_pull_none_smt>;
> -		};
> -	};
> -
> -	i2s0 {
> -		/omit-if-no-ref/
> -		i2s0_lrck: i2s0-lrck {
> -			rockchip,pins =
> -				/* i2s0_lrck */
> -				<1 RK_PC5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_mclk: i2s0-mclk {
> -			rockchip,pins =
> -				/* i2s0_mclk */
> -				<1 RK_PC2 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sclk: i2s0-sclk {
> -			rockchip,pins =
> -				/* i2s0_sclk */
> -				<1 RK_PC3 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdi0: i2s0-sdi0 {
> -			rockchip,pins =
> -				/* i2s0_sdi0 */
> -				<1 RK_PD4 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdi1: i2s0-sdi1 {
> -			rockchip,pins =
> -				/* i2s0_sdi1 */
> -				<1 RK_PD3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdi2: i2s0-sdi2 {
> -			rockchip,pins =
> -				/* i2s0_sdi2 */
> -				<1 RK_PD2 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdi3: i2s0-sdi3 {
> -			rockchip,pins =
> -				/* i2s0_sdi3 */
> -				<1 RK_PD1 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdo0: i2s0-sdo0 {
> -			rockchip,pins =
> -				/* i2s0_sdo0 */
> -				<1 RK_PC7 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdo1: i2s0-sdo1 {
> -			rockchip,pins =
> -				/* i2s0_sdo1 */
> -				<1 RK_PD0 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdo2: i2s0-sdo2 {
> -			rockchip,pins =
> -				/* i2s0_sdo2 */
> -				<1 RK_PD1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s0_sdo3: i2s0-sdo3 {
> -			rockchip,pins =
> -				/* i2s0_sdo3 */
> -				<1 RK_PD2 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	i2s1 {
> -		/omit-if-no-ref/
> -		i2s1m0_lrck: i2s1m0-lrck {
> -			rockchip,pins =
> -				/* i2s1m0_lrck */
> -				<4 RK_PA2 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_mclk: i2s1m0-mclk {
> -			rockchip,pins =
> -				/* i2s1m0_mclk */
> -				<4 RK_PA0 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sclk: i2s1m0-sclk {
> -			rockchip,pins =
> -				/* i2s1m0_sclk */
> -				<4 RK_PA1 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdi0: i2s1m0-sdi0 {
> -			rockchip,pins =
> -				/* i2s1m0_sdi0 */
> -				<4 RK_PA5 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdi1: i2s1m0-sdi1 {
> -			rockchip,pins =
> -				/* i2s1m0_sdi1 */
> -				<4 RK_PA6 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdi2: i2s1m0-sdi2 {
> -			rockchip,pins =
> -				/* i2s1m0_sdi2 */
> -				<4 RK_PA7 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdi3: i2s1m0-sdi3 {
> -			rockchip,pins =
> -				/* i2s1m0_sdi3 */
> -				<4 RK_PB0 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdo0: i2s1m0-sdo0 {
> -			rockchip,pins =
> -				/* i2s1m0_sdo0 */
> -				<4 RK_PB1 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdo1: i2s1m0-sdo1 {
> -			rockchip,pins =
> -				/* i2s1m0_sdo1 */
> -				<4 RK_PB2 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdo2: i2s1m0-sdo2 {
> -			rockchip,pins =
> -				/* i2s1m0_sdo2 */
> -				<4 RK_PB3 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m0_sdo3: i2s1m0-sdo3 {
> -			rockchip,pins =
> -				/* i2s1m0_sdo3 */
> -				<4 RK_PB4 3 &pcfg_pull_none>;
> -		};
> -		/omit-if-no-ref/
> -		i2s1m1_lrck: i2s1m1-lrck {
> -			rockchip,pins =
> -				/* i2s1m1_lrck */
> -				<0 RK_PB7 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_mclk: i2s1m1-mclk {
> -			rockchip,pins =
> -				/* i2s1m1_mclk */
> -				<0 RK_PB5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sclk: i2s1m1-sclk {
> -			rockchip,pins =
> -				/* i2s1m1_sclk */
> -				<0 RK_PB6 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdi0: i2s1m1-sdi0 {
> -			rockchip,pins =
> -				/* i2s1m1_sdi0 */
> -				<0 RK_PC5 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdi1: i2s1m1-sdi1 {
> -			rockchip,pins =
> -				/* i2s1m1_sdi1 */
> -				<0 RK_PC6 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdi2: i2s1m1-sdi2 {
> -			rockchip,pins =
> -				/* i2s1m1_sdi2 */
> -				<0 RK_PC7 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdi3: i2s1m1-sdi3 {
> -			rockchip,pins =
> -				/* i2s1m1_sdi3 */
> -				<0 RK_PD0 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdo0: i2s1m1-sdo0 {
> -			rockchip,pins =
> -				/* i2s1m1_sdo0 */
> -				<0 RK_PD1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdo1: i2s1m1-sdo1 {
> -			rockchip,pins =
> -				/* i2s1m1_sdo1 */
> -				<0 RK_PD2 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdo2: i2s1m1-sdo2 {
> -			rockchip,pins =
> -				/* i2s1m1_sdo2 */
> -				<0 RK_PD4 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s1m1_sdo3: i2s1m1-sdo3 {
> -			rockchip,pins =
> -				/* i2s1m1_sdo3 */
> -				<0 RK_PD5 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	i2s2 {
> -		/omit-if-no-ref/
> -		i2s2m0_lrck: i2s2m0-lrck {
> -			rockchip,pins =
> -				/* i2s2m0_lrck */
> -				<2 RK_PC0 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_mclk: i2s2m0-mclk {
> -			rockchip,pins =
> -				/* i2s2m0_mclk */
> -				<2 RK_PB6 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sclk: i2s2m0-sclk {
> -			rockchip,pins =
> -				/* i2s2m0_sclk */
> -				<2 RK_PB7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sdi: i2s2m0-sdi {
> -			rockchip,pins =
> -				/* i2s2m0_sdi */
> -				<2 RK_PC3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m0_sdo: i2s2m0-sdo {
> -			rockchip,pins =
> -				/* i2s2m0_sdo */
> -				<4 RK_PC3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m1_lrck: i2s2m1-lrck {
> -			rockchip,pins =
> -				/* i2s2m1_lrck */
> -				<3 RK_PB6 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m1_mclk: i2s2m1-mclk {
> -			rockchip,pins =
> -				/* i2s2m1_mclk */
> -				<3 RK_PB4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m1_sclk: i2s2m1-sclk {
> -			rockchip,pins =
> -				/* i2s2m1_sclk */
> -				<3 RK_PB5 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m1_sdi: i2s2m1-sdi {
> -			rockchip,pins =
> -				/* i2s2m1_sdi */
> -				<3 RK_PB2 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s2m1_sdo: i2s2m1-sdo {
> -			rockchip,pins =
> -				/* i2s2m1_sdo */
> -				<3 RK_PB3 3 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	i2s3 {
> -		/omit-if-no-ref/
> -		i2s3_lrck: i2s3-lrck {
> -			rockchip,pins =
> -				/* i2s3_lrck */
> -				<3 RK_PA2 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s3_mclk: i2s3-mclk {
> -			rockchip,pins =
> -				/* i2s3_mclk */
> -				<3 RK_PA0 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s3_sclk: i2s3-sclk {
> -			rockchip,pins =
> -				/* i2s3_sclk */
> -				<3 RK_PA1 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s3_sdi: i2s3-sdi {
> -			rockchip,pins =
> -				/* i2s3_sdi */
> -				<3 RK_PA4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		i2s3_sdo: i2s3-sdo {
> -			rockchip,pins =
> -				/* i2s3_sdo */
> -				<3 RK_PA3 3 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	jtag {
> -		/omit-if-no-ref/
> -		jtagm0_pins: jtagm0-pins {
> -			rockchip,pins =
> -				/* jtag_tck_m0 */
> -				<4 RK_PD2 5 &pcfg_pull_none>,
> -				/* jtag_tms_m0 */
> -				<4 RK_PD3 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		jtagm1_pins: jtagm1-pins {
> -			rockchip,pins =
> -				/* jtag_tck_m1 */
> -				<4 RK_PD0 5 &pcfg_pull_none>,
> -				/* jtag_tms_m1 */
> -				<4 RK_PD1 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		jtagm2_pins: jtagm2-pins {
> -			rockchip,pins =
> -				/* jtag_tck_m2 */
> -				<0 RK_PB5 2 &pcfg_pull_none>,
> -				/* jtag_tms_m2 */
> -				<0 RK_PB6 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	litcpu {
> -		/omit-if-no-ref/
> -		litcpu_pins: litcpu-pins {
> -			rockchip,pins =
> -				/* litcpu_avs */
> -				<0 RK_PD3 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	mcu {
> -		/omit-if-no-ref/
> -		mcum0_pins: mcum0-pins {
> -			rockchip,pins =
> -				/* mcu_jtag_tck_m0 */
> -				<4 RK_PD4 5 &pcfg_pull_none>,
> -				/* mcu_jtag_tms_m0 */
> -				<4 RK_PD5 5 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mcum1_pins: mcum1-pins {
> -			rockchip,pins =
> -				/* mcu_jtag_tck_m1 */
> -				<3 RK_PD4 6 &pcfg_pull_none>,
> -				/* mcu_jtag_tms_m1 */
> -				<3 RK_PD5 6 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	mipi {
> -		/omit-if-no-ref/
> -		mipim0_camera0_clk: mipim0-camera0-clk {
> -			rockchip,pins =
> -				/* mipim0_camera0_clk */
> -				<4 RK_PB1 1 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim0_camera1_clk: mipim0-camera1-clk {
> -			rockchip,pins =
> -				/* mipim0_camera1_clk */
> -				<1 RK_PB6 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim0_camera2_clk: mipim0-camera2-clk {
> -			rockchip,pins =
> -				/* mipim0_camera2_clk */
> -				<1 RK_PB7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim0_camera3_clk: mipim0-camera3-clk {
> -			rockchip,pins =
> -				/* mipim0_camera3_clk */
> -				<1 RK_PD6 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim0_camera4_clk: mipim0-camera4-clk {
> -			rockchip,pins =
> -				/* mipim0_camera4_clk */
> -				<1 RK_PD7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim1_camera0_clk: mipim1-camera0-clk {
> -			rockchip,pins =
> -				/* mipim1_camera0_clk */
> -				<3 RK_PA5 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim1_camera1_clk: mipim1-camera1-clk {
> -			rockchip,pins =
> -				/* mipim1_camera1_clk */
> -				<3 RK_PA6 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim1_camera2_clk: mipim1-camera2-clk {
> -			rockchip,pins =
> -				/* mipim1_camera2_clk */
> -				<3 RK_PA7 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim1_camera3_clk: mipim1-camera3-clk {
> -			rockchip,pins =
> -				/* mipim1_camera3_clk */
> -				<3 RK_PB0 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipim1_camera4_clk: mipim1-camera4-clk {
> -			rockchip,pins =
> -				/* mipim1_camera4_clk */
> -				<3 RK_PB1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipi_te0: mipi-te0 {
> -			rockchip,pins =
> -				/* mipi_te0 */
> -				<3 RK_PC2 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		mipi_te1: mipi-te1 {
> -			rockchip,pins =
> -				/* mipi_te1 */
> -				<3 RK_PC3 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	npu {
> -		/omit-if-no-ref/
> -		npu_pins: npu-pins {
> -			rockchip,pins =
> -				/* npu_avs */
> -				<0 RK_PC6 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie20x1 {
> -		/omit-if-no-ref/
> -		pcie20x1m0_pins: pcie20x1m0-pins {
> -			rockchip,pins =
> -				/* pcie20x1_2_clkreqn_m0 */
> -				<3 RK_PC7 4 &pcfg_pull_none>,
> -				/* pcie20x1_2_perstn_m0 */
> -				<3 RK_PD1 4 &pcfg_pull_none>,
> -				/* pcie20x1_2_waken_m0 */
> -				<3 RK_PD0 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie20x1m1_pins: pcie20x1m1-pins {
> -			rockchip,pins =
> -				/* pcie20x1_2_clkreqn_m1 */
> -				<4 RK_PB7 4 &pcfg_pull_none>,
> -				/* pcie20x1_2_perstn_m1 */
> -				<4 RK_PC1 4 &pcfg_pull_none>,
> -				/* pcie20x1_2_waken_m1 */
> -				<4 RK_PC0 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie20x1_2_button_rstn: pcie20x1-2-button-rstn {
> -			rockchip,pins =
> -				/* pcie20x1_2_button_rstn */
> -				<4 RK_PB3 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie30phy {
> -		/omit-if-no-ref/
> -		pcie30phy_pins: pcie30phy-pins {
> -			rockchip,pins =
> -				/* pcie30phy_dtb0 */
> -				<1 RK_PC4 4 &pcfg_pull_none>,
> -				/* pcie30phy_dtb1 */
> -				<1 RK_PD1 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie30x1 {
> -		/omit-if-no-ref/
> -		pcie30x1m0_pins: pcie30x1m0-pins {
> -			rockchip,pins =
> -				/* pcie30x1_0_clkreqn_m0 */
> -				<0 RK_PC0 12 &pcfg_pull_none>,
> -				/* pcie30x1_0_perstn_m0 */
> -				<0 RK_PC5 12 &pcfg_pull_none>,
> -				/* pcie30x1_0_waken_m0 */
> -				<0 RK_PC4 12 &pcfg_pull_none>,
> -				/* pcie30x1_1_clkreqn_m0 */
> -				<0 RK_PB5 12 &pcfg_pull_none>,
> -				/* pcie30x1_1_perstn_m0 */
> -				<0 RK_PB7 12 &pcfg_pull_none>,
> -				/* pcie30x1_1_waken_m0 */
> -				<0 RK_PB6 12 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x1m1_pins: pcie30x1m1-pins {
> -			rockchip,pins =
> -				/* pcie30x1_0_clkreqn_m1 */
> -				<4 RK_PA3 4 &pcfg_pull_none>,
> -				/* pcie30x1_0_perstn_m1 */
> -				<4 RK_PA5 4 &pcfg_pull_none>,
> -				/* pcie30x1_0_waken_m1 */
> -				<4 RK_PA4 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_clkreqn_m1 */
> -				<4 RK_PA0 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_perstn_m1 */
> -				<4 RK_PA2 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_waken_m1 */
> -				<4 RK_PA1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x1m2_pins: pcie30x1m2-pins {
> -			rockchip,pins =
> -				/* pcie30x1_0_clkreqn_m2 */
> -				<1 RK_PB5 4 &pcfg_pull_none>,
> -				/* pcie30x1_0_perstn_m2 */
> -				<1 RK_PB4 4 &pcfg_pull_none>,
> -				/* pcie30x1_0_waken_m2 */
> -				<1 RK_PB3 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_clkreqn_m2 */
> -				<1 RK_PA0 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_perstn_m2 */
> -				<1 RK_PA7 4 &pcfg_pull_none>,
> -				/* pcie30x1_1_waken_m2 */
> -				<1 RK_PA1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x1_0_button_rstn: pcie30x1-0-button-rstn {
> -			rockchip,pins =
> -				/* pcie30x1_0_button_rstn */
> -				<4 RK_PB1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x1_1_button_rstn: pcie30x1-1-button-rstn {
> -			rockchip,pins =
> -				/* pcie30x1_1_button_rstn */
> -				<4 RK_PB2 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie30x2 {
> -		/omit-if-no-ref/
> -		pcie30x2m0_pins: pcie30x2m0-pins {
> -			rockchip,pins =
> -				/* pcie30x2_clkreqn_m0 */
> -				<0 RK_PD1 12 &pcfg_pull_none>,
> -				/* pcie30x2_perstn_m0 */
> -				<0 RK_PD4 12 &pcfg_pull_none>,
> -				/* pcie30x2_waken_m0 */
> -				<0 RK_PD2 12 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x2m1_pins: pcie30x2m1-pins {
> -			rockchip,pins =
> -				/* pcie30x2_clkreqn_m1 */
> -				<4 RK_PA6 4 &pcfg_pull_none>,
> -				/* pcie30x2_perstn_m1 */
> -				<4 RK_PB0 4 &pcfg_pull_none>,
> -				/* pcie30x2_waken_m1 */
> -				<4 RK_PA7 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x2m2_pins: pcie30x2m2-pins {
> -			rockchip,pins =
> -				/* pcie30x2_clkreqn_m2 */
> -				<3 RK_PD2 4 &pcfg_pull_none>,
> -				/* pcie30x2_perstn_m2 */
> -				<3 RK_PD4 4 &pcfg_pull_none>,
> -				/* pcie30x2_waken_m2 */
> -				<3 RK_PD3 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x2m3_pins: pcie30x2m3-pins {
> -			rockchip,pins =
> -				/* pcie30x2_clkreqn_m3 */
> -				<1 RK_PD7 4 &pcfg_pull_none>,
> -				/* pcie30x2_perstn_m3 */
> -				<1 RK_PB7 4 &pcfg_pull_none>,
> -				/* pcie30x2_waken_m3 */
> -				<1 RK_PB6 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x2_button_rstn: pcie30x2-button-rstn {
> -			rockchip,pins =
> -				/* pcie30x2_button_rstn */
> -				<3 RK_PC1 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pcie30x4 {
> -		/omit-if-no-ref/
> -		pcie30x4m0_pins: pcie30x4m0-pins {
> -			rockchip,pins =
> -				/* pcie30x4_clkreqn_m0 */
> -				<0 RK_PC6 12 &pcfg_pull_none>,
> -				/* pcie30x4_perstn_m0 */
> -				<0 RK_PD0 12 &pcfg_pull_none>,
> -				/* pcie30x4_waken_m0 */
> -				<0 RK_PC7 12 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x4m1_pins: pcie30x4m1-pins {
> -			rockchip,pins =
> -				/* pcie30x4_clkreqn_m1 */
> -				<4 RK_PB4 4 &pcfg_pull_none>,
> -				/* pcie30x4_perstn_m1 */
> -				<4 RK_PB6 4 &pcfg_pull_none>,
> -				/* pcie30x4_waken_m1 */
> -				<4 RK_PB5 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x4m2_pins: pcie30x4m2-pins {
> -			rockchip,pins =
> -				/* pcie30x4_clkreqn_m2 */
> -				<3 RK_PC4 4 &pcfg_pull_none>,
> -				/* pcie30x4_perstn_m2 */
> -				<3 RK_PC6 4 &pcfg_pull_none>,
> -				/* pcie30x4_waken_m2 */
> -				<3 RK_PC5 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x4m3_pins: pcie30x4m3-pins {
> -			rockchip,pins =
> -				/* pcie30x4_clkreqn_m3 */
> -				<1 RK_PB0 4 &pcfg_pull_none>,
> -				/* pcie30x4_perstn_m3 */
> -				<1 RK_PB2 4 &pcfg_pull_none>,
> -				/* pcie30x4_waken_m3 */
> -				<1 RK_PB1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pcie30x4_button_rstn: pcie30x4-button-rstn {
> -			rockchip,pins =
> -				/* pcie30x4_button_rstn */
> -				<3 RK_PD5 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pdm0 {
> -		/omit-if-no-ref/
> -		pdm0m0_clk: pdm0m0-clk {
> -			rockchip,pins =
> -				/* pdm0_clk0_m0 */
> -				<1 RK_PC6 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m0_clk1: pdm0m0-clk1 {
> -			rockchip,pins =
> -				/* pdm0m0_clk1 */
> -				<1 RK_PC4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m0_sdi0: pdm0m0-sdi0 {
> -			rockchip,pins =
> -				/* pdm0m0_sdi0 */
> -				<1 RK_PD5 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m0_sdi1: pdm0m0-sdi1 {
> -			rockchip,pins =
> -				/* pdm0m0_sdi1 */
> -				<1 RK_PD1 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m0_sdi2: pdm0m0-sdi2 {
> -			rockchip,pins =
> -				/* pdm0m0_sdi2 */
> -				<1 RK_PD2 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m0_sdi3: pdm0m0-sdi3 {
> -			rockchip,pins =
> -				/* pdm0m0_sdi3 */
> -				<1 RK_PD3 3 &pcfg_pull_none>;
> -		};
> -		/omit-if-no-ref/
> -		pdm0m1_clk: pdm0m1-clk {
> -			rockchip,pins =
> -				/* pdm0_clk0_m1 */
> -				<0 RK_PC0 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m1_clk1: pdm0m1-clk1 {
> -			rockchip,pins =
> -				/* pdm0m1_clk1 */
> -				<0 RK_PC4 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m1_sdi0: pdm0m1-sdi0 {
> -			rockchip,pins =
> -				/* pdm0m1_sdi0 */
> -				<0 RK_PC7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m1_sdi1: pdm0m1-sdi1 {
> -			rockchip,pins =
> -				/* pdm0m1_sdi1 */
> -				<0 RK_PD0 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m1_sdi2: pdm0m1-sdi2 {
> -			rockchip,pins =
> -				/* pdm0m1_sdi2 */
> -				<0 RK_PD4 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm0m1_sdi3: pdm0m1-sdi3 {
> -			rockchip,pins =
> -				/* pdm0m1_sdi3 */
> -				<0 RK_PD6 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pdm1 {
> -		/omit-if-no-ref/
> -		pdm1m0_clk: pdm1m0-clk {
> -			rockchip,pins =
> -				/* pdm1_clk0_m0 */
> -				<4 RK_PD5 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m0_clk1: pdm1m0-clk1 {
> -			rockchip,pins =
> -				/* pdm1m0_clk1 */
> -				<4 RK_PD4 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m0_sdi0: pdm1m0-sdi0 {
> -			rockchip,pins =
> -				/* pdm1m0_sdi0 */
> -				<4 RK_PD3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m0_sdi1: pdm1m0-sdi1 {
> -			rockchip,pins =
> -				/* pdm1m0_sdi1 */
> -				<4 RK_PD2 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m0_sdi2: pdm1m0-sdi2 {
> -			rockchip,pins =
> -				/* pdm1m0_sdi2 */
> -				<4 RK_PD1 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m0_sdi3: pdm1m0-sdi3 {
> -			rockchip,pins =
> -				/* pdm1m0_sdi3 */
> -				<4 RK_PD0 2 &pcfg_pull_none>;
> -		};
> -		/omit-if-no-ref/
> -		pdm1m1_clk: pdm1m1-clk {
> -			rockchip,pins =
> -				/* pdm1_clk0_m1 */
> -				<1 RK_PB4 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m1_clk1: pdm1m1-clk1 {
> -			rockchip,pins =
> -				/* pdm1m1_clk1 */
> -				<1 RK_PB3 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m1_sdi0: pdm1m1-sdi0 {
> -			rockchip,pins =
> -				/* pdm1m1_sdi0 */
> -				<1 RK_PA7 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m1_sdi1: pdm1m1-sdi1 {
> -			rockchip,pins =
> -				/* pdm1m1_sdi1 */
> -				<1 RK_PB0 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m1_sdi2: pdm1m1-sdi2 {
> -			rockchip,pins =
> -				/* pdm1m1_sdi2 */
> -				<1 RK_PB1 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pdm1m1_sdi3: pdm1m1-sdi3 {
> -			rockchip,pins =
> -				/* pdm1m1_sdi3 */
> -				<1 RK_PB2 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		/omit-if-no-ref/
> -		pmic_pins: pmic-pins {
> -			rockchip,pins =
> -				/* pmic_int_l */
> -				<0 RK_PA7 0 &pcfg_pull_up>,
> -				/* pmic_sleep1 */
> -				<0 RK_PA2 1 &pcfg_pull_none>,
> -				/* pmic_sleep2 */
> -				<0 RK_PA3 1 &pcfg_pull_none>,
> -				/* pmic_sleep3 */
> -				<0 RK_PC1 1 &pcfg_pull_none>,
> -				/* pmic_sleep4 */
> -				<0 RK_PC2 1 &pcfg_pull_none>,
> -				/* pmic_sleep5 */
> -				<0 RK_PC3 1 &pcfg_pull_none>,
> -				/* pmic_sleep6 */
> -				<0 RK_PD6 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmu {
> -		/omit-if-no-ref/
> -		pmu_pins: pmu-pins {
> -			rockchip,pins =
> -				/* pmu_debug */
> -				<0 RK_PA5 3 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm0 {
> -		/omit-if-no-ref/
> -		pwm0m0_pins: pwm0m0-pins {
> -			rockchip,pins =
> -				/* pwm0_m0 */
> -				<0 RK_PB7 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm0m1_pins: pwm0m1-pins {
> -			rockchip,pins =
> -				/* pwm0_m1 */
> -				<1 RK_PD2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm0m2_pins: pwm0m2-pins {
> -			rockchip,pins =
> -				/* pwm0_m2 */
> -				<1 RK_PA2 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm1 {
> -		/omit-if-no-ref/
> -		pwm1m0_pins: pwm1m0-pins {
> -			rockchip,pins =
> -				/* pwm1_m0 */
> -				<0 RK_PC0 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm1m1_pins: pwm1m1-pins {
> -			rockchip,pins =
> -				/* pwm1_m1 */
> -				<1 RK_PD3 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm1m2_pins: pwm1m2-pins {
> -			rockchip,pins =
> -				/* pwm1_m2 */
> -				<1 RK_PA3 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm2 {
> -		/omit-if-no-ref/
> -		pwm2m0_pins: pwm2m0-pins {
> -			rockchip,pins =
> -				/* pwm2_m0 */
> -				<0 RK_PC4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm2m1_pins: pwm2m1-pins {
> -			rockchip,pins =
> -				/* pwm2_m1 */
> -				<3 RK_PB1 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm3 {
> -		/omit-if-no-ref/
> -		pwm3m0_pins: pwm3m0-pins {
> -			rockchip,pins =
> -				/* pwm3_ir_m0 */
> -				<0 RK_PD4 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm3m1_pins: pwm3m1-pins {
> -			rockchip,pins =
> -				/* pwm3_ir_m1 */
> -				<3 RK_PB2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm3m2_pins: pwm3m2-pins {
> -			rockchip,pins =
> -				/* pwm3_ir_m2 */
> -				<1 RK_PC2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm3m3_pins: pwm3m3-pins {
> -			rockchip,pins =
> -				/* pwm3_ir_m3 */
> -				<1 RK_PA7 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm4 {
> -		/omit-if-no-ref/
> -		pwm4m0_pins: pwm4m0-pins {
> -			rockchip,pins =
> -				/* pwm4_m0 */
> -				<0 RK_PC5 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm5 {
> -		/omit-if-no-ref/
> -		pwm5m0_pins: pwm5m0-pins {
> -			rockchip,pins =
> -				/* pwm5_m0 */
> -				<0 RK_PB1 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm5m1_pins: pwm5m1-pins {
> -			rockchip,pins =
> -				/* pwm5_m1 */
> -				<0 RK_PC6 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm6 {
> -		/omit-if-no-ref/
> -		pwm6m0_pins: pwm6m0-pins {
> -			rockchip,pins =
> -				/* pwm6_m0 */
> -				<0 RK_PC7 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm6m1_pins: pwm6m1-pins {
> -			rockchip,pins =
> -				/* pwm6_m1 */
> -				<4 RK_PC1 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm7 {
> -		/omit-if-no-ref/
> -		pwm7m0_pins: pwm7m0-pins {
> -			rockchip,pins =
> -				/* pwm7_ir_m0 */
> -				<0 RK_PD0 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm7m1_pins: pwm7m1-pins {
> -			rockchip,pins =
> -				/* pwm7_ir_m1 */
> -				<4 RK_PD4 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm7m2_pins: pwm7m2-pins {
> -			rockchip,pins =
> -				/* pwm7_ir_m2 */
> -				<1 RK_PC3 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm8 {
> -		/omit-if-no-ref/
> -		pwm8m0_pins: pwm8m0-pins {
> -			rockchip,pins =
> -				/* pwm8_m0 */
> -				<3 RK_PA7 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm8m1_pins: pwm8m1-pins {
> -			rockchip,pins =
> -				/* pwm8_m1 */
> -				<4 RK_PD0 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm8m2_pins: pwm8m2-pins {
> -			rockchip,pins =
> -				/* pwm8_m2 */
> -				<3 RK_PD0 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm9 {
> -		/omit-if-no-ref/
> -		pwm9m0_pins: pwm9m0-pins {
> -			rockchip,pins =
> -				/* pwm9_m0 */
> -				<3 RK_PB0 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm9m1_pins: pwm9m1-pins {
> -			rockchip,pins =
> -				/* pwm9_m1 */
> -				<4 RK_PD1 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm9m2_pins: pwm9m2-pins {
> -			rockchip,pins =
> -				/* pwm9_m2 */
> -				<3 RK_PD1 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm10 {
> -		/omit-if-no-ref/
> -		pwm10m0_pins: pwm10m0-pins {
> -			rockchip,pins =
> -				/* pwm10_m0 */
> -				<3 RK_PA0 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm10m1_pins: pwm10m1-pins {
> -			rockchip,pins =
> -				/* pwm10_m1 */
> -				<4 RK_PD3 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm10m2_pins: pwm10m2-pins {
> -			rockchip,pins =
> -				/* pwm10_m2 */
> -				<3 RK_PD3 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm11 {
> -		/omit-if-no-ref/
> -		pwm11m0_pins: pwm11m0-pins {
> -			rockchip,pins =
> -				/* pwm11_ir_m0 */
> -				<3 RK_PA1 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm11m1_pins: pwm11m1-pins {
> -			rockchip,pins =
> -				/* pwm11_ir_m1 */
> -				<4 RK_PB4 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm11m2_pins: pwm11m2-pins {
> -			rockchip,pins =
> -				/* pwm11_ir_m2 */
> -				<1 RK_PC4 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm11m3_pins: pwm11m3-pins {
> -			rockchip,pins =
> -				/* pwm11_ir_m3 */
> -				<3 RK_PD5 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm12 {
> -		/omit-if-no-ref/
> -		pwm12m0_pins: pwm12m0-pins {
> -			rockchip,pins =
> -				/* pwm12_m0 */
> -				<3 RK_PB5 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm12m1_pins: pwm12m1-pins {
> -			rockchip,pins =
> -				/* pwm12_m1 */
> -				<4 RK_PB5 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm13 {
> -		/omit-if-no-ref/
> -		pwm13m0_pins: pwm13m0-pins {
> -			rockchip,pins =
> -				/* pwm13_m0 */
> -				<3 RK_PB6 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm13m1_pins: pwm13m1-pins {
> -			rockchip,pins =
> -				/* pwm13_m1 */
> -				<4 RK_PB6 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm13m2_pins: pwm13m2-pins {
> -			rockchip,pins =
> -				/* pwm13_m2 */
> -				<1 RK_PB7 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm14 {
> -		/omit-if-no-ref/
> -		pwm14m0_pins: pwm14m0-pins {
> -			rockchip,pins =
> -				/* pwm14_m0 */
> -				<3 RK_PC2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm14m1_pins: pwm14m1-pins {
> -			rockchip,pins =
> -				/* pwm14_m1 */
> -				<4 RK_PB2 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm14m2_pins: pwm14m2-pins {
> -			rockchip,pins =
> -				/* pwm14_m2 */
> -				<1 RK_PD6 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pwm15 {
> -		/omit-if-no-ref/
> -		pwm15m0_pins: pwm15m0-pins {
> -			rockchip,pins =
> -				/* pwm15_ir_m0 */
> -				<3 RK_PC3 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm15m1_pins: pwm15m1-pins {
> -			rockchip,pins =
> -				/* pwm15_ir_m1 */
> -				<4 RK_PB3 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm15m2_pins: pwm15m2-pins {
> -			rockchip,pins =
> -				/* pwm15_ir_m2 */
> -				<1 RK_PC6 11 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		pwm15m3_pins: pwm15m3-pins {
> -			rockchip,pins =
> -				/* pwm15_ir_m3 */
> -				<1 RK_PD7 11 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	refclk {
> -		/omit-if-no-ref/
> -		refclk_pins: refclk-pins {
> -			rockchip,pins =
> -				/* refclk_out */
> -				<0 RK_PA0 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sata {
> -		/omit-if-no-ref/
> -		sata_pins: sata-pins {
> -			rockchip,pins =
> -				/* sata_cp_pod */
> -				<0 RK_PC6 13 &pcfg_pull_none>,
> -				/* sata_cpdet */
> -				<0 RK_PD4 13 &pcfg_pull_none>,
> -				/* sata_mp_switch */
> -				<0 RK_PD5 13 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sata0 {
> -		/omit-if-no-ref/
> -		sata0m0_pins: sata0m0-pins {
> -			rockchip,pins =
> -				/* sata0_act_led_m0 */
> -				<4 RK_PB6 6 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sata0m1_pins: sata0m1-pins {
> -			rockchip,pins =
> -				/* sata0_act_led_m1 */
> -				<1 RK_PB3 6 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sata1 {
> -		/omit-if-no-ref/
> -		sata1m0_pins: sata1m0-pins {
> -			rockchip,pins =
> -				/* sata1_act_led_m0 */
> -				<4 RK_PB5 6 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sata1m1_pins: sata1m1-pins {
> -			rockchip,pins =
> -				/* sata1_act_led_m1 */
> -				<1 RK_PA1 6 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sata2 {
> -		/omit-if-no-ref/
> -		sata2m0_pins: sata2m0-pins {
> -			rockchip,pins =
> -				/* sata2_act_led_m0 */
> -				<4 RK_PB1 6 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sata2m1_pins: sata2m1-pins {
> -			rockchip,pins =
> -				/* sata2_act_led_m1 */
> -				<1 RK_PB7 6 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdio {
> -		/omit-if-no-ref/
> -		sdiom1_pins: sdiom1-pins {
> -			rockchip,pins =
> -				/* sdio_clk_m1 */
> -				<3 RK_PA5 2 &pcfg_pull_none>,
> -				/* sdio_cmd_m1 */
> -				<3 RK_PA4 2 &pcfg_pull_none>,
> -				/* sdio_d0_m1 */
> -				<3 RK_PA0 2 &pcfg_pull_none>,
> -				/* sdio_d1_m1 */
> -				<3 RK_PA1 2 &pcfg_pull_none>,
> -				/* sdio_d2_m1 */
> -				<3 RK_PA2 2 &pcfg_pull_none>,
> -				/* sdio_d3_m1 */
> -				<3 RK_PA3 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sdmmc {
> -		/omit-if-no-ref/
> -		sdmmc_bus4: sdmmc-bus4 {
> -			rockchip,pins =
> -				/* sdmmc_d0 */
> -				<4 RK_PD0 1 &pcfg_pull_up_drv_level_2>,
> -				/* sdmmc_d1 */
> -				<4 RK_PD1 1 &pcfg_pull_up_drv_level_2>,
> -				/* sdmmc_d2 */
> -				<4 RK_PD2 1 &pcfg_pull_up_drv_level_2>,
> -				/* sdmmc_d3 */
> -				<4 RK_PD3 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sdmmc_clk: sdmmc-clk {
> -			rockchip,pins =
> -				/* sdmmc_clk */
> -				<4 RK_PD5 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sdmmc_cmd: sdmmc-cmd {
> -			rockchip,pins =
> -				/* sdmmc_cmd */
> -				<4 RK_PD4 1 &pcfg_pull_up_drv_level_2>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sdmmc_det: sdmmc-det {
> -			rockchip,pins =
> -				/* sdmmc_det */
> -				<0 RK_PA4 1 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		sdmmc_pwren: sdmmc-pwren {
> -			rockchip,pins =
> -				/* sdmmc_pwren */
> -				<0 RK_PA5 2 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	spdif0 {
> -		/omit-if-no-ref/
> -		spdif0m0_tx: spdif0m0-tx {
> -			rockchip,pins =
> -				/* spdif0m0_tx */
> -				<1 RK_PB6 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spdif0m1_tx: spdif0m1-tx {
> -			rockchip,pins =
> -				/* spdif0m1_tx */
> -				<4 RK_PB4 6 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	spdif1 {
> -		/omit-if-no-ref/
> -		spdif1m0_tx: spdif1m0-tx {
> -			rockchip,pins =
> -				/* spdif1m0_tx */
> -				<1 RK_PB7 3 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spdif1m1_tx: spdif1m1-tx {
> -			rockchip,pins =
> -				/* spdif1m1_tx */
> -				<4 RK_PB1 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spdif1m2_tx: spdif1m2-tx {
> -			rockchip,pins =
> -				/* spdif1m2_tx */
> -				<4 RK_PC1 3 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	spi0 {
> -		/omit-if-no-ref/
> -		spi0m0_pins: spi0m0-pins {
> -			rockchip,pins =
> -				/* spi0_clk_m0 */
> -				<0 RK_PC6 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_miso_m0 */
> -				<0 RK_PC7 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_mosi_m0 */
> -				<0 RK_PC0 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m0_cs0: spi0m0-cs0 {
> -			rockchip,pins =
> -				/* spi0_cs0_m0 */
> -				<0 RK_PD1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m0_cs1: spi0m0-cs1 {
> -			rockchip,pins =
> -				/* spi0_cs1_m0 */
> -				<0 RK_PB7 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -		/omit-if-no-ref/
> -		spi0m1_pins: spi0m1-pins {
> -			rockchip,pins =
> -				/* spi0_clk_m1 */
> -				<4 RK_PA2 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_miso_m1 */
> -				<4 RK_PA0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_mosi_m1 */
> -				<4 RK_PA1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m1_cs0: spi0m1-cs0 {
> -			rockchip,pins =
> -				/* spi0_cs0_m1 */
> -				<4 RK_PB2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m1_cs1: spi0m1-cs1 {
> -			rockchip,pins =
> -				/* spi0_cs1_m1 */
> -				<4 RK_PB1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -		/omit-if-no-ref/
> -		spi0m2_pins: spi0m2-pins {
> -			rockchip,pins =
> -				/* spi0_clk_m2 */
> -				<1 RK_PB3 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_miso_m2 */
> -				<1 RK_PB1 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_mosi_m2 */
> -				<1 RK_PB2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m2_cs0: spi0m2-cs0 {
> -			rockchip,pins =
> -				/* spi0_cs0_m2 */
> -				<1 RK_PB4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m2_cs1: spi0m2-cs1 {
> -			rockchip,pins =
> -				/* spi0_cs1_m2 */
> -				<1 RK_PB5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -		/omit-if-no-ref/
> -		spi0m3_pins: spi0m3-pins {
> -			rockchip,pins =
> -				/* spi0_clk_m3 */
> -				<3 RK_PD3 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_miso_m3 */
> -				<3 RK_PD1 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi0_mosi_m3 */
> -				<3 RK_PD2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m3_cs0: spi0m3-cs0 {
> -			rockchip,pins =
> -				/* spi0_cs0_m3 */
> -				<3 RK_PD4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi0m3_cs1: spi0m3-cs1 {
> -			rockchip,pins =
> -				/* spi0_cs1_m3 */
> -				<3 RK_PD5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	spi1 {
> -		/omit-if-no-ref/
> -		spi1m1_pins: spi1m1-pins {
> -			rockchip,pins =
> -				/* spi1_clk_m1 */
> -				<3 RK_PC1 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_miso_m1 */
> -				<3 RK_PC0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_mosi_m1 */
> -				<3 RK_PB7 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m1_cs0: spi1m1-cs0 {
> -			rockchip,pins =
> -				/* spi1_cs0_m1 */
> -				<3 RK_PC2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m1_cs1: spi1m1-cs1 {
> -			rockchip,pins =
> -				/* spi1_cs1_m1 */
> -				<3 RK_PC3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m2_pins: spi1m2-pins {
> -			rockchip,pins =
> -				/* spi1_clk_m2 */
> -				<1 RK_PD2 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_miso_m2 */
> -				<1 RK_PD0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi1_mosi_m2 */
> -				<1 RK_PD1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m2_cs0: spi1m2-cs0 {
> -			rockchip,pins =
> -				/* spi1_cs0_m2 */
> -				<1 RK_PD3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi1m2_cs1: spi1m2-cs1 {
> -			rockchip,pins =
> -				/* spi1_cs1_m2 */
> -				<1 RK_PD5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	spi2 {
> -		/omit-if-no-ref/
> -		spi2m0_pins: spi2m0-pins {
> -			rockchip,pins =
> -				/* spi2_clk_m0 */
> -				<1 RK_PA6 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_miso_m0 */
> -				<1 RK_PA4 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_mosi_m0 */
> -				<1 RK_PA5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m0_cs0: spi2m0-cs0 {
> -			rockchip,pins =
> -				/* spi2_cs0_m0 */
> -				<1 RK_PA7 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m0_cs1: spi2m0-cs1 {
> -			rockchip,pins =
> -				/* spi2_cs1_m0 */
> -				<1 RK_PB0 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m1_pins: spi2m1-pins {
> -			rockchip,pins =
> -				/* spi2_clk_m1 */
> -				<4 RK_PA6 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_miso_m1 */
> -				<4 RK_PA4 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_mosi_m1 */
> -				<4 RK_PA5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m1_cs0: spi2m1-cs0 {
> -			rockchip,pins =
> -				/* spi2_cs0_m1 */
> -				<4 RK_PA7 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m1_cs1: spi2m1-cs1 {
> -			rockchip,pins =
> -				/* spi2_cs1_m1 */
> -				<4 RK_PB0 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m2_pins: spi2m2-pins {
> -			rockchip,pins =
> -				/* spi2_clk_m2 */
> -				<0 RK_PA5 1 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_miso_m2 */
> -				<0 RK_PB3 1 &pcfg_pull_up_drv_level_1>,
> -				/* spi2_mosi_m2 */
> -				<0 RK_PA6 1 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m2_cs0: spi2m2-cs0 {
> -			rockchip,pins =
> -				/* spi2_cs0_m2 */
> -				<0 RK_PB1 1 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi2m2_cs1: spi2m2-cs1 {
> -			rockchip,pins =
> -				/* spi2_cs1_m2 */
> -				<0 RK_PB0 1 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	spi3 {
> -		/omit-if-no-ref/
> -		spi3m1_pins: spi3m1-pins {
> -			rockchip,pins =
> -				/* spi3_clk_m1 */
> -				<4 RK_PB7 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_miso_m1 */
> -				<4 RK_PB5 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_mosi_m1 */
> -				<4 RK_PB6 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m1_cs0: spi3m1-cs0 {
> -			rockchip,pins =
> -				/* spi3_cs0_m1 */
> -				<4 RK_PC0 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m1_cs1: spi3m1-cs1 {
> -			rockchip,pins =
> -				/* spi3_cs1_m1 */
> -				<4 RK_PC1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m2_pins: spi3m2-pins {
> -			rockchip,pins =
> -				/* spi3_clk_m2 */
> -				<0 RK_PD3 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_miso_m2 */
> -				<0 RK_PD0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_mosi_m2 */
> -				<0 RK_PD2 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m2_cs0: spi3m2-cs0 {
> -			rockchip,pins =
> -				/* spi3_cs0_m2 */
> -				<0 RK_PD4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m2_cs1: spi3m2-cs1 {
> -			rockchip,pins =
> -				/* spi3_cs1_m2 */
> -				<0 RK_PD5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m3_pins: spi3m3-pins {
> -			rockchip,pins =
> -				/* spi3_clk_m3 */
> -				<3 RK_PD0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_miso_m3 */
> -				<3 RK_PC6 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi3_mosi_m3 */
> -				<3 RK_PC7 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m3_cs0: spi3m3-cs0 {
> -			rockchip,pins =
> -				/* spi3_cs0_m3 */
> -				<3 RK_PC4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi3m3_cs1: spi3m3-cs1 {
> -			rockchip,pins =
> -				/* spi3_cs1_m3 */
> -				<3 RK_PC5 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	spi4 {
> -		/omit-if-no-ref/
> -		spi4m0_pins: spi4m0-pins {
> -			rockchip,pins =
> -				/* spi4_clk_m0 */
> -				<1 RK_PC2 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_miso_m0 */
> -				<1 RK_PC0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_mosi_m0 */
> -				<1 RK_PC1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m0_cs0: spi4m0-cs0 {
> -			rockchip,pins =
> -				/* spi4_cs0_m0 */
> -				<1 RK_PC3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m0_cs1: spi4m0-cs1 {
> -			rockchip,pins =
> -				/* spi4_cs1_m0 */
> -				<1 RK_PC4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m1_pins: spi4m1-pins {
> -			rockchip,pins =
> -				/* spi4_clk_m1 */
> -				<3 RK_PA2 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_miso_m1 */
> -				<3 RK_PA0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_mosi_m1 */
> -				<3 RK_PA1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m1_cs0: spi4m1-cs0 {
> -			rockchip,pins =
> -				/* spi4_cs0_m1 */
> -				<3 RK_PA3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m1_cs1: spi4m1-cs1 {
> -			rockchip,pins =
> -				/* spi4_cs1_m1 */
> -				<3 RK_PA4 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m2_pins: spi4m2-pins {
> -			rockchip,pins =
> -				/* spi4_clk_m2 */
> -				<1 RK_PA2 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_miso_m2 */
> -				<1 RK_PA0 8 &pcfg_pull_up_drv_level_1>,
> -				/* spi4_mosi_m2 */
> -				<1 RK_PA1 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -
> -		/omit-if-no-ref/
> -		spi4m2_cs0: spi4m2-cs0 {
> -			rockchip,pins =
> -				/* spi4_cs0_m2 */
> -				<1 RK_PA3 8 &pcfg_pull_up_drv_level_1>;
> -		};
> -	};
> -
> -	tsadc {
> -		/omit-if-no-ref/
> -		tsadcm1_shut: tsadcm1-shut {
> -			rockchip,pins =
> -				/* tsadcm1_shut */
> -				<0 RK_PA2 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		tsadc_shut: tsadc-shut {
> -			rockchip,pins =
> -				/* tsadc_shut */
> -				<0 RK_PA1 2 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		tsadc_shut_org: tsadc-shut-org {
> -			rockchip,pins =
> -				/* tsadc_shut_org */
> -				<0 RK_PA1 1 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart0 {
> -		/omit-if-no-ref/
> -		uart0m0_xfer: uart0m0-xfer {
> -			rockchip,pins =
> -				/* uart0_rx_m0 */
> -				<0 RK_PC4 4 &pcfg_pull_up>,
> -				/* uart0_tx_m0 */
> -				<0 RK_PC5 4 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart0m1_xfer: uart0m1-xfer {
> -			rockchip,pins =
> -				/* uart0_rx_m1 */
> -				<0 RK_PB0 4 &pcfg_pull_up>,
> -				/* uart0_tx_m1 */
> -				<0 RK_PB1 4 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart0m2_xfer: uart0m2-xfer {
> -			rockchip,pins =
> -				/* uart0_rx_m2 */
> -				<4 RK_PA4 10 &pcfg_pull_up>,
> -				/* uart0_tx_m2 */
> -				<4 RK_PA3 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart0_ctsn: uart0-ctsn {
> -			rockchip,pins =
> -				/* uart0_ctsn */
> -				<0 RK_PD1 4 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart0_rtsn: uart0-rtsn {
> -			rockchip,pins =
> -				/* uart0_rtsn */
> -				<0 RK_PC6 4 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart1 {
> -		/omit-if-no-ref/
> -		uart1m1_xfer: uart1m1-xfer {
> -			rockchip,pins =
> -				/* uart1_rx_m1 */
> -				<1 RK_PB7 10 &pcfg_pull_up>,
> -				/* uart1_tx_m1 */
> -				<1 RK_PB6 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m1_ctsn: uart1m1-ctsn {
> -			rockchip,pins =
> -				/* uart1m1_ctsn */
> -				<1 RK_PD7 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m1_rtsn: uart1m1-rtsn {
> -			rockchip,pins =
> -				/* uart1m1_rtsn */
> -				<1 RK_PD6 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m2_xfer: uart1m2-xfer {
> -			rockchip,pins =
> -				/* uart1_rx_m2 */
> -				<0 RK_PD2 10 &pcfg_pull_up>,
> -				/* uart1_tx_m2 */
> -				<0 RK_PD1 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m2_ctsn: uart1m2-ctsn {
> -			rockchip,pins =
> -				/* uart1m2_ctsn */
> -				<0 RK_PD0 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart1m2_rtsn: uart1m2-rtsn {
> -			rockchip,pins =
> -				/* uart1m2_rtsn */
> -				<0 RK_PC7 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart2 {
> -		/omit-if-no-ref/
> -		uart2m0_xfer: uart2m0-xfer {
> -			rockchip,pins =
> -				/* uart2_rx_m0 */
> -				<0 RK_PB6 10 &pcfg_pull_up>,
> -				/* uart2_tx_m0 */
> -				<0 RK_PB5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart2m1_xfer: uart2m1-xfer {
> -			rockchip,pins =
> -				/* uart2_rx_m1 */
> -				<4 RK_PD1 10 &pcfg_pull_up>,
> -				/* uart2_tx_m1 */
> -				<4 RK_PD0 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart2m2_xfer: uart2m2-xfer {
> -			rockchip,pins =
> -				/* uart2_rx_m2 */
> -				<3 RK_PB2 10 &pcfg_pull_up>,
> -				/* uart2_tx_m2 */
> -				<3 RK_PB1 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart2_ctsn: uart2-ctsn {
> -			rockchip,pins =
> -				/* uart2_ctsn */
> -				<3 RK_PB4 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart2_rtsn: uart2-rtsn {
> -			rockchip,pins =
> -				/* uart2_rtsn */
> -				<3 RK_PB3 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart3 {
> -		/omit-if-no-ref/
> -		uart3m0_xfer: uart3m0-xfer {
> -			rockchip,pins =
> -				/* uart3_rx_m0 */
> -				<1 RK_PC0 10 &pcfg_pull_up>,
> -				/* uart3_tx_m0 */
> -				<1 RK_PC1 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart3m1_xfer: uart3m1-xfer {
> -			rockchip,pins =
> -				/* uart3_rx_m1 */
> -				<3 RK_PB6 10 &pcfg_pull_up>,
> -				/* uart3_tx_m1 */
> -				<3 RK_PB5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart3m2_xfer: uart3m2-xfer {
> -			rockchip,pins =
> -				/* uart3_rx_m2 */
> -				<4 RK_PA6 10 &pcfg_pull_up>,
> -				/* uart3_tx_m2 */
> -				<4 RK_PA5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart3_ctsn: uart3-ctsn {
> -			rockchip,pins =
> -				/* uart3_ctsn */
> -				<1 RK_PC3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart3_rtsn: uart3-rtsn {
> -			rockchip,pins =
> -				/* uart3_rtsn */
> -				<1 RK_PC2 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart4 {
> -		/omit-if-no-ref/
> -		uart4m0_xfer: uart4m0-xfer {
> -			rockchip,pins =
> -				/* uart4_rx_m0 */
> -				<1 RK_PD3 10 &pcfg_pull_up>,
> -				/* uart4_tx_m0 */
> -				<1 RK_PD2 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart4m1_xfer: uart4m1-xfer {
> -			rockchip,pins =
> -				/* uart4_rx_m1 */
> -				<3 RK_PD0 10 &pcfg_pull_up>,
> -				/* uart4_tx_m1 */
> -				<3 RK_PD1 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart4m2_xfer: uart4m2-xfer {
> -			rockchip,pins =
> -				/* uart4_rx_m2 */
> -				<1 RK_PB2 10 &pcfg_pull_up>,
> -				/* uart4_tx_m2 */
> -				<1 RK_PB3 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart4_ctsn: uart4-ctsn {
> -			rockchip,pins =
> -				/* uart4_ctsn */
> -				<1 RK_PC7 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart4_rtsn: uart4-rtsn {
> -			rockchip,pins =
> -				/* uart4_rtsn */
> -				<1 RK_PC5 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	uart5 {
> -		/omit-if-no-ref/
> -		uart5m0_xfer: uart5m0-xfer {
> -			rockchip,pins =
> -				/* uart5_rx_m0 */
> -				<4 RK_PD4 10 &pcfg_pull_up>,
> -				/* uart5_tx_m0 */
> -				<4 RK_PD5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m0_ctsn: uart5m0-ctsn {
> -			rockchip,pins =
> -				/* uart5m0_ctsn */
> -				<4 RK_PD2 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m0_rtsn: uart5m0-rtsn {
> -			rockchip,pins =
> -				/* uart5m0_rtsn */
> -				<4 RK_PD3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m1_xfer: uart5m1-xfer {
> -			rockchip,pins =
> -				/* uart5_rx_m1 */
> -				<3 RK_PC5 10 &pcfg_pull_up>,
> -				/* uart5_tx_m1 */
> -				<3 RK_PC4 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m1_ctsn: uart5m1-ctsn {
> -			rockchip,pins =
> -				/* uart5m1_ctsn */
> -				<2 RK_PA2 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m1_rtsn: uart5m1-rtsn {
> -			rockchip,pins =
> -				/* uart5m1_rtsn */
> -				<2 RK_PA3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart5m2_xfer: uart5m2-xfer {
> -			rockchip,pins =
> -				/* uart5_rx_m2 */
> -				<2 RK_PD4 10 &pcfg_pull_up>,
> -				/* uart5_tx_m2 */
> -				<2 RK_PD5 10 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	uart6 {
> -		/omit-if-no-ref/
> -		uart6m1_xfer: uart6m1-xfer {
> -			rockchip,pins =
> -				/* uart6_rx_m1 */
> -				<1 RK_PA0 10 &pcfg_pull_up>,
> -				/* uart6_tx_m1 */
> -				<1 RK_PA1 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart6m1_ctsn: uart6m1-ctsn {
> -			rockchip,pins =
> -				/* uart6m1_ctsn */
> -				<1 RK_PA3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart6m1_rtsn: uart6m1-rtsn {
> -			rockchip,pins =
> -				/* uart6m1_rtsn */
> -				<1 RK_PA2 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart6m2_xfer: uart6m2-xfer {
> -			rockchip,pins =
> -				/* uart6_rx_m2 */
> -				<1 RK_PD1 10 &pcfg_pull_up>,
> -				/* uart6_tx_m2 */
> -				<1 RK_PD0 10 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	uart7 {
> -		/omit-if-no-ref/
> -		uart7m1_xfer: uart7m1-xfer {
> -			rockchip,pins =
> -				/* uart7_rx_m1 */
> -				<3 RK_PC1 10 &pcfg_pull_up>,
> -				/* uart7_tx_m1 */
> -				<3 RK_PC0 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart7m1_ctsn: uart7m1-ctsn {
> -			rockchip,pins =
> -				/* uart7m1_ctsn */
> -				<3 RK_PC3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart7m1_rtsn: uart7m1-rtsn {
> -			rockchip,pins =
> -				/* uart7m1_rtsn */
> -				<3 RK_PC2 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart7m2_xfer: uart7m2-xfer {
> -			rockchip,pins =
> -				/* uart7_rx_m2 */
> -				<1 RK_PB4 10 &pcfg_pull_up>,
> -				/* uart7_tx_m2 */
> -				<1 RK_PB5 10 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	uart8 {
> -		/omit-if-no-ref/
> -		uart8m0_xfer: uart8m0-xfer {
> -			rockchip,pins =
> -				/* uart8_rx_m0 */
> -				<4 RK_PB1 10 &pcfg_pull_up>,
> -				/* uart8_tx_m0 */
> -				<4 RK_PB0 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8m0_ctsn: uart8m0-ctsn {
> -			rockchip,pins =
> -				/* uart8m0_ctsn */
> -				<4 RK_PB3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8m0_rtsn: uart8m0-rtsn {
> -			rockchip,pins =
> -				/* uart8m0_rtsn */
> -				<4 RK_PB2 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8m1_xfer: uart8m1-xfer {
> -			rockchip,pins =
> -				/* uart8_rx_m1 */
> -				<3 RK_PA3 10 &pcfg_pull_up>,
> -				/* uart8_tx_m1 */
> -				<3 RK_PA2 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8m1_ctsn: uart8m1-ctsn {
> -			rockchip,pins =
> -				/* uart8m1_ctsn */
> -				<3 RK_PA5 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8m1_rtsn: uart8m1-rtsn {
> -			rockchip,pins =
> -				/* uart8m1_rtsn */
> -				<3 RK_PA4 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart8_xfer: uart8-xfer {
> -			rockchip,pins =
> -				/* uart8_rx_ */
> -				<4 RK_PB1 10 &pcfg_pull_up>;
> -		};
> -	};
> -
> -	uart9 {
> -		/omit-if-no-ref/
> -		uart9m0_xfer: uart9m0-xfer {
> -			rockchip,pins =
> -				/* uart9_rx_m0 */
> -				<2 RK_PC4 10 &pcfg_pull_up>,
> -				/* uart9_tx_m0 */
> -				<2 RK_PC2 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m1_xfer: uart9m1-xfer {
> -			rockchip,pins =
> -				/* uart9_rx_m1 */
> -				<4 RK_PB5 10 &pcfg_pull_up>,
> -				/* uart9_tx_m1 */
> -				<4 RK_PB4 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m1_ctsn: uart9m1-ctsn {
> -			rockchip,pins =
> -				/* uart9m1_ctsn */
> -				<4 RK_PA1 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m1_rtsn: uart9m1-rtsn {
> -			rockchip,pins =
> -				/* uart9m1_rtsn */
> -				<4 RK_PA0 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m2_xfer: uart9m2-xfer {
> -			rockchip,pins =
> -				/* uart9_rx_m2 */
> -				<3 RK_PD4 10 &pcfg_pull_up>,
> -				/* uart9_tx_m2 */
> -				<3 RK_PD5 10 &pcfg_pull_up>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m2_ctsn: uart9m2-ctsn {
> -			rockchip,pins =
> -				/* uart9m2_ctsn */
> -				<3 RK_PD3 10 &pcfg_pull_none>;
> -		};
> -
> -		/omit-if-no-ref/
> -		uart9m2_rtsn: uart9m2-rtsn {
> -			rockchip,pins =
> -				/* uart9m2_rtsn */
> -				<3 RK_PD2 10 &pcfg_pull_none>;
> -		};
> -	};
> -
> -	vop {
> -		/omit-if-no-ref/
> -		vop_pins: vop-pins {
> -			rockchip,pins =
> -				/* vop_post_empty */
> -				<1 RK_PA2 1 &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -/*
> - * This part is edited handly.
> - */
> -&pinctrl {
> -	bt656 {
> -		/omit-if-no-ref/
> -		bt656_pins: bt656-pins {
> -			rockchip,pins =
> -				/* bt1120_clkout */
> -				<4 RK_PB0 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d0 */
> -				<4 RK_PA0 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d1 */
> -				<4 RK_PA1 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d2 */
> -				<4 RK_PA2 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d3 */
> -				<4 RK_PA3 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d4 */
> -				<4 RK_PA4 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d5 */
> -				<4 RK_PA5 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d6 */
> -				<4 RK_PA6 2 &pcfg_pull_none_drv_level_2>,
> -				/* bt1120_d7 */
> -				<4 RK_PA7 2 &pcfg_pull_none_drv_level_2>;
> -		};
> -	};
> -
> -	gpio-func {
> -		/omit-if-no-ref/
> -		tsadc_gpio_func: tsadc-gpio-func {
> -			rockchip,pins =
> -				<0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588s-rock-5a.dts b/arch/arm/dts/rk3588s-rock-5a.dts
> deleted file mode 100644
> index 2002fd0221fa..000000000000
> --- a/arch/arm/dts/rk3588s-rock-5a.dts
> +++ /dev/null
> @@ -1,744 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588s.dtsi"
> -
> -/ {
> -	model = "Radxa ROCK 5 Model A";
> -	compatible = "radxa,rock-5a", "rockchip,rk3588s";
> -
> -	aliases {
> -		ethernet0 = &gmac1;
> -		mmc0 = &sdhci;
> -		mmc1 = &sdmmc;
> -	};
> -
> -	analog-sound {
> -		compatible = "audio-graph-card";
> -		label = "rk3588-es8316";
> -
> -		widgets = "Microphone", "Mic Jack",
> -			  "Headphone", "Headphones";
> -
> -		routing = "MIC2", "Mic Jack",
> -			  "Headphones", "HPOL",
> -			  "Headphones", "HPOR";
> -
> -		dais = <&i2s0_8ch_p0>;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&io_led>;
> -
> -		io-led {
> -			color = <LED_COLOR_ID_BLUE>;
> -			function = LED_FUNCTION_STATUS;
> -			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	fan: pwm-fan {
> -		compatible = "pwm-fan";
> -		cooling-levels = <0 95 145 195 255>;
> -		fan-supply = <&vcc_5v0>;
> -		pwms = <&pwm3 0 50000 0>;
> -		#cooling-cells = <2>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc_5v0: vcc-5v0-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_5v0";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-boot-on;
> -		regulator-always-on;
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc_5v0_en>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	vdd_npu_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <950000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	eeprom: eeprom@50 {
> -		compatible = "belling,bl24c16a", "atmel,24c16";
> -		reg = <0x50>;
> -		pagesize = <16>;
> -	};
> -};
> -
> -&i2c3 {
> -	status = "okay";
> -};
> -
> -&i2c5 {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c5m2_xfer>;
> -};
> -
> -&i2c7 {
> -	status = "okay";
> -
> -	es8316: audio-codec@11 {
> -		compatible = "everest,es8316";
> -		reg = <0x11>;
> -		clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		clock-names = "mclk";
> -		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> -		assigned-clock-rates = <12288000>;
> -		#sound-dai-cells = <0>;
> -
> -		port {
> -			es8316_p0_0: endpoint {
> -				remote-endpoint = <&i2s0_8ch_p0_0>;
> -			};
> -		};
> -	};
> -};
> -
> -&i2s0_8ch {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_lrck
> -		     &i2s0_mclk
> -		     &i2s0_sclk
> -		     &i2s0_sdi0
> -		     &i2s0_sdo0>;
> -	status = "okay";
> -
> -	i2s0_8ch_p0: port {
> -		i2s0_8ch_p0_0: endpoint {
> -			dai-format = "i2s";
> -			mclk-fs = <256>;
> -			remote-endpoint = <&es8316_p0_0>;
> -		};
> -	};
> -};
> -
> -&gmac1 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy1>;
> -	phy-mode = "rgmii";
> -	pinctrl-0 = <&gmac1_miim
> -		     &gmac1_tx_bus2
> -		     &gmac1_rx_bus2
> -		     &gmac1_rgmii_clk
> -		     &gmac1_rgmii_bus>;
> -	pinctrl-names = "default";
> -	tx_delay = <0x3a>;
> -	rx_delay = <0x3e>;
> -	status = "okay";
> -};
> -
> -&mdio1 {
> -	rgmii_phy1: ethernet-phy@1 {
> -		/* RTL8211F */
> -		compatible = "ethernet-phy-id001c.c916";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtl8211f_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pinctrl {
> -	leds {
> -		io_led: io-led {
> -			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	power {
> -		vcc_5v0_en: vcc-5v0-en {
> -			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	rtl8211f {
> -		rtl8211f_rst: rtl8211f-rst {
> -			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	wifibt {
> -		wl_reset: wl-reset {
> -			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		wl_dis: wl-dis {
> -			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_output_high>;
> -		};
> -
> -		wl_wake_host: wl-wake-host {
> -			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		bt_dis: bt-dis {
> -			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_output_high>;
> -		};
> -
> -		bt_wake_host: bt-wake-host {
> -			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -};
> -
> -&pwm3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm3m1_pins>;
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&avcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	no-sdio;
> -	no-mmc;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_3v3_s0>;
> -	vqmmc-supply = <&vccio_sd_s0>;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	status = "okay";
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -				regulator-enable-ramp-delay = <400>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	status = "okay";
> -	phy-supply = <&vcc5v0_host>;
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&wl_reset &wl_dis &wl_wake_host &bt_dis &bt_wake_host>;
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host2_xhci {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
> deleted file mode 100644
> index 36b1b7acfe6a..000000000000
> --- a/arch/arm/dts/rk3588s.dtsi
> +++ /dev/null
> @@ -1,2485 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> - */
> -
> -#include <dt-bindings/clock/rockchip,rk3588-cru.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/power/rk3588-power.h>
> -#include <dt-bindings/reset/rockchip,rk3588-cru.h>
> -#include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/ata/ahci.h>
> -
> -/ {
> -	compatible = "rockchip,rk3588";
> -
> -	interrupt-parent = <&gic>;
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -
> -	aliases {
> -		gpio0 = &gpio0;
> -		gpio1 = &gpio1;
> -		gpio2 = &gpio2;
> -		gpio3 = &gpio3;
> -		gpio4 = &gpio4;
> -		i2c0 = &i2c0;
> -		i2c1 = &i2c1;
> -		i2c2 = &i2c2;
> -		i2c3 = &i2c3;
> -		i2c4 = &i2c4;
> -		i2c5 = &i2c5;
> -		i2c6 = &i2c6;
> -		i2c7 = &i2c7;
> -		i2c8 = &i2c8;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -		serial3 = &uart3;
> -		serial4 = &uart4;
> -		serial5 = &uart5;
> -		serial6 = &uart6;
> -		serial7 = &uart7;
> -		serial8 = &uart8;
> -		serial9 = &uart9;
> -		spi0 = &spi0;
> -		spi1 = &spi1;
> -		spi2 = &spi2;
> -		spi3 = &spi3;
> -		spi4 = &spi4;
> -	};
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpu-map {
> -			cluster0 {
> -				core0 {
> -					cpu = <&cpu_l0>;
> -				};
> -				core1 {
> -					cpu = <&cpu_l1>;
> -				};
> -				core2 {
> -					cpu = <&cpu_l2>;
> -				};
> -				core3 {
> -					cpu = <&cpu_l3>;
> -				};
> -			};
> -			cluster1 {
> -				core0 {
> -					cpu = <&cpu_b0>;
> -				};
> -				core1 {
> -					cpu = <&cpu_b1>;
> -				};
> -			};
> -			cluster2 {
> -				core0 {
> -					cpu = <&cpu_b2>;
> -				};
> -				core1 {
> -					cpu = <&cpu_b3>;
> -				};
> -			};
> -		};
> -
> -		cpu_l0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a55";
> -			reg = <0x0>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <530>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> -			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
> -			assigned-clock-rates = <816000000>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <32768>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <128>;
> -			d-cache-size = <32768>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> -			next-level-cache = <&l2_cache_l0>;
> -			dynamic-power-coefficient = <228>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_l1: cpu@100 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a55";
> -			reg = <0x100>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <530>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <32768>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <128>;
> -			d-cache-size = <32768>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> -			next-level-cache = <&l2_cache_l1>;
> -			dynamic-power-coefficient = <228>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_l2: cpu@200 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a55";
> -			reg = <0x200>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <530>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <32768>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <128>;
> -			d-cache-size = <32768>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> -			next-level-cache = <&l2_cache_l2>;
> -			dynamic-power-coefficient = <228>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_l3: cpu@300 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a55";
> -			reg = <0x300>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <530>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUL>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <32768>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <128>;
> -			d-cache-size = <32768>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <128>;
> -			next-level-cache = <&l2_cache_l3>;
> -			dynamic-power-coefficient = <228>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_b0: cpu@400 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a76";
> -			reg = <0x400>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
> -			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
> -			assigned-clock-rates = <816000000>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <65536>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <256>;
> -			d-cache-size = <65536>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <256>;
> -			next-level-cache = <&l2_cache_b0>;
> -			dynamic-power-coefficient = <416>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_b1: cpu@500 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a76";
> -			reg = <0x500>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <65536>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <256>;
> -			d-cache-size = <65536>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <256>;
> -			next-level-cache = <&l2_cache_b1>;
> -			dynamic-power-coefficient = <416>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_b2: cpu@600 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a76";
> -			reg = <0x600>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
> -			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
> -			assigned-clock-rates = <816000000>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <65536>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <256>;
> -			d-cache-size = <65536>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <256>;
> -			next-level-cache = <&l2_cache_b2>;
> -			dynamic-power-coefficient = <416>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		cpu_b3: cpu@700 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a76";
> -			reg = <0x700>;
> -			enable-method = "psci";
> -			capacity-dmips-mhz = <1024>;
> -			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
> -			cpu-idle-states = <&CPU_SLEEP>;
> -			i-cache-size = <65536>;
> -			i-cache-line-size = <64>;
> -			i-cache-sets = <256>;
> -			d-cache-size = <65536>;
> -			d-cache-line-size = <64>;
> -			d-cache-sets = <256>;
> -			next-level-cache = <&l2_cache_b3>;
> -			dynamic-power-coefficient = <416>;
> -			#cooling-cells = <2>;
> -		};
> -
> -		idle-states {
> -			entry-method = "psci";
> -			CPU_SLEEP: cpu-sleep {
> -				compatible = "arm,idle-state";
> -				local-timer-stop;
> -				arm,psci-suspend-param = <0x0010000>;
> -				entry-latency-us = <100>;
> -				exit-latency-us = <120>;
> -				min-residency-us = <1000>;
> -			};
> -		};
> -
> -		l2_cache_l0: l2-cache-l0 {
> -			compatible = "cache";
> -			cache-size = <131072>;
> -			cache-line-size = <64>;
> -			cache-sets = <512>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_l1: l2-cache-l1 {
> -			compatible = "cache";
> -			cache-size = <131072>;
> -			cache-line-size = <64>;
> -			cache-sets = <512>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_l2: l2-cache-l2 {
> -			compatible = "cache";
> -			cache-size = <131072>;
> -			cache-line-size = <64>;
> -			cache-sets = <512>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_l3: l2-cache-l3 {
> -			compatible = "cache";
> -			cache-size = <131072>;
> -			cache-line-size = <64>;
> -			cache-sets = <512>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_b0: l2-cache-b0 {
> -			compatible = "cache";
> -			cache-size = <524288>;
> -			cache-line-size = <64>;
> -			cache-sets = <1024>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_b1: l2-cache-b1 {
> -			compatible = "cache";
> -			cache-size = <524288>;
> -			cache-line-size = <64>;
> -			cache-sets = <1024>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_b2: l2-cache-b2 {
> -			compatible = "cache";
> -			cache-size = <524288>;
> -			cache-line-size = <64>;
> -			cache-sets = <1024>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l2_cache_b3: l2-cache-b3 {
> -			compatible = "cache";
> -			cache-size = <524288>;
> -			cache-line-size = <64>;
> -			cache-sets = <1024>;
> -			cache-level = <2>;
> -			cache-unified;
> -			next-level-cache = <&l3_cache>;
> -		};
> -
> -		l3_cache: l3-cache {
> -			compatible = "cache";
> -			cache-size = <3145728>;
> -			cache-line-size = <64>;
> -			cache-sets = <4096>;
> -			cache-level = <3>;
> -			cache-unified;
> -		};
> -	};
> -
> -	firmware {
> -		optee: optee {
> -			compatible = "linaro,optee-tz";
> -			method = "smc";
> -		};
> -
> -		scmi: scmi {
> -			compatible = "arm,scmi-smc";
> -			arm,smc-id = <0x82000010>;
> -			shmem = <&scmi_shmem>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			scmi_clk: protocol@14 {
> -				reg = <0x14>;
> -				#clock-cells = <1>;
> -			};
> -
> -			scmi_reset: protocol@16 {
> -				reg = <0x16>;
> -				#reset-cells = <1>;
> -			};
> -		};
> -	};
> -
> -	pmu-a55 {
> -		compatible = "arm,cortex-a55-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_partition0>;
> -	};
> -
> -	pmu-a76 {
> -		compatible = "arm,cortex-a76-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_partition1>;
> -	};
> -
> -	psci {
> -		compatible = "arm,psci-1.0";
> -		method = "smc";
> -	};
> -
> -	spll: clock-0 {
> -		compatible = "fixed-clock";
> -		clock-frequency = <702000000>;
> -		clock-output-names = "spll";
> -		#clock-cells = <0>;
> -	};
> -
> -	display_subsystem: display-subsystem {
> -		compatible = "rockchip,display-subsystem";
> -		ports = <&vop_out>;
> -	};
> -
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
> -	};
> -
> -	xin24m: clock-1 {
> -		compatible = "fixed-clock";
> -		clock-frequency = <24000000>;
> -		clock-output-names = "xin24m";
> -		#clock-cells = <0>;
> -	};
> -
> -	xin32k: clock-2 {
> -		compatible = "fixed-clock";
> -		clock-frequency = <32768>;
> -		clock-output-names = "xin32k";
> -		#clock-cells = <0>;
> -	};
> -
> -	pmu_sram: sram@10f000 {
> -		compatible = "mmio-sram";
> -		reg = <0x0 0x0010f000 0x0 0x100>;
> -		ranges = <0 0x0 0x0010f000 0x100>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		scmi_shmem: sram@0 {
> -			compatible = "arm,scmi-shmem";
> -			reg = <0x0 0x100>;
> -		};
> -	};
> -
> -	usb_host0_ehci: usb@fc800000 {
> -		compatible = "rockchip,rk3588-ehci", "generic-ehci";
> -		reg = <0x0 0xfc800000 0x0 0x40000>;
> -		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
> -		phys = <&u2phy2_host>;
> -		phy-names = "usb";
> -		power-domains = <&power RK3588_PD_USB>;
> -		status = "disabled";
> -	};
> -
> -	usb_host0_ohci: usb@fc840000 {
> -		compatible = "rockchip,rk3588-ohci", "generic-ohci";
> -		reg = <0x0 0xfc840000 0x0 0x40000>;
> -		interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST_ARB0>, <&cru ACLK_USB>, <&u2phy2>;
> -		phys = <&u2phy2_host>;
> -		phy-names = "usb";
> -		power-domains = <&power RK3588_PD_USB>;
> -		status = "disabled";
> -	};
> -
> -	usb_host1_ehci: usb@fc880000 {
> -		compatible = "rockchip,rk3588-ehci", "generic-ehci";
> -		reg = <0x0 0xfc880000 0x0 0x40000>;
> -		interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
> -		phys = <&u2phy3_host>;
> -		phy-names = "usb";
> -		power-domains = <&power RK3588_PD_USB>;
> -		status = "disabled";
> -	};
> -
> -	usb_host1_ohci: usb@fc8c0000 {
> -		compatible = "rockchip,rk3588-ohci", "generic-ohci";
> -		reg = <0x0 0xfc8c0000 0x0 0x40000>;
> -		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST_ARB1>, <&cru ACLK_USB>, <&u2phy3>;
> -		phys = <&u2phy3_host>;
> -		phy-names = "usb";
> -		power-domains = <&power RK3588_PD_USB>;
> -		status = "disabled";
> -	};
> -
> -	usb_host2_xhci: usb@fcd00000 {
> -		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> -		reg = <0x0 0xfcd00000 0x0 0x400000>;
> -		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru REF_CLK_USB3OTG2>, <&cru SUSPEND_CLK_USB3OTG2>,
> -			 <&cru ACLK_USB3OTG2>, <&cru CLK_UTMI_OTG2>,
> -			 <&cru CLK_PIPEPHY2_PIPE_U3_G>;
> -		clock-names = "ref_clk", "suspend_clk", "bus_clk", "utmi", "pipe";
> -		dr_mode = "host";
> -		phys = <&combphy2_psu PHY_TYPE_USB3>;
> -		phy-names = "usb3-phy";
> -		phy_type = "utmi_wide";
> -		resets = <&cru SRST_A_USB3OTG2>;
> -		snps,dis_enblslpm_quirk;
> -		snps,dis-u2-freeclk-exists-quirk;
> -		snps,dis-del-phy-power-chg-quirk;
> -		snps,dis-tx-ipgap-linecheck-quirk;
> -		snps,dis_rxdet_inp3_quirk;
> -		status = "disabled";
> -	};
> -
> -	pmu1grf: syscon@fd58a000 {
> -		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd58a000 0x0 0x10000>;
> -	};
> -
> -	sys_grf: syscon@fd58c000 {
> -		compatible = "rockchip,rk3588-sys-grf", "syscon";
> -		reg = <0x0 0xfd58c000 0x0 0x1000>;
> -	};
> -
> -	vop_grf: syscon@fd5a4000 {
> -		compatible = "rockchip,rk3588-vop-grf", "syscon";
> -		reg = <0x0 0xfd5a4000 0x0 0x2000>;
> -	};
> -
> -	vo1_grf: syscon@fd5a8000 {
> -		compatible = "rockchip,rk3588-vo-grf", "syscon";
> -		reg = <0x0 0xfd5a8000 0x0 0x100>;
> -	};
> -
> -	php_grf: syscon@fd5b0000 {
> -		compatible = "rockchip,rk3588-php-grf", "syscon";
> -		reg = <0x0 0xfd5b0000 0x0 0x1000>;
> -	};
> -
> -	pipe_phy0_grf: syscon@fd5bc000 {
> -		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
> -		reg = <0x0 0xfd5bc000 0x0 0x100>;
> -	};
> -
> -	pipe_phy2_grf: syscon@fd5c4000 {
> -		compatible = "rockchip,rk3588-pipe-phy-grf", "syscon";
> -		reg = <0x0 0xfd5c4000 0x0 0x100>;
> -	};
> -
> -	usb2phy2_grf: syscon@fd5d8000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd5d8000 0x0 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		u2phy2: usb2-phy@8000 {
> -			compatible = "rockchip,rk3588-usb2phy";
> -			reg = <0x8000 0x10>;
> -			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
> -			reset-names = "phy", "apb";
> -			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> -			clock-names = "phyclk";
> -			clock-output-names = "usb480m_phy2";
> -			#clock-cells = <0>;
> -			status = "disabled";
> -
> -			u2phy2_host: host-port {
> -				#phy-cells = <0>;
> -				status = "disabled";
> -			};
> -		};
> -	};
> -
> -	usb2phy3_grf: syscon@fd5dc000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd5dc000 0x0 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		u2phy3: usb2-phy@c000 {
> -			compatible = "rockchip,rk3588-usb2phy";
> -			reg = <0xc000 0x10>;
> -			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
> -			reset-names = "phy", "apb";
> -			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> -			clock-names = "phyclk";
> -			clock-output-names = "usb480m_phy3";
> -			#clock-cells = <0>;
> -			status = "disabled";
> -
> -			u2phy3_host: host-port {
> -				#phy-cells = <0>;
> -				status = "disabled";
> -			};
> -		};
> -	};
> -
> -	ioc: syscon@fd5f0000 {
> -		compatible = "rockchip,rk3588-ioc", "syscon";
> -		reg = <0x0 0xfd5f0000 0x0 0x10000>;
> -	};
> -
> -	system_sram1: sram@fd600000 {
> -		compatible = "mmio-sram";
> -		reg = <0x0 0xfd600000 0x0 0x100000>;
> -		ranges = <0x0 0x0 0xfd600000 0x100000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -	};
> -
> -	cru: clock-controller@fd7c0000 {
> -		compatible = "rockchip,rk3588-cru";
> -		reg = <0x0 0xfd7c0000 0x0 0x5c000>;
> -		assigned-clocks =
> -			<&cru PLL_PPLL>, <&cru PLL_AUPLL>,
> -			<&cru PLL_NPLL>, <&cru PLL_GPLL>,
> -			<&cru ACLK_CENTER_ROOT>,
> -			<&cru HCLK_CENTER_ROOT>, <&cru ACLK_CENTER_LOW_ROOT>,
> -			<&cru ACLK_TOP_ROOT>, <&cru PCLK_TOP_ROOT>,
> -			<&cru ACLK_LOW_TOP_ROOT>, <&cru PCLK_PMU0_ROOT>,
> -			<&cru HCLK_PMU_CM0_ROOT>, <&cru ACLK_VOP>,
> -			<&cru ACLK_BUS_ROOT>, <&cru CLK_150M_SRC>,
> -			<&cru CLK_GPU>;
> -		assigned-clock-rates =
> -			<1100000000>, <786432000>,
> -			<850000000>, <1188000000>,
> -			<702000000>,
> -			<400000000>, <500000000>,
> -			<800000000>, <100000000>,
> -			<400000000>, <100000000>,
> -			<200000000>, <500000000>,
> -			<375000000>, <150000000>,
> -			<200000000>;
> -		rockchip,grf = <&php_grf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -	i2c0: i2c@fd880000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfd880000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_I2C0>, <&cru PCLK_I2C0>;
> -		clock-names = "i2c", "pclk";
> -		pinctrl-0 = <&i2c0m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	vop: vop@fdd90000 {
> -		compatible = "rockchip,rk3588-vop";
> -		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
> -		reg-names = "vop", "gamma-lut";
> -		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP>,
> -			 <&cru HCLK_VOP>,
> -			 <&cru DCLK_VOP0>,
> -			 <&cru DCLK_VOP1>,
> -			 <&cru DCLK_VOP2>,
> -			 <&cru DCLK_VOP3>,
> -			 <&cru PCLK_VOP_ROOT>;
> -		clock-names = "aclk",
> -			      "hclk",
> -			      "dclk_vp0",
> -			      "dclk_vp1",
> -			      "dclk_vp2",
> -			      "dclk_vp3",
> -			      "pclk_vop";
> -		iommus = <&vop_mmu>;
> -		power-domains = <&power RK3588_PD_VOP>;
> -		rockchip,grf = <&sys_grf>;
> -		rockchip,vop-grf = <&vop_grf>;
> -		rockchip,vo1-grf = <&vo1_grf>;
> -		rockchip,pmu = <&pmu>;
> -		status = "disabled";
> -
> -		vop_out: ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vp0: port@0 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <0>;
> -			};
> -
> -			vp1: port@1 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <1>;
> -			};
> -
> -			vp2: port@2 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <2>;
> -			};
> -
> -			vp3: port@3 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <3>;
> -			};
> -		};
> -	};
> -
> -	vop_mmu: iommu@fdd97e00 {
> -		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> -		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
> -		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -		power-domains = <&power RK3588_PD_VOP>;
> -		status = "disabled";
> -	};
> -
> -	uart0: serial@fd890000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfd890000 0x0 0x100>;
> -		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac0 6>, <&dmac0 7>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart0m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-shift = <2>;
> -		reg-io-width = <4>;
> -		status = "disabled";
> -	};
> -
> -	pwm0: pwm@fd8b0000 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfd8b0000 0x0 0x10>;
> -		clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm0m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm1: pwm@fd8b0010 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfd8b0010 0x0 0x10>;
> -		clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm1m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm2: pwm@fd8b0020 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfd8b0020 0x0 0x10>;
> -		clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm2m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm3: pwm@fd8b0030 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfd8b0030 0x0 0x10>;
> -		clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm3m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pmu: power-management@fd8d8000 {
> -		compatible = "rockchip,rk3588-pmu", "syscon", "simple-mfd";
> -		reg = <0x0 0xfd8d8000 0x0 0x400>;
> -
> -		power: power-controller {
> -			compatible = "rockchip,rk3588-power-controller";
> -			#address-cells = <1>;
> -			#power-domain-cells = <1>;
> -			#size-cells = <0>;
> -			status = "okay";
> -
> -			/* These power domains are grouped by VD_NPU */
> -			power-domain@RK3588_PD_NPU {
> -				reg = <RK3588_PD_NPU>;
> -				#power-domain-cells = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				power-domain@RK3588_PD_NPUTOP {
> -					reg = <RK3588_PD_NPUTOP>;
> -					clocks = <&cru HCLK_NPU_ROOT>,
> -						 <&cru PCLK_NPU_ROOT>,
> -						 <&cru CLK_NPU_DSU0>,
> -						 <&cru HCLK_NPU_CM0_ROOT>;
> -					pm_qos = <&qos_npu0_mwr>,
> -						 <&qos_npu0_mro>,
> -						 <&qos_mcu_npu>;
> -					#power-domain-cells = <0>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					power-domain@RK3588_PD_NPU1 {
> -						reg = <RK3588_PD_NPU1>;
> -						clocks = <&cru HCLK_NPU_ROOT>,
> -							 <&cru PCLK_NPU_ROOT>,
> -							 <&cru CLK_NPU_DSU0>;
> -						pm_qos = <&qos_npu1>;
> -						#power-domain-cells = <0>;
> -					};
> -					power-domain@RK3588_PD_NPU2 {
> -						reg = <RK3588_PD_NPU2>;
> -						clocks = <&cru HCLK_NPU_ROOT>,
> -							 <&cru PCLK_NPU_ROOT>,
> -							 <&cru CLK_NPU_DSU0>;
> -						pm_qos = <&qos_npu2>;
> -						#power-domain-cells = <0>;
> -					};
> -				};
> -			};
> -			/* These power domains are grouped by VD_GPU */
> -			power-domain@RK3588_PD_GPU {
> -				reg = <RK3588_PD_GPU>;
> -				clocks = <&cru CLK_GPU>,
> -					 <&cru CLK_GPU_COREGROUP>,
> -					 <&cru CLK_GPU_STACKS>;
> -				pm_qos = <&qos_gpu_m0>,
> -					 <&qos_gpu_m1>,
> -					 <&qos_gpu_m2>,
> -					 <&qos_gpu_m3>;
> -				#power-domain-cells = <0>;
> -			};
> -			/* These power domains are grouped by VD_VCODEC */
> -			power-domain@RK3588_PD_VCODEC {
> -				reg = <RK3588_PD_VCODEC>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#power-domain-cells = <0>;
> -
> -				power-domain@RK3588_PD_RKVDEC0 {
> -					reg = <RK3588_PD_RKVDEC0>;
> -					clocks = <&cru HCLK_RKVDEC0>,
> -						 <&cru HCLK_VDPU_ROOT>,
> -						 <&cru ACLK_VDPU_ROOT>,
> -						 <&cru ACLK_RKVDEC0>,
> -						 <&cru ACLK_RKVDEC_CCU>;
> -					pm_qos = <&qos_rkvdec0>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_RKVDEC1 {
> -					reg = <RK3588_PD_RKVDEC1>;
> -					clocks = <&cru HCLK_RKVDEC1>,
> -						 <&cru HCLK_VDPU_ROOT>,
> -						 <&cru ACLK_VDPU_ROOT>,
> -						 <&cru ACLK_RKVDEC1>;
> -					pm_qos = <&qos_rkvdec1>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_VENC0 {
> -					reg = <RK3588_PD_VENC0>;
> -					clocks = <&cru HCLK_RKVENC0>,
> -						 <&cru ACLK_RKVENC0>;
> -					pm_qos = <&qos_rkvenc0_m0ro>,
> -						 <&qos_rkvenc0_m1ro>,
> -						 <&qos_rkvenc0_m2wo>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -					#power-domain-cells = <0>;
> -
> -					power-domain@RK3588_PD_VENC1 {
> -						reg = <RK3588_PD_VENC1>;
> -						clocks = <&cru HCLK_RKVENC1>,
> -							 <&cru HCLK_RKVENC0>,
> -							 <&cru ACLK_RKVENC0>,
> -							 <&cru ACLK_RKVENC1>;
> -						pm_qos = <&qos_rkvenc1_m0ro>,
> -							 <&qos_rkvenc1_m1ro>,
> -							 <&qos_rkvenc1_m2wo>;
> -						#power-domain-cells = <0>;
> -					};
> -				};
> -			};
> -			/* These power domains are grouped by VD_LOGIC */
> -			power-domain@RK3588_PD_VDPU {
> -				reg = <RK3588_PD_VDPU>;
> -				clocks = <&cru HCLK_VDPU_ROOT>,
> -					 <&cru ACLK_VDPU_LOW_ROOT>,
> -					 <&cru ACLK_VDPU_ROOT>,
> -					 <&cru ACLK_JPEG_DECODER_ROOT>,
> -					 <&cru ACLK_IEP2P0>,
> -					 <&cru HCLK_IEP2P0>,
> -					 <&cru ACLK_JPEG_ENCODER0>,
> -					 <&cru HCLK_JPEG_ENCODER0>,
> -					 <&cru ACLK_JPEG_ENCODER1>,
> -					 <&cru HCLK_JPEG_ENCODER1>,
> -					 <&cru ACLK_JPEG_ENCODER2>,
> -					 <&cru HCLK_JPEG_ENCODER2>,
> -					 <&cru ACLK_JPEG_ENCODER3>,
> -					 <&cru HCLK_JPEG_ENCODER3>,
> -					 <&cru ACLK_JPEG_DECODER>,
> -					 <&cru HCLK_JPEG_DECODER>,
> -					 <&cru ACLK_RGA2>,
> -					 <&cru HCLK_RGA2>;
> -				pm_qos = <&qos_iep>,
> -					 <&qos_jpeg_dec>,
> -					 <&qos_jpeg_enc0>,
> -					 <&qos_jpeg_enc1>,
> -					 <&qos_jpeg_enc2>,
> -					 <&qos_jpeg_enc3>,
> -					 <&qos_rga2_mro>,
> -					 <&qos_rga2_mwo>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#power-domain-cells = <0>;
> -
> -
> -				power-domain@RK3588_PD_AV1 {
> -					reg = <RK3588_PD_AV1>;
> -					clocks = <&cru PCLK_AV1>,
> -						 <&cru ACLK_AV1>,
> -						 <&cru HCLK_VDPU_ROOT>;
> -					pm_qos = <&qos_av1>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_RKVDEC0 {
> -					reg = <RK3588_PD_RKVDEC0>;
> -					clocks = <&cru HCLK_RKVDEC0>,
> -						 <&cru HCLK_VDPU_ROOT>,
> -						 <&cru ACLK_VDPU_ROOT>,
> -						 <&cru ACLK_RKVDEC0>;
> -					pm_qos = <&qos_rkvdec0>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_RKVDEC1 {
> -					reg = <RK3588_PD_RKVDEC1>;
> -					clocks = <&cru HCLK_RKVDEC1>,
> -						 <&cru HCLK_VDPU_ROOT>,
> -						 <&cru ACLK_VDPU_ROOT>;
> -					pm_qos = <&qos_rkvdec1>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_RGA30 {
> -					reg = <RK3588_PD_RGA30>;
> -					clocks = <&cru ACLK_RGA3_0>,
> -						 <&cru HCLK_RGA3_0>;
> -					pm_qos = <&qos_rga3_0>;
> -					#power-domain-cells = <0>;
> -				};
> -			};
> -			power-domain@RK3588_PD_VOP {
> -				reg = <RK3588_PD_VOP>;
> -				clocks = <&cru PCLK_VOP_ROOT>,
> -					 <&cru HCLK_VOP_ROOT>,
> -					 <&cru ACLK_VOP>;
> -				pm_qos = <&qos_vop_m0>,
> -					 <&qos_vop_m1>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#power-domain-cells = <0>;
> -
> -				power-domain@RK3588_PD_VO0 {
> -					reg = <RK3588_PD_VO0>;
> -					clocks = <&cru PCLK_VO0_ROOT>,
> -						 <&cru PCLK_VO0_S_ROOT>,
> -						 <&cru HCLK_VO0_S_ROOT>,
> -						 <&cru ACLK_VO0_ROOT>,
> -						 <&cru HCLK_HDCP0>,
> -						 <&cru ACLK_HDCP0>,
> -						 <&cru HCLK_VOP_ROOT>;
> -					pm_qos = <&qos_hdcp0>;
> -					#power-domain-cells = <0>;
> -				};
> -			};
> -			power-domain@RK3588_PD_VO1 {
> -				reg = <RK3588_PD_VO1>;
> -				clocks = <&cru PCLK_VO1_ROOT>,
> -					 <&cru PCLK_VO1_S_ROOT>,
> -					 <&cru HCLK_VO1_S_ROOT>,
> -					 <&cru HCLK_HDCP1>,
> -					 <&cru ACLK_HDCP1>,
> -					 <&cru ACLK_HDMIRX_ROOT>,
> -					 <&cru HCLK_VO1USB_TOP_ROOT>;
> -				pm_qos = <&qos_hdcp1>,
> -					 <&qos_hdmirx>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_VI {
> -				reg = <RK3588_PD_VI>;
> -				clocks = <&cru HCLK_VI_ROOT>,
> -					 <&cru PCLK_VI_ROOT>,
> -					 <&cru HCLK_ISP0>,
> -					 <&cru ACLK_ISP0>,
> -					 <&cru HCLK_VICAP>,
> -					 <&cru ACLK_VICAP>;
> -				pm_qos = <&qos_isp0_mro>,
> -					 <&qos_isp0_mwo>,
> -					 <&qos_vicap_m0>,
> -					 <&qos_vicap_m1>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#power-domain-cells = <0>;
> -
> -				power-domain@RK3588_PD_ISP1 {
> -					reg = <RK3588_PD_ISP1>;
> -					clocks = <&cru HCLK_ISP1>,
> -						 <&cru ACLK_ISP1>,
> -						 <&cru HCLK_VI_ROOT>,
> -						 <&cru PCLK_VI_ROOT>;
> -					pm_qos = <&qos_isp1_mwo>,
> -						 <&qos_isp1_mro>;
> -					#power-domain-cells = <0>;
> -				};
> -				power-domain@RK3588_PD_FEC {
> -					reg = <RK3588_PD_FEC>;
> -					clocks = <&cru HCLK_FISHEYE0>,
> -						 <&cru ACLK_FISHEYE0>,
> -						 <&cru HCLK_FISHEYE1>,
> -						 <&cru ACLK_FISHEYE1>,
> -						 <&cru PCLK_VI_ROOT>;
> -					pm_qos = <&qos_fisheye0>,
> -						 <&qos_fisheye1>;
> -					#power-domain-cells = <0>;
> -				};
> -			};
> -			power-domain@RK3588_PD_RGA31 {
> -				reg = <RK3588_PD_RGA31>;
> -				clocks = <&cru HCLK_RGA3_1>,
> -					 <&cru ACLK_RGA3_1>;
> -				pm_qos = <&qos_rga3_1>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_USB {
> -				reg = <RK3588_PD_USB>;
> -				clocks = <&cru PCLK_PHP_ROOT>,
> -					 <&cru ACLK_USB_ROOT>,
> -					 <&cru ACLK_USB>,
> -					 <&cru HCLK_USB_ROOT>,
> -					 <&cru HCLK_HOST0>,
> -					 <&cru HCLK_HOST_ARB0>,
> -					 <&cru HCLK_HOST1>,
> -					 <&cru HCLK_HOST_ARB1>;
> -				pm_qos = <&qos_usb3_0>,
> -					 <&qos_usb3_1>,
> -					 <&qos_usb2host_0>,
> -					 <&qos_usb2host_1>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_GMAC {
> -				reg = <RK3588_PD_GMAC>;
> -				clocks = <&cru PCLK_PHP_ROOT>,
> -					 <&cru ACLK_PCIE_ROOT>,
> -					 <&cru ACLK_PHP_ROOT>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_PCIE {
> -				reg = <RK3588_PD_PCIE>;
> -				clocks = <&cru PCLK_PHP_ROOT>,
> -					 <&cru ACLK_PCIE_ROOT>,
> -					 <&cru ACLK_PHP_ROOT>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_SDIO {
> -				reg = <RK3588_PD_SDIO>;
> -				clocks = <&cru HCLK_SDIO>,
> -					 <&cru HCLK_NVM_ROOT>;
> -				pm_qos = <&qos_sdio>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_AUDIO {
> -				reg = <RK3588_PD_AUDIO>;
> -				clocks = <&cru HCLK_AUDIO_ROOT>,
> -					 <&cru PCLK_AUDIO_ROOT>;
> -				#power-domain-cells = <0>;
> -			};
> -			power-domain@RK3588_PD_SDMMC {
> -				reg = <RK3588_PD_SDMMC>;
> -				pm_qos = <&qos_sdmmc>;
> -				#power-domain-cells = <0>;
> -			};
> -		};
> -	};
> -
> -	i2s4_8ch: i2s@fddc0000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddc0000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S4_8CH_TX>, <&cru MCLK_I2S4_8CH_TX>, <&cru HCLK_I2S4_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S4_8CH_TX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 0>;
> -		dma-names = "tx";
> -		power-domains = <&power RK3588_PD_VO0>;
> -		resets = <&cru SRST_M_I2S4_8CH_TX>;
> -		reset-names = "tx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s5_8ch: i2s@fddf0000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddf0000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S5_8CH_TX>, <&cru MCLK_I2S5_8CH_TX>, <&cru HCLK_I2S5_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S5_8CH_TX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 2>;
> -		dma-names = "tx";
> -		power-domains = <&power RK3588_PD_VO1>;
> -		resets = <&cru SRST_M_I2S5_8CH_TX>;
> -		reset-names = "tx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s9_8ch: i2s@fddfc000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfddfc000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S9_8CH_RX>, <&cru MCLK_I2S9_8CH_RX>, <&cru HCLK_I2S9_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S9_8CH_RX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac2 23>;
> -		dma-names = "rx";
> -		power-domains = <&power RK3588_PD_VO1>;
> -		resets = <&cru SRST_M_I2S9_8CH_RX>;
> -		reset-names = "rx-m";
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	qos_gpu_m0: qos@fdf35000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf35000 0x0 0x20>;
> -	};
> -
> -	qos_gpu_m1: qos@fdf35200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf35200 0x0 0x20>;
> -	};
> -
> -	qos_gpu_m2: qos@fdf35400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf35400 0x0 0x20>;
> -	};
> -
> -	qos_gpu_m3: qos@fdf35600 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf35600 0x0 0x20>;
> -	};
> -
> -	qos_rga3_1: qos@fdf36000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf36000 0x0 0x20>;
> -	};
> -
> -	qos_sdio: qos@fdf39000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf39000 0x0 0x20>;
> -	};
> -
> -	qos_sdmmc: qos@fdf3d800 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf3d800 0x0 0x20>;
> -	};
> -
> -	qos_usb3_1: qos@fdf3e000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf3e000 0x0 0x20>;
> -	};
> -
> -	qos_usb3_0: qos@fdf3e200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf3e200 0x0 0x20>;
> -	};
> -
> -	qos_usb2host_0: qos@fdf3e400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf3e400 0x0 0x20>;
> -	};
> -
> -	qos_usb2host_1: qos@fdf3e600 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf3e600 0x0 0x20>;
> -	};
> -
> -	qos_fisheye0: qos@fdf40000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40000 0x0 0x20>;
> -	};
> -
> -	qos_fisheye1: qos@fdf40200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40200 0x0 0x20>;
> -	};
> -
> -	qos_isp0_mro: qos@fdf40400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40400 0x0 0x20>;
> -	};
> -
> -	qos_isp0_mwo: qos@fdf40500 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40500 0x0 0x20>;
> -	};
> -
> -	qos_vicap_m0: qos@fdf40600 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40600 0x0 0x20>;
> -	};
> -
> -	qos_vicap_m1: qos@fdf40800 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf40800 0x0 0x20>;
> -	};
> -
> -	qos_isp1_mwo: qos@fdf41000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf41000 0x0 0x20>;
> -	};
> -
> -	qos_isp1_mro: qos@fdf41100 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf41100 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc0_m0ro: qos@fdf60000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf60000 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc0_m1ro: qos@fdf60200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf60200 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc0_m2wo: qos@fdf60400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf60400 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc1_m0ro: qos@fdf61000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf61000 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc1_m1ro: qos@fdf61200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf61200 0x0 0x20>;
> -	};
> -
> -	qos_rkvenc1_m2wo: qos@fdf61400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf61400 0x0 0x20>;
> -	};
> -
> -	qos_rkvdec0: qos@fdf62000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf62000 0x0 0x20>;
> -	};
> -
> -	qos_rkvdec1: qos@fdf63000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf63000 0x0 0x20>;
> -	};
> -
> -	qos_av1: qos@fdf64000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf64000 0x0 0x20>;
> -	};
> -
> -	qos_iep: qos@fdf66000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66000 0x0 0x20>;
> -	};
> -
> -	qos_jpeg_dec: qos@fdf66200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66200 0x0 0x20>;
> -	};
> -
> -	qos_jpeg_enc0: qos@fdf66400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66400 0x0 0x20>;
> -	};
> -
> -	qos_jpeg_enc1: qos@fdf66600 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66600 0x0 0x20>;
> -	};
> -
> -	qos_jpeg_enc2: qos@fdf66800 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66800 0x0 0x20>;
> -	};
> -
> -	qos_jpeg_enc3: qos@fdf66a00 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66a00 0x0 0x20>;
> -	};
> -
> -	qos_rga2_mro: qos@fdf66c00 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66c00 0x0 0x20>;
> -	};
> -
> -	qos_rga2_mwo: qos@fdf66e00 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf66e00 0x0 0x20>;
> -	};
> -
> -	qos_rga3_0: qos@fdf67000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf67000 0x0 0x20>;
> -	};
> -
> -	qos_vdpu: qos@fdf67200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf67200 0x0 0x20>;
> -	};
> -
> -	qos_npu1: qos@fdf70000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf70000 0x0 0x20>;
> -	};
> -
> -	qos_npu2: qos@fdf71000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf71000 0x0 0x20>;
> -	};
> -
> -	qos_npu0_mwr: qos@fdf72000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf72000 0x0 0x20>;
> -	};
> -
> -	qos_npu0_mro: qos@fdf72200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf72200 0x0 0x20>;
> -	};
> -
> -	qos_mcu_npu: qos@fdf72400 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf72400 0x0 0x20>;
> -	};
> -
> -	qos_hdcp0: qos@fdf80000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf80000 0x0 0x20>;
> -	};
> -
> -	qos_hdcp1: qos@fdf81000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf81000 0x0 0x20>;
> -	};
> -
> -	qos_hdmirx: qos@fdf81200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf81200 0x0 0x20>;
> -	};
> -
> -	qos_vop_m0: qos@fdf82000 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf82000 0x0 0x20>;
> -	};
> -
> -	qos_vop_m1: qos@fdf82200 {
> -		compatible = "rockchip,rk3588-qos", "syscon";
> -		reg = <0x0 0xfdf82200 0x0 0x20>;
> -	};
> -
> -	pcie2x1l1: pcie@fe180000 {
> -		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> -		bus-range = <0x30 0x3f>;
> -		clocks = <&cru ACLK_PCIE_1L1_MSTR>, <&cru ACLK_PCIE_1L1_SLV>,
> -			 <&cru ACLK_PCIE_1L1_DBI>, <&cru PCLK_PCIE_1L1>,
> -			 <&cru CLK_PCIE_AUX3>, <&cru CLK_PCIE1L1_PIPE>;
> -		clock-names = "aclk_mst", "aclk_slv",
> -			      "aclk_dbi", "pclk",
> -			      "aux", "pipe";
> -		device_type = "pci";
> -		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie2x1l1_intc 0>,
> -				<0 0 0 2 &pcie2x1l1_intc 1>,
> -				<0 0 0 3 &pcie2x1l1_intc 2>,
> -				<0 0 0 4 &pcie2x1l1_intc 3>;
> -		linux,pci-domain = <3>;
> -		max-link-speed = <2>;
> -		msi-map = <0x3000 &its0 0x3000 0x1000>;
> -		num-lanes = <1>;
> -		phys = <&combphy2_psu PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy";
> -		power-domains = <&power RK3588_PD_PCIE>;
> -		ranges = <0x01000000 0x0 0xf3100000 0x0 0xf3100000 0x0 0x00100000>,
> -			 <0x02000000 0x0 0xf3200000 0x0 0xf3200000 0x0 0x00e00000>,
> -			 <0x03000000 0x0 0x40000000 0x9 0xc0000000 0x0 0x40000000>;
> -		reg = <0xa 0x40c00000 0x0 0x00400000>,
> -		      <0x0 0xfe180000 0x0 0x00010000>,
> -		      <0x0 0xf3000000 0x0 0x00100000>;
> -		reg-names = "dbi", "apb", "config";
> -		resets = <&cru SRST_PCIE3_POWER_UP>, <&cru SRST_P_PCIE3>;
> -		reset-names = "pwr", "pipe";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		status = "disabled";
> -
> -		pcie2x1l1_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 245 IRQ_TYPE_EDGE_RISING 0>;
> -		};
> -	};
> -
> -	pcie2x1l2: pcie@fe190000 {
> -		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> -		bus-range = <0x40 0x4f>;
> -		clocks = <&cru ACLK_PCIE_1L2_MSTR>, <&cru ACLK_PCIE_1L2_SLV>,
> -			 <&cru ACLK_PCIE_1L2_DBI>, <&cru PCLK_PCIE_1L2>,
> -			 <&cru CLK_PCIE_AUX4>, <&cru CLK_PCIE1L2_PIPE>;
> -		clock-names = "aclk_mst", "aclk_slv",
> -			      "aclk_dbi", "pclk",
> -			      "aux", "pipe";
> -		device_type = "pci";
> -		interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> -		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie2x1l2_intc 0>,
> -				<0 0 0 2 &pcie2x1l2_intc 1>,
> -				<0 0 0 3 &pcie2x1l2_intc 2>,
> -				<0 0 0 4 &pcie2x1l2_intc 3>;
> -		linux,pci-domain = <4>;
> -		max-link-speed = <2>;
> -		msi-map = <0x4000 &its0 0x4000 0x1000>;
> -		num-lanes = <1>;
> -		phys = <&combphy0_ps PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy";
> -		power-domains = <&power RK3588_PD_PCIE>;
> -		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
> -			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x00e00000>,
> -			 <0x03000000 0x0 0x40000000 0xa 0x00000000 0x0 0x40000000>;
> -		reg = <0xa 0x41000000 0x0 0x00400000>,
> -		      <0x0 0xfe190000 0x0 0x00010000>,
> -		      <0x0 0xf4000000 0x0 0x00100000>;
> -		reg-names = "dbi", "apb", "config";
> -		resets = <&cru SRST_PCIE4_POWER_UP>, <&cru SRST_P_PCIE4>;
> -		reset-names = "pwr", "pipe";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		status = "disabled";
> -
> -		pcie2x1l2_intc: legacy-interrupt-controller {
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <1>;
> -			interrupt-parent = <&gic>;
> -			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING 0>;
> -		};
> -	};
> -
> -	dfi: dfi@fe060000 {
> -		reg = <0x00 0xfe060000 0x00 0x10000>;
> -		compatible = "rockchip,rk3588-dfi";
> -		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> -		rockchip,pmu = <&pmu1grf>;
> -	};
> -
> -	gmac1: ethernet@fe1c0000 {
> -		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
> -		reg = <0x0 0xfe1c0000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "macirq", "eth_wake_irq";
> -		clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
> -			 <&cru PCLK_GMAC1>, <&cru ACLK_GMAC1>,
> -			 <&cru CLK_GMAC1_PTP_REF>;
> -		clock-names = "stmmaceth", "clk_mac_ref",
> -			      "pclk_mac", "aclk_mac",
> -			      "ptp_ref";
> -		power-domains = <&power RK3588_PD_GMAC>;
> -		resets = <&cru SRST_A_GMAC1>;
> -		reset-names = "stmmaceth";
> -		rockchip,grf = <&sys_grf>;
> -		rockchip,php-grf = <&php_grf>;
> -		snps,axi-config = <&gmac1_stmmac_axi_setup>;
> -		snps,mixed-burst;
> -		snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
> -		snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
> -		snps,tso;
> -		status = "disabled";
> -
> -		mdio1: mdio {
> -			compatible = "snps,dwmac-mdio";
> -			#address-cells = <0x1>;
> -			#size-cells = <0x0>;
> -		};
> -
> -		gmac1_stmmac_axi_setup: stmmac-axi-config {
> -			snps,blen = <0 0 0 0 16 8 4>;
> -			snps,wr_osr_lmt = <4>;
> -			snps,rd_osr_lmt = <8>;
> -		};
> -
> -		gmac1_mtl_rx_setup: rx-queues-config {
> -			snps,rx-queues-to-use = <2>;
> -			queue0 {};
> -			queue1 {};
> -		};
> -
> -		gmac1_mtl_tx_setup: tx-queues-config {
> -			snps,tx-queues-to-use = <2>;
> -			queue0 {};
> -			queue1 {};
> -		};
> -	};
> -
> -	sata0: sata@fe210000 {
> -		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
> -		reg = <0 0xfe210000 0 0x1000>;
> -		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_SATA0>, <&cru CLK_PMALIVE0>,
> -			 <&cru CLK_RXOOB0>, <&cru CLK_PIPEPHY0_REF>,
> -			 <&cru CLK_PIPEPHY0_PIPE_ASIC_G>;
> -		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
> -		ports-implemented = <0x1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		sata-port@0 {
> -			reg = <0>;
> -			hba-port-cap = <HBA_PORT_FBSCP>;
> -			phys = <&combphy0_ps PHY_TYPE_SATA>;
> -			phy-names = "sata-phy";
> -			snps,rx-ts-max = <32>;
> -			snps,tx-ts-max = <32>;
> -		};
> -	};
> -
> -	sata2: sata@fe230000 {
> -		compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
> -		reg = <0 0xfe230000 0 0x1000>;
> -		interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru ACLK_SATA2>, <&cru CLK_PMALIVE2>,
> -			 <&cru CLK_RXOOB2>, <&cru CLK_PIPEPHY2_REF>,
> -			 <&cru CLK_PIPEPHY2_PIPE_ASIC_G>;
> -		clock-names = "sata", "pmalive", "rxoob", "ref", "asic";
> -		ports-implemented = <0x1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		sata-port@0 {
> -			reg = <0>;
> -			hba-port-cap = <HBA_PORT_FBSCP>;
> -			phys = <&combphy2_psu PHY_TYPE_SATA>;
> -			phy-names = "sata-phy";
> -			snps,rx-ts-max = <32>;
> -			snps,tx-ts-max = <32>;
> -		};
> -	};
> -
> -	sfc: spi@fe2b0000 {
> -		compatible = "rockchip,sfc";
> -		reg = <0x0 0xfe2b0000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> -		clock-names = "clk_sfc", "hclk_sfc";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	sdmmc: mmc@fe2c0000 {
> -		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
> -		reg = <0x0 0xfe2c0000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&scmi_clk SCMI_HCLK_SD>, <&scmi_clk SCMI_CCLK_SD>,
> -			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> -		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth = <0x100>;
> -		max-frequency = <200000000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_det &sdmmc_bus4>;
> -		power-domains = <&power RK3588_PD_SDMMC>;
> -		status = "disabled";
> -	};
> -
> -	sdio: mmc@fe2d0000 {
> -		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
> -		reg = <0x00 0xfe2d0000 0x00 0x4000>;
> -		interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru HCLK_SDIO>, <&cru CCLK_SRC_SDIO>,
> -			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> -		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> -		fifo-depth = <0x100>;
> -		max-frequency = <200000000>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdiom1_pins>;
> -		power-domains = <&power RK3588_PD_SDIO>;
> -		status = "disabled";
> -	};
> -
> -	sdhci: mmc@fe2e0000 {
> -		compatible = "rockchip,rk3588-dwcmshc";
> -		reg = <0x0 0xfe2e0000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH 0>;
> -		assigned-clocks = <&cru BCLK_EMMC>, <&cru TMCLK_EMMC>, <&cru CCLK_EMMC>;
> -		assigned-clock-rates = <200000000>, <24000000>, <200000000>;
> -		clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
> -			 <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
> -			 <&cru TMCLK_EMMC>;
> -		clock-names = "core", "bus", "axi", "block", "timer";
> -		max-frequency = <200000000>;
> -		pinctrl-0 = <&emmc_rstnout>, <&emmc_bus8>, <&emmc_clk>,
> -			    <&emmc_cmd>, <&emmc_data_strobe>;
> -		pinctrl-names = "default";
> -		resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
> -			 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
> -			 <&cru SRST_T_EMMC>;
> -		reset-names = "core", "bus", "axi", "block", "timer";
> -		status = "disabled";
> -	};
> -
> -	i2s0_8ch: i2s@fe470000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfe470000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>, <&cru PLL_AUPLL>;
> -		dmas = <&dmac0 0>, <&dmac0 1>;
> -		dma-names = "tx", "rx";
> -		power-domains = <&power RK3588_PD_AUDIO>;
> -		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
> -		reset-names = "tx-m", "rx-m";
> -		rockchip,trcm-sync-tx-only;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s0_lrck
> -			     &i2s0_sclk
> -			     &i2s0_sdi0
> -			     &i2s0_sdi1
> -			     &i2s0_sdi2
> -			     &i2s0_sdi3
> -			     &i2s0_sdo0
> -			     &i2s0_sdo1
> -			     &i2s0_sdo2
> -			     &i2s0_sdo3>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s1_8ch: i2s@fe480000 {
> -		compatible = "rockchip,rk3588-i2s-tdm";
> -		reg = <0x0 0xfe480000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>, <&cru HCLK_I2S1_8CH>;
> -		clock-names = "mclk_tx", "mclk_rx", "hclk";
> -		dmas = <&dmac0 2>, <&dmac0 3>;
> -		dma-names = "tx", "rx";
> -		resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
> -		reset-names = "tx-m", "rx-m";
> -		rockchip,trcm-sync-tx-only;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s1m0_lrck
> -			     &i2s1m0_sclk
> -			     &i2s1m0_sdi0
> -			     &i2s1m0_sdi1
> -			     &i2s1m0_sdi2
> -			     &i2s1m0_sdi3
> -			     &i2s1m0_sdo0
> -			     &i2s1m0_sdo1
> -			     &i2s1m0_sdo2
> -			     &i2s1m0_sdo3>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s2_2ch: i2s@fe490000 {
> -		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x0 0xfe490000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S2_2CH>, <&cru HCLK_I2S2_2CH>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		assigned-clocks = <&cru CLK_I2S2_2CH_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac1 0>, <&dmac1 1>;
> -		dma-names = "tx", "rx";
> -		power-domains = <&power RK3588_PD_AUDIO>;
> -		rockchip,trcm-sync-tx-only;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s2m1_lrck
> -			     &i2s2m1_sclk
> -			     &i2s2m1_sdi
> -			     &i2s2m1_sdo>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s3_2ch: i2s@fe4a0000 {
> -		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x0 0xfe4a0000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru MCLK_I2S3_2CH>, <&cru HCLK_I2S3_2CH>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		assigned-clocks = <&cru CLK_I2S3_2CH_SRC>;
> -		assigned-clock-parents = <&cru PLL_AUPLL>;
> -		dmas = <&dmac1 2>, <&dmac1 3>;
> -		dma-names = "tx", "rx";
> -		power-domains = <&power RK3588_PD_AUDIO>;
> -		rockchip,trcm-sync-tx-only;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s3_lrck
> -			     &i2s3_sclk
> -			     &i2s3_sdi
> -			     &i2s3_sdo>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	gic: interrupt-controller@fe600000 {
> -		compatible = "arm,gic-v3";
> -		reg = <0x0 0xfe600000 0 0x10000>, /* GICD */
> -		      <0x0 0xfe680000 0 0x100000>; /* GICR */
> -		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-controller;
> -		mbi-alias = <0x0 0xfe610000>;
> -		mbi-ranges = <424 56>;
> -		msi-controller;
> -		ranges;
> -		#address-cells = <2>;
> -		#interrupt-cells = <4>;
> -		#size-cells = <2>;
> -
> -		its0: msi-controller@fe640000 {
> -			compatible = "arm,gic-v3-its";
> -			reg = <0x0 0xfe640000 0x0 0x20000>;
> -			msi-controller;
> -			#msi-cells = <1>;
> -		};
> -
> -		its1: msi-controller@fe660000 {
> -			compatible = "arm,gic-v3-its";
> -			reg = <0x0 0xfe660000 0x0 0x20000>;
> -			msi-controller;
> -			#msi-cells = <1>;
> -		};
> -
> -		ppi-partitions {
> -			ppi_partition0: interrupt-partition-0 {
> -				affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
> -			};
> -
> -			ppi_partition1: interrupt-partition-1 {
> -				affinity = <&cpu_b0 &cpu_b1 &cpu_b2 &cpu_b3>;
> -			};
> -		};
> -	};
> -
> -	dmac0: dma-controller@fea10000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x0 0xfea10000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH 0>;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMAC0>;
> -		clock-names = "apb_pclk";
> -		#dma-cells = <1>;
> -	};
> -
> -	dmac1: dma-controller@fea30000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x0 0xfea30000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH 0>;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMAC1>;
> -		clock-names = "apb_pclk";
> -		#dma-cells = <1>;
> -	};
> -
> -	i2c1: i2c@fea90000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfea90000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c1m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c2: i2c@feaa0000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfeaa0000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C2>, <&cru PCLK_I2C2>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c2m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c3: i2c@feab0000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfeab0000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c3m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c4: i2c@feac0000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfeac0000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C4>, <&cru PCLK_I2C4>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c4m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c5: i2c@fead0000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfead0000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c5m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	timer0: timer@feae0000 {
> -		compatible = "rockchip,rk3588-timer", "rockchip,rk3288-timer";
> -		reg = <0x0 0xfeae0000 0x0 0x20>;
> -		interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru PCLK_BUSTIMER0>, <&cru CLK_BUSTIMER0>;
> -		clock-names = "pclk", "timer";
> -	};
> -
> -	wdt: watchdog@feaf0000 {
> -		compatible = "rockchip,rk3588-wdt", "snps,dw-wdt";
> -		reg = <0x0 0xfeaf0000 0x0 0x100>;
> -		clocks = <&cru TCLK_WDT0>, <&cru PCLK_WDT0>;
> -		clock-names = "tclk", "pclk";
> -		interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH 0>;
> -	};
> -
> -	spi0: spi@feb00000 {
> -		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xfeb00000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names = "spiclk", "apb_pclk";
> -		dmas = <&dmac0 14>, <&dmac0 15>;
> -		dma-names = "tx", "rx";
> -		num-cs = <2>;
> -		pinctrl-0 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi1: spi@feb10000 {
> -		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xfeb10000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
> -		clock-names = "spiclk", "apb_pclk";
> -		dmas = <&dmac0 16>, <&dmac0 17>;
> -		dma-names = "tx", "rx";
> -		num-cs = <2>;
> -		pinctrl-0 = <&spi1m1_cs0 &spi1m1_cs1 &spi1m1_pins>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi2: spi@feb20000 {
> -		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xfeb20000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_SPI2>, <&cru PCLK_SPI2>;
> -		clock-names = "spiclk", "apb_pclk";
> -		dmas = <&dmac1 15>, <&dmac1 16>;
> -		dma-names = "tx", "rx";
> -		num-cs = <2>;
> -		pinctrl-0 = <&spi2m2_cs0 &spi2m2_cs1 &spi2m2_pins>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi3: spi@feb30000 {
> -		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xfeb30000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_SPI3>, <&cru PCLK_SPI3>;
> -		clock-names = "spiclk", "apb_pclk";
> -		dmas = <&dmac1 17>, <&dmac1 18>;
> -		dma-names = "tx", "rx";
> -		num-cs = <2>;
> -		pinctrl-0 = <&spi3m1_cs0 &spi3m1_cs1 &spi3m1_pins>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	uart1: serial@feb40000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb40000 0x0 0x100>;
> -		interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac0 8>, <&dmac0 9>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart1m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart2: serial@feb50000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb50000 0x0 0x100>;
> -		interrupts = <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac0 10>, <&dmac0 11>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart2m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart3: serial@feb60000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb60000 0x0 0x100>;
> -		interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac0 12>, <&dmac0 13>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart3m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart4: serial@feb70000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb70000 0x0 0x100>;
> -		interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART4>, <&cru PCLK_UART4>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac1 9>, <&dmac1 10>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart4m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart5: serial@feb80000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb80000 0x0 0x100>;
> -		interrupts = <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART5>, <&cru PCLK_UART5>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac1 11>, <&dmac1 12>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart5m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart6: serial@feb90000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeb90000 0x0 0x100>;
> -		interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART6>, <&cru PCLK_UART6>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac1 13>, <&dmac1 14>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart6m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart7: serial@feba0000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfeba0000 0x0 0x100>;
> -		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART7>, <&cru PCLK_UART7>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac2 7>, <&dmac2 8>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart7m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart8: serial@febb0000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfebb0000 0x0 0x100>;
> -		interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART8>, <&cru PCLK_UART8>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac2 9>, <&dmac2 10>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart8m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	uart9: serial@febc0000 {
> -		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
> -		reg = <0x0 0xfebc0000 0x0 0x100>;
> -		interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_UART9>, <&cru PCLK_UART9>;
> -		clock-names = "baudclk", "apb_pclk";
> -		dmas = <&dmac2 11>, <&dmac2 12>;
> -		dma-names = "tx", "rx";
> -		pinctrl-0 = <&uart9m1_xfer>;
> -		pinctrl-names = "default";
> -		reg-io-width = <4>;
> -		reg-shift = <2>;
> -		status = "disabled";
> -	};
> -
> -	pwm4: pwm@febd0000 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebd0000 0x0 0x10>;
> -		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm4m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm5: pwm@febd0010 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebd0010 0x0 0x10>;
> -		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm5m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm6: pwm@febd0020 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebd0020 0x0 0x10>;
> -		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm6m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm7: pwm@febd0030 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebd0030 0x0 0x10>;
> -		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm7m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm8: pwm@febe0000 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebe0000 0x0 0x10>;
> -		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm8m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm9: pwm@febe0010 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebe0010 0x0 0x10>;
> -		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm9m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm10: pwm@febe0020 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebe0020 0x0 0x10>;
> -		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm10m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm11: pwm@febe0030 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebe0030 0x0 0x10>;
> -		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm11m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm12: pwm@febf0000 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebf0000 0x0 0x10>;
> -		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm12m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm13: pwm@febf0010 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebf0010 0x0 0x10>;
> -		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm13m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm14: pwm@febf0020 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebf0020 0x0 0x10>;
> -		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm14m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	pwm15: pwm@febf0030 {
> -		compatible = "rockchip,rk3588-pwm", "rockchip,rk3328-pwm";
> -		reg = <0x0 0xfebf0030 0x0 0x10>;
> -		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
> -		clock-names = "pwm", "pclk";
> -		pinctrl-0 = <&pwm15m0_pins>;
> -		pinctrl-names = "default";
> -		#pwm-cells = <3>;
> -		status = "disabled";
> -	};
> -
> -	tsadc: tsadc@fec00000 {
> -		compatible = "rockchip,rk3588-tsadc";
> -		reg = <0x0 0xfec00000 0x0 0x400>;
> -		interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
> -		clock-names = "tsadc", "apb_pclk";
> -		assigned-clocks = <&cru CLK_TSADC>;
> -		assigned-clock-rates = <2000000>;
> -		resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>;
> -		reset-names = "tsadc-apb", "tsadc";
> -		rockchip,hw-tshut-temp = <120000>;
> -		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
> -		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
> -		pinctrl-0 = <&tsadc_gpio_func>;
> -		pinctrl-1 = <&tsadc_shut>;
> -		pinctrl-names = "gpio", "otpout";
> -		#thermal-sensor-cells = <1>;
> -		status = "disabled";
> -	};
> -
> -	saradc: adc@fec10000 {
> -		compatible = "rockchip,rk3588-saradc";
> -		reg = <0x0 0xfec10000 0x0 0x10000>;
> -		interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH 0>;
> -		#io-channel-cells = <1>;
> -		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
> -		clock-names = "saradc", "apb_pclk";
> -		resets = <&cru SRST_P_SARADC>;
> -		reset-names = "saradc-apb";
> -		status = "disabled";
> -	};
> -
> -	i2c6: i2c@fec80000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfec80000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C6>, <&cru PCLK_I2C6>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c6m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c7: i2c@fec90000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfec90000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C7>, <&cru PCLK_I2C7>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c7m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2c8: i2c@feca0000 {
> -		compatible = "rockchip,rk3588-i2c", "rockchip,rk3399-i2c";
> -		reg = <0x0 0xfeca0000 0x0 0x1000>;
> -		clocks = <&cru CLK_I2C8>, <&cru PCLK_I2C8>;
> -		clock-names = "i2c", "pclk";
> -		interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH 0>;
> -		pinctrl-0 = <&i2c8m0_xfer>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spi4: spi@fecb0000 {
> -		compatible = "rockchip,rk3588-spi", "rockchip,rk3066-spi";
> -		reg = <0x0 0xfecb0000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru CLK_SPI4>, <&cru PCLK_SPI4>;
> -		clock-names = "spiclk", "apb_pclk";
> -		dmas = <&dmac2 13>, <&dmac2 14>;
> -		dma-names = "tx", "rx";
> -		num-cs = <2>;
> -		pinctrl-0 = <&spi4m0_cs0 &spi4m0_cs1 &spi4m0_pins>;
> -		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	otp: efuse@fecc0000 {
> -		compatible = "rockchip,rk3588-otp";
> -		reg = <0x0 0xfecc0000 0x0 0x400>;
> -		clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
> -			 <&cru CLK_OTP_PHY_G>, <&cru CLK_OTPC_ARB>;
> -		clock-names = "otp", "apb_pclk", "phy", "arb";
> -		resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>,
> -			 <&cru SRST_OTPC_ARB>;
> -		reset-names = "otp", "apb", "arb";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		cpu_code: cpu-code@2 {
> -			reg = <0x02 0x2>;
> -		};
> -
> -		otp_id: id@7 {
> -			reg = <0x07 0x10>;
> -		};
> -
> -		cpub0_leakage: cpu-leakage@17 {
> -			reg = <0x17 0x1>;
> -		};
> -
> -		cpub1_leakage: cpu-leakage@18 {
> -			reg = <0x18 0x1>;
> -		};
> -
> -		cpul_leakage: cpu-leakage@19 {
> -			reg = <0x19 0x1>;
> -		};
> -
> -		log_leakage: log-leakage@1a {
> -			reg = <0x1a 0x1>;
> -		};
> -
> -		gpu_leakage: gpu-leakage@1b {
> -			reg = <0x1b 0x1>;
> -		};
> -
> -		otp_cpu_version: cpu-version@1c {
> -			reg = <0x1c 0x1>;
> -			bits = <3 3>;
> -		};
> -
> -		npu_leakage: npu-leakage@28 {
> -			reg = <0x28 0x1>;
> -		};
> -
> -		codec_leakage: codec-leakage@29 {
> -			reg = <0x29 0x1>;
> -		};
> -	};
> -
> -	dmac2: dma-controller@fed10000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x0 0xfed10000 0x0 0x4000>;
> -		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH 0>;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMAC2>;
> -		clock-names = "apb_pclk";
> -		#dma-cells = <1>;
> -	};
> -
> -	combphy0_ps: phy@fee00000 {
> -		compatible = "rockchip,rk3588-naneng-combphy";
> -		reg = <0x0 0xfee00000 0x0 0x100>;
> -		clocks = <&cru CLK_REF_PIPE_PHY0>, <&cru PCLK_PCIE_COMBO_PIPE_PHY0>,
> -			 <&cru PCLK_PHP_ROOT>;
> -		clock-names = "ref", "apb", "pipe";
> -		assigned-clocks = <&cru CLK_REF_PIPE_PHY0>;
> -		assigned-clock-rates = <100000000>;
> -		#phy-cells = <1>;
> -		resets = <&cru SRST_REF_PIPE_PHY0>, <&cru SRST_P_PCIE2_PHY0>;
> -		reset-names = "phy", "apb";
> -		rockchip,pipe-grf = <&php_grf>;
> -		rockchip,pipe-phy-grf = <&pipe_phy0_grf>;
> -		status = "disabled";
> -	};
> -
> -	combphy2_psu: phy@fee20000 {
> -		compatible = "rockchip,rk3588-naneng-combphy";
> -		reg = <0x0 0xfee20000 0x0 0x100>;
> -		clocks = <&cru CLK_REF_PIPE_PHY2>, <&cru PCLK_PCIE_COMBO_PIPE_PHY2>,
> -			 <&cru PCLK_PHP_ROOT>;
> -		clock-names = "ref", "apb", "pipe";
> -		assigned-clocks = <&cru CLK_REF_PIPE_PHY2>;
> -		assigned-clock-rates = <100000000>;
> -		#phy-cells = <1>;
> -		resets = <&cru SRST_REF_PIPE_PHY2>, <&cru SRST_P_PCIE2_PHY2>;
> -		reset-names = "phy", "apb";
> -		rockchip,pipe-grf = <&php_grf>;
> -		rockchip,pipe-phy-grf = <&pipe_phy2_grf>;
> -		status = "disabled";
> -	};
> -
> -	system_sram2: sram@ff001000 {
> -		compatible = "mmio-sram";
> -		reg = <0x0 0xff001000 0x0 0xef000>;
> -		ranges = <0x0 0x0 0xff001000 0xef000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible = "rockchip,rk3588-pinctrl";
> -		ranges;
> -		rockchip,grf = <&ioc>;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -
> -		gpio0: gpio@fd8a0000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xfd8a0000 0x0 0x100>;
> -			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru PCLK_GPIO0>, <&cru DBCLK_GPIO0>;
> -			gpio-controller;
> -			gpio-ranges = <&pinctrl 0 0 32>;
> -			interrupt-controller;
> -			#gpio-cells = <2>;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio1: gpio@fec20000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xfec20000 0x0 0x100>;
> -			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
> -			gpio-controller;
> -			gpio-ranges = <&pinctrl 0 32 32>;
> -			interrupt-controller;
> -			#gpio-cells = <2>;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio2: gpio@fec30000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xfec30000 0x0 0x100>;
> -			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
> -			gpio-controller;
> -			gpio-ranges = <&pinctrl 0 64 32>;
> -			interrupt-controller;
> -			#gpio-cells = <2>;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio3: gpio@fec40000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xfec40000 0x0 0x100>;
> -			interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
> -			gpio-controller;
> -			gpio-ranges = <&pinctrl 0 96 32>;
> -			interrupt-controller;
> -			#gpio-cells = <2>;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio4: gpio@fec50000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x0 0xfec50000 0x0 0x100>;
> -			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
> -			gpio-controller;
> -			gpio-ranges = <&pinctrl 0 128 32>;
> -			interrupt-controller;
> -			#gpio-cells = <2>;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	av1d: video-codec@fdc70000 {
> -		compatible = "rockchip,rk3588-av1-vpu";
> -		reg = <0x0 0xfdc70000 0x0 0x800>;
> -		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "vdpu";
> -		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> -		assigned-clock-rates = <400000000>, <400000000>;
> -		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> -		clock-names = "aclk", "hclk";
> -		power-domains = <&power RK3588_PD_AV1>;
> -		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
> -	};
> -};
> -
> -#include "rk3588s-pinctrl.dtsi"
> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> deleted file mode 100644
> index b5616bca7b44..000000000000
> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> +++ /dev/null
> @@ -1,766 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
> - * Copyright (c) 2022 Collabora Ltd.
> - *
> - * Author: Elaine Zhang <zhangqing@rock-chips.com>
> - * Author: Sebastian Reichel <sebastian.reichel@collabora.com>
> - */
> -
> -#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3588_H
> -#define _DT_BINDINGS_CLK_ROCKCHIP_RK3588_H
> -
> -/* cru-clocks indices */
> -
> -#define PLL_B0PLL			0
> -#define PLL_B1PLL			1
> -#define PLL_LPLL			2
> -#define PLL_V0PLL			3
> -#define PLL_AUPLL			4
> -#define PLL_CPLL			5
> -#define PLL_GPLL			6
> -#define PLL_NPLL			7
> -#define PLL_PPLL			8
> -#define ARMCLK_L			9
> -#define ARMCLK_B01			10
> -#define ARMCLK_B23			11
> -#define PCLK_BIGCORE0_ROOT		12
> -#define PCLK_BIGCORE0_PVTM		13
> -#define PCLK_BIGCORE1_ROOT		14
> -#define PCLK_BIGCORE1_PVTM		15
> -#define PCLK_DSU_S_ROOT			16
> -#define PCLK_DSU_ROOT			17
> -#define PCLK_DSU_NS_ROOT		18
> -#define PCLK_LITCORE_PVTM		19
> -#define PCLK_DBG			20
> -#define PCLK_DSU			21
> -#define PCLK_S_DAPLITE			22
> -#define PCLK_M_DAPLITE			23
> -#define MBIST_MCLK_PDM1			24
> -#define MBIST_CLK_ACDCDIG		25
> -#define HCLK_I2S2_2CH			26
> -#define HCLK_I2S3_2CH			27
> -#define CLK_I2S2_2CH_SRC		28
> -#define CLK_I2S2_2CH_FRAC		29
> -#define CLK_I2S2_2CH			30
> -#define MCLK_I2S2_2CH			31
> -#define I2S2_2CH_MCLKOUT		32
> -#define CLK_DAC_ACDCDIG			33
> -#define CLK_I2S3_2CH_SRC		34
> -#define CLK_I2S3_2CH_FRAC		35
> -#define CLK_I2S3_2CH			36
> -#define MCLK_I2S3_2CH			37
> -#define I2S3_2CH_MCLKOUT		38
> -#define PCLK_ACDCDIG			39
> -#define HCLK_I2S0_8CH			40
> -#define CLK_I2S0_8CH_TX_SRC		41
> -#define CLK_I2S0_8CH_TX_FRAC		42
> -#define MCLK_I2S0_8CH_TX		43
> -#define CLK_I2S0_8CH_TX			44
> -#define CLK_I2S0_8CH_RX_SRC		45
> -#define CLK_I2S0_8CH_RX_FRAC		46
> -#define MCLK_I2S0_8CH_RX		47
> -#define CLK_I2S0_8CH_RX			48
> -#define I2S0_8CH_MCLKOUT		49
> -#define HCLK_PDM1			50
> -#define MCLK_PDM1			51
> -#define HCLK_AUDIO_ROOT			52
> -#define PCLK_AUDIO_ROOT			53
> -#define HCLK_SPDIF0			54
> -#define CLK_SPDIF0_SRC			55
> -#define CLK_SPDIF0_FRAC			56
> -#define MCLK_SPDIF0			57
> -#define CLK_SPDIF0			58
> -#define CLK_SPDIF1			59
> -#define HCLK_SPDIF1			60
> -#define CLK_SPDIF1_SRC			61
> -#define CLK_SPDIF1_FRAC			62
> -#define MCLK_SPDIF1			63
> -#define ACLK_AV1_ROOT			64
> -#define ACLK_AV1			65
> -#define PCLK_AV1_ROOT			66
> -#define PCLK_AV1			67
> -#define PCLK_MAILBOX0			68
> -#define PCLK_MAILBOX1			69
> -#define PCLK_MAILBOX2			70
> -#define PCLK_PMU2			71
> -#define PCLK_PMUCM0_INTMUX		72
> -#define PCLK_DDRCM0_INTMUX		73
> -#define PCLK_TOP			74
> -#define PCLK_PWM1			75
> -#define CLK_PWM1			76
> -#define CLK_PWM1_CAPTURE		77
> -#define PCLK_PWM2			78
> -#define CLK_PWM2			79
> -#define CLK_PWM2_CAPTURE		80
> -#define PCLK_PWM3			81
> -#define CLK_PWM3			82
> -#define CLK_PWM3_CAPTURE		83
> -#define PCLK_BUSTIMER0			84
> -#define PCLK_BUSTIMER1			85
> -#define CLK_BUS_TIMER_ROOT		86
> -#define CLK_BUSTIMER0			87
> -#define CLK_BUSTIMER1			88
> -#define CLK_BUSTIMER2			89
> -#define CLK_BUSTIMER3			90
> -#define CLK_BUSTIMER4			91
> -#define CLK_BUSTIMER5			92
> -#define CLK_BUSTIMER6			93
> -#define CLK_BUSTIMER7			94
> -#define CLK_BUSTIMER8			95
> -#define CLK_BUSTIMER9			96
> -#define CLK_BUSTIMER10			97
> -#define CLK_BUSTIMER11			98
> -#define PCLK_WDT0			99
> -#define TCLK_WDT0			100
> -#define PCLK_CAN0			101
> -#define CLK_CAN0			102
> -#define PCLK_CAN1			103
> -#define CLK_CAN1			104
> -#define PCLK_CAN2			105
> -#define CLK_CAN2			106
> -#define ACLK_DECOM			107
> -#define PCLK_DECOM			108
> -#define DCLK_DECOM			109
> -#define ACLK_DMAC0			110
> -#define ACLK_DMAC1			111
> -#define ACLK_DMAC2			112
> -#define ACLK_BUS_ROOT			113
> -#define ACLK_GIC			114
> -#define PCLK_GPIO1			115
> -#define DBCLK_GPIO1			116
> -#define PCLK_GPIO2			117
> -#define DBCLK_GPIO2			118
> -#define PCLK_GPIO3			119
> -#define DBCLK_GPIO3			120
> -#define PCLK_GPIO4			121
> -#define DBCLK_GPIO4			122
> -#define PCLK_I2C1			123
> -#define PCLK_I2C2			124
> -#define PCLK_I2C3			125
> -#define PCLK_I2C4			126
> -#define PCLK_I2C5			127
> -#define PCLK_I2C6			128
> -#define PCLK_I2C7			129
> -#define PCLK_I2C8			130
> -#define CLK_I2C1			131
> -#define CLK_I2C2			132
> -#define CLK_I2C3			133
> -#define CLK_I2C4			134
> -#define CLK_I2C5			135
> -#define CLK_I2C6			136
> -#define CLK_I2C7			137
> -#define CLK_I2C8			138
> -#define PCLK_OTPC_NS			139
> -#define CLK_OTPC_NS			140
> -#define CLK_OTPC_ARB			141
> -#define CLK_OTPC_AUTO_RD_G		142
> -#define CLK_OTP_PHY_G			143
> -#define PCLK_SARADC			144
> -#define CLK_SARADC			145
> -#define PCLK_SPI0			146
> -#define PCLK_SPI1			147
> -#define PCLK_SPI2			148
> -#define PCLK_SPI3			149
> -#define PCLK_SPI4			150
> -#define CLK_SPI0			151
> -#define CLK_SPI1			152
> -#define CLK_SPI2			153
> -#define CLK_SPI3			154
> -#define CLK_SPI4			155
> -#define ACLK_SPINLOCK			156
> -#define PCLK_TSADC			157
> -#define CLK_TSADC			158
> -#define PCLK_UART1			159
> -#define PCLK_UART2			160
> -#define PCLK_UART3			161
> -#define PCLK_UART4			162
> -#define PCLK_UART5			163
> -#define PCLK_UART6			164
> -#define PCLK_UART7			165
> -#define PCLK_UART8			166
> -#define PCLK_UART9			167
> -#define CLK_UART1_SRC			168
> -#define CLK_UART1_FRAC			169
> -#define CLK_UART1			170
> -#define SCLK_UART1			171
> -#define CLK_UART2_SRC			172
> -#define CLK_UART2_FRAC			173
> -#define CLK_UART2			174
> -#define SCLK_UART2			175
> -#define CLK_UART3_SRC			176
> -#define CLK_UART3_FRAC			177
> -#define CLK_UART3			178
> -#define SCLK_UART3			179
> -#define CLK_UART4_SRC			180
> -#define CLK_UART4_FRAC			181
> -#define CLK_UART4			182
> -#define SCLK_UART4			183
> -#define CLK_UART5_SRC			184
> -#define CLK_UART5_FRAC			185
> -#define CLK_UART5			186
> -#define SCLK_UART5			187
> -#define CLK_UART6_SRC			188
> -#define CLK_UART6_FRAC			189
> -#define CLK_UART6			190
> -#define SCLK_UART6			191
> -#define CLK_UART7_SRC			192
> -#define CLK_UART7_FRAC			193
> -#define CLK_UART7			194
> -#define SCLK_UART7			195
> -#define CLK_UART8_SRC			196
> -#define CLK_UART8_FRAC			197
> -#define CLK_UART8			198
> -#define SCLK_UART8			199
> -#define CLK_UART9_SRC			200
> -#define CLK_UART9_FRAC			201
> -#define CLK_UART9			202
> -#define SCLK_UART9			203
> -#define ACLK_CENTER_ROOT		204
> -#define ACLK_CENTER_LOW_ROOT		205
> -#define HCLK_CENTER_ROOT		206
> -#define PCLK_CENTER_ROOT		207
> -#define ACLK_DMA2DDR			208
> -#define ACLK_DDR_SHAREMEM		209
> -#define ACLK_CENTER_S200_ROOT		210
> -#define ACLK_CENTER_S400_ROOT		211
> -#define FCLK_DDR_CM0_CORE		212
> -#define CLK_DDR_TIMER_ROOT		213
> -#define CLK_DDR_TIMER0			214
> -#define CLK_DDR_TIMER1			215
> -#define TCLK_WDT_DDR			216
> -#define CLK_DDR_CM0_RTC			217
> -#define PCLK_WDT			218
> -#define PCLK_TIMER			219
> -#define PCLK_DMA2DDR			220
> -#define PCLK_SHAREMEM			221
> -#define CLK_50M_SRC			222
> -#define CLK_100M_SRC			223
> -#define CLK_150M_SRC			224
> -#define CLK_200M_SRC			225
> -#define CLK_250M_SRC			226
> -#define CLK_300M_SRC			227
> -#define CLK_350M_SRC			228
> -#define CLK_400M_SRC			229
> -#define CLK_450M_SRC			230
> -#define CLK_500M_SRC			231
> -#define CLK_600M_SRC			232
> -#define CLK_650M_SRC			233
> -#define CLK_700M_SRC			234
> -#define CLK_800M_SRC			235
> -#define CLK_1000M_SRC			236
> -#define CLK_1200M_SRC			237
> -#define ACLK_TOP_M300_ROOT		238
> -#define ACLK_TOP_M500_ROOT		239
> -#define ACLK_TOP_M400_ROOT		240
> -#define ACLK_TOP_S200_ROOT		241
> -#define ACLK_TOP_S400_ROOT		242
> -#define CLK_MIPI_CAMARAOUT_M0		243
> -#define CLK_MIPI_CAMARAOUT_M1		244
> -#define CLK_MIPI_CAMARAOUT_M2		245
> -#define CLK_MIPI_CAMARAOUT_M3		246
> -#define CLK_MIPI_CAMARAOUT_M4		247
> -#define MCLK_GMAC0_OUT			248
> -#define REFCLKO25M_ETH0_OUT		249
> -#define REFCLKO25M_ETH1_OUT		250
> -#define CLK_CIFOUT_OUT			251
> -#define PCLK_MIPI_DCPHY0		252
> -#define PCLK_MIPI_DCPHY1		253
> -#define PCLK_CSIPHY0			254
> -#define PCLK_CSIPHY1			255
> -#define ACLK_TOP_ROOT			256
> -#define PCLK_TOP_ROOT			257
> -#define ACLK_LOW_TOP_ROOT		258
> -#define PCLK_CRU			259
> -#define PCLK_GPU_ROOT			260
> -#define CLK_GPU_SRC			261
> -#define CLK_GPU				262
> -#define CLK_GPU_COREGROUP		263
> -#define CLK_GPU_STACKS			264
> -#define PCLK_GPU_PVTM			265
> -#define CLK_GPU_PVTM			266
> -#define CLK_CORE_GPU_PVTM		267
> -#define PCLK_GPU_GRF			268
> -#define ACLK_ISP1_ROOT			269
> -#define HCLK_ISP1_ROOT			270
> -#define CLK_ISP1_CORE			271
> -#define CLK_ISP1_CORE_MARVIN		272
> -#define CLK_ISP1_CORE_VICAP		273
> -#define ACLK_ISP1			274
> -#define HCLK_ISP1			275
> -#define ACLK_NPU1			276
> -#define HCLK_NPU1			277
> -#define ACLK_NPU2			278
> -#define HCLK_NPU2			279
> -#define HCLK_NPU_CM0_ROOT		280
> -#define FCLK_NPU_CM0_CORE		281
> -#define CLK_NPU_CM0_RTC			282
> -#define PCLK_NPU_PVTM			283
> -#define PCLK_NPU_GRF			284
> -#define CLK_NPU_PVTM			285
> -#define CLK_CORE_NPU_PVTM		286
> -#define ACLK_NPU0			287
> -#define HCLK_NPU0			288
> -#define HCLK_NPU_ROOT			289
> -#define CLK_NPU_DSU0			290
> -#define PCLK_NPU_ROOT			291
> -#define PCLK_NPU_TIMER			292
> -#define CLK_NPUTIMER_ROOT		293
> -#define CLK_NPUTIMER0			294
> -#define CLK_NPUTIMER1			295
> -#define PCLK_NPU_WDT			296
> -#define TCLK_NPU_WDT			297
> -#define HCLK_EMMC			298
> -#define ACLK_EMMC			299
> -#define CCLK_EMMC			300
> -#define BCLK_EMMC			301
> -#define TMCLK_EMMC			302
> -#define SCLK_SFC			303
> -#define HCLK_SFC			304
> -#define HCLK_SFC_XIP			305
> -#define HCLK_NVM_ROOT			306
> -#define ACLK_NVM_ROOT			307
> -#define CLK_GMAC0_PTP_REF		308
> -#define CLK_GMAC1_PTP_REF		309
> -#define CLK_GMAC_125M			310
> -#define CLK_GMAC_50M			311
> -#define ACLK_PHP_GIC_ITS		312
> -#define ACLK_MMU_PCIE			313
> -#define ACLK_MMU_PHP			314
> -#define ACLK_PCIE_4L_DBI		315
> -#define ACLK_PCIE_2L_DBI		316
> -#define ACLK_PCIE_1L0_DBI		317
> -#define ACLK_PCIE_1L1_DBI		318
> -#define ACLK_PCIE_1L2_DBI		319
> -#define ACLK_PCIE_4L_MSTR		320
> -#define ACLK_PCIE_2L_MSTR		321
> -#define ACLK_PCIE_1L0_MSTR		322
> -#define ACLK_PCIE_1L1_MSTR		323
> -#define ACLK_PCIE_1L2_MSTR		324
> -#define ACLK_PCIE_4L_SLV		325
> -#define ACLK_PCIE_2L_SLV		326
> -#define ACLK_PCIE_1L0_SLV		327
> -#define ACLK_PCIE_1L1_SLV		328
> -#define ACLK_PCIE_1L2_SLV		329
> -#define PCLK_PCIE_4L			330
> -#define PCLK_PCIE_2L			331
> -#define PCLK_PCIE_1L0			332
> -#define PCLK_PCIE_1L1			333
> -#define PCLK_PCIE_1L2			334
> -#define CLK_PCIE_AUX0			335
> -#define CLK_PCIE_AUX1			336
> -#define CLK_PCIE_AUX2			337
> -#define CLK_PCIE_AUX3			338
> -#define CLK_PCIE_AUX4			339
> -#define CLK_PIPEPHY0_REF		340
> -#define CLK_PIPEPHY1_REF		341
> -#define CLK_PIPEPHY2_REF		342
> -#define PCLK_PHP_ROOT			343
> -#define PCLK_GMAC0			344
> -#define PCLK_GMAC1			345
> -#define ACLK_PCIE_ROOT			346
> -#define ACLK_PHP_ROOT			347
> -#define ACLK_PCIE_BRIDGE		348
> -#define ACLK_GMAC0			349
> -#define ACLK_GMAC1			350
> -#define CLK_PMALIVE0			351
> -#define CLK_PMALIVE1			352
> -#define CLK_PMALIVE2			353
> -#define ACLK_SATA0			354
> -#define ACLK_SATA1			355
> -#define ACLK_SATA2			356
> -#define CLK_RXOOB0			357
> -#define CLK_RXOOB1			358
> -#define CLK_RXOOB2			359
> -#define ACLK_USB3OTG2			360
> -#define SUSPEND_CLK_USB3OTG2		361
> -#define REF_CLK_USB3OTG2		362
> -#define CLK_UTMI_OTG2			363
> -#define CLK_PIPEPHY0_PIPE_G		364
> -#define CLK_PIPEPHY1_PIPE_G		365
> -#define CLK_PIPEPHY2_PIPE_G		366
> -#define CLK_PIPEPHY0_PIPE_ASIC_G	367
> -#define CLK_PIPEPHY1_PIPE_ASIC_G	368
> -#define CLK_PIPEPHY2_PIPE_ASIC_G	369
> -#define CLK_PIPEPHY2_PIPE_U3_G		370
> -#define CLK_PCIE1L2_PIPE		371
> -#define CLK_PCIE4L_PIPE			372
> -#define CLK_PCIE2L_PIPE			373
> -#define PCLK_PCIE_COMBO_PIPE_PHY0	374
> -#define PCLK_PCIE_COMBO_PIPE_PHY1	375
> -#define PCLK_PCIE_COMBO_PIPE_PHY2	376
> -#define PCLK_PCIE_COMBO_PIPE_PHY	377
> -#define HCLK_RGA3_1			378
> -#define ACLK_RGA3_1			379
> -#define CLK_RGA3_1_CORE			380
> -#define ACLK_RGA3_ROOT			381
> -#define HCLK_RGA3_ROOT			382
> -#define ACLK_RKVDEC_CCU			383
> -#define HCLK_RKVDEC0			384
> -#define ACLK_RKVDEC0			385
> -#define CLK_RKVDEC0_CA			386
> -#define CLK_RKVDEC0_HEVC_CA		387
> -#define CLK_RKVDEC0_CORE		388
> -#define HCLK_RKVDEC1			389
> -#define ACLK_RKVDEC1			390
> -#define CLK_RKVDEC1_CA			391
> -#define CLK_RKVDEC1_HEVC_CA		392
> -#define CLK_RKVDEC1_CORE		393
> -#define HCLK_SDIO			394
> -#define CCLK_SRC_SDIO			395
> -#define ACLK_USB_ROOT			396
> -#define HCLK_USB_ROOT			397
> -#define HCLK_HOST0			398
> -#define HCLK_HOST_ARB0			399
> -#define HCLK_HOST1			400
> -#define HCLK_HOST_ARB1			401
> -#define ACLK_USB3OTG0			402
> -#define SUSPEND_CLK_USB3OTG0		403
> -#define REF_CLK_USB3OTG0		404
> -#define ACLK_USB3OTG1			405
> -#define SUSPEND_CLK_USB3OTG1		406
> -#define REF_CLK_USB3OTG1		407
> -#define UTMI_OHCI_CLK48_HOST0		408
> -#define UTMI_OHCI_CLK48_HOST1		409
> -#define HCLK_IEP2P0			410
> -#define ACLK_IEP2P0			411
> -#define CLK_IEP2P0_CORE			412
> -#define ACLK_JPEG_ENCODER0		413
> -#define HCLK_JPEG_ENCODER0		414
> -#define ACLK_JPEG_ENCODER1		415
> -#define HCLK_JPEG_ENCODER1		416
> -#define ACLK_JPEG_ENCODER2		417
> -#define HCLK_JPEG_ENCODER2		418
> -#define ACLK_JPEG_ENCODER3		419
> -#define HCLK_JPEG_ENCODER3		420
> -#define ACLK_JPEG_DECODER		421
> -#define HCLK_JPEG_DECODER		422
> -#define HCLK_RGA2			423
> -#define ACLK_RGA2			424
> -#define CLK_RGA2_CORE			425
> -#define HCLK_RGA3_0			426
> -#define ACLK_RGA3_0			427
> -#define CLK_RGA3_0_CORE			428
> -#define ACLK_VDPU_ROOT			429
> -#define ACLK_VDPU_LOW_ROOT		430
> -#define HCLK_VDPU_ROOT			431
> -#define ACLK_JPEG_DECODER_ROOT		432
> -#define ACLK_VPU			433
> -#define HCLK_VPU			434
> -#define HCLK_RKVENC0_ROOT		435
> -#define ACLK_RKVENC0_ROOT		436
> -#define HCLK_RKVENC0			437
> -#define ACLK_RKVENC0			438
> -#define CLK_RKVENC0_CORE		439
> -#define HCLK_RKVENC1_ROOT		440
> -#define ACLK_RKVENC1_ROOT		441
> -#define HCLK_RKVENC1			442
> -#define ACLK_RKVENC1			443
> -#define CLK_RKVENC1_CORE		444
> -#define ICLK_CSIHOST01			445
> -#define ICLK_CSIHOST0			446
> -#define ICLK_CSIHOST1			447
> -#define PCLK_CSI_HOST_0			448
> -#define PCLK_CSI_HOST_1			449
> -#define PCLK_CSI_HOST_2			450
> -#define PCLK_CSI_HOST_3			451
> -#define PCLK_CSI_HOST_4			452
> -#define PCLK_CSI_HOST_5			453
> -#define ACLK_FISHEYE0			454
> -#define HCLK_FISHEYE0			455
> -#define CLK_FISHEYE0_CORE		456
> -#define ACLK_FISHEYE1			457
> -#define HCLK_FISHEYE1			458
> -#define CLK_FISHEYE1_CORE		459
> -#define CLK_ISP0_CORE			460
> -#define CLK_ISP0_CORE_MARVIN		461
> -#define CLK_ISP0_CORE_VICAP		462
> -#define ACLK_ISP0			463
> -#define HCLK_ISP0			464
> -#define ACLK_VI_ROOT			465
> -#define HCLK_VI_ROOT			466
> -#define PCLK_VI_ROOT			467
> -#define DCLK_VICAP			468
> -#define ACLK_VICAP			469
> -#define HCLK_VICAP			470
> -#define PCLK_DP0			471
> -#define PCLK_DP1			472
> -#define PCLK_S_DP0			473
> -#define PCLK_S_DP1			474
> -#define CLK_DP0				475
> -#define CLK_DP1				476
> -#define HCLK_HDCP_KEY0			477
> -#define ACLK_HDCP0			478
> -#define HCLK_HDCP0			479
> -#define PCLK_HDCP0			480
> -#define HCLK_I2S4_8CH			481
> -#define ACLK_TRNG0			482
> -#define PCLK_TRNG0			483
> -#define ACLK_VO0_ROOT			484
> -#define HCLK_VO0_ROOT			485
> -#define HCLK_VO0_S_ROOT			486
> -#define PCLK_VO0_ROOT			487
> -#define PCLK_VO0_S_ROOT			488
> -#define PCLK_VO0GRF			489
> -#define CLK_I2S4_8CH_TX_SRC		490
> -#define CLK_I2S4_8CH_TX_FRAC		491
> -#define MCLK_I2S4_8CH_TX		492
> -#define CLK_I2S4_8CH_TX			493
> -#define HCLK_I2S8_8CH			494
> -#define CLK_I2S8_8CH_TX_SRC		495
> -#define CLK_I2S8_8CH_TX_FRAC		496
> -#define MCLK_I2S8_8CH_TX		497
> -#define CLK_I2S8_8CH_TX			498
> -#define HCLK_SPDIF2_DP0			499
> -#define CLK_SPDIF2_DP0_SRC		500
> -#define CLK_SPDIF2_DP0_FRAC		501
> -#define MCLK_SPDIF2_DP0			502
> -#define CLK_SPDIF2_DP0			503
> -#define MCLK_SPDIF2			504
> -#define HCLK_SPDIF5_DP1			505
> -#define CLK_SPDIF5_DP1_SRC		506
> -#define CLK_SPDIF5_DP1_FRAC		507
> -#define MCLK_SPDIF5_DP1			508
> -#define CLK_SPDIF5_DP1			509
> -#define MCLK_SPDIF5			510
> -#define PCLK_EDP0			511
> -#define CLK_EDP0_24M			512
> -#define CLK_EDP0_200M			513
> -#define PCLK_EDP1			514
> -#define CLK_EDP1_24M			515
> -#define CLK_EDP1_200M			516
> -#define HCLK_HDCP_KEY1			517
> -#define ACLK_HDCP1			518
> -#define HCLK_HDCP1			519
> -#define PCLK_HDCP1			520
> -#define ACLK_HDMIRX			521
> -#define PCLK_HDMIRX			522
> -#define CLK_HDMIRX_REF			523
> -#define CLK_HDMIRX_AUD_SRC		524
> -#define CLK_HDMIRX_AUD_FRAC		525
> -#define CLK_HDMIRX_AUD			526
> -#define CLK_HDMIRX_AUD_P_MUX		527
> -#define PCLK_HDMITX0			528
> -#define CLK_HDMITX0_EARC		529
> -#define CLK_HDMITX0_REF			530
> -#define PCLK_HDMITX1			531
> -#define CLK_HDMITX1_EARC		532
> -#define CLK_HDMITX1_REF			533
> -#define CLK_HDMITRX_REFSRC		534
> -#define ACLK_TRNG1			535
> -#define PCLK_TRNG1			536
> -#define ACLK_HDCP1_ROOT			537
> -#define ACLK_HDMIRX_ROOT		538
> -#define HCLK_VO1_ROOT			539
> -#define HCLK_VO1_S_ROOT			540
> -#define PCLK_VO1_ROOT			541
> -#define PCLK_VO1_S_ROOT			542
> -#define PCLK_S_EDP0			543
> -#define PCLK_S_EDP1			544
> -#define PCLK_S_HDMIRX			545
> -#define HCLK_I2S10_8CH			546
> -#define CLK_I2S10_8CH_RX_SRC		547
> -#define CLK_I2S10_8CH_RX_FRAC		548
> -#define CLK_I2S10_8CH_RX		549
> -#define MCLK_I2S10_8CH_RX		550
> -#define HCLK_I2S7_8CH			551
> -#define CLK_I2S7_8CH_RX_SRC		552
> -#define CLK_I2S7_8CH_RX_FRAC		553
> -#define CLK_I2S7_8CH_RX			554
> -#define MCLK_I2S7_8CH_RX		555
> -#define HCLK_I2S9_8CH			556
> -#define CLK_I2S9_8CH_RX_SRC		557
> -#define CLK_I2S9_8CH_RX_FRAC		558
> -#define CLK_I2S9_8CH_RX			559
> -#define MCLK_I2S9_8CH_RX		560
> -#define CLK_I2S5_8CH_TX_SRC		561
> -#define CLK_I2S5_8CH_TX_FRAC		562
> -#define CLK_I2S5_8CH_TX			563
> -#define MCLK_I2S5_8CH_TX		564
> -#define HCLK_I2S5_8CH			565
> -#define CLK_I2S6_8CH_TX_SRC		566
> -#define CLK_I2S6_8CH_TX_FRAC		567
> -#define CLK_I2S6_8CH_TX			568
> -#define MCLK_I2S6_8CH_TX		569
> -#define CLK_I2S6_8CH_RX_SRC		570
> -#define CLK_I2S6_8CH_RX_FRAC		571
> -#define CLK_I2S6_8CH_RX			572
> -#define MCLK_I2S6_8CH_RX		573
> -#define I2S6_8CH_MCLKOUT		574
> -#define HCLK_I2S6_8CH			575
> -#define HCLK_SPDIF3			576
> -#define CLK_SPDIF3_SRC			577
> -#define CLK_SPDIF3_FRAC			578
> -#define CLK_SPDIF3			579
> -#define MCLK_SPDIF3			580
> -#define HCLK_SPDIF4			581
> -#define CLK_SPDIF4_SRC			582
> -#define CLK_SPDIF4_FRAC			583
> -#define CLK_SPDIF4			584
> -#define MCLK_SPDIF4			585
> -#define HCLK_SPDIFRX0			586
> -#define MCLK_SPDIFRX0			587
> -#define HCLK_SPDIFRX1			588
> -#define MCLK_SPDIFRX1			589
> -#define HCLK_SPDIFRX2			590
> -#define MCLK_SPDIFRX2			591
> -#define ACLK_VO1USB_TOP_ROOT		592
> -#define HCLK_VO1USB_TOP_ROOT		593
> -#define CLK_HDMIHDP0			594
> -#define CLK_HDMIHDP1			595
> -#define PCLK_HDPTX0			596
> -#define PCLK_HDPTX1			597
> -#define PCLK_USBDPPHY0			598
> -#define PCLK_USBDPPHY1			599
> -#define ACLK_VOP_ROOT			600
> -#define ACLK_VOP_LOW_ROOT		601
> -#define HCLK_VOP_ROOT			602
> -#define PCLK_VOP_ROOT			603
> -#define HCLK_VOP			604
> -#define ACLK_VOP			605
> -#define DCLK_VOP0_SRC			606
> -#define DCLK_VOP1_SRC			607
> -#define DCLK_VOP2_SRC			608
> -#define DCLK_VOP0			609
> -#define DCLK_VOP1			610
> -#define DCLK_VOP2			611
> -#define DCLK_VOP3			612
> -#define PCLK_DSIHOST0			613
> -#define PCLK_DSIHOST1			614
> -#define CLK_DSIHOST0			615
> -#define CLK_DSIHOST1			616
> -#define CLK_VOP_PMU			617
> -#define ACLK_VOP_DOBY			618
> -#define ACLK_VOP_SUB_SRC		619
> -#define CLK_USBDP_PHY0_IMMORTAL		620
> -#define CLK_USBDP_PHY1_IMMORTAL		621
> -#define CLK_PMU0			622
> -#define PCLK_PMU0			623
> -#define PCLK_PMU0IOC			624
> -#define PCLK_GPIO0			625
> -#define DBCLK_GPIO0			626
> -#define PCLK_I2C0			627
> -#define CLK_I2C0			628
> -#define HCLK_I2S1_8CH			629
> -#define CLK_I2S1_8CH_TX_SRC		630
> -#define CLK_I2S1_8CH_TX_FRAC		631
> -#define CLK_I2S1_8CH_TX			632
> -#define MCLK_I2S1_8CH_TX		633
> -#define CLK_I2S1_8CH_RX_SRC		634
> -#define CLK_I2S1_8CH_RX_FRAC		635
> -#define CLK_I2S1_8CH_RX			636
> -#define MCLK_I2S1_8CH_RX		637
> -#define I2S1_8CH_MCLKOUT		638
> -#define CLK_PMU1_50M_SRC		639
> -#define CLK_PMU1_100M_SRC		640
> -#define CLK_PMU1_200M_SRC		641
> -#define CLK_PMU1_300M_SRC		642
> -#define CLK_PMU1_400M_SRC		643
> -#define HCLK_PMU1_ROOT			644
> -#define PCLK_PMU1_ROOT			645
> -#define PCLK_PMU0_ROOT			646
> -#define HCLK_PMU_CM0_ROOT		647
> -#define PCLK_PMU1			648
> -#define CLK_DDR_FAIL_SAFE		649
> -#define CLK_PMU1			650
> -#define HCLK_PDM0			651
> -#define MCLK_PDM0			652
> -#define HCLK_VAD			653
> -#define FCLK_PMU_CM0_CORE		654
> -#define CLK_PMU_CM0_RTC			655
> -#define PCLK_PMU1_IOC			656
> -#define PCLK_PMU1PWM			657
> -#define CLK_PMU1PWM			658
> -#define CLK_PMU1PWM_CAPTURE		659
> -#define PCLK_PMU1TIMER			660
> -#define CLK_PMU1TIMER_ROOT		661
> -#define CLK_PMU1TIMER0			662
> -#define CLK_PMU1TIMER1			663
> -#define CLK_UART0_SRC			664
> -#define CLK_UART0_FRAC			665
> -#define CLK_UART0			666
> -#define SCLK_UART0			667
> -#define PCLK_UART0			668
> -#define PCLK_PMU1WDT			669
> -#define TCLK_PMU1WDT			670
> -#define CLK_CR_PARA			671
> -#define CLK_USB2PHY_HDPTXRXPHY_REF	672
> -#define CLK_USBDPPHY_MIPIDCPPHY_REF	673
> -#define CLK_REF_PIPE_PHY0_OSC_SRC	674
> -#define CLK_REF_PIPE_PHY1_OSC_SRC	675
> -#define CLK_REF_PIPE_PHY2_OSC_SRC	676
> -#define CLK_REF_PIPE_PHY0_PLL_SRC	677
> -#define CLK_REF_PIPE_PHY1_PLL_SRC	678
> -#define CLK_REF_PIPE_PHY2_PLL_SRC	679
> -#define CLK_REF_PIPE_PHY0		680
> -#define CLK_REF_PIPE_PHY1		681
> -#define CLK_REF_PIPE_PHY2		682
> -#define SCLK_SDIO_DRV			683
> -#define SCLK_SDIO_SAMPLE		684
> -#define SCLK_SDMMC_DRV			685
> -#define SCLK_SDMMC_SAMPLE		686
> -#define CLK_PCIE1L0_PIPE		687
> -#define CLK_PCIE1L1_PIPE		688
> -#define CLK_BIGCORE0_PVTM		689
> -#define CLK_CORE_BIGCORE0_PVTM		690
> -#define CLK_BIGCORE1_PVTM		691
> -#define CLK_CORE_BIGCORE1_PVTM		692
> -#define CLK_LITCORE_PVTM		693
> -#define CLK_CORE_LITCORE_PVTM		694
> -#define CLK_AUX16M_0			695
> -#define CLK_AUX16M_1			696
> -#define CLK_PHY0_REF_ALT_P		697
> -#define CLK_PHY0_REF_ALT_M		698
> -#define CLK_PHY1_REF_ALT_P		699
> -#define CLK_PHY1_REF_ALT_M		700
> -#define ACLK_ISP1_PRE			701
> -#define HCLK_ISP1_PRE			702
> -#define HCLK_NVM			703
> -#define ACLK_USB			704
> -#define HCLK_USB			705
> -#define ACLK_JPEG_DECODER_PRE		706
> -#define ACLK_VDPU_LOW_PRE		707
> -#define ACLK_RKVENC1_PRE		708
> -#define HCLK_RKVENC1_PRE		709
> -#define HCLK_RKVDEC0_PRE		710
> -#define ACLK_RKVDEC0_PRE		711
> -#define HCLK_RKVDEC1_PRE		712
> -#define ACLK_RKVDEC1_PRE		713
> -#define ACLK_HDCP0_PRE			714
> -#define HCLK_VO0			715
> -#define ACLK_HDCP1_PRE			716
> -#define HCLK_VO1			717
> -#define ACLK_AV1_PRE			718
> -#define PCLK_AV1_PRE			719
> -#define HCLK_SDIO_PRE			720
> -
> -#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
> -
> -/* scmi-clocks indices */
> -
> -#define SCMI_CLK_CPUL			0
> -#define SCMI_CLK_DSU			1
> -#define SCMI_CLK_CPUB01			2
> -#define SCMI_CLK_CPUB23			3
> -#define SCMI_CLK_DDR			4
> -#define SCMI_CLK_GPU			5
> -#define SCMI_CLK_NPU			6
> -#define SCMI_CLK_SBUS			7
> -#define SCMI_PCLK_SBUS			8
> -#define SCMI_CCLK_SD			9
> -#define SCMI_DCLK_SD			10
> -#define SCMI_ACLK_SECURE_NS		11
> -#define SCMI_HCLK_SECURE_NS		12
> -#define SCMI_TCLK_WDT			13
> -#define SCMI_KEYLADDER_CORE		14
> -#define SCMI_KEYLADDER_RNG		15
> -#define SCMI_ACLK_SECURE_S		16
> -#define SCMI_HCLK_SECURE_S		17
> -#define SCMI_PCLK_SECURE_S		18
> -#define SCMI_CRYPTO_RNG			19
> -#define SCMI_CRYPTO_CORE		20
> -#define SCMI_CRYPTO_PKA			21
> -#define SCMI_SPLL			22
> -#define SCMI_HCLK_SD			23
> -
> -#endif
> diff --git a/include/dt-bindings/power/rk3588-power.h b/include/dt-bindings/power/rk3588-power.h
> deleted file mode 100644
> index 1b92fec013cb..000000000000
> --- a/include/dt-bindings/power/rk3588-power.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
> -#ifndef __DT_BINDINGS_POWER_RK3588_POWER_H__
> -#define __DT_BINDINGS_POWER_RK3588_POWER_H__
> -
> -/* VD_LITDSU */
> -#define RK3588_PD_CPU_0		0
> -#define RK3588_PD_CPU_1		1
> -#define RK3588_PD_CPU_2		2
> -#define RK3588_PD_CPU_3		3
> -
> -/* VD_BIGCORE0 */
> -#define RK3588_PD_CPU_4		4
> -#define RK3588_PD_CPU_5		5
> -
> -/* VD_BIGCORE1 */
> -#define RK3588_PD_CPU_6		6
> -#define RK3588_PD_CPU_7		7
> -
> -/* VD_NPU */
> -#define RK3588_PD_NPU		8
> -#define RK3588_PD_NPUTOP	9
> -#define RK3588_PD_NPU1		10
> -#define RK3588_PD_NPU2		11
> -
> -/* VD_GPU */
> -#define RK3588_PD_GPU		12
> -
> -/* VD_VCODEC */
> -#define RK3588_PD_VCODEC	13
> -#define RK3588_PD_RKVDEC0	14
> -#define RK3588_PD_RKVDEC1	15
> -#define RK3588_PD_VENC0		16
> -#define RK3588_PD_VENC1		17
> -
> -/* VD_DD01 */
> -#define RK3588_PD_DDR01		18
> -
> -/* VD_DD23 */
> -#define RK3588_PD_DDR23		19
> -
> -/* VD_LOGIC */
> -#define RK3588_PD_CENTER	20
> -#define RK3588_PD_VDPU		21
> -#define RK3588_PD_RGA30		22
> -#define RK3588_PD_AV1		23
> -#define RK3588_PD_VOP		24
> -#define RK3588_PD_VO0		25
> -#define RK3588_PD_VO1		26
> -#define RK3588_PD_VI		27
> -#define RK3588_PD_ISP1		28
> -#define RK3588_PD_FEC		29
> -#define RK3588_PD_RGA31		30
> -#define RK3588_PD_USB		31
> -#define RK3588_PD_PHP		32
> -#define RK3588_PD_GMAC		33
> -#define RK3588_PD_PCIE		34
> -#define RK3588_PD_NVM		35
> -#define RK3588_PD_NVM0		36
> -#define RK3588_PD_SDIO		37
> -#define RK3588_PD_AUDIO		38
> -#define RK3588_PD_SECURE	39
> -#define RK3588_PD_SDMMC		40
> -#define RK3588_PD_CRYPTO	41
> -#define RK3588_PD_BUS		42
> -
> -/* VD_PMU */
> -#define RK3588_PD_PMU1		43
> -
> -#endif
> diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> deleted file mode 100644
> index 738e56aead93..000000000000
> --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
> +++ /dev/null
> @@ -1,754 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
> -/*
> - * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
> - * Copyright (c) 2022 Collabora Ltd.
> - *
> - * Author: Elaine Zhang <zhangqing@rock-chips.com>
> - * Author: Sebastian Reichel <sebastian.reichel@collabora.com>
> - */
> -
> -#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3588_H
> -#define _DT_BINDINGS_RESET_ROCKCHIP_RK3588_H
> -
> -#define SRST_A_TOP_BIU			0
> -#define SRST_P_TOP_BIU			1
> -#define SRST_P_CSIPHY0			2
> -#define SRST_CSIPHY0			3
> -#define SRST_P_CSIPHY1			4
> -#define SRST_CSIPHY1			5
> -#define SRST_A_TOP_M500_BIU		6
> -
> -#define SRST_A_TOP_M400_BIU		7
> -#define SRST_A_TOP_S200_BIU		8
> -#define SRST_A_TOP_S400_BIU		9
> -#define SRST_A_TOP_M300_BIU		10
> -#define SRST_USBDP_COMBO_PHY0_INIT	11
> -#define SRST_USBDP_COMBO_PHY0_CMN	12
> -#define SRST_USBDP_COMBO_PHY0_LANE	13
> -#define SRST_USBDP_COMBO_PHY0_PCS	14
> -#define SRST_USBDP_COMBO_PHY1_INIT	15
> -
> -#define SRST_USBDP_COMBO_PHY1_CMN	16
> -#define SRST_USBDP_COMBO_PHY1_LANE	17
> -#define SRST_USBDP_COMBO_PHY1_PCS	18
> -#define SRST_DCPHY0			19
> -#define SRST_P_MIPI_DCPHY0		20
> -#define SRST_P_MIPI_DCPHY0_GRF		21
> -
> -#define SRST_DCPHY1			22
> -#define SRST_P_MIPI_DCPHY1		23
> -#define SRST_P_MIPI_DCPHY1_GRF		24
> -#define SRST_P_APB2ASB_SLV_CDPHY	25
> -#define SRST_P_APB2ASB_SLV_CSIPHY	26
> -#define SRST_P_APB2ASB_SLV_VCCIO3_5	27
> -#define SRST_P_APB2ASB_SLV_VCCIO6	28
> -#define SRST_P_APB2ASB_SLV_EMMCIO	29
> -#define SRST_P_APB2ASB_SLV_IOC_TOP	30
> -#define SRST_P_APB2ASB_SLV_IOC_RIGHT	31
> -
> -#define SRST_P_CRU			32
> -#define SRST_A_CHANNEL_SECURE2VO1USB	33
> -#define SRST_A_CHANNEL_SECURE2CENTER	34
> -#define SRST_H_CHANNEL_SECURE2VO1USB	35
> -#define SRST_H_CHANNEL_SECURE2CENTER	36
> -
> -#define SRST_P_CHANNEL_SECURE2VO1USB	37
> -#define SRST_P_CHANNEL_SECURE2CENTER	38
> -
> -#define SRST_H_AUDIO_BIU		39
> -#define SRST_P_AUDIO_BIU		40
> -#define SRST_H_I2S0_8CH			41
> -#define SRST_M_I2S0_8CH_TX		42
> -#define SRST_M_I2S0_8CH_RX		43
> -#define SRST_P_ACDCDIG			44
> -#define SRST_H_I2S2_2CH			45
> -#define SRST_H_I2S3_2CH			46
> -
> -#define SRST_M_I2S2_2CH			47
> -#define SRST_M_I2S3_2CH			48
> -#define SRST_DAC_ACDCDIG		49
> -#define SRST_H_SPDIF0			50
> -
> -#define SRST_M_SPDIF0			51
> -#define SRST_H_SPDIF1			52
> -#define SRST_M_SPDIF1			53
> -#define SRST_H_PDM1			54
> -#define SRST_PDM1			55
> -
> -#define SRST_A_BUS_BIU			56
> -#define SRST_P_BUS_BIU			57
> -#define SRST_A_GIC			58
> -#define SRST_A_GIC_DBG			59
> -#define SRST_A_DMAC0			60
> -#define SRST_A_DMAC1			61
> -#define SRST_A_DMAC2			62
> -#define SRST_P_I2C1			63
> -#define SRST_P_I2C2			64
> -#define SRST_P_I2C3			65
> -#define SRST_P_I2C4			66
> -#define SRST_P_I2C5			67
> -#define SRST_P_I2C6			68
> -#define SRST_P_I2C7			69
> -#define SRST_P_I2C8			70
> -
> -#define SRST_I2C1			71
> -#define SRST_I2C2			72
> -#define SRST_I2C3			73
> -#define SRST_I2C4			74
> -#define SRST_I2C5			75
> -#define SRST_I2C6			76
> -#define SRST_I2C7			77
> -#define SRST_I2C8			78
> -#define SRST_P_CAN0			79
> -#define SRST_CAN0			80
> -#define SRST_P_CAN1			81
> -#define SRST_CAN1			82
> -#define SRST_P_CAN2			83
> -#define SRST_CAN2			84
> -#define SRST_P_SARADC			85
> -
> -#define SRST_P_TSADC			86
> -#define SRST_TSADC			87
> -#define SRST_P_UART1			88
> -#define SRST_P_UART2			89
> -#define SRST_P_UART3			90
> -#define SRST_P_UART4			91
> -#define SRST_P_UART5			92
> -#define SRST_P_UART6			93
> -#define SRST_P_UART7			94
> -#define SRST_P_UART8			95
> -#define SRST_P_UART9			96
> -#define SRST_S_UART1			97
> -
> -#define SRST_S_UART2			98
> -#define SRST_S_UART3			99
> -#define SRST_S_UART4			100
> -#define SRST_S_UART5			101
> -#define SRST_S_UART6			102
> -#define SRST_S_UART7			103
> -
> -#define SRST_S_UART8			104
> -#define SRST_S_UART9			105
> -#define SRST_P_SPI0			106
> -#define SRST_P_SPI1			107
> -#define SRST_P_SPI2			108
> -#define SRST_P_SPI3			109
> -#define SRST_P_SPI4			110
> -#define SRST_SPI0			111
> -#define SRST_SPI1			112
> -#define SRST_SPI2			113
> -#define SRST_SPI3			114
> -#define SRST_SPI4			115
> -
> -#define SRST_P_WDT0			116
> -#define SRST_T_WDT0			117
> -#define SRST_P_SYS_GRF			118
> -#define SRST_P_PWM1			119
> -#define SRST_PWM1			120
> -#define SRST_P_PWM2			121
> -#define SRST_PWM2			122
> -#define SRST_P_PWM3			123
> -#define SRST_PWM3			124
> -#define SRST_P_BUSTIMER0		125
> -#define SRST_P_BUSTIMER1		126
> -#define SRST_BUSTIMER0			127
> -
> -#define SRST_BUSTIMER1			128
> -#define SRST_BUSTIMER2			129
> -#define SRST_BUSTIMER3			130
> -#define SRST_BUSTIMER4			131
> -#define SRST_BUSTIMER5			132
> -#define SRST_BUSTIMER6			133
> -#define SRST_BUSTIMER7			134
> -#define SRST_BUSTIMER8			135
> -#define SRST_BUSTIMER9			136
> -#define SRST_BUSTIMER10			137
> -#define SRST_BUSTIMER11			138
> -#define SRST_P_MAILBOX0			139
> -#define SRST_P_MAILBOX1			140
> -#define SRST_P_MAILBOX2			141
> -#define SRST_P_GPIO1			142
> -#define SRST_GPIO1			143
> -
> -#define SRST_P_GPIO2			144
> -#define SRST_GPIO2			145
> -#define SRST_P_GPIO3			146
> -#define SRST_GPIO3			147
> -#define SRST_P_GPIO4			148
> -#define SRST_GPIO4			149
> -#define SRST_A_DECOM			150
> -#define SRST_P_DECOM			151
> -#define SRST_D_DECOM			152
> -#define SRST_P_TOP			153
> -#define SRST_A_GICADB_GIC2CORE_BUS	154
> -#define SRST_P_DFT2APB			155
> -#define SRST_P_APB2ASB_MST_TOP		156
> -#define SRST_P_APB2ASB_MST_CDPHY	157
> -#define SRST_P_APB2ASB_MST_BOT_RIGHT	158
> -
> -#define SRST_P_APB2ASB_MST_IOC_TOP	159
> -#define SRST_P_APB2ASB_MST_IOC_RIGHT	160
> -#define SRST_P_APB2ASB_MST_CSIPHY	161
> -#define SRST_P_APB2ASB_MST_VCCIO3_5	162
> -#define SRST_P_APB2ASB_MST_VCCIO6	163
> -#define SRST_P_APB2ASB_MST_EMMCIO	164
> -#define SRST_A_SPINLOCK			165
> -#define SRST_P_OTPC_NS			166
> -#define SRST_OTPC_NS			167
> -#define SRST_OTPC_ARB			168
> -
> -#define SRST_P_BUSIOC			169
> -#define SRST_P_PMUCM0_INTMUX		170
> -#define SRST_P_DDRCM0_INTMUX		171
> -
> -#define SRST_P_DDR_DFICTL_CH0		172
> -#define SRST_P_DDR_MON_CH0		173
> -#define SRST_P_DDR_STANDBY_CH0		174
> -#define SRST_P_DDR_UPCTL_CH0		175
> -#define SRST_TM_DDR_MON_CH0		176
> -#define SRST_P_DDR_GRF_CH01		177
> -#define SRST_DFI_CH0			178
> -#define SRST_SBR_CH0			179
> -#define SRST_DDR_UPCTL_CH0		180
> -#define SRST_DDR_DFICTL_CH0		181
> -#define SRST_DDR_MON_CH0		182
> -#define SRST_DDR_STANDBY_CH0		183
> -#define SRST_A_DDR_UPCTL_CH0		184
> -#define SRST_P_DDR_DFICTL_CH1		185
> -#define SRST_P_DDR_MON_CH1		186
> -#define SRST_P_DDR_STANDBY_CH1		187
> -
> -#define SRST_P_DDR_UPCTL_CH1		188
> -#define SRST_TM_DDR_MON_CH1		189
> -#define SRST_DFI_CH1			190
> -#define SRST_SBR_CH1			191
> -#define SRST_DDR_UPCTL_CH1		192
> -#define SRST_DDR_DFICTL_CH1		193
> -#define SRST_DDR_MON_CH1		194
> -#define SRST_DDR_STANDBY_CH1		195
> -#define SRST_A_DDR_UPCTL_CH1		196
> -#define SRST_A_DDR01_MSCH0		197
> -#define SRST_A_DDR01_RS_MSCH0		198
> -#define SRST_A_DDR01_FRS_MSCH0		199
> -
> -#define SRST_A_DDR01_SCRAMBLE0		200
> -#define SRST_A_DDR01_FRS_SCRAMBLE0	201
> -#define SRST_A_DDR01_MSCH1		202
> -#define SRST_A_DDR01_RS_MSCH1		203
> -#define SRST_A_DDR01_FRS_MSCH1		204
> -#define SRST_A_DDR01_SCRAMBLE1		205
> -#define SRST_A_DDR01_FRS_SCRAMBLE1	206
> -#define SRST_P_DDR01_MSCH0		207
> -#define SRST_P_DDR01_MSCH1		208
> -
> -#define SRST_P_DDR_DFICTL_CH2		209
> -#define SRST_P_DDR_MON_CH2		210
> -#define SRST_P_DDR_STANDBY_CH2		211
> -#define SRST_P_DDR_UPCTL_CH2		212
> -#define SRST_TM_DDR_MON_CH2		213
> -#define SRST_P_DDR_GRF_CH23		214
> -#define SRST_DFI_CH2			215
> -#define SRST_SBR_CH2			216
> -#define SRST_DDR_UPCTL_CH2		217
> -#define SRST_DDR_DFICTL_CH2		218
> -#define SRST_DDR_MON_CH2		219
> -#define SRST_DDR_STANDBY_CH2		220
> -#define SRST_A_DDR_UPCTL_CH2		221
> -#define SRST_P_DDR_DFICTL_CH3		222
> -#define SRST_P_DDR_MON_CH3		223
> -#define SRST_P_DDR_STANDBY_CH3		224
> -
> -#define SRST_P_DDR_UPCTL_CH3		225
> -#define SRST_TM_DDR_MON_CH3		226
> -#define SRST_DFI_CH3			227
> -#define SRST_SBR_CH3			228
> -#define SRST_DDR_UPCTL_CH3		229
> -#define SRST_DDR_DFICTL_CH3		230
> -#define SRST_DDR_MON_CH3		231
> -#define SRST_DDR_STANDBY_CH3		232
> -#define SRST_A_DDR_UPCTL_CH3		233
> -#define SRST_A_DDR23_MSCH2		234
> -#define SRST_A_DDR23_RS_MSCH2		235
> -#define SRST_A_DDR23_FRS_MSCH2		236
> -
> -#define SRST_A_DDR23_SCRAMBLE2		237
> -#define SRST_A_DDR23_FRS_SCRAMBLE2	238
> -#define SRST_A_DDR23_MSCH3		239
> -#define SRST_A_DDR23_RS_MSCH3		240
> -#define SRST_A_DDR23_FRS_MSCH3		241
> -#define SRST_A_DDR23_SCRAMBLE3		242
> -#define SRST_A_DDR23_FRS_SCRAMBLE3	243
> -#define SRST_P_DDR23_MSCH2		244
> -#define SRST_P_DDR23_MSCH3		245
> -
> -#define SRST_ISP1			246
> -#define SRST_ISP1_VICAP			247
> -#define SRST_A_ISP1_BIU			248
> -#define SRST_H_ISP1_BIU			249
> -
> -#define SRST_A_RKNN1			250
> -#define SRST_A_RKNN1_BIU		251
> -#define SRST_H_RKNN1			252
> -#define SRST_H_RKNN1_BIU		253
> -
> -#define SRST_A_RKNN2			254
> -#define SRST_A_RKNN2_BIU		255
> -#define SRST_H_RKNN2			256
> -#define SRST_H_RKNN2_BIU		257
> -
> -#define SRST_A_RKNN_DSU0		258
> -#define SRST_P_NPUTOP_BIU		259
> -#define SRST_P_NPU_TIMER		260
> -#define SRST_NPUTIMER0			261
> -#define SRST_NPUTIMER1			262
> -#define SRST_P_NPU_WDT			263
> -#define SRST_T_NPU_WDT			264
> -#define SRST_P_NPU_PVTM			265
> -#define SRST_P_NPU_GRF			266
> -#define SRST_NPU_PVTM			267
> -
> -#define SRST_NPU_PVTPLL			268
> -#define SRST_H_NPU_CM0_BIU		269
> -#define SRST_F_NPU_CM0_CORE		270
> -#define SRST_T_NPU_CM0_JTAG		271
> -#define SRST_A_RKNN0			272
> -#define SRST_A_RKNN0_BIU		273
> -#define SRST_H_RKNN0			274
> -#define SRST_H_RKNN0_BIU		275
> -
> -#define SRST_H_NVM_BIU			276
> -#define SRST_A_NVM_BIU			277
> -#define SRST_H_EMMC			278
> -#define SRST_A_EMMC			279
> -#define SRST_C_EMMC			280
> -#define SRST_B_EMMC			281
> -#define SRST_T_EMMC			282
> -#define SRST_S_SFC			283
> -#define SRST_H_SFC			284
> -#define SRST_H_SFC_XIP			285
> -
> -#define SRST_P_GRF			286
> -#define SRST_P_DEC_BIU			287
> -#define SRST_P_PHP_BIU			288
> -#define SRST_A_PCIE_GRIDGE		289
> -#define SRST_A_PHP_BIU			290
> -#define SRST_A_GMAC0			291
> -#define SRST_A_GMAC1			292
> -#define SRST_A_PCIE_BIU			293
> -#define SRST_PCIE0_POWER_UP		294
> -#define SRST_PCIE1_POWER_UP		295
> -#define SRST_PCIE2_POWER_UP		296
> -
> -#define SRST_PCIE3_POWER_UP		297
> -#define SRST_PCIE4_POWER_UP		298
> -#define SRST_P_PCIE0			299
> -#define SRST_P_PCIE1			300
> -#define SRST_P_PCIE2			301
> -#define SRST_P_PCIE3			302
> -
> -#define SRST_P_PCIE4			303
> -#define SRST_A_PHP_GIC_ITS		304
> -#define SRST_A_MMU_PCIE			305
> -#define SRST_A_MMU_PHP			306
> -#define SRST_A_MMU_BIU			307
> -
> -#define SRST_A_USB3OTG2			308
> -
> -#define SRST_PMALIVE0			309
> -#define SRST_PMALIVE1			310
> -#define SRST_PMALIVE2			311
> -#define SRST_A_SATA0			312
> -#define SRST_A_SATA1			313
> -#define SRST_A_SATA2			314
> -#define SRST_RXOOB0			315
> -#define SRST_RXOOB1			316
> -#define SRST_RXOOB2			317
> -#define SRST_ASIC0			318
> -#define SRST_ASIC1			319
> -#define SRST_ASIC2			320
> -
> -#define SRST_A_RKVDEC_CCU		321
> -#define SRST_H_RKVDEC0			322
> -#define SRST_A_RKVDEC0			323
> -#define SRST_H_RKVDEC0_BIU		324
> -#define SRST_A_RKVDEC0_BIU		325
> -#define SRST_RKVDEC0_CA			326
> -#define SRST_RKVDEC0_HEVC_CA		327
> -#define SRST_RKVDEC0_CORE		328
> -
> -#define SRST_H_RKVDEC1			329
> -#define SRST_A_RKVDEC1			330
> -#define SRST_H_RKVDEC1_BIU		331
> -#define SRST_A_RKVDEC1_BIU		332
> -#define SRST_RKVDEC1_CA			333
> -#define SRST_RKVDEC1_HEVC_CA		334
> -#define SRST_RKVDEC1_CORE		335
> -
> -#define SRST_A_USB_BIU			336
> -#define SRST_H_USB_BIU			337
> -#define SRST_A_USB3OTG0			338
> -#define SRST_A_USB3OTG1			339
> -#define SRST_H_HOST0			340
> -#define SRST_H_HOST_ARB0		341
> -#define SRST_H_HOST1			342
> -#define SRST_H_HOST_ARB1		343
> -#define SRST_A_USB_GRF			344
> -#define SRST_C_USB2P0_HOST0		345
> -
> -#define SRST_C_USB2P0_HOST1		346
> -#define SRST_HOST_UTMI0			347
> -#define SRST_HOST_UTMI1			348
> -
> -#define SRST_A_VDPU_BIU			349
> -#define SRST_A_VDPU_LOW_BIU		350
> -#define SRST_H_VDPU_BIU			351
> -#define SRST_A_JPEG_DECODER_BIU		352
> -#define SRST_A_VPU			353
> -#define SRST_H_VPU			354
> -#define SRST_A_JPEG_ENCODER0		355
> -#define SRST_H_JPEG_ENCODER0		356
> -#define SRST_A_JPEG_ENCODER1		357
> -#define SRST_H_JPEG_ENCODER1		358
> -#define SRST_A_JPEG_ENCODER2		359
> -#define SRST_H_JPEG_ENCODER2		360
> -
> -#define SRST_A_JPEG_ENCODER3		361
> -#define SRST_H_JPEG_ENCODER3		362
> -#define SRST_A_JPEG_DECODER		363
> -#define SRST_H_JPEG_DECODER		364
> -#define SRST_H_IEP2P0			365
> -#define SRST_A_IEP2P0			366
> -#define SRST_IEP2P0_CORE		367
> -#define SRST_H_RGA2			368
> -#define SRST_A_RGA2			369
> -#define SRST_RGA2_CORE			370
> -#define SRST_H_RGA3_0			371
> -#define SRST_A_RGA3_0			372
> -#define SRST_RGA3_0_CORE		373
> -
> -#define SRST_H_RKVENC0_BIU		374
> -#define SRST_A_RKVENC0_BIU		375
> -#define SRST_H_RKVENC0			376
> -#define SRST_A_RKVENC0			377
> -#define SRST_RKVENC0_CORE		378
> -
> -#define SRST_H_RKVENC1_BIU		379
> -#define SRST_A_RKVENC1_BIU		380
> -#define SRST_H_RKVENC1			381
> -#define SRST_A_RKVENC1			382
> -#define SRST_RKVENC1_CORE		383
> -
> -#define SRST_A_VI_BIU			384
> -#define SRST_H_VI_BIU			385
> -#define SRST_P_VI_BIU			386
> -#define SRST_D_VICAP			387
> -#define SRST_A_VICAP			388
> -#define SRST_H_VICAP			389
> -#define SRST_ISP0			390
> -#define SRST_ISP0_VICAP			391
> -
> -#define SRST_FISHEYE0			392
> -#define SRST_FISHEYE1			393
> -#define SRST_P_CSI_HOST_0		394
> -#define SRST_P_CSI_HOST_1		395
> -#define SRST_P_CSI_HOST_2		396
> -#define SRST_P_CSI_HOST_3		397
> -#define SRST_P_CSI_HOST_4		398
> -#define SRST_P_CSI_HOST_5		399
> -
> -#define SRST_CSIHOST0_VICAP		400
> -#define SRST_CSIHOST1_VICAP		401
> -#define SRST_CSIHOST2_VICAP		402
> -#define SRST_CSIHOST3_VICAP		403
> -#define SRST_CSIHOST4_VICAP		404
> -#define SRST_CSIHOST5_VICAP		405
> -#define SRST_CIFIN			406
> -
> -#define SRST_A_VOP_BIU			407
> -#define SRST_A_VOP_LOW_BIU		408
> -#define SRST_H_VOP_BIU			409
> -#define SRST_P_VOP_BIU			410
> -#define SRST_H_VOP			411
> -#define SRST_A_VOP			412
> -#define SRST_D_VOP0			413
> -#define SRST_D_VOP2HDMI_BRIDGE0		414
> -#define SRST_D_VOP2HDMI_BRIDGE1		415
> -
> -#define SRST_D_VOP1			416
> -#define SRST_D_VOP2			417
> -#define SRST_D_VOP3			418
> -#define SRST_P_VOPGRF			419
> -#define SRST_P_DSIHOST0			420
> -#define SRST_P_DSIHOST1			421
> -#define SRST_DSIHOST0			422
> -#define SRST_DSIHOST1			423
> -#define SRST_VOP_PMU			424
> -#define SRST_P_VOP_CHANNEL_BIU		425
> -
> -#define SRST_H_VO0_BIU			426
> -#define SRST_H_VO0_S_BIU		427
> -#define SRST_P_VO0_BIU			428
> -#define SRST_P_VO0_S_BIU		429
> -#define SRST_A_HDCP0_BIU		430
> -#define SRST_P_VO0GRF			431
> -#define SRST_H_HDCP_KEY0		432
> -#define SRST_A_HDCP0			433
> -#define SRST_H_HDCP0			434
> -#define SRST_HDCP0			435
> -
> -#define SRST_P_TRNG0			436
> -#define SRST_DP0			437
> -#define SRST_DP1			438
> -#define SRST_H_I2S4_8CH			439
> -#define SRST_M_I2S4_8CH_TX		440
> -#define SRST_H_I2S8_8CH			441
> -
> -#define SRST_M_I2S8_8CH_TX		442
> -#define SRST_H_SPDIF2_DP0		443
> -#define SRST_M_SPDIF2_DP0		444
> -#define SRST_H_SPDIF5_DP1		445
> -#define SRST_M_SPDIF5_DP1		446
> -
> -#define SRST_A_HDCP1_BIU		447
> -#define SRST_A_VO1_BIU			448
> -#define SRST_H_VOP1_BIU			449
> -#define SRST_H_VOP1_S_BIU		450
> -#define SRST_P_VOP1_BIU			451
> -#define SRST_P_VO1GRF			452
> -#define SRST_P_VO1_S_BIU		453
> -
> -#define SRST_H_I2S7_8CH			454
> -#define SRST_M_I2S7_8CH_RX		455
> -#define SRST_H_HDCP_KEY1		456
> -#define SRST_A_HDCP1			457
> -#define SRST_H_HDCP1			458
> -#define SRST_HDCP1			459
> -#define SRST_P_TRNG1			460
> -#define SRST_P_HDMITX0			461
> -
> -#define SRST_HDMITX0_REF		462
> -#define SRST_P_HDMITX1			463
> -#define SRST_HDMITX1_REF		464
> -#define SRST_A_HDMIRX			465
> -#define SRST_P_HDMIRX			466
> -#define SRST_HDMIRX_REF			467
> -
> -#define SRST_P_EDP0			468
> -#define SRST_EDP0_24M			469
> -#define SRST_P_EDP1			470
> -#define SRST_EDP1_24M			471
> -#define SRST_M_I2S5_8CH_TX		472
> -#define SRST_H_I2S5_8CH			473
> -#define SRST_M_I2S6_8CH_TX		474
> -
> -#define SRST_M_I2S6_8CH_RX		475
> -#define SRST_H_I2S6_8CH			476
> -#define SRST_H_SPDIF3			477
> -#define SRST_M_SPDIF3			478
> -#define SRST_H_SPDIF4			479
> -#define SRST_M_SPDIF4			480
> -#define SRST_H_SPDIFRX0			481
> -#define SRST_M_SPDIFRX0			482
> -#define SRST_H_SPDIFRX1			483
> -#define SRST_M_SPDIFRX1			484
> -
> -#define SRST_H_SPDIFRX2			485
> -#define SRST_M_SPDIFRX2			486
> -#define SRST_LINKSYM_HDMITXPHY0		487
> -#define SRST_LINKSYM_HDMITXPHY1		488
> -#define SRST_VO1_BRIDGE0		489
> -#define SRST_VO1_BRIDGE1		490
> -
> -#define SRST_H_I2S9_8CH			491
> -#define SRST_M_I2S9_8CH_RX		492
> -#define SRST_H_I2S10_8CH		493
> -#define SRST_M_I2S10_8CH_RX		494
> -#define SRST_P_S_HDMIRX			495
> -
> -#define SRST_GPU			496
> -#define SRST_SYS_GPU			497
> -#define SRST_A_S_GPU_BIU		498
> -#define SRST_A_M0_GPU_BIU		499
> -#define SRST_A_M1_GPU_BIU		500
> -#define SRST_A_M2_GPU_BIU		501
> -#define SRST_A_M3_GPU_BIU		502
> -#define SRST_P_GPU_BIU			503
> -#define SRST_P_GPU_PVTM			504
> -
> -#define SRST_GPU_PVTM			505
> -#define SRST_P_GPU_GRF			506
> -#define SRST_GPU_PVTPLL			507
> -#define SRST_GPU_JTAG			508
> -
> -#define SRST_A_AV1_BIU			509
> -#define SRST_A_AV1			510
> -#define SRST_P_AV1_BIU			511
> -#define SRST_P_AV1			512
> -
> -#define SRST_A_DDR_BIU			513
> -#define SRST_A_DMA2DDR			514
> -#define SRST_A_DDR_SHAREMEM		515
> -#define SRST_A_DDR_SHAREMEM_BIU		516
> -#define SRST_A_CENTER_S200_BIU		517
> -#define SRST_A_CENTER_S400_BIU		518
> -#define SRST_H_AHB2APB			519
> -#define SRST_H_CENTER_BIU		520
> -#define SRST_F_DDR_CM0_CORE		521
> -
> -#define SRST_DDR_TIMER0			522
> -#define SRST_DDR_TIMER1			523
> -#define SRST_T_WDT_DDR			524
> -#define SRST_T_DDR_CM0_JTAG		525
> -#define SRST_P_CENTER_GRF		526
> -#define SRST_P_AHB2APB			527
> -#define SRST_P_WDT			528
> -#define SRST_P_TIMER			529
> -#define SRST_P_DMA2DDR			530
> -#define SRST_P_SHAREMEM			531
> -#define SRST_P_CENTER_BIU		532
> -#define SRST_P_CENTER_CHANNEL_BIU	533
> -
> -#define SRST_P_USBDPGRF0		534
> -#define SRST_P_USBDPPHY0		535
> -#define SRST_P_USBDPGRF1		536
> -#define SRST_P_USBDPPHY1		537
> -#define SRST_P_HDPTX0			538
> -#define SRST_P_HDPTX1			539
> -#define SRST_P_APB2ASB_SLV_BOT_RIGHT	540
> -#define SRST_P_USB2PHY_U3_0_GRF0	541
> -#define SRST_P_USB2PHY_U3_1_GRF0	542
> -#define SRST_P_USB2PHY_U2_0_GRF0	543
> -#define SRST_P_USB2PHY_U2_1_GRF0	544
> -#define SRST_HDPTX0_ROPLL		545
> -#define SRST_HDPTX0_LCPLL		546
> -#define SRST_HDPTX0			547
> -#define SRST_HDPTX1_ROPLL		548
> -
> -#define SRST_HDPTX1_LCPLL		549
> -#define SRST_HDPTX1			550
> -#define SRST_HDPTX0_HDMIRXPHY_SET	551
> -#define SRST_USBDP_COMBO_PHY0		552
> -#define SRST_USBDP_COMBO_PHY0_LCPLL	553
> -#define SRST_USBDP_COMBO_PHY0_ROPLL	554
> -#define SRST_USBDP_COMBO_PHY0_PCS_HS	555
> -#define SRST_USBDP_COMBO_PHY1		556
> -#define SRST_USBDP_COMBO_PHY1_LCPLL	557
> -#define SRST_USBDP_COMBO_PHY1_ROPLL	558
> -#define SRST_USBDP_COMBO_PHY1_PCS_HS	559
> -#define SRST_HDMIHDP0			560
> -#define SRST_HDMIHDP1			561
> -
> -#define SRST_A_VO1USB_TOP_BIU		562
> -#define SRST_H_VO1USB_TOP_BIU		563
> -
> -#define SRST_H_SDIO_BIU			564
> -#define SRST_H_SDIO			565
> -#define SRST_SDIO			566
> -
> -#define SRST_H_RGA3_BIU			567
> -#define SRST_A_RGA3_BIU			568
> -#define SRST_H_RGA3_1			569
> -#define SRST_A_RGA3_1			570
> -#define SRST_RGA3_1_CORE		571
> -
> -#define SRST_REF_PIPE_PHY0		572
> -#define SRST_REF_PIPE_PHY1		573
> -#define SRST_REF_PIPE_PHY2		574
> -
> -#define SRST_P_PHPTOP_CRU		575
> -#define SRST_P_PCIE2_GRF0		576
> -#define SRST_P_PCIE2_GRF1		577
> -#define SRST_P_PCIE2_GRF2		578
> -#define SRST_P_PCIE2_PHY0		579
> -#define SRST_P_PCIE2_PHY1		580
> -#define SRST_P_PCIE2_PHY2		581
> -#define SRST_P_PCIE3_PHY		582
> -#define SRST_P_APB2ASB_SLV_CHIP_TOP	583
> -#define SRST_PCIE30_PHY			584
> -
> -#define SRST_H_PMU1_BIU			585
> -#define SRST_P_PMU1_BIU			586
> -#define SRST_H_PMU_CM0_BIU		587
> -#define SRST_F_PMU_CM0_CORE		588
> -#define SRST_T_PMU1_CM0_JTAG		589
> -
> -#define SRST_DDR_FAIL_SAFE		590
> -#define SRST_P_CRU_PMU1			591
> -#define SRST_P_PMU1_GRF			592
> -#define SRST_P_PMU1_IOC			593
> -#define SRST_P_PMU1WDT			594
> -#define SRST_T_PMU1WDT			595
> -#define SRST_P_PMU1TIMER		596
> -#define SRST_PMU1TIMER0			597
> -#define SRST_PMU1TIMER1			598
> -#define SRST_P_PMU1PWM			599
> -#define SRST_PMU1PWM			600
> -
> -#define SRST_P_I2C0			601
> -#define SRST_I2C0			602
> -#define SRST_S_UART0			603
> -#define SRST_P_UART0			604
> -#define SRST_H_I2S1_8CH			605
> -#define SRST_M_I2S1_8CH_TX		606
> -#define SRST_M_I2S1_8CH_RX		607
> -#define SRST_H_PDM0			608
> -#define SRST_PDM0			609
> -
> -#define SRST_H_VAD			610
> -#define SRST_HDPTX0_INIT		611
> -#define SRST_HDPTX0_CMN			612
> -#define SRST_HDPTX0_LANE		613
> -#define SRST_HDPTX1_INIT		614
> -
> -#define SRST_HDPTX1_CMN			615
> -#define SRST_HDPTX1_LANE		616
> -#define SRST_M_MIPI_DCPHY0		617
> -#define SRST_S_MIPI_DCPHY0		618
> -#define SRST_M_MIPI_DCPHY1		619
> -#define SRST_S_MIPI_DCPHY1		620
> -#define SRST_OTGPHY_U3_0		621
> -#define SRST_OTGPHY_U3_1		622
> -#define SRST_OTGPHY_U2_0		623
> -#define SRST_OTGPHY_U2_1		624
> -
> -#define SRST_P_PMU0GRF			625
> -#define SRST_P_PMU0IOC			626
> -#define SRST_P_GPIO0			627
> -#define SRST_GPIO0			628
> -
> -#define SRST_A_SECURE_NS_BIU		629
> -#define SRST_H_SECURE_NS_BIU		630
> -#define SRST_A_SECURE_S_BIU		631
> -#define SRST_H_SECURE_S_BIU		632
> -#define SRST_P_SECURE_S_BIU		633
> -#define SRST_CRYPTO_CORE		634
> -
> -#define SRST_CRYPTO_PKA			635
> -#define SRST_CRYPTO_RNG			636
> -#define SRST_A_CRYPTO			637
> -#define SRST_H_CRYPTO			638
> -#define SRST_KEYLADDER_CORE		639
> -#define SRST_KEYLADDER_RNG		640
> -#define SRST_A_KEYLADDER		641
> -#define SRST_H_KEYLADDER		642
> -#define SRST_P_OTPC_S			643
> -#define SRST_OTPC_S			644
> -#define SRST_WDT_S			645
> -
> -#define SRST_T_WDT_S			646
> -#define SRST_H_BOOTROM			647
> -#define SRST_A_DCF			648
> -#define SRST_P_DCF			649
> -#define SRST_H_BOOTROM_NS		650
> -#define SRST_P_KEYLADDER		651
> -#define SRST_H_TRNG_S			652
> -
> -#define SRST_H_TRNG_NS			653
> -#define SRST_D_SDMMC_BUFFER		654
> -#define SRST_H_SDMMC			655
> -#define SRST_H_SDMMC_BUFFER		656
> -#define SRST_SDMMC			657
> -#define SRST_P_TRNG_CHK			658
> -#define SRST_TRNG_S			659
> -
> -#endif
