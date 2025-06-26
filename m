Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD35C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9ED80E9A;
	Thu, 26 Jun 2025 14:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QA4hOo3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F08B82AA4; Thu, 26 Jun 2025 14:39:55 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C68809A5
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqrkXUElyx3vlBg1M898oemfod27oEmRLXs6jr3ktu0cDtf2wGl+AtbldfKO8/PD+e4xbkL8rEPrNhcrv3rO6VTJRFeC88q3E9/2nVPDkgOkQqeQDglwoa6L4Wn2t+LkJXMJPv+wkMQE3jMANm8PXGNoNgFVR6Dvd1u7LhZioQ6b+IhxiZZl6etrHuv5vTHc5J0p4pxqgPTEBSDyPOfCUBZAstIlZR95sK92oYu20B6NYSa5YeYceM7SQWHwc26O3NPi/KHZBCk2AU/KLIqD7e4qeEDZgshO2UP56IQarHvxV+YsjUAjdMrc5Er/o28/s5SzR8PNpSOdAcftMcN6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRJquJmtYVmlLynXGZhX8ZdU3sO3Aj2yskmOv+8hcnI=;
 b=Yn3fRxmLm1L3m3+8XY/CPtjxS1Blm0SexAvN29/N9rE9OU6kjgsO+MIwpjEJDKvSYb74Jxv1ekgJxQlHTiFTy2EFwe/OrSaqfbEzTVljgxMlCSPfImCcl95jze7YJZ8p9TCTfPaCTMdRdkAvV26MNAr1Xc6FKXmluqF1mU0xOb3/MpCeu/FgMd+Tgek3v7OSzVObB+MpS4cxIrKI3DvzcowJxKmBI9cIWLRvmV3TkRqjeo44rL/Mn6wCWrFE91Z5tZt16M3eh3X3PJniD8CLZeLDkMXN3QUGOFS8ULtqVs9ZaDt+zZfnBGYpVxcNixyCXFW1iy/MFFfKXyYlbJ28Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRJquJmtYVmlLynXGZhX8ZdU3sO3Aj2yskmOv+8hcnI=;
 b=QA4hOo3RAtu8epfKneNXv10PE9xY256wiiaB6DNhNK9c8/QCHPg9qqDjNzHMaN1Fd1ydKq52x6z6BCLHb3otslj5dhvkABzUbs5mToegBDbHvD39xUMX1DYwb89wKEHaWoY3f1XdBI3pDBb84kNbPUvocmksrjYBWx326GxaOTeAojAJ4+pz3AiEQhNNMHFqAYZC9bk8jBwwI36UMkH4WijBoEVZQrhbKHXNHTOoNZ5KWQhnKP7iDZorco62PXO6E0aIAYip3MyOB7pBo5jwTInlY9JV6fdHqYvlRptqkoOy/uXl8CWIoSLSBJ4jglC50betSfGlbDY71bL+iCBgdg==
