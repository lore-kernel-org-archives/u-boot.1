Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72460CE7B06
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 13:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C641188CD1;
	Fri,  6 Sep 2024 15:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2j8igZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96ACC88CD9; Fri,  6 Sep 2024 15:01:39 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C61588936
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 15:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-457e2537611so11777221cf.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725627696; x=1726232496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EqFO7QiANoD//v3UXI1YLCwvxYHxVLitXSeREcTNOEI=;
 b=A2j8igZgXcqLL4rXjpL9sK9OKJsdaSJFSCtGqSjUoqpZrW6aUQn0Ok1kgyG8ijMf+s
 iOp7EdbYMV8i0UbvNBb4xKeSf2HecI8B2YLYdbQlf2+LuxYYRljY6BhLGX5fw+8nFzDq
 AmY5D/QSbAIXashIQDUImP74I8uRY1NzjLs1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725627696; x=1726232496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqFO7QiANoD//v3UXI1YLCwvxYHxVLitXSeREcTNOEI=;
 b=u4D3lrusC6MrwcovtUpnrZ8ARA7Jb8xYTvM0XQ1a5sOXUfy2W/pCOlHttUi4wgxGJZ
 nyVqFVdcRugWT2xD9fmEQX2h7aU1TYlUf6dxHuPtjqzHubn/080sy0wGzRTICQ1ysY5k
 0xcYEVOUIzl75dlCuO8jHDlGNTFJF084nQPyctOfxgDOHMYV5Kh1rshcZwR6RhxtSlvb
 /JbDzhX1JW1Gm8uUo2FRhoWZjalFz5+oRqXMSlLreBSFmrhoohLt3cvHOyNeYpkb8HL3
 404b3BlT1l5g/WRxqKCb9QIraAU1Zm5ojLYy2q/PxegwOlApAVIy4KPIWEnp6j8Rmyzx
 EggQ==
X-Gm-Message-State: AOJu0Yy4OPY7fwHaKiukhml8oKkLbjZedA/A9imEuZRU/gdghteHP+cw
 6Le/N24L2xLM7GYc41YIvtII4B1JpCRWWQUMMZDn8vijjUv6lwt/OARhVyK9JoatYwUGJb5XrMG
 W2lJ6Z1W8lbXGp+DLBJHAvFkmhNzcehn5YxKO
X-Google-Smtp-Source: AGHT+IF643vM5QMLQ2HvjpEQbNwaqleKHvwTTyIcYt7FvFb6LD5Y7j0jDgUOmHnIVjTDiebXCruXGJWjsc5Kgw/UkvI=
X-Received: by 2002:a05:6214:5d01:b0:6c3:66f2:a640 with SMTP id
 6a1803df08f44-6c5284f61a7mr24025306d6.31.1725627694245; Fri, 06 Sep 2024
 06:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
In-Reply-To: <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 07:01:22 -0600
Message-ID: <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
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

Hi Sughosh,

