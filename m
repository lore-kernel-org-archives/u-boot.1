Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CC7D12D79
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 07:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3759B8921A;
	Mon, 11 Nov 2024 08:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="jsHcaHp+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ra6HuUoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E7E8921A; Mon, 11 Nov 2024 08:01:58 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C9989110
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0898C11400EC;
 Mon, 11 Nov 2024 02:01:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 11 Nov 2024 02:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1731308513; x=1731394913; bh=UGN4952wFO
 2UEAN5nzEC6tp4dDNhj3mFVOGWA78wVQs=; b=jsHcaHp+5LLgw5s+Mnqa05lBq+
 2BYynFd9qd1rUMIG27Su4RuGpI7ng6+bzMtnnrhdrDjWrnhpgizhRxj3D90IiZOg
 5/2AqLZlwZs4qE9fximk6aVIXTrop3tTup+1lrBipOYdYALLh0n6aNx3rGFXgI/y
 fvmbby8Fr3gKUKqYPdafXmfyIgNcx0PinXiJl7fLsBXFEHD3d68/mFF7QqkjUQ7o
 FHvcnBlC4X8SgxzKzuvK47W0Q/V/mnDuAMJFh1mEUHnHfrcGgggxF9H9/NfDqgIb
 8B7tESnYhByYwtTp+X2I+OqmV2+gMl6rRqDaAWkGxViTZrtE0k+g00pcYS7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1731308513; x=1731394913; bh=UGN4952wFO2UEAN5nzEC6tp4dDNhj3mFVOG
 WA78wVQs=; b=Ra6HuUoSkzVL/oZMUGcKJYBt2FEMXcsn8Ykl7NB6AVnOyafjLqh
 UKKXaFO42Gif1FRkb8s6qZhjO717cm6OLmEqG44Xa/vimEPZQ0JMbVAELpBY21+6
 SMeaRXWVwZ4Z382SObuviB6MooTuuOcKPXEXhkHXnPos9rH3PyFH4Oor3s1rwass
 hNTNXxmczoR3Y+LPuTb/CDbB/tcF5hcha2yaP1VCfT3j7EfQUGPP3u9+AAIs9Mce
 mAg7BhNlye8SrcW1d2QPXUgmUs1DWnyOUlncsZ9aRyjGn1nbTSGhjG+QSfJfqk7X
 nz2hmrCO4jA+hbl2JDh3lSHnD+j6mMtMUBw==
X-ME-Sender: <xms:4KsxZ2O0tRDD-Cd2IVeGR4LGxfGNQ1brv0pR4sNDhfNalM3X2LLT_g>
 <xme:4KsxZ0_cqMqfbT0AvoOWjaM_1HnJ2Ucq-BrQ7e_MzJMGn7uCezafKVkwGByeTeCkW
 aB8ECM75F0McnpDWcA>
X-ME-Received: <xmr:4KsxZ9QfCZKN3OAl_Llv09aKI3V9k_EiP4dfaJG7jCNUiKjNtHj6bi9idoKXpv3zKIMXRe1LO0fdBAUltnbYd9cQjqYUL9vxL8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugddutddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
 ggtffrrghtthgvrhhnpefgudeuffelfeekgeeukedtheekjeettdfftddujefhvdehtefg
 iefgledtueefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrh
 hinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehkvghtthgvnhhishesohhp
 vghnsghsugdrohhrghdprhgtphhtthhopehsuhhghhhoshhhrdhgrghnuheslhhinhgrrh
 hordhorhhgpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:4KsxZ2txztTJPUWW0BNtGvAW71DIsPHxZ-_y-bYFF9Yy1ZOvz7puHw>
 <xmx:4KsxZ-cwtKrKScGYbbdPcdqKiYkpp7TEAJ9ivPNH8QlJg8UOfUtQmw>
 <xmx:4KsxZ634gnoJqe26Vp72NmKJosK_1RnZDsL5DR-tIfnogBysEml6_A>
 <xmx:4KsxZy_hSI2rrhTcdjosCu-oAEsJ-q4lqcxQHy2uqPfbSWSBut7ulA>
 <xmx:4KsxZ7EWqqjQguXmWM7qneX3g8iZRZUYfkrmLWKLnpfU-0UqSlXVSv8n>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 02:01:52 -0500 (EST)
Date: Mon, 11 Nov 2024 08:01:50 +0100
From: Janne Grunau <j@jannau.net>
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] Fix IOVA allocation in Apple dart iommu after
 global LMB mem map changes
Message-ID: <20241111070150.GA1962490@robin.jannau.net>
References: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
 <20241111025211.GQ3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111025211.GQ3600562@bill-the-cat>
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

On Sun, Nov 10, 2024 at 08:52:11PM -0600, Tom Rini wrote:
> On Wed, Nov 06, 2024 at 10:10:08PM +0100, Janne Grunau via B4 Relay wrote:
> 
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
> > Changes in v2:
> > - added io_lmb_teardown() and use it in dart's remove callback
> > - removed leftover from copy-n-paste in io_lmb_setup() documentation
> > - added Tom's Rb:
> > - Link to v1: https://lore.kernel.org/r/20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net
> 
> Sorry for the late reply here, can you please rebase on top of current
> master? A few other changes / clean-ups have gone in and I can't easily
> rebase and confirm the changes right now. Thanks!

done. I redid the cosmetic reorder patch to ensure the other changes to
lib/lmb.c are not inadvertently reverted. Please apply Patch 1 + 2
quickly to avoid the risk of having to do it again.

best regards

Janne

