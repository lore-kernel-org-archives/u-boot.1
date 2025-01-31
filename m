Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6DBC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 13:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 672BA80EB2;
	Fri, 31 Jan 2025 14:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XGhC7SuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C1B8213E; Fri, 31 Jan 2025 14:42:13 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7E880812
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e46ac799015so2295635276.0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738330929; x=1738935729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L3HeOsJ1HsoHQgCbn2UrKm4oh0WjaOoyTC+2eNZukVU=;
 b=XGhC7SuMieQ0mcfvXp/niEpaMeCHSvpBo0caH2azZ9iU4BOQ0zC56bGf64iJLehSOY
 1GSeU0LvRZhCOKKxfCbCMd4crR8UHpAuGVeK8zE3WZzblcsO3vaTdiPO3DurvSCKtFPk
 6kkGo17UhmjojfkQ+BT7V2eoYbtN+uaL0F/df/lQMX578Pvgt1j2pa6tEd+hYcre23vq
 /nbomosAI7yaEgQLcJI71gqBCsP0hVwUlo61I9gyc3qhTVqHZQRnuFv/7vSrehmEfHaQ
 gfKOPAlr8goGK0NHor5/XEzbBfdF++JCQDaHjTZq6W5PMhZoE9oL7w9/+Z/UAyZWWXAF
 oZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738330929; x=1738935729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L3HeOsJ1HsoHQgCbn2UrKm4oh0WjaOoyTC+2eNZukVU=;
 b=FMUiv2RU/U28PxoRko/5qwrG3g33MgMPqfZRz6iI+O97+1X+WntAi1AJr4YCQznhUg
 shP/QTm90zb5s565knQTEZCIIv5O+lWcO6W3nDy2kyMvdTkup9zP5QK9n8PLoq99JYct
 Rrsw+YOnORi3D0GumCt/wapsOkSrCN19VWWht7T4KzuqoOf2egrESVOOA71HrzQ34kyB
 6Jpey70F+PJxqzaIRnOXb/69R7Fg4dP7PSC7Q4pGl3oTpZ/mKsqis0adSLzRPuvvuuPg
 tdB+l5XYdCfxfQrPuJ3gMFNo1hABVNj7rSGc4TzMElbBPJrtAq+pyGVNZhfEfmnE3sKV
 WX2Q==
X-Gm-Message-State: AOJu0Yw95ev6o3Q9FQc3/OApQ+0yzJbAe2oXBLOZPi3WwtXuUgvuUZwy
 Kuinkq7l+OMFROzoUnNVLpr78csZ0DZRy5UO4kFBKY4LphHHBuZMgAdBRHZ55DRKVaFhm8JKs4z
 Wy/aM/AOI9/bS7INKrIeZzcBOF4Uz4dfYj8JiGw==
X-Gm-Gg: ASbGncvzGyh7x7T0ZWFK9N6x0Jr4R3CBVNI3Yd6rAemcsDuE10qff2LVBteyof0s2vI
 qhq2LR8BJLunbA8j+T1+JZvUQGdhfxoMmXIzPyCkH8tAtqaPPUP1vlD+8DZkMKCpe3UPGKiUN
X-Google-Smtp-Source: AGHT+IFTZP04Z9VyLTh8BVgK6NOntVNBV2jGX7zCsuJz6GFv3tTz0aANwAD6FMwFn1WopCZBs3R2jgqHDuDMLnSJ5B0=
X-Received: by 2002:a05:6902:250f:b0:e57:f57a:4475 with SMTP id
 3f1490d57ef6-e58a4ac4e5fmr8858251276.16.1738330929525; Fri, 31 Jan 2025
 05:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20250127151657.648255-1-raymond.mao@linaro.org>
 <20250127151657.648255-2-raymond.mao@linaro.org>
In-Reply-To: <20250127151657.648255-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Jan 2025 15:41:33 +0200
X-Gm-Features: AWEUYZn7U-wfMjzvKWIyCgtIc_3LYhJR-FyCo-V7raxAeYPjxQPKBwYZg3vgucU
Message-ID: <CAC_iWj+rpE-OseGYsPwhMdW4tXKrDBpg_hZ6OsGXP69wdom8-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mbedtls: access mbedtls private members in mscode and
 pkcs7 parser
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
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

