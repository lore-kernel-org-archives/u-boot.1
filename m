Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F56C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 16:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D2982998;
	Mon,  9 Jun 2025 18:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1Cr1Tpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46E882AA7; Mon,  9 Jun 2025 18:49:28 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7250826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-610db3f3f90so278034eaf.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749487765; x=1750092565; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vvFcATsKAg10bczG+D6thArlY/Vn2l8aDsCjX/rLtAo=;
 b=k1Cr1TpwLgMt6yosTeV00/J4xgxhkMUBd9NUgRuZ4cHpJ9Uvrn1jfPk4JnoA+YiTMy
 gwRXGmgGFmOALM5kHLqsr7TgMjUyFNrjE4ri2q18d+vScp8VwQimteOuFFcAAJ9TEwcu
 eDqlaIv1zuZK/XFDEc/q/zEWcyJa+jNvcVmfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487765; x=1750092565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvFcATsKAg10bczG+D6thArlY/Vn2l8aDsCjX/rLtAo=;
 b=mD6/TVwe2OR2K9vZfZux7tAJHPQ7uyJzbzKozoRdDwDSiwE3NOr4NDq6zpzbFIdygy
 L1WyTiOCsWFVImnEzpN4CHZ6Q/swPRWsWKL8Cv9wdNgZn3/x8AQoRf5FFDJ+bSnOZ2Cn
 JwArvtrA3IfgGYSCqei2lltrxqVnQPo1RnBgZU+FHN3VasOjAahaMUlaFOLuhYspPUh5
 CtIF8f1NpKjNChWK22+PGmoq/rEXuhoSO5nw6nIM/TFPsay8tLKJkyZ4HzJhYoWVFcAd
 8BgCy3PFhCpq8LeaLI4HC4galSajLW2GtyKMsNNhg5r47Rg3InReWbyXLVD/TaSycB7w
 PZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr2oixIPTVb2sBXSiruRr5LMaNrnytzMcMlGjUNQQSchc8ZHpLlS4pVAUSOhGI7MEU/LFaF9Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh4RMI5nTnHBVSRzpv0SsuGheGmPcSaJ8XS7WEt7x8JPoFyoxv
 cbMp+QIOyiV5c+fFqjYReqP5FzDHcUnQNPALTcZwTBxNvugLQDQztBEuRA/G70spgSs=
X-Gm-Gg: ASbGnctErX0M6/lMKibyTPCggWwzwRKAc0FA/RAIa0NCIkSEuSKPyzZZbfYC6fdjdd+
 7oK80PMiXXFXgbwDSq5qFXte2wWNWxDKSSaUunMWly5hAtTVkdL/OZGHaepnH7RiMyIddukt8+k
 imG+jsvoaS54V6obGHRYo8PV+IKcUcr42DQmTqu4aSbM5BdTi1ek+2B6rIwSJ/mEZFRuFuyLSK+
 cN+H4YGS/Wp3F3oNl3dm+VrGYXWdVow1S/UB8cgO0rmTguRNzU2k8YZBZmHYsshEH5NtUwpvStD
 Pg7K8yDOtembhzkB8KQHYKY3lS1ymjg1Y0r3XJFJh5foRj1k4XFM11HiZm81dMbGf4o+DnvIp2n
 PzaJF4ZSo3Z/O
X-Google-Smtp-Source: AGHT+IGaybAOLxxYn4mNIngp1MsvbcSta8XUm59hc16y/IZNUhcdsxuNOed0dmgluIkFpeBhTjV6Bg==
X-Received: by 2002:a05:6820:1a06:b0:60f:874e:6601 with SMTP id
 006d021491bc7-60f874e665emr5929731eaf.0.1749487765429; 
 Mon, 09 Jun 2025 09:49:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e645a22sm1351364eaf.15.2025.06.09.09.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:49:24 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:49:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Message-ID: <20250609164922.GV1382132@bill-the-cat>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-2-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k3fUZAELnAUBlhyR"
Content-Disposition: inline
In-Reply-To: <20250606223109.502055-2-mikhail.kshevetskiy@iopsys.eu>
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


--k3fUZAELnAUBlhyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 01:31:07AM +0300, Mikhail Kshevetskiy wrote:

> The current code have two issues:
> 1) ineffective NULL pointer check
>=20
> 	str =3D strchr(str, '\0') + 1
> 	if (!str || ...
>=20
>    The str here will never be NULL (because we add 1 to result of strchr(=
))
>=20
> 2) strchr() may go out of the buffer for the special forms of name variab=
le.
>    It's better use memchr() function here.
>=20
>    According to the code the property is a sequence of C-string like
>    shown below:
>=20
>      'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '=
\0'
>=20
>    index is the string number we are interested, so
>=20
>      index =3D 0   =3D>  "hello",
>      index =3D 1   =3D>  "world",
>      index =3D 2   =3D>  "!"
>=20
>    The issue will arrise if last string for some reason have no terminati=
ng
>    '\0' character. This can happen for damaged or specially crafted dtb.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Thanks for explaining how I was misreading things to badly.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--k3fUZAELnAUBlhyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHEJIACgkQFHw5/5Y0
tyw+NQv9FPPNfsvbvFL49Zdr2E5nRzqdChfzOik2WcLSgPJkNQQeXZoOgEBEoxZ4
DpdLk3sRMXjRB/2ild+Giw4CmhpBATQfAlBCXphA/ZtdmZZAiV48HusaJqHbnbxA
vBIK5cD9fAYuihmtTN4sMDhvKgVz/uvPTm2T38Bc0cqk0RFcP2nbhL367K4BwIDt
ytaBsaGO69nQxpZX2HKzKBY2NHVgWhrCXRRTpA3KHTG0CYhJm2NwxRbuxdu12Kw5
mvghizKIPl+8EGqKvw1B/bRkWx8jEPfkoIt4dlq+iJhJXMn2UGFvlMsvQNf+qgr+
JNZc7PSqagCMcJ2cjvdl9jfMtInq+kMyl9nKsuDZcAMef64LsMXspZyjljb+tft4
6BHCy7TyvdpsrBOOcAuyRwkw2rPwyOWNdODxYKtdz4xPch0TSsbfgmdJ7YhruUgg
ui24wfgfI7Epgk056Jv5H6MaiHUEGTSC2xqHgqd8KzuZofw/XIGx+UZcaFDdi6gk
/5APIIsN
=7/w1
-----END PGP SIGNATURE-----

--k3fUZAELnAUBlhyR--
