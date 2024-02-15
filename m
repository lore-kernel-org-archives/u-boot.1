Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B479C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8018B87BBA;
	Thu, 15 Feb 2024 22:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r5N97fX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A588487D6B; Thu, 15 Feb 2024 22:54:06 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1B786308
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 22:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708034040; x=1708638840; i=xypron.glpk@gmx.de;
 bh=AFeIv6FDOvuAadMjSaKsIBOd9Uco6wyDdn5gFSYE0Dw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=r5N97fX+ZzT+6d1xwYqpItRB6VxbYpZ3Z6sU3wHG5vTMYqLAqBy/QoyF7iKEeTSo
 /cUDPV8wHVbM1oSRfsZV4KgYJ5KgbXSwipNN/RnkPxn/XYyHW3dmC/KCqVm3Ipl+w
 QtzH3YiogVYwgX6/HdO7IYX0aRqsCy4yX23SlI7KUvLabe1HMqGj9925A2ZGPoFSi
 66yaQQAo4R4L7tXewp5oy3mnBNOMqKv+/8eI7XaHdviRO89x6EtMWkrfA/cG9ue4F
 BG//t5mop/hX5z259yxzainbtH17Hpoquw+BU3heC9/knK5dy2oh28jbgYcI2Ur5J
 rLBbTIoun70oZawR5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1r82gi20BE-00kPbB; Thu, 15
 Feb 2024 22:54:00 +0100
Date: Thu, 15 Feb 2024 22:53:59 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_doc=3A_Rework_the_gcc_sect?=
 =?US-ASCII?Q?ion_to_reflect_general_build_instructions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240215212824.GF3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
Message-ID: <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sd5ff+uDAtUg273pekESKWnOC7u69aQZfCaNKdoETFkmHK9fnWO
 LXJ5Fjs7ufG0e47AspGOcoA853pG/cQY+j3BFpoKovivEAzUG/VkP6TdQKzmod86hmYPT04
 mfhBHm1WkMKsmIB43l98ul9unnNdBTH3/CEDNbbwOPF6HWROWf+jadcCfjBaQzCZ3FW0pda
 cp1VP7E1jTlBlyGM76OGQ==
UI-OutboundReport: notjunk:1;M01:P0:a5tJFtrdzdk=;d0/h2cdOXENd+OAl2+1mGrAqQtP
 znxMMT32ZqPRmoxFBQIEXwFtXIm0rMyvEInQ0c2q+Xv/WmojxGJuJysEsK6dXirHBnX+Zn14x
 gynyGjtC5jUSbq9Zp6pg5zxrHYvyxM4uesFDo6zFgjXqLIJvOK/6sNENb758w/plwF0PN5rnX
 jP2sgZw9z2qXS/cYNwz7NXYa4aSyG8Gh6li9xStII0RxoHRtVCz+oRDFX2UsF0K70ue0a1COG
 wf7cU40Rb+UQSmwzZJBIDm2HYRZJKzT2XIHUBTXxOlRWFFJ6tfn95Z3kVNeW/9Kuxo4krvIT2
 eINV54pPVoJmAcJ4TvstOxmfT1sBczjYBcc+rhOQoTVOB0yU717UW6zfR8Ne8C+SVZl/46UEz
 04TuyQcMTXAm3BzkWiqiKnM9J5aOYnvZ2h9COKHRght6RPOzlB7uNSxEJ66CzEbJUzk4tmHmQ
 PciIwxgkVXHpZ+FFBr+Z2WIDTt5wyF/h1Cg6cGZqjcv9TiY4SMB/vkVtRXqJsdW8alWSwNkzm
 iEUYecPai36uJ2KKqHMNVxYY3NlI9O4EdbOQIBRx/80l/Lj7EmUFWVnsMsHWfW13mTiIgnrvw
 FwwrE7ya/s0OwQA4uhA3WKDU3k2pCFyT8ag21Whl3x5Abd9Zi5/QWeA1Qrpgl+9NFaFUd1R0B
 fNv5LvfCXvFqoLuJBoIdyDC9wInf8J07gSD99gncIoSJtYf2qwRG9xC0B7YXt+/yFBfG4fnxc
 +mwmIg1z0CkgLLqO5CRWQ467uQAY8Noj7yRJSMzdBiYUPXft1QCAdeN+AoLOH4Y+dGV8QqjLW
 SkeNDQUoBtOI4J2F+dfHnX/ZovuTIzlwqZ2F2bvYZiTPg=
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



