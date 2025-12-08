Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3541D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 13:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AAD83B43;
	Mon,  8 Dec 2025 14:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5XMoZgYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FE683BD2; Mon,  8 Dec 2025 14:54:40 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE2C83B21
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 14:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy2GrtvTO3fV7Qc/S+S4Qme4yNhlHvp7znhv074osnC2hWKjj1mtHwTSeazX5bpk4fmNwzp9pHeG/xrACimrOrbKhIwOXpTqQOaQQ4xewqjkPrjVT2Yy5o17Of8oFlAgvpRCn2/9Mk3wgxZU9uauT7NkHNLpJryCZuQCchjd4kKOtuD/wgX+0XGsiQKwBOdNznbENs6S8IgLfW02lli73roXMM2o7pYijVXyYJXuPniBG1C3rBFGDCPeim16xIKMM8tWUWiAloSxhv9UPTkSgvxok0Eahit5eCaiAhat4UVrD0oxGHpkLl/TfqXbhA3eOoBHjcFKcQEjCDlsaoedLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLubj6FbASMt23jyagozxLuIt7ZQehHC32TpmlaPcH8=;
 b=COHS8jPZK3hg5Qv7zbkiACsMyWXHNDwdet/Xz32xrx01VdlxTlK2NKwccRUS4/Z0q9+EmYLleMtPDEeGausahv4Xw92qumTrn+BN5qKBywk4VtxGl0hTopkJbWWsyKZvAPlYf1flbvEa3CPzRWLaNhX8ebujbMcxO2OmS0QeBDks5SLW8wWia9+AmbXBMK3IwUF8Gq3JU7zZl421YDHSSq+ykS3W2uoRbFAmnwwChyk2XS617jvNAnZk2VxNqx7RgjzjxYT4RnsUkJqwMXZqEnvxQOmiJQ4UDqND1bhcjMr4yv0UKXs13pXDxPHpZwASHTVFbpHpjzsltwDUiWwwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLubj6FbASMt23jyagozxLuIt7ZQehHC32TpmlaPcH8=;
 b=5XMoZgYTnXBBdQJGQybXCHG+rjYCTDHPL3DsVLxe67WhuUVyeQAehj0qUPG0j0oQ+vEirtA5ZElZj/Qa8QZpQ5VlNTxkvm6Why0TO5tHmJHjnvecxued3Ol66TLJp2V8xSc3UCxDSreS4ItrZoPNRWU0CKx1/32Dq8wtHEQYK8g=
