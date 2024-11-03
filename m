Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F6E6F09E
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 14:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919FA89109;
	Sun,  3 Nov 2024 15:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XMCcHrIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04958910B; Sun,  3 Nov 2024 15:23:51 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429ED890E9
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso1501433a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730643828; x=1731248628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUlRGm5ou3trH92lUhMIalgOo4zTPk/FIFhAaP3C3U8=;
 b=XMCcHrISyP0tGnyEMOpon1BK+449WpCyu8mAqO7SxTK38PRAAjxNC3Uo7002YL12zv
 U/lL7BsRzVJGMh1T3vwjpRuLXCHMr9fSsDxruuRT0tdwaYFfgpdz4Tb3iLeVgAkcSSm1
 4TMr5cgr/dblDcyjkErEEcqTLpFUHB5G9FwEiBnMOLsDQdWrYZr6jhCSiOmVQtRHSKM6
 2Kr7EcRa7xcD6iQ/SS6BmvWNU+8ydi1iOOY9C8EQ9iB+yRfqs6crDBg6U+2fHGFHbdAJ
 YEG1lozDe0wY44vEdHQTWfh33PMvptjjPmtW6aRktRWel7r9WzeZcvHE2YlpXat3u8ra
 OQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730643828; x=1731248628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUlRGm5ou3trH92lUhMIalgOo4zTPk/FIFhAaP3C3U8=;
 b=kFtW6u0Y9YnAFHRT/C65ePpt6uMKnk+H4Ys5+Di2Z67gzDlNYpYZ+AgtFGWZj6sbfN
 JZzmyIYoVy8Kas8lS5HfSYOu70gsjS3bQy8PCocQCxMVeG0nOneWoN1Xqu6usRYFnpkS
 j4CdprHHtUm0qvGa+cor/V3aVHE6uppqVx8hTcdlT4vH72rbt0WOC+mye09KJRGqL+PK
 9HZ84aTlgJtIe0JASZB2pln6czCwWLbPvuBkIlhAtVQDXSTHQlVJL++px3unT/lJBpUN
 O9ce6Q4X+sgLIUGp8fvYLh09TuqPacBwlfoYNJjRQePfH9Zsdka1g6KbVZQBR4SYkRfo
 607A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoMlmnPQewNkTEDnA9S1cK55UfRpHoeB895CYjkmBTbaS4jc5opQRPIkx+eRB/Q640cY60tgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxxvmEUj77h4hnSal2Nm8rYMyEbGIMQxADcDVCmWOC+jczEfVLm
 AQiVg3KKSZqseyjHrgrlDXyNuDkyjQkhsIk7n3Hg4KWb5cojbdmDLid5uIVgUFBrhzURrjYwQ2u
 4cetn0fLuM2GeqAEH/TTQTCyw+QhNZXwxDQSuHQ==
X-Google-Smtp-Source: AGHT+IFqfKmvIUMErC9BKMiImAZgb9dlL9yK5y7/8JSg3rizgxs5E53Zd4MRyOp6XqRFhKNs0bAvd4cXoInO7yRPguM=
X-Received: by 2002:a50:c8c9:0:b0:5cb:ee14:d0a8 with SMTP id
 4fb4d7f45d1cf-5cd54b27020mr10930585a12.35.1730643827907; Sun, 03 Nov 2024
 06:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 3 Nov 2024 19:53:36 +0530
Message-ID: <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: j@jannau.net, trini@konsulko.com, kettenis@openbsd.org, sjg@chromium.org, 
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

