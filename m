Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2722C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA71A82F00;
	Wed,  2 Jul 2025 09:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lh1q7kOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786D68206E; Wed,  2 Jul 2025 09:44:21 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D35D82E86
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bru3ab3NfaQQ7DlrZXIB83lPDQW0yj7FshkGn3xLYN2iZrOfZl2lKg5YUXtV3NLoyhy4jWm3DOCtKybmVBMyYm8CIQcJYB3sxdxTGS08l4iyiAGlNf8EhVZiBR2LYyft6FsL9eLX9p/fGBn3p7zIdSpv4ANDzBpVSqohO0DjfKPonbViI4lhv8ETrTG4ri2lxzi51B5vd/ksnT0jg6X/rH5FWr6Eb0avp/qhzO1HgEDMXYiY+xx+p4lWyzgsf/YlJfEaazZqFQHh5O+Jug/aC8mCe8x+C9IVf3qKf4fpsnXYQ8NkX31GkUek1Yv08BFkhz9Q1ozHpV5yhp6hRsserQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYQyQzNfRsAj8xwUsD9PTuv2+sBgHAF0mwyMEXjBqUY=;
 b=IBQCL3pSIFbGVOGaH3yxYu1f+PEbRcdw/hlhPW2bU7ClRVck8jkrcoFUSw7sytjenQL+N2zFm8qmeNkPrHoGrQ1zBigSY9PJcV9W1Ts+Kz55BSizGqNczCbfDu4/7e1t6j3RPlsbTJuCqzs6Xku4co8PgSpklfFrhA2eLaoZmFBENtWjTSmrFBdA2FfLNWcaJvsbNtALvYdDn68manIVyqZQvryBtaUJDd/I4pa/GDSJZwTYrVPhXdYsHL6qWsBvzkPY7wo/UrIZLOttqbqE+j6S4MaHLiqcv0OVF22gDLUUkBa4GTF5rpof2DpC0eRdHGtzAleTKBx/LNKtOHjMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYQyQzNfRsAj8xwUsD9PTuv2+sBgHAF0mwyMEXjBqUY=;
 b=lh1q7kOutycYr22BeY6rNu0iMWDwHxvQlnSRlpUva22NshojlyEIgWzCU2qATPuuzCvfmHZkwkdzla69CvzD543YbTWNs8i8Aul5yn8v1iGA+hI9XXGi2+YcQPS+CEZ+jibmoHvPYNvTM0Xd3RPFAfz+732U89NbVg+0Mxm6Yhw=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 2 Jul
 2025 07:44:14 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::6f) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Wed,
 2 Jul 2025 07:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 07:44:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 02:44:12 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 02:44:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3] arm64: zynqmp: Enable rng-seed generation
