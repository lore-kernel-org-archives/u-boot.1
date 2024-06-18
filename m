Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C8CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DC388352;
	Tue, 18 Jun 2024 15:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="dxkfpq6Z";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="KFA//ZMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F07686784; Tue, 18 Jun 2024 15:56:28 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F4163882ED
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 73D491C00095;
 Tue, 18 Jun 2024 09:56:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 18 Jun 2024 09:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718980;
 x=1718805380; bh=DDqQ7ITclzHzWovVIuW9En1uys38aox71jMS+LHnGlI=; b=
 dxkfpq6ZxkIGpU1FudU2ABsTWVeIqc6djvQL4oIMlo46uIduYoOCpsCYsYTwmT2L
 lks0mC9CmxGNvtI0HzOQA2XbQQDRhFAVJtjjHNn4FWcE5ebn5j4AND161URYiGhg
 T+mp+/mo12pRjJsndSCyHJgy7aJjTmWt7Lrid9FniV/NEXNAfu1ytPH5k1aXnKIy
 QsWziJ0fUjUxZLadA3bk/KiQsGCYmFVmBjiHw0D5/kx/1qvE721qKqN5nl293Gdw
 s06kk9/8bW4GrBNmOleNzy/1RZI/hm+qBmhile/aR/W/QwmObbgKk7mx/hKcF3nU
 B/kncHy8n7/VJe0WYDHHQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718980; x=
 1718805380; bh=DDqQ7ITclzHzWovVIuW9En1uys38aox71jMS+LHnGlI=; b=K
 FA//ZMKgtSxyAk60eMTIRwsZicmXZcbo1cWtvzEen2jIjKtHVkjoOZCEdBNEi413
 yDKAVNLYexnXQDRoyWYYn3ZXxK5XOBFnNrBTIVppTO/CJRs8eduRnrDaO3/GhY00
 C+87YK8sUS1VQ3B3aTE0CouJC1mvN/6A8B/QMDh4/tT62v0vWd3zfHZGpWUVphkx
 sqjlBDrl+DTUsI8gHUwUgm7YZstt1vAzSjHyKF1v37jW2AgByLk4bbG/7oI8wivh
 Dhd3/g3Rzi/Yvl5KzhUl5aVx17MHA36sxT8BB+L0GKTdLd7U8Rz/T9qiAG0VOfzu
 H/ztMYp8VGvjFFYlZ2Mng==
X-ME-Sender: <xms:A5JxZlK2oBglZcicAowapHEH77LE-u8vKMKmpMrATJqsG_QmWYdF8w>
 <xme:A5JxZhJpyVc-hrLjsr-T1sqlOS-UY5Q_EbRgBt4SZQ3YaneVacEiDar4_DLctO9-E
 5rwNRRiLUktvFxhWlk>
X-ME-Received: <xmr:A5JxZttAIMXoTRsysyrGh69cWlClBlyGUHvvaNbNoVoi8AWAe0kXd9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:A5JxZmbLx-EoBEgTcD1Y5xivNape5PiDq6793UjqeocVnjvFSR8eWw>
 <xmx:A5JxZsYCG9WcLVHgQtH1U9iPDYuEBX1CsskVi9EOBzIAVQtuedi2Rw>
 <xmx:A5JxZqCubMR3zzU-5r_AWcBSxzY0734cw_RqJDmV-VCRkHye7ja_MQ>
 <xmx:A5JxZqarR3VML3sWZvdzsO7k40rA8NDlmiq5Q8vLjZ98AK_2czIHgg>
 <xmx:BJJxZhNU0IoMhNpg1nJb0jZP8OZz4eNB5GxJL-q5otIccQwweAjtzmdo>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:01 +0100
Subject: [PATCH v3 01/12] xtensa: Move dram_init to xtfpga board file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-1-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=bShfOQuXToDB+wXf0qzgm93+zCGpzXU6bN5JmlZZ19Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYw9M95Ys3Omeoq6222yP5cfO0HoreF5QfeHHSHl/
 Ztbs150lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETc9BkZ+mRrBTiPfFxdOt++
 rPGmWeySU5khAlZlszTXlSSf8bEBavj5SLh49RTXHcF/vC4eWDXl/MTlZy+WOFt8OquzP/XUElU
 eAA==
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

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
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

