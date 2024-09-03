Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4054CD342A
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B5B889BD;
	Tue,  3 Sep 2024 17:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uvIJGB46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7524088B49; Tue,  3 Sep 2024 17:28:18 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF7D88875
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo4269827a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725377294; x=1725982094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UzN82OKZZVObiCG2C9DOvQyHh9pbykx8EZF1CcJk5KA=;
 b=uvIJGB46JQw9WNh7Bu6iSrRy6PPbkXMqwbYcEnUGzjy0yGnYN+vem1SZ8Q8TFeGoS/
 tZPU5EEUd/YrGvQZT0WsR0r0mskgXLmmyBmBDewImk/2MXh1N2J4d1/xMnX43p6ANwZg
 MPDbaHTO5oPSXs1X6H4Ky64wnGVW8VR4IV1oHbuDTJt60mNvQ8JdN7Txq8Y4oDEy6bxT
 ILC40L+smuo6bWTh0gqqHYn6xB51sqtEACkBPTpklnd3LwPAuNkhCozqRqNUXBw/c1OS
 e+/ShfB7QP5oAz57fF6WMGDT5THxRP8BQpTNSjM/dHLBF12aBeWE0evzJYDp+5aOrLAS
 JeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725377294; x=1725982094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzN82OKZZVObiCG2C9DOvQyHh9pbykx8EZF1CcJk5KA=;
 b=K2u4qcqpyH72V3dxSoKVoRMfC7t7Kt+rZjz9DX83AeTliOTJ3bsYZuJ+/PfoeGJv36
 CmCloDONQqXWBxGtCoefkB4ENHLPMGPeQnqb4iH4q4G4hNkALwGGQHbdeTIA4VjE7BRf
 tVWewioWKLRP8ZaQ/yheyA5C7YkSf7zWEMZV8YY+2v0Nz0lg6hVLBPaUTBI+HICVM6fa
 NT5GA3Rk8Wc4VOHt56pzEplQgvUQEF4WL0mbqzKnuDOFUevvYmBE1BltechPa2HDaPoq
 QHzYkFtT5P3NNkCG8Dq7mluKWlbg5q0e79LLt+Xf5jSTEmD1adXXL5hq7hFOoIa8erjn
 SUkw==
X-Gm-Message-State: AOJu0YwSenl4VRMvByS7qpWV05WT5fEflINxN0EslpiU0eLiTaexOJ4e
 TNh1C65TEGmpW0253Za4mk1mjileMaFT5LSbSFSL+QXOC48pPkhHfJj5D1OdpADEEWWLLA+KIU3
 cO0hHDhrH1eXZ29X5qJjkVMgi0i4GX42SR4iNDw==
X-Google-Smtp-Source: AGHT+IGuG8WOrFmx/+qofj4EINGSk4eq0wOG7q+TfWla1teD5QVbTttNuceHgiIe0xTRXJIH9NuY6lsgKkzMSuUgFEQ=
X-Received: by 2002:a17:90b:97:b0:2d8:7445:7ab2 with SMTP id
 98e67ed59e1d1-2d874459b73mr17800340a91.20.1725377293939; Tue, 03 Sep 2024
 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-7-raymond.mao@linaro.org> <Zs79zfxLrE1/7aaL@hades>
In-Reply-To: <Zs79zfxLrE1/7aaL@hades>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:28:02 -0400
Message-ID: <CAEfUkUL99tiJEHWxf5qPmqR7wpQRnFmLCB=caxfo4P4-wrYn=w@mail.gmail.com>
Subject: Re: [PATCH v6 06/28] mbedtls: add digest shim layer for MbedTLS
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
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

On Wed, 28 Aug 2024 at 06:37, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> [...]
>
> > --- a/lib/mbedtls/Makefile
> > +++ b/lib/mbedtls/Makefile
> > @@ -5,17 +5,23 @@
> >
> >  MBEDTLS_LIB_DIR = external/mbedtls/library
> >
> > +# shim layer for hash
> > +obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
> > +obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
> > +obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
> > +obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
> > +
> >  # MbedTLS crypto library
> >  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> >  mbedtls_lib_crypto-y := \
> >       $(MBEDTLS_LIB_DIR)/platform_util.o \
> >       $(MBEDTLS_LIB_DIR)/constant_time.o \
> >       $(MBEDTLS_LIB_DIR)/md.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>
> Why do we need to rename these here? Can't you add them with the _MBEDTLS
> suffix on the patch that introduced them?
>
> Patch #2 introduced the digest library but set it as default. And this
patch moves it under _MBEDTLS kconfig.
I have to separate into two otherwise patch #3 will be too huge and hard to
be reviewed.


