Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AA9C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B2D87C35;
	Fri, 23 Feb 2024 21:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N0yi2auE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABA8863D3; Fri, 23 Feb 2024 21:38:25 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F2487E23
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 21:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6087396e405so6718357b3.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708720687; x=1709325487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g6JKjDQ04JZHhL5hzsg9ce/4ZmB+21NfLSg4IJNjAfc=;
 b=N0yi2auEJM4H12NNlPSWjWun17ZqfyyOewyRW8Q9HOUMVuK037dIPaTGbjK3UvETH/
 Vh7/S4mk7QqBM2iv4S58+Q2fE3l+iQRw4e9xvdX0s/8I2xESXJZA7ijxXd5KCYqr0VOw
 Zr0m6UV8bQIdiRdmvJG7EmGqpq1Tzq2S7uQXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708720687; x=1709325487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6JKjDQ04JZHhL5hzsg9ce/4ZmB+21NfLSg4IJNjAfc=;
 b=qwqAyADce45SUpbjeB7gGqbxpIOCTAhGhGOhJci8ZLPBb5F/nFEm8m/Y+m8lejipRZ
 DHBfEJeoqfgrz9q9tDf+Y7BKF/+Y3bEoV8hj/ojNO6yQIvInTyUs6izu2AliVd4pXX0q
 ugOXK3Cff5J5VBgKlOG7+DVIKnRzdHd92WWfDf+Gl6mph5u6AyR+qIhOYkCXjWl+5zSo
 /Nn0yIEKqDkHBAfDssowKrqnl2Tt/FhJRV4FS7C1Qw7AX9RYuUJMX8b1paGzEXxF0xPH
 uRc5boMW7INNk0qJDXwgjEOYB8Ch/NfFU+c+QN5UOnp4PNW6i79irKwONJ96824YtIgr
 Mi6g==
X-Gm-Message-State: AOJu0YyKH+iTKnq/s+CX5vJCMlTDhOgSZROVlOxKJRfl4emmojrjrUYW
 N1g5mpZBxmBIiKnESNkRuHPSz/EMP+gep3RBK1vIqqJWI00GtJ56bvvv6isfgwIQDBxOhBx3ahU
 C
X-Google-Smtp-Source: AGHT+IEyrsiFgKzpZWl0rAtVQCRRKUOnWdxDMX+2WJa+8zIFojpTiX7lrB8taLF3HGfHr99NQ5wLsA==
X-Received: by 2002:a0d:cc06:0:b0:608:a89e:be9c with SMTP id
 o6-20020a0dcc06000000b00608a89ebe9cmr742416ywd.9.1708720686748; 
 Fri, 23 Feb 2024 12:38:06 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 n81-20020a0dcb54000000b00608cbf547d9sm196510ywd.88.2024.02.23.12.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 12:38:06 -0800 (PST)
Date: Fri, 23 Feb 2024 15:38:04 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3 1/1] Makefile: pass -undef option to cmd_gen_envp
Message-ID: <20240223203804.GZ3040305@bill-the-cat>
References: <20240223114206.21720-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8UsHBvU33a6jDIrJ"
Content-Disposition: inline
In-Reply-To: <20240223114206.21720-1-sebastien.szymanski@armadeus.com>
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


--8UsHBvU33a6jDIrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:42:06PM +0100, S=E9bastien Szymanski wrote:

> Without the '-undef' option, the 'linux' string in .env files is
> replaced with the string '1 '.
> For example, in the board/armadeus/opos6uldev/opos6uldev.env file,
>=20
> kernelimg=3Dopos6ul-linux.bin
>=20
> becomes
>=20
> kernelimg=3Dopos6ul-1 .bin
>=20
> in the include/generated/env.in file.
>=20
> That's because 'linux' is a System-specific Predefined Macros. [1]
>=20
> Pass the '-undef' option to fix this issue.
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/cpp/System-specific-Predefi=
ned-Macros.html
>=20
> Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8UsHBvU33a6jDIrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXZAiUACgkQFHw5/5Y0
tyznmgv9FH+8TwL8xk6CZBwNQq1qCdA/qKzfNhzHtG6BKinl2MD4XTO5Sf1rpC2p
NK/3+fFEhv90YdnV7Dr/Z3G1ASAE2B6/mAJy59N4BkkGmDEB7hzDs6LT9pfI6aS4
twfl3hZaYjJvQJXkeoG3MCaGwLf0yNQhd6dBntqKh44ov0aaamPeG/vm3fT3Ze+i
ExtMSq2KAUhhHAdatDzVl0KSesDRgvFI7UsJKMcEjYBhyy8DXUxI67///lonRN6L
NQtMO2tdl3syMBqgbkmm3cxZSZT+grcDmsZ4AlzggljcK210JiN5p+l/jz4QT9Zf
RlKPvAXzPfoexbfaVBXHAIWaL3dUbQn3A0qTzaYTm6Z4Wch+Q2ZKjDHK1L4y9Ibo
EP62Cs6pigc11gdpB7EKDxmhIu5UI1wuyH0N85MPsqwBwEwzj/ABgl4GNnMvd1uz
ib9+cQQfJEpXtAfrMpAzYNHeh30FgVEqEwpa/3kvht6gaRJoj059mK0jtkwbZkgV
wZ4GSfys
=iygr
-----END PGP SIGNATURE-----

--8UsHBvU33a6jDIrJ--
