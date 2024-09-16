Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F3C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB83788F07;
	Mon, 16 Sep 2024 17:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="boByOKcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98ACD88F1F; Mon, 16 Sep 2024 17:43:23 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A090E88F07
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a99eee4a5bso415145185a.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501396; x=1727106196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U56C9SoLoG+ZBmQHvwy14aOYAFe0ybfvQve9fsEGkHc=;
 b=boByOKcFAESuafmGwLW+scB8uZ4cW8XZC5DEmHHMJ2ENQkV/5eq1Ha7sWKXlh5BYqS
 khm52f6+UOJXe6OhA4FElaCsL9+lIto8R9eYBAj4O/mP4wOtr68IBYBkYc+P6wC0o8PW
 t9ZH4A0G1fUTlnN4POnkTVTNfBwPFwgCvo4rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501396; x=1727106196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U56C9SoLoG+ZBmQHvwy14aOYAFe0ybfvQve9fsEGkHc=;
 b=XJrR6sBoFhqRFzCk+5I5rbLdiORHNo6pJpNvla49j9Soq2gGBKybJkJntUsRc5Ve61
 mp9iLszji8TbgrA+kMinkyK20dhHUEE68WYSJE/w9StLcLXvUu5X9VewOapJdJQrQ0vk
 lDjWi0TmTt4H/QCuEvcwBwVcerSTx6zX6a3YhZMQPNpPT8rm4uuOHvBeo3e2cAmlsUTa
 jrVjwTYYTrqDBc0v9AQHK2sYrfcwPQ2jlkGSsTYqLY9yh6WUrz5110E/5Y2VKHoRtrbB
 9SfcA9q6rIx630s3s5bFHOXTKAhj0nZ4cDQPnGMZB5B8+Ec8Jrn5dM5imNcQmlN0Ar0l
 Qgng==
X-Gm-Message-State: AOJu0Yw5tTsdD7pwmrWgVVoxvAIqHMk0QgQ9FcKcMvLSyteuyZq2qbg4
 uFjOAZVRNJvc49ra5p70gSNUrkWRCJ4QDvrSoE8pils/bPjLkhFIpOam7Cd6uKnjc3wXUBp9Rkj
 aHCmku0j49U1kaoToFMHG0KhOZfAIJLujyPEO
X-Google-Smtp-Source: AGHT+IH7nHs+tN/8IlD7jQY1MoJkFi0Xn33S8x9cpKzrMYKtsNRFlVDHApOttjkZhDHUb2KVKCZSHMZmavx/xmbsUeU=
X-Received: by 2002:a05:6214:3287:b0:6c5:537a:ce43 with SMTP id
 6a1803df08f44-6c573539d30mr199771456d6.26.1726501396500; Mon, 16 Sep 2024
 08:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CAC_iWjLwbeU2vO5-BdYz8gbpTH4Zq=7W_JeUVVURCnMtPg8DWg@mail.gmail.com>
 <CAFLszTicmXVmi45AVZgmxcT=gnxpUS4-UAyD5=_UC2LWDF2W1Q@mail.gmail.com>
 <CAC_iWjL26e7rLtAkzNSGmqNsG9TJn=PE-4Z4GGz-Qt_8izWopg@mail.gmail.com>
In-Reply-To: <CAC_iWjL26e7rLtAkzNSGmqNsG9TJn=PE-4Z4GGz-Qt_8izWopg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:42:59 +0200
Message-ID: <CAFLszTjWn9dwvfBT6sPMvgWNAF5Q7KLq1_o2b4=zao9fx1mhdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Hi Ilias,

On Thu, 12 Sept 2024 at 08:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 6 Sept 2024 at 16:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 6 Sept 2024 at 01:13, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > Apologies for the late reply, I was attending a conference.
> > >
> > > On Mon, 2 Sept 2024 at 01:23, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This API call is intended for allocating small amounts of memory,
> > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > which can waste large amounts of memory. It also implements its own
> > > > malloc()-style header on each block.
> > > >
> > > > For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> > > > use U-Boot's built-in malloc() instead, at least until the app starts.
> > > > This avoids poluting the memory space with blocks of data which may
> > > > interfere with boot scripts, etc.
>
> This won't happen with LMB merged no?

It still happens with LMB merged. As I covered in the cover letter,
this is orthogonal to all of that. In fact, I think a lot of the
effort there is actually missing the point, unfortunately.

>
> > > >
> > > > Once the app has started, there is no advantage to using malloc(), since
> > > > it doesn't matter what memory is used: everything is under control of
> > > > the EFI subsystem. Also, using malloc() after the app starts might
> > > > result in running of memory, since U-Boot's malloc() space is typically
> > > > quite small.
> > > >
> > > > In fact, malloc() is already used for most EFI-related allocations, so
> > > > the impact of this change is fairly small.
>
> Where? We explained in the past that malloc is only used to handle
> internal EFI stuff which don't need the efi allocations and that's
> perfectly fine.

