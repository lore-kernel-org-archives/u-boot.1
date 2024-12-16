Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17699E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 07:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991EF8005B;
	Mon, 16 Dec 2024 08:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MaB12vLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5DB80104; Mon, 16 Dec 2024 08:52:50 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399C88003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 08:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgbKqFCQDJuNuW20MuUr4TOR4+MMtSCwOx5mYjCImzcmXYwyZW8osfzmBjYZ3K7aUbteU7zPUpID4hcy5h3Of68Ety4r+VkSdRIAK4GKIfOyqTkS1OiHqO4pDiz7+VsLqQRkkoL9ULhXQM2UwORLxvEWGyDabWhzrJuN3PCQ/W7SFmDcCOxqt4YFd3sBHlj0/q0cFQ8y1kjUgnsQ4TwKTRHcfM0mbkhDQgFWWQFq845sfLJ9CssXyZY7NA1cdhFShyD7VTcDAjr6UfRMsK0+EQSh7nAPeOtr5S9KUeZsYC2tLLpNi4aUnldQozbPE2uogg8YLKIicwz5c+hz893QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt9JMHd3+Zd67WWAiBjk/IClhSL+QpGw5KdocfArEVw=;
 b=SxzvK1vU4G/O22l/9Mm5NiWXcGLP+0HF0I/DuqxeHBh63AVVGQvGq+UNlYyx8JPYT//b6EAVLG+EYTbyHE4wxhwaJkY9lO6x4nYESEOiZ/W4O6CevSCm/G01sd4xjhEsaIoK8ivxob3WEIvFItTKdtj0EpkPTkrgz/fF4Q3ttKQoHxLvN4GyhlDJpS3sPnM0bRbz3t6e8CEOVeLselpCRKMKA1v2kiwSXlX2aZYxN9BUlBiMcmvlSRQnXPcCryMBGd0hKxxosACmegquylBsZkN+4r33duWY8S5ttkAlOjjwA2ngyv+iCFcikcWW6i9APx/+zPvrLpE5UlEKN3J8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt9JMHd3+Zd67WWAiBjk/IClhSL+QpGw5KdocfArEVw=;
 b=MaB12vLQ7EYFzvdyVoNkSmyWscHd/9xY/HlB1kWVjp/DvbfqtEJ7K8KAknojqHZPqfsC7yhArkMdWitUqcYTN7UMz8wgkpYVnqJACP8HlJ60IQ+ieQN3XrpVDQopyAUnXXJCc8jfmDd9aJt/kUc6g4cpz3b6e6HADXIa4Txx03c=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:52:42 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::4c) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 07:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 07:52:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 01:52:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Sort OF_LIST and add missing vpk120 and zcu670
 platforms
