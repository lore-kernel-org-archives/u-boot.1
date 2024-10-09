Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5393ECEDD90
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E1E89217;
	Wed,  9 Oct 2024 15:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mAx3EvVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D2C8891AB; Wed,  9 Oct 2024 12:14:27 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE41389186
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo521378a12.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728468862; x=1729073662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YQ5KdScpY3uy79RloXipjELtAXdtVR3Ww+vaS3PNFRo=;
 b=mAx3EvVN8J6+R3IMLyA9Z99xf5yn1HvlWUcJQZnaHORmhDIauGyf0TLvKO4yR/RT5C
 c6Z/sTIgvv7xQJQsBFZq37FZPMxZTzDEs+nQmGv5yPZN1xQ2r6JPDC6DvpgDIQhwiuii
 46ORQlvT4rcBjY2BRtX4XUHXTG6y0tgtRLBZ8U5JUrgvxTc572aZRF2h+sYjFEwmi9S0
 alKtU+erkkWzG4nQcuSgvkMuvgINPSsLQXbVp9CKIkvfhvOI9Zasq4VT2SVdQPUOs/Ne
 RnMLmeRgJc+vASj4wo00oOs7NaNPtOdYcijh0jfT9jNXrv+HsvjfR7J61UOVdsdYOIO8
 D8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728468862; x=1729073662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQ5KdScpY3uy79RloXipjELtAXdtVR3Ww+vaS3PNFRo=;
 b=q3EbPogftBGKG++2WxhUXTp2OkdM1hJZ1aOoTaMT2ysNhoHTmvOt/ZH5lQ2Ct9mQLn
 4XoPb81twkKdbnGhq7BAID+8Sn4JMDo/qtP98qrpC06ys7y0B5DkaFhkj9mZikTaNe80
 yHxK6BJRCeMOjN7Oe+LpWkuPGGh98165RUAyetJjvV4pr4TnNmGMWT8EI2D2oSlr/Yd/
 zxynoGx1L5z9pTrot+ptwwGI5WbnistvmbVHcfSQq3+8FnsS0xaXB/vNHa9ZEBuH5nYC
 tvGYevceKWFYkCWzUfu0Gp+vAcPpYFQ51eyxXLSvoUI/PK1WghQck6apznaGHvy/bGcD
 9a4w==
X-Gm-Message-State: AOJu0YxHwVtfyYRt+vqGjzdsi5ANBUMz789FLPgDGCBxcS9GJjiqVIh1
 g2Rztto8dqx3yEGua6dVk4TDl9dGzLB/DAJ+FcgJnqX7T/BrkzopkC+uVfx1I5pahtmm64LYbWA
 Qzmt6Xyk2qxlGUf7A0TzNOQhMuwOIn4KHS9TaXg==
X-Google-Smtp-Source: AGHT+IG8Nm7OOeTRi6zmxkPU9Xqgh2UNh5Lr7DJpC2X7Nhd+LCSMKSZuYicqKhgAOZNoowcLLg0VR41262xgEY41Vb8=
X-Received: by 2002:a17:903:189:b0:205:5d71:561e with SMTP id
 d9443c01a7336-20c6353e2a9mr37210285ad.26.1728468862130; Wed, 09 Oct 2024
 03:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-3-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 13:13:46 +0300
Message-ID: <CAC_iWjLsUyTuuxNgfekPZ0xB0C_fw+zM8P74TPb=m6vSuJe7vw@mail.gmail.com>
Subject: Re: [PATCH v8 02/27] mbedtls: add mbedtls into the build system
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Greg Malysa <greg.malysa@timesys.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

Hi Raymond

