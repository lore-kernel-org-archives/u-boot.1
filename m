Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA1DE6BF17
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 14:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E895C84496;
	Fri, 30 Jan 2026 15:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dNJmylKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8A284496; Fri, 30 Jan 2026 15:33:56 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CAE4844A9
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 15:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRAxiWNmW0MtvA1kzSNk0ZfoCEE/lIwHjs4vwNKPbCxkYMOqWSGWpXlZMWGnVELOEHqHPvAf5CiWe9e4MBMdZ7FguNiGUPdR9UN76Up/ien683jcUbOgK8FxFMCTr8WFS9fo/RUZetZfIf1IchkLQ6xcmYXbxPQPPketvpJGbIU5tEnNFmShtzIDhb0thr9LATSRx59il9Ek6HcCV4nPrAxqkZQ21uXivzMWkLLllVaE3VIS1AkIcuUZtCYn31rHkE790TR8TRskQtL18ou6yrudTROtdy6LmKzfeBMDbuzp3rKlAv8tUzw5qXNil6KrXvSaHjqgts5BVuW50jnYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vsIQSyIrDHQOJ+lR/CPjKdOBn/TNW929hTGAiZ0ZeI=;
 b=mqOcf0lIJnGBsDeEwniPqjq2zpr/cCxJ2t53FOeaC76+MKvGRfzH6eBs+vkAYrL8ODk8+wrpTUgd2kjKs9bJpPDFnJmQEfGooV2+v00/LMriU+7f+upA/4GhwMctE1vIhqbgIHiuhD+ZTfOnYr6yfsK1PBaxfvO3qj4P+icgkJR1Wy4HGHLiCS+FAT/T1Rnl4b1qDNKqdjQjv/77yoTWGkja9Auw1l9rnyRY4Ay7lCWR3Hll7nN961EuPhbU7MdxYyhCYL55sOBiERRIKokIp/0RYT0H1eorvMywKf6ZeF3QRLhiru0oz4hwiz1nIf7SmnTAOX6gnSdSPqrFpFiByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vsIQSyIrDHQOJ+lR/CPjKdOBn/TNW929hTGAiZ0ZeI=;
 b=dNJmylKHCPdVfCIZtqMIs5+Or6IbqG2msEJZr8YQG8B3pDAu15zPqb48rBUaHpSEP8QPyXI/eiNqbITEm5IlBxWWxaFUu2rg6a58TR0uobCk97hwBXPw/dfBwjSaOn8/GVlV7abkYBKJ+hZG/ZNrwJpGZM192sxBXtmMIgcHEgw=
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 14:33:48 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::52) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 14:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 14:33:47 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 08:33:47 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 08:33:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 08:33:47 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UEXkGs1453928;
 Fri, 30 Jan 2026 08:33:46 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <sparsh-kumar@ti.com>, <sebin.francis@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>, <vishalm@ti.com>
Subject: [PATCH] board: ti: am62ax: tifs-rm-cfg.yaml: Add C7x resource
 allocation entries
