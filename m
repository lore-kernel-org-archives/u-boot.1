Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB1C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 20:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC1B884C7;
	Fri,  7 Jun 2024 22:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kk84Wt4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B27884BE; Fri,  7 Jun 2024 22:43:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6046884A4
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 22:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c60b13a56so843324a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717792977; x=1718397777; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RpXaHECFBRPu1AelIvGTfl9hHhS021JeTZxOEiELyvc=;
 b=Kk84Wt4sJx6rrRfMoKbrCsk9kDkAaWiOV/G2+jckSI6oSDkFitugdJUWBB/CTvG2xN
 oo7EY5xyARXaGpaU67Qfas54ZIv5AEiI35Iyfa57fMv0YHYdO5x4HNnGKvlfJySzKRux
 0NYd8RAzG/AQzTUPwjoaLr0JhuXVaBEfdg0ueWKSYfhYOqVJoFIWjHPFfIaKDRF/kSHx
 rB76XVSLWvWp6m6vXL+IlZnhwFaWPHGcH2OvruloL7EQgJNiVJF37Ag2zygOrf9qopiZ
 gQvnPamnLOauuYlzPFhS8BI4OV2m7vlUcEmthN8unHoFAfu7bHMEouAtOptK5rRNqMp3
 eFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717792977; x=1718397777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpXaHECFBRPu1AelIvGTfl9hHhS021JeTZxOEiELyvc=;
 b=UqLc/imrAsHqtOc4lfNW8EMNB35Yo0VhdErq3C32u9qJF4TGtQ7Ce/d6Dk55Usjm4D
 6o7o1Efy8iW9brlaw1KT+EiL7KYHy92ht/xEMZ/QMGH7f1+yLBwgDT14sMa6zlUZX25t
 azpSXKQNB8EqVQaE6uxDJE1K9zzdl2tFafJzvyyp0QWTwM0FpENfUUodyBM1M3SxSssq
 UOx/XV1/NSY3bmRc6qT3hangmT6S4nP0cNox1eXjnvqiJ7lh/pQ6WN7X5GiI/DGzisq2
 MCtsuJjg4gYzY151tZePyZwtBOp4v1pP1E4gzAkrsi+4c5YKPPdOMA2ZMTLIY8n3XawB
 8EoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDgh2AxOOw/Thq74h6GVY20IT0/5ceDCkhuIo06fS+gqG2rAjIc96TM22Cylw0OqcDkhWpZin6OU/6oXVBeCddDlLeQw==
X-Gm-Message-State: AOJu0YzR/3MGb1g0XsdOCUOyx3NBxu5L4ovMRsBdkT4VE1mqVPzkbVjU
 MnmRV9bN7jNwLBdFZZXm6LCSgfDkmbiR+ePy1IR6eQvf+Mq/wpkB1+T4wjlng58=
X-Google-Smtp-Source: AGHT+IEtZMhj/gPwRsuSFOww97B5PuCUzK2bro9A5tzsvzAfZwEMHrbLZvPd5hZfKL5eC3nb32EnHg==
X-Received: by 2002:a17:906:c9d4:b0:a6c:8b51:8001 with SMTP id
 a640c23a62f3a-a6cdb203f40mr237937666b.51.1717792977193; 
 Fri, 07 Jun 2024 13:42:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80588851sm300766966b.29.2024.06.07.13.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 13:42:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 07 Jun 2024 22:42:50 +0200
Subject: [PATCH v2 2/3] arm64: add software pagetable walker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-caleb-upstreaming-v2-2-bae407f51f22@linaro.org>
References: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
In-Reply-To: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9087;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SkLo01GnLf99xkOyC+KfMffyYAfbteyx6isBlld2MUc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmY3DN+U8qyf9PWk3bmbPzfy7sAyHXKBUg8UJyq
 WLTPQTdqSaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZmNwzQAKCRAFgzErGV9k
 tlVgD/oDclFfGFPrGQ4utPuzY7J6cOjb1xJeOwYdgo3aFHIN0E8xAXDQD5dPFd44TWequt5svwr
 hJVp5yHsYOcBRPwPLufWs0d7l/7jK8aqWl51eSmPhDU/3xNIenhq9jqIL2lVt9VxXKxHPx1DiIh
 PnQM+vKdmSfEB4wNzmKJDHx+MiEkXZOGc9fmRrB/+gCWvBO1TMMTQF1mS2XhPVJCqRWTXkzQo4s
 5FRljogU+4v6cyGVpcL5sqdOWx8wbnnNUAAmeQ6og4dW/COwUP9c6DkH8uBRUKm3+lbApY7SX6Z
 WXSubB7cX1TdE5cxpb+206Qq5WcuW8XC8+G5b4eU6yBvtiXL/bSNuKlfak+FxBA4TCt4iz246Tq
 BQ5pcr5tPGTGGzzxtMsLW6LA7q060sa2ulfoXnWQkSaYt6GP1kqgcaIGRCOAbKoveBkfWt62A7t
 fAEp/JrSWzak1MlxgiZA0LI+fvjo/DlHSwmMWx5KFKNEFvnLZdaAv8GHLotIAI8166qrZlnUGW2
 YXplpJNvVElaRqj2CQDaEfSu4QKiUNB/QVdRMZppn2AK5fGEZqKzioI0CsbtsW6a69+hTqVEnkc
 ft64ysGNAtCuYXot7iVZpyarW/1ObkRlFeyymEgjmutVVWr3Awxg2cmZR008TwUsy/javB8sicN
 znOn3uHkrBgzKAw==
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

