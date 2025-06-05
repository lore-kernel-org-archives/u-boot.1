Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D958EC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 21:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13CA381E25;
	Thu,  5 Jun 2025 23:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VFeETJqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1076781F0D; Thu,  5 Jun 2025 23:47:03 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B418091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 23:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73044329768so1026432a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749160019; x=1749764819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=luRb6d6OO8h9PxphJcyEssBPqEG2dfi0b5/Rl7xSrOA=;
 b=VFeETJqFLeFFbjS0dopysmA/x0I3/JZYOyDpOKoCFeyFFDzuTJhbkWvMf15tPWpOGd
 W4Xt4k4bF5stMP97wmzQYKv3FbBrxPzSMN1clJiDCtle19m7v0uug+DrPYXCic2YGrTe
 KBRABI8SnHBKwz1W6cd+90HwFec/dlGPEPJ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749160019; x=1749764819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luRb6d6OO8h9PxphJcyEssBPqEG2dfi0b5/Rl7xSrOA=;
 b=vWICMsNYp4vv62n3NTo647Hj2xwn53QjMdxkIgRqA4S0A9/MuKhoIpoaQ3Xj81JRAk
 eb7qi9eAkunwzqgr6cCbOfX7YdWCJ2qDh8HA4vLuluESuDQBaIT/R05Icl++qbu6QM71
 +e0F/ZLS4D5RZglBygW4sKsX9YwURFGsukGEUl5KaZuUjOFpDEtxyzdjiUEhLv7MnnQC
 akBygqjAUkOzxs4Xl5jbCZTVWChTRbMKYrA0KlRlUWB6fhEq0u4s+eZUg/kdhjqYY4PM
 7yy5B3ClPV47vjOiNvPfVMY2w/+DzUISwgrf7V9/6zBh2OawmRaD+TJ0QktaGrwZcXzz
 qK4g==
X-Gm-Message-State: AOJu0YxUXoHSXzvgj0xY5AJuHCvgdpB3fTJ1rGRfzkwwxtPlXrJN9kPa
 lHFJAG9UNS5Xt4qzxhE1YYL0gp3USxOeJUZ+kjXu+R4SSL26GbCCsrwz4ru9pcg7/9o=
X-Gm-Gg: ASbGncvoFhzcpdhYEQg2C23vKa2F858jXcBUucxfXN5g63DIwPZFI7m0QGtNH0nXqVD
 Q5TwLn3/YF3p52HDGHScCf/tOHjhLW5YEQO2ZUVRvR5Aidwm78sQsV5x5B3BoB9WX3d00zjqxfd
 eOXP3La2Wnp9OICL9m92glGyrFc1qBiX5bp+lYeYG7gj8oGSrY+X8CEMnNFV/C/60vgDG9wjebA
 CfLdFmmI+HTxBob5h3djq45AKC77/T+TcRxgFQRRDpo3zoEYRRcQ8JOFosOIPxWHB4uQxQi8yLF
 C15/+RsGGvSEz+d1jvgUGeFnm8U7EmIoqSaXKzONSwA3RXq+vi8R5mbJp2DoZMKbD68y8MX7Adk
 3PhXjbwAjaIobKF31+bLyXlM=
X-Google-Smtp-Source: AGHT+IHcIEP56RyvtBhL7bu9UWjbuU9AHT3iOaHk674QgfffgTxhUy+Xa4m59KsRtg+IvHVBhibEiA==
X-Received: by 2002:a05:6830:381a:b0:735:b40e:2b47 with SMTP id
 46e09a7af769-73888d9def0mr860360a34.5.1749160018696; 
 Thu, 05 Jun 2025 14:46:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f59d46sm65138a34.24.2025.06.05.14.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 14:46:57 -0700 (PDT)
Date: Thu, 5 Jun 2025 15:46:55 -0600
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
Message-ID: <20250605214655.GG1382132@bill-the-cat>
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
 <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e5obt98X1LxAdy7f"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
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


