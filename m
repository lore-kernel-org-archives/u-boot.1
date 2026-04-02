Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6073ED6AB14
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9AA840F1;
	Thu,  2 Apr 2026 22:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GdtTrRND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1723584020; Thu,  2 Apr 2026 22:51:26 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993CD840D8
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+ZZ04euihWXYzxaLHjjWJ2XBMK0DAzSSEBVptude+kayVisEKqGYmJZhU/80Qy6Ez+md5QJduTPm3Mvuj/jHDcST/0bOM01h6nwrw1iBT2pgezgZxIUwJdjSMIe4v5cMR07diGOAV2szhcjnO2L0hIy3Ue7JSzamZWwphji9dhup6VWNTQ1YzWGja3TLHHLClevc8r390mSLjEkUyoZ++5rZm1YVubTbiBdfiKg9J8n17gBHim8N6EhB08VzAXaHm0UbxA5Cr4oMkUKI5NNZ9/cbMO3CQxa2NDO87AsBKqqRtKIhClzJgvYq/N5scH/8zdRWi7XaqUSV9lSXTBrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYCbEfccR9KumyEVLzxrTn+DliG7HK0gMTROxuo/zLs=;
 b=SBz9NgCdfcoxqi55z5MfF96bHOhxkK+tdBwKFmplbZbcqgwS6Ox+1rVOrigFsfqAWXHVRXR24Lmy/f1KMGIi5QFJ0jHt8pYeb5BqRxtvZ4NM/AnFV/AgOkwyyeA8AAkUmSghcyCLBAecr9rK3Z/57U2edQ7zgTEnpuI+g3bGMqFuiUlK/IAYqoQyzUhHVun0mspC+Sc6cNEWKHjtREUq+bgmCurUMG1lVTdBu6Nb/mrwuFCyNeiA52DB2UjwfAxL50GaND3xt7I+R2gqDfNs+rkSw3DF/r3fuEtbe3xTnF3Vr8G0wjS+b/5M0PL5hOktRPyzsLjIxrPGddEhhX3AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYCbEfccR9KumyEVLzxrTn+DliG7HK0gMTROxuo/zLs=;
 b=GdtTrRNDVoVuPVtZlV/RkttnkKMtUcVmCnmyCzRHUds5Wka/8v7s8YK4txy80s3GWod68AK2R/nGvyglFS8LUGBBi3ujNZV1Y2ArmrI1OW8NjXxd6KaShRsSADktxViRLbztbWBevzckW1kIwEWriHHJECcKOJF4HLFtMCdutys=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by PH0PR10MB5546.namprd10.prod.outlook.com (2603:10b6:510:d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 20:51:20 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8c) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 20:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:18 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bR2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 4/5] efi_mem_sort: skip unnecessary compare
Date: Thu, 2 Apr 2026 15:50:37 -0500
Message-ID: <20260402205038.4005350-5-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205038.4005350-1-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH0PR10MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: e017728a-e376-4ae5-0476-08de90f99734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mY+rmlp9qByb3ddN9NYbRYvlKDC/Uhw1HdnZjenYO6yl7XWi+EHga2Eyg9m4xfF6bGk8OV2AUiPlF/s6CUURjcfex/jj/GF3HdElp7OiSnBbmg/xIi5/EhyBc+AKl8qmUFEpd7DtwYvlsfy8vKBjBLaJzhFkrvPr7DFyBavRZnrC/2ov0tcAJkUoOicpx+1B3HSwYUwtGXvg6R6kGAIBjMaHaK0HwJyFhjVgH1oCQCFO9L6Ta+emoCaDOWreMm89pOSD/MsVkEqm8g4TH/66/O7Qq9BMQ1xdZCXVUpzXeL6rE2y9UnflrdG8FbNP+KMnYZPBiSZZR4ouR19Is5HD3nwKFSXTruhxiYnq99j2t1ZYyLEtq8izsYwTyA5kjyOuie/8Mk0S1xqeiOd2xIif7T7X9uJQB4qngTwMSU5OrRncqYOnYgYZ6ncNG7OvIJz9scXHjDtFubNNrTIupV3drEw680eRCuBRNpxVx40rZiAA84j/rsGZsmsuMyM/Vy/B9r9/bjnQyW3LQdgi4FsSy2j5hedzsDD9Q1yQQlUfRyP6pFPHjgsLb/EQTg8AAMkgBnmJ31LS1RfRPjRwc5OXN5tZGuYNtrFZr7R83YHhLzEa2gDcO1C7/McqTjrsPLWdSIyFgB0B3wrOqSbDmOHAue6bXjcBaWlw+6GBh9eivW5FH1c4q2pIZfLS0vUIEI7SduN/WvoS/bKa+09ft1RQWz3Jv93Hm0XgmxWh0jQgc59elmrj6EUOIRevaJ0UNG1ZuLvGrWawuGmlQhsEyB6l0w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NlMH1DbW4AuDjDXAjlSH0btnR8jNbjANmmbLtcChQeQln4jXPqoCURHL1oiguvqWM69D+EUHPeVkJJCFdfDnl9qjaaiIqN3gxIQrqnL36fa0gb9pcfLsCDUtGOhf7ER69IYIZTyLC1rAX2bZf5s7wfpV4pI7vtimReQHPJ+Ylt0X/MVu9nddh06IhTcOt1C6R8ORGZgCHVHo4EGhWORftisbMI7QUgoC8c6ng1zWRhqWarcRHL4wgBQIPHGscy1OtOoo6R+EKo7nUvMNCBBnM1DfuACibGw9nCgzgGL8wXRdINJ2p8iGpZvaLhuI3yGUtovSWR785+bYnNJJH3iSWMO2MRvV6Jx1hPJNpkLKXUyT8jqPEtRvusjbxuAZkIf+BcoWpCHzYHQvS4fsZV/UTsgq0aU96ZEk2J5gfuaiL5qkY6+AXXWpPcYRXTuICxbL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:18.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e017728a-e376-4ae5-0476-08de90f99734
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
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

I don't want to think about the possibility of this pointer containing a
reference to something from a previous iteration. At best it results in
a some arithmetic and a comparison that should usually be unnecessary.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..882366a9f8a 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -129,13 +129,13 @@ static uint64_t desc_get_end(struct efi_mem_desc *desc)
 static void efi_mem_sort(void)
 {
 	struct efi_mem_list *lmem;
-	struct efi_mem_list *prevmem = NULL;
 	bool merge_again = true;
 
 	list_sort(NULL, &efi_mem, efi_mem_cmp);
 
 	/* Now merge entries that can be merged */
 	while (merge_again) {
+		struct efi_mem_list *prevmem = NULL;
 		merge_again = false;
 		list_for_each_entry(lmem, &efi_mem, link) {
 			struct efi_mem_desc *prev;
-- 
2.53.0

