Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C529F483C4
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C140F8408D;
	Mon, 23 Mar 2026 17:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGPG99e1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2568418A; Mon, 23 Mar 2026 17:09:45 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A7C8406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiKRXkK0zqldyOyEhxEUjtDHc1I4qLKy8YJXF2hfNKMeGfVFKyo+kru5WXv5CW+p/QRS+mnOhZnTlbA3bpbjEkZ79qREsGHeQmG+S36j0txQIwDamePiIyrqtXTpmZ4ZVRf7VjVDQPnHKDCDecSnZ2fkbLa8UiD75ZP8lwtU1Pic9ureodJMCJInXb9T1SMXDirQSgGggfTa5iee8U7LZtOtVV6i9LtQygDAKpDQwG1i6ql33QEVR4Ic65E1Ktt2TFndH1F8bYozJIstx8daEtgYbSkC4ZQG5brpxbZ2YqGZGzcTk3EgJ8c2cyHVy/qPvWIfz86XNmXKVwgKiiSmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56yTLPGRjOP/PAth6Uyx2U6gqnhUGd8kjxVwpy7Com0=;
 b=SsbdCFYZJ1T64WiyAe1kCFZ2fgDTedg5gVDbUJI9fJN+jA9HHhtdYr0dinnPDnjaET8q9W+iIvSqUjqiO2m6ChQUmOAzCA93U0P8ItW40BewpGhQ1izeT7h+hoUMO9gkiYUVvdqi9oYwRsZp8T7/1818onqqQrjC788nuou7YDfdsyN/osvj7E+p/PddxzwQVCmZx7vR2b9+Fh6ardVha5Rn7royqIkIYU9ZuSALwa5Orhaaa8Zb982O1XbRum3BXnq76mGhDRt30RVwyaIt8KFtgnjXg7nhVCObcgchVY0s0/PX9TvJIOxvVioM2BR3/NPrGOG2TihkCPx3IeaELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56yTLPGRjOP/PAth6Uyx2U6gqnhUGd8kjxVwpy7Com0=;
 b=IGPG99e112iyYXpMtZl3PKlHETZGlLs0n0xQnkAPh1HV8jirn2f/aiPjM/AQYq/IlooDcOL0CKy7V3t3rqyUt1En261hOVWa5T6goHPKtwIp5a4L/zLhX1Mr46Xa6vOfYSUVN35dfC5gn4qTzt0AxZU0FN3ru7KgvqmjjP2a9Xg=
