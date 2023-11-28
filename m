Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F7FC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9AD48777C;
	Tue, 28 Nov 2023 18:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KwHTRliJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887B6875BD; Tue, 28 Nov 2023 18:05:38 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9F1875FB
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5VCB104542;
 Tue, 28 Nov 2023 11:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701191131;
 bh=bwabuxGTrimE+p/UNjPmvW6Jf2NyeoB1I2xVaGQfwjk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KwHTRliJC5oBnXrjiEHfzF9rvSDs+SNMFWUzjgi5Eswt/vJENxMJrlHYb1OE1dNhl
 452Xr22QqnJSHYaLJAXQN3MQA3CUcvTKfkKl3trIGyViGjxnD8GLjnraz1jnTcMwu5
 R04GeT3YyFLSD8IDvtUbMfIgWVkN4CDMpd1AIZVE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASH5VWQ069316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 11:05:31 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 11:05:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 11:05:30 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5Tqd028109;
 Tue, 28 Nov 2023 11:05:30 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/4] arm: mach-k3: Let the compiler size the mem_map lists
Date: Tue, 28 Nov 2023 11:05:25 -0600
Message-ID: <20231128170528.407707-2-afd@ti.com>
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

NR_MMU_REGIONS is a copy/paste from another platform that extends
this list later. We do not do that, so let the list be the size
of the initializer list.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/arm64-mmu.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index e8db5332ae0..d872ed714c4 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -13,11 +13,7 @@
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
@@ -68,10 +64,7 @@ struct mm_region *mem_map = am654_mem_map;
 #ifdef CONFIG_SOC_K3_J721E
 
 #ifdef CONFIG_SOC_K3_J721E_J7200
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
-
-/* ToDo: Add 64bit IO */
-struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j7200_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -119,12 +112,7 @@ struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
 struct mm_region *mem_map = j7200_mem_map;
 
 #else /* CONFIG_SOC_K3_J721E_J7200 */
-
-/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
-#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
-
-/* ToDo: Add 64bit IO */
-struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
+struct mm_region j721e_mem_map[] = {
 	{
 		.virt = 0x0UL,
 		.phys = 0x0UL,
@@ -181,10 +169,7 @@ struct mm_region *mem_map = j721e_mem_map;
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
@@ -223,11 +208,7 @@ struct mm_region *mem_map = j721s2_mem_map;
 
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
@@ -272,11 +253,7 @@ struct mm_region *mem_map = am62_mem_map;
 
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

