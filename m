Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627E5C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DFD81FEE;
	Wed,  2 Jul 2025 08:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWTpPIA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4A082103; Wed,  2 Jul 2025 08:34:14 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1828003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv02TYDQHgCTgkhbOaxRYS7IfxuK8pND75GlkMNQPVmBSwfAtCVaL+1TATn+xo2nnpaXQxiU7w8QX5A8C7Wl3gIXWQltPq69exoT9F6XUqMQ2kFoQZAlMdsRdWonYuCLofbWhksI71tsJ087RUqquoNkY+8kRlNdYVxlfuNLHT8mDGi+cEZsa1Xr5lQ7dJkl5IckRkGQ1KyVXDm9axFAd+ovU2bSUE4mwaKv7pq+HB4NG+2/psgNLw0lyAz2Rsm8yhGHvBsyXr+aWM5fjD8wdbwQv8iqd2ghbNSa1GDk9mlf65Wl4MQ05fvqS5cplIzpifIuiMGXhOkszhllWQKeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aS/tw/+nea3JR2J5eaZRzZ+e+eRa0GWu90Qc4S+RsU=;
 b=eoa3VT+fIdkOKN9W97FxL/STLOhe4LFNuf8ckxVXpezSCeubSMe0xML0yU8zRHWNVO6TD5JWw89GRyHGGqvz8Dust9YM3L5y9PVrFLRmyj3zQyozPKvJ6KMc4Z0TSWCPfdmrFwneqVMj6aCPuNh+PF3pY/UK1QbRVC1xn6qnrnBVT4SwGrImrvDEMQGWqrac+p3pXLH7RikqYfmsjl5LXiPcafNfZVDD9+rIs0H8f6VJUXedbpQC4J1oYGhsJk9BEED7fdYHQJhR2SXxT4BIOx5SgO5smGGRCmFQrsC2SGaOcT35aShWKyRIimaI9Nmo/zeps8E7Sz6/7Ypas7cMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aS/tw/+nea3JR2J5eaZRzZ+e+eRa0GWu90Qc4S+RsU=;
 b=LWTpPIA1elEJlL6VIWnGnDfjTgtWSGH2rQSMpd9gCgptIRN4dcTsj4OdytPQVwQjt7tRbWPYrRbv1PzOdpkEnI3CmYOmuAzBETMCm5t8yaB4R6nYzHEVYVXO6ngvMVOICJkdPtVPGo8NxDAe9h5Vj0gk+eInxyAI/Sxad0m2bf8=
Received: from CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::14)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 2 Jul
 2025 06:34:09 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::64) by CH3P221CA0003.outlook.office365.com
 (2603:10b6:610:1e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 06:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 06:34:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 01:34:06 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 01:34:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Srinivas Goud <srinivas.goud@amd.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] arm64: zynqmp: Enable rng-seed generation
