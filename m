Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD5CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53E6845C8;
	Thu, 30 Apr 2026 23:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="ExeYcfWM";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWQGv6hi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12DE8432A; Thu, 30 Apr 2026 23:59:55 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE5880086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 5CF251D000B6;
 Thu, 30 Apr 2026 17:59:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Thu, 30 Apr 2026 17:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1777586392;
 x=1777672792; bh=wKk0KDUfV+uOXWWWCohXz7pnMnox5nLythk6210Rjrc=; b=
 ExeYcfWMH7jtlZ/SFxJTQBycgHDHC9PEXO6h2sYSP3BEYrrQmylNDWgcyv5fQjGU
 HWYmFWy/77uTbvA4JhVjbE8jumj090xETNfFBYrod+nqmMnEggRrkMP2ecSN4F6W
 kTQNoGWV/Ikjn8om794eDDIDwkr/EwY0n+i/HsJ6gZy08SRnnKqjbkIgUatogUvV
 /SDzwVXBfprWBHc7yw8sMds7+pjDjsRPE1mJ4X6dNcpBWoPsqX1Wet+j/ZSG5rgo
 kEnaHutaFn9qMzkdgnWtlM5Npo+NMjSKTzJU9l/PR71Om5nOAb1bc0ZIIWryVlEd
 vnF4/NEbnmHrI31jnUC7SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777586392; x=
 1777672792; bh=wKk0KDUfV+uOXWWWCohXz7pnMnox5nLythk6210Rjrc=; b=U
 WQGv6hiWZEGZ7JIVt9/aAp9hxY7kWpSRo7YrlwZCHT0JXySKO+5inMj25VAfnCmP
 LqgIDsNuvyWDMyf3NlyeVbMzpPix6xAeKW2lyFhZuE6OJoZraw9n7z5jTJLwnWeI
 ZdnQWAgVED/ixZimiinpsaho4/ijkaLbA2uKaRc0T4xV/yjyb+mQJWAoup3Pkqrx
 XBkVnBYbTI9jD8CaA3A96XaRlEOcV+A9am2bzk6CdRyFvMpMPORG3GuEcPPL8AIe
 ZWNohAMPGPErF5VZ1wVbXkBA1Kyfo2W1jEHttynB1XO5+tNTRcWlt8RK1ctR7dNC
 i33G69+ieTPlT0wndB9kQ==
X-ME-Sender: <xms:19DzaXcwTIaRvC08p3H4a1CTVHrMA6OX0uZgv_l1tdi4yMl_vXfThg>
 <xme:19DzaWnYFVO-Yec5BGnSnfk99ick62xM-uDLDvO0v0uvUdYfwPc3HbAjdFchL4_sR
 8WFbydd-UZprJPeA_wJ2QLB4sNgr_eZbnYSAw80aiyR3covtTijL_4>
X-ME-Received: <xmr:19DzaZC4hl9GeJDlhm28ggX_hSl7PJK1BB-DAtm1Z1bG2vtAMb1ZMnRDfn2H5WeipwcDWdZUosBwkpPjNHYzMiRj16vJXPcnWvk6gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
 ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
 ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
 drnhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
 thhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehprghtrhhitggvrd
 gthhhothgrrhgusehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdr
 shgthhhulhiisegthhgvrhhrhidruggvpdhrtghpthhtohepshhtvghfrghnrdhrohgvsh
 gvsehmrghilhgsohigrdhorhhgpdhrtghpthhtohepmhgvseiiihihrghordgttgdprhgt
 phhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehtrhhinhhisehkohhnsh
 hulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdgu
 vgdprhgtphhtthhopehphhhilhhiphdrmhholhhlohihsegrnhgrlhhoghdrtghomh
X-ME-Proxy: <xmx:19DzaYdzJve5GUsNZGitnbQ-Lqbcpl7QdQIdV4T7fKvZgCEg6FyU3g>
 <xmx:19DzaU6ASzhoBtVXMpB8icRsN7ftqZLnASqFaoZT4HEpnxIMJ3UUiA>
 <xmx:19DzaSN_1WbV4HkWgu9rbHm29X0x3P_-U3tmY8Zb5QXBP3J1MlHqug>
 <xmx:19DzaVE2WuFbjVlsBY-YZjglf1bwA9a52ekYlM73y1navFxUe61dzA>
 <xmx:2NDzaZoV2pbbYoIlPuYCEB7oyD4cGRb7ca1w2kDKb3osYYQHUPXepZK6>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:59:51 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:59:36 +0200
Subject: [PATCH 1/2] MAINTAINERS: Add missing Apple M1 specific files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-maintainers-apple-v1-1-43382ca4d780@jannau.net>
References: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
In-Reply-To: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=j@jannau.net; s=yk2025; 
 h=from:subject:message-id;
 bh=CEmscWhBUbxKy9TiQTyPo0WY1WUq2pdROul5xJA0vBY=; 
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPFy7u02ha0aR9bWd+6WRzlttZKbME0jdcum8rJma6b
 9UZ/hWLOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExk7weGP9w5PgnWuYdPJi7f
 rsgqcp3d3aV1ykPWue/X1Ljoph14vJyR4VHZ0bzFM9f4vj9tsWbSy1fJmRuWF1h8PH5gu6nsozU
 HJnMDAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

The files weren't added to MAINTAINERS but clearly belong to Apple
silicon (M1) support.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4b527560aa..2fc41a79dac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -132,11 +132,16 @@ S:	Maintained
 F:	arch/arm/include/asm/arch-apple/
 F:	arch/arm/mach-apple/
 F:	configs/apple_m1_defconfig
+F:	doc/board/apple/
+F:	drivers/input/apple_spi_kbd.c
 F:	drivers/iommu/apple_dart.c
+F:	drivers/mailbox/apple-mbox.c
 F:	drivers/nvme/nvme_apple.c
 F:	drivers/pci/pcie_apple.c
 F:	drivers/phy/phy-apple-atc.c
 F:	drivers/pinctrl/pinctrl-apple.c
+F:	drivers/power/domain/apple-pmgr.c
+F:	drivers/spi/apple_spi.c
 F:	drivers/watchdog/apple_wdt.c
 F:	include/configs/apple.h
 

-- 
2.53.0

