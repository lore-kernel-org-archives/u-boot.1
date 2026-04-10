Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46269E99062
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 09:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968D184120;
	Fri, 10 Apr 2026 11:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmTmreUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898308414B; Fri, 10 Apr 2026 11:30:53 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD7283DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXULUzEIBUcn4Gtk2bSa+6q7GjbtKHzvq79auwuwBA9dAXZv3OvKSrMra7kBITPOth37ajO4GUdrNQnOpwchM+ZRTv8OWQSWj1ywyzJgnkPaQEOKoX1i1cXCpkYJRfYMsLnrEat1YW5MMFczTCjba7EpRijY1CmZ6nOd+Ji5PwlCMg75LiIz+eiS8axPcR/stsOGlk2GidH8vOitpi2O2DZKb77hG4xXvNTOEc98CT4ro/DsEJhG9jrTbsK+iO6xyp6hO7T010GmT8nvVV9gPcxgYogQQUlFcAXTtEKHkP/kXrZYD2gir2T2L0/2oMnZhjTpVTlrY28OIljAd1NSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwwE+sT68Sa4bEdcArKXvNpp1QHpHY8WVtWGwLHnaKs=;
 b=NTsm9fHc2Y1mexF1+OUhANJBQ9Jj4XvvXlTDdPPAvuLHPr/ZJewCictpeFY2MpKq7X2McUIfyOfqHN+sEgD99iEL4o2DOgEHbFqdWAamsZEKNUyjaFVYlH7MInoWu+DIpCfw4PQDCyWP9GB8bu3E8vePxRenZ/NC8SuGfkYAr79908wO8mwNI7Ccxan7HsCytLqZPqolO0ubzpQ3i7oQC9U/SHk7TDsXKXVHFuCrqx0/vCrVASOJOX57Y0OhkfOzoyqFPzivBFoT/ykjNx7wczgetzFJ6S6yIffqFQXzA5LEnmtw9I4CIoowof1WUa7hl/UUUe+8wZsuD8XBUbWgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwwE+sT68Sa4bEdcArKXvNpp1QHpHY8WVtWGwLHnaKs=;
 b=tmTmreUBznGw5eP9tNEHAHOhkXhUq3AfcBrGmPIo8dsMvNvxdfSe1wkO6t4Wfb/7W8u8SendsTyeL97rIZkQG/OMwxdETem/dkBaOQS3gGT2FivFRtK5+ww8JAFErvU1CRBsD24/L7j8+pGxjM4urbn/SqofCFY5gJ5I9R7SBHo=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 09:30:45 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c7) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 09:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 09:30:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Apr
 2026 04:30:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Apr
 2026 04:30:31 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 10 Apr 2026 04:30:30 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH 2/3] net: zynq_gem: set 128-bit AXI bus width for 10GBE
