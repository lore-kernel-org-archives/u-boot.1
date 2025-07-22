Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FEBC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC888384E;
	Tue, 22 Jul 2025 13:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToYGM7Ja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C5A8383F; Tue, 22 Jul 2025 13:04:31 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2259B8383E
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSIP6I7xCVgMLOXdt+MK/fp5/5Pup2cSRcAVe4OkmGx/3La2L+3tQLfCWMVsRvg/AcqI00DNPbThIEhrU0UT819kuL5eztpyGS/SfLyfC9ZrwGRLUSFIMJOT+2aG3d2vG98xtb/wSgAXynfiBNUBZ3q7+gOiR6QsKNYDOCLE8ZA52SDPeDM36zT9RKx0HCPtza+UzCQUoguVwbwYlvb7de0mAr+5kc64XBRl3z/V8MtS1f+7OQN9//9qHtNbpM3rWpXttD/mtfXt8bJ+qt/kecwTyZUfu7K1szVlheBUX4i0EtV0HoTitgdf5stV3BIFc6pxC8vUZlI4ET+DvQNtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gGc8/zbdLxxssxCt1ZeD3ikCCl/qoMBDsSk34HaSd4=;
 b=BRDjgw5GNpfBv05dp7Idv7lUtyavrWTiPWlTqYTupH3jLc+/6JVES2xEP1urKb/9DCnkoP6dInoN8tI1X3/8mdXamhz3TNPyHRR8ETg/KPlr3rUlL7UEaIi0pPCbYFcV0P3+YLLm6z7SXm+hd8oO2EwJY3vg5X6ajEhQqB6XpXC0SsSYE/3sAGCoBPlingv0eceCl77aoMw3ppCy6pzEww8dBmw5RMtAeD/9esfdWO6D6vAjbVex2AS4bVjs466Kpz4vyTKkailxSPWz9n7/kKB0ZiEXlmrmd9htbkZTd4uSwnbAkTOgNy4T9erF7kZAjTdsmn98IIme2rTVXKVxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gGc8/zbdLxxssxCt1ZeD3ikCCl/qoMBDsSk34HaSd4=;
 b=ToYGM7Ja10+E00etbiSQ8iKgwxLU/2rHAgkyr/xk1/UkMRHypsvz1BzJ2YfPts5K9s/z/RRLfBQt0/cpIJSXEpQsYC1S2pKtXl73LTSKh2bwCR6Cpv2k8jh958iAL5S81asYcGfzH20HK/3VDrq/QA2pmae+jeD7p2LgP0xWTyo=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:04:25 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ad) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 11:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:04:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:19 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 06:04:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] xilinx: mbv: Fix dt properties in interrupt controller
 node
