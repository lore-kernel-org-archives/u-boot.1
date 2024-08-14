Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7174BC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 13:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A39889D1;
	Wed, 14 Aug 2024 15:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z4Ibw9En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA098870E; Wed, 14 Aug 2024 15:29:52 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A07E88702
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 15:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc5296e214so63605425ad.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642188; x=1724246988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eu0jkaeVOufQUtnoDYNZemlYwuRQdqdM9gDtLZZX17k=;
 b=z4Ibw9Enw8cdFoAbxXk0VB48pQxyOgN4g+kVazy5Gw2MuqPpzRJdeBAD4IpxpSZjb6
 UDtKsopkpCi/np34UBM4cLXIr21AC3mWte6DXXL8W2WLPZd3RPiSfS9H+AI39K6SFC00
 g9d5Ppcoq/MGIVBrZIpwcqkEbIyB0HLyXtgf0hGnqsY+lR5RAv2cyfxDnaKSl9cCZtUY
 0mwdJrukLlbSaA3tI4SfQI9sB+PQo/MKlxPT0VPU+YRtBQ1kA+WJ47s2/vk/NBK8iPCo
 6mraPEeF1wN9XlI8BJigmzllpU1z0da040MRJL6rZNMUMj6vGEAfxAtG415pS7skCVps
 oztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642188; x=1724246988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eu0jkaeVOufQUtnoDYNZemlYwuRQdqdM9gDtLZZX17k=;
 b=hnlZlz+e+vq548OKTB+gSD+J22neJvqx386wJUUmXHZn0oRl2765LiS0ymThjGQBdR
 z0b20sTb0KPEl080xlK9BTpntdV1EJ3IxRLZTSRWFVJ5Zd8FR6mfPgNIQLdLMifgcN4/
 481d0oTePDR16Q7MDzJC/9xpblYWKldm/Pyu0gNknblEOBcvhXfDwvaB9yvoe2tJsFqt
 RmkoiDYbUNMKZO97u8QYFxl8wcLO1DiyLqu4WZc0DSLopp62fn/Ris6C2Scg5IbRceOT
 lj+z6Tc+K30DZ/Nier0Rdjgxbe82u/7/CVwmtWm5Cjygj3q3UfQyltzq7288mewgSNWy
 tuQQ==
X-Gm-Message-State: AOJu0Yybmf8Z0HSYvAUs4XZVtNxtOEoxYLfMfD6W0Jxvi8lVCxF3ieKD
 //RSkIL47Hm1yeSUd50ZDrw+UfJlqp5iwE5dy/udT/0Vh8p1TyXY837SihYzgUQnmHvdteW9wFO
 2BZGv8KK69URZeihdTgZLzZtIYwGGdtbYraQ4HKaLLmVQOm72
X-Google-Smtp-Source: AGHT+IGHfknokQ1aAF113P0iHSAySeiwW+LaLqoNSs+Gu08aeE82slcw4UMC+U0uknjR9TmSb7pt76JR3fUjQaxnefA=
X-Received: by 2002:a17:902:da86:b0:200:953b:75a6 with SMTP id
 d9443c01a7336-201d638d9b8mr31483715ad.5.1723642187688; Wed, 14 Aug 2024
 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240731172556.1348487-3-raymond.mao@linaro.org>
 <CAC_iWjKX-o0_WmaFuAsDQLOjDevuGKJc-PNSGxuqw0tk1dF=MQ@mail.gmail.com>
 <CAEfUkUK7RBTyL_u4=M5adXCrK_rDGkfUZz=rKwmaUiNO=Kpi9w@mail.gmail.com>
In-Reply-To: <CAEfUkUK7RBTyL_u4=M5adXCrK_rDGkfUZz=rKwmaUiNO=Kpi9w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Aug 2024 16:29:11 +0300
Message-ID: <CAC_iWjJmrgZ32na4N=uVoJk0b4Z7jJ6UFsw80fdPWvpwRk4sNA@mail.gmail.com>
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

