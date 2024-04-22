Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1BFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A429D8831B;
	Mon, 22 Apr 2024 10:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="F7QDOA3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111E188124; Mon, 22 Apr 2024 10:02:34 +0200 (CEST)
Received: from mail-m12778.qiye.163.com (mail-m12778.qiye.163.com
 [115.236.127.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AD78831B
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=F7QDOA3agxnwD0sMnqWJ+st1+j6DI5qNlL5GKr/INT6xOuWwaBsAHHhHvprzyOa031/mLqCUgFXmXF+dLF6HnvjDv6Xq5T/zisePNtGZmcNlwqhubcNZzUASJiQ1P01qsICA4Uwe2kDGzmGsa/UJ2oZCDHckJqml726RB5AhWUg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=/604L+XCTgyUiV0vMktqbTwyARV7TXgLN5X9P3cSREc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 920C69002CE;
 Mon, 22 Apr 2024 16:02:17 +0800 (CST)
Message-ID: <cc6a6e09-6f97-4000-a897-fff9e616f2cf@rock-chips.com>
Date: Mon, 22 Apr 2024 16:02:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/28] rockchip: rk356x: Update bootph props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-13-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeQ1ZDGk1IQ0hNH0xNGEpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d3c36803a9kunm920c69002ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Cyo4ATMDOjoMNwMRIQhN
 N0MwFAtVSlVKTEpITExJQkhDQ0JPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTUxJNwY+
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
> After the commit aca95282c1b7 ("Makefile: Use the fdtgrep -u flag")
> bootph props is propagating to parent nodes.
>
> Update bootph props to ensure eMMC, SD-card and SPI flash is available
> in SPL and U-Boot proper pre-reloc phase also remove unneeded bootph
> props that automatically is propagated to parent nodes.
>
> Also adjust pinctrl nodes to only be included in boot phases where they
> are needed and add any missing pinctrl node needed in SPL.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Split evb-rk3568_defconfig change into a separate patch
> v2: Add bootph-some-ram props and follow kernel sort order
>
> Following bootph props have been applied:
>
> CRU, GRF and UART nodes:
> - bootph-all - needed at all or most stages
>
> SD-card regulator related nodes:
> - bootph-pre-ram (SPL) - regulator pinctrl may be needed to read FIT
>    from SD-card on some boards
>
> eMMC/SD-card/SPI flash related nodes:
> - bootph-pre-ram (SPL)
> - bootph-some-ram (U-Boot proper pre-reloc)
> ---
>   arch/arm/dts/rk3566-pinetab2-u-boot.dtsi   | 25 +++++++----
>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi |  8 ++--
>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi |  4 +-
>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi  |  7 ++-
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi    |  5 +--
>   arch/arm/dts/rk356x-u-boot.dtsi            | 51 ++++++++++++++--------
>   6 files changed, 59 insertions(+), 41 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> index 4aa6ab1c848c..eb18008f2fe3 100644
> --- a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> @@ -3,20 +3,31 @@
>   #include "rk356x-u-boot.dtsi"
>   
>   &fspi_dual_io_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &gpio0 {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &i2c0 {
>   	bootph-pre-ram;
>   };
>   
> +&i2c0_xfer {
> +	bootph-pre-ram;
> +};
> +
> +&i2s1m0_mclk {
> +	bootph-pre-ram;
> +};
> +
> +&pmic_int_l {
> +	bootph-pre-ram;
> +};
> +
>   &rk817 {
> -	bootph-pre-ram;
> -
>   	regulators {
>   		bootph-pre-ram;
>   	};
> @@ -27,15 +38,13 @@
>   };
>   
>   &sdmmc_pwren_l {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> -
>   	flash@0 {
>   		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> index 930d660868bb..0e25b7e108fc 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -3,7 +3,7 @@
>   #include "rk356x-u-boot.dtsi"
>   
>   &gpio0 {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &sdhci {
> @@ -13,11 +13,9 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> -
>   	flash@0 {
>   		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
>   
> @@ -34,5 +32,5 @@
>   };
>   
>   &vcc_sd_h {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> index c235b4357f7d..f2c9d8e167d5 100644
> --- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> @@ -9,11 +9,9 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> -
>   	flash@0 {
>   		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> index 1fc71faa9e07..d8a6dd87510f 100644
> --- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> @@ -3,7 +3,8 @@
>   #include "rk356x-u-boot.dtsi"
>   
>   &fspi_dual_io_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -15,10 +16,8 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> -
>   	flash@0 {
>   		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 5b823fcca5fb..9d18f5d0b364 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -26,16 +26,15 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
>   	#address-cells = <1>;
>   	#size-cells = <0>;
>   	status = "okay";
>   
>   	flash@0 {
> -		bootph-pre-ram;
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
> +		bootph-pre-ram;
> +		bootph-some-ram;
>   		spi-max-frequency = <24000000>;
>   		spi-rx-bus-width = <4>;
>   		spi-tx-bus-width = <1>;
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 8ac10f1698f6..0a0943b462a9 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -54,43 +54,46 @@
>   };
>   
>   &emmc_bus8 {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_clk {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_cmd {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_datastrobe {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_rstnout {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &fspi_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &grf {
>   	bootph-all;
>   };
>   
> -&i2c0_xfer {
> -	bootph-all;
> -};
> -
>   &pcfg_pull_none {
>   	bootph-all;
>   };
>   
>   &pcfg_pull_none_smt {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_up {
> @@ -98,7 +101,8 @@
>   };
>   
>   &pcfg_pull_up_drv_level_2 {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pinctrl {
> @@ -115,35 +119,46 @@
>   
>   &sdhci {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   	max-frequency = <200000000>;
>   };
>   
>   &sdmmc0 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_bus4 {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_clk {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_cmd {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_det {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_pwren {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sfc {
> +	u-boot,spl-sfc-no-dma;
>   };
>   
>   &uart2 {
> -	bootph-pre-ram;
> +	bootph-all;
>   	clock-frequency = <24000000>;
>   };
>   
