Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EADC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1D582D21;
	Fri, 13 Jun 2025 16:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQAH3aaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8018682D7C; Fri, 13 Jun 2025 16:39:50 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5825482D21
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 16:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7311a8bb581so1749927a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749825587; x=1750430387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/P/TGDv5JuRkpfJobuUpRXZUQGmXgXrKMpW5uAmuG7E=;
 b=aQAH3aaR1gmttHOIfHnl8LmdQgJbuAlBF0yUiytOavF+Ejfaz2CsYcHSbEtuijI4NJ
 Q/H0gCG3WMRifhftkNFQixWBEzePqHQ9GYTwy9rM5hfL1gdMTQz5WWYL+T8fWcNk1ZI2
 mjPlIPbl0TlYiIexoCLNqYNI4H7j218aXzQsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749825587; x=1750430387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/P/TGDv5JuRkpfJobuUpRXZUQGmXgXrKMpW5uAmuG7E=;
 b=utN+CHqkS2DR6PEVvJRtCRUyhWhwWd11i6ghNIvNRNniyIM+Ve/1RCys4+SujKh9CF
 cl0tnflhZQfYaiiBejc9TMfM6EhRDmGyKuohnjZMyH4JXMf7mZk23rV1aQTqp+nwlRKY
 iVfPEuYnAPWaX0J8fecJZqY95F5h3Kg1hC0Ob41ZYpW3Bmkrj9IxmN7NQtPqAkUwfk5v
 AJL/4YG2JzxAQBbcGaASH6jjdQdp6aMpRtSKcu6GWy6VR6EdH4Nol6BM+UDe4pSvVHt4
 iuwYWtcYSclEWbdfb3Nr/VMPkzc+X387J6SzVKoNPdkyh+LJaXQrk1SZwIyG4FHh1DID
 BB5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS307JufdMmMQ64kzeR6rW1hpH9kGpA03R4QTzmHjtfJlOI3rMfF/N2xTC6g4gw12X32d5wB0=@lists.denx.de
X-Gm-Message-State: AOJu0YwPPeYSXuGBjrcH08p1RYsXTzxSsL5DJPm8n1fJ27ljE9iudrWH
 X+cMWnyL9rJbkeraf3Nth326rxXbN3hZNBYWkL7e9wLI/KReQCQvaVNA31shtNyeQrA=
X-Gm-Gg: ASbGnctEBqPv/KQBhiS75SB6MbJyJcQzbN6mGjLrGOEJXC3Oh/Tks6tXKMkIHYIKpSd
 zwJ9GTgKNajyKx3uV0bvpSrXi0Jm2pZPRyMpEmRj4PdkTKxgUx2+Ssob7LLqtEzsNMBi73fztU8
 naR7rULgLttI5uM9A13iOZWmkGu7zmkyg73nW1mpYb8elKVko+sVnfUt3X820NYAI5tM5K1rD6O
 FSqbMu2YpTSUV1Gk6QS95qFkQ+KsTvXhWEB4TlZfUjWrGjE7CenICUZ6hlUGtjHhYfXJmWi1bER
 BiilJ30b3wN9m4ZHHNT5T7gU6Smx7Dw28kaaJAABgo6cPcT3EGL9krqgraG8vYLKoPTvKbfCSDs
 EADTiipvHwjFZfdJrwe+eSFw=
X-Google-Smtp-Source: AGHT+IHBt8aeYaxMPETR6cEoqWRIiMb5J8LJ4lR/OVjedg4ajeVzrN3eQdjgaQibWMa6QlpPkYhg4g==
X-Received: by 2002:a05:6830:33ef:b0:739:fbd3:b932 with SMTP id
 46e09a7af769-73a270eb029mr2003785a34.5.1749825586965; 
 Fri, 13 Jun 2025 07:39:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283dbfa5sm222154a34.6.2025.06.13.07.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:39:46 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:39:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Neal Frager <neal.frager@amd.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation
 for ZynqMP KV260
Message-ID: <20250613143943.GX1382132@bill-the-cat>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
 <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0UrJq2iSZJQI27QJ"
Content-Disposition: inline
In-Reply-To: <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
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