Date: Mon, 16 Dec 2024 08:52:34 +0100
Message-ID: <505996b6ef969b1b677ab921462c75c798c366e7.1734335553.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IwaGtjARKYW8674Cs4DyQHiAVJlU0SaNwa6JaXDyQxM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvT4O87vAj3koorW8ihMn1Je9ybjxp0jCg96e9ae8EkJ+
 8xbHHyjI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEyk4zHD/HD5zQv3TOUv+C48
 STDq8sU9z4/0PmFYMG0e50XLe6yeobpC+TvDp89o2C8yBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e1079e-2421-4bfe-9253-08dd1da69e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bxD719/eDVdwmvYyjRXq6UxqPgmGLrenH8evOljEQ3BbKHjnhzE22M4dh5Dv?=
 =?us-ascii?Q?d8UPTxt/u0wcVCsrRc0Bo8UN4pVqxQUbZynPQ1T9tO6ZCx5cbGb+G9S2grcJ?=
 =?us-ascii?Q?UNu2DAJWhiLExRgE/a4x0vUZpureTFg6vBHo9CgHyAM4u1OaFFET3daABlZu?=
 =?us-ascii?Q?du4lzCqFa+JoVwGmhnsTuXMekG68wfkBDS/OgacZTa7R/ZGw8SXHV0v3EvTb?=
 =?us-ascii?Q?rZGjyjDbAuHzUpTnO1bfsmm/PwS6aN8CLxrWq9nuZBdNO6YEYxuwemEyJTE9?=
 =?us-ascii?Q?rY+e0IXGDFDBAg3yeV5IpJ/bWOwkUan3Crw57YO8EhGZT3e7/jCoUW7pUcxc?=
 =?us-ascii?Q?wtbhXTrsoi8x1JAfBvwbohBlLIJTrlsRh6mJ+GRiVCSmye5G27lxySf34JdK?=
 =?us-ascii?Q?9vjfSSHo8sSi3Mo2qghZyhnjD39vLflN1NyxxirKWU7QjK4XPBtPSStPc2VX?=
 =?us-ascii?Q?BvKBe8blF8RGud98dCKUGgtTLRXFqol6oqqSo1IjclV6KJnXSrRLa/z3ggaV?=
 =?us-ascii?Q?pCA3q1F0/hpvOvjCFtuInaoKAzZE1489MXRcieKxKHGF3o8E+81iSjDYaGo3?=
 =?us-ascii?Q?XDm+lkLKvmq63fqtQneJFQR4nwRUhCpmJIV1LhQp11BGXxzjD54Fkoyago6c?=
 =?us-ascii?Q?U2RAAewZr3miZwxoncp94QNx+D59E8pDSucm7CtTIKLzjZCqGTqL7KNqzK0c?=
 =?us-ascii?Q?KHXQR/GHks47wPg37wWAyNU3wnQAO5AlRdNVQC0C7285t6Y08+IIIDZ+p7x2?=
 =?us-ascii?Q?GHrNkuDvSttAN0RvuuOZWaK+yey/+t+ALlUvbhQq55BrAfZmApGnh6H+rQLO?=
 =?us-ascii?Q?uEwn8/ugn/1eH8nWsCPumxCkq/4aKRheA/pzVbj0pBDrB7JqwkkbXo4Zgyyf?=
 =?us-ascii?Q?YYOVwpBJf9vlmnUUa8gPEjaFSwR+vZr29VezvmAzdMRHAd4K9wst74nnhN0r?=
 =?us-ascii?Q?a2umkIFvG6tLjE/FbpikSFSq9+7hnstowGQCWReHcB87UJ2LPwDLKXv3vmwR?=
 =?us-ascii?Q?+XqgIUkEMNIaOtm6HAh+wgCsTEw3Dinef82PvJBhx/g56iuhvOCfrXAB7tAt?=
 =?us-ascii?Q?lI2ckRlCD/QMDprVBdG2bzQH5puKnQU5V/9KLrZJnpybp2LRKQl9d11FUgXo?=
 =?us-ascii?Q?96UElW+8a+yFOEkTfzzzTYDOeF3bRKCPP4E2DamoIc/iUf6JkaKdQgZ0C57/?=
 =?us-ascii?Q?FWVmGU69Jtv9EhokMQA5i7AF7h4rqC9jCZH+WKZ1tsSiScik7+sSb1N/iJyw?=
 =?us-ascii?Q?/1EkdwdZoUxqeflSgjRxdc33csp5A17MeWNBFlb9zpv1aPW5NnXnkiJ4sQt+?=
 =?us-ascii?Q?vqEG7J3uJnhlWHoH8kxQ9KXYCe/6etq/eo0gUukLBsbxeXM0ntsDWI5U8TII?=
 =?us-ascii?Q?V/Zu3oVq1CnLSxf/eAlzBc0flF/KGUBUdCL1WDShg3P/V4zgZ3BbmmCUPUb8?=
 =?us-ascii?Q?7RRHtEraszXcTLp834TUakd5ML/wb0RbXm/3BRranPPHPYPbhWVwFd+aBln+?=
 =?us-ascii?Q?iumPCYSRescmrGQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:52:41.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e1079e-2421-4bfe-9253-08dd1da69e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

Sort OF_LIST entries and also add missing vpk120 and zcu670 platforms.
Compilation is failing when these DTs are exported via DEVICE_TREE because
binman is not able to create a link for default configuration.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 09f487acf0dc..b13079cdf707 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -110,7 +110,7 @@ CONFIG_CMD_UBI=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
+CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-dlc21-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-vpk120-revA zynqmp-vp-x-a2785-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.0 zynqmp-zcu102-rev1.1 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-rev1.0 zynqmp-zcu106-revA zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-zcu670-revA zynqmp-zcu670-revB"
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
-- 
2.43.0

