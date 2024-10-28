Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3DD5B154
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F4C89140;
	Mon, 28 Oct 2024 22:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="AxzGj9tu";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AskGPVOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CD289124; Mon, 28 Oct 2024 22:20:44 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363C4890A9
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0DEF8114019B;
 Mon, 28 Oct 2024 17:20:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 28 Oct 2024 17:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730150441; x=1730236841; bh=giL7ECRrwe
 /8uIv0wxMpOyIRkFZQrNqKlJ3HvdMRp+8=; b=AxzGj9tuYzXg5dUw3FqBn/+B/8
 phvFKIZpX3O8BRdpyzGC18YqlcgkCBaz0SEJL7KdiApoMo5oymSOAxV20jjqE/WW
 rrvV6yydEBDoPB5sbJlDcv5NUDL6Gv61WYzHNHnf1IzsO17eokaH9Ka5D9gSMVrt
 pUJlJI3+jtcUQ/d/z1WEnUekNhhODgZ3QAk6HyV7hNTcSjpBr7/cqI4+gn/neWCH
 +vRKRdvvNFf6REsUfAoqB6xG2NM135U0Z9RElIgKsZMHKSXNjeyfFC+FBk5MmA2E
 1rY1nK92561xkzfYPcrYzlpHQdhVJ0dJZrajI6LYz920MWfIPg/ECNlz1e7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1730150441; x=1730236841; bh=giL7ECRrwe/8uIv0wxMpOyIRkFZQ
 rNqKlJ3HvdMRp+8=; b=AskGPVOXR+r6hO2Edcq+Y3Q54K/iC16vh4Sw8+z2TRj/
 RhQcP0YtxGRtNofAOnJkR6ks1e1YdlFBPJw/tiyb2a1aM5FctFsPtKtkBsW7iLqo
 Q5XQ6sahQ7SIcICthwU0J72M8czxx23/572+YWPvZ+m0I6UuTR86i0w9s+01zXhh
 0OLE8n1Rs/9AQCl0bZiDwoKYZjIj7UdweRz/PpL7KgbEWn6uMhS93elOBvEjeBgJ
 yHeIBC/YPZ4kHImdyYOXJRuJogagdVr4lKBmgYO5rxR9/ZnI2RCBN+JGVMPmZu/5
 aR3JG21FjI6W5j1of6MKnPjEZoEYcmAlWyOGf9mQwA==
X-ME-Sender: <xms:KAAgZ26SwoRVgBiXDl79te8f3cTYeRS62RHZHiZ9pgIJOdOvU087oQ>
 <xme:KAAgZ_5Ixf--z21F1feD5ve7DiDU9NjKB13Iv0f7kgzPiUvSlHrqFj9OHK6aNJW-1
 vquhoBOM3Vf-UUMDgE>
X-ME-Received: <xmr:KAAgZ1egHKwahNT1D1dqXM91iCLtR9v3WIsVOLYIJykFVmqPY-scfyCqPgrbcmgAejeZoTvazPOnZmFF0axLOIM18qFfwko_yCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjrghnnhgvsehjrghnnhgruhdrnh
 gvtheqnecuggftrfgrthhtvghrnhepgeeugedvtdfgheeuuddtveeiheegfeetjeettedv
 geeulefhtdeiueejueeghedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhgrnhhnvgesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthho
 pedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhughhhohhshhdrghgrnh
 husehlihhnrghrohdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggv
 nhigrdguvgdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtth
 hopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehilhhirghsrdgr
 phgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepgiihphhrohhnrd
 hglhhpkhesghhmgidruggvpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgt
 phhtthhopehmrghrkhdrkhgvthhtvghnihhsseigshegrghllhdrnhhlpdhrtghpthhtoh
 epmhhitghhrghlrdhsihhmvghksegrmhgurdgtohhm
