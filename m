Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA33C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B9088327;
	Mon,  6 May 2024 12:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="f5a9uer5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59308848B; Mon,  6 May 2024 12:36:40 +0200 (CEST)
Received: from mail-m17248.xmail.ntesmail.com (mail-m17248.xmail.ntesmail.com
 [45.195.17.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65BD88134
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=f5a9uer53L/mXYIRh4VuUFUvUhMblj+gMF2jlkGtHiVeG1Xs+4qSFQHB7cgpZbY6MviIySKPHzTXxTcQqV9RPKHFSEP6r1SQmrl05iNAM6MkHw6nowYWMwRgbvTPdr+FPK0TM7iwcRBA5PjoeufbIclwp55rXa0NN6wgFKn6xcg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=iQYOH3PLVrfnUJGW7bKj9tgLOgBMnHbGA5aSGs8aiw0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B9D57900323;
 Mon,  6 May 2024 18:36:28 +0800 (CST)
Message-ID: <d796c213-1770-442f-a183-a4383197f4e8@rock-chips.com>
Date: Mon, 6 May 2024 18:36:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] rockchip: rk3399: Sort nodes in u-boot.dtsi files
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pNGVYfTBlMSkxDTE8eShhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d79f57a03a9kunmb9d57900323
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6HQw4HjNIHBYOIToDQksa
 CUMKCktVSlVKTEpPQkJKTENCQ09CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNSEhINwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> Sort nodes alphabetically by name, symbol or reg addr in RK3399 related
> u-boot.dtsi files. Also remove one of the duplicated &pmu nodes.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> ---
>   arch/arm/dts/rk3399-evb-u-boot.dtsi    | 24 ++++++++---------
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 12 ++++-----
>   arch/arm/dts/rk3399-u-boot.dtsi        | 37 ++++++++++++--------------
>   3 files changed, 35 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> index 9df4a02c3e74..6dedfeec0722 100644
> --- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> @@ -20,6 +20,18 @@
>   	bootph-all;
>   };
>   
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> +	status = "okay";
> +};
> +
>   &tcphy1 {
>   	status = "okay";
>   };
> @@ -36,15 +48,3 @@
>   &vdd_center {
>   	regulator-init-microvolt = <900000>;
>   };
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> -	disable-wp;
> -	max-frequency = <150000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index e390cf3abab5..58a3c0afcddd 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -38,12 +38,11 @@
>   	};
>   };
>   
> -&vdd_log {
> -	regulator-min-microvolt = <430000>;
> -	regulator-init-microvolt = <950000>;
> +&vcc5v0_host {
> +	regulator-always-on;
>   };
>   
> -&vcc5v0_host {
> +&vcc_sdio {
>   	regulator-always-on;
>   };
>   
> @@ -51,6 +50,7 @@
>   	regulator-always-on;
>   };
>   
> -&vcc_sdio {
> -	regulator-always-on;
> +&vdd_log {
> +	regulator-min-microvolt = <430000>;
> +	regulator-init-microvolt = <950000>;
>   };
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 96523a138ae3..b9b8d3ee1d92 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -18,19 +18,25 @@
>   		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>   	};
>   
> -	cic: syscon@ff620000 {
> +	pmusgrf: syscon@ff330000 {
> +		compatible = "rockchip,rk3399-pmusgrf", "syscon";
> +		reg = <0x0 0xff330000 0x0 0xe3d4>;
>   		bootph-all;
> +	};
> +
> +	cic: syscon@ff620000 {
>   		compatible = "rockchip,rk3399-cic", "syscon";
>   		reg = <0x0 0xff620000 0x0 0x100>;
> +		bootph-all;
>   	};
>   
>   	dfi: dfi@ff630000 {
> -		bootph-all;
>   		reg = <0x00 0xff630000 0x00 0x4000>;
>   		compatible = "rockchip,rk3399-dfi";
>   		rockchip,pmu = <&pmugrf>;
>   		clocks = <&cru PCLK_DDR_MON>;
>   		clock-names = "pclk_ddr_mon";
> +		bootph-all;
>   	};
>   
>   	rng: rng@ff8b8000 {
> @@ -39,12 +45,7 @@
>   	};
>   
>   	dmc: dmc {
> -		bootph-all;
>   		compatible = "rockchip,rk3399-dmc";
> -		devfreq-events = <&dfi>;
> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks = <&cru SCLK_DDRCLK>;
> -		clock-names = "dmc_clk";
>   		reg = <0x0 0xffa80000 0x0 0x0800
>   		       0x0 0xffa80800 0x0 0x1800
>   		       0x0 0xffa82000 0x0 0x2000
> @@ -53,14 +54,12 @@
>   		       0x0 0xffa88800 0x0 0x1800
>   		       0x0 0xffa8a000 0x0 0x2000
>   		       0x0 0xffa8c000 0x0 0x1000>;
> -	};
> -
> -	pmusgrf: syscon@ff330000 {
> +		devfreq-events = <&dfi>;
> +		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_DDRCLK>;
> +		clock-names = "dmc_clk";
>   		bootph-all;
> -		compatible = "rockchip,rk3399-pmusgrf", "syscon";
> -		reg = <0x0 0xff330000 0x0 0xe3d4>;
>   	};
> -
>   };
>   
>   #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> @@ -108,21 +107,19 @@
>   	bootph-all;
>   };
>   
> -&pmugrf {
> -	bootph-all;
> -};
> -
> -&pmu {
> +&pmucru {
>   	bootph-all;
>   };
>   
> -&pmucru {
> +&pmugrf {
>   	bootph-all;
>   };
>   
>   &sdhci {
> -	max-frequency = <200000000>;
>   	bootph-all;
> +	max-frequency = <200000000>;
> +
> +	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
>   	u-boot,spl-fifo-mode;
>   };
>   
