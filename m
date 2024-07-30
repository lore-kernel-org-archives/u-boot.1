Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A4DC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7141688846;
	Tue, 30 Jul 2024 16:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CwO0qpOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF0A88640; Tue, 30 Jul 2024 16:38:18 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9648885D
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a1dd2004e1so288383685a.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350294; x=1722955094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FbFjEwZmC2rnbz5S90+bK+cmYVfh0BfDKcTmIh2lCw=;
 b=CwO0qpOdj1+S94nsiCmfz8Km329UH47PYwU4Ze8T5PD1mwMoTEc1FllqEKb5uSCaxT
 zrZ/oVk5HsQXyZ6bpaSpnM+fV083T7C4BWCGmePWFAmYjMBXnKzXxvylh+u8wteVAvTN
 kAwW6UmePE45bDMMYXsJ0id2j7fPub7twD7wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350294; x=1722955094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FbFjEwZmC2rnbz5S90+bK+cmYVfh0BfDKcTmIh2lCw=;
 b=nwDmnm1liA1i1z3dW9CJY6/YSCUWqBCm3wbkhOkc2DThBdxqwtzB41Da6bVf19S9U8
 JKc5XENMQq8p+vBbkE1fH1TW5LY3BLHgo7OjDRVjyireL64G8TtA8AARXVua1eOgW+eE
 kMtMYvtwZw14J8A516YzS3yWl2GQzlk4G+fkd4l5UBdTmiriU2p2Rne22XhHdcByJsoA
 eeb+GlJNJ6GhUz2EW2o19dUof7/fV+uJpXbh0tykAxoCj/c69W0Ag/B00QOlWmLm8muX
 qqKBi3FetdoeXmTYjSgFXLaAil2kSLJKY/FDZ585z2dIAd86IRroYQailIOyBr0/gJM5
 XHtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrt8RH4bN/WxJwzMt8coB93bWqt7KzpJgVPK6EjgUx4N4F3sDB47/2VEZ4+zpecPGcj1PSobkkXus6Yk5zPto+Nvau6Q==
X-Gm-Message-State: AOJu0YwGVpwMDSFqqTTRr9wMWg+Pkj1Xq1WdaONS1WOOGr6NjYwXeeO5
 aMNfTG8rR0yvv5x/y4G8QPgT3jjXqxsuDOkR+1uiC1F/XwKYxu+lWXvklGMiWFmstAk/wKKLymF
 6P5PD6Kn3+000KWh17sB5JiZJNFDnv8wb/gNp
X-Google-Smtp-Source: AGHT+IGjcsqtzkfO6bQQ0ARdWCXjbcMgxYg4DCoIPJHjYsQ9TizOAUicFDlNfqdebC3gnZdDYHz5HpARinZVnXU/Q5g=
X-Received: by 2002:a05:6214:f6c:b0:6b5:4e07:2a55 with SMTP id
 6a1803df08f44-6bb55a74f68mr146996386d6.29.1722350293886; Tue, 30 Jul 2024
 07:38:13 -0700 (PDT)
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
In-Reply-To: <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 08:38:03 -0600
Message-ID: <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
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

