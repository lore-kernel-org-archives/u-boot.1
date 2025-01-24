Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F55C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52024807E4;
	Fri, 24 Jan 2025 14:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8jOZ6TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B981807FE; Fri, 24 Jan 2025 13:59:59 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A760680780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 13:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGMj9z7HB8YfIJsjd6ArJC1tjYkDkwQKMBKW0xyedqVVGB3h+WSpTDwlDeNcIS5wGLr6xkzSj4KU8dla7BI4XWt/JWTpkHKHrDug2TuLNmt3X6HTKWH0JNLR5uOshARRUeOElAeePDq9q0aV8DVdRH3eEJ/3WINLeKXbfkE35QfXpcCI2qrhGS2AMH+f8Uf9GciYOH9B+xX8Pe/xpxT2aFuPUJs6YmbZlI0/BMmMoAnnrzSjOkgi673+K6s28c1GCaUobj8esoarzUjYd25H4RkLTdgRRFJo4/bTaHcifC6pF0VYA46hRDyON95bKbv/VDqWkmovYge2vuHRVC/vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXUl+vyb7kaJ3KgwflCe06ZrCIBhpk+yCmqjEnTi4vw=;
 b=njAimQM4Al9Z48JQ9Uqnrkr8lmzacYwRqdEaKVaOIIxPddWwd6Npr7SSp8SEaU3vvoZdwnX2SGzERdH5utyOuQpZJVtBi5t/UHQpCvgepgo59zJTiAGsv+7sv9wuD6fx0HY1dT2EBKGkHwgO4m12Eb/9xL8STec2dyNwY4iAOKRYaAPmNN26IJawlKOeZI7r9h6v2xSqxT8oChxNn7gtJX33acDVum6XnodKWTRhsdrYr1pytXQfqJkscBCO+T7XqLU8J8QCk1SGQN6EWuQgexqkhbqsoDWeiJdm69XAnrXNsgKjRUV09OkDWzjum0Q/jzJZnIIn1xce3t2MG+5eJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXUl+vyb7kaJ3KgwflCe06ZrCIBhpk+yCmqjEnTi4vw=;
 b=R8jOZ6TM1IZhtg0IlST92S0Z4uMakmHceMybvXGJTsg5Gjd0Abe9XKWuCMr6aSx5oqqcMe32yNe9kamQbOH8FWQUeSdUv6BUtLs2dlDyz4FqT6psQrB26wQGsYPhFkW4mETZK0+2By7v9fG7j0U3I5PC1zmVULV46fRJ0RG6Q1k=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 12:59:50 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::c3) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Fri,
 24 Jan 2025 12:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 12:59:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 06:59:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Prasad Kummari <prasad.kummari@amd.com>, "T
 Karthik Reddy" <t.karthik.reddy@xilinx.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable meminfo command with mapping
