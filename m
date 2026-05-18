Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30447CD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F438467A;
	Mon, 18 May 2026 03:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Imi+MNeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B1883AA9; Mon, 18 May 2026 03:01:02 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA7D84150
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBpU8TH1IYIdh1XM8MemOGgmoduaKh1+jARaneqzL5vHN+qNmU8v2J843Q8gjfsNLRaU4QmkKyaW9U9l3vNYyI1x3pYX73cgqGOvPNxetBCQHnMfmq91ZUWL3Amgm7e6fSxegd7dVelNDKVkrMfqIYqquhRFqhdOQ1xRGRsLFyIO+1JYgx+5drL9/+xk54ZAS73nwHvaxif1XJX7q7FxWaDCf5wyBvn8eK4o7ACAzOBPkfcxgrKwoFIji7BF2uP08wncsMyJnkqxP/QKSYpAIAA3EVawLV6/Mtnkxz30qKsDK9WCVc7HO9hu4urwxzTHc2P31sLfykrJU77lWQpDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eVtYknbqaFtpwu9c3HBzQ8ggXsWh+3XXHxzJPRtF2A=;
 b=up+J9s4ex1jXbY+DZBs39M9wGylS7j39MlrblFeU6ZauVi2vPVMt3mFRElCLy0qLbldRTjiUjgbcskq1ytw8VUAapRsZ6Wf4Uqn3hmuexUup9I/DmsdaX+Pt6zjQhN0WBtYSleA7E/xRgJnAzTki/aWnu07i58cAHn7mty2ava1HUKybk9UDTNZpaZ4mmYGL4t/bRojxMNNGUXIWQYbsNin0XUOJ03pxsnBpPdlfTKJKWfkG8qQmQLxmLxjy9MUF6GLDwE4EQPoLcYVF85dj68Zoj0ig/qbLLLRne/+lWlr40xKRJqB/kE0eXbBY1m+qKUfa9Zk5b2whb/y0PHUYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eVtYknbqaFtpwu9c3HBzQ8ggXsWh+3XXHxzJPRtF2A=;
 b=Imi+MNeQYrAWQRgsQ1lx+qc9cl+3GnnF49BbP9e1bDShCljlveihtdvxRoQX40HRKoY7HXBKQrF04Rq3CntNtlBRVs9Aa0pP8QqBXpaBOPTk/17ld/M35kfnyW5bqDzgVM/bCoc2DD0DwfKz0Rnlh+4oEd9ecSCjBpLqDLu5BF+nDNAZpcMXDuZuxlZCK6mTiVlbiBqEH685g9nV7THimobQGzxBmYBJoV1eYkpbwr79K2K+Kw+mGwDUnbwtabzumWL0SDDWJifuzjpZI+h8u4Ul64OC+g0LXx1buIsb4QoX8CFO/dflJhS9dTJl2FDrVS+8rxDn4yxAbYphrA2mtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:00:58 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 01:00:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 18 May 2026 10:18:10 +0800
