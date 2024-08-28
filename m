Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9B3C54753
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 08:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7FC88A7D;
	Wed, 28 Aug 2024 10:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OPxuRZK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D39E88A92; Wed, 28 Aug 2024 10:56:26 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D731D88A2E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso4618375a12.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724835382; x=1725440182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tSNVkFWXO5lkHcbWoO4IeLNXB972v/u4EiKYdrO6iZY=;
 b=OPxuRZK9VHgeNg0WXnPlJyMBOqw26jjWXChvBC8jrltz3zsTI6S6pkW9w8hH+81tYr
 MpZqD8CICzc1PIvQY/SCN7zYdkBapVAoliLkjN3yXyyohn4S2HMHlSYIxndNO77AYBWE
 wpL+pMcfQN0uTqYVsy2GYewBXCdlxXaNIqW38X/Lj4kW6XqKoNQSGObENYn+oX1OYDJp
 MqXJ5SB4YmenfmPbdMGxLwXeUmnPxcY4Of8alaw31PSRRyP1LKTg6IMoU/GUQVt0DNQf
 /zwmo5arwBvgVNBHX02Swi6pwXK4DgTBGENppFRJ3FtmKs4MOzsQrSZac/Lv9N7/6vey
 GH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724835382; x=1725440182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSNVkFWXO5lkHcbWoO4IeLNXB972v/u4EiKYdrO6iZY=;
 b=c3x8c/poRWpGPAaMGxtUgBV3lAalEQp4o4uC46LzgQn3HSzKPQrq1eTgVy8TH9I7k4
 Si4XAoQIcZ4pmUu1UA5jcqM3QuWBLXOt7dALna2Qt+zLD+wi3681iR0KFFmo1WWu3m4x
 gQ9eJeO1dOydEKHzjYocI9eg+err4OA3Kct/8jFBaHJ6XlfoEptzutWKeOAn1UC/Saxr
 I9pXqe5Ysc2LltagRUsKHgzMWccAu64BPNrXQgYdMHpLqCwheaaFVXB7kwe8oJR7meyV
 FIU1uLQwdboOC0aQ54KqyE9yTFi+o6/mfYutKupC7VxOnxtq2tGpyVzvWRUoE4poWyQg
 sSVg==
X-Gm-Message-State: AOJu0Yx67UYk6BsdlYfXoDZnRoeneXf5b+izJelNRqWGg/3F78/iLQgI
 VS9TcEwVM3u+03B1pfkjsq+zZ0U+PEIgzFOssWZx/nKfC5KyCAx+As0vOgEq06GmL2gXmoSNRRM
 7PeJn4+AzvlEV/HnpMP5zmHkGifC1eRJp+DBpKxlh01ddopFCr8M=
X-Google-Smtp-Source: AGHT+IH7z5Rmk7llW03l1jo4YDLsLxAwa2skVbvZhm7EHnIQLaMedbqcxi2QuSbC/QUiJ/j2R+VmdXYGRJCuu+LsPG4=
X-Received: by 2002:a17:90b:17c9:b0:2d3:ba42:774b with SMTP id
 98e67ed59e1d1-2d8440cac7emr1401890a91.16.1724835382062; Wed, 28 Aug 2024
 01:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-27-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-27-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 11:55:46 +0300
Message-ID: <CAC_iWjKecO8O59N8C19fVCi4H3kUXFitEJsffUxDApXKc-WzBw@mail.gmail.com>
Subject: Re: [PATCH v6 26/28] asn1_decoder: add build options for ASN1 decoder
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
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
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
> When building with MbedTLS, we are using MbedTLS to decode ASN1 data
> for x509, pkcs7 and mscode.
> Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
> MbedTLS implementations respectively.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
> Changes in v4
> - Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
>   MbedTLS implementations respectively.
> - Update the commit subject.
> Changes in v5
> - Correct kconfig dependence.
> - Refactored MbedTLS makefile.
> Changes in v6
> - None.
>
>  lib/Makefile         |  2 +-
>  lib/mbedtls/Kconfig  | 30 ++++++++++++++++++++++++++++++
>  lib/mbedtls/Makefile |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 617f5a55de0..2f5c0a01b9a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -82,7 +82,7 @@ obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
>  obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
>
>  obj-$(CONFIG_CRYPT_PW) += crypt/
> -obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
> +obj-$(CONFIG_$(SPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
>
>  obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
>  obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 797da0df938..b51f46014a7 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -117,12 +117,14 @@ endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
> +       select ASN1_DECODER_LEGACY if ASN1_DECODER
>         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_LEGACY if MSCODE_PARSER
> +       select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
> @@ -131,6 +133,12 @@ config LEGACY_CRYPTO_CERT
>
>  if LEGACY_CRYPTO_CERT
>
> +config ASN1_DECODER_LEGACY
> +       bool "ASN1 decoder with legacy certificate library"
> +       depends on LEGACY_CRYPTO_CERT && ASN1_DECODER
> +       help
> +         This option chooses legacy certificate library for ASN1 decoder.
> +
>  config ASYMMETRIC_PUBLIC_KEY_LEGACY
>         bool "Asymmetric public key crypto with legacy certificate library"
>         depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> @@ -172,6 +180,13 @@ config MSCODE_PARSER_LEGACY
>
>  if SPL
>
> +config SPL_ASN1_DECODER_LEGACY
> +       bool "ASN1 decoder with legacy certificate library in SPL"
> +       depends on LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
> +       help
> +         This option chooses legacy certificate library for ASN1 decoder in
> +         SPL.
> +
>  config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
>         bool "Asymmetric public key crypto with legacy certificate library in SPL"
>         depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> @@ -317,12 +332,14 @@ endif # MBEDTLS_LIB_CRYPTO
>
>  config MBEDTLS_LIB_X509
>         bool "MbedTLS certificate libraries"
> +       select ASN1_DECODER_MBEDTLS if ASN1_DECODER
>         select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
> +       select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
> @@ -331,6 +348,12 @@ config MBEDTLS_LIB_X509
>
>  if MBEDTLS_LIB_X509
>
> +config ASN1_DECODER_MBEDTLS
> +       bool "ASN1 decoder with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> +       help
> +         This option chooses MbedTLS certificate library for ASN1 decoder.
> +
>  config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         bool "Asymmetric public key crypto with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> @@ -372,6 +395,13 @@ config MSCODE_PARSER_MBEDTLS
>
>  if SPL
>
> +config SPL_ASN1_DECODER_MBEDTLS
> +       bool "ASN1 decoder with MbedTLS certificate library in SPL"
> +       depends on MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
> +       help
> +         This option chooses MbedTLS certificate library for ASN1 decoder in
> +         SPL.
> +
>  config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
>         depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 40031994708..14bc59f6cf3 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -36,7 +36,7 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
>  # MbedTLS X509 library
>  obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
>  mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
> -mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
> +mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
