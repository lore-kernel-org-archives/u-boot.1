Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C645FC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 06:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E588756C;
	Thu,  1 Feb 2024 07:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tc9yRElg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8009F87579; Thu,  1 Feb 2024 07:33:51 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854628753E
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 07:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so633169a12.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 22:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706769229; x=1707374029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDiNUQh8huzRqlNbeSGKbdE/qnZ2KfnadNje1EVhBPU=;
 b=Tc9yRElgmGmxYGMmlZ1Y+yd07LZpIxvNbsL+eiIOiiWRiYcvxZvfGNDbld9L92jjh0
 m9qZ41NeJnrE037rzs3k+WTfrIkWju/YBEiNCygmEYpXx2hZCDl2MZipPJM5KxsbKCtX
 VhZ+ue91eaVE7j3wajDfmdwC6KmYCS5H6nKIzjqrMMo9U4lkWa5xzJOBWEDRcjldv5cn
 GcgvOHWYFkL3eckEL6ueH0FJyeLki879ks4X9CjhrjzEtZbzlA6/cDDhAtsxaXYm4e5U
 9u4EnIWYki+G54xinX/ulWB29YVbJMvvx6VNsJVTASdcsItvDio6Et6pmbAkxrAa5G39
 VZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706769229; x=1707374029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDiNUQh8huzRqlNbeSGKbdE/qnZ2KfnadNje1EVhBPU=;
 b=CFAJPb5CmUj6zO5FNJAJpWiGZKkVeHPVuj13MzuiT2d3MZrAmuAlx7iidfpxq31Osh
 7MxQHQOuehasL9YtglSV4bdFgKvwR9MLfXfre4WakPFZ6U5VhcfHyAMa4C4ijxXbPQs+
 VbWVpuDTLuxFoOG5vK5Q4BCVdFARRXNo99Rfk6t2lXmx20v0tcoJTRhAODblxv+O0wpk
 tq8upmfARgEOdarJ2zeYFOKS1tLWADGPxuBsVdqA8ZwAVakvF/2XY10531xJqQ265x0i
 tZHUiapqkP6tJc20zpWrLXWRSxrIWu7mPRbi88ldEJgp0erAYT1EajhuXPsyvD5S+bgT
 l9aQ==
X-Gm-Message-State: AOJu0YymcqM7jCGL7ZBygneytIinCgfRNnvNUqhlwxHE0IrRFcv75UZZ
 NCbZdTMMg5MaYxuWpI0sTsEquuBEuj6pvFrfO8Gicjp5oKyIaj36MGR4rViK5EdkIFDeO3XT1+P
 hHDDl+wqMVwonWED/jTjBG5EsJjQ=
X-Google-Smtp-Source: AGHT+IEwX+yzGtO8gw4sr1ajh34x4zQz3S873WQ9cE0goOst9WZxJqxmDWxD8PB+WmE6ICs8IKAw2WFmPV+BRv5VcsQ=
X-Received: by 2002:a05:6402:150f:b0:55f:c78a:765e with SMTP id
 f15-20020a056402150f00b0055fc78a765emr53298edw.5.1706769228278; Wed, 31 Jan
 2024 22:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-3-jonas@kwiboo.se>
In-Reply-To: <20240126232615.6826-3-jonas@kwiboo.se>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 1 Feb 2024 14:33:36 +0800
Message-ID: <CAHk0HouFqN527cv6TnxXOP9wGVezz8yXK_xoahAV+rprhpfikg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rockchip: rk356x: Enable eMMC HS200 mode
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Chris Morgan <macromorgan@hotmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
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

On Sat, Jan 27, 2024 at 10:32=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Writing to eMMC using HS200 mode work more reliably then other modes on
> RK356x boards.
>
> Enable MMC_HS200_SUPPORT Kconfig option to prefer use of HS200 mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

> ---
>  configs/anbernic-rgxx3-rk3566_defconfig   | 2 ++
>  configs/bpi-r2-pro-rk3568_defconfig       | 2 ++
>  configs/evb-rk3568_defconfig              | 2 ++
>  configs/lubancat-2-rk3568_defconfig       | 2 ++
>  configs/odroid-m1-rk3568_defconfig        | 2 ++
>  configs/quartz64-a-rk3566_defconfig       | 2 ++
>  configs/quartz64-b-rk3566_defconfig       | 2 ++
>  configs/radxa-cm3-io-rk3566_defconfig     | 2 ++
>  configs/rock-3a-rk3568_defconfig          | 2 ++
>  configs/soquartz-blade-rk3566_defconfig   | 2 ++
>  configs/soquartz-cm4-rk3566_defconfig     | 2 ++
>  configs/soquartz-model-a-rk3566_defconfig | 2 ++
>  12 files changed, 24 insertions(+)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-r=
gxx3-rk3566_defconfig
> index ed6643d9d4fa..295c0bd3fc61 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -61,6 +61,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3=
568_defconfig
> index e6e0e6fc6fa6..c9e1cd2c2c85 100644
> --- a/configs/bpi-r2-pro-rk3568_defconfig
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -60,6 +60,8 @@ CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
> index cb9b87ff12cb..19eab9bf00ac 100644
> --- a/configs/evb-rk3568_defconfig
> +++ b/configs/evb-rk3568_defconfig
> @@ -54,6 +54,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3=
568_defconfig
> index 80ae6ec3a2e9..c06a447fda26 100644
> --- a/configs/lubancat-2-rk3568_defconfig
> +++ b/configs/lubancat-2-rk3568_defconfig
> @@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk356=
8_defconfig
> index 3130e341e776..7fed6e7da597 100644
> --- a/configs/odroid-m1-rk3568_defconfig
> +++ b/configs/odroid-m1-rk3568_defconfig
> @@ -72,6 +72,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3=
566_defconfig
> index ade08867f60f..fd6b0e528834 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -71,6 +71,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3=
566_defconfig
> index 8d01db54407d..ec7a677fd3d3 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -69,6 +69,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io=
-rk3566_defconfig
> index 4b606dcb8e94..10626acfdea2 100644
> --- a/configs/radxa-cm3-io-rk3566_defconfig
> +++ b/configs/radxa-cm3-io-rk3566_defconfig
> @@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_de=
fconfig
> index 18372a570eb7..2b944163f5a9 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -68,6 +68,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-b=
lade-rk3566_defconfig
> index 9693cc2f9eb9..af04dccf4923 100644
> --- a/configs/soquartz-blade-rk3566_defconfig
> +++ b/configs/soquartz-blade-rk3566_defconfig
> @@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4=
-rk3566_defconfig
> index 9c6b12d23028..e669ca14c1cc 100644
> --- a/configs/soquartz-cm4-rk3566_defconfig
> +++ b/configs/soquartz-cm4-rk3566_defconfig
> @@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz=
-model-a-rk3566_defconfig
> index fd72d78a47a8..3beeab1dbba8 100644
> --- a/configs/soquartz-model-a-rk3566_defconfig
> +++ b/configs/soquartz-model-a-rk3566_defconfig
> @@ -63,6 +63,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> --
> 2.43.0
>
