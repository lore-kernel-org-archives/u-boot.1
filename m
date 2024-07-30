Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B2C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F7C88883;
	Tue, 30 Jul 2024 16:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="njpncDag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7195788800; Tue, 30 Jul 2024 16:53:09 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D91888AB
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6cbeaebb-4e83-11ef-af74-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6cbeaebb-4e83-11ef-af74-005056994fde;
 Tue, 30 Jul 2024 16:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=4NTeIUAGg9URuOfpqF2jQAFMS+PK4ElCn8DLB6El1v8=;
 b=njpncDagbdFRcSWtKWjl5u2b1KzNaAvcfvghZa/wT38Z8mXtoUzTFts3XdTXRlw1bAdnln2b+x1Hi
 7PnFxU7QGl/q/34P0SVgkdvxksl4R/MtrmrzCZO1e884vnXY+QF9Uhu7XyoXgV+hIktGKpWdj2tZAq
 nk69WZrpM2R94lxeF3aPYdaeuT/BxVV5v7LasImpFLvpfpmVV6ZY7O6HnIMBWPYCAL6oX7JxgH9Jy6
 oIwtC6p8hH8XlYnqdSkgOYoDSL3Q8htVcQyWUc2f7ZwiavYZpUrWWlqjjGaVO8OD0rZLdiWB6zd0Ts
 YECUvjNIRjLBjikYEpxOi3DXBzJRQDg==
X-KPN-MID: 33|DfQdXj4niw4J4VFcO3iMN9Or/tkEGKI9MV1ybvSF429xuwlh/7IW1rXowkkvcm3
 s3Y0kjjfAURLKDs45IPZpzQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RPplbgL7dN3ZfyQ8SLCzqQz8CtUSLz+G7/A1+p+K6I0G0rw8NuiNbozZUkXxulU
 3pE22dJu33nc6FTEuVfDZbg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6d559aa5-4e83-11ef-93f4-00505699772e;
 Tue, 30 Jul 2024 16:53:06 +0200 (CEST)
Date: Tue, 30 Jul 2024 16:53:05 +0200
Message-Id: <87ttg7x772.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 sughosh.ganu@linaro.org, trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 (message from Simon Glass on Tue, 30 Jul 2024 08:38:03 -0600)
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
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

