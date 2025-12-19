Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC94D78783
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 14:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F46280077;
	Fri, 19 Dec 2025 15:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tV7SDAkl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA71D803F5; Fri, 19 Dec 2025 15:10:04 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A0B80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 15:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMPXIg2KMVeLTUvsaopvlaK93ZRFyDs0sHzMnkU5aMJY3SV+MyW8OGEMiKs9/LSZVzv44CiplYk1oUI0fhU2iMb2A55qCn+TCbjeYZJ0MlF8eQ6mTlzoKEL0l2/m/7izqtoLZOz+TrUlax9ZjGzQkWTnbu0k4z2x9YjzTg2mAjh29bQmy1P5oA5Evqp8623gBXjVQx9Vs8hnrpEg0zcsjAoBdtPDjGkfEh3rlSwMliI+DugkpSIbhLslbhNiEdWB5oYH2rNY/3/tKU0G/6jWMNnOo2ibxtSVAebauJ1BwmtbSaW4FrUh1tJ6WQeKlHSIhamoczlUsECe+YTdHT8yFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj/SwMHEeQeQ3KzVHc+a4ohaQtX0Axyz8TgijZHynCc=;
 b=jEgZSJhWWyZ3PVVtxA1LhhkN0U9e4lz8pqsg+USKU1pKUKiOC5Hh8T6D2xdv9XHA2NrpPvTPeZ+HOJO2oTZ5nhtLf82dyVfi33SstSnHOp2DKrpyYMt0dzZGmTeq7fVe0vF8+Vzr4emP2qhemPZa5g1+3xcaLgkcinh+vv3D6CBxClJv3TbuCu9tQwOL/+X927u/w+VvH085x6iLHB2mjTFrmk7PZP2IsAZq9U+KPG6sHVAsWaX8kOtcDpOsukX2VPHc34DIiuFLPAYxybFI+Tpuj1muK6I9vCwxA/x3+lYkF9E+9gae4M3Pw5sGJbakeVS/rdMmEzT9Ar4ec9CpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj/SwMHEeQeQ3KzVHc+a4ohaQtX0Axyz8TgijZHynCc=;
 b=tV7SDAkldk5dygoF5btshqIU11oMaosvNYCCXJo9Vy1RxOCByXcIKFzriYQSJk5ZKudT+jCcuZLrXzp+jNiiCJO4TKriTvtRu+oNIGwZSIwXfSnaAa8xZ8NuHyL0/Spa+0cP2SjfZYsgnbBhN/a7kbitD/S53w6wYs5zeq28kS0=
