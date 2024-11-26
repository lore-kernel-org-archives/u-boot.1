Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CEFD5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07088961F;
	Tue, 26 Nov 2024 09:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qNGpXKU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1550389643; Tue, 26 Nov 2024 09:01:31 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A118961E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-724f81aff1bso1780309b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732608087; x=1733212887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p/88IpmbW6PKd16lpvPeGELIN4G+lbhsJPkJXz+67UE=;
 b=qNGpXKU0Q7J8OohWR74+OrtXYr5Yy7Bi4o/Cz5Xa2CgPAvLg4oMjlKxLtIi6Ac6qV2
 FDktXTJWxGWn8O8nAsUXBR4SA67lLojCkFLFs4VQsoPHNhEkZIXmFpd8y8GYgtlq0YkR
 ib67/NTlpqGnfcwp3UKNnILO8eEHLkND+lm9O25uRIB0F5yofbMn+NEy8d73UqylkfLp
 KJIDIv6gUp2kMjDIou+pTaVKeEUFSAveg44ctm4QvgedTXeOU2HKL139WCPkS1aQRO0y
 e1KCFI9+CstJWob6meS5bi4KOKVCriW3fVJNxH5uhYQt8aWXWG+wlfQa1LLHtISwE/mg
 LWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608087; x=1733212887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/88IpmbW6PKd16lpvPeGELIN4G+lbhsJPkJXz+67UE=;
 b=TM6aCljW45rk0MOT5EQbOLFeWrRViNga1Y1w1ta30JpYAyxVKjBQ+PuOZWVgY8nrj4
 jiS4Z5vHwmQxwo1bI+k8NPT9Gu+RkechtYwIGPOEW3WXpIiRiGhiVRZ7vBoogUsLJndt
 weTn1sipCewaf0RS9zCJUBkgey+SDXVs2UaJpb1jfROdJnWUL1tdk7PsmwfLBXgg14Xp
 WuSykzO4a+5uVQeLe8ujRcA/7+FgKhBMcFwADnBbXR+PnEK6HLJADI6L+6RTMHP/Yu1a
 VJqae/ZD9Gdmrb2EYrZ6RHMlizV885ZdUVm5A073rX2KPmpMOcFpo72ZaGo6O5Ygi1Vf
 T+IA==
X-Gm-Message-State: AOJu0Yyr1j6Q4RH36QICv+QjdBQRSytrdA5fzitDyLxjtRp66MPM5tXU
 TAAHD6OJsXOcakXMcRkSaNsQcZsexSXI3RmrJEzEQKhUFwa12x38P9QOkgZpdRR6ItcUcOWaQuI
 azbLak5uwC7ZxM6rWDsth7IVsHDLh2lZdUrK0EA==
X-Gm-Gg: ASbGnctS+N+8BoX3wDNWLdM+6lcJ7oBB1FGV/nsrPV6Pz+DJrOwnJ/AGV9Aze7PNV5j
 NGWsGpw1lc7enCXVgAtxu2MyUIgGTgg==
X-Google-Smtp-Source: AGHT+IFEWAYeRulGN8+IpMjzeEdj4FF8kxAZyOUnOR/AwfFTz0gPy+Zsi3VHs5mHzAg8azfhYPYzqnfPcxXoPnftkNk=
X-Received: by 2002:aa7:8a13:0:b0:724:e3e4:a9c7 with SMTP id
 d2e1a72fcca58-7251ccbb9e9mr3101805b3a.2.1732608086563; Tue, 26 Nov 2024
 00:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-8-sjg@chromium.org>
In-Reply-To: <20241125204456.1525752-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Nov 2024 10:00:50 +0200
Message-ID: <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
Subject: Re: [PATCH 07/13] efi_loader: Make more use of ulong
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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


On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
>
> One of the confusing parts of the EFI loader is that it uses u64 for
> addresses, whereas the rest of U-Boot typically uses ulong.
>
> There is a case on 32-bit machines where phys_addr_t can be larger than
> 32 bits, but this is very much the exception. Also, such machines have
> mostly faded away and generally don't make use of EFI.

I am not sure how true this statement is with LPAE etc. In any case, I
don't want us to convert to ulong, there's no reason to break things
for platforms we can't test.  So please drop this patch

