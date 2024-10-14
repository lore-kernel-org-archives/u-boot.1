Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D7D18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 23:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FCC8922C;
	Tue, 15 Oct 2024 01:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D028WY8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6A788E3C; Mon, 14 Oct 2024 20:06:54 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B178E88CD9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso2749225a91.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728929210; x=1729534010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+wTDCHkdjF7bmEjS1lJsBnV7uRYMP7QYs8kEwkGvODA=;
 b=D028WY8dhazFzgcS53AiwYWA3YAZnmieqItVRh90LV7JdOCVqBpoMz7BFFpowQBPX6
 uJTLk4txxiXo2abk6gGGUmWAn7Mcyg3yfzinQW0XMFGz513L5j95zcolwahb/+qCbWZS
 PpknUWUzowS5eimiXVNcbqcacCze+8Hcqrmbpyrxc5T1YnMrdafuvHeKzvpca0cbzPBz
 WwM1uV2IsIZruZuyCU6KKUnIzwHHJsANgiqUdqvt29Rzd4ATUWOrfMlfR+rOQTxZ04Z5
 34B+O8LGss3d2ocrXdQw4g+zPD/uqfHNGtXW8LIm9aFplyy7pn3v/lrktQ22X91JxoX1
 sFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728929210; x=1729534010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wTDCHkdjF7bmEjS1lJsBnV7uRYMP7QYs8kEwkGvODA=;
 b=vrmKOZNJiRUmWWjkRBQqlSRCdetgEDnV/qwR4CoTX1MsdpLtegpoHVAMNOIBdcQPWc
 CzvN/YE+Q2lU59++M1oQV2FCiB8wKtOVd9eK2wxKpaeW0D5DgwpTAjIT7fpjvIN1eevw
 mMLCpGJAW1PYLNMQdWSnvLx33Es+C30KlDnf9gfUpZ8NSMgevbt7PczOhJyD+vy7vK0C
 QvBU5B+MuRnhpbchjID6N9oYHXe51USfJFIe1u92ENZON+YgTSfqcOH7ral2jj3KEEuO
 DEDeWSPY9S6KLUjQ1OOjdxHUPB0JBVOLicZF1vFlvR1cYQ8WpNPhCy7o7+YAanzwgfnu
 Xg0Q==
X-Gm-Message-State: AOJu0Yw+NM/7y+eU9Q7aL0xzRAHHgrXrUjwaDYR/MMCXzQ+EEy0VsdHm
 G1+mwlg2NaV0qFUWCk+GaOBm3vln834tK2nMtCpnmExLFw4Yi4QLL+FPls/b38aZQQcfsIdQMaP
 kOnFMhPj+dSlCuVTjyCB+WGl/iZOS9w1fOX4SbkFyP95nXOleRL8=
X-Google-Smtp-Source: AGHT+IEZJbCxJq6dRUHhJwD6o0BSC52JxmIUDOR7dKQgrmVuV1sCE8J/4JepmUI1RsjAV/9+HjXfPEH6PyQe8z0PdIk=
X-Received: by 2002:a17:90a:db41:b0:2e2:a828:2982 with SMTP id
 98e67ed59e1d1-2e2f0d84d02mr15310661a91.38.1728929210010; Mon, 14 Oct 2024
 11:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-20-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-20-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 21:06:13 +0300
Message-ID: <CAC_iWjLz14mebMvsn20TE+XXMM7A+gsbO6OstwO218E=Qc=LEA@mail.gmail.com>
Subject: Re: [PATCH v8 19/27] mbedtls: add PKCS7 parser porting layer
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Oct 2024 01:55:13 +0200
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

