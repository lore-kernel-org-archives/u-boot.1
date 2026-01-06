Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A66CDC199
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556C483F54;
	Tue,  6 Jan 2026 13:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EtSSBiDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE1083F5C; Tue,  6 Jan 2026 13:59:13 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA3883F20
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLLCYk64isBwVSJTU2SHkJEsWeBhbYmifVHFx/2F5jxH/HxL30ZmNs7OGkeeivpHG/kRxaLUNmKXeKmG25r42JNhHN3HxNwZG5kiRrlpzZsJ8ojUr0Yarh+Mps/ZvHAkbhlJkTQOeRcr6knFot0lMF5YHUYFwL60N2flSf/7sX6L2MgeiXuIa++d3okw18DiTib4HXQG0xqM2QJE09oYOmB4/KZdszv61o8frEqK4VyihP4dpaEKQZUuleo3irGvIGuIIZ70cGS//A3xk+qntcNmBSed75xZitJ/AV9e1iFDFY9vSsPQCDQqQbP6izfhy0iGAQZ72I+UCMK4FHw7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9lyg/7Jw9Bka73rZQb+4HC0chW34UTOUhi+9gQBVyw=;
 b=mHqBU1NZZfl+kctK0Rg4a2+SuckUPdU47kvdj/38rXAvcifEYkAYPU9NZ6rdZtzBCmXYRc29VmK6zA3Ov5fAhDjrEFsPalAnkmC0UaWtu0jN7oS1l4kn37cRswRXf1bjyvdop+Vx4cpEee6GfPr8A6tPR2CtCnjyMncIv+KcHp8d2JgNmu3iBBUtvX2JjRGEE3HVNFP9k001Uja7NOJeYy0cHbVyaizFvTDIa7BZlxCR05fiwjMa4JrR2XgocaRotuYPvZsU6Hy4KEm4pRAcC7SmubJZBFmBhgCxGvcc3v5n/yy1IYjzm+T1z1MFZTZUUvMZxsZJ/fQYacaId50z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9lyg/7Jw9Bka73rZQb+4HC0chW34UTOUhi+9gQBVyw=;
 b=EtSSBiDskc1Ba2rYrgDLOAdtGHbLNO+ahRKfFIwVZwIFZiQR/ncdJYsHK/sWxXUX3NwF6OrUcpxbFvFhgTSb6yWB7dZhBKd1a/prAErms+5I/2qD+7sWStLwMpK6WweQ/usdhqVTeFUauhaCcsgP1B0PCS9yZvf6rniab3vRii8=