--0UrJq2iSZJQI27QJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 09:59:52AM +0200, Michal Simek wrote:
>=20
>=20
> On 6/13/25 09:38, Jerome Forissier wrote:
> >=20
> >=20
> > On 6/12/25 18:49, Tom Rini wrote:
> > > On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
> > >=20
> > > > Add a script to help build a functional U-Boot binary for the ZynqMP
> > > > Kria KV260. Also add some documentation.
> > > >=20
> > > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > ---
> > > >=20
> > > >   doc/board/xilinx/index.rst        |  1 +
> > > >   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
> > > >   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
> > > >   tools/zynqmp_pmufw_elf_convert.py | 96 ++++++++++++++++++++++++++=
+++++
> > > >   4 files changed, 167 insertions(+)
> > > >   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
> > > >   create mode 100755 tools/zynqmp_kv260_build.sh
> > > >   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
> > >=20
> > > Helper build scripts don't belong in the tools directory. If they're
> > > super helpful, I don't object to adding them to
> > > u-boot-extras/contrib/<you>/ directory.
> >=20
> > OK
> >=20
> > > But there's a number of
> > > documented examples already on checkout and build TF-A then do ... for
> > > your platform.
> >=20
> > There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
> > boards but not the KV260. In addition, it has a number of shortcomings:
> > - It mentions pmu.bin but does not say where to get if from
> > - It doesn't say how to build TF-A (bl31.bin), some very specific build
> > options are needed.
> > - I consider that detailed build instructions belong in things called
> > scripts or Makefiles, that were invented long ago exactly for that
> > purpose :) IMO the documentation should tell the bare minimum and ideal=
ly
> > be unnecessary.
> >=20
> > I am not particularly proud of the fact that I spent more than a whole
> > day trying to get U-Boot master to boot on my KV260, and without the he=
lp
> > of Michal, no doubt I would still be trying... So, how about I submit t=
he
> > zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directo=
ry
> > and just point to it in doc/board/xilinx/zynqmp.rst?
>=20
> no issue from my side.

I am also fine with this approach (and you should have access to the
repository, and I need to go do some admin work to make it easier to add
all custodians), and once Michal is happy with the script too.

>=20
>=20
> > > > diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw=
_elf_convert.py
> > > > new file mode 100755
> > > > index 00000000000..b4eb2695831
> > > > --- /dev/null
> > > > +++ b/tools/zynqmp_pmufw_elf_convert.py
> > > > @@ -0,0 +1,96 @@
> > > > +#!/usr/bin/env python3
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +# Copyright (C) 2025 Linaro Ltd.
> > > > +#
> > > > +# Written by Gemini (Google AI) then reviewed and edited to remove=
 some comments
> > >=20
> > > I'm glad this calls out where it's from. I'm not comfortable for a
> > > number of ethical reasons on taking LLM-generated code. I'm also a
> > > little surprised we don't already have something like this with binman
> > > today?
> >=20
> > Nervermind. 'llvm-objcopy -O binary pmufw.elf pmufw.bin' works just
> > fine :) so I'll use that instead. Note that the binutils objcopy
> > cannot be used because it is target-specific and the MicroBlaze
> > version is not so easily available. While LLVM supports many targets
> > natively.
>=20
> yes/no. Toolchains are wired via buildman already and available at kernel=
=2Eorg.
> Connection to llvm is adding another dependency.
>=20
> I think putting this script to u-boot-extras is fine. To upstream u-boot
> could be more problematic because as I mentioned there are some issues wi=
th
> the way you use. You should be able to take bl31.elf from
> soc-prebuilt-firmware repo too.
> You can also look what Neal did in buildroot to get it work which is bett=
er
> place for building tfa and putting images together from different locatio=
ns.

FWIW, it's things like this as to why I prefer more and better
documentation in u-boot itself and build scripts in contrib. Everything
has so many other use cases and then host dependencies that it's a Lot
OF Work to have something that handles everything. Having seen a number
of "helper build scripts" that then went very wrong once out in the wild
over the years is another part of my reasoning.

--=20
Tom

--0UrJq2iSZJQI27QJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMOCwACgkQFHw5/5Y0
tyxtEQv/XjOhpTF0A35dAAuqUn3ouS7MZ6AHgp/lKPvpqvDf8LBUj8LljmWsMv9A
Ux9Ny6zqVflP3bF/UMUoHEHw6rNoXd1iKmWhmdkm+9VlJornHZZOpVmtiGL3lquO
j+v2e9fleqYC+PAYChAmK2xb2iO/36H4h8idheA7QuBqE/CxjCYSwSCUQtXLH/c/
UBqMxstrS5q2ZTdaXIAMm1NcbttX0GRb505K8Rmf4SAAMtK27plvt3WyQfi5wY5R
h5CmFNKIQsLh76xEYcCWzIlIRV7p/Feddlf1dcJkc5pSa+1t/MBdtWat2TLeWqFJ
z9c26khN6QfEn1IrnErJPqZO7eV0Wi0XV8TTrW2rAHCcpcGhb2TArHyA7A6vMzYs
Ha6qmEcMV+4HPfXqHfZ8vQM5YtewtJGDXBG7lFQ9nDtEQSYqeuqJ5GUgI69f4lK8
vwyi8HQaQpLNxcCBDg9wFyIuRFOL0391JffqF58ux+5o1chfAC4u9EWKDdni1lNz
sqfI6D/b
=0wyF
-----END PGP SIGNATURE-----

--0UrJq2iSZJQI27QJ--
