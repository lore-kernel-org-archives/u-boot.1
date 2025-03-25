Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B81C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B062281C84;
	Tue, 25 Mar 2025 04:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iUVrOCLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8306E80EEF; Tue, 25 Mar 2025 04:58:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DC581CA8
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjfp8OT9ORE+SwaK5pzocVacwop6lmoc9mNHosbcVtBSlHkiaZXqg+Q5ymClGYlb5GuoJdL5LezEBxzdk94ORjZHy2LPxNcWfbKhgS1HKPo6PqULHtJoxG0ihiAq12meh4QANhpNOh9bUI86vjpu2BkNYaVzL9D3ewIx5ZVIYZghP0XDV6Mn6XIGLfq6sJbPfevuCQQpA3LrdEsfmFwQKYmy9ajzDW1T0+nW/pwLKVdgBc55pxNYEvd/jNEcEMBV8UQndmEK9yTKV6zr5nmFLOeIaaYJV8WS0pBB9J4YBlAJ95UURXZzgWtMMNURb5WY0WgClzz0M6ckZ2yQaEZniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74ukdqVX1BHEpxed3WM7TlrQMrhk5mlf558TbeFc09c=;
 b=o0/Fi8SKuUXiGWoMHj43U02nbkaJS9HZLoT6FClMZrWfrEK8KX3xAMt3I2WM7/GoIJpv1LJxzBeAI00G+xnXVbSLU6eQkCJL/D0bgcBAPf3QKKreIbyW0ThQFl0FPR7dhKVVyWpq9BB3TUOg5wk6nA86ZYFFk6kz2dqIlqO1VMrn0OzJEosFp3t4C7Fs6AyyaEgAN61r5MuJXvJnly4V591hAkj7+VXpyvvvZc921WRf+RCBexK2gairXS08s+DvxAtOXOVKMdU5SwTieSzdl078fQUIFXIP+RCyLnP1VXI7Pw7yZxPrpx1ID/QUypT7j+scHfThIQLu7hk5jUHCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74ukdqVX1BHEpxed3WM7TlrQMrhk5mlf558TbeFc09c=;
 b=iUVrOCLOH7OBG6BQTZ/vTA2v8xjmfz1LymmUIK77dIy5IjFjcLdT9x5pr4OvQL/O03IOxv+aHLfsmubyEhB5+qq0ED2RJ9p4jQ5K10IBLzHlwxOpEQNEsHqIkj6RGbEzOAYPyzgMrdc07rVVtLaiFKt+AN2hU49slzQVF28CV9MBeYFAsm3pGOEhl0HuxYZwg8ln3bF83XHT+YScyIZRU/mF6BFWXrdzbSFMmsXvZdFrLvgo6xRez0opj14YmoeUaYfp/+smV1yRjQQ/ozB7O/iFMoCJwq72/FEEXyOuQadQg9BJuvhZWACwj3NFiisHtpw0x4Zp0x/pFPMjAQUtNA==
Received: from DU6P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::8) by
 DB9P195MB1418.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:330::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 03:58:36 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::27) by DU6P191CA0006.outlook.office365.com
 (2603:10a6:10:540::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:36 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 7/8] board: phytec: phycore_am62ax: Share ethernet resources
 with boot r5 core
