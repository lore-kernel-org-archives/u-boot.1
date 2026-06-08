Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A2FCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E7184884;
	Mon,  8 Jun 2026 19:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D1SopsUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEC6847C3; Mon,  8 Jun 2026 19:14:28 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5EA8405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bebb72b845aso685086066b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938866; x=1781543666; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UhpeUZhJKvDWfHz/3GZvCzlSY1yAnzZ5mjRHWtTYPnE=;
 b=D1SopsUJnrHvU1F7jZ6XKzlPil+IAU70Dilku9Mbyz25TZlAV77/nD97nv7cJcNK1C
 BR2aUDsjvCGxlu5J2j6VA8f7I92ejQc22WGUyzFWNZ5laQ/TxJF577GNavr4tlWEhS98
 IgnvDMPsDRQJrlFldPt+MVXDoLDm5Nio2zrb/eLmJeUptvI3p5pFc/LkBlCOK0r1sMFB
 SuUigvTqOzYA1bLwSP5QJPdzFoKnRRCjJWsnZlF27ooB6eyhRIvCYczWrfQRX2/5OCU6
 HA3s6lF9ZptLcSvVjfjjG/XGXDkpKFj2RkvisX//wNuaRFv+fMUcq4lDyah50cnwD6yt
 EJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938866; x=1781543666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UhpeUZhJKvDWfHz/3GZvCzlSY1yAnzZ5mjRHWtTYPnE=;
 b=khzf4DF/S9pIAks0EBcV1xA7fkGjMpgi0hIduvnWm9snUf4FiY3zFQJDUB9nJypI+P
 To5U7zF8aOCa0/1dkPTSKMYNqs0UCGarIGvkr7KdEAciMoDAabz4ENBencEOqIqlhr1m
 50JXMwcitPrvIiRFUOlVWG6EycXUsArnY6VNNidxI3KBn7VY3wYMO6p1Q2VkKhmB2JBT
 J5plEj20SPobeES9GCJOYCp4m2TvXVkUTy9pHg9YTxeGpv7XTCdVSB8I2c5FGexKfhKS
 P/ELS/ndgs8otbyyb81lZB/JR0lRZ4yXb70DMUn/mMqNgzyXZpWyuKubMqsG3F5mb6kL
 kg1A==
X-Gm-Message-State: AOJu0YwkvGAWiDRXJSqcuzqT4jc+hqqsvcfWPdt9CUIIhTAFwkPOJmcZ
 NwrtKEu5E159TAnDGGtsCHiPgA/UVaWNL4ozejxJI3bSDa37MnxxBbhZKAS5QCqtfdF8NmLNJ74
 d3gRR
X-Gm-Gg: Acq92OE75i1X/P3+1yKYQeyrTcokaVvnMF4IQzAuyk+3auFg7GvnwR77EISRWHauELa
 ZxDmwMr/z2Lqi7bFWJ2PiQBje/fvrFzwKtDVXu7ezuqpiClIJq9GEd9cmk7hDtbGbZuc72v2S/S
 q4oO5E76FQ04pp8rIftlhb7ASFrSdPY5o7CABoe2PFAVt4/q8slcwGY4ZO9mVo+YIdDgD5gUUW0
 1d1soJsyZPj7b0AtGBGlHv4GDZApQhYCpXTudRPOPYj0/uoRdqIhh5nS5KM006mPm5VH/30foE6
 SQG8CCnpjWqCnsKjRziFjn7wmlUA3o02PcRyDJ9l5VIwiz0VI453cNZGOLvq4uqAD3ebJUR8XKm
 ha41lvM5IZu0SuXGOXyplRDMAOzj6tIOhHqk54PFmJaX9qqUiZznVfMWrjsHdmaAS8LTu3LPq+H
 ljeHXSduLyTMlWtLIqGfzbo0aeoSvgwLU9GOhEFLQ3CqpNPv0k6YtOhTUsk1w4o/S9U6GGiP9Td
 D3H
