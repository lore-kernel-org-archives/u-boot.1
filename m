Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F020CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA4580FA8;
	Mon, 18 Aug 2025 12:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FPfy85VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BA4829E7; Mon, 18 Aug 2025 12:26:29 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1B0803DF
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1RUafKmomV+Bb7cg9aVituEw5x6QsQRDfXrgWDC1M4kTqTr4JExvjZrHgrAhKATSYuO4tRDNPTRjNUrMB07OIX0vZ8dpUaGIpS5b11BPP4PpwMRdYrtKAKRWfZu3+ie1WwomgmKnoigNKw2LLiZS/aF0MIF3LD2KhK4wyQuFQwL5sC5T7AQXpLP1BLViMJUyNIxpa7Soyt5j877DnS7yX5nCO4r4v4MxKCxiF89lYP8Ly4MkIupPC+3tnP3nReDbg/YATlwhGrCAyO7NOEuwZxVrxMt1W3SOESnc+D005+RCSHT8STNeb98FXZ1z+oZN3LzSTDmpkN88zRjsNJrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtOI8ThvojfDcUf9Mek6a4FmxCBnNcehL2kfeF1RFC0=;
 b=g8pIQB0PTDpmmeiBAQ53ZqZJMkzs2kUFc6QJgyEEcoQJ0VXFzad+pqjcdJ8ZOZ2+F9Fm3ew1znLPa9Yp/jdmJ9IPU84gnwZrM2KDuoPhFKCnXWliZ4li0TOMDiVa9bdlMbZN4s55d524p82sBAX7irEA7rJ1SLXXnxcM0E9nIPZPTaALbnbkkd59hqYoSuJ9IdIhlmb8LV5QB/CaQCV7kIQuHeQItbeBajOomSP/p7Rh6/Vl6PrNl2vVjI876nzSM88Omki0YZgEK/aoEAH3NRYiKQY0PFLVol8z14P8+3eurRRBOhuB1MZ0XifyHSFbDHsqAC3iiRpqKmlinFlgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtOI8ThvojfDcUf9Mek6a4FmxCBnNcehL2kfeF1RFC0=;
 b=FPfy85VK8SNZPN212qZGRhiCkx1DP+dpJPQPx31Dd8uvRm6MECTIp0SRNV8xww2SvH/kS2GhNCRVf2I4HRbOxBMggDi/HWT1JE1Vd9KF1VY+YUTZZbqi/ttuUpm9Ib36aZOzJrARjopbbOtNXikV4kr3nTfPNjrA3z+rNSgFAndKpzLyAElyEgcMDRC1L3ZLnzhliY+pF+aG1fdhgH56L2NTGoDWyu8846xj6DPEqOMfTR226H0NK2lOAoE6ACjv/7WXsvq42g8eZOYKGn2zpWEyiylqMNA7cSZmKIOSiWZgh/2rw6nBzS5W6ClU1RtT2FrZBC9N8MVyxhQN8Mqdjg==
Received: from DUZP191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::10)
 by PR3P195MB0863.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:26:24 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::5) by DUZP191CA0013.outlook.office365.com
 (2603:10a6:10:4f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 10:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 10:26:24 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 18 Aug
 2025 12:26:23 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 18 Aug
 2025 12:26:23 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>, <ggiordano@phytec.com>,
 <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] board: phytec: phycore_am6xx: Add rauc to bootmeths
