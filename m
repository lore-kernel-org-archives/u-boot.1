Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F8FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 13:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C305E887CD;
	Mon, 29 Jul 2024 15:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mXpbRE35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B649887D4; Mon, 29 Jul 2024 15:20:38 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA23887CD
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 15:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso18807535ad.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722259234; x=1722864034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPWXkKaJpOaBbwR4X6n/JsJs2jYu1eb5QeOiVGaa+ZI=;
 b=mXpbRE35XStJvw02vc9Ekv3E4NOUriPARQM6hqxP7dRqS3sIUYxjn9Bp2XS6AGsj7N
 KYUzXGYHXNOklmgGeHbC485eTnecUXA8Pvp1Drgg3wFUECkZ+/khUHWDvQ8qBvhEJTz3
 Hi360jqBbGNNF9CgRBpEm49HQyiBSNythmYWZBgOL3gfVeV7X4fa1jlUiR7HhJzqg2AT
 pgfc0Xk0yuqRbpELnJ3MN/lLfys/S5mpwKNPUywjmGYjp+jRN4A6hZ5ZiG1Hp1QBrGTH
 h7iG3ygg2UJfsAAptyqXdZBRYZwiPDnK3B+qU3agf34jd/3z/A7+SkXFjb6wF6iWd7Ly
 vebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722259234; x=1722864034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPWXkKaJpOaBbwR4X6n/JsJs2jYu1eb5QeOiVGaa+ZI=;
 b=Iab59MO44Fr3hEfJbcTwRDm+kVEAnw9kNJNZc/9oZYkJbXeQvKrIOMsP8Jx6Jbraqu
 rgWfXXcOOMzq+AvqwMfMhZdK9KtIUk7kkBrWYI0IewO/kxxHGExnkXFT8nGAPkmmVVCi
 jNU72KjAZyj8GMyO9zI5u1X2Jy7n3e6YRO+3aPyA9H90eey9POqtZxyck5Wo7/dclFjO
 A6J3l1oDLT2ZPUhuxvav8yBayvOR+xjWPuQazXkTBtYx4kG5WU8Vii6oM1uCWH1WkZkH
 JYPiPKdGPeopgJYP5tjhcWQ5vxpN9czDrSBkp42xQfWowVSKrHI1HJTfm9J7brqihzhh
 BcpA==
X-Gm-Message-State: AOJu0YxeM/VLCl8YZXFPQub9gFspXTXXUYxjbFZYvmTSFNmLE+yv1WJL
 ru1s5JjJP70EvVfT6XpW/4itC26v67mG0tlzKWSlK8edsqmKQD2okIK4cOG+J0wbNkJcgbYUx3h
 AvbIjG6HBXdNJO6A8EjRBPEjqZuhSOUu1pUJI5g==
X-Google-Smtp-Source: AGHT+IGzHFZijrGnjHkhIRsXwlb8L+a8oDY8mqK1ynPBnjgJ+mBTxDTmFgu/qLT+nikMt4L59fhUY2Nnno3WgGlQ7rw=
X-Received: by 2002:a17:90a:8d0a:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2cf7e1f7f76mr5437273a91.17.1722259234371; Mon, 29 Jul 2024
 06:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-21-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-21-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jul 2024 16:19:58 +0300
Message-ID: <CAC_iWjLeM3zKfo274FpEhPb11=KxrRASqBW6WDe4o-jmQxmBkQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/29] lib/crypto: Adapt x509_cert_parser to MbedTLS
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
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
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

>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +/* Backup of part of the parsing context */

I am not sure I understand the comment

