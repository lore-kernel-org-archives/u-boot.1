Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1320C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 22:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 198FA607F5;
	Wed,  5 Aug 2026 22:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcH6UX11f9xC; Wed,  5 Aug 2026 22:49:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C69160671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785970192;
	bh=EiOEC4SMBcAnlE953sGkhIyeu8B3D92MK+501C/1NE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KijKzWivOWo3OQ5s44LUUTsJW0ycjatKyPepsVJdnJqSCHkMeh2L6Qmcplayf3//E
	 gwhcfsElPo2OunonaMjWUTrICpKNw4hh/VDTIbUb2myys6orb+tJ6PEEAdjlWBZuH8
	 kFggEuZUtPWtqCL7JFtiwqLl6PBvT+wicy3kfmFZ2aEXnATsTGHpYZuaGWtX+5hA7Q
	 j3xS+6mm5UFmYzD6npB6Hwmw6xrWX/tiFPbcG4eLJAl4iZRsdHQ8Kyd0g10y4FvCZ7
	 bZDiVT6xEelLF6c1aoEwtiRvlDlYgYqpVR0RNsbguNVCdQ5Jue40dNs3tSyJp10rl/
	 IyhtHwFyifJPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C69160671;
	Wed,  5 Aug 2026 22:49:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46CCD3FA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38FF060671
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GNfir4r9T0Oq for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 22:49:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 78A0F6062D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78A0F6062D
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78A0F6062D
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 22:49:50 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso983690a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 15:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785970190; cv=none;
 d=google.com; s=arc-20260327;
 b=Ezv5JFbXAMMZIKrSPOyMbDoSbck2VnrAxIhkLF5DRJtedG3ZmGYwQVTQESOcet9n0K
 xN6tv0J3xA/6eBYBr2aRW8JBh6l/488xmlr3/eV9IWqUsjrr5aQw7WWDL242aP0vEcx2
 zxSbp6mMPZVotmxqqurEaPgAtKD5JJIyWR25bXMB03T2sxhb0Y2TQyl/hiO0GcCaF9Mh
 HwzcPYIWWhnf1q10Xsr2ppbFnPtorYURbzhHD8+LeucoF4WuL4qzxqeYEHzhOEYCaglC
 HcXLDZjntzKUGqSt+g0gTF9C9gyIS82kS6+OHss8cnU9K+QdxanqLrKb5uPfQQ8ALQEM
 pXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EiOEC4SMBcAnlE953sGkhIyeu8B3D92MK+501C/1NE0=;
 fh=Fxk8l4C8GhNxwIBDb5FQUkubZA95iCBOXA7zFlxTwBs=;
 b=qIwH+W/z6Vj8Gl/lK0owG1V1BVS+/sbhlHfewcqwY0cvDgiKASh6Frj5wdnM5Brq74
 RKbKyHUwbWbCaXK/zTrVuzh+Y3NmScYAbVpWreb5jWiFFzQ8e27AmLvsCEYNNIJKmv4n
 yA4kMGxStW4pKpKBQgj9D8U812vx5ffBseV0z1bgbFPOE43ejb/NHH/+x3EDfrepZARd
 S8Gdee2HS321AMCb54Fd1BfqVjthkvbjOjGyCLQhQ9wbxUH2Ad/u3VOUOp/2qG8KmaJM
 7myE397VjMfJq42ObUvjwYpDtguzPspeyluh3bR/tRYBElKdkipSFlLJUhjiLsGbueFJ
 VXRw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785970190; x=1786574990;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EiOEC4SMBcAnlE953sGkhIyeu8B3D92MK+501C/1NE0=;
 b=ndboW/lKPPph1tUFAdMzXnijMQ65OB6Pev4M54ipfqEn8SuMR+lFpx+pw2uTRhyRJa
 KTraIEmfHABcdeOGRO/ghoYgRvRXV7o3Du0YItlLxsLr9GNcwxJfrTRW4GaRD6dW2MTb
 d1OLe1lCKCiSwQXhO6mkdwA9C5dj0XwamtK67f9c9LDEkfENQX1QzIjnLsXFwESofuM0
 JDFiifr5D+x+zxx142Lis1wEPnsAakYBfghzNY60B8uthIhqd6KBJ6df3AtR7Df35D1p
 ZtSQZ79i4AU2SvA9ypSrjdg4V9xgCERnS0QLiIRbjCUWlIjC3++FL0lk5pk2IpwPXCn6
 bing==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1gWpPz6wUIrDxo7ucOtQxMwzWBrJzhZMUk85wpd49tPqh6pqgM84SKxdRAiMuDdF+tUPfOgs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzokZE64QtNXmi82nVgI8T2e76l8bHqd5P5SIrtddGxgLMuxttu
 jUY8hRB6j3qjL5fGXcrqDhUG61WOTw4b/3R8HrCYSH/RMsWjoNaYoPAjLjV9vmypxjsRh9aNtOA
 E7L+y5sxGMPUz2ywxoHzqoXdHDldqzQ==
