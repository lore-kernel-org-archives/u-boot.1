Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 07:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF29801DE;
	Mon,  6 Jan 2025 08:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrpczfOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79044801E8; Mon,  6 Jan 2025 08:44:28 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7A880137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 08:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso87283335e9.0
 for <u-boot@lists.denx.de>; Sun, 05 Jan 2025 23:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736149465; x=1736754265; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//K68L43PQOhXrvLk0oWIlR0yV0ovwnZsVi5UPYFrTg=;
 b=rrpczfOPN/f14vpS2fR0SYGek1K+SZQHvQ5dkMGadgLqPdB7HzjvxRWOPZ0hBO74EF
 2/pAdG2hW7le76GJqrQUdMLF0JPNn/lzuutOpA8JoR/Ub/TPGqy7RbKXJBUCdmE42J6J
 WBteOdfYRz0nFG4q489V3qnLJX86mdNDQixhhj6Y43xuwg8gNV/CI6wspAnD7VVjdxvz
 ehyp+3lv+gzwNhYxxs+kaU8vH7YFEiV/uzM0Z2/AOtE9Oun+vCH5AneOrarBQigmCvkl
 NOW2UPrk6pp0JzVmF6xA6FONCQPYdpRxJFi9/8r3kSElRdFP07pRr3w0SuiDGH6fjd28
 mqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736149465; x=1736754265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//K68L43PQOhXrvLk0oWIlR0yV0ovwnZsVi5UPYFrTg=;
 b=BhVPqJLOaPPPSROUicNcZIVZZQItzqknqGUGHvIcDaoJjdUfA/coAOlWZjLV0/lkrh
 4pu8Vng61tFzN5jw45h9K4N4rmmQsae+DZBw5cG0+ETPW1BpGvtt1LcobqXJiqrXZ9yD
 RbkKbQ78W0BRCW6SuspLJtyMcUfzMVOy0j79R16ZY024V8adh92d6CzuJWtWBsPxpCdX
 bNgL4JxkvkqxxMdVc7eIJXrgp9zkpf4q1Tq+FM3SJN5sOwiUfPa5t/UoIuVQdQ7UUvsf
 Mqk0BPKrBcV6XtEM1LKLUKWnKrh/If3vBhM1N0v6AMy86SDc0Y5+PcQXIalGO47Zh/p3
 fFdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr65QVFYX3Kr4SeU/bupAwDkZ7zp9hQypMQaTsxtuh4ClA0RHlamyUAnYXROv9CgDmq0GnzpU=@lists.denx.de
X-Gm-Message-State: AOJu0YwN1+mJUAf35RhILlz63wEvX1JGap89NVfE07e+UYFBx4cTYgNu
 GF1qEdnmWdgjh92SYzEJrMHKM0OBGf3T6zoHZaFd+n0SjY5S2931YYazwkwC/Ls=
X-Gm-Gg: ASbGncuHVhIpkMt/buwwkxDmFtXBjyvxc6e/n8jz75PFiefUbp8XtCiVeG/aupyeaJ8
 B5aFYS3DCzEfC/3LwqtJgZAQIULYhjTnEsgszXYRHk8hoT8F1w6hrGKY8lOrtlspx+vhN82p8JK
 SKFXxMUnHPK9S47uF27wbsaOLgfO2Tl6lP/Fjs0CiGZS+ozm2jUCHWzxk0fi+1j4rcLuWTHdv55
 MNjA+HYs4GmNuDJWxGQsbueHziCdWrPUBTKfhFz90QwS36bfJrVTDToqxqaGfZTPgMxUnZIsoi7
 AadnQTrw9kgdgGPI7La564Q+RiidX18GVG97
X-Google-Smtp-Source: AGHT+IHJRqgEt9Q1z3dmZo23K49xrmDiwBSKyf52WxJhmAgDJU9aVGT+XRA47TuvdFbjTG5Q2SisOw==
X-Received: by 2002:a05:600c:474f:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-43682a402ecmr354116925e9.8.1736149465330; 
 Sun, 05 Jan 2025 23:44:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc?
 ([2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013a1sm597636145e9.11.2025.01.05.23.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 23:44:25 -0800 (PST)
Message-ID: <196cc091-5031-426e-b5ea-923065b2b026@linaro.org>
Date: Mon, 6 Jan 2025 08:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib: implement strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250103232118.711135-2-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 1/4/25 00:21, Heinrich Schuchardt wrote:
> Implement library function strnstr().
> Implement strstr() using strnstr().
> Sort the includes.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/linux/string.h |  3 +++
>  lib/string.c           | 49 +++++++++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 27b2beb9ddb..8a377a8176a 100644
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
> index feae9519f2f..d5a486fb89d 100644
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
>  	return p;
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
> + * @s1:		string to be searched
> + * @s2:		string to search for
> + * @len:	maximum number of characters in s2 to consider

You mean s1?

> + *
> + * Return:	pointer to the first occurrence or NULL
>   */
> -char * strstr(const char * s1,const char * s2)
> +char *strnstr(const char *s1, const char *s2, size_t len)
>  {
> -	int l1, l2;
> +	size_t l1, l2;
>  
> +	l1 = strnlen(s1, len);
>  	l2 = strlen(s2);
> -	if (!l2)
> -		return (char *) s1;
> -	l1 = strlen(s1);
> -	while (l1 >= l2) {
> -		l1--;
> -		if (!memcmp(s1,s2,l2))
> +
> +	for (; l1 >= l2; --l1, ++s1) {
> +		if (!memcmp(s1, s2, l2))
>  			return (char *) s1;
> -		s1++;
>  	}
> +
>  	return NULL;
>  }
>  #endif

This won't return s1 when s2 == NULL, will it?
Why not use a known good implementation such as [1]?

[1] https://github.com/freebsd/freebsd-src/blob/main/lib/libc/string/strnstr.c

>  
> +#ifndef __HAVE_ARCH_STRSTR
> +/**
> + * strstr() - find the first substring occurrence in a NUL terminated string
> + *
> + * @s1:		string to be searched
> + * @s2:		string to search for
> + * @len:	maximum number of characters in s2 to consider

There is no len parameter

> + *
> + * Return:	pointer to the first occurrence or NULL
> + */
> +char *strstr(const char *s1, const char *s2)
> +{
> +	return strnstr(s1, s2, SIZE_MAX);
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_MEMCHR
>  /**
>   * memchr - Find a character in an area of memory.

Thanks,
-- 
Jerome
