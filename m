Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D6C31D97
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A101887FB;
	Wed,  3 Jul 2024 13:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8cSydOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F387888806; Wed,  3 Jul 2024 13:47:36 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839FA887EA
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c97ff39453so231044a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720007253; x=1720612053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YskHxdl9i+hZbdbIGrb3ZvjXLKeDU+ecdsh09jD2Ne8=;
 b=w8cSydOJqSa/5XhGqlfXivYjS4ReDsgOlGqYXIxVHa44q1nDqJNJhJIk0KiH8g7TZj
 9L1FYkhUG3+4W7T3JCIjGsM1nk9zoZEP1ssfAFOp7Aj6C2ddgLka1COwiVsXhtVs9MrY
 8OjUx18ifDSP/SXNV/KWtXdU1JmhBFA8wsRplqN4K2DOXFB08aoS0w86r7RiENPXhjcm
 o+HzFI1FWlcf8rqBOeLoqwZwyBR2W+8VN3a+r9yFSTmQ0zma5VTjMvXi3Pp54mvs01Hp
 nghxyTjzqW9Jmc2YpaGQYyqm93Uja/GkCQxg/U9X4+UF58dQBt6qYEvo7e4GW6L86tN+
 0Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720007253; x=1720612053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YskHxdl9i+hZbdbIGrb3ZvjXLKeDU+ecdsh09jD2Ne8=;
 b=jKWLHvIDKFEeiqTCVKd2dh1NCIFP1Ltb5barqkA47HSD9zBBgZOADNyOaNcvLLCpsB
 cWyTxFM2/7/bjSdgzbQsU0wfX06IvSd00VPntMU24vSUYnxlIh/IHzWo802+frWRPOCG
 HTgBjBU0i2e+LdHvLP/xNBAi0Gu+PCVniUYGO6sMQ6FRVm0SVzmYtfuHNr+MVWTncMqT
 S6anNC7uDin6fnqYTQVtN+GCdPWJQLbKSRy55QZAnzLlHMarQrDZoenQ0hYEV4Jzq91L
 4OwOCPWYyJwl1ex8aoWJcM26tAhyF14nFUtluesp2ECU6IBdbo+VSGpk8N9XpDWiw6VR
 1DEA==
X-Gm-Message-State: AOJu0YwTJtS0Nj5cOZnxMqK2vl7gZ+6GCkgWxc0gsLKp+YScq+t4HHBg
 eMEYdbWdd8zKOkIszDSTze391GQlGDXCy5c7jUOkN/CmVTQaOoRzfz3pq3ylJwDfJrzQUaBYJI6
 5awHtvDP3mAVsSffX8yZA7Dbhlvg1TDyl7BYH3Q==
X-Google-Smtp-Source: AGHT+IEomCuc0AOtQJE+4P+tWKfOgzOhEGPj9aROYjJP3i63WXWyu/PF2oGuGVMCVC4dQpr+Dvox2MCEI9dHForJcg4=
X-Received: by 2002:a17:90b:1bc5:b0:2bf:9566:7c58 with SMTP id
 98e67ed59e1d1-2c93d78e1c6mr8730039a91.41.1720007252702; Wed, 03 Jul 2024
 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-18-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-18-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 14:46:55 +0300
Message-ID: <CAC_iWjL6E+SNLGjzO3s7-8MJH4XjKyPeN3WkUjQrxFRrjfO_7A@mail.gmail.com>
Subject: Re: [PATCH v4 17/29] mbedtls: add public key porting layer
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
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On Tue, 2 Jul 2024 at 21:30, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add porting layer for public key on top of MbedTLS X509 library.
> Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
> MbedTLS implementations respectively.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - None.
> Changes in v4
> - Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
>   MbedTLS implementations respectively.
> - Move common functions to helper.
>
>  lib/mbedtls/Kconfig      | 50 ++++++++++++++++++++++++
>  lib/mbedtls/Makefile     |  7 +++-
>  lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 lib/mbedtls/public_key.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 0cdf0135667..6f29b0c81a2 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -122,9 +122,35 @@ endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
> +       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
>         help
>           Enable legacy certificate libraries.
>
> +if LEGACY_CRYPTO_CERT
> +
> +config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
> +       bool "Asymmetric public key crypto with legacy certificate library"
> +       depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       help
> +         This option chooses legacy certificate library for asymmetric public
> +         key crypto algorithm.
> +
> +if SPL
> +
> +config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY

subtype is either legacy or mbedTLS? If yes I think you can get rid of
it and have
SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY and ASYMMETRIC_PUBLIC_KEY_MBEDTLS

> +       bool "Asymmetric public key crypto with legacy certificate library in SPL"
> +       depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       help
> +         This option chooses legacy certificate library for asymmetric public
> +         key crypto algorithm in SPL.
> +
> +endif # SPL
> +
> +endif # LEGACY_CRYPTO_CERT
> +
>  endif # LEGACY_CRYPTO
>
>  if MBEDTLS_LIB
> @@ -232,7 +258,31 @@ endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
> +       select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL

