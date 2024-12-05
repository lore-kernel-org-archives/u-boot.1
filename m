Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E4E77178
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7026892A0;
	Thu,  5 Dec 2024 18:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsX3rT/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFA089405; Thu,  5 Dec 2024 18:09:00 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53DC8901D
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  5 Dec 2024 18:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd17f231a7so681188a12.0
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 05 Dec 2024 09:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418536; x=1734023336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4BhJCztrmPg0yAFDJ3JOKmGqKUIPw+qWqUcI829r7s8=;
 b=MsX3rT/8GxE6EU7rzGNaZKA6DtTJnNzbMhL58f+hs5LmMV8BVUWUoy+FXIqHU8IMGY
 xQT94oJYVa+4tUR113H3MCE9hTr93IcX8VukyJTgIwxyzl8qBIrfpa/ruzVVNlpVSYfd
 XkbukGEdvqhuafBwBEZBKpTjv5ZFNYWOFGECLZD9ux8tNC573670TQ/ykPKzOuQPg7zs
 LgwJXSh5ckHkAhyfS/q3ZrHYQ27kNGdJ37+3Ar2Ig2DNCn90eY3BSoUNoaH9HBVpCMND
 6FBhz0Gp+EoC2OlQY+RS6gRNIl6+JaURUAv80/J/j2CQIu3mycJwNtA+2MAC2DUz0daK
 ic1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418536; x=1734023336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4BhJCztrmPg0yAFDJ3JOKmGqKUIPw+qWqUcI829r7s8=;
 b=uvigpoRy1WO36aFAk7olmryImWpByPlbx2CoBxu0E1Q7EDCSuAAARdeWM5u4GAxgGO
 lBbUtX9nVc2FP1LTFrO7sxzWzMfh7nWYhaxHAS3bPUcmcnV7aVWuGtdMQdD05k+Amghs
 urcQQmfYZ4ez2IPyaoGQx/ka2IeX74i408CaaSF+bKSakhmTDpO8iuOdAAtAPV3xVLux
 sq6h0d7xp+Ui7o3fVUNTA8t1bp5oJ+4jWifgLTR3Sa2u8S/YM7YQXcIJB/gW/d7El3sr
 8PsFiuZ7uj8BxRjJkPtmKKgQfv6ZS51F5Nf7iMK0jRnSTGz5dL1E2dQYVNs2xdkq4KBV
 uyXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZJkEHsIn8rS+hfyjZtnu2hx0kyNIWfl+3d+0QCsadKjRSVuFq54RHeAIhu8Ys/PjyfSlNFVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwZs84s1Ms4NmJvuAucJIJP7TWcxjwIWEZp8T3ThWMjam8goHvb
 kZxlHElFA5wAyOTmpei2NKL2qhFQwX8Fm6Yzcf8j3DyWc+Bm2bjGNqq9A74OsviETJS5MqAa7mD
 WFBNXZMyY46dZyF07vojMATJT2OpQCYkXhaVF+A==
X-Gm-Gg: ASbGncvEOeudzVzF+QEVk0m4c/6wA6Ywnf5/o7bElRR3DCUjpYl00CBGHHhysWhdxnS
 DXaRRTIdrolBGFwR2ihDhe19wyRicFHNL2s2hyYBhm8eQLUAM+9brBkvV0TImWvnr
X-Google-Smtp-Source: AGHT+IEZYfCLt5yiVVYmj+PgrpAhCS8krf4RRMD9qL9hIXNr/hG2C1qpxLZW6CatDqYddU332lM6PiilKfGCeXUt4ro=
X-Received: by 2002:a17:90b:4fca:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2ef011e6829mr14544050a91.1.1733418534830; Thu, 05 Dec 2024
 09:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-2-philippe.reynes@softathome.com>
In-Reply-To: <20241204175437.185449-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Dec 2024 12:08:43 -0500
Message-ID: <CAEfUkULsAXFeN1ALR4Cpipx17NXS2yj55+meZdzGjySM9_GX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mbedtls: enable support of hkdf
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 u-boot+nodisclaimer@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Philippe,

On Wed, 4 Dec 2024 at 12:54, Philippe Reynes <philippe.reynes@softathome.com>
wrote:

> Adds the support of key derivation using
> the scheme hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  lib/mbedtls/Kconfig              | 14 ++++++++++++++
>  lib/mbedtls/Makefile             |  2 ++
>  lib/mbedtls/mbedtls_def_config.h |  4 ++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 78167ffa252..aa82336ef14 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -297,6 +297,13 @@ config MD5_MBEDTLS
>           This option enables support of hashing using MD5 algorithm
>           with MbedTLS crypto library.
>
> +config HKDF_MBEDTLS
> +       bool "Enable HKDF support with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of key derivation using HKDF
> algorithm
> +         with MbedTLS crypto library.
> +
>  if SPL
>
>  config SPL_SHA1_MBEDTLS
> @@ -335,6 +342,13 @@ config SPL_MD5_MBEDTLS
>           This option enables support of hashing using MD5 algorithm
>           with MbedTLS crypto library.
>
> +config SPL_HKDF_MBEDTLS
> +       bool "Enable HKDF support in SPL with MbedTLS crypto library"
> +       depends on MBEDTLS_LIB_CRYPTO
> +       help
> +         This option enables support of key derivation using HKDF
> algorithm
> +         with MbedTLS crypto library.
> +
>  endif # SPL
>
>  endif # MBEDTLS_LIB_CRYPTO
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index ce0a61e4054..e66c2018d97 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -33,6 +33,8 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha256.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/sha512.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
> +       $(MBEDTLS_LIB_DIR)/hkdf.o
>
> lib/mbedtls/hkdf.c does not exist in your patch series.


>  # MbedTLS X509 library
>  obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
> diff --git a/lib/mbedtls/mbedtls_def_config.h
> b/lib/mbedtls/mbedtls_def_config.h
> index d27f017d084..cce0134d527 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -56,6 +56,10 @@
>  #endif
>  #endif
>
> +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> +#define MBEDTLS_HKDF_C
> +#endif
> +
>  #if defined CONFIG_MBEDTLS_LIB_X509
>
>  #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
> --
> 2.25.1
>
>
Regards,
Raymond
