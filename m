Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FB3CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6BA84825;
	Mon,  8 Jun 2026 19:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UI4gAoZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF7D84878; Mon,  8 Jun 2026 19:14:27 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803C8847C3
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bf046d4da1fso468085466b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938865; x=1781543665; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FME6/6Awez9s+hjHlMprvDcWU6wsXs2H1wG1nkLs5Po=;
 b=UI4gAoZrTFBAWYzTrv2ZELawkEp6A5SfSGn22UObXSzpSaJEYk7kE9oFjiL7IZsU7j
 0ziQ8jznGyRmPt3nFbhkRmSjdTBQqdwOESMDHB+kUoHMTG5zL+tQNoYi/UMLJA4UHR03
 MjizFVhEAETCkkiuFOO/EYTQyi/MhObcebu9838B/RWVmh6Ne8I+tip0aQFuYBzkOrSL
 xyZQRW8n8x/G1vTEQhLXdRCSnb9i5Q5gYdCF6qgVqN7Am+3OiipsxgMkloTwTMQOPeL4
 hmtKY0MtYJYXMe+lKUDRBJ8+kUpUEdLPwQti/4ErxeoridUTX5EGFthEw4erqHfo/ieg
 Ir6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938865; x=1781543665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FME6/6Awez9s+hjHlMprvDcWU6wsXs2H1wG1nkLs5Po=;
 b=BobW6995FbXrlehrlq9imXYVR9Zh85zVFI0va7+p8Np+34/AAl9aNa1XNWZjnqr3PL
 ZH+oURVEOWNjEi7WIrw84KX896d6yBg48NCdkeheU148i11idfU/B5unq76FHuljCT5N
 19VaBk/ZlgfTKs1c3e3bGi+i6aQiv2bFCTSaYjdPpKvaYsxiN749j0BoTXtKEzaixpBR
 nQ4+APcXu/3tGtbSpmDQ0IaAuf+A8y1IrO4XNy0No4jzx1PeARY2YB3NdKMYSTub1dnp
 PMv8egpjj+oN8uugh027p+qwiII5v5Y73f19roeuqkBfI9XHLJq3mfuuxnMGT7HUA7w4
 P7lw==
X-Gm-Message-State: AOJu0YxC0fEwE61SkALl5kKcMKHfZOguOT3xAtzLz8w543VGdgtL3wWr
 mLyTaLfconPop517FyUvGFWeAddJV9dw1pXklnS26W7qHSNMjc7mrzkTpMVWyAT+6UU=
X-Gm-Gg: Acq92OHDnyz6tGFI8QgLhfI5021yhF4d6UbioQp2KAFV4quaSbMnWZ42pbJO1qUQgiZ
 5sj2yi0R+ipHjKyT4G4MxKPH8L3VTNK6FDRjq5swhkRd4TaXJFhjJvOer5n1oA9nmqVRa3+QFe/
 XWiaL5CimK6Nbp7P0q/CfcejS8Umx51VZkmCuyWRYR7K1Fdn/MofTCF/aZFor3MiXpTZ65ulJW7
 iBTpH1p0aUzBZtN52/+uO+4WCwvNdRlUrYmFXJaVyiMwQCwwh1Yz/EJ1DLrkw/T7junWMl1Ra2Z
 uqUYmNL/iU4Bwl+ssyxEzuKrcQui4Oc9Ruz4gk8Edr4UAfgzg6/Tk+O7wQEiDaG9Of+jPGGe6uh
 6HlZLw74nTxiYxjJGU+BO7tjpXtv3bzBR08D8v+nGJrPb8RwO4wjZRCMR+ojDtDJ01vTsp/BgD0
 ThEMkkdKK7b6Aql6HwIz39NAkSUDWBh4IPqDhEvyh4WI3GyaPtsgeIYOElSWgvV5kubkQEaUsNo
 Nkd
X-Received: by 2002:a17:907:7606:b0:bec:5234:af7d with SMTP id
 a640c23a62f3a-bf37018109bmr600326566b.6.1780938864352; 
 Mon, 08 Jun 2026 10:14:24 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm893898766b.58.2026.06.08.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:14:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 08 Jun 2026 19:13:50 +0200
Subject: [PATCH v6 3/4] armv8: mmu: commonize the set_one_region() loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-mmu-unmap-fixes-v6-3-ac0764cccf40@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=dE4sCe2I/EcLxLorisJVts5SUeJQAevRNiZf7JADCTY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiy1H9nVJ+7rhHc7N9z4zrx4yc9P/dWZWddeqKnIJcTeX
 /noYU9dRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiInTLDHz7Zu09tzcM+5D4W
 Mcw86D+dzVVMNtMr59tr10k+MhtqJjL8D1iaw1Ek++6IeseBO6tPxbw2ib3yRH/jD8XOJRPWn4n
 KFwAA
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 94 +++++++++++++------------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 91c55591a1d9..01f72c3d0ec6 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1032,8 +1032,30 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
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
@@ -1051,28 +1073,9 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
 
@@ -1082,31 +1085,11 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
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
@@ -1115,38 +1098,17 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
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

