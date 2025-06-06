Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AEBC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2715482A65;
	Fri,  6 Jun 2025 16:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uC5oTOaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138B282A8D; Fri,  6 Jun 2025 16:23:22 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DD6800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40791b6969bso1453069b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219798; x=1749824598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ghD/rBRr3OFkk1p9wg3nDC96PmM3tEYiV81XsybAqJI=;
 b=uC5oTOaNpTxfDlOIvl8zG2JcF7XrHiIUha8A78k+PHX+Fj8+VDz75cf9vZEfyZcXd2
 1PYSi1a/KrcZlt0GFr+T2BFTTGYZRl53Z+H9mPBuuZnnvAxjKjr33CJz5ugON4d16RS0
 lWBg3vgH+PJan6Oe1vVOH1SECDRDd9PbaUodU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219798; x=1749824598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghD/rBRr3OFkk1p9wg3nDC96PmM3tEYiV81XsybAqJI=;
 b=JiGz03iSXGuzWWArCzAqjvM1WD+esQ8pOHqHorC+47ugpcHTeFvQAGYqXjrMxmJ5M8
 dGLQ2QO6yf8ZCxFq74S0qoGHidxnlXy98kyjm/W/xLMTNhpsK882MOgCBbpeV4HHocUz
 r/VqCaKoLc19mJQ2ONzw2ugSTVGnur33R28qq5FtZwkNDiwvWJtahhH7s4SQ2ZgaKwxt
 bPODqpXFmU2PO1iVcg06pHiYUFLoL+n6lVMsmhminSClsCrZlP8f+QU6QJkvZy8tJQC/
 CzGdS/j0+aJIhnDmt/oUOsJDUGHqOYFgfdJXySOQKwqT1R8mZ5ASIHxTrqUaJoGUBoOL
 HFtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/rNPH+Orz+O1NASX0KtYpe5Tff73wTlWtFKR0LQpghz52jmVFIA4zRzc9LN6UN/frEh8fdA=@lists.denx.de
X-Gm-Message-State: AOJu0YyEDYHY1x1OrtCoYzxQCeUWrld38yTJ+1+DyJ+saV+97w8lnlft
 pdh4icl/tJ7q2LFA3GZ5ZCUIeixPxHFJNf29hFjHfVXzVS8Ba98z+xfnUm/41PMu2Hg=
X-Gm-Gg: ASbGncvLRqs9UsB00wlXqez5LY05hidqjBKoIbznep2XsEcDEdGvHjE8DiFPiMJZibX
 IhO1a9pvrKvtuU0Xi1LYzW3iKc9ELLMuJ9I++GhKnjH1HewAN8TDFSxBJSKStXgxrnrY+AgU2WU
 XXPZqI3WsTYykxs5bkMUJo0v3r9eyRklE2o2a4edwjYl/PCXEJaz3tAuAqL/+5LF588vcPGJ/ql
 pZ+IdRvfkqVVyzb2Cep263BGBQDRohjfEi0xjrx4bNzEg7LsqVBUKqyczAH+dGnruwj8cQn5roF
 JSHq7WRvGCi/shZYZtjdv8CoUt6IE9j/IUKr7chF5bPbPmQoczQlA99DxJz0BcKGqJxmrxzFXWz
 k7yVeRdgY8NT1
X-Google-Smtp-Source: AGHT+IFJsk4jFPrDYOY9LXiFP3Z742VnjWJKt/j3knP94xUx+39JQ7ngrxvj5HAQaVmjyQ9M3RQhNw==
X-Received: by 2002:a05:6870:f601:b0:2c2:c92a:5789 with SMTP id
 586e51a60fabf-2ea006939b9mr2185872fac.5.1749219797993; 
 Fri, 06 Jun 2025 07:23:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea072e5f5bsm330062fac.28.2025.06.06.07.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:23:16 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:23:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
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
Message-ID: <20250606142314.GQ1382132@bill-the-cat>
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
 <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
 <20250605214655.GG1382132@bill-the-cat>
 <CAEfUkUKR-zZ124VsOX31KNer6EiDKyXgO=oF2L2YwUOgf40CEg@mail.gmail.com>
 <c114ac9f-bcce-4dbb-bf32-1825d455240d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UPnXCM9cqEoLclZM"
Content-Disposition: inline
In-Reply-To: <c114ac9f-bcce-4dbb-bf32-1825d455240d@linaro.org>
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


