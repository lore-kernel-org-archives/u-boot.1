Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE5C369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673D583B49;
	Thu, 10 Apr 2025 11:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yyD/EgQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D017583B4A; Thu, 10 Apr 2025 11:25:44 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6396D83B32
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpaS35ZIZpwdKG16/8LcynLQWbB6P+cgMbgX+AvyZ2XNtO/Q6P+edgKUZnyWZKhUGMdhUj6QdFKt3fwwxX2N1ZoTMpK00tQyJmWa1OIrSEjjiYBG4p4+CdCrSzASbCebk7ssxGaHhjCt7qUZ4eR4bIrQj6a61mY/b2ToZ6Jrf/mpB/OeEaSzxoI2/IkiJpDfGNeeHd2Q6WyO1WAwhbWkT+lWjyqgs4Gec2+MYQEtnBnzJt2Enh6iLndi7+Y4JTFfZDzF2JyL7LWSTs2NLSX0s06ZqT6gCFNxcOwFETNehSMD/4Z/E1/hqE7bs1jbhDWXzeSikMPjiTcs/oZyy3xcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7rwvZMS3PVA9xCzAEhBwRlWBR4zyK6tT3fD66Lcs/o=;
 b=J6wWxZ99yEr1EVdrZoPHXuoCH08FeiOwQo02Ba9e/DVr4BLQElyRtraJVn/yYvnujzf4hzqScGd5b/osdS7Xh2EvSLHVI6NZAJQyRjyzJ6dSgYOUcoJdi8vUxwxSdHYSuLvlSPbd5lCyWCx7BNMZcZKkcLZIwOdBkXo6VYEKfx1k0Q9m3DgEqBj+ogp90/2BbqeG2vk5c8QuMiZfdI4y3s4/SwtaTyvdgIC6bmsYkaKwSZJQmeM/Rw0ati7hBhT3pyL7KhWQQYh9mKvKxbx5CcZj964dLvI2DcPqqdVn6ciIK84NOaes0SWR2mWpjKZvcq78tJ+R8AjCU3ONAt7w4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7rwvZMS3PVA9xCzAEhBwRlWBR4zyK6tT3fD66Lcs/o=;
 b=yyD/EgQZw3jmB9dFYNgsd8rXaQoEEGuXqpgr+AJ2mCtL8sbriXaAWRBCN2tqJn8NUNsHP6bHPjRrJnpImbnfHA3IvFjonsCzzj0TLcRyvqwv4zUbrJ0yiIo9RbA5xDzXqtyl8a3FiA+tmHdKOfRrmaAEIzZyC9hPun43mG5gZTo=
