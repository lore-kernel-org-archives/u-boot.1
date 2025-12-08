Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F74D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2060583AB7;
	Mon,  8 Dec 2025 20:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IjTXtCOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B426983AEE; Mon,  8 Dec 2025 20:16:34 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C43183A57
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdLEA1IW/FOQQqJXbCdA4xjV+OnM7DC1AZ/eX7Az8SRPYzOIzv/bPpPC523oZDlkRdoWuVsktKI4E2PltwcRBQqU7f/mecn7+oz90ys0BD4H+XTInAr9gWBAY1Ip406o6xWcuqRYORkK5nAR6Nsro40pNZ685MLV1pd/8I7pA3J3uaYQcKmA8wdLt/UCyFaN6ZlsU2DM9lk+ggkf9SbSv4J7AkqGKgQPF1c0eQodY12dZwUX2PFgdbLHQaQM0GRk48r3PhOG45QfV/GGn0OZJo87X9PTqoKMrT4BNOMQtuKYHE2ulNmIYygyd/+QadwD9NBhXMcgabXrvwldjhHdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2UlIHxgdYtC+8xuiXz887F4b+YSzM2Q/k7LxB+MW0A=;
 b=RakOQ9nAPq2oZiKeTUw4Ifnfoov7eC9kwH0Q+nyQ2Hwv7KwbxILtkFgTNXc+Clu1iYyyGAJSVRurlno5JEZcIbI0QLUI9OutOSUmcSe6p7lToLD/ysNOuFqOQWEvYleuaYRQOlLU7c8BOy0ZspHBSyr/s1o5gyQLiHqWCNPEtukcKDIvhILEfXJ0MgGhh1EwZqmbvR+17ZGStkVQfcex4vDlCwTqq1x4S7Fbu01LMfeOQKlXc8XCReh4xmyF/o9KQUMSZp65MsWoUTRk3+MCZcUcrZfZUDtXu5FSqDlcEWz74wZ0eF074nFTCTjbu/JBW7Jf0eMVYwdeg8+3LCe2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2UlIHxgdYtC+8xuiXz887F4b+YSzM2Q/k7LxB+MW0A=;
 b=IjTXtCOXUki/JF77vYyb9+gMrWsyuJzb4aShB+dX9JO/zNA7RfIreYCmQrCSyaf40OLmjOhtTVN3bjf6YnPkQnwtlrgrlVmH13IxYdvE1TmwMXPLnhHtrCeligmi9A8YaWBEdru7dyJ9bw/Nz0gtOw//PHzTgO4dGqX46MAV1EU=
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:16:29 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5c) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 19:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 19:16:28 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:16:26 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:16:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 13:16:26 -0600
Received: from fllvem-mr08.itg.ti.com ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8JGP0t4114110;
 Mon, 8 Dec 2025 13:16:25 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] doc: board: ti: k3: Fix a couple small typos
