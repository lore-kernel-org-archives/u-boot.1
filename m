Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4A4CA1000
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB21083890;
	Sat, 30 Aug 2025 17:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q2lp4fVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15A6838AA; Sat, 30 Aug 2025 17:24:04 +0200 (CEST)
Received: from mail-m49213.qiye.163.com (mail-m49213.qiye.163.com
 [45.254.49.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC13A83887
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f9872;
 Sat, 30 Aug 2025 23:23:57 +0800 (GMT+08:00)
Message-ID: <def524aa-e04c-4769-b980-872d57870949@rock-chips.com>
Date: Sat, 30 Aug 2025 23:23:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm: dts: rockchip: Use sdmmc node from dts/upstream
 on RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb94021b03afkunm1a2c4cce415267
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxlPVhkdSxpDHRkdTUNOHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Q2lp4fVXOC5854As5RP5vnQ1VUYrNjHx3PZ5p/ZcWKXD5RKqgWW9sfify2pU+zy9Cvv5nWi1EIOGG/KwGq8GQaXR84dd19LQCTjAIn7XcS/Czs6L4/ImSNG9+GoAj7q8M1bim7b61duD2Viz6Y2JndeM/KpSM5oVaJ3wzNVCg1o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2tWrBv3uNnqZTQA/MSA6ZK9Jm8hVjfftQUukbQv7u5w=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> Drop the sdmmc node from soc u-boot.dtsi and instead use the sdmmc node
> from rk3528.dtsi with v6.16-dts now merged to dts/upstream.
>
> This cleanup has no intended functional change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-generic-u-boot.dtsi    |  9 ---------
>   arch/arm/dts/rk3528-generic.dts            | 12 +++++++++++-
>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi |  9 ---------
>   arch/arm/dts/rk3528-u-boot.dtsi            | 18 ------------------
>   4 files changed, 11 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/dts/rk3528-generic-u-boot.dtsi b/arch/arm/dts/rk3528-generic-u-boot.dtsi
> index cc830b514567..9e1fb2a7eef6 100644
> --- a/arch/arm/dts/rk3528-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-generic-u-boot.dtsi
> @@ -1,12 +1,3 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   #include "rk3528-u-boot.dtsi"
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	no-mmc;
> -	no-sdio;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
> index fe9e72c41cd7..637ca03325ed 100644
> --- a/arch/arm/dts/rk3528-generic.dts
> +++ b/arch/arm/dts/rk3528-generic.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   /*
> - * Minimal generic DT for RK3528 with eMMC enabled
> + * Minimal generic DT for RK3528 with eMMC and SD-card enabled
>    */
>   
>   /dts-v1/;
> @@ -12,6 +12,7 @@
>   
>   	aliases {
>   		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
>   		serial0 = &uart0;
>   	};
>   
> @@ -30,6 +31,15 @@
>   	status = "okay";
>   };
>   
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	no-mmc;
> +	no-sdio;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart0m0_xfer>;
> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> index 1372d8f1e38a..05a58c136bcd 100644
> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> @@ -5,12 +5,3 @@
>   &sdhci {
>   	mmc-hs200-1_8v;
>   };
> -
> -&sdmmc {
> -	bus-width = <4>;
> -	cap-mmc-highspeed;
> -	cap-sd-highspeed;
> -	disable-wp;
> -	vmmc-supply = <&vcc_3v3>;
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
> index eb6a55cd5c93..a18d33b3d369 100644
> --- a/arch/arm/dts/rk3528-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-u-boot.dtsi
> @@ -27,24 +27,6 @@
>   			compatible = "rockchip,rk3528-otp";
>   			reg = <0x0 0xffce0000 0x0 0x4000>;
>   		};
> -
> -		sdmmc: mmc@ffc30000 {
> -			compatible = "rockchip,rk3528-dw-mshc",
> -				     "rockchip,rk3288-dw-mshc";
> -			reg = <0x0 0xffc30000 0x0 0x4000>;
> -			clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SRC_SDMMC0>;
> -			clock-names = "biu", "ciu";
> -			fifo-depth = <0x100>;
> -			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> -			max-frequency = <150000000>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
> -				    <&sdmmc_det>;
> -			resets = <&cru SRST_H_SDMMC0>;
> -			reset-names = "reset";
> -			rockchip,default-sample-phase = <90>;
> -			status = "disabled";
> -		};
>   	};
>   };
>   
