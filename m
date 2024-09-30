Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79140CF649C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 04:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C90B88D08;
	Mon, 30 Sep 2024 06:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5YilcP3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3CE88CBB; Mon, 30 Sep 2024 06:39:26 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF7E88D66
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hubcDBaywiw2TeNHwz6dEUgt0RheEr8B0OChY6rK85B3B4kCQ56k7veEEK9EMqp1pDUY7leEWYN0o006FKtUUYZdWaYd6vuUZx4z5Kfo26iC8rSQLtQTBjZ1RvzxTYhakFi9jwx25CmXwVc1H5vR3FHwwh22R4dImgq33znYT9SjA4rKl/dzPgZxc5rFbCEob9kgSbwct+FuX+itEUnj4Bdv8P4nHOVJhguG0KsmzaeOra/xodVqNq2S7P9Tx9r4/glXbZNIbugcxjvUA9z4/17dlGdIyUOY5eyjhK1ClOJSIPzCuLfz9M3zBU21r9qRysNzvqJJwGD1KAsj/l5PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B/P0Hfb+8J2p8Qrd12bDTmpZPrrdDBAfW4bQeKSp1I=;
 b=sfxq1dvlGve4DMFeFcrTSf1Htf1Vnss1OVSt4BvODF8F9G0u5Wq6scq05FbabrSEg3XHjjHb7dW0PCa7U5SBy3jbBrwL7iInWvEzwCGltNkaQqtptpkI4xkwMaBT7IUhFWE8gmvzYq6U4tfaB/2SCmTo0FEl74vN7R01sLviRhZxwkGvmwTVpkT0r1KAwTJt50nD9N+BIiz6+sP9l1zAMyimQ/Ahk9iyap7T/KRwH8UTl6f48sIfMzWsAkVzt6aSeLS2oI3bn8OCRqY0X8+gYYfiVWYQ37ZT4j5ysqFwivicsyTOz0Wv6G+YNWgNqbuAb07Yc3IeLd3OcSywU9Soyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B/P0Hfb+8J2p8Qrd12bDTmpZPrrdDBAfW4bQeKSp1I=;
 b=5YilcP3FmoTYOT6HaeL1nCVhAsJ/ZCxFT2K9wQNOP76nyXn8iCe10OuBN+RyGhityYIIjnWQctW8jWRlTvHKg8c3yTTy/5VVcDWfyMPlZ+yVGRxq/gxSXcRlyCeklXP4m1iVXTZuhOHCgfss/HYyAidAKai9B91651OWa32UW8c=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:39:19 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::47) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 04:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 04:39:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Sep
 2024 23:38:47 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 29 Sep 2024 23:38:45 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH v2 1/2] arm64: zynqmp: Print an error for split to lock mode
 switch
