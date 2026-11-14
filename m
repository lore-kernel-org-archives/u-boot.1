Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8F606A331
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pYmVe5Cs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F819405E6;
	Sat, 14 Nov 2026 00:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noEq1BC3coDf; Sat, 14 Nov 2026 00:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B011405E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615115;
	b=jIQwfB4IOJqahYO+/doDf7BHi2s6LaSkgkAZ7YvhtpZrPPDKX8JJoaQ4W4StMO28n2mO
	 Xn+pKswyoJ3Sl/ffWt5AhIidNps7joAApPQqUDsP2MXpryhWzcFfvBYocINXn6vLE2DKB
	 1TUJWrSurNj5lJqpG0C+Az9U+gDYlMujbi0s1iW9yYKBGvCLlOtUHGa9XF9t3poRlP9fl
	 yULTDj/wMyDugN8ey02YKP3uSNY4p2Wnh6294OVAx/Phm6qLMVXH5bakjxtZtYUq8JI0G
	 RkLLy2Hs3GyDI3Y81Jc4gj/QZDul5HJlFTj1G8GnMCkUvERAo3JbqFXH7z/v+n3iVWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VPtcYbnBshYvJTA96QOV0f6aBSR487f5e9csiZxo4o0=;
	b=RAmnvPFE+PTjc9BW9dKm38oz5GnbTQfHKnYr+5lMcz4rRkVy7bv1SSIwIGgb6V7aQJok
	 3f5eC8R2PVwhA5ExgiaV8GEiDfZtP6LsHCCNz7nBXZG0FXU48Px/JpNuV2D/6hXejWun0
	 iTotx2wDR8EX9TK+v+2VYqHFIbtoQ3GoWVN9zxSwVKPqiq3jQrmmWqcRuolcT8f1rk2V+
	 YSuFqbugueCVeVH5rrS9xxyUiuti76jnDhrKigYsxfQOjFLhscjQEfJ7Z1R9bUAYORded
	 EsBLOqmeIO9VkPDcQBLLvFhvrLK9LOCTewBcJqYjO9dgR1/no+QTQ0MWhQAgu3pcm3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615115;
	bh=VPtcYbnBshYvJTA96QOV0f6aBSR487f5e9csiZxo4o0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYmVe5CsjfTtOLa7c4kvweYe+3UGCAWoh/Oys6cijMxfC2igky3iFacmP8rfyxzC/
	 Hfn+RmvNfw3dusvb5AUxtsEJzH/PTDISveJ+qA6yHBK5kmrPNe0MAZDsIOUzczRZFs
	 P4SVDiRwep1zLswTMtCnQdOphOH468rnu8ew6O1Q6a0iry/f1qzi2V1xxTeQwJbCCA
	 c9R3gV1SHzoU30jEhVoB2zCrGIxmzIY9OEK99bnhOO0brhSGSJpesqRvPjB4d6Pzhl
	 +T1uJ3fw6+QuAGIe8VXDlIxD+s/e4igkpNd70djgaJIzvbR8Euj0Y2uBBthesx5ghD
	 l8bwPi3kjjHvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B011405E7;
	Sat, 14 Nov 2026 00:11:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1622F28C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0B0A40269
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZBnpKHS9QMh for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:11:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3CDA24025F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CDA24025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:11:52 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1Mt-0000000006L-2lT6;
 Sat, 14 Nov 2026 00:11:43 +0000
Date: Sat, 14 Nov 2026 00:11:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 6/9] boot: imagemap: Clarify region replacement
Message-ID: <655b83ffe57eaed4c505c60a36941e8bbd21b035.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The comments describe replacing a region only when it grows, but the
table keeps one region per image offset. Document replacement and
pointer lifetime, and update the allocation and extension descriptions.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/imagemap.c    |  6 +++---
 include/imagemap.h | 13 +++++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 0e3fbd0934a..8455763815e 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -96,8 +96,8 @@ void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
 /**
  * imagemap_record() - Record a region in the translation table
  *
- * If an entry with the same img_offset already exists and the new size
- * is larger, update the existing entry. Otherwise add a new entry.
+ * An entry with the same img_offset is replaced, releasing a reservation
+ * it owns at a different address. Otherwise a new entry is added.
  *
  * @dev:		The imagemap device
  * @img_offset:		Byte offset within the source image
@@ -114,7 +114,7 @@ imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
 	struct imagemap_region *r;
 	struct imagemap_region entry;
 
-	/* Check for an existing entry at the same base that we can extend */
+	/* Each image offset has one entry */
 	alist_for_each(r, &priv->regions) {
 		if (r->img_offset != img_offset)
 			continue;
diff --git a/include/imagemap.h b/include/imagemap.h
index 984a2fa8934..dad438094af 100644
--- a/include/imagemap.h
+++ b/include/imagemap.h
@@ -74,8 +74,9 @@ void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size);
  * new pointer.
  *
  * If the requested range starts at the same offset as an existing
- * region but is larger, the existing region is extended (LMB
- * reservation adjusted, data re-read).
+ * region but is larger, the existing region is extended and only the
+ * added bytes are read. The region may move to a new address, after
+ * which pointers returned for it earlier are no longer valid.
  *
  * @dev:	The imagemap device
  * @img_offset:	Byte offset within the source image
@@ -88,8 +89,12 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size);
  * imagemap_map_to() - Load an image region to a specific RAM address
  *
  * Like imagemap_map() but reads into a caller-specified address
- * instead of allocating from the scratch area. Used when the sub-image
- * has a known load address for a zero-copy path.
+ * instead of allocating one. Used when the sub-image has a known load
+ * address for a zero-copy path.
+ *
+ * Each image offset has one region. A region already recorded at
+ * @img_offset is replaced: a reservation it owns is released and
+ * pointers returned for it earlier are no longer valid.
  *
  * @dev:	The imagemap device
  * @img_offset:	Byte offset within the source image
-- 
2.56.0
