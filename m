Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB34EFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E0CB83F6D;
	Mon, 16 Mar 2026 09:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CuJ/Y8MX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0527C83A1B; Mon, 16 Mar 2026 09:05:06 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CE083A1B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5sWMIJP/1DWzH0SH0vBsf0+u+lGG4hFLHmUgweRuCWZfS+dD//SgIqCiTjtmZuueIaHuQMe2OD4MP9ogv26ixh69cVm5Ms+l1Bv+H0uQH6BtHU6B3mlQKl/DyvPVB/RykXHsafY22HWkJ+W5uqM94YxPFD4LEzy1eyp1d49dDLkmj/JiA/QJrgcvuAycckqcXZE8eAM2QT0rJOf+fE0LIB/j3onfFivmnCpxkBIPBv0Kb0kw2N2KNRugqdj3WmVfoGca8JrmBUmfX3J7jFyKbYlhePrzkjMWde+zS5hGZvW7jJu8IWdwTA68bsBVE5cTrlt1nvo11fun9wuv8ffbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTQfvcEqO10zgSV7jKoBuD+GU5Wds755Wm535P1QUlY=;
 b=XpbR+Ox3G6zEXjFIaQp3fcYOiZL87xZkc/W0ZO9hdPUVcZ8jEVWPuL4VWUBzQwEHW5o9VEs35jxl+EST2hnVC9cpzhJtCHCnf4nW4HEAiRhDkgE04a/Ci4s9b+RDaBN0GH5cnNp094mO+EhTQc6FqsqhKPPhirdnXEVzKBRMUqlewtLZxa1DY8eNQoA060ZlHE6h6IDHHrugJlV/8Zab3ny035LPOKtVB2IGh7kTBABhoqgyKIPEIq6woOlijvRlOlbuZ1ri6eWz76KWXWbm/i1LaCASzfQHSO483kr33RWb2OPDaS49qgeA5gdimNsIHd2qAK4fgzoWv5+XOBPr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTQfvcEqO10zgSV7jKoBuD+GU5Wds755Wm535P1QUlY=;
 b=CuJ/Y8MXuoDVykuOTOjMOBj3CCCCK02vVPIywTbWl5aV6chvRVlAU+0WqRIC9DG9WWk5ZC5tgAxP5ddOgl5iJ56w0AOrRl5JXw+L2dFRU0gqMT7qyaV/Q7WsWlwFrR+H+0EbCnVyByCll/+AOiLOD3E1E95KkKhARCZtovQfrC3nehAnhTK8H6lBbVrnJhtWXL258ALMg7KCxac2H7nHSClHj2evCeQwU1f72jwZL8XuZELNtMZn02MWj77471dKU9E7a0bAchOqb72NJu3FzVBrBiJ5dXIvkdcm8DOnRIxXC0/loG4wVzDVKZIpYTg2AVNXvmOqf5JGtu4Lk4+ptQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:30 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:04:58 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Date: Mon, 16 Mar 2026 10:15:55 +0200
