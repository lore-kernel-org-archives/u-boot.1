Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD160C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 11:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FAA81119;
	Mon, 27 Jan 2025 12:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tt0xffdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCCA8111F; Mon, 27 Jan 2025 12:11:58 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E570B81115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlhEKL7IrP0+SOElV7jxwEpjBRoCu4V4bLcgRZqt7kU82/a0JU/Dbc6HZ2wCAMjPJT0LLWb2McxFSELj10wSdrXwzoFX95wqRn0G/eg+w8KOKJEgjsxl8eMFSDJwdMgAlz/NGiS2U8hcM9kBRWhLu5t1nniqbUs5toulHrVagfRPMwLWsbx75zLCECueeZBK+FsF1UKzP5hfTFSkbvN2fuo2sgRnk9k9o2D7eJbQO/gi4g1bxCeOJBhH+aEuJOiDJUkowd73NtwKmIMJwMqsCUs1osHlCQ04AZ861bcK9wJKPmhd4qKzpC9CF8YZDg3PQ7aNZFsP32MJJ7rDgGYx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9JhwQMOWo73gNPTHHNljDVxvhRUw/hEwazPxAftxI4=;
 b=H3bHZKoM8Twpzl3qbJyloySQ50bN73Xl0fwm6aHMSs95e7gYgmK1vxhV3HK+4m44WT/kW4IWLZo/+v2WduPnHR4ENCo1tx8Xsy+G3JlHJU7zrvdBbgnEo5jz5k+AcRMQ7IL9WKgw263ilWNvY+2wqii3/9vcOTSM1n74iMCRQ3QVuh2P1+vtxXBSDk1l4wDT+Qx/9iLyYyAUb1VkO94lXQYe2ttXDjhaKTdGxW/4AQXpnRW7G2SjZe08KaTB8BOAnUNd+8ysBFCNPr+PmJVYF1+eNBN/sZS22F2y7FtB9rfZtrPNLXiyasM6s1YhbjrPvAFPWmS/9q+oGUdHalkNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9JhwQMOWo73gNPTHHNljDVxvhRUw/hEwazPxAftxI4=;
 b=Tt0xffdjKrQSmdXM4enxFZmmwVnsnHjIJnVz6hApmPPJRXOZKBDOIu6+GVDFTQ5gog3A8onr3sQmkBZR83aAF1Gb+P5Xqn7j0ILzRP9IFpspEFNsHRvN5gU0SCrrvjUdzsXiZtY8eCrthPe4N7yPXylS7oijg/+A+zlB9EvfTNA=
Received: from MN2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:208:1b4::34)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 11:11:48 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::fb) by MN2PR15CA0021.outlook.office365.com
 (2603:10b6:208:1b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 27 Jan 2025 11:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.0 via Frontend Transport; Mon, 27 Jan 2025 11:11:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 05:11:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Prasad Kummari <prasad.kummari@amd.com>,
 Srinivas Goud <srinivas.goud@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] xilinx: Enable meminfo command with mapping
