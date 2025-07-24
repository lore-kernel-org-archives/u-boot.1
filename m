Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338ABC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 04:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EFE8835CD;
	Thu, 24 Jul 2025 06:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qaHt7BVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825FF835FE; Thu, 24 Jul 2025 06:44:21 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF3F803DF
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 06:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atA9f2XUlT7TXyZSg35e/XjIxpJ5Sy4dS+sgCTESizm8Ifwjb1a4mhdHpzBkxLGLQJ/N+D2PrR/Y4FuBd/qV22RS0ehB7HHsf6nIgAvFooNwvTvxNKKBfxZlOyHmg42V3IPDcaAYa+Q7FWBCRLc/QB/jIsJVYZlCQAbcRW0LAYh8cDfZ2Sn28N8LlDSozublhal+NBMSNGyOu57fuiqoEgnJLd+HH7inYn7cDS7U8yxavWvaV5YAH6Gd3yIWIckDZ8mP/T0QPJ5Pkeh80dpJj5V6ZrrUeIVNlrQ+GhtNGiktfEQMOSeuo1O4nhvS2APDjY5aVpEr/+eLnDNO6dvxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgBhP/2M7nZakJJBx0Pl7kT3hHYbQqnJ5ASOdB+XDdw=;
 b=AxkAPudkDMxGV48OntXkINoWkicrfuYQZKjqgCy3p9JiASgg0wF7nIU+wTYlK6RkKsHAnLNQDs1wCLvUyyfTwc06CMiLHYWnTQ/iLMvtZ0t7smbzUGJQWvZjBKKV0o6Q4Yq8T136k7thPka2LThPjYxMw/0Ej6Dfd3hgIb8xB8WUWo9plUaX6AH6Kd6h6cIWm5zppepmDOgrLGWuVnDXi9OScF6R1e8O8ggugmUdrhOJGeQ42NVIPhB82zv/rssTAhXCUESRnduzCVJjCcTQrsBGb1LO7CzpEkJz9dctGCAXeTcrOaoiYUnKnkP37w5jHtfKYPajXTIEuq5w0+hPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgBhP/2M7nZakJJBx0Pl7kT3hHYbQqnJ5ASOdB+XDdw=;
 b=qaHt7BVYafq+kVuoaA538Sl5QBOnDiifujUjjpxkVwbgstJxjOX/2UKctCqJOdcEAvLmiSsnjmjtmZwJewLjCEBEH2kTpAn1PWp+H58eE1BBncTB4pb3fJYrkWHrtFcBzCvckuG4YwFCizJY31gMrkD0RJPwfMz7jUmdzPj+/JM=
Received: from MN2PR11CA0023.namprd11.prod.outlook.com (2603:10b6:208:23b::28)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 04:44:13 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::b7) by MN2PR11CA0023.outlook.office365.com
 (2603:10b6:208:23b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 04:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 04:44:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 23:44:11 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Jul 2025 23:44:09 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH] ufs: amd-versal2: Configure RMMI and M-PHY registers for HS
 mode