Date: Tue, 22 Jul 2025 13:03:45 +0200
Message-ID: <d68dcc8f041567990a63176242c4acae33b56d4b.1753182218.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753182218.git.michal.simek@amd.com>
References: <cover.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lNueEP7r25Ft5S/O/njxNSx75oCRxVvRQaJiI7QACh0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUF4jp1ZofkpsYOt1p5gvPzY2BiWGreLYEh29sm5H71
 /eHkNCFjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIkaeMDOe87vXE+Lx69mzi
 fs5Kj09S5yt0lp++tGmxUfSDxe8s5FoYGV40s+i+rCxLl7kyPS3R50HI3n/sL54tDq15f6hr8b0
 tZ/kA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cf94ae-5908-49b1-2180-08ddc90f8541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oj/yJk/ImReLe0uTTVXxytDbrJtsn3G9m3+IArkaXFdGt7ghaqaTmXitdovh?=
 =?us-ascii?Q?bOl4PqZvjX1ETnjqJutklTu4IiYTC/Qb8p1Z4RfehkcV6BDB3RoLewshAc6f?=
 =?us-ascii?Q?FNWR3r5/bg0OjufpG51oRJ6j3IWjO8kpfm+rwuDx5xYJTJNllCNQClP7TNqv?=
 =?us-ascii?Q?cXJEDlHJS6POwezJaXaf2kgR9vwYouN7FxLWOfCFtBUYLnsUiIq1rPQD99Tp?=
 =?us-ascii?Q?ABp6hi71kPdL1RmbxkSSCv1wTLjxpx7KbWBtn3i+6QJsZdlLpC/GzIX5KF8D?=
 =?us-ascii?Q?eKcppM9GHwluDNYeDAnQ5BLqGp6lEwYA3W6PojCa4Nb9hmflV5+yGFuae0fW?=
 =?us-ascii?Q?2zPB9DwlB0DrsPNsp11uimt2ubVaZipyL/fWJlsPl0x+mH52iZVBdBnQsEwZ?=
 =?us-ascii?Q?NSLlhPU9j5bNuDS1q0BXq602V6IMN8s/0K9BIXJqpwraNQibUX54MgnMbVWB?=
 =?us-ascii?Q?YU31/+kt4/lwKEcN0VA6ZO8nDd73gvEPF1jJiPEgi9ar6TSvD18QTUFA2E0T?=
 =?us-ascii?Q?Vt79yz9bE4UcaY0qnC7ikvrQBTFn9erlLd8F0hdC60ZcGKR6l/eD5hsxhJd6?=
 =?us-ascii?Q?xKWR5KOeogzJ3YBlsEI+F743NDvRLJv1te5JUy1uqpyauuEKLAmRW+j2P+20?=
 =?us-ascii?Q?0c5SLwonAZqc+A5/h7j1DfwnpW7TVkaXvQi8LCkeeV1gEGQtZ8O0RKmnQTo0?=
 =?us-ascii?Q?0NjZVLnvJfs8DO3jjX0T/JSMnR15p44qO1GzsznBk2Je8OU0lyIsatZKqyb/?=
 =?us-ascii?Q?5CGEC4m3ZmRtSVXIovq79Amrx2SzPFB2rAbk4of70uqztFh6biZuPrnUqYVP?=
 =?us-ascii?Q?OOFuysFgaDlmPBeXpzhgy8zitSAzdmDO7jc9LzyOZmXVALBhN9hPvnKIPrPC?=
 =?us-ascii?Q?kYN4nBakiRVf+IfRDxu/B6Qlzj9Tdn4aIOO1h3QgBBughJ/+FJJlxAxJi32L?=
 =?us-ascii?Q?mWfhS8PzACYdMwjGC5YplqRH0kgKxeMp4Zj3mgqdpObezUCjDiK3Ig4PKQC0?=
 =?us-ascii?Q?SYkQHFQIdX+b0pyqirUk3OitjPPXhox7NkRJ80DWcivVwzgIe10Xa9V1RBYM?=
 =?us-ascii?Q?fZMGA3BrHKsAhmBpO29S8o5COT5hAkSj0l28BBxRu+liv2t4GfSGqMtTxq9G?=
 =?us-ascii?Q?mjTSNxtwyWY46Ycyl5CP04Pn2tCCqBhJLVpg2YviqLvgM4G4aLSrOXGVoAE3?=
 =?us-ascii?Q?h+8zXDJe6pgtQ8dpxL4OS0fKgRClAekaImRgs/MwhAEbGkzq4FCa041MayRm?=
 =?us-ascii?Q?IRGcKeyC9FVah4vy9bKvuSdTlADIDyXpKeft/2Y2ShTZzfdzxvbiPU8ADVDW?=
 =?us-ascii?Q?25KJcgZCNIe/BeETAdUZbtkZZJupwgicqlbLnJklCfnt39aHM//oMFjRUDD4?=
 =?us-ascii?Q?/e2ZqZs2OT1eEtlfbgryQz1N1Ryee7y7SP9WfAB0hKdp+jnl9US0h3RiZcUy?=
 =?us-ascii?Q?D8xKIvgwoElaqAff1mYK+AEKJQuQY3GT4yfAm6btXbdOvm2UqpcoKA5/UDQ+?=
 =?us-ascii?Q?ojUoCnmwwFUso+pPViHim0cf2JIvG8mepJVPOOEwPW+wYyS/ueiqNSfbUA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:25.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf94ae-5908-49b1-2180-08ddc90f8541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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

Properties didn't match dt binding that's why should be fixed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Binding has been sent here:
https://lore.kernel.org/r/6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com
but it is used for more then 15 years unchanged.
---
 arch/riscv/dts/xilinx-mbv32.dts | 3 ++-
 arch/riscv/dts/xilinx-mbv64.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 96e428062442..b426510f3434 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -71,7 +71,8 @@
 			interrupt-controller;
 			interrupt-parent = <&cpu0_intc>;
 			#interrupt-cells = <2>;
-			kind-of-intr = <0>;
+			xlnx,num-intr-inputs = <2>;
+			xlnx,kind-of-intr = <0>;
 		};
 
 		xlnx_timer0: timer@41c00000 {
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index 5a989c1697e4..3762def29f9a 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -71,7 +71,8 @@
 			interrupt-controller;
 			interrupt-parent = <&cpu0_intc>;
 			#interrupt-cells = <2>;
-			kind-of-intr = <0>;
+			xlnx,num-intr-inputs = <2>;
+			xlnx,kind-of-intr = <0>;
 		};
 
 		xlnx_timer0: timer@41c00000 {
-- 
2.43.0

