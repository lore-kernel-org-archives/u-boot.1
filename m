Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98384E6FE49
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0AA388D40;
	Mon,  9 Sep 2024 09:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CquY5YIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA6688D51; Mon,  9 Sep 2024 09:44:25 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DE8886A7
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c0aa376e15so1923370a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725867862; x=1726472662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Os2R/lRx/oWnc5P8w84GRQeL2mEA3KUFoWf8+s8c2s=;
 b=CquY5YIKx0UeLBpExYKMDXqM59EOPqSJARS6EDSv00MvSCwB0DVYEDcjwly3JT0uyX
 yPlC2pDuHKjgZSSFcCxD5/01Vpt2sWPjIsxFAexQD4urJz5aQPKDbxUv30BAU/gL/4N0
 F/nARjxoXw3J0jvTf6qgtiEGacSQBOg8ryy5QarV92EOc4h9OZH818V/UIvn8/5pj/Fy
 wpExUrUgAoO8sAoPubhCRgPBZrF0+OE9BWm19lYWdAS/zvzZ1uiFX0clDC7EDk+01jCn
 tW3gXO1RBgWZwt5IT46QRxSxb3pjmPgo9VssM2293mS055z5cJhsha+fttEl7877a8t+
 mZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725867862; x=1726472662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Os2R/lRx/oWnc5P8w84GRQeL2mEA3KUFoWf8+s8c2s=;
 b=tjrGxhzhVAsyb+G3ZQOhUnweqcgTIUtbxTJ4lsvPZMdOtWPFBntK0Q8ouI4xtIQ3iw
 DR43PvEGy6v1DsAJJR05gwKNx6whEsQLXmgJPm2sxpe8hkzXiFQMghZnG8f0YSl6g0+i
 z08Lo/TPv3Di7VJEvp/UR2huwStHxaSRdgHeFsIHHIJxMyRotIh3Kxn+XTGhOkrIBVVv
 zX/vwYiqQm1ghXVbgUj7CUHzW2zJfvPo3zGO8c6Z8O6mT0K+R4xoVHNDC3lC77O5mRTl
 7g1iRAWr9q5gnfhi/bTtWGf9xtuvlJdIdehzC0RdiPybvylycMuI4eF8nsJ/ArIG7zS/
 mgYg==
X-Gm-Message-State: AOJu0YzM6smic91Q75u8MSt8A+qU51oJVzybJudvKGHNEtsdQr4S/Z9J
 Elqvd9uMggvB8bAloAwOVPaNc7jpp8UlKSp5LmKJPENOtnAmjEcrO9ezGnWYgPstATvOcT4KzYh
 Fk65ReknWGftFhh9fi5LwalLk58DG2airRNlr+w==
X-Google-Smtp-Source: AGHT+IH6wSARlCF0FtNxAP2e61+D5Itv03mRNLu421XMK59niqZxchSclOnlYPgfBcTPO/vAPdpUnZJuluIt4TgXyAg=
X-Received: by 2002:a05:6402:2686:b0:5c2:5620:f72 with SMTP id
 4fb4d7f45d1cf-5c3dc61afbfmr8837223a12.0.1725867862063; Mon, 09 Sep 2024
 00:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
 <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
In-Reply-To: <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Sep 2024 13:14:10 +0530
Message-ID: <CADg8p95a1iAzmwd-n8Y9EarX03cFUyBE5k+kwGm2PDy1W+PHNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
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

