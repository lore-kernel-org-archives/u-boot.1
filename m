Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315BAD116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 07:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686F583F4C;
	Wed,  3 Dec 2025 08:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYlSg/5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F8E83F4E; Wed,  3 Dec 2025 08:20:56 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF8B83F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 08:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qma3v9UPflufBKcEvolMawzsIgsuo2RcxXNhw94VQuB+2BhRxfn76lKSgfb7Z6pCyXpEm7oCgPOLTpUW4bhMvy+qAFNikmSgQJXGpDaJaYXPVxqXMWWkkhlRDF9X5r90S4xCCt3zW6wth2wqnptBfFBlrqzfWhazqrn1Geq5Bmz3oL2a1GtpSCvjSWLhe8djnGss1NM5rNIZNzY6bgGkwjtn0JPccDXzX9/k5mFH6I/v3FdH43O0a7tPi2YKEZd3OiL7uEB15uY/Ji8OqmodpEwnNQsQK6eWFnZAlREzWr1m2dN1WsQQw78hxCX8hrT0lnJlC9NXUlsBbeDnDFW0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtoGyrDtmmW6N6dDy3wp3lo3WuoyxZML9Fm5k5OU8aM=;
 b=CJltO8KmoXhD+kEvQ1g8xlOht6Ljmun4ROwrP+uh/Z/98zqget5Yj0DwvRuVtKvVokWnBDHssyVwFNMqNDGbK4281TZLOWch+gztoOECZKHhpsrVu8Uhli6rJd+MduhKyPcAT3bNi/tEg3CBziQUP+ocSihqtdxWoxEsCwDL/ozxxuRt/jNXqHqp+HZjdO+KhVVvGpFHYVp+zhvHurK2QEhJFy+LF/aM7WavrJ8BctLajJzZ0W8M9aL8z8AThfozNLKINMXUlxqI7f/8FvE44c2H/AAJn79NwSIB9cxgcyH7ORI/8fHTUxyabSxwXevDqey+x2XVt7ufPszsEwvqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtoGyrDtmmW6N6dDy3wp3lo3WuoyxZML9Fm5k5OU8aM=;
 b=XYlSg/5QbayTwFuUFYOMo+K5ybEbbRZ3MFMoDVLysc1R+I0aUYALUTTkcj+45RGBExI4KtHZsCBTLUUJRJ5+vV6OpP5CFkFbTe3/SvlvNSv5KC93ud1XEjqo6vasfpci9Uls/kK0mYTgoN1dXvLrzVK4+hsWwIllElkMQzp8xJI=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 07:20:49 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::b4) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 07:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 07:20:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 01:20:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 23:20:37 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 23:20:36 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv32: Disable floating point
