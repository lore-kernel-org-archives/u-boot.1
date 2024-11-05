Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F06BD3610E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF9388D8D;
	Tue,  5 Nov 2024 20:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T0p85ieZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BE188E3F; Tue,  5 Nov 2024 20:13:17 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9C488CA2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5a9c7420so57056241fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730833993; x=1731438793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/IiCxRP1urAukCDgGSbjIAVPt0Q+axrgkp/QcaVz7Q=;
 b=T0p85ieZvpPh6p7RmIexojh8PMAqDGq6G9OeRH10h6Sar6CtXjPjIQa0w1y3mEsEM9
 LFQ0uUZ9dCG+XtqdkqfpQC6Zo1MtLGqnIsNZGiDzWfsX6PrMia4IhbgI4bDEG7jokRDs
 7QLZkn9Tu/wfe5N8Ut2APNi9M+dsOXl/ugZFk8YJg/5vyDLpEyAh1/SDpupdz5ZHFZ1L
 ONPB5XxJ7VEQa9AYKJIew5vsrXS6m0a97FQXltjKs4OdmI8mzdkmbByMWFWZRxyal0Tc
 BF8OiW/Ructtpm+P8g/HNOX5KdTRjF3musc6Elm1VczAS88nsvNab0nU0hos/o1GWMBq
 mnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730833993; x=1731438793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/IiCxRP1urAukCDgGSbjIAVPt0Q+axrgkp/QcaVz7Q=;
 b=CCFDLaFhnTyhZpXO7jk5jbK13VDQ2R1w5Dd5s+yrVzxzrnPgHnJHfdcW8AMwumOBBP
 ZlJEA6XQ3kNHW/ne3nB+oA9RHcVtHRShOCjOluiRQYMPrXhKx1payO+BmNoPCM3at/um
 bokQM+AH20uzXqZk3ohLqz5eo+3Z3JlVDqxHGn3TB5uwNB74lAyrNZnRrL6faXrIir1T
 S/S40ub//cZ0OSYaTu+t59aPGBKAySk1tSgeDMN9qOJpkp1mB6Z+/4IM3xUmTbnVhQ3L
 g5kgCP6AoyvyL/4p8FMkhTZ3sXM26hZ0cPfLk+E7cDT0Hye2fyojByVLV1r4vu5OHz4n
 La3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4B7d/uE7rdhdEJrmOh9dMc6TnSGgsOrMYa0QSG+5prMPSVKgp1Q8hMJpFU95V/F/B9zqxWhA=@lists.denx.de
X-Gm-Message-State: AOJu0YwLSP2dM1J67k5z15jOZ09aXmnSQ/Ru08qt3nihb4sEP6T87KG6
 z6TAH57dyi3n9l2xnePBY61KzEIDwug1LPiQFNyXCyGcbap0xbBXH4I88Wr53lDCPIqIqK67YIS
 12IJQHx1vEhzLvpMm/ogF/jqlgyQvXdIhQlugaA==
X-Google-Smtp-Source: AGHT+IH5O0vDfZvYwazAO06A1FS0vWSwg6yPgoZryDEtB0wz7KsIwqCmHnfeaoT31j7XfN/D/yWI6o74Pp7gBSA00sk=
X-Received: by 2002:a05:651c:160f:b0:2f7:64b9:ff90 with SMTP id
 38308e7fff4ca-2fedb7964a1mr77945461fa.9.1730833993176; Tue, 05 Nov 2024
 11:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
 <20241103173633.GA664967@robin.jannau.net>
In-Reply-To: <20241103173633.GA664967@robin.jannau.net>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 6 Nov 2024 00:43:01 +0530
Message-ID: <CADg8p94t3AQ_tsEwSpQEUu3cc3P0BtbZ=DE8k58Vtp6HFGo-Nw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 kettenis@openbsd.org, sjg@chromium.org, u-boot@lists.denx.de
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

