Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97012C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 10:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130118036F;
	Fri, 17 Jan 2025 11:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICO/wVKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0448069D; Fri, 17 Jan 2025 11:34:12 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E5080312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e549a71dd3dso3646561276.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737110049; x=1737714849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+A3DmNsdjFucup+THkYOofVw+Cib08gK/WZud+mqeSY=;
 b=ICO/wVKcSeV+4bCw+m8nYfBmYjTQ9kY7Pgxzv4gdveicPqZpCU0S7hPc76Cd5FqhEH
 JdkYYW6Z6kSOdeYovSHKvI2cKrOUwtFnlRYU27ZsWuta1JPT4MA8XsZi+0n1j12qDLvm
 PwfJkzEOHPZNRnbM/ZSvaKxh6Fevj6tIUDHv/l2UanlaYGJ1uQcIw4CmlG+exYUNLCMj
 5y3MhSvsk6UxC3nEA4XNaCbnCzqV22oMltO2AmrN8FRXllj6gYN5Pinx02+Yw5nLiivQ
 IL+2w6kpLvIzFWhVOae6hUJz30m6EYiTbAJhPD0pSyVhc9YPuiX7aWehHtcCFlfVQfN2
 4cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110049; x=1737714849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+A3DmNsdjFucup+THkYOofVw+Cib08gK/WZud+mqeSY=;
 b=pBOVt8TRGcua0OYZn5xVRBbIyOWi+YbS23YSpsIZP0Kiw5tA2rI9XaVNmtnBzH1wie
 KU33k5Qq22mZ3VbsmAYGWD+HpzHpgQ0DO6ucxDoCn5zIv/EEByAsQqD8neGwclVZb1Bd
 lVmQ3M1v4HwfIuCftPT34iLDTKr+NPX8NxdALWGZt+/+X18D7/gTlLog0+6n3CPKhnjZ
 c18hI/nOF6PRp+5F4J5Bw1ND6+AQP9wLPs2XH5IV53s0iAMyspK+ZxonqOM6wQIo71YT
 WKrDAvlCExzY50FVhwI/SWfQrMiq6SwiYE2dXRgsr5abyflYzCgN22W9tvDaThSfvQiQ
 B6QQ==
X-Gm-Message-State: AOJu0Yxbqx88+J17iV3Y+O2mQwJjYf8Olygoot62L/JjkqvNL7BZafwl
 9Em3uRiXaS39YJDUwxQixvZkisO31Y5NdGJlagWgMAExXD9PkiGfy+lGqWp/rv9szJIdI6YN746
 Ib9Xfpt0jQnnLB4W0pWJeA9NGDuBg7DqHx+vcpw==
X-Gm-Gg: ASbGncuEfMrK1NxCYE+W0ieu260E+g2zl+Eq9BcZfOeBHMMXrKDITZffOZxhmyKPpJ1
 BXdPs7f3C1hzO+bZaUhD04SzxIJpFHGtmRGZtlg==
X-Google-Smtp-Source: AGHT+IHun98i1utMD3wyWLX+66zEmsXTU6eoc8e7wrdjqK25d6C4akun4Xn0pK2xkwRW95PNZ/USWyTaxQX5aWbwgio=
X-Received: by 2002:a05:690c:f87:b0:6f6:d511:a20f with SMTP id
 00721157ae682-6f6eb65c32bmr11895847b3.8.1737110049147; Fri, 17 Jan 2025
 02:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-5-sjg@chromium.org>
In-Reply-To: <20250106144755.3054780-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 12:33:33 +0200
X-Gm-Features: AbW1kvZHtMbDML9a8STUs1RMv_RaH3xDfbJw5SIFiG05RhVIRH-VtvT4QgX8n1U
Message-ID: <CAC_iWjK2Arj5EkA8AsQh_BFGQoby5tNwf=GVpwSBaW8nBnQ_Yg@mail.gmail.com>
Subject: Re: [PATCH 4/8] efi_loader: Correct bounce-buffer setup
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

Is this patch for -master of your tree?

On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
>
> This should set the bounce buffer to a pointer, not an address. Fix it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/efi_loader/efi_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 2e197e94edd..9374f77d3b7 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -837,11 +837,11 @@ int efi_memory_init(void)
>         uint64_t efi_bounce_buffer_addr = 0xffffffff;
>
>         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
> -                              (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
> +                              SZ_64M >> EFI_PAGE_SHIFT,
>                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
>                 return -1;
>
> -       efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
> +       efi_bounce_buffer = map_sysmem(efi_bounce_buffer_addr, SZ_64M);

map_sysmem does *exactly* the same thing so you need to adjust your
commit message.
Does this solve any sandbox crashes?

/Ilias
>  #endif
>
>         return 0;
> --
> 2.34.1
>
