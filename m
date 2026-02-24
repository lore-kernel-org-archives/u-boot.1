Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61CAE9B250
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FC383E13;
	Tue, 24 Feb 2026 13:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BUhAswxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679D383642; Tue, 24 Feb 2026 13:04:44 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BC783E13
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCbjVQF1Y5TV77N5s7154GZ2V8Ki+qrCM0U0L3nhiamAhEgkoY4m3SI4++aJYCV2g/an1d1PHh1ew9oimtR4gpsHdZcbKMB54cRdUHMefeiCNXR+tJzPIDLBRM0LQjio7K8MiIwvWLqKAOVv0ofsk0vlgzmLE99UWXxMuD+8bIKQZc2HAQU91IAj05oAgXTeXfeUYu1jXbIeEhv52MZ1w5qtoW1es6brAXcj4C0Rhu2YI9WDzBw7GNKlBpM3sUnfqjjhRHqkkfYo19wghHHH9yDCsJG21ug2jhXji32UIDUUuQ/j4hxzSmzLz5qLv1cpGASs4EHXqG4SB6FIi2ncTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jjT8Q1smRIcnjwOQ6Ov3lq/3WtNC03qauXtXWroaQE=;
 b=sZCm1vnhXpPgqzkexPBejtjo0XqTQmYGr7+6NuNxc+eVJbi6wtrwSgN24yS7voBhKLJMfa8sU4U/zoe+irO81ty7VWMD0RbYKbh0+ZeFVxeUOTrBsKDVGTorxDgMozt5lCmau8FG0T5xBMk80ZlwFl8uPsxs9k5NbMi0/kvX1PkCeDUKcNgHoLGg9VlFqWmfUyJTOlWi4/pBj9e+k6KzntwPndlFC6X9clmJ0lswZ9kwjUtfd/RMIenVpwjOksmBfDlYMZObEalY30UJazXVnw13scfTwVum/B1bpHzCc8xooSuD6Ca9QaR+GL4MsNewA8RLAjpJYo2TMnmfgEQf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jjT8Q1smRIcnjwOQ6Ov3lq/3WtNC03qauXtXWroaQE=;
 b=BUhAswxvYuFpHQ/S40Z0i/7d4aCl/j0Q/Ou1bZqGlN31QrVA50nVDveKMRw3hNX2WTRsKwNX87f9OyDqkes5HxHitFfcVclDm/3WevnKExN2E3ShvhGe6gecjz8iEEoWSCSg542hUB6/71SDbiDWqjfPMxtsIGTL+I+4dU9dq/U=
Received: from CH5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:1f1::16)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 12:04:36 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::d8) by CH5PR03CA0014.outlook.office365.com
 (2603:10b6:610:1f1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:04:36 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:35 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:04:35 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OC4QPb2202322;
 Tue, 24 Feb 2026 06:04:33 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/2] board: ti: j722s: tifs-rm-cfg/rm-cfg: Update DMA resource
 sharing for CPSW
