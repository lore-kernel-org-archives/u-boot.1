Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CDC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 23:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFF5879F3;
	Fri, 16 Feb 2024 00:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aP3UVByk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2052587A80; Fri, 16 Feb 2024 00:20:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F2F879E0
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 00:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708039216; x=1708644016; i=xypron.glpk@gmx.de;
 bh=9OMGpaC8dg1APyrR0DtrDPX8U6TLuaoeuWVqFUfSJ5g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=aP3UVBykNaSmV9JTd3Hb0yaumqVTrsZruVKwNn3Oc5XkKd9/svLis6leztQ0QS9F
 cIfud/XYPBlRbgGhEKyU+uU/FjvFrm8GsI1qf+tD3LTbRqW2IiUck0N5GBnSR8QEJ
 J9fTpqxc6NAoJJBokucdXjSELOvk42bcEpQYC1R8LmVpam80S1KXcON0k3qoZVenQ
 tbKV77ss0/SlLuItGhEYffutGcQbwYPqMCl4W01ZTMmZWkjHoIXkS6dRx2wCi7sJe
 Whx9xS2N8JwU3oG//94OJMBV6fb+NLZZBrlXyrUT3aMTBcDXTZ3/z8+5VLkaYiwzO
 M6cE88uBn+NZFpGhfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1qwpyV02vT-014zuY; Fri, 16
 Feb 2024 00:20:16 +0100
Date: Fri, 16 Feb 2024 00:20:14 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_doc=3A_Rework_the_gcc_sect?=
 =?US-ASCII?Q?ion_to_reflect_general_build_instructions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240215220032.GG3040305@bill-the-cat>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
 <45D1EDA6-C570-4F18-B937-57808BBCDFC2@gmx.de>
 <20240215212824.GF3040305@bill-the-cat>
 <6FCE298F-EE98-462E-B27E-EEF0796D0097@gmx.de>
 <20240215220032.GG3040305@bill-the-cat>
Message-ID: <9B30B785-4711-4343-9402-3CF5DC7F0338@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3fRryvntDfWeO41D7bsDEIVvSEFHDOojUTsR76txRF6gJMxuBOR
 AZfIcATTMYSfejJoZY3tYe5AxNPe3VD5e43RJuDti1hYzcvLoTo+CAUb2CE5PByistEVf68
 ynGrb0S0fPExScaWYf9acd01NDTASRXK832OZdWLT7CfB99QdDFiAunYXE8Ed/Nkr/wKFmS
 DQ6H/j/Fsxxii1SOpgsng==
UI-OutboundReport: notjunk:1;M01:P0:gBOncBtIBDk=;d2QIpAxEUMN7Q6eflIhbMFX7hsd
 mpo201Q4XYAWEWao5NG3QFgJogpaphF2gAhsH6u8aNHk2iPnC9XWe1SLutjt120O2ijsxaoBC
 69+Y1LaeBJyz5ccnN+DG+tHBmPvGVT46dNfAHyHv2V65gIwzrLrDxvPBenj9xNIrfkDU/2I6p
 MT0qfdIbJsCb577yjVBYwqpnAYFkJwL8QnuiK7YGXUJaJ5EP9zZjCZpDwMei3W06tbpFiHU9b
 peNFaaprh7y1pzo+e7DRPOCzRc+zuySoHue4Sv4oSqn+1of0TJH+ZCX69KtBKsALymqaV2mn5
 AdgqPrhs1SP0YRFzW0M6PLwly+bnZC8rgycfiKQtVBvt1+AwqCZ98prZem+i94gH9fpZqju2u
 JHjJab2IlVnYS4io0C+YB7Z8VLl2PjIGMAKWcxgrriKlME3EgMzG7mUF1jNwYSELWM5g0fOdc
 +o8wy7mNW5qBiBIWkMbnKfWRGxxckcsNXb3OIYbxwejGlt4LrOXoJzHu/zFVloclakb2KxmJn
 QxKxDLdHB6FaHNXgNOaJBIgcOKtyYc8AiMfrLKM50vnUh6uvIxo4r6RSjGxZ6wmOFBHGnppyL
 952aOhSA9CJuXKjIpHdNAyCk90BwARqzDcIPm0hKtJYbDV2GfJWsdE/OZU7XlAJSu9U7WpFYX
 oUX3lOOQ8KAYGbPtlLQDYTyG3G0Ea18EkDTWwRwDg1q1Wvc7eyqm1cHt1trArBsNVKDiiJw2y
 IIyWaxF/3YfBjY3N7y7Wh0A2NczEmNPcpF8b5vSCvmfllXJRknNpVJnowz6dBeBVPxoP+TLrU
 kWipSkjTXLmD5XP6BpVt9DP5P9zkH70sDRAa6Edw/pjMs=
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



