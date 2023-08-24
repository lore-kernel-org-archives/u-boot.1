Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CCDC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A08865FB;
	Thu, 24 Aug 2023 20:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R9nd2+mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A164865FB; Thu, 24 Aug 2023 20:15:21 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21988641D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so113852e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692900918; x=1693505718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwT/bmITR9sfMusGEUwBSaJhDiYsEhgkymIUelYN05w=;
 b=R9nd2+mDK8OXAbVg39h7JQ9qBkojINiZjHiFjMrsHEwdmPOJR3VV0J4TwCFo47/bj3
 VSp+UDqPxSQXDmz3ix1Mb8KnjqgK2AwpI1lJpMg+Exs2wBJ6G11tard9dnjRr/+0eTY8
 dqYifSvqVZ20eJCyKF79ieQXC/xyPODtJpT0vXF71Do6CxvKMh1SOXXJkbVJ+9c/I06q
 TqZtXwB0SGEO3l1lHJpNRmbbEaIpn7CDv569GeWdEV5MY7RyHaz1iVSOwYvjuyfnDwji
 9rsXXfyUFC+La34v1jQN2DOP7Ll5ocZDrNbakyhLIJ0fuBPe/bcvJ+mhQ9NNzo4+rYhn
 5iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692900918; x=1693505718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwT/bmITR9sfMusGEUwBSaJhDiYsEhgkymIUelYN05w=;
 b=Rv4y/6/+ZsC2Wvh6YxrXljmMpgZIe/p3GssPrYJGzVBA413Em3/Z1IH2NQ4TfiBIha
 fhkcvM/gI1CqAAbHTZ302NQt342vakqQV3o5OX6fubTjLvk15B2fqVLLZq6ffPWvoaeM
 XHG6nTCib1FOBYiQxnKMjTvVZoTQ8+fopM1Wv5DZ7WviX3TD7GBbHtfuyPNxs6x3V4+O
 9t7PK3nCOeiVOHUTWHLEmvsCfKiyC3hCW79AuujMjh0Xu504+uZs2dS0T2cGZeyar+Pc
 6NoBZ6XMjztcmlyKLgNl1BXfBZF9qdllbW8Vxagw78PkCUz8RBIkU0S6XlDA9/Brx+Hi
 kNlg==
X-Gm-Message-State: AOJu0YxKJmwC8O8eAgrTRErytt85vmsE/jxAd0e9kixrZpAj7DzzcgZN
 Qyhj1nVPzoUg6tVQC5xg1rhoA2NbaNE0xEJjEdU=
X-Google-Smtp-Source: AGHT+IGFYkxnoXKqi8yAswFznW3wtt4hupmXVASLbCZcvbarPJsazBSItA728zJBU2KPTjZ0biUfNbadE50tXCiHDL0=
X-Received: by 2002:a05:6512:2007:b0:500:75f1:c22e with SMTP id
 a7-20020a056512200700b0050075f1c22emr9107805lfb.40.1692900917722; Thu, 24 Aug
 2023 11:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230731212734.7256-1-sean.anderson@seco.com>
In-Reply-To: <20230731212734.7256-1-sean.anderson@seco.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 24 Aug 2023 11:15:05 -0700
Message-ID: <CAJaLiFwb0Zbo8VrE3eByFrHwCEHZNQUJ0AMLOuSWCJ=iJYfcwQ@mail.gmail.com>
Subject: Re: [PATCH] arm: Use builtins for ffs/fls
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sean,

On Mon, Jul 31, 2023 at 2:28=E2=80=AFPM Sean Anderson <sean.anderson@seco.c=
om> wrote:
>
> Since ARMv5, the clz instruction allows for efficient implementation of
> ffs/fls with builtins. Until ARMv7 (with Thumb-2), this instruction is
> only available in ARM mode. LTO makes it difficult to force specific
> functions to be in ARM mode, as it is effectively a form of very
> aggressive inlining. To work around this, fls/ffs are implemented in
> assembly for ARMv5 and ARMv6 when compiling U-Boot in Thumb mode.
> Overall, this saves around 75 bytes per call.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> I only tested this on ARMv8. If someone has an ARMv5 or ARMv6 board,
> please test this.

