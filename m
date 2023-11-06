Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F710C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE0587091;
	Mon,  6 Nov 2023 17:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fKAJPi+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B2E870A2; Mon,  6 Nov 2023 17:52:12 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1971E8701D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6Gq7Q8058171;
 Mon, 6 Nov 2023 10:52:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699289527;
 bh=DyAHkHkqtAbBevrKMWX1r63fZgaugFa3wwbogoFgNo8=;
 h=From:To:CC:Subject:Date;
 b=fKAJPi+D770BPa8LmKIPYBbz29WNCf0GL89dvb1vjcH2eNxOTp1qoirANqnqiNRRf
 wDEpKoZNKlXh6AfDv+N2lFLoSs4Rr7fnuHpjblesttZltTvqQizsRhw8L01kre3Rx+
 Vd+PQdkG+JJxJnOkitvaN6kG/46y5dh6dNgbZ46o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6Gq7Ms012837
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 10:52:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 10:52:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 10:52:07 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6Gq6T4091104; 
 Mon, 6 Nov 2023 10:52:07 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: mach-k3: Let the compiler size the mem_map lists
Date: Mon, 6 Nov 2023 10:52:05 -0600
Message-ID: <20231106165205.22066-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

NR_MMU_REGIONS is a copy/paste from another platform that extends
this list later. We do not do that, so let the list be the size
of the initializer list.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index f8087d2421e..471295fa7eb 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -14,11 +14,7 @@
 #include <asm/armv8/mmu.h>
 
 #ifdef CONFIG_SOC_K3_AM654
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
-
-/* ToDo: Add 64bit IO */
-struct mm_region am654_mem_map[NR_MMU_REGIONS] = {
+struct mm_region am654_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -69,11 +65,7 @@ struct mm_region *mem_map = am654_mem_map;
 #ifdef CONFIG_SOC_K3_J721E
 
 #ifdef CONFIG_TARGET_J721E_A72_EVM
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
-
-/* ToDo: Add 64bit IO */
-struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j721e_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -128,10 +120,7 @@ struct mm_region *mem_map = j721e_mem_map;
 #endif /* CONFIG_TARGET_J721E_A72_EVM */
 
 #ifdef CONFIG_TARGET_J7200_A72_EVM
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
-
-/* ToDo: Add 64bit IO */
-struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j7200_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -182,10 +171,7 @@ struct mm_region *mem_map = j7200_mem_map;
 #endif /* CONFIG_SOC_K3_J721E */
 
 #ifdef CONFIG_SOC_K3_J721S2
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 3)
-
-/* ToDo: Add 64bit IO */
-struct mm_region j721s2_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j721s2_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -224,11 +210,7 @@ struct mm_region *mem_map = j721s2_mem_map;
 
 #if defined(CONFIG_SOC_K3_AM625) || defined(CONFIG_SOC_K3_AM62A7)
 
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 4)
-
-/* ToDo: Add 64bit IO */
-struct mm_region am62_mem_map[NR_MMU_REGIONS] = {
+struct mm_region am62_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -273,11 +255,7 @@ struct mm_region *mem_map = am62_mem_map;
 
 #ifdef CONFIG_SOC_K3_AM642
 
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 4)
-
-/* ToDo: Add 64bit IO */
-struct mm_region am64_mem_map[NR_MMU_REGIONS] = {
+struct mm_region am64_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
-- 
2.39.2

