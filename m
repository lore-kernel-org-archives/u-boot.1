Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FACDC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C068855C;
	Mon, 10 Jun 2024 16:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wVwKQ7gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B666F88577; Mon, 10 Jun 2024 16:18:36 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430428855C
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c702226b0aso4024140a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718029113; x=1718633913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H8eHqdPjga4UIAjpUo0Xa38OhIgeRDnlfteRQYP/KcI=;
 b=wVwKQ7gm65nyMQozpRUkxXjcGen8R+TNv2aWsW8p60oXlIOuVqOn/+F7Qu23W83DgS
 EoV8NN9W+85HtMKiz3r4odqe/frID08NhRTQI+L85zDJOvDbp/EFHNwddE9UtJsLiDl9
 MgXAZbkGXHNAEKome/GWbAjQHXJxeCyFfztVUfW1A2KhA/ippVQidNBqUPvAbEwVQm7B
 ASRmu0vEGOK6Y6BhuaIpQFeFBo6OA6wFNEfZeDJwwiVDFGVGqdpTC1xVC7vv4ihcHuw8
 wOIJ4CALzO3DNzA8kSTdH8Q5WcbGNz8McETEKbHu7iyeuGaIQHIYTfw5bLRM7S5iZ/mL
 QWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718029113; x=1718633913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H8eHqdPjga4UIAjpUo0Xa38OhIgeRDnlfteRQYP/KcI=;
 b=uAM5UbdItyz6fgN42Tamuz5JvOVJP0/yWyW9QrdXubggfcWXD+32krUTMs3IYXQVCN
 To0L/e/djW3WTlmzNZnYRNyECR5uDD9mwmdTEZGoxXgT6cCA40xWWoApOl6PGiyboDWG
 1bnvXDm641kX8Yd84D641/T6e4npCLqs6taVpEV+W9iLFquAH+s/QdrnawXXP0QdjYWS
 wJ6hrlPmOv1SoB0cQot0zGqtd/gJOsoUHo2fuXDn2cfXJEATijlQT//T8wOGe1TnGjex
 XM6aFD0GJClmbpMVnxxT3gF7MXja6QMh08OqC3u3ees4Dy4EK9LkUt0QdV+aIs74k6+6
 g+rQ==
X-Gm-Message-State: AOJu0Yz4tO0uKjGaA9B3PGPXFSsaQDRVoVJOIoUILeN8BVKM/fkH+s9t
 XaI3VJA5WtiemAgSGlMu7b/JpesZ7JBMepOnM1ptBULu+KfD+jhT+5wBjGvqDKJoACm/bQQUFQF
 f9els+r5j6nSS/XcjyGG1ymxwZ0VxESD5KtmPZQ==
X-Google-Smtp-Source: AGHT+IELyvFbqud1NakF5D+SR4jG5s5EDXJPvknh12CiIJfwrqEE/Kk7H8xsZjCztPZTxvC90Y5FfoygM1Kdq5Wtsd0=
X-Received: by 2002:a17:903:234f:b0:1f7:2051:18bf with SMTP id
 d9443c01a7336-1f720511c77mr16654125ad.3.1718029112626; Mon, 10 Jun 2024
 07:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <CAC_iWjJB4t_SAuEoJwTdUR=d+N_PZhXEBx6jMW+n1OQzREVNvQ@mail.gmail.com>
 <CADg8p94H6d3cPQzw8Xgc5r6vTat1SKAu3xY1BZcYNyPYrmjX7A@mail.gmail.com>
In-Reply-To: <CADg8p94H6d3cPQzw8Xgc5r6vTat1SKAu3xY1BZcYNyPYrmjX7A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 17:17:56 +0300
Message-ID: <CAC_iWj+S1MHjwH1zvT=rz+agwxXWef6SFG7Kipg4bCNFn7oabg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

Hi Sughosh

