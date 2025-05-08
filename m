Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CBCC3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5BB082B2F;
	Thu,  8 May 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XWGuxTTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE0082B37; Thu,  8 May 2025 17:16:05 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BD382AE1
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O55mhtgM3QVueGRyRQF12plbVmpksfEinE66JkrP2fmZKHx7EXIgS6+zgEQ1XuURsnC6jUFuTVwyvV+PwqKA2y/bBIOj363zv1Aau7oCZIy6hhOJMM04r4j4+HQeSlYsYBnVH1Bw5pqLMSn8El1lEJlF6BUd9+8kS0tPfFIfw91z6zoXWb79V3I6xz9ez0SUpcserUuh7hvkaN7ux96XP04BAKRdhXTNuW2j+K2rcEZE8s1PZH466ETyGDz+Xq2iUTFBo7QiHS1tbU7nOe9A/ur5jsaaR9C64c84RhS3XulozzbIgW0Kp8jjNk61ehDRp4iPB6BMBLh+lkoQ8qxUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPU5bkZZsi6DAvEU15kTkltRv9OtcuN2t/w/w39vIYI=;
 b=XtBkSZ6p+gDCPwDD36lqGAHq1fuztMAN6vytDgAxKVvuVeogjupcLNanPJnkIt11joEvEj24uDYleTIkaar62w6pjnbmR8peYmxHtv2HO8tnyNiqctHwqMwJAXt8y9roR5pP6ftPjV6jOAfYXbFB2ZsfKMHrxjk7arh2YntUaWVLR6k0C3oJhV62Z2DaEUc60eCNe0oU0QBKbF2Q/oWIFbI/dxzTukfuSeNlCfQg+Q/KjprDqBxsDCZsADv6/4J6LmC7dZwSpNG9Qomx9bibgblFg6yzexeaR/a9fr0KwFKSjIqQy42sEOHbAPsDhiAYJR2IXmrVC3cC05JBc+kx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPU5bkZZsi6DAvEU15kTkltRv9OtcuN2t/w/w39vIYI=;
 b=XWGuxTTRAj7n2Ps/sa7glL2N+a8u2qozeFy1qxB3q9PlTAnr1l5rfr/ODcYqkyZ3AO7ikiDMs+5tegqx1eg14EWfeMyush5yZ89iKikq+kzJCSCC86f882/hIlJTutHLD8LdG+0BPnab7iz91URux/YOC8xqomQHEHBrfSpNxm+0oQ6R+FpiTI6bL/XFA57jf/n6V52rBgSrxjKBMnGklm13yO3olOCu0PA1TGxWA4egfX98ZWGNWc0Xw/SRgWBYx6SfuZ1wPYRejBeRZoh/iRjWEcY+bYfYeMg+oJpKmG10xknoAW8J1KEC6NNn1U9nzjF+0gGqyUJhVeJU6ioOGQ==
Received: from DB9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:1db::28)
 by AM0P195MB0691.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:15:58 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::b2) by DB9PR06CA0023.outlook.office365.com
 (2603:10a6:10:1db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 15:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:58 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 3/7] board: phytec: phycore_am6xx: Set bootmeths &
 boot_targets environment
