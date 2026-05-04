Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF51DFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E68F8467A;
	Mon,  4 May 2026 19:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DFzPomsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D86B28467B; Mon,  4 May 2026 19:55:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CFC80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so42158415e9.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777917322; x=1778522122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M9UkPO56j0Qek9szbPKIs4NmRNBhasazroYlSkGGTxo=;
 b=DFzPomsO9UcBvW6aKNicf4P80xkqYTK5Da6pdetGA/bvQzaYoNjteiUrwspCGHrvy2
 lHUnmzwfJh3iJqRZgjvJsGDbNsne1UKXIFsUzWJmrp92Eacgl/mqS/H11ZF6OK1snEWu
 k20YWUy0aJ/bk1mhm29TiPdJQIysE5JV6I5JN/t5DJdmKB8emjJ/ly+XdVQyZmhUdG7n
 k6Q6cp8yanTLdJW7Sf60sm1+NC1OakDY1MJsuoJM9y+thagDIVMExv+BRkxG1j9wlh0Y
 LmeURU0vCwjsFLHnMsxSvvM4DNAHU6MvC5Tc+hY4cncThrR/cnGxZUsfHiQOGGmRA8uR
 m4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777917322; x=1778522122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9UkPO56j0Qek9szbPKIs4NmRNBhasazroYlSkGGTxo=;
 b=DwZug0qrIsE+AugeWnMnhYvP/9ITU+qc1ctrJdqoRoeaNHr5EMHUXwx6j9RfLRpD4s
 cjN/ZgYQ1n6VyS+Fqb7ps5L1Z2woJ/BfmphnTYE3EYmnjWL646YBWmW3NjEYoZF7R0Ev
 0Y/Ktv/V0j7hqseIuhy70F4tXEJm1PXcjEySb1h1Yys1u+7eUfY3bsSHPVOUysIUQjqF
 nfNaEoGV02Zuvg9lpsGdL7am9iy4G0QP02xi4uPRznWlE8PjM+2j+zqJHJDv/+p2gN3t
 FPaNZwXqmSY1BaKIQbEHPsvXJpSCZyO/WNp17DTujJDAKM3s3x4evEa3iWdEhhZKC4Hr
 8oWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VZMGvjDb07GseqrdLfmQ0rXzY80nsgIEw1baRKrSRtY+qGHxVSzPHd6+tDjM4yhN0jf4E46M=@lists.denx.de
X-Gm-Message-State: AOJu0YyQlEhK2dZ30IR/bYv6iWD6x913zSkYXxaNfE1GTu4+kejMBgLS
 wWnV++/d9x5LYpvZE4AQkbvAtrXe3WhcnWLaUrDgHLfStSBosaZNEeLm/hAz7NvZBO0=
X-Gm-Gg: AeBDiesyvgpKiDP6m/JuluLq/1VemFIUuULbgMTG2sdSANSj/1EFq3E1QttgEOeF2LD
 Ld1wsrFIWvCzxdJuUX7RBx+dwY37Malem5beqR2zDqVaNrxbU79itNpo2/xF0VjTi5lCSqjk2EI
 ccYrWdmSZwjuQfaCGWiQSjHCQgHaMzQK2aDiwauscc6VRpTrFPeGv81HwxYLWkU2tPM3i+d6aeR
 mOSwPIuVyW66so6pBZ7YOgftgbXsjQLntotqdvpVvcRVRdzDo9lyLn0bUMRscQ8WDruEDTwvr8g
 Tr2L7dNF0eTJA9PrQ7GaEZd6ROBgaZFYsqEYw4pQtl4FI5/WFGjqoE3ON8xqSyUARnF9GxUMyjZ
 U+m/A+WvczUIpi3Cn86kuAJ1LxKpJrIR7Q8Vq8Be/7x9krjE76Tmfvhj5tDTA22+W/OJGYEc8Tj
 K2juglWlXJMxg+G+tzScCubgFFGBYn+6L1LH1a13a7LtEeF6dU6hA48PE1DvxuIW6Ha2nakwqF9
 VaRg9GtKZT1ik8=
X-Received: by 2002:a05:600c:c089:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a98676df6mr154881865e9.29.1777917322209; 
 Mon, 04 May 2026 10:55:22 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981defa6sm25406013f8f.24.2026.05.04.10.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:55:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] armv8: mmu: support unmapping regions with set_one_region()
Date: Mon,  4 May 2026 19:53:54 +0200
Message-ID: <20260504175511.585797-1-casey.connolly@linaro.org>
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
 arch/arm/cpu/armv8/cache_v8.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21f..b1a1fd571341 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
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
+		*pte &= ~PMD_ATTRMASK;
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

