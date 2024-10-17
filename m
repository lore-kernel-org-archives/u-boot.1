Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF8ED3C526
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 18:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20F18901D;
	Thu, 17 Oct 2024 20:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IRMyyaXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718C08901D; Thu, 17 Oct 2024 20:19:07 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D1C8900A
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so936133a91.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729189141; x=1729793941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Laqg1JVFaHlAhenziOcXQM7nYlQ7lDrUJPbBGX7/lLg=;
 b=IRMyyaXJPh142eb1+DYGM9AC120T1Jev41C9su39iUMcqUqJwfXdqvX1sSC/jrEc1u
 6r7Jo24Rs6SJi3Evs2EP++/vkAXHFX0rHhn+eLkm300QS58XcMgXSnN3mWMB+LP9Zaaq
 y9U/afj1s6wG7d1HALOsJ+oEUZh2fr/4UW6J2eq0KR7o8IbhKqQj6Zud0K2DjfUulFe7
 e39dX8zTzUYfLcu6x3RzKQSTVCsLoqoU4iMpmBJdBYuZJodR5daNafFSKihb0HW6CMjP
 kPySI//WKXaxcVcXc8uTHiq/siYkU24VdZw6REEZvNXz3weMRAYjitERgsW14lsosXis
 XcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729189141; x=1729793941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Laqg1JVFaHlAhenziOcXQM7nYlQ7lDrUJPbBGX7/lLg=;
 b=Ch3huwKWUjXeRxlxApc3J9rTWBxSGVKj1eAx/BnCYNgkxwy2c1spKFrGw9EyeGDl9s
 Hinn9hgNVM2W5+5SESJW3hw7Ml48uJc70OTYRDrYjXmGVAPfZZONB6AG0+aiNCALCoEy
 p0PrIYGlcYSPAKB1SFM0CYQkkaLlBB57Lpmd4BL2YEUslpvYQDdYhWav0iAbFYvz7yTv
 ihvhoAdtGBDdM7i31lM+TKO6OhhrDbrbERnljqEHm5zBt8fhzC+/fRCMkqk8eNhPvGMr
 MuVMtA4uUHayUvK1yM0LaKU04uXNPTjijE6MZbk3QBJCFzdL0G3qpIuLaTSiiLZHSeb4
 lcDA==
X-Gm-Message-State: AOJu0Yy8WI7gPxwZ+2wHrq23siTaLxQG6uXhRSLOgBNu7Jdo83yTDnP/
 dgpwKzLRmxxRYHogwRxJ6PpUCLRAEM80T9zGZ5VRQtDTaofBgr70ANgE4vXSwIzV9Zcr5DxCXAp
 q1w62sk93dpOewYud8Vsk6dgBn5OmjChmyji9f9rfmsVF0Ax3IiA=
X-Google-Smtp-Source: AGHT+IF4G0g8xV708Fb4E1ogkUjUFBnevXX5kKNR98jN4xVts2SwdR7D5ScTLR7WvxbwkSLjlpt1ftH5+sFqRRDqN1Q=
X-Received: by 2002:a17:90a:ff0e:b0:2e2:d3ab:2d77 with SMTP id
 98e67ed59e1d1-2e31538f3edmr22284347a91.39.1729189141549; Thu, 17 Oct 2024
 11:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241017180507.6261-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241017180507.6261-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Oct 2024 21:18:25 +0300
Message-ID: <CAC_iWjL+QjOtzL2+hDysYxOYoJm2wEv5xt6L1t3BEkupwjHKEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: add missing lf in error message
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

On Thu, 17 Oct 2024 at 21:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Messages written with log_err() should terminate with a linefeed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index b63b5cca71e..3d742fa1915 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -652,7 +652,7 @@ void *efi_alloc(size_t size)
>
>         if (efi_allocate_pool(EFI_BOOT_SERVICES_DATA, size, &buf) !=
>             EFI_SUCCESS) {
> -               log_err("out of memory");
> +               log_err("out of memory\n");
>                 return NULL;
>         }
>         memset(buf, 0, size);
> --
> 2.45.2
>\

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