Subject: [PATCH 1/4] imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-imx8m-of-upstream-2-v1-1-05c0b996c883@nxp.com>
References: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
In-Reply-To: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 092fed1f-4b9c-4cc9-766d-08deb478ebe2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|18002099003|56012099003|22082099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: Ive1c0IeXAl3ieaEdKUZlvyY0gu7IcnnoeiJUDld4bN8UngNpA3Bldp96OH49YSeWq9MBYah5ShH7qax8pq54jFmnpvDC6E5hwuhsh5G6qy1/J/wrA1Mw2lxBo4dFGi+oSUtSTmrzLVu6Y50+FJVsrsJVYS8ER+AC4a+R6JtdDwSyN+Km68pP/GUzg+c0Roh97Khft+0oBD2nVum19lJywt+loQJHQDejBkRVlxXsoHDubeapQZFMmCU3Z+dGxwcdNDF8HwX4omvvtM2OdvNrXz9WpYMmEkBMVHbWleacx81nb4LY5RQZqr68Ap5b1TZoKnq70CTFt6zNE7MONqcJevACtapK2zqsTiArRGIZOVsJXYpUhhbyHPklSY7rru1b6mZQiHslx8YNoYqwTlJRSIjg/xcloRvkVCr0Y9dyuf/xVsjKBifDUGti7gNIf4H/MCbOarqED+RZyI2RMSHDNbBoiW24M+ayIglaVekI8TkrgINn/v2YAhba0f5xz43hR+/CIsZJkTejnUYBB0A4dK0WnZAVj+764KdSdU4rdsVC75RNeK+5M2lEpXAmmAOnSwt8jXQe+U14k98C4WPf060geWZMQz82DjR3iCAip+XTeUVQVc+SktNSp+0EiK8XdtNt29qeiyIRhdCH1x/xNvWx6I2xwq523lagqUA4vyhRs69VvKo5EcsPn0Gad1eqdkvfBNi8DJXIwgG9oEWCygG6q8t5AwXp8aXwwgI/39q5Q1Mu4zjjWN0IBaDWVtz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRQbFZVSjdVRzNDcGdTdjRPUGl4d2w3SDRFc3dBMGdvZjhjNDNSNHpHZ0NU?=
 =?utf-8?B?UVdEQ2pZeXRWUmNHTnEvY1gzWENlb1Z2SFc3UXZVV0hieXhMZ0lOMTVjLzkr?=
 =?utf-8?B?RFlQOTM2OTRkbi9oVzVOamlGZDcwbFFFVFdsQlNwd0EwVlBSUVFnR3p3Yzdr?=
 =?utf-8?B?dlFya1hnRlJkSnhGSWVIR1A0SENzN2kvUlVaODlNMklXZUxDYURhM3FicFBZ?=
 =?utf-8?B?OHlUalo4cStvWm4wc0s1SWZiS2VDRkJFV1crNmIvQ25KNDQ0UzI5MGxGSlRK?=
 =?utf-8?B?NCtJeDEzQ1ltZUhqTnNQaXJuQ0dPNU5FNkdhSU5aNzNsVEdkSUVYQzlGcERW?=
 =?utf-8?B?RTlSSng1TnNyRE1lemVIa2VzV0RiNk16Y2ZCMTN6OGtyRnlDMktrcERYOHZY?=
 =?utf-8?B?akdadVIzYmlYUXpHT3l0TWdrcUpvSXRPRlQwajd3MDZsYlNWRWlaM25xM0hB?=
 =?utf-8?B?dmU1RlBIVUhIU0FYK1hxNDBxQVBpNUlBa2VhR1JJdGtuRmpzQmJSV2V4RDVl?=
 =?utf-8?B?bEYrbFNMTHR6eGVTMGY5TFhvem9SNVI5eVJaMTZuMU5RTkxiVVpPZ0N3Vyto?=
 =?utf-8?B?STJlZFMxVlhNYUdHdHpFeGRiSm5BbHpwOHBkR2F5d253ZTNuUFlZRzlhZFpN?=
 =?utf-8?B?V09oZjIrVE5RblRLbVBOMUJINktEZHJCdTN5ajlYTGJaSEVudERKTklsY3Qx?=
 =?utf-8?B?WWFETG01OGxFcUc1OFZGbmVvdVhGWlV0eUNHRzBWaW14TXRPdDVlK3hSQnBX?=
 =?utf-8?B?M01aemdVOXFIdldsZjV2MWdtRFpMN3ppMHRWRkQzSG9YM1l4a2FNM0Q5UXBZ?=
 =?utf-8?B?S2tWRUE5NVdObXpsUTVaeWsyNW8xRWZLZHhEVzVUOFVSM0tUL1JtdGJsWlhR?=
 =?utf-8?B?OWlRNisyVTVtQmlSTXFnYll6ZmhMb2RxUWtILzFNWUFJNy9Sem9hRktDZzY2?=
 =?utf-8?B?dGt1ZHRYZzJORDErZGVvTWJlbldGT0JpMWRZK3QwYTk0b0xwbVhhNmRxcTUx?=
 =?utf-8?B?bUpGY3BEdHlad1o3N0V3bWZGTmk2VjVjaTZ6ZXdZM013dkM2VlNlWHo3d2xM?=
 =?utf-8?B?N2ZhOXpnMlZLYVl3eUpKMUl2V3htNnlQSVV4c1NYbWw0c05BSDVqQmVzLzQw?=
 =?utf-8?B?b0g5ZDQ5R2w5eXB3bzdveEZqM3BuVFQxNzVnc3dPU0hvM085UkY4UUU4Q3lS?=
 =?utf-8?B?c2ZZcldLZ0FFVE80YW9VQnRydUdxMzNndzF4S1dHVW5Xclh0QnFoV2hPK21P?=
 =?utf-8?B?b0FGa1owUGhoaEtLN3RJUjRmc2NZc1BqZDAxZGhoSmpZSFlqUTZMQ05WNGpV?=
 =?utf-8?B?eDREc2h1OVU4MTJxRWFGVlNFWGZIamtJRE5zNk5kZnlzTTlWRVg4V0kxcXhy?=
 =?utf-8?B?b3I1Tk9veGl3SFF1ZmJlNEJHaWYzS04rVVVOaWdLY1pyMmNLeTlqRFVIU3Vj?=
 =?utf-8?B?dDAzeUcrbGVxYVBhTFhTcE1rUDgwejZWeC9vWUd6WWNJcjJqd1lQdlYzeCtS?=
 =?utf-8?B?em1GN3NWMHhIeVZjVnpoZEtSa08wdUJxbnQ3U2FhMndUWUxvQnQ5bUZYZ2Nn?=
 =?utf-8?B?NlNBcXNYWlUrYXdCb1NxZ3UzNUJ1ZTQ3MTNmWDdGMllpVUhvQTJnbWJnWjNs?=
 =?utf-8?B?TGd3VFhrMmd1VExlYzA1UUVZUHV6YnA1b2hPeDFJOG9sYmFVRG9qNk1IbGR6?=
 =?utf-8?B?cFBwQmVYQTRPVkN3ZHZ5L2VtbHo0WHBTRUtrWGhZK2RjeHpxTnY5Snd2OTJq?=
 =?utf-8?B?UWx1Mmw0cnBkWTVIY3RUSDdHMkVIcTlLWmNWUnJWOUJ5SWJXK0VEWXFVcXkz?=
 =?utf-8?B?NFR5cGxjd0FKK2NrcHNvVUtRcDJwYlFvZUhnQ0xUS2loVkRCc2lSYUpPV2VU?=
 =?utf-8?B?MDVDQmRuaTZjcUpWb2FUaFRQVkdCdmJiY2dHNXpFMkg2aUFsb0tZMVpZc0RU?=
 =?utf-8?B?RVUzK3p3U3BBYXgzZ0o5NjdyUi96U1U3QTlpeXo0bVRpTnpHa0FjOFNOWkVs?=
 =?utf-8?B?MGd0akp5WlhTdUcrWnl6VUxaWVZIbDdEenZqZTd0dkxKdXNzNTVoSys2UHl4?=
 =?utf-8?B?VDZWU1hOM2paVkRzL0ExRjQ4VTVlcVRYYkYwMW5OaFUzVWF5eFdxYk5odEgy?=
 =?utf-8?B?VTA3WFBtYUlUM3pNTDNHeWJuajVIK1pWeUg5dzJudkdBaUE1N2x2SVpwWkdH?=
 =?utf-8?B?b1ArY0FGQmg0Q0hoWjFUenVaZXhpRUloRStKNUQzeVl1N0hQQUZQdURSM3B2?=
 =?utf-8?B?NzBzYi8wUENJUjArZGdMZU1zL0lhYVZtSWpqNlVuWk5BWUVYRjNQQ2dSSklE?=
 =?utf-8?B?Y3JsRXJSVE0wdzBNR3JMajduTEhVdHp0WmdzZUQ2dTV4OEt4cXoyZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092fed1f-4b9c-4cc9-766d-08deb478ebe2
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:00:58.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/fAReHbDW0khAQC+xOmdMqUJLR/7QuPWxqbMs/QdJG2AEv4/vsoxkmqSZcYIXPjCdTtwgGlyGEa0uPAmuEVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9272
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

