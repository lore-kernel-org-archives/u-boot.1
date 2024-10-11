Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCA0D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9C2893E1;
	Fri, 11 Oct 2024 23:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vK0oFhnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5DB893D5; Fri, 11 Oct 2024 21:00:38 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3577C893A8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 21:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71def8abc2fso1849803b3a.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728673234; x=1729278034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16bVh/qoJPdovboHQTNUS1+70Iy9nN1Uzs+usPknhmk=;
 b=vK0oFhncDvZwu+qPl4Fm/rF1tzQ7sKIhYJfT1456aKr93SbtYbD767+DebUNPBpU5m
 te/6cMv0iCJKYz1hR+qAxzBumik7RNfBuxuMHG3M1O0ftSDAR/e7l5fqIRswZ1+e/ltS
 Uy7+apmgo82qguQ2dEQiIMFetQliH5Qcg7ySdLGjqzW/Xi6Ebg3bclMbwMsf2gyL+dUb
 8bVTXKP9ZRpoFifxsarrBOSQlrLurXL6UHlNs7P1l/lKf2240yCkXgF13I3nqnSpspYx
 NpjInSN1JWOziKau/KBoTmoF3yC1HIPQ26VZEcfBYO+/yd86xscRPf00HgTqiKRo0h4p
 Jouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728673234; x=1729278034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16bVh/qoJPdovboHQTNUS1+70Iy9nN1Uzs+usPknhmk=;
 b=KVt8hEwbItbD/7d2nDh6Tvh8nYegYgXYm5QzkYBa8i1BD0wKXHcrzRAONRphfQR4+5
 75B1P91kX1L6zSjbSVOU4Z22M+0VQMQRrJTeIob41Gc40cTPcVOYzwqNzt5jOtTDucKX
 rm4pdHRfvszX7835fxVAHkVt4Jf+zEP4PBNd7KjFEZ+c7TJ2XD1GOV0G6wvdwvtNeTWt
 4Rih/E5jeyuW7J+O/4yeDqYkW+WfpsoQ/SAujbGnf54sVwd3/HNSUlTC3aa470Pu92JA
 3ju/XvgxGi/5z7IiZhJP3i50rHFe/JhVxEBkIGNggunf4R87cQCiUfDqP7RtylY9nEEe
 nWrw==
X-Gm-Message-State: AOJu0Yx+XaUoISTJVP4oeaCAWHU/QkhCb1adbykm3p8sFC3x4dq2WmaQ
 G1wCGYnDlWi0AiPsIEm4OBJwLnKDtaath0hCxaFH35E0/sbKw5YbAH5o94/1Qg7sIhXeVDt2jZr
 YHL/7K8/XgNVl+OHlzA3yk8uyUA641bj+OnZpjQ==
X-Google-Smtp-Source: AGHT+IHaaKzO0FNONnwNsuxnP7rbQLDo4AijD/ALLZ/yTXc0ccEQOcpnq1a/dh3365YJzWpRx9HduBIv7ZDF6QodS2U=
X-Received: by 2002:a05:6a21:2d84:b0:1d4:e4a9:c126 with SMTP id
 adf61e73a8af0-1d8bcfb26d6mr5149868637.32.1728673233443; Fri, 11 Oct 2024
 12:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-3-raymond.mao@linaro.org>
 <CAC_iWjLsUyTuuxNgfekPZ0xB0C_fw+zM8P74TPb=m6vSuJe7vw@mail.gmail.com>
