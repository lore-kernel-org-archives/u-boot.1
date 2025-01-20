Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9412C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE5F801CF;
	Mon, 20 Jan 2025 14:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mqqQFI8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D55805C5; Mon, 20 Jan 2025 14:34:07 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8EF480077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAw702LV7LN44hDPgXRGTq8Yz2WRbn81Nv+6PTh4c8SetzEE1J3eskAl2ZUVn42oddk9H3SesSObkmMg1oJtNrOkcIbOjYacVQrbshZ7ByV8aRxYvMwpwUq382w+TMS+izdMwwIwQ23a8qDoKO+05AH650dy0r53Mcl0dWybPDMgRQanMTRXcyUroNU/USVjfVjDU0w6Xfw2cf+lTcCOQGnHdqduLPSVuqxBLn/ShKjDLdW8OQ4JRWcg/QGdbn/xSHKV9ICPpooYe88rNY0VWJpYJnQ+kO/xG8WVf0dMcQ9Pmunt6EUVAA8KTc6oSYO1WN0CzFUs1cc3rG702gfgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDAXemAU9o4ANXqLLYEc+hIVOTI4vS+WlulZ1T9UR5A=;
 b=jXcONAgGEHKbCsjzuOai+uwUpS8dyuUO2swyhq6gRHkw3bqHE1dEmahC95tblBhnd8b+tZBIApX8eeIg9DduyHzQYf5TXXf09faAba79g30CjuW2NdyEX1r6vJfCrSmtYKmCKNi7Gy4k740nAD8qFcMGN6sxMkdlwjQdfAxs/CCoouoT4XcMG/qorvTVdNO6GCYIbvNJAr9hejr3S+ODxOTwncOCelxVozlHErTdCzhSd8Ve5QzZsNwRb4Z9MrURacTE0SRW+xKoV7adhoOLoV1p0Heo6GrdftdKhJgZYgZVMvxC5a6C12by+2ClWdREiKaXQTINRIOIs5epSPPvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDAXemAU9o4ANXqLLYEc+hIVOTI4vS+WlulZ1T9UR5A=;
 b=mqqQFI8KOaLmiHRitZGhxnVjp6nCSzHpCwTM8rjXOOjh8fOojyEIJZs5Pgykifqty0zzMBxOVob81SzQNOjYe6tyS/nqBCr+19s4jmIFm317vfYgGALTbELPyVYqoMT1qIy/Zqq4IuDyfB/ispHI5EH2cPKSfUmdUWJiB4D4XP8=
