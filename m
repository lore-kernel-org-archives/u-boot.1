Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EAAC282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6285281111;
	Sun,  2 Mar 2025 13:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t9Nu2faG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D0F810F6; Sat,  1 Mar 2025 17:49:52 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E4C810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e51e3274f1so1068714a12.0
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847789; x=1741452589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=t9Nu2faGRB5/EG7/2EgAp2ENdruQWPvTn1nO6fbBr9LqAmkjCKv0KJZRQSUcqI1Nsn
 cxpYkWvg/kQ/0kJBlVaoTL4f442eVFK5CyojixotNF+ZB+JRVb6p0QErq3p06N/xmDLK
 QKs7AcN86sCIxd0IBawsc53IFL69TNtFLGlSX+Dfd/vIedo6CB9Vr7b/E3+HxaYPaGos
 U6TSYR0K2aHnYPrSgT6YUy8cfCEVZruqW0ybBLOl37kSFouuX+yXQo+/QGFlEcZA1cQN
 4mCnSNBEQCe/2E6bcrBmDNv4WdWPMHesq/hp/6HfPSGdKcS8PoGanAOIvTy1dwGFSwLS
 h+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847789; x=1741452589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=aRc10GnOHyYmE9MGCUPTO4zUdpzpXZB61qcM4USDnpSPqwI1KSYCccIIKW/fMuhMSf
 vVZSRX/iMRfYxEaRic6q4P3dj3SRf+2kK4+H/JQgFtuuAHKye7c5SzAJOZ4KRvR9in4b
 JgvkZ1FBJOSGThO3gbyK1KFv3p/BbQAPpaqxMKOl/aOK1EevqMw1HRadPJOKZdujTqTf
 6rdf6OcqEFmhNxetGxl5ziUeTCS2j2FZE2lvfLKVdOYk/RQUWwiOPmHa7UOnKEQFyNqw
 IAKE6fbupppfV3N1tvcSBm4vhmE7LXBygLnY+lXhrcdrC2m6bkSCkaRm3vIuZfPHe653
 KIzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf8a7vnfUudDp/j0BSjZ26d2v0NcYxT1/eD7FAyUklrQR3WrKKG2YcgiH3kb9OHxW526S1xRw=@lists.denx.de
X-Gm-Message-State: AOJu0YxvyA9V5F6dvSgknddbdNZJ2rutje1lg7w44FHv6+P5oyxAdYC3
 xcgKI4aWxhn0pTLlZPLYGnRZKMcwqQ6Shk5Ud1kBev3TOwu8WY+sm2PMzo5Mvgw=
X-Gm-Gg: ASbGncvZ9DEUQWk2D5tDyTM3BfmV7Qz6/MkgdMwZfU6jauD2gVeEwwe+TNWBp2BWmcd
 YqFfgh/gzV6QdvUfJ7gXyZgT3yusecD0oW0RQewp6w2oYokxBpdsrwk/pseexT4vPq/AmQXddQQ
 VF92YtVpy0so0EE38PqRRTCaB/wOQaZLcLB27YR081+V8UCIBd3t+r2XYPQ3POsCOx5GKBDPTFo
 TKfb8VezCZ95+p1W+00TfvGpnK7knXs5VP/E3XeqLg2yU0R6A1Crk9zbEHnsXRxCMr3Pz+47dyS
 JBgniU/qc9NFB+jRHoUqywJueZTP9w03HhSTlbLBftZ5G61dNxyny2xtZXgwQ/TVrrfDZj3CnPc
 RJqxHO9b4FG2sVbTlpwVpmC0=
X-Google-Smtp-Source: AGHT+IGIad8dS+TMhpnzebc1u80/oQZvc1xv993yHsoIrJzGKIq+j5+nMYQQdE3H/d07tY0higRv9w==
X-Received: by 2002:a05:6402:2350:b0:5e0:8c55:536 with SMTP id
 4fb4d7f45d1cf-5e4d6ac9e59mr7262602a12.4.1740847789385; 
 Sat, 01 Mar 2025 08:49:49 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:49:48 -0800 (PST)
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
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 1/6] meminfo: add memory details for armv8
Date: Sat,  1 Mar 2025 18:48:59 +0200
Message-ID: <20250301164922.397441-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