X-Gm-Gg: AR+sD12dmO2mmeMAF593hMeNYMiGpP1TNkKzNZVHmW78U17Ea5h8UKMtIiJ/cQh9s3P
 Xo7LhNRneGPlVALijlZg3iNNuCcH28ym6ygbLoFYKp8/2QRfxP3aqlQ1axhOuS/005EUM0sFDdG
 Bga2N1I3AgWghXj1mY8QjD/RTSAjXR3974re9duo4yR7bUWF0wRUPgbPgzjrDW/6Cjz+nOUAb7K
 2SSlm5GCr2srEswrpBwhJkUGPGw85K4sMt9hEUuNBO/WAVUagOyf97mzpJ868wKQPc0Ilxn1sjf
 n2+2B/+l0y21KweEk8OYpqZRtqaD26zM+JgE+6TFAQ5Jb85PP7yY1mN9UPs/Lx3Y3/XzOnyDkJ2
 g
X-Received: by 2002:a05:6a20:6a06:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3cb85df274emr10541307637.14.1785970189565; Wed, 05 Aug 2026
 15:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260804104332.2585195-1-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260804104332.2585195-1-u.kleine-koenig@baylibre.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Wed, 5 Aug 2026 18:48:56 -0400
X-Gm-Features: AUfX_mzNW01stNTESKB1ftdXfyLXNSaoyjpjcVtyQ7c6OqaCvgDhx0ImprzLYD8
Message-ID: <CABdDSeV3tiEeVE=_YNn33JN1KDU51h-q8TBOv-Y31T1yF26EkA@mail.gmail.com>
Subject: Re: [PATCH] arm: sc5xx: Enable BOOTSTD_DEFAULTS
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>, 
 Ozan Durgut <ozndrgt@gmail.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 linux@analog.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785970190; x=1786574990;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EiOEC4SMBcAnlE953sGkhIyeu8B3D92MK+501C/1NE0=;
 b=mOXJN3Zgej/yQ714IPDmLOdT83KBCl7dkn96l/4gk+Gl4photBQP/DXJ48pU4VCsDs
 ZrlU+C2SIIachm3pIm6/Mlxv/AiTZARwtp18TpkK77CE113+t9kFj+kXfVCsTIuYocFK
 MnxoHbBDrtOv0pSGWYJtbGPAo0XVCcMg2vSGNpOD0iS7AQBV4qBSUzQv3sz8oUCOEqcv
 9YnC9bTGSh4phsRMyKU41FrQdFZOv1C/IvzlrsAXb5/EO5wPrfBsf9nyYeIafFmVaFQh
 kgKMDkxbwj3C+NfKWkUGrv/Oy0Fghs/y2d6idsMbbo7uvZuFqCEQ0CW7CVDhUqW0/DPl
 wJDw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mOXJN3Zg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Uwe,