Date: Tue, 25 Mar 2025 04:58:23 +0100
Message-ID: <20250325035824.2304200-8-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|DB9P195MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: 34598740-bea1-40b6-a260-08dd6b5151a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRUonB1+HY0Z+kDrO6WyP083JxOxA/ecmNZVebbCAvybDnRjteotoMUd/5A+?=
 =?us-ascii?Q?+eiqef5LdfyWR6322BU+xBJXtRulv1KSFCHFQMTn46iVokqm78AgnaA4cxrH?=
 =?us-ascii?Q?ZuAA5fgjucFc149EqPumbh+r7ryU7eUx4769ivYvpD7PAeX6+jmv9e0BlxFl?=
 =?us-ascii?Q?Spp0WxkNek5t3cvKRW9URmwqtbyDGaeJFTiUzrPE8RTI7EO0mAvFz7NvE3mD?=
 =?us-ascii?Q?/NhnrOChX5+lJYV7/YzJejlrYzdufou4IOIxWQ24FlemfeMKl+YJzOVT1ekr?=
 =?us-ascii?Q?OUypf+Sutp/dnVa4zfcr/7IJV6Xd5w2EC6aIm3i65t28gorvInjDAb4Q9BrD?=
 =?us-ascii?Q?SOb+/VmOp3wzyOf95fsXMxM9FsgGSWNwG76kRpk3ziX0J4KEgEKL1RjhJhtW?=
 =?us-ascii?Q?DdeNLau/R70yXGFdCsnS2OzqrTT7yktk3fwQFLjRqlr7XVqfLvc0nVldrxJ0?=
 =?us-ascii?Q?NWXOO6TKOqb1TgQxtZajzbKLObk7mdPLcxkefR9Vsv1gxgML/RWCwWI7uT3p?=
 =?us-ascii?Q?z1M8IM0hiJgCgGGPI2XkeBvyD9O7MmqJGctf0HxowWqTDhuiKGDMxx45/f3Z?=
 =?us-ascii?Q?ih9dwJ871OFm38yUNSFgQosulGfe+LFeOqCIgji6mW3m9rj2GVOH5/wSVx22?=
 =?us-ascii?Q?3IGCqq1VMW+tw52c7nMHj8ElOWVlP3ILG0iwqraN8H/QN4rP/p7bCKx5Et2W?=
 =?us-ascii?Q?dwLv07TNwiLoYRwz8fO/tLJy8KhNLIXNqDk9PYp21HUWZ2wU1XJbg5nQY5+W?=
 =?us-ascii?Q?Ar5OW7CbaYHbNEDENdcYoZyIjF1jymFGRONFUTqOWbklaLoIuHiBUYy/SYrn?=
 =?us-ascii?Q?yiJxJsBiaDZZxGw08oZHpah6uZAHxtRebAy/Yq5KH4PKvlsbIDPuXS/7VvY9?=
 =?us-ascii?Q?7lT9G92zVI6B54yIOd2UbUc5uwkk12rMRgAPhDs/XerFknLuDqYE51tgdYra?=
 =?us-ascii?Q?FMDod2FzvbC8npaLQscf6yvVaCWP0TSbbpuF5EIPG5UEft/8HD9Lu93zQIE+?=
 =?us-ascii?Q?+lEAuaZLc2Pd/ijuoHf3se3GyM5Fo8YpZUGAjMPgXNt12anZZZOEHWyt/xpA?=
 =?us-ascii?Q?BzKVg120KkcyKl6xk+/N+moLiWv/ybx6mRpFnpPV/CsKx/L0fFlskG/JI5xr?=
 =?us-ascii?Q?CJE8+SJOgMK+PE2qR6DiNomPBZuMui8JwxesS2oJ2nhR2tGrgrt5BTNAn54j?=
 =?us-ascii?Q?LspqQAw+oG2MGlbsiYCvO/nWxecpLJzNJj9WGqmPJOv/B7MGtTnQbHIVXXTC?=
 =?us-ascii?Q?KfbjTLS35joJg8xXQODpUw4JCbNndf+0vpXG84APscOu7RPcOR+7xt4n0jBT?=
 =?us-ascii?Q?nhpyW4soaSGswNoC1MIJ82w1bxgf4IpcowwYCJ7vB9+Lh21Os+16xc1iARly?=
 =?us-ascii?Q?ux19/0oYLQAHmaePJdtSIUQWB25aAuEQ36I0CgTIjBOmwR5hfqMUfLYA0MUO?=
 =?us-ascii?Q?2UddKg+MNRc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:36.1989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34598740-bea1-40b6-a260-08dd6b5151a2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1418
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

From: Nathan Morrisson <nmorrisson@phytec.com>

During the U-Boot SPL R5 boot stage the code is running on the MAIN R5
core, which means a host ID of 36 is used for DM/TIFS communication,
see [1]. In order to enable Ethernet boot update the DMA resources used
to be shared with the MAIN R5 core instead of the MCU R5 core.

[1] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62ax/hosts.html

Based on patch 19 from https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1307981/sk-am62a-lp-rgmii-boot-mode-problem

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/rm-cfg.yaml      | 10 ++--
 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml | 48 +++++++++++---------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/board/phytec/phycore_am62ax/rm-cfg.yaml b/board/phytec/phycore_am62ax/rm-cfg.yaml
index cbd087de797..0f34b8c1bc0 100644
--- a/board/phytec/phycore_am62ax/rm-cfg.yaml
+++ b/board/phytec/phycore_am62ax/rm-cfg.yaml
@@ -713,7 +713,7 @@ rm-cfg:
             start_resource: 19
             num_resource: 64
             type: 1937
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 83
@@ -767,7 +767,7 @@ rm-cfg:
             start_resource: 118
             num_resource: 16
             type: 1943
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 134
@@ -833,7 +833,7 @@ rm-cfg:
             start_resource: 19
             num_resource: 8
             type: 1956
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 27
@@ -917,7 +917,7 @@ rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 19
@@ -929,7 +929,7 @@ rm-cfg:
             start_resource: 19
             num_resource: 16
             type: 1964
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 20
diff --git a/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml b/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
index 151cd599b1b..23dcd784615 100644
--- a/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
+++ b/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
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
@@ -429,10 +429,16 @@ tifs-rm-cfg:
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
             num_resource: 36
@@ -587,7 +593,7 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 64
             type: 1937
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 83
@@ -641,7 +647,7 @@ tifs-rm-cfg:
             start_resource: 118
             num_resource: 16
             type: 1943
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 134
@@ -707,7 +713,7 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 8
             type: 1956
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 27
@@ -791,7 +797,7 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 1
             type: 1963
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 19
@@ -803,7 +809,7 @@ tifs-rm-cfg:
             start_resource: 19
             num_resource: 16
             type: 1964
-            host_id: 30
+            host_id: 36
             reserved: 0
         -
             start_resource: 20
-- 
2.34.1

