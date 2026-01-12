Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806D6D26D97
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DB2830E4;
	Mon, 12 Jan 2026 11:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NzyF59BP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC5A83885; Mon, 12 Jan 2026 11:11:15 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C3C800B6
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4Ib2GONORgLCbet0xJOkJA9UfTxtiM8HOer6tD9+zMqXz0Y62rmEFpzoxBsGpXb+1G/VG0ZOK/oqMsibC8S1NRjO5IP+frXiYWTQ/og7NIRYndP5nrsjj/E6mb4+tWcuaLaFFIcgElfgyozwRtIfUPMtHkNOtpWUJSBkRfmzmfyVhp9HDLOZX5guaFvF4XqhIh6xs0WDq4z/zSH6LwMKAW9b1jcr+8Y2KEPNWyJhnhKqj9NZlHzAxa3Mr5vdhVhhGGTfI26sP0PSefHPUHYQSzh6al9k4NPdnScJ8dPDnGPoeWgYasbeEPrTEQ2/1gvEuFj5HiJamkw4uGI+m/Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJocuV4/1kZZYaAwC0yWx5K5QAzLVB3N99U9XhrtTB4=;
 b=WULeRI9jY53axOipMiMlFpZlBtD0u/G0nBwsy9QZ/KHupfyNgKvKqgu/n29dztOOW0KpeXxp6zOqv++xQc7E1evAUAnjOcUxfr6qFaZs0FW2woDnWP/bQvIoZrCXYBX9rjYbdwneZmZ508GHqHVjK3oNpSXC/JF1r2zDDnpuAebXwwUB4fRT/n237TZD82RXYWy+c9VSLOKgXklKLqkdeJXU7BvlE8lTx+duTxhNwrIqLrb/Zhff1fIwTvRgQor2OsjUxY7arbWZbl9BKjAQOYowrmeaPaQvA60EmuD9fVDRZ+bXej0EnpB/EZ3zGvSz8C08T2vrLDD2xZkJiQSlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJocuV4/1kZZYaAwC0yWx5K5QAzLVB3N99U9XhrtTB4=;
 b=NzyF59BPYTvk9uuTGhIRRVlegt9iHb5rVJ07IsN1fa1HpyJyiF8kUCuHgWf5f1i6PReJfH+xDn4Swm8+MgUmKAJ6vIYksUkzAtLW8TtCeMSdKWEzBI6WPRLh3VuxQYbEN0F3NQE7xiQc67FvhtbRVFOfWk5o5uh02qAHVN4NNx4=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:11:08 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f0) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:11:08 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:08 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 04:11:07 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CAB2ft322683;
 Mon, 12 Jan 2026 04:11:03 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] Fix TI DTB alignment issues with recent libfdt update
