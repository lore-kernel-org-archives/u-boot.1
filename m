Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060A5CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088AB83C51;
	Tue, 12 May 2026 13:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZShfVlUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D49803C6; Tue, 12 May 2026 13:13:20 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B34801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso2793100f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584398; x=1779189198; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nr4am9gv9U0N/c4vZE/ad7/efBIckjlYmSb+rKmZNbk=;
 b=ZShfVlUCgXSx95MuVq+UJqP74VETxj7VAYku+Ygwk5/Y5IGVqDAZvde+Kkl+UEu1po
 aBVjUdHRer1PNiTTU4a92vDPAbQmBegdpY/G9Jl6LeO6P0I/aQoAuaYT8oev5mlnC3mC
 OpepiCmFxzkvbCR+mX8/u1VhI6uKbNZ96QD5Ne8+pYEzhz5LDxUcEFMlsC5lFu1FhqoQ
 5ZLo1IKklyc/kATK9DwE2+x35GiHCHsszaPMHGZZXHMNXz/xxeaegPkzKsQJY9SLdAWZ
 7E4HVybznzARz+tB1bHrQoy4ISBhyOHWa9l1M1FfMHDmOJN2G4IvYc886RhDteAbPJcm
 FaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584398; x=1779189198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nr4am9gv9U0N/c4vZE/ad7/efBIckjlYmSb+rKmZNbk=;
 b=inX2ZYceHYmcWE2vkzSTvMUHCPxPa8SImIOKJf9BpeBJQkwQm8bXDfNh4UfKeDZInK
 qLl0lOUcGjVQctTZa1Xu7ROcTJihc+64QkZW6xGcx5rjIsCiAKuGHbSOQG6wZE13BtQq
 5HfbqPTF74orYXXDWReu0JQuxH+wR1w1BLZrMzMmT+vvFUmgUeMaIzWjfTmhAPOeqFAC
 1LOIqi0JpbPBLyOekWsmjnj/BaMCxkOKvPSsHXY8WcoDjglFCKn+O1RtnUdcAzorYb8z
 Z0C5Zb0wIGU14l8lijpcGNk3+FqJY8HCc3TF3QQPzBtL/wufBWKHFToTFK6J1RAb85JU
 sgvw==
X-Gm-Message-State: AOJu0YxQfPpwL7twfbSXwBey8bFpp235rnxhNDi5DvJkx/pM0VYoOXl6
 fPlHapDzCgt/9JC5gnSqnue2fSaMBl4SbkMZuo0Gh2d4CQ4SWlT8rqNAqe6+l7nZ/zQ=
X-Gm-Gg: Acq92OF62LiFOw/E96KlhTdFXwJWkq2UJISJBGByWpqZ/weOvxYVT9MqWaVZ6LEqb2V
 kuGdSSz2mtwGhJkoaGYtb8h+xBdaF1claQxGxWSUadZiOvY9CyF9sZ3MLT6jzTfFgfaEJoMbGZQ
 94AE1b2dLBAKjqxQS5U0KIG9UDhP5F3Zsh6uz0kVeAU8+nFKzQ5fq5umpOZddtlgtF39U4j5tAc
 LDKNlM6go5v4BzVtrmzU/8+LcTklbXXVzmQZuInKb5FxEBFxaqFuexrd9mTo39xD88QmATxHryf
 vbXHL734TxqbKMtRJsQ990XsQWdGVlGjuJEga1rFe7ZbDo85ySPomifsOiPZBhFYUv/2ZRViAgt
 F0z0T0wZDibhMLi8domo8cY9jXNCVrmSVpLs9PufVdHpjxraRNmaSeg4ZVQNWIATkIawOZ/86h2
 n1gfhf5wGRcpQaM6UrSjC5Hn0lnuVBeZXxXYFVb5HxD4mqscTA/R8lm5iBFCZNSW1ep7I4
X-Received: by 2002:a05:6000:2311:b0:446:96b1:f5f with SMTP id
 ffacd0b85a97d-45b115c7f49mr3475996f8f.8.1778584397642; 
 Tue, 12 May 2026 04:13:17 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm35124259f8f.11.2026.05.12.04.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:13:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 12 May 2026 13:13:13 +0200
Subject: [PATCH v4 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-b4-mmu-unmap-fixes-v4-4-fab802f647c9@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4030;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=y/sMNF1ejgR9HbQ7qmKfCkh9GCcr+aBHtgdY/Tswbb4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhixmbvfVZS/yfywL2lu1Kz3INsuC8XSfXvvSG4kzNX3SJ
 ti4rpXoKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPZn8HwP1zk3r/u6792x3Wc
 F1qWcUJf54rJaneO+OCluy8a2H7J38HwhyPfo+9n0gWuWpckI6WemHPeJj/4U5LOmBz0VfJcIRZ
 pBAA=
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
index e9ce6335ee9e..bcfc36603adb 100644
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
@@ -980,11 +980,12 @@ u64 *__weak arch_get_page_table(void) {
 
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
@@ -992,11 +993,16 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
 	u64 *pte = find_pte(start, level);
 
-	/* Can we can just modify the current level block PTE? */
+	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
-		if (flag) {
+		if (attrs == PTE_TYPE_FAULT) {
+			if (pte_type(pte) == PTE_TYPE_TABLE)
+				*pte &= ~0;
+			else
+				*pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK | PTE_BLOCK_INNER_SHARE);
+		} else if (flag) {
 			*pte &= ~PMD_ATTRMASK;
 			*pte |= attrs & PMD_ATTRMASK;
 		} else {
 			*pte &= ~PMD_ATTRINDX_MASK;
@@ -1097,8 +1103,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
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

