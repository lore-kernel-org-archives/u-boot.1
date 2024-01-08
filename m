Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64416C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 20:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC8687942;
	Mon,  8 Jan 2024 21:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mBTiXYcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3FF87A30; Mon,  8 Jan 2024 21:44:34 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F659878E1
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 21:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78314e00350so232118285a.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704746671; x=1705351471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NVY1iWo87P+QX7J9EnBO6gA3XemPZOffMJ4k7T0fN8U=;
 b=mBTiXYcDdmvqFM2pO/US6b3OhJJHAGF4GmsQx/NzQC8hMmqTadl2cSYrhR5y/Wdl6a
 WhGxsM+ZY4t16Og57FtUCJpZN7dn42m8TtkaNk5vnlUr4WHhJMHK099zNF86f4L8Qb+M
 JE4N9/PKy9dluS2g4opzWyV+he2n36ElsPbag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704746671; x=1705351471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVY1iWo87P+QX7J9EnBO6gA3XemPZOffMJ4k7T0fN8U=;
 b=kYw6Uxxx1u0PFKHBbh4lCxDrQhuLjPuhxapaaGWnQeY+4QmKR1AlA9lgPVinM73nOB
 M8LufuE3/5yRWsVuiVu7DvUZi4lBdLvgydvnf1fiXcqg72n8v9+rU5UA9/+4wShUE7zx
 4eq0DJaWpkKF3MZ5VeH+WJtNyg4qbkjEyu7LVuDvhxJ3K9GWINULSETrnnUl9vRHWnlH
 AcBj1qsff3TAOMboUHqNz87yEroxDh3jDiAfHqRr/FWaq3+Ce2o/mP5roySn8F/3j8pn
 w654GQSyl6Phwrwk+fk1lbYj7Xs55bI21ltm9qD7LGk2vIJUjKDwgSGMkJtsyJzI+GPA
 1o8A==
X-Gm-Message-State: AOJu0Yyim6RiLg9aBH1z/V5A/3Ar93B9ky3A25aijeWWYOd94In/6Rrs
 oYaZyoMLGZiDUWgmAB4YG/qh4IeLQ07p2Q==
X-Google-Smtp-Source: AGHT+IHq1WHLexKPXIgJjWzhbmnywMHbPvnEKOAqZ6GoQ/xe08twq42toXMzXUpylcEg2uJGDKapFA==
X-Received: by 2002:a05:620a:6890:b0:781:b2bc:336 with SMTP id
 rv16-20020a05620a689000b00781b2bc0336mr5265216qkn.12.1704746671303; 
 Mon, 08 Jan 2024 12:44:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05620a22c400b007831c7989a4sm194052qki.22.2024.01.08.12.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 12:44:30 -0800 (PST)
Date: Mon, 8 Jan 2024 15:44:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: [v2] Pull request: Please pull u-boot-imx-master-20240108
Message-ID: <20240108204429.GQ1610741@bill-the-cat>
References: <20240108183709.3230970-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rmn9xbqKno55hID0"
Content-Disposition: inline
In-Reply-To: <20240108183709.3230970-1-festevam@gmail.com>
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


--Rmn9xbqKno55hID0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 03:37:09PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> This is v2. Fixed the summary log.
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit 93d91e9485d902a1836a22e72d1a545b587adf=
36:
>=20
>   Merge branch 'next' (2024-01-08 12:00:18 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240108
>=20
> for you to fetch changes up to 54e1aa236f7d934ea81d727fe27b6d05902643be:
>=20
>   Add imx93-var-som support (2024-01-08 14:37:57 -0300)
>=20
> u-boot-imx-master-20240108

Applied to u-boot/master, thanks!

--=20
Tom

--Rmn9xbqKno55hID0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcXq0ACgkQFHw5/5Y0
tyy9tAwAkhJkOYfKAWHQRv7+eUohR+/qJXR2zFMHFReCHV7r3A6J3hSRtYxp1gQz
nQIHFADyq3GpybsPagv9phkMe2aEOtEiPNDNkjZyU7fVBhUMtGkO6kuuXv3iJGHv
gOVTnZVjVWkQqnaW97fC00DN0qDr7rZScMaI/X55wKJph/kFzd3KiO3ftdq7Aofs
OPlW//DMVfXkZPDZBE3BJsIRI6NXGhPLjq+ytEjhAiz98Tv1ZfbD/sS2oHJIPMNN
X5H8wXvVsZxMV9+oQuEUoQ0WoGvC8hxwwvV6quNYld1657E1NGtU9uU48lmIiraf
LbZdVxLS+M8X93peKY2e6tFT1gq3yAFJzoElLw/J0Mpe+XL/0vimYnfupU5mICSA
m3zAmLchVy3pLQGAy/tX7BYe+Twi4/nk4HisG3qLQHWhRL5UM9b8b/RiasTE58S7
N5UeUlOI/yTRVogcz+szf+9euqmp9wB1p1goi9jteaMnr9CRdfgyYZW1zQb+c998
JvEPWJyT
=YdYV
-----END PGP SIGNATURE-----

--Rmn9xbqKno55hID0--
