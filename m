Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD41EC54E93
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FF488AB9;
	Wed, 28 Aug 2024 12:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgaDPgX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBCB88AB9; Wed, 28 Aug 2024 12:29:32 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39168884F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-201fba05363so55434965ad.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724840968; x=1725445768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z59HF5zNLWCqj1M/GFbB8UkLuyA93agEtd5WumNmY9s=;
 b=RgaDPgX+kCrNBjGJ54W8pWYZ+/6APEx4JNHh8qTqIug65xPQY+bmIKDTlCjIkUGfCY
 /dcjCh5Op61TWy+LrOXZK9U9NsKW930Wtvu9z5jrW3DybOlNCDkRyruhqboLEC41uWks
 JrGtdQ3ED8GrKYN3zh+bkOa2B8cqjgsr4iGk5iejnbWku8jDLWxdkPxt8dkvHOxjpH4v
 FilsKIxK65B7RvsjCAOJlaw3nvoNI/Pbzg1aQInRNNWTj/8u8rZqXF0sx0nYQsTif8QI
 W/hYB30dZnorCHHLgKnwN8GVTzRTHTEsgINBUJ3RgOZnAXSDBCqLA6pnuryjCea7ZoJF
 538Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724840968; x=1725445768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z59HF5zNLWCqj1M/GFbB8UkLuyA93agEtd5WumNmY9s=;
 b=LuHEAEgwlSbpPcLersRa3zZN97PEALUC+X+A9GXrKMQ1Vyat88LXw811ktJqHrGOeX
 cGJHQWaU6bx0e0wWDOH28sRWMOHkKZFQxghURo7lcqPmjliMHGJHKCGms4CEhca9pO1D
 0RYnwBQIT6Fh1g6wQDQme+LMtv1B0jaBlvPjm46scGg2glLdYhIxcFzC1lLEV7AQ+TZ0
 fz9phNEYwgtIainRDXaeSxvksQPFbGuiLBhuusMFbPco5MFsDz8IxAVVSnDaOCGtTvsl
 JLBISdBXcP6BPwxa1KR1pGiWYReIhMNP1x9q7ESi9Zf2ZBVNHznaGl0bNxZaCW5uFWb3
 vZmA==
X-Gm-Message-State: AOJu0Ywg43E8C63DJkKzAVkjTcVvFep5D2o7YXSkwZZm5IWZgS66Qv0f
 2eodhtEn1g289drqfSQnFzn+cCcJ3TkkkxYd2dcBzDBLeUgcSPpQJ+A9jUxdztyzFWLJMCmjPJ1
 J4jN71OjEH7+ebACCmjZ268TrnWpFSH4mTJiIrw==
X-Google-Smtp-Source: AGHT+IEKKqxBCTXD7234SluBhTsypyfv02ydCZqwvw5NnghNoqTJCGq92HJBd9pmS8rPiUdRsgbVe9YxhmD/H0tRhtA=
X-Received: by 2002:a17:902:e881:b0:202:3bae:9718 with SMTP id
 d9443c01a7336-204f9b61ca8mr16511335ad.15.1724840968067; Wed, 28 Aug 2024
 03:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-25-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-25-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 13:28:51 +0300
Message-ID: <CAC_iWj+cfaxQGMrinfeBOyf1QjXG+jdLwMzfkQyjnyOyEp4h5g@mail.gmail.com>
Subject: Re: [PATCH v6 24/28] mbedtls: add RSA helper layer on MbedTLS
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

