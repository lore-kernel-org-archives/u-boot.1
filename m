Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3279C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C2C87CDA;
	Mon, 17 Jun 2024 10:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="spLZQw3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6D0882BB; Mon, 17 Jun 2024 10:03:58 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A444878ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57c7ec8f1fcso4658414a12.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718611436; x=1719216236; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KeWLLc1x+3A5e5lAV/5VfRTg3STaj+HfrLlU0fBCHSA=;
 b=spLZQw3EMmFQ8N46XtEWKfjwT4HO1meo+PycQbk3oE1e+Ds8d6IdhKhpZXC1i4UbNV
 9N/45h3BArgHulKON2HLV1rLcUK4OISGApRNDAlwudFxh7MyPuzKO53ctn6nRwBEU0EX
 FW/fZ088HP1QU2weWgcXmpDm5jEJxI6B0a7nsJpAx7y1/sK2M2IgRvxEtQBOPK4mBcDV
 2mb9wkUiZ3n48F6JTLCyXxjLAmUhFcHEWZ80/mpg2hRDxhNEWXcq7rwTrlKYkfa8JSnS
 uLfffRspo79iMv4PzjjwaDTN5/qY5KqcYH+xOMOjEP0neiAH4YzRdXxd23MCTVPS4h60
 gMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718611436; x=1719216236;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeWLLc1x+3A5e5lAV/5VfRTg3STaj+HfrLlU0fBCHSA=;
 b=uuNjLrGV4hPNUijHVPFIvlMiTlMBlpWAQ2lfLb/get9pQZA+VX2xO0+sEIt2zDcwqv
 1alSRM2D8J9Shk4g6kdSY+Shz4+OmvZZ09IloyAxhB9rPvZBGhW8bz5VtqCpDXFK9Td3
 ET7/eX4yfaws+VQBG2xTHvIQrZo2ZUQ/dbsq92EdQGFyvJiBi9lmMNjXNhz+ijO7pgct
 MizMetcx3+xWDTnOMEIHMotFbJS54Y4lTaPGzSvfMZ0QjxLM0LPPgjVXgtOIoR/WPZgr
 W2lS3DZ1At7BB9Uy8Fu9h/BWEJw1dM0Jca0IWnL0LmDevW0UkNi137f9d5JpUyTnSgEI
 SU3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn7gvMyq0Co4KN/+29DicLF/D0WWsY1JfgNpwDSm8PuS0xpqhgJnYhtQirBrubcGlT2IverDM+slCgPLW2hgsbNcshwg==
X-Gm-Message-State: AOJu0Yw7Fyi69mI0FY73Hp+rC5kaOXAuhr4kJdP0I7jGw3SBWtySkNrD
 W4VjDKnTI14GUdddGq2g8mkzQC2CgRbTAiUKi5iYdYUPHzuE4u4V9e4RPmcfcLs=
X-Google-Smtp-Source: AGHT+IFo0vESJXBaMcAhgzkspvY8vvUvklnng51f60wDbRkyw/TR5NbQ8O3nazUAxvO+0EZ82+vn9w==
X-Received: by 2002:a17:906:b282:b0:a6f:1e06:29e4 with SMTP id
 a640c23a62f3a-a6f60dc5174mr591378666b.57.1718611435502; 
 Mon, 17 Jun 2024 01:03:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd79sm493224966b.132.2024.06.17.01.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:03:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Jun 2024 10:03:48 +0200