Received: from AS4P189CA0037.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::8)
 by GVX0PF886830E71.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::7d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 12:39:39 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::6e) by AS4P189CA0037.outlook.office365.com
 (2603:10a6:20b:5dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 12:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 12:39:39 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 26 Jun
 2025 14:39:39 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 26 Jun
 2025 14:39:38 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <d.schultz@phytec.de>, <francesco.dolcini@toradex.com>
Subject: [PATCH] board: phytec: rm-cfg: Update rm-cfg to reflect new resource
 reservation
Date: Thu, 26 Jun 2025 14:39:30 +0200
Message-ID: <20250626123930.128398-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|GVX0PF886830E71:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fedf3d-4330-427e-8425-08ddb4ae846a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oao9cO2AHwxN0tenAbG+JqiOj39q4YN7RZY+iRGBrbwBuJ8cW6knu37uXBm2?=
 =?us-ascii?Q?flAtlXmhkXtsOW4jOpgzpzBi6WFFKwsPEXxQXEb2ZXhgy7nEhf7YiAOVM5A4?=
 =?us-ascii?Q?z5/t0gcVglpv7AyrXZnRgHIT0OF3KJv9EIVj4pJfIGS0IgLM4iQ9e/PrSbxV?=
 =?us-ascii?Q?R7c7Pmo3PUQHvoQwGms2JkzcF3NuauinElcHcHjuYdGr+9sezmm7mQTqZDGy?=
 =?us-ascii?Q?LFfdyIRir3R68FDLtC5+3ODMHPOHAokjHUHg9YHmLyCguwuSqLRBq/H9bWvD?=
 =?us-ascii?Q?u/ROnV4uwhwX6omwTILcNsf2qyTg68vQWn5uTP8KgNnCHLYHmi+FFi81+Jl8?=
 =?us-ascii?Q?g2S+VBdOiqNHDAWTOmXEILdmUL9hTHuxvs3i4l2k/KkTom3U2e5UZg8Gp8pa?=
 =?us-ascii?Q?/OLyps7LKUaK6/fsMZs3/LjCa/6OHCEXTcvs6pBgc2FIHVDyx6e/pisrV6F5?=
 =?us-ascii?Q?Cs4G0TGUiVnQrpTxSICEHdyVCo8prD6Ia29l22XmDm4YuCABvj+KJzlJIqh4?=
 =?us-ascii?Q?rOfY/Hmc1yqAmlb0W0Wl7FFkEBxSuscjgw2AXZCxSXyORL5g6+NmOyRtGYxK?=
 =?us-ascii?Q?bO6nDw+pGiVmZpv+qtghX6bWrlCX+uUb/LZGw5ftCYtIf0adifrWzk5g2m9N?=
 =?us-ascii?Q?wWTz1FaAvWikQXNoQ9F/3+ytE5o/5iJKo/hXpgevMamp3qRPwbv+Na1HLhCE?=
 =?us-ascii?Q?+ftBj0k/YvSjMpbpOuCsKKoHxkbi8i49p9Yq8W8/WV3WjJa+Xan8NkkT1kmH?=
 =?us-ascii?Q?4w0/i4+xoqekY5dcqA/QBG8+1AT+SrX275/ho2NZO+eWkN0X/unryGQwyea5?=
 =?us-ascii?Q?/sDld/bM45FVQlq6wJYs6BLl3U2NO8J3tuXp2KBZCA37VPxxSnOYKilEBBX6?=
 =?us-ascii?Q?xTXHx72Rbz+HqBBw3CO8a+zPeaDUsr67WJULSXjLo3wQiT6osdumYB6ZpaH0?=
 =?us-ascii?Q?HUjvxA/cUwMjh0SByv3WnoIzqBLTxEgV7FRaWHgwmZlgkFKPX3hy6iJ6ITLb?=
 =?us-ascii?Q?lpXEEO6gBZYj/jOSe0050u4e+4zuYtcDdAN2gwtdTs+jZAxR+Q6Cexanw0Fw?=
 =?us-ascii?Q?Vfxy1G+EfhrBiAqmapfJMHqhNAJtJAhV297jRJIwMy/Y/KPzQ07CkBtvbJaH?=
 =?us-ascii?Q?x3J86pd+ppxr0IPxg5SMAVFjOIRIbhvTZ9YWP//SdA8sf5aU7tZ+dSqCA86z?=
 =?us-ascii?Q?vkUp02VHU7kJjOUS78mDVrwhhZURZSp5wtO3BZRiO7/ncGduThrZW9dIJGJJ?=
 =?us-ascii?Q?4ZfIZYl33mdeMS2jtZ0FGe/6DRdn5A0LX13f4r2jGpGtdMSRBe9D/B/WYOgM?=
 =?us-ascii?Q?y4N19GK1kfvyKM8J7Bz8ZsBMWO2wnD19FhN1SacqT5cQDzhC1BfPIGA4lUaw?=
 =?us-ascii?Q?69AwYv1Z32pZLHdLQ2DZlEEQpP8BVPMCu+BdEqcbAbRsWMyfWIgY4G6qUNYu?=
 =?us-ascii?Q?PZK6H1SGQArY6YYpfQ3NbOdcO3j/rpWunkGLzczlC++cMYxJKr9CNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:39:39.4185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fedf3d-4330-427e-8425-08ddb4ae846a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF886830E71
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

With the latest TIFS firmware, an additional virtual interrupt and
event is reserved for TIFS usage on am62x and am62ax devices.

Update the rm-cfg to reflect this new reservation.

Based on commit 87720385ab69 ("board: ti: rm-cfg: Update rm-cfg to
reflect new resource reservation").

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/rm-cfg.yaml | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/board/phytec/phycore_am62x/rm-cfg.yaml b/board/phytec/phycore_am62x/rm-cfg.yaml
index e4221f82f92..26d99b03b80 100644
--- a/board/phytec/phycore_am62x/rm-cfg.yaml
+++ b/board/phytec/phycore_am62x/rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62
+# Resource management configuration for AM62X
 #
 
 ---
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 960
+            resasg_entries_size: 976
             reserved: 0
     resasg_entries:
         -
@@ -285,10 +285,22 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
-            num_resource: 4
+            num_resource: 2
             type: 320
             host_id: 12
             reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
         -
             start_resource: 4
             num_resource: 4
@@ -501,13 +513,13 @@ rm-cfg:
             reserved: 0
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
@@ -543,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 627
+            num_resource: 626
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

