Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD33CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 07:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D5683496;
	Wed, 17 Sep 2025 09:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GfYfYN03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5E08349B; Wed, 17 Sep 2025 09:54:22 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803A2833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 09:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSenr/z1OkBldFa9aozB9b3rW3iHe/BRsrAHNOycwcwsShNXTUU6rZEoqtZ8RDvHHjNFfh7L3Wlg+oy5FaYMsi7BKJ53HGjvenSoWCJSCrNygEX8L/h+XnrvJOEgf+Any+jlY6V+b44yISPUuMom+fWwdnpJE7UIdzMH2ChPJDY6etth2f9rscSr60kjnBIOB0DV8edxO99WTUo84yo88TsLFzPY9Ybx+VMWQ2fbxk8dcB/93kjb7cucvlqZmSrWDdWA6ZFVVdiixAzIbI/lJQc5GmFZvZSBONhXABhqfAvgmt1UHtunAQDS6W0FPzQYAKsy2Kw2WzXR0OZk/qokMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0aVnLa/uiZcO+JcLlNyAYhj6C19e3U1CEKQ73TeO5E=;
 b=uukqY6JERmAoAqnwOAordS+EATZU8lQUBMnPISSMLeeEkRhlI1sUi0B8TxmPnbipynXcJQWpAIQsXHk3M9UGwHJar/18o7InkV7AOIOaF6s8yEnQvFvrl1XntAV1gu6Bu8cdECRkvSiyJxQ1Thsj+Sev45Jd6wyX4/+0duH/tjC8RYFI/AGpyYgcGyXcCGFzQgSNsklsMTHrejJGOZDXvFM24nwcY8VLSjC4GlrrhkBF863EULMC/VUTk/6g4TQL6T0HLgwpiHf4am0OgZmZJkUQ/Fta+KR/TU9bf/j8HPk4wc3DVLIsA/ylqDuYslAw3hTNkBcmUgZtfPSZZ2qs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0aVnLa/uiZcO+JcLlNyAYhj6C19e3U1CEKQ73TeO5E=;
 b=GfYfYN03U+MOXBjtLQra0GGDgIF23ff7XPD5IMyItgyb13abu/gp171EoIkaj/gBnXjOtipBG/BbMo2fEYhRGVrUCwEAcMEWWWKUpwDBh+PrP1nne48CCj59iBZZ1W/3MdhlILcesuKu0ui/mi+gjp549PCyGVjTmM65piXJiTM=
