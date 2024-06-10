Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AFEC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147A7885A0;
	Mon, 10 Jun 2024 16:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E240iCWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4157B8822D; Mon, 10 Jun 2024 16:52:36 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD69A88572
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6f06699ae4so97086666b.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031153; x=1718635953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5CvaIGcwczezXwTfPagBHrai72jIw3QzOjkjQiVG/rY=;
 b=E240iCWVxzAdGzHDbPYjGKtbKZJurlQRr1BSCBx7VqmDbShX0t6eBJMlGhrAJkgjKM
 UDkNLkvJKqi4kGqOVOFE2WMS+ICp+PWMUev0Fb/PqgsqD1Rdc6ZS/JjGL/W79MtAVKJT
 cihmNscTFcAaX2+AUfpnXmB1uDPeVwgm6d5UglmjSkGn76siM4eEbKBKk/b+Pia6UkSz
 IHCbRTYw8kGdR8V5wL987++1e9CcSMSwIYvihvkg45+QasSDYotAfLuatEQLegRn5A4a
 t+07OcH0uY1QUUN3ETU/63H6pkZKq9f45fkHn5a0AWyhTl4oTG2m5201TCiwSFoiAV26
 vzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031153; x=1718635953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CvaIGcwczezXwTfPagBHrai72jIw3QzOjkjQiVG/rY=;
 b=W7g/5dH2JddD/u/9wAoM71c7M6l87B1hbhdICUKRoTocmaetQ5rpZTHqCiSkwtRSXY
 9FSWIefIV7E5nbfyYYiNHLZikfTghVJkFx29pvRrs5zXXJDx4TvbJCBKQvH0wdAuqUoD
 eFlx4k/bRWWGSWcIGOyR+ri8VO4xQrilpTK2R4mVOiazprvs1FLfvAUchy2CRUbRG29i
 WvaGTJZ4V1W3EseXi0g/VpQ3tae7WX/pDg1gwTmxphyg64Pu91HQpY1Oy7nSRMPbGUiI
 S8iWHI8RE5eWrxmS9jhUvQWkvePbCeTg4E4WBsOGzq4RDKR8q5Ax8YWzHqJXGx9SV/Qq
 ZPDg==
X-Gm-Message-State: AOJu0YwF92tC+Bw/VhR0WsbnUJf3yqO5+uP3j6bikFNcjxl4HfJ6Y322
 /nvWBWrT3FPX8hkikeaSbTcAkMmrYrKH8DlkPKFiZOsrUZZ+PFisS/g+lk215zEVs0PehGLQKpI
 RYb0w+K2kgQ29Nq5NAvCOfuAxiULNElphvgna1w==
X-Google-Smtp-Source: AGHT+IGEclR4SIdRqasNGDp7WdD9ekpPFxqQdj59UBgX7H+UuYfSIILivLiMBTIzPIo9NjoCs/A+0W+WPWhicmIbUyU=
X-Received: by 2002:a50:99c9:0:b0:573:55cc:2f50 with SMTP id
 4fb4d7f45d1cf-57c509bd35fmr7724729a12.37.1718031150549; Mon, 10 Jun 2024
 07:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <CAC_iWjJB4t_SAuEoJwTdUR=d+N_PZhXEBx6jMW+n1OQzREVNvQ@mail.gmail.com>
 <CADg8p94H6d3cPQzw8Xgc5r6vTat1SKAu3xY1BZcYNyPYrmjX7A@mail.gmail.com>
 <CAC_iWj+S1MHjwH1zvT=rz+agwxXWef6SFG7Kipg4bCNFn7oabg@mail.gmail.com>
In-Reply-To: <CAC_iWj+S1MHjwH1zvT=rz+agwxXWef6SFG7Kipg4bCNFn7oabg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 20:22:19 +0530
Message-ID: <CADg8p94_C=1qYQW0=qgFBvoMVOWOM3U66pjfR_Q+_HYw-+KfAA@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

hi Ilias,