Date: Thu, 24 Jul 2025 10:14:02 +0530
Message-ID: <20250724044402.260149-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f1c956-9bf9-4bd3-135c-08ddca6cbcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtNcPHBjDhUbL+HvY8OdyrfhtIh7t/pQsgMUStEXpl6ZbSefAU1J/uqV7WtD?=
 =?us-ascii?Q?1Tdn7KjA818TP/DG14+uLvd+4HcvveRtd8pl/GK+VInJZrEdRO5bOfw5b3J1?=
 =?us-ascii?Q?eKv23xsoVzY0BH5meYCIMMLpuDrAUO7xHrCq9pftDOrTZPIkP4NxTDwie/Tw?=
 =?us-ascii?Q?t7s0de+CZMeirV72tCNSMad1Z/r9EiiMQJwyDeaL8AidE1Wel2zUyBcmsIKz?=
 =?us-ascii?Q?iu58ApkKcgXAcMwugeU6Yi/0ck8QnYO0L2epSOBysyrDTv9hTcg0B23hmVsY?=
 =?us-ascii?Q?vhgFa1trxjFeL6DfB1G8kNPZ92FiCwFHlD48+yk3kVi5Ck5oBRWZxinqA3Is?=
 =?us-ascii?Q?Spivyh7Y0XEukhRw9q9ICKL/0ZKYRTciMxNn354YTV42/c5m6Fcfrf3o+Ixo?=
 =?us-ascii?Q?rj0cREQxTxqi7BUFMg30TBsHN0TLNSvy77eoJ9UX2vpWiI1y3xvruF/DjTXm?=
 =?us-ascii?Q?IHAu+ON9ZD8uhrbPWUqkYUPRUbjGs1+/BgLNV+AaXJI6o+lVAXx45gilX0gY?=
 =?us-ascii?Q?Oz7S0m5JqoR0SiPvZa+LsJievl+sfrWEtlTKo6H2u4Hp2RvdgoNDLJsHi81d?=
 =?us-ascii?Q?Oz6XKxqFbIXXKvmLn4eL5Fn396j3BAfD6BZ9nAIadiIKyvn7NO+84EyAFeKJ?=
 =?us-ascii?Q?9O7U/F5tlGJD3+kNnmH2cd4c/ZEB8ZGanZtHapcEBOHLn0HKVcO7oT7JcghN?=
 =?us-ascii?Q?8XTvRy63VYaEfCcTQE6VVI8L2D21Oc5LoS4upd8TAUdc7m796HEj3EZzTsFo?=
 =?us-ascii?Q?FV9xUe1a/+393pbVulCvgu8/v4MtH1cEFLsaOQFsPNP0t6ogpHanSrzCxyq+?=
 =?us-ascii?Q?2oiI5J92luajdGj0tyM4SvarBotud9W5mZ6W4OGKt7+31GXceKo0QIEdD+0c?=
 =?us-ascii?Q?zDaMA1N37A+0Ka3OvwRLuXfo7+rR9PDe0v/KXVTzh4nyA/lVIkOZKq7GiY2E?=
 =?us-ascii?Q?oU1tv+65ktF8h3uInsi2ZIp16SpQPeXindubMh5sw5OeIXGZ38E4tyZqX25T?=
 =?us-ascii?Q?rpg+v2sW1Tv0QFuNlChpVUV5KPi47E/71+I5Wn9mR+tbKt1vGawzDi3mewQd?=
 =?us-ascii?Q?uy/NWWjc2pKFELs0bpU6oK94/urf5eJnAqMx9O3UDeldAgFoLzH29hGf8//+?=
 =?us-ascii?Q?tYVLjBMzhmM4wV4urlyKUJ8Aj4FZ43DYDmX/fcJPKELeeNa+Q1i+T2dHAixC?=
 =?us-ascii?Q?bvG/EeB4qr75KHBEQsTIeSxIgAz122QHD1/HftVDMTpfKu+IHzAKS1J+jig8?=
 =?us-ascii?Q?7n03gytPJt9tmv4/Wc+a0gGjLnjlMUNuMjXFQYaVcdwoG1T8qysiTjfWUKo6?=
 =?us-ascii?Q?hav/Ru2MHXbO8cHRW1tfPTd43JQJHE7M2lRziPc5JxibDohFrlZlOlx+adon?=
 =?us-ascii?Q?wuA6yItzD9oO2wEYKjj79c2YZCA/WEpCas3kWZ1sUQLZ7yM8/E7w5DTBdeug?=
 =?us-ascii?Q?qwyFkGwnflr2TCp9ky35ijrbf1Je5jZRl3HG2ror5MY7PRxki3qqbjmx3eny?=
 =?us-ascii?Q?ZAEQWqgxnyMPkdgBbQqOkOUtIU61SiD7ZWFt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 04:44:13.1206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1c956-9bf9-4bd3-135c-08ddca6cbcf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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

Configure RMMI and M-PHY registers for HS mode required for selection of
bit rate series A or B. If it is not a calibrated part, then switch back
to SLOWAUTO_MODE and skip all these configurations.
Implemented below sequence as per the DWC RMMI databook.
1. Override RMMI CBRATESEL with the desired rate.
2. Set TX_CFGUPDT_0 to 1'b1 for one TX_CFGCLK_0 cycle.
3. Override PHY rx_req to 1, then poll on PHY rx_ack register till it
goes 1(both lanes).
4. Override PHY rx_req to 0, then poll on PHY rx_ack register till it
goes 0(both lanes).
5. Remove PHY rx_req override(both lanes).
6. Start the LS PMC.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs-amd-versal2.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.c             |  15 +++++
 drivers/ufs/ufs.h             |   3 +
 drivers/ufs/ufshcd-dwc.h      |   3 +
 4 files changed, 133 insertions(+)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 1c5ed538370..896dda2de4e 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -26,6 +26,10 @@
 #define MPHY_FAST_RX_AFE_CAL		BIT(2)
 #define MPHY_FW_CALIB_CFG_VAL		BIT(8)
 
+#define MPHY_RX_OVRD_EN			BIT(3)
+#define MPHY_RX_OVRD_VAL		BIT(2)
+#define MPHY_RX_ACK_MASK		BIT(0)
+
 #define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
 
 #define TIMEOUT_MICROSEC		1000000L
@@ -422,10 +426,118 @@ static int ufs_versal2_link_startup_notify(struct ufs_hba *hba,
 	return ret;
 }
 
