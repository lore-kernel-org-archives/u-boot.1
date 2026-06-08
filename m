Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEECCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16C984841;
	Mon,  8 Jun 2026 19:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DR/yMJa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF7E841C2; Mon,  8 Jun 2026 19:14:24 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EFD846E6
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bef8b97655eso891691766b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780938862; x=1781543662; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DOscfCuMjNweWEL26DBtU8yza+YXB08EIRT4Ypf3V7s=;
 b=DR/yMJa6HUjC5g9NO4353pO8g01VC6HhkNGW5N+Z+EUWmXqMeITpBHApVkRTg+/D2A
 ub2XbwAcU+O4/ApNwr/CB7E/Wpnyb4NUiuIeFJI2J+wGGgik9pgc3LkKaIQySjo+j/fq
 Z6coSAnPel4cZsCucfcjgacJa18TOHDIuPg9YqkUzTK/7YFmB9Eff8icGt/JaG1eEmMn
 qB29xC2Cqg5SeRpx5KnMxQAtC1M59/0OAlsnrjMfW8qF2FntoE71y6dEZNObckHmYeTD
 tpVcufUSlUFzwi+2Dun2K7AQp2S6rkah3E1NQOnX8L8wRAFEmSV3zSgZ2dI63yMbqeUe
 epVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938862; x=1781543662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DOscfCuMjNweWEL26DBtU8yza+YXB08EIRT4Ypf3V7s=;
 b=Dm5Zm2vfOXOT9beG4+BO2z49Yz7/Y+3KKtfX+uQyWhM22KHbJDiePyK4wNfXxrME2h
 yGXQ7NNaCCsR9JAUE35FEEKYrzu7iENdj/DkKALMCcsUFi82XbayLSe61HadQw1rjNSR
 T4OHbcLsRLL2EgYPj3SyOLu6qbetVPmuHtWANwTPyeguHw7cQqPchT00/VihukzVeVKt
 0mGAP0AL0MLzWAZuOjPuarfshGEkkxjNqz9OTsNECNrLkEwtsJ4JyglSFOtMK51yT6gD
 QJITf1BGxhcWb1/rC7It1G8PzOW6h4Dt2sWCxS/kHQNOxdwaoB33AyYTKSfnAYU97dR1
 9u4w==
X-Gm-Message-State: AOJu0YwQ2DfSpwKd3UfmdAU+TnREwSUpdvjY8y4xLAuKpXUw44ra/jRT
 UJc1a9zuzA64hYcMn0clAehkJvZT96ICsNAXQt/Mx8kEnWnwtYR0ZeeEz8uq68nYrgE=
X-Gm-Gg: Acq92OHHjAljQ221ArNQlIYR6dm+PaMzHBRx5HvrZLqi2AXwrzfRfjCSrJjQ7mo+U/l
 weg+49Lh3oWYLP27GhTPROv0kteQiFwX3eNZRJ7gf+fqzUWOv5mUr2SFHTj2kTR89Kzs/yQIz0s
 BEKIua2fDwcrWiw2vm7aHdUujxChcavfjQTs8u7KLIuZaV9v3it3yyHH8unWBsBR0Tfiml8vIfL
 G62fZUrxtt6EGcgMYHzMzfKmgAtJ+TWapmp/RjyZSXjTDtlsX6qXTmsVt6e2CToxTtfe3/d39iQ
 I5xhTYneGZqITkwi6gHokyusGd8tV3Rrz68pafkB4DislQHivY+HBG1mi1oQKHI16X4pczHnYel
 Z/EiogIT9A8N02UUfLe0IDcNFJirasG1Wnas8oO7hfVn7hrBzwoQWr1obhfZIx8DsgR/jOdsSfn
 5PHtntkSksgo0OT8F+dYnBMqBDtkYIriHfLCitt4GecsXTyVT+Zi8SYFAqxLXZmxzVzYyjZZ2UZ
 JCF
X-Received: by 2002:a17:907:8d8e:b0:bed:15ff:5fe2 with SMTP id
 a640c23a62f3a-bf3a8c05094mr635928066b.17.1780938861932; 
 Mon, 08 Jun 2026 10:14:21 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f4144sm893898766b.58.2026.06.08.10.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:14:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 08 Jun 2026 19:13:48 +0200
