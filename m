Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963BBC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5BB875BD;
	Tue, 28 Nov 2023 18:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZOm1rvnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8042B8777C; Tue, 28 Nov 2023 18:05:37 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57688870D2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5V1m112042;
 Tue, 28 Nov 2023 11:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701191131;
 bh=JoRnrUr4cXkZCM4L66/UPleAWnl/2C9RjLBifh4h16A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZOm1rvnbstwHnlb7XHk5f0NKFmE0RFhsJU1VSt4eES6WLQ/4pZIRz6hD6CeZya0sU
 90Z9ztCHdJYlsK5k1NjBKY9luLVhlIq4NtkqD1PfKXbzDkbVBxM3Gkkf2XvxG2vv26
 jjU7bYslKSrLAuzeY9h1Y396b8JFxGlErBgp4ORU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASH5VY7002578
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 11:05:31 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 11:05:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 11:05:31 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5Tqe028109;
 Tue, 28 Nov 2023 11:05:30 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/4] arm: mach-k3: Do not map ATF and OPTEE regions in MMU
Date: Tue, 28 Nov 2023 11:05:26 -0600
Message-ID: <20231128170528.407707-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128170528.407707-1-afd@ti.com>
References: <20231128170528.407707-1-afd@ti.com>
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

ATF and OPTEE regions may be firewalled from non-secure entities. To
prevent access to this area we leave a hole there in the MMU map. This
is the same idea as [0] but we complete that patch by adding the same
for AM65, J721e, J7200, and J721s2 here.

[0] commit 0688ff3ae23c ("arm: mach-k3: arm64-mmu: do not map ATF and OPTEE regions in A53 MMU")

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index d872ed714c4..5c858ae0f84 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -24,7 +24,7 @@ struct mm_region am654_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
+		.size = 0x1e780000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -75,7 +75,7 @@ struct mm_region j7200_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
+		.size = 0x1e780000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -123,7 +123,7 @@ struct mm_region j721e_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x20000000UL,
+		.size = 0x1e780000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
@@ -180,7 +180,13 @@ struct mm_region j721s2_mem_map[] = {
 	}, {
 		.virt = 0x80000000UL,
 		.phys = 0x80000000UL,
-		.size = 0x80000000UL,
+		.size = 0x1e780000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		.virt = 0xa0000000UL,
+		.phys = 0xa0000000UL,
+		.size = 0x60000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_INNER_SHARE
 	}, {
-- 
2.39.2

