Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AD5C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 23:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1864888B4;
	Sun,  4 Aug 2024 01:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="XmPN6N2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E06888CC; Sun,  4 Aug 2024 01:33:55 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C1388861
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 01:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Sun, 4 Aug 2024 01:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1722728033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7R7Ex8j23kr+T2klQ3LLbRoZp+Z7QT88+H5+SwHGYs=;
 b=XmPN6N2rNOgLDNnM4BHpXMAGISt12C8zUBhkxXJgWUIglXUff+Mfg6Gz0hPqzoV9ygf0WZ
 TNLv3Qpe1rFKen31fthwMxN3tKokAJp7VN3c9USsFx++JU6kSp6ylYJ1BmLmDhk42M6zkR
 od2V6n68/qqyCI1ea5MNYlVVctjBGhw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Minkyu Kang <promsoft@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH v4 14/38] arm: dts: exynos: Add upstream DW MMC
 properties to all Exynos dts
Message-ID: <20240803233350.GA194598@l14.localdomain>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
 <20240725204520.18134-15-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725204520.18134-15-semen.protsenko@linaro.org>
X-Migadu-Flow: FLOW_OUT
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

Hi Sam,

Thanks for working on this, makes switching to upstream dts'es easier
:)

I tested the series on exynos4412-odroid-u2 and exynos5422-odroid-xu4.
One issue for exynos4412-odroid to resolve below, with that fixed
booting from both eMMC and sdcard works on my devices.

