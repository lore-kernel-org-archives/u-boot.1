Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E05BC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C87F82B07;
	Fri,  6 Jun 2025 16:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xyFwCRvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF36082B0E; Fri,  6 Jun 2025 16:26:08 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C981782A8D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3109f106867so2638994a91.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749219963; x=1749824763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ebw1QUtu7m8c9W2vxW/FFrks2UkZHIyBWJQRROhJNPA=;
 b=xyFwCRvGDW9VrWojSdmx5eNz2uDNdIsb96w1t68MaQhzjf/nRiHnTy9ecGJW0j32qS
 seQqas5ss6mS/MUBWWLvDuMWR175NKnhCmIV5gEx7vFUHnRHfxJ76Uu9y9tzsxAELJkS
 otX0wMmqBkJCWkvuL+3NtNfQ8tA9uKGSBt/Rd0kE2rWldBQ4Qkt0ItyJ2NP/7kD21s5t
 1sD9fNabnw+8h99DvgI9P2WiG0yXXpccls14R9+eFhRStIm1jkhThdQEiRkiTdiYu0+e
 3fDaltEZ7uuwBCACKM8aAoEyUUQ1uAV0HmMl0C1udS3UUWEg9GxgUXQx/OJwxejIkGqm
 qQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219963; x=1749824763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ebw1QUtu7m8c9W2vxW/FFrks2UkZHIyBWJQRROhJNPA=;
 b=B9QbLUoeAok6QG5TAggfX1/aktTBtYHlFDt1lqcuk+LghUtCA7HlaW8UOlGL0sOY1m
 UWqD+8PbSDlbQBpSYU1C5Z67ns01Krmjo3YYUrhITT8IblTeNe8u5/Moc44qipWrtwDo
 l42iy5atP1dkYgV/ySh3PKbnJSeooi/Pufms1bYknJFdW3U1XH0+i4P0YnGKc+24OKmD
 dxKWqy2LfJuaxFsCNmvWoHysdILsemR1g4RKS3xxkcqlz5qZENtV7bvyeUOlnivlWEwM
 Ju8uY3945Jn/4n6FllJ73KWDhfVjkVTOCwAZKrBHquFtWVe7T7TaFyxku2YFizvH3v2r
 47sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTL46hDt4yTiRHyFk+JrBk3gK72nKrbt9T5EUp0kx+x3frk87ljggcdz4vk9suxBx+Vq9yMdQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0i7g9bdu4wb2m1WJEmOq/VVDDyuiGFw1erb88tpXBiTiLmoFR
 JUNa1SHLtzP/9z9rykG1tc/jDWwVYmPjp+7Yi7N9KOpIMlNYWBobzbcTEEq7rsulrmmNIXNirKf
 MNGiK0a4quTclxzBqLBKFHisxQ9hIyH4MvReQLwHc6gMahD8hTqm1YbM=
X-Gm-Gg: ASbGnct2ZQDmbABB13I+sCeGhy4/KzdjVwCwtHfaDLed1vDjQ35xwL+0qQ39GXHlJK+
 p0FbYxSyZNzmkkHmSsYSP7LMWSt4JysTRSngRC6lXrWZu6eyEdzHPX6VsHwmnyR/IZJR3Te0QaZ
 A+sb/FarkSS17e65NsHORqOh+3nBJti0c5ig==
X-Google-Smtp-Source: AGHT+IHxTKTyeQ9TOOLO09/K3rvE8KbmSDZKg3vBdkhkbzB7ybfXUJ1raOm0GDHpfcVjJL/p0IDCM/jBlcrcGc25ErY=
X-Received: by 2002:a17:90b:55ce:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31346b56c43mr6287696a91.17.1749219963235; Fri, 06 Jun 2025
 07:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
 <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
 <20250605214655.GG1382132@bill-the-cat>
 <CAEfUkUKR-zZ124VsOX31KNer6EiDKyXgO=oF2L2YwUOgf40CEg@mail.gmail.com>
 <c114ac9f-bcce-4dbb-bf32-1825d455240d@linaro.org>
