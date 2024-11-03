Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A305D11182
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 17:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAC588E41;
	Sun,  3 Nov 2024 18:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="tI0m7hdm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4qqmA3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5437688E41; Sun,  3 Nov 2024 18:36:43 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271AB88F7B
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 18:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 96DB62540112;
 Sun,  3 Nov 2024 12:36:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Sun, 03 Nov 2024 12:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730655398; x=1730741798; bh=/pZRVlYqEs
 0lVSK4cETfOyUqx8fHTQHTBYPjxP020as=; b=tI0m7hdmWJHimrjIz9q3Plgi5g
 cMjLIvxMHxruQaMxl+Gm451wBU5vlFoYCVarZJx5FU2bjdyZtHoiIJD7iq8XMOA9
 Dr3jfRb//0NxhRgXIXpWD2vyQHPJfCRAEUGkp3lOStn4vXNH5GIw0VLzZr8uOqtU
 0yKj+803H/h3P6jw1N7ig6ZUx/U9UbIrZI6lVE30tG82U3q161G59MLoEun6xd09
 xJd7Ei9JCNev6Iasx5/zpHWFw0oTB21JwnbFHbeya1pzqrQ4Z4/xQwFZngqbtIBD
 EY/CDorleAZ3od1t5j5X/IO0NKyXy5ybVtHb/Jx6JfifcB9UcLhywLDDBWyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730655398; x=1730741798; bh=/pZRVlYqEs0lVSK4cETfOyUqx8fHTQHTBYP
 jxP020as=; b=X4qqmA3KhsFfJWvXCCrDsIBeWZmyfhD5Njq+bwl2dWD4y95wazD
 J7pBXNFDRRHSJfgoqVa3IXCaldsEWgKNaALRkPctU82ay1f8SDzeFsoM/Tz2ON/E
 leJ7E313fOD03ihdJL3GtC9Nvg2AmK91URCjnEaX1xpNwKKGpQcvD9IFeu/Vzcuh
 /hGXehs/LmwC+YaVwsXIxFn5+LGf17cwbLlkr2uONswTPUapFX94i1J2RveZnF3V
 wNmZ8hL4IBplL5S4PG6P1Kw66Ctt4hcaC552BiA32PjrcBIAfbEHqRjlVSHuJ5i/
 fdhPhbj4HRfd4MDaQeXbvfDa3B+QNUDZugg==
X-ME-Sender: <xms:pbQnZ5wZtNH3_6HfRkLkOmkSdtMF6bBCl4VgsRdLXdnTp65YKTiDQA>
 <xme:pbQnZ5Qrd0QrY3hMnQjmAJtz3CuYyMoUA4A-bXZqpZ9VmQUtQY0h2E-xPIH4-iYTr
 YCoaA5HGdDAKj2L0ew>
X-ME-Received: <xmr:pbQnZzXetLMjXvwTcJsYUT1zf8lLnxq2Zez1mhxmvCcrkGJpDBnKlRUtvKG-Jj90f9PtdRJLtY8SGHBaZrVBCILNIcUlIALYepQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedguddtgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepgfduueffleefkeegueektdehkeejtedtffdtudejhfdvheet
 gfeigfeltdeufeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
 thdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
 hughhhohhshhdrghgrnhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghrkhdr
 khgvthhtvghnihhsseigshegrghllhdrnhhlpdhrtghpthhtohepthhrihhniheskhhonh
 hsuhhlkhhordgtohhmpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdho
 rhhgpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepuh
 dqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:pbQnZ7imZRcZd_BJEChCrV5fQCcvhTpWEJNaSB27cMAEFE1ZFQ1YLw>
 <xmx:pbQnZ7AQ9cdh0hHMxctxQDvkS1c4Vvs9w37dvcZ9pwk8mDNbCxEJ7A>
 <xmx:pbQnZ0LXfNNqcG8Y1GgSMb_dVwn47A7N9bkl11tcl-u8h1St3t-M0A>
 <xmx:pbQnZ6CEAlUTosX6RC9nTb2_gwUdS6etcB2ucaHgzo9ycSrAxo5epA>
 <xmx:prQnZ90dC20YaUwQlRUGU4n2v2jLZJvYAFzs7rkdpnQvXRueGfESISFX>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 12:36:36 -0500 (EST)
Date: Sun, 3 Nov 2024 18:36:33 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 kettenis@openbsd.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] Fix IOVA allocation in Apple dart iommu after global
 LMB mem map changes
Message-ID: <20241103173633.GA664967@robin.jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <CADg8p97H9eqncSEGjZF5EGP2M9Y10MmV28RwSdtsW+T8fSURiw@mail.gmail.com>
 <87v7x63p3c.fsf@bloch.sibelius.xs4all.nl>
 <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADg8p96csvFbyWpgajy_ewZMXRCsKstbhGFMnDUcGnG9e+QA3g@mail.gmail.com>
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

