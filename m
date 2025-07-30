Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AD3C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B2B82F00;
	Wed, 30 Jul 2025 17:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ImivxTmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB5A8091A; Wed, 30 Jul 2025 17:42:32 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::713])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 084428129F
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBoeXHjEMDh4AbLBPps3mznN5yUczpW2ruL70MxwzAKA8GDo1y+C4p5v/0z8I/UvFcBmrgHKjwBHsVrjyObi0Y1dmht4wnucZyjQOnntEZeSqX5N4EnBHNPittP6nMYaEaZxrgNfYSntNhSwmkU/7i/SqgBlj0NfeIRpcbUPGzoa/uYxx5m8Nd/zkSFM1KY2RtN0bWkobPeW6L5rn60SjU9Ka+ckk1NCTaX+TBjyTkBsHC6NdDFOugX2VcYD2qkNrw3CxAc4w+lihuT/ppLpRJ237ALZtnj8ld1HUqhZIQl0qA3fK0dRgyGhnoBwSyW1WYwRA5wbmmI4LidG5yIWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2kuQegFG6nJGUNhomzjNX74c/WyQ4IGl1YPgEajqko=;
 b=HC3e97EaP6kfe1+w5OUkRCRFB/VoBxR8AYP3BIF6LRHPEPvV8seUb+8QkQHHfZ38AsDIMS1ZBSFr8KkZAL+49ZNxD7FI/e7Pa+og2pyeWi7WoUnlnrzAqaxAeuS/VzzNicKGmoKW2Fwhq8DdVWwSXariO6gn8L3q5pxirZpHQzXRIJVnLaSstgOokrnuhHgu609+tG5nzep1j1yvlEOZ/Sqghz4m3XXOpHWSVCzsczybpVAKu/9p9G0TowgQcHL/WW2RXxNSI9z5xQV1+7uLDn93IyjPLcc0ZADZGQ5Vy79RWLbTHTCLFjrDvV/AY52G+3+Q+ferH9Kpk7UAJHnKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2kuQegFG6nJGUNhomzjNX74c/WyQ4IGl1YPgEajqko=;
 b=ImivxTmidZDIplJNzNQFu57IVeYhEi8WsDvry0BigQl3LDV4Blpwop+M4mLtbJH3d3ACFHhoQ/OIFgYN9gazCWqWOT3SuVhlLf4VKLnhJz3O3rQY2Se5QrkbdR23qU7Qgo3AVqynztAA4bn9KuxkyVwmF8oet5fbe2OBDvzuS735CDMzrNAgD0dag/zlzz422+bZulDkHcpD+LepioqV/yy/43JWdH3yJeoJFPRsXyG8q07GahYz8nAeMPlgvIh6DDqxe8naokwApIQq1TSsBIyPKQZJ+g4I6bTjEI1yWTUJtPexF3Sk9jpQcsPTSwK755mHmz4A7h+dTgxxfFZMmg==
