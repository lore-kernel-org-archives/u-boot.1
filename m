Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C02D29FA8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 07:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352FC88E0F;
	Wed,  6 Nov 2024 08:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="wiZIGPlZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="dd15du0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB72588E3A; Wed,  6 Nov 2024 08:21:11 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA6188D09
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 08:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 680FD138009A;
 Wed,  6 Nov 2024 02:21:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 02:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730877668; x=1730964068; bh=QxM/Og+jfw
 en5K7dF5rYt7kaGr5Yacn7VGAmSON1x+4=; b=wiZIGPlZ9jxSIm6VFPOOuc+XNX
 Eg6PRWrDYDuWHbHO2P24vr1iZ+UwwORU/1vY3dijS44SkeSCFIvM0uXarZaoXa6a
 k8AZCPFC76cUA+abFpnugqK6/qyIOhKipluXhar767rnIKXNGoDRcJR1dGwc/P91
 IOJ5ULNGwfHw/gN49VRy9hGlfc6xul1JS8i0+tvU4+jaQzln1+9ZE+jTH58buPgc
 kPdgYxeQEiQlT7qF/+ueriVYZOug11CrQX0sL7croSgHqfWM6b4ubTI75RAGI9kN
 MrxVsBiqjPyb35A+XjUH1cCaSRzwhZpqfUO8sKWA+iuM9UHx+WlrrwFJntXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730877668; x=1730964068; bh=QxM/Og+jfwen5K7dF5rYt7kaGr5Yacn7VGA
 mSON1x+4=; b=dd15du0MPQ3XKOGwqrzW+2bR2j3V7NoyQWuAsv0Gy+97bbvXs4r
 cYkNV/4UWF8HIHFSdisaR0Vh3q0UtQgkTjYKtcz9K7O3r7ZRQg3v3dqhk5pB1GAy
 KPPojEj613J/Yfbmxzj+N3ptOZ+yCyeXCdyJwp6jPWcgS/o7kquHRaOwvMCbwZGv
 TM3COg5HfFwE7VSP8AKb2LSFkKWj1h+/QFGLpTwuzrx+9hIxQ44L0QalgDXmc+6E
 sq6uNzJ9TU22RdY0yeKcKG/ZxklDDuQqtT0sEnSrUVy5eS5j7h40qb598ABnA47M
 O+SLCLW944JZDV+8557Ql0t207j/tu+xmtw==
X-ME-Sender: <xms:5BgrZ6OJTHWSYfPKL865Gdc5SkP4hE9TadmaT_4LfeA7h_u9tkkzqw>
 <xme:5BgrZ48oeTml0NAUY6AWxFxFqf_58BErIYlzlJy7FTn6yQJjJZBKUlzS_P9pVUEea
 KjVWae5QcKhyMSvqjA>
X-ME-Received: <xmr:5BgrZxQXO7Dwpykcjj-XvP8a8th_ztSarHm9B2rTJsEiWrV1acZuLaWUAl-mpPz6NkHDv0ZN6nZRT_4bY9JV6N_uhlXo9Hgkhmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
 ggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedugeet
 hfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepshhughhhohhshhdrghgrnhhusehlihhnrghrohdroh
 hrghdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthho
 pehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehsjhhgsegthh
 hrohhmihhumhdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhig
 rdguvg
X-ME-Proxy: <xmx:5BgrZ6s3OAM4waLZm-BIHpcGtMxrtbg83D76u_Swj0KFMYQWhYrcoA>
 <xmx:5BgrZyca27ig4JQ5NiJ7LLCsywfhdjT4yoTdEskdadEIhv5FhJCMLA>
 <xmx:5BgrZ-3Io_05sdytYMosM7B8SiERT6m7-LPhy7PGJq7MQYweruVSeg>
 <xmx:5BgrZ28MW1g-fXf3ktH-NXvGA3tx6iK5obibhy3DXcJWvRSDcGtu3g>
 <xmx:5BgrZ_EI_dkmJfuR4lJ3Cx-eaAnKTirBQ3q003AzK1eXtL2ZP90W-w_6>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 02:21:07 -0500 (EST)
Date: Wed, 6 Nov 2024 08:21:06 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] lmb: Add basic io_lmb functionality
Message-ID: <20241106072106.GC928468@robin.jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <20241101-io_lmb_apple_dart_iommu-v1-3-fe4b9a74d47c@jannau.net>
 <CADg8p95AbiUTFcmYrs0idPEyvq=hT78FzHbSiR3sPVCUh+ns4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADg8p95AbiUTFcmYrs0idPEyvq=hT78FzHbSiR3sPVCUh+ns4w@mail.gmail.com>
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

