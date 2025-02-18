Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC069C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E10B807C0;
	Tue, 18 Feb 2025 13:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AwYNaA+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9644C807F1; Tue, 18 Feb 2025 13:43:21 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592098043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvLQkQ4eOQ/yNtkt54Khu/P20TjmWXXp8Hc0hEmxIjbrW8T5lz+bpoNN3pA5iE/AzwVZMS7jqIffSvnDukUHwT+VzfHo08jZ+87zABtbGJIEC3P0IXmBLokoC9HaZvsRr1EL22bm2VArtzxRfwIlMNLRmiXdt+0X+h6Z80XE5Zr7qy51D9AQr0R837pS5B6wAnMDuHnViI1O3OvBwa447t205SypZRBmITkkYU/iRJ1OZSQC8YUQ/TaIWIlnTc7FFi0U5wKMqtQdSZWUXQdX+sy+QS4erJhhO0ZvKIqcSYk/FV+IQ6kC/HA3OLWp0eoTOkt4XBMhJwndOjLDh9ipNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p0vO9T4dDp3MTnz59MOkvVpBP0fkfs6Ott73M42BUQ=;
 b=Q6/ClFEb8xy+vvkUy1RFCBfXU6+J1fFDE8G0gsMtuZF8XffAETZov6P+SDirgfkcVvgCEHsgZ84mdBEtdypC1sitcxCgvlnLaJTuPRLuyXuN55wnvIEGPGn01d5zAkPr8vCL99bop6d1jEMzf6IEYabmYgaQE4+Ap8OYyw+Gq6e4VLjkXF0yXG6JHn4BEjxtuF+HQPH1Eg+9TIvJq3/v4fZoLQ9WLm/8MlbkP5Mhh5cvQsjEby7B/Uhf4oDb29Syrsm945rTE2R3YiHggpCZiLpT6tUzz/HfvHg9jajLENyLTjKGIuzfTC7rZaK7WFNMwZqNC1VvRM+7YrDVG7BVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p0vO9T4dDp3MTnz59MOkvVpBP0fkfs6Ott73M42BUQ=;
 b=AwYNaA+0YsLm6Gs5d6jC6o0vKnlnN5OiuYkQQunehKZa9c4Fi1mxKP10z85HMobT5M2jZnpiB2XYigwW6wkeWhw/fBfMGv/M1DQyakbeuGtEtVTKoidgWtE9tJicxwohpp9oj9ZwqFZ8ybKhdUNMi1fCzbXZ/hY2wRb8t2EgLLU=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 12:43:15 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::91) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 12:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 12:43:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 06:43:11 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal2: Show major and minor silicon version
