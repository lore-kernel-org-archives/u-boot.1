Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64117C27C79
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC168874B;
	Wed, 12 Jun 2024 04:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X94dQM2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29A988176; Wed, 12 Jun 2024 04:42:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9888874B
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 04:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b0825b8421so13783756d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 19:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718160131; x=1718764931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2d9XBKNwaZh85kg8BoPRiaTh/2mfGd3G/OMG3ZTOWBY=;
 b=X94dQM2QL/aJk4p1sczg5/uAQHOtqMeJfAGizO4xBBEvZhoZHe4jOWFsrdquaJ3kDU
 QmJNFpUQ05HqnWBrk1iOMHqTNivXnjP2BYOkUq4ZNiOTdBgrCF+Ie1rj88k52HBMBkUk
 rZzaTYFLpc3TP+DnbSgjLdhJsQh1jg2pebuK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718160131; x=1718764931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2d9XBKNwaZh85kg8BoPRiaTh/2mfGd3G/OMG3ZTOWBY=;
 b=tqX/CBMhFiEMj6qBjQYJjsua6MHQ1h8EwJW8b8EPVzKNTkV8Yj3jUGulmMyFNTXVZ4
 1ajb6TlEkC8LzZeeO2pqvsGDjQBbVmgh7oKhbXK0dBn8A9tDeDVJgfY/55F4J5aTuCqR
 lTfWvvhds324/DL14Ti6EH7Ata1YmLgKCJNgl52+Nd9rkOkrLzzO7A8DODISqQXqvprD
 ObZPhlXXZqusWNlqoe/K7RiLAhCrGFHPSyaAS+VJ4MIB+AmHf21cpOjhSWk6Y0v/YRoL
 co8XG/S9KmeT7MRVwP706cTp6zPkPYick3DeCqlPugKMY3CGDe2WMQk74KEEGQ8EA2pc
 gnjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCGlTQ5AbXGhKtuVT3w4yBmNbTOLH8EXXKt/p3YozGn7O5EVPGJ9YoJKjamgszaWKW+yb6vlOtl7JGt7MxrO4rLnjiTQ==
X-Gm-Message-State: AOJu0YwqF40bkLAPeKD1FAPGrLzaGTZpsHPXcFa4mT/mLr29LQnStSG5
 AJkpNdBbxji48gfdh1Jf82QYynrpemOKZotPlbatepkaXHg/ZjwxHlQBGlcYxuuQJAfvQlkIhkK
 GZZjb+/yhqpBwNya98NeBNiEnqCZb0HmoIxdQ
X-Google-Smtp-Source: AGHT+IEceUfcVJrLLOOQ2klbzBsBBw4kMItnJGzBEoh2q5/Q13GvYPo5Q3Ps0pligsaAhoMgM4GPEgL+VRA1M/WGT3Q=
X-Received: by 2002:a05:6214:4986:b0:6b0:8789:ae2e with SMTP id
 6a1803df08f44-6b191f32bbdmr4932986d6.23.1718160131205; Tue, 11 Jun 2024
 19:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
 <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
 <20240611210138.GL68077@bill-the-cat>
 <CAFLszThcanoRd=8A8wq0RWzSHerPPZxYdvyT8AjLNfH1QvyDiw@mail.gmail.com>
 <20240611225417.GN68077@bill-the-cat>
In-Reply-To: <20240611225417.GN68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 20:42:00 -0600
Message-ID: <CAFLszTjm_k6DLCZcMCevf78-K7MsiqWGq5ONxowDVMpRe_XB7g@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Hi Tom,

On Tue, 11 Jun 2024 at 16:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 04:22:25PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 11 Jun 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 11, 2024 at 12:52:19PM -0600, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Tue, 11 Jun 2024 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt wrote:
> > > > > > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > > > > > There are events that would be used to notify other interested modules
> > > > > > > of any changes in available and occupied memory. This would happen
> > > > > > > when a module allocates or reserves memory, or frees up memory. These
> > > > > > > changes in memory map should be notified to other interested modules
> > > > > > > so that the allocated memory does not get overwritten. Add an event
> > > > > > > handler in the EFI memory module to update the EFI memory map
> > > > > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > > > > memory request would honour the updated memory map and only available
> > > > > > > memory would be allocated from.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > >   lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
> > > > > > >   1 file changed, 58 insertions(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > > > index 435e580fb3..93244161b0 100644
> > > > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > > > > >   #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > > > > >   extern bool is_addr_in_ram(uintptr_t addr);
> > > > > > >
> > > > > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
> > > > > > > +                                       int memory_type,
> > > > > > > +                                       bool overlap_only_ram);
> > > > > > > +
> > > > > > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > > > > >   {
> > > > > > >     struct event_efi_mem_map_update efi_map = {0};
> > > > > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > > > > >     if (is_addr_in_ram((uintptr_t)addr))
> > > > > > >             event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > > > > > >   }
> > > > > > > +
> > > > > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > > > > > +{
> > > > > > > +   u8 op;
> > > > > > > +   u64 addr;
> > > > > > > +   u64 pages;
> > > > > > > +   efi_status_t status;
> > > > > > > +   struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > > > > > +
> > > > > > > +   addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > > > > +   pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > > > > > +   op = lmb_map->op;
> > > > > > > +   addr &= ~EFI_PAGE_MASK;
> > > > > > > +
> > > > > > > +   if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > > > > > +           log_debug("Invalid map update op received (%d)\n", op);
> > > > > > > +           return -1;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   status = __efi_add_memory_map_pg(addr, pages,
> > > > > > > +                                    op == MAP_OP_FREE ?
> > > > > > > +                                    EFI_CONVENTIONAL_MEMORY :
> > > > > >
> > > > > > This is dangerous. LMB might turn memory that is marked as
> > > > > > EfiReservedMemory which the OS must respect into EfiBootServicesData
> > > > > > which the OS may discard.
> > > > > >
> > > > > > E.g. initr_lmb() is being called after efi_memory_init().
> > > > > >
> > > > > > Getting all cases of synchronization properly tested seems very hard to
> > > > > > me. Everything would be much easier if we had only a single memory
> > > > > > management system.
> > > > >
> > > > > Yes, Sughosh is working on the single memory reservation system for
> > > > > everyone to use. This pairs with the single memory allocation system
> > > > > (malloc) that we have. Parts of the code base that aren't keeping these
> > > > > systems up to date / obeying their results need to be corrected.
> > > >
> > > > The EFI allocations don't happen until boot time...so why do we need
> > > > to do this now? We can instead have an EFI function to scan LMB and
> > > > add to its memory map.
> > >
> > > We're talking about reservations, not allocations. So yes, when someone
> > > is making their reservation, they need to make it. I don't understand
> > > your question.
> >
> > As I understand it, this is used to tell EFI about a memory reservation.
>
> This patch, or this series? This series isn't about EFI. This patch is,
> yes.
>
> > But the EFI code can scan the LMB reservations just before booting and
> > update its tables. I don't see a need to keep them in sync before the
> > boot actually happens.
>
> But that wouldn't work. If something needs to reserve a region it needs
> to do it when it starts using it. It's not about the EFI map for the OS,
> it's about making sure that U-Boot doesn't scribble over a now-reserved
> area.

I'm not convinced of that yet. EFI does not do allocations until it
starts loading images, and it uses LMB for those (or at least it does
with bootstd). I'm just trying to keep this all as simple as possible.

Regards,
Simon