+static int ufs_versal2_phy_ratesel(struct ufs_hba *hba, u32 activelanes, u32 rx_req)
+{
+	u32 time_left, reg, lane;
+	int ret;
+
+	for (lane = 0; lane < activelanes; lane++) {
+		time_left = TIMEOUT_MICROSEC;
+		ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
+		if (ret)
+			return ret;
+
+		reg |= MPHY_RX_OVRD_EN;
+		if (rx_req)
+			reg |= MPHY_RX_OVRD_VAL;
+		else
+			reg &= ~MPHY_RX_OVRD_VAL;
+
+		ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
+		if (ret)
+			return ret;
+
+		do {
+			ret = ufs_versal2_phy_reg_read(hba, RX_PCS_OUT(lane), &reg);
+			if (ret)
+				return ret;
+
+			reg &= MPHY_RX_ACK_MASK;
+			if (reg == rx_req)
+				break;
+
+			time_left--;
+			mdelay(5);
+		} while (time_left);
+
+		if (!time_left) {
+			dev_err(hba->dev, "Invalid Rx Ack value.\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int ufs_get_max_pwr_mode(struct ufs_hba *hba,
+				struct ufs_pwr_mode_info *max_pwr_info)
+{
+	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
+	u32 lane, reg, rate = 0;
+	int ret = 0;
+
+	/* If it is not a calibrated part, switch PWRMODE to SLOW_MODE */
+	if (!priv->attcompval0 && !priv->attcompval1 &&
+	    !priv->ctlecompval0 && !priv->ctlecompval1) {
+		max_pwr_info->info.pwr_rx = SLOWAUTO_MODE;
+		max_pwr_info->info.pwr_tx = SLOWAUTO_MODE;
+		max_pwr_info->info.gear_rx = UFS_PWM_G1;
+		max_pwr_info->info.gear_tx = UFS_PWM_G1;
+		max_pwr_info->info.lane_tx = 1;
+		max_pwr_info->info.lane_rx = 1;
+		max_pwr_info->info.hs_rate = 0;
+			return 0;
+	}
+
+	if (max_pwr_info->info.pwr_rx == SLOWAUTO_MODE ||
+	    max_pwr_info->info.pwr_tx == SLOWAUTO_MODE)
+		return 0;
+
+	if (max_pwr_info->info.hs_rate == PA_HS_MODE_B)
+		rate = 1;
+
+	/* Select the rate */
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(CBRATESEL), rate);
+	if (ret)
+		return ret;
+
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYCFGUPDT), 1);
+	if (ret)
+		return ret;
+
+	ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 1);
+	if (ret)
+		return ret;
+
+	ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 0);
+	if (ret)
+		return ret;
+
+	/* Remove rx_req override */
+	for (lane = 0; lane < max_pwr_info->info.lane_tx; lane++) {
+		ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
+		if (ret)
+			return ret;
+
+		reg &= ~MPHY_RX_OVRD_EN;
+		ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
+		if (ret)
+			return ret;
+	}
+
+	if (max_pwr_info->info.lane_tx == UFS_LANE_2 &&
+	    max_pwr_info->info.lane_rx == UFS_LANE_2)
+		ret = ufshcd_dme_configure_adapt(hba, max_pwr_info->info.gear_tx,
+						 PA_INITIAL_ADAPT);
+
+	return 0;
+}
+
 static struct ufs_hba_ops ufs_versal2_hba_ops = {
 	.init = ufs_versal2_init,
 	.link_startup_notify = ufs_versal2_link_startup_notify,
 	.hce_enable_notify = ufs_versal2_hce_enable_notify,
+	.get_max_pwr_mode = ufs_get_max_pwr_mode,
 };
 
 static int ufs_versal2_probe(struct udevice *dev)
diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 91f6ad3bfef..57e6e8c013b 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -226,6 +226,21 @@ static int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	return 0;
 }
 
+int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
+			       int agreed_gear,
+			       int adapt_val)
+{
+	int ret;
+
+	if (agreed_gear < UFS_HS_G4)
+		adapt_val = PA_NO_ADAPT;
+
+	ret = ufshcd_dme_set(hba,
+			     UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+			     adapt_val);
+	return ret;
+}
+
 /**
  * ufshcd_dme_set_attr - UIC command for DME_SET, DME_PEER_SET
  *
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 53137fae3a8..0337ac5996b 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -428,6 +428,9 @@ enum uic_link_state {
 #define ATTR_SET_NOR	0	/* NORMAL */
 #define ATTR_SET_ST	1	/* STATIC */
 
+int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
+			       int agreed_gear,
+			       int adapt_val);
 int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			u8 attr_set, u32 mib_val, u8 peer);
 int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
index fc1bcca8ccb..f7d27736f44 100644
--- a/drivers/ufs/ufshcd-dwc.h
+++ b/drivers/ufs/ufshcd-dwc.h
@@ -17,6 +17,7 @@
 #define CBREFCLKCTRL2		0x8132
 #define CBCRCTRL		0x811F
 #define CBC10DIRECTCONF2	0x810E
+#define CBRATESEL		0x8114
 #define CBCREGADDRLSB		0x8116
 #define CBCREGADDRMSB		0x8117
 #define CBCREGWRLSB		0x8118
@@ -32,6 +33,8 @@
 #define MRX_FSM_STATE		0xC1
 
 /* M-PHY registers */
+#define RX_OVRD_IN_1(n)		(0x3006 + ((n) * 0x100))
+#define RX_PCS_OUT(n)		(0x300F + ((n) * 0x100))
 #define FAST_FLAGS(n)		(0x401C + ((n) * 0x100))
 #define RX_AFE_ATT_IDAC(n)	(0x4000 + ((n) * 0x100))
 #define RX_AFE_CTLE_IDAC(n)	(0x4001 + ((n) * 0x100))
-- 
2.25.1

