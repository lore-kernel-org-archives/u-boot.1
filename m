Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15AECCFA17
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2AF88CBF;
	Thu, 26 Sep 2024 06:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jBJYE0U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1859D88CC2; Thu, 26 Sep 2024 06:07:21 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD47F88CBF
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so53384885a.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 21:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727323634; x=1727928434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qoDLLe297f3zBOW6+mKAajQE29HYLk7oj4yp3kO/UkQ=;
 b=jBJYE0U0jS6OpI3iimMcOhFxe5UNTaEek8z2oXCACqyXIBMLBx9ts0KOJYUnHfGT2P
 xp/EC3bEujWN7Yl9+Jv8b7wh0x5Nh4ldVCHD4MgmU7rd056pWz+gZKYpvy4uX8okMz3u
 4Whkocnf8B9w9KPwExt6dVLay4NHv2ktblcjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727323634; x=1727928434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoDLLe297f3zBOW6+mKAajQE29HYLk7oj4yp3kO/UkQ=;
 b=IltcN5poAN27XX2ciBsJK5RgDuh99lqzgaQJ/80tiBoM5Ph+pl6a7rnrXLUAOQJZmQ
 QXszxPgfj5ofv0BRQCmf8+gbcJlTeoolpDmptFXww+fLN3Mwem+8LWLT2hhBLJJkopCn
 YgayjGec1EC07Nw8r0orJI7RKMdW9C3kHGWyrKAHT4SH83v0R7bc3BLefS+kl7MSayZI
 jKcCbEB3VmgifgU3TN7a/RnqROcGuWOGjr9/NWAXCOuLgPD8WFOa1cQJO2HZLg6WGW+V
 ZXO0Qzlh9Jv0Wjo7kjVNnM5umvrRpy530zZLIuFDiKDnxey+qW/6fIEaBwYXR4zmSII1
 D6XQ==
X-Gm-Message-State: AOJu0YyikHLEcNUOXTk0BdSr9T7JCgvydeLjh1j6etw1A/NXSxs5ZsNq
 rYfPvU5WvthmERepzdD6wVA28a+A95dNnHzuW0tJrHgFBxgyZhLJLY5jjWg6i1s=
X-Google-Smtp-Source: AGHT+IGy1yixEqmMNTYc2KzDbCAf5PROhdoV08e5ZQEWbWprza2Z2cWjEegBYlfZLNc2Zy0Z2PvHug==
X-Received: by 2002:a05:620a:1aa8:b0:7ac:9b5e:baf3 with SMTP id
 af79cd13be357-7ace740284emr900626885a.26.1727323634593; 
 Wed, 25 Sep 2024 21:07:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5cc309sm238071985a.84.2024.09.25.21.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:07:13 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:07:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 11/19] spl: Support jumping to VPL from TPL
Message-ID: <20240926040710.GI4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OU9KGPesV8Ynv/Lo"
Content-Disposition: inline
In-Reply-To: <20240925125622.197915-12-sjg@chromium.org>
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


--OU9KGPesV8Ynv/Lo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:55:37PM +0200, Simon Glass wrote:
> Use spl_get_image_pos() to obtain the image position to jump to. Add
> the symbols used for VPL so that the correct image can be loaded.
>=20
> Use the functions provided for accessing these symbols and add a few
> comments too.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/spl.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index d01e9861f88..623e486c210 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -50,15 +50,19 @@ u32 *boot_params_ptr =3D NULL;
> =20
>  #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
>  /* See spl.h for information about this */
> +#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && !defined(=
CONFIG_VPL_BUILD)
>  binman_sym_declare(ulong, u_boot_any, image_pos);
>  binman_sym_declare(ulong, u_boot_any, size);
> +#endif
> =20
> -#ifdef CONFIG_TPL
> +#if defined(CONFIG_TPL)
> +/* TPL jumps straight to SPL */
>  binman_sym_declare(ulong, u_boot_spl_any, image_pos);
>  binman_sym_declare(ulong, u_boot_spl_any, size);
>  #endif
> =20
>  #ifdef CONFIG_VPL
> +/* TPL jumps to VPL */
>  binman_sym_declare(ulong, u_boot_vpl_any, image_pos);
>  binman_sym_declare(ulong, u_boot_vpl_any, size);
>  #endif

So I see on a64-olinuxino and others a size reduction here, as those
symbols aren't included now. Do we have something in the tooling to
ensure that we aren't now referencing / dereferencing invalid links?

--=20
Tom

--OU9KGPesV8Ynv/Lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb03e4ACgkQFHw5/5Y0
tyydoAv8CiG7repYdX4vifcLVIHYEnXvlDgvyHlsZ8YtSOaNwFUWfApoyfvQKko/
Ro8Ahh59VnJc4V9K2XzkL8BlnGHYcewPEx/7UbjxEwSy+r/p/eStbqR2tVu1wHy/
CgISBxwQTJakNcc0EpDUglQ5/u0PP3d+FMaesZJ+hL7szWh1nZwwvQxicTIa84M1
2YxRQb/gtB778SXuO0HGcwgpIcMgv0gEbsOYyWlTWJslEZMGCouEyruFhQjaNs0g
PzUDZl41P7occWhFm11Nnn7idRu9ZRoHP/kaRBT1ujnTOODb1dickVfFtqW3UTSN
iAyXVwEh471/BPpFV8B94U/Plw76obD1HsehbPqh84ILKbb25Zoh91m/s74RpQC3
HSC2DDeLvHCZeeWvW433Ui4zOhaAhpq4LkQnS01sLhHTsKBGnAXXj97ulqSKIfcR
/VIxPs9Fg2bPK9EL4y3cbg0AhkgKQ1NMBlmilV1JV4Ls0Et3WurQuZxn3FYkFv+h
iCrHo1RV
=Fq3V
-----END PGP SIGNATURE-----

--OU9KGPesV8Ynv/Lo--
