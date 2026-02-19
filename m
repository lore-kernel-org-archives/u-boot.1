Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E71E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3620383E4C;
	Thu, 19 Feb 2026 14:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pIy3QS8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D3F83A47; Thu, 19 Feb 2026 12:59:19 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCA7802C1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTMbfDDoyYt07x8niXvq/cfCISTwPPsXmAnrFjyZpnVhP9PKVs4UTKgHEFw7jvdnsQc5rAM9R9VS6fMy557u+E6hFcGCaAJzTXX5/hY5xjuDQOanBC/6AMME5Zkfzzh2Ol3E5SDWUCLnlb0qAnqTaBfA6kfckpdJ0pItRUifmI6GLIbEMuJSyY2g4q/Uhk/Y6dFZTtcChJPZba7TRhOmCf7uxuKSuJptuOg+i7ySOc+lDEtlKcmzAacMAKLNTRFrNbB0L/2hj3YWt6I8nuSLyYa372yFlMjwYZdA70+fKKebm7w1E2C0PTdhdpUbw1QRC+47kPfWJesJ6TZDCS4cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x2RlJvGxHporO8ILEH+WnMDodPRugpc9gO9PYbwSqU=;
 b=rwcAAka0TxH4JDkj8IkD8iXfG33QU8zx1SlSR2YoAgnf3jU1mOOXdjB1WygncjFbmslk1aj8jqfovAW/AyPjnVk+kboPPZooAEk6cMdclEYazlC8T4ueAtiCEMaOwIZNHmtuldgz0tNAzfNYlqvFNB20c5U6bpVdMZyIwwSA3VCC72vECn3/lShY8z9TzIwyi8NUbBMG/PI2E737cUuEAhbV065vZQsLqxuWfWACeqzH7knqLZ0476S+or9MhSkkrFRyZZQ9bU7vulnXu1EnA6X0zGZUl1D2ab0Zcd4NTHuxh/qaJ4mZv9HJFIuvhJRXU0dbEdQAaafcn89QUQ9IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x2RlJvGxHporO8ILEH+WnMDodPRugpc9gO9PYbwSqU=;
 b=pIy3QS8Psd8OHsA7oDMwms4qk+GKBYw/cbTVZgTTbmpuLCntBWz92ybcXYO2+TkE4PmVVahjfR6TsKQ6E8twfpzIbDXhVdPTI+VtXcc2DFmFb/wk516ocxcIO+XkXcT0FykqHaoRnp+jsRgvmZDimqgmERfErQUIJtaaZj0M2OI=
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Thu, 19 Feb 2026 11:59:10 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::38) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 11:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 11:59:09 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:09 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 05:59:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 05:59:09 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JBx59t2535407;
 Thu, 19 Feb 2026 05:59:06 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH 0/4] board: ti: am62 family: Sync rm-cfg and tifs-rm-cfg with
 TIFS firmware
