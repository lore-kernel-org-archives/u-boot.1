Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA840C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 08:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3237A88276;
	Tue, 30 Jul 2024 10:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qHJdw67j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844D188607; Tue, 30 Jul 2024 10:05:34 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DCE88247
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 10:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so2576722a91.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722326730; x=1722931530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdFbcEUZGtHq6v3Hkq9bxCh8fRt9vp87IV+dXKdmbqo=;
 b=qHJdw67jfugsyzDt6vhTMyr+TirLfb1gehWnbEv1xj+jxhDGRXVJ1LLDBkZrU5akWV
 CwU2IYmJzLcIL7CrkzAsLlyZn4kqVYNrW+s8axWZacgu6aMdc7BlCbJnSubfbDqzZqKs
 flGPuMiEAfY7qJDyHP6jg1cATwkMeznJ0ZNQzl9i+gUhSphuvDJAMs3yW3sTH8P/JUbf
 t5sqLrlKndegVom7I+FCaPsHLRE5nyuJQN278SUAudsZ1yb+ZfK+9DNaTbqlA3AhfHHB
 UkDZlrl5e4L2Xu2jVj/LsHtWVaJvHeco3eK2TcJaXn2n0kmWF13owCORL5ErmzBqlvOa
 AHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722326730; x=1722931530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdFbcEUZGtHq6v3Hkq9bxCh8fRt9vp87IV+dXKdmbqo=;
 b=NhaX39i2ZA9Dzc/OprbdPNRCJDIAE/ZST3U9vPNt/BG5/9KTXQDQ6KLHeSR2PagfIg
 t/1YXB1sJXN92EXIH2IcWSbMi9f7r4K/gWe3JETOE9RpVQXCDfLNAX7ryRhlKbvE0vwA
 C8/2pHcG/dsyehalx6vEDVN+VBF2yba3B03CPP9Uk1L9wAaYg+pz9sUpxAlG+1U79ACs
 2DgXwcVya+MDcHny89SqtozzkzF1ulb0iPucqSJwEOvef3p8Cw5+j9Docq55ijRxESuh
 Lldm/saCXYf74VKSzVvICoM0O0c3jckIUFlSfDBRrdlnNH5anxu5C/wmbloPOTebEzH2
 /IMw==
X-Gm-Message-State: AOJu0YzLof/5kMsG1AAJRw+Wo8jdwFudZOq4a/Z9TkbW0W06/UeX7vTQ
 2pjD2PBwgjMpwof10ckJsYsI9++pm+QVMnurBbBpbPbC6hOnlxZO9aUMHV1MN/qVwn3Y4u6AFgG
 wNq8xY1pYOfYxOsVV3v3vJCZ4Afx9mPWWiQz9NfqcRO0Nv5gePs0=
X-Google-Smtp-Source: AGHT+IEXyU80iVEXYJkwc12g3yq5nbYSi0UPyiSzN8sjMrwEpC2An4C/qmXwf65kIcznd76uc1IOkAgJEoql1IF8wJU=
X-Received: by 2002:a17:90a:7447:b0:2cc:f538:7cf0 with SMTP id
 98e67ed59e1d1-2cf7e098498mr8362742a91.4.1722326730266; Tue, 30 Jul 2024
 01:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-26-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-26-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jul 2024 11:04:54 +0300
Message-ID: <CAC_iWjJtLb9N8sYn2qczTeLYdeuN-uZvjNGGf4KsD2Ks3uB1OA@mail.gmail.com>
Subject: Re: [PATCH v4 25/29] mbedtls: add RSA helper layer on MbedTLS
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
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Manorit Chawdhry <m-chawdhry@ti.com>, 
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

Hi Raymond


On Tue, 2 Jul 2024 at 21:33, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> - Minor fix of the include directories.
>
>  lib/mbedtls/Kconfig      | 36 +++++++++++++++
>  lib/mbedtls/Makefile     |  3 +-
>  lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 lib/mbedtls/rsa_helper.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index d8a8f87e031..87c500d6ca9 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -124,11 +124,13 @@ config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
>         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_LEGACY if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
> +       select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER && SPL

SPL shouldn't be selected. IIRC we discussed the same thing on another
patch, so I assume this is fixed already?

Cheers
/Ilias
>         help
>           Enable legacy certificate libraries.
>
> @@ -141,6 +143,14 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
>           This option chooses legacy certificate library for asymmetric public
>           key crypto algorithm.
>
> +config RSA_PUBLIC_KEY_PARSER_LEGACY
> +       bool "RSA public key parser with legacy certificate library"
> +       depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
> +       select ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for RSA public key
> +         parser.
> +
>  config X509_CERTIFICATE_PARSER_LEGACY
>         bool "X.509 certificate parser with legacy certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
> @@ -174,6 +184,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
>           This option chooses legacy certificate library for asymmetric public
>           key crypto algorithm in SPL.
>
> +config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
> +       bool "RSA public key parser with legacy certificate library in SPL"
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
> +       select SPL_ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for RSA public key
> +         parser in SPL.
> +
>  endif # SPL
>
>  endif # LEGACY_CRYPTO_CERT
> @@ -287,11 +305,13 @@ config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
>         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
> +       select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER && SPL
>         help
>           Enable MbedTLS certificate libraries.
>
> @@ -303,6 +323,14 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
>           This option chooses MbedTLS certificate library for asymmetric public
>           key crypto algorithm.
>
> +config RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       bool "RSA public key parser with MbedTLS certificate library"
> +       depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> +       select ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for RSA public key
> +         parser.
> +
>  config X509_CERTIFICATE_PARSER_MBEDTLS
>         bool "X.509 certificate parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> @@ -334,6 +362,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
>           This option chooses MbedTLS certificate library for asymmetric public
>           key crypto algorithm in SPL.
>
> +config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       bool "RSA public key parser with MbedTLS certificate library in SPL"
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> +       select SPL_ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for RSA public key
> +         parser in SPL.
> +
>  endif # SPL
>
>  endif # MBEDTLS_LIB_X509
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index ac7c487449d..9c6991f8783 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -28,6 +28,7 @@ x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
>  x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
>  x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
> +x509_mbedtls-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
>
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> @@ -49,7 +50,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
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
