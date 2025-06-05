Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC6C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F918091A;
	Thu,  5 Jun 2025 22:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="og65Greu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D641E81E25; Thu,  5 Jun 2025 22:01:25 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B6080050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c13802133so426829a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749153682; x=1749758482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=58/pf2xloeR9cwTWcVT1y10MyFELkyN0mCeRN9vDFKM=;
 b=og65GreupEuhr5MuYp1DWmTYKJ3uDCbb8fbAUICSBhwo8yS9Ev1MKazLkobeVFmR5V
 W51tD0YJpw5J0gWJap04QXNEtKjm2XqVxXHxCxDJ6mU07SToDG0F7xjxhrWleeofKwjH
 eXtPULvCOxBUl6f5f6rbw9M2bYxTDHXXw+LFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749153682; x=1749758482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58/pf2xloeR9cwTWcVT1y10MyFELkyN0mCeRN9vDFKM=;
 b=hj1Fjf84TjAuLhjUujaZexf029Y+OV75hgY6pu38OT5HUORv+Wbh5XsDhCBsUTLC5t
 8POW468Mes8HXPIydEYkh9I6zwR75tP9hIeDx8GtCeLcR/jhDYPL02Ga77s0qKlmjqkZ
 NsSMw9GZ8Hn2ZL0OC8gpwK9pVIlY7blt+KtY8vazOsRZfo9EYPbTM0lhglrwZZSvFbWC
 C64V6J0tQwdiftsegftV+f8Ou+sbXXuoCDyJ4sT8mXOn5wCCtG7gH+b8UMKJh2noZYnk
 xzUgEYY3jAfJLwj3BgKI6yTfane9ydedJhvHnjMSA+Eu9LTtcpfsoAyLdEMLq7f/LJe/
 LvRQ==
X-Gm-Message-State: AOJu0Yy0z+QFreGF+aGb1JHgLPkUy44NX1BGu/rU8cBgSLwEoZDk6exf
 lFLwq5d4DkZ+wE9eGGp+lEcG0PJMp2GD8a0+wbYJOMpRSQf8q/PMz5wV1G03BJss83c=
X-Gm-Gg: ASbGncuSlo/PWsYyB0LrJL9y+jnY5w4W3Fo5oXj+xvRdv6Mzrf7jM2RHYBWCWuy2Vcc
 XzyO7Re39ypsMwe64LhbMC/MsTYAh7YeRRHsTAvKr26ZZwun43rCBEfGFABHDJiewkNRjHvrMvN
 C2TgqtdlQn+b0hHqKKaNIzW6LVEjo5bjU23dWnAOdy6vz2tsDPTBG94gvpoXR34QTdO/fBTn+fl
 7SR9a1iKlTEtNYOATN/L7ajcQCnuN8S7glF9hF5Gp7FOAhVp2TnA2p3H2JNePP4XRPFa6uvxBqR
 ItuLVbp6SelEUSAaAeE0hcbG8dxRgdIuuxwUwXMG2qPg9FcQ9CrdRoao1V6hhZgZr/vztGtt3P9
 nFsF9foavvMPs
X-Google-Smtp-Source: AGHT+IFGHAtLXJh4TPCJMUIosTWJ6jqX+2K/Lz3bWPMZ69x9zmxUdF1z1q/TXc1pthjBKA46Sx0gEg==
X-Received: by 2002:a05:6830:6218:b0:72b:8c4b:8ef2 with SMTP id
 46e09a7af769-73888efd472mr626730a34.24.1749153681572; 
 Thu, 05 Jun 2025 13:01:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a05272dsm32033a34.36.2025.06.05.13.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:01:20 -0700 (PDT)
Date: Thu, 5 Jun 2025 14:01:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH v2] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
Message-ID: <20250605200117.GD1382132@bill-the-cat>
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ClH8HyL4W75etogk"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
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


