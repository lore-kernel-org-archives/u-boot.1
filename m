Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F81ACDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 18:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEC48460E;
	Wed, 24 Jun 2026 20:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OmI3BlXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D43847C8; Wed, 24 Jun 2026 20:19:32 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C0280398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 20:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a11f19fcf6so929381eaf.3
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782325169; x=1782929969; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I1ONeqIS0Kv9szY8PCTMDatEhdIeJJOTN4n9S86pE2Y=;
 b=OmI3BlXA7zrpLbGnwhXO8PyR/+6BYKMQ7UT++a1jc79Cc0XJ+A1nInlDd8KQaGhKyj
 r8pcmUelds5QnA7uyUrzzXfqsdcciixYxk/6V8+afUvgIt/xooAWVyvzZQsM61isduBc
 B5KplvZ3WT2g5+vgQSxH6pOlXlAaDcqx6SooE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782325169; x=1782929969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1ONeqIS0Kv9szY8PCTMDatEhdIeJJOTN4n9S86pE2Y=;
 b=hIQQSGMCb4Hn/md49U9o8i3Z+ebU1hgJWmO/Ye+9Cs06lu0o1SyQL8GIzbSjJ7PR6a
 6zhKeV27dEOuoNT4sGOwZqo+1J/ft0SDN+QszXHL5E6o16+PtTryfRDTu6T3+YyPqlZn
 qVep+NBjZ3+Pb8DHn34c4StUBQ0/O/+FEE+9v3a7bc3b70Jg3JCz86jyJHBb1JJvxI5b
 m3dzp88a4H8C8HQUT6L5FDGkjk5c/nVbzLVZG+rUNplNxMQ11NhhuTBh2MEHFdkl15kQ
 zc3dpaYuqN2npjeeBgIfGaUalIA9EMr8FUPnvKEW/XlXIxrFJ9p5xbK4K7V5KrKisALs
 BhRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9I14ItsAfn6KwdFv4O0XeVzH4xLTk6uiv05yepAd4JHhLBbpHnkdrYUoyZFazNnln9zFUzms=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/x2x692w2KjjmxRo16nAmyZQb+75Q2teF2glubcD4tr7+KqR7
 0JlgslRoWf7FC9eIUmC+47VpMftWBCUVgKlAVi3+G7/n5q6VSHXZe7Jl9VNZJmk5a9U=
X-Gm-Gg: AfdE7clb8hOHmiGJyCsAOfb3OveoE2uy1dmOSU7V7+fBCQsaHLkJ0eW7E6oBqJ+TeUf
 BCOfKr5uLmeL5CYJ6C3mX3r3jN16rnP5pnQzWQlQ34enrWVALW+i/khwxFEXbSHhQrTbq7yO3yH
 FcBRdE54x7iKXjz2fJfEN7M/Uls2cPK9+JKFMKULbqGF9ITcSWAwc+tzV1mORV+L5APJczDfpv+
 acwMdA1aAjou9ninNoCH4KnpDppFOyTSLf6xfpEoJgSGuN5xiQkQ7uDJpp+R11s1hgDDAcyAte6
 4ZWbnNui+Ln9+L2q0z60c41FZqw5LOal1rJu0dYJy2fauWvwPMl1DhqDZYCaRfCLw7zMPUzl24T
 L0w16IzD82Q3B06CXVv/+ZU1lt9bAgkKiDytwYlMMyrBnJ1SOnUb5/LQbpmWcZQLpoJBneWKRTT
 pwz8+iQF/kQEwQHqtQI4lqHHxbBG/xv2zxyadK4vVB0f6TalIgKxytI0t8YwvXdkxjwDpHdKvc
X-Received: by 2002:a05:6820:2222:b0:6a1:2295:f476 with SMTP id
 006d021491bc7-6a12295f6f3mr3132966eaf.13.1782325168892; 
 Wed, 24 Jun 2026 11:19:28 -0700 (PDT)
Received: from bill-the-cat ([145.14.135.239])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472f04236fsm9914613fac.14.2026.06.24.11.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 11:19:27 -0700 (PDT)
Date: Wed, 24 Jun 2026 12:19:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
Message-ID: <20260624181925.GP382693@bill-the-cat>
References: <20260520201218.3752042-1-sjg@chromium.org>
 <20260522170328.GU1858239@bill-the-cat>
 <e56cb70e-1a66-4ebf-8014-7fd6be9c69ef@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/MVx47pRlMyXeUjk"
Content-Disposition: inline
In-Reply-To: <e56cb70e-1a66-4ebf-8014-7fd6be9c69ef@cherry.de>
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


