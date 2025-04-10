Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CECC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F33883A2A;
	Thu, 10 Apr 2025 10:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dG1pDY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9905583A32; Thu, 10 Apr 2025 10:22:36 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9961F839DD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm9/5IRhD0iBJRTGLPnN8Jqc7WG5VWgqc9f9bDbElldT4gu6YLcBm7wbV5mQPJljNKxPinX8nbQ1c8F8xQX76B/juPVsYyBmOxbrxjBTEmNfe8lzEsGsZFwN4WB+0TjPPbIGyhzyp+Ejg2ADEYVqV924ELI0tAEatwYQICa75W57hrp1FLy44EjQhDcKQFHwgd+nsuk3i7ZlSXUM4srnHInTC2VaHOfYP5r9S6sSsA4FQJHFs6SlQCa2Bh3Y3jnvpMjzWVlvBVWCPeWFJVhzlW4HT4Uz15kqNlq7z1dNqX0j7287og2YtOEp5Cal+atXyxrGUE/YiZs3fSbEgAEMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFOyjEeGiwclSofXV6sv41rS60JtHXEqYuVRUyrTWD0=;
 b=vVEanTWyoy8HdlzfoHKZ6/FfIisCUIkQXa0aXS3D5rH8BSOzG0U4BUqZkvbWgst+h+69CFyX784kHjuzkuDggEZG2FDEqwCfA7IZV56buBQaA8JsIMPkvJIhlnAi/0GzTgr3EEzb/z0/dDD8R5I621W4sCfp6fElfr+Xo9gIwurxwnLuQd/wKXVx5eAjByGalue9eaJqm29n4Y6wePzRVhBJlk3BLAVNI5UyRBGE0nz0qoR+Ng7/LZZLPodX/MFKfgREJ7aTquS+QEGEyk3Bb+ptGrLazWCJSu6C3ssh4LnKQoxCsC6c+Dw1nm1KOD8PCokc8qrVwoohqOiHkYtQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFOyjEeGiwclSofXV6sv41rS60JtHXEqYuVRUyrTWD0=;
 b=1dG1pDY57VJQr1rcbjfH5k2zCOq7p0royTU8nZCaByHjqVtsDjnrNCR2u3Vl2S5s//m6QMJ4+U5lQJQKa4fqwgBQiDZEpWAw7Yky4vuHeBOhF0sTXjdyO3Cld1rhlx0TmfPg9EGvmLrGpXhFWyQTxj3bqOfOjfd20zTaHNSaQ8U=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 08:22:29 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::2e) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 08:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:22:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:22:25 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:22:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, "Tejas
 Bhumkar" <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: versal-net: Enable loading bitstreams via fpga
