Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9310EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A55980214;
	Mon,  3 Feb 2025 10:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uUQFPupV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CDD780568; Mon,  3 Feb 2025 10:28:30 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9D8801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoZj1xeG//OgqLQXa/PWnC3K84aRmQ0wzPXKGJXwzpExtf6OYL7j4fQwzmaVTPKcJUaz4vhYuS+kmKXlC4sVZ5M0APK6GUapht8lv5Yzqu+tQf63uaRdeFHFPATJLmpur7HOCpyPfMcNeTawKpRjz+WLncsaJRIm2KvYUqPST69FeeUf3/835d7qyIsNDKcZRp5vyiNAjWm5ixDRxnL7u+ITdRTStm1lZ0jyLQ1VLNY99TQZ2h8zL0B2MqnqKzB7eCZB11lENuoIGNwZm9xcKfERTvFCf2NoXHcol88SSiofwztltyp5Fb1s/SyXhTqMGeaXqn2gyVRiVAkTTLLglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtVi63PBt/V+Nz+FS8tqz4sxXZEOzr0z/TBkOeuOBgU=;
 b=dxfpKnhuF66bua6fEs/FnScM47U+mtImGcVe2Be7VyAZ7liHeaJ+3tNLSQRH+C9c2hyhoZm5eTusRsPFUpUto/Gs0VVae4DcqWLvTuXMr0sNeUNSET24QFdzHBlFjUYUrp4KpmxSHj1LXiZcthDWCRddebCUDTKWSFTrLeudOpWYXlC9uo0FMOOMiT0kg1ZwAQz9hrc/GJ9fwg7TvcV3to6Bw5whAOuz66LFP+1QkIOTR3qCQtiBuasebWDpXMxdB6hjPi166XJnpzOVeaTjDjFFPEOfBO5bX8MPcDzLqLnuiO4clntxjpbsvjyfFNsJ7ykEELcrdtH+0STWyMkhHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtVi63PBt/V+Nz+FS8tqz4sxXZEOzr0z/TBkOeuOBgU=;
 b=uUQFPupV5BgdaZ2YT5HoBWuGMqga7gu3CywK39sjV9EWaN7N8v2jrtkYasdltfVBk+vIBoCbXiAunoQQ/VE8vJvvf6FU4FPTUMYr3UKR8ALUbi5fp229GRGz0AKT952U8T34ZZlDI0pqGNqIjQ3adzr7VeRmpIo8SXFJf7Nyw2A=
