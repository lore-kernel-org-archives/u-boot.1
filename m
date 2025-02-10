Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89CC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A216F807B1;
	Mon, 10 Feb 2025 15:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qowezAFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF2E580AE5; Mon, 10 Feb 2025 15:50:19 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1538043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f9bb24d033so24714537b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739199016; x=1739803816; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7pfxj6sqgWlHE3nM4HTbBak7cBsAbD1cUk/9AzGTuo4=;
 b=qowezAFhVq4PnSAfwBfxrC/sz6y0DuD4UHXfN3qUvB+lHaKFcJ8kwjt3SERc1bbo2N
 PIsTFEFGFwhB7p2pBPeQefDlItnqj6W1hLJyvhgzcVxvo6UCybiqLYAad+8Y8cBmkFXt
 9+DKD45x26rYlHZ284/y7CG1/aQDbCryu8Dw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199016; x=1739803816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pfxj6sqgWlHE3nM4HTbBak7cBsAbD1cUk/9AzGTuo4=;
 b=EeepxfsCSKlCzZzdwXL75NS+CXp80Ap4OBrXfcts2KA6YeGXbOhJw29odHFYqU3xu6
 78+2+5tcBfG+qcsqfYrWxiNU6P4AzweyuKD/bx1svGM2ees3sJzRgS3zYPi91Uo0sAD7
 EEbWVobti4Hs+24NkZqFv6kbpUq662JzGfL/SWp+vGC4FOgkSHvo749FGYUjp4VUJwsE
 Dpvft2xsmRBuoyYb2fU1Ly64qXM1LtTUDBPS3i3kdjaMkFI4xWP9MSoe2dvxQ2pobDMr
 uoHTjnTVUxdYaIXV2IErzugIzt9XviBcOTxHdvwindcVD3OlbSW8YLyjrCP58JjBq6WI
 2t6g==
X-Gm-Message-State: AOJu0YxPBxF4RdTrwrZuIFfXcvgrTwN0qRLN4rOOQYP00uvZRSRgIHcQ
 4BV6j2pdc6evrdLindHBQvgcdbWhZ4yQk6ERAR98czSbscqzr0DnJglKgZ//j60=
X-Gm-Gg: ASbGncviy1Y8eTz0OYWC/h7+zW11+APjwodRH1lCDsHuqVGbfqbLoYO3//Zwcv+konc
 XBJ+WzNvm312CcbBuh5p5VvbYX5WbEV/mA1yuF+gw+3I0y6IKaVx3SkoiFRSeOhWsGl8rXJ/Lbp
 mRyA+5P1I1UNUsdRZWMVT86DYZT+AWuBY5tEA04qxfTNvb4hzTMuaTxC3ZXFg90O0IwOn9FARnB
 4IDPaIa6H3HwRIBdjhWUR0eP7e5vQ110EPVeXmgWHwKLYO+/iUih2yEz1Zt1DhkVcsnVY2vhRnJ
 Vzaqaqv9QtogZek=
X-Google-Smtp-Source: AGHT+IF2yYcN+nRLruhluXH8njGKPuF7Wlh9rzU3TtBKwk8ZjFANZQsHhwSo+vGDdHBuXNqNmfBf3Q==
X-Received: by 2002:a05:690c:25c2:b0:6ef:48ac:9d21 with SMTP id
 00721157ae682-6f9b29230cdmr120600937b3.24.1739199016394; 
 Mon, 10 Feb 2025 06:50:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc073fsm16628057b3.99.2025.02.10.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:50:15 -0800 (PST)
Date: Mon, 10 Feb 2025 08:50:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 25/29] efi: Generate the app as a shared library
Message-ID: <20250210145013.GF1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-26-sjg@chromium.org>
 <20250209181404.GW1233568@bill-the-cat>
 <CAFLszTjBVFY5AnscRhCa9St+mi9zfSdeeTMEStNcgnjRUGSigg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3KyQgI+tyjy9RgMP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjBVFY5AnscRhCa9St+mi9zfSdeeTMEStNcgnjRUGSigg@mail.gmail.com>
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


