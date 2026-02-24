Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C92E9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653E083E48;
	Tue, 24 Feb 2026 13:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l7B2ybLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08B383642; Tue, 24 Feb 2026 13:04:40 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1832383DEB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZm1vCH0Goaz7whpEYnCBI9y8n9u7G4p5hXnpqUDkv9JIw0JH0OLIZPQodMy4mdFFDfz6p65NM4awEW3hRkPHd4d7sPl/L2gfi1hulXjqONeoFXfgyWrPVXBrR1qOFx9x9FPTKQWKeQvsHq1vJdFVf1gw/5PGH9qcc7L3JfspGvjJoSX3Fr3q2NJQJUPQEecaFgZUIib2WlfKmkKfDb7Q1KCrG0v5difmvLPTkIYcf8nSwb/4EfaF41TFoJ9/gn6rCmucMXEb29z2CZKAKhu4b0P+sxz0LbgvREu+A+NyZXE+I0jqjtv4+0iWGRmSMS/9X77M3AV0uNVHzKAB5/W0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzlVP/oBt+vBiVwaJIx2U3zEbN1MoN9/IxV7If15CmQ=;
 b=LwgQzIo5CkyF6gRXtraTo3M/GRBDrI/CiuJack5dhve6i+rMZ6ycsAIRmRHxjb8NKevYuUfqqsebW27iaRWLLMaIPxuf99Rl0mMxKkcyqEwhy3BKXRcrueeR1YbLIU+8Y5iKN3e2kJlt5Ud1A+FzPkCjiDeZI3rm7pyxvb+ScIOuh5xyjAdI2R2GkpWSFm5PoJbXMRUKllncEOwvQscZAM61UX6koppmXw9L9BDcNPJKlnvEG11SEgieTnVYTHCxGwpQ3r9zA7HR9gxNh4BP72CzRVRqpaFm5VtszD9E7nUpq0GHJPYlAru1arXjG/Q4O1z9TWI93OBndumslcjW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzlVP/oBt+vBiVwaJIx2U3zEbN1MoN9/IxV7If15CmQ=;
 b=l7B2ybLrswtsEBw4lKOMuVYTQ2koyu0JaWnkUciQRU47cCA/vJ9KRQ1dB/7XBTF55cba+c22g6IUzRJzuPm0wbEmS0pprB7qnzNR+Z3bU8i0DSOEYxAGwvq9dG+GgMHDRD7/jtDNjwgnBI+giddrh8IcjQQEfvYPFrgt8wgDupw=
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:04:34 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::cf) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:04:33 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:33 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:04:32 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OC4QPa2202322;
 Tue, 24 Feb 2026 06:04:30 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/2] board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA
 resource sharing for CPSW
