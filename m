Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC0FC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 06:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B613080FE1;
	Thu, 27 Feb 2025 07:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mgDypai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 728F580FED; Thu, 27 Feb 2025 07:04:45 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8B7807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEfca4dC7DzIzE1H37dtJT0jKDfXusZT9dOhuRZAyubpPAFK2R2urgkIPgSmvskeBsTDQMD3SnbmnmogSiIc6NofZ3QSPdFr3Q71o3TGM5qgHdR44I5r6D/G5AvghiPj4t/rqNH8xdZD8zj44zO63jykF9GWqU2mkJBUoSa60efOXoceDLtyVdJAptjMJgz63wnNWE4gw9yVqUPSnanm9cSnvGmDMTtUlLYMZCP8UFqtzSLEIi9Jb1ZnoYR2zV00ZgODutb//qS15pjyvMc8ocUXtI4c8pKOx2vr2IuvF4OOWeyhtMCyIdRxaLWB/NcuzIltKnBIwDgOBbnLBh/tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/hfroTPk5Iq13AY9LQCdC2PR/5ds3XnBB+Ha42aNPg=;
 b=wPlq/8t0XxI9/ZblqsOT0CJLF78mmNjFEoZZlNp42FA5mz8hpwgdKHSD2dezhzX7vSwSttRVXBT7MeWAfU8hOqZAwTIoME3puSaVpzTqBjvlvqraSbBP2jTkNWm65//4RHBpY7wwIrr8lBzUqoyen/6ElDbocwez2tY8qFY0Ap3ARUTGgP2IuuxIUoWCT70q0TV1zG7+zZce81aH7dmml6q6l2L9yqanHVbkzRMBdO7aYL5G4ltfVmGhYPi+jUxPmSuwLdJMcix/iNUJBHrZK0EIjRaISXdZWaqZpNTEzMLgjCDJ/e+a5RBi/Y9TG8K2rHx07TMtSvHmV65XM50zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/hfroTPk5Iq13AY9LQCdC2PR/5ds3XnBB+Ha42aNPg=;
 b=3mgDypairWcU37zGKj2zOSaFzch61+12RXle1HrJ1N98TFGT9q8xsdiH1nsciu9XEuB56+HVMpX5+NsX20Az90k4vqNA9fS3BDB21+bgJkkMA2CnpaeZFEUmjb1ixoES45YvzkbBDW+HDQ/ArQQcvO63o5puQAgzr1oP9CDRcSY=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 06:04:39 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::5c) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Thu,
 27 Feb 2025 06:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 06:04:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 00:04:37 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Feb 2025 00:04:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [RFC PATCH] UFS: Remove the timeout while send command
