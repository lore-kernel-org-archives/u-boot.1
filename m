Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E5DC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C5E8858E;
	Mon, 10 Jun 2024 17:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D+2j11IS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4561885E1; Mon, 10 Jun 2024 17:54:18 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424158858E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b07308fe6cso7371386d6.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718034855; x=1718639655; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qv8QVidjzolD5kbh5e+ibrhdSRuUQ2HuLhCJdJRZAiY=;
 b=D+2j11ISnQODyB1q+rTr7yt+/UJ7VCz6ST92LituFf1PvMx4Qtx6sfmGvDuuTpPH+4
 klUX3QJBAiJw/cWyUjY58kVOwHHpw/DL/bsG7e0s+EsnY6XfnhiJEMt3kHUCOCXAqpYg
 TtsHLSiJuGr5CMCDqdIziJYXQrspfUCw5VKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034855; x=1718639655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qv8QVidjzolD5kbh5e+ibrhdSRuUQ2HuLhCJdJRZAiY=;
 b=povl2me177YvaxWR5Xkt28Ti3JQoYNJi/DnHIk3jZ87K2maL0EYAgv93q8gXA/XvN4
 A3XnSUPvtiWRDaMgSuxSygHr12IfPoZC1aqd43gsOxSU8tYgu+hZCSameBylhqIWpKvz
 2LnqhfJSG0mh1Oplr+a3d9TXqNhsOejs/yHxdetbXkP1tn/724Xj1Wzo6pWtI0f08mUU
 j1sN/enFLPLGJDK6Sow5nrxYvzEoAfeofoNwwLXNMzMEdaZ4W6LOZBh5IKk8Ann6rCPE
 d2hA+sW838L9XI2rooe2LwK0X3oHN/Bd19cpTX/FK22EIqvVYox1h601nTL2lNtXDCOx
 o8vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQXao4YS7UFFpnEwLkTIXnvLJsxW6mDLJ3gxPbKLbC1RZs3MZjUrX0ny33/GxcRHYGuxoZduDi6gOz735ARpQKOnpH/w==
X-Gm-Message-State: AOJu0YyFqPoVTrjEcr3oTRgJBhKq+55poxXzcXpavbSGYqGFa1Z/6bz/
 ScWQbj9WFejsUT0WMUrFOoXXwgKw8ZM32g0RJ2IcxK12kcxMyJmqmg8OxyTVxJ2scNeNx6Owfeq
 rck2n9E/JpdZEY3IIRcHkiBQkoZC5gI7Ifi67
X-Google-Smtp-Source: AGHT+IHg7moChbikWwe/LtsMcLW8NOENM08zreqS3ShZaNH2J0DU2Q2yqxBm8FrxPsDQ8yYtuo9y0QMD3xY5tapVmeM=
X-Received: by 2002:a05:6214:5342:b0:6b0:754e:9869 with SMTP id
 6a1803df08f44-6b0754e9ad7mr54533616d6.15.1718034855060; Mon, 10 Jun 2024
 08:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <40cf9c99-d3f5-4851-81e0-9fc7218434e8@gmx.de>
 <CADg8p952ieHHzeBSoyKPZ4+9pzHHEL+7w9=1Xf5WKuN2zBrBXw@mail.gmail.com>
In-Reply-To: <CADg8p952ieHHzeBSoyKPZ4+9pzHHEL+7w9=1Xf5WKuN2zBrBXw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:54:03 -0600
Message-ID: <CAFLszTi=En1-FJ7WRpTZDhr9kzS9TNySPeSjMqfso-L6Cp_vrg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
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

Hi,

On Mon, 10 Jun 2024 at 09:42, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 10 Jun 2024 at 20:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > There are events that would be used to notify other interested modules
> > > of any changes in available and occupied memory. This would happen
> > > when a module allocates or reserves memory, or frees up memory. These
> >
> > I am worried about the "frees up memory" case.
> >
> > When LMB frees memory we cannot add it back to EFI conventional memory
> > as there might still be a file image lingering around that EFI should
> > not overwrite. It has to stay marked as EfiLoaderCode or EfiLoaderData.
>
> So here is my basic doubt. Why would LMB free up memory if it still
> has a valid image. If that is the case, the lmb_free API should not be
> called?
>
> -sughosh
>
>
> >
> > How do you ensure that if a region reserved by LMB notification as
> > EfiLoaderData is coalesced with some other allocation LMB is not
> > requested to mark the coalesced region as reserved?
> >
> > @Tom
> >
> > Clinging to the existing logic that you can do anything when loading
> > files is obviously leading us into coding hell.
> >
> > If somebody wants to load two images into the same location, he should
> > be forced to unload the first image. This will allow us to have a single
> > memory management system.

