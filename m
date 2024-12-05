Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A00BE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82393892C6;
	Thu,  5 Dec 2024 18:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k5M4RqHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD8E89405; Thu,  5 Dec 2024 18:12:08 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0DD892C6
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  5 Dec 2024 18:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fd23d9160dso181412a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 05 Dec 2024 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418724; x=1734023524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vTiuCccWybKS09VDDj+6SmzjRXT4OE9rrAiVg7miLv8=;
 b=k5M4RqHln+pc1eK74q8z7BrqioTAPTygqA01PqxmJj8qwe+L23YgPc8FQjlU/fUz5z
 fX3TB1XzmlWli4BSfdrqO9HACURfXHnmRe5FTHZLc87kVjXNHIPmTqfTtLGw16/bD9cz
 tOJi9SSuLDZhpWGQZgLKi3EskX0S79xKxPCHOIuwVfiPR/8//AxckL9323i51cK4gcwx
 W8sp3pKMWAXfq7d15lyO7wh0sq5SewZkWxKom8mQBQ4xuNVfgpEPPGw13aP3pSRVArRK
 BHt84/u1dScQh7nMMzuUf6/uH4yr2NjCg0BSIdOYusZ6DoTxjvEnEhkSnJg9UOA0sZj1
 aTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418724; x=1734023524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vTiuCccWybKS09VDDj+6SmzjRXT4OE9rrAiVg7miLv8=;
 b=pNtMeNvZxrN6xSu9LWLiiH7jH//RfoDxtaDaMrc9NnFaicAuPp8k/7Kt5gRCwUPoef
 qlkdAiczcAWtgOfk6fN9w3ZqbxInptVAQLvPnJYjXtlJv8NU1pX5rojpGn2DyYYLYN4G
 5wBQM9NHuy8QyJuU/h0Z4zrGQlr1CHZ8FPS60BRjuaB0jWFE+rPsQHaa35QeNJSru+D9
 mglv/b6BhznHOA1FinQLqWGd6/RZj2B2aoOkKEy9BlxHySWRQt6M1yrxxo5x14x/fJlY
 azck2wKqSwc1JOIaqCfW2K0byKSM1+lW70zlI++zdKEwaCxVvsPyMkgYdfUvI4MvM5xD
 dOxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZk6GRilq6oqYEsy/GsSgj4+FrMS9Orik4hNyKxnA6H1PVDJ9cx0hQzsoeAt/OhjkN3GG+yN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwRqD+buV56RmFUkiaiykXYVme/V8BhPrjF5T+Gli3dYu06O0y7
 EFPu/OGj2Y9bsdgBW6OwzabTGU7VOdhEG9aRM9KNcHExAFt9raUfm4s7VUKU5hVMX5P/Q6j3vb/
 0k/CbaEZLrb2CUmGWbfpXffKlppW9qGV2C3/PozJvPFmQMogXaPo=
X-Gm-Gg: ASbGncsNnyzgADuKDN5LdkaxsQYEaqMUeStohYJwCJzijC5PuINgpqY3obwWNNCQtzU
 T7xqxDF3Dcl6v1taQjJH16lsSg9AqhLn6HmWwC7m4hd17aA4Xov31zZnyj3co21xb
X-Google-Smtp-Source: AGHT+IG9OPY79E2ktUFKtG1v0gmbR3Lyx9qVJCclk+4KRNVkDm/JVMI9Efg54z/AeL5FD1ATcz5j95D0hbSiUjwBN4k=
X-Received: by 2002:a17:90b:47:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2ef011fbab1mr19181628a91.12.1733418724621; Thu, 05 Dec 2024
 09:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-3-philippe.reynes@softathome.com>
In-Reply-To: <20241204175437.185449-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Dec 2024 12:11:53 -0500
Message-ID: <CAEfUkU+peqy0T9mhA++xhrm+6x-_pogkLr_DE2C-yb6QiZkRUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: sha256: add feature sha256_hmac
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

> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index b58d5b58d39..77dbcd4553a 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -44,4 +44,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[SHA256_SUM_LEN]);
>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz);
>
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output);
> +
>
Shall we have an inline function for the case if mbedtls is not enabled?


>  #endif /* _SHA256_H */
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 24aa58fa674..1b9fc1a8503 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -8,6 +8,7 @@
>  #ifndef USE_HOSTCC
>  #include <cyclic.h>
>  #endif /* USE_HOSTCC */
> +#include <string.h>
>  #include <u-boot/sha256.h>
>
>  const u8 sha256_der_prefix[SHA256_DER_LEN] = {
> @@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input,
> unsigned int ilen,
>
>         sha256_finish(&ctx, output);
>  }
> +
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output)
> +{
> +       int i;
> +       sha256_context ctx;
> +       unsigned char k_ipad[64];
> +       unsigned char k_opad[64];
> +       unsigned char tmpbuf[32];
> +
> +       memset(k_ipad, 0x36, 64);
> +       memset(k_opad, 0x5C, 64);
> +
> +       for (i = 0; i < keylen; i++) {
> +               if (i >= 64)
> +                       break;
> +
> +               k_ipad[i] ^= key[i];
> +               k_opad[i] ^= key[i];
> +       }
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
> +       sha256_update(&ctx, input, ilen);
> +       sha256_finish(&ctx, tmpbuf);
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_opad, sizeof(k_opad));
> +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
> +       sha256_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, sizeof(k_ipad));
> +       memset(k_opad, 0, sizeof(k_opad));
> +       memset(tmpbuf, 0, sizeof(tmpbuf));
> +       memset(&ctx, 0, sizeof(sha256_context));
> +}
>

This function seems to be generic and should be located in lib instead of
lib/mbedtls.

Regards,
Raymond