Date: Thu, 27 Feb 2025 11:34:28 +0530
Message-ID: <20250227060428.2070765-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: afe55239-8486-4a46-354a-08dd56f49e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PaJVqwtLh/L1hqB+Q1dzfSQZd1iZxJNPhS/Jegn/epTcJCrdoHcthI9iiOxW?=
 =?us-ascii?Q?AZtI3wYHZxTe95Uo7iIHcLVgcwfaEv/uSoiGW8Sdj726MnXLRO1A6BfvziUg?=
 =?us-ascii?Q?ZivAnnxa+bDmyx0ONZvP1AGVlW0XdZC7e0KpvrWuAu/H0HxSBKc8EqxAp6PL?=
 =?us-ascii?Q?bnx3iYihPLv80q1PcQuUk473MpZF4SJ3Fi7fx9eAKliuBggSP6fl4lKW22Iy?=
 =?us-ascii?Q?EkZ8R63HHZyVjKljdQuLZUWKf95jjzPI33k1mWafU5IqHZ+UjbG1c3fjxLXB?=
 =?us-ascii?Q?hNzZME52noFxxZly21qskOy6GQr5rQMDohnPAW1EzOUL3zoT0gVoRA+9QOhn?=
 =?us-ascii?Q?aCXkzN/LEYU1XYLtb/2kcaJuDvmaaxRYAsQmcYGoK9uejz0oHqSskJcMSqKa?=
 =?us-ascii?Q?ifaxBYWJCnvmvQtbjHCChAmeKwGeClpU33Vwb0fzFQrVfZLAgijDX5DQoXqB?=
 =?us-ascii?Q?AKy1NM3+4x87uZs49vxH801phoTlAzbpWjn/dBKrVurDiS97uVt9Y+07ZsM5?=
 =?us-ascii?Q?gDgqszOjft7542FC/TfhAvMsrdgOggzs452ZDFQkUT/3bbrxz9ulUu/O43Yx?=
 =?us-ascii?Q?u7sy8OPqaXaLRMPmFnLxgA4q9OCqqBmpPtB+szuOLCwrVyl95c6Z395UXIV6?=
 =?us-ascii?Q?rrLayfAbkhPdtmEGpSgM9QUtEiZ6OcpXLZg02Me/NEFYtSUse6KvHEgpvQjV?=
 =?us-ascii?Q?89ZdTuty4v9i6BdLaIcRqsRW9rN3QWpoq4qkAZjNq/RX5Cal3NYL7Bp98Rlb?=
 =?us-ascii?Q?pDzX8iou5STnvGAndp9VZzRKn4uKjJYERVH/oNBrHNNBjS1Dgl6YbF85gZVS?=
 =?us-ascii?Q?wqd5XdI6ENl9nahIPofPzRt8iUMZYN6DOOAqmXfTRXQB3UJDPVNT7eKFuyMX?=
 =?us-ascii?Q?zeW/GPM31dMkeHKNtA8tsxPQZmlawB3qQzDnQouygfCUswYmP/s9s+GbhTgz?=
 =?us-ascii?Q?Ytg40gaxvQyExvfMZAbD0c7pnR6CuYM1nUJIDviv3UQtQDZaV4BrQCtk+5oZ?=
 =?us-ascii?Q?ODEFGyTeNmkIqNQVuH3rd8zb1dJIhQM61jr7wtY1vqZJCacKQvliPk01tC4U?=
 =?us-ascii?Q?JkN8+kBOHvRp/43bp70aS+2xgLrqGVJKagfqkGQfNx5oJanblun4Rfg0rF6v?=
 =?us-ascii?Q?JQ9OkZUo+2lhOrFsAiZeP38bGy1A5cMPGAztJQ7Cs+d8bBLYMdBNtZA0pa5o?=
 =?us-ascii?Q?pQ729VKvFA6S5cM9Z+A1PH4532jkVS628DyARsmB5r1sQ05oFaJdZEn5BldP?=
 =?us-ascii?Q?W7w3bgkOF6dpHCVro0kNWrXVusBvf3+txwfbIqJGC62Ftah/SMVFfaVZa1bv?=
 =?us-ascii?Q?DOwO764ob7jxVlxYAAIhJPO3YK0qtNl8HclHPKYoRff+QYHTtdtKWbuOZoQu?=
 =?us-ascii?Q?5+Pe3Zlf63OfK1riywLhQ9Rhnif+XPndLb+hWtPK7UNyURiH9yGI7ESnpVXf?=
 =?us-ascii?Q?chdtBUtqIJ/HSzWbhrvjkCYVTk9ZKt8QOnOxzkqZAnuPMLhNpVA8fA0ekaUN?=
 =?us-ascii?Q?rEKwsYVeifB67Ps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 06:04:38.8063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe55239-8486-4a46-354a-08dd56f49e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

Based on the UFS speed mode(HS or PWM) the timeout might vary and
can result timeouts.

ufs-versal2-pltfm ufs@f10b0000: Timedout waiting for UTP response
ufs-versal2-pltfm ufs@f10b0000: OCS error from controller = f
 
It's a temporary workaround to solve the timeout issue.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index f7d8c40c448..c3acbd709e7 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -858,7 +858,6 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba *hba,
 
 static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 {
-	unsigned long start;
 	u32 intr_status;
 	u32 enabled_intr_status;
 
@@ -867,19 +866,11 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	/* Make sure doorbell reg is updated before reading interrupt status */
 	wmb();
 
-	start = get_timer(0);
 	do {
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 		enabled_intr_status = intr_status & hba->intr_mask;
 		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
 
-		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
-			dev_err(hba->dev,
-				"Timedout waiting for UTP response\n");
-
-			return -ETIMEDOUT;
-		}
-
 		if (enabled_intr_status & UFSHCD_ERROR_MASK) {
 			dev_err(hba->dev, "Error in status:%08x\n",
 				enabled_intr_status);
-- 
2.34.1