Date: Fri, 30 Jan 2026 20:03:39 +0530
Message-ID: <20260130143339.1401600-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 16700720-ccd1-42bb-ae98-08de600c9473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z7W/7YQeItLnv11v9pfHa0P/UHxyOUi/DoCkhBWNQ9yqYqzlByn+YHlr1JfH?=
 =?us-ascii?Q?gX6sZiptDo7aXL7LLhbkwcdUrKY2ta5hviBqon0T0tmqKYjvgG0+RlrNEJT/?=
 =?us-ascii?Q?tuutjEsCcHHWOcwUiiMSriuIpHrw8ghC+wONKgRJxPgmQKZDTc4pwnYR0ITx?=
 =?us-ascii?Q?EwsiYGNOQVcfEJDK0S54xEJje0jl1kLk0VH85/Hk7fTebnsGgCc06rVSY83c?=
 =?us-ascii?Q?7Xw8lpHsZiAAbIE/cJvGWHzTe3OEzn/J0muXglNk9RVO9OZ2iyRCFxw/RDcl?=
 =?us-ascii?Q?SR5ZN7KqFnM7lDK+0dyfDk04MW77lvU5OipFw87eTeUOSeg8qI7u159dAJPR?=
 =?us-ascii?Q?QVYM7M14juLhLHfnmx79fRQJoqX7NtvG9Kwr/VEB2YDV2IvX4vC0+r0w70Vq?=
 =?us-ascii?Q?cUSWYigB4octWI/X8Db1X1cZPlxxxy9rZvtFK1OIPOIZ9A9Zf/tzv+F6cedM?=
 =?us-ascii?Q?ZTRfbZdZv9Q8Ad1FTLysGYoxTW+0zYNi/jNrpU+/Cj8ZPkAZYRsMHCNtCV3V?=
 =?us-ascii?Q?b3dRa1vtWBmD0jrNhTlUwFFEQCWoAbgt6/1QZzrDVJabMhgc0bKfax9do5p0?=
 =?us-ascii?Q?qXZ3cGnadfHSkypWW8hr6/XBg0vPzgQ6IJqGK9sWhHUc08EyklSp23ipwg5D?=
 =?us-ascii?Q?U1Jo+tgTyzmKNNmq4FRUWJs9YzGzbGo8q9qqT5kIul+Wu6BCkOVI0MHlEkke?=
 =?us-ascii?Q?ZKXBQKiaq6OcFn07ZhZ1+MaumL5T7ZUFBR82i/EfrzQoJ00smPiOM+n1oV/r?=
 =?us-ascii?Q?NYT4JruSvUtOKPA5AgDQtDsioBXxMCEPNa9e3hVpy7QCd5K33grjjgDG0XWe?=
 =?us-ascii?Q?Nx0QBfGl1tU2NLE/GDkrK9CrnTptAF+W4bXejdIXycP3TYkfEzHgAFHmNT1A?=
 =?us-ascii?Q?CAbIKftJc7OyNZIkdVuLKA/VTAgk0/6s9dLy9W3uawowTlF9o8hKS11n7dD/?=
 =?us-ascii?Q?SEyRF4fKXcmhnMKyP8BMtAoz92Q7BhVgxeUoxLqcIP/VJ2chk12gQ8zEHLH5?=
 =?us-ascii?Q?IM04aYwNSwqHO6huKVo5oXMfv1K9aq7+4eW9VV50zmujSGvLtA30XJFRhGIY?=
 =?us-ascii?Q?yUPgYcj0Mxei24LCxPDTx9K8vtNC8ba9zPfkZR0SlkTYKjfTIpAtGhjabbge?=
 =?us-ascii?Q?DBxJx2C7owYJEqiJNci0DuqNO/kSNyKm56I/5rTzRzooYjGVW2MyMrZPorqW?=
 =?us-ascii?Q?stY0um4dmGQ4l885/y6F+vvGwHvU7ATRhjzXvKPCzb+Wb/zfM8Wz/6hgE1Vq?=
 =?us-ascii?Q?vhsVEPCV3NM+1oNbYQ1slieH9qv0C2JmiuVPbuTwVJLk25ntBkWZ/DwjYE3I?=
 =?us-ascii?Q?DfPOptPEot4Secc7/jcFqlyzRp6FquMt73Tutav0YF4hvnDdUS1HBpeVVkzf?=
 =?us-ascii?Q?4wjumBqeALFZD/EfQ3RGX6LXGaYxe92l5Y0cbn8eMTRpwJomPUoAad9XXSp6?=
 =?us-ascii?Q?Oyh39r5NlSyBvjzNqzlmQOxGgIP3730EOW0LPFuywwf+6W0SeMbmO+x4MCVk?=
 =?us-ascii?Q?+PImTyvCd7JnwSCwetuUYT6oEVDM3LfjvU3xJGuLlkYWrdRuavUvCxXdLwYE?=
 =?us-ascii?Q?wqVgI3Koyrp48s53MG9X4RBzq+jpeRMgqEc0NcwWP/i0F4XtHfpbID/a7b6A?=
 =?us-ascii?Q?txHkV+zXb829/Ey+48OFw9M=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nF2kUTNCY4iaN0ubWyuQepdXrzAiCzUs/wIxfvuTqEeU3g+zhx/wH+lgB57WZilZMSbexQYS6ob6NMBkF0atfCL8V+De509HBOkHknbAQf7WhLg9gugZrWf0eGzcmIYSxrSgiyhf1L+JT1q3WLzdTPa/QSZ9BJwTfZ03hfrIJrWGiL3ebS22EiL0TLYXR6D26tVZRynd2f2aSMjvrJmbD/rAg6j1PoagPRkRH6qzp4vEyT0c655Mc4aKbF+FsC7+fq4ZoJVdj31y876kPyhXJhWGPwM3LZ0wvZ2jzd0ooF2gXu2TjH5Mqsp8wu/PylX3StkzRkcFKWOV2UzYa4203ZN9sztoqK4IeJqBpPaoMAmUCXOWeYI4Pn0+x6nBzt5MInTtvByGmeEAx1kzhvfLTy3JtBgFYQsSLxTlAfn8GHTfehvOxh3RUa+v7W0aLtqD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 14:33:47.8993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16700720-ccd1-42bb-ae98-08de600c9473
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
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

