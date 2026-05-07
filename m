Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7649BCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097688468B;
	Thu,  7 May 2026 10:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="Krx387IS";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpRWpcJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7072D84A26; Thu,  7 May 2026 10:35:24 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41DA84687
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D7D24EC0109;
 Thu,  7 May 2026 04:35:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 04:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1778142920; x=1778229320; bh=i3IpRpvcjC
 Xw4ieFew/phd3fIhv7PTV74hijYW5EnpA=; b=Krx387ISAqZuRjBvW7ei+rnBqw
 zNq3szFceHC5nGSpN1tNOI1F9VvGBw0uI+OUBmmlI12K6lR9OcALjSzzOmMuT0/4
 +FXmwkZRBxKN3TybioKp3r9rA5AQVjsNR744exym6UP2gmtZaYmgOg1EiXiDMk0G
 PZw+4DboUodI+qNEbar44GN6hlUuky7vU4IsA7ey2TzkhGCHiPVsI9pGPECHZ6mt
 jPKLi25r/zMVjeCrOdhq0IRWsje/fUzKXysp1KQPm3rrLIQJ8BcHFzMa9wpizIQx
 SKmq4zRP2tiVFIEIOblZeSuVPbqzKI0vhC4qzP/TfrWQs3akIyMrgYKifRAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1778142920; x=1778229320; bh=i3IpRpvcjCXw4ieFew/phd3fIhv7PTV74hi
 jYW5EnpA=; b=YpRWpcJBDS/zb9bYo6eutRqpNdfajx0sEMqNm8b6yI86Htpk97e
 YY6HeOcOOoclagGXNJ5C6RqlypBEh+jVJut1TlxlO30ksFdNqL4/RQE29p/hFv9j
 dVWqldZw4JMdLAc/+pYoaI0NVXyINghciYrhG2ciqQhymhFhn6TnYVhrRo78ftGo
 tIVYa2c6JdQuuKyqSPYw0rkbDTdEnx+ZTZyG0hq4TKzjWs3DHA0IPEuKW9ak9QEJ
 n5tSMnh4nxu3t4dD88fuM4ZbMP+x13qi0t2dV00EwZ9GZsIYHtG7RpaghBJAwiTl
 2WC/Lk3KvxCoPO7sxd0u1ZMYjwPKBN2xowQ==
X-ME-Sender: <xms:yE78aXYlRHUl32J9rQhvlFYyThGNTutBG4-LYj8ynO2ZKzUAbpcXBg>
 <xme:yE78aVfy3JKff8KEZY6nPOtLoOskTin8ZRcH05OP0PaCSSqBP1IY3zHdzzz9aaYpN
 lpy_GNb36kVUP-kQjconiUlJbA-fosGUxuPzc8YEFr88TgVixirsYs>
X-ME-Received: <xmr:yE78aQIXjndKnImi0o6U7yXsMkFXHZ5laH5ZrqyGKGWdtd4g1mCjq8zJHMuYXVZoc203eE1JUY4k7Irm8voE4MWngZh5tAAEqFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejtddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
 ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
 ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
 drnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
 ohepmhgrrhhkrdhkvghtthgvnhhishesgihsgegrlhhlrdhnlhdprhgtphhtthhopehuqd
 gsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehkvghtthgvnhhishes
 ohhpvghnsghsugdrohhrghdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtg
 homhdprhgtphhtthhopehsuhhghhhoshhhrdhgrghnuhesrghrmhdrtghomhdprhgtphht
 thhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpth
 htohepmhhkohhrphgvrhhshhhovghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
 vghrohhmvgdrfhhorhhishhsihgvrhesrghrmhdrtghomh
X-ME-Proxy: <xmx:yE78aaK17PZ4aS3QIqzRrYv61xZuM5o6VP3uG9IWpMNASzOMsWh35g>
 <xmx:yE78aXVwj-PQN2J0uQchs3Hu0SOjpaJZQF9KdeCplVLfYlyXeQFRYw>
 <xmx:yE78abn9r8VBthZg9IyOg8Lcu0bBRJMqyNPNY-OmgruHRllSvs5d_Q>
 <xmx:yE78aVmOMiF5FeWnWqJ_Ewx_je7OjaGMMYDZTrrbdr3u1KxcTJd3Eg>
 <xmx:yE78aUi4W0dXT3c9dWj0pxmzZIKKhToyFudyxrEcWrNith-0ypir5NSl>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:35:19 -0400 (EDT)
