Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8BD68BDB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BF1896F1;
	Fri, 15 Nov 2024 23:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=brisammon.fastmail.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="YwjYmG1C";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYqOhuD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3767D8916C; Fri, 15 Nov 2024 19:28:28 +0100 (CET)
Received: from flow-b2-smtp.messagingengine.com
 (flow-b2-smtp.messagingengine.com [202.12.124.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E53488D3C
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 19:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=brisammon.fastmail.fm
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=u-boot@brisammon.fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailflow.stl.internal (Postfix) with ESMTP id 371D51D40B98
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:28:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 15 Nov 2024 13:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1731695304; x=1731702504; bh=MZl+Rz/0KM
 Tc/kZ+IjWTC//HUX2kIiBD7wepiM4NBFA=; b=YwjYmG1CdHWcyFkhEvLWJzSFGH
 /myxbJFfl5Cxq+Eh0kW/ofFQaV5WVnh+Rtpgtj68ZFSyrAch7QMwaNIe/oei4+Dn
 7hB/s07sBu93sg9yLiQjQGtYRh1ezOxpJ6aZl+4fRLSpNjlUjyeEuJCXXopWSC55
 dSQdni28er/Vai2VflWOyOJXe36ObjeqNq/sinGErQa77qAgQBhH4St39yiA7gT7
 KI3FhnWPz97YNkGaYmSYmlTTNo8qTXQZikj98OE5LveLi47ukouEJNpomuA4Wivv
 GdLktbNC3/zs3Z7htNgzLig2IgZvlrJmq6VSt3ngVgWfUAuHBerL2M7Tab1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1731695304; x=1731702504; bh=MZl+Rz/0KMTc/kZ+IjWTC//HUX2kIiBD7we
 piM4NBFA=; b=mYqOhuD7EW5PaDSOko1hEf3HbFQwppYxRNVVSRRmJxahXt394wH
 /c6/L2p0rx14g4kC9xdMOT8KqeyOPwhh3f0V6ACiUSywH9P3RvCcyxjqfi3k0UrK
 9dRYsq4sFfdoV2KqdWKb93IOsYzHgYzDUtHUR2pB+DhrbwmzE30TMCMpa6NQQzH3
 P7eq2L+5Q9PD6zBXOGeOXEnI56cS+Qkouct8R1wime0GV6CCd/9+hJ+3cB6RHwGZ
 gU8DGkyBxJ2XMLtUKFhNQN7HeZIBjMsZzS7JiQYNaeSAml9fY6zctflDJKGWGHjQ
 iRHHzBcuGxqpaNgjoE5mfDy6+RQ71Yr4mfg==
X-ME-Sender: <xms:x5I3Z0ksxcKiudNbeVw50fvbI1LjQF6p_766Hvk_siB1C9a5aNkxqQ>
 <xme:x5I3Zz2N_3wChnYDPjJO6bRq7G3L5ncfQgDfGeX_xA6BIsKYl_vamf63duvTAv2RH
 kTlikIdHIXVoQ>
X-ME-Received: <xmr:x5I3ZypJUONSQglsh42-AZpGtStB9QZ6nGuB6RAjSk2-zEPqr0p1QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggdduuddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
 fkofggtgfgsehtjeertdfjtddvnecuhfhrohhmpeeurhhirghnucfurghmmhhonhcuoehu
 qdgsohhothessghrihhsrghmmhhonhdrfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrth
 htvghrnhepueevtdfhiefgveeifefhteejuefhhfegfeelffduheejteekfeehvdegueeg
 heeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuh
 dqsghoohhtsegsrhhishgrmhhmohhnrdhfrghsthhmrghilhdrfhhmpdhnsggprhgtphht
 thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehuqdgsohhotheslhhish
 htshdruggvnhigrdguvg
X-ME-Proxy: <xmx:x5I3ZwlPhg4n86B6NTK8byGnR4k8fTg7x4fWDdLVPbQb6niYJiX8gQ>
 <xmx:x5I3Zy2BwcBRefEWneDOItsSQfj6zcNN7D8KOOKQFUm_NqiUZDTZcw>
 <xmx:x5I3Z3sK1YjSZ8laDYEA_oXYcII6B5EspUkhZo44U55iYoD-mPqdoQ>
 <xmx:x5I3Z-WJIXA2F6pun5xI5VECoCu7gqLvpHiXD8aYMCvAfjCZmuv9sA>
 <xmx:yJI3Z3-hKfwQFQKBUOhWvP1Al33xK-GOXCgB_sp3JXJoC8JcGkRRL2H->
Feedback-ID: i431d41ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:28:23 -0500 (EST)
Date: Fri, 15 Nov 2024 13:28:21 -0500
From: Brian Sammon <u-boot@brisammon.fastmail.fm>
To: u-boot@lists.denx.de
Subject: "help" output too much for my screen
Message-Id: <20241115132821.c2cb96e17c9a62e450d155b0@brisammon.fastmail.fm>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 15 Nov 2024 23:35:33 +0100
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

I recently upgraded the u-boot on my Pinebook Pro, and lo and behold!, the new version supports the built-in display.

So, now I'm experimenting.  I hit the any key to stop the autoboot, and I get the command prompt.  I type "help", and a large quantity of information spews out to my screen, faster than I can read it, and scrolls off the top.

So, this prompts a few questions:
1) is there a paginator, so I can do "help | more" or something like that?
2) is there a scroll-back buffer, so I can do something like "Ctrl-Alt-PageUp" to view stuff that scrolled off the top of the screen?
3) Is there a website that lists (and documents) the commands available at the command prompt?
