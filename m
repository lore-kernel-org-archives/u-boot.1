Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D781DFCC9DB
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 09:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9D283F6D;
	Tue, 10 Mar 2026 10:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nrq3O1Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00FA683F9A; Tue, 10 Mar 2026 10:16:48 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D684883981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ21hQX7YBWK0Yio1a6u/MD2erE+CS+ikAI95J8o73f0j2nllfspUeS6TJ0Bf2bj81Wyp14B4MzPDtDqz6/szJRBDZ2lpSWH/Xc+2rcedg1N8O4V07cPhIQjK6lmpkjOPVQ/uJ+RUEsctka30Dy6pPhOaPahn0qlPW3fpRZfVPf8+/TBoTBSeGspsSm1vVnSXhtHGO6/91NkDGyzN61eOHZ41LIQe2YgZUIAAQpDVbte0ieiLvuaVGT2k64J5nv0qGi2QDPiCy+KY3+PG2yoQAmd+qUMMVzE2KABHj926op/Ax/lRRa5ou7s1RSbHvCsx5aLI2R2ESbEKNMnU6LXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFwQKn4BO/IZ/tP+iiS/w6Fvx1xv6XW1o0tia5Fy3Vk=;
 b=wtGsLOB9olleiw/LNloEAkv61w1oVxk2y+UA00RpFU0LJEpxXh+fFhQJCXFDfzF7hkKpVa0CkUBg85V/lkmvcYNI4STGE+7qaX3ElM8XOo6/CiayaIWWgANKHSW/5vz69X2D+OykFJUKtO7nTrLV511fnYmfLhhTupLkaOLOw8K34Cg3HplPs9xzkG4cZ1U7oa9dFNPnIyorwpcc4WS7ClaXf9d2qna05WyDsUTHsg8wnWmqOl+QP9khQn5IKtk4KYor3qliZA0i/qeOL/aXOOyLZn3Cif7mepSMHcmRvoozVI775X44Edr+791OYp6njLkWvR4MT3R0LrkJwfkA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFwQKn4BO/IZ/tP+iiS/w6Fvx1xv6XW1o0tia5Fy3Vk=;
 b=nrq3O1Dg2U0Ac4AEZRSSMmIBSaAwuydUem+Q9w62zCINS80eAUL0LxbjleoeHdjpPyXgWi3T3bLc5Ltip0GdDfXNDlPhQ1JrWhxcM4LHlT0hyT2NNuNeV/V7uDcfIRBy0ylFYkK+p+y9z3YK//y0lVAfVYtRO6BTTyysgRz0C+A=