Received: from DU2P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::30)
 by AM8P195MB1089.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:42:27 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::80) by DU2P250CA0025.outlook.office365.com
 (2603:10a6:10:231::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:42:27 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 30 Jul
 2025 17:42:25 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <ggiordano@phytec.com>, <bb@ti.com>, <d.schultz@phytec.de>,
 <nmorrisson@phytec.com>, <joe.hershberger@ni.com>
Subject: [PATCH 5/7] board: phytec: phycore-am64x: Add watchdog start to
 bootcmd
Date: Wed, 30 Jul 2025 17:42:15 +0200
Message-ID: <20250730154217.1116751-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AM8P195MB1089:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c18789-23eb-40a8-f04c-08ddcf7fafdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?laoO/R+TK3aOk+FuQgdm+xXTs0zlIR20biu6xIJSpLbUOpIS0PDF4sv+WXNp?=
 =?us-ascii?Q?jqZj6S0m0HjxMZioTgqLbTpX0lbJd/ibTEdnFryTSMzkHW8wgAV5oQ0FhzbT?=
 =?us-ascii?Q?0zkB9VPEAXKeLOHlB6jCNQ7cSSZbt6Z6mAREyH/w7D2Nd7boGtFN2u69UndY?=
 =?us-ascii?Q?yLZ0g8Q82SOt7FW3CAsm6uyXNjMwcTtFVd6zfIzfbr4fFXrLhpkUooBsBHk5?=
 =?us-ascii?Q?PfEX5rmWjaUwnCgAVbalfQeNSOBs9znCtAjl1DFoJ0x/lpVcSy7i/RZRDjOA?=
 =?us-ascii?Q?DuCsAq083jts2PDPbWtEENWGxCFsmNx8+ctC9OJUJCapgyc1yScxo6AsU1p1?=
 =?us-ascii?Q?1MHezdGcD3b3dp0Ra24bh1DI8YVHZgumMsiFJNmSYZLxxNTKrN/McJZE6oMy?=
 =?us-ascii?Q?2EYQlI25PsHeSbi0haEvOojo62oE7w06tNzBIBmUhdzkVGXaA06OFUZ+4+4Y?=
 =?us-ascii?Q?2R+uToTGazOFgY87j4DRCYACTt8Bw1pni5RHRZsGZQZiT5jVgsvf3q6VrtQW?=
 =?us-ascii?Q?bTyY/JN7CfBsNfadXmQdgMbSjT5am2bcJVfrEtPPgjc5G4mFzTG+fpq4K8/w?=
 =?us-ascii?Q?zhOdG19xN3ctyRlXoq//o2DxZvcXLv+r8f40bhouv7w2x6U+rN+H5ddzK/ip?=
 =?us-ascii?Q?j1uHZ8e7AL9PWCfKyz0TOVJ/jncJVZApsuMZJlQUplC4Tc5Q8lR8qj5lXOfX?=
 =?us-ascii?Q?873pAOPIgr7q8mVZ3qxIUzHWk5L5Tqk3DkXybB1NUoipXFQMF38Wlqw1oLXi?=
 =?us-ascii?Q?57cLB7dKI8nJMzrmtEGbhR6qbJ9snh03/HQUi9BmmN3RfxKgu1DJE+4MNX7f?=
 =?us-ascii?Q?q8WKpJ+S02AEbtiGrmLD7vE5EA6QOPpcNmdY7KUXmdoiS0VDf+GMtJe+N+M7?=
 =?us-ascii?Q?Vpgz8cDp0goNhKTIyOSaxJIITgww6JE+dLTslpLERmYtgv9xfG8q1cODmOvY?=
 =?us-ascii?Q?p5JuAXERWzkjwcyD/U7qhqSKoq/f8NCJXG7ZpSs8xX126ZCOSetaP29+wLz3?=
 =?us-ascii?Q?aUs2agTKXH2rYRhQLQH+jpR2D6ac6SDWSsTh2gBQhZoHCJcLi4x5MUdwFo58?=
 =?us-ascii?Q?WZljvTERtN7FTH+TcE7iaxzp4Qj05Y4L3qfmupiTU3OgtF+3CxzivlgiWHM9?=
 =?us-ascii?Q?L2ymcgJmOYrCcgaxtlkDXHym38+aH6W1n0+k2467G6Sl1Ib3r54BZtl4EeCG?=
 =?us-ascii?Q?Q6saSOG9O25F8eRsORXSkkM8QOv42i0M5VEQqLcWe8f7+1uZCZ6SkDY9uQBU?=
 =?us-ascii?Q?YI681mOgb6jc9S07AhwVdGxTjQ3FTkva0QkhCHXlPhTKbh5aonykuOxR622r?=
 =?us-ascii?Q?vutkOXwxDIQC0n6rfvFAsF9b1xWBFd2AQigY1MKYiKnFN/BWzZm2QNL1Rfcn?=
 =?us-ascii?Q?lT7ld0gCMNdKQG8naSlYkA3VA4ur0KASeWNHeLFPp7oJxhHP5RPlpb6RByiB?=
 =?us-ascii?Q?xERFLisYy1GhjSas+UkHTB278AARFSwowkC3ONYZhQgUaT6TpC2V1o/5e4Jx?=
 =?us-ascii?Q?D6bSqBebBGeQacZeSvXX+JSzeGipwbEPghYU?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:27.4048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c18789-23eb-40a8-f04c-08ddcf7fafdc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB1089
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

Allows run-time control over watchdog auto-start and the timeout via
setting the environment variable watchdog_timeout_ms. A value of zero
means "do not start". Use CONFIG_WATCHDOG_TIMEOUT_MSECS as initial value.
Users can enable the watchdog to monitor the boot process until userspace
or OS takes over to serve the watchdog.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 3 +++
 configs/phycore_am64x_a53_defconfig          | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 36ab16e2f7a..3775a27c1a3 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -1,6 +1,7 @@
 #include <env/phytec/k3_mmc.env>
 #include <env/phytec/k3_net.env>
 #include <env/phytec/k3_spi.env>
+#include <env/phytec/watchdog.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -26,3 +27,5 @@ spi_ramdisk_addr=0x2200000
 
 bootmeths=script efi extlinux pxe
 boot_targets=mmc1 mmc0 spi_flash dhcp
+
+watchdog=watchdog@e000000
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 62c9eec971d..cf1e9061f3c 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -39,7 +39,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
+CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
@@ -77,6 +77,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
@@ -182,4 +183,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_MASS_STORAGE=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_K3_RTI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
-- 
2.48.1