Date: Tue, 24 Feb 2026 17:34:48 +0530
Message-ID: <20260224120557.1476390-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260224120557.1476390-1-s-vadapalli@ti.com>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a816d5f-12ec-4a88-2d5c-08de739ce134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+I2V2P+brMxW4K9/C4WcXStohORmxRsDn+QPqNZhwZcpSHstPBGLJwPx8ALO?=
 =?us-ascii?Q?w5KUOFeYVziAs0utFDcCfqqSDJTRQw/W2OzXv56jE0RWu3wNO9vf27l/GRmZ?=
 =?us-ascii?Q?zAuFey+H1GLPnAIXB+JtEuqhCtUYJpGOZNxQq5R+SsNtyjiMiGqNoW5Zr+Qu?=
 =?us-ascii?Q?VRWDObxFG/l5gaGKhWSBZ1tDnBZOYMJib9uHPaVrdRK7h2+LPbPU7wQKiUEb?=
 =?us-ascii?Q?0Dupp0CwIhZ2XMg/Rihdk6b6Dlpq+44ethC6HTI7ehHgo/xMxKTuABhPNw8J?=
 =?us-ascii?Q?p3qZYePquO6IPTlVnLctYYhqqZdvF86tMh2wjw65uPzOcjcsrYBBR0Ypda3P?=
 =?us-ascii?Q?FqIpm4B+H3bgsVqYvE1fKSRx7ouR6mvKwuVwRZns5rcPvI2aVLpB2Ln3nFt5?=
 =?us-ascii?Q?3JGabwokssFYFAGUPqpMi0K4JvCXVaR1hD9zzEzjhSTXpiW/t1b5x93Ww0cB?=
 =?us-ascii?Q?hVR1zZh1i8ufgUcrzvcpndDn61cy4Tl4kkrdllSWdqxJipOvr7ifikjwRuql?=
 =?us-ascii?Q?DgpG7fB22HUdKDnvfANT/0AagKgjBJACLTVUhGJeybUxMn8Fopp3TfCNZ6yv?=
 =?us-ascii?Q?oGFor94EAjzrEybf2JSTh3UBsG44ZLYvA1s8aWzkKqEIEGKoADZYh2Z6ciR2?=
 =?us-ascii?Q?mFUZuQQdfNgKdolk8GcmyloSdEe3Zgq8ZpTpYth297D7XEwqoeyvNgmPjCf9?=
 =?us-ascii?Q?uSzWmVlmbVmS4Em1QPxY12YcpccFM8it8OevFSVraUhtH/xlwJKm/GPYlxTt?=
 =?us-ascii?Q?aJ3rqtolkGrFIQ6KxZ/o3eD75Hx8EERsZ1ukO4EDVfp4S5TEB4k/5KZ10OlQ?=
 =?us-ascii?Q?dluo4bua2lsq1+SK412mZ6QiXORKro/zaOMcsdUrEcWxO9ryH/B+FHqm6smf?=
 =?us-ascii?Q?9EIi+q0tPNF9VgdAtV121A0BgQJzo1NLHpYHlsVQZbpM7g9OA2sJLYikKnTh?=
 =?us-ascii?Q?tNSBv8VIL0tu7uFE7MnX7AUxG/ltMX0pGL/g5hRnT4WeOrOQ0qgVPLF2eQdr?=
 =?us-ascii?Q?xU7HcJij732ENDgoCjQzGZpeAWke+8iYy7xOjSy7IQzQzSp1aQcKs2vnYTHJ?=
 =?us-ascii?Q?d/kvlj7etnYm1Dh5+/k+OwsEVGMGtFuWk4NMLGf7BDcxRBR1JstS3a0WlJ5o?=
 =?us-ascii?Q?zCQqAhldQE11XnPX1YdyeiCivn7hYEQmfooe9atp8zyQqIpzNwivu9tRbAGm?=
 =?us-ascii?Q?7MxNdWqNIDl4YVN/WO+alLed57ELct+c1fB+LLPoyv1j5JrfsjfoBJtfwr8j?=
 =?us-ascii?Q?oKwzN3tbDhq4EXw5wtZBapzzvhPozRNj7KkwmZtASYSzTzG3U6et7ZhvTJ2q?=
 =?us-ascii?Q?Lo9BwAbpcJPoITbQqllTSMGhZMSv53GD2xUUVeD0oA1hqxMLSd2J9TSxdTRU?=
 =?us-ascii?Q?mmKhii/z1Qj/M6rNX4CvCWujppDL6E0jsru5RZPj3bRdLj9RbbIH5+eHh4sU?=
 =?us-ascii?Q?RuRk2qMljBxX5IQxU/PDT+l31wm1ljYGfZWpLN+iao6mh5NBcgoXNJe96LPZ?=
 =?us-ascii?Q?2Y3OcKKDIflSAHrtLf3m1MwpDe+hooZEduviq/Ivsqtii5wJXNEDZvpf/iCt?=
 =?us-ascii?Q?pYiu45yZRzZR2WwvPSnp954uaDSLH7euHiHrn840qfPO6JpfUK5Sf15LWUEO?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rma1Fubkil6otd/USGNIsc6yOADOcVJSFOP8K1uI9qNjLfXi1MVy7eAw3gDAMsLqLX+KSXqEY7Ov7ygDpFVxh3PeuvkHZvDW/BAVwHcn2pUzmfgAgnkYbkEoflPtxv5w/HZEh4vzCNLXmX0jD7udhdpF2+p3s46a+rS/KInlHfYfhjfBN7EQJ8f7qtYeB8DFUAZgU+0GFBccQ/75r9ejyN3+3TBb5Km6vJ/iB7u/g4DktsQu5BP+EEol2H3z2UnjhBECLwVyqy0XDtP8HFdmknLXfbCiMj+3nG6dgP6SW+4P9OW2oO0Q3kqwhQY0MdzE/0U/c8sXqsdl2A+R/2i31rHwfvxjNoWdsBKtPItIwFb6zB+v94m2ccsakYnpI1FWAe4lsJs6pKMBP5kBjCG/nHbXFWPJMlvPYCmBMc5g1Sj5aB3WmehdcIcspSlVMOoL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:04:36.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a816d5f-12ec-4a88-2d5c-08de739ce134
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
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

The CPSW3G instance of CPSW on J722S SoC provides Ethernet functionality.
Currently, Ethernet is supported on Linux which runs on the A53 core on the
SoC, by allocating all of the DMA resources associated with CPSW to A53_2.

