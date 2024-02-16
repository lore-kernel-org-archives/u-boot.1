Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2550FC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 13:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F3187C5B;
	Fri, 16 Feb 2024 14:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZNQpQsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F6387CBA; Fri, 16 Feb 2024 14:18:43 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C548718A
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 14:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60802b329c4so3479337b3.0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708089518; x=1708694318; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SbzFbd2Wu9+RR5gMBifnTmblY62uB/erYIfZdy+gd+Y=;
 b=JZNQpQsT2OctpdCEMRi+s/owbynobio6RiFeaK+JC8Oz+W8ynoULjdCfRs9i3HYHb5
 nPQDHc9rnyEjS916bFwA31SvN67BCbR1nfunfyKgMWA8wVx8Ao/4FsinpktqxLKLx+G3
 Gc1sSUxUtfK/IByUsH3ls8eWx+ZEdZA6Z6j9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089518; x=1708694318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbzFbd2Wu9+RR5gMBifnTmblY62uB/erYIfZdy+gd+Y=;
 b=PGqxiUeBJOfkQx0n8bpe4VBpd4LeqojTILB1IELajj7WMBreiuBck0sE8dmTQ+h8dy
 Kx6z0zKxXAxab8mJSOa2b2/6ciPGdvS6jablhWVznEzusK6Tsr0GHGQfuOuUFiOaeJmU
 xqFOTt3OD/aZJk/Yh3vzKihC2FQg7ws276mEuWqhSDtG8dXZ/CrdGqCpmOQVdrrVHy6N
 u/5bW6vdisWzueqpFi2kTO8eyooehbGWv3q8/+nTOhkqaH/fkVyYkEsFoRe1eDeJe3jH
 FYKlfZsNykdKGGfHQrTu4gSQPFweTWlii2vq3fzj3RkhTnJbZ95hqYmr5KylJWoZhnB2
 1nvQ==
X-Gm-Message-State: AOJu0YzMIozg2leb2B/JO0e72cOwlUD0SwiuljMrn180LM2OzMToslW4
 iIrMLv+PKqEQjx5XTfrpqBRS7ZFi9OWhBlduWBgICYVBIuRCgndyA+REZg1LoyM=
X-Google-Smtp-Source: AGHT+IGVhmCt/awY4TGKGUtmgRIy9AtennV0CwX8n194MbJLzq1JQMc7d+1D661sAQ9+8aMzXwhDww==
X-Received: by 2002:a81:b71b:0:b0:604:3ee2:f258 with SMTP id
 v27-20020a81b71b000000b006043ee2f258mr4760923ywh.45.1708089518273; 
 Fri, 16 Feb 2024 05:18:38 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 w133-20020a0dd48b000000b00607cb99db8fsm338547ywd.53.2024.02.16.05.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:18:37 -0800 (PST)
Date: Fri, 16 Feb 2024 08:18:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Message-ID: <20240216131835.GH3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
 <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
 <20240215220032.GG3040305@bill-the-cat>
 <9B30B785-4711-4343-9402-3CF5DC7F0338@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M+PxOaeQ8CEUNxww"
Content-Disposition: inline
In-Reply-To: <9B30B785-4711-4343-9402-3CF5DC7F0338@gmx.de>
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


