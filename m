Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55080C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 02:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9EC9879F2;
	Wed,  7 Feb 2024 03:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="faYMt+/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A4687C71; Wed,  7 Feb 2024 03:58:36 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F3C86A26
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 03:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707274708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnAgSnWkrV5Dr6z6EIBTPToP9jCnmzXH870BFsmqRsE=;
 b=faYMt+/0xhNXt1xno3gDcQphV4rUaUuIWZtfVMvvktyMCGCBAvh0/z+ZTdCVREx7UVTI+u
 cgPHS9qYMQRBtJq4aGG12oHTHeTcfL7x3aHb9sEOLVgPXr7TH8kc1HQkulY1/A1mn+5azg
 glF+hRnx2wen/tZmlGWJF9Rskop68vX3MU8z+K/Dqef77KTqZ/4fD2psRn/5rcAOYjCWEP
 lYPQ6GtEawK+AtN5L7OnTDnOzC7nzSW+5ot4dgWzY7N5Ws5WefR9a1vFOU6vJafI7H3jvV
 X1pkXc6ldZJm9IeMSGpQASJky8UJq6eDb8RFtEkTDY7lXOu7Jj6JAJ4GIbWhsg==
Date: Wed, 07 Feb 2024 03:58:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Loic
 Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>, "Matwey V.
 Kornilov" <matwey.kornilov@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 01/15] rockchip: rk3328: Update default u-boot,
 spl-boot-order prop
In-Reply-To: <20240207000301.3270722-2-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-2-jonas@kwiboo.se>
Message-ID: <03acc06690cc89a35e762becb4f7d14d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-07 01:02, Jonas Karlman wrote:
> Change to use a common FIT load order, same-as-spl > SD-card > eMMC on
> RK3328 boards. Only EVB and Radxa ROCK Pi E is affected by this change.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi      | 6 ------
>  arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi           | 5 -----
>  arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi | 5 -----
>  arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     | 5 -----
>  arch/arm/dts/rk3328-roc-cc-u-boot.dtsi               | 5 +----
>  arch/arm/dts/rk3328-rock64-u-boot.dtsi               | 5 +----
>  arch/arm/dts/rk3328-u-boot.dtsi                      | 2 +-
>  7 files changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> index f8adb9e5e1ff..1dc3c022c504 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
> @@ -1,9 +1,3 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> 
>  #include "rk3328-nanopi-r2c-u-boot.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> index 78d37ab47558..d969b008775e 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> @@ -6,11 +6,6 @@
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
> 
>  &gpio0 {
>  	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> index ebe33e48cb9c..5aaa5ccb15c1 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
> @@ -6,11 +6,6 @@
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-lpddr3-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
> 
>  &gpio0 {
>  	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> index 637c70adf194..6d3db86dce6a 100644
> --- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
> @@ -6,11 +6,6 @@
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> -};
> 
>  &gpio0 {
>  	bootph-pre-ram;
> diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> index 2062f34bf825..8bc2f134f8f4 100644
> --- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> @@ -5,11 +5,8 @@
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-ddr4-666.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> 
> +/ {
>  	smbios {
>  		compatible = "u-boot,sysinfo-smbios";
> 
> diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> index 6904515b9693..bfe506fd2249 100644
> --- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
> @@ -5,11 +5,8 @@
> 
>  #include "rk3328-u-boot.dtsi"
>  #include "rk3328-sdram-lpddr3-1600.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
> -	};
> 
> +/ {
>  	smbios {
>  		compatible = "u-boot,sysinfo-smbios";
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi 
> b/arch/arm/dts/rk3328-u-boot.dtsi
> index a9f2536de2a2..a12be7876db0 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -13,7 +13,7 @@
>  	};
> 
>  	chosen {
> -		u-boot,spl-boot-order = &emmc, &sdmmc;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
>  	};
> 
>  	dmc: dmc {
