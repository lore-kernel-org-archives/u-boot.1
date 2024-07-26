Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72280C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D797188361;
	Fri, 26 Jul 2024 10:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+ZVAh5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A175E8304A; Fri, 26 Jul 2024 10:31:46 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3E387CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-75a6c290528so552200a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721982702; x=1722587502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l9av2cLruQYZaPJIRtlUhA2Egl6moIlp874jPcdTzPU=;
 b=e+ZVAh5Z/azifzXUHDsmW7ea9+mQg7Xmhd0vxiOc6KM+3v4vSszNG1Cn0VVk2LaaFp
 uTgDe3uMZOz6KwAJ5Ok+IKixuAK67RGS5SRkv9qSGqqBdBKnMKlSglNLIzGAKBMK7lZf
 S6MLdbefA2m5Y+YfZjJal5n18VYgH8AlPKaEy24U9LiBZ4fE5jkJ7Wtaex9aX4PvMs+p
 CX0SFzSjjmDvvPcHBzSY+dwK6dCPcoQTIYL0Hum1FDsVnvvxG8ZMJaBcf87C7b/JexLJ
 RpWUSLt/IYeQxLMUL33SGvVrcgz+9c+kL6gAlWqXkdO3qNdnpYHLYmroT8pMxsIX+wTx
 qZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721982702; x=1722587502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l9av2cLruQYZaPJIRtlUhA2Egl6moIlp874jPcdTzPU=;
 b=noopaBUrm5KzEM0vlN57rOpOavC3jeExaicZrc4HhvLJtHXLPPX3VCZFgBFbIfqNPl
 /PJ9ejTPV8UthUtI25kB8fjOc7S0tf3118NX5rxIeWqMGr06D5ivxOBvO4eXjPtdHp8J
 IP3W5fAyX6YdWYcUoQwm/KEvTM05TW9vL1JqH8BfXuwRBEUBpSuuVT829IhK0HJ/IAjr
 o7rOapgBOagvZeKqJwvb1Xj0Wj7TdILYTPSxBlIpztuwhLhRBQtElcDljNJq8pyFyf/c
 craoJqYRhLeyUywEgJ4Sgy0tw5Mba0DYHsed6yO37q7SM+bhGDRo2RWu6rashPS+3pCe
 EZQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3YQxaJ+760MhaS2X9nn1nwA9FOFLExqDU0zoui5c3KrobX8cqvb66m1gCPBe/74zMV/WAFbSeh5BvjFHLR4Ug3saqwQ==
X-Gm-Message-State: AOJu0YwHFiXR4SQYXAmhBDL77a+Il8ir5VlL5I6Ctxw12P/E7AeOVnQl
 NzHcwVJUDigI1025SxKSfMxSTTcDsLGOjNLZr7a39e4A5CC6H/+EHhhR050BgpWHYwCOVKTFhmg
 Na9Lm24cw7Wze7XFodsv+HfK8IFf/bt8Lk7+CIQ==
X-Google-Smtp-Source: AGHT+IGr5S4bNurDStYSRm3iPWpQzbnERHVydwnMRXpyHxIl9amJcX3yOgfzATxIMD7CggZjOo6FI3frJ6Mgpcc9k60=
X-Received: by 2002:a17:90b:4f88:b0:2cb:4c25:f941 with SMTP id
 98e67ed59e1d1-2cf2e9e1aa6mr5120078a91.17.1721982701961; Fri, 26 Jul 2024
 01:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-6-sjg@chromium.org>
 <72e02ed6-f8c3-4caa-8ae6-2cef00a2ddd2@gmx.de>
 <CAFLszTjBw9wfFjwn2UeM=TNYCjCQP3xoBCmfv8WcWs515nOKxw@mail.gmail.com>
In-Reply-To: <CAFLszTjBw9wfFjwn2UeM=TNYCjCQP3xoBCmfv8WcWs515nOKxw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jul 2024 11:31:05 +0300
Message-ID: <CAC_iWjJbs=i6gWHzeHbsHwFv5BC+6PWy0NesKFFWC1=ERAvcQw@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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


