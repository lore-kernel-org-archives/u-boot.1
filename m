Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED89C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6234484125;
	Fri, 11 Apr 2025 16:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nhSscxI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A38D84130; Fri, 11 Apr 2025 16:57:22 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A95B840D8
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c0b4a038fso1240878a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744383438; x=1744988238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwRHQIfcc0eKRILwd/tiPPn08Fh3ddSpb4+SPiDlLyY=;
 b=nhSscxI8srbudg23DK9IZdAn8aEM0FhYPuu5bAVW0Y3xXeHA+Yl1mHxWldvtSd24Bh
 GK7DHyJlsdMs5xM3pZAgp7v7j+bDc5T+NVtg75lR842tMQRsq7A1tpqeCg/Xb5lfIZa7
 CwMecS/1L87MJuBuvi2SKYZKf4hmZUezWNwMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383438; x=1744988238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwRHQIfcc0eKRILwd/tiPPn08Fh3ddSpb4+SPiDlLyY=;
 b=vVOdaEiCJ9gQ8sSAaU9H9PZ9BnGqRgcbgsNofSCAzmxXo0j5hz2titPiyrc3rSPchE
 qkTBfRqAJLLK+cne9VR+E/JiRb8fjJlSJS5jL3vHVus1EsYVu1M26kmWqFgGIkd1woMe
 IqWqXUhSLaqls7btaoQk08gHhodPAGUOrWN+aF1c0GMT8M37YZyYJCxkh8UxsN1VdfHE
 LMcwveLgAg0zIGs1BF0gL4IF6d70j1T7S5Ay79vCac9XKeKEo3WFLBC5UHnW5wnT7EnZ
 jvqAHiTkbXd0wl921J3MAESpkH0EUcnkmTtJfPsWmTTzcseGSLCdBowT+lFZRia9cWMl
 gMEg==
X-Gm-Message-State: AOJu0YxhNb0zaVj6dGz61Yrc88tC2DfLIigYiZ6Oox0kVsT8wgiDrXsc
 jAXF0fBIm6J5Ww3p/BfVPcgNkTNtYP7iXmWTPS7gIHUmWnBnZNd4Pc/nwKRIfwE=
X-Gm-Gg: ASbGncvV90J876Nb1Vg+4e6De5BxwtdeBVXtqT2OR01gmbSsK80zilXKWnG0X1pADnG
 V0XYiqkqbJv7I2IxhcfQ+8Aibci7oTV3ki5RHJMc+CNpGmW9IPsDJ8qSO+axmWVEmYSLCi8TeiD
 hVK/8E6J35DDCAKOlqq0XGq37Iqz6sVpOgUac/bH0gf9vU6UMKMYBIy9QwwTpQiEJzj0dyhlT84
 Fw6yr0niHa63a35uasHgLaK+jjbIs/Q3hjxMbyxJ0hGrhSCgQ8E0QB4PhC4ZrAD11Zfj9tpI5bC
 Kzio9muDVnNz1NpccSHUEj6B19j3R7jXfYhvVvl4eIlkoPyi8kQOhiq8Qn+xCqLDc5lJDQaHKs0
 leg==
X-Google-Smtp-Source: AGHT+IERdC47lvkMNv9m55ayTnHx/8geCjIOX6QGTl9gZQIaYZi5IPBsaN7p3xnrZmVPFZVIWmbctA==
X-Received: by 2002:a05:6830:d01:b0:72b:7d60:fda6 with SMTP id
 46e09a7af769-72e861641e1mr2229529a34.0.1744383437913; 
 Fri, 11 Apr 2025 07:57:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e6745asm961351a34.68.2025.04.11.07.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:57:17 -0700 (PDT)
Date: Fri, 11 Apr 2025 08:57:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Dockerfile: Update to gcc-14.2.0 and clang-18
Message-ID: <20250411145715.GP5495@bill-the-cat>
References: <20250128230205.2062703-1-trini@konsulko.com>
 <faee771b-9bf2-4689-86dc-fcfa79ec5880@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="znnhupR9wGlSHq39"