Why do we have to select SPL here and in the Kconfig above for the
legacy option?

>         help
>           Enable MbedTLS certificate libraries.
>
> +if MBEDTLS_LIB_X509
> +
> +config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> +       bool "Asymmetric public key crypto with MbedTLS certificate library"
> +       help
> +         This option chooses MbedTLS certificate library for asymmetric public
> +         key crypto algorithm.
> +
> +if SPL
> +
> +config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> +       bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
> +       help
> +         This option chooses MbedTLS certificate library for asymmetric public
> +         key crypto algorithm in SPL.
> +
> +endif # SPL
> +
> +endif # MBEDTLS_LIB_X509
> +
>  endif # MBEDTLS_LIB
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 32a98b7f4ca..f06d0704502 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -20,6 +20,11 @@ hash_mbedtls-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
>  hash_mbedtls-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
>  hash_mbedtls-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
>
> +# x509 libraries
> +obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
> +x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
> +       public_key.o
> +
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y += \
> @@ -45,7 +50,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
>         $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pk.o \
>         $(MBEDTLS_LIB_DIR)/pk_wrap.o \
>         $(MBEDTLS_LIB_DIR)/pkparse.o
> diff --git a/lib/mbedtls/public_key.c b/lib/mbedtls/public_key.c
> new file mode 100644
> index 00000000000..076a61862cb
> --- /dev/null
> +++ b/lib/mbedtls/public_key.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Public key helper functions using MbedTLS X509 library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#include <linux/compat.h>
> +#include <crypto/public_key.h>
> +
> +int public_key_verify_signature(const struct public_key *pkey,
> +                               const struct public_key_signature *sig)
> +{
> +       mbedtls_md_type_t mb_hash_algo;
> +       mbedtls_pk_context pk_ctx;
> +       int ret;
> +
> +       if (!pkey || !sig || pkey->key_is_private)
> +               return -EINVAL;
> +
> +       /*
> +        * ECRDSA (Elliptic Curve RedDSA) from Red Hat is not supported by
> +        * MbedTLS
> +        */

That's not Redhat AFAICT. That's Elliptic Curve (Russian) Digital
Signature Algorithm described in GOST 34.10-2018, GOST R 34.10-2012,
RFC 7091, ISO/IEC 14888-3:2018

> +       if (strcmp(pkey->pkey_algo, "rsa")) {
> +               pr_err("Encryption is not RSA: %s\n", sig->pkey_algo);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Can be pkcs1 or raw, but pkcs1 is expected.
> +        * This is just for argument checking, not necessarily passed to MbedTLS,
> +        * For RSA signatures, MbedTLS typically supports the PKCS#1 v1.5
> +        * (aka. pkcs1) encoding by default.
> +        * The library internally handles the details of decoding and verifying
> +        * the signature according to the expected encoding for the specified algorithm.
> +        */
> +       if (strcmp(sig->encoding, "pkcs1")) {
> +               pr_err("Encoding %s is not supported, only supports pkcs1\n",
> +                      sig->encoding);
> +               return -EINVAL;
> +       }
> +
> +       if (!strcmp(sig->hash_algo, "sha1"))
> +               mb_hash_algo = MBEDTLS_MD_SHA1;
> +       else if (!strcmp(sig->hash_algo, "sha224"))
> +               mb_hash_algo = MBEDTLS_MD_SHA224;
> +       else if (!strcmp(sig->hash_algo, "sha256"))
> +               mb_hash_algo = MBEDTLS_MD_SHA256;
> +       else if (!strcmp(sig->hash_algo, "sha384"))
> +               mb_hash_algo = MBEDTLS_MD_SHA384;
> +       else if (!strcmp(sig->hash_algo, "sha512"))
> +               mb_hash_algo = MBEDTLS_MD_SHA512;
> +       else    /* Unknown or unsupported hash algorithm */
> +               return -EINVAL;
> +       /* Initialize the mbedtls_pk_context with RSA key type */
> +       mbedtls_pk_init(&pk_ctx);
> +
> +       /* Parse the DER-encoded public key */
> +       ret = mbedtls_pk_parse_public_key(&pk_ctx, pkey->key, pkey->keylen);
> +       if (ret) {
> +               pr_err("Failed to parse public key, ret:-0x%04x\n", -ret);
> +               ret = -EINVAL;
> +               goto err_key;
> +       }
> +
> +       /* Ensure that it is a RSA key */
> +       if (mbedtls_pk_get_type(&pk_ctx) != MBEDTLS_PK_RSA) {
> +               pr_err("Only RSA keys are supported\n");
> +               ret = -EKEYREJECTED;
> +               goto err_key;
> +       }
> +
> +       /* Verify the hash */
> +       ret = mbedtls_pk_verify(&pk_ctx, mb_hash_algo, sig->digest,
> +                               sig->digest_size, sig->s, sig->s_size);
> +
> +err_key:
> +       mbedtls_pk_free(&pk_ctx);
> +       return ret;
> +}
> --
> 2.25.1
>

Thanks
/Ilias
