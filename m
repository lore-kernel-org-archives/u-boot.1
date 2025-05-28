Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50D1C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D25C83403;
	Wed, 28 May 2025 17:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5EuAP+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB117838EF; Wed, 28 May 2025 17:47:02 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D68B8334F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-232059c0b50so71805ad.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748447217; x=1749052017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1VNo58UkLZuk1fpbhU2QpXijaghBCFxPb2Haf4OsKSI=;
 b=E5EuAP+RfwKR9jFyJhbakSx+otP1BMQj4CSl8ILdh1Oh3WQggKGHQmqFK6BhXfdTq+
 Jn3Q9txzzFTnb5HApgfUNRpNGg/b1d8+xIkwBh9FW9RqpuQPvNpFfM3vOhCRCOM9wAt3
 v1KLLigdPrzCKOo7enV3o8h4fPHDN62mDf1VMaa2YiI8LXMyy3hzqmTo1kkJEBuQYOI9
 S1JKj9FWl5fDAyhFKHl3gbKV69BiiuOpZITfFQN9T6IQNZCIQir9jq9rtGRO5HKvjmEh
 E3aj0Ii/15S+FRtt2AItaO51z8avDHLJvsZ6cJDaTN5ByuoA6o5UUE8a2ttFPLDCce3b
 +k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748447217; x=1749052017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1VNo58UkLZuk1fpbhU2QpXijaghBCFxPb2Haf4OsKSI=;
 b=Ga2REDP4RqyRTVQAt5zsF8vSMGbyTqO61eZRueyGUC2MyafBODcpSW35ONnea8kG3U
 EskH1hJKsvOx+W5EDSxUD2STZNN8EpnL4xEgZsVOWorJaoRkksmlP0cYxMR4rqCvjYUq
 dWnn8vcJwnANSJESKy3fGSDr7y/eKXIKGfTteyqakN585sBtTEQ82CKz1ZcOg/7PPGYN
 xm6woazk4mjDv2WkL39COlkNo9BNATmo2V47jdyHOIwA5fBSs+nTU2dooJOfOWNeHqyE
 gCM8h4wNXaRriv0jAz+RMTNEzOZMnsDVA6UoDvwTr0sthCd+Y59Dyxzad6VMT8AoXaT5
 jEyw==
X-Gm-Message-State: AOJu0YwNYAUCETBC+gYJS45xm4C6UbZ/yAQvKat0l5CxmhcCUf+gfPoh
 F6mJQqd/6oSDvLOnkZq+nCW+CDL2DZGKxjN4ot+XhMpxEiuXI6yIlHH3ZM9lsjGNvcro646kmHj
 coquuqpEBC7TIAmLAlweC02zRKzMvt4AneKsAoL9lqQ==
X-Gm-Gg: ASbGnctn6Cpn5EIjHyvcc8n5VEZmK3szTpsDIEWmxKPBgxZLxaTToa/R9u39iCfkxrt
 qVf7xjl/egoRdfzjl+yxdVCrLMGbUbi28F4OLH/YGTojXTFhoPHVOWpQrVTehO6V3VH7Eh+1JjS
 7yOa2VLeGv7DF733ZA6jTI6plOfEuUkBDdMw==
X-Google-Smtp-Source: AGHT+IHzn4/rAiupe0LOS6Nxt8gPfetKsUbIbNl8/9b4idNjqMnUXhB6jDpPQfco1xM9+L2cqzp1JD0oVQA4QwZcf+I=
X-Received: by 2002:a17:90b:3ec6:b0:30a:255c:9d10 with SMTP id
 98e67ed59e1d1-3110f3369demr24607670a91.8.1748447217404; Wed, 28 May 2025
 08:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
 <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
 <CAEfUkUK-hpCLC6oeMdomDNQHvtObDowecr4uY0CiStugHNWpBg@mail.gmail.com>
 <5c26ad0f-3dfc-4dea-bd81-9f201c17e5c1@linaro.org>
In-Reply-To: <5c26ad0f-3dfc-4dea-bd81-9f201c17e5c1@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 28 May 2025 11:46:45 -0400
X-Gm-Features: AX0GCFsusnI7ahmMmjhCznTleUdFy63MehyXkhZW77cz1XoAOulAI60-R0R60Bk
Message-ID: <CAEfUkU+vHG5p7jPQF7GMAy1yvmKmXD31Lk2kEDimTLf3ncRHJw@mail.gmail.com>
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

