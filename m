Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01777C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9D280FA1;
	Wed, 30 Jul 2025 17:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eYnXyFcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642E482E34; Wed, 30 Jul 2025 17:42:34 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7E481E06
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVD2nUMN9kXs5fCNl6aTNs30zfUvTkF8v9qInepIKshD/5nIXQn07ECMriqc9XbuC98drF0YiibbSMqlUPPEZku+fT4iz7pQbljauPEYJJKzOPKMm2DokUwWsgb8gXTg2TOYkkm8TMqL0tb27sRH9fG1ekPH33vrbaIbe4mnHLmXxN4lku1IZS+kDnhkNoSQkU9MWAwp43kaEDRuvT+o0PsZJ2/1HF5rqOZmo6qlmegOj3tai8y0aE7pAs0S5KOx9n1qwxX2gKLl7iWUSFD5lY9GVqRx87n6PO1q4oLGYLA6X5K4tZUQQl6C8/dRd6n10LzjIiMxcJeOmJn/6YcyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXQdOYwsrjZe8nRa4AdfXiAti3lcOZI2488Zf6qHdxY=;
 b=UqSYHKhc/hzd8rQVplJNcozHscUCh/egJFk5i2hrXbzhEgBqeG9kKxj0zdDitvDo1V+VYnN1BeigW/NyNPjbNEkWfo5bRjCeXzOS3K9kEcfAndwh8VzKIPWb3c1BzX6zSuoBrDBOYnc0kzHnUUc997KlWktN6CvOf5ibKli5/KHCtN4lRrA39S4Ykp1QHJ+2GwB2Vi5XzyieqM3wvZHfJapIJabUG9rkhh9ftCogXAef9lKFej3w5iuPFSvPYpHVwTu+bc93gBU560JPCD6QleEZoiemLm1FC/YR3lpJ0n2CvZIau76TUql4MeAT2dWjwowO/UJlaK8ZSX8TCqXOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXQdOYwsrjZe8nRa4AdfXiAti3lcOZI2488Zf6qHdxY=;
 b=eYnXyFcmcDSp59uHFN9y+zQkq4B3GNL3pP6cu3VwUHgQuIGXBZOnzThpiy7YAWJ80LAbcPgszYE1iP4iQl94sUOYjut0TELrk1THx4YewAjuhpf+MUiH5TTkXEcrIlVm66kZ93m/6iotxWlc3KPodyUfnaKfXeYIv9cKxdJzFg37rmkH2KYvHQPBoB3hGXdq8vHZ9FEOdiqg4cYnVgns7B1/zWYejZZPnTJTR8mg4Ggu07FgTAv0vsgTOP3G1de/iO4XvmaM+zF3oSw7DV4pP9q1f4dFsd5bAExTwedr4P2ck7CVGfn1HXiq+J+7YYnxzOpMp0PDIpjOTBj5nvsv3g==
