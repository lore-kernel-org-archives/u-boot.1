Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD460C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055E08785A;
	Mon,  5 Feb 2024 10:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aTUF2rRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A9A87887; Mon,  5 Feb 2024 10:18:54 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF5987480
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so5500924a12.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707124732; x=1707729532; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsW0jfEMkpwkmNbU8Hic4KoSyinNBNNH1QRjd9f9YPE=;
 b=aTUF2rRWRlswTh6aVrhu3DWSzC8NSboQxjxbq46fr0bBGFuicK/xC8kGXMPeU7MeZJ
 jCCEWaa9AstBP7Vi/99tDwHTzA9qsPFm5NMB1TSNIp4w+Hcshxja6QHXDFRgnPJePq95
 x9VPM2Zgq57uZ9BmzLfKFsoXy5s9DoLE3S+KKL7dDZHFQC+lkF4LNxHRFdUqj++V679P
 w9N8n/FdoGzdX2SEKVnlw/VYkEJlTVxQ36hgiutU3IoUMctpFca/79EBe+QBnYq0ffb1
 cw+HkQTLhDYc9kg2Jg9jhcu8lpwB+PDs5WF2j3qSxCYDmVZwVWf2BvO5GIvhcCNeqtG5
 X1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707124732; x=1707729532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsW0jfEMkpwkmNbU8Hic4KoSyinNBNNH1QRjd9f9YPE=;
 b=PlxfQZBGf66P9j8MM8H+rPBADVPZ+zWYiq2PMvLIlpVg8ct0+qpNaPiBR04dmYEKs3
 qe/lQYr6vrvyuxtsm3KmoyHk3cPXxm8LEOAwaDSPf6StZTdQT77NtdpSwPOgrd/0P1NZ
 7TKjAAQmaxHrbq4UYUQPIZQrjpoIA4f4Vflc6eI2m9SYIzKDMOofTJQ0auUFlQ3GI94h
 NdUgVyCnQ4wDi7kt7934wxOC1imuoy5QsBCe5Zc/kapVNUOM23YCHosNauMLY/IxA0LR
 hbuDF/yqVTD8Ync6dGlE+DaejaTfgfarBrYcyllS5jl6LA/B0agPNU/VrBEXNAJiphV0
 aEUA==
X-Gm-Message-State: AOJu0YxLY625K/HAAkfQI9JpeIO7A1XxiqVIo4RyRhCfms/bRZKp4Kg0
 qU03v8hswDV5TyGc4XkbFwBt6G2+FXs+DOH/W3Z0d5Grub/SxE77LopiLK1H5kbMkQIWm2T7Cb9
 8bbZZHCtXhbp6K7eJQw2Y0XUYQXk=
X-Google-Smtp-Source: AGHT+IGttP4QG7q5eKG6vt4sDmP4CR/gROJEX6dLoGR303kOvSgYaueOQHnljRM546Fsfr9b4Il1AjYh5v0OMeWRwQQ=
X-Received: by 2002:a05:6402:516c:b0:560:4e74:20a4 with SMTP id
 d12-20020a056402516c00b005604e7420a4mr2895441ede.34.1707124731091; Mon, 05
 Feb 2024 01:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-3-jonas@kwiboo.se>
In-Reply-To: <20240204205312.2342868-3-jonas@kwiboo.se>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 5 Feb 2024 17:18:40 +0800
Message-ID: <CAHk0HouCMi3SrANKaGnD13RoHbn+8Yp+YOB-yiQ7W7A5+5rdvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Tianling Shen <cnsztl@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Feb 5, 2024 at 4:53=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Testing has shown that writing to eMMC using a slower mode then HS200
> typically generate an ERROR on first attempt on RK3588.
>
>   # Rescan using MMC legacy mode
>   =3D> mmc rescan 0
>
>   # Write a single block to sector 0x4000 fails with ERROR
>   =3D> mmc write 20000000 4000 1
>
>   # Write a single block to sector 0x4000 now works
>   =3D> mmc write 20000000 4000 1
>
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>
> Writing to eMMC using HS200 mode work more reliably than slower modes on
> RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
> prefer use of HS200 mode on RK356x and RK3588.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

> ---
> Changes in v2:
> - Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
>   instead of adding to each boards defconfig
> - R-b tags not collected because of above change
> - Combine changes for rk356x and rk3588 in one patch
> - Update commit message
>
> Link to v1: https://patchwork.ozlabs.org/patch/1891693/
> ---
>  arch/arm/mach-rockchip/Kconfig      | 4 ++++
>  configs/nanopi-r5c-rk3568_defconfig | 2 --
>  configs/nanopi-r5s-rk3568_defconfig | 2 --
>  configs/radxa-e25-rk3568_defconfig  | 2 --
>  4 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index 6ff0aa6911e2..946ef5d7023d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
>         imply OF_LIBFDT_OVERLAY
>         imply ROCKCHIP_OTP
>         imply MISC_INIT_R
> +       imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +       imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>         help
>           The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A5=
5,
>           including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
> @@ -317,6 +319,8 @@ config ROCKCHIP_RK3588
>         imply OF_LIBFDT_OVERLAY
>         imply ROCKCHIP_OTP
>         imply MISC_INIT_R
> +       imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +       imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>         imply CLK_SCMI
>         imply SCMI_FIRMWARE
>         help
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3=
568_defconfig
> index 833cff0e457d..f5a472d03d78 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> -CONFIG_MMC_HS200_SUPPORT=3Dy
> -CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3=
568_defconfig
> index 2736d382a352..99692d341f44 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> -CONFIG_MMC_HS200_SUPPORT=3Dy
> -CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk356=
8_defconfig
> index 5a613abe0d2d..fedb137877ab 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -60,8 +60,6 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> -CONFIG_MMC_HS200_SUPPORT=3Dy
> -CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> --
> 2.43.0
>
