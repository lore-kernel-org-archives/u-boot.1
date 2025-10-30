Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA25CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A96838C8;
	Thu, 30 Oct 2025 06:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mBgENpcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A60B836D1; Thu, 30 Oct 2025 06:20:00 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F0383914
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6XJy1U7y3Dx6YcBCWqGYG0gjfIww5YzGZ3dQ4jpVZW0birDboSEx4xDAnLUAfKfiJGqZlCfAIxPRh/rzvgNmmH7Pw7TZYO/B5ihgHMFIeWbwi1HTot8ewPN31A74C9bjY+ONuD3U1UgzwERm/LtOZmobC//pwmvBNRB2rpFUvPdpuXpOPb66uYFL/wwnsgYh0AK8+8WM4NQcSjeOO94c1U1h9R3au3GrBvhfYz/vieoMvKBoP05/q5h/QwlbpH9t+xh/uQ5kjhI/97bkJgJX2bnpec9+o8/2jyFmHsd166Y96GaaKMtTIIBwC3rv+FbmZDmcehNu5dQ5iFIgUZv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na64V0uB5WF3T743/95NDhvsyJC4Nba2wsuj1Piqx/U=;
 b=ZFF+CO13OW34MWT/636cwgvYyjECGPjEFZNkDXr+AwUWYghL2NCgxoP+YNNJ7E4vLwxgc73hRo+xCFQK2riUoa/KCiqG1a2+E37IyhLB1sERp4caOIKzu+S9J/yp3D/+bmq8n6nJNfKzdGxGgfC+8U7XhOFpy/neK9LOZKWOySifeiEBuLTBNZBARh+sfXR36VmfJKaPq97sBTaT9Z6096WLi83AbQPntm20D5mvF/hOvhGWPL1zV27lG+begCclNkYaM+KUqz/o+A3L/Wrl22yokhDdQTOR3dzmOKcheCpI4Us7NfTm3EmvW9bmLYEgUGvJ3H3c+vMzc4xxUaUrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na64V0uB5WF3T743/95NDhvsyJC4Nba2wsuj1Piqx/U=;
 b=mBgENpcW9lQXQnXbltUcLSyl4ry57uz5n4s6tt1ULPr7cG3Ru09fQGMnYF6EfUgqJUi+wo93YNt6Fmbid4mSP4JJA5lWG0qDysRP8H2A482h9Ul+ghg4+qpyM4sFDo7Da6BL/a2aZUmMee/hKoYbswZsFDkoW2PYeCYTkEMSo8o=
Received: from MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:19:51 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::7d) by MW3PR05CA0030.outlook.office365.com
 (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 05:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:19:50 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:40 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:40 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5Jdjs1446078;
 Thu, 30 Oct 2025 00:19:40 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 0/8] Allow falcon boot from R5 SPL on TI's AM62 devices