Content-Disposition: inline
In-Reply-To: <faee771b-9bf2-4689-86dc-fcfa79ec5880@gmx.de>
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


--znnhupR9wGlSHq39
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 09:36:16AM +0200, Heinrich Schuchardt wrote:
> On 1/29/25 00:02, Tom Rini wrote:
> > Outside of changing versions here the other visible change is that we
> > tell grub that riscv64 does not have "large model" support. Without this
> > change the resulting mkimage is non-functional. This is known upstream
> > already.
> >=20
> > Link: https://savannah.gnu.org/bugs/?65909
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >   .azure-pipelines.yml    | 8 ++++----
> >   .gitlab-ci.yml          | 6 +++---
> >   tools/docker/Dockerfile | 8 ++++----
> >   3 files changed, 11 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > index ba351b9802d1..4d3a5800beb3 100644
> > --- a/.azure-pipelines.yml
> > +++ b/.azure-pipelines.yml
> > @@ -2,7 +2,7 @@ variables:
> >     windows_vm: windows-2022
> >     ubuntu_vm: ubuntu-24.04
> >     macos_vm: macOS-14
> > -  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08De=
c2024
> > +  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Ja=
n2025
> >     # Add '-u 0' options for Azure pipelines, otherwise we get "permiss=
ion
> >     # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontai=
ner",
> >     # since our $(ci_runner_image) user is not root.
> > @@ -324,16 +324,16 @@ stages:
> >             TEST_PY_TEST_SPEC: "version"
> >           sandbox_clang:
> >             TEST_PY_BD: "sandbox"
> > -          OVERRIDE: "-O clang-17"
> > +          OVERRIDE: "-O clang-18"
> >           sandbox_clang_asan:
> >             TEST_PY_BD: "sandbox"
> > -          OVERRIDE: "-O clang-17 -a ASAN"
> > +          OVERRIDE: "-O clang-18 -a ASAN"
> >             TEST_PY_TEST_SPEC: "version"
> >           sandbox64:
> >             TEST_PY_BD: "sandbox64"
> >           sandbox64_clang:
> >             TEST_PY_BD: "sandbox64"
> > -          OVERRIDE: "-O clang-17"
> > +          OVERRIDE: "-O clang-18"
> >           sandbox_spl:
> >             TEST_PY_BD: "sandbox_spl"
> >             TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test=
_spl"
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 74dc05d58a70..c3c38e24fd1d 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -20,7 +20,7 @@ workflow:
> >=20
> >   # Grab our configured image.  The source for this is found
> >   # in the u-boot tree at tools/docker/Dockerfile
> > -image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1=
-08Dec2024
> > +image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1=
-28Jan2025
> >=20
> >   # We run some tests in different order, to catch some failures quicke=
r.
> >   stages:
> > @@ -241,7 +241,7 @@ sandbox with clang test.py:
> >       - ${DEFAULT_AMD64_TAG}
> >     variables:
> >       TEST_PY_BD: "sandbox"
> > -    OVERRIDE: "-O clang-17"
> > +    OVERRIDE: "-O clang-18"
> >     <<: *buildman_and_testpy_dfn
> >=20
> >   sandbox64 test.py:
> > @@ -256,7 +256,7 @@ sandbox64 with clang test.py:
> >       - ${DEFAULT_AMD64_TAG}
> >     variables:
> >       TEST_PY_BD: "sandbox64"
> > -    OVERRIDE: "-O clang-17"
> > +    OVERRIDE: "-O clang-18"
> >     <<: *buildman_and_testpy_dfn
> >=20
> >   sandbox_spl test.py:
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index d2848ab85f35..b72ed357fa36 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -23,7 +23,7 @@ ENV ARCHS=3D"aarch64 arc i386 m68k mips microblaze ni=
os2 powerpc riscv64 riscv32 s
> >   ENV MIRROR=3Dhttps://mirrors.edge.kernel.org/pub/tools/crosstool/file=
s/bin
> >=20
> >   # Toolchain version
> > -ENV TCVER=3D13.2.0
> > +ENV TCVER=3D14.2.0
> >=20
> >   RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
> >=20
> > @@ -32,7 +32,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sh=
aring=3Dlocked \
> >       --mount=3Dtype=3Dcache,target=3D/var/lib/apt,sharing=3Dlocked \
> >       apt-get update && apt-get install -y gnupg2 wget xz-utils
> >   RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key ad=
d -
> > -RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main |=
 tee /etc/apt/sources.list.d/llvm.list
