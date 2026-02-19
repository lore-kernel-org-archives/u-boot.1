Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F68E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 15:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EDC83946;
	Thu, 19 Feb 2026 16:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OX5hJCym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F3D83CEE; Thu, 19 Feb 2026 16:41:22 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36888366F
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 16:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4c7d04890so970137a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771515678; x=1772120478; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mu0z5BSK5AN2Z+MRn2BuDEQpErS3XVuYdKj+/4iJNPc=;
 b=OX5hJCymh8CtNblLLyO6k5RtI6GxdN1exQ+NwZZ1nt8X5kIcvfc0n0DV76znSQn3bf
 LwSpaPHrFh6FUHhSVnDefgmAF7zSDcDiCKVlUfdI5BXyt5UpcXewJNPrA0jaKb5M0g+t
 qs5EERGw2bnHM63YfxenG3j3DOPWqVmAKurXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771515678; x=1772120478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mu0z5BSK5AN2Z+MRn2BuDEQpErS3XVuYdKj+/4iJNPc=;
 b=GC9DDDZ9dRRvNE27Wy1XEqNSqzfxf2G3cGD39H7p8bWXc51ZGo0adpXpYrlLtzHhYp
 1b0AHjKsbpAlhAT+4oZ+gHEY5LavtzChu8CJvldiTgPU+wsN5R+tF0PJKH2NuHkutsQS
 GMV84+Ob20lPIx60RvmUf3bR45WuMyIQ414Em0HQBIb0iQOe3kkvFY6IUht8b74fAY5D
 aXjEtVM5UCLWGsTgwppkFwT9nTOKqEyb6TaAoftbTAtjCshAdpz8NKPb3AMdXAgWtID9
 170BGIcZy50dH/6s+VuzhmaA53G8yH/tAQ9Lig+UbrY+ttqsqXgQfP3LKFWOtH20VkSx
 z6Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlLJ4bPXzdbLueu4glgrh4Fmm864w/I2VKi1FX8uriafQ+VgOo0r17U5mkmAgN1Kds/ixk20=@lists.denx.de
X-Gm-Message-State: AOJu0YzM5avHMXunGj/M9pF7iSgNbO/P/zSB/QOQxSuSX92TQU9zyJwT
 1fgbnNB9Og30ynfGYZ7amF49tve5shsQVcpa1a6/AT9rujQunBOs6bst4sn2U3ZLeUw=
X-Gm-Gg: AZuq6aLm2bgPE1Jr8EEUDmnj5Ji76d7qdz49wO0o+nbFMeQnJfKfnfR5hcFWy/fL6ZZ
 PpeESsmAoPx8MfdZleBpktY68Aw8FHjE5eQfVu1nOFOOTW3O5Rp0ljJiHBnfygXHOVQlsDBtObf
 zyGciqko+D0+fFb/lG9mBEkWrKZkh5mtSnwoszi4igfr4I2ELxaSvRQTRw34nknDKj9IztDtstS
 a7NpVnAqkLdrvtX4rj2RyJ7G0WrSG4Kz4r+O3Pb4Tg/4y2FG9xfGHQ2SJ1bwAd/t+GT6L0ePWvU
 BH/mnzUeA40omMEiUR/8Gg+BbVSvsnk0T8qnI8vZ0vr4cBY7Ydf74V6PSiUZJQhHd7Bwu2j03Ss
 S/1TWPpcjnXbNJPCHNqAykbNlHz3T9cKfDPonJIBhPYBclMUfC8oBfXK0Wd19QWlPPsjHY2Cxli
 VBVpKFJkJ0rFB4eG2tocd7PTtUAg2Gf/hs5K1a2/svLSFheRVeY/WF5IByrIk32F+hGfuAP/xUn
 ZXkrErOE4xrQ3O2STPHKtQj/+dzNqN870oCOLjFJGUC6qwSQKc=
X-Received: by 2002:a05:6830:6aeb:b0:7d1:4608:a2cc with SMTP id
 46e09a7af769-7d505db712dmr4203985a34.12.1771515678461; 
 Thu, 19 Feb 2026 07:41:18 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7720a95sm19763963a34.29.2026.02.19.07.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 07:41:17 -0800 (PST)
