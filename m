Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hy71SyYz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=pIsQbP/k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0832880F66;
	Thu, 29 Oct 2026 05:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rcVf3w8cipix; Thu, 29 Oct 2026 05:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1351380F61
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250505;
	b=SlbOOVrly1zeDVcRyWrt+grtTyjPncJKZ5e7gf/WDvQ7s77EeVwUWf1l5ajHGR77v1Dz
	 xIXGzrIL9CWa8Yn12Lqf4Auqq+cS3ZqZHpd7FYj+TrhYX4KVgTyU/Tp6i8HEz56wJnYnV
	 LfdeF7Oom9mYhg7B6p8TH1NG0QCvVZppHk3sHCz3ol/LfglnIAzTBHSIHxfvbb62rAtBw
	 Wz6y1AHlSbqkUDSf/p3BRCiLq1eWX2stZcvHBi9N+yk1VgQAgZEjRcmqiVvmBYolP9O1o
	 55HbVA6avRiCOYTs/U/5sMY6jLIgxwh9pVFraCtSuDaQlgmax/OzoYga1Lv/k014uUQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Qo474Vu3sSE88salBfZCDMLyG9LyBxMah3kRksgWgU8=;
	b=BLR23W8LIcaJ/TXG4mKcrjPrX3jC/OqeZhkZ9jT/Aao23Q5Fx+Av3J7kiI9NeCXJLyQ9
	 6h2L1P5416sLpX/Ndad6X+w2eDLViO0Gmlu0JgCmyG0F/l80OHItwSwEnVmrPr4hkrs5S
	 qXFx48oUK/Jfb4HPKGq40fVj3i7+YOVcb6ufVAxNHwV6RZIm12eYcqJFQfF80jWL5VW4R
	 Pl0h/X1DeA0ceg0dvbawb8pkvJuuNVQj2EkOJ/kNy+u6uWlU7TUhj/y556NkJzNLM7R7T
	 +BnlaBKmJmkX3y9bIrt3WBpRRw6HjdDPkO4SMraxgfLFut3AVrsy4HDkzXIRYsrHpfQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250505;
	bh=Qo474Vu3sSE88salBfZCDMLyG9LyBxMah3kRksgWgU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hy71SyYzAFrujCe2xKb0pSo9h5H+T9uEMFZzgY2yDx9n7bw0viEvS4VpjQIhBQ/xo
	 /zR1HJry0stgj2mpIBmPkonyMRt6vOfYTtC+N/XKpxpD7l1Y4LOLbrlMm+nV2Zou9n
	 Ph0NdKhu9gpFw4Twz5OqJcpidwPKb8ptNjGailro5Y7jp8QbbvVWfwmmfl/iHb3nMv
	 5M/A502zgsqnyaIUdXlR3PwXXf4cTRw5WDhJpMiD91F0s2MZ29xSHaVrLpplbxXLvQ
	 kIqjXDqM1nJWjDmCFnidi3VOPiAWNBuCnGssKCrMyMvPHfwKf9mTyKEdy5UkWZx1zh
	 U4fD/sotnzPmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1351380F61;
	Thu, 29 Oct 2026 05:08:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A4D5380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C3E440310
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6iX7YM2elqA for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1667140176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250502;
 b=DMZD6lMsX7QuV5Z3ZzS6BgxdXJK33vJJIkPGtwkc5Qfv2fes6tm9TxvHvFzsvtZtjQtH
 AXjYvmDpT7eTUS+GTYCqw9bwbw8Bs6nlnXIjgc60ebv3RTZEq3UbH6UMiG1m4ljJZBV6D
 9mko8T27xov61xsp/EZhgrYeteftcanQugzbVLxpZ4Ivf7HZMW6iy6wEdxRHZcNe7P1v6
 M2Z2gZnJ4Yc8hMprzdQ0ycrqZlWF/JX6ZfbABECQcPnUN/IhjrYuLNklKXTdo78cLkyU+
 EV/1oJCKJ5p2TUS+dpjPa2krkvOwutiTWmqciSgKXErloXnqrtt6gGKC481L+6ioBqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250502;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=Qo474Vu3sSE88salBfZCDMLyG9LyBxMah3kRksgWgU8=;
 b=jm7SzMfxLy2tolbQXUyTmAyjJuJvvSQiZnJ6JBz3puQuXzRMV7wYTCN97taA2UxpSG50
 6DxS4IRnvakjUfMQnZ3Owzc3sZzDPZOdRoiN6PDdVS27FOUC5wBdXBe7SiCG2fFEHbupB
 pF0wNt0Qlq1IZzeG1fAOwro6fkzOwA7ThB6cojnH+JnSS4qL5EaGK1nhLhQomfurW5iuX
 8qAkuc+YCC66ppzVc15Dp6WFH+btknkJp7iRZb/y8MlyNHjuJ+ANYbaPztjr4Mtkxxuwo
 sOEPpNXGqL+CEVZ35xrH1iTx6euAZT3XMfCVjbzAEt6DZ6fQT+tpuq0Kw0/Ty/CWJUQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="pIsQbP/k"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pIsQbP/k
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1667140176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250493; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=djgsCx6LKBpC5UoS1Sk32RrQj//7+CEXw08rRMDLT+r7d9nin3+H2CovPSgvRao6tlRhgckAyw4mOaNrOnJ0jqgpL2/ROgDxAR+YRm39Q/D5KO4L8mScbOfSrXTwE4JrpC8RXkqt/r7VXZKLpI0Hb+MZe2tFKZvS86xRo3cyidI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250493;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Qo474Vu3sSE88salBfZCDMLyG9LyBxMah3kRksgWgU8=; 
 b=Fo6jifIJISNpT13rbx5riaGZZaCAmS0dKPc6CKYY4dFO2qxCGByMnR/IqiENmazj+nymz5RLZMOfbOLmf3uq52S2J66nqB53lE9UsNnFBF3s1hjzRho+T3xIbv6LD/zAKHnGxaxGBQxEfYiDPLpkvhLiB6sRu2UERSDFp1pSxqM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=pIsQbP/kojfR12uPlcWzJt8dmwSKVFSanmahmwnMCWCsggYPhx9va/MuKyms8k0lAUo77wNrqo2pEL0Dpmw8QOXDwPWq+VmbdHjGRTA7JZJ/YkPCuPWsRThNG0Lwqae8VxLy+n35EZ/lMemUhYN8W3gaoJnoNVSXZlCCS/B0VY8=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=Qo474Vu3sSE88salBfZCDMLyG9LyBxMah3kRksgWgU8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250491967938.2968240621454;
 Wed, 28 Oct 2026 22:08:11 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 01/20] lib: fdtdec: Handle multiple memory nodes
Date: Thu, 29 Oct 2026 05:07:18 +0000
Message-ID: <20261029050738.1107663-2-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
---

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

