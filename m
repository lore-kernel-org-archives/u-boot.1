Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61169C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E0C820F6;
	Tue,  6 May 2025 14:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InCmOanh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90538210D; Tue,  6 May 2025 14:03:13 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C6F80C83
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 14:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso8475138a12.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746532990; x=1747137790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLJ4nl1xi4btl9kSJuheYf6h+CUoZYeBX4u6OGNxOVM=;
 b=InCmOanhavxyXQvQb1U1u1RQpyGkB39Oc1eJu9oOQLA0NuS6LSuJhighFbeGrM8EXS
 DdFFkJlEldk1rklunqvEXmAnqZ9uszgdLW3FolkmytQWzw1cElsc/qZpTqmtAlbTT3yD
 RpbXwAUNocpLeDkSPZ2lRHfPhJI3LSqmGkA3nspDlYPEFD7uYKPwRwUIJMKNGq1xBiDp
 8RC8ftQU7Cz0AY68JQs5XYX/5f6rZ6JjYZn2+PRzpNjfoGKTLpEl1gMZx7oJJFwxKqJC
 KNYHL6k+eSMuIRW+dMZBbW0CT6Li2jp7Nbo2dM7Rf6ewKJ+J9Ls50H+XxDbRxC8ugKeV
 Y1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746532990; x=1747137790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLJ4nl1xi4btl9kSJuheYf6h+CUoZYeBX4u6OGNxOVM=;
 b=Vd/aTyzQWDe8m1Fz4HNBWB9NkPvtKlzG6VuB0ohiPDadM4fVumvbpTWZOz3Kmzqa4t
 m22WkUZ3dz2Oh+3yOC0EVa4SL1trX2nu32DfNXRZkggN9IBsjSqkITOsOxTcih3Uu64i
 WM9St5gT7dBftjemsfkWqT/qm9wrDvLMS7DjEW3aAdcWLZrkM0J9sPOfzYkl2CRHxz7q
 b8HvEKkoWSB1bGIbWpANhkXWk0sxLzAgpNMfgFqjhsduOsnJv/vpp+dum81tNt0K9ubF
 Bupahb5RCTtsXqOxXdnTQLU1ckObjL4hcrHyRfichoTZoc8G24OIXFfP8SHgK8UtrYb6
 TMcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkociI8Z/qN62x6qck1kD+5VfwJtBVvwt1NEgDZiFbm8i1qsi88eMLKcBjLTAJ/TepDtV6Wu0=@lists.denx.de
X-Gm-Message-State: AOJu0YwZoubSoCYMal/m/Ts9TDjjehJ4DfCyemnEyjPP4DBuIuFtxe0e
 183kQmiT5cWSHGmk2d1jvNdd47bhAQLj/QnoOLb/ClfwwR1DsuOn7tJgQgB+WbZ7TB4/RX+tGiw
 wnAz3Dy06jc3UT02YbtnIOFbfcA0=
X-Gm-Gg: ASbGnctnv/umLJMQNrded8XYzU8ozu5IDdfljvM/P1FAoDHihbpSAwqzPmbZPhLCWkE
 Hq3VJj02PrlbjR3+7QNRYJ0fFXEhu50bI3R9zwE5G3r4ePvmDmVRVSW3hKrH9WDRgOR4QKyqtex
 ilF+614EDF5llEqghel7BEY1NsX6IWkX9vmJDoLnOGAvwtUzuwm6uT1CM=
X-Google-Smtp-Source: AGHT+IEHX0t4eSFXB354NAiuxIOrxr1yG3s7EDLjJ2o9rXtq004YDk7LHssr8be5+eZvcuxUAKBYtISdjufO95lKXh8=
X-Received: by 2002:a05:6402:3485:b0:5f7:eaf0:8849 with SMTP id
 4fb4d7f45d1cf-5fb700a1305mr2372454a12.16.1746532989723; Tue, 06 May 2025
 05:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de>
 <20250505-has_rom-u-boot-rockchip-spi-bin-v3-1-75f23b3bd8d3@cherry.de>
In-Reply-To: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-1-75f23b3bd8d3@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 6 May 2025 13:02:58 +0100
X-Gm-Features: ATxdqUHftfM9meGjkwwKLVHzjzxw45fmrjvHJJ38BrLTdHqSstpzT29U5yOTJIk
Message-ID: <CALeDE9NZD8r2hNmhJzgmB8wwMhq17KwvJy1Y9rrdo08gdttd9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rockchip: rk3399: do not generate u-boot.rom
 anymore
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 5 May 2025 at 15:47, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This was only used on RK3399 Gru Chromebooks and their maintainer
> (Simon) agreed[1] to its removal on the basis that the generic
> u-boot-rockchip-spi.bin is now enough, so let's do that.
>
> At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
> since they were used only for that.
>
> Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
> Chromebooks as that seems to be important.
>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/dts/rk3399-gru-u-boot.dtsi   |  4 +++-
>  arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>  arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>  3 files changed, 3 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> index 5517176aa4a0bcc11aa292e76be7c4d894a034f7..dfc7be4c621e712cc665e889b9c54d192924827a 100644
> --- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
> @@ -15,11 +15,13 @@
>         };
>  };
>
> +#if defined(CONFIG_ROCKCHIP_SPI_IMAGE)
>  &binman {
> -       rom {
> +       simple-bin-spi {
>                 size = <0x800000>;
>         };
>  };
> +#endif
>
>  &cros_ec {
>         ec-interrupt = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 70f35b6c197a8bedf2fc09ec66d2aac8e615aa75..587eef9504eccc7a1ea365b5f8aed24756692dcb 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -29,41 +29,6 @@
>         };
>  };
>
> -#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> -&binman {
> -       multiple-images;
> -       rom {
> -               filename = "u-boot.rom";
> -               size = <0x400000>;
> -               pad-byte = <0xff>;
> -
> -               mkimage {
> -                       args = "-n rk3399 -T rkspi";
> -                       multiple-data-files;
> -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> -                       rockchip-tpl {
> -                       };
> -#elif defined(CONFIG_TPL)
> -                       u-boot-tpl {
> -                       };
> -#endif
> -                       u-boot-spl {
> -                       };
> -               };
> -               fit {
> -                       type = "blob";
> -                       filename = "u-boot.itb";
> -                       offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> -               };
> -               u-boot {
> -                       offset = <0x300000>;
> -               };
> -               fdtmap {
> -               };
> -       };
> -};
> -#endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */
> -
>  &cru {
>         bootph-all;
>  };
> diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
> index b2430207ee9d0130b5a0c303a41a7375c7db26fa..5c21b08a5ae226ad545f8492f21ac16fb2fda98d 100644
> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
> @@ -5,7 +5,6 @@ choice
>
>  config TARGET_CHROMEBOOK_BOB
>         bool "Asus Flip C101PA Chromebook (RK3399)"
> -       select HAS_ROM
>         select ROCKCHIP_SPI_IMAGE
>         help
>           Bob is a small RK3299-based device similar in apperance to Minnie.
> @@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_BOB
>
>  config TARGET_CHROMEBOOK_KEVIN
>         bool "Samsung Chromebook Plus (RK3399)"
> -       select HAS_ROM
>         select ROCKCHIP_SPI_IMAGE
>         help
>           Kevin is a RK3399-based convertible chromebook. It has two USB 3.0
>
> --
> 2.49.0
>
