Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AF1CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6B483510;
	Fri, 12 Sep 2025 14:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BpiddyGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBBC830A0; Fri, 12 Sep 2025 14:16:38 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC85B83448
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGVbq966955;
 Fri, 12 Sep 2025 07:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679391;
 bh=1TlIDgle96S2XJjkE4E4er1rPPGy8x/x8OyhlEbMLhY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BpiddyGrbrEQ3WAUO1dpzWz+IcM904gU8aLe/9CHdlPC4ABp11/U8j17Ns/pdk4Za
 BKPOem84ahg0/ZfCCMjXaS/+LaiYThGkyBYUkapfsgwkUbrqECjU6Y6aXA2mWbiP9W
 e1jqbwtnzkuql57qAQevCeukpufhvNGBC99b44r0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGVMV1287966
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:31 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:30 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGTZS3886198;
 Fri, 12 Sep 2025 07:16:30 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 05/10] arm: armv8: mmu: add mem_map_fix_dram_banks
Date: Fri, 12 Sep 2025 17:46:12 +0530
Message-ID: <20250912121618.1074054-6-anshuld@ti.com>
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
the MMU as part of mmu_setup.

But since the exact configuration of memory banks might not be known at
build time, many platforms such as imx9, versal2 etc. utilize
gd->bd->bi_dram to configure the static map at runtime.

Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
the static map in a similar way. Allowing the caller to map all dram
banks by just passing the index to last entry in their mem_map and it's
length.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/cpu/armv8/cache_v8.c    | 28 ++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 6e662395a83..20583bad470 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -58,6 +58,34 @@ static int get_effective_el(void)
 	return el;
 }
 
+int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs)
+{
+	unsigned int i;
+	int ret = fdtdec_setup_memory_banksize();
+
+	if (ret) {
+		printf("%s: Failed to setup dram banks\n", __func__);
+		return ret;
+	}
+
+	if (index + CONFIG_NR_DRAM_BANKS >= len) {
+		printf("%s: Provided mem_map array has insufficient size for DRAM entries\n",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		mem_map[index].virt = gd->bd->bi_dram[i].start;
+		mem_map[index].phys = gd->bd->bi_dram[i].start;
+		mem_map[index].size = gd->bd->bi_dram[i].size;
+		mem_map[index].attrs = attrs;
+		index++;
+	}
+
+	memset(&mem_map[index], 0, sizeof(mem_map[index]));
+
+	return 0;
+}
 u64 get_tcr(u64 *pips, u64 *pva_bits)
 {
 	int el = get_effective_el();
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 3807c702fb6..257352f216e 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -194,8 +194,18 @@ struct mm_region {
 	u64 attrs;
 };
 
+/* Used as the memory map for MMU configuration by mmu_setup */
 extern struct mm_region *mem_map;
 void setup_pgtables(void);
+
+/**
+ * mem_map_fix_dram_banks() - Populate mem_map with entries corresponding to
+ * dram banks as per the gd. This should be called prior to mmu_setup.
+ *
+ * @index: The entry in mem_map to start the over-write
+ * @len: The size of mem_map
+ */
+int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 attrs);
 u64 get_tcr(u64 *pips, u64 *pva_bits);
 
 /**
-- 
2.51.0

