Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A7C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CA087E1B;
	Thu, 15 Feb 2024 22:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U7WcfcS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AC787DF4; Thu, 15 Feb 2024 22:24:55 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066B787C83
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 22:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708032281; x=1708637081; i=xypron.glpk@gmx.de;
 bh=NTEOJS6wFXdFrzsPOqT/3X2n+Ui+kAwcXkmkxL2EHZA=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=U7WcfcS3Zhm8by9HSFcj1seOan8lpUlwHh/s/v16KM1s4dUATgI001X6qfxEEDtO
 x0XeR+VhKnskjmQhNPWoEDSAXdrbhJMBOaN6z9Mn2D/yCw3dK2M8sgbN7mSJgtbDh
 SOhXDmygexb9iO7hHatY5hBDx1N6XJjpxojDxcKptuzDfW6PkoYPpdaFfBiFBvVlM
 PS72+rNje6h6u+wHj2KXkdaOt5bKh8m7GnGpK4dlTzga3SZERfRK/6z62qRCxoqRS
 w5ixhihGU1BqLE0StWqT1hJOTppsVQal3cXWIH+R0bM2d0dvgNWOUHhHSg5RO18es
 66qVJpyqvz7x7AHOHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1rH0Vd2vhA-00JqX3; Thu, 15
 Feb 2024 22:24:41 +0100
Date: Thu, 15 Feb 2024 22:24:40 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_doc=3A_Rework_the_gcc_sect?=
 =?US-ASCII?Q?ion_to_reflect_general_build_instructions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240215211025.690964-2-trini@konsulko.com>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
Message-ID: <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/yXarfLMyNG+ZjjbYznxLllaRsiQHI86j2XCPVM1oWeXyNzotkP
 3ZYo5WI1mosrzoFWJxhS9AzW6nlpszX5+2bg8Kb2lYE79EulGMhTgGEhy5BK9K5P/SfwYBp
 nZKKL8p/A2UCvas5jC6Ri5f0f3gOB2BALanWTljHXVsCOlNFxc3Jhdxgc8TvYuVkUoS/xdi
 hVcH2khw4iwlUmn6LIINQ==
UI-OutboundReport: notjunk:1;M01:P0:1+GcrNs9CwY=;87inh9ajDTOWybxQqCqw5xkIb/Q
 ruAb7pOOcRtAH6GetULFuwQit1Y/AU4PwY/Gj+ouLfW1NFDdCRD0udviLGNaB7JEfUykPIdiS
 t/JzckZC+GdKx2XJPsmLodgkQTS57BOV7jZx/XAhVC5sIpNrzrtEawgHm14f8dSGp83dEJGA5
 5ccAIH/RXoywNK9GGfqkSQBCUTNmM0Ilm4G1BvgwI8NQV+dYGh3OQydy4snAnKmJtMfJ/CKYb
 +EKbfhGcsaR8hDJJ4cmmYYoiVIMva1rpkU2fUcMzBELUmB40+5v3o0zcgswUfhjxauszpTZoY
 8dQ7O5A/pao7Ntl//YGtBtFCD6VxtiPEC6EbD8Q1b1+/VdCGE0gOr4/2NPdlGfQw+TqotNkOW
 JRiLptv8zPaGunN+rK2qQGMeCqzShcS/oQmh5DjmHdiBo4XIqOtj/vz4+6arzPXcgqgsWYsCd
 dnmBEJ4VQjgw5heRd3KCCMrLk6Eu19L9ZndvQlda0Sw9ISYqXU4iMhzq158bhg5FosilfAn2D
 KR+VXmshkpU8/jDqCS3r50ijsz60YWRwqUWZouBoLvpzc4/H1Xnn0eosj6S6MFqG7Nuz1InoY
 ehGNP7CgALHBboBZ9bwtYRuo/hkd4j2NeGKSACFEEzpKZeG2gun9/7Eh34AzHOUDsAccH9ekb
 TZKdeo4kwpp8EAWAtdEv0giPbNOYq4rpX6NdLxiTGAjgk1ZVXx9+I+DfiREjxQ4G4leJNkAPm
 HU47Xj3HQTCP4eUmzRiBVdFjQqyzsEU5Qr+j5zALizC0WO0Ff2zyvnUhxVqy1a+76uG3ujigW
 pwTc+I3QMK24H83NCqfmlWwUuYK5Cpyh4q7l0lflEZcAU=
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



