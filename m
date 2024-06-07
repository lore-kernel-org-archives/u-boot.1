Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E7C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 16:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BDD8844B;
	Fri,  7 Jun 2024 18:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwUSDjUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD6C88422; Fri,  7 Jun 2024 18:51:38 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25ADA87F6F
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 18:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a68b54577aaso307524166b.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717779095; x=1718383895; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2nKwREbyBXmZFyQe8QoOBjCPftfcSOeh5MbTwZFQCM8=;
 b=mwUSDjUWPW5lrrqskfTxjOYj9xpb6gUYFoelL9T/9vQmlxWqy3N4GhoDl2ntKQUPAA
 Dfk+xmoGQRS2j0fggBM6sFW7tKyumlnALK3dRg2AQb41O1rMf0AtEfYudXw5bdgUfNHO
 eStgBKie18MYZ+4elnFycZiQ7Tcw+PNLa6D7AevIZPpVPp6pI7sJWH+39q9ic74KevVp
 4uUKZk2F6p8p6fz1V2YLqi+Xh59rG0892Gyk8is10fNJhXwpK++v3cwTZn15S75HW1lh
 bopAG74DR7hCst4SHFUK58pIh41h2FflpqKerrGSB8j2NRXMMEY2jIyQkzbLUcuupABh
 ZO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779095; x=1718383895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nKwREbyBXmZFyQe8QoOBjCPftfcSOeh5MbTwZFQCM8=;
 b=JW3qHkUWzLYpR2JOG3p5+9q8DFHiEpLpZLxwhC79Nety9Vqa7/tnWXHjmTUfsCi9B3
 ABoup5Kz3FBDQMZdPsPwN3AIyqcBAfMfKsbmI51L5tUwhYoWYqmouY/NZi83l4HiaYVf
 IWYnziHv+Ih8VhJ5w2K0BgyP32oliBphTT9POmVmOGy+1DzIkLmFs6nCd3/fbCQ9T5g7
 BFV9tKTYYZ62wXMXcYRv7JgJCy7XqpAgtxdeCQTS/HpiMz8Z2Bv/nRN5Ctzj7JU2cxwl
 jTf6frwvSkGcbgR7xrLBdeQLsuiFVMb/HAL7wkVMZV5hiAgRQa8uno38x6+PTdQjwlyz
 RdOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM2AvSbilWtGwHgFkETyeo2rqKJChba4uvq4yZcX8BlyiqbenkunpqmrsouDNzxU1wcAKrAHabCS3Up0QVuE3VM2VjXA==
X-Gm-Message-State: AOJu0YzZMySyMP3uRiT24QT6f45Eqn+oXpx3x6cs5mtwK6gbS44y8T9o
 WsPKWKPuCVxPhmHOdv3Nj6M03aAZu79rSTJDL7oVleZt3OPSVVAI778GYYUn8+aMW+SQZ/TCG/9
 9AJ8cxJEz
X-Google-Smtp-Source: AGHT+IGUzqJ1OvCq2mXM06Qw83KaWs1Bsqu4wKWAsc/X3n398/ftpls4zsYDx4+yUAJswG2zQUxLFQ==
X-Received: by 2002:a17:906:6a29:b0:a6e:a97c:fc97 with SMTP id
 a640c23a62f3a-a6ea97cfd15mr137562766b.7.1717779095527; 
 Fri, 07 Jun 2024 09:51:35 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581c05sm266720466b.7.2024.06.07.09.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 09:51:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 07 Jun 2024 18:51:20 +0200
Subject: [PATCH 2/2] arm64: add software pagetable walker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-caleb-upstreaming-v1-2-99094dabb3d9@linaro.org>
References: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
In-Reply-To: <20240607-caleb-upstreaming-v1-0-99094dabb3d9@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8966;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VhmUJx8jpOwiK3MIq8pjOiqf8F8oM/ZHnD/DDRA60P0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmYzqUdnX1eGXoI/0zdRP39pp4GRj/nwRAVI8F7
 CXyO+VGPQmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmM6lAAKCRAFgzErGV9k
 tnYqD/sF8Sy5aNQJkDBl6f5Xaen1pJJFCZgQ6pTmpHCMqnInQEuvSLxLOcQyOsNALVu/uirT+t6
 +NwryRDCwpPHJsOVZF95ufXTQrOwhtf8jBGCNeaKtVsowHC4ejm6BIP9aT4J+/UF4t5QuP37Z6y
 rH6NM0VkA6MmCXMlwqnBb1Q+FOUZObaBDY9po2RzU+0iBm/oS3N6b0Uuibmm5QiJR52KNeXj9dx
 knhyXmCNhPw7Spj5OAqFR778HWXwYK7CJ27xAQj9AS8Bd8y5tD5itofP2ram+HfCldatdes8iX7
 92H7xYtcxeK63ps8pgrPywOY9tsu9D5Ix7TSiihlGKK12iYoKZGJXV6mk5kaS66gSzvBcj9c0XG
 gfVnNNipe6Qq77YhGd4Mrz+RY8AoYMW110N4yd3AFbc6PnQy4k21+ADRqOXQP/K3JZO57Ir4BMO
 mltwT2zimk6Oq+etkpNDrRgW24Uho+qeBI1MXjv4sldNQ3Lyd7xgcWHkhyCYkC8WteCO7icLzSZ
 CwpxJDrkPCAM/YnFdh3jKuSoLbu0oFyegqvogJqZO0QH2ruLwgJu0JldmljE0xSQBRpUbjsPWrN
 rmmgIxWFZWiN0yr66mmNhsk6b58XMAV2zTxh20Q3lyJ4RnNUCaY+Onahu6pO3/CwM+kpMjcRjf8
 N1v8N0f9A8eCKFA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 202 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  55 +++++++++++
 2 files changed, 257 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index d4c64f2d60d9..cb7c0e61ba70 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -395,8 +395,210 @@ static int count_ranges(void)
 
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
index 52cb18b9ed5e..eed121784247 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -128,8 +128,63 @@ static inline void set_ttbr_tcr_mair(int el, u64 table, u64 tcr, u64 attr)
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
+ * walk_pagetable() - Walk the pagetable at ttbr and call cb for each region
+ *
+ * @ttbr: Address of the pagetable to dump
+ * @tcr: TCR value to use
+ * @cb: Callback function to call for each entry
+ * @priv: Private data for the callback
+ */
+void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
+
+/**
+ * dump_pagetable() - Dump the pagetable at ttbr by printing each region
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