On Mon, 10 Jun 2024 at 15:25, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 10 Jun 2024 at 17:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > There are events that would be used to notify other interested modules
> > > of any changes in available and occupied memory. This would happen
> > > when a module allocates or reserves memory, or frees up memory. These
> > > changes in memory map should be notified to other interested modules
> > > so that the allocated memory does not get overwritten. Add an event
> > > handler in the EFI memory module to update the EFI memory map
> > > accordingly when such changes happen. As a consequence, any subsequent
> > > memory request would honour the updated memory map and only available
> > > memory would be allocated from.
> >
> > So the question here, is why do we need a notifier chain overall?
> > Can't we change the EFI subsystem and allocate memory with lmb now?
> > And any special functions we have in EFI (e.g allocate aligned memory)
> > can migrate to lmb()
>
> Like we discussed offline, that was my initial attempt -- to use the
> LMB allocation API's from inside the EFI allocate pages module. But I
> was facing a lot of corner case issues, primarily in keeping the two
> memory maps the same.

I think it would worth discussing this a bit more. I like the idea of
having a single allocator more than having events to update memory
reservations

> Which is why I moved to the current
> implementation of notifying other modules, and that too only for the
> addresses in the RAM region.

The notification to 'other modules' i still done by updating the
static memory map though no?
So what corner cases we couldn't solve by having a single allocator?

Thanks
/Ilias
>
> -sughosh
>
> >
> > Cheers
> > /Ilias
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> > >  1 file changed, 58 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > index 435e580fb3..93244161b0 100644
> > > --- a/lib/efi_loader/efi_memory.c
> > > +++ b/lib/efi_loader/efi_memory.c
> > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > >  #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > >  extern bool is_addr_in_ram(uintptr_t addr);
> > >
> > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                           int memory_type,
> > > +                                           bool overlap_only_ram);
> > > +
> > >  static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >  {
> > >         struct event_efi_mem_map_update efi_map = {0};
> > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >         if (is_addr_in_ram((uintptr_t)addr))
> > >                 event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > >  }
> > > +
> > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > +{
> > > +       u8 op;
> > > +       u64 addr;
> > > +       u64 pages;
> > > +       efi_status_t status;
> > > +       struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > +
> > > +       addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > +       pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > +       op = lmb_map->op;
> > > +       addr &= ~EFI_PAGE_MASK;
> > > +
> > > +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > +               log_debug("Invalid map update op received (%d)\n", op);
> > > +               return -1;
> > > +       }
> > > +
> > > +       status = __efi_add_memory_map_pg(addr, pages,
> > > +                                        op == MAP_OP_FREE ?
> > > +                                        EFI_CONVENTIONAL_MEMORY :
> > > +                                        EFI_BOOT_SERVICES_DATA,
> > > +                                        true);
> > > +
> > > +       return status == EFI_SUCCESS ? 0 : -1;
> > > +}
> > > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > >  #endif /* MEM_MAP_UPDATE_NOTIFY */
> > >
> > >  /**
> > > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > >         return EFI_CARVE_LOOP_AGAIN;
> > >  }
> > >
> > > -/**
> > > - * efi_add_memory_map_pg() - add pages to the memory map
> > > - *
> > > - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > > - * @pages:             number of pages to add
> > > - * @memory_type:       type of memory added
> > > - * @overlap_only_ram:  region may only overlap RAM
> > > - * Return:             status code
> > > - */
> > > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > -                                         int memory_type,
> > > -                                         bool overlap_only_ram)
> > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                           int memory_type,
> > > +                                           bool overlap_only_ram)
> > >  {
> > >         struct list_head *lhandle;
> > >         struct efi_mem_list *newlist;
> > > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > >                 }
> > >         }
> > >
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +/**
> > > + * efi_add_memory_map_pg() - add pages to the memory map
> > > + *
> > > + * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > > + * @pages:             number of pages to add
> > > + * @memory_type:       type of memory added
> > > + * @overlap_only_ram:  region may only overlap RAM
> > > + * Return:             status code
> > > + */
> > > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > +                                         int memory_type,
> > > +                                         bool overlap_only_ram)
> > > +{
> > > +       efi_status_t status;
> > > +
> > > +       status = __efi_add_memory_map_pg(start, pages, memory_type,
> > > +                                        overlap_only_ram);
> > > +       if (status != EFI_SUCCESS)
> > > +               return status;
> > > +
> > >         if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > >                 efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
> > >                                       memory_type == EFI_CONVENTIONAL_MEMORY ?
> > > --
> > > 2.34.1
> > >
