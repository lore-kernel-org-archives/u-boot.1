Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F13C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 10:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D520885D7;
	Tue, 11 Jun 2024 12:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kZGbmyYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0137388282; Tue, 11 Jun 2024 12:27:38 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B85885D7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c923e03caso877267a12.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718101655; x=1718706455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zow1aYbrclHAhr7lH20UpY9divM7SNxY+yufxxzpGsY=;
 b=kZGbmyYhZiyvWIoinn/BTcg0ddWX2oB5BjuZhvsdyOxL/a+UvVdncA8l/mGRFuIDRK
 lo/Pty52me9ldlUSoVTCO4+YBJ7R5j08+CsLrjteHssjXa13558awA/1lKDjRePmR1I9
 ePLiQNL5AX0hfs9ITy1Mo4Lb0fdlXpkvO6urWrNXHio1lGRQDDIu/oUCB4CRx5ShJYVd
 9ZTJpwsDcRmmh4D1zvoMLOY+vZv2RYEkb8AICCSBDg7RWH8OJZaRMAAGemt4YIExCL8L
 k2WlDOVrJ5wA2t8OZfzSpmho85o/pGHGaM2xev42yJcZRApDDciKf6dLk5A313sl4646
 x/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718101655; x=1718706455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zow1aYbrclHAhr7lH20UpY9divM7SNxY+yufxxzpGsY=;
 b=pytZtP0stuFAd1wbT+qFVk6pRs87I8sFeQ+XN24mdWq4aNnGcpoDYlymfDRDk1zroG
 tPE32V1ogZDBRDBneUXpd9wNRH0QgTNYh1qhl7VtpbLJfoc7ZwQIIiA265tb83INX88H
 Pd5ZzBA1Hp/zdD5qVL+YFnvKmjyqOv0blL2qYwzn2QdnPuOHjBiYBPV15znKDqeC8mig
 Y9L0ehbJzz9tdk+84/1R4zhqwrZ0fgU9NiD6HcU70VeXsNUs3ytDHvTbBz2EV/2ecGVA
 2gRGrUJkSBv1OV624uOSOXkwrTHaqob3VzJB2XKH4j6Ks/cmZgr+CMnZlbMkOwsROzYX
 KR+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJrbGudGOl/4ghhEYi8yuBEJz5djUS8G2VsegZndFFGKSwHVQLLeD3N5EOw3XK7e9fe2y8G+DhKH24dZdcNiWtwPx1w==
X-Gm-Message-State: AOJu0YzA8KfuENogeBwQxumuEMrLtXCbUtZZMAgFEtKb7LPwypohTNqn
 ms7ArWrsgOzHISYa/dsuhV2mBXbJf+2TRZ8n4B98JrUJf6bud5pQqgNe+jdPY6nGHPugeAlOdL2
 NCOdCobOKzeo1QUmrW1Hdh2KBsWIeN+3d8Wt7ex3Z6/1n44Gz
X-Google-Smtp-Source: AGHT+IGp/pK87XVyGl0BHgGrl4/T02q39GJ57MpPe0RtDsOSHI7XXMgf6gjKF71UnsAJ+ZPEDLh/22Fta/8re931MTI=
X-Received: by 2002:a50:c047:0:b0:57c:47c3:dc62 with SMTP id
 4fb4d7f45d1cf-57c50829346mr7010484a12.5.1718101655283; Tue, 11 Jun 2024
 03:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
In-Reply-To: <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 15:57:24 +0530
Message-ID: <CADg8p96MKfzfP1K5dqS_h+EA18H+dS_e3TuVyrRzOPTJ3stH=g@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
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

On Tue, 11 Jun 2024 at 15:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.06.24 20:52, Sughosh Ganu wrote:
> > There are events that would be used to notify other interested modules
> > of any changes in available and occupied memory. This would happen
> > when a module allocates or reserves memory, or frees up memory. These
> > changes in memory map should be notified to other interested modules
> > so that the allocated memory does not get overwritten. Add an event
> > handler in the EFI memory module to update the EFI memory map
> > accordingly when such changes happen. As a consequence, any subsequent
> > memory request would honour the updated memory map and only available
> > memory would be allocated from.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> >   1 file changed, 58 insertions(+), 12 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 435e580fb3..93244161b0 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> >   extern bool is_addr_in_ram(uintptr_t addr);
> >
> > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > +                                         int memory_type,
> > +                                         bool overlap_only_ram);
> > +
> >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> >   {
> >       struct event_efi_mem_map_update efi_map = {0};
> > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> >       if (is_addr_in_ram((uintptr_t)addr))
> >               event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> >   }
> > +
> > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > +{
> > +     u8 op;
> > +     u64 addr;
> > +     u64 pages;
> > +     efi_status_t status;
> > +     struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > +
> > +     addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > +     pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > +     op = lmb_map->op;
> > +     addr &= ~EFI_PAGE_MASK;
> > +
> > +     if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > +             log_debug("Invalid map update op received (%d)\n", op);
> > +             return -1;
> > +     }
> > +
> > +     status = __efi_add_memory_map_pg(addr, pages,
> > +                                      op == MAP_OP_FREE ?
> > +                                      EFI_CONVENTIONAL_MEMORY :
>
> This is dangerous. LMB might turn memory that is marked as
> EfiReservedMemory which the OS must respect into EfiBootServicesData
> which the OS may discard.

If memory is being marked as EfiReservedMemory, that will also update
the LMB memory map to have it marked as reserved. So a correct
implementation should then not be freeing memory that is not allocated
by that module.

-sughosh

>
> E.g. initr_lmb() is being called after efi_memory_init().
>
> Getting all cases of synchronization properly tested seems very hard to
> me. Everything would be much easier if we had only a single memory
> management system.
>
> Best regards
>
> Heinrich
>
> > +                                      EFI_BOOT_SERVICES_DATA,
> > +                                      true);
> > +
> > +     return status == EFI_SUCCESS ? 0 : -1;
> > +}
> > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> >   #endif /* MEM_MAP_UPDATE_NOTIFY */
> >
> >   /**
> > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >       return EFI_CARVE_LOOP_AGAIN;
> >   }
> >
> > -/**
> > - * efi_add_memory_map_pg() - add pages to the memory map
> > - *
> > - * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > - * @pages:           number of pages to add
> > - * @memory_type:     type of memory added
> > - * @overlap_only_ram:        region may only overlap RAM
> > - * Return:           status code
> > - */
> > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > -                                       int memory_type,
> > -                                       bool overlap_only_ram)
> > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > +                                         int memory_type,
> > +                                         bool overlap_only_ram)
> >   {
> >       struct list_head *lhandle;
> >       struct efi_mem_list *newlist;
> > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >               }
> >       }
> >
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +/**
> > + * efi_add_memory_map_pg() - add pages to the memory map
> > + *
> > + * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > + * @pages:           number of pages to add
> > + * @memory_type:     type of memory added
> > + * @overlap_only_ram:        region may only overlap RAM
> > + * Return:           status code
> > + */
> > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > +                                       int memory_type,
> > +                                       bool overlap_only_ram)
> > +{
> > +     efi_status_t status;
> > +
> > +     status = __efi_add_memory_map_pg(start, pages, memory_type,
> > +                                      overlap_only_ram);
> > +     if (status != EFI_SUCCESS)
> > +             return status;
> > +
> >       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> >               efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
> >                                     memory_type == EFI_CONVENTIONAL_MEMORY ?
>
