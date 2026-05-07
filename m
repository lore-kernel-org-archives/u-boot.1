Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F744CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE3384AA4;
	Thu,  7 May 2026 14:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vdBAY4Lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 002DF84AA9; Thu,  7 May 2026 14:29:16 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F44184A85
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 14:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS/ZFojVmMz7/ASYqlbL3DyT74rXyK24UTD0By+1ofa/0kkklQCceN4h2HOY3lqQl+L5Ggg2LM2JPGuqwGWaLXQXfhNa0RTh3uZfh7/iEjInprirpvc/OjEJFUNv9RvrfCTp25tNMsUpT4/oLWv9oOkJoRxK4ame/Vfs6/R3kNuXPBaxTZ4ZTdoCNp7U7fRSnXZdbokHSvJGvuRnkYBRQuoU8+wPoUW8Znesz0e9cVRlCH3XXk54J6z9xyoOv7trXOxfTnC6tOpFp55vPonkaJo2V10omuOigSPrTzNqMoV2EPZjHXNsonrZeHLDYVftbV8v8rPb1Ve1rD/sXLZclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJmZGNKTCbFcvU0V+63nQlIhiPr44Kq3yoxDY6yVzPA=;
 b=ys1U65ksGWePbcT5Vrbb/OQ7GpCqpp5Sne2NjSbrZ1WfY2kkSL3FA9XT/y9Fc2pS4uRWg+5P0BwMwu04gXPh9tWMBh/aVdetAbYk0PCCwcClHqTMDXimFJryyKeNlh0dKylb87bRZX1o1Ih2+EsQOyYKrCYopUQdfQao9/QPgbKfa/o79F08U/f4uA+y3DEnP54IsqpLP0PlCRjpmv4WCERbvh0VkyrusIUOhTJcHU+6npVz/bWqQmm0yl+jL/5Sk/biPHR2QDnJyDQlBUCnlBfUeK4ue2VVpH6OtJz0mOFWYJLdctCoFsj6JcuLYlzYsiEyTJuqMN7XXMwo1h6OPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJmZGNKTCbFcvU0V+63nQlIhiPr44Kq3yoxDY6yVzPA=;
 b=vdBAY4LxCs45q//dhlX1tYn4weag1Wz2momcWPLe9S01QQAvTi///RZYhuVb8AnVKczIXlOEk9SJmQ3GXdQQ90rFAmXWWchv9vwFhJM5JGIlwR54tI6Rau9peZUQm+NQDGdvH5za7OfQEN8RRwbAAWf2cWDY/Y4QaO/jNlBegHE=
