Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C63E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F60183E8E;
	Thu, 19 Feb 2026 14:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OYgv27Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E9383A47; Thu, 19 Feb 2026 12:59:23 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E1E83AA9
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI1jt8axgWpFkVUT5rUwGh1CNfjJ//pIk5dInSVVmYSHrHJOJQHpYbGieQNkQAzFQUkdxgkMusDQENvaR+l3su1Jbp32bgGBdlv2BjfW9XTLSbxR9XOnDgPxWNMlVtRZECq62jyq2/0sbJv+3JpRuRyKJRev6BSDT0dhvZ4+hKpIC2AlyTlxyTuz7jhkDm1S0k643suCkKdLwb2OWV9+wNafwvMMWa6DglT58acaGG3JGv939HyC3C+Y2h2ky5cC8GVlRsmih9O9qT0gFUiRPpE0qOlSgci8nRBqKKxOuVIA336n3G4XdrJULAcWvfnv8xhScAIqMd4Zr9a+yxxCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/wkUKj9lj81XOqyOQm4UncEJiPpaH0RyVAYslr4k1M=;
 b=FB711wbbhFoyTwe8pkNbJkhfjkpUaD0h1hmel+dzn1Gl+evuhRpiL08jkMp/CoaJ+IL9KD0MqaoYykpfUrWXmaIF9eZEtUFyGCH7Uz/Sj7og6PtVFKOuPKwztYOiMVYPwnp0bClsKXUP3E0WWfeT8pAJ8eNYOwYCVZh0QYtfQHvUZSfarrAfjt6u3SyQVkF3f6b+WucMNFb9BFm+geYuHr01R2AYK173P8yiImRF2XtmKoyvfj14l1jMUB7iaiZOemUlsA6DPi5MFdqc93KtblmYSMdInG/DwUbxTlGaiJMs7Ky4zeyEgebHOis2R9UZVTkzS47GENQu8kNmM3KpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/wkUKj9lj81XOqyOQm4UncEJiPpaH0RyVAYslr4k1M=;
 b=OYgv27Pb8C6mnQnzhGt2ZmMlYXqzpx8Q24SMX2akyN73vws6H4VNFDWPSm+3N7rRLtIPSIAMy03RLDVStVf1avIy+M4pk0kex423eVY2dJ+OIVm7cHwEAjdZrP0lEBoaxyb7zpVeyO25qn9Y2clF/JdNiHJWrmJkMGJPuHmPCbs=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by MW4PR10MB6629.namprd10.prod.outlook.com (2603:10b6:303:22e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 11:59:15 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::71) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 11:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 11:59:13 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:12 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 05:59:12 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JBx59u2535407;
 Thu, 19 Feb 2026 05:59:09 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH 1/4] board: ti: rm-cfg: Update rm-cfg to reflect new resource
 reservation
