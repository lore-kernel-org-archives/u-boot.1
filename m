Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9067BC61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 15:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81994875B2;
	Wed, 22 Nov 2023 16:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yn+59pxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2C086FB5; Wed, 22 Nov 2023 16:14:20 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796C3875D6
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 16:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFEETS026800;
 Wed, 22 Nov 2023 09:14:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700666054;
 bh=rLaA3ukXSIAmwAoKMH866xHjBmdA7/DULzikeDiLdwA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yn+59pxzhjZfL3t+nmZLshlOOo3xUPmHUcKEELviKfkGNVC+ricuepw2b7I/Uiv+N
 uY9yGi20AOfGmXsmzXJQHaBL5iJToKWMjBexHb7+/YUtkDS1IxyLjqOGvv138Z/rbL
 SbGmD/IkMYGX8wx0UBNH1j5cKg3fE7RA3myVb9Fk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFEEoC122428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 09:14:14 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:14:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:14:13 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFECHD015190;
 Wed, 22 Nov 2023 09:14:13 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 1/2] arm: mach-k3: Remove non-cached memory map areas
Date: Wed, 22 Nov 2023 09:14:10 -0600
Message-ID: <20231122151411.11268-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122151411.11268-1-afd@ti.com>
References: <20231122151411.11268-1-afd@ti.com>
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

All normal memory areas should be mapped as such.

We added these un-cached holes in our memory map to hack around the
remoteproc driver missing the proper cache maintenance operations.

The problem is having these non-cached memory map areas causes stability
issues later in system operation due to the nature of the K3 coherency
architecture. Plus these are board specific carveouts and instead
should have been added at the board level, not here in the SoC common
code area.

Remove these non-cached memory map areas.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 48 +++---------------------------------
 1 file changed, 3 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index 471295fa7eb..a5afdf9f4a7 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -25,19 +25,7 @@ struct mm_region am654_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL,
-		.phys = 0xa0000000UL,
-		.size = 0x02100000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa2100000UL,
-		.phys = 0xa2100000UL,
-		.size = 0x5df00000UL,
+		.size = 0x80000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -76,19 +64,7 @@ struct mm_region j721e_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL,
-		.phys = 0xa0000000UL,
-		.size = 0x1bc00000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_NON_SHARE
-	}, {
-		.virt = 0xbbc00000UL,
-		.phys = 0xbbc00000UL,
-		.size = 0x44400000UL,
+		.size = 0x80000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -104,12 +80,6 @@ struct mm_region j721e_mem_map[] = {
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
@@ -131,19 +101,7 @@ struct mm_region j7200_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xa0000000UL,
-		.phys = 0xa0000000UL,
-		.size = 0x04800000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
-			 PTE_BLOCK_NON_SHARE
-	}, {
-		.virt = 0xa4800000UL,
-		.phys = 0xa4800000UL,
-		.size = 0x5b800000UL,
+		.size = 0x80000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
-- 
2.39.2

