Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29349D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60ACC891C7;
	Mon, 14 Oct 2024 17:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aYK9gJf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8BC3891B0; Mon, 14 Oct 2024 17:51:05 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51CB8915B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460371bfda4so37006151cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921062; x=1729525862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QpycWWyln23kFs/5p729MHPLINYo1O5xfMMiVEdg2Q4=;
 b=aYK9gJf7S6HzaD1PWyuhHH+HcfQw3BjM9R8r8xW75aODrBLbutRSBio0SfnzyBH+se
 ZZl5z0l1g9Jaazgx0/qLQ3Z7ZKOXDeaQu7qsvWXMpHgBOi2XcDbNj2iol1HE/8MKmLuX
 OVsE6brO6GlQPsv6GrJ3ZJdZny7/MULoimmQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921062; x=1729525862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpycWWyln23kFs/5p729MHPLINYo1O5xfMMiVEdg2Q4=;
 b=gydro340hUI9C7iHExJp7bkZUY/ejYxFRvJthfc2vWeyR2tiro6GPez1M0z/1GPyWr
 WSjV8tzO+mFZiTxnlDX9hNhBIfQA/ubuoPzzk7S93RCD7l0PMoLeY2Av/mmNG/H/MmvX
 jrziSsSRqYK9O0hZggmsDef8DBlPdQ+oTt2StnMbpq2EzPSkGkJQV3RoJcQl1mTZ5/N7
 xamoOkeNd8bGXXLetOHGhpwIXVzNyiRRmZ6XhIn0gLbJMEkii3DIQfgB5PibUz5l0ypG
 VJAjbLZq8UH2pjF1xQUM/BrDxpq4K1FRQTk/QsEJEf0YfCgLZUbT3Uc3mkXnRdCMZ8GP
 5fJA==
X-Gm-Message-State: AOJu0YwGuyPaYOWmjuaFT92OWknWdBxhveBe7bZPOd01I4l48ERHANP0
 AnXP+YKkf2WloIOTKiOa5yyKKWfyalOuhH4/ts6KSoXAEWGqwcrFsAg8e81hmgtbKtMSsJYUj9G
 ZnSwXmBRZqF+iEVFuuBowGawhra/FeHxfNQM9
X-Google-Smtp-Source: AGHT+IF1gtw13mBoDiWj/w8HHAxOegTt01PYc+CwurPHAYNu8d1TsWSIxc0QOZHE24iNCx2EavrxjOvouTr85eHZpYY=
X-Received: by 2002:a05:6214:5d11:b0:6cb:e76b:d90 with SMTP id
 6a1803df08f44-6cbf0044b74mr150975086d6.13.1728921061983; Mon, 14 Oct 2024
 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-12-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-12-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:51 -0600
Message-ID: <CAFLszTjYM_4het1OJx_SXb=2ztqmDtVeACmzZMyhB5q=P9sZMA@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] layerscape: use the lmb API's to add RAM memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI memory allocations are now being done through the LMB module,
> and hence the memory map is maintained by the LMB module. Use the
> lmb_arch_add_memory() API function to add the usable RAM memory to the
> LMB's memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 8 ++++----
>  lib/Kconfig                             | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> index f9c2083677..d2d3e346a3 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> @@ -10,6 +10,7 @@
>  #include <env.h>
>  #include <init.h>
>  #include <hang.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <net.h>
>  #include <vsprintf.h>
> @@ -1525,8 +1526,8 @@ int dram_init_banksize(void)
>         return 0;
>  }
>
> -#if CONFIG_IS_ENABLED(EFI_LOADER)
> -void efi_add_known_memory(void)
> +#if CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP)
> +void lmb_arch_add_memory(void)
>  {
>         int i;
>         phys_addr_t ram_start;
> @@ -1548,8 +1549,7 @@ void efi_add_known_memory(void)
>                     gd->arch.resv_ram < ram_start + ram_size)just
>                         ram_size = gd->arch.resv_ram - ram_start;
>  #endif
> -               efi_add_memory_map(ram_start, ram_size,
> -                                  EFI_CONVENTIONAL_MEMORY);
> +               lmb_add(ram_start, ram_size);

But isn't RAM added to lmb anyway? I understand the call-removal but
why the lmb_add() ?

>         }
>  }
>  #endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 100c4e5c25..3796adc453 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1135,6 +1135,7 @@ config SPL_LMB
>  config LMB_ARCH_MEM_MAP
>         bool "Add an architecture specific memory map"
>         depends on LMB
> +       default y if FSL_LAYERSCAPE

This should use an event.

>         help
>           Some architectures have special or unique aspects which need
>           consideration when adding memory ranges to the list of available
> --
> 2.34.1
>

Regards,
Simon