On Mon, 10 Jun 2024 at 19:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Mon, 10 Jun 2024 at 15:25, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2024 at 17:40, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > There are events that would be used to notify other interested modules
> > > > of any changes in available and occupied memory. This would happen
> > > > when a module allocates or reserves memory, or frees up memory. These
> > > > changes in memory map should be notified to other interested modules
> > > > so that the allocated memory does not get overwritten. Add an event
> > > > handler in the EFI memory module to update the EFI memory map
> > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > memory request would honour the updated memory map and only available
> > > > memory would be allocated from.
> > >
> > > So the question here, is why do we need a notifier chain overall?
> > > Can't we change the EFI subsystem and allocate memory with lmb now?
> > > And any special functions we have in EFI (e.g allocate aligned memory)
> > > can migrate to lmb()
> >
> > Like we discussed offline, that was my initial attempt -- to use the
> > LMB allocation API's from inside the EFI allocate pages module. But I
> > was facing a lot of corner case issues, primarily in keeping the two
> > memory maps the same.
>
> I think it would worth discussing this a bit more. I like the idea of
> having a single allocator more than having events to update memory
> reservations
>
> > Which is why I moved to the current
> > implementation of notifying other modules, and that too only for the
> > addresses in the RAM region.
>
> The notification to 'other modules' i still done by updating the
> static memory map though no?
> So what corner cases we couldn't solve by having a single allocator?

I can re-check what were the issues that I faced when trying with a
single allocator. But please note that we are not making any
significant gains by having a single allocator. Even with a common
allocator(say LMB), it would still be required to have the same
notification mechanism to update the EFI memory map. Else the EFI
memory map would show regions of memory as conventional memory, while
they are being used by the other subsystem. So, all in all, I think
that the notification mechanism is not that inefficient. Thanks.

-sughosh

>
> Thanks
> /Ilias
> >
> > -sughosh
> >
> > >
> > > Cheers
> > > /Ilias
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 58 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > index 435e580fb3..93244161b0 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > >  #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > >  extern bool is_addr_in_ram(uintptr_t addr);
> > > >
> > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                           int memory_type,
> > > > +                                           bool overlap_only_ram);
> > > > +
> > > >  static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > >  {
> > > >         struct event_efi_mem_map_update efi_map = {0};
> > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > >         if (is_addr_in_ram((uintptr_t)addr))
> > > >                 event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > > >  }
> > > > +
> > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > > +{
> > > > +       u8 op;
> > > > +       u64 addr;
> > > > +       u64 pages;
> > > > +       efi_status_t status;
> > > > +       struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > > +
> > > > +       addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > +       pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > > +       op = lmb_map->op;
> > > > +       addr &= ~EFI_PAGE_MASK;
> > > > +
> > > > +       if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > > +               log_debug("Invalid map update op received (%d)\n", op);
> > > > +               return -1;
> > > > +       }
> > > > +
> > > > +       status = __efi_add_memory_map_pg(addr, pages,
> > > > +                                        op == MAP_OP_FREE ?
> > > > +                                        EFI_CONVENTIONAL_MEMORY :
> > > > +                                        EFI_BOOT_SERVICES_DATA,
> > > > +                                        true);
> > > > +
> > > > +       return status == EFI_SUCCESS ? 0 : -1;
> > > > +}
> > > > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > > >  #endif /* MEM_MAP_UPDATE_NOTIFY */
> > > >
> > > >  /**
> > > > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > > >         return EFI_CARVE_LOOP_AGAIN;
> > > >  }
> > > >
> > > > -/**
> > > > - * efi_add_memory_map_pg() - add pages to the memory map
> > > > - *
> > > > - * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > > > - * @pages:             number of pages to add
> > > > - * @memory_type:       type of memory added
> > > > - * @overlap_only_ram:  region may only overlap RAM
> > > > - * Return:             status code
> > > > - */
> > > > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > -                                         int memory_type,
> > > > -                                         bool overlap_only_ram)
> > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                           int memory_type,
> > > > +                                           bool overlap_only_ram)
> > > >  {
> > > >         struct list_head *lhandle;
> > > >         struct efi_mem_list *newlist;
> > > > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > >                 }
> > > >         }
> > > >
> > > > +       return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +/**
> > > > + * efi_add_memory_map_pg() - add pages to the memory map
> > > > + *
> > > > + * @start:             start address, must be a multiple of EFI_PAGE_SIZE
> > > > + * @pages:             number of pages to add
> > > > + * @memory_type:       type of memory added
> > > > + * @overlap_only_ram:  region may only overlap RAM
> > > > + * Return:             status code
> > > > + */
> > > > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                         int memory_type,
> > > > +                                         bool overlap_only_ram)
> > > > +{
> > > > +       efi_status_t status;
> > > > +
> > > > +       status = __efi_add_memory_map_pg(start, pages, memory_type,
> > > > +                                        overlap_only_ram);
> > > > +       if (status != EFI_SUCCESS)
> > > > +               return status;
> > > > +
> > > >         if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > > >                 efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
> > > >                                       memory_type == EFI_CONVENTIONAL_MEMORY ?
> > > > --
> > > > 2.34.1
> > > >