On Fri, 6 Sept 2024 at 18:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 6 Sept 2024 at 00:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Mon, 2 Sept 2024 at 03:53, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This API call is intended for allocating small amounts of memory,
> > > similar to malloc(). The current implementation rounds up to whole pages
> > > which can waste large amounts of memory. It also implements its own
> > > malloc()-style header on each block.
> > >
> > > For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> > > use U-Boot's built-in malloc() instead, at least until the app starts.
> > > This avoids poluting the memory space with blocks of data which may
> > > interfere with boot scripts, etc.
> > >
> > > Once the app has started, there is no advantage to using malloc(), since
> > > it doesn't matter what memory is used: everything is under control of
> > > the EFI subsystem. Also, using malloc() after the app starts might
> > > result in running of memory, since U-Boot's malloc() space is typically
> > > quite small.
> > >
> > > In fact, malloc() is already used for most EFI-related allocations, so
> > > the impact of this change is fairly small.
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
> > > (no changes since v1)
> > >
> > >  common/dlmalloc.c            |   7 +++
> > >  include/efi_loader.h         |  18 ++++++
> > >  include/malloc.h             |   7 +++
> > >  lib/efi_loader/efi_bootbin.c |   2 +
> > >  lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> > >  5 files changed, 117 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > > index 1ac7ce3f43c..48e9f3515f7 100644
> > > --- a/common/dlmalloc.c
> > > +++ b/common/dlmalloc.c
> > > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> > >  #endif
> > >  }
> > >
> > > +bool malloc_check_in_range(void *ptr)
> > > +{
> > > +       ulong val = (ulong)ptr;
> > > +
> > > +       return val >= mem_malloc_start && val < mem_malloc_end;
> > > +}
> > > +
> > >  /* field-extraction macros */
> > >
> > >  #define first(b) ((b)->fd)
> > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > index 38971d01442..d07bc06bad4 100644
> > > --- a/include/efi_loader.h
> > > +++ b/include/efi_loader.h
> > > @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> > >  int efi_disk_remove(void *ctx, struct event *event);
> > >  /* Called by board init to initialize the EFI memory map */
> > >  int efi_memory_init(void);
> > > +
> > > +/**
> > > + * enum efi_alloc_flags - controls EFI memory allocation
> > > + *
> > > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > > + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > > + */
> > > +enum efi_alloc_flags {
> > > +       EFIAF_USE_MALLOC        = BIT(0),
> > > +};
> > > +
> > > +/**
> > > + * efi_set_alloc() - Set behaviour of EFI memory allocation
> > > + *
> > > + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> > > + */
> > > +void efi_set_alloc(int flags);
> > > +
> > >  /* Adds new or overrides configuration table entry to the system table */
> > >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> > >  /* Sets up a loaded image */
> > > diff --git a/include/malloc.h b/include/malloc.h
> > > index 07d3e90a855..a64f117e2f2 100644
> > > --- a/include/malloc.h
> > > +++ b/include/malloc.h
> > > @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
> > >
> > >  void mem_malloc_init(ulong start, ulong size);
> > >
> > > +/**
> > > + * malloc_check_in_range() - Check if a pointer is within the malloc() region
> > > + *
> > > + * Return: true if within malloc() region
> > > + */
> > > +bool malloc_check_in_range(void *ptr);
> > > +
> > >  #ifdef __cplusplus
> > >  };  /* end of extern "C" */
> > >  #endif
> > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > index a87006b3c0e..5bb0fdcf75d 100644
> > > --- a/lib/efi_loader/efi_bootbin.c
> > > +++ b/lib/efi_loader/efi_bootbin.c
> > > @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > >  {
> > >         efi_status_t ret;
> > >
> > > +       efi_set_alloc(0);
> > > +
> >
> > Here we are setting the flags to use the efi_allocate_pages() route to
> > allocate memory, when booting into an EFI app. Do we need to set it
> > back to EFIAF_USE_MALLOC if the app exits and control lands back in
> > U-Boot? I am not sure that is being handled.
>
> I don't believe so. Once we have booted into the app, U-Boot loses
> control of its memory layout, in the sense that the
> efi_allocate_pages() has likely been called and placed things all over
> the place in the memory. People should expect this.

I am referring to a scenario where the app exits and control returns
back to U-Boot, which I believe is a valid scenario. In such a case,
should control not switch back to the malloc based allocations.
Otherwise we do not have consistent behaviour with the allocations --
any subsequent calls to efi_allocate_pool on return from an EFI app
would continue using the other (efi_allocate_pages() based) path.

This is of course with the assumption that the EFI maintainers are
fine with using this hybrid approach on the allocations.

-sughosh

>
> We can potentially deal with this if we find a specific problem, but I
> can't think of one at the moment.
>
> >
> > -sughosh
> >
> > >         /* Initialize EFI drivers */
> > >         ret = efi_init_obj_list();
> > >         if (ret != EFI_SUCCESS) {
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 50cb2f3898b..206d10f207a 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
> > >  /* Magic number identifying memory allocated from pool */
> > >  #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
> > >
> > > +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags */
> > > +static int alloc_flags;
> > > +
> > > +void efi_set_alloc(int flags)
> > > +{
> > > +       alloc_flags = flags;
> > > +}
> > > +
> > >  efi_uintn_t efi_memory_map_key;
> > >
> > >  struct efi_mem_list {
> > > @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
> > >   * The checksum calculated in function checksum() is used in FreePool() to avoid
> > >   * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > >   *
> > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > - * prepend each allocation with these header fields.
> > > + * EFI requires 8-byte alignment for pool allocations, so we can prepend each
> > > + * allocation with these header fields.
> > > + *
> > > + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA allocations
> > > + * are served using malloc(), bypassing this struct. This helps to avoid memory
> > > + * fragmentation, since efi_allocate_pages() uses any pages it likes.
> > >   */
> > >  struct efi_pool_allocation {
> > >         u64 num_pages;
> > > @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > >  /**
> > >   * efi_allocate_pool - allocate memory from pool
> > >   *
> > > + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_USE_MALLOC
> > > + * is enabled
> > > + *
> > >   * @pool_type: type of the pool from which memory is to be allocated
> > >   * @size:      number of bytes to be allocated
> > >   * @buffer:    allocated memory
> > >   * Return:     status code
> > >   */
> > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > +                              void **buffer)
> > >  {
> > >         efi_status_t r;
> > >         u64 addr;
> > > -       struct efi_pool_allocation *alloc;
> > > -       u64 num_pages = efi_size_in_pages(size +
> > > -                                         sizeof(struct efi_pool_allocation));
> > >
> > >         if (!buffer)
> > >                 return EFI_INVALID_PARAMETER;
> > > @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > >                 return EFI_SUCCESS;
> > >         }
> > >
> > > -       r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > -                              &addr);
> > > -       if (r == EFI_SUCCESS) {
> > > -               alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > -               alloc->num_pages = num_pages;
> > > -               alloc->checksum = checksum(alloc);
> > > -               *buffer = alloc->data;
> > > +       if ((alloc_flags & EFIAF_USE_MALLOC) &&
> > > +           pool_type == EFI_BOOT_SERVICES_DATA) {
> > > +               void *ptr;
> > > +
> > > +               /*
> > > +                * Some tests crash on qemu_arm etc. if the correct size is
> > > +                * allocated.
> > > +                * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > +                * Increasing it to 0x20 seems to fix test_efi_selftest_base
> > > +                * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > +                *
> > > +                * This workaround can be dropped once these problems are
> > > +                * resolved
> > > +                */
> > > +               ptr = memalign(8, size + 0x100);
> > > +               if (!ptr)
> > > +                       return EFI_OUT_OF_RESOURCES;
> > > +
> > > +               *buffer = ptr;
> > > +               r = EFI_SUCCESS;
> > > +               log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
> > > +       } else {
> > > +               u64 num_pages = efi_size_in_pages(size +
> > > +                                       sizeof(struct efi_pool_allocation));
> > > +
> > > +               r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> > > +                                      num_pages, &addr);
> > > +               if (r == EFI_SUCCESS) {
> > > +                       struct efi_pool_allocation *alloc;
> > > +
> > > +                       alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > +                       alloc->num_pages = num_pages;
> > > +                       alloc->checksum = checksum(alloc);
> > > +                       *buffer = alloc->data;
> > > +                       log_debug("EFI pool: pages alloc(%zx) type %d = %p\n",
> > > +                                 size, pool_type, *buffer);
> > > +               }
> > >         }
> > >
> > >         return r;
> > > @@ -686,27 +729,37 @@ void *efi_alloc(size_t size)
> > >  efi_status_t efi_free_pool(void *buffer)
> > >  {
> > >         efi_status_t ret;
> > > -       struct efi_pool_allocation *alloc;
> > >
> > >         if (!buffer)
> > >                 return EFI_INVALID_PARAMETER;
> > >
> > > -       ret = efi_check_allocated((uintptr_t)buffer, true);
> > > -       if (ret != EFI_SUCCESS)
> > > -               return ret;
> > > +       if (malloc_check_in_range(buffer)) {
> > > +               log_debug("EFI pool: free(%p)\n", buffer);
> > > +               free(buffer);
> > > +               ret = EFI_SUCCESS;
> > > +       } else {
> > > +               struct efi_pool_allocation *alloc;
> > >
> > > -       alloc = container_of(buffer, struct efi_pool_allocation, data);
> > > +               ret = efi_check_allocated((uintptr_t)buffer, true);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       return ret;
> > >
> > > -       /* Check that this memory was allocated by efi_allocate_pool() */
> > > -       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > > -           alloc->checksum != checksum(alloc)) {
> > > -               printf("%s: illegal free 0x%p\n", __func__, buffer);
> > > -               return EFI_INVALID_PARAMETER;
> > > -       }
> > > -       /* Avoid double free */
> > > -       alloc->checksum = 0;
> > > +               alloc = container_of(buffer, struct efi_pool_allocation, data);
> > >
> > > -       ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > > +               /*
> > > +                * Check that this memory was allocated by efi_allocate_pool()
> > > +                */
> > > +               if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
> > > +                   alloc->checksum != checksum(alloc)) {
> > > +                       printf("%s: illegal free 0x%p\n", __func__, buffer);
> > > +                       return EFI_INVALID_PARAMETER;
> > > +               }
> > > +               /* Avoid double free */
> > > +               alloc->checksum = 0;
> > > +
> > > +               ret = efi_free_pages((uintptr_t)alloc, alloc->num_pages);
> > > +               log_debug("EFI pool: pages free(%p)\n", buffer);
> > > +       }
> > >
> > >         return ret;
> > >  }
> > > @@ -926,6 +979,9 @@ static void add_u_boot_and_runtime(void)
> > >
> > >  int efi_memory_init(void)
> > >  {
> > > +       /* use malloc() pool where possible */
> > > +       efi_set_alloc(EFIAF_USE_MALLOC);
> > > +
> > >         efi_add_known_memory();
> > >
> > >         add_u_boot_and_runtime();
> > > --
> > > 2.34.1
> > >
>
> Regards,
> Simon