Received: from SA9PR03CA0015.namprd03.prod.outlook.com (2603:10b6:806:20::20)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 09:28:24 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::34) by SA9PR03CA0015.outlook.office365.com
 (2603:10b6:806:20::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 09:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 09:28:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 03:28:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alexander Dahl <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fpga: Make do_fpga_loads() static
Date: Mon, 3 Feb 2025 10:28:15 +0100
Message-ID: <cbe93e4eb33752aaddc943b15fd04731d4f75b68.1738574893.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=q76uN4RdyCJY9nke8P9qJJY/pZeN7lSsiv4SmBFBOFs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQFPYa3pt2RFeN3sBfmeuXq2W2gknz3dLD7qZnaurZyh
 dH7rWd0xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIkYmTLMr01lXeKhKNb2rmgS
 1+VZFtudZoXNZZhffJC364nHC/GZZ+q99T4fnnZY58NEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e2db6a-d9e9-4b83-3e8f-08dd44351b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLhh43DFflfS7wN3kP5fL6Uv5qwqsFMSx67a40jchmAWEVcZ9Egg56O6fGGu?=
 =?us-ascii?Q?0W4avYKm2vShdKrPhNy1eCOKeTpmprp2nMOc367b/DvlCkYJ139HbP/aogEc?=
 =?us-ascii?Q?udiKOX9UUwpj/1UyL/LGbjZWGbHD+LHWJzPg6j5USEPEqDiXNt4++cszuXd9?=
 =?us-ascii?Q?5cAYq7K9kdUvbQfpgkm5MX7zzFTUBRaBNmue51m2EOpse5q75BDZ2ut5mYiC?=
 =?us-ascii?Q?Q6Xf8UfT5z7wWhLzN0YnKs1MrOBTO0D+YN9zgW8tlMd+zFdxChSxAZ2LN7z3?=
 =?us-ascii?Q?nZDtmk7jfc/hDtn32Sg+UzDvghzNde0v8ZbqBcotrhH2uTNIgyJswBOXg6Io?=
 =?us-ascii?Q?z8914Q8hCqBUKkw1ATDRsNWnVm/qr2RdSUVzJ3ZrM4ZpF6iOUF9/+14Z1STm?=
 =?us-ascii?Q?DsowD8IfynqEN5aUusD4QVhN35c1UX4JS1UluMYpymgGQDfaysv9uCBU9DCA?=
 =?us-ascii?Q?ipebNUw7xilwkomJTzt6HLLxS7t/mSKCXFVIGIjwx31xNi5WN9dPxJbwCTuA?=
 =?us-ascii?Q?0V7mUHsutG8zv3u7t/H99+vgR6m0R1fQMTnPU+L9cIN7U3hZ/4L2jZiaIpFK?=
 =?us-ascii?Q?Z+xUm6AANRJGAamZFb4Mab+BryKiXcUf8Zy0Ss7w4kEklVuj6GgpuCUy/evo?=
 =?us-ascii?Q?6W6D5brgKsrF2CbVH7UllToVEGUK5nMSJ0qtt0NERIGVKuOzHNE4SnWSt5y8?=
 =?us-ascii?Q?YIiDE4kVc/kYLjpVbS7VtYbXGvd2KvwVYISMtaFMQFTo0XO7A+v9VuUjxAoF?=
 =?us-ascii?Q?BPZIemSnVl8f6ZDdViprJj8bt7B1xOOywaIlZNWm4PLoqCPQJyWrkISt1Z0p?=
 =?us-ascii?Q?OAjc6Orm0nnzh51yc7zUWlyZF3riOU+k4pJx05K+U0DpRJtsbq5iixnpJqTs?=
 =?us-ascii?Q?HlznhoVrLGjBTfQ4JimymNSyRJIf1dgM2rqyZGQAraxHYRKJBLSFEniHjRFF?=
 =?us-ascii?Q?onJrtEi1hqUXWe4bCjM8zIaKu6RT1cNUe7fhaHrim2Y4NF75/Xg0daJY5hyr?=
 =?us-ascii?Q?qLycPX1WH+Q3bJugB1yZNhSfqhn02QhNV6kghSajF8gc4EvvXXDXgIeOZYAS?=
 =?us-ascii?Q?orNS8vagehNRz3xMEH06oT/HmAMe8ytgzsqeXYHWLyPhhYQ3UnRSwgYkVHNH?=
 =?us-ascii?Q?I2ZNoxrFLGcnkL8yyQENRzRHLrq4cjQOEI4BVtnsQTQTW2blBZ33wZaTtxoj?=
 =?us-ascii?Q?MVjBgX1gcNH/APqkpuqoZ5GXHb3DjvcYKcR/3B+LweFpjwmwMlkenbyxCbmH?=
 =?us-ascii?Q?C85t6RUsGvOC/v6rBa5ClTdhVmnrIZkBN+MnSzdtIOUMO2w9oXvIt1dAkn5x?=
 =?us-ascii?Q?J/4kfkdyf2ulBe1CO/fphRKgaJNuqhR6UWekE9B0q5YFK68XESYCk8ufZOwV?=
 =?us-ascii?Q?uc7kYG1K8Z1reS8YslRFV/kA68a9smpgOJp09vpgUJt7Tw8W+EAk+e7WXeaa?=
 =?us-ascii?Q?/suyUek9rRWCuVrfrDZoo7uAZ1zGwP3x7KsMUIFQnTEbHY+wId7VAvOZfqAg?=
 =?us-ascii?Q?vo7OBccv8m/B2J8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:28:23.7306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e2db6a-d9e9-4b83-3e8f-08dd44351b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

do_fpga_loads() is not called from anywhere else that's why make it static.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/fpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 212f421739fa..9dc7b63db5d1 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -67,7 +67,8 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
 }
 
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
 {
 	size_t data_size = 0;
 	long fpga_data, dev;
-- 
2.43.0

