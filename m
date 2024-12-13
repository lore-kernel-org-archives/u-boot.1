Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3082E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72905800D7;
	Fri, 13 Dec 2024 17:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NxTmkim2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA4480104; Fri, 13 Dec 2024 17:42:35 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1F7800C8
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 17:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so1319562a91.1
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734108151; x=1734712951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rf43cUYS4h8CzCvB6H6y5NYZgLVM43bA44IAiOjq5g4=;
 b=NxTmkim2WWIRuCSfG7KerOKA/y9oANj0ccTs4fbuHVzthzCLmODBzGwFhvoIPK4Vvz
 lmHPlA77qx93qkpI6RC/l6dVhU3rq6SWSqqDzDTh9xd9DjaU/hg07OiKZn7QJCT9Eo9z
 xVTPMch3XB5VOBLlNplK/atqeSgrZOjUkMXouK7tp+eR8fpquniNvKmNSTiCK7iBZQBX
 y3JEYipEyhq+hcb53/TWawducfDFosxvoEi026i7abeMbkJ0VH064H34pP6AluUr+KFf
 a7g6PiRaBmE1ThbBhN0RCZ+MR/+beaVzB/b1fG18DEL3nx0znoSwdo0hbvFcB6HG109J
 961Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734108151; x=1734712951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rf43cUYS4h8CzCvB6H6y5NYZgLVM43bA44IAiOjq5g4=;
 b=i7IIzypYTtlEHxZ5Bs9WoybfBZ/Anjac2yyaMtzl7otsqDxREBrDa5XNRskJ5qYonK
 yAKlys/wYK1NQYYw0hKfsSJQq+rcD7dNtGAtkSJ8vFPAuByer1qClVPmxRgwtLWNaARg
 GjtsSIdTieBnB5jqXjwgM9EDxD0Xj2m2vfhQe/XeXZN3WngGOZfbZgUhkipdswlzT1Lc
 0fKRXC+TChd9pFU59r0PY1mcQ3eNva0ITEqVHM+eXXh6yrAsneJmhOn6iwcdjVsmxjUD
 fzYb4OqAKNtTgp06i0CLKIkWFzqFRKGq16JuYpCqgYQ63LFmn7StuQ5P3kD7YxwYYQGW
 oZhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiGBeR7RCtzTW4c1/MRk0vyTiBhmdh+yFgJ4lKUDR4rdgG9em314CbUX/xWQb36BLm43RGlTw=@lists.denx.de
X-Gm-Message-State: AOJu0YyEizeXNcGNd/hxhe6gBKpih+/sMsH50ggB3MeWoKkQ6Ors9WK0
 btWBWzaQxHJb/ObEKfmIABMkoemBgd1nV5MVX2kvxJMNC18zfbUtm9fE3b0uBnj/uEV33eeKZMj
 57+dJdpSaK1LkJIcskv0kBYoEUHZ48DfQVXY9YQ==
X-Gm-Gg: ASbGncsw1R4F9JLsU5fNtBIS/ED9BfZCZc0h2o+PliGEzIYM0VlAR49Q03XOW6YmOrg
 PIGdR3DTkW1ltIKsl0IvcO0WFnrWH+iNV3JCzkgJeQ4TzOqqxMKYvn6l0MM9SQpNNCznR9U0=
X-Google-Smtp-Source: AGHT+IEy2Njq3UwF/7nh/o2HNa1bww44PGZSfrlAJS7aAFwJIYMhIkyvftBbYb9e2F89aGgmnhQYmVvBP3eXkOZEAmU=
X-Received: by 2002:a17:90a:fa8d:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f28fb63fcfmr5325070a91.14.1734108151011; Fri, 13 Dec 2024
 08:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-5-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 11:42:19 -0500
Message-ID: <CAEfUkU+Z1rPASx9w_PLya0P8mu3XxOR_-uqiiODgtnnGzEka6w@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] lib: sha256: move common function to
 sha256_common.c
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