Received: from SJ0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:a03:331::30)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 16:09:32 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::c1) by SJ0PR03CA0085.outlook.office365.com
 (2603:10b6:a03:331::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 16:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 16:09:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:09:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:09:25 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 11:09:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Jerome Forissier
 <jerome.forissier@arm.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sai Varun Venkatapuram
 <saivarun.venkatapuram@amd.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: xilinx: Reject broadcast and multicast packets in AXI
 Ethernet MAC
Date: Mon, 23 Mar 2026 17:09:15 +0100
Message-ID: <07ad94eb8a3a9d80273a16a7ac8c7caaba607fe2.1774282153.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=GrNeL26KvwSPUUvPF2P2qTgB6H1/X4BkwUVm0teePls=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQeTF37dp2nSU7BMzXNQ7LGeTxT79qZtC3fU+rS15f1/
 /KSaUesO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiVfmMDOtN+LY/lLF72tuf
 ++HJfJMcsXsGBYqZ1g2/Ncr1jxg9mM/IcMwh5dzfMqWMNMn2e5NlZDuXF6VNblx64eaM1XqXHwT
 dZQEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 735097da-f5bb-43c4-b659-08de88f691a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rOFI63pUcfpQ4e1w6ST1JFfa5oQLmsquNf5lrzSmBmy1mHHhXuaeizpn1SWya3OY1k1MnjYkC5qqoDsW88eVf4yAn7wq36IlvauEVuiJEpyBlki4W/pd1zAholwRq64GRVeUWOfeGzzXRxWbHT0grkfZ+KvI6604tLBicnFB2BqQJXzP9aWZhb2woXeTEjfnZUmjRLWNgUGx1Q53EaD1PhtMvoeVfylJQEao0KIiq5oC5ypCBwFXcujDbaWeTE/vxQbQEfsQvnc4wYsKKXOSQyUPa+GmlglpRVP4Qx7XDer+2d3gtpOIiuo5l2cY8B0Nm83KvaRpEyVduqsIJ8HNZc4U8NWXK1pSNrgT/6YOlnVIzdV1n01dZIxGsEz5ut09VZG9w6uFZ1btDP29alZ5MQMzJVfShITs1E3fjZFAfl1rE1zQ/7t9HoqeivyM7fyxJkHF/RHjzuYJycnZOspOEIa9W+2HWxOQqx3GO19N9VyRyorWy/QBa+Gsrv27YrZSuUiZ2vFTFSOkP7K/yBN10OJJpYy0pbVg8mX89P9vBldnmf93meGJcz6N5SX2tD7fzD5DxTTJb5m8EiAAMXqY1nzi9nYoe80xbVme1+NHIONEW7NiaipsgeH5PvdkYHTjuqA6c9J+0XtQBBIQJJpbMQfXa09VAf6WEjDanYVX+5qMFhClY3tpTqNqza1kG1WJqIUbyqX7I0e1K5XLwBlO8MCC7cuyUHdTY7NrRdgVt1J6VOUFNBdFSKhcPuUXWSM2smbp8mE88qCCKtiCk2x9CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: biChm3IPQGLJfCYnl/L6dtLk8UtpKfArBmbpCEN3MpJsYrQuHnKb7xIyGHK1cWfvs6NseT3tOlnl0Bp/K7n+Vk2kaFwiLeLsvRA5mYy8LHmJlMsT6Liz6yH3sZjNMz0mZKz/NVaHrxX/NDnZIjuIIhp7xTO9xcBHBjxWq02jx6mIFELP0PlxVj5juMk9TIupoO8dRpTd7z4rupHwcNT2uR0mS1TYrjr2e68AZabaKy6K6CNWmMQGnnB0obzXS5L0koBuaqXgBk+YDrKfprxM21WjZ9g4RVOdIklqyfccAFRBH8QEvghCsKNwh/OBj9VCFfkrVrE8R0tdo3OvCbN413e1wGPMRejQXwFH84lAMst+4vJFkPHdwwwRF+9IHO1Ulm+9FCoTAod+nphVXv5m7BJc4A3cRT9rQedlXB/BOjG7CtkkxA396eT6BMb0HNvA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:09:31.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 735097da-f5bb-43c4-b659-08de88f691a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

Set the XAE_RAF_BCSTREJ_MASK bit in the Reset and Address Filter (RAF)
register during hardware initialization to make the MAC drop incoming
frames with broadcast destination address. This avoids unnecessary
broadcast traffic processing by the CPU.

Additionally, when IPv6 is not enabled (CONFIG_IPV6), also set the
XAE_RAF_MCSTREJ_MASK bit to reject multicast frames. Multicast
rejection is skipped when IPv6 is configured because IPv6 Neighbor
Discovery and DHCPv6 rely on multicast.

Expose the RAF register (offset 0x0) in struct axi_regs which was
previously hidden in a reserved array.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/xilinx_axi_emac.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index e9cc5db52d25..1ea81fe1830a 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -28,6 +28,10 @@
 #define XAE_EMMC_LINKSPD_100	0x40000000 /* Link Speed mask for 100 Mbit */
 #define XAE_EMMC_LINKSPD_1000	0x80000000 /* Link Speed mask for 1000 Mbit */
 
+/* Reset and Address Filter (RAF) Register bit definitions */
+#define XAE_RAF_MCSTREJ_MASK	0x00000002 /* Reject rx multicast dst addr */
+#define XAE_RAF_BCSTREJ_MASK	0x00000004 /* Reject rx broadcast dst addr */
+
 /* Interrupt Status/Enable/Mask Registers bit definitions */
 #define XAE_INT_RXRJECT_MASK	0x00000008 /* Rx frame rejected */
 #define XAE_INT_MGTRDY_MASK	0x00000080 /* MGT clock Lock */
@@ -153,7 +157,8 @@ static struct axidma_bd tx_bd __attribute((aligned(DMAALIGN)));
 static struct axidma_bd rx_bd __attribute((aligned(DMAALIGN)));
 
 struct axi_regs {
-	u32 reserved[3];
+	u32 raf; /* 0x0: Reset and Address Filter */
+	u32 reserved[2];
 	u32 is; /* 0xC: Interrupt status */
 	u32 reserved2;
 	u32 ie; /* 0x14: Interrupt enable */
@@ -528,6 +533,19 @@ static int axi_ethernet_init(struct axidma_priv *priv)
 	/* Set default MDIO divisor */
 	writel(XAE_MDIO_DIV_DFT | XAE_MDIO_MC_MDIOEN_MASK, &regs->mdio_mc);
 
+	/*
+	 * Reject broadcast and multicast frames at MAC level to reduce
+	 * unnecessary traffic processing. Multicast rejection is only
+	 * enabled when IPv6 is not configured because IPv6 Neighbor
+	 * Discovery and DHCPv6 rely on multicast.
+	 */
+	if (!IS_ENABLED(CONFIG_IPV6))
+		writel(readl(&regs->raf) | XAE_RAF_MCSTREJ_MASK |
+		       XAE_RAF_BCSTREJ_MASK, &regs->raf);
+	else
+		writel(readl(&regs->raf) | XAE_RAF_BCSTREJ_MASK,
+		       &regs->raf);
+
 	debug("axiemac: InitHw done\n");
 	return 0;
 }
-- 
2.43.0

base-commit: 5d771fc684405b135f003ab3b226e8bc24fd2889
branch: debian-sent3
