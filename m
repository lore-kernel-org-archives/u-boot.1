Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06188C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 15:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02308718A;
	Fri, 16 Feb 2024 16:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTbuaLeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6C187D66; Fri, 16 Feb 2024 16:46:03 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62A9F86DBD
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 16:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dcc6fc978ddso1824196276.0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708098357; x=1708703157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KIQUGnaoPElQErBaDygDq1Rx4+9cTrSZ3Xk7cn9xml8=;
 b=oTbuaLeqFtbNsc6UsxHFeqQ51ngNrCcGNM6789eibjYDC7uEz1LbdTMLmbXzyt8BlR
 r4yvvnW1HF0gF4dwJ9rC+645SzoSJhkybv6llT38F7bHIyfI4QMLBOiBVYmhyjn1UfW6
 3zqutgsEA1LaiczGq+Ll+N6deJzgdmMjXgRH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708098357; x=1708703157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIQUGnaoPElQErBaDygDq1Rx4+9cTrSZ3Xk7cn9xml8=;
 b=t835R9ORKuj87lCemSN7Xb5Uo5mUCy8y0GefAZgA7hSM2ZPnpUS3yvbhoosxTsbO+2
 GtGJvsPZctWAXWbAcX7ITdVnPUU29dsMDncWLYxLnKuMr51pJkNf79cORI1v/VkG1CDB
 qerPT/Yztvx1RCJjC4WS1VE4LGXwEXLy2vZ3KUnjCh1qPqqJkvAIl7BqcZwR1YO7qwmq
 o9w3/3lSU34Z1ooFXXhNvx90YprKg4XHBbUeTbO7L/PPzeBZn3/r0/+7Z2WHdRwuJ+0F
 BMtYnftCliLuZsqc21O+uJ1LmXF39loiaHYpfoTHbW9izT+Pa8umIKEc5Ii4U0c7H+BH
 Cc2w==
X-Gm-Message-State: AOJu0YzNqD4PRaYVUCDulwBM86r2VG6QfhF81B7oy71q71iPUfBk1S1S
 +fNhtiO5n1GJDCPdBG7tXZjLNUhTziN6lael39QlqBWK2AvSJvKB+/U3G4Ov040=
X-Google-Smtp-Source: AGHT+IE24fD0SsZ5iv2jw1TPWlUSw/1DtEd6yHboJt2QkHm9r4jZDw34IdXmOdffW+VPsLK9UkbfPg==
X-Received: by 2002:a25:b78e:0:b0:dc7:46fd:4998 with SMTP id
 n14-20020a25b78e000000b00dc746fd4998mr3836307ybh.13.1708098356964; 
 Fri, 16 Feb 2024 07:45:56 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 z89-20020a25a162000000b00dc74258241fsm361688ybh.45.2024.02.16.07.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 07:45:56 -0800 (PST)
Date: Fri, 16 Feb 2024 10:45:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Message-ID: <20240216154554.GK3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
 <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
 <20240215220032.GG3040305@bill-the-cat>
 <9B30B785-4711-4343-9402-3CF5DC7F0338@gmx.de>
 <20240216131835.GH3040305@bill-the-cat>
 <84c6a0c6-376c-4fed-9f27-bee49c9b659c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8VSlCOEbiXWkWNNY"
Content-Disposition: inline
In-Reply-To: <84c6a0c6-376c-4fed-9f27-bee49c9b659c@gmx.de>
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


--8VSlCOEbiXWkWNNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 04:00:27PM +0100, Heinrich Schuchardt wrote:
> On 16.02.24 2:18 PM, Tom Rini wrote:
> > On Fri, Feb 16, 2024 at 12:20:14AM +0100, Heinrich Schuchardt wrote:
> > >=20
> > >=20
> > > Am 15. Februar 2024 23:00:32 MEZ schrieb Tom Rini <trini@konsulko.com=
>:
> > > > On Thu, Feb 15, 2024 at 10:53:59PM +0100, Heinrich Schuchardt wrote:
> > > > >=20
> > > > >=20
> > > > > Am 15. Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
> > > > > > On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Am 15. Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@kons=
ulko.com>:
> > > > > > > > The first big issue is that the "gcc" file talked a lot abo=
ut the
> > > > > > > > general build requirements as well, but was titled in a gcc=
-centric
> > > > > > > > manner. Solve this by renaming the file to compile.rst and =
more fully
> > > > > > > > reflecting that it is general build instructions. Next, add=
 a section
