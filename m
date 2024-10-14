Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E72FD18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 23:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEE5891A0;
	Tue, 15 Oct 2024 01:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jo3c+6vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7C6889CA; Mon, 14 Oct 2024 20:02:19 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E538C88730
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so1778551a91.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728928934; x=1729533734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vfS6qUe7K4OlsEGFC3w561P953Zg3pomiiT1lNvMAp8=;
 b=Jo3c+6vnaFVbyHvQyDs2YCW1svTdXlSFyGRGXF9/9VrNX0NMQH5uQbyJF047Qo6IvS
 DveK5KQulKs8R6xZASZqvDzWD1KULEuq2eU6eU/fOcN+PWGrulqf9ufLT78dlyTJd2rx
 gLCHjZw+CHW+Iwv6y9MQ65N+OaHfd2ovP3A4mjXU+ot+AKMdVZaafX0yF1GSKqGMcI8D
 YwO9SB9KItIbivlUrXg74X6FNowOFgQuDos4yqFARafwQXAqSu/hAWF8FXljT98x49y5
 o13pDRt7BAixEWw59jUinLlt6eNucwbyQrKfHSVxGLZuzUCA7zIdSxo2ZH6whWvVKC5D
 ZWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728928934; x=1729533734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfS6qUe7K4OlsEGFC3w561P953Zg3pomiiT1lNvMAp8=;
 b=JA5kDoL9mGNDgOw5kv1oWr6XZe/Mlaj6b28yn10Az09qLIM2mwrJ9ARRP5tNgVkf2L
 zMWcuYS87HJfvojSbrBpdOEmfgJW79E4bC//dHzjs2DfncHVZcOKC9MEqZMrYKNJiOtd
 K0IrGg3aZD//nM4ZGC1SSWsqN7fTpaJrNA0m67RKVORZMALqFJb+6RqX842GGjetBDmS
 NHMbp2VpLkWrgCls3sKp4rTbmDYoYwVpo42FHV7r4jG8XC85w5Pa1m8A+49yUy6iPfd2
 fllS/k2irGdx6WgAzZOck5R/3SBxsYPH/+zjpE4yVt3WyfBRWi8X0FPPlxnqWWDJ7Ais
 zHhA==
X-Gm-Message-State: AOJu0Yx19zZoCFmY3peEriLYIlAa5B0ZhDnAWlCUf8aqxaM2YbxfMjJi
 SdgVfPDmxd3uOGyCwKX3GHs9uukav6VN756TxshcgXv6ng6Uqm+hdW2lMYxRBokJ8zl+0S7OEDS
 mvYdbgfCGhwWvTc8tFPJ0+y63FabL4loLUuGteQ==
X-Google-Smtp-Source: AGHT+IE1Zgqr9alle1qPc69HunHlR9J+2gJMHONGRMB1jdkm/p/bUVerICp+q9mV38uwgzTnQETdRFp704+pJODyYY4=
X-Received: by 2002:a17:90a:fa88:b0:2d8:8430:8a91 with SMTP id
 98e67ed59e1d1-2e3152c0653mr12303856a91.10.1728928934186; Mon, 14 Oct 2024
 11:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-8-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-8-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 21:01:38 +0300
Message-ID: <CAC_iWjJThF8qo61LmnhVmgvG069GUhgWKb7fq0r7viuW5SSJgg@mail.gmail.com>
Subject: Re: [PATCH v8 07/27] mbedtls: Enable smaller implementation for
 SHA256/512
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
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

On Fri, 4 Oct 2024 at 00:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Smaller implementation for SHA256 and SHA512 helps to reduce the
> ROM footprint though it has a certain impact on performance.
> As a trade-off, enable it as a default config when MbedTLS is
> enabled can reduce the target size significantly with acceptable
> performace loss.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v6
> - Initial patch
> Changes in v7
> - Fixed the config dependencies.
> Changes in v8
> - None
>
>  lib/mbedtls/Kconfig              | 24 ++++++++++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h |  6 ++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 262abb2cec7..8e3a94c6f2b 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -164,6 +164,18 @@ config SHA256_MBEDTLS
>           This option enables support of hashing using SHA256 algorithm
>           with MbedTLS crypto library.
>
> +if SHA256_MBEDTLS
> +
> +config SHA256_SMALLER
> +       bool "Enable SHA256 smaller implementation with MbedTLS crypto library"
> +       depends on SHA256_MBEDTLS
> +       default y if SHA256_MBEDTLS
> +       help
> +         This option enables support of hashing using SHA256 algorithm
> +         smaller implementation with MbedTLS crypto library.
> +
> +endif
> +
>  config SHA512_MBEDTLS
>         bool "Enable SHA512 support with MbedTLS crypto library"
>         depends on MBEDTLS_LIB_CRYPTO && SHA512
> @@ -172,6 +184,18 @@ config SHA512_MBEDTLS
>           This option enables support of hashing using SHA512 algorithm
>           with MbedTLS crypto library.
>
> +if SHA512_MBEDTLS
> +
> +config SHA512_SMALLER
> +       bool "Enable SHA512 smaller implementation with MbedTLS crypto library"
> +       depends on SHA512_MBEDTLS
> +       default y if SHA512_MBEDTLS
> +       help
> +         This option enables support of hashing using SHA512 algorithm
> +         smaller implementation with MbedTLS crypto library.
> +
> +endif
> +
>  config SHA384_MBEDTLS
>         bool "Enable SHA384 support with MbedTLS crypto library"
>         depends on MBEDTLS_LIB_CRYPTO && SHA384
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> index 6fba053bd7c..1af911c2003 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -35,6 +35,9 @@
>  #if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
>  #define MBEDTLS_SHA256_ALT
>  #endif
> +#if CONFIG_IS_ENABLED(SHA256_SMALLER)
> +#define MBEDTLS_SHA256_SMALLER
> +#endif
>  #endif
>
>  #if CONFIG_IS_ENABLED(SHA384)
> @@ -48,6 +51,9 @@
>  #if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
>  #define MBEDTLS_SHA512_ALT
>  #endif
> +#if CONFIG_IS_ENABLED(SHA512_SMALLER)
> +#define MBEDTLS_SHA512_SMALLER
> +#endif
>  #endif
>
>  #if defined CONFIG_MBEDTLS_LIB_X509
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
