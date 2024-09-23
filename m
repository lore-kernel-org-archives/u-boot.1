Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9354CF9C5B
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 10:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5586D88D35;
	Mon, 23 Sep 2024 12:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YOSWWm/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4B988D27; Mon, 23 Sep 2024 12:03:34 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7590A88BB7
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 12:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d87a1f0791so2773831a91.2
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727085810; x=1727690610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6e7/6wQQJlbWXGFAdycPRWgFRJ467FyBx6SN2vnJpM=;
 b=YOSWWm/MGngIXuzUSIs035jtcPjMMKz65sIZUSJQy5CM2NHOF85VzVvIDzjLs+fPwD
 2B8CZYMk8WeNIRB6/3+utp6sk/VcIdLmCQ6PM+/uI4UsgENXx0lJ3SqIVeT2i8VCNamb
 aDUYqF+M4EQhJgASlrik3Q8TPAf5BA2cEKAhavyASvZP7bAz1VUHOz8Lwo02D1ZQmN+1
 XHhT7aZjWiHlUcVX/iugoS3LMTIQdtXgTvicPAUsppFb3/6PGvhKnp6SLrOWpu+tDvDz
 x3i3WL7RIvPko6lZ81xpOUUVgV7XoRBY+GwyNrJZrkdtZ/9VZbv6IOUceyvUVDY0J2yk
 RpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727085810; x=1727690610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6e7/6wQQJlbWXGFAdycPRWgFRJ467FyBx6SN2vnJpM=;
 b=B0V0O7x8EIqqQ8mRrk39BKfGmiQBrF2OAhoXkL1q6yksQEAanyozAchvoRdZ7kLbxl
 aXS6wa+M7aYtSBrhRxduGrXSmxFcZpaSfebCZUm5lK2nZW3Qm0vixjlWWO7UaErZVh3H
 xOgeh4od4WQ+J335AjCmu1WJ4cNbPHfXxKeAhCiEQFUG7GGCmkuimmk/0YInTS+7nJ06
 KWT8Fc1G39C73ZcMVCOTi8IkXa+80UPvIGvB+wld/2v2REAdzQIfJTpGlMyvcQx2Emho
 +06QwdVsfSzsVeTimxAWZWs1AsdhhH4+DykeqYE/e/GTOAXCsgVscvx4y7FVYw4uN584
 KE+Q==
X-Gm-Message-State: AOJu0Yzl6z1uhUpvj07ptQtpeA6R51ZSu3tVzDdDqoBHQJWWW9Md8GZ8
 2SQ5tmt9HbcaHEmMIR7uwFm7eoWFfDtjcVot9HSLfoUszElZDtvy7SGHqpjizZ0khwF+0qIgXaB
 PleLbiyVWwD0nWGZIb2YGcB5kIoY5jlaInwD9aA==
X-Google-Smtp-Source: AGHT+IFcr0+x/UJKBeYHAtPIbZ3HEK5/7p0HbaRE/vQLF5uUrPBShfvi5meNWRcN1brQbwTaPzXXF2xzg41ljzk1Xro=
X-Received: by 2002:a17:90b:4d0a:b0:2c6:ee50:5af4 with SMTP id
 98e67ed59e1d1-2dd7f36e7d8mr12584787a91.6.1727085809742; Mon, 23 Sep 2024
 03:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CAC_iWjLwbeU2vO5-BdYz8gbpTH4Zq=7W_JeUVVURCnMtPg8DWg@mail.gmail.com>
 <CAFLszTicmXVmi45AVZgmxcT=gnxpUS4-UAyD5=_UC2LWDF2W1Q@mail.gmail.com>
 <CAC_iWjL26e7rLtAkzNSGmqNsG9TJn=PE-4Z4GGz-Qt_8izWopg@mail.gmail.com>
 <CAFLszTjWn9dwvfBT6sPMvgWNAF5Q7KLq1_o2b4=zao9fx1mhdw@mail.gmail.com>
 <Zu1mSkoCuB8PKhBi@hera>
 <CAFLszTiXz+P9K69HNcaxqqqCp3sPF-CRh-5ctuSxVGAS0K7f1w@mail.gmail.com>
In-Reply-To: <CAFLszTiXz+P9K69HNcaxqqqCp3sPF-CRh-5ctuSxVGAS0K7f1w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Sep 2024 13:02:53 +0300
Message-ID: <CAC_iWjLwfyZG+P-A4Z826zOOxrNCmSL_2eFD9dqSMwg5XvK-Aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Simon Glass <sjg@chromium.org>
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

