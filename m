Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A002FFC5936
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 11:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E348383E63;
	Thu, 26 Feb 2026 12:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fb2tThHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D1D83E81; Thu, 26 Feb 2026 12:38:13 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DAE83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcrCtyfcpnHUaAY/l66EZhbAZXo3J00QTsq/gLTY34D9c1td4qA/2MsJZqQOT62Fpzak8wIib3BE/bYDb+qXowvRz9/PQRPSeSwKpvRw6d8+xb44GLwk/6D+YDkvLkpDKP0lRnioRmfa4mH2MK2wkYYU2vSPvDcAmBa2A5Z/kFO0sezAoc6hLlxXrQOjxcQRBYpaELos4L51eBVhz5kO5alg72e+L8QZyBHn9UIUTtwamfu7c0wbB8fB2G8xdCv3GKHrJpawWRbaNA4eXs0kApBLj/eoWsHKLlBiWxjWIb7iKJ2q/KSTgh6FksAHHh9gPWzgab83t4kwh5B0TboXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFvNyHNTnSAKFFgi9gWjYUKYfOTciSjgFjoXnW0eT8o=;
 b=cMr9pE4r1mYsXgS5cNqEa/dMBq8/ZR5+I4yY2YsOjXDwyTCsW7jxz55mcN4zsPW36JZKOYrd5zjrHDxal/lvW0eKRMqenNO/mjCI/CTaDLt5Tv6wHI0hfr2xLR5ibVCEmjVHLsqHnhCFGkofFR3V0LgoHZ+0EQ0y0kYGmxSvJ1ntxnLXFoXYj28BLgDqdmTcXOQAw+5u5JvrLD867+gs8M4UxS0PQ3TrZYRpa2kAbN2iR6UQgkfHrIvDmLYLgXpXbsaRC3NRgmqa25ER+CixWz71LEdecMeZlaIbg50qD/jM/f5MlbNLXAUAAWX11G9KXV+jUa7ZsSRIJ01yO8pXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFvNyHNTnSAKFFgi9gWjYUKYfOTciSjgFjoXnW0eT8o=;
 b=Fb2tThHKQnyiOwhlw4VvKSsezuC02ipu504zcsRgQyjC+lCKILr/kw9ZlCumBOhFY2S2+zUbWAPF2smek+PqoiUR4A0tf7SkQJ4V6Vem3+n/2tgvfHow2Fdz9ggNaE7Tb4B6LGBaCBXL5sloY4Yh9EwlfVz+Sgn/SX9JfFMBtNk=
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 11:38:06 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::f9) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 11:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 11:38:04 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:38:04 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:38:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 05:38:03 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [10.24.50.245])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QBc1GS1805496;
 Thu, 26 Feb 2026 05:38:01 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 26 Feb 2026 17:07:57 +0530
Subject: [PATCH] board: ti: j7*: Update rm-cfg and tifs-rm-cfg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-board-cfg-update-v1-1-9d434890f537@ti.com>
X-B4-Tracking: v=1; b=H4sIAJQwoGkC/x3MTQqAIBBA4avIrBuoIfq7SrQwHWs2KVoRhHdPW
 n6L915IHIUTTOqFyLck8UdBUykwuz42RrHFQDV1NVGHq9fRonEbXsHqk3F1NPY0uLYfDJQsRHb
 y/Mt5yfkDBVr/l2IAAAA=
