Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8686AEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 681E788DEE;
	Thu, 12 Sep 2024 03:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LGSf75YR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F93788DC6; Thu, 12 Sep 2024 03:00:32 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6925088DF1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso300619a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102826; x=1726707626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w4lxPKt3CwS7J3LKWrWlZLPSAhY25Qfc9h7WTStht/M=;
 b=LGSf75YR+TzgI5weotTXK7k0E1ENVbzGq9TwH/5gMwB76XvyhdmsevFDYApb5wvEYm
 EDpD+HKXKsXpJRfKSJDZHPbKZ3xzt+gF6bm62e76LFFvdeysOnbuw1E6Tb31UmciCs2b
 a1njmtF0UqBPjrZlfw+QLPXnTbzGCb2A5IZHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102826; x=1726707626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w4lxPKt3CwS7J3LKWrWlZLPSAhY25Qfc9h7WTStht/M=;
 b=WJ0zJ12t2ukOUBpOw1pEemOBOKB25lq/+iDu8Ttmj1VN4ISAr7LePj1/yoFun76SlU
 VorD6nuyiou2i9EfplNWtI0CZWV4z4xFaLfT8LFVaxbixHZxubdI1V5QgGAy/S97t3sC
 0w5m0/E0QFdeeRn2cKbG+eR2nqauJejxTZSuf4hyxw+CPxAb4mRDHUfKD4rrCPgTRRTU
 NTe0I4FftC5vBNoV7NEdm/JQJdfCZunQjsY3hGLO6NbsDv6PLp3PpuQeqTVP65bRa+7E
 6oMNEFJpU3faoPdz/mMWuyNY79szHTSqIflFeLKqZut9ltLi4B9qjiIvbqI5g+oWNyLt
 SV0w==
X-Gm-Message-State: AOJu0YyBw0d3Sjk4MBWX+0dMUmRGqfk9cOClmEL7oDp55sjytWedjQ31
 oPKLY28t2k+6ruzQYpJuCFO4aPCr5n703V2l5306Xtv0+Jb6dF9eInfpRBtgAXlauYbLhuU39Wg
 B0lnae518VaVpIsYWL5sOqa7jDKgp3mTEkL8t
X-Google-Smtp-Source: AGHT+IFEIF6dRnk+YQwUOc+x/U260svxkYam6cK1XvQcmwjalNz/6K1R28ZQuhQ9jARVOkkqRd64tMg038UchBu1wqw=
X-Received: by 2002:a05:6300:668c:b0:1cf:2843:f798 with SMTP id
 adf61e73a8af0-1cf76239cd5mr1324467637.47.1726102825443; Wed, 11 Sep 2024
 18:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
 <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
 <CADg8p95a1iAzmwd-n8Y9EarX03cFUyBE5k+kwGm2PDy1W+PHNA@mail.gmail.com>
 <CAFLszThDsQrjWerLYiMf=T9VVbdT=i0FKbiD_v+Lv7uUZYsZBA@mail.gmail.com>
 <CADg8p953_gFWNigt+rUhLDVDz=DpQwefdpN8qgLaWNcpDZrrKg@mail.gmail.com>
In-Reply-To: <CADg8p953_gFWNigt+rUhLDVDz=DpQwefdpN8qgLaWNcpDZrrKg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:58 -0600
Message-ID: <CAFLszTiJkS23KGQ20dziPe5sQ0Ey+wCSSO6uV+Y4Ln=-cpuT=w@mail.gmail.com>
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

