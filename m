Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03305C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 06:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD8387BDA;
	Thu,  1 Feb 2024 07:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjIG1PIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB5087BDC; Thu,  1 Feb 2024 07:34:39 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B848753E
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 07:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55cca88b6a5so642744a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706769276; x=1707374076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Wfs+FwwmJFPxLUfCGMSVdoIE8e+utEl78k66LWxyd0=;
 b=DjIG1PIJfGBpVXOoxNJar4EtSsdd4NkMvWNnn+01vodu57gfHvDZw4fIrXnHuxdJ3w
 94Xhl+eNcAzT0Mcbv7HcDtogbLSdhOsPzII2YqOzXLS2BaRJVDshSRPe/fEkevsbjw1c
 V2geh9uNoimOV4TfeqexsNftYRX6Z4HoGHp5vuNlRbr0Kf+C/Kg4a+bwfrbd0PLLo4yM
 2RmRILc61DQU9xpO5lzra56n8ou3zfyFKlyu32Gsgh9a8OOK7cAPQ9K3wXeZ5N+7m8C5
 mXsCq00wh/il4h+XgPJQiDxTcQagydhGuqlv1Wx2D3cPygLlkSFrg8G3vnt0hZ+hOx7C
 K/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706769276; x=1707374076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Wfs+FwwmJFPxLUfCGMSVdoIE8e+utEl78k66LWxyd0=;
 b=N4xPxQSqqzT8LKVq+oSXW2l4f0FaclF6GM1WGJTt9aQqBn7ETPHwyOQjTkoos9yfts
 7x3DRKVDRAMJazkVVQs7LVHuBNv8CEqu7X5WehVbw7M9CxRFMNhNffKQCyxwIBzIjXl1
 YY3Dj84LJCpYfaiRTz7j4fR4i1KUlWyfa+rpMaiJAEbZ0KHDDeIBkpMzBIeAxv7iy6EX
 /9MSuQfKvcN5UCoDzCB8UgkQQ8Gzto4GA5QYtyYHx1VahVPbtodsMZXW9g878cq7Tuvi
 xDCMou/OEjG9deq3jVnNfn/E0vKlrq+zUy0Nq8GKA9bVVs2BXo8OyHSRSspP91G5ThdZ
 qUEQ==
X-Gm-Message-State: AOJu0Yyf0SsdauZWscHpB8jya0yETO7DIo6HXVDnwseueA8jZ/hrgOeA
 NuHfNy/rQ1Nmk07nBXZVVN5HyY+RZkm6W7ywNzL89RpIzAZ5SKYGVnjokzG931sbM4axsz57tFY
 jJXbdIKi/nAnlAZDpY7WBrY98N2c=
X-Google-Smtp-Source: AGHT+IGBc07yuk4g8cYtadleoSn4xQ03Lfr+0FqagqK70GoAteZdsCZzh6RH6SvpjL0EX0LEQ+pRf7fvlGpn3TrsIqg=
X-Received: by 2002:aa7:c988:0:b0:55f:3d22:b307 with SMTP id
 c8-20020aa7c988000000b0055f3d22b307mr2162984edt.41.1706769276319; Wed, 31 Jan
 2024 22:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-4-jonas@kwiboo.se>
In-Reply-To: <20240126232615.6826-4-jonas@kwiboo.se>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 1 Feb 2024 14:34:25 +0800
Message-ID: <CAHk0Hotm8x7-E+fTfeExD8o60zaH-Zik_igbgfSJ_17DuCZkiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rockchip: rk3588: Enable eMMC HS200 mode
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 John Clark <inindev@gmail.com>, Jagan Teki <jagan@edgeble.ai>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Joshua Riek <jjriek@verizon.net>, u-boot@lists.denx.de
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

On Sat, Jan 27, 2024 at 7:27=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Writing to eMMC using HS200 mode work more reliably then other modes on
> RK3588 boards.
>
> Enable MMC_HS200_SUPPORT Kconfig option to prefer use of HS200 mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

BR,
Weizhao

> ---
>  configs/evb-rk3588_defconfig             | 2 ++
>  configs/nanopc-t6-rk3588_defconfig       | 2 ++
>  configs/neu6a-io-rk3588_defconfig        | 2 ++
>  configs/neu6b-io-rk3588_defconfig        | 2 ++
>  configs/orangepi-5-plus-rk3588_defconfig | 2 ++
>  configs/quartzpro64-rk3588_defconfig     | 2 ++
>  configs/rock5a-rk3588s_defconfig         | 2 ++
>  configs/rock5b-rk3588_defconfig          | 2 ++
>  configs/turing-rk1-rk3588_defconfig      | 2 ++
>  9 files changed, 18 insertions(+)
>
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index 0b7b4f2f627a..2dfdc71259f7 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -53,6 +53,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk358=
8_defconfig
> index 760993220929..26dcf3aae21c 100644
> --- a/configs/nanopc-t6-rk3588_defconfig
> +++ b/configs/nanopc-t6-rk3588_defconfig
> @@ -66,6 +66,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_=
defconfig
> index d5301c630b2a..a6549420c01e 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -48,6 +48,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_=
defconfig
> index b13c9b5db1b0..b5739de147d8 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -48,6 +48,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-=
5-plus-rk3588_defconfig
> index a58f96d57798..e5325158d2af 100644
> --- a/configs/orangepi-5-plus-rk3588_defconfig
> +++ b/configs/orangepi-5-plus-rk3588_defconfig
> @@ -69,6 +69,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-r=
k3588_defconfig
> index 85af4c4ff955..fd8304debdbb 100644
> --- a/configs/quartzpro64-rk3588_defconfig
> +++ b/configs/quartzpro64-rk3588_defconfig
> @@ -53,6 +53,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_de=
fconfig
> index efa7bcbdcda6..10d6f6580490 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -56,6 +56,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defc=
onfig
> index a0678ff1290c..76f57340df5a 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -71,6 +71,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_SUPPORT_EMMC_RPMB=3Dy
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS200_SUPPORT=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3=
588_defconfig
> index 289f2da775c5..0d6c34d468e3 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -75,6 +75,8 @@ CONFIG_ROCKCHIP_GPIO=3Dy
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
