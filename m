Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60238C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1335B87574;
	Tue, 31 Oct 2023 06:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="puf/f4oY";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NM0a8Ph3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6000F87578; Tue, 31 Oct 2023 06:32:25 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF9087033
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.west.internal (Postfix) with ESMTP id 8E18E3200A1B;
 Tue, 31 Oct 2023 01:32:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 31 Oct 2023 01:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698730341; x=1698816741; bh=aNucpX6lpI
 xKmo+gCjSstXywzZ7fZj0ZNf/z0PN2Gvs=; b=puf/f4oY1HdVOsKTo0ZIrEgTT7
 82mKF3agcnHWqhToKHPykm7e4pAEOmGaBOsBq8w/cKcw93ix/wicthtNpStfMpDZ
 ZtWPHRG8p7LVh4ytNoIuliD74MUZzgfRjlv0pBnBB76dlF5jYingmgl7/62NGL22
 f9GDGpo8SvvuXgxQkRVtCaBJcZTssapwhY4y62DBjyiNQa7ft7AsLyFnahNqnuad
 dSX37yiQfO89FVBIji8pgemthxPo8S9O1v3mwLg9Y9LQLY24f4Dh2fjlWG75z9UH
 8WkOVBiK+9yg0VkTFztC50pHNT0nRyCsplrJDJ0Z/pN2WZBgq/ODLacNUx+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698730341; x=1698816741; bh=aNucpX6lpIxKm
 o+gCjSstXywzZ7fZj0ZNf/z0PN2Gvs=; b=NM0a8Ph3YbZu6kXCkKS+74hgspsve
 xz6DfiBBQMfEfokvSb6AjG2mwT14jhTEF1lX+HbNcOGxc/tycNOj53B09b3J5eC7
 wEVpeWezcSNRiiG8IbrM+Kp0VDyfE7bmE5KW4bJHU6VkU8v6nfoE0Yq/S0BR4lel
 +axMbhVQ2AvMiiL0En7Y/FG9Qw1NeeOw4y5vlxjb+1NgUyyQ34IDhd8Uc7HiFnXe
 qewHVbKvQswIJgNkEuMV8ogBiNO1IoEZ6oNIgNzJ71SNuHmhuHhZIdnL/VDAf7sk
 /iljnaGdrSAgSOnUl60G1jTMRxIeC549AN9AG8i/mwhDWvQ7NTT5WzVTA==
X-ME-Sender: <xms:ZJFAZXA5mxYuB7-fPajxTjvTx6cvo03xkYB6aginCkfW9GXEtvfCNQ>
 <xme:ZJFAZdgw6HBUr7ol-KOaj52alP-XxFGlsuqvsprlc9aQgUWv97O_70GqhcVVfzR81
 VbSLi32fSR8UIk8ew>
X-ME-Received: <xmr:ZJFAZSk0P_1dpXmimA70F5EYwnwz7jzZ7PVFQdnozkU0n13v8PLe2VpKMhJMpkqI5CFBvPP0_BZxuO1ESqpJDXzHmZm0PfHJihhct7VFNDySHSf5sdYp0WkNI02EWk4VJR1A6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ZJFAZZx3dYXIM3qEkH1hzHOC1vk15ZE3Fhbos3NcZuw5gRXm7l6q1A>
 <xmx:ZJFAZcTZjSSRkxFO7PCD5Z-_sp02ad1Y31hrAZ7ILJ6TtdeR7BoIGA>
 <xmx:ZJFAZcZsojtSQajhK_hkXBbmLd4JyyApoSHIVWV0SH8m4k8N_QdpOg>
 <xmx:ZZFAZXfbqMLypW0eQbmbEf04LGPqwD3YJ0OwVTNygc3ISjMw3aoi6Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:32:20 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH] riscv: Sort target configs alphabetically
Date: Tue, 31 Oct 2023 00:32:12 -0500
Message-ID: <20231031053219.63764-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Clean things up for the next time somebody adds a target.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fc81fb284c..6d0d812ddb5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
 
+config TARGET_OPENPITON_RISCV64
+	bool "Support RISC-V cores on OpenPiton SoC"
+
 config TARGET_QEMU_VIRT
 	bool "Support QEMU Virt Board"
 
@@ -24,6 +27,10 @@ config TARGET_SIFIVE_UNMATCHED
 	bool "Support SiFive Unmatched Board"
 	select SYS_CACHE_SHIFT_6
 
+config TARGET_SIPEED_MAIX
+	bool "Support Sipeed Maix Board"
+	select SYS_CACHE_SHIFT_6
+
 config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
 	select BOARD_LATE_INIT
@@ -32,13 +39,6 @@ config TARGET_TH1520_LPI4A
 	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
 	select SYS_CACHE_SHIFT_6
 
-config TARGET_SIPEED_MAIX
-	bool "Support Sipeed Maix Board"
-	select SYS_CACHE_SHIFT_6
-
-config TARGET_OPENPITON_RISCV64
-	bool "Support RISC-V cores on OpenPiton SoC"
-
 endchoice
 
 config SYS_ICACHE_OFF
@@ -76,12 +76,12 @@ config SPL_ZERO_MEM_BEFORE_USE
 source "board/AndesTech/ae350/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_icicle/Kconfig"
+source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
-source "board/thead/th1520_lpi4a/Kconfig"
-source "board/openpiton/riscv64/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
+source "board/thead/th1520_lpi4a/Kconfig"
 
 # platform-specific options below
 source "arch/riscv/cpu/andesv5/Kconfig"
-- 
2.41.0

