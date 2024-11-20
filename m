Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5551FD6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3179892B8;
	Wed, 20 Nov 2024 14:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AlxRnP8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4791B89327; Wed, 20 Nov 2024 14:47:11 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4918916D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e79f73aaeso1669263b3a.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110427; x=1732715227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5kmnHDiVzwHZgebek9b2kPB5VpTl1lsC0SnSoG551k=;
 b=AlxRnP8dlsH6thqhjJBGZSxnf7BxadJ2ug8+krRridoSGN2y9dCrvSqpo1669dp9Ik
 bYdXwJcPSNtw2Vo5whvJC5wCaUnWFTnuCL+bmlPF03Xwo3bzPvMgNDWDFUk1bD6iTlWx
 04REsCg2bhMFNLgBSu91197B21TC7k3B2hQnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110427; x=1732715227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5kmnHDiVzwHZgebek9b2kPB5VpTl1lsC0SnSoG551k=;
 b=urqbw5kZzepAs0Cejl/mO/t0xQMEFIKv2xnY7P2KWVJfDZ0Gwlj8CVq6PADPN5w2YA
 hR1IX5s9ektsundBHJ/bHQo2Od68uiHTp5f3ykzOkqpj0QJV316Wl9rg7UEAr/W+8voz
 oqhuFAbtZkyOtNHuoNtyehc2x0e++B5OeW6FvMbW9hCs7Up6liRL7qix0Y5v5dtCL3ZD
 s5sCF40u1JhsG3c5drRfkJo0kkvr3FAXPV778tzoiOOmGTQu4gS7pDpBK3n0JuF34zbe
 w6/hP9UdMu4YqfzAvMYup0UcX56TpUHoOjg4GmOJxjTxrSqrMvlrZGgj83LGR7awNIij
 v4kg==
X-Gm-Message-State: AOJu0YyKntU9vGXPt25zdQ6T041Jer+jXHgd0wyz89kyXj9QW4j7gBii
 C9cS2ODpJCkpGzZjfsVRFAv9eeEaMM6Uyx3i3baBmSFxFvNNYzGl7GWQR8jiZoR+wCbAzaUgbli
 CGkzGrKftzhixBOOSRuLs451XjcKMRx8MYvhk
X-Gm-Gg: ASbGnct0PvCz49MsF6KmdQcTpy/h5ptTL8ywJfFBOyz1O8xERLnVLldlfqGPFOXE5hJ
 7BDtuX9PZS016VA5ddnTqAhFLQMzy9Hk=
X-Google-Smtp-Source: AGHT+IEyYJBPzGWA2XZ/fx6fkSXut/m7RDnvZ2cZkq5eqCO5LfCDZduMPXGz4obe1Ex7s83R10ivue/twBFykdJrEgQ=
X-Received: by 2002:a05:6a00:1d0c:b0:724:bf30:2d39 with SMTP id
 d2e1a72fcca58-724bf302dc4mr2733388b3a.7.1732110426903; Wed, 20 Nov 2024
 05:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
 <20241120100157.485418-4-andrew.goodbody@linaro.org>
In-Reply-To: <20241120100157.485418-4-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:46:49 -0700
Message-ID: <CAFLszTjAaUVccHaxj758jFqkjQzB_J_cBFi=Nx42ADWdp9EjJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] x86: select CONFIG_64BIT for X86_64
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 LekKit <50500857+LekKit@users.noreply.github.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Andrew,

On Wed, 20 Nov 2024 at 03:02, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> static analysis tools.
> Introduce CONFIG_SPL_64BIT and select it for architectures other than
> x86 with 64 bit builds. Do not select it for x86 builds as x86 uses
> a 32 bit SPL.
> Ensure that when limits are set they use CONFIG_64BIT for U-Boot
> proper and CONFIG_SPL_64BIT for SPL. This is to allow for the 32 bit
> SPL build used by x86.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v3:
> Introduce CONFIG_SPL_64BIT to allow for x86 building a 32 bit SPL and
> a 64 bit U-Boot proper.
>
> Changes in v2:
> Corrected commit title to be x86 not sandbox
>
>  arch/Kconfig         | 3 +++
>  arch/arm/Kconfig     | 1 +
>  arch/mips/Kconfig    | 4 ++++
>  arch/riscv/Kconfig   | 1 +
>  arch/sandbox/Kconfig | 1 +
>  arch/x86/Kconfig     | 1 +
>  common/bloblist.c    | 3 ++-
>  include/limits.h     | 3 ++-
>  8 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6258788f53..c726ac5fc7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -38,6 +38,9 @@ config 32BIT
>  config 64BIT
>         bool
>
> +config SPL_64BIT
> +       bool

