Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56704C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 15:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4799887E1;
	Mon, 22 Apr 2024 17:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ki4Qjn4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A58B883A7; Mon, 22 Apr 2024 17:03:22 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1504F887E1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b24162dd6so20896286d6.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713798197; x=1714402997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GeAgvRTkvDew1rWWGLXpFMz2LEtsM/y3zLfFY6Rjgc0=;
 b=Ki4Qjn4Ov7F/2MA8e6qL/WhSdQEKTlKSFRpbTP4Cuco5AIiJC3YCdHf2WEDgv+3+9p
 6sU3vSTD8rCrE8FIDgUPTZqJde0O0K+mo57Be2TpzeST3PELOcuUcwB1DDXKEMY+UUP8
 yZ6JiPUzwyjUk1KJR0egoflxUGUAC0fDXhH74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713798197; x=1714402997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeAgvRTkvDew1rWWGLXpFMz2LEtsM/y3zLfFY6Rjgc0=;
 b=VI+mt5QOBYr/cEdiOIK5bUF5Gwhn0tkxBtjbjvjvFvysAQZnC7FnPHt7kzRCsGoEob
 DXUkWbHZZwomHVTkSYYwhz7bBVPtWrsY+gOlFi5w7dppYIyMh/jlgYRuvSRvzbmeGhKl
 qg+t2MOH8SCHJo+QDkPRJpy7TmeMhzKa1tge3J69pv5gAuPx1xIvMFNgKOApkb3ggN1S
 kdz5xj2diN8KDCbylqRRnl7q/Rp7whVB/9/4uvYAow6xeMZwsuOo50YUvXmQs8sgyvgK
 vb28tU6wYA9ji0rOoaBXznLJLhrGedXQdOy88ysSTUDPyqX8QNr+KJ0td2A7Gd5863sG
 w1bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm4gtCcJPbVj6s59ZT0lzb5TCdFk8AGWKIbzTsPa8RYS8PbKVPpr0wtk1sZqEARZNLHTugUdIp66vBUDLQjTbviI7HCA==
X-Gm-Message-State: AOJu0YyfFIzC1K/DQOipXy8R0ahrOm8X7j8ZYmhDKNw+kJU/nq8DMMFi
 g/qkmn/lsNUv0T+/Cr6jXfZVXWIl4Q4xY/yjuq1q5g4gyrol4hMxexJMKDY0dDs=
X-Google-Smtp-Source: AGHT+IF6VRTyTKw/Frc2CxjIbLloU+pGVH2Fyknllt9DOza6M9CtDuT9HyF5iCbpDRn/7sVQy2yqrQ==
X-Received: by 2002:a0c:efcd:0:b0:6a0:58f4:5d82 with SMTP id
 a13-20020a0cefcd000000b006a058f45d82mr10608347qvt.1.1713798196750; 
 Mon, 22 Apr 2024 08:03:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a0cda90000000b0069b0c9a81b5sm4306801qvj.95.2024.04.22.08.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 08:03:16 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:03:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, afd@ti.com,
 vigneshr@ti.com, dannenberg@ti.com, srk@ti.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>, joe.hershberger@ni.com,
 simon.k.r.goldschmidt@gmail.com, sjg@chromium.org, marex@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240422150312.GT1054907@bill-the-cat>
References: <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
 <20240416170027.GQ1054907@bill-the-cat>
 <97f84067-ba36-47f6-befa-221be47a1d25@ti.com>
 <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
 <20240417160446.GF1054907@bill-the-cat>
 <8997eeb9-c5a7-4bc6-84c0-78693010ccc7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="itsYQwPnO5gqPW/a"
Content-Disposition: inline
In-Reply-To: <8997eeb9-c5a7-4bc6-84c0-78693010ccc7@ti.com>
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


