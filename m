Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085ABC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18044807F1;
	Wed,  5 Feb 2025 14:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XPrmH5Mm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60CB80562; Wed,  5 Feb 2025 08:17:31 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C9780207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5dcd9158685so1590304a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739849; x=1739344649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JzVTlLx5zWD9AZTRQTbv7V6ZpWHVfksSKhcHYkEbP0=;
 b=XPrmH5MmOQvfp6OToiuihzTZRaWBpD71r4QGevk0dXP6/bACAsY0rtZ3NryCNQhWHF
 dxBW59CVzfTb+bIkrzKJON7pC5PunhUYY4PjdBncKE6Vqr4Ych5r/QvnqHRiMf2m69Yl
 webP8/t3s2HR+zw5TVeIRJtb3scPrJqI/DsBFyq6+DCnTGMgfrsDBc9VMG9+18XEiXE/
 tJJmc9QgfsJIQdXS+AP/3+QlrHYmDTevNUY/wQgT5Zw9HargymrNfrjcSJuDU3pw6uHB
 mXv1WZ0MiCvpmmysiIWVY2tpCiJ9od8TAclC7m1wowUVlfx4OsPc1D2a4I2+CGZpgDQQ
 jFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739849; x=1739344649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JzVTlLx5zWD9AZTRQTbv7V6ZpWHVfksSKhcHYkEbP0=;
 b=B9h4iuQJpNu/FtXjcxO3LcnrF2l6lO55W1cHU6YsZ7rZoawXE1idXtUYkxMn5KtFC4
 5rZ5kHa1epCFoJ3ODOr1ELvcy87xNoKJmD3nf+xy2UNFawYRqcZrQkNPNRj4+rewFUmH
 bCnOCt399nindYRbuc13VpAKflvSOGhAgjABfKY+OEaoPomJMT9NkS3hykoBaJYLlCGW
 Y23I51iNZ2nSiluiVMrGDKfnzF8Eao3g4FvoKC7wKmxuENjyVau8VNGekWYZo/FPDIPy
 hlE29LPXx1aMsvRd/O/Mi1gXRFbdVfWPlDxyMZ2PkZ7kwR2KOFNt3PIcfHGyJoBanlf/
 GqHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc/Kx5LAIN0lZhvQE8zfyvD6i/oBJ14z/3PzYN72vPtaVzvafeCVGjEQlKGHEvnD0/nwSMxyc=@lists.denx.de
X-Gm-Message-State: AOJu0YyX2c5gnChw+Q1MBHOLZn1wAlHgQw5G8iCHiJtQGmFrGPWSeg3/
 oDgAgaq+mfdurxsMQOh/grz8+VrVFspJMq8T29Onl+abFySTvGBSGAI5PQcGsis=
X-Gm-Gg: ASbGncvxja4fquKjJ6T6+QeF9hdurb1k4r7YkKZE75t5+J2JeUeRF/E70HXQ8Kbi6/0
 4p4FayEE0/DHjhmji7Jkkensx2Qu+lZqlAozJmC/oQESaYl7Y+gtE6IpaZXTsgTA/fM6HEhKDlM
 E1mFqcyBCrMdLh2BBMGkxx2g8n4P4iI2Wct8orTQBfLTEmKnxtfpj66FWZKzb8JJoM5GyQfhBwq
 NosPCNM7tWIRHwNzFQTc2D5O7GOihol0sOMp5f18UXfA8tbvAqoaNKULVqSRVaNkkbrx6UzcEQZ
 tos8DGF1gaLIeTOehPKurb1svlmWfadlmBKOWFVPdYyHu9sesVRK4WHTIVY3Pwr1UItI
X-Google-Smtp-Source: AGHT+IG9VDhtSncb/VyV/h/3hmmXecslII6a1gRmXI8LEix7bcvK01NglY0D7M4XT5D4Z2ujNVQ08g==
X-Received: by 2002:a05:6402:42c2:b0:5dc:db1e:ab4c with SMTP id
 4fb4d7f45d1cf-5dcdb755d2cmr1725906a12.16.1738739849127; 
 Tue, 04 Feb 2025 23:17:29 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:28 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 1/6] meminfo: add memory details for armv8
Date: Wed,  5 Feb 2025 09:16:45 +0200
Message-ID: <20250205071714.635518-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
 arch/arm/include/asm/armv8/mmu.h |  2 ++
 cmd/meminfo.c                    |  5 +++++
 3 files changed, 30 insertions(+), 3 deletions(-)

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
index 5e83d61c2dd3..3915e2bbb268 100644
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
@@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	puts("DRAM:  ");
 	print_size(gd->ram_size, "\n");
+	arch_dump_mem_attrs();
 
 	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
 		return 0;
-- 
2.47.2

