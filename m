Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9BEE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E180483F00;
	Thu, 19 Feb 2026 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rvnkthnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DF083A47; Thu, 19 Feb 2026 12:59:27 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9773802C1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqeKJ90p4vZql/LfRZVIEbzYzRavMRLVwX3davJACboir6gY1M/60j6dhtTDODH9xy8W2CeDMFhDtRH6dF5QWyEfGDufSIf7euiJBqMnpr1oll1g3yNi4ObyzDucb6V+RYkWlzFiSx0ntTcVt8mYcW0i85jW3yrLk6U5ajN7HlFldkoHi6DAIh0g2WMjfq6Xuk1a5u5l2hkVDaXKhtkdsHo4Db0AoFyID6Jy2oVGT8TfFWCWfDjKSCUZaGegW0dfng97GG5wIIfSDTghb3VJgrZ6j0fPqa+J+D1e1YSgaKyvwl+q4rtTokqUBHKgEIEyup//Pr6vHy+8EadtpWWecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeTW1eKl0IUxbOWrn4pk4QFhYOLr7rN5HaQ5NcccxNw=;
 b=vHiG5LJHJorftbnauz0xtEKmsS7GTHM5JGesngtQT7XVWHsXk2WhVLq/kRcdPEai5Q9zIA3jVHxJUa+9exwZWAhyMhFNmRTSvOi8XoyF52aG9y3NUyDbqHOkyj9e9HzmFNcEdpY3SxRNKkWVRLlGN42MEpSwIQYBuqqaYr214KC2a2y+VVPbV6DSOEgvcc/9Yuc3h005spqDtZ2D4f7/45yuprh8BH4Wz6TYVI3j1CQ1h2yczKseHYL0EhmdYEdMBOA+8v/ujAK5SCzIueOL+fB4zjR15nandv9VB7vxlRN3C0rrByxLGUGBsaloghExpxGZMBk3+UYyZ2ZF+xJmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeTW1eKl0IUxbOWrn4pk4QFhYOLr7rN5HaQ5NcccxNw=;
 b=rvnkthnnneYZObFXzvMPFRhYAafq+X4NOj/FQ+0mqw4qzRkR5oGwJXWj3JxUSlls3+Xehdrm9dUZ7ZTnNz9PjXiQrQAOJ4x1j7lwfPEjGo18cM0r0+6xDzKcu/FZs8j9z5xhNEbLNjqkfBJKfrGiBKDKb/0YlbOu4GGKHwmTp8Y=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by PH5PR10MB997757.namprd10.prod.outlook.com (2603:10b6:510:39e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 11:59:21 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a2) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 11:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 11:59:19 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:19 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 05:59:19 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JBx59w2535407;
 Thu, 19 Feb 2026 05:59:16 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH 3/4] board: ti: am62x: tifs-rm-cfg: Add the missing
 tifs-rm-cfg:
