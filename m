Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09DEC54E92
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858ED88861;
	Wed, 28 Aug 2024 12:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wxc91Inn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7620A8876E; Wed, 28 Aug 2024 12:16:47 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC038873C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7cf6641765dso2920493a12.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724840203; x=1725445003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9a8sb2SmclLMO8fnyEhl5LtflwQkvPjo2U4AvKx6sks=;
 b=Wxc91Innp9DyPNHlikQB/wmJ94aDKEyPTPOgwoabDLVkSCnuzaeOWgbfVjxCySBv11
 N/vcVBoFYvsi43vP+HmkheNxMonuJbnS4IyQlDXKicwID0a8X1NYq+46w4fCYJEDQfXW
 CqaZjBQpgIi37w0tATOqsG9LAoIKRKFnIiy7far9tShnzxcvApASBqa+MRa4WJw5eIvr
 HNwiq9WKZ4+seo6d63iwPPFu0OrMAJzQeCUA2pmVLY8yju75O024+7z6No8hYG6DztsJ
 AHPuZs8ToV3W/pttWXZ20XRcwo7ywGBBZCPp0a7aKonienna5M0aHfpii2xD4gDGoCX9
 dn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724840203; x=1725445003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9a8sb2SmclLMO8fnyEhl5LtflwQkvPjo2U4AvKx6sks=;
 b=o63OAqklFaIOZlHehtj0FP3T9WU3H0sFIj21/BDPuSxEeYCpDjsl9+gy6PDDMirLb+
 SGoVx7URk6SwQDOqI7hwE0Js5x4kWIY4fRB8TRwxn8aDVee7vQKnRBpmXNdmjRAFwtA9
 5llgCWVEN/X+Bu4LDs8OLOlpZ2bicBWv7CSmapaU44HHcr6ohRz47Za9oTZO2C4A5T6F
 U4OPUYGod7vbTLqto+aEiL7nvS9G790zDAT614gKrMRhnLx7ezbKr+WM4gmQjYjXTaSk
 C+KtNFfCkLxQYlG1P72oG4iNcsTpjRFZqu+yd+mdzWWLCJiJOovXad7MtGF31KicttQY
 4hLQ==
X-Gm-Message-State: AOJu0YwcB/zw0J6MtT6mqpWKXXNRvsfBhwmnmA1aZdlYnb+awsk7iH1w
 7U4dybgFsJXBmL6RAK0S3ZKVj/DGHueOGAQ6AuzdH1KyTJGkBXglz1X1vN/DeWQ0teBQiTaLEtb
 RujmzsW25qjXM54FlV9ITGjF/NO58w1DBq4LntA==
X-Google-Smtp-Source: AGHT+IFzTk0YOoY3L8smSbGspnOYpstoJYYAUNs9U/ZbUU3HwAQebDKaktENDYZhAJ6eSseyAFxI9Fh9ynqmRUPNico=
X-Received: by 2002:a17:90b:3001:b0:2cf:c2da:771d with SMTP id
 98e67ed59e1d1-2d646c452ebmr18074859a91.25.1724840203315; Wed, 28 Aug 2024
 03:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-23-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-23-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 13:16:07 +0300
Message-ID: <CAC_iWjKd+pLv4qCMixu1m2fehpAryHkEcs3KwDy4BDfzSf20sw@mail.gmail.com>
Subject: Re: [PATCH v6 22/28] mbedtls: add MSCode parser porting layer
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Anand Moon <linux.amoon@gmail.com>,
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

