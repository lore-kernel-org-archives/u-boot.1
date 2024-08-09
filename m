Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48744C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A818895D;
	Fri,  9 Aug 2024 20:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUxoJXDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4442879AF; Fri,  9 Aug 2024 20:36:45 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5163488C25
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso19363056d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723228602; x=1723833402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QIP7AfEJj5SFiOK3HXKjxPRLhuiv6I2o8KF6WH+fXIo=;
 b=LUxoJXDrusrdOCe5RFgpeT40CJsbCUMFTUA3X64SW3jydrTWJCnQvJJcCYEXtoUmlU
 0YHzCRsfvO/PCEiU+1+NfhyhOBg0EI/xwmr3o9/toKR8K7lvwVCQ6Wf/LnN+l/+iG7Hf
 L7AxWXPmTlKdjeKmAtFMaXVgG1CFWDv9Y9FN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723228602; x=1723833402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QIP7AfEJj5SFiOK3HXKjxPRLhuiv6I2o8KF6WH+fXIo=;
 b=oBnwrVM15S7qpKVYmB/yU/CSDed/ZEnKU2h5L7ifjb0Z8lzqyA4Bi+KQoSNNsVYSg/
 XEfFNZi+2omxKum7KSxtsi5YHvd6nAsRpYfYTjGRdWosHBhDXkoZHCwXY/tgsvlWtM6u
 d9fUCdOoRuSYVlltYd7deZwRs3B+2qtLN+PpiicBWTkjLJCrfYpRjj/LTrdBXL7A4MkS
 XZqqz9fI/E9wpLu+Zq1TO2iB8FS2zwpOM9gXRObFSKHlLoK1gWjDfLeKow1iWKxDU5mT
 t2BUgHDECm3oXGUJA45oHaSTNS+755WmA8y7IFarfjSrG3NnlyQ5UFCUtZoJXnOiqPsT
 8xCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGSfpkmPj7toxU0AlX7LB0pzv889hBWahkGYyreiegSpMtriyqbCID4f/SXrcuiaOm8Z38VcgXWqrumje3KQkBJldn8A==
X-Gm-Message-State: AOJu0YxEH0uRCunWcexCWZM/mB+U4IFPD2E+38PfbHJOFchAUVh9WySE
 0BEw46MwPofpaJnuaBe+AOfBT+sTqfDvC96lCCTJULfVRIxmQTKCHzfqL0iJgFObs3PFUgXWsLN
 Sa7m4gE+S7s2pLTE+FNsI+wv113Jorqujq1sx
X-Google-Smtp-Source: AGHT+IFkX8CtzxridgG2VvF919RXAvUvJ7rfN/RAQXAZZJVSjF2QDwOfv3Cp9gQi1svcu3oQMeiaV3J9EKXt/RrRrB4=
X-Received: by 2002:a05:6214:3bc2:b0:6b5:ce93:c3fc with SMTP id
 6a1803df08f44-6bd78d53de8mr35108816d6.18.1723228602056; Fri, 09 Aug 2024
 11:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240801173637.1071068-1-sjg@chromium.org>
 <20240801173637.1071068-2-sjg@chromium.org>
 <81a85e93-5712-4262-9f68-cd6a93624beb@gmx.de>
In-Reply-To: <81a85e93-5712-4262-9f68-cd6a93624beb@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 12:36:31 -0600
Message-ID: <CAFLszTjEnP2jDAyHdMwzFqY4B6LGaio+u-H0xwetCUF2vKQwFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi: Allow use of malloc() for the EFI pool
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

Hi Heinrich,