Subject: [PATCH v3 2/3] arm64: add software pagetable walker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-caleb-upstreaming-v3-2-1ba35dc9179d@linaro.org>
References: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
In-Reply-To: <20240617-caleb-upstreaming-v3-0-1ba35dc9179d@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11491;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=42VHFcS6Bo61/InwrQtlMub/WtmjG2o/q3Ic+kNvU1A=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb+3oOqDyQwEL4fXeB7xPx+mGdyj/QDskGKB19
 pl4WonL4QGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/t6AAKCRAFgzErGV9k
 tpn3D/97F5muOVjquYX3N2+qLdjCF7Pa1K6cS0WCjFQXTqRYJUgdzspEXtcypGrzwVlTCVnJx+4
 ePxarYyPaIowLfJyN7Thu8hRYtuokCVxxsAtcrWpx7+ospLh4rTZuM4EYMzbnWAFh7CrkgY0WV+
 E0d4tM39xjLHpd9Rk8Ybuq606dWF71fJu6gGxHGwkMAJ0FzVOGOZv2rty6tt0aE/sa3uFwZKL/m
 J1X9Yhafc1qBQJ9bcaJK+xmTnqlngYdQasZG/Zs+P0DUS3IxwKAnhIjoQLaAYhl0xIeV5tjQixR
 WUvNsMWrHzsPiww5Cwn2tQGfQeyPYYDKLJ+0DRKs6RxUsHj+QNAwnM8E9X+FyAnouUua+aGywaZ
 ecTAQu+g3JxyRd/pHQlCYMcgJil6Yp6Ufd6hEQCJsNCc1DggSgGn/RPE2iZkgNKQ0EXto6YAGU9
 liHSK2P0i+bcKIHhnKrnI2pdVsFho4CemSBYyu7iyJSHcQc8OaXWsKNHSVv8SdcIj0yAtmKLfXS
 cw41G/vrXC0VlEQ3Ac48L0spbO+fUa2jNDpk8+W+A7VKgF55hFkumFzE8ZkG+zD7QdAaZPSY7iU
 2Ft0ewxqp7edNA1S/qHMAmemTBszdLC4b6fua2JWcDqgRcdSKE4m0bC5BvlzaabiQvr+HycKBoM
 pqGVUpJuaDbsYqw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Add a basic software implementation of the ARM64 pagetable walker. This
can be used for debugging U-Boot's pagetable, as well as dumping the
pagetable from the previous bootloader stage if it used one (by reading
out the ttbr address).

One can either call dump_pagetable() to print the pagetable to the
console with the default formatter, or implement their own pagetable
handler using walke_pagetable() with a custom pte_walker_cb_t callback.

All of the added code is discarded when unused, hence there is no need
to add an additional Kconfig option for this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 245 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  56 +++++++++
 2 files changed, 301 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index d4c64f2d60d9..c3f8dac648ba 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -395,8 +395,253 @@ static int count_ranges(void)
 
 	return count;
 }
 