Date: Wed, 2 Jul 2025 08:33:58 +0200
Message-ID: <8c1f0b439062476c609d8d30247041556c0b69f6.1751438036.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hdGWFxIRknoGgpmtbM7kDpIYlw2ooMMYdzmcumHj4zc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSkXLp+3aw3vKip+HxLsta5mAJf2bTmihqpxoZvyUXc8
 14f8eLpKGVhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgIm0bWJkOMx5ydLJrNf09OFI
 78ZVj14E5Kkv+nvgtPderR/neX/lxTEyPHj89NWUbUZh/3cZdlt2J3Bmy8jOy/zOc4bXz/9wfsE
 XZgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f47e8ca-d5dd-4883-6006-08ddb932737e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?roFrzp895o72yV/KXfK7OBCsjoM6AWL4Tv86wYnkTuU9XwLbmJ8LzFDdl4dT?=
 =?us-ascii?Q?QI5pa3qs5Z2G9BRHGAp+GzyU8oZGz/fGdIdA9y0xAr3GIDdWp2BV1nxhbERH?=
 =?us-ascii?Q?HJJ9UlS7HNjklsUV8sEw6vgGNh1cqkWlMEOI8yWmZ/6WfrsT+lf9WCPh6keB?=
 =?us-ascii?Q?djK9VEKLHm514CT/HsVTHtm7kTuuHsGiTWF+NAFMF7JsazK1WFL9bOG0cSVE?=
 =?us-ascii?Q?q4/efjevsobL+tyeIrxD73ssnf3RheDlEfixZzhikQIEw6BX9PsaoT1E25+a?=
 =?us-ascii?Q?Mm6z8fQdA9ijhMUrJ5yGRwx0gKvtlJQ1T9DiHAVke/NW+gsWbFYFxJW10/9E?=
 =?us-ascii?Q?1MxZu0KYEJgrS6jSh2UaLPdW+CW6gGoagf4yYYqmlywW4/3SvvAq8Ziq5Gzy?=
 =?us-ascii?Q?I0kTgxUGF25BwmXXaWZxfJcpzliu/EbRZJ9JWZAAN9OzVFKNbqe26DFEQ4SH?=
 =?us-ascii?Q?sPlvWYx88rsZtauqSt6/IGGW8KLAwaZ0A4STUtY6TRRctqRz0yTM0G2R55v8?=
 =?us-ascii?Q?G776ZEY4H5ENogMUDEHDHLuDHKCS96nQzcdXZhFVJu0AN9TJ4XfirLbVdN0B?=
 =?us-ascii?Q?ZcpQZrrPqXZFw8Wg2hQb4Dx7k6tNrsj3pxALgRVIQnE+bzdKVc3I/S462zMA?=
 =?us-ascii?Q?6DAGzkmTNNfpcoTmD0NGXk2gIqq6+eT0SKK4Z11odnLcwTuNbwkgIbkBDgjv?=
 =?us-ascii?Q?mYBJRwIhu0XE3qQfihDdd9I2EvDCkxInHNmYLD7t9RbiBh+VB5KhDqGX/ZyE?=
 =?us-ascii?Q?gIZbzoAyCymyp1AWypDu77t/u+NvK7J15y3P+S8Dyq4KrcBfPHMQLP91tzXP?=
 =?us-ascii?Q?btcuOk8pUx9+tVijg8RxQI1s6OkJJ+tES4GkjNKQTF1gZLhTZlSXUVCP8eB/?=
 =?us-ascii?Q?j9jg1m4EXB7B60OO2Epj3rgMQ0FuY7k7wZ5QzfH/MVWOmeuCQ4ivJFbR+Nke?=
 =?us-ascii?Q?t+OgsqTqWgOMB7ExoVv/WsgKMS2C2UM5nk+W3E/H1h3eHg7zwNcwO5OFlqJH?=
 =?us-ascii?Q?QT7FFuqFmG738KdOWGh0UcjTTm2vsQrUilAdMxSkAhLk7AlALlOnZr1EBa/J?=
 =?us-ascii?Q?I/bOg1S2ZS4lrY8tm2mI/W6koVgRLUP7snOoj74h3uvOOD9KngdQ3EJqh1pR?=
 =?us-ascii?Q?4SNW0m8aOxP3NpBwmxT8pfizkd7VYI7HMjoF4bDU59zOZSstml2dz9DQ8ZEh?=
 =?us-ascii?Q?kklNxDiO0uCz1WVfvD5VtvRDlggnxHgj6irGX134134OaTL4CauQPmry2SUl?=
 =?us-ascii?Q?5HfP28c75XnoFea5Uqou+1ABjtyc3cToDQUn0lP3qaN7FgkBXoZog3yYMBD3?=
 =?us-ascii?Q?wtTsWwhEbIkLI8kdERZmyriTSa5W6kV1h7b4rAcdVdfdci276/UoP74zCieq?=
 =?us-ascii?Q?CBzk+w8xEuAGWz9YVHQ7Nc8/Pk9q3kcl7VqlA0QOJD5aM8mwlfcErTV4MumQ?=
 =?us-ascii?Q?Ckh17/FV9ZuV1SFGi90bS2+ngmhZ8puOnYMdrYtXBiikHPkWyJVaZne35mgL?=
 =?us-ascii?Q?LxBdredNpDJ6bN9UP+EJIpx3ox9ETIxBEB8f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:34:09.3121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f47e8ca-d5dd-4883-6006-08ddb932737e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

Changes in v2:
- Free alloc area in case of error

 board/xilinx/common/board.c          | 34 +++++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe74299016..f258675d7772 100644
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
@@ -712,3 +712,35 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
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
+		free(data);
+		return -ENODEV;
+	}
+
+	if (dm_rng_read(dev, data, len)) {
+		printf("Reading RNG failed\n");
+		free(data);
+		return -EIO;
+	}
+
+	abuf_init_set(buf, data, len);
+
+	return 0;
+}
+#endif
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 22ba8a7cc158..3e2ac6144050 100644
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

base-commit: ebd8a8ae95f6dc8548139aafb975da553af3bd04
branch: debian-sent3
