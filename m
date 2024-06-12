Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9112C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 06:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098E0886EB;
	Wed, 12 Jun 2024 08:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ShxubsFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A13D886DF; Wed, 12 Jun 2024 08:46:05 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CF7886EB
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so2991221a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718174761; x=1718779561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+qM3TNHHpdNT2Wjd5sDcUzUdjbriPiQXFWy9qFBAcmc=;
 b=ShxubsFMAIMTBPHGrnYP9002GrPzuAgkgi1dA+Iaqz1g4il77ajna4lyjZCfVBuwSV
 QUHQsXtKQOb77HK/X555lnzLk/v3zGOH/AqvLqZ93K35eg+82DE8hWLxtaK8LwYWyrbA
 C4tGbk6NQ7EMGzeW+/Qtho2PeZ+hBhg8fe6OOl61ye5F64aUk4UggkldwZdtv2XN1Fqq
 N5+MYB4ltXjiR7uxGk1WRx7Vbhn6/qH1C2FdhP7aGcziReY0OUO4sNCI8mqOU79XYtWw
 c/bSek+l/KhLKj3bicRk1KBCCV4LAhenuOPIF8aMTU9Ncm+ydt5O7fqyoIH+WFFmHPAx
 QjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718174761; x=1718779561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qM3TNHHpdNT2Wjd5sDcUzUdjbriPiQXFWy9qFBAcmc=;
 b=U1j4YdpZSwK8xbhK445x7XzNaolgAt6Jp5WdrtX+lfsBkqjgCndVKk6fnvhoOcf1T0
 x3FoKZTe2/OdklUc3dt9pwbWPTuQSiuKcJRZ8Hv2Vum0pK/0leEgga/pKpCRpr2zVB68
 aKyGcHJJgbj4Dl5jheUu4KaQhE6EbrY7CkH8ersJYk8vddIkvyWIH1Htz+qlcv9OkkCA
 lSGEOxz1QyDt0Vdh6+O2OSvAJmMy3nXNMEBbG94q8wbAlNH5caOQTyo3fwqit2lw2UvZ
 Uz5a9ZnH8A7YDBk01C6Wiw0eJYQg3h59c04pqc0D5GeFpfKcgnHAlP+I0ACTkYNgjUfR
 9ung==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIy+5WVOQQZ4YvzqlJ83MDvVmsgNESUvz4RH27nj4WMtsoQLi2YZ7xMG6b7Fq5PMGqe8OOocH8ZRzheHnKqMYXcEwvFg==
X-Gm-Message-State: AOJu0Yxzfkr7MxA+Y7DXVoJJH8qlZGF9XF3ftvlvau/n8Hsh3j3uia4m
 v3qyvN71YFs4VafuX9utAJbwVv1hBpxBd/aMmFFiFCzW1udaqwklyMIpzFxlA5cMzfD7+dxWxUd
 hk0/HAoQBrfBvpoINfZp/1PQlxg3HKwJBH1yZDw==
X-Google-Smtp-Source: AGHT+IG3VhIQGxntHd1OyksQV1rvDN7aAOOaV2NALyd4KDrzjqlypettSdCYC/GufBoUVdJXL+VkSTq1PjLUjtQsWOs=
X-Received: by 2002:a05:6a21:999a:b0:1b7:577c:7180 with SMTP id
 adf61e73a8af0-1b8a9b6c908mr1164416637.12.1718174761170; Tue, 11 Jun 2024
 23:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <40cf9c99-d3f5-4851-81e0-9fc7218434e8@gmx.de>
 <CADg8p952ieHHzeBSoyKPZ4+9pzHHEL+7w9=1Xf5WKuN2zBrBXw@mail.gmail.com>
 <CAFLszTi=En1-FJ7WRpTZDhr9kzS9TNySPeSjMqfso-L6Cp_vrg@mail.gmail.com>
In-Reply-To: <CAFLszTi=En1-FJ7WRpTZDhr9kzS9TNySPeSjMqfso-L6Cp_vrg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 09:45:24 +0300
Message-ID: <CAC_iWj+hKPYNvRpVMZoF83ccVrv+jLmbivsun3WQ1RVHbJgDKg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
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

