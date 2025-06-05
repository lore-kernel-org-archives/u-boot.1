Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF18C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 22:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FF881E25;
	Fri,  6 Jun 2025 00:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dCkpN9gR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AED881F0D; Fri,  6 Jun 2025 00:10:43 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC888091A
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 00:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so1240531a91.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749161439; x=1749766239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ODjNJFmzqDf/vskXpdeuulFyq4spe9Sdn6KI3YEQUZ0=;
 b=dCkpN9gR6FNpeAo4YR0GKt7802Q1eBadJOHxGI1fn15kMK9sMez88UxCEqJIz6p61V
 ccHTkXDFhtoZU5PE56OQceEHVJDk3EXetEgbVApbV1vX7ZoQnf0fQ0d1IbVI0fIMDP9l
 iwPs5L6FOrRtxH/vBbOHQUlZ+i0ZUsDSmnZ0qre4DuDzh87PFGRSNul8wq0XBxOqiILs
 9hHPAqTXj/eMbWVo7fpywZ7YoPJmJa293RAMrobvHUso3xa2lyv+v/PQf8GR3CKG9o4M
 Y9SEOFLE4TQVveydbOp3VHEpSWy0X/sQFX3H4FaOZBr9cVBBzJZHD6ykWLXQ84HldwI8
 p83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749161439; x=1749766239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ODjNJFmzqDf/vskXpdeuulFyq4spe9Sdn6KI3YEQUZ0=;
 b=kQZ18jKUl1PRT44jG+DoLC+BISMa5MGSWuYP5X7OrDe/8G3ly6cAlF3ti8KDNpPxvG
 5jNrcUWeFZLk7pyOs5eGkaiaNMXHewncrFpropNfCV/VaxhPcQe/uvvvQE7rQqnyUgzI
 OyQ1Xd7gsx8OGzcZYQbpgfmiN68TdarGFIpRJLsbVKlXXDQZ8V68+J6OmPDBUoVcWCPC
 ZACIXPrkyyEpcLNIz4SQblgiPISnTIOOA8qNcgj+YHtk84aquL4oVY5C2VA/BfXeU3jO
 GbgDhXi2BFX5sib/iKf9uKVJM96pLhaU6A0Le+dQ4KEiGqKuiWO+NeqiL/QJ7+gipJ51
 PLYQ==
X-Gm-Message-State: AOJu0YyIP3fB2DKlvzpCKJ2i6F/66bORxuin7T5h/bl8LfI10g4pPjv8
 E8KUxwF0VUjxQaOughGq7Y6AmP2IfTdASA5jO+7BlsX6wxII7nsAjd3bFzSst29YNYLxxsNXov+
 Mq5mRrBXqFa6NSvVMiUn/2rbTZHU2PADAVwOne7Gxyw==
X-Gm-Gg: ASbGncvID6pLt5vJ5s2iT5VOMMJ41aALL185pJICW1/LSwAHvgAlaQEZpEBKU+FzYOz
 ogXc9b/KNlkeiXJZHUX/3ISVkIXz+L44QhS5vrWsZ/a2/k3ggOmLeYeDhxFPq9cZzWBFo8C87Xa
 g9NybWgz9/kEYgdF5MOfYQyOJHoV4HKs3y54HIguQ3aZ9z
X-Google-Smtp-Source: AGHT+IEPj/PSCUx6RxvFk4uyGBERacbpF9K1HGAlLJv2Eb6buB4b10pYrjHRdVlAkB9zkfZV5zsc4yR6M5z6mN9ZZMQ=
X-Received: by 2002:a17:90b:5383:b0:313:220c:b63b with SMTP id
 98e67ed59e1d1-3134769f727mr1673311a91.35.1749161439401; Thu, 05 Jun 2025
 15:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
 <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
 <20250605214655.GG1382132@bill-the-cat>
