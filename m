Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB342C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6755B88B13;
	Wed, 25 Sep 2024 14:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JnEGpbHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AE888AA7; Wed, 25 Sep 2024 14:49:14 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B618288B6D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-49bd40d77e5so2202742137.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268548; x=1727873348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KFbn95EpJjbfR42eJuOdVMtwedHuWKsWfiMPqLWbpls=;
 b=JnEGpbHm4YKprRLcZT3s0dqxV20hBiVr/S9x3T0pjpCCksZSsMvL0IO024zJ8mI1+u
 B5WAkZVhUAOZVVGICLmiBlU/lRQICJ9QtuKWmUBo4TLCjIfVo+Mzh9m5LGtaL1p5QANr
 YaPFzKqv8I4Q1Jwy2w76m4enH/cxB8fEfF+f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268548; x=1727873348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFbn95EpJjbfR42eJuOdVMtwedHuWKsWfiMPqLWbpls=;
 b=Hvx2HKsAVC1aK/svf0oKGvkh6m+Lc+n+hpEu0EadiBK5e/XOh4DwYovCS2ESSMvLP6
 Ee6SI0KdF3Stjai8/+f1RkUmoQ3s/pTMVTQOo/GcipJAJzzx26nB+9iTHrbvAfVAMwlJ
 xI2RxVYaS/SQxhNZn3XswHEak90ghmK9jt7tYKDunOemZ6VV/qoz6JduhBsffnhmeLV6
 t+jeeGUKtiBsjXKQZ6OkQTFwD1SFdGM0GhmP4ZS9yjhwuLJNcUltZLun/A8AP9bOrkiv
 srwLckD+TMsAy6EI0Ad5BbSEAnR0ENUify8mv0QDihXKr1e8pCmtXYa4ZLM3ejtm2BY+
 BdPA==
X-Gm-Message-State: AOJu0Yw1T/SJ4QYhN02d8hZjXmPxzZnvNFsnpJ61z9hY0X3HZ6zCbLe7
 0Yyh21ggT6JutC8FIBOZNTIBeiYwadBgneu/mKYktQkUq05YSO5joMVqgYOaRQypCZzUci1Fx/R
 HDyrvSZLmwvJo3Xa4OkJSzRFWIB1ZLsz/7qH6
X-Google-Smtp-Source: AGHT+IHjPFWkPKXMASBIUKGdUDF3FmceO7WrCkKdKZQLVj0shj0zQCH1CMkfW1nsNiOCRpp/liBpTQaj0nHxU9XunwE=
X-Received: by 2002:a05:6102:390d:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-4a15dd5470amr2186118137.19.1727268548436; Wed, 25 Sep 2024
 05:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-3-sjg@chromium.org>
 <CADg8p96GUQcWXt3HPjjmZxF9o50d05GmPut5icqRr3Z1NA4hrg@mail.gmail.com>
 <CAFLszTiH=c1RYOOgQZMkYn2HQhL9h0d6bq6VRmzW8Hrk1YG6cg@mail.gmail.com>
 <CADg8p95a1iAzmwd-n8Y9EarX03cFUyBE5k+kwGm2PDy1W+PHNA@mail.gmail.com>
 <CAFLszThDsQrjWerLYiMf=T9VVbdT=i0FKbiD_v+Lv7uUZYsZBA@mail.gmail.com>
 <CADg8p953_gFWNigt+rUhLDVDz=DpQwefdpN8qgLaWNcpDZrrKg@mail.gmail.com>
 <CAFLszTiJkS23KGQ20dziPe5sQ0Ey+wCSSO6uV+Y4Ln=-cpuT=w@mail.gmail.com>
 <8bcde947-2b34-4401-b847-121818d8bcef@gmx.de>