Received: from CH0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:610:11a::8)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 09:25:38 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::37) by CH0PR03CA0336.outlook.office365.com
 (2603:10b6:610:11a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Thu,
 10 Apr 2025 09:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 09:25:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 04:25:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 04:25:35 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 04:25:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: versal2: Update the number of DRAM banks to 36
Date: Thu, 10 Apr 2025 14:55:28 +0530
Message-ID: <20250410092528.3713904-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e588fa4-e362-47be-a132-08dd7811a7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kt1eZi/SAzxnf2P91upqkK9LMGIb3YMvzEreiNJ4I+ZZqkon8hw/K91h8JR4?=
 =?us-ascii?Q?1c+tqXg8vRxY1+myHecsUZKJNQspmc8w9GDUbiJLe2ZAaHOnbHAUkrYQ95YZ?=
 =?us-ascii?Q?t2zODMzwPPN7HQ3yHAiYmqjmN0oenDd5GeKTQWW1QoWh1S9K2V3JLAtN0jCM?=
 =?us-ascii?Q?/2RPtqsrxI1ZcWF2/jCcE2bYfxQbsIyAmDQs5qZyLo5ZdJqGWMMc+tO9+LCU?=
 =?us-ascii?Q?FOy+CCxwaHTraigLNQQ6XMgRuT3/Dzx7pYu+OQbziQP89eBixAUAG5LL58z2?=
 =?us-ascii?Q?SI+xzhLrN6zoxE2iTZARH/36E0uqpQyVmfoGaJY6FZhDtqCXLbhlI83oNmBm?=
 =?us-ascii?Q?t/3eI/+QDBM8VRsNKTWXnieXEWHqiMQ50M82WM2/u7rmkDJCO+Ndqf7b8cx1?=
 =?us-ascii?Q?+LIGvGL7dn+ixwjlFGPyx1Wf+IPJ+cxhREyYBlKMQViRpyjLq2N4UGIa97C9?=
 =?us-ascii?Q?6A0mEA/lXSYovaLV1uBM8Yjz+cRfrQUn33oqgReR+pZIBUs48TgFpKmFAr+n?=
 =?us-ascii?Q?En4RN8J2elGCrlESS1qjhVBIZZ1QrNoEsHEhV9owDjDgKm4gn68vJCuGRNj/?=
 =?us-ascii?Q?r7jU/DH984hHT22e7MS9i24XQ8zmj5n6F81XOGbtQtKweEvnFr1OMgNriZqM?=
 =?us-ascii?Q?7FJYroJ0/OuTydYQ0GeMPkQLaEgnPxcyXLxLLLGQcT0Fux3qbs5cIkA4DVDw?=
 =?us-ascii?Q?MN/QV68fWYt6lcFxAyGehcmR9/1ol+Yk41C8MqL+Sqj3dU38aVdbuA1cxehJ?=
 =?us-ascii?Q?eA+s23cozv+vEcV5YYyrfitZJLimJvqujti6Liid7ZSHsV+PWla6pjG8EVbZ?=
 =?us-ascii?Q?fjazZ235pEsrJKLwZwsC1UceVsbKQbu5cxpLX1QKxXsdcnucdaM3gIZt41fe?=
 =?us-ascii?Q?u+mnUzhAf6osGzDtQEveUTGVq59hgeWVfFTSE00O6ms7nSW8tEyLbK0iG8mA?=
 =?us-ascii?Q?Gs3m8LPy9wQhVV6UR0U1Y5iMWL6JFqXn+4nHHxuq9J7HEp3lVqe4Oki1N0Z6?=
 =?us-ascii?Q?QIDnUUZBy9CHxxNmJttqTV08rclILFH+zp1ze1ZJ5NE1la2oxN/6ItpyygFO?=
 =?us-ascii?Q?fOvdlDuhvwzXvvmE7aBl0ISomZLSctZ9HehWPqWtPi01XoNycbN4YuM59UOm?=
 =?us-ascii?Q?kNNqfteVOwtIBby3KSqG/YUBKmB0G5Vjr0Arlzf/tYMG9pSDvRPo09+9jGcu?=
 =?us-ascii?Q?EwobgEeNUVexL3IZCzgm5E1bUFv4wlSVxffragsMQcBOU1Wfo1WbBQyQ28mv?=
 =?us-ascii?Q?rIeUqkNg/gr7ABfbC+gS+aAmO27fognVl5VC84ik2rP9XyBpnJZKKNyTA2a8?=
 =?us-ascii?Q?vyA6grf4WzvZDr57bTS4nOXiPyEea66u9bUyRUM7LusnLDnUoJ8A/G+/upe0?=
 =?us-ascii?Q?jXAMYw9F8ee29lRPk7XWAvu4xdXy6YXtMha6LXZphLIEDSbnPaorYaOnO9An?=
 =?us-ascii?Q?4CN1+4//GnPhlzGTIVUlKT+9Fa/xw98AotQv+fSRKuwWBlNEonfj6bz4jkoB?=
 =?us-ascii?Q?WN4Dm9o6MR4s828=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:25:38.2777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e588fa4-e362-47be-a132-08dd7811a7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
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

HBM stands for high bandwidth memory and is a type of memory interface used
in 3D-stacked DRAM (dynamic random access memory) in some AMD GPUs (aka
graphics cards), as well as the server, high-performance computing (HPC)
and networking and client space. High Bandwidth Memory(HBM) has total 16
channels, one channel is divided into two pseudo channels which makes its
32 banks each with some amount of memory.
And then we have DDR_LOW PS low, DDR_HIGH0 PS high, DDR_HIGH1 PS very high
and pretty much there should be also place for PL DDR. So maximum number of
memory banks will be 36, updating the CONFIG_NR_DRAM_BANKS to 36.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 9911caa0e46..59a817a2a85 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL2=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
+CONFIG_NR_DRAM_BANKS=36
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.25.1

