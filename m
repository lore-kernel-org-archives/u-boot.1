Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCECA5FE3
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22DE481298;
	Fri,  2 Oct 2026 16:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJX7Z59U1lwy; Fri,  2 Oct 2026 16:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 52C5A81222
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959651;
	b=LX/YGnbnb+37XojT0jTx09teOxQ9pB78Cz6+TOKjCU+ugwHEfCsi81QffT45/Ii7aERu
	 NA9L2d6Hnx2Ql/GTvLoO5lVSL6zVPJn6Vo/+XJyelbRQ5/XZBVg6cY0zNx8S8lUHZScb8
	 trV4Mde0PPvw5vDmNCJVSTmmaUYD9huBlPrxRgLlpTr1470MOp7sJID5iKzUl2LYL6riy
	 uMBc4IuWyA22qcdyGoMAcU+FFFcIRdR/RzIB/z24kFM8jATtB54L9xNrdGHF7CMJ6uOKl
	 Sipl2ZO5f9BSd3ayY/yMichpeGVqcHZHQWq9EwZQF/8Rd1AUt+sXkPYp7o7DhYkF+aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z8zni5n2/e1GfUbU2zv1TWn7LX1kI1GA6LzRaXUPAGs=;
	b=Y+YJraV9dJHQajWId+nszbL05LnMsDpsNWRfbe0jQUUkzKAB1BHkqhigDElQ+lyHbehZ
	 zKbuXY991gGiLVJvFm2ppbzC0gCbwltVLwcWXm/zET/zaUeDXk0TuPN9aERCHPc6qCLZN
	 aXxM1ivy/FDUx/SOR/4/HBqjJCj61H/0t+zs5MSG2uSVtT93yn80rvRithLhQWR90AoPJ
	 MuWCtJRh1lxPpTvyL5xnJrz23tVuvd5pHBHfErgPyTnN3lv0yRvNuLGaCajzZUVrcCmjj
	 pvlrCceqEzr+1RJ1XXFSenqT8VIswtmhI9AneaL05TdullC7XAEB6zPGkUs9tmvx1Dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959651;
	bh=z8zni5n2/e1GfUbU2zv1TWn7LX1kI1GA6LzRaXUPAGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIf//jGjXQz8spjVH5sAY+zYMuWn+DE1MArQUIY9yJXU3uwOmhGsv/yxMaTUOXOEH
	 5aLTglY6MLS8nOf3nhJWDhtldB5wj4kYPD4akb89bF4nAIEBvSHJjyb7HkZB8v0zt8
	 lx2VEoc6hG7Mp/kHMQ+7Br4nHtNhqnAiGTi8PegcVPOgOXCn4x1PEgPrItfHtCblcn
	 ebkm3Ncz8irFAGQBtOqq0IH0ZZpAV+kge2yK4FShXApyesByB2qawFbvmt+oaJvvVz
	 MoxVU6aZYr/oUlTdHQdy6IlBrHlH5nmJIAPv/pE+dT+4xHzNQ4yrBwAbpjbAmHld7T
	 Ra6Imk22baZag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52C5A81222;
	Fri,  2 Oct 2026 16:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4EEA3AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B604E40565
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GN6xUAmC1jG for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6A27C4055D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946844;
 b=oUorbfhFiMF24lgT0URkr8pWnz1a0xfwvLnA6BM86tsPwfDJCu1NkSsVf9IG0dyxqh0A
 KUQXrzRuJiuzF1HTy4dBBWkjeHVKyc1Aa9Aj3X8fvBwgIn5lbBJltuCaDcV9H54AwRQfh
 15ZdIONSZA342Re9oWi9qD2jCTam0teH6LpeFQRKBB1REETRkupq+CMGptgEMi0hnI95d
 FaIc/3ZY5impxu5XMBEjslfmr28sS8W3A/f8VJyCw3zB1ZZanAid9Hy0S7kUVTjdwIqNE
 kc/FZCD8y7rfSKQZ77U8xy2mYSNrao8kRhIr3CgG+3PSA3S6faHQ3hKapBlPuLN+qOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946844;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=z8zni5n2/e1GfUbU2zv1TWn7LX1kI1GA6LzRaXUPAGs=;
 b=G2Ec092M9EMZQ4IPWZTyoL4DRJ+2sEPHLHCJcpb9pVnqvlOZcyzwuDP/NlU7E3hBZsYR
 E+sxOm5rsdH4TE8JtVxtxtD3KWd0INdxG9TmZEFs++p9B1+DaqCIpsqdGayzKRPTCauv0
 dZY1zBR/KNwAzwOQ3+UZXBzQLjvEVgZiY154cgZYmfk10HoWP1Jlf22K9h5At3287qqLh
 SWG/Fd29VGyYtmABOI4hvPJbRaH+suBdcMn0pw+cHzao04iLicHdV94bDxnWT6Du80g+d
 QkZx02XuMeF1Sp1cO8+chwTS2cG1knvS84UE7EIRniZIvbdijUp+ES44fJ/HKHiXaFA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=z4Y7y4mb; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=z4Y7y4mb
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A27C4055D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1F1AF4E41113;
 Fri,  2 Oct 2026 13:14:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E5DD0603DC;
 Fri,  2 Oct 2026 13:14:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 11CBE10328255; 
 Fri,  2 Oct 2026 15:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=z8zni5n2/e1GfUbU2zv1TWn7LX1kI1GA6LzRaXUPAGs=;
 b=z4Y7y4mbNaFU4/RoLx/BjsSa9Y4SncOqQWpYykI6uJKcOb09VLfC91QawsLwNWTS2ifaLu
 tnYjAddz39t/BJXbOHPCtl5hyjrpwo6EitZsWN/B263oiNGtiyvu5bg6b2EGunlg3T/I9+
 hFkSMBc/et/ZsSM3b6H9P7IdQbXM0BCCrN5DOl0wflTvZdxGY48zH7QPCAWt9lhlth/Sdb
 wGex8matM/vM0E1usakH6M2b3dhqABIQPUUV/hW07z5AGG7v43NE0qp5tRquQSC22myX7S
 5ENn/kidcwkhWX6Bxsx+uZgRdlwWXzrGf6JgFoqmFX73XxqBylIUuRmWjekyUA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:21 +0200
