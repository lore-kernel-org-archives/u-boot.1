Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFDFE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1323A801E8;
	Tue,  7 Jan 2025 14:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dDmy5LBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF5E8036B; Tue,  7 Jan 2025 14:33:39 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C098007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e537d9e3d75so22960163276.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736256813; x=1736861613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOoeR9KZN9jl1x7/BoIneIyZVTEfmd4U23MobDGP/C8=;
 b=dDmy5LBNzqOcImbA5gs545zZHyzecBBNXJEKrWUmPD62GjrMH4wvmW3HBhzRrCqbNf
 kUJSNb5+U9tsZ3T316EYfE1YFbXyTwF3gxkZkCs45h59fNJaB2vZWeuMRKcktMoeAszr
 WYlCn+cHbkZZrGnszcP3pomJYWT86yNbqZSN+McskLd7Jk5zh3oQzKctZmrJEGnVwYBg
 QENr3mHEo/Cr6kuvgbtkvSaLFl4g7VGPlKQA+C8f0upELlDe7GCu49BGkYQW6zzRHimG
 sVKXyVOX/PfHD6WrFcPlhsl6ujKVhFV21Tf0FUwN/N7FI3aVo9UhohxEIdDZlg0/MLEJ
 cq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736256813; x=1736861613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOoeR9KZN9jl1x7/BoIneIyZVTEfmd4U23MobDGP/C8=;
 b=HJcETnbDgjGSqxwbx4pn9I73ZTMCTF6Wkl/taN0vnsYtlzoZV15pbqJf3UJ32eRD8V
 2SxX7NOOdqi1ORZg1etDb+K1DKxS1LsvMKZ3QjNqU/MYOq3UComYgTNjgK1D32VfMLig
 2HIcNKHmHIeXWV1cWBfkcHvTAJiC6NCxMIx1XHhumbUZaElvwE21zt5i/3SojdtRJ9to
 rwtvuYbXd7Ydk2CxmBLQeNoLs449lZvR773k6OvWpNfaFea5PlqNg6GVM4rnse+hXDBA
 AZy/JYIH80DJJzeeixrLB95WxVnHp3cbVYXyzYP+rTJfADWouwuMgMaJOhiavl2hU83R
 qb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+QIl1Sa3TJ10Lkn3UTwRuQb+CQxzruW9HVNLYx+mgllAFaSvZaYiZ3zTLQd/ZYzSv9ZG41bA=@lists.denx.de
X-Gm-Message-State: AOJu0YyRhiqj7eCFPJmRDv+yri3/4r3I0ganG6IT8hf/QMdseVw5vP9D
 DklMEuKGLgzOG5HKwxogi4wBSQx9hIOg8jZp6ISevruX40IV9LtYr/nsAhvrjs80uknPNTR1Dww
 YAgPyTcHZiHbWpYrnv2UM63HkUG2JP5vW90zA2ok57yPM+C6uiQI=
X-Gm-Gg: ASbGnctVRlwvkQjVorF5fWiMESpnZe+5kzMFmb2ehTUb/bR2Aj/j2zKsEWRRcPLLGJ2
 /TUihRgToVqUbFLLonFANGgnlkUiy9Erm+jd2ug==
X-Google-Smtp-Source: AGHT+IFWkitMYx6/Db00D9DCLviE1DKTgRNr37wFt6guEb1M+kvp44nVAWjtf1nQA93PZ0ek38oDohEPptbDngurnRs=
X-Received: by 2002:a25:1845:0:b0:e4c:bd70:8550 with SMTP id
 3f1490d57ef6-e538c4284c6mr33538024276.45.1736256813651; Tue, 07 Jan 2025
 05:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250102181133.378867-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 15:32:57 +0200
X-Gm-Features: AbW1kvYOTRxN1g19jFmaEwib9VdXSbMPHUgRelPgE9WkpLSsn3tlJ8NQ3cuNUzQ
Message-ID: <CAC_iWjLykW-kgo65mCGfnwBEmYGbGa6mq52yxfCZHC1Rep1FQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi_loader: print image load address in StartImage
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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

On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When starting image add the image load address to the debug output.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_boottime.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 080e7f78ae3..bc0cbd96e74 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3194,7 +3194,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>         struct efi_loaded_image_obj *image_obj =
>                 (struct efi_loaded_image_obj *)image_handle;
>         efi_status_t ret;
> -       void *info;
> +       struct efi_loaded_image *info;
>         efi_handle_t parent_image = current_image;
>         efi_status_t exit_status;
>         struct jmp_buf_data exit_jmp;
> @@ -3212,7 +3212,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>                 return EFI_EXIT(EFI_SECURITY_VIOLATION);
>
>         ret = EFI_CALL(efi_open_protocol(image_handle, &efi_guid_loaded_image,
> -                                        &info, NULL, NULL,
> +                                        (void **)&info, NULL, NULL,

We don't really need the cast here

>                                          EFI_OPEN_PROTOCOL_GET_PROTOCOL));
>         if (ret != EFI_SUCCESS)
>                 return EFI_EXIT(EFI_INVALID_PARAMETER);
> @@ -3266,7 +3266,8 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>
>         current_image = image_handle;
>         image_obj->header.type = EFI_OBJECT_TYPE_STARTED_IMAGE;
> -       EFI_PRINT("Jumping into 0x%p\n", image_obj->entry);
> +       EFI_PRINT("Starting image loaded at 0x%p, entry point 0x%p\n",
> +                 info->image_base, image_obj->entry);
>         ret = EFI_CALL(image_obj->entry(image_handle, &systab));
>
>         /*
> --
> 2.47.1
>

With or without the cast removed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
