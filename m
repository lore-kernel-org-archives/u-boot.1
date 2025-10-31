Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE3DCCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36682839D7;
	Fri, 31 Oct 2025 17:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T4os9VA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F14839FA; Fri, 31 Oct 2025 17:18:04 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazhn150120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d900::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B8D839B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maPuRzeDCl388aIr/Ulj97nvLwZZ6qyLCTV6Hm0yscn5oK2QNlrsh/IqQpSEMRg/qFIOKs81XAdyo+jhHyg+QAPZskAS56BJ4xJdG6vacDM/M6Q6Dt17IOEXhsIV98byPi8ScZX5A8k9uEmw0WhAOZBN1HLkwZL3F2u0tisktgyLlBuXOUzn+eSyWX2W2QlwxNyLzsZiRs0CwZ6udukORCklhEzkVMX/gco81GksFpt5Ao8YKRQ2Z422+FtNGwFXtFZdxn7wM4r5SGftQPWLgp7zILmfwlBw+Ad74nANI+dhGT2eR0eUdawGSK05XaHsUHmdoFHyMnhqQDnk9xOv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnwpk491EubRPjvk5e7t/300EXkXlRt220xmaomUGrI=;
 b=n55X3Kss6Dq2TlG1Jbc5Je3mzjbKF+TfgmbY72iljUfGJBeroXg3rqTBQSxDvcf21uQg7mHEapWDFEOqSbO6GtP/HU9QW6zPKebyEDxekraWWCS+Noj6wAf5W3OYAN+6wrOctKkNn8neMLmGNimQVPcsVAOepsWsq1JHe9zhnmzgb+VFxfXGKn3igybvUG5XwKGMjfyiB0TAHLQfsfu1kPn3ts7ZTjCfXQMyq6PvWvc3GE2MBxQGWlMWk5quTMUnp1s/w86Ag2M1yFg97cy69Pk2DtamRCwX8QUxJtoHisbpOxq5jSlXvoCz84URRUowzjivZol6AMwAQ9EdOoj6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnwpk491EubRPjvk5e7t/300EXkXlRt220xmaomUGrI=;
 b=T4os9VA5d5XWEbgi+ANKju0tPLdGxvT9CjmPFBsu1U2QdRZvciYHjhk0xGePpcXiOs1nJUtl3Td61SATDa/GErf0XN0EBcPs4eyatYwLrDTWPCqi1dOYb3Ug4LN91ySoJ/QzbTI5uQryqkwgsfUtq+f+rhKro6PRMapKkeqC4EQ=
