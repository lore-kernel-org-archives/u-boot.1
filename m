Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A314C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4BB885CE;
	Tue, 23 Apr 2024 13:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VbUp+sjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF7A888A5; Tue, 23 Apr 2024 13:14:58 +0200 (CEST)
Received: from mail-m49243.qiye.163.com (mail-m49243.qiye.163.com
 [45.254.49.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B9B885AA
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VbUp+sjzb6KBkkMIsYmQ0alYDs7aV40KFbwjCubbURP4+0y7LKa6xDTVFTfhr4qO9e3JHAzQopd6+kfnfA1v5d+vm7i3IhdbWzwsbTiJ4fUThRFNkWX3DxYE7n5zUFVYo5LE+iU3/+U66IqjhDeyIeLdQkl/cyav+f8Tot/2tVU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=dBZJ8jLSxvevpHvCOaQA3ZBOo/yiQayH2FCn7ZRG/Fs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 271D0900124;
 Tue, 23 Apr 2024 19:14:33 +0800 (CST)
Message-ID: <89f7d61e-a9fb-43a6-9fb5-e2d1d2ce5039@rock-chips.com>
Date: Tue, 23 Apr 2024 19:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/31] rockchip: rk3399-rockpro64: Sync device tree from
 linux v6.8
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-30-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240331202921.262323-30-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkfHVZDHx9JQ0JDH0IaSB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0aaa24c403a9kunm271d0900124
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Ayo6PTNCED01AikCFwgL
 Ty0aCw1VSlVKTEpIQ0xLQ0xPSUNOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSElPNwY+
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
> Sync rk3399-rockpro64 device tree from linux v6.8.
>
> Add SF_DEFAULT_SPEED=10000000 and SPI_FLASH_SFDP_SUPPORT=y to improve
> support for booting from SPI flash.
>
> Remove USE_PREBOOT=y to speed up booting, standard boot will init USB
> after faster boot media has been evaluated.
>
> Add CMD_POWEROFF=y to support poweroff using cmdline and power on using
> the pwr button on the board.
>
> Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.
>
> Remove SPL_TINY_MEMSET=y to use full memset in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-rockpro64.dtsi | 98 ++++++++++++++++++++++++++++--
>   configs/rockpro64-rk3399_defconfig |  7 ++-
>   2 files changed, 97 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-rockpro64.dtsi b/arch/arm/dts/rk3399-rockpro64.dtsi
> index 6bff8db7d33e..f30b82a10ca3 100644
> --- a/arch/arm/dts/rk3399-rockpro64.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64.dtsi
> @@ -11,6 +11,7 @@
>   
>   / {
>   	aliases {
> +		ethernet0 = &gmac;
>   		mmc0 = &sdio0;
>   		mmc1 = &sdmmc;
>   		mmc2 = &sdhci;
> @@ -20,6 +21,15 @@
>   		stdout-path = "serial2:1500000n8";
>   	};
>   
> +	/* enable for panel backlight support */
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <5>;
> +		pwms = <&pwm0 0 1000000 0>;
> +		status = "disabled";
> +	};
> +
>   	clkin_gmac: external-gmac-clock {
>   		compatible = "fixed-clock";
>   		clock-frequency = <125000000>;
> @@ -33,7 +43,7 @@
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pwrbtn>;
>   
> -		power {
> +		key-power {
>   			debounce-interval = <100>;
>   			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
>   			label = "GPIO Key Power";
> @@ -69,6 +79,7 @@
>   
>   	fan: pwm-fan {
>   		compatible = "pwm-fan";
> +		cooling-levels = <0 100 150 200 255>;
>   		#cooling-cells = <2>;
>   		fan-supply = <&vcc12v_dcin>;
>   		pwms = <&pwm1 0 50000 0>;
> @@ -106,6 +117,14 @@
>   		};
>   	};
>   
> +	avdd: avdd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "avdd";
> +		regulator-min-microvolt = <11000000>;
> +		regulator-max-microvolt = <11000000>;
> +		vin-supply = <&vcc3v3_s0>;
> +	};
> +
>   	vcc12v_dcin: vcc12v-dcin {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc12v_dcin";
> @@ -212,12 +231,12 @@
>   	vdd_log: vdd-log {
>   		compatible = "pwm-regulator";
>   		pwms = <&pwm2 0 25000 1>;
> +		pwm-supply = <&vcc5v0_sys>;
>   		regulator-name = "vdd_log";
>   		regulator-always-on;
>   		regulator-boot-on;
>   		regulator-min-microvolt = <800000>;
>   		regulator-max-microvolt = <1700000>;
> -		vin-supply = <&vcc5v0_sys>;
>   	};
>   };
>   
> @@ -245,6 +264,34 @@
>   	cpu-supply = <&vdd_cpu_b>;
>   };
>   
> +&cpu_thermal {
> +	trips {
> +		cpu_warm: cpu_warm {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		cpu_hot: cpu_hot {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map2 {
> +			trip = <&cpu_warm>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map3 {
> +			trip = <&cpu_hot>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>   &emmc_phy {
>   	status = "okay";
>   };
> @@ -371,8 +418,6 @@
>   
>   			vcc3v0_touch: LDO_REG2 {
>   				regulator-name = "vcc3v0_touch";
> -				regulator-always-on;
> -				regulator-boot-on;
>   				regulator-min-microvolt = <3000000>;
>   				regulator-max-microvolt = <3000000>;
>   				regulator-state-mem {
> @@ -461,8 +506,6 @@
>   
>   			vcc3v3_s0: SWITCH_REG2 {
>   				regulator-name = "vcc3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
>   				regulator-state-mem {
>   					regulator-off-in-suspend;
>   				};
> @@ -536,6 +579,19 @@
>   		vbus-supply = <&vcc5v0_typec>;
>   		status = "okay";
>   	};
> +
> +	/* enable for pine64 touch screen support */
> +	touch: touchscreen@5d {
> +		compatible = "goodix,gt911";
> +		reg = <0x5d>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
> +		AVDD28-supply = <&vcc3v0_touch>;
> +		VDDIO-supply = <&vcc3v0_touch>;
> +		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";
> +	};
>   };
>   
>   &i2s0 {
> @@ -571,6 +627,36 @@
>   	gpio1830-supply = <&vcc_3v0>;
>   };
>   
> +/* enable for pine64 panel display support */
> +&mipi_dsi {
> +	clock-master;
> +	status = "disabled";
> +
> +	ports {
> +		mipi_out: port@1 {
> +			reg = <1>;
> +
> +			mipi_out_panel: endpoint {
> +				remote-endpoint = <&mipi_in_panel>;
> +			};
> +		};
> +	};
> +
> +	mipi_panel: panel@0 {
> +		compatible = "feiyang,fy07024di26a30d";
> +		reg = <0>;
> +		avdd-supply = <&avdd>;
> +		backlight = <&backlight>;
> +		dvdd-supply = <&vcc3v3_s0>;
> +
> +		port {
> +			mipi_in_panel: endpoint {
> +				remote-endpoint = <&mipi_out_panel>;
> +			};
> +		};
> +	};
> +};
> +
>   &pcie0 {
>   	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
>   	num-lanes = <4>;
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 173f8f75020d..4e1af37a1559 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SF_DEFAULT_SPEED=10000000
>   CONFIG_ENV_SIZE=0x8000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
> @@ -20,7 +21,6 @@ CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_BOOTSTAGE=y
>   CONFIG_BOOTSTAGE_REPORT=y
> -CONFIG_USE_PREBOOT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
> @@ -34,6 +34,7 @@ CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
>   CONFIG_CMD_TIME=y
> @@ -57,7 +58,10 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
> @@ -96,5 +100,4 @@ CONFIG_VIDEO=y
>   CONFIG_DISPLAY=y
>   CONFIG_VIDEO_ROCKCHIP=y
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> -CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_ERRNO_STR=y
