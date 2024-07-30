Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64250C3DA7F
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 10:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93CAB88640;
	Tue, 30 Jul 2024 12:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m60VOHyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4F788785; Tue, 30 Jul 2024 12:43:00 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D028854A
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgKV0bFCogCxWzLOBzjZiX7MbfVSbC26PV4MJqjlRywwbjgfOASeleJ6qRwXbkIM2aFovdZi1KhzucIePDMKeh9B+iDUCEAmfG7+o1GaazAdDm6CUn+f347ySErUS0MA0Y8QLb1no087auv7TOzFUPFdUy/34DgQ5O64Ca7n9f9tpEAhOCcjWNywv/ZuMUc/vldoKguchfR0hrPtA08xVahm69W5ROCrJreWLL9IqGoGlcxrrQFdYbK/iIKlftASEm1kMfK00K2FZtRw68gELUbt02dor9klmxXDCvlP/z1+bqKpWsgtlfpKoDc5/AFKdOEWNfcMGztTyiNpPd4LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfLI1ZrqwkANKWR8UAuFvQL6roPxsKa4em+VYyKz1Io=;
 b=rQHqOuWSrMGCgFfzKSZBkeuZHtgbQPW0fasEATLG4WFz+rGqJ/AXZ1GpKypRwA1Lna5XBmyz1ky36osv4j16iBCDW7xPALAaoE5m4AWNLT4aZv0DnvnNdO0NP9nfF219xoDJ0EW0ywpji1kjC0xk+jVCX0n8Pa9LGiY/S4zHv3UugGyPClKURekIamZ14eu8HyfCv8FZtjjtCsqKzsASnX1XnBlLsCW4hkzzxBxthYtdHNTS+eLbsOJJI82kIvGYPNc++qnv/pMC8f1l4+rgP+So8ijQlic7vpQ9xacNQAbR3nliFelFaz0CKb+eoeKImDUZxvD4kvt+k+GYSFgStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfLI1ZrqwkANKWR8UAuFvQL6roPxsKa4em+VYyKz1Io=;
 b=m60VOHykZNWzAln5L8oy0kV991Ann6Ytn/7DJ0TDBsH4rp/X6XYQNQ96iZIyWUQcadV4ErOKA4H7aIx7FmwkR4IqwvXZB6mek74s/aMobgVzVjzyksW1CKLoDQYBEdxT1Q4KklwCCf6KRL8LGf22FIC2kwJv1qBvBGyz+Ji2gv0=
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 30 Jul
 2024 10:42:54 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::11) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 10:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 10:42:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 05:42:51 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Kory Maincent <kory.maincent@bootlin.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Remove PM firmware checking
