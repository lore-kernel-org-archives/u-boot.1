Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D5DD75BC8
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 07:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDCC8959B;
	Thu, 21 Nov 2024 08:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="JQK+lyQe";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4HJ0+SX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8378A8959B; Thu, 21 Nov 2024 08:39:33 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C602789082
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 559F7254011D;
 Thu, 21 Nov 2024 02:39:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 21 Nov 2024 02:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1732174769; x=1732261169; bh=bKRwM01xJO
 a6qjzeaEh24bQHCg5B2nQr58eRgx+qkGY=; b=JQK+lyQeXwgulmRFvsoZMEYb3N
 dmPZjdu/c9UshIEoI15n7YgzzhC8nlHjb8yw4dJsSZ9tkmr8e30iV9D5IGbB5B9s
 8mwm5yzS51RJo6ZOxw7MPPAlRNayNqzdZYopOFbAfmWNYze/XOENOtoNfgcAdyqY
 BwzMCT8u4PmD0rmyVwwEGeNLfQr3csOLnWRfsOUpXSVJirK/KucJrNdwZ8hD0IA8
 DbJE+GX3ocSg4L3Heeo94al2eLfQqnlHQpUR4nHZw8108Itz7A45NcoWm2KmLX0g
 YjTN9imHHnqFH55/df8A4QEr2xvidQN6EbMwn62uan7qbr4+WnOoBfMIwGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1732174769; x=1732261169; bh=bKRwM01xJOa6qjzeaEh24bQHCg5B2nQr58e
 Rgx+qkGY=; b=X4HJ0+SXXzR8bKFML+nofR7zxMuYGW1+cojiemHNg6kZBmSKPQD
 rRpj+dJgNKrT1ZTJyGpUl3DLHK0VEVzfa6fWvN/BWjGNmYAEd20M1MPlgIbbzm8/
 UkMjGwJFMr67YAexCeTq6kw6rbqJFDQ0coSagylcl8yOk3l0QvooxhUdPkOlan1L
 cZwssAS7FZp1tHDXJs4I8Dvo83rpLRhb29FFwInqeCJO0lpa8SnZF8l9/n+v6HTV
 izbKhyIcCbDldBIE+J+udVEfmyRyBiE18Hqq18GnMEnLHjpzscWutl/XoK7f/X3O
 uhTslz3fAo5OK5GUWYIgSxXyV23iF1u7EJA==
X-ME-Sender: <xms:sOM-Z2LcIy1nvIPnRiRDxjbVrrP35z7oyqsmoypAE3UutTZ4gps5Rg>
 <xme:sOM-Z-L9kt7mOC-5tAXjAe3ekNqidNDF6n9qI3mQLZRnUJo0OrU-v_KK8Ar0K012P
 VYZsOgSD5CSFTDAd5I>
X-ME-Received: <xmr:sOM-Z2t9Z9T30I4iWCCsAoI7PK_LudyDHBk_X0sAoabuetF5isLoK1dROLn1OMB195YQpjuAjbLAzDictvL6B6x5j3wTUaQxTTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
 ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
 ggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedugeet
 hfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpd
 hrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepgiih
 phhrohhnrdhglhhpkhesghhmgidruggvpdhrtghpthhtohepihhlihgrshdrrghprghloh
 guihhmrghssehlihhnrghrohdrohhrghdprhgtphhtthhopehsjhhgsegthhhrohhmihhu
 mhdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:sOM-Z7b0RRg9FEPckd7ZB4IpyqYUA9n8OqsO0hSc9cerTpR_oksmhg>
 <xmx:sOM-Z9Z5sNeayt4Ai3mA4ysW8vTYig1qlDxnYPdlojEOQrlWKgpGeA>
 <xmx:sOM-Z3DAyMmViSFbbxirOSZNKoDdrzOCcfd5kO3isBSJaO3bo2aFrQ>
 <xmx:sOM-ZzYhPEHhzcKpSdlJ3PQ5KspwoRAJr00JhtGQ1zredS-3ezpOtg>
 <xmx:seM-ZyMeqQVRx8u364UPA_92PO6L7V5XlCv-Cu6Ue7XNYtfaMdJmOUqO>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 02:39:28 -0500 (EST)
Date: Thu, 21 Nov 2024 08:39:26 +0100
From: Janne Grunau <j@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Fix device removal order for Apple dart iommu
Message-ID: <20241121073926.GA2171629@robin.jannau.net>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
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

On Thu, Oct 31, 2024 at 11:48:00PM +0100, Janne Grunau wrote:
> Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
> trigger a NULL pointer dereference since the the iommu device is removed
> before its user. The sparsely used DM_FLAG_VITAL flag is intended for
> this dependency.
> This series adds it to the Apple dart iommu driver and implements the
> two phased device removal to the EFI loader.

Can we get this two small patches merged? They fix a regression although
it worked previously just accidentally. The only drivers using
DM_FLAG_VITAL are clk-rcar-gen3.c, rzg2l-cpg.c and apple_dart.c all used
on arm SoCs. arch/arm/lib/bootm.c already uses a device_remove call with
DM_REMOVE_NON_VITAL so adding it to efi_loader looks reasonable as
regression fix.

Janne