On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 25.07.24 15:56, Simon Glass wrote:
> > > This API call is intended for allocating small amounts of memory,
> > > similar to malloc(). The current implementation rounds up to whole pages
> > > which can waste large amounts of memory. It also implements its own
> > > malloc()-style header on each block.
> > >
> > > Use U-Boot's built-in malloc() instead, to avoid these problems:
> > >
> > > - it should normally be large enough for pool allocations
> > > - if it isn't we can enforce a minimum size for boards which use
> > >    EFI_LOADER
> > > - the existing mechanism may create an unwatned entry in the memory map
> > > - it is used for most EFI allocations already
> > >
> > > One side effect is that this seems to be showing up some bugs in the
> > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > This has likely crept in due to the very large gaps between allocations
> > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > too small. Work around this by increasing the size for now, until these
> > > (presumed) bugs are located.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
> > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 2945f5648c7..fabe9e3a87a 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > >   void *efi_bounce_buffer;
> > >   #endif
> > >
> > > -/**
> > > - * struct efi_pool_allocation - memory block allocated from pool
> > > - *
> > > - * @num_pages:       number of pages allocated
> > > - * @checksum:        checksum
> > > - * @data:    allocated pool memory
> > > - *
> > > - * U-Boot services each UEFI AllocatePool() request as a separate
> > > - * (multiple) page allocation. We have to track the number of pages
> > > - * to be able to free the correct amount later.
> > > - *
> > > - * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > - * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > - *
> > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > - * prepend each allocation with these header fields.
> > > - */
> > > -struct efi_pool_allocation {
> > > -     u64 num_pages;
> > > -     u64 checksum;
> > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > -};
> > > -
> > > -/**
> > > - * checksum() - calculate checksum for memory allocated from pool
> > > - *
> > > - * @alloc:   allocation header
> > > - * Return:   checksum, always non-zero
> > > - */
> > > -static u64 checksum(struct efi_pool_allocation *alloc)
> > > -{
> > > -     u64 addr = (uintptr_t)alloc;
> > > -     u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> > > -               EFI_ALLOC_POOL_MAGIC;
> > > -     if (!ret)
> > > -             ++ret;
> > > -     return ret;
> > > -}
> > > -
> > >   /**
> > >    * efi_mem_cmp() - comparator function for sorting memory map
> > >    *
> > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > >    * @buffer: allocated memory
> > >    * Return:  status code
> > >    */
> > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > +                            void **buffer)
> > >   {
> > > -     efi_status_t r;
> > > -     u64 addr;
> > > -     struct efi_pool_allocation *alloc;
> > > -     u64 num_pages = efi_size_in_pages(size +
> > > -                                       sizeof(struct efi_pool_allocation));
> > > +     void *ptr;
> > >
> > >       if (!check_allowed())
> > >               return EFI_UNSUPPORTED;
> > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > >               return EFI_SUCCESS;
> > >       }
> >
> > Unfortunately this patch does not match the UEFI specification:
> >
> > Two different memory types cannot reside in the same memory page. You
> > have to keep track of the memory type of each allocated memory page and
> > report it in GetMemoryMap().
>
> I actually hadn't thought about that. Is it implied in the spec or
> actually stated somewhere?

I don't remember if it's explicitly stated, but it *really* doesn't
have to be. Although u-boot doesn't currently support this on modern
secure systems you can't have code and data mixed on the same page.
This would prevent you to map pages with proper permissions and take
advantage of CPU security features  e.g RW^X.

In any case, the AllocatePool description reads "This function
allocates pages from EfiConventionalMemory as needed to grow the
requested pool type. All allocations are eight-byte aligned". I don't
think using malloc in AllocatePool is appropriate. If we ever want to
do that and allocate from the malloc space, we need to teach malloc
some EFI semantics, but that's a really bad idea.

>
> Anyway, from what I can tell, we mostly use EFI_BOOT_SERVICES_DATA.
> The only exception is EFI_RUNTIME_SERVICES_DATA for the runtime stuff.

That's not entirely correct, we use a lot more than these 2.
EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMORY from a
quick grep

/Ilias

>
> So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA allocations
> and stick with whole pages otherwise? That will mostly fix the problem
> I am seeing.
>
> >
> > The specification is available https://uefi.org/specifications.
>
> The problem is that it is thousands of pages so it is hard to pick up
> on some of these issues.
>
> >
> > >
> > > -     r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > -                            &addr);
> > > -     if (r == EFI_SUCCESS) {
> > > -             alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > -             alloc->num_pages = num_pages;
> > > -             alloc->checksum = checksum(alloc);
> > > -             *buffer = alloc->data;
> > > -     }
> > > +     /*
> > > +      * Some tests crash on qemu_arm etc. if the correct size is allocated.
> > > +      * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > +      * Increasing it to 0x20 seems to fix test_efi_selftest_base except
> > > +      * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > +      *
> > > +      * This workaround can be dropped once these problems are resolved
> > > +      */
> > > +     ptr = memalign(8, size + 0x100);
> >
> > We were using ARCH_DMA_MINALIGN before this patch.
>
> Where is that in the code? All I see is EFI_PAGE_SHIFT.
>
> >
> > If we are overwriting allocated memory, we must fix that instead of
> > increasing size. Do you have a git tag showing the problem?
>
> Not easy to do, because the 4KB per allocation thing has been there
> from the start. It might be possible to apply my patch to earlier and
> earlier U-Boots to try to bisect it.
>
> Regards,
> Simon
>
>
>
> >
> > Best regards
> >
> > Heinrich
> >
> > > +     if (!ptr)
> > > +             return EFI_OUT_OF_RESOURCES;
> > > +
> > > +     *buffer = ptr;
> > >
> > > -     return r;
> > > +     return EFI_SUCCESS;
> > >   }
> > >
> > >   /**
> > > @@ -742,30 +705,12 @@ void *efi_alloc(size_t size)
> > >    */
> > >   efi_status_t efi_free_pool(void *buffer)
> > >   {
> > > -     efi_status_t ret;
> > > -     struct efi_pool_allocation *alloc;
> > > -
> > >       if (!buffer)
> > >               return EFI_INVALID_PARAMETER;
> > >
> > > -     ret = efi_check_allocated((uintptr_t)buffer, true);
> > > -     if (ret != EFI_SUCCESS)
> > > -             return ret;
> > > -
> > > -     alloc = container_of(buffer, struct efi_pool_allocation, data);
> > > -
> > > -     /* Check that this memory was allocated by efi_allocate_pool() */
> > > -     if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > > -         alloc->checksum != checksum(alloc)) {
> > > -             printf("%s: illegal free 0x%p\n", __func__, buffer);
> > > -             return EFI_INVALID_PARAMETER;
> > > -     }
> > > -     /* Avoid double free */
> > > -     alloc->checksum = 0;
> > > -
> > > -     ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > > +     free(buffer);
> > >
> > > -     return ret;
> > > +     return EFI_SUCCESS;
> > >   }
> > >
> > >   /**
> >
