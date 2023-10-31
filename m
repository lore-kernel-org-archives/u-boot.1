Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51481C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD2F87578;
	Tue, 31 Oct 2023 06:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="nffjdpW5";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fktz55/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0056687AAD; Tue, 31 Oct 2023 06:36:08 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022B587033
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id B18003200A3B;
 Tue, 31 Oct 2023 01:36:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 31 Oct 2023 01:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698730564; x=1698816964; bh=taGrQ71qwz
 HEt7vZ/tsbz+gBZnVnbAQFACvf+GMPaPE=; b=nffjdpW5ZpOotLiAyUjvo/oyEk
 JYRuIJ/3kcFDQqgwVU4r5ZOVbfgi2NHpZM3A59TuaCJ1OAsN03okv4xYmv9XmRqX
 wc1VyWTm62Yesc5ZNqBA/vtN3qOAuMKfKP1l/M2wPfHT9zGZdsYVuwvy7Qgt/0aD
 u2hMBjEH6RwLENhSkv81LO6NN39lC5q6faAMyXmSxqhMHUJs5rGu8YEXnMRsz3EL
 elm8POkC0+cpP0Rq7aQCdZxDCbmlKwqYe999zscpJoVK6iJKcXHXUmZctKxCxvSL
 bNhnFh/Jxw1r8drhlcAA4GShI3cTkLJ/t0L+5ScB0vwJ+ec8zKDHTAZwlZYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698730564; x=1698816964; bh=taGrQ71qwzHEt
 7vZ/tsbz+gBZnVnbAQFACvf+GMPaPE=; b=fktz55/S4Xu3MPAlmOE0ZCKLHf9No
 HOnEXGd2BCyGJM3x/LLWgw07LwFTskY7dF0zjOLxscHm4hwUDdi3/0hvOqLMlo9H
 7MxJo61SMH6/Gmdkbft0kmN3rMLGTYlmyQ3in+ZYVJKWpNi1ThbLdxZ0q1wTPHmB
 +E3jRgzecbEs/d5xJYuFxksMc8WUpUhgyjcmQ5xuvLbswJEGExWu56fVZc+1H2s8
 pr6QJgVvSCHVYg2GotILK+vFqTJ/39pjsfBcSoNQ/NAOUjL5pfEyVGMMc9fUaPFI
 kXF4ZeZdHouyteB17P4wZ7YgLvyGNBsPtZrdZnjK/9zrRZNzkKtXoAU+A==
X-ME-Sender: <xms:Q5JAZeCro4Rl_LMhN87NpoycEPPEQsHIFF2CpcFngA6ug7IdFGPyjw>
 <xme:Q5JAZYiKkYBOEigB36gvb_vAgMnCmLl6GKx3elJ1_jnd5FJphOtUnm2aiSWY_E9Qd
 RePLxBwzsXZZK9dVw>
X-ME-Received: <xmr:Q5JAZRmELh2K0n-wooyZxC270VTNAwLJ0rh9GCt7joFttwUTojigcXyqhP_4lT-mtVWksTS78TqqrBAXXVu3G9f5Wf_Kt0rdYr74ePx_OnaxLfmjB_emPNzmYZgVJl_kUMm3cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnheptdfgtdeikeefvddufeeiveejteevheetlefhieekkeduveffhfejffdu
 feetkefhnecuffhomhgrihhnpehmthhrrghprdhssgenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
 rhhg
X-ME-Proxy: <xmx:Q5JAZcwgbPE3QcoPgey6cM-S1-0NxF3bmyz4kU6dpuX7rsHmyp819g>
 <xmx:Q5JAZTQD1VAFJHzX0Ip6_tb4bCaP4b8fGoNcej5gzUqRmnjzY2bEbg>
 <xmx:Q5JAZXaxaVj_IkgrBHKgEV24HEqOEFYSg1_0gugfSTkKHw5ZCcQfyg>
 <xmx:RJJAZdePjuBtVPAsW_j2Hdujkq_Gl0GcO_B5dLUfDw02Dtf1NaAHnA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:36:03 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Madushan Nishantha <jlmadushan@gmail.com>
Subject: [PATCH] riscv: Align the trap handler to 64 bytes
Date: Tue, 31 Oct 2023 00:35:41 -0500
Message-ID: <20231031053603.64062-1-samuel@sholland.org>
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

This is required on CPUs which always operate in CLIC mode, such as the
T-HEAD E906 and E907. Per the CLIC specification: "In this mode, the
trap vector base address held in mtvec is constrained to be aligned on a
64-byte or larger power-of-two boundary."

Reported-by: Madushan Nishantha <jlmadushan@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/cpu/mtrap.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/mtrap.S b/arch/riscv/cpu/mtrap.S
index 6eb3ed1d5a8..5cad7b41ff7 100644
--- a/arch/riscv/cpu/mtrap.S
+++ b/arch/riscv/cpu/mtrap.S
@@ -26,7 +26,7 @@
 	.text
 
 	/* trap entry */
-	.align 2
+	.align 6
 	.global trap_entry
 trap_entry:
 	addi sp, sp, -32 * REGBYTES
-- 
2.41.0

