Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF826C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 10:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F02D88498;
	Fri, 26 Jul 2024 12:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dkg2RvoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E1288418; Fri, 26 Jul 2024 12:19:38 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D34088496
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 12:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7aa7703cf08so656979a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721989174; x=1722593974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jBQJwW/+KLwCkk7RDUnCXJVdOQ1pRs0jZzaEipeyrdA=;
 b=Dkg2RvoDqf9ga9yNQufC2eaaGGV9RZ45yLATdGBCMDXvsVYhan1lSoCENHtP57tgoi
 7dO3Lxzh0k1t/am6+leBOiEiQbQ5B+j+5p/2rYFred7hyqF2oVLdqGWm2wvg837dyXPJ
 cbiwrJQF5IT29DGXa3//lfLvljEDZWTvA86ExWjmGhV9CZlNM+I+/gcsY5Wb3tlm3U7A
 Q+xHOdtx902jkKpCX9ih5aGjuat7/RNTxiFjFIhqdH+nXBfIQlwdad9FY6MmmpscI1Rg
 VKkPBdls9lGOvkd5GVhgp2Gnq6X8NkfMGpj9kVu8Se10yXgujGqk6hb2kvtAl+SQPF/+
 DYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721989174; x=1722593974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBQJwW/+KLwCkk7RDUnCXJVdOQ1pRs0jZzaEipeyrdA=;
 b=hlOttjsenPuDAon+9PneWFGpl55uOloeIwvVB/LG1pSEQBIGguBjl+xbaFe2MKVKo8
 7nQC+Riu2FStwfcZjljxCabqvTG/F37Dqeqk2zqrZM+MhPzKhUE7cbtmhcAtqMeNqC3T
 5U93kOC91DNOUhnIusBKSBvTwMxR0EFi/X3s9Db3mumGpD4sUW5M0HTAdg/MyAOBbnsZ
 B3y8IGQzZ3qWsCQTc6vCMeJwGcWBbIhEoniQ4G4cz8el3watxH7PEeFpskAjQ7xU9AsX
 tjBCjB4D1yotURXG59PUb0tgkZVTRANHbI4OiJfB0vzpPgmX3YG7yzVcl435xxHlfFwB
 ynHw==
X-Gm-Message-State: AOJu0YyEx2jPMkGFFRUohKhfi08/fvjblmQEQ8f8S9FBZMVxrkErs9Ce
 VnSbcEsO37QPPsRn7s/UQTD+ae+hBmJTZeU+zKKjlwLflVnN5Nlt7K47ceFh+2TPs2iTJWMAiJ/
 kK05UH1rOIlpHnqkN+PklPVu3uKK9uf/HXBgGBA==
X-Google-Smtp-Source: AGHT+IGTHXI1OT4zQkAUolhXe2ku8TIHZl+f3sPD3/jpygCkgQWaoLiViBrbS0eTJ5Jni9zFb/acNFlI1G1nwhFRYVA=
X-Received: by 2002:a17:90b:4b51:b0:2c9:a151:44fb with SMTP id
 98e67ed59e1d1-2cf237d73c2mr6594412a91.22.1721989173645; Fri, 26 Jul 2024
 03:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-8-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-8-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jul 2024 13:18:57 +0300
Message-ID: <CAC_iWjKxdyTg+HeALny9sMDhwKpcJ7peL=M_6jdivcWN884Shw@mail.gmail.com>
Subject: Re: [PATCH v4 07/29] mbedtls: add digest shim layer for MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
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

[...]

>
> +if MBEDTLS_LIB_CRYPTO
> +
> +config SHA1_MBEDTLS
> +       bool "Enable SHA1 support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with MbedTLS crypto library.
> +
> +config SHA256_MBEDTLS
> +       bool "Enable SHA256 support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with MbedTLS crypto library.
> +
> +config SHA512_MBEDTLS
> +       bool "Enable SHA512 support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SHA512
> +       default y if TI_SECURE_DEVICE && FIT_SIGNATURE

I don't like this default 'y' for 'ti secure devices'.  This is a
board specific option. I think it should be defined on the defconfig
of those boards instead.

> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with MbedTLS crypto library.
> +
> +config SHA384_MBEDTLS
> +       bool "Enable SHA384 support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SHA384
> +       select SHA512_MBEDTLS
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with MbedTLS crypto library.
> +
> +config MD5_MBEDTLS
> +       bool "Enable MD5 support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with MbedTLS crypto library.
> +
> +if SPL
> +
> +config SPL_SHA1_MBEDTLS
> +       bool "Enable SHA1 support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA1
> +       default y if SHA1 && MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with MbedTLS crypto library.
> +
> +config SPL_SHA256_MBEDTLS
> +       bool "Enable SHA256 support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA256
> +       default y if SHA256 && MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with MbedTLS crypto library.
> +
> +config SPL_SHA512_MBEDTLS
> +       bool "Enable SHA512 support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA512
> +       default y if SHA512 && MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with MbedTLS crypto library.
> +
> +config SPL_SHA384_MBEDTLS
> +       bool "Enable SHA384 support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA384
> +       default y if SHA384 && MBEDTLS_LIB_CRYPTO
> +       select SPL_SHA512
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with MbedTLS crypto library.
> +
> +config SPL_MD5_MBEDTLS
> +       bool "Enable MD5 support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO && SPL_MD5
> +       default y if MD5 && MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with MbedTLS crypto library.
> +
> +endif # SPL
> +
> +endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 803ea0b62a0..32a98b7f4ca 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -13,17 +13,24 @@ ccflags-y += \
>         -I$(src)/external/mbedtls/include \
>         -I$(src)/external/mbedtls/library
>
> +# shim layer for hash
> +obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += hash_mbedtls.o
> +hash_mbedtls-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
> +
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y += \
>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>         $(MBEDTLS_LIB_DIR)/constant_time.o \
>         $(MBEDTLS_LIB_DIR)/md.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha256.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha512.o
>
>  # MbedTLS X509 library
> diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
> new file mode 100644
> index 00000000000..04388fce249
> --- /dev/null
> +++ b/lib/mbedtls/md5.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include "compiler.h"
> +
> +#ifndef USE_HOSTCC
> +#include <watchdog.h>
> +#endif /* USE_HOSTCC */
> +#include <u-boot/md5.h>
> +
> +void MD5Init(MD5Context *ctx)
> +{
> +       mbedtls_md5_init(ctx);
> +       mbedtls_md5_starts(ctx);
> +}
> +
> +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
> +{
> +       mbedtls_md5_update(ctx, buf, len);
> +}
> +
> +void MD5Final(unsigned char digest[16], MD5Context *ctx)
> +{
> +       mbedtls_md5_finish(ctx, digest);
> +       mbedtls_md5_free(ctx);
> +}
> +
> +void md5_wd(const unsigned char *input, unsigned int len,
> +           unsigned char output[16], unsigned int chunk_sz)
> +{
> +       MD5Context context;
> +
> +       MD5Init(&context);
> +
> +       if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +               const unsigned char *curr = input;
> +               const unsigned char *end = input + len;
> +               int chunk;
> +
> +               while (curr < end) {
> +                       chunk = end - curr;
> +                       if (chunk > chunk_sz)
> +                               chunk = chunk_sz;
> +                       MD5Update(&context, curr, chunk);
> +                       curr += chunk;
> +                       schedule();
> +               }
> +       } else {
> +               MD5Update(&context, input, len);
> +       }

You can probably split this part to a function, that takes the hashing
algo as an argument, since the loop is identical for md5, sha1, sha256
etc


