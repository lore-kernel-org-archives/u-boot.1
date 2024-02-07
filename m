Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A811C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 03:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587B487CB5;
	Wed,  7 Feb 2024 04:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="LF34hnGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB26387C93; Wed,  7 Feb 2024 04:01:23 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B39879F2
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 04:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707274881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDNuHKZ/FudwgfCEz2POAQAidKWHBi5FeGLkj4tkxUc=;
 b=LF34hnGYjzsLd9FWxpAZfz78E3SEU7W1m2HElql7N43KolVNiz94Aa8p1BMIHVy2AevOqx
 7zS6e69/TG9vykWj99O8bGwaDgDhBtyoEyB7nF3W9qEk+pskliQVpteQ4s1jxPoaDTwvn0
 qvuXH/CqFabNhJhcZtHIZi0MGUQSYq1G9jOQhldXPgd89i+rQlYZIC5CVEIjKiqwVAdP1u
 OJnw5BrWFajxG+1cUHihpUo0gHcOevlCVxDFrx1BmDTVDKAxDWenaZtXXrvHzNCQndDgZK
 ZpC4tnL/u4xnSU/bGL9IFesu3bcG0DvHECeANfm5Ig2FKXF9O5sQFABWuy6sxQ==
Date: Wed, 07 Feb 2024 04:01:20 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 03/15] rockchip: rk3328-rock64: Update defconfig
In-Reply-To: <20240207000301.3270722-4-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-4-jonas@kwiboo.se>
Message-ID: <decd70703b98c1fc6ce8f2679fbd22c6@manjaro.org>
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
> Update defconfig for rk3328-rock64 with new defaults.
> 
> Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.
> 
> Add CONFIG_SPL_FIT_SIGNATURE=y to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=y to keep
> support for scripts.
> 
> Remove the NET_RANDOM_ETHADDR=y option, ethaddr and eth1addr is set
> based on cpuid read from eFUSE.
> 
> Add SPL_DM_SEQ_ALIAS=y option to use alias sequence number in SPL.
> 
> Add DM_ETH_PHY=y and PHY_REALTEK=y to support onboard ethernet PHY.
> 
> Also add missing device tree file to MAINTAINERS and add myself as a
> reviewer for this board.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  board/rockchip/evb_rk3328/MAINTAINERS | 2 ++
>  configs/rock64-rk3328_defconfig       | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS
> b/board/rockchip/evb_rk3328/MAINTAINERS
> index dc750bd69426..419bc8ded375 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -47,8 +47,10 @@ F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> 
>  ROCK64-RK3328
>  M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
> +R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/rock64-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-rock64.dts
>  F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
> 
>  ROCKPIE-RK3328
> diff --git a/configs/rock64-rk3328_defconfig 
> b/configs/rock64-rk3328_defconfig
> index 0297d098761e..0157a1efe374 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=y
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
>  CONFIG_TPL_LIBCOMMON_SUPPORT=y
>  CONFIG_TPL_LIBGENERIC_SUPPORT=y
> -CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_SPL_STACK_R_ADDR=0x600000
>  CONFIG_SPL_STACK=0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=0x800
> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=y
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
>  CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -57,8 +58,8 @@ CONFIG_TPL_OF_PLATDATA=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SYS_MMC_ENV_DEV=1
> -CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_TPL_DM=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_REGMAP=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_TPL_REGMAP=y
> @@ -76,6 +77,8 @@ CONFIG_ROCKCHIP_EFUSE=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_ETH_PHY=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