Date: Wed, 2 Jul 2025 09:44:08 +0200
Message-ID: <0e55eb3eade94e9cd0ffe04da0618aa6b1589f01.1751442246.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UCWNnZ09x2oLtD48yhkrzPi6viCUtr37e2dE+0Ih8N4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSkPPZM+py/QjW8ymeX4apfys9VPH9NzfFqcTHdGdy/+
 2q64iT/jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhISQAjw7s7jeJvk9nPTFul
 fbesLXTzhh86Lv6Vc5rKFgYsr/72KIORYVXaV5NkqfmvGLR4Iz9Uas/iUvH/51zq91X374H4R2c
 2cgEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b08d7c2-55c2-4dfa-9134-08ddb93c3ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jkqQUPmm7NJHzWHzjZqegWvubdYY0rZzWOYdK4j+gfB56h8nw7qFJ35dac/b?=
 =?us-ascii?Q?/vlXphXlkA+fwdBl1VWIGbBSW/HSbryIsvA/i+x97757fZtQGSu/JuNXfn75?=
 =?us-ascii?Q?UCLCLrN+FQFupnPJ4cf8zi7Z/jFEI2gMKfv54JXniCslc2z7J2nHTKgJHZDe?=
 =?us-ascii?Q?anpYZ1CawLyGTg6iFW4A/zNW4JxyFwnYuYVHyh0GRxkjX73ZHmhgexrSg+JL?=
 =?us-ascii?Q?aGdo58akbG+3bgGklzEfBdtrK8zp/HIClThzBeRuVvO3ywi9DAHtnEMBUyEP?=
 =?us-ascii?Q?yReyCfabaJ5IqLu8v86xzvU7U4Jshb7E7F1OQZEycqUj+SG8GWYKMCG3qaaL?=
 =?us-ascii?Q?mMDCKskQjnUQ+6ti3BLJiBXGI5OipU2zbmv6stNdWgQTFkJLzOMGTJKJeFaI?=
 =?us-ascii?Q?wCwiCBkqsYdIHmH4vE3haBmk3putAiOVk4goPQmAU1QgirxfQ5HblfkJRJ9u?=
 =?us-ascii?Q?X5oHnQE3vBAMuNBXqK3rx0R97tM60D2HF/kN1Vci6ZCaRYzBPHdod6gm3/Mv?=
 =?us-ascii?Q?QoPJY5OIU8m1khIBzNQemEU+pUAnnBMzf5ucKKt+Dvg+BsDK0dYr/A9ww1ks?=
 =?us-ascii?Q?4MTN3ZWg197wUU5DijkopNXBXEVaSl6d/OzGuOYQLmwGp3TA21B7szIRs6+X?=
 =?us-ascii?Q?kcteBtXXXBd+U+PLTZsJO3IIBDqVnqKAlh88Crl+9E6iE17WulobcPI8Q3oW?=
 =?us-ascii?Q?xG0lT4IU68voE2uD/WfvYcY0H/eq6jPu37M6kifx6PVCydgg6z+gVpvUxutL?=
 =?us-ascii?Q?ZhnrfflFElmeWb8Nd6NLZk8iinCMCAs8cP6D1x/IVgkfQOIRRT6g65VTy6Wx?=
 =?us-ascii?Q?ULexJbfpkaJn35JlNTQihGOWY8fSBZ2kwd5ETAaSSXMR5PluJsJV37Z97JGp?=
 =?us-ascii?Q?C7/OrKFcgmOBsI97eAHZpfF/KS56rKHHU9htlUQzpX3pHsH6ll1l0abgPeKn?=
 =?us-ascii?Q?C9svi5mzQDF0OhlVIVZ+NmC5y/J6ZJdAgCHEfuRGlcOdemoB1ixLwTziorPI?=
 =?us-ascii?Q?1F3UQk4WEs7upRZ9s9TaPTVdNiHu/xJaSk1DvHsawQ80MBGqmyb9tGmHProW?=
 =?us-ascii?Q?8DzFc22j1KHqJAgxa73/KRsw/q/8q1aBDdySqYpjtN/+pmIIT3Oxi+11lhRy?=
 =?us-ascii?Q?r3qeiSpA7NpaCN3ghXiaDq4rFg/mc9EX7D1dXyNi9016eb8f2RzBVASqaBls?=
 =?us-ascii?Q?F4AVqlSJeNoacoUY+tw/MqQC9I1vbuSiZJbm7aoejBfAyVAryXuBdn0yffGG?=
 =?us-ascii?Q?AGVn2OHB94tmA60pNAgmf+89C45XTa9ainC0qytN8alrRbqvHPgg+vVB0DwQ?=
 =?us-ascii?Q?U0HlbrKqqmMwjKETF72gqS37Mr1mpyIJgINDqMhxQDBpjbIL8MS2mgkyRTho?=
 =?us-ascii?Q?WhVcaMMsyc/bCYMmrFAYSq08bLgijj75GL6GWrnusH9UU/qON6sW5jHs7vT7?=
 =?us-ascii?Q?JkMhFVuBxeGxmiV+VKrxp6IgldNim6qZHOwaVFlDTxTYjPLnMz9oYlwwWFbg?=
 =?us-ascii?Q?pMFM8ESyYPhspcUDie0KS+v/tk31NTdb327o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:44:14.3107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b08d7c2-55c2-4dfa-9134-08ddb93c3ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

Changes in v3:
- Move malloc allocation before rng_read

Changes in v2:
- Free alloc area in case of error

 board/xilinx/common/board.c          | 33 +++++++++++++++++++++++++++-
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe74299016..ceb58da6d3cd 100644
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
@@ -712,3 +712,34 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
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
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		printf("No RNG device\n");
+		return -ENODEV;
+	}
+
+	data = malloc(len);
+	if (!data) {
+		printf("Out of memory\n");
+		return -ENOMEM;
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

base-commit: 506757335edcf5e74eac0e608f1835a8b0102c4b
branch: debian-sent3