Date: Wed, 3 Dec 2025 08:20:32 +0100
Message-ID: <2c043ed05643fee200a79eb08bfd5c0041663bd2.1764746430.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ashBrKOkj5GokA01mfLiRROR8M+BGBCN2/vx02XxOiI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTqPzn0nCWp5/bVBadmXGjve2zg29nGzBC66/czc8HfC
 3+fUzud2lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATceVhZJi4r/h6m/nkxv0z
 Wf7JBnJ8luCZHmCqkGfIzt3L8PvBgm6G/9G/352xM3S8X2MWz2K278vh9yeULFueGyQ+Td52icX
 iLAcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d70e9d7-5bb8-4e9e-e57c-08de323c7bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r1TGT0L01aL+K5+uP3n/3XnqqRovPCC1hQEhyYjvQiIM8DMObWFbdIhKoXDl?=
 =?us-ascii?Q?yN4YTq+ia/fgoCeFUv58hvkOpbvIrUvct5iAKyM/2PCe8rcZ6+B1wuw7Tmsa?=
 =?us-ascii?Q?lNh8g3414AO3Vg7byWMRY11/y2THH4bHGC+lHxcT7qjmeaFlXiKO9V/2UJKs?=
 =?us-ascii?Q?WXCkiHQPXi+8S+BMJiP7LouojS9k4tEyKqVo7p7ALZO7k23N6vpZ1tSAB/ir?=
 =?us-ascii?Q?sY5Z9X80fptPPZo2bD81tnSUNdhPPTAzZeb5bmGvC/7MJ1FG1DqnJ3pPjhf6?=
 =?us-ascii?Q?zpLkKgP31EB62aRLH47MGw+Uv0gWC+qn9txgm2lqD67J2V6E/IIMRqKKKPyf?=
 =?us-ascii?Q?L5lF9INOS9WnlEXtSKpLeRtHU0OecDEyQn043QAHr5BtJjLSlpJRVD1vaBk/?=
 =?us-ascii?Q?+jWLi15HAbScs35/orlHvTHvM21W1FQKQMQGLlkbr62g07xxeBPyxLO3coBg?=
 =?us-ascii?Q?T17lNV1Z2je0z0l53cqaCfca6sZ9eWiPtvrDa4pGhQ+Vvli4okO5nacOywKy?=
 =?us-ascii?Q?ghKkTH54gzQbdCR8Qwl2ByFsN7Ngs7yborUGCbt+LwzccOK53rCcfBkAnJeU?=
 =?us-ascii?Q?dPo9HWn8An/Kq8SrN/GofNt/ENJJ3eX+zdlETB5seQmotdHpn0vsZxHm10C0?=
 =?us-ascii?Q?HWwSZeJX55E/e9yy2i2ayDqPYkYIbkYRVXpCZddvwU229jEz1clFVjHfZ9N4?=
 =?us-ascii?Q?rvwT/tmcLmzBxmqs4+DkzB4QwtM0AF7P3BbTlgnKOX8GzKvj6/NKRnnJJ9jo?=
 =?us-ascii?Q?zRilnPMHtwbZ+8IbQoClksa+L0Fu6wQ/L6sqJlYhEQQu/R9q2l0peT9Mzrn1?=
 =?us-ascii?Q?unsXE9ClWZt9TdPDmdoHzm+uwb8ZCq+xJ9taFMh5F0JuIxeneiaodRNAlE8r?=
 =?us-ascii?Q?L82A8IHPZ5+TWFcQ3vFvsPXxNDBG/FB6WYqO/wzFmsx338ElpupVShg5lnF5?=
 =?us-ascii?Q?ztdouDHZJuphyORxRytX+xLWgacc59PIsvEEVyHU6EEmfQHWcxW20zixUL54?=
 =?us-ascii?Q?8aGi/AgPxPgT6KyP0rOnT6DyDb80j7eySUVjaBbUVk5l3KNmtpu8k7jTAngK?=
 =?us-ascii?Q?tB2wE7gwoqxpleOWgr75KP8Gsz4f5vGM9Wr2dsEqOvF3MU4oHDVT16+QWJn1?=
 =?us-ascii?Q?D0WaLyuwXAsudnaugQK90kLKE0pQFRbhQEhyVRVrEZ5a21A7ZV3/20aPokS4?=
 =?us-ascii?Q?2HmIm4XzQzYO7JUng/A/OMs8Y8Kjk1D/HRzvL7Of5DzJyUfG3neu+arPkzVi?=
 =?us-ascii?Q?43uhSklbQkYUZnk2+kWyTSmpXzjt0Y9Uhhx3TzvIc525dkT4sXLw+cUVI338?=
 =?us-ascii?Q?NCHSbMulSdxq3lCbvJTMimZ6a7xEsA89/2wda82nta8NMokQbxuGMyE6OAga?=
 =?us-ascii?Q?KgjXLDU+1lOZsK4Gu0q2KzPWEiB8GHOLjsqempexKEdNkrL9zoKs9Ybjp7Oh?=
 =?us-ascii?Q?gU5NOfgDHSaINu7uqEam1z64yiQvkrCO3wb3Hn2wHbZCck37/t3NEnZryfZJ?=
 =?us-ascii?Q?A7PTXsmbfTJhf8bHmHX0/nXDGsovCCslLzcJmTKhysRwH8lPSfz8v3QhJC91?=
 =?us-ascii?Q?/d1CuzodlgnLquvbiBU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 07:20:49.0669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d70e9d7-5bb8-4e9e-e57c-08de323c7bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111
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

MB-V 32 has optional single precision FPU (64bit has single and double
precision FPU) but there is no use and reason to enable FPU by default
that's why disable it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 88d9e5ce6b2b..81c0f8e9e936 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_CLK_FREQ=100000000
 CONFIG_BOOT_SCRIPT_OFFSET=0x0
 CONFIG_DEBUG_UART=y
 CONFIG_TARGET_XILINX_MBV=y
+# CONFIG_RISCV_ISA_F is not set
 # CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
-- 
2.43.0

base-commit: a0f0154ef89929517c3217efe025e8021a910b90
branch: debian-sent3
