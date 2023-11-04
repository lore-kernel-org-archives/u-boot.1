Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B260FC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65957874B9;
	Sat,  4 Nov 2023 08:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OszrVc1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B445786EC9; Sat,  4 Nov 2023 08:23:07 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6BA87137
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LsgC031805;
 Sat, 4 Nov 2023 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082514;
 bh=+OmgdZ+XEHuE+HQXdviUmeW57/g0bQYTiSzM2Aa3KB0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OszrVc1sH0ab3ScOeVwu3DmMw4wu+HZjtw81vjXyY5JbV4E4t/m/AX5FLV2E7br0T
 HNPhvLHypav8FOuwiJ6+NK7L5unZ5QQlyUTGvkQe604O+dHbOrGUXbn1uMSfy51q8f
 Ul3PDrb3KsyDgwEbppk4cBdunbnmtKAbi4mZkeLU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47Ls7C120805
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Lsc3065276;
 Sat, 4 Nov 2023 02:21:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 08/12] arm: mach-k3: arm64-mmu: Refactor to be independent
 of board
Date: Sat, 4 Nov 2023 02:21:46 -0500
Message-ID: <20231104072150.3339-9-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Refactor J721E J7200 definition to make this independent of board
macros.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index f8087d2421e7..8cb6614035a5 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -68,12 +68,11 @@ struct mm_region *mem_map = am654_mem_map;
 
 #ifdef CONFIG_SOC_K3_J721E
 
-#ifdef CONFIG_TARGET_J721E_A72_EVM
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
+#ifdef CONFIG_SOC_K3_J721E_J7200
+#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
 
 /* ToDo: Add 64bit IO */
-struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -90,13 +89,13 @@ struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
 	}, {
 		.virt = 0xa0000000UL,
 		.phys = 0xa0000000UL,
-		.size = 0x1bc00000UL,
+		.size = 0x04800000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
 			 PTE_BLOCK_NON_SHARE
 	}, {
-		.virt = 0xbbc00000UL,
-		.phys = 0xbbc00000UL,
-		.size = 0x44400000UL,
+		.virt = 0xa4800000UL,
+		.phys = 0xa4800000UL,
+		.size = 0x5b800000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -112,26 +111,21 @@ struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x4d80000000UL,
-		.phys = 0x4d80000000UL,
-		.size = 0x0002000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE
 	}, {
 		/* List terminator */
 		0,
 	}
 };
 
-struct mm_region *mem_map = j721e_mem_map;
-#endif /* CONFIG_TARGET_J721E_A72_EVM */
+struct mm_region *mem_map = j7200_mem_map;
 
-#ifdef CONFIG_TARGET_J7200_A72_EVM
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
+#else /* CONFIG_SOC_K3_J721E_J7200 */
+
+/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
+#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
 
 /* ToDo: Add 64bit IO */
-struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -148,13 +142,13 @@ struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
 	}, {
 		.virt = 0xa0000000UL,
 		.phys = 0xa0000000UL,
-		.size = 0x04800000UL,
+		.size = 0x1bc00000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
 			 PTE_BLOCK_NON_SHARE
 	}, {
-		.virt = 0xa4800000UL,
-		.phys = 0xa4800000UL,
-		.size = 0x5b800000UL,
+		.virt = 0xbbc00000UL,
+		.phys = 0xbbc00000UL,
+		.size = 0x44400000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -170,14 +164,20 @@ struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x4d80000000UL,
+		.phys = 0x4d80000000UL,
+		.size = 0x0002000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE
 	}, {
 		/* List terminator */
 		0,
 	}
 };
 
-struct mm_region *mem_map = j7200_mem_map;
-#endif /* CONFIG_TARGET_J7200_A72_EVM */
+struct mm_region *mem_map = j721e_mem_map;
+#endif /* CONFIG_SOC_K3_J721E_J7200 */
 
 #endif /* CONFIG_SOC_K3_J721E */
 
-- 
2.37.2

