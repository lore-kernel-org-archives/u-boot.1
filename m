Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EC2C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39BD883018;
	Tue,  8 Jul 2025 12:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wYh90gxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5550483043; Tue,  8 Jul 2025 12:33:33 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4301C83015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e302191a3so34929117b3.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751970810; x=1752575610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1A5QejQN6kXAHEW8RzzGLGA6I2kWt2lGKp9a0HZPAkI=;
 b=wYh90gxS0oBTSLdY47SlAlRA6hJPIHGkMPSynOsprQKD0lyXXDT57dziYIgKSSFgK2
 DhYBCb2c630O6+wvRkaOAgILqurtFiLlVyf2u4M0lp8FzEqpctEO2l/133tIjHPtjU1F
 MxmVqwTBOu/YXmfALsnLG9s1wMp59t4rFUi8pVNRL+SSyHMYhw3gaKexoM5XvTAOfxGO
 CiXrcTF9Mk9oBWJPAYgzbV7stbIQQL5z1ASqpDMP307IdAvbbyzmqR+Zn0GggDdHoGx0
 lgnUk3Mxqfu/Y1FgIyBSv5g0z9cMhEHxqQp3rkQFwFMzVI/+qfA5AWNnh/X9yaN5VXFT
 JdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751970810; x=1752575610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1A5QejQN6kXAHEW8RzzGLGA6I2kWt2lGKp9a0HZPAkI=;
 b=o9M9ZvHaMfHccOr+nM36sSaJ5ABU+4Xqc/TTokVmuWxa/t+TfpeQXY5Q8sqcLqyKdq
 Lnkww7uUH/i8huQOLoppkVY14IN//Vow6aR/5iRiJVy9lH1yjP9wQF9O7HUBUwKgKy5F
 uniuKBcCC1Nvl3n4znCj/3/IhB2LorgZAQCv12tzx7e+5amXTrmEijnqW3Ct5pX9Ye/E
 2y4dy/5TnHur21TAHMXLvns+B58f3+2gPZbjobTgCmgLbvjwtSPSsHm6fKtMTUUcijt0
 7Ax8VH0uuhApm0A5Z32vtPXoYk9BCFgurf5Vh1rWsjMm4LWeM6VLg3nb7CMXmRXKOZ7q
 OmmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNwxpH6s99nGjZrxHCSeqCkE1wbSTXvHaoAsQGcNC3RWzV7zTUP2PZzhs/hYNQpBQNP9CN74I=@lists.denx.de
X-Gm-Message-State: AOJu0YyLRgoBChcR97FF6O5jMQo7Qr04k4GWycnwXc+iwqFLb526wjug
 z4RLZg+TatuA8IvHS+RGoz+JO377cNCqH59kfrP9Vp7miKFlzCK67NL0r2vFzeOSrhzjefelbK3
 0er3bQQuFz1ucoJy8f+/Ny9rthUjrB1VUta5hH7XQjJGOZcNOQzyTo9U7qg==
X-Gm-Gg: ASbGncu6eLX1uLMEoq7qvaL915ld3g7YqSWbyJ3UO7HwOo/ONZ5wusxogmSHLFu75yH
 wDrmhOvzrRLi9kg/bMtHXwhrDMP/HfWi79z1FTcMy2j2W45ydc/7X3RLh4dGVMiPnqeXWojkcHG
 wOwEqzv5Wl4OqX9l4/QOpXORkeACylwapOV1+EK7WfH4k=
X-Google-Smtp-Source: AGHT+IHY5gtYU1+qzWM7Ylna9un2Xu1V1rkOi6nVuB2boVVORcjY3+w52lOkQkq59AYDD45tCG9S/6B+Hc4xRgwBtZM=
X-Received: by 2002:a05:690c:490d:b0:713:ff41:37f1 with SMTP id
 00721157ae682-717a0431c1dmr29495497b3.29.1751970809965; Tue, 08 Jul 2025
 03:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250708100820.34909-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250708100820.34909-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 13:32:54 +0300
X-Gm-Features: Ac12FXxb8S6VAUTqXic7L_hqJF-2mYiMcQigpNIhF8mJPAx8Uapa6u3-hRUr8P0
Message-ID: <CAC_iWjLM7Eir+m4HTqOA1bG+G6LV-o8ccu8SvkpiB7TO2rLMUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: efi_realloc() must check efi_alloc()
 return value
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Ying-Chun Liu <paul.liu@linaro.org>,
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

On Tue, 8 Jul 2025 at 13:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Avoid copying to NULL if out of memory.
>
> Fixes: 3c08df58cc43 ("lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory")
> Addresses-Coverity-ID: 569499: Null pointer dereferences (NULL_RETURNS)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 6dfc698a247..b77c2f980cc 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -714,6 +714,8 @@ efi_status_t efi_realloc(void **ptr, size_t size)
>                 sizeof(struct efi_pool_allocation);
>
>         new_ptr = efi_alloc(size);
> +       if (!new_ptr)
> +               return EFI_OUT_OF_RESOURCES;
>
>         /* copy old data to new alloced buffer */
>         memcpy(new_ptr, *ptr, min(size, old_size));
> --
> 2.48.1
>