On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon
> > >
> > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > >
> > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > This API call is intended for allocating small amounts of memory,
> > > > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > > > malloc()-style header on each block.
> > > > > > > >
> > > > > > > > Use U-Boot's built-in malloc() instead, to avoid these problems:
> > > > > > > >
> > > > > > > > - it should normally be large enough for pool allocations
> > > > > > > > - if it isn't we can enforce a minimum size for boards which use
> > > > > > > >    EFI_LOADER
> > > > > > > > - the existing mechanism may create an unwatned entry in the memory map
> > > > > > > > - it is used for most EFI allocations already
> > > > > > > >
> > > > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > > > (presumed) bugs are located.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
> > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > >   void *efi_bounce_buffer;
> > > > > > > >   #endif
> > > > > > > >
> > > > > > > > -/**
> > > > > > > > - * struct efi_pool_allocation - memory block allocated from pool
> > > > > > > > - *
> > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > - * @checksum:        checksum
> > > > > > > > - * @data:    allocated pool memory
> > > > > > > > - *
> > > > > > > > - * U-Boot services each UEFI AllocatePool() request as a separate
> > > > > > > > - * (multiple) page allocation. We have to track the number of pages
> > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > - *
> > > > > > > > - * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > > > > > > - * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > > > > > > - *
> > > > > > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > > > > > - * prepend each allocation with these header fields.
> > > > > > > > - */
> > > > > > > > -struct efi_pool_allocation {
> > > > > > > > -     u64 num_pages;
> > > > > > > > -     u64 checksum;
> > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > -};
> > > > > > > > -
> > > > > > > > -/**
> > > > > > > > - * checksum() - calculate checksum for memory allocated from pool
> > > > > > > > - *
> > > > > > > > - * @alloc:   allocation header
> > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > - */
> > > > > > > > -static u64 checksum(struct efi_pool_allocation *alloc)
> > > > > > > > -{
> > > > > > > > -     u64 addr = (uintptr_t)alloc;
> > > > > > > > -     u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > -     if (!ret)
> > > > > > > > -             ++ret;
> > > > > > > > -     return ret;
> > > > > > > > -}
> > > > > > > > -
> > > > > > > >   /**
> > > > > > > >    * efi_mem_cmp() - comparator function for sorting memory map
> > > > > > > >    *
> > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > > > > > >    * @buffer: allocated memory
> > > > > > > >    * Return:  status code
> > > > > > > >    */
> > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > +                            void **buffer)
> > > > > > > >   {
> > > > > > > > -     efi_status_t r;
> > > > > > > > -     u64 addr;
> > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > -     u64 num_pages = efi_size_in_pages(size +
> > > > > > > > -                                       sizeof(struct efi_pool_allocation));
> > > > > > > > +     void *ptr;
> > > > > > > >
> > > > > > > >       if (!check_allowed())
> > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > >               return EFI_SUCCESS;
> > > > > > > >       }
> > > > > > >
> > > > > > > Unfortunately this patch does not match the UEFI specification:
> > > > > > >
> > > > > > > Two different memory types cannot reside in the same memory page. You
> > > > > > > have to keep track of the memory type of each allocated memory page and
> > > > > > > report it in GetMemoryMap().
> > > > > >
> > > > > > I actually hadn't thought about that. Is it implied in the spec or
> > > > > > actually stated somewhere?
> > > > >
> > > > > I don't remember if it's explicitly stated, but it *really* doesn't
> > > > > have to be. Although u-boot doesn't currently support this on modern
> > > > > secure systems you can't have code and data mixed on the same page.
> > > > > This would prevent you to map pages with proper permissions and take
> > > > > advantage of CPU security features  e.g RW^X.
> > > >
> > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVICES_CODE
> > > > through EFI. Perhaps the difference between EFI_BOOT_SERVICES_CODE and
> > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > >
> > > > But if we did want to fix that, we could make the malloc region
> > > > EFI_BOOT_SERVICES_DATA.
> > > >
> > > > >
> > > > > In any case, the AllocatePool description reads "This function
> > > > > allocates pages from EfiConventionalMemory as needed to grow the
> > > > > requested pool type. All allocations are eight-byte aligned". I don't
> > > > > think using malloc in AllocatePool is appropriate. If we ever want to
> > > > > do that and allocate from the malloc space, we need to teach malloc
> > > > > some EFI semantics, but that's a really bad idea.
> > > >
> > > > Here I don't see the difference between EFI's malloc(n) and
> > > > memalign(8, n). I do see a lot of comments like 'use the spec', 'read
> > > > the spec'. It seems very clear to me that the bootloader can use
> > > > whatever algorithm it likes to provide the allocated memory for the
> > > > pool.
> > > >
> > > > What sort of EFI semantics are you referring to?
> > >
> > > the memory type. Your patch removes the call to efi_allocate_pages
> > > which tracks it.
> >
> > I can put that code back, depending on what we decide below.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_SERVICES_DATA.
> > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for the runtime stuff.
> > > > >
> > > > > That's not entirely correct, we use a lot more than these 2.
> > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMORY from a
> > > > > quick grep
> > > >
> > > > Yes I did a quick grep too, but then checked each site. The first two
> > > > are used in an EFI app, not U-Boot itself. The ACPI one is not an
> > > > allocation.
> > > >
> > > > > >
> > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA allocations
> > > > > > and stick with whole pages otherwise? That will mostly fix the problem
> > > > > > I am seeing.
> > > >
> > > > Any comments on this?
> > >
> > > This violates the spec and probably breaks a few tests and the EFI
> > > boot services API, as you are supposed to be able to define the memory
> > > type. We might be able to control it from U-Boot, but EFI apps are
> > > going to end up being buggy and hard to debug -- e.g an app calls
> > > allocatePool to allocate memory that needs to be preserved at runtime.
> >
> > To be more specific, I am suggesting:
> > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with no memory
> > type since it is always that). This should cover all the U-Boot
> > allocations and make sure they are safely within the malloc() pool
> > - use efi_allocate_pages() for other memory types (keeping the memory
> > type in metadata)
> >
>
> Personally, I don't see the point and we deviate from the spec as
> well. Perhaps Heinrich thinks otherwise, but the EFI spec still says
> you need to allocate *pages* to grow the pool. What's missing from our
> efi_allocate_pool() is the ability to merge allocations of the same
> memory type to an existing pool assuming there's space, rather than
> requesting a new pool of 4kb.

