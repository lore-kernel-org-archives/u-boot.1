Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E743FFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC0E8467B;
	Mon,  4 May 2026 20:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wp2ej92j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A6DE8467F; Mon,  4 May 2026 20:37:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFC68467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ad135063so40784165e9.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777919847; x=1778524647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ykClgkRhJ3DShhZRfZIFxr6xJ+WHx6TYbtbqntn32/I=;
 b=Wp2ej92jN3rDvkSSeH+LhPevw9ljHvVU+ezcGGxyEreXxsj14FQ9A7mb7zOt8hyB7P
 /db91DAy3AmiIPRn1S1p3muVxO0qdZk2HiJb71giDHLB1PxiVa/CFXkcwwbQY0MgR6uQ
 2dFmlWtvz0MjpHajjjx5Wt/mZnl5nPjWRXHTweDezCg5dWb6neeJoFdcziQB2frs3nvp
 1jVf/biAn2eGVIZLqTlAMRhyGgMeBW+l12YU0vHnIzzArm6MQDB8XTdMV6cgFVPLjiwv
 dU45HqQ7lfnyJP9JWaR97Xzcl91PJf56rQ/B0MjC2R5QIk6LQsnQJdZ9bjamiu4sYq0k
 iojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777919847; x=1778524647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykClgkRhJ3DShhZRfZIFxr6xJ+WHx6TYbtbqntn32/I=;
 b=pQSsD6udpW4lCQOwKio5E5AUA/ADe29HDzvdqfsQwwpzi8vsoBMCqqXNCF/917j3GO
 9J5Ay3JjHj1jnuT170qFjUmurDT/b5lFLNOpnEoaLGUstlk7bNXHSQ70wMorrVMfkoBr
 0Ohg2CzIKg77nLKRoMg0r4H4NRVAVSrx4moOywqfelyiL/IuAdMc4wBZxy0DG1QY3bwf
 cWWmptGbkaErl7TuO8eDgnuoPvT3tCldoCni1RHEsqqm8JrlbpO7ARm0gLH8Hd2C6eRx
 d00H56MgToj9OVz51EvjD/HgeRUgIITEPJnYtP12XrOqBFPwQJKyDC+ne+Ox6Ix0XqQ8
 57nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BV8/ydMzV04YOwqRCWLInWGvkcgwkEspNfi6+b6hu+4xuQGDYjBteLlYgBfyOy1QApBmw1cQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1NaN7WLgOyMWkU3UvI+W05Vn0yP4I/rBL1wtRJN7b1zBH1GwX
 uIjLc6BNkLb7xKaAXosFylxfBfaw6uzqmeAhwzP7MgadmnjNr6HRxGYMvQKh4l8hK+0=
X-Gm-Gg: AeBDieup2Au+8ZyFAylsUP48CSlcVQZTWDU9Iji5ma1q4xyCekqEtJ+Qeb/Sba67voD
 2mZXKX8znXeaSkj1DdP755DFk/hXcgONY27pn/+u1IBaYJIwP+WWFo+fenx3M9coGPG+vZgAt5o
 zxqIAAhWt8E5GFvFe28fWFKOl4gXoeYf5L880UzrcMAbsKjsPNfl1ZRrlM5MaHATicGlv0VJ/Wh
 0yy/ROn7oX1ZHp4RBBj/zNFQ2h5Y9NscROl5pm3B6XEC178ymIs5cTGksk0X1ngihdQTVD6HaJi
 x7QAEQBfrfFB22rjVo01b5YUcqWKmntB18S5oHZxYpGnPq7bZi2VtYfIGZJP5u0Xb40YDNp0W7U
 2g2Gx4pG5errASdbAOKc4etHqWSlZuOKBcDylYIbBMymC9BvSobbMnly5K04dewAGhSoSvc6Aic
 cqlzVmbMr5++0X+ncyDjXOcKvQkASomYmMRybeXg4mtWIBit7MSHryBRGWC+UkREhLMxe37UZWg
 gDSEp/WKlVgrRA=
X-Received: by 2002:a05:600c:4f48:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48a988ccc94mr199919925e9.27.1777919846839; 
 Mon, 04 May 2026 11:37:26 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7d0e7sm26140711f8f.3.2026.05.04.11.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:37:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v2] armv8: mmu: support unmapping regions with set_one_region()
Date: Mon,  4 May 2026 20:37:12 +0200
Message-ID: <20260504183721.646712-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently set_one_region() implicitly assumes that we want to map a
region and aggressively splits blocks into tables to do this, but when
called with PTE_TYPE_FAULT to unmap a currently mapped region it may
try to unnecessarily split blocks which doesn't make sense if the entire
block should actually be unmapped. In the end it then has to walk every
single page and create a bunch of empty tables.

Introduce a check for this kind of behaviour and optimise with a fast
path, if we're unmapping a region >= the size of this entry then we can
just unmap the entire PTE and whatever it contains.

This fixes some bogus empty tables being left behind when carving out
reserved memory regions on Qualcomm, and should improve the performance
of the break-before-make in mmu_change_region_attr().

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
Changes in v2:
 - Update pte_type() to correctly check the PTE_TYPE_VALID bit
 - Explicitly unset both bits of PTE_TYPE_MASK to be extra safe
 - V1: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
---
 arch/arm/cpu/armv8/cache_v8.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21f..b6506e8523be 100644
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
@@ -939,8 +939,20 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
 	u64 *pte = find_pte(start, level);
 
+	/*
+	 * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
+	 * then the PTE we're looking at right now, in the first case we can do nothing and in the
+	 * second case we just need to unmap this page/block.
+	 * Otherwise we will needlessly create new tables until we have traversed every single page
+	 * in the region.
+	 */
+	if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {
+		*pte &= ~(PMD_ATTRMASK | PTE_TYPE_MASK);
+		return levelsize;
+	}
+
 	/* Can we can just modify the current level block PTE? */
 	if (is_aligned(start, size, levelsize)) {
 		if (flag) {
 			*pte &= ~PMD_ATTRMASK;
@@ -1081,8 +1093,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 
+	/* If we were unmapping a region then we're done! */
+	if (attrs == PTE_TYPE_FAULT)
+		return;
+
 	mmu_change_region_attr_nobreak(addr, siz, attrs);
 }
 
 int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
-- 
2.53.0

