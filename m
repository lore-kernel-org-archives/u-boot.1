Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C48C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 07:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627B382CAC;
	Sat, 12 Apr 2025 09:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UwJGS6AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF8882CB0; Sat, 12 Apr 2025 09:29:50 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B8882C8A
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 09:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e6e2a303569so2082190276.0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744442986; x=1745047786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qci+U+sQQILves3Ns4/s6ZRJtCp0NfmRK1UTsCw5YU=;
 b=UwJGS6AG9tgRnnAN+KqlEqvbP9fZ6J+iaytteUDK8Po1sp3PRbturxRG1haPsIsEuT
 ZH1oecolTnyulfXVoywDkETB820IVNDa0vqurwQJZasASc3keT6pk7SpUT7m8ElYJe4n
 ojJkjZIIPe1W0PNjBJypU0YOV3LcFu34xfhCfKMhYScv+Nudu9dRNhNcOCeJTDDjp7W+
 LjfK9EO2qYSt2DyIFTHz1MOaBO1Wwmj9UDNrINlw9dNXeV8HiNovBMsd2ohRgNNW3GKr
 Zf48hdhZG5irHoY7UL6m4VoVNvdtOVF3N9qQPDhrT1iJOHgHQWB7QZYLkrqsp2m68itQ
 StRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744442986; x=1745047786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qci+U+sQQILves3Ns4/s6ZRJtCp0NfmRK1UTsCw5YU=;
 b=GVGVSr3Tn6AZvVGnCFtG019CA/mh/Q8CFTJsUc4zfPO+eYx3N0Fn1kNKfNAfZeFUl6
 CtVIPVnysP6N9HS+RsXicJNoqLYxCtyoWFGa1F6eJ+PACkWl5B8EDTsTxi9+Az2fPAYI
 gyPa9+/RjukJPr0DQQ1xoOewLc1xFhUuKLYABGgkTpvhgrjZp8uxANGyH4xq1H+i6Q6P
 2+0MdZkRsd55DQTGJykvVKqG11vWaxqOIAHzAK35u/nGFkHnl5wE1LPrZp7DIq8hZKjR
 73NY03xFCFQazu59X/81w5mULVRio3AG8BW49kcjt+1l1cart4rZqcGLyftp3/1+7R1D
 Rw0A==
X-Gm-Message-State: AOJu0Yw8hyQ5Q5fAn5g9Mce56PbGO/FrpQRGHTRi2/Sw93zD/rtMlTs6
 XrdSUHlNR1tSZ/m3SArURfZmpFKbOqMV7NWsSyLa5arOXlvP7IT8wAdnzgmmTecVUL9VuUKocWw
 Nx8kA7E6oTkHUF+qCOcZDS2u/C5XbxusFcyNvnhAmbKiQSwmN
X-Gm-Gg: ASbGncsCOl3p5/8C0A01bL4x8lsn322qZfUuHMyCDhLEqs4E0AscfKYiIx6sjjA6Eln
 E8Px6jBicE1u4dm+RaRQ8Ls2QHzbwuiNcppdr2ZoO7LNcDu1lne9Fe8ooMO8KSIroNxVGG1c7FO
 XwI/g3BbVB7a8RRK6Jo0dSLUaC3jWi2Z2r
X-Google-Smtp-Source: AGHT+IEXmfopp76f0gvfdUiw6htkcne/VtgnaBY79kMh6Jv+EiGtJQVUdg1fQpgoVM+WSdZi77htkRNnTiu0T7Oq81U=
X-Received: by 2002:a05:6902:2586:b0:e6e:4d8:81ce with SMTP id
 3f1490d57ef6-e704dee5df1mr8909036276.29.1744442986345; Sat, 12 Apr 2025
 00:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-3-adriano.cordova@canonical.com>
In-Reply-To: <20250311164758.421900-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 12 Apr 2025 10:29:10 +0300
X-Gm-Features: ATxdqUHjFVL1h8lifdoF6hYPKkA_15sr9y0Ji7YTPXtLcTbXxX_Yg7ibE7b-0pk
Message-ID: <CAC_iWj+VyhocQyQ-cx7UwU3r9g_m35R8DpRaN0OPb=djn4B1=A@mail.gmail.com>
Subject: Re: [PATCH 02/16] efi_loader: efi_net: check efi_search_protocol
 return value
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, =trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano

Apologies for the very late review, I was travelling a lot...

On Tue, 11 Mar 2025 at 18:47, Adriano Cordova <adrianox@gmail.com> wrote:
>

You need a proper commit message on why we need this

> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  lib/efi_loader/efi_net.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 0334eedaf5c..8c0a3f5243c 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -1020,7 +1020,9 @@ efi_status_t efi_netobj_set_dp(struct efi_net_obj *netobj, struct efi_device_pat
>                 return EFI_OUT_OF_RESOURCES;
>
>         phandler = NULL;
> -       efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +       ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +       if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)
> +               return ret;
>
>         // If the device path protocol is not yet installed, install it
>         if (!phandler)
> @@ -1051,12 +1053,15 @@ add:
>  static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
>  {
>         struct efi_handler *phandler;
> +       efi_status_t r;
>
>         if (!efi_netobj_is_active(netobj))
>                 return NULL;
>
>         phandler = NULL;
> -       efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +       r = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +       if (r != EFI_SUCCESS && r != EFI_NOT_FOUND)

Why do you check for EFI_NOT_FOUND here? If the protocol isn't
installed it will just fail adn retunr NULL a few lines below


> +               return NULL;
>
>         if (phandler && phandler->protocol_interface)
>                 return efi_dp_dup(phandler->protocol_interface);
> @@ -1444,7 +1449,9 @@ int efi_net_unregister(void *ctx, struct event *event)
>                         return -1;
>
>                 phandler = NULL;
> -               efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +               ret = efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler);
> +               if (ret != EFI_SUCCESS && ret != EFI_NOT_FOUND)

same here

> +                       return -1;
>                 if (phandler && phandler->protocol_interface)
>                         interface = phandler->protocol_interface;
>
> --
> 2.48.1
>

Cheers
/Ilias