Subject: [PATCH 03/10] disk: efi: Reuse the GPT entries buffer with simple
 malloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-3-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The simple malloc used in SPL has a no-op free(), so allocating the
GPT partition entries buffer on every partition table read leaks
memory. With repeated lookups, SPL can exhaust its small heap.

Keep a single cached buffer and reuse it while the allocation size
does not change. The entries are re-read on every call, so the buffer
is device- and LBA-agnostic.

It is safe to reuse the same buffer in the single-threaded xPL context
as the returned pointer is only ever handed out within a single
partition-table lookup and every caller consumes or copies the entries
before the next lookup.

The change is gated on CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE), so builds
with a real free() (U-Boot proper) keep the original malloc/free behavior.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 disk/part_efi.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91..8a57fe911c4 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -1141,7 +1141,7 @@ static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head)
 {
-	size_t count = 0, blk_cnt;
+	size_t count = 0, blk_cnt, size;
 	lbaint_t blk;
 	gpt_entry *pte = NULL;
 
@@ -1158,10 +1158,27 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 		  (u32)le32_to_cpu(pgpt_head->sizeof_partition_entry),
 		  (ulong)count);
 
+	size = PAD_TO_BLOCKSIZE(count, desc);
+
 	/* Allocate memory for PTE, remember to FREE */
-	if (count != 0) {
-		pte = memalign(ARCH_DMA_MINALIGN,
-			       PAD_TO_BLOCKSIZE(count, desc));
+	if (CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)) {
+		/*
+		 * The simple malloc has a no-op free(): keep one
+		 * buffer and reuse it. The entries are re-read on
+		 * every call, so the buffer is device- and LBA-agnostic.
+		 */
+		static gpt_entry *cache;
+		static size_t cache_size;
+
+		if (cache && cache_size == size) {
+			pte = cache;
+		} else {
+			pte = memalign(ARCH_DMA_MINALIGN, size);
+			cache = pte;
+			cache_size = size;
+		}
+	} else {
+		pte = memalign(ARCH_DMA_MINALIGN, size);
 	}
 
 	if (count == 0 || pte == NULL) {

-- 
2.55.0