On Sat, 17 Aug 2024 at 00:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add porting layer for MSCode on top of MbedTLS ASN1 library.
> Introduce _MBEDTLS kconfigs for MSCode MbedTLS implementation.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - None.
> Changes in v4
> - Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
>   MbedTLS implementations respectively.
> - Fix a few code style.
> Changes in v5
> - Correct kconfig dependence.
> - Refactored MbedTLS makefile.
> - Move mscode legacy kconfig to the next patch.
> Changes in v6
> - None.
>
>  lib/mbedtls/Kconfig         |   9 +++
>  lib/mbedtls/Makefile        |   1 +
>  lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
>  create mode 100644 lib/mbedtls/mscode_parser.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index e759cc20832..f03fb752d3f 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -294,6 +294,7 @@ config MBEDTLS_LIB_X509
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
> +       select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
> @@ -324,6 +325,14 @@ config PKCS7_MESSAGE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for PKCS7 message
>           parser.
>
> +config MSCODE_PARSER_MBEDTLS
> +       bool "MS authenticode parser with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && MSCODE_PARSER
> +       select ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for MS authenticode
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 36eba07bf43..83333b1b6a5 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>  obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
>  obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
> +obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
>
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
> new file mode 100644
> index 00000000000..c3805c6503c
> --- /dev/null
> +++ b/lib/mbedtls/mscode_parser.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MSCode parser using MbedTLS ASN1 library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <crypto/pkcs7.h>
> +#include <crypto/mscode.h>
> +
> +/*
> + * Parse a Microsoft Individual Code Signing blob
> + *
> + * U.P.SEQUENCE {
> + *    U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.15 (SPC_PE_IMAGE_DATA_OBJID)
> + *    U.P.SEQUENCE {
> + *       U.P.BITSTRING NaN : 0 unused bit(s);
> + *       [C.P.0] {
> + *          [C.P.2] {
> + *             [C.P.0] <arbitrary string>
> + *          }
> + *       }
> + *    }
> + * }
> + * U.P.SEQUENCE {
> + *    U.P.SEQUENCE {
> + *       U.P.OBJECTIDENTIFIER <digest algorithm OID>
> + *       U.P.NULL
> + *    }
> + *    U.P.OCTETSTRING <PE image digest>
> + * }
> + *
> + * @ctx: PE file context.
> + * @content_data: content data pointer.
> + * @data_len: content data length.
> + * @asn1hdrlen: ASN1 header length.
> + */
> +int mscode_parse(void *ctx, const void *content_data, size_t data_len,
> +                size_t asn1hdrlen)
> +{
> +       struct pefile_context *_ctx = ctx;
> +       unsigned char *p = (unsigned char *)content_data;
> +       unsigned char *end = (unsigned char *)content_data + data_len;
> +       size_t len = 0;
> +       int ret;
> +       unsigned char *inner_p;
> +       size_t seq_len = 0;
> +
> +       ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
> +                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                  MBEDTLS_ASN1_SEQUENCE);
> +       if (ret)
> +               return ret;
> +
> +       inner_p = p;
> +       ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len,
> +                                  MBEDTLS_ASN1_OID);
> +       if (ret)
> +               return ret;
> +
> +       /* Sanity check on the PE Image Data OID (1.3.6.1.4.1.311.2.1.15) */
> +       if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_PEIMAGEDATA, inner_p,
> +                               len))
> +               return -EINVAL;
> +
> +       p += seq_len;
> +       ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
> +                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                  MBEDTLS_ASN1_SEQUENCE);
> +       if (ret)
> +               return ret;
> +
> +       ret = mbedtls_asn1_get_tag(&p, p + seq_len, &seq_len,
> +                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                  MBEDTLS_ASN1_SEQUENCE);
> +       if (ret)
> +               return ret;
> +
> +       inner_p = p;
> +
> +       /*
> +        * Check if the inner sequence contains a supported hash
> +        * algorithm OID
> +        */
> +       ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len,
> +                                  MBEDTLS_ASN1_OID);
> +       if (ret)
> +               return ret;
> +
> +       if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_MD5, inner_p, len))
> +               _ctx->digest_algo = "md5";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA1, inner_p,
> +                                     len))
> +               _ctx->digest_algo = "sha1";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA224, inner_p,
> +                                     len))
> +               _ctx->digest_algo = "sha224";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA256, inner_p,
> +                                     len))
> +               _ctx->digest_algo = "sha256";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA384, inner_p,
> +                                     len))
> +               _ctx->digest_algo = "sha384";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA512, inner_p,
> +                                     len))
> +               _ctx->digest_algo = "sha512";
> +
> +       if (!_ctx->digest_algo)
> +               return -EINVAL;
> +
> +       p += seq_len;
> +       ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_OCTET_STRING);
> +       if (ret)
> +               return ret;
> +
> +       _ctx->digest = p;
> +       _ctx->digest_len = len;
> +
> +       return 0;
> +}
> --
> 2.25.1
>\\