--3KyQgI+tyjy9RgMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 02:04:22PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 9 Feb 2025 at 11:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 08, 2025 at 10:11:45AM -0700, Simon Glass wrote:
> >
> > > The app should be built as a shared library, with position-independent
> > > code and the -shared flags. Update the Makefile to handle this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  Makefile | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index f989c31073f..b3b13e29c26 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -452,9 +452,13 @@ KBUILD_CFLAGS +=3D $(call cc-option, -no-integra=
ted-as)
> > >  KBUILD_AFLAGS +=3D $(call cc-option, -no-integrated-as)
> > >  endif
> > >
> > > +ifdef CONFIG_EFI_APP
> > > +KBUILD_CFLAGS +=3D -shared
> > > +else
> > >  # Don't generate position independent code
> > >  KBUILD_CFLAGS        +=3D $(call cc-option,-fno-PIE)
> > >  KBUILD_AFLAGS        +=3D $(call cc-option,-fno-PIE)
> > > +endif
> > >
> > >  # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
> > >  UBOOTRELEASE =3D $(shell cat include/config/uboot.release 2> /dev/nu=
ll)
> >
> > This should be tidied up with x86 being updated as well. In fact the
> > comment there isn't entirely useful as we still pass that with
> > CONFIG_POSITION_INDEPENDENT=3Dy.
>=20
> They are slightly different things.

Yes.

> POSITION_INDEPENDENT - controls how TEXT_BASE is figured out before reloc=
aiton
> position-independent code - tells the compiler what to do. and we want
> this so we can relocate at the end of board_init_f()

All I'm saying is that the comment in the Makefile is wrong. We pass
-fno-PIE when building CONFIG_POSITION_INDEPENDENT=3Dy.

> I can enable POSITION_INDEPENDENT in the ARM EFI app (like it is in
> x86, probably erroneously). Yes it gets rid of TEXT_BASE, but more as
> a side effect.
>=20
> Perhaps POSITION_INDEPENDENT should be called POSITION_INDEPENDENT_F ?
>=20
> Or perhaps it can have a dual meaning?

I confused things by commenting on the existing comment being wrong, no
need to try and overload the POSITION_INDEPENDENT symbol.

> > Setting flags should also likely be handled in board/efi/config.mk.
>=20
> Oh yes, good idea.

Thanks.

--=20
Tom

--3KyQgI+tyjy9RgMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqEiUACgkQFHw5/5Y0
tyx82gv/e+fCM3j7q7XoPSaT7HhTxhGYANF+pkVK4knnWXSgFL4Hb6ntWw9QwXWe
dqLwUAgg5+NvfONPy4uyapv7FKSaO3ydAHy6WjgSRfbxVLWwEfH93jk3oONNrDZL
oBXtenS8TLWMmXH5UdiGnwLn63xgIKFQas41v1RoC3wu9baN8rczwhItHWJHprxF
6anpx8yhvMBWgJgz+QFPItqIwNTzBnKRp4eOvLYW+1ZEfbsYK6Q4gErfnbwCDMpQ
h3SsEWPSrg/P8YY4xLX0sRjWCxq0QTZ/GXjyhW2KgCuAG5ITg03LHds/aTUqhdUQ
X7LLJmlLG/yPk/5jdLxVBy3AZnm1uA34tkblRxmC8S5NzUJncwsssk3oJs86CpoM
c/dVZatoQSvRgmQWG2TDCL2NzVk9qOXvZjLOvWfuJjblg6IKDBLoelFY3LUMvAt8
hJJ0rKroC17XpsRYDd/JPMSduh+u/Cc8Yhzuf7oRVIqjSgL2xpA5i8S+7QQcivIu
l4bEzzbs
=8aut
-----END PGP SIGNATURE-----

--3KyQgI+tyjy9RgMP--
