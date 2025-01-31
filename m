Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C92C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 13:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E5D80F95;
	Fri, 31 Jan 2025 14:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bhN/961B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37080F9C; Fri, 31 Jan 2025 14:52:09 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01DD80F92
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so2468335276.3
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738331525; x=1738936325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4dwKnzLUrPC9joG93j9LIIuxz56+W1TCC/O5zH1A+c4=;
 b=bhN/961BdCWtDP2GsQQubxE4+l4XtSAw1z+lsVd3h0HeN1Xarh8jMvigMr3zomR4tE
 Rubfz4E2RB5qkCOAZjC2uuGxYBdPmzU61/8Dq3ZSUMAZGrBeVkqCsNxZhihpiFe24PYO
 op24PZy7p7RUu6httKAmBavkDfcoD+wq+OHmMBfPXziDMyUxvY8Qf7bX0Z4SGU9Cb+0k
 RAjyne+gc7fJtzJgwbbG7sbsIYLkTDZyR1BzA2eG0UrN0XiXGr5+HTlIe1Xd1jHBPVtz
 wT/Sdio1UmvBx9J75KlgWucbcM/ciN8b35YdlbZqzCXqG1/+u6iPC1miudVPvaFwPr33
 /2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738331525; x=1738936325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4dwKnzLUrPC9joG93j9LIIuxz56+W1TCC/O5zH1A+c4=;
 b=BYkZhQUX1Cbc1sVXc9PjVinYD8OFZlHehY0tSg+6pncextXE/cO2rYjzuULJMDJNmV
 sWXhmK4OqYJMTutd4wSDiSu4Gj5pvQ3KsAs595CUaBIqgUNp0kX1/x8cak1dkFuonm9d
 je1AC/AaLbZI0JRlNbQmIWPBwxv24nAZfByfl3s8PHXV/MSrW6EpmJ9+XE2EBKxh9p39
 S5ru2uJODdOZpAHU+AMnvzbqxYr2K8duQCLd5I8rXPLWaHRp3vpMAqocaZOX/rd8VyG8
 P+3V/tspN1oh31v4Gdsg6de3RY5eNY9xK6nYtzMaXhkC/JlicCppivkdjmJ/jIQ54cC8
 3HgA==
X-Gm-Message-State: AOJu0YzGIb5an018Q3hLaPCr7VJDgahNoKQblRk2P0/oZ4fpk3ybw+BT
 OJMotjUWGYiBoZ1Cf0TsQnoATzks2A/tqwPS/gNQCtx6xlclDGnPnP8MLcxP+sAGwBjWsLwjak/
 Cn+VjwCdiZHqFVLRpI+xefikaTXVCs/qqbD0DEw==
X-Gm-Gg: ASbGncvXdOJkFi1jaDQFiacgvuFnL1T6/uJcQA9v2f8UpySIfdrN8xcFrnGBCJiC+4h
 toOV2N9NYfIisnA4tQU+UAnwQbFlasBYViIi4MjSTQ0mAo5CAH61nhs0cWJTzCamBGxM/uoeH
X-Google-Smtp-Source: AGHT+IF+Q+3wQQ7B7adH/vtOvvsExaSlEWiVStFqAG1GiOvgtDCelaMxS5Wl5q/UK/Y+As+jZTuyklvZTLe06iq4Aho=
X-Received: by 2002:a05:6902:2601:b0:e58:183e:90dc with SMTP id
 3f1490d57ef6-e58a4aa8c62mr9036865276.9.1738331525308; Fri, 31 Jan 2025
 05:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
 <20250127151657.648255-3-raymond.mao@linaro.org>
In-Reply-To: <20250127151657.648255-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jan 2025 15:51:29 +0200
X-Gm-Features: AWEUYZk63yZTgy8xhjulSZoWJXiSBiVuyHnF_vdE-3-kxvxQkKskUITlzQKQW3k
Message-ID: <CAC_iWjK+RkdSO_WVF327fxdVWuEGEFEeGjABKFix0RX8z_g1ow@mail.gmail.com>
Subject: Re: [PATCH 3/3] mbedtls: refactor mbedtls build for XPL
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

Hi Raymond, Tom

This config seems reasonable to me and we can now build a combination
of SPL + older crypto + mbedTLS for u-boot proper which was always the
goal.

I do still think the naming is a bit confusing.

