Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D3C02197
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7769800CF;
	Tue,  4 Feb 2025 09:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YMHbP6be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3072480104; Tue,  4 Feb 2025 09:46:26 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C1F800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so5035179276.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738658782; x=1739263582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhmKPnj+vd5AzWTV5N4fPqTuCLA7iDBLrJnyvFUfths=;
 b=YMHbP6bezNfvcUFZNFHA3DHCD950anKp89NDv+Trx0IntBRMpN3gPoKIM48R+px6dk
 5CK1WoWsDot3ONrHrTyWX0CeP33Guqp0KNeC1FezDHr4DYEjj3gp9IcBNaiyAh5jIJdC
 EW+L+BViIfLIYWtgBvnqWMKwBdgyiCwQHExH/fWKexSAWRGH1w2Eufn3ab029SdeuX1O
 d5KRca7tZD7ZZWKtbm4OqnD9BGypvZngC8veVEdsEbZxx+yZFcdjYgG+PPOHAG4aoUQc
 T1G7WSFtqg5spuvoZ+d3QdBHb8/SPuvzrUua2egfV4BoOIw5qFCVgyZeVB48rLPynAsJ
 cInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738658782; x=1739263582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZhmKPnj+vd5AzWTV5N4fPqTuCLA7iDBLrJnyvFUfths=;
 b=X2mYAY8YvrU7nqMmN5AYu5XKItA7UfIi/6DCm5Y+ylcxRGKpsbVbQ8y8SA66r86HTm
 TyS4j9cS9bsxG7EXfakY2LDbFWGc9oLYtSlb5wwxjNOvlqKMoQpGTc/pcLXekBSuQsYg
 FYNvQgHGh1mFmszVcvvdGOCFbkJ1aTcAVSs77/LoNiNkbB1xN9xWLf8+FzXZG3+IGrtv
 yBl7Bly0X5CYz49YW7GFY+Yxq/iuxxQCYwt5LOlfYP2UCZx+RQb7eYQYNj05EwzJMJPy
 GTeQRNbVxdMObC5Gh7yzckiFSQ/5keguwo2cKJj0kq8obSdTTWSKW1elhuq71oHCuVFJ
 hYMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl/ygL3FBnpOmXLBSEwF3D2BPFv8wk6MDxqgYHhbPiXIvr9AX2wmjebqZvLII3Wv8uxYGs/cQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzdbHOqE2Nu/mhLK/v6AupIVgGY8WJw+9gSQrgwY8mczXkHobW2
 2xjJ3kc4AQ7dqQRGDQEoaaLaYQ350sMwak2EeWUIDzSjOC529xNQNqqB5gZzJ//7YDJObzOO3fs
 gXvZq/2ZowTyw5UdPdX0WBPQqH5yjvEbBLBCqlA==
X-Gm-Gg: ASbGnctRdldrJbFyJLNMcTFAXt9m+u4e2J2iSQjOCLaeKlq8PFJpkFUJ9ZNbqhmCZIv
 QX4u9cY8qHDD7JQO0iwbPkC+AHcc1g2n1eDbiFevDNtLd/7Gzvmf4Pypk1BgLMx8opVS0FHnS
X-Google-Smtp-Source: AGHT+IGgKLhRTVdNA7efU1UyBMXW0i+sXTCSfKYhzjWYlfflA6P0H4XVHICwhEsS5iuj9bDyl4lHTtAEamiuko5mk1I=
X-Received: by 2002:a05:6902:f85:b0:e57:37d5:e271 with SMTP id
 3f1490d57ef6-e58a4bf76f3mr19006529276.47.1738658782431; Tue, 04 Feb 2025
 00:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20250203091203.47590-1-heinrich.schuchardt@canonical.com>
 <20250203091203.47590-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250203091203.47590-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 10:45:45 +0200
X-Gm-Features: AWEUYZktnl3NLGc_9sVmfzYFsRr9aLZh444fYmwZmFI5asK2Kam5YuZhVYz9ofc
Message-ID: <CAC_iWj+acyUcJS54JJo7jZyvGm3wRg-zse1EvsWsQL=WDs_GJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] lib: implement strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Mon, 3 Feb 2025 at 11:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Implement library function strnstr().
> Implement strstr() using strnstr().
> Sort the includes.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         no change
> v2:
>         no change
> ---
>  include/linux/string.h |  3 +++
>  lib/string.c           | 49 +++++++++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 27b2beb9ddb..d943fcce690 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -72,6 +72,9 @@ extern char * strrchr(const char *,int);
>  #ifndef __HAVE_ARCH_STRSTR
>  extern char * strstr(const char *,const char *);
>  #endif
> +#ifndef __HAVE_ARCH_STRNSTR
> +extern char *strnstr(const char *, const char *, size_t);
> +#endif
>  #ifndef __HAVE_ARCH_STRLEN
>  extern __kernel_size_t strlen(const char *);
>  #endif
> diff --git a/lib/string.c b/lib/string.c
> index feae9519f2f..691c9985692 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,11 +16,12 @@
>   */
>
>  #include <config.h>
> +#include <malloc.h>
> +#include <stdint.h>
>  #include <linux/compiler.h>
> +#include <linux/ctype.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
> -#include <linux/ctype.h>
> -#include <malloc.h>
>
>  /**
>   * strncasecmp - Case insensitive, length-limited string comparison
> @@ -678,30 +679,48 @@ char *memdup(const void *src, size_t len)
>         return p;
>  }
>
> -#ifndef __HAVE_ARCH_STRSTR
> +#ifndef __HAVE_ARCH_STRNSTR
>  /**
> - * strstr - Find the first substring in a %NUL terminated string
> - * @s1: The string to be searched
> - * @s2: The string to search for
> + * strnstr() - find the first substring occurrence in a NUL terminated string
> + *
> + * @s1:                string to be searched
> + * @s2:                string to search for
> + * @len:       maximum number of characters in s2 to consider
> + *
> + * Return:     pointer to the first occurrence or NULL
>   */
> -char * strstr(const char * s1,const char * s2)
> +char *strnstr(const char *s1, const char *s2, size_t len)
>  {
> -       int l1, l2;
> +       size_t l1, l2;
>
> +       l1 = strnlen(s1, len);
>         l2 = strlen(s2);
> -       if (!l2)
> -               return (char *) s1;
> -       l1 = strlen(s1);
> -       while (l1 >= l2) {
> -               l1--;
> -               if (!memcmp(s1,s2,l2))
> +
> +       for (; l1 >= l2; --l1, ++s1) {
> +               if (!memcmp(s1, s2, l2))
>                         return (char *) s1;
> -               s1++;
>         }
> +
>         return NULL;
>  }
>  #endif
>
> +#ifndef __HAVE_ARCH_STRSTR
> +/**
> + * strstr() - find the first substring occurrence in a NUL terminated string
> + *
> + * @s1:                string to be searched
> + * @s2:                string to search for
> + * @len:       maximum number of characters in s2 to consider
> + *
> + * Return:     pointer to the first occurrence or NULL
> + */
> +char *strstr(const char *s1, const char *s2)
> +{
> +       return strnstr(s1, s2, SIZE_MAX);
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_MEMCHR
>  /**
>   * memchr - Find a character in an area of memory.
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
