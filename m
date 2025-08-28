Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB1ECA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 04:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B163831B4;
	Thu, 28 Aug 2025 06:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkF+6biI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00278831BB; Thu, 28 Aug 2025 06:58:23 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232C383106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 06:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3+6OwEpCsfbuJ/fAUL/j+ffaHL1AIWq0zfiA5ksLXAhegHe1pGYN+3dMmw9A7xCW9syfvvoRgoWCw28SK30EgaFZxkEt8lrxYZUMGY0IwiW5hutA2ia+8IoA/dEWr8PguPX3BP11aAAKYNxKIO53Ad3TCDMj54AtU/PGtco4uRhDyXONF/rk9OKtqkcF8ouR4Ha40ZZS6wqYtKlbYdJYXmGKJ3JjFW7nEPHXXMMkZvpR+loSIZXu4nyz9OGOyD9t7p7pCl/IJij7R3kztQqScyw/7mMcEt6ZfuDp+SN5UbBMwXFMkOTZIiKEznKxSvcvu+iQP6UysyGq7b3+aDbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ0J0arsrc962xM3FMvIpPQWeAAq0yKQOzoI9RqeCl8=;
 b=wiyqiVZtn0YrKrYYHX+khSLzvHyZpkwtsH9CXbO0SUlmCI/qkrL+8OEXxM5h1TM2CDSBFc3jbFUsLtBJRj6ZjHw8R2yFqltrlVjcO5Tq/+4ofHQHK1nVsWrYY92egiKGbtcnzIhc8wsBvavkNQJKWaoNLdqlRC7WFQKZxr3n+o/Nc/Z8KD4eoDpCg9pghfKcK2ex/d37VrWNfM3Vx8KHeSYyEtW/E5uXjwMlGUeNRrGmDIHyCxNQsG6tcigjjyESXnGVSNKu6vMPwDTay9teZMBUrWYrlDGYFJkkFQlqW4EpEZXu9w/Vty7P9QzcmLe8ssBn+gWmB5hvxAeMm192Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ0J0arsrc962xM3FMvIpPQWeAAq0yKQOzoI9RqeCl8=;
 b=WkF+6biIkj3Ob5H4H/esvrdkExBm5dThUMpy+dVCu7OMdIosVWaLhwm0DWqOs5L9+/3ZnSIwE40z9uleIr6q6kw0TsQE3bor6+AoSmURnxqxvvv3GzvvmvKpxPSdfitEQUWdxwOQsRopOArWRus4qp3JC07Ngi4H1T8mt452hQ4=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 04:58:17 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::27) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 04:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 04:58:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 23:58:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 27 Aug
 2025 21:58:15 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Aug 2025 23:58:14 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@amd.com>
