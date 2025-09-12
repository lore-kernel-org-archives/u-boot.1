Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C141CAC58F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949FE83285;
	Fri, 12 Sep 2025 14:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OMSYLuBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0746683285; Fri, 12 Sep 2025 14:16:32 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB69783285
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGRqo600594;
 Fri, 12 Sep 2025 07:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679387;
 bh=/TsTgUJWonwNdxUt3rrYagHlRE1AJH4qcPN28IN4sWw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OMSYLuBY3YfDtOkDs1Wd2+ABnyqkSActBmLynwtt6uW1OP/VD+RW3ErB69RZzpI0q
 5eg3SVeo8Mk7NwJ5A8xOU1vY2z6jpreiR8gtjvvtwoUCtoyl24P/GGFJ5qP1SbL8Nf
 axV9SkAofhvqLf7BiEtxeECzsdndRfYbFrJna8Lg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGR4M1846403
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:27 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:26 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGPks3582225;
 Fri, 12 Sep 2025 07:16:26 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 03/10] arm: armv8: mmu: export mmu_setup
Date: Fri, 12 Sep 2025 17:46:10 +0530
Message-ID: <20250912121618.1074054-4-anshuld@ti.com>
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

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
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
index 7f2a4e6260e..ea287ba1226 100644
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
2.51.0

