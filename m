Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D95CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282B48329B;
	Fri, 19 Sep 2025 08:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pBzJPH4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D021D83314; Fri, 19 Sep 2025 08:40:04 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9F48329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXmmaJwmyVQLwg8RIcKAzZJxbFrCoiAUi45wfKpliaYUv6Dgi7QnWnKLnK5QNipCjqb9jOETwIr5eYeEXm5XbvIClVCQUpnVOTTFRgt+AxO8gj8p5ZtBt6ENlwG3tXk8JTkOuFow4EEFlqwmldZEMn+6pla1SyWcvrJIQ3gsxLpE0ndlC0qybo/QhoZ3mlZsf1RrqjuFI7KKozUO0sL5ons89IYFWrJcwNx4LDrPnswpNSBIunZ1/iFfxpgr9DRdhcntEFHh2iWucoh3U1eUaUNMwnxw0TlP6OhVgaXCYyTOmq4QeGu6huxQNITS/u/MNCld6rxdzRE2EeLTNVnFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTuOqMQFFxe8hKjK2TBu7/cZoQ3nF6Es1ql065NtQBc=;
 b=Nu0a12j9Uq7P5SxVN/aqyGxe/xMckcKVMGESM3fH/QZ0AjcHj7zYafJfGlkb2Pt0UXhDX4WkPN+TriiF7zwrPmyOpR0FZNP2ldTfO9whUn7g9yMHYypGR0eAJdzM2dWnt54cKtohOOia0HA/Mgr2s4/jyg/3+qAUfW15/rQw719ZYGpi6Ia3s//jIb6ogaMesAmgo0PHbWEY9pAPaTNDh9WokuROaB/AQlq3xWvVAa+Tg87Ipr3SAQcZYTc8DXDAigpg0x4rdQKQN2SQ3ENR8vVNpR8/abeb3b731dex3jroy0W2TbUbVBec3p2VdL4bZoCmPf+v/5OXUjhYeWUkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTuOqMQFFxe8hKjK2TBu7/cZoQ3nF6Es1ql065NtQBc=;
 b=pBzJPH4zRJvxgzbJ/UuWuodz5vroFqd723PCkfbpKjVoX3L7j0gH/oAv7S4WOv1csmG1pTOOFyovDDR19xx4rjg9ILDVDbpl8MeE7W5QrZEsqXEw5H4AMjQYrGZ9kqpBRDTvn10D7X/50+OaEtk86kQDbb0E7/cHE8bN6uzNT/ct6sHm5hiNko8+Ttufzd7AEAJVC2BP+8tgYH+yIjt1+SXp1sXJM/As+myw4+XronTWToZctEKvEqZWM7CGT6doUv0ehoyM8UTbq4b1dzpZhwJ6/ze5MhZx08WqzoCItbGMDSeaYEHoERqt8W2b6Rjwh8pOOwZeklsIl2nvwWiIRg==
Received: from AM6PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:20b:92::28)
 by DB4P195MB1894.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:39:58 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:92:cafe::45) by AM6PR04CA0015.outlook.office365.com
 (2603:10a6:20b:92::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 06:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.0 via Frontend Transport; Fri, 19 Sep 2025 06:39:57 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Fri, 19 Sep
 2025 08:39:57 +0200
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 19 Sep
 2025 08:39:56 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] board: phytec: phycore_am6xx: Update scriptaddr
