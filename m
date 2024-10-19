Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8679AD3C902
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 09:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B2088C60;
	Sat, 19 Oct 2024 11:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBwg3WLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF3388D13; Sat, 19 Oct 2024 11:37:53 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD4E88B16
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 11:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso3139800a12.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729330670; x=1729935470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AxbATNa15mfHMYFqo4CYvV5nbxF1d15L/r6xe6R55ug=;
 b=VBwg3WLZWZgY2cSkXphCOSkJj+e95g3WsFT0HNQRgI3ZuPSAWrrGPMVjcvBhmxI9Zh
 I1WfDYjA0hvdR03YBUT9KZQEZvrZGIQSUFlmQCRtQKIUhzddUIVg+4AQx+YdYBfmLNDZ
 bM88YnvW8o4MM3TLiuanKjhoxHKvn0BX6IRBRfGdH0+TmfWLuBPXGSTCBAQTiv1HWZvn
 DrXGOnEsriDn6SJpY0E25hN+PpbLAmwvIX6bIMkg/GyLBzEm46WlI+vEE4EtYRZgwojF
 lMU/y/S6Jk7YKQsPUeqtXSzn3ez95ArZkS2VMit7nVKvdXeAg8SPAZjl38JoOk3waO5R
 DZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729330670; x=1729935470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxbATNa15mfHMYFqo4CYvV5nbxF1d15L/r6xe6R55ug=;
 b=ZxkruxiK13CWOp8pEWojTRTTbUP51xW7YtwWcYDhKcsx6MnE6ZYPgtpzXe7ZxC7ERl
 mdc4+Fym18OMsjL6yge6qRJWcncDjIUMepV7Nf+/TG8wMEuXnXRzkNOuJJpsnZ1P9bRQ
 ogypDIA+R7mS0s8aGZ5LP/Ycvm0LTYIFnZpSGq2nDhCUGmHy8BbkGhLS3lHony69RqCx
 lxXIJttoyIa7c+pPiOyV7rMfIV8RSTVCDLie59knpIVvjWlAPS/PL2pIwjRwMPAvxPBy
 OhL7d3izNkwNNqy4rrt10N+Pyn7e33dsb9KmStiG6qTDaORZuHsRbgRVHWJai1AcRjY4
 FBKQ==
X-Gm-Message-State: AOJu0YyGf/qrWLNXOfkcK2fX3FHzxqzSjmHf+fwYk8hr4Aur9e74g3Cv
 DDHbnw11q4QrrJHeowKM8UUec+PxGL+tiADZlm5BPeW0Z2hgbpafkIfi0ra0WYBxtXlAx3zEICw
 1tRq9YvFN1H7cG6aEkzAEMKhVDOUoYQ==
X-Google-Smtp-Source: AGHT+IE50b/CLptow+Xjy40TwpDq681+4Bld1PhBmoM/3uKe0T2wy4kH6+MydIZJVNbTIePihD8jHZj6gyp5V2cTrY8=
X-Received: by 2002:a05:6402:1e93:b0:5ca:da2:b2ca with SMTP id
 4fb4d7f45d1cf-5ca0da2b46emr2812572a12.19.1729330670306; Sat, 19 Oct 2024
 02:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241016234829.3836359-1-raymond.mao@linaro.org>
In-Reply-To: <20241016234829.3836359-1-raymond.mao@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 19 Oct 2024 10:37:38 +0100
Message-ID: <CALeDE9PpzBEQBYXMf9VCDWZD76LmEj0X1fq9W-=wjdwNOD1-nA@mail.gmail.com>
Subject: Re: [PATCH] mbedtls: fix defects in coverity scan
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, 17 Oct 2024 at 00:49, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Fixes of unreleased buffer, deadcode and wrong variable type detected
> by coverity scan.
>
> Addresses-Coverity-ID: 510809:  Resource leaks  (RESOURCE_LEAK)
> Addresses-Coverity-ID: 510806:  Control flow issues  (DEADCODE)
> Addresses-Coverity-ID: 510794 Control flow issues  (NO_EFFECT)

I think it makes sense to reference upstream commits/PRs for these
sort of things moving forward, Tom maybe we need a policy around the
third party libraries now we have a few more.

Peter

> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/mbedtls/pkcs7_parser.c     | 7 +++----
>  lib/mbedtls/x509_cert_parser.c | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> index 69ca784858e..ecfcc46edfa 100644
> --- a/lib/mbedtls/pkcs7_parser.c
> +++ b/lib/mbedtls/pkcs7_parser.c
> @@ -206,9 +206,6 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
>                 p += seq_len;
>         }
>
> -       if (ret && ret !=  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
> -               return ret;
> -
>         msg->have_authattrs = true;
>
>         /*
> @@ -361,8 +358,10 @@ static int x509_populate_sinfo(struct pkcs7_message *msg,
>         signed_info->sig = s;
>
>         /* Save the Authenticate Attributes data if exists */
> -       if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len)
> +       if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len) {
> +               kfree(mctx);
>                 goto no_authattrs;
> +       }
>
>         mctx->authattrs_data = kmemdup(mb_sinfo->authattrs.data,
>                                        mb_sinfo->authattrs.data_len,
> diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
> index cb42018695c..e163e16b9bc 100644
> --- a/lib/mbedtls/x509_cert_parser.c
> +++ b/lib/mbedtls/x509_cert_parser.c
> @@ -66,7 +66,7 @@ time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time)
>  static char *x509_populate_dn_name_string(const mbedtls_x509_name *name)
>  {
>         size_t len = 256;
> -       size_t wb;
> +       int wb;
>         char *name_str;
>
>         do {
> --
> 2.25.1
>
