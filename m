Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB9CFC528
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105AA88CBB;
	Mon, 14 Oct 2024 11:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8fG5Rad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6EF89049; Mon, 14 Oct 2024 11:23:54 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FFD88A1B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e28b75dbd6so2847328a91.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728897830; x=1729502630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sTGgI8Sg9liCXht0tppRBBXDj3cCqWkjtaKl6Nu97B0=;
 b=w8fG5Rad46Vc+3LPr+dXCrbof2NRmgKYLPUiZMlv73x/mLGmUI9OvVkCKAhrLm7L5a
 5fyfv/L2JsaeMl1bOuZzCn5WfuRnRxestXYYZi960B/SFltlkKndU1mVCyvd1R7juZGD
 N+bt4EuQWN8t8b3NA2xmQfx89HsT/Xt+YgDkjMFav76DOAy1xRLCuEXWHgJKsQRwr/dT
 vHbeBoSno1RPtHUmbp9rVVi6rEibaOJea+vWWIDxwzf/OuAOD3cPimPy7cBarxUyj70w
 2lu8zjsbLDi6vrOyfJhSSRsywvbRwxMAOeuKPQF7Aw3ENuC+UNvdyW1wuldeG2Nvs0jY
 lkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728897830; x=1729502630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sTGgI8Sg9liCXht0tppRBBXDj3cCqWkjtaKl6Nu97B0=;
 b=df+F1sxEu9rgG8vEU+2cFuan0vt4EZQax0G080o1oJMMfgI/+RhyotcM7t+/u5g1Vl
 y0h5vt4jEnRvVRPlnBxIrZ4kympPQSi3FRdz9qPHrwOUde7Zl6SWM83Z0xSsI1kjhJuV
 sLp16UsLdJB9YP55/7JCVsSFv+wJMhNkNVjNCVfAhDa1A3E//yGLhUyIv5UAThxIf7jo
 yQzokbDwUi9R70zwNUsEwM0WRFJKvxR8zIFMX1RL9veThrG8ymmUjbQC/YarNTcVAKXX
 11tzX8SQiPszeO1lZQHge8lJP3dLEXWIX8+jlOBx1+t7Rt8HJ2S6+m2ajjlHbjLc1/q+
 wonw==
X-Gm-Message-State: AOJu0Yzer/j83nkIWZMUAJpfOAGPm8nHyD6uFmAQdMc2U5/atq9zYMHr
 Ikp6rLmIBn4oNatj1WUAGkBGWfGTSXzCyDBHx/lzjU5fOtZqgfoF4F1dpN/L6RZ7mIHojsyRcq2
 h57CEvM+PV1WotX9GSjvDuS0SxVZkMiTibBt3A5Kw4QYrV8d7zzU=
X-Google-Smtp-Source: AGHT+IHUWKnK6JLj1ZzQGoPoWESwl0UxLa333l6yLTAmfYRQu7YRBBLglQ1MyQcjO798Z2ADXs0r3kM/11R2zGG8/TA=
X-Received: by 2002:a17:90b:315:b0:2e2:e597:6cd3 with SMTP id
 98e67ed59e1d1-2e3152ea871mr9472338a91.17.1728897830409; Mon, 14 Oct 2024
 02:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-16-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-16-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 12:23:14 +0300
Message-ID: <CAC_iWj+4qUvwb-Y3JxVYO_OC9+En_Paz0oMAOyXA4HBKBOqEOA@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] efi_memory: rename variable to highlight overlap
 with free memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
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

