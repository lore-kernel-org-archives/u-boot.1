Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1DACAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641D98317B;
	Mon, 29 Sep 2025 08:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLNg8Mfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E6583189; Mon, 29 Sep 2025 08:25:05 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D5A8317B
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+PDd9THtMvV8V92c6LvUf9ry9dtA7SjmXbOjKENWVPUWJbzA4X/N56vNXxW0S3OZQF6JQun0lGAgTLLr9wXTKb/eSUAnqU0MMNeew2OqWgpC2VrOESUKxTP3JadT5Mw3M2kPXujMHRwx5m0S3886bvHdqZarQ8YCIdpY5QxMLk9b8LRln2FsB0Llr7wn1N1bm6LTQYABiZX/SwgO6ZvzHuvNpCNTqlRnYLWirzl6PuxIIKic+MKZtyzJ2tHEyDXaXHekS6ZN320I/Taq24hXjRjuzwjwTul6cnbUYDOlnnNGo04zsuUnH1sLRlPSnUjcUoCLVALLFPVnoRN6mfR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V9mVywlA6wjT+sXDhaZ94YvkVS8UIOhFcrhWGiRc0M=;
 b=bM0HwZ+43oD1gWREgRXUNeF3eO7+sl3zPV4WuVvdk1t/ElAFpfIJeuqmbyLpTVlu13iuzbgsYSncXIi/dungl/K7k/0ZOIO6/+84uTaqJrU20uFfZaODeCE8m/stC6P038qDGSc2vwXttDyXkrsipsHcys1qVePdYTERG3T1fASx7eCDtWfu8Vg5m2E+uXksezyavYgGJHyiBFqEVXdlmHeO55BAoy73FehGtDHhnqMzKaacrX8kR1o1qV77/2oibKh9Pinazx2L3otgCPHVU1Svm0j6JTVJeSyU1Sv7MtQiiYsVWzA2yQasDojOIUbgp/Ol0xg9tOBEnJ+fau1wnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V9mVywlA6wjT+sXDhaZ94YvkVS8UIOhFcrhWGiRc0M=;
 b=sLNg8MfkJl2uSq4yci1uP+b/8E1dlxjIqOAAC4uSF3tmg2AtWFMRY1ECeqTz5zBYxqpd+Be4ms/bK2MqctrM3Qw+kquvuUe07ZVdBDbrPE6WWCtg/hU+U10RQaCj3r/dFIE18lCRQLpPZ/SkufbUMlySdUqVuuS0EAnHJsqE7GA=
