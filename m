Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8F4C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25C88768B;
	Thu, 23 Nov 2023 18:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VVeGqZp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A965686BDB; Thu, 23 Nov 2023 18:22:24 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D6287620
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHMICq078111;
 Thu, 23 Nov 2023 11:22:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700760138;
 bh=X1v1dLoCWlvTvuZCpMEOJZZr1Tyf3UmkF4Tzcn+ESpg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VVeGqZp6JcUJSUH5IHZwlc+BNuwmyWD/BAFrxUUNNho6MqGgnVQKT/XehQ54zdldz
 Z8/puzb6do4z8pwbLGU0w0F3EIVIQ4aNUAK5uiPx3kEfwTgEoGypikNde50CRz7qsG
 JmFB87tvvwhSnyvw4cBFnfn0Y6kPzNWdCRYYlmrU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ANHMIOt129397
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Nov 2023 11:22:18 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 11:22:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 11:22:18 -0600
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHMFvZ114031;
 Thu, 23 Nov 2023 11:22:17 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/3] arm: mach-k3: Merge initial memory maps
Date: Thu, 23 Nov 2023 11:22:14 -0600
Message-ID: <20231123172214.653268-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123172214.653268-1-afd@ti.com>
References: <20231123172214.653268-1-afd@ti.com>
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

The Device vs Normal memory map is the same for all K3 SoCs. Merge
the SoC specific maps into one.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 197 +----------------------------------
 1 file changed, 2 insertions(+), 195 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index 97a029af13f..ccc4161be99 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -12,8 +12,7 @@
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 
-#ifdef CONFIG_SOC_K3_AM654
-struct mm_region am654_mem_map[] = {
+struct mm_region k3_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -46,196 +45,4 @@ struct mm_region am654_mem_map[] = {
 	}
 };
 
-struct mm_region *mem_map = am654_mem_map;
-#endif /* CONFIG_SOC_K3_AM654 */
-
-#ifdef CONFIG_SOC_K3_J721E
-
-#ifdef CONFIG_SOC_K3_J721E_J7200
-struct mm_region j7200_mem_map[] = {
-	{
-		.virt = 0x0UL,
-		.phys = 0x0UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x500000000UL,
-		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = j7200_mem_map;
-
-#else /* CONFIG_SOC_K3_J721E_J7200 */
-struct mm_region j721e_mem_map[] = {
-	{
-		.virt = 0x0UL,
-		.phys = 0x0UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x500000000UL,
-		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = j721e_mem_map;
-#endif /* CONFIG_SOC_K3_J721E_J7200 */
-
-#endif /* CONFIG_SOC_K3_J721E */
-
-#ifdef CONFIG_SOC_K3_J721S2
-struct mm_region j721s2_mem_map[] = {
-	{
-		.virt = 0x0UL,
-		.phys = 0x0UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x500000000UL,
-		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = j721s2_mem_map;
-
-#endif /* CONFIG_SOC_K3_J721S2 */
-
-#if defined(CONFIG_SOC_K3_AM625) || defined(CONFIG_SOC_K3_AM62A7)
-
-struct mm_region am62_mem_map[] = {
-	{
-		.virt = 0x0UL,
-		.phys = 0x0UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x500000000UL,
-		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = am62_mem_map;
-#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
-
-#ifdef CONFIG_SOC_K3_AM642
-
-struct mm_region am64_mem_map[] = {
-	{
-		.virt = 0x0UL,
-		.phys = 0x0UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x80000000UL,
-		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x880000000UL,
-		.phys = 0x880000000UL,
-		.size = 0x80000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0x500000000UL,
-		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		/* List terminator */
-		0,
-	}
-};
-
-struct mm_region *mem_map = am64_mem_map;
-#endif /* CONFIG_SOC_K3_AM642 */
+struct mm_region *mem_map = k3_mem_map;
-- 
2.39.2