> > > > > > > > about the prebuilt toolchains that are recommended (as they=
 are the ones
> > > > > > > > we use in CI), and update a few places to reference these v=
endor-neutral
> > > > > > > > tools.
> > > > > > > >=20
> > > > > > > > Next, we can include the reproducible builds section direct=
ly in the
> > > > > > > > compile instructions rather than as a small standalone file.
> > > > > > > >=20
> > > > > > > > Finally, we update the sandbox document to reflect both the=
 name change
> > > > > > > > as well as what is specifically required to build sandbox.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > ---
> > > > > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > > > > ---
> > > > > > > > doc/arch/sandbox/sandbox.rst       |  5 ++-
> > > > > > > > doc/build/{gcc.rst =3D> compile.rst} | 64 +++++++++++++++++=
+++++++++----
> > > > > > > > doc/build/index.rst                |  3 +-
> > > > > > > > doc/build/reproducible.rst         | 27 -------------
> > > > > > > > 4 files changed, 61 insertions(+), 38 deletions(-)
> > > > > > > > rename doc/build/{gcc.rst =3D> compile.rst} (73%)
> > > > > > > > delete mode 100644 doc/build/reproducible.rst
> > > > > > > >=20
> > > > > > > > diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbo=
x/sandbox.rst
> > > > > > > > index 5f8db126657f..f2ed5a25c115 100644
> > > > > > > > --- a/doc/arch/sandbox/sandbox.rst
> > > > > > > > +++ b/doc/arch/sandbox/sandbox.rst
> > > > > > > > @@ -39,11 +39,12 @@ integers can only be built on 64-bit ho=
sts.
> > > > > > > >=20
> > > > > > > > Note that standalone/API support is not available at presen=
t.
> > > > > > > >=20
> > > > > > > > -
> > > > > > > > Prerequisites
> > > > > > > > -------------
> > > > > > > >=20
> > > > > > > > -Install the dependencies noted in :doc:`../../build/gcc`.
> > > > > > > > +In addition to the normal dependencies shows in the :doc:`=
general build
> > > > > > > > +instructions <../../build/compile>` to enable display supp=
ort SDL2 libraries
> > > > > > > > +need to be available.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Basic Operation
> > > > > > > > diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
> > > > > > > > similarity index 73%
> > > > > > > > rename from doc/build/gcc.rst
> > > > > > > > rename to doc/build/compile.rst
> > > > > > > > index 3c6465772729..ef9c8545835a 100644
> > > > > > > > --- a/doc/build/gcc.rst
> > > > > > > > +++ b/doc/build/compile.rst
> > > > > > > > @@ -1,11 +1,19 @@
> > > > > > > > -Building with GCC
> > > > > > > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > +Building U-Boot
> > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >=20
> > > > > > > > Dependencies
> > > > > > > > ------------
> > > > > > > >=20
> > > > > > > > -For building U-Boot you need a GCC compiler for your host =
platform. If you
> > > > > > > > -are not building on the target platform you further need  =
a GCC cross compiler.
> > > > > > > > +For building U-Boot you need the general build tools such =
as `make` and a C
> > > > > > > > +compiler for your host platform. Next, if you are not buil=
ding on the same
> > > > > > > > +architecture as the target platform you further need a C c=
ross compiler.
> > > > > > > > +Furthermore, some target platforms require additional host=
 tools to be present
