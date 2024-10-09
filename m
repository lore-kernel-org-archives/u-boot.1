Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34888CEDD90
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075BB89201;
	Wed,  9 Oct 2024 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XF6qIyIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9919B88FAF; Wed,  9 Oct 2024 11:19:11 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5017689184
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so5185350a12.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465546; x=1729070346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SxRgrLAHeDP0frVbhkv1BQJdoCo4kxpENkGJqBsdP/0=;
 b=XF6qIyIwmeIVxuIXwy7qSJjFCEAxuXYwsahaeo+CEln7109cXb39PDnbcG2JuIdGBJ
 2bKEKGafXDIqKfUPIVvTcA1an1i6jYL9LBeFI6f5FqDmaARk1gl/mHZuwx6SeRpvRJoE
 zQn8D2SQY5omPd9Er3SMmz8d9f6TUyYaZYuBdwJcw0LqwHgTqMQkziKzTPUgFMhb2ZiL
 wbUSwbLkDx5egWHE0LspUvbdOCvSbfAiQIUN36yj7PNLbn8Tah1iymi/zZ9+7RFhufol
 KWQMLkqRLqG+x8rnlgokjO+bcM8kkouKJSUvI/bwAJabJ5sdD7IVHMuH1hUqe87xfW+C
 HCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465546; x=1729070346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SxRgrLAHeDP0frVbhkv1BQJdoCo4kxpENkGJqBsdP/0=;
 b=LDizud99y1aggtn1LsS0qHOfnCuCLVM2CPXaZxqfMAOa5CWr9eIXoVA4c0SOZdqw48
 bhPyGPxd++boW9mBhu+bsixVaLh2cZg7YAWxj+Wa6g1kvT7C6USzxN6n4sn9f02Gkh6+
 9RRO9IIYR0QQqA/rWhEBNne6uXyHbN1tUqP0c0W5MJS0vHKcwrbMDeog1qkfz7wM/MtX
 DgG7r1ZLboHpzKtV0P+ITebu++BuA3OFRvJnNzqOW+PECZgVj+fsDtE6KK959k88sQFk
 PEKFkOWsxsTaHlkwK38xwlpQUG10IgIFsTEy0qjKX/n3VBQgsxZdYDadWqDZ1AhzJ6N2
 ZmEA==
X-Gm-Message-State: AOJu0Yxzgb44aGtNes7YSc52b/f7qZjqvbah025Y/xBiRveUXJDMPLo7
 Jwd11nJBcuwsbkrY3ATWOWRyOPW1NMbK8AYWq2p7GqKTtG7vknMPutczFSyi4HRiFD+WU7zCdL1
 ejMf1sHKWgCjxhEPlcaCll2LMFibd5raeaCvZBQ==
X-Google-Smtp-Source: AGHT+IHTmRnhXnMpoBXGJgsfTZxrrAWvVoeF8ZB9Aq/EpUPlOId01lojzN+YHnNUWYVIjzKucOx3CKRjWXgfB+SVLuk=
X-Received: by 2002:a17:902:f60d:b0:20b:ad74:c84f with SMTP id
 d9443c01a7336-20c6377bdc1mr34779405ad.26.1728465545818; Wed, 09 Oct 2024
 02:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-23-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-23-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 12:18:29 +0300
Message-ID: <CAC_iWjLMStirH10UnL1cLtTtshA4rdbrGwaobVZZrtVk2F_0Bw@mail.gmail.com>
Subject: Re: [PATCH v8 22/27] lib/crypto: Adapt mscode_parser to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
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

On Fri, 4 Oct 2024 at 01:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for mscode parser,
> here to adjust the header and makefiles accordingly.
> Adding _LEGACY Kconfig for legacy mscode implementation.
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
> - Add kconfig for legacy mscode parser.
> - Correct header file include directories.
> Changes in v6
> - None.
> Changes in v7
> - None.
> Changes in v8
> - None
>
>  include/crypto/mscode.h | 4 ++++
>  lib/crypto/Makefile     | 2 +-
>  lib/mbedtls/Kconfig     | 9 +++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
> index 551058b96e6..678e69001b9 100644
> --- a/include/crypto/mscode.h
> +++ b/include/crypto/mscode.h
> @@ -9,6 +9,10 @@
>  #ifndef __UBOOT__
>  #include <crypto/hash_info.h>
>  #endif
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <mbedtls/asn1.h>
> +#include <mbedtls/oid.h>
> +#endif
>
>  struct pefile_context {
>  #ifndef __UBOOT__
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 7129315393f..3caa45dc2a8 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -63,7 +63,7 @@ obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
>  #
>  # Signed PE binary-wrapped key handling
>  #
> -obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
> +obj-$(CONFIG_$(SPL_)MSCODE_PARSER_LEGACY) += mscode.o
>
>  mscode-y := \
>         mscode_parser.o \
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index fd7263f9616..efeaed50385 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -120,6 +120,7 @@ config LEGACY_CRYPTO_CERT
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
> +       select MSCODE_PARSER_LEGACY if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         help
> @@ -150,6 +151,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
>           This option chooses legacy certificate library for PKCS7 message
>           parser.
>
> +config MSCODE_PARSER_LEGACY
> +       bool "MS authenticode parser with legacy certificate library"
> +       depends on LEGACY_CRYPTO_CERT && MSCODE_PARSER
> +       select ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for MS authenticode
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