Am 15=2E Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>The first big issue is that the "gcc" file talked a lot about the
>general build requirements as well, but was titled in a gcc-centric
>manner=2E Solve this by renaming the file to compile=2Erst and more fully
>reflecting that it is general build instructions=2E Next, add a section
>about the prebuilt toolchains that are recommended (as they are the ones
>we use in CI), and update a few places to reference these vendor-neutral
>tools=2E
>
>Next, we can include the reproducible builds section directly in the
>compile instructions rather than as a small standalone file=2E
>
>Finally, we update the sandbox document to reflect both the name change
>as well as what is specifically required to build sandbox=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>---
> doc/arch/sandbox/sandbox=2Erst       |  5 ++-
> doc/build/{gcc=2Erst =3D> compile=2Erst} | 64 ++++++++++++++++++++++++++=
----
> doc/build/index=2Erst                |  3 +-
> doc/build/reproducible=2Erst         | 27 -------------
> 4 files changed, 61 insertions(+), 38 deletions(-)
> rename doc/build/{gcc=2Erst =3D> compile=2Erst} (73%)
> delete mode 100644 doc/build/reproducible=2Erst
>
>diff --git a/doc/arch/sandbox/sandbox=2Erst b/doc/arch/sandbox/sandbox=2E=
rst
>index 5f8db126657f=2E=2Ef2ed5a25c115 100644
>--- a/doc/arch/sandbox/sandbox=2Erst
>+++ b/doc/arch/sandbox/sandbox=2Erst
>@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts=2E
>=20
> Note that standalone/API support is not available at present=2E
>=20
>-
> Prerequisites
> -------------
>=20
>-Install the dependencies noted in :doc:`=2E=2E/=2E=2E/build/gcc`=2E
>+In addition to the normal dependencies shows in the :doc:`general build
>+instructions <=2E=2E/=2E=2E/build/compile>` to enable display support SD=
L2 libraries
>+need to be available=2E
>=20
>=20
> Basic Operation
>diff --git a/doc/build/gcc=2Erst b/doc/build/compile=2Erst
>similarity index 73%
>rename from doc/build/gcc=2Erst
>rename to doc/build/compile=2Erst
>index 3c6465772729=2E=2Eef9c8545835a 100644
>--- a/doc/build/gcc=2Erst
>+++ b/doc/build/compile=2Erst
>@@ -1,11 +1,19 @@
>-Building with GCC
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+Building U-Boot
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Dependencies
> ------------
>=20
>-For building U-Boot you need a GCC compiler for your host platform=2E If=
 you
>-are not building on the target platform you further need  a GCC cross co=
mpiler=2E
>+For building U-Boot you need the general build tools such as `make` and =
a C
>+compiler for your host platform=2E Next, if you are not building on the =
same
>+architecture as the target platform you further need a C cross compiler=
=2E
>+Furthermore, some target platforms require additional host tools to be p=
resent
>+and their package names may vary slightly dependinng on the naming schem=
e used
>+by a particular host OS=2E
>+
>+In general, GCC should be used for both the host and target C compiler=
=2E Using
>+:doc:`clang <clang>` is supported but please see the documented issues f=
or it as
>+well=2E
>=20
> Debian based
> ~~~~~~~~~~~~
>@@ -69,6 +77,17 @@ Depending on the build target further packages may be =
needed:
> * riscv64 S-mode targets: opensbi
> * some arm64 targets: arm-trusted-firmware
>=20
>+Prebuilt
>+~~~~~~~~
>+
>+Another option, which the project uses for CI for example, is to use a p=
rebuilt
>+toolchain=2E For the most part, we use the latest `kernel=2Eorg`_ prebui=
t binaries,
>+but there are a few architectures that require their own specific toolch=
ains
>+still=2E
>+
>+In general, examples found within the documentation here refer to the to=
ols
>+found here and exceptions will be noted where relevant=2E
>+
> Prerequisites
> -------------
>=20
>@@ -112,11 +131,11 @@ command line or export it beforehand=2E
>=20
>     CROSS_COMPILE=3D<compiler-prefix> make
>=20
>-Assuming cross compiling on Debian for ARMv8 this would be
>+Assuming cross compiling for ARMv8 this would be
>=20
> =2E=2E code-block:: bash
>=20
>-    CROSS_COMPILE=3Daarch64-linux-gnu- make
>+    CROSS_COMPILE=3Daarch64-linux- make