Date: Thu, 8 May 2025 17:15:44 +0200
Message-ID: <20250508151548.162122-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AM0P195MB0691:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f170e74-14ab-469c-8262-08dd8e433c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Tcq7ATS9qvauTO0vf1N82bHT0a1J+JpNh4ehfgHUoIdwbLyDKGZ9JMmhL/J?=
 =?us-ascii?Q?aph4x3CKS8TUMhDbYIXl+s64vBrne2MjJELlGA1ExVtcl3wGqYpF+DUv3suM?=
 =?us-ascii?Q?aq4p82NR0srkVClmapCH5Bk90fWSTeNNZ8nmFfRgkOuo0mQQwoblUFlW3NHJ?=
 =?us-ascii?Q?zK9glm4Ubt3UXHpDIwuiCSjsqP9PIEqVkc38mjDQpzpJp4G7iZ/vAS3Zf1WQ?=
 =?us-ascii?Q?ji/WJ3fqYlOZWiebBxjrh03xZ5lHWd0ggmt4d5H7A3cx3oG7SnenaDYiwPMm?=
 =?us-ascii?Q?Q0rZ1QZihPq4fJKyP3ouP3H6DuMVYOcRQOVhV6NOJ8llnT5CSZKsWvMu+KPi?=
 =?us-ascii?Q?Vgmgt4EftC12oMefhGmZy7C6X0vMhZrHl6QsXq8VyDcVITqdg5e08WLH3bcZ?=
 =?us-ascii?Q?DI2gPQnvcehIsRRjrVKzlcWFvGztLzDks99S8NzHMJYA7rXk2RHeM8QjRFax?=
 =?us-ascii?Q?MqnNkOU71ZiVbtMtgBFDELGIkq5fgdqb4va8p6ejsFxLuXu5tvPV5FW5d1bd?=
 =?us-ascii?Q?uu6mCcq/8hWGsv7RNFfv1Va4sKpnx3M8iq705ZieuQUHM274OcdGXDRBNCvL?=
 =?us-ascii?Q?hO3CpFhJ7aoc0BgWPQapCo5DGPfusSH60gMOtCFqahxPIAdi6WTvJM32RcHC?=
 =?us-ascii?Q?5EL1g3aTPIRjmIO6T+ghF5Pz4q6AZ3ogmOzWtA5ByZPd5ncGA9ibKJWRBHva?=
 =?us-ascii?Q?fsyvZHXObiDjEMHtGbTni2/R7PfzZKHR4pjk6V33ekEb/UPgSAvA2w11SJsp?=
 =?us-ascii?Q?5FCFTjWcTA8bttBrjh5Nw9QZRtwJQhrVmXavHcxgPM7af4AfbD2BfrTUrNDb?=
 =?us-ascii?Q?w8cTefXSaN3pNonI4nXZ87M6j3PEjGD5AoLk5pXnVTiINVFHtN8M8wmeH1/E?=
 =?us-ascii?Q?b7XTYcWp5l7rY+N5F/W5J+QIjFP7L1nKamYBFCn4qa2ZujDXUkrcQtdkFeri?=
 =?us-ascii?Q?U7eB6zI52X/wW9viuDjnsIyE1Epm4iAUErp6ONed20N/B43NQIWLgsEob1QW?=
 =?us-ascii?Q?mMrEc7ulzNJFF7q9dlfhb/GAVHhdWa4rYphW718XepimpndHJJEjQPfADHS/?=
 =?us-ascii?Q?OHxXXAr5maSMLE2O2jqKdDSJimdiSAn/No/w1f7OZsWIfuUsAQqZzmWQe6WR?=
 =?us-ascii?Q?3eKF1XKG0GtWL8vyHadO8mQehPc9uUsky193ngRx2Bb58Ew0PVQMKYao/KBm?=
 =?us-ascii?Q?52sVubXuwd3XDq+IFhrSueaO6vIpl2uD1LnIJza/ExdjgkWB4o0iS/SnIOh+?=
 =?us-ascii?Q?42VqNVWIRlksFC2yyFp8LxMkbmq0qnomNdijPnp0L3oCnwhG5VtKZ/4e13TN?=
 =?us-ascii?Q?Z2rlDHLb46CqXsJkXEYoGcWNOD29Zbhfkg1xrMsCGRI3pEwzXgi5ZsGisIEr?=
 =?us-ascii?Q?ZgOHlF5XnougOpoCgM603g8nKaQoI9froI/dy/zoKqSKOFtOs3flFcX9+LBX?=
 =?us-ascii?Q?8tkWh3/zeoK8Oi+uptdXpT4P+Lkj03BIxqrKCwC5i7fZB/ang61zuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:58.1555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f170e74-14ab-469c-8262-08dd8e433c4f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0691
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

As part of our migration to the standard boot process, configure the
default values for the bootmeths and boot_targets environment variables.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2:
  - Rebased on current master, fixing conflicts after 48db49b0977c ("Merge patch series "include: env: phytec: k3_net: Remove net_apply_extensions"")
---
 board/phytec/phycore_am62ax/phycore_am62ax.env | 3 +++
 board/phytec/phycore_am62x/phycore_am62x.env   | 3 +++
 board/phytec/phycore_am64x/phycore_am64x.env   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index 40787b0cbcb..797904013dc 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -24,3 +24,6 @@ get_cmd=tftp
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
+
+bootmeths=script efi extlinux pxe
+boot_targets=mmc1 mmc0 spi_flash dhcp
diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 40787b0cbcb..797904013dc 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -24,3 +24,6 @@ get_cmd=tftp
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
+
+bootmeths=script efi extlinux pxe
+boot_targets=mmc1 mmc0 spi_flash dhcp
diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index d04a3be6864..36ab16e2f7a 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -23,3 +23,6 @@ get_cmd=tftp
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
+
+bootmeths=script efi extlinux pxe
+boot_targets=mmc1 mmc0 spi_flash dhcp
-- 
2.34.1

