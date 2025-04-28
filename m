Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7774DC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C316F82B6B;
	Mon, 28 Apr 2025 15:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="t8HmHenN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686C482A33; Mon, 28 Apr 2025 15:45:54 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FCF82ABA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9nd1abIrtN66s74bCacA6TmLcIKoaTwJPjR8Wm4UVnsAvVDrBqpG50WSjO5e8RksGKMPnOODdSnfm0BBER0yoFF3jq1PJ8mrT3EiPphdc4FppZMHega0Xs4IOId5P1Z/otPW+KD7dpsxUpwoP8I8e/gnLpKHvo591HqJOE7MsiCEt25CkKyawF0SmZM0bYjqB0eml/EUZkQx+YAh0hySxNPgPt095eYWnmU5OYTEV1f1n4fMaQEM2FtzJQDLIgVj0XguaCth6OPi12BomWIclohZMbJwLBx9zd68SrcPEqeqUiecf63R2q7IMUU22ni+0DVBW5BhSTrmklLvWbs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fne9odfK8CsRTHl47oFTaRx4W1dq6XYzhE7Hgt6gCQg=;
 b=ZrTyI7WbnyPu2E+TO+ZZxZc73ze3pAsfvpLHZxuCXJfw3PShX5b/zlt8PYv9XRqQtgbqd5frVsVuzJ09U4zMZeli1t1W9MuJ4VibTnwwgwc7+ty6eg/nG2eggHZv0jiNOC1el3bBKG58dcVnL5kOdiaMuMX37yUnsx7OVt56V4Xk/6gG4Llxp692OuyvENX0oQG3b7OUnNWFUPCMA/PEQjb3HFUqhK+91WrK7TgcQNki/qh8lEjXCtXOJI24+2CmlcczcBLmCSFrOOxG9OJckypzqCrGJXMwgVkzZWDIuw1wEygiZdISi/x6hzGfppr6yZ7nWHguYgq7UWVwta1YTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fne9odfK8CsRTHl47oFTaRx4W1dq6XYzhE7Hgt6gCQg=;
 b=t8HmHenNTsIIZJ4Av6dCb/16Wz0iOrVvVQpXSoar6LoFrV86Vx6CD+mTygn27SPbBLPsSKzR5vqJj8DVptDCjO2llmpTWVKgREMRKiB9QOeIzGRY5RHuSxz5Lgl3lhCt/Ph1/cldzAS+MosCihAaE14XN2D+99BqUE1Na6ffFId8b5axT6OtgA0mB96GwzMZ8N03PrF/2ZTYIOkYMY9mpiBvMmn/rA4D78oEnrj8HlVwLmUcKRTmLRKPS/euTP9IVkWicYD7IcMvXNbf6GmXNABzvr1suOJltyCU8U2J0T+BlSEBTZNN/4kNtut3YxlJbeyTGYt9cWdVbVpY5lmlkg==
