Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C1E674B1
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 08:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227E488E1C;
	Fri,  1 Nov 2024 09:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="w5VoM6AM";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKZtXKQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFF288F4A; Fri,  1 Nov 2024 09:09:32 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAF888D94
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 09:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 8B0FF11400D9;
 Fri,  1 Nov 2024 04:09:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 04:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730448568; x=1730534968; bh=LE4EzvwgrV
 Yfwf6uC4JjkFo3DaYzmfgtIcU7b7PSjzg=; b=w5VoM6AM9Z++f+ePTcI5j7I55V
 pr+oBpcXemDmai0bsiX2jteRM8VhreR3s0eJSBp1E4l7lV/BYEnKWtMHc6SC31Kp
 chBHBfkhGWR1JqK2GyZIT/7Y5RDMThJPNYsOlgREGUKsax5G3GZoxfEeAY/VMOrP
 bA0Ry87yQC2vQsja18UExxj1GCF7PmZ15o2dPrN8WjgQHN4dYqg0/kwmGGx9KeUO
 wyXqb0ppznLZ/x5Cs0fqz3FPxStKTXrbHMdc3H0HecjQaLN8hAzqmflK89dbTg+O
 Z0PHFWnK0axJKj3Vz9+svC31wsp0U7sidS/kl4hmS/LnP/KqCA/+/bu6banQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730448568; x=1730534968; bh=LE4EzvwgrVYfwf6uC4JjkFo3DaYzmfgtIcU
 7b7PSjzg=; b=nKZtXKQyPGQ8ALZEIjbpDFoiEo89z6jIMRWmXVUsocUY4bkKHvQ
 MLcboegTSbZfww/48R+UcgTu6ffKFSL+hcxTGtcRIFCEddoRvDj7iMB+bOhfU8dj
 XTy5b5Pm/l4BpoeITbpHqdwG/iWC9TQxXpJInSoIB6cUm6FrLWQgiK2BdEVhUtCW
 JH+I9rGfr8HHQtU34B/IBmHQ4WKuEmx5jOI4Usm5KTl5PrhiOkcMPa9oCu2y/n0I
 tU/EKBpy1PbKfItJyXWiEMU8eMwInGQn6tSRQWkTMYbLRQvrng8qipFRbiRViCKp
 ZbDRw6hAHhBtA6PFWdOKbGmbHm2gGEbEbMg==
X-ME-Sender: <xms:uIwkZ0z-WwUP8uQ1rQtfOlw_P43afH1Lj0AlXcQGPlCqa5VtaWxSvQ>
 <xme:uIwkZ4SqqYzy6WJ2UZ5RSWCT8_HWe9-H8JGhid9fYGocS13D0jSpez6aYF0aVH-wZ
 LS7NEDz8zBpRfJfm9o>
X-ME-Received: <xmr:uIwkZ2WKgPQ8dkOsEREsgH0_Rr9PJgVCAogn2Ta9X4G04Tmqg6iFrREzxG6qqS42_xPpMSRtE-TnziszgAxAJf35xPlycEiyWok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedguddufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepvdeviefguddtgedthfeiveekiedtvefhiefhtdekteeihefh
 keeggfegkeehgfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehsuhhghhhoshhhrdhgrghnuheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghp
 thhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepgiihphhroh
 hnrdhglhhpkhesghhmgidruggvpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhm
 rghssehlihhnrghrohdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdrug
 gvnhigrdguvg
X-ME-Proxy: <xmx:uIwkZygXEQee63UPYciO1E1B1InNymmpqHa2lqI0hl_Vivt19fe9ig>
 <xmx:uIwkZ2CQOKLCa0mWdCxhjGhbjQFB2ieAHxoWXWTTZsQKW_iY0c7Tfw>
 <xmx:uIwkZzJVMr3t_7YpTP3O2RURAYf7lKQTlMEGoeG3bQEdVhFtvBDfdg>
 <xmx:uIwkZ9DDrh-_El05Box_tctw84m-0UdMA8qWMYWh7hWMJZRXlQI73w>
 <xmx:uIwkZ42ONXp7L3Jo2CrgVkanVoL5zYN4qmcDekKdBVitwtI9BO9aZzwc>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 04:09:27 -0400 (EDT)
Date: Fri, 1 Nov 2024 09:09:26 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Fix device removal order for Apple dart iommu
Message-ID: <ZySMtvihaERwmqMN@robin>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <CADg8p96v8ocR=8yRLmC7j0CFcCUCFfQv6P9YaST_i-ewUP4RdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADg8p96v8ocR=8yRLmC7j0CFcCUCFfQv6P9YaST_i-ewUP4RdA@mail.gmail.com>
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

On Fri, Nov 01, 2024 at 11:52:26AM +0530, Sughosh Ganu wrote:
> On Fri, 1 Nov 2024 at 04:37, Janne Grunau <j@jannau.net> wrote:
> >
> > Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
> > trigger a NULL pointer dereference since the the iommu device is removed
> > before its user. The sparsely used DM_FLAG_VITAL flag is intended for
> > this dependency.
> > This series adds it to the Apple dart iommu driver and implements the
> > two phased device removal to the EFI loader.
> 
> Is this also the cause of the crash that you were observing with the
> RFC patches that I had posted earlier?

It shouldn't as I applied those patches on top of this. This is a
separate issue already present in v2024.10. I discovered the LMB changes
while investigating this.

Janne