Received: from SN7PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:f2::7)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Mon, 20 Jan
 2025 13:33:59 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::a2) by SN7PR04CA0002.outlook.office365.com
 (2603:10b6:806:f2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 13:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 13:33:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 07:33:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Charlie Johnston <charlie.johnston@loftorbital.com>, Kristian Amlie
 <kristian.amlie@northern.tech>, Masami Hiramatsu
 <masami.hiramatsu@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Tom Rini <trini@konsulko.com>, Tony Dinh
 <mibodhi@gmail.com>
Subject: [PATCH] xilinx: Remove SYS_MALLOC_F_LEN setup via board Kconfig
Date: Mon, 20 Jan 2025 14:33:47 +0100
Message-ID: <c3edd75b7a19d5cc205c9d5c37c2d86189ca3de6.1737380025.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Onk0kr6RcvkTVbq9lVpeU2FmMtWDpPeUueBKvaJADBE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvS+gN18815b3d9j5eWzXTg799p8x4U30vdYbNrVq/Zo4
 5m/nxISOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEygsY5spMkQ6Tm17y87XT
 o0/q5fzHD34Q/ciwYN60nIWWYn2G3kVrDquq1U6qz0t/CgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db345fa-2bf4-4fee-8e7b-08dd39571840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UgEB31HBNp0uUJ8usgM6LRgh38KTKWteGm/HbaT01/IPLr7Tq5CHC1j6Gzcc?=
 =?us-ascii?Q?xi03tx0mMiBdBGx8YbTN/nU0CaALeao49C5HMc6JDAaUYt5hhjxCWRXtqxSh?=
 =?us-ascii?Q?flHENcmE5aPBEe/WXTuWXWFlGnZtgmZ2RPJhaph56zmFPuq0FsLGGz6mVQIh?=
 =?us-ascii?Q?pLaLOPBIBVNDzh/A6OBaDiR8A1RFs4QCW+AbGXYJOG3PBc/fsOf23THzWgqJ?=
 =?us-ascii?Q?6lTEBd1QLhME6FwDA9xZ7HblgA+LhHxcy+WFi9LtD62nYPpJTqF/NxwnaajR?=
 =?us-ascii?Q?nwv0c4h9qQcb02i3tMY+Z6HmU3T21bQ45CFDe2h4WA/x2ATAOko0nM7f4rMF?=
 =?us-ascii?Q?M4TJ0qgE244BThzOGyv0T9OqiqOg3wF4n5wDY2sLq/QRCQ72j2Iej+bTHH30?=
 =?us-ascii?Q?uX5amYZMhUofeTi/WLesu62navCbG1xO2+RndY5zdONQDnMJVYts6XICCtO9?=
 =?us-ascii?Q?qtyiYAFMCm9RJwgLU8dGcM3MjFG39BXHfwyoUVU2SpbeL90Phxs5VM9TxpuG?=
 =?us-ascii?Q?9Q2BeZIKhd890f5Ny4QaQD4yMi/wmFfg9TYPE3Tc4uN5JOgIZYiVJV0J/DZJ?=
 =?us-ascii?Q?iqxx9fZJjFZIuo8+JhXnG5QWBaqNnT5UE7/XchXaZUPbTwZ3/nnqdnYJUBkW?=
 =?us-ascii?Q?ZbbV2no/+62VYAjLUfCmlNGqdFL8XpXn1sJR1Oa6YA6GnpTaM5KOJNSH4Zl2?=
 =?us-ascii?Q?wQtNBwhesXJmnGme5rDkjYVNPQuZuwAkSwWv1gwXCqzQLhyIgxPENbH/DgA/?=
 =?us-ascii?Q?tH4WFyr6qGBaSbEQmKDca1qy1EwNEpCnv4Pip6e3Vvl90werV0vdKDYiNcdG?=
 =?us-ascii?Q?r4nw1bT1ffnHi9daCqg6jvxWFnA1zP9kq0ghOGpYOtNfdlIsj9eGVsOf74Mt?=
 =?us-ascii?Q?uNzTQqsNIKDQMATpl4BWzRdKaf2tPXTVyPY6o2K1lrW1ZBTNVCO2Ve7nMOE9?=
 =?us-ascii?Q?+LilpI6IaKRcXvj7crG9Z/Coi23zyfpNLLMQPkE6a2x8ZtaBqG1dKslN+JM0?=
 =?us-ascii?Q?6J+2WhiDKYga6Lfk88u+HTlRJzttELSZrUdmCUJdJHVpp4ujQgchnbd/tl2w?=
 =?us-ascii?Q?RSEplBFv5gBZmJkoTCds42+oJQt9lQCGWNh0gUGCr54VerWDHD69mh/UOoyF?=
 =?us-ascii?Q?DFRT8hOO6soJlyPCrkGUnd4paQG4Fg58N7tVbKA7eUI2qv5NfC4l8t5U8vhE?=
 =?us-ascii?Q?sdx3kI8lDyO5bTYxifsEkPr7UH28CLi9WeSTiDIvbbcl0xlzUq2iwsS14Taw?=
 =?us-ascii?Q?Z6ixmTH6hvi8CCUiZBdKfRe78L9GkxhqWB0aExvVaUSuS7L+HMMmLtSmLx5P?=
 =?us-ascii?Q?8qN4aoKao4xyzJewpP5DGqW8S03/52GbMXSeoFDjJ2T+IKvg69h6QU8oM53X?=
 =?us-ascii?Q?htxn8WhRXPDGaeZaqiqqz5HRuERZdprT/gIMKEgsWLSJfmwcgivrhnpdrsCD?=
 =?us-ascii?Q?1sVBlo1qitxZ8o9styXOP1U4JjbUCU0nJAMibYdrC7OoUqvG8a7mxymf9vgO?=
 =?us-ascii?Q?DQNt3R47QhVSa7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:33:58.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db345fa-2bf4-4fee-8e7b-08dd39571840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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

The commit e05689242238 ("Kconfig: Change SYS_MALLOC_F_LEN default to
0x2000") already setup default values from board Kconfigs that's why no
reason to duplicate it again.

Fixes: e05689242238 ("Kconfig: Change SYS_MALLOC_F_LEN default to 0x2000")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynq/Kconfig      | 3 ---
 arch/arm/mach-zynqmp-r5/Kconfig | 3 ---
 arch/arm/mach-zynqmp/Kconfig    | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 265e9ce588ad..376d1bc7131f 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -43,9 +43,6 @@ config SYS_VENDOR
 config SYS_SOC
 	default "zynq"
 
-config SYS_MALLOC_F_LEN
-	default 0x800
-
 config SYS_MALLOC_LEN
 	default 0x1400000
 
diff --git a/arch/arm/mach-zynqmp-r5/Kconfig b/arch/arm/mach-zynqmp-r5/Kconfig
index b2ba896e9b41..45d8c0535774 100644
--- a/arch/arm/mach-zynqmp-r5/Kconfig
+++ b/arch/arm/mach-zynqmp-r5/Kconfig
@@ -19,7 +19,4 @@ config CPU_FREQ_HZ
 	help
 	  The value, in Hz, that the CPU clock is running at.
 
-config SYS_MALLOC_F_LEN
-	default 0x600
-
 endif
diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index 92d61e84319d..151cfada4366 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -93,9 +93,6 @@ config SPL_ZYNQMP_DRAM_BANK2_LEN
 	help
 	  Size in bytes of the DRAM ECC bank2. A null size takes no action.
 
-config SYS_MALLOC_F_LEN
-	default 0x600
-
 config DEFINE_TCM_OCM_MMAP
 	bool "Define TCM and OCM memory in MMU Table"
 	default y if MP
-- 
2.43.0