On Fri, 4 Oct 2024 at 00:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Port mbedtls with adapted libc header files.
> Add mbedtls default config header file.
> Optimize mbedtls default config by disabling unused features to
> reduce the target size.
> Add mbedtls kbuild makefile.
> Add Kconfig skeleton and config submenu entry for selecting
> crypto libraries between mbedtls and legacy ones.
> Add the mbedtls include directories into the build system.
> Port u-boot hash functions as MbedTLS crypto alternatives and set
> it as default.
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
> Changes in v6
> - Fixed UINT64_MAX.
> - Removed copy right statement from limits.h
> Changes in v7
> - Fixed CI world build failures due to config dependencies.
> - Fixed values of UINT_MAX and UINT32_MAX.
> Changes in v8
> - Port u-boot hash functions as MbedTLS crypto alternatives and set
>   it as default.
>
>  Makefile                         |  6 +++
>  include/limits.h                 | 25 ++++++++++
>  include/linux/kernel.h           | 13 +----
>  include/stdlib.h                 |  1 +
>  lib/Kconfig                      |  4 ++
>  lib/Makefile                     |  2 +
>  lib/mbedtls/Kconfig              | 56 +++++++++++++++++++++
>  lib/mbedtls/Makefile             | 41 ++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h | 84 ++++++++++++++++++++++++++++++++
>  lib/mbedtls/port/assert.h        | 12 +++++
>  lib/mbedtls/port/md5_alt.h       | 57 ++++++++++++++++++++++
>  lib/mbedtls/port/sha1_alt.h      | 57 ++++++++++++++++++++++
>  lib/mbedtls/port/sha256_alt.h    | 64 ++++++++++++++++++++++++
>  lib/mbedtls/port/sha512_alt.h    | 78 +++++++++++++++++++++++++++++
>  14 files changed, 488 insertions(+), 12 deletions(-)
>  create mode 100644 include/limits.h
>  create mode 100644 lib/mbedtls/Kconfig
>  create mode 100644 lib/mbedtls/Makefile
>  create mode 100644 lib/mbedtls/mbedtls_def_config.h
>  create mode 100644 lib/mbedtls/port/assert.h
>  create mode 100644 lib/mbedtls/port/md5_alt.h
>  create mode 100644 lib/mbedtls/port/sha1_alt.h
>  create mode 100644 lib/mbedtls/port/sha256_alt.h
>  create mode 100644 lib/mbedtls/port/sha512_alt.h
>
> diff --git a/Makefile b/Makefile
> index 525576f987d..f4659f9493a 100644
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
> index 00000000000..4700cc7a59f
> --- /dev/null
> +++ b/include/limits.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _LIMITS_H
> +#define _LIMITS_H
> +
> +#define INT_MAX     0x7fffffff
> +#define UINT_MAX    0xffffffffU
> +#define CHAR_BIT    8
> +#define UINT32_MAX  0xffffffffU
> +#define UINT64_MAX  0xffffffffffffffffULL
> +
> +#ifdef CONFIG_64BIT
> +    #define UINTPTR_MAX UINT64_MAX
> +#else
> +    #define UINTPTR_MAX UINT32_MAX
> +#endif
> +
> +#ifndef SIZE_MAX
> +#define SIZE_MAX    UINTPTR_MAX
> +#endif
> +#ifndef SSIZE_MAX
> +#define SSIZE_MAX   ((ssize_t)(SIZE_MAX >> 1))
> +#endif
> +
> +#endif /* _LIMITS_H */
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 939465f372b..9467edd65ab 100644
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
> index 1dd4f271595..67a60160dac 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -419,6 +419,10 @@ config CIRCBUF
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
> index d300249f57c..c4950b78a29 100644
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
> index 00000000000..9d1a63c1ca6
> --- /dev/null
> +++ b/lib/mbedtls/Kconfig
> @@ -0,0 +1,56 @@
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


This overall llooks ok, but the native mbedTLS hashing should depend
on !CONFIG_SHA_HW_ACCEL.
If everyone thinks the series is good enough to merge, I don't mind
this going on a followup commit


> +config MBEDTLS_LIB
> +       bool "MbedTLS libraries"
> +       select MBEDTLS_LIB_X509
> +endchoice
> +
> +if LEGACY_CRYPTO || MBEDTLS_LIB_CRYPTO_ALT
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
> +config MBEDTLS_LIB_CRYPTO_ALT
> +       bool "MbedTLS crypto alternatives"
> +       depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> +       select LEGACY_CRYPTO_BASIC
> +       default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
> +       help
> +         Enable MbedTLS crypto alternatives.
> +         Mutually incompatible with MBEDTLS_LIB_CRYPTO.
> +
> +config MBEDTLS_LIB_CRYPTO
> +       bool "MbedTLS crypto libraries"
> +       help
> +         Enable MbedTLS crypto libraries.
> +         Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
> +
> +
> +config MBEDTLS_LIB_X509
> +       bool "MbedTLS certificate libraries"

> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#if defined CONFIG_MBEDTLS_LIB
> +
> +#if CONFIG_IS_ENABLED(MD5)
> +#define MBEDTLS_MD_C
> +#define MBEDTLS_MD5_C
> +#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#define MBEDTLS_MD5_ALT
> +#endif
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA1)
> +#define MBEDTLS_MD_C
> +#define MBEDTLS_SHA1_C
> +#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#define MBEDTLS_SHA1_ALT
> +#endif
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA256)
> +#define MBEDTLS_MD_C
> +#define MBEDTLS_SHA256_C
> +#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#define MBEDTLS_SHA256_ALT
> +#endif
> +#endif
> +
> +#if CONFIG_IS_ENABLED(SHA384)
> +#define MBEDTLS_MD_C
> +#define MBEDTLS_SHA384_C
> +#endif
> +

[...]

Thanks
/Ilias
