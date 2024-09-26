Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330AACDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B612088E1F;
	Thu, 26 Sep 2024 23:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lTJ0HxQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3011388E5A; Thu, 26 Sep 2024 23:33:28 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E95F88DBA
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso8769766d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386405; x=1727991205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YnsJaTjZBf9U0D8M/CYR3Tj45yF/dl3p4e6MypniDzs=;
 b=lTJ0HxQ4Dtouiwevc4L3FF7sEITT6FyXlBcg2LDS6HWt6IBoxlNZzG4WaYSbE7h+iw
 30iM1sUvoHbu8+mVICUvJHpICXqLkqBed7enIhxVMA46roOLrM+39SPbiUMb8RCQe6wK
 J4v3cOeFEev7ZBBtHaYuRBqv7bbzo55zVVdbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386405; x=1727991205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YnsJaTjZBf9U0D8M/CYR3Tj45yF/dl3p4e6MypniDzs=;
 b=H5ZYkFrDlgfd4fzsbCdpTTklsQBrfLrSrtkFRNS4qiY/6Sw4tF+NnXG69ms6CYf1oX
 5K8LvUlcfBJrr3Svu+7W6JUjV5lXLAGXTe9C9z42yiS/YPoirOzfjKAW5eZYQjHMaUwG
 Z6z4AvdcdQ3sow0gVoP3wxWeRiJr7jdt9pifqGJtEvRNL4p3TsL2TyUXAEWtoQ6y9iVF
 ussKY/V9Ww0eYGC3dILXFVPTstOQqlkdd2qz+bUXmsbCwI27krIU3NAK6DGsHvVJAQCR
 gHp/US8+XbPc3qBCOIwxLsSoNQZa6uge82I3y7oOAcVgnOSoL7QlXhpGb3R5TAzS2oPo
 o3mw==
X-Gm-Message-State: AOJu0YzOJwliCzsMmTPQpmfbTUXrU4ZLcupcr3DGblP/USclM8Xq3Y14
 tBhj6uJ0klX4n+ijNA0qFeJFHvliX2jGYETomfiywqmiCmTFv0NFLcENh79vI50rZOve88bed0q
 cVCVvpFjHHFInIKKApgKNff+jNIK0LbtXEkC93Qp2s3n4r4KTySjV6hs=
X-Google-Smtp-Source: AGHT+IHfeXzgJQucwNZmIu5nESphPkC7Fd/Ub1JsOYrFQ+xVeQVJDW55gjMt5SsIbOGfvRKqBxfZVG3DJk7x+bftcAQ=
X-Received: by 2002:ad4:4f47:0:b0:6cb:3bc0:c2c5 with SMTP id
 6a1803df08f44-6cb3bc0c33bmr8084196d6.53.1727386404903; Thu, 26 Sep 2024
 14:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
 <20240920161521.917955-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240920161521.917955-1-joakim.tjernlund@infinera.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:13 +0200
Message-ID: <CAFLszTjVJiVQNc5f=Q67enUPBMY9wv=sMh__+=gY8+H0rWQozA@mail.gmail.com>
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

Hi Joakim,

On Fri, 20 Sept 2024 at 18:15, Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>
> Adds support for secp521r1 ECDSA in mkimage
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>  include/u-boot/ecdsa.h      | 1 +
>  lib/ecdsa/ecdsa-libcrypto.c | 2 +-
>  tools/image-sig-host.c      | 7 +++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Just sending this again as it wasn't picked up:

Reviewed-by: Simon Glass <sjg@chromium.org>

>
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

Regards,
Simon
