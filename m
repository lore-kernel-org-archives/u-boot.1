Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2DDC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 03:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D30C87ECA;
	Sat, 27 Jan 2024 04:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XQ9arP5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C980587ECE; Sat, 27 Jan 2024 04:48:20 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04B687EC9
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 04:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706327298;
 bh=2tbt8WDT7MRlVC2CV//DdhhR2xyIRrYw+aWBJl0hsC0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XQ9arP5zLizBulquVWRXsdVKac4v0vSuEnOGk/mU9y1D5ZFJAX5oynQa70hg9pkWD
 MyQEjnn5D3IctNbgt6dBO3AkLfzy2wV4LP1ZrTacl8fsaqg9/NV423WWFBJWlrhuEq
 +66kZG8SvVmZxQwauyNz8KojQfEIa/3QJ6tZtBeinJa+WLlFH0OvPPp+21LBX46BOg
 RaBx4nNAGOu9IWAKzKzX1vIweND4mIK0JJ9mlq3a7BdTSCSKblqiEeuySFZKL58bzT
 AWFMC0MIkPXK8ac+PoRVvCsIeptTqbbnk25B7vaUG8OVd+zLRAXE9Mh3B5cMVL8UA/
 9K9mePdGIYwtA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F86C3780629;
 Sat, 27 Jan 2024 03:48:14 +0000 (UTC)
Message-ID: <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
Date: Sat, 27 Jan 2024 05:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240126232615.6826-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Jonas,


On 1/27/24 01:26, Jonas Karlman wrote:
> Writing to eMMC using DDR52 mode does not work reliably or at all on
> RK356x and RK3588 boards.
> 


This is related to the old issue I encountered last year with mmc write?

Thanks,
Eugen

> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>  arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>  arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>  arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>  arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>  arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>  12 files changed, 12 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> index 11976fd3a6e0..930d660868bb 100644
> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> @@ -8,7 +8,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> index 8de9d1535efb..c235b4357f7d 100644
> --- a/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> @@ -4,7 +4,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> index 158f652cb3b1..e0e501deccfe 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -7,5 +7,4 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  };
> diff --git a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> index f65f4067f3e9..5e46a2422d60 100644
> --- a/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> @@ -4,7 +4,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>  };
> diff --git a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> index a44ac35bdacd..1597473017ed 100644
> --- a/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> @@ -8,7 +8,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs400-1_8v;
>  	mmc-hs400-enhanced-strobe;
>  	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 62f572c4cf9f..64c43374c042 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -14,7 +14,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> index ecba91aa30f5..1fc71faa9e07 100644
> --- a/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index caf524443079..74755a44eaee 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -16,7 +16,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 46ebb77283f1..5b823fcca5fb 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -20,7 +20,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	mmc-hs400-enhanced-strobe;
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index e99e60185ebe..9ee9dd051e32 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -31,7 +31,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  };
>  
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index 471508a9ed74..ca2a684f3541 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -8,7 +8,6 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  };
>  
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index 9a6a353088df..efba0c359ba5 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -7,6 +7,5 @@
>  
>  &sdhci {
>  	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  };

