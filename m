Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A48C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 10:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868A88334A;
	Tue, 22 Jul 2025 12:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/rKxMDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A7A8334A; Tue, 22 Jul 2025 12:52:28 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E5583253
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvQfglc19Zy3w3vApkfktPdq/MsF0YXpQ+BRgGDCKJOuNI1b+cVUDkN4b6+YJM2TWNWSZqFmTmT/LHbCqwTMKSa+FVWp8lFBPtl/UQ8C4b1ZlyY7ajsoNPSefHexKTcn3lZTX4TqrgNgJOlY5s9lgRia1zH0qwwx6Dwwg7GP9kKJ5FYGje7EYD7FMwVAJBgXSKJSbo1Qrb5GBw7he3+BvaaR46Jm/KbJvcFdb7hFTgqUnUmrGJhfAIEW2mpmFNWxhk9EW4IKO23GUFLnUAAf0lHtFU7ERuCKMQLrSxLF1DbEELXv/TJ73wV3clNii1N/W7hXiocccr7zx1/NS5g7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNr82w3ClOpytLq4S+5zl6yVCgQq96Hd3P++Fg3pZv4=;
 b=pKo0U8eP0Di6o3zT9v7W0smTu04+j3usnbWQZLZDLmaJf9EDYcfDrVKlLGi7yZ6tyiwd/sosB9Q4dpKR11mAvHap4nnVlaQhVUGyxegLPMoxptWyf8X56PaahNYYXqLIgqjvmatnmcw7k1eWcSl72K9NRkNCRWxzdju016rXYGbANXzzbRp4aHpC92t0bahTdUQQ2T+VfuLRCcrcUglbvWA3tJwHP0iuGOWatRh6aMXdJ1JY1BwINtLxt4YlrnoMtzTJpNtbD8uRA7c+b35Tdc003ZAhEQ17xtj4IaKxpsS0+Nm789NRqgzxd08GzqHCUrUp4zpKeBf+xXUNRY5ogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNr82w3ClOpytLq4S+5zl6yVCgQq96Hd3P++Fg3pZv4=;
 b=v/rKxMDXyaISZX1swzx/zDuHnhXalnrlc9Q71uqoG3tfmMXMurNxwJDSHDgw5FPSrU7nwlJYejMECZCh9AS9Rg9eD2CCHuVX+sjpjpQBQiFOYQx/q9dcMidaeKl5koibseaQl+IiOx/y2relP3pj6y230W0xX9h0gZkxATTNX7g=
