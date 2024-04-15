Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19573C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935CC88159;
	Mon, 15 Apr 2024 08:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Sp7rOGeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305B488188; Mon, 15 Apr 2024 08:43:44 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5299C8811D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713163421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rilRUbRXYP7vi4oirza8QN/mSMTxznwtw2RrRyFDEc=;
 b=Sp7rOGeDXxkH9dNpHXfo74X22rIrzCcZyEOQeRojBDjTjTR/y6PaSVui/0mv5Igfe4Ad1B
 eyvYdIjszFmEA1LiPu8mJwxKNbpUsaOS80HuRGlYc3knJ/FY/60hFI7I3w2gioVFRJqv9n
 3mLTEIA1Xgn5M/+RX1LP330meAbm7AlbMakZM0KFJ0yQf859da5AbY73W9ShV2SGSwHFYm
 dZGbg5W+gWtqhvGxxfGqYXpp1Pfp1mNRRerB3pjCh/Nm9GuhZen0y1JVZzyWef74NUMRsh
 WBCOTuHgrjhfpzLrD1oX9g3U3ltyuRMN5F3r8/M7Tp3vZkGUYRRfZvLMGK+O4g==
Date: Mon, 15 Apr 2024 08:43:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Frank Wunderlich <frank-w@public-files.de>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 09/23] rockchip: rk356x: Imply enhanced features for
 standard boot
In-Reply-To: <20240413181425.1384357-10-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-10-jonas@kwiboo.se>
Message-ID: <3d3b038c26c851dccdeef3f67733f392@manjaro.org>
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

On 2024-04-13 20:13, Jonas Karlman wrote:
> Imply BOOTSTD_FULL for all RK356x boards to more closely follow RK3588.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2: No change
> ---
>  arch/arm/mach-rockchip/Kconfig      | 1 +
>  configs/bpi-r2-pro-rk3568_defconfig | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig 
> b/arch/arm/mach-rockchip/Kconfig
> index 88bab9c7b3bf..22eccaaf5cb1 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -305,6 +305,7 @@ config ROCKCHIP_RK3568
>  	select BOARD_LATE_INIT
>  	select DM_REGULATOR_FIXED
>  	select DM_RESET
> +	imply BOOTSTD_FULL
>  	imply DM_RNG
>  	imply MISC_INIT_R
>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig
> b/configs/bpi-r2-pro-rk3568_defconfig
> index 5cc95241ba43..70837574462b 100644
> --- a/configs/bpi-r2-pro-rk3568_defconfig
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -15,7 +15,6 @@ CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_SPL_FIT_SIGNATURE=y
>  CONFIG_SPL_LOAD_FIT=y
> -CONFIG_BOOTSTD_FULL=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
