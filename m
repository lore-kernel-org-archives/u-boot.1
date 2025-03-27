Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4035AC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A67181B4B;
	Thu, 27 Mar 2025 11:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVBye66g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7E881951; Thu, 27 Mar 2025 11:52:42 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C784C8070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECqrV2sA4/2oAFfPeRPV/s5HSWvTD/Tz3hz+j6KBaaQrhDMymXeDRmy4h8lN4t+a94yW6/oN488yA1kHz3ks7wN/8TiRXIvDmT9wsOhP9odj9KFXc93O/LN75y3ykbKkoATWN77AFOwyy67vvwUcI8XwdPhQT+MqySLOrsijS8geTlnkM+CKeR6ef7lut7UBw+LlEL+wHKZjciLV9uNM8pbDKmX1GC50UFIHhj59PaSL0vJJuAVfTQ9x6JW0Zx3LidLTm/XkC3itlPEiM42px/sXyayuSY/D8/FkCzMe5k/9BorG1/xXHO0oz9Ekd2wLX9pJl2vRoCrZRpbsv7v2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHsGXmic8cqwTgRBIOZQmmSqVTwxT7dqgVT/LAH193A=;
 b=Yp8s5LdrGLkvn25PBWYrIwkT+K6Eo/XepGD2moNLnXX2w4IQG86tG7Z/3Icu/ICq6XOlMCKWyZgwz9Zl8hfJBesR178BEFK84oA1nH+ePmrdIJM4o2Y74lBRPyzsVPdhE58EYCM8YT+VXopXwhDMUY6tD8k0mko0FCYJuZZBmkDzER5u9iFWnIO2RLIwRmPM3fSND5WkHcFL505pjKeJdkWpO06MLVctj70wZ+QCUU1bOaOGC8aKl52I0u3z+klhAhvHOsjWuIAM6YLGrl4YTm3a5bEKbsA2ISCai58tqOkhTXLXucIea/yu2NfK4/GQU3yY1cAQrkGOKLA5p3Edvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHsGXmic8cqwTgRBIOZQmmSqVTwxT7dqgVT/LAH193A=;
 b=UVBye66gri6zX14HO1FsP8xdg8wrt7Yd4tcJUxqZqO+dTeMuouDFZwzt2ynAaLnMLFTKCfB7xM9zTwniz0SN9uwlo0fEcJ6quHqvJnEDqhHA/H0XgJ4Yr54DdwCFqppSvouw5radLBIA5Te4RIh59eR+OZLec32fAvUXJK8oDZU=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 10:52:34 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::13) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 10:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 10:52:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:32 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Mar 2025 05:52:29 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 0/3] loadpdi related code changes.
