Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63364CA1015
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1612D838CC;
	Fri,  5 Sep 2025 10:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pu2hx+iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1224B838C8; Fri,  5 Sep 2025 10:19:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA934838A5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5858JBNv3710736;
 Fri, 5 Sep 2025 03:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757060351;
 bh=jT36nWJGekzu90/f4N27ErchB46X+XrkYc9UXcO+0D4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pu2hx+iYGhoGSNESGWB2BbV0bJabIr8WIkpI7BdRR97cQqZSQQCNwSpdvkmBJn677
 cg3yQ+ddEh5LjTKqpsy5ODtCCMHyVnE/I7DAo4XzbW4A4krvUv0OKG0F7URhflYOYo
 nY6NkgRZXhbWhSpzV3cTYVHhcbrybcJNezmZGJFs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5858JBN01502069
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 5 Sep 2025 03:19:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 03:19:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 03:19:10 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5858J9ob445220;
 Fri, 5 Sep 2025 03:19:10 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v6 03/10] arm: armv8: mmu: export mmu_setup
Date: Fri, 5 Sep 2025 13:48:54 +0530
Message-ID: <20250905081902.489345-4-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905081902.489345-1-anshuld@ti.com>
References: <20250905081902.489345-1-anshuld@ti.com>
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

The mmu_setup function configures the page tables based on the board
supplied mem_map struct array. It is called implicitly as part of
dcache_enable but this limits us to only be able to use APIs such as
mmu_change_region_attr only after caches are enabled.

This might lead to speculative accesses before we can unmap a region
that is marked as cacheable in the static memory map.

Therefore this patch exports the mmu_setup function in mmu.h allowing
users to have more control over when the mmu is configured.

For K3 specifically this allows for the following configuration sequence
as part of enable_caches:

static mem_map fixups (TODO) -> mmu_setup -> carveouts using
mmu_change_region_attr (TODO) -> icache/dcache enable

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/include/asm/armv8/mmu.h | 5 +++++
 arch/arm/mach-k3/common.c        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 6af8cd111a4..3807c702fb6 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -197,6 +197,11 @@ struct mm_region {
 extern struct mm_region *mem_map;
 void setup_pgtables(void);
 u64 get_tcr(u64 *pips, u64 *pva_bits);
+
+/**
+ * mmu_setup() - Sets up the mmu page tables as per mem_map
+ */
+void mmu_setup(void);
 #endif
 
 #endif /* _ASM_ARMV8_MMU_H_ */
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 9d6c6fea451..e9b48b528d6 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -30,6 +30,7 @@
 #include <soc.h>
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
+#include <asm/armv8/mmu.h>
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -261,6 +262,8 @@ void board_prep_linux(struct bootm_headers *images)
 
 void enable_caches(void)
 {
+	mmu_setup();
+
 	icache_enable();
 	dcache_enable();
 }
-- 
2.50.1

