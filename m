Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A29CCF9E7
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F26D88363;
	Wed, 25 Sep 2024 19:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RbbXmBoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B76088216; Wed, 25 Sep 2024 19:26:13 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BE188363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9a30a045cso8500585a.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285170; x=1727889970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mKvIVtqYJ1WSpOhhd/TWIkvRPnvYP9fAfAdKmCbk2lY=;
 b=RbbXmBoHUxhISbCzdoVWGzGfrc3RGcAeJz+dxH3B4UYOMTjX3hw3FdmqAIvHGcfvNk
 lDOic3ju2B7pYS2pOLex/6B7jKQJDSdEt8F/hJu5rC7Ew1QqEa0TrhZ+sH4q2fDARhmm
 iljF8AH2xmI2ermOlR4qZ8YUY+M7BD6+GvYec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285170; x=1727889970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKvIVtqYJ1WSpOhhd/TWIkvRPnvYP9fAfAdKmCbk2lY=;
 b=QsO5UPSw5yg4Tyi1ONlBY7561bA7hcI2xsqk/39vU6wc1pqqogNAGBJ+3t/ThZ2GDO
 cWj87Fo+3K9IKn3I+MuG7sUtButGX+hxHdYrk+uVhX1UURIgAw394mE83fRn7RduDLvj
 +vA/s2mkTWkPxZ6glHcgjuAsjE8EDLL6GmppxOAyg5Q3yF8hO4EUZNkuTF2WbqZMM2hT
 R5LHFk7SgQPtQtpU92Em74itZBJ6nV40QOl8STlbF2IrG0sMdXbNVJGAH0ddcDbQJqcI
 1merjkbt4IQtIVeCY/jNHi3iwiLS3AxSMnB7qwQXwiOHCX9c9eQjX5HC5PPNPEozvdoR
 0pfQ==
X-Gm-Message-State: AOJu0YxYjI45mcCNoUan6cyHnk9PJQRrPAAac3sncI+4rinTmr+ftCLc
 NTjmL+Q3PEljvsgxvyBraUUk1WUnmcCBzMwZPYxyXLDg/BBMsJ0gT30pPKL0PoI=
X-Google-Smtp-Source: AGHT+IGUiayhJnoqIUqLyIOy6XSZV2AdJcfwi9LW8GT+K2F4/T310xmKkelhpyM7J9PmTshCzYGlmQ==
X-Received: by 2002:a05:620a:d81:b0:7a9:bcd1:5279 with SMTP id
 af79cd13be357-7ace7403c98mr462716785a.18.1727285170141; 
 Wed, 25 Sep 2024 10:26:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5ccbf4sm191404285a.96.2024.09.25.10.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:26:09 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:26:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 00/19] labgrid: Provide an integration with Labgrid
Message-ID: <20240925172607.GB4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240923203612.GT4252@bill-the-cat>
 <CAFLszThbxYuDeui6PJQpUMr58jvQ=GnxjTK-UWSanU6AGt+cbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G9szjRIOlZwlRr2e"
Content-Disposition: inline
In-Reply-To: <CAFLszThbxYuDeui6PJQpUMr58jvQ=GnxjTK-UWSanU6AGt+cbg@mail.gmail.com>
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


--G9szjRIOlZwlRr2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:50:08PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 23 Sept 2024 at 22:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 08:01:35AM +0200, Simon Glass wrote:
> >
> > > Labgrid provides access to a hardware lab in an automated way. It is
> > > possible to boot U-Boot on boards in the lab without physically touch=
ing
> > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > >
> > > By way of background, about 4 years ago I wrong a thing called Labman=
[1]
> > > which allowed my lab of about 30 devices to be operated remotely, usi=
ng
> > > tbot for the console and build integration. While it worked OK and I
> > > used it for many bisects, I didn't take it any further.
> > >
> > > It turns out that there was already an existing program, called Labgr=
id,
> > > which I did not know about at time (thank you Tom for telling me). It=
 is
> > > more rounded than Labman and has a number of advantages:
> > >
> > > - does not need udev rules, mostly
> > > - has several existing users who rely on it
> > > - supports multiple machines exporting their devices
> > >
> > > It lacks a 'lab check' feature and a few other things, but these can =
be
> > > remedied.
> > >
> > > On and off over the past several weeks I have been experimenting with
> > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > hooks.
> > >
> > > I hope that this might inspire others to set up boards and run tests
> > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > it may even be possible to have a number of labs available.
> > >
> > > Included in the integration are a number of simple scripts which make=
 it
> > > easy to connect to boards and run tests:
> > >
> > > ub-int <target>
> > >     Build and boot on a target, starting an interactive session
> > >
> > > ub-cli <target>
> > >     Build and boot on a target, ensure U-Boot starts and provide an i=
nteractive
> > >     session from there
> > >
> > > ub-smoke <target>
> > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > >
> > > ub-bisect <target>
> > >     Bisect a git tree to locate a failure on a particular target
> > >
> > > ub-pyt <target> <testspec>
> > >     Run U-Boot pytests on a target
> > >
> > > Some of these help to provide the same tbot[4] workflow which I have
> > > relied on for several years, albeit much simpler versions.
> > >
> > > The goal here is to create some sort of script which can collect
> > > patches from the mailing list, apply them and test them on a selection
> > > of boards. I suspect that script already exists, so please let me know
> > > what you suggest.
> >
> > I still really wish you would split the labgrid parts of this series out
> > from the pytest fixes and improvement parts. Things are largely fine
> > outside of the labgrid part for example, which I'll probably just take
> > after confirming it doesn't break using labgrid other ways.
>=20
> I have had a few attempts at this, but it ends up being somewhat arbitrar=
y.
>=20
> Perhaps I could split out a series with the exception-handling changes
> and the typo? Perhaps 'Avoid failing skipped tests' also?

Well, in a previous series I said where I thought each patch went in
terms of what-it-did, so yes, that sounds like one of the sets of
patches I thought was unrelated to labgrid. Thanks.

--=20
Tom

--G9szjRIOlZwlRr2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R68ACgkQFHw5/5Y0
tyySxQv9GhifM6GeDSTupxav9QdvNq9uVCLWcDJtkcRRIAiMHXhVx3KeUZM0hXjg
wdwdTBWGrIVUgiftNNFD2Az2bbUtyF6XhI+6hRWAqD6dabqu3JwzPdol/+R9225R
kYCsW+o9kyeW5ZTTGCH5E/rt6JB9SvoUi9Q0NycS02oNOp3bXqVWRRLlW2SJM2Ti
qYd6wzohHrL+LAnaCaWHwX2MKKUSEy6H6jqAODbqdTPofm7++8qUah1MID6VRQOi
13OoznhCzjJ8EX3WtF10Fgnszcjk+i4+bFzSY14Lf8QPM2svaUTJwVKXpBUJ9gDN
Z0+1c3/OhUWWi7cTTjig8tNpuFUxsd/YYnxnWcn0u90OSbtwH2AenM+B1V3XSq9N
Gh7LDjUP+APN/hfLVtU46IM3gyD9JOLai0ujDSqgOjW+2H38O1svssb702Kab6pY
/sXUl3oCIeBdB0eOavNyEhLwQaP6p+f3jSKfPJCLrY7vRxSo3LSYesar+fhQTP8O
NKFDuVAq
=bl/u
-----END PGP SIGNATURE-----

--G9szjRIOlZwlRr2e--