On Mon, 10 Jun 2024 at 18:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Mon, 10 Jun 2024 at 09:42, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2024 at 20:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > > There are events that would be used to notify other interested modules
> > > > of any changes in available and occupied memory. This would happen
> > > > when a module allocates or reserves memory, or frees up memory. These
> > >
> > > I am worried about the "frees up memory" case.
> > >
> > > When LMB frees memory we cannot add it back to EFI conventional memory
> > > as there might still be a file image lingering around that EFI should
> > > not overwrite. It has to stay marked as EfiLoaderCode or EfiLoaderData.
> >
> > So here is my basic doubt. Why would LMB free up memory if it still
> > has a valid image. If that is the case, the lmb_free API should not be
> > called?
> >
> > -sughosh
> >
> >
> > >
> > > How do you ensure that if a region reserved by LMB notification as
> > > EfiLoaderData is coalesced with some other allocation LMB is not
> > > requested to mark the coalesced region as reserved?
> > >
> > > @Tom
> > >
> > > Clinging to the existing logic that you can do anything when loading
> > > files is obviously leading us into coding hell.
> > >
> > > If somebody wants to load two images into the same location, he should
> > > be forced to unload the first image. This will allow us to have a single
> > > memory management system.
>
> It seems we really shouldn't use the words 'allocate' and 'free' when
> talking about LMB. They are simply reservations.

Correct and while at it can we please make the code less confusing to
read. What we today mark as reserved isnt even trully reserved as it
can be overwritten.
struct lmb_region memory -> available memory we added on LMB. That's fine
struct lmb_region reserved -> can we rename this to 'used' and rename
LMB_NOOVERWRITE to LMB_RESERVED?

Thanks
/Ilias

> I believe we have got
> into this situation due to an assumption that these two things are the
> same, but in U-Boot they certainly are not. LMB is a very lighweight
> and temporary reservation system to be used for a single boot process.
>
> Regards,
> Simon
>
>
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > > changes in memory map should be notified to other interested modules
> > > > so that the allocated memory does not get overwritten. Add an event
> > > > handler in the EFI memory module to update the EFI memory map
> > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > memory request would honour the updated memory map and only available
> > > > memory would be allocated from.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> > > >   1 file changed, 58 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > index 435e580fb3..93244161b0 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > >   extern bool is_addr_in_ram(uintptr_t addr);
> > > >
> > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                         int memory_type,
> > > > +                                         bool overlap_only_ram);
> > > > +
> > > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > >   {
> > > >       struct event_efi_mem_map_update efi_map = {0};
> > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > >       if (is_addr_in_ram((uintptr_t)addr))
> > > >               event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > > >   }
> > > > +
> > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > > +{
> > > > +     u8 op;
> > > > +     u64 addr;
> > > > +     u64 pages;
> > > > +     efi_status_t status;
> > > > +     struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > > +
> > > > +     addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > +     pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > > +     op = lmb_map->op;
> > > > +     addr &= ~EFI_PAGE_MASK;
> > > > +
> > > > +     if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > > +             log_debug("Invalid map update op received (%d)\n", op);
> > > > +             return -1;
> > > > +     }
> > > > +
> > > > +     status = __efi_add_memory_map_pg(addr, pages,
> > > > +                                      op == MAP_OP_FREE ?
> > > > +                                      EFI_CONVENTIONAL_MEMORY :
> > > > +                                      EFI_BOOT_SERVICES_DATA,
> > > > +                                      true);
> > > > +
> > > > +     return status == EFI_SUCCESS ? 0 : -1;
> > > > +}
> > > > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > > >   #endif /* MEM_MAP_UPDATE_NOTIFY */
> > > >
> > > >   /**
> > > > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> > > >       return EFI_CARVE_LOOP_AGAIN;
> > > >   }
> > > >
> > > > -/**
> > > > - * efi_add_memory_map_pg() - add pages to the memory map
> > > > - *
> > > > - * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > > > - * @pages:           number of pages to add
> > > > - * @memory_type:     type of memory added
> > > > - * @overlap_only_ram:        region may only overlap RAM
> > > > - * Return:           status code
> > > > - */
> > > > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > -                                       int memory_type,
> > > > -                                       bool overlap_only_ram)
> > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                         int memory_type,
> > > > +                                         bool overlap_only_ram)
> > > >   {
> > > >       struct list_head *lhandle;
> > > >       struct efi_mem_list *newlist;
> > > > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > >               }
> > > >       }
> > > >
> > > > +     return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +/**
> > > > + * efi_add_memory_map_pg() - add pages to the memory map
> > > > + *
> > > > + * @start:           start address, must be a multiple of EFI_PAGE_SIZE
> > > > + * @pages:           number of pages to add
> > > > + * @memory_type:     type of memory added
> > > > + * @overlap_only_ram:        region may only overlap RAM
> > > > + * Return:           status code
> > > > + */
> > > > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > +                                       int memory_type,
> > > > +                                       bool overlap_only_ram)
> > > > +{
> > > > +     efi_status_t status;
> > > > +
> > > > +     status = __efi_add_memory_map_pg(start, pages, memory_type,
> > > > +                                      overlap_only_ram);
> > > > +     if (status != EFI_SUCCESS)
> > > > +             return status;
> > > > +
> > > >       if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > > >               efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
> > > >                                     memory_type == EFI_CONVENTIONAL_MEMORY ?
> > >
