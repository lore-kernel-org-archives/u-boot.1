Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D99E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C665089634;
	Mon,  9 Dec 2024 17:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cRx7MfCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5272D89490; Mon,  9 Dec 2024 17:28:21 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AD589698
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 17:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so3346768a12.3
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 09 Dec 2024 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733761697; x=1734366497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xWD5ioAVVx1mndZLTl1r+xi7b+78Gsv8Ylstt9hGnHs=;
 b=cRx7MfCG3TogiGBs2BD6DBhVCU+7RBneeceuq6rCeXfc3cwj6E30MIwMX3jXsdO+Wa
 fsXhjVoNOtQ9uHKw3F43as0o7/P92J2yo2lUF8SE/43HI2Wa1JdRQjD2WSQPpaFGaW62
 dqNx6U+VclORSY032iE6b4oivVYhH4lpGr0CnQAWPrWwZMR6C+sux7TqzI9krbcTgCz5
 rTi36CWkVc6uhc7B3rhlsAc51El0+fvjMFS224R5OCmuBu7BSXxQqOLjt6KuDfeKLKFM
 23KLpzXMdWmihwEY7l2xG9W7C9YGiUy+CS8VuRchqh/n4CzOZ133lHcsy5WKmRBi2UyE
 QBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761697; x=1734366497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWD5ioAVVx1mndZLTl1r+xi7b+78Gsv8Ylstt9hGnHs=;
 b=E2DehPggxz+DZI6DHX4uMh8Tn3yBdjQF7YbZRRrUS2xZYzbThNq/z3kIEcioJj4XFq
 OgjnC3rPhP3XEzgR9QkieTXlZhCPka/1a0ol70rZHo00qVfKctce8ZtuQaHgjeGm3/tv
 hhCvpw/KCdrJ3GEpdXDMU9+YoUeg/arSKebhR6SrTFUll8XhvQLxe3/7dEGPWovXdiK3
 E44KiDZY41V6+yyHYNlJUcELyrI7ZnT4G0kJ3jUJn/EPl6UViLkck2ZhM7dKWLVOqJjd
 +F+8W1P4zccjObrg+E97m8F/fuafY+xdvY4pq7mv9V/8spP3Lc2zgUjbwsaSO6ggR3QQ
 /CrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3gV3lSPS5s1t48i884/+W0DLu4i5jmm9u1t+nSEoIqkHJlrubEMNRUAWPLvTzIkg+hBy1NA=@lists.denx.de
X-Gm-Message-State: AOJu0YwLcZXzZiZUFG+IxUBf8O8WuE4QzHDqtv8hQ4SDxmwdfSSD+ICX
 OfwzK30JKLISd9Bn4GBlpEYYoM8M/6oi5m55Wq0bSRsc+enNzn+EAr6y/z3pbrgN34bJrGgwQcj
 E2O2TYomUJ+0LhFeMtaGSCazucyp7iPQn2QwO1PwldwPGLsmrrUQ=
X-Gm-Gg: ASbGncs8MtaR8SD1V33Ufwa4F/xvX2TpUHjetCEMTfqyNYBRu8sTltaLWWhGAELFWAQ
 OezFPEliH0NPrAvOeUnABkP8t6+9KW9YhVPIoxOT66LpO/ReIUJHIvhmrJ7lTlhqD
X-Google-Smtp-Source: AGHT+IGvyHE08OSMHHKXGos8s1JVXS0X89mcrKUbmpqJIXVlRL0lXVOBdKhON/oMr+wrhCX0BPoWA2T8uNrNI/PG+QY=
X-Received: by 2002:a17:90b:5184:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2ef6ab0d5b6mr19692782a91.24.1733761695662; Mon, 09 Dec 2024
 08:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-5-philippe.reynes@softathome.com>
In-Reply-To: <20241209094159.8355-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 9 Dec 2024 11:28:05 -0500
Message-ID: <CAEfUkUJ7OwWrFpzwMPsf0+iPcDht6iazKHDpStksDCAf3FR03w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] lib: mbedtls: sha256: add support of key derivation
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: raymond.mao+nodisclaimer@linaro.org, sjg+nodisclaimer@chromium.org, 
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

On Mon, 9 Dec 2024 at 04:42, Philippe Reynes <philippe.reynes@softathome.com>
wrote:

> Adds the support of key derivation using the scheme hkdf.
> This scheme is defined in rfc5869.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  7 +++++++
>  lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 2f12275b703..5643efcb85c 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -49,4 +49,11 @@ void sha256_hmac(const unsigned char *key, int keylen,
>                  const unsigned char *input, unsigned int ilen,
>                  unsigned char *output);
>
> +#if defined(CONFIG_HKDF_MBEDTLS)
> +int sha256_hkdf(const unsigned char *salt, int saltlen,
> +               const unsigned char *ikm, int ikmlen,
> +               const unsigned char *info, int infolen,
> +               unsigned char *output, int outputlen);
> +#endif
> +
>

I think this will be better:
#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
int sha256_hkdf(const unsigned char *salt, int saltlen,
                 const unsigned char *ikm, int ikmlen,
                 const unsigned char *info, int infolen,
                 unsigned char *output, int outputlen);
#else
static inline int sha256_hkdf(const unsigned char __always_unused *salt,
                int __always_unused saltlen,
                const unsigned char __always_unused *ikm,
                int __always_unused ikmlen,
                const unsigned char __always_unused *info,
                int __always_unused infolen,
                unsigned char __always_unused *output,
                int __always_unused outputlen) {
        return -EOPNOTSUPP;
}
#endif


>  #endif /* _SHA256_H */
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 1b9fc1a8503..6e9659d31bb 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -11,6 +11,11 @@
>  #include <string.h>
>  #include <u-boot/sha256.h>
>
> +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
> +#include <mbedtls/md.h>
> +#include <mbedtls/hkdf.h>
> +#endif
> +
>  const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>         0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>         0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> @@ -98,3 +103,20 @@ void sha256_hmac(const unsigned char *key, int keylen,
>         memset(tmpbuf, 0, sizeof(tmpbuf));
>         memset(&ctx, 0, sizeof(sha256_context));
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
