Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA488C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 04:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5723381D5D;
	Mon,  7 Jul 2025 06:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/j6QhL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1ED81D6A; Mon,  7 Jul 2025 06:13:27 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995F7810EB
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 06:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZbgOITB3UIAIBuAJPZAviKOtw9ruPFpJ06ku0Fk4We3UkSgwKRrA7Ob8PDB6PXTuwKLcIfgZ9MYpQAKBBY7BV3sL6RjIO31c5eJxMiyLrnVgBtuSwCT1DFsQ8CD0BZszJPiwdh2qjKUdms+WK9Tfv7Os8MwVL/eCDE+eTay+zEcak6Ulmg9sA9wILievEf1W53xAA1M2LbKwOyObG1vqAzloueHwaa5ZzsQpV4IJJoZCqDViN1fKc43hrwvSScA7u8bjrNQLz8nXlYUncjSOMHRnMsbWPrq3VItsrN+VuoxgR4+P4NYbSrR1+VR7UG12sTCCB3H5X77Wo9/a+Wirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LZRMhIqS6ftlWWpfk/r6/rcNGkq0q/CuZFGuNyahcQ=;
 b=Qg+DPjK0unzqzUSt5G1QyFVvyp7JnLk/sx3+PWUWHdjnpYMoNhIKdG3UFwT5JOa1P2XDLFQC/sCP1qE/eC7iwZ7kTPURmuk8B1nA8W8vJZIQBOip1/SPClBvS9iUUnXm+PIgDfNBMw62fVt+W1ikPfr2J2O4AFf9gk+9uZJP1CvK3tBkJiSN9PTDY0Y30/ye+6hiW7WJMV/h3L8EAb/Tg9ihy5xiuXs9dCBGt0RetShiLyjb+pBEOjC6O6x0pykmrMWnkggcDVBGK6Knt1O29NFvia9z9TZhs6/yLVLc5Q1wQM4P8CDAK586slJ+QWWqGahryIw0gkzgLwyK/IRqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LZRMhIqS6ftlWWpfk/r6/rcNGkq0q/CuZFGuNyahcQ=;
 b=2/j6QhL7bFRgJM86wLdU69K/lRZ3BZ4XNWzZ8E8gRkFba2GGa/H+fU6EULJUjfe743mHgT0U0so4K1JX8IWNaTOqI7c8vcFsE2Icrxf1rF2eIP4cNp8yr9LRIXPdKrcVo+ZtRikya8jnTR1w6Vsv4emF1+y0VAShVGSFPPGL+NY=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 04:13:21 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::9) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Mon,
 7 Jul 2025 04:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 04:13:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:13:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Jul
 2025 23:13:19 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Jul 2025 23:13:18 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: versal2: Remove the ZynqMP Firmware from mini ospi