Date: Mon, 12 Jan 2026 15:41:00 +0530
Message-ID: <20260112101102.1417970-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 640b092f-71e7-4de4-d6c8-08de51c2e7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|36860700013|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jwDRLPnDfuGsb00jPzBSQml4Hp0vsGJoTfejoYaushBW0OSYsdmFb0ngXoaw?=
 =?us-ascii?Q?cR743nnTRKy2JDhc7RgdgKKySki65sb/Wkm92NOLAEAa/6sVb19x2kEZy2A3?=
 =?us-ascii?Q?80SgnMWccvqDI4ZecsZoaAs6pVErGVQoFw/D754LbH7XoIUDvqc9dBRSwfKr?=
 =?us-ascii?Q?sfHpR72YOKyFC98MvHzD3kmaiXCP4/BkJ0DQWnVNgRt6Cm+gGvaddAlIt9QR?=
 =?us-ascii?Q?nEJEzAARsfJGFuQtge8x7dA8xS1oSFNdtrPjkm0X07HnyyGj2T7XLHhhCTxB?=
 =?us-ascii?Q?XQkIz1PTLzn0/IHpQNGmzEshGgScOY7+IS3ueBV3NEqlPsQVL1CWXvjRt75x?=
 =?us-ascii?Q?1/RDA8TvDrlI9xMoBaeUBqJXPq8SdrWwqNqkBtjkl3oFsNqRz6n2qdf9onay?=
 =?us-ascii?Q?hsav047YruDggo1N+XRxepZFpFEqhhRXZphdG02V7+krS8LWCXRZK0D6cJ9h?=
 =?us-ascii?Q?8esOe2A5sUMTw9rm4EUZUPrii0s7sMA2yv/++VXtqS3hLgW5FqT20rFsDeCZ?=
 =?us-ascii?Q?TAbf6yq/2g6XyyaNw/lJFL7BdONsssVa958E2DoPTZjPeIsCm02mYPigR9cm?=
 =?us-ascii?Q?dfS+X5gLV3p44Hh34VpqKjeabFbJ969/nmGvxj8DUzainui6XCGdQEwnzEVX?=
 =?us-ascii?Q?MADEi/R1fnDBi0WsOt2uWlvVYtagkQ6XIbfl6oqrOpk5psC39IyfA34+drbS?=
 =?us-ascii?Q?xfJOAMTbMvjV2EZZ53KZVBT/5/n0+MNWDsG8qM8a9D73cSB9AOuSlUUK+ZYp?=
 =?us-ascii?Q?EQR8/KN0UPnrmNfpBr0rwekfooMZlUg/q2fvsFf8gsII+XpTshK8L9NiBhBo?=
 =?us-ascii?Q?p0RSMCLk242sfVZ4CJ1Ejln52IvoZdirCJbXUvJkgHC8KL2FCcnAKyaPSdq2?=
 =?us-ascii?Q?029cctWNn0gVsDEFwUekskXgQgzdXGN+5EO+VQmlyZ5KUqWVQ5cs2b/AkbyE?=
 =?us-ascii?Q?CZjeuqNYNdYAWk8pUs60DOh5bp1iWL2mUnWZFxoLBkIxvoBii1JwsEtLhg5W?=
 =?us-ascii?Q?UNeO1zGbVtQL2QXnKIoiwr8VrYPcfwPvhIN+S9he+GY6rjSzjXk3HMKaokDm?=
 =?us-ascii?Q?Yh4/wklHfEGKuaOP+zZz8C9Aubr2MiZKUKlDvT61mGvq/knuilUlCYfxWYtf?=
 =?us-ascii?Q?LiVqU7EwS/GmnrIud0YDdrVMoyx3ypQYGWyoEj1lSOqiiRawEOnFOmVSQiba?=
 =?us-ascii?Q?W1zSUGvGNuJ+VVqH6V8jBPnEQOzgihhEd2haAi2TwSmI1iIc8Tkop4xtI8B9?=
 =?us-ascii?Q?PUIkzlsy+QH5CW11OfRZQMVCGTsT4vc37jg7hHP9f+O/8e7DP/OL5iKqylic?=
 =?us-ascii?Q?QUwKxTvtdyKBdDIn1y5ebUBeyWoMRkw2hijbbf5qRXX15SXfDbVnAiusUp9N?=
 =?us-ascii?Q?+KvPSIYH7qId2D8WTcBFEgG0WDx0dnfSn4rnNY1bsYv2woP5bVB+mqH5qsid?=
 =?us-ascii?Q?zErOpU0XW32EGPjUHHBd/SMPcxUyAQ3SZyhKpUKD57RU5iFN085dRTUGtCiv?=
 =?us-ascii?Q?mA9vry4G40jVYq4EmqnEIXbU7lYv8cuRA2rv8RLp770Yt+ErjOnBaKaQqFTM?=
 =?us-ascii?Q?d6wAHGiWrG/l1HU/lFg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(36860700013)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:11:08.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640b092f-71e7-4de4-d6c8-08de51c2e7d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
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

Recent libfdt updates (commit 0535e46d55d7 "scripts/dtc: Update to
upstream version v1.7.2-35-g52f07dcca47c") enforce strict 8-byte
alignment for device tree blobs, as required by the device tree
specification. This causes failures on platforms using
CONFIG_SPL_MULTI_DTB_FIT, where DTBs were not properly aligned.

The alignment issue occurs at two levels:

1. DTBs embedded within the multidtb.fit FIT image may not be 8-byte
   aligned, even though the FIT image itself starts at an aligned
   address. This causes -FDT_ERR_ALIGNMENT failures when
   setup_multi_dtb_fit() tries to locate and use these DTBs.

2. The FIT image is concatenated to u-boot-spl-nodtb.bin at a boundary
   determined by the OMAP2 linker script. Currently, the linker only
   advances the location counter for alignment without padding the
   binary, causing the FIT image to be appended an unaligned offset.

This series addresses both issues:

Patch 1 adds the -B 0x8 flag to mkimage, ensuring all DTB entries
within the FIT image are 8-byte aligned.

Patch 2 fixes the linker script to include padding in the binary
by placing an alignment directive inside the __u_boot_list section,
ensuring the FIT image is appended at an 8-byte aligned boundary.

v2: Changelog:
1. Remove extra ALIGN() directive, add a comment instead.
2. Add R/B, Reported-by and Fixes: tags.

Link to v1:
https://lore.kernel.org/all/20260109190026.58464-1-b-padhi@ti.com/

Testing done:
1. Boot tested on all TI K3 platforms.

Beleswar Padhi (2):
  scripts/Makefile.xpl: Align filtered DTB to 8-byte within multidtb.fit
  ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB

 arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
 scripts/Makefile.xpl               | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1