Subject: [PATCH] drivers: net: Add versal2 10GBE device support
Date: Thu, 28 Aug 2025 10:28:07 +0530
Message-ID: <20250828045807.426542-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a06a45a-591a-4142-f13f-08dde5ef8054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NG6kYAuHdi2D5PefIgRVD0TnyAO5JthmCX608paUKEmoUChYG5v0niiJH5i7?=
 =?us-ascii?Q?ptVdOqxVI0DMILZEutil8r5wZp+EhLUx+fIx58NBcNS9aDnH7ijYvHdHnzWa?=
 =?us-ascii?Q?mxNvZ2wiQBF2Aqy7nwGAfgPB4eh8KUIcx3Sp+ywqARDPUWQlYdk7fB5nBLRL?=
 =?us-ascii?Q?LHR1VR3fRh9E1pw51r5jV7rlR8EfWBALL+qbiVrinz4FARYUT4R72vhhDwxO?=
 =?us-ascii?Q?GFoFoZkwLtaIlY2Wra6tM8EmRWc9XLgjMQjY1If0AO+VCnxcN4tiF17AxNOJ?=
 =?us-ascii?Q?UGyOYhB55FqT+3myqr111Y3GYQYbZu/vb1PvkLqjEHonL43xoldPnv0o9HqS?=
 =?us-ascii?Q?8WPX+ceSAjrDoT2no8UadOVsXOh20j2Y65+8XpnSgBq58Y6l9qtoZHAc+0A0?=
 =?us-ascii?Q?nUoV13iUy7QAJzN3YXTOnuU8ULEMo2Vs8c6sc1Ml0n2xD+raBysi+gQ0AG68?=
 =?us-ascii?Q?W4N0bg2KDpH1xpu/KKP/BGAvra9WW2AjfyK3ogqaxbKJP+Ewn7QQ+E4w8oge?=
 =?us-ascii?Q?5IEP/0tk+noEEZiNV5RHH3KU250kfBbIgtADhzJhlaUNx0K+Of+p3oWzs7rl?=
 =?us-ascii?Q?QoV6Js8Yb5id2H+2TbiQYe0QZHqUxJAiMXEsUKI8HwCQM6PBXMI7sYmHn1Km?=
 =?us-ascii?Q?aMcc6tN7VmKguGyFRMo1JGcYct0FcP3RxJ44ki600L3GQLHdZj+sqUrXC1u9?=
 =?us-ascii?Q?ihTZZAICjyXqy9kbuRKPT71vcXzPK+2XGrvsHCwDZF5EnhWJ/AWhPtERvaJk?=
 =?us-ascii?Q?JAauShiVahwKSU2Q0Bn/459AOYZjksLdHQrp0UJblF+D+oNOM7DS+HkGZxgX?=
 =?us-ascii?Q?uS8bonVzF4+3jFHezMNPkX+C1FcryvrJDxHgXwaff+7vtHqWP3uFiRH7fOXN?=
 =?us-ascii?Q?PcyAoXTfmUw1JlIdEunSJIF1fSIZNiR32uyZLEyVhxJ9OI6FQXEPENgGkRK9?=
 =?us-ascii?Q?5Sy56ENy7cTD2gW+8RBHpf6Ve2MfffTDRwHGCVMk+muhleCYYzIzMjk0/7P5?=
 =?us-ascii?Q?Wxz94I8KIgc2AC9qk2pgADhebHQrQRzfPDqOkiGZEyQv5BKQN936fr6yEGRO?=
 =?us-ascii?Q?xCvODj7n7LasSswQifQucOoyujdriVG6G+c88mk1bASVxRsyd+IoiayKTr2k?=
 =?us-ascii?Q?ejqh9vhFWYlc7jvhh2JI8fWIL7t2hg0Wggg6wc61lPX5LpaUWkR49FbcmB6L?=
 =?us-ascii?Q?qWRfhPJ+OGh1Y4evVB9+WXhKTteg1eeDdmn1UdiVQOIxo7fvIeg4J5PcWmyH?=
 =?us-ascii?Q?SYzWqggnJfaFVqI0XB9Ev7IQjiCORTnkLbjTI/grDArmR8jR08eXkUZHd1yB?=
 =?us-ascii?Q?IurHnLEEyAqxxoPrbn9luk0iTwAdQG4l51SMClspqcqu/xR22sgu03z3dgOL?=
 =?us-ascii?Q?6llZ0+MtsJzFWkGdtQZBjEFRe7xk5UNdecqUAtii7M7fH4OUki6aGXE8BRH7?=
 =?us-ascii?Q?4Qqluj54V72wfAEHbI2ZrY90eGyDz0qMn4KiHr2Rdl8o7EJnfJ0RoIXXlJRb?=
 =?us-ascii?Q?2Mw8atv0WydnWNHbw0OTKfjob/xYbcp0ExAt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 04:58:16.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a06a45a-591a-4142-f13f-08dde5ef8054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
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

Add 10GBE high-speed Mac support, it supports 10G, 5G, 2.5G and 1G speeds.
10GBE high speed Mac is an extension of the current 1G Mac in versal,
inheriting all its current features.

MMI 10GBE ip has two internal PCS's.
1)10GBASER PCS is used for higher speeds 10G and 5G.
2)1000BASEX PCS is used for slower speeds 1G and 2.5G.

Both PCS's speed and rate configuration is done with same
usx registers. ENABLE_HS_MAC bit in NCR is the toggle switch
between the PCS's.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/net/zynq_gem.c | 95 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 703e22479d2..407b022508c 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -162,7 +162,9 @@ struct zynq_gem_regs {
 	u32 idr; /* 0x2c - Interrupt Disable reg */
 	u32 reserved3;
 	u32 phymntnc; /* 0x34 - Phy Maintaince reg */
-	u32 reserved4[18];
+	u32 reserved4[6];
+	u32 hsmaccfg; /* 0x50 - HS MAC Config reg */
+	u32 reserved5[11];
 	u32 hashl; /* 0x80 - Hash Low address reg */
 	u32 hashh; /* 0x84 - Hash High address reg */
 #define LADDR_LOW	0
@@ -185,6 +187,10 @@ struct zynq_gem_regs {
 	u32 upper_txqbase; /* 0x4C8 - Upper tx_q base addr */
 	u32 reserved11[2];
 	u32 upper_rxqbase; /* 0x4D4 - Upper rx_q base addr */
+	u32 reserved13[362];
+	u32 usxctrlreg;  /* 0xA80 - Usx Control reg */
+	u32 reserved14;
+	u32 usxstatusreg; /* 0xA88 - Usx Status reg */
 };
 
 /* BD descriptors */