--UPnXCM9cqEoLclZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:58:28AM +0200, Jerome Forissier wrote:
>=20
>=20
> On 6/6/25 00:10, Raymond Mao wrote:
> > Hi Tom,
> >=20
> > On Thu, 5 Jun 2025 at 17:46, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Jun 05, 2025 at 04:52:20PM -0400, Raymond Mao wrote:
> >>> Hi Tom,
> >>>
> >>> On Thu, 5 Jun 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
> >>>>> Hi Tom,
> >>>>>
> >>>>> On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
> >>>>>>
> >>>>>>> MbedTLS bignum module needs '__udivti3' which is a 128-bit divisi=
on
> >>>>>>> function provided by the compiler runtime, typically libgcc for G=
CC or
> >>>>>>> clang_rt.builtins for Clang.
> >>>>>>> Thus 'clang_rt.builtins' library is required when building using =
Clang.
> >>>>>>>
> >>>>>>> This patch supports the location layout of clang_rt.builtins libr=
aries
> >>>>>>> from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [=
2].
> >>>>>>>
> >>>>>>> As a fact that starts from LLVM 20, no official prebuilt multi-ta=
rgets
> >>>>>>> are included and users might need to cross-built it from source. =
[3] is
> >>>>>>> an example of instructions for building.
> >>>>>>>
> >>>>>>> [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<AR=
CH>.a
> >>>>>>> E.g.
> >>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> >>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> >>>>>>>
> >>>>>>> [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.=
builtins.a
> >>>>>>> E.g.
> >>>>>>> lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> >>>>>>> lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> >>>>>>>
> >>>>>>> [3]
> >>>>>>> git clone https://github.com/llvm/llvm-project.git
> >>>>>>> cd llvm-project
> >>>>>>> git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> >>>>>>> mkdir build-builtin && cd build-builtin
> >>>>>>> cmake -G Ninja ../llvm \
> >>>>>>>   -DCMAKE_BUILD_TYPE=3DRelease \
> >>>>>>>   -DCMAKE_C_COMPILER=3Dclang \
> >>>>>>>   -DLLVM_ENABLE_PROJECTS=3D"clang" \
> >>>>>>>   -DLLVM_ENABLE_RUNTIMES=3D"compiler-rt" \
> >>>>>>>   -DLLVM_TARGETS_TO_BUILD=3D"X86;AArch64" \
> >>>>>>>   -DLLVM_BUILTIN_TARGETS=3D\
> >>>>>>>     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=3DLinux \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=3D\
> >>>>>>>     <YOUR_TOOLCHAIN_GCC> \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=3D\
> >>>>>>>     <YOUR_TOOLCHAIN_GCC> \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=3D\
> >>>>>>>     <YOUR_TOOLCHAIN_LIBC_DIR> \
> >>>>>>>   -DCOMPILER_RT_BUILD_BUILTINS=3DON \
> >>>>>>>   -DCOMPILER_RT_BUILD_SANITIZERS=3DOFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_XRAY=3DOFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_LIBFUZZER=3DOFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_PROFILE=3DOFF \
> >>>>>>>   -DCMAKE_INSTALL_PREFIX=3D<INSTALL_DIR> \
> >>>>>>>   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=3DOFF
> >>>>>>> ninja builtins
> >>>>>>> sudo ninja install
> >>>>>>>
> >>>>>>> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> >>>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>>>>>
> >>>>>> I think that newer versions don't even ship this moves us further =
away
> >>>>>> from a solution here as all of the logic. I think we need to look =
at the
> >>>>>> suggestion of just importing the assembly version of the function.
> >>>>>
> >>>>> But, the assembly versions are architecture-specific, do you want a
> >>>>> portable C code for it?
> >>>>
> >>>> Is it easily done in C? If not, we can just try and make it clear wh=
at
> >>>> needs to be pulled out of LLVM sources if/when another platform
> >>>> encounters the problem.
> >>>>
> >>> But maybe we can ask the LLVM project owner why they removed the
> >>> prebuilt multi-targets since 20.0.0.
> >>> May current patch can support multiple target layouts of pre-15 and
> >>> post-15 patterns (I believe they will keep the one of post-15 for the
> >>> future), if they can provide the prebuilt multi-targets via package
> >>> managers or release tarballs then it is the best solution.
> >>> In the future we might need other functions from those libraries and
> >>> implementing it in U-Boot is not a good choice IMO.
> >>
> >> I think adding all of that logic to the Makefile is taking us down the
> >> wrong path. Looking at the kernel, they're working with LLVM to be able
> >> to disable these 128bit intrinsics currently (as part of rust support).
>=20
> Good to know.
>=20
> >> So hopefully we just need some temporary workaround until things get
> >> fixed upstream.
> >>
> > I will try to implement a C code function as a temporary solution and
> > be back shortly.
>=20
> To solve a similar issue in OP-TEE we decided to import a few files
> unmodified from the LLVM compiler-rt tree, and that's plain C [1]. OTOH if
> it's only a temporary solution, maybe a single C file can be put together.
>=20
> [1] https://github.com/OP-TEE/optee_os/commit/48952fd403d867dbf13675e062c=
d8a7d2e5260a9

This is a good starting point, thanks.

--=20
Tom

--UPnXCM9cqEoLclZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+dEACgkQFHw5/5Y0
tyzbbwv/V5o7ip1AuMF80Mibd3uk+fKN8a0x9jE9Tkx05YiqbjLjVYycxRWqDKRD
OV8/5UwNi3TQGtAj82LKNsMR3GpGO5WJN4amZ0azL8EgKLLWBwT3Bu4CM6bu7R3C
AP8jnl7l2zFN0iloUTo8w2SceMeOs0igiTsh6IiyURrhY+rOw6FTtEsDrrQP/kZV
M973J4tfhmo/QJyrC/tfTxfImjCuEBXdLHatK7PWVY+F2mfG6JBLYDeA39ol22jz
D6YnmhfJc5pabHLZTojo7qb6CLrM+Sbz6vLzxLfCZUBlQlsRUvMVZ0vF9lo89NoS
roY0kgq/UCgLODnTsYIQziCEa8D8BqAiF7ROIrja0/fYvROO+C59+f8EnjGhxwbA
AyuMor8vRCrMj5S3sTfBOmhjxTN5L/xnE0ceCgW8EVF6UpoX0+FSLKx9FhfE3cgf
4tldzSYxBbef0RgcP3o6LJv5oh03yU4CAq1eY61PPtK6y2ye42udgKCb171g1DiH
1yW6NdW7
=nod+
-----END PGP SIGNATURE-----

--UPnXCM9cqEoLclZM--