In-Reply-To: <c114ac9f-bcce-4dbb-bf32-1825d455240d@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 6 Jun 2025 10:25:50 -0400
X-Gm-Features: AX0GCFvX74V1t45w2xkOt5iJGX_oWiTXC8E4RB5bBGqskyTElmzipdOTqodjz2E
Message-ID: <CAEfUkULJ0_MzuDHecAHPL6zEb6yuEkajagTEqa8cLef56osf5g@mail.gmail.com>
Subject: Re: [PATCH v2] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Sam Edwards <cfsworks@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
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

Hi Jerome,

On Fri, 6 Jun 2025 at 02:58, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 6/6/25 00:10, Raymond Mao wrote:
> > Hi Tom,
> >
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
> >>>>>>> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> >>>>>>> function provided by the compiler runtime, typically libgcc for GCC or
> >>>>>>> clang_rt.builtins for Clang.
> >>>>>>> Thus 'clang_rt.builtins' library is required when building using Clang.
> >>>>>>>
> >>>>>>> This patch supports the location layout of clang_rt.builtins libraries
> >>>>>>> from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
> >>>>>>>
> >>>>>>> As a fact that starts from LLVM 20, no official prebuilt multi-targets
> >>>>>>> are included and users might need to cross-built it from source. [3] is
> >>>>>>> an example of instructions for building.
> >>>>>>>
> >>>>>>> [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> >>>>>>> E.g.
> >>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> >>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> >>>>>>>
> >>>>>>> [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
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
> >>>>>>>   -DCMAKE_BUILD_TYPE=Release \
> >>>>>>>   -DCMAKE_C_COMPILER=clang \
> >>>>>>>   -DLLVM_ENABLE_PROJECTS="clang" \
> >>>>>>>   -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
> >>>>>>>   -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
> >>>>>>>   -DLLVM_BUILTIN_TARGETS=\
> >>>>>>>     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
> >>>>>>>     <YOUR_TOOLCHAIN_GCC> \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
> >>>>>>>     <YOUR_TOOLCHAIN_GCC> \
> >>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
> >>>>>>>     <YOUR_TOOLCHAIN_LIBC_DIR> \
> >>>>>>>   -DCOMPILER_RT_BUILD_BUILTINS=ON \
> >>>>>>>   -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_XRAY=OFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
> >>>>>>>   -DCOMPILER_RT_BUILD_PROFILE=OFF \
> >>>>>>>   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
> >>>>>>>   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
> >>>>>>> ninja builtins
> >>>>>>> sudo ninja install
> >>>>>>>
> >>>>>>> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> >>>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>>>>>
> >>>>>> I think that newer versions don't even ship this moves us further away
> >>>>>> from a solution here as all of the logic. I think we need to look at the
> >>>>>> suggestion of just importing the assembly version of the function.
> >>>>>
> >>>>> But, the assembly versions are architecture-specific, do you want a
> >>>>> portable C code for it?
> >>>>
> >>>> Is it easily done in C? If not, we can just try and make it clear what
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
>
> Good to know.
>
> >> So hopefully we just need some temporary workaround until things get
> >> fixed upstream.
> >>
> > I will try to implement a C code function as a temporary solution and
> > be back shortly.
>
> To solve a similar issue in OP-TEE we decided to import a few files
> unmodified from the LLVM compiler-rt tree, and that's plain C [1]. OTOH if
> it's only a temporary solution, maybe a single C file can be put together.
>
Sounds good. I can put the same stuff under
'<u-boot>/lib/mbedtls/port/compiler-rt'.
Thanks for sharing.

Raymond

> [1] https://github.com/OP-TEE/optee_os/commit/48952fd403d867dbf13675e062cd8a7d2e5260a9
>
> HTH,
> --
> Jerome