Date: Tue, 24 Feb 2026 17:34:47 +0530
Message-ID: <20260224120557.1476390-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260224120557.1476390-1-s-vadapalli@ti.com>
References: <20260224120557.1476390-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a88ae1b-7f0b-41c1-3fd7-08de739cdf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJ8QpusF3C11NWdrb9CgooA738olAGATZK/atW1HLVFSxzuQdO7RbxIK/ifV?=
 =?us-ascii?Q?1/7ZONt5gd4+/OFOBhLLMrkBnQ72Ev9kgqutsekRrnRQkdWW9NGy/b/LZw02?=
 =?us-ascii?Q?XVgsdOmPuLMJyvKyzuoW/AcQpDBijBas7gElkZ1jGTlVHQpdVE3f4+CItJGO?=
 =?us-ascii?Q?yT6OhxGPW0eaeK1AaQXBmqhow1NBurQBWlZstfRbhgGKtvUc7CAafv5EDsaU?=
 =?us-ascii?Q?QEx8tLxvbUZP1El7z9nrBz1wgZVsoAeVPSG37npbnHMGBQ7IMa8voSzdPYbK?=
 =?us-ascii?Q?B+ZnNSnb9L2j2NkTq8+yMcOavbuGWuAX6uAAeKeh8VOrNdbMqMTRcy6+FswC?=
 =?us-ascii?Q?07zEWRCQuWgIrdvi/IL7BnGPM8owpiWijtWbfc5aJAsSgVlC+TmYeWXmkWxd?=
 =?us-ascii?Q?MNnlx8kEkYc9idl+lIAX78WMixVC8uT2GvzaAnDHjZBaMt+/SpM7OlIMrLnd?=
 =?us-ascii?Q?eGbGPUwmP84YfEnpLF0TbUaRVRd028inNlm519jI5yHROow8ICc3VHrxUEgP?=
 =?us-ascii?Q?kNjZl5Jq16o1Om7hXiIlKGDL/CEXEtOrsR8wm7O3iGBT7BZW9A1rQFtK9c8I?=
 =?us-ascii?Q?bWEmxVxnC5GDApcto7ROL6wv0RhtAzCgJVJ+Ry26N9sgx3CD+dy5BFaH5mBN?=
 =?us-ascii?Q?dLnCFl4sM5Y09FJO18BedFAEprpbhu7OWhRy+C8qIK97eP7YK/JkSxYYqEbk?=
 =?us-ascii?Q?j6hcHtmxKAWLNuJGxxmWGBcrTB8epYKTLcXZj2bv+67wfCBogByJgOBQuP9c?=
 =?us-ascii?Q?llbHbMObs8zj9UiQDu5sMNbudJzcALREc7iSOkldHjhf93c7dQ5mA7Hue+th?=
 =?us-ascii?Q?G8zUpi+C86dpL6ARknF2zCoECi5AZOhbOQ5u4WuYeIpxZqoSSh/RS26ircPg?=
 =?us-ascii?Q?rbYEmM4tAzgN78LZYGWntOFSU4KPrc1RkbklKUxY+dUtgjA0654hLBoYTjSF?=
 =?us-ascii?Q?ow1VEQ0BOxbzweeP2Od24f/EFEqHCjxgZDMf68FNTpEv5gktbCDqm1OcYVm4?=
 =?us-ascii?Q?qur99j07kJ2aAivrLlnYhlE2JMQkWXW++uOPVXOMr7JZkVsbVuCH8PR7z508?=
 =?us-ascii?Q?e8HFXSWBxPWuyRivmKc3FLkT3WQcC4rf4PII+2P/YWCmOrvWI8cYrv6hNRDI?=
 =?us-ascii?Q?nqfRk/5/YnLm/9SiP8HKQyIaNsk7WS9emmPL6LO9WCE3eU44s1OFbjkaRkXW?=
 =?us-ascii?Q?ACLvZjwmFFXXxN/mIPXvGqjO/4oI9RiBFxgvLTn0VonAkJW7CmqUAZRc3jX0?=
 =?us-ascii?Q?+Cf1SYkpqQqzBtlzmNm1tOThgGk4A8bX/gD2DuqWxg3kCvZ7zlhcsaeil8Zp?=
 =?us-ascii?Q?YsqtQR6bH91mkMIXsKGJ64e45MxTRHa4BilqJAwDU4QjFLgXfVwutF6QEUwW?=
 =?us-ascii?Q?RsKBIDvbD3fvNYSGDocZgZ/EqooEWaWwM9hkwJqfHMIHQUryHS6emA2DwroN?=
 =?us-ascii?Q?+vdGUOVX5a/aTGBrHdVTxv0uWPACy0ohfI0o0PM5yJu/0PoPv3QAsE2LYG1Y?=
 =?us-ascii?Q?GIU8uQqEXcXUmwzVOVICZXFtZdzoV19JsfRRfX39ql9auCDMKaWMhemQv2ak?=
 =?us-ascii?Q?zN+uRTpyeg4Ij6vLG3pdpE8PDLmKBDzEE6IjoJ1c1yvhJcc+p+gkuAt7MEOB?=
 =?us-ascii?Q?Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B/sC7dvZSM15b8x9PUuX6uw0ZWPD9edXBzlj3VAN4sb+p1f2Q6qrj7p1dln6RxppOD+DZ+L+OLkvY1hm4lIo8A6lXMFaasijLqBEMkN7uqLuoVa7N2bvshlwCAbPa7XgM02V57X3mkxGsnLpYZbFyd7UxNsdKBSqxBQ1NCME1ZmFJb+WxCzUT8e8dnexB6syHQU6++cFu1BplRqOJ3IyQmN4g4d3/HFwM2CO0/MkTJTt5qIPn1Ai87zuumSzhBjzCB4SnEuxaPwczG+eObKbDXcy95/N5xdjLmvCdzD4daPmriJTlk4NQFiuGm0BwyIhW7XEHdFDrS1vibQQiX+6teZe1BeV1r6xFH1DDZqkCbbcKWvsiZ3+wdjglE3iIfEC3/uxVbQPZJhMxnla+RfgrQZH3U9Ok9IOd6xpjcyvDlDd7gVoOiJW3fkhnQNDfc9u
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:04:33.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a88ae1b-7f0b-41c1-3fd7-08de739cdf83
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
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
 board/ti/am62ax/rm-cfg.yaml      |  74 ++++++++++++++++----
 board/ti/am62ax/tifs-rm-cfg.yaml | 112 +++++++++++++++++++++++--------
 2 files changed, 144 insertions(+), 42 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index cbd087de797..89e1c49a2af 100644
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
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1064
+            resasg_entries_size: 1128
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
diff --git a/board/ti/am62ax/tifs-rm-cfg.yaml b/board/ti/am62ax/tifs-rm-cfg.yaml
index 151cd599b1b..fcb057dbdac 100644
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
+            resasg_entries_size: 944
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
@@ -579,13 +585,25 @@ tifs-rm-cfg:
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
@@ -633,13 +651,25 @@ tifs-rm-cfg:
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
@@ -699,13 +729,25 @@ tifs-rm-cfg:
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
@@ -791,17 +833,29 @@ tifs-rm-cfg:
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
-- 
2.51.1