Date: Thu, 19 Feb 2026 17:28:33 +0530
Message-ID: <20260219115837.965532-1-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd33173-5d90-45a0-30c5-08de6fae4a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?faXLDXsGXPH3wdFVua1SvgB61Yg/vBn/5zRLt0pgdiG0tQMXxdGualdrGGEW?=
 =?us-ascii?Q?CT58q4f6HxCLvFGpki/xWhXMpTGV6WSiiCDHYswzjAo0z9rylET3I7MKRab0?=
 =?us-ascii?Q?C/W4rFNy2UPoA8zEAKVc3iM8npyc6PaVa+aayR9le3sdY4SRgOEskpOrv1HP?=
 =?us-ascii?Q?MjWLg0ojbNI4Y3WdY2Rfhr+npRoFgOjpwbJKzvupiBlcV3yAvG/vZfwKsk+3?=
 =?us-ascii?Q?AdUgV5T0hr24OF+X/GutxhDd7dRrPTuC4+dSAKb4gc1sBjRtE70pxzIZEk27?=
 =?us-ascii?Q?JUrudT1LuJr1PaNC/MBYS4mZP/AK+d63e0e8kFUKPn9ME8zbN8DC9Q3M5Fzm?=
 =?us-ascii?Q?YWp8WT5+2WlMq3Zwsf3YQcUOFwNOl8pF2Vtdbsx1FHbkRLWSEgHRTM6IEBAG?=
 =?us-ascii?Q?xCwNNHsf1eoz+xb1XlxfYL0kkkQv+zEg7GmMT+k40ReXBcmZ5soZicHXhZkN?=
 =?us-ascii?Q?iSiR/9jzf1YHgmk9kFY3SNgYfJsZAZ1/Osnv0AZlr9cm1FXr/8d4DGlor5yS?=
 =?us-ascii?Q?fFsbMDJESwERlMooD2KUEKcY6ZGDVnLPByTHOtr41DUi9ckPSb0d9/ff4tN4?=
 =?us-ascii?Q?jLt651/XgL2/5U31B83pEKblo4C4KgmOWNlxqODTqHyLUT8yRx7u7bssigd9?=
 =?us-ascii?Q?z/EWW5xQEvtDfYFrwL6JU985eqbcHgvYhS/bdiukorw9qJjXRCcvz/d8D8d1?=
 =?us-ascii?Q?6ub64TN6GAnaZwDKHOD4i9nTVlpgvECedP3gSRMQYgV9VxQLfDjF0BdW9f5o?=
 =?us-ascii?Q?I8GaiW8UsSQsj8vcf21oiumYJsuXRf7ojHQWxIgeC9lq6N/eYFJ3m9qc7WbT?=
 =?us-ascii?Q?/LVn76A2jc6QXbfaq5zztx/Hxg3Uy3dxIdCAQZmJQF44boXxb6rD8f39Uqzt?=
 =?us-ascii?Q?ZnPFgl+YbWs6E66qw1w4MXxEmLz4LzoDGRGzGBeTb8YNG2isBrh4dyZFYhGk?=
 =?us-ascii?Q?mieMe/fOZlNmjvwNampNp3F2sI6FMyfR8jitOhzZiCrOYnkqqi5G5bzqVjIb?=
 =?us-ascii?Q?bzZLdW2VTC6veLM3sE4SKxMCmATFCB3JOpQ81OjaRV8+IHXtlwYY4VysE14T?=
 =?us-ascii?Q?AtjxaRXc0hNPbj7z7lmT2qmATCZZD51yq+J4djrivQeT4hV7MuzEtGCPZljb?=
 =?us-ascii?Q?KYBIDrswuj26d1mBLUEJeuMz8gPbe+a08euBtYhCwhlNWz3Vw/ruT/1a0NXD?=
 =?us-ascii?Q?Xl9MO7CGOqCOfNkGEd1RwxWEW/fyattOsY84ocyWBgxWFY1nqtbvM2KOPYsK?=
 =?us-ascii?Q?OnFuZIDggE9M37qjKzHOGXUvybBY/jBgEmYUTl/EDIR9M370n+1fpazqo06y?=
 =?us-ascii?Q?gksT4RLIehrsfFey5qw4i//cfC4Tt8AL2HyrUnR2dguIoPLfNaTtWwEWmLRz?=
 =?us-ascii?Q?rRcZRn7FmlDz7iBqfCpuAatPMi8D6X+2wVRnZ8PjmU/zcfSESOpAgLU/J0uD?=
 =?us-ascii?Q?zYkikW4qdlbyIVkfAKmmwsuWOZQzJdgeVRDSB7mhAt0XZ7d8ieu7Pykahgau?=
 =?us-ascii?Q?sM+t0llFWiAw7o7+I7Sr0L79vxUDucnmK/1kKthmXnRxVlUqllJpijtLjPFF?=
 =?us-ascii?Q?dmxi0N5jpoKAlr1DvwaZUieUgBRdgH980j9jtFLvYWwtqYsATKCdTlI78fma?=
 =?us-ascii?Q?bNkam4KfeKY/9YUzm6tHzO4tcrO9E5AaQankunxN5yRWgjVVLwmL7r2LJJL9?=
 =?us-ascii?Q?TiLUCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m0K2nkeZo9f8bp1zhJlZcJi4dOc8dyg6UnzbPXFwZhvzR5I0V/QM8TAnOjBSbmzLskaJdwqMAnd7ocHBzx9HaMIPUO2iwEQxFBryNHIXCQKDELhMx8G8pWH8isV0inJUj1FZ7X01t0PX8OyLZ3JCjaz+VE5LKWt+CB5yeciCWpOv+pPta6ki/RVQWmnYthUtcNPYa0LaWlqVsWj8u0SKR2MRQPXNqWxJpUK5wRivqzqwAUUEyFY2R7FxaBpBriEOX5+dZFr/hnShyridaRpKgIGfUBTNcyVgo05kN4yLWl8glAcBaEgZarJ138yJ7sEY8ptHTwyzeQFQbp5pVngcX6VPcBMw//O7Ve/HHai1PSl595WyRoJJXSVh/kvBBPG3570FHwRsqZvbAoYQiUZ0i7ZWgZV4zv9aTSUOwEZwoGMfbobtp/3lu8Zslugu03We
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 11:59:09.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd33173-5d90-45a0-30c5-08de6fae4a8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
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

This patch series updates the Resource Management (RM) configuration
files for the AM62 family of devices (am62x, am62ax, am62px) to align
with the latest TIFS firmware changes.

Background:
-----------
With the latest TIFS firmware, an additional virtual interrupt and event
is reserved for MCU cores to DM usage. This series brings the rm-cfg and
tifs-rm-cfg files in sync with these firmware changes.

Additionally, the am62x platform was originally introduced without a
tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family. This
series addresses that gap.

Dependencies:
-------------
This series depends on the following patch for am62ax tifs-rm-cfg updates:
  https://lore.kernel.org/u-boot/20260130143339.1401600-1-p-bhagat@ti.com/

That patch adds C7x core resource allocations to am62ax tifs-rm-cfg:
- Shared split BCDMA tx/rx channels between DM R5 and C7x
- Shared rings for split BCDMA tx/rx channels
- Global events and virtual interrupts for C7x

---

Sparsh Kumar (4):
  board: ti: rm-cfg: Update rm-cfg to reflect new resource reservation
  board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with TIFS firmware
    updates
  board: ti: am62x: tifs-rm-cfg: Add the missing tifs-rm-cfg:
  arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman

 arch/arm/dts/k3-am625-sk-binman.dtsi |    4 +
 arch/arm/dts/k3-am62p-sk-binman.dtsi |    4 +
 board/ti/am62ax/rm-cfg.yaml          |    8 +-
 board/ti/am62px/rm-cfg.yaml          |    4 +-
 board/ti/am62px/tifs-rm-cfg.yaml     | 1476 +++++++++++++-------------
 board/ti/am62x/rm-cfg.yaml           |    6 +-
 board/ti/am62x/tifs-rm-cfg.yaml      |  867 +++++++++++++++
 7 files changed, 1646 insertions(+), 723 deletions(-)
 create mode 100644 board/ti/am62x/tifs-rm-cfg.yaml

-- 
2.34.1