Am 15=2E Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
>>=20
>>=20
>> Am 15=2E Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko=2Ec=
om>:
>> >The first big issue is that the "gcc" file talked a lot about the
>> >general build requirements as well, but was titled in a gcc-centric
>> >manner=2E Solve this by renaming the file to compile=2Erst and more fu=
lly
>> >reflecting that it is general build instructions=2E Next, add a sectio=
n
>> >about the prebuilt toolchains that are recommended (as they are the on=
es
>> >we use in CI), and update a few places to reference these vendor-neutr=
al
>> >tools=2E
>> >
>> >Next, we can include the reproducible builds section directly in the
>> >compile instructions rather than as a small standalone file=2E
>> >
>> >Finally, we update the sandbox document to reflect both the name chang=
e
>> >as well as what is specifically required to build sandbox=2E
>> >
>> >Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>> >---
>> >Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >---
>> > doc/arch/sandbox/sandbox=2Erst       |  5 ++-
>> > doc/build/{gcc=2Erst =3D> compile=2Erst} | 64 +++++++++++++++++++++++=
+++----
>> > doc/build/index=2Erst                |  3 +-
>> > doc/build/reproducible=2Erst         | 27 -------------
>> > 4 files changed, 61 insertions(+), 38 deletions(-)
>> > rename doc/build/{gcc=2Erst =3D> compile=2Erst} (73%)
>> > delete mode 100644 doc/build/reproducible=2Erst
>> >
>> >diff --git a/doc/arch/sandbox/sandbox=2Erst b/doc/arch/sandbox/sandbox=
=2Erst
>> >index 5f8db126657f=2E=2Ef2ed5a25c115 100644
>> >--- a/doc/arch/sandbox/sandbox=2Erst
>> >+++ b/doc/arch/sandbox/sandbox=2Erst
>> >@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts=2E
>> >=20
>> > Note that standalone/API support is not available at present=2E
>> >=20
>> >-
>> > Prerequisites
>> > -------------
>> >=20
>> >-Install the dependencies noted in :doc:`=2E=2E/=2E=2E/build/gcc`=2E
>> >+In addition to the normal dependencies shows in the :doc:`general bui=
ld
>> >+instructions <=2E=2E/=2E=2E/build/compile>` to enable display support=
 SDL2 libraries
>> >+need to be available=2E
>> >=20
>> >=20
>> > Basic Operation
>> >diff --git a/doc/build/gcc=2Erst b/doc/build/compile=2Erst
>> >similarity index 73%
>> >rename from doc/build/gcc=2Erst
>> >rename to doc/build/compile=2Erst
>> >index 3c6465772729=2E=2Eef9c8545835a 100644
>> >--- a/doc/build/gcc=2Erst
>> >+++ b/doc/build/compile=2Erst
>> >@@ -1,11 +1,19 @@
>> >-Building with GCC
>> >-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >+Building U-Boot
>> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >=20
>> > Dependencies
>> > ------------
>> >=20
>> >-For building U-Boot you need a GCC compiler for your host platform=2E=
 If you
>> >-are not building on the target platform you further need  a GCC cross=
 compiler=2E
>> >+For building U-Boot you need the general build tools such as `make` a=
nd a C
>> >+compiler for your host platform=2E Next, if you are not building on t=
he same
>> >+architecture as the target platform you further need a C cross compil=
er=2E
>> >+Furthermore, some target platforms require additional host tools to b=
e present
>> >+and their package names may vary slightly dependinng on the naming sc=
heme used
>> >+by a particular host OS=2E
>> >+
>> >+In general, GCC should be used for both the host and target C compile=
r=2E Using
>> >+:doc:`clang <clang>` is supported but please see the documented issue=
s for it as
>> >+well=2E
>> >=20
>> > Debian based
>> > ~~~~~~~~~~~~
>> >@@ -69,6 +77,17 @@ Depending on the build target further packages may =
be needed:
>> > * riscv64 S-mode targets: opensbi
>> > * some arm64 targets: arm-trusted-firmware
>> >=20
>> >+Prebuilt
>> >+~~~~~~~~
>> >+
>> >+Another option, which the project uses for CI for example, is to use =
a prebuilt
>> >+toolchain=2E For the most part, we use the latest `kernel=2Eorg`_ pre=
buit binaries,
>> >+but there are a few architectures that require their own specific too=
lchains
>> >+still=2E
>> >+
>> >+In general, examples found within the documentation here refer to the=
 tools
>> >+found here and exceptions will be noted where relevant=2E
>> >+
>> > Prerequisites
>> > -------------
>> >=20
>> >@@ -112,11 +131,11 @@ command line or export it beforehand=2E
>> >=20
>> >     CROSS_COMPILE=3D<compiler-prefix> make
>> >=20
>> >-Assuming cross compiling on Debian for ARMv8 this would be
>> >+Assuming cross compiling for ARMv8 this would be
>> >=20
>> > =2E=2E code-block:: bash
>> >=20
>> >-    CROSS_COMPILE=3Daarch64-linux-gnu- make
>> >+    CROSS_COMPILE=3Daarch64-linux- make
>>=20
>> GCC uses triples to specify the architecture=2E With the suggested chan=
ge building will fail on many distros, e=2Eg=2E in our CI image=2E
>>=20
>> cf=2E https://gcc=2Egnu=2Eorg/install/specific=2Ehtml#aarch64-x-x
>
>But this is what the kernel=2Eorg compiler is called, and for consistency
>we should reference the reference compiler in our docs=2E I'm wanting to
>follow up and change everyone to use consistent names=2E
>

Please, do not asume that Linux distros will change=2E=20

Users will and should use the tools provided by their distros=2E Side load=
ing foreign binaries is a secutity risc which should be avoided=2E

I cannot see what is inconsistent about sticking to triples=2E

Best regards

Heinrich