On Thu, Jul 25, 2024 at 03:44:56PM -0500, Sam Protsenko wrote:
> Some device tree properties for DW MMC block were updated in Linux
> kernel. Let's follow its example and rework corresponding properties in
> all Exynos device trees. Don't remove outdated properties yet, it'll be
> done later once DW MMC driver is updated accordingly to read the updated
> properties instead of outdated ones.
> 
> Next properties are added:
> 
> * samsung,dw-mshc-ciu-div and samsung,dw-mshc-sdr-timing:
> 
>   They were derived from outdated samsung,timing property.
> 
> * fifo-depth (generic replacement for fifoth_val):
> 
>   FIFO depth was calculated from fifoth_val (using expressions from
>   FIFOTH register description in TRM):
> 
>       fifo-depth = ((fifoth_val >> 16) + 1) * 2
> 
> * bus-width: generic replacement for samsung,bus-width
> * clock-frequency: generic replacement for bus_hz
> * non-removable: generic replacement for samsung,removable = <0>
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v4:
>   - (none)
> 
> Changes in v3:
>   - (none)
> 
> Changes in v2:
>   - (none)
> 
>  arch/arm/dts/exynos4210-origen.dts         | 1 +
>  arch/arm/dts/exynos4210-trats.dts          | 2 ++
>  arch/arm/dts/exynos4210-universal_c210.dts | 2 ++
>  arch/arm/dts/exynos4412-odroid.dts         | 6 ++++++
>  arch/arm/dts/exynos4412-trats2.dts         | 8 ++++++++
>  arch/arm/dts/exynos5250-arndale.dts        | 6 ++++++
>  arch/arm/dts/exynos5250-smdk5250.dts       | 7 +++++++
>  arch/arm/dts/exynos5250-snow.dts           | 7 +++++++
>  arch/arm/dts/exynos5250-spring.dts         | 4 ++++
>  arch/arm/dts/exynos5420-smdk5420.dts       | 7 +++++++
>  arch/arm/dts/exynos5422-odroidxu3.dts      | 2 ++
>  arch/arm/dts/exynos54xx.dtsi               | 7 +++++++
>  12 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm/dts/exynos4210-origen.dts b/arch/arm/dts/exynos4210-origen.dts
> index 65a5fcd67eff..a4915de2c49c 100644
> --- a/arch/arm/dts/exynos4210-origen.dts
> +++ b/arch/arm/dts/exynos4210-origen.dts
> @@ -26,6 +26,7 @@
>  
>  &sdhci2 {
>  	samsung,bus-width = <4>;
> +	bus-width = <4>;
>  	samsung,timing = <1 2 3>;
>  	cd-gpios = <&gpk2 2 0>;
>  	status = "okay";
> diff --git a/arch/arm/dts/exynos4210-trats.dts b/arch/arm/dts/exynos4210-trats.dts
> index 05989ee97e5b..4fbdf4730994 100644
> --- a/arch/arm/dts/exynos4210-trats.dts
> +++ b/arch/arm/dts/exynos4210-trats.dts
> @@ -241,6 +241,7 @@
>  
>  &sdhci0 {
>  	samsung,bus-width = <8>;
> +	bus-width = <8>;
>  	samsung,timing = <1 3 3>;
>  	pwr-gpios = <&gpk0 2 0>;
>  	status = "okay";
> @@ -248,6 +249,7 @@
>  
>  &sdhci2 {
>  	samsung,bus-width = <4>;
> +	bus-width = <4>;
>  	samsung,timing = <1 2 3>;
>  	cd-gpios = <&gpx3 4 0>;
>  	status = "okay";
> diff --git a/arch/arm/dts/exynos4210-universal_c210.dts b/arch/arm/dts/exynos4210-universal_c210.dts
> index 610a8ad2e71e..1b3ac1fee15f 100644
> --- a/arch/arm/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/dts/exynos4210-universal_c210.dts
> @@ -236,6 +236,7 @@
>  
>  &sdhci0 {
>  	samsung,bus-width = <8>;
> +	bus-width = <8>;
>  	samsung,timing = <1 3 3>;
>  	pwr-gpios = <&gpk0 2 0>;
>  	status = "okay";
> @@ -243,6 +244,7 @@
>  
>  &sdhci2 {
>  	samsung,bus-width = <4>;
> +	bus-width = <4>;
>  	samsung,timing = <1 2 3>;
>  	cd-gpios = <&gpx3 4 0>;
>  	status = "okay";
> diff --git a/arch/arm/dts/exynos4412-odroid.dts b/arch/arm/dts/exynos4412-odroid.dts
> index ce08e8dc1ebb..24e96ed05868 100644
> --- a/arch/arm/dts/exynos4412-odroid.dts
> +++ b/arch/arm/dts/exynos4412-odroid.dts
> @@ -243,9 +243,15 @@
>  
>  &mshc_0 {
>  	samsung,bus-width = <8>;
> +	bus-width = <8>;
>  	samsung,timing = <2 1 0>;
> +	samsung,dw-mshc-ciu-div = <0>;
> +	samsung,dw-mshc-sdr-timing = <2 1>;
>  	samsung,removable = <0>;
> +	non-removable;
>  	fifoth_val = <0x203f0040>;
> +	fifo-depth = <0x80>;
> +	clock-frequency = <400000000>;
>  	bus_hz = <400000000>;
>  	div = <0x3>;
>  	index = <4>;

bus-width needs to be added to sdhci2 (sdcard) node above as well.

Best regards,
Henrik Grimler

> diff --git a/arch/arm/dts/exynos4412-trats2.dts b/arch/arm/dts/exynos4412-trats2.dts
> index c4db137e01f6..30758ffa1ef9 100644
> --- a/arch/arm/dts/exynos4412-trats2.dts
> +++ b/arch/arm/dts/exynos4412-trats2.dts
> @@ -109,6 +109,7 @@
>  
>  	sdhci@12510000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
>  		pwr-gpios = <&gpk0 4 0>;
>  		status = "disabled";
> @@ -432,6 +433,7 @@
>  
>  &sdhci0 {
>  	samsung,bus-width = <8>;
> +	bus-width = <8>;
>  	samsung,timing = <1 3 3>;
>  	pwr-gpios = <&gpk0 4 0>;
>  	status = "disabled";
> @@ -439,6 +441,7 @@
>  
>  &sdhci2 {
>  	samsung,bus-width = <4>;
> +	bus-width = <4>;
>  	samsung,timing = <1 2 3>;
>  	cd-gpios = <&gpk2 2 0>;
>  	status = "okay";
> @@ -446,9 +449,14 @@
>  
>  &mshc_0 {
>  	samsung,bus-width = <8>;
> +	bus-width = <8>;
>  	samsung,timing = <2 1 0>;
> +	samsung,dw-mshc-ciu-div = <0>;
> +	samsung,dw-mshc-sdr-timing = <2 1>;
>  	samsung,removable = <0>;
> +	non-removable;
>  	fifoth_val = <0x203f0040>;
> +	clock-frequency = <400000000>;
>  	bus_hz = <400000000>;
>  	div = <0x3>;
>  	index = <4>;
> diff --git a/arch/arm/dts/exynos5250-arndale.dts b/arch/arm/dts/exynos5250-arndale.dts
> index 60309c61f302..7f84589c97a2 100644
> --- a/arch/arm/dts/exynos5250-arndale.dts
> +++ b/arch/arm/dts/exynos5250-arndale.dts
> @@ -28,7 +28,10 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  	};
>  
>  	mmc@12210000 {
> @@ -37,7 +40,10 @@
>  
>  	mmc@12220000 {
>  		samsung,bus-width = <4>;
> +		bus-width = <4>;
>  		samsung,timing = <1 2 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 2>;
>  	};
>  
>  	mmc@12230000 {
> diff --git a/arch/arm/dts/exynos5250-smdk5250.dts b/arch/arm/dts/exynos5250-smdk5250.dts
> index afe0cca48a93..882db2d1f608 100644
> --- a/arch/arm/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/dts/exynos5250-smdk5250.dts
> @@ -146,8 +146,12 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  		samsung,removable = <0>;
> +		non-removable;
>  	};
>  
>  	mmc@12210000 {
> @@ -156,7 +160,10 @@
>  
>  	mmc@12220000 {
>  		samsung,bus-width = <4>;
> +		bus-width = <4>;
>  		samsung,timing = <1 2 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 2>;
>  		samsung,removable = <1>;
>  	};
>  
> diff --git a/arch/arm/dts/exynos5250-snow.dts b/arch/arm/dts/exynos5250-snow.dts
> index e41f2d3041e2..bcf04d5c07c0 100644
> --- a/arch/arm/dts/exynos5250-snow.dts
> +++ b/arch/arm/dts/exynos5250-snow.dts
> @@ -302,8 +302,12 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  		samsung,removable = <0>;
> +		non-removable;
>  	};
>  
>  	mmc@12210000 {
> @@ -312,7 +316,10 @@
>  
>  	mmc@12220000 {
>  		samsung,bus-width = <4>;
> +		bus-width = <4>;
>  		samsung,timing = <1 2 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 2>;
>  		samsung,removable = <1>;
>  	};
>  
> diff --git a/arch/arm/dts/exynos5250-spring.dts b/arch/arm/dts/exynos5250-spring.dts
> index 77e7a6b9e45a..7270a546a795 100644
> --- a/arch/arm/dts/exynos5250-spring.dts
> +++ b/arch/arm/dts/exynos5250-spring.dts
> @@ -104,8 +104,12 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  		samsung,removable = <0>;
> +		non-removable;
>  	};
>  
>  	mmc@12210000 {
> diff --git a/arch/arm/dts/exynos5420-smdk5420.dts b/arch/arm/dts/exynos5420-smdk5420.dts
> index 7a5da674fbed..1f27baafebaf 100644
> --- a/arch/arm/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/dts/exynos5420-smdk5420.dts
> @@ -107,8 +107,12 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  		samsung,removable = <0>;
> +		non-removable;
>  		samsung,pre-init;
>  	};
>  
> @@ -118,7 +122,10 @@
>  
>  	mmc@12220000 {
>  		samsung,bus-width = <4>;
> +		bus-width = <4>;
>  		samsung,timing = <1 2 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 2>;
>  		samsung,removable = <1>;
>  	};
>  
> diff --git a/arch/arm/dts/exynos5422-odroidxu3.dts b/arch/arm/dts/exynos5422-odroidxu3.dts
> index 9d055d066fd3..767b3e415d58 100644
> --- a/arch/arm/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/dts/exynos5422-odroidxu3.dts
> @@ -281,10 +281,12 @@
>  
>  	mmc@12200000 {
>  		fifoth_val = <0x201f0020>;
> +		fifo-depth = <0x40>;
>  	};
>  
>  	mmc@12220000 {
>  		fifoth_val = <0x201f0020>;
> +		fifo-depth = <0x40>;
>  	};
>  
>  	emmc-reset {
> diff --git a/arch/arm/dts/exynos54xx.dtsi b/arch/arm/dts/exynos54xx.dtsi
> index 221da8b4850b..fd74166c7e48 100644
> --- a/arch/arm/dts/exynos54xx.dtsi
> +++ b/arch/arm/dts/exynos54xx.dtsi
> @@ -120,8 +120,12 @@
>  
>  	mmc@12200000 {
>  		samsung,bus-width = <8>;
> +		bus-width = <8>;
>  		samsung,timing = <1 3 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 3>;
>  		samsung,removable = <0>;
> +		non-removable;
>  		samsung,pre-init;
>  	};
>  
> @@ -131,7 +135,10 @@
>  
>  	mmc@12220000 {
>  		samsung,bus-width = <4>;
> +		bus-width = <4>;
>  		samsung,timing = <1 2 3>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <1 2>;
>  		samsung,removable = <1>;
>  	};
>  
> -- 
> 2.39.2
> 
