Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5885CC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E10B800CF;
	Tue,  4 Feb 2025 09:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R1jRt8eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B20980107; Tue,  4 Feb 2025 09:49:48 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB94800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5ae3fc15acso2884667276.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738658985; x=1739263785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yrZ2DglwpA6h4/5SN/vQkQnL0shAGPb3VRKimpQUEf0=;
 b=R1jRt8eoQWOVMuQODL1/Q3R69/07QMOZRnsCKz9EQyXqN4CLrF/ORdd23tiEMrhZOz
 domZd1IcFSZkXQe9rkfjD+8GtXGFhHdL7QlH/NikWChOmGQYl9sFgeOJ2n3Ff+41s5Id
 QvYmyLAjhI0k7uxaiPKKgND4hR2oOzH0ZTttoPXEFkmRmv60d6GBtb0gtTlvEdrAjdTl
 ogbjfoZq9HuapPP9bhxR21txzTPGw/E5aCE+PHMsK6c1L768FCKv2bnIMar2uqrESFnp
 3L8Li+xbHXbeOu3nox/crI7y6XEvq4jVu73Hs7nuqufxbRJU/uuqkWREQZHlmb4fbjML
 A1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738658985; x=1739263785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yrZ2DglwpA6h4/5SN/vQkQnL0shAGPb3VRKimpQUEf0=;
 b=MFJVWCCf/3UUTnTsLaXte7g7pF+ISAhg60GwyGj4vkVlHpKQcMBq7V8iXUF52EFfmY
 ueI1r6vMtyNboj49mK4OD1tdybNJdTvQNXa/juj8Iey4578P6kxsN8QSjBMU7QAetVdh
 xS8PVbCRqXn3ZZF/V9PTteTaN6SjHc+eHJgvLyZGISYF5ejtf0FOOebTptCaMi7Wlwm9
 EBQqK0mdnvFvx5dpwRGv04Ro0lvwKqC837ZKMBNiHe1Qzix09pK+jrDj3+i6eAQrWs5P
 7gsVsc6vSDzRtsMn0kK6q/nBfmUDnV2On5UKwRL/wpP0uLMc46KCZ2wTmd7WNXWhSsek
 b4lw==
X-Gm-Message-State: AOJu0Yz2JGDDQGpqihgqwwGz3tl+uCLeB7aYZvn8RWIM7rQhPoyNXbul
 488n5DFSFWy92vWtfQJykm5ENqgLtcHb4U1b3JRcyW8/g8tLEC98HqyZgvTWysSqlhRBjjqIKYw
 JZDEzm48S1lEiqWT7d72AG0Cc7jayFs9aCOQ5eQ==
X-Gm-Gg: ASbGncsfT5SVXsgDMHh+g0GWI13VyfunafMJoSHIq2/FCpW/l5OE4GvBpmrCOjL9f1H
 4faLS52+fm/rZbCgZXDrsICMtQLcM2R/WiSdGpAEb/HBgytWaMYIYXPxoeexKwBB2QmPqE8d8
X-Google-Smtp-Source: AGHT+IE9AVaTIBtvGuqTJ6x9dT46C5b8sdlCSdYDaYtiX3JiQ5xdVriIjVLCPFkCzfCYCwaBjsHN4cW1gCYIQcNpE+w=
X-Received: by 2002:a05:6902:1688:b0:e58:98ba:c125 with SMTP id
 3f1490d57ef6-e58a4be8656mr16933561276.43.1738658984787; Tue, 04 Feb 2025
 00:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20250203220825.707590-1-raymond.mao@linaro.org>
In-Reply-To: <20250203220825.707590-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 10:49:09 +0200
X-Gm-Features: AWEUYZmw8QKxynT7ThVdtVxEAJ-HGiUkuXRrU66jn7uqiojWid1Ktq-C7xr6jFM
Message-ID: <CAC_iWjLYqUucPThnuYPP_Pr19BQfQPMv4AY5XHDnJ8Pi_=hfhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on
 mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
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

On Tue, 4 Feb 2025 at 00:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Fixed the building failures when WGET_HTTPS,NET_LWIP and MBEDTLS_LIB
> are selected due to a few incorrect kconfig dependencies.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - Remove the renaming to patch 3/3 and update the commit message accordingly.
>
>  cmd/Kconfig         | 1 -
>  lib/mbedtls/Kconfig | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index e62817bd977..2e2dd459f56 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2160,7 +2160,6 @@ config WGET_HTTPS
>         select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         select X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER
> -       select MBEDTLS_LIB_CRYPTO
>         select MBEDTLS_LIB_TLS
>         select RSA_VERIFY_WITH_PKEY
>         select X509_CERTIFICATE_PARSER
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 35d8c507a89..bb8ac5f862b 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -156,6 +156,7 @@ endif # LEGACY_CRYPTO_BASIC
>
>  config LEGACY_CRYPTO_CERT
>         bool "legacy certificate libraries"
> +       depends on LEGACY_CRYPTO
>         select ASN1_DECODER_LEGACY if ASN1_DECODER
>         select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
>                 ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> @@ -491,7 +492,7 @@ config MBEDTLS_LIB_TLS
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