On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Date: Fri, 1 Nov 2024 17:17:22 +0530
> >
> > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > >
> > > The changes in "Make LMB memory map global and persistent" [1] break
> > > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > > iommu present on Apple silicon systems.
> > >
> > > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > > do not overlap. The physical memory on this systems starts depending on
> > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > > manage these distinct regions in a single LMB map. In addition every
> > > device has its own iommu and IO address space so sharing a single memory
> > > map between all iommu instances is not necessary.
> > >
> > > To fix this issue restore the used subset (add, alloc and free) of the
> > > previous pointer based LMB interface with "io_" as prefix.
> > >
> > > To ensure that low level lmb functions do not use the global LMB
> > > variable reorder lib/lmb.c so that the variable is not visible.
> > >
> > > Tested with patches from my "Fix device removal order for Apple dart
> > > iommu" series [2] to fix a separate issue.
> > >
> > > The cosmetic commit has two checkpatch warnings in existing code which I
> > > ignored.
> > >
> > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> > >
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > ---
> > > Janne Grunau (4):
> > >       lmb: Do not use global LMB variable in _lmb_free()
> > >       lmb: cosmetic: reorder functions and global LMB variable
> > >       lmb: Add basic io_lmb functionality
> > >       iommu: apple: Manage IOVA separately from global LMB mem map
> >
> > Thanks for these changes. I am currently on leave, but will take a
> > look at this in detail next week. But on a cursory glance, I have to
> > say that I am not entirely satisfied with this solution as well. With
> > these patches, we now have a disparity in terms on how we view the LMB
> > memory map -- we have a global map for RAM address range, but a per
> > device one for IOVA's. I understand that IOVA's are supposed to be
> > per-device,
>
> The IVOA's are per-stream.  Multiple devices might share a single
> stream.
>
> > but then I think that perhaps LMB is not the right way to
> > solve this. This was fine earlier, when the entire LMB implementation
> > in U-Boot was local, but that is not the case now. I wonder if there
> > can be a different, non-LMB way to implement this.
>
> Of course there can be a different implementation.  But why add a
> separate implementation for what is essentially the same problem:
> allocate blocks out of an address space.

My primary concern here is to prevent setting a precedent that it is
okay to have a local, per caller lmb instance. If it is allowed for
one caller, it becomes difficult to say no to someone proposing a
similar approach later. In any case, based on how the allocation logic
works, with all the addresses being allocated from the IOMMU driver's
map function callback, why can there not be a single instance of an
iova lmb structure. That would at least ensure some kind of parity on
how the lmb maps are maintained.

>
> Before you changed the goal posts, lmb did exactly that.  The only
> problem was that there were multiple lmb instances covering the same
> "main memory" address space.

I had provided an explanation of the situation that existed prior to
these changes in a writeup [1]. And that writeup had clearly provided
the two possible solutions to fix the issue with EFI allocated memory
working with LMB. And it was decided through discussion on that
writeup as well as on the mailing list that this was the approach to
be taken.

-sughosh

[1] - https://docs.google.com/document/d/1LJj4f1oBaxPIALnMlIy8Bf-3pESjecTyKhrQoeCfyrk/edit?usp=sharing

>
> > Earlier, we had
> > functions for allocating and maintaining a memory map in the EFI
> > memory module. I am wondering if we can use those functions in a
> > common place, and use that implementation instead of having this in
> > LMB.
>
> Well, that implementation doesn't really have an external API, and has
> the same prolem that it only supports a single address space.
>
> > That way, every device which is looking for an IOVA map, can
> > maintain one, and use the common functions to add memory space to it's
> > map, and then use that memory for allocations. Also, based on your
> > explanation above, I think that it should be the responsibility of the
> > device to get the IOVA address range, and then pass those addresses to
> > the IOMMU driver? Let us see what others have to say on this solution.
> > If there is consensus, I can look at a solution once I am back.
>
> No, as I said the IOVA address space is per-stream not per-device.
>
> > -sughosh
> >
> > >
> > >  drivers/iommu/apple_dart.c |  16 +-
> > >  include/lmb.h              |  47 ++++
> > >  lib/lmb.c                  | 608 ++++++++++++++++++++++++++-------------------
> > >  3 files changed, 406 insertions(+), 265 deletions(-)
> > > ---
> > > base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
> > > change-id: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036
> > >
> > > Best regards,
> > > --
> > > Janne Grunau <j@jannau.net>
> > >
> >
