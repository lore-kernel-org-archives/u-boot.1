Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DABC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C681088B3C;
	Wed,  1 May 2024 10:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="XluEvWnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6154188B3D; Wed,  1 May 2024 10:49:47 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE2B88B34
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714553384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/10cF+yRhKgiNxwBbWLdS9i9fpVK2mF8hlimVGnTtI=;
 b=XluEvWnCNC6Ux/9y1Ul0wdCPYxiNDeSOc1gYg8i/8y/kuY+xfYjMIucZg38czbUtN2V9ei
 WoOSnl6lJqvdjt5BMyBNiGnQTTOGvEzYbBRURN9g1Cm5jbY3u3Bh+A9PR4T2SU/DwKGKMo
 kiUPzYwYm96FB73djJD/bE4wUx2gBj9qlHgZ0QcVbv31DFpO6vq5hvsrZFtvg10cfI+f43
 blQILT1R0XAb+qZTXFXld6QIgg/GQ9Icgz4Jckr9+WOH9HQEkQ2IfnKrr7a3pIEFLRrOW9
 ilp1kwW+aFMYRhH1ldp4Zbk26/DEQdLsC4UqsjPSRaXGrQovMW11VRj9M7PNTA==
Date: Wed, 01 May 2024 10:49:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Peter
 Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, Suniel Mahesh
 <sunil@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 11/18] rockchip: rk3399: Add a default spl-boot-order
 prop
In-Reply-To: <20240430153053.308788-12-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-12-jonas@kwiboo.se>
Message-ID: <42b94427811d5a217981298852421dec@manjaro.org>
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

On 2024-04-30 17:30, Jonas Karlman wrote:
> A lot of RK3399 boards use a u-boot,spl-boot-order of "same-as-spl",
> &sdhci and &sdmmc.
> 
> Move this to rk3399-u-boot.dtsi and make this default for boards
> currently missing a u-boot,spl-boot-order prop.
> 
> Before commit a7e69952eb6d ("rockchip: spl: Cache boot source id for
> later use") it was required to include the SPI flash node in the
> u-boot,spl-boot-order prop to successfully load FIT from SPI flash.
> 
> The SPI flash node reference has been dropped from spl-boot-order from
> pinebook-pro, roc-pc and rockpro64 now that "same-as-spl" also gets
> resolved to the SPI flash node and loading FIT from SPI flash works
> without having the node explicitly referenced in spl-boot-order prop.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Update commit message
> ---
>  arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi      | 1 -
>  arch/arm/dts/rk3399-evb-u-boot.dtsi            | 1 -
>  arch/arm/dts/rk3399-ficus-u-boot.dtsi          | 6 ------
>  arch/arm/dts/rk3399-firefly-u-boot.dtsi        | 6 ------
>  arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi    | 6 ------
>  arch/arm/dts/rk3399-leez-p710-u-boot.dtsi      | 6 ------
>  arch/arm/dts/rk3399-nanopi4-u-boot.dtsi        | 6 ------
>  arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi   | 6 ------
>  arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi  | 6 ------
>  arch/arm/dts/rk3399-roc-pc-u-boot.dtsi         | 4 ----
>  arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi      | 6 ------
>  arch/arm/dts/rk3399-rock960-u-boot.dtsi        | 5 -----
>  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi      | 5 +----
>  arch/arm/dts/rk3399-u-boot.dtsi                | 4 ++++
>  arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi | 6 ------
>  15 files changed, 5 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> index a3f27566e438..6c07de98fa01 100644
> --- a/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-eaidk-610-u-boot.dtsi
> @@ -9,7 +9,6 @@
>  / {
>  	chosen {
>  		stdout-path = "serial2:1500000n8";
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>  	};
>  };
> 
> diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> index dfce63e4d428..796ac9642399 100644
> --- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> @@ -9,7 +9,6 @@
>  / {
>  	chosen {
>  		stdout-path = "serial2:1500000n8";
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>  	};
>  };
> 
> diff --git a/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> index 38e0897db91d..67b63a835238 100644
> --- a/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
> @@ -5,9 +5,3 @@
> 
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-ddr3-1600.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> diff --git a/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> index c58ad95d120a..1f5fda1d0f1d 100644
> --- a/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-firefly-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-ddr3-1600.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &vdd_log {
>  	regulator-init-microvolt = <950000>;
>  };
> diff --git a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> index a7039d74a016..4a3b23e48313 100644
> --- a/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &vdd_log {
>  	regulator-init-microvolt = <950000>;
>  };
> diff --git a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> index c638ce259731..03b596850635 100644
> --- a/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-leez-p710-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &vdd_log {
>  	regulator-init-microvolt = <950000>;
>  };
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> index a9d10592d573..a126bbaf086f 100644
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> @@ -5,12 +5,6 @@
> 
>  #include "rk3399-u-boot.dtsi"
> 
> -/{
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &sdmmc {
>  	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
>  };
> diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> index 88a77cad8d43..83b0c44e9ec5 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &spiflash, &sdmmc;
> -	};
> -};
> -
>  &edp {
>  	rockchip,panel = <&edp_panel>;
>  };
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 0e46e87e1fa0..5dc7d0db5f73 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &sdhci {
>  	max-frequency = <25000000>;
>  	bootph-all;
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index c8f4418a7389..e390cf3abab5 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -7,10 +7,6 @@
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
>  / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdhci, &sdmmc;
> -	};
> -
>  	vcc_hub_en: vcc_hub_en-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> index 60122f3bcd6c..b3bfc77f7569 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
> @@ -6,12 +6,6 @@
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> 
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
> -
>  &sdhci {
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> index c190089e2643..55716ba4df73 100644
> --- a/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
> @@ -7,10 +7,6 @@
>  #include "rk3399-sdram-lpddr3-2GB-1600.dtsi"
> 
>  / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -
>  	vdd_log: vdd-log {
>  		compatible = "pwm-regulator";
>  		pwms = <&pwm2 0 25000 1>;
> @@ -22,5 +18,4 @@
>  		regulator-init-microvolt = <950000>;
>  		vin-supply = <&vcc5v0_sys>;
>  	};
> -
>  };
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 089732524a76..b15e5392c3cf 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -5,11 +5,8 @@
> 
>  #include "rk3399-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr4-100.dtsi"
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
> -	};
> 
> +/ {
>          smbios {
>                  compatible = "u-boot,sysinfo-smbios";
>                  smbios {
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi 
> b/arch/arm/dts/rk3399-u-boot.dtsi
> index 0b0a90acf431..96523a138ae3 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -14,6 +14,10 @@
>  		spi1 = &spi1;
>  	};
> 
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> +	};
> +
>  	cic: syscon@ff620000 {
>  		bootph-all;
>  		compatible = "rockchip,rk3399-cic", "syscon";
> diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> index 7c66e1145a50..946a0230dbb4 100644
> --- a/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399pro-rock-pi-n10-u-boot.dtsi
> @@ -5,9 +5,3 @@
> 
>  #include "rk3399pro-u-boot.dtsi"
>  #include "rk3399-sdram-lpddr3-4GB-1600.dtsi"
> -
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> -	};
> -};
