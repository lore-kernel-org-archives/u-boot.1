Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7026CE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C433B89533;
	Mon,  9 Dec 2024 17:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YS018WR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F118F89699; Mon,  9 Dec 2024 17:06:30 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDF689490
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 17:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so3246217a91.3
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 09 Dec 2024 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760387; x=1734365187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ru6w6ceDS+R0Fg3VDNsXtjjF+Q3nGucvWG4fuySO6sw=;
 b=YS018WR0V85CYCX+isiJh3ZTtWXpkk3YBCtbcMKj4xF+YFmXZN+lUNQRlNNEhZwtIe
 hGS2lIDl54FWqBH/D5CR2JmNrOxhxEcrWINfN6xTpoKjSvhanUnL8xwXTGRMyG1wddcH
 txUojjT8CMJykRQRJwWeEh5wWDUnvk7LubfQWhG52Kz+Tc/eHI2CAOjLm/jlKvhogk80
 O2lYlwA1UX3KOPnwsxwwAQBSjyCywAyCVvCKM3hIYRdjxoUyE56DOYl9XqzJ0+k9j8i9
 xULOLjucVJ+GB6cFNWKdsJiGHl5C4N09XWRzsDVI0rUpqlB+rSx9aWLo7hAxTKiXrynE
 k5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760387; x=1734365187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ru6w6ceDS+R0Fg3VDNsXtjjF+Q3nGucvWG4fuySO6sw=;
 b=oXcCB3YNu6ZH+6y0SpsXqyJcKTANUc7YelRwOiXG9LIcmiHKWZS9SXFt+lPKKtUEwy
 E0YzNTzKE8r+qyH+oMj91POc8Tf/gOEuLI5bsgkTa1fgWihrnUgOmkRwk/dRwLOuS050
 ZZaBgds2NeZwm36eca9IwJkdUP9aze8zKROH/E3fQmXqZnDUdOCwbnQcdUByUWPSsWom
 ydSuyPMZ3htDH9ASU1xwelOJwO8+Ww3Nkevv5hbZWzCo6J1YWEEcrDUxl6Avhtz78YxN
 Myi3b4UjUdw8UDXh545OsHidwlh70xnDOl+GGC925Q+L6LxH/kfDbW8GCYDIBuFc374o
 PXgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFObbLoLpcAwTd8MhYJADbKMq7nEfYAqHnX4mffpfWwePIlcznSePXZ5Z3LJX/VKfoy1/r0V8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+ylogCWzkE4MCDZyzU8k74U+lkhS3q9c4iXyWH4MmF7fUUHmz
 OAIg40Y/PsMji2rqXe0JI926SpFJ8UuH0GYRLTmHVNnap+xV0Cf8DaeFPCfj00lNlUHvf2NWscI
 XFTLgeQSRFN9LEzYawDApeC0p0VIefYm+3LZFbGIicd3u2KntMrA=
X-Gm-Gg: ASbGnct/R2TBpwnfUxszr9QqsRA38E0VM85tB8gNPxNa94aNhtoEnNC6TwoZ6sBrQRN
 TuJ6z4tTCAovmXDOAwWzro9K172w49MMm8ghS3TzPxQqvrk3Km1W7XV/0w0pr1rTq
X-Google-Smtp-Source: AGHT+IEGAdw6Bqgr2AT6Ic4YJGRRC9ES6nGK/x6pnK0i308DR0t7jcnjDPSzoPBT9SxFleyGG0sbPhUBGrCp11jR5B0=
X-Received: by 2002:a17:90b:554e:b0:2ee:97d1:d818 with SMTP id
 98e67ed59e1d1-2ef6955f87bmr19383848a91.3.1733760386590; Mon, 09 Dec 2024
 08:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-3-philippe.reynes@softathome.com>
In-Reply-To: <20241209094159.8355-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 9 Dec 2024 11:06:15 -0500
Message-ID: <CAEfUkU+7+mjckwERnr-rk2YO8z+VfT3EJKfNO9nOYHivyi-g=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] lib: sha256: add feature sha256_hmac
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

> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  lib/sha256.c            | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 44a9b528b48..2f12275b703 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[SHA256_SUM_LEN]);
>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz);
>
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output);
> +
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
>

You are assuming that the key length is at most 64 bytes.
But according to the HMAC specification:
If the key is longer than the hash block size (64 bytes for SHA256),
it should be hashed first to produce a shorter key.
If the key is shorter than 64 bytes, it should be zero-padded to 64 bytes.


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
> diff --git a/lib/sha256.c b/lib/sha256.c
> index fb195d988f1..66224c92dd9 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -300,3 +300,40 @@ void sha256_csum_wd(const unsigned char *input,
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

I understand now we have duplicated 'shaX_csum_wd()' under lib and
lib/mbedtls.
That is because at the time when MbedTLS was added in, _csum_wd() is the
only
duplicated function and it is a trade-off comparing with creating a new
common
file for each algorithm.
But it is not the case if the number of these duplicated functions is
increasing.
Do you mind moving them into a common file with the one you created?
At least for sha256 with this patch I think.

Regards,
Raymond


> --
> 2.25.1
>
>