> The function sha256_csum_wd is defined in lib/sha256.c
> and in lib/mbedtls/sha256.c. To avoid duplicating this
> function (and future function), we move this function
> to the file lib/sha256_common.c
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  lib/Makefile         |  1 +
>  lib/mbedtls/sha256.c | 27 ------------------------
>  lib/sha256.c         | 36 -------------------------------
>  lib/sha256_common.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/Makefile       |  1 +
>  5 files changed, 52 insertions(+), 63 deletions(-)
>  create mode 100644 lib/sha256_common.c
>
> diff --git a/lib/Makefile b/lib/Makefile
> index d24ed629732..17201f66798 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
>
>  obj-$(CONFIG_$(XPL_)MD5_LEGACY) += md5.o
>  obj-$(CONFIG_$(XPL_)SHA1_LEGACY) += sha1.o
> +obj-$(CONFIG_$(XPL_)SHA256) += sha256_common.o
>  obj-$(CONFIG_$(XPL_)SHA256_LEGACY) += sha256.o
>  obj-$(CONFIG_$(XPL_)SHA512_LEGACY) += sha512.o
>
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 24aa58fa674..2128e598834 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -33,30 +33,3 @@ void sha256_finish(sha256_context *ctx, uint8_t
> digest[SHA256_SUM_LEN])
>         mbedtls_sha256_finish(ctx, digest);
>         mbedtls_sha256_free(ctx);
>  }
> -
> -void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> -                   unsigned char *output, unsigned int chunk_sz)
> -{
> -       sha256_context ctx;
> -
> -       sha256_starts(&ctx);
> -
> -       if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG))
> {
> -               const unsigned char *curr = input;
> -               const unsigned char *end = input + ilen;
> -               int chunk;
> -
> -               while (curr < end) {
> -                       chunk = end - curr;
> -                       if (chunk > chunk_sz)
> -                               chunk = chunk_sz;
> -                       sha256_update(&ctx, curr, chunk);
> -                       curr += chunk;
> -                       schedule();
> -               }
> -       } else {
> -               sha256_update(&ctx, input, ilen);
> -       }
> -
> -       sha256_finish(&ctx, output);
> -}
> diff --git a/lib/sha256.c b/lib/sha256.c
> index fb195d988f1..827bd9a872b 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -264,39 +264,3 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[32])
>         PUT_UINT32_BE(ctx->state[6], digest, 24);
>         PUT_UINT32_BE(ctx->state[7], digest, 28);
>  }
> -
> -/*
> - * Output = SHA-256( input buffer ). Trigger the watchdog every 'chunk_sz'
> - * bytes of input processed.
> - */
> -void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> -               unsigned char *output, unsigned int chunk_sz)
> -{
> -       sha256_context ctx;
> -#if !defined(USE_HOSTCC) && \
> -    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
> -       const unsigned char *end;
> -       unsigned char *curr;
> -       int chunk;
> -#endif
> -
> -       sha256_starts(&ctx);
> -
> -#if !defined(USE_HOSTCC) && \
> -    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
> -       curr = (unsigned char *)input;
> -       end = input + ilen;
> -       while (curr < end) {
> -               chunk = end - curr;
> -               if (chunk > chunk_sz)
> -                       chunk = chunk_sz;
> -               sha256_update(&ctx, curr, chunk);
> -               curr += chunk;
> -               schedule();
> -       }
> -#else
> -       sha256_update(&ctx, input, ilen);
> -#endif
> -
> -       sha256_finish(&ctx, output);
> -}
> diff --git a/lib/sha256_common.c b/lib/sha256_common.c
> new file mode 100644
> index 00000000000..7041abd26d9
> --- /dev/null
> +++ b/lib/sha256_common.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * FIPS-180-2 compliant SHA-256 implementation
> + *
> + * Copyright (C) 2001-2003  Christophe Devine
> + */
> +
> +#ifndef USE_HOSTCC
> +#include <u-boot/schedule.h>
> +#endif /* USE_HOSTCC */
> +#include <string.h>
> +#include <u-boot/sha256.h>
> +
> +#include <linux/compiler_attributes.h>
> +
> +/*
> + * Output = SHA-256( input buffer ). Trigger the watchdog every 'chunk_sz'
> + * bytes of input processed.
> + */
> +void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> +                   unsigned char *output, unsigned int chunk_sz)
> +{
> +       sha256_context ctx;
> +#if !defined(USE_HOSTCC) && \
> +       (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
> +       const unsigned char *end;
> +       unsigned char *curr;
> +       int chunk;
> +#endif
> +
> +       sha256_starts(&ctx);
> +
> +#if !defined(USE_HOSTCC) && \
> +       (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
> +       curr = (unsigned char *)input;
> +       end = input + ilen;
> +       while (curr < end) {
> +               chunk = end - curr;
> +               if (chunk > chunk_sz)
> +                       chunk = chunk_sz;
> +               sha256_update(&ctx, curr, chunk);
> +               curr += chunk;
> +               schedule();
> +       }
> +#else
> +       sha256_update(&ctx, input, ilen);
> +#endif
> +
> +       sha256_finish(&ctx, output);
> +}
> diff --git a/tools/Makefile b/tools/Makefile
> index ee08a9675df..237fa900a24 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -135,6 +135,7 @@ dumpimage-mkimage-objs := aisimage.o \
>                         generated/lib/hash-checksum.o \
>                         generated/lib/sha1.o \
>                         generated/lib/sha256.o \
> +                       generated/lib/sha256_common.o \
>                         generated/lib/sha512.o \
>                         generated/common/hash.o \
>                         ublimage.o \
> --
> 2.25.1
>
> Sounds good to me.
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