X-Change-ID: 20260226-board-cfg-update-bf29728f478c
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772105881; l=12174;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=CYC0R6XD9kRcEz9wZv1CeRdJFTNjdOaHwVwXFrRCWrU=;
 b=96ikkofhaAkdV6BLOn7EwR5YlrSs1QcUeLyYZOxrxgrMXGyWJ9ilCLAdZ9xOlsR3JeSAx9+s0
 W1SfO35WOZcChscN7fO+E3l5Ik1lSpZWo5ZZWOkxJG9bU2a6ge3FbC4
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: fea784d5-8ba2-4477-46fd-08de752b8141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: x4mVBcZE8iJ5tcWd3E0pSq3idFiFLl8FpX0ms653qDVZshR0R9WFIkH7A3gIN9UH+9s/pBoCoC2pwiuQSUPjT/6Vc2GJ83t4jpPmxlsmVfRJU+0xJ/kgzz2sCYgAYGdDD74MaT0Pj05KkEDiQphCURxV7wG3RFIwIIv3d9NRIEzDi8x2iEzfqA2xeTw7dWPQRSUsNt2wsd6+JK66aSrzauPxHlFdsuigHQgs+JNgCcR1MoEQJG/GIMyj8AH3l7yR7JQamKQfjiwH4TWZzsk7hCMu50TNVMxI9gLJ4tQsj2ydePaytAdtEpXzvb20IAvhNgogz/30SEsG4HN6q5/oqBiO1Oaegfve5uRMRpe3h7JZmvKWsSlChyzcrp2R0TQGh4yU46PKSen0Pyd1QH8hGOgBkQbhY/nHjNoHP8GH24P98TVxRpAb85dmhQJk9Jw2pyuzsJxByXsxoTUgyvAicmOvOQdVs0fYbNWkfUibnd2l4ufg+awnZZV19LRT8cr+fnCTIfru+tBhnX8CKjQWg5khlvHW3J4EqZeKRPdDsje0acoRzjNHzDRJGOFgbPeCmQ8iqT3ksZ2umK1UiynfjTBZf6Gw+xtFCsjvGcRUlrs9Dblp52FJZW08iddYOnqkzNRZAcvzJ5+EHOq31qbKkguYvh5Mr+yqbmSst4yf0xgEH8zb494oCRXzsysnNjw9soVsFqmRK2/7KpKWd0uKhO1UXPY8Cx3jT4j4vhZrnSZepnKhlrVVS1H6hVFbVZc7R/7sNOg1Xe2/KIeQpkWXGg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BgOgbd+HP7bXgYlUcAcvctXV8VTomnoe6z5Oo9NXVmb2jj402dPcH3T9kuzb94BQqK4Bm17RpQ3bYi9xuwAhTQAMTRczdt6D5dHm13NCbWV1oTt++wh9iJWnc310D9GoHN02Jil7JuMm/k9KMApXuro02JYP46b+t1cJdg6noUcf08tR78JVqLq42cVTHMA2QMRe2hDWAZMelaJndm1GssxmyUo0f9RRdyztytRg8EvhDxwdaX6smOzZlfH1fkG72y4PdJx5ljmgC/MZqgCQSTfETPXdJACjpwF2B118AIBVgDySb+Nug1l87M4Kf6ldqwNfwYoL59OwY8VL0YZRrUQvxAr38o3iPzwsOP/rlfkRhH1INEffQg0VKb43pZiWNWC+Pp515jRj4ZcbGDRoUq4S1M7FPiQgVDZfILqYkL7tSo3FIHgWf3myrnCaZaOx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:38:04.4622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea784d5-8ba2-4477-46fd-08de752b8141
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
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

Repurpose the allocated resources with version V11.02.07 of
k3-resource-partition.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j7200/rm-cfg.yaml       |  8 ++++----
 board/ti/j721e/rm-cfg.yaml       | 10 +++++-----
 board/ti/j721s2/rm-cfg.yaml      | 14 +++++++-------
 board/ti/j722s/rm-cfg.yaml       |  2 +-
 board/ti/j784s4/rm-cfg.yaml      | 40 ++++++++++++++++++++--------------------
 board/ti/j784s4/tifs-rm-cfg.yaml | 26 +++++++++++++-------------
 6 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/board/ti/j7200/rm-cfg.yaml b/board/ti/j7200/rm-cfg.yaml
index 9da0ea91adab..e1973de821fe 100644
--- a/board/ti/j7200/rm-cfg.yaml
+++ b/board/ti/j7200/rm-cfg.yaml
@@ -399,7 +399,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 224
-            num_resource: 32
+            num_resource: 30
             type: 13386
             host_id: 128
             reserved: 0
