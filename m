Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE604CFC273
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F5C80433;
	Fri, 21 Nov 2025 14:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IYa5FCIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213CB8051F; Fri, 21 Nov 2025 14:21:52 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B109802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDX9BKnnqELu6xM5lOdGekZWw3xhgbctBWs/gsZ2HlKj+PlcXW/9Rv654GsFeszH54GGscSuk9Lasw7mBD6kf10TCLILrQD9SK4KuhQe6ux/Gd7/ZBatBCRT3DHSzqftMdT4/5BNS8JFlYq8dvNXOgk5LhIjEEGOp3izww7N4T3AUuLXopprjKdAnbTfSLDVcS/BVcHKm4Ll+Q98NrNMpcUgg47VWu1+QPH9TMAP8pIEwsGOvR60Kh/40KI/xcA2JXjCUZufrtimBgiRlVQYceu7PFIKKAGGb3TfhGHfgK8HCjBIi0sKLGEebju1bFVcqNAAHQPMeA7BQ43zWVfsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po149A3EUxINHvEobHQk12pPILNcTcsg9BvvMrBWP3A=;
 b=p2WbRSQDimOPiA9eNswG+RqCoj5b9XVEcYklr3OxuxXYAkKqnwEZeSaQr+dGBUE6WWEv31yDNxwY+SFnnRuiogfroDoF5/8LXDFj3ldgnat0mZ7Dod+jOI0kh1BKw+BK1FxlUl5SRO0UvtxtY8a4aueblK7kDt+I2npliVEA1JVrBUYbjVv2Dg680pBZzhOYufu81HQg6ssMOJ0k6+CfryS5SGas5iP/bqngHCZnNfxaIFU/HdI1xTDm18Gl7NtMOAZYx1VqfJHtkVM3RsVqs+OX6MHBTLtEFyRkQX9jgylad94cTI+sjybDXvDFxVBa3OrHo4ZEkBW2URBRq+UMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po149A3EUxINHvEobHQk12pPILNcTcsg9BvvMrBWP3A=;
 b=IYa5FCITSs70xsWYNYENORjTxkMmgOzYCyxQmpUReJ0KB/PbkLDl18HJdjHjH1awL/W/a60zNAfsY8FroB+cK3ktKrA4a8+c1WnXBYHJRz+DhfqbD1KZMLVxBPOKn0xHG+Pzyy8W4pIXQvTnBkrvDFxRPtNb7t0cFve9pY82FxA=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 DM3PPF76BAA8D48.namprd10.prod.outlook.com (2603:10b6:f:fc00::c31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:21:45 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::e3) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 13:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 13:21:44 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:21:41 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:21:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 07:21:41 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ALDLbEK1281260;
 Fri, 21 Nov 2025 07:21:38 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <jerome.forissier@linaro.org>, <trini@konsulko.com>,
 <richard.genoud@bootlin.com>, <matthias.schiffer@ew.tq-group.com>,
 <andrew.goodbody@linaro.org>, <c-vankar@ti.com>
