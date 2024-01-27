Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D60C47DDB
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 07:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F387C87F13;
	Sat, 27 Jan 2024 08:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="3QzIS5Gd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECDD87ED0; Sat, 27 Jan 2024 08:27:36 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C2F87EB7
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 08:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706340453;
 bh=7BRmzPrtG+M0uYp2moHkrg7R29ZuPRYcbZ7CKqa7Z40=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=3QzIS5GdXK7uiSq70VI2IqD9ouo00rjnHbY4weG6p9pwXEhV2YgWCs1nQ0s5yl5/e
 35koIU5iCs5NYrURooXb27lNjKdiUjbOs1cWjCTQ+h7NVmytIf6/l7eoGXK1xd2Bgt
 3PFqaCnmfdRp3u0BNt+4ygmNMK5AfGQiTSGboRsOCBGaISkPemvvcuitRab2LkH3wq
 QM4FbONmYketMAxnbmTXSHN7T2UlHnK9v3SC2zavhPF0ClZ8zAcq8I0n3RNPC/3Lpa
 fIaS3b2186y+7AownU9p7t2eTjMCVJ1XGTV9rRkMbCI04ORy++XjRIoBlXToXx0B/K
 l3qRxCpbRg30g==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id F2F0E37813CF;
 Sat, 27 Jan 2024 07:27:30 +0000 (UTC)
Message-ID: <2e2d046b-9e7e-479e-997d-a14cd57f98ab@collabora.com>
Date: Sat, 27 Jan 2024 09:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] rockchip: rk3588: Add default u-boot,spl-boot-order
 prop
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, John Clark <inindev@gmail.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-7-jonas@kwiboo.se>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240126221508.4093334-7-jonas@kwiboo.se>
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

On 1/27/24 00:14, Jonas Karlman wrote:
> Add a default u-boot,spl-boot-order prop to rk3588s-u-boot.dtsi and
> remove the prop from board u-boot.dtsi files using the default value.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi       | 6 ------
>  arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi | 6 ------
>  arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi     | 6 ------
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi         | 4 ----
>  arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi      | 6 ------
>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi        | 6 ------
>  arch/arm/dts/rk3588s-u-boot.dtsi                | 4 ++++
>  7 files changed, 4 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> index 87831c9d432a..60494bb8485f 100644
> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  
>  #include "rk3588-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>  &fspim1_pins {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> index b0f5c667197c..5d5fa6ffb214 100644
> --- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> @@ -2,12 +2,6 @@
>  
>  #include "rk3588-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>  &fspim1_pins {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> index 191ec988c459..7b937943a53c 100644
> --- a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> @@ -4,9 +4,3 @@
>   */
>  
>  #include "rk3588-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 5fa20cecc044..e99e60185ebe 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -7,10 +7,6 @@
>  #include <dt-bindings/usb/pd.h>
>  
>  / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -
>  	vcc12v_dcin: vcc12v-dcin-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index 06c6f327c14b..e791b572b6bf 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  
>  #include "rk3588-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index 584476f77b13..9a6a353088df 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -5,12 +5,6 @@
>  
>  #include "rk3588s-u-boot.dtsi"
>  
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index d251a210b313..945b2d62a75e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -10,6 +10,10 @@
>  		spi5 = &sfc;
>  	};
>  
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +
>  	dmc {
>  		compatible = "rockchip,rk3588-dmc";
>  		bootph-all;