On Mon, 27 Jan 2025 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> U-Boot requires to access x509_internal.h, mbedtls_sha256_context and
> mbedtls_sha1_context in the porting layer, and this requires to
> enable MBEDTLS_ALLOW_PRIVATE_ACCESS.
>
> Enable it to mscode and pkcs7_parser to fix a mbedtls internal building
> error when X509 is selected.
>
> Moreover, Move it to a separate file to avoid enabling it in multiple
> places.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/crypto/mscode.h            |  1 +
>  include/crypto/pkcs7_parser.h      |  1 +
>  include/u-boot/sha1.h              | 12 +-----------
>  include/u-boot/sha256.h            | 12 +-----------
>  lib/mbedtls/port/mbedtls_options.h | 23 +++++++++++++++++++++++
>  5 files changed, 27 insertions(+), 22 deletions(-)
>  create mode 100644 lib/mbedtls/port/mbedtls_options.h
>
> diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
> index 678e69001b9..55501c22acb 100644
> --- a/include/crypto/mscode.h
> +++ b/include/crypto/mscode.h
> @@ -10,6 +10,7 @@
>  #include <crypto/hash_info.h>
>  #endif
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include "mbedtls_options.h"
>  #include <mbedtls/asn1.h>
>  #include <mbedtls/oid.h>
>  #endif
> diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
> index 469c2711fa6..fd1e48da09e 100644
> --- a/include/crypto/pkcs7_parser.h
> +++ b/include/crypto/pkcs7_parser.h
> @@ -12,6 +12,7 @@
>  #include <crypto/pkcs7.h>
>  #include <crypto/x509_parser.h>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include "mbedtls_options.h"
>  #include <mbedtls/pkcs7.h>
>  #include <library/x509_internal.h>
>  #include <mbedtls/asn1.h>
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index dd66258bbe9..c2d62e9cf0f 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -18,17 +18,7 @@
>  #include <linux/types.h>
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> -/*
> - * FIXME:
> - * MbedTLS define the members of "mbedtls_sha256_context" as private,
> - * but "state" needs to be access by arch/arm/cpu/armv8/sha1_ce_glue.
> - * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> - * access.
> - * Directly including <external/mbedtls/library/common.h> is not allowed,
> - * since this will include <malloc.h> and break the sandbox test.
> - */
> -#define MBEDTLS_ALLOW_PRIVATE_ACCESS
> -
> +#include "mbedtls_options.h"
>  #include <mbedtls/sha1.h>
>  #endif
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index d7a3403270b..2d86508332e 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -7,17 +7,7 @@
>  #include <linux/types.h>
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> -/*
> - * FIXME:
> - * MbedTLS define the members of "mbedtls_sha256_context" as private,
> - * but "state" needs to be access by arch/arm/cpu/armv8/sha256_ce_glue.
> - * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> - * access.
> - * Directly including <external/mbedtls/library/common.h> is not allowed,
> - * since this will include <malloc.h> and break the sandbox test.
> - */
> -#define MBEDTLS_ALLOW_PRIVATE_ACCESS
> -
> +#include "mbedtls_options.h"
>  #include <mbedtls/sha256.h>
>  #endif
>
> diff --git a/lib/mbedtls/port/mbedtls_options.h b/lib/mbedtls/port/mbedtls_options.h
> new file mode 100644
> index 00000000000..885ed6990b6
> --- /dev/null
> +++ b/lib/mbedtls/port/mbedtls_options.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Internal build options for MbedTLS
> + *
> + * Copyright (c) 2025 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#ifndef _MBEDTLS_OPT_H
> +#define _MBEDTLS_OPT_H
> +
> +/*
> + * FIXME:
> + * U-Boot/MbedTLS port requires to access a few of members which are defined
> + * as private in MbedTLS context.
> + * E.g: x509_internal.h, mbedtls_sha256_context and mbedtls_sha1_context.
> + * MBEDTLS_ALLOW_PRIVATE_ACCESS needs to be enabled to allow the external
> + * access, but directly including <external/mbedtls/library/common.h> is not
> + * allowed, since this will include <malloc.h> and break the sandbox test.
> + */
> +#define MBEDTLS_ALLOW_PRIVATE_ACCESS
> +
> +#endif /* _MBEDTLS_OPT_H */
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
