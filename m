Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68216D29FA9
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 07:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AA788E43;
	Wed,  6 Nov 2024 08:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="XtEWKeqx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMIp+CcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6908900E; Wed,  6 Nov 2024 08:13:43 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C938388E0F
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 08:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BB9E5114018A;
 Wed,  6 Nov 2024 02:13:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 02:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730877219; x=1730963619; bh=wGWPfmPhTx
 2t0NX5Bk9fR48GmMRvZXjoDiuozp4vgHU=; b=XtEWKeqxdSDIoPy81w0Xcqj6KT
 jTgBy9Y/OTl3au5q2OvDAIcv/K9xfvHdZnFRMqjxNd413YGm5i9u3oGetb2IS4f8
 bs6VnTOPkK05Vnc7sWASzJQuI6oLmjNFDEIvUzQ1mcyP1VQ7ZCERHC06MFh9Uz58
 edNimDu6AG7gSsv3CxAkuZz7+kU+EQCY7vCKgX+Ie3pomA8sORQlxyVNKC3KPtGQ
 o23AeHXEwXCBQsDI+2YdlTWPCXnLZ8ajwcUEKdmWneFr45DHpXHWnYjQRfy1mWUH
 zZiUyUV/ce16NlJB/JmJeaMDaJHtifYnNDvYECf6Fink8iNlzYtSrwVKGuFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730877219; x=1730963619; bh=wGWPfmPhTx2t0NX5Bk9fR48GmMRvZXjoDiu
 ozp4vgHU=; b=lMIp+CcDK877moW6TT65p20/yvLY5/69TUy8czv5eLDHJe6hPn8
 7dWGkQbe8AgVeoISc5aoZKG9S5TAGQ7YVHVbYUsdf+Ghs3OggC5bLPzWK3kaX+pO
 ukiL8bJOMXAe94je+LQ1RhDQKiWA4isKhf7xAD8u3QMRu4L9NUsHfeLSv2WzMJnG
 rHyklFPd2w2CziCA3upGRncrp2POYBHYyIpFFIHUwyRkUHdDk1m4TIvKSs9tWtwC
 Bixy7sA+6jyi8W4hH2yKOiSfSewUHhQu/jkyR2qvRo4kKM5FCctjAuKL+nvnTfap
 WWPfB8bRMaDYb11zx+jTI17qSxiDzodP/sw==
X-ME-Sender: <xms:IxcrZ4R3IyQc_hlpnemQi7n_CH0t7Uve0Uu0KZyrOfxOK3D5fRKaFg>
 <xme:IxcrZ1yXIC4hIog7q9IQBIovJtFeHFrqOzVz-bCxcfDxMgqjIdBD5Q53BY2AtIpUw
 HwRNjS_EB4jWLsqcpg>
X-ME-Received: <xmr:IxcrZ11yDTT0NXenFEuuvixRCKNW42x16TuzpI_uoX0yjK_U4OPI_2CB1v-7VRneF2BANGm7JxQdl_g2HAPjyfyvVRDgsGXYzl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddutdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
 ggtffrrghtthgvrhhnpefgudeuffelfeekgeeukedtheekjeettdfftddujefhvdehtefg
 iefgledtueefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuh
 hghhhoshhhrdhgrghnuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhhkrdhk
 vghtthgvnhhishesgihsgegrlhhlrdhnlhdprhgtphhtthhopehtrhhinhhisehkohhnsh
 hulhhkohdrtghomhdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhr
 ghdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehuqd
 gsohhotheslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:IxcrZ8CrGJeM8XWCLO3uqbLj_U8LKmDr6eYntNXi5eJwcmUZDy_i2g>
 <xmx:IxcrZxhlE5EpMFlfkPTeTrZdfgQE1AQ3OPs9UKFZLkKW_JD7dx4L3Q>
 <xmx:IxcrZ4o3HLW0v8S6wX9B4emETBxXbdaRgPToKeKQFNTjGnkPjIOvfA>
 <xmx:IxcrZ0gzv8hmGji4Z-e42Wy6tAFyvZoa93Z6A5cEfgtR6yPs8w_vjg>
 <xmx:IxcrZ5iwjv_rNAukGLfhVWMwqF-eEouCjVVS_wJ8vv5Tif9DK3nwH9Qn>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 02:13:38 -0500 (EST)
Date: Wed, 6 Nov 2024 08:13:37 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 kettenis@openbsd.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
Message-ID: <20241106071337.GB928468@robin.jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
 <20241103173633.GA664967@robin.jannau.net>
 <CADg8p94t3AQ_tsEwSpQEUu3cc3P0BtbZ=DE8k58Vtp6HFGo-Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADg8p94t3AQ_tsEwSpQEUu3cc3P0BtbZ=DE8k58Vtp6HFGo-Nw@mail.gmail.com>
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