--itsYQwPnO5gqPW/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 04:46:04PM +0530, Chintan Vankar wrote:
>=20
>=20
> On 17/04/24 21:34, Tom Rini wrote:
> > On Wed, Apr 17, 2024 at 05:48:31PM +0530, Sughosh Ganu wrote:
> > > hi Chintan,
> > >=20
> > > On Wed, 17 Apr 2024 at 13:21, Chintan Vankar <c-vankar@ti.com> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > On 16/04/24 22:30, Tom Rini wrote:
> > > > > On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 12/04/24 03:37, Tom Rini wrote:
> > > > > > > On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrot=
e:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > On 22/01/24 10:11, Siddharth Vadapalli wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 20/01/24 22:11, Tom Rini wrote:
> > > > > > > > > > On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vad=
apalli wrote:
> > > > > > > > > > > Hello Tom,
> > > > > > > > > > >=20
> > > > > > > > > > > On 12/01/24 18:56, Tom Rini wrote:
> > > > > > > > >=20
> > > > > > > > > ...
> > > > > > > > >=20
> > > > > > > > > > > > The list of conditionals in common/spl/spl.c::board=
_init_r() should be
> > > > > > > > > > > > updated and probably use SPL_NET as the option to c=
heck for.
> > > > > > > > > > >=20
> > > > > > > > > > > Thank you for reviewing the patch and pointing this o=
ut. I wasn't aware of it. I
> > > > > > > > > > > assume that you are referring to the following change:
> > > > > > > > > > >=20
> > > > > > > > > > >             if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CON=
FIG_IS_ENABLED(HANDOFF) ||
> > > > > > > > > > > -           IS_ENABLED(CONFIG_SPL_ATF))
> > > > > > > > > > > +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(=
CONFIG_SPL_NET))
> > > > > > > > > > >                     dram_init_banksize();
> > > > > > > > > > >=20
> > > > > > > > > > > I shall replace the current patch with the above chan=
ge in the v2 series. Since
> > > > > > > > > > > this is in the common section, is there a generic rea=
son I could provide in the
> > > > > > > > > > > commit message rather than the existing commit messag=
e which seems to be board
> > > > > > > > > > > specific? Also, I hope that the above change will not=
 cause regressions for
> > > > > > > > > > > other non-TI devices. Please let me know.
> > > > > > > > > >=20
> > > > > > > > > > Yes, that's the area, and just note that networking als=
o requires the
> > > > > > > > > > DDR to be initialized.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Thank you for confirming and providing your suggestion fo=
r the contents of the
> > > > > > > > > commit message.
> > > > > > > > >=20
> > > > > > > > Following Tom's Suggestion of adding CONFIG_SPL_NET in comm=
on/spl/spl.c
> > > > > > > > "dram_init_banksize()", the issue of fetching a file at SPL=
 stage seemed
> > > > > > > > to be fixed. However the commit "ba20b2443c29", which sets =
gd->ram_top
> > > > > > > > for the very first time in "spl_enable_cache()" results in
> > > > > > > > "arch_lmb_reserve()" function reserving memory region from =
Stack pointer
> > > > > > > > at "0x81FFB820" to gd->ram_top pointing to "0x100000000". P=
reviously
> > > > > > > > when gd->ram_top was zero "arch_lmb_reserve()" was noop. No=
w using TFTP
> > > > > > > > to fetch U-Boot image at SPL stage results in "tftp_init_lo=
ad_addr()"
> > > > > > > > function call that invokes "arch_lmb_reserve()" function, w=
hich reserves
> > > > > > > > entire memory starting from Stack Pointer to gd->ram_top le=
aving no
> > > > > > > > space to load U-Boot image via TFTP since TFTP loads files =
at pre
> > > > > > > > configured memory address at "0x82000000".
> > > > > > > >=20
> > > > > > > > As a workaround for this issue, one solution we can propose=
 is to
> > > > > > > > disable the checks "lmb_get_free_size()" at SPL and U-Boot =
stage. For
> > > > > > > > that we can define a new config option for LMB reserve chec=
ks as
> > > > > > > > "SPL_LMB". This config will be enable by default for the ba=
ckword
> > > > > > > > compatibility and disable for our use case at SPL and U-Boo=
t stage.
> > > > > > >=20
> > > > > > > The problem here is that we need LMB for booting an OS, which=
 is