Please document what this means and its implications, with some help

> +
>  config SYS_CACHELINE_SIZE
>         int
>         default 128 if SYS_CACHE_SHIFT_7
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7282c4123b..055762b0b9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config SYS_ARCH
>  config ARM64
>         bool
>         select 64BIT
> +       select SPL_64BIT if SPL
>         select PHYS_64BIT
>         select SYS_CACHE_SHIFT_6
>         imply SPL_SEPARATE_BSS
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 38577af43d..7ea439e857 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -211,6 +211,7 @@ config CPU_MIPS64_R1
>         bool "MIPS64 Release 1"
>         depends on SUPPORTS_CPU_MIPS64_R1
>         select 64BIT
> +       select SPL_64BIT if SPL
>         help
>           Choose this option to build a kernel for release 1 through 5 of the
>           MIPS64 architecture.
> @@ -219,6 +220,7 @@ config CPU_MIPS64_R2
>         bool "MIPS64 Release 2"
>         depends on SUPPORTS_CPU_MIPS64_R2
>         select 64BIT
> +       select SPL_64BIT if SPL
>         help
>           Choose this option to build a kernel for release 2 through 5 of the
>           MIPS64 architecture.
> @@ -227,6 +229,7 @@ config CPU_MIPS64_R6
>         bool "MIPS64 Release 6"
>         depends on SUPPORTS_CPU_MIPS64_R6
>         select 64BIT
> +       select SPL_64BIT if SPL
>         help
>           Choose this option to build a kernel for release 6 or later of the
>           MIPS64 architecture.
> @@ -235,6 +238,7 @@ config CPU_MIPS64_OCTEON
>         bool "Marvell Octeon series of CPUs"
>         depends on SUPPORTS_CPU_MIPS64_OCTEON
>         select 64BIT
> +       select SPL_64BIT if SPL
>         help
>          Choose this option for Marvell Octeon CPUs.  These CPUs are between
>          MIPS64 R5 and R6 with other extensions.
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 043d963f63..abb7a984c4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -120,6 +120,7 @@ config ARCH_RV32I
>  config ARCH_RV64I
>         bool "RV64I"
>         select 64BIT
> +       select SPL_64BIT if SPL
>         select PHYS_64BIT
>         help
>           Choose this option to target the RV64I base integer instruction set.
> diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
> index db29ca14bd..4c169034d9 100644
> --- a/arch/sandbox/Kconfig
> +++ b/arch/sandbox/Kconfig
> @@ -47,6 +47,7 @@ config HOST_32BIT
>  config HOST_64BIT
>         def_bool $(cc-define,_LP64)
>         select 64BIT
> +       select SPL_64BIT if SPL
>
>  config HOST_HAS_SDL
>         def_bool $(success,sdl2-config --version)
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 23a1e21b29..006a59d6fa 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -44,6 +44,7 @@ endchoice
>
>  config X86_64
>         bool
> +       select 64BIT
>
>  config SPL_X86_64
>         bool
> diff --git a/common/bloblist.c b/common/bloblist.c
> index ec6ff7a5a9..30fe1cb4b3 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -579,7 +579,8 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
>         ulong version = BLOBLIST_REGCONV_VER;
>         ulong sigval;
>
> -       sigval = (IS_ENABLED(CONFIG_64BIT)) ?
> +       sigval = ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
> +                       (IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) ?
>                         ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
>                          ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
>                         ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |

Gosh this is pretty ugly.

Can you split it into separate statements?

> diff --git a/include/limits.h b/include/limits.h
> index 4700cc7a59..1d0bbf69be 100644
> --- a/include/limits.h
> +++ b/include/limits.h
> @@ -9,7 +9,8 @@
>  #define UINT32_MAX  0xffffffffU
>  #define UINT64_MAX  0xffffffffffffffffULL
>
> -#ifdef CONFIG_64BIT
> +#if (defined(CONFIG_64BIT) && !defined(CONFIG_SPL_BUILD)) || \
> +       (defined(CONFIG_SPL_64BIT) && defined(CONFIG_SPL_BUILD))
>      #define UINTPTR_MAX UINT64_MAX
>  #else
>      #define UINTPTR_MAX UINT32_MAX
> --
> 2.39.5
>

REgards,
Simon