From: Sparsh Kumar <sparsh-kumar@ti.com>

Update am62ax and am62dx tifs-rm-cfg with allocation entries for C7x
core to match with their rm-cfg. Following updates are added for C7x:
- Share split BCDMA tx and rx channels between DM R5 and C7x.
- Share rings for split BCDMA tx and rx channels between DM R5 and C7x.
- Add global events and virtual interrupts for C7x.

Fixes: 01e01277538a ("am62a: yaml: Add board configs for AM62ax")
Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
Logs-https://gist.github.com/paresh-bhagat12/6a6e43025ffd8bac18f024a75cc8b806

 board/ti/am62ax/tifs-rm-cfg.yaml | 46 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/board/ti/am62ax/tifs-rm-cfg.yaml b/board/ti/am62ax/tifs-rm-cfg.yaml
index 151cd599b1b..78bbab38bb6 100644
--- a/board/ti/am62ax/tifs-rm-cfg.yaml
+++ b/board/ti/am62ax/tifs-rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62AX
+# Resource management configuration for AM62A
 #
 
 ---
@@ -24,26 +24,26 @@ tifs-rm-cfg:
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 -  # 2
-                    host_id: 30
+                    host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 -  # 3
-                    host_id: 36
+                    host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 -  # 4
-                    host_id: 0
-                    allowed_atype: 0
-                    allowed_qos: 0
-                    allowed_orderid: 0
-                    allowed_priority: 0
-                    allowed_sched_priority: 0
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 -  # 5
                     host_id: 0
                     allowed_atype: 0
@@ -244,7 +244,7 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 872
+            resasg_entries_size: 880
             reserved: 0
     resasg_entries:
         -
@@ -257,7 +257,7 @@ tifs-rm-cfg:
             start_resource: 18
             num_resource: 6
             type: 1677
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 18
@@ -287,7 +287,7 @@ tifs-rm-cfg:
             start_resource: 72
             num_resource: 6
             type: 1678
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 72
@@ -317,7 +317,7 @@ tifs-rm-cfg:
             start_resource: 44
             num_resource: 6
             type: 1679
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 44
@@ -347,7 +347,7 @@ tifs-rm-cfg:
             start_resource: 18
             num_resource: 6
             type: 1696
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 18
@@ -377,7 +377,7 @@ tifs-rm-cfg:
             start_resource: 18
             num_resource: 6
             type: 1697
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 18
@@ -407,7 +407,7 @@ tifs-rm-cfg:
             start_resource: 12
             num_resource: 6
             type: 1698
-            host_id: 35
+            host_id: 20
             reserved: 0
         -
             start_resource: 12
@@ -429,19 +429,25 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 6
-            num_resource: 34
+            num_resource: 26
             type: 1802
             host_id: 12
             reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 1802
+            host_id: 20
+            reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 35
             reserved: 0
         -
             start_resource: 44
-            num_resource: 36
+            num_resource: 35
             type: 1802
             host_id: 36
             reserved: 0
-- 
2.34.1

