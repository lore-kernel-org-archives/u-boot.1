Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9199AC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 22:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C2D87CC1;
	Thu, 15 Feb 2024 23:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YD8nmiPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF23587A80; Thu, 15 Feb 2024 23:00:46 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194FC87DC1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 23:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-607d633381fso804997b3.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708034435; x=1708639235; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lGtUkkIrADc19z1top0lqWs8wOfWFzh2/PtvKubKwX0=;
 b=YD8nmiPdPONHZ4eoS+oY+aX1kVk0QT7iNGL9hsAxNI1wQHeVXXWTpGYNfMlfMB56Cw
 Tma6+2IbC6fvfaar0UHLu9+A9MKifB95CvM7mcU8AnVUllsq7XSbwd9nD0TBmU5fcgne
 diKWnlh2FFe3wnVl9si9w3GPiT7CIHi8zhHw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708034435; x=1708639235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGtUkkIrADc19z1top0lqWs8wOfWFzh2/PtvKubKwX0=;
 b=mHoQqZ01QdjrOVG3xTi/fAYKQeqwHduzbXlpwZx3xEE+Jmw1St9krmzVNE1lU03MlD
 bp27jvwhZlx9D7Rrz2w/b+nyZsseR11x4Nu+NGSh5DkPGSNUqeQpYj9JfbGeoxfq9H7v
 DM+tt4SdlnsCImo0f0hrGZNX0aTyjWtiAISifiQIWzdgGwha6CGsOe3Ni5TVbzhlCaqH
 R5/ei45t1UTMpS84HZ/bCD72RM3DkTE862x57pZUwZOWrYMB+Z+Gji9Y/OTSwinidmI3
 T0zeoUMujhyhiPLuffMrBsgfTEFLzro0JFbXz8uPnV36jHidjY8r1lLwjM/XAYCpJhHa
 8Exg==
X-Gm-Message-State: AOJu0Yz+PdDyI8ZYNOxZiNZHw+iAAUW5ijBJZb16QJz641LwaTViUhcx
 mYP5Xyfh1lUGttjSAgIOZ+uf01IZF6KIt6lj6puu2NexcLgEzrXn8fUU0QSQ9dw=
X-Google-Smtp-Source: AGHT+IHSusZzk4AyEW8lnB61ECM/iAMDegsVIG3qJBuCytG8sXrJjqjV81xQ+JCNYKXR2WxYZGMYcg==
X-Received: by 2002:a0d:d842:0:b0:607:8057:dec9 with SMTP id
 a63-20020a0dd842000000b006078057dec9mr3433869ywe.7.1708034434676; 
 Thu, 15 Feb 2024 14:00:34 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d85-20020a814f58000000b00607aa6c6d09sm66241ywb.30.2024.02.15.14.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:00:34 -0800 (PST)
Date: Thu, 15 Feb 2024 17:00:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Message-ID: <20240215220032.GG3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
 <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OBBMIBbuTr5S9u15"
Content-Disposition: inline
In-Reply-To: <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
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


--OBBMIBbuTr5S9u15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:53:59PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 15. Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
> >>=20
> >>=20
> >> Am 15. Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >> >The first big issue is that the "gcc" file talked a lot about the
> >> >general build requirements as well, but was titled in a gcc-centric
> >> >manner. Solve this by renaming the file to compile.rst and more fully
> >> >reflecting that it is general build instructions. Next, add a section
> >> >about the prebuilt toolchains that are recommended (as they are the o=
nes
> >> >we use in CI), and update a few places to reference these vendor-neut=
ral
> >> >tools.
> >> >
> >> >Next, we can include the reproducible builds section directly in the
> >> >compile instructions rather than as a small standalone file.
> >> >
> >> >Finally, we update the sandbox document to reflect both the name chan=
ge
> >> >as well as what is specifically required to build sandbox.
> >> >
> >> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >> >---
> >> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >---
> >> > doc/arch/sandbox/sandbox.rst       |  5 ++-
> >> > doc/build/{gcc.rst =3D> compile.rst} | 64 ++++++++++++++++++++++++++=
----
> >> > doc/build/index.rst                |  3 +-
> >> > doc/build/reproducible.rst         | 27 -------------
> >> > 4 files changed, 61 insertions(+), 38 deletions(-)
> >> > rename doc/build/{gcc.rst =3D> compile.rst} (73%)
> >> > delete mode 100644 doc/build/reproducible.rst
> >> >
> >> >diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.=
rst
> >> >index 5f8db126657f..f2ed5a25c115 100644
> >> >--- a/doc/arch/sandbox/sandbox.rst
> >> >+++ b/doc/arch/sandbox/sandbox.rst
> >> >@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
> >> >=20
> >> > Note that standalone/API support is not available at present.
> >> >=20
> >> >-
> >> > Prerequisites
> >> > -------------
> >> >=20
> >> >-Install the dependencies noted in :doc:`../../build/gcc`.
> >> >+In addition to the normal dependencies shows in the :doc:`general bu=
ild
> >> >+instructions <../../build/compile>` to enable display support SDL2 l=
ibraries
> >> >+need to be available.
> >> >=20
> >> >=20
> >> > Basic Operation
> >> >diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
> >> >similarity index 73%
> >> >rename from doc/build/gcc.rst
> >> >rename to doc/build/compile.rst
> >> >index 3c6465772729..ef9c8545835a 100644
> >> >--- a/doc/build/gcc.rst
> >> >+++ b/doc/build/compile.rst
> >> >@@ -1,11 +1,19 @@
> >> >-Building with GCC
> >> >-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >+Building U-Boot
> >> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >=20
> >> > Dependencies
> >> > ------------
> >> >=20
> >> >-For building U-Boot you need a GCC compiler for your host platform. =
If you
> >> >-are not building on the target platform you further need  a GCC cros=
s compiler.
> >> >+For building U-Boot you need the general build tools such as `make` =
and a C
> >> >+compiler for your host platform. Next, if you are not building on th=
e same
> >> >+architecture as the target platform you further need a C cross compi=
ler.
> >> >+Furthermore, some target platforms require additional host tools to =
be present
> >> >+and their package names may vary slightly dependinng on the naming s=
cheme used
> >> >+by a particular host OS.
> >> >+
> >> >+In general, GCC should be used for both the host and target C compil=
er. Using
> >> >+:doc:`clang <clang>` is supported but please see the documented issu=
es for it as
> >> >+well.
> >> >=20
> >> > Debian based
> >> > ~~~~~~~~~~~~
> >> >@@ -69,6 +77,17 @@ Depending on the build target further packages may=
 be needed:
