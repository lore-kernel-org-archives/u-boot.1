Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603D4C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33205888A0;
	Wed, 22 May 2024 19:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="PjOkY4tw";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jEkw6uU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F45488881; Wed, 22 May 2024 19:08:08 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D32788881
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 1FF74180009E;
 Wed, 22 May 2024 13:08:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 22 May 2024 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397681;
 x=1716484081; bh=ZdmKnQ9YhE1iT9cs+BdkdUsgu8lxjLTjqPwY0i0EsXk=; b=
 PjOkY4twKmd+eIxnYj11NnsvzI657pxXHu5pDywWwVC4lP9QjEqHSMZs/Nzn/yDu
 oIoOcBG9Me7BsO6WGS00r5tiGfUCb4UCN1vSbawn4JIKvEjvpVBlNnJk7GCnlXiE
 yESx/p+/meYrUNSTnS7A1WdtWGhtxrmeFM3uIitVlj7BDsq1gaANoA7kH8mtRo8v
 87q/7on0MeP+bMB8fI1lGOQv1UAly7FymlJRKGf6czMKXy6sXIJi+URp/qLECMx+
 RMnkXFHT7hJotWP1rDC2IWg79ac+tl09/lF1khG4EjSQP7MJyQefBrUDdtZbQ3/9
 z9wpE5z9cFiv/aWkNsh/ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397681; x=
 1716484081; bh=ZdmKnQ9YhE1iT9cs+BdkdUsgu8lxjLTjqPwY0i0EsXk=; b=j
 Ekw6uU/nP8iTQ9J6xnmvqXlgNBUP9FBjE6XBaXVAAnXH2RwFWHtGMByD0Wl5bUos
 UbUACrXSaEGVjH7Z3kdT/JHgcWHJ9OFPYBmOyZMd9rzz3d9BTGZbFiAGZwwNNHVU
 1x3JWpRtYhRK/SHZAMmwXqXy+ZxYpu5tqjQ+zVLdTpUJdeIXmZhHT9noOMC+poOP
 501p+ZQ/LusQCyVRLVJKsQ0QxiEjHlP4qtGZaq5VZZc6LIfzy94UtZXoTIPBVRAv
 wNAsPuqupWMVICYAks+zF/jyjRPr5sJ/1xHNhi7DcNsNpFSeSbXzgIaMFm/gifb+
 FvrzMYdEvv3yzLM0gJftg==
X-ME-Sender: <xms:cSZOZthAo0duGUAYSN_wsoVGvDEOqZecLIlFrc2ZK90ja1IH8XxT9w>
 <xme:cSZOZiDI2otT42l3lz1QR0G7BhBTmXtbVAd7k76MkzpurfAFdKDHLQbyOVuOgwwfV
 uTijLCrfdMDui1DMwM>
X-ME-Received: <xmr:cSZOZtFN1FBd5QulhbPUmsoVh2znfKMU7oQxOsgO5i3rQ5jkIpphKBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cSZOZiRU3mfpuChfmn84YYjYxdLUPV323-dHTb_Myut5m5dgQiGJow>
 <xmx:cSZOZqzvtf5znhCZoT_047wfVi-2Eyi69e-ePe0IglngIGm9bRqXNg>
 <xmx:cSZOZo4wQoTRmTsZggVsmr8DNBxJgV6qrzvByKnuPpMCUDCUBwB_3w>
 <xmx:cSZOZvzRUyF-Ae4oEgd5Q9cYnoPMIW2HDAJNk9b7cG6WuOQZNMzWXw>
 <xmx:cSZOZhmMQoSLFV9OuUPhVnToeVtaJ0gXm5PQD7lC94lMjM5OjSI4gyvE>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:07:57 +0100
Subject: [PATCH v2 01/10] xtensa: Move dram_init to xtfpga board file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-1-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GANoPz/dvriQAaXUB4/yZbULtnGNWF6683sB1ucNN2s=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tTyPFWt4em7zHK7tuD/nwf27v1++y8gMavY+/73i6
 w87lRlnO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAivBYM//PcPuQs1Lt2Uyld
 xO/nh6Xfijut4qu3zPNbbihgrfavNZzhf6bQgZUmzME9rJOyl018mDtnjlxeno8uVwPH/eh5Xc/
 KmAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

This is a board level stuff.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/cpu/cpu.c         | 5 -----
 board/cadence/xtfpga/xtfpga.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/cpu/cpu.c b/arch/xtensa/cpu/cpu.c
index abcd8f7984fa..d2266812229c 100644
--- a/arch/xtensa/cpu/cpu.c
+++ b/arch/xtensa/cpu/cpu.c
@@ -48,8 +48,3 @@ int arch_cpu_init(void)
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
 	return 0;
 }
-
-int dram_init(void)
-{
-	return 0;
-}
diff --git a/board/cadence/xtfpga/xtfpga.c b/board/cadence/xtfpga/xtfpga.c
index 5110fed31194..6b92fe31c0e0 100644
--- a/board/cadence/xtfpga/xtfpga.c
+++ b/board/cadence/xtfpga/xtfpga.c
@@ -66,6 +66,11 @@ unsigned long get_board_sys_clk(void)
 #endif
 }
 
+int dram_init(void)
+{
+	return 0;
+}
+
 int board_postclk_init(void)
 {
 	gd->cpu_clk = get_board_sys_clk();

-- 
2.43.0

