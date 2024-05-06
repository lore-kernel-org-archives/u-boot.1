Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C68FC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC25883D1;
	Mon,  6 May 2024 12:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="h9QSlxJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9BB8859F; Mon,  6 May 2024 12:36:13 +0200 (CEST)
Received: from mail-m17248.xmail.ntesmail.com (mail-m17248.xmail.ntesmail.com
 [45.195.17.248])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A0788327
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=h9QSlxJvbbXxmS9f9ZUYIb8GROSr1+BpHdIl3cP4S/rP7zkTZ29bg6/fugRqT7FOj+0ZDyLpR/8BE7PqQdN/dlfBdYU1mwbZQ+qMluQuwh9TPgWm7wZJMnNMyo8x34IS5SPkys8UIahkbea04Kt1WthksZyIxinHU47ooeo6GRc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=amcIwQZV1qYgZw4AHENZTwkECJiM+sNGY9fo+d2ozmo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 01241900275;
 Mon,  6 May 2024 18:36:03 +0800 (CST)
Message-ID: <c8d893d5-5e41-4e60-9614-8e8b434524de@rock-chips.com>
Date: Mon, 6 May 2024 18:36:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] rockchip: rk3399: Remove inherited bootph-all
 props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-13-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1JTlYdHRlCSEpKQ0IZHRlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7993b203a9kunm01241900275
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6Lio6SjNPIhYNMTgVQk4f
 MCsaCypVSlVKTEpPQkJKTE1PTENNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUJJNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> Remove superfluous bootph-all props already inherited from main soc
> u-boot.dtsi file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> ---
>   arch/arm/dts/rk3399-evb-u-boot.dtsi           | 1 -
>   arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi  | 2 --
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 2 --
>   3 files changed, 5 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> index 796ac9642399..9df4a02c3e74 100644
> --- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
> @@ -38,7 +38,6 @@
>   };
>   
>   &sdmmc {
> -	bootph-all;
>   	bus-width = <4>;
>   	cap-mmc-highspeed;
>   	cap-sd-highspeed;
> diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> index 83b0c44e9ec5..56fdaf440aea 100644
> --- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
> @@ -12,12 +12,10 @@
>   
>   &sdhci {
>   	max-frequency = <25000000>;
> -	bootph-all;
>   };
>   
>   &sdmmc {
>   	max-frequency = <20000000>;
> -	bootph-all;
>   };
>   
>   &spiflash {
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 5dc7d0db5f73..dcfcec4f3072 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -8,10 +8,8 @@
>   
>   &sdhci {
>   	max-frequency = <25000000>;
> -	bootph-all;
>   };
>   
>   &sdmmc {
>   	max-frequency = <20000000>;
> -	bootph-all;
>   };