Date: Mon, 7 Jul 2025 09:43:11 +0530
Message-ID: <20250707041311.769577-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd61311-73e1-4e20-77b1-08ddbd0c9be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DoH+e1KDZ3SXz6KxiRpKd3wh4+57Ugh/TUSBM5Ul1Nbk8DR5t8tl3WJIrZUQ?=
 =?us-ascii?Q?ubEF15ZxmZaf0atqbRVIMg0KDZ6lpCKRQbcUsfrTIcLUnbQ7K4cwGWE+T0ln?=
 =?us-ascii?Q?KRys7noUinQ9Wgns5yirgNx04KQZke4PILMgEUjeOFVRgy/6zkcNvI01H0Lw?=
 =?us-ascii?Q?dNqJQZknpCj+/4EGuVGETzsjkerN4sOpe9u7yrNcCDblex1AtTC6FsXxObKE?=
 =?us-ascii?Q?eKr+84Nxua8FKaqSXgNV9ZohMjI0uwD7D1oRiMAO2JB9Dk40qie0FYvC+BBw?=
 =?us-ascii?Q?Xd1JxyE+0GTwkN/Ls2jfN7X2XWuUxbH0fBXaHFybp66S5f1ATklVsn1TRjWg?=
 =?us-ascii?Q?v+gR5PU5a+H+UsYENzo6LWyVxHXDOx9O5SpHvx3GBpuLHDsUd5SBGi/mPcJQ?=
 =?us-ascii?Q?9mReFP5aK1Fe8+fwY/sRnRBnet7ZECrkp11S28+j2XCNqHKjmuOlfY+JDLBf?=
 =?us-ascii?Q?2N3bXQ9nRieBjk9xqafxatZfS4hTuRBJMTelVyJPSDt3XSMFBOUShiP/oVXb?=
 =?us-ascii?Q?9Q5Rmiug7cVtnLIlcDhv9KhAsPS1S4t7AFXV7SGQQzLXRl8uzb4REwqRGCQQ?=
 =?us-ascii?Q?2TMG2qMl16AnO81t11HlVDklqfS4nvuGV+lxfW43IzQCiVWNoRgxEcZ8qmDJ?=
 =?us-ascii?Q?M/I1EwUNDL5ie/MeH2fcf/tWG+jgT/Ru3BsrCztsWpcFKLp4x+9/Gstwthq/?=
 =?us-ascii?Q?MVMzlUNymvi+CEWugmp3km7LYr9l72QS1Oe6ieNgR7Vt2+bo6q5J/dv4PIeI?=
 =?us-ascii?Q?kjvOz+fG6AlQKJGhp0M0FxUDj3UbvQSRgXZvOUHrRKjPvtCELSPY/rPEdK9/?=
 =?us-ascii?Q?XXV7cewBgYrlr8vaHBaf+aoHK1YClYlm06bzh4Y2w7K6AloUVxdF1E3Skec2?=
 =?us-ascii?Q?WvHkTKI202JhrcY+Ift7HvU6hjMtZXqo9rex8DEifdd32C3KeG0ZHpKZQRQ0?=
 =?us-ascii?Q?g1EdcyhP+nsQIApbu0e6y7CtN/HLAu27y0wrnJ3X6JIGzgcObbhDSn8BJEbk?=
 =?us-ascii?Q?Y1setPpS8TSPc6qiMaVyS5w4hweHR1bVNF/ZWeWtqnNVmNqIJRc0gD+m0cO9?=
 =?us-ascii?Q?Hn7yD5iEYZCT1OynL80pbIa9Zl0rlhxKIT38fwscTPraEKMymWG3cauEEvSM?=
 =?us-ascii?Q?qaUr1XGo2tStLu7a8seN119CgRJxBfGOxELbkWtcFD9UvwaDEaDL98BERIM4?=
 =?us-ascii?Q?4mfP0AfFSeTFKbFwsXLXtEg8CRxt1YroYQ4UNy1sF1S//MbhwTsTFxoTjyok?=
 =?us-ascii?Q?8bSsoOS2eySStwVBuAXntXyQ+WlIgtyZLj4zTo3ahPU+uxoQk0Tu8SWBahWK?=
 =?us-ascii?Q?zNTAiqZPrEvr6m2sOrp4xC4Uj+UqbSn7XzKydPMGdBpZa9UnP98oRzKbZT8V?=
 =?us-ascii?Q?VoEoEullmlThcxm/b7wJit/vuVdv+3BtHW26w49LX33q/9vebO7TjppOocqI?=
 =?us-ascii?Q?K7JmHuyL57W0jf6wrwnj9hDVBcbjvKA1I2NTmAuMzNkW7Mwx+KLjrObgQOe6?=
 =?us-ascii?Q?hFjpqu5e9JHc+lkmqETsFCcPLJwv7dq2G6Kq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 04:13:20.8941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd61311-73e1-4e20-77b1-08ddbd0c9be7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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

Remove the config ZYNQMP_FIRMWARE and also update the initial
stack address.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_mini_ospi_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 54328e85784..55953d14200 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_LEN=0x20000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBFF8000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
@@ -57,6 +57,8 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+CONFIG_FIRMWARE=y
+# CONFIG_ZYNQMP_FIRMWARE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
-- 
2.34.1