+#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
+#define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
+
+enum walker_state {
+	WALKER_STATE_START = 0,
+	WALKER_STATE_TABLE,
+	WALKER_STATE_REGION, /* block or page, depending on level */
+};
+
+
+/**
+ * __pagetable_walk() - Walk through the pagetable and call cb() for each memory region
+ *
+ * This is a software implementation of the ARMv8-A MMU translation table walk. As per
+ * section D5.4 of the ARMv8-A Architecture Reference Manual. It recursively walks the
+ * 4 or 3 levels of the page table and calls the callback function for each discrete
+ * region of memory (that being the discovery of a new table, a collection of blocks
+ * with the same attributes, or of pages with the same attributes).
+ *
+ * U-Boot picks the smallest number of virtual address (VA) bits that it can based on the
+ * memory map configured by the board. If this is less than 39 then the MMU will only use
+ * 3 levels of translation instead of 3 - skipping level 0.
+ *
+ * Each level has 512 entries of 64-bits each. Each entry includes attribute bits and
+ * an address. When the attribute bits indicate a table, the address is the physical
+ * address of the table, so we can recursively call _pagetable_walk() on it (after calling
+ * @cb). If instead they indicate a block or page, we record the start address and attributes
+ * and continue walking until we find a region with different attributes, or the end of the
+ * table, in either case we call @cb with the start and end address of the region.
+ *
+ * This approach can be used to fully emulate the MMU's translation table walk, as per
+ * Figure D5-25 of the ARMv8-A Architecture Reference Manual.
+ *
+ * @addr:		The address of the table to walk
+ * @tcr:		The TCR register value
+ * @level:		The current level of the table
+ * @cb:			The callback function to call for each region
+ * @priv:		Private data to pass to the callback function
+ */
+static void __pagetable_walk(u64 addr, u64 tcr, int level, pte_walker_cb_t cb, void *priv)
+{
+	u64 *table = (u64 *)addr;
+	u64 attrs, last_attrs = 0, last_addr = 0, entry_start = 0;
+	int i;
+	u64 va_bits = 64 - (tcr & (BIT(6) - 1));
+	static enum walker_state state[4] = { 0 };
+	static bool exit;
+
+	if (!level) {
+		exit = false;
+		if (va_bits < 39)
+			level = 1;
+	}
+
+	state[level] = WALKER_STATE_START;
+
+	/* Walk through the table entries */
+	for (i = 0; i < MAX_PTE_ENTRIES; i++) {
+		u64 pte = table[i];
+		u64 _addr = pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
+
+		if (exit)
+			return;
+
+		if (pte_type(&pte) == PTE_TYPE_FAULT)
+			continue;
+
+		attrs = pte & ALL_ATTRS;
+		/* If we're currently inside a block or set of pages */
+		if (state[level] > WALKER_STATE_START && state[level] != WALKER_STATE_TABLE) {
+			/*
+			 * Continue walking if this entry has the same attributes as the last and
+			 * is one page/block away -- it's a contiguous region.
+			 */
+			if (attrs == last_attrs && _addr == last_addr + (1 << level2shift(level))) {
+				last_attrs = attrs;
+				last_addr = _addr;
+				continue;
+			} else {
+				/* We either hit a table or a new region */
+				exit = cb(entry_start, last_addr + (1 << level2shift(level)),
+					  va_bits, level, priv);
+				if (exit)
+					return;
+				state[level] = WALKER_STATE_START;
+			}
+		}
+		last_attrs = attrs;
+		last_addr = _addr;
+
+		if (PTE_IS_TABLE(pte, level)) {
+			/* After the end of the table might be corrupted data */
+			if (!_addr || (pte & 0xfff) > 0x3ff)
+				return;
+			state[level] = WALKER_STATE_TABLE;
+			/* Signify the start of a table */
+			exit = cb(pte, 0, va_bits, level, priv);
+			if (exit)
+				return;
+
+			/* Go down a level */
+			__pagetable_walk(_addr, tcr, level + 1, cb, priv);
+			state[level] = WALKER_STATE_START;
+		} else if (pte_type(&pte) == PTE_TYPE_BLOCK || pte_type(&pte) == PTE_TYPE_PAGE) {
+			/* We foud a block or page, start walking */
+			entry_start = pte;
+			state[level] = WALKER_STATE_REGION;
+		}
+	}
+
+	if (state[level] > WALKER_STATE_START)
+		exit = cb(entry_start, last_addr + (1 << level2shift(level)), va_bits, level, priv);
+}
+
+static void pretty_print_pte_type(u64 pte)
+{
+	switch (pte_type(&pte)) {
+	case PTE_TYPE_FAULT:
+		printf(" %-5s", "Fault");
+		break;
+	case PTE_TYPE_BLOCK:
+		printf(" %-5s", "Block");
+		break;
+	case PTE_TYPE_PAGE:
+		printf(" %-5s", "Pages");
+		break;
+	default:
+		printf(" %-5s", "Unk");
+	}
+}
+
+static void pretty_print_table_attrs(u64 pte)
+{
+	int ap = (pte & PTE_TABLE_AP) >> 61;
+
+	printf(" | %2s %10s",
+	       (ap & 2) ? "RO" : "",
+	       (ap & 1) ? "!EL0" : "");
+	printf(" | %3s %2s %2s",
+	       (pte & PTE_TABLE_PXN) ? "PXN" : "",
+	       (pte & PTE_TABLE_XN) ? "XN" : "",
+	       (pte & PTE_TABLE_NS) ? "NS" : "");
+}
+
+static void pretty_print_block_attrs(u64 pte)
+{
+	u64 attrs = pte & PMD_ATTRINDX_MASK;
+
+	switch (attrs) {
+	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
+		printf(" | %-13s", "Device-nGnRnE");
+		break;
+	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE):
+		printf(" | %-13s", "Device-nGnRE");
+		break;
+	case PTE_BLOCK_MEMTYPE(MT_DEVICE_GRE):
+		printf(" | %-13s", "Device-GRE");
+		break;
+	case PTE_BLOCK_MEMTYPE(MT_NORMAL_NC):
+		printf(" | %-13s", "Normal-NC");
+		break;
+	case PTE_BLOCK_MEMTYPE(MT_NORMAL):
+		printf(" | %-13s", "Normal");
+		break;
+	default:
+		printf(" | %-13s", "Unknown");
+	}
+}
+
+static void pretty_print_block_memtype(u64 pte)
+{
+	u64 share = pte & (3 << 8);
+
+	switch (share) {
+	case PTE_BLOCK_NON_SHARE:
+		printf(" | %-16s", "Non-shareable");
+		break;
+	case PTE_BLOCK_OUTER_SHARE:
+		printf(" | %-16s", "Outer-shareable");
+		break;
+	case PTE_BLOCK_INNER_SHARE:
+		printf(" | %-16s", "Inner-shareable");
+		break;
+	default:
+		printf(" | %-16s", "Unknown");
+	}
+}
+
+static void print_pte(u64 pte, int level)
+{
+	if (PTE_IS_TABLE(pte, level)) {
+		printf(" %-5s", "Table");
+		pretty_print_table_attrs(pte);
+	} else {
+		pretty_print_pte_type(pte);
+		pretty_print_block_attrs(pte);
+		pretty_print_block_memtype(pte);
+	}
+	printf("\n");
+}
+
+/**
+ * pagetable_print_entry() - Callback function to print a single pagetable region
+ *
+ * This is the default callback used by @dump_pagetable(). It does some basic pretty
+ * printing (see example in the U-Boot arm64 documentation). It can be replaced by
+ * a custom callback function if more detailed information is needed.
+ *
+ * @start_attrs:	The start address and attributes of the region (or table address)
+ * @end:		The end address of the region (or 0 if it's a table)
+ * @va_bits:		The number of bits used for the virtual address
+ * @level:		The level of the region
+ * @priv:		Private data for the callback (unused)
+ */
+static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int level, void *priv)
+{
+	u64 _addr = start_attrs & GENMASK_ULL(va_bits, PAGE_SHIFT);
+	int indent = va_bits < 39 ? level - 1 : level;
+
+	printf("%*s", indent * 2, "");
+	if (PTE_IS_TABLE(start_attrs, level))
+		printf("[%#011llx]%14s", _addr, "");
+	else
+		printf("[%#011llx - %#011llx]", _addr, end);
+
+	printf("%*s | ", (3 - level) * 2, "");
+	print_pte(start_attrs, level);
+
+	return false;
+}
+
+void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv)
+{
+	__pagetable_walk(ttbr, tcr, 0, cb, priv);
+}
+
+void dump_pagetable(u64 ttbr, u64 tcr)
+{
+	u64 va_bits = 64 - (tcr & (BIT(6) - 1));
+
+	printf("Walking pagetable at %p, va_bits: %lld. Using %d levels\n", (void *)ttbr,
+	       va_bits, va_bits < 39 ? 3 : 4);
+	walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
+}
+
 /* Returns the estimated required size of all page tables */
 __weak u64 get_page_table_size(void)
 {
 	u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 52cb18b9ed5e..1348db4204ee 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -128,8 +128,64 @@ static inline void set_ttbr_tcr_mair(int el, u64 table, u64 tcr, u64 attr)
 	}
 	asm volatile("isb");
 }
 
