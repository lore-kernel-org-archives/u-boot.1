Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C89CC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D8B88AE3;
	Thu,  8 Aug 2024 15:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="AUTSmE+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D127B88AE8; Thu,  8 Aug 2024 15:13:44 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FA788AAE
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1723122821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qppaXw1QPaZLbT18wB+zeGbiYh3X4ns+4UUGfb1WH4=;
 b=AUTSmE+ApDk1uD+Z+jPq9Ya7USgLZwcwkgFE+7Lr6XuNE+w7nQiNjw9DyJ+wup0fGrXs4y
 +0WsFZDmRyyIzniK/ReTvZJWgYZ2JgAbj74uVN0Bz11lqRQuZNUafu2HNsWuAhQ87dUMrH
 iUmfi2YwaR2ohCOivI8MFqRqRai4j9yn98p7ks/L/DQNh/CPie19I6j9b7Dpn1/4/vbrLP
 +RtLojfpqlu7G8d0XF36j/GAc2mlGrw1uUX7sKE8RVrC5HU+QhxxCPREtdC9uBAdvt+pa1
 qmed7zFp4nwv0PMcv/IMgRM/FN7SZvtMziIB2x8hGFTvpGxZ6AdQrlvFUv9LlQ==
Date: Thu, 08 Aug 2024 15:13:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, banglang.huang@foxmail.com, jonas@kwiboo.se,
 jagan@amarulasolutions.com, gajjar04akash@gmail.com,
 eugen.hristev@collabora.com, chris.obbard@collabora.com
Subject: Re: [PATCH 2/2] arm: dts: rockchip: turn LEDs on at boot for Radxa
 boards
In-Reply-To: <20240808092743.1508-2-naoki@radxa.com>
References: <20240808092743.1508-1-naoki@radxa.com>
 <20240808092743.1508-2-naoki@radxa.com>
Message-ID: <d5df7805c948eb4725af848b82e2959d@manjaro.org>
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

Hello Fukaumi,

Please see a comment below.

On 2024-08-08 11:27, FUKAUMI Naoki wrote:
> Basically, Radxa's boards are intended to turn LEDs on at U-Boot.
> add `default-state = "on"` to u-boot.dtsi.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>  .../arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi |  6 +++++
>  arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi  | 25 ++++++++++++++++++-
>  arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi     |  8 ++++++
>  arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi  |  8 ++++++
>  arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi     | 23 +++++++++++++++++
>  arch/arm/dts/rk3568-rock-3a-u-boot.dtsi       |  8 ++++++
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 ++++++
>  arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi      |  8 ++++++
>  8 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> index 39bb66c4fcb..a30adb0be98 100644
> --- a/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
> @@ -6,6 +6,12 @@
>  #include "rk3328-u-boot.dtsi"
> 
>  / {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +
>  	smbios {
>  		compatible = "u-boot,sysinfo-smbios";
> 
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 5ec15a845c1..614e4ce0fa8 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -2,7 +2,20 @@
>  /*
>   * Copyright (c) 2023 Radxa Limited
>   */
> -#include "rk3399-rock-pi-4-u-boot.dtsi"
> +#include "rk3399-u-boot.dtsi"
> +#include "rk3399-sdram-lpddr4-100.dtsi"
> +
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
> 
>  &pcfg_pull_none_18ma {
>  	bootph-pre-ram;
> @@ -14,6 +27,12 @@
>  	bootph-some-ram;
>  };
> 
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +};
> +

This change should be taken out of the patch, because it doesn't
match the patch description.  If the change is still needed, it
should be submitted as a separate patch.

>  &spi1 {
>  	status = "okay";
> 
> @@ -25,3 +44,7 @@
>  		spi-max-frequency = <10000000>;
>  	};
>  };
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index b3bfc77f756..4861574636e 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -6,6 +6,14 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> index e0e501deccf..412f9e06aff 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> @@ -5,6 +5,14 @@
> 
>  #include "rk356x-u-boot.dtsi"
> 
> +/ {
> +	leds {
> +		led-1 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>  &sdhci {
>  	cap-mmc-highspeed;
>  };
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 74755a44eae..efeab626d8a 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -2,6 +2,29 @@
> 
>  #include "rk356x-u-boot.dtsi"
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
>  &pcie3x1 {
>  	pinctrl-0 = <&pcie30x1_reset_h>;
>  };
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 9d18f5d0b36..c493352abc1 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -6,6 +6,14 @@
> 
>  #include "rk356x-u-boot.dtsi"
> 
> +/ {
> +	leds {
> +		led-0 {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>  &pcie3x2 {
>  	pinctrl-0 = <&pcie3x2_reset_h>;
>  };
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 8e318e624a8..8ebba36f90a 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -5,6 +5,14 @@
> 
>  #include "rk3588-u-boot.dtsi"
> 
> +/ {
> +	leds {
> +		led_rgb_b {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>  &fspim2_pins {
>  	bootph-pre-ram;
>  	bootph-some-ram;
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index efba0c359ba..a75ae296386 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -5,6 +5,14 @@
> 
>  #include "rk3588s-u-boot.dtsi"
> 
> +/ {
> +	leds {
> +		io-led {
> +			default-state = "on";
> +		};
> +	};
> +};
> +
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-hs200-1_8v;