--e5obt98X1LxAdy7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 04:52:20PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 5 Jun 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
> > > >
> > > > > MbedTLS bignum module needs '__udivti3' which is a 128-bit divisi=
on
> > > > > function provided by the compiler runtime, typically libgcc for G=
CC or
> > > > > clang_rt.builtins for Clang.
> > > > > Thus 'clang_rt.builtins' library is required when building using =
Clang.
> > > > >
> > > > > This patch supports the location layout of clang_rt.builtins libr=
aries
> > > > > from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [=
2].
> > > > >
> > > > > As a fact that starts from LLVM 20, no official prebuilt multi-ta=
rgets
> > > > > are included and users might need to cross-built it from source. =
[3] is
> > > > > an example of instructions for building.
> > > > >
> > > > > [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<AR=
CH>.a
> > > > > E.g.
> > > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> > > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> > > > >
> > > > > [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.=
builtins.a
> > > > > E.g.
> > > > > lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> > > > > lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> > > > >
> > > > > [3]
> > > > > git clone https://github.com/llvm/llvm-project.git
> > > > > cd llvm-project
> > > > > git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> > > > > mkdir build-builtin && cd build-builtin
> > > > > cmake -G Ninja ../llvm \
> > > > >   -DCMAKE_BUILD_TYPE=3DRelease \
> > > > >   -DCMAKE_C_COMPILER=3Dclang \
> > > > >   -DLLVM_ENABLE_PROJECTS=3D"clang" \
> > > > >   -DLLVM_ENABLE_RUNTIMES=3D"compiler-rt" \
> > > > >   -DLLVM_TARGETS_TO_BUILD=3D"X86;AArch64" \
> > > > >   -DLLVM_BUILTIN_TARGETS=3D\
> > > > >     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=3DLinux \
> > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=3D\
> > > > >     <YOUR_TOOLCHAIN_GCC> \
> > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=3D\
> > > > >     <YOUR_TOOLCHAIN_GCC> \
> > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=3D\
> > > > >     <YOUR_TOOLCHAIN_LIBC_DIR> \
> > > > >   -DCOMPILER_RT_BUILD_BUILTINS=3DON \
> > > > >   -DCOMPILER_RT_BUILD_SANITIZERS=3DOFF \
> > > > >   -DCOMPILER_RT_BUILD_XRAY=3DOFF \
> > > > >   -DCOMPILER_RT_BUILD_LIBFUZZER=3DOFF \
> > > > >   -DCOMPILER_RT_BUILD_PROFILE=3DOFF \
> > > > >   -DCMAKE_INSTALL_PREFIX=3D<INSTALL_DIR> \
> > > > >   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=3DOFF
> > > > > ninja builtins
> > > > > sudo ninja install
> > > > >
> > > > > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > >
> > > > I think that newer versions don't even ship this moves us further a=
way
> > > > from a solution here as all of the logic. I think we need to look a=
t the
> > > > suggestion of just importing the assembly version of the function.
> > >
> > > But, the assembly versions are architecture-specific, do you want a
> > > portable C code for it?
> >
> > Is it easily done in C? If not, we can just try and make it clear what
> > needs to be pulled out of LLVM sources if/when another platform
> > encounters the problem.
> >
> But maybe we can ask the LLVM project owner why they removed the
> prebuilt multi-targets since 20.0.0.
> May current patch can support multiple target layouts of pre-15 and
> post-15 patterns (I believe they will keep the one of post-15 for the
> future), if they can provide the prebuilt multi-targets via package
> managers or release tarballs then it is the best solution.
> In the future we might need other functions from those libraries and
> implementing it in U-Boot is not a good choice IMO.

I think adding all of that logic to the Makefile is taking us down the
wrong path. Looking at the kernel, they're working with LLVM to be able
to disable these 128bit intrinsics currently (as part of rust support).
So hopefully we just need some temporary workaround until things get
fixed upstream.

--=20
Tom

--e5obt98X1LxAdy7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhCEEcACgkQFHw5/5Y0
tyzYUQv/UM65/oEQf3KNunVJTrINhFuDGWSJ35361Phkq0dxxJ12PPpc62xrFLRP
s+jygsjOW/1K+b+BV0salAqnoaXWDJVdVNBlNhxqSQB234LOkVXb6WVKeL68ECpM
93DHpRHCgMSY2ikg0igQwaAUIRhLvWvDXGcioVL7SFBPAFxSfY3+bYlRUFqFg6sB
ghNcIETsrKSvOCjJjdpV5hczstD3Ypq48NSDR58pyYni5fHSBRWYYxYf0JJeu70b
4lZFRHe5FEea+kadxp7FZQsr8oZtz737DFELO0icikGa7n/3r0j3ye5E47DSV98p
twr4klQkM+ohKgqm/XIvWWLZ8AUIf/d7VgMU5DVit+wmJkFT5DkuINqoMq1PUtXW
H9yyKLoJTkpjMHLlENdghZN/KxbbPSyQtcT8wtrcfmR2PB79aKHjpPoBddcMPcvl
ennnSIy5ih3frqCgWVt/hYAmZ3+a61KykJFqEbXbO2Pn57f21JYeBMfnw/A+WRga
T8fyI7qY
=UWNi
-----END PGP SIGNATURE-----

--e5obt98X1LxAdy7f--