> +
> +       MD5Final(output, &context);
> +}
> diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
> new file mode 100644
> index 00000000000..2aee5037795
> --- /dev/null
> +++ b/lib/mbedtls/sha1.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef USE_HOSTCC
> +#include <cyclic.h>
> +#endif /* USE_HOSTCC */
> +#include <string.h>
> +#include <u-boot/sha1.h>
> +
> +const u8 sha1_der_prefix[SHA1_DER_LEN] = {
> +       0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
> +       0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
> +};
> +
> +void sha1_starts(sha1_context *ctx)
> +{
> +       mbedtls_sha1_init(ctx);
> +       mbedtls_sha1_starts(ctx);
> +}
> +
> +void sha1_update(sha1_context *ctx, const unsigned char *input,
> +                unsigned int length)
> +{
> +       mbedtls_sha1_update(ctx, input, length);
> +}
> +
> +void sha1_finish(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN])
> +{
> +       mbedtls_sha1_finish(ctx, output);
> +       mbedtls_sha1_free(ctx);
> +}
> +
> +void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
> +                 unsigned char *output, unsigned int chunk_sz)
> +{
> +       sha1_context ctx;
> +
> +       sha1_starts(&ctx);
> +
> +       if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +               const unsigned char *curr = input;
> +               const unsigned char *end = input + ilen;
> +               int chunk;
> +
> +               while (curr < end) {
> +                       chunk = end - curr;
> +                       if (chunk > chunk_sz)
> +                               chunk = chunk_sz;
> +                       sha1_update(&ctx, curr, chunk);
> +                       curr += chunk;
> +                       schedule();
> +               }
> +       } else {
> +               sha1_update(&ctx, input, ilen);
> +       }
> +
> +       sha1_finish(&ctx, output);
> +}
> +
> +void sha1_hmac(const unsigned char *key, int keylen,
> +              const unsigned char *input, unsigned int ilen,
> +              unsigned char *output)
> +{
> +       int i;
> +       sha1_context ctx;
> +       unsigned char k_ipad[K_PAD_LEN];
> +       unsigned char k_opad[K_PAD_LEN];
> +       unsigned char tmpbuf[20];
> +
> +       if (keylen > K_PAD_LEN)
> +               return;
> +
> +       memset(k_ipad, K_IPAD_VAL, sizeof(k_ipad));
> +       memset(k_opad, K_OPAD_VAL, sizeof(k_opad));
> +
> +       for (i = 0; i < keylen; i++) {
> +               k_ipad[i] ^= key[i];
> +               k_opad[i] ^= key[i];
> +       }
> +
> +       sha1_starts(&ctx);
> +       sha1_update(&ctx, k_ipad, sizeof(k_ipad));
> +       sha1_update(&ctx, input, ilen);
> +       sha1_finish(&ctx, tmpbuf);
> +
> +       sha1_starts(&ctx);
> +       sha1_update(&ctx, k_opad, sizeof(k_opad));
> +       sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
> +       sha1_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, sizeof(k_ipad));
> +       memset(k_opad, 0, sizeof(k_opad));
> +       memset(tmpbuf, 0, sizeof(tmpbuf));
> +       memset(&ctx, 0, sizeof(sha1_context));
> +}
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> new file mode 100644
> index 00000000000..24aa58fa674
> --- /dev/null
> +++ b/lib/mbedtls/sha256.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef USE_HOSTCC
> +#include <cyclic.h>
> +#endif /* USE_HOSTCC */
> +#include <u-boot/sha256.h>
> +
> +const u8 sha256_der_prefix[SHA256_DER_LEN] = {
> +       0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
> +       0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> +       0x00, 0x04, 0x20
> +};
> +
> +void sha256_starts(sha256_context *ctx)
> +{
> +       mbedtls_sha256_init(ctx);
> +       mbedtls_sha256_starts(ctx, 0);
> +}
> +
> +void
> +sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length)
> +{
> +       mbedtls_sha256_update(ctx, input, length);
> +}
> +
> +void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
> +{
> +       mbedtls_sha256_finish(ctx, digest);
> +       mbedtls_sha256_free(ctx);
> +}
> +
> +void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> +                   unsigned char *output, unsigned int chunk_sz)
> +{
> +       sha256_context ctx;
> +
> +       sha256_starts(&ctx);
> +
> +       if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +               const unsigned char *curr = input;
> +               const unsigned char *end = input + ilen;
> +               int chunk;
> +
> +               while (curr < end) {
> +                       chunk = end - curr;
> +                       if (chunk > chunk_sz)
> +                               chunk = chunk_sz;
> +                       sha256_update(&ctx, curr, chunk);
> +                       curr += chunk;
> +                       schedule();
> +               }
> +       } else {
> +               sha256_update(&ctx, input, ilen);
> +       }
> +
> +       sha256_finish(&ctx, output);
> +}
> diff --git a/lib/mbedtls/sha512.c b/lib/mbedtls/sha512.c
> new file mode 100644
> index 00000000000..5615248cb91
> --- /dev/null
> +++ b/lib/mbedtls/sha512.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef USE_HOSTCC
> +#include <cyclic.h>
> +#endif /* USE_HOSTCC */
> +#include <compiler.h>
> +#include <u-boot/sha512.h>
> +
> +const u8 sha384_der_prefix[SHA384_DER_LEN] = {
> +       0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
> +       0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
> +       0x00, 0x04, 0x30
> +};
> +
> +const u8 sha512_der_prefix[SHA512_DER_LEN] = {
> +       0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
> +       0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
> +       0x00, 0x04, 0x40
> +};
> +
> +void sha384_starts(sha512_context *ctx)
> +{
> +       mbedtls_sha512_init(ctx);
> +       mbedtls_sha512_starts(ctx, 1);
> +}
> +
> +void
> +sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length)
> +{
> +       mbedtls_sha512_update(ctx, input, length);
> +}
> +
> +void sha384_finish(sha512_context *ctx, uint8_t digest[SHA384_SUM_LEN])
> +{
> +       mbedtls_sha512_finish(ctx, digest);
> +       mbedtls_sha512_free(ctx);
> +}
> +
> +void sha384_csum_wd(const unsigned char *input, unsigned int length,
> +                   unsigned char *output, unsigned int chunk_sz)
> +{
> +       mbedtls_sha512(input, length, output, 1);
> +}
> +
> +void sha512_starts(sha512_context *ctx)
> +{
> +       mbedtls_sha512_init(ctx);
> +       mbedtls_sha512_starts(ctx, 0);
> +}
> +
> +void
> +sha512_update(sha512_context *ctx, const uint8_t *input, uint32_t length)
> +{
> +       mbedtls_sha512_update(ctx, input, length);
> +}
> +
> +void sha512_finish(sha512_context *ctx, uint8_t digest[SHA512_SUM_LEN])
> +{
> +       mbedtls_sha512_finish(ctx, digest);
> +       mbedtls_sha512_free(ctx);
> +}
> +
> +void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
> +                   unsigned char *output, unsigned int chunk_sz)
> +{
> +       sha512_context ctx;
> +
> +       sha512_starts(&ctx);
> +
> +       if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +               const unsigned char *curr = input;
> +               const unsigned char *end = input + ilen;
> +               int chunk;
> +
> +               while (curr < end) {
> +                       chunk = end - curr;
> +                       if (chunk > chunk_sz)
> +                               chunk = chunk_sz;
> +                       sha512_update(&ctx, curr, chunk);
> +                       curr += chunk;
> +                       schedule();
> +               }
> +       } else {
> +               sha512_update(&ctx, input, ilen);
> +       }
> +
> +       sha512_finish(&ctx, output);
> +}
> --
> 2.25.1
>