Received: from BYAPR11CA0107.namprd11.prod.outlook.com (2603:10b6:a03:f4::48)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 12:59:07 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:f4:cafe::fe) by BYAPR11CA0107.outlook.office365.com
 (2603:10b6:a03:f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 12:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 12:59:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 06:59:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:59:05 -0800
Received: from xirengwts09.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 06:59:04 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <igor.opaniuk@foundries.io>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] board: zynqmp: add cmd for getting boot auth state
Date: Tue, 6 Jan 2026 12:59:01 +0000
Message-ID: <20260106125901.1491300-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 68085ac1-390d-4357-9209-08de4d235ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bLw40batUB86P1YItddNJmkiHYgwnEfO+EL+9sG+40vbR2rh1vRJtW26tbyp?=
 =?us-ascii?Q?IFoIHeLSXg6roRYAepPKEcW+xJRfBsX7v54goQLv0QHDjpeWYzhNsUkkFXPx?=
 =?us-ascii?Q?GTY81/MNIrBbfzs6tHNzqfH4SX2DJH7DQ8kiCDVKxN3EYBzgypfStZGxulbn?=
 =?us-ascii?Q?XdO28X6rFFV/oop0aamJyr9zBkfH4OlfuTmZFKTBCcw1mhBSjP8ty76FwxzL?=
 =?us-ascii?Q?djB6kqOeYAMmaZBoeSdpkEQFm4KUWfsux33Mi1+DSVFLWoNmp6QvpJMH91BS?=
 =?us-ascii?Q?D0yHWJhFWAW7ahytvkZnl+NVOB9iZ7NilSYi+GOpc2hU4hPKazc322Vv5ECb?=
 =?us-ascii?Q?ursoHKyT0KylOJQCxz4YT2dqH05wCk6YS+nNOoPCqucB1LsjvKLg0MVSXpZs?=
 =?us-ascii?Q?WvxKRBzzR86mmO9P18/eJiNS/ZYoa/vGZr8+F/LNPJCqvWMUauvbsaxaQ60q?=
 =?us-ascii?Q?Sp99j7xTLoOK35mc8gCBlifv0A3BJgptUclte7Y1zLN4mKZzfv/We/o+npRM?=
 =?us-ascii?Q?hZFXPK6FXCUTF4Z1LOsmEfML52vPnzqstcM51F8yKz256b+BAmG4yB7nJIk9?=
 =?us-ascii?Q?/c97oAFB5SxgfwgTa8K3SJWkyuklrfOXolh/MMV5FuLTorZpJgQxeRki9Lxf?=
 =?us-ascii?Q?byXMAOersqJnD83frvsH6WZplv3oUXtLT0AojV1zjI0Tqq6npfhoORJ9KmYQ?=
 =?us-ascii?Q?YAFJdCNqtXfGFYf6036lXWnVYyGU+NSMQVeD0hSDB1x/orY2bZmwYgYnMHyR?=
 =?us-ascii?Q?yYeKAaW6tsA6VD4iA1TJ08tzrsuAT+SqL9DsklMvbEZYLkKgN22UJX/nttDy?=
 =?us-ascii?Q?Z2Jpy84hc7xpT4MaEk4A7pgNhuz1675smFE6ChoFVUPDLd4OkNPXhrCjtUNB?=
 =?us-ascii?Q?SSVD2umt0sycG2fevc9IH8nZzu9HtYeEkthY6SGhVfN5w+UF6ZjNQgQtSm4A?=
 =?us-ascii?Q?Dz5pQPRsqCPkdLSEaHFTxYg9WjVPnRUqCqtbR/ZdTMU028EmCCU5m7ATWqMn?=
 =?us-ascii?Q?+4kEHh8AG6bmFqKLxoXkemt4wps9HyihYyXk31fuduiNtzIis3bZpLRzZuIj?=
 =?us-ascii?Q?5ePVAMQH0wa2nhpFf9bVwvgXyXvxr1BUlZknwpJ+mRA1GByjbi6JNlwal7M3?=
 =?us-ascii?Q?6J96IaRZbSZoZUu8BWFUH97IwFEfLcOFwJqfMkTy8CILEv/ODwEm0ogaWE9J?=
 =?us-ascii?Q?y1BeW6wKNfiSm5VcE0V2yU1AdM+MqmguxnTPbKFq/Uox6OFeK0tvQHJngiGV?=
 =?us-ascii?Q?Mkn0bcbHSRaDvxtScQl8KamjCIwNoJspOCb+g+SVE563D2Upd2FUkcH3AKv+?=
 =?us-ascii?Q?CMMfgb7hxU0NKKa5oJTowOzSjHEP08fNFTSV+PtVx+hzcnU3O/brBR/vXR/p?=
 =?us-ascii?Q?/pehoduplQ+0gZXjyj5OYdgOBMGgNH4GnAHHyDNGh0BHWMUKgB9zC6RQ1FB7?=
 =?us-ascii?Q?TFqa1gnsoWWT38gWWw0Yuoc6Ln1hVqwf4E//sstFirGvcoon6EC1xMhJ0CWv?=
 =?us-ascii?Q?NxHJ24SRcDujK6YYTyTu4Mp0E8uwykbIstLSV9qkIb9P/pEmkCvhS964MemY?=
 =?us-ascii?Q?tWIgQB9rYIXe6IDPT10=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 12:59:06.1651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68085ac1-390d-4357-9209-08de4d235ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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

Add command for checking if boot was authenticated.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 3b28ba62374..92351aca36c 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -149,6 +149,44 @@ static void print_secure_boot(void)
 	       status & ZYNQMP_CSU_STATUS_ENCRYPTED ? "" : "not ");
 }
 
+static bool is_boot_authenticated(void)
+{
+	u32 status = 0;
+	int ret;
+
+	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
+	if (ret) {
+		printf("Can't obtain boot auth state");
+		return false;
+	}
+
+	return (status & BIT(0));
+}
+
+static int do_is_boot_authenticated(struct cmd_tbl *cmdtp, int flag,
+				    int argc, char * const argv[])
+{
+	int ret;
+
+	if (is_boot_authenticated()) {
+		printf("Board is in closed state\n");
+
+		ret = env_set("board_is_closed", "1");
+		if (ret)
+			return CMD_RET_FAILURE;
+	} else {
+		printf("Board is in open state\n");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(
+	is_boot_authenticated, CONFIG_SYS_MAXARGS, 1,
+	do_is_boot_authenticated,
+	"Check if the board is authenticated", ""
+);
+
 int board_init(void)
 {
 #if CONFIG_IS_ENABLED(FPGA) && defined(CONFIG_FPGA_ZYNQMPPL)
-- 
2.25.1

