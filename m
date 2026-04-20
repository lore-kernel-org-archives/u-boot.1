Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827A4F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B332A84394;
	Mon, 20 Apr 2026 21:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NT0m+ZMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA68A84376; Mon, 20 Apr 2026 21:25:31 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E828E84319
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6SA/U15tf5ETBpLFTHsc3fRQPYskuGURPgI7vtZGIty5yxIgdvWIH1xIKE0NNGqOHHkabUMeAUpW3SLQ71lSIOoq933JIIStRF4DIoKeX+OmOhCA1662mx23vLilcdZL36zzi0I6YVdb5p3/Xvw1lbisXvL6LB1BthTYeeF4ZstJSuolFxo6y8Z5DgAYbSEN4Qx1D42B1qgOPue3nWS+jb6YJTPFC/kIZdiXv73/2og9br5BUAXdlTAW+QN2IeypmDOQO6dBSD6mDEPlxOnpNohtWc652MTr+zcJrA5HO0bbyZCgQ7s/3XnzS0EKSWesVCs6eYDQDUaG2hLtZ4TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5cKaYWEXpJkj+DHzenphJ9FKgkoigICiqjvva2Nupk=;
 b=Yi1SkXhLRn68Wo1+ZW3o78eNc6XUMgJzlARBDUgGfZhrPUAPD7JX0Rultx3N1lMO9aViJmg3xPOfg54kQXByKq3sGq9YbSUpGdNZLhQniXM7WFjp0wX/r+KtF+ukGQgu2A+FFK92z4I+zFBaHbK8dxrOp7VFK0vvSFkTHeI/mNuZ8g0wS9B69NwJm79E0XQBZg0IkqAgfPkRqYnVxyPmpixcQJba27b7TFAWkk6quPL7uwST5Tnw+gCG+CtKcJLHxm8kj/C5JEXWKvFfAFkaeOrC/FL36pHji3wst8CDScZGeBnAp435u+s+ixWtwdxXgnRLWjexDgbNodiu4Vu3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cKaYWEXpJkj+DHzenphJ9FKgkoigICiqjvva2Nupk=;
 b=NT0m+ZMr7Y4SG/6ipLpHZu7WwN3UXXSNuXde5kHJRq9IuC+r+JRJ0INL5QtWHuLHEupSHK5vqELBirTJJHZOImhSt5/tN3z6oZO5BV+ydzLozhRFFwmY1OkN0P8Igrd07vTTt/jHbBc49lfuLYxac55VS3fKQ3GRPc2zlLow/TI=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 19:25:25 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::b0) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 19:25:25 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh73399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 4/6] efi_selftest_memory: check for duplicates first
