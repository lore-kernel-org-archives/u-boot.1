Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741EEC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0761788500;
	Tue, 23 Apr 2024 13:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="L6buwQuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5B48852B; Tue, 23 Apr 2024 13:09:09 +0200 (CEST)
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com
 [220.197.31.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52E6884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=L6buwQuD1b3+BTBtuf8ce0GJxvXLzx5C+CXroq1ZNAsGJDgpG5E3E0mQN/t1PQBIz6nI3sZ5KfSu19HJMOsQsX1Tu6Mji3fucXpXsEatmvLk0X7OjLrblSuBYXBy7e3mdAJyD72177GbGiaxmw3Ty8v0vxLv2GDizNmlAg8T9QA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=10mW0Oz+R0GDubEuB0WilQJx0eDMyvXTYEyfuD1JEN4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BE19390031F;
 Tue, 23 Apr 2024 19:08:49 +0800 (CST)
Message-ID: <50309530-4f44-4770-ba28-bf411376b4e5@rock-chips.com>
Date: Tue, 23 Apr 2024 19:08:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/31] rockchip: rk3399-puma: Sync DT from linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-18-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-18-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4eGlZDSxpMSE4eSkgfT01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0aa4e6d203a9kunmbe19390031f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Ehw*CDNMLj0IEjdNHw4f
 Q0gKFDpVSlVKTEpIQ0xLTkhLTEhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSk5ONwY+
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


On 2024/4/1 04:28, Jonas Karlman wrote:
> Sync rk3399-puma related device tree from linux v6.8.
>
> SPL_MAX_SIZE is not adjusted to the now common 0x40000 (256 KiB) due to
> TPL+SPL combined (idbloader.img) is limited to max 224 KiB because of:
>
>    SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
>
> Because FIT payload is located at sector 0x200 instead of the more
> Rockchip common 0x4000, TPL+SPL cannot take up more than 224 KiB:
>
>    (0x200 - 64) x 512 = 0x38000 (224 KiB)
>
> Also adjust SPL_PAD_TO to match the 0x200 sector offset.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 20 ++--------
>   arch/arm/dts/rk3399-puma-haikou.dts         | 42 ++++++++++++++++++---
>   arch/arm/dts/rk3399-puma.dtsi               | 17 ++++++++-
>   configs/puma-rk3399_defconfig               |  2 +-
>   4 files changed, 57 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> index f48d395f972a..65340f98d595 100644
> --- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
> @@ -30,18 +30,6 @@
>   	aliases {
>   		spi5 = &spi5;
>   	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 1>;
> -		regulator-name = "vdd_log";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-init-microvolt = <950000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
>   };
>   
>   &binman {
> @@ -87,10 +75,6 @@
>   	bootph-all;
>   };
>   
> -&haikou_pin_hog {
> -	bootph-all;
> -};
> -
>   &norflash {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> @@ -111,3 +95,7 @@
>   &uart0_xfer {
>   	bootph-all;
>   };
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
> diff --git a/arch/arm/dts/rk3399-puma-haikou.dts b/arch/arm/dts/rk3399-puma-haikou.dts
> index 115c14c0a3c6..18a98c4648ea 100644
> --- a/arch/arm/dts/rk3399-puma-haikou.dts
> +++ b/arch/arm/dts/rk3399-puma-haikou.dts
> @@ -5,6 +5,7 @@
>   
>   /dts-v1/;
>   #include "rk3399-puma.dtsi"
> +#include <dt-bindings/input/input.h>
>   
>   / {
>   	model = "Theobroma Systems RK3399-Q7 SoM";
> @@ -18,6 +19,38 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&haikou_keys_pin>;
> +		pinctrl-names = "default";
> +
> +		button-batlow-n {
> +			gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +			label = "BATLOW#";
> +			linux,code = <KEY_BATTERY>;
> +		};
> +
> +		button-slp-btn-n {
> +			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
> +			label = "SLP_BTN#";
> +			linux,code = <KEY_SLEEP>;
> +		};
> +
> +		button-wake-n {
> +			gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
> +			label = "WAKE#";
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +
> +		switch-lid-btn-n {
> +			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +			label = "LID_BTN#";
> +			linux,code = <SW_LID>;
> +			linux,input-type = <EV_SW>;
> +		};
> +	};
> +
>   	leds {
>   		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
>   
> @@ -165,11 +198,8 @@
>   };
>   
>   &pinctrl {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&haikou_pin_hog>;
> -
> -	hog {
> -		haikou_pin_hog: haikou-pin-hog {
> +	buttons {
> +		haikou_keys_pin: haikou-keys-pin {
>   			rockchip,pins =
>   			  /* LID_BTN */
>   			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
> @@ -177,7 +207,7 @@
>   			  <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
>   			  /* SLP_BTN# */
>   			  <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
> -			  /* BIOS_DISABLE# */
> +			  /* WAKE# */
>   			  <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
>   		};
>   	};
> diff --git a/arch/arm/dts/rk3399-puma.dtsi b/arch/arm/dts/rk3399-puma.dtsi
> index aa3e21bd6c8f..c08e69391c01 100644
> --- a/arch/arm/dts/rk3399-puma.dtsi
> +++ b/arch/arm/dts/rk3399-puma.dtsi
> @@ -9,6 +9,7 @@
>   
>   / {
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdhci;
>   	};
>   
> @@ -27,7 +28,7 @@
>   
>   	extcon_usb3: extcon-usb3 {
>   		compatible = "linux,extcon-usb-gpio";
> -		id-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		id-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&usb3_id>;
>   	};
> @@ -119,6 +120,20 @@
>   	drive-impedance-ohm = <33>;
>   };
>   
> +&gpio0 {
> +	/*
> +	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
> +	 * signal. This usually represents the state of a switch on the baseboard.
> +	 * The pin has a 10k pull-up resistor connected, so no pull-up setting is needed.
> +	 */
> +	bios-disable-hog {
> +		gpios = <RK_PB0 GPIO_ACTIVE_HIGH>;
> +		gpio-hog;
> +		input;
> +		line-name = "bios_disable";
> +	};
> +};
> +
>   &gmac {
>   	assigned-clocks = <&cru SCLK_RMII_SRC>;
>   	assigned-clock-parents = <&clkin_gmac>;
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index cc3d2cf3755d..26d524cabb06 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -27,7 +27,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
> -CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_PAD_TO=0x38000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0xff8e0000
>   CONFIG_SPL_BSS_MAX_SIZE=0x10000
