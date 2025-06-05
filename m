Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA67C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3569F8091A;
	Thu,  5 Jun 2025 22:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CU2pK0hZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD0381E25; Thu,  5 Jun 2025 22:52:37 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2458080050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-311a6236effso1115261a91.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749156752; x=1749761552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3W/WgYeRNny8k0qSYHyyi6ePasZQeUGAybQqAzVRnA=;
 b=CU2pK0hZZZdMTmimcQykxysKqj4TJl9wtYHK0lo23xY5a+RPqgvYdY6xprUOlbPCUv
 7YG7OPFoY608DR5tVXjhnHnhMfRs0n1Y2f8uiovldn6L5l9KgSf/xECfsi1XXlXxkoXg
 5DWeHNZig2HxowpDhmPKfzzfbmMJhNvZDaOAo0qonc1RMCpawM8fgBgvo9ty4EW411QO
 YDAYdL8NDy4bgWy+2pJu8reO6qKz19fw0sKNlT3zbHNv5BTr9IT3Dd/o8cnAiOHeP+F7
 SwkG9PD/NQhXx0fVpuELI7TgDmDvWphzLeeHSd8pwyD2yh8wEcYJaL7w6FSkLhU7ZkLm
 vxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749156752; x=1749761552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3W/WgYeRNny8k0qSYHyyi6ePasZQeUGAybQqAzVRnA=;
 b=rs6MZMKdVg2kJ7vU5tg9u4eIbEZ7RXX7KGry1sO7+dOJautX6W3WDEeh4HzyaWz9Yn
 1wCm0bhgk5is4FziBXOGDoGITZZ3yIkxRzWb/Q9kQtudGlN28znqqqq3dQwRNEIMMMdQ
 DZufWsn9eyzvTD1Hbl6bDhPebUoFG77GlejYwwXfgJgGVryF7Dvvq6YBnTtn55n6YP9e
 7GTGRmFdCW9taBlrkxe7jJqxxuS3rkVT9p9y6ypZy3Tvlqy4JFj/bUqCJ8iunJNemblu
 YuvA7bJBoV/G9eMmsuRNx24PZMBajmhh+tXxVFRcfVoy6k4pZPJRnO9mWv/0zrl/Hsrf
 Fouw==
X-Gm-Message-State: AOJu0YwbZ31HX2L1irCxYA3x8RdMhKfpqt+04jMLBGot0gH3yo1Jc+++
 7NETxvVeGzGiurMwWqUlSEP4Kk9yZNbrQU/CKU1zRAZHsqSZ5reo6m59mEd+0nD6h5mHiAx8xft
 WJyMnwC4etseYe5yaXsfd5UNRceMz309Iz1OVa5F0ZQ==
X-Gm-Gg: ASbGncucUv6hDqWxdFVDizKaxSLxK9pfeaSQBD8Lv3CcRlXJEU0L2aACd8DNgEai9mV
 ZNoTxajDeVYLm2xdlOPMv+Q471Bf55pjGyM12leWavuh2EHlXDnyBzRcL620yX9vOM6wv0WsChS
 LKQFVr0rai3PEr2UxtbKlx+y/DmfzLUAA5MA==
X-Google-Smtp-Source: AGHT+IGnAZ1q5ZUE6ZliCiot3zZzTKIR/wG3uomZLmzpJ7KRTD2dJxVNU/fTwNtj8UgtS1eqKjZcYDKxOrEVHuPj/FI=
X-Received: by 2002:a17:90a:d88d:b0:311:b0ec:1360 with SMTP id
 98e67ed59e1d1-3134706d56bmr1763730a91.29.1749156752605; Thu, 05 Jun 2025
 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
In-Reply-To: <20250605200117.GD1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Jun 2025 16:52:20 -0400
X-Gm-Features: AX0GCFsHtq4qgf4vpAxVogvb2XXFFwgzHtYjz-71EmTGsnYWmy1hJBiTi3np0Oo
Message-ID: <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
Subject: Re: [PATCH v2] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 5 Jun 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
> > >
> > > > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > > > function provided by the compiler runtime, typically libgcc for GCC or
> > > > clang_rt.builtins for Clang.
> > > > Thus 'clang_rt.builtins' library is required when building using Clang.
> > > >
> > > > This patch supports the location layout of clang_rt.builtins libraries
> > > > from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
> > > >
> > > > As a fact that starts from LLVM 20, no official prebuilt multi-targets
> > > > are included and users might need to cross-built it from source. [3] is
> > > > an example of instructions for building.
> > > >
> > > > [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> > > > E.g.
> > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> > > >
> > > > [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
> > > > E.g.
> > > > lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> > > > lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> > > >
> > > > [3]
> > > > git clone https://github.com/llvm/llvm-project.git
> > > > cd llvm-project
> > > > git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> > > > mkdir build-builtin && cd build-builtin
> > > > cmake -G Ninja ../llvm \
> > > >   -DCMAKE_BUILD_TYPE=Release \
> > > >   -DCMAKE_C_COMPILER=clang \
> > > >   -DLLVM_ENABLE_PROJECTS="clang" \
> > > >   -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
> > > >   -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
> > > >   -DLLVM_BUILTIN_TARGETS=\
> > > >     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
> > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
> > > >     <YOUR_TOOLCHAIN_GCC> \
> > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
> > > >     <YOUR_TOOLCHAIN_GCC> \
> > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
> > > >     <YOUR_TOOLCHAIN_LIBC_DIR> \
> > > >   -DCOMPILER_RT_BUILD_BUILTINS=ON \
> > > >   -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
> > > >   -DCOMPILER_RT_BUILD_XRAY=OFF \
> > > >   -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
> > > >   -DCOMPILER_RT_BUILD_PROFILE=OFF \
> > > >   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
> > > >   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
> > > > ninja builtins
> > > > sudo ninja install
> > > >
> > > > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > >
> > > I think that newer versions don't even ship this moves us further away
> > > from a solution here as all of the logic. I think we need to look at the
> > > suggestion of just importing the assembly version of the function.
> >
> > But, the assembly versions are architecture-specific, do you want a
> > portable C code for it?
>
> Is it easily done in C? If not, we can just try and make it clear what
> needs to be pulled out of LLVM sources if/when another platform
> encounters the problem.
>
But maybe we can ask the LLVM project owner why they removed the
prebuilt multi-targets since 20.0.0.
May current patch can support multiple target layouts of pre-15 and
post-15 patterns (I believe they will keep the one of post-15 for the
future), if they can provide the prebuilt multi-targets via package
managers or release tarballs then it is the best solution.
In the future we might need other functions from those libraries and
implementing it in U-Boot is not a good choice IMO.

Regards,
Raymond


> --
> Tom