Am 15=2E Februar 2024 23:00:32 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>On Thu, Feb 15, 2024 at 10:53:59PM +0100, Heinrich Schuchardt wrote:
>>=20
>>=20
>> Am 15=2E Februar 2024 22:28:24 MEZ schrieb Tom Rini <trini@konsulko=2Ec=
om>:
>> >On Thu, Feb 15, 2024 at 10:24:40PM +0100, Heinrich Schuchardt wrote:
>> >>=20
>> >>=20
>> >> Am 15=2E Februar 2024 22:10:25 MEZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>> >> >The first big issue is that the "gcc" file talked a lot about the
>> >> >general build requirements as well, but was titled in a gcc-centric
>> >> >manner=2E Solve this by renaming the file to compile=2Erst and more=
 fully
>> >> >reflecting that it is general build instructions=2E Next, add a sec=
tion
>> >> >about the prebuilt toolchains that are recommended (as they are the=
 ones
>> >> >we use in CI), and update a few places to reference these vendor-ne=
utral
>> >> >tools=2E
>> >> >
>> >> >Next, we can include the reproducible builds section directly in th=
e
>> >> >compile instructions rather than as a small standalone file=2E
>> >> >
>> >> >Finally, we update the sandbox document to reflect both the name ch=
ange
>> >> >as well as what is specifically required to build sandbox=2E
>> >> >
>> >> >Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>> >> >---
>> >> >Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >> >---
>> >> > doc/arch/sandbox/sandbox=2Erst       |  5 ++-
>> >> > doc/build/{gcc=2Erst =3D> compile=2Erst} | 64 ++++++++++++++++++++=
++++++----
>> >> > doc/build/index=2Erst                |  3 +-
>> >> > doc/build/reproducible=2Erst         | 27 -------------
>> >> > 4 files changed, 61 insertions(+), 38 deletions(-)
>> >> > rename doc/build/{gcc=2Erst =3D> compile=2Erst} (73%)
>> >> > delete mode 100644 doc/build/reproducible=2Erst
>> >> >
>> >> >diff --git a/doc/arch/sandbox/sandbox=2Erst b/doc/arch/sandbox/sand=
box=2Erst
>> >> >index 5f8db126657f=2E=2Ef2ed5a25c115 100644
>> >> >--- a/doc/arch/sandbox/sandbox=2Erst
>> >> >+++ b/doc/arch/sandbox/sandbox=2Erst
>> >> >@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts=2E
>> >> >=20
>> >> > Note that standalone/API support is not available at present=2E
>> >> >=20
>> >> >-
>> >> > Prerequisites
>> >> > -------------
>> >> >=20
>> >> >-Install the dependencies noted in :doc:`=2E=2E/=2E=2E/build/gcc`=
=2E
>> >> >+In addition to the normal dependencies shows in the :doc:`general =
build
>> >> >+instructions <=2E=2E/=2E=2E/build/compile>` to enable display supp=
ort SDL2 libraries
>> >> >+need to be available=2E
>> >> >=20
>> >> >=20
>> >> > Basic Operation
>> >> >diff --git a/doc/build/gcc=2Erst b/doc/build/compile=2Erst
>> >> >similarity index 73%
>> >> >rename from doc/build/gcc=2Erst
>> >> >rename to doc/build/compile=2Erst
>> >> >index 3c6465772729=2E=2Eef9c8545835a 100644
>> >> >--- a/doc/build/gcc=2Erst
>> >> >+++ b/doc/build/compile=2Erst
>> >> >@@ -1,11 +1,19 @@
>> >> >-Building with GCC
>> >> >-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >+Building U-Boot
>> >> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >=20
>> >> > Dependencies
>> >> > ------------
>> >> >=20
>> >> >-For building U-Boot you need a GCC compiler for your host platform=
=2E If you
>> >> >-are not building on the target platform you further need  a GCC cr=
oss compiler=2E
>> >> >+For building U-Boot you need the general build tools such as `make=
` and a C
>> >> >+compiler for your host platform=2E Next, if you are not building o=
n the same
>> >> >+architecture as the target platform you further need a C cross com=
piler=2E
>> >> >+Furthermore, some target platforms require additional host tools t=
o be present
>> >> >+and their package names may vary slightly dependinng on the naming=
 scheme used
