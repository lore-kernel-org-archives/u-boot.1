Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DA2CD4F35
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C194A80398;
	Tue, 12 May 2026 13:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B9itvK+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1503183F14; Tue, 12 May 2026 13:13:19 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBAD838BB
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44a14580111so3982709f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584396; x=1779189196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w5QMwIsaHtRcr/7PZogZy4KwP01izm+hDr81xLo+d60=;
 b=B9itvK+mnLVINGx8HhRJWBM4kB588gGOBagV254n1h7gkJ7I94oefxA1dcCTRfe5mL
 Mbr8m7vzC619qgtt5X/04nGX1K/ADY1h+QIpxM5KcuM8hQIyJ2FNpV8ECl7SlbsYjqKS
 /ABsC5Th5kQ2YnM7lI2mHTykloAQZJ65mlOrs5PKEw6N02+wMMyoTDI0iyJJ1FMASrNM
 4DybKvd8DhBlpviyfR1FW3SN1C8/MPgdDska658UMgUb+D0lEwJuUl7Hnn8/5lGczqJK
 zC+x6GvDzyj9Ag+zmugDoXdHJtNdtGvjLjdrqHu7tz8Less26GrLGUlVB8pwCiaqftw7
 NjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584396; x=1779189196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w5QMwIsaHtRcr/7PZogZy4KwP01izm+hDr81xLo+d60=;
 b=Fji36S1hjXtWl5uaZvohVnY/gIwkom1LE0E3HjR8u1F0KI7E44PAHXmVbATqdogXNq
 urEfccjZ2tJ9BkJdDqlkLvk6yjzta/iLzD7kASN5+T409t7LXU2q+MhTg4lm+SBWhze8
 UPfIjjgCfX0gVNkNaYDCDahHd9I9q1y0iMDnqIgIR2lFfJgOWOPO2gEOJX/MEvkljRQb
 zRFdw5vTeaQpX71iQGVqiI3rhzNBFqcerid25gbJzaHvL0CN3lJQKgTJIxdjxpTrE1G2
 G6PfrJ0XkxV/gmc5/nmpizxSHU51mT8cJChJXrnNSvX1WWyo7zrRmwHY23RCjYsrYeEq
 941Q==
X-Gm-Message-State: AOJu0YyVcUXEHcezJfsszeFNF0OHmVbkhGdf1713Evoa1z0sStwKsXmr
 1yFgu4if3XjZkyhvNqgrQcaudcoN4yRCoopOpmqgBfd/GLW7dMUAFbwvyBJmWtRhp1Q=
X-Gm-Gg: Acq92OHr51sMwYqnIRcnbZPgLUM0K7cNuAppKZszZYPO88/wPgSg4LdVczpc4Ev6psX
 6Pd4REG4qpeJZemlBv3Vhhv6LNLQ0mU6ZyclOV3ApnNed0hMWlkcV3DDyQ+vq/q0xgBubsyf2Re
 dZ5FZl/laz6gm5e955qkyEObawHuMbktuxhzx8BNb01JYi4nTrBQhUbiHtDfDx90G764vga8VFZ
 cM8lTlTAmMSsUuE1dxpbjy1Yz0yTJBU7XyRTCu8KB5PCCdpFyy8ypHnUuRQ1NqiWp1VdiKOIkVt
 teHzpI/zchLxGGDNMASKcmc9LzqdkFxGylPWaEWUjGKy3aeIn5Clv2hj/xKXPpqZwXxP+AGOuEb
 4PAl2f2TK6aWTTKlBcx5ncNJSf6iO4Qni1Mzg1JkqPxDU0QKFSQYZ248hiDlavqTWC32kgNcZHL
 3fzou61kGljNBs4urRva4qMffBgG0xLAVEZR1xe5enEZ8TmMY3WZkbgQs8RMM4eS+RWsiw
X-Received: by 2002:a5d:6446:0:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-453e3a16769mr26673546f8f.25.1778584396397; 
 Tue, 12 May 2026 04:13:16 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm35124259f8f.11.2026.05.12.04.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:13:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 12 May 2026 13:13:12 +0200
Subject: [PATCH v4 3/4] armv8: mmu: commonize the set_one_region() loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-b4-mmu-unmap-fixes-v4-3-fab802f647c9@linaro.org>
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ekt4UPuBnE3jcJL0tHQiB8yx+uy+b7qMNorf75TBt5E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhixmbvcZ5n27+k+uZpubuONu/+rntiwB113P77w5P7D4d
 a3zUqcLHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiP3QYGeZ+Fz9Qsuxw/K0r
 BrP5H3d03J/zg7Fb96euIseqjkltP+cyMnQJGhroWvBfPMpQvXzmanPRsp+9yUt/lLk84MyLzOJ
 wsQIA
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
 arch/arm/cpu/armv8/cache_v8.c | 95 +++++++++++++------------------------------
 1 file changed, 29 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 36d337378fcd..e9ce6335ee9e 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1022,8 +1022,31 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	/* Roll on to the next page table level */
 	return 0;
 }
 
+static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+{
+	int level;
+	u64 r, va_bits;
+	get_tcr(NULL, &va_bits);
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
@@ -1041,28 +1064,9 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
 
@@ -1072,31 +1076,11 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
@@ -1105,38 +1089,17 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
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