> +struct x509_cert_mbedtls_ctx {
> +       void    *tbs;                   /* Signed data */
> +       void    *raw_serial;            /* Raw serial number in ASN.1 */
> +       void    *raw_issuer;            /* Raw issuer name in ASN.1 */
> +       void    *raw_subject;           /* Raw subject name in ASN.1 */
> +       void    *raw_skid;              /* Raw subjectKeyId in ASN.1 */
> +};
> +#endif
> +
> +/*
> + * MbedTLS integration Notes:
> + *
> + * Fields we don't need to populate from MbedTLS:

You mean *for* mbedTLS?

> + * 'raw_sig' and 'raw_sig_size' are buffer for x509_parse_context,

'raw_sig' and 'raw_sig_size' are used in x509_parse_context(), which
in turn is not used in mbedTLS?

> + * not needed for MbedTLS.
> + * 'signer' and 'seen' are used internally by pkcs7_verify.
> + * 'verified' is not inuse.

either 'unsued' or 'not in use'
> + */
>  struct x509_certificate {
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +       struct x509_cert_mbedtls_ctx *mbedtls_ctx;
> +#endif
>         struct x509_certificate *next;
>         struct x509_certificate *signer;        /* Certificate that signed this one */
>         struct public_key *pub;                 /* Public key details */
> @@ -48,6 +76,32 @@ struct x509_certificate {
>   * x509_cert_parser.c
>   */
>  extern void x509_free_certificate(struct x509_certificate *cert);
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +/**
> + * x509_populate_pubkey() - Populate public key from MbedTLS context
> + *
> + * @cert:      Pointer to MbedTLS X509 cert
> + * @pub_key:   Pointer to the populated public key handle
> + * Return: 0 on succcess, error code on failure
> + */
> +int x509_populate_pubkey(mbedtls_x509_crt *cert, struct public_key **pub_key);
> +/**
> + * x509_populate_cert() - Populate X509 cert from MbedTLS context
> + *
> + * @mbedtls_cert:      Pointer to MbedTLS X509 cert
> + * @pcert:             Pointer to the populated X509 cert handle
> + * Return: 0 on succcess, error code on failure
> + */
> +int x509_populate_cert(mbedtls_x509_crt *mbedtls_cert,
> +                      struct x509_certificate **pcert);
> +/**
> + * x509_get_timestamp() - Translate timestamp from MbedTLS context
> + *
> + * @x509_time: Pointer to MbedTLS time
> + * Return: Time in time64_t format
> + */
> +time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time);
> +#endif
>  extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
>  extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
>                             unsigned char tag,
> @@ -56,6 +110,8 @@ extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
>  /*
>   * x509_public_key.c
>   */
> +#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
>  extern int x509_get_sig_params(struct x509_certificate *cert);
> +#endif
>  extern int x509_check_for_self_signed(struct x509_certificate *cert);
>  #endif /* _X509_PARSER_H */
> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index 6e0656ad1c5..6106190677e 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig ASYMMETRIC_KEY_TYPE
>         bool "Asymmetric (public-key cryptographic) key Support"
> -       depends on FIT_SIGNATURE
> +       depends on LEGACY_CRYPTO_CERT || MBEDTLS_LIB_X509
>         help
>           This option provides support for a key type that holds the data for
>           the asymmetric keys used for public key cryptographic operations such
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 228ae443a27..7f5f04d582c 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -32,11 +32,11 @@ endif
>  # X.509 Certificate handling
>  #
>  obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
> -x509_key_parser-y := \
> +x509_key_parser-y := x509_helper.o
> +x509_key_parser-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_LEGACY) += \
>         x509.asn1.o \
>         x509_akid.asn1.o \
>         x509_cert_parser.o \
> -       x509_helper.o \
>         x509_public_key.o
>
>  $(obj)/x509_cert_parser.o: \
> diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
> index 4ba13c1adc3..310edbd21be 100644
> --- a/lib/crypto/x509_public_key.c
> +++ b/lib/crypto/x509_public_key.c
> @@ -30,6 +30,8 @@
>  #include "x509_parser.h"
>  #endif
>
> +#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +
>  /*
>   * Set up the signature parameters in an X.509 certificate.  This involves
>   * digesting the signed data and extracting the signature.
> --
> 2.25.1
>
