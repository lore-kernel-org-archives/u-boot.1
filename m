Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CED0E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19EDD893C7;
	Sat, 23 Nov 2024 03:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VpcJal7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE29893C7; Sat, 23 Nov 2024 03:41:22 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A32891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d41edfac53so18398086d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329678; x=1732934478; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KHonP94Qfz7u2DH5tmJNgM918hS4PrOQZoS7E2EluPg=;
 b=VpcJal7nfw43grQMxTrwDGNqipmli2TM6Rr+zlvuHhGjDR+SQTfcXPlCxdRDj2I7Vg
 GMy94bV/8OAy2e8A3cslK+EFlspY305DsmKS7FMPxrLpxs7ZYjSbiaZJ7xzHLOdO8/+u
 o0Ue0VwXp1yLAQHJqEDkokgN98BJw7nBV3GRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329678; x=1732934478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHonP94Qfz7u2DH5tmJNgM918hS4PrOQZoS7E2EluPg=;
 b=i+xLZmkZzNTiwXkegp3I34niWwHc+pqIhA6rPyTvEmnrADLDYG31F0/hblkFYnRBjR
 i0EFgIKzuR4QeEYLVxSvAIJybxsdVVZpRV1wETBEwZFRMDBe+e5FuQ/TczQ6ce3EWpY0
 T/bPr5wdqhLk51w1LgLw+OBqRGwrMzsSol7L12Y//4f7WzR7rSfvJQ/pIZxFobIbD8MH
 SRbZ0KNcWuiLKSpH9NRUT3OQIVZI2Kvwu6lvIgk47/JDUJpGP5D8fKmiHjiAYxF6ZgIE
 FMCmCFUjVZkVwx3Y5NVtgCskWCtbjpg1VBIH7ZwjRv/a9IhmNAmUTd3txPA82kCMM/c+
 SBgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUzN3RcTSkqknGgabEPM4Vat2gii1QSt/HTsx5gvN/U7yV5Yrv1n26fKd8W8f32lxHdbfLfJA=@lists.denx.de
X-Gm-Message-State: AOJu0YxCuBmgGrlAhMk2xBpi0yPT32EAGxtWWnaxy+n46ZLHsqjTQulb
 3LRPhfiDaVc0u7MR6w8Y2x9jva+wQhdBeQNFAuqHCzieEoe2Yyo2AmgA7rwBYCg=
X-Gm-Gg: ASbGncs4/+3pcMTYId8Knd29yCyondr4pjprleb02JgfBzpaXhwWOeyZfRU3NTuhVMt
 hqWkkWaVxxawdrvn0Gc/Pf/K13ZYmrgPJJQ2PeWrUCbPuhdQiXgFWTsK4JfnWiS1umcvvS4zOs9
 zUA4Eljlf1OT+Ll40aHgEAzGwA2LJsGbQOzxknmDGQTR9g72seFhU57HncxbJf+7X9RrxbHyNrs
 VAX9bbObS+gJMU/n1KOU9LR2pwKQ93SRlhPZDblaiSxfAnc5g==
X-Google-Smtp-Source: AGHT+IEDJbhO13cnV4LKoTMlmQnpcthNIz0MDnfjSWO11rBgoxmDOelZt7942pOcUnZ72Js/eTBdEw==
X-Received: by 2002:a05:6214:766:b0:6d4:1d9b:1563 with SMTP id
 6a1803df08f44-6d451374123mr74449836d6.40.1732329678124; 
 Fri, 22 Nov 2024 18:41:18 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23ec1sm17202896d6.71.2024.11.22.18.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:17 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
Message-ID: <20241123024113.GM3600562@bill-the-cat>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241113180059.GV3600562@bill-the-cat>
 <67350b1d.5d0a0220.2d4a95.bc9a@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tmgZ55bWJHb9zmqN"
Content-Disposition: inline
In-Reply-To: <67350b1d.5d0a0220.2d4a95.bc9a@mx.google.com>
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


