Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2845C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE4181101;
	Thu, 27 Feb 2025 13:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wT39py/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63317801FB; Thu, 27 Feb 2025 13:15:36 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 463A280FF4
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abee54ae370so126055266b.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658534; x=1741263334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=wT39py/t+/uNs8VFo59cpc2OHimfNTxSnYR+M8KD3bP89VyBp+qolZLzPPumWlAkxI
 c0ZFg/gURq0APO3j8O1aXE+qoWtCOxdq5EsAdAvxsKIkJr4mzQ5GpUiqE/ckAILDlbVc
 4OIL8WXm3yiZ36/4d2IYo/IoIdbFWwwfznyuvaZxrKWfOlKTkTir8UflYxU9or8G2V7+
 ZO3Epyt3oa90fzeSLo/tyz+8pPmxHBqIA6CyeGIiF8xb04IvNtDYaxugcmG4d3BnMYsg
 SfSmBEP5F3M3X6dLb4kIueq5vwL+MEutuaAHToSVN9QudR09t1svyErXeKiRpYj4Xyrc
 xSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658534; x=1741263334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=Cg4USRkIxfWNM5axM8H7wdY1CLBy8kjn3vWjrwDbkhmQmzMBSWKDKRm9a8Asp0nggV
 FJ8RocK+tiqQy0AqXbboOfQLNNyC5JQnfhUq40Ykik/SxIq0N4lm25+Vvad2X6PLbAcm
 w7G4Vzo8XzMtQJOfMoUPhLbU4/6yKeL+Yj7CM2r0xsav7r5ncjKBO9pSti02LJXtM24C
 1txPcf41XBGBGsQT6ajS2DsWdw81gLPcsEMdB3LOGqnYm+aAXHIOjzKogS73nNt7i+Zl
 Q1dqlER5XQEj29ffWJBmiNQ7iIoQsgAX+FgHnovqwM8aOLetm3UfvSL3JYXg6rU7v7Tt
 WKpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtpvkZF659wNXv/Rda6GGtwEkg825KvjLotuDrnRDJ9AuixeFb1e+2GnAtMDhWgK/JTaeWtec=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8Ac6XJFdsvAVs6tg8p60/2GK6m1QI466Fewk7R51O6dbHQ0Zu
 UMVjEAobXd1Hn51nff5YjwDzPVFTPzoHFrL33A3lXexFLgCQiT4j1qY6ZK8iGf4=
X-Gm-Gg: ASbGncvdl/ymhvLtKjMX6OZIznqigBmC842KXWaYypqUooPLsbdQoYOnD2UPILFtR99
 0yaDCicBkDLM3BM0r5J/Bp/i3MRUbioetp+gL+RcN5MT+3hCsMGLjjpecDxdpF+YbjabNy2LNbj
 1Iu759N9sRnWlp/koIQnUnSFNyBr+OOJK2N8x0Xo0P2oY91U0xNzveiWQIfxhLQBOumSktpHiRK
 tN8gYUbaYlUu6VxmM2lX3bJdo9LSwjnabLEHwha3hWyRbSLqMhO69vmvLg/a4Q/8hZ7Kfr4DWIF
 RpBs+FwChUK4slGlmYyyGO8MwDPEzQYWLISfOzYxfigxnymEZCSEVSjrnAQV0oOoEeI19f4RAuN
 CTr0+
X-Google-Smtp-Source: AGHT+IF8/dhy3AXUgBrd/LHDsgVzfIukJCQcgzCvsIxjXHjxrI8XlVxptFm32gzpqrFsNBAWECfNHw==
X-Received: by 2002:a17:906:1daa:b0:abe:ebe2:6748 with SMTP id
 a640c23a62f3a-abeeef649f8mr830652766b.38.1740658533599; 
 Thu, 27 Feb 2025 04:15:33 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:15:33 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 1/6] meminfo: add memory details for armv8
Date: Thu, 27 Feb 2025 14:14:51 +0200
Message-ID: <20250227121515.232996-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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

Upcoming patches are mapping memory with RO, RW^X etc permsissions.
Fix the meminfo command to display them properly

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
 arch/arm/include/asm/armv8/mmu.h |  2 ++
 cmd/meminfo.c                    |  6 ++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 5d6953ffedd1..c4b3da4a8da7 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -421,7 +421,7 @@ static int count_ranges(void)
 	return count;
 }
 
-#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
+#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
 #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
 
 enum walker_state {
@@ -568,6 +568,20 @@ static void pretty_print_table_attrs(u64 pte)
 static void pretty_print_block_attrs(u64 pte)
 {
 	u64 attrs = pte & PMD_ATTRINDX_MASK;
+	u64 perm_attrs = pte & PMD_ATTRMASK;
+	char mem_attrs[16] = { 0 };
+	int cnt = 0;
+
+	if (perm_attrs & PTE_BLOCK_PXN)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "PXN ");
+	if (perm_attrs & PTE_BLOCK_UXN)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
+	if (perm_attrs & PTE_BLOCK_RO)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "RO");
+	if (!mem_attrs[0])
+		snprintf(mem_attrs, sizeof(mem_attrs), "RWX ");
+
+	printf(" | %-10s", mem_attrs);
 
 	switch (attrs) {
 	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
@@ -613,6 +627,7 @@ static void print_pte(u64 pte, int level)
 {
 	if (PTE_IS_TABLE(pte, level)) {
 		printf(" %-5s", "Table");
+		printf(" %-12s", "|");
 		pretty_print_table_attrs(pte);
 	} else {
 		pretty_print_pte_type(pte);
@@ -642,9 +657,9 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
 
 	printf("%*s", indent * 2, "");
 	if (PTE_IS_TABLE(start_attrs, level))
-		printf("[%#011llx]%14s", _addr, "");
+		printf("[%#016llx]%19s", _addr, "");
 	else
-		printf("[%#011llx - %#011llx]", _addr, end);
+		printf("[%#016llx - %#016llx]", _addr, end);
 
 	printf("%*s | ", (3 - level) * 2, "");
 	print_pte(start_attrs, level);
@@ -1112,3 +1127,8 @@ void __weak enable_caches(void)
 	icache_enable();
 	dcache_enable();
 }
+
+void arch_dump_mem_attrs(void)
+{
+	dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
+}
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 0ab681c893d3..6af8cd111a44 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -66,6 +66,7 @@
 #define PTE_BLOCK_NG		(1 << 11)
 #define PTE_BLOCK_PXN		(UL(1) << 53)
 #define PTE_BLOCK_UXN		(UL(1) << 54)
+#define PTE_BLOCK_RO            (UL(1) << 7)
 
 /*
  * AttrIndx[2:0]
@@ -75,6 +76,7 @@
 #define PMD_ATTRMASK		(PTE_BLOCK_PXN		| \
 				 PTE_BLOCK_UXN		| \
 				 PMD_ATTRINDX_MASK	| \
+				 PTE_BLOCK_RO		| \
 				 PTE_TYPE_VALID)
 
 /*
diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 5e83d61c2dd3..acdb38dcba02 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -15,6 +15,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+void __weak arch_dump_mem_attrs(void)
+{
+}
+
 static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
 {
 	ulong end = base + size;
@@ -58,6 +62,8 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
 		return 0;
 
+	arch_dump_mem_attrs();
+
 	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
 	       "Gap");
 	printf("------------------------------------------------\n");
-- 
2.47.2