@@ -209,6 +215,27 @@ struct emac_bd {
 /* Setup the first free TX descriptor */
 #define TX_FREE_DESC	2
 
+#define HS_SPEED_1000M                          1
+#define HS_SPEED_2500M                          2
+#define HS_SPEED_5000M                          3
+#define HS_SPEED_10000M                         4
+#define MACB_SERDES_RATE_5G_2G5_1G              0
+#define MACB_SERDES_RATE_10G                    1
+#define USX_BLOCK_LOCK                          BIT(0)
+#define TX_SCR_BYPASS                           BIT(8)
+#define RX_SCR_BYPASS                           BIT(9)
+#define RX_SYNC_RESET                           BIT(2)
+#define SPEED_5000                              5000
+#define TX_EN                                   BIT(1)
+#define SIGNAL_OK                               BIT(0)
+#define ENABLE_HS_MAC                           BIT(31)
+#define PCSSEL                                  BIT(11)
+#define HS_MAC_SPEED_MASK                       0x3
+#define USX_CONFIG_SERDES_RATE_MASK             0x3
+#define USX_CONFIG_SERDES_RATE_SHIFT            12
+#define USX_CONFIG_SPEED_MASK                   0x3
+#define USX_CONFIG_SPEED_SHIFT                  14
+
 /* Initialized, rxbd_current, rx_first_buf must be 0 after init */
 struct zynq_gem_priv {
 	struct emac_bd *tx_bd;
@@ -391,9 +418,11 @@ static int zynq_phy_init(struct udevice *dev)
 
 static int zynq_gem_init(struct udevice *dev)
 {
-	u32 i, nwconfig, nwcfg;
 	int ret;
+	u32 i, nwconfig, nwcfg, ctrl, ncr;
 	unsigned long clk_rate = 0;
+	unsigned long speed_val, serdes_rate, config;
+	unsigned long clear_speed_val_mask, clear_serdes_rate_mask;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 	struct zynq_gem_regs *regs = priv->iobase;
 	struct zynq_gem_regs *regs_mdio = priv->mdiobase;
@@ -499,6 +528,67 @@ static int zynq_gem_init(struct udevice *dev)
 
 	nwconfig = ZYNQ_GEM_NWCFG_INIT;
 
+	if (device_is_compatible(dev, "amd,versal2-10gbe")) {
+		if (priv->interface == PHY_INTERFACE_MODE_10GBASER) {
+			ctrl = readl(&regs->nwcfg);
+			ctrl |= PCSSEL;
+			writel(ctrl, &regs->nwcfg);
+			ncr  = readl(&regs->nwctrl);
+			ncr  |= ENABLE_HS_MAC;
+			writel(ncr, &regs->nwctrl);
+		}
+		switch (priv->phydev->speed) {
+		case SPEED_1000:
+			speed_val = HS_SPEED_1000M;
+			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
+			break;
+		case SPEED_2500:
+			speed_val = HS_SPEED_2500M;
+			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
+			break;
+		case SPEED_5000:
+			speed_val = HS_SPEED_5000M;
+			serdes_rate = MACB_SERDES_RATE_5G_2G5_1G;
+			break;
+		case SPEED_10000:
+			speed_val = HS_SPEED_10000M;
+			serdes_rate = MACB_SERDES_RATE_10G;
+			break;
+		default:
+			printf("Specified speed not supported =%d\n", priv->phydev->speed);
+			break;
+		}
+
+		config = readl(&regs->hsmaccfg);
+		config = (config & ~HS_MAC_SPEED_MASK) | speed_val;
+		writel(config, &regs->hsmaccfg);
+
+		config = readl(&regs->usxctrlreg);
+		config |= SIGNAL_OK;
+		clear_serdes_rate_mask = ~(USX_CONFIG_SERDES_RATE_MASK <<
+					   USX_CONFIG_SERDES_RATE_SHIFT);
+		config = (config & clear_serdes_rate_mask) |
+			  serdes_rate << USX_CONFIG_SERDES_RATE_SHIFT;
+
+		clear_speed_val_mask = ~(USX_CONFIG_SPEED_MASK <<
+					 USX_CONFIG_SPEED_SHIFT);
+		config = (config & clear_speed_val_mask) |
+			  speed_val << USX_CONFIG_SPEED_SHIFT;
+		config &= ~(TX_SCR_BYPASS | RX_SCR_BYPASS);
+		config |= RX_SYNC_RESET;
+		writel(config, &regs->usxctrlreg);
+
+		mdelay(250);
+		config &= ~(RX_SYNC_RESET);
+		config |= (TX_EN);
+		writel(config, &regs->usxctrlreg);
+
+		ret = wait_for_bit_le32(&regs->usxstatusreg, USX_BLOCK_LOCK,
+					true, 20000, true);
+		if (ret)
+			printf("usx block lock failed\n");
+	}
+
 	/*
 	 * Set SGMII enable PCS selection only if internal PCS/PMA
 	 * core is used and interface is SGMII.
@@ -997,6 +1087,7 @@ static int zynq_gem_of_to_plat(struct udevice *dev)
 }
 
 static const struct udevice_id zynq_gem_ids[] = {
+	{ .compatible = "amd,versal2-10gbe" },
 	{ .compatible = "xlnx,versal-gem", .data = RXCLK_EN },
 	{ .compatible = "cdns,versal-gem", .data = RXCLK_EN },
 	{ .compatible = "xlnx,zynqmp-gem" },
-- 
2.34.1