Received: from BN8PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:70::25)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 07:54:13 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::c4) by BN8PR04CA0012.outlook.office365.com
 (2603:10b6:408:70::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 07:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 07:54:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Sep
 2025 00:54:12 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Sep
 2025 02:54:10 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 00:54:10 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Casey Connolly
 <casey.connolly@linaro.org>, =?UTF-8?q?Duje=20Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Oliver
 Gaskell <Oliver.Gaskell@analog.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul@pbarker.dev>, Peng Fan <peng.fan@nxp.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Sam Day <me@samcday.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Tingting Meng
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Varadarajan
 Narayanan" <quic_varada@quicinc.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, "open list:ARM SNAPDRAGON"
 <u-boot-qcom@groups.io>
Subject: [PATCH] arm: Change SYS_INIT_SP_BSS_OFFSET from int to hex
Date: Wed, 17 Sep 2025 09:54:06 +0200
Message-ID: <156e2f6f07731efd50688f1e59630b9caae4db65.1758095642.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4608; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AmjXcm37EPmN6F+P2MgIzqINTW/rK/3sEtgntfmP5U8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWScylT4tNPxt2TZvFeloqZuxyrKXxScna4QO3M/x+VXt
 49P/G7J01HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATCddkZFjcyvsxQ37nLk6O
 lQH8Xx5u8lHRP/pH7s1VqeszutmqFJcy/I9ecLPtgk+LV+5hwSzj6S+2Z+0ynv7X8Kb8kVaHbUe
 b7rEBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: e0787f2c-40fa-466d-45fa-08ddf5bf6473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2fRw9iTQBmS3nMnVn6ag8P0E6bK/7Y9qQhbKwxJL3kG6ihvp4WZ3wf50W4uj?=
 =?us-ascii?Q?b5PLP0i8SHcwFgZXeSWaQ4z3mFfoBGstUqsrSpCafm0rO9qNf/QS5AlMz19d?=
 =?us-ascii?Q?kCu681OsjLHxRI83+v5Bm5dUJlH2yIO4V8jUsFtfuNNTGrLqQfIz7z1/zNJ5?=
 =?us-ascii?Q?6Jbg+yvg5+JRhAm+/ApPiYStUzHhCzLuDJbK00Xr/XaPOkQwMrtVlEvkPc1b?=
 =?us-ascii?Q?Fgf/eIkva0cWTwcmu+YYh2FNnS8jWm0pxfRVhtAFDSjCmSu0wTekPm2R9P2R?=
 =?us-ascii?Q?N/vDYqtlFY+xDh1LW3KNH9uPdAL68Ae3CUyXivWfmfP2wN0aS2aAQw6Co+bx?=
 =?us-ascii?Q?Zuf1pOsCJN7pqfd7pgwnxu3LKQOs8+ctEUQTu5C2AjV1I2hvnDhMaLfoOBR9?=
 =?us-ascii?Q?qtWNqyXq4koe95bQrOk/mUf7DqvOooAxjbKeXg/Zu20F8vJKFH1hpX1cC4vm?=
 =?us-ascii?Q?Q5BXp+cqSc7bccHu+w28UXMnfB16kvV24CANnYfYJj+KuEtgdnd2MOaWnz60?=
 =?us-ascii?Q?PxXC1qdzgWfq1lgMiZmGTfmUTux1jfpjKzfOy3ot4RWGHWJtVQc2ay9RfsUQ?=
 =?us-ascii?Q?rJO8wAF20wJJl3ZNfwUFjXJ4XVM15ESRdV0XyXWm7M+Z6IaZ9C2BrWvrPG+k?=
 =?us-ascii?Q?WO8Rs5z+20vQ5UeCCsNtxplosDQZyvdxv7HsY38iywzA0YXYmejPr3pRG3gz?=
 =?us-ascii?Q?AqIlSeXDqERiKVaMKy9pMbGX2TYQfAvUBdH4LXFaBrTskqxLq9/tvz4d2Qze?=
 =?us-ascii?Q?S0D6rzBXY9MHnRo334eMIbT3lLgVSFenIIoouGYIhBw45CJ6lYJ8sjHNbvtf?=
 =?us-ascii?Q?n/RGNenInUWd0pa79AU9MywjyeDXuZ0CDDN3QYSJHiINVfb0dEjg2jnBdOE4?=
 =?us-ascii?Q?y3XilTyx6LV4EfYWeW5YmPsx4e6sOsEd4Nyww5BzE8kr3wedygyoAfz0YuAB?=
 =?us-ascii?Q?3HKzjbdVrVdV8Ko44H36KzXLGD5TpSgp1vRTLQ3ypbsMZPDhHxed/Ivrd5K3?=
 =?us-ascii?Q?7cfWHZwqGAOHYjmcF0RJpzWqdzPn0HJ+FtGG1FcLivH9PZPz7CCPD5vHHuPg?=
 =?us-ascii?Q?5eozjRqIhrzGx2xoPyW/pxRpvmqTd5nHPQdH4LdZxyMAEvD2jZnOGMrH9UZd?=
 =?us-ascii?Q?3qUjzW7J8rGgGQfPyjY9MicR1+qKx16ObgP5vEhDM+Bx+rQTcSPN5XAJ+Yq4?=
 =?us-ascii?Q?Mr3uMlBMiTTShiJ2fXlyV/xgbz3I4+G7t9183t7uL25frydgn0UO6K6FxjzT?=
 =?us-ascii?Q?/pJxQSDJSIMA58uCbPtUhx/9NlVYR/OYJ5xqKm49/xtYTXIwZoUZJEUiYujZ?=
 =?us-ascii?Q?MXYa5U9KYm9B+naA2HE7kXfdjztRucF99HYuAc+vqeGIdnMTyllM9oXKZjD5?=
 =?us-ascii?Q?Jon1MtBhaGG+BWV2WFunO7I4k9uH0v0TdMTI9vO8WcRc8rf/EpUKgM0C4y50?=
 =?us-ascii?Q?4BXsqx2BP0fJARF8ZwHf6MDtUCcB9F2YWObIwUnbbWx7+LmJijet48o25iQ/?=
 =?us-ascii?Q?dR1k4PXDvwoKDg4hWKbS0H3YvhhWv2K7NoCn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:54:12.8866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0787f2c-40fa-466d-45fa-08ddf5bf6473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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

The most of OFFSET values are in hex instead of int which is easier for
layout description.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/Kconfig                         | 4 ++--
 configs/amd_versal2_virt_defconfig       | 2 +-
 configs/qcom_defconfig                   | 2 +-
 configs/qcom_ipq5424_mmc_defconfig       | 2 +-
 configs/qcom_ipq9574_mmc_defconfig       | 2 +-
 configs/renesas_rzg2l_smarc_defconfig    | 2 +-
 configs/xilinx_versal_net_virt_defconfig | 2 +-
 configs/xilinx_versal_virt_defconfig     | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 16db046f4b8d..2eb9a37abed5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -68,10 +68,10 @@ config INIT_SP_RELATIVE
 	  SYS_INIT_SP_BSS_OFFSET.
 
 config SYS_INIT_SP_BSS_OFFSET
-	int "Early stack offset from the .bss base address"
+	hex "Early stack offset from the .bss base address"
 	depends on ARM64
 	depends on INIT_SP_RELATIVE
-	default 524288
+	default 0x80000
 	help
 	  This option's value is the offset added to &_bss_start in order to
 	  calculate the stack pointer. This offset should be large enough so
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 062cae70eb0c..5791f0415c95 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_VERSAL2=y
 CONFIG_TEXT_BASE=0x40000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e774..8d1269b46341 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index e508c0cf508e..3c03e367b7d5 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x8a380000
 CONFIG_NR_DRAM_BANKS=24
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 720220dc98a8..b45ef5041551 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_TEXT_BASE=0x4A240000
 CONFIG_NR_DRAM_BANKS=24
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 401e237a816c..e5b560cf237c 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=16666666
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1048576
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x100000
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0x4000000
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index c13bdb2e545b..13d89c473392 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_VERSAL_NET=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index d8f4b884e766..52142bcc7b2c 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_VERSAL=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
-- 
2.43.0

base-commit: 6846ac4ca29c1156cd8020c19584bc26c2727d58
branch: for-ilias