Date: Thu, 10 Apr 2025 10:22:15 +0200
Message-ID: <3420e63e46e21daca3330ba2498aeb1ebc9b1fd5.1744273334.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c2a6af-c198-4773-6e62-08dd7808d561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6J1W7tosKCJoZEaiDuLnj+6THR7UFwxiGMeCO2jFQ6gh+58VoNMmlm45btB0?=
 =?us-ascii?Q?dzkW+nWBj4PWKqb1nEzUotPbMrhymHOTReSW3XYTvlID+Wf3TIn+vN9YZnqO?=
 =?us-ascii?Q?ooCUXs8oyCOcX1EW2bQiaFZhO313d/YaKoCAQPfo5Q25DESJ20DLeJV5TkBs?=
 =?us-ascii?Q?54HYh5W01z3iUe47++yx36dRZ/7jB55OJU1abP93gd2nbnKp25dva6abbciB?=
 =?us-ascii?Q?NQTI0rnFxDT8vfT8dIbIK13BocCFSirVzpTy1O2Hu6SZuV4mSA9Csz7b1v16?=
 =?us-ascii?Q?L4ol46tubHPfhqNIx2BcAZ90xWlOLriov2yoyX4trbn28/HDU6ZYYWmvhxs2?=
 =?us-ascii?Q?I0i5PuhA8DyZtH5TcdV1NRIYNkGBPfsVFggSJEHGKJu3Pc1ShCv2bPq6zIwI?=
 =?us-ascii?Q?c4TJahOZ01IrLKvsPRWaDBLvy3MzjmGb79OniUqiFEBxXOKEUndzqNKhpjPq?=
 =?us-ascii?Q?QGWoul45SDOEz9xSsdwLjz6azWXPaHT1fpqsnHhXMFpV9V4uhv7Xkp8KdMKd?=
 =?us-ascii?Q?kz0Qt4ZHCc/1zxiqOYt8MO2SJxk8IC9Fo3P9q4YdfgCG5iOmVxQkFoLVgNkN?=
 =?us-ascii?Q?sa1zM8ThRyHHjIonupymCaF2Gs31sOzQ2P355oa6Cg5UAowQ75uIPMMqeX00?=
 =?us-ascii?Q?pgw5rlA2CklAqJdEravdyGIYZUHp7mY4JGNT/1CjPMGsgKpMAP5EY5npxeAv?=
 =?us-ascii?Q?3dVb7wKTB5Pgi/Qw+6NYyrr8FAIR2kv+eGRFeNfjQ5l2nn33qlsK6GN6um/z?=
 =?us-ascii?Q?KpABXdc5pNoMRlC4UcMdo7v/6CLbJNEzIB6N7GxAVWzrlkjXaOpFLRxsXJ8q?=
 =?us-ascii?Q?/S4RFvoSKyzPm/fqQGIPo6yC+NqaEMygK83Tjk76RG/i76NtM0CkK6yfkPBO?=
 =?us-ascii?Q?ZqZ+mQMArJjtdQhUpTx+Fsx2K8kBUNDZH/azGqBCf5BC2AUDal7795vCj1OX?=
 =?us-ascii?Q?XzwAGJc/ZYcqOMzPKpUIJyA8BYrY6w51pC/KVulD1Y/HdJGlziOqh6Mr617R?=
 =?us-ascii?Q?5Q/fDHB/zFmSwPT7f8w3Z5RkFk9E1e7buIo9SS1RWKlAQuGUd6ZofTAvDaMz?=
 =?us-ascii?Q?2fSoE2IDRizwmIVXMuxCO+d9wjt4u5OexnJI2Tvo0haSqlnyoHUdnJu+TULI?=
 =?us-ascii?Q?6qBYk0W/uyGZ/+jLn17NcAOqYSYesnrBFR/0yQG0Jv2HUZO9SzffIalEhNBR?=
 =?us-ascii?Q?CYEBXZssN2oaMWthBPCWck6IRpLNY34yK7g+WXNZp7CbvbkjpQvvOKJLB8rz?=
 =?us-ascii?Q?MZm8CgmItXmA0/a/G9DPz5+SuXb69SmsKDpI2sZ14KqkVqKRdZi5QkpULFKN?=
 =?us-ascii?Q?zLOI3bFVZ2xqmtAxF/Tx9H4i3UsnVx7RNnKiuZ0t17HVU5/S+EjvflBp2Q75?=
 =?us-ascii?Q?+Qr2lXq39VL4IQm+t57h/1nqlfCTwl0fWBtmYYTDNpeLai0RGOCf0AdJCwDW?=
 =?us-ascii?Q?SqlBDQwgNsOLhAogULVJJCAYcCLgynwFSR8kQxJui8Qv+dd4GXc1AVQwRerx?=
 =?us-ascii?Q?vHIgMHSQQ5qiIeHeiOEcU45etKEirZUD+0pS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:22:28.9919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c2a6af-c198-4773-6e62-08dd7808d561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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

Enable FPGA Xilinx interface and driver for loading bistreams.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_net_virt_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 49dc9bb5c4d3..add233d2dbb7 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -76,6 +76,8 @@ CONFIG_DFU_RAM=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
 CONFIG_ARM_FFA_TRANSPORT=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_VERSALPL=y
 CONFIG_ZYNQ_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
-- 
2.43.0

