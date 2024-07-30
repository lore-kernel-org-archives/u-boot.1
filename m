Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA06C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 15:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D578882C;
	Tue, 30 Jul 2024 17:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WwO+Pg38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580CB88800; Tue, 30 Jul 2024 17:18:17 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F56088747
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 17:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7a3e4686eso25858416d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722352693; x=1722957493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hiQ4HphX+oUpzHt4dYZi0zLB+DP9X7qvp0eK26teEXk=;
 b=WwO+Pg38mzy+J1jiXJe7O8F75JQOA3enIHVOjZmU/1Z12az7bLb072sP22reIE3kBs
 sI2FlPBxwXL0IVDVLqhSUeEg/AblZTAxqFGgUExgYR1fNOgKnx5c+BG2ytKWYZE7AAc8
 LjhXFKQ/czwEN6vQGxdBX8BOx1YqJDJNKmxUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722352693; x=1722957493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hiQ4HphX+oUpzHt4dYZi0zLB+DP9X7qvp0eK26teEXk=;
 b=O5qU2EHQyE56Q2uhkSDepXMHQjLhuu1ueABmDmEAq2qBEJpzTak31ZotNe0Su9qWUR
 uiPnPfNdDCrawOUmyeKu2JnngCxk3O+3bDYDvRPdRVLDRCvFSOPrKkUkCclGaCLFpJXz
 UNCwNbLqXge4vlkoTFh1cFTz1yQhJJY0v5afRYqstcP9AiV/+OAQpcV4FfigPU5aY0IW
 yjYdDe9a10yi9jzwch1wfkxJ0LE3KVncopOl6piklggl1CaD9OKre5lAgqyM5YUAQt5/
 ON1iChOzsquVkJCogdQ5czao0VuCGnH5ROOLqLS49rPLz9TxnWGIpiQhWMzsv2kGK413
 6FTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUmr2Oa8yCiDxrJXAKcy8TjiCrnDdy/T1xYdlk7YVyFAjvQVtDCBbk05SY3fLfapnf6IdOkC7EQ9iC405FunFY11c3sg==
X-Gm-Message-State: AOJu0Yz5C56OC9JHHnQpLa+qWvMUd8zSZPUFa18T+dDzve3Cb0BYMEtE
 UZRNYAsIFlfhoofo3hucVJLsrbGWuJ2D4pgvS0oy+x63E6KT8+IH94ge7gnSAKpj7u8dIxWpW/8
 QyReK/q9uTMkPTvZfCBi1XxoKQ6+3GWvmB5WdrF+eublpay8=
X-Google-Smtp-Source: AGHT+IHgVxjK9wjchjz1LbZg6ego1XaMLkjLIt/Ln1OenY6K1Ulzbh45C38EJlHri+BTpwLKG1VGXqDMGnwleUil6po=
X-Received: by 2002:a05:6214:e48:b0:6b5:e9a6:8416 with SMTP id
 6a1803df08f44-6bb55aca27cmr136016276d6.48.1722352693113; Tue, 30 Jul 2024
 08:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-6-sjg@chromium.org>
 <72e02ed6-f8c3-4caa-8ae6-2cef00a2ddd2@gmx.de>
 <CAFLszTjBw9wfFjwn2UeM=TNYCjCQP3xoBCmfv8WcWs515nOKxw@mail.gmail.com>
 <CAC_iWjJbs=i6gWHzeHbsHwFv5BC+6PWy0NesKFFWC1=ERAvcQw@mail.gmail.com>
 <CAFLszTgkwUvou2i0zVCxJPDqGQPxbKUHE41gMs5Kt1_SToL9LA@mail.gmail.com>
 <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
