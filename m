Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEE7D11193
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 21:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320588C7B;
	Sun,  3 Nov 2024 22:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QUCskXqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222C088EF7; Sun,  3 Nov 2024 22:56:05 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4612C88C53
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 22:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6a2e66a7-9a2e-11ef-93fe-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6a2e66a7-9a2e-11ef-93fe-005056994fde;
 Sun, 03 Nov 2024 22:56:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=jRdKKmXtVLJwXkAijvyf1wYWgZdzUf5IOdZUzSyZYnc=;
 b=QUCskXqVDsONgw2traw+Qj8/C8fE9ipRurJ0wXYPe/jDXZ7U3RpOMVngbZzU82FLZTtZ5ba4+Z/DY
 wXkiFs2Ky56tjfDyMQnOTOHNcZBLTEuL4xtgrBUgXusI1K3RsC+8M8oVMKP6C1GkhMJucDGYoaC3qE
 BEhBw4eWQJMKbjw18QUH6rEnFLLdD9Diyfr/QVr4zPHJ5H3gOctJJGk3j/VvMgQQhabkTVV/pJmn9k
 y86Qn86pey+4tOyQLvimPKWbe/sCcmLr2/Wts+ReOLwzYwa+XY862Hqvi/PfxVQJXWSt5+vi0vdbGY
 BAMG5Ja3fIYBXhVPy63AWuoHLL4jX2g==
X-KPN-MID: 33|cKeDL8O1TwhLry0pxnW6S15Vi4IEA1lNrWrZ/27yUMnhCzGi+mhGBBrkQi5hn5h
 Sz/97SRVwJG40rarvsRbwcA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Pp5ZskTy6l+6R/qC1iDNOOTDeGYjpeLOpjYPgg4+JELaCRucGBwPr9tMJzJe9LR
 h8JuuYSkPBUFrdKmchWkrxQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6a01c3d9-9a2e-11ef-b66d-00505699b758;
 Sun, 03 Nov 2024 22:56:01 +0100 (CET)
Date: Sun, 03 Nov 2024 22:56:00 +0100
Message-Id: <87jzdk3rtb.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: sughosh.ganu@linaro.org, trini@konsulko.com, kettenis@openbsd.org,
 sjg@chromium.org, u-boot@lists.denx.de
In-Reply-To: <20241103173633.GA664967@robin.jannau.net> (message from Janne
 Grunau on Sun, 3 Nov 2024 18:36:33 +0100)
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
 <20241103173633.GA664967@robin.jannau.net>
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

> Date: Sun, 3 Nov 2024 18:36:33 +0100
> From: Janne Grunau <j@jannau.net>
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
> >From my point of view it's clear that "io_lmb*" is separate from the
> main memory lmb. It manages the IO virtual address space of devices and
> it is fine that there as many (io_)lmb instances as there are IO virtual
> address spaces. These do not have to be managed via struct lmb and
> looking at the minimal io_lmb* API a simpler implementation would work.
> An alternative implementation would be duplicated code and reusing the
> existing tested lmb code is desireable.
> If we want a stronger distinction between lmb and io_lmb we could hide
> struct lmb from io_lmb.

Thanks Janne, you explained that very well and I 100% agree.