Subject: [PATCH v6 1/4] armv8: mmu: add a function to help debug TLB
 lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-mmu-unmap-fixes-v6-1-ac0764cccf40@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fmZl2uIm41NO3nA+ff4C5Rb/kOrC2+YVOsP4nLTFmRE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiy1H9m2wgcSjH9sY4pc+v+ImKuWseik2CeWYnpa6tNUm
 9PToj90lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgImc9WT4X2TW5GOTKaXRVtt+
 eNaKmuAHV7ld1DdM+cj01z7zvWD5akaGZbl3p+yu2Kpc9aj2zJnOk6dusoUmbpgX/OejSC73qgc
 aTwA=
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

Implement a super basic software TLB walk which can look up a single
address in the TLB and print each stage of the translation. This is
helpful for debugging TLB issues and will be compiled out if unused.

Example output on QEMU aarch64:

Performing software TLB lookup of address 0x50100000 va_bits: 40
  PTE: 0x47fe0000. addr[47:39]: 0x000 (offset 0x00000)
  L0: 0x47fe0000 -> TABLE (0x47fe1000)
    PTE: 0x47fe1000. addr[38:30]: 0x001 (offset 0x00008)
    L1: 0x47fe1008 -> BLOCK (0x40000000)
      [0x40000000 - 0x80000000]

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 60 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  7 +++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 7c0e3f6d055e..f07204ed2fad 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -733,8 +733,68 @@ void dump_pagetable(u64 ttbr, u64 tcr)
 	       va_bits, va_bits < 39 ? 3 : 4);
 	walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
 }
 
+/* Do a software pagetable walk for the given address */
+void tlb_debug_lookup(u64 addr)
+{
+	u64 va_bits;
+	u64 ttbr = gd->arch.tlb_addr, *pte;
+	int lshift, level;
+
+	get_tcr(NULL, &va_bits);
+	level = va_bits < 39 ? 1 : 0;
+
+	printf("Performing software TLB lookup of address %#010llx va_bits: %lld\n",
+	       addr, va_bits);
+
+	addr = ALIGN_DOWN(addr, 0x1000);
+	pte = ((u64 *)ttbr);
+	for (int i = level; i < 4; i++) {
+		int indent = (i - level + 1) * 2;
+		u32 idx;
+		u64 _addr;
+
+		lshift = level2shift(i);
+		idx = (addr >> lshift) & 0x1FF;
+
+		printf("%*sPTE: %#010llx. addr[%d:%d]: %#05x (offset %#07x)\n", indent, "", (u64)pte,
+		       lshift + 8, lshift, idx, idx * 8);
+		printf("%*sL%d: %#010llx -> ", indent, "", i, (u64)(&pte[idx]));
+
+		pte = &pte[idx];
+		_addr = *pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
+
+		/*
+		 * Check the PTE and either descend if it's a table or print
+		 * the mapping and return.
+		 */
+		switch (pte_type(pte)) {
+		case PTE_TYPE_FAULT:
+			printf("UNMAPPED!\n");
+			return;
+		case PTE_TYPE_BLOCK:
+			printf("BLOCK (%#010llx)\n", _addr);
+			break;
+		case PTE_TYPE_TABLE:
+			if (i < 3) {
+				printf("TABLE (%#010llx)\n", _addr);
+				pte = (u64 *)_addr;
+				continue;
+			} else { /* PTE_TYPE_PAGE */
+				printf("PAGE (%#010llx)\n", _addr);
+			}
+			break;
+		default:
+			printf("Unknown (%#010llx)\n", _addr);
+			break;
+		}
+
+		printf("%*s[%#010llx - %#010llx]\n", indent + 2, "", _addr, _addr + (1 << lshift));
+		return;
+	}
+}
+
 /* Returns the estimated required size of all page tables */
 __weak u64 get_page_table_size(void)
 {
 	u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 5359b2ad87bb..8e6989810b08 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -186,8 +186,15 @@ void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
  * @tcr: TCR value to use
  */
 void dump_pagetable(u64 ttbr, u64 tcr);
 
+/**
+ * tlb_debug_lookup() - Perform a software TLB walk printing each stage
+ *
+ * @addr: the address to look-up in the TLB.
+ */
+void tlb_debug_lookup(u64 addr);
+
 struct mm_region {
 	u64 virt;
 	u64 phys;
 	u64 size;

-- 
2.53.0