> > > > > > > > +and their package names may vary slightly dependinng on th=
e naming scheme used
> > > > > > > > +by a particular host OS.
> > > > > > > > +
> > > > > > > > +In general, GCC should be used for both the host and targe=
t C compiler. Using
> > > > > > > > +:doc:`clang <clang>` is supported but please see the docum=
ented issues for it as
> > > > > > > > +well.
> > > > > > > >=20
> > > > > > > > Debian based
> > > > > > > > ~~~~~~~~~~~~
> > > > > > > > @@ -69,6 +77,17 @@ Depending on the build target further pa=
ckages may be needed:
> > > > > > > > * riscv64 S-mode targets: opensbi
> > > > > > > > * some arm64 targets: arm-trusted-firmware
> > > > > > > >=20
> > > > > > > > +Prebuilt
> > > > > > > > +~~~~~~~~
> > > > > > > > +
> > > > > > > > +Another option, which the project uses for CI for example,=
 is to use a prebuilt
> > > > > > > > +toolchain. For the most part, we use the latest `kernel.or=
g`_ prebuit binaries,
> > > > > > > > +but there are a few architectures that require their own s=
pecific toolchains
> > > > > > > > +still.
> > > > > > > > +
> > > > > > > > +In general, examples found within the documentation here r=
efer to the tools
> > > > > > > > +found here and exceptions will be noted where relevant.
> > > > > > > > +
> > > > > > > > Prerequisites
> > > > > > > > -------------
> > > > > > > >=20
> > > > > > > > @@ -112,11 +131,11 @@ command line or export it beforehand.
> > > > > > > >=20
> > > > > > > >      CROSS_COMPILE=3D<compiler-prefix> make
> > > > > > > >=20
> > > > > > > > -Assuming cross compiling on Debian for ARMv8 this would be
> > > > > > > > +Assuming cross compiling for ARMv8 this would be
>=20
>=20
> Referring to Debian the CROSS_COMPILE value was correct.
>=20
> After the change we have some value that is wrong for many or even most
> distros.
>=20
> Please, drop this change.

One of the reasons for this series is to lay the groundwork to make
everything consistent, which we are not today:
$ git grep -l CROSS_COMPILE=3Daarch64-poky-linux- doc/ | wc -l
7
$ git grep -l CROSS_COMPILE=3Daarch64-linux-gnu doc/ | wc -l
34
$ git grep -l CROSS_COMPILE=3Daarch64-none-elf doc/ | wc -l
39

So yes, I dropped "Debian" from the text in order to be
distribution-agnostic and then changed to the prefix used by the
toolchain we test, which very annoyingly, is the one that doesn't put
"gnu" in the suffix as it's not required (if it was OpenEmbedded
wouldn't be ignoring it).

Since I'm not sure we even can build the world on a distribution
toolchain due to age of the toolchain (for the cases where there is a
toolchain, but that is the most common case at least), I don't want to
encourage that as the first choice.

--=20
Tom

--8VSlCOEbiXWkWNNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXPgywACgkQFHw5/5Y0
tyzc1Qv/QYnESyeiDVJiyRJJIJfM4JNCDVKH4AGIrED8j/mR8htWeLOOgQ270Y0y
NwAKKH3d0q32e0ICCLxjVPLr8Cu5764KSbFFDY9eG26BdIGQyGnTT0yvKH6tNodN
JgOr3qea63We2x7XyCujMn/BsAJPaI2P8CtATr+CjizUyw3LONopVY/R4e/ZL2ut
0Ib155BKqKUbHOlPNFYF7+zuxYBTCFwRhYyX5VmRCs3ZCiQC/Bm7R1PEVHqpd7cK
9LQZWHlEgcQsCdWmzHb+6XgsVnWcrCTuPKWlUY23sqW1yp3u/gEoK6pFvZyFnmtt
FfWgoZkMuRr3LWZ4amS7FVUEc7WjQKffAfOtkv5aR7BNT7f7vAw5KDitT6S3AuHN
FAm0yoW7C1zKBvshThg/z5lhCXqH27KLIFL0ScuqAzdPOSCiFz/qOBnKmU3mccuK
bZBIuEIFvtYHuT247OuJOshtSeOOSlZp5euLLtiKJ/eX8l4UUroR0Jit13cGgZ4h
EMQMNdTx
=UZj3
-----END PGP SIGNATURE-----

--8VSlCOEbiXWkWNNY--
