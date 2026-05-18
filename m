Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078BCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D0384150;
	Mon, 18 May 2026 11:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H8QIdjeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED6484694; Mon, 18 May 2026 11:01:01 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD7284676
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so19949555e9.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094858; x=1779699658; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9zp5vhWfMRWiTo8dTKo4R+VXf7gO0quJhgOt1CmwWQg=;
 b=H8QIdjeRW5oJ6kz/F4woXApbRHC9ZoiZNv9VZ8RBWfDlHJOEcO+xVwhnqVgS9mAJ1M
 wNxP5Y7huU35+uPj6OrSUg3qdR6YBdeqFzUB8mnvx9mSHZ//bRljI0bUNhAJrgg9CyKS
 QrSgLwe76c5oZaTt7/bfDeqgbVINIUFcFFeHd+41l2/6wXbSuoDI7bunEX/6ATGaNcq5
 Ti063HPImIedpTdU7J+aJMbyI5/+h1X8kxrsHPfo8+N1z3p/BWB0AMfDm2wuCwcH79XI
 kx+v26Bk7XLGE2X8vTsIa9rKsj/ttUPyMrXuArFff5rLA2Psndmbz76e/1NAh8F0bbgl
 sduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094858; x=1779699658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9zp5vhWfMRWiTo8dTKo4R+VXf7gO0quJhgOt1CmwWQg=;
 b=PLX7kzvbn1SyAY7zQ+nN3ekh/ou/OqqHdYyLgjdmZ5MS2T0yGVoC4K+4SQSurqmJib
 x/Cx4DnAjI3dqBAAlBlf3WNBNqgviKRmUqW42lu5aQyEgMl81FVUeHJb/uJcf8Sa8eir
 AiDi+4ZojdmH5+MSRrb8BWlzI5xkXnClKiZVrhT8Mre3vCdgvZsNduZgo9SqQT1w/zLO
 7p6LrMHS8avyx5KcTxCI0tBzz/r4a0jLLY4WVN1/W4p96EwSN8hG6aMDujcIqI7QiNoD
 ZIctoxBrrq9lHxYSJ6Yn/EJ4FafP3GEwTIppi/hzl/KvmqDZEwrTFgpShPZiyUdBgGZR
 ePuw==
X-Gm-Message-State: AOJu0YyRalImuboZDtxCW6S+HISWlL4W4lZNI4Sny+4aiw0FpgZ1ZCJx
 toheVTwlz7F4FLQTjpdU4QvG9yrMz0ec1ipffqNU99kNEx2MSKoHDhgmxOCEOywO4jw=
X-Gm-Gg: Acq92OGOqDomA3NBM4lFwq6shtRXAOLQEHv/+bVwO0RlVR+Q7C8nOiK6ESnXXTg7pcS
 Hn4SW1kqy1So35NSfdhFiDr2TXPFdElslSZOkrIKfXcSq0Ueok4uOLcp13BqBhAdC/K4XMbbI+y
 RUT41LeDEovz/UGO3dfCMs9xoxSRhJLOoTnebIrbkqBgV4/IQyZInJR4nok04aKhLj5K9sb9M5G
 ZU0ZmiVB0BMSzDxmS8rr0achTM+5pflhMCptpyfmqlDKeCDyLVwFPcOG9YOyj8VwIZw0PvFy0u0
 GGuZL81AGWgXyKNy+dbxI6cK9PNPcIWTmqJNjzlyrs1RwHxfvuErUbBU7A68cpuyR+UVcn+kH7J
 1Gd/E+lD3xruQNaxp7xJYkEROfJUh1KM9bDTkdJU2AbLU6sdNJYGAAEIczsBWghEtTJI3yvvyul
 ymzcpWsG1x8c1BeEUG4/6dAxe/mw1LYqZwPldF4lz9JBSP8oZj35SB73BYcWrhhEtXI91A
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:2a24 with SMTP id
 5b1f17b1804b1-48fe66204e8mr199530305e9.31.1779094858384; 
 Mon, 18 May 2026 02:00:58 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm265269425e9.9.2026.05.18.02.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:00:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 18 May 2026 11:00:52 +0200
