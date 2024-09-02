Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4BCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414F788ABF;
	Mon,  2 Sep 2024 12:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H/zg7E93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D1D88A47; Mon,  2 Sep 2024 12:27:40 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A82788A9D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqcszIlpYmOEl2B3lKmfgOjmFPSN3xHN9fCUtZr1rznSkujNfkYe/6ToJNJtaPLoNiCRli1UMXjrD5j3LOyt24dtdonsJn3Mg3UDZXH5H+Os3OPAsRBrIytZL+8qS22Rfwl0Pc5h6bOis4bgYujBf6pVi7JXasNCht65ZN8EvWd5T+Pnx2rEpcQEPs65kIDlquOHM3pizeW/6/onWZTfwCG0WwLayaeJKAE0UccQ4qMWoaoXRRP7AUa4JkVR57Qly4rLlGNuP234YVAsVQPcg6+jDQH+6Mnk4BRCdcNlJn90erNGolfZSJbSAzNTEdAI4902l2I+SwNGSTCzpbUkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsGJIaYS4ThAntr9uL9PiGlljCsDoFRcCbN4uoPyuZs=;
 b=JtSNeE5kFDsdH35Hxnw8d//Dd8QjZ0vijB10d0b1HcNbCtJzwORBLcPkUlGSym/1kJzd+uFqlhEtUqyONushR76dOQTFYkrgBL20fzNckiT9LatjbiQNhwZKxzRZ6Idjn034wbWH0rV5BXZK1hl3rY/jDFt1l5NizzGrO8lvqFG9zCT0I8D7JZ5xqPc8nL03DpUbWhMBACdnCRT8B0LB0zBXxEvbpnIMo/0alzYWwPCkHRLN36oXisePuv1E3BfUFn3iMn0JDXBcQSeojE08M7r/nRBbbFvfjATJlg/zGMLxuq7yPBHNlaSCUKF1aslkws1LR8uqTQaZc7CLw1LjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsGJIaYS4ThAntr9uL9PiGlljCsDoFRcCbN4uoPyuZs=;
 b=H/zg7E93ewUun1JqbgYoGO00x/52yRbn5up6nnooaZ3uHpU2hwxdgFzEuPhseWWiGCfn+wDKybMxsoT3ieju3x4YlgJkyRh5DYHqsvhmQJDawQRiovgFOYYrknpU0gB1rX9u+q0wmRh/NTD9qZ6ffcvx4kRU5DIoi6sdlPWMg2w=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:27:34 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::da) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:32 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:30 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH v12 7/9] spi: Add the spi advance options for non SPL
