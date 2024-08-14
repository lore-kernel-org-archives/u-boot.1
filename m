Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE22C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98C188967;
	Wed, 14 Aug 2024 14:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZxAqZ7U/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8664889BA; Wed, 14 Aug 2024 14:08:58 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEAC885FA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d18d4b94cso4926795b3a.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723637334; x=1724242134; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ElhhttgTnNFcyOtC/vTER6BuKFVwnqjYhbzwBJ0FMBQ=;
 b=ZxAqZ7U/d4rxpGSE4EErhfq6c3xJjcvMuZ21DKC0Gz/qeZT0mrNT5wl2JzM2kLJNyC
 gf/1xn1sYtW11j15+4wpzP7cHWbgOcyu5GR2o86TH0NNI8GOA+29kki4IkakTNT4V0vA
 Iw/OQAqcSw2OV+A7l9LOx4Fa2TfqDEvbyGW/Rc/Uv6A+bSWHqgShoTv2eWTtbHSgUial
 Xe2HnpgE+lBm1phgavItKDoSro9z90imbP/xDPgmZYOM7zrgz/Z8DpWDsmiS1r8JBgOy
 KHWCZYVfLtrCwXrF1aDSoUaLqv3mwNAn6CZ60rf8DnHmBtZHuTE0NEjl5GdinwUZhUG+
 kDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723637334; x=1724242134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElhhttgTnNFcyOtC/vTER6BuKFVwnqjYhbzwBJ0FMBQ=;
 b=G5feThpo1MtI2PEdud4VYB6C8j7OtTrHYVGJYsaz38qo8jXltzGYmk9fp2ycHmhSXL
 6/j/keq3o7htgIkptqarEBhsa8Y3N52D/ScK7m1qgduHXcX9gHiItAFJwjTT/bRdrI8o
 jUF+ks3JrneLXZQph47mR1Qu+vrakRaG3xI/p06ND7ENr++pj2K9P+oq2o281sl2XrMD
 s8eKRYgOdWHHAqWplZNMWiT3PSYK1OOjWjwL9pnflN2iVs+KCbnjBzHjzRq6Oyr9zuPq
 hWH0bzHLtTorXK2Jz7aVJQCrfMRYD35pws5eS3/+MwV4I4WN7hQpB+1b6zjvj53aeNKX
 OAoQ==
X-Gm-Message-State: AOJu0Yx6mG7AvU9d8sfuAz3sIZCjAii4u0//Pg+c2sc6AesFPBrJiEHT
 FHPS2zX00wDFAV7L0Vxyz7f+UaDgZVbv7BQV3z1ZDcJkUYkF5voAXcJjWj6zHKvVOjg/yhv2R74
 Q7ZE45UvEN4+Ic2kNMw1MabJR7chCdzre+ztqvA==
X-Google-Smtp-Source: AGHT+IFK+bHptMIbzEwzOqa7RIlXP7MPxvxHeEQ1uZKrT5DzH98umzcmfsdsLyF5AhDVx80OIS+JQUm480CeTcNgbVQ=
X-Received: by 2002:a05:6a21:398e:b0:1c6:faba:14a4 with SMTP id
 adf61e73a8af0-1c8eaf8064amr3349988637.41.1723637334165; Wed, 14 Aug 2024
 05:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240731172556.1348487-3-raymond.mao@linaro.org>
In-Reply-To: <20240731172556.1348487-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Aug 2024 15:08:18 +0300
Message-ID: <CAC_iWjKX-o0_WmaFuAsDQLOjDevuGKJc-PNSGxuqw0tk1dF=MQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/27] mbedtls: add mbedtls into the build system
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Raymond,

