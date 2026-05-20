Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D517CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 02:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED796848B7;
	Wed, 20 May 2026 04:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ah4anI5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E4784868; Wed, 20 May 2026 04:52:12 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5078184874
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPxh3/WiyCc3NonFMZf1O06L0deB1f0iDeN5F4VBSDYwO8XgfDtRqBydJbpdGu/J2F7mr5iXwy703tUIHhpu3iTjxU5Cvz1xd0rq3zvQ/+LK+ICx7WwOVoCwfb77qAAmtCN4xaQdGU2tuFTrMBcQjxi0WhGCsq8yCz1rPVg6HliQ2AkihOeWQUqTgHHOwgOEdJQ03OSL/jZt94c8LJ7kMBVASdqy3XSKZTZ4h0GvEq7bj7rlBWGjFOPFjx1+Ev6zcJToZiEzhz7Rjq4C4we2m45WAkuoRchjaaEBOsetJKsIxZxnz9a1SzC3xXRPrv45tbiOR4k9yHYSqoICHw5/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg8BOPp86VBpo/5PMQRzKVr5djSqUzZmqmva7y24H9U=;
 b=CFd6AVFFjHpY/Fha57dGo0lfQVTyMlQwlpoxHwnhgI5meJ0WKYdP/yso+DMeIx2OlSpKY4Nn9dzGSjCw6SZC0/IMrSzR5yae8dh46gJ+sx/P5iUTRWdy0P5q6C6b44EIIg579OVkFsulRdvMGbqWcWlFDQLLjjyEjsCbTsXa7JHZABvjRbcsu9QtpGolu2VZCjLL5uwnoMANqGkVXKA2bboP+ijruZXvhjmctV2TKQTG4n96DiePg8eOIge4CMVXu8pvmGo1aj9TFR3s0iMjzsuxN3z6PxS2Vi+hxkQnJc+KYIk4bfX1CDSj3fh4UERqeOXtbX/k7cjDZPTvt2e50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg8BOPp86VBpo/5PMQRzKVr5djSqUzZmqmva7y24H9U=;
 b=Ah4anI5BuNjTtass6SrAFZ64lBuWD10rn0elb63+eUkV+KVyOqWkp9SAvNjTkQsHMr0VUvoqQ9XpT53ETrdQRAZ5LfevVAflXUrfCYHfQ/qoOcqbb5sOT5PVhDBfh4zOTdWNa15qkmzbjCh/X7DLnsNqKf+vsvq7GptBxzuEQPo=
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by PH8PR10MB997765.namprd10.prod.outlook.com (2603:10b6:510:39f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:52:07 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::c9) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 02:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:52:07 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:06 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 21:52:05 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K2q4q01099952;
 Tue, 19 May 2026 21:52:05 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 20 May 2026 08:21:49 +0530
Subject: [PATCH master v3 1/2] arm: armv8: mmu: move mmu enablement out of
 mmu_setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-am62_firewall_exception_fix-v3-1-9ca3dc40aea4@ti.com>