Received: from MN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:530::14)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:17:55 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::ba) by MN0PR02CA0016.outlook.office365.com
 (2603:10b6:208:530::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 16:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 16:17:53 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 11:17:36 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 11:17:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 11:17:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VGHZKt4186149;
 Fri, 31 Oct 2025 11:17:35 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 31 Oct 2025 21:47:31 +0530
Subject: [PATCH] arm: armv8: mmu: fix mem_map_from_dram_banks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-k3_fix_mmu-v1-1-3f3cb6f8b3dd@ti.com>
X-B4-Tracking: v=1; b=H4sIABrhBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3Wzj+LTMivjc3FLdpBQzI0sLi1QglaIE1FBQlAqUAhsWHVtbCwC
 gvA3wXAAAAA==
X-Change-ID: 20251031-k3_fix_mmu-bd62988ed62d
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, Casey Connolly
 <casey.connolly@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Neha Malcom Francis
 <n-francis@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, Francesco Dolcini
 <francesco@dolcini.it>, Emanuele Ghidoli <ghidoliemanuele@gmail.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761927454; l=1974;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=Mf4JUW92EVtxKTWXigZB/tkVpWfIfIiUZAPKWJxKxAs=;
 b=gEYvw84BvDNkSufP3ucMZWGWc/3vV9OfNR6RtTQNTwwMcFcBkAIboUOZUriHVIPJWpOIbi168
 UpqlxQxI8fvAlJsJtburmO1hGr2B3kaNKnboXUrpTIpUd3SGsa6zzkt
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dd5711-e7e3-401e-7f08-08de18990bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|34020700016|376014|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qkx2ZnF4anFRZ0krVTliV0tkZmordWxhQlYrR0w4ZkVxSGRTNWtJVFRmQVFq?=
 =?utf-8?B?dlBaaFJ3NlZLcVQ0Q3ZGZGwyckJXM3FnOEljS3dCMnFoRkVjQXpQQkNFZW8z?=
 =?utf-8?B?cmFqdURueFlUTjNsSGxCSTBsMWgrWFhTZjdqZ0gwcVFVTFpxUGIrM1FQR1Bz?=
 =?utf-8?B?T2wycW9zTG9jSDhvNDNSdGE1ZmhGU2dVRjhCWW54SDFVRkpwYlFkclp3MytV?=
 =?utf-8?B?cHZ4aFk1YVF0c1hmM0dTWnE0NDI4eldJNkNnbitHclZ2UjdRL2RsbExna2wz?=
 =?utf-8?B?QU94anRScmpqNzhKSld2U1hKTEFPYzZyUnJpMEFiRnBYMSswVmloVFI2KzNp?=
 =?utf-8?B?SzltbE9QZ3R4TzBYYmprTU5oU1pXZUE3cmd3N1JkckZTV09zZEdueDhPZjJq?=
 =?utf-8?B?VXRBZFpBMWN5YXBJT2hwZStuQTdLb29ma2piR1BHYmRrZWoraEFyaXhUYUlP?=
 =?utf-8?B?V05Mcmtoc012bU1FU2xBbVZaMWh0R2liUjZtK29Za3FJYzg5eDZIV3pOZWcr?=
 =?utf-8?B?S2Z3dkdZL05qMXpDdVVqRG54cG5LQ0xDOHZGN3ZoV1FqaDJDdlovNTBHVWVt?=
 =?utf-8?B?ZG5xMmZXNzQ2eGVkMVJrZVRlMUp4NkZHRTNIRERuNWFTYkg1eWIrU3FsNGVW?=
 =?utf-8?B?US9vM0ZXQUorUDF2SmdXNXpGaUFHeTlxYlpsd25oT0o0V0xvM3ZndnltVkVK?=
 =?utf-8?B?TVB1U0xuMjlCMDBpRXZPODgwSkNveGpzK3V1VHZ2Z1ZxMnlCdGN4MkwreU1I?=
 =?utf-8?B?Q3QydkdRMlowMlQ2Slo3SldiVkxFNWp0a3RHVS9zajlqY0kxTGtEaG5KQXc4?=
 =?utf-8?B?OHdmb3VleFdzMUk5TUMyd3FKemczbEhlMm9yR3VlenBCSWlKbk1DOVZMYTU3?=
 =?utf-8?B?eGQxT25YVnhBd2lXYVM5c2ZHZW1JTWtvMDB5T1FJL3JLNDArMXp4czFwaVBp?=
 =?utf-8?B?WGNZUGp1K0tXN1VwaWxUbWJxMURPZllaL1pGQTNYWFUvbU5PUUtGbmZmVGM3?=
 =?utf-8?B?ek5kcHg2NUd5dXNpTVI3cHgxdUJpL1h1cHhQOFhSSXpDUzhkOEZRMkszcHRX?=
 =?utf-8?B?akc2QXFvanZoVHllbklPM0w5UFFVSWwzYUR5aGpOK1JoTFlhWlFEb29qbzJh?=
 =?utf-8?B?a0V0bTFmOExBZFM5Sms3L3dzaG5jUmZlcjdFV0NPYTZNLzVFRlI2bXZZdXN6?=
 =?utf-8?B?ck9leTY5TjdkMWo0TkZVTHJLREIwaENYRHlSOVU4WmFWNWQvSVNveDdadEN0?=
 =?utf-8?B?VGRJampxNEtXaVU0RFF3dlBXdVpUT0NDZmNBZ0Zod2xuRVo2TGhDNG5XbmlR?=
 =?utf-8?B?UkYyVFVLNXdSUGxTcVBkc3FaSUFlQit2UnV2aDBPYTZRN0NlQndvYlRpdEl1?=
 =?utf-8?B?YitxT0hJNDF3NmdicldMY1cwSndlOXBvZDhVTDlIY0ppRG1wdlJROXlCRUxZ?=
 =?utf-8?B?dGdDRSt2S2JZN1VuN04ybmRXei81R0xhRGpzMmlTV3dXd00yNnhJQWJPdnE2?=
 =?utf-8?B?aDlXVWoyMXFYMVMrc2dQNXQvRW9oS2tUVXY2emMrMThyRVZJV3hNWXNiVTBy?=
 =?utf-8?B?cXBYNU1JUE9nOWlPMjN6YTVZMEhSK2JSUWkxeTJjMnpGV2RSbmlHSTZubDJh?=
 =?utf-8?B?aXlldU5UeHZoSktVcC8vamhqcUZvSlFIazdXTFpUUU5nTzU0NUwzTmg2Q0Q2?=
 =?utf-8?B?OG5HSm1OY1RwdXE2clZ0ekJYMHlZa2I3TjF0WGFkdDVxTFdZMThqMVlTa3JU?=
 =?utf-8?B?cm83UVY4TnF4RzhYQVJ2SFFDMmRDYWEzdk5kZjllOWJubWIxL1EwTkdFVlZ3?=
 =?utf-8?B?cFhyZHRNS0psWnpyZzJEYW52RUhxaHZBQ0dRL3lIdEltZ1ZueU1JcHN1Vm5V?=
 =?utf-8?B?cmRHdmMySlVZOE8wSFpNblZBdWo0clZoQUJUREZHVzQ2a2x2MmR0Q0xYdEhu?=
 =?utf-8?B?b0ZjYUhvbC9PRzlXQ2ZXYmcrdXJSTEtvQit6aTdURjZ3bmdLUi94Q2lCbHVZ?=
 =?utf-8?B?V0RkczRRYU1SSUpSZElhM1pIWFVibTZLZG9MblpwR3plT2Y2SExPeC9paGZq?=
 =?utf-8?B?L2QzQVJieEZYQlFXc3ZiWlI5SEVKc3plODlWYXg1VkI0a3NzR014ZnRlYmFp?=
 =?utf-8?Q?t5+I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(34020700016)(376014)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:17:53.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dd5711-e7e3-401e-7f08-08de18990bc2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
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

mem_map_from_dram_banks calls fdtdec_setup_memory_banksize to setup the
dram banks though that is expected to be done by dram_init_banksize as
part of board_r sequence.

This has the side effect of modifying gd->bd->bi_dram as well, therefore
this patch removes the call and updates spl_enable_cache for K3 to call
dram_init_banksize.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/u-boot/20251027165225.GA71553@francesco-nb/
Fixes: fe2647f2a0d4 ("arm: armv8: mmu: add mem_map_from_dram_banks")
---
 arch/arm/cpu/armv8/cache_v8.c | 6 ------
 arch/arm/mach-k3/common.c     | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 672ec16d4834be501d5bfa343af9537aa9285252..0309da6d3971af6f2a349ce0760507765da9af4f 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -61,12 +61,6 @@ static int get_effective_el(void)
 int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 attrs)
 {
 	unsigned int i;
-	int ret = fdtdec_setup_memory_banksize();
-
-	if (ret) {
-		log_err("%s: Failed to setup dram banks\n", __func__);
-		return ret;
-	}
 
 	if (index + CONFIG_NR_DRAM_BANKS >= len) {
 		log_err("%s: Provided mem_map array has insufficient size for DRAM entries\n",
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 7c06764af8256b7fd27f8e7f208a597b1b91652b..82a31b5178b9b5abdf7eae68cbbd22fe2a86dbee 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -311,6 +311,7 @@ void spl_enable_cache(void)
 	int ret = 0;
 
 	dram_init();
+	dram_init_banksize();
 
 	/* reserve TLB table */
 	gd->arch.tlb_size = PGTABLE_SIZE;

---
base-commit: 08bf42e1faa4411cd347c2e370da790a0116e318
change-id: 20251031-k3_fix_mmu-bd62988ed62d

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

