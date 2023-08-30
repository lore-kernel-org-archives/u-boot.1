Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5034C83F14
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63D18652B;
	Wed, 30 Aug 2023 23:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zs5cw2ic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124D58652E; Wed, 30 Aug 2023 23:39:23 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C881803AB
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d7485d37283so17520276.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693431559; x=1694036359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W2+3G3a5LhXGAofljQmFR4xGIBh5CVk/BX4N7VhK/7M=;
 b=Zs5cw2ic6aKvNJoDy+FhBZbQbSrpG0nIbNM6PXDhzJEwUu7h0Zhc1usOzz+HwgvJKQ
 6OIgjiLA+XTxyJRHF8gh4e9ZQJ+rVS8w0Q5c5R4uuj3spxdJhPSd7BKvBxBC9GLusiNW
 /fNG+Qf72a2Z6HX0Alp9kG2aGyUyyo3U/fB28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693431559; x=1694036359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2+3G3a5LhXGAofljQmFR4xGIBh5CVk/BX4N7VhK/7M=;
 b=PGY33YImbbUP1PA+185vJDYFKyItgMhHf/bspHBxHM2ZIhXUFzQYp2wAXCK/XH3Yi6
 j1MtFJndJQ9GepXS6feTwcYXyqrVqsnFW6zu7ZYjPoK/MqVH86hMwiYlb59xParx1HWG
 KKrsM5wkMWxvJBtzGjOybQ2KKSB7cymHV68ugXCPzgCc1DkXKN2xNImObOKQVAyYrCNW
 HFhNLaAdwAztIlWr04rXrXZYP2dGGbeT3hSjqfWReMy0JhcakA83I1sg2KpnkJV9k9VC
 1qFxCpbxXRTTG5WRLTV2p9eEmm1Ufieh+wRFpOyWySmiNpxGn8Cz4W+fXFXreGCvf8wC
 Fs6w==
X-Gm-Message-State: AOJu0YyJm7ZDi+1z/HFk9bb9PQE/eD8EasPyd1Ri24SX6b+9bt5CDrVr
 WJEvur9FAuKGaWq7bLzG13PJMw==
X-Google-Smtp-Source: AGHT+IEQmgvDl10CY4RV6sW/DQ+ALiOKRocEFrmoN+G00P2iehZZzfFB8U87pN/IvEMK4/pzC047Pw==
X-Received: by 2002:a25:9192:0:b0:d7b:6e31:dbef with SMTP id
 w18-20020a259192000000b00d7b6e31dbefmr3361245ybl.6.1693431559052; 
 Wed, 30 Aug 2023 14:39:19 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a25ad8f000000b00d6a4bae16bbsm9044ybi.49.2023.08.30.14.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:39:18 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:39:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
Message-ID: <20230830213916.GL3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UEQdj/uoPohcV9Pe"
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-10-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--UEQdj/uoPohcV9Pe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> Use an accessor in the header file to avoid this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/spl.c                  | 9 +++++----
>  include/asm-generic/global_data.h | 7 +++++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index f0a90c280da..f5cef81000c 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>  	} else {
>  		debug("Unsupported OS image.. Jumping nevertheless..\n");
>  	}
> -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
> -	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
> -	      gd->malloc_ptr / 1024);
> -#endif
> +	if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> +	    !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> +		debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> +		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
> +
>  	bootstage_mark_name(get_bootstage_id(false), "end phase");
>  #ifdef CONFIG_BOOTSTAGE_STASH
>  	ret =3D bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/glob=
al_data.h
> index 8fc205ded1a..edf9ff6823f 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) =3D=3D GD_S=
IZE);
>  #define gd_malloc_start()	0
>  #define gd_set_malloc_start(val)
>  #endif
> +
> +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> +#define gd_malloc_ptr()		gd->malloc_ptr
> +#else
> +#define gd_malloc_ptr()		0L
> +#endif
> +
>  /**
>   * enum gd_flags - global data flags
>   *

This is another case where readability is not improved. I also have a
bad feeling that changing that exact area had some unintended
consequences from the compiler, that totally should not have happened.
But maybe that was something in a similar code section instead.

--=20
Tom

--UEQdj/uoPohcV9Pe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvtwQACgkQFHw5/5Y0
tyw8/AwAqVvR56V0chv0fjfmSGkMBINNncUsCRdWSlRnYTSGjZ8gwgW0v7GdB2QG
uz2HMn0TXYgKEX3AV6WTbgMvAhDkrF6TpT4m8umYipfKf1kaOuk030iHtGaxMxYG
WD9JcO9zGWLoO7WYtw2/5LZQn+18gIXZTaTp4asxuFqpUtT7equkw1bUZ765uaLg
QuB0eClzEq0e1WenO8GfofEqUxbwbCaIEz/I7XJThRRPEmK6vY0bSP5QZro0JkeY
iotasbe3vC6/GMzhINL0veQ3IQB76dRaXEZ6SYiYeFM6aynFFrW6JaKyOnyYOmsr
qC4fz2dd5xqTi7GVaspgTSlaVY0QWVBxLIokCGPiLZePtc3C8j/BSM5IWHyb+y8h
qBoyXAE4tNgRNGB6AYOYLqgTIm0/S9JMgpeQZam2XpedzjJVXb3Sm0p1VMH5iCwS
EER8oGqeVcygtpYhQAoGHOI5bvC/pGpS3yKFsK2AQyDsAcF6P5Jg83weOAbWEMkO
c0F1mdAx
=c8uC
-----END PGP SIGNATURE-----

--UEQdj/uoPohcV9Pe--