Date: Thu, 7 May 2026 10:35:18 +0200
From: Janne Grunau <j@jannau.net>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, kettenis@openbsd.org, trini@konsulko.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 mkorpershoek@kernel.org, jerome.forissier@arm.com
Subject: Re: [PATCH] arm: apple: Add Apple M3 (t8122) support
Message-ID: <20260507083518.GB514139@robin.jannau.net>
References: <20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net>
 <87zf2ic9iw.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zf2ic9iw.fsf@bloch.sibelius.xs4all.nl>
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

Hej,

On Sat, May 02, 2026 at 01:53:43PM +0200, Mark Kettenis wrote:
> > From: Janne Grunau <j@jannau.net>
> > Date: Fri, 01 May 2026 16:07:16 +0200
> 
> > Apple's M3 SoC is similar to M1 and M2 but uses a different memory map.
> > The main difference is that RAM starts at 0x100_0000_0000 like on t600x
> > and t602x (M1 and M2 Pro/Max/Ultra). Otherwise IO blocks have been
> > rearranged.
> > U-boot's existing drivers are compatible with the hardware and M3 device
> > trees will carry "apple,t8103-*" compatible strings. Only
> > apple-atcphy-reset might need a new compatible due to USB4 / DisplayPort
> > changes the Linux driver has to deal with.
> > 
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  arch/arm/mach-apple/board.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > index 4cd8979bdc2..914b4581e7d 100644
> > --- a/arch/arm/mach-apple/board.c
> > +++ b/arch/arm/mach-apple/board.c
> > @@ -85,6 +85,75 @@ static struct mm_region t8103_mem_map[] = {
> >  	}
> >  };
> >  
> > +/* Apple M3 */
> 
> I think it makes more sense to keep things sorted based on the name
> and put M3 after M2 Ultra?  M2 is the odd one out here since it is
> identical to M1.

ack, I still think of t81xx and t60xx as two separate groups and group
them together but I think that's not maintainable in the long run.
This doesn't seem to hold for t6030 (M3 Pro) which looks more like an
extended M3 or M4 than a chopped down t6031 (M3 Max).

> > +
> > +static struct mm_region t8122_mem_map[] = {
> > +	{
> > +		/* I/O */
> > +		.virt = 0x210000000,
> > +		.phys = 0x210000000,
> > +		.size = 4UL * SZ_1G,
> 
> We should try to keep the regions aligned on 1G boundaries with sizes
> that are multiples of 1G as that allows for more efficient page
> tables.
> 
> I haven't looked at Apple's device tree for the t8122 (I don't think I
> have ever seen one).  But based on the t8122.dtsi from the asahi-wip
> branch, I'd suggest using two regions
> 
> 0x200000000: 4UL * SZ_1G
> 0x300000000: 1UL * SZ_1G
> 
> You could tag the region at 0x300000000 as /* NVME */ if the Apple dts
> doesn't suggest there are non-NVMe things in there.

Apple's device tree for the M3 Macbook Pro (J504) has only NVMe related
nodes in 0x300000000... (ignoring pmgr's and error-handler's views into
other devices). I'll split the regions and annotate the second one as
NVMe.

> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* I/O */
> > +		.virt = 0x700000000,
> > +		.phys = 0x700000000,
> > +		.size = SZ_1G,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* I/O */
> > +		.virt = 0xb00000000,
> > +		.phys = 0xb00000000,
> > +		.size = SZ_1G,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* I/O */
> > +		.virt = 0x580000000,
> > +		.phys = 0x580000000,
> > +		.size = SZ_512M,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* PCIE */
> > +		.virt = 0x5a0000000,
> > +		.phys = 0x5a0000000,
> > +		.size = SZ_512M,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> > +			 PTE_BLOCK_INNER_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* PCIE */
> > +		.virt = 0x5c0000000,
> > +		.phys = 0x5c0000000,
> > +		.size = SZ_1G,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> > +			 PTE_BLOCK_INNER_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* RAM */
> > +		.virt = 0x10000000000,
> > +		.phys = 0x10000000000,
> > +		.size = 8UL * SZ_1G,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > +			 PTE_BLOCK_INNER_SHARE
> > +	}, {
> > +		/* Framebuffer */
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> > +			 PTE_BLOCK_INNER_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* List terminator */
> > +		0,
> > +	}
> > +};
> > +
> >  /* Apple M1 Pro/Max */
> >  
> >  static struct mm_region t6000_mem_map[] = {
> > @@ -710,6 +779,8 @@ void build_mem_map(void)
> >  	if (of_machine_is_compatible("apple,t8103") ||
> >  	    of_machine_is_compatible("apple,t8112"))
> >  		mem_map = t8103_mem_map;
> > +	else if (of_machine_is_compatible("apple,t8122"))
> > +		mem_map = t8122_mem_map;
> 
> I'd probably move this down as well.

ack

I'll send a v2 shortly, thanks

Janne
