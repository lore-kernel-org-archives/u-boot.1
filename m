Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5FCC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 790808338B;
	Wed, 28 May 2025 17:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kAlHxXtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BBF8339D; Wed, 28 May 2025 17:22:16 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0AF8329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30e8feb1886so4357358a91.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748445732; x=1749050532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MLogXbmKyallBinWrkSPwUwMG9uLmrs7oVpuzrrS7og=;
 b=kAlHxXtDO6uw0q68xDnSt4WLpaf0tlIxd5/6Z+N+uDrfPH9+d4BQnHG+LPuGSpCYYH
 9b9rymG+sP3YQOTddsYYfa+41NCANuOjy23PPOTa6UALF1V9ZZ9G+fGYEZT6WleZRh0b
 7xAzQnr8l/0VeizhC1y7OU0BO33zPpEFw4YtjUweWr1lKdqPrm+oZf0fyegAieu/IE27
 BpEOf8MHlG6L2ybfKQiExAYc+jVuZm/bnowWoonApJiZbljLSsAsKGGo0zvIq1fsu159
 aOZimJSx+BxNU3bQAQlDyZez29kUszYr60vY362dmBO6LS8BtSnnBRuNoJvCEPLNoaF0
 uj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445732; x=1749050532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLogXbmKyallBinWrkSPwUwMG9uLmrs7oVpuzrrS7og=;
 b=OWOQcrx6Cra7mT9oXSzeDUkjcdazp7GKe7wYaECFWS6MktWPf2h9msb2kqxPYLyyxl
 l+1qE8u8A0EEml6zaM1MK7juRLKqSXVOLGKL1t0tzx09jhTcAhKDW9WmBjEfzRxSPJcj
 0BXraOxmIAQtuJLGYHk7YQC0hJH4TCyHY2yzmtZy7Rntv2+W5lkqHNL8hJUGxzLH8xfn
 vpFotITUlWWxK2FxLyLIv/MI5CfW7Hap3yyWhRCNWeaZ7tRODsCSsxGTI7RUO0miOl9Q
 vX58i7q0YV9Jdww17oCYISqAHQr7Sjyfg8imOjQqLY7GHh4cZVxskIqGm73DueQmecJB
 uyeQ==
X-Gm-Message-State: AOJu0YxOXxkcbs3dAQG4UZH9SEbN5Mqvkn1M0TsnNAJ8bqnOL1sUzSyc
 vQkGaCkXa59CJNZUE8CUdkPfxjgu2MkS6oQX1ICwayflLhffq1vy5BQ+1LpdUt38J+agt4KDS5p
 MkmivkUkeqqOBeC5e9E+En48SAF1XOHCKFhzPSnahHQ==
X-Gm-Gg: ASbGnct2Cwmd1grcU9mLZ7WXkBF4bmhFqVEjGqC3zu3kMl7wRtbCrwimVHWctMyXGz2
 1cfShhMAz81XHACatpJ9v3TODiFVu+fwa3WsKJ5YIzadq+EGk41R9CZOB6FXYsveTduNQWrujOM
 nIt4DihyVsEzs2VNCEkz68OfnlDMmkKGOBEh2fJtvXwK+E
X-Google-Smtp-Source: AGHT+IENBgDikg2GiAeX3dZ6D2/pVEUp5Cm8UEZ1xF5I7NvbI8ty5cE6hdK06m7tNrjk38GTFnmTpsl5s7mnYAVzjFw=
X-Received: by 2002:a17:90b:38c1:b0:311:b07f:1b86 with SMTP id
 98e67ed59e1d1-311b07f1ccemr9138369a91.29.1748445732457; Wed, 28 May 2025
 08:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
 <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
In-Reply-To: <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 28 May 2025 11:22:00 -0400
X-Gm-Features: AX0GCFtUZtUwzrnHa0Fz5dJvp7Uighzz5EqTXWmGraZL_3IfkjBGHA3xCZsbqHE
Message-ID: <CAEfUkUK-hpCLC6oeMdomDNQHvtObDowecr4uY0CiStugHNWpBg@mail.gmail.com>
Subject: Re: [PATCH] makefile: fix Clang link error when RSA_PUBLIC_KEY_PARSER
 is selected
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
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
 Prasad Kummari <prasad.kummari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 28 May 2025 at 04:25, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Rayond,
>
> On 5/27/25 23:05, Raymond Mao wrote:
> > MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> > function provided by the compiler runtime, typically libgcc for GCC or
> > clang_rt.builtins for Clang.
> > Thus 'clang_rt.builtins' library is required when building using Clang.
>
> How do you reproduce the problem? Can you give the config and build
> command you are using?
>
I am using this:
CROSS_COMPILE=aarch64-none-linux-gnu- make O=out CC="clang -target
aarch64-none-linux-gnu" all

