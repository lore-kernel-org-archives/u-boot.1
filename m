Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10025E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0272F800C8;
	Fri, 13 Dec 2024 17:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mqGtJJw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB6A800D7; Fri, 13 Dec 2024 17:41:39 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3A8800C1
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 17:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso1315835a91.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734108095; x=1734712895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bf6X8wZQT6J6XIQdsg8M63wkKHvf3Acp+dj5l5atGmk=;
 b=mqGtJJw5DGujmXkjoMQQgDWe/hL4tMWYKZdparojDpJ6vVoXxE3mwkmVDAe+mzLQPp
 jj7k+egYOkvFJBDroD83utJIwThdTtd72MRNsx4f6vbAEYtcAkcnypQKpSHY5IzB8SEZ
 6IzKBvwsDAe0Yn6v7SYm+po3KwqMP3dIqjYEDHBBwUKJeWlBne5+243l3I6IvrKlGK9b
 4Z2oiqFPj3hnZowOdrWFquaI7IyQE4jU2Xup5Wxcw4lOMYNarCaJeCp8ajq9sKduwnyb
 C6mZja7FIIEMhz4xYnzGlWHBMGhaoxxFAyQdqx3Rsh2h+24VcZ75NBpyqJmU1EaEXCsJ
 JcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734108095; x=1734712895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bf6X8wZQT6J6XIQdsg8M63wkKHvf3Acp+dj5l5atGmk=;
 b=R23A8tXrc80cQOQC7sZcQoROjBvm2W7sedWP66wKrU+XdGrjjUvKXLa7xTP4HgU4Tj
 M0w3wG7onduEiDQ5ux5J0X94ItMKcAPR6EMuFnd93AO+qFBUFL/nz0WlaQ6+YjwV+xky
 sbHHblzRC8vXS2UjosqK7c15POrJl/ooB7uHZ/7JRi8k/OIYIcih3vWPelUBI6DjCsX2
 kTQsn3La8au0Y8siASkTjNwc50AkyLU9eEwvoc/YYjfaqMwbQ4L+tN7XMWA92lGUhkgm
 BzfqAumqFDXZnF60qKA5qPnrZ1KHC5Jz6Y4Rm03z2TD8URgdYpqL+Rgz03C5wL9YeJMK
 FDag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk8sQmssWNVItvE7v3So9QCtDuCx3T4bSGZKl076ZtFK0pSTplVOHT/zadeVFueREG2ScRqqU=@lists.denx.de
X-Gm-Message-State: AOJu0YzEn1OaAso858AhXgNk4Lew778pccKvrjDAe0EPDIl/7BzD+xaI
 9j+UccaRz1ozoaUkrhrZ8CKdgAtJ34XmQhSkSQQB1CkCdjByXEXCil38+C8H0PIT3Q3/cuEifLc
 A8hqqy/qbFjCztTwF5RkXqFsDWKSHPeN6N5JONQ==
X-Gm-Gg: ASbGncs5+D+DFFib40DJZtNkG8Jx1o1oqmdolYhCHC5EBpltiHwb3ptBm/iplzD8g74
 f37MF2eHX+IL9IrQEhu92hnzGRVS0aQs6KhfLJaZiY7uYN2ted8Io2sMWCYYn7XSoH8Qv+4U=
X-Google-Smtp-Source: AGHT+IGUrbGh6ui0WL1DRvN6qmS5SoGnpSRkT9mRY2caAq2hXEKdJZ+DSFVe/vXhZYzW5w2XOBt0GJ4hCNkouesMX5g=
X-Received: by 2002:a17:90b:1dc3:b0:2ee:cb5c:6c with SMTP id
 98e67ed59e1d1-2f28fd676eemr4299158a91.22.1734108094846; Fri, 13 Dec 2024
 08:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-4-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 11:41:24 -0500
Message-ID: <CAEfUkUKHtwnFupOGWfd3d81mWtNN5e-CV=VyVfDnhDFB2L6=kg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] mbedtls: enable support of hkdf
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

On Thu, 12 Dec 2024 at 08:37, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

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
>  # MbedTLS X509 library
>  obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
> diff --git a/lib/mbedtls/mbedtls_def_config.h
> b/lib/mbedtls/mbedtls_def_config.h
> index 1d2314e90e4..fd440c392f9 100644
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
Sounds good to me.
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
