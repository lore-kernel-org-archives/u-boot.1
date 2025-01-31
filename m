Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F0C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 13:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9998D80EB2;
	Fri, 31 Jan 2025 14:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Szqx/HdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AA480F0E; Fri, 31 Jan 2025 14:40:28 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A71980107
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e58a90c6059so3926607276.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 05:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738330825; x=1738935625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OL6Qc/spcveV6tPczh0rA7v9cbHyqTGRFysTW+SIu2A=;
 b=Szqx/HdSZT40X0v+1T2TMSDmuESXaOBZM2GJt0J4UeinyB0iooTb63IBgp6cVrQk4R
 xKMfd1YB36SFhZ77BCAbsmmacl3QeyQBX2cDpG+HkF2ubhqnz3tNFyPcul3cpaSbKed0
 uzFabP8m/3ty9VMWGaZqFjFCZZ0UNfz5DSJfmdYjcFnrvhbb6Sc5bSLrHCk9m30GvJOi
 Z0iqMJgjVP1Ea3JNSBe2O2/zT1KGghLy0Dfk22YA3c5aceyL9d0ibiovpoGOchpGV3BI
 adMKRfGvrrvVgAv+PGygvXAKbbHkRFa4z7QovLfZqmwbLLyaaS1PFQ4hShwI0c4aUJvo
 TLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738330825; x=1738935625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OL6Qc/spcveV6tPczh0rA7v9cbHyqTGRFysTW+SIu2A=;
 b=aN8fjNRuWzXXksO7YjqRlOVHS1mwHBTGSFPLbMXeivFyhA38pkXxYLXKxsX3Bsetg0
 TrrjV2mZsv87LvlcLWs1oR3VwdotbHSg+jcCE9mJKZ88B+Rm+U8ERcK03NfZJhTKfEML
 ZuZAnhY6xPsRG5bEG5BdumuyIxLOl+PPy6SZ63wUaHrSCdJ73b6K2NJaGB2Iu7rkZZWo
 eniEEOgjcqVjWm39ZJa3pl9e/PAuFbkClzToB8cE0wgN3wVHRZgxGlL4NebT5eul17r+
 0yCa6aognvOKD2+xxO1ybVgJSH2YJsSKj7tv6irmhdziczkN0gtCgGT5s1rmRGtopnLV
 POoA==
X-Gm-Message-State: AOJu0YyiIdMZ73C00x19Ve+kRC08qxVQcyLIFGg4Smkwnc2RARTUUyjL
 7cfS5XXAFgnX2foaaT0/yw5wYNGMkqSeHApKTenVJRYfj7zcTpMCnskUnXx0InneiHjflmcVznu
 lJTgpPL/1s4rCFPqpIZDf5CICpNzEEz76wshFGA==
X-Gm-Gg: ASbGncuyMALoTXCtIOMuPxQzMSH7TtOULm9Nq5tCqwZKD4Cbqt51tZ3kB8VeNz0h5Rh
 3+yzo4Yi5F12qervI1TIFTlEtKd/aM62a0UDRpu7KN64pEKbP1NwKiftyJa9b6SJH2bZ+bYZG
X-Google-Smtp-Source: AGHT+IHSi+sFBhV1gPPcN+Q2VQzwdNm5TUA5I/X5cmIPsPWP18QOnFGuq6i5OW125WJuH6ft855JGzaruJoheggmI3g=
X-Received: by 2002:a05:6902:2384:b0:e3c:a021:4898 with SMTP id
 3f1490d57ef6-e5ac8913c2amr6437684276.13.1738330824919; Fri, 31 Jan 2025
 05:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
In-Reply-To: <20250127151657.648255-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jan 2025 15:39:49 +0200
X-Gm-Features: AWEUYZnLHYkqPaeCS_VVx8YWgCYqJp7kjnTWBIZ5h0mDmeLG3RxBhC3UFJ5f5YM
Message-ID: <CAC_iWjLCMYCCCOAZ2V0XcNQVvSrk0NZjoOwxN+9n9PvbsAiheA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mbedtls: fix incorrect kconfig dependencies on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Currently building with WGET_HTTPS,NET_LWIP and MBEDTLS_LIB failed
> due to a few incorrect kconfig dependencies.
> Fix these and clarify what is the purpose of MBEDTLS_LIB_CRYPTO_ALT.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  cmd/Kconfig         | 1 -
>  lib/mbedtls/Kconfig | 8 +++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1a0985ca479..071601b5ac2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2161,7 +2161,6 @@ config WGET_HTTPS
>          select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>          select X509_CERTIFICATE_PARSER
>          select PKCS7_MESSAGE_PARSER
> -       select MBEDTLS_LIB_CRYPTO
>         select MBEDTLS_LIB_TLS
>         select RSA_VERIFY_WITH_PKEY
>         select X509_CERTIFICATE_PARSER
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index aa82336ef14..17ed2bc71de 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -116,6 +116,7 @@ endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
> +       depends on LEGACY_CRYPTO
>         select ASN1_DECODER_LEGACY if ASN1_DECODER
>         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> @@ -210,12 +211,13 @@ endif # LEGACY_CRYPTO
>  if MBEDTLS_LIB
>
>  config MBEDTLS_LIB_CRYPTO_ALT
> -       bool "MbedTLS crypto alternatives"
> +       bool "Use legacy crypto libraries as MbedTLS alternatives"
>         depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
>         select LEGACY_CRYPTO_BASIC
>         default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
>         help
> -         Enable MbedTLS crypto alternatives.
> +         Enable MbedTLS crypto alternatives and replace it with legacy crypto
> +         libraries.

This isn't too clear for someone that hasn't been involved with mbedTLS.
Isn't that enabling U-Boot's hashing algorithms instead of the mbedTLS ones?

Thanks
/Ilias
>           Mutually incompatible with MBEDTLS_LIB_CRYPTO.
>
>  config MBEDTLS_LIB_CRYPTO
> @@ -451,7 +453,7 @@ config MBEDTLS_LIB_TLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         depends on ASN1_DECODER_MBEDTLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> -       depends on MBEDTLS_LIB_CRYPTO
> +       depends on MBEDTLS_LIB
>         help
>           Enable MbedTLS TLS library. Required for HTTPs support
>           in wget
> --
> 2.25.1
>
