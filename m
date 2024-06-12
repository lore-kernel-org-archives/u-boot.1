Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578D1C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 06:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8E48864F;
	Wed, 12 Jun 2024 08:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PypbjHc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F050588789; Wed, 12 Jun 2024 08:20:29 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618CD8864F
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 08:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so8445704a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718173227; x=1718778027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lq3bKo/cL+RpDSNUppw/9535SG/BevxiOMUcwuEXuIM=;
 b=PypbjHc/CmXdMBQ/4Mq4yQUX9Kiud8LR9C9B12Pk/1x1GhO1yueKiLFkBK+lF6rw4t
 X63wm0heEzLp3+QBaRg5pyrbNruGFjPhDjYMUUXVAYYtugDXX9iuBU3TvcQtSqbMSAOz
 BBismVVo5V8OS5YvZSxM6zoxThlAmtYa3EG7RKFc0aCmvzXuKH8dT0e6wPmhGj0oMk12
 SAGYML02zuw3DUdJAfHN3JEk1GQpp6c/u0XeUGGpM6aE77Z7lAXPAGnoJHUWOtSWyY/D
 UyrOHetqF/OsWGtZiLOUZl62KizI3vLDeR7tSViVhC7dCSurd9+1VFKK5Fb3Zjvrkew2
 O8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718173227; x=1718778027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lq3bKo/cL+RpDSNUppw/9535SG/BevxiOMUcwuEXuIM=;
 b=WwVnl2fdLLhkRDTY7vrTYY5YExHyUhoS/hPfrZLyFxAVdh/A92J2LMG4RkBRLxcS19
 hpIHCxCHcLZT5jyyARgUBLvQcyAmsS61qU89B5XlrltTQgOz8NmApraRADhpok58zudH
 bOQKCbIGvsWiIjhDH+kb5wluvpSvh8NE2Gk0uD1Sxkn4HpOWKqyWSWQY/ExeGhn720OR
 QjymC6NFM8DUqeqkMItuGV30Ta5zGRFjdZ49zGFVMDmxXlmGlyvhmMV0WxFXTFhsb12T
 rretmNDynnBjQpPK1GGtbdFFnnlVDZvtQsDwVENaFAe2AryP9esqvKQ1uAv7YbfR6dZf
 F4qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4v7F4qnp65WAlSVenhPiRkN9p8xyelvF++SWezfWtFI3v3oTUa0z1HhJj4XUszifUXpkzpU40+ZkucMXMXsPwfCjvsw==
X-Gm-Message-State: AOJu0YxyrUDY75PI5PazRnQMB3SEr7ZaUa23eBmtIxcE/5y98OYYyu6C
 qHd4PxIRr1P9fUSQ9FevZjnnNtlsLYXNAUd08VcOO6rgoCP8dDxYnwjrXUtStjU4M198sGtxvnS
 xFLDcP7o25UFkiXjOuxmQ/LnUcphRHZCzNs4W6w==
X-Google-Smtp-Source: AGHT+IFPgqWfOUy/Qfuog8OiJMX3ScN/PmOb9mG+sf1iigunQr3+dEBSvGR0SwPRZr7sOBoAaanrzW12+asXN+wBFEU=
X-Received: by 2002:a50:96c4:0:b0:57c:aac7:105c with SMTP id
 4fb4d7f45d1cf-57caac7109bmr519927a12.0.1718173226762; Tue, 11 Jun 2024
 23:20:26 -0700 (PDT)
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
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 12 Jun 2024 11:50:15 +0530
Message-ID: <CADg8p97Pb0i2HHhRuRsgx=RbjQAkL3dyaPctJkEZddn9J-GOTg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
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

hi Ilias,

On Wed, 12 Jun 2024 at 11:19, Ilias Apalodimas
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
>
> > and it uses LMB for those (or at least it does
> > with bootstd). I'm just trying to keep this all as simple as possible.
>
> Heinrich already pointed out a potential danger in the current design.
> If an EFI allocation happens *before* LMB comes up, we might end up
> updating the efi memory map with the wrong attributes. That would lead
> to the OS discarding memory areas that should be preserved and we
> won't figure that out until the OS boots and blows up.

Like I mentioned in one of the earlier replies [1], this is actually
not an issue, as long as modules are freeing memory that was actually
allocated/reserved by them. In case of the EFI subsystem marking some
memory region as EfiReservedMemory, this will send a notification to
the LMB module, and the LMB module will mark this region as reserved.
So unless some LMB user decides on freeing up memory that was not
reserved by it, this should be just fine.

Making use of the LMB API's as the common backend for allocating
memory is a separate thing, and I will look into that. But the above
highlighted issue is not one, with correctly working code.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-June/555883.html
