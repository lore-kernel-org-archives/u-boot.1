Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7DDC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3803382F6A;
	Thu,  3 Jul 2025 15:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ecsmq2KN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D23822D7; Thu,  3 Jul 2025 15:36:25 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A4B9822D7
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563DaKiO018333;
 Thu, 3 Jul 2025 08:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751549780;
 bh=gosWcJEindAkKPM1i3Kx1nU/0jjB6CocYfesVXe7tIQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ecsmq2KN+tmcz+Ww1P2369nrXraDqa2NEfKzZZAMSE3WP4En1eEiTh3C7WjjwktEU
 roA2Br8Vi8OAuYINm1AtAY0Uw/U+FsUJKcFKP8qH05a0hapSrIXXt1aEHy75Be8VgR
 U91uWJoAmMJO6f3r0fP/3pKGzdCkJeNM/UBEI2F4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563DaKFB1876398
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:36:20 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:36:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:36:19 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563DaIeg1191855;
 Thu, 3 Jul 2025 08:36:19 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 1/4] mach-k3: use minimal MMU table for all k3
Date: Thu, 3 Jul 2025 19:05:26 +0530
Message-ID: <20250703133533.104758-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703133533.104758-1-anshuld@ti.com>
References: <20250703133533.104758-1-anshuld@ti.com>
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

This patch replaces the existing MMU table with a minimal bootable table
(at least till SPL) that could be modified at runtime as per the
device-tree and the CONFIG_K3_*_LOAD_ADDR.

The 128MiB region starting from SPL_TEXT_BASE is mapped for use by the
A-core SPL. 128MiB provides enough space for future use cases such as
falcon boot from the A-Core SPL etc.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c | 38 ++++++++++++------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 0e07b1b7ce0..5c29df4fe6f 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -12,41 +12,33 @@
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 
-struct mm_region k3_mem_map[] = {
-	{
+/* We need extra 5 entries for:
+ * SoC peripherals, flash, atf-carveout, tee-carveout and the sentinel value.
+ */
+#define K3_MMU_REGIONS_COUNT ((CONFIG_NR_DRAM_BANKS) + 5)
+
+struct mm_region k3_mem_map[K3_MMU_REGIONS_COUNT] = {
+	{ /* SoC Peripherals */
 		.virt = 0x0UL,
 		.phys = 0x0UL,
 		.size = 0x80000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x1e780000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL,
-		.phys = 0xa0000000UL,
-		.size = 0x60000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
+	}, { /* Flash peripherals */
 		.virt = 0x500000000UL,
 		.phys = 0x500000000UL,
 		.size = 0x380000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
+	}, { /* Map SPL load region and the next 128MiB as cacheable */
+		.virt = CONFIG_SPL_TEXT_BASE,
+		.phys = CONFIG_SPL_TEXT_BASE,
+		.size = SZ_128M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, { /* List terminator */
 		0,
 	}
 };
-- 
2.49.0