On Wed, 28 May 2025 at 11:37, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 5/28/25 17:22, Raymond Mao wrote:
> > Hi Jerome,
> >
> > On Wed, 28 May 2025 at 04:25, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Hi Rayond,
> >>
> >> On 5/27/25 23:05, Raymond Mao wrote:
> >>> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> >>> function provided by the compiler runtime, typically libgcc for GCC or
> >>> clang_rt.builtins for Clang.
> >>> Thus 'clang_rt.builtins' library is required when building using Clang.
> >>
> >> How do you reproduce the problem? Can you give the config and build
> >> command you are using?
> >>
> > I am using this:
> > CROSS_COMPILE=aarch64-none-linux-gnu- make O=out CC="clang -target
> > aarch64-none-linux-gnu" all
> >
> >>>
> >>> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> >>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>> ---
> >>>  Makefile | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Makefile b/Makefile
> >>> index f88684947ee..16506dcaec6 100644
> >>> --- a/Makefile
> >>> +++ b/Makefile
> >>> @@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
> >>>  else ifeq ("riscv64", $(MK_ARCH))
> >>>    export HOST_ARCH=$(HOST_ARCH_RISCV64)
> >>>  endif
> >>> -undefine MK_ARCH
> >>>
> >>>  # Avoid funny character set dependencies
> >>>  unexport LC_ALL
> >>> @@ -915,8 +914,13 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
> >>>  else
> >>>  ifndef CONFIG_CC_IS_CLANG
> >>>  PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
> >>> +else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
> >>> +# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
> >>> +CLANG_RT_DIR := $(shell $(CC) --print-resource-dir)/lib/linux
> >>> +PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)
> >>
> >> I'm afraid this won't work when cross-compiling because the compiler-rt
> >> builtins libraries are usually not installed with the compiler.
> >> For example on my Ubuntu 24.04 machine:
> >>
> >> $ clang --version
> >> Ubuntu clang version 18.1.3 (1ubuntu1)
> >> Target: x86_64-pc-linux-gnu
> >> Thread model: posix
> >> InstalledDir: /usr/bin
> >> $ clang --print-targets
> >>
> >>   Registered Targets:
> >>     aarch64     - AArch64 (little endian)
> >>     aarch64_32  - AArch64 (little endian ILP32)
> >>     aarch64_be  - AArch64 (big endian)
> >>     amdgcn      - AMD GCN GPUs
> >>     arm         - ARM
> >>     arm64       - ARM64 (little endian)
> >>     arm64_32    - ARM64 (little endian ILP32)
> >>     armeb       - ARM (big endian)
> >>     avr         - Atmel AVR Microcontroller
> >>     bpf         - BPF (host endian)
> >>     bpfeb       - BPF (big endian)
> >>     bpfel       - BPF (little endian)
> >>     hexagon     - Hexagon
> >>     lanai       - Lanai
> >>     loongarch32 - 32-bit LoongArch
> >>     loongarch64 - 64-bit LoongArch
> >>     m68k        - Motorola 68000 family
> >>     mips        - MIPS (32-bit big endian)
> >>     mips64      - MIPS (64-bit big endian)
> >>     mips64el    - MIPS (64-bit little endian)
> >>     mipsel      - MIPS (32-bit little endian)
> >>     msp430      - MSP430 [experimental]
> >>     nvptx       - NVIDIA PTX 32-bit
> >>     nvptx64     - NVIDIA PTX 64-bit
> >>     ppc32       - PowerPC 32
> >>     ppc32le     - PowerPC 32 LE
> >>     ppc64       - PowerPC 64
> >>     ppc64le     - PowerPC 64 LE
> >>     r600        - AMD GPUs HD2XXX-HD6XXX
> >>     riscv32     - 32-bit RISC-V
> >>     riscv64     - 64-bit RISC-V
> >>     sparc       - Sparc
> >>     sparcel     - Sparc LE
> >>     sparcv9     - Sparc V9
> >>     systemz     - SystemZ
> >>     thumb       - Thumb
> >>     thumbeb     - Thumb (big endian)
> >>     ve          - VE
> >>     wasm32      - WebAssembly 32-bit
> >>     wasm64      - WebAssembly 64-bit
> >>     x86         - 32-bit X86: Pentium-Pro and above
> >>     x86-64      - 64-bit X86: EM64T and AMD64
> >>     xcore       - XCore
> >>     xtensa      - Xtensa 32
> >> $ clang --print-resource-dir
> >> /usr/lib/llvm-18/lib/clang/18
> >> $ ls /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins*
> >> /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-i386.a  /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-x86_64.a
> >>
> >>
> >> Are you doing cross compilation for arm or arm64? Did you have to
> >> install the compiler-rt libraries separately from the compiler?
> >>
> > I installed clang manually.
> >
> > This is what I have:
> > $ which clang
> > /home/raymond/toolchain/clang-12.0.0/bin/clang
> > $ clang --version
> > clang version 12.0.0
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /home/raymond/toolchain/clang-12.0.0/bin
> > $ clang --print-targets
> >   Registered Targets:
> >     aarch64    - AArch64 (little endian)
> >     aarch64_32 - AArch64 (little endian ILP32)
> >     aarch64_be - AArch64 (big endian)
> >     amdgcn     - AMD GCN GPUs
> >     arm        - ARM
> >     arm64      - ARM64 (little endian)
> >     arm64_32   - ARM64 (little endian ILP32)
> >     armeb      - ARM (big endian)
> >     avr        - Atmel AVR Microcontroller
> >     bpf        - BPF (host endian)
> >     bpfeb      - BPF (big endian)
> >     bpfel      - BPF (little endian)
> >     hexagon    - Hexagon
> >     lanai      - Lanai
> >     mips       - MIPS (32-bit big endian)
> >     mips64     - MIPS (64-bit big endian)
> >     mips64el   - MIPS (64-bit little endian)
> >     mipsel     - MIPS (32-bit little endian)
> >     msp430     - MSP430 [experimental]
> >     nvptx      - NVIDIA PTX 32-bit
> >     nvptx64    - NVIDIA PTX 64-bit
> >     ppc32      - PowerPC 32
> >     ppc32le    - PowerPC 32 LE
> >     ppc64      - PowerPC 64
> >     ppc64le    - PowerPC 64 LE
> >     r600       - AMD GPUs HD2XXX-HD6XXX
> >     riscv32    - 32-bit RISC-V
> >     riscv64    - 64-bit RISC-V
> >     sparc      - Sparc
> >     sparcel    - Sparc LE
> >     sparcv9    - Sparc V9
> >     systemz    - SystemZ
> >     thumb      - Thumb
> >     thumbeb    - Thumb (big endian)
> >     wasm32     - WebAssembly 32-bit
> >     wasm64     - WebAssembly 64-bit
> >     x86        - 32-bit X86: Pentium-Pro and above
> >     x86-64     - 64-bit X86: EM64T and AMD64
> >     xcore      - XCore
> > $ clang --print-resource-dir
> > /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0
> > $ ls /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins*
> > /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> >  /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-x86_64.a
> > /home/raymond/toolchain/clang-12.0.0/lib/clang/12.0.0/lib/linux/libclang_rt.builtins-armhf.a
>
> Interesting. How did you install clang/LLVM? Did you get those builins
> library from multiple release packages?
>
That is an old version 12.0.0 and I cannot recall well where I got it
and how I installed it...
But looking at the CI job here [1], the clang builds passed and that
implies it got the libs properly.
I will take a look at the newer clang releases if I can find some clues.

[1] https://github.com/u-boot/u-boot/pull/773

Regards,
Raymond

> In the OP-TEE project we used to do that via a get_clang.sh script [1] but
> it broke when llvm-project stopped releasing all the binary packages we needed
> (aarch64-linux-gnu and armv7a-linux-gnueabihf). So we ended up importing the
> __udivti3 implementation in source code instead [3]. I'm not saying this is
> the way to go, but relying on libclang_rt.builtins assumes that a proper
> toolchain is available, and that should at least be documented.
>
> [1] https://github.com/OP-TEE/build/blob/1b68e0bb8a00/get_clang.sh
> [2] https://github.com/OP-TEE/build/commit/8dd39dc99f09
> [3] https://github.com/OP-TEE/optee_os/commit/48952fd403d8
>
> Regards,
> --
> Jerome
>
> >
> > Regards,
> > Raymond
> >
> >> Thanks,
> >> --
> >> Jerome
> >>
> >>>  endif
> >>>  endif
> >>> +undefine MK_ARCH
> >>>  PLATFORM_LIBS += $(PLATFORM_LIBGCC)
> >>>
> >>>  ifdef CONFIG_CC_COVERAGE
