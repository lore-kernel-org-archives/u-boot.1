Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D8C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF18C80BAE;
	Wed, 12 Feb 2025 16:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szJZrgdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5728080C69; Wed, 12 Feb 2025 16:24:54 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E16809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e4468b7099so60378316d6.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739373891; x=1739978691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UtXfGytfs2VR/XmA7fynSS/hnZB2juveqpewL95glSE=;
 b=szJZrgdORegvzavEXoMI3HPbtPr/aYrN5G24WlQeRiI59bqZtzg/OC9QDxc8VLuff5
 usIjoaoyS+8EOkp99ad/rT5/PSNk2OtPrqErOlcIrT04N0WCdpx10taW7IBVi0m2htbq
 Stgt/nwpIOeunPTZpyzO5w9QaQPba3ZAuNByk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739373891; x=1739978691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtXfGytfs2VR/XmA7fynSS/hnZB2juveqpewL95glSE=;
 b=Xl9Q2OvvLDejz4YwBgOEOCYeftdhYU2nGa6tk7wLPOQ44UV/dw6D72Yog1H1LGa2lt
 G6AI6D+5zTGsUUgI4F4ISZxPNSJVVSQL6mPofovHAtPpVHqZpOg50UrKZ9VdWEhzflAe
 WxdLZz7MPsjj4K1kTgoiqrMJ6wFBSPo8sS4tLVosVZRBbJtzb0e9a/cEsME4LkyF9BxP
 Am5khk+xa/dy8JZJzgA1NCLkH9h3U5/1urmP1IWht6rvxcjUm+0RS8vat1g+b8YJ8a5e
 2ByPDDmyIrBaK5p4LkQsCb+HWldPecfSoVseniSlyHw3ZGlvU7BXunFhgN+mOh4bGBOg
 /1Pw==
X-Gm-Message-State: AOJu0YzUhC0DLC068Ry/JhtVyO+sB1eoDTr5Ti7J8julu75w5JTftV7H
 viUNWU6zOoYeOEzVYU4ds//EVPW5VBcS3L7wCocHbCypbpuAUbthKDMWN0610o4=
X-Gm-Gg: ASbGncvl03Nk6PrvGrSsMYupTEE4SjCHRP3zaDTj+H5MRPdJuqyjI7DnH8DxGWgNORX
 u9qKyBxKp9oXMXIfIUqoYlqyqnnqWhthzTEsDjdaquhaJCDWUYJgxrIvQfb6/70Qmoux6x8Kt6S
 iGLZ3SqMU5PZ2c1OUuA2+XRqkeYczwrYkv1LzTupX2njWSUGZ+VQxXRIaq0B4Bcg5A1fhJP9xWc
 BdlLPWYGE9WBGgV9qSjyqOG1g5Bx2M398xouvQFXAwUYBignsn5aQbzQylSNMSMe9xvgsc8ku9B
 NH9LXSXa0TB7r8A=
X-Google-Smtp-Source: AGHT+IF1Dp+wWW2+xa1lQllNLlIRPqyTAmU2Z1tFxcLf4tnlrVVKIertBx8e7LI0BwV09Ogy9GZONw==
X-Received: by 2002:a05:6214:248e:b0:6d8:812e:1fd0 with SMTP id
 6a1803df08f44-6e46ed822f2mr54176406d6.15.1739373890886; 
 Wed, 12 Feb 2025 07:24:50 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e456893843sm55208096d6.59.2025.02.12.07.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 07:24:50 -0800 (PST)
Date: Wed, 12 Feb 2025 09:24:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] scripts: kconfig: Fix potential NULL pointer dereference
 in
Message-ID: <20250212152447.GM1233568@bill-the-cat>
References: <20250211160509.115328-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YMtfSwsVxaSTIKYH"
Content-Disposition: inline
In-Reply-To: <20250211160509.115328-1-ant.v.moryakov@gmail.com>
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


--YMtfSwsVxaSTIKYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:05:09PM +0300, Anton Moryakov wrote:

> The function `prop_get_symbol` may return NULL, which was not checked
> before dereferencing the pointer in `menu_finalize`. This could lead
> to undefined behavior or crashes.
>=20
> This commit adds a NULL check before accessing `es->rev_dep.expr` and
> `es->implied.expr`. If `es` is NULL, a warning is logged, and the
> operation is skipped.
>=20
> Triggers found by static analyzer Svace.
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> ---
>  scripts/kconfig/menu.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 0fe7f3255a..3fb3ab4637 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -400,12 +400,18 @@ void menu_finalize(struct menu *parent)
>  				 */
>  				if (prop->type =3D=3D P_SELECT) {
>  					struct symbol *es =3D prop_get_symbol(prop);
> -					es->rev_dep.expr =3D expr_alloc_or(es->rev_dep.expr,
> -							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
> +					if (es) {
> +						es->rev_dep.expr =3D expr_alloc_or(es->rev_dep.expr,
> +								expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
> +					} else
> +						menu_warn(menu, "select property has no symbol");
>  				} else if (prop->type =3D=3D P_IMPLY) {
>  					struct symbol *es =3D prop_get_symbol(prop);
> -					es->implied.expr =3D expr_alloc_or(es->implied.expr,
> -							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
> +					if (es) {
> +						es->implied.expr =3D expr_alloc_or(es->implied.expr,
> +								expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
> +					} else
> +						menu_warn(menu, "imply property has no symbol");
>  				}
>  			}
>  		}

Please submit this to the upstream kernel for review, thanks!

--=20
Tom

--YMtfSwsVxaSTIKYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmesvTsACgkQFHw5/5Y0
tyx75gwAujlWcaOgdyNKv7Fl9ApSF2VLhIeUottY81qFRFwqgX53N/1KcsCw2XfE
1Hk6ZE/uCGf/rWCMpT1bys+I5v41A4VSDYVKasAkZmMzcvjP5iStzcNH1ay7gHA8
/qzs2dx0NIbrpAqOXxVDVfpOk6vwcNUykZvQ5PcDXJQ16j8Pw3nYbYe0J66GsP/x
Juprg0dQRV07vL4u7tKgfIiXaS9H/+w466Fy9ruxQdPj4Y3WgKu//Ttc9zUd2xRm
S5zbf45p9k5EIZj82ZsjdKsaD18BuFQtpWin3JtRq6aEndwMMjQ65auRNL9JVEPY
EbYwx4tcpSnGQFOaMuM1/BofsxcCLnZ6VvJqUKZQytKqv2y/VCCqQhl67PDIIZ+D
5k+9XXGlotdvCFQJjXqvl3dwbxIu1yk9a3GGOAEqy1oSLrTClpXM4gZ1ks0U00E7
oxOfS4O/p0xwfllTkVzrBV6brsrqQR2zXIfFmMYDIJgRiFvBlNsjze9R7Xzi9h3R
+GsFHc3o
=KCm2
-----END PGP SIGNATURE-----

--YMtfSwsVxaSTIKYH--
