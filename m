Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D37FD29DC9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 06:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAC5836A3;
	Tue, 13 Jan 2026 07:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxJEx7Z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E08836C8; Tue, 13 Jan 2026 07:02:08 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F605800AB
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TySiPMsJ3p2sVeezFPiDW9V3l3gFD+4eGveCASHjsEutW3hqQ1oROBdKra0Z0wUd/CuCPIZLzOpOkno0kaAEEJugdJKEm/8EV4AR8OdkX7utplxuQ5ik2ojQi5OKPPTtIgpj1zu46pHjwY675vucKXuIF19uhVy1OhuKYyWE6a9oyAqmA+ElyBgbGyTaEfKNG/huyObqC6A5PRgNs+u+YVAt0jZZNxDVLVh+5J/INSnv9aojqN5lW8JtTKQjXD4LrKZuc9bZMuGlBQKcpUVaRLXOa4bCn+h67Pkgj+XvUVZjcyG9iHcEBm8ysRLZPcnLKq4V8AErvp+jEL57tlZ8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n2bSKnxYRbGk9KdjZVQfpwDlBmZM0lL97zsfOYF7Js=;
 b=qqdTJ6sas8FO0uWgP56O3D44qQah3V+OB3PhZE/EeHQ5WVFj9TPQGseanD/UKhWBYMgCLVmnVlQNwZMxsqq0UXFh02SV3Xaa2m1ewEy2KegoaYn9AbBynQ6gSQDMX0r4QCbzDYGW6okipBqTTVqt6CPEd7E9P8YbXEPwtc/d8D3cL+2TA3SnBvJN9sIB5RNjC7CIybMUE1RSFJsajQYLpVLhxv0u2GDCe/Ir5wIMoGwPjTj0095+OCGovOdeAcmRXxGzxwh1C7xYzy48MkBMmLG4+dR6Ov0lBgOefksrRHuC8QoDoz0RFQAF/fTfkQ6Y9POlDqOQd1BV5DUodwSlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n2bSKnxYRbGk9KdjZVQfpwDlBmZM0lL97zsfOYF7Js=;
 b=xxJEx7Z5gRXvYach7pfhQGDmt1QROk6XG+/pF46T+QcFnQi3+T8MvwD5576asPvsFpkgvL9L0VbQVPDUR4FhliIXRWWUwUzOKQLiajVtVNlULcFpz7oUGQPREjN38goD2yGwoyUgftBusbbsRsvaPvelWTf95vrpsxPN8Dx2+wQ=