I see only about 5 allocations affected by this change, when booting from EFI.

>
> > > >
> > > > One side effect is that this seems to be showing up some bugs in the
> > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > This has likely crept in due to the very large gaps between allocations
> > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > too small. Work around this by increasing the size for now, until these
> > > > (presumed) bugs are located.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  common/dlmalloc.c            |   7 +++
> > > >  include/efi_loader.h         |  18 ++++++
> > > >  include/malloc.h             |   7 +++
> > > >  lib/efi_loader/efi_bootbin.c |   2 +
> > > >  lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> > > >  5 files changed, 117 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > > > index 1ac7ce3f43c..48e9f3515f7 100644
> > > > --- a/common/dlmalloc.c
> > > > +++ b/common/dlmalloc.c
> > > > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> > > >  #endif
> > > >  }
> > > >
> > > > +bool malloc_check_in_range(void *ptr)
> > > > +{
> > > > +       ulong val = (ulong)ptr;
> > > > +
> > > > +       return val >= mem_malloc_start && val < mem_malloc_end;
> > > > +}
> > > > +
> > > >  /* field-extraction macros */
> > > >
> > > >  #define first(b) ((b)->fd)
> > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > index 38971d01442..d07bc06bad4 100644
> > > > --- a/include/efi_loader.h
> > > > +++ b/include/efi_loader.h
> > > > @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> > > >  int efi_disk_remove(void *ctx, struct event *event);
> > > >  /* Called by board init to initialize the EFI memory map */
> > > >  int efi_memory_init(void);
> > > > +
> > > > +/**
> > > > + * enum efi_alloc_flags - controls EFI memory allocation
> > > > + *
> > > > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > > > + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > > > + */
> > > > +enum efi_alloc_flags {
> > > > +       EFIAF_USE_MALLOC        = BIT(0),
> > > > +};
> > >
> > > Why do we need to handle cases differently? IOW can't all EFI
> > > allocations that need a pool gi via malloc?
> >
> > Once the app boots, as Heinrich pointed out, it expects to be able to
> > malloc() very large amount of memory, but the malloc() pool is small.
> >
>
> Yes, it does.  My problem is that right now we have everything in the
> same pool, handled by LMB, but you are arguing it's 'cleaner' to split
> the allocations. I can't really understand what the problem with the
> current allocations is.

