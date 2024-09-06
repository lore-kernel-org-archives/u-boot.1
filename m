Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA1BCE7B06
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 13:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2293688936;
	Fri,  6 Sep 2024 15:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTI//9l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9916388CD9; Fri,  6 Sep 2024 15:01:40 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBE388CD1
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 15:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf6606363fso11082586d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725627697; x=1726232497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ooLFtMYB2HqubLAdo8iutwnt5drrWzbKXW2CIBY7lqY=;
 b=jTI//9l+Im8aj8xBk1YFNBr1Lg1mVCri3mS7vEPS8Ln/ZQgabCQgqi4d/1B1IfwNhN
 GNdhU7nHTr0+74UX0HCwZwHVyj5Ly6O/3R8one498N5eFk+2OenbdbjXbL+G8V+Ff/1J
 GlDLbadjNGqLS6+7EpN1bsGtqBlTZgGA+nyXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725627697; x=1726232497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ooLFtMYB2HqubLAdo8iutwnt5drrWzbKXW2CIBY7lqY=;
 b=KwAepksBVKmy1lrLrZNVsEAf/fy6WWq9pC5xY3AnYnAAK8CS/c47XQFbYwY/rsUDwZ
 9kYaL1JKpSr1NROewfY2AQdy/KW2zpXDRTLl62yHtyKOZSkPO8GRiMJV5gli9U73ZyV7
 1JcJjPIPaAO4/ZAC+GRGBS1UWct196HO0rJdyV4/Sfj+0XYcJWF7JSPD9j9kgwggPtkq
 Cq6hCnoJp9M+E1eythpasbRfiiE0kId5qi+6jdixPOdqtGePkfPMfT5FQbT5Lnt+4/vw
 TtsbJupSKhwoYUKLxArtYX+KnfwPaNd+y0zYE3yOTESorZHA7qGvu/jjS65LB/Px5U6X
 HA0Q==
X-Gm-Message-State: AOJu0Yw9gY6zitjTipzkQtznNPzvmqRtNtCs4F1MI4LytzZkZpjAEfRV
 L05DJ8r00KA15UPXJvKboqCkwn4kq1zoa5XDRP2Iki4CObHMrvsOaYcCLDEsDvt3WADeCntV/Is
 Vfu1KKwnlgD7BCqDndEnKhigVdZA+7m3MoYok
X-Google-Smtp-Source: AGHT+IGEMY9ipG2PGs0uCy52KJUTuElrLLW6nF5NB7SUhsoeQBlPsCn615238A3q2vGiHYdiHt5MV6EN7KjSVLNtpCA=
X-Received: by 2002:a05:6214:aaf:b0:6c5:194a:4d7b with SMTP id
 6a1803df08f44-6c52851138emr30474686d6.33.1725627695596; Fri, 06 Sep 2024
 06:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CAC_iWjLwbeU2vO5-BdYz8gbpTH4Zq=7W_JeUVVURCnMtPg8DWg@mail.gmail.com>
In-Reply-To: <CAC_iWjLwbeU2vO5-BdYz8gbpTH4Zq=7W_JeUVVURCnMtPg8DWg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 07:01:25 -0600
Message-ID: <CAFLszTicmXVmi45AVZgmxcT=gnxpUS4-UAyD5=_UC2LWDF2W1Q@mail.gmail.com>
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

On Fri, 6 Sept 2024 at 01:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> Apologies for the late reply, I was attending a conference.
>
> On Mon, 2 Sept 2024 at 01:23, Simon Glass <sjg@chromium.org> wrote:
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
>
> Why do we need to handle cases differently? IOW can't all EFI
> allocations that need a pool gi via malloc?

Once the app boots, as Heinrich pointed out, it expects to be able to
malloc() very large amount of memory, but the malloc() pool is small.

>
> [...]
>
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
>
> I don't think the explanation is enough here. On top of that adding
> random values to fix the problem doesn't sound right. Can we figure
> out why?

My guess is that an allocated pointer is going beyond its limits. The
newer upstream dlmalloc() has a checker which might help. I fiddled
around a bit but could not work one where the problem was.

>
> > +               if (!ptr)
> > +                       return EFI_OUT_OF_RESOURCES;
> > +
> > +               *buffer = ptr;
> > +               r = EFI_SUCCESS;
> > +               log_debug("EFI pool: malloc(%zx) = %p\n", size, ptr);
>
> So as I commented above, I think this is papering over whatever
> problem you are seeing. If you want to move the pool to use malloc()
> that's fine, but *all* of the pool allocations should use it. Not just
> boot services because its easier to retrofit it on the current code.

Please see above. Also, please see the commit message. This change
actually solves the problems I am seeing, quite well.

>
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
> [...]

Regards,
Simon
