Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2406E6B240
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A3E88B8F;
	Fri,  1 Nov 2024 11:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="Jdvs7wr1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpRQ0UEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E8D889D2; Fri,  1 Nov 2024 11:17:46 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068F3889EF
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id CDC11114011A;
 Fri,  1 Nov 2024 06:17:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 01 Nov 2024 06:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730456263;
 x=1730542663; bh=mYYY/0IaOkD7vF95qx2Uo9EnLgzoL02Vl5ObmTUBVG0=; b=
 Jdvs7wr1/ny76oBu/gNhuoGxxLmqoVtQM5rDau7RjWDbkEvZ9tvOckIXpSexDhLf
 igmzClVIc4QMSxpDTyZGRjbCwniN5WAuk/7QzOCKeGc8FnP9qhzadUMoiwqKORW8
 6BT4rxZmFrjnvP1Dy5scg5iiB7TIlJ223pF+eiUpzGKTzcjpAZ9ie/iTdymVwmyZ
 kocDHLM6O0cvw6xHtU27UMVXuAcpHpJkB6sDqVoahPIEMlDzdmXUcFF4OSn69bM8
 +qz8xffC3SdpGCVAPfM6x+ypsq93OFRyXd1J+LduC9FF6p97nQOMjqSygA+zdoIR
 NVB9kPlDW2dHRRn2ZMk61Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730456263; x=
 1730542663; bh=mYYY/0IaOkD7vF95qx2Uo9EnLgzoL02Vl5ObmTUBVG0=; b=L
 pRQ0UEC6i1P+2B6V7gSlpBeRyimgXazp1qrcOrnn53Sj4bBmMDLB4cqwO9OmLXRN
 DgNLFNsrk5s5tMy6ogcLx9CUs6kJbpRFIQ51Q1qfC5AMPfSH9G6AzFgMAdbC74Kt
 gLYKtVC9J7Fo4/+nN0G/S0KfBRWDmaaDqSP0O0KN3O6u4I6vTXW5hAefglxrlUt2
 MNvD21HQ6nu5onnA+BeKMJqLa4ODBEpPtbDScL69RZw2fAvC4awX9fml5xBb9PPL
 iArqURZ14rC0g948H3Q0ZQjdVAx/OshEb3A/ZCycl0CKTtgrqefgxjn5ehBywW1I
 xQpjNtDQVw0n4g1aT+LZA==
X-ME-Sender: <xms:x6okZ6-0A3LQR816YCHQI7ubnSP6E8dgG1BxIjzHUmmlpClojIgKKw>
 <xme:x6okZ6tEM3ueu4VolUzQilPC6ZhxZCea9cndQcgV2eSi-cG54fhqhdCuITkUCpVYj
 XqNmkPYRvQh_o6FHvs>
X-ME-Received: <xmr:x6okZwA3ihM3J0B6QK0VI5DkBElHegqLN8FoWjL-dFbwZnF506DOSGDHLWAdArSbka-NUA0byMBzWMubfeXZmNtBkUjI5t9NmEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprh
 gtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehs
 uhhghhhoshhhrdhgrghnuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhjghestg
 hhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:x6okZyfXJniDzsh7eXWA5jEoXDTxcTvOSOZCMyE-c3KuagepzMuxxg>
 <xmx:x6okZ_NpDnTRn0e1pCmKS-JIjTvXN6IfEUGun75BYjkKHeCoJQlTaA>
 <xmx:x6okZ8kKPkTfxkZpZmpaOUaoOVXouqflWeu_A6-NlTmGvbPzza9bmg>
 <xmx:x6okZxu_BH5hNHS91a9hav1Fqghwxud6js9hnmsvyRQsBzIY1EYpFQ>
 <xmx:x6okZ7CjEyUXGUG7OEwzEQadOmAbUgdCjJ34WVavKEcXJ6uWM4WBs3IX>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 06:17:43 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 Nov 2024 11:15:51 +0100
Subject: [PATCH 1/4] lmb: Do not use global LMB variable in _lmb_free()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-io_lmb_apple_dart_iommu-v1-1-fe4b9a74d47c@jannau.net>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=tTyU+sFMl5IffnJT7JSvqVmEE+7SQkKIjdYdL6A/LGE=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVVeFf+6vX2m6o+xrLPfn+roxbnD89dumHT8rWXv7dc
 2LIwadOHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACby4Skjw5p6z4SqVWfqYxd/
 TP30bb5AEOc044idG7+oJwWmt6VuqGf4Z1op8suR2aYyf67h9avfTQRkJ8b0v9nkfvLTvfnPWCf
 LcQMA
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

It will be re-used with a lmb list pointer as argument for IOVA
allocations in the apple_dart iommu driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/lmb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 96a055f951e657bf3acc05c9fa804698ce90c312..5be0d9dd89a506dc1e6e6951cc54441a8d4bb0df 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -495,10 +495,10 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
 }
 
-static long _lmb_free(phys_addr_t base, phys_size_t size)
+static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
+		      phys_size_t size)
 {
 	struct lmb_region *rgn;
-	struct alist *lmb_rgn_lst = &lmb.used_mem;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
@@ -561,7 +561,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 {
 	long ret;
 
-	ret = _lmb_free(base, size);
+	ret = _lmb_free(&lmb.used_mem, base, size);
 	if (ret < 0)
 		return ret;
 

-- 
2.47.0

