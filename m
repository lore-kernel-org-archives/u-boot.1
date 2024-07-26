Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68216C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF624881BA;
	Fri, 26 Jul 2024 16:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MIB5SLOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C127B884C5; Fri, 26 Jul 2024 16:30:03 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8E787C68
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc52394c92so7185405ad.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722004199; x=1722608999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EtUVWKSTGdNDeQLYLKs8IxjoQhbY/Dv9YoUFSoaF4Hk=;
 b=MIB5SLODM/QcDszJ0jU8AAuPz6O9fYnXOXwPd7+ugCDD+sLfOgOkImrKYL4G143pz+
 +RiPyijuAxjOMY4g1gdONEh4hlm0KPGecliYvzitDENFbplPIaxDDdNXYbeOVfRah802
 2/dkz9Yk1KtgR5ZQC4Kh12Jm43i8nOtINNth5JVpAjV6chYmbekH/1x7hwmL8sgTnHbE
 ot5qcKsrClFIoAnoTDTg2a1LlDiuktTz9sjyBtnS1M2M5B1Kp6yrZjiXxrlrZoUrrsvL
 jJpcJ0mfgfQycE5v94EXUglLLYdxqzN/X+G7mnAMYKmJgrsGminXooKNF00wU+PUVA6W
 tTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722004199; x=1722608999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtUVWKSTGdNDeQLYLKs8IxjoQhbY/Dv9YoUFSoaF4Hk=;
 b=l5gFsbWRGi5xXrSorT9ZYY6PC7T0K0MqPHfXXxSQzBhr9/TuLJ565z3O4ZMbbDVTOu
 DRK+YFifGM6qqOaA967ZE22GWnDjJ9IMXzkZZrlOT/T5Tk7FgazMSryX41rUY/OEZMqe
 dGM/zC+rOVrwDwx94225D/rJIoJ+O5MLSjpO2CDV9uar9oT3vL66ME4YdoevlWu24cme
 lcmjK/hERal2iHgg+90KD4ntX4kkxwFGzfibcVGvn868SnJVolB8nGkQeqGITyHn3omA
 zBeHvF8PYdZilkM1y+7jRsSimB4wwbUpZIHbsArShYqMpumlNWVFfjV2v27HseM4Yzah
 Tmxw==
X-Gm-Message-State: AOJu0Yx8atLBspWbd/oE27gHy6UNO7bfvlTKWZu5kV5bDCVExZkFoTNS
 /qHnsmGAihge5YJwvMnFmzMJx4V4UiLDWYpAW+m0EuqdObVL6oXyOI8fKJ3WHEDOn0GLmjBTvYW
 9nhRoAbv/q2iRnjob+PnwuZ47OnQhXBVbydVxXg==
X-Google-Smtp-Source: AGHT+IEUuDIhtRb+50XDTOL7JcAmUgHyG9BjoRLm9RQAYMsHeuSEtRHp5l/PkPOAJWrJT5tsPL5zE5otnFt+DKTEfcA=
X-Received: by 2002:a17:90a:ab0d:b0:2c8:84b:580e with SMTP id
 98e67ed59e1d1-2cf23e25a25mr6685393a91.41.1722004199301; Fri, 26 Jul 2024
 07:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-8-raymond.mao@linaro.org>
 <CAC_iWjKxdyTg+HeALny9sMDhwKpcJ7peL=M_6jdivcWN884Shw@mail.gmail.com>
In-Reply-To: <CAC_iWjKxdyTg+HeALny9sMDhwKpcJ7peL=M_6jdivcWN884Shw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 26 Jul 2024 10:29:47 -0400
Message-ID: <CAEfUkU+07PhhyMebjQ711xsdgx_+-nMhNOANAV1JuK9XnwWpDA@mail.gmail.com>
Subject: Re: [PATCH v4 07/29] mbedtls: add digest shim layer for MbedTLS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
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

On Fri, 26 Jul 2024 at 06:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> [...]
>
> >
> > +if MBEDTLS_LIB_CRYPTO
> > +
> > +config SHA1_MBEDTLS
> > +       bool "Enable SHA1 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA1
> > +       help
> > +         This option enables support of hashing using SHA1 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SHA256_MBEDTLS
> > +       bool "Enable SHA256 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA256
> > +       help
> > +         This option enables support of hashing using SHA256 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SHA512_MBEDTLS
> > +       bool "Enable SHA512 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA512
> > +       default y if TI_SECURE_DEVICE && FIT_SIGNATURE
>
> I don't like this default 'y' for 'ti secure devices'.  This is a
> board specific option. I think it should be defined on the defconfig
> of those boards instead.
>
> This dependence completely follows the original SHA512.
Removing TI_SECURE_DEVICE brings some additions work out of the scope
of this patch series since we have to update all defconfigs which enables
ARCH_K3 (TI_SECURE_DEVICE is an implicit setting of ARCH_K3).
If we plan to do this, it is better to have another optimization patch set
after
this one is merged.