Received: from DU2P250CA0010.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::15)
 by AMBP195MB2781.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 15:42:28 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::a7) by DU2P250CA0010.outlook.office365.com
 (2603:10a6:10:231::15) with Microsoft SMTP Server (version=TLS1_3,
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
Subject: [PATCH 6/7] board: phytec: phycore-am62ax: Add watchdog start to
 bootcmd
Date: Wed, 30 Jul 2025 17:42:16 +0200
Message-ID: <20250730154217.1116751-6-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AMBP195MB2781:EE_
X-MS-Office365-Filtering-Correlation-Id: 41979ab5-3bd9-4cfc-95b6-08ddcf7fb016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DG0pvj2a5549yZ7cG0SvvcgGGwadkr3ZVqqXJc/4ei1PIkPKbhcus0/P7z5z?=
 =?us-ascii?Q?1pA7L23mA1qkjAF9oWbJq3/mX6ICnP6tyNOQEnPjMrk11pZ3fgCVrVbQPVIy?=
 =?us-ascii?Q?H0YN8xCl/yyjWl5oQzgKCUZ2R73Uf20hQMeHpM5z4L6cqDCBvCW8jT1dB6MG?=
 =?us-ascii?Q?8TM0jWYYODhJcFNYwxe8Q1RYOUV6HO4fGywFmBfRFvm7EglL3e6PPDZtQR5W?=
 =?us-ascii?Q?+q3sJ0vBVBbsLG2IXzPOc7qpzCfxJlw9nHYX0zOVZBIF2nADIDI5ukhMijwm?=
 =?us-ascii?Q?Kg1OuhuPcGm7WdbTXAK9N9sJK/3Yh5XHZPmMvShTzwuPd9s1dL/SoXsrdUVS?=
 =?us-ascii?Q?SoeyxPUsGNKC14yAWo79XekpLxO6I909YhqaU7vbsxze3408LPHL89xGXdLV?=
 =?us-ascii?Q?rCU+zxR2trBI0ziC80/Uq0D4PyEddF9FMpleHKmffz8+MxjAVPHlF0qqEVpV?=
 =?us-ascii?Q?ojprMCoBxrabDDqM1nGAL137JivQL2a0/3zXorox207x3Lw8tE0zxQyCiL5i?=
 =?us-ascii?Q?dJUiFv5dnU4sjAQBnWeDjc64qA4HThpzFxcFLifIs5uSIfu+FjbqNEqbE9ch?=
 =?us-ascii?Q?ENPCgGWuSs3BHFG+hMdsyQtiM/ozxc9j9iEROCuERJogp1lM+nfqAT3l48mE?=
 =?us-ascii?Q?iWUf1pHgzy0paJpSg0ui354pZIA2+nWH0/HvfI/ur8FjWTFJqt5VVCiPKNyO?=
 =?us-ascii?Q?d3NdUHU0ch517OslvIwif2yZrgHtcPyHc+CyU94STZX1bfnP2iOpKIlEqxDN?=
 =?us-ascii?Q?ZKIPiiGHwhdHnSJJ6ylPn3heHsle+pFk50h6fbrSuKwhsm+Ps9sIwlpepUv+?=
 =?us-ascii?Q?yORUIyWJ1RMfk3tw5pEdQMFTyWgeZcd5qCde8IFC6re9oTYhACg3uy7tcUIq?=
 =?us-ascii?Q?RVE9p7aPCckH3o0rsSLr+F8urdi9c3N5Fp6M2SaORlTAN3E7KeD9ghtcm4gX?=
 =?us-ascii?Q?wreg+rOOOyz/2/TPpH9MtDa63OCR+nE5nOuUbDcP2NYFnGyER2uWXygBmhta?=
 =?us-ascii?Q?Bv/tpb/jlXSSvYsvsAYn2PlGiXfXjDOo+jmZF+Mfy2AT5yRoggjAyyDCB9wx?=
 =?us-ascii?Q?gbnyc1N2+BAYYx/aCbw0nrs19wz6RQNi3iditNsjE8NsTIlZvgi/T5zHltlj?=
 =?us-ascii?Q?/5oL8d9p+cojFSq1D5/6ICHAnt14NxGAODlR1Y38EsyYA4PbyLJH8Ixivp0J?=
 =?us-ascii?Q?c6FvD2d4kk2CVpF/OGtsz5EQs704NdoXx2SZ6OW1rRxOV/TTc3nAGSE1PN+t?=
 =?us-ascii?Q?q5TEf3Ia9F+B6xD+Ps//I/Q7Sp38+DA2YXFg1Jnf5mw8nPcOlzhYtdRk/Ned?=
 =?us-ascii?Q?FhBR6VyCL3EIPHupGocTtc2l2VohRLZyk/f//fkeMUa5FfTqH8oYP7x7CcNR?=
 =?us-ascii?Q?tIVdAlP7KitchlySNbtLyZtoMKnbsnj9djJ/1kCcWwGcz2KloYXZGQvZZ115?=
 =?us-ascii?Q?0dJ376fr+5nskKp9YBW+emcw6H9sn5quVfiUOBLfYNYQ3/r3kFjTeNg7bKtI?=
 =?us-ascii?Q?2qAwdP9oq0rEezCoMkkIRboRwnbUbX3trx4J?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:42:27.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41979ab5-3bd9-4cfc-95b6-08ddcf7fb016
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2781
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
 board/phytec/phycore_am62ax/phycore_am62ax.env | 3 +++
 configs/phycore_am62ax_a53_defconfig           | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index 797904013dc..3f4b3cc4f0d 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -2,6 +2,7 @@
 #include <env/phytec/k3_mmc.env>
 #include <env/phytec/k3_net.env>
 #include <env/phytec/k3_spi.env>
+#include <env/phytec/watchdog.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -27,3 +28,5 @@ spi_ramdisk_addr=0x2200000
 
 bootmeths=script efi extlinux pxe
 boot_targets=mmc1 mmc0 spi_flash dhcp
+
+watchdog=watchdog@e000000
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 05849d05be4..3572d46dc1f 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -40,7 +40,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
+CONFIG_BOOTCOMMAND="run start_watchdog; bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
@@ -75,6 +75,7 @@ CONFIG_CMD_MTD=y
 # CONFIG_CMD_POWEROFF is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
@@ -185,5 +186,9 @@ CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_SPL_DFU=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_K3_RTI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 # CONFIG_HEXDUMP is not set
-- 
2.48.1