Date: Fri, 10 Apr 2026 15:00:17 +0530
Message-ID: <20260410093018.1461732-3-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
References: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a41a6ef-4b23-4c6a-4671-08de96e3d7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BzaYkjir8Z2OT276D2IeqCPR8eSyR7uidSXEqe2DrBzIYsAdbo89Fz1QjV5HEch0YFH5ZobS84Xnpn0rujWetgLP4qfRV2x8F0QPv+Uyvk557XlWF2qqmurr/dqo07TsJIRNenM4G47gEJS1CNzsEYDtXEFa9/a8lliUa25sfzkndHHkFXNlua45nRGxOELy374ROBu7B0E+oV5e0R2cw8EEB/h512bjLtj9nlUVIa/Ijwzv+AleYr4gcjf+apWz8kCAmwTPPvAmjINTcGcbfL/B6D54UhcTw+TF5VI05cx9a+QLbqepb1z+rcgEknIgqZbQMWk8kT4wlDqnSGggKpJSI58bGVv/BjfUgvHGgZAowqtPkKm3D5bmBlwjUsqqKiQf/zS4buwE70VGBbHTEK9+4gv0X4phyJuoTMqfwGn3He8/x8qJ3RCHW5i3af1YmAJQxVXweVP8RE1a5ZNdYZF9VNEFc4+OHU8aKmSpdRAFsZmuyMx7YcSO8MUMi1b1VO8ZQNbk+HdAMqw/nd2qXyn+X0WkXXosTFUMYybnDGT6uyeJXcd0cnJaC1mbEGPGSHfClXOw/b8oAGBp0lewW8dzXmhbTBOeZBKnvHfaNaNlfSedAafDR5038gUleN4xtfKgaCeXwzJiAsIxdrjCBdL4S0f3KyNFiSHPahuWzsYw/fnSa/oksJSZgf4xDr1PexYiPFI6w/r7EMIvvenV5TUq0AuM8ZGnB08EHLURn4tK4TB4T/2JTVzeDn6C8hZMqV/GlFuYrexCYbx5bhawOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: huubchgdu5lqMHuF/5U3nbTf/Lj4WHODWefkLZHjSoi/JZQAvsZ/HoDGjv3zG9+dBRS2TJ1TJDCZKazMW9HGVpwCtxsLFNsD9kFJ5wuq6IQMVHLDUHpOeit4yBWZT9X050etJev+HjWNzUvanJPGMNk1L+6IeMbWgcrmpmoP8tTpzOZdCidDc4YFaIi0kJh21R3oF4WFcJxjiTuuPkT2W9PZF5NnDUD7hHP1etCSHRuyUCw4rFql7cW7pHIVeipV9oUWjDyWLiIZ0+D7YW84TtdRV8oFKZ58sVeUWCiFXOGMYCDm+h44hZjXX4odhTkXSGSHU4qXhycsB570L82PyCJ83ox6vmPoK1jGNw8L6qMiamvOK+HJWHl2m+UuO06duvjBPs/xougByOOLZMaZvtQpufCdBi8PmXx7bs+rYqq6JAAjpTJ3L5zTfBoCAxjn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:30:45.8200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41a6ef-4b23-4c6a-4671-08de96e3d7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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

Set 128-bit AXI bus width in network config for 10GBE. The default 64-bit
setting causes DMA data corruption.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/zynq_gem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index c06d114af68..e9210d42438 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -69,10 +69,13 @@
 #define ZYNQ_GEM_NWCFG_SGMII_ENBL	0x08000000 /* SGMII Enable */
 #define ZYNQ_GEM_NWCFG_PCS_SEL		0x00000800 /* PCS select */
 
+#define ZYNQ_GEM_DBUS_WIDTH_MASK	(3 << 21) /* bits 22:21 */
 #ifdef CONFIG_ARM64
 # define ZYNQ_GEM_DBUS_WIDTH	(1 << 21) /* 64 bit bus */
+# define ZYNQ_GEM_DBUS_WIDTH_128	(2 << 21) /* 128 bit bus */
 #else
 # define ZYNQ_GEM_DBUS_WIDTH	(0 << 21) /* 32 bit bus */
+# define ZYNQ_GEM_DBUS_WIDTH_128	(0 << 21) /* 32 bit bus */
 #endif
 
 #define ZYNQ_GEM_NWCFG_INIT		(ZYNQ_GEM_DBUS_WIDTH | \
@@ -533,6 +536,8 @@ static int zynq_gem_init(struct udevice *dev)
 	nwconfig = ZYNQ_GEM_NWCFG_INIT;
 
 	if (device_is_compatible(dev, "amd,versal2-10gbe")) {
+		nwconfig &= ~ZYNQ_GEM_DBUS_WIDTH_MASK;
+		nwconfig |= ZYNQ_GEM_DBUS_WIDTH_128;
 		if (priv->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl = readl(&regs->nwcfg);
 			ctrl |= PCSSEL;
-- 
2.43.0