Date: Tue, 30 Jul 2024 12:42:43 +0200
Message-ID: <05b8bbf0686c72f86ea7f8bfe0da250ddba9e211.1722336162.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TtJa2KqWwiDSnhkNFeA5pZac2BP6N4XYivQsT8sdPug=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQVh5cUnc9/pcH/bstvd/FNS6c76h8zerJjW/wXhkjrX
 9MYA9IkO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEdJoZFvQd1+t+Vui06Zjt
 Xl/VrNmZi0sPWzHMUwy7tWO66c79N3j/TJ/2/8jMQ/YdFwE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c47bb3-c8c4-4be1-aafe-08dcb0845de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vsBt5Ai0P9ZfII/mV4GjD5c5cOKuNP2Q55rN+BX8pquY+QXf144AdoUAqtel?=
 =?us-ascii?Q?c4jsgo/60F8mllb2pYgmQBPj/lOhhmqS3ClqhBjyWkrAPITz8hi72zOuSlWs?=
 =?us-ascii?Q?EmkA2mBsHPuZWBfdVXnrghPm/dVNhdjKthrqTx08dY1/uHsXV7PlI9evkiRu?=
 =?us-ascii?Q?Lr2tNj2sTf8entS9TbZ2iQuUxjh+vh/TkRR14civVGPHnJtPzWmsa33Ap6Cj?=
 =?us-ascii?Q?6uhbhsbInyMFWVXoFp4YB9uq/vxvJd+FPLCx/sA+EUpFYexaqGslzIOhgEDp?=
 =?us-ascii?Q?XA8lqNk69lgxWdTp4H9VY0m4uYk9G9qgmhW5CwzLUsHcpTaca3U2u7DuMiU4?=
 =?us-ascii?Q?IybmRzhyFtNzZ98yA497M5f2EwihKR1954rv41jj84cmSGGwxlW/U5zbwaj1?=
 =?us-ascii?Q?/akW1BoAjBb7IVylB2YAGtbjMdfGNx2JT0iRSlfYHffxoHv1xw6YMNzKZ0vB?=
 =?us-ascii?Q?xHuP68THK2HrJwONfeb4GfwC8BecQ/wh75CWp3rGChIH2GdQduLvhhv059yT?=
 =?us-ascii?Q?AF1U1jZWNvK+cQqVcXo6bSFoCb66LcNdCgJ348aPLdZrD/nBbx/JjcHLhUuC?=
 =?us-ascii?Q?r8sqBcRk5yNCZz9t4yfqNXvdWv4IotqCJD8CkSYG48X+l+PJIGw+C3Fi8/b3?=
 =?us-ascii?Q?lrGdn5HahqBQckhL4tin6/5YLewu5u+uVqVKn4+Cu9nAQJ1eut2qqIOMMfer?=
 =?us-ascii?Q?tmP899rg4pf3GeVs1LcLlfNI2oLuenStEGW9AOrjAyp0nwSofgxvVcd2QxgH?=
 =?us-ascii?Q?UJJHYRNxe+BaJ3Tp3E4egt9GKxKc4WE+MyOTgP2wPh4/liCX+U8Ne6YaTmS0?=
 =?us-ascii?Q?ZZSxHdKODO+3/Al2x504/c3ideKE7+ok9+hTvlzdWZVPwVS2/uNCVkinE5KF?=
 =?us-ascii?Q?8UZufwNHWMLblgH7i+hMxn8yhu5qO2St2p8u++s3Xl/tZ0lpMgpmDU6Mb7NL?=
 =?us-ascii?Q?0j+kkXG9orniXzsJDMjToYzxpEW8O4/c5J5Mj4EelzzG/kjT+YZZS433jB8/?=
 =?us-ascii?Q?SVroZbIKvFSF14dForN2M6JCPjIZKoikzimlIQjoGO7tKBwHENG1jXCOykoq?=
 =?us-ascii?Q?SiNQ3yTiv6HIHlkgS3ORsNshd7dEcZ6NYhjQz5VCxpXftOYJ52Gr8TL/L/mR?=
 =?us-ascii?Q?HuHcqoz5/roxxbP12xZMN9MUeqRYNHPCjhztwxYCa1DkUEBVV4OygNJxDBJS?=
 =?us-ascii?Q?tawpVdcSPG6d54Hq90cR8cIB/5s8o+V5gSd25GtOufyCYMO6SqyIiOsMmpo8?=
 =?us-ascii?Q?XfiTIGdh4QwjsS8ecL0o2cwV1FmizaZdTs69Y4M26ldyjvHQoPGOTp8pnIC+?=
 =?us-ascii?Q?lmhJ6mOzjwCJyxbvzy0dDEB3LhiV5N0+AMxSJ+wS7r/xE15whs102BE+urPU?=
 =?us-ascii?Q?X7/lITghx20r/4AVey3xFqzkblsypJ08GWjEI3xoFCtf3kRuw7ZgAgNMypgg?=
 =?us-ascii?Q?fNkCe+2xLkU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:42:53.6465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c47bb3-c8c4-4be1-aafe-08dcb0845de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Having zynqmp firmware is actually only one valid configuration. In QEMU
case for example there is no PMU that's why this checking can't end up in
panic that's why code remove this code completely.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index b4c15b041ccb..e6331c0e4d81 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -152,20 +152,7 @@ int board_init(void)
 	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
 		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
 						zynqmp_pm_cfg_obj_size);
-#endif
-
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
-	struct udevice *dev;
 
-	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
-	if (!dev) {
-		uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
-		if (!dev)
-			panic("PMU Firmware device not found - Enable it");
-	}
-#endif
-
-#if defined(CONFIG_SPL_BUILD)
 	printf("Silicon version:\t%d\n", zynqmp_get_silicon_version());
 
 	/* the CSU disables the JTAG interface when secure boot is enabled */
-- 
2.43.0