Date: Mon, 2 Sep 2024 15:57:04 +0530
Message-ID: <20240902102706.1107-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f797ba-25dc-48ac-31f9-08dccb39db7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?53VWQwzKrClQVEQsWyrh5L/LLpMTWdGwY7NFw1ZpB/SSh9PVlJZFbWAulv5m?=
 =?us-ascii?Q?Tn662Gg4lvXRFCvxeVMPxkdnlKhstSk/JgX9CWloVplyvNts9RynMH8PP9HD?=
 =?us-ascii?Q?CEqbdDMQGXdhfE+Hhl0GX5iXh1rt3erEXcAHz8kVupPINFcOhql0BWi70Ghg?=
 =?us-ascii?Q?Gg9m9F3bWJEIGnjAztP+85kJZuajJxxXLMh5DXo43m0LCZQdAoiYGF1CXkA2?=
 =?us-ascii?Q?66b1Cxx75238HntkWzJ1xCqgsS4V9f+m/r6P0axy+U4aHrSMpxYrn4RvtXjK?=
 =?us-ascii?Q?kOEqgkFXG2+vx7VnSSoaeNtQGmP0vKpbXyWx9VSrjXrtC1fjg8OeEngQAY9v?=
 =?us-ascii?Q?R44/xvTp0o1w6cCf5Gcj2uPiAoSpLPX+XS7VEjiKYoMkfubA8dJUHwC/MCYt?=
 =?us-ascii?Q?6WI/u3+kwwroC+3sM1gpgzbb5yUzmAfYkNqGnm7NI50Jef7Y28dvTCWyRBe5?=
 =?us-ascii?Q?+nRc6SdkdCV+P6HgicCjZw//gUVNowQOQJ0MTaik57BEa1MUTuRnB9/rxK+c?=
 =?us-ascii?Q?t91Ux7/TI3cMfIL3SnOXO34y1W50aPLr9RBa+QwVFhRGZJAhzpVUy2vpQXqX?=
 =?us-ascii?Q?FliNXFvRzOgFRkgnA7O+BuT7JYfT3IvDesLpB1R0tpKiKzxT0qF1Wb+/FWqS?=
 =?us-ascii?Q?qYwNykwyfghlaVzth3X8hlJEgPxgFBy1rBig7ZB4ScgHc51m27AsyYqHtxys?=
 =?us-ascii?Q?6nd8D7o3iY5EIxgSyG1bStAlBhMFBp/LgBo+/U7sVeT16OdudmnxRB1Tp9E3?=
 =?us-ascii?Q?Q0gw9K2JBIj+IEGIcs+tKubBLTGSEtHEeLAKRgs+9klf0X97a1XA3Eh8AK4V?=
 =?us-ascii?Q?9tFHE+t4vUnqGk0e0zRHbu+jUakPizRl0hEvN0R0lDwLOs9o7aQnaiGz1HXe?=
 =?us-ascii?Q?GexVmAzYNgGlww17aoQCym09yY/J9OuexfvrdTqDO9CK7Zzq6gYQNz8kxhbD?=
 =?us-ascii?Q?lohRhVoYhTWA1dPOyAoojVGIk9at8jiwK8jwu43Mq685HwYRIdiR+lAxF11d?=
 =?us-ascii?Q?QD+BXAOZnKnCeikYFYeDkzSiWF1QHD8M5j5b+YQID+fQCncA5+aKnxNnPzPG?=
 =?us-ascii?Q?Z3J023mdrNaGc8TISt1fxjwdbbZ27yW8+nzmDf1BFJp8QSdxuQTKOSsSxT7J?=
 =?us-ascii?Q?xpBvrtSaDqar30p0+JnU6qBe9m11rkDlNz0CyXgpyWSXq4redal2UXR/geI6?=
 =?us-ascii?Q?fXgLcbIAgI/cb9AA8nFCuoC1cabDcaweL4e4lFQyDfsb2NcjlSnxwWvMmmdk?=
 =?us-ascii?Q?13R3bUh+G5JBKcUaKaf+1A1A9yaPKbX4vU1HAfSIoVoPfmKvyOhk51O4DM/j?=
 =?us-ascii?Q?62r76XtRYrRbLxcNzsHPOdRMyNwXfzNuLdSXLuuC1GYhXIo2ReE9e2EMZNgm?=
 =?us-ascii?Q?36IBoVQAuxGAIfYBcFBHCQFtvnhcMOueMZRmqgrHc8kO9/ww+Gf/M0Px3jDz?=
 =?us-ascii?Q?UNlVWM37kSJjifjX1KpePl3WhWLxRnfg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:33.4794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f797ba-25dc-48ac-31f9-08dccb39db7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

Adding the config option SPI_ADVANCE for non SPL code.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/Kconfig      | 8 ++++++++
 drivers/spi/spi-uclass.c | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd785aefd5..cdac275570 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -20,6 +20,14 @@ menuconfig SPI
 
 if SPI
 
+config SPI_ADVANCE
+       bool "Enable the advance feature"
+       default y
+       help
+         Enable the SPI advance feature support. By default this is set to y.
+         If you intend not to use the advance feature support you should say n here.
+
+
 config DM_SPI
 	bool "Enable Driver Model for SPI drivers"
 	depends on DM
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 1a61926450..bf987ea432 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -445,12 +445,13 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
-	
+
+#if CONFIG_IS_ENABLED(SPI_ADVANCE)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
 		return -EINVAL;
 	}
-
+#endif
 	/*
 	 * In case the operation speed is not yet established by
 	 * dm_spi_claim_bus() ensure the bus is configured properly.
-- 
2.17.1