Date: Thu, 27 Mar 2025 16:21:57 +0530
Message-ID: <20250327105200.1262615-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: efaa5d58-7249-4c1a-a463-08dd6d1d7ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1YWg0oCoUDjUE5TQjvxUGJhm4oDJKdW0UzmX87JMLA9LgT2otSj1wcN0YpG?=
 =?us-ascii?Q?TXjg4ooteMPp+TsK+zX1DSgycUVAU8yrWDKjcIBCxzlkuH9XtbsNxHcrRQ2n?=
 =?us-ascii?Q?zrsZhkz9uXMnyf2OIkebfgY0JdEJXEnvl6CXwUYsBuMNbK9Fh3R0e8rqfmpF?=
 =?us-ascii?Q?AVjT+iT64yPrfg5MjBW0oYq6iU9ZpjAuEiC13xAEJC+lnHNyX97iqZNxnM0e?=
 =?us-ascii?Q?TLOxbbbIpgrxcsTgHmf2bZ1H57IDycaC/QRwb+BZaA6FodNeG19R4EaroKL2?=
 =?us-ascii?Q?0JoT0EiPwsev8O3kNy6X8RjFiGKo57g3EmUejBT5hQlpV4oiJIna9/XAnEsn?=
 =?us-ascii?Q?WxiMkZ39G6rEc6eYwMrI9cPqWGmdfgxcKMcsJHtBNFU9POecrX/dHhVm4YEg?=
 =?us-ascii?Q?S/R394ZgtrnHK3qdfMFqaApZcCNoXPrift2auCMlH8fYCKnPLrfgyuyDSWdi?=
 =?us-ascii?Q?ozMjDmaxGmDnuobNpmxyPPCLrHN2BQgkFoy8zvGCE3hxUdxhV2S0b6L5JCEW?=
 =?us-ascii?Q?jJXYzPZSSeTxgVJdDX0Xo8lifkxYxJu8pND//1mAiHh6xqpbJS3fp3Rv56IV?=
 =?us-ascii?Q?8z7HwX7SPjkcdGRn5CF/3cc6hRGvU1mxKd8u5PN2NUdAw7QzP+0p8FRD991k?=
 =?us-ascii?Q?Rl7PZHfRlbYqLoJpYBZgxENUcUBhbrOEdvrKfWZS4plbV/qgORNUaEcwL+xV?=
 =?us-ascii?Q?Lg4KbZ0YI4uxMqo37ezEFeBhT41M9mzgEKwYMT1LMNuqxcX0D1IjZFr/gzTB?=
 =?us-ascii?Q?vMyQwwqVHleuEZ2dFiqSWI+zhrkpNY2Sv5r0xNmGIH1mrLhqk6UcyrJv3+Xd?=
 =?us-ascii?Q?Ls69AjaT4BCOUNGy0dbTvYGobc6gN3Iu2UJTQFuBkvxPSKAKGV8Ohwsl2Dj0?=
 =?us-ascii?Q?7y3+Q9AuGQiuJv2IiQbVg5W3YHtYFBWEo8/iJC1jF0tI5U8xlvFWOPFU+4bB?=
 =?us-ascii?Q?Ed50/zbGlEKDdbLg0CkI3r7vKLs7yfQhnufA4zpnQi1qIFSbaB4UUEPq1W3O?=
 =?us-ascii?Q?4ATiOIuU0ZEjJGLppvZDeChIcoYMe5EyWy1lNSEOxoFbPY3jKM0TgeHjRKQb?=
 =?us-ascii?Q?Z9/KLv3T/dsmCDZ5MlZA+v5q4s1sawgiikU1JdSOFnHGdyqGWxM+b3ZGy0cc?=
 =?us-ascii?Q?Yu1FY/i7glYIwlYn2PJQBgLEoNQMhbyx8Arc9yKAEGhRM4swDazUgJFJpGy2?=
 =?us-ascii?Q?jPMEsVOrsu6TZQAXgBj2kaN7s5dCQBqxJkRb9bI8nffNHBLzLgAvJ7U7IlyO?=
 =?us-ascii?Q?iZ9Jdqphno8zdh4GiX0R+5mHarLN46DeMxeek8ANPA1qLn7Pj9Qa2S3NrZZL?=
 =?us-ascii?Q?qlm2ItQH2dNC93kpjCRVjpbjk0CxizidxUIlmdbIUYscpFkr27zRRFpt95OD?=
 =?us-ascii?Q?f5ZlV+ABtAb8rOddsk0gGhViu+nQqTRBjV105/g3x6eVpc4Hgu2Jki3GHISM?=
 =?us-ascii?Q?EFhxzyZ9H/hjymBe4lAnzPsgc3mrbrwQgFmI0QXTNABTG2LLvBIXuQvuErpB?=
 =?us-ascii?Q?CBclkdMZV1zGN5U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 10:52:33.7171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efaa5d58-7249-4c1a-a463-08dd6d1d7ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

Prasad Kummari (3):
  arm64: versal-net: Add PL bit stream load support
  arm64: versal2: Add PL bit stream load support
  xilinx: versal: remove versal loadpdi command

 arch/arm/mach-versal-net/Kconfig         |   1 -
 arch/arm/mach-versal/Kconfig             |   1 -
 arch/arm/mach-versal2/Kconfig            |   1 -
 board/amd/versal2/Kconfig                |  16 ----
 board/amd/versal2/Makefile               |   1 -
 board/amd/versal2/board.c                |  13 +++
 board/amd/versal2/cmds.c                 |  80 ------------------
 board/xilinx/versal-net/Kconfig          |  17 ----
 board/xilinx/versal-net/Makefile         |   1 -
 board/xilinx/versal-net/board.c          |  12 +++
 board/xilinx/versal-net/cmds.c           |  80 ------------------
 board/xilinx/versal/Kconfig              |  14 ----
 board/xilinx/versal/Makefile             |   1 -
 board/xilinx/versal/cmds.c               | 101 -----------------------
 configs/amd_versal2_virt_defconfig       |   2 +
 configs/xilinx_versal_net_virt_defconfig |   2 +
 drivers/fpga/versalpl.c                  |  11 ++-
 include/xilinx.h                         |   2 +
 18 files changed, 40 insertions(+), 316 deletions(-)
 delete mode 100644 board/amd/versal2/Kconfig
 delete mode 100644 board/amd/versal2/cmds.c
 delete mode 100644 board/xilinx/versal-net/Kconfig
 delete mode 100644 board/xilinx/versal-net/cmds.c
 delete mode 100644 board/xilinx/versal/Kconfig
 delete mode 100644 board/xilinx/versal/cmds.c

-- 
2.25.1

