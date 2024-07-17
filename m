Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B96C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9E688602;
	Wed, 17 Jul 2024 07:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SQXr2QNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9454A88636; Wed, 17 Jul 2024 07:04:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 656E4885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 150BD61455
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 05:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF5C32782
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 05:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721192679;
 bh=MKsBPjDI7xSpEx1KKcdDxC01zlxyL4UwmSbTNgapZH0=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=SQXr2QNc5IFCjXNpQUAGD4wiYt7BJ6ADWGIlQYdLC6J7a8DlF8ZWr3ruhaO5ZarBK
 Szqv247zxd83pgJo0xgWaIc4kNIV4K+cYms0rkqvmfPqK0YSIddXUK+vzqTAPA2+1A
 yStDfZMFmGIDisnShlDwTUCzOzJr2sPBWo7wzBDQsqWByAbEXSv9idJo0/8Dxl8LJn
 vtbYXpH/6Wm9z5QjXjfm4V7ekGgFOC6VGMy+vQp8cL2j1sJpqNlBIf5JJM/3Ud5Giu
 PQO04SwwpaYiyfHXH4eNVx7syEXTo4Yz1K8hLiVH0jOkgcxlFOpgtVp+sUhLwgtYXV
 L2BNIPUKiHnJA==
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2ee9b098bd5so86644251fa.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:04:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGBWWU4nd/HbXOWHj1FX3O6B1iUSCy8TIlgGPO541N54Cw7oYS
 NXIOrEevU0AIB9oQXJ3esBRc0E5/t7HlJy6wY+ObtsFbB7d5UnsLeHqBHb+sTi31a0lnGC+nouP
 lqNIoQLFF88CPYVv8hj+ToEAy9N8=
X-Google-Smtp-Source: AGHT+IEoPcSCx2K+7/cpzwa1Zwu4wNId9O4DwgxD8D4ZKv+mAKXp896g/2QKtw5/HgBgALey52r0qM/LCbjoibcEabA=
X-Received: by 2002:a05:651c:118b:b0:2eb:2e0b:72c with SMTP id
 38308e7fff4ca-2eefd09a8e2mr4214411fa.16.1721192677932; Tue, 16 Jul 2024
 22:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240717044726.59721-1-naoki@radxa.com>
 <20240717044726.59721-3-naoki@radxa.com>
In-Reply-To: <20240717044726.59721-3-naoki@radxa.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 17 Jul 2024 13:04:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v65EzxHoP5YucT_RqVhgp==8NO6u0YPMrDXC=WVSvW9T0w@mail.gmail.com>
Message-ID: <CAGb2v65EzxHoP5YucT_RqVhgp==8NO6u0YPMrDXC=WVSvW9T0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] configs: rockchip: imply OF_LIBFDT_OVERLAY for
 rk3308 and rk3328
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, andy.yan@rock-chips.com, gajjar04akash@gmail.com, 
 jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Jul 17, 2024 at 12:47=E2=80=AFPM FUKAUMI Naoki <naoki@radxa.com> wr=
ote:
>
> for rk3308, all defconfigs have CONFIG_OF_LIBFDT_OVERLAY=3Dy, so enable i=
t
> by default.
>
> for rk3328, any defconfig doesn't have it. but there is no strong reason
> not to enable it. at least it's required for ROCK Pi E.

I wonder if it makes sense to eventually move it up to ARCH_ROCKCHIP?

ChenYu

> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v3:
> - add missing separator in commit message
> Changes in v2:
> - none
> ---
>  arch/arm/mach-rockchip/Kconfig     | 2 ++
>  configs/evb-rk3308_defconfig       | 1 -
>  configs/roc-cc-rk3308_defconfig    | 1 -
>  configs/rock-pi-s-rk3308_defconfig | 1 -
>  4 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index 661e7fd1c9..5f6a4dd24a 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -166,6 +166,7 @@ config ROCKCHIP_RK3308
>         imply LEGACY_IMAGE_FORMAT
>         imply MISC
>         imply MISC_INIT_R
> +       imply OF_LIBFDT_OVERLAY
>         imply OF_UPSTREAM
>         imply RNG_ROCKCHIP
>         imply ROCKCHIP_COMMON_BOARD
> @@ -196,6 +197,7 @@ config ROCKCHIP_RK3328
>         imply ARMV8_SET_SMPEN
>         imply MISC
>         imply MISC_INIT_R
> +       imply OF_LIBFDT_OVERLAY
>         imply OF_LIVE
>         imply OF_UPSTREAM
>         imply PRE_CONSOLE_BUFFER
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index f4c2ea12ad..6d090dba30 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D24000000
>  CONFIG_ARCH_ROCKCHIP=3Dy
>  CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3308-evb"
> -CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3308=3Dy
>  CONFIG_TARGET_EVB_RK3308=3Dy
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defc=
onfig
> index 862ea4301f..b1b59d9cb5 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -4,7 +4,6 @@ CONFIG_COUNTER_FREQUENCY=3D24000000
>  CONFIG_ARCH_ROCKCHIP=3Dy
>  CONFIG_SPL_GPIO=3Dy
>  CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3308-roc-cc"
> -CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3308=3Dy
>  CONFIG_TARGET_ROC_RK3308_CC=3Dy
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk330=
8_defconfig
> index c15ba3d8a4..e450a06180 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -3,7 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D24000000
>  CONFIG_ARCH_ROCKCHIP=3Dy
>  CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3308-rock-pi-s"
> -CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_DM_RESET=3Dy
>  CONFIG_ROCKCHIP_RK3308=3Dy
>  CONFIG_TARGET_EVB_RK3308=3Dy
> --
> 2.43.0
>