--M+PxOaeQ8CEUNxww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:20:14AM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 15. Februar 2024 23:00:32 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Thu, Feb 15, 2024 at 10:53:59PM +0100, Heinrich Schuchardt wrote:
> >>=20
> >>=20
> >> Am 15. Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >> >On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
> >> >>=20
> >> >>=20
> >> >> Am 15. Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko.c=
om>:
> >> >> >The first big issue is that the "gcc" file talked a lot about the
> >> >> >general build requirements as well, but was titled in a gcc-centric
> >> >> >manner. Solve this by renaming the file to compile.rst and more fu=
lly
> >> >> >reflecting that it is general build instructions. Next, add a sect=
ion
> >> >> >about the prebuilt toolchains that are recommended (as they are th=
e ones
> >> >> >we use in CI), and update a few places to reference these vendor-n=
eutral
> >> >> >tools.
> >> >> >
> >> >> >Next, we can include the reproducible builds section directly in t=
he
> >> >> >compile instructions rather than as a small standalone file.
> >> >> >
> >> >> >Finally, we update the sandbox document to reflect both the name c=
hange
> >> >> >as well as what is specifically required to build sandbox.
> >> >> >
> >> >> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >> >> >---
> >> >> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >> >---
> >> >> > doc/arch/sandbox/sandbox.rst       |  5 ++-
> >> >> > doc/build/{gcc.rst =3D> compile.rst} | 64 +++++++++++++++++++++++=
+++----
> >> >> > doc/build/index.rst                |  3 +-
> >> >> > doc/build/reproducible.rst         | 27 -------------
> >> >> > 4 files changed, 61 insertions(+), 38 deletions(-)
> >> >> > rename doc/build/{gcc.rst =3D> compile.rst} (73%)
> >> >> > delete mode 100644 doc/build/reproducible.rst
> >> >> >
> >> >> >diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandb=
ox.rst
> >> >> >index 5f8db126657f..f2ed5a25c115 100644
> >> >> >--- a/doc/arch/sandbox/sandbox.rst
> >> >> >+++ b/doc/arch/sandbox/sandbox.rst
> >> >> >@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
> >> >> >=20
> >> >> > Note that standalone/API support is not available at present.
> >> >> >=20
> >> >> >-
> >> >> > Prerequisites
> >> >> > -------------
> >> >> >=20
> >> >> >-Install the dependencies noted in :doc:`../../build/gcc`.
> >> >> >+In addition to the normal dependencies shows in the :doc:`general=
 build
> >> >> >+instructions <../../build/compile>` to enable display support SDL=
2 libraries
> >> >> >+need to be available.
> >> >> >=20
> >> >> >=20
> >> >> > Basic Operation
> >> >> >diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
> >> >> >similarity index 73%
> >> >> >rename from doc/build/gcc.rst
> >> >> >rename to doc/build/compile.rst
> >> >> >index 3c6465772729..ef9c8545835a 100644
> >> >> >--- a/doc/build/gcc.rst
> >> >> >+++ b/doc/build/compile.rst
> >> >> >@@ -1,11 +1,19 @@
> >> >> >-Building with GCC
> >> >> >-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >+Building U-Boot
> >> >> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >=20
> >> >> > Dependencies
> >> >> > ------------
> >> >> >=20
> >> >> >-For building U-Boot you need a GCC compiler for your host platfor=
m. If you
> >> >> >-are not building on the target platform you further need  a GCC c=
ross compiler.
> >> >> >+For building U-Boot you need the general build tools such as `mak=
e` and a C
> >> >> >+compiler for your host platform. Next, if you are not building on=
 the same
> >> >> >+architecture as the target platform you further need a C cross co=
mpiler.
> >> >> >+Furthermore, some target platforms require additional host tools =
to be present
> >> >> >+and their package names may vary slightly dependinng on the namin=
g scheme used
> >> >> >+by a particular host OS.
> >> >> >+
> >> >> >+In general, GCC should be used for both the host and target C com=
piler. Using
> >> >> >+:doc:`clang <clang>` is supported but please see the documented i=
ssues for it as
> >> >> >+well.
> >> >> >=20
> >> >> > Debian based
> >> >> > ~~~~~~~~~~~~
> >> >> >@@ -69,6 +77,17 @@ Depending on the build target further packages =
may be needed:
> >> >> > * riscv64 S-mode targets: opensbi
> >> >> > * some arm64 targets: arm-trusted-firmware
> >> >> >=20
> >> >> >+Prebuilt
> >> >> >+~~~~~~~~
> >> >> >+
> >> >> >+Another option, which the project uses for CI for example, is to =
use a prebuilt
> >> >> >+toolchain. For the most part, we use the latest `kernel.org`_ pre=
buit binaries,
> >> >> >+but there are a few architectures that require their own specific=
 toolchains