Received: from BN1PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:e0::34)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 06:24:56 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::b6) by BN1PR10CA0029.outlook.office365.com
 (2603:10b6:408:e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 06:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Mon, 29 Sep 2025 06:24:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 28 Sep
 2025 23:24:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Sep
 2025 01:24:53 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 28 Sep 2025 23:24:53 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Martin Herren
 <sputnik@on-the-web.ch>, Padmarao Begari <padmarao.begari@amd.com>, Peng Fan
 <peng.fan@nxp.com>, Prasad Kummari <prasad.kummari@amd.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable sntp command
Date: Mon, 29 Sep 2025 08:24:46 +0200
Message-ID: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5702; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=E4EXQ/NyUYmLRn7jZjhfQ3ZO2Jqa83L9kJ+Wt8I6+D8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcUtPXlHj2hEFaw/vrIaFih8XJK/8eyefb8MmwOChfp
 PG7iuWhjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIlUWMDJ+fCVdLrO94XFy+
 jjdCzKXoz52pCg777lfaNpzS2Pok1YThr+ACo4zD//cqM/lzfj1Xdt+CY22g2L7/d2u+hN97Zvr
 kKSsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb70a66-01c9-47c9-a077-08ddff20e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HLJDImv8jEcuE1dzxop9dALZzW6cud13aG0MoPwr/wChaJvjhebZC7bPxOC6?=
 =?us-ascii?Q?4CwjrUxaN6rzWasUebpVMdYSS0jBc6lXon/9j2bfv71xLazLOaIPXS0P/o2H?=
 =?us-ascii?Q?+FiwgVZV5HNVsSeZkuwr8NCGW2W10iwONMs32XFk2G1A7NqYpmOaFdgFJB4M?=
 =?us-ascii?Q?ky3h7tQYoxku6CsTPPcOS5HJtBOEhOwBlSzxIALEpx5/mZ9PTc04Km/4u59y?=
 =?us-ascii?Q?bGp0VqiYvxaZM4zdvOtoCsdQROegP/9UG9yThMdYNk1Th8DknetkZ0lHpTm5?=
 =?us-ascii?Q?emMt9VNd/qDM88r1BoWWxEWW1KIjI3bsoCjBL4RynqTsTcqfsbr132nOZf/S?=
 =?us-ascii?Q?FloDVvIlSXLxMDsOAAUKf53Qpzj67PlxP1hSEH+uJ8UgsNUqnt7N9LM6rFhI?=
 =?us-ascii?Q?wd9L8CMXMfcMrsMGx3Iz1DXH+s0c6ZfEDfBV2XdqYpYQs/B+6h5ARXEb13hz?=
 =?us-ascii?Q?wACHWaw64Z52eQHjL4LkWHFLRnCokXDdl3nm8sOoAkxyJcLPs1OGI+sJU9it?=
 =?us-ascii?Q?SmU5CG0u156hMXDahWLjnm7krTvEFzR99EhNmdDl/miuPayHaK4rdjuHEDf0?=
 =?us-ascii?Q?5C5t93aZjT3QRSs65n3MqnELHRUB6Gq5O+0Xv4v0IB4fcUMUT2yYrc/EXYi1?=
 =?us-ascii?Q?798FoIRho23pmwMwh8URbext91bXEJr1wOMigC4OEy7w5cF1kqhOEnpfBQwA?=
 =?us-ascii?Q?j6s6yi+kJAzMBYI5aT2sjU1huTab8f7bI83RRukrJLqpZwl/oaRV2CvlO3mG?=
 =?us-ascii?Q?gnhoJQ6y3jBOpmJFhH5/l4JSOjoEDoZPcupK2+TGkFnf/hLsIuC/rC4/k2gi?=
 =?us-ascii?Q?C311uwbPbqW3UNDEVkfj+A6uFUU+sImsxMPW18J6PqsyRDoVnMU8pvWntRFZ?=
 =?us-ascii?Q?G3c/hOuq662Z+/MLqkJyNLWimyHTk2aDKlUk1YRo7XN2YIGWbKnN+xB/wRZU?=
 =?us-ascii?Q?3ifkwwHduvKqV2GyANaboBuADUl8imuwtV//MKXHKPVP4atlhIqonL6/JwjN?=
 =?us-ascii?Q?SoblXuh4WwKWdVesLW+EQbnpWeNPJNSHjHJBre0OF2dobS+FtL8EpW02On85?=
 =?us-ascii?Q?17ZBX0hWYa0Q8qOJAcVNqIcUhmA0O8i3jsx6zaYjndAPQCV7Dls7C+p0IFj4?=
 =?us-ascii?Q?nbWBtVIoSZ8okLraf7Ab1aL28mcWwVeU4NoH2weT1cso4PmyZqNJ7r9vT19c?=
 =?us-ascii?Q?nZnCdmg4O4ltDPhnfCiJOOqdAG09dqHSOdj7u5jXfcgss1CnPScDOhmr1tG9?=
 =?us-ascii?Q?WobUgX2A1egXWmhb++ArOdSWuXDHoCuyUGjDULmL13IuumFiyp28+lqd6Vb4?=
 =?us-ascii?Q?Os3rEkVUqEJbAQgAOFAVK814g79Dkn4ywL5T3/WSgI2xxmTprrYZ0Jynv0Ip?=
 =?us-ascii?Q?mWxXt1qL2OUaH7w3QHDekJ7TFetSQm/DGM6dO87oEnEvB0pEV+bWeC5JPTEh?=
 =?us-ascii?Q?h8gRkkgfhaqwVmn2kutvRgU6AkF6WDnj387+XGXLREnF8b11smwiRKW9iCN0?=
 =?us-ascii?Q?pI1SrXxlzYxpB5w+/4b+rhBvgOV4KFybzYQRcN83LsYG23auBQc43n+5psUU?=
 =?us-ascii?Q?820cpO+g97eR41iL1oE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:24:55.6636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb70a66-01c9-47c9-a077-08ddff20e840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

Enable SNTP commands on all Xilinx boards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig       | 1 +
 configs/microblaze-generic_defconfig     | 1 +
 configs/xilinx_mbv32_defconfig           | 1 +
 configs/xilinx_mbv32_smode_defconfig     | 1 +
 configs/xilinx_mbv64_defconfig           | 1 +
 configs/xilinx_mbv64_smode_defconfig     | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 2 +-
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 11 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 5791f0415c95..4a7bc1951451 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 07612ef5e932..e26613ce9099 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_SAVES=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index e3341179a682..2bf1f33585ec 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -32,6 +32,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index c95b44973952..b9263940041e 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index a3cc1a5669e5..6216ba855b34 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 3d49670c60c4..a3ea779076d6 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -35,6 +35,7 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 13d89c473392..770bd0643c19 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 52142bcc7b2c..ac78dea587cd 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -52,6 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 4412f52bbd2e..c4f9df16a0fe 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
-CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
@@ -71,6 +70,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index a99462864106..1e0728fa4f3f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -82,6 +82,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index b45ac8063fc3..6e4ba7269f85 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -81,6 +81,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
-- 
2.43.0

base-commit: 7c742d5b1d33e5455560510b76905cc47d10951d
branch: debian-sent3
