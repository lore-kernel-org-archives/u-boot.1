Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFCACA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5491834EC;
	Fri, 12 Sep 2025 14:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xAvdLHhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767C78350A; Fri, 12 Sep 2025 14:16:44 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2FC834E5
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGZjF966963;
 Fri, 12 Sep 2025 07:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679395;
 bh=f6ADJY6MAmtq4nA8jKzIgWgA3kqyyX6soQGCqsxJVrU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xAvdLHhi5vdj2EoadrYszXMhCo5nYpS1LwqEe3riA+orOGeHavL2Pyv1oYncZdHWp
 mOllyfcQB15URlPVmB2QPZhAsO8hKoA5eiq8uEqDgX538BbiDGMENqlZ7Jp2Gzry3i
 NA7kvZGhisAXCfJTiWIkaarK9tcfYvKkZ4DhakC4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGZNU1287982
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:35 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:34 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGXWc3886281;
 Fri, 12 Sep 2025 07:16:34 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 07/10] arm: armv8: mmu: add mmu_unmap_reserved_mem
Date: Fri, 12 Sep 2025 17:46:14 +0530
Message-ID: <20250912121618.1074054-8-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912121618.1074054-1-anshuld@ti.com>
References: <20250912121618.1074054-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
the MMU's page tables, done by mmu_setup.

Though this works well for simpler platforms, it makes creating runtime
carveouts by modifying the static array at runtime exceedingly complex
like in mach-snapdragon/board.c.

Creation of such carveouts are much better handled by APIs such as
mmu_change_region_attr once the page tables are configured. Usually such
carveouts are configured via the device-tree's reserved-memory node
which provides the address and size for the carveout.

Therefore this patch adds mmu_unmap_reserved_mem which acts as a wrapper
over mmu_change_region_attr, helping unmap a reserved-memory region.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/cpu/armv8/cache_v8.c    | 23 +++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 20583bad470..1dcb6007475 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -86,6 +86,29 @@ int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)
 
 	return 0;
 }
+
+int mmu_unmap_reserved_mem(const char *name)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	char node_path[128];
+	fdt_addr_t addr;
+	fdt_size_t size;
+	int ret;
+
+	snprintf(node_path, sizeof(node_path), "/reserved-memory/%s", name);
+	ret = fdt_path_offset(fdt, node_path);
+	if (ret < 0)
+		return ret;
+
+	addr = fdtdec_get_addr_size(fdt, ret, "reg", &size);
+	if (addr == FDT_ADDR_T_NONE)
+		return -1;
+
+	mmu_change_region_attr_nobreak(addr, size, PTE_TYPE_FAULT);
+
+	return 0;
+}
+
 u64 get_tcr(u64 *pips, u64 *pva_bits)
 {
 	int el = get_effective_el();
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 257352f216e..fbd64e649ff 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -206,6 +206,15 @@ void setup_pgtables(void);
  * @len: The size of mem_map
  */
 int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs);
+
+/**
+ * mmu_unmap_reserved_mem() - Unmaps a reserved-memory node as PTE_TYPE_FAULT
+ * once MMU is configured by mmu_setup.
+ *
+ * @name: The name of the node under "/reserved-memory/" path
+ */
+int mmu_unmap_reserved_mem(const char *name);
+
 u64 get_tcr(u64 *pips, u64 *pva_bits);
 
 /**
-- 
2.51.0

