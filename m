Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38693C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 06:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB68881BA;
	Tue, 11 Jun 2024 08:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I0PGSQwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB61885C5; Tue, 11 Jun 2024 08:20:07 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFD1884FB
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 08:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c2f6b47621so1520232a91.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718086803; x=1718691603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DTJFGHjpLqfTi+Sb2UBoHRg5u4Q09Kh7LAwLHMhwEyI=;
 b=I0PGSQwgp82FFhylJd5UHfOTtvwWTwj53G3u+iLl3n1mCb8pOi+c2gKoEVmMoUyBSS
 U9a2b32CFTFs07USU8FLKnLKS9dBUCH80am8KHauF2NzHNOk+G/NJ1exQdDEDRGVclUl
 XvxriDKVTBQP0Qth4IrQE2oFeFrl6NOFIHAsJLYXJ8+EYmYl4cUTyJpId6awCscpLwIS
 ho75tv64csttIKPbSqKyFFEKGR5vzezBSBOcKc7XE4xPqUzw1lox066EYYqrfCWw3e6v
 XcHVHl4OQId7C+GDxa0AvZBQFC2nEX9kayV9FxxPRIrGshReBCcNeP4P6OI03snFPRy2
 taHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718086803; x=1718691603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTJFGHjpLqfTi+Sb2UBoHRg5u4Q09Kh7LAwLHMhwEyI=;
 b=nSDh7ObFybH4VlGO9I0KaH7FcxCiW75PYQnzgNEoIzvOlSDttjgH+Emj2T9DjNoRee
 rlo949gNYU9jS1n1mHD8aeuLznw97hWXzHOOBdr2UZzLZjcnHRO7afKbvhli5TBYMhp6
 rv5P6SZnkTJeVSjsPpVgNyyBOKAfrLNZtn3Mf6DIjznVW7rWXbP1EKZBV16RtsmgiUL+
 1aV9cS1D24SZY4QcIeE862RuNaILgqThZQMN/jW1JnvL/q57ZM6+wRw8gAqU923DALfj
 BBjxUfU/jQNtd3XnQHAM3iSF8pQN3YbZ9QHQcmdOUjqk47XpSwg+GvraJnt7b2qgEW2X
 F+ZA==
X-Gm-Message-State: AOJu0Yy2fGwrMWt1MU6AOMajHAoT+na6/6foskqd9nPSf+Q7MWjmuold
 91lpWvxBsqGOjaWn5JHXBCdDDDiINOLTZohtt/dXm9DAkcPVoqJ8bFqfqALEYCgGB0aTFSqwd+n
 Slv3Uz6M+5B2suUF9bxYIcN0IV2HP38uF753doA==
X-Google-Smtp-Source: AGHT+IGpbltv3X4Fo7fj6I3B9jDv6nofbwlNS0SEkgpEU7xSSKhAG1dXpxkU0v1XS+I7CznrLsq1ZdwoVdmJclWPKJU=
X-Received: by 2002:a17:90a:8d0f:b0:2c2:db4e:16eb with SMTP id
 98e67ed59e1d1-2c32b494c05mr2511683a91.7.1718086802998; Mon, 10 Jun 2024
 23:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <CAC_iWjJB4t_SAuEoJwTdUR=d+N_PZhXEBx6jMW+n1OQzREVNvQ@mail.gmail.com>
 <CADg8p94H6d3cPQzw8Xgc5r6vTat1SKAu3xY1BZcYNyPYrmjX7A@mail.gmail.com>
 <CAC_iWj+S1MHjwH1zvT=rz+agwxXWef6SFG7Kipg4bCNFn7oabg@mail.gmail.com>
 <CADg8p94_C=1qYQW0=qgFBvoMVOWOM3U66pjfR_Q+_HYw-+KfAA@mail.gmail.com>
In-Reply-To: <CADg8p94_C=1qYQW0=qgFBvoMVOWOM3U66pjfR_Q+_HYw-+KfAA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 09:19:26 +0300
Message-ID: <CAC_iWjJL41EWK=hze+oQrP+RbS_EdSkUGFrJrj4Od24WXT634A@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, Jun 10, 2024, 5:52=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:

> hi Ilias,
>
> On Mon, 10 Jun 2024 at 19:48, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sughosh
> >
> > On Mon, 10 Jun 2024 at 15:25, Sughosh Ganu <sughosh.ganu@linaro.org>
> wrote:
> > >
> > > On Mon, 10 Jun 2024 at 17:40, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org>
> wrote:
> > > > >
> > > > > There are events that would be used to notify other interested
> modules
> > > > > of any changes in available and occupied memory. This would happe=
n
> > > > > when a module allocates or reserves memory, or frees up memory.
> These
> > > > > changes in memory map should be notified to other interested
> modules
> > > > > so that the allocated memory does not get overwritten. Add an eve=
nt
> > > > > handler in the EFI memory module to update the EFI memory map
> > > > > accordingly when such changes happen. As a consequence, any
> subsequent
> > > > > memory request would honour the updated memory map and only
> available
> > > > > memory would be allocated from.
> > > >
> > > > So the question here, is why do we need a notifier chain overall?
> > > > Can't we change the EFI subsystem and allocate memory with lmb now?
> > > > And any special functions we have in EFI (e.g allocate aligned
> memory)
> > > > can migrate to lmb()
> > >
> > > Like we discussed offline, that was my initial attempt -- to use the
> > > LMB allocation API's from inside the EFI allocate pages module. But I
> > > was facing a lot of corner case issues, primarily in keeping the two
> > > memory maps the same.
> >
> > I think it would worth discussing this a bit more. I like the idea of
> > having a single allocator more than having events to update memory
> > reservations
> >
> > > Which is why I moved to the current
> > > implementation of notifying other modules, and that too only for the
> > > addresses in the RAM region.
> >
> > The notification to 'other modules' i still done by updating the
> > static memory map though no?
> > So what corner cases we couldn't solve by having a single allocator?
>
> I can re-check what were the issues that I faced when trying with a
> single allocator. But please note that we are not making any
> significant gains by having a single allocator. Even with a common
> allocator(say LMB), it would still be required to have the same
> notification mechanism to update the EFI memory map.


