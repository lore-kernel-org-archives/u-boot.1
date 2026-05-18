Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E01ACD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F4D8460E;
	Mon, 18 May 2026 11:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gObDQf9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A6A83EF9; Mon, 18 May 2026 11:01:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E5A83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso25150265e9.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094860; x=1779699660; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kjlBj6MfvEYLZbvB9hY6FxxkYyPaPq6nJXm2m8+kSvk=;
 b=gObDQf9TgpLKglKbeKSL31L2qGIcg7MCUQoeJeMkKXZCvQ9hb7qaNQxU4p8O5mLfpg
 87t7SLnG9/H0eFHArJCkBM87yU4GPB+eRaylytu6pRwaCT6bKh76vqSIdfvs/OqdDGQy
 LxwsPx1Tc0O/52fPHb8F8KOfUeR342cBY6P+MLu+r3fZ6wTMtpuDOKQpsuLUAhAOcw9m
 UMYzxAGKYyDY8tIYVy1ASECesjzvvDofXjVTmjUuwCNbHxwkkzGYWo4tuS6PDXoKUVfP
 f6h16aitPoQAgJDQMem+YRfmWbjr6RuMuLQ36ESiIMPfI2aeXsOP2v/9mg6e0GrY7bUT
 jflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094860; x=1779699660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kjlBj6MfvEYLZbvB9hY6FxxkYyPaPq6nJXm2m8+kSvk=;
 b=KGstvU4ffm1M5yrKKpBdMQYHllOjSOGA7SOd7trtOQuEcSdU7h/vQBpBQBaaKNheql
 Rvp+YbRl7n7jrvriTZ0fV/c/iSQvgSxSmAG4IdNYLNhUSjKdnS9bBRCd63nTqqEJdurG
 +6Cv3nYfaGCT4tjxbAuFrb1PTQQ9lJIAtdzzddj2egFaF5ep04gT+NwiBszG4XMiSbmh
 B8qlaE2XsH4gYUJAOC4solhtnTpUzpF78iK38ChrNzC18/tbHXm658Xxt2v7mtHA7SPf
 QzyTPS+pQ+g77jw7iZCC66tpc1kIk03duNVewoP/CoW5ATbIwAPWusjhmZSTWjbFTjB1
 NdLQ==
X-Gm-Message-State: AOJu0YyQ5ccywugUKm2j+Emq1wcfuzJIWWEXiWuVsI+3HLVcd2ux2kvZ
 mF17aViBjfp2vSp1JtyeRT/ZWtg/ykujA+8l8BwwOLX2gkIz55XprOAvhEhCeh3wdJA=
X-Gm-Gg: Acq92OH1n+tZtHWZDZi5zEqF0hDDy7u/lZ++ZKjgbEgNBf+lAm7sD/jxmNLBM9wuIq3
 0TylP7EjcLF4SYnXUmJlO2NVx6BDEhHTNqkF6rP+pU93n843UYEaHP2f+nNMf3od7KR0dRRkYNw
 y9IdG1AnH+B9Un0zdKCJZfRgIOfLtC0kDtsQfbowDqJ9a7wm48N3ZM3OBvUYOSDXDNLSG2NGk3W
 DoSrCKjr5MUhBuoyng+UP4TcHgyn1goA7uBn6uUX9Av+iDEo1mQj3tHtuC7WNeuMT5OFJt7xPmP
 tg9MJLvVI9xZEc22/F3RDvcPxArqbyqIAJBao12x38cUGJN8CHmiWFkK3HZi4IVjLelJ2SNfOCR
 4wwFKn/TkOxkIvyInCfqjXNPRvEQKJw/jByZTLVcAYgNKTjjQih2y6rn7v1i4yBd81zsE4UcU9D
 LIyuKOz/DCQ1Ae0uHi5lKx+FMX2QDRzC6JAADPB4vY9o/PDTInfP2DodFp84866VWkzU5q
X-Received: by 2002:a05:600c:8b05:b0:48f:be94:d82c with SMTP id
 5b1f17b1804b1-48fe632518cmr252675005e9.19.1779094859701; 
 Mon, 18 May 2026 02:00:59 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm265269425e9.9.2026.05.18.02.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:00:59 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 18 May 2026 11:00:53 +0200
Subject: [PATCH v5 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-b4-mmu-unmap-fixes-v5-4-7802245a40a2@linaro.org>
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=CVZBhJ1Qu1oD7gO74jKJGd+k99lGYy0vXrpsD9R/RRY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiyuq67ttU6n3Rcb98clHGm3vsQ6zy6rJblGUCqx++n1j
 +I3PoZ1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIkIujIy7Pgi+yHkw8Pe6aLq
 k2ZM65z8WGWRf9DhpSc0JhsYJypss2P4p/1kuu7m1bN/dn67o7QnQejcTPuNhftM3h9kn/wzPkj
 +VysA
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
index 889c566df105..f924e640a4a4 100644
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
@@ -991,11 +991,12 @@ u64 *__weak arch_get_page_table(void) {
 
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
@@ -1003,11 +1004,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
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
+				*pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);
+		} else if (flag) {
 			*pte &= ~PMD_ATTRMASK;
 			*pte |= attrs & PMD_ATTRMASK;
 		} else {
 			*pte &= ~PMD_ATTRINDX_MASK;
@@ -1107,8 +1113,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
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

