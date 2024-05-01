Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862FBC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67D588B37;
	Wed,  1 May 2024 10:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="wfBuEldi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD78288B39; Wed,  1 May 2024 10:47:26 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D77AC88B34
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714553244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/FP9kyMynh3LuPlDUKGysrzzex1HMU1D58ATdYR7Ac=;
 b=wfBuEldiec4wI/8/2TK+wuUz6HUgHbgAsINHkR8b+IHJDXH8pzrQRGdseg2xXzoSo/DkyS
 FeJoTFs4str36fmYB3SEpHTUKkvZd2V0GhZWqTLPCElFglZNGhmV6JvdFrd9WcE96LMbLy
 Voi8sNoOTmG9lDIMKXTSAhm0SfaG9VB6T+JXB2ypE5awuuK89idH+9JHWU82JFE3UkUhpH
 Wpv/TPys6z7vubOoTpiucuo/El5T1zB9Bfu9RxPCSybvo32x/O1dkAH0tK1vUWB1KPtytt
 ZjrdT+d2MaoKIpLRwO3bMd9ryzc4FcPybFo25OleETrl25ghRtFrdIiBp2y3cg==
Date: Wed, 01 May 2024 10:47:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 09/18] rockchip: rk3399: Enable DT overlay support on
 all boards
In-Reply-To: <20240430153053.308788-10-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-10-jonas@kwiboo.se>
Message-ID: <27ee0853cd3df707a65e8c628f90380c@manjaro.org>
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
> Imply OF_LIBFDT_OVERLAY Kconfig options to add device tree overlay
> support on all RK3399 boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: Collect r-b tags
> ---
>  arch/arm/mach-rockchip/Kconfig        | 1 +
>  configs/rock-4c-plus-rk3399_defconfig | 1 -
>  configs/rock-4se-rk3399_defconfig     | 1 -
>  configs/rock-pi-4-rk3399_defconfig    | 1 -
>  configs/rock-pi-4c-rk3399_defconfig   | 1 -
>  5 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index 6f1213b1710c..bfde9bf8dd16 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -269,6 +269,7 @@ config ROCKCHIP_RK3399
>  	imply LEGACY_IMAGE_FORMAT
>  	imply MISC
>  	imply MISC_INIT_R
> +	imply OF_LIBFDT_OVERLAY
>  	imply OF_LIVE
>  	imply PARTITION_TYPE_GUID
>  	imply PHY_GIGE if GMAC_ROCKCHIP
> diff --git a/configs/rock-4c-plus-rk3399_defconfig
> b/configs/rock-4c-plus-rk3399_defconfig
> index bebea4fd0691..6c69e8bdcb92 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
> diff --git a/configs/rock-4se-rk3399_defconfig
> b/configs/rock-4se-rk3399_defconfig
> index 04622df3c0a0..e5ed81022bd6 100644
> --- a/configs/rock-4se-rk3399_defconfig
> +++ b/configs/rock-4se-rk3399_defconfig
> @@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
> diff --git a/configs/rock-pi-4-rk3399_defconfig
> b/configs/rock-pi-4-rk3399_defconfig
> index 9036c51de421..2801becedb4b 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -6,7 +6,6 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_SF_DEFAULT_SPEED=10000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_ROCKCHIP_SPI_IMAGE=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig
> b/configs/rock-pi-4c-rk3399_defconfig
> index e1adec600174..72d37bff9e9a 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
> -CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_DM_RESET=y
>  CONFIG_ROCKCHIP_RK3399=y
>  CONFIG_TARGET_ROCKPI4_RK3399=y
