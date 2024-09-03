Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A3FCD342A
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE81D88B68;
	Tue,  3 Sep 2024 17:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eeDTSs9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163B488C1C; Tue,  3 Sep 2024 17:12:48 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB0388B4B
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2da4ea59658so1041443a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725376364; x=1725981164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hzx91uB7tNRZopT7GlBr3WiYGMq2mgMrZTBnWPVZYSg=;
 b=eeDTSs9eyMaro9iORnSfpvkMcVoy20ZD4ri4+Lmq0iJqt4oD/80fxBnj4wvjS+N+/A
 6bWkhgx8E9+0VXp5yhYoewQeT0HNeH3t+tqwHxNs4/iyleyCpXbdAB5NZrm6YDklVwGP
 jZl5XTMSW+Z1/zQmNR8ita1McsApk13ZMNWR17z3hkmN+oZrYDczeg5idz43KqtcPiy0
 KA9fwH8/YmbiYt5e0oe3PHCjb61ChnNqGAt46qsnTOYeOV/gohMOCgkYwb5dRhXwjAWb
 DF2Vabs+PMMh7GkFP3MYNG6nkuxmDY0rrgMjXiPJcNnEugdgqKtt7zAJNCjVAN6RS3Wg
 dUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725376364; x=1725981164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hzx91uB7tNRZopT7GlBr3WiYGMq2mgMrZTBnWPVZYSg=;
 b=uovXUdBP5K3TYBskAe7hJiyjqI7rd59ry8SOpsIbIUnla96jOEN+7Na7cbBeSYCc/3
 0mM8fgGyOYAbcrJMQS9gfayXPPJe4ucvU5q+MciFi6lNj/yJ9qndcOSElI/aBTZ+lWpo
 Qr77vdBj33Jz1z7v09OaRktXGxk8X03ZwAFQWEGLsEel+AkXYZDA/FNKGegXLJqhs5H6
 t/1j74y2aF+JY9Tcz6v/RsKlp1WmGWuXI8fCIlhkKmuuUYMfUXRbp933zvFaPf5/8t//
 yadIP/yTYnmHa4wtcbuG5WIdGQOhwTbGlAePWqbt25zZ60ESrcFTz0R56c3ylHCcyb9O
 Vt2w==
X-Gm-Message-State: AOJu0YzqcOhEWByeEEWwJLFKUp2OxulXA5J6zAunQbLc4OLzPuQ1Piy0
 N3xO+7vrr0pLhIp+QVepM7znzfzTZMVMe+aKxLzn+mBWGDdHT3ddXf3gPcBDiLmBW//pSJ5VQ8D
 Tj+KcaWJ+k2XZj7l5JUIBYVlMftEU/IM2bjcbVgyQUrDntgJZ
X-Google-Smtp-Source: AGHT+IFFit1zkJzVpuGxsfbAc3fGiMu20VykY2WNt74ocxObDtYR5d3V7Ghm+0pfhdKVUiU1z9PgukIb7pVtv0jWicM=
X-Received: by 2002:a17:90a:db8a:b0:2d8:8808:5154 with SMTP id
 98e67ed59e1d1-2d88e6f57c2mr10678946a91.40.1725376363962; Tue, 03 Sep 2024
 08:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-4-raymond.mao@linaro.org>
 <CAC_iWj+-Wa=X8RxUpLGuDV+BAkt-4hBKNSvJWPPsXHF+jX-L0Q@mail.gmail.com>
In-Reply-To: <CAC_iWj+-Wa=X8RxUpLGuDV+BAkt-4hBKNSvJWPPsXHF+jX-L0Q@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:12:32 -0400
Message-ID: <CAEfUkUJcHd7Ag=mpf+WH_DzoPDMD26V5+1hi5j7zzhEhOb=UBQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/28] lib: Adapt digest header files to MbedTLS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
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

On Wed, 28 Aug 2024 at 05:25, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Sat, 17 Aug 2024 at 00:46, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Adapt digest header files to support both original libs and MbedTLS
> > by switching on/off MBEDTLS_LIB_CRYPTO.
> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> >
> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > including <linux/kconfig.h> causes undefined reference on schedule()
> > with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no
> schedule()
> > are defined in sandbox build,
> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Initial patch.
> > Changes in v3
> > - Remove the changes that were done in previous clean-up patch set.
> > Changes in v4
> > - Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > Changes in v5
> > - Correct header file include directories.
> > - Correct kconfig dependence.
> > Changes in v6
> > - Update commit message.
> > - Rebased on next branch.
> >
> >  include/u-boot/md5.h    |  7 ++++
> >  include/u-boot/sha1.h   | 21 +++++++++-
> >  include/u-boot/sha256.h | 20 +++++++++
> >  include/u-boot/sha512.h |  9 ++++
> >  lib/Makefile            | 10 +++--
> >  lib/mbedtls/Kconfig     | 91 +++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 153 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> > index c465925ea8d..69898fcbe49 100644
> > --- a/include/u-boot/md5.h
> > +++ b/include/u-boot/md5.h
> > @@ -6,10 +6,16 @@
> >  #ifndef _MD5_H
> >  #define _MD5_H
> >
> > +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> > +#include <mbedtls/md5.h>
> > +#endif
> >  #include "compiler.h"
> >
> >  #define MD5_SUM_LEN    16
> >
> > +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> > +typedef mbedtls_md5_context MD5Context;
> > +#else
> >  typedef struct MD5Context {
> >         __u32 buf[4];
> >         __u32 bits[2];
> > @@ -18,6 +24,7 @@ typedef struct MD5Context {
> >                 __u32 in32[16];
> >         };
> >  } MD5Context;
> > +#endif
> >
> >  void MD5Init(MD5Context *ctx);
> >  void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int
> len);
> > diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> > index c1e9f67068d..ab88134fb98 100644
> > --- a/include/u-boot/sha1.h
> > +++ b/include/u-boot/sha1.h
> > @@ -16,6 +16,21 @@
> >
> >  #include <linux/types.h>
> >
> > +#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> > +/*
> > + * FIXME:
> > + * MbedTLS define the members of "mbedtls_sha256_context" as private,
> > + * but "state" needs to be access by arch/arm/cpu/armv8/sha1_ce_glue.
> > + * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the
> external
> > + * access.
> > + * Directly including <external/mbedtls/library/common.h> is not
> allowed,
> > + * since this will include <malloc.h> and break the sandbox test.
> > + */
> > +#define MBEDTLS_ALLOW_PRIVATE_ACCESS
>
> nit, this probably belongs on the mbedTLS config file, so you wont
> have to define for all checksum algorithms
>
> Have to keep it here to avoid changes to the library,
as the macro belongs to the common header file but not the custom config.

Regards,
Raymond

[snip]
