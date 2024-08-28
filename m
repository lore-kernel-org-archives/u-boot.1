Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87218C54748
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 08:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81CC889B3;
	Wed, 28 Aug 2024 10:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QOXd/BPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873B7889B3; Wed, 28 Aug 2024 10:31:31 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED00885D1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20223b5c1c0so58997405ad.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724833887; x=1725438687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fNomUhLD6gsSDuCI6CkPKUQ9y1qvrrN9JzG7QZvWL30=;
 b=QOXd/BPAWGNOYVkRMXXeevtRz7GvQf1DX32XROea5USkwSYSFLSUU2nUmADGqjPYkE
 lOCOaN4hiyFOrwVaJ1+rlVKx2N6NyexiDfLuK5UdTaEPPVrsvwgvsk62nHOoAgJgTCoo
 v09CpOlC8Ks+Cwvqit+4nV/WOFEzRpvA+ReAWK4DIcl/y+5nPUq4SRI82Tlvt1lAYIPP
 nAz3LC9NUeXQo3jhp7x7zxX2/TEzEobk3sxSZlMCrny7ULCL6f0c3ntivS4LfOttqUtH
 sgDVEy+ofCjlx2BhUGhhodhgP0DbIwVhlbct+aH3UThMe7r4FYdh/R83PAsvgsoGc3Vr
 +veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724833887; x=1725438687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fNomUhLD6gsSDuCI6CkPKUQ9y1qvrrN9JzG7QZvWL30=;
 b=wZyf9bdS6OlvhyccPBUP6R17XPtjr+PL2U1+8JeXWhs5DUePyKiNxH1xdQQ3bJoBt9
 0qwdglNPfTr9bTKKuJb6uXjNVI8Bog8vAND8LqAzfh526SDLalZjc2xrejoQhKFVGvbv
 ZO8wM5y12WA1t+ewpREaLI4kutPpB8azgYlew/RHhSMUG2a4CGxmD7q9jbGgij/9magv
 tza1YQmjl3QCRuQTYqdy2r7OBE056BXuatdHlg/3PGYYxX46Jv0OGLmgjRk1f08QNS4x
 TBamX2VMHuw8WWgrMq4m52QY/S3+BMSarYO8gTMFLtfMP951CL3RFdTvy01fkbPVfyOh
 w39w==
X-Gm-Message-State: AOJu0Yy7TCOd68bEjiwdEQiBVMOl5POKERmmix43G79mTsfuUaK8CRNK
 DQGEPQavarRH46ovHlwH0XW+Ok5WPkbmjc1PQLDGjNhsGRAc5V/ErPximLaLkcrlAgw64E3gyOy
 o4n57YledjF39GvGZ91wEMqZ0UdzDbe3+tfyJag==
X-Google-Smtp-Source: AGHT+IF6ais2+Iq79aYJikBsnFvMlDuWGqTqTsov2FH4DRWw5Dpdn2que1Tv6zxjcUjiOUUonyW4vqixNtxNj7VBZ+U=
X-Received: by 2002:a17:90b:17c7:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d8440ebadamr1357233a91.25.1724833887003; Wed, 28 Aug 2024
 01:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-3-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 11:30:48 +0300
Message-ID: <CAC_iWjLkze_Qui5i9dbBQRfxnvcjPFCmCB4eEQv8sXZNd_TKNw@mail.gmail.com>
Subject: Re: [PATCH v6 02/28] mbedtls: add mbedtls into the build system
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
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

Hi Raymond

On Sat, 17 Aug 2024 at 00:45, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> Changes in v6
> - Fixed UINT64_MAX.
> - Removed copy right statement from limits.h
>
>  Makefile                         |  6 +++
>  include/limits.h                 | 25 ++++++++++++
>  include/linux/kernel.h           | 13 +-----
>  include/stdlib.h                 |  1 +
>  lib/Kconfig                      |  4 ++
>  lib/Makefile                     |  2 +
>  lib/mbedtls/Kconfig              | 47 ++++++++++++++++++++++
>  lib/mbedtls/Makefile             | 41 +++++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h | 69 ++++++++++++++++++++++++++++++++
>  lib/mbedtls/port/assert.h        | 12 ++++++
>  10 files changed, 208 insertions(+), 12 deletions(-)
>  create mode 100644 include/limits.h
>  create mode 100644 lib/mbedtls/Kconfig
>  create mode 100644 lib/mbedtls/Makefile
>  create mode 100644 lib/mbedtls/mbedtls_def_config.h
>  create mode 100644 lib/mbedtls/port/assert.h
>
> diff --git a/Makefile b/Makefile
> index b35a472d9be..3c506c299a1 100644
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
> index 00000000000..be219ddbfca
> --- /dev/null
> +++ b/include/limits.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _LIMITS_H
> +#define _LIMITS_H
> +
> +#define INT_MAX     0x7fffffff
> +#define UINT_MAX    0xffffffffUL

this is 0xffffffffU

> +#define CHAR_BIT    8
> +#define UINT32_MAX  0xffffffffUL

Ditto

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
> index 2059219a120..8b170dcc67e 100644
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

[....]

with the above  fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
