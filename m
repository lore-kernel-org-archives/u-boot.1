Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E622CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1388A84BB7;
	Thu,  7 May 2026 21:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLezBmJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71FA84BEE; Thu,  7 May 2026 21:58:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98B984BEE
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so11964835e9.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183905; x=1778788705; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZlZtA01fsXs1/qNyGrvhvjvr/eLqDJVA3J+/0iAQuyA=;
 b=iLezBmJOrCnyNhBo3tJS1LFqNPSGV4ioHwUEdLODAYPjpwDJv7RsY6ea6B1BgY0K7y
 mifhpBus/NoYOmjVb23RNkEy2dUy0/EkzXFCwNCeZ9KLObNs4QkMzdRSnCBD6Ix0MWPt
 FZXvkX+XWX2yWFo3mK7v/KQo3GT7VZ8Qk/kbL1fdrpMzbFNncON4/NSY/wXTCociX0bs
 1tjAN1FzMPuwSTSn/JC+BpnKPuvYMYXl3w+S9Q30U7firhtFesZj+17ThSIX1f6YY+JH
 cdY7ZzZ6jDyNDfQ8WSs2QWKHDpPA7r3SdfU0ZF/dSuFRTTXKrdLbyHaWZZKms94w8Sto
 MvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183905; x=1778788705;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZlZtA01fsXs1/qNyGrvhvjvr/eLqDJVA3J+/0iAQuyA=;
 b=e98SR/fqPADDzj9nkHRk3I+4lrs5odYn2EoZVyhVylWahb13PFy+HdwW3UUCidWAse
 k46f2nmGHSVinV0ZoGDjltSQDlcQjvKCRRcJg5KPXskPzI7vTNduPPKJHBr8AZ0RupQo
 GU2qol39eluKSFzIQbLHKVYZYvJr5ppJMUW84lBF+I++azcy1KXxAWfRLsNrdi+uSca/
 S2zdx+lrCUocK4I2SXKrh+VPcyQ5T3XQmI0hufgGHB12df+8Bv2CBzTvyvML5HNgG1LQ
 zNfdX9txFpbPgndF0GMTWGy+n/ubBV6my6P9DUdQ0rkloibrC4CxkPJywgsn2cWAMcu2
 EcCQ==
X-Gm-Message-State: AOJu0YwkMM1nTKnJ9NIcApucOfO5M6dkqswCZmP+fw7HZ8ovaWqlsz8B
 tAsanh+FLFm57058a4pS3FiSHFPejGk8DaTwYQ+KoYaNp06/Pwkctn17ZA2ZeWsVJL6f0Uy4mjx
 yGBhABj4=
X-Gm-Gg: AeBDietpDoEJq05GVlpRMg8f9oMKOQUFT6kQDzkH5cUgw5v6IibQJ6XxX2yugA2DvP9
 kbx5HW/EKjol3SPsU6CD4wqe5354NuWcOqbzU/+fT2YN0GWtvHnqqNPEelEb3g7Myi7fteqid5Q
 tEXIYBSWW/nN8Na5DAqQYi7cEqBRE8AHfsItS0ybPScDg6sGzMs7qBJhhV3iGQwD0Oalyg9JVSA
 6Xqn5ojkul0un5xfHFyht0JSfHrxs57VeorKnTFShr9Cc7xf4QcjxRgNdnS6NeZWXE8AEsUWpFh
 ueGhGRLK4FoC4m4oqLklwdJfgomUU9hbkatQ5JjOqdWwIIG74e2jQcrdvaxRzr/z6IUT1cm8qhG
 z017ImplYd1dPCmZMy6ihX+eRn7ecl9lqZ4ymeZNIf3sFLOrH2Ge2GCi/ULkH5UEdG5FPAvZLcu
 /3e8/1XSLnsRdxZ8kqCtREL93fKSg1usGi2KbJAuVZeqDKZ6tgpZNKWm+THgbE0Qpj92aWRyPT2
 4yqU2s=
X-Received: by 2002:a05:600c:4643:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-48e51f464f9mr93141525e9.27.1778183905357; 
 Thu, 07 May 2026 12:58:25 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm235344265e9.15.2026.05.07.12.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:58:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 07 May 2026 21:58:10 +0200
Subject: [PATCH v3 3/4] armv8: mmu: commonize the set_one_region() loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-b4-mmu-unmap-fixes-v3-3-aac7726d87d5@linaro.org>
References: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
In-Reply-To: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4658;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=4qKXa9Bg0heRd74dhwDpOUr88fzn35KNXO4NS+24ZLg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw/7+54LMvb9GxpzhwHaSNFDl8Rn9NdS0O56rcL7nf4d
 k2szP9NRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI8iRGhvXcC361XFyieNz3
 dfSsK7+4St7uv//uVLPvt1Tt++cStkYy/M/8wu/mojDlWfZ5+UMCXM8/bBZJuhHMVpolXT59yq8
 qJw8A
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
 arch/arm/cpu/armv8/cache_v8.c | 97 ++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 36d337378fcd..bd839b2addb4 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1022,8 +1022,33 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	/* Roll on to the next page table level */
 	return 0;
 }
 
+static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+{
+	int level, levelstart;
+	u64 r, va_bits;
+	get_tcr(NULL, &va_bits);
+
+	levelstart = va_bits < 39 ? 1 : 0;
+
+	/*
+	 * Loop through the address range until we find a page granule that fits
+	 * our alignment constraints, then set it to the new cache attributes
+	 */
+	while (size > 0) {
+		for (level = levelstart; level < 4; level++) {
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
@@ -1041,28 +1066,9 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
 
@@ -1072,31 +1078,11 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
@@ -1105,38 +1091,17 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
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