On Wed, 31 Jul 2024 at 20:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Port mbedtls with adapted libc header files.
> Add mbedtls default config header file.
> Optimize mbedtls default config by disabling unused features to
> reduce the target size.
> Add mbedtls kbuild makefile.
> Add Kconfig skeleton and config submenu entry for selecting
> crypto libraries between mbedtls and legacy ones.
> Add the mbedtls include directories into the build system.
>
> Subsequent patches will separate those Kconfigs into pairs of
> _LEGACY and _MBEDTLS for controlling the implementations of legacy
> crypto libraries and MbedTLS ones respectively.
>
> The motivation of moving and adapting *INT* macros from kernel.h
> to limits.h is to fullfill the MbedTLS building requirement.
> The conditional compilation statements in MbedTLS expects the
> *INT* macros as constant expressions, thus expressions like
> `((int)(~0U >> 1))` will not work.
>
> Prerequisite
> ------------
>
> This patch series requires mbedtls git repo to be added as a
> subtree to the main U-Boot repo via:
>
> $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>       https://github.com/Mbed-TLS/mbedtls.git \
>       v3.6.0 --squash
>
> Moreover, due to the Windows-style files from mbedtls git repo,
> we need to convert the CRLF endings to LF and do a commit manually:
>
> $ git add --renormalize .
> $ git commit
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Disabled unused MbedTLS features to optimize the target size.
> Changes in v3
> - Removed changes in stdio.h.
> Changes in v4
> - Move limits.h as a common header file that is included by kernel.h.
> - Refactor the Kconfig to support legacy and MbedTLS options for each
>   algorithm.
> - Refactor MbedTLS makefile and default config file to remove unused
>   config options and objects.
> Changes in v5
> - Merged patch #9 of v4 into this patch.
> - Removed unused config MBEDTLS_LIB_TLS.
> - Refactored MbedTLS Makefile and default config file.
>
>  Makefile                         |  6 +++
>  include/limits.h                 | 29 ++++++++++++++
>  include/linux/kernel.h           | 13 +-----
>  include/stdlib.h                 |  1 +
>  lib/Kconfig                      |  4 ++
>  lib/Makefile                     |  2 +
>  lib/mbedtls/Kconfig              | 47 ++++++++++++++++++++++
>  lib/mbedtls/Makefile             | 41 +++++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h | 69 ++++++++++++++++++++++++++++++++
>  lib/mbedtls/port/assert.h        | 12 ++++++
>  10 files changed, 212 insertions(+), 12 deletions(-)
>  create mode 100644 include/limits.h
>  create mode 100644 lib/mbedtls/Kconfig
>  create mode 100644 lib/mbedtls/Makefile
>  create mode 100644 lib/mbedtls/mbedtls_def_config.h
>  create mode 100644 lib/mbedtls/port/assert.h
>
> diff --git a/Makefile b/Makefile
> index 07d7947c8af..fd855dbd5c9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>  UBOOTINCLUDE    := \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(CONFIG_MBEDTLS_LIB), \
> +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
> +               -I$(srctree)/lib/mbedtls \
> +               -I$(srctree)/lib/mbedtls/port \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \
>         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>                 $(if $(CONFIG_HAS_THUMB2), \
>                         $(if $(CONFIG_CPU_V7M), \
> diff --git a/include/limits.h b/include/limits.h
> new file mode 100644
> index 00000000000..cc691d15650
> --- /dev/null
> +++ b/include/limits.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2023 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#ifndef _LIMITS_H
> +#define _LIMITS_H
> +
> +#define INT_MAX         0x7fffffff
> +#define UINT_MAX       0xffffffffUL
> +#define CHAR_BIT        8
> +#define UINT32_MAX      0xffffffffUL
> +#define UINT64_MAX     0xffffffffffffffffUL

Some of these seem wrong e.g UINT64_MAX should be ULL, etc
Can you keep the original definitions?

Also, there's no copyright on this file, values where moved from one
file to another, you should just preserve the original one.

Thanks
/Ilias
> +
> +#ifdef CONFIG_64BIT
> +    #define UINTPTR_MAX UINT64_MAX
> +#else
> +    #define UINTPTR_MAX UINT32_MAX
> +#endif
> +
> +#ifndef SIZE_MAX
> +#define SIZE_MAX        UINTPTR_MAX
> +#endif
> +#ifndef SSIZE_MAX
> +#define SSIZE_MAX      ((ssize_t)(SIZE_MAX >> 1))
> +#endif
> +
> +#endif /* _LIMITS_H */
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5cd6c9dc821..2cb2ceaf84b 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -3,25 +3,18 @@
>
>  #include <linux/types.h>
>  #include <linux/printk.h> /* for printf/pr_* utilities */
> +#include <limits.h>
>
>  #define USHRT_MAX      ((u16)(~0U))
>  #define SHRT_MAX       ((s16)(USHRT_MAX>>1))
>  #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
> -#define INT_MAX                ((int)(~0U>>1))
>  #define INT_MIN                (-INT_MAX - 1)
> -#define UINT_MAX       (~0U)
>  #define LONG_MAX       ((long)(~0UL>>1))
>  #define LONG_MIN       (-LONG_MAX - 1)
>  #define ULONG_MAX      (~0UL)
>  #define LLONG_MAX      ((long long)(~0ULL>>1))
>  #define LLONG_MIN      (-LLONG_MAX - 1)
>  #define ULLONG_MAX     (~0ULL)
> -#ifndef SIZE_MAX
> -#define SIZE_MAX       (~(size_t)0)
> -#endif
> -#ifndef SSIZE_MAX
> -#define SSIZE_MAX      ((ssize_t)(SIZE_MAX >> 1))
> -#endif
>
>  #define U8_MAX         ((u8)~0U)
>  #define S8_MAX         ((s8)(U8_MAX>>1))
> @@ -36,10 +29,6 @@
>  #define S64_MAX                ((s64)(U64_MAX>>1))
>  #define S64_MIN                ((s64)(-S64_MAX - 1))
>
> -/* Aliases defined by stdint.h */
> -#define UINT32_MAX     U32_MAX
> -#define UINT64_MAX     U64_MAX
> -
>  #define INT32_MAX      S32_MAX
>
>  #define STACK_MAGIC    0xdeadbeef
> diff --git a/include/stdlib.h b/include/stdlib.h
> index 9c175d4d74c..dedfd52a144 100644
> --- a/include/stdlib.h
> +++ b/include/stdlib.h
> @@ -7,5 +7,6 @@
>  #define __STDLIB_H_
>
>  #include <malloc.h>
> +#include <rand.h>
>
>  #endif /* __STDLIB_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b3baa4b85b0..129063ca8a5 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -418,6 +418,10 @@ config CIRCBUF
>
>  source "lib/dhry/Kconfig"
>
> +menu "Alternative crypto libraries"
> +source lib/mbedtls/Kconfig
> +endmenu
> +
>  menu "Security support"
>
>  config AES
> diff --git a/lib/Makefile b/lib/Makefile
> index e389ad014f8..499d174199f 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -96,6 +96,8 @@ obj-$(CONFIG_LIBAVB) += libavb/
>  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
>  obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
>
> +obj-$(CONFIG_MBEDTLS_LIB) += mbedtls/
> +
>  ifdef CONFIG_SPL_BUILD
>  obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
>  obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> new file mode 100644
> index 00000000000..3e9057f1acf
> --- /dev/null
> +++ b/lib/mbedtls/Kconfig
> @@ -0,0 +1,47 @@
> +choice
> +       prompt "Select crypto libraries"
> +       default LEGACY_CRYPTO
> +       help
> +         Select crypto libraries.
> +         LEGACY_CRYPTO for legacy crypto libraries,
> +         MBEDTLS_LIB for MbedTLS libraries.
> +
> +config LEGACY_CRYPTO
> +       bool "legacy crypto libraries"
> +       select LEGACY_CRYPTO_BASIC
> +       select LEGACY_CRYPTO_CERT
> +
> +config MBEDTLS_LIB
> +       bool "MbedTLS libraries"
> +       select MBEDTLS_LIB_CRYPTO
> +       select MBEDTLS_LIB_X509
> +endchoice
> +
> +if LEGACY_CRYPTO
> +
> +config LEGACY_CRYPTO_BASIC
> +       bool "legacy basic crypto libraries"
> +       help
> +         Enable legacy basic crypto libraries.
> +
> +config LEGACY_CRYPTO_CERT
> +       bool "legacy certificate libraries"
> +       help
> +         Enable legacy certificate libraries.
> +
> +endif # LEGACY_CRYPTO
> +
> +if MBEDTLS_LIB
> +
> +config MBEDTLS_LIB_CRYPTO
> +       bool "MbedTLS crypto libraries"
> +       help
> +         Enable MbedTLS crypto libraries.
> +
> +
> +config MBEDTLS_LIB_X509
> +       bool "MbedTLS certificate libraries"
> +       help
> +         Enable MbedTLS certificate libraries.
> +
> +endif # MBEDTLS_LIB
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> new file mode 100644
> index 00000000000..e98241b46ab
> --- /dev/null
> +++ b/lib/mbedtls/Makefile
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +
> +MBEDTLS_LIB_DIR = external/mbedtls/library
> +
> +# MbedTLS crypto library
> +obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> +mbedtls_lib_crypto-y := \
> +       $(MBEDTLS_LIB_DIR)/platform_util.o \
> +       $(MBEDTLS_LIB_DIR)/constant_time.o \
> +       $(MBEDTLS_LIB_DIR)/md.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
> +       $(MBEDTLS_LIB_DIR)/sha256.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
> +       $(MBEDTLS_LIB_DIR)/sha512.o
> +
> +# MbedTLS X509 library
> +obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
> +mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
> +       $(MBEDTLS_LIB_DIR)/asn1parse.o \
> +       $(MBEDTLS_LIB_DIR)/asn1write.o \
> +       $(MBEDTLS_LIB_DIR)/oid.o
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
> +       $(MBEDTLS_LIB_DIR)/bignum.o \
> +       $(MBEDTLS_LIB_DIR)/bignum_core.o \
> +       $(MBEDTLS_LIB_DIR)/rsa.o \
> +       $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> +       $(MBEDTLS_LIB_DIR)/pk.o \
> +       $(MBEDTLS_LIB_DIR)/pk_wrap.o \
> +       $(MBEDTLS_LIB_DIR)/pkparse.o
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += \
> +       $(MBEDTLS_LIB_DIR)/x509_crl.o \
> +       $(MBEDTLS_LIB_DIR)/x509_crt.o
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += \
> +       $(MBEDTLS_LIB_DIR)/pkcs7.o
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> new file mode 100644
> index 00000000000..38de6b0b9af
> --- /dev/null
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * MbedTLS config file
> + *
> + * Derived from the MbedTLS internal config file,
> + * for more information about each build option,
> + * please refer to:
> + * external/mbedtls/include/mbedtls/mbedtls_config.h
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> +
> +#define MBEDTLS_MD_C
> +
> +#if CONFIG_IS_ENABLED(MD5)
> +#define MBEDTLS_MD5_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA1)
> +#define MBEDTLS_SHA1_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA256)
> +#define MBEDTLS_SHA256_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA384)
> +#define MBEDTLS_SHA384_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA512)
> +#define MBEDTLS_SHA512_C
> +#endif
> +
> +#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
> +
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +
> +#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
> +#define MBEDTLS_PKCS1_V15
> +#define MBEDTLS_X509_USE_C
> +#define MBEDTLS_X509_CRT_PARSE_C
> +#define MBEDTLS_X509_CRL_PARSE_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
> +#define MBEDTLS_PK_C
> +#define MBEDTLS_PK_PARSE_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_RSA_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(PKCS7_MESSAGE_PARSER)
> +#define MBEDTLS_PKCS7_C
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ASN1_DECODER)
> +#define MBEDTLS_OID_C
> +#define MBEDTLS_ASN1_PARSE_C
> +#define MBEDTLS_ASN1_WRITE_C
> +#endif
> +
> +#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
> diff --git a/lib/mbedtls/port/assert.h b/lib/mbedtls/port/assert.h
> new file mode 100644
> index 00000000000..490701aa9d0
> --- /dev/null
> +++ b/lib/mbedtls/port/assert.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Dummy file to allow mbedtls linked with U-Boot to include assert.h
> + *
> + * Copyright (c) 2023 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#ifndef _MBEDTLS_ASSERT_H
> +#define _MBEDTLS_ASSERT_H
> +
> +#endif /* _MBEDTLS_ASSERT_H */
> --
> 2.25.1
>
