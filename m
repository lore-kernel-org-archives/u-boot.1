Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FAEC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 07:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E7183EF2;
	Fri, 11 Apr 2025 09:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="d9dax1D8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162A483EF5; Fri, 11 Apr 2025 09:36:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E2E83E78
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744356977; x=1744961777; i=xypron.glpk@gmx.de;
 bh=AI+d7J4FFOWX7xE13X06E+O49cCs4xRfk3A2rZzY8wc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=d9dax1D87MmX98MIcL5UPGZPCEx6KoUdxaIyXsHxAnhcWRhNsUn3AlBVZFOEm+uY
 xp5CyJb7LDFQ7x6MP6L48xMmGgyXaH3YhGzooC0deob/dyIZ/HcdkS7n2g88rwUPv
 hEbgMrN03Z7zloqiDBkC7hBm1tWw4Ko2EPobACzqktRfpPeYKbRE3C/y0V79zt1DE
 GJlH7A+ZQuCxf++cPACJcmrX44LLy+jY2Ij+sSSsqQn8eVg9PIKZXxjupm7T4dtJD
 3M8Are1nHXYcemARecDdnFCSmcQGBldwmD/mqzDlvxKq8SZ7IBWzjnPSxTuQFKYIZ
 XRbdRkA++3U0RJf3hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1tLrow0hvf-00bbD4; Fri, 11
 Apr 2025 09:36:17 +0200
Message-ID: <faee771b-9bf2-4689-86dc-fcfa79ec5880@gmx.de>
Date: Fri, 11 Apr 2025 09:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Dockerfile: Update to gcc-14.2.0 and clang-18
To: Tom Rini <trini@konsulko.com>
References: <20250128230205.2062703-1-trini@konsulko.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250128230205.2062703-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ozh4x5WTSNjPddyZjQ3tqwvh/NnnYoe0XPyUT6CrMmoTOv24sOJ
 oQleEMpNKBz25ChIqEhWRjlZ0mapC6PIA2qRl+DHgAXO1trdgAfOj/w8TROsg8LQyWc8fyC
 T5ebem3P9GpsA9iZOkCm8b7Pa8r0G8JaDp5GdDkMkZkKRVpbS+ZAVG4xsUYrDFLhujab8lh
 gIylogyZYDGK2TX1br/iw==
UI-OutboundReport: notjunk:1;M01:P0:ESuoTLKGDHc=;SHG2cg6zXSDDOQFXrjIJVFdhUZD
 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
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

