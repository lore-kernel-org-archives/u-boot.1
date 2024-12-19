Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70980E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E486C8021D;
	Thu, 19 Dec 2024 16:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xiapdrzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE698022B; Thu, 19 Dec 2024 16:13:29 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442928021A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 16:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso688059a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734621206; x=1735226006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oMkM3kJ0oErNhmv17N47gqklm98ltPloqc0yrCmNV7Q=;
 b=xiapdrzCZRTIaRF34ijCEn4cW4Byir8fQig5eDvU6rkFWe01XH8k+opqYtTr/M7LHC
 nEXwu89i0Kokn+vQJgfIOD1Y6J+YyUOmzmUDwg3u2hSBshC8ZBDTos/aR8Z+tPnmMOBz
 IT9ClbdxisJ1ZlVo6W29qeXcvXaNSDX3ODecghlWmoK293+6A5yomH3TkBfzghzBO9vl
 mIGSjM83H3NB836Ib8oCPVP7LAVYxQcdwTwW/vEeE0Sar3jzESrWMp+e6RaXW8E0rcuU
 FIrR0P1HUjx0/Hq4wxg7cKctI3ERvg1JXhuuqIUkHKfsPQ1f/f5fuJpqQdl4kz8/QkZ1
 nEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621206; x=1735226006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMkM3kJ0oErNhmv17N47gqklm98ltPloqc0yrCmNV7Q=;
 b=alpZs249TcseXq3GkCpOtx79V9GKkHJLjivbxV/RqeNtwBDfqTVrtAXiRLRnAF9nBl
 uTd+rIYSgrwkqBQKCqY/SATNYBH+KA982wgr1tmwZIxgREr8SBfa0DyDb0k99oudsxlB
 mPjqaWjCv+/K41w9A1WXrwI3DQXqBVyMTQFUOlh4fCOJk4mNo8a0xw1OEDEb3SzOQkXp
 rr6nePjUd1vDw1P/BIBk0sDGBPtgl16gbj4Apei9CQd7/WgWgvkyPRZzlAAg4N+Gm9UF
 Gcn/BcuUg/YgLeCl7f+CS7xmM2l5TqLAMFmgLgvO/KQdrA5eIGbOePG4Co78Uh0ZzL5e
 IP9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSPPZnxeXCpZsEbvIB7zU5OYwow7EIBuX4keZiXrICibCUf+7rSbDRjK71HJ1BsSL6fJmf90E=@lists.denx.de
X-Gm-Message-State: AOJu0YwUIyqB6530jRKKpS6p6psWAu00iRYVjsl50DvPZ2L7t3eYzpfg
 d6dKfYjblOiNi6g3wW8f8w694LcJQy5AE4QmJDFYIItRSIZnUYApqymJF6ncR9gu2eJxB1wcaSV
 DmkriE39I7HkcLs2gVIk7SearhLnmOT/9hliTag==
X-Gm-Gg: ASbGncvYZcZ8t6qoUlsM5eJ0bgS8qMoOLP7QfWJu5du1YyJ5fKGWXox9iyt3NTKc7LR
 wpmHZsfCuyOk8bD2Vgh6qOs4iUq/J6xW3W/TdTYDEnssTG/4Rjb1+Kd5eFtYDPjOdtqU/lzM=
X-Google-Smtp-Source: AGHT+IESN8BG0stR1L+gZ5yDWK7757fI/FYWoT0kaAIp5PWn4kvSqrexiLUtS5WbHVQfUSMANS6CFTl6OU8G3Q3au4Y=
X-Received: by 2002:a17:90b:50cf:b0:2ee:f1e3:fd21 with SMTP id
 98e67ed59e1d1-2f443d454a8mr5191217a91.25.1734621205745; Thu, 19 Dec 2024
 07:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
 <20241219130554.49825-8-philippe.reynes@softathome.com>
In-Reply-To: <20241219130554.49825-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Dec 2024 10:13:13 -0500
Message-ID: <CAEfUkU+25yH2e-Ko7p+b2b=Ckfgfn0RSxhzSi0OESVkVw1Q1Bw@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] lib: mbedtls: sha256: add support of key derivation
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

On Thu, 19 Dec 2024 at 08:05, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds the support of key derivation using the scheme hkdf.
> This scheme is defined in rfc5869.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h | 20 ++++++++++++++++++++
>  lib/mbedtls/sha256.c    | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 99cf78e204c..d7a3403270b 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -1,6 +1,8 @@
>  #ifndef _SHA256_H
>  #define _SHA256_H
>
> +#include <linux/compiler_attributes.h>
> +#include <linux/errno.h>
>  #include <linux/kconfig.h>
>  #include <linux/types.h>
>
> @@ -49,4 +51,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
>                 const unsigned char *input, unsigned int ilen,
>                 unsigned char *output);
>
> +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> +int sha256_hkdf(const unsigned char *salt, int saltlen,
> +               const unsigned char *ikm, int ikmlen,
> +               const unsigned char *info, int infolen,
> +               unsigned char *output, int outputlen);
> +#else
> +static inline int sha256_hkdf(const unsigned char __always_unused *salt,
> +                             int __always_unused saltlen,
> +                             const unsigned char __always_unused *ikm,
> +                             int __always_unused ikmlen,
> +                             const unsigned char __always_unused *info,
> +                             int __always_unused infolen,
> +                             unsigned char __always_unused *output,
> +                             int __always_unused outputlen) {
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #endif /* _SHA256_H */
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 7d456a82017..59edcb517df 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -12,6 +12,10 @@
>
>  #include <mbedtls/md.h>
>
> +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> +#include <mbedtls/hkdf.h>
> +#endif
> +
>  const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>         0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>         0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> @@ -48,3 +52,22 @@ int sha256_hmac(const unsigned char *key, int keylen,
>
>         return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
>  }
> +
> +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> +int sha256_hkdf(const unsigned char *salt, int saltlen,
> +               const unsigned char *ikm, int ikmlen,
> +               const unsigned char *info, int infolen,
> +               unsigned char *output, int outputlen)
> +{
> +       const mbedtls_md_info_t *md;
> +
> +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
> +       if (!md)
> +               return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
> +
> +       return mbedtls_hkdf(md, salt, saltlen,
> +                           ikm, ikmlen,
> +                           info, infolen,
> +                           output, outputlen);
> +}
> +#endif
> --
> 2.25.1
>
>
Sounds good to me.
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
