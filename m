Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C140C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FE688581;
	Mon, 10 Jun 2024 19:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ARVIIKY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA3C88581; Mon, 10 Jun 2024 19:12:58 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274AB8865F
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d229181325so698201b6e.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718039575; x=1718644375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CQECgUOtieRaES3f9RnoNnw3uWFANbV1dUfvEW3MOhY=;
 b=ARVIIKY2IQm9wSP7libSB9iFpc5mAwOB3jzxPk7/hPSuOPhoGw+73FTYWbyg/FRXYg
 6AZctCW+olihgb6IqOBk/lQLLKzBklLfMi5+XNz7H02xbYQ0kgm1OFB3svmIhAx34WRv
 6dGX6XrwQ2TW2Mei7ZeIu26IednDeTUVdW8l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718039575; x=1718644375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQECgUOtieRaES3f9RnoNnw3uWFANbV1dUfvEW3MOhY=;
 b=LVff/5fTaxa22cFevEqIumQ9gN1MY0n4+4uCUMAWfcv2lIP0oPjUhMcbVlZukmQtQF
 7Sjpf8wZx4u6tAtbVxcuq1D2Yhqhpzsb7iL4+NOdHR4uziQD9PVf47Sg94gYOK/iVcyL
 KoNU9wBqsdTujord+CiU6qS7L5vGfTXLsdYkH9qtX4O2KVjYleTRWqdUWuSmjpixm46n
 FoGbvit1g6iPZ7XmiK3a2Sl/xSr1QJEiCJBtRPK/jlzZMsw8gUjLR4g6TDSKcsHlg7Sd
 6brUeX46IdvCTnMJf4GLwM89O1BKdxjkrzc93vAEP1XoTHO7JVnPpWM17e6qporZfygF
 Y7LQ==
X-Gm-Message-State: AOJu0YyrAEISkRTreioxUMRsTojWAW8IBNdRl3RVHvylErdJoYs6EpKW
 aacoLdDJwZogOZO88lrGWFc0WxvBQTnYoE5ZKyNgWOoGhrfwd2OSPuMaXDHwhbs=
X-Google-Smtp-Source: AGHT+IHZ/UOqodDbAPU4jaxnzCgFVErdMcG3zPTXwD7k0v19pKSI9orFnzXFFK2ViUcqThojhad+9Q==
X-Received: by 2002:a54:4e97:0:b0:3d1:fda9:3b05 with SMTP id
 5614622812f47-3d210d2b9b7mr8841028b6e.12.1718039574750; 
 Mon, 10 Jun 2024 10:12:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d21db2cea2sm873341b6e.36.2024.06.10.10.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 10:12:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:12:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 05/31] lmb: pass a flag to image_setup_libfdt() for
 lmb reservations
Message-ID: <20240610171252.GT68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-6-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eWUBkOAyG8BMUZpz"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-6-sughosh.ganu@linaro.org>
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


--eWUBkOAyG8BMUZpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:14AM +0530, Sughosh Ganu wrote:

> The image_setup_libfdt() function optionally calls the LMB API to
> reserve the region of memory occupied by the FDT blob. This was
> earlier determined through the presence of the pointer to the lmb
> structure, which is no longer present. Pass a flag to the
> image_setup_libfdt() function to indicate if the region occupied by
> the FDT blob is to be marked as reserved by the LMB module.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
[snip]
> ---
>  arch/mips/lib/bootm.c         | 2 +-
>  boot/image-board.c            | 2 +-
>  boot/image-fdt.c              | 7 +++----
>  cmd/elf.c                     | 2 +-
>  include/image.h               | 5 ++---
>  lib/efi_loader/efi_dt_fixup.c | 2 +-
>  lib/efi_loader/efi_helper.c   | 2 +-
>  7 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
> index 54d89e9cca..e4fc2e589d 100644
> --- a/arch/mips/lib/bootm.c
> +++ b/arch/mips/lib/bootm.c
> @@ -247,7 +247,7 @@ static int boot_setup_fdt(struct bootm_headers *image=
s)
>  	images->initrd_start =3D virt_to_phys((void *)images->initrd_start);
>  	images->initrd_end =3D virt_to_phys((void *)images->initrd_end);
> =20
> -	return image_setup_libfdt(images, images->ft_addr, &images->lmb);
> +	return image_setup_libfdt(images, images->ft_addr, 0);
>  }
> =20
>  static void boot_prep_linux(struct bootm_headers *images)
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 89ccf80066..481b333b4c 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -897,7 +897,7 @@ int image_setup_linux(struct bootm_headers *images)
>  	}
> =20
>  	if (CONFIG_IS_ENABLED(OF_LIBFDT) && of_size) {
> -		ret =3D image_setup_libfdt(images, *of_flat_tree, lmb);
> +		ret =3D image_setup_libfdt(images, *of_flat_tree, 1);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 08afde203c..4daced9e99 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -567,8 +567,7 @@ __weak int arch_fixup_fdt(void *blob)
>  	return 0;
>  }
> =20
> -int image_setup_libfdt(struct bootm_headers *images, void *blob,
> -		       struct lmb *lmb)
> +int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lm=
b)
>  {
>  	ulong *initrd_start =3D &images->initrd_start;
>  	ulong *initrd_end =3D &images->initrd_end;

Since this is a bool, please use true/false in the callers.

--=20
Tom

--eWUBkOAyG8BMUZpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnNBAACgkQFHw5/5Y0
tyzX2gwAiM+yXRbELQ9zlv/KDosC1uFiC/362oBGNjwUKgLlg7/wR+qPuCccSnh6
YEU0maofQVequ9Ce5pKpVqCw49oMgU89wtJbzmawTEi+7DHStVaBEmS5JPkLFhUw
XpQAWsdf5HUHM9WoGHKss7Vb7Z5joMnTf6fvrjp52D3P9QemjYJgsrTA3NG7GIps
pRiklmiX+QXOCTHT2r/zIqyJIX5pfEad00Q/oE/N/StjqUmv58TaI+cW4Y2Z1HeM
86KzU7YIEmS0pYdTxj9EivTD+AYQ9b9K0lTKYJOQptCC7yRdEOpdBo5J781LDlfr
FdaviHG6845/IE7Gj0uKf6N8HQfGR3pMYiKzmfTVzTipcQMwvOdvtDbdpYyColMU
SiR8FfEOnvtHzlu/8OligowfISJPtKX64wx49DmDK4pjfsu/qvk39tX6Rg2DT7t7
eIZeX89r2Suq3MufHHCE9w9AHwuXHI5/UUoy8K9kJrnDQxEK+qCdzzhF2MtRcoWk
UTBrd4cY
=dCjx
-----END PGP SIGNATURE-----

--eWUBkOAyG8BMUZpz--
