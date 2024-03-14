Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6013AC5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 06:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C240B87F52;
	Thu, 14 Mar 2024 07:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eTHfhwRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83CA287F63; Thu, 14 Mar 2024 07:50:41 +0100 (CET)
Received: from mail-m12776.qiye.163.com (mail-m12776.qiye.163.com
 [115.236.127.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEA185B66
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 07:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eTHfhwRecIL0XRm5wNeCYpBegM7EpuWWciLFKH3bWE32JX1fIbcIQ3i+Sy8ofcwA7fy1U8Id3MaW68cBpzAH1LBkXhNNHtUAXOfqAFAaZF25oF/KR1GvxzA1mwkYUq7ExLR5jRLxXKX61MFzANm/4VEyvS2fi6yNft+ibOWAQ/c=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=C7FbJgERqF7o8aXv5xlWaAhjZUzK578Q8/DemzvLmgE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 58F019002D5;
 Thu, 14 Mar 2024 14:50:24 +0800 (CST)
Message-ID: <833e0e28-4154-4454-b66c-09271c203f22@rock-chips.com>
Date: Thu, 14 Mar 2024 14:50:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Pine64 PineTab2
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240204173040.2293613-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240204173040.2293613-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxCTVZDSh5CT0pNGU9KSE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e3bb9ee2003a9kunm58f019002d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCo6PDo4SzMNPC9MSDAsKA1R
 SSwKCyhVSlVKTEpLSEJCS0lOT05OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUNKTDcG
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


On 2024/2/5 01:30, Jonas Karlman wrote:
> The Pine64 PineTab2 is a tablet computer based on the Rockchip RK3566
> SoC. The table features 4/8 GB LPDDR4 RAM and 64/128 GB eMMC storage.
>
> Features tested on a Pine64 PineTab2 8GB v2.0:
> - SD-card boot
> - eMMC boot
> - SPI Flash boot
> - USB host
>
> Device tree is imported from linux maintainer branch v6.9-armsoc/dts64,
> commit 1b7e19448f8f ("arm64: dts: rockchip: Add devicetree for Pine64
> PineTab2").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This patch depend on the series "rockchip: rk35xx: Sync device tree with
> linux v6.8-rc1" [1].
>
> [1] https://patchwork.ozlabs.org/cover/1891669/
> ---
>   arch/arm/dts/Makefile                         |   2 +
>   arch/arm/dts/rk3566-pinetab2-u-boot.dtsi      |  44 +
>   arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi |   3 +
>   arch/arm/dts/rk3566-pinetab2-v0.1.dts         |  28 +
>   arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi |   3 +
>   arch/arm/dts/rk3566-pinetab2-v2.0.dts         |  48 +
>   arch/arm/dts/rk3566-pinetab2.dtsi             | 943 ++++++++++++++++++
>   board/pine64/quartz64_rk3566/MAINTAINERS      |  11 +
>   configs/pinetab2-rk3566_defconfig             | 119 +++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   10 files changed, 1202 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1.dts
>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0.dts
>   create mode 100644 arch/arm/dts/rk3566-pinetab2.dtsi
>   create mode 100644 configs/pinetab2-rk3566_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 50f35e3db3f0..825fa1cd368a 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -173,6 +173,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
>   
>   dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>   	rk3566-anbernic-rgxx3.dtb \
> +	rk3566-pinetab2-v0.1.dtb \
> +	rk3566-pinetab2-v2.0.dtb \
>   	rk3566-quartz64-a.dtb \
>   	rk3566-quartz64-b.dtb \
>   	rk3566-radxa-cm3-io.dtb \
> diff --git a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> new file mode 100644
> index 000000000000..4aa6ab1c848c
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +&fspi_dual_io_pins {
> +	bootph-all;
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&i2c0 {
> +	bootph-pre-ram;
> +};
> +
> +&rk817 {
> +	bootph-pre-ram;
> +
> +	regulators {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +};
> +
> +&sdmmc_pwren_l {
> +	bootph-all;
> +};
> +
> +&sfc {
> +	bootph-pre-ram;
> +	u-boot,spl-sfc-no-dma;
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&vcc3v3_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> new file mode 100644
> index 000000000000..061dc3c2c375
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3566-pinetab2-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3566-pinetab2-v0.1.dts b/arch/arm/dts/rk3566-pinetab2-v0.1.dts
> new file mode 100644
> index 000000000000..5fe6ca5da9d3
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2-v0.1.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-pinetab2.dtsi"
> +
> +/ {
> +	model = "Pine64 PineTab2 v0.1";
> +	compatible = "pine64,pinetab2-v0.1", "pine64,pinetab2", "rockchip,rk3566";
> +};
> +
> +&lcd {
> +	reset-gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_pwren_h &lcd0_rst_l>;
> +};
> +
> +&pinctrl {
> +	lcd0 {
> +		lcd0_rst_l: lcd0-rst-l {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc1 {
> +	vmmc-supply = <&vcc3v3_sys>;
> +};
> diff --git a/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> new file mode 100644
> index 000000000000..061dc3c2c375
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3566-pinetab2-u-boot.dtsi"
> diff --git a/arch/arm/dts/rk3566-pinetab2-v2.0.dts b/arch/arm/dts/rk3566-pinetab2-v2.0.dts
> new file mode 100644
> index 000000000000..9349541cbbd0
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2-v2.0.dts
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-pinetab2.dtsi"
> +
> +/ {
> +	model = "Pine64 PineTab2 v2.0";
> +	compatible = "pine64,pinetab2-v2.0", "pine64,pinetab2", "rockchip,rk3566";
> +};
> +
> +&gpio_keys {
> +	pinctrl-0 = <&kb_id_det>, <&hall_int_l>;
> +
> +	event-hall-sensor {
> +		debounce-interval = <20>;
> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
> +		label = "Hall Sensor";
> +		linux,code = <SW_LID>;
> +		linux,input-type = <EV_SW>;
> +		wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		wakeup-source;
> +	};
> +};
> +
> +&lcd {
> +	reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_pwren_h &lcd0_rst_l>;
> +};
> +
> +&pinctrl {
> +	lcd0 {
> +		lcd0_rst_l: lcd0-rst-l {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hall {
> +		hall_int_l: hall-int-l {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&sdmmc1 {
> +	vmmc-supply = <&vcc_sys>;
> +};
> diff --git a/arch/arm/dts/rk3566-pinetab2.dtsi b/arch/arm/dts/rk3566-pinetab2.dtsi
> new file mode 100644
> index 000000000000..db40281eafbe
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-pinetab2.dtsi
> @@ -0,0 +1,943 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +	chassis-type = "tablet";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <25>;
> +
> +		button-vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <297500>;
> +		};
> +
> +		button-vol-down {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <1750>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm4 0 25000 0>;
> +		brightness-levels = <20 220>;
> +		num-interpolated-steps = <200>;
> +		default-brightness-level = <100>;
> +		power-supply = <&vcc_sys>;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		charge-full-design-microamp-hours = <6000000>;
> +		charge-term-current-microamp = <300000>;
> +		constant-charge-current-max-microamp = <2000000>;
> +		constant-charge-voltage-max-microvolt = <4300000>;
> +		voltage-max-design-microvolt = <4350000>;
> +		voltage-min-design-microvolt = <3400000>;
> +
> +		ocv-capacity-celsius = <20>;
> +		ocv-capacity-table-0 = <4322000 100>, <4250000 95>, <4192000 90>, <4136000 85>,
> +				       <4080000 80>, <4022000 75>, <3972000 70>, <3928000 65>,
> +				       <3885000 60>, <3833000 55>, <3798000 50>, <3780000 45>,
> +				       <3776000 40>, <3773000 35>, <3755000 30>, <3706000 25>,
> +				       <3640000 20>, <3589000 15>, <3535000 10>, <3492000 5>,
> +				       <3400000 0>;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&kb_id_det>;
> +
> +		tablet-mode-switch {
> +			debounce-interval = <20>;
> +			gpios = <&gpio4 RK_PA4 GPIO_ACTIVE_HIGH>;
> +			label = "Tablet Mode";
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_TABLET_MODE>;
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "d";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	led-0 {
> +		compatible = "regulator-led";
> +		vled-supply = <&vcc5v0_flashled>;
> +		color = <LED_COLOR_ID_WHITE>;
> +		function = LED_FUNCTION_FLASH;
> +	};
> +
> +	rk817-sound {
> +		compatible = "simple-audio-card";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_det_l>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "rk817_ext";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Headphone", "Headphones",
> +			"Speaker", "Internal Speakers";
> +
> +		simple-audio-card,routing =
> +			"MICR", "Mic Jack",
> +			"Headphones", "HPOL",
> +			"Headphones", "HPOR",
> +			"Internal Speakers", "Speaker Amplifier OUTL",
> +			"Internal Speakers", "Speaker Amplifier OUTR",
> +			"Speaker Amplifier INL", "HPOL",
> +			"Speaker Amplifier INR", "HPOR";
> +		simple-audio-card,hp-det-gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
> +		simple-audio-card,aux-devs = <&speaker_amp>;
> +		simple-audio-card,pin-switches = "Internal Speakers";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&rk817>;
> +		};
> +	};
> +
> +	speaker_amp: speaker-amplifier {
> +		compatible = "simple-audio-amplifier";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spk_ctl>;
> +		enable-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		sound-name-prefix = "Speaker Amplifier";
> +		VCC-supply = <&vcc_bat>;
> +	};
> +
> +	vcc_3v3: vcc-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwren_h>;
> +		regulator-name = "vcc3v3_minipcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vcc3v3_sd: vcc3v3-sd-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_pwren_l>;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc5v0_flashled: vcc5v0-flashled-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&flash_led_en_h>;
> +		regulator-name = "vcc5v0_flashled";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v_midu>;
> +	};
> +
> +	vcc5v0_usb_host0: vcc5v0-usb-host0-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren1_h>;
> +		regulator-name = "vcc5v0_usb_host0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v_midu>;
> +	};
> +
> +	vcc5v0_usb_host2: vcc5v0-usb-host2-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren2_h>;
> +		regulator-name = "vcc5v0_usb_host2";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v_midu>;
> +	};
> +
> +	vcc_bat: vcc-bat-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_bat";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc_sys: vcc-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_bat>;
> +	};
> +
> +	vdd1v2_dvp: vdd1v2-dvp-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd1v2_dvp";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cru {
> +	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>,
> +			  <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
> +	assigned-clock-rates = <32768>, <1200000000>, <200000000>, <500000000>;
> +	assigned-clock-parents = <&pmucru CLK_RTC32K_FRAC>;
> +};
> +
> +&csi_dphy {
> +	status = "okay";
> +};
> +
> +&dsi0 {
> +	status = "okay";
> +	clock-master;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	lcd: panel@0 {
> +		compatible = "boe,th101mb31ig002-28a";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		enable-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +		rotation = <90>;
> +		power-supply = <&vcc_3v3>;
> +
> +		port@0 {
> +			panel_in_dsi: endpoint@0 {
> +				remote-endpoint = <&dsi0_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_in {
> +	dsi0_in_vp1: endpoint {
> +		remote-endpoint = <&vp1_out_dsi0>;
> +	};
> +};
> +
> +&dsi0_out {
> +	dsi0_out_con: endpoint {
> +		remote-endpoint = <&panel_in_dsi>;
> +	};
> +};
> +
> +&dsi_dphy0 {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_npu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda_0v9_p>;
> +	avdd-1v8-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk817: pmic@20 {
> +		compatible = "rockchip,rk817";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> +		#clock-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
> +		rockchip,system-power-controller;
> +		#sound-dai-cells = <0>;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc_sys>;
> +		vcc2-supply = <&vcc_sys>;
> +		vcc3-supply = <&vcc_sys>;
> +		vcc4-supply = <&vcc_sys>;
> +		vcc5-supply = <&vcc_sys>;
> +		vcc6-supply = <&vcc_sys>;
> +		vcc7-supply = <&vcc_sys>;
> +		vcc8-supply = <&vcc_sys>;
> +		vcc9-supply = <&vcc5v_midu>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_logic";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu_npu: DCDC_REG2 {
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_gpu_npu";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc_ddr";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sys: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc3v3_sys";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9_p: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda_0v9_p";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_acodec";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc1v8_dvp: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8_dvp";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc2v8_dvp: LDO_REG9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-name = "vcc2v8_dvp";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc5v_midu: BOOST {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-name = "boost";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vbus: OTG_SWITCH {
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-name = "otg_switch";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +
> +		charger {
> +			monitored-battery = <&battery>;
> +			rockchip,resistor-sense-micro-ohms = <10000>;
> +			rockchip,sleep-enter-current-microamp = <300000>;
> +			rockchip,sleep-filter-current-microamp = <100000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt911";
> +		reg = <0x5d>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_int_l_pmuio2>, <&tp_rst_l_pmuio2>;
> +		AVDD28-supply = <&vcc3v3_pmu>;
> +		VDDIO-supply = <&vcca1v8_pmu>;
> +		irq-gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c2m1_xfer>;
> +	status = "okay";
> +
> +	vcm@c {
> +		compatible = "dongwoon,dw9714";
> +		reg = <0x0c>;
> +		vcc-supply = <&vcc1v8_dvp>;
> +	};
> +
> +	camera@36 {
> +		compatible = "ovti,ov5648";
> +		reg = <0x36>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&camerab_pdn_l &camerab_rst_l>;
> +
> +		clocks = <&cru CLK_CIF_OUT>;
> +		assigned-clocks = <&cru CLK_CIF_OUT>;
> +		assigned-clock-rates = <24000000>;
> +
> +		avdd-supply = <&vcc2v8_dvp>;
> +		dvdd-supply = <&vdd1v2_dvp>;
> +		dovdd-supply = <&vcc1v8_dvp>;
> +		powerdown-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			endpoint {
> +				data-lanes = <1 2>;
> +				remote-endpoint = <0>;
> +				link-frequencies = /bits/ 64 <210000000 168000000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	accelerometer@18 {
> +		compatible = "silan,sc7a20";
> +		reg = <0x18>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gsensor_int_l>;
> +		st,drdy-int-pin = <1>;
> +		vdd-supply = <&vcc_1v8>;
> +		vddio-supply = <&vcc_1v8>;
> +		mount-matrix = "1", "0", "0",
> +			       "0", "0", "1",
> +			       "0", "1", "0";
> +	};
> +};
> +
> +&i2s0_8ch {
> +	status = "okay";
> +};
> +
> +&i2s1_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s1m0_sclktx
> +		     &i2s1m0_lrcktx
> +		     &i2s1m0_sdi0
> +		     &i2s1m0_sdo0>;
> +	rockchip,trcm-sync-tx-only;
> +	status = "okay";
> +};
> +
> +&pcie2x1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_reset_h>;
> +	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_minipcie>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	camerab {
> +		camerab_pdn_l: camerab-pdn-l {
> +			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		camerab_rst_l: camerab-rst-l {
> +			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	cameraf {
> +		cameraf_pdn_l: cameraf-pdn-l {
> +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		cameraf_rst_l: cameraf-rst-l {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	flash {
> +		flash_led_en_h: flash-led-en-h {
> +			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	fspi {
> +		fspi_dual_io_pins: fspi-dual-io-pins {
> +			rockchip,pins =
> +				/* fspi_clk */
> +				<1 RK_PD0 1 &pcfg_pull_none>,
> +				/* fspi_cs0n */
> +				<1 RK_PD3 1 &pcfg_pull_none>,
> +				/* fspi_d0 */
> +				<1 RK_PD1 1 &pcfg_pull_none>,
> +				/* fspi_d1 */
> +				<1 RK_PD2 1 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	gsensor {
> +		gsensor_int_l: gsensor-int-l {
> +			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	kb {
> +		kb_id_det: kb-id-det {
> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	lcd {
> +		lcd_pwren_h: lcd-pwren-h {
> +			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie_pwren_h: pcie-pwren-h {
> +			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie_reset_h: pcie-reset-h {
> +			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_pwren_l: sdmmc-pwren-l {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sound {
> +		hp_det_l: hp-det-l {
> +			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		spk_ctl: spk-ctl {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	tp {
> +		tp_int_l_pmuio2: tp-int-l-pmuio2 {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		tp_rst_l_pmuio2: tp-rst-l-pmuio2 {
> +			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usbcc_int_l: usbcc-int-l {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb_host_pwren1_h: usb-host-pwren1-h {
> +			rockchip,pins = <4 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb_host_pwren2_h: usb-host-pwren2-h {
> +			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		host_wake_wl: host-wake-wl {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_wake_host_h: wifi-wake-host-h {
> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcca1v8_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_1v8>;
> +	vccio6-supply = <&vcc1v8_dvp>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm4 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs200-1_8v;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8
> +		     &emmc_clk
> +		     &emmc_cmd
> +		     &emmc_datastrobe
> +		     &emmc_rstnout>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4
> +		     &sdmmc0_clk
> +		     &sdmmc0_cmd
> +		     &sdmmc0_det>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc1_bus4
> +		     &sdmmc1_cmd
> +		     &sdmmc1_clk>;
> +	sd-uhs-sdr104;
> +	vqmmc-supply = <&vcca1v8_pmu>;
> +	status = "okay";
> +};
> +
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspi_dual_io_pins>;
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-rx-bus-width = <2>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart2 {
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
> +&usb_host0_xhci {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_host {
> +	phy-supply = <&vcc5v0_usb_host0>;
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_usb_host2>;
> +	status = "okay";
> +};
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
> +
> +&vp1 {
> +	vp1_out_dsi0: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
> +		reg = <ROCKCHIP_VOP2_EP_MIPI0>;
> +		remote-endpoint = <&dsi0_in_vp1>;
> +	};
> +};
> diff --git a/board/pine64/quartz64_rk3566/MAINTAINERS b/board/pine64/quartz64_rk3566/MAINTAINERS
> index 6b75b35a1243..37b8c1eb78b6 100644
> --- a/board/pine64/quartz64_rk3566/MAINTAINERS
> +++ b/board/pine64/quartz64_rk3566/MAINTAINERS
> @@ -21,3 +21,14 @@ F:	arch/arm/dts/rk3566-soquartz-cm4.dts
>   F:	arch/arm/dts/rk3566-soquartz-cm4-u-boot.dtsi
>   F:	arch/arm/dts/rk3566-soquartz-model-a.dts
>   F:	arch/arm/dts/rk3566-soquartz-model-a-u-boot.dtsi
> +
> +PINETAB2-RK3566
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/pinetab2-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-pinetab2.dtsi
> +F:	arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-pinetab2-v0.1.dts
> +F:	arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-pinetab2-v2.0.dts
> +F:	arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
> new file mode 100644
> index 000000000000..19b396eef975
> --- /dev/null
> +++ b/configs/pinetab2-rk3566_defconfig
> @@ -0,0 +1,119 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x1000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3566-pinetab2-v2.0"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_QUARTZ64_RK3566=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
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
> +CONFIG_SPL_I2C=y
> +CONFIG_SPL_POWER=y
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_LIST="rk3566-pinetab2-v0.1 rk3566-pinetab2-v2.0"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_BUTTON_GPIO=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=4
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9fe69fc9422f..fda2282b2c26 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -93,6 +93,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3566
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> +     - Pine64 PineTab2 (pinetab2-rk3566)
>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)
>        - Pine64 Quartz64-B Board (quartz64-b-rk3566)
>        - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
