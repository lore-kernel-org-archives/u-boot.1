Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E0AC02194
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647B980FA4;
	Fri, 31 Jan 2025 23:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ODUsCnrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA98380FB6; Fri, 31 Jan 2025 23:55:26 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A8880E90
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d89a727a19so34644996d6.0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738364123; x=1738968923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1UR9nEnfYU7Ntcx0txK/F+wshSxMeTFYBGD6MItIiCk=;
 b=ODUsCnrYugOtcr8tygwmQPB6Fnv3ls9Qai3aD/GLLt7xP3RYUNlI0fMcmXfUa9reuV
 6h1Z60F0ByRRuP0oABXIplNpNdfj3yOZaakDJNJqGPWmT3FKAmxjgR/yJKPiAKerhx1Q
 WSrAQK4vT9he7oJ3qnPAzd/m7V5XYHdiv/Wro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738364123; x=1738968923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UR9nEnfYU7Ntcx0txK/F+wshSxMeTFYBGD6MItIiCk=;
 b=MaZHij0HhNcEFgzjqEQwqnkdn5uDM3PWyPK/xroYCj21xLqyPvrefcB+1Exwe52UIR
 0d95gPHhr51XxP0JNDtDK3e3V4zIu2sQ3jdXoFLtpRLawvOHzRo3TpgHl4hmcvJ+ifNI
 /dZbpME3e5D/B482RbuhdJHEE6OKk0fgM4/BFUnZeF/rn0KsTNsDs9FB+IUfJmiwRCWP
 mdb09pahjWEFYuZdc3oQbmV3Z9aNPdHGBxCqHKhs07fMTgYBrRlf85mfrWUxOha2a7q5
 0pdSH6JM4prIAvuv5AikrmyZ/Pe91pWohcqdm0ZYC3O8VjC/cD9kz/tcojfA4R4d7MTX
 Mluw==
X-Gm-Message-State: AOJu0YwwREFEFBO9vMWabNaqhTS30oz9OxT8mhhjsYmMrOv8ZGFvSDT5
 lZVMpk1bf50f9fI+NAfcRQbpzKWOIlJDK05uhbICUGQI1hPt7YxQnC3Oa5Ldgqx+ZmilvjhDv8W
 /
X-Gm-Gg: ASbGncuqgW/I1CjYB5oDnXJniHD7FmnhLXiNA3Zf0RrfDYcKjYTYr2JEF7H0T26m7Nv
 ATxhmKTLY4qEOf3+ThpQXqTJE/xjECbOXu1DmDguMD1rYX+mDMP9NaZCw/pGl/Te9cBoydqJ4ua
 m9vUY+TmmMpy3x3h/Ml4d7JoaIMgm3C7rpyFkRKa1mVtOMj7TmQpgorU1mS7DbihK91xHketBBV
 LOOdmcZXG3p1VZH8lmPuF4mMKwuymimikmHavGn34Yb51lcte/gk/GxPbzXzu/YkVIoWBU86FQ8
 odr1vOPhFFl0eYU=
X-Google-Smtp-Source: AGHT+IGTSD8o3oVogNX1JXs1cst7CKTLfwOP18GH5+ORErbsN/M2goQVe1jOnGrrW/G45np/tBaOkg==
X-Received: by 2002:a05:6214:1ccd:b0:6d8:99cf:d2d0 with SMTP id
 6a1803df08f44-6e251b75997mr117064516d6.19.1738364123682; 
 Fri, 31 Jan 2025 14:55:23 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2548188b4sm22464526d6.46.2025.01.31.14.55.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:55:23 -0800 (PST)
Date: Fri, 31 Jan 2025 16:55:20 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] sifive_unleashed: Rename "spi-nor_qemu" variant to
 "spi_nor_qemu"
Message-ID: <20250131225520.GT1233568@bill-the-cat>
References: <20250131220420.3059801-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YsAuv5sO0QQPQT6x"
Content-Disposition: inline
In-Reply-To: <20250131220420.3059801-1-trini@konsulko.com>
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


--YsAuv5sO0QQPQT6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 04:04:20PM -0600, Tom Rini wrote:

> Given how files are searched and parsed,
> py/travis-ci/u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py was not
> being used due to the dash in the name. Use an underbar for consistency.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  ..._unleashed_spi-nor_qemu =3D> conf.sifive_unleashed_spi_nor_qemu} | 0
>  ...r_qemu.py =3D> u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py} | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)

Note that the issue is that in test/py/conftest.py we have a specific
replace - with _ in the boardenv file, so there's a handful of others
that need this change as well.

I also don't quite understand why we do the rename, but since it's been
there since day 1, we should fix the bad examples to not break the
working deployments people have.

--=20
Tom

--YsAuv5sO0QQPQT6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmedVNgACgkQFHw5/5Y0
tyyCBwv9HKom252qZtG1cUkytX0PbfkJeF5LDRGi7DCRBDPoy4U0VvUHYDn8dAH5
qEvW0Ogs9tENSxOLgSJOIn8yXEU1HtjU8kmIBkeCkyQD1pzAVamJJXWAwGqDx42y
RfZUTyM1Nx5BD+xEp8dIjrZeNnGigwsTUW6tI7rOU/BkLJxAxStVyqYfqTpnycG3
TliU4mzr3GrX1COdX5JTk30NVjnfelFQlBEWD3ZoccIHAR0wsJJ+M6ScDyxgRVfz
0NUMCpwuvT5U0b2OL6TrskYM+xUqdMTKaM8FrzQSpspLxkzkIktanaKmmpYhn4ua
fH6QyQqiqpWc5xPL83cOwVF/SKWpFTUDlZp1b80qc1sWPLtYD7gSoJCV2P/kJpkF
DKTCK7k9/+eR6lxQ1mgcOQ/NhBZrbNkHgEz/yUyKk5IRZ81lY/4fpArrebRGA+l2
4ktkcz2YQqGR8ltMZMi4qt2MxLIuIMWvlj8hkuf7vLjHdem5s46xm/835vSiFa9L
PHqnmbs7
=VmAm
-----END PGP SIGNATURE-----

--YsAuv5sO0QQPQT6x--