> > +RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main |=
 tee /etc/apt/sources.list.d/llvm.list
> >=20
> >   # Create a list of URLs to process, then pass them into a 'while read=
' loop
> >   RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then HOSTARCH=3Dx86_6=
4; else HOSTARCH=3Darm64; fi; ( \
> > @@ -65,7 +65,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,sh=
aring=3Dlocked \
> >   	bison \
> >   	build-essential \
> >   	cgpt \
> > -	clang-17 \
> > +	clang-18 \
> >   	coreutils \
> >   	cpio \
> >   	curl \
> > @@ -182,7 +182,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /=
tmp/grub && \
> >   	search search_fs_file search_fs_uuid search_label serial sleep test \
> >   	true && \
> >   	make clean && \
> > -	./configure --target=3Driscv64 --with-platform=3Defi \
> > +	grub_cv_cc_mcmodel=3Dno ./configure --target=3Driscv64 --with-platfor=
m=3Defi \
>=20
> Hello Tom,
>=20
> The upstream GRUB code already has a test in autoconfigure.ac to check
> if the large model is supported:
>=20
> if test "$target_cpu" =3D x86_64 || test "$target_cpu" =3D sparc64 || test
> "$target_cpu" =3D riscv64 ; then
>   # Use large model to support 4G memory
>   AC_CACHE_CHECK([whether option -mcmodel=3Dlarge works],
> grub_cv_cc_mcmodel, [
>     CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dlarge"
>     AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[]])],
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0      [grub_cv_cc_mcmodel=
=3Dyes],
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0      [grub_cv_cc_mcmodel=
=3Dno])
>   ])
>   if test "x$grub_cv_cc_mcmodel" =3D xyes; then
>     TARGET_CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dlarge"
>   elif test "$target_cpu" =3D sparc64 || test "$target_cpu" =3D riscv64; =
then
>     TARGET_CFLAGS=3D"$TARGET_CFLAGS -mcmodel=3Dmedany"
>   fi
> fi
>=20
> Why did you have to put grub_cv_cc_mcmodel=3Dno on the command line?
>=20
> I would prefer to leave it to GRUB to figure out which model is supported.

Because the test is wrong. It claims it's supported and then the tools
fail to run and segfault. This is in the link at
https://savannah.gnu.org/bugs/?65909

--=20
Tom

--znnhupR9wGlSHq39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5LcsACgkQFHw5/5Y0
tywTVAv9GrASU5dVzUGpXdZW8r6qvtUCWyLgpyayeCXKM3rM8/Tam6LuDEhqwOeO
+YmMoYi0sb1RFTgqfjv+gUMUFKQyXTpGAz2mPG2T3auDOMgrqXs0G2cgD7nbAmWr
6F8OYgd91a45PukNiElMcKjL5Wvkp9+PomDPVrGwrAxBzviL7KQsmM4go9GraiQT
eIvT+bTlWCXBy9+5uCUPQ2wZBdgcFeja6mpIJiHHYwMvFQy6ZNJ30xCr3LD91+2e
/2fiXkQk6w2gD6Oc9cmfuUJ1CdcNuw1Zi7hel+9PiQcXw6Orj40YuTn+L6ivyoDo
GZGI8lKXYC1c2VhvOKHnUTh49Db5Us4acjo62szp4/dUvbVsZud/roWDY85SOV7t
BfrFZ6ZAReynbftPiXC0QXzzcy8OKN6GkmTDHdP3CqrFCOIrezvV6d51gvsjmxkY
lRapAtAejs3fOO+76NjDBJDhIWtJz1eMg7Mvk2+4q50PQEO5OwYEbiB11I2CjLmq
It8VBQHN
=F2jt
-----END PGP SIGNATURE-----

--znnhupR9wGlSHq39--
