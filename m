Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E0EC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06098877C;
	Tue, 11 Jun 2024 20:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LJ1tFP5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32CE88746; Tue, 11 Jun 2024 20:52:34 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA9928874C
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7954f8b818fso84801985a.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131950; x=1718736750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qr/UfvdPRiDtIDsR0IUhyf1GSyYxxhFgQscEflMxDWg=;
 b=LJ1tFP5mmFWk9BY8h4jj0EtaoCLE1mpXTSzM263JCl7xh5hNBY/XUTvRGz0/ixxveM
 AYLdRKIIKTf7JK5AwrOumzdEBvrD0ZXxSoaQry6JARkfal8HkOvcV7Qk4tRVyO7GSjP7
 AgRqGpBZ3yM56ZwTC43XtMnMVy+hofuJ2zXCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131950; x=1718736750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qr/UfvdPRiDtIDsR0IUhyf1GSyYxxhFgQscEflMxDWg=;
 b=nhAMkeOtsbqgJwmcdqzoVH+BdszrLYAIjs8/OKl3D1OYRzpoNs9Y50IGPXS34A7c5B
 70fiF/6I/VjSZAnoSsejhQ4ErIbkMDEIYoBGwp/rVCwa41CagzRO/JnqOfSTC+daRnuO
 L9U6xpuR3rZEMmuMvr8pFdLIz/khKdN1anFLgMJt3G/IGTteMwCpnr/F2qEbnNJP3IFG
 pFmyUs7MIWUVVBaHTSeAyi03+crbmNw5gMyFgom3PDml5O+ywIFKGs9zQmazIafvshRw
 iBwGR39oDAgNdWniUax/ReNeNJV7h+8NhluHwtkaBYq1ccvFaiNKfmaYQ78hGA77MRpG
 kxFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc9HvmG+EAPEYvanDu1guSoYZ3JEISXZFeeDXV99dABDpnNjw+aF8wHVhvk39CRuF8Wl8DR6kwh31qjXPNNuQs8iPfXg==
X-Gm-Message-State: AOJu0YyGxpWVtW8GQmQUp+EZYL5UAjgGKkOmoHHco2Ls2hwt5H/flGPT
 WMytSI5b+Rf6vVR5AOKRpSfdDk30SMUHqV2m/wFjNSqXRxdjrZa03w67q7YFlIgRzQl0HHvhxg6
 xIyh/dz87666qlanYJytRvoPvUr5rl4o2jyqd
X-Google-Smtp-Source: AGHT+IFH3m66g8HWT2CQTNeo+EtGoIUd8RDc2LwKIb7edViIwL4NcQpjcg5Y3xV5GXuq20hzS833a3ze48q2PnYd4O4=
X-Received: by 2002:a05:6214:4412:b0:6b0:8bb2:dfb5 with SMTP id
 6a1803df08f44-6b08bb2eea1mr30255276d6.12.1718131950668; Tue, 11 Jun 2024
 11:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
In-Reply-To: <20240611143635.GF68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:19 -0600
Message-ID: <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
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

Hi,

On Tue, 11 Jun 2024 at 08:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 12:17:16PM +0200, Heinrich Schuchardt wrote:
> > On 07.06.24 20:52, Sughosh Ganu wrote:
> > > There are events that would be used to notify other interested modules
> > > of any changes in available and occupied memory. This would happen
> > > when a module allocates or reserves memory, or frees up memory. These
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
> > > +                                       int memory_type,
> > > +                                       bool overlap_only_ram);
> > > +
> > >   static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >   {
> > >     struct event_efi_mem_map_update efi_map = {0};
> > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > >     if (is_addr_in_ram((uintptr_t)addr))
> > >             event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
> > >   }
> > > +
> > > +static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > > +{
> > > +   u8 op;
> > > +   u64 addr;
> > > +   u64 pages;
> > > +   efi_status_t status;
> > > +   struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > +
> > > +   addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > +   pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > +   op = lmb_map->op;
> > > +   addr &= ~EFI_PAGE_MASK;
> > > +
> > > +   if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > +           log_debug("Invalid map update op received (%d)\n", op);
> > > +           return -1;
> > > +   }
> > > +
> > > +   status = __efi_add_memory_map_pg(addr, pages,
> > > +                                    op == MAP_OP_FREE ?
> > > +                                    EFI_CONVENTIONAL_MEMORY :
> >
> > This is dangerous. LMB might turn memory that is marked as
> > EfiReservedMemory which the OS must respect into EfiBootServicesData
> > which the OS may discard.
> >
> > E.g. initr_lmb() is being called after efi_memory_init().
> >
> > Getting all cases of synchronization properly tested seems very hard to
> > me. Everything would be much easier if we had only a single memory
> > management system.
>
> Yes, Sughosh is working on the single memory reservation system for
> everyone to use. This pairs with the single memory allocation system
> (malloc) that we have. Parts of the code base that aren't keeping these
> systems up to date / obeying their results need to be corrected.

The EFI allocations don't happen until boot time...so why do we need
to do this now? We can instead have an EFI function to scan LMB and
add to its memory map.

Regards,
Simon
