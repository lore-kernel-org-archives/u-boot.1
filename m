Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1FBC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A0B83950;
	Wed, 28 May 2025 10:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wf1YRBtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4669383951; Wed, 28 May 2025 10:25:13 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B2583939
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-603fdd728ccso6455164a12.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420710; x=1749025510; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zC5qZyg+jQgSiv+9/ROOF6jYTpJRTaxIO8Kh0T2CaEU=;
 b=wf1YRBtgbUIGjvreOlz4oMJamE1aqfP5cLhWkHcv5fMUABH4YUvy4lHX++ze0DgB5+
 QOtqoXEXBiakPNFBK1CHWxJ5JYgj/FGvR33aszxW2b96rhMjkJ5JCbCkMZjUu7tviFn5
 cO84jagmAwloUhYHsUjpdYQVV1qHKS415EIPFj++dwSrZ+Eq7DfsFuWCcF8PAakIftIo
 rDafsH1lsJKRLWwxpgBx/YvSF7Nvbj2b6EWYp/1oiS3lxo7KMuDRaapWKgPqgMKoxRK5
 QB773oVDzEFUcO97NjuIW4rePPHsZO/P3vUQJwIy0xkfgA3CKzWb6jfXhRzb/Ch9xDM9
 5r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420710; x=1749025510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zC5qZyg+jQgSiv+9/ROOF6jYTpJRTaxIO8Kh0T2CaEU=;
 b=VXHCf6tRz5glkpNaYg+8k7uRZHsmkTKdqkFUaRl35LHwLbq3LFTau8n9SUwkQw53/M
 bUr3bcPDl2RU5SCMZ5y33xQ3GjuLSdKAvIJaoXp49VBgapoN9SFO3/TlbqhGQOTmeM6n
 ppY+ENlJ5CSwlZv7852SM8BOAJHGRfzI5PLYAef7Z4RDNQ5nBDOjrvRQ3l9/X43Us3pV
 r3Lb4NkTP+jo8LUVhekGiMhOAVlK3DaSTltyJtwggcATepnRMpj/E6iSLeD0F/BxTOPb
 ZylBdIsppmSgIr418Hbgl6SNg5xqCt3XAZBdEtKxJXxo5PZDiyMvValzY0Rl4+/oGUSg
 b0hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULGDnk1LuvPrx/cA6RifGWVxOUsNVwv5uzB6LnKg+zI3zBXNsLFpeZ9dbqbqw6V1O06265ilU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1Gmw69fBOj/rpEycj58PF/q0bNGCZEI7daQwlf4Xz754zUkXa
 SWETppQa3J+F7ekHCvkIQwT9dV//DLWes45nr3K+0TuZhvjTSgWxAJxjSEit6uef7Os=
X-Gm-Gg: ASbGncu+ttIi3AAplydiGIZXRqFbY/4xYQeaSNvpVIyIoGdKzuPlwzXjh9JxTF/4uBj
 sa1wwNuomgs2om/GyXpxygLsDJz/Gc7rNjXtW3Cv5aFjbrP0R1VuHpktensk5zeEmkizTLTxADe
 Zr2YGicPrP1HG47CtTUe3w0oRnwSoVGmoGLnay3cgqd644Ko3r1d9pEzBlbiPkYZ4SvYIVr7CJp
 MBcYQFUQY50vMlC5AmJ2YS+heZTPz6bNfE3pj1IAug2lr6gCTmED0b2es+XsEYyl3RkZSp0umg0
 Mo1YGmrviZeCTWALdUY/i3f5Ylx+Xc20ITX5tRCaP1BU56fR7iW7Z5x3vlbI
X-Google-Smtp-Source: AGHT+IGS4i29hDH+fww+ezM0pX6UvSf+kQUYZriHM8JTjMD4SGw8wH43QjLJTHXLQ5oYbPo0K08ZGA==
X-Received: by 2002:a05:6402:5112:b0:604:e5cc:1a3f with SMTP id
 4fb4d7f45d1cf-604e5cc1f8cmr6399370a12.20.1748420709724; 
 Wed, 28 May 2025 01:25:09 -0700 (PDT)
