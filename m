Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F4C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A3E877B2;
	Mon, 23 Oct 2023 12:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YrwWtsc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679A587897; Mon, 23 Oct 2023 12:21:56 +0200 (CEST)
Received: from mail-m127154.qiye.163.com (mail-m127154.qiye.163.com
 [115.236.127.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6188775C
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YrwWtsc4D9zxlpd9S9ma7yFE9gBfzcEqOvDj7xDor5JgjXwpC9Z0Vw3q9OxFwlJ4oX3eNIbARnQqB71MRXXyYTKSmvLDLIo2N2UxgCttQDtL0NV9zdqZzR7+z8s+GQkO9647eVJyznShu99EYa8bX8x6+3MdT8eXOQArl7DaJoY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jHlBY2qZ4LTQ7NlpsR5Svdi7EpYQCV6Xbfoosu3x/FE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 6234640040B;
 Mon, 23 Oct 2023 18:21:13 +0800 (CST)
Message-ID: <7eb8ef51-903d-4143-bd14-74745a276d9b@rock-chips.com>
Date: Mon, 23 Oct 2023 18:21:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] board: rockchip: add Pine64 QuartzPro64 RK3588
 board
Content-Language: en-US
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 u-boot@lists.denx.de
References: <20231017155943.127659-1-tom@tom-fitzhenry.me.uk>
 <20231017155943.127659-3-tom@tom-fitzhenry.me.uk>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017155943.127659-3-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhPSVYYSUxOSUlMGkMaSE1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1DTExPVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8b5c0d8bd82eb3kusn6234640040b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRg6Ijo6MTw#LTgjSC0wD01I
 ShYaFAhVSlVKTUJDS05NT0xPT0hMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkxKQzcG
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


On 2023/10/17 23:59, Tom Fitzhenry wrote:
> QuartzPro64 is a Rockchip RK3588 based SBC by Pine64.
>
> UART and boot over SD/eMMC/RJ45 are tested to work.
>
> Linux commits from next-20231013:
> 8152d3d070a9 ("arm64: dts: rockchip: Add QuartzPro64 SBC device tree")
>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Ondrej Jirman <megi@xff.cz>
> ---
>
> This patch depends on "rockchip: rk3588: Sync device tree from linux
> maintainer tree"[0], since the QuartzPro64 upstream DT depends on upstream
> dtsi changes.

This patch has been update to V2, and your patch are not able to apply 
any more.

Please help to rebase it.


Thanks,

- Kever

>
> 0. https://lore.kernel.org/all/20231010222344.3436526-2-jonas@kwiboo.se
> ---
>   arch/arm/dts/Makefile                         |    1 +
>   arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi   |   12 +
>   arch/arm/dts/rk3588-quartzpro64.dts           | 1137 +++++++++++++++++
>   arch/arm/mach-rockchip/rk3588/Kconfig         |    8 +
>   board/pine64/quartzpro64-rk3588/Kconfig       |   15 +
>   board/pine64/quartzpro64-rk3588/MAINTAINERS   |    8 +
>   board/pine64/quartzpro64-rk3588/Makefile      |    3 +
>   .../quartzpro64-rk3588/quartzpro64-rk3588.c   |   39 +
>   configs/quartzpro64-rk3588_defconfig          |   72 ++
>   doc/board/rockchip/rockchip.rst               |    1 +
>   include/configs/quartzpro64-rk3588.h          |   14 +
>   11 files changed, 1310 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
>   create mode 100644 board/pine64/quartzpro64-rk3588/Kconfig
>   create mode 100644 board/pine64/quartzpro64-rk3588/MAINTAINERS
>   create mode 100644 board/pine64/quartzpro64-rk3588/Makefile
>   create mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
>   create mode 100644 configs/quartzpro64-rk3588_defconfig
>   create mode 100644 include/configs/quartzpro64-rk3588.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 4569483d5fd..6d1e33d9e2e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -191,6 +191,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>   	rk3588-edgeble-neu6a-io.dtb \
>   	rk3588-edgeble-neu6b-io.dtb \
>   	rk3588-evb1-v10.dtb \
> +	rk3588-quartzpro64.dtb \
>   	rk3588s-rock-5a.dtb \
>   	rk3588-rock-5b.dtb
>   
> diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> new file mode 100644
> index 00000000000..191ec988c45
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 Google, Inc
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3588-quartzpro64.dts b/arch/arm/dts/rk3588-quartzpro64.dts
> new file mode 100644
> index 00000000000..5c59f9571dc
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-quartzpro64.dts
> @@ -0,0 +1,1137 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Ondřej Jirman <megi@xff.cz>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "PINE64 QuartzPro64";
> +	compatible = "pine64,quartzpro64", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys-0 {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-maskrom {
> +			label = "Mask Rom";
> +			linux,code = <KEY_SETUP>;
> +			press-threshold-microvolt = <393>;
> +		};
> +	};
> +
> +	adc-keys-1 {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-volume-up {
> +			label = "V+/REC";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <17821>;
> +		};
> +
> +		button-volume-down {
> +			label = "V-";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <415384>;
> +		};
> +
> +		button-menu {
> +			label = "MENU";
> +			linux,code = <KEY_MENU>;
> +			press-threshold-microvolt = <890909>;
> +		};
> +
> +		button-esc {
> +			label = "ESC";
> +			linux,code = <KEY_ESC>;
> +			press-threshold-microvolt = <1233962>;
> +		};
> +	};
> +
> +	headphone_amp: audio-amplifier-headphone {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		sound-name-prefix = "Headphones Amp";
> +	};
> +
> +	speaker_amp: audio-amplifier-speaker {
> +		compatible = "simple-audio-amplifier";
> +		enable-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins>;
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_ORANGE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_detect>;
> +		simple-audio-card,name = "Analog";
> +		simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
> +		simple-audio-card,bitclock-master = <&daicpu>;
> +		simple-audio-card,frame-master = <&daicpu>;
> +		/* SARADC_IN3 is used as MIC detection / key input */
> +
> +		simple-audio-card,widgets =
> +			"Microphone", "Onboard Microphone",
> +			"Microphone", "Microphone Jack",
> +			"Speaker", "Speaker",
> +			"Headphone", "Headphones";
> +
> +		simple-audio-card,routing =
> +			"Headphones", "LOUT1",
> +			"Headphones", "ROUT1",
> +			"Speaker", "LOUT2",
> +			"Speaker", "ROUT2",
> +
> +			"Headphones", "Headphones Amp OUTL",
> +			"Headphones", "Headphones Amp OUTR",
> +			"Headphones Amp INL", "LOUT1",
> +			"Headphones Amp INR", "ROUT1",
> +
> +			"Speaker", "Speaker Amp OUTL",
> +			"Speaker", "Speaker Amp OUTR",
> +			"Speaker Amp INL", "LOUT2",
> +			"Speaker Amp INR", "ROUT2",
> +
> +			/* single ended signal to LINPUT1 */
> +			"LINPUT1", "Microphone Jack",
> +			"RINPUT1", "Microphone Jack",
> +			/* differential signal */
> +			"LINPUT2", "Onboard Microphone",
> +			"RINPUT2", "Onboard Microphone";
> +
> +		daicpu: simple-audio-card,cpu {
> +			sound-dai = <&i2s0_8ch>;
> +			system-clock-frequency = <12288000>;
> +		};
> +
> +		daicodec: simple-audio-card,codec {
> +			sound-dai = <&es8388>;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +
> +	vcc12v_dcin: vcc12v-dcin-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc3v3_bt: vcc3v3-bt-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio3 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc3v3_bt";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc_3v3_s0>;
> +	};
> +
> +	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc3v3_pcie30";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc3v3_wf: vcc3v3-wf-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc3v3_wf";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc_3v3_s0>;
> +	};
> +
> +	vcc4v0_sys: vcc4v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc4v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <4000000>;
> +		regulator-max-microvolt = <4000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_host_en>;
> +		regulator-name = "vcc5v0_host";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_usb: vcc5v0-usb-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy1_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gmac0 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	rx_delay = <0x00>;
> +	tx_delay = <0x43>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		wakeup-source;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	es8388: audio-codec@11 {
> +		compatible = "everest,es8388";
> +		reg = <0x11>;
> +		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		assigned-clock-rates = <12288000>;
> +		clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&avcc_1v8_codec_s0>;
> +		DVDD-supply = <&avcc_1v8_codec_s0>;
> +		HPVDD-supply = <&vcc_3v3_s0>;
> +		PVDD-supply = <&vcc_3v3_s0>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&i2s0_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s0_lrck
> +		     &i2s0_mclk
> +		     &i2s0_sclk
> +		     &i2s0_sdi0
> +		     &i2s0_sdo0>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	rgmii_phy: ethernet-phy@1 {
> +		/* RTL8211F */
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0x1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtl8211f_rst>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	leds {
> +		led_pins: led-pins {
> +			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	rtl8111 {
> +		rtl8111_isolate: rtl8111-isolate {
> +			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	rtl8211f {
> +		rtl8211f_rst: rtl8211f-rst {
> +			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +	};
> +
> +	sound {
> +		hp_detect: hp-detect {
> +			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_host_en: vcc5v0-host-en {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +/* WIFI */
> +&pcie2x1l0 {
> +	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_wf>;
> +	status = "okay";
> +};
> +
> +/* GMAC1 */
> +&pcie2x1l1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rtl8111_isolate>;
> +	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x4 {
> +	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie30>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <150000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-sdio;
> +	no-mmc;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_s3>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	num-cs = <2>;
> +	status = "okay";
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x0>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +		pinctrl-names = "default";
> +		spi-max-frequency = <1000000>;
> +
> +		vcc1-supply = <&vcc4v0_sys>;
> +		vcc2-supply = <&vcc4v0_sys>;
> +		vcc3-supply = <&vcc4v0_sys>;
> +		vcc4-supply = <&vcc4v0_sys>;
> +		vcc5-supply = <&vcc4v0_sys>;
> +		vcc6-supply = <&vcc4v0_sys>;
> +		vcc7-supply = <&vcc4v0_sys>;
> +		vcc8-supply = <&vcc4v0_sys>;
> +		vcc9-supply = <&vcc4v0_sys>;
> +		vcc10-supply = <&vcc4v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc4v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc4v0_sys>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: dcdc-reg1 {
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu_s0: dcdc-reg2 {
> +				regulator-name = "vdd_npu_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_log_s0: dcdc-reg3 {
> +				regulator-name = "vdd_log_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_vdenc_s0: dcdc-reg4 {
> +				regulator-name = "vdd_vdenc_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +
> +			};
> +
> +			vdd_gpu_mem_s0: dcdc-reg5 {
> +				regulator-name = "vdd_gpu_mem_s0";
> +				regulator-boot-on;
> +				regulator-enable-ramp-delay = <400>;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +
> +			};
> +
> +			vdd_npu_mem_s0: dcdc-reg6 {
> +				regulator-name = "vdd_npu_mem_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-name = "vdd_2v0_pldo_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vdd_vdenc_mem_s0: dcdc-reg8 {
> +				regulator-name = "vdd_vdenc_mem_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg9 {
> +				regulator-name = "vdd2_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v1_nldo_s3: dcdc-reg10 {
> +				regulator-name = "vcc_1v1_nldo_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1100000>;
> +				};
> +			};
> +
> +			avcc_1v8_s0: pldo-reg1 {
> +				regulator-name = "avcc_1v8_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd1_1v8_ddr_s3: pldo-reg2 {
> +				regulator-name = "vdd1_1v8_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avcc_1v8_codec_s0: pldo-reg3 {
> +				regulator-name = "avcc_1v8_codec_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_s3: pldo-reg4 {
> +				regulator-name = "vcc_3v3_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-name = "vccio_sd_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: pldo-reg6 {
> +				regulator-name = "vcc_1v8_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-name = "vdd_0v75_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			/* reserved for LPDDR5, unused? */
> +			vdd2l_0v9_ddr_s3: nldo-reg2 {
> +				regulator-name = "vdd2l_0v9_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vdd_0v75_hdmi_edp_s0: nldo-reg3 {
> +				regulator-name = "vdd_0v75_hdmi_edp_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			avdd_0v75_s0: nldo-reg4 {
> +				regulator-name = "avdd_0v75_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v85_s0: nldo-reg5 {
> +				regulator-name = "vdd_0v85_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x01>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-0 = <&rk806_slave_dvs1_null>, <&rk806_slave_dvs2_null>,
> +			    <&rk806_slave_dvs3_null>;
> +		pinctrl-names = "default";
> +		spi-max-frequency = <1000000>;
> +
> +		vcc1-supply = <&vcc4v0_sys>;
> +		vcc2-supply = <&vcc4v0_sys>;
> +		vcc3-supply = <&vcc4v0_sys>;
> +		vcc4-supply = <&vcc4v0_sys>;
> +		vcc5-supply = <&vcc4v0_sys>;
> +		vcc6-supply = <&vcc4v0_sys>;
> +		vcc7-supply = <&vcc4v0_sys>;
> +		vcc8-supply = <&vcc4v0_sys>;
> +		vcc9-supply = <&vcc4v0_sys>;
> +		vcc10-supply = <&vcc4v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc4v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_2v0_pldo_s3>;
> +		vcca-supply = <&vcc4v0_sys>;
> +
> +		rk806_slave_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_slave_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_slave_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_cpu_big1_s0: dcdc-reg1 {
> +				regulator-name = "vdd_cpu_big1_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_big0_s0: dcdc-reg2 {
> +				regulator-name = "vdd_cpu_big0_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: dcdc-reg3 {
> +				regulator-name = "vdd_cpu_lit_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_s0: dcdc-reg4 {
> +				regulator-name = "vcc_3v3_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_big1_mem_s0: dcdc-reg5 {
> +				regulator-name = "vdd_cpu_big1_mem_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +
> +			vdd_cpu_big0_mem_s0: dcdc-reg6 {
> +				regulator-name = "vdd_cpu_big0_mem_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s0: dcdc-reg7 {
> +				regulator-name = "vcc_1v8_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_mem_s0: dcdc-reg8 {
> +				regulator-name = "vdd_cpu_lit_mem_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg9 {
> +				regulator-name = "vddq_ddr_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg10 {
> +				regulator-name = "vdd_ddr_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* reserved, unused? */
> +			vcc_1v8_cam_s0: pldo-reg1 {
> +				regulator-name = "vcc_1v8_cam_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			avdd1v8_ddr_pll_s0: pldo-reg2 {
> +				regulator-name = "avdd1v8_ddr_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_1v8_pll_s0: pldo-reg3 {
> +				regulator-name = "vdd_1v8_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* reserved, unused? */
> +			vcc_3v3_sd_s0: pldo-reg4 {
> +				regulator-name = "vcc_3v3_sd_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* reserved, unused? */
> +			vcc_2v8_cam_s0: pldo-reg5 {
> +				regulator-name = "vcc_2v8_cam_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* unused */
> +			pldo6_s3: pldo-reg6 {
> +				regulator-name = "pldo6_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_pll_s0: nldo-reg1 {
> +				regulator-name = "vdd_0v75_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_pll_s0: nldo-reg2 {
> +				regulator-name = "vdd_ddr_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			avdd_0v85_s0: nldo-reg3 {
> +				regulator-name = "avdd_0v85_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* reserved, unused */
> +			avdd_1v2_cam_s0: nldo-reg4 {
> +				regulator-name = "avdd_1v2_cam_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			avdd_1v2_s0: nldo-reg5 {
> +				regulator-name = "avdd_1v2_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	phy-supply = <&vcc5v0_host>;
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	phy-supply = <&vcc5v0_host>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 79fcc99b898..a0ebcdb2e84 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -80,6 +80,13 @@ config TARGET_ROCK5B_RK3588
>   	  USB PD over USB Type-C
>   	  Size: 100mm x 72mm (Pico-ITX form factor)
>   
> +config TARGET_QUARTZPRO64_RK3588
> +	bool "Pine64 QuartzPro64 RK3588 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
> +	  Computer) by Pine64.
> +
>   config ROCKCHIP_BOOT_MODE_REG
>   	default 0xfd588080
>   
> @@ -93,6 +100,7 @@ config SYS_MALLOC_F_LEN
>   	default 0x80000
>   
>   source board/edgeble/neural-compute-module-6/Kconfig
> +source board/pine64/quartzpro64-rk3588/Kconfig
>   source board/rockchip/evb_rk3588/Kconfig
>   source board/radxa/rock5a-rk3588s/Kconfig
>   source board/radxa/rock5b-rk3588/Kconfig
> diff --git a/board/pine64/quartzpro64-rk3588/Kconfig b/board/pine64/quartzpro64-rk3588/Kconfig
> new file mode 100644
> index 00000000000..96aa7921d32
> --- /dev/null
> +++ b/board/pine64/quartzpro64-rk3588/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_QUARTZPRO64_RK3588
> +
> +config SYS_BOARD
> +	default "quartzpro64-rk3588"
> +
> +config SYS_VENDOR
> +	default "pine64"
> +
> +config SYS_CONFIG_NAME
> +	default "quartzpro64-rk3588"
> +
> +config BOARD_SPECIFIC_OPTIONS # dummy
> +	def_bool y
> +
> +endif
> diff --git a/board/pine64/quartzpro64-rk3588/MAINTAINERS b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> new file mode 100644
> index 00000000000..a7e944b7478
> --- /dev/null
> +++ b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> @@ -0,0 +1,8 @@
> +QUARTZPRO64-RK3588
> +M:	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> +S:	Maintained
> +F:	board/pine64/quartzpro64-rk3588
> +F:	include/configs/quartzpro64-rk3588.h
> +F:	configs/quartzpro64-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-quartzpro64.dts
> +F:	arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> diff --git a/board/pine64/quartzpro64-rk3588/Makefile b/board/pine64/quartzpro64-rk3588/Makefile
> new file mode 100644
> index 00000000000..47819d9be93
> --- /dev/null
> +++ b/board/pine64/quartzpro64-rk3588/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +
> +obj-y += quartzpro64-rk3588.o
> diff --git a/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
> new file mode 100644
> index 00000000000..bda804a89e2
> --- /dev/null
> +++ b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 Google, Inc
> + */
> +
> +#include <fdtdec.h>
> +#include <fdt_support.h>
> +
> +#ifdef CONFIG_OF_BOARD_SETUP
> +int quartzpro64_add_reserved_memory_fdt_nodes(void *new_blob)
> +{
> +	struct fdt_memory gap1 = {
> +		.start = 0x3fc000000,
> +		.end = 0x3fc4fffff,
> +	};
> +	struct fdt_memory gap2 = {
> +		.start = 0x3fff00000,
> +		.end = 0x3ffffffff,
> +	};
> +	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
> +	unsigned int ret;
> +
> +	/*
> +	 * Inject the reserved-memory nodes into the DTS
> +	 */
> +	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
> +					 NULL, flags);
> +	if (ret)
> +		return ret;
> +
> +	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
> +					  NULL, flags);
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +	return quartzpro64_add_reserved_memory_fdt_nodes(blob);
> +}
> +#endif
> diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
> new file mode 100644
> index 00000000000..d6b35c72647
> --- /dev/null
> +++ b/configs/quartzpro64-rk3588_defconfig
> @@ -0,0 +1,72 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_QUARTZPRO64_RK3588=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 8262fc0d32c..6fba0ff1e1d 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -115,6 +115,7 @@ List of mainline supported Rockchip boards:
>        - Rockchip EVB (evb-rk3588)
>        - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
>        - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
> +     - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B (rock5b-rk3588)
>   
> diff --git a/include/configs/quartzpro64-rk3588.h b/include/configs/quartzpro64-rk3588.h
> new file mode 100644
> index 00000000000..a1faa2aad85
> --- /dev/null
> +++ b/include/configs/quartzpro64-rk3588.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+
> + * Copyright 2023 Google, Inc
> + */
> +
> +#ifndef __QUARTZPRO64_RK3588_H
> +#define __QUARTZPRO64_RK3588_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#endif /* __QUARTZPRO64_RK3588_H */