> From: Simon Glass <sjg@chromium.org>
> Date: Tue, 30 Jul 2024 08:38:03 -0600
> 
> Hi Ilias,
> 
> On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon
> > > >
> > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > >
> > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > This API call is intended for allocating small amounts of memory,
> > > > > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > > > > malloc()-style header on each block.
> > > > > > > > >
> > > > > > > > > Use U-Boot's built-in malloc() instead, to avoid these problems:
> > > > > > > > >
> > > > > > > > > - it should normally be large enough for pool allocations
> > > > > > > > > - if it isn't we can enforce a minimum size for boards which use
> > > > > > > > >    EFI_LOADER
> > > > > > > > > - the existing mechanism may create an unwatned entry in the memory map
> > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > >
> > > > > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > > > > (presumed) bugs are located.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
> > > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > >   #endif
> > > > > > > > >
> > > > > > > > > -/**
> > > > > > > > > - * struct efi_pool_allocation - memory block allocated from pool
> > > > > > > > > - *
> > > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > > - * @checksum:        checksum
> > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > - *
> > > > > > > > > - * U-Boot services each UEFI AllocatePool() request as a separate
> > > > > > > > > - * (multiple) page allocation. We have to track the number of pages
> > > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > > - *
> > > > > > > > > - * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > > > > > > > - * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > > > > > > > - *
> > > > > > > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > > > > > > - * prepend each allocation with these header fields.
> > > > > > > > > - */
> > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > -     u64 num_pages;
> > > > > > > > > -     u64 checksum;
> > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > > -};
> > > > > > > > > -
> > > > > > > > > -/**
> > > > > > > > > - * checksum() - calculate checksum for memory allocated from pool
> > > > > > > > > - *
> > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > - */
> > > > > > > > > -static u64 checksum(struct efi_pool_allocation *alloc)
> > > > > > > > > -{
> > > > > > > > > -     u64 addr = (uintptr_t)alloc;
> > > > > > > > > -     u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > -     if (!ret)
> > > > > > > > > -             ++ret;
> > > > > > > > > -     return ret;
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > >   /**
> > > > > > > > >    * efi_mem_cmp() - comparator function for sorting memory map
> > > > > > > > >    *
> > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > > > > > > >    * @buffer: allocated memory
> > > > > > > > >    * Return:  status code
> > > > > > > > >    */
> > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > +                            void **buffer)
> > > > > > > > >   {
> > > > > > > > > -     efi_status_t r;
> > > > > > > > > -     u64 addr;
> > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > -     u64 num_pages = efi_size_in_pages(size +
> > > > > > > > > -                                       sizeof(struct efi_pool_allocation));
> > > > > > > > > +     void *ptr;
> > > > > > > > >
> > > > > > > > >       if (!check_allowed())
> > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > >       }
> > > > > > > >
> > > > > > > > Unfortunately this patch does not match the UEFI specification:
> > > > > > > >
> > > > > > > > Two different memory types cannot reside in the same memory page. You
> > > > > > > > have to keep track of the memory type of each allocated memory page and
> > > > > > > > report it in GetMemoryMap().
> > > > > > >
> > > > > > > I actually hadn't thought about that. Is it implied in the spec or
> > > > > > > actually stated somewhere?
> > > > > >
> > > > > > I don't remember if it's explicitly stated, but it *really* doesn't
> > > > > > have to be. Although u-boot doesn't currently support this on modern
> > > > > > secure systems you can't have code and data mixed on the same page.
> > > > > > This would prevent you to map pages with proper permissions and take
> > > > > > advantage of CPU security features  e.g RW^X.
> > > > >
> > > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVICES_CODE
> > > > > through EFI. Perhaps the difference between EFI_BOOT_SERVICES_CODE and
> > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > >
> > > > > But if we did want to fix that, we could make the malloc region
> > > > > EFI_BOOT_SERVICES_DATA.
> > > > >
> > > > > >
> > > > > > In any case, the AllocatePool description reads "This function
> > > > > > allocates pages from EfiConventionalMemory as needed to grow the
> > > > > > requested pool type. All allocations are eight-byte aligned". I don't
> > > > > > think using malloc in AllocatePool is appropriate. If we ever want to
> > > > > > do that and allocate from the malloc space, we need to teach malloc
> > > > > > some EFI semantics, but that's a really bad idea.
> > > > >
> > > > > Here I don't see the difference between EFI's malloc(n) and
> > > > > memalign(8, n). I do see a lot of comments like 'use the spec', 'read
> > > > > the spec'. It seems very clear to me that the bootloader can use
> > > > > whatever algorithm it likes to provide the allocated memory for the
> > > > > pool.
> > > > >
> > > > > What sort of EFI semantics are you referring to?
> > > >
> > > > the memory type. Your patch removes the call to efi_allocate_pages
> > > > which tracks it.
> > >
> > > I can put that code back, depending on what we decide below.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_SERVICES_DATA.
> > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for the runtime stuff.
> > > > > >
> > > > > > That's not entirely correct, we use a lot more than these 2.
> > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMORY from a
> > > > > > quick grep
> > > > >
> > > > > Yes I did a quick grep too, but then checked each site. The first two
> > > > > are used in an EFI app, not U-Boot itself. The ACPI one is not an
> > > > > allocation.
> > > > >
> > > > > > >
> > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA allocations
> > > > > > > and stick with whole pages otherwise? That will mostly fix the problem
> > > > > > > I am seeing.
> > > > >
> > > > > Any comments on this?
> > > >
> > > > This violates the spec and probably breaks a few tests and the EFI
> > > > boot services API, as you are supposed to be able to define the memory
> > > > type. We might be able to control it from U-Boot, but EFI apps are
> > > > going to end up being buggy and hard to debug -- e.g an app calls
> > > > allocatePool to allocate memory that needs to be preserved at runtime.
> > >
> > > To be more specific, I am suggesting:
> > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with no memory
> > > type since it is always that). This should cover all the U-Boot
> > > allocations and make sure they are safely within the malloc() pool
> > > - use efi_allocate_pages() for other memory types (keeping the memory
> > > type in metadata)
> > >
> >
> > Personally, I don't see the point and we deviate from the spec as
> > well. Perhaps Heinrich thinks otherwise, but the EFI spec still says
> > you need to allocate *pages* to grow the pool. What's missing from our
> > efi_allocate_pool() is the ability to merge allocations of the same
> > memory type to an existing pool assuming there's space, rather than
> > requesting a new pool of 4kb.
> 
> "This function allocates pages from EfiConventionalMemory as needed to
> grow the requested pool type". So far as EFI is concerned, the
> malloc() region is in EfiConventionalMemory, so I don't see any
> deviation.
> 
> Please also see below.
> 
> > > >
> > > > You can switch some callsite of efi_allocate_pool to
> > > > efi_allocate_pages() internally. Will that fix the behavior?
> > >
> > > It still allocates memory 'in space' and uses 4KB for each allocation.
> > >
> 
> This is the key point that doesn't seem to be coming across. The
> current allocator is allocating memory wherever it likes, potentially
> interfering with the kernel_addr_r addresses, etc. as on qemu_arm.

And even if we'd go ahead with your idea, there would still be other
EFI allocations that would interefere.

The real solution here is to start thinking about these addresses as
reservations, and actually record those reservations properly.  That
is kind-of what I did for the apple machines: the various addresses
are determined by allocating memory blocks using LMB.