The problem is that they happen in space, between the bottom of memory
and the bottom of the stack. That is the area which is supposed to not
be used by U-Boot.
>
> > >
> > > [...]
> > >
> > > > @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
> > > >  /* Magic number identifying memory allocated from pool */
> > > >  #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
> > > >
> > > > +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags */
> > > > +static int alloc_flags;
> > > > +
> > > > +void efi_set_alloc(int flags)
> > > > +{
> > > > +       alloc_flags = flags;
> > > > +}
> > > > +
> > > >  efi_uintn_t efi_memory_map_key;
> > > >
> > > >  struct efi_mem_list {
> > > > @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
> > > >   * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > >   * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > >   *
> > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > - * prepend each allocation with these header fields.
> > > > + * EFI requires 8-byte alignment for pool allocations, so we can prepend each
> > > > + * allocation with these header fields.
> > > > + *
> > > > + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA allocations
> > > > + * are served using malloc(), bypassing this struct. This helps to avoid memory
> > > > + * fragmentation, since efi_allocate_pages() uses any pages it likes.
> > > >   */
> > > >  struct efi_pool_allocation {
> > > >         u64 num_pages;
> > > > @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > >  /**
> > > >   * efi_allocate_pool - allocate memory from pool
> > > >   *
> > > > + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_USE_MALLOC
> > > > + * is enabled
> > > > + *
> > > >   * @pool_type: type of the pool from which memory is to be allocated
> > > >   * @size:      number of bytes to be allocated
> > > >   * @buffer:    allocated memory
> > > >   * Return:     status code
> > > >   */
> > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > +                              void **buffer)
> > > >  {
> > > >         efi_status_t r;
> > > >         u64 addr;
> > > > -       struct efi_pool_allocation *alloc;
> > > > -       u64 num_pages = efi_size_in_pages(size +
> > > > -                                         sizeof(struct efi_pool_allocation));
> > > >
> > > >         if (!buffer)
> > > >                 return EFI_INVALID_PARAMETER;
> > > > @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > >                 return EFI_SUCCESS;
> > > >         }
> > > >
> > > > -       r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > > -                              &addr);
> > > > -       if (r == EFI_SUCCESS) {
> > > > -               alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > -               alloc->num_pages = num_pages;
> > > > -               alloc->checksum = checksum(alloc);
> > > > -               *buffer = alloc->data;
> > > > +       if ((alloc_flags & EFIAF_USE_MALLOC) &&
> > > > +           pool_type == EFI_BOOT_SERVICES_DATA) {
> > > > +               void *ptr;
> > > > +
> > > > +               /*
> > > > +                * Some tests crash on qemu_arm etc. if the correct size is
> > > > +                * allocated.
> > > > +                * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > > +                * Increasing it to 0x20 seems to fix test_efi_selftest_base
> > > > +                * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > > +                *
> > > > +                * This workaround can be dropped once these problems are
> > > > +                * resolved
> > > > +                */
> > > > +               ptr = memalign(8, size + 0x100);
> > >
> > > I don't think the explanation is enough here. On top of that adding
> > > random values to fix the problem doesn't sound right. Can we figure
> > > out why?
> >
> > My guess is that an allocated pointer is going beyond its limits. The
> > newer upstream dlmalloc() has a checker which might help. I fiddled
> > around a bit but could not work one where the problem was.
>
> Ok, but I don't want us to pull code with random values that happened
> to work during testing. We need to understand why

It is presumably because of bugs in the EFI code. The current code
adds about 4KB to the size of each allocation, so adding 100 bytes is
at least an improvement. I did do some digging but couldn't
immediately locate any bugs. To be honest I am not sure what is going
on.

But once I have these two EFI series in, I will spend some time
digging into it and help fix these (presumed) bugs.

>
> >
> > >
> > > > +               if (!ptr)
> > > > +                       return EFI_OUT_OF_RESOURCES;
> > > > +
> > > > +               *buffer = ptr;
> > > > +               r = EFI_SUCCESS;
> > > > +               log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
> > >
> > > So as I commented above, I think this is papering over whatever
> > > problem you are seeing. If you want to move the pool to use malloc()
> > > that's fine, but *all* of the pool allocations should use it. Not just
> > > boot services because its easier to retrofit it on the current code.
> >
> > Please see above. Also, please see the commit message. This change
> > actually solves the problems I am seeing, quite well.
>
> I did and the only 'problem' that is mentioned is polluting and
> overwriting memory of scripts etc. But that goes away with LMB AFAICT.
> So the only advantage is that you save a few kbs of space when
> requesting pool allocations?

No, you misunderstand. I am happy to arrange a call to go through this
if it is still unclear from my comment above. When I say this is
orthogonal to the lmb series, I really do mean that.

Regards,
Simon



>
> Thanks
> /Ilias
> >
> > >
> > > > +       } else {
> > > > +               u64 num_pages = efi_size_in_pages(size +
> > > > +                                       sizeof(struct efi_pool_allocation));
> > > > +
> > > > +               r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> > > > +                                      num_pages, &addr);
> > > > +               if (r == EFI_SUCCESS) {
> > > > +                       struct efi_pool_allocation *alloc;
> > > > +
> > > > +                       alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > +                       alloc->num_pages = num_pages;
> > > > +                       alloc->checksum = checksum(alloc);
> > > > +                       *buffer = alloc->data;
> > > > +                       log_debug("EFI pool: pages alloc(%zx) type %d = %p\n",
> > > > +                                 size, pool_type, *buffer);
> > > > +               }
> > > >         }
> > > >
> > > >         return r;
> > > > @@ -686,27 +729,37 @@ void *efi_alloc(size_t size)
> > > >  efi_status_t efi_free_pool(void *buffer)
> > > >  {
> > > >         efi_status_t ret;
> > > > -       struct efi_pool_allocation *alloc;
> > > >
> > > >         if (!buffer)
> > > >                 return EFI_INVALID_PARAMETER;
> > > >
> > > > -       ret = efi_check_allocated((uintptr_t)buffer, true);
> > > > -       if (ret != EFI_SUCCESS)
> > > > -               return ret;
> > > > +       if (malloc_check_in_range(buffer)) {
> > > > +               log_debug("EFI pool: free(%p)\n", buffer);
> > > > +               free(buffer);
> > > > +               ret = EFI_SUCCESS;
> > > > +       } else {
> > > > +               struct efi_pool_allocation *alloc;
> > > >
> > > > -       alloc = container_of(buffer, struct efi_pool_allocation, data);
> > > > +               ret = efi_check_allocated((uintptr_t)buffer, true);
> > > > +               if (ret != EFI_SUCCESS)
> > > > +                       return ret;
> > > >
> > > [...]
> >
> > Regards,
> > Simon
