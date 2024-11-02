Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1E2E677F8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB66388FD6;
	Sat,  2 Nov 2024 11:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="qxdTqfbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6508901D; Sat,  2 Nov 2024 11:30:19 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450BA88FC4
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 79357ccd-9905-11ef-bc49-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 79357ccd-9905-11ef-bc49-005056992ed3;
 Sat, 02 Nov 2024 11:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=DuNn4xAl/tXpAdC/vdQ/6WkoXoaERXby1APBFFoEjCs=;
 b=qxdTqfbRuXdp1W83uPLjl8xikfc0BNaufdrIOwV4CvgeGPXl/v6uF0jK5GsqSwPLUk7U368lUk59a
 NScBHTjLVYnv4DiBSVH9gxTsz+zbfm4a6V/FRZBrAkHaonnJXYlFNQJmsbhCdvx0kuB42deEEIk5ox
 WzZvpCKMHT3AcQaCtShedslfy7KzGveN7C8veAxzpbhDrG/6UCE3a7mpv7PGn1KGoeEMZVT+wD061X
 //DtXIWRYMbnUreDExYzLPn4MtMmhhyw0KMu/S9EeQJoN4/IODQXeBeqb/erN8wAyjdlUiR9j35z4t
 p5iUmcUziadRNGgw3k+aKehh1RoYxLg==
X-KPN-MID: 33|LyVjNwPQx7ow4Jbtbkag5Ml2/J8ZE/SEEMDm2fsqlEZtvQezfu+OPDAirsEX9Cm
 m1y+XAgD3TDntHxHQi/AkdiqayUGtTaHSoCZkt16eNGY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|idsBwwIxx0Lug+84EiU4dpTCErsv3kSVKsx4Aa5J9jsfxaSrkvGUjS7CDxrNNW4
 EQzzrW77m1KHrKQRnIb2kdA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 73513a0e-9905-11ef-8884-00505699772e;
 Sat, 02 Nov 2024 11:30:16 +0100 (CET)
Date: Sat, 02 Nov 2024 11:30:15 +0100
Message-Id: <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: j@jannau.net, trini@konsulko.com, kettenis@openbsd.org,
 sjg@chromium.org, u-boot@lists.denx.de
In-Reply-To: <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 (message from Sughosh Ganu on Fri, 1 Nov 2024 17:17:22 +0530)
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
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

> From: Sughosh Ganu <sughosh.ganu@linaro.org>
> Date: Fri, 1 Nov 2024 17:17:22 +0530
> 
> On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> >
> > The changes in "Make LMB memory map global and persistent" [1] break
> > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > iommu present on Apple silicon systems.
> >
> > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > do not overlap. The physical memory on this systems starts depending on
> > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > manage these distinct regions in a single LMB map. In addition every
> > device has its own iommu and IO address space so sharing a single memory
> > map between all iommu instances is not necessary.
> >
> > To fix this issue restore the used subset (add, alloc and free) of the
> > previous pointer based LMB interface with "io_" as prefix.
> >
> > To ensure that low level lmb functions do not use the global LMB
> > variable reorder lib/lmb.c so that the variable is not visible.
> >
> > Tested with patches from my "Fix device removal order for Apple dart
> > iommu" series [2] to fix a separate issue.
> >
> > The cosmetic commit has two checkpatch warnings in existing code which I
> > ignored.
> >
> > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> > Janne Grunau (4):
> >       lmb: Do not use global LMB variable in _lmb_free()
> >       lmb: cosmetic: reorder functions and global LMB variable
> >       lmb: Add basic io_lmb functionality
> >       iommu: apple: Manage IOVA separately from global LMB mem map
> 
> Thanks for these changes. I am currently on leave, but will take a
> look at this in detail next week. But on a cursory glance, I have to
> say that I am not entirely satisfied with this solution as well. With
> these patches, we now have a disparity in terms on how we view the LMB
> memory map -- we have a global map for RAM address range, but a per
> device one for IOVA's. I understand that IOVA's are supposed to be
> per-device,

The IVOA's are per-stream.  Multiple devices might share a single
stream.

> but then I think that perhaps LMB is not the right way to
> solve this. This was fine earlier, when the entire LMB implementation
> in U-Boot was local, but that is not the case now. I wonder if there
> can be a different, non-LMB way to implement this.

Of course there can be a different implementation.  But why add a
separate implementation for what is essentially the same problem:
allocate blocks out of an address space.

Before you changed the goal posts, lmb did exactly that.  The only
problem was that there were multiple lmb instances covering the same
"main memory" address space.

> Earlier, we had
> functions for allocating and maintaining a memory map in the EFI
> memory module. I am wondering if we can use those functions in a
> common place, and use that implementation instead of having this in
> LMB.

Well, that implementation doesn't really have an external API, and has
the same prolem that it only supports a single address space.

> That way, every device which is looking for an IOVA map, can
> maintain one, and use the common functions to add memory space to it's
> map, and then use that memory for allocations. Also, based on your
> explanation above, I think that it should be the responsibility of the
> device to get the IOVA address range, and then pass those addresses to
> the IOMMU driver? Let us see what others have to say on this solution.
> If there is consensus, I can look at a solution once I am back.

No, as I said the IOVA address space is per-stream not per-device.

> -sughosh
> 
> >
> >  drivers/iommu/apple_dart.c |  16 +-
> >  include/lmb.h              |  47 ++++
> >  lib/lmb.c                  | 608 ++++++++++++++++++++++++++-------------------
> >  3 files changed, 406 insertions(+), 265 deletions(-)
> > ---
> > base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
> > change-id: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036
> >
> > Best regards,
> > --
> > Janne Grunau <j@jannau.net>
> >
> 
