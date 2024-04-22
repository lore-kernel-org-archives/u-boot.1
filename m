Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425F788336;
	Mon, 22 Apr 2024 10:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gLUmFTN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778A788381; Mon, 22 Apr 2024 10:02:11 +0200 (CEST)
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com
 [115.236.118.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479028831B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gLUmFTN6B+lUPwm86Zcbra7UzmuDGieqaHsVmyY96BKYAzT3MXYAi55aOkCA2LF0c9z2GRiwTxAiU7cHEa+vnoA3zRlSq+MR6Y9LRwd+9TqdvLAf8NQwETPGwBB2jw7AkXisWP+OFb7Arxg7ZiZ73i4yudQTnj+EcblZWcXNHCg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=0LJA6iIN0/ljxz9/xshKYexy6JKvcm9aLoYjQ4qDwRw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 1C2AB9002C1;
 Mon, 22 Apr 2024 16:01:58 +0800 (CST)
Message-ID: <2da8c05d-7673-49f0-a673-0f6fe1de2d8b@rock-chips.com>
Date: Mon, 22 Apr 2024 16:01:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/28] rockchip: rk35xx: Sort soc u-boot.dtsi
 alphabetically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMaSVZCTUpPQ05CS04dH0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d3774a03a9kunm1c2ab9002c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6ORw5NjNJPjpDTgETISI1
 PCsKCh5VSlVKTEpITExJQkpCTEpCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTE1NNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> Sort nodes and props in RK356x/RK3588 u-boot.dtsi alphabetically, nodes
