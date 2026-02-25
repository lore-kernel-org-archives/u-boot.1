Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E9BFD375E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24DD83F8F;
	Wed, 25 Feb 2026 14:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b+E//qCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8F83F2A; Wed, 25 Feb 2026 14:25:57 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEAD83F75
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRW7X0smoNgNSCuPQxYqwWq7AvgaF6IlC3pyU+koZWZzPLFiouoQlzv8Ku/sIOI5AQ7+tTQbP8NnQdgzW69kwTG3CM1hEsP04loIesVTDoiaEBjGbejBSr5TN4nreLbgMYH7fhtX0I06WJUcberuiI8eXIa8AIyV2vjohCC0cQ8u9shwJCcRaaMmY7aw5ktF7GB52fBGNzEnpeANMLzSxN3NfuBI+DYG6HiLTwGZUdGRGsth4Q/rxIJbFKgxEg9gBnE21FBlY3gHCXgzyTnBEt3e41TQFmPiAQmfYlI3oPuQ5BWcWkSlmGlXzC5VlRnW5O0KnN9GoVPeks/DEBgT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTeohaJQd8ggogYYQjWDRuoJZmwXUdlMWtSfq4qVe+A=;
 b=opy6sYGu0NoqWwYxr6SdPUFv+Q1b5cfm+m9E0P/mCg+v2bF1giV7HpKinFqVQ5QurdxRhuQnWGO79Jyl06Oo4GGBkRiHZGKLfgUSULKhmuVIFqDFmK1YcUqlMN9NadhyZ35RGI1Bo10YYAw2jjrmbABLgUgjpz29BU1fMjk/ZYLra+i6ru4avqViCt3ZR/qtN1L6W4ID06r+C5916DqwmedFC0gzvP7jhavEv3TJMDPmN2geDzg/w7evin3erJwarzzI6mb5F4hkOdwESS5M0A6PUxV9IVOdddUqw6BySFoMBQfnaBKDN7nfEwcFistvOqjImXfF3fg3XW83X4AUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTeohaJQd8ggogYYQjWDRuoJZmwXUdlMWtSfq4qVe+A=;
 b=b+E//qCcRVz+Hv5NnhUKjUc1pNywPvFca6so4vxxaQ9kT/+ap7/W+n+aETIKQKBlPbuKk184LGZyLM26VRpD09lBDoN3qHn9R5UuiZPmQszWaKoLtCNBZ0/8adZ+P/YE979wKNi72RpKo5dNeSdaP7GWT7vUGldUE8LRFRx/J4I=
Received: from PH7P221CA0067.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::28)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 13:24:51 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::fa) by PH7P221CA0067.outlook.office365.com
 (2603:10b6:510:328::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:51 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:40 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:38 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGq011150;
 Wed, 25 Feb 2026 07:24:35 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 2/9] board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with
 TIFS firmware updates
Date: Wed, 25 Feb 2026 18:54:18 +0530
Message-ID: <20260225132425.3096103-3-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CO1PR10MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b34bf25-80cf-4b17-a51b-08de7471418f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34070700014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: pSnUnefD7mLofp5D80qI4l82azYjd/7LnlkFwzVmg/+uuK1pVaY92tRwPovqP37eg1gFf7Yjjt30loEctn/uLYIb0gGODwZRWDfRRHZziiJh5BBhzSIBBjhE0nUtENHtPXPNWy2mOxwO61xlWXNafj+hzetFBOQiY7OswPyY6m24yCDv0EaWkZGw8Q6VAmdRG8n8E6exIAT4Ty8mXyu1+HaIM/S+ZQHDKddyaqIxaEKTZws18F6VhrHwC49KCSw7NmzIqdorkKAMEI6n6MUM89S+R0z920FYxiO7GlP7qtGSNnTDbZY6Bbftc54ppFV9nm4miz3NmW+TquuyDmcPAOHPm06A8SojsIBmxlFbYufax1kyhD5ZZFLp62y9YHMzBx7w1gjOGofWcz4DJyXZmTvwnSoLcWHHExvatP/934byGck3QgxnxF4ihTe+hF4J0bdpjnt/hh6LKB43iCpDVQvhURsciTUy6W9Ey6y3eGBLNU11he9BqH6DGO6x8h0d/5x12azH26B48f0+SxJS9TEmcBlxssY3KKJ2d4gHFuxDKn6iyfTVTqeCPI0D9//HvonmEPYzxZaiH5GxnFmHe4OZlLZF3R8JEBy/HglooytPXcUnGsf79fd7fhxG1tlYZIMNbeoEwbDgU9J27fP2Ctk8RV0RgcOFbvkDAculPC8HPrVqGVj8doYWUgTLL+Yj/5Rqf2GRS/7KV4HydtQp9jDyFUVqF1M1w+8dvyONrp8NL5eX3n2KFjQqVbbAWfCpVEdAlzZJgvEHFjXm3ofp3A==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34070700014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5jJqOc+zzo+AWSE94eOUa0LBqdOtUeWTb9KHzWuwgn/InCngvuO8LNRhiR/Dm/dbDmrWBWOgKSezeMZkXmEIXfShpEZns7Kt9Jb44d3FG534JEdcxzvxkFfZnchjEk7m3W8yKqiusvEdyrF7Mdk+0NyHuTeP1vyKjyaA7jWQ8qwN6uETegclBLe5oC/hca5EvHYYtQ6JNhAsC9qE8sBxll4CWjdnnsodLQhBjNoz9spr85vewPnXm+pfst8UJZZd3stqZzdRFfIivL8W4XE0LKtXh3FdNR2FekO3AStWzEFe2E+8MwjDAb9pY/yfjWe54eq2hrZRlBsdLG6TOv8eySmQ05KAuRiiT4vnP0HgI7KkfjgcVeMvZiuNZlsh2gFCR2FOirDLNBoxllEJ+NrHMKWwtQoGST+BVfhLcB3JbQ34eWW7MPyvTer1MtWtfd4V
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:51.2317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b34bf25-80cf-4b17-a51b-08de7471418f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:33:08 +0100
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

