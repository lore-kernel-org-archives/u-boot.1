Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400AAD5B164
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863928912C;
	Tue, 29 Oct 2024 09:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="GFU2fJj4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="khHiDliY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500C78910C; Tue, 29 Oct 2024 09:32:21 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94AB8913B
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 943D9138013A;
 Tue, 29 Oct 2024 04:32:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 29 Oct 2024 04:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730190737; x=1730277137; bh=hjJ6QQcKEJ
 ZSWn05mwrvfMoajKAJXJl0EUs3HVwkjg4=; b=GFU2fJj4VVPamTmvfEyORbZvce
 BxCPHibeSnLzmHT9wlIp1z2pRMwJDnYFYBlCfu8ti1tCxIf8woD4cTdJHxH57w92
 BB1r15b1EPBu/yxRxRnCbQqBH1sTILIskqla40/BPC9qga1Z4aKpivnAC/TS1BsF
 ZmupPJdFCjzrZOb+g3EKM2Wsaou5BLvyZuNGCqH97Q2EbJRrG1SEbYckESupsox7
 1784uaeJilxAZtEQEuln7P4UyfyGpMxClihn3CpPJw8S1p3Rn60yhBoRnHZf+o82
 hrIHKwLVZQBSmgTTSvKsHCAksEpPk+cz/HQMdlXY3l2HpgScN4q6d9sFH2nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730190737; x=1730277137; bh=hjJ6QQcKEJZSWn05mwrvfMoajKAJXJl0EUs
 3HVwkjg4=; b=khHiDliYbWJrRAt1ENYizH4NwWKGoO/3Mx8eiLI2/GWQVGMSZW0
 wBbIO5/b3QSLSORb6gxfIfPZSspFQLOloFU1ljOghfoVkL09lG/CNX637nSMvzP4
 umKIvtfOQi49b20MBfcjwiYjdsXjnP5bk0n7VNBhHmWIql5NGZY88dV1tx66mWqN
 /4nMLzFE6mWYC3c6qR2jXma36oQd2J3xzyVB3ROnt2mfo+Q/nizVMMIgMAGaj1Wv
 A2Hif9PogJaKeSm1z28FTYV94o1fegkJ4bRbtSaGhWmuYdQIrM+47HKwOoaXm6M3
 1GQRQ9ubgisfxFKiyAp5DgkxVz2f8qFXAzw==
X-ME-Sender: <xms:kZ0gZ-Wc5ITCalF2zFZgOTh2RVU-o02mLHzLyUdQRfvDdLpaNb91wg>
 <xme:kZ0gZ6mnXnstlzKpcx_kBwqJ5Iwij79yOLMabzSWHVq4ROV3ZtUsjiEWy-uLS3Je_
 cU6rpNfkPM9Qx1VL8c>
X-ME-Received: <xmr:kZ0gZyaRG6cERDBeCG7KfUnpHYngj1ZiW5QdCJ_uyFEnx4gXFhI2JWEZf-gX_8-EVA28U3YS90UcgR2axEsKqQqNhgfcPE5cbfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdektddguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
 tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehsuhhghhhoshhhrdhgrghnuheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghp
 thhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepthhrih
 hniheskhhonhhsuhhlkhhordgtohhm
X-ME-Proxy: <xmx:kZ0gZ1VdEPNRqimKpMIqqypCen5A9Wv25w73XIm-JiCCkkN8vTSnSA>
 <xmx:kZ0gZ4nfcS58qf4krbWNEwM8xby5FWG_5AEMNp5Odmv7SEoycZNCwg>
 <xmx:kZ0gZ6ffg3bG-Wo92O8BbFamhjosXA2Ey3MnpfJah6jU22cJWPS53A>
 <xmx:kZ0gZ6HVp2P0sfGVbbvFq7KLms0v5qtEDJ_0sSGA98TmzzqDKV8Ksw>
 <xmx:kZ0gZ5AXiEo-WPw_N2lVhozQk3gbi2bx11lgVqEpA9fr0TCy4WOw0J7g>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 04:32:16 -0400 (EDT)
Date: Tue, 29 Oct 2024 09:32:15 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 2/2] apple: dart: use driver specific instance of LMB
Message-ID: <ZyCdj5x3RS_djKqk@robin>
References: <20241029071846.514559-1-sughosh.ganu@linaro.org>
 <20241029071846.514559-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029071846.514559-3-sughosh.ganu@linaro.org>
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

On Tue, Oct 29, 2024 at 12:48:46PM +0530, Sughosh Ganu wrote:
> The LMB module is typically used for managing the platform's RAM
> memory. RAM memory gets added to the module's memory map, and
> subsequently allocated through various LMB API's.
> 
> The IOMMU driver for the apple platforms also uses the LMB API's for
> allocating device virtual addresses(VA). These addresses are different
> from the RAM addresses, and cannot be added to the RAM memory map. Add
> a separate instance of LMB memory map for the device VA's, which gets
> managed by the IOMMU driver. Use lmb_push() and lmb_pop() functions to
> set-up the relevant lmb instance.

thanks, this fixes the initial brokenness when setting up dma mappings
but I still see SError due to translation fault. I don't have time right
now to look into it so it could be unrelated to the iommu.

> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  drivers/iommu/apple_dart.c | 67 +++++++++++++++++++++++++++++++++++++-
>  include/lmb.h              |  2 ++
>  lib/lmb.c                  |  1 -
>  3 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 611ac7cd6de..55f60287b0e 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
>   */
>  
> +#include <alist.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <iommu.h>
> @@ -70,6 +71,8 @@
>  
>  struct apple_dart_priv {
>  	void *base;
> +	struct lmb apple_dart_lmb;
> +	struct lmb ram_lmb;
>  	u64 *l1, *l2;
>  	int bypass, shift;
>  
> @@ -87,6 +90,56 @@ struct apple_dart_priv {
>  	void (*flush_tlb)(struct apple_dart_priv *priv);
>  };
>  
> +static int apple_dart_lmb_init(struct apple_dart_priv *priv)
> +{
> +	bool ret;
> +	struct lmb *almb = &priv->apple_dart_lmb;
> +
> +	ret = alist_init(&almb->free_mem, sizeof(struct lmb_region),
> +			 (uint)LMB_ALIST_INITIAL_SIZE);
> +	if (!ret) {
> +		log_debug("Unable to initialise the list for LMB free memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = alist_init(&almb->used_mem, sizeof(struct lmb_region),
> +			 (uint)LMB_ALIST_INITIAL_SIZE);
> +	if (!ret) {
> +		log_debug("Unable to initialise the list for LMB used memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void apple_dart_lmb_uninit(struct apple_dart_priv *priv)
> +{
> +	struct lmb *almb = &priv->apple_dart_lmb;
> +
> +	alist_uninit(&almb->free_mem);
> +	alist_uninit(&almb->used_mem);
> +}
> +
> +static void apple_dart_lmb_setup(struct apple_dart_priv *priv)
> +{
> +	struct lmb *almb = &priv->apple_dart_lmb;
> +	struct lmb *rlmb = &priv->ram_lmb;
> +
> +	lmb_push(rlmb);
> +
> +	lmb_pop(almb);

This doesn't look look like a good solution to me. We're conflating two
different concepts into the global lmb. This looks error prone to me. I
was looking into adding iomb_* entry points into the lmb points which
take a pointer.

Janne