In-Reply-To: <20250605214655.GG1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Jun 2025 18:10:26 -0400
X-Gm-Features: AX0GCFuW_ra9AWyiqjgnPfFl6Euuobz68vEkQFgKkUnqdVeAYhHvbaI96nz1ppc
Message-ID: <CAEfUkUKR-zZ124VsOX31KNer6EiDKyXgO=oF2L2YwUOgf40CEg@mail.gmail.com>
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

On Thu, 5 Jun 2025 at 17:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 05, 2025 at 04:52:20PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Thu, 5 Jun 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
> > > > >
> > > > > > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > > > > > function provided by the compiler runtime, typically libgcc for GCC or
> > > > > > clang_rt.builtins for Clang.
> > > > > > Thus 'clang_rt.builtins' library is required when building using Clang.
> > > > > >
> > > > > > This patch supports the location layout of clang_rt.builtins libraries
> > > > > > from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
> > > > > >
> > > > > > As a fact that starts from LLVM 20, no official prebuilt multi-targets
> > > > > > are included and users might need to cross-built it from source. [3] is
> > > > > > an example of instructions for building.
> > > > > >
> > > > > > [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> > > > > > E.g.
> > > > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> > > > > > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> > > > > >
> > > > > > [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
> > > > > > E.g.
> > > > > > lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> > > > > > lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> > > > > >
> > > > > > [3]
> > > > > > git clone https://github.com/llvm/llvm-project.git
> > > > > > cd llvm-project
> > > > > > git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> > > > > > mkdir build-builtin && cd build-builtin
> > > > > > cmake -G Ninja ../llvm \
> > > > > >   -DCMAKE_BUILD_TYPE=Release \
> > > > > >   -DCMAKE_C_COMPILER=clang \
> > > > > >   -DLLVM_ENABLE_PROJECTS="clang" \
> > > > > >   -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
> > > > > >   -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
> > > > > >   -DLLVM_BUILTIN_TARGETS=\
> > > > > >     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> > > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
> > > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
> > > > > >     <YOUR_TOOLCHAIN_GCC> \
> > > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
> > > > > >     <YOUR_TOOLCHAIN_GCC> \
> > > > > >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
> > > > > >     <YOUR_TOOLCHAIN_LIBC_DIR> \
> > > > > >   -DCOMPILER_RT_BUILD_BUILTINS=ON \
> > > > > >   -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
> > > > > >   -DCOMPILER_RT_BUILD_XRAY=OFF \
> > > > > >   -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
> > > > > >   -DCOMPILER_RT_BUILD_PROFILE=OFF \
> > > > > >   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
> > > > > >   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
> > > > > > ninja builtins
> > > > > > sudo ninja install
> > > > > >
> > > > > > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > >
> > > > > I think that newer versions don't even ship this moves us further away
> > > > > from a solution here as all of the logic. I think we need to look at the
> > > > > suggestion of just importing the assembly version of the function.
> > > >
> > > > But, the assembly versions are architecture-specific, do you want a
> > > > portable C code for it?
> > >
> > > Is it easily done in C? If not, we can just try and make it clear what
> > > needs to be pulled out of LLVM sources if/when another platform
> > > encounters the problem.
> > >
> > But maybe we can ask the LLVM project owner why they removed the
> > prebuilt multi-targets since 20.0.0.
> > May current patch can support multiple target layouts of pre-15 and
> > post-15 patterns (I believe they will keep the one of post-15 for the
> > future), if they can provide the prebuilt multi-targets via package
> > managers or release tarballs then it is the best solution.
> > In the future we might need other functions from those libraries and
> > implementing it in U-Boot is not a good choice IMO.
>
> I think adding all of that logic to the Makefile is taking us down the
> wrong path. Looking at the kernel, they're working with LLVM to be able
> to disable these 128bit intrinsics currently (as part of rust support).
> So hopefully we just need some temporary workaround until things get
> fixed upstream.
>
I will try to implement a C code function as a temporary solution and
be back shortly.

Raymond

> --
> Tom
