Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA4ED0E6C1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72DFD892EA;
	Mon, 21 Oct 2024 10:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NU5J9ecB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B2A892E8; Mon, 21 Oct 2024 10:16:33 +0200 (CEST)
Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com
 [45.254.49.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6BB892AB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NU5J9ecBJyRCpikwwoh+exyuGSWlTCLOL9UcTiPI5j/gkU/ixVSND89rQTV9fjkYaDkkr8CbESqAPeJVlM7fOXH5pFU5CGDR8M3kaYxJyoD447fVyY0afi3gqxFDhwuODnoKwcwk9my1jrOKOT9RjZEJKVxfFuHWKqiNGVtKjbw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=cYGZYcYlPNoRvTILAYWjHSlaCcAYVssgvTdWlrgh4+g=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 82F4752064C;
 Mon, 21 Oct 2024 16:16:23 +0800 (CST)
Message-ID: <8e615323-e655-4c40-a9d9-a2ddf2c279a6@rock-chips.com>
Date: Mon, 21 Oct 2024 16:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm: dts: rockchip: turn LEDs on at boot for Radxa
 boards
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: banglang.huang@foxmail.com, jonas@kwiboo.se, sjg@chromium.org,
 philipp.tomsich@vrull.eu, jagan@amarulasolutions.com,
 gajjar04akash@gmail.com, chris.obbard@collabora.com, dsimic@manjaro.org
References: <20240808222325.2082-1-naoki@radxa.com>
 <20240808222325.2082-2-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240808222325.2082-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4YQlZJSh1PQ0pPTBlKGU9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 xVSktLVUpCS0tZBg++
X-HM-Tid: 0a92ae261a1303afkunm82f4752064c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6NAw4TDItOS5KEx8xGT8i
 CUoaCUpVSlVKTElCT0JDTkNNTk1PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTEtDNwY+
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


On 2024/8/9 06:23, FUKAUMI Naoki wrote:
> Basically, Radxa's boards are intended to turn LEDs on at U-Boot.
> add `default-state = "on"` to u-boot.dtsi.
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - remove irrelevant contents from rk3399-rock-4c-plus-u-boot.dtsi
> - depend https://patchwork.ozlabs.org/project/uboot/patch/20240808221902.2006-1-naoki@radxa.com/
> ---
>   .../arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  6 +++++
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  | 12 ++++++++++
>   arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi     |  8 +++++++
>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi  |  8 +++++++
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 23 +++++++++++++++++++
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |  8 +++++++
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +++++++
>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi      |  8 +++++++
>   8 files changed, 81 insertions(+)
>
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> index 39bb66c4fcb..a30adb0be98 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> @@ -6,6 +6,12 @@
>   #include "rk3328-u-boot.dtsi"
>   
>   / {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +
>   	smbios {
>   		compatible = "u-boot,sysinfo-smbios";
>   
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 50dae5cb5ef..7a6af430a6f 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -6,6 +6,18 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &pcfg_pull_none_18ma {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index b3bfc77f756..4861574636e 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -6,6 +6,14 @@
>   #include "rk3399-u-boot.dtsi"
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> index e0e501deccf..412f9e06aff 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -5,6 +5,14 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> +/ {
> +	leds {
> +		led-1 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   };
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 74755a44eae..efeab626d8a 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -2,6 +2,29 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> +/ {
> +	gpio-leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +
> +		led-red {
> +			default-state = "on";
> +			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-green {
> +			default-state = "on";
> +			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-blue {
> +			default-state = "on";
> +			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
>   &pcie3x1 {
>   	pinctrl-0 = <&pcie30x1_reset_h>;
>   };
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 9d18f5d0b36..c493352abc1 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -6,6 +6,14 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &pcie3x2 {
>   	pinctrl-0 = <&pcie3x2_reset_h>;
>   };
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 8e318e624a8..8ebba36f90a 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -5,6 +5,14 @@
>   
>   #include "rk3588-u-boot.dtsi"
>   
> +/ {
> +	leds {
> +		led_rgb_b {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &fspim2_pins {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index efba0c359ba..a75ae296386 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -5,6 +5,14 @@
>   
>   #include "rk3588s-u-boot.dtsi"
>   
> +/ {
> +	leds {
> +		io-led {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
