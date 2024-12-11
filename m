Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF79E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8624802C2;
	Wed, 11 Dec 2024 16:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OY4QDmk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B6C802EF; Wed, 11 Dec 2024 16:27:16 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910098021A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so66487817b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733930833; x=1734535633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rkl8BPi2L1c3kuYn+B2esxbwCcXDtzNM18E91mdOcQ4=;
 b=OY4QDmk1RixgN1uMOSYmQ2CHGINlJuvcMULjgef8Al4z6wBUyDDqLY0Pllm/klCapy
 t2FzH5q98CSsSrSb3P3TWQEYs8Pdx4gwDWABW8CvAj8GdHPmO37ek/WQ13mW7SuGQwfa
 PDBJo5TuX+7HamTejSEd4x8kcEEKNj/wRg5/1wfzOqx/3zETunAbxVuhHOtfwgjrfVA8
 IcxB7Mdb0kwYNOevTozviwmGXiqff9t6sEF9HRw5q+8mt1waGZV/J65PTQbKXu/e/5TN
 Ntu4OAs5HQK1DGpUjLcasFBexNpsrXgA2t59tyXVqbWOF2d3f0KKvAi9TzaL/LzaWwqq
 zaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930833; x=1734535633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rkl8BPi2L1c3kuYn+B2esxbwCcXDtzNM18E91mdOcQ4=;
 b=EE55s1rSXoxKbzWhGs0tHoHwZOOv8BQ9Uks7ae+PgSDTh7S4t6M/e/SNGbwthUQBE7
 HgxmjFZGsCijNLT45BG6e25Ah2UU3MlKQe9ChNp6hAH7r5OUdj0wlMbrbogpNiWf3vNC
 SbTZZyGlUjXsOKHIwTQm4mC0RUje5Meo8wwUplkFaEF7qj++Xmod/BvUKTv7da2S4k/2
 TfyFf8agB1uHraXTewYnBCPT8oO+eqf+RpOIEfog+X13vt1a3DokTeitaY4pUVZZDD/d
 04oB1InbVW+qKyWISQu4OvHXlq/uQGxTsC7E2lyIHgiLd3XA4IxifKPtXmIspckTFyse
 ceHQ==
X-Gm-Message-State: AOJu0YxVkZVYKQnkrywBVQt0c0nwsqXAPIJKsEraEyhD5KvVQIfE3KTa
 C26wwkb3CfffHNVAvTVcD/zRyaRI2JP/tkzwSFgjNT3FRIQ1NjwsJS9Lh9QS8lmEc4+82Q7uOBG
 cxOc/R2FFCo48PHfkdhbrLWZnDyHsFkXxNhcThw==
X-Gm-Gg: ASbGncsP8TopOCWy5NEeueQpcAf26wcmLdoUARSifEmwCpqn5jdK4L0VIhx32f17P2m
 X0dGGCwK0klOR8R0s3moe0m8QMCZ6Omw/o2I=
X-Google-Smtp-Source: AGHT+IHjFjirKYZg/dALeVa/KpjT9KMe9FJZhfXK0bw+9QKnxHANRuWVvv8QQSGL+mCfFSmKNGr+Psl6S3zng2R6dD8=
X-Received: by 2002:a05:690c:6d05:b0:6ee:4209:731 with SMTP id
 00721157ae682-6f14805cf74mr29820357b3.39.1733930833335; Wed, 11 Dec 2024
 07:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-16-sjg@chromium.org>
In-Reply-To: <20241211135418.563803-16-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 17:26:37 +0200
Message-ID: <CAC_iWjL9kduAOJDEHKU0CBz87+ZJz_4TbXHmR3DdPU=i38+_rg@mail.gmail.com>
Subject: Re: [PATCH v5 15/23] efi_loader: Rename physical_start to base
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> The word 'physical' suggests that there is an associated virtual address
> but there is not. Use 'base' since this is the base address of a region.
>
> Change some uint64_t and remove some brackets to keep checkpatch happy.

