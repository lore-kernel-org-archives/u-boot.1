Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58895C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 16:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D49F889DB;
	Tue, 16 Jul 2024 18:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a1y3a4w2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DD5889EC; Tue, 16 Jul 2024 18:56:26 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FB28876D
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 18:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so10235804a12.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721148984; x=1721753784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuVI6jTiBctfFYUQqA7eSBNBxUubvdzQv0T/ZHpB4nI=;
 b=a1y3a4w2XrgJM0fsyLI9g4S7VmKNIbeXgOKuY6Afft/R23+YCtQ2qu8S6NaYMHylEd
 82Ep9MTiEACKzN3OY11uTfHTYzlP6d9QpdgsmaWnD+8DEygnf5vxnlHn8DoNZpI4ukBl
 J+1x+tP8Hsu+NSfLGuB631Eowu9njCRDrXUf3c1m1WgIGFbVeBvDwynhwsZyy9FDF9gl
 kE9tIFb2eA2WN2fdbMY9UnzyGLO2o9kzL1693mj0JM/AWLVbhm3eMcKeFzhFma6a8Ls1
 VaL/7MmgajD7Yt+fIO5KobsHeUt3ImyUcOBZvy1lbhhnRfE8c0jEoUkqs7G7wdTiGoLN
 iA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721148984; x=1721753784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZuVI6jTiBctfFYUQqA7eSBNBxUubvdzQv0T/ZHpB4nI=;
 b=Za0bG7MjuY7WSy+sIwvwCBrYpx05mw0i8ugwshM6+j6A/2PJdRbkxDXZBEoqwH7542
 meLWloLT23o9KfFljtSUEY/1Jx6ljUBH44PzYY2vLTE+d5CwehKqmBnceXCxyf5/9kKD
 BGfVxBdoVz0ZKAKgQq57EXITwRO5DAe7kHlH2/Ccg+KWCJck//3kaV7A22hGiU/XUrbU
 5lnJfC3EMs6cCCRwtH/lg6ejYKmu+L7Uv6vfY19SHN/2b2gYVYZxFSdHaMCTvpg0Khew
 djSiqTks5LnPN+qPJJAzBICGt2fm4aDlTZ3mnx25Ww2ADQbgLnclgA8Y9Mndz1AfpNS2
 lrvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcI098EPSf8+7BQ4U6aYK6DhN/pllU5n8FEDlL8/SzIsNK5H7OCYGxMo/7xPRir3Y7lsu8MZkIG5E/PPM1QSzbJ+I0Sg==
X-Gm-Message-State: AOJu0YxM3f8bc14LQxhRwaktp7OdfQcb99utxzeVyJ4as9yr8ziArwlQ
 UNquSvujjYdzVp8+2DIhCoQHQ/QnTDx7yrPO9aYgQzpUcsAjKViahDPF4HE0UTRVK3ArOsU3Om9
 mC82T193S85QgqWC5gwxOGJZcPdY=
X-Google-Smtp-Source: AGHT+IGbR1vsAGDh1sZsbjBEAsViEGy1/UoMn+EqV7fmG2FO2Dl4iTmn0gzov2XblJQMzTPUcPTjJ7e1h9Fh9FPg3Cw=
X-Received: by 2002:a05:6402:3489:b0:58c:77b4:404b with SMTP id
 4fb4d7f45d1cf-59f0b913ccdmr2657312a12.15.1721148983547; Tue, 16 Jul 2024
 09:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
In-Reply-To: <20240716150616.349466-1-philippe.reynes@softathome.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 16 Jul 2024 17:56:12 +0100
Message-ID: <CALeDE9PSADyPUwBuHH46V2Of-HxyYJbo2VOdfQe-_soS6CHCvg@mail.gmail.com>
Subject: Re: [PATCH 1/4] lib: sha256: add feature sha256_hmac
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: trini@konsulko.com, sjg@chromium.org, abdellatif.elkhlifi@arm.com, 
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

Hi Philippe,

It might be useful to have a cover letter explaining what the plans
for this code are, great that there are tests but adding code in
without it being used isn't always a feature so a cover letter with
some details often helps with the context.

Also if you're not aware there's work to integrate MBedTLS [1] and I'm
not sure if that also may provide the functionality.

Peter

[1] https://lists.denx.de/pipermail/u-boot/2024-July/557832.html

On Tue, 16 Jul 2024 at 16:16, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/sha256.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index a4fe176c0b4..7aa4c54d0d4 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -24,4 +24,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz);
>
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output);
> +
>  #endif /* _SHA256_H */
> diff --git a/lib/sha256.c b/lib/sha256.c
> index 665ba6f152e..64f6b48974b 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -298,3 +298,43 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>
>         sha256_finish(&ctx, output);
>  }
> +
> +/*
> + * Output = HMAC-SHA-256( input buffer, hmac key )
> + */
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
> +       sha256_update(&ctx, k_ipad, 64);
> +       sha256_update(&ctx, input, ilen);
> +       sha256_finish(&ctx, tmpbuf);
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_opad, 64);
> +       sha256_update(&ctx, tmpbuf, 32);
> +       sha256_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, 64);
> +       memset(k_opad, 0, 64);
> +       memset(tmpbuf, 0, 32);
> +       memset(&ctx, 0, sizeof(sha256_context));
> +}
> --
> 2.25.1
>