Received: from BL0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:207:3d::16)
 by DS4PPFD4164D783.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:29:09 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::e9) by BL0PR02CA0039.outlook.office365.com
 (2603:10b6:207:3d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Thu,
 7 May 2026 12:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 12:29:08 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 07:29:08 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 07:29:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 07:29:07 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647CT4cI3303222;
 Thu, 7 May 2026 07:29:05 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <sparsh-kumar@ti.com>, <p-bhagat@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA resource
 sharing for CPSW
Date: Thu, 7 May 2026 18:01:15 +0530
Message-ID: <20260507123127.1518673-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS4PPFD4164D783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b133313-7d7e-48fd-1073-08deac343c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YRNW7D2QQ74/8BbCeOFsPy6YHl6G1xsYbMIR4Z5jHUQiYLJ/I7u3zXSBRYzh0ojLHxNPllccgO2VFIqjkNu/pzwHD4Stj96RoHz5nGLKOikG17wL+KeIVl4PXlUkZcEIYsUMdFsxdew4zYpQqoX+odVrv+SJmk/vQJ7FbVw7/FbYN16M9If4SWKPZtyaXRga/BouXX94U3z9aHFcqbcJnT1imtuKJixE4mLizigRamrhmrOA238cYUlVMF17FEQDcexcLzFaW4j/MLkvtKq1EB9I/Tv+aVA7QWAkfus91B3Kq/D+1LSwTHKrcLGWhstovP2SDLlnaihQv4ic8ZYb7b0wNZnqArb+rl9w/MT5a9VgoSIBXaQePlJ5Jh38nYvO16RpamrJFzZbcnSFZbF7ZOb+AEERBTpvLzOQz9kDlex3HHh8A0xH4hJqEytBfEeTXY0e+jvwNlb1nvLDkrq1KLo2R3nkkn10yNSLqEAjrezwAK2V+bT91Amn5wagXRAiXJ3UFTqxU7XFFnhk/hwrSrIUlA16Z2tePLQ3yi0GshuQQnmAR+9jxq1WmgIcXXCUayD6yvrXwHzKL+M2XbywjnbhYRWCDN13kulBbHKXHOcdMSCwrE0r6uykzLLSi98Z3S58iS7692jrFT8uv3g2hzwkKX2liQLx3Qzuk2a29vPT9y+TvhVq+3/WTIjUyAIo
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HENI90azK+DVW5pXU3yELR3+ZM/v50msJO3iCT/SVvlOXOMgdgQ4ZLEEl63qyhCX97lD1ALj5KobSKk9nXlMgWMZR1uqYobMWusV3sNxmJnpxyar6W0BeQSEe0jeCHNELll/EzGIGBDsSZO0HXrbQEMx7ZlArz6P8uPeyszpdMKCR0G2uqQ+rO7v6DQK2kJQVZZrxhad8LKGSyXriCfIcjlqKgS1lsEYMrNgRlhCuI+47NGl/r11jn9W4xhOlXAnvDJ/zGOfxVKxNqy67ygKIQwUF863WTK03IiZ9EMpW4o/T0/wMJv22k0saxyKimYFsWsbSB3z1K3M9F/JfJKtAt3fGcIYli6ECfJ+m2ywXh2s/imxSSjVehcHSTHq1yrPYsphaIoSFm2XjPkeSTOaDg6ey0ZvrqODTjJmS/gkUf0w/H4coV9xOlH+HA9qTFue
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:29:08.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b133313-7d7e-48fd-1073-08deac343c9c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD4164D783
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

The CPSW3G instance of CPSW on AM62AX SoC provides Ethernet functionality.
Currently, Ethernet is supported on Linux which runs on the A53 core on the
SoC, by allocating all of the DMA resources associated with CPSW to A53_2.

In order to enable use-cases where the Ethernet traffic is sent from or
consumed by various CPU cores on the SoC simultaneously, while at the
same time, maintaining backward compatibility with the existing use-case
of A53 being the sole entity that exchanges traffic with CPSW via DMA,
update the DMA resource sharing scheme on AM62AX SoC to the following:

---------------      --------------   -------------  ----------------
   Resource              WKUP_R5         MCU_R5            A53_2
---------------      --------------   -------------  ----------------
TX Channels [8]  =>    4 (Primary)     4 (Primary)     8 (Secondary)
TX Rings   [64]  =>   32 (Primary)    32 (Primary)    64 (Secondary)
RX Channels [1]  =>    1 (Primary)     0               1 (Secondary)
RX Flows   [16]  =>    6 (Primary)    10 (Primary)    16 (Secondary)

In the absence of primary owners of resources (existing use-case
where A53 owns all of the CPSW DMA resources), the secondary owner
can claim all of the resources as its own. For shared use-cases,
the resources that are not claimed by the primary are communicated
to the secondary owner allowing it to claim them. This ensures that
Linux on A53_2 can continue claiming all DMA resources associated
with CPSW in the absence of primary owners, while at the same time
providing users the flexibility to share CPSW DMA resources across
various CPU cores listed above if needed.

While Linux has been mentioned as the Operating System running
on A53, there is no dependency between the Operating System
running on A53 and its ability to claim the CPSW DMA resources
listed above.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on commit
3cdd19089f1 Merge tag 'mmc-for-2026.07-rc2' of https://source.denx.de/u-boot/custodians/u-boot-mmc
of the master branch of U-Boot.

v1 of this patch is at:
https://lore.kernel.org/r/20260224120557.1476390-2-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch.

 board/ti/am62ax/rm-cfg.yaml      | 108 +++++++++++++++++++++++++++----
 board/ti/am62ax/tifs-rm-cfg.yaml |  94 +++++++++++++++++++++++----
 2 files changed, 179 insertions(+), 23 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 4e238883b96..36b0049f43a 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1064
+            resasg_entries_size: 1176
             reserved: 0
     resasg_entries:
         -
@@ -705,13 +705,25 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 19
-            num_resource: 64
+            num_resource: 32
             type: 1937
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 64
+            num_resource: 32
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
             type: 1937
             host_id: 30
             reserved: 0
@@ -759,13 +771,25 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 118
-            num_resource: 16
+            num_resource: 6
             type: 1943
             host_id: 12
             reserved: 0
         -
             start_resource: 118
-            num_resource: 16
+            num_resource: 6
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
             type: 1943
             host_id: 30
             reserved: 0
@@ -825,13 +849,25 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 19
-            num_resource: 8
+            num_resource: 4
             type: 1956
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 8
+            num_resource: 4
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
             type: 1956
             host_id: 30
             reserved: 0
@@ -917,17 +953,29 @@ rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 19
-            num_resource: 16
+            num_resource: 6
             type: 1964
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 16
+            num_resource: 6
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
             type: 1964
             host_id: 30
             reserved: 0
@@ -1009,6 +1057,12 @@ rm-cfg:
             type: 12750
             host_id: 12
             reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 36
+            reserved: 0
         -
             start_resource: 0
             num_resource: 6
@@ -1017,16 +1071,46 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 6
+            type: 12769
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 5
             type: 12810
             host_id: 12
             reserved: 0
+        -
+            start_resource: 5
+            num_resource: 3
+            type: 12810
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 3
+            type: 12810
+            host_id: 36
+            reserved: 0
         -
             start_resource: 12288
-            num_resource: 128
+            num_resource: 64
             type: 12813
             host_id: 12
             reserved: 0
+        -
+            start_resource: 12352
+            num_resource: 64
+            type: 12813
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12352
+            num_resource: 64
+            type: 12813
+            host_id: 36
+            reserved: 0
         -
             start_resource: 3072
             num_resource: 6
diff --git a/board/ti/am62ax/tifs-rm-cfg.yaml b/board/ti/am62ax/tifs-rm-cfg.yaml
index 78bbab38bb6..3706fac8664 100644
--- a/board/ti/am62ax/tifs-rm-cfg.yaml
+++ b/board/ti/am62ax/tifs-rm-cfg.yaml
@@ -244,7 +244,7 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 880
+            resasg_entries_size: 976
             reserved: 0
     resasg_entries:
         -
@@ -585,13 +585,25 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 19
-            num_resource: 64
+            num_resource: 32
             type: 1937
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 64
+            num_resource: 32
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
             type: 1937
             host_id: 30
             reserved: 0
@@ -639,13 +651,25 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 118
-            num_resource: 16
+            num_resource: 6
             type: 1943
             host_id: 12
             reserved: 0
         -
             start_resource: 118
-            num_resource: 16
+            num_resource: 6
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
             type: 1943
             host_id: 30
             reserved: 0
@@ -705,13 +729,25 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 19
-            num_resource: 8
+            num_resource: 4
             type: 1956
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 8
+            num_resource: 4
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
             type: 1956
             host_id: 30
             reserved: 0
@@ -797,17 +833,29 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 19
-            num_resource: 16
+            num_resource: 6
             type: 1964
             host_id: 12
             reserved: 0
         -
             start_resource: 19
-            num_resource: 16
+            num_resource: 6
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
             type: 1964
             host_id: 30
             reserved: 0
@@ -877,6 +925,12 @@ tifs-rm-cfg:
             type: 12750
             host_id: 12
             reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 36
+            reserved: 0
         -
             start_resource: 0
             num_resource: 6
@@ -885,10 +939,28 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 6
+            type: 12769
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 5
             type: 12810
             host_id: 12
             reserved: 0
+        -
+            start_resource: 5
+            num_resource: 3
+            type: 12810
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 3
+            type: 12810
+            host_id: 36
+            reserved: 0
         -
             start_resource: 3072
             num_resource: 6
-- 
2.51.1