> > > > > > > something we'll want in SPL in non-cortex-R cases too, which =
means this
> > > > > > > platform, so that's a no-go. I think you need to dig harder a=
nd see if
> > > > > > > you can correct the logic somewhere so that we don't over res=
erve?
> > > > > > >=20
> > > > > > Since this issue is due to function call "lmb_init_and_reserve(=
)"
> > > > > > function invoked from "tftp_init_load_addr()" function. This fu=
nction
> > > > > > is defined by Simon in commit "a156c47e39ad", which fixes
> > > > > > "CVE-2018-18439" to prevent overwriting reserved memory. Simon,=
 can you
> > > > > > explain why do we need to call "lmb_init_and_reserve()" functio=
n here ?
> > > > >=20
> > > > > This is indeed a tricky area which is why Sughosh is looking in to
> > > > > trying to re-work the LMB mechanic and we've had a few long threa=
ds
> > > > > about it as well.
> > > > >=20
> > > > > I've honestly forgotten the use case you have here, can you please
> > > > > remind us?
> > > > >=20
> > > > We are trying to boot AM62x using Ethernet for which we need to load
> > > > binary files at SPL and U-Boot stage using TFTP. To store the file =
we
> > > > need a free memory in RAM, specifically we are storing these files =
at
> > > > 0x82000000. But we are facing an issue while loading the file since
> > > > the memory area having an address 0x82000000 is reserved due to
> > > > "lmb_init_and_reserve()" function call. This function is called in
> > > > "tftp_init_load_addr()" function which is getting called exactly be=
fore
> > > > we are trying to get the free memory area by calling
> > > > "lmb_get_free_size()".
> > >=20
> > > I have no idea about your platform but I was wondering if there is any
> > > particular importance of the load address of 0x82000000? It looks as
> > > though the current location of the SP when arch_lmb_reserve() gets
> > > called means that the load address is getting reserved for the U-Boot
> > > image. Do you not have the option of loading the image at a lower
> > > address instead?
> >=20
> > Or using a higher address for SPL stack? You might be able to solve this
> > just by re-examining which addresses (and RAM size limitations) need to
> > be considered here.
> >=20
>=20
> Tom,
>=20
> We changed SPL_STACK_R_ADDR to higher address as you suggested here and
> observe that the memory area which was getting reserved by
> "lmb_init_and_reserve()" function, when SPL_STACK_R_ADDR was 0x82000000,
> is from 0x81FFB820 to gd->ram_top, but when SPL_STACK_R_ADDR is changed
> to 0x83000000, stack pointer is pointing to 0x82FFB810 and reserving a
> memory area till gd->ram_top. Since memory address 0x82000000 is not
> there in reserved memory area region U-Boot proper is successfully
> getting fetched and we are able to boot.
>=20
> Can it be considered of changing "SPL_STACK_R_ADDR" independently for
> Ethernet Boot feature ?

Yes, it's a configuration option so that it can be changed as needed.

--=20
Tom

--itsYQwPnO5gqPW/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYmfC0ACgkQFHw5/5Y0
tyyqxgv/U5ym4+y0/w8jJgZZ5H/AXK7NknAo1T17mB1DWkYmwCxZ84wgIWLqmOpI
1cfk9jw+YuxrN1b/qLSCby3nPjf+4dgm1TvdOCHiNQ4mzIc5Ctv3DQqt6PZCZdHg
Pc/tQJEFvXL/APXbVQUv3YPs/BGEh3ZooRRYL/1hBnb4LS7gch8gFdDvQSD+9B2F
U75xT8e1H+uMw0FWrX0kS3cmYJatCn0rf0T4y3QU0jDxCz5WKeecLuUPsBGkEgn2
66Z6kAjhclWefC9E9nK1TmnLfON4s+UxbnYnwiUTJRyJapE7apu8LyBT7gQBFygD
nI3rlvvUDbFqOEZ0nCtEdFx/tV7gVFQ1q0J07523pLcUUpZ1w+DcegGpjgbVHl0/
AcdWkw0VVgSwhLvLTwJaKsDXWNBu6RRDXF9Pjhv3w1Vurh1KgQNLD7OaVoQz5OEz
iFV1w8q+BfITXIlNMgLwJvcBjUAF6vcV534O1bf9FIFG6uGGl0p+CFC8ajMCkXnL
p0Ud7fNd
=k8SV
-----END PGP SIGNATURE-----

--itsYQwPnO5gqPW/a--