On Wed, 11 Sept 2024 at 00:50, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 11 Sept 2024 at 00:14, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 9 Sept 2024 at 01:44, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 6 Sept 2024 at 18:31, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Fri, 6 Sept 2024 at 00:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Mon, 2 Sept 2024 at 03:53, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > This API call is intended for allocating small amounts of memory,
> > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > malloc()-style header on each block.
> > > > > >
> > > > > > For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> > > > > > use U-Boot's built-in malloc() instead, at least until the app starts.
> > > > > > This avoids poluting the memory space with blocks of data which may
> > > > > > interfere with boot scripts, etc.
> > > > > >
> > > > > > Once the app has started, there is no advantage to using malloc(), since
> > > > > > it doesn't matter what memory is used: everything is under control of
> > > > > > the EFI subsystem. Also, using malloc() after the app starts might
> > > > > > result in running of memory, since U-Boot's malloc() space is typically
> > > > > > quite small.
> > > > > >
> > > > > > In fact, malloc() is already used for most EFI-related allocations, so
> > > > > > the impact of this change is fairly small.
> > > > > >
> > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > (presumed) bugs are located.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  common/dlmalloc.c            |   7 +++
> > > > > >  include/efi_loader.h         |  18 ++++++
> > > > > >  include/malloc.h             |   7 +++
> > > > > >  lib/efi_loader/efi_bootbin.c |   2 +
> > > > > >  lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> > > > > >  5 files changed, 117 insertions(+), 27 deletions(-)
> > > > > >
> > > > > > diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> > > > > > index 1ac7ce3f43c..48e9f3515f7 100644
> > > > > > --- a/common/dlmalloc.c
> > > > > > +++ b/common/dlmalloc.c
> > > > > > @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> > > > > >  #endif
> > > > > >  }
> > > > > >
> > > > > > +bool malloc_check_in_range(void *ptr)
> > > > > > +{
> > > > > > +       ulong val = (ulong)ptr;
> > > > > > +
> > > > > > +       return val >= mem_malloc_start && val < mem_malloc_end;
> > > > > > +}
> > > > > > +
> > > > > >  /* field-extraction macros */
> > > > > >
> > > > > >  #define first(b) ((b)->fd)
> > > > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > > > index 38971d01442..d07bc06bad4 100644
> > > > > > --- a/include/efi_loader.h
> > > > > > +++ b/include/efi_loader.h
> > > > > > @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> > > > > >  int efi_disk_remove(void *ctx, struct event *event);
> > > > > >  /* Called by board init to initialize the EFI memory map */
> > > > > >  int efi_memory_init(void);
> > > > > > +
> > > > > > +/**
> > > > > > + * enum efi_alloc_flags - controls EFI memory allocation
> > > > > > + *
> > > > > > + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> > > > > > + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> > > > > > + */
> > > > > > +enum efi_alloc_flags {
> > > > > > +       EFIAF_USE_MALLOC        = BIT(0),
> > > > > > +};
> > > > > > +
> > > > > > +/**
> > > > > > + * efi_set_alloc() - Set behaviour of EFI memory allocation
> > > > > > + *
> > > > > > + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> > > > > > + */
> > > > > > +void efi_set_alloc(int flags);
> > > > > > +
> > > > > >  /* Adds new or overrides configuration table entry to the system table */
> > > > > >  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> > > > > >  /* Sets up a loaded image */
> > > > > > diff --git a/include/malloc.h b/include/malloc.h
> > > > > > index 07d3e90a855..a64f117e2f2 100644
> > > > > > --- a/include/malloc.h
> > > > > > +++ b/include/malloc.h
> > > > > > @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
> > > > > >
> > > > > >  void mem_malloc_init(ulong start, ulong size);
> > > > > >
> > > > > > +/**
> > > > > > + * malloc_check_in_range() - Check if a pointer is within the malloc() region
> > > > > > + *
> > > > > > + * Return: true if within malloc() region
> > > > > > + */
> > > > > > +bool malloc_check_in_range(void *ptr);
> > > > > > +
> > > > > >  #ifdef __cplusplus
> > > > > >  };  /* end of extern "C" */
> > > > > >  #endif
> > > > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > > > index a87006b3c0e..5bb0fdcf75d 100644
> > > > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > > > @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > > > > >  {
> > > > > >         efi_status_t ret;
> > > > > >
> > > > > > +       efi_set_alloc(0);
> > > > > > +
> > > > >
> > > > > Here we are setting the flags to use the efi_allocate_pages() route to
> > > > > allocate memory, when booting into an EFI app. Do we need to set it
> > > > > back to EFIAF_USE_MALLOC if the app exits and control lands back in
> > > > > U-Boot? I am not sure that is being handled.
> > > >
> > > > I don't believe so. Once we have booted into the app, U-Boot loses
> > > > control of its memory layout, in the sense that the
> > > > efi_allocate_pages() has likely been called and placed things all over
> > > > the place in the memory. People should expect this.
> > >
> > > I am referring to a scenario where the app exits and control returns
> > > back to U-Boot, which I believe is a valid scenario. In such a case,
> > > should control not switch back to the malloc based allocations.
> > > Otherwise we do not have consistent behaviour with the allocations --
> > > any subsequent calls to efi_allocate_pool on return from an EFI app
> > > would continue using the other (efi_allocate_pages() based) path.
> >
> > Thanks for reviewing.
> >
> > I completely understand your scenario, but I think I explained it
> > above. The important thing is to keep memory 'consistent' from a
> > U-Boot point of view until we actually boot something.
>
> How does reverting back to using the malloc heap for
> efi_allocate_pool() after returning back from the EFI app affect
> memory consistency? We now have the LMB memory map which is global and
> persistent. So any allocations that were done (and not freed) from the
> app, would be using the memory that you mention -- from 0 to bottom of
> the stack. In fact, I would argue that not reverting back to malloc
> based allocations on return from the app is inconsistent behaviour.

No, I mean we should *not* use memory from 0 to the bottom of the
stack. That is supposed to be reserved for image loading. Scripts may
assume they can do anything in this space and most boards have fixed
addresses for kernel, etc.

>
> >
> > U-Boot expects memory from 0 to the bottom of the stack to be
> > available for loading images. That is why it relocates itself.
>
> The EFI app is supposed to use the memory allocation API's
> (efi_allocate_{pages,pool}) for getting memory. And those requests are
> going to come from the LMB allocations (after the latest LMB rework
> series). So the heap memory is not supposed to be trampled over with.

I'm not quite sure what you are getting at here? My goal is to tidy up
the allocation of memory *before* the app boots.

> > > This is of course with the assumption that the EFI maintainers are
> > > fine with using this hybrid approach on the allocations.
> >
> > Yes, I certainly hope so. This whole problem has caused an enormous
> > amount of confusion and I very much want to clean it up.
> > >

> > > >
> > > > We can potentially deal with this if we find a specific problem, but I
> > > > can't think of one at the moment.
> > > >

[..]

Regards,
Simon