Date: Fri, 19 Sep 2025 08:39:47 +0200
Message-ID: <20250919063948.3093358-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250919063948.3093358-1-w.egorov@phytec.de>
References: <20250919063948.3093358-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|DB4P195MB1894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d811b50-a6f9-4468-cc9d-08ddf74759e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KF7PyEbU+1WNtskEv4MB2nS/VnyUrGjsd5yN8uZcAHwQZjJKc6ssO7VYeZH0?=
 =?us-ascii?Q?5kGmEFOkTiV+hol2gUN9VU5+ng2Zn4IkLnaEowCo9EQEJ9Hiw1jbfB8mF5SN?=
 =?us-ascii?Q?giYTHVoF8wmm05wXrWcOTOKH0AshvDTQ4YN1HLYf2DKMxen8j1UxxYlJSZDi?=
 =?us-ascii?Q?N4K8HXr3FzRkGp3HBs2BbhRVLFcT+qEQ416b/h37Z3H457Mzzak7wx9+xoiV?=
 =?us-ascii?Q?Ep+SQ7XesJgKiVQ+IVbrTNBtKRNpsTe/dGjS1b/CZR1DgprGIs18t4gJlS3Y?=
 =?us-ascii?Q?+d7Dj8ecEMt0cY7DBYjI4+qYaLfinHR006xLklkvNcHHHu/RYFvzOZHSbR+G?=
 =?us-ascii?Q?c3hkzHNc/LxKUGR0Q+FsTttdbDI4dN3HziLVgTC8nlVTynP/uYe4Mg1l/bOK?=
 =?us-ascii?Q?K0MrXrsKmMeHlJ6D7V30Ev3KJ02phbLKwkY3QmDxLbuDQR9QKKO2OUcjlRtq?=
 =?us-ascii?Q?SL/kburzO2T8FaTUgD4fgl1FqSY0bMTifH3nDjaDZxf3DocY8cYnqeYBTbpw?=
 =?us-ascii?Q?drVMI/+16iP1doWmqZRJoQgMUouJ7cNz4qn+b7ir9rHgkYgoC7grJ3WqQ8W5?=
 =?us-ascii?Q?kQPWTQAOXUBB1q10+QoKWk3yc+2jRSRykZ8C/zpBNBdAfuH8Mexh/fRi5lsF?=
 =?us-ascii?Q?0+PNSMTGsnzQY8BShXWv+3LuQuNCOc1XiCUEYvxlcyTef5MoRFH4KJLtyrFW?=
 =?us-ascii?Q?Ev6gbfuXBtnhYL1H1oAs6MmtC96sxrZcg314JVaDPa7QsNe7UvnGojukeUze?=
 =?us-ascii?Q?AJmYoZuXN9TrVFa1Y5UNQOpiUuRstV0JF2SP2TS+fVpiRLYUIKKj0in2vkDP?=
 =?us-ascii?Q?04gcWZ3nBA+pnv74Ha+4fBNDteBKTjoQNhSIgZo/W7A8ANUvqT3Ja83avESu?=
 =?us-ascii?Q?tscceI0ZqbS7JMirrEQyiI5RCyVBTh3EeWWGAkksKJKQng3YLYIwYc5VLOAu?=
 =?us-ascii?Q?zUf0xPee+3pSKYUqUz6ufbMEdOOB3yQb/cRc7XrkzP7x45GyhSKOkBNTP2j+?=
 =?us-ascii?Q?cjBUG6ECTJshISzdR4HX8OhG65G1kCrgSipAR/Iq2V3ypO03qA7IYLH6Ts2d?=
 =?us-ascii?Q?yV/Iaz+7FBjrOg0lY09ecmdXGSwawJg6o9qthCSgXYstWbddoU7bGeKsPKKG?=
 =?us-ascii?Q?mRctzTafSY/c+X0xsCH9/AIzkb+0MiT0cc0viXq1BW6QHpY8k1htUK68IMi6?=
 =?us-ascii?Q?XhHDDq3rydK/P0MEqoQforVM2KWrGd/OQX6S0JQSDjVzcOYtj4AO09boAQ+U?=
 =?us-ascii?Q?kUMEXrYrHR9454XfntHA8s3NEb3WRLOL6xKqGJT66Cf9pGH1PXlKzr4lSB8f?=
 =?us-ascii?Q?WaWill6MO53eR0kZ2EO09F0KZ+GBcbJ6TSIOUNoGpVEnVpLCRvY8BXsdQbMT?=
 =?us-ascii?Q?VY/x5OH53Ue9G/FYvviNjPIkDUwhAWhdohf3rzqkAqLe5Db2hfXOE5lgbjkU?=
 =?us-ascii?Q?5cP2JU78X06folZ0j/yge7Osep6FyitPRajnPh9VeyguKcjqZmauyQxNzstM?=
 =?us-ascii?Q?yIGiCphvyrByINhEWhzgXUggXhnVOCvoyoyv?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:39:57.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d811b50-a6f9-4468-cc9d-08ddf74759e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB1894
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

After switching our boards to standard boot, we observed that the
kernel hangs when booting with the "script" boot method over the
network.

The original scriptaddr value was copied from ti_common.env and
remained unused for some time. On phycore-am62x and phycore-am62ax,
however, this address conflicts with the current location where
ATF is loaded (CONFIG_K3_ATF_LOAD_ADDR).

Move scriptaddr to 0x89100000, directly after fdtoverlay_addr_r.
The phycore-am64x is not affected by this issue, but we update it
as well to keep all phycore-am6xx boards consistent.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/phycore_am62ax.env | 2 +-
 board/phytec/phycore_am62x/phycore_am62x.env   | 2 +-
 board/phytec/phycore_am64x/phycore_am64x.env   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index ff4ab8c87b8..47e90f1b7c6 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -5,7 +5,7 @@
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
-scriptaddr=0x80000000
+scriptaddr=0x89100000
 fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index ff4ab8c87b8..47e90f1b7c6 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -5,7 +5,7 @@
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
-scriptaddr=0x80000000
+scriptaddr=0x89100000
 fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index cbaf45b3ace..f4136ed237d 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -4,7 +4,7 @@
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
-scriptaddr=0x80000000
+scriptaddr=0x89100000
 fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
-- 
2.48.1

