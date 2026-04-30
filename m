Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A554CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0367783936;
	Thu, 30 Apr 2026 23:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="JLORckLp";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwTkSNHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7DC83A91; Thu, 30 Apr 2026 23:25:57 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58DE2803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E964B1D00081;
 Thu, 30 Apr 2026 17:25:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584353; x=1777670753; bh=AP
 S/lJNFBlUwr6zKeYSRx9QBFfR2IXDp6v9ewE6uJig=; b=JLORckLpZMFW4P0zz9
 Zs+JDd3LeAabmzlsg/MNSUEAyfuFtiNX93eRBSNJ+CiQMS/P/xAXQV2ThpGvPN84
 CAyUvU8Oatt1vBTDE4ez3vx6R+pnD1yfKxfcTMu+9unoMoD0b39ZxP7OF5qXPVGq
 z2X0GSw+OaOpcPqrgX/dIPFe0biNn2mV9hWU3opU7X4rkn7ORkU1hL2UgF3F+ADb
 AN93npvYeGADRE+EMcYCh9Zce5hX+NFNk7KTvOqfrSEd0kiSGFOm/s6zLNwnbVGU
 Q9AOWO4TWQaLfpjyc0KLRcjg7cPXNgvHwpY2GzcMlmT9wexheMvJeVW2ftkCulRu
 atLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584353; x=1777670753; bh=APS/lJNFBlUwr6zKeYSRx9QBFfR2
 IXDp6v9ewE6uJig=; b=QwTkSNHpxGMNGlew62CqTx3dyGbJy24F5RXPpHFKzJnT
 poQMuBN3WS6cuQYi2jtKu3nlsTgNzwnKd6u+HTRR9/e1pTpghTh476xE8f6bqARX
 BJYnTQ2hnrNxSssgX2y09r9UR1SiMKBtW7wcRRzu1JkKzOU08J5TLTYh96Le8E6g
 /DEPt9Osphmto4Cgr3P7YP7RwqckavQfiUaVa2Sxj7MZHzqoRI9CIeemP9rBDnxm
 BdUa/tB7LH6wOIBhyXuc5NG2ZLOJQYmMKh3/CZG/qjG8T0eoYNGw0KH2PKFUvxKp
 qoNo3ZnLun05D1BAcqIEn/UNcLmn5zAyWBHZRCsg7g==
X-ME-Sender: <xms:4cjzaQfFxhF-xjatFf-ioHZoahTbtrGuc1v6ULyTLZs4Qw4dc-j0Ow>
 <xme:4cjzaZPuSD7Fk9leoUbYiKCx_QYy5Fv9_lkGonlvGwgfYMya40sCg7F_Q6v7pPRom
 pioyRuS1SoaZoIRaglplcPlAjp22U8OMOHAPZPbzsyBcoFmCprvVZo>
X-ME-Received: <xmr:4cjzaWi00-Iek-YJNHcItO6M2NOjyac7vnFJPGzUxMRY2zIDIJk0Sej6Aom1aDCh2HOt39hM38lGBiL_2SIPO2NDaZsgfIvYioVwpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefhtdeuud
 eljeffuddvheekuedtfefhtddvieeigeehffelfeevvdfhgeeggefffeenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
 gvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 khgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepjhesjhgrnhhnrg
 hurdhnvghtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghp
 thhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:4cjzaU1OOSGiPHTQ_rgEuNirJz9FE3CXUowoGCRx1GLGs28QU8rNZw>
 <xmx:4cjzaYi6_ENPWwskyfo6hcglaYtgGPDb7q5Pe1LSPKRB95b6WA11rQ>
 <xmx:4cjzacfpJzaWzV0T6Gxe9_hBPifp_L2UyVkq9PiNKi_GaMQAE17sew>
 <xmx:4cjzaTlnZojssyifD_7t1xoZ5L7WQqhg1mIr9xxKH6VN8PDUVJDapQ>
 <xmx:4cjzaXK9VMgVM2IeO159ohwhuONKjaAOt1MHOD0vJ6LKlQMlfEioW2Rh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:25:52 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/3] Switch Apple silicon boards to upstream device trees
Date: Thu, 30 Apr 2026 23:25:45 +0200
Message-Id: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBsYi4K6SrSQHGugTLQiEO+et
 HyL/xNEDsIRxipB4EeinK5A1RUsm3Yro5hiaKjpSdGA2vud0Vx4+3gF1gf2RltqO0WWFyidD2z
 l/Z/TnPMHk+1zhWMAAAA=
X-Change-ID: 20260109-apple-dt-upstream-6daf03510fec
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2527; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=81a4m9X7WPfYIWehc4Cj6FS29ATHldjJcFPioyVrFe8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPJ+52fWISmV3gquK4KMry+5PPkau1zu51TeflP90ZV
 VV52MOvo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQqzjD8j1Fft9365+JZ9qJ1
 Z+R3Kelm7n/ot6pQ1Joj4krz3+02Wxn+qX7cOG/fnq+iabNOpB6OuXjc4s4mQT71/U5Gq5RMl1Y
 uYAQA
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

The Linux device trees for Apple silicon devices cover now most of the
hardware as u-boot's internal device trees for M1 devices. Linux has in
addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
never added in u-boot.
The most common use case for u-boot on Apple silicon devices does not
use DTBs from u-boot but passes runtime modified device trees from an
earlier boot loader (m1n1).
This change regresses support for the DWC3 based USB-C ports and the SPI
based keyboard on M1 and M1 Pro/Max notebooks. The regression for the
USB-C ports will be fixed when dts/upstream is synced to Linux v7.0.
The dt-bindings and device tree nodes for the SPI keyboard has still to
be submitted upstream.
These regression are in my opinion acceptable due to the limited use of
u-boot's DTBs for these targets.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (3):
      doc: board: apple: Mention M2 and M2 Pro/Max/Ultra SoCs
      doc: device-tree-bindings: Remove apple,pinctrl.yaml
      arm: dts: Switch Apple silicon devices to dts/upstream

 arch/arm/Kconfig                                   |    1 +
 arch/arm/dts/Makefile                              |    7 -
 arch/arm/dts/t8103-j274-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j274.dts                        |  129 ---
 arch/arm/dts/t8103-j293-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j293.dts                        |  116 --
 arch/arm/dts/t8103-j313-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j313.dts                        |  111 --
 arch/arm/dts/t8103-j456-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j456.dts                        |  117 --
 arch/arm/dts/t8103-j457-u-boot.dtsi                |    1 -
 arch/arm/dts/t8103-j457.dts                        |  105 --
 arch/arm/dts/t8103-jxxx.dtsi                       |  143 ---
 arch/arm/dts/t8103-pmgr.dtsi                       | 1138 --------------------
 arch/arm/dts/t8103-u-boot.dtsi                     |   25 -
 arch/arm/dts/t8103.dtsi                            |  696 ------------
 configs/apple_m1_defconfig                         |    2 +-
 doc/board/apple/m1.rst                             |   15 +-
 .../pinctrl/apple,pinctrl.yaml                     |  106 --
 19 files changed, 11 insertions(+), 2705 deletions(-)
---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260109-apple-dt-upstream-6daf03510fec

Best regards,
-- 
Janne Grunau <j@jannau.net>

