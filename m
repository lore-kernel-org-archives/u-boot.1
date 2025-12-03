Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F1D1266D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 07:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C661A83F5C;
	Wed,  3 Dec 2025 08:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJp0UxB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F2483F61; Wed,  3 Dec 2025 08:37:17 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4F883F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 08:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5TODE1XVDfCkFRvCgzgNAo0eRJLsHraejuukCvxProyGIQc8yqsB8OcOeT/HaEqr5SYOzNY8dkJ10RycRvzNQdoezgdVv2r3MT0CX2NpA+1ylJRZ5mNuQtvfhxva0MnKHKdXd3xS9gyi5y8Bb9q/jG2JIxMrLvCkV3IyYmCCuyEGeT6UaFtK8wy0DeMgY714REaNralmanORVrpEZETdHI/4m2U1wdz7F60RaioTaSCjKZxlBqJxsp5J1gKm7ZRkUhEgGv/CKKwDqMF6aQ+6dJOIBLYJA/cVXXPtqkiQGMbMptKUlZm/cr6r5hry0vPl5tfaAq/TfZT8+VKAVnfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY0oDXhZ/VUJ//oAXKu0CiLeXDsiuLDmjO3Xxzk3vss=;
 b=qHV8P7fibKO283rUh2IIa6JidyAcKZMqVL75EZ4BAYIPYGy0kKmz4jkiIYY4RBrVqCEAlyBTjSVDpfmJiLXp40D55Je6E0hVpIJPDQl273DivcmoMzHB/ed5O4J540Qu/Mj2x8UULtSRyvIUQXMsCCLlVNfMQQlm6yNL4zy6T+aFY8wl9CXWfU1HTBQ6ierK29JAg3dDeXNrG/QIBsr7kLNd84e7uYuca7vp0kdLSaMdVpDHoJEKWMogaDXDtVYqyJE9GqiccRfD/7NaH39lEi91Phfx1Xv+7CNXUKVuQbpbW0PDU5YFVj1zaZuZwpqHfr9XzYGApYTxzGERKSUjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY0oDXhZ/VUJ//oAXKu0CiLeXDsiuLDmjO3Xxzk3vss=;
 b=sJp0UxB96BWgayXQlM1Gj4Tt2ttsed3r43NDiZzdJ/bptR8fSSGyv+IIqg5PexWUUxSWRmJ4GVKTYxBUeqAfEjPeFUOIHb2m6doDFG6pzbRyF1S9/m7iwaQFet3ETooArSXZ9MaxKHvPQC5HlabYJGs5vrEaPOkk8mBiZsLNlLA=