>> >> >+by a particular host OS=2E
>> >> >+
>> >> >+In general, GCC should be used for both the host and target C comp=
iler=2E Using
>> >> >+:doc:`clang <clang>` is supported but please see the documented is=
sues for it as
>> >> >+well=2E
>> >> >=20
>> >> > Debian based
>> >> > ~~~~~~~~~~~~
>> >> >@@ -69,6 +77,17 @@ Depending on the build target further packages m=
ay be needed:
>> >> > * riscv64 S-mode targets: opensbi
>> >> > * some arm64 targets: arm-trusted-firmware
>> >> >=20
>> >> >+Prebuilt
>> >> >+~~~~~~~~
>> >> >+
>> >> >+Another option, which the project uses for CI for example, is to u=
se a prebuilt
>> >> >+toolchain=2E For the most part, we use the latest `kernel=2Eorg`_ =
prebuit binaries,
>> >> >+but there are a few architectures that require their own specific =
toolchains
>> >> >+still=2E
>> >> >+
>> >> >+In general, examples found within the documentation here refer to =
the tools
>> >> >+found here and exceptions will be noted where relevant=2E
>> >> >+
>> >> > Prerequisites
>> >> > -------------
>> >> >=20
>> >> >@@ -112,11 +131,11 @@ command line or export it beforehand=2E
>> >> >=20
>> >> >     CROSS_COMPILE=3D<compiler-prefix> make
>> >> >=20
>> >> >-Assuming cross compiling on Debian for ARMv8 this would be
>> >> >+Assuming cross compiling for ARMv8 this would be
>> >> >=20
>> >> > =2E=2E code-block:: bash
>> >> >=20
>> >> >-    CROSS_COMPILE=3Daarch64-linux-gnu- make
>> >> >+    CROSS_COMPILE=3Daarch64-linux- make
>> >>=20
>> >> GCC uses triples to specify the architecture=2E With the suggested c=
hange building will fail on many distros, e=2Eg=2E in our CI image=2E
>> >>=20
>> >> cf=2E https://gcc=2Egnu=2Eorg/install/specific=2Ehtml#aarch64-x-x
>> >
>> >But this is what the kernel=2Eorg compiler is called, and for consiste=
ncy
>> >we should reference the reference compiler in our docs=2E I'm wanting =
to
>> >follow up and change everyone to use consistent names=2E
>> >
>>=20
>> Please, do not asume that Linux distros will change=2E=20
>>=20
>> Users will and should use the tools provided by their distros=2E Side l=
oading foreign binaries is a secutity risc which should be avoided=2E
>>=20
>> I cannot see what is inconsistent about sticking to triples=2E
>
>We need to be consistent within our docs, and we aren't today=2E And
>"-gnu" isn't a required suffix for aarch64 linux toolchains as not all
>distributions do that=2E I'd be open to wording suggesting that users
>install tools recommended by their vendors, but that still won't give us
>consistent names due to "aarch64-poky-linux-" being what other vendor
>tools will be=2E
>

On which operating systems will CROSS_COMPILE=3Daarch64-linux- work for th=
e distro tools?

On which will CROSS_COMPILE=3Daarch64-linux-gnu- work?

Best regards

Heinrich
