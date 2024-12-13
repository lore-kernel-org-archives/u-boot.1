Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C057EE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA6A800D7;
	Fri, 13 Dec 2024 17:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FahS0f9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CE080104; Fri, 13 Dec 2024 17:58:32 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F3D800CF
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 17:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fdc6e04411so1236289a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734109108; x=1734713908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LNNyhkF7Vkv1L83JopLvpR2tzO8usFx7wUBt1xBR5TA=;
 b=FahS0f9/kiC9TWsKZjLlxZ9YPBmFFy24sBJSYhEtIOOtfkNt4WQAPysgKb4p3UWY6p
 HwdNHbz8fW3i20SqWz5M5UDntJgLnMgWHPhMcvWxyPrgtcCmsVzk23Y3Dl7Gxw6UEqAB
 TSDgvzUU8GN81sRj0GYdv+scfl4OT2TFO/OLYpgRqEbHwsnDQHLi54ybBiNJff+kvH70
 Y0KJy1mSO9QVw2qbVSI+HW4SKEA26qkWb15poFNTWMgo/m4V3eXfyiUCvs9cqjvrcVU+
 EI1BC08ZUKVPKksS4U0Kocsr0LKZny0IlTktwb//lmQmlwmD7b79mQ5Hd0LctPlgMOvU
 a47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734109108; x=1734713908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNNyhkF7Vkv1L83JopLvpR2tzO8usFx7wUBt1xBR5TA=;
 b=lQXGfM8UvvmdALrhcUFwdr7KKT4Kc75F9KnYDQbOwrCvTXeJHXw+0Lr5TL/HCbXo2s
 KEsG/y4QfOWNecjz7ITUiy8VxaS//7kHFeeV6VVfEgO2e/oPALFF6dP0E2hyjTpdkrES
 TMH5PHjGyJairoKHXVm1ewtnIGOCsh3zjMQ+ib+zuNHtNj9j4LS2caz2D8EEiloX9xBj
 aJdUlwyD9nDYaqvBKwnm6vVwTy/3rr/I1e9Hgchz+1hrpM7BPCVn1sLH7BgL2sezSWo9
 m7bY/WLf0j7sYqtbHxiTWXEYVmkQL1xGJ70lJglslr/GN59f7T9V8UEsRHVog3qRc5f/
 ewiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrtYriGAV6ZmnAvmVONu6xFHmIcHfQEbxEm162TgU1YnlOwBax0Ycx++XFYOksGb/mR409/Q8=@lists.denx.de
X-Gm-Message-State: AOJu0YzB0Q790+/O9wwk6PMDp41zo88Ph6easRPXIpROxmZ0CGPLt3VM
 N0vtFYcOXYpsNvOUo/0M5dR45cJV/qdpUq9P4V3wL/Mvd+QFzv7SxPyrLpX4C9R4CTY96CpvN9F
 YqNkBJ//qcLW/AAMPs+GYE2FERq0ztKt3/FZm3g==
X-Gm-Gg: ASbGnct6d443vlHxZnGCda4q0+fvCtROYGYix4I0Es4jAwg24k7l0Zg1T574JlZwSX7
 hbblXUqWYTpiogpZJvppitpmhKaBLfnOuW/IqS0wa6WItPdhXCAewcWj7gPKw6J4k0qOHanQ=
X-Google-Smtp-Source: AGHT+IETST3+7Z/WAxLhd58SFsn+caMbB2DeTwO3kD+bejw1s/8RKjVcIQEUataoVM6MknOTfQKcJSkqi5iBneaiLKQ=
X-Received: by 2002:a17:90b:184f:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f28fa54f41mr4899362a91.3.1734109108632; Fri, 13 Dec 2024
 08:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-8-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-8-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 11:58:17 -0500
Message-ID: <CAEfUkULeJipeyYGC1kvRQOubESupRt7ezG0a-Q3DZTmDR6rE-A@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] lib: mbedtls: sha256: add support of key derivation
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

> Adds the support of key derivation using the scheme hkdf.
> This scheme is defined in rfc5869.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h | 20 ++++++++++++++++++++
>  lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 2f12275b703..f21173305a6 100644
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
> @@ -49,4 +51,22 @@ void sha256_hmac(const unsigned char *key, int keylen,
>                  const unsigned char *input, unsigned int ilen,
>                  unsigned char *output);
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
> index 2128e598834..b8bc43b612e 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -10,6 +10,11 @@
>  #endif /* USE_HOSTCC */
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
> @@ -33,3 +38,20 @@ void sha256_finish(sha256_context *ctx, uint8_t
> digest[SHA256_SUM_LEN])
>         mbedtls_sha256_finish(ctx, digest);
>         mbedtls_sha256_free(ctx);
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
>

Please check if the return is not NULL.

+
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
Regards,
Raymond
