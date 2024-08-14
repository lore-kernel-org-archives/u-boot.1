Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAD4C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 13:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F32188967;
	Wed, 14 Aug 2024 15:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vy5gCyfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D174889A1; Wed, 14 Aug 2024 15:22:59 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7FC88763
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 15:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso255341a91.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723641774; x=1724246574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cfd/PQo5li7mwiAvJJbXFwJ8mzcbOrd5/Bte3C6ww4I=;
 b=vy5gCyfRMYpSdtYCPTMz+pFhGgeGEgftcOw2ImNiTFJliFGG3WO9WC07z4+Q6pVRp9
 GsmpC5qp3pPZvuiCUwjmdn66BO9dnZTUdT2JaSJLotptJ0AoF3cDe7s2lyHo3giVN7t2
 mPy6CJ7+nV5v3OqxVvCo1OIMUx/c12OX8EUW454MnQuTNTjmR8QH4k54j5Qin3qV62GJ
 jgt1XVoORy/c6eueKB5KFx5kEbo8RlVjSu/Rxl11F3yLlcoopfFhUeO/3gBFJ4hWXv5F
 HOBnDkbIugAybfG78DLp1bCZJeKiZGDb37fWhb8HUedSKmIhk2ps7DICfz4qP+OQBxhO
 31Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723641774; x=1724246574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cfd/PQo5li7mwiAvJJbXFwJ8mzcbOrd5/Bte3C6ww4I=;
 b=JwTasT7SMVRhwC6gv+41/Kcd/rrfn9BsSgFYPZJSIOWC3XoPcByF53m0vfjSyQxsSW
 UTbgGfm6+3MT176oxi+2pTUdHyJ6ESR9Ky4UEKRfds9c7AzxWycyalnKmIl5IAGw8E2e
 T0D60MGZLT/Zz+DnG08b72yJ4TcjWySqmfGxrgc7l91NuYQstiysCJVHcLVxXNeQHQrd
 xktGgEmyFkFf8DGrT/GtEBhVUx2RwScpFqvEHddHZF3HAGKeNArYfjctInJHnfDvLkGO
 JnJ34nIT0KFZblLHGm4hYelotVbqBMtc83te+lvtglo2X5XAcka5SE6gTjturWRDOd/V
 TLLA==
X-Gm-Message-State: AOJu0YyI2pjea4qXAu9OIrGL7098dNw6MkR4ABhdN8zyDn38tA2Scf5a
 6AppQqMzRNgzYVfOaYqrLkhn94Yym7s02jIAXnHHB3L3uo5D6s+81V7B/hUd2dIjQAujFUd6yNr
 nxS0/V81vYCQQ0casRatEibJSnIrIN7OODp2wYw==
X-Google-Smtp-Source: AGHT+IGeV2HQELCst9wq16Xl39G1t0b6IIpVMOTDMMR3UZ9xwTYci3ulfaluIHesiehX7DOg2Yl8APWM26OxY0l5cF0=
X-Received: by 2002:a17:90a:f2d4:b0:2c8:f3b5:7dd1 with SMTP id
 98e67ed59e1d1-2d3ace552eamr3556505a91.16.1723641774365; Wed, 14 Aug 2024
 06:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240731172556.1348487-3-raymond.mao@linaro.org>
 <CAC_iWjKX-o0_WmaFuAsDQLOjDevuGKJc-PNSGxuqw0tk1dF=MQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKX-o0_WmaFuAsDQLOjDevuGKJc-PNSGxuqw0tk1dF=MQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 14 Aug 2024 09:22:41 -0400
Message-ID: <CAEfUkUK7RBTyL_u4=M5adXCrK_rDGkfUZz=rKwmaUiNO=Kpi9w@mail.gmail.com>
Subject: Re: [PATCH v5 02/27] mbedtls: add mbedtls into the build system
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 14 Aug 2024 at 08:08, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Wed, 31 Jul 2024 at 20:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Port mbedtls with adapted libc header files.
> > Add mbedtls default config header file.
> > Optimize mbedtls default config by disabling unused features to
> > reduce the target size.
> > Add mbedtls kbuild makefile.
> > Add Kconfig skeleton and config submenu entry for selecting
> > crypto libraries between mbedtls and legacy ones.
> > Add the mbedtls include directories into the build system.
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
> >
> >  Makefile                         |  6 +++
> >  include/limits.h                 | 29 ++++++++++++++
> >  include/linux/kernel.h           | 13 +-----
> >  include/stdlib.h                 |  1 +
> >  lib/Kconfig                      |  4 ++
> >  lib/Makefile                     |  2 +
> >  lib/mbedtls/Kconfig              | 47 ++++++++++++++++++++++
> >  lib/mbedtls/Makefile             | 41 +++++++++++++++++++
> >  lib/mbedtls/mbedtls_def_config.h | 69 ++++++++++++++++++++++++++++++++
> >  lib/mbedtls/port/assert.h        | 12 ++++++
> >  10 files changed, 212 insertions(+), 12 deletions(-)
> >  create mode 100644 include/limits.h
> >  create mode 100644 lib/mbedtls/Kconfig
> >  create mode 100644 lib/mbedtls/Makefile
> >  create mode 100644 lib/mbedtls/mbedtls_def_config.h
> >  create mode 100644 lib/mbedtls/port/assert.h
> >
> > diff --git a/Makefile b/Makefile
> > index 07d7947c8af..fd855dbd5c9 100644
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
> > index 00000000000..cc691d15650
> > --- /dev/null
> > +++ b/include/limits.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2023 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +
> > +#ifndef _LIMITS_H
> > +#define _LIMITS_H
> > +
> > +#define INT_MAX         0x7fffffff
> > +#define UINT_MAX       0xffffffffUL
> > +#define CHAR_BIT        8
> > +#define UINT32_MAX      0xffffffffUL
> > +#define UINT64_MAX     0xffffffffffffffffUL
>
> Some of these seem wrong e.g UINT64_MAX should be ULL, etc
> Can you keep the original definitions?
>
> The original definitions cannot work with building MbedTLS.
As I stated in the commit message:
```
The conditional compilation statements in MbedTLS expects the
*INT* macros as constant expressions, thus expressions like
`((int)(~0U >> 1))` will not work.
```
[snip]

Raymond
