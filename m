Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91754E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 06:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4C5800D0;
	Fri, 10 Jan 2025 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SCdofuDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB98801F5; Fri, 10 Jan 2025 07:57:53 +0100 (CET)
Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com
 [101.71.155.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FD880027
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 07:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 84fbe8e0;
 Fri, 10 Jan 2025 14:57:42 +0800 (GMT+08:00)
Message-ID: <779b8003-e97b-4fc6-9e34-af609b038eed@rock-chips.com>
Date: Fri, 10 Jan 2025 14:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: use OF_UPSTREAM for rk3066a/rk3188
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <93c8f104-8596-433d-bc28-c82034addfaa@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <93c8f104-8596-433d-bc28-c82034addfaa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkNIVkJPQh8aTEkeTB1DGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944f0124f003afkunm84fbe8e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Mio*PjIJNQ8cAT1ILjo6
 MExPCy5VSlVKTEhNT0JJSU1PTktDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUxCSUlLNwY+
DKIM-Signature: a=rsa-sha256;
 b=SCdofuDjh4I0JLVyx/M3SbgdexbgClVyeIgxR9/5tZpEeEm76LbtjRe57E7ODT8fySoy/Qvd9U25SJjILyiOminRdsNP4PqTC/gJYFb7Z+ptMzd9+ea4wQOyg/H2AakCFPdsXztVP9fLCfmn7AOndrn5d3NTplnz2FjTQPvceCc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dS2j3YQNhGe58Zrg89/at5XYPd/ULtyPKsHIqyeR0Hg=;
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


On 2024/12/16 20:44, Johan Jonker wrote:
> The device tree for rk3066a/rk3188 combined is now
> available in the /dts/upstream directory.
> Use imply OF_UPSTREAM to migrate all rk3066a/rk3188 boards.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changed V2:
>    remove Makefile entries
> ---
>   arch/arm/dts/Makefile             |   6 -
>   arch/arm/dts/rk3066a-mk808.dts    | 241 --------
>   arch/arm/dts/rk3066a-u-boot.dtsi  |  20 -
>   arch/arm/dts/rk3066a.dtsi         | 880 ------------------------------
>   arch/arm/dts/rk3188-radxarock.dts | 389 -------------
>   arch/arm/dts/rk3188-u-boot.dtsi   |  17 -
>   arch/arm/dts/rk3188.dtsi          | 815 ---------------------------
>   arch/arm/dts/rk3xxx.dtsi          | 488 -----------------
>   arch/arm/mach-rockchip/Kconfig    |   2 +
>   configs/mk808_defconfig           |   4 +-
>   configs/rock_defconfig            |   4 +-
>   11 files changed, 6 insertions(+), 2860 deletions(-)
>   delete mode 100644 arch/arm/dts/rk3066a-mk808.dts
>   delete mode 100644 arch/arm/dts/rk3066a.dtsi
>   delete mode 100644 arch/arm/dts/rk3188-radxarock.dts
>   delete mode 100644 arch/arm/dts/rk3188.dtsi
>   delete mode 100644 arch/arm/dts/rk3xxx.dtsi
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 6ad59aeed5f6..166f9628dc8a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -55,15 +55,9 @@ dtb-$(CONFIG_MACH_S700) += \
>   dtb-$(CONFIG_ROCKCHIP_RK3036) += \
>   	rk3036-sdk.dtb
>
> -dtb-$(CONFIG_ROCKCHIP_RK3066) += \
> -	rk3066a-mk808.dtb
> -
>   dtb-$(CONFIG_ROCKCHIP_RK3128) += \
>   	rk3128-evb.dtb
>
> -dtb-$(CONFIG_ROCKCHIP_RK3188) += \
> -	rk3188-radxarock.dtb
> -
>   dtb-$(CONFIG_ROCKCHIP_RK322X) += \
>   	rk3229-evb.dtb
>
> diff --git a/arch/arm/dts/rk3066a-mk808.dts b/arch/arm/dts/rk3066a-mk808.dts
> deleted file mode 100644
> index 06790f05b395..000000000000
> --- a/arch/arm/dts/rk3066a-mk808.dts
> +++ /dev/null
> @@ -1,241 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2016 Paweł Jarosz <paweljarosz3691@gmail.com>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/input.h>
> -#include "rk3066a.dtsi"
> -
> -/ {
> -	model = "Rikomagic MK808";
> -	compatible = "rikomagic,mk808", "rockchip,rk3066a";
> -
> -	aliases {
> -		mmc0 = &mmc0;
> -		mmc1 = &mmc1;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	memory@60000000 {
> -		reg = <0x60000000 0x40000000>;
> -		device_type = "memory";
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <2500000>;
> -		poll-interval = <100>;
> -
> -		button-recovery {
> -			label = "recovery";
> -			linux,code = <KEY_VENDOR>;
> -			press-threshold-microvolt = <0>;
> -		};
> -	};
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -
> -		blue_led: led-0 {
> -			label = "mk808:blue:power";
> -			gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
> -			default-state = "off";
> -			linux,default-trigger = "default-on";
> -		};
> -	};
> -
> -	hdmi_con {
> -		compatible = "hdmi-connector";
> -		type = "c";
> -
> -		port {
> -			hdmi_con_in: endpoint {
> -				remote-endpoint = <&hdmi_out_con>;
> -			};
> -		};
> -	};
> -
> -	vcc_2v5: vcc-2v5 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_2v5";
> -		regulator-min-microvolt = <2500000>;
> -		regulator-max-microvolt = <2500000>;
> -	};
> -
> -	vcc_io: vcc-io {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_io";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -	};
> -
> -	vcc_host: usb-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> -		pinctrl-0 = <&host_drv>;
> -		pinctrl-names = "default";
> -		regulator-always-on;
> -		regulator-name = "host-pwr";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -
> -	vcc_otg: usb-otg-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> -		pinctrl-0 = <&otg_drv>;
> -		pinctrl-names = "default";
> -		regulator-always-on;
> -		regulator-name = "vcc_otg";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -
> -	vcc_sd: sdmmc-regulator {
> -		compatible = "regulator-fixed";
> -		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
> -		pinctrl-0 = <&sdmmc_pwr>;
> -		pinctrl-names = "default";
> -		regulator-name = "vcc_sd";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -
> -	vcc_wifi: sdio-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-0 = <&wifi_pwr>;
> -		pinctrl-names = "default";
> -		regulator-name = "vcc_wifi";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -};
> -
> -&hdmi {
> -	status = "okay";
> -};
> -
> -&hdmi_in_vop1 {
> -	status = "disabled";
> -};
> -
> -&hdmi_out {
> -	hdmi_out_con: endpoint {
> -		remote-endpoint = <&hdmi_con_in>;
> -	};
> -};
> -
> -&mmc0 {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	vmmc-supply = <&vcc_sd>;
> -	status = "okay";
> -};
> -
> -&mmc1 {
> -	bus-width = <4>;
> -	non-removable;
> -	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
> -	pinctrl-names = "default";
> -	vmmc-supply = <&vcc_wifi>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	brcmf: wifi@1 {
> -		compatible = "brcm,bcm4329-fmac";
> -		reg = <1>;
> -	};
> -};
> -
> -&nfc {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	nand@0 {
> -		reg = <0>;
> -		label = "rk-nand";
> -		nand-bus-width = <8>;
> -		nand-ecc-mode = "hw";
> -		nand-ecc-step-size = <1024>;
> -		nand-ecc-strength = <40>;
> -		nand-is-boot-medium;
> -		rockchip,boot-blks = <8>;
> -		rockchip,boot-ecc-strength = <24>;
> -	};
> -};
> -
> -&pinctrl {
> -	usb-host {
> -		host_drv: host-drv {
> -			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_default>;
> -		};
> -	};
> -
> -	usb-otg {
> -		otg_drv: otg-drv {
> -			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_default>;
> -		};
> -	};
> -
> -	sdmmc {
> -		sdmmc_pwr: sdmmc-pwr {
> -			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_default>;
> -		};
> -	};
> -
> -	sdio {
> -		wifi_pwr: wifi-pwr {
> -			rockchip,pins = <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_2v5>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb_host {
> -	status = "okay";
> -};
> -
> -&usb_otg {
> -	status = "okay";
> -};
> -
> -&usbphy {
> -	status = "okay";
> -};
> -
> -&vop0 {
> -	status = "okay";
> -};
> -
> -&wdt {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
> index 06f405ca2c5e..d99db7853b59 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -3,26 +3,6 @@
>   #include "rockchip-u-boot.dtsi"
>   #include "rk3xxx-u-boot.dtsi"
>
> -&gpio0 {
> -	gpio-ranges = <&pinctrl 0 0 32>;
> -};
> -
> -&gpio1 {
> -	gpio-ranges = <&pinctrl 0 32 32>;
> -};
> -
> -&gpio2 {
> -	gpio-ranges = <&pinctrl 0 64 32>;
> -};
> -
> -&gpio3 {
> -	gpio-ranges = <&pinctrl 0 96 32>;
> -};
> -
> -&gpio4 {
> -	gpio-ranges = <&pinctrl 0 128 32>;
> -};
> -
>   &gpio6 {
>   	status = "disabled";
>   };
> diff --git a/arch/arm/dts/rk3066a.dtsi b/arch/arm/dts/rk3066a.dtsi
> deleted file mode 100644
> index de9915d946f7..000000000000
> --- a/arch/arm/dts/rk3066a.dtsi
> +++ /dev/null
> @@ -1,880 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3066a-cru.h>
> -#include <dt-bindings/power/rk3066-power.h>
> -#include "rk3xxx.dtsi"
> -
> -/ {
> -	compatible = "rockchip,rk3066a";
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		enable-method = "rockchip,rk3066-smp";
> -
> -		cpu0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x0>;
> -			operating-points =
> -				/* kHz    uV */
> -				<1416000 1300000>,
> -				<1200000 1175000>,
> -				<1008000 1125000>,
> -				<816000  1125000>,
> -				<600000  1100000>,
> -				<504000  1100000>,
> -				<312000  1075000>;
> -			clock-latency = <40000>;
> -			clocks = <&cru ARMCLK>;
> -		};
> -		cpu1: cpu@1 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x1>;
> -		};
> -	};
> -
> -	display-subsystem {
> -		compatible = "rockchip,display-subsystem";
> -		ports = <&vop0_out>, <&vop1_out>;
> -	};
> -
> -	sram: sram@10080000 {
> -		compatible = "mmio-sram";
> -		reg = <0x10080000 0x10000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0 0x10080000 0x10000>;
> -
> -		smp-sram@0 {
> -			compatible = "rockchip,rk3066-smp-sram";
> -			reg = <0x0 0x50>;
> -		};
> -	};
> -
> -	vop0: vop@1010c000 {
> -		compatible = "rockchip,rk3066-vop";
> -		reg = <0x1010c000 0x19c>;
> -		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_LCDC0>,
> -			 <&cru DCLK_LCDC0>,
> -			 <&cru HCLK_LCDC0>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		power-domains = <&power RK3066_PD_VIO>;
> -		resets = <&cru SRST_LCDC0_AXI>,
> -			 <&cru SRST_LCDC0_AHB>,
> -			 <&cru SRST_LCDC0_DCLK>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vop0_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vop0_out_hdmi: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&hdmi_in_vop0>;
> -			};
> -		};
> -	};
> -
> -	vop1: vop@1010e000 {
> -		compatible = "rockchip,rk3066-vop";
> -		reg = <0x1010e000 0x19c>;
> -		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_LCDC1>,
> -			 <&cru DCLK_LCDC1>,
> -			 <&cru HCLK_LCDC1>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		power-domains = <&power RK3066_PD_VIO>;
> -		resets = <&cru SRST_LCDC1_AXI>,
> -			 <&cru SRST_LCDC1_AHB>,
> -			 <&cru SRST_LCDC1_DCLK>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vop1_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			vop1_out_hdmi: endpoint@0 {
> -				reg = <0>;
> -				remote-endpoint = <&hdmi_in_vop1>;
> -			};
> -		};
> -	};
> -
> -	hdmi: hdmi@10116000 {
> -		compatible = "rockchip,rk3066-hdmi";
> -		reg = <0x10116000 0x2000>;
> -		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_HDMI>;
> -		clock-names = "hclk";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
> -		power-domains = <&power RK3066_PD_VIO>;
> -		rockchip,grf = <&grf>;
> -		status = "disabled";
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			hdmi_in: port@0 {
> -				reg = <0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				hdmi_in_vop0: endpoint@0 {
> -					reg = <0>;
> -					remote-endpoint = <&vop0_out_hdmi>;
> -				};
> -
> -				hdmi_in_vop1: endpoint@1 {
> -					reg = <1>;
> -					remote-endpoint = <&vop1_out_hdmi>;
> -				};
> -			};
> -
> -			hdmi_out: port@1 {
> -				reg = <1>;
> -			};
> -		};
> -	};
> -
> -	i2s0: i2s@10118000 {
> -		compatible = "rockchip,rk3066-i2s";
> -		reg = <0x10118000 0x2000>;
> -		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s0_bus>;
> -		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		dmas = <&dmac1_s 4>, <&dmac1_s 5>;
> -		dma-names = "tx", "rx";
> -		rockchip,playback-channels = <8>;
> -		rockchip,capture-channels = <2>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s1: i2s@1011a000 {
> -		compatible = "rockchip,rk3066-i2s";
> -		reg = <0x1011a000 0x2000>;
> -		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s1_bus>;
> -		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
> -		dma-names = "tx", "rx";
> -		rockchip,playback-channels = <2>;
> -		rockchip,capture-channels = <2>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	i2s2: i2s@1011c000 {
> -		compatible = "rockchip,rk3066-i2s";
> -		reg = <0x1011c000 0x2000>;
> -		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s2_bus>;
> -		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		dmas = <&dmac1_s 9>, <&dmac1_s 10>;
> -		dma-names = "tx", "rx";
> -		rockchip,playback-channels = <2>;
> -		rockchip,capture-channels = <2>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	cru: clock-controller@20000000 {
> -		compatible = "rockchip,rk3066a-cru";
> -		reg = <0x20000000 0x1000>;
> -		clocks = <&xin24m>;
> -		clock-names = "xin24m";
> -		rockchip,grf = <&grf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		assigned-clocks = <&cru PLL_CPLL>, <&cru PLL_GPLL>,
> -				  <&cru ACLK_CPU>, <&cru HCLK_CPU>,
> -				  <&cru PCLK_CPU>, <&cru ACLK_PERI>,
> -				  <&cru HCLK_PERI>, <&cru PCLK_PERI>;
> -		assigned-clock-rates = <400000000>, <594000000>,
> -				       <300000000>, <150000000>,
> -				       <75000000>, <300000000>,
> -				       <150000000>, <75000000>;
> -	};
> -
> -	timer2: timer@2000e000 {
> -		compatible = "snps,dw-apb-timer";
> -		reg = <0x2000e000 0x100>;
> -		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
> -		clock-names = "timer", "pclk";
> -	};
> -
> -	efuse: efuse@20010000 {
> -		compatible = "rockchip,rk3066a-efuse";
> -		reg = <0x20010000 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&cru PCLK_EFUSE>;
> -		clock-names = "pclk_efuse";
> -
> -		cpu_leakage: cpu_leakage@17 {
> -			reg = <0x17 0x1>;
> -		};
> -	};
> -
> -	timer0: timer@20038000 {
> -		compatible = "snps,dw-apb-timer";
> -		reg = <0x20038000 0x100>;
> -		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
> -		clock-names = "timer", "pclk";
> -	};
> -
> -	timer1: timer@2003a000 {
> -		compatible = "snps,dw-apb-timer";
> -		reg = <0x2003a000 0x100>;
> -		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
> -		clock-names = "timer", "pclk";
> -	};
> -
> -	tsadc: tsadc@20060000 {
> -		compatible = "rockchip,rk3066-tsadc";
> -		reg = <0x20060000 0x100>;
> -		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> -		clock-names = "saradc", "apb_pclk";
> -		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> -		#io-channel-cells = <1>;
> -		resets = <&cru SRST_TSADC>;
> -		reset-names = "saradc-apb";
> -		status = "disabled";
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible = "rockchip,rk3066a-pinctrl";
> -		rockchip,grf = <&grf>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		gpio0: gpio@20034000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x20034000 0x100>;
> -			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio1: gpio@2003c000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x2003c000 0x100>;
> -			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO1>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio2: gpio@2003e000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x2003e000 0x100>;
> -			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO2>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio3: gpio@20080000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x20080000 0x100>;
> -			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO3>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio4: gpio@20084000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x20084000 0x100>;
> -			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO4>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio6: gpio@2000a000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x2000a000 0x100>;
> -			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO6>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		pcfg_pull_default: pcfg-pull-default {
> -			bias-pull-pin-default;
> -		};
> -
> -		pcfg_pull_none: pcfg-pull-none {
> -			bias-disable;
> -		};
> -
> -		emac {
> -			emac_xfer: emac-xfer {
> -				rockchip,pins = <1 RK_PC0 2 &pcfg_pull_none>, /* mac_clk */
> -						<1 RK_PC1 2 &pcfg_pull_none>, /* tx_en */
> -						<1 RK_PC2 2 &pcfg_pull_none>, /* txd1 */
> -						<1 RK_PC3 2 &pcfg_pull_none>, /* txd0 */
> -						<1 RK_PC4 2 &pcfg_pull_none>, /* rx_err */
> -						<1 RK_PC5 2 &pcfg_pull_none>, /* crs_dvalid */
> -						<1 RK_PC6 2 &pcfg_pull_none>, /* rxd1 */
> -						<1 RK_PC7 2 &pcfg_pull_none>; /* rxd0 */
> -			};
> -
> -			emac_mdio: emac-mdio {
> -				rockchip,pins = <1 RK_PD0 2 &pcfg_pull_none>, /* mac_md */
> -						<1 RK_PD1 2 &pcfg_pull_none>; /* mac_mdclk */
> -			};
> -		};
> -
> -		emmc {
> -			emmc_clk: emmc-clk {
> -				rockchip,pins = <3 RK_PD7 2 &pcfg_pull_default>;
> -			};
> -
> -			emmc_cmd: emmc-cmd {
> -				rockchip,pins = <4 RK_PB1 2 &pcfg_pull_default>;
> -			};
> -
> -			emmc_rst: emmc-rst {
> -				rockchip,pins = <4 RK_PB2 2 &pcfg_pull_default>;
> -			};
> -
> -			/*
> -			 * The data pins are shared between nandc and emmc and
> -			 * not accessible through pinctrl. Also they should've
> -			 * been already set correctly by firmware, as
> -			 * flash/emmc is the boot-device.
> -			 */
> -		};
> -
> -		hdmi {
> -			hdmi_hpd: hdmi-hpd {
> -				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
> -			};
> -
> -			hdmii2c_xfer: hdmii2c-xfer {
> -				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
> -						<0 RK_PA2 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c0 {
> -			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins = <2 RK_PD4 1 &pcfg_pull_none>,
> -						<2 RK_PD5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c1 {
> -			i2c1_xfer: i2c1-xfer {
> -				rockchip,pins = <2 RK_PD6 1 &pcfg_pull_none>,
> -						<2 RK_PD7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c2 {
> -			i2c2_xfer: i2c2-xfer {
> -				rockchip,pins = <3 RK_PA0 1 &pcfg_pull_none>,
> -						<3 RK_PA1 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c3 {
> -			i2c3_xfer: i2c3-xfer {
> -				rockchip,pins = <3 RK_PA2 2 &pcfg_pull_none>,
> -						<3 RK_PA3 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c4 {
> -			i2c4_xfer: i2c4-xfer {
> -				rockchip,pins = <3 RK_PA4 1 &pcfg_pull_none>,
> -						<3 RK_PA5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm0 {
> -			pwm0_out: pwm0-out {
> -				rockchip,pins = <0 RK_PA3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm1 {
> -			pwm1_out: pwm1-out {
> -				rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm2 {
> -			pwm2_out: pwm2-out {
> -				rockchip,pins = <0 RK_PD6 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm3 {
> -			pwm3_out: pwm3-out {
> -				rockchip,pins = <0 RK_PD7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		spi0 {
> -			spi0_clk: spi0-clk {
> -				rockchip,pins = <1 RK_PA5 2 &pcfg_pull_default>;
> -			};
> -			spi0_cs0: spi0-cs0 {
> -				rockchip,pins = <1 RK_PA4 2 &pcfg_pull_default>;
> -			};
> -			spi0_tx: spi0-tx {
> -				rockchip,pins = <1 RK_PA7 2 &pcfg_pull_default>;
> -			};
> -			spi0_rx: spi0-rx {
> -				rockchip,pins = <1 RK_PA6 2 &pcfg_pull_default>;
> -			};
> -			spi0_cs1: spi0-cs1 {
> -				rockchip,pins = <4 RK_PB7 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		spi1 {
> -			spi1_clk: spi1-clk {
> -				rockchip,pins = <2 RK_PC3 2 &pcfg_pull_default>;
> -			};
> -			spi1_cs0: spi1-cs0 {
> -				rockchip,pins = <2 RK_PC4 2 &pcfg_pull_default>;
> -			};
> -			spi1_rx: spi1-rx {
> -				rockchip,pins = <2 RK_PC6 2 &pcfg_pull_default>;
> -			};
> -			spi1_tx: spi1-tx {
> -				rockchip,pins = <2 RK_PC5 2 &pcfg_pull_default>;
> -			};
> -			spi1_cs1: spi1-cs1 {
> -				rockchip,pins = <2 RK_PC7 2 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		uart0 {
> -			uart0_xfer: uart0-xfer {
> -				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_default>,
> -						<1 RK_PA1 1 &pcfg_pull_default>;
> -			};
> -
> -			uart0_cts: uart0-cts {
> -				rockchip,pins = <1 RK_PA2 1 &pcfg_pull_default>;
> -			};
> -
> -			uart0_rts: uart0-rts {
> -				rockchip,pins = <1 RK_PA3 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		uart1 {
> -			uart1_xfer: uart1-xfer {
> -				rockchip,pins = <1 RK_PA4 1 &pcfg_pull_default>,
> -						<1 RK_PA5 1 &pcfg_pull_default>;
> -			};
> -
> -			uart1_cts: uart1-cts {
> -				rockchip,pins = <1 RK_PA6 1 &pcfg_pull_default>;
> -			};
> -
> -			uart1_rts: uart1-rts {
> -				rockchip,pins = <1 RK_PA7 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		uart2 {
> -			uart2_xfer: uart2-xfer {
> -				rockchip,pins = <1 RK_PB0 1 &pcfg_pull_default>,
> -						<1 RK_PB1 1 &pcfg_pull_default>;
> -			};
> -			/* no rts / cts for uart2 */
> -		};
> -
> -		uart3 {
> -			uart3_xfer: uart3-xfer {
> -				rockchip,pins = <3 RK_PD3 1 &pcfg_pull_default>,
> -						<3 RK_PD4 1 &pcfg_pull_default>;
> -			};
> -
> -			uart3_cts: uart3-cts {
> -				rockchip,pins = <3 RK_PD5 1 &pcfg_pull_default>;
> -			};
> -
> -			uart3_rts: uart3-rts {
> -				rockchip,pins = <3 RK_PD6 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		sd0 {
> -			sd0_clk: sd0-clk {
> -				rockchip,pins = <3 RK_PB0 1 &pcfg_pull_default>;
> -			};
> -
> -			sd0_cmd: sd0-cmd {
> -				rockchip,pins = <3 RK_PB1 1 &pcfg_pull_default>;
> -			};
> -
> -			sd0_cd: sd0-cd {
> -				rockchip,pins = <3 RK_PB6 1 &pcfg_pull_default>;
> -			};
> -
> -			sd0_wp: sd0-wp {
> -				rockchip,pins = <3 RK_PB7 1 &pcfg_pull_default>;
> -			};
> -
> -			sd0_bus1: sd0-bus-width1 {
> -				rockchip,pins = <3 RK_PB2 1 &pcfg_pull_default>;
> -			};
> -
> -			sd0_bus4: sd0-bus-width4 {
> -				rockchip,pins = <3 RK_PB2 1 &pcfg_pull_default>,
> -						<3 RK_PB3 1 &pcfg_pull_default>,
> -						<3 RK_PB4 1 &pcfg_pull_default>,
> -						<3 RK_PB5 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		sd1 {
> -			sd1_clk: sd1-clk {
> -				rockchip,pins = <3 RK_PC5 1 &pcfg_pull_default>;
> -			};
> -
> -			sd1_cmd: sd1-cmd {
> -				rockchip,pins = <3 RK_PC0 1 &pcfg_pull_default>;
> -			};
> -
> -			sd1_cd: sd1-cd {
> -				rockchip,pins = <3 RK_PC6 1 &pcfg_pull_default>;
> -			};
> -
> -			sd1_wp: sd1-wp {
> -				rockchip,pins = <3 RK_PC7 1 &pcfg_pull_default>;
> -			};
> -
> -			sd1_bus1: sd1-bus-width1 {
> -				rockchip,pins = <3 RK_PC1 1 &pcfg_pull_default>;
> -			};
> -
> -			sd1_bus4: sd1-bus-width4 {
> -				rockchip,pins = <3 RK_PC1 1 &pcfg_pull_default>,
> -						<3 RK_PC2 1 &pcfg_pull_default>,
> -						<3 RK_PC3 1 &pcfg_pull_default>,
> -						<3 RK_PC4 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		i2s0 {
> -			i2s0_bus: i2s0-bus {
> -				rockchip,pins = <0 RK_PA7 1 &pcfg_pull_default>,
> -						<0 RK_PB0 1 &pcfg_pull_default>,
> -						<0 RK_PB1 1 &pcfg_pull_default>,
> -						<0 RK_PB2 1 &pcfg_pull_default>,
> -						<0 RK_PB3 1 &pcfg_pull_default>,
> -						<0 RK_PB4 1 &pcfg_pull_default>,
> -						<0 RK_PB5 1 &pcfg_pull_default>,
> -						<0 RK_PB6 1 &pcfg_pull_default>,
> -						<0 RK_PB7 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		i2s1 {
> -			i2s1_bus: i2s1-bus {
> -				rockchip,pins = <0 RK_PC0 1 &pcfg_pull_default>,
> -						<0 RK_PC1 1 &pcfg_pull_default>,
> -						<0 RK_PC2 1 &pcfg_pull_default>,
> -						<0 RK_PC3 1 &pcfg_pull_default>,
> -						<0 RK_PC4 1 &pcfg_pull_default>,
> -						<0 RK_PC5 1 &pcfg_pull_default>;
> -			};
> -		};
> -
> -		i2s2 {
> -			i2s2_bus: i2s2-bus {
> -				rockchip,pins = <0 RK_PD0 1 &pcfg_pull_default>,
> -						<0 RK_PD1 1 &pcfg_pull_default>,
> -						<0 RK_PD2 1 &pcfg_pull_default>,
> -						<0 RK_PD3 1 &pcfg_pull_default>,
> -						<0 RK_PD4 1 &pcfg_pull_default>,
> -						<0 RK_PD5 1 &pcfg_pull_default>;
> -			};
> -		};
> -	};
> -};
> -
> -&gpu {
> -	compatible = "rockchip,rk3066-mali", "arm,mali-400";
> -	interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-names = "gp",
> -			  "gpmmu",
> -			  "pp0",
> -			  "ppmmu0",
> -			  "pp1",
> -			  "ppmmu1",
> -			  "pp2",
> -			  "ppmmu2",
> -			  "pp3",
> -			  "ppmmu3";
> -	power-domains = <&power RK3066_PD_GPU>;
> -};
> -
> -&grf {
> -	compatible = "rockchip,rk3066-grf", "syscon", "simple-mfd";
> -
> -	usbphy: usbphy {
> -		compatible = "rockchip,rk3066a-usb-phy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		usbphy0: usb-phy@17c {
> -			reg = <0x17c>;
> -			clocks = <&cru SCLK_OTGPHY0>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -		};
> -
> -		usbphy1: usb-phy@188 {
> -			reg = <0x188>;
> -			clocks = <&cru SCLK_OTGPHY1>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0_xfer>;
> -};
> -
> -&i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_xfer>;
> -};
> -
> -&i2c2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_xfer>;
> -};
> -
> -&i2c3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c3_xfer>;
> -};
> -
> -&i2c4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c4_xfer>;
> -};
> -
> -&mmc0 {
> -	clock-frequency = <50000000>;
> -	dmas = <&dmac2 1>;
> -	dma-names = "rx-tx";
> -	max-frequency = <50000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
> -};
> -
> -&mmc1 {
> -	dmas = <&dmac2 3>;
> -	dma-names = "rx-tx";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_cd &sd1_bus4>;
> -};
> -
> -&emmc {
> -	dmas = <&dmac2 4>;
> -	dma-names = "rx-tx";
> -};
> -
> -&pmu {
> -	power: power-controller {
> -		compatible = "rockchip,rk3066-power-controller";
> -		#power-domain-cells = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		power-domain@RK3066_PD_VIO {
> -			reg = <RK3066_PD_VIO>;
> -			clocks = <&cru ACLK_LCDC0>,
> -				 <&cru ACLK_LCDC1>,
> -				 <&cru DCLK_LCDC0>,
> -				 <&cru DCLK_LCDC1>,
> -				 <&cru HCLK_LCDC0>,
> -				 <&cru HCLK_LCDC1>,
> -				 <&cru SCLK_CIF1>,
> -				 <&cru ACLK_CIF1>,
> -				 <&cru HCLK_CIF1>,
> -				 <&cru SCLK_CIF0>,
> -				 <&cru ACLK_CIF0>,
> -				 <&cru HCLK_CIF0>,
> -				 <&cru HCLK_HDMI>,
> -				 <&cru ACLK_IPP>,
> -				 <&cru HCLK_IPP>,
> -				 <&cru ACLK_RGA>,
> -				 <&cru HCLK_RGA>;
> -			pm_qos = <&qos_lcdc0>,
> -				 <&qos_lcdc1>,
> -				 <&qos_cif0>,
> -				 <&qos_cif1>,
> -				 <&qos_ipp>,
> -				 <&qos_rga>;
> -			#power-domain-cells = <0>;
> -		};
> -
> -		power-domain@RK3066_PD_VIDEO {
> -			reg = <RK3066_PD_VIDEO>;
> -			clocks = <&cru ACLK_VDPU>,
> -				 <&cru ACLK_VEPU>,
> -				 <&cru HCLK_VDPU>,
> -				 <&cru HCLK_VEPU>;
> -			pm_qos = <&qos_vpu>;
> -			#power-domain-cells = <0>;
> -		};
> -
> -		power-domain@RK3066_PD_GPU {
> -			reg = <RK3066_PD_GPU>;
> -			clocks = <&cru ACLK_GPU>;
> -			pm_qos = <&qos_gpu>;
> -			#power-domain-cells = <0>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm0_out>;
> -};
> -
> -&pwm1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm1_out>;
> -};
> -
> -&pwm2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm2_out>;
> -};
> -
> -&pwm3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm3_out>;
> -};
> -
> -&spi0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -};
> -
> -&spi1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -};
> -
> -&uart0 {
> -	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -	dmas = <&dmac1_s 0>, <&dmac1_s 1>;
> -	dma-names = "tx", "rx";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer>;
> -};
> -
> -&uart1 {
> -	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -	dmas = <&dmac1_s 2>, <&dmac1_s 3>;
> -	dma-names = "tx", "rx";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1_xfer>;
> -};
> -
> -&uart2 {
> -	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -	dmas = <&dmac2 6>, <&dmac2 7>;
> -	dma-names = "tx", "rx";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart2_xfer>;
> -};
> -
> -&uart3 {
> -	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
> -	dmas = <&dmac2 8>, <&dmac2 9>;
> -	dma-names = "tx", "rx";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart3_xfer>;
> -};
> -
> -&vpu {
> -	power-domains = <&power RK3066_PD_VIDEO>;
> -};
> -
> -&wdt {
> -	compatible = "rockchip,rk3066-wdt", "snps,dw-wdt";
> -};
> -
> -&emac {
> -	compatible = "rockchip,rk3066-emac";
> -};
> diff --git a/arch/arm/dts/rk3188-radxarock.dts b/arch/arm/dts/rk3188-radxarock.dts
> deleted file mode 100644
> index 118deacd38c4..000000000000
> --- a/arch/arm/dts/rk3188-radxarock.dts
> +++ /dev/null
> @@ -1,389 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/input/input.h>
> -#include "rk3188.dtsi"
> -
> -/ {
> -	model = "Radxa Rock";
> -	compatible = "radxa,rock", "rockchip,rk3188";
> -
> -	aliases {
> -		mmc0 = &mmc0;
> -	};
> -
> -	memory@60000000 {
> -		device_type = "memory";
> -		reg = <0x60000000 0x80000000>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -
> -		key-power {
> -			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> -			linux,code = <KEY_POWER>;
> -			label = "GPIO Key Power";
> -			linux,input-type = <1>;
> -			wakeup-source;
> -			debounce-interval = <100>;
> -		};
> -	};
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -
> -		green_led: led-0 {
> -			label = "rock:green:user1";
> -			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
> -		};
> -
> -		blue_led: led-1 {
> -			label = "rock:blue:user2";
> -			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
> -		};
> -
> -		sleep_led: led-2 {
> -			label = "rock:red:power";
> -			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> -			default-state = "off";
> -		};
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "SPDIF";
> -
> -		simple-audio-card,dai-link@1 {  /* S/PDIF - S/PDIF */
> -			cpu { sound-dai = <&spdif>; };
> -			codec { sound-dai = <&spdif_out>; };
> -		};
> -	};
> -
> -	spdif_out: spdif-out {
> -		compatible = "linux,spdif-dit";
> -		#sound-dai-cells = <0>;
> -	};
> -
> -	ir_recv: ir-receiver {
> -		compatible = "gpio-ir-receiver";
> -		gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ir_recv_pin>;
> -	};
> -
> -	vcc_otg: usb-otg-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&otg_vbus_drv>;
> -		regulator-name = "otg-vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc_sd0: sdmmc-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "sdmmc-supply";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&sdmmc_pwr>;
> -		startup-delay-us = <100000>;
> -		vin-supply = <&vcc_io>;
> -	};
> -
> -	vcc_host: usb-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&host_vbus_drv>;
> -		regulator-name = "host-pwr";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vsys: vsys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vsys";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&emac {
> -	phy = <&phy0>;
> -	phy-supply = <&vcc_rmii>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&phy_int>;
> -	status = "okay";
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		phy0: ethernet-phy@0 {
> -			reg = <0>;
> -			interrupt-parent = <&gpio3>;
> -			interrupts = <RK_PD2 IRQ_TYPE_LEVEL_LOW>;
> -		};
> -	};
> -};
> -
> -&cpu0 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu1 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu2 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu3 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&gpu {
> -	status = "okay";
> -};
> -
> -&i2c1 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB5 IRQ_TYPE_EDGE_FALLING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtc_int>;
> -		#clock-cells = <0>;
> -		clock-output-names = "xin32k";
> -	};
> -
> -	act8846: act8846@5a {
> -		compatible = "active-semi,act8846";
> -		reg = <0x5a>;
> -		status = "okay";
> -		system-power-controller;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&act8846_dvs0_ctl>;
> -
> -		vp1-supply = <&vsys>;
> -		vp2-supply = <&vsys>;
> -		vp3-supply = <&vsys>;
> -		vp4-supply = <&vsys>;
> -		inl1-supply = <&vcc_io>;
> -		inl2-supply = <&vsys>;
> -		inl3-supply = <&vsys>;
> -
> -		regulators {
> -			vcc_ddr: REG1 {
> -				regulator-name = "VCC_DDR";
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_log: REG2 {
> -				regulator-name = "VDD_LOG";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_arm: REG3 {
> -				regulator-name = "VDD_ARM";
> -				regulator-min-microvolt = <875000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-always-on;
> -			};
> -
> -			vcc_io: REG4 {
> -				regulator-name = "VCC_IO";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_10: REG5 {
> -				regulator-name = "VDD_10";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -			};
> -
> -			vdd_hdmi: REG6 {
> -				regulator-name = "VDD_HDMI";
> -				regulator-min-microvolt = <2500000>;
> -				regulator-max-microvolt = <2500000>;
> -				regulator-always-on;
> -			};
> -
> -			vcc18: REG7 {
> -				regulator-name = "VCC_18";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			vcca_33: REG8 {
> -				regulator-name = "VCCA_33";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vcc_rmii: REG9 {
> -				regulator-name = "VCC_RMII";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			vccio_wl: REG10 {
> -				regulator-name = "VCCIO_WL";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -			};
> -
> -			vcc_18: REG11 {
> -				regulator-name = "VCC18_IO";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -			};
> -
> -			vcc28: REG12 {
> -				regulator-name = "VCC_28";
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -				regulator-always-on;
> -			};
> -		};
> -	};
> -};
> -
> -&mmc0 {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
> -	vmmc-supply = <&vcc_sd0>;
> -
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&pwm3 {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	pcfg_output_low: pcfg-output-low {
> -		output-low;
> -	};
> -
> -	act8846 {
> -		act8846_dvs0_ctl: act8846-dvs0-ctl {
> -			rockchip,pins = <3 RK_PD3 RK_FUNC_GPIO &pcfg_output_low>;
> -		};
> -	};
> -
> -	hym8563 {
> -		rtc_int: rtc-int {
> -			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	lan8720a  {
> -		phy_int: phy-int {
> -			rockchip,pins = <3 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	ir-receiver {
> -		ir_recv_pin: ir-recv-pin {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	sd0 {
> -		sdmmc_pwr: sdmmc-pwr {
> -			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	usb {
> -		host_vbus_drv: host-vbus-drv {
> -			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -		otg_vbus_drv: otg-vbus-drv {
> -			rockchip,pins = <2 RK_PD7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&spdif {
> -	status = "okay";
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
> -&usbphy {
> -	status = "okay";
> -};
> -
> -&usb_host {
> -	status = "okay";
> -};
> -
> -&usb_otg {
> -	status = "okay";
> -};
> -
> -&wdt {
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3188-u-boot.dtsi b/arch/arm/dts/rk3188-u-boot.dtsi
> index 176f9e65c267..8f2849dda241 100644
> --- a/arch/arm/dts/rk3188-u-boot.dtsi
> +++ b/arch/arm/dts/rk3188-u-boot.dtsi
> @@ -6,25 +6,8 @@
>   #include "rockchip-u-boot.dtsi"
>   #include "rk3xxx-u-boot.dtsi"
>
> -&global_timer {
> -	status = "okay";
> -};
> -
>   &gpio0 {
>   	compatible = "rockchip,gpio-bank";
> -	gpio-ranges = <&pinctrl 0 0 32>;
> -};
> -
> -&gpio1 {
> -	gpio-ranges = <&pinctrl 0 32 32>;
> -};
> -
> -&gpio2 {
> -	gpio-ranges = <&pinctrl 0 64 32>;
> -};
> -
> -&gpio3 {
> -	gpio-ranges = <&pinctrl 0 96 32>;
>   };
>
>   &pmu {
> diff --git a/arch/arm/dts/rk3188.dtsi b/arch/arm/dts/rk3188.dtsi
> deleted file mode 100644
> index 44b54af0bbf9..000000000000
> --- a/arch/arm/dts/rk3188.dtsi
> +++ /dev/null
> @@ -1,815 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3188-cru.h>
> -#include <dt-bindings/power/rk3188-power.h>
> -#include "rk3xxx.dtsi"
> -
> -/ {
> -	compatible = "rockchip,rk3188";
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		enable-method = "rockchip,rk3066-smp";
> -
> -		cpu0: cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x0>;
> -			clock-latency = <40000>;
> -			clocks = <&cru ARMCLK>;
> -			operating-points-v2 = <&cpu0_opp_table>;
> -			resets = <&cru SRST_CORE0>;
> -		};
> -		cpu1: cpu@1 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x1>;
> -			operating-points-v2 = <&cpu0_opp_table>;
> -			resets = <&cru SRST_CORE1>;
> -		};
> -		cpu2: cpu@2 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x2>;
> -			operating-points-v2 = <&cpu0_opp_table>;
> -			resets = <&cru SRST_CORE2>;
> -		};
> -		cpu3: cpu@3 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a9";
> -			next-level-cache = <&L2>;
> -			reg = <0x3>;
> -			operating-points-v2 = <&cpu0_opp_table>;
> -			resets = <&cru SRST_CORE3>;
> -		};
> -	};
> -
> -	cpu0_opp_table: opp-table-0 {
> -		compatible = "operating-points-v2";
> -		opp-shared;
> -
> -		opp-312000000 {
> -			opp-hz = /bits/ 64 <312000000>;
> -			opp-microvolt = <875000>;
> -			clock-latency-ns = <40000>;
> -		};
> -		opp-504000000 {
> -			opp-hz = /bits/ 64 <504000000>;
> -			opp-microvolt = <925000>;
> -		};
> -		opp-600000000 {
> -			opp-hz = /bits/ 64 <600000000>;
> -			opp-microvolt = <950000>;
> -			opp-suspend;
> -		};
> -		opp-816000000 {
> -			opp-hz = /bits/ 64 <816000000>;
> -			opp-microvolt = <975000>;
> -		};
> -		opp-1008000000 {
> -			opp-hz = /bits/ 64 <1008000000>;
> -			opp-microvolt = <1075000>;
> -		};
> -		opp-1200000000 {
> -			opp-hz = /bits/ 64 <1200000000>;
> -			opp-microvolt = <1150000>;
> -		};
> -		opp-1416000000 {
> -			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1250000>;
> -		};
> -		opp-1608000000 {
> -			opp-hz = /bits/ 64 <1608000000>;
> -			opp-microvolt = <1350000>;
> -		};
> -	};
> -
> -	display-subsystem {
> -		compatible = "rockchip,display-subsystem";
> -		ports = <&vop0_out>, <&vop1_out>;
> -	};
> -
> -	sram: sram@10080000 {
> -		compatible = "mmio-sram";
> -		reg = <0x10080000 0x8000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges = <0 0x10080000 0x8000>;
> -
> -		smp-sram@0 {
> -			compatible = "rockchip,rk3066-smp-sram";
> -			reg = <0x0 0x50>;
> -		};
> -	};
> -
> -	vop0: vop@1010c000 {
> -		compatible = "rockchip,rk3188-vop";
> -		reg = <0x1010c000 0x1000>;
> -		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_LCDC0>, <&cru DCLK_LCDC0>, <&cru HCLK_LCDC0>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		power-domains = <&power RK3188_PD_VIO>;
> -		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vop0_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -	};
> -
> -	vop1: vop@1010e000 {
> -		compatible = "rockchip,rk3188-vop";
> -		reg = <0x1010e000 0x1000>;
> -		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_LCDC1>, <&cru DCLK_LCDC1>, <&cru HCLK_LCDC1>;
> -		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
> -		power-domains = <&power RK3188_PD_VIO>;
> -		resets = <&cru SRST_LCDC1_AXI>, <&cru SRST_LCDC1_AHB>, <&cru SRST_LCDC1_DCLK>;
> -		reset-names = "axi", "ahb", "dclk";
> -		status = "disabled";
> -
> -		vop1_out: port {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -		};
> -	};
> -
> -	timer3: timer@2000e000 {
> -		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
> -		reg = <0x2000e000 0x20>;
> -		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru PCLK_TIMER3>, <&cru SCLK_TIMER3>;
> -		clock-names = "pclk", "timer";
> -	};
> -
> -	timer6: timer@200380a0 {
> -		compatible = "rockchip,rk3188-timer", "rockchip,rk3288-timer";
> -		reg = <0x200380a0 0x20>;
> -		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru PCLK_TIMER0>, <&cru SCLK_TIMER6>;
> -		clock-names = "pclk", "timer";
> -	};
> -
> -	i2s0: i2s@1011a000 {
> -		compatible = "rockchip,rk3188-i2s", "rockchip,rk3066-i2s";
> -		reg = <0x1011a000 0x2000>;
> -		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&i2s0_bus>;
> -		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0>;
> -		clock-names = "i2s_clk", "i2s_hclk";
> -		dmas = <&dmac1_s 6>, <&dmac1_s 7>;
> -		dma-names = "tx", "rx";
> -		rockchip,playback-channels = <2>;
> -		rockchip,capture-channels = <2>;
> -		#sound-dai-cells = <0>;
> -		status = "disabled";
> -	};
> -
> -	spdif: sound@1011e000 {
> -		compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
> -		reg = <0x1011e000 0x2000>;
> -		#sound-dai-cells = <0>;
> -		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
> -		clock-names = "mclk", "hclk";
> -		dmas = <&dmac1_s 8>;
> -		dma-names = "tx";
> -		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spdif_tx>;
> -		status = "disabled";
> -	};
> -
> -	cru: clock-controller@20000000 {
> -		compatible = "rockchip,rk3188-cru";
> -		reg = <0x20000000 0x1000>;
> -		clocks = <&xin24m>;
> -		clock-names = "xin24m";
> -		rockchip,grf = <&grf>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -	efuse: efuse@20010000 {
> -		compatible = "rockchip,rk3188-efuse";
> -		reg = <0x20010000 0x4000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&cru PCLK_EFUSE>;
> -		clock-names = "pclk_efuse";
> -
> -		cpu_leakage: cpu_leakage@17 {
> -			reg = <0x17 0x1>;
> -		};
> -	};
> -
> -	pinctrl: pinctrl {
> -		compatible = "rockchip,rk3188-pinctrl";
> -		rockchip,grf = <&grf>;
> -		rockchip,pmu = <&pmu>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		gpio0: gpio@2000a000 {
> -			compatible = "rockchip,rk3188-gpio-bank0";
> -			reg = <0x2000a000 0x100>;
> -			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO0>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio1: gpio@2003c000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x2003c000 0x100>;
> -			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO1>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio2: gpio@2003e000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x2003e000 0x100>;
> -			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO2>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		gpio3: gpio@20080000 {
> -			compatible = "rockchip,gpio-bank";
> -			reg = <0x20080000 0x100>;
> -			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cru PCLK_GPIO3>;
> -
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -
> -		pcfg_pull_up: pcfg-pull-up {
> -			bias-pull-up;
> -		};
> -
> -		pcfg_pull_down: pcfg-pull-down {
> -			bias-pull-down;
> -		};
> -
> -		pcfg_pull_none: pcfg-pull-none {
> -			bias-disable;
> -		};
> -
> -		emmc {
> -			emmc_clk: emmc-clk {
> -				rockchip,pins = <0 RK_PD0 2 &pcfg_pull_none>;
> -			};
> -
> -			emmc_cmd: emmc-cmd {
> -				rockchip,pins = <0 RK_PD2 2 &pcfg_pull_up>;
> -			};
> -
> -			emmc_rst: emmc-rst {
> -				rockchip,pins = <0 RK_PD3 2 &pcfg_pull_none>;
> -			};
> -
> -			/*
> -			 * The data pins are shared between nandc and emmc and
> -			 * not accessible through pinctrl. Also they should've
> -			 * been already set correctly by firmware, as
> -			 * flash/emmc is the boot-device.
> -			 */
> -		};
> -
> -		emac {
> -			emac_xfer: emac-xfer {
> -				rockchip,pins = <3 RK_PC0 2 &pcfg_pull_none>, /* tx_en */
> -						<3 RK_PC1 2 &pcfg_pull_none>, /* txd1 */
> -						<3 RK_PC2 2 &pcfg_pull_none>, /* txd0 */
> -						<3 RK_PC3 2 &pcfg_pull_none>, /* rxd0 */
> -						<3 RK_PC4 2 &pcfg_pull_none>, /* rxd1 */
> -						<3 RK_PC5 2 &pcfg_pull_none>, /* mac_clk */
> -						<3 RK_PC6 2 &pcfg_pull_none>, /* rx_err */
> -						<3 RK_PC7 2 &pcfg_pull_none>; /* crs_dvalid */
> -			};
> -
> -			emac_mdio: emac-mdio {
> -				rockchip,pins = <3 RK_PD0 2 &pcfg_pull_none>,
> -						<3 RK_PD1 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c0 {
> -			i2c0_xfer: i2c0-xfer {
> -				rockchip,pins = <1 RK_PD0 1 &pcfg_pull_none>,
> -						<1 RK_PD1 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c1 {
> -			i2c1_xfer: i2c1-xfer {
> -				rockchip,pins = <1 RK_PD2 1 &pcfg_pull_none>,
> -						<1 RK_PD3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c2 {
> -			i2c2_xfer: i2c2-xfer {
> -				rockchip,pins = <1 RK_PD4 1 &pcfg_pull_none>,
> -						<1 RK_PD5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c3 {
> -			i2c3_xfer: i2c3-xfer {
> -				rockchip,pins = <3 RK_PB6 2 &pcfg_pull_none>,
> -						<3 RK_PB7 2 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2c4 {
> -			i2c4_xfer: i2c4-xfer {
> -				rockchip,pins = <1 RK_PD6 1 &pcfg_pull_none>,
> -						<1 RK_PD7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		lcdc1 {
> -			lcdc1_dclk: lcdc1-dclk {
> -				rockchip,pins = <2 RK_PD0 1 &pcfg_pull_none>;
> -			};
> -
> -			lcdc1_den: lcdc1-den {
> -				rockchip,pins = <2 RK_PD1 1 &pcfg_pull_none>;
> -			};
> -
> -			lcdc1_hsync: lcdc1-hsync {
> -				rockchip,pins = <2 RK_PD2 1 &pcfg_pull_none>;
> -			};
> -
> -			lcdc1_vsync: lcdc1-vsync {
> -				rockchip,pins = <2 RK_PD3 1 &pcfg_pull_none>;
> -			};
> -
> -			lcdc1_rgb24: lcdc1-rgb24 {
> -				rockchip,pins = <2 RK_PA0 1 &pcfg_pull_none>,
> -						<2 RK_PA1 1 &pcfg_pull_none>,
> -						<2 RK_PA2 1 &pcfg_pull_none>,
> -						<2 RK_PA3 1 &pcfg_pull_none>,
> -						<2 RK_PA4 1 &pcfg_pull_none>,
> -						<2 RK_PA5 1 &pcfg_pull_none>,
> -						<2 RK_PA6 1 &pcfg_pull_none>,
> -						<2 RK_PA7 1 &pcfg_pull_none>,
> -						<2 RK_PB0 1 &pcfg_pull_none>,
> -						<2 RK_PB1 1 &pcfg_pull_none>,
> -						<2 RK_PB2 1 &pcfg_pull_none>,
> -						<2 RK_PB3 1 &pcfg_pull_none>,
> -						<2 RK_PB4 1 &pcfg_pull_none>,
> -						<2 RK_PB5 1 &pcfg_pull_none>,
> -						<2 RK_PB6 1 &pcfg_pull_none>,
> -						<2 RK_PB7 1 &pcfg_pull_none>,
> -						<2 RK_PC0 1 &pcfg_pull_none>,
> -						<2 RK_PC1 1 &pcfg_pull_none>,
> -						<2 RK_PC2 1 &pcfg_pull_none>,
> -						<2 RK_PC3 1 &pcfg_pull_none>,
> -						<2 RK_PC4 1 &pcfg_pull_none>,
> -						<2 RK_PC5 1 &pcfg_pull_none>,
> -						<2 RK_PC6 1 &pcfg_pull_none>,
> -						<2 RK_PC7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm0 {
> -			pwm0_out: pwm0-out {
> -				rockchip,pins = <3 RK_PD3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm1 {
> -			pwm1_out: pwm1-out {
> -				rockchip,pins = <3 RK_PD4 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm2 {
> -			pwm2_out: pwm2-out {
> -				rockchip,pins = <3 RK_PD5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		pwm3 {
> -			pwm3_out: pwm3-out {
> -				rockchip,pins = <3 RK_PD6 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		spi0 {
> -			spi0_clk: spi0-clk {
> -				rockchip,pins = <1 RK_PA6 2 &pcfg_pull_up>;
> -			};
> -			spi0_cs0: spi0-cs0 {
> -				rockchip,pins = <1 RK_PA7 2 &pcfg_pull_up>;
> -			};
> -			spi0_tx: spi0-tx {
> -				rockchip,pins = <1 RK_PA5 2 &pcfg_pull_up>;
> -			};
> -			spi0_rx: spi0-rx {
> -				rockchip,pins = <1 RK_PA4 2 &pcfg_pull_up>;
> -			};
> -			spi0_cs1: spi0-cs1 {
> -				rockchip,pins = <1 RK_PB7 1 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		spi1 {
> -			spi1_clk: spi1-clk {
> -				rockchip,pins = <0 RK_PD6 1 &pcfg_pull_up>;
> -			};
> -			spi1_cs0: spi1-cs0 {
> -				rockchip,pins = <0 RK_PD7 1 &pcfg_pull_up>;
> -			};
> -			spi1_rx: spi1-rx {
> -				rockchip,pins = <0 RK_PD4 1 &pcfg_pull_up>;
> -			};
> -			spi1_tx: spi1-tx {
> -				rockchip,pins = <0 RK_PD5 1 &pcfg_pull_up>;
> -			};
> -			spi1_cs1: spi1-cs1 {
> -				rockchip,pins = <1 RK_PB6 2 &pcfg_pull_up>;
> -			};
> -		};
> -
> -		uart0 {
> -			uart0_xfer: uart0-xfer {
> -				rockchip,pins = <1 RK_PA0 1 &pcfg_pull_up>,
> -						<1 RK_PA1 1 &pcfg_pull_none>;
> -			};
> -
> -			uart0_cts: uart0-cts {
> -				rockchip,pins = <1 RK_PA2 1 &pcfg_pull_none>;
> -			};
> -
> -			uart0_rts: uart0-rts {
> -				rockchip,pins = <1 RK_PA3 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart1 {
> -			uart1_xfer: uart1-xfer {
> -				rockchip,pins = <1 RK_PA4 1 &pcfg_pull_up>,
> -						<1 RK_PA5 1 &pcfg_pull_none>;
> -			};
> -
> -			uart1_cts: uart1-cts {
> -				rockchip,pins = <1 RK_PA6 1 &pcfg_pull_none>;
> -			};
> -
> -			uart1_rts: uart1-rts {
> -				rockchip,pins = <1 RK_PA7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		uart2 {
> -			uart2_xfer: uart2-xfer {
> -				rockchip,pins = <1 RK_PB0 1 &pcfg_pull_up>,
> -						<1 RK_PB1 1 &pcfg_pull_none>;
> -			};
> -			/* no rts / cts for uart2 */
> -		};
> -
> -		uart3 {
> -			uart3_xfer: uart3-xfer {
> -				rockchip,pins = <1 RK_PB2 1 &pcfg_pull_up>,
> -						<1 RK_PB3 1 &pcfg_pull_none>;
> -			};
> -
> -			uart3_cts: uart3-cts {
> -				rockchip,pins = <1 RK_PB4 1 &pcfg_pull_none>;
> -			};
> -
> -			uart3_rts: uart3-rts {
> -				rockchip,pins = <1 RK_PB5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		sd0 {
> -			sd0_clk: sd0-clk {
> -				rockchip,pins = <3 RK_PA2 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_cmd: sd0-cmd {
> -				rockchip,pins = <3 RK_PA3 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_cd: sd0-cd {
> -				rockchip,pins = <3 RK_PB0 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_wp: sd0-wp {
> -				rockchip,pins = <3 RK_PB1 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_pwr: sd0-pwr {
> -				rockchip,pins = <3 RK_PA1 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_bus1: sd0-bus-width1 {
> -				rockchip,pins = <3 RK_PA4 1 &pcfg_pull_none>;
> -			};
> -
> -			sd0_bus4: sd0-bus-width4 {
> -				rockchip,pins = <3 RK_PA4 1 &pcfg_pull_none>,
> -						<3 RK_PA5 1 &pcfg_pull_none>,
> -						<3 RK_PA6 1 &pcfg_pull_none>,
> -						<3 RK_PA7 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		sd1 {
> -			sd1_clk: sd1-clk {
> -				rockchip,pins = <3 RK_PC5 1 &pcfg_pull_none>;
> -			};
> -
> -			sd1_cmd: sd1-cmd {
> -				rockchip,pins = <3 RK_PC0 1 &pcfg_pull_none>;
> -			};
> -
> -			sd1_cd: sd1-cd {
> -				rockchip,pins = <3 RK_PC6 1 &pcfg_pull_none>;
> -			};
> -
> -			sd1_wp: sd1-wp {
> -				rockchip,pins = <3 RK_PC7 1 &pcfg_pull_none>;
> -			};
> -
> -			sd1_bus1: sd1-bus-width1 {
> -				rockchip,pins = <3 RK_PC1 1 &pcfg_pull_none>;
> -			};
> -
> -			sd1_bus4: sd1-bus-width4 {
> -				rockchip,pins = <3 RK_PC1 1 &pcfg_pull_none>,
> -						<3 RK_PC2 1 &pcfg_pull_none>,
> -						<3 RK_PC3 1 &pcfg_pull_none>,
> -						<3 RK_PC4 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		i2s0 {
> -			i2s0_bus: i2s0-bus {
> -				rockchip,pins = <1 RK_PC0 1 &pcfg_pull_none>,
> -						<1 RK_PC1 1 &pcfg_pull_none>,
> -						<1 RK_PC2 1 &pcfg_pull_none>,
> -						<1 RK_PC3 1 &pcfg_pull_none>,
> -						<1 RK_PC4 1 &pcfg_pull_none>,
> -						<1 RK_PC5 1 &pcfg_pull_none>;
> -			};
> -		};
> -
> -		spdif {
> -			spdif_tx: spdif-tx {
> -				rockchip,pins = <1 RK_PB6 1 &pcfg_pull_none>;
> -			};
> -		};
> -	};
> -};
> -
> -&emac {
> -	compatible = "rockchip,rk3188-emac";
> -};
> -
> -&global_timer {
> -	interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> -};
> -
> -&local_timer {
> -	interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> -};
> -
> -&gpu {
> -	compatible = "rockchip,rk3188-mali", "arm,mali-400";
> -	interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-names = "gp",
> -			  "gpmmu",
> -			  "pp0",
> -			  "ppmmu0",
> -			  "pp1",
> -			  "ppmmu1",
> -			  "pp2",
> -			  "ppmmu2",
> -			  "pp3",
> -			  "ppmmu3";
> -	power-domains = <&power RK3188_PD_GPU>;
> -};
> -
> -&grf {
> -	compatible = "rockchip,rk3188-grf", "syscon", "simple-mfd";
> -
> -	io_domains: io-domains {
> -		compatible = "rockchip,rk3188-io-voltage-domain";
> -		status = "disabled";
> -	};
> -
> -	usbphy: usbphy {
> -		compatible = "rockchip,rk3188-usb-phy";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		status = "disabled";
> -
> -		usbphy0: usb-phy@10c {
> -			reg = <0x10c>;
> -			clocks = <&cru SCLK_OTGPHY0>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -		};
> -
> -		usbphy1: usb-phy@11c {
> -			reg = <0x11c>;
> -			clocks = <&cru SCLK_OTGPHY1>;
> -			clock-names = "phyclk";
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -};
> -
> -&i2c0 {
> -	compatible = "rockchip,rk3188-i2c";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0_xfer>;
> -};
> -
> -&i2c1 {
> -	compatible = "rockchip,rk3188-i2c";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c1_xfer>;
> -};
> -
> -&i2c2 {
> -	compatible = "rockchip,rk3188-i2c";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c2_xfer>;
> -};
> -
> -&i2c3 {
> -	compatible = "rockchip,rk3188-i2c";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c3_xfer>;
> -};
> -
> -&i2c4 {
> -	compatible = "rockchip,rk3188-i2c";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c4_xfer>;
> -};
> -
> -&pmu {
> -	power: power-controller {
> -		compatible = "rockchip,rk3188-power-controller";
> -		#power-domain-cells = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		power-domain@RK3188_PD_VIO {
> -			reg = <RK3188_PD_VIO>;
> -			clocks = <&cru ACLK_LCDC0>,
> -				 <&cru ACLK_LCDC1>,
> -				 <&cru DCLK_LCDC0>,
> -				 <&cru DCLK_LCDC1>,
> -				 <&cru HCLK_LCDC0>,
> -				 <&cru HCLK_LCDC1>,
> -				 <&cru SCLK_CIF0>,
> -				 <&cru ACLK_CIF0>,
> -				 <&cru HCLK_CIF0>,
> -				 <&cru ACLK_IPP>,
> -				 <&cru HCLK_IPP>,
> -				 <&cru ACLK_RGA>,
> -				 <&cru HCLK_RGA>;
> -			pm_qos = <&qos_lcdc0>,
> -				 <&qos_lcdc1>,
> -				 <&qos_cif0>,
> -				 <&qos_ipp>,
> -				 <&qos_rga>;
> -			#power-domain-cells = <0>;
> -		};
> -
> -		power-domain@RK3188_PD_VIDEO {
> -			reg = <RK3188_PD_VIDEO>;
> -			clocks = <&cru ACLK_VDPU>,
> -				 <&cru ACLK_VEPU>,
> -				 <&cru HCLK_VDPU>,
> -				 <&cru HCLK_VEPU>;
> -			pm_qos = <&qos_vpu>;
> -			#power-domain-cells = <0>;
> -		};
> -
> -		power-domain@RK3188_PD_GPU {
> -			reg = <RK3188_PD_GPU>;
> -			clocks = <&cru ACLK_GPU>;
> -			pm_qos = <&qos_gpu>;
> -			#power-domain-cells = <0>;
> -		};
> -	};
> -};
> -
> -&pwm0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm0_out>;
> -};
> -
> -&pwm1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm1_out>;
> -};
> -
> -&pwm2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm2_out>;
> -};
> -
> -&pwm3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pwm3_out>;
> -};
> -
> -&spi0 {
> -	compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
> -};
> -
> -&spi1 {
> -	compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
> -};
> -
> -&uart0 {
> -	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_xfer>;
> -};
> -
> -&uart1 {
> -	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1_xfer>;
> -};
> -
> -&uart2 {
> -	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart2_xfer>;
> -};
> -
> -&uart3 {
> -	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart3_xfer>;
> -};
> -
> -&vpu {
> -	compatible = "rockchip,rk3188-vpu", "rockchip,rk3066-vpu";
> -	power-domains = <&power RK3188_PD_VIDEO>;
> -};
> -
> -&wdt {
> -	compatible = "rockchip,rk3188-wdt", "snps,dw-wdt";
> -};
> diff --git a/arch/arm/dts/rk3xxx.dtsi b/arch/arm/dts/rk3xxx.dtsi
> deleted file mode 100644
> index cb4e42ede56a..000000000000
> --- a/arch/arm/dts/rk3xxx.dtsi
> +++ /dev/null
> @@ -1,488 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#include <dt-bindings/interrupt-controller/irq.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/soc/rockchip,boot-mode.h>
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	interrupt-parent = <&gic>;
> -
> -	aliases {
> -		ethernet0 = &emac;
> -		i2c0 = &i2c0;
> -		i2c1 = &i2c1;
> -		i2c2 = &i2c2;
> -		i2c3 = &i2c3;
> -		i2c4 = &i2c4;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -		serial3 = &uart3;
> -		spi0 = &spi0;
> -		spi1 = &spi1;
> -	};
> -
> -	xin24m: oscillator {
> -		compatible = "fixed-clock";
> -		clock-frequency = <24000000>;
> -		#clock-cells = <0>;
> -		clock-output-names = "xin24m";
> -	};
> -
> -	gpu: gpu@10090000 {
> -		compatible = "arm,mali-400";
> -		reg = <0x10090000 0x10000>;
> -		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
> -		clock-names = "bus", "core";
> -		assigned-clocks = <&cru ACLK_GPU>;
> -		assigned-clock-rates = <100000000>;
> -		resets = <&cru SRST_GPU>;
> -		status = "disabled";
> -	};
> -
> -	vpu: video-codec@10104000 {
> -		compatible = "rockchip,rk3066-vpu";
> -		reg = <0x10104000 0x800>;
> -		interrupts = <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "vepu", "vdpu";
> -		clocks = <&cru ACLK_VDPU>, <&cru HCLK_VDPU>,
> -			 <&cru ACLK_VEPU>, <&cru HCLK_VEPU>;
> -		clock-names = "aclk_vdpu", "hclk_vdpu",
> -			      "aclk_vepu", "hclk_vepu";
> -	};
> -
> -	L2: cache-controller@10138000 {
> -		compatible = "arm,pl310-cache";
> -		reg = <0x10138000 0x1000>;
> -		cache-unified;
> -		cache-level = <2>;
> -	};
> -
> -	scu@1013c000 {
> -		compatible = "arm,cortex-a9-scu";
> -		reg = <0x1013c000 0x100>;
> -	};
> -
> -	global_timer: global-timer@1013c200 {
> -		compatible = "arm,cortex-a9-global-timer";
> -		reg = <0x1013c200 0x20>;
> -		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
> -		clocks = <&cru CORE_PERI>;
> -		status = "disabled";
> -		/* The clock source and the sched_clock provided by the arm_global_timer
> -		 * on Rockchip rk3066a/rk3188 are quite unstable because their rates
> -		 * depend on the CPU frequency.
> -		 * Keep the arm_global_timer disabled in order to have the
> -		 * DW_APB_TIMER (rk3066a) or ROCKCHIP_TIMER (rk3188) selected by default.
> -		 */
> -	};
> -
> -	local_timer: local-timer@1013c600 {
> -		compatible = "arm,cortex-a9-twd-timer";
> -		reg = <0x1013c600 0x20>;
> -		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
> -		clocks = <&cru CORE_PERI>;
> -	};
> -
> -	gic: interrupt-controller@1013d000 {
> -		compatible = "arm,cortex-a9-gic";
> -		interrupt-controller;
> -		#interrupt-cells = <3>;
> -		reg = <0x1013d000 0x1000>,
> -		      <0x1013c100 0x0100>;
> -	};
> -
> -	uart0: serial@10124000 {
> -		compatible = "snps,dw-apb-uart";
> -		reg = <0x10124000 0x400>;
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift = <2>;
> -		reg-io-width = <1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
> -		status = "disabled";
> -	};
> -
> -	uart1: serial@10126000 {
> -		compatible = "snps,dw-apb-uart";
> -		reg = <0x10126000 0x400>;
> -		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift = <2>;
> -		reg-io-width = <1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
> -		status = "disabled";
> -	};
> -
> -	qos_gpu: qos@1012d000 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012d000 0x20>;
> -	};
> -
> -	qos_vpu: qos@1012e000 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012e000 0x20>;
> -	};
> -
> -	qos_lcdc0: qos@1012f000 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f000 0x20>;
> -	};
> -
> -	qos_cif0: qos@1012f080 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f080 0x20>;
> -	};
> -
> -	qos_ipp: qos@1012f100 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f100 0x20>;
> -	};
> -
> -	qos_lcdc1: qos@1012f180 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f180 0x20>;
> -	};
> -
> -	qos_cif1: qos@1012f200 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f200 0x20>;
> -	};
> -
> -	qos_rga: qos@1012f280 {
> -		compatible = "rockchip,rk3066-qos", "syscon";
> -		reg = <0x1012f280 0x20>;
> -	};
> -
> -	usb_otg: usb@10180000 {
> -		compatible = "rockchip,rk3066-usb", "snps,dwc2";
> -		reg = <0x10180000 0x40000>;
> -		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_OTG0>;
> -		clock-names = "otg";
> -		dr_mode = "otg";
> -		g-np-tx-fifo-size = <16>;
> -		g-rx-fifo-size = <275>;
> -		g-tx-fifo-size = <256 128 128 64 64 32>;
> -		phys = <&usbphy0>;
> -		phy-names = "usb2-phy";
> -		status = "disabled";
> -	};
> -
> -	usb_host: usb@101c0000 {
> -		compatible = "snps,dwc2";
> -		reg = <0x101c0000 0x40000>;
> -		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_OTG1>;
> -		clock-names = "otg";
> -		dr_mode = "host";
> -		phys = <&usbphy1>;
> -		phy-names = "usb2-phy";
> -		status = "disabled";
> -	};
> -
> -	emac: ethernet@10204000 {
> -		compatible = "snps,arc-emac";
> -		reg = <0x10204000 0x3c>;
> -		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clocks = <&cru HCLK_EMAC>, <&cru SCLK_MAC>;
> -		clock-names = "hclk", "macref";
> -		max-speed = <100>;
> -		phy-mode = "rmii";
> -
> -		status = "disabled";
> -	};
> -
> -	mmc0: mmc@10214000 {
> -		compatible = "rockchip,rk2928-dw-mshc";
> -		reg = <0x10214000 0x1000>;
> -		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
> -		clock-names = "biu", "ciu";
> -		dmas = <&dmac2 1>;
> -		dma-names = "rx-tx";
> -		fifo-depth = <256>;
> -		resets = <&cru SRST_SDMMC>;
> -		reset-names = "reset";
> -		status = "disabled";
> -	};
> -
> -	mmc1: mmc@10218000 {
> -		compatible = "rockchip,rk2928-dw-mshc";
> -		reg = <0x10218000 0x1000>;
> -		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
> -		clock-names = "biu", "ciu";
> -		dmas = <&dmac2 3>;
> -		dma-names = "rx-tx";
> -		fifo-depth = <256>;
> -		resets = <&cru SRST_SDIO>;
> -		reset-names = "reset";
> -		status = "disabled";
> -	};
> -
> -	emmc: mmc@1021c000 {
> -		compatible = "rockchip,rk2928-dw-mshc";
> -		reg = <0x1021c000 0x1000>;
> -		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
> -		clock-names = "biu", "ciu";
> -		dmas = <&dmac2 4>;
> -		dma-names = "rx-tx";
> -		fifo-depth = <256>;
> -		resets = <&cru SRST_EMMC>;
> -		reset-names = "reset";
> -		status = "disabled";
> -	};
> -
> -	nfc: nand-controller@10500000 {
> -		compatible = "rockchip,rk2928-nfc";
> -		reg = <0x10500000 0x4000>;
> -		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru HCLK_NANDC0>;
> -		clock-names = "ahb";
> -		status = "disabled";
> -	};
> -
> -	pmu: pmu@20004000 {
> -		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
> -		reg = <0x20004000 0x100>;
> -
> -		reboot-mode {
> -			compatible = "syscon-reboot-mode";
> -			offset = <0x40>;
> -			mode-normal = <BOOT_NORMAL>;
> -			mode-recovery = <BOOT_RECOVERY>;
> -			mode-bootloader = <BOOT_FASTBOOT>;
> -			mode-loader = <BOOT_BL_DOWNLOAD>;
> -		};
> -	};
> -
> -	grf: grf@20008000 {
> -		compatible = "syscon", "simple-mfd";
> -		reg = <0x20008000 0x200>;
> -	};
> -
> -	dmac1_s: dma-controller@20018000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x20018000 0x4000>;
> -		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells = <1>;
> -		arm,pl330-broken-no-flushp;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMA1>;
> -		clock-names = "apb_pclk";
> -	};
> -
> -	dmac1_ns: dma-controller@2001c000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x2001c000 0x4000>;
> -		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells = <1>;
> -		arm,pl330-broken-no-flushp;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMA1>;
> -		clock-names = "apb_pclk";
> -		status = "disabled";
> -	};
> -
> -	i2c0: i2c@2002d000 {
> -		compatible = "rockchip,rk3066-i2c";
> -		reg = <0x2002d000 0x1000>;
> -		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clock-names = "i2c";
> -		clocks = <&cru PCLK_I2C0>;
> -
> -		status = "disabled";
> -	};
> -
> -	i2c1: i2c@2002f000 {
> -		compatible = "rockchip,rk3066-i2c";
> -		reg = <0x2002f000 0x1000>;
> -		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clocks = <&cru PCLK_I2C1>;
> -		clock-names = "i2c";
> -
> -		status = "disabled";
> -	};
> -
> -	pwm0: pwm@20030000 {
> -		compatible = "rockchip,rk2928-pwm";
> -		reg = <0x20030000 0x10>;
> -		#pwm-cells = <2>;
> -		clocks = <&cru PCLK_PWM01>;
> -		status = "disabled";
> -	};
> -
> -	pwm1: pwm@20030010 {
> -		compatible = "rockchip,rk2928-pwm";
> -		reg = <0x20030010 0x10>;
> -		#pwm-cells = <2>;
> -		clocks = <&cru PCLK_PWM01>;
> -		status = "disabled";
> -	};
> -
> -	wdt: watchdog@2004c000 {
> -		compatible = "snps,dw-wdt";
> -		reg = <0x2004c000 0x100>;
> -		clocks = <&cru PCLK_WDT>;
> -		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> -		status = "disabled";
> -	};
> -
> -	pwm2: pwm@20050020 {
> -		compatible = "rockchip,rk2928-pwm";
> -		reg = <0x20050020 0x10>;
> -		#pwm-cells = <2>;
> -		clocks = <&cru PCLK_PWM23>;
> -		status = "disabled";
> -	};
> -
> -	pwm3: pwm@20050030 {
> -		compatible = "rockchip,rk2928-pwm";
> -		reg = <0x20050030 0x10>;
> -		#pwm-cells = <2>;
> -		clocks = <&cru PCLK_PWM23>;
> -		status = "disabled";
> -	};
> -
> -	i2c2: i2c@20056000 {
> -		compatible = "rockchip,rk3066-i2c";
> -		reg = <0x20056000 0x1000>;
> -		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clocks = <&cru PCLK_I2C2>;
> -		clock-names = "i2c";
> -
> -		status = "disabled";
> -	};
> -
> -	i2c3: i2c@2005a000 {
> -		compatible = "rockchip,rk3066-i2c";
> -		reg = <0x2005a000 0x1000>;
> -		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clocks = <&cru PCLK_I2C3>;
> -		clock-names = "i2c";
> -
> -		status = "disabled";
> -	};
> -
> -	i2c4: i2c@2005e000 {
> -		compatible = "rockchip,rk3066-i2c";
> -		reg = <0x2005e000 0x1000>;
> -		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rockchip,grf = <&grf>;
> -
> -		clocks = <&cru PCLK_I2C4>;
> -		clock-names = "i2c";
> -
> -		status = "disabled";
> -	};
> -
> -	uart2: serial@20064000 {
> -		compatible = "snps,dw-apb-uart";
> -		reg = <0x20064000 0x400>;
> -		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift = <2>;
> -		reg-io-width = <1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
> -		status = "disabled";
> -	};
> -
> -	uart3: serial@20068000 {
> -		compatible = "snps,dw-apb-uart";
> -		reg = <0x20068000 0x400>;
> -		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift = <2>;
> -		reg-io-width = <1>;
> -		clock-names = "baudclk", "apb_pclk";
> -		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
> -		status = "disabled";
> -	};
> -
> -	saradc: saradc@2006c000 {
> -		compatible = "rockchip,saradc";
> -		reg = <0x2006c000 0x100>;
> -		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -		#io-channel-cells = <1>;
> -		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> -		clock-names = "saradc", "apb_pclk";
> -		resets = <&cru SRST_SARADC>;
> -		reset-names = "saradc-apb";
> -		status = "disabled";
> -	};
> -
> -	spi0: spi@20070000 {
> -		compatible = "rockchip,rk3066-spi";
> -		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> -		reg = <0x20070000 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		dmas = <&dmac2 10>, <&dmac2 11>;
> -		dma-names = "tx", "rx";
> -		status = "disabled";
> -	};
> -
> -	spi1: spi@20074000 {
> -		compatible = "rockchip,rk3066-spi";
> -		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
> -		clock-names = "spiclk", "apb_pclk";
> -		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> -		reg = <0x20074000 0x1000>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		dmas = <&dmac2 12>, <&dmac2 13>;
> -		dma-names = "tx", "rx";
> -		status = "disabled";
> -	};
> -
> -	dmac2: dma-controller@20078000 {
> -		compatible = "arm,pl330", "arm,primecell";
> -		reg = <0x20078000 0x4000>;
> -		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> -		#dma-cells = <1>;
> -		arm,pl330-broken-no-flushp;
> -		arm,pl330-periph-burst;
> -		clocks = <&cru ACLK_DMA2>;
> -		clock-names = "apb_pclk";
> -	};
> -};
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 92dca5e57600..a9420406649c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -48,6 +48,7 @@ config ROCKCHIP_RK3066
>   	select TPL
>   	select TPL_ROCKCHIP_BACK_TO_BROM
>   	select TPL_ROCKCHIP_EARLYRETURN_TO_BROM
> +	imply OF_UPSTREAM
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	imply SPL_SERIAL
> @@ -84,6 +85,7 @@ config ROCKCHIP_RK3188
>   	select SPL_ROCKCHIP_EARLYRETURN_TO_BROM
>   	select SPL_ROCKCHIP_BACK_TO_BROM
>   	select BOARD_LATE_INIT
> +	imply OF_UPSTREAM
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
>   	help
> diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
> index 12a37054b4da..e47d0b594f35 100644
> --- a/configs/mk808_defconfig
> +++ b/configs/mk808_defconfig
> @@ -14,7 +14,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x78000000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_SIZE=0x8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3066a-mk808"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3066a-mk808"
>   CONFIG_DM_RESET=y
>   CONFIG_ROCKCHIP_RK3066=y
>   # CONFIG_ROCKCHIP_STIMER is not set
> @@ -35,7 +35,7 @@ CONFIG_SPL_PAYLOAD="u-boot.bin"
>   CONFIG_DEBUG_UART=y
>   CONFIG_SD_BOOT=y
>   CONFIG_USE_PREBOOT=y
> -CONFIG_DEFAULT_FDT_FILE="rk3066a-mk808.dtb"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3066a-mk808.dtb"
>   CONFIG_SYS_CBSIZE=256
>   CONFIG_SYS_PBSIZE=276
>   # CONFIG_DISPLAY_CPUINFO is not set
> diff --git a/configs/rock_defconfig b/configs/rock_defconfig
> index d7f11310cba1..9c05bf451465 100644
> --- a/configs/rock_defconfig
> +++ b/configs/rock_defconfig
> @@ -11,7 +11,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
> -CONFIG_DEFAULT_DEVICE_TREE="rk3188-radxarock"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3188-radxarock"
>   CONFIG_ROCKCHIP_RK3188=y
>   # CONFIG_ROCKCHIP_STIMER is not set
>   CONFIG_TARGET_ROCK=y
> @@ -25,7 +25,7 @@ CONFIG_DEBUG_UART_BASE=0x20064000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_DEBUG_UART=y
>   CONFIG_USE_PREBOOT=y
> -CONFIG_DEFAULT_FDT_FILE="rk3188-radxarock.dtb"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3188-radxarock.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x7800
> --
> 2.39.5
>
>