Date: Mon, 30 Sep 2024 10:08:13 +0530
Message-ID: <20240930043814.530181-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930043814.530181-1-padmarao.begari@amd.com>
References: <20240930043814.530181-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1909f511-0936-4612-1319-08dce109d8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3W5mvB81GWrRUSAHxqOgxmTkJ5R8kqkVqjuFcq3eWqDm5rvF3/xQTkV0UvG?=
 =?us-ascii?Q?i3tWTQDVMsRgyAYFZSPTVYbexnaSHNFE6Kh4EkHDAdQxC7/2L/oXpzOVKb7B?=
 =?us-ascii?Q?0SLZeaIjmw2PsELpkbA/vKnqSzm52qHIbA/HVqJlrLwolh8eNLQwH4xeINO4?=
 =?us-ascii?Q?STeeA69VLXL0XCYbrH9nE+m0vMCzaXdGtUJigBUfgEa0fpSSYWpYxQgqnLO8?=
 =?us-ascii?Q?0Qgax5GpQWp4RI4HJ5gtIRkQUKJZbIbvc9W7NR1YH7BPZRDEDb4Ph1K7Ju9s?=
 =?us-ascii?Q?jm+5SNZGjh9dJZTg3upbHxH8W3KCJ6OQeB3Oepe0xT6xsWyatFwJ1u1iIqm4?=
 =?us-ascii?Q?jz5wLwCw9KYbofj7dA1Vs3Pz9EQogEpC8ofFT2ztD1HqbLK02jHvtqHwxlSb?=
 =?us-ascii?Q?taOPrlBlrdygIB79jwuYaKkXzQEnpEAbIS6bZxZDpcDzx/UbytA1rfkXRd2M?=
 =?us-ascii?Q?xbYRR/mwCiyNXZRxSfXhH/K29hy9eZM4XID9LQCJNXYQ2dpX1e+vKvMJjXLj?=
 =?us-ascii?Q?bt5Wm2sp2owL31sRMiCTZ+oMWb3C/yMUIJujIiqxGAIWVNKBjltKHwzaaLzu?=
 =?us-ascii?Q?HDduOzixjtk/Iz0+VYUHHrwLyQv3ur0JsY1+2tdjTit+pgAFZcc4uZicN+05?=
 =?us-ascii?Q?y+OQf87ObSOEw8s02TCK55PpB1uzVsbC1h4uzqePUqkewUH2gXYEsPjc+vqL?=
 =?us-ascii?Q?XSNmXvCqNaXX9RdFAtsjlBg0Kbce86Kf7abYcuSe/rmK8CzkA+xgFV4+rO0e?=
 =?us-ascii?Q?sVDA2TMVIsPrhGzJ9mt1R3TgeCqJnzJdvzv2h8sYBFsAgMzotgLg0Jxodvda?=
 =?us-ascii?Q?iYvZjb357Lc3TBDnZAFbThUGYvYnGk9iY/f/JfYE2LBMLKrUuwq7IU3aMd9k?=
 =?us-ascii?Q?qwRDDygrLMveGllTSQHKpqe3f2AdE+unOIc2WAfApXB5VbE46l85WLA1ZGPc?=
 =?us-ascii?Q?bh1ewM+uKN5iaZErUCGrH5IPpfuwPAJF/p0tKXffHZKt0jjRMV65skwfhiLG?=
 =?us-ascii?Q?gWkQdkdjFtTcZiDif7oiCBc3dnm2H0rS3yXjdjqALny+SNobmxVhQ9TtqvUr?=
 =?us-ascii?Q?hNYvtQf8jF8NzIrOnTHZvQwT2iNAo3/ziXRHJ4N7NufSEvA5mSThwxO+Dm76?=
 =?us-ascii?Q?U26yvMHDhJ/KEhM7Pd+rWRmxWq7DKmtHij6CVcyw9dqhkrAq/DxnYFL6Ymc+?=
 =?us-ascii?Q?CXAW9UDHWJagewCWvaGEfqR8XK76BQqo8uyuwYNLobi6Feb1MHUWacmv7sLx?=
 =?us-ascii?Q?gEhiDG5dFCDePYOp4zWsfvnft7lopPpWxo5FNoeWamJVcZ3QH8e1xGX2oMDx?=
 =?us-ascii?Q?t4yazdhAcggKbIAhO785jhINYRheJ6cFk4+h+UpN7YlFzbHxKiIy5qWGxKCj?=
 =?us-ascii?Q?3cq7XoY06b9v/GSW33HKL6ypCyqY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:39:18.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1909f511-0936-4612-1319-08dce109d8e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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

The zynqmp tcminit crashes the U-Boot when switching from
r5-mode "split" to "lockstep" instead it should throw an error.
When cpu is enabled, the check_tcm_mode() function checks
if the previous mode is "split", switch mode is "lockstep" then
it returns the error code and the initialize_tcm() function is not
updating the global control register of the RPU instead it prints
the error message. When cpu is disabled, the check_tcm_mode()
function returns the success code for switch split to lockstep mode.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/cpu.c                    | 16 ++++++++++---
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  1 +
 arch/arm/mach-zynqmp/mp.c                     | 24 +++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 07668c9468..b24c163147 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -115,9 +115,19 @@ u64 get_page_table_size(void)
 #if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
 void tcm_init(u8 mode)
 {
-	puts("WARNING: Initializing TCM overwrites TCM content\n");
-	initialize_tcm(mode);
-	memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
+	int ret;
+
+	ret = check_tcm_mode(mode);
+	if (!ret) {
+		puts("WARNING: Initializing TCM overwrites TCM content\n");
+		initialize_tcm(mode);
+		memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
+	}
+
+	if (ret == -EACCES)
+		printf("ERROR: Split to lockstep mode required reset/disable cpu\n");
+
+	/* Ignore if ret is -EAGAIN, trying to initialize same mode again */
 }
 #endif
 
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index 15b69e7771..b3396db28f 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -48,6 +48,7 @@ enum {
 
 unsigned int zynqmp_get_silicon_version(void);
 
+int check_tcm_mode(bool mode);
 void initialize_tcm(bool mode);
 void mem_map_fill(void);
 #if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index 9b46a25a1c..6e6da8008f 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -12,7 +12,9 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 #define LOCK		0
@@ -264,6 +266,28 @@ void initialize_tcm(bool mode)
 	}
 }
 
+int check_tcm_mode(bool mode)
+{
+	u32 tmp, cpu_state;
+	bool mode_prev;
+
+	tmp = readl(&rpu_base->rpu_glbl_ctrl);
+	mode_prev = FIELD_GET(ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK, tmp);
+
+	tmp = readl(&crlapb_base->rst_lpd_top);
+	cpu_state = FIELD_GET(ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK |
+			      ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK, tmp);
+	cpu_state = cpu_state ? false : true;
+
+	if ((mode_prev == SPLIT && mode == LOCK) && cpu_state)
+		return -EACCES;
+
+	if (mode_prev == mode)
+		return -EAGAIN;
+
+	return 0;
+}
+
 static void mark_r5_used(u32 nr, u8 mode)
 {
 	u32 mask = 0;
-- 
2.25.1

