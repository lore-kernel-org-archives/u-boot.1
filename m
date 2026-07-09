Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC34C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7173884A3E;
	Thu,  9 Jul 2026 11:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LiCMYp+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A0E84A3E; Thu,  9 Jul 2026 11:19:52 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AB584994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEK1+ot3Bpf2oJHm4x3y9EkCAkMAGTs+2TGQTLQSq8q+ovtbngy0pIviiP99ofdNG7MICptlb8iJkfAKhxkcNNDxIvRklCVyIt9iYYuu2ZDvpjNjuWeM3r0DhCT8DsgfyOSOchLTRk2nxCNeNnw1qsad1TedTXtWL1gwnUm9StV/L5GX5T09+95r7mwqLUj4B18jMgkd1Iz/XBzbizElItKG8nUXK4QfDEtIfe5YdiX7iL08E3uSFPECKFQZUwovOak6lMiGjuUXzSwZw05b+TbIAyxVlm5tyGcCUHquDL/DP2BLmdUHuLVxYCM1DDrS99rDF1PiHO9lr4vOu1ChDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef4tTQ/dfz2CcZ+4dxOUJJ4BzuvcuT7ggUULszD/Qf0=;
 b=zFihD9Nr3tEnySpUFhOST1gaK+GvLtbte8zIa7N1Cu5lO+lFMEZweAhcMLjW8n8tOymKOmmoM8FHlB2jiO3keP5TGN+Z+epel5B57pWI7fAXOaKPGrEl5uua8kczfWn3jzczDfUbJfuYDj5B2HynQSSvpgP31SIGR4cekay+17dhXoJsAPqLe6FDHRRT0BACjd/7QUbKggzJ2WD+nQlu3UA1PnpyYEZZErzomoTG110HKYuhE6KyTn084MbbYC/hxGqmzuI4q46W5NAgqU9+z8Evd3kAvwd2MtS1NmU0qvtV3ISiUNMKlgfVPqEfSjc0+wu8r4iJx+qy86Em8RQVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef4tTQ/dfz2CcZ+4dxOUJJ4BzuvcuT7ggUULszD/Qf0=;
 b=LiCMYp+EK+HSC9U3I5Pm+5cdB2tJIMxv3OeTiG7gwSb8KQV6Ck86yS8/UyAAwwWJimDfqQ52rahCRK8MmcY73Oy8PqGUt8dMZd8N5ZooiDU7Y0wWThTtUdVykSbxFbUaGk8Hsv/DRmZVY/34PMwT6gxm4khqupPRKBlzwUaCtH4=
Received: from DS7P220CA0106.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::16) by
 PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 9 Jul 2026 09:19:42 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:25d:cafe::6b) by DS7P220CA0106.outlook.office365.com
 (2603:10b6:8:25d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 09:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:19:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:19:40 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 04:19:38 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 4/4] i3c: dw: fix slave device setup after DAA
