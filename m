Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D620C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 05:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA4888758;
	Wed, 12 Jun 2024 07:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gNUVlCGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ACC88763; Wed, 12 Jun 2024 07:49:38 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C879D88758
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 07:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c2e31d319eso2921585a91.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718171374; x=1718776174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+C2tH9eswCKUCQwbIVRCIPvHDfTtysRxaE+Dcbe7UvQ=;
 b=gNUVlCGzAGgtwMlvaRgut8WtNpqShMVCq6IigOj4nLcf1MBHCD99azJr5zY3DR/FMJ
 //1DER5huOd4ZWhUQ8YwwQHsnqc614KCM13XP8iNQB6faPp43tfzuAtWstFo6tTeOwZW
 IT4ZJFstNoV3PYxfEP+bFKolqe5UCEkjGFge0s+mmnAC1h96byNx43vdWzgMF6HmUyi+
 ThK0/LCgugrSnVegT3nOfKIGzUERAiWkcn1Mhgj7lnAjTShiuaCups/uwVp0CNpsHRy+
 22PYgWnQXXrVG8/gJOBwfIxPMqNwG1Fo39PVNF633z1uyoNI6tr7tBPgmh3198ENYtCp
 C0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718171374; x=1718776174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+C2tH9eswCKUCQwbIVRCIPvHDfTtysRxaE+Dcbe7UvQ=;
 b=Z8XQmgFPJzSGmNyX+Kd1UHWD7nH3lmhfxqg9XvUeUEzf1FBJFlA8Rtu2ivjcINySZS
 HVAgubXhlGCnuBNvS3M0fdVEeIl7f1SzmTIdySgD8RDMWZxs4Chw4lhsM/vhcvKPpYng
 L7vGl1QO31V6Jdvb2S8IYf3x+kBEoY8V2OefIpODCMc1+6szzTZ19ka3Sqs3CZDxiTth
 DNJa2mu6nWBhUmJz3wsi6T6wB7Qa+L8uhhVvsEzF0C1RhiEX7duyrxT44w+wBNvth688
 h7nQK4B87HSpRZfg4+WYJkoUQdBOvNJRIxjD5B1dBSv40upcRl1Ip/VfEXB0L1FzYrRd
 ADmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdRw3lpm6CyquKAYiTdWRUiv00BPxn9RMM5aLCPKeOd9YyxuRzpRiuOmulJliLN8sariv2lsDzW4V1jKegpX+97JWOYw==
X-Gm-Message-State: AOJu0YzcTgPOlYxKzAXe2IDdQb3ertVIFYU6FG/c94ko0P3lLqP0Sqfo
 cP67K20vFHutWGRqqz3W7HIqmOT5GuYdxiU6ORinjc9cDwCzZo/KM3mmtOHQxFHweSRD4uNLiYj
 6K6ne3rTBU9WPde7hSJLXFJMK1Sjd81Cg9nFhXA==
X-Google-Smtp-Source: AGHT+IHE7z7LQMHQ7E7ZRuI5Kqm3hGFH9J1CV1pX8Ec1u+YLrcTmB1j91BfkMTJNG8R//7rnfdsiB7+3xMTvwJ/o7hw=
X-Received: by 2002:a17:90b:f13:b0:2c4:aa69:26c2 with SMTP id
 98e67ed59e1d1-2c4aa6927d9mr603359a91.24.1718171374198; Tue, 11 Jun 2024
 22:49:34 -0700 (PDT)
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
In-Reply-To: <CAFLszTjm_k6DLCZcMCevf78-K7MsiqWGq5ONxowDVMpRe_XB7g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 08:48:38 +0300
Message-ID: <CAC_iWjJhb4ROumTSYMzhOCgpdv-5=v=5fjuvcf8g8xUC9fsjNg@mail.gmail.com>
Subject: Re: [RFC PATCH 15/31] efi_memory: add an event handler to update
 memory map
To: Simon Glass <sjg@chromium.org>
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

[...]

> > > > > > > > +   struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
> > > > > > > > +
> > > > > > > > +   addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
> > > > > > > > +   pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
> > > > > > > > +   op = lmb_map->op;
> > > > > > > > +   addr &= ~EFI_PAGE_MASK;
> > > > > > > > +
> > > > > > > > +   if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
> > > > > > > > +           log_debug("Invalid map update op received (%d)\n", op);
> > > > > > > > +           return -1;
> > > > > > > > +   }
> > > > > > > > +
> > > > > > > > +   status = __efi_add_memory_map_pg(addr, pages,
> > > > > > > > +                                    op == MAP_OP_FREE ?
> > > > > > > > +                                    EFI_CONVENTIONAL_MEMORY :
> > > > > > >
> > > > > > > This is dangerous. LMB might turn memory that is marked as
> > > > > > > EfiReservedMemory which the OS must respect into EfiBootServicesData
> > > > > > > which the OS may discard.
> > > > > > >
> > > > > > > E.g. initr_lmb() is being called after efi_memory_init().
> > > > > > >
> > > > > > > Getting all cases of synchronization properly tested seems very hard to
> > > > > > > me. Everything would be much easier if we had only a single memory
> > > > > > > management system.
> > > > > >
> > > > > > Yes, Sughosh is working on the single memory reservation system for
> > > > > > everyone to use. This pairs with the single memory allocation system
> > > > > > (malloc) that we have. Parts of the code base that aren't keeping these
> > > > > > systems up to date / obeying their results need to be corrected.
> > > > >
> > > > > The EFI allocations don't happen until boot time...so why do we need
> > > > > to do this now? We can instead have an EFI function to scan LMB and
> > > > > add to its memory map.
> > > >
> > > > We're talking about reservations, not allocations. So yes, when someone
> > > > is making their reservation, they need to make it. I don't understand
> > > > your question.
> > >
> > > As I understand it, this is used to tell EFI about a memory reservation.
> >
> > This patch, or this series? This series isn't about EFI. This patch is,
> > yes.
> >
> > > But the EFI code can scan the LMB reservations just before booting and
> > > update its tables. I don't see a need to keep them in sync before the
> > > boot actually happens.
> >
> > But that wouldn't work. If something needs to reserve a region it needs
> > to do it when it starts using it. It's not about the EFI map for the OS,
> > it's about making sure that U-Boot doesn't scribble over a now-reserved
> > area.
>
> I'm not convinced of that yet. EFI does not do allocations until it
> starts loading images,

It does in some cases. E.g The efi variables allocate some pages when
the subsystem starts, the TCG protocol allocates the EventLog once
it's installed and I am pretty sure we have more.

> and it uses LMB for those (or at least it does
> with bootstd). I'm just trying to keep this all as simple as possible.

Heinrich already pointed out a potential danger in the current design.
If an EFI allocation happens *before* LMB comes up, we might end up
updating the efi memory map with the wrong attributes. That would lead
to the OS discarding memory areas that should be preserved and we
won't figure that out until the OS boots and blows up.

Cheers
/Ilias
>
> Regards,
> Simon