--tmgZ55bWJHb9zmqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 09:24:59PM +0100, Christian Marangi wrote:
> On Wed, Nov 13, 2024 at 12:00:59PM -0600, Tom Rini wrote:
> > On Sun, Nov 10, 2024 at 12:50:19PM +0100, Christian Marangi wrote:
> >=20
> > > This series is split in 2 part.
> > >=20
> > > While adapting the LED boot and activity code to the new property
> > > accepted by Rob in dt-schema repository, a big BUG was discovered.
> > >=20
> > > The reason wasn't clear at start and took me some days to figure it
> > > out.
> > >=20
> > > This was triggered by adding a new phandle in the test.dts to
> > > introduce test for the new OPs.
> > >=20
> > > This single addition caused the sandbox CI test to fail in the
> > > dm_test_ofnode_phandle_ot test.
> > >=20
> > > This doesn't make sense as reverting the change made the CI test
> > > to correctly finish. Also moving the uboot node down
> > > after the first phandle (in test.dts the gpio one) also made
> > > the CI test to correctly finish.
> > >=20
> > > A little bit of searching and debugging made me realize the
> > > parse phandle OPs didn't support other.dts at all and they
> > > were still referencing phandle index from test.dts.
> > > (more info in the related commit)
> > >=20
> > > In short the test was broken all along and was working by
> > > pure luck. The first 4 patch address and fix the problem for good.
> > >=20
> > > The other 4 patch expand and address the property change for
> > > LED boot/activity.
> > >=20
> > > Posting in a single series as changes are trivial and just
> > > to speedup review process. (and also because the second
> > > part depends on the first)
> > >=20
> > > All CI tested with azure pipeline.
> > >=20
> > > Changes v2:
> > > - Fix handling of flat tree for phandle
> > > - Fix test and other.dts changes
> > >=20
> > > Christian Marangi (8):
> > >   dm: core: implement oftree variant of parse_phandle OPs
> > >   test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phandle_ot
> > >   dm: core: implement ofnode/tree_parse_phandle() helper
> > >   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
> > >     ofnode/tree_parse_phandle
> > >   dm: core: implement phandle ofnode_options helper
> > >   test: dm: Add test for ofnode options phandle helper
> > >   led: update LED boot/activity to new property implementation
> > >   test: dm: Update test for LED activity and boot
> > >=20
> > >  arch/sandbox/dts/other.dts |  31 ++++++++-
> > >  arch/sandbox/dts/test.dts  |  16 +++--
> > >  drivers/core/of_access.c   |  61 ++++++++++++-----
> > >  drivers/core/ofnode.c      | 124 ++++++++++++++++++++++++++++++++-
> > >  drivers/led/led-uclass.c   |  30 +++++---
> > >  include/dm/of_access.h     |  86 +++++++++++++++++++++++
> > >  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
> > >  test/dm/led.c              |  18 +++--
> > >  test/dm/ofnode.c           | 136 ++++++++++++++++++++++++++++++++---=
--
> > >  9 files changed, 551 insertions(+), 58 deletions(-)
> >=20
> > My main issue with the series is a lack of documentation updates, as the
> > biggest challenge thus far has been that for example Peter couldn't
> > figure out how to make use of this on PinePhone. We generate
> > documentation today based on include/led.h for this API, yes? Thanks.
> >=20
>=20
> Hi Tom,
>=20
> actually quite the oppisite, led.h describe how these works and was
> instructed to first have the options property merged in dt-schema. [1]
>=20
> Here we have all the option documented under a yaml.
>=20
> I notice there is a series from Simon that is also pushing a .yaml
> here locally in U-Boot and I was waiting for that to be merged to also
> include the additional entry there.
>=20
> Also led.h description and API have info on where to look about the
> handling of /options/u-boot/
>=20
> I feel the main problem with documentation is currently the fact that we
> are migrating to a more robust schema and people are used to using Doc
> directory? Anyway happy to get any hint on how to improve this.
>=20
> [1] https://github.com/devicetree-org/dt-schema

So Peter, does this bring you what you were asking for in terms of
details, or can you explain what's still missing from your point of
view? Thanks!

--=20
Tom

--tmgZ55bWJHb9zmqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQMkACgkQFHw5/5Y0
tyzGwAwArzujcpFYl5dSMsmzNHengASaA2m6a5ofoYFqt4j2QZB0bz+jSA7ra9ps
r7n4Ff8RmIbwu4iye+3m1QjP2jF/S9rBgliUfPW6L5nbdGAq8yl31Ew/TpQgES5e
mWznFfPoakT3XolecwNccZ07slkpCAK6x179UKmsV/5nzUXaCfRlYl7G9tsWF8vG
Qhr6361ri1Abo5sbCO5YosJv3htxePfWFfVbZVnYoLyges5nsZmWL6pbIDJZAgWf
oPIGWS97JnvGHc7e0UwFuyfnTo/uBwT47BFUahBi4uhyfgALtrAG7GC90/XlBaVU
7LpkpEjNp6x+0iIFjnvihtyJ7vqIatW38LNyq6KOsVJMqswLI/ulEX6DbdSsuxL8
u8Otb//5GvFSiRIz75SQX7xL25heMobYG2xK953+StMiwqW2PA6VbjKgrb0tz1Fm
whdS0dOmzOjbLodWSYTKw1KVEM4EQ/wFzAq/WuH0ddJy3W9hMgGizCsEnS07cj9N
qA5M20h4
=CxO5
-----END PGP SIGNATURE-----

--tmgZ55bWJHb9zmqN--
