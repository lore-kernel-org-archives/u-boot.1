Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08666CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6CE86F93;
	Wed, 18 Oct 2023 14:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dBFbn7zU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8568386F94; Wed, 18 Oct 2023 14:43:20 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7048586F92
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7be88e9ccso85206047b3.2
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632997; x=1698237797; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F7UJ8m+IJ+A1KqZLlUSdbXGd6xpQJ94Ladgc8ximp0U=;
 b=dBFbn7zULsFVIy4a+ij67FzZS+s8Pw1asAKvFo0ifaM83ioabaAVH+ExCPLnHXMvGf
 aDZ1esyTu99Kf+j1XuAnMsx71IAnnRwpDzqqcjhhX0Dq4J3fgHdxEozE9zWpIKt3tVlK
 DIVcNRb+THUbIysAq4IR7mcj9RK4arqdKP/5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632997; x=1698237797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7UJ8m+IJ+A1KqZLlUSdbXGd6xpQJ94Ladgc8ximp0U=;
 b=kxIDV3TqiZnbAagvtzKJ2XW4IT/jc1sL/EnIMLbEBhlYAil4HULgH/vhCmjH6PuGr8
 eoHHTOaYRODzEW3gCwyiVAg+jhZkuBwzC7C1DJL+kC9u4gilgbLbRsqyCRS2XG34mRH7
 DUcWnHecfAham5WAdvM+SSdRA1MHa1L1TZtMM9fxc9FQtfqK226aSk4DdAyikNn1+RGQ
 cjw4pYahaedZjftNbY3fvt0fB291lIvxn0CIpavhCbGCA02rigcgvvuZ3zQMU8u2jhBo
 V/0wBd4NV3BUM4wDrkCJrePGfIbLfo1vxWyOTzq0GZGvwlt1uVwEbS/b5WLushpgDGuq
 hTQQ==
X-Gm-Message-State: AOJu0Yz8O0rgNeEAlLtVR067JpVybwjVZV2WWJGoKANISKzzlL6wQsam
 lqZgtunJn9CLpoWinVRvxF0KRQ==
X-Google-Smtp-Source: AGHT+IGcbU4+al46ZQVXHZmB9JSVDGjPqIiZk1nQaDj1nMNposWLl6qrZWd0iLYGC3HNeDdHimDYKA==
X-Received: by 2002:a81:92cf:0:b0:5a7:cc14:9e40 with SMTP id
 j198-20020a8192cf000000b005a7cc149e40mr5493228ywg.5.1697632996781; 
 Wed, 18 Oct 2023 05:43:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 m7-20020a817107000000b00589b653b7adsm1469339ywc.136.2023.10.18.05.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:43:16 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:43:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231018124314.GQ3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
 <CAPnjgZ3QDBJSmdOc=DMOUur0NgbytfWC6SQMNLs9_zX4WCFDqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4dUsSD08C3ojLiFD"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3QDBJSmdOc=DMOUur0NgbytfWC6SQMNLs9_zX4WCFDqA@mail.gmail.com>
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


--4dUsSD08C3ojLiFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:31:34PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Tue, 17 Oct 2023 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> >
> > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet=
 is
> > > available, add it as an explicit dependency.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > >
> > >  lib/efi_loader/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 13cad6342c36..fca4b3eef270 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > >       depends on BLK
> > > +     depends on DM_ETH
> > >       depends on !EFI_APP
> > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
> > >       select CHARSET
> >
> > Does this work for you Heinrich, or do you want to clarify the
> > dependencies (and re-organize the code as needed) around networking?
>=20
> It would be great to tidy up networking in lots of ways...perhaps we
> should add ~CMDLINE support to the list of post-lwip tasks if it lands

But this isn't even directly networking.  It's I believe that the
network related portion of EFI loader isn't optional today.  But perhaps
it could / should be?

--=20
Tom

--4dUsSD08C3ojLiFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv0uIACgkQFHw5/5Y0
tyxDgQv+KLP8mvXB4lB2YXmljoyIX3jXLuoEIpy7+X9c61qILA84bGfX3D+vDdfA
Snz2vBNb0ABvUxNeFerUDxZt7ixzS7dgjRYcPQCXmM9TFtbFqXHjzIJfCjkzBnpu
ZsNBJgiAHab5x5t0pO559+GsJk5MPSVFQWmUFuAt3YYihTggb2Mqk1Ls0hZCM3Z+
ycRFR0PivWI9vqrnf6VndC5Kl7YvkhrpvFg3jCGJhBxQwIBv30yAI/A6vSJXoYtQ
bZPG8f6LkN+L4QGMh9Myg2zWAblH8r87lDKuWng2KuvrlTfs9SDOGkevQLORfaHW
YpWK2f2lFEfYcvMJfgwm21CuNyYjsVtBiT0s76MrGyYEZhn+CXq0ccFQ56iSRc+e
x7CNHM5OHmI+lWj0asWrYQVBPbEBd609LE8HkSHT9ghyRqiUcWBuiypAtv66wwSf
B/jFK/NIivGL9QD/lRvXOT+aPhYqMIz34AX6Zk8USA8bH+qrptnemSthj7EVr6/f
wAH0aNe8
=4t8/
-----END PGP SIGNATURE-----

--4dUsSD08C3ojLiFD--
