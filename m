Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5D6D690F8
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 10:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27014893A3;
	Thu, 28 Nov 2024 11:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N+eRk68Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAFD89840; Thu, 28 Nov 2024 11:47:37 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E463E89372
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6ef402e4589so7991927b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790854; x=1733395654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kU62SS6emzW6mvaZT65Pe/Kmw9eaq/UBkxp9nvEDo3M=;
 b=N+eRk68ZWdRdJ9y0QObE8Kfu2k8EGC77Q+dMivyC0eIQOfJ+1I9kG0wI5HHuY1smSa
 G6YqDnqXQ3DvbG/KpvcukMOxgpvqb0J0b/fEHYzj739/CnjAy05Boqe55nUpvlvUQfMU
 FlVWL7WiFDyH5mwwPb7MXI/X44Q4Hq/NT7GJU5O6B3NzR0oG6wjRW4iApYG52OPXuhYT
 4ue6gzJsP0km9nv+Mnj9E68cs0jD3BqbFpVvpxqghyMqcUlyhIjh5rPwb6UQ8hbiTf6H
 Usq3y0hSZttDhKtc/aZz3QS6eO5EPtLSRM0si7hjU/jos1EyziEEhcE9kNGy+p1y5rrn
 uZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790854; x=1733395654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kU62SS6emzW6mvaZT65Pe/Kmw9eaq/UBkxp9nvEDo3M=;
 b=iKk+WG3TkBgEBETyhPhZtv1tLjHdp0SA6Jgds5zOy+0YrSFhy/1IPMDX4KCK3ftSi0
 CjlSFh9hSGVEe3MZ48mLgdkrCpvII1aks9zI1Dyh7ubRFIq5fpEJJYQhJR6oZJ9+eLht
 2NbO+yXTZBkAvHxHzJ4pwzHXAMgTSybHDcZm4YjqcVAjO5T7dN1tb0WpR3SgQ7U0EFk1
 r2cZzx1Uz+agIdCZzfbiO1Wuwsp/LjMxsC+JSjWy1FZrWTmiisruleEQgzG6btnvps6x
 IZ5SAmNpq2LPayRnQ5MHVlSlKm1+kmv9ogaFgDQ6sp1ORGUkVCgs+0NiVtZxxeySzNul
 e0RQ==
X-Gm-Message-State: AOJu0Ywlg/k/aZxpPwHXSzaHbUy0GM2m2RTR82q3SQZ+dAIp+7kIeWpk
 7D/PaX7bgS603Km9DohUxJ04QGaRnwhkPBkbROHZen09oPymGPMe6v9qHFyDp0B7XIXuvR0PddF
 BJD9Qafrx6b7rmid0sBkHw3oOraActpDoU4shEw==
X-Gm-Gg: ASbGnctSRsPkbUwH0NsdUttCIwV0UhGRcuwGXt7hsuSryebupuQFS90cH1YuOUcyGpB
 tJSm6waIiJBWxB0nMa0MECBb++5BS6A==
X-Google-Smtp-Source: AGHT+IGKe7r9vd8E0c++wa4ZXKGyqByl3wl3LVUBtOnTttxP3nHsJn9Xw/ayATm2hB5gAQDHfqwDvh598SlfmGskJLE=
X-Received: by 2002:a05:690c:45c7:b0:6e6:1018:64c7 with SMTP id
 00721157ae682-6ef3728c054mr80886967b3.41.1732790853815; Thu, 28 Nov 2024
 02:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20241126234017.29814-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241126234017.29814-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Nov 2024 12:46:58 +0200
Message-ID: <CAC_iWjLjJ3F6vHiR3yfxAALQvDmzdwCo+M21hgFVXOrpqwTB5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: avoid writing message in Exit() boot
 service
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, 27 Nov 2024 at 01:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We should not write messages in UEFI API functions. This may lead to
> incorrect screen layout in UEFI application.
>
> For single statements after if clause we don't need braces.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_boottime.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 080e7f78ae3..38b0af9d502 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3495,10 +3495,9 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>                 if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
>                         ret = efi_tcg2_measure_efi_app_exit();
> -                       if (ret != EFI_SUCCESS) {
> -                               log_warning("tcg2 measurement fails(0x%lx)\n",
> -                                           ret);
> -                       }
> +                       if (ret != EFI_SUCCESS)
> +                               log_debug("tcg2 measurement fails (0x%lx)\n",
> +                                         ret);
>                 }
>         }
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
