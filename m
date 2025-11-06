Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04977CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 11:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBB183B5F;
	Thu,  6 Nov 2025 12:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pTYs09Oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B07883B72; Thu,  6 Nov 2025 12:39:58 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1846838FA
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 12:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63f97c4eccaso866123d50.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 03:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762429194; x=1763033994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p1wh0leAOpWCzjxH/DXiApq70vvkkJVDSlYFrU6dyAw=;
 b=pTYs09OcV7U5JkRVrTbBY1I61OSh0ehKU4gaOegCVfm86753J2DCXzN53yL3/A7zLH
 HkaAOd3aos2LVVq9R7sxbNJb2A7TZ45U9CyR0SY+mnULzmb4B0K0q6U2okF10hNZmlHN
 T1wTxzs0ZitOzI/7vepQLfAQg6vWoWDucY1pNqmU7g5kIPidVeXcR+ukQm9pUDtNcVo8
 gePcr36nXdOjmWZHaNyswWhto0iRipS50+BjxTa9gUX1yEEVY4FKBBCwK7AeGRDcfiad
 LbHRr4qCa3IfVhU+cYeAfmnQk2Y3wa4g6kIk/35skMuA04giDrKJuulkR4xUI0GA3X9Q
 hLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762429194; x=1763033994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1wh0leAOpWCzjxH/DXiApq70vvkkJVDSlYFrU6dyAw=;
 b=fFTFpqKPbRGyIBbFXJiFQpWnbIvpUS6TFLzdzJAGjcKNwsQtEAuJL3gu5pX0Br8bpD
 xjNm9S6tlClQ/RHvIZ7BsJdp0lc/JTFWYfWWHSx3hcgxvMy/pBJYMM3pnldPGrot1yVa
 0Xz2mHvK35w+uiXC8wsyL+mlWGurQumWomrcOaYdcfyS5e/0HlSm9/fpqPEboB5uVpiv
 ABQMJx/85Re0+RyN9ZhNBfJxyZ0xHmoyICQOhM1MViCeyPY2mE64SqhULQvXUn+89mZB
 sfbmqHHO3Dju2lbQZeyi4q0P46qz2ft89D8+xImduKQuyZ300v73jxPtbte9zm/nU0KJ
 qQyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwhWogbxkSsBdujB1BBG8dFhaEYDPT3lb1JTneOKRcQ9A10dTFo1ehUfIOjPJRpGqf6PrZyPk=@lists.denx.de
X-Gm-Message-State: AOJu0YwfT2Rkrf5EB2vVvESosB3sH8kM9lkkGmut9MOZKCBY5F2QpJWb
 a1hhwa08ccCWJ6ohgujzUHacoLze6rmc1gnZ4k9NtI5DNtx8/L8ljkAWEn9o+rRmx9BcXoA5UIk
 Of52XI+RZufzIW44mzF6JWpHRmbL42UOs7e5nSFz2s5agUGDfhsWpYyaxjQ==
X-Gm-Gg: ASbGncu34ZvooakhLdG5Mnmj+d74w2QtYSESw7JmWkYZEb7zXssuAKOypaAM5bPzYqG
 GfZhCPdoV+Qc8f0VNGBpMgmnYBCXmSfEks864XuXDuoVuYeGfd+gDp4ijWEuEHG3aMPaIgqD0id
 om6QnDiJefobY1dq+C2uVI34eKSqghVlGizYWlcHtusWSQ1xrRCsmxh/ivzrGrnLMBkQGq0yi8R
 ZUwPAWghmf55exRqo8kQRLsNcNfru6aQ34+2yxSr3cpLCU+hBrrKPfl/3r1uMQeZ0ntr0GF+ZGh
 c3w5CHNlvuBj4FPG7EpH610MmkLFgpCm2TkfjE3EkWMwILhRYEQa
X-Google-Smtp-Source: AGHT+IEJURbDE/L6hbFzIRWrqR2By+UveOEIdwyIGCHKBQyTHuq6d631ug0Rw3+eT0L38bPdBfjMfv1yspRH5Y/ta+A=
X-Received: by 2002:a05:690e:2483:b0:63f:9473:4749 with SMTP id
 956f58d0204a3-63fd3588767mr4386517d50.56.1762429194577; Thu, 06 Nov 2025
 03:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20251104222712.47366-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104222712.47366-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 13:39:18 +0200
X-Gm-Features: AWmQ_bkMLLp_ZB57JpI50pfsoLp2SePjxTca9gfS7IaXfJsvfQjgUAgrBftxBkI
Message-ID: <CAC_iWj+-NMjcRCJ_5r4fY4GYVZKGdiwY992dhm3N2=_xQ8-Pjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_client: efi_store_memory_map() must return int
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 5 Nov 2025 at 00:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The type efi_status_t is not compatible with the return type int.
>
> Let efi_store_memory_map() return -EFAULT instead of a truncated EFI error
> code.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_client/efi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_client/efi.c b/lib/efi_client/efi.c
> index bcb34d67465..a3a40b5549d 100644
> --- a/lib/efi_client/efi.c
> +++ b/lib/efi_client/efi.c
> @@ -155,7 +155,7 @@ int efi_store_memory_map(struct efi_priv *priv)
>                 putc(' ');
>                 printhex2(ret);
>                 puts(" No memory map\n");
> -               return ret;
> +               return -EFAULT;
>         }
>         /*
>          * Since doing a malloc() may change the memory map and also we want to
> @@ -168,7 +168,7 @@ int efi_store_memory_map(struct efi_priv *priv)
>         if (!priv->memmap_desc) {
>                 printhex2(ret);
>                 puts(" No memory for memory descriptor\n");
> -               return ret;
> +               return -EFAULT;
>         }
>
>         ret = boot->get_memory_map(&priv->memmap_size, priv->memmap_desc,
> @@ -177,7 +177,7 @@ int efi_store_memory_map(struct efi_priv *priv)
>         if (ret) {
>                 printhex2(ret);
>                 puts(" Can't get memory map\n");
> -               return ret;
> +               return -EFAULT;
>         }
>
>         return 0;
> --
> 2.51.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