On Fri, 20 Sept 2024 at 19:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 20 Sept 2024 at 14:10, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > A few more comments after looking into this a bit more
> >
> > On Mon, Sep 16, 2024 at 05:42:59PM +0200, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Thu, 12 Sept 2024 at 08:37, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 6 Sept 2024 at 16:01, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Fri, 6 Sept 2024 at 01:13, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > Apologies for the late reply, I was attending a conference.
> > > > > >
> > > > > > On Mon, 2 Sept 2024 at 01:23, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > This API call is intended for allocating small amounts of memory,
> >
> > Well it's not only for small memory. Look below.
>
> Yes, you are right, I was imprecise. In U-Boot, it it used for
> allocations or small amounts of memory. Until the app runs, we have
> control over this, so can be sure the allocations will be small. After
> that, allocations could be very large.
>
> >
> > > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > > malloc()-style header on each block.
> >
> > Yes and there is a reason for that. The EFI spec description is
> >
> > "The AllocatePool() function allocates a memory region of Size bytes
> >  from memory of type PoolType and returns the address of the allocated
> >  memory in the location referenced by Buffer. This function allocates
> >  *pages* from EfiConventionalMemory as needed to grow the requested pool
> >  type. All allocations are eight-byte aligned. The allocated pool memory
> >  is returned to the available pool with the EFI_BOOT_SERVICES.FreePool()
> >  function"
> >
> > The current implementation of efi_allocate_pool kind of does that, but is
> > indeed very inefficient, since it allocates a single page and pool every time.
> > A proper implementation would be to allocate a page and return the size
> > needed. Then for every subsequent request to the same pooltype, you look up
> > the existing pool, and return the requested memory. If the pool is depleted
> > you allocate another *page* and so on and so forth. That's where the
> > metadata is actually useful.
> >
> > So the suggested solution here is trying to fix an existing hack, by
> > papering over the problem with *another* hack that will basically make the
> > process of fixing efi_allocate_pool() properly impossible.
>
> It actually makes it easier, doesn't it? We can decrease the 'margin'
> I have set in the patch until we see the first failure, then fix the
> bug thus exposed, decrease it again, etc. Eventually when all the bugs
> are fixed, the margin will be zero.

Not really. The AllocatePool says "it must allocate pages" for a
reason, which we did discuss in earlier versions of the patch.  How do
you plan to deal with memory attributes and permissions when
allocating memory, which you can only control per page?

EFI is a spec. You either adhere to it or not. You can't change random
parts because it interferes with U-Boot image loading assumptions that
were in place *before* merging EFI.
This is a memory dump on QEMU aarch64. and

CONVENTIONAL     0000000040000000-000000023d52e000 WB
BOOT DATA        000000023d52e000-000000023d533000 WB
RUNTIME DATA     000000023d533000-000000023d534000 WB|RT
BOOT DATA        000000023d534000-000000023d535000 WB
ACPI NVS         000000023d535000-000000023d546000 WB
BOOT DATA        000000023d546000-000000023d558000 WB
RUNTIME DATA     000000023d558000-000000023d57a000 WB|RT
BOOT DATA        000000023d57a000-000000023d585000 WB
BOOT CODE        000000023d585000-000000023e6a3000 WB
RUNTIME DATA     000000023e6a3000-000000023e6a4000 WB|RT
BOOT CODE        000000023e6a4000-000000023f6c0000 WB
RUNTIME CODE     000000023f6c0000-000000023f6d0000 WB|RT
BOOT CODE        000000023f6d0000-0000000240000000 WB

As you can see the memory from the bottom is empty and free to load
images. efi_find_free_memory() is always trying to allocate the
highest available memory and stay out of the way.