@@ -441,7 +441,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 2578
-            num_resource: 2030
+            num_resource: 2028
             type: 13389
             host_id: 128
             reserved: 0
@@ -1041,12 +1041,12 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 10
-            num_resource: 128
+            num_resource: 126
             type: 13632
             host_id: 12
             reserved: 0
         -
-            start_resource: 138
+            start_resource: 136
             num_resource: 54
             type: 13632
             host_id: 13
diff --git a/board/ti/j721e/rm-cfg.yaml b/board/ti/j721e/rm-cfg.yaml
index 88ec2026db0d..86d30a963751 100644
--- a/board/ti/j721e/rm-cfg.yaml
+++ b/board/ti/j721e/rm-cfg.yaml
@@ -495,7 +495,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 252
-            num_resource: 4
+            num_resource: 2
             type: 13386
             host_id: 128
             reserved: 0
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 3686
-            num_resource: 922
+            num_resource: 920
             type: 13389
             host_id: 128
             reserved: 0
@@ -1635,18 +1635,18 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 10
-            num_resource: 100
+            num_resource: 98
             type: 13632
             host_id: 12
             reserved: 0
         -
-            start_resource: 110
+            start_resource: 108
             num_resource: 32
             type: 13632
             host_id: 13
             reserved: 0
         -
-            start_resource: 142
+            start_resource: 140
             num_resource: 46
             type: 13632
             host_id: 21
diff --git a/board/ti/j721s2/rm-cfg.yaml b/board/ti/j721s2/rm-cfg.yaml
index 8796463129d2..86d572b4b336 100644
--- a/board/ti/j721s2/rm-cfg.yaml
+++ b/board/ti/j721s2/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J721S2
 #
@@ -429,24 +429,24 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 10
-            num_resource: 100
+            num_resource: 98
             type: 14528
             host_id: 12
             reserved: 0
         -
-            start_resource: 110
+            start_resource: 108
             num_resource: 32
             type: 14528
             host_id: 13
             reserved: 0
         -
-            start_resource: 142
+            start_resource: 140
             num_resource: 21
             type: 14528
             host_id: 21
             reserved: 0
         -
-            start_resource: 163
+            start_resource: 161
             num_resource: 21
             type: 14528
             host_id: 23
@@ -1431,7 +1431,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 236
-            num_resource: 20
+            num_resource: 18
             type: 16970
             host_id: 128
             reserved: 0
@@ -1497,7 +1497,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 3426
-            num_resource: 1182
+            num_resource: 1180
             type: 16973
             host_id: 128
             reserved: 0
diff --git a/board/ti/j722s/rm-cfg.yaml b/board/ti/j722s/rm-cfg.yaml
index 62730adf2162..e5f7b24c1d1b 100644
--- a/board/ti/j722s/rm-cfg.yaml
+++ b/board/ti/j722s/rm-cfg.yaml
@@ -591,7 +591,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 1297
-            num_resource: 239
+            num_resource: 238
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/j784s4/rm-cfg.yaml b/board/ti/j784s4/rm-cfg.yaml
index 6968d317522d..6fb717e4808a 100644
--- a/board/ti/j784s4/rm-cfg.yaml
+++ b/board/ti/j784s4/rm-cfg.yaml
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2023-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J784S4
 #
@@ -454,36 +454,36 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 16
-            num_resource: 80
+            num_resource: 78
             type: 18112
             host_id: 12
             reserved: 0
         -
-            start_resource: 96
+            start_resource: 94
             num_resource: 14
             type: 18112
             host_id: 13
             reserved: 0
         -
-            start_resource: 110
+            start_resource: 108
             num_resource: 21
             type: 18112
             host_id: 21
             reserved: 0
         -
-            start_resource: 131
+            start_resource: 129
             num_resource: 21
             type: 18112
             host_id: 23
             reserved: 0
         -
-            start_resource: 152
+            start_resource: 150
             num_resource: 12
             type: 18112
             host_id: 25
             reserved: 0
         -
-            start_resource: 164
+            start_resource: 162
             num_resource: 12
             type: 18112
             host_id: 27
