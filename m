Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE204C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7228087C49;
	Thu,  1 Feb 2024 04:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="I0ClQ1DM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B0287C49; Thu,  1 Feb 2024 04:05:14 +0100 (CET)
Received: from mail-m49220.qiye.163.com (mail-m49220.qiye.163.com
 [45.254.49.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCEF87C7A
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=I0ClQ1DMiNELfhJAbvOLl1ASAkTfgaS6YX3EfPoLDCa+4VqwQVTecc640CcH1V6Ys57kIkP/wstnR2K5Lk4cnr2CujhnMIdMDnjrCHcxhePUAMdIsIevjVKJ+017F/p99voVbsrG0Ghvk1EcsrNVm5DyF3TNHQhe+cjDEZ27hA0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=HqzBt0KQhnuD+IZXj69S+nV1fqc1zHuWKOCk6zLi54Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 707A1900178;
 Thu,  1 Feb 2024 11:04:54 +0800 (CST)
Message-ID: <9339ea60-1b07-471a-acfe-b75b7a90ba77@rock-chips.com>
Date: Thu, 1 Feb 2024 11:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] rockchip: rk3588: Add default u-boot,spl-boot-order
 prop
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126221508.4093334-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIaHVYdShodQ05LGRhJSh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d62a0640e03a9kunm707a1900178
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Cio6MTMJDE0VLQ0QOk5P
 GE1PChRVSlVKTEtNTE5NTUJOT0lJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTUJPNwY+
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


On 2024/1/27 06:14, Jonas Karlman wrote:
> Add a default u-boot,spl-boot-order prop to rk3588s-u-boot.dtsi and
> remove the prop from board u-boot.dtsi files using the default value.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi       | 6 ------
>   arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi | 6 ------
>   arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi     | 6 ------
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi         | 4 ----
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi      | 6 ------
>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi        | 6 ------
>   arch/arm/dts/rk3588s-u-boot.dtsi                | 4 ++++
>   7 files changed, 4 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> index 87831c9d432a..60494bb8485f 100644
> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   
>   #include "rk3588-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>   &fspim1_pins {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> index b0f5c667197c..5d5fa6ffb214 100644
> --- a/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> @@ -2,12 +2,6 @@
>   
>   #include "rk3588-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>   &fspim1_pins {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> index 191ec988c459..7b937943a53c 100644
> --- a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> @@ -4,9 +4,3 @@
>    */
>   
>   #include "rk3588-u-boot.dtsi"
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
>   #include <dt-bindings/usb/pd.h>
>   
>   / {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -
>   	vcc12v_dcin: vcc12v-dcin-regulator {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc12v_dcin";
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index 06c6f327c14b..e791b572b6bf 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -6,12 +6,6 @@
>   
>   #include "rk3588-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> index 584476f77b13..9a6a353088df 100644
> --- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> @@ -5,12 +5,6 @@
>   
>   #include "rk3588s-u-boot.dtsi"
>   
> -/ {
> -	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index d251a210b313..945b2d62a75e 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -10,6 +10,10 @@
>   		spi5 = &sfc;
>   	};
>   
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +	};
> +
>   	dmc {
>   		compatible = "rockchip,rk3588-dmc";
>   		bootph-all;