Date: Thu, 30 Oct 2025 10:49:24 +0530
Message-ID: <20251030051937.3659010-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fac4730-768f-4373-c908-08de1773f391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W1KyMpat1HVuy2Yrz7cfFy3QDN+HXPJtocGwTLHdrjzGyi0Wg/HiIg6Ltx8J?=
 =?us-ascii?Q?7wCibqDQWJ1thdt2j6aLNsMaglxNcYvvLEiKJLQTPuU8wGk4Hj4QRHy/m5TW?=
 =?us-ascii?Q?IDyR4doUPZRzc20Dza4yEYZox8t/4UBwAbxymG/OnOw6qUBeVkg4KC6/4xGg?=
 =?us-ascii?Q?0yHti0pJ9X8EKFYp4r8DEAjvoOLoe3W3q7P8ui2vhaWWN7pvYwTc5HXtGkx2?=
 =?us-ascii?Q?IXvvC8ya9Pn4iEpnDLT1mR2kxxHtZK69laBX2lxECDlPhjDlHLAn91KE8NfZ?=
 =?us-ascii?Q?FavQM8NgDS6eAuH9tcAtVZ9sTTldvpZ7imLx/VPtOKv2PwGSDNDztXJcO/+V?=
 =?us-ascii?Q?C14nO85PT1boPmaiOy2HKanhPRB2AzbQBBgXbPnA/P67BXjjz2xuKPCxX/vB?=
 =?us-ascii?Q?+aM9VaRK6HruPq5zBSr6xZ7V6IgwMxzv+l4DXA163P9HC+mnBipnxwQZb9h0?=
 =?us-ascii?Q?it+h4CkBHw/lTDjg1rRUJmwruJZf+D9277d9XAruEq6qSvVil8pj6mTXzoo+?=
 =?us-ascii?Q?FQCryAF90swEs6uMgru7wOVGD3KhG2PoVKyIGimLz1JQbHXrtPGHgdEmXKwo?=
 =?us-ascii?Q?GGRhh3d/qQPLeq/yiJH72XoRA0RjqJ7GtvqaNpQWWFmH8I7lWwmLLr+3PhVG?=
 =?us-ascii?Q?JJYcVTYNsf2/g6qFEsUdGRd+2I3MwFRSLAUD81IU7pxBJ5p81XPYmgQKjzo7?=
 =?us-ascii?Q?HE7GHJXoPzMktXtRuV/Y9wbq8hxQEmxKtPXbZ/mMMnMSS4M8MxzLwIEWVkuz?=
 =?us-ascii?Q?2rWwEodaOfkbnC06jK9o4uo1DocHaBASPy/dVJfrQDrbwapxCubHHqCscOZE?=
 =?us-ascii?Q?nNCJAUMHkmaGt+J6p1ObZgMpTSCnsdqgJ6YdQ1Z+hGasl/5jtxaRFUjG5CJG?=
 =?us-ascii?Q?sCFt0h89RcREsvUtqZE6MiTm2EbODKRZxNZt7bGTFqMqq71VczoJosPks5DF?=
 =?us-ascii?Q?FN8+8ZwJ3jhMaoDLHMMO3Mld+0xAcJKun16FvCGzukrEi7AoTlwFnO1PD4AN?=
 =?us-ascii?Q?82ojvOTCER97oo1wFbXIpS9OIop5As1Ji9JK0Ky6YlTjCLPRx8HoVdHzM8vl?=
 =?us-ascii?Q?rjxn3rejyKuw/0snQYU4ydp3IEXLHlYqCW/JFJm9mJ5fesKmk1Wav3oFif8/?=
 =?us-ascii?Q?pF65yE2cwZnG01rc+Em6PWOPUHIpNIfIGzBkxq6H5h9R19AZo4yx0KxiJpiB?=
 =?us-ascii?Q?xlCCyUmLhCOhurtgJ9eHP9U9F1Az3wHMJK2lzxnO59DVFAsEyRWQHqdHHdXu?=
 =?us-ascii?Q?G+FHVkAL31UbJ8KnszB3+IsjX9ziQmehUnBgEQpVuRoOR/cMNRn/YvxVhCo7?=
 =?us-ascii?Q?RQEf4cs4FSyZ0K8scWJNCEK165RUKipdFSIw8aIfBHCWpxcWHRWbPToI6SBb?=
 =?us-ascii?Q?wKPD05/Qyx4T8ZmKYqrCp4tfY1P6ASO5FKmsqq6rJM+uVbmxF0+qXTS0kfYY?=
 =?us-ascii?Q?kWV5+sCVYYb0K1QIomkMSXcf9giuCC1IUs4IX1XeAR8jsHgYjokrTZ4Y2ett?=
 =?us-ascii?Q?+zUeRM0Hpp1ZFfoJ3poFE8e4npMWjvLXaP3w93HPqP4XkJp2RhsD92de4TxP?=
 =?us-ascii?Q?ONQr3Gw/Ob6lGgjhWcg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:19:50.7426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fac4730-768f-4373-c908-08de1773f391
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
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

Hi all,

This patch set adds support for falcon boot on AM62a, 62p and 62x by bypassing
A53 SPL and U-boot.

Existing Boot flow:
R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel

Updated flow:
R5 SPL -> ATF -> Linux Kernel

U-Boot's falcon mode expects the jump from SPL to kernel to happen on the same
core which is not directly applicable for our heterogeneous platforms since
ATF, OPTEE and other non SPL binaries from tispl.bin should be loaded before the
kernel by the R5 SPL.