On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Refactor the entire kconfig page for mbedtls, adapt mbedtls makefile
> and default config file using 'XPL_', in order to have independent
> mbedtls kconfig options in both U-Boot Proper and SPL.
> User can choose legacy or mbedtls libraries in SPL independently.
>
> Set mbedtls native crypto libraries as default when MBEDTLS_LIB or
> SPL_MBEDTLS_LIB is selected.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  Makefile                         |   2 +-
>  lib/mbedtls/Kconfig              | 381 +++++++++++++++++++------------
>  lib/mbedtls/Makefile             |  44 ++--
>  lib/mbedtls/mbedtls_def_config.h |  37 +--
>  4 files changed, 276 insertions(+), 188 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5c6f467153c..406cd28595a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -829,7 +829,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>  UBOOTINCLUDE    := \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> -       $(if $(CONFIG_MBEDTLS_LIB), \
> +       $(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
>                 "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
>                 -I$(srctree)/lib/mbedtls \
>                 -I$(srctree)/lib/mbedtls/port \
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 17ed2bc71de..821d13a0dd2 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -1,3 +1,5 @@
> +# For U-Boot Proper
> +
>  choice
>         prompt "Select crypto libraries"

I'd remove the 'select here'.

So have a 'Crypto library' support only
and the SPL entry below should become
"SPL Crypto libraries"

>         default LEGACY_CRYPTO
> @@ -25,11 +27,6 @@ config LEGACY_CRYPTO_BASIC
>         select SHA256_LEGACY if SHA256
>         select SHA512_LEGACY if SHA512
>         select SHA384_LEGACY if SHA384
> -       select SPL_MD5_LEGACY if SPL_MD5
> -       select SPL_SHA1_LEGACY if SPL_SHA1
> -       select SPL_SHA256_LEGACY if SPL_SHA256
> -       select SPL_SHA512_LEGACY if SPL_SHA512
> -       select SPL_SHA384_LEGACY if SPL_SHA384
>         help
>           Enable legacy basic crypto libraries.
>
> @@ -72,46 +69,6 @@ config MD5_LEGACY
>           This option enables support of hashing using MD5 algorithm
>           with legacy crypto library.
>
> -if SPL
> -
> -config SPL_SHA1_LEGACY
> -       bool "Enable SHA1 support in SPL with legacy crypto library"
> -       depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
> -       help
> -         This option enables support of hashing using SHA1 algorithm
> -         with legacy crypto library.
> -
> -config SPL_SHA256_LEGACY
> -       bool "Enable SHA256 support in SPL with legacy crypto library"
> -       depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
> -       help
> -         This option enables support of hashing using SHA256 algorithm
> -         with legacy crypto library.
> -
> -config SPL_SHA512_LEGACY
> -       bool "Enable SHA512 support in SPL with legacy crypto library"
> -       depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
> -       help
> -         This option enables support of hashing using SHA512 algorithm
> -         with legacy crypto library.
> -
> -config SPL_SHA384_LEGACY
> -       bool "Enable SHA384 support in SPL with legacy crypto library"
> -       depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
> -       select SPL_SHA512_LEGACY
> -       help
> -         This option enables support of hashing using SHA384 algorithm
> -         with legacy crypto library.
> -
> -config SPL_MD5_LEGACY
> -       bool "Enable MD5 support in SPL with legacy crypto library"
> -       depends on LEGACY_CRYPTO_BASIC && SPL_MD5
> -       help
> -         This option enables support of hashing using MD5 algorithm
> -         with legacy crypto library.
> -
> -endif # SPL
> -
>  endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
> @@ -124,10 +81,6 @@ config LEGACY_CRYPTO_CERT
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_LEGACY if MSCODE_PARSER
> -       select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
> -       select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> -               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -       select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
>         help
>           Enable legacy certificate libraries.
>
> @@ -178,35 +131,9 @@ config MSCODE_PARSER_LEGACY
>           This option chooses legacy certificate library for MS authenticode
>           parser.
>
> -if SPL
> -
> -config SPL_ASN1_DECODER_LEGACY
> -       bool "ASN1 decoder with legacy certificate library in SPL"
> -       depends on LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
> -       help
> -         This option chooses legacy certificate library for ASN1 decoder in
> -         SPL.
> -
> -config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> -       bool "Asymmetric public key crypto with legacy certificate library in SPL"
> -       depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -       help
> -         This option chooses legacy certificate library for asymmetric public
> -         key crypto algorithm in SPL.
> -
> -config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
> -       bool "RSA public key parser with legacy certificate library in SPL"
> -       depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> -       select SPL_ASN1_DECODER_LEGACY
> -       help
> -         This option chooses legacy certificate library for RSA public key
> -         parser in SPL.
> -
> -endif # SPL
> -
>  endif # LEGACY_CRYPTO_CERT
>
> -endif # LEGACY_CRYPTO
> +endif # LEGACY_CRYPTO || MBEDTLS_LIB_CRYPTO_ALT
>
>  if MBEDTLS_LIB
>
> @@ -221,19 +148,15 @@ config MBEDTLS_LIB_CRYPTO_ALT
>           Mutually incompatible with MBEDTLS_LIB_CRYPTO.
>
>  config MBEDTLS_LIB_CRYPTO
> -       bool "MbedTLS crypto libraries"
> +       bool "Use MbedTLS native crypto libraries"
> +       default y if MBEDTLS_LIB
>         select MD5_MBEDTLS if MD5
>         select SHA1_MBEDTLS if SHA1
>         select SHA256_MBEDTLS if SHA256
>         select SHA512_MBEDTLS if SHA512
>         select SHA384_MBEDTLS if SHA384
> -       select SPL_MD5_MBEDTLS if SPL_MD5
> -       select SPL_SHA1_MBEDTLS if SPL_SHA1
> -       select SPL_SHA256_MBEDTLS if SPL_SHA256
> -       select SPL_SHA512_MBEDTLS if SPL_SHA512
> -       select SPL_SHA384_MBEDTLS if SPL_SHA384
>         help
> -         Enable MbedTLS crypto libraries.
> +         Enable MbedTLS native crypto libraries.
>           Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
>
>  if MBEDTLS_LIB_CRYPTO
> @@ -306,53 +229,6 @@ config HKDF_MBEDTLS
>           This option enables support of key derivation using HKDF algorithm
>           with MbedTLS crypto library.
>
> -if SPL
> -
> -config SPL_SHA1_MBEDTLS
> -       bool "Enable SHA1 support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA1
> -       help
> -         This option enables support of hashing using SHA1 algorithm
> -         with MbedTLS crypto library.
> -
> -config SPL_SHA256_MBEDTLS
> -       bool "Enable SHA256 support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA256
> -       help
> -         This option enables support of hashing using SHA256 algorithm
> -         with MbedTLS crypto library.
> -
> -config SPL_SHA512_MBEDTLS
> -       bool "Enable SHA512 support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA512
> -       help
> -         This option enables support of hashing using SHA512 algorithm
> -         with MbedTLS crypto library.
> -
> -config SPL_SHA384_MBEDTLS
> -       bool "Enable SHA384 support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO && SPL_SHA384
> -       select SPL_SHA512
> -       help
> -         This option enables support of hashing using SHA384 algorithm
> -         with MbedTLS crypto library.
> -
> -config SPL_MD5_MBEDTLS
> -       bool "Enable MD5 support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO && SPL_MD5
> -       help
> -         This option enables support of hashing using MD5 algorithm
> -         with MbedTLS crypto library.
> -
> -config SPL_HKDF_MBEDTLS
> -       bool "Enable HKDF support in SPL with MbedTLS crypto library"
> -       depends on MBEDTLS_LIB_CRYPTO
> -       help
> -         This option enables support of key derivation using HKDF algorithm
> -         with MbedTLS crypto library.
> -
> -endif # SPL
> -
>  endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
> @@ -364,10 +240,6 @@ config MBEDTLS_LIB_X509
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
> -       select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
> -       select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
> -               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -       select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
>         help
>           Enable MbedTLS certificate libraries.
>
> @@ -418,44 +290,249 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenticode
>           parser.
>
> +endif # MBEDTLS_LIB_X509
> +
> +config MBEDTLS_LIB_TLS
> +       bool "MbedTLS TLS library"
> +       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       depends on ASN1_DECODER_MBEDTLS
> +       depends on MBEDTLS_LIB
> +       help
> +         Enable MbedTLS TLS library. Required for HTTPs support
> +         in wget
> +
> +endif # MBEDTLS_LIB
> +
> +# For SPL
> +
>  if SPL
>
> +choice
> +       prompt "Select crypto libraries (SPL)"

'SPL crypto libraries'

> +       default SPL_LEGACY_CRYPTO
> +       help
> +         Select crypto libraries in SPL.
> +         SPL_LEGACY_CRYPTO for legacy crypto libraries,
> +         SPL_MBEDTLS_LIB for MbedTLS libraries.
> +
> +config SPL_LEGACY_CRYPTO
> +       bool "legacy crypto libraries"
> +       select SPL_LEGACY_CRYPTO_BASIC
> +       select SPL_LEGACY_CRYPTO_CERT
> +
> +config SPL_MBEDTLS_LIB
> +       bool "MbedTLS libraries"
> +       select SPL_MBEDTLS_LIB_X509
> +endchoice
> +
> +if SPL_LEGACY_CRYPTO || SPL_MBEDTLS_LIB_CRYPTO_ALT
> +
> +config SPL_LEGACY_CRYPTO_BASIC
> +       bool "legacy basic crypto libraries (SPL)"

This is hashing not crypto.  It should be clear that you can generate
a config with mbedTLS for x509 while using hashing algorithms outside
mbedTLS

> +       select SPL_MD5_LEGACY if SPL_MD5
> +       select SPL_SHA1_LEGACY if SPL_SHA1
> +       select SPL_SHA256_LEGACY if SPL_SHA256
> +       select SPL_SHA512_LEGACY if SPL_SHA512
> +       select SPL_SHA384_LEGACY if SPL_SHA384
> +       help
> +         Enable legacy basic crypto libraries in SPL.
> +
> +if SPL_LEGACY_CRYPTO_BASIC
> +
> +config SPL_SHA1_LEGACY
> +       bool "Enable SHA1 support with legacy crypto library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with legacy crypto library in SPL.
> +
> +config SPL_SHA256_LEGACY
> +       bool "Enable SHA256 support with legacy crypto library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with legacy crypto library in SPL.
> +
> +config SPL_SHA512_LEGACY
> +       bool "Enable SHA512 support with legacy crypto library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA512
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with legacy crypto library in SPL.
> +
> +config SPL_SHA384_LEGACY
> +       bool "Enable SHA384 support with legacy crypto library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA384
> +       select SPL_SHA512_LEGACY
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with legacy crypto library in SPL.
> +
> +config SPL_MD5_LEGACY
> +       bool "Enable MD5 support with legacy crypto library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_BASIC && SPL_MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with legacy crypto library in SPL.
> +
> +endif # SPL_LEGACY_CRYPTO_BASIC
> +
> +config SPL_LEGACY_CRYPTO_CERT
> +       bool "legacy certificate libraries (SPL)"
> +       depends on SPL_LEGACY_CRYPTO
> +       select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
> +               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
> +       help
> +         Enable legacy certificate libraries in SPL.
> +
> +if SPL_LEGACY_CRYPTO_CERT
> +
> +config SPL_ASN1_DECODER_LEGACY
> +       bool "ASN1 decoder with legacy certificate library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
> +       help
> +         This option chooses legacy certificate library for ASN1 decoder in
> +         SPL.
> +
> +config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> +       bool "Asymmetric public key crypto with legacy certificate library (SPL)"
> +       depends on SPL_LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       help
> +         This option chooses legacy certificate library for asymmetric public
> +         key crypto algorithm in SPL.
> +
> +config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
> +       bool "RSA public key parser with legacy certificate library (SPL)"
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> +       select SPL_ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for RSA public key
> +         parser in SPL.
> +
> +endif # SPL_LEGACY_CRYPTO_CERT
> +
> +endif # SPL_LEGACY_CRYPTO || SPL_MBEDTLS_LIB_CRYPTO_ALT
> +
> +if SPL_MBEDTLS_LIB
> +
> +config SPL_MBEDTLS_LIB_CRYPTO_ALT
> +       bool "Use legacy crypto libraries as MbedTLS alternatives (SPL)"
> +       depends on SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
> +       select SPL_LEGACY_CRYPTO_BASIC
> +       default y if SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
> +       help
> +         Enable MbedTLS crypto alternatives and replace it with legacy crypto
> +         libraries in SPL.
> +         Mutually incompatible with SPL_MBEDTLS_LIB_CRYPTO.
> +
> +config SPL_MBEDTLS_LIB_CRYPTO
> +       bool "Use MbedTLS native crypto libraries (SPL)"
> +       default y if SPL_MBEDTLS_LIB
> +       select SPL_MD5_MBEDTLS if SPL_MD5
> +       select SPL_SHA1_MBEDTLS if SPL_SHA1
> +       select SPL_SHA256_MBEDTLS if SPL_SHA256
> +       select SPL_SHA512_MBEDTLS if SPL_SHA512
> +       select SPL_SHA384_MBEDTLS if SPL_SHA384
> +       help
> +         Enable MbedTLS native crypto libraries in SPL.
> +
> +if SPL_MBEDTLS_LIB_CRYPTO
> +
> +config SPL_SHA1_MBEDTLS
> +       bool "Enable SHA1 support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA1
> +       help
> +         This option enables support of hashing using SHA1 algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +config SPL_SHA256_MBEDTLS
> +       bool "Enable SHA256 support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA256
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +config SPL_SHA512_MBEDTLS
> +       bool "Enable SHA512 support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA512
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +config SPL_SHA384_MBEDTLS
> +       bool "Enable SHA384 support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA384
> +       select SPL_SHA512
> +       help
> +         This option enables support of hashing using SHA384 algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +config SPL_MD5_MBEDTLS
> +       bool "Enable MD5 support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_MD5
> +       help
> +         This option enables support of hashing using MD5 algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +config SPL_HKDF_MBEDTLS
> +       bool "Enable HKDF support with MbedTLS crypto library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of key derivation using HKDF algorithm
> +         with MbedTLS crypto library in SPL.
> +
> +endif # SPL_MBEDTLS_LIB_CRYPTO
> +
> +config SPL_MBEDTLS_LIB_X509
> +       bool "MbedTLS certificate libraries (SPL)"
> +       select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
> +       select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
> +               SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
> +       help
> +         Enable MbedTLS certificate libraries in SPL.
> +
> +if SPL_MBEDTLS_LIB_X509
> +
>  config SPL_ASN1_DECODER_MBEDTLS
> -       bool "ASN1 decoder with MbedTLS certificate library in SPL"
> -       depends on MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
> +       bool "ASN1 decoder with MbedTLS certificate library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
>         help
>           This option chooses MbedTLS certificate library for ASN1 decoder in
>           SPL.
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> -       bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
> -       depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +       bool "Asymmetric public key crypto with MbedTLS certificate library (SPL)"
> +       depends on SPL_MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
>           This option chooses MbedTLS certificate library for asymmetric public
>           key crypto algorithm in SPL.
>
>  config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
> -       bool "RSA public key parser with MbedTLS certificate library in SPL"
> +       bool "RSA public key parser with MbedTLS certificate library (SPL)"
>         depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select SPL_ASN1_DECODER_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public key
>           parser in SPL.
>
> -endif # SPL
> +endif # SPL_MBEDTLS_LIB_X509
>
> -endif # MBEDTLS_LIB_X509
> -
> -config MBEDTLS_LIB_TLS
> -       bool "MbedTLS TLS library"
> -       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> -       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> -       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> -       depends on ASN1_DECODER_MBEDTLS
> -       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> -       depends on MBEDTLS_LIB
> +config SPL_MBEDTLS_LIB_TLS
> +       bool "MbedTLS TLS library (SPL)"
> +       depends on SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       depends on SPL_X509_CERTIFICATE_PARSER_MBEDTLS
> +       depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       depends on SPL_ASN1_DECODER_MBEDTLS
> +       depends on SPL_MBEDTLS_LIB
>         help
> -         Enable MbedTLS TLS library. Required for HTTPs support
> +         Enable MbedTLS TLS library in SPL. Required for HTTPs support
>           in wget
>
> -endif # MBEDTLS_LIB
> +endif # SPL_MBEDTLS_LIB
> +
> +endif # SPL
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index e66c2018d97..4bbe7ceec45 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -6,60 +6,60 @@
>  MBEDTLS_LIB_DIR = external/mbedtls/library
>
>  # shim layer for hash
> -obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
> -obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
> -obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
> -obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
> +obj-$(CONFIG_$(XPL_)MD5_MBEDTLS) += md5.o
> +obj-$(CONFIG_$(XPL_)SHA1_MBEDTLS) += sha1.o
> +obj-$(CONFIG_$(XPL_)SHA256_MBEDTLS) += sha256.o
> +obj-$(CONFIG_$(XPL_)SHA512_MBEDTLS) += sha512.o
>
>  # x509 libraries
> -obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
> +obj-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>         public_key.o
> -obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
> +obj-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
> -obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
> -obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
> -obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
> +obj-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
> +obj-$(CONFIG_$(XPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
> +obj-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
>
>  # MbedTLS crypto library
> -obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
> +obj-$(CONFIG_$(XPL_)MBEDTLS_LIB) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>         $(MBEDTLS_LIB_DIR)/constant_time.o \
>         $(MBEDTLS_LIB_DIR)/md.o
>
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> +mbedtls_lib_crypto-$(CONFIG_$(XPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
> +mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
> +mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA256_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha256.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
> +mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA512_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha512.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
> +mbedtls_lib_crypto-$(CONFIG_$(XPL_)HKDF_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/hkdf.o
>
>  # MbedTLS X509 library
> -obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
> +obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
>  mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(XPL_)ASN1_DECODER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/bignum.o \
>         $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pk.o \
>         $(MBEDTLS_LIB_DIR)/pk_wrap.o \
>         $(MBEDTLS_LIB_DIR)/pkparse.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/x509_crl.o \
>         $(MBEDTLS_LIB_DIR)/x509_crt.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
> +mbedtls_lib_x509-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pkcs7.o
>
>  #mbedTLS TLS support
> -obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
> +obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
>  mbedtls_lib_tls-y := \
>         $(MBEDTLS_LIB_DIR)/mps_reader.o \
>         $(MBEDTLS_LIB_DIR)/mps_trace.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> index fd440c392f9..2da88c95454 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -11,12 +11,12 @@
>   * Author: Raymond Mao <raymond.mao@linaro.org>
>   */
>
> -#if defined CONFIG_MBEDTLS_LIB
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB)
>
>  #if CONFIG_IS_ENABLED(MD5)
>  #define MBEDTLS_MD_C
>  #define MBEDTLS_MD5_C
> -#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
>  #define MBEDTLS_MD5_ALT
>  #endif
>  #endif
> @@ -24,7 +24,7 @@
>  #if CONFIG_IS_ENABLED(SHA1)
>  #define MBEDTLS_MD_C
>  #define MBEDTLS_SHA1_C
> -#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
>  #define MBEDTLS_SHA1_ALT
>  #endif
>  #endif
> @@ -32,7 +32,7 @@
>  #if CONFIG_IS_ENABLED(SHA256)
>  #define MBEDTLS_MD_C
>  #define MBEDTLS_SHA256_C
> -#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
>  #define MBEDTLS_SHA256_ALT
>  #endif
>  #if CONFIG_IS_ENABLED(SHA256_SMALLER)
> @@ -48,7 +48,7 @@
>  #if CONFIG_IS_ENABLED(SHA512)
>  #define MBEDTLS_MD_C
>  #define MBEDTLS_SHA512_C
> -#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
>  #define MBEDTLS_SHA512_ALT
>  #endif
>  #if CONFIG_IS_ENABLED(SHA512_SMALLER)
> @@ -60,7 +60,7 @@
>  #define MBEDTLS_HKDF_C
>  #endif
>
> -#if defined CONFIG_MBEDTLS_LIB_X509
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_X509_USE_C
> @@ -89,9 +89,9 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> -#endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
> +#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
> -#if IS_ENABLED(CONFIG_MBEDTLS_LIB_TLS)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>  #include "rtc.h"
>
>  /* Generic options */
> @@ -106,25 +106,36 @@
>  #define MBEDTLS_ENTROPY_C
>  #define MBEDTLS_NO_PLATFORM_ENTROPY
>  #define MBEDTLS_SSL_PROTO_TLS1_2
> +#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
>  #define MBEDTLS_SSL_SERVER_NAME_INDICATION
> +#endif
>  #define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
>
>  /* RSA */
> +#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER) && \
> +       CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
>  #define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
>  #define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
>  #define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
> +#endif
>  #define MBEDTLS_GCM_C
>
>  /* ECDSA */
> +#if CONFIG_IS_ENABLED(ASN1_DECODER)
>  #define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
>  #define MBEDTLS_ECDH_C
> +#endif
>  #define MBEDTLS_ECDSA_DETERMINISTIC
>  #define MBEDTLS_HMAC_DRBG_C
> -#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
> -#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
> +
>  #define MBEDTLS_CAN_ECDH
>  #define MBEDTLS_PK_CAN_ECDSA_SIGN
> -#define MBEDTLS_ECP_C
> +#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
> +#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
> +#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
> +#endif
> +
>  #define MBEDTLS_ECP_DP_SECP256K1_ENABLED
>  #define MBEDTLS_ECP_DP_SECP192R1_ENABLED
>  #define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> @@ -138,6 +149,6 @@
>  #define MBEDTLS_ECP_DP_BP384R1_ENABLED
>  #define MBEDTLS_ECP_DP_BP512R1_ENABLED
>
> -#endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
> +#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
>
> -#endif /* #if defined CONFIG_MBEDTLS_LIB */
> +#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB) */
> --
> 2.25.1
>

Cheers
/Ilias
