Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CDEC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0825687823;
	Tue,  9 Jan 2024 13:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jBJJSf/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE46807E2; Tue,  9 Jan 2024 09:45:59 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38E486FBF
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nsekhar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4098jsTD118104;
 Tue, 9 Jan 2024 02:45:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704789954;
 bh=6gIacyqrxfKpwhtQafPpCsg+GdM53MhMO0R4+rC24uA=;
 h=From:To:CC:Subject:Date;
 b=jBJJSf/+zm/kOovFbxh5tpM9a6aFTqVG2tFtU6sbMeKyjnOUtijGv+FiztANkxlMs
 tNNTYK1xutxF8+chucjApUMp1duQSvH+94vVE5pXIx9z8MNZqSqZRMSuKxSU0040ym
 TmQSlbZbGC1PBHRwqbie9g4EqlBnk6mdoRLyhn8I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4098jsaA031052
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 02:45:54 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 02:45:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 02:45:54 -0600
Received: from pxplinux063.india.ti.com (pxplinux063.india.englab.ti.com
 [172.24.238.35])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4098jqQC074460;
 Tue, 9 Jan 2024 02:45:52 -0600
From: Sekhar Nori <nsekhar@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: "Andrew F. Davis" <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] arch: mach-k3: Fix incorrect mapping of higher DDR addresses
 as device memory
Date: Tue, 9 Jan 2024 14:15:51 +0530
Message-ID: <20240109084551.21155-1-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Jan 2024 13:21:09 +0100
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

Entry for physical address 0x500000000 in memory map table for MMU
configuration is spilling over and inadvertently making DDR available at
higher address (above 4GB address space) get mapped as device memory
(nGnRnE).

Fix this by adjusting entry size. Tested on AM62A SK. Before this patch:

=> time crc32 0x881000000 0x20000000
crc32 for 881000000 ... 8a0ffffff ==> 7f34d7ca

time: 1 minutes, 14.716 seconds

After patch:

=> time crc32 0x881000000 0x20000000
crc32 for 881000000 ... 8a0ffffff ==> 7f34d7ca

time: 2.710 seconds

Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Applies to u-boot/next

 arch/arm/mach-k3/arm64-mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index b4308205b2..0e07b1b7ce 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -41,7 +41,7 @@ struct mm_region k3_mem_map[] = {
 	}, {
 		.virt = 0x500000000UL,
 		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
+		.size = 0x380000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.40.0

