Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE7CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536B384BFD;
	Thu,  7 May 2026 21:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cRHXTv1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A2D84BEE; Thu,  7 May 2026 21:58:29 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EA1684B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b150559bso9872575e9.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183906; x=1778788706; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xrmDk9XCkoDkcaZwxqSxP7vyriYdTHuacokEhK2S1DA=;
 b=cRHXTv1lkZACCKh8vPWKt4mV3TQXlKnM4dAwYO8ntzvLfHd3Fx9j3X3qkLQsBm/DPh
 YUiQHtI11+6Ge12aqCAw7PyuUF5Hwena0m3+a7RPrEpvYVX98yn8H8VmH7yCz+70u5yc
 cilC2EKYsy/PFhY8pFRjLdqxLeSEkFEnIXCa0R07szLYPH0FIrimQpAmLXhzUr+y7CiZ
 v4EURXu4ONYDxf/w/k20+oCR9/hu4dBKhu8gVMmNEu8QbljJ9hJtjtTUuz1H3ZF6Jong
 bHaflOlQUWqGTbVK+EcWA+Xzzz2bBZOFhgSbpRLGyaiHlGHa7/kaDYjYQLtDVJdXgTHt
 tqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183906; x=1778788706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xrmDk9XCkoDkcaZwxqSxP7vyriYdTHuacokEhK2S1DA=;
 b=WK0aySwblYVMjEtgKNMj+ZadxKblHyhwxHRUk/txoaYYheZF0R3lleryVXu9ar1Fyd
 dSg2fuzr/54mXFCw9VSmOoqeCbyBw4F5N58axmupNRcPZj+OiLslnYxwFnVxO/tkq/ji
 F/2uEgn7Wl1inf3PxF9i9b0ERYcd1AszjxvPMImaCCBjkGyoHWYX487hRaFLD/tGp6Ve
 bqe6ccAojNaQOqiplLxYtjDwn2I2RCSbFlx2tR+YCygcgYwP23Huvi9lOJnPVRVAza+5
 w/2wna+9UsqKAuvCQd2P+Cr3qcudf90XZZwu8jtFcjFxqEpA/dqTlWx370KHHKpWvur4
 ua3A==
X-Gm-Message-State: AOJu0YxNLjGgGZgxlfyjhswMxaQAfRyRrbUcVJorlMP9dmX6ulZyVazi
 7+6sEamF4HsDL5co+wHOYcmdALJVKmqchv6Z5XtucCWbMwt1e0DgcG/bD6jSnJdAFto=
X-Gm-Gg: AeBDieujRERpI3YAiuhBzBSgQ4f+qNWg608eci5aRaeOBbBwm96iPqFt3GGxB62QOq6
 Hkc4WA/Vj8icDlZOyHhjRY82MCIFx6ep1+ma6btsvnMMJjRBmio6vtASSucRzWSRG+VzmayksDT
 eIDPVNjj7r/Is9kHLT5TNxlCQnZDpl0dAPA/yyXQNQHBCWuhQdTCttB2rFEU5AHbGJ+T1Dwp1EX
 4qUFgDYYhO4PKVB8qC1IYwc6frXmjqTiau7wuTqjm7R6ujPisyWC0d4nBpkuUpw9g2LyCud+NOU
 GQ96P0LwrkgFos1cMQxQY+KHweT/qhv0R5dmuXB9A+PSIMpDy9A51tL4Bi3GXe+AG8MDwGygPjf
 XTehZ/LuTpQ+nchtSjPHYcVoubsyuXxjpQNyrVD8mjEZicppurJ7yl/8AAls2fbfQzNgeQmNr3h
 wOOLsTpc470S/HZne6fgSNBo4BCugcaPRiI4ToMSNMSSD0dUIauLFua2XOsDb5OBERYHdZ
X-Received: by 2002:a05:600c:8211:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-48e51e09680mr159048725e9.2.1778183906391; 
 Thu, 07 May 2026 12:58:26 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm235344265e9.15.2026.05.07.12.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:58:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 07 May 2026 21:58:11 +0200
Subject: [PATCH v3 4/4] armv8: mmu: fix and optimise explicitly unmapping
 regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-b4-mmu-unmap-fixes-v3-4-aac7726d87d5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4030;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=JyKcHG3CDm6TiD3xkCztln04+LiDUlSBDyQYtXKquSg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw/7+4cFTn31sfzvB3nNA5Jd//DB7VWOiXrSlhkT45r7
 vbbmPiqo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEqJGRYWPW3u13hc6UrV8z
 O5bb+N9CYa6lde09qfJT5zseFyx9/4Thf4Sc2/YJ2iuenPh9KvnBhBi2971CLcsE1h7/xVHU4Op
 wLxIA
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
index bd839b2addb4..c3dd1c24d18a 100644
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
@@ -1099,8 +1105,12 @@ void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
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