In-Reply-To: <CAC_iWjLsUyTuuxNgfekPZ0xB0C_fw+zM8P74TPb=m6vSuJe7vw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 11 Oct 2024 15:00:21 -0400
Message-ID: <CAEfUkUJzAKcUt6HstDPQGA-8rw0mRAzJxw0Jpuj6KtE+4Ue1Rg@mail.gmail.com>
Subject: Re: [PATCH v8 02/27] mbedtls: add mbedtls into the build system
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Mailman-Approved-At: Fri, 11 Oct 2024 23:11:27 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, 9 Oct 2024 at 06:14, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Fri, 4 Oct 2024 at 00:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Port mbedtls with adapted libc header files.
> > Add mbedtls default config header file.
> > Optimize mbedtls default config by disabling unused features to
> > reduce the target size.
> > Add mbedtls kbuild makefile.
> > Add Kconfig skeleton and config submenu entry for selecting
> > crypto libraries between mbedtls and legacy ones.
> > Add the mbedtls include directories into the build system.
> > Port u-boot hash functions as MbedTLS crypto alternatives and set
> > it as default.
> >
> > Subsequent patches will separate those Kconfigs into pairs of
> > _LEGACY and _MBEDTLS for controlling the implementations of legacy
> > crypto libraries and MbedTLS ones respectively.
> >
> > The motivation of moving and adapting *INT* macros from kernel.h
> > to limits.h is to fullfill the MbedTLS building requirement.
> > The conditional compilation statements in MbedTLS expects the
> > *INT* macros as constant expressions, thus expressions like
> > `((int)(~0U >> 1))` will not work.
> >
> > Prerequisite
> > ------------
> >
> > This patch series requires mbedtls git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> >       https://github.com/Mbed-TLS/mbedtls.git \
> >       v3.6.0 --squash
> >
> > Moreover, due to the Windows-style files from mbedtls git repo,
> > we need to convert the CRLF endings to LF and do a commit manually:
> >
> > $ git add --renormalize .
> > $ git commit
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Disabled unused MbedTLS features to optimize the target size.
> > Changes in v3
> > - Removed changes in stdio.h.
> > Changes in v4
> > - Move limits.h as a common header file that is included by kernel.h.
> > - Refactor the Kconfig to support legacy and MbedTLS options for each
> >   algorithm.
> > - Refactor MbedTLS makefile and default config file to remove unused
> >   config options and objects.
> > Changes in v5
> > - Merged patch #9 of v4 into this patch.
> > - Removed unused config MBEDTLS_LIB_TLS.
> > - Refactored MbedTLS Makefile and default config file.
> > Changes in v6
> > - Fixed UINT64_MAX.
> > - Removed copy right statement from limits.h
> > Changes in v7
> > - Fixed CI world build failures due to config dependencies.
> > - Fixed values of UINT_MAX and UINT32_MAX.
> > Changes in v8
> > - Port u-boot hash functions as MbedTLS crypto alternatives and set
> >   it as default.
> >
> >  Makefile                         |  6 +++
> >  include/limits.h                 | 25 ++++++++++
> >  include/linux/kernel.h           | 13 +----
> >  include/stdlib.h                 |  1 +
> >  lib/Kconfig                      |  4 ++
> >  lib/Makefile                     |  2 +
> >  lib/mbedtls/Kconfig              | 56 +++++++++++++++++++++
> >  lib/mbedtls/Makefile             | 41 ++++++++++++++++
> >  lib/mbedtls/mbedtls_def_config.h | 84 ++++++++++++++++++++++++++++++++
> >  lib/mbedtls/port/assert.h        | 12 +++++
> >  lib/mbedtls/port/md5_alt.h       | 57 ++++++++++++++++++++++
> >  lib/mbedtls/port/sha1_alt.h      | 57 ++++++++++++++++++++++
> >  lib/mbedtls/port/sha256_alt.h    | 64 ++++++++++++++++++++++++
> >  lib/mbedtls/port/sha512_alt.h    | 78 +++++++++++++++++++++++++++++
> >  14 files changed, 488 insertions(+), 12 deletions(-)
> >  create mode 100644 include/limits.h
> >  create mode 100644 lib/mbedtls/Kconfig
> >  create mode 100644 lib/mbedtls/Makefile
> >  create mode 100644 lib/mbedtls/mbedtls_def_config.h
> >  create mode 100644 lib/mbedtls/port/assert.h
> >  create mode 100644 lib/mbedtls/port/md5_alt.h
> >  create mode 100644 lib/mbedtls/port/sha1_alt.h
> >  create mode 100644 lib/mbedtls/port/sha256_alt.h
> >  create mode 100644 lib/mbedtls/port/sha512_alt.h
> >
> > diff --git a/Makefile b/Makefile
> > index 525576f987d..f4659f9493a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
> >  UBOOTINCLUDE    := \
> >         -Iinclude \
> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> > +       $(if $(CONFIG_MBEDTLS_LIB), \
> > +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
> > +               -I$(srctree)/lib/mbedtls \
> > +               -I$(srctree)/lib/mbedtls/port \
> > +               -I$(srctree)/lib/mbedtls/external/mbedtls \
> > +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \
> >         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> >                 $(if $(CONFIG_HAS_THUMB2), \
> >                         $(if $(CONFIG_CPU_V7M), \
> > diff --git a/include/limits.h b/include/limits.h
> > new file mode 100644
> > index 00000000000..4700cc7a59f
> > --- /dev/null
> > +++ b/include/limits.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef _LIMITS_H
> > +#define _LIMITS_H
> > +
> > +#define INT_MAX     0x7fffffff
> > +#define UINT_MAX    0xffffffffU
> > +#define CHAR_BIT    8
> > +#define UINT32_MAX  0xffffffffU
> > +#define UINT64_MAX  0xffffffffffffffffULL
> > +
> > +#ifdef CONFIG_64BIT
> > +    #define UINTPTR_MAX UINT64_MAX
> > +#else
> > +    #define UINTPTR_MAX UINT32_MAX
> > +#endif
> > +
> > +#ifndef SIZE_MAX
> > +#define SIZE_MAX    UINTPTR_MAX
> > +#endif
> > +#ifndef SSIZE_MAX
> > +#define SSIZE_MAX   ((ssize_t)(SIZE_MAX >> 1))
> > +#endif
> > +
> > +#endif /* _LIMITS_H */
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 939465f372b..9467edd65ab 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -3,25 +3,18 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/printk.h> /* for printf/pr_* utilities */
> > +#include <limits.h>
> >
> >  #define USHRT_MAX      ((u16)(~0U))
> >  #define SHRT_MAX       ((s16)(USHRT_MAX>>1))
> >  #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
> > -#define INT_MAX                ((int)(~0U>>1))
> >  #define INT_MIN                (-INT_MAX - 1)
> > -#define UINT_MAX       (~0U)
> >  #define LONG_MAX       ((long)(~0UL>>1))
> >  #define LONG_MIN       (-LONG_MAX - 1)
> >  #define ULONG_MAX      (~0UL)
> >  #define LLONG_MAX      ((long long)(~0ULL>>1))
> >  #define LLONG_MIN      (-LLONG_MAX - 1)
> >  #define ULLONG_MAX     (~0ULL)
> > -#ifndef SIZE_MAX
> > -#define SIZE_MAX       (~(size_t)0)
> > -#endif
> > -#ifndef SSIZE_MAX
> > -#define SSIZE_MAX      ((ssize_t)(SIZE_MAX >> 1))
> > -#endif
> >
> >  #define U8_MAX         ((u8)~0U)
> >  #define S8_MAX         ((s8)(U8_MAX>>1))
> > @@ -36,10 +29,6 @@
> >  #define S64_MAX                ((s64)(U64_MAX>>1))
> >  #define S64_MIN                ((s64)(-S64_MAX - 1))
> >
> > -/* Aliases defined by stdint.h */
> > -#define UINT32_MAX     U32_MAX
> > -#define UINT64_MAX     U64_MAX
> > -
> >  #define INT32_MAX      S32_MAX
> >
> >  #define STACK_MAGIC    0xdeadbeef
> > diff --git a/include/stdlib.h b/include/stdlib.h
> > index 9c175d4d74c..dedfd52a144 100644
> > --- a/include/stdlib.h
> > +++ b/include/stdlib.h
> > @@ -7,5 +7,6 @@
> >  #define __STDLIB_H_
> >
> >  #include <malloc.h>
> > +#include <rand.h>
> >
> >  #endif /* __STDLIB_H_ */
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 1dd4f271595..67a60160dac 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -419,6 +419,10 @@ config CIRCBUF
> >
> >  source "lib/dhry/Kconfig"
> >
> > +menu "Alternative crypto libraries"
> > +source lib/mbedtls/Kconfig
> > +endmenu
> > +
> >  menu "Security support"
> >
> >  config AES
> > diff --git a/lib/Makefile b/lib/Makefile
> > index d300249f57c..c4950b78a29 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -96,6 +96,8 @@ obj-$(CONFIG_LIBAVB) += libavb/
> >  obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
> >  obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
> >
> > +obj-$(CONFIG_MBEDTLS_LIB) += mbedtls/
> > +
> >  ifdef CONFIG_SPL_BUILD
> >  obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
> >  obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > new file mode 100644
> > index 00000000000..9d1a63c1ca6
> > --- /dev/null
> > +++ b/lib/mbedtls/Kconfig
> > @@ -0,0 +1,56 @@
> > +choice
> > +       prompt "Select crypto libraries"
> > +       default LEGACY_CRYPTO
> > +       help
> > +         Select crypto libraries.
> > +         LEGACY_CRYPTO for legacy crypto libraries,
> > +         MBEDTLS_LIB for MbedTLS libraries.
> > +
> > +config LEGACY_CRYPTO
> > +       bool "legacy crypto libraries"
> > +       select LEGACY_CRYPTO_BASIC
> > +       select LEGACY_CRYPTO_CERT
> > +
>
>
> This overall llooks ok, but the native mbedTLS hashing should depend
> on !CONFIG_SHA_HW_ACCEL.
> If everyone thinks the series is good enough to merge, I don't mind
> this going on a followup commit
>
> I will add this into v9 with other changes.

[snip]

Raymond
