Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A1FC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0955681FFC;
	Tue,  1 Jul 2025 06:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ra9PAko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D1682EA2; Tue,  1 Jul 2025 06:09:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C587681FEE
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC59vRoNDzh/vbH3YZqyIIDR4dek9fNZkYJaGfvMZFA4hU4qVgbBNAPKKKXzAdJ8RqFnQt7CIi5xOa6NT5EdBjnZkLv+vVgFLEqxuIkaoVzdYBDJGXA72dmXLUR47+7uyedFelsVZGSJmJ3K1mUkbqt9tPjdcbtTNPlO+ACXjbdy/LBkYqyputvvTbkOycY5603VkazZnzGtPGSMGLL5RQjhxIrQ6a3qBJfBV+i9aQTg9s0BXsEvsdOL1Ot/lCdwx9ZwwmHJsK0BpUu1etT8GWKLPus94Dzmccus0GNLWnobOIKLNsX5dwsplIrEtLs3JDMgW+IcwxkXPSXWSX5+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qrHk4JEOGelYv8ieq0jqnfeNCyShSiiq8j525ucwD4=;
 b=r0gqf/IkkCfdU1rGehAriAnrsGHvuD0SzWk+7ysCMo8qy9E0rWFRD0tl+ohSgEOXWoYUb9g+FWp6691GlCXs3Y+ybjRnOm60+nzY3Mm3ZD8k7u+bULhC7qRRN/ldQB12mw0lWlmGj8YIdITpQbQrBHvAwwyHJQvgYYBXkUOOVyT9ypW/ghR0oSNxF4kNS/EOrQUgEKWDhK5OLi3eSpV6cRNGGRueSaAUdvwPt6WmfzXJX1h8X0KH4KfjNue2z4Ue0SHw7cDadbwCDVekxbikkr7aheEPTfH8Dj8fSENXjhXJFl74p0o3WvuNRU+Ei38N9TBUpCkev+llohHGz8dfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qrHk4JEOGelYv8ieq0jqnfeNCyShSiiq8j525ucwD4=;
 b=3Ra9PAko+yGPnLI+kAM81L+B+JP+gt5VsgNIfmg9RecXL1rzTvn2yeSGx8CzbXEtzGm56e08ViTWKaGvvajRcXVDdPSSvcF76DOBtH6kp7jpGaUVXMCNK71ASj8NfIfR1kgbdIaVifyGEU4KBoM6jioRrBxY+vrGohPbczv52mY=