--/MVx47pRlMyXeUjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 07:35:49PM +0200, Quentin Schulz wrote:
> On 5/22/26 7:03 PM, Tom Rini wrote:
> > On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:
> >=20
> > > U-Boot has had a getopt() implementation for over five years but it is
> > > not used much; most commands hand-roll their own argv loops to spot
> > > -x style flags. The env export and env import sub-commands have the
> > > gnarliest of these parsers in nvedit.c
> > >=20
> > > Each one walks every -prefixed argv element by hand, opens an inner
> > > loop to split grouped flags and tracks a counter to catch a repeated
> > > format flag.
> > >=20
> > > This short series converts both sub-commands to getopt(). The mutex
> > > check for the format flags is done after the option loop, since it is
> > > a per-command rule rather than an option-parsing rule, and the traili=
ng
> > > positional list is read straight out of argv from gs.index onwards.
> > >=20
> > > There is no functional change. getopt() stops at the first non-option,
> > > just as the hand-rolled loops did, so options still have to appear
> > > before the positional arguments.
> > >=20
> > > Each command gains a 'select GETOPT' so the parser is linked in on
> > > boards that do not already enable it.
> > >=20
> > > For firefly-rk3399:
> > >=20
> > >    03: cmd: nvedit: Use getopt() in env export
> > >       aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
> > >    04: cmd: nvedit: Use getopt() in env import
> > >       aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
> > >=20
> > >=20
> > > Simon Glass (2):
> > >    cmd: nvedit: Use getopt() in env export
> > >    cmd: nvedit: Use getopt() in env import
> > >=20
> > >   cmd/Kconfig  |   2 +
> > >   cmd/nvedit.c | 186 +++++++++++++++++++++++-------------------------=
---
> > >   env/common.c |   2 +-
> > >   3 files changed, 85 insertions(+), 105 deletions(-)
> >=20
> > For the record, here's a link to v2:
> > https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.or=
g/
> > And here's the full size change for firefly-rk3399:
> > Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
> > 01: arm: Fix typo in linker script
> >     aarch64:  w+   firefly-rk3399
> > +(firefly-rk3399) Image 'simple-bin' is missing external blobs and is n=
on-functional: atf-bl31
> > +(firefly-rk3399)
> > +(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-=
bl31):
> > +(firefly-rk3399)    See the documentation for your board. You may need=
 to build ARM Trusted
> > +(firefly-rk3399)    Firmware and build with BL31=3D/path/to/bl31.bin
> > +(firefly-rk3399) Image 'simple-bin' is missing optional external blobs=
 but is still functional: tee-os
> > +(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os=
):
> > +(firefly-rk3399)    See the documentation for your board. You may need=
 to build Open Portable
> > +(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build w=
ith TEE=3D/path/to/tee.bin
> > +(firefly-rk3399) Some images are invalid
> > 02: cmd: nvedit: Use getopt() in env export
> >     aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
> >              firefly-rk3399 : all +883 rodata +199 text +684
> >                 u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
> >                   function                                   old     ne=
w   delta
> >                   __getopt                                     -     52=
0    +520
> >                   static.bdinfo_print_all                      -     32=
4    +324
> >                   print_eth                                    -     23=
6    +236
> >                   print_bi_dram                                -      9=
2     +92
> >                   getopt_init_state                            -      1=
2     +12
> >                   do_env_export                              548     47=
6     -72
> >                   do_bdinfo                                  588     16=
0    -428
> > 03: cmd: nvedit: Use getopt() in env import
> >     aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
> >              firefly-rk3399 : all -27 rodata -55 text +28
> >                 u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
> >                   function                                   old     ne=
w   delta
> >                   do_env_import                              668     69=
6     +28
> >=20
> > And so this is why I'm just deferring this until someone has the time to
> > pick up and address the underlying problems with this potential
> > migration that have been raised in the previous iterations.
> >=20
>=20
> Chiming in because I was put in Cc...
>=20
> Do I understand correctly that this only impacts U-Boot proper? If so, is=
 a
> size increase in proper that much of a blocker? As opposed to xPL which
> usually resides in SRAM, I'm assuming U-Boot proper would run in RAM wher=
e I
> hope an additional ~700B shouldn't be too much to ask for? The issue howe=
ver
> could be on the storage medium where U-Boot proper is located, maybe this
> gets the binary above the max space allowed for U-Boot proper to be stored
> (e.g. on some of my boards I'm (self-imposed) limited to 2000KiB) though =
I'm
> assuming it could be less than 700B if U-Boot proper is compressed for
> example. But I'm also lucky enough to have storage space and (D)RAM to sp=
are
> on my boards.
>=20
> Out of the RFC, I see the strlower() part as being separate from the rest,
> maybe that's something we could revisit separately? Reading the cover
> letter, we should even spare 60B with that alone, with the added benefit =
of
> easier maintainability?

This was just impacting U-Boot proper. However, it showed I think two
sets of problems. The first of which is that there was an expectation
that switching the code should result in some sort of savings,
somewhere. And it didn't. And we do have boards where the space between
the end of U-Boot and the start of the environment is small and so
global changes that aren't just bug fixes need careful consideration
(and they've already turned off things that aren't needed for them such
as EFI loader). The second thing was that the code wasn't really easier
to read / follow. So I don't object to the concept but I think the
outcome of this series was that our getopt needs to be looked at in a
bit more detail, and figure out if it's really designed the way we need
it.

--=20
Tom

--/MVx47pRlMyXeUjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajwfrQAKCRAr4qD1Cr/k
CnRQAPwI6dkZNn1LewswJR9JFipTlO1jkenroM/J1F9fXzn1dQD9ERexz86fE2I3
bekf/8zBembeLKrU4pC0ynJBsLBi6ww=
=Qu5f
-----END PGP SIGNATURE-----

--/MVx47pRlMyXeUjk--
