Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D96AEE0215
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056D0891D1;
	Wed, 11 Sep 2024 10:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1IrMjNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB51E8919A; Wed, 11 Sep 2024 10:04:52 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830428920C
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5xWiJ1T7XhhPrCZUZD1PO4J0Cg0fBEet9akGyMyTksHL/tmUWMiN4nBtA75i/o+TTuVzr8bmFkvq39xKVK4ieTEOeSPkVOg2Ct8qA1nDSzpVIols3l2snf42KjcZu4CvFItMTUywN+EEka84kfy7BOdNJXa4oGuzEAykdfllu7HmZFVQ8pZLoeXoA4Nvfiv01WGpAKtEOuG8p1cBJQNxngXZFA19MOZiSJaKvCsXvgHHRjzt+3kINMGVaH88jgw87O9+0RtW51KvLeGjpnosHHObQzjaeJofJib7OX0C2yx9Ijg8jZid6MPAgMDytzEsbIQZ43O6VRAhdKJTv1Ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr7IAvYbpZrBOg39hXWfMDDP16guqnbc8O+OByPKxsQ=;
 b=pOI6DKrYllIfNnDRpcuOGZr2WFWyzApeJ/UeMbgfQvrICC0POgR3/X318VoVJ29fAZvRycWQCHRW0R/djXBORao2mMV4twrY9Wmc2Lw846+7vRc871+T/cvtuSL8zx9EhHIU1pDuh8XwQQBeb7Tdn8782qL8TaCe6bI+RXA9zM0pr4PlpGJYr59iKoL77dg4aZLQdI2G0H2lzmkgNMShVROaYJOGuwLN8NfZZISuU8V8AmcB8LdzS0C0u6Bcwec3z5zxaRA53e6Bm9ggKZIbNUV2YrjQKp9k3hHgtyfwwdciMg9mjHStdI86K+92TpG8zwurxN5evA6DBKiyKvK0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr7IAvYbpZrBOg39hXWfMDDP16guqnbc8O+OByPKxsQ=;
 b=g1IrMjNx4geX30Js3C+d+S/g9ikT58f8aCOoe9vomn25W46g4E8ghsElszwnS/cPoNU64CGZ2jd0sob9d1dm+J81WsdiCwik08Kq5eUh95dv1p9H+pmr7/tEaUrJKmmvohyTbUoHegZJbBSDL1aeW5TEI6ROcW4deQax57CjSVc=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.32; Wed, 11 Sep
 2024 08:04:45 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::7) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 08:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 08:04:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 03:04:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shubhangi Shrikrushna Mahalle
 <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: zynqmp: Add bootmenu support