Date: Thu, 19 Feb 2026 17:28:34 +0530
Message-ID: <20260219115837.965532-2-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219115837.965532-1-sparsh-kumar@ti.com>
References: <20260219115837.965532-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MW4PR10MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 848aefa2-ffe5-4f3e-c399-08de6fae4cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TAe+wIg1DjagvcgH2VGqm1cqEachpIjpOA7p2jZOLS6tjjKu4vU8QCAEwK6Z?=
 =?us-ascii?Q?pgOkecMOWpwip75OVH2e4D/1bXQjPz4tafnwS8k0tcpG6YVQzm2v74qXSujV?=
 =?us-ascii?Q?aCAlSWd5HgdJgZ2nNqdMilrGLUW4pqq54OztXlfenAag96a+YtxSxajgazEN?=
 =?us-ascii?Q?x1et/oDwrpHUjnmOyq1m/Bd+kepBTLm3d221N2H/qS1ZRd/2FmFLzMaUE4Ec?=
 =?us-ascii?Q?AeHeS2YPza7DICF4v2T8X3JFOyy3fmi5T/r3+UkQv8zXpvqt7ariDh+jIVOC?=
 =?us-ascii?Q?Ej1FQeY6IcMnFpA9c8Re9H1CMX/npPSyhqbGKTHSDMFL5QW3XbGeF/9YBBM3?=
 =?us-ascii?Q?2zOls7luPl2gIBydDEhzJrxxUHqkMpCG/eWGmqs+p9TNyUDh9rPHZ/Y9Gxho?=
 =?us-ascii?Q?8u/a0aCxmiOSW/IqrRBUEOt1Xub4YpGWA2Tj7q/51Eg0b0NPAtpKsC+9/zei?=
 =?us-ascii?Q?0k0UgubJLWIIIXNsZAhMvTvQF5QAF98CMJYzmACnwXItdwM+9Ooj0znP+WzR?=
 =?us-ascii?Q?zLSMNPubUdbpOafsHe0q1fcZnmV1HHdm0bUtJgLD/65b6QTZWFS1X31TWuSR?=
 =?us-ascii?Q?+TQot5laAlQBwpdVfP5oycy6x5Sf8PEMv+r0V2+JjGFvrQXbGPjXawbzdFs+?=
 =?us-ascii?Q?Fj0ZUGOEz423nbRvJ6q2oKRMQmd7PBhCvCZeIWk4ThE4GhtFPRq+pSB3n7iJ?=
 =?us-ascii?Q?dpXl5edLcHOAa3QbiBhKC6Px+ZbDnWOAGCi1TPuckQUG2VDX7pgbGD0rv7eV?=
 =?us-ascii?Q?yqH1+LwMUksPMyAWi3vPImmgi76mhDdKYNxt0IS7X12rvozoVGKLbfzStHgr?=
 =?us-ascii?Q?5bT4xkr5ov0vATfg0jRyG08UNhTuEbdlmZwmyBCAN+Pf8oOkTd42eGaeHuuZ?=
 =?us-ascii?Q?xBPcYWbG57DEmrExTszkIi1zscwAUWW/l3DL8zG+5xdz0vHVQtMz2t5RcuXu?=
 =?us-ascii?Q?zc1j208fm39znXQGrA+PhMnKjmZ7LqlfOX3f8ICOBMqubjGjxhLbWoqYNNz8?=
 =?us-ascii?Q?M2lsmRDD77sJeUcfl3gSnTngxJ6DVeXovzWR1wnZadpvwDYpNOw+L3E/5tP2?=
 =?us-ascii?Q?m7Dv42G+gQiuatrB987bXOawekvK7G97eaVutLtkcmeLtctCfJM8jNzNN1eu?=
 =?us-ascii?Q?xU+iQt9hHZ542K1wBiWIrcF/21HhBYur5KuLaC8PiXPF/Ah/pjUCxJgcJQSi?=
 =?us-ascii?Q?fM2v2CO5MByGDZwyXAPlP6FyF9DfjUHiHNNCmbqEP7kxIPWQhRcvHq1Zu32n?=
 =?us-ascii?Q?xTRn4nSI75HSuwybaMq0JGHcETFmHLPsC7Cufyk2GBtFNeNJxAX63FjlEi6m?=
 =?us-ascii?Q?fgxhxAdxFWyg8y41AQH655kBPqaEW54MTmHXQ2/oqjii2EmQR8e/8RNo1lFL?=
 =?us-ascii?Q?9RuZdCrIRCefolpF4Qf3NjvFnD/mjPLsHpLOIMl4Hy1yelcTS17zAK7edEB7?=
 =?us-ascii?Q?osUudkl8SN9x7zNMeAsu9MgDHBWof6dxRd16smJKD+tEjtW7ieQbBFuERyin?=
 =?us-ascii?Q?IqjdRFVN7d8X6ITIvsu4d1f/trqxXT9VgAoxpYuWZc0S6bTty3iZeJCy+iGD?=
 =?us-ascii?Q?l83lJnfsqjbqZqoCben5xd4M5kQ05qv8WNg4tmwhm9FHv5NG4pvsrH4GpTk5?=
 =?us-ascii?Q?xQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CdSh3CRX6j2qlohx+LOM8a3BjDbMMpmH7ti8POwsYot40DUEaUrj/agtq8LhDDmY0+SaUXx0N7YhArAKiX4Lu58aV8HbHnBeri8sGPY+iSMyjnGa8nglGTkXZ+acIP5N1R8R62Bu9iZ7cNcJHnlD+Mfr5NZcuPOP5sUa6QYLqWcKN+2zSdX3wVaqoztj25ewBT3Lij1S3v88RkQyQGy/bTHxp3P0g3n6YXgzDyRobu8u8UN8YK4PV0dbh2dpI3bzQRGlhOVsquau5ru9clPNV6CBzeyokoxowJsgVOh96BWpF6oQ6+f8rD+ebAOArSYRPXKPJD16Q+OZyQrs8+o5uYUivWygT67aovX95icRf3oWPL23IxoN2BZroqGBFs70Hw1t1EaknUiSW6jrRityvWCdeQSXEIJvPsuRJbxoD2cU9c0xAGMDQkHdKG2akTEF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:59:13.6385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848aefa2-ffe5-4f3e-c399-08de6fae4cd6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6629
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62x, am62ax and am62px devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 8 ++++----
 board/ti/am62px/rm-cfg.yaml | 4 ++--
 board/ti/am62x/rm-cfg.yaml  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index cbd087de797..4e238883b96 100644
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
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 1038
-            num_resource: 497
+            num_resource: 496
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/am62px/rm-cfg.yaml b/board/ti/am62px/rm-cfg.yaml
index 73da85eeade..0db82fdaf79 100644
--- a/board/ti/am62px/rm-cfg.yaml
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62P
 #
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index 26d99b03b80..a7035dc0bd9 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for AM62X
 #
@@ -525,7 +525,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 168
-            num_resource: 8
+            num_resource: 7
             type: 1802
             host_id: 30
             reserved: 0
@@ -555,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