>
> >
> > > > > > >
> > > > > > > For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> > > > > > > use U-Boot's built-in malloc() instead, at least until the app starts.
> > > > > > > This avoids poluting the memory space with blocks of data which may
> > > > > > > interfere with boot scripts, etc.
> > > >
> > > > This won't happen with LMB merged no?
> > >
> > > It still happens with LMB merged. As I covered in the cover letter,
> > > this is orthogonal to all of that. In fact, I think a lot of the
> > > effort there is actually missing the point, unfortunately.
> >
> > So why isn't this an LMB problem since we plan to use it for EFI
> > allocations? LMB is trying to fix similar issues for efi_allocate_pages().
> > Once that's done efi_allocate_pool() which calls efi_allocate_pages() is
> > automatically sorted. So the only problem is efficiency, no ?
>
> We are still not on the same page with this. If you happen to be at
> Plumbers, let's have a chat. Otherwise we can try to have a call to go
> over it.
>
> >
> > >
> > > >
> > > > > > >
> > > > > > > Once the app has started, there is no advantage to using malloc(), since
> > > > > > > it doesn't matter what memory is used: everything is under control of
> > > > > > > the EFI subsystem. Also, using malloc() after the app starts might
> > > > > > > result in running of memory, since U-Boot's malloc() space is typically
> > > > > > > quite small.
> > > > > > >
> > > > > > > In fact, malloc() is already used for most EFI-related allocations, so
> > > > > > > the impact of this change is fairly small.
> > > >
> > > > Where? We explained in the past that malloc is only used to handle
> > > > internal EFI stuff which don't need the efi allocations and that's
> > > > perfectly fine.
> > >
> > > I see only about 5 allocations affected by this change, when booting from EFI.
> >
> > What we can do, is go over the usage of efi_allocate_pool(). A quick grep
> > showed a few uses, but I am pretty certain those can be replaced by
> > efi_allocate_pages().
>
> Oh dear, please no. Until the EFI app runs, we should not use that
> function. It uses memory which should not be used for simple
> allocations, but instead kept free for images.

So this is one more point..., efi_allocate_pages is used more than EFI
allocate pool. So I really don't see any point in merging this.
AFAICT it makes it impossible to fix memory permissions, it only deals
with a very small fraction of the problem, it fragments the EFI memory
management since random parts go via malloc now etc etc.


Thanks

/Ilias