Date: Thu, 19 Feb 2026 09:41:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 11/20] test: boot: add image_loader unit tests
Message-ID: <20260219154114.GM3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
 <CAFLszTh3FiMF+eCSxHq7b6hszKphWxyZZpeKrfPAAqEseLhNdg@mail.gmail.com>
 <20260219140421.GJ3233182@bill-the-cat>
 <CAFLszTjkdArCnEWPc5MkA1rVH1xnTvyQ+eeeWRkXiPPuSkbvwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+npyNlChtAjuIxEr"
Content-Disposition: inline
In-Reply-To: <CAFLszTjkdArCnEWPc5MkA1rVH1xnTvyQ+eeeWRkXiPPuSkbvwg@mail.gmail.com>
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


--+npyNlChtAjuIxEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 07:34:21AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 19 Feb 2026 at 07:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 06:10:58AM -0700, Simon Glass wrote:
> > > Hi Daniel,
> > >
> > > On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wr=
ote:
> > > >
> > > > Add unit tests for the image_loader framework covering its core
> > > > logic with a mock storage backend:
> > > >
> > > > - map() allocates, reads and records a region
> > > > - map() returns cached pointer for already-mapped range
> > > > - map() returns correct offset within a larger region
> > > > - map() re-reads when extending a region to a larger size
> > > > - map_to() reads to a specified address and records it
> > > > - lookup() returns NULL for unmapped ranges
> > > > - alloc_ptr advances with correct alignment
> > > > - map() returns NULL when the translation table is full
> > > > - cleanup() calls backend and resets state
> > > > - map() with multiple disjoint regions
> > > > - read beyond image size returns error
> > > >
> > > > Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
> > > > and default to 16 unconditionally (the previous 'default 0' fallback
> > > > caused the regions array to be zero-sized when IMAGE_LOADER was
> > > > enabled after initial defconfig generation).
> > > >
> > > > Register the new 'image_loader' test suite in test/cmd_ut.c so it
> > > > can be run via 'ut image_loader'.
> > > >
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > ---
> > > >  boot/Kconfig             |   4 +-
> > > >  test/boot/Makefile       |   2 +
> > > >  test/boot/image_loader.c | 429 +++++++++++++++++++++++++++++++++++=
++++
> > > >  test/cmd_ut.c            |   2 +
> > > >  4 files changed, 435 insertions(+), 2 deletions(-)
> > > >  create mode 100644 test/boot/image_loader.c
> > > >
> > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > index 1f870c7d251..efc06f3cd1a 100644
> > > > --- a/boot/Kconfig
> > > > +++ b/boot/Kconfig
> > > > @@ -1179,8 +1179,8 @@ config IMAGE_LOADER
> > > >
> > > >  config IMAGE_LOADER_MAX_REGIONS
> > > >         int "Maximum number of mapped regions in image loader"
> > > > -       default 16 if IMAGE_LOADER
> > > > -       default 0
> > > > +       depends on IMAGE_LOADER
> > > > +       default 16
> > > >         help
> > > >           Maximum number of distinct image regions that can be mapp=
ed
> > > >           into RAM simultaneously. 16 is sufficient for typical FIT
> > >
> > > As Tom mentioned, this is in the wrong patch. But really we should
> > > just remove it and use an alist
> >
> > Lets not have another argument about your alist stuff please.
>=20
> Then perhaps another type of list that can grow as needed.

A problem to worry about later, yes.

--=20
Tom

--+npyNlChtAjuIxEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZcvFgAKCRAr4qD1Cr/k
Chh4AP9lU2OQTJ9iiZIhmKGSGsLgl/kEo9Cv1pclfFmfuMLWRgEAiqh6BqYI4fRi
gvLzdGFiyFxmh5xK2vALMR70o6NlxQs=
=dBoC
-----END PGP SIGNATURE-----

--+npyNlChtAjuIxEr--
