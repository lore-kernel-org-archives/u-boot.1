Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADD6D3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABF489739;
	Tue, 26 Nov 2024 16:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RUeqtDYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C254F89C76; Tue, 26 Nov 2024 16:40:27 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A0188E0F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so278779066b.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635625; x=1733240425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d4qEouYJs2lLS/3gmSpVWr+TEA33r1t3RvXR3ocVjv4=;
 b=RUeqtDYMuVUox/JESRaFottvWHxIEDiNn5gMcKDE/F0hn7W+LSED8SyoAnNL31QVx0
 0XIcTu5GvhN9tgEuDjKj9NudxcUJTb17NCKB744tx2dOkiYcQSlv2ZzNGBEFza28mSn/
 8oNDmQllq1aXk83krfHAYSATc029dTg0qy8BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635625; x=1733240425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4qEouYJs2lLS/3gmSpVWr+TEA33r1t3RvXR3ocVjv4=;
 b=sz3Xx06npslNAJpNyEzFIPGiDbsFuh1jZ5k1798e7SHpa+ChtEijfTEenhnF3TAhqF
 wicbsBNh4BCFD2Y5lr/TXSKDfdJvXW5MF9z4ckJU5p8uQL/smmGYfOGHiMjfpE5gpY7b
 q161K3o5Ki5nCXqMgyaU4waHwitJfNqbcsTiW/0GANljeY7RBmj0JIC/VebSngFEPmyh
 SyvYmHddHR5L21ZvYSJQMofP+kiy0DaCmVsowrgwQLAdFHcSH/6hIJ554YhQRzExen9n
 OYpwjdIkBpPu8SZRY92mbZPQ5iE7ZqKmnWS9f54MorECEkg0Os9dZJDZjMICVjg6DRgw
 YFDA==
X-Gm-Message-State: AOJu0YwlCM5aIaFFVqP3qLq2hxMIN76FmgBKJc2kznTs2mWHkoGUB7G1
 xWKCkjjK64xxuA1+TUo0rdN2nH52MfbU882AQSStsbpkpN2XThjFW5yBY/OXL/RUjvbQn54ixK0
 hLhnwLj2e7/duq6/eyJSaWyF/0YdsCVl1ezaQ
X-Gm-Gg: ASbGncuBwijOyiKhz6gv9MP7pkCgvZzcVHdQ4PsRp0/QzEAzzXfXQJJDHxhBR+U62p6
 vGiLONCGTH/xEVMgQLR1gVHPXqha8Ah8=
X-Google-Smtp-Source: AGHT+IHDpvp6aqi7mE4iZZY5jqB70A3fn0BibT9UDS13V4twcQrAz8iTFJa5J+gOrdUC5NHRPD4f7TUuNUQWmslvYhE=
X-Received: by 2002:a17:907:d23:b0:aa4:ecf6:baa2 with SMTP id
 a640c23a62f3a-aa509d3fc15mr1695295266b.46.1732635624893; Tue, 26 Nov 2024
 07:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-8-sjg@chromium.org>
 <CAC_iWjKAWrgFuKrNBq_+J9Tr726Aoor4+b=sPYwfydxfC6bevg@mail.gmail.com>
 <e0493294-0e67-4645-bc19-3b895f13c356@gmx.de>
In-Reply-To: <e0493294-0e67-4645-bc19-3b895f13c356@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:40:13 -0700
Message-ID: <CAFLszTg+5Jz22--VsfXKP09xr1MMyFEzDYM=OMXt50aJgw0VXA@mail.gmail.com>
Subject: Re: [PATCH 07/13] efi_loader: Make more use of ulong
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 03:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 26.11.24 09:00, Ilias Apalodimas wrote:
> > Hi Simon,
> >
> >
> > On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> One of the confusing parts of the EFI loader is that it uses u64 for
> >> addresses, whereas the rest of U-Boot typically uses ulong.
>
> You are confusing sandbox virtual addresses (phys_addr_t) with the
> physical addresses (EFI_PHYSICAL_ADDRESS) in the UEFI spec.

No, I am actually trying to resolve the confusion between ulong and
void * in the EFI code. Note that phys_addr_t is unrelated to sandbox.

>
> The EFI specification requires an identity mapping. This means the value
> of a EFI_PHYSICAL_ADDRESS must be usable as a pointer.