Received: from BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 14:09:58 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::a9) by BY5PR17CA0059.outlook.office365.com
 (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 14:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 14:09:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 08:09:54 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 06:09:53 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 19 Dec 2025 06:09:52 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Enable pci root port driver
Date: Fri, 19 Dec 2025 15:09:44 +0100
Message-ID: <bc09405d9a2df190f807bdf750ed47b86e6b83b2.1766153383.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=R50dA8MMI3JHNVqQBzq2UNmq/4Np9KAb+ZKzxWsgxgQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWS6xqyqzhEqsuaaOHfehK0HglZqPTlo9Pv2m10s9Yr1X
 Ws9WRQ6O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAimsUM/8sj8updPFeHKpso
 +GavXye9XNFM8dCZ9b3HRPZZ8Vk9nMPIMNGmU3CN8cVQNqltrXarMo/F10Qcr6iRn2Ob7vEuV1a
 PDwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 7351b5df-bcb4-4c54-470e-08de3f084a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FhuNZWBtPuIDl9BsUPMGf1O8XQUrnZcu70m+spXF+mUCvSSRjzCiNTt/5pdQ?=
 =?us-ascii?Q?r22uISAcIq/Upy4IgYMjmzj1MOKDJB9pWujL8Nod9NesOFZIO9H1Sq64imjZ?=
 =?us-ascii?Q?RwXzEDrhF3lDjIv2Wh3qjGRr4yK1oWSOU5HG2XXcGVlB8rX8g4Zt5/I5pzk6?=
 =?us-ascii?Q?44PRWNiMkkfSBL2dzXpRWN/3YzW6ic0WQcuqhJL+wh8ihK1VdiVprx22ZNfn?=
 =?us-ascii?Q?TLQ9ZxdkjYokv8hOzp6UNpINJnIUR1bFVzkBc9PxcSIpf4cj/CxY9dThoj7N?=
 =?us-ascii?Q?ScoRC1PWDt0PNAmCi5jccNPqBxMIGNgUkxbfBtR6sGLL4JRBFLFDXk2kxrVB?=
 =?us-ascii?Q?Ici/zL0HdIPW9SaHm4Uo8RfjHWEJF4vBlr77i5yXef0I96N3xxwF+TZUsevn?=
 =?us-ascii?Q?8p2jii6NDHRpe4n1KoGFzofY6VmUfFSzJX4Mbxrk4zjnDXin5C5IUoLU9235?=
 =?us-ascii?Q?IhPE3NdNU7plRsHQgu9vm6CnIHeyKcVVlAUFLzPT+POEQ5g+E74yOqO4OJAH?=
 =?us-ascii?Q?iX84SCWHFV/AW/U1g0J2H9N9sEwfq8kF5I2VhlMFmvGc5TJQ+CFhN6NndPLb?=
 =?us-ascii?Q?2tv4iZObs0rlV4FClOs6j8/IaYP2OtyDwNTYWb3TfWCnuvzBWrcJEsMkYQCz?=
 =?us-ascii?Q?ucfVaEYGmVHA+NSgqkS4Zh71vFnveUfxS+zSpZF7MhyrtPKmtgbPX4Lx6LGn?=
 =?us-ascii?Q?LoszWPrBPyYBaVOMaWOktP7PPqgwGIzANWqotIn7jj1t2SlAeyLnmSl9asns?=
 =?us-ascii?Q?dRFKCtOOduqgrjMCX0z/2gZvf0uHAtQZ9jvzkZUVUh39V4dTYqEWJltM182B?=
 =?us-ascii?Q?LKCg2dmNeT4EAhqjL98PdIOU5P49dCQcF2p5BqltqCtfBcmCkD8T2QB0TuFI?=
 =?us-ascii?Q?Ludu8/LzL5Jr+fMXxdnSwGovg1vLjVtLZx8m3XQpFpMHBo40PvDrK1hi93QG?=
 =?us-ascii?Q?QdhpxgPJnx0vf6JtcDIdOgAxbnw432e7061DQ7TKFiRm697kXEmMDlyvEiCF?=
 =?us-ascii?Q?g0J8T/+OGo4TJa84GpZ89NAOz7LP7civY/CEzPylzRsG+HAgt2tavTWFSEWC?=
 =?us-ascii?Q?RsCQRC3xZzaRrhok/WbYxUFH1ZmFPMeNMtdNdLOIyaAe2ko6knXuiNNvok9J?=
 =?us-ascii?Q?mZ1towPaDmFkwo3TZZRGnR2ruohZHa7wVr4iA1htTtVVxrXjjH+MQUReGTpR?=
 =?us-ascii?Q?GucOA3aYXv8XNPlH/u8xThgq7Wrm6qzrQHqShX3jU39+17Wd6UKmpp4z5u7A?=
 =?us-ascii?Q?iGEeKAhm1wX7crXalQJfOG1TVXI94l2nNKvl5dFRKX+yFhZS68qp9S1AyZ/S?=
 =?us-ascii?Q?e27Iv1YXt9AMIRCgl5WJUIr1LtEJH9EUlwSUasFy0xtXub0vP/SpiAOnR865?=
 =?us-ascii?Q?3j82ipNEeKLp0X6GoJycDFG22bfYjMc9ixeTW0iPY3Oct+k9oKy6FB25Rhuw?=
 =?us-ascii?Q?IdSp81N+42pjJoCXWIsxIgipradcE1xXMlwhqjRG1+8AYxyn2cUbTL//Pp9l?=
 =?us-ascii?Q?gnYXI3tv62eVrrlbopI+0hhnzMr/dIWID1Ju2QpFRSwkOVnzUPVJRE5xl8LL?=
 =?us-ascii?Q?55G97tv/eLOZrAUQM9E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:09:57.1916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7351b5df-bcb4-4c54-470e-08de3f084a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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

zcu102 has PCIe x1 enabled by default that's why enable PCIe root port
driver also with e1000 networking card for validation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_virt_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index fc610fd4af5f..bb79ddf989e4 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET_REDUND=0x1E80000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_CMD_FRU=y
+CONFIG_PCI=y
 CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
@@ -76,6 +77,7 @@ CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
@@ -180,8 +182,10 @@ CONFIG_PHY_XILINX=y
 CONFIG_PHY_XILINX_GMII2RGMII=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_ETH_PHY=y
+CONFIG_E1000=y
 CONFIG_XILINX_AXIEMAC=y
 CONFIG_ZYNQ_GEM=y
+CONFIG_PCIE_XILINX_NWL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
-- 
2.43.0

base-commit: 0b880fc95dbaed88dd55060730857b8f52765c57
branch: debian-sent3
