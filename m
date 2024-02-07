Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ECDC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 07:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA60387C7D;
	Wed,  7 Feb 2024 08:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/xwPGLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3436487CB5; Wed,  7 Feb 2024 08:53:36 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D5A87BC1
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 08:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68ca3ab3358so2092846d6.2
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707292413; x=1707897213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb9FK2ZwM/XspaQ2/FWvhSP+2Gj1oLg7Y85cC0ZhhZs=;
 b=L/xwPGLCgk5W/wy3ieNvEWuXorkBrLyCBA/h0II+/JmMdmp6OPyqEXoOkkNaMJMNK+
 Wkhk+huGyrB/cO3J0B570do9hgq+5VmpI4XsOdESrkXhWrrsffDze5RTyh9SxAvPGEq8
 +ZFkV5SkybW2LMqm16TmyhyDJmkoz7WX6gt0BmCV+D0q4sJT3+5sG/HCZ/ryANWciiJa
 IAPYEoG4sj3D7wIQp2eatahGaqM5yarEPsXaRF/0b1NFWNrZaxJjnxNkPQvPvq2RPVId
 vXNBKQKemaaivuoTcVZnNL57vvV+q9sV7I3cquEwx5T6V8TyusThokxuhxbJUhN6J2Jc
 dwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707292413; x=1707897213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nb9FK2ZwM/XspaQ2/FWvhSP+2Gj1oLg7Y85cC0ZhhZs=;
 b=tNZVO5KRZKuDh6vsQsDhW1dq1LoL5mQLhnByPt4ZPBGuUSrebXERlOXqRlerg3WB8E
 PgaChsNfVx9Q6hmQX92SjuddZ/AnNYgYZJfXHLOheXt7HudmpzIgeQt2wdazVKWS9AZM
 Ped0FaABm0ydHoF2OLUesZqHKlC+d2KdFcr5MTqODxRdKpE1aOtsXuHv0tXR1JzuqeCG
 l67SokRquBG5f6J9kyL8n3DKJLA6BFtDSd2vQHFVVXD7OpTVE77T/bKrpLn6PNqJK7gf
 gmaZZ7codFHwf6+jBLYSnPm4hlYPAEe8wVEokGAZbGkWFx7ifxmnOf0XF+1tjkD6ZYtc
 9EKw==
X-Gm-Message-State: AOJu0YxIDqzKgI3nIZYhwhJnxsX3eaXDKZ3fa+K6nzBrvnmlOP/Ns6p/
 Y5pqVqLCFsFcfmytQ4Jgl/5+MZ2pmz3iNCESTTl1OC2jYSckx0qvYtGGT3fMI5nGeyc6UVBYPNK
 howyZy9sFjlJk7r6pedMg9yiYVNg=
X-Google-Smtp-Source: AGHT+IEHIWyij++U1Cw5FYJXVZ/+eVVBqCgiyet6fB8qlAQr+eEDl6keKoHE2pObtzuMEeEQxOeUu7a+zOuUyOXSfO0=
X-Received: by 2002:a0c:b712:0:b0:68c:92f0:2d53 with SMTP id
 t18-20020a0cb712000000b0068c92f02d53mr4175424qvd.41.1707292412611; Tue, 06
 Feb 2024 23:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-4-jonas@kwiboo.se>
In-Reply-To: <20240207000301.3270722-4-jonas@kwiboo.se>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 7 Feb 2024 10:53:21 +0300
Message-ID: <CAJs94Eat5OcLjTuyAMLkBRWJwBEQ0+vJnnqLT7+krGd1zPrV-A@mail.gmail.com>
Subject: Re: [PATCH 03/15] rockchip: rk3328-rock64: Update defconfig
To: jonas@kwiboo.se
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

=D1=81=D1=80, 7 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 03:14=
, Jonas Karlman <jonas@kwiboo.se>:
>
> Update defconfig for rk3328-rock64 with new defaults.
>
> Remove the SPL_DRIVERS_MISC=3Dy option, no misc driver is used in SPL.

What is abould rockchip-efuse?

>
> Add CONFIG_SPL_FIT_SIGNATURE=3Dy to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=3Dy to keep
> support for scripts.
>
> Remove the NET_RANDOM_ETHADDR=3Dy option, ethaddr and eth1addr is set
> based on cpuid read from eFUSE.
>
> Add SPL_DM_SEQ_ALIAS=3Dy option to use alias sequence number in SPL.
>
> Add DM_ETH_PHY=3Dy and PHY_REALTEK=3Dy to support onboard ethernet PHY.
>
> Also add missing device tree file to MAINTAINERS and add myself as a
> reviewer for this board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  board/rockchip/evb_rk3328/MAINTAINERS | 2 ++
>  configs/rock64-rk3328_defconfig       | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_r=
k3328/MAINTAINERS
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
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defc=
onfig
> index 0297d098761e..0157a1efe374 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
> -CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
>  CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-rock64.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -57,8 +58,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -76,6 +77,8 @@ CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> --
> 2.43.0
>


--=20
With best regards,
Matwey V. Kornilov