Received: from SJ0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:a03:33e::12)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:52:21 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::cf) by SJ0PR03CA0037.outlook.office365.com
 (2603:10b6:a03:33e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 10:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 10:52:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 05:52:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 05:52:03 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 05:52:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Michal Simek <michal.simek@amd.com>
Subject: [u-boot-test-hooks PATCH] travis-ci: Wire MB-V targets for CI
Date: Tue, 22 Jul 2025 12:51:45 +0200
Message-ID: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: c5797e5b-ab43-42e6-073c-08ddc90dd55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q51Lm8IFbcbNYRdJbtOzCX35dA7TDj8+UPniamKKQOP8tfixm2ya/r7MV+2g?=
 =?us-ascii?Q?CdYl7TM0vfXGzlZ8OJMCt3MGsYaV2SCMz0u37Zw0pOW5Vjx0L+D6txy0g0G4?=
 =?us-ascii?Q?CEmXlBIEykGH+tp+8M/cXGTB3clPoxw0A0UfO5adGTqSugaJ3HBf0x5K1MbT?=
 =?us-ascii?Q?8vO/nRpzvZBKjQZGjBoyZlrfJrmJEBXB8+fAvC62xxt1BCVTPe80ihGj5eFG?=
 =?us-ascii?Q?UX5cMXpABPz9XgyO+u5UeIJUdNl08NbJ230YADf9gUkyivKxWh/mZLzmzzgX?=
 =?us-ascii?Q?Ey/rC9YnFt88J7/PPJAMZNLYMDbBCXWED4w6LDUib6o2obXb8/G3uII0jwcv?=
 =?us-ascii?Q?wk6FaSOe4kvTbGrIgqJ06ww/vHFKDUwBp6HX6I+37CVf+yxjn3qZFQAGMh0g?=
 =?us-ascii?Q?RZfgSE56ulJ8ePhbAlFi/dlsiHXqEbzWzWONDyQJAnULXl82t/FHLHZ1VWSX?=
 =?us-ascii?Q?b6UmQchDycpoR4+7Qitw/4ZzvqwsPcSwQHWFVCFDlcl0ThsdG83+sAlZdZFG?=
 =?us-ascii?Q?+jk7ZAyLIkUSldoQ/D4DBlvMWYvAzYylLQ64leyMv2Bx+eh+zg50iQMsPHFs?=
 =?us-ascii?Q?np0vHi6xu7ZbS6AeFd9iuDvMgssOxXpQfxHbHcxrSH3foawv02TFOY5mJZAk?=
 =?us-ascii?Q?iWOoDeKW9NZ6s/PypIwKHheHYRNiTrTWRwBEnljgDSsksF5obkbLZ1TzDbpG?=
 =?us-ascii?Q?1aPtTzxYbpdtRp4b0fGc3/4xRR8ND0R7HfQcwmf5XgODs9M4EdD3sH4KMI8O?=
 =?us-ascii?Q?kdQxCnZBaZ+RhK7E9qpU5hvEICImOk7STBeXCrE0AoVsqVdA0v1JbJqatsQ7?=
 =?us-ascii?Q?bMAsA59x9g9gZ6PrwIUoJdAr2GW36R4RYrKkFBl+FvZSnWI3cXLcAxBW6SaW?=
 =?us-ascii?Q?HRkqseYO1ky3UOUD3prYMLZCmKngKdPrWBff5SX4vHiX0MII+7tpzD48POeL?=
 =?us-ascii?Q?m9VEGmQSBRzh/7A4P5672hq+7C9HOO5gZz9jqGGGzNLLze9GN7Ro5doss+94?=
 =?us-ascii?Q?l6JNDDGIlkyx9e19OJVjlHCqMOUPAeeXQBNxX+ciaQ07qezH3PcK1LG+xVi/?=
 =?us-ascii?Q?IaOF1Dphasu76kGciQK7iwihuRV99wNKzxmWE4U4pAR4rUT5Og1F+d1CG5C8?=
 =?us-ascii?Q?vAMHp5+iYsPPEub4IjXl4qqG4OaBDdaWJhU/GppwtAVKuk7aVqkklYVjAD12?=
 =?us-ascii?Q?JDqprqXwfNpwn/PIf62Y54jXDrXTGVYlneFl6YtAy1B9IJ4g4l/tFJ9j9is4?=
 =?us-ascii?Q?p2CKENtIu29bU91w5IvdKANJgCgzWC16Au0SgWUsZdw734/9sCmlmHYs3R3S?=
 =?us-ascii?Q?y50QI5VBgJpu4UNuSfZhbRHSeFsuMdvbUdmItRZ4A8CTIYymwR2oRmGJ5W6/?=
 =?us-ascii?Q?xd93PjDy1Bofzua0ek7793VWzAPe/I5Jvk+by+9kdFI6XzusGgLi4yNUwIX+?=
 =?us-ascii?Q?eDcgBOI07bpyUx+6/rFQPD5msQHsg7UjQ6tf1tVOje46l0MDeXBlbuug2Lp+?=
 =?us-ascii?Q?NEmKLdlm68FLyUjDkR3L6gkozszEf+rzIzed?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:52:20.6664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5797e5b-ab43-42e6-073c-08ddc90dd55f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

When QEMU v10 upgrade happens MB-V targets should be wired to add them to
CI that's why add configuration for it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 bin/travis-ci/conf.xilinx_mbv32_qemu       | 40 ++++++++++++++++++++++
 bin/travis-ci/conf.xilinx_mbv32_smode_qemu |  1 +
 bin/travis-ci/conf.xilinx_mbv64_qemu       |  1 +
 bin/travis-ci/conf.xilinx_mbv64_smode_qemu |  1 +
 4 files changed, 43 insertions(+)
 create mode 100644 bin/travis-ci/conf.xilinx_mbv32_qemu
 create mode 120000 bin/travis-ci/conf.xilinx_mbv32_smode_qemu
 create mode 120000 bin/travis-ci/conf.xilinx_mbv64_qemu
 create mode 120000 bin/travis-ci/conf.xilinx_mbv64_smode_qemu

diff --git a/bin/travis-ci/conf.xilinx_mbv32_qemu b/bin/travis-ci/conf.xilinx_mbv32_qemu
new file mode 100644
index 000000000000..b92e6e748246
--- /dev/null
+++ b/bin/travis-ci/conf.xilinx_mbv32_qemu
@@ -0,0 +1,40 @@
+# Copyright (c) 2025 Advanced Micro Devices, Inc (Michal Simek). All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+eval $(awk -F= '
+  /^CONFIG_SPL_TEXT_BASE=/       { print "SPL_BASE=" $2 }
+  /^CONFIG_SPL_LOAD_FIT_ADDRESS=/{ print "LOAD_ADDR=" $2 }
+  /^CONFIG_SPL_OPENSBI=y/        { print "OPENSBI_ENABLED=1" }
+  /^CONFIG_64BIT=y/              { print "BITS64=1" }
+' "${U_BOOT_BUILD_DIR}/.config")
+
+IMAGE=${OPENSBI_ENABLED:+u-boot.itb}
+IMAGE=${IMAGE:-u-boot.img}
+
+VERSION=${BITS64:+64}
+VERSION=${VERSION:-32}
+
+console_impl=qemu
+qemu_machine="amd-microblaze-v-generic"
+qemu_binary="qemu-system-riscv${VERSION}"
+qemu_extra_args="-display none -m 2G -serial mon:stdio"
+qemu_kernel_args="-device loader,addr=${SPL_BASE},file=${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin,cpu-num=0 -device loader,addr=${LOAD_ADDR},file=${U_BOOT_BUILD_DIR}/${IMAGE}"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.xilinx_mbv32_smode_qemu b/bin/travis-ci/conf.xilinx_mbv32_smode_qemu
new file mode 120000
index 000000000000..66179b3d3fb7
--- /dev/null
+++ b/bin/travis-ci/conf.xilinx_mbv32_smode_qemu
@@ -0,0 +1 @@
+conf.xilinx_mbv32_qemu
\ No newline at end of file
diff --git a/bin/travis-ci/conf.xilinx_mbv64_qemu b/bin/travis-ci/conf.xilinx_mbv64_qemu
new file mode 120000
index 000000000000..66179b3d3fb7
--- /dev/null
+++ b/bin/travis-ci/conf.xilinx_mbv64_qemu
@@ -0,0 +1 @@
+conf.xilinx_mbv32_qemu
\ No newline at end of file
diff --git a/bin/travis-ci/conf.xilinx_mbv64_smode_qemu b/bin/travis-ci/conf.xilinx_mbv64_smode_qemu
new file mode 120000
index 000000000000..66179b3d3fb7
--- /dev/null
+++ b/bin/travis-ci/conf.xilinx_mbv64_smode_qemu
@@ -0,0 +1 @@
+conf.xilinx_mbv32_qemu
\ No newline at end of file
-- 
2.43.0

base-commit: a7bd2dc1f6fa4f9f2adecd983ca283df1bc48792
branch: master
