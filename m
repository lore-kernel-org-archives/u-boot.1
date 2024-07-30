Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 20:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199AA887E8;
	Tue, 30 Jul 2024 22:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imEM51Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E26888AB; Tue, 30 Jul 2024 22:52:36 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB62887B9
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 22:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso34242516d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722372752; x=1722977552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3S4lyZz+LWEscioISQExetZtg6yuXtP/lkhWtI9vTs=;
 b=imEM51LvyU1NoCrz3e/s9fG8hKVgR2dBAB7MuNFHRyfCBGZt9MbanGd02jUcxak10a
 BOp7p7V9PYvncKvSjQDI7LhPYHj8jDZcG6WyluBGch6BObD8v4U+AgSGuDqmm40o1oM9
 woHrGgs5rja0KUuQZw6oQyYU+NkiqaR8vdTZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722372752; x=1722977552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3S4lyZz+LWEscioISQExetZtg6yuXtP/lkhWtI9vTs=;
 b=C6DhIFcBEOxmKF87TTj3vk5sPW+z8Oz51kRjIsSNjwO4iM3k+QKNLbczSb+GWFedUD
 FKygY1sWhg7zOaXkYH8iSY/gQvwEBjnQK8f5avy/ASEHoNCZ7btvxO4VT51HfImyB2SH
 Z7YSaP+pGe7lbDRUd3G8q0CR308ve90co2VP1KP1YioVp4HYL7xPFq/k4JGdcuSXMswK
 /Plu8nfJvX4Zww2+cNmNnr5mM01D9l50PzAobXLue15ANFGjCMp+gsRFetLYcGqO0dBm
 HqRFlGRH/3X79iSSldmzl6L3FvRywiuuHhSs8tzDg2z6ZSPOvOdfvvvEUlh5DFPXp+OZ
 ICQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpzgmp5Z1KX40QXQEuYKSiTL6yWca0ar2zYCRyH1qJnk34+YRyHLtMUxNUCktLU5h+//rIR6TNhZeb5xdZWrFohMi7XQ==
X-Gm-Message-State: AOJu0YxSGUZRf2XOEBwM9JE6SNfSc1mDrNPLnnKeSJV5+6yCQWWsLlPE
 KvkMXU4gg7r08qEpuFlDkaqoBmzXCxNF3AxDWFfSwk9z9nNptW10CtV9oJEP8sx7+L6TNpWME6x
 wPWt5TWHGkO03EvLREjTaxX3gZsuRppaRKwiS9UIciUd+Y3Y=
X-Google-Smtp-Source: AGHT+IE8SRW3Tk7WbJwN3MUtPWn65XqpCFomN0Nv69ZdbxH3TYe5EYKi4XuO3g+L0PA4VIpw44Z+Gg3tNAv7ysWsBQo=
X-Received: by 2002:a05:6214:62e:b0:6b5:e403:4418 with SMTP id
 6a1803df08f44-6bb5597d56dmr192767796d6.10.1722372752075; Tue, 30 Jul 2024
 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjKvx8VEnAuotXLm41YVn24-ijNjh5PW6kBcb1TqV9o_og@mail.gmail.com>
 <CAFLszTg7aGk=nb+C1ovNu3QZk3d-vGAOsS5RzzUvdBCaMkyArw@mail.gmail.com>
 <CAC_iWjLcJ-PkX2d0LH-Tj8M513t-R1Hy1qNAZNz3Cjw4P+K2BA@mail.gmail.com>
 <CAFLszTivmh=ig-Zoe721B8wHqGRyFZ=R9_4Wo6ZhfmxNLO0+Bg@mail.gmail.com>
 <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <20240730201129.GB3794063@bill-the-cat>
In-Reply-To: <20240730201129.GB3794063@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 14:52:21 -0600
Message-ID: <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Hi Tom,