Message-ID: <8f6be77bacc6a9abeaf4e9cf6c6f5e01890bc31a.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773648510.git.simona.toaca@nxp.com>
References: <cover.1773648510.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd75094-56cd-4ca6-a340-08de8332b784
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jm+th2jn/rziE3GVjvBVKHAgTAuxWAtpPUr8b65k89W9XWIFz/dXBGpbhn7MuWjBUXAMQsVHI0ZbkH8iBxo45Smb4xs4hJWINM+a1kLj6YXmVTDK21B9EffEp5gWDJdLlLLKY2bbZ+Col9pINeCvZTSojs+TDDTfreQVfO0DZMAoesvMPReWUpeTWmrtYxO5ZB6b+OIArl+j9Me/Z5JMQOyjTz049A2/zND3VnJOmyxGsNygqEMMcNY5DPEhXdxh8y+tCuBelV+SDGWzKHAR0W7V60Xgk8IcZLuvbCwL/3XeWXRFDuvsKKdLh00SijU3ZSFpLhqKY2UTDlQ9KCsyvQfVRTMLghbfs7iBcRju5RtCh7JiTF2GGvehE4z4aUVTAUGSkMYOh4D/mzqAclcRW91T/Z+H+G+uTRuJ++s0Z/BDc3fY2jY6T52+RaF+DTcmIbKfboqveiiV/CpGt7u2whBVCPIe3P7SP0DIfjsX995rXKVLUciKumoRNdYsF6kd9sePguQfSYULR4QfTDEj/cReXL/pc1zwXIk9JgZvHPvH7bRQaVM96LKitsxKKq8M8NJmoWBcNFdR+C7FqWBLKI3qJOoJCQq7F7mmtsl6U07FZ/s3fLB1IWvLzIPOPPC17BiPjp1+F6Uh/Hu/RpH1xO54/1MD5cpdk6bkFrOdi9RdPeIFv1LwMri1F5/cLZfcx6e1dXKQhalryKbWHu4UCHvmS0pLHvBg5o9gnmpVIew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkrSZsRGxqXvE1sqli7bhBrvxQUueyHj9uCDV58MK1MwuQIMtqqT4v+8scL2?=
 =?us-ascii?Q?K5+BMYGxOra9C47FC3HQ1AYE7b577eoQkV+XvzTt6LjwMfVa7i00CN2kOlPk?=
 =?us-ascii?Q?LzXQ7AQOP2/9HXXXLzRHeMpix5LHsxIqMZhSQkbxTFD1oWgIaT771nL4rr7u?=
 =?us-ascii?Q?iD2ZCQ4jI2wPM2Gt+w66mPxRBt9gKVM5snzPaOxgiVLX4xH+yKyM/3yKkc/w?=
 =?us-ascii?Q?7sDbFRfMmlWGJG+R3cpH1fJmoLj0yoFplmp6o5Dgn6Rrr8LSPji9hKo3L1Fc?=
 =?us-ascii?Q?VHBtn1l8d3/ZxcfUCJQ2u9SQdE4y8GE/HP7L/YGRL7jRfSwtsILJvUTB4FW0?=
 =?us-ascii?Q?RS/QwFI/vPhpAxfIX6Y1IPetL9nJ01BZPLnllrsC4eDPuXw/hVoipHBJqHO+?=
 =?us-ascii?Q?dv7JU7bhhI3bmznpdgH1+zMyYj0/FeZd2GCMSFeySn5/T0Bx14gvydSXgW6f?=
 =?us-ascii?Q?fsng+rFrLp93KEWa2YFLsOzbTlb8D/2cDYbl5oEBzfRjvsuBS/vE+VN6NiEm?=
 =?us-ascii?Q?dMToROjbjvUofmWhJyZ5Oe1T0Em+pcyNVCojsETTPw1+KkcrwU/KwMVTtEpn?=
 =?us-ascii?Q?S3kiEj4ZbZesoPC6My8ybXpFu2kAsAgrWKVvqMUirJ/j1cKLjl+5TWkCtno8?=
 =?us-ascii?Q?KkG75LXS1kICrcrFtqAaWWvHJOd4G4531+PstJ980/b3fyMYRzc45dwcNrss?=
 =?us-ascii?Q?FZJzOEQI0wCfO+Sn/3NZzrt2vCXaRwWzxIzmDE+ymb9OpfQsGmEfILLu+EKG?=
 =?us-ascii?Q?YiXFtxBJ6L5Vq7UoLHKYbiD0MfzzpvjocmK39H/3/C7V4twtL41zBKFtwvbW?=
 =?us-ascii?Q?iIODf2ZFitsqBwQYTvxsvOGxXJUBzfUTbnZz3HZTYfKPaaAkthcidjx/VWNB?=
 =?us-ascii?Q?ONgPhJWo7U5hJvXBP8hHGetCSb+F6g6laQCmZ4IU5nt7w4HoiVRNIzbBa4l8?=
 =?us-ascii?Q?hI+Tb/kwKjzMROFLlI8PPLpjLS9Kc42fYlsgNcRXm6jO4y3bivmEncQ0QkWQ?=
 =?us-ascii?Q?AJmAKvjaVkHDW7Wva5Zs+Iqmb7yxewFWBjXVbNxbJ2lKIiqBcwDeivcDpDGw?=
 =?us-ascii?Q?BK0hiuAO31SzvaWA9A3A+lw6aZe5WZ/L5VV37OFJXUed2dLJX+7NaJL0O3Ce?=
 =?us-ascii?Q?xbuJbG8UaVDai+bFt/Sl4SnJ65UISZP/FvEaLNzvud9IfY7QQz9BdjKegetq?=
 =?us-ascii?Q?UszGDQzWG3BA955HPO6BXE/aGnsYTs0dTDHI/i2s40/6zjdqhQCEMM9l/iMJ?=
 =?us-ascii?Q?aiYPA6gnbXjdFCmtITpMXx6/ycGQ7rJvCJexGHA24Z9GwSpMs2gO8uoDErYB?=
 =?us-ascii?Q?n5SAoAihvWpMkahPDMSn47CltyqdcrXQAtItZQHY12zHFx4fzUQNFuI/vaWy?=
 =?us-ascii?Q?9aSRtamHkMb5gRFlHLZMBoQqu9rBDJfL0JD2iK3ivyby5bIletAKGC/d66I0?=
 =?us-ascii?Q?u/kEQ2GviJKTPdbwixpnHXqazh8gQkgTRRGjpEZJPL2ayH3U9/GCrvwtGWas?=
 =?us-ascii?Q?fwoq9iCJ1bkiqOyBJE7wDU4g2/eTY9NQ6VCyixUe+VDeFI/P1KAa/x+jYW19?=
 =?us-ascii?Q?ByTVpahKR5lxqwATou69iHAHGwCG7zg/5KePOWA06n7fno95gwpvbw8GBsjf?=
 =?us-ascii?Q?pELVhXfjOkFwKKe6/hlDECy49PEVpYckCc4BQeqw9eY8w1zVrY/MEPVtMBY6?=
 =?us-ascii?Q?WmS9TcrdMWW0qfs2EwLWiScRRXpu/jXhGRbEq+dgsEEplRCJlGbIn25S7SIM?=
 =?us-ascii?Q?IMxvaf+7CQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd75094-56cd-4ca6-a340-08de8332b784
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:04:58.6007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMetaEWd3fFPpALXRXQImMYXPVSyqkq8X3Y0DYr82uc8Txa1KhlIsDKD8AToQBvgeKvaPXCreayIDWKg8HfZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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