Date: Wed, 11 Sep 2024 10:04:13 +0200
Message-ID: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=l64wyABcAp0A7u67grvDniZOn2vfav9SPM+RbBC7s/c=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSH/mKPeJdefPKcq1dvm5C/7Qnnfj8Wfa+omFM8YdON3
 yUtr6roiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABN5P5Fhfo5bhOyCbVcWzZJM
 OX6m3Tlyu1e4C8P8oKeqk5b2PbvXvVt0f86xy+1m0gaaAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6348ece9-fc2a-48f2-db8c-08dcd23865aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TwWpTSsOBLNlkKdOByLaIi6COLaOKFpEan8iqSUtUA/XQGU28Cn6bsOYuTou?=
 =?us-ascii?Q?iplDijQmZ6UazyeG6EphDpoeaEFRlV3mhSEGMNO2spn4sani88D9U3gce7Vd?=
 =?us-ascii?Q?Rec1XapWmMQ6F91JO/m4Ig5fRFo2oAMmmvFxSInkJAM4DkyEHiPSHDaGF4yZ?=
 =?us-ascii?Q?QlrOP+mYHYLaL6uwsw32XYV3ivcxiQTcx4Ib55ZwsykOj/Gi7qbgxyXhoyX5?=
 =?us-ascii?Q?WAz/4P2B29B5tA9GKQA+EZiwp0GZ9Kxp2jemvVqCtion2SHpHs66Ybqq8jIB?=
 =?us-ascii?Q?hq2d4zEOK4gptinwHu/Q5sAg9vGtnQoB9nG8l78DH113y5qOcfrEA9yZ6MIr?=
 =?us-ascii?Q?Ajg3zHHfrcwphZo05/Dl/lgAUUjJFXUpMoWyZd3Xl5pwg9dj8kYp8cD00Huu?=
 =?us-ascii?Q?56XYyImIXGGlU/3A/dfgShEM9XtdRexCxP1PSsQC82lyWUhqgGDgfANap9t0?=
 =?us-ascii?Q?xkbgVJLMwpDm+5y1DGanfvcUDeMayaqjS3qoEeki8WKphpkPe6ZWXsR/gtlc?=
 =?us-ascii?Q?CyYtqavk9MXx9g5QVd/6GRg+dlGt9RYvvTBcORi0EGZf3lThC5CpTpcHCPm8?=
 =?us-ascii?Q?4Cu5NHuFH5L2aAeyHbXz/uH6FfNGKPE1GV4ZlrL4DNwTdqkHB4y3YIfJpXx4?=
 =?us-ascii?Q?uZ+xhRx96NZDTsBwh7+XI6J50ldc+LQ7fki7J7PfgutMEUnoP2rKXRFagF0a?=
 =?us-ascii?Q?WHqEyUmQxpVjEoFsXBaLBjHbSJke6JNgCPPPnEOVQNk4YLENNV3QBGSHjehv?=
 =?us-ascii?Q?j5N7bubSVyKzEhtygE6k0fmPoLR5T2dX1G2iP5kZRhjCmW8EPI18e5eLx61r?=
 =?us-ascii?Q?PzE/2OlEaOI0CiqdaGJeJB5hJGyKMHcfc+q7zI/BwCFeJBVagWCM9nqcPaS+?=
 =?us-ascii?Q?/uAvMZEKIXqII3JgLFQlLZpzFhsp/AAOhwsWK+jBNzOgUwFHEXIxZsGgYg5g?=
 =?us-ascii?Q?TKaHvwFWh/HrJR9Qb2ogGF5DfskADxza6T8d60XVmIDjjT3DeSlCYd9DqFfg?=
 =?us-ascii?Q?P8Qu025pmBPHUjJpFxZ4hMgdZKu4bBMRjbPKZ0l2SQO9EZNCVKwd+F/uWjDE?=
 =?us-ascii?Q?oFv3sVEz4W5B+zlpTxlnx42LXTAZxlsQfggRlltv3HPXkyKqzoM/0AYwkoyy?=
 =?us-ascii?Q?z9eZo4NClxsSjANET6gZZP7uKUn+KMfRPWTQRgdGSmK4NHXs5sKn4Qagok/m?=
 =?us-ascii?Q?cHrndBqfnS3QXLcjZjJrctEQjD+3eTQLvAOzkgsogfxKQF9M1CR5b0Xuy0QZ?=
 =?us-ascii?Q?9ayGkwidqev/+sE0WUd8CdbKGT3WtM5lz0e5lJtRNk3hj2UFuobierpfWeTE?=
 =?us-ascii?Q?QEqC2VD3oZB+wjHr0F1mTi02YErjqMboaY6xumTeHuxehONT1PiMK3tYpVyq?=
 =?us-ascii?Q?MFOtD8d7ICEoPU0cDTJOtIUgokb3djfVEzEc37qqN9XkIpcV2OJtb1d4M8zp?=
 =?us-ascii?Q?s+jcEo/xGRHQR/vIHAuYM9Gx3qH9VUoZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:04:44.4840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6348ece9-fc2a-48f2-db8c-08dcd23865aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>

Popup the bootmenu for 5 sec with default boot options to CC on AMD CCs and
default to SOM on others.
Users can anytime disable the bootmenu by setting the variable
enable_bootmenu=0 in zynqmp_kria.env or setup it up at run time and save
variables to NV memory.

The patch is also fixing issue created by commit 4c7363068651 ("cmd:
setexpr: fix no matching string in gsub return empty value") which has
changed return value from setexpr command (Before this commit when
matching string wasn't found command return 1 that's why was possible to
use with if).

Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 49ef3e7d7532..d0e431ebb46f 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -49,9 +49,19 @@ usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
 som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; fi;"
 som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
 
+# To disable bootmenu set enable_bootmenu=0
+enable_bootmenu=1
+check_cc_for_default_boot=if test ${card1_name} = SCK-KV-G || test ${card1_name} = SCK-KR-G || test ${card1_name} = SCK-KD-G; then setenv bootmenu_default 1; else setenv bootmenu_default 0; fi
+som_bootmenu=if test ${enable_bootmenu} = 1; then run check_cc_for_default_boot; bootmenu; else run som_mmc_boot; fi
+
 k26_starter=SMK-K26-XCL2G
 k24_starter=SMK-K24-XCL2G
-bootcmd=setenv model $board_name && if setexpr model gsub .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then run som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
+bootcmd=setenv model $board_name; setexpr model gsub ".*${k24_starter}.*" starter; setexpr model gsub ".*${k26_starter}.*" starter; if test ${model} = "starter"; then run som_cc_boot; else run som_bootmenu; fi
+
+# Boot menu
+bootmenu_0=eMMC Boot=run som_mmc_boot
+bootmenu_1=SD Boot=run som_cc_boot
+bootmenu_delay=5
 
 usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
 
-- 
2.43.0