> > +       help
> > +         This option enables support of hashing using SHA512 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SHA384_MBEDTLS
> > +       bool "Enable SHA384 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA384
> > +       select SHA512_MBEDTLS
> > +       help
> > +         This option enables support of hashing using SHA384 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config MD5_MBEDTLS
> > +       bool "Enable MD5 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && MD5
> > +       help
> > +         This option enables support of hashing using MD5 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +if SPL
> > +
> > +config SPL_SHA1_MBEDTLS
> > +       bool "Enable SHA1 support in SPL with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA1
> > +       default y if SHA1 && MBEDTLS_LIB_CRYPTO
> > +       help
> > +         This option enables support of hashing using SHA1 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SPL_SHA256_MBEDTLS
> > +       bool "Enable SHA256 support in SPL with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA256
> > +       default y if SHA256 && MBEDTLS_LIB_CRYPTO
> > +       help
> > +         This option enables support of hashing using SHA256 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SPL_SHA512_MBEDTLS
> > +       bool "Enable SHA512 support in SPL with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA512
> > +       default y if SHA512 && MBEDTLS_LIB_CRYPTO
> > +       help
> > +         This option enables support of hashing using SHA512 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SPL_SHA384_MBEDTLS
> > +       bool "Enable SHA384 support in SPL with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA384
> > +       default y if SHA384 && MBEDTLS_LIB_CRYPTO
> > +       select SPL_SHA512
> > +       help
> > +         This option enables support of hashing using SHA384 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SPL_MD5_MBEDTLS
> > +       bool "Enable MD5 support in SPL with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SPL_MD5
> > +       default y if MD5 && MBEDTLS_LIB_CRYPTO
> > +       help
> > +         This option enables support of hashing using MD5 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +endif # SPL
> > +
> > +endif # MBEDTLS_LIB_CRYPTO
> >
> >  config MBEDTLS_LIB_X509
> >         bool "MbedTLS certificate libraries"
> > diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> > index 803ea0b62a0..32a98b7f4ca 100644
> > --- a/lib/mbedtls/Makefile
> > +++ b/lib/mbedtls/Makefile
> > @@ -13,17 +13,24 @@ ccflags-y += \
> >         -I$(src)/external/mbedtls/include \
> >         -I$(src)/external/mbedtls/library
> >
> > +# shim layer for hash
> > +obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += hash_mbedtls.o
> > +hash_mbedtls-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
> > +hash_mbedtls-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
> > +hash_mbedtls-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
> > +hash_mbedtls-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
> > +
> >  # MbedTLS crypto library
> >  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> >  mbedtls_lib_crypto-y += \
> >         $(MBEDTLS_LIB_DIR)/platform_util.o \
> >         $(MBEDTLS_LIB_DIR)/constant_time.o \
> >         $(MBEDTLS_LIB_DIR)/md.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> >         $(MBEDTLS_LIB_DIR)/sha256.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
> >         $(MBEDTLS_LIB_DIR)/sha512.o
> >
> >  # MbedTLS X509 library
> > diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
> > new file mode 100644
> > index 00000000000..04388fce249
> > --- /dev/null
> > +++ b/lib/mbedtls/md5.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hash shim layer on MbedTLS Crypto library
> > + *
> > + * Copyright (c) 2024 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#include "compiler.h"
> > +
> > +#ifndef USE_HOSTCC
> > +#include <watchdog.h>
> > +#endif /* USE_HOSTCC */
> > +#include <u-boot/md5.h>
> > +
> > +void MD5Init(MD5Context *ctx)
> > +{
> > +       mbedtls_md5_init(ctx);
> > +       mbedtls_md5_starts(ctx);
> > +}
> > +
> > +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int
> len)
> > +{
> > +       mbedtls_md5_update(ctx, buf, len);
> > +}
> > +
> > +void MD5Final(unsigned char digest[16], MD5Context *ctx)
> > +{
> > +       mbedtls_md5_finish(ctx, digest);
> > +       mbedtls_md5_free(ctx);
> > +}
> > +
> > +void md5_wd(const unsigned char *input, unsigned int len,
> > +           unsigned char output[16], unsigned int chunk_sz)
> > +{
> > +       MD5Context context;
> > +
> > +       MD5Init(&context);
> > +
> > +       if (IS_ENABLED(CONFIG_HW_WATCHDOG) ||
> IS_ENABLED(CONFIG_WATCHDOG)) {
> > +               const unsigned char *curr = input;
> > +               const unsigned char *end = input + len;
> > +               int chunk;
> > +
> > +               while (curr < end) {
> > +                       chunk = end - curr;
> > +                       if (chunk > chunk_sz)
> > +                               chunk = chunk_sz;
> > +                       MD5Update(&context, curr, chunk);
> > +                       curr += chunk;
> > +                       schedule();
> > +               }
> > +       } else {
> > +               MD5Update(&context, input, len);
> > +       }
>
> You can probably split this part to a function, that takes the hashing
> algo as an argument, since the loop is identical for md5, sha1, sha256
> etc
>
> I think this change does not bring too much value.
They are calling different "_update()" functions and we need to switch the
algorithm to select which one should be called.
Other than that, we need to create a new file (e.g. md_common.c) to contain
this new common function.
As a trade-off, I prefer to keep the current implementation.

[snip]

Regards,
Raymond