On Fri, 6 Sept 2024 at 00:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 2 Sept 2024 at 03:53, Simon Glass <sjg@chromium.org> wrote:
> >
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
> > EFI code, since the malloc() pool becomes corrupted with some tests.
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
> >  common/dlmalloc.c            |   7 +++
> >  include/efi_loader.h         |  18 ++++++
> >  include/malloc.h             |   7 +++
> >  lib/efi_loader/efi_bootbin.c |   2 +
> >  lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> >  5 files changed, 117 insertions(+), 27 deletions(-)
> >
> > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > index 1ac7ce3f43c..48e9f3515f7 100644
> > --- a/common/dlmalloc.c
> > +++ b/common/dlmalloc.c
> > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> >  #endif
> >  }
> >
> > +bool malloc_check_in_range(void *ptr)
> > +{
> > +       ulong val = (ulong)ptr;
> > +
> > +       return val >= mem_malloc_start && val < mem_malloc_end;
> > +}
> > +
> >  /* field-extraction macros */
> >
> >  #define first(b) ((b)->fd)
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 38971d01442..d07bc06bad4 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> >  int efi_disk_remove(void *ctx, struct event *event);
> >  /* Called by board init to initialize the EFI memory map */
> >  int efi_memory_init(void);
> > +
> > +/**
> > + * enum efi_alloc_flags - controls EFI memory allocation
> > + *
> > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > + */
> > +enum efi_alloc_flags {
> > +       EFIAF_USE_MALLOC        = BIT(0),
> > +};
> > +
> > +/**
> > + * efi_set_alloc() - Set behaviour of EFI memory allocation
> > + *
> > + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> > + */
> > +void efi_set_alloc(int flags);
> > +
> >  /* Adds new or overrides configuration table entry to the system table */
> >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> >  /* Sets up a loaded image */
> > diff --git a/include/malloc.h b/include/malloc.h
> > index 07d3e90a855..a64f117e2f2 100644
> > --- a/include/malloc.h
> > +++ b/include/malloc.h
> > @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
> >
> >  void mem_malloc_init(ulong start, ulong size);
> >
> > +/**
> > + * malloc_check_in_range() - Check if a pointer is within the malloc() region
> > + *
> > + * Return: true if within malloc() region
> > + */
> > +bool malloc_check_in_range(void *ptr);
> > +
> >  #ifdef __cplusplus
> >  };  /* end of extern "C" */
> >  #endif
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index a87006b3c0e..5bb0fdcf75d 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >  {
> >         efi_status_t ret;
> >
> > +       efi_set_alloc(0);
> > +
>
> Here we are setting the flags to use the efi_allocate_pages() route to
> allocate memory, when booting into an EFI app. Do we need to set it
> back to EFIAF_USE_MALLOC if the app exits and control lands back in
> U-Boot? I am not sure that is being handled.

I don't believe so. Once we have booted into the app, U-Boot loses
control of its memory layout, in the sense that the
efi_allocate_pages() has likely been called and placed things all over
the place in the memory. People should expect this.

We can potentially deal with this if we find a specific problem, but I
can't think of one at the moment.

>
> -sughosh
>
> >         /* Initialize EFI drivers */
> >         ret = efi_init_obj_list();
> >         if (ret != EFI_SUCCESS) {
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 50cb2f3898b..206d10f207a 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
> >  /* Magic number identifying memory allocated from pool */
> >  #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
> >
> > +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags */
> > +static int alloc_flags;
> > +
> > +void efi_set_alloc(int flags)
> > +{
> > +       alloc_flags = flags;
> > +}
> > +
> >  efi_uintn_t efi_memory_map_key;
> >
> >  struct efi_mem_list {
> > @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
> >   * The checksum calculated in function checksum() is used in FreePool() to avoid
> >   * freeing memory not allocated by AllocatePool() and duplicate freeing.
> >   *
> > - * EFI requires 8 byte alignment for pool allocations, so we can
> > - * prepend each allocation with these header fields.
> > + * EFI requires 8-byte alignment for pool allocations, so we can prepend each
> > + * allocation with these header fields.
> > + *
> > + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA allocations
> > + * are served using malloc(), bypassing this struct. This helps to avoid memory
> > + * fragmentation, since efi_allocate_pages() uses any pages it likes.
> >   */
> >  struct efi_pool_allocation {
> >         u64 num_pages;
> > @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> >  /**
> >   * efi_allocate_pool - allocate memory from pool
> >   *
> > + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_USE_MALLOC
> > + * is enabled
> > + *
> >   * @pool_type: type of the pool from which memory is to be allocated
> >   * @size:      number of bytes to be allocated
> >   * @buffer:    allocated memory
> >   * Return:     status code
> >   */
> > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > +                              void **buffer)
> >  {
> >         efi_status_t r;
> >         u64 addr;
> > -       struct efi_pool_allocation *alloc;
> > -       u64 num_pages = efi_size_in_pages(size +
> > -                                         sizeof(struct efi_pool_allocation));
> >
> >         if (!buffer)
> >                 return EFI_INVALID_PARAMETER;
> > @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> >                 return EFI_SUCCESS;
> >         }
> >
> > -       r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > -                              &addr);
> > -       if (r == EFI_SUCCESS) {
> > -               alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > -               alloc->num_pages = num_pages;
> > -               alloc->checksum = checksum(alloc);
> > -               *buffer = alloc->data;
> > +       if ((alloc_flags & EFIAF_USE_MALLOC) &&
> > +           pool_type == EFI_BOOT_SERVICES_DATA) {
> > +               void *ptr;
> > +
> > +               /*
> > +                * Some tests crash on qemu_arm etc. if the correct size is
> > +                * allocated.
> > +                * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > +                * Increasing it to 0x20 seems to fix test_efi_selftest_base
> > +                * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> > +                *
> > +                * This workaround can be dropped once these problems are
> > +                * resolved
> > +                */
> > +               ptr = memalign(8, size + 0x100);
> > +               if (!ptr)
> > +                       return EFI_OUT_OF_RESOURCES;
> > +
> > +               *buffer = ptr;
> > +               r = EFI_SUCCESS;
> > +               log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
> > +       } else {
> > +               u64 num_pages = efi_size_in_pages(size +
> > +                                       sizeof(struct efi_pool_allocation));
> > +
> > +               r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> > +                                      num_pages, &addr);
> > +               if (r == EFI_SUCCESS) {
> > +                       struct efi_pool_allocation *alloc;
> > +
> > +                       alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > +                       alloc->num_pages = num_pages;
> > +                       alloc->checksum = checksum(alloc);
> > +                       *buffer = alloc->data;
> > +                       log_debug("EFI pool: pages alloc(%zx) type %d = %p\n",
> > +                                 size, pool_type, *buffer);
> > +               }
> >         }
> >
> >         return r;
> > @@ -686,27 +729,37 @@ void *efi_alloc(size_t size)
> >  efi_status_t efi_free_pool(void *buffer)
> >  {
> >         efi_status_t ret;
> > -       struct efi_pool_allocation *alloc;
> >
> >         if (!buffer)
> >                 return EFI_INVALID_PARAMETER;
> >
> > -       ret = efi_check_allocated((uintptr_t)buffer, true);
> > -       if (ret != EFI_SUCCESS)
> > -               return ret;
> > +       if (malloc_check_in_range(buffer)) {
> > +               log_debug("EFI pool: free(%p)\n", buffer);
> > +               free(buffer);
> > +               ret = EFI_SUCCESS;
> > +       } else {
> > +               struct efi_pool_allocation *alloc;
> >
> > -       alloc = container_of(buffer, struct efi_pool_allocation, data);
> > +               ret = efi_check_allocated((uintptr_t)buffer, true);
> > +               if (ret != EFI_SUCCESS)
> > +                       return ret;
> >
> > -       /* Check that this memory was allocated by efi_allocate_pool() */
> > -       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > -           alloc->checksum != checksum(alloc)) {
> > -               printf("%s: illegal free 0x%p\n", __func__, buffer);
> > -               return EFI_INVALID_PARAMETER;
> > -       }
> > -       /* Avoid double free */
> > -       alloc->checksum = 0;
> > +               alloc = container_of(buffer, struct efi_pool_allocation, data);
> >
> > -       ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > +               /*
> > +                * Check that this memory was allocated by efi_allocate_pool()
> > +                */
> > +               if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > +                   alloc->checksum != checksum(alloc)) {
> > +                       printf("%s: illegal free 0x%p\n", __func__, buffer);
> > +                       return EFI_INVALID_PARAMETER;
> > +               }
> > +               /* Avoid double free */
> > +               alloc->checksum = 0;
> > +
> > +               ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > +               log_debug("EFI pool: pages free(%p)\n", buffer);
> > +       }
> >
> >         return ret;
> >  }
> > @@ -926,6 +979,9 @@ static void add_u_boot_and_runtime(void)
> >
> >  int efi_memory_init(void)
> >  {
> > +       /* use malloc() pool where possible */
> > +       efi_set_alloc(EFIAF_USE_MALLOC);
> > +
> >         efi_add_known_memory();
> >
> >         add_u_boot_and_runtime();
> > --
> > 2.34.1
> >

Regards,
Simon
