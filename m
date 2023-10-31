Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C2C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F0487AC6;
	Tue, 31 Oct 2023 06:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="6vfghl6U";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWAVF+HS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6621B87ACC; Tue, 31 Oct 2023 06:37:29 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7574587579
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id B4C583200A49;
 Tue, 31 Oct 2023 01:37:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 31 Oct 2023 01:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698730645; x=1698817045; bh=m9NrMNL+Pr
 4YaxiHN8TSyacDFw6kyNsuB0qnfSHal6A=; b=6vfghl6UzWYpi9CuA+02DknFgW
 TxXIMzE40EmE6aqjE47TEcVH2W3sNpwCzWb28y18KYRy6XZAJPjoevHg2bNuET+r
 YzEGe4XVg9p9a7b8Doik8vRFTh+vr2fjf2CT3ZHXbmPr6VMP8uLub4b73npdL/5X
 KV313vqbfkYLM+tQaUm0AlRyG7ORMRu+HHClOJPNnHECoiXpMmINSOhd3HBsZrlz
 9+EJBYXVBECQbSe3P3uDf3Vk0vqU/JYomIwA11bJfwbPeo6RJA1EHo0+2auMOEIX
 Gggo9Gwljq5g7dHYKtgIWSnJSLhIxh89uiNet4XS279KrHapbodf6YwXIq+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698730645; x=1698817045; bh=m9NrMNL+Pr4Ya
 xiHN8TSyacDFw6kyNsuB0qnfSHal6A=; b=LWAVF+HSO9sQZWhojNOMAqYorviTF
 MOhMFsHTH3I53a99Mf0pJLl7+BZi9z6OXYN33Q1jGt4XxFtJBohsHNPH/l2hN223
 bdYeGjWxfkZdxtgP+4oXcW+8SkaqpKPfY+aoo8XYYiYt/fEDuXm5kNtqA7r+HHeo
 CG9WRsnLvAH5mzTM/xtFj/YI8834yAAMoQ5XHO8/tiKIIvPs6DIp4WiW/qeLctQM
 +jsuGCN6B0T1XDeo/kvB1c8PwsRSJSbRLbq2ojYys5qUVMpHEWZCVqPo+37/Idur
 OVupQ5QruloJgXnigtd5CULGgA7FiLOHm4o0B2fBJU5nLTG42hPJHlkoQ==
X-ME-Sender: <xms:lJJAZcQHUChndMyB5ppjo0pzGIBagwrQRJzn8sYYefHsXapqYXquzA>
 <xme:lJJAZZyCs3liUbUivEUHkHQqJuxsOqjekQnO2qwR2A5R8EEuDnq0F2tQQUzGWlwg-
 gCckTLpuPolUcvs4w>
X-ME-Received: <xmr:lJJAZZ0c9796hncn3eEVMkXn-ByzhfXr-D4DUwnGuQ-Fxz2HnOMKzBXl7Q2gzLBzr2s8FqadcahkRjn1xnb8_hoyOStD2gR6fDGe1hjjXkgs-ps8hJjR4ixmzeWBmjKZHPgcnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:lJJAZQCpi4u4AgH6s1PxSch_8Q5vKods1v7WVn5wtV2oG9VEo8xbBQ>
 <xmx:lJJAZVi5kOwTay8t9pMyCnq9xXr4Cvb1JjNIii3JwJ9wWHgFlKpL4g>
 <xmx:lJJAZcqWKm58uyxMDK-h89x85ZgBWxdwGbB56Uv_hPEJTuDoWWamTQ>
 <xmx:lZJAZYuZSJB_5qaPxLiw_nSKjXRyKgoIssqW0u0Vqcqgbbcd7ZEmvg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:37:24 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH] riscv: Weakly define invalidate_icache_range()
Date: Tue, 31 Oct 2023 00:37:20 -0500
Message-ID: <20231031053723.64301-1-samuel@sholland.org>
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

Some RISC-V CPUs, such as the T-HEAD XuanTie series, have a
vendor-specific way to invalidate a portion of the instruction cache.
Allow them to override invalidate_icache_range().

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/lib/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index c46b49eb0ac..afad7e117f3 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -19,7 +19,7 @@ __weak void flush_dcache_range(unsigned long start, unsigned long end)
 {
 }
 
-void invalidate_icache_range(unsigned long start, unsigned long end)
+__weak void invalidate_icache_range(unsigned long start, unsigned long end)
 {
 	/*
 	 * RISC-V does not have an instruction for invalidating parts of the
-- 
2.41.0

