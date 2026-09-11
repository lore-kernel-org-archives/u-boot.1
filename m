Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F42C88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4552081257;
	Fri, 11 Sep 2026 10:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBo-tZF2l1hj; Fri, 11 Sep 2026 10:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 567EB811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123596;
	b=Z8s3cTMjbjCGSToeQVu9qBOLzxdBvRvhDZG+xLr32audI8gDzq1EczR354+HJ5hNoHFN
	 1hEhgrgASzYh87aRdBUwCtCweN+Eqq8IfoY4ZVZS8z1A8OPQAq5K6gEROaxM+ffBirWs3
	 OkWkGKXgXgTw7iRlsvXBS1hb5Kr0Yag5u7x5k0H37U6vs6nFT0pV1gXI3hw5wsWg4Mlr+
	 bVFgx6rEKjio+BjPoZLL/9L+21STxJahogemIJp/mPZBeS0toUDOb160Xgb5v4y7BoYTV
	 YemN8BDQjyRESFGxnFL9v+F6HwcOsWVkiqP68b+ytAGoEpD7hnB7mucOXM9VDx/YnDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IL/s6ScoCPAiiOrSTygsx6niUpa84qsCku1whZOZU5M=;
	b=OIM41/tTg0td60B0RvoOxZveL4xDo7snqPZACvheZiaNNSUQl4DimyYw58ilDXTLjw1T
	 4odaHbftJJfQufSIYtasZrNUWqe5DPk5bm2SuA8XviN4AKk42fXtNs/FXi+xzWahqUmYg
	 7Omp4R6lDdrk/ue9DDJKG1IPh3GdZn49pc/3TpnFiwfKbHf3NBBhbYdrgApm66no4q4Yk
	 f/dRsGOX7xe3Cw/lRSdywM88eY2wQfh6RQk5ESqkNmBjN4ji2+3iV9tqaqIDGRwc++7KX
	 XIK/0iuDHcXCl3Qf1I/v/2JqP8q8tFST10Hoog7lBGAtPD9NWaD5YfC+0mvInXsJlsg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123596;
	bh=IL/s6ScoCPAiiOrSTygsx6niUpa84qsCku1whZOZU5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGUi950fLxKxsWXe24ZgXm3EbukDLM/o7FOfhkgDyenqg9AbgJ+MThu2pHl42WREE
	 ad6Pyn7nPIgS48Jk0xAnRP9kX+mT7M4euCPOJ1TsQ/pcn0DmwUiSofsIvXutTYRR/e
	 mB5x7V5zyFVvet12t8OUVssyD9+huSr55ff+YJQTkHwtsjzvkMhrb5u21etlL1HY+g
	 u/wwvwHuiFSWK6YU6a3fNGWkFmrVfsWBtHFdXLKYbVqLejSdoZaSA00GloFiCBCpmv
	 oNsBz0ObjagSMriPa07stJIu883SWbklxwnOEmOyDd3tYkUyDHKA6VacSQTP4RS3Gr
	 m0RW+XknWAt0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 567EB811FD;
	Fri, 11 Sep 2026 10:46:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 41FEC769
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27D8840AF6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQnDWXB4byuu for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 118EA40AFB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123594;
 b=o8Pb6I19jY4Xl7GnUeIiIPBi6y1yM8YtK2gr+92NdvAFqBH0Z7ClYxW3cVaa0XUiUvU1
 neXkLhhrj7gfEXPTfjGrkYOhtxjxwEM+Zn2nuKbJp6ABxwbFPKB9nmQOtWSwbIVBI69+f
 tE9Ls+s07SkV8NnZmvfLIrFZkkaXGvqzlJGcoTvlM0p4YdUqYHGiIGfVeaxO1r0B5x56b
 t3/A7AwTtwJX01SO2rinBFWTtF4ZN4mV+IXVMkbhIYDvw6r3HxP+l4F9u5LPvKO0mGtVx
 tptw7YhsNia7DUV43W05PvicQHkbfb/CA1j/aVggZsSv/kWKbmrt+aBFfzx227mW3CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123594;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=IL/s6ScoCPAiiOrSTygsx6niUpa84qsCku1whZOZU5M=;
 b=H9jwolTgyJVVnWKzq3ZuLs85TFIAWhyU7qCHcMzzbw82B2gvz6uaoaohD2cZYpInxnMV
 C1Omos9L6eiWipiAYw70JOVtN3tycmcSa6BFgfefOf0mS9S8u1kgWNgM6ydH6+Xpxjl0V
 njziFqUh0VSOPUFLpTfLQJgRitBg7MeFAnmv104wBgTDaY6/TrNp/qON3k5s4BLWUoEmo
 VSTi74mZCq19Fct2caig/ADtoR1Y0pd8efbiaQakxW+wFKgGY9jIXcsq4iTOSBhji+RFW
 3A7ZwgKRBNBKSPGcx7IBVTdbtEP9IO/wkDtCZwJJsEFteuE8+9r3P5/0mI0kzr29KPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TQxlBdw5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TQxlBdw5
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 118EA40AFB
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123587; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YDvbZxHarBb/ZHpKG8vrxWCZP6bhV+OubI9y862Fc5XVXTOWKvr4viGUai5Z8Hq/wBUUCSxKxpUraaDKnJCOxks/aK62G0s5oSA3AMbAbjFDjSaE7smySlnFgv9jSM1YdStgNsytyTLQkR+fHyowYsScZnMKQqjhooiQFhN4JUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123587;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IL/s6ScoCPAiiOrSTygsx6niUpa84qsCku1whZOZU5M=; 
 b=ipeJUOYjTVeaIXFXxXs1qDKdlZ/Wl5BtdDw2Y/w6KvsWfidOK0/KY5fbLLPDr9IjTfWs6lZVhfujjTkBmcoNhT4UhX5z5AlwDl1uXt0JTyjzJmHN0CU+5s2IWo6BQ85oOjUuFCZC+86oXsBH7wdw68odeIICMLtUYiqD4bKvTDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123587; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IL/s6ScoCPAiiOrSTygsx6niUpa84qsCku1whZOZU5M=;
 b=TQxlBdw5g6Hw7VGzV2i1dTyuFPg3ePz7mSdA6+TZb6hCQXyfazCI6hf9HOCYOSCQ
 vrpr1QEPpkLdBzXS9iF2B+aNRd0WDfHCTOj2bzMW9Zk9GHPGcLHI0QvqrdKxDdN01sm
 VE32IDpMhDOPM4EBkpyJdI8nLXPYxd6sidbtDcc4=
Received: by mx.zohomail.com with SMTPS id 1789123586555909.948607837097;
 Fri, 11 Sep 2026 03:46:26 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 01/19] lib: fdtdec: Handle multiple memory nodes
Date: Fri, 11 Sep 2026 10:45:46 +0000
Message-ID: <20260911104604.2910944-2-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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
index d25535bf36cf..1000f03d0141 100644
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
+				return -EINVAL;
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