On Wed, Nov 06, 2024 at 12:48:45AM +0530, Sughosh Ganu wrote:
> On Fri, 1 Nov 2024 at 15:47, Janne Grunau <j@jannau.net> wrote:
> >
> > These functions can be used with struct lmb pointers and will be used to
> > manage IOVA space in the apple_dart iommu driver. This restores part of
> > the pointer base struct lmb API from before commit ed17a33fed29 ("lmb:
> > make LMB memory map persistent and global").
> > io_lmb_add() and io_lmb_free() can trivially reuse exisiting lmb
> > functions. io_lmb_setup() is separate for unique error log messages.
> > io_lmb_alloc() is a simplified copy of _lmb_alloc_base() since the
> > later has unused features and internal use of the global LMB memory map.
> >
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  include/lmb.h | 47 +++++++++++++++++++++++++++++++++++++
> >  lib/lmb.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 121 insertions(+)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 2201d6f2b67bb605dbff015fa2a6a008b780c57a..9cb3ba8289e10ab92bea135d248580e44880e3e2 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -156,6 +156,53 @@ static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> >         return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
> >  }
> >
> > +/**
> > + * io_lmb_setup() - Initialize LMB struct
> > + * @lmb: IO LMB to initialize
> > + *
> > + * Add the IOVA space [base, base + size] to be managed by io_lmb.
> > + *
> > + * Returns: 0 on success, negative error code on failure
> > + */
> > +int io_lmb_setup(struct lmb *io_lmb);
> > +
> > +/**
> > + * io_lmb_add() - Add an IOVA range for allocations
> > + * @io_lmb: LMB to add the space to
> > + * @base: Base Address of region to add
> > + * @size: Size of the region to add
> > + *
> > + * Add the IOVA space [base, base + size] to be managed by io_lmb.
> > + *
> > + * Returns: 0 if the region addition was successful, -1 on failure
> > + */
> > +long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> > +
> > +/**
> > + * io_lmb_alloc() - Allocate specified IO memory address with specified alignment
> > + * @io_lmb: LMB to alloc from
> > + * @size: Size of the region requested
> > + * @align: Required address and size alignment
> > + *
> > + * Allocate a region of IO memory. The base parameter is used to specify the
> > + * base address of the requested region.
> > + *
> > + * Return: base IO address on success, 0 on error
> > + */
> > +phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align);
> > +
> > +/**
> > + * io_lmb_free() - Free up a region of IOVA space
> > + * @io_lmb: LMB to return the IO address space to
> > + * @base: Base Address of region to be freed
> > + * @size: Size of the region to be freed
> > + *
> > + * Free up a region of IOVA space.
> > + *
> > + * Return: 0 if successful, -1 on failure
> > + */
> > +long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size);
> > +
> >  #endif /* __KERNEL__ */
> >
> >  #endif /* _LINUX_LMB_H */
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 2ce91f7521cfe58577b092fdaea8004b17f0eeff..cbf1ee0df93a9cb0cfea571a4caebae09646595e 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -351,6 +351,80 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> >         return addr & ~(size - 1);
> >  }
> >
> > +/*
> > + * IOVA LMB memory maps using lmb pointers instead of the global LMB memory map.
> > + */
> > +
> > +int io_lmb_setup(struct lmb *io_lmb)
> > +{
> > +       int ret;
> > +
> > +       ret = alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
> > +                        (uint)LMB_ALIST_INITIAL_SIZE);
> > +       if (!ret) {
> > +               log_debug("Unable to initialise the list for LMB free IOVA\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       ret = alist_init(&io_lmb->used_mem, sizeof(struct lmb_region),
> > +                        (uint)LMB_ALIST_INITIAL_SIZE);
> > +       if (!ret) {
> > +               log_debug("Unable to initialise the list for LMB used IOVA\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       io_lmb->test = false;
> > +
> > +       return 0;
> > +}
> 
> In the current use case, the above data structure is getting allocated
> as part of the driver's probe function. The resource should be free'd
> from the driver's remove function -- that should happen through a
> corresponding alist_uninit() call.

yes, I was mislead by that not happening for the global lmb. I'll add a
io_lmb_teardown() and use it in the remove callback.

I'll send a v2 with above change once it's clear that this is an
acceptable approach. See my reply to [Patch 0/4].

Janne
