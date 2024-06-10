Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8FDC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED98884C8;
	Mon, 10 Jun 2024 13:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HLezb53E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD3A8811A; Mon, 10 Jun 2024 13:46:51 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96F5884AC
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6ce533b643dso3232414a12.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718020007; x=1718624807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZZBrO2fb9RW3lLEu2YeNTeMP9i8BdeDxcd+vo+FJLk=;
 b=HLezb53EBrA5nFC5vV1mavMU+P28Zd6R9bkdv1Q3tEuxe6IIxeYbJ8C74pAoF1zvWy
 6tqd4xiVxr1MhqeRAqZLdq485iIM+0ZmIAHBCZdaaYv1kPpt7oVji+Snky9Dezlphusx
 zg6Gqrai3t3ZA4sJVOGKfxq7u/5nHt14MySHbh7oJ1FsFxbCE7FCkaJmPBSMzTK3WYvY
 QkDbfY61PettwssPpNnOGxuvlpVMLSmtGg0dDQsm0nFP7M+oobIbcVQiBmokg2SBT0iG
 loPE4dkVRFVEeQ8cC7NeZ5BJaXcDxBI8JhXpT4REp6cOcE3wH6N08ydgbt+mDLQNtPUh
 Cs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718020007; x=1718624807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZZBrO2fb9RW3lLEu2YeNTeMP9i8BdeDxcd+vo+FJLk=;
 b=e8bNa/0N9ETxkMKlJKtlSjNLaeOdU2JcfQoE9HAffNUyNZsBUJ8MTLyGPJU0SmO1sa
 vFO5CwGGRzraqmzSZFCA4MkodnoOpui5M5bv+iSMS0sL643ixkEa+w2Q0KPX3Xu+Nhz3
 EsSiUlGqvV9wpjMk60Dm6c9FG3BYBR5EyXd1Of9o6As86T1RO67fHrT443QgVcz+Ae4w
 gI4bjuxdrfK20is5K9/AXyn+OBrJwOyOWYnLYrb1AEqB+WoiRBHXV/j/MKwfezKCGI0o
 JFt/ncq7uRAyiZ5xXhXFMKIdtMcHoHOXTP5eBz//5zWDMRVNf/jYy4qQv4mFuvSVn5a7
 ySjA==
X-Gm-Message-State: AOJu0YyXaKaXmaARM46noi2FnDR3M9qEYSLdZjxX04nJ5XN6wixU05qo
 OjyCWk7c604mbq9uyntPB0Hng1GxKsnAQYkc5RJNLEdCScmigrUxE3mCD+FfE92b9gVQ4Zp9/xM
 AaZCjen9niBIiK2slfYnihqwQaR/RhoQ/kA2VCg==
X-Google-Smtp-Source: AGHT+IFfH25k+j5KJhtsmxdqTBqTr7SU+a7E1CKgZ6BXSifLulDsW8rKEDD2FqjqCKHL7qfekmeDVjrX1mIDgquYtsM=
X-Received: by 2002:a17:902:da8b:b0:1f6:51f5:540c with SMTP id
 d9443c01a7336-1f6d02f41e5mr110087615ad.29.1718020007304; Mon, 10 Jun 2024
 04:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-18-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-18-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 14:46:11 +0300
Message-ID: <CAC_iWjLd79VywGTAGRhPcG1=NHSypADt=suzN3vkVv_=ATzK+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 17/31] lmb: remove call to efi_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The changes in the EFI memory map are now notified to the LMB
> module. There is therefore no need to explicitly get the efi memory
> map and set aside the EFI allocated memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/lmb.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 3059609aea..c9f6ca692e 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -204,38 +204,6 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
>         }
>  }
>
> -/**
> - * efi_lmb_reserve() - add reservations for EFI memory
> - *
> - * Add reservations for all EFI memory areas that are not
> - * EFI_CONVENTIONAL_MEMORY.
> - *
> - * Return:     0 on success, 1 on failure
> - */
> -static __maybe_unused int efi_lmb_reserve(void)
> -{
> -       struct efi_mem_desc *memmap = NULL, *map;
> -       efi_uintn_t i, map_size = 0;
> -       efi_status_t ret;
> -
> -       ret = efi_get_memory_map_alloc(&map_size, &memmap);
> -       if (ret != EFI_SUCCESS)
> -               return 1;
> -
> -       for (i = 0, map = memmap; i < map_size / sizeof(*map); ++map, ++i) {
> -               if (map->type != EFI_CONVENTIONAL_MEMORY) {
> -                       lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> -                                                       map->physical_start),
> -                                         map->num_pages * EFI_PAGE_SIZE,
> -                                         map->type == EFI_RESERVED_MEMORY_TYPE
> -                                             ? LMB_NOMAP : LMB_NONE);
> -               }
> -       }
> -       efi_free_pool(memmap);
> -
> -       return 0;
> -}
> -
>  /**
>   * lmb_reserve_common() - Reserve memory region occupied by U-Boot image
>   * @fdt_blob: pointer to the FDT blob
> @@ -255,9 +223,6 @@ void lmb_reserve_common(void *fdt_blob)
>
>         if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
>                 boot_fdt_add_mem_rsv_regions(fdt_blob);
> -
> -       if (CONFIG_IS_ENABLED(EFI_LOADER))
> -               efi_lmb_reserve();
>  }
>
>  /**
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