CC: <w.egorov@phytec.de>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH] net: ti: am65-cpsw-nuss: Ignore disabled ethernet ports
Date: Fri, 21 Nov 2025 18:51:53 +0530
Message-ID: <20251121132156.3987128-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM3PPF76BAA8D48:EE_
X-MS-Office365-Filtering-Correlation-Id: c11122ae-800e-4404-73f3-08de2900eaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0XkiR4fOBSyJWZ/eTvTf3H9VyNkbKaV7vOAOc7Lb+JZcNYwFtko5zIPvmuvJ?=
 =?us-ascii?Q?mvZM++qwbBKyeqy3WPj8EytPZaNJFyhmEUZjJC5RhrQJMtRx4EMBQ6N3U/a5?=
 =?us-ascii?Q?z1VwkF3NPN/W2yy9l2gWzsagJNWgx/EU+YFBYpo/HHpXbobscIh88y5aLgdh?=
 =?us-ascii?Q?NhD4v02etO8cWwxT8884G6XVzobua1q03YNGdEhpO8CycmWDtCOxuwrUIWTt?=
 =?us-ascii?Q?YeHgvcwwhiP1U5IoJr4pPQsuC9bWGB7LStK3CmShg0fMPRM/x0Q3XBGZ55z9?=
 =?us-ascii?Q?fzZ5ZBJgyszdObzzsQ1yf8Hu4WV44dmXoc6ATz7LCAqndyCHqJCb9tFu1H4I?=
 =?us-ascii?Q?sKp2MykjYIYy3FWcVsRVQoi4NmgM17NlHX21BcoED3jSNdLpK5scCr1h/HeD?=
 =?us-ascii?Q?/zt4tQNKx0RhgrhJccW84YHvz7Yu+E/7PeXn1Ra9NKnaZs6ElbTXbU43Sxno?=
 =?us-ascii?Q?oSRMA3oPQTEQUhtkMTa2bwt9dBCK8PErMbaK4wqegnNu2aWRBSKGsG3a0E8j?=
 =?us-ascii?Q?AwEPpyFzbRBbCXmS85pzFWvoy0s5/RzCKcZ7CuaWit1ABAD1e6sIPyPXhhuP?=
 =?us-ascii?Q?XU0jjVoJTI8kh/rv16RAITq8yeCrYeDe5v49c0+zqeo/pVahbI7sGSQ1Dz9w?=
 =?us-ascii?Q?KhTAMsYmwroS1QUDm34K6tTQoYMjyo/3OQlaqlKz6rpZ5WylzoO4IZJaJMJU?=
 =?us-ascii?Q?Wc6OkQh6aldbbX3lxXSEMw2bL1eRfTIofui5Ci40gX1vuVbWeU0n9yV5UDNS?=
 =?us-ascii?Q?vzML+93gTWrsEh3rTEjymfyTZ85y0n6WG/ZmVY/ttpwSd9HHejXdA3QbsE3a?=
 =?us-ascii?Q?5OPwL9VMdXBwi7lp4exwnC4vS2g5VefS8c+OYVEOvAoM8VJyF8xKHykg01RO?=
 =?us-ascii?Q?tid+DWbtKA2CRHw9XrFin08wDONxnvxTqJyjs4ZxvPf++yGpI0XoA4MaXJNU?=
 =?us-ascii?Q?e+tYqD+7+eUEzXJcZyypsPfNkk39vkFVyg1o1EKmgwdwfuPOu67o9pr64ACj?=
 =?us-ascii?Q?wAwhcja84+fZRO+8LMfE64CDx/5PPkSI2RHTEPsjRsVooCardupXbcyKeHlF?=
 =?us-ascii?Q?ufSNWW29t9yGq7q18liirAGarahhGTDNXlkNMHe0gcK+EGH8pF59XWYAaUU2?=
 =?us-ascii?Q?H23j6vrogbKVDK+R/uIJnW9luJ4IM385Pvmdm+doJX0541G+CWB0IOUfaOV9?=
 =?us-ascii?Q?7EnLSlBgcljnuCDoT+WO8eRs15vHhBcvZX0ID8fgf+D5iNY4cMM0qpdl8Ciq?=
 =?us-ascii?Q?Je/aps9zvT92aCq2wM6+q3yRjsGJlDyq5OnuBzONyfPB+pIORrBe3+hQSXwq?=
 =?us-ascii?Q?bxSutkGr+AcFgL/40ewZm+1tb634rhNHZ/eD4iVuzQSOVu89kuOsWeyb4N27?=
 =?us-ascii?Q?bFcfOpYF50EQzSu5wsTYBRkyaTYwY4RSOv3gh+phYd5Zd0W5fgE8FvyCaqkm?=
 =?us-ascii?Q?gyQx2cCw1yDXlM+YnBCtkttzHY2D9leJdrU9Q9tntpfIZ0UFvGM/FjUZHRGp?=
 =?us-ascii?Q?YojEt1kZpQvEgvs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 13:21:44.6414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11122ae-800e-4404-73f3-08de2900eaad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF76BAA8D48
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

Currently, the bind callback of the driver namely am65_cpsw_nuss_bind()
registers all ethernet ports including the ones that have been disabled
in the device-tree. Since the ports that have been disabled are ought to
be ignored, fix the implementation to register only the enabled ports as
indicated by their 'status' in their respective device-tree node.

Fixes: 3943531a5468 ("net: ti: am65-cpsw-nuss: Define bind method for CPSW driver")
Reported-by: Wadim Egorov <w.egorov@phytec.de>
Closes: https://patch.msgid.link/8b4ac072-125c-493b-b12a-f0a4e9d56e7e@phytec.de
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
2bc0715b558 Merge tag 'u-boot-ufs-20251119' of https://source.denx.de/u-boot/custodians/u-boot-ufs
of the master branch of U-Boot.

Patch has been tested on the AM625-SK which has two Ethernet ports of
which only one is enabled in U-Boot. Test logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1f0ae4fec659784f6d99fd159b380644

Regards,
Siddharth.

 drivers/net/ti/am65-cpsw-nuss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 7a88f76fd09..840029280e7 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -819,6 +819,10 @@ static int am65_cpsw_nuss_bind(struct udevice *dev)
 	ofnode_for_each_subnode(node, ports_np) {
 		const char *node_name;
 
+		/* Ignore disabled ports */
+		if (!ofnode_is_enabled(node))
+			continue;
+
 		node_name = ofnode_get_name(node);
 
 		ret = device_bind_driver_to_node(dev, "am65_cpsw_nuss_port", node_name, node,
-- 
2.51.1