So we have to use a different flow to bypass A53 SPL and U-Boot, we first load
the newly added tispl_falcon.bin instead of tispl.bin which lacks u-boot-spl.bin
(A53's SPL) and the corresponding fdt. This sets up dm, tifs, optee and
atf. Once loaded, we load the kernel and the dtb (with fixups) at ATF's
PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE.

NOTE:

Since we're now using the SPL to load the kernel and kernel expects a 2MiB
aligned load address, the existing PRELOADED_BL33_BASE has to be changed for ATF
to 0x82000000 with K3_HW_CONFIG_BASE set to 0x88000000 for the DTB.

Depends on:
  [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
  https://lore.kernel.org/u-boot/20251024081408.1610102-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v9:
 * Update the boot flow diagram in documentation
 * Refactor the documentation diagram into am62x_sk.rst
v8: https://lore.kernel.org/u-boot/20251027130004.2156121-1-anshuld@ti.com/
Changes in v8:
 * Base the series on the recently added support for secure falcon mode
 * Split the [8/10] patch of previous series to multiple commits
 * Move R5 falcon mode logic from k3/common.c to k3/r5/common.c
 * Load `tifalcon.bin` from rootfs even in raw eMMC boot to simplify usage
 * Drop the section on 'SPI usage' in the documentation
v7: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
Changes in v7:
 * Replaced AM62a/p documentation with a hyperlink to AM62x's docs
 * Made CMD_BOOTZ disabled for TI_SECURE_DEVICE
v6: https://lore.kernel.org/u-boot/20250428141235.1734014-1-anshuld@ti.com/
Changes in v6:
 * Added A53 build steps in docs
 * Had git add SVGs as text instead of blob
 * Added memory map for standard boot flow
v5: https://lore.kernel.org/u-boot/20250425145644.2228186-1-anshuld@ti.com/
Changes in v5:
 * Added documentation
 * Moved address for kernel and dtb to 0x82000000 and 0x88000000 respectively
v4: https://lore.kernel.org/u-boot/20250416074515.1452854-1-anshuld@ti.com/
Changes in v4:
 * Move emmc boot fixes to saperate patch
 * Update load address for kernel to 0x82200000
 * Add jump_stub config
v3: https://lore.kernel.org/u-boot/20250403215910.1292922-1-anshuld@ti.com/
Changes in v3:
 * Make tifs load and entry address consistent with tispl for am62a and 62p
 * Update loadables order to be same as tispl.bin
 * Use rootfs for boot instead of boot partition
 * Disable SPL_HAS_BOOTZ to save space
 * Add default dtbs for each board in Kconfig
 * Fix fdt totalsize in the header before applying fixups
 * Update Makefile to clean tispl_falcon.bin on `make clean`
v2: https://lore.kernel.org/u-boot/20250311095758.3383047-1-anshuld@ti.com/
Changes in v2:
 * Move to CONFIG_SYS_SPI_*
 * Remove the need for CMD_BOOTI
v1: https://lore.kernel.org/u-boot/20250307075541.2571104-1-anshuld@ti.com/
---

Anshul Dalal (8):
  arch: arm: k3-binman: add fit for falcon boot
  configs: add falcon mode fragment for k3 devices
  mach-k3: common: enable falcon mode from R5 SPL
  mach-k3: common: support only MMC in R5 falcon mode
  mach-k3: r5: common: add fdt fixups for falcon mode
  mach-k3: r5: common: add bootargs to kernel's dtb
  Makefile: add tifalcon.bin to CLEAN_FILES
  doc: ti: document R5 falcon mode for AM62 platforms

 Makefile                                      |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  64 ++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-binman.dtsi                   |  54 +++
 arch/arm/mach-k3/am62ax/am62a7_init.c         |   3 +
 arch/arm/mach-k3/am62px/am62p5_init.c         |   4 +
 arch/arm/mach-k3/am62x/am625_init.c           |   3 +
 arch/arm/mach-k3/common.c                     |   8 +
 arch/arm/mach-k3/common.h                     |   5 +
 arch/arm/mach-k3/r5/common.c                  | 145 ++++++++
 configs/k3_r5_falcon.config                   |  39 +++
 doc/board/ti/am62ax_sk.rst                    |  31 ++
 doc/board/ti/am62px_sk.rst                    |  31 ++
 doc/board/ti/am62x_sk.rst                     | 319 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | 180 ++++++++++
 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
 17 files changed, 1274 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_r5_falcon.config
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg

-- 
2.51.0

