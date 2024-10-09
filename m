Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F02CEDD89
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92FA8920F;
	Wed,  9 Oct 2024 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hlOSRiCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B62F8918E; Wed,  9 Oct 2024 11:20:39 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D27E89184
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e09f67bc39so5485469a91.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465635; x=1729070435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BovCFEgf9oLh0z2e/c6ydtCeoEaMwopdsVvhb3G9y5s=;
 b=hlOSRiCs3aa1ZGKgXN8vgIO6aQThD6J/HqZGXLKkmqYu/JIlfoO+dGauKOpi2slZpH
 2yuspJQjioNcvXl5oUq3orW1xcRNuhyeIzhkOl3uVqMV6s1r9xugLdNeEMhp9iW7kd71
 EklWt35y5+aLqyv4+tWhHmXC9WV+h3vuIdr+es0jUA9OZjjWbxgt2gRpDNOOJkXeUE8g
 KojhY4VVRc9+ajLtxy9P5by10OriJ1iNQkSdSWsgVWpMLGbIIjRiWuO2Wn2h4Q4Z62w5
 qDQmu0QMnwo42YDgXpNgmziX8/lPyamLjyVXV8XN6NKlMyjjHhBT+eYFelSfchC3sZjc
 txVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465635; x=1729070435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BovCFEgf9oLh0z2e/c6ydtCeoEaMwopdsVvhb3G9y5s=;
 b=UND6mpTczRGvYA86k54TU2aUjQ8vkq8g9ljbujdB4ezxQ7yhB1bhjcp51GVC6ZnZSm
 rHgVsG7A8+LTk2k3XbDI/YgwbthMkBx1CeE6KD1Uw4cOtan+CSzIlPsuFaWNDGJAUfSa
 Pj2vtDUK+W3GNE+2sF0q8SBD+DcDTh0eIEOLAE3zwqxpI8NQuSFHy4NCPiMKs021evOV
 f45r2j+H7aV1PVEB1YNkHmsQpo8RUk8y1VhOFCXXI14xcs/MmBKMMfAmLSdJT3CZIjQu
 tbp8g/wVa62WBt4YoldID4sph6UhxTXfAAw1cXJD59h0UE4MkgY1whiKk4vmgnaT3XQc
 3CEw==
X-Gm-Message-State: AOJu0Yx+ro0qqIQyzHfGPciW/KYMZ68k1Um+cAmkcPMNwVhVbGo3Bw+j
 rhLnlFv4zt4Pd78wUgM2KLRWsIcfgitdhTz/023P0QcpdwKbDTvRBZ7B70633p096vUOYCegzsc
 qzVCIBFdbKPsHgw4oUHQgvo7kLysUKHQmhOe3Kw==
X-Google-Smtp-Source: AGHT+IH04mro1HrgxjuPUq+XzepISwd8Sre7opXRuN5yfTzOGQRkE7EiX+F/B1diuYOTzKp4xyO2FU/I87HNS9RiMJU=
X-Received: by 2002:a17:90a:1784:b0:2e2:a96c:f009 with SMTP id
 98e67ed59e1d1-2e2a96cf022mr1604616a91.9.1728465635016; Wed, 09 Oct 2024
 02:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-21-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-21-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 12:19:59 +0300
Message-ID: <CAC_iWj+nmrhx6BUD1neYXbvZuYGaLcrrOKedU-z2A4zmQ7uycA@mail.gmail.com>
Subject: Re: [PATCH v8 20/27] lib/crypto: Adapt PKCS7 parser to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