> >
> > Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  Makefile | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f88684947ee..16506dcaec6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
> >  else ifeq ("riscv64", $(MK_ARCH))
> >    export HOST_ARCH=$(HOST_ARCH_RISCV64)
> >  endif
> > -undefine MK_ARCH
> >
> >  # Avoid funny character set dependencies
> >  unexport LC_ALL
> > @@ -915,8 +914,13 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
> >  else
> >  ifndef CONFIG_CC_IS_CLANG
> >  PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
> > +else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
> > +# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
> > +CLANG_RT_DIR := $(shell $(CC) --print-resource-dir)/lib/linux
> > +PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)
>
> I'm afraid this won't work when cross-compiling because the compiler-rt
> builtins libraries are usually not installed with the compiler.
> For example on my Ubuntu 24.04 machine:
>
> $ clang --version
> Ubuntu clang version 18.1.3 (1ubuntu1)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> $ clang --print-targets
>
>   Registered Targets:
>     aarch64     - AArch64 (little endian)
>     aarch64_32  - AArch64 (little endian ILP32)
>     aarch64_be  - AArch64 (big endian)
>     amdgcn      - AMD GCN GPUs
>     arm         - ARM
>     arm64       - ARM64 (little endian)
>     arm64_32    - ARM64 (little endian ILP32)
>     armeb       - ARM (big endian)
>     avr         - Atmel AVR Microcontroller
>     bpf         - BPF (host endian)
>     bpfeb       - BPF (big endian)
>     bpfel       - BPF (little endian)
>     hexagon     - Hexagon
>     lanai       - Lanai
>     loongarch32 - 32-bit LoongArch
>     loongarch64 - 64-bit LoongArch
>     m68k        - Motorola 68000 family
>     mips        - MIPS (32-bit big endian)
>     mips64      - MIPS (64-bit big endian)
>     mips64el    - MIPS (64-bit little endian)
>     mipsel      - MIPS (32-bit little endian)
>     msp430      - MSP430 [experimental]
>     nvptx       - NVIDIA PTX 32-bit
>     nvptx64     - NVIDIA PTX 64-bit
>     ppc32       - PowerPC 32
>     ppc32le     - PowerPC 32 LE
>     ppc64       - PowerPC 64
>     ppc64le     - PowerPC 64 LE
>     r600        - AMD GPUs HD2XXX-HD6XXX
>     riscv32     - 32-bit RISC-V
>     riscv64     - 64-bit RISC-V
>     sparc       - Sparc
>     sparcel     - Sparc LE
>     sparcv9     - Sparc V9
>     systemz     - SystemZ
>     thumb       - Thumb
>     thumbeb     - Thumb (big endian)
>     ve          - VE
>     wasm32      - WebAssembly 32-bit
>     wasm64      - WebAssembly 64-bit
>     x86         - 32-bit X86: Pentium-Pro and above
>     x86-64      - 64-bit X86: EM64T and AMD64
>     xcore       - XCore
>     xtensa      - Xtensa 32
> $ clang --print-resource-dir
> /usr/lib/llvm-18/lib/clang/18
> $ ls /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins*
> /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-i386.a  /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-x86_64.a
>
>
> Are you doing cross compilation for arm or arm64? Did you have to
> install the compiler-rt libraries separately from the compiler?
>
I installed clang manually.

This is what I have:
$ which clang
/home/raymond/toolchain/clang-12.0.0/bin/clang
$ clang --version
clang version 12.0.0
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/raymond/toolchain/clang-12.0.0/bin
$ clang --print-targets
  Registered Targets:
    aarch64    - AArch64 (little endian)
    aarch64_32 - AArch64 (little endian ILP32)
    aarch64_be - AArch64 (big endian)
    amdgcn     - AMD GCN GPUs
    arm        - ARM
    arm64      - ARM64 (little endian)
    arm64_32   - ARM64 (little endian ILP32)
    armeb      - ARM (big endian)
    avr        - Atmel AVR Microcontroller
    bpf        - BPF (host endian)
    bpfeb      - BPF (big endian)
    bpfel      - BPF (little endian)
    hexagon    - Hexagon
    lanai      - Lanai
    mips       - MIPS (32-bit big endian)
    mips64     - MIPS (64-bit big endian)
    mips64el   - MIPS (64-bit little endian)
    mipsel     - MIPS (32-bit little endian)
    msp430     - MSP430 [experimental]
    nvptx      - NVIDIA PTX 32-bit
    nvptx64    - NVIDIA PTX 64-bit
    ppc32      - PowerPC 32
    ppc32le    - PowerPC 32 LE
    ppc64      - PowerPC 64
    ppc64le    - PowerPC 64 LE
    r600       - AMD GPUs HD2XXX-HD6XXX
    riscv32    - 32-bit RISC-V
    riscv64    - 64-bit RISC-V
    sparc      - Sparc
    sparcel    - Sparc LE
    sparcv9    - Sparc V9
    systemz    - SystemZ
    thumb      - Thumb
    thumbeb    - Thumb (big endian)
    wasm32     - WebAssembly 32-bit
    wasm64     - WebAssembly 64-bit
    x86        - 32-bit X86: Pentium-Pro and above
    x86-64     - 64-bit X86: EM64T and AMD64
    xcore      - XCore
$ clang --print-resource-dir
/home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0
$ ls /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins*
/home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-aarch64.a
 /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-x86_64.a
/home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-armhf.a

Regards,
Raymond

> Thanks,
> --
> Jerome
>
> >  endif
> >  endif
> > +undefine MK_ARCH
> >  PLATFORM_LIBS += $(PLATFORM_LIBGCC)
> >
> >  ifdef CONFIG_CC_COVERAGE
