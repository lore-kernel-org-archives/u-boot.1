Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC060C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 18:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AD6810EA;
	Fri, 28 Mar 2025 19:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LYRDjYUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65713810F4; Fri, 28 Mar 2025 19:35:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB07F80F0E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 19:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72be=WQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743186935;
 bh=Unv1E/Rqg4qxrUcPBo+3uH6YXBeAwiVjj6oeksfagTw=;
 b=LYRDjYUAe4kKKrQYSqGToCPIXF5rkmjJGW6Y1DD3xWNd+7fByKhABiuJXHvTzMDqTfcXglQeV
 t3jqXijNWFW4733fs7KrkIaWEt64eg3evqnnGu+6Aekg+aZhhX0HwVmzphhqWS1lHajaa030C+G
 yHuoagYyjsTmvgzDXeEM1Lmd+wS0fQ1m4Cyhx0LNbdyuf/ZfAEr6IPEdBVbdVgsEMCzIcS0OJrh
 n9Q7qgXIevNVivIOK2zr2ob39WZO5MzBVVNdhS4zfynduGT0tBPQaOMHtgyU31oHScviwsVXDAP
 aTZhKRIpJto30WyRA9NWsoFMhuUd1ejg34QPa6UMJ5sA==
X-Forward-Email-ID: 67e6ebf399a280edf51ecee9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7fe942a6-ea52-4705-a837-25be56db7724@kwiboo.se>
Date: Fri, 28 Mar 2025 19:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 huang lin <hl@rock-chips.com>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250328153522.3555472-20-sjg@chromium.org>
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

Hi Simon,

On 2025-03-28 16:34, Simon Glass wrote:
> Add support for this new phase, which runs after TPL. It determines the
> state of the machine, then selects which SPL image to use. SDRAM init is
> then done in SPL, so that it is updatable.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> - Skip spl-boot-order.c for VPL (rather than modifying it)

[snip]

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 4c515593718..58ba0e0468f 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -252,13 +252,15 @@ config ROCKCHIP_RK3399
>  	select SPL_ATF
>  	select SPL_BOARD_INIT if SPL
>  	select SPL_LOAD_FIT
> -	select SPL_CLK if SPL
> +	select SPL_CLK if SPL && !VPL
>  	select SPL_PINCTRL if SPL
>  	select SPL_RAM if SPL
>  	select SPL_REGMAP if SPL
>  	select SPL_SYSCON if SPL
>  	select TPL_HAVE_INIT_STACK if TPL
> -	select SPL_SEPARATE_BSS
> +	select VPL_HAVE_INIT_STACK if VPL
> +	select SPL_SEPARATE_BSS if !VPL

SPL_SEPARATE_BSS is already implied by ARM64, so we could probably just
drop the select SPL_SEPARATE_BSS here.

> +	select SPL_RAW_IMAGE_SUPPORT if VPL

We have this disabled in all RK3399 defconfigs so this can probably be
dropped. We really do not want this accidentally enabled for !VPL.

>  	select CLK
>  	select FIT
>  	select PINCTRL
> @@ -268,6 +270,7 @@ config ROCKCHIP_RK3399
>  	select DM_PMIC
>  	select DM_REGULATOR_FIXED
>  	select BOARD_LATE_INIT
> +	select SUPPORT_VPL

Probably better to keep this next to the other SUPPORT_xPL.

>  	imply ARMV8_CRYPTO
>  	imply ARMV8_SET_SMPEN
>  	imply BOOTSTD_FULL
> @@ -296,13 +299,14 @@ config ROCKCHIP_RK3399
>  	imply TPL_LIBCOMMON_SUPPORT
>  	imply TPL_LIBGENERIC_SUPPORT
>  	imply TPL_OF_CONTROL
> -	imply TPL_RAM
> +	imply TPL_RAM if !VPL
>  	imply TPL_REGMAP
>  	imply TPL_ROCKCHIP_COMMON_BOARD
>  	imply TPL_SERIAL
>  	imply TPL_SYS_MALLOC_SIMPLE
>  	imply TPL_SYSCON
>  	imply TPL_TINY_MEMSET
> +	imply TPL_DM_MMC if VPL

Please try to keep the imply statements in alphabetical order after the
commit d8ff591d9263 ("rockchip: rk3399: Sort imply statements
alphabetically").

Regards,
Jonas

>  	help
>  	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
>  	  and quad-core Cortex-A53.

[snip]