On Fri, 4 Oct 2024 at 01:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for PKCS7 parser,
> here to adjust the header and makefiles accordingly.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - Update commit message.
> Changes in v4
> - Control building legacy library via '_LEGACY' Kconfig.
> Changes in v5
> - Correct header file include directories.
> Changes in v6
> - None.
> Changes in v7
> - None.
> Changes in v8
> - None
>
>  include/crypto/pkcs7_parser.h | 56 +++++++++++++++++++++++++++++++++++
>  lib/crypto/Makefile           |  7 +++--
>  2 files changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
> index 2c45cce5234..469c2711fa6 100644
> --- a/include/crypto/pkcs7_parser.h
> +++ b/include/crypto/pkcs7_parser.h
> @@ -11,6 +11,12 @@
>  #include <linux/oid_registry.h>
>  #include <crypto/pkcs7.h>
>  #include <crypto/x509_parser.h>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <mbedtls/pkcs7.h>
> +#include <library/x509_internal.h>
> +#include <mbedtls/asn1.h>
> +#include <mbedtls/oid.h>
> +#endif
>  #include <linux/printk.h>
>
>  #define kenter(FMT, ...) \
> @@ -18,7 +24,54 @@
>  #define kleave(FMT, ...) \
>         pr_devel("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
>
> +/* Backup the parsed MedTLS context that we need */
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +struct pkcs7_mbedtls_ctx {
> +       void *content_data;
> +};
> +
> +struct pkcs7_sinfo_mbedtls_ctx {
> +       void *authattrs_data;
> +       void *content_data_digest;
> +};
> +#endif
> +
> +/*
> + * MbedTLS integration Notes:
> + *
> + * MbedTLS PKCS#7 library does not originally support parsing MicroSoft
> + * Authentication Code which is used for verifying the PE image digest.
> + *
> + * 1.  Authenticated Attributes (authenticatedAttributes)
> + *     MbedTLS assumes unauthenticatedAttributes and authenticatedAttributes
> + *     fields not exist.
> + *     See MbedTLS function 'pkcs7_get_signer_info' for details.
> + *
> + * 2.  MicroSoft Authentication Code (mscode)
> + *     MbedTLS only supports Content Data type defined as 1.2.840.113549.1.7.1
> + *     (MBEDTLS_OID_PKCS7_DATA, aka OID_data).
> + *     1.3.6.1.4.1.311.2.1.4 (MicroSoft Authentication Code, aka
> + *     OID_msIndirectData) is not supported.
> + *     See MbedTLS function 'pkcs7_get_content_info_type' for details.
> + *
> + * But the EFI loader assumes that a PKCS#7 message with an EFI image always
> + * contains MicroSoft Authentication Code as Content Data (msg->data is NOT
> + * NULL), see function 'efi_signature_verify'.
> + *
> + * MbedTLS patch "0002-support-MicroSoft-authentication-code-in-PKCS7-lib.patch"
> + * is to support both above features by parsing the Content Data and
> + * Authenticate Attributes from a given PKCS#7 message.
> + *
> + * Other fields we don't need to populate from MbedTLS, which are used
> + * internally by pkcs7_verify:
> + * 'signer', 'unsupported_crypto', 'blacklisted'
> + * 'sig->digest' is used internally by pkcs7_digest to calculate the hash of
> + * Content Data or Authenticate Attributes.
> + */
>  struct pkcs7_signed_info {
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +       struct pkcs7_sinfo_mbedtls_ctx *mbedtls_ctx;
> +#endif
>         struct pkcs7_signed_info *next;
>         struct x509_certificate *signer; /* Signing certificate (in msg->certs) */
>         unsigned        index;
> @@ -55,6 +108,9 @@ struct pkcs7_signed_info {
>  };
>
>  struct pkcs7_message {
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +       struct pkcs7_mbedtls_ctx *mbedtls_ctx;
> +#endif
>         struct x509_certificate *certs; /* Certificate list */
>         struct x509_certificate *crl;   /* Revocation list */
>         struct pkcs7_signed_info *signed_infos;
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 4302f197297..7129315393f 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -50,15 +50,16 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
>  # PKCS#7 message handling
>  #
>  obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
> -pkcs7_message-y := \
> +pkcs7_message-y := pkcs7_helper.o
> +pkcs7_message-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_LEGACY) += \
>         pkcs7.asn1.o \
> -       pkcs7_helper.o \
>         pkcs7_parser.o
> -obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
>
>  $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
>  $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
>
> +obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
> +
>  #
>  # Signed PE binary-wrapped key handling
>  #
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