X-Received: by 2002:a17:907:980b:b0:bed:8f3f:eb7d with SMTP id
 a640c23a62f3a-bf3703794bcmr851435266b.4.1780938865723; 
 Mon, 08 Jun 2026 10:14:25 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm893898766b.58.2026.06.08.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:14:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 08 Jun 2026 19:13:51 +0200
Subject: [PATCH v6 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-mmu-unmap-fixes-v6-4-ac0764cccf40@linaro.org>
References: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
In-Reply-To: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4004;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=QlDbx3alr4ianVVuPQMUrbJbmq/tvtZuQgxRFfRYYKQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiy1H9mndlcqKO60XBsazGD98o7G5Sol/vTL+wz3Fbf+D
 Z368YJURykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIXX2G//X9v6r2Nc45V3lr
 2X4HodM3P/r8Lki9zGUnU6d04Hbgaj9Ghk7N/pl6b597bHjUckfg1d1bx+tvtx8MFNfQObO0Zkn
 fIVEA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

As more platforms start ensuring they explicitly unmap reserved-memory
regions a few issues have appeared with how the existing dynamic mapping
code works. Fix these and get a small optimisation as well.

1. Teach pte_type() to actually respect the PTE_TYPE_VALID bit
2. Don't walk the TLB a second time if we call mmu_change_region_attr()
   with PTE_TYPE_FAULT (since it would just be a slow nop)
3. Fix how set_one_region() decides to split blocks.

Today set_one_region() will always split blocks until it reaches the
smallest granule size (4k) and then update all of these pages. This
appears to be due to a big in how is_aligned() is implemented, since
it only evaluates to true if addr and size are both multiples of the
current granule size, so a mapping aligned to 2M which is 4M in size
will cleanly result in 2 blocks being set, but a mapping aligned to
2M which is 4M + 8k in size will result in blocks being split and 1026
individual pages being set.

While for the address it is correct to enforce that it is aligned to
the current granule size, we only need to check if the region size is
greater than the current granule size. This allows us to simplify our
second example above to only 4 entries being updated (assuming no blocks
have to be split) since we only need to update 2 blocks to map the first
4M, drastically improving the best-case performance.

In the case where the address is 4k aligned rather than 2M aligned we
will still be restricted to mapping 4k pages until we reach 2M alignment
where we could then map a larger 2M granule which previously would never
happen.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 01f72c3d0ec6..6c85022556ad 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -162,9 +162,9 @@ u64 get_tcr(u64 *pips, u64 *pva_bits)
 #define MAX_PTE_ENTRIES 512
 
 static int pte_type(u64 *pte)
 {
-	return *pte & PTE_TYPE_MASK;
+	return *pte & PTE_TYPE_VALID ? *pte & PTE_TYPE_MASK : PTE_TYPE_FAULT;
 }
 
 /* Returns the LSB number for a PTE on level <level> */
 static int level2shift(int level)
@@ -990,11 +990,12 @@ u64 *__weak arch_get_page_table(void) {
 
 	return NULL;
 }
 
+/* Checks if the current PTE is an aligned subset of the region */
 static bool is_aligned(u64 addr, u64 size, u64 align)
 {
-	return !(addr & (align - 1)) && !(size & (align - 1));
+	return !(addr & (align - 1)) && size >= align;
 }
 
 /* Use flag to indicate if attrs has more than d-cache attributes */
 static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
@@ -1002,11 +1003,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
 	u64 *pte = find_pte(start, level);
 
-	/* Can we can just modify the current level block PTE? */
+	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
-		if (flag) {
+		if (attrs == PTE_TYPE_FAULT) {
+			if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
+				*pte = 0;
+			else
+				*pte &= ~(PTE_TYPE_MASK);
+		} else if (flag) {
 			*pte &= ~PMD_ATTRMASK;
 			*pte |= attrs & PMD_ATTRMASK;
 		} else {
 			*pte &= ~PMD_ATTRINDX_MASK;
@@ -1106,8 +1112,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 
+	/* If we were unmapping a region then we have nothing to make and can return. */
+	if (attrs == PTE_TYPE_FAULT)
+		return;
+
 	mmu_change_region_attr_nobreak(addr, size, attrs);
 }
 
 int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)

-- 
2.53.0