Thanks for the patch! I've tested it with the Pogo V4 board (Kirkwood
88F6192, ARMv5) with LTO and SYS_THUMB_BUILD.

Also nice size reduction:
Before: 502K
After: 499K

So for ARMv5,
Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

>
>  arch/arm/include/asm/bitops.h              | 27 ++++++++++++-
>  arch/arm/lib/Makefile                      |  5 +++
>  arch/arm/lib/bitops.S                      | 45 ++++++++++++++++++++++
>  include/asm-generic/bitops/builtin-__ffs.h | 16 ++++++++
>  include/asm-generic/bitops/builtin-__fls.h | 16 ++++++++
>  include/asm-generic/bitops/builtin-ffs.h   | 15 ++++++++
>  include/asm-generic/bitops/builtin-fls.h   | 17 ++++++++
>  7 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/lib/bitops.S
>  create mode 100644 include/asm-generic/bitops/builtin-__ffs.h
>  create mode 100644 include/asm-generic/bitops/builtin-__fls.h
>  create mode 100644 include/asm-generic/bitops/builtin-ffs.h
>  create mode 100644 include/asm-generic/bitops/builtin-fls.h
>
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.=
h
> index fa8548624a..8e897833bb 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -15,9 +15,34 @@
>  #ifndef __ASM_ARM_BITOPS_H
>  #define __ASM_ARM_BITOPS_H
>
> +#if __LINUX_ARM_ARCH__ < 5
> +
>  #include <asm-generic/bitops/__ffs.h>
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/fls.h>
> +
> +#else
> +
> +#define PLATFORM_FFS
> +#define PLATFORM_FLS
> +
> +#if !IS_ENABLED(CONFIG_HAS_THUMB2) && CONFIG_IS_ENABLED(SYS_THUMB_BUILD)
> +
> +unsigned long __fls(unsigned long word);
> +unsigned long __ffs(unsigned long word);
> +int fls(unsigned int x);
> +int ffs(int x);
> +
> +#else
> +
> +#include <asm-generic/bitops/builtin-__fls.h>
> +#include <asm-generic/bitops/builtin-__ffs.h>
> +#include <asm-generic/bitops/builtin-fls.h>
> +#include <asm-generic/bitops/builtin-ffs.h>
> +
> +#endif
> +#endif
> +
>  #include <asm-generic/bitops/fls64.h>
>
>  #ifdef __KERNEL__
> @@ -113,7 +138,7 @@ static inline int test_bit(int nr, const void * addr)
>
>  static inline int __ilog2(unsigned int x)
>  {
> -       return generic_fls(x) - 1;
> +       return fls(x) - 1;
>  }
>
>  #define ffz(x)  __ffs(~(x))
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 62cf80f373..b1bcd37466 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -113,6 +113,11 @@ AFLAGS_REMOVE_memset.o :=3D -mthumb -mthumb-interwor=
k
>  AFLAGS_REMOVE_memcpy.o :=3D -mthumb -mthumb-interwork
>  AFLAGS_memset.o :=3D -DMEMSET_NO_THUMB_BUILD
>  AFLAGS_memcpy.o :=3D -DMEMCPY_NO_THUMB_BUILD
> +
> +# This is only necessary to force ARM mode on THUMB1 targets.
> +ifneq ($(CONFIG_SYS_ARM_ARCH),4)
> +obj-y   +=3D bitops.o
> +endif
>  endif
>  endif
>
> diff --git a/arch/arm/lib/bitops.S b/arch/arm/lib/bitops.S
> new file mode 100644
> index 0000000000..29d1524634
> --- /dev/null
> +++ b/arch/arm/lib/bitops.S
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Sean Anderson <sean.anderson@seco.com>
> + *
> + * ARM bitops to call when using THUMB1, which doesn't have these instru=
ctions.
> + */
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +.pushsection .text.__fls
> +ENTRY(__fls)
> +       clz     r0, r0
> +       rsb     r0, r0, #31
> +       ret     lr
> +ENDPROC(__fls)
> +.popsection
> +
> +.pushsection .text.__ffs
> +ENTRY(__ffs)
> +       rsb     r3, r0, #0
> +       and     r0, r0, r3
> +       clz     r0, r0
> +       rsb     r0, r0, #31
> +       ret     lr
> +ENDPROC(__ffs)
> +.popsection
> +
> +.pushsection .text.fls
> +ENTRY(fls)
> +       cmp     r0, #0
> +       clzne   r0, r0
> +       rsbne   r0, r0, #32
> +       ret     lr
> +ENDPROC(fls)
> +.popsection
> +
> +.pushsection .text.ffs
> +ENTRY(ffs)
> +       rsb     r3, r0, #0
> +       and     r0, r0, r3
> +       clz     r0, r0
> +       rsb     r0, r0, #32
> +       ret     lr
> +ENDPROC(ffs)
> +.popsection
> diff --git a/include/asm-generic/bitops/builtin-__ffs.h b/include/asm-gen=
eric/bitops/builtin-__ffs.h
> new file mode 100644
> index 0000000000..87024da44d
> --- /dev/null
> +++ b/include/asm-generic/bitops/builtin-__ffs.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS_BUILTIN___FFS_H_
> +#define _ASM_GENERIC_BITOPS_BUILTIN___FFS_H_
> +
> +/**
> + * __ffs - find first bit in word.
> + * @word: The word to search
> + *
> + * Undefined if no bit exists, so code should check against 0 first.
> + */
> +static __always_inline unsigned long __ffs(unsigned long word)
> +{
> +       return __builtin_ctzl(word);
> +}
> +
> +#endif
> diff --git a/include/asm-generic/bitops/builtin-__fls.h b/include/asm-gen=
eric/bitops/builtin-__fls.h
> new file mode 100644
> index 0000000000..43a5aa9afb
> --- /dev/null
> +++ b/include/asm-generic/bitops/builtin-__fls.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS_BUILTIN___FLS_H_
> +#define _ASM_GENERIC_BITOPS_BUILTIN___FLS_H_
> +
> +/**
> + * __fls - find last (most-significant) set bit in a long word
> + * @word: the word to search
> + *
> + * Undefined if no set bit exists, so code should check against 0 first.
> + */
> +static __always_inline unsigned long __fls(unsigned long word)
> +{
> +       return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
> +}
> +
> +#endif
> diff --git a/include/asm-generic/bitops/builtin-ffs.h b/include/asm-gener=
ic/bitops/builtin-ffs.h
> new file mode 100644
> index 0000000000..7b12932904
> --- /dev/null
> +++ b/include/asm-generic/bitops/builtin-ffs.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS_BUILTIN_FFS_H_
> +#define _ASM_GENERIC_BITOPS_BUILTIN_FFS_H_
> +
> +/**
> + * ffs - find first bit set
> + * @x: the word to search
> + *
> + * This is defined the same way as
> + * the libc and compiler builtin ffs routines, therefore
> + * differs in spirit from ffz (man ffs).
> + */
> +#define ffs(x) __builtin_ffs(x)
> +
> +#endif
> diff --git a/include/asm-generic/bitops/builtin-fls.h b/include/asm-gener=
ic/bitops/builtin-fls.h
> new file mode 100644
> index 0000000000..c8455cc288
> --- /dev/null
> +++ b/include/asm-generic/bitops/builtin-fls.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS_BUILTIN_FLS_H_
> +#define _ASM_GENERIC_BITOPS_BUILTIN_FLS_H_
> +
> +/**
> + * fls - find last (most-significant) bit set
> + * @x: the word to search
> + *
> + * This is defined the same way as ffs.
> + * Note fls(0) =3D 0, fls(1) =3D 1, fls(0x80000000) =3D 32.
> + */
> +static __always_inline int fls(unsigned int x)
> +{
> +       return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
> +}
> +
> +#endif
> --
> 2.40.1
>