Received: from DU2PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:10:234::34)
 by DB4P195MB2267.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:45:42 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::63) by DU2PR04CA0059.outlook.office365.com
 (2603:10a6:10:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 13:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:42 +0000
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
Subject: [PATCH 4/7] configs: phycore_am6xx: Default BOOTCOMMAND to standard
 boot
Date: Mon, 28 Apr 2025 15:45:28 +0200
Message-ID: <20250428134531.2884940-4-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB4P195MB2267:EE_
X-MS-Office365-Filtering-Correlation-Id: 77955f77-4ff1-4481-b90d-08dd865af7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9q3h806rsa7IOGXfnc+pH0jbKD802qyYBgS0I7Q2JupWHATsJDy2z1hjfu94?=
 =?us-ascii?Q?4X70mO3XGTWSEcbuI4YMI1nUDrGakeLkog5py+ZyCBzrb55dE7tIeNMkjrKC?=
 =?us-ascii?Q?IPSyACqeKusoAL+N2NNKVe0DIgFOyRDLguO7cbLbqPkoKBIH5lZkovt0ozwo?=
 =?us-ascii?Q?vlh5s15biOayAvedBARLo9r8UdWxmsF7tDA4BLYqSbixR5wyq8O6gJR3c/3k?=
 =?us-ascii?Q?nC99mtQBElzcoQ1HichyriS/1pzjH0eKybYEKlGHTrSuP/Yl3KG0Q52yGxD9?=
 =?us-ascii?Q?LWUCrMwAddeKDXrVEgcxX3M6t6aC1JUJ7QK9Kr/smxGEYxG9fXQfKBUKYYg6?=
 =?us-ascii?Q?4buvKAJ262wo7pdNrt+uml89geQRVZBABG2juuyQ4/dHtKpQlpL5UQ1DlYm3?=
 =?us-ascii?Q?SDmqEIxWLy39JsVN5WoarH5YG02jzUH9NrWWvFUtR+vWJTKqUf5vJkMFiOEW?=
 =?us-ascii?Q?viPFa3zSxDcxX4YYPDVpsfox5iW+DBHiLcgRodpIpZsH+gyjXXqcnLqOQ8es?=
 =?us-ascii?Q?OJcpfJ/2HoNZrBz3+LzqqP/kAuag53ONkdcjROUn/jyz2I1NG77vkQETP84T?=
 =?us-ascii?Q?wjBHRqgG4NN816V3V7rwPBkj0pnwM6f9Efpm3PlRMoP6epqwbQwvLsDRttkV?=
 =?us-ascii?Q?UlI8B+g6XqYYBrZiHa00NRULzMKWxBNlH9Q9Vx7rTwHQo7YkLie+l1D/NPbg?=
 =?us-ascii?Q?fuXHL1avq0QsYxrvtbAH6KYfCE8eoC+A4bXtg0MhdTq+zKy8uHyINcHXmZGM?=
 =?us-ascii?Q?ke09kOHhNYQP2r1RCcQ8bq1qoBsOBbqDL/WoX0m0pSCDdY88csVgxuwZSVPq?=
 =?us-ascii?Q?taFWiuMbaGOLNeGFl8HnF3QFzB7m5JpE2zZx0RL5anScKxpBhxSheiXvg7Cq?=
 =?us-ascii?Q?KP0CSZvjyT4O18VwXq4wi45GsxKSvGUi7O5rUTYsQ/yANYO+hCgur8x60fzJ?=
 =?us-ascii?Q?ywEBvmFqpLve6qCSpIWRQrNbhIfYPdxSuDP4yeKQ0glokCWvRzvhUjscx4xJ?=
 =?us-ascii?Q?IQ4FjI9S4xFbTDqq0rv5+JxYVjcMpQrA46jV6ngWL/ATrtzlBMNbC0DwsDiV?=
 =?us-ascii?Q?fpq1Qd9KRoApTAgIChdFJzIOOfPsZXvAeGE/im/dY9383EDXuZ3dzn7o9uFa?=
 =?us-ascii?Q?VkD9srZ4Q/50nTlbeiDUHNKmaCT79MmyOrAKGVCPEuwTRj9ODc0iGf/ESHsN?=
 =?us-ascii?Q?LjEaqVQqiBfl7nzsNwh3CeqIl1QDhunmkPiBn3iGcga7aNk1RkWdV1HpeDbg?=
 =?us-ascii?Q?pmN4GYec2DhatlVvkvzB17DBqAaYEntob2jbCKrikYqhVm6lH3C006b4eL5d?=
 =?us-ascii?Q?pzZgv0CJPyXUm9SfKm6UriYhpNWmt1iKArPLcvZBZH6/fQlMovY6Dil3RKks?=
 =?us-ascii?Q?vP9X75nKxiP7aPoNpddad1pBqUv1QjD3Szy59pgF53Kq7JtZXcVZ/mypYB4P?=
 =?us-ascii?Q?Ub28BDe/mFyOG8VJT0WQysygJIR6lg2gWuey+UHT7ytP5IPFW9WVRrf6tCtg?=
 =?us-ascii?Q?aa5CN9LUwBKrNSGJZIOfDq7GpqFfxX/KpcpM?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:42.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77955f77-4ff1-4481-b90d-08dd865af7fd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB2267
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

Make the "bootflow scan -lb" command execute first and
fallback to the legacy BSP boot scripts.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 2 +-
 configs/phycore_am62x_a53_defconfig  | 2 +-
 configs/phycore_am64x_a53_defconfig  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index d86e19d914f..c9d3c9f4bb8 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 3622e1a7cf2..22060e2634b 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -46,7 +46,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 72936865132..40e92525ef2 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -41,7 +41,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run ${boot}boot"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x180000
-- 
2.34.1