Date: Thu, 9 Jul 2026 14:42:55 +0530
Message-ID: <20260709091357.1860417-5-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 43531b5f-9a6c-4c94-428e-08dedd9b357a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X15tuqkyI7JMiAx/G1XgCPjJYjUtcxl5nrYbkND+y+uOpTV6fDBeQ2HoyxLA1ymWG5kfV++1vLNC4b66iHz+38UTKsxcBrKANxAKBFFtG+hlgoPJow2QugS7iNNFCYNEOeGPLmxtC7MgWy9yNOyhpnnOSo2N83V0Q3XNdrJ3lmAVRtNPHpkdceaJOVqnjyE8kAoK6pIBHt7Yl5tODtiZTdnaKiVPQCLlHXhKrJkOnLklwZH1Q3ZAvOC+CiHSSEETiokw4OuVoQmAMbqDXLSScx73VpwSvjeSLIjgey9ZxRwUeweosK7wLNhO2Qxapja39bg0nXfPrR0Jr9m2YSAm91h91otM5xuqHERmTzwgIpsfEGK9+tRpAxIlD6jf59bmpMzTuC2D+piBcWEa+BlWOCyZ00O4d+KWtlFcugQOBYTq2SLHEX2fsHDwmvGHstYlg7LbiJfsr1TOnN6Ez74QGu7h6pyvaMV0E9ybTY+00HHRhlvbWN4zioHYBg0EvswNPCnoA0D7F8EVJLeRNKudEKVGDiHhd6EzLH4XyDHhdWjAmJhFpa1y6wZGTAG7Hhx7mZ2boPR/ZMb5saGB+QKfZoVkiZjVQqYwFhaouzDK2DJ84v+IBwFQET2XtrFuEA5FyDCMR5dQAYQ37Gm8ECjxGMxKQmxrrz3IvK2yQpDvDWMIVL4iIDs77RVtBc8YD8z7tmpNZ+lJQdLQBXdxaQqQIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W1K+svcoHBA+e38TX2Qlom2d71J6gk/ZD+B/0x7fKGeWHAhSIawRJmwOXgtrPgqWQocx7bV/IxylNurcsiQKo9HnXWqeEx4RSa2diwX5sp4l17kfHHYpM7TKXmjHL98VU3na3QnMpVGrc1SMTPiLTi/SVqEaUnldqR12SAk/fIokEA8r4ncxkk7Guo5JlkAEyXZ6CX1xIzgMH0OLwqTcw5wjt0fr7PuBvfti6Dk8xvHK1+UDobw+dmFh+MoSdA9HP79MY/FVTIiqkr7bOMynmedymjq/IGRgGQn92RcgGI0W7luJsXzYkvLzivdXIEgMlZ7I6m5+lP5oGe5DsJBQuLhqiqiB6vyK00Q78ddBxD187wkv/yB2MIJkpWcdsh2h629Dd1ZKS4KLhhxAlBNiKGjU4Jo6EPkbbXi7J1KmyCPLfuSeGdMJ+lgC5JLY90OZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:19:41.9251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43531b5f-9a6c-4c94-428e-08dedd9b357a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

i3c_master_add_i3c_dev_locked() incorrectly set master->this to the
newly discovered slave device, causing i3c_master_attach_i3c_dev()
to skip the attach_i3c_dev() callback. As a result the slave device
never got its master_priv (DAT slot index) allocated, free_pos was
never updated, and the DAT entry was never written.

Fix by removing the incorrect master->this assignment. Store the
slave descriptor directly in master->i3cdev[pos] inside
dw_i3c_master_attach_i3c_dev() where the DAT slot index is already
known. Also check the return value of i3c_master_add_i3c_dev_locked()
and skip num_i3cdevs increment on failure, fixing dummy devices shown
when no slaves are present on the bus.

Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/i3c/master.c               | 1 -
 drivers/i3c/master/dw-i3c-master.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 019167a2dc5..1cf1ffd99cc 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1443,7 +1443,6 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	if (IS_ERR(newdev))
 		return PTR_ERR(newdev);
 
-	master->this = newdev;
 	ret = i3c_master_attach_i3c_dev(master, newdev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index c6ce54a1d3b..25933adf010 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -671,8 +671,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
 		if (newdevs & BIT(pos)) {
-			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
-			master->i3cdev[pos] = m->this;
+			if (i3c_master_add_i3c_dev_locked(m, master->addrs[pos]))
+				continue;
 			master->num_i3cdevs++;
 		}
 	}
@@ -806,6 +806,7 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	master->addrs[pos] = dev->info.dyn_addr ? : dev->info.static_addr;
 	master->free_pos &= ~BIT(pos);
 	i3c_dev_set_master_data(dev, data);
+	master->i3cdev[pos] = dev;
 
 	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(master->addrs[pos]),
 	       master->regs +
-- 
2.34.1

