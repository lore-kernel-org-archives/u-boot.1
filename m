Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D481FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 06:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481E5801FE;
	Wed, 11 Dec 2024 07:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Zzl5kII+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A3180210; Wed, 11 Dec 2024 07:44:23 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11198801FD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1733899460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5ea265qCEKuavgkDPiikpdfi7GJdOUgtzKF2STyHq8=;
 b=Zzl5kII+n9wGAhhzXi5/RCrUJHSjX8imYvCzrQMw1pSfKYPxJWyn8jmZsPl2U/E1nr8WxI
 CgsVkskSOu3kfWKRAbPQ/DNKQdV9wDjfYexrCK/tIoeeQrvefobOTditMvvsrhd5ECZtib
 3jHYdKcjfN+5NDe3l+8BLgWTPTrLLnrXH2nSrbTSPUzv4rSQI0nN0EhsUF3fNWn8NFdQx8
 4sgufSaPfv0qD7S2ym+AeRXV8+17f2I4/Gsbz6bwVTEKQL4FhfsosRD4eMNLTQnIxG1FvW
 vn9IL4WWqo6ujXnr9kk86o4t/Sev2Zj63FxGFMbJwx6AFX+kUINWaEZkPq+VYw==
Date: Wed, 11 Dec 2024 07:44:19 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se
Subject: Re: [PATCH] rockchip: Add support for Radxa ROCK 5C Lite
In-Reply-To: <20241211063729.57963-1-naoki@radxa.com>
References: <20241211063729.57963-1-naoki@radxa.com>
Message-ID: <8c7491dbb855173b370eb64c88453c38@manjaro.org>
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

On 2024-12-11 07:37, FUKAUMI Naoki wrote:
> Radxa ROCK 5C Lite[1] is a RK3582 based single board computer.
> 
> [1] https://radxa.com/products/rock5/5c
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>

Please, see my related comment on the linux-rockchip mailing
list, linked below:

https://lore.kernel.org/linux-rockchip/c6ba70f1681bb635190e9452ecb22d59@manjaro.org/

Comments are more than welcome, of course.

> ---
> this patch depends on follwing patches:
> - 
> https://patchwork.ozlabs.org/project/uboot/patch/20241210222341.3537543-2-jonas@kwiboo.se/
> - 
> https://patchwork.ozlabs.org/project/uboot/patch/20241211033934.23044-6-naoki@radxa.com/
> ---
>  arch/arm/mach-rockchip/rk3588/Kconfig | 5 +++--
>  configs/rock-5-rk3588s_defconfig      | 1 +
>  doc/board/rockchip/rockchip.rst       | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig
> b/arch/arm/mach-rockchip/rk3588/Kconfig
> index e1487ecb0464..733ea35839a5 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -261,10 +261,11 @@ config TARGET_ROCK_5_ITX_RK3588
>  	  Powered by either 12V, ATX power-supply or PoE
> 
>  config TARGET_ROCK_5_RK3588S
> -	bool "Radxa ROCK 5C RK3588S2 board"
> +	bool "Radxa ROCK 5C/5C Lite RK3588S2/RK3582 board"
>  	select BOARD_LATE_INIT
>  	help
> -	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +	  Radxa ROCK 5C/5C Lite are Rockchip RK3588S2/RK3582 based
> +	  single board computer.
> 
>  config TARGET_SIGE7_RK3588
>  	bool "ArmSoM Sige7 RK3588 board"
> diff --git a/configs/rock-5-rk3588s_defconfig 
> b/configs/rock-5-rk3588s_defconfig
> index 54043264de48..a0137520803f 100644
> --- a/configs/rock-5-rk3588s_defconfig
> +++ b/configs/rock-5-rk3588s_defconfig
> @@ -18,6 +18,7 @@ CONFIG_FIT_VERBOSE=y
>  CONFIG_SPL_FIT_SIGNATURE=y
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_SYSTEM_SETUP=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> diff --git a/doc/board/rockchip/rockchip.rst 
> b/doc/board/rockchip/rockchip.rst
> index 6b952654cb3d..4516260976ee 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -141,7 +141,7 @@ List of mainline supported Rockchip boards:
>       - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>       - Radxa ROCK 5A (rock5a-rk3588s)
>       - Radxa ROCK 5B (rock5b-rk3588)
> -     - Radxa ROCK 5C (rock-5-rk3588s)
> +     - Radxa ROCK 5C/5C Lite (rock-5-rk3588s)
>       - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>       - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
>       - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
