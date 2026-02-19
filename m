Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B826E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 14:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA67E83D8A;
	Thu, 19 Feb 2026 15:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YoYIc4PS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB48D83D8A; Thu, 19 Feb 2026 15:04:29 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9949B83CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 15:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46394090d2fso296407b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771509866; x=1772114666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EW+LBPdd0vNd6Vo2Nm5e7/fsUWPclSHEOeI5a3MjZOU=;
 b=YoYIc4PSICbhK9iINylZtJVi9M+UclCP42iZae9awuPiAPDeqtMG4XgXMiTg+06WcN
 7RbSRwe8wm8cV0nGSPf7Sy9blk0iUewRtL6+T1xp/w47bK7vstwzoBUT+SuXhZv0oWSg
 slTTe8l9MBCNcHjc8w3fQSU7IkZXkNkyZU/hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771509866; x=1772114666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EW+LBPdd0vNd6Vo2Nm5e7/fsUWPclSHEOeI5a3MjZOU=;
 b=u7cEz7C3rOfTXnRHPTXqgme2b25pBky+15nhob85JSIFNjjBxHkAbJZ3kiX9rw7VOV
 /3bxu5KE7ekzWf4bSYanq3inIVBhQ5PgkR++zISDJONaY2Hq2Y4dJxh4jXXTs9NivXrH
 gjfW7XF2YBdyqgELXIsrhc4veYK64Z2A7lFZmbEFR2Z1lD/aSm+ndEzbXvK1nmP5cfuM
 4zpk1ntxXGqXWnQivqnKtffqlQXOZXWQwf8VsF865fybAQrH5vCWCsOR/xc6W5PUJ02M
 ZWJMF9+wNsNzs5lgCeVsL+8DjvCs8kI/iv5JMGyZQCqHP1lO2rvBD2ZAYNbubh20N29T
 HQnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjSk7S0q9bQaP8ZOasGcTfGykuRk/JrEIXUnzYahSztktHbZYlBMuzV9F4liiypl/2Gw8/ilY=@lists.denx.de
X-Gm-Message-State: AOJu0YwQRGnGga4tMVov5sVCVvt0hl0rzbpLe2mqRV50f5VutXt7dsTx
 5eKIMQGOq+JfXYaW+kGYFsduWbqDpQ2j1letnog0j8pktMHCiJDFmiCRNvwHAha+g3U=
X-Gm-Gg: AZuq6aKCeNgF7P0FFJWV9TlJk7eCbxI2w813QjAYroithfaUU57IyWzlDmoTiPdOG9Q
 swh7JP7DYl+cznbR+BPUsg+rxt6ro+Rm4KiJPO85TU/7tAwiTuSxuTp32M4nNwwZ+ZhmzoE8GK8
 B+to3Ssa2K0uuOpPcHYFTN2MgFmF1EEk+bBRIbOIEy6ng1AdCkBC9DklTJ6+ig5LuO41qoYPBAZ
 WIbAAKnFGvZfeumU2fslnVBh7taWmSghiLUh0yfgfpNBgzjkcm5P0rxzgeeG1t93b0A1YfnfWRb
 1NkYw3NP4xtV31DIFv4Nxnm0xe2u2s8uFrEGDuYrlP0jEHlZY1wPOeqduQPvLcgVZPv/uhTP9hK
 BuBiMr66+PM6CbXWLMiAbxzftaWVTqwEaU4/O92Yqe1a7DANcQT8EboOaAu/4iiGl3/T7FXO6rm
 Zz1c59WPcmwKU9wvfqCJrSrbPlx6U69gIRvQMhI6t43ffJkvfGZ2JOnT6KDFi6wPc/61t6cBhKu
 jVpJy4Vg2ZVvYo/yY4wZIHrmOKzIi74cod+xFgMrRLGYoy3qYA=
X-Received: by 2002:a05:6808:221a:b0:45c:8f03:1e18 with SMTP id
 5614622812f47-463b403c71amr8834703b6e.44.1771509865943; 
 Thu, 19 Feb 2026 06:04:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b0cf66dsm16080656b6e.19.2026.02.19.06.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:04:25 -0800 (PST)
Date: Thu, 19 Feb 2026 08:04:21 -0600
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
Message-ID: <20260219140421.GJ3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
 <CAFLszTh3FiMF+eCSxHq7b6hszKphWxyZZpeKrfPAAqEseLhNdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Acr1emZ4QxFdUwqk"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3FiMF+eCSxHq7b6hszKphWxyZZpeKrfPAAqEseLhNdg@mail.gmail.com>
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


--Acr1emZ4QxFdUwqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 06:10:58AM -0700, Simon Glass wrote:
> Hi Daniel,
>=20
> On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add unit tests for the image_loader framework covering its core
> > logic with a mock storage backend:
> >
> > - map() allocates, reads and records a region
> > - map() returns cached pointer for already-mapped range
> > - map() returns correct offset within a larger region
> > - map() re-reads when extending a region to a larger size
> > - map_to() reads to a specified address and records it
> > - lookup() returns NULL for unmapped ranges
> > - alloc_ptr advances with correct alignment
> > - map() returns NULL when the translation table is full
> > - cleanup() calls backend and resets state
> > - map() with multiple disjoint regions
> > - read beyond image size returns error
> >
> > Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
> > and default to 16 unconditionally (the previous 'default 0' fallback
> > caused the regions array to be zero-sized when IMAGE_LOADER was
> > enabled after initial defconfig generation).
> >
> > Register the new 'image_loader' test suite in test/cmd_ut.c so it
> > can be run via 'ut image_loader'.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  boot/Kconfig             |   4 +-
> >  test/boot/Makefile       |   2 +
> >  test/boot/image_loader.c | 429 +++++++++++++++++++++++++++++++++++++++
> >  test/cmd_ut.c            |   2 +
> >  4 files changed, 435 insertions(+), 2 deletions(-)
> >  create mode 100644 test/boot/image_loader.c
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 1f870c7d251..efc06f3cd1a 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1179,8 +1179,8 @@ config IMAGE_LOADER
> >
> >  config IMAGE_LOADER_MAX_REGIONS
> >         int "Maximum number of mapped regions in image loader"
> > -       default 16 if IMAGE_LOADER
> > -       default 0
> > +       depends on IMAGE_LOADER
> > +       default 16
> >         help
> >           Maximum number of distinct image regions that can be mapped
> >           into RAM simultaneously. 16 is sufficient for typical FIT
>=20
> As Tom mentioned, this is in the wrong patch. But really we should
> just remove it and use an alist

Lets not have another argument about your alist stuff please.

--=20
Tom

--Acr1emZ4QxFdUwqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZcYZQAKCRAr4qD1Cr/k
CgksAQDcTk4W7oTCU4AtSMk5CFnY0jnpy2C+6yk4P/bkrF46TAEAt8ZAFqbDPQ/W
e1sRzFlYRSKLccUgGKstHiQKgENteAE=
=Ldqt
-----END PGP SIGNATURE-----

--Acr1emZ4QxFdUwqk--
