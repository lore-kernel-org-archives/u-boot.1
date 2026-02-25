Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA57FD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E48183FB6;
	Wed, 25 Feb 2026 15:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cFVNGZJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F9A83F7F; Wed, 25 Feb 2026 14:46:31 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B1C82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Joa5BZw9g3mLMV9QTSsycrqw8p0md2t88Ox1E1+xV0B362n9HioxMlTGN6JHlKmGxVyYunI3LBhzuxJ6+tS4XHfAiANHSWJt1yt4HuzqadZEkzP5vLU8j4fHHXHarsx5645LoheOtYP2gicwtzD9Y0p+vWcncQn4ewKQxRZnrygB0NLEJZjCZ4B/L9vKcrLRUexPKWBldDWuT9I3KYPFhslrwUrpdLa7k2XlRMpHXrrFMRcT3LI+PTzpgeuF2P9TKZjAWciW/8NwH9h2FiRKh+xOU+O879zwadhVycrJhidUaNl2BUKb31G1pTvpxHvsqS3i/Q0rXO6MMTFE3vtbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/wkUKj9lj81XOqyOQm4UncEJiPpaH0RyVAYslr4k1M=;
 b=VwaE3xv8cuzcy/Uu6o5pf93g+1O17eEcseplApHZ/i/o8swGgZoOl3tlC2ZLzTnjRJjRqbfvXpAULwt/88o6+dHhkJjyVfZRWloA70DxwzntARcQtkt7BQSA8kUjeHfNVarlbFOSg9gxw3FXwh8PuyItZ3PDVA2HoK5sGiOBlCQHHAhCGvWyWo4P3XFlft4e2HrRcdkH7MRA+JXnIU5ZrfjMxYobsvcDU4pdL5qCunHWBQsdMMf+EINjjwfyafDRKjkQzzpjSMvAwPLStapbYE3nd/2LYVif3qyx+HVdGTaJ1vvHF9DJVYGBstL6kFfED8KOoqzA7fNaii+ZD2xnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/wkUKj9lj81XOqyOQm4UncEJiPpaH0RyVAYslr4k1M=;
 b=cFVNGZJX8CBXgrr1CuI8Ms5PsY1Ma2CtPZT1ZZl5P8akpQIKKvUQJFqwQFxbRT05im4o9WaIOKiLpVeSzmzLT6j0bOXi7li70ylgcjJiHncfPWSb2wegYjRjlHo17dA3vxhl47WEvWYrHULco8HOu1hcXjD70NM+wFXPRmxXDSM=
Received: from BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::6)
 by DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 13:24:40 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::27) by BN9P220CA0001.outlook.office365.com
 (2603:10b6:408:13e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Wed,
 25 Feb 2026 13:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:38 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:35 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:34 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGp011150;
 Wed, 25 Feb 2026 07:24:31 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 1/9] board: ti: rm-cfg: Update rm-cfg to reflect new
 resource reservation
Date: Wed, 25 Feb 2026 18:54:17 +0530
Message-ID: <20260225132425.3096103-2-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM6PR10MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b0c55f-3f6b-4413-f188-08de74713a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34070700014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: kU0ch5W17y8HJUY6xCvlYqKK/E9MwGqsZKrY0DMO3ESTngb9fuNDhOom4Z5nmW9jY49koFTYk/ZXFEAHd7x6zR7MjfaYHU+Tdm4ptxtNZCfo+XmEKiFHUj2/UlM5RpJO4mbn3iYf+VFaYQqODJolRW4IiGhsFMTB/EQa1z7FwmaXRtJsMA9fg0mljhaEfP5vKVOtPH5ve+gCS8ySiFQfV9mDRiYGxDQZyy/2LTvxNrpTfrkb1MdToOK76lKTbyPLnpAuw9eYhbUKgYzO5Rq2gRtyshvcrYlK8WfiEU+GU3ZSHD1CPwSxmoYGhfMCNuxamb0cqwCYM01OPI5VVfm7tkWHJM4BIUTCHRx4oR2ljueMm5/bA8k2wOrH+dSJhNMNTcfYdJqRrVsIYhfRr99B0q/DExw83FoJcej8QmI3FlbzzNnOmARmO02a8h9lX6uck9GDMDqFvEqV/ey97ojK1Wq+aMPI6COg1X8aOGXWBhu7/UYueV5SyWYZ5HcOqvaR9u/gGUAyJjoCaiBmNrocnWNoXOcKtsTOE4UT3sK/4zV21RfydSxG4vGvH5rihkCozmY/XFkN0ry2D2KY/Q6mfZHUBxEvuzs7sWhCGyycBwi/zSxFaqzXx030tnxvN4STYkh8lxxQkVju3NQzMkkmj9vm7c/lt2qMRr1hn9pfYsfD7ULzK1lyUmKhCu/iBDL871x8+fQIFekS9bhFgeEpiFpuwA59LY/+cIuLLKon1MFOcA4RcuAPs6dcXqbH6aTpnNANet7EbgoJXOZ4SEzXiQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34070700014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4zt4dC8eWUIKy1r5ncv6wQc3HTNieFw3nwBAAx9sSg4LVcASRg8Ohh2pyOEQn+EaZ1Ciz+Ytk2miIaK+QzmYtpfwFRrtaH/BzgOSLv/bgRYClRhAXtK42EFKhXJ80wpN2CNvtcjRlw+c39KblxnZjsmgTCxiRi0MkNZOnxjyqwcPtwezeyZ/DmveOTMSKZfrNWa9+t+zMidWOox9ZIEwhl3Z16jMxurKePKu+mXVx4UXN5UWh4GMESWOv9Ei3XHKMBDz8pO5NEqSQmXpPhMsf7DfKrgVVejavLZeKWLUQPA5V2SmdoyaWRsJsiw1TuHTyuFIqdP9dBkJRN0H1EVb+8u1pJdWJLeovgTCzRIt9kjGg4o4fQBC0pyROUHGx//TcyoiBshgLLkPvY3oH8fJ8TSXlXqjFKQR+fee18ApZw/c6mCfxtcTACyT2I74E4t2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:38.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b0c55f-3f6b-4413-f188-08de74713a17
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4123
X-Mailman-Approved-At: Wed, 25 Feb 2026 15:01:23 +0100
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62x, am62ax and am62px devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 8 ++++----
 board/ti/am62px/rm-cfg.yaml | 4 ++--
 board/ti/am62x/rm-cfg.yaml  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index cbd087de797..4e238883b96 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62A
 #
@@ -16,14 +16,14 @@ rm-cfg:
                 magic: 0x4C41
                 size: 356
             host_cfg_entries:
-                -   #  1
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -   #  2
+                -  # 2
                     host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 1038
-            num_resource: 497
+            num_resource: 496
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/am62px/rm-cfg.yaml b/board/ti/am62px/rm-cfg.yaml
index 73da85eeade..0db82fdaf79 100644
--- a/board/ti/am62px/rm-cfg.yaml
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index 26d99b03b80..a7035dc0bd9 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62X
 #
@@ -525,7 +525,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 168
-            num_resource: 8
+            num_resource: 7
             type: 1802
             host_id: 30
             reserved: 0
@@ -555,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