On Sat, 17 Aug 2024 at 00:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add RSA helper layer on top on MbedTLS PK and RSA library.
> Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
> MbedTLS implementations respectively.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
> Changes in v4
> - Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
>   MbedTLS implementations respectively.
> - Remove unnecessary type casting.
> Changes in v5
> - Correct header file include directories.
> - Correct kconfig dependence.
> - Kconfig rename.
> - Refactored MbedTLS makefile.
> Changes in v6
> - None.
>
>  lib/mbedtls/Kconfig      | 36 +++++++++++++++
>  lib/mbedtls/Makefile     |  3 +-
>  lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 lib/mbedtls/rsa_helper.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index ecdf4d3008f..797da0df938 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -119,11 +119,13 @@ config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
>         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_LEGACY if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
>         help
>           Enable legacy certificate libraries.
>
> @@ -136,6 +138,14 @@ config ASYMMETRIC_PUBLIC_KEY_LEGACY
>           This option chooses legacy certificate library for asymmetric public
>           key crypto algorithm.
>
> +config RSA_PUBLIC_KEY_PARSER_LEGACY
> +       bool "RSA public key parser with legacy certificate library"
> +       depends on ASYMMETRIC_PUBLIC_KEY_LEGACY
> +       select ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for RSA public key
> +         parser.
> +
>  config X509_CERTIFICATE_PARSER_LEGACY
>         bool "X.509 certificate parser with legacy certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_LEGACY
> @@ -169,6 +179,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
>           This option chooses legacy certificate library for asymmetric public
>           key crypto algorithm in SPL.
>
> +config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
> +       bool "RSA public key parser with legacy certificate library in SPL"
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> +       select SPL_ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for RSA public key
> +         parser in SPL.
> +
>  endif # SPL
>
>  endif # LEGACY_CRYPTO_CERT
> @@ -301,11 +319,13 @@ config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
>         select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
>         help
>           Enable MbedTLS certificate libraries.
>
> @@ -318,6 +338,14 @@ config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>           This option chooses MbedTLS certificate library for asymmetric public
>           key crypto algorithm.
>
> +config RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       bool "RSA public key parser with MbedTLS certificate library"
> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       select ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for RSA public key
> +         parser.
> +
>  config X509_CERTIFICATE_PARSER_MBEDTLS
>         bool "X.509 certificate parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> @@ -351,6 +379,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>           This option chooses MbedTLS certificate library for asymmetric public
>           key crypto algorithm in SPL.
>
> +config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       bool "RSA public key parser with MbedTLS certificate library in SPL"
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       select SPL_ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for RSA public key
> +         parser in SPL.
> +
>  endif # SPL
>
>  endif # MBEDTLS_LIB_X509
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 83333b1b6a5..40031994708 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
>  obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
>  obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
> +obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
>
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> @@ -39,7 +40,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/bignum.o \
>         $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
> diff --git a/lib/mbedtls/rsa_helper.c b/lib/mbedtls/rsa_helper.c
> new file mode 100644
> index 00000000000..3d94eee9954
> --- /dev/null
> +++ b/lib/mbedtls/rsa_helper.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RSA helper functions using MbedTLS
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#include <linux/err.h>
> +#include <crypto/internal/rsa.h>
> +#include <library/common.h>
> +#include <mbedtls/pk.h>
> +#include <mbedtls/rsa.h>
> +#include <mbedtls/asn1.h>
> +
> +/**
> + * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in the
> + *                       provided struct rsa_key, pointers to the raw key as is,
> + *                       so that the caller can copy it or MPI parse it, etc.
> + *
> + * @rsa_key:   struct rsa_key key representation
> + * @key:       key in BER format
> + * @key_len:   length of key
> + *
> + * Return:     0 on success or error code in case of error
> + */
> +int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
> +                     unsigned int key_len)
> +{
> +       int ret = 0;
> +       mbedtls_pk_context pk;
> +       mbedtls_rsa_context *rsa;
> +
> +       mbedtls_pk_init(&pk);
> +
> +       ret = mbedtls_pk_parse_public_key(&pk, (const unsigned char *)key,
> +                                         key_len);
> +       if (ret) {
> +               pr_err("Failed to parse public key, ret:-0x%04x\n", -ret);
> +               ret = -EINVAL;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Ensure that it is a RSA key */
> +       if (mbedtls_pk_get_type(&pk) != MBEDTLS_PK_RSA) {
> +               pr_err("Non-RSA keys are not supported\n");
> +               ret = -EKEYREJECTED;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Get RSA key context */
> +       rsa = mbedtls_pk_rsa(pk);
> +       if (!rsa) {
> +               pr_err("Failed to get RSA key context, ret:-0x%04x\n", -ret);
> +               ret = -EINVAL;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Parse modulus (n) */
> +       rsa_key->n_sz = mbedtls_mpi_size(&rsa->N);
> +       rsa_key->n = kzalloc(rsa_key->n_sz, GFP_KERNEL);
> +       if (!rsa_key->n) {
> +               ret = -ENOMEM;
> +               goto clean_pubkey;
> +       }
> +       ret = mbedtls_mpi_write_binary(&rsa->N, (unsigned char *)rsa_key->n,
> +                                      rsa_key->n_sz);
> +       if (ret) {
> +               pr_err("Failed to parse modulus (n), ret:-0x%04x\n", -ret);
> +               ret = -EINVAL;
> +               goto clean_modulus;
> +       }
> +
> +       /* Parse public exponent (e) */
> +       rsa_key->e_sz = mbedtls_mpi_size(&rsa->E);
> +       rsa_key->e = kzalloc(rsa_key->e_sz, GFP_KERNEL);
> +       if (!rsa_key->e) {
> +               ret = -ENOMEM;
> +               goto clean_modulus;
> +       }
> +       ret = mbedtls_mpi_write_binary(&rsa->E, (unsigned char *)rsa_key->e,
> +                                      rsa_key->e_sz);
> +       if (!ret)
> +               return 0;
> +
> +       pr_err("Failed to parse public exponent (e), ret:-0x%04x\n", -ret);
> +       ret = -EINVAL;
> +
> +       kfree(rsa_key->e);
> +clean_modulus:
> +       kfree(rsa_key->n);
> +clean_pubkey:
> +       mbedtls_pk_free(&pk);
> +       return ret;
> +}
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