X-ME-Proxy: <xmx:KAAgZzLbVYcHB-cPsBOXb4BA7zVU4np94nxYwU8D-i5dMh-uwHGobg>
 <xmx:KAAgZ6IE2WzerOexbmIJC3x8t08vdM3OZuTfymehqyCl2WkNVKoMcg>
 <xmx:KAAgZ0whz5SnspGAdUsZdUBW1WnVphSuPYw3I8z02arfLBLdLmSyMQ>
 <xmx:KAAgZ-IGyYAeOupni0JfYtr6cG_Srxe8s3CF_cPphhsGn7f84d7mxA>
 <xmx:KQAgZ1YUtHJx38zE9QBaLa0kM7c0Ds2OOQn9CFFbiWBt_-GAn7dIUm6b>
Feedback-ID: i449149f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 17:20:39 -0400 (EDT)
Date: Mon, 28 Oct 2024 22:20:38 +0100
From: Janne Grunau <janne@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, asahi@lists.linux.dev
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
Message-ID: <ZyAAJsnV4uz2Btwy@robin>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826115940.3233167-6-sughosh.ganu@linaro.org>
X-Mailman-Approved-At: Mon, 28 Oct 2024 22:32:55 +0100
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

On Mon, Aug 26, 2024 at 05:29:18PM +0530, Sughosh Ganu wrote:
> The current LMB API's for allocating and reserving memory use a
> per-caller based memory view. Memory allocated by a caller can then be
> overwritten by another caller. Make these allocations and reservations
> persistent using the alloced list data structure.
> 
> Two alloced lists are declared -- one for the available(free) memory,
> and one for the used memory. Once full, the list can then be extended
> at runtime.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> ---
> Changes since V3:
> * Fix checkpatch warnings of spaces between function name and
>   open parantheses.
> * s/uint64_t/u64 as suggested by checkpatch.
> * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.

[...]
 
>  drivers/iommu/apple_dart.c           |   8 +-

[...]

> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 9327dea1e3..611ac7cd6d 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -70,7 +70,6 @@
>  
>  struct apple_dart_priv {
>  	void *base;
> -	struct lmb lmb;
>  	u64 *l1, *l2;
>  	int bypass, shift;
>  
> @@ -124,7 +123,7 @@ static dma_addr_t apple_dart_map(struct udevice *dev, void *addr, size_t size)
>  	off = (phys_addr_t)addr - paddr;
>  	psize = ALIGN(size + off, DART_PAGE_SIZE);
>  
> -	dva = lmb_alloc(&priv->lmb, psize, DART_PAGE_SIZE);
> +	dva = lmb_alloc(psize, DART_PAGE_SIZE);
>  
>  	idx = dva / DART_PAGE_SIZE;
>  	for (i = 0; i < psize / DART_PAGE_SIZE; i++) {
> @@ -160,7 +159,7 @@ static void apple_dart_unmap(struct udevice *dev, dma_addr_t addr, size_t size)
>  			   (unsigned long)&priv->l2[idx + i]);
>  	priv->flush_tlb(priv);
>  
> -	lmb_free(&priv->lmb, dva, psize);
> +	lmb_free(dva, psize);
>  }
>  
>  static struct iommu_ops apple_dart_ops = {
> @@ -213,8 +212,7 @@ static int apple_dart_probe(struct udevice *dev)
>  	priv->dvabase = DART_PAGE_SIZE;
>  	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
>  
> -	lmb_init(&priv->lmb);
> -	lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
> +	lmb_add(priv->dvabase, priv->dvaend - priv->dvabase);

no. This breaks everything. apple_dart is an iommu and used struct lmb
to manage the IO virtual address space. This has nothing to do
with system memory.
Depending on the allocation strategy this will cause all sorts of
problems since the IO and the physical memory address space does not
overlap on apple silicon devices. IOVA is for many devices only 32-bit
but physical memory starts at 0x10_0000_0000 or 0x100_0000_0000.
Every device has its own iommu / IOVA space so sharing the space between
all of them is another problem. I'd assume only theoretical due to the
limited driver support and memory use in u-boot.

My current plan to fix this is to resurrect the old lmb code under a
different name.

Not sure about the same change in sandbox_iommu but I guess it could be
ok as there is no sandbox.

Janne
