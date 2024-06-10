Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1338C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49268859B;
	Mon, 10 Jun 2024 17:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l+4HUhQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81193885F2; Mon, 10 Jun 2024 17:42:25 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6598D8852E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so5930454a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718034143; x=1718638943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KB5zMKDZs6CTqH8sdw+VXASpP1Z6SDoQG2FfajJXM3Q=;
 b=l+4HUhQ0Q0BGJu01ctWd852/MoE8+OQ2ERl4eGoi+1/9aHJ27rNiyI/X57GIvcxny0
 GCtXHaH1rQogzgx7DV3sav+Xlwug2WNnwhKm3HjQ1E0V4vxctzpZD/D6S1Ny0gi+EljS
 AlvmnfoiCelZAZkcz/KHKkhrOg+GAdC1ZAAEorabYbpSjmNsezJ0e4uehADYawqFvEK3
 4DB3rDsUp32XKABqWHEwWoWVWAmfDxYU6hRE3coQcOhW6Y8P2WXDCxj5MgT4zmbbWEov
 HyBYFf1oTZMnH2sw/JwgiIdeesq8NpCJ/JvUlnQ4nY0hczESvvccwYBaCLg6B8vZRIsC
 5MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034143; x=1718638943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KB5zMKDZs6CTqH8sdw+VXASpP1Z6SDoQG2FfajJXM3Q=;
 b=kDbIZq3Jok/1jSSNpqb53qN3kfUgLuIttLtunPRYco8f1Vp3x44Kc4srxExWFRfgf4
 SDckFHhfhFC7ZxEX14pZ8AqTJDzcs6Rs5cL/vZWjPCwGjB1shBHqONRg+BZnQOmUnrCL
 cuSucCIxfngxMKkGgDaeIIG0eA3OhJ5IAA1AQ16a3V6HxVNfxRNtKgfJafCDiVs9Q/sA
 DtysSxtUwm2/87MWFJteO1DGtC2Bo+LD2MRh2deNfUU32W3cV7bLPr6A5ilRXqJDGvlh
 csf5gnRJJjeE5dM1wXN0ve9qXzT+3GhhEBRP7xNqnvEUla0qWACxd7XILg9mPXDE9ULp
 FZBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP+Aqi9Mt3IMpwruFslnb4fYKxD+pi0w8IhEsYbALsC7ErPsjFyxDEhXixbbEZrFmw+BzO0cyAJK6fal1YSG7uBI+oGA==
X-Gm-Message-State: AOJu0YyfeAQkcHKrG8WjvWER77Kh6DLkd47U9GjEtLC1tZaNCcw6I0ZR
 t/nxwTaN+CHYqrtkaZpV3dO/Ww5VsDrx78xYUADwmUw1kvGXIZkdSDt2dyjp428s82HGUIZcla/
 uv8CrWvCT8lRf4ki44V65dvurajI6JI24h2m9sA==
X-Google-Smtp-Source: AGHT+IFTrXPIbidpuyyyNTcIxqzlZBYViC6UDbQh0HBkH+uS+XRXQCdCl9PyEnWh6vhLVOlAAsduQc+cGhqDk9nXQ+k=
X-Received: by 2002:a50:d718:0:b0:57c:46cb:a984 with SMTP id
 4fb4d7f45d1cf-57c50883fc4mr6059376a12.5.1718034142690; Mon, 10 Jun 2024
 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <40cf9c99-d3f5-4851-81e0-9fc7218434e8@gmx.de>
In-Reply-To: <40cf9c99-d3f5-4851-81e0-9fc7218434e8@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 21:12:11 +0530
Message-ID: <CADg8p952ieHHzeBSoyKPZ4+9pzHHEL+7w9=1Xf5WKuN2zBrBXw@mail.gmail.com>
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

On Mon, 10 Jun 2024 at 20:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.06.24 20:52, Sughosh Ganu wrote:
> > There are events that would be used to notify other interested modules
> > of any changes in available and occupied memory. This would happen
> > when a module allocates or reserves memory, or frees up memory. These
>
> I am worried about the "frees up memory" case.
>
> When LMB frees memory we cannot add it back to EFI conventional memory
> as there might still be a file image lingering around that EFI should
> not overwrite. It has to stay marked as EfiLoaderCode or EfiLoaderData.

So here is my basic doubt. Why would LMB free up memory if it still
has a valid image. If that is the case, the lmb_free API should not be
called?

-sughosh


>
> How do you ensure that if a region reserved by LMB notification as
> EfiLoaderData is coalesced with some other allocation LMB is not
> requested to mark the coalesced region as reserved?
>
> @Tom
>
> Clinging to the existing logic that you can do anything when loading
> files is obviously leading us into coding hell.
>
> If somebody wants to load two images into the same location, he should
> be forced to unload the first image. This will allow us to have a single
> memory management system.
>
> Best regards
>
> Heinrich
>
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
