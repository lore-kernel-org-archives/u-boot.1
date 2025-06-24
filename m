Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52559C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 07:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD60782C84;
	Tue, 24 Jun 2025 09:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QRQyTpbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3243282D17; Tue, 24 Jun 2025 09:38:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6DE82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 09:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMBe90Xa/fN40OtfS1gdLGBmC0Yfpb15M9nosp0+4zcGU7VQQocRZTBt9uLG497F3pr8yJ+WizSKGfN9QgoiGq3+HTrV58rMHI8nnn7+0drPPHNn4+iJoNtodApqHCHbvo/DGLaDVaAndS2sFRaCb+u/8l0nghQRgd4MMz5BfERYYRn4ClYz/L3z29EGUxGJzQ4cdwiCU0lu6USskiTg4CHrI6vGpx7zED59XVX2zs6lrwGsFnHryLDNHIfrDTfhjkxIOSWy6Cg30ay2k3lJIIVtK0YY/2ZHJMOhiCIKOsn1IwIrVA2v8lsw6Kq6I9jwpRLpyR1LtAJzWyLgQFWBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGoSDK8Y7AdjU7eW7frq04WK2Q1uQUxskNKr369GLI4=;
 b=xn+XFz2K4O8oUmcP+G4LyKvHMUMxf9JEmxR8bXBoM2lm1phKXN+Jzb5tWGoyAv6VKeTZknoQmCHD+hTtU5+W/FH57T+lSQMf3JY251czCg7DZNIpQe/W0Q5c78VW1/9aof9/uJrFiqKj5fGcOLZyVvtvfp0e3Cbw94Qe+McaylaCuMxY6HdyxudzGrwAnvJI60wqSEKZYbcEzYcCEkkstWJL4S/+dqICaNbMwpIKDl0UvZlTDm14tAZId4vJQcAR6Y+Bu1KQgXlD+9/kVj4XgrZQHFqBdD/cowHE8dw3FkMAai19hak3OAtP7AUIqY9DMnv81+h1om8c0rTnX1KMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGoSDK8Y7AdjU7eW7frq04WK2Q1uQUxskNKr369GLI4=;
 b=QRQyTpbHiPFBETDGznx8wYWAxxCkyWTo+Y/ojOSXD55UR5nBzqByKKCZYP8vev+QJPOqyBAWNQAktOLK9sQVdYtADA0JOw8OvN1k+H+X7w2hBg75HJ7pMFqVA8EWRTPIwKMXCmCJYFbqDqarCG4m7CzKO1MzOVuXihbav89RWbc=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 07:38:45 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5f) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 07:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 07:38:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 02:38:40 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 02:38:40 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Srinivas Goud <srinivas.goud@amd.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Enable rng-seed generation