>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> >
> > >
> > > >
> > > > > > >
> > > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > > (presumed) bugs are located.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  common/dlmalloc.c            |   7 +++
> > > > > > >  include/efi_loader.h         |  18 ++++++
> > > > > > >  include/malloc.h             |   7 +++
> > > > > > >  lib/efi_loader/efi_bootbin.c |   2 +
> > > > > > >  lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> > > > > > >  5 files changed, 117 insertions(+), 27 deletions(-)
> > > > > > >
> > > > > > > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > > > > > > index 1ac7ce3f43c..48e9f3515f7 100644
> > > > > > > --- a/common/dlmalloc.c
> > > > > > > +++ b/common/dlmalloc.c
> > > > > > > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> > > > > > >  #endif
> > > > > > >  }
> > > > > > >
> > > > > > > +bool malloc_check_in_range(void *ptr)
> > > > > > > +{
> > > > > > > +       ulong val = (ulong)ptr;
> > > > > > > +
> > > > > > > +       return val >= mem_malloc_start && val < mem_malloc_end;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /* field-extraction macros */
> > > > > > >
> > > > > > >  #define first(b) ((b)->fd)
> > > > > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > > > > index 38971d01442..d07bc06bad4 100644
> > > > > > > --- a/include/efi_loader.h
> > > > > > > +++ b/include/efi_loader.h
> > > > > > > @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> > > > > > >  int efi_disk_remove(void *ctx, struct event *event);
> > > > > > >  /* Called by board init to initialize the EFI memory map */
> > > > > > >  int efi_memory_init(void);
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum efi_alloc_flags - controls EFI memory allocation
> > > > > > > + *
> > > > > > > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > > > > > > + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > > > > > > + */
> > > > > > > +enum efi_alloc_flags {
> > > > > > > +       EFIAF_USE_MALLOC        = BIT(0),
> > > > > > > +};
> > > > > >
> > > > > > Why do we need to handle cases differently? IOW can't all EFI
> > > > > > allocations that need a pool gi via malloc?
> > > > >
> > > > > Once the app boots, as Heinrich pointed out, it expects to be able to
> > > > > malloc() very large amount of memory, but the malloc() pool is small.
> > > > >
> > > >
> > > > Yes, it does.  My problem is that right now we have everything in the
> > > > same pool, handled by LMB, but you are arguing it's 'cleaner' to split
> > > > the allocations. I can't really understand what the problem with the
> > > > current allocations is.
> > >
> > > The problem is that they happen in space, between the bottom of memory
> > > and the bottom of the stack. That is the area which is supposed to not
> > > be used by U-Boot.
> > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > @@ -24,6 +24,14 @@ DECLARE_GLOBAL_DATA_PTR;
> > > > > > >  /* Magic number identifying memory allocated from pool */
> > > > > > >  #define EFI_ALLOC_POOL_MAGIC 0x1fe67ddf6491caa2
> > > > > > >
> > > > > > > +/* Flags controlling EFI memory-allocation - see enum efi_alloc_flags */
> > > > > > > +static int alloc_flags;
> > > > > > > +
> > > > > > > +void efi_set_alloc(int flags)
> > > > > > > +{
> > > > > > > +       alloc_flags = flags;
> > > > > > > +}
> > > > > > > +
> > > > > > >  efi_uintn_t efi_memory_map_key;
> > > > > > >
> > > > > > >  struct efi_mem_list {
> > > > > > > @@ -57,8 +65,12 @@ void *efi_bounce_buffer;
> > > > > > >   * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > > > > >   * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > > > > >   *
> > > > > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > > > > - * prepend each allocation with these header fields.
> > > > > > > + * EFI requires 8-byte alignment for pool allocations, so we can prepend each
> > > > > > > + * allocation with these header fields.
> > > > > > > + *
> > > > > > > + * Note that before the EFI app is booted, EFI_BOOT_SERVICES_DATA allocations
> > > > > > > + * are served using malloc(), bypassing this struct. This helps to avoid memory
> > > > > > > + * fragmentation, since efi_allocate_pages() uses any pages it likes.
> > > > > > >   */
> > > > > > >  struct efi_pool_allocation {
> > > > > > >         u64 num_pages;
> > > > > > > @@ -631,18 +643,19 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > > > > >  /**
> > > > > > >   * efi_allocate_pool - allocate memory from pool
> > > > > > >   *
> > > > > > > + * This uses malloc() for EFI_BOOT_SERVICES_DATA allocations if EFIAF_USE_MALLOC
> > > > > > > + * is enabled
> > > > > > > + *
> > > > > > >   * @pool_type: type of the pool from which memory is to be allocated
> > > > > > >   * @size:      number of bytes to be allocated
> > > > > > >   * @buffer:    allocated memory
> > > > > > >   * Return:     status code
> > > > > > >   */
> > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > +                              void **buffer)
> > > > > > >  {
> > > > > > >         efi_status_t r;
> > > > > > >         u64 addr;
> > > > > > > -       struct efi_pool_allocation *alloc;
> > > > > > > -       u64 num_pages = efi_size_in_pages(size +
> > > > > > > -                                         sizeof(struct efi_pool_allocation));
> > > > > > >
> > > > > > >         if (!buffer)
> > > > > > >                 return EFI_INVALID_PARAMETER;
> > > > > > > @@ -652,13 +665,43 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > >                 return EFI_SUCCESS;
> > > > > > >         }
> > > > > > >
> > > > > > > -       r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type, num_pages,
> > > > > > > -                              &addr);
> > > > > > > -       if (r == EFI_SUCCESS) {
> > > > > > > -               alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > > > > -               alloc->num_pages = num_pages;
> > > > > > > -               alloc->checksum = checksum(alloc);
> > > > > > > -               *buffer = alloc->data;
> > > > > > > +       if ((alloc_flags & EFIAF_USE_MALLOC) &&
> > > > > > > +           pool_type == EFI_BOOT_SERVICES_DATA) {
> > > > > > > +               void *ptr;
> > > > > > > +
> > > > > > > +               /*
> > > > > > > +                * Some tests crash on qemu_arm etc. if the correct size is
> > > > > > > +                * allocated.
> > > > > > > +                * Adding 0x10 seems to fix test_efi_selftest_device_tree
> > > > > > > +                * Increasing it to 0x20 seems to fix test_efi_selftest_base
> > > > > > > +                * except * for riscv64 (in CI only). But 0x100 fixes CI too.
> > > > > > > +                *
> > > > > > > +                * This workaround can be dropped once these problems are
> > > > > > > +                * resolved
> > > > > > > +                */
> > > > > > > +               ptr = memalign(8, size + 0x100);
> > > > > >
> > > > > > I don't think the explanation is enough here. On top of that adding
> > > > > > random values to fix the problem doesn't sound right. Can we figure
> > > > > > out why?
> > > > >
> > > > > My guess is that an allocated pointer is going beyond its limits. The
> > > > > newer upstream dlmalloc() has a checker which might help. I fiddled
> > > > > around a bit but could not work one where the problem was.
> > > >
> > > > Ok, but I don't want us to pull code with random values that happened
> > > > to work during testing. We need to understand why
> > >
> > > It is presumably because of bugs in the EFI code. The current code
> > > adds about 4KB to the size of each allocation, so adding 100 bytes is
> > > at least an improvement. I did do some digging but couldn't
> > > immediately locate any bugs. To be honest I am not sure what is going
> > > on.
> > >
> > > But once I have these two EFI series in, I will spend some time
> > > digging into it and help fix these (presumed) bugs.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > +               if (!ptr)
> > > > > > > +                       return EFI_OUT_OF_RESOURCES;
> > > > > > > +
> > > > > > > +               *buffer = ptr;
> > > > > > > +               r = EFI_SUCCESS;
> > > > > > > +               log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
> > > > > >
> > > > > > So as I commented above, I think this is papering over whatever
> > > > > > problem you are seeing. If you want to move the pool to use malloc()
> > > > > > that's fine, but *all* of the pool allocations should use it. Not just
> > > > > > boot services because its easier to retrofit it on the current code.
> > > > >
> > > > > Please see above. Also, please see the commit message. This change
> > > > > actually solves the problems I am seeing, quite well.
> > > >
> > > > I did and the only 'problem' that is mentioned is polluting and
> > > > overwriting memory of scripts etc. But that goes away with LMB AFAICT.
> > > > So the only advantage is that you save a few kbs of space when
> > > > requesting pool allocations?
> > >
> > > No, you misunderstand. I am happy to arrange a call to go through this
> > > if it is still unclear from my comment above. When I say this is
> > > orthogonal to the lmb series, I really do mean that.
> > >
> > > Regards,
> > > Simon
> > >
> > >
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > >
> > > > > > > +       } else {
> > > > > > > +               u64 num_pages = efi_size_in_pages(size +
> > > > > > > +                                       sizeof(struct efi_pool_allocation));
> > > > > > > +
> > > > > > > +               r = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES, pool_type,
> > > > > > > +                                      num_pages, &addr);
> > > > > > > +               if (r == EFI_SUCCESS) {
> > > > > > > +                       struct efi_pool_allocation *alloc;
> > > > > > > +
> > > > > > > +                       alloc = (struct efi_pool_allocation *)(uintptr_t)addr;
> > > > > > > +                       alloc->num_pages = num_pages;
> > > > > > > +                       alloc->checksum = checksum(alloc);
> > > > > > > +                       *buffer = alloc->data;
> > > > > > > +                       log_debug("EFI pool: pages alloc(%zx) type %d = %p\n",
> > > > > > > +                                 size, pool_type, *buffer);
> > > > > > > +               }
> > > > > > >         }
> > > > > > >
> > > > > > >         return r;
> > > > > > > @@ -686,27 +729,37 @@ void *efi_alloc(size_t size)
> > > > > > >  efi_status_t efi_free_pool(void *buffer)
> > > > > > >  {
> > > > > > >         efi_status_t ret;
> > > > > > > -       struct efi_pool_allocation *alloc;
> > > > > > >
> > > > > > >         if (!buffer)
> > > > > > >                 return EFI_INVALID_PARAMETER;
> > > > > > >
> > > > > > > -       ret = efi_check_allocated((uintptr_t)buffer, true);
> > > > > > > -       if (ret != EFI_SUCCESS)
> > > > > > > -               return ret;
> > > > > > > +       if (malloc_check_in_range(buffer)) {
> > > > > > > +               log_debug("EFI pool: free(%p)\n", buffer);
> > > > > > > +               free(buffer);
> > > > > > > +               ret = EFI_SUCCESS;
> > > > > > > +       } else {
> > > > > > > +               struct efi_pool_allocation *alloc;
> > > > > > >
> > > > > > > -       alloc = container_of(buffer, struct efi_pool_allocation, data);
> > > > > > > +               ret = efi_check_allocated((uintptr_t)buffer, true);
> > > > > > > +               if (ret != EFI_SUCCESS)
> > > > > > > +                       return ret;
> > > > > > >
> > > > > > [...]
> > > > >
> > > > > Regards,
> > > > > Simon
> >
> > Thanks
> > /Ilias
