Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8362C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 19:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223928091A;
	Thu,  5 Jun 2025 21:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZbgdJ2IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D553581E25; Thu,  5 Jun 2025 21:45:17 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89DF80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 21:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b2c4331c50eso1124831a12.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749152713; x=1749757513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z33tAkVGkQEJ7Vgt3eRRW40wOYYdZf+0fg4ntPLKDiw=;
 b=ZbgdJ2IF66nTE+KfIUX7nIOVRUjToLRkTH8BSVsxEpX6GjTvnnYZheaNjq6Kb6AkRQ
 7e7ZbzgsOoedYF9G291v4hdtvLyMm4hMi2niTbYqPTHoudPDZDgIyG9cZVXvs46qgWiY
 6Fs68xUf06b9SBViGDvfHsoChExdyGos5npQAWoxZddp6MC2V5NRCo0QDpZ3tV58euSd
 PbadFGW3CABXUPFmvQNyRI9ynWlPgFMMq7EdgnBBOIfIOAn1AhzNilOua1PhL62MMZac
 VSuceTpFx5/XkSoKWIlGSWjtbnERY7slrYar3tsXNVwJsYQUAG+FBclcA0RhaxJ9sT3p
 HHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152713; x=1749757513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z33tAkVGkQEJ7Vgt3eRRW40wOYYdZf+0fg4ntPLKDiw=;
 b=ZhhDvSvJWIB1y9YS4bSN10B8OmsW+WLUATonA8enKS7qhdHJNCo2BN2PadGrTsU27O
 b4HdnypyUVejRxudD6rddPw0ZSpWSfZrs20o30QHqFfuSL6glUXh1VIha7EIAcwU60R9
 UPnU4MbJXD4WXJovqmhdvfXqLNh0u3xB3WPWZzsoF84qL3AIf75vESl1sAgq1zeKmVDJ
 LfUiK7Xzeo+Frihui2rXCJTMyLdJhWw3HJjK/2XSIsMwRN66EFLmA/EZplo0l7y8ODPf
 fcktHgm6J6W1nik5PbUUTbsiuSgLwvriUYXjA+2t9L8sGTstzPRPZX3T/sA/aEJ+FsZg
 H0SA==
X-Gm-Message-State: AOJu0YyyoTwvBwjnh3j5y+pQCK6+XnhuDS0+h4qMnwZsmrGEVPS0vlfj
 b7/CZX0UcUerPf3phseGl+CQ0mM4nN07HKoe13H4W9/jMYVBNQrZupbBXk2A5AXEON+XsgLwkOd
 2PCY3mr89xPWIbAZgYvSk31GPN9HBKpk6F0k2HMatRg==
X-Gm-Gg: ASbGncu9L+LuJKPF3Ag0h6nWpyJsdG6gZ/tCEpK/obhztr11wF1om4XJHuGbWsFXwTm
 8AKp2HDC+BCdUvDn+IXu9VBF0iUqk/xaRjU0J2Wmm7joeTxw3X3gb8mCTOafSPDBSzKjPNTuYGV
 QkeP/DvGBZyabTZDH+mCxpmfoLBZzc5uWy7xsA/mfFxC16
X-Google-Smtp-Source: AGHT+IE7ecsUsGJgnqfH+41i5DHNU3ESHvC27ryQ4VJph8umIIa9HQX0AJwXKJzDBR5FXZrYH4LzoXxu57WAv7oZthg=
X-Received: by 2002:a17:90b:1f8a:b0:310:8d4a:a246 with SMTP id
 98e67ed59e1d1-31346b03cbbmr1114472a91.1.1749152713065; Thu, 05 Jun 2025
 12:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
In-Reply-To: <20250605171538.GC1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Jun 2025 15:45:00 -0400
X-Gm-Features: AX0GCFvWQeKpQE-NZQqrfJ4xW-AJDbF3zuChVgP74-4SIIycOcEm9Vz444oVMTM
Message-ID: <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
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

On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
>
> > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > function provided by the compiler runtime, typically libgcc for GCC or
> > clang_rt.builtins for Clang.
> > Thus 'clang_rt.builtins' library is required when building using Clang.
> >
> > This patch supports the location layout of clang_rt.builtins libraries
> > from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
> >
> > As a fact that starts from LLVM 20, no official prebuilt multi-targets
> > are included and users might need to cross-built it from source. [3] is
> > an example of instructions for building.
> >
> > [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> > E.g.
> > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> > lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> >
> > [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
> > E.g.
> > lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> > lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
> >
> > [3]
> > git clone https://github.com/llvm/llvm-project.git
> > cd llvm-project
> > git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> > mkdir build-builtin && cd build-builtin
> > cmake -G Ninja ../llvm \
> >   -DCMAKE_BUILD_TYPE=Release \
> >   -DCMAKE_C_COMPILER=clang \
> >   -DLLVM_ENABLE_PROJECTS="clang" \
> >   -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
> >   -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
> >   -DLLVM_BUILTIN_TARGETS=\
> >     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
> >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
> >     <YOUR_TOOLCHAIN_GCC> \
> >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
> >     <YOUR_TOOLCHAIN_GCC> \
> >   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
> >     <YOUR_TOOLCHAIN_LIBC_DIR> \
> >   -DCOMPILER_RT_BUILD_BUILTINS=ON \
> >   -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
> >   -DCOMPILER_RT_BUILD_XRAY=OFF \
> >   -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
> >   -DCOMPILER_RT_BUILD_PROFILE=OFF \
> >   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
> >   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
> > ninja builtins
> > sudo ninja install
> >
> > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>
> I think that newer versions don't even ship this moves us further away
> from a solution here as all of the logic. I think we need to look at the
> suggestion of just importing the assembly version of the function.
>
But, the assembly versions are architecture-specific, do you want a
portable C code for it?

Regards,
Raymond

> --
> Tom