Received: from [10.5.0.2] ([94.101.114.227]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6051d5f24afsm447822a12.22.2025.05.28.01.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:25:09 -0700 (PDT)
Message-ID: <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
Date: Wed, 28 May 2025 10:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] makefile: fix Clang link error when RSA_PUBLIC_KEY_PARSER
 is selected
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250527210508.1488509-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Rayond,

On 5/27/25 23:05, Raymond Mao wrote:
> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> function provided by the compiler runtime, typically libgcc for GCC or
> clang_rt.builtins for Clang.
> Thus 'clang_rt.builtins' library is required when building using Clang.

How do you reproduce the problem? Can you give the config and build
command you are using?

> 
> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index f88684947ee..16506dcaec6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
>  else ifeq ("riscv64", $(MK_ARCH))
>    export HOST_ARCH=$(HOST_ARCH_RISCV64)
>  endif
> -undefine MK_ARCH
>  
>  # Avoid funny character set dependencies
>  unexport LC_ALL
> @@ -915,8 +914,13 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
>  else
>  ifndef CONFIG_CC_IS_CLANG
>  PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
> +else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
> +# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
> +CLANG_RT_DIR := $(shell $(CC) --print-resource-dir)/lib/linux
> +PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)

I'm afraid this won't work when cross-compiling because the compiler-rt
builtins libraries are usually not installed with the compiler.
For example on my Ubuntu 24.04 machine:

$ clang --version
Ubuntu clang version 18.1.3 (1ubuntu1)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
$ clang --print-targets

  Registered Targets:
    aarch64     - AArch64 (little endian)
    aarch64_32  - AArch64 (little endian ILP32)
    aarch64_be  - AArch64 (big endian)
    amdgcn      - AMD GCN GPUs
    arm         - ARM
    arm64       - ARM64 (little endian)
    arm64_32    - ARM64 (little endian ILP32)
    armeb       - ARM (big endian)
    avr         - Atmel AVR Microcontroller
    bpf         - BPF (host endian)
    bpfeb       - BPF (big endian)
    bpfel       - BPF (little endian)
    hexagon     - Hexagon
    lanai       - Lanai
    loongarch32 - 32-bit LoongArch
    loongarch64 - 64-bit LoongArch
    m68k        - Motorola 68000 family
    mips        - MIPS (32-bit big endian)
    mips64      - MIPS (64-bit big endian)
    mips64el    - MIPS (64-bit little endian)
    mipsel      - MIPS (32-bit little endian)
    msp430      - MSP430 [experimental]
    nvptx       - NVIDIA PTX 32-bit
    nvptx64     - NVIDIA PTX 64-bit
    ppc32       - PowerPC 32
    ppc32le     - PowerPC 32 LE
    ppc64       - PowerPC 64
    ppc64le     - PowerPC 64 LE
    r600        - AMD GPUs HD2XXX-HD6XXX
    riscv32     - 32-bit RISC-V
    riscv64     - 64-bit RISC-V
    sparc       - Sparc
    sparcel     - Sparc LE
    sparcv9     - Sparc V9
    systemz     - SystemZ
    thumb       - Thumb
    thumbeb     - Thumb (big endian)
    ve          - VE
    wasm32      - WebAssembly 32-bit
    wasm64      - WebAssembly 64-bit
    x86         - 32-bit X86: Pentium-Pro and above
    x86-64      - 64-bit X86: EM64T and AMD64
    xcore       - XCore
    xtensa      - Xtensa 32
$ clang --print-resource-dir
/usr/lib/llvm-18/lib/clang/18
$ ls /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins*
/usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-i386.a  /usr/lib/llvm-18/lib/clang/18/lib/linux/libclang_rt.builtins-x86_64.a


Are you doing cross compilation for arm or arm64? Did you have to
install the compiler-rt libraries separately from the compiler?

Thanks,
-- 
Jerome

>  endif
>  endif
> +undefine MK_ARCH
>  PLATFORM_LIBS += $(PLATFORM_LIBGCC)
>  
>  ifdef CONFIG_CC_COVERAGE
