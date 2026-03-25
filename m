Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62772109C057
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C376F83DA6;
	Wed, 25 Mar 2026 20:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gDU43POS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BA283F6D; Wed, 25 Mar 2026 20:53:44 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D531283A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d8b2703f37so166583a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774468420; x=1775073220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JUhfvVooYjZR+hDYLYGquvPoI3t7JF3lJVJwOQYZFKs=;
 b=gDU43POSlZgAKk3nKUaiJv+gpOspSWOKKtowBMGFszgnQf0jSIuZ6I+8L4zZk97vEZ
 ysvQ+/+mvu34keP3mVeQpQSqBZJBomABO7BPTkzvis5Nl/UQjzITiaRHObNeNaGT5jeQ
 K9IU+8KcP4GZZ1Zwv+sJhdO3RvTHXLIVkmUrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774468420; x=1775073220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUhfvVooYjZR+hDYLYGquvPoI3t7JF3lJVJwOQYZFKs=;
 b=n1SDAX4cDxDaTEtoa8RXQS6qeEtkwoE3YyJrqqo27df2YziScF4u+y3jv1ju/pcf8X
 TRDF0x0IEmuQR2uksRgPhOUy82KuXcqSPgf2+6++BbEL/LIn2zGgMd4t+4RiEeheqMzo
 LNMrQiV9ICezPNbDQv+AsdjtptQ8KK1546l8UgWTrpdRAU8jUqn31+KQwWToBNQOYJnv
 KYATQ5+XsOwJiq2Rkmv99R/cpAHKxE+2grgYT/qU4+3opUY0dUeHErtP4l7w8SrbHz7y
 4rZhgoZqU2RYtix1LvXxXdasU9cSpH2LtqHS4CiM9KtmYoiK7rYnADsPK9K9IL/u0p8l
 1QAA==
X-Gm-Message-State: AOJu0YzRwm7SVK35GpgkM8gE497H4j5sZrqv64fcrD967tafAuHdXVVl
 k3oZcxN4bUZaL1gK/VthArjGlQn4bhucoHPv/jgE/sv189Oo6pHsTG4ebyQ4z3SrI/M=
X-Gm-Gg: ATEYQzyQZLftFPEj8pMMItdft+KgK2f6Ve7Epz3SH7GIzAxU1c7/G+6Q3KJS4cuRhqt
 ZADhot3u7wuhBrkuW0A+ITbXxHbjxrgPpD/jzf0FYLqwZtgahLoq/LUOgOv07QN+GT0qAXnNojf
 1s0u8FioYXAzwyi0UUPLmnwEf+R4TugBTSuLN5v71ki9btcY5f5wK3QKECX9aeVzeCmJe2bA7Mi
 EH7fCEjKkvdZ+aBmWtzuamflzbfVAGDsQrg2sUeIHjBsBGYFRkhl5fz6ZjjPi3F07ohdc1oCdsu
 z/VgkR7xa6US/y+HcWw62mRiQvBQqlx7LOqtOP9cCEQfQqhuKratb0Q5sKTNY5wG10g8gmCK64S
 o97LCL6J/fbtUxo2ApXJtHVkUe51imi1H6aoC08ZKNptQClJP0WCxCDqtlls85H8hqWam58HE4d
 D6lb0p+PxUx3Gztu8AGEkNzos/2/HqWf/8IUjG3b49qLFibMBMH8rbewRXgtf6ANxs6wMms5ZUP
 7adDZGaK600ANiPB7STwHyguNY6snQdvuSt5/OGCkZjUaYi
X-Received: by 2002:a05:6830:380f:b0:7d7:f90c:5833 with SMTP id
 46e09a7af769-7d9d69d0c5cmr2384609a34.27.1774468420515; 
 Wed, 25 Mar 2026 12:53:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e71f5ab2sm480687a34.18.2026.03.25.12.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:53:39 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:53:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
Message-ID: <20260325195337.GY502704@bill-the-cat>
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
 <20260325171540.GU502704@bill-the-cat>
 <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
 <20260325182619.GV502704@bill-the-cat>
 <CAFLszThCO2a1COB8kBwYfTXM65AGJEugo9MWZAjphQNuX16Y-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F+jMOzaAK/fmICJV"
Content-Disposition: inline
In-Reply-To: <CAFLszThCO2a1COB8kBwYfTXM65AGJEugo9MWZAjphQNuX16Y-Q@mail.gmail.com>
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


--F+jMOzaAK/fmICJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 01:21:54PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Mar 2026 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 11:57:17AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 25 Mar 2026 at 11:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > > > > > The generated .S files for fonts, splash screens and EFI apps=
 use
> > > > > > > .incbin with the full prerequisite path. When building with O=
=3D this
> > > > > > > bakes an absolute path into the .S file. If the build directo=
ry is
> > > > > > > later used on a different machine (e.g. in a container), the =
assembler
> > > > > > > cannot find the source file.
> > > > > > >
> > > > > > > Use $(src)/$(notdir $<) instead of $< so the .incbin directiv=
e contains
> > > > > > > a source-relative path like drivers/video/fonts/nimbus_sans_l=
_regular.ttf
> > > > > > > rather than an absolute one. Add -Wa,-I$(srctree) to the asse=
mbler
> > > > > > > flags so the assembler can resolve these paths.
> > > > > > >
> > > > > > > The DTB and DTBO rules are left unchanged since their prerequ=
isites are
> > > > > > > generated files in the build directory.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  scripts/Makefile.lib | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > This is generic kbuild infrastructure now. Is there a fix we're=
 missing
> > > > > > from upstream, a change we haven't pulled in yet (as we need to=
 keep
> > > > > > syncing upwards) or a problem upstream too? Thanks!
> > > > >
> > > > > Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
> > > > >
> > > > > echo '.incbin "$<" ';
> > > > >
> > > > > But Linux only uses generated files in the build directory, never
> > > > > actual source files. The font/splash/EFI .incbin rules are U-Boot
> > > > > additions that aren't in the upstream kbuild. So Linux doesn't ha=
ve
> > > > > this problem.
> > > >
> > > > Shouldn't we be generating these files in to the build directory to=
o?
> > >
> > > These are actually source files, e.g.
> > > drivers/video/fonts/nimbus_sans_l_regular.ttf
> >
> > So, the first thing then is that S_ttf is a local U-Boot rule. Lets
> > start by moving this out of scripts/Makefile.lib to
> > scripts/Makefile.lib-u-boot as that will make future re-sync work easier
> > (and is something we've talked about in the re-sync threads, splitting
> > U-Boot specific stuff out to new files). Then 2/2 of that series can be
> > this change, thanks.
>=20
> Almost, but I still need the a_flags change.

Think a bit on how to solve that without touching the files that we
really want to have no delta with upstream on please. It's 5 files,
adding AFLAGS_foo.o +=3D ... to the fonts Makefile and a note doesn't seem
bad and reduces the chances of the a_flags part being lost in a future
resync to zero.

--=20
Tom

--F+jMOzaAK/fmICJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQ9QQAKCRAr4qD1Cr/k
Cn8iAP93H9fLBc0r2snx6nZUXtm6ImFzCMqsCeNydbKrxqwwZgD/Qq1dLsYFEfxS
Uar05Hw2WfD4LMhnq6NaaZ6lsq7ApAA=
=vUEt
-----END PGP SIGNATURE-----

--F+jMOzaAK/fmICJV--