On Sun, 3 Nov 2024 at 23:06, Janne Grunau <j@jannau.net> wrote:
>
> On Sun, Nov 03, 2024 at 07:53:36PM +0530, Sughosh Ganu wrote:
> > On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > Date: Fri, 1 Nov 2024 17:17:22 +0530
> > > >
> > > > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > > > >
> > > > > The changes in "Make LMB memory map global and persistent" [1] break
> > > > > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > > > > iommu present on Apple silicon systems.
> > > > >
> > > > > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > > > > do not overlap. The physical memory on this systems starts depending on
> > > > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > > > > manage these distinct regions in a single LMB map. In addition every
> > > > > device has its own iommu and IO address space so sharing a single memory
> > > > > map between all iommu instances is not necessary.
> > > > >
> > > > > To fix this issue restore the used subset (add, alloc and free) of the
> > > > > previous pointer based LMB interface with "io_" as prefix.
> > > > >
> > > > > To ensure that low level lmb functions do not use the global LMB
> > > > > variable reorder lib/lmb.c so that the variable is not visible.
> > > > >
> > > > > Tested with patches from my "Fix device removal order for Apple dart
> > > > > iommu" series [2] to fix a separate issue.
> > > > >
> > > > > The cosmetic commit has two checkpatch warnings in existing code which I
> > > > > ignored.
> > > > >
> > > > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > > > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> > > > >
> > > > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > > > ---
> > > > > Janne Grunau (4):
> > > > >       lmb: Do not use global LMB variable in _lmb_free()
> > > > >       lmb: cosmetic: reorder functions and global LMB variable
> > > > >       lmb: Add basic io_lmb functionality
> > > > >       iommu: apple: Manage IOVA separately from global LMB mem map
> > > >
> > > > Thanks for these changes. I am currently on leave, but will take a
> > > > look at this in detail next week. But on a cursory glance, I have to
> > > > say that I am not entirely satisfied with this solution as well. With
> > > > these patches, we now have a disparity in terms on how we view the LMB
> > > > memory map -- we have a global map for RAM address range, but a per
> > > > device one for IOVA's. I understand that IOVA's are supposed to be
> > > > per-device,
> > >
> > > The IVOA's are per-stream.  Multiple devices might share a single
> > > stream.
> > >
> > > > but then I think that perhaps LMB is not the right way to
> > > > solve this. This was fine earlier, when the entire LMB implementation
> > > > in U-Boot was local, but that is not the case now. I wonder if there
> > > > can be a different, non-LMB way to implement this.
> > >
> > > Of course there can be a different implementation.  But why add a
> > > separate implementation for what is essentially the same problem:
> > > allocate blocks out of an address space.
> >
> > My primary concern here is to prevent setting a precedent that it is
> > okay to have a local, per caller lmb instance.
>
> I think the issue is thinking this is per caller. It is not (primarily)
> by caller. It is one LMB instance per managed independent address space
> block. Apple silicon SoCs have multiple independent iommus. Each iommu
> can handle multiple address spaces (streams, only partially implemented
> in the u-boot driver.
>
> > If it is allowed for
> > one caller, it becomes difficult to say no to someone proposing a
> > similar approach later. In any case, based on how the allocation logic
> > works, with all the addresses being allocated from the IOMMU driver's
> > map function callback, why can there not be a single instance of an
> > iova lmb structure. That would at least ensure some kind of parity on
> > how the lmb maps are maintained.
>
> There are multiple fully independent IOVA spaces. I doesn't make sense
> to allocate them from a single pool.
>
> > > Before you changed the goal posts, lmb did exactly that.  The only
> > > problem was that there were multiple lmb instances covering the same
> > > "main memory" address space.
> >
> > I had provided an explanation of the situation that existed prior to
> > these changes in a writeup [1]. And that writeup had clearly provided
> > the two possible solutions to fix the issue with EFI allocated memory
> > working with LMB. And it was decided through discussion on that
> > writeup as well as on the mailing list that this was the approach to
> > be taken.
>
> That document missed due to unfortunate circumstances one special case
> in the LMB usage. Consolidating all struct lmb referring main memory
> into a single opaque object is useful. Please let's move on to fix the
> single usage which broke due to the change.
>
> From my point of view it's clear that "io_lmb*" is separate from the
> main memory lmb.

Yes, that is my view as well. Which is why I was proposing a different
mechanism for the IOVA allocations.

 It manages the IO virtual address space of devices and
> it is fine that there as many (io_)lmb instances as there are IO virtual
> address spaces. These do not have to be managed via struct lmb and
> looking at the minimal io_lmb* API a simpler implementation would work.

Okay. Although I wonder, given your explanation of multiple, per
device IO VA spaces, how would these spaces be identified, if not
through an instance of the lmb structure.

> An alternative implementation would be duplicated code and reusing the
> existing tested lmb code is desireable.

Yes, I agree.

> If we want a stronger distinction between lmb and io_lmb we could hide
> struct lmb from io_lmb.

Okay, but I am not sure how you would be able to achieve that. Are you
proposing using the region lists directly? If so, I would say that if
we are using the LMB code for the allocations, we might as well use
the structure.

-sughosh

>
> Janne