Received: from SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::35)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 07:37:10 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::63) by SJ0P220CA0019.outlook.office365.com
 (2603:10b6:a03:41b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 07:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 07:37:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 01:37:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 01:37:08 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 23:37:08 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: xilinx: add SPL boot device support
Date: Wed, 3 Dec 2025 08:36:59 +0100
Message-ID: <a1f26a9392128309a1affed28b14809845714c21.1764747417.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0GjVQRxaaoLVJASaZQPzKWTDrUXYb+bs+jKiY7SshNM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTqv5hz/2nx2SV7MqOKZ7sUW28UlH6re1d7wnGlim3Lu
 Q9d3tLT2VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATWXuIkWFttxn3s/b0l1qL
 ps9Z3cNQdcX0/zXB1+IbhT7tc1pQbfua4b+X9Mq8FH4n9aCt/7cuP8sez1yXkMsase7J/qm8myt
 qHjMDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5752ef87-0136-471a-2ffb-08de323ec4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ohvB8KLExdWIb7u9fU5TbHkxAzJXxRuYUD0kwGvYpMAcz6G1NCaFbBCD3Yva?=
 =?us-ascii?Q?T9+HKeYrh2L3nJN9fXRLCyfwpia9dQTUZzdODAjlBg+rdDcbi3e9SPN8tzKJ?=
 =?us-ascii?Q?Nr9eQvvWqpU51ui0zdxQpZjmmOIRVsqOLDwFJyVag+07hzxkzsWTMdbziog8?=
 =?us-ascii?Q?UuWU0tsRmuDqt4rr5LFjt1/On4FYl3S8lG2syHmCDuIK1L81G70vB7ZWJKhl?=
 =?us-ascii?Q?RVCJjUxnjm8y2hAGneAC09XEeLa1HRUPsiOoh/ZrHDIsiqueUdcKT/88msqC?=
 =?us-ascii?Q?Yge/tOm1skDX3H5TeDkLMukU4xWFaxHftYuSPyptvJtVkdGoko3GY91TYSLD?=
 =?us-ascii?Q?mxCNcuEpBCvxKQP1Jb/4qxjoINwzrHa2cxffZl/8JfuJMRuCHazYtRl5EdgZ?=
 =?us-ascii?Q?1n41Ag8VA9e1gjccaY1tlv617zyt/TcMr9YLiQtU+hAoinNE1YQpyd5ZKFAf?=
 =?us-ascii?Q?HfWa7LFNC7nCSukt2h1P3uOUVbCxRennqbLFItzneCZIvbtHM7RTyJly04C+?=
 =?us-ascii?Q?pZuDiDs5zoaaWbtyL96VtTBsWyoEctdYX4iwlQUggTAHOGjb/Xe1r4Wp6hqt?=
 =?us-ascii?Q?I0x3ETByHnpUltnVG0f0T/kA6irN91UQgdOsOI33IIBAoetDog3akWBUlefm?=
 =?us-ascii?Q?RFDllMdR3gWoPFORp+OA/jrEHsSQ1Oxz0yGrxZIWj/x2O3ApWKIiab5S8b3I?=
 =?us-ascii?Q?vqRi/DmaLghd2Zp4Hj2uBYOBY7/x3TQ+qWq8zNK/rJFJTY+Kb3GOw/J/kKG1?=
 =?us-ascii?Q?F0EaOM8uZ4MDml7nfFJ6vQ8/o1TvdoKqiDqZmP0SKLsoLH8OWGm+DHEHvGJZ?=
 =?us-ascii?Q?Kp4p+L+m48ihQDPqAdWsQzDJ4MUUxbMvXQrAgI29wwnqekidHmJV/jU55zZd?=
 =?us-ascii?Q?cEl7QMkHCFCb5P3jLZ7QK6MMdSSrUbw+4/oPRfZqbdszH+XdIxrPpjfn0M1Y?=
 =?us-ascii?Q?GyPcrPMA6COLPJ+OVpjO5RYQURq31hfnoBGjqnOB2lV/dZTjX1XTbcV4Lps/?=
 =?us-ascii?Q?ENqInT2/2qnIqzojZFQlOcRJV0kKsor+XmH8ffneELz3gAdBACJdxyueTnP4?=
 =?us-ascii?Q?xV+rrvK6pSWqqBE45+XPccllcrCdjoi7MjjlO/VICt/WRyZPNr5FzMda36Tw?=
 =?us-ascii?Q?2iKeIynBwM3atm1pq9gZMaoT0qoTDabBFipMbTE+lWaNK1iHMoNIwakNLqw/?=
 =?us-ascii?Q?LdpxmfQhnJKeP+M6OIP73IF6fa+wtK+eXnBTHKgcdRgdWgZUx2Ln3uglaIun?=
 =?us-ascii?Q?THXzKh44Ob3JTLTHtAkTxAnzJBIjjIMHduYMhxTifhF2BFcNbowD1IiPQQkP?=
 =?us-ascii?Q?Yg6HLJ7/CMPBwpVYrTdPUP754nRRybZRfZdoqCUVd4FfJr9QZngIKqseDzD+?=
 =?us-ascii?Q?UUwNT2E2Oo718ilxIHd0yrfHtbWOpmwNttS/YOGbNhR+9MLwc7juUivY+Uej?=
 =?us-ascii?Q?xDQndVJTsqrtNZbfCOG1mMWNcVW7pItQn1QrkJwCGt7apfEGyQtI6NGdf9wn?=
 =?us-ascii?Q?XJLIxLwYLc6sSkpQaCIe5aiRErn0lsEhbkl/xYzMKQG7EEC+/CEMMXqeKJ4a?=
 =?us-ascii?Q?PqLjQEsPEbk6MubpSKw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 07:37:10.3694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5752ef87-0136-471a-2ffb-08de323ec4d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
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

From: Padmarao Begari <padmarao.begari@amd.com>

Add board_boot_order() function and remove spl_boot_device()
function because it is called from weak board_boot_order().

Add support to U-Boot SPL for booting from RAM or SPI, as
configured in defconfig.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/mbv/board.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
index ed3fe16af7b9..2b0005955ca5 100644
--- a/board/xilinx/mbv/board.c
+++ b/board/xilinx/mbv/board.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -8,9 +8,15 @@
 #include <spl.h>
 
 #ifdef CONFIG_SPL
-u32 spl_boot_device(void)
+void board_boot_order(u32 *spl_boot_list)
 {
-	/* RISC-V QEMU only supports RAM as SPL boot device */
-	return BOOT_DEVICE_RAM;
+	u32 i = 0;
+
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SUPPORT))
+		spl_boot_list[i++] = BOOT_DEVICE_SPI;
+
+	if (CONFIG_IS_ENABLED(RAM_SUPPORT))
+		spl_boot_list[i++] = BOOT_DEVICE_RAM;
+
 }
 #endif
-- 
2.43.0

base-commit: 6eaad47c30990ffd230d21c7158bc7234cda1752
branch: debian-sent3