Received: from CH0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:610:11a::10)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 04:09:26 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::99) by CH0PR03CA0338.outlook.office365.com
 (2603:10b6:610:11a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 04:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 04:09:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 23:09:23 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Jun 2025 23:09:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <michal.simek@amd.com>,
 <git@amd.com>
Subject: [PATCH] mmc: zynq_sdhci: Add emmc hardware reset
Date: Tue, 1 Jul 2025 09:39:15 +0530
Message-ID: <20250701040915.530912-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: b667b9ad-1769-48e3-5393-08ddb8551150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ExHj32sQnlWYU5h1MW7lUMJXP1up7nrJQOWex3b6w46smOwkCKnSQ+2FdmuE?=
 =?us-ascii?Q?ipGLeQOBN7Zi2PsDUDScfl7K9GtmI5eRBgpRnJg3N5EEz4wuYk2872qGbKkT?=
 =?us-ascii?Q?LZN01VPny0zp99bYtbKxcF+FxPqxcOI8YLhm6r0RPRdiw2tgYaSj9Zmgd7au?=
 =?us-ascii?Q?1IpwU6nX0gZGBWmsUoEZn+nQ1+NpWWnaXTeu3YkLt2itttYvWLSQMeeosT3f?=
 =?us-ascii?Q?fUMFii3OODGbSrDoZtnuyooApLU7gxc5KtoaHKlO1suefOEbZJpyjdHsBCVb?=
 =?us-ascii?Q?4hBRs7uUCH8HobZFRXhDLQNR2g/HDUI6FKhPR6FnsnV0rrDqbieXDlZ3wf49?=
 =?us-ascii?Q?G5+jG+m+DzkQVmVN0JqLbl1hr9yi7zqPWetGn3vbWyYAeAg+0x6Gt0pS/XBo?=
 =?us-ascii?Q?lTmVyFcEzSm9qZYRTKV4J9ZGiiIgDbO2vPZCc1kwQfHletAzQVkfcBmjw6Gv?=
 =?us-ascii?Q?UTBD5lq4Rys20tyQ2D4xmjntlYHE3jqDQH5nwBTh6caQ5yBI/QX0yKplf7zI?=
 =?us-ascii?Q?/WtDxYflx5+fqofBMTHRuKnyaQn+lgE35HoDHzd6+tFH0z8ogtl6KB+KDfVJ?=
 =?us-ascii?Q?j9CaQtAYGRkjIbBUB+JWvgNYdllhJ/Ekk2l2PcJGupS9MtTgnhXJt5rHhX7c?=
 =?us-ascii?Q?lqcCnN75Jf+iTSk/09zodF1Hk5QynS8gSj97ZZv2izy1S0fU8T55y9kkysta?=
 =?us-ascii?Q?a4ZctA5BBKnh3zdLXsIM3OpaU2fGNUQGTi9ESmHn4Uxsg8s1g72SbD8VKkQv?=
 =?us-ascii?Q?DYQd+1IkW/q9GHE7Zp0WjGRn6f4VDJiDuKYNtAMK4kgyt0p3xUSAqMF4aRRi?=
 =?us-ascii?Q?iiKFcYTbVRR9Q5HQuC43R86gCgcemZiBLYWxawdKnhJRueqQBIKhgt1PVhn8?=
 =?us-ascii?Q?WSapnkPH8+3dNCugbn5RFDQmnZILurIEDE1Bq8D6xw7KirlxAyJB3o+FB9/R?=
 =?us-ascii?Q?ZY3Rzgi6fwBSf/DVA0ILulcT9rog0G6SpRWpKQ9ciOPCxrWnhVy0fFBoc2bI?=
 =?us-ascii?Q?eUo6Lr5CGmZ9XsFliMTPq2UbJhE97Z8ooKQrswFSpZhpkigx5IcXWP37SCYT?=
 =?us-ascii?Q?ETwc+JYwRprRrE+HefL7lXWXvKd9Va72siv+xyKYqXd3nBdKGuJl1Hre3nAW?=
 =?us-ascii?Q?Lbb6Ja6z59m0Ujo+C+/DB+FoKYoixfIJ8s9J46lxUGXXDihEUZR/wy64Cqhu?=
 =?us-ascii?Q?8pEU5j0oMJmFpBnvYB6O0qSL7SAATfn+OmcsxYSWzP6RthfSiX8PANGcbJ9v?=
 =?us-ascii?Q?haL05CuPLZAuXtyoQ2Rm9z7Xlsi4ylpA91RKCu2mUMM8laDqE1Qnw3OpCVS9?=
 =?us-ascii?Q?XXaZvHuTIiNuEjhuLu8HKrT4p4F8rrzrN0xWn9sBOx963XB4epsWI7vzF8yr?=
 =?us-ascii?Q?nP+qDFSo+WmwB9txk3E/DcK6UUXIN+1I7tF3N9JjotRKeEuTEy3WVNp3kUDG?=
 =?us-ascii?Q?Ok6E6z17Qw55RKSlhRgr7eb5GVPLGJv+HF0puxpXDI2Y+KmGXaFG/Pu8OZ6X?=
 =?us-ascii?Q?C2LYKZsny2uZLo538ltW9T260p6WhjCwrSbs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:09:25.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b667b9ad-1769-48e3-5393-08ddb8551150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

Add support for emmc hardware reset for the emmc card, trigger this
hardware reset at the end of arasan_sdhci_probe() function.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mmc/zynq_sdhci.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 4d1f92931a3..f99d464a467 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -85,6 +85,8 @@
 #define VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLL		146
 #define VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL		0X77
 
+#define SDHCI_HW_RST_EN			BIT(4)
+
 struct arasan_sdhci_clk_data {
 	int clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
 	int clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
@@ -1101,6 +1103,21 @@ static int sdhci_zynqmp_set_dynamic_config(struct arasan_sdhci_priv *priv,
 }
 #endif
 
+static void sdhci_arasan_hw_reset(struct sdhci_host *host)
+{
+	u8 reg;
+
+	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	reg |= SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
+	udelay(2);
+	reg &= ~SDHCI_HW_RST_EN;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
+	udelay(300);
+}
+
 static int arasan_sdhci_probe(struct udevice *dev)
 {
 	struct arasan_sdhci_plat *plat = dev_get_plat(dev);
@@ -1221,7 +1238,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
 		}
 	}
 
-	return sdhci_probe(dev);
+	ret = sdhci_probe(dev);
+	if (ret)
+		return ret;
+
+	sdhci_arasan_hw_reset(host);
+
+	return 0;
 }
 
 static int arasan_sdhci_of_to_plat(struct udevice *dev)
-- 
2.34.1