+static inline void get_ttbr_tcr_mair(int el, u64 *table, u64 *tcr, u64 *attr)
+{
+	if (el == 1) {
+		asm volatile("mrs %0, ttbr0_el1" : "=r" (*table));
+		asm volatile("mrs %0, tcr_el1" : "=r" (*tcr));
+		asm volatile("mrs %0, mair_el1" : "=r" (*attr));
+	} else if (el == 2) {
+		asm volatile("mrs %0, ttbr0_el2" : "=r" (*table));
+		asm volatile("mrs %0, tcr_el2" : "=r" (*tcr));
+		asm volatile("mrs %0, mair_el2" : "=r" (*attr));
+	} else if (el == 3) {
+		asm volatile("mrs %0, ttbr0_el3" : "=r" (*table));
+		asm volatile("mrs %0, tcr_el3" : "=r" (*tcr));
+		asm volatile("mrs %0, mair_el3" : "=r" (*attr));
+	} else {
+		hang();
+	}
+}
+
+/**
+ * pte_walker_cb_t - callback function for walk_pagetable.
+ *
+ * This function is called when the walker finds a table entry
+ * or after parsing a block or pages. For a table the @end address
+ * is 0, and @addr is the address of the table. Otherwise, they
+ * are the start and end physical addresses of the block or page.
+ *
+ * @addr: PTE start address (PA), or address of table. Includes attributes.
+ * @end: End address of the region (or 0 for a table)
+ * @va_bits: Number of bits in the virtual address
+ * @level: Table level
+ * @priv: Private data for the callback
+ *
+ * Return: true to stop walking, false to continue
+ */
+typedef bool (*pte_walker_cb_t)(u64 addr, u64 end, int va_bits, int level, void *priv);
+
+/**
+ * walk_pagetable() - Walk the pagetable at ttbr and call @cb for each region
+ *
+ * @ttbr: Address of the pagetable to dump
+ * @tcr: TCR value to use
+ * @cb: Callback function to call for each entry
+ * @priv: Private data for the callback
+ */
+void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
+
+/**
+ * dump_pagetable() - Dump the pagetable at ttbr, printing each region and
+ * level.
+ *
+ * @ttbr: Address of the pagetable to dump
+ * @tcr: TCR value to use
+ */
+void dump_pagetable(u64 ttbr, u64 tcr);
+
 struct mm_region {
 	u64 virt;
 	u64 phys;
 	u64 size;

-- 
2.45.0

