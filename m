Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD8CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 15:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E888801CE;
	Tue, 17 Dec 2024 16:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cm7IaJ0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BEA8021A; Tue, 17 Dec 2024 16:06:16 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8CA801CE
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 16:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fc88476a02so4211549a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 07:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734447972; x=1735052772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ebYB6A4YE0jxMKN7RZJ4CTE0DUbkVPulzWkp7ibTho=;
 b=cm7IaJ0qJ4SaYwDs86Z2nqAQyoK4P4AmuUB0LD1q/wJ2SvJdU0s59VnUesDKwWrNC6
 OnktcClAiXidXU0GKNw1BlMFF8fMlSI0ZO6p3K6hYPqxMBaOV1hszgjESD4dUQfs+4kW
 d97q8y2zdUUrKNX+2uF3iczLawugbFmPsyRSEBAKOuAVtUT8gtXr4jZi3xHwZVDA/Ufj
 Wt4ellB+4gozVN9KHWR2T3Oirrq/zqGOyQaqypIIaLuB+uA5LjKq+9hZrDzK22mJYUfE
 V9IXHq2YL+mmaX8If3NMG3xcnBFC+nH/Mj8Uf+srVwy6twq6+nAOFXAPwe3qG/uIacbw
 sN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734447972; x=1735052772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ebYB6A4YE0jxMKN7RZJ4CTE0DUbkVPulzWkp7ibTho=;
 b=gTE7eNJ66DMSxq+KMpj7Ts/49SrVbJhHPifX7hp/xGO/dieFZ/91OXAY29S3eCaxFo
 vOVzdmbgm5V6Yw2L8sU69YBRXz1amLPY7Gu1GYKpgjJPVTTea45MLQOtyNOALeBRvEJX
 QlIepKp2LEvOeOPnCaqRJdhb8LiuFxpRviKTq1VcYNTP8M+4LFjUzlmp12A3PncqCIiw
 LwWjd+SPk7D+9tCryrbdEjWaCH/UwpU4kn7PGHsk+l1EdtDymDEisVjab1EsABuIskqv
 WnulvvHmCSCxZR+JMQ3mzMiZbiEQ/ffhSKrf9K8Kvp/1gWtScm8YJ9rXC0w1DRsJuetz
 BZeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiISoOmwJLplhO/AgfnoeksFQuL0mZIt20Rxb5MXtOhdjo71bnIN3WSxbqxgn/OatWKeu/9wc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8eoPqIz6JzF1gMWj1v8An4idzamATyaCfLzc+IeYTeM6Qsfbv
 ot4IA9gXvTCK9DQq0NhL/fxb7iOLEEiLEC7v4aVnVKWRCdQd5dS0FCiISo7i5jx4OF7nynTOLFW
 GGzFaHKCO4K3jZjflYa8C+yS5KNdK2QrFyMn34w==
X-Gm-Gg: ASbGncsbQnvUomrNj+cMj42vQ98DW5UG4hF16j/7+1I964BirBij9EZwLrWWSnxYgDH
 mEnMhQ48rpfHvTBBoSnuLySOFmtmSeBe+bx3HOOD/xiiHZSScCkAzFbopb62PGpw/NUgDaFI=
X-Google-Smtp-Source: AGHT+IHtUN4b5n2a99LGCAnFV2/VePTvuiZNDXFjLoPd6+O5FysSY90ryT6f3K+m01TdQlcFBgTnx4SGMDwiv5gjyHg=
X-Received: by 2002:a17:90b:3b52:b0:2ee:ab04:1037 with SMTP id
 98e67ed59e1d1-2f28fd7040amr27620819a91.17.1734447972002; Tue, 17 Dec 2024
 07:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-8-philippe.reynes@softathome.com>
In-Reply-To: <20241217083212.70330-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 17 Dec 2024 10:06:00 -0500
Message-ID: <CAEfUkUJdk2qS8VWp8GfghJyM6cLJDsr2mCyoLydAAh3Ziod5zw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] lib: mbedtls: sha256: add support of key derivation
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

On Tue, 17 Dec 2024 at 03:32, Philippe Reynes <
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