Date: Fri, 24 Jan 2025 13:59:37 +0100
Message-ID: <049e6630ee182ff9ab2c57a978c15ab3e2b35e63.1737723573.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YCTizkUgay5vBRw2ErZSqwXkGxQtfN/QeiyFibXBbME=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTJfbu8/cQfl0fds6zT3XKFqfyTXcyjc8IyO8Tkzj28/
 Zz/zqSAjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRSVEM832qXX5z33X8LuCy
 /GPlioNa++exrGRY0L9YudfPPP31i1/qwhNvbbge7j7/KQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 46350e2e-3ca4-45d1-033f-08dd3c76fcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RgmbJ+E1i+M83V7NGZ2LaoyHxgVrhnzF92maXTULmg9nUImd6GbDRL3cB4PY?=
 =?us-ascii?Q?VvmdX8/Fg7TsTd86Bf500N8xIqCS9rAlCBTYG/Dt8oMMgu4+a6VcidxOYDxl?=
 =?us-ascii?Q?g1V/8FRydf09VqwpnH/UM5SXvjT96HnaAD5j71mj9k07anPX3NJ5S9FCwYjy?=
 =?us-ascii?Q?WXaFgxan0g0be6HuJkN0faX/i3ebR7z/5DaRh2G03mrk07r9aTYIOh8OliVr?=
 =?us-ascii?Q?QHsUTPDWvHBsdrpAs5rp1F65uREpdjIYWt06HJWLMwVWbp1XANiHYK5SXchD?=
 =?us-ascii?Q?GAA0MXWOI2bvPQ/8gC2CfD7eQt/swdQz7WKaR0CzaieC5ZEqUhFlNjMBncZf?=
 =?us-ascii?Q?ODH+fVTUzrFfyqB5khp0+/vFxMNlKtGPspj/kt0O8s8Cor32Xg9P6NGnt1L7?=
 =?us-ascii?Q?DUGOkgK30gge5kvhjqM5nr+JlpueSxaIUje3YZe+6qgNn8JczFjCIyI7yreM?=
 =?us-ascii?Q?MwIjzBUFz4F1T4A4maIIuWt2HZYoKM85YcvCWKNXSndk5u6iuwYnYj6bPB9G?=
 =?us-ascii?Q?hqFjiWhpyN6uIhzPWM+ERL/Yu4AU+JHO+S6i4BNqtm4GQfCDuwte7BINCH+x?=
 =?us-ascii?Q?W3sELNWLkgFbrVCQ3CqA0bXb6gIXKx9s8OVNZWS8fbVWHNYHtGGlRsq5ygm+?=
 =?us-ascii?Q?NMw3BD2yWwmVShKgrYYWHYAdfyu8+NggICjiNUMtMso0lq/IMjIYN3LXrSdc?=
 =?us-ascii?Q?VSlYOKAhAO5egiJqMz9lPb0HdWI9ox8nU8WCw5ykOyqLts/IIK741cKH0MTl?=
 =?us-ascii?Q?IgPeE6J6G8uBwNBGHP1gIOKLf65WE6TUx0lOhkIdQByUesNb+iZ6PhBchyrd?=
 =?us-ascii?Q?5UIqdZbFrjEOgCEeEMW9Tgh8/cTYFjH6zL4KQqB/0TVfd+O/QJzDCGpX1s8E?=
 =?us-ascii?Q?4zpw7IebAsRsHIpY3uT5dnske/Dqvg9CiNcG+8rJpXDmT2tvLNT7as3ARUqZ?=
 =?us-ascii?Q?HLBpVvp0lmx8MTw75Vk5H+mUgDjfZ6aIKEIU5u3rAfqWoZJKoJOjUzSW+/Rh?=
 =?us-ascii?Q?JIo/EWlMmRZoJ2J+g+33NUP0ccQwL/6UlSi02JQpdPxwrFC6/RccLVpg1V7u?=
 =?us-ascii?Q?tVh9eCMfmQFqiIvje8teDD79qsOLdw9xxMUsbHKt7jsHd7w8jo2Pf8ZisY7M?=
 =?us-ascii?Q?j6OHFeaUbV04qPKzz/udSjDtePQ41pzCVoEUlzsQvUBzdtY8DLgapzNx84Mt?=
 =?us-ascii?Q?q+U+Uxbz+/yt4FPFcSyI27I+E5IX3T/iYwpdTp27XlxcWIAYIiYJOgIGv3VN?=
 =?us-ascii?Q?hphPUodLlVMLiUUkSbMGBfFT5tApYQTAcCROdlICsxcBT7uJ9jPfzBUR+7KD?=
 =?us-ascii?Q?nszirZk2R7V2OVErWeHSEv1/GNI+fBgBXJezNtopHH4WJuoKtE2ofaTIO+ht?=
 =?us-ascii?Q?J9eJ7azaPw17yTLo/rcBMd2PyvGb5vj8NWZeKXBfJuOPVqL0yEWmfAsnloo3?=
 =?us-ascii?Q?MY5RRT+bTTntzzJxelsQU+eRRogypipNgY9r/8m3YlT6mrYT+ZBaI7dl1bGF?=
 =?us-ascii?Q?PJDQMdhNzAMk58w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:es; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 12:59:50.1066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46350e2e-3ca4-45d1-033f-08dd3c76fcdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
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

 configs/amd_versal2_virt_defconfig       | 2 ++
 configs/microblaze-generic_defconfig     | 2 ++
 configs/xilinx_versal_net_virt_defconfig | 2 ++
 configs/xilinx_versal_virt_defconfig     | 2 ++
 configs/xilinx_zynq_virt_defconfig       | 2 ++
 configs/xilinx_zynqmp_virt_defconfig     | 2 ++
 6 files changed, 12 insertions(+)

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