In-Reply-To: <8bcde947-2b34-4401-b847-121818d8bcef@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:48:55 +0200
Message-ID: <CAFLszTgO-_HEP5DG92_ohwGih88pXpooVVGAud0D-RQ5YLie0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] efi: Allow use of malloc() for the EFI pool
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 23 Sept 2024 at 14:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12.09.24 02:59, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Wed, 11 Sept 2024 at 00:50, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >>
> >> On Wed, 11 Sept 2024 at 00:14, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Hi Sughosh,
> >>>
> >>> On Mon, 9 Sept 2024 at 01:44, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >>>>
> >>>> On Fri, 6 Sept 2024 at 18:31, Simon Glass <sjg@chromium.org> wrote:
> >>>>>
> >>>>> Hi Sughosh,
> >>>>>
> >>>>> On Fri, 6 Sept 2024 at 00:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >>>>>>
> >>>>>> On Mon, 2 Sept 2024 at 03:53, Simon Glass <sjg@chromium.org> wrote:
> >>>>>>>
> >>>>>>> This API call is intended for allocating small amounts of memory,
> >>>>>>> similar to malloc(). The current implementation rounds up to whole pages
> >>>>>>> which can waste large amounts of memory. It also implements its own
> >>>>>>> malloc()-style header on each block.
> >>>>>>>
> >>>>>>> For certain allocations (those of type EFI_BOOT_SERVICES_DATA) we can
> >>>>>>> use U-Boot's built-in malloc() instead, at least until the app starts.
> >>>>>>> This avoids poluting the memory space with blocks of data which may
> >>>>>>> interfere with boot scripts, etc.
> >>>>>>>
> >>>>>>> Once the app has started, there is no advantage to using malloc(), since
> >>>>>>> it doesn't matter what memory is used: everything is under control of
> >>>>>>> the EFI subsystem. Also, using malloc() after the app starts might
> >>>>>>> result in running of memory, since U-Boot's malloc() space is typically
> >>>>>>> quite small.
> >>>>>>>
> >>>>>>> In fact, malloc() is already used for most EFI-related allocations, so
> >>>>>>> the impact of this change is fairly small.
> >>>>>>>
> >>>>>>> One side effect is that this seems to be showing up some bugs in the
> >>>>>>> EFI code, since the malloc() pool becomes corrupted with some tests.
> >>>>>>> This has likely crept in due to the very large gaps between allocations
> >>>>>>> (around 4KB), which provides a lot of leeway when the allocation size is
> >>>>>>> too small. Work around this by increasing the size for now, until these
> >>>>>>> (presumed) bugs are located.
> >>>>>>>
> >>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> (no changes since v1)
> >>>>>>>
> >>>>>>>   common/dlmalloc.c            |   7 +++
> >>>>>>>   include/efi_loader.h         |  18 ++++++
> >>>>>>>   include/malloc.h             |   7 +++
> >>>>>>>   lib/efi_loader/efi_bootbin.c |   2 +
> >>>>>>>   lib/efi_loader/efi_memory.c  | 110 ++++++++++++++++++++++++++---------
> >>>>>>>   5 files changed, 117 insertions(+), 27 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> >>>>>>> index 1ac7ce3f43c..48e9f3515f7 100644
> >>>>>>> --- a/common/dlmalloc.c
> >>>>>>> +++ b/common/dlmalloc.c
> >>>>>>> @@ -613,6 +613,13 @@ void mem_malloc_init(ulong start, ulong size)
> >>>>>>>   #endif
> >>>>>>>   }
> >>>>>>>
> >>>>>>> +bool malloc_check_in_range(void *ptr)
> >>>>>>> +{
> >>>>>>> +       ulong val = (ulong)ptr;
> >>>>>>> +
> >>>>>>> +       return val >= mem_malloc_start && val < mem_malloc_end;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>   /* field-extraction macros */
> >>>>>>>
> >>>>>>>   #define first(b) ((b)->fd)
> >>>>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >>>>>>> index 38971d01442..d07bc06bad4 100644
> >>>>>>> --- a/include/efi_loader.h
> >>>>>>> +++ b/include/efi_loader.h
> >>>>>>> @@ -805,6 +805,24 @@ int efi_disk_probe(void *ctx, struct event *event);
> >>>>>>>   int efi_disk_remove(void *ctx, struct event *event);
> >>>>>>>   /* Called by board init to initialize the EFI memory map */
> >>>>>>>   int efi_memory_init(void);
> >>>>>>> +
> >>>>>>> +/**
> >>>>>>> + * enum efi_alloc_flags - controls EFI memory allocation
> >>>>>>> + *
> >>>>>>> + * @EFIAF_USE_MALLOC: Use malloc() pool for pool allocations of type
> >>>>>>> + *     EFI_BOOT_SERVICES_DATA, otherwise use page allocation
> >>>>>>> + */
> >>>>>>> +enum efi_alloc_flags {
> >>>>>>> +       EFIAF_USE_MALLOC        = BIT(0),
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +/**
> >>>>>>> + * efi_set_alloc() - Set behaviour of EFI memory allocation
> >>>>>>> + *
> >>>>>>> + * @flags: new value for allocation flags (see enum efi_alloc_flags)
> >>>>>>> + */
> >>>>>>> +void efi_set_alloc(int flags);
> >>>>>>> +
> >>>>>>>   /* Adds new or overrides configuration table entry to the system table */
> >>>>>>>   efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
> >>>>>>>   /* Sets up a loaded image */
> >>>>>>> diff --git a/include/malloc.h b/include/malloc.h
> >>>>>>> index 07d3e90a855..a64f117e2f2 100644
> >>>>>>> --- a/include/malloc.h
> >>>>>>> +++ b/include/malloc.h
> >>>>>>> @@ -983,6 +983,13 @@ extern ulong mem_malloc_brk;
> >>>>>>>
> >>>>>>>   void mem_malloc_init(ulong start, ulong size);
> >>>>>>>
> >>>>>>> +/**
> >>>>>>> + * malloc_check_in_range() - Check if a pointer is within the malloc() region
> >>>>>>> + *
> >>>>>>> + * Return: true if within malloc() region
> >>>>>>> + */
> >>>>>>> +bool malloc_check_in_range(void *ptr);
> >>>>>>> +
> >>>>>>>   #ifdef __cplusplus
> >>>>>>>   };  /* end of extern "C" */
> >>>>>>>   #endif
> >>>>>>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> >>>>>>> index a87006b3c0e..5bb0fdcf75d 100644
> >>>>>>> --- a/lib/efi_loader/efi_bootbin.c
> >>>>>>> +++ b/lib/efi_loader/efi_bootbin.c
> >>>>>>> @@ -201,6 +201,8 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >>>>>>>   {
> >>>>>>>          efi_status_t ret;
> >>>>>>>
> >>>>>>> +       efi_set_alloc(0);
> >>>>>>> +
> >>>>>>
> >>>>>> Here we are setting the flags to use the efi_allocate_pages() route to
> >>>>>> allocate memory, when booting into an EFI app. Do we need to set it
> >>>>>> back to EFIAF_USE_MALLOC if the app exits and control lands back in
> >>>>>> U-Boot? I am not sure that is being handled.
> >>>>>
> >>>>> I don't believe so. Once we have booted into the app, U-Boot loses
> >>>>> control of its memory layout, in the sense that the
> >>>>> efi_allocate_pages() has likely been called and placed things all over
> >>>>> the place in the memory. People should expect this.
> >>>>
> >>>> I am referring to a scenario where the app exits and control returns
> >>>> back to U-Boot, which I believe is a valid scenario. In such a case,
> >>>> should control not switch back to the malloc based allocations.
> >>>> Otherwise we do not have consistent behaviour with the allocations --
> >>>> any subsequent calls to efi_allocate_pool on return from an EFI app
> >>>> would continue using the other (efi_allocate_pages() based) path.
> >>>
> >>> Thanks for reviewing.
> >>>
> >>> I completely understand your scenario, but I think I explained it
> >>> above. The important thing is to keep memory 'consistent' from a
> >>> U-Boot point of view until we actually boot something.
> >>
> >> How does reverting back to using the malloc heap for
> >> efi_allocate_pool() after returning back from the EFI app affect
> >> memory consistency? We now have the LMB memory map which is global and
> >> persistent. So any allocations that were done (and not freed) from the
> >> app, would be using the memory that you mention -- from 0 to bottom of
> >> the stack. In fact, I would argue that not reverting back to malloc
> >> based allocations on return from the app is inconsistent behaviour.
> >
> > No, I mean we should *not* use memory from 0 to the bottom of the
> > stack. That is supposed to be reserved for image loading. Scripts may
> > assume they can do anything in this space and most boards have fixed
> > addresses for kernel, etc.
> >
> >>
> >>>
> >>> U-Boot expects memory from 0 to the bottom of the stack to be
> >>> available for loading images. That is why it relocates itself.
> >>
> >> The EFI app is supposed to use the memory allocation API's
> >> (efi_allocate_{pages,pool}) for getting memory. And those requests are
> >> going to come from the LMB allocations (after the latest LMB rework
> >> series). So the heap memory is not supposed to be trampled over with.
> >
> > I'm not quite sure what you are getting at here? My goal is to tidy up
> > the allocation of memory *before* the app boots.
>
>
> AllocatePool() can be used to allocate multiple GiB of memory. The
> malloc pool is too small for this purpose. You would first have to
> change the malloc implementation to acquire arbitrary amounts of memory
> from LMB.
>
> Please, don't complicate the code by treating different memory types
> differently in AllocatePool().
>
> The way forward is to change LMB to store EFI memory types. This will
> allow us to remove most of the code in lib/efi_loader/efi_memory.c.
>
> Once that integration work is done we can start thinking about
> generalizing malloc() to support multiple memory pools of arbitrary size
> to encompass AllocatePool().

Unfortunately that is not the correct approach at all. I fully
understand where you are coming from, but the complexity involved is
wrong for U-Boot.

I do not have to have to change the malloc() implementation at all. It
is perfectly fine as it is. It is only EFI that needs to change
slightly, using malloc() for the pool until the app starts.

We also need to consider what happens when EFI_LOADER is disabled,
which I am intent on preserving.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> >>>> This is of course with the assumption that the EFI maintainers are
> >>>> fine with using this hybrid approach on the allocations.
> >>>
> >>> Yes, I certainly hope so. This whole problem has caused an enormous
> >>> amount of confusion and I very much want to clean it up.
> >>>>
> >
> >>>>>
> >>>>> We can potentially deal with this if we find a specific problem, but I
> >>>>> can't think of one at the moment.
> >>>>>
> >
> > [..]
> >
> > Regards,
> > Simon
>