Date: Thu, 19 Feb 2026 17:28:36 +0530
Message-ID: <20260219115837.965532-4-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219115837.965532-1-sparsh-kumar@ti.com>
References: <20260219115837.965532-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH5PR10MB997757:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e3a499-eae8-4f86-4db9-08de6fae5073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fkhgL5TGqjDXDSlMT/WIP/M41FO7X87B5Yu+Q27GL8a3PgCs944yUkX89uTA?=
 =?us-ascii?Q?nYdzn4G8EFxURJLglCYARFI9Cbcy8H1J5Hq2sA9jSagn5phspBtI8CVtutGP?=
 =?us-ascii?Q?vE8uyyVbwzvR/cPhnO6x/yMVF5XWV3vO9iNYip2Eg0feI0ZbVDzRz0/jUonZ?=
 =?us-ascii?Q?JuC5e9zu1GnzUABdvfBSlf+gZV531OkVFasjIKPOE48IrRy+yG6cmym+wj6d?=
 =?us-ascii?Q?t0U4CV3oPL6jdh6AyiNCxvSFVCcs9k9GmH2OcX6SCokjszaitZAyrPshYKcL?=
 =?us-ascii?Q?dIhFKTX6nCJzNEAn8lVclXBknhLSVL4h2htN+36fRifbbxhCysSc3B5DJsgn?=
 =?us-ascii?Q?1y/RY2WG0NRO6xF5qR42wKTJA2lGemezWyABDEbi5+huPlhUV5LA9Y38dTmd?=
 =?us-ascii?Q?Q7ck8kw5f3Z+8uUKcaucuo+12DwM8LNTJuKBdeRTL2ETyhv3f0KWtdR9zTbg?=
 =?us-ascii?Q?cULSznTcKGDv0kM9FDJ2aegzU8ojQQCR6S7wd8tDxtwxs5jbPFVSfQ24+tm7?=
 =?us-ascii?Q?NeryrX+LQH0yvmn+lL8mNcyq7SpJZEeY5kS/ewNUdBd7/XvDCXQj/yO3becP?=
 =?us-ascii?Q?bM6q6xTAjxPXP773DuNtfcENYYjrpa/berMLvdaIrYYtFvMt30m0OXGGNgab?=
 =?us-ascii?Q?I7fpVPf6Oi1NR8Bfoia/bQPSzCeaA/xAsUlxBbS0nyRBPhM/lNAoq2UBS3fp?=
 =?us-ascii?Q?PbPBAamnz6c8qgtvAc670ff46sbNAe5iBikIDM+oKNpumv+vtU32zKFwgnNb?=
 =?us-ascii?Q?E8Ad4cMIVCGufp7UGVd8HokcgtWQWm7w7DnlVdMGcsUt6QoVWh19yFH1ZEjH?=
 =?us-ascii?Q?9tL0dpfmjTkGwspTkaHI6iqkKCwm4vxRyXSo30wSt3n1f7TzJ6ATuIruKAEA?=
 =?us-ascii?Q?ssYDR+EWIDqCIu9Dgo2003Is0EDUfrANxnLZ5Qe/8qHHhLw5szgXeus7Joku?=
 =?us-ascii?Q?MucJZcHO0scGZ+zbnm1EMyd/rg8WkdCIc9nW0Tqm1T41wNnfgMswYqgbfhPo?=
 =?us-ascii?Q?398i+odBqLxGcb7hDiXOPuQE1VKdfUONODTHEP1OKgbh3ByLUltEHzYjRFi7?=
 =?us-ascii?Q?7DD7P6JPM3tn3Sx291X7zjd4fA2Gc9jM53M4bL2W9/E8iGyplNmE11pmEBaC?=
 =?us-ascii?Q?3T1OaqrRaUw7tCCpgu3cSXxLwuwCcq1i/0O30u7C17C7cRzan+/n6HcFQMnL?=
 =?us-ascii?Q?K3hYZGO9BtqP/25G5XC1dp2U9o6z/gKmaW+KewI1wZX+4g2KVTyJ6pTApPAR?=
 =?us-ascii?Q?mOLKtRbREjG0ZmCjZ92CgrU/dr4cTLZD1YmNP3kQeJAdnRyTuZT0daFJ7rA0?=
 =?us-ascii?Q?RzqWWy5R0wV7qkBntkqTAx73qzqMt92OBVRxK20jSP0QsocV5zjJVX65IZf/?=
 =?us-ascii?Q?eeORnq6eev1MmiGi5IVkNJV6Tpk3cqRpm7YKXTu2QNPHL29LnYmmkVRDZhlq?=
 =?us-ascii?Q?7Zmgp2QcgBkjZUXyjulKDDaRfmV72TC24Rf2FtcRML5/lB21LnlYDXF1oy2z?=
 =?us-ascii?Q?zwdqqSpQt3Qnytf9PLiKPRG/wfXPbi1kWOceznKrjHHa1b7dWk2VhwDhkzPz?=
 =?us-ascii?Q?FeDs4JG5gI9ENKtLZYsNElhIvCwZb4TxatFBUaPlOw0q3BxFAj3oVtDvqCq7?=
 =?us-ascii?Q?gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i01p5MBi81qEZNTgT0EBSexCxXQdQr2GOYjfBxB5TX+DcLtpTNxpq7LMJoOT/tUBQnFrlkdxtyMwXLs6prJD+BFGXuM4C/IWpIoBe/9/gKq0bth5lKOmDPjg8rrNJBZtyBcol4X03YRLozYQY1IJIxdUwRbYFSWSlqC12GbVGX/hpeT4IvxsJrWw2p+Ux6b4yxIWNRIHp0tTr86tcYC1nft0sn0AIfYtW7yJITXzRVMm6cc3X73NC0RT6EK4XCqU8zUcZfSGCjyNGbAqTUzKjkAZ26XDuJygGp9hVGpMkxFgE6gxt4OMCF5wiamIc0NYjCF1S1eR6/baP8C3hfIT8zNeJHQdUKjmaqbvj3f0KHJhQ5myamsubJ6T2QIMnUWMeLYBSKGcntQg3GyBXb7wE6dqbcOUrnmr2Mc6yHacbYmk1QfEfVRvdId4TDlojkZw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:59:19.6989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e3a499-eae8-4f86-4db9-08de6fae5073
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997757
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

The am62x platform was originally introduced without a
tifs-rm-cfg.yaml file. Add the tifs-rm-cfg to bring am62x
in line with other am62 family of devices (am62px and am62a)
which all include this file.

This complements the rm-cfg update in commit 22cc77516ac7 ("board:
ti: rm-cfg: Update rm-cfg to reflect new resource reservation").

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/ti/am62x/tifs-rm-cfg.yaml | 867 ++++++++++++++++++++++++++++++++
 1 file changed, 867 insertions(+)
 create mode 100644 board/ti/am62x/tifs-rm-cfg.yaml

diff --git a/board/ti/am62x/tifs-rm-cfg.yaml b/board/ti/am62x/tifs-rm-cfg.yaml
new file mode 100644
index 00000000000..8510fe9526e
--- /dev/null
+++ b/board/ti/am62x/tifs-rm-cfg.yaml
@@ -0,0 +1,867 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62X
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 824
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
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
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
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
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
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
+            num_resource: 2
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
+            num_resource: 7
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
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
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 36
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
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 36
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
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 36
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
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 36
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
-- 
2.34.1