On Fri, 9 Aug 2024 at 10:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 01.08.24 19:36, Simon Glass wrote:
> > This API call is intended for allocating small amounts of memory,
> > similar to malloc(). The current implementation rounds up to whole pages
> > which can waste large amounts of memory. It also implements its own
> > malloc()-style header on each block.
> >
> > For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> > use U-Boot's built-in malloc() instead, at least until the app starts.
> > This avoids poluting the memory space with blocks of data which may
> > interfere with boot scripts, etc.
> >
> > Once the app has started, there is no advantage to using malloc(), since
> > it doesn't matter what memory is used: everything is under control of
> > the EFI subsystem. Also, using malloc() after the app starts might
> > result in running of memory, since U-Boot's malloc() space is typically
> > quite small.
> >
> > In fact, malloc() is already used for most EFI-related allocations, so
> > the impact of this change is fairly small.
> >
> > One side effect is that this seems to be showing up some bugs in the
> > EFI code, since the malloc() pool becomes corrupted when running some of
> > the tests.
> >
> > This has likely crept in due to the very large gaps between allocations
> > (around 4KB), which provides a lot of leeway when the allocation size is
> > too small. Work around this by increasing the size for now, until these
> > (presumed) bugs are located.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   common/dlmalloc.c            |   7 +++
> >   include/efi_loader.h         |  18 ++++++
> >   include/malloc.h             |   7 +++
> >   lib/efi_loader/efi_bootbin.c |   2 +
> >   lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> >   5 files changed, 117 insertions(+), 27 deletions(-)
> >
> > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > index 62e8557daa7..0bc77395035 100644
> > --- a/common/dlmalloc.c
> > +++ b/common/dlmalloc.c
> > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> >   #endif
> >   }
> >
> > +bool malloc_check_in_range(void *ptr)
> > +{
> > +     ulong val = (ulong)ptr;
> > +
> > +     return val >= mem_malloc_start && val < mem_malloc_end;
> > +}
> > +
> >   /* field-extraction macros */
> >
> >   #define first(b) ((b)->fd)
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f84852e384f..31899bef99e 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -796,6 +796,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> >   int efi_disk_remove(void *ctx, struct event *event);
> >   /* Called by board init to initialize the EFI memory map */
> >   int efi_memory_init(void);
> > +
> > +/**
> > + * enum efi_alloc_flags - controls EFI memory allocation
> > + *
> > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > + *   EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > + */
> > +enum efi_alloc_flags {
> > +     EFIAF_USE_MALLOC        = BIT(0),
> > +};
> > +
> > +/**
> > + * efi_set_alloc() - Set behaviour of EFI memory allocation
> > + *
> > + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> > + */
> > +void efi_set_alloc(int flags);
> > +
> >   /* Adds new or overrides configuration table entry to the system table */
> >   efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> >   /* Sets up a loaded image */
> > diff --git a/include/malloc.h b/include/malloc.h
> > index 07d3e90a855..a64f117e2f2 100644
> > --- a/include/malloc.h
> > +++ b/include/malloc.h
> > @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
> >
> >   void mem_malloc_init(ulong start, ulong size);
> >
> > +/**
> > + * malloc_check_in_range() - Check if a pointer is within the malloc() region
> > + *
> > + * Return: true if within malloc() region
> > + */
> > +bool malloc_check_in_range(void *ptr);
> > +
> >   #ifdef __cplusplus
> >   };  /* end of extern "C" */
> >   #endif
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index a87006b3c0e..5bb0fdcf75d 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >   {
> >       efi_status_t ret;
> >
> > +     efi_set_alloc(0);
> > +
> >       /* Initialize EFI drivers */
> >       ret = efi_init_obj_list();
> >       if (ret != EFI_SUCCESS) {
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index c6f1dd09456..3c3d05eef94 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
> >   /* Magic number identifying memory allocated from pool */
> >   #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
> >
> > +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags */
> > +static int alloc_flags;
> > +
> > +void efi_set_alloc(int flags)
> > +{
> > +     alloc_flags = flags;
> > +}
> > +
> >   efi_uintn_t efi_memory_map_key;
> >
> >   struct efi_mem_list {
> > @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
> >    * The checksum calculated in function checksum() is used in FreePool() to avoid
> >    * freeing memory not allocated by AllocatePool() and duplicate freeing.
> >    *
> > - * EFI requires 8 byte alignment for pool allocations, so we can
> > - * prepend each allocation with these header fields.
> > + * EFI requires 8-byte alignment for pool allocations, so we can prepend each
> > + * allocation with these header fields.
> > + *
> > + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA allocations
> > + * are served using malloc(), bypassing this struct. This helps to avoid memory
> > + * fragmentation, since efi_allocate_pages() uses any pages it likes.
> >    */
> >   struct efi_pool_allocation {
> >       u64 num_pages;
> > @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> >   /**
> >    * efi_allocate_pool - allocate memory from pool
> >    *
> > + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_USE_MALLOC
> > + * is enabled
> > + *
> >    * @pool_type:      type of the pool from which memory is to be allocated
> >    * @size:   number of bytes to be allocated
> >    * @buffer: allocated memory
> >    * Return:  status code
> >    */
> > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > +                            void **buffer)
> >   {
> >       efi_status_t r;
> >       u64 addr;
> > -     struct efi_pool_allocation *alloc;
> > -     u64 num_pages = efi_size_in_pages(size +
> > -                                       sizeof(struct efi_pool_allocation));
> >
> >       if (!buffer)
> >               return EFI_INVALID_PARAMETER;
> > @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> >               return EFI_SUCCESS;
> >       }
> >
> > -     r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > -                            &addr);
> > -     if (r == EFI_SUCCESS) {
> > -             alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > -             alloc->num_pages = num_pages;
> > -             alloc->checksum = checksum(alloc);
> > -             *buffer = alloc->data;
> > +     if ((alloc_flags & EFIAF_USE_MALLOC) &&
> > +         pool_type == EFI_BOOT_SERVICES_DATA) {
> > +             void *ptr;
> > +
> > +             /*
> > +              * Some tests crash on qemu_arm etc. if the correct size is
> > +              * allocated.
> > +              * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > +              * Increasing it to 0x20 seems to fix test_efi_selftest_base
> > +              * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> > +              *
> > +              * This workaround can be dropped once these problems are
> > +              * resolved
> > +              */
> > +             ptr = memalign(8, size + 0x100);
>
> We don't want voodoo code. Please, analyze what is going on.
>
> The allocations were cache line size aligned (0x40) because our
> file-system drivers rely on it.

Where is that documented and which allocation call is doing this?

>
> > +             if (!ptr)
> > +                     return EFI_OUT_OF_RESOURCES;
>
> This will not work for allocating more memory than is in the malloc pool
> as pointed out in a previous review comment. The malloc pool is 2 MiB or
> less.

Before the app starts, only a very small amount of memory is
allocated. Please read the patch thoroughly.

>
> An EFI program can reasonable expect that the largest chunk of
> unallocated conventional memory reported in the memory map can be
> allocated with AllocatePool().
>
> How will this code allocate 6 GiB on a 16 GiB board?

Again, this is supported by the patch. I can add a test to the testapp
if you like.

>
> We should not have different code paths depending on the EFI memory type.

Why is that?

>
> A reasonable solution would be a single memory allocator replacing
> malloc(), LMB(), and the EFI memory management which is aware of EFI
> memory types.

Perhaps, although I doubt it very much. We never actually resolved
that discussion though. So for now I am doing this patch-up series.

Anyway that point has almost nothing to do with this patch, which is
aimed at avoiding strange allocations 'in space' which no one expects.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> > +
> > +             *buffer = ptr;
> > +             r = EFI_SUCCESS;
> > +             log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
> > +     } else {
> > +             u64 num_pages = efi_size_in_pages(size +
> > +                                     sizeof(struct efi_pool_allocation));
> > +
> > +             r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> > +                                    num_pages, &addr);
> > +             if (r == EFI_SUCCESS) {
> > +                     struct efi_pool_allocation *alloc;
> > +
> > +                     alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > +                     alloc->num_pages = num_pages;
> > +                     alloc->checksum = checksum(alloc);
> > +                     *buffer = alloc->data;
> > +                     log_debug("EFI pool: pages alloc(%zx) type %d = %p\n",
> > +                               size, pool_type, *buffer);
> > +             }
> >       }
> >
> >       return r;
> > @@ -695,27 +738,37 @@ void *efi_alloc(size_t size)
> >   efi_status_t efi_free_pool(void *buffer)
> >   {
> >       efi_status_t ret;
> > -     struct efi_pool_allocation *alloc;
> >
> >       if (!buffer)
> >               return EFI_INVALID_PARAMETER;
> >
> > -     ret = efi_check_allocated((uintptr_t)buffer, true);
> > -     if (ret != EFI_SUCCESS)
> > -             return ret;
> > +     if (malloc_check_in_range(buffer)) {
> > +             log_debug("EFI pool: free(%p)\n", buffer);
> > +             free(buffer);
> > +             ret = EFI_SUCCESS;
> > +     } else {
> > +             struct efi_pool_allocation *alloc;
> >
> > -     alloc = container_of(buffer, struct efi_pool_allocation, data);
> > +             ret = efi_check_allocated((uintptr_t)buffer, true);
> > +             if (ret != EFI_SUCCESS)
> > +                     return ret;
> >
> > -     /* Check that this memory was allocated by efi_allocate_pool() */
> > -     if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > -         alloc->checksum != checksum(alloc)) {
> > -             printf("%s: illegal free 0x%p\n", __func__, buffer);
> > -             return EFI_INVALID_PARAMETER;
> > -     }
> > -     /* Avoid double free */
> > -     alloc->checksum = 0;
> > +             alloc = container_of(buffer, struct efi_pool_allocation, data);
> >
> > -     ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > +             /*
> > +              * Check that this memory was allocated by efi_allocate_pool()
> > +              */
> > +             if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > +                 alloc->checksum != checksum(alloc)) {
> > +                     printf("%s: illegal free 0x%p\n", __func__, buffer);
> > +                     return EFI_INVALID_PARAMETER;
> > +             }
> > +             /* Avoid double free */
> > +             alloc->checksum = 0;
> > +
> > +             ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > +             log_debug("EFI pool: pages free(%p)\n", buffer);
> > +     }
> >
> >       return ret;
> >   }
> > @@ -935,6 +988,9 @@ static void add_u_boot_and_runtime(void)
> >
> >   int efi_memory_init(void)
> >   {
> > +     /* use malloc() pool where possible */
> > +     efi_set_alloc(EFIAF_USE_MALLOC);
> > +
> >       efi_add_known_memory();
> >
> >       add_u_boot_and_runtime();
>
