Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ADFC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 00:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB8483390;
	Wed,  9 Jul 2025 02:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VykDJGs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F083B83394; Wed,  9 Jul 2025 02:14:51 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D24E83371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 02:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73ce7b40d7aso18437a34.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752020088; x=1752624888; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EwdZjzyZW5y5gfp3GOasHpDdmknr1cScoKfD9eTEc28=;
 b=VykDJGs5w0YuaabQqvjOyAoHMIlZ6NTrBUHSbkm9CiyFG3xBWY6W7PFsQXTau8ulfL
 9bSfoZhFQGwAcgJgiZjOsP+Ygr6XP1V1pmRS6pMK1VG10xY4vNJ8Ov3KdsApPqUn6p6d
 Fdl8Kew0idOG8Pi1PzWW7WySYipnfRMnx0YWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752020088; x=1752624888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwdZjzyZW5y5gfp3GOasHpDdmknr1cScoKfD9eTEc28=;
 b=qXtoYD2FLspAQhh18CnfYJDAnLtr9aA1ChldRXBD41/+VT+5yjk09aZHVRT87yrJFi
 /fzrTvpLEo/Y58jR6JmhDHYMa7XclccPN1gY8m6/h3h33mpcH5pFmUI0F1IDNMF+gd2V
 uWbt148Dnozb5G9wLxrU1XfEYKuLSh0cq1HcX7s0c1Ikhqgv/mQxvyzSRJKikRkEvzh8
 M/Ma4ffT3Q/kErxVQbTFrBu495tLtRan3dJHt0ooH9mlTxauw3wWw2VYl/voyB9pgjEj
 NN4SAB+Qb+WyPSsiowE0PBBTvaCFawd71zNLH0KGVqN9JrcHXMsSGWJGPSUcpmtc1c3D
 18tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwPBWKIAwT4YQkaGt392a9Qw5D2qleCYkmLTKysfkMQQ/0tvNRSB1k/x0Io5gRbzTgQ5FbmDI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1+dcQ1OwM+10yymXvyFTrSespkkb3HfjU3L+Eky5/tbOHzjEQ
 0V3OvLymLcldYmUu3jiGZUaL9HPrx8KBNGLWNdx1DYDjT0UHze5RMe/2q49wj/aaT24=
X-Gm-Gg: ASbGncsjC5CAko2LJhZ0qFa765nLqmilCCSAxPADXXFewmjAnqqdMDd0heDBZagnGKX
 n2Kg5wn1m1KYfvQY+kVTk+y4OZbQcozw61tXInLMITumxuhQNVdXsiUda67fzz1mpo/VCfDPYog
 bnzRkkdUnXsQtPHpu6tOaz2jn+kM0hpJPh1ezCiKM+d9/0Vy9eaBluGNeRu0WlCv2ht8J8ExoMt
 hA9tHTaSysmCtA+hQupHBQVXm7mh8qtrdhwU/642tNz3vq2UuO53eI4nVG7Ewu+yuwbr71NmFji
 Bz5aX6cwn5ZMWZdJYXG327+FxNTJU42OpcAZtZ5PbxRKz7RA+60AQVgAQIfDQluw14W49EgTSMb
 3QT8YPMlWHvQMDtEEHvH5w9Hk6NEp5hU=
X-Google-Smtp-Source: AGHT+IEC+j1VSgpu4KmW7lFcuPD+jhJPa4QcJmAFrSAwjoRBKkVg5Q25aoXMNOe3vgdLWpDkNzdknQ==
X-Received: by 2002:a05:6830:154e:b0:72a:48d1:7fca with SMTP id
 46e09a7af769-73cd791dbdfmr3443726a34.4.1752020088099; 
 Tue, 08 Jul 2025 17:14:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f73520csm2195543a34.8.2025.07.08.17.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 17:14:47 -0700 (PDT)
Date: Tue, 8 Jul 2025 18:14:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] boot: Ensure method_flags is initialised before use
Message-ID: <20250709001445.GA1724532@bill-the-cat>
References: <20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gc09Q3/35tulY1oy"
Content-Disposition: inline
In-Reply-To: <20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org>
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


--Gc09Q3/35tulY1oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:09:36AM +0100, Andrew Goodbody wrote:

> The local variable method_flags is only assigned to in some of the
> code paths leaving it possibly uninitialised at first use.
> Initialise method_flags at declaration to ensure that it cannot be
> used uninitialised. Also remove now redundant assignments.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  boot/bootflow.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 4054a966af8..d60e9df6a9d 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -245,7 +245,7 @@ static int iter_incr(struct bootflow_iter *iter)
>  	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
>  		ret =3D -ENOENT;
>  	} else {
> -		int method_flags;
> +		int method_flags =3D 0;
> =20
>  		ret =3D 0;
>  		dev =3D iter->dev;
> @@ -264,7 +264,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
>  			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
>  			log_debug("next in single\n");
> -			method_flags =3D 0;
>  			do {
>  				/*
>  				 * Move to the next bootdev child of this media
> @@ -306,7 +305,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  				}
>  			} else {
>  				ret =3D bootdev_next_prio(iter, &dev);
> -				method_flags =3D 0;
>  			}
>  		}
>  		log_debug("ret=3D%d, dev=3D%p %s\n", ret, dev,

This leads to failures in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/1195854

--=20
Tom

--Gc09Q3/35tulY1oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhttHEACgkQFHw5/5Y0
tyzgpAv9GITJWEfaui3Hp1f4Gyvb8cW4mA9tDTOzI3vvqf7/D0UJIytf2gsRN61o
iqjihCv389IN/72IFSO0VY0xpVGoymw3Tv3kvtFA32u+KxCW6BHSJN10y9QrDIs6
BfWda6Ou2SJp2CWFHrKGQO3mANIk/bgTdLisXtnKSly59WyVw0laZpdpR2Z9wlpS
ep0WqJ4iYG3YgFH5KlltqX7dvzFygxc3UA2wA3EpRDBSSbe2L0FMMdzZEGT8zxe8
URHuQju2T4OKp4bclf5aDOL+w0l+8yx7tIM2YhBldnLOeNidqptw8AMpNfsoR7Ig
iKZrhD/6jHj/TWG3o4fkLV4obrXUcEmcZ9hYOQGqfgOOolxOXA/U3pl1VzgxPWVF
cspMnu8jjHwVej8btSNfkQFV1QaL4cYhfAmPoTKzDeXIlijp2W0W3A4BviYnLJB/
5i490lPOc0Necb4NVlAreoHT5PddzjvO7LfslXI4TFaFPb+uDoRs7jq5OtSsBYy/
M0EzCPoa
=5ikZ
-----END PGP SIGNATURE-----

--Gc09Q3/35tulY1oy--
