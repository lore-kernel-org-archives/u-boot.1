Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94186606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jw4ZVfQO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=V3zZNM4b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E0FD40795;
	Thu, 12 Nov 2026 11:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8DCReWS60bE; Thu, 12 Nov 2026 11:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E3244097D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484508;
	b=et/ASaPcqrCzKD1//c1vpb/+lTyp6ADNCUF80pTJx2371yrsucp/3tLQcYNjnC6jS72y
	 WyBqXIVdnmwlkR5wYqeYhyPaEby5o1knZ8jUyBrYeNGYf1Yy71ZmpHjVUVaCTrF6OU6i6
	 05Gzjaw85t4uKtFBKl2HmgxXTdKGfRkYr4Dwl92bq9Cbd7e2gg8TSr7nDssrj4Aw6Adg6
	 pSRdGap+KOFUJa38eOXKAOpojCvyZoK4U7yLREKVJx5Pf+IYS2NpZB7myFuk4XgmV0l5t
	 W1BH22HGCnTpRbj+DZjVojG9FDBrJdJUa0HPActYiZvy22FlDFZUcVRbYwUzrBYcbTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=udhtyzT/jo6VRPkAOT+tP8qRA4W1NJp4EtzWvoGc8XQ=;
	b=Wr5Mha4Ww8GJcTiil/I4P/skKmwDuU89olkzCh4XdrbBUZyySQQ/59dgtRZaVPYptfNH
	 ioYTXwl5BpwJGAcARcFD/6yWBV8Fa+D9J5CdZUAnYSmLVBBMCGIvTN+p9lhGoy3aVxk9J
	 MXqxEI1NtbJRV6uWsaP8F28TjpMXa5z7STwiiLWmwGXuErFZmFM+9680q0R8pwIE2kvHF
	 2rhRyohQ1LppjGuCkwMo1eTP4jtlElhzd71juuTeep+dI1kGVFcyqZjfOPgYUB3ZireRH
	 1mesUolH/uAsOjEsJYWsYilenw7HFE62nAKwBxxSXLDHZbeFnAyxENZmYq1KiRRYqVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484508;
	bh=udhtyzT/jo6VRPkAOT+tP8qRA4W1NJp4EtzWvoGc8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jw4ZVfQORnYe+gkypEO8R/czlXRfvpOymMAz+MZrx+DDLK8nVhhsMD6suLJtcITyO
	 Dqm+i5W0PaefhgeUMusAjZF6i5/QxFG1HkjpQq7qao3WVsDhaWTuWE5jo9yM8GP52z
	 ++GGwhUavwBD+QwDmD+FMGMkpt+ygogmWIEysG0UQ65/SVNaGHh5A9s/fjaMOGywm/
	 n/+/4ZsTXPHae92vBDcHdlThvE8TTqcla762wY+98j90aWR8QpdTN/r0mnOsPWkf79
	 9IhRJjYDYuUWgTbAvgD51klHnUPmThwN1QIrhi7nfzuOnt0GH1PPB+VEvlOcBpxIlB
	 T0D0M+2kmutCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E3244097D;
	Thu, 12 Nov 2026 11:55:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64C14156
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61E908144C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vmJJDY1uR5Aj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:55:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6097C8144A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=V3zZNM4b
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6097C8144A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:55:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=V3zZNM4bQ+lFwQQgDLIt53bA/mZI7yaC1sT9wcZw9yfmSKEUOGefN6lpvD+RD5myHXrG7dbBas/L4llgsJvuLZ3SiUepHWa32xew0rY/ryU/8wjX6ItzOqxG5WjiNY37mUmNjsr8T/Wrmt++Pe8NozJuJcGPpxAG9YWvX+MGHoE=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=udhtyzT/jo6VRPkAOT+tP8qRA4W1NJp4EtzWvoGc8XQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484495113363.19447554319595; 
 Thu, 12 Nov 2026 03:54:55 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 01/20] lib: fdtdec: Handle multiple memory nodes
Date: Thu, 12 Nov 2026 11:54:19 +0000
Message-ID: <20261112115438.1837663-2-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Current code only tries to fetch the first memory node found in
fdt tree and determine memory banks from multiple reg properties.

Specification allows multiple memory nodes in devicetree, rework
fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
to iterate over all memory nodes.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v6

Changed from v5
- Drop the redundant 0x prefix when printing debug message

Changed from v4
- Do not fail fdtdec_setup_memory_banksize() with -EINVAL when there are
  more memory banks than CONFIG_DR_DRAM_BANKS to avoid breaking existing
  boards

No changes since v3

Changed from v2
- Return directly from the inner loop of fdtdec_setup_memory_banksize(),
  instead of using a goto
- Use %pap instead of %llx when appropriate
- Use phys_addr_t for base in fdtdec_get_next_memory_node()

Changed from v1
- Reword commit message to reflect the fact that dtspec allows multiple
  memory nodes
- Replace sort_memory_banks() with qsort()
- Do not use CONFIG_VAL when referencing NR_DRAM_BANKS to avoid breaking
  SPL build
- print gd->ram_size with %pap instead of %lx, drop unnecessary cast for
  gd->ram_base in fdtdec_setup_size_base_lowest()
- Style improvements
---
 include/asm-generic/global_data.h |   2 +-
 lib/fdtdec.c                      | 127 +++++++++++++++++-------------
 2 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 886c12900ddb..75c80c8a0db4 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -462,7 +462,7 @@ struct global_data {
 	/**
 	 * @dram: array describing DRAM banks (start address and size for each bank)
 	 */
-	struct {			/* RAM configuration */
+	struct dram_bank {		/* RAM configuration */
 		phys_addr_t start;
 		phys_size_t size;
 	} dram[CONFIG_NR_DRAM_BANKS];
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d25535bf36cf..59623df8db39 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -36,6 +36,7 @@
 #include <linux/lzo.h>
 #include <linux/ioport.h>
 #include <asm/global_data.h>
+#include <sort.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -1115,90 +1116,108 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
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
+			if (bank >= CONFIG_NR_DRAM_BANKS) {
+				log_warning("%s: Too many memory banks\n", __func__);
+				return 0;
+			}
 
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
+			log_debug("%s: DRAM Bank #%d %s.%d: start = %pap, size = %pap\n",
+				  __func__, bank, ofnode_get_name(mem), reg,
+				  &gd->dram[bank].start, &gd->dram[bank].size);
+			reg++;
+			bank++;
+		}
 	}
 
+	if (!bank) {
+		log_warning("%s: Missing /memory node\n", __func__);
+		return -EINVAL;
+	}
+
+	qsort(gd->dram, bank, sizeof(gd->dram[0]), cmp_memory_bank);
+
 	return 0;
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
+		phys_addr_t base;
+		phys_size_t size;
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
2.56.0

