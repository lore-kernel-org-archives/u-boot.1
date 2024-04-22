Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D289AC07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251818839C;
	Mon, 22 Apr 2024 10:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="e1//ENLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48BF8839C; Mon, 22 Apr 2024 10:02:46 +0200 (CEST)
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com
 [117.135.214.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830FC883A9
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=e1//ENLzjH6CvMVAgNob2DDFhaHBS7cid3K3y50etJKNjgHdsRTh+sDdKO22e0JCHdm7u4Hed7n1+gs5edEOjCsRK+rOEqTgRAOUIRIhg/Vzc6+XRnb1lGxspX9EskAxau4qA7Sp6qUeByqMmSjPbPxaFBZNl1o4kGM3aW24Jic=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=mifMEfxDX6csIJGAKmvxdULkvs9LWBWm47fE0AT4qvo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 86E089002E3;
 Mon, 22 Apr 2024 16:02:28 +0800 (CST)
Message-ID: <a82e00a2-c108-402a-8671-1ec865102c6f@rock-chips.com>
Date: Mon, 22 Apr 2024 16:02:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/28] rockchip: rk3588: Update bootph props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>, John Clark <inindev@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-14-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpMSFZLTBpISRhDS08eGRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d3ef2703a9kunm86e089002e3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6OSo*MDNJLjoMNwMfIQgN
 IhhPCTZVSlVKTEpITExJQk9CQ09JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS09PTDcG
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
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Split rk3588-generic.dts and evb-rk3588_defconfig changes into
>      separate patches
> v3: Collect r-b tag
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
>   .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |  8 +--
>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     | 12 ++---
>   .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  7 ++-
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +--
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  6 ++-
>   arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |  8 +--
>   arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  9 ++--
>   arch/arm/dts/rk3588s-u-boot.dtsi              | 50 ++++++++++++++-----
>   8 files changed, 67 insertions(+), 41 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> index ed15b14ea0ee..f0ef0164664e 100644
> --- a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> @@ -3,7 +3,8 @@
>   #include "rk3588-u-boot.dtsi"
>   
>   &fspim2_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -12,16 +13,15 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&fspim2_pins>;
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
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> index 60494bb8485f..968385622fa5 100644
> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> @@ -7,12 +7,11 @@
>   #include "rk3588-u-boot.dtsi"
>   
>   &fspim1_pins {
> -	bootph-all;
> -};
> -
> -&sfc {
>   	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> +	bootph-some-ram;
> +};
> +
> +&sfc {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&fspim1_pins>;
>   	#address-cells = <1>;
> @@ -20,9 +19,10 @@
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
> diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> index 5d5fa6ffb214..1ab31a4ec5ab 100644
> --- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> @@ -3,7 +3,8 @@
>   #include "rk3588-u-boot.dtsi"
>   
>   &fspim1_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -12,10 +13,8 @@
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
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 9ee9dd051e32..d6020ca790f6 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -18,7 +18,8 @@
>   };
>   
>   &fspim2_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pinctrl {
> @@ -35,16 +36,15 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&fspim2_pins>;
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
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index ca2a684f3541..a50bcc45f216 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -12,6 +12,10 @@
>   };
>   
>   &uart9 {
> -	bootph-pre-ram;
> +	bootph-all;
>   	clock-frequency = <24000000>;
>   };
> +
> +&uart9m0_xfer {
> +	bootph-all;
> +};
> diff --git a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
> index 6e4b97028d7c..f51d7f30d787 100644
> --- a/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi
> @@ -3,7 +3,8 @@
>   #include "rk3588s-u-boot.dtsi"
>   
>   &fspim2_pins {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -12,16 +13,15 @@
>   };
>   
>   &sfc {
> -	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&fspim2_pins>;
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
> diff --git a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> index 888d1b9c12d7..12a92c0cba10 100644
> --- a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> @@ -9,14 +9,13 @@
>   };
>   
>   &fspim0_pins {
> -	bootph-all;
> -};
> -
> -&sfc {
>   	bootph-pre-ram;
> -	u-boot,spl-sfc-no-dma;
> +	bootph-some-ram;
> +};
>   
> +&sfc {
>   	flash@0 {
>   		bootph-pre-ram;
> +		bootph-some-ram;
>   	};
>   };
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 7fcbdb969240..d3c257983ecb 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -132,31 +132,40 @@
>   #endif
>   
>   &cru {
> -	bootph-pre-ram;
> +	bootph-all;
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
>   &emmc_data_strobe {
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
>   &ioc {
> -	bootph-pre-ram;
> +	bootph-all;
> +};
> +
> +&pcfg_pull_down {
> +	bootph-all;
>   };
>   
>   &pcfg_pull_none {
> @@ -168,6 +177,11 @@
>   };
>   
>   &pcfg_pull_up_drv_level_2 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&php_grf {
>   	bootph-all;
>   };
>   
> @@ -181,10 +195,12 @@
>   
>   &scmi {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &scmi_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdhci {
> @@ -200,27 +216,35 @@
>   };
>   
>   &sdmmc_bus4 {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_clk {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_cmd {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc_det {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sfc {
> +	u-boot,spl-sfc-no-dma;
>   };
>   
>   &sys_grf {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &uart2 {
> -	bootph-pre-ram;
> +	bootph-all;
>   	clock-frequency = <24000000>;
>   };
>   
