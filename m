Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A4C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 03:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D99788720;
	Tue,  7 May 2024 05:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bji/UbBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402B188651; Tue,  7 May 2024 05:27:49 +0200 (CEST)
Received: from mail-m118220.qiye.163.com (mail-m118220.qiye.163.com
 [115.236.118.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A5488662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 05:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Bji/UbBdCAroXqpRoQpN8o8Ebek71ZvtNycnBmScUne6P7U2+STDgSOx3Tb3HA1+LPb6uE7+NT/bvFfGrPUcHMMFFZSEopsdrn1LxZ1dMUpZ52t0Nle/V/KBLhfCq7dc79eUD9TkkDpQXIDuBcXF6iV6bO0PqsR+Bl2S5GepUfM=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=QXDBRf57ebsSQjiQEkZQEm8yJO5BFBqvncbcx0rDzmQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 47B4E900268;
 Tue,  7 May 2024 11:27:24 +0800 (CST)
Message-ID: <3c17a382-c0c9-4788-8cd7-d364a01bfe40@rock-chips.com>
Date: Tue, 7 May 2024 11:27:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3328: Add missing bootph-some-ram props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 David Bauer <mail@david-bauer.net>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240501192127.962261-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240501192127.962261-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9IGFZKSEkZSUlMGUoZTkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f51177c1403a9kunm47b4e900268
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6GTo*MjNDNhRIShgeDQsL
 GBZPCQ9VSlVKTEpOS05JT09OSk9IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMSk5DNwY+
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


On 2024/5/2 03:21, Jonas Karlman wrote:
> Add bootph-some-ram props to pinctrl nodes related to eMMC, SD-card and
> SPI flash to match e.g. RK3308 and RK3399.
>
> Also adjust bootph props for sdio_vcc_pin, pinctrl and uart2m1_xfer.
>
> Fixes: 1e21f5693045 ("rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> This has been runtime tested on a Rock64 and NanoPi R2S Plus.
>
> The uart2m1_xfer change help speed up boot by around 100 ms.
> ---
>   arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    |  2 +-
>   .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   |  7 ++++---
>   .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   |  7 ++++---
>   arch/arm/dts/rk3328-rock64-u-boot.dtsi        |  7 ++++---
>   arch/arm/dts/rk3328-u-boot.dtsi               | 20 +++++++++++++++----
>   5 files changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> index 4fa170eeaf8d..d8c79600b659 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> @@ -12,7 +12,7 @@
>   };
>   
>   &sdio_vcc_pin {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &usb20_otg {
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index 0a9423cd9c7e..b50c1332b836 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -8,9 +8,6 @@
>   #include "rk3328-sdram-lpddr3-666.dtsi"
>   
>   &spi0 {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> -
>   	flash@0 {
>   		bootph-pre-ram;
>   		bootph-some-ram;
> @@ -19,18 +16,22 @@
>   
>   &spi0m2_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_cs0 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_rx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_tx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &usb20_otg {
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 1096821fc5d3..8ae003bbefd1 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -8,9 +8,6 @@
>   #include "rk3328-sdram-ddr4-666.dtsi"
>   
>   &spi0 {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> -
>   	flash@0 {
>   		bootph-pre-ram;
>   		bootph-some-ram;
> @@ -19,18 +16,22 @@
>   
>   &spi0m2_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_cs0 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_rx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_tx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &usb20_otg {
> diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> index 551cff6f24f6..22f128090f84 100644
> --- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> @@ -30,9 +30,6 @@
>   };
>   
>   &spi0 {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> -
>   	flash@0 {
>   		bootph-pre-ram;
>   		bootph-some-ram;
> @@ -41,18 +38,22 @@
>   
>   &spi0m2_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_cs0 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_rx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &spi0m2_tx {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &usb20_otg {
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index d3608bd0e2b2..0135bc08d491 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -17,7 +17,6 @@
>   	};
>   
>   	dmc: dmc {
> -		bootph-all;
>   		compatible = "rockchip,rk3328-dmc";
>   		reg = <0x0 0xff400000 0x0 0x1000
>   		       0x0 0xff780000 0x0 0x3000
> @@ -25,6 +24,7 @@
>   		       0x0 0xff440000 0x0 0x1000
>   		       0x0 0xff720000 0x0 0x1000
>   		       0x0 0xff798000 0x0 0x1000>;
> +		bootph-all;
>   	};
>   };
>   
> @@ -42,14 +42,17 @@
>   
>   &emmc_bus8 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &emmc_cmd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &gpio0 {
> @@ -66,10 +69,12 @@
>   
>   &pcfg_pull_none_8ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_none_12ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_up {
> @@ -78,19 +83,21 @@
>   
>   &pcfg_pull_up_4ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_up_8ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pcfg_pull_up_12ma {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &pinctrl {
> -	bootph-pre-ram;
> -	bootph-some-ram;
> +	bootph-all;
>   };
>   
>   &sdmmc {
> @@ -103,18 +110,22 @@
>   
>   &sdmmc0_bus4 {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_clk {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_cmd {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0_dectn {
>   	bootph-pre-ram;
> +	bootph-some-ram;
>   };
>   
>   &sdmmc0m1_pin {
> @@ -127,7 +138,8 @@
>   };
>   
>   &uart2m1_xfer {
> -	bootph-all;
> +	bootph-pre-sram;
> +	bootph-pre-ram;
>   };
>   
>   &vop {