On Tue, 30 Jul 2024 at 14:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 30, 2024 at 02:05:19PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 30 Jul 2024 at 13:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jul 30, 2024 at 01:42:17PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 30 Jul 2024 at 09:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jul 30, 2024 at 09:18:02AM -0600, Simon Glass wrote:
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Tue, 30 Jul 2024 at 08:54, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 30 Jul 2024 at 17:38, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > On Tue, 30 Jul 2024 at 02:20, Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 29 Jul 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Ilias,
> > > > > > > > > >
> > > > > > > > > > On Mon, 29 Jul 2024 at 04:02, Ilias Apalodimas
> > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Simon
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 26 Jul 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Ilias,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 26 Jul 2024 at 02:31, Ilias Apalodimas
> > > > > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 26 Jul 2024 at 02:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, 25 Jul 2024 at 09:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On 25.07.24 15:56, Simon Glass wrote:
> > > > > > > > > > > > > > > > This API call is intended for allocating small amounts of memory,
> > > > > > > > > > > > > > > > similar to malloc(). The current implementation rounds up to whole pages
> > > > > > > > > > > > > > > > which can waste large amounts of memory. It also implements its own
> > > > > > > > > > > > > > > > malloc()-style header on each block.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Use U-Boot's built-in malloc() instead, to avoid these problems:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > - it should normally be large enough for pool allocations
> > > > > > > > > > > > > > > > - if it isn't we can enforce a minimum size for boards which use
> > > > > > > > > > > > > > > >    EFI_LOADER
> > > > > > > > > > > > > > > > - the existing mechanism may create an unwatned entry in the memory map
> > > > > > > > > > > > > > > > - it is used for most EFI allocations already
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > One side effect is that this seems to be showing up some bugs in the
> > > > > > > > > > > > > > > > EFI code, since the malloc() pool becomes corrupted with some tests.
> > > > > > > > > > > > > > > > This has likely crept in due to the very large gaps between allocations
> > > > > > > > > > > > > > > > (around 4KB), which provides a lot of leeway when the allocation size is
> > > > > > > > > > > > > > > > too small. Work around this by increasing the size for now, until these
> > > > > > > > > > > > > > > > (presumed) bugs are located.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >   lib/efi_loader/efi_memory.c | 93 ++++++++-----------------------------
> > > > > > > > > > > > > > > >   1 file changed, 19 insertions(+), 74 deletions(-)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > index 2945f5648c7..fabe9e3a87a 100644
> > > > > > > > > > > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > > > > @@ -80,45 +80,6 @@ static LIST_HEAD(efi_mem);
> > > > > > > > > > > > > > > >   void *efi_bounce_buffer;
> > > > > > > > > > > > > > > >   #endif
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > > - * struct efi_pool_allocation - memory block allocated from pool
> > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > - * @num_pages:       number of pages allocated
> > > > > > > > > > > > > > > > - * @checksum:        checksum
> > > > > > > > > > > > > > > > - * @data:    allocated pool memory
> > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > - * U-Boot services each UEFI AllocatePool() request as a separate
> > > > > > > > > > > > > > > > - * (multiple) page allocation. We have to track the number of pages
> > > > > > > > > > > > > > > > - * to be able to free the correct amount later.
> > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > - * The checksum calculated in function checksum() is used in FreePool() to avoid
> > > > > > > > > > > > > > > > - * freeing memory not allocated by AllocatePool() and duplicate freeing.
> > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > - * EFI requires 8 byte alignment for pool allocations, so we can
> > > > > > > > > > > > > > > > - * prepend each allocation with these header fields.
> > > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > > -struct efi_pool_allocation {
> > > > > > > > > > > > > > > > -     u64 num_pages;
> > > > > > > > > > > > > > > > -     u64 checksum;
> > > > > > > > > > > > > > > > -     char data[] __aligned(ARCH_DMA_MINALIGN);
> > > > > > > > > > > > > > > > -};
> > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > > -/**
> > > > > > > > > > > > > > > > - * checksum() - calculate checksum for memory allocated from pool
> > > > > > > > > > > > > > > > - *
> > > > > > > > > > > > > > > > - * @alloc:   allocation header
> > > > > > > > > > > > > > > > - * Return:   checksum, always non-zero
> > > > > > > > > > > > > > > > - */
> > > > > > > > > > > > > > > > -static u64 checksum(struct efi_pool_allocation *alloc)
> > > > > > > > > > > > > > > > -{
> > > > > > > > > > > > > > > > -     u64 addr = (uintptr_t)alloc;
> > > > > > > > > > > > > > > > -     u64 ret = (addr >> 32) ^ (addr << 32) ^ alloc->num_pages ^
> > > > > > > > > > > > > > > > -               EFI_ALLOC_POOL_MAGIC;
> > > > > > > > > > > > > > > > -     if (!ret)
> > > > > > > > > > > > > > > > -             ++ret;
> > > > > > > > > > > > > > > > -     return ret;
> > > > > > > > > > > > > > > > -}
> > > > > > > > > > > > > > > > -
> > > > > > > > > > > > > > > >   /**
> > > > > > > > > > > > > > > >    * efi_mem_cmp() - comparator function for sorting memory map
> > > > > > > > > > > > > > > >    *
> > > > > > > > > > > > > > > > @@ -681,13 +642,10 @@ void *efi_alloc_aligned_pages(u64 len, int memory_type, size_t align)
> > > > > > > > > > > > > > > >    * @buffer: allocated memory
> > > > > > > > > > > > > > > >    * Return:  status code
> > > > > > > > > > > > > > > >    */
> > > > > > > > > > > > > > > > -efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size, void **buffer)
> > > > > > > > > > > > > > > > +efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > > > +                            void **buffer)
> > > > > > > > > > > > > > > >   {
> > > > > > > > > > > > > > > > -     efi_status_t r;
> > > > > > > > > > > > > > > > -     u64 addr;
> > > > > > > > > > > > > > > > -     struct efi_pool_allocation *alloc;
> > > > > > > > > > > > > > > > -     u64 num_pages = efi_size_in_pages(size +
> > > > > > > > > > > > > > > > -                                       sizeof(struct efi_pool_allocation));
> > > > > > > > > > > > > > > > +     void *ptr;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >       if (!check_allowed())
> > > > > > > > > > > > > > > >               return EFI_UNSUPPORTED;
> > > > > > > > > > > > > > > > @@ -700,16 +658,21 @@ efi_status_t efi_allocate_pool(enum efi_memory_type pool_type, efi_uintn_t size,
> > > > > > > > > > > > > > > >               return EFI_SUCCESS;
> > > > > > > > > > > > > > > >       }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Unfortunately this patch does not match the UEFI specification:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Two different memory types cannot reside in the same memory page. You
> > > > > > > > > > > > > > > have to keep track of the memory type of each allocated memory page and
> > > > > > > > > > > > > > > report it in GetMemoryMap().
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I actually hadn't thought about that. Is it implied in the spec or
> > > > > > > > > > > > > > actually stated somewhere?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I don't remember if it's explicitly stated, but it *really* doesn't
> > > > > > > > > > > > > have to be. Although u-boot doesn't currently support this on modern
> > > > > > > > > > > > > secure systems you can't have code and data mixed on the same page.
> > > > > > > > > > > > > This would prevent you to map pages with proper permissions and take
> > > > > > > > > > > > > advantage of CPU security features  e.g RW^X.
> > > > > > > > > > > >
> > > > > > > > > > > > As it stands, U-Boot's data is reported as EFI_BOOT_SERVICES_CODE
> > > > > > > > > > > > through EFI. Perhaps the difference between EFI_BOOT_SERVICES_CODE and
> > > > > > > > > > > > EFI_BOOT_SERVICES_DATA isn't that important?
> > > > > > > > > > > >
> > > > > > > > > > > > But if we did want to fix that, we could make the malloc region
> > > > > > > > > > > > EFI_BOOT_SERVICES_DATA.
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > In any case, the AllocatePool description reads "This function
> > > > > > > > > > > > > allocates pages from EfiConventionalMemory as needed to grow the
> > > > > > > > > > > > > requested pool type. All allocations are eight-byte aligned". I don't
> > > > > > > > > > > > > think using malloc in AllocatePool is appropriate. If we ever want to
> > > > > > > > > > > > > do that and allocate from the malloc space, we need to teach malloc
> > > > > > > > > > > > > some EFI semantics, but that's a really bad idea.
> > > > > > > > > > > >
> > > > > > > > > > > > Here I don't see the difference between EFI's malloc(n) and
> > > > > > > > > > > > memalign(8, n). I do see a lot of comments like 'use the spec', 'read
> > > > > > > > > > > > the spec'. It seems very clear to me that the bootloader can use
> > > > > > > > > > > > whatever algorithm it likes to provide the allocated memory for the
> > > > > > > > > > > > pool.
> > > > > > > > > > > >
> > > > > > > > > > > > What sort of EFI semantics are you referring to?
> > > > > > > > > > >
> > > > > > > > > > > the memory type. Your patch removes the call to efi_allocate_pages
> > > > > > > > > > > which tracks it.
> > > > > > > > > >
> > > > > > > > > > I can put that code back, depending on what we decide below.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Anyway, from what I can tell, we mostly use EFI_BOOT_SERVICES_DATA.
> > > > > > > > > > > > > > The only exception is EFI_RUNTIME_SERVICES_DATA for the runtime stuff.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That's not entirely correct, we use a lot more than these 2.
> > > > > > > > > > > > > EFI_LOADER_DATA, EFI_LOADER_CODE and EFI_ACPI_RECLAIM_MEMORY from a
> > > > > > > > > > > > > quick grep
> > > > > > > > > > > >
> > > > > > > > > > > > Yes I did a quick grep too, but then checked each site. The first two
> > > > > > > > > > > > are used in an EFI app, not U-Boot itself. The ACPI one is not an
> > > > > > > > > > > > allocation.
> > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So perhaps we can use malloc() for EFI_BOOT_SERVICES_DATA allocations
> > > > > > > > > > > > > > and stick with whole pages otherwise? That will mostly fix the problem
> > > > > > > > > > > > > > I am seeing.
> > > > > > > > > > > >
> > > > > > > > > > > > Any comments on this?
> > > > > > > > > > >
> > > > > > > > > > > This violates the spec and probably breaks a few tests and the EFI
> > > > > > > > > > > boot services API, as you are supposed to be able to define the memory
> > > > > > > > > > > type. We might be able to control it from U-Boot, but EFI apps are
> > > > > > > > > > > going to end up being buggy and hard to debug -- e.g an app calls
> > > > > > > > > > > allocatePool to allocate memory that needs to be preserved at runtime.
> > > > > > > > > >
> > > > > > > > > > To be more specific, I am suggesting:
> > > > > > > > > > - use malloc() for EFI_BOOT_SERVICES_DATA allocations (with no memory
> > > > > > > > > > type since it is always that). This should cover all the U-Boot
> > > > > > > > > > allocations and make sure they are safely within the malloc() pool
> > > > > > > > > > - use efi_allocate_pages() for other memory types (keeping the memory
> > > > > > > > > > type in metadata)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Personally, I don't see the point and we deviate from the spec as
> > > > > > > > > well. Perhaps Heinrich thinks otherwise, but the EFI spec still says
> > > > > > > > > you need to allocate *pages* to grow the pool. What's missing from our
> > > > > > > > > efi_allocate_pool() is the ability to merge allocations of the same
> > > > > > > > > memory type to an existing pool assuming there's space, rather than
> > > > > > > > > requesting a new pool of 4kb.
> > > > > > > >
> > > > > > > > "This function allocates pages from EfiConventionalMemory as needed to
> > > > > > > > grow the requested pool type". So far as EFI is concerned, the
> > > > > > > > malloc() region is in EfiConventionalMemory, so I don't see any
> > > > > > > > deviation.
> > > > > > > >
> > > > > > > > Please also see below.
> > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > You can switch some callsite of efi_allocate_pool to
> > > > > > > > > > > efi_allocate_pages() internally. Will that fix the behavior?
> > > > > > > > > >
> > > > > > > > > > It still allocates memory 'in space' and uses 4KB for each allocation.
> > > > > > > > > >
> > > > > > > >
> > > > > > > > This is the key point that doesn't seem to be coming across. The
> > > > > > > > current allocator is allocating memory wherever it likes, potentially
> > > > > > > > interfering with the kernel_addr_r addresses, etc. as on qemu_arm.
> > > > > > >
> > > > > > > It is, but I don't think using malloc is solving it. It's papering
> > > > > > > over the problem, because if someone in the future launches an EFI app
> > > > > > > or allocates EFI memory with a different type you are back on the same
> > > > > > > problem.
> > > > > >
> > > > > > It is certainly solving this problem.
> > > > > >
> > > > > > Once the app is launched it is OK to overwrite memory...after all it
> > > > > > has been loaded and is running. The issue is that these little
> > > > > > allocations can end up anywhere in memory. Did you see the qemu_arm
> > > > > > note?
> > > > >
> > > > > Isn't this another part of why we need the LMB rework? So that
> > > > > kernel_addr_r, et al, can be marked as reserved.
> > > >
> > > > If we mark them as reserved, we won't be able to load a file into that
> > > > region, so boot scripts will fail.
> > >
> > > No? We mark it as being overwriteable but allocated. This is part of the
> > > LMB rework series.
> >
> > Yes, I see, that makes sense. I don't know any way to guess the
> > expected size of the kernel or ramdisk. I see that Apple uses 128MB
> > for the kernel (plenty) and 1GB for the ramdisk.
>
> Yes, 128MiB is a practical limit. Ramdisk is where it gets trickier.
>
> > > > Please take a look at the whole series and let me know if there is
> > > > anything missing from the descriptions I have given. I have had this
> > > > problem in the back of my mind for some time...but just a few hours of
> > > > investigation was enough to determine that it really is broken.
> > >
> > > I'm missing something, sorry. Yes, it is known that EFI can make some
> > > incorrect assumptions about what memory is/isn't available (as other
> > > implementations give EFI the world to work with), hence the LMB rework
> > > series to address some of these problems.
> >
> > My goal here is to tidy up EFI memory allocation so that it doesn't
> > result in allocating memory in strange places. Avoiding overlaps is
> > one thing, but the way this is heading, we will get overlap errors
> > randomly on platforms when someone tries to load something into RAM,
> > or we won't protect things that need to be protected. It is all a bit
> > mushy without a proper design.
> >
> > Does that make sense?
>
> Well, to me step one is to get the lmb series done so that if something
> needs a range of memory it can both check if it's available and mark it
> as unavailable to others. As yes, we have something analogous to
> cooperative multitasking when it comes to memory management today, and
> that doesn't always work out.

OK, and that is in progress.

>
> Step two is getting the new lmb series and EFI_LOADER talking,

What sort of talking? Bear in mind that EFI_LOADER currently does
allocations even if it isn't used.

> so that
> step three can be seeing what tweaks may be needed in where things
> allocate memory.

So my series is step 3?

Regards,
SImon
