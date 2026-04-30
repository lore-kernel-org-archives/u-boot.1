Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78617CD13DE
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED95284227;
	Fri,  1 May 2026 00:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.b="BxHPtehZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="meoV/CJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609B380F0E; Thu, 30 Apr 2026 22:31:42 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D207B80433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 22:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gmcastil@fastmail.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 86D7E1D0006F;
 Thu, 30 Apr 2026 16:31:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 30 Apr 2026 16:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1777581097; x=1777667497; bh=GWVsYo5HLwQJZyVAKsW1sn9N6DM1C1+e
 LMJaldN0YUI=; b=BxHPtehZy6EW3gQvAS249TkY/S8NFl2jAtd6xUDQPbBZj+ak
 YxAsUVmdvkEObj4tLQDXXlsEyX+DewKw2CITy6w/308lZkpxgeEdj/dke9sIv1mA
 4pp/tl5JDXJye6J6Mn2dbWQrxkY77tFtmuaZR08VX0uexJN+vWsEYONndBs/fxsm
 w88Ttyq7u9rjlX8nirFSqDd4hVsEznqUFPHGnDx9VRjGwEH3y1srNTMACz1Rvu1F
 iSVdNetqkz8zQ6qoyDt1eK/B2wmW+x9PwlTXUX9rFxqgG01yePeA4ZngFcBI36y6
 /OR8BGmOON++FTryJ999Au8KqmbDikQAD+9jQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777581097; x=
 1777667497; bh=GWVsYo5HLwQJZyVAKsW1sn9N6DM1C1+eLMJaldN0YUI=; b=m
 eoV/CJq+7MzjMEfladY4ectOCGFSC+DPEjdF+3impriIrfgHK2jCyViDa4gDQMyD
 hqoIOKu6Ikp0gC+fTobdOPszpvrCSI/H986Cnb6fh/GodSB6kXjZ/5TpgQezK7ug
 RIrvBq28ou7Iyq6wQkW3lsiv/VegRVWhAxVN7N9u93KYz3xNlieqrUUcitKC7oQO
 KcwQdqDzzlM1Od/CzwqOK9Qcgr7NP2R31OkEkGd5mgmdeTxNZSY56ZF/2vVR0Hlo
 YXgXaeXE2Em7Ld6r5MnkB5HBI6vKoT+cyvmBhI1ieeCkuOEUcsKRfAQru5IjjB7S
 2MV38TE50gZTnQwrFwTAA==
X-ME-Sender: <xms:KbzzaXWe1J1598f1H-wXCcw7xHdUxtW7z_pmYxi4O2HStaIEuKaTMQ>
 <xme:KbzzaVk1VJyv0ySutfUQH-Q5N38G9AS0L-ibfcqICpm5lzhlzZpBxwgLXHzwNmI3h
 GDBifwc7SeJBQWrpGKoiiqpSqdSe1vvCuofpfV3zPRPKLuXqHkoUg>
X-ME-Received: <xmr:KbzzaRCjHcjwKXHL9GMdUfyUrRtq_vliCgoAA_KpRxQXWw9YrBd3WxoXyDH58orNwWTfO48jQezMwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkedvlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttddtvd
 enucfhrhhomhepifgvohhrghgvucevrghsthhilhhlohcuoehgmhgtrghsthhilhesfhgr
 shhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejgfevffeutdeffeehfeehge
 duiedvuddvteffieeglefgledvheefleelveejgfenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehgmhgtrghsthhilhesfhgrshhtmhgrihhlrd
 gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmihgthhgrlh
 drshhimhgvkhesrghmugdrtghomh
X-ME-Proxy: <xmx:KbzzadcWuS-ZmLJUKbWNZFl00VfFC0hxKjLQBrKq011YSwl9qsXGyQ>
 <xmx:KbzzaUJhTgY0ZbE5kMMUfHjGWLvRtZ4OoVMPEFCjT9GZIoREc09kCQ>
 <xmx:KbzzaYegMJ3-bQXwHLUJm7YdQ71TqvGl4bDB3QewgAnNJ2IFdIku3Q>
 <xmx:KbzzaT1W9odY1I3Y_RG0jBDTlOT3avS3u6wZbmMUIn-LBiasx-sm4A>
 <xmx:KbzzaegNQQ8iyZo_qJmjHw7iDwRO3fgJfbDs-H1Z7kJowEwzjsHY6Uzn>
Feedback-ID: i14a94276:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 16:31:36 -0400 (EDT)
Date: Thu, 30 Apr 2026 14:31:34 -0600
From: George Castillo <gmcastil@fastmail.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com
Subject: Zynq: Arty Z7-20 board support
Message-ID: <afO8JoulesgQeAF_@caprica-dev.lab.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 01 May 2026 00:55:30 +0200
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

I'm preparing a board support patch for the Arty Z7-20, using the
Zybo Z7 as a reference. The device tree is complete and I have the
FSBL + U-Boot boot flow working in hardware. Is a working ps7_init_gpl.c
and SPL boot path required for an initial submissions, or is that
acceptable as a follow on patch?

~ George