On Tue, Aug 4, 2026 at 6:43=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> This setting implies various config knobs that are "commonly needed to
> support a good selection of booting methods." Among them is
> CONFIG_SUPPORT_RAW_INITRD which is convenient for booting a Debian
> installer. Enable it for the (non-SPL) sc5xx defconfigs.
>
> The removed lines are only about settings that are (transitively)
> selected by CONFIG_BOOTSTD_DEFAULTS and thus are not needed any more to
> be listed explicitly. CONFIG_ISO_PARTITION is now listed explicitly
> because it defaults to y in the presence of BOOT_DEFAULTS (which is
> selected by BOOTSTD_DEFAULTS).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  configs/sc573-ezkit_defconfig | 11 ++---------
>  configs/sc584-ezkit_defconfig | 11 ++---------
>  configs/sc589-ezkit_defconfig | 11 ++---------
>  configs/sc589-mini_defconfig  | 11 ++---------
>  4 files changed, 8 insertions(+), 36 deletions(-)
>
> diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfi=
g
> index fc4ce13cc709..086009a23e15 100644
> --- a/configs/sc573-ezkit_defconfig
> +++ b/configs/sc573-ezkit_defconfig
> @@ -18,13 +18,12 @@ CONFIG_CGU0_CLKOUTSEL=3D7
>  # CONFIG_EFI_LOADER is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> -CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run ramboot"
>  CONFIG_SYS_CBSIZE=3D512
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_I2C=3Dy
> -CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -39,16 +38,11 @@ CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_SPI=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> -CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_DNS=3Dy
> -CONFIG_CMD_MII=3Dy
>  # CONFIG_CMD_MDIO is not set
> -CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_WGET=3Dy
> -CONFIG_CMD_EXT4=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> +# CONFIG_ISO_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_OF_EMBED=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> @@ -87,6 +81,5 @@ CONFIG_USB=3Dy
>  CONFIG_USB_MUSB_HOST=3Dy
>  CONFIG_USB_MUSB_SC5XX=3Dy
>  CONFIG_USB_MUSB_PIO_ONLY=3Dy
> -CONFIG_USB_STORAGE=3Dy
>  CONFIG_FAT_WRITE=3Dy
>  # CONFIG_REGEX is not set
> diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfi=
g
> index a8c6b9f1224b..161c9ecda038 100644
> --- a/configs/sc584-ezkit_defconfig
> +++ b/configs/sc584-ezkit_defconfig
> @@ -23,14 +23,13 @@ CONFIG_CGU0_CLKOUTSEL=3D7
>  # CONFIG_EFI_LOADER is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> -CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run ramboot"
>  CONFIG_SYS_CBSIZE=3D512
>  CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_I2C=3Dy
> -CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -44,16 +43,11 @@ CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_SPI=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> -CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_DNS=3Dy
> -CONFIG_CMD_MII=3Dy
>  # CONFIG_CMD_MDIO is not set
> -CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_WGET=3Dy
> -CONFIG_CMD_EXT4=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> +# CONFIG_ISO_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_OF_EMBED=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> @@ -91,7 +85,6 @@ CONFIG_USB=3Dy
>  CONFIG_USB_MUSB_HOST=3Dy
>  CONFIG_USB_MUSB_SC5XX=3Dy
>  CONFIG_USB_MUSB_PIO_ONLY=3Dy
> -CONFIG_USB_STORAGE=3Dy
>  CONFIG_FAT_WRITE=3Dy
>  # CONFIG_REGEX is not set
>  # CONFIG_SPL_CRC8 is not set
> diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfi=
g
> index 9cd204e40abb..5b56a0bef9be 100644
> --- a/configs/sc589-ezkit_defconfig
> +++ b/configs/sc589-ezkit_defconfig
> @@ -26,14 +26,13 @@ CONFIG_CGU0_CLKOUTSEL=3D7
>  # CONFIG_EFI_LOADER is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> -CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run ramboot"
>  CONFIG_SYS_CBSIZE=3D512
>  CONFIG_CYCLIC_MAX_CPU_TIME_US=3D1000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_I2C=3Dy
> -CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -48,16 +47,11 @@ CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_SPI=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> -CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_DNS=3Dy
> -CONFIG_CMD_MII=3Dy
>  # CONFIG_CMD_MDIO is not set
> -CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_WGET=3Dy
> -CONFIG_CMD_EXT4=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> +# CONFIG_ISO_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_OF_EMBED=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> @@ -97,7 +91,6 @@ CONFIG_USB=3Dy
>  CONFIG_USB_MUSB_HOST=3Dy
>  CONFIG_USB_MUSB_SC5XX=3Dy
>  CONFIG_USB_MUSB_PIO_ONLY=3Dy
> -CONFIG_USB_STORAGE=3Dy
>  CONFIG_FAT_WRITE=3Dy
>  # CONFIG_REGEX is not set
>  # CONFIG_SPL_CRC8 is not set
> diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
> index 0908ab1708b3..6c6dc805e606 100644
> --- a/configs/sc589-mini_defconfig
> +++ b/configs/sc589-mini_defconfig
> @@ -24,13 +24,12 @@ CONFIG_ADI_USE_DMC1=3Dy
>  # CONFIG_EFI_LOADER is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_SIGNATURE=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> -CONFIG_USE_BOOTCOMMAND=3Dy
>  CONFIG_BOOTCOMMAND=3D"run ramboot"
>  CONFIG_SYS_CBSIZE=3D512
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_I2C=3Dy
> -CONFIG_CMD_BOOTZ=3Dy
>  # CONFIG_BOOTM_PLAN9 is not set
>  # CONFIG_BOOTM_RTEMS is not set
>  # CONFIG_BOOTM_VXWORKS is not set
> @@ -45,16 +44,11 @@ CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_SPI=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_SYS_DISABLE_AUTOLOAD=3Dy
> -CONFIG_CMD_DHCP=3Dy
>  CONFIG_CMD_DNS=3Dy
> -CONFIG_CMD_MII=3Dy
>  # CONFIG_CMD_MDIO is not set
> -CONFIG_CMD_PING=3Dy
>  CONFIG_CMD_WGET=3Dy
> -CONFIG_CMD_EXT4=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> +# CONFIG_ISO_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_OF_EMBED=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> @@ -94,6 +88,5 @@ CONFIG_USB=3Dy
>  CONFIG_USB_MUSB_HOST=3Dy
>  CONFIG_USB_MUSB_SC5XX=3Dy
>  CONFIG_USB_MUSB_PIO_ONLY=3Dy
> -CONFIG_USB_STORAGE=3Dy
>  CONFIG_FAT_WRITE=3Dy
>  # CONFIG_REGEX is not set
>
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> --
> 2.55.0.11.g153666a7d9bb
>

This patch does not apply to uboot/main or uboot/next, please rebase
it and resubmit. Note that the sc573-ezkit has been renamed to the
sc573-ezlite since the base commit referenced here, and another series
has modified things like the default bootcmd.

I have additional questions however:
1) This enables things like CONFIG_HUSH_PARSER, CONFIG_BOOTP_PXE, and
others as well which increase the size of uboot on an already tightly
packed spi flash. Are these needed or intentional? Why not enable
CONFIG_SUPPORT_RAW_INITRD individually?
2) How do you intend to use a debian image on these boards? The kernel
does not currently have mainline support or drivers, and the SPI flash
memory is likely too small for a debian image, as it required
extensive tweaking in yocto to build root filesystems that would fit.
Is it going to use exclusively NFS as the root filesystem?
3) Why not make the same change to the sc594/sc598 boards as well?

Thanks,
Greg