Date: Mon, 20 Apr 2026 14:25:18 -0500
Message-ID: <20260420192520.1444749-5-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420192520.1444749-1-rs@ti.com>
References: <20260420192520.1444749-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db252f5-9fdb-49a1-3bf2-08de9f1292bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GkakkK6cF49auu1lNNtwNJWeN0/jMOtOtARA9iveUnC/REK78CcgrxnnhJ4DlRC0S8kVr2P/Jj+w9AGy0LUpvzhF5f6Nr6yPrdtgpkFrnOk4ilreK76Po8GhXoZwOs1h9+ltNtGqeBw1T4LNaxURKOdmOb/9P5jrQ1V0aYxflBuK9dlay5N/h7cizR0d3rw6KA1SeWnPia2JhPi3JVb+0oXbQRAcxL21WromnOzHxkrq9HahXoZBahx/a//uP6fgnv6+hMXxjPsFva+6HpQAsgOJ+m7Q8jvCvPLzQeyfYGd0DFkSV+JXINyZrIhk0FnKHJD6PabiF9xvSZ/j/SBdPG4UEqZEA+XKx3KzZHxMTrgURYoTi1FHKn5A3/ReFU0Y7Os5d/eJkDaXu1ZWZzpmaM+NSXummP/TFQkr6s4NYEfwzscv+1pcexynL7yyyjtOH2HPqKB52uCefvJRFypj5JWrr1dRTTGEQywQ15nI4i695God82KjedYkdwvUuCpOwKRdQecl1IBmnouFVYuuRD9JCl6/wDOStkgy2WdQ9Zhv7CRV26OwABzfD+2JZT96kDN2Bvui9TlGu0eEYrrrgJgOEygIXXYcRINZ7w/ihwgjQ0benUiJzfTUTnGGgYCdcjUKIEaXuAYO6nhVDCl2F2rBau8dGL8ef8GzW+CBHK1fT+OEh1MqzVUVKQIoJboG139ovLeyAufIUj2p14e6N0IKNwB9nFmJdCEg2N7cvXQsSq6TmsunS+iEYjvc1tLaLNW8NcUvr2VCtHaytHvr6w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DNr+iD2XjEnwuaUz8E8bFQwHFskjLj7liQ3U2OK7rneqlZ+LzDra/EN0KoYRDZHwuZwiJtwi4JGBIFn7kuhRUV38LMpLfDGX9S890t3PDsd0/ga43vcXsUQoFMsSRhjM0zAnJb02vFR7NuBRMHWO75adpe42DvXYsqgRZ5Q6dxH0YSxcQpBzhtzYdxO5eVzIbMLIecmb1r1AFhUzQyVZ2pTXssO6ueq8YZ+oJIQXBxlhdqKwBOgOZyDVzOoUA8kiFnEE+mAmv84Q0Xpk4FZ8HT54P2JOtRSt0uftVkUEkeHYMbzitWo4E4sNYmykUogNprOm2HwIWzD+MAwxYzXpA29sZ698NMl46O1K4FO2mRdIgm+O8RatSlA84qKRJobu6AAUu9Yp8NS6j84JmS9pa8pry/hS6LZRZsjc2en4DJv1vDsbqH7Gpi9fsAoCX9Mi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:25.1881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db252f5-9fdb-49a1-3bf2-08de9f1292bc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
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

From: Randolph Sapp <rs@ti.com>

Check for duplicate memory mappings before reporting any incorrect
attributes. Could be that second allocation has the correct type while
the first doesn't. Knowing there is a duplicate in this scenario is
more helpful than just reporting the first mismatch.

Signed-off-by: Randolph Sapp <rs@ti.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 lib/efi_selftest/efi_selftest_memory.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/efi_selftest_memory.c
index 4d32a280061..7320964c129 100644
--- a/lib/efi_selftest/efi_selftest_memory.c
+++ b/lib/efi_selftest/efi_selftest_memory.c
@@ -60,7 +60,7 @@ static int find_in_memory_map(efi_uintn_t map_size,
 			      u64 addr, int memory_type)
 {
 	efi_uintn_t i;
-	bool found = false;
+	struct efi_mem_desc *match = NULL;
 
 	for (i = 0; map_size; ++i, map_size -= desc_size) {
 		struct efi_mem_desc *entry = &memory_map[i];
@@ -72,24 +72,23 @@ static int find_in_memory_map(efi_uintn_t map_size,
 
 		if (addr >= entry->physical_start &&
 		    addr < entry->physical_start +
-			    (entry->num_pages << EFI_PAGE_SHIFT)) {
-			if (found) {
+				    (entry->num_pages << EFI_PAGE_SHIFT)) {
+			if (match) {
 				efi_st_error("Duplicate memory map entry\n");
 				return EFI_ST_FAILURE;
 			}
-			found = true;
-			if (memory_type != entry->type) {
-				efi_st_error
-					("Wrong memory type %d, expected %d\n",
-					 entry->type, memory_type);
-				return EFI_ST_FAILURE;
-			}
+			match = entry;
 		}
 	}
-	if (!found) {
+	if (!match) {
 		efi_st_error("Missing memory map entry\n");
 		return EFI_ST_FAILURE;
 	}
+	if (memory_type != match->type) {
+		efi_st_error("Wrong memory type %d, expected %d\n", match->type,
+			     memory_type);
+		return EFI_ST_FAILURE;
+	}
 	return EFI_ST_SUCCESS;
 }
 
-- 
2.53.0