On Sun, 13 Oct 2024 at 13:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The variable overlap_only_ram is used to specify that the new memory
> region that is being created needs to come from the free memory pool
> -- this is done by carving out the memory region from the free
> memory. The name is a bit confusing though, as other allocated memory
> regions, like boot-services code and data are also part of the RAM
> memory. Rename the variable to overlap_conventional to highlight the
> fact that it is the free/conventional memory that is being referred to
> in this context.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Rename overlap_no_freemem to overlap_conventional as suggested by
>   Ilias.
>
>  include/efi_loader.h        | 16 +++++++-----
>  lib/efi_loader/efi_memory.c | 51 ++++++++++++++++++++-----------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 6b9a66a06c..291eca5c07 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -788,15 +788,17 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
>  /**
>   * efi_add_memory_map_pg() - add pages to the memory map
>   *
> - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:             number of pages to add
> - * @memory_type:       type of memory added
> - * @overlap_only_ram:  region may only overlap RAM
> - * Return:             status code
> + * @start:                     start address, must be a multiple of
> + *                             EFI_PAGE_SIZE
> + * @pages:                     number of pages to add
> + * @memory_type:               type of memory added
> + * @overlap_conventional:      region may only overlap free(conventional)
> + *                             memory
> + * Return:                     status code
>   */
>  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                         int memory_type,
> -                                         bool overlap_only_ram);
> +                                  int memory_type,
> +                                  bool overlap_conventional);
>
>  /* Called by board init to initialize the EFI drivers */
>  efi_status_t efi_driver_init(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index f59f7780e9..b63b5cca71 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -173,17 +173,19 @@ static void efi_mem_sort(void)
>  /**
>   * efi_mem_carve_out() - unmap memory region
>   *
> - * @map:               memory map
> - * @carve_desc:                memory region to unmap
> - * @overlap_only_ram:  the carved out region may only overlap RAM
> - * Return:             the number of overlapping pages which have been
> - *                     removed from the map,
> - *                     EFI_CARVE_NO_OVERLAP, if the regions don't overlap,
> - *                     EFI_CARVE_OVERLAPS_NONRAM, if the carve and map overlap,
> - *                     and the map contains anything but free ram
> - *                     (only when overlap_only_ram is true),
> - *                     EFI_CARVE_LOOP_AGAIN, if the mapping list should be
> - *                     traversed again, as it has been altered.
> + * @map:                       memory map
> + * @carve_desc:                        memory region to unmap
> + * @overlap_conventional:      the carved out region may only overlap free,
> + *                             or conventional memory
> + * Return:                     the number of overlapping pages which have been
> + *                             removed from the map,
> + *                             EFI_CARVE_NO_OVERLAP, if the regions don't
> + *                             overlap, EFI_CARVE_OVERLAPS_NONRAM, if the carve
> + *                             and map overlap, and the map contains anything
> + *                             but free ram(only when overlap_conventional is
> + *                             true),
> + *                             EFI_CARVE_LOOP_AGAIN, if the mapping list should
> + *                             be traversed again, as it has been altered.
>   *
>   * Unmaps all memory occupied by the carve_desc region from the list entry
>   * pointed to by map.
> @@ -193,7 +195,7 @@ static void efi_mem_sort(void)
>   */
>  static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                              struct efi_mem_desc *carve_desc,
> -                            bool overlap_only_ram)
> +                            bool overlap_conventional)
>  {
>         struct efi_mem_list *newmap;
>         struct efi_mem_desc *map_desc = &map->desc;
> @@ -208,7 +210,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>                 return EFI_CARVE_NO_OVERLAP;
>
>         /* We're overlapping with non-RAM, warn the caller if desired */
> -       if (overlap_only_ram && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
> +       if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
>                 return EFI_CARVE_OVERLAPS_NONRAM;
>
>         /* Sanitize carve_start and carve_end to lie within our bounds */
> @@ -258,15 +260,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>  /**
>   * efi_add_memory_map_pg() - add pages to the memory map
>   *
> - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> - * @pages:             number of pages to add
> - * @memory_type:       type of memory added
> - * @overlap_only_ram:  region may only overlap RAM
> - * Return:             status code
> + * @start:                     start address, must be a multiple of
> + *                             EFI_PAGE_SIZE
> + * @pages:                     number of pages to add
> + * @memory_type:               type of memory added
> + * @overlap_conventional:      region may only overlap free(conventional)
> + *                             memory
> + * Return:                     status code
>   */
>  efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> -                                         int memory_type,
> -                                         bool overlap_only_ram)
> +                                  int memory_type,
> +                                  bool overlap_conventional)
>  {
>         struct efi_mem_list *lmem;
>         struct efi_mem_list *newlist;
> @@ -275,7 +279,8 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         struct efi_event *evt;
>
>         EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> -                 start, pages, memory_type, overlap_only_ram ? "yes" : "no");
> +                 start, pages, memory_type, overlap_conventional ?
> +                 "yes" : "no");
>
>         if (memory_type >= EFI_MAX_MEMORY_TYPE)
>                 return EFI_INVALID_PARAMETER;
> @@ -312,7 +317,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                         s64 r;
>
>                         r = efi_mem_carve_out(lmem, &newlist->desc,
> -                                             overlap_only_ram);
> +                                             overlap_conventional);
>                         switch (r) {
>                         case EFI_CARVE_OUT_OF_RESOURCES:
>                                 free(newlist);
> @@ -348,7 +353,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>                 }
>         } while (carve_again);
>
> -       if (overlap_only_ram && (carved_pages != pages)) {
> +       if (overlap_conventional && (carved_pages != pages)) {
>                 /*
>                  * The payload wanted to have RAM overlaps, but we overlapped
>                  * with an unallocated region. Error out.
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