GCC uses triples to specify the architecture=2E With the suggested change =
building will fail on many distros, e=2Eg=2E in our CI image=2E

cf=2E https://gcc=2Egnu=2Eorg/install/specific=2Ehtml#aarch64-x-x

>=20
> Build parameters
> ~~~~~~~~~~~~~~~~
>@@ -131,13 +150,40 @@ You can speed up compilation by parallelization usi=
ng the -j parameter, e=2Eg=2E
>=20
> =2E=2E code-block:: bash
>=20
>-    CROSS_COMPILE=3Daarch64-linux-gnu- make -j$(nproc)
>+    CROSS_COMPILE=3Daarch64-linux- make -j$(nproc)

ditto

Best regards

Heinrich

>=20
> Further important build parameters are
>=20
> * O=3D<dir> - generate all output files in directory <dir>, including =
=2Econfig
> * V=3D1 - verbose build
>=20
>+
>+Reproducible builds
>+~~~~~~~~~~~~~~~~~~~
>+
>+In order to achieve reproducible builds, timestamps used in the U-Boot b=
uild
>+process have to be set to a fixed value=2E
>+
>+This is done using the SOURCE_DATE_EPOCH environment variable which spec=
ifies
>+the number of seconds since 1970-01-01T00:00:00Z=2E
>+
>+
>+To build the sandbox with 2023-01-01T00:00:00Z as timestamp we can use:
>+
>+=2E=2E code-block:: bash
>+
>+    make sandbox_defconfig
>+    SOURCE_DATE_EPOCH=3D1672531200 make
>+
>+This date is shown when we launch U-Boot:
>+
>+=2E=2E code-block:: console
>+
>+    =2E/u-boot -T
>+    U-Boot 2023=2E01 (Jan 01 2023 - 00:00:00 +0000)
>+
>+The same effect can be obtained with buildman using the `-r` flag=2E
>+
> Devicetree compiler
> ~~~~~~~~~~~~~~~~~~~
>=20
>@@ -176,6 +222,8 @@ builds during development, you can disable it by sett=
ing `NO_LTO` to `1`=2E
>=20
>     NO_LTO=3D1 make
>=20
>+Note that not all platforms which enable LTO support disabling it howeve=
r=2E
>+
> Other build targets
> ~~~~~~~~~~~~~~~~~~~
>=20
>@@ -195,3 +243,5 @@ Installation
>=20
> The process for installing U-Boot on the target device is device specifi=
c=2E
> Please, refer to the board specific documentation :doc:`=2E=2E/board/ind=
ex`=2E
>+
>+=2E=2E _`kernel=2Eorg`: https://mirrors=2Eedge=2Ekernel=2Eorg/pub/tools/=
crosstool/files/bin/
>diff --git a/doc/build/index=2Erst b/doc/build/index=2Erst
>index 7a4507b57461=2E=2E5262b4f3c1b9 100644
>--- a/doc/build/index=2Erst
>+++ b/doc/build/index=2Erst
>@@ -7,9 +7,8 @@ Build U-Boot
>    :maxdepth: 2
>=20
>    source
>-   gcc
>+   compile
>    clang
>-   reproducible
>    docker
>    tools
>    buildman
>diff --git a/doc/build/reproducible=2Erst b/doc/build/reproducible=2Erst
>deleted file mode 100644
>index 8b030f469d7c=2E=2E000000000000
>--- a/doc/build/reproducible=2Erst
>+++ /dev/null
>@@ -1,27 +0,0 @@
>-Reproducible builds
>-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>-
>-In order to achieve reproducible builds, timestamps used in the U-Boot b=
uild
>-process have to be set to a fixed value=2E
>-
>-This is done using the SOURCE_DATE_EPOCH environment variable which spec=
ifies
>-the number of seconds since 1970-01-01T00:00:00Z=2E
>-
>-Example
>--------
>-
>-To build the sandbox with 2023-01-01T00:00:00Z as timestamp we can use:
>-
>-=2E=2E code-block:: bash
>-
>-    make sandbox_defconfig
>-    SOURCE_DATE_EPOCH=3D1672531200 make
>-
>-This date is shown when we launch U-Boot:
>-
>-=2E=2E code-block:: console
>-
>-    =2E/u-boot -T
>-    U-Boot 2023=2E01 (Jan 01 2023 - 00:00:00 +0000)
>-
>-The same effect can be obtained with buildman using the `-r` flag=2E
