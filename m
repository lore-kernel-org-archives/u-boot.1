Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDBCE77178
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B937A88E35;
	Thu,  5 Dec 2024 18:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rbUS7J9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FE689506; Thu,  5 Dec 2024 18:19:13 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808598760C
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  5 Dec 2024 18:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so1028304a91.3
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 05 Dec 2024 09:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733419149; x=1734023949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QepdGKrjvFRhCAXYwQn+37PselgKLIOZtuyJXS+IgOk=;
 b=rbUS7J9+Z7yxu1aFwJmfOmYRVJIhQxM7Um7KsfsQIfFjHWB7sIUO4JTj2mzcq8JmAc
 IIHYhuLbFV+5bnVatuTI/3ZpklB98xme0HTVJGIjjI3aYeyTdnDk6zDyuAL4CrSesbCA
 a+bWZ0Pp0gosZTg0+RVBpxdChJVT/TRoyTZ24eamX/OdfC5ctOepIUs2mN6+bO6h8FNd
 96wGatB2d5EdzZMPI2eMwrNp5MJVgZiIzlTvPcbLrNsnagWnyXIipUgD8wqTQAHLX3M0
 B9QUUqkN9YkIXHj8Z9eUZerayXZtFLc7jmeCe5VXo62NimhAF3A5wr0wSs20NthstjVA
 OB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419149; x=1734023949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QepdGKrjvFRhCAXYwQn+37PselgKLIOZtuyJXS+IgOk=;
 b=WZl5KCBgKa1Kags9HZBFa2s4anxcJyTw9a5sZj4od0xD19CM/ag6i25cGGiWgijF4s
 v+tyQUAniO/zy6SgfnSDBlTOkrlzaOubcWWXQnenJ65Ie8BlUfGynQLmTHOxUlOMGq21
 fB6W7dr+VGC6LJjFSi9xnIoNUboERSTsCHtN4HqGVOgXmwkrIRCnCJZCyoyaSPtf4eUQ
 zEkknCGt1puj0Cmx5BCGAPyat0zM6ZfhMflO0YzsJy3a+cxxx2zIb7N7HPI2HRkncmQY
 DKlRqqVgtM6JWALI4KaKpd57FjYBfWa1ROZOFCBQE2XNR5v2oNEA7YaKSKLlt9hbV8rh
 8jxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHSo2Kf3vVe0gGmukxYDkpsH93D/mHEYF3cwE0bBjhcAo7tn31bJCqZohyIsgonO9h5kQiyCs=@lists.denx.de
X-Gm-Message-State: AOJu0YxldRfY1arFQ0Tk0Y1CsYjy/RW8NoaZ4+wlQbJmS2sm0XDyTQFS
 qOrnk0fiKfw9Qlka2vxh1DQVoO4q/bPWMaNZCxRYTb2KhgUgdxwSjxHhN8bSCuvMOZXo28UOt4v
 dZPdEM3r3C6JzdklxpTWEMtQ7g8wfuLqcbOgwcT8oxTE5Gq0iwXM=
X-Gm-Gg: ASbGncuROXgRjCUWhAHK678ogBNbRj7+zYHVUpFzU0pxcIWvS3S2XoYrln+0fxCSAsN
 pZqrUUvlOJiceSTqVuv0xPFK/I7v7Y4b/IGHMgKBgF4upE7BXaT99weKZwJPXd9oi
X-Google-Smtp-Source: AGHT+IHPrlpQ1WLRyCWKapwAv2yoJNniW01Ru2bhqv8aiY9t8kVBeH7/mI3IS76KxSAh5rGQ19eQWEUlDGjfkXZbU6w=
X-Received: by 2002:a17:90b:3c09:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2ef0120cd6amr15242048a91.20.1733419147908; Thu, 05 Dec 2024
 09:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-5-philippe.reynes@softathome.com>
In-Reply-To: <20241204175437.185449-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Dec 2024 12:18:57 -0500
Message-ID: <CAEfUkUL=wrwVbVO9ke-XAfK+4qMro-wNCyxaUg-GzaN-5T4R8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] lib: mbedtls: sha256: add support of key derivation
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

On Wed, 4 Dec 2024 at 12:54, Philippe Reynes <philippe.reynes@softathome.com>
wrote:

> Adds the support of key derivation using the scheme hkdf.
> This scheme is defined in rfc5869.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  5 +++++
>  lib/mbedtls/sha256.c    | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 77dbcd4553a..0a6e309e3ab 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -48,4 +48,9 @@ void sha256_hmac(const unsigned char *key, int keylen,
>                  const unsigned char *input, unsigned int ilen,
>                  unsigned char *output);
>
> +int sha256_hkdf(const unsigned char *salt, int saltlen,
> +               const unsigned char *ikm, int ikmlen,
> +               const unsigned char *info, int infolen,
> +               unsigned char *output, int outputlen);
> +
>
An inline function is needed when the build options are not fulfilled.


>  #endif /* _SHA256_H */
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 1b9fc1a8503..c38e3e5818c 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -11,6 +11,9 @@
>  #include <string.h>
>  #include <u-boot/sha256.h>
>
> +#include <mbedtls/md.h>
> +#include <mbedtls/hkdf.h>
> +
>  const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>         0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>         0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> @@ -98,3 +101,18 @@ void sha256_hmac(const unsigned char *key, int keylen,
>         memset(tmpbuf, 0, sizeof(tmpbuf));
>         memset(&ctx, 0, sizeof(sha256_context));
>  }
> +
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
>
Missing `#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)`.

Regards,
Raymond
