Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D68D6AB10
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 20:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DE4840AA;
	Thu,  2 Apr 2026 22:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xIgmSVWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803E084056; Thu,  2 Apr 2026 22:51:18 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EC680212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 22:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5iIt/uLsfIFla6DHZKpwPq5gBB2IG9mkal0Y56oJlzoIKXMdTY4n8V9BQ89nrPhEni5x7ri7bngM050Z/v0F5auqU8+SGE/A1dwEJUTyb6H8to5R1hTuMq3FlJvrhN4493kpOdW2flC3OB7LkU3SnPC7QBHNg0fnMh5nyfGhy720LWPWBu1jt63ymE65E0nv6T3YVGysWeY64koHbait/QZ8qtjX+F02qffj69WXw1yN3qKJ8BfkKU4MIM1yXvIlWVHZDO/z6h2Y7hcjCeX45fekbYh+Eg0IpTwKKLbICGOxFjN7zh6P/fhyAqP4G0QahjKnMNpKtCN0m1wX9NeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X4ZosKKjdfaQlkcQ6ETce3mJFBqT8XNG/0Z+Ii1HqA=;
 b=IsQvlSsKKnZKMHabja/3+nXa7KWLdD/C48gyEI2MEcxRa1m/mplbzXdhGkB1zbalkx59LbHdcmXstNqeLKZUhJDxnct3af9X6JpQoOvPOm2Nie2BoENbZ4Ldxz4LXtIz0JMHflszzoBb5KWNtPiygU6rj3j3s9L8e7XB8Z+7nL/wSg6HUNDlGzLXzvqqRtcfFAUji+JyBBTf5M5mSdCltv6uK6d90aJ5lgDxTLHW+xAuNMxrhFhY+XHp+E8o3kRe0nnBe8gyTTwRjAXAb1nE/ETCb93VT9oc7bG0CSbagIulFqQFaogvtlxvEVZVQp/aF/mLHcMEFGZproTXoQ6o/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X4ZosKKjdfaQlkcQ6ETce3mJFBqT8XNG/0Z+Ii1HqA=;
 b=xIgmSVWqdJc42aiODDNytbVRs8tMw4c6LMUdeQXT3XFipzTTJIG8LIRoZjJm9Fo+FWGMdTsADmXaDj+EAjdH3IAU18JEz+tsXSWonTcLkcnmtOIfEOTz65aHkGt/JW7hJ8gbyH6qMxMElP/Dnmcvy9Q/goFOUXEQiEdzPt1zby8=
Received: from BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 20:51:14 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::28) by BY3PR03CA0011.outlook.office365.com
 (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 20:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:51:12 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 15:51:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 15:51:00 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 632Kp0bP2708543;
 Thu, 2 Apr 2026 15:51:00 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 2/5] efi_dt_fixup: use fdtdec_get_bool
Date: Thu, 2 Apr 2026 15:50:35 -0500
Message-ID: <20260402205038.4005350-3-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402205038.4005350-1-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7724e-3ad3-4b6d-286a-08de90f99348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fJdzczulXS0whZ6EiMtfy1Li76Vp9Z3QjfZOc7pMjD96m74P1GJ1szLol5F155fs+nbnIccukt5a1l06o9hDN21Xui6Q6Mp6Tq9/1eEAxzELYuxpRXtHzgDH4iQyNa1/okO3MVwvizfyWiYmH2RmHaY0MoVkeIfkwmsn2iHF/AIHNoF+NiMh1Gd15MxZDlyIlNJLs1R94r0IdKf20v6uN+6L+vRN1i5QTdJ+/SB0zdm/k8X4w7xk0cJfUiy/0OdUgA+DzRmXcTugueyZ4DKDtq2R4DIp9YI2HQJJK3YJYnWiDgCwr/zEaa8hdMyG8eqe3ZfvUpXtKxytE1Gn5BVhWrUh5cv++KQ+M9pFLuTaL1ml3M4qigqJAJAoif+eRGakJptE9PShoSRDoHp6asvyKwc1HXDA8hGemIGoAATrlvimsa30XZxg/bs8QpSMK52mUjYnEU4kUm6GHNt+jPythCIGs3JnTtB9idxFLqhIbG0tFYX69rL+8qhRW5w+/O8K4euCBPnNWlEsO6J1kwxghz4fPF/v1epaO0Nf9ebs0GsApLas49jzsDc4ANDSo3FFoHics3TkYYlD3T3CboEqqPUVB+X1rkg69hquUNhPZ+wtwiy/dmmx448180CCpl44tuJaaFYUZz4o2wd51OvuRNbeOtvNBoc325c1HNK9aVurTFxxjqIIsQCtxc2PCtG7EfxlqVTYa98ztfjfb1LkDcnGIg56rYx7UZ7C2xIaJp/XY7MF1GZKk/Pp+STN3P62Ttx6/PITICOJmHo25O/yQA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: njd/En0n9KW9ymohoo2pt2SJr6DYkukj8PhntFXW1qNuF4vzmfx+cPHBV/tqAuzv9wfJ374+p4EQbCbPi5RJXyt3YfZwUIWE9nr+DGlnyZbZGJ7KJo4SJlIVgLsGP+a8It9qxqAd33vKKpjXAR6f4P/p0UgWCNEA/qxp57H0CsDDwz6GujahuH4vAfquj4mKwE9jTa/xtUwqd6E1XhICBY21hW7X0OJbA7bTj4JKcSXu2qf2mEKQivFUFlYvwJrPO09mdWUOc+Io30HrR2S+kAL9NQ8zetwP7N4JTVlD1Mc6h+rvVjpPOh2UQSeVYUeQKqVmUK5YwrNb6wBub8LuP3tw3DeP5g71UkJUln6seAJ33hYVl5Eyv2MIfh4+Csa1umjlU3EzIUyqUMRU3Sjl3IWpp4iYs2KTklDvmU3v/9/j1GyFsv87nObhGT+cez+I
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:51:12.4102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7724e-3ad3-4b6d-286a-08de90f99348
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
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

Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
a return code check.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 lib/efi_loader/efi_dt_fixup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 544e1aa9808..333711b9957 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -123,8 +123,7 @@ void efi_carve_out_dt_rsv(void *fdt)
 			    fdtdec_get_is_enabled(fdt, subnode)) {
 				bool nomap;
 
-				nomap = !!fdt_getprop(fdt, subnode, "no-map",
-						      NULL);
+				nomap = fdtdec_get_bool(fdt, subnode, "no-map");
 				efi_reserve_memory(fdt_addr, fdt_size, nomap);
 			}
 			subnode = fdt_next_subnode(fdt, subnode);
-- 
2.53.0