@@ -1720,72 +1720,72 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 56
-            num_resource: 56
+            num_resource: 54
             type: 20554
             host_id: 12
             reserved: 0
         -
-            start_resource: 112
+            start_resource: 110
             num_resource: 24
             type: 20554
             host_id: 13
             reserved: 0
         -
-            start_resource: 136
+            start_resource: 134
             num_resource: 12
             type: 20554
             host_id: 21
             reserved: 0
         -
-            start_resource: 148
+            start_resource: 146
             num_resource: 12
             type: 20554
             host_id: 23
             reserved: 0
         -
-            start_resource: 160
+            start_resource: 158
             num_resource: 10
             type: 20554
             host_id: 25
             reserved: 0
         -
-            start_resource: 170
+            start_resource: 168
             num_resource: 10
             type: 20554
             host_id: 27
             reserved: 0
         -
-            start_resource: 180
+            start_resource: 178
             num_resource: 28
             type: 20554
             host_id: 35
             reserved: 0
         -
-            start_resource: 208
+            start_resource: 206
             num_resource: 8
             type: 20554
             host_id: 37
             reserved: 0
         -
-            start_resource: 216
+            start_resource: 214
             num_resource: 12
             type: 20554
             host_id: 40
             reserved: 0
         -
-            start_resource: 228
+            start_resource: 226
             num_resource: 8
             type: 20554
             host_id: 42
             reserved: 0
         -
-            start_resource: 236
+            start_resource: 234
             num_resource: 10
             type: 20554
             host_id: 45
             reserved: 0
         -
-            start_resource: 246
+            start_resource: 244
             num_resource: 10
             type: 20554
             host_id: 47
@@ -1876,7 +1876,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 4472
-            num_resource: 136
+            num_resource: 134
             type: 20557
             host_id: 128
             reserved: 0
diff --git a/board/ti/j784s4/tifs-rm-cfg.yaml b/board/ti/j784s4/tifs-rm-cfg.yaml
index 992ea23155a1..738fe0ea07df 100644
--- a/board/ti/j784s4/tifs-rm-cfg.yaml
+++ b/board/ti/j784s4/tifs-rm-cfg.yaml
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2023-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J784S4
 #
@@ -1456,72 +1456,72 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 56
-            num_resource: 56
+            num_resource: 54
             type: 20554
             host_id: 12
             reserved: 0
         -
-            start_resource: 112
+            start_resource: 110
             num_resource: 24
             type: 20554
             host_id: 13
             reserved: 0
         -
-            start_resource: 136
+            start_resource: 134
             num_resource: 12
             type: 20554
             host_id: 21
             reserved: 0
         -
-            start_resource: 148
+            start_resource: 146
             num_resource: 12
             type: 20554
             host_id: 23
             reserved: 0
         -
-            start_resource: 160
+            start_resource: 158
             num_resource: 10
             type: 20554
             host_id: 25
             reserved: 0
         -
-            start_resource: 170
+            start_resource: 168
             num_resource: 10
             type: 20554
             host_id: 27
             reserved: 0
         -
-            start_resource: 180
+            start_resource: 178
             num_resource: 28
             type: 20554
             host_id: 35
             reserved: 0
         -
-            start_resource: 208
+            start_resource: 206
             num_resource: 8
             type: 20554
             host_id: 37
             reserved: 0
         -
-            start_resource: 216
+            start_resource: 214
             num_resource: 12
             type: 20554
             host_id: 40
             reserved: 0
         -
-            start_resource: 228
+            start_resource: 226
             num_resource: 8
             type: 20554
             host_id: 42
             reserved: 0
         -
-            start_resource: 236
+            start_resource: 234
             num_resource: 10
             type: 20554
             host_id: 45
             reserved: 0
         -
-            start_resource: 246
+            start_resource: 244
             num_resource: 10
             type: 20554
             host_id: 47

---
base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
change-id: 20260226-board-cfg-update-bf29728f478c

Best regards,
--  
Manorit Chawdhry <m-chawdhry@ti.com>