From: Peng Fan <peng.fan@nxp.com>

arch/arm/dts/imx8mm-icore-mx8mm[ctouch2.dts,edimm2.2.dts] are same as
the one in dts/upstream, so drop the copy and switch to OF_UPSTREAM by
updating config and selecting OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                         |   2 -
 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts   |  96 -----------
 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts  |  96 -----------
 arch/arm/dts/imx8mm-icore-mx8mm.dtsi          | 232 --------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |   2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |   2 +-
 7 files changed, 3 insertions(+), 428 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0f4f6c986f0..58a6be9c060 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -874,8 +874,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
-	imx8mm-icore-mx8mm-ctouch2.dtb \
-	imx8mm-icore-mx8mm-edimm2.2.dtb \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts b/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts
deleted file mode 100644
index 50274540284..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "imx8mm.dtsi"
-#include "imx8mm-icore-mx8mm.dtsi"
-
-/ {
-	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0";
-	compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
-		     "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-/* SD */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
-	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-	max-frequency = <50000000>;
-	bus-width = <4>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts b/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts
deleted file mode 100644
index ddac8bc7ae6..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts
+++ /dev/null
@@ -1,96 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "imx8mm.dtsi"
-#include "imx8mm-icore-mx8mm.dtsi"
-
-/ {
-	model = "Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit";
-	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",
-		     "fsl,imx8mm";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&fec1 {
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c4 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-/* SD */
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
-	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-	max-frequency = <50000000>;
-	bus-width = <4>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx8mm-icore-mx8mm.dtsi b/arch/arm/dts/imx8mm-icore-mx8mm.dtsi
deleted file mode 100644
index def7bb5d37c..00000000000
--- a/arch/arm/dts/imx8mm-icore-mx8mm.dtsi
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/ {
-	compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
-};
-
-&A53_0 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_1 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_2 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&A53_3 {
-	cpu-supply = <&reg_buck4>;
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy>;
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-			reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pmic@8 {
-		compatible = "nxp,pf8121a";
-		reg = <0x08>;
-
-		regulators {
-			reg_ldo1: ldo1 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo2: ldo2 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo3: ldo3 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_ldo4: ldo4 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck1: buck1 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck2: buck2 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck3: buck3 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck4: buck4 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck5: buck5 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck6: buck6 {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_buck7: buck7 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			reg_vsnvs: vsnvs {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7		0x19
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x190
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d0
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d0
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d0
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d0
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d0
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d0
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d0
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x194
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d4
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d4
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d4
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d4
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d4
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d4
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d4
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d4
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d4
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x196
-			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d6
-			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d6
-			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d6
-			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d6
-			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d6
-			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d6
-			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d6
-			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d6
-			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
-			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
-		>;
-	};
-};
-
-/* eMMC */
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0e885f97e63..936d550588f 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -114,6 +114,7 @@ config TARGET_IMX8MM_ICORE_MX8MM
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 	help
 	  i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM.
 
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index eca9bf63376..2db503652ee 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-icore-mx8mm-ctouch2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-icore-mx8mm-ctouch2"
 CONFIG_TARGET_IMX8MM_ICORE_MX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 29114486cba..7650d7b734d 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-icore-mx8mm-edimm2.2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-icore-mx8mm-edimm2.2"
 CONFIG_TARGET_IMX8MM_ICORE_MX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y

-- 
2.51.0

