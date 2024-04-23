Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DF1C16B13
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC30088A9B;
	Tue, 23 Apr 2024 13:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WHAsbxJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4DE88A9C; Tue, 23 Apr 2024 13:15:36 +0200 (CEST)
Received: from mail-m127170.xmail.ntesmail.com
 (mail-m127170.xmail.ntesmail.com [115.236.127.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBB5885AA
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WHAsbxJMXRHsQw7yhnSe/bF64y4jfiCD5De/Os1FPdcHUT4gEotMSCbaMW/uEQlcNK5K0qRJ9db8/cCXbfjjzRo0NptHufZDR8d6HHl7OTo/JOifsJo+shSoqX5e/RSKpo1x7ZpbXbwf6tOxpoYJT/VsMjQKBhDNne7gLHaT2HQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=yYoAtXnUJSFilRkRo13OxHE49j0ifcRm0GYglWYHk+k=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7EDD0900339;
 Tue, 23 Apr 2024 19:15:17 +0800 (CST)
Message-ID: <6be88bd7-f61c-4279-a016-ba6e0e134b8a@rock-chips.com>
Date: Tue, 23 Apr 2024 19:15:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/31] rockchip: rk3399-pinephone-pro: Sync device tree
 from linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-32-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-32-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgdTlZOH0xLGU4eHUNKSkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f0aaad25803a9kunm7edd0900339
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6Cgw4QzNNMj1IOC81FwNI
 FzkKFDxVSlVKTEpIQ0xLQkpDTEhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSU5CNwY+
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
> Sync rk3399-pinephone-pro device tree from linux v6.8.
>
> Add SPI flash related node and options to support booting from SPI flash.
>
> Remove REGULATOR_PWM=y, board does not use pwm-regulator compatible.
>
> Add SYS_NS16550_MEM32=y to use readl/writel for serial console.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |  12 ++
>   arch/arm/dts/rk3399-pinephone-pro.dts         | 147 ++++++++++++++++++
>   configs/pinephone-pro-rk3399_defconfig        |   8 +-
>   3 files changed, 163 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index dcfcec4f3072..6a248691e29d 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -13,3 +13,15 @@
>   &sdmmc {
>   	max-frequency = <20000000>;
>   };
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-pinephone-pro.dts b/arch/arm/dts/rk3399-pinephone-pro.dts
> index 04403a76238b..61f3fec5a8b1 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro.dts
> +++ b/arch/arm/dts/rk3399-pinephone-pro.dts
> @@ -10,6 +10,7 @@
>    */
>   
>   /dts-v1/;
> +#include <dt-bindings/input/gpio-keys.h>
>   #include <dt-bindings/input/linux-event-codes.h>
>   #include "rk3399.dtsi"
>   #include "rk3399-opp.dtsi"
> @@ -29,6 +30,31 @@
>   		stdout-path = "serial2:115200n8";
>   	};
>   
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1600000>;
> +		poll-interval = <100>;
> +
> +		button-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <100000>;
> +		};
> +
> +		button-down {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <600000>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 50000 0>;
> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		pinctrl-names = "default";
> @@ -102,6 +128,37 @@
>   		/* WL_REG_ON on module */
>   		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>   	};
> +
> +	/* MIPI DSI panel 1.8v supply */
> +	vcc1v8_lcd: vcc1v8-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		regulator-name = "vcc1v8_lcd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		gpio = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +	};
> +
> +	/* MIPI DSI panel 2.8v supply */
> +	vcc2v8_lcd: vcc2v8-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		regulator-name = "vcc2v8_lcd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&cpu_alert0 {
> +	temperature = <65000>;
> +};
> +&cpu_alert1 {
> +	temperature = <68000>;
>   };
>   
>   &cpu_l0 {
> @@ -132,6 +189,11 @@
>   	status = "okay";
>   };
>   
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	clock-frequency = <400000>;
>   	i2c-scl-rising-time-ns = <168>;
> @@ -326,6 +388,25 @@
>   	};
>   };
>   
> +&i2c3 {
> +	i2c-scl-rising-time-ns = <450>;
> +	i2c-scl-falling-time-ns = <15>;
> +	status = "okay";
> +
> +	touchscreen@14 {
> +		compatible = "goodix,gt1158";
> +		reg = <0x14>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PB5 IRQ_TYPE_EDGE_RISING>;
> +		irq-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		AVDD28-supply = <&vcc3v0_touch>;
> +		VDDIO-supply = <&vcc3v0_touch>;
> +		touchscreen-size-x = <720>;
> +		touchscreen-size-y = <1440>;
> +	};
> +};
> +
>   &cluster0_opp {
>   	opp04 {
>   		status = "disabled";
> @@ -355,6 +436,39 @@
>   	status = "okay";
>   };
>   
> +&mipi_dsi {
> +	status = "okay";
> +	clock-master;
> +
> +	ports {
> +		mipi_out: port@1 {
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			mipi_out_panel: endpoint {
> +				remote-endpoint = <&mipi_in_panel>;
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "hannstar,hsd060bhw4";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		reset-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;
> +		vcc-supply = <&vcc2v8_lcd>;
> +		iovcc-supply = <&vcc1v8_lcd>;
> +		pinctrl-names = "default";
> +
> +		port {
> +			mipi_in_panel: endpoint {
> +				remote-endpoint = <&mipi_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
>   &pmu_io_domains {
>   	pmu1830-supply = <&vcc_1v8>;
>   	status = "okay";
> @@ -422,6 +536,15 @@
>   	status = "okay";
>   };
>   
> +&pwm0 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca1v8_s3>;
> +	status = "okay";
> +};
> +
>   &sdmmc {
>   	bus-width = <4>;
>   	cap-sd-highspeed;
> @@ -472,3 +595,27 @@
>   &uart2 {
>   	status = "okay";
>   };
> +
> +&vopb {
> +	status = "okay";
> +	assigned-clocks = <&cru DCLK_VOP0_DIV>, <&cru DCLK_VOP0>,
> +			  <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
> +	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> +	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP0_DIV>;
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +	assigned-clocks = <&cru DCLK_VOP1_DIV>, <&cru DCLK_VOP1>,
> +			  <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +	assigned-clock-rates = <0>, <0>, <400000000>, <100000000>;
> +	assigned-clock-parents = <&cru PLL_GPLL>, <&cru DCLK_VOP1_DIV>;
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index c36898364b5d..1bb7b35a255c 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_SF_DEFAULT_SPEED=20000000
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinephone-pro"
> @@ -33,7 +33,6 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> -CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TIME=y
> @@ -54,18 +53,20 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_TYPEC=y
>   CONFIG_DM_PMIC_FAN53555=y
>   CONFIG_PMIC_RK8XX=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_REGULATOR_RK8XX=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_RAM_ROCKCHIP_LPDDR4=y
>   CONFIG_BAUDRATE=1500000
>   CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
>   CONFIG_ROCKCHIP_SPI=y
>   CONFIG_SYSRESET=y
>   CONFIG_USB=y
> @@ -85,5 +86,4 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_EDP=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
