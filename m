Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B52C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 10:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B20885AF;
	Fri, 31 May 2024 12:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXAbNouM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328DE885F1; Fri, 31 May 2024 12:04:03 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80188856E
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 12:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7024e7e55f7so142725b3a.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717149839; x=1717754639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gymVY1PAQxRgpZfTHzwwSmyb+S7NVyoWP3O4DM8qXfQ=;
 b=iXAbNouM3MCHs8d4EDXwoMLku8jaIHnWff0rIwIlqkhj2K4l1n4weWFhveIdJTQmBb
 8iwl7FQEzFaXEx5a0QOudDS3FLj4Ck9LuIntjEJ/yiS86inoZtTgba/+8AtRO4Gb40Dc
 7rg28wXNTkOSxT1kyjaWLq27ke9zz9UV3VM9JeSRhikhAb2/yQyhVVmkOfvSXz/ZmJqF
 ifolPBXp/fv22FflthHV95fvIsw1ugZWrPt/ef/mv7Ckolk5sSQ5/PY+w3i+ZD8dvE84
 CODMBC7k1vazLxroJowIMXYQbuGz95zwju4upuVzA8RiIONcSdmbGHT9ydivSfLnzDOZ
 1Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149839; x=1717754639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gymVY1PAQxRgpZfTHzwwSmyb+S7NVyoWP3O4DM8qXfQ=;
 b=rSY+nBM0ccXV3+wMxrhUt4ShNfvZD2XTnWDdvTZCafMdDnSAsQ1dK/NVgxz5+RWs1N
 7K+X/TTePWA9E4MHhDC8ZVpbQLd8bJjsbwuKT2/Gw5/CJDnZIFhk9BlpNyOQBpzN6GTl
 spyZ8AoSCeSA5S/J0pzVlPI/AuVeCy1KhnowEnbCcRmZax8gwh1LQfOXzZzJzRCyo3LE
 GP4KR57iTeJJYTE2ucH/a0gyiWOiUHfpT8dGKFDDJHXcupipgx4T4t0/1Qew3TVBTLsJ
 lP04zpESsY3nURy1xKUiuBZxnmtEolJJXafWEPXKk41qxkQb4chrMSwilArWAV4r0G8A
 ggyA==
X-Gm-Message-State: AOJu0YwMdUHIkbcoo/VAXw73Imghxgk469dP4G3fTCn4uh2rDETwUiV1
 piNKwtIu2nIl77hPgprnDIg86bzNrI5j3CxQ+x9e2Dc3WjDKELP2qaTAAHwBqMjW/DJsYXv8wtM
 N3pGS6leNAYCv5LhIq7k4sduQAU9cKHkKFavd6A==
X-Google-Smtp-Source: AGHT+IHqRtvoPVy12SZcx7PoY4l52+qT/roOg3mHVXxcGtbtqK3taHVMe+pnlnouTe6dkUl/sz/8Aq0BEjE+kc4Rd50=
X-Received: by 2002:a05:6a21:6d8a:b0:1af:d07a:37c8 with SMTP id
 adf61e73a8af0-1b26f22b0e3mr1797335637.37.1717149839126; Fri, 31 May 2024
 03:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-20-raymond.mao@linaro.org>
In-Reply-To: <20240528140955.1960172-20-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 13:03:22 +0300
Message-ID: <CAC_iWjK7st0ttFuuX22eMtRraGin2dikMUu5_C1cY8J9KvKESw@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] mbedtls: add MSCode parser porting layer
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, 
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

On Tue, 28 May 2024 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add porting layer for MSCode on top of MbedTLS ASN1 library.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - None.
>
>  lib/mbedtls/Makefile        |   1 +
>  lib/mbedtls/mscode_parser.c | 111 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 lib/mbedtls/mscode_parser.c
>
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 005b8a25320..f0b8a1c4003 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
>  x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
>  x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_cert_parser.o
>  x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_parser.o
> +x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode_parser.o
>
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
> diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
> new file mode 100644
> index 00000000000..34715f3a137
> --- /dev/null
> +++ b/lib/mbedtls/mscode_parser.c
> @@ -0,0 +1,111 @@
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

You need to describe the function arguments as well on the comment

> + *
> + */
> +int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
> +                size_t asn1hdrlen)
> +{
> +       struct pefile_context *ctx = _ctx;
> +       unsigned char *p = (unsigned char *)content_data;
> +       unsigned char *end = (unsigned char *)content_data + data_len;

Why are you dropping const here?

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
> +       ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
> +       if (ret)
> +               return ret;
> +
> +       /* Sanity check on the PE Image Data OID (1.3.6.1.4.1.311.2.1.15) */
> +       if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_PEIMAGEDATA, inner_p, len))
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
> +       ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
> +       if (ret)
> +               return ret;
> +
> +       if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_MD5, inner_p, len))
> +               ctx->digest_algo = "md5";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA1, inner_p, len))
> +               ctx->digest_algo = "sha1";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA224, inner_p, len))
> +               ctx->digest_algo = "sha224";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA256, inner_p, len))
> +               ctx->digest_algo = "sha256";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA384, inner_p, len))
> +               ctx->digest_algo = "sha384";
> +       else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA512, inner_p, len))
> +               ctx->digest_algo = "sha512";
> +
> +       if (!ctx->digest_algo)
> +               return -EINVAL;
> +
> +       p += seq_len;
> +       ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_OCTET_STRING);
> +       if (ret)
> +               return ret;
> +
> +       ctx->digest = p;
> +       ctx->digest_len = len;
> +
> +       return 0;
> +}
> --
> 2.25.1
>

Thanks
/Ilias