> >> > * riscv64 S-mode targets: opensbi
> >> > * some arm64 targets: arm-trusted-firmware
> >> >=20
> >> >+Prebuilt
> >> >+~~~~~~~~
> >> >+
> >> >+Another option, which the project uses for CI for example, is to use=
 a prebuilt
> >> >+toolchain. For the most part, we use the latest `kernel.org`_ prebui=
t binaries,
> >> >+but there are a few architectures that require their own specific to=
olchains
> >> >+still.
> >> >+
> >> >+In general, examples found within the documentation here refer to th=
e tools
> >> >+found here and exceptions will be noted where relevant.
> >> >+
> >> > Prerequisites
> >> > -------------
> >> >=20
> >> >@@ -112,11 +131,11 @@ command line or export it beforehand.
> >> >=20
> >> >     CROSS_COMPILE=3D<compiler-prefix> make
> >> >=20
> >> >-Assuming cross compiling on Debian for ARMv8 this would be
> >> >+Assuming cross compiling for ARMv8 this would be
> >> >=20
> >> > .. code-block:: bash
> >> >=20
> >> >-    CROSS_COMPILE=3Daarch64-linux-gnu- make
> >> >+    CROSS_COMPILE=3Daarch64-linux- make
> >>=20
> >> GCC uses triples to specify the architecture. With the suggested chang=
e building will fail on many distros, e.g. in our CI image.
> >>=20
> >> cf. https://gcc.gnu.org/install/specific.html#aarch64-x-x
> >
> >But this is what the kernel.org compiler is called, and for consistency
> >we should reference the reference compiler in our docs. I'm wanting to
> >follow up and change everyone to use consistent names.
> >
>=20
> Please, do not asume that Linux distros will change.=20
>=20
> Users will and should use the tools provided by their distros. Side loadi=
ng foreign binaries is a secutity risc which should be avoided.
>=20
> I cannot see what is inconsistent about sticking to triples.

We need to be consistent within our docs, and we aren't today. And
"-gnu" isn't a required suffix for aarch64 linux toolchains as not all
distributions do that. I'd be open to wording suggesting that users
install tools recommended by their vendors, but that still won't give us
consistent names due to "aarch64-poky-linux-" being what other vendor
tools will be.

--=20
Tom

--OBBMIBbuTr5S9u15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXOiXwACgkQFHw5/5Y0
tyxGAAv8Cp2c0FyBwNXMx8xpHYPZnLv3KMRaowHmnAuAgtEulKWZU25L9ncG2wdE
VuNVymsaNLqeOxvhQNLJRdCpr1SoAerkyfO9jM7r/Z9b6WLPnL3svzcVYOfKdJfu
8Vw7rx3CbrD5HNucKHuNYtJJDX5UqtPrEuD4URDd+FI+dE9DizhZoLnwVR9slKoz
DyNEAFi6efQhYoAyxCutheGcYH53A14gLY840+ID6zPZ4Hf+AwtjvytvVHnZqgd/
lfuLgS6FDc2eAerrJ6LaF7mW/RRNBTY/M1LmfxZ9xU3/WBBOsW6fq5PyRuEPrOPL
YnMK3x6Sfjl+aknYKoMcuwgrj4eYZAYhD+J0lUqBpRRA1esdm3QBbQ048N52Qdy7
6bnlMgYcN5LuiWjcApUpg0G9HFVW3EDD3+20f3SbYzBM8kV5Hy52TtUtx87gy706
YP77q05IV3Kjcqp4QYkcKJTmLMWyRd+5kMEOwrNt8aT3by3K1WHAcXitmgsBY8eE
Xuk1W5E8
=I5pH
-----END PGP SIGNATURE-----

--OBBMIBbuTr5S9u15--