> is sorted by reg addr then by alphabetical order.
>
> This has no intended change beside sorting existing nodes and removing
> a duplicated usbdpphy0_grf node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Include binman node in sort (Quentin)
> v3: Collect r-b tag
> v2: Follow kernel sort order (Quentin)
>
> [1] https://www.kernel.org/doc/html/latest/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi  | 112 +++++++++++++++----------------
>   arch/arm/dts/rk3588s-u-boot.dtsi |  91 ++++++++++++-------------
>   2 files changed, 99 insertions(+), 104 deletions(-)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 05367216e118..8ac10f1698f6 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -38,46 +38,21 @@
>   	};
>   };
>   
> -&xin24m {
> -	bootph-all;
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
>   };
> +#endif
>   
>   &cru {
>   	bootph-all;
>   };
>   
> -&pmucru {
> -	bootph-all;
> -};
> -
> -&grf {
> -	bootph-all;
> -};
> -
> -&pmugrf {
> -	bootph-all;
> -};
> -
> -&pinctrl {
> -	bootph-all;
> -};
> -
> -&pcfg_pull_none_smt {
> -	bootph-all;
> -};
> -
> -&pcfg_pull_none {
> -	bootph-all;
> -};
> -
> -&pcfg_pull_up_drv_level_2 {
> -	bootph-all;
> -};
> -
> -&pcfg_pull_up {
> -	bootph-all;
> -};
> -
>   &emmc_bus8 {
>   	bootph-all;
>   };
> @@ -102,10 +77,51 @@
>   	bootph-all;
>   };
>   
> +&grf {
> +	bootph-all;
> +};
> +
>   &i2c0_xfer {
>   	bootph-all;
>   };
>   
> +&pcfg_pull_none {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_none_smt {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up {
> +	bootph-all;
> +};
> +
> +&pcfg_pull_up_drv_level_2 {
> +	bootph-all;
> +};
> +
> +&pinctrl {
> +	bootph-all;
> +};
> +
> +&pmucru {
> +	bootph-all;
> +};
> +
> +&pmugrf {
> +	bootph-all;
> +};
> +
> +&sdhci {
> +	bootph-pre-ram;
> +	max-frequency = <200000000>;
> +};
> +
> +&sdmmc0 {
> +	bootph-pre-ram;
> +};
> +
>   &sdmmc0_bus4 {
>   	bootph-all;
>   };
> @@ -126,31 +142,15 @@
>   	bootph-all;
>   };
>   
> -&uart2m0_xfer {
> -	bootph-all;
> -};
> -
> -&sdhci {
> -	bootph-pre-ram;
> -	max-frequency = <200000000>;
> -};
> -
> -&sdmmc0 {
> -	bootph-pre-ram;
> -};
> -
>   &uart2 {
>   	bootph-pre-ram;
>   	clock-frequency = <24000000>;
>   };
>   
> -#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> -&binman {
> -	simple-bin-spi {
> -		mkimage {
> -			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> -			offset = <0x8000>;
> -		};
> -	};
> +&uart2m0_xfer {
> +	bootph-all;
> +};
> +
> +&xin24m {
> +	bootph-all;
>   };
> -#endif
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 233eb79d9ba2..7fcbdb969240 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -41,6 +41,17 @@
>   		status = "disabled";
>   	};
>   
> +	vo0_grf: syscon@fd5a6000 {
> +		compatible = "rockchip,rk3588-vo-grf", "syscon";
> +		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> +		clocks = <&cru PCLK_VO0GRF>;
> +	};
> +
> +	usb_grf: syscon@fd5ac000 {
> +		compatible = "rockchip,rk3588-usb-grf", "syscon";
> +		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> +	};
> +
>   	usbdpphy0_grf: syscon@fd5c8000 {
>   		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
>   		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> @@ -72,22 +83,6 @@
>   		};
>   	};
>   
> -	vo0_grf: syscon@fd5a6000 {
> -		compatible = "rockchip,rk3588-vo-grf", "syscon";
> -		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> -		clocks = <&cru PCLK_VO0GRF>;
> -	};
> -
> -	usb_grf: syscon@fd5ac000 {
> -		compatible = "rockchip,rk3588-usb-grf", "syscon";
> -		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> -	};
> -
> -	usbdpphy0_grf: syscon@fd5c8000 {
> -		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> -		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> -	};
> -
>   	rng: rng@fe378000 {
>   		compatible = "rockchip,trngv1";
>   		reg = <0x0 0xfe378000 0x0 0x200>;
> @@ -125,6 +120,21 @@
>   	};
>   };
>   
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif
> +
> +&cru {
> +	bootph-pre-ram;
> +};
> +
>   &emmc_bus8 {
>   	bootph-all;
>   };
> @@ -145,32 +155,24 @@
>   	bootph-all;
>   };
>   
> -&pinctrl {
> -	bootph-all;
> +&ioc {
> +	bootph-pre-ram;
>   };
>   
>   &pcfg_pull_none {
>   	bootph-all;
>   };
>   
> -&pcfg_pull_up_drv_level_2 {
> -	bootph-all;
> -};
> -
>   &pcfg_pull_up {
>   	bootph-all;
>   };
>   
> -&xin24m {
> +&pcfg_pull_up_drv_level_2 {
>   	bootph-all;
>   };
>   
> -&cru {
> -	bootph-pre-ram;
> -};
> -
> -&sys_grf {
> -	bootph-pre-ram;
> +&pinctrl {
> +	bootph-all;
>   };
>   
>   &pmu1grf {
> @@ -185,18 +187,18 @@
>   	bootph-pre-ram;
>   };
>   
> -&sdmmc {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> -	u-boot,spl-fifo-mode;
> -};
> -
>   &sdhci {
>   	bootph-pre-ram;
>   	bootph-some-ram;
>   	u-boot,spl-fifo-mode;
>   };
>   
> +&sdmmc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +	u-boot,spl-fifo-mode;
> +};
> +
>   &sdmmc_bus4 {
>   	bootph-all;
>   };
> @@ -213,6 +215,10 @@
>   	bootph-all;
>   };
>   
> +&sys_grf {
> +	bootph-pre-ram;
> +};
> +
>   &uart2 {
>   	bootph-pre-ram;
>   	clock-frequency = <24000000>;
> @@ -222,17 +228,6 @@
>   	bootph-all;
>   };
>   
> -&ioc {
> -	bootph-pre-ram;
> +&xin24m {
> +	bootph-all;
>   };
> -
> -#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> -&binman {
> -	simple-bin-spi {
> -		mkimage {
> -			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> -			offset = <0x8000>;
> -		};
> -	};
> -};
> -#endif
