Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB99C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 15:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182FD880B6;
	Thu, 29 Feb 2024 16:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TtKZ11Yk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A97880DE; Thu, 29 Feb 2024 16:43:11 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD5587C60
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 16:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dcc73148611so1162605276.3
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709221386; x=1709826186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Rn1o3wKBQ3zW8XhduJZc0yk83nxnx1eg5wgEffKtMc=;
 b=TtKZ11YkEOyNcvFXZFKfEbMUzlWxIkNbTmUEbBre9Ux1zOihzLsijSy//YT8mnT3d3
 u1ac7YDk7U2Ia4A6Pk0L6sr6LEtAEHkjB+J63KaQZnRO6rZQbtYlsqC1J/zODu2newPl
 Enm3KZ35JavUK8vEeqlLE0TOkZnN9/j+d4CG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709221386; x=1709826186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Rn1o3wKBQ3zW8XhduJZc0yk83nxnx1eg5wgEffKtMc=;
 b=ABjViVvNU3nNOsDw0gqgjgZ13seLwsVb1i4VNWw/kZq4Ps5Ve7rDMAQyR3aBuO3zOp
 M/4vIS9VjC001K02vTtnA/A5wF2yxeh8GhljSn8u7uQcH7rtzz2PAjC1Ee0JVGx29PjS
 y01qhQfOyUWStsjkQpojJN6coByXg9H+VDtWozH8v5NrBOELotADPfV6FDUS/G/XDORe
 NqH7WPDMOcPWIWQ9khYyOH1q3hEBZEf2Occ/OKf0euVw2b+zTMOuLm2grqV3pka2OCtw
 sEuxH9trGeEvYiM+eaGcRA0ANtHPZV9bYbxSb1+TAHsWqsqNo7wrmHljgAQW/fI9KB7n
 s2zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckCkY5odgGnvROkEZKm6M/ZIlrQ+0NkbweOOpmEzpXvQE2fe0nUjKdZ+Ogp6g8M6PXLMK8gpos4+4Z6o9DP6RBz5EXA==
X-Gm-Message-State: AOJu0Yz9O4fbWzkw9uyJun0vlPul1kDn+YeNzcue0tTKq+hrrantmHpI
 B8SdF3UIMSvLf1B0MsVnGPxvgq50BkIKbPaigUYZKcRCLhEalWSR3E0VaMJ3wMI=
X-Google-Smtp-Source: AGHT+IHvDfwxjNPsmPRwl8Yh0kC/y805OU8C7M66WWraacPmxUOOtnbE+3p+n0Uo/XA+hJM/tE5DCA==
X-Received: by 2002:a5b:78d:0:b0:dc7:464c:e979 with SMTP id
 b13-20020a5b078d000000b00dc7464ce979mr2615311ybq.28.1709221386063; 
 Thu, 29 Feb 2024 07:43:06 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 g17-20020a25b111000000b00dcc3c85f6a1sm392603ybj.6.2024.02.29.07.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:43:05 -0800 (PST)
Date: Thu, 29 Feb 2024 10:43:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/1] Fix booting kernels with ATAGS and extlinux
Message-ID: <20240229154303.GW3040305@bill-the-cat>
References: <20240125201654.17685-1-clamor95@gmail.com>
 <CAPVz0n0x22t6x1Zu-GRqLYXjJVpyme-PikhB=_KyKyLEFreyvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ifkm8xs7mLsbGmbO"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0x22t6x1Zu-GRqLYXjJVpyme-PikhB=_KyKyLEFreyvg@mail.gmail.com>
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


--Ifkm8xs7mLsbGmbO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:23:31PM +0200, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 25 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 22:17 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Currently, if boot with extlinux.conf and do not set the fdt
> > U-Boot will provide its own device tree. This behavior is
> > beneficial if the U-Boot device tree is in sync with Linux,
> > but it totally halts the booting of pre-dtb kernels (3.4 for
> > example) since it uses ATAGs. To fix this, pass `-` in the
> > fdt extlinux field as a signal that no tree should be used.
> >
> > Tested with 3.4 legacy kernel and mainline 6.7 kernel on
> > P895 (lg_x3 board).
> >
> > ---
> > Changes form v1
> >  - Added CONFIG guards
> >  - Clarified documentation
> > ---
> >
> > Svyatoslav Ryhel (1):
> >   boot: pxe_utils: skip fdt setup in case legacy kernel is booted
> >
> >  boot/pxe_utils.c       | 27 ++++++++++++++++++++++-----
> >  doc/develop/distro.rst |  6 ++++++
> >  2 files changed, 28 insertions(+), 5 deletions(-)
> >
> > --
> > 2.40.1
> >
>=20
> Hello, Tom! A month passed since v2 was pushed without any actions,
> should I re-send it or maybe some adjustments are needed?

I should pick it up at some point for -next, thanks.

--=20
Tom

--Ifkm8xs7mLsbGmbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXgpgAACgkQFHw5/5Y0
tyw3NgwArWfwiRcvjocXOxYa2Qd0nvoEkovc5oz5bVK0nBQd0P9M8hfKtj6lKbMX
IUdjJj+g5LLjikx9EvDEieTRJU4oGR9npNcNA1FVnVziW3IZKfe0nSXGuolfgew8
ZupaegZtCGBFEwhRd5iiEHNOmQG2HWkPiK/iU/djLlp8OxQ1aKje/vsxTRUX2hde
LczQiqctQXhgQpE5nlZUYQRV+tOoL/gyi2YU+pGwQTW6yX3NkuSW8SkSjIBdcWbh
uPRgydSxqrCO3ywpOg1JJJ/tFvMorFiy08eE8U95vgooFjxGtnZOkgU4Hs8k0x2G
UdeEoYj/pe7p9m1f/Drw5x5yh3yBBlE6WEzTjPAyboZvLUXL9m6oyN0oOJNikMJF
qaQjMofPVn17BLpS0l1tCI1MjnEHPnZpdYOR5eFR8HLj16mMaJff0Zcdw2KvFMla
VYWKbyUdFqY4p9qGgsh6FgUkT1muE8PclKCkty/sPP4LeAlPS/rg6G6jUF/O9Hp3
raq2Nl0+
=+WsB
-----END PGP SIGNATURE-----

--Ifkm8xs7mLsbGmbO--
