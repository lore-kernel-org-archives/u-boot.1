Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AF5C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A239829E2;
	Mon, 28 Apr 2025 15:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kUpb3Rua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA8882B07; Mon, 28 Apr 2025 15:45:49 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1068297E
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVnM5kSDsAvmslo6G5IzbjO8lFcOFoaiWKPfjQHLboLpN1jTwLT9q9l5DW5u+EkibXVM3PFUi12QrWM2NLbqTQ56qwmAaAY9TiSCpn0K9qV7/FJka97SAVeikFGd18/Hdxrg5uxDqL/f2S8rBPqT25ujxOcx/5NS0kvxixBzTfBl42eNNQDuM6DRJDgZO+XY8KZKCQ3PQG/9cch26Y6Nu5VvJPQgWvJzh63ZAol+e5d1xO+7I3Rx4wPHHhjdYUUcjFdOdZ9+xXOLYncU+n+oC+YU0SBQo8zT+02BVZhpe9xqS0o/mS/cSdlxIpY4AVjHLQ7l6u8hTDWdvugGpuP65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFHIELUm9Nf74y1bBaPQeLjGCyRtAoBTl0stqvgKTz8=;
 b=uxGAysvDEM5DrZCKBjBgWoss4GAY1zTMB92m4l8M/f9BvXfmlIPH7FY5l8Up/rX9EnyCCo0NQLBRLxtgw/tV3ggseyOS7CGVQQbbHvUVf8n3d3cvmg4wtC8Mtw11xg/rAMrU4Gqhac2Gny7mfbFNQqmu8v7A2uZTI7WjZYs44F38SMM7ewyFtlm2L/blLb0Lsi6pDBlNf/YCaPimV5MyLyXHmL60lgUe093zKaXHIOgPO48s1DyH5rnHo6Hg5VfvVZ5ZG1gVtU5BxuCV/Mq+ZgZePLrlqzQ8MeQaa+uvDbW/aWDZn53PtKORVTmvXUfY88ZpFA9smfHMZ4UrLE5J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFHIELUm9Nf74y1bBaPQeLjGCyRtAoBTl0stqvgKTz8=;
 b=kUpb3RuanxOLfoOLQIz5NUH1jZNRBWtxtg4K7yq9cFAxBZA2yjzsKbFK2sB2MlgR6liMCvmDt9MAGwUk48bI+aOsnJWujcJUr/5NV4BRrajBTTMaCvsQ1UKNuuvE53kzadIj3ewi/5DYU39Q75DMR46e3xVg4K0D0NNBQ9LLnmo2KsBEDRto/GugjD+KCzBSmzB1YrH5SUftk3HmLy5q9au/FCOSbXVTmLYAZ/0XxeNWPbyFFiL6t2tb31yC6HkYI6J0DgFTPo+er2f2zg5ENgeG4zh/wywBz8bKf8Et9VKaLTx8UE0ELhpL2nvBt61wZlwq/GNE1BfnKOeHr9rXqA==
Received: from DU2PR04CA0041.eurprd04.prod.outlook.com (2603:10a6:10:234::16)
 by DU0P195MB1425.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:341::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 13:45:41 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::d9) by DU2PR04CA0041.outlook.office365.com
 (2603:10a6:10:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 13:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 3/7] board: phytec: phycore_am6xx: Set bootmeths &
 boot_targets environment