Date: Tue, 18 Feb 2025 13:43:07 +0100
Message-ID: <20095339334fe07f373ffae3bdbfec51f5a00dc7.1739882585.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=C9qExiIMnY5MiQOMHGdWcLymXTAjcQcIZbX+/UMoT9M=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQtDTE8r2cZ9dy0Djs0ITrlr7mZ4Wx/Oylt54yQlx3yb
 yof5Ep2xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIksS2RYMMtlx9mtJV9iZWxY
 FmhNnqeWZfPmFcOC2annA/hWPbq9ZMMVDe4zx3/KZGbvAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e512264-e4fc-45dc-eb9b-08dd5019cffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jbVO/HzLtnCbfSl4ygKPIa2MtuXwscrcTNqh0mqI75Fwnd/6++9iT3Nc8mWY?=
 =?us-ascii?Q?vTlALBbz9by1rD7VlEMg7w7kDZ9WHboyRckGLF5+LaRI7oyqD/gtf1qOpHU3?=
 =?us-ascii?Q?WTKTuUhUQu1KuWKqQOoAoFDrik6LoaqJHqloBMIKBrSnztaq/U2FaxYcyaFb?=
 =?us-ascii?Q?7kK+7NSFXs0gKSw7flUVo91+B4qE06xK+gDScjpgIz+gCpZj9dYCLuwTGMP3?=
 =?us-ascii?Q?OwK2d5pGJ2DfCMyGeP7s/lh+Ee5z+knQzj0j5WOHWN03OkMv4yFn529b6EdB?=
 =?us-ascii?Q?dIA982jd60eESQMevibOWxj3rJHIvuOH+ZNSZuxg0U4/s/3wsRRbjClpHFuz?=
 =?us-ascii?Q?bXYhEAFF64E3CYtAJ2XU6jyQ4aflrMgLM0oMIhtuYvo8qYyxhcV6e+28XSx6?=
 =?us-ascii?Q?ArxI1g+AB7nxU7gNb4RLw8Za6dvVD0OICor6o4WUjuKl4fE5fhkQOifOgHEy?=
 =?us-ascii?Q?QuYQyanprWuVFAngjdu2B3YTfIO+r/hIRP0B4v87CjZSli7mH2rd+GJzIzD7?=
 =?us-ascii?Q?kN1hrWa01NL9KtxOSkzzO4rX3b7yEvz7sIOLkZ3tovoBTCrZ9yKqSZJFBTTa?=
 =?us-ascii?Q?Vug0qGU4HQQuQnDS4f9GC8Jc1aZEABJd5JEcMNGvwsoCybvNeQsekJoaNMlL?=
 =?us-ascii?Q?tcV7OiDdyjLbmRdIpOw0LfYKrU6zfyN+yR7gJzbUtpilAUspr5n/e7HgQC8r?=
 =?us-ascii?Q?1Qgh4Kc0aliLXz1gYC72xYHgyC3+D4us9WVcC66m3qZIizFSumsV26/jgFGX?=
 =?us-ascii?Q?VA9a0Z4blfdeKM096TbVkokmaSbcIcLMtAPgXgOW37kVBMuGYtZXZptzJ/GD?=
 =?us-ascii?Q?4Vss2tauLzfbVcq6bJIGnp/m8wzb4cGOeOXlAskElHDyZiA3wDzLwWv3TWEH?=
 =?us-ascii?Q?tXgrcR30gogdkphyJ5KNVXL8L9SRN7Je8SP8xyoAfJuC/P2yt+/oJ4xxZ8rI?=
 =?us-ascii?Q?01uj0fYZZ83AAy6e3DcFmW83F+MfeH/YMhSMBB6PipXmiu6fG9n8Sq6d/6iv?=
 =?us-ascii?Q?P9Ru8zBeY/J1csLWFIxuWvEPq05skLFwSN37GdY9EBYa6yUiv8aBwt59CqGO?=
 =?us-ascii?Q?yv9nghqDquX1DjYHaTsytITSaRV1QTDOg9WGFzlc68jPW+p9Y90WkVazyIDq?=
 =?us-ascii?Q?rlYMNYeVm4roG6dZxKHDBIrW1/SsNATrU7bo8IhNCgNrY18A4I6Q2t1Gyafx?=
 =?us-ascii?Q?JBqxthURiHCe8F1/0Ln7pzvVRTCwLklDmS1K1vJy1E1ktJGhxQvYk73hTGvc?=
 =?us-ascii?Q?tocZdNmWbuqBH4vvxgbklapuanD6qh9n09ZCr3rzKjfarUr4F0060W/0yFzi?=
 =?us-ascii?Q?rw8rwkeqnSDYVAM+L4QTeblvQgolvLNi+scvKJkwdSyFwfDOrLPYa7uB3GWe?=
 =?us-ascii?Q?RidWIIyRvTzLIa5zVhtVNmHjBDVJlE0MoWtZZJtC4L3ieyBexFqKgFxOBR89?=
 =?us-ascii?Q?IT+415HtrKD/l7ipBwWnxGwQMsh6VWCXMGcOCXJEqwUDyi+9eJarBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:43:14.8910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e512264-e4fc-45dc-eb9b-08dd5019cffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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

ES1 silicon is 0x10 (16) and production is 0x20 (32) but correct number to
see are v1.0 or v2.0 instead of v16 or v32.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/include/mach/hardware.h | 3 ++-
 drivers/soc/soc_amd_versal2.c                 | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 42e3061a0aea..15085f941e02 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -51,7 +51,8 @@ struct crp_regs {
 #define PMC_TAP_VERSION		(PMC_TAP + 0x4)
 # define PMC_VERSION_MASK	GENMASK(7, 0)
 # define PS_VERSION_MASK	GENMASK(15, 8)
-# define PS_VERSION_PRODUCTION	0x20
+# define PS_VERSION_MAJOR	GENMASK(7, 4)
+# define PS_VERSION_MINOR	GENMASK(3, 0)
 # define RTL_VERSION_MASK	GENMASK(23, 16)
 # define PLATFORM_MASK		GENMASK(27, 24)
 # define PLATFORM_VERSION_MASK	GENMASK(31, 28)
diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
index 66bcb22b4fa9..8507da0bd228 100644
--- a/drivers/soc/soc_amd_versal2.c
+++ b/drivers/soc/soc_amd_versal2.c
@@ -35,7 +35,9 @@ static int soc_amd_versal2_get_revision(struct udevice *dev, char *buf, int size
 {
 	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
 
-	return snprintf(buf, size, "v%d", priv->revision);
+	return snprintf(buf, size, "v%d.%d",
+			(u32)FIELD_GET(PS_VERSION_MAJOR, priv->revision),
+			(u32)FIELD_GET(PS_VERSION_MINOR, priv->revision));
 }
 
 static const struct soc_ops soc_amd_versal2_ops = {
-- 
2.43.0

