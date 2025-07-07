Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FA9C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05E2830E4;
	Mon,  7 Jul 2025 12:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YH8ZxJrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E5B8304D; Mon,  7 Jul 2025 12:39:35 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68DC83043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6MR5vNGirJzfs+CTF4za1F8Ry1Tim2/KsDDtHGsbb+W58jBmhs30PUn7RZo9lIG/IErLoMlDIj+S1n6hDIH/pc+5caTS0X6DBusg3l+G4Z/CBvQ4FPgoet/kmWEtESWd+3T4TgeERXrOkU4E9hYeG1jwcqVRidCBk6bHMBM3TzYv9IrTStbSGcNDlsqhv/2g4CZraKPisS9miJWXgX/rrHR671plEV+rCAaXH+AMoCsBF/Xfhnwvz3oQhFVxYCd7yRKMJ0vTwPgwZDS4FfBVe/8etXGFP+5Q07BebumeCsOv5zhYXp+PZTMBoGstjyY5umasEg8ldDrnPyYS+0ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udMHnQPJxAa2Mf43zwauLJOSObxodl54X9RBZIGXf6M=;
 b=Wd/oWi8zA0kkuZKNeJo5JRuSRa23UFhEOIkPjQq379f6GaarwTqg/3lnj9qvR6lknAYusTgNfQwpTAkeR1B68V2f9bhlusX9O5LyrL+jDjelCY7Bpatl8NRBdjnwuJlvDwS7XNOvX9vbXuXMtYpz2CEY8sKiJuqXAN6atDnBKUFtK1+rSozbuFx5SH0uVEEm80Jpl+uwM6Pg0rYwyu9pCocprx7cngAf3XdBqrywDz3V/MdoMYqelpZ9hcjcANz7M2pxs+LF0hnNtZFi92aGLgaut+jBH2tfo2/Wlp9gAcsbQN7P4VEKcJMydziJtQkfkcuhpMqcfJSloAiGfu/pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udMHnQPJxAa2Mf43zwauLJOSObxodl54X9RBZIGXf6M=;
 b=YH8ZxJrKj1eKSdoOIj2vO3JH+SS4kPkXvYaOgyT0i8lJ2i6YTydbj1M+P/T6fhYKmID4uHdB6MIgkb1YebnQCmcTpDLxLYTIGHgwjBUJtIOWLUXE3oGYSwQ8sJzoiUvV/JAXqQpF8SyKQn4TfpQxndqbVop3rrHXwyGX6A93SZM=
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 10:39:28 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::bf) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 10:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 10:39:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 05:39:26 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 05:39:25 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 0/2] xilinx: update guid with fwu metadata
Date: Mon, 7 Jul 2025 16:09:16 +0530
Message-ID: <20250707103918.4189148-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fead8d-17d3-486c-7f45-08ddbd428cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtkXcqYDlftwYWecXqsrzaq32TQLpavDe9Jkf01wvncG3GZKVsCz2WAENLCc?=
 =?us-ascii?Q?tG1z+u2Qxa5AtnqHM4Mf/dsfD18LVZHcpjVlJTVXRCAUMc06DlYh9GRt/zz6?=
 =?us-ascii?Q?iOXVx6f3enPS5fnCcXE0o0BZrNR64F91JoMeeOMa1ZxhgKHTr2KvDkS108iq?=
 =?us-ascii?Q?6woX0kwzcyxVZFZxmbO5K47i/BA46xcgfQo3RsHPYcqihtK3epGUt2GZvm/7?=
 =?us-ascii?Q?/noFyciklAZWpDCQdHN30CL48Kd7k/43RxFVxIeAqxPgUJOY3LaEQmO4P4df?=
 =?us-ascii?Q?hd6pFW/5O8trVV5/G14uQWW0wfN8GG/X7UO8t7CywcOlCmmh6YL/VSBLDWfS?=
 =?us-ascii?Q?NGf4MTTPSlzfOvRefAk7j0lnn/HVEtNCZ4vEqCoctanJpd0T5rXaKQEkwa2m?=
 =?us-ascii?Q?mj/Vpz/5VR3bIxCkzfGGq8gC+4yz0FvU7brXACFzysYCG5/uVKEaHdWEvik4?=
 =?us-ascii?Q?173XOE4U8wUVDu1aB0Y/QjO1Gr1CHZP3bSKT3luC7Ox++TI7KtRNTvtXX0OH?=
 =?us-ascii?Q?OVj/t06/tbYJz2HZW9AmPDl+hHKMBbMRJOyDQFQpbyfQ/d80A6/MyUQOFobY?=
 =?us-ascii?Q?KMMsiWWkQQDip9kA077vs6jKcdsnemZBsdj6Kf4exyM/m3emYcRKuVgBIuY6?=
 =?us-ascii?Q?SG/Nt4XPswe5PIVSFboTHngCBih+VL23nSrLe/Kmf7B5cQd+U1xWGFbQIq4E?=
 =?us-ascii?Q?vB0+XLppgWGlKjdaNZxYzVF1L4pztLwRcuOFCbd+Q7qCGGlugTjQrMi9uxry?=
 =?us-ascii?Q?IgwUFuHYUOIny0GjS6vq70b381sQI9aAj1ZIaDjeY0AlNHO/8K7RiMPd4O67?=
 =?us-ascii?Q?nPKoIUzvO/YHShyKoRz0ppcpXdM0ixxaYdWshB5vbTABYUWEypTbsoF8TXHH?=
 =?us-ascii?Q?Iksi++baUCAjG8pML9KyIBzFigXcKL5Xz/RDbViiF5F6tIRakTFsNL5jXI9Q?=
 =?us-ascii?Q?hTABnA2KCCyVz6Bg3AKTTIFrF2+exUPH1U17NldLxgtOgKNWs+8Cxn8075vA?=
 =?us-ascii?Q?O4XfEAAr3GFxvfBHe7itttC1Q22HQR+SYmyCLFF+8pIBk73mGKpbWMPyf1LQ?=
 =?us-ascii?Q?NzwL6WbRecXmJnnqdSIW6MemJbG7jc7Or6wiQ/r842isN/jghZajDbx3NKB9?=
 =?us-ascii?Q?9QexdgFvsECzkmfgxEKpaxPFsD45GYwzGrw7mxnYuRZ5HuKEe2cp6Tl/1ljS?=
 =?us-ascii?Q?Q1NqxWzjWWetRAYLlPONaVxS8R5MnnIpm1kCnTHJ6vC1qQXQV0t9lsU6sAIA?=
 =?us-ascii?Q?bmSCPx9SQQk7ttwn1cz0nvyQFtTYisnFUMC45ihkto6k6VXo08YxxPZF5khE?=
 =?us-ascii?Q?8r5Q42DAzq+KDdMQcp6BrJvp332oqCza1qGxU4ktlnA4v4rOgmrKrwUcXPaK?=
 =?us-ascii?Q?M3T5ueESOXp0VePw3AIaTrwTWWC/N/JD5flWe+cmJr8J5lP+BCROQsw8u+ZS?=
 =?us-ascii?Q?7A0TffqkkBrA7VLO0rM3vq9/L4hyjHky0k5oxCeSZQYcUh9nJZnXIC4+QjeE?=
 =?us-ascii?Q?z1q/MqMdSIblUj59o2wdM4d3/ZRPv1kNmiF9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:39:28.2379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fead8d-17d3-486c-7f45-08ddbd428cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

Introducing the fwu platform hook function from fwu
initialization to process fwu metadata information with
platform specific operation, and use image uuid(GUID)
from fwu metadata structure for fwu multi bank update.

Change in v2:
-Update commit message for FWU mdata
-Remove platform_hook() from driver, add weak and actual platform hook function

Padmarao Begari (2):
  FWU: Add platform hook support for fwu metata
  board: xilinx: update guid based on metadata

 board/xilinx/common/board.c | 13 +++++++++++++
 include/fwu.h               | 11 +++++++++++
 lib/fwu_updates/fwu.c       | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.25.1