I am not sure about this. With the proposal I did on the other thread, you
would have the allocations updated at runtime and an ID of the subsystem
that allocated the memory.

The only difference with having a central allocator is that we will need a
'flags' field to store the EFI-specific options.

Else the EFI
> memory map would show regions of memory as conventional memory, while
> they are being used by the other subsystem. So, all in all, I think
> that the notification mechanism is not that inefficient. Thanks.
>
>
Regards
/Ilias

> -sughosh
>
> >
> > Thanks
> > /Ilias
> > >
> > > -sughosh
> > >
> > > >
> > > > Cheers
> > > > /Ilias
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  lib/efi_loader/efi_memory.c | 70
> ++++++++++++++++++++++++++++++-------
> > > > >  1 file changed, 58 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_memory.c
> b/lib/efi_loader/efi_memory.c
> > > > > index 435e580fb3..93244161b0 100644
> > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > @@ -73,6 +73,10 @@ struct efi_pool_allocation {
> > > > >  #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
> > > > >  extern bool is_addr_in_ram(uintptr_t addr);
> > > > >
> > > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages=
,
> > > > > +                                           int memory_type,
> > > > > +                                           bool overlap_only_ram=
);
> > > > > +
> > > > >  static void efi_map_update_notify(u64 addr, u64 size, u8 op)
> > > > >  {
> > > > >         struct event_efi_mem_map_update efi_map =3D {0};
> > > > > @@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u6=
4
> size, u8 op)
> > > > >         if (is_addr_in_ram((uintptr_t)addr))
> > > > >                 event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map,
> sizeof(efi_map));
> > > > >  }
> > > > > +
> > > > > +static int lmb_mem_map_update_sync(void *ctx, struct event *even=
t)
> > > > > +{
> > > > > +       u8 op;
> > > > > +       u64 addr;
> > > > > +       u64 pages;
> > > > > +       efi_status_t status;
> > > > > +       struct event_lmb_map_update *lmb_map =3D
> &event->data.lmb_map;
> > > > > +
> > > > > +       addr =3D (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > > +       pages =3D efi_size_in_pages(lmb_map->size + (addr &
> EFI_PAGE_MASK));
> > > > > +       op =3D lmb_map->op;
> > > > > +       addr &=3D ~EFI_PAGE_MASK;
> > > > > +
> > > > > +       if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE) {
> > > > > +               log_debug("Invalid map update op received (%d)\n"=
,
> op);
> > > > > +               return -1;
> > > > > +       }
> > > > > +
> > > > > +       status =3D __efi_add_memory_map_pg(addr, pages,
> > > > > +                                        op =3D=3D MAP_OP_FREE ?
> > > > > +                                        EFI_CONVENTIONAL_MEMORY =
:
> > > > > +                                        EFI_BOOT_SERVICES_DATA,
> > > > > +                                        true);
> > > > > +
> > > > > +       return status =3D=3D EFI_SUCCESS ? 0 : -1;
> > > > > +}
> > > > > +EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > > > >  #endif /* MEM_MAP_UPDATE_NOTIFY */
> > > > >
> > > > >  /**
> > > > > @@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct
> efi_mem_list *map,
> > > > >         return EFI_CARVE_LOOP_AGAIN;
> > > > >  }
> > > > >
> > > > > -/**
> > > > > - * efi_add_memory_map_pg() - add pages to the memory map
> > > > > - *
> > > > > - * @start:             start address, must be a multiple of
> EFI_PAGE_SIZE
> > > > > - * @pages:             number of pages to add
> > > > > - * @memory_type:       type of memory added
> > > > > - * @overlap_only_ram:  region may only overlap RAM
> > > > > - * Return:             status code
> > > > > - */
> > > > > -static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > > -                                         int memory_type,
> > > > > -                                         bool overlap_only_ram)
> > > > > +static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages=
,
> > > > > +                                           int memory_type,
> > > > > +                                           bool overlap_only_ram=
)
> > > > >  {
> > > > >         struct list_head *lhandle;
> > > > >         struct efi_mem_list *newlist;
> > > > > @@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u6=
4
> start, u64 pages,
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       return EFI_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * efi_add_memory_map_pg() - add pages to the memory map
> > > > > + *
> > > > > + * @start:             start address, must be a multiple of
> EFI_PAGE_SIZE
> > > > > + * @pages:             number of pages to add
> > > > > + * @memory_type:       type of memory added
> > > > > + * @overlap_only_ram:  region may only overlap RAM
> > > > > + * Return:             status code
> > > > > + */
> > > > > +static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> > > > > +                                         int memory_type,
> > > > > +                                         bool overlap_only_ram)
> > > > > +{
> > > > > +       efi_status_t status;
> > > > > +
> > > > > +       status =3D __efi_add_memory_map_pg(start, pages, memory_t=
ype,
> > > > > +                                        overlap_only_ram);
> > > > > +       if (status !=3D EFI_SUCCESS)
> > > > > +               return status;
> > > > > +
> > > > >         if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
> > > > >                 efi_map_update_notify(start, pages <<
> EFI_PAGE_SHIFT,
> > > > >                                       memory_type =3D=3D
> EFI_CONVENTIONAL_MEMORY ?
> > > > > --
> > > > > 2.34.1
> > > > >
>