Synchronize tifs-rm-cfg file with the latest v11.02.09
TIFS firmware rm configuration:

 - Update am62px tifs-rm-cfg with revised resource allocations
 - Apply formatting updates to align with TIFS template

This brings tifs-rm-cfg in sync with the rm-cfg changes
earlier in this series.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/ti/am62px/tifs-rm-cfg.yaml | 1476 +++++++++++++++---------------
 1 file changed, 762 insertions(+), 714 deletions(-)

diff --git a/board/ti/am62px/tifs-rm-cfg.yaml b/board/ti/am62px/tifs-rm-cfg.yaml
index 80269748057..73efceafc75 100644
--- a/board/ti/am62px/tifs-rm-cfg.yaml
+++ b/board/ti/am62px/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -9,231 +9,231 @@
 tifs-rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #2
+                -  # 2
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #3
+                -  # 3
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #4
+                -  # 4
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #5
+                -  # 5
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #6
+                -  # 6
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #7
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #8
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #9
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #10
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #11
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #12
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #13
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #14
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #15
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #16
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #17
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #18
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #19
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #20
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #21
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #22
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #23
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #24
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #25
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #26
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #27
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #28
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #29
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #30
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #31
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #32
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
@@ -244,684 +244,732 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 904
+            resasg_entries_size: 968
             reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 18
-                type: 1677
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1677
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 57
-                num_resource: 18
-                type: 1678
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 75
-                num_resource: 5
-                type: 1678
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 75
-                num_resource: 5
-                type: 1678
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 52
-                num_resource: 5
-                type: 1679
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1696
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1696
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1697
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 5
-                type: 1697
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 5
-                type: 1697
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 5
-                type: 1698
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5
-                num_resource: 35
-                type: 1802
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 35
-                type: 1802
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 35
-                type: 1802
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 168
-                num_resource: 8
-                type: 1802
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 29
-                type: 1807
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4608
-                num_resource: 99
-                type: 1808
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5120
-                num_resource: 24
-                type: 1809
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5632
-                num_resource: 51
-                type: 1810
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6144
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8192
-                num_resource: 32
-                type: 1812
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8704
-                num_resource: 32
-                type: 1813
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9216
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9728
-                num_resource: 25
-                type: 1815
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10240
-                num_resource: 25
-                type: 1816
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10752
-                num_resource: 25
-                type: 1817
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11264
-                num_resource: 25
-                type: 1818
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11776
-                num_resource: 25
-                type: 1819
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 25
-                type: 1820
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 32
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 32
-                type: 1937
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 51
-                num_resource: 32
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 51
-                num_resource: 32
-                type: 1937
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 6
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 6
-                type: 1943
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 124
-                num_resource: 10
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 124
-                num_resource: 10
-                type: 1943
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 4
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 4
-                type: 1956
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 4
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 4
-                type: 1956
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 6
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 6
-                type: 1964
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 25
-                num_resource: 10
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 25
-                num_resource: 10
-                type: 1964
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12750
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12769
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 8
-                type: 12810
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 3072
-                num_resource: 6
-                type: 12826
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 3584
-                num_resource: 6
-                type: 12827
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 6
-                type: 12828
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 1676
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1676
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 5
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 1695
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1695
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 5
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 25
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 25
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 25
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 25
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 25
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 25
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
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
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 6
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
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
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
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
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 6
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
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
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
-- 
2.34.1