--ClH8HyL4W75etogk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
> >
> > > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > > function provided by the compiler runtime, typically libgcc for GCC or
> > > clang_rt.builtins for Clang.
> > > Thus 'clang_rt.builtins' library is required when building using Clan=
g.
> > >
> > > This patch supports the location layout of clang_rt.builtins libraries
> > > from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
> > >
> > > As a fact that starts from LLVM 20, no official prebuilt multi-targets
> > > are included and users might need to cross-built it from source. [3] =
is
> > > an example of instructions for building.
> > >
> > > [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> > > E.g.
> > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> > >
> > > [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.buil=
tins.a
> > > E.g.
> > > lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> > > lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> > >
> > > [3]
> > > git clone https://github.com/llvm/llvm-project.git
> > > cd llvm-project
> > > git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> > > mkdir build-builtin && cd build-builtin
> > > cmake -G Ninja ../llvm \
> > >   -DCMAKE_BUILD_TYPE=3DRelease \
> > >   -DCMAKE_C_COMPILER=3Dclang \
> > >   -DLLVM_ENABLE_PROJECTS=3D"clang" \
> > >   -DLLVM_ENABLE_RUNTIMES=3D"compiler-rt" \
> > >   -DLLVM_TARGETS_TO_BUILD=3D"X86;AArch64" \
> > >   -DLLVM_BUILTIN_TARGETS=3D\
> > >     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=3DLinux \
> > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=3D\
> > >     <YOUR_TOOLCHAIN_GCC> \
> > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=3D\
> > >     <YOUR_TOOLCHAIN_GCC> \
> > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=3D\
> > >     <YOUR_TOOLCHAIN_LIBC_DIR> \
> > >   -DCOMPILER_RT_BUILD_BUILTINS=3DON \
> > >   -DCOMPILER_RT_BUILD_SANITIZERS=3DOFF \
> > >   -DCOMPILER_RT_BUILD_XRAY=3DOFF \
> > >   -DCOMPILER_RT_BUILD_LIBFUZZER=3DOFF \
> > >   -DCOMPILER_RT_BUILD_PROFILE=3DOFF \
> > >   -DCMAKE_INSTALL_PREFIX=3D<INSTALL_DIR> \
> > >   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=3DOFF
> > > ninja builtins
> > > sudo ninja install
> > >
> > > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >
> > I think that newer versions don't even ship this moves us further away
> > from a solution here as all of the logic. I think we need to look at the
> > suggestion of just importing the assembly version of the function.
>
> But, the assembly versions are architecture-specific, do you want a
> portable C code for it?

Is it easily done in C? If not, we can just try and make it clear what
needs to be pulled out of LLVM sources if/when another platform
encounters the problem.

--=20
Tom

--ClH8HyL4W75etogk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhB94oACgkQFHw5/5Y0
tyxEAwv+J5vedUETWN+0y5Bnfm/0UnCYKTSqCg+aqvp4OtvCcovtCVFmopjrlRZp
gr9oLpZ7q1Opj9eA8uUzNzV9w5GYI/75hjVnKbQKpSak4fIZke56DGNp8HsmeezC
Hgr6kCwWvVYkibw4zQOYIEhYprxrwmGYag3lle4nOPOW8EuiXLdqXxdIC2DsAS6Y
Rin4jUYPrc472usRx0riD+6E9xPoIUHmP6xFH2GrQAY5NrJRDYB3+eSNY6Gdk3UL
mcPqg0qEVEnvSKTVjTU8oLZMC01Pmjro1BHX1TONrxmtE1+Hn+JHsRn9IBC3ni/c
V6QVvltT2r1u0ySOQnzU/woRb2XdjHiB1IYSYagbQvHZKgE8J/RgIIDqyJNPTFWX
63q1CyyUet9PVSNnaNoYAgGruIQzcARw/Nb2+u7ZMz+evH9lGviLxlMNAdZ4+qFU
oJz0aYAHWzMWfLYW3F9Tb7IqPvtVfLTLH05BQyaOxPIZkNvT1twwuLKvuLWLvYwY
pqJRFZ5V
=z7pb
-----END PGP SIGNATURE-----

--ClH8HyL4W75etogk--