> >       $(MBEDTLS_LIB_DIR)/sha256.o
> > -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
> > +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
> >       $(MBEDTLS_LIB_DIR)/sha512.o
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
> > +     mbedtls_md5_init(ctx);
> > +     mbedtls_md5_starts(ctx);
> > +}
> > +
> > +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int
> len)
> > +{
> > +     mbedtls_md5_update(ctx, buf, len);
> > +}
> > +
> > +void MD5Final(unsigned char digest[16], MD5Context *ctx)
> > +{
> > +     mbedtls_md5_finish(ctx, digest);
> > +     mbedtls_md5_free(ctx);
> > +}
> > +
> > +void md5_wd(const unsigned char *input, unsigned int len,
> > +         unsigned char output[16], unsigned int chunk_sz)
> > +{
> > +     MD5Context context;
> > +
> > +     MD5Init(&context);
> > +
> > +     if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG))
> {
> > +             const unsigned char *curr = input;
> > +             const unsigned char *end = input + len;
> > +             int chunk;
> > +
> > +             while (curr < end) {
> > +                     chunk = end - curr;
> > +                     if (chunk > chunk_sz)
> > +                             chunk = chunk_sz;
> > +                     MD5Update(&context, curr, chunk);
> > +                     curr += chunk;
> > +                     schedule();
> > +             }
> > +     } else {
> > +             MD5Update(&context, input, len);
> > +     }
> > +
> > +     MD5Final(output, &context);
> > +}
> > diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
> > new file mode 100644
> > index 00000000000..2aee5037795
> > --- /dev/null
> > +++ b/lib/mbedtls/sha1.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hash shim layer on MbedTLS Crypto library
> > + *
> > + * Copyright (c) 2024 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#ifndef USE_HOSTCC
> > +#include <cyclic.h>
> > +#endif /* USE_HOSTCC */
> > +#include <string.h>
> > +#include <u-boot/sha1.h>
> > +
> > +const u8 sha1_der_prefix[SHA1_DER_LEN] = {
> > +     0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
> > +     0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
> > +};
> > +
> > +void sha1_starts(sha1_context *ctx)
> > +{
> > +     mbedtls_sha1_init(ctx);
> > +     mbedtls_sha1_starts(ctx);
> > +}
> > +
> > +void sha1_update(sha1_context *ctx, const unsigned char *input,
> > +              unsigned int length)
> > +{
> > +     mbedtls_sha1_update(ctx, input, length);
> > +}
> > +
> > +void sha1_finish(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN])
> > +{
> > +     mbedtls_sha1_finish(ctx, output);
> > +     mbedtls_sha1_free(ctx);
> > +}
> > +
> > +void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
> > +               unsigned char *output, unsigned int chunk_sz)
> > +{
> > +     sha1_context ctx;
> > +
> > +     sha1_starts(&ctx);
> > +
> > +     if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG))
> {
> > +             const unsigned char *curr = input;
> > +             const unsigned char *end = input + ilen;
> > +             int chunk;
> > +
> > +             while (curr < end) {
> > +                     chunk = end - curr;
> > +                     if (chunk > chunk_sz)
> > +                             chunk = chunk_sz;
> > +                     sha1_update(&ctx, curr, chunk);
> > +                     curr += chunk;
> > +                     schedule();
> > +             }
> > +     } else {
> > +             sha1_update(&ctx, input, ilen);
> > +     }
> > +
> > +     sha1_finish(&ctx, output);
> > +}
> > +
> > +void sha1_hmac(const unsigned char *key, int keylen,
> > +            const unsigned char *input, unsigned int ilen,
> > +            unsigned char *output)
> > +{
> > +     int i;
> > +     sha1_context ctx;
> > +     unsigned char k_ipad[K_PAD_LEN];
> > +     unsigned char k_opad[K_PAD_LEN];
> > +     unsigned char tmpbuf[20];
> > +
> > +     if (keylen > K_PAD_LEN)
> > +             return;
> > +
> > +     memset(k_ipad, K_IPAD_VAL, sizeof(k_ipad));
> > +     memset(k_opad, K_OPAD_VAL, sizeof(k_opad));
> > +
> > +     for (i = 0; i < keylen; i++) {
> > +             k_ipad[i] ^= key[i];
> > +             k_opad[i] ^= key[i];
> > +     }
> > +
> > +     sha1_starts(&ctx);
> > +     sha1_update(&ctx, k_ipad, sizeof(k_ipad));
> > +     sha1_update(&ctx, input, ilen);
> > +     sha1_finish(&ctx, tmpbuf);
> > +
> > +     sha1_starts(&ctx);
> > +     sha1_update(&ctx, k_opad, sizeof(k_opad));
> > +     sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
> > +     sha1_finish(&ctx, output);
> > +
> > +     memset(k_ipad, 0, sizeof(k_ipad));
> > +     memset(k_opad, 0, sizeof(k_opad));
> > +     memset(tmpbuf, 0, sizeof(tmpbuf));
> > +     memset(&ctx, 0, sizeof(sha1_context));
> > +}
> > diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> > new file mode 100644
> > index 00000000000..24aa58fa674
> > --- /dev/null
> > +++ b/lib/mbedtls/sha256.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hash shim layer on MbedTLS Crypto library
> > + *
> > + * Copyright (c) 2024 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#ifndef USE_HOSTCC
> > +#include <cyclic.h>
> > +#endif /* USE_HOSTCC */
> > +#include <u-boot/sha256.h>
> > +
> > +const u8 sha256_der_prefix[SHA256_DER_LEN] = {
> > +     0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
> > +     0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> > +     0x00, 0x04, 0x20
> > +};
> > +
> > +void sha256_starts(sha256_context *ctx)
> > +{
> > +     mbedtls_sha256_init(ctx);
> > +     mbedtls_sha256_starts(ctx, 0);
> > +}
> > +
> > +void
> > +sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t
> length)
> > +{
> > +     mbedtls_sha256_update(ctx, input, length);
> > +}
> > +
> > +void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
> > +{
> > +     mbedtls_sha256_finish(ctx, digest);
> > +     mbedtls_sha256_free(ctx);
>
> Patch #7 treats this differently and looks at the mbedtls_sha256_finish()
> result (for all hashing algos). I think this one is correct and the other
> one needs fixing
>
> The difference is just due to different API prototypes to be ported - one
returns void while
the other returns int. According to this difference I decided to check the
result of
mbedtls_sha256_finish() or not.

[snip]

Regards,
Raymond