On 1/29/25 00:02, Tom Rini wrote:
> Outside of changing versions here the other visible change is that we
> tell grub that riscv64 does not have "large model" support. Without this
> change the resulting mkimage is non-functional. This is known upstream
> already.
>
> Link: https://savannah.gnu.org/bugs/?65909
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   .azure-pipelines.yml    | 8 ++++----
>   .gitlab-ci.yml          | 6 +++---
>   tools/docker/Dockerfile | 8 ++++----
>   3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index ba351b9802d1..4d3a5800beb3 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -2,7 +2,7 @@ variables:
>     windows_vm: windows-2022
>     ubuntu_vm: ubuntu-24.04
>     macos_vm: macOS-14
> -  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec=
2024
> +  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Jan=
2025
>     # Add '-u 0' options for Azure pipelines, otherwise we get "permissi=
on
>     # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontain=
er",
>     # since our $(ci_runner_image) user is not root.
> @@ -324,16 +324,16 @@ stages:
>             TEST_PY_TEST_SPEC: "version"
>           sandbox_clang:
>             TEST_PY_BD: "sandbox"
> -          OVERRIDE: "-O clang-17"
> +          OVERRIDE: "-O clang-18"
>           sandbox_clang_asan:
>             TEST_PY_BD: "sandbox"
> -          OVERRIDE: "-O clang-17 -a ASAN"
> +          OVERRIDE: "-O clang-18 -a ASAN"
>             TEST_PY_TEST_SPEC: "version"
>           sandbox64:
>             TEST_PY_BD: "sandbox64"
>           sandbox64_clang:
>             TEST_PY_BD: "sandbox64"
> -          OVERRIDE: "-O clang-17"
> +          OVERRIDE: "-O clang-18"
>           sandbox_spl:
>             TEST_PY_BD: "sandbox_spl"
>             TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_=
spl"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 74dc05d58a70..c3c38e24fd1d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -20,7 +20,7 @@ workflow:
>
>   # Grab our configured image.  The source for this is found
>   # in the u-boot tree at tools/docker/Dockerfile
> -image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-=
08Dec2024
> +image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-=
28Jan2025
>
>   # We run some tests in different order, to catch some failures quicker=
.
>   stages:
> @@ -241,7 +241,7 @@ sandbox with clang test.py:
>       - ${DEFAULT_AMD64_TAG}
>     variables:
>       TEST_PY_BD: "sandbox"
> -    OVERRIDE: "-O clang-17"
> +    OVERRIDE: "-O clang-18"
>     <<: *buildman_and_testpy_dfn
>
>   sandbox64 test.py:
> @@ -256,7 +256,7 @@ sandbox64 with clang test.py:
>       - ${DEFAULT_AMD64_TAG}
>     variables:
>       TEST_PY_BD: "sandbox64"
> -    OVERRIDE: "-O clang-17"
> +    OVERRIDE: "-O clang-18"
>     <<: *buildman_and_testpy_dfn
>
>   sandbox_spl test.py:
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index d2848ab85f35..b72ed357fa36 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -23,7 +23,7 @@ ENV ARCHS=3D"aarch64 arc i386 m68k mips microblaze nio=
s2 powerpc riscv64 riscv32 s
>   ENV MIRROR=3Dhttps://mirrors.edge.kernel.org/pub/tools/crosstool/files=
/bin
>
>   # Toolchain version
> -ENV TCVER=3D13.2.0
> +ENV TCVER=3D14.2.0
>
>   RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
>
> @@ -32,7 +32,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sha=
ring=3Dlocked \
>       --mount=3Dtype=3Dcache,target=3D/var/lib/apt,sharing=3Dlocked \
>       apt-get update && apt-get install -y gnupg2 wget xz-utils
>   RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add=
 -
> -RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | =
tee /etc/apt/sources.list.d/llvm.list
> +RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main | =
tee /etc/apt/sources.list.d/llvm.list
>
>   # Create a list of URLs to process, then pass them into a 'while read'=
 loop
>   RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then HOSTARCH=3Dx86_64=
; else HOSTARCH=3Darm64; fi; ( \
> @@ -65,7 +65,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sha=
ring=3Dlocked \
>   	bison \
>   	build-essential \
>   	cgpt \
> -	clang-17 \
> +	clang-18 \
>   	coreutils \
>   	cpio \
>   	curl \
> @@ -182,7 +182,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /t=
mp/grub && \
>   	search search_fs_file search_fs_uuid search_label serial sleep test \
>   	true && \
>   	make clean && \
> -	./configure --target=3Driscv64 --with-platform=3Defi \
> +	grub_cv_cc_mcmodel=3Dno ./configure --target=3Driscv64 --with-platform=
=3Defi \

Hello Tom,

The upstream GRUB code already has a test in autoconfigure.ac to check
if the large model is supported:

if test "$target_cpu" =3D x86_64 || test "$target_cpu" =3D sparc64 || test
"$target_cpu" =3D riscv64 ; then
   # Use large model to support 4G memory
   AC_CACHE_CHECK([whether option -mcmodel=3Dlarge works],
grub_cv_cc_mcmodel, [
     CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dlarge"
     AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[]])],
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0      [grub_cv_cc_mcmodel=3Dyes],
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0      [grub_cv_cc_mcmodel=3Dno])
   ])
   if test "x$grub_cv_cc_mcmodel" =3D xyes; then
     TARGET_CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dlarge"
   elif test "$target_cpu" =3D sparc64 || test "$target_cpu" =3D riscv64; =
then
     TARGET_CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dmedany"
   fi
fi

Why did you have to put grub_cv_cc_mcmodel=3Dno on the command line?

I would prefer to leave it to GRUB to figure out which model is supported.

Best regards

Heinrich

>   	CC=3Dgcc \
>   	TARGET_CC=3D/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-=
gcc \
>   	TARGET_OBJCOPY=3D/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-l=
inux-objcopy \