Yes, that's right.

>
> The sandbox virtual addresses are not usable as pointers on the sandbox
> and hence cannot be used for EFI_PHYSICAL_ADDRESS.
>
> EFI_PHYSICAL_ADDRESS is a 64bit type.
>
> The only useful place for sandbox virtual addresses is in the CLI. We
> should get rid of them anywhere else to avoid further confusion.

This is not correct and this attitude is making it very hard to
understand what the EFI loader is doing with memory.

>
> >>
> >> There is a case on 32-bit machines where phys_addr_t can be larger than
> >> 32 bits, but this is very much the exception. Also, such machines have
> >> mostly faded away and generally don't make use of EFI.
> >
> > I am not sure how true this statement is with LPAE etc. In any case, I
> > don't want us to convert to ulong, there's no reason to break things
> > for platforms we can't test.  So please drop this patch
> >
> > Thanks
> > /Ilias
> >>
> >> So in the interests of consistency, update the memory functions to use
> >> ulong in most cases.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >>   include/efi_loader.h        |  4 ++--
> >>   lib/efi_loader/efi_memory.c | 42 ++++++++++++++++++-------------------
> >>   2 files changed, 23 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >> index 0ef4c6f7dea..cae94fc4661 100644
> >> --- a/include/efi_loader.h
> >> +++ b/include/efi_loader.h
> >> @@ -838,7 +838,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >>    * @mem_type: EFI type of memory added
> >>    * Return: status code
> >>    */
> >> -efi_status_t efi_add_memory_map(u64 start, u64 size,
> >> +efi_status_t efi_add_memory_map(ulong start, ulong size,
> >>                                  enum efi_memory_type mem_type);
> >>
> >>   /**
> >> @@ -852,7 +852,7 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
> >>    *                             memory
> >>    * Return:                     status code
> >>    */
> >> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
> >>                                     enum efi_memory_type mem_type,
> >>                                     bool overlap_conventional);
> >>
> >> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >> index 2c46915e5b9..4e9c372b622 100644
> >> --- a/lib/efi_loader/efi_memory.c
> >> +++ b/lib/efi_loader/efi_memory.c
> >> @@ -199,10 +199,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >>   {
> >>          struct efi_mem_list *newmap;
> >>          struct efi_mem_desc *map_desc = &map->desc;
> >> -       uint64_t map_start = map_desc->physical_start;
> >> -       uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> >> -       uint64_t carve_start = carve_desc->physical_start;
> >> -       uint64_t carve_end = carve_start +
> >> +       ulong map_start = map_desc->physical_start;
> >> +       ulong map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
> >> +       ulong carve_start = carve_desc->physical_start;
> >> +       ulong carve_end = carve_start +
> >>                               (carve_desc->num_pages << EFI_PAGE_SHIFT);
> >>
> >>          /* check whether we're overlapping */
> >> @@ -257,17 +257,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >>          return EFI_CARVE_LOOP_AGAIN;
> >>   }
> >>
> >> -efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >> +efi_status_t efi_add_memory_map_pg(ulong start, ulong pages,
> >>                                     enum efi_memory_type mem_type,
> >>                                     bool overlap_conventional)
> >>   {
> >>          struct efi_mem_list *lmem;
> >>          struct efi_mem_list *newlist;
> >>          bool carve_again;
> >> -       uint64_t carved_pages = 0;
> >> +       ulong carved_pages = 0;
> >>          struct efi_event *evt;
> >>
> >> -       EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
> >> +       EFI_PRINT("%s: 0x%lx 0x%lx %d %s\n", __func__,
> >>                    start, pages, mem_type, overlap_conventional ?
> >>                    "yes" : "no");
> >>
> >> @@ -370,10 +370,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >>          return EFI_SUCCESS;
> >>   }
> >>
> >> -efi_status_t efi_add_memory_map(u64 start, u64 size,
> >> +efi_status_t efi_add_memory_map(ulong start, ulong size,
> >>                                  enum efi_memory_type mem_type)
> >>   {
> >> -       u64 pages;
> >> +       ulong pages;
>
> The result of efi_size_in_pages() is u64.
>
> >>
> >>          pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
>
> Maybe we should check here that pages <= SIZE_T_MAX.
>
> >>          start &= ~EFI_PAGE_MASK;
> >> @@ -396,13 +396,13 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
> >>    * @must_be_allocated: return success if the page is allocated
> >>    * Return:             status code
> >>    */
> >> -static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
> >> +static efi_status_t efi_check_allocated(ulong addr, bool must_be_allocated)
> >>   {
> >>          struct efi_mem_list *item;
> >>
> >>          list_for_each_entry(item, &efi_mem, link) {
> >> -               u64 start = item->desc.physical_start;
> >> -               u64 end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
> >> +               ulong start = item->desc.physical_start;
> >> +               ulong end = start + (item->desc.num_pages << EFI_PAGE_SHIFT);
>
> Physical start is u64 as defined in the EFI standard. ulong makes no
> sense here.

My understanding is that a 32-bit machine cannot access 64-bit
addresses in U-Boot, so accounting for them makes no sense?

>
> >>
> >>                  if (addr >= start && addr < end) {
> >>                          if (must_be_allocated ^
> >> @@ -420,7 +420,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >>                                  enum efi_memory_type mem_type,
> >>                                  efi_uintn_t pages, uint64_t *memory)
> >>   {
> >> -       u64 efi_addr, len;
> >> +       ulong efi_addr, len;
>
> efi_allocate_pages must return u64. Using ulong for efi_addr does not match.
>
> >>          uint flags;
> >>          efi_status_t ret;
> >>          phys_addr_t addr;
> >> @@ -430,7 +430,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >>                  return EFI_INVALID_PARAMETER;
> >>          if (!memory)
> >>                  return EFI_INVALID_PARAMETER;
> >> -       len = (u64)pages << EFI_PAGE_SHIFT;
> >> +       len = (ulong)pages << EFI_PAGE_SHIFT;
> >>          /* Catch possible overflow on 64bit systems */
> >>          if (sizeof(efi_uintn_t) == sizeof(u64) &&
> >>              (len >> EFI_PAGE_SHIFT) != (u64)pages)
> >> @@ -491,7 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
> >>    */
> >>   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> >>   {
> >> -       u64 len;
> >> +       ulong len;
>
> pages << EFI_PAGE_SHIFT may be more than ULONG_MAX on 32bit systems.
>
> >>          long status;
> >>          efi_status_t ret;
> >>
> >> @@ -506,7 +506,7 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> >>                  return EFI_INVALID_PARAMETER;
> >>          }
> >>
> >> -       len = (u64)pages << EFI_PAGE_SHIFT;
> >> +       len = (ulong)pages << EFI_PAGE_SHIFT;
>
> This might overflow on 32bit systems.
>
> >>          /*
> >>           * The 'memory' variable for sandbox holds a pointer which has already
> >>           * been mapped with map_sysmem() from efi_allocate_pages(). Convert
> >> @@ -525,10 +525,10 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
> >>   void *efi_alloc_aligned_pages(u64 len, enum efi_memory_type mem_type,
> >>                                size_t align)
> >>   {
> >> -       u64 req_pages = efi_size_in_pages(len);
> >> -       u64 true_pages = req_pages + efi_size_in_pages(align) - 1;
> >> -       u64 free_pages;
> >> -       u64 aligned_mem;
> >> +       ulong req_pages = efi_size_in_pages(len);
>
> Please, use efi_uintn_t as this is the parameter type of AllocatePages().
>
> >> +       ulong true_pages = req_pages + efi_size_in_pages(align) - 1;
> >> +       ulong free_pages;
> >> +       ulong aligned_mem;
>
> This does not compile on 32bit. efi_allocate_pages expects *u64 as
> parameter.
>
> >>          efi_status_t r;
> >>          u64 mem;
> >>
> >> @@ -572,7 +572,7 @@ efi_status_t efi_allocate_pool(enum efi_memory_type mem_type, efi_uintn_t size,
> >>          efi_status_t r;
> >>          u64 addr;
> >>          struct efi_pool_allocation *alloc;
> >> -       u64 num_pages = efi_size_in_pages(size +
> >> +       ulong num_pages = efi_size_in_pages(size +
> >>                                            sizeof(struct efi_pool_allocation));
>
> The EFI specification defines the argument parameter Pages of
> AllocatePages() as being UINTN. So we should use efi_uintn_t here.

We normally use ulong for size as well as address, in U-Boot.

Regards,
SImon
