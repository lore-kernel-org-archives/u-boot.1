Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF05C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 10:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44D1884BE;
	Fri, 26 Jul 2024 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHkeu0OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B615884DB; Fri, 26 Jul 2024 12:10:13 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1068288496
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 12:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7a1d48e0a5fso538219a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721988609; x=1722593409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8fojlfsoCFL5NITB6IL7HnlVJVj9wWmN6If7yw/TJfg=;
 b=mHkeu0OMDYmoNeon96T1o512JTHuee7as+x5iP+PMmrzOR4MKGnpYvLN55Oy8kjLox
 f2zr/kf2YaEqApHsrI5bKh7jWDPQYFhM1VAxoo0+kzRn+F1ZrgNxv2QPCI0JVhZHP6L+
 did4qpWFFEUm24/Zk1hlRiVCd4a9g+lLdTwvfkQxDgs+O1zL2eDYHcAt8p51GZDvfKSf
 /85d4mY6sfG1cvqMcdi5I05t+k9qPU1Oa+Uiz2JGEP6gn4aW1MyYaS3B9I4VPNTvjw7e
 IYBihoUdxDa/uT/0C0UKHhl5bSM1TaXDb6YZurS7ALbZ8n2Tto+4+ewvTFhqKNy5NVd9
 YO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721988609; x=1722593409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fojlfsoCFL5NITB6IL7HnlVJVj9wWmN6If7yw/TJfg=;
 b=lSz5qIqR1y3W2G3RxPkiZ0x6gfn0NlXciKMJiQ+uHx063+VB8bYnv5+diDrYUrzv8o
 QXeV5w9t2X+utQmvyCJ7yclgDwLkOueTyfIciMTj8VA75ZW0vbjhYV7/WWfqZYls2Obr
 tNztmgOQv1bYzX+ENwZNBcCNGWo2L6BTSGcRi7oHGKWdsTPmhuXrds/mPlub3xVkgnsd
 288TVS+Mmp5uUGQbrIneM6WdjTXp/uGokR3YtP0xT7BKJUy99g8wLJEbIpN3J0kGgkKA
 OYOG//IWLVoxCsa0G98tyXzajzoZvvEJ5iRVyX2kdKEYSLk6qbNorPCwPo3ptGdcwrzk
 8i8g==
X-Gm-Message-State: AOJu0YysYpyZcAnGEHQ08qMMKKSp7kLS2s4y8Slie+8LWPmvHpmVQl8m
 ayzkFRV5sSejRRAOPlPwrjgYUZB/4X/aHl8LRb1ruyy4o7Lysb8woqwv09vnyTUv012A5AApBso
 /AdWydJCNczlmbzI6k93V98aGai+NHRprolsDLQ==
X-Google-Smtp-Source: AGHT+IGG/l0gYRF3xc1j+NzcehN86ONF5sZjfNridmoc/sBuZBda99XtgsV5p8Td8l1K+H52QtOln0ED0rkvtp3j6bU=
X-Received: by 2002:a17:90b:3844:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2cf237b7546mr5644730a91.11.1721988609130; Fri, 26 Jul 2024
 03:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-24-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-24-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jul 2024 13:09:32 +0300
Message-ID: <CAC_iWj+qFMj7JerKn6zJSE91uGSM=Dsceg8S3q+FHhY4dU031Q@mail.gmail.com>
Subject: Re: [PATCH v4 23/29] mbedtls: add MSCode parser porting layer
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>, 
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
> Add porting layer for MSCode on top of MbedTLS ASN1 library.
> Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
> MbedTLS implementations respectively.

You should mention explicitly on the commit message, that this patch
is expected to be merged in mbedTLS upstream and we can remove it in
the future


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
>
>  lib/mbedtls/Kconfig         |  17 +++++
>  lib/mbedtls/Makefile        |   1 +
>  lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 lib/mbedtls/mscode_parser.c
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 8c5b617bb48..d8a8f87e031 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -126,6 +126,7 @@ config LEGACY_CRYPTO_CERT
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
> +       select MSCODE_PARSER_LEGACY if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
>         help
> @@ -156,6 +157,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
>           This option chooses legacy certificate library for PKCS7 message
>           parser.
>
> +config MSCODE_PARSER_LEGACY

Where is this used? Is it on a later patch? The MSCODE_PARSER_MBEDTLS
option is part of this patch on the Makefile


> +       bool "MS authenticode parser with legacy certificate library"
> +       depends on LEGACY_CRYPTO_CERT && MSCODE_PARSER
> +       select ASN1_DECODER_LEGACY
> +       help
> +         This option chooses legacy certificate library for MS authenticode
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
> @@ -280,6 +289,7 @@ config MBEDTLS_LIB_X509
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
> +       select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
>         select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
>         help
> @@ -309,6 +319,13 @@ config PKCS7_MESSAGE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for PKCS7 message
>           parser.
>
> +config MSCODE_PARSER_MBEDTLS
> +       bool "MS authenticode parser with MbedTLS certificate library"
> +       select ASN1_DECODER_MBEDTLS
> +       help
> +         This option chooses MbedTLS certificate library for MS authenticode
> +         parser.
> +
>  if SPL
>
>  config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 7b40ff0c467..ac7c487449d 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -27,6 +27,7 @@ x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
>  x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         x509_cert_parser.o
>  x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
> +x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
>
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
> diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
> new file mode 100644
> index 00000000000..c3805c6503c
> --- /dev/null
> +++ b/lib/mbedtls/mscode_parser.c
> @@ -0,0 +1,123 @@
 [...]

Thanks
/Ilias
