Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C26C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 03:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448FA87F5A;
	Thu, 14 Mar 2024 04:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KXScMJ4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B441876E4; Thu, 14 Mar 2024 04:30:54 +0100 (CET)
Received: from mail-m11886.qiye.163.com (mail-m11886.qiye.163.com
 [115.236.118.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B53A387F5A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 04:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KXScMJ4jcFuaFstozagVKb/dVC7Fg/bJ7gRPYM4JW0vK1A3CTP/Mur1Y4VBBmN1M0lV2p6L41wV4pPkHLwgAjI2FBma/Yxs3YwOBEmtnDgD2s113+5Zmv6z453cBocV72XmvirIBI2w9+p8WVuAEOQRuf/NhBQ9Dvwsup/Sc76A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=xdZb65EPIvyR2rWjELDRi3v7obEg+I0s0qgJV4TGTPg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 170E59001B4;
 Thu, 14 Mar 2024 11:30:13 +0800 (CST)
Message-ID: <afbecb0c-6610-4212-b297-9d5eb03555a2@rock-chips.com>
Date: Thu, 14 Mar 2024 11:30:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] rockchip: rk3328: Fix loading FIT from SD-card
 when booting from eMMC
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 David Bauer <mail@david-bauer.net>, Tianling Shen <cnsztl@gmail.com>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-9-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240217002304.2141064-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpMTVZCHx9PS0sYTEofSU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e3b02a8b103a9kunm170e59001b4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Hio6AjMTHigBHTQfE1E2
 CzQwFBdVSlVKTEpLSENMS0pPSU9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS01NQjcG
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


On 2024/2/17 08:22, Jonas Karlman wrote:
> When RK3328 boards run SPL from eMMC and fail to load FIT from eMMC due
> to it being missing or checksum validation fails there is a fallback to
> read FIT from SD-card. However, without proper pinctrl configuration
> reading FIT from SD-card will fail:
>
>    U-Boot SPL 2024.04-rc1 (Feb 05 2024 - 22:18:22 +0000)
>    Trying to boot from MMC1
>    mmc_load_image_raw_sector: mmc block read error
>    Trying to boot from MMC2
>    Card did not respond to voltage select! : -110
>    spl: mmc init failed with error: -95
>    Trying to boot from MMC1
>    mmc_load_image_raw_sector: mmc block read error
>    SPL: failed to boot from all boot devices
>    ### ERROR ### Please RESET the board ###
>
> Fix this by tagging related emmc and sdmmc pinctrl nodes with bootph
> props. Also sort and move common nodes shared by all boards to the SoC
> u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Add missing UART2 pinctrl nodes to soc u-boot.dtsi
> - Mark the pinctrl node to be included in U-Boot proper pre-reloc phase
> - Add SD-card IO-voltage related nodes to nanopi-r2 u-boot.dtsi
> ---
>   arch/arm/dts/rk3328-evb-u-boot.dtsi           |  4 +
>   arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    | 13 +--
>   .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   | 25 ++---
>   .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   | 25 ++---
>   arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        | 17 ----
>   arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     | 17 ----
>   arch/arm/dts/rk3328-rock64-u-boot.dtsi        | 25 ++---
>   arch/arm/dts/rk3328-u-boot.dtsi               | 91 +++++++++++++++++--
>   8 files changed, 107 insertions(+), 110 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-evb-u-boot.dtsi b/arch/arm/dts/rk3328-evb-u-boot.dtsi
> index 12b68df1ac67..38ad3cc16d09 100644
> --- a/arch/arm/dts/rk3328-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-evb-u-boot.dtsi
> @@ -44,3 +44,7 @@
>   	/* Integrated PHY unsupported by U-Boot */
>   	status = "broken";
>   };
> +
> +&vcc_sd {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> index 0a1152e8b52d..cca4f06145cf 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> @@ -7,23 +7,18 @@
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-ddr4-666.dtsi"
>   
> -&gpio0 {
> +&gpio1 {
>   	bootph-pre-ram;
>   };
>   
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> -	bootph-pre-ram;
> +&sdio_vcc_pin {
> +	bootph-all;
>   };
>   
> -&pcfg_pull_up_4ma {
> +&vcc_io_sdio {
>   	bootph-pre-ram;
>   };
>   
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index 8a4189c6f1cc..7cdf6913795d 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -7,29 +7,16 @@
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-lpddr3-666.dtsi"
>   
> -&gpio0 {
> -	bootph-pre-ram;
> -};
> -
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> +&spi0 {
>   	bootph-pre-ram;
> -};
> +	bootph-some-ram;
>   
> -&pcfg_pull_up_4ma {
> -	bootph-pre-ram;
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
>   };
>   
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> -
> -&spi0 {
> -	spi_flash: spiflash@0 {
> -		bootph-all;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 2e3b6a77a268..35baeb2464bc 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -7,29 +7,16 @@
>   #include "rk3328-u-boot.dtsi"
>   #include "rk3328-sdram-ddr4-666.dtsi"
>   
> -&gpio0 {
> -	bootph-pre-ram;
> -};
> -
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> +&spi0 {
>   	bootph-pre-ram;
> -};
> +	bootph-some-ram;
>   
> -&pcfg_pull_up_4ma {
> -	bootph-pre-ram;
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
>   };
>   
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> -
> -&spi0 {
> -	spi_flash: spiflash@0 {
> -		bootph-all;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> index 8bc2f134f8f4..47d74964fd0c 100644
> --- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> @@ -29,23 +29,6 @@
>   	};
>   };
>   
> -&gpio0 {
> -	bootph-pre-ram;
> -};
> -
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> -	bootph-pre-ram;
> -};
> -
> -&pcfg_pull_up_4ma {
> -	bootph-pre-ram;
> -};
> -
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> index 1f220c6dcd0f..9ed0aef1ecc9 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
> @@ -29,23 +29,6 @@
>   	};
>   };
>   
> -&gpio0 {
> -	bootph-pre-ram;
> -};
> -
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> -	bootph-pre-ram;
> -};
> -
> -&pcfg_pull_up_4ma {
> -	bootph-pre-ram;
> -};
> -
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> index bfe506fd2249..9de645d8d7ab 100644
> --- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> @@ -29,29 +29,16 @@
>   	};
>   };
>   
> -&gpio0 {
> -	bootph-pre-ram;
> -};
> -
> -&pinctrl {
> -	bootph-pre-ram;
> -};
> -
> -&sdmmc0m1_pin {
> +&spi0 {
>   	bootph-pre-ram;
> -};
> +	bootph-some-ram;
>   
> -&pcfg_pull_up_4ma {
> -	bootph-pre-ram;
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
>   };
>   
> -/* Need this and all the pinctrl/gpio stuff above to set pinmux */
>   &vcc_sd {
>   	bootph-pre-ram;
>   };
> -
> -&spi0 {
> -	spi_flash: flash@0 {
> -		bootph-all;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index a12be7876db0..687c16da5135 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -38,33 +38,104 @@
>   	bootph-all;
>   };
>   
> +&emmc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +
> +	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
> +	u-boot,spl-fifo-mode;
> +};
> +
> +&emmc_bus8 {
> +	bootph-pre-ram;
> +};
> +
> +&emmc_clk {
> +	bootph-pre-ram;
> +};
> +
> +&emmc_cmd {
> +	bootph-pre-ram;
> +};
> +
> +&gpio0 {
> +	bootph-pre-ram;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
>   
> -&uart2 {
> +&pcfg_pull_none {
>   	bootph-all;
> -	clock-frequency = <24000000>;
>   };
>   
> -&emmc {
> +&pcfg_pull_none_8ma {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_none_12ma {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_up {
>   	bootph-all;
> +};
>   
> -	/* mmc to sram can't do dma, prevent aborts transfering TF-A parts */
> -	u-boot,spl-fifo-mode;
> +&pcfg_pull_up_4ma {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_up_8ma {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_up_12ma {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl {
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc {
> -	bootph-all;
> +	bootph-pre-ram;
> +	bootph-some-ram;
>   
> -	/* mmc to sram can't do dma, prevent aborts transfering TF-A parts */
> +	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
>   	u-boot,spl-fifo-mode;
>   };
>   
> -&usb20_otg {
> -	hnp-srp-disable;
> +&sdmmc0_bus4 {
> +	bootph-pre-ram;
> +};
> +
> +&sdmmc0_clk {
> +	bootph-pre-ram;
> +};
> +
> +&sdmmc0_cmd {
> +	bootph-pre-ram;
> +};
> +
> +&sdmmc0_dectn {
> +	bootph-pre-ram;
> +};
> +
> +&sdmmc0m1_pin {
> +	bootph-pre-ram;
> +};
> +
> +&uart2 {
> +	bootph-all;
> +	clock-frequency = <24000000>;
>   };
>   
> -&spi0 {
> +&uart2m1_xfer {
>   	bootph-all;
>   };
> +
> +&usb20_otg {
> +	hnp-srp-disable;
> +};