Thanks
/Ilias
>
> So in the interests of consistency, update the memory functions to use
> ulong in most cases.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  include/efi_loader.h        |  4 ++--
>  lib/efi_loader/efi_memory.c | 42 ++++++++++++++++++-------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 0ef4c6f7dea..cae94fc4661 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -838,7 +838,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
>   * @mem_type: EFI type of memory added
>   * Return: status code
>   */
> -efi_status_t efi_add_memory_map(u64 start, u64 size,
> +efi_status_t efi_add_memory_map(ulong start, ulong size,
>                                 enum efi_memory_type mem_type);
>
>  /**
> @@ -852,7 +852,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
>   *                             memory
>   * Return:                     status code
>   */
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
>                                    enum efi_memory_type mem_type,
>                                    bool overlap_conventional);
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 2c46915e5b9..4e9c372b622 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -199,10 +199,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>  {
>         struct efi_mem_list *newmap;
>         struct efi_mem_desc *map_desc = &map->desc;
> -       uint64_t map_start = map_desc->physical_start;
> -       uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> -       uint64_t carve_start = carve_desc->physical_start;
> -       uint64_t carve_end = carve_start +
> +       ulong map_start = map_desc->physical_start;
> +       ulong map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> +       ulong carve_start = carve_desc->physical_start;
> +       ulong carve_end = carve_start +
>                              (carve_desc->num_pages << EFI_PAGE_SHIFT);
>
>         /* check whether we're overlapping */
> @@ -257,17 +257,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
>         return EFI_CARVE_LOOP_AGAIN;
>  }
>
> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
>                                    enum efi_memory_type mem_type,
>                                    bool overlap_conventional)
>  {
>         struct efi_mem_list *lmem;
>         struct efi_mem_list *newlist;
>         bool carve_again;
> -       uint64_t carved_pages = 0;
> +       ulong carved_pages = 0;
>         struct efi_event *evt;
>
> -       EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> +       EFI_PRINT("%s: 0x%lx 0x%lx %d %s\n", __func__,
>                   start, pages, mem_type, overlap_conventional ?
>                   "yes" : "no");
>
> @@ -370,10 +370,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
>         return EFI_SUCCESS;
>  }
>
> -efi_status_t efi_add_memory_map(u64 start, u64 size,
> +efi_status_t efi_add_memory_map(ulong start, ulong size,
>                                 enum efi_memory_type mem_type)
>  {
> -       u64 pages;
> +       ulong pages;
>
>         pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
>         start &= ~EFI_PAGE_MASK;
> @@ -396,13 +396,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
>   * @must_be_allocated: return success if the page is allocated
>   * Return:             status code
>   */
> -static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
> +static efi_status_t efi_check_allocated(ulong addr, bool must_be_allocated)
>  {
>         struct efi_mem_list *item;
>
>         list_for_each_entry(item, &efi_mem, link) {
> -               u64 start = item->desc.physical_start;
> -               u64 end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
> +               ulong start = item->desc.physical_start;
> +               ulong end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
>
>                 if (addr >= start && addr < end) {
>                         if (must_be_allocated ^
> @@ -420,7 +420,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>                                 enum efi_memory_type mem_type,
>                                 efi_uintn_t pages, uint64_t *memory)
>  {
> -       u64 efi_addr, len;
> +       ulong efi_addr, len;
>         uint flags;
>         efi_status_t ret;
>         phys_addr_t addr;
> @@ -430,7 +430,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>                 return EFI_INVALID_PARAMETER;
>         if (!memory)
>                 return EFI_INVALID_PARAMETER;
> -       len = (u64)pages << EFI_PAGE_SHIFT;
> +       len = (ulong)pages << EFI_PAGE_SHIFT;
>         /* Catch possible overflow on 64bit systems */
>         if (sizeof(efi_uintn_t) == sizeof(u64) &&
>             (len >> EFI_PAGE_SHIFT) != (u64)pages)
> @@ -491,7 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
>   */
>  efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>  {
> -       u64 len;
> +       ulong len;
>         long status;
>         efi_status_t ret;
>
> @@ -506,7 +506,7 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>                 return EFI_INVALID_PARAMETER;
>         }
>
> -       len = (u64)pages << EFI_PAGE_SHIFT;
> +       len = (ulong)pages << EFI_PAGE_SHIFT;
>         /*
>          * The 'memory' variable for sandbox holds a pointer which has already
>          * been mapped with map_sysmem() from efi_allocate_pages(). Convert
> @@ -525,10 +525,10 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>  void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
>                               size_t align)
>  {
> -       u64 req_pages = efi_size_in_pages(len);
> -       u64 true_pages = req_pages + efi_size_in_pages(align) - 1;
> -       u64 free_pages;
> -       u64 aligned_mem;
> +       ulong req_pages = efi_size_in_pages(len);
> +       ulong true_pages = req_pages + efi_size_in_pages(align) - 1;
> +       ulong free_pages;
> +       ulong aligned_mem;
>         efi_status_t r;
>         u64 mem;
>
> @@ -572,7 +572,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
>         efi_status_t r;
>         u64 addr;
>         struct efi_pool_allocation *alloc;
> -       u64 num_pages = efi_size_in_pages(size +
> +       ulong num_pages = efi_size_in_pages(size +
>                                           sizeof(struct efi_pool_allocation));
>
>         if (!buffer)
> --
> 2.43.0
>
