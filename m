Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCEE9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F51583EC0;
	Thu, 19 Feb 2026 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Rv0rrfVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F17B83936; Thu, 19 Feb 2026 12:59:24 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7F8802C1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss8Q1vtwvdsbvHvyEZ3UJZVuLhIXs8cR9jDjmIJPyaz/SaNVto+CZIhs2GcnxzvHEDXHU6DlRNqnJldfF+3qOeVaqq20OuviVDEUMPyPvQCYwpegYOU+5ZP8+JMV8hFI5fCgkSecyv/vQBXGuRhQyvuvDJRBc9UjiV9VKFfwGpyYtJ33e+S/TuH3IHdtXCxZHW4jddoAcbK95tg2kyi6Lhdz82//4XaT3d7JgNBqaXArbDpamDy0Do76ufyKCQd6K2J4w5dxZ4zmUT4wOr6e7cYNmGNhB2R1mINxEU4lNPS1z75mkXnFo8be0MrY0N+Q6Yzb+pSA73EsURIqKMtH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkdSEnxZMCD+LQHruu4YUa55PqfjHtMn3qSecpusbGo=;
 b=RXLkNKy63JzKauLYDZaqxxXGIETiarnstRmEUBi+P5DaFStcDAS7IoG0VCy+ubWj2D92CLKQj3cYnQTQvAL5WJ5Xs9SpBrNW0xwKzgSW928yWiHjlCOxSJXmwHBZLefWZm9iBGs+paBKIN1CqObdgm1krHoK7CDT+4r8242uxVDdZXejTf3B9Uy8Il7EpneEY8ezfnOyN1Xy8kDdrpkUxmjiAhD7opF+iaID91RLqM2ZClI0BE1jpJDj6ZgS42ai8MQL4JFBaV/ToJwNCBNNFM7Vzk+nLi+TTq+qwZdo20kA7GlxIUvvLiKpdOFuQgu1AdN75JLXRhtuvqpclaU6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkdSEnxZMCD+LQHruu4YUa55PqfjHtMn3qSecpusbGo=;
 b=Rv0rrfVK4r1zLmEM9swS2esk91a6A/WpGTOI9u4NSPCqLfkucsJfjMtqQeR38PaEw0b5OBWRKd0vRZDeB/TsyyEnBqFmPUW45U6wJsKGE9ORGVY7pl0hugV5mgrWqE7s3owhhIv7BpMZXUC9bH1u2lVKMlMr6voJ4ymKcSwsNWQ=
Received: from DS7PR03CA0249.namprd03.prod.outlook.com (2603:10b6:5:3b3::14)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 11:59:17 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::87) by DS7PR03CA0249.outlook.office365.com
 (2603:10b6:5:3b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 11:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 11:59:16 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:16 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 05:59:15 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JBx59v2535407;
 Thu, 19 Feb 2026 05:59:12 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH 2/4] board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with
 TIFS firmware updates
