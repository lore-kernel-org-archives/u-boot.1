Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4005C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF07E887CD;
	Mon, 29 Jul 2024 15:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0UFcr1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC471887D1; Mon, 29 Jul 2024 15:29:16 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814AB887BE
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 15:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso2424116a91.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722259753; x=1722864553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LI1Ziurfj0fXjLF3WVrVc3ts6t5T0E9O4L0uSRAcxy8=;
 b=w0UFcr1L8gC+VuYdi3fQPqKLZOHtQhCQxhH+TDocLF5uhNP0F9dPlVIRfwewdQzMxG
 eid4SmRRBmXfmUaAfKOLpx9OI81LJroidt2fi2pWZZeARgyJU3l40YElFdGs2me240HA
 cNYIJ0CgELWfL6IGGVoUKCC0Tm2DvZcEPsrocm9EUBh9DhbOhh0ipwJfiKknkIKmjqm1
 TLugVBV62dP1aYlAIh+cxzxTceNEklh7eDBU3z4ARuVzibd9ksy7gwuHdWmJAZFhQoag
 GZ64N0N9AowoTN9ORUwAzNbDs8dEOZ/OIrOsqIS08IgEb62NEk3HJ5ObSxaWGvGq+057
 FHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722259753; x=1722864553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LI1Ziurfj0fXjLF3WVrVc3ts6t5T0E9O4L0uSRAcxy8=;
 b=UKaZ5ruerxICEtPiopki00WFO6fa1bysNVwTCmVaMObf/C13qbn77JXoZOI5GskbCS
 R+G8n0qQekQQp/YzIg1oUHSidhAPODBFY54QH36FArJP4fyo7vHPHqQ2GEifsJnPWh34
 Q5y7wpAGPerYG05TA09StTcnne9TSaRjT1ibo+DfONMaXmXFZhtPj7mXO3g0HLhCzzfQ
 1NBj9RWIrOcu88LryUhR9jtjI9/ejknYgxG5EuezB7xEHhs+vMFRNJmm4l9SuD6xb2Bg
 M7QPRJk9961va7vag2mzVb4rfn4TrvFNX+Fpfc5KOnTM8+vk91I7Xz4IVDHfyA+skKUN
 KPEw==
X-Gm-Message-State: AOJu0YyDa86ZYxGOqIyW+fgY+DzVScnfjyM5vvYvJNcA3GBGQMzO3i6J
 IMVZsCVag3CnXGCd3Ocx8mvDBCw8YDzeTpOrewf+K8Jz7cjsR+Nb0KTzO6jmA9wbJBl3Ha8CTWt
 iZmLC3g2bV9JjmYph+a3YRglpXYyJjA/XcRT32/HYfQVSxeM8qhg=
X-Google-Smtp-Source: AGHT+IH7rZtcXwo33DQsThp4KMFC3FiDSB+IC4mCjLQi2Pqb0yJcl5j9PMIUuV9iY7e3XTQDpFH3K4nnGjQO3D5Q+VU=
X-Received: by 2002:a17:90b:1b44:b0:2c9:964a:95cb with SMTP id
 98e67ed59e1d1-2cf7e71d20emr7180203a91.40.1722259752849; Mon, 29 Jul 2024
 06:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-19-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-19-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jul 2024 16:28:36 +0300
Message-ID: <CAC_iWjK8vyYW7mcY-9BP4zKmHQ7hhm-B=vPw-bGPMOFV+_g+Tw@mail.gmail.com>
Subject: Re: [PATCH v4 18/29] lib/crypto: Adapt public_key header with MbedTLS
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
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
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

On Tue, 2 Jul 2024 at 21:31, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for public key,
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
> - Minor fix of the include directories.
>
>  include/crypto/public_key.h  | 6 ++++++
>  lib/crypto/Makefile          | 5 ++---
>  lib/crypto/asymmetric_type.c | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 3ba90fcc348..25cfb68adce 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -12,6 +12,12 @@
>
>  #ifdef __UBOOT__
>  #include <linux/types.h>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <library/common.h>
> +#include <mbedtls/pk.h>
> +#include <mbedtls/x509_crt.h>
> +#include <mbedtls/md.h>
> +#endif
>  #else
>  #include <linux/keyctl.h>
>  #endif
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 16059088f26..228ae443a27 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -7,9 +7,8 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
>
>  asymmetric_keys-y := asymmetric_type.o
>
> -obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> -       public_key_helper.o \
> -       public_key.o
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY) += public_key.o
>
>  #
>  # RSA public key parser
> diff --git a/lib/crypto/asymmetric_type.c b/lib/crypto/asymmetric_type.c
> index 24c2d15ef97..95b82cd8e84 100644
> --- a/lib/crypto/asymmetric_type.c
> +++ b/lib/crypto/asymmetric_type.c
> @@ -12,7 +12,6 @@
>  #include <keys/asymmetric-subtype.h>
>  #include <keys/asymmetric-parser.h>
>  #endif
> -#include <crypto/public_key.h>
>  #ifdef __UBOOT__
>  #include <linux/bug.h>
>  #include <linux/compat.h>
> @@ -26,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
>  #endif
> +#include <crypto/public_key.h>
>  #ifdef __UBOOT__
>  #include <keys/asymmetric-type.h>
>  #else
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