From: Simona Toaca <simona.toaca@nxp.com>

Call qb save automatically in the board-specific
spl_board_init(), if SPL_IMX_QB option is enabled.
This makes sure qb_save is called before any image
loading is done by the SPL. This option is also
suitable for the case where U-Boot proper is
missing (Falcon mode).

qb save refers to saving DDR training data to NVM,
so that OEI runs Quickboot flow on next reboot,
skipping full training and achieveing a lower boot
time.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/include/asm/mach-imx/qb.h | 2 ++
 arch/arm/mach-imx/Kconfig          | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile    | 4 +++-
 arch/arm/mach-imx/imx9/qb.c        | 9 +++++++++
 board/nxp/imx94_evk/spl.c          | 6 +++++-
 board/nxp/imx95_evk/spl.c          | 6 +++++-
 6 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/qb.h b/arch/arm/include/asm/mach-imx/qb.h
index 5efe68f0a60..4f923d79e7a 100644
--- a/arch/arm/include/asm/mach-imx/qb.h
+++ b/arch/arm/include/asm/mach-imx/qb.h
@@ -10,4 +10,6 @@
 
 bool qb_check(void);
 int  qb(int qb_dev, int qb_bootdev, bool save);
+void spl_qb_save(void);
+
 #endif
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b199a0419fe..614829d1587 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,14 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config SPL_IMX_QB
+	bool "Run qb save during SPL"
+	depends on SPL && IMX_SNPS_DDR_PHY_QB_GEN && (IMX95 || IMX94)
+	help
+	  Automatically save DDR training data (Quickboot data)
+	  to current boot device when needed (when OEI runs Training
+	  flow and saves qb data to volatile memory).
+
 config CMD_IMX_QB
 	bool "Support the 'qb' command"
 	default y
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 7dee144e0f4..3207013812a 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -15,7 +15,9 @@ obj-y += imx_bootaux.o
 endif
 
 ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
-ifneq ($(CONFIG_XPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_SPL_IMX_QB) += qb.o
+else
 obj-$(CONFIG_CMD_IMX_QB) += qb.o
 endif
 endif
diff --git a/arch/arm/mach-imx/imx9/qb.c b/arch/arm/mach-imx/imx9/qb.c
index 9987c57b16a..e00d2fd7512 100644
--- a/arch/arm/mach-imx/imx9/qb.c
+++ b/arch/arm/mach-imx/imx9/qb.c
@@ -428,3 +428,12 @@ int qb(int qb_dev, int qb_bootdev, bool save)
 
 	return 0;
 }
+
+void spl_qb_save(void)
+{
+	int dev = spl_boot_device();
+
+	/* Save QB data on current boot device */
+	if (qb(dev, dev, true))
+		printf("QB save failed\n");
+}
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index cc5b7f9ef0f..1d25795eb17 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 /* SCMI support by default */
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 761a1a4a0f6..35e4458f2b7 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -13,6 +13,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,6 +42,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 void board_init_f(ulong dummy)
-- 
2.43.0