It seems we really shouldn't use the words 'allocate' and 'free' when
talking about LMB. They are simply reservations. I believe we have got
into this situation due to an assumption that these two things are the
same, but in U-Boot they certainly are not. LMB is a very lighweight
and temporary reservation system to be used for a single boot process.

Regards,
Simon


> >
> > Best regards
> >
> > Heinrich
> >
> > > changes in memory map should be notified to other interested modules
> > > so that the allocated memory does not get overwritten. Add an event
> > > handler in the EFI memory module to update the EFI memory map
> > > accordingly when such changes happen. As a consequence, any subsequent
> > > memory request would honour the updated memory map and only available
> > > memory would be allocated from.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> > >   1 file changed, 58 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 435e580fb3..93244161b0 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > >   extern bool is_addr_in_ram(uintptr_t addr);
> > >
> > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                         int memory_type,
> > > +                                         bool overlap_only_ram);
> > > +
> > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >   {
> > >       struct event_efi_mem_map_update efi_map = {0};
> > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >       if (is_addr_in_ram((uintptr_t)addr))
> > >               event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > >   }
> > > +
> > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > +{
> > > +     u8 op;
> > > +     u64 addr;
> > > +     u64 pages;
> > > +     efi_status_t status;
> > > +     struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > +
> > > +     addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > +     pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > +     op = lmb_map->op;
> > > +     addr &= ~EFI_PAGE_MASK;
> > > +
> > > +     if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > +             log_debug("Invalid map update op received (%d)\n", op);
> > > +             return -1;
> > > +     }
> > > +
> > > +     status = __efi_add_memory_map_pg(addr, pages,
> > > +                                      op == MAP_OP_FREE ?
> > > +                                      EFI_CONVENTIONAL_MEMORY :
> > > +                                      EFI_BOOT_SERVICES_DATA,
> > > +                                      true);
> > > +
> > > +     return status == EFI_SUCCESS ? 0 : -1;
> > > +}
> > > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > >   #endif /* MEM_MAP_UPDATE_NOTIFY */
> > >
> > >   /**
> > > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > >       return EFI_CARVE_LOOP_AGAIN;
> > >   }
> > >
> > > -/**
> > > - * efi_add_memory_map_pg() - add pages to the memory map
> > > - *
> > > - * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > > - * @pages:           number of pages to add
> > > - * @memory_type:     type of memory added
> > > - * @overlap_only_ram:        region may only overlap RAM
> > > - * Return:           status code
> > > - */
> > > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > -                                       int memory_type,
> > > -                                       bool overlap_only_ram)
> > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                         int memory_type,
> > > +                                         bool overlap_only_ram)
> > >   {
> > >       struct list_head *lhandle;
> > >       struct efi_mem_list *newlist;
> > > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > >               }
> > >       }
> > >
> > > +     return EFI_SUCCESS;
> > > +}
> > > +
> > > +/**
> > > + * efi_add_memory_map_pg() - add pages to the memory map
> > > + *
> > > + * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > > + * @pages:           number of pages to add
> > > + * @memory_type:     type of memory added
> > > + * @overlap_only_ram:        region may only overlap RAM
> > > + * Return:           status code
> > > + */
> > > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                       int memory_type,
> > > +                                       bool overlap_only_ram)
> > > +{
> > > +     efi_status_t status;
> > > +
> > > +     status = __efi_add_memory_map_pg(start, pages, memory_type,
> > > +                                      overlap_only_ram);
> > > +     if (status != EFI_SUCCESS)
> > > +             return status;
> > > +
> > >       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > >               efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
> > >                                     memory_type == EFI_CONVENTIONAL_MEMORY ?
> >
