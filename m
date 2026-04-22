Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EF8FA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF8C843AF;
	Wed, 22 Apr 2026 19:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sYj84r23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41D984370; Wed, 22 Apr 2026 19:10:08 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A80E8439F
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT8YQat6yKgcUHib8x2y+Be3JBMaSYwvTuHzwrTuoKqEVFtO4LQrIda4Grp6xBl8PbA/tGlMfaSA9ksq+mqAvEl/p14TgmtMjXdAFwWXhnJuj4f6e+FnKfKdAMleSASTEfUKd24FlmIHtqgYzAFfEift53l1/aIaOtk/CqtgjFcwXRVHMfu+NTqyloEf1PGSmR5x5XJFPZ+qSeoq3F7wkzy1m04A5W9xZONG01vQyfR/+PGNrBBVGzQJs/xZ0U6x/J6ztHx6XarEq9eATTnhf6NPwm6byMoTbjOXQXONI7ERK8aYBGmPSa9yYwuyKkPmYTBGzHOPLlG/TVd2gX75ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5cKaYWEXpJkj+DHzenphJ9FKgkoigICiqjvva2Nupk=;
 b=MUDsoeHPc7noyLlfq3TjzXbd9IJl0qYBDUnt5Z2nWBzmX1mKJKZa6AF/kZp1wr9o9rESAFnqXY9k+CVHe+vujwIwT0QFSscB+hxyJd2SqimLKL28DsuBt1suU1YOb6WX+AcDmo9DCzhpk+BxmWDSd2jAPG/f62fn61XUWSAiO2U8GNOZ81X50xeaX0lZCPaa9qSjmMACqwWtA9Xgdy7Xy8cxJZRhbO2vvSg+ot16fWFR8RK44Dr36CCUAKZVLNDhsk1WLES8qB0mKqoOom+jUpv19dwzHFK3+tTp0B9bDtgAAAd++u9zfUJ6gDm/ag0TXPGdMpiewTfDs+v3JgrPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cKaYWEXpJkj+DHzenphJ9FKgkoigICiqjvva2Nupk=;
 b=sYj84r23DOrZAt0mIgN0ASUM2qxL+5J3q6kZlD/tog6agCK/qTCtAaR4THHgQmtgn+GaWup3pMtHqExvO7rcX5X2iIKYWBzsw3lDTko8IZx9HPD/dRO4X6hRTxkjvZpN7FpDnyoRdvJZzOEZi7pJx8odHtIqcOw0UBLOX/Cl4zM=
Received: from DS7PR03CA0327.namprd03.prod.outlook.com (2603:10b6:8:2b::35) by
 CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.32; Wed, 22 Apr 2026 17:10:02 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::e1) by DS7PR03CA0327.outlook.office365.com
 (2603:10b6:8:2b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:10:01 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPO2769561;
 Wed, 22 Apr 2026 12:09:57 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 4/6] efi_selftest_memory: check for duplicates first
Date: Wed, 22 Apr 2026 12:09:44 -0500
Message-ID: <20260422170946.3394481-5-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422170946.3394481-1-rs@ti.com>
References: <20260422170946.3394481-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1ed73-d2b8-44ea-08f6-08dea091fdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wk7uY9cIkR5dYG42SOPCGtn3+2ybi8r/4yUgUUKSpXBmXUC5Cvg3H5fJRNpLoz4FUFoR0U0XK5QPP/swrzRK2pj80fXSUC4ZH10WWHOLWLA8bwFq3XgOzsvHOx/jL+3T5tEN6y69xS+0D+AxafHdOSrptdQV6qzl1fDfh1vNy7r9fp4Wt935YfCQrxhUybg4SDGySO6C0cjaLqiTc47tPboEBijMuO5qp2ZGrEcdmxsgdCOFK25Yg6qOMzG40m/1lRM+NTq79P1nX6JvBDXwc0P4I+MWU+lpHQYrybNHki6aeQPths2EC2Nttnt/JhWg5iCYSaY3awQX4tVt23HKq0ObRrDchudKX9FFOySyqWjpdO6uKF4/rDlLctrU4SKsQh+GcirBQBdLhYEY4YieGyLyVZ3BUIvHB81T9FtFbv4RJ1Mf4eDpQBGhhPvfwqZzlEkgFsB0q75dO3/yxvEsz9AFBhqMKYVyQLwVe6TQfIIRYuMInNlBVm5bNcmNH+rtrz+5/RCxWXJ7ufXZDRop6KYHo7i+Wx3cdIwF6vE2H7nTa3JNhGFQ37JcICD3vnMJhMOE2aPIgsajVYouatMKWIJ0yJONQqFegCTPkUNKBtPRPgMPBlTcfKXzs9gndWrtjWHPa5+Qjha5R2jqhBWx0WzpfxRsIK7O+Aa6clLVRORU0GgBZZiFS26HWz0KZ3FYPf0MULbWn5jtSjZKPs+g9O+1ED9JPi1dVBl/Q2TNdDnD41MT58x9kLJ7pIrupc1W22HHRiXRKRs223K1Z3EP7w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MFdcBMShbChfpFATZiVyi4dXxwfAQZyYJcFRSjzwVt8tfqNYPOm0ClSrehbSAG4PhLURODLrsqrMCEwv1KAW1GtmTYdUxT6xnc6Pql7E2l9Yw4tzX/Q2qvhBfzRp2hVYwFLOPMruNodyaR/RN20tBx6a+xH2b5AKNMDlr3bAvxbve0A63Bux8QUdeEtjajXX1BdMb0adVukggMJrO8JQ0wVH4X5AU0wjwNDn/x6bBccyiPmkAfZ1NRTYbWTObUcP66ykuh6f9OsY8F+o2G70sp2+ImgYgbw/ozqlTr/Yq7vYaFjALq8XPlEANPsftC/zlE2+tWyhJxEfcjoC6mkIa9vzs94tcA9IjUVOtXeWXfcFO8MPFxKydGDSUp7x+uopuCJ22FRmJ4T/M7wSQqghkOMWfVm0ehs1axhShuTraObjeKRkozhifFexAzDzQQCB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:10:01.9814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1ed73-d2b8-44ea-08f6-08dea091fdb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
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

