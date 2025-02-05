Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5444C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18304805E7;
	Wed,  5 Feb 2025 14:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xlA9UZCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07D5806C9; Wed,  5 Feb 2025 14:14:52 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC23880562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515DElFm2536507
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 07:14:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738761287;
 bh=aEtxwR+R+5xD9TADE2zdRAHAWAt0B/oKozUowphHMj8=;
 h=From:To:CC:Subject:Date;
 b=xlA9UZCiAyl5o+1RM5zojjnENkRwjNw7MYjkCPyARDx71F6pKyRCm0PUQFXxrSzc7
 yVUlU8nJF59ZB/YdzoxzyVkSMVZ7RoaVPgmrVEbGw1XB/IW5ieE57qO74asX1eMuPc
 OVq05310zCLSE/hra1Y47t7ook+sPLJItHquzUqk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515DEl2E077452
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Feb 2025 07:14:47 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 07:14:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 07:14:47 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515DEhBK128350; 
 Wed, 5 Feb 2025 07:14:44 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <hnagalla@ti.com>,
 <vishalm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] board: ti: am62px: tifs-rm-cfg/rm-cfg: Update DMA resource
 sharing for CPSW
Date: Wed, 5 Feb 2025 18:44:40 +0530
Message-ID: <20250205131443.426635-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The CPSW3G instance of CPSW on AM62PX SoC provides Ethernet functionality.
Currently, Ethernet is supported on Linux which runs on the A53 core on the
SoC, by allocating all of the DMA resources associated with CPSW to A53_2.

In order to enable use-cases where the Ethernet traffic is sent from or
consumed by various CPU cores on the SoC simultaneously, while at the
same time, maintaining backward compatibility with the existing use-case
of A53 being the sole entity that exchanges traffic with CPSW via DMA,
update the DMA resource sharing scheme on AM62PX SoC to the following:

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

Hello,

This patch is based on commit
d6da3dbaef Merge patch series "cmd: Add support for optee commands."
of the next branch of U-Boot.

Patch has been tested on AM62PX SoC running Linux, ensuring that the
changes made by this patch don't break backwards compatibility i.e.
Linux can continue claiming all of the CPSW DMA Resources in the absence
of primary owners.

Regards,
Siddharth.

 board/ti/am62px/rm-cfg.yaml      | 82 +++++++++++++++++++++++++-------
 board/ti/am62px/tifs-rm-cfg.yaml | 72 +++++++++++++++++++++++-----
 2 files changed, 125 insertions(+), 29 deletions(-)

diff --git a/board/ti/am62px/rm-cfg.yaml b/board/ti/am62px/rm-cfg.yaml
index caa2f7a5a8..dc445a4b72 100644
--- a/board/ti/am62px/rm-cfg.yaml
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 984
+            resasg_entries_size: 1048
             reserved: 0
     resasg_entries:
         -
@@ -476,13 +476,13 @@ rm-cfg:
             host_id: 12
             reserved: 0
         -
-            start_resource: 45
+            start_resource: 44
             num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
-            start_resource: 45
+            start_resource: 44
             num_resource: 35
             type: 1802
             host_id: 36
@@ -494,31 +494,31 @@ rm-cfg:
             host_id: 30
             reserved: 0
         -
-            start_resource: 14
+            start_resource: 13
             num_resource: 512
             type: 1805
             host_id: 12
             reserved: 0
         -
-            start_resource: 526
+            start_resource: 525
             num_resource: 256
             type: 1805
             host_id: 35
             reserved: 0
         -
-            start_resource: 526
+            start_resource: 525
             num_resource: 256
             type: 1805
             host_id: 36
             reserved: 0
         -
-            start_resource: 782
+            start_resource: 781
             num_resource: 128
             type: 1805
             host_id: 30
             reserved: 0
         -
-            start_resource: 910
+            start_resource: 909
             num_resource: 626
             type: 1805
             host_id: 128
@@ -645,16 +645,28 @@ rm-cfg:
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
             type: 1937
             host_id: 36
             reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 30
+            reserved: 0
         -
             start_resource: 83
             num_resource: 8
@@ -699,16 +711,28 @@ rm-cfg:
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
             type: 1943
             host_id: 36
             reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 30
+            reserved: 0
         -
             start_resource: 134
             num_resource: 8
@@ -765,16 +789,28 @@ rm-cfg:
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
             type: 1956
             host_id: 36
             reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 30
+            reserved: 0
         -
             start_resource: 27
             num_resource: 1
@@ -861,16 +897,28 @@ rm-cfg:
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
             type: 1964
             host_id: 36
             reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 30
+            reserved: 0
         -
             start_resource: 20
             num_resource: 1
diff --git a/board/ti/am62px/tifs-rm-cfg.yaml b/board/ti/am62px/tifs-rm-cfg.yaml
index a80a275046..8026974805 100644
--- a/board/ti/am62px/tifs-rm-cfg.yaml
+++ b/board/ti/am62px/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -244,7 +244,7 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 840
+            resasg_entries_size: 904
             reserved: 0
     resasg_entries:
         -
@@ -423,13 +423,13 @@ tifs-rm-cfg:
                 reserved: 0
         -
                 start_resource: 44
-                num_resource: 36
+                num_resource: 35
                 type: 1802
                 host_id: 35
                 reserved: 0
         -
                 start_resource: 44
-                num_resource: 36
+                num_resource: 35
                 type: 1802
                 host_id: 36
                 reserved: 0
@@ -555,16 +555,28 @@ tifs-rm-cfg:
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 64
+                num_resource: 32
                 type: 1937
                 host_id: 12
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 64
+                num_resource: 32
                 type: 1937
                 host_id: 36
                 reserved: 0
+        -
+                start_resource: 51
+                num_resource: 32
+                type: 1937
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 32
+                type: 1937
+                host_id: 30
+                reserved: 0
         -
                 start_resource: 83
                 num_resource: 8
@@ -609,16 +621,28 @@ tifs-rm-cfg:
                 reserved: 0
         -
                 start_resource: 118
-                num_resource: 16
+                num_resource: 6
                 type: 1943
                 host_id: 12
                 reserved: 0
         -
                 start_resource: 118
-                num_resource: 16
+                num_resource: 6
                 type: 1943
                 host_id: 36
                 reserved: 0
+        -
+                start_resource: 124
+                num_resource: 10
+                type: 1943
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 10
+                type: 1943
+                host_id: 30
+                reserved: 0
         -
                 start_resource: 134
                 num_resource: 8
@@ -675,16 +699,28 @@ tifs-rm-cfg:
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 8
+                num_resource: 4
                 type: 1956
                 host_id: 12
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 8
+                num_resource: 4
                 type: 1956
                 host_id: 36
                 reserved: 0
+        -
+                start_resource: 23
+                num_resource: 4
+                type: 1956
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 4
+                type: 1956
+                host_id: 30
+                reserved: 0
         -
                 start_resource: 27
                 num_resource: 1
@@ -771,16 +807,28 @@ tifs-rm-cfg:
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 16
+                num_resource: 6
                 type: 1964
                 host_id: 12
                 reserved: 0
         -
                 start_resource: 19
-                num_resource: 16
+                num_resource: 6
                 type: 1964
                 host_id: 36
                 reserved: 0
+        -
+                start_resource: 25
+                num_resource: 10
+                type: 1964
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 10
+                type: 1964
+                host_id: 30
+                reserved: 0
         -
                 start_resource: 20
                 num_resource: 1
-- 
2.43.0

