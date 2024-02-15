Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3274C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9F087DF4;
	Thu, 15 Feb 2024 22:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zbq9vwB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D40787DF4; Thu, 15 Feb 2024 22:28:39 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE81687E12
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 22:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-607ec539525so5953287b3.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708032506; x=1708637306; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCKTP3XtxFQ3ehKb5xchMrZ4MVUy93EOf6zsXJad3Tg=;
 b=Zbq9vwB8QupEc677h/jWHx13WUbyatTny6F0lI7zYNw3K+GGtPvEKDW8a26sRpHnLp
 tuYIlWn8vE4/NjdKEVmQGik0KTHjqhdphFGjkVh4nFN2F/dtQqx5ZtxcWHY31eKv6Ko3
 ATA4nHHWSdy0OahVIzwHCkBNtJw0fMCyHD/+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708032506; x=1708637306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCKTP3XtxFQ3ehKb5xchMrZ4MVUy93EOf6zsXJad3Tg=;
 b=jq90xcMLen42q9Baq4Kcq0McAcZIniiLz3PjQpMq0r30dU6KFeRJQUjH+cPDIMlCNy
 jRWZZP1rvD/x9kS7hW0ExaZy9CRafU/Y5qK/lOzmAHQtvyKBkxUafMEMCPGhvvf8C68i
 Ek8IFmfJ+4GyTLAJjBCKNNZS8F50tu9dKeNiHkvM1Gty3WSgSXS6A9f3hXsO96A+wa3E
 Gf1Pkl5KZhiym5tH5R7w6dgHdfu7WF+9vIzZjJm9F7bVWjcumIDWrFryV1vin7kxna87
 O7GjaobkpS4Dubm/iOFFwR6JimulqT+2JRyROdSGZYXi1fDE2vO1oa0EbMiw6lT9rwQV
 Qm4g==
X-Gm-Message-State: AOJu0YzbEBgTPc08KMeeDFdX+ekFeaiayIlfd0lZWN4gk0CuIrCyZL30
 wQivTsifVw6D9w56CLDcjXFVgSDokPx4EvmF+jjRI6qxPL77gSVSCdGs+UZ2UgrDHf8cq1H278X
 T
X-Google-Smtp-Source: AGHT+IF5cudCzjzTmuePibh8I3Axx6TT8OCZg3Uzv+t4Vsji/Mb3Y/CauCdwuH1JrcVcV421PmE75A==
X-Received: by 2002:a81:6f0b:0:b0:607:ca2e:f23e with SMTP id
 k11-20020a816f0b000000b00607ca2ef23emr3164858ywc.30.1708032506337; 
 Thu, 15 Feb 2024 13:28:26 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 s4-20020a817704000000b0060788326365sm59703ywc.0.2024.02.15.13.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 13:28:25 -0800 (PST)
Date: Thu, 15 Feb 2024 16:28:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Message-ID: <20240215212824.GF3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wxHb47uCybLtf6lc"
Content-Disposition: inline
In-Reply-To: <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
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


--wxHb47uCybLtf6lc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 15. Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >The first big issue is that the "gcc" file talked a lot about the
> >general build requirements as well, but was titled in a gcc-centric
> >manner. Solve this by renaming the file to compile.rst and more fully
> >reflecting that it is general build instructions. Next, add a section
> >about the prebuilt toolchains that are recommended (as they are the ones
> >we use in CI), and update a few places to reference these vendor-neutral
> >tools.
> >
> >Next, we can include the reproducible builds section directly in the
> >compile instructions rather than as a small standalone file.
> >
> >Finally, we update the sandbox document to reflect both the name change
> >as well as what is specifically required to build sandbox.
> >
> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >---
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >---
> > doc/arch/sandbox/sandbox.rst       |  5 ++-
> > doc/build/{gcc.rst =3D> compile.rst} | 64 ++++++++++++++++++++++++++----
> > doc/build/index.rst                |  3 +-
> > doc/build/reproducible.rst         | 27 -------------
> > 4 files changed, 61 insertions(+), 38 deletions(-)
> > rename doc/build/{gcc.rst =3D> compile.rst} (73%)
> > delete mode 100644 doc/build/reproducible.rst
> >
> >diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
> >index 5f8db126657f..f2ed5a25c115 100644
> >--- a/doc/arch/sandbox/sandbox.rst
> >+++ b/doc/arch/sandbox/sandbox.rst
> >@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
> >=20
> > Note that standalone/API support is not available at present.
> >=20
> >-
> > Prerequisites
> > -------------
> >=20
> >-Install the dependencies noted in :doc:`../../build/gcc`.
> >+In addition to the normal dependencies shows in the :doc:`general build
> >+instructions <../../build/compile>` to enable display support SDL2 libr=
aries
> >+need to be available.
> >=20
> >=20
> > Basic Operation
> >diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
> >similarity index 73%
> >rename from doc/build/gcc.rst
> >rename to doc/build/compile.rst
> >index 3c6465772729..ef9c8545835a 100644
> >--- a/doc/build/gcc.rst
> >+++ b/doc/build/compile.rst
> >@@ -1,11 +1,19 @@
> >-Building with GCC
> >-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+Building U-Boot
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Dependencies
> > ------------
> >=20
> >-For building U-Boot you need a GCC compiler for your host platform. If =
you
> >-are not building on the target platform you further need  a GCC cross c=
ompiler.
> >+For building U-Boot you need the general build tools such as `make` and=
 a C