Date: Mon, 8 Dec 2025 13:16:23 -0600
Message-ID: <20251208191623.2246534-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1e9955-9ef2-4176-ad0e-08de368e49ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxEdXMKa6GOio3o8vMIp+WB5mA/eOu7Z8xaTP7anWSrA8+Q3Kk3E5vqgvPzi?=
 =?us-ascii?Q?f2MsPxEjOowdMp0EEsSPyHEIwVPbmRySUBe8Y/P9DvGxMN8m08zKjfD6skLQ?=
 =?us-ascii?Q?fbztdtBosyHfXKgR09r3YLFcjvWAyjwrbTq8ssEKB4RAvNpgaG5DfMkg3rZx?=
 =?us-ascii?Q?tZBv6vVJpl8CsJuw72HgA50nxveXIW56sjE7BEDqT7dTDFAYgBQU4ZThoXCf?=
 =?us-ascii?Q?wbZhPGm9LW2vWjjeLxUfdumdmmlEBl2bAybLzgA3ggxCuf/1V4swHvSDoaiY?=
 =?us-ascii?Q?W5mZkyKI+yscRQdNHxX2dq0mMdyj8PkWitlXK4AKU1A3Iu1k4WYrS0gkelIW?=
 =?us-ascii?Q?dmuFt3/CaipFioYwsJmtAUIoLCmsFGfOQkqntXLLwjZu73uB6cq0j+cxNZaj?=
 =?us-ascii?Q?T1X1TLNKw8F3PR/IVp49GnCEKr8G5AAsly+TvwlVM1p+x63WRQd3BAxoAYx8?=
 =?us-ascii?Q?ZHarupJRXQdLErWQkSTS6zU+8VVAtJXkYrEhfO4oY5020RtIw5CIYR0ym9Ti?=
 =?us-ascii?Q?FQtx/X9EFBeMkIYbrYwXK36MtzLwNur9ZzfARCKVvQJK2JD32QBNb5stt7WP?=
 =?us-ascii?Q?32N1MZ7MdmO6ebBVvCyVbfXHlh4YnY2GcDU47TV/qLjqt3mixYmI9Z4jZEJ/?=
 =?us-ascii?Q?lGZ+8UWm9YngFpP+R23PdCDlQUACH1T0sOJ+GtEAxAKz8fFDqW37BwBw6HMf?=
 =?us-ascii?Q?AwvIAa1ix7T3MSEuJ+yOVYJbZH3L1vmxFTZ8ST2TRgspuGD6n+ex+XUI9JTW?=
 =?us-ascii?Q?M85WyQo+YIzRUDyaMv9PFQYp4SLzk7LAa+R1hl53AOkEDpu/TMaSkgu7CUHD?=
 =?us-ascii?Q?uxt+dYTh5hHR3ysPS23u9FKngbpVdBrTzZ+b91EnWBVmon6p4bW4tG15FAeb?=
 =?us-ascii?Q?gfUFP/5gsGmJx3IgpM6rKb92y3EQNXbOS/JOkpXbV+4o9+ikSvAOokTVfmVf?=
 =?us-ascii?Q?MxtsRU57llFrZr59tB0x6Vm3YpcTBoq2o0mnnyWz2kck2WWx4/twuKrBpic0?=
 =?us-ascii?Q?zBKDG/UvRPzfDguO5f4uh/0h9650nZlfTDsUse+SLxs4FDBBXuJvTKPovB6T?=
 =?us-ascii?Q?9lqjcAWE3swdBgEnglhik6559wlIgIIP+TEj57tchLqHi8KDGE4cpDXuA9Fx?=
 =?us-ascii?Q?kO6CjHTiX1sUZtMjvR4VxtEyFvlm8iAtMx1PjgkqkBBR2qapkax1JCe31Aq4?=
 =?us-ascii?Q?DsxqS4tB5TOBNwM/+vWjhG2PNbB2p20X0cfjUltD0//Wg84eKGnh21xT7AqM?=
 =?us-ascii?Q?qvCYoa1aeag78IrUN5ApIVgzNnkYMmuG14mixjzzKNdH+gjxqHfXhLuuvhsh?=
 =?us-ascii?Q?6/yT5GmTUwe3/2FxxmPavLPG1643tspMSqmJiC8v86qwhlDdDnLBLGuNMnjD?=
 =?us-ascii?Q?HXJL3XHo2ZnfwXOWeKhnLNRTinYe3CwiIMEy3XhZSwYzHzGFkid/BZVZMTyg?=
 =?us-ascii?Q?69QJ0+b+jnnzosn8Yw6Ww2PoZqSBDiuRyORVVzYS5PYiSWgj5d/+VHC3cOM/?=
 =?us-ascii?Q?tq/ZnGVWa988Fqc+0Tu5b09gM8BtCk3Kmf/joYG568wmBRXE51w6ZRU0dYz4?=
 =?us-ascii?Q?0FOBUQfOtHgii7WYVBc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 19:16:28.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1e9955-9ef2-4176-ad0e-08de368e49ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
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

s/Uenv.txt/uEnv.txt
s/then/than

Signed-off-by: Andrew Davis <afd@ti.com>
---
 doc/board/ti/k3.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 37a66b3c69d..913cdd7d09e 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -653,9 +653,9 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
 Saving environment
 ------------------
 
-SAVEENV is disabled by default and for the new flow uses Uenv.txt as the default
-way for saving the environments. This has been done as Uenv.txt is more granular
-then the saveenv command and can be used across various bootmodes too.
+SAVEENV is disabled by default and for the new flow uses uEnv.txt as the default
+way for saving the environments. This has been done as uEnv.txt is more granular
+than the saveenv command and can be used across various bootmodes too.
 
 **Writing to MMC/EMMC**
 
-- 
2.39.2