Subject: [PATCH v5 3/4] armv8: mmu: commonize the set_one_region() loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-b4-mmu-unmap-fixes-v5-3-7802245a40a2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4559;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=2lKMmdZ02ez9e48qc/A86gpdMqG+Dg43QhWDwvoqdFk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiyuq67sYQ+nn2h1rZL8F8wpzXZiQkTczI1LlFJ4eP5q/
 Fx0ukGko5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzE8Acjwy7zk1u6djd8+uuY
 dL7VK8t2wYuvKvOe/S/zmOn/64WTuRPDf3+VCbkXgrdMdI4Uvz5nzrcIFV2FMsMNVU8fTKwOzmF
 S+Q4A
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

This loop is duplicated 3 times, put it into its own function and call
it instead. This simplifies the logic in a few functions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 94 +++++++++++++------------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 2800ba57a464..889c566df105 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1033,8 +1033,30 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	/* Roll on to the next page table level */
 	return 0;
 }
 
+static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+{
+	int level;
+	u64 r;
+
+	/*
+	 * Loop through the address range until we find a page granule that fits
+	 * our alignment constraints, then set it to the new cache attributes
+	 */
+	while (size > 0) {
+		for (level = 1; level < 4; level++) {
+			r = set_one_region(start, size, attrs, flag, level);
+			if (r) {
+				/* PTE successfully replaced */
+				size -= r;
+				start += r;
+				break;
+			}
+		}
+	}
+}
+
 void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 				     enum dcache_option option)
 {
 	u64 attrs = PMD_ATTRINDX(option >> 2);
@@ -1052,28 +1074,9 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 	 * we can safely modify our primary page tables and then switch back
 	 */
 	__asm_switch_ttbr(gd->arch.tlb_emerg);
 
-	/*
-	 * Loop through the address range until we find a page granule that fits
-	 * our alignment constraints, then set it to the new cache attributes
-	 */
-	while (size > 0) {
-		int level;
-		u64 r;
-
-		for (level = 1; level < 4; level++) {
-			/* Set d-cache attributes only */
-			r = set_one_region(start, size, attrs, false, level);
-			if (r) {
-				/* PTE successfully replaced */
-				size -= r;
-				start += r;
-				break;
-			}
-		}
-
-	}
+	set_regions(start, size, attrs, false);
 
 	/* We're done modifying page tables, switch back to our primary ones */
 	__asm_switch_ttbr(gd->arch.tlb_addr);
 
@@ -1083,31 +1086,11 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 	 */
 	flush_dcache_range(real_start, real_start + real_size);
 }
 
-void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
+void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
 {
-	int level;
-	u64 r, size, start;
-
-	/*
-	 * Loop through the address range until we find a page granule that fits
-	 * our alignment constraints and set the new permissions
-	 */
-	start = addr;
-	size = siz;
-	while (size > 0) {
-		for (level = 1; level < 4; level++) {
-			/* Set PTE to new attributes */
-			r = set_one_region(start, size, attrs, true, level);
-			if (r) {
-				/* PTE successfully updated */
-				size -= r;
-				start += r;
-				break;
-			}
-		}
-	}
+	set_regions(addr, size, attrs, true);
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 }
@@ -1116,38 +1099,17 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
  * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
  * The procecess is break-before-make. The target region will be marked as
  * invalid during the process of changing.
  */
-void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
+void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
 {
-	int level;
-	u64 r, size, start;
-
-	start = addr;
-	size = siz;
-	/*
-	 * Loop through the address range until we find a page granule that fits
-	 * our alignment constraints, then set it to "invalid".
-	 */
-	while (size > 0) {
-		for (level = 1; level < 4; level++) {
-			/* Set PTE to fault */
-			r = set_one_region(start, size, PTE_TYPE_FAULT, true,
-					   level);
-			if (r) {
-				/* PTE successfully invalidated */
-				size -= r;
-				start += r;
-				break;
-			}
-		}
-	}
+	set_regions(addr, size, PTE_TYPE_FAULT, true);
 
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 
-	mmu_change_region_attr_nobreak(addr, siz, attrs);
+	mmu_change_region_attr_nobreak(addr, size, attrs);
 }
 
 int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
 {

-- 
2.53.0