> >+compiler for your host platform. Next, if you are not building on the s=
ame
> >+architecture as the target platform you further need a C cross compiler.
> >+Furthermore, some target platforms require additional host tools to be =
present
> >+and their package names may vary slightly dependinng on the naming sche=
me used
> >+by a particular host OS.
> >+
> >+In general, GCC should be used for both the host and target C compiler.=
 Using
> >+:doc:`clang <clang>` is supported but please see the documented issues =
for it as
> >+well.
> >=20
> > Debian based
> > ~~~~~~~~~~~~
> >@@ -69,6 +77,17 @@ Depending on the build target further packages may be=
 needed:
> > * riscv64 S-mode targets: opensbi
> > * some arm64 targets: arm-trusted-firmware
> >=20
> >+Prebuilt
> >+~~~~~~~~
> >+
> >+Another option, which the project uses for CI for example, is to use a =
prebuilt
> >+toolchain. For the most part, we use the latest `kernel.org`_ prebuit b=
inaries,
> >+but there are a few architectures that require their own specific toolc=
hains
> >+still.
> >+
> >+In general, examples found within the documentation here refer to the t=
ools
> >+found here and exceptions will be noted where relevant.
> >+
> > Prerequisites
> > -------------
> >=20
> >@@ -112,11 +131,11 @@ command line or export it beforehand.
> >=20
> >     CROSS_COMPILE=3D<compiler-prefix> make
> >=20
> >-Assuming cross compiling on Debian for ARMv8 this would be
> >+Assuming cross compiling for ARMv8 this would be
> >=20
> > .. code-block:: bash
> >=20
> >-    CROSS_COMPILE=3Daarch64-linux-gnu- make
> >+    CROSS_COMPILE=3Daarch64-linux- make
>=20
> GCC uses triples to specify the architecture. With the suggested change b=
uilding will fail on many distros, e.g. in our CI image.
>=20
> cf. https://gcc.gnu.org/install/specific.html#aarch64-x-x

But this is what the kernel.org compiler is called, and for consistency
we should reference the reference compiler in our docs. I'm wanting to
follow up and change everyone to use consistent names.

--=20
Tom

--wxHb47uCybLtf6lc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXOgfQACgkQFHw5/5Y0
tyzpZwv/VQZZKTqXNOZqoMCNwMhC/j0wdX3yeT6eqsV4n9wjTy5oMZrkRZNM8teR
AijE6axHRUy8vXBIOe7BtQdtS8dxSwrBHmOjMCKW1grTxspYRY70FD9CWotiTlkb
8+4vgoPIl3lEAM3102RXM8OwMTCKjUgbdHyfEpIX1aXEI33nVF4eH/mlrtxcbs0x
8Sspcsnr6yQkKqCclQGRVvQwoNkJlqQbDEgTIwUSSaPzPQ1iOEyxK+5uv1uTJuTN
p7dz2/lH9czY3iC/qi//z1FR6rxD3b+nNU3nhnLCeiBRnUPu+XqU/jY9TXaRjUlJ
24wqNbFvbWJSxQDWNtkbSnRPIgav9tz+ZIFa+NNMPaK5zmSUX/7EYDD63yIiZ8cq
qqAc12TJtVZ4i7g7My9dcgg+7eu3XeEEdbym1yfYumUBi3ShzjVIdyipjNDRwCzh
QlpBam9RZ2v3v1Ef9hfZJz+iAGa+d+00sjip1FFXOP0oAXpryCIcrONLhHDcFxWy
bBZ4Q+6o
=psyj
-----END PGP SIGNATURE-----

--wxHb47uCybLtf6lc--