In order to enable use-cases where the Ethernet traffic is sent from or
consumed by various CPU cores on the SoC simultaneously, while at the
same time, maintaining backward compatibility with the existing use-case
of A53 being the sole entity that exchanges traffic with CPSW via DMA,
update the DMA resource sharing scheme on J722S SoC to the following:

---------------      --------------   -------------  ----------------
   Resource              MAIN_R5         MCU_R5            A53_2
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
 board/ti/j722s/rm-cfg.yaml      | 124 ++++++++++++++++++++------------
 board/ti/j722s/tifs-rm-cfg.yaml | 104 ++++++++++++++++++---------
 2 files changed, 147 insertions(+), 81 deletions(-)

diff --git a/board/ti/j722s/rm-cfg.yaml b/board/ti/j722s/rm-cfg.yaml
index 62730adf216..7fe21892055 100644
--- a/board/ti/j722s/rm-cfg.yaml
+++ b/board/ti/j722s/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J722S
 #
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1184
+            resasg_entries_size: 1192
             reserved: 0
     resasg_entries:
         -
@@ -717,15 +717,27 @@ rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 83
@@ -771,15 +783,27 @@ rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 134
@@ -837,15 +861,27 @@ rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 27
@@ -929,19 +965,31 @@ rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 36
+            host_id: 38
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 20
@@ -1017,13 +1065,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 8
-            num_resource: 32
+            num_resource: 12
             type: 12750
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 32
+            start_resource: 20
+            num_resource: 20
             type: 12750
             host_id: 38
             reserved: 0
@@ -1035,13 +1083,13 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 32
+            num_resource: 12
             type: 12769
             host_id: 12
             reserved: 0
         -
-            start_resource: 0
-            num_resource: 32
+            start_resource: 12
+            num_resource: 20
             type: 12769
             host_id: 38
             reserved: 0
@@ -1053,22 +1101,10 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 2
+            num_resource: 8
             type: 12810
             host_id: 12
             reserved: 0
-        -
-            start_resource: 2
-            num_resource: 2
-            type: 12810
-            host_id: 20
-            reserved: 0
-        -
-            start_resource: 4
-            num_resource: 2
-            type: 12810
-            host_id: 22
-            reserved: 0
         -
             start_resource: 22
             num_resource: 18
@@ -1077,27 +1113,21 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 12288
-            num_resource: 56
+            num_resource: 64
             type: 12813
             host_id: 12
             reserved: 0
         -
-            start_resource: 12344
-            num_resource: 48
-            type: 12813
-            host_id: 20
-            reserved: 0
-        -
-            start_resource: 12392
-            num_resource: 48
+            start_resource: 12352
+            num_resource: 64
             type: 12813
-            host_id: 22
+            host_id: 38
             reserved: 0
         -
-            start_resource: 12440
-            num_resource: 64
+            start_resource: 12416
+            num_resource: 88
             type: 12813
-            host_id: 38
+            host_id: 128
             reserved: 0
         -
             start_resource: 1536
diff --git a/board/ti/j722s/tifs-rm-cfg.yaml b/board/ti/j722s/tifs-rm-cfg.yaml
index 7b2e58a89b3..a6b7a089e36 100644
--- a/board/ti/j722s/tifs-rm-cfg.yaml
+++ b/board/ti/j722s/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J722S
 #
@@ -244,7 +244,7 @@ tifs-rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 992
+            resasg_entries_size: 1000
             reserved: 0
     resasg_entries:
         -
@@ -609,15 +609,27 @@ tifs-rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 83
@@ -663,15 +675,27 @@ tifs-rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 134
@@ -729,15 +753,27 @@ tifs-rm-cfg:
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 27
@@ -821,19 +857,31 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 36
+            host_id: 38
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
-            host_id: 36
+            host_id: 38
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
             reserved: 0
         -
             start_resource: 20
@@ -897,13 +945,13 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 8
-            num_resource: 32
+            num_resource: 12
             type: 12750
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 32
+            start_resource: 20
+            num_resource: 20
             type: 12750
             host_id: 38
             reserved: 0
@@ -915,13 +963,13 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 32
+            num_resource: 12
             type: 12769
             host_id: 12
             reserved: 0
         -
-            start_resource: 0
-            num_resource: 32
+            start_resource: 12
+            num_resource: 20
             type: 12769
             host_id: 38
             reserved: 0
@@ -933,22 +981,10 @@ tifs-rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 2
+            num_resource: 8
             type: 12810
             host_id: 12
             reserved: 0
-        -
-            start_resource: 2
-            num_resource: 2
-            type: 12810
-            host_id: 20
-            reserved: 0
-        -
-            start_resource: 4
-            num_resource: 2
-            type: 12810
-            host_id: 22
-            reserved: 0
         -
             start_resource: 22
             num_resource: 18
-- 
2.51.1