Received: from PH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:5::30)
 by DM4PR10MB5991.namprd10.prod.outlook.com (2603:10b6:8:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:16:40 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::2a) by PH0PR07CA0025.outlook.office365.com
 (2603:10b6:510:5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 09:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 09:16:38 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:16:29 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 04:16:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 04:16:29 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62A9GS262283304;
 Tue, 10 Mar 2026 04:16:28 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 10 Mar 2026 14:46:24 +0530
Subject: [PATCH] mach-k3: common: init gd->bd before dram_init_banksize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260310-init_bd_before_dram_init-v1-1-4486dacbe0e7@ti.com>
X-B4-Tracking: v=1; b=H4sIAGfhr2kC/x2MWwqAIBAArxL7naAJRV0lQnystR9ZrBFBdPesz
 xmYuSEjE2YYqhsYT8q0pQKqrsAvNs0oKBSGRjat1EoKSnQYF4zDuDGawHY1nxOd7b22QTqtFJR
 8Z4x0/etxep4XhNfJiWoAAAA=
X-Change-ID: 20260310-init_bd_before_dram_init-7a9c3ad0b311
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Vignesh R
 <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773134187; l=850;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=QmZFLJCWJ8R5PEFnN8o0TaHzz+ZBXnkvOVMGsDYlN9M=;
 b=DgeKj5tF/6rkAXnfndJ/faQteZke9451bN9iz7xvE8SRkCAOrUDgMtjsNY7HfTiOG99imj/Sr
 /q2D2yvXgxSA80k9I3VXXEW5zngFxpk2OakDYBi1KOzhO+4mK+YmWzp
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR10MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b33d79-7902-4402-23ad-08de7e85bc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: sCR+de/nQTXnelANw/mRlx6aLbuz6KIqBs8eCbDiYIEZbt3R/apWAVwjaOeUZMZpQieGWT8OCED2sr/4BKzM4/TWHzLTvwoK4kIr/bwthizPSzjJ/QjDXLVVx0/ItFVS9F8g2G25JyjilnLOvd8bDKF/Aj7jTlB/f1KRgJPhC+VQgA0mZa0k8Ri88BMmCcyqgCPTVdzw0MHTqDobkYWu3YKizbhU2Mzy6h3cIP2yaTNIFl/pY3hmwXmmYDOqsX8ggSkD5pzu+GZWyEFqdDbye/y9r6tjcDdZMHE3TcnAuVgnE2K1NO5TPRPnbB5pPymIZzesfYfU8InJsgoTmf82vciKMFoelQuC8+hN1ZHq/BX9GnmBJnBHz9UI5KNuBoQHHFviil4gRRyqky/JZKv73sJ7tXZl4A2r2F8VTwewYatBAfPKRZCHkz1/R63q7mNCE+hTFSyN6yPz7roCiLZlbCNM5r6T+OWY3IuNfXEDNw5DxPscq9MKx7SRNU+6LcJOK4b23c4b+LZG5+lKapDn72K3jCzMfIfyj6vbCmg/1c6Qju8Xf6PdcIiP0q40W3vEYK8FpL4d1lu+QAtEuIRR1ICBrsNCV9Es3uhTZz6hNzmEMR142a19Eq6HQ37kJr1o93U9Jvd3xpksRrJN1fuoSKaz/RKtn6FO7ulTvjX6pWwwfW4Xm6EgQbDMw0O39aoGjMcZzjr7Y2qFDvU6KdJiBD5gyAi+hsZEIk0JLAuCZa2OsJXfzxWF16V2O8nwuA3ym8xpQXPxdJ5jc4KfSmf61A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gmMOCB19d06r+GIS08jkyBiZLZAeGtK6FIf/na3AExXfhHiQIODfXHTD+YNSlYB7gToE7YhFwf6wityzNJORH4jcO/d5Arkk3qRRgGAUgLlefHW71TrA56THncQbAF46OMrg3UHzbMHXMeFGTgL9DdDV5xfk+hD/wtlY9oWlEPzonn1GaFcgCkwdp4mbAh/BU7nrZbyiZidNhvT4khmHnyF/9vxFlFGYoIvGw5ch264mu9q/XVR2wl6uz6oIsHUaafP1za7wwESheaESjAM08LmbMLyW+GWe3vaGK7pDwGk5RyCEQfNJbhdYyEY4Z/VWx/iS2feUcaj75UiY9B7Z08AN8MS89zpMnTDivApHLZJ/L0cXihtT6iZJ83pqTwhvutSspWVCkCKXpBVRvI/UsPCUViqfGy0zrtl9B8qiVS7jk8qwRoLbqPUWjuTaKRXy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:16:38.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b33d79-7902-4402-23ad-08de7e85bc21
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5991
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

The dram_init_banksize API configures the dram banks inside gd->bd, so
ensure bd is initialized by calling spl_set_bd as part of
spl_enable_cache.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 2f3df5519c5..39467c21679 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -418,6 +418,9 @@ void spl_enable_cache(void)
 	gd->ram_top = CFG_SYS_SDRAM_BASE;
 	int ret = 0;
 
+	/* dram_init_banksize populates bd, so init it first */
+	spl_set_bd();
+
 	dram_init();
 	dram_init_banksize();
 

---
base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
change-id: 20260310-init_bd_before_dram_init-7a9c3ad0b311

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

