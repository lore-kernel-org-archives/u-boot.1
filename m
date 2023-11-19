Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21DDC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA5987174;
	Sun, 19 Nov 2023 21:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LwyoZZKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8443A86F80; Sun, 19 Nov 2023 21:28:09 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0E886940
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5c9adcaf514so7655677b3.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700425685; x=1701030485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw8nil8ExBKqzPf3/xCchv0ktaUmnJkHs8M9hYY11U4=;
 b=LwyoZZKNKRe8wKJTHhnvetpiYH3YXKa79/zSXAmJmaXiXrR078jcf7Pl1JfO75+ywr
 fIcEZhLertORoepIgbYBp4/w3RJMS5Avc2UvNJHqKmr2r5NziIO6gJFmgDgYumviZv6X
 46pz0F4P5CyzYCUxYhc1Iaxttt/5GFrlyo3Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700425685; x=1701030485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw8nil8ExBKqzPf3/xCchv0ktaUmnJkHs8M9hYY11U4=;
 b=GGdCToctfvKXbKMHJhLplBD1j/mFkOpT99faTGuqrtyzRktwYEIPeD3HgkrFPF5h16
 66tx5DjVFStOxqWuaZnHTssFic40l22nJ5rE829t0ibphD4do5Afn8sqzMaF+AqFLKxR
 PazIPtsiayBTqrWoDFJ+8jVIMds8d4cmm4TcCRVeIkyDWWRVD6WXHK66UIazobW/Q1oL
 OjiCujGAoCLoG0FP8LuTUzCSSihupfVAYFxCSJcQnI/EqAkF+4HsllTVq21tRfXk99py
 dMt1GIkAsv8fVUicdJB6A1pn3zlBu9RvaXlQ/1sMy29MYLFKHyG9OU8nYMliOI+By04y
 2FsA==
X-Gm-Message-State: AOJu0YwdVSveXr+0n6aGZBPldLjphCvvoEI1B47sjpZAyMeISLGWdBxy
 u8OCLnk9PhCyQkTF9Yqg/P6LH4ZgmKW+56jpfk3Faw==
X-Google-Smtp-Source: AGHT+IHpdJ0la5tsyIX/I0QzsdJSKFn0FMfSAQL/a9keld4z5oANQNjq9AKUvpWGAWxo7LrTmDtEjQ==
X-Received: by 2002:a0d:ff45:0:b0:577:189b:ad4 with SMTP id
 p66-20020a0dff45000000b00577189b0ad4mr6046155ywf.48.1700425685348; 
 Sun, 19 Nov 2023 12:28:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 e81-20020a816954000000b0059b2be24f88sm1891841ywc.143.2023.11.19.12.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 12:28:04 -0800 (PST)
Date: Sun, 19 Nov 2023 15:28:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] global: Clean up arch/*/dts/Makefile
Message-ID: <20231119202802.GF2513409@bill-the-cat>
References: <20231117225214.2144414-1-trini@konsulko.com>
 <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1CJmZgCnO3wDJ/AP"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
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


--1CJmZgCnO3wDJ/AP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 12:09:07PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > With commit 3609e1dc ("dts: automatically build necessary .dtb files")
> > we now have logic that will ensure that all device trees needed in the
> > binary are built automatically. Any device tree that the developer needs
> > while working can still be built normally via make arch/.../foo.dtb so
> > we can simply drop the rest of this logic.
> >
> > Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  arch/arc/dts/Makefile        |    8 -
> >  arch/arm/dts/Makefile        | 1436 +---------------------------------
> >  arch/m68k/dts/Makefile       |   18 -
> >  arch/microblaze/dts/Makefile |    2 -
> >  arch/mips/dts/Makefile       |   37 -
> >  arch/nios2/dts/Makefile      |    2 -
> >  arch/powerpc/dts/Makefile    |   32 -
> >  arch/riscv/dts/Makefile      |    9 -
> >  arch/sandbox/dts/Makefile    |    5 -
> >  arch/sh/dts/Makefile         |    2 +-
> >  arch/x86/dts/Makefile        |   22 -
> >  arch/xtensa/dts/Makefile     |    2 -
> >  configs/iot2050_defconfig    |    1 +
> >  13 files changed, 6 insertions(+), 1570 deletions(-)
>=20
> I can see the motivation for this, but it ends up moving us away from
> driver model and devicetree, IMO. For example, rk3399 and other
> rockchip boards use DT for their init so the same U-Boot can be used
> for all, mostly. Ideally that is the way all boards would be, as they
> are in Linux.
>=20
> But here I have to manually add all the rk3399 boards to OF_LIST for
> each board and enable SPL_LOAD_FIT (and SPL_FRAMEWORK but that is
> fine) to make this work.

How are you doing this today on N rk3399 boards if you aren't tweaking a
CONFIG option to get the correct dtb in to the final binary? That I
think is where we go back-and-forth on stuff like this. If there's
deconfigs that can support N boards, but only list a, or only a few, dtb
files in the right CONFIG variable how do you get it to run on the
others? I know you noted some Exynos platforms it's a simple concat to
make another platform work instead. But I really don't know how common
that is in theory, and even less so in practice. Picking up rk3399, you
need bl31 and op-tee and you can only get those so generic too.

And part of the issue is that with Linux, the "do board specific things"
just gets pushed down a layer, to us. We have to just know X/Y/Z at
build time so that someone else can know it at run time.

--=20
Tom

--1CJmZgCnO3wDJ/AP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVab88ACgkQFHw5/5Y0
tyxDeAwAjCvdGB1+E8Ut/5zavAMZV7cz60C2cipWC9C/tjrJ3ZzobkXKKq5eEoKz
xZk4CHL2nGSZQa5GG7SNoCYduYij3MDv9PUp3cZlJiAsyl70NtD9gNTWQjWtJUHy
OM9J/jVaFdEKNWakTom6VBYsj02B48Hnk8QCepDcPvy+qsxOya5aW6yW0SRyb//3
ZDe4knaSuZnzN/ZJIt9e5teu4e9LMU9rdEDOJzAMQHicOfGa9WMm6lxJVb8S6Urs
PTvwcgb8AylqdEonyDCk/+HOxlCk3VIUdxfUv0RHpz8p7ormVV0C+tCeCpvx5SeC
mG9KVnLDyxyWNVHb2dKAL5KAFmExlHD7ny80t+1QUhmewZkfXK1MNBgj+VRYpYLj
pwS97Oz9K5TI9AEnd6J8wK4sqF+6OPnB3NGQillxu/8UTpjiWWyFR5B38RH27YAE
VfHvS15Zl5WdzzW3SOmOWRE+9Y6nzy6MVO+zlk0vH8FrX7GqfYCOYtaL8c8UuKbg
zG4lfKrd
=0sqb
-----END PGP SIGNATURE-----

--1CJmZgCnO3wDJ/AP--