Received: from BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Mon, 8 Dec 2025 13:54:34 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::c2) by BL0PR05CA0004.outlook.office365.com
 (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 13:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 13:54:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 07:54:33 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Dec 2025 05:54:32 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pranav Tilak <pranav.vinaytilak@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal: Fix LTO for mini_ospi/mini_qspi
Date: Mon, 8 Dec 2025 14:54:24 +0100
Message-ID: <448e92ada514c3c043838404ad063b275b1619ad.1765202062.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=riMh7D4+oyeTFyX09DzDk9caYVGqH6CHgWpfebnrv7k=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSa3ZioqOAVdyfxAruY+tmyvhx+/5vBV65MenxDrVlzE
 Utu/qmojlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIrjwjw57YHfONz35e9/U0
 1+nTjyS2WzTeaz2pw1CwOiDnXZFg4DaG3ywz5x06fJ7r5+OMv8yn9noxix26bLXi3dFTXy9cisp
 vrmEEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 912880d7-89f4-47fb-2a73-08de36615188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a4b5XApWN8k/7RUYa29CGnnGSyf0t4mQQfWno0aihM4VKvTQXsdD6xoXWV3W?=
 =?us-ascii?Q?lxMn6uJFnG56XaXV/thwBT8RZkutp/EVaxCkO9lneeVQJ/6lKySVo2BLWwTS?=
 =?us-ascii?Q?5DVPi9bM6CrvSPuuKFnX/BGOiaRslYdgEabSF+medkWvmD/qt11waWCVDoPj?=
 =?us-ascii?Q?vKAa4QYqXwOnbxxDsJCHDEuNNxvJ0CQze48E61vhIrfrI1Yuky8W9UQ4kAak?=
 =?us-ascii?Q?/+Yach7Bsab+FK5n1fFghPeDC+NXK6J3zS8kH/Lby42gxBibxQSg5vfa++/X?=
 =?us-ascii?Q?nTZxAljo8uDJi0tTF7nrkbVsSPt12X6fapRX8gr0IXa9GacSfOY2s6LtMI20?=
 =?us-ascii?Q?C41dhiMI5Hs8TJ17RYhis7BwR/VZefKtNRVC2DgHemZAl1tpwFyc5GDpZyfU?=
 =?us-ascii?Q?/ms8DtGypOsj2IfijyghOYouYPEmA6vMbjAU7skEysSPAuMWo8lR+0I6W7c1?=
 =?us-ascii?Q?xi9OD/1lM8YWlX68HTGwrXdERZ0BoAvy6zT4W1767YEL7kVUPDVLtNoVbjZx?=
 =?us-ascii?Q?IAnV9n1mDB7PXfftP3RKZVyh8iJK9IyEH6hc9+9fHAv58Wm70wIRss4WTobN?=
 =?us-ascii?Q?AcX+Jfc9IZpGgy6l7fd6Svy3bAUdmGOF8/HuR8p3LEuHIPkHW3joXZHMnKfu?=
 =?us-ascii?Q?ZtCtkN8KWNk94B7v8ZtBidcQm5Q7HlUMz5pnSGcjGtmQc0OF+SAlG1vbqMTL?=
 =?us-ascii?Q?Mdi6LDXosNedYVMveiYuyEUExTV91TbuCXCpf/zXDvjoN3vC+dtCS4BlgY1g?=
 =?us-ascii?Q?TobscG4mN6dQFXl5670WiH8ZliNUOdc5HiOXXiOZREktTwjE8vLFKHybPJDp?=
 =?us-ascii?Q?UJ5O61PXTFiP5aB20e4yuDRm4MEwsEkJnUyHxUE8A9BVlWFuvm0G/jvhxrew?=
 =?us-ascii?Q?+nbzIrn0hKZ1wRGek5HELftqPpLUVJ5HDYsD9Ni02nS+smE4+J7nrZ8C7VgA?=
 =?us-ascii?Q?70xvUDfIDstDQSqmG/S1uBsVHADJ1PXLr2z21AL3lqYTEvSVA/O4ataJTZsS?=
 =?us-ascii?Q?QssTKTjpjkl2KDdAvZnUPRWinXCgt76ebbe7S0nniIP9nd8xTLctRPidr0jX?=
 =?us-ascii?Q?fMRz8GX/PLsXqj63zBroEJ3YiVhvexIbPAdOTxpj1O3LK1armiWqykf4YJRx?=
 =?us-ascii?Q?PXiJ85afEWjB/KdbYp6zfU26kfxXMyBKYikSqPEyq4brANhI4B2Xugq1JXiP?=
 =?us-ascii?Q?7StfebK8BVkQ0DwxxmtbH3kI8B3UcIkClYsWd7FtF0G1VjDABL7UQSsxcRm6?=
 =?us-ascii?Q?gv5Mi9D9ex+4PMIeMshjtVzj56dKaYq6F3YDp4GLFWMjsgE+Ox8KYtW2Ikfa?=
 =?us-ascii?Q?6tJVpyJX9MF2x755ugP28uV6p5nurRGXBNZSplHwyna6Y3lXaxLMR4hrS7C6?=
 =?us-ascii?Q?VsiJnMrrI1s5MiGYvCqXn5SYko57IYHSfgDhwT0gcHSjOtf9KlyqqBiLnTqr?=
 =?us-ascii?Q?NK0ngrPJH+It4luPCREO/5hw94rqweZOgjuz9x9LpJvGI/YRec/ADS+1j2U1?=
 =?us-ascii?Q?TXeZtboK4My3faaIY66xfCW9TXdSASA9wvF6N/MIGT4msTZA/ziV119eJdbP?=
 =?us-ascii?Q?3EUSe/kFUmtY2iesaUs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 13:54:34.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912880d7-89f4-47fb-2a73-08de36615188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
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

From: Pranav Tilak <pranav.vinaytilak@amd.com>

With LTO enabled, mini U-Boot was hanging during reloc_fdt().
The initial stack pointer was placed too low, and the FDT memcpy
destination was carved only 4KB above it. This left insufficient
margin, causing the FDT copy to overwrite the live early stack
and corrupt execution before relocation.

To fix this, increase the malloc heap from 8KB to 12KB and raise the
initial stack pointer by 4KB. Together these adjustments increase
the separation between the early stack and the FDT region during
the pre-relocation phase, eliminating the overlap and fixing the
hang on mini builds (QSPI/OSPI).

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_mini_ospi_defconfig | 4 ++--
 configs/xilinx_versal_mini_qspi_defconfig | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 11811f3c0fdb..eb101d03973e 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -3,11 +3,11 @@ CONFIG_SYS_CONFIG_NAME="xilinx_versal_mini"
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0xFFFC0000
-CONFIG_SYS_MALLOC_LEN=0x2000
+CONFIG_SYS_MALLOC_LEN=0x3000
 CONFIG_SYS_MALLOC_F_LEN=0x500
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE1000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE2000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 47737ce0f8fd..20fab6931c36 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -3,10 +3,10 @@ CONFIG_SYS_CONFIG_NAME="xilinx_versal_mini"
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0xFFFC0000
-CONFIG_SYS_MALLOC_LEN=0x2000
+CONFIG_SYS_MALLOC_LEN=0x3000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE0000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE2000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-qspi-single"
-- 
2.43.0

base-commit: a1f26a9392128309a1affed28b14809845714c21
branch: debian-sent3