Date: Mon, 18 Aug 2025 12:26:05 +0200
Message-ID: <20250818102605.2248056-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922D:EE_|PR3P195MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b72268-0655-46db-648f-08ddde41aed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h4c2fRr0T1s9Q69hzlBi0kBbv2X7Y0rwKASfuiyKh4DZ2nc5JNLv0WA4tZqg?=
 =?us-ascii?Q?KVdbhBVZYUKIo9NSdvYFGFJ+RXQI3DMPF/cjJ2DEiStgrGTGrzD2Q2ewMqVt?=
 =?us-ascii?Q?/rdJTcFz/ma560m/U9x7j+isNNqPBARVe5w9dEwJ1W0pRu0sE2GCxzavLokN?=
 =?us-ascii?Q?CpON15loAdpj4TcCaIybPUlcqj443bO+IS7cywVz9Gl6zx9v7/vIdL0Na+3b?=
 =?us-ascii?Q?/tfURdzdYT4KPzNWRfef1ohD9caSWlaJAUPxbNm0f5VvOpO1Foc2+G7+SyuJ?=
 =?us-ascii?Q?ZFd1DuLRJ9etWFesx5A71onnWvUgB9TdlFMkbePFZnfX8FDXKal70R1fQvWC?=
 =?us-ascii?Q?b9XlchFbmzwRxkj65JNhAScCtbPdgesDaOMXCshCQJ+frvz3AScg+lI7PIib?=
 =?us-ascii?Q?Na/WnBBxkzIQ97GfdTn8BvABrt/W0ekCj++BkZ03HjlLyTsHDnAX94lP0fK6?=
 =?us-ascii?Q?H6xWz5mqFuxKzwMbBbDGK5NMOlprnmFWCxWwu7TyE8vWGzvtTrNso1n8AggZ?=
 =?us-ascii?Q?uoshd+278WGX/6Yr4nopfxIgd0soiNJ5TzG8gdnjGf+BDdPzEKVFmRZd0svs?=
 =?us-ascii?Q?Kh8OUTiDx19CAOgThav2pbfHtHHd/kcMVqYI4o4TDBsRMVse28j+kOdiJ8+6?=
 =?us-ascii?Q?HapbbpJm7JR407wM7kbvUPJCaHJs4GanoHHSaICiKRvk3Gr6EUJ5Fdwx5pGV?=
 =?us-ascii?Q?MxHGZ47xA1j3oJqZKYHrtocfmaE61LlGvNl4+Cz91vA3zGV+hcritoFTbHI/?=
 =?us-ascii?Q?HcDOLFyYl6cKC8TUoU1ocjZY90mQBXt+VczYwZ24mojzzvizzyY5GwyJACsT?=
 =?us-ascii?Q?DMEJFNbZaUcRZDZS4ObMpyekY9gIurAt8UvD+sKhzLu82smGakqXNDXYgMOi?=
 =?us-ascii?Q?7yAImItoF1mlpkbeelfzFiJHbcN3PEnV7eeHrfDs7rZga6zVJ9yy4o8CbHAK?=
 =?us-ascii?Q?9K1HIZlKN3mHarehMSS+HOQ7OoE10R72MV3JflYWsiCKDghwMYgBisdpNIuN?=
 =?us-ascii?Q?oTghJ1IsT5TlA6Gw5xL7UAUpEt1fRzogjpvg2frVIqQtGKWMqjmMFBVFlvKA?=
 =?us-ascii?Q?3u0aeBbFnuepuHK3YGNE8WpG1QF3eORhAnGuvuLqymKesWwIa7XPgnTtZBgs?=
 =?us-ascii?Q?UjZH3QMMX4oecZnNXzzR/DQQ1RcimdjljZhFdeNmfO0xeS+KkKb+no6MlAEE?=
 =?us-ascii?Q?aO0itt9nHUhhKQhwFb/zau7EvCX2gCwD444KmbsweOYbIMCoyCaNUr9u2qGK?=
 =?us-ascii?Q?xzyn4YszOBYnEcvBu3xqcYmyyfJDTZJItGBfZbSCmZEZlSMGrJXXxQu6sOgv?=
 =?us-ascii?Q?j8A00RVAuXnCDg7isvDgnOz8+hx+iXPKXVhI0viuTRUAylUMg3R7gWfLPxOq?=
 =?us-ascii?Q?BYkfISUZZ+3ICPKh1NRYVaoUE3OXPmyjiNu+QmA4VSK8zGwfO4eioAUoXRmW?=
 =?us-ascii?Q?zlpRgS4xdiJJEiG0lLjzfPjVjN8mLF5/w+6FZ7zvUhqAAgD35tL4TYNBe5Xz?=
 =?us-ascii?Q?Qgsr9Nby9tQyB8gu4E6xl2ljBKpFa8PQTcUr?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:26:24.3514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b72268-0655-46db-648f-08ddde41aed9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0863
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

Add rauc to bootmeths variable if BOOTMETH_RAUC is enabled.
This is setting a proper default for RAUC enabled systems.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62ax/phycore_am62ax.env | 4 ++++
 board/phytec/phycore_am62x/phycore_am62x.env   | 4 ++++
 board/phytec/phycore_am64x/phycore_am64x.env   | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index 797904013dc..ff4ab8c87b8 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -25,5 +25,9 @@ spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
 
+#ifdef CONFIG_BOOTMETH_RAUC
+bootmeths=rauc script efi extlinux pxe
+#else
 bootmeths=script efi extlinux pxe
+#endif
 boot_targets=mmc1 mmc0 spi_flash dhcp
diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 797904013dc..ff4ab8c87b8 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -25,5 +25,9 @@ spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
 
+#ifdef CONFIG_BOOTMETH_RAUC
+bootmeths=rauc script efi extlinux pxe
+#else
 bootmeths=script efi extlinux pxe
+#endif
 boot_targets=mmc1 mmc0 spi_flash dhcp
diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 36ab16e2f7a..cbaf45b3ace 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -24,5 +24,9 @@ spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x2200000
 
+#ifdef CONFIG_BOOTMETH_RAUC
+bootmeths=rauc script efi extlinux pxe
+#else
 bootmeths=script efi extlinux pxe
+#endif
 boot_targets=mmc1 mmc0 spi_flash dhcp
-- 
2.48.1

