Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC74BCF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E815C88C41;
	Fri, 20 Sep 2024 18:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mEsGbBrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB7D88D36; Fri, 20 Sep 2024 18:01:56 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1CF88B49
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so1490787b3a.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848112; x=1727452912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=By/pb6vXPQEDkQHOkVgemgN4O4XnXkSdWLDTAyAwNO0=;
 b=mEsGbBrG7oPGZfDQe1twBrllqxy3XmBA/fzQXFs/LtOe5R1wpcptkWLSd+v4Sa+Rd8
 fNEb98Go/YMSgpTCvX/kRIxE97Ie1c6P64k0LCXZJNtecAby8OoCipN7qb5MvhMpuMMH
 IDTXn369pzNxlYVbv7Pif7dYfKLW/NeJj/w94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848112; x=1727452912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=By/pb6vXPQEDkQHOkVgemgN4O4XnXkSdWLDTAyAwNO0=;
 b=J1C6DsQpGHv7Ws8WFn6E3iQSjgyv5xtQYvE8BSary+d+BjAX1PGenf2HzYZDSqkkd7
 x75rZzJrGxyc956oArRZ9vss8Yt1P7wymptChbAdKu2oCU/deUorCVRQI0mE6RT9DKdC
 mjs7I9Qd1q3OAjAjHs9JfvcPu3wHfMFQjOMBKnFH2xNktvwjxstu1+OK4dTL3qLvATRb
 R0/kPJReX0ERg9TIQ2KIRFw1abBnu97WP0YnDLNxejMVHvFKivlmjoQyGNfTOnNfK1SR
 sFyr7xnYhwG6zCLe71D63sByx/rx0GNTT9RACtx1TpMvcBeF7NusLTKgJ8QhLtPZBWJe
 MCZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwANnYCN12RU7qc/OVIX1Rqag1ZxaKFn2U9vFWI5hWJUbS5h0WAaAfAmhxwpIWSmcOCQjuXKM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrwpk7nSGx6xRmZIEB6TMun/NCjPv3TiM1ttyXeNnRrqTblrFo
 tnW7k4Tivgc23yNcbgqpF8rFJDSTEo2fumQG5w5YhjO4yvzJDYl50h0ngla2KsimoWXX23HtF4t
 bODJ8+5kFkDmaBcanwzf/jlSaROLQcIeeimf2
X-Google-Smtp-Source: AGHT+IHLNCyVD7P47ktKBpvdG5ati+QPGJU5KeGWVYAq5j0uX5v7NXmqJ+rqXd3kR5ZIPFYZMsr5oAGpHNuPhtL3/JU=
X-Received: by 2002:a05:6a00:4fcf:b0:718:d573:25b9 with SMTP id
 d2e1a72fcca58-7199cdb4595mr4981588b3a.16.1726848111809; Fri, 20 Sep 2024
 09:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20240902053326.3273410-2-chiawei_wang@aspeedtech.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:39 +0200
Message-ID: <CAFLszThB8hq=C++AXKTV0Aa_NHUvOA=DVY93E3ChYhtZRLkcVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] lib: ecdsa: Add ECDSA384 support
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: trini@konsulko.com, bob.wolff68@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Sept 2024 at 07:33, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Add ECDSA384 algorithm support for image signing and verification.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  include/u-boot/ecdsa.h   |  1 +
>  lib/ecdsa/ecdsa-verify.c | 14 +++++++++++---
>  tools/image-sig-host.c   |  7 +++++++
>  3 files changed, 19 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
> index 53490c6b287..0d4df9887e6 100644
> --- a/include/u-boot/ecdsa.h
> +++ b/include/u-boot/ecdsa.h
> @@ -65,5 +65,6 @@ int ecdsa_verify(struct image_sign_info *info,
>  /** @} */
>
>  #define ECDSA256_BYTES (256 / 8)
> +#define ECDSA384_BYTES (384 / 8)
>
>  #endif
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 4d1835b598a..629b662cf6c 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -22,8 +22,10 @@ static int ecdsa_key_size(const char *curve_name)
>  {
>         if (!strcmp(curve_name, "prime256v1"))
>                 return 256;
> -       else
> -               return 0;
> +       else if (!strcmp(curve_name, "secp384r1"))
> +               return 384;
> +
> +       return 0;
>  }
>
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
> @@ -121,12 +123,18 @@ int ecdsa_verify(struct image_sign_info *info,
>         return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
>  }
>
> -U_BOOT_CRYPTO_ALGO(ecdsa) = {
> +U_BOOT_CRYPTO_ALGO(ecdsa256) = {
>         .name = "ecdsa256",
>         .key_len = ECDSA256_BYTES,
>         .verify = ecdsa_verify,
>  };
>
> +U_BOOT_CRYPTO_ALGO(ecdsa384) = {
> +       .name = "ecdsa384",
> +       .key_len = ECDSA384_BYTES,
> +       .verify = ecdsa_verify,
> +};
> +
>  /*
>   * uclass definition for ECDSA API
>   *
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> index d0133aec4c8..22253502065 100644
> --- a/tools/image-sig-host.c
> +++ b/tools/image-sig-host.c
> @@ -76,6 +76,13 @@ struct crypto_algo crypto_algos[] = {
>                 .add_verify_data = ecdsa_add_verify_data,
>                 .verify = ecdsa_verify,
>         },
> +       {
> +               .name = "ecdsa384",
> +               .key_len = ECDSA384_BYTES,
> +               .sign = ecdsa_sign,
> +               .add_verify_data = ecdsa_add_verify_data,
> +               .verify = ecdsa_verify,
> +       },
>  };
>
>  struct padding_algo padding_algos[] = {
> --
> 2.25.1
>
