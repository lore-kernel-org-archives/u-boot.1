Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BC4CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B0844096A;
	Fri, 16 Oct 2026 06:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PLVoMM8iF8fZ; Fri, 16 Oct 2026 06:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32EB140965
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133724;
	b=OIJOUBdKTwzIPCJVYtScqXgeACCXmwwgQ8cp9dOuu57gaYc4zfsTa58kldbbBMBgzweM
	 hRUvAji1v3IY1Yqw76g/hMXdRMNWns/oOJFDiAAEDkC7B4fSV3br7mGkV3fWME0+dK3Eh
	 twELNiOMF9xmEYh0QgeI9yXbjhjAx8EHFiIN0koU3qVprrHc0eeKPpdcNG61mrPXKeeJE
	 ofDc6evwr3XKPod5fjQppfM8eLlhpAGmsUv/7sy6CJTaFHAABjJtbkYCqCx006bsPzY9R
	 fkWB4eO/cvBTkY2I1bGQB3yi1VTw3BlyUWRe4kuU8gTPBBYc5iBXqLDEuqe71wl4G5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fYegZkoEcj6tzvrUyzV3voWUZIg1ljFP+TPPDOgUWpY=;
	b=tWsZiKD7YJA2iN3KR8RVsbir00kAf5v1KRA6gwfbcf/gUyUfQgIqjxC5XfToY+HVGFXA
	 LXwZfihV8xiEggf+Ygat8P74VTBap2CUcnHwYk3nvofJlyVdCOfcmXEVBtM4gYwyzveyo
	 ayRpGXCpYkmx7ZTC3gHWD5fKYPbeZAKJ+MNAwahkw3cNhi3w5DsjNkOlcQuNFjgrzZ9Yq
	 P9LtoMeqr+m7XFg4dD1OURvdjvag3mt0RqNzdI9z3I9Ayvg79/b1mfzGJrOgb/FVP0Kcy
	 TTyLsDAg/0E5i6lZjDSLG9RBSqxdtrJhvQovuAktSNRZ8+bvrXc+UeQ0IOHJTDDGz8A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133724;
	bh=fYegZkoEcj6tzvrUyzV3voWUZIg1ljFP+TPPDOgUWpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YQVhP7RMkVm3gK04rH5NzRmpAm3jfGY2PN5XQInmsFiRzIM2WpSsNgchDKifR51cK
	 zpTzy+X41dvLucRWjXlq+ikiDO8ToBw94Jywj77LfQxzndTeMj0vPxC0PIXOPgXziY
	 zTEWSfvGCUr54iwy5Mp4suwuEj5hWjg9EHzH+kU9buNq8xPILHW43k+61kQrbTCCy/
	 MIuKcoxuTb6VpkppIoMmk3DWKGYsYU97rTlBMfKUsWnNlCGlK7/wu1mReD0loFvoIt
	 jmPibRGbusSZOUin/hoAyMUxkeg4zLyTbsh3eoHvI6wdbsS9eUnS5vmqC2NzkTydZq
	 n2C1Bg3ZXTwGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32EB140965;
	Fri, 16 Oct 2026 06:55:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA14263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3928260ACF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4hzLWvqGTVb for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B79C60AAC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133721;
 b=dY2FbULGBDG3FyyftR9Mn0bXo29A6cf1yajpFqIBfdBlY605HvtsdQ9yrC80LfOk8skk
 pr9Bsp/X8lEM41jWx9BJndV3kOTUwsPF3bCj45NTxmqWxt0NZQqEFqqQnXd3/LM1p722T
 GUq1oEotGSGqb68dxD9ndHUedtc6wOwMDKb3gs2I3zMjCQjnloVWLgLIG4IklSOymiSMa
 Csgde7Wpx+MzXwQqzVUs6ro0S5zRYNGiG8L1Cp2mx8e/65Y2kgV+mYSH766D0Hjdzqmsa
 xjgFzPt3tuW9BLzlSnWqPXMipkY1SSHLZMeXv/DHMi+WVVAJOef6bnnWCywlztzSQ8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133721;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=fYegZkoEcj6tzvrUyzV3voWUZIg1ljFP+TPPDOgUWpY=;
 b=GLiU8YL4+ydsKWq9+zO1oZFFLpaotgbo/i9QxkhNGmFAs9HD11sQcALZZ3uyUHmSpiVO
 /wlYZXc0EW5IlqHs8ZxLIxhbNIfuWC9MyqziDSb1QOZoPSbbXLx8xu+9YJv+TCPy3JPg6
 PRxlvpVRL5Ky8Q+n2wWbe6pw3zp19aBPh/FluCAHngr3r8vpAkPyoZ232WjqpR/4uazfx
 1YzMr7AMnDVatlzFKDXpS7cW/VM5Y0cVuiKXFsQb2tnW5HA3/5M0rr9v6V06legQrONKq
 xPIvJNAdfoOd1lhD+RNwmBGWcWLlQDJYHp6ChHi179xOg1AUVY9WljD68vBZdJet+ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=gi4Kev8j; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=gi4Kev8j
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B79C60AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133715; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q4rq6Txts7Ei+73tTTlc47VtzVN9Rk47AnO3/wLUZACgNOA/CZQYv+fKEJv7TzKn2cDTspIJufTVTTtIJLnUo5/cRRNJoctHnsyE2zhaSctDmXJM1YIAEa1K8Xry1rrDveA1i4J41O7CRDCtwAZC0JJlC23teB+kBHeknwV78JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133715;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fYegZkoEcj6tzvrUyzV3voWUZIg1ljFP+TPPDOgUWpY=; 
 b=n+ULXIIQrshxca0I+jUnHxeh7EF78gYMH7BR+9ejRNJPeZrBYJGvgMeGq2cXedGhks//QSUbQuhjuKUtL8Fb8acWGmXHq33Omsk5GnhLdNk8sJqkE95jePAm+KhXe88knZdVp8cNgrFTmVbh0nttm/v3sb1RWZoN85Ub8gxDOlA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133714; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fYegZkoEcj6tzvrUyzV3voWUZIg1ljFP+TPPDOgUWpY=;
 b=gi4Kev8jTLjjalArrkqcD8Thh2yncu2y2GFOnFG5whATQsV6WXWQMGX+IdbLINoU
 Fd9xRVsXzUtfs8Oox8sQZ7jOd6ASW0dk02PzTjkaYvilcpp4kl7Y2LB01qopkeHdCOp
 OBpQYvgV/2f7vLHrCtNN4HqIC5W2haGC3QuiknZE=
Received: by smtp.zohomail.com with SMTPS id 1792133713516198.05972397676737; 
 Thu, 15 Oct 2026 23:55:13 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 01/20] lib: fdtdec: Handle multiple memory nodes
Date: Fri, 16 Oct 2026 06:54:41 +0000
Message-ID: <20261016065500.137544-2-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Current code only tries to fetch the first memory node found in
fdt tree and determine memory banks from multiple reg properties.

Specification allows multiple memory nodes in devicetree, rework
fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
to iterate over all memory nodes.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

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
index d25535bf36cf..e6c89c771368 100644
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
+			log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%pap, size = 0x%pap\n",
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
2.55.0