In-Reply-To: <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 09:18:02 -0600
Message-ID: <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon
> > > > >
> > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > >
> > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > This API call is intended for allocating small amounts of memory,
> > > > > > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > >
> > > > > > > > > > Use U-Boot's built-in malloc() instead, to avoid these problems:
> > > > > > > > > >
> > > > > > > > > > - it should normally be large enough for pool allocations
> > > > > > > > > > - if it isn't we can enforce a minimum size for boards which use
> > > > > > > > > >    EFI_LOADER
> > > > > > > > > > - the existing mechanism may create an unwatned entry in the memory map
> > > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > > >
> > > > > > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
> > > > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > >   #endif
> > > > > > > > > >
> > > > > > > > > > -/**
> > > > > > > > > > - * struct efi_pool_allocation - memory block allocated from pool
> > > > > > > > > > - *
> > > > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > - *
> > > > > > > > > > - * U-Boot services each UEFI AllocatePool() request as a separate
> > > > > > > > > > - * (multiple) page allocation. We have to track the number of pages
> > > > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > > > - *
> > > > > > > > > > - * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > > > > > > > > - * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > > > > > > > > - *
> > > > > > > > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > > > > > > > - * prepend each allocation with these header fields.
> > > > > > > > > > - */
> > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > -     u64 checksum;
> > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > > > -};
> > > > > > > > > > -
> > > > > > > > > > -/**
> > > > > > > > > > - * checksum() - calculate checksum for memory allocated from pool
> > > > > > > > > > - *
> > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > - */
> > > > > > > > > > -static u64 checksum(struct efi_pool_allocation *alloc)
> > > > > > > > > > -{
> > > > > > > > > > -     u64 addr = (uintptr_t)alloc;
> > > > > > > > > > -     u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > -     if (!ret)
> > > > > > > > > > -             ++ret;
> > > > > > > > > > -     return ret;
> > > > > > > > > > -}
> > > > > > > > > > -
> > > > > > > > > >   /**
> > > > > > > > > >    * efi_mem_cmp() - comparator function for sorting memory map
> > > > > > > > > >    *
> > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > >    * Return:  status code
> > > > > > > > > >    */
> > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > +                            void **buffer)
> > > > > > > > > >   {
> > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > -     u64 addr;
> > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > -     u64 num_pages = efi_size_in_pages(size +
> > > > > > > > > > -                                       sizeof(struct efi_pool_allocation));
> > > > > > > > > > +     void *ptr;
> > > > > > > > > >
> > > > > > > > > >       if (!check_allowed())
> > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > Unfortunately this patch does not match the UEFI specification:
> > > > > > > > >
> > > > > > > > > Two different memory types cannot reside in the same memory page. You
> > > > > > > > > have to keep track of the memory type of each allocated memory page and
> > > > > > > > > report it in GetMemoryMap().
> > > > > > > >
> > > > > > > > I actually hadn't thought about that. Is it implied in the spec or
> > > > > > > > actually stated somewhere?
> > > > > > >
> > > > > > > I don't remember if it's explicitly stated, but it *really* doesn't
> > > > > > > have to be. Although u-boot doesn't currently support this on modern
> > > > > > > secure systems you can't have code and data mixed on the same page.
> > > > > > > This would prevent you to map pages with proper permissions and take
> > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > >
> > > > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVICES_CODE
> > > > > > through EFI. Perhaps the difference between EFI_BOOT_SERVICES_CODE and
> > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > >
> > > > > > But if we did want to fix that, we could make the malloc region
> > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > >
> > > > > > >
> > > > > > > In any case, the AllocatePool description reads "This function
> > > > > > > allocates pages from EfiConventionalMemory as needed to grow the
> > > > > > > requested pool type. All allocations are eight-byte aligned". I don't
> > > > > > > think using malloc in AllocatePool is appropriate. If we ever want to
> > > > > > > do that and allocate from the malloc space, we need to teach malloc
> > > > > > > some EFI semantics, but that's a really bad idea.
> > > > > >
> > > > > > Here I don't see the difference between EFI's malloc(n) and
> > > > > > memalign(8, n). I do see a lot of comments like 'use the spec', 'read
> > > > > > the spec'. It seems very clear to me that the bootloader can use
> > > > > > whatever algorithm it likes to provide the allocated memory for the
> > > > > > pool.
> > > > > >
> > > > > > What sort of EFI semantics are you referring to?
> > > > >
> > > > > the memory type. Your patch removes the call to efi_allocate_pages
> > > > > which tracks it.
> > > >
> > > > I can put that code back, depending on what we decide below.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_SERVICES_DATA.
> > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for the runtime stuff.
> > > > > > >
> > > > > > > That's not entirely correct, we use a lot more than these 2.
> > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMORY from a
> > > > > > > quick grep
> > > > > >
> > > > > > Yes I did a quick grep too, but then checked each site. The first two
> > > > > > are used in an EFI app, not U-Boot itself. The ACPI one is not an
> > > > > > allocation.
> > > > > >
> > > > > > > >
> > > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA allocations
> > > > > > > > and stick with whole pages otherwise? That will mostly fix the problem
> > > > > > > > I am seeing.
> > > > > >
> > > > > > Any comments on this?
> > > > >
> > > > > This violates the spec and probably breaks a few tests and the EFI
> > > > > boot services API, as you are supposed to be able to define the memory
> > > > > type. We might be able to control it from U-Boot, but EFI apps are
> > > > > going to end up being buggy and hard to debug -- e.g an app calls
> > > > > allocatePool to allocate memory that needs to be preserved at runtime.
> > > >
> > > > To be more specific, I am suggesting:
> > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with no memory
> > > > type since it is always that). This should cover all the U-Boot
> > > > allocations and make sure they are safely within the malloc() pool
> > > > - use efi_allocate_pages() for other memory types (keeping the memory
> > > > type in metadata)
> > > >
> > >
> > > Personally, I don't see the point and we deviate from the spec as
> > > well. Perhaps Heinrich thinks otherwise, but the EFI spec still says
> > > you need to allocate *pages* to grow the pool. What's missing from our
> > > efi_allocate_pool() is the ability to merge allocations of the same
> > > memory type to an existing pool assuming there's space, rather than
> > > requesting a new pool of 4kb.
> >
> > "This function allocates pages from EfiConventionalMemory as needed to
> > grow the requested pool type". So far as EFI is concerned, the
> > malloc() region is in EfiConventionalMemory, so I don't see any
> > deviation.
> >
> > Please also see below.
> >
> > > > >
> > > > > You can switch some callsite of efi_allocate_pool to
> > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > >
> > > > It still allocates memory 'in space' and uses 4KB for each allocation.
> > > >
> >
> > This is the key point that doesn't seem to be coming across. The
> > current allocator is allocating memory wherever it likes, potentially
> > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
>
> It is, but I don't think using malloc is solving it. It's papering
> over the problem, because if someone in the future launches an EFI app
> or allocates EFI memory with a different type you are back on the same
> problem.

