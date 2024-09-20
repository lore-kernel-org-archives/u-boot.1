Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103EACF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D089488D66;
	Fri, 20 Sep 2024 18:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uhnb5rk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C549188C1C; Fri, 20 Sep 2024 18:04:16 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBCC889ED
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71923d87be4so1698732b3a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848253; x=1727453053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5VWE081EGRfh6Ay7gmPFfJKvf87eeKKJN+nA1XTphlU=;
 b=Uhnb5rk3ojEdXGYQImfhgmC23J3TqH7IgRcvqndcXy6cqxuTuPS5Dca+MwlFEd0+p/
 zJe6t07nYh1uBzwNEabxSEL1JtWrW7uzz2EhPJn1dWsfYBSzJ2Li6qpstZOv7ZUAmDoY
 /KyruwpvPuwEKn0S775JxQavcylEhBikm8uXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848253; x=1727453053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VWE081EGRfh6Ay7gmPFfJKvf87eeKKJN+nA1XTphlU=;
 b=nl80tehhYdFe3Q9BDxBpj/x/BknDqva3NwYu69tJ5588SBJPkF5AXsJWvJkyR5aLbF
 e5EKt8SWic2vJFpPsW+QXXOS5/SsZl6s3Vpd+zCQCF81+noOX0wj5uXts2I53iCE3Boh
 vqPutyhCwq8bO16j798Wp2z/ppDMUK+SfbC2xVOtzFcFvXWMOszTSUJeU20a7Bj0tfle
 o1AMOowhfrwR0596+mzLlMLiINg9WeexGoUARBLoPDZj+0j4mD6QfYqZ2u3+AF2Wn6RW
 IMlA/j6EOkgx7Ib4TkyCDYJkR0xD3ZsAA14PAOendg/DZPFcCtjG5pb9Xz0bYA+lN9qq
 8IPQ==
X-Gm-Message-State: AOJu0YzTPVNVm3k/9jbqXtDiuK+wvUOIR3GyaVDIrDVp0aQm15OEGF1+
 o62EzREv64sUOIiWdraINiv2AhXadfurMY3FyslAtauDgDUvwsXD8VZz8Quv4Kd5ADJz2qKKPB8
 pSZM+dyeVH5zspv7IP0rm2Vj6KB/PSz9e9Scq
X-Google-Smtp-Source: AGHT+IG7xRuWk959XNMlWVsFvtIqWAxDqIw/3hGJMeyBH17pW0MAxnC2O+1q9+q2sojRvqe/WH8vy7z9doMNCbXAZRA=
X-Received: by 2002:a05:6a00:179f:b0:714:20a8:d79f with SMTP id
 d2e1a72fcca58-7199c96e1efmr4411907b3a.14.1726848252689; Fri, 20 Sep 2024
 09:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240919134835.377572-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240919134835.377572-1-joakim.tjernlund@infinera.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:55 +0200
Message-ID: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
Subject: Re: [PATCH] Add mkimage secp521r1 ECDSA curve support
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 15:48, Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>

commit message?

> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>  include/u-boot/ecdsa.h      | 1 +
>  lib/ecdsa/ecdsa-libcrypto.c | 2 +-
>  tools/image-sig-host.c      | 7 +++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>

With above fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
> index 53490c6b287..8f9f5e7d6e7 100644
> --- a/include/u-boot/ecdsa.h
> +++ b/include/u-boot/ecdsa.h
> @@ -65,5 +65,6 @@ int ecdsa_verify(struct image_sign_info *info,
>  /** @} */
>
>  #define ECDSA256_BYTES (256 / 8)
> +#define ECDSA521_BYTES ((521 + 7) / 8)
>
>  #endif
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 5fa9be10b4b..403dfe0b97c 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -108,7 +108,7 @@ static size_t ecdsa_key_size_bytes(const EC_KEY *key)
>         const EC_GROUP *group;
>
>         group = EC_KEY_get0_group(key);
> -       return EC_GROUP_order_bits(group) / 8;
> +       return (EC_GROUP_order_bits(group) + 7) / 8;
>  }
>
>  static int default_password(char *buf, int size, int rwflag, void *u)
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> index d0133aec4c8..21b4fa5d39d 100644
> --- a/tools/image-sig-host.c
> +++ b/tools/image-sig-host.c
> @@ -76,6 +76,13 @@ struct crypto_algo crypto_algos[] = {
>                 .add_verify_data = ecdsa_add_verify_data,
>                 .verify = ecdsa_verify,
>         },
> +       {
> +               .name = "secp521r1",
> +               .key_len = ECDSA521_BYTES,
> +               .sign = ecdsa_sign,
> +               .add_verify_data = ecdsa_add_verify_data,
> +               .verify = ecdsa_verify,
> +       },
>  };
>
>  struct padding_algo padding_algos[] = {
> --
> 2.44.2
>