Received: from DM6PR10CA0005.namprd10.prod.outlook.com (2603:10b6:5:60::18) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 06:02:03 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::b4) by DM6PR10CA0005.outlook.office365.com
 (2603:10b6:5:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 06:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 06:02:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 00:01:22 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 00:01:21 -0600
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH] arm64: versal2: Fix emmc boot mode boot_target issue
Date: Tue, 13 Jan 2026 11:31:07 +0530
Message-ID: <20260113060107.1136297-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6d90a7-8ab6-4c3a-bfdb-08de52694607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xC4HJxpACfbDXee9R33jKXO4nhwm705WrniV6KivnPRSiRwAAtAsJLmBpoxB?=
 =?us-ascii?Q?LN7njtBht783PlgVKSicO0f04E8SOX96IeXDQF8HETGeLANqTTpBUfLjJF8r?=
 =?us-ascii?Q?qarNZlxWk44EFZobWD2W8USXHsUrCSy0T3FiCTGyXPOW8h942wPnc6LJXWOB?=
 =?us-ascii?Q?1WZz8IpUomy12oFdsM3Swnxp3fQ93IbV6vKhDpRRZvV9NY1UstEJ/FwgBwLS?=
 =?us-ascii?Q?KyS9pmS86VyGajmfK6ss0lttQtDTAxyagoo2eX6m0KPTEK9c7L/MF7Tkula1?=
 =?us-ascii?Q?3GxqWpFtrIg+pkD22Cs4Vmd59hzQQoElqwxIOlb6moGZf3bI1HnAaPc3Fhy0?=
 =?us-ascii?Q?pb7AE3Wt4KDDabxL/SxP+Lg+I8svmQuJDq5A8alQ++X+Lb2kp0Av9Pek05Qm?=
 =?us-ascii?Q?yK9juQjUTO0rzVaJLWkevcq/j+HRMlnMI2+yRT0uSWFHkLE8xTe/xVRNFiwg?=
 =?us-ascii?Q?C8hlBJh3GXvanQAVTrifnHKe0ungp6LcBsfxH3QY111KuRumeUOOuX05a7yT?=
 =?us-ascii?Q?8oG9MdMbk9I/yxKt20Xgk/NUFF19yPTvowghh3+pJHyDil7NIeoGgirmTcdy?=
 =?us-ascii?Q?AUDoR7KcNBnYnPp/vbwuHbj2sqGiuRNgUhqi/2L621vOxDb3mi4Iopu3h8f2?=
 =?us-ascii?Q?PSlS0WfpHp5K7FWSTgYIqKGv9TsEMu15Sy7Fws0l/6QRPS5/rMgp5GjhRXN5?=
 =?us-ascii?Q?Eh/IuNPvKJ2a3ZIb5FphTgtEwODKGctC2bnpiF+/Y6TonNrFT8trWrFM7RWW?=
 =?us-ascii?Q?1XQE9Z9n4uJqLLkln30zqP1gEJ0MR3BwpshG47NM32FWSmsbuQ+jAF2C+D5E?=
 =?us-ascii?Q?440ZPw3aMmbRw5T7evY+LIo0FA2gGpj+dj/EV1JwISL6VODM0Vkg8+91uupU?=
 =?us-ascii?Q?c2eknRxskdjijBDeR0j0tsHjdatSoB2uMzR2AWAdVjNQzxf8dUKQZk7s5fS1?=
 =?us-ascii?Q?vy2PZiOI4h9KW4XgJvJpteioCqqsnbsB8l+/88/+QINZ/ZbqHvFDgfIK+pxk?=
 =?us-ascii?Q?S6rebqV9WxXqlboaTv4sfWrXY65Cnk98ceDlQ5IXyZaMs65nSXG3eZlNOsmA?=
 =?us-ascii?Q?lI1yoMBQJbSWu+9lRqyl6KGZtG8rur4USWepaQ6g27pPHy/J4I4CBgiyiBxD?=
 =?us-ascii?Q?DBbdZ8tgsNrmGIWmzNCXmiAhGlZM6oXxl65vvKqcQN8l4MZP5ctyOtkVqGZm?=
 =?us-ascii?Q?WLSVLVL8npsyWh71efMPs4Rq2NJyza01rtGTKdrzLyfdDok0+CvHLAe2vn8h?=
 =?us-ascii?Q?E/IPMVTzxK+P9YZtOnH2mTRZD+PO3dbswrCeqWfuuzdzek7nwBD/0Tzmn9R4?=
 =?us-ascii?Q?EOq6dkNIu39ee7wdUUtyYEGwAbngqUBf0Eb5siL908jalxUIQ2fSMBt3I7QS?=
 =?us-ascii?Q?rYGEk0WD4NJqVvi8pT/ForOBBeD++vAZC9JS84lxvqfBSl406D2CH3SaYo+b?=
 =?us-ascii?Q?TjcRWlRoUxJG0YssKoiWHfs4Vn6poDKDGTcz7dQNyQ2cpDAr5SVTxXSpdSwH?=
 =?us-ascii?Q?nvhCnPTClHOZ/Llnl3n9AUCtkwPhejJbpVLxYcu/lzR5xl0HEH4luxhYIqWO?=
 =?us-ascii?Q?cHWstmln/H6VN4jyxMA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:02:03.2566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6d90a7-8ab6-4c3a-bfdb-08de52694607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

The eMMC boot device controller on Versal2 requires device pointer
initialization before accessing its sequence number. The EMMC_MODE case
was using dev_seq(dev) on an uninitialized pointer, causing corrupted
boot_targets entries (mmc7f7fbfbf instead of mmc0/mmc1).

Add uclass_get_device_by_name() call to properly initialize the device
pointer before reading the sequence number. The dev sequence number is
determined at runtime based on DT aliases.

Fix boot_targets corruption in eMMC boot mode, allowing proper boot
device selection instead of falling back to JTAG mode.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 board/amd/versal2/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 1fd05a1157a..d8079c1cee0 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -253,6 +253,12 @@ static int boot_targets_setup(void)
 		break;
 	case EMMC_MODE:
 		puts("EMMC_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_MMC,
+					      "mmc@f1050000", &dev)) {
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
+		}
+		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 		mode = "mmc";
 		bootseq = dev_seq(dev);
 		break;
-- 
2.34.1

