Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D9BC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA5F81FEE;
	Wed,  2 Jul 2025 08:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TmYiHtC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7F982103; Wed,  2 Jul 2025 08:32:02 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239A8003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e64b430daso44403097b3.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751437919; x=1752042719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VeobfpshtOwUOiCr6Zd/Y51AD6RaAjCM5iBzv5uoMYI=;
 b=TmYiHtC5TA+NOpKrqt2g9cWZ1c40noy2GiFTTRpOoz1yc/+RdNZb4rUW/fvd7VTLcU
 gBG/NYZmKR/Z0oCJ4MKnj/SeRNk2ntAHAjCBwfbnXpG3DNIy8g5zdVEI9O3GGhgamtvV
 jJc75WtIVxeCDFpFhAEojQXYPHECXqSTz0eC/7Bo1X4Ds9K7I8jfEjJncRHN+Mj2zHBy
 G+7gFK58hz89TDWwlSFnIFZ7jx7ijxxkRljOveAOINr7Jk2BZAcqWBiWEkAAZKz6SrcM
 kvygh2wKXSjRLPYsi1fv4cvlsIcJh5aMQQxQ3lKVoRDr3qgh9p6ddM0iOcU2nTuxvzs8
 nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751437919; x=1752042719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VeobfpshtOwUOiCr6Zd/Y51AD6RaAjCM5iBzv5uoMYI=;
 b=H+Sqz8x1SPPgPAsFjJkz8mXjfnK0cODwHY+RS/t4kpEmVn7dz6caiyApzM+L/orHS4
 b/wuT2ljQYJzFKVIwXdiF1xuJxT0rxBO1k3+nySxyTpHFyA+vE9MMWW+t5cRnF3Is5zH
 UC9XR1MNNBiUYn+x1Xh9nnLmhJPm1yLzStuka2dTkuboayWjIgKNwqF6RRsmzWiWY5Y4
 4z2s+3MRHcqxfm2XB24F7HY/8ROv+V+KVDCl9FRd7ZERHkqZv/oHF48wU0VoLHlkeyyz
 AkTcjsgrL0tus+YFiC8Wwh64HSscsLuVdSdeWE9O9a56KZLw5R/7G6S5ZULyzF5LHCgZ
 gagA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO3TQSWu2Y6FiD6oaFvxQe3UoC1mtiaSBmTei4Wv7fKU0DuEFkZMFtQvQeHZM1j1D8xQ9KMgo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7ax3wWO/0o/2jFeGjBh6IiitXM47qTV8j4s81lKEIi949wQRa
 VA+IpbfUDmd9GR+Zfxgcx6Ojh+IdqyioP06jwQrI1I/JTow9k8uhlkTon+IZjBnAFh8TXaTuhDz
 OCw3HYSRVCcFcUvELuOYWr4IhvEvx7PV3WU5p0c1auQ==
X-Gm-Gg: ASbGncvhV4ekDwH+baRiccooo+xGnbnctXYYZt5F3vMz0g6wZdDRnc8KEvjaMr//D28
 zuUW2OgTa/SIGHtCD5jkkLCXiQy8SczdI38K6Q6H+eSsZRCbAdW1ej08yXSyOR9ez5ry/Ff4HFj
 Cywd/mrrPR75d8oDLDEHYOdcCzXaI0JwN30lWwNPlduUPF
X-Google-Smtp-Source: AGHT+IFnOXwRbYQHL2yv+xuywZuqWLJAVWXvD1iRgzeoH6xxAsKD3S0utVn++MhGNNNj0NBStjpdtgTanYiZIRJSe7U=
X-Received: by 2002:a05:690c:6a11:b0:712:d70b:45d5 with SMTP id
 00721157ae682-7164d4cdff0mr19858027b3.33.1751437919386; Tue, 01 Jul 2025
 23:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-2-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-2-f3c6e0b0ae43@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 09:31:23 +0300
X-Gm-Features: Ac12FXxEbvZF2qCxWrmrLHJbYiPRgVBnzknTOyYz1-kEHdFq_mrWxwLZAGgD6YE
Message-ID: <CAC_iWjKGMQDzc1Q_JqKaBotnDu2LYAHebev5upvomRd288OP8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: Prevent dereference of uninitialised
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
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

Hi Andrew,


On Tue, 1 Jul 2025 at 16:38, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> If phandler is returned as NULL from efi_search_protocol then
> protocol_interface is never assigned to. Add a check to prevent
> protocol_interface being dereferenced in this case. Small refactor to
> coalesce the two identical NULL checks of phandler.
>
> This issue found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  lib/efi_loader/efi_http.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 189317fe2d2..ce3a7a831ca 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -463,18 +463,18 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
>
>         efi_search_protocol(child_handle, &efi_http_guid, &phandler);
>
> -       if (phandler)
> -               protocol_interface = phandler->protocol_interface;
> -
>         ret = efi_delete_handle(child_handle);
>         if (ret != EFI_SUCCESS)
>                 return EFI_EXIT(ret);
>
> -       http_instance = (struct efi_http_instance *)protocol_interface;
> -       efi_free_pool(http_instance->http_load_addr);
> -       http_instance->http_load_addr = NULL;
> +       if (phandler) {
> +               protocol_interface = phandler->protocol_interface;
> +               http_instance = (struct efi_http_instance *)protocol_interface;
> +               efi_free_pool(http_instance->http_load_addr);
> +               http_instance->http_load_addr = NULL;
>
> -       free(protocol_interface);
> +               free(protocol_interface);
> +       }

Reading at the spec I think we can't return EFI_SUCCESS in that case.
11.6.3 EFI_SERVICE_BINDING_PROTOCOL.DestroyChild() is the chapter that
describes the protocol.
EFI_UNSUPPORTED is supposed to be returned if the ChildHandle does not
support the protocol that is being removed.

So I think you should return a different error if phadnle is indeed NULL

Thanks
/Ilias

>
>         num_instances--;
>
>
> --
> 2.39.5
>