References: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
In-Reply-To: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779245522; l=2430;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=BxSVcdHYjSg/W/++FXJh9QTSaQpeHhOf2b85hMwKygI=;
 b=0OcBGprbjaQlN3hg5SWjjrUWad6G7BCmjzBqnflgmAxgqISWPzrlqy7sK0IqQrayAdZZpUKJn
 yva2oN74AToC0KFHHOX2aI6/91XG+jlkhDw0+cC1QK+7r+I12vsiUCl
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH8PR10MB997765:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d6bff-d854-4c84-7aaf-08deb61ac7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7l9aaYSGKn9svbvarojtRSK5+rquTvGO0TVe1d1Kd6HT7ApbIjBIJrFhJT+/vYU5+mgvzTVabGX2mjyHohgE6ql5TfAOZB4bj9lQlcBoncUISnJAl6U0P4JWoBPcmDGG9U4gqPTUrUeN24G5DZhPLyrPeVPJH6yLlZ6tPTAsSsShkzsT9+s4P4NQv3315jrSZTefdoYrILL5xkY6VixuwNBYESvycLssr5RIJee8RcamVB/senwXZX273NXVsqq0Qtdps8mLrKkXH9oDjsRr1VMEtA8I+0IKHnswQYOlPok1PAJ3WQSOoN4xfqaUCh+E1yIKqoP/O4l9Tg+XQRNGtON5DVye7BIggIoevrAAIhn6k7fEHr/3HX/piWeglga0brM2bcAfN/EjKIuX6TTInlsX0UJ+UMsMe0LS2Q+bvmVWGE0bDyFSuzoPHYKa3Ym3JesTyYnLKCRUY+QbPEle4WRRjeINrf6OBhGeMSaGVnFNkMct+3bQ70ygCOAqGuEaUsRnjOQ/DIoOdy8E9KxjZPonKSNe+OyENARRXzbW7rq2XZ4lsLTxgvU5NorhuVjTcrVF+y3/LbQaBOKTK7rtGjTgWK9LRnioUITfrcDTPeEHKgJvHaKqKi0aGmLmPpmKJ3Sqri1Rf60Htp1afs6+hwspfNzckloABCcQT4eAfX/7E0gKYe2CRN0zv3+dbw/fXbVvzjmtIVQEKvMX9pDmAzDK/3nAguzKdua2Lzvaops=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xq7zQlhImq13Lzo1Qc7oZKcTrGttSVZYUUeah67iJC/89rSg8cEkpcSWIDNxqp2YBxw4NhXvnkud7Zj276AyibXxV0XdZYdspKMdbuFlIBBntIgVoe0zfxXYMXMAG6aFMqmWVAps1iCoCXXyz+QXw9hQn/xzg22LZ9EYSZ9INijQ/AcJuMXWtstkjkfKz0iWhyLt4CWNFm3n0oMDKv9zFOf5UaACOLfMYd/ysy6nsZNbLBUqHFCRmQVCeufCGZtJlQbzOkZwuaqFopEH90GdtjcB/QEj1Y4qH1LWKkXwkNKLQvuDgZAP6lkBBKQJt5jKd/tT6BDXqGa5Ai2WrnJ5TTYsVbSwnkkfN2HQmT8cdOPckOLcJ61FYaZLLVAxstbYb8/WMue9JyZvb6/hZffgalQwfIj8XDf9mcorreUUaYV4WB1rY7wNT+5z3bcljNzQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:52:07.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d6bff-d854-4c84-7aaf-08deb61ac7db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997765
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

Currently mmu_setup for ARMv8 performs two functions, first it sets up
the page tables based the memory map provided by the board and then it
enables the MMU.

However for some platforms runtime fixes to the generated page tables
are required before the MMU can be enabled, such as K3 family of SoCs.

Therefore this patch moves the enablement of the MMU out of mmu_setup
and to a standalone mmu_enable function to give more granular control to
the platforms.

Note that no functional changes are intended from this patch.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/cpu/armv8/cache_v8.c    | 5 ++++-
 arch/arm/include/asm/armv8/mmu.h | 5 +++++
 arch/arm/mach-k3/common.c        | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21..7c0e3f6d055 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -810,8 +810,10 @@ __weak void mmu_setup(void)
 	el = current_el();
 	set_ttbr_tcr_mair(el, gd->arch.tlb_addr, get_tcr(NULL, NULL),
 			  MEMORY_ATTRIBUTES);
+}
 
-	/* enable the mmu */
+void mmu_enable(void)
+{
 	set_sctlr(get_sctlr() | CR_M);
 }
 
@@ -881,6 +883,7 @@ void dcache_enable(void)
 	if (!mmu_status()) {
 		__asm_invalidate_tlb_all();
 		mmu_setup();
+		mmu_enable();
 	}
 
 	/* Set up page tables only once (it is done also by mmu_setup()) */
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 8aa5f9721c4..5359b2ad87b 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -222,6 +222,11 @@ u64 get_tcr(u64 *pips, u64 *pva_bits);
  * mmu_setup() - Sets up the mmu page tables as per mem_map
  */
 void mmu_setup(void);
+
+/**
+ * mmu_enable() - Enable the MMU by setting 'M' bit in SCTLR register
+ */
+void mmu_enable(void);
 #endif
 
 #endif /* _ASM_ARMV8_MMU_H_ */
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b0a75988714..396018b7a7a 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -279,6 +279,7 @@ void enable_caches(void)
 		       __func__, fdt_strerror(ret));
 
 	mmu_setup();
+	mmu_enable();
 
 	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
 		ret = mmu_unmap_reserved_mem("tfa", true);

-- 
2.53.0