On Fri, 4 Oct 2024 at 01:01, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add porting layer for PKCS7 parser on top of MbedTLS PKCS7 library.
> Introduce _LEGACY and _MBEDTLS kconfigs for PKCS7 parser legacy and
> MbedTLS implementations respectively.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> - Fix EFI Capsule CI test failures.
> Changes in v3
> - None.
> Changes in v4
> - Introduce _LEGACY and _MBEDTLS kconfigs for PKCS7 parser legacy and
>   MbedTLS implementations respectively.
> - Move common functions to helper.
> - Fix an unnecessary pointer casting.
> Changes in v5
> - Refactored MbedTLS makefile.
> Changes in v6
> - None.
> Changes in v7
> - None.
> Changes in v8
> - None
>
>  lib/mbedtls/Kconfig        |  18 ++
>  lib/mbedtls/Makefile       |   3 +-
>  lib/mbedtls/pkcs7_parser.c | 506 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 526 insertions(+), 1 deletion(-)
>  create mode 100644 lib/mbedtls/pkcs7_parser.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index abdafd04e89..189bb3186b6 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -119,6 +119,7 @@ config LEGACY_CRYPTO_CERT
>         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
> +       select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
> @@ -141,6 +142,14 @@ config X509_CERTIFICATE_PARSER_LEGACY
>           This option chooses legacy certificate library for X509 certificate
>           parser.
>
> +config PKCS7_MESSAGE_PARSER_LEGACY
> +       bool "PKCS#7 message parser with legacy certificate library"
> +       depends on X509_CERTIFICATE_PARSER_LEGACY
> +       select ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for PKCS7 message
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> @@ -293,6 +302,7 @@ config MBEDTLS_LIB_X509
>         select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
> +       select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
> @@ -315,6 +325,14 @@ config X509_CERTIFICATE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for X509 certificate
>           parser.
>
> +config PKCS7_MESSAGE_PARSER_MBEDTLS
> +       bool "PKCS#7 message parser with MbedTLS certificate library"
> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> +       select ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for PKCS7 message
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 29653323279..128a29c512f 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>         public_key.o
>  obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
> +obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
>
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
> @@ -49,5 +50,5 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
>  mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/x509_crl.o \
>         $(MBEDTLS_LIB_DIR)/x509_crt.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += \
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pkcs7.o
> diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> new file mode 100644
> index 00000000000..69ca784858e
> --- /dev/null
> +++ b/lib/mbedtls/pkcs7_parser.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PKCS#7 parser using MbedTLS PKCS#7 library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#include <log.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <crypto/public_key.h>
> +#include <crypto/pkcs7_parser.h>
> +
> +static void pkcs7_free_mbedtls_ctx(struct pkcs7_mbedtls_ctx *ctx)
> +{
> +       if (ctx) {
> +               kfree(ctx->content_data);
> +               kfree(ctx);
> +       }
> +}
> +
> +static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_sinfo_mbedtls_ctx *ctx)
> +{
> +       if (ctx) {
> +               kfree(ctx->authattrs_data);
> +               kfree(ctx->content_data_digest);
> +               kfree(ctx);
> +       }
> +}
> +
> +/*
> + * Parse Authenticate Attributes
> + * TODO: Shall we consider to integrate decoding of authenticate attribute into
> + *      MbedTLS library?
> + *
> + * There are two kinds of structure for the Authenticate Attributes being used
> + * in U-Boot.
> + *
> + * Type 1 - contains in a PE/COFF EFI image:
> + *
> + * [C.P.0] {
> + *   U.P.SEQUENCE {
> + *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.3 (OID_contentType)
> + *     U.P.SET {
> + *        U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.4 (OID_msIndirectData)
> + *     }
> + *  }
> + *  U.P.SEQUENCE {
> + *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.5 (OID_signingTime)
> + *     U.P.SET {
> + *        U.P.UTCTime '<siging_time>'
> + *     }
> + *  }
> + *  U.P.SEQUENCE {
> + *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.4 (OID_messageDigest)
> + *     U.P.SET {
> + *        U.P.OCTETSTRING <digest>
> + *     }
> + *  }
> + *    U.P.SEQUENCE {
> + *        U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.15 (OID_smimeCapabilites)
> + *       U.P.SET {
> + *          U.P.SEQUENCE {
> + *             <...>
> + *          }
> + *       }
> + *    }
> + * }
> + *
> + * Type 2 - contains in an EFI Capsule:
> + *
> + * [C.P.0] {
> + *   U.P.SEQUENCE {
> + *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.3 (OID_contentType)
> + *      U.P.SET {
> + *         U.P.OBJECTIDENTIFIER 1.2.840.113549.1.7.1 (OID_data)
> + *      }
> + *   }
> + *   U.P.SEQUENCE {
> + *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.5 (OID_signingTime)
> + *      U.P.SET {
> + *         U.P.UTCTime '<siging_time>'
> + *      }
> + *   }
> + *   U.P.SEQUENCE {
> + *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.4 (OID_messageDigest)
> + *      U.P.SET {
> + *         U.P.OCTETSTRING <digest>
> + *      }
> + *  }
> + *}
> + *
> + * Note:
> + * They have different Content Type (OID_msIndirectData or OID_data).
> + * OID_smimeCapabilites only exists in a PE/COFF EFI image.
> + */
> +static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> +                          struct pkcs7_signed_info *sinfo)
> +{
> +       unsigned char *p = aa;
> +       unsigned char *end = (unsigned char *)aa + aa_len;
> +       size_t len = 0;
> +       int ret;
> +       unsigned char *inner_p;
> +       size_t seq_len = 0;
> +
> +       ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
> +                                  MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> +                                  MBEDTLS_ASN1_CONSTRUCTED);
> +       if (ret)
> +               return ret;
> +
> +       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> +                                    MBEDTLS_ASN1_CONSTRUCTED |
> +                                    MBEDTLS_ASN1_SEQUENCE)) {
> +               inner_p = p;
> +               ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                          MBEDTLS_ASN1_OID);
> +               if (ret)
> +                       return ret;
> +
> +               if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, inner_p, len)) {
> +                       inner_p += len;
> +                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                                  MBEDTLS_ASN1_SET);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                                  MBEDTLS_ASN1_OID);
> +                       if (ret)
> +                               return ret;
> +
> +                       /*
> +                        * We should only support 1.2.840.113549.1.7.1 (OID_data)
> +                        * for PKCS7 DATA that is used in EFI Capsule and
> +                        * 1.3.6.1.4.1.311.2.1.4 (OID_msIndirectData) for
> +                        * MicroSoft Authentication Code that is used in EFI
> +                        * Secure Boot.
> +                        */
> +                       if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_INDIRECTDATA,
> +                                               inner_p, len) &&
> +                           MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS7_DATA,
> +                                               inner_p, len))
> +                               return -EINVAL;
> +
> +                       if (__test_and_set_bit(sinfo_has_content_type, &sinfo->aa_set))
> +                               return -EINVAL;
> +               } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGEDIGEST, inner_p,
> +                                               len)) {
> +                       inner_p += len;
> +                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                                  MBEDTLS_ASN1_SET);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                                  MBEDTLS_ASN1_OCTET_STRING);
> +                       if (ret)
> +                               return ret;
> +
> +                       sinfo->msgdigest = inner_p;
> +                       sinfo->msgdigest_len = len;
> +
> +                       if (__test_and_set_bit(sinfo_has_message_digest, &sinfo->aa_set))
> +                               return -EINVAL;
> +               } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_SIGNINGTIME, inner_p,
> +                                               len)) {
> +                       mbedtls_x509_time st;
> +
> +                       inner_p += len;
> +                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +                                                  MBEDTLS_ASN1_CONSTRUCTED |
> +                                                  MBEDTLS_ASN1_SET);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = mbedtls_x509_get_time(&inner_p, p + seq_len, &st);
> +                       if (ret)
> +                               return ret;
> +                       sinfo->signing_time = x509_get_timestamp(&st);
> +
> +                       if (__test_and_set_bit(sinfo_has_signing_time, &sinfo->aa_set))
> +                               return -EINVAL;
> +               } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_SMIMECAP, inner_p,
> +                                               len)) {
> +                       if (__test_and_set_bit(sinfo_has_smime_caps, &sinfo->aa_set))
> +                               return -EINVAL;
> +
> +                       if (msg->data_type != OID_msIndirectData &&
> +                           msg->data_type != OID_data)
> +                               return -EINVAL;
> +               } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_SPOPUSINFO, inner_p,
> +                                               len)) {
> +                       if (__test_and_set_bit(sinfo_has_ms_opus_info, &sinfo->aa_set))
> +                               return -EINVAL;
> +               } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_STATETYPE, inner_p,
> +                                               len)) {
> +                       if (__test_and_set_bit(sinfo_has_ms_statement_type, &sinfo->aa_set))
> +                               return -EINVAL;
> +               }
> +
> +               p += seq_len;
> +       }
> +
> +       if (ret && ret !=  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
> +               return ret;
> +
> +       msg->have_authattrs = true;
> +
> +       /*
> +        * Skip the leading tag byte (MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> +        * MBEDTLS_ASN1_CONSTRUCTED) to satisfy pkcs7_digest() when calculating
> +        * the digest of authattrs.
> +        */
> +       sinfo->authattrs = aa + 1;
> +       sinfo->authattrs_len = aa_len - 1;
> +
> +       return 0;
> +}
> +
> +static int x509_populate_content_data(struct pkcs7_message *msg,
> +                                     mbedtls_pkcs7 *pkcs7_ctx)
> +{
> +       struct pkcs7_mbedtls_ctx *mctx;
> +
> +       if (!pkcs7_ctx->content_data.data ||
> +           !pkcs7_ctx->content_data.data_len)
> +               return 0;
> +
> +       mctx = kzalloc(sizeof(*mctx), GFP_KERNEL);
> +       if (!mctx)
> +               return -ENOMEM;
> +
> +       mctx->content_data = kmemdup(pkcs7_ctx->content_data.data,
> +                                    pkcs7_ctx->content_data.data_len,
> +                                    GFP_KERNEL);
> +       if (!mctx->content_data) {
> +               pkcs7_free_mbedtls_ctx(mctx);
> +               return -ENOMEM;
> +       }
> +
> +       msg->data = mctx->content_data;
> +       msg->data_len = pkcs7_ctx->content_data.data_len;
> +       msg->data_hdrlen = pkcs7_ctx->content_data.data_hdrlen;
> +       msg->data_type = pkcs7_ctx->content_data.data_type;
> +
> +       msg->mbedtls_ctx = mctx;
> +       return 0;
> +}
> +
> +static int x509_populate_sinfo(struct pkcs7_message *msg,
> +                              mbedtls_pkcs7_signer_info *mb_sinfo,
> +                              struct pkcs7_signed_info **sinfo)
> +{
> +       struct pkcs7_signed_info *signed_info;
> +       struct public_key_signature *s;
> +       mbedtls_md_type_t md_alg;
> +       struct pkcs7_sinfo_mbedtls_ctx *mctx;
> +       int ret;
> +
> +       signed_info = kzalloc(sizeof(*signed_info), GFP_KERNEL);
> +       if (!signed_info)
> +               return -ENOMEM;
> +
> +       s = kzalloc(sizeof(*s), GFP_KERNEL);
> +       if (!s) {
> +               ret = -ENOMEM;
> +               goto out_no_sig;
> +       }
> +
> +       mctx = kzalloc(sizeof(*mctx), GFP_KERNEL);
> +       if (!mctx) {
> +               ret = -ENOMEM;
> +               goto out_no_mctx;
> +       }
> +
> +       /*
> +        * Hash algorithm:
> +        *
> +        * alg_identifier =     digestAlgorithm (DigestAlgorithmIdentifier)
> +        *                      MbedTLS internally checks this field to ensure
> +        *                      it is the same as digest_alg_identifiers.
> +        * sig_alg_identifier = digestEncryptionAlgorithm
> +        *                      (DigestEncryptionAlgorithmIdentifier)
> +        *                      MbedTLS just saves this field without any actions.
> +        * See function pkcs7_get_signer_info() for reference.
> +        *
> +        * Public key algorithm:
> +        * No information related to public key algorithm under MbedTLS signer
> +        * info. Assume that we are using RSA.
> +        */
> +       ret = mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg);
> +       if (ret)
> +               goto out_err_sinfo;
> +       s->pkey_algo = "rsa";
> +
> +       /* Translate the hash algorithm */
> +       switch (md_alg) {
> +       case MBEDTLS_MD_SHA1:
> +               s->hash_algo = "sha1";
> +               s->digest_size = SHA1_SUM_LEN;
> +               break;
> +       case MBEDTLS_MD_SHA256:
> +               s->hash_algo = "sha256";
> +               s->digest_size = SHA256_SUM_LEN;
> +               break;
> +       case MBEDTLS_MD_SHA384:
> +               s->hash_algo = "sha384";
> +               s->digest_size = SHA384_SUM_LEN;
> +               break;
> +       case MBEDTLS_MD_SHA512:
> +               s->hash_algo = "sha512";
> +               s->digest_size = SHA512_SUM_LEN;
> +               break;
> +       /* Unsupported algo */
> +       case MBEDTLS_MD_MD5:
> +       case MBEDTLS_MD_SHA224:
> +       default:
> +               ret = -EINVAL;
> +               goto out_err_sinfo;
> +       }
> +
> +       /*
> +        * auth_ids holds AuthorityKeyIdentifier, aka akid
> +        * auth_ids[0]:
> +        *      [PKCS#7 or CMS ver 1] - generated from "Issuer + Serial number"
> +        *      [CMS ver 3] - generated from skid (subjectKeyId)
> +        * auth_ids[1]: generated from skid (subjectKeyId)
> +        *
> +        * Assume that we are using PKCS#7 (msg->version=1),
> +        * not CMS ver 3 (msg->version=3).
> +        */
> +       s->auth_ids[0] = asymmetric_key_generate_id(mb_sinfo->serial.p,
> +                                                   mb_sinfo->serial.len,
> +                                                   mb_sinfo->issuer_raw.p,
> +                                                   mb_sinfo->issuer_raw.len);
> +       if (!s->auth_ids[0]) {
> +               ret = -ENOMEM;
> +               goto out_err_sinfo;
> +       }
> +
> +       /* skip s->auth_ids[1], no subjectKeyId in MbedTLS signer info ctx */
> +
> +       /*
> +        * Encoding can be pkcs1 or raw, but only pkcs1 is supported.
> +        * Set the encoding explicitly to pkcs1.
> +        */
> +       s->encoding = "pkcs1";
> +
> +       /* Copy the signature data */
> +       s->s = kmemdup(mb_sinfo->sig.p, mb_sinfo->sig.len, GFP_KERNEL);
> +       if (!s->s) {
> +               ret = -ENOMEM;
> +               goto out_err_sinfo;
> +       }
> +       s->s_size = mb_sinfo->sig.len;
> +       signed_info->sig = s;
> +
> +       /* Save the Authenticate Attributes data if exists */
> +       if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len)
> +               goto no_authattrs;
> +
> +       mctx->authattrs_data = kmemdup(mb_sinfo->authattrs.data,
> +                                      mb_sinfo->authattrs.data_len,
> +                                      GFP_KERNEL);
> +       if (!mctx->authattrs_data) {
> +               ret = -ENOMEM;
> +               goto out_err_sinfo;
> +       }
> +       signed_info->mbedtls_ctx = mctx;
> +
> +       /* If authattrs exists, decode it and parse msgdigest from it */
> +       ret = authattrs_parse(msg, mctx->authattrs_data,
> +                             mb_sinfo->authattrs.data_len,
> +                             signed_info);
> +       if (ret)
> +               goto out_err_sinfo;
> +
> +no_authattrs:
> +       *sinfo = signed_info;
> +       return 0;
> +
> +out_err_sinfo:
> +       pkcs7_free_sinfo_mbedtls_ctx(mctx);
> +out_no_mctx:
> +       public_key_signature_free(s);
> +out_no_sig:
> +       kfree(signed_info);
> +       return ret;
> +}
> +
> +/*
> + * Free a signed information block.
> + */
> +static void pkcs7_free_signed_info(struct pkcs7_signed_info *sinfo)
> +{
> +       if (sinfo) {
> +               public_key_signature_free(sinfo->sig);
> +               pkcs7_free_sinfo_mbedtls_ctx(sinfo->mbedtls_ctx);
> +               kfree(sinfo);
> +       }
> +}
> +
> +/**
> + * pkcs7_free_message - Free a PKCS#7 message
> + * @pkcs7: The PKCS#7 message to free
> + */
> +void pkcs7_free_message(struct pkcs7_message *pkcs7)
> +{
> +       struct x509_certificate *cert;
> +       struct pkcs7_signed_info *sinfo;
> +
> +       if (pkcs7) {
> +               while (pkcs7->certs) {
> +                       cert = pkcs7->certs;
> +                       pkcs7->certs = cert->next;
> +                       x509_free_certificate(cert);
> +               }
> +               while (pkcs7->crl) {
> +                       cert = pkcs7->crl;
> +                       pkcs7->crl = cert->next;
> +                       x509_free_certificate(cert);
> +               }
> +               while (pkcs7->signed_infos) {
> +                       sinfo = pkcs7->signed_infos;
> +                       pkcs7->signed_infos = sinfo->next;
> +                       pkcs7_free_signed_info(sinfo);
> +               }
> +               pkcs7_free_mbedtls_ctx(pkcs7->mbedtls_ctx);
> +               kfree(pkcs7);
> +       }
> +}
> +
> +struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
> +{
> +       int i;
> +       int ret;
> +       mbedtls_pkcs7 pkcs7_ctx;
> +       mbedtls_pkcs7_signer_info *mb_sinfos;
> +       mbedtls_x509_crt *mb_certs;
> +       struct pkcs7_message *msg;
> +       struct x509_certificate **cert;
> +       struct pkcs7_signed_info **sinfos;
> +
> +       msg = kzalloc(sizeof(*msg), GFP_KERNEL);
> +       if (!msg) {
> +               ret = -ENOMEM;
> +               goto out_no_msg;
> +       }
> +
> +       /* Parse the DER encoded PKCS#7 message using MbedTLS */
> +       mbedtls_pkcs7_init(&pkcs7_ctx);
> +       ret = mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
> +       /* Check if it is a PKCS#7 message with signed data */
> +       if (ret != MBEDTLS_PKCS7_SIGNED_DATA)
> +               goto parse_fail;
> +
> +       /* Assume that we are using PKCS#7, not CMS ver 3 */
> +       msg->version = 1;       /* 1 for [PKCS#7 or CMS ver 1] */
> +
> +       /* Populate the certs to msg->certs */
> +       for (i = 0, cert = &msg->certs, mb_certs = &pkcs7_ctx.signed_data.certs;
> +            i < pkcs7_ctx.signed_data.no_of_certs && mb_certs;
> +            i++, cert = &(*cert)->next, mb_certs = mb_certs->next) {
> +               ret = x509_populate_cert(mb_certs, cert);
> +               if (ret)
> +                       goto parse_fail;
> +
> +               (*cert)->index = i + 1;
> +       }
> +
> +       /*
> +        * Skip populating crl, that is not currently in-use.
> +        */
> +
> +       /* Populate content data */
> +       ret = x509_populate_content_data(msg, &pkcs7_ctx);
> +       if (ret)
> +               goto parse_fail;
> +
> +       /* Populate signed info to msg->signed_infos */
> +       for (i = 0, sinfos = &msg->signed_infos,
> +            mb_sinfos = &pkcs7_ctx.signed_data.signers;
> +            i < pkcs7_ctx.signed_data.no_of_signers && mb_sinfos;
> +            i++, sinfos = &(*sinfos)->next, mb_sinfos = mb_sinfos->next) {
> +               ret = x509_populate_sinfo(msg, mb_sinfos, sinfos);
> +               if (ret)
> +                       goto parse_fail;
> +
> +               (*sinfos)->index = i + 1;
> +       }
> +
> +       mbedtls_pkcs7_free(&pkcs7_ctx);
> +       return msg;
> +
> +parse_fail:
> +       mbedtls_pkcs7_free(&pkcs7_ctx);
> +       pkcs7_free_message(msg);
> +out_no_msg:
> +       msg = ERR_PTR(ret);
> +       return msg;
> +}
> --
> 2.25.1
>

I don't know if it would be easier to try and merge this with the
existing pkcs7 parser. It's unlikely since it has too much mbedTLS
specific structs, but we might look into it in the future. In any case
these are mutually exclusive so FWIW

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
