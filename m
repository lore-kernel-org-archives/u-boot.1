Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC6DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09CC885CC;
	Wed, 12 Jun 2024 22:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbaV7Sxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA76F88872; Wed, 12 Jun 2024 22:24:55 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8939F882B6
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c2c74d9be0so171655a91.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223892; x=1718828692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bCV0GnkDP2QKc9STB8Da0LQA8kp70at8DVdJxKR84XE=;
 b=JbaV7SxzXsYDDMvX3gn1qk5GDu8qMNwuCHcnoSQkeAUnlKecAOqCvgNOjDrXd1MS1r
 mo0yRZYVLx93U45ZF6biW0axQCv9wb7ScnrJfi/pFePX1Zp0XzMbWfyjo3vFR2xsZFPb
 RcyIlfjV0QXEnD951uZ9Af2oRN+gzZ6RK4rTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223892; x=1718828692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCV0GnkDP2QKc9STB8Da0LQA8kp70at8DVdJxKR84XE=;
 b=DZBdazf+0EcJxL1+gk4X7KCJEoxt+oHXeFktelELHqFsbrFq3vL0H9VSEBWO5/5XcT
 naPkSQak7/oLDfC/qy1hEp+Ha5lDAF1O9gPEiFoYmfYrilb/MiMLcvSyIuUBs1Hff1Bq
 LgSeUOa560junRIAthV/jApwUOOF2Z9XnW2rBO2ZZIUoUIePFubRVsWJkg8c6oR1Vax9
 duZ6yAlKKe9tZ+2hFRE5OmKdR5PAMgyRuqlq0ypunb89jKbChfjkUDFSduknQeMWja89
 itjt6a3VQO8lk5G220oj7r0bXafgLEeTfcQOfoAodHAuFM4m97B7E4F1l3TSc9b8/cl3
 fAdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqyWJpxjBYGw2/2VBHjQ/yR4AeYQaJErfWMmMiEsSQRWNFa8Os0gXCos/RqL7nOiVQedwG+u9/Yh2IVH1bcoz28WeuXQ==
X-Gm-Message-State: AOJu0Yx2061uOCSnpw5A0iAGwZiSm65qXmEOQFUnopgdu3dDoZ08zCkv
 vPLF+gXIU5IGRcYotzYGcCc/k64QQTaUV8J4a2HNsGKPBsR7ID9JH20o1UGtIF2MSyR7YacsTWw
 Goej1kS/NrXxXWYXTzon60tCmovSIMRPvJhXm
X-Google-Smtp-Source: AGHT+IFWdw/6FgxXtuT2q9lw0pTbfwLs2or2vJhLO2KRnBghrMqN2DAgYtsz6XIXDR0dDKV3OJMyTW8C4rLhK8vJXlY=
X-Received: by 2002:a17:90a:eb18:b0:2c0:17b4:85aa with SMTP id
 98e67ed59e1d1-2c4a763912dmr2847550a91.22.1718223892025; Wed, 12 Jun 2024
 13:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-16-sughosh.ganu@linaro.org>
 <50d0efab-0df6-47ef-a4e9-b0e3d6ec2556@gmx.de>
 <20240611143635.GF68077@bill-the-cat>
 <CAFLszTiEWw0tey4zeqjPYe2TsSWH1P4Xakn8OrOKSwqDU+EM_A@mail.gmail.com>
 <20240611210138.GL68077@bill-the-cat>
 <CAFLszThcanoRd=8A8wq0RWzSHerPPZxYdvyT8AjLNfH1QvyDiw@mail.gmail.com>
 <20240611225417.GN68077@bill-the-cat>
 <CAFLszTjm_k6DLCZcMCevf78-K7MsiqWGq5ONxowDVMpRe_XB7g@mail.gmail.com>
 <CAC_iWjJhb4ROumTSYMzhOCgpdv-5=v=5fjuvcf8g8xUC9fsjNg@mail.gmail.com>