On Sun, Nov 03, 2024 at 07:53:36PM +0530, Sughosh Ganu wrote:
> On Sat, 2 Nov 2024 at 16:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > Date: Fri, 1 Nov 2024 17:17:22 +0530
> > >
> > > On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> > > >
> > > > The changes in "Make LMB memory map global and persistent" [1] break
> > > > mapping DMA memory in the USB xHCI driver when using the apple_dart
> > > > iommu present on Apple silicon systems.
> > > >
> > > > The IOVA space used by the u-boot driver (low 4GB) and physical memory
> > > > do not overlap. The physical memory on this systems starts depending on
> > > > the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> > > > manage these distinct regions in a single LMB map. In addition every
> > > > device has its own iommu and IO address space so sharing a single memory
> > > > map between all iommu instances is not necessary.
> > > >
> > > > To fix this issue restore the used subset (add, alloc and free) of the
> > > > previous pointer based LMB interface with "io_" as prefix.
> > > >
> > > > To ensure that low level lmb functions do not use the global LMB
> > > > variable reorder lib/lmb.c so that the variable is not visible.
> > > >
> > > > Tested with patches from my "Fix device removal order for Apple dart
> > > > iommu" series [2] to fix a separate issue.
> > > >
> > > > The cosmetic commit has two checkpatch warnings in existing code which I
> > > > ignored.
> > > >
> > > > [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
> > > > [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/
> > > >
> > > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > > ---
> > > > Janne Grunau (4):
> > > >       lmb: Do not use global LMB variable in _lmb_free()
> > > >       lmb: cosmetic: reorder functions and global LMB variable
> > > >       lmb: Add basic io_lmb functionality
> > > >       iommu: apple: Manage IOVA separately from global LMB mem map
> > >
> > > Thanks for these changes. I am currently on leave, but will take a
> > > look at this in detail next week. But on a cursory glance, I have to
> > > say that I am not entirely satisfied with this solution as well. With
> > > these patches, we now have a disparity in terms on how we view the LMB
> > > memory map -- we have a global map for RAM address range, but a per
> > > device one for IOVA's. I understand that IOVA's are supposed to be
> > > per-device,
> >
> > The IVOA's are per-stream.  Multiple devices might share a single
> > stream.
> >
> > > but then I think that perhaps LMB is not the right way to
> > > solve this. This was fine earlier, when the entire LMB implementation
> > > in U-Boot was local, but that is not the case now. I wonder if there
> > > can be a different, non-LMB way to implement this.
> >
> > Of course there can be a different implementation.  But why add a
> > separate implementation for what is essentially the same problem:
> > allocate blocks out of an address space.
> 
> My primary concern here is to prevent setting a precedent that it is
> okay to have a local, per caller lmb instance.

I think the issue is thinking this is per caller. It is not (primarily)
by caller. It is one LMB instance per managed independent address space
block. Apple silicon SoCs have multiple independent iommus. Each iommu
can handle multiple address spaces (streams, only partially implemented
in the u-boot driver.

> If it is allowed for
> one caller, it becomes difficult to say no to someone proposing a
> similar approach later. In any case, based on how the allocation logic
> works, with all the addresses being allocated from the IOMMU driver's
> map function callback, why can there not be a single instance of an
> iova lmb structure. That would at least ensure some kind of parity on
> how the lmb maps are maintained.

There are multiple fully independent IOVA spaces. I doesn't make sense
to allocate them from a single pool.

> > Before you changed the goal posts, lmb did exactly that.  The only
> > problem was that there were multiple lmb instances covering the same
> > "main memory" address space.
> 
> I had provided an explanation of the situation that existed prior to
> these changes in a writeup [1]. And that writeup had clearly provided
> the two possible solutions to fix the issue with EFI allocated memory
> working with LMB. And it was decided through discussion on that
> writeup as well as on the mailing list that this was the approach to
> be taken.

That document missed due to unfortunate circumstances one special case
in the LMB usage. Consolidating all struct lmb referring main memory
into a single opaque object is useful. Please let's move on to fix the
single usage which broke due to the change.

From my point of view it's clear that "io_lmb*" is separate from the
main memory lmb. It manages the IO virtual address space of devices and
it is fine that there as many (io_)lmb instances as there are IO virtual
address spaces. These do not have to be managed via struct lmb and
looking at the minimal io_lmb* API a simpler implementation would work.
An alternative implementation would be duplicated code and reusing the
existing tested lmb code is desireable.
If we want a stronger distinction between lmb and io_lmb we could hide
struct lmb from io_lmb.

Janne