> >> >> >+still.
> >> >> >+
> >> >> >+In general, examples found within the documentation here refer to=
 the tools
> >> >> >+found here and exceptions will be noted where relevant.
> >> >> >+
> >> >> > Prerequisites
> >> >> > -------------
> >> >> >=20
> >> >> >@@ -112,11 +131,11 @@ command line or export it beforehand.
> >> >> >=20
> >> >> >     CROSS_COMPILE=3D<compiler-prefix> make
> >> >> >=20
> >> >> >-Assuming cross compiling on Debian for ARMv8 this would be
> >> >> >+Assuming cross compiling for ARMv8 this would be
> >> >> >=20
> >> >> > .. code-block:: bash
> >> >> >=20
> >> >> >-    CROSS_COMPILE=3Daarch64-linux-gnu- make
> >> >> >+    CROSS_COMPILE=3Daarch64-linux- make
> >> >>=20
> >> >> GCC uses triples to specify the architecture. With the suggested ch=
ange building will fail on many distros, e.g. in our CI image.
> >> >>=20
> >> >> cf. https://gcc.gnu.org/install/specific.html#aarch64-x-x
> >> >
> >> >But this is what the kernel.org compiler is called, and for consisten=
cy
> >> >we should reference the reference compiler in our docs. I'm wanting to
> >> >follow up and change everyone to use consistent names.
> >> >
> >>=20
> >> Please, do not asume that Linux distros will change.=20
> >>=20
> >> Users will and should use the tools provided by their distros. Side lo=
ading foreign binaries is a secutity risc which should be avoided.
> >>=20
> >> I cannot see what is inconsistent about sticking to triples.
> >
> >We need to be consistent within our docs, and we aren't today. And
> >"-gnu" isn't a required suffix for aarch64 linux toolchains as not all
> >distributions do that. I'd be open to wording suggesting that users
> >install tools recommended by their vendors, but that still won't give us
> >consistent names due to "aarch64-poky-linux-" being what other vendor
> >tools will be.
> >
>=20
> On which operating systems will CROSS_COMPILE=3Daarch64-linux- work for t=
he distro tools?
>=20
> On which will CROSS_COMPILE=3Daarch64-linux-gnu- work?

Should we document what we test? We don't test distribution tools
because then we would have to test some number of distributions. And
distro tools can be too old. I guess the biggest problem is that I see
distro tools as a fall back option and you see kernel.org prebuilt
toolchains as a fallback option.

--=20
Tom

--M+PxOaeQ8CEUNxww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXPYKUACgkQFHw5/5Y0
tyzw6Qv/YH4/5y7oxw7hfYxHHZ13HCTeRhDNvzRko4XSdYk/I8UV1yqX6L8aeqyZ
MpgZ3GKfcG6FfdqvD5I5No/7C0BqK1B2Pb8b0e4KpIPXoAGuZGtAkPP8LGyLU+72
Qb0/8kpNZlBD0Lo42An01aSYNJPauQks6BxgUOCSIMvUnUd6tSLxfMNzmoVEhgRw
30jWifKlurxauWcRH5KVrl/8VubQ+W0kH/zqP+yKwWTf+iAxL9sYATevzKZz4sIT
TNAXZKJPVAPgERMW6hZGcH5JbnjkQHOX7JL2NdWgjnv7FbkVIZPDHHqxDScQpYur
Z22CAvPUIRtQt5iHKXS0luoNIvG9WnssHIK0/FLHy9DarA0rgaPIP0PNbmi4BJtg
cmwRKjJOf1Mn0L6+3ef77LJIP1RfFltuls8SR7UtA1QZ5B2OE7TO98SVbQXBMLQo
uqyc2Z1H9H5wdPH2gzyaUDBmu60PnruWRI0uYoT+sPZSi8dNjN75L6O2m9Ikehuq
1tf6nsLR
=nazt
-----END PGP SIGNATURE-----

--M+PxOaeQ8CEUNxww--