On Wed, 14 Aug 2024 at 16:22, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 14 Aug 2024 at 08:08, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On Wed, 31 Jul 2024 at 20:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Port mbedtls with adapted libc header files.
>> > Add mbedtls default config header file.
>> > Optimize mbedtls default config by disabling unused features to
>> > reduce the target size.
>> > Add mbedtls kbuild makefile.
>> > Add Kconfig skeleton and config submenu entry for selecting
>> > crypto libraries between mbedtls and legacy ones.
>> > Add the mbedtls include directories into the build system.
>> >
>> > Subsequent patches will separate those Kconfigs into pairs of
>> > _LEGACY and _MBEDTLS for controlling the implementations of legacy
>> > crypto libraries and MbedTLS ones respectively.
>> >
>> > The motivation of moving and adapting *INT* macros from kernel.h
>> > to limits.h is to fullfill the MbedTLS building requirement.
>> > The conditional compilation statements in MbedTLS expects the
>> > *INT* macros as constant expressions, thus expressions like
>> > `((int)(~0U >> 1))` will not work.
>> >
>> > Prerequisite
>> > ------------
>> >
>> > This patch series requires mbedtls git repo to be added as a
>> > subtree to the main U-Boot repo via:
>> >
>> > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>> >       https://github.com/Mbed-TLS/mbedtls.git \
>> >       v3.6.0 --squash
>> >
>> > Moreover, due to the Windows-style files from mbedtls git repo,
>> > we need to convert the CRLF endings to LF and do a commit manually:
>> >
>> > $ git add --renormalize .
>> > $ git commit
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Disabled unused MbedTLS features to optimize the target size.
>> > Changes in v3
>> > - Removed changes in stdio.h.
>> > Changes in v4
>> > - Move limits.h as a common header file that is included by kernel.h.
>> > - Refactor the Kconfig to support legacy and MbedTLS options for each
>> >   algorithm.
>> > - Refactor MbedTLS makefile and default config file to remove unused
>> >   config options and objects.
>> > Changes in v5
>> > - Merged patch #9 of v4 into this patch.
>> > - Removed unused config MBEDTLS_LIB_TLS.
>> > - Refactored MbedTLS Makefile and default config file.
>> >
>> >  Makefile                         |  6 +++
>> >  include/limits.h                 | 29 ++++++++++++++
>> >  include/linux/kernel.h           | 13 +-----
>> >  include/stdlib.h                 |  1 +
>> >  lib/Kconfig                      |  4 ++
>> >  lib/Makefile                     |  2 +
>> >  lib/mbedtls/Kconfig              | 47 ++++++++++++++++++++++
>> >  lib/mbedtls/Makefile             | 41 +++++++++++++++++++
>> >  lib/mbedtls/mbedtls_def_config.h | 69 ++++++++++++++++++++++++++++++++
>> >  lib/mbedtls/port/assert.h        | 12 ++++++
>> >  10 files changed, 212 insertions(+), 12 deletions(-)
>> >  create mode 100644 include/limits.h
>> >  create mode 100644 lib/mbedtls/Kconfig
>> >  create mode 100644 lib/mbedtls/Makefile
>> >  create mode 100644 lib/mbedtls/mbedtls_def_config.h
>> >  create mode 100644 lib/mbedtls/port/assert.h
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 07d7947c8af..fd855dbd5c9 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>> >  UBOOTINCLUDE    := \
>> >         -Iinclude \
>> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> > +       $(if $(CONFIG_MBEDTLS_LIB), \
>> > +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
>> > +               -I$(srctree)/lib/mbedtls \
>> > +               -I$(srctree)/lib/mbedtls/port \
>> > +               -I$(srctree)/lib/mbedtls/external/mbedtls \
>> > +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \
>> >         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>> >                 $(if $(CONFIG_HAS_THUMB2), \
>> >                         $(if $(CONFIG_CPU_V7M), \
>> > diff --git a/include/limits.h b/include/limits.h
>> > new file mode 100644
>> > index 00000000000..cc691d15650
>> > --- /dev/null
>> > +++ b/include/limits.h
>> > @@ -0,0 +1,29 @@
>> > +/* SPDX-License-Identifier: GPL-2.0+ */
>> > +/*
>> > + * Copyright (c) 2023 Linaro Limited
>> > + * Author: Raymond Mao <raymond.mao@linaro.org>
>> > + */
>> > +
>> > +#ifndef _LIMITS_H
>> > +#define _LIMITS_H
>> > +
>> > +#define INT_MAX         0x7fffffff
>> > +#define UINT_MAX       0xffffffffUL
>> > +#define CHAR_BIT        8
>> > +#define UINT32_MAX      0xffffffffUL
>> > +#define UINT64_MAX     0xffffffffffffffffUL
>>
>> Some of these seem wrong e.g UINT64_MAX should be ULL, etc
>> Can you keep the original definitions?
>>
> The original definitions cannot work with building MbedTLS.
> As I stated in the commit message:
> ```
> The conditional compilation statements in MbedTLS expects the
> *INT* macros as constant expressions, thus expressions like
> `((int)(~0U >> 1))` will not work.

Ah that's ok, fix the UL etc and keep it as is

> ```
> [snip]
>
> Raymond
>