Date: Tue, 24 Jun 2025 09:38:31 +0200
Message-ID: <fba4498f82e39982e1b4157a0cc18e9b6c2b033d.1750750709.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=57UTV5Bad9Mx7/xNz2ckipztRoTzfABodiLsHOETjkw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWREhf7MVLsZdnT7OefEehmrHL8DTbtFTR1EuwxzF1+68
 P/3cd26jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiI/WJGhp2PFwhXck9umMT+
 wfr+73VnhC/phnFoPAj68jzV5NnFRHOG/0nXvr0JDc8L1eU38TrrFjHTTmrqwjPM4p09XYGL7jy
 35QIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: ce63a785-44ac-4de0-856d-08ddb2f22641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mrQIaJrBWWEvmenkz6DxzLEDwjYm3ZOZEx3EmDsuCx9z+42GWtjKQrSyCeOR?=
 =?us-ascii?Q?/wlYhnkK4aSPIw4i5y9OnXlPYQC3hgeOCrkJmFDMlUsoirMp9AoXeUkn8So1?=
 =?us-ascii?Q?/XFMT5xnrhzU4bNa6BsTfSlyQ//tzGTrPdRE9aXsagQawIJ/IMm3lAGbNCxw?=
 =?us-ascii?Q?dkOj5YII2NMgWTVVmeGxGnwkviuHNm+4AiKjOeF5ikJuIrv7GWu4LwY3tvI6?=
 =?us-ascii?Q?JfSjbFUuIXIRplht6tKHLsRhrKuYf3EKZ4lUrJxsMARHfBKr/cnlgt84EYgQ?=
 =?us-ascii?Q?zTC6R0jxx1VwUU61bDwnmu5GBCVqaVfmkJXuls1E4FJVefkxfkdUwLe1kF0b?=
 =?us-ascii?Q?E4T+leX+ydhwS840sfMC9+buwnjg+cE3ua8zR//Olk3N9O8yp1SxdsZTg9Fw?=
 =?us-ascii?Q?ybjacoNA8CtYNEAtpjZuFoJgj03qqbcGpuQbr6esU+S3qiFY8LoRQw6HOnm5?=
 =?us-ascii?Q?y1k/irIFNfM99CcC36FC6/rQeuHjypRqsK7iZtvzWTKE6fWcgzcolI8qxMFu?=
 =?us-ascii?Q?Ud0grm6LliHbXoGn654fkJdWmaLYUPIbv03AUbFQfNjfXf5q4b23pj0A7Erw?=
 =?us-ascii?Q?vH/Iu7R8fHW49ts0VgaiLWW8lt1qHwBPc0bZsjpo+ZuQxPLNXpCjjvstlgnr?=
 =?us-ascii?Q?gzeJBvEJyhw1vAj7puvemFcQ9U2iZKbxW5UEj0oLy0m44FDAgicQFWKY2RcF?=
 =?us-ascii?Q?VcX7wp5IyOrSFegBKQ5mSSltqitiOPc4fmrByVnWkII/8NkyLn0J556PzBNG?=
 =?us-ascii?Q?gI2Qfl5Thucaz5IhZQjVns+zRsoxj4HTocoV94awTIJC9t+zeZecvnpNB/oV?=
 =?us-ascii?Q?VIv97XkUA7V39wS4AOR1q6Sysq3mVOpd1Gr9+ZlskhIhJ7RBWLtoBcJG/ZKR?=
 =?us-ascii?Q?aTARFzSm1V27gcV/TJdOTE7E9Hkj+mBNHOzNBTH2D/spuD/es1ufYRynwsI1?=
 =?us-ascii?Q?3pj0z2U2h+/g1VHd9GPiz5ucc9DlqE7ZRdinUFVawdvi3RGXMVZ9f+oAve0p?=
 =?us-ascii?Q?urFeJ6Xo90Ec8DV8ZZQuW+9Apmgr5QHOXwzNTKzhlqtnDLbtovY4wOYdp01D?=
 =?us-ascii?Q?I8uH6sUsau3yIiFTS/LAIlh0+CzKni0+oVIViA55Y9mRIUEvo34YMri6t5Xd?=
 =?us-ascii?Q?HrtUnWtvZUVMNzG0ZJUcGLejxH1M2VkO5qqueg5b4um9I1cFTnZ+J1ZjyS7b?=
 =?us-ascii?Q?jqIbSqr7Zr2oMFAODWdDsIYe6ZJ32Nx1J7f7tLOdRXut4ghQG+CIxOIqzKkE?=
 =?us-ascii?Q?KsI6iHXe/y6Q+IGjuiYU032Y9Bou/Mv2GN/+6j1hcKfkNto5i1lIK8fhMt8T?=
 =?us-ascii?Q?NcBx3f3nrXiYbDy+keRvCFeEMJJn8hWosl/WTJ40Ba42QK6gQFz1WdAEOkJG?=
 =?us-ascii?Q?SRKMyUFNfhKDLzGhQUfDLovpO5xQoZZ6v0zGY+2Rq1oMhr/mTj1D3Pfx9wQm?=
 =?us-ascii?Q?qIi35fleHlE2lYGLY/zKRd0VH4hQcqkpxNUMk5wR9AtPMvRtsuftm2GhFZ5v?=
 =?us-ascii?Q?erJNDpkbbcW2kVsjKT8veOMzqapy6BLwSFTh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:38:44.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce63a785-44ac-4de0-856d-08ddb2f22641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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

SOM has TPM with RNG in it that's why enable rng-seed generation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/board.c          | 32 +++++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe74299016..06470c740e63 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2014 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -712,3 +712,33 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 
 #endif
+
+#if IS_ENABLED(CONFIG_BOARD_RNG_SEED)
+/* Use hardware rng to seed Linux random. */
+__weak int board_rng_seed(struct abuf *buf)
+{
+	struct udevice *dev;
+	ulong len = 64;
+	u64 *data;
+
+	data = malloc(len);
+	if (!data) {
+		printf("Out of memory\n");
+		return -ENOMEM;
+	}
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		printf("No RNG device\n");
+		return -ENODEV;
+	}
+
+	if (dm_rng_read(dev, data, len)) {
+		printf("Reading RNG failed\n");
+		return -EIO;
+	}
+
+	abuf_init_set(buf, data, len);
+
+	return 0;
+}
+#endif
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 48246f1b4f61..93776f95bdf0 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -46,6 +46,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
+CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

base-commit: 965964491a8de3bb105f2bd83daa261f9c8ce156
branch: debian-sent3
