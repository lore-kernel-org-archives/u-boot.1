Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E73CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D8C88B19;
	Wed,  1 May 2024 10:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="N2RZ6Tat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3780788B22; Wed,  1 May 2024 10:41:16 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8C988AB8
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714552873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HoZL37rAzLp1fXO/N0Fvwp6vxcj+H3Z3q3lhuQrHtM=;
 b=N2RZ6Tatchqzm4imcPbiaq/4hAxG8uwO83n/JtYNjCZIDrOGDMNpXD/jKMHXCWFd4VXP0H
 KyFy5GGGvOycUmJd/1dArwYhA31P2l7VC1jFpNeE73jTQ3T0lG7C8y5bFqFgf84tfhAtom
 hbQefx3FgIFsJRQdJsJEjnI97KziiuVV2wG62NfgGmOs6vfk2WORgNk0UwCkH+LO/FHjc8
 i9zT50UDL/8nJrf2G7Uq3OJTfVl6c3vIp7JPFtij8f71jIbsp8rywgRLbOimWQfjC1z6Lc
 YxoBFiRhLNhQ7zosNNkad+763PsrLyN6t8ikCb9aHov4+ARA1L6PNj42u1hbbg==
Date: Wed, 01 May 2024 10:41:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 05/18] rockchip: rk3399: Sort imply statements
 alphabetically
In-Reply-To: <20240430153053.308788-6-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-6-jonas@kwiboo.se>
Message-ID: <b67c1864582502acd2794e4f36e44840@manjaro.org>
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
> Sort imply statements under ROCKCHIP_RK3399 alphabetically.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Collet r-b tags
> ---
>  arch/arm/mach-rockchip/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index 67d3b28d058f..20f1b7572a31 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -261,30 +261,30 @@ config ROCKCHIP_RK3399
>  	select DM_PMIC
>  	select DM_REGULATOR_FIXED
>  	select BOARD_LATE_INIT
> +	imply BOOTSTD_FULL
> +	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +	imply MISC
> +	imply MISC_INIT_R
>  	imply PARTITION_TYPE_GUID
>  	imply PRE_CONSOLE_BUFFER
>  	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_EFUSE
>  	imply ROCKCHIP_SDRAM_COMMON
>  	imply SPL_ROCKCHIP_COMMON_BOARD
> -	imply TPL_SERIAL
> +	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
> +	imply TPL_CLK
> +	imply TPL_DM
> +	imply TPL_DRIVERS_MISC
>  	imply TPL_LIBCOMMON_SUPPORT
>  	imply TPL_LIBGENERIC_SUPPORT
> -	imply TPL_SYS_MALLOC_SIMPLE
> -	imply TPL_DRIVERS_MISC
>  	imply TPL_OF_CONTROL
> -	imply TPL_DM
> +	imply TPL_RAM
>  	imply TPL_REGMAP
> +	imply TPL_ROCKCHIP_COMMON_BOARD
> +	imply TPL_SERIAL
> +	imply TPL_SYS_MALLOC_SIMPLE
>  	imply TPL_SYSCON
> -	imply TPL_RAM
> -	imply TPL_CLK
>  	imply TPL_TINY_MEMSET
> -	imply TPL_ROCKCHIP_COMMON_BOARD
> -	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
> -	imply BOOTSTD_FULL
> -	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> -	imply MISC
> -	imply ROCKCHIP_EFUSE
> -	imply MISC_INIT_R
>  	help
>  	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
>  	  and quad-core Cortex-A53.