In-Reply-To: <CAC_iWjJhb4ROumTSYMzhOCgpdv-5=v=5fjuvcf8g8xUC9fsjNg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:34 -0600
Message-ID: <CAFLszTjQ_2GxbRmxM9PAgDDHKTvVtxkxNhgm+yZpq0CO5++WWg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marek Vasut <marex@denx.de>, 
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

Hi Ilias,

On Tue, 11 Jun 2024 at 23:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > > > > > +   struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > > > > > > > +
> > > > > > > > > +   addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > > > > > > +   pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > > > > > > > +   op = lmb_map->op;
> > > > > > > > > +   addr &= ~EFI_PAGE_MASK;
> > > > > > > > > +
> > > > > > > > > +   if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > > > > > > > +           log_debug("Invalid map update op received (%d)\n", op);
> > > > > > > > > +           return -1;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   status = __efi_add_memory_map_pg(addr, pages,
> > > > > > > > > +                                    op == MAP_OP_FREE ?
> > > > > > > > > +                                    EFI_CONVENTIONAL_MEMORY :
> > > > > > > >
> > > > > > > > This is dangerous. LMB might turn memory that is marked as
> > > > > > > > EfiReservedMemory which the OS must respect into EfiBootServicesData
> > > > > > > > which the OS may discard.
> > > > > > > >
> > > > > > > > E.g. initr_lmb() is being called after efi_memory_init().
> > > > > > > >
> > > > > > > > Getting all cases of synchronization properly tested seems very hard to
> > > > > > > > me. Everything would be much easier if we had only a single memory
> > > > > > > > management system.
> > > > > > >
> > > > > > > Yes, Sughosh is working on the single memory reservation system for
> > > > > > > everyone to use. This pairs with the single memory allocation system
> > > > > > > (malloc) that we have. Parts of the code base that aren't keeping these
> > > > > > > systems up to date / obeying their results need to be corrected.
> > > > > >
> > > > > > The EFI allocations don't happen until boot time...so why do we need
> > > > > > to do this now? We can instead have an EFI function to scan LMB and
> > > > > > add to its memory map.
> > > > >
> > > > > We're talking about reservations, not allocations. So yes, when someone
> > > > > is making their reservation, they need to make it. I don't understand
> > > > > your question.
> > > >
> > > > As I understand it, this is used to tell EFI about a memory reservation.
> > >
> > > This patch, or this series? This series isn't about EFI. This patch is,
> > > yes.
> > >
> > > > But the EFI code can scan the LMB reservations just before booting and
> > > > update its tables. I don't see a need to keep them in sync before the
> > > > boot actually happens.
> > >
> > > But that wouldn't work. If something needs to reserve a region it needs
> > > to do it when it starts using it. It's not about the EFI map for the OS,
> > > it's about making sure that U-Boot doesn't scribble over a now-reserved
> > > area.
> >
> > I'm not convinced of that yet. EFI does not do allocations until it
> > starts loading images,
>
> It does in some cases. E.g The efi variables allocate some pages when
> the subsystem starts, the TCG protocol allocates the EventLog once
> it's installed and I am pretty sure we have more.

Both of those seem wrong to me, though.

- EFI variables should use malloc() like other small amounts of data
- TCG should probably use a bloblist, but in any case I suspect it is
needed beyond EFI

>
> > and it uses LMB for those (or at least it does
> > with bootstd). I'm just trying to keep this all as simple as possible.
>
> Heinrich already pointed out a potential danger in the current design.
> If an EFI allocation happens *before* LMB comes up, we might end up
> updating the efi memory map with the wrong attributes. That would lead
> to the OS discarding memory areas that should be preserved and we
> won't figure that out until the OS boots and blows up.

Yes, I believe the EFI memory sort-out should happen when booting and
not before. It is a bit like creating a plate of spaghetti if we do
all this stuff randomly while trying to boot different things,
retrying, etc....

Regards,
Simon
