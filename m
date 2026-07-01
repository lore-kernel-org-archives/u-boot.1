Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC388C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C9484B92;
	Wed,  1 Jul 2026 13:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="PzWNFgQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964F184BB3; Wed,  1 Jul 2026 13:18:31 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5A384B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782904705; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JfncklcRQLHN6Vr+GRrNK5uP/ZOxS6mFBy2CEQn2i5wbhS6PGCJfYdut00RzRRS3ytbrCic696GDsYyjMMmvjAk7IcWXnVFymXdLWEWhfvLXzbKGvlc5dbe5ozG0Mmw/pd3f8GvMR5PyhVYQ9rCg51ragH1K3znJ9i96NT/XsIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782904705;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kuGxh/mLUDzxU0ZZJN+KOqu2d3sCo4VNLrEO/lt1Mc4=; 
 b=hbGhPJBxNy7DsT32Rm2LLSsxjQNYGmS/RTTUHdxXbNc8jaFvrs1WtGtcp/+9BzGRFxsaup3alDZY73GfqRRNJNBkwn3ILsR5YHNGeSJ6TKkB46CS7a6g6ZTl541gmK7TF9c0jt3q1btBTtLSo2/Kkm7KyqMQ16KjNRitzCMtYY0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782904705; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kuGxh/mLUDzxU0ZZJN+KOqu2d3sCo4VNLrEO/lt1Mc4=;
 b=PzWNFgQlNLoVExQqfbMp3Ui85hGRa+3UWMKCZoIXh+xctIDmTRFbcN6H5c1+8W99
 Z6BH3GWf5q/NWSUGYQ7AodT0UbkfoClu3v3e5nbfJM5/JZUjD2xZkQbcdGnKHCGW1re
 uUTiQClZYyUlK/pl4ofcCNc5o3M3qtu+OQFe5xhI=
Received: by mx.zohomail.com with SMTPS id 1782904702867473.9941158695974;
 Wed, 1 Jul 2026 04:18:22 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 01/16] lib: fdtdec: Handle multiple memory nodes
Date: Wed,  1 Jul 2026 11:17:53 +0000
Message-ID: <20260701111808.870705-2-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
References: <20260701111808.870705-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Current code only tries to fetch the first memory node found in
fdt tree and determine memory banks from multiple reg properties.

Specification allows multiple memory nodes in devicetree, rework
fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
to iterate over all memory nodes.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Hi Simon,

It's hard to add unit tests for these two functions since they operate
on global states (gd), so I don't do so. Is it acceptable, or is there
a better way to do this?

Changed from v1
- Reword commit message to reflect the fact that dtspec allows multiple
  memory nodes
- Replace sort_memory_banks() with qsort()
- Do not use CONFIG_VAL when referencing NR_DRAM_BANKS to avoid breaking
  SPL build
- print gd->ram_size with %pap instead of %lx, drop unnecessary cast for
  gd->ram_base in fdtdec_setup_size_base_lowest()
- Style improvements

 include/asm-generic/global_data.h |   2 +-
 lib/fdtdec.c                      | 129 +++++++++++++++++-------------
 2 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index ad7ebb1bbc95..a4df897543a8 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -460,7 +460,7 @@ struct global_data {
 	/**
 	 * @dram: array describing DRAM banks (start address and size for each bank)
 	 */
-	struct {			/* RAM configuration */
+	struct dram_bank {		/* RAM configuration */
 		phys_addr_t start;
 		phys_size_t size;
 	} dram[CONFIG_NR_DRAM_BANKS];
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b91e067106dd..33fd7359f2eb 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -36,6 +36,7 @@
 #include <linux/lzo.h>
 #include <linux/ioport.h>
 #include <asm/global_data.h>
+#include <sort.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
 	return get_next_memory_node(mem);
 }
 
+static int cmp_memory_bank(const void *a, const void *b)
+{
+	const struct dram_bank *a1 = a, *b1 = b;
+
+	return a1->start > b1->start ? 1 :
+	       a1->start < b1->start ? -1 : 0;
+}
+
 int fdtdec_setup_memory_banksize(void)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
+	int bank = 0;
 	ofnode mem = ofnode_null();
 
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
+	while (true) {
+		struct resource res;
+		int reg = 0;
 
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
+		mem = get_next_memory_node(mem);
+		if (!ofnode_valid(mem))
+			break;
+
+		while (true) {
+			int ret = ofnode_read_resource(mem, reg, &res);
 
-			ret = ofnode_read_resource(mem, reg++, &res);
 			if (ret < 0)
 				break;
-		}
 
-		if (ret != 0)
-			return -EINVAL;
+			if (bank >= CONFIG_NR_DRAM_BANKS)
+				goto too_may_memory_banks;
 
-		gd->dram[bank].start = (phys_addr_t)res.start;
-		gd->dram[bank].size =
-			(phys_size_t)(res.end - res.start + 1);
+			gd->dram[bank].start = res.start;
+			gd->dram[bank].size =
+					(phys_size_t)(res.end - res.start + 1);
 
-		debug("%s: DRAM Bank #%d: start = %pap, size = %pap\n",
-		      __func__, bank,
-		      &gd->dram[bank].start,
-		      &gd->dram[bank].size);
+			log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%llx, size = 0x%llx\n",
+				  __func__, bank, ofnode_get_name(mem), reg,
+				 (unsigned long long)gd->dram[bank].start,
+				 (unsigned long long)gd->dram[bank].size);
+			reg++;
+			bank++;
+		}
+	}
+
+	if (!bank) {
+		log_warning("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
 	}
 
+	qsort(gd->dram, bank, sizeof(gd->dram[0]), cmp_memory_bank);
+
 	return 0;
+
+too_may_memory_banks:
+	log_warning("%s: Too many memory banks\n", __func__);
+	return -EINVAL;
 }
 
 int fdtdec_setup_mem_size_base_lowest(void)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
-	unsigned long base;
-	phys_size_t size;
+	int bank = 0;
 	ofnode mem = ofnode_null();
+	__maybe_unused const char *final_name;
+	__maybe_unused int final_reg;
 
-	gd->ram_base = (unsigned long)~0;
+	gd->ram_base = ULONG_MAX;
 
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
+	while (true) {
+		struct resource res;
+		phys_size_t base, size;
+		int reg = 0;
 
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
+		mem = get_next_memory_node(mem);
+		if (!ofnode_valid(mem))
+			break;
+
+		while (true) {
+			int ret = ofnode_read_resource(mem, reg, &res);
 
-			ret = ofnode_read_resource(mem, reg++, &res);
 			if (ret < 0)
 				break;
-		}
 
-		if (ret != 0)
-			return -EINVAL;
-
-		base = (unsigned long)res.start;
-		size = (phys_size_t)(res.end - res.start + 1);
+			base = res.start;
+			size = res.end - res.start + 1;
+			if (gd->ram_base > base && size) {
+				gd->ram_base = base;
+				gd->ram_size = size;
+				final_name = ofnode_get_name(mem);
+				final_reg = reg;
+			}
 
-		if (gd->ram_base > base && size) {
-			gd->ram_base = base;
-			gd->ram_size = size;
-			debug("%s: Initial DRAM base %lx size %lx\n",
-			      __func__, base, (unsigned long)size);
+			reg++;
+			bank++;
 		}
 	}
 
+	if (!bank) {
+		log_warning("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
+	}
+
+	log_debug("%s: Initial DRAM %s.%d: base %lx size %pap\n",
+		  __func__, final_name, final_reg,
+		  gd->ram_base, &gd->ram_size);
+
 	return 0;
 }
 
-- 
2.54.0

