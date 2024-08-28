Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0647C54FAA
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14B8889B3;
	Wed, 28 Aug 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q0NQ+gC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8589B88A7B; Wed, 28 Aug 2024 12:27:46 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C588884F
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2020b730049so51603705ad.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724840862; x=1725445662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3WdClCwS/bPcchkK40Pu76Nx20aaegAneUg4hKPU9M=;
 b=Q0NQ+gC3gwrcUy+OBj7L+JQmzJMukkfFN25orbra1neHE3xhUNS2Ot00PJUAiVL0Vt
 BLroqqE3Jo9IjnptrdzrhSkuND7GHkjYfqKb+XMyleQcoqPnhqFD9eR+vRIDjfD3Bb2V
 yMA49xD7lIPYxMRS3wZmVzCXQbs3frKMzslKEyvY34D8k27XEwF8SZzl+/w7WPoZ4f5F
 eUugOxbfLPuLKeo/g77NDaCWwFkeyIwS27+LvYzO6kpc4P0nIZ6pBrhGH8aALSIqdghf
 aD3kGG+oJd+QmhXdf+TYfdSS+YIePu4AernTDEwCD128UPt9hr7KYTpOHgAQMOq8eG4o
 IGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724840862; x=1725445662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/3WdClCwS/bPcchkK40Pu76Nx20aaegAneUg4hKPU9M=;
 b=bxkP1LvK1tlytGlCPo6/JWHy3tp88FhHXBdbQHEt1QCg3tmccv2gZxUxE8Fm06hc9R
 qzJ2tyLx9aFYR0TYA5DOpEvq83GT7v0ylhq1/t6Xcz+zNjlwJf2Rbse02c7VMdNxa9FI
 MVQ3Ly7N8HMWriw0Msv/DwbZi54s7YCzQ4qMK1zMMbZBnTHq7vl7jnUcAI4FQXifhX8e
 DZ6GhCfu3ts88Nl+qNcSKVvdP2G/UAFViB/QjO8j5V/R5AOaRyhjsDxaNvaPgZIKdUL3
 rKIt5sc/eFesqqT+60fxYUbwf40ZIs9LhD1rprsXGk+zme4Yzjlv/pmEFHndzl0BKehv
 MtvQ==
X-Gm-Message-State: AOJu0YzcbIO74hpIyqnsn+5FAcbDsJAiUia986vJacfMgwfKnzH+PE6r
 hiCjmKlVpaEpNhukaICKCNqYabYsmJNln4BD/xKaoTUhZlKeEFsY2g9hKLqPlbnzva1Wf3GEKHR
 fOrBZ0jhvDzeyGM8kGtLI0uM3ANjwKYYHjKs4SQ==
X-Google-Smtp-Source: AGHT+IHXzugRc5J6eMcv3uXysb6d2I4+kLAAWiIXcdh6j+/qvJCpujOF0KRLiFijCC/5QKKkYCLAtv3nj2ZBe2P3Z2E=
X-Received: by 2002:a17:902:f647:b0:1fc:369b:c1dd with SMTP id
 d9443c01a7336-2039e44ee47mr157427605ad.6.1724840862286; Wed, 28 Aug 2024
 03:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-17-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-17-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 13:27:06 +0300
Message-ID: <CAC_iWj+mef-_Ox_cbcs=iWc0o-q0F82Kam0_oYr90s5m8L0ZpA@mail.gmail.com>
Subject: Re: [PATCH v6 16/28] mbedtls: add public key porting layer
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
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Aug 2024 14:49:25 +0200
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

On Sat, 17 Aug 2024 at 00:51, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> Changes in v5
> - Correct kconfig dependence.
> - Kconfig rename.
> - Refactored MbedTLS makefile.
> - Adjust a few inline comments.
> Changes in v6
> - None.
>
>  lib/mbedtls/Kconfig      | 52 +++++++++++++++++++++++++
>  lib/mbedtls/Makefile     |  6 ++-
>  lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 1 deletion(-)
>  create mode 100644 lib/mbedtls/public_key.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 0e22edf1b6c..dbbcdba8bc6 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -117,9 +117,35 @@ endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
> +       select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> +               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
>           Enable legacy certificate libraries.
>
> +if LEGACY_CRYPTO_CERT
> +
> +config ASYMMETRIC_PUBLIC_KEY_LEGACY
> +       bool "Asymmetric public key crypto with legacy certificate library"
> +       depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       help
> +         This option chooses legacy certificate library for asymmetric public
> +         key crypto algorithm.
> +
> +if SPL
> +
> +config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
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
> @@ -246,7 +272,33 @@ endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
> +       select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
> +               ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
> +               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
>           Enable MbedTLS certificate libraries.
>
> +if MBEDTLS_LIB_X509
> +
> +config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       bool "Asymmetric public key crypto with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       help
> +         This option chooses MbedTLS certificate library for asymmetric public
> +         key crypto algorithm.
> +
> +if SPL
> +
> +config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
> +       depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
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
> index 50c1ba5f88e..2d2220dd4fd 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -11,6 +11,10 @@ obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
>  obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
>  obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
>
> +# x509 libraries
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
> +       public_key.o
> +
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
> @@ -36,7 +40,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
>         $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pk.o \
>         $(MBEDTLS_LIB_DIR)/pk_wrap.o \
>         $(MBEDTLS_LIB_DIR)/pkparse.o
> diff --git a/lib/mbedtls/public_key.c b/lib/mbedtls/public_key.c
> new file mode 100644
> index 00000000000..5f73b99d4f2
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
> +        * ECRDSA (Elliptic Curve Russian Digital Signature Algorithm) is not
> +        * supported by MbedTLS.
> +        */
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