On Wed, Nov 06, 2024 at 12:43:01AM +0530, Sughosh Ganu wrote:
> On Sun, 3 Nov 2024 at 23:06, Janne Grunau <j@jannau.net> wrote:
> >
> > On Sun, Nov 03, 2024 at 07:53:36PM +0530, Sughosh Ganu wrote:
> > > On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > > >
> > > > > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > Date: Fri, 1 Nov 2024 17:17:22 +0530
> > > > >
> > > > > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > > > > >
> > > > > > The changes in "Make LMB memory map global and persistent" [1] break
> > > > > > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > > > > > iommu present on Apple silicon systems.
> > > > > >
> > > > > > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > > > > > do not overlap. The physical memory on this systems starts depending on
> > > > > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > > > > > manage these distinct regions in a single LMB map. In addition every
> > > > > > device has its own iommu and IO address space so sharing a single memory
> > > > > > map between all iommu instances is not necessary.
> > > > > >
> > > > > > To fix this issue restore the used subset (add, alloc and free) of the
> > > > > > previous pointer based LMB interface with "io_" as prefix.
> > > > > >
> > > > > > To ensure that low level lmb functions do not use the global LMB
> > > > > > variable reorder lib/lmb.c so that the variable is not visible.
> > > > > >
> > > > > > Tested with patches from my "Fix device removal order for Apple dart
> > > > > > iommu" series [2] to fix a separate issue.
> > > > > >
> > > > > > The cosmetic commit has two checkpatch warnings in existing code which I
> > > > > > ignored.
> > > > > >
> > > > > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > > > > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> > > > > >
> > > > > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > > > > ---
> > > > > > Janne Grunau (4):
> > > > > >       lmb: Do not use global LMB variable in _lmb_free()
> > > > > >       lmb: cosmetic: reorder functions and global LMB variable
> > > > > >       lmb: Add basic io_lmb functionality
> > > > > >       iommu: apple: Manage IOVA separately from global LMB mem map
> > > > >
> > > > > Thanks for these changes. I am currently on leave, but will take a
> > > > > look at this in detail next week. But on a cursory glance, I have to
> > > > > say that I am not entirely satisfied with this solution as well. With
> > > > > these patches, we now have a disparity in terms on how we view the LMB
> > > > > memory map -- we have a global map for RAM address range, but a per
> > > > > device one for IOVA's. I understand that IOVA's are supposed to be
> > > > > per-device,
> > > >
> > > > The IVOA's are per-stream.  Multiple devices might share a single
> > > > stream.
> > > >
> > > > > but then I think that perhaps LMB is not the right way to
> > > > > solve this. This was fine earlier, when the entire LMB implementation
> > > > > in U-Boot was local, but that is not the case now. I wonder if there
> > > > > can be a different, non-LMB way to implement this.
> > > >
> > > > Of course there can be a different implementation.  But why add a
> > > > separate implementation for what is essentially the same problem:
> > > > allocate blocks out of an address space.
> > >
> > > My primary concern here is to prevent setting a precedent that it is
> > > okay to have a local, per caller lmb instance.
> >
> > I think the issue is thinking this is per caller. It is not (primarily)
> > by caller. It is one LMB instance per managed independent address space
> > block. Apple silicon SoCs have multiple independent iommus. Each iommu
> > can handle multiple address spaces (streams, only partially implemented
> > in the u-boot driver.
> >
> > > If it is allowed for
> > > one caller, it becomes difficult to say no to someone proposing a
> > > similar approach later. In any case, based on how the allocation logic
> > > works, with all the addresses being allocated from the IOMMU driver's
> > > map function callback, why can there not be a single instance of an
> > > iova lmb structure. That would at least ensure some kind of parity on
> > > how the lmb maps are maintained.
> >
> > There are multiple fully independent IOVA spaces. I doesn't make sense
> > to allocate them from a single pool.
> >
> > > > Before you changed the goal posts, lmb did exactly that.  The only
> > > > problem was that there were multiple lmb instances covering the same
> > > > "main memory" address space.
> > >
> > > I had provided an explanation of the situation that existed prior to
> > > these changes in a writeup [1]. And that writeup had clearly provided
> > > the two possible solutions to fix the issue with EFI allocated memory
> > > working with LMB. And it was decided through discussion on that
> > > writeup as well as on the mailing list that this was the approach to
> > > be taken.
> >
> > That document missed due to unfortunate circumstances one special case
> > in the LMB usage. Consolidating all struct lmb referring main memory
> > into a single opaque object is useful. Please let's move on to fix the
> > single usage which broke due to the change.
> >
> > From my point of view it's clear that "io_lmb*" is separate from the
> > main memory lmb.
> 
> Yes, that is my view as well. Which is why I was proposing a different
> mechanism for the IOVA allocations.

It's not clear to me what you mean with "different mechanism". My
understanding was that it would be completely separate from lmb but that
is at conflict with the statement of code reuse below.

> > It manages the IO virtual address space of devices and
> > it is fine that there as many (io_)lmb instances as there are IO virtual
> > address spaces. These do not have to be managed via struct lmb and
> > looking at the minimal io_lmb* API a simpler implementation would work.
> 
> Okay. Although I wonder, given your explanation of multiple, per
> device IO VA spaces, how would these spaces be identified, if not
> through an instance of the lmb structure.

If the u-boot driver would gain support for that, each IOVA space would
have its own lmb instance. On iommu side the IOVA spaces are called
stream and the driver would have one lmb structure for each stream.

> > An alternative implementation would be duplicated code and reusing the
> > existing tested lmb code is desireable.
> 
> Yes, I agree.
> 
> > If we want a stronger distinction between lmb and io_lmb we could hide
> > struct lmb from io_lmb.
> 
> Okay, but I am not sure how you would be able to achieve that. Are you
> proposing using the region lists directly? If so, I would say that if
> we are using the LMB code for the allocations, we might as well use
> the structure.

The most basic way would be a struct io_lmb which just embeds struct
lmb and the io_lmb_* API would use struct io_lmb pointers as arguments.
This would provide some type safety but I don't think it is necessary as
the lmb API doesn't use struct lmb pointers (with the exception of
lmb_push/lmb_pop);

best regards,
Janne