It is certainly solving this problem.

Once the app is launched it is OK to overwrite memory...after all it
has been loaded and is running. The issue is that these little
allocations can end up anywhere in memory. Did you see the qemu_arm
note?

Regards,
Simon

> >
> > > > > > > > >
> > > > > > > > > The specification is available https://uefi.org/specifications.
> > > > > > > >
> > > > > > > > The problem is that it is thousands of pages so it is hard to pick up
> > > > > > > > on some of these issues.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > -     r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > > > > > > > > -                            &addr);
> > > > > > > > > > -     if (r == EFI_SUCCESS) {
> > > > > > > > > > -             alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > > > > > > > -             alloc->num_pages = num_pages;
> > > > > > > > > > -             alloc->checksum = checksum(alloc);
> > > > > > > > > > -             *buffer = alloc->data;
> > > > > > > > > > -     }
> > > > > > > > > > +     /*
> > > > > > > > > > +      * Some tests crash on qemu_arm etc. if the correct size is allocated.
> > > > > > > > > > +      * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > > > > > > > > +      * Increasing it to 0x20 seems to fix test_efi_selftest_base except
> > > > > > > > > > +      * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > > > > > > > > +      *
> > > > > > > > > > +      * This workaround can be dropped once these problems are resolved
> > > > > > > > > > +      */
> > > > > > > > > > +     ptr = memalign(8, size + 0x100);
> > > > > > > > >
> > > > > > > > > We were using ARCH_DMA_MINALIGN before this patch.
> > > > > > > >
> > > > > > > > Where is that in the code? All I see is EFI_PAGE_SHIFT.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > If we are overwriting allocated memory, we must fix that instead of
> > > > > > > > > increasing size. Do you have a git tag showing the problem?
> > > > > > > >
> > > > > > > > Not easy to do, because the 4KB per allocation thing has been there
> > > > > > > > from the start. It might be possible to apply my patch to earlier and
> > > > > > > > earlier U-Boots to try to bisect it.
> > > > > >
> > > > > > Would anyone like to take a look at these presumed bugs?
> > > > > >
> > > > > > It might be worth moving to a newer dlmalloc() [1,2] as it has a checker.
> > > > > >
> > > > > > > >
> > > > > > [..]
> > > > > >
> > > > > >
> > > > > > [1] https://gee.cs.oswego.edu/dl/html/malloc.html
> > > > > > [2] https://gee.cs.oswego.edu/pub/misc/malloc.c