Date: Mon, 28 Apr 2025 15:45:27 +0200
Message-ID: <20250428134531.2884940-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DU0P195MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ac7569-c223-4f7e-3605-08dd865af7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4livlnv+vSADEcbtGwB/2MekGmzQVRwZXe940jGyspqsT2iNDpN4vH4tT0Us?=
 =?us-ascii?Q?8PFbJKO2+4zh8bDuP3GzM87vwxvU70seilE74mFEim6vEu+T9z9faIJkLPv4?=
 =?us-ascii?Q?9Mx/SpENnUEYemYDD8OlaPswqzn5gz8+gNDnvuwaoRdAmhVvv9Zy/o8kQdkl?=
 =?us-ascii?Q?yqo4+PHNG3ilS+tWjiHXuNWK2tn4He8xthDKEo9xqXRmqQ836HK4qlCCTC5t?=
 =?us-ascii?Q?7qHueithmI9/ET1Z72lMNSCbaSNNSkv/e60FHjR+6WjvK5C/r4SKkvGemviW?=
 =?us-ascii?Q?W89ghkLJBIS+7M4jnSTQtiJPVaIWm61zpRUOI3GvuagSue+SO1jTU4XwgG9F?=
 =?us-ascii?Q?Ice0qA3Z3cyIXVlG7ZPWiYKuIZZ0l6+1mVGNIKer1vad7OBZuqS7wuFgeqAn?=
 =?us-ascii?Q?NLaGCqKyAXEx9hEmP5/q7Jb+FJHCWQyv13ijKpU1E87GcTarOXQNhBC01Muw?=
 =?us-ascii?Q?Hdy4yzg0Z61tOPHDXowOYE+X7MtM1tB2vI1GDeumZhyNveO2ToNDo8lUB4Lx?=
 =?us-ascii?Q?8uWuKx9Y8zvUh2vMH1U9wDdt/BPQ4UBajZ+i9Y6G5kjcKXIHFJyXCT2wUC61?=
 =?us-ascii?Q?/z9eP13f9DIvUeGvHUFryH3ecBtomb6oFp1G7qN4l6VrHMLL2ohsfYKppwoU?=
 =?us-ascii?Q?dRhXgRAhNAVlCKx9zadhjZGgP7e+H2URYnEs0PyahPhvEpKKekBfqASCVbQA?=
 =?us-ascii?Q?vkBikO2RGx/biFAPzuWKzVBUsqp/dChP8ZqX85O7YY/zdpw/UXRKutc58ne1?=
 =?us-ascii?Q?IcI/RJYjIBFJGDyuPBVqAlkk6KamFzPhYHaWhgjWN/lahCCtNBkoA00jstVx?=
 =?us-ascii?Q?tGNu0bLyGdSvBibNlTqKjrqYa27avXyE4xDeLWwUPP+y/KZq4vqNbbQfIQ8V?=
 =?us-ascii?Q?DYVF6FyQwwxbS0B8NDZOjN0UJCZiWi/n9xbbQqE9wdLm3TnJNpRWdiw2TXc3?=
 =?us-ascii?Q?doRE37eYzQhtuJrfwa0lR48gaCwLVCj9HSwRM0fNaA3zWn0B3ZgcWVMPqBN/?=
 =?us-ascii?Q?cZ1C1zVVmR6u8o5qo7028h5sDOIc8V/3W50ScBa55ivF0JqlaxZOoEx6d+t4?=
 =?us-ascii?Q?zHZ14iXGc/wcdt16PpRpxkWYqaHkJeB/yQTdC8AA1er6GGWTgTtlt1q8MnDv?=
 =?us-ascii?Q?GAhCeklQDfq19VkJwzXmGM7PZNh8YwbDXtQgEYKsPo28iHRZaQUZ41PtRLat?=
 =?us-ascii?Q?hO7SBfI1hUeHNHivhjFISen/GvEjOk8uWCvBxFkR0IpcxanErZn6tAcIWCbp?=
 =?us-ascii?Q?YhVcNKQEDLXqqFVRQBEoctITOP+lnSZDnEq2KoTgCmSSv1UrQpYjfkeSj0lE?=
 =?us-ascii?Q?WsjHb1uU1dpvmwbWWcriDcV1OSJZBmiqa0TUBNoN5VDj9w0zhDWD0PGV83pa?=
 =?us-ascii?Q?ATRKCZ2anzqwD2rZgIGXQQUSManpXm2S70wDrzTVqOuk/Rj6PpKmG53wXvWD?=
 =?us-ascii?Q?DZb1gi1+BgZD59NoaliYPQPTE/jKvfRUSDLoAzK5cETmmHmxXDKVWacUKkkh?=
 =?us-ascii?Q?cOJDGfgzjiMwclTPrrN8BgUMdR8cpE9pXsvP?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:41.7973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ac7569-c223-4f7e-3605-08dd865af7c7
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1425
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
 board/phytec/phycore_am62ax/phycore_am62ax.env | 3 +++
 board/phytec/phycore_am62x/phycore_am62x.env   | 3 +++
 board/phytec/phycore_am64x/phycore_am64x.env   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index a0eacd1dfc3..df452804f98 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -23,3 +23,6 @@ get_cmd=tftp
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
 spi_ramdisk_addr=0x1e00000
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