Date: Thu, 19 Feb 2026 17:28:35 +0530
Message-ID: <20260219115837.965532-3-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219115837.965532-1-sparsh-kumar@ti.com>
References: <20260219115837.965532-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e965f6-9f3c-4bef-3683-08de6fae4e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WzCykNotGNaTkkuuvhNv8ynBvN3A62PWGgwLX/UZmcmUXa2W7U+NOkQMQ/6M?=
 =?us-ascii?Q?9Ci+XOW+VHJoFqeQ6ZtfdHxCFks/pNdGUcw2fFHiBV0ycWRkaDDYC91G59is?=
 =?us-ascii?Q?hjBKQapl5cKzKPMie5LfJ9kB9Ufcp0okThDgrgjwAFXUeRw2oB//bgiNuh6d?=
 =?us-ascii?Q?CKcNj1cyH9bIDZldZ49E7lkJ6YoqVAMFYfEzzDN1KAz68kZBZRgDEU1IneD9?=
 =?us-ascii?Q?wyVMDD9bJW9fYDkxnMvh9K2svovxluGcqYizy17ksilFNIzbZQQ/+qw7pYiB?=
 =?us-ascii?Q?CoYdxrIU/fhOA+d57WqY3NiTalXGK4bxm4Pc1CYLIepWtDzMQ9H81RvAlWW6?=
 =?us-ascii?Q?Jf8/mDQuId8sLkK8R9KEx0ceCGOGmK3KyEPXVHDuXaSPemV7ebGrUWmE9ziq?=
 =?us-ascii?Q?8RIsGMnwRgGs3Pgt9oqMOlVFnrdgvqQiwFI12TpXMw5hrDHESIIwsO3RUFkh?=
 =?us-ascii?Q?EKOuXyGA7dnA6Rqo+okIHPLWhj3kY1PEWpDuS2LZYZ4tsTRzQKr0/BYv/7TO?=
 =?us-ascii?Q?PhaRrAmppRjBLfay+x1RxtjZKG/IlA6q9a7UL/D13l9ZZ1xnUYDeeONzICAM?=
 =?us-ascii?Q?xkzG6O4/quDsz2Bzr+ftaferPPcY8o2dCtz0Nt393uAdYkBD+u6N0b/NcslT?=
 =?us-ascii?Q?fPQMjJHU2cvcUImd1ir+LfpKyww6dVN4rNTMZFN7Wa6I8HeT7MFnw252jNun?=
 =?us-ascii?Q?WRYsg6k3ek1Ph1M+VbkZEmtnJGn3r2fXupJ4Gr5p0fyiA3jR4OkQasSduib0?=
 =?us-ascii?Q?OS803ICP1Vuqsek2MARg08W3dJK1oyJWDORvWu5yw3zF8m/UiduTa/NTZ3FS?=
 =?us-ascii?Q?qejZT08b5mJPAvD42gHx9rHX8rtqw3nuJRRbsx82Xi55TV+LLrAWrU+LZihQ?=
 =?us-ascii?Q?ZCl1xkHcnof7uL/7kN700M3XTdPM8z93pdSKebJHogfCuxdkKm/yQo2UoGSQ?=
 =?us-ascii?Q?BPlIv1xR42S1C7fgWWiHXWYQRnD7P9BfyNqRy9Yj2yawkGZloGhUBb9C/m0J?=
 =?us-ascii?Q?xMQe3upBjoDL9CxDt1EOJDM7sKSTPtYOzBxIzYpgA6K595Es+V0z8vCoBYsJ?=
 =?us-ascii?Q?D6vlznJbUMQGYOyxTwFvJAf0xsK2IB7CQxcq6Wb4xtMqOXAXDPSj89hl71B8?=
 =?us-ascii?Q?4ouGR36klvW8ta1H5sVlSFTF8A60Cv6ljkUw6dOnPrPCdMH/Fyk1feudQ87w?=
 =?us-ascii?Q?8Oz2VLVWoKZ0Ep2Ms+PjZ3wN2oxj4a3ibQN8Eo0Kl5W7Vb973+11RYquY8sK?=
 =?us-ascii?Q?f3e/xK8OqmCXesFtf2fSp33R71IcoCc18SWzcs9LnzzyNKOgytpOwzMfx2q7?=
 =?us-ascii?Q?1pQMKWoaXs3HSzzFzWf5e16Vj1eWiJwRLzdPf+TjwaicXWfIO21EuKq08Zus?=
 =?us-ascii?Q?AjO7/QJMenWPKph6DRalH7nYWvstyJ/hWeZVrywiaVqpMxNAPVCkI96/Icnu?=
 =?us-ascii?Q?AsAVhhwFTE69H/ygwa2Mr1RfCUjNkqm1oDVQotG4T/oV1LI9zUP7wgQfuWQ5?=
 =?us-ascii?Q?t8QYOf/7YNc+xaaXR09yJLJ+wwcuYT7JcmD+Ers41syZnnilv9n6B2zCDinB?=
 =?us-ascii?Q?Zz9EUBabi/B+A76zlmKeL8RKuYlfB6k7T++DX0aJHa3iRIUvasnq0odo5bMg?=
 =?us-ascii?Q?wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: icsD59a/VNjRFqX1CeDaQ2+dK5B4Kx3T8uDSEkVkIGPxOgp29ZAM7g+raCRVDmBU8YxdZPO1ad9l/SoHFMlr0+OioIHp5a39aV0JUHuYUeHOKyvCxdJyQfvSbdWzMvokxd5NfYqUGT7AKZhYOfz/6dt2UVnUgzMF9JZcpDjdI1Dp9nBo37lGt8a/kp9TJ8kZZEO9IzILORvel+NA/0K8OXA4Yhyilytx2GgVQxL6eJvibRQmQTS1HM69W7vlem2TGm37R8kq/iLmVBpjiBYjdKV6c+zp9hMmwDDMMKpUiQARyCLGQ+KvHYYzHWgeMq37JjzBuWwRIRoqEhPnQ9+RxA6oEFlw/mtqIGFH4rj5dXbGY0zdhJ7t0Uqu8eItOTaC6tqIzU/r4kY9dqevbsuBAc2uB+gIjnRGNM6rsQ0nLx9sYZZmmkub5fKvyLR8NbPV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:59:16.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e965f6-9f3c-4bef-3683-08de6fae4e8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
X-Mailman-Approved-At: Thu, 19 Feb 2026 14:37:09 +0100
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
from commit 22cc77516ac7 ("board: ti: rm-cfg: Update
rm-cfg to reflect new resource reservation").

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