Please drop this. physical start is what the spec uses and it's a lot
easier to remember when reading the spec


Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 38 ++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 42319ceb16f..0f149f99c7d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -36,7 +36,7 @@ efi_uintn_t efi_memory_map_key;
>   *
>   * @link: Link to prev/next node in list
>   * @type: EFI memory-type
> - * @physical_start: Start address of region in physical memory. Note that this
> + * @base: Start address of region in physical memory. Note that this
>   *     is really a pointer stored as an address, so use map_to_sysmem() to
>   *     convert it to an address if needed
>   * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> @@ -46,7 +46,7 @@ efi_uintn_t efi_memory_map_key;
>  struct mem_node {
>         struct list_head link;
>         enum efi_memory_type type;
> -       efi_physical_addr_t physical_start;
> +       efi_physical_addr_t base;
>         u64 num_pages;
>         u64 attribute;
>  };
> @@ -121,9 +121,9 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
>         struct mem_node *mema = list_entry(a, struct mem_node, link);
>         struct mem_node *memb = list_entry(b, struct mem_node, link);
>
> -       if (mema->physical_start == memb->physical_start)
> +       if (mema->base == memb->base)
>                 return 0;
> -       else if (mema->physical_start < memb->physical_start)
> +       else if (mema->base < memb->base)
>                 return 1;
>         else
>                 return -1;
> @@ -137,7 +137,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
>   */
>  static uint64_t desc_get_end(struct mem_node *node)
>  {
> -       return node->physical_start + (node->num_pages << EFI_PAGE_SHIFT);
> +       return node->base + (node->num_pages << EFI_PAGE_SHIFT);
>  }
>
>  /**
> @@ -169,13 +169,13 @@ static void efi_mem_sort(void)
>                         cur = lmem;
>                         prev = prevmem;
>
> -                       if ((desc_get_end(cur) == prev->physical_start) &&
> -                           (prev->type == cur->type) &&
> -                           (prev->attribute == cur->attribute)) {
> +                       if (desc_get_end(cur) == prev->base &&
> +                           prev->type == cur->type &&
> +                           prev->attribute == cur->attribute) {
>                                 /* There is an existing map before, reuse it */
>                                 pages = cur->num_pages;
>                                 prev->num_pages += pages;
> -                               prev->physical_start -= pages << EFI_PAGE_SHIFT;
> +                               prev->base -= pages << EFI_PAGE_SHIFT;
>                                 list_del(&lmem->link);
>                                 free(lmem);
>
> @@ -216,10 +216,10 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
>  {
>         struct mem_node *newmap;
>         struct mem_node *map_desc = map;
> -       uint64_t map_start = map_desc->physical_start;
> -       uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> -       uint64_t carve_start = carve_desc->physical_start;
> -       uint64_t carve_end = carve_start +
> +       u64 map_start = map_desc->base;
> +       u64 map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> +       u64 carve_start = carve_desc->base;
> +       u64 carve_end = carve_start +
>                              (carve_desc->num_pages << EFI_PAGE_SHIFT);
>
>         /* check whether we're overlapping */
> @@ -241,7 +241,7 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
>                         list_del(&map->link);
>                         free(map);
>                 } else {
> -                       map->physical_start = carve_end;
> +                       map->base = carve_end;
>                         map->num_pages = (map_end - carve_end)
>                                               >> EFI_PAGE_SHIFT;
>                 }
> @@ -261,7 +261,7 @@ static s64 efi_mem_carve_out(struct mem_node *map, struct mem_node *carve_desc,
>         if (!newmap)
>                 return EFI_CARVE_OUT_OF_RESOURCES;
>         newmap->type = map->type;
> -       newmap->physical_start = carve_start;
> +       newmap->base = carve_start;
>         newmap->num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
>         newmap->attribute = map->attribute;
>         /* Insert before current entry (descending address order) */
> @@ -298,7 +298,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         if (!newlist)
>                 return EFI_OUT_OF_RESOURCES;
>         newlist->type = memory_type;
> -       newlist->physical_start = start;
> +       newlist->base = start;
>         newlist->num_pages = pages;
>
>         switch (memory_type) {
> @@ -415,7 +415,7 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
>         struct mem_node *item;
>
>         list_for_each_entry(item, &efi_mem, link) {
> -               u64 start = item->physical_start;
> +               u64 start = item->base;
>                 u64 end = start + (item->num_pages << EFI_PAGE_SHIFT);
>
>                 if (addr >= start && addr < end) {
> @@ -695,10 +695,10 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>         list_for_each_entry(lmem, &efi_mem, link) {
>                 memory_map->type = lmem->type;
>                 memory_map->reserved = 0;
> -               memory_map->physical_start = lmem->physical_start;
> +               memory_map->physical_start = lmem->base;
>
>                 /* virtual and physical are always the same */
> -               memory_map->virtual_start = lmem->physical_start;
> +               memory_map->virtual_start = lmem->base;
>                 memory_map->num_pages = lmem->num_pages;
>                 memory_map->attribute = lmem->attribute;
>                 memory_map--;
> --
> 2.34.1
>