"This function allocates pages from EfiConventionalMemory as needed to
grow the requested pool type". So far as EFI is concerned, the
malloc() region is in EfiConventionalMemory, so I don't see any
deviation.

Please also see below.

> > >
> > > You can switch some callsite of efi_allocate_pool to
> > > efi_allocate_pages() internally. Will that fix the behavior?
> >
> > It still allocates memory 'in space' and uses 4KB for each allocation.
> >

This is the key point that doesn't seem to be coming across. The
current allocator is allocating memory wherever it likes, potentially
interfering with the kernel_addr_r addresses, etc. as on qemu_arm.

> > > > > > >
> > > > > > > The specification is available https://uefi.org/specifications.
> > > > > >
> > > > > > The problem is that it is thousands of pages so it is hard to pick up
> > > > > > on some of these issues.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > -     r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > > > > > > -                            &addr);
> > > > > > > > -     if (r == EFI_SUCCESS) {
> > > > > > > > -             alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > > > > > -             alloc->num_pages = num_pages;
> > > > > > > > -             alloc->checksum = checksum(alloc);
> > > > > > > > -             *buffer = alloc->data;
> > > > > > > > -     }
> > > > > > > > +     /*
> > > > > > > > +      * Some tests crash on qemu_arm etc. if the correct size is allocated.
> > > > > > > > +      * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > > > > > > +      * Increasing it to 0x20 seems to fix test_efi_selftest_base except
> > > > > > > > +      * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > > > > > > +      *
> > > > > > > > +      * This workaround can be dropped once these problems are resolved
> > > > > > > > +      */
> > > > > > > > +     ptr = memalign(8, size + 0x100);
> > > > > > >
> > > > > > > We were using ARCH_DMA_MINALIGN before this patch.
> > > > > >
> > > > > > Where is that in the code? All I see is EFI_PAGE_SHIFT.
> > > > > >
> > > > > > >
> > > > > > > If we are overwriting allocated memory, we must fix that instead of
> > > > > > > increasing size. Do you have a git tag showing the problem?
> > > > > >
> > > > > > Not easy to do, because the 4KB per allocation thing has been there
> > > > > > from the start. It might be possible to apply my patch to earlier and
> > > > > > earlier U-Boots to try to bisect it.
> > > >
> > > > Would anyone like to take a look at these presumed bugs?
> > > >
> > > > It might be worth moving to a newer dlmalloc() [1,2] as it has a checker.
> > > >
> > > > > >
> > > > [..]
> > > >
> > > >
> > > > [1] https://gee.cs.oswego.edu/dl/html/malloc.html
> > > > [2] https://gee.cs.oswego.edu/pub/misc/malloc.c

Regards,
Simon
