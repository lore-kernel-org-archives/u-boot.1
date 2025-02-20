Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78990C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 06:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00FC801DE;
	Thu, 20 Feb 2025 07:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="stm2hSWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E3080C98; Thu, 20 Feb 2025 07:58:57 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F51B801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 07:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5dbdbdaeedso611631276.2
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 22:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740034733; x=1740639533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fUkB2EQPdFJzl0BNtJUoyWSgtfNAwkeDJp28D+MGGA4=;
 b=stm2hSWLVAjDojjFf0aHfkdsXXYjUny5LHLyPzlGLD1tx5+CJnBEbrO+HoYPrk7Xxn
 y2SxQsBg3MPF9uYGJN4O5lVaVnIMq7N7PkImCsLVrtxta8AZPFD7bAhnN0XMg9vMNPyF
 mFO9SqwtfrrlNl6eC64+e/bReU5x0kxHdj1n0Shw0s6Ywgwts6WoKh2hwXTinoN2kNDa
 DC8XE6lLPT2lxNAe27zizqs3vnDmW1Rh6oNDwLjL8qHCtKfEbbZOe3HGY7odQfnBHxjW
 /lH6Z3nqZ9VQ0+gxRQG/pZtCFi9CUGjqqSot1WUJlUJPpb7CKujNltFUQlxoRZmCg58I
 QL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740034733; x=1740639533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUkB2EQPdFJzl0BNtJUoyWSgtfNAwkeDJp28D+MGGA4=;
 b=VD3ZcxD5LnusPSDXwlAM979eEYXBRbdqCJ09TEk6UbTk9jk3SH+VLNHI6uXkm6YGzQ
 jsj2CfEeHmunUiofCcykaFaHAdR4FHkeulY1InqoKgIKdBk1eNI7zZNzi1Z2/1fvJsRD
 Sx/7qT2mVSmnjcW68iDLhnGRTbr2G8xLmFGXvSKpX9V0mCUKAuUJFc7umZ7nb8MMX6E2
 T07PMagT8jFJqMg2sYdy1XsdAc/moasjtUg888LoNE1nCZouCO+r3rUFzjo15i5J8Hw4
 ZUr9PiBVlZv0+REJhjs+E+bErSCWXnN8sZ6FQrfn16Zzrxf2qIQcOp3InAZqp5HP1WZU
 7T6Q==
X-Gm-Message-State: AOJu0YzdOriTahxjpmtuYlekHL8R4swLohfRH3Sp1ociT47U7EZtLeve
 ejoCu8RxZCehJ9PsymsjGqcueLdbly+2RKU4drvy4q/iJKh3jh2hF1f4APeAHpXr/UpFNv7O9eN
 QyXRvsyYZZSO2D6bWIk3W/ixcts3TXrybrmCvLA==
X-Gm-Gg: ASbGncukbkDT0uSx/s2tEcvXyyDyxVKsVvJBWAsOB2NODykImQZIt7FtpHrf/Y9BUtk
 pwVuEA5hWKjeROd7ofK3dO6E8p1+EcruSCc6CiK9TPmTEGWtJC62phd2QQQ7XG1ujfceWqOPIkQ
 ==
X-Google-Smtp-Source: AGHT+IFzdBxV9teZOsbDxyLM4+JnFlCtvN0oiF5t0jmiFJbbV/29SjiM8nUNi7xlsTQXQ4WMiVa74AUnYSI4nx5W0BY=
X-Received: by 2002:a05:6902:2308:b0:e58:1565:b542 with SMTP id
 3f1490d57ef6-e5e1b36da2cmr702332276.1.1740034733508; Wed, 19 Feb 2025
 22:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20250210160727.30993-1-pkochanowski@sii.pl>
In-Reply-To: <20250210160727.30993-1-pkochanowski@sii.pl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 08:58:17 +0200
X-Gm-Features: AWEUYZltzsEqJ831SGpSNL-YRKXiLL8eueeJo44vfrB_FvA_D8Pd86Htz1uBq1Q
Message-ID: <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Pawel Kochanowski <pkochanowski@sii.pl>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Gabriel Nesteruk <gnesteruk@sii.pl>
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

On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
>
> From: Gabriel Nesteruk <gnesteruk@sii.pl>
>
> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> in `copy_fdt()`, which may not be sufficient if additional nodes
> (such as FMAN firmware) are added later.
>
> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
> to allow users to define the amount of extra space reserved for FDT
> expansion. The default remains 0x3000.
>
> This change prevents potential corruption when resizing FDT after
> EFI boot, especially when firmware like FMAN requires additional
> space.
>
> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> ---
>  lib/efi_loader/Kconfig      | 9 +++++++++
>  lib/efi_loader/efi_helper.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d4f6b56afaa..bd2cbe995c9 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
>           No additional space will be required in the resulting U-Boot binary
>           when this option is enabled.
>
> +config EFI_FDT_EXTRA_SPACE
> +    hex "Extra space to allocate for FDT expansion"
> +    default 0x3000
> +    help
> +      Defines additional space (in bytes) reserved for expanding the
> +      Flattened Device Tree (FDT) when passed to the EFI system.
> +      Increase this value if your firmware (e.g., FMAN) needs to add
> +      more data to the device tree after U-Boot relocation.
> +
>  endif
>
>  source "lib/efi/Kconfig"
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 04b2efc4a3b..91b2a5b8653 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>          * needs to be expanded later.
>          */
>         fdt = *fdtp;
> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
>         fdt_size = fdt_pages << EFI_PAGE_SHIFT;
>
>         ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