Date: Mon, 27 Jan 2025 12:11:38 +0100
Message-ID: <b7f9f5e18e16a945277d4b8cfde5a7f057e77676.1737976295.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=A7Oxbpn0F1rzE7GxF5JeYOs/FlHutuStyzZ+VH6+wM8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTpmW+yD5s/8vA7fehZ9AulSxy2oe8C669XqU+T8j5/4
 /r/n9vndsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJTDzBMD8ju21RyTmtne2X
 Pv7+uU7FdIZz0C2GBdOMNWe/Ld/+ZNMV+RmLTFmXrszyyAcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e31b38a-7815-4ecc-4e64-08dd3ec36428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SwgqsXqZ6CVPY7MuqzJecqHKJ1ZbDpE+r4EOTjxg9IdwZ1IoxK+0RHAl7uR9?=
 =?us-ascii?Q?s74rTz1dzowFRKcMEOc6Kf40w4D6qepgYfi+WSN16gfIi32cO1kTy4KAAxx/?=
 =?us-ascii?Q?fS7I55krBi/R86bCFBhDRrFc+ZIJUQEiDGXvnkQKliJ/8hei8HH4KYOqhvK5?=
 =?us-ascii?Q?uWA/z1QDsaiVTiDDJr4SZcPMEMWBtzrSA7uv3KJPqrN2gCdkcg69rdDaMXek?=
 =?us-ascii?Q?QkyGUWsqiGxEg/yeXUjBvZgJf612DRCjVq4GCGu0tWet5ctuOcm3HH5z5K2b?=
 =?us-ascii?Q?/nH+B+sHXK9nU6UkydebAqwYz/Ah0YKFdBF+C0I9yw4Sf30LdaHb54QuVFqw?=
 =?us-ascii?Q?xirtV/fO3ptr59r+8XXveSVxnz9Y4dQb+XbJuMr+k2QXcnlDkQ7gvWXaKHVA?=
 =?us-ascii?Q?mdfvalad7p0lXZ6+mvk0dbOnp/pAnfkrLCYo8j/FsEsQakEo+e1pGNnS3zHS?=
 =?us-ascii?Q?TumoZSuUvGALL8UgLNJO1o2IeMr+NsHX4UI4yCMMpq0J3t6ivnsyXdg0v8ZM?=
 =?us-ascii?Q?ug73ThmTgSxogup7nhtQAHWFc/rIU2SQhnr8JgWPAxxQDKVwPoIF2BXbC2GP?=
 =?us-ascii?Q?TrYE97P3yTf0+4fX3pSm/KMuEhWBqVeIEpU7tuYyLmfSyNZPGFzOoCMEPb5n?=
 =?us-ascii?Q?rZGu8jeNVovriRAhach9TBQbA9TB666q83kAnMcLw0lHEHrSXdu12uNU7AJD?=
 =?us-ascii?Q?/tvV2KxAtXKlhvQHoOCxtkxGHz57WdVnr70D+2kcC7C2Vq20a2PJzq20sG/P?=
 =?us-ascii?Q?0H1r2wiETqPzZvR1bp90WhlJd3j2R1VyD/Icn8JqlCIo8fb15DrHyTU+5M31?=
 =?us-ascii?Q?uuKZtzLKnFOk6nRSLRAdZSh+70zJ4cUjrZUMApU9jQr7zOYQ/58LQCSVfuiG?=
 =?us-ascii?Q?bYpiaRFTHZ7J+meBVumvp7G9xXmcRsAvblvEVRM9FKgDDutxdsqv3Ak6NnW7?=
 =?us-ascii?Q?ieKK9qGI+A5yovheucEG/RmciHT6qISB/dtzr9cq0VwJpssEwUjoRxrKBnqn?=
 =?us-ascii?Q?xrh7s9t7vztlHARVmSpW+YR/6D+pVQJvP1VC+1+NEkldkC4TgbCbs3KY921N?=
 =?us-ascii?Q?HTabbuW16Su1rdAlLC/mcefVtPz4bMCvwLqSt9QkmGs6qfn0uY0gDtKFk2jg?=
 =?us-ascii?Q?0OCo2Q4u/4VwPCBhLEH3yBkSfCT41HSZhn1Mgn8S1HLbe5gw0r/hu8nNKsD9?=
 =?us-ascii?Q?ongZImzK1zDY7bVU4t6l1FIJQwp3sTCnxQspkvx1+or+3HHbilOL2npHiv+Y?=
 =?us-ascii?Q?GAdOrRGA3U5EBSX8YV0EUx6Gzojx3PPIBjUd3fCCO40XBRBC0VMa4JvHCL3A?=
 =?us-ascii?Q?Dk+PSqqMHaBq3ln/3B5UP7r4k4LmXrCQdClEi1MnqUwU72Z+45xOhw+9KtMu?=
 =?us-ascii?Q?pG0f8Axko1/59/2d9hFjp9bAB7I2otn22gbyxZMwrkp5u7TFhirU8F0wxS41?=
 =?us-ascii?Q?cVAYLB6tmWvvEHrF5AB2wKYzALMc5U6gRvwIoq3QQpa18ewR7huTlJb49IHd?=
 =?us-ascii?Q?3igDFCd4rMkAMxg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:es; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 11:11:47.5761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e31b38a-7815-4ecc-4e64-08dd3ec36428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

Enable meminfo command to be able to see where things are mapped.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Also cover Kria

 configs/amd_versal2_virt_defconfig       | 2 ++
 configs/microblaze-generic_defconfig     | 2 ++
 configs/xilinx_versal_net_virt_defconfig | 2 ++
 configs/xilinx_versal_virt_defconfig     | 2 ++
 configs/xilinx_zynq_virt_defconfig       | 2 ++
 configs/xilinx_zynqmp_kria_defconfig     | 2 ++
 configs/xilinx_zynqmp_virt_defconfig     | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 22dad1b7076b..a7d8b035a714 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -30,6 +30,8 @@ CONFIG_SYS_PROMPT="versal2> "
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-generic_defconfig
index 2e618d81544d..87756cb26df5 100644
--- a/configs/microblaze-generic_defconfig
+++ b/configs/microblaze-generic_defconfig
@@ -42,6 +42,8 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_SPL=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_SAVES=y
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index b40f7b7f8556..081ad424a9aa 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -32,6 +32,8 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ccbd33ee1cf7..dd6e3ca34660 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -38,6 +38,8 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index ed3d10194857..c2422c5b4dcf 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -56,6 +56,8 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_THOR_DOWNLOAD=y
 CONFIG_THOR_RESET_OFF=y
 CONFIG_CMD_GREPENV=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_DFU=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index a68bd522f90a..ce44148dc0bc 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -63,6 +63,8 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index b13079cdf707..05ead1a41b4d 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -63,6 +63,8 @@ CONFIG_CMD_THOR_DOWNLOAD=y
 CONFIG_THOR_RESET_OFF=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
-- 
2.43.0

