Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F56F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5EA842A4;
	Tue, 21 Apr 2026 14:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hjygiqNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CEF839D5; Tue, 21 Apr 2026 14:26:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C408C842FD
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNsRKRTMjB/upo03l30kipV6wF0xxOQaghD02c/nJpzJi/Zc6YYwZeCSG38BzGYYQlhfEStNCHFjSTy9ALwfQVWBGEdKz+i9g0C2cVDSzWC+cqWpeFY7Wf07sNWrurGymj7gyhOhc89oyIPrJuiW9wf9Bwjr86Gjba8xIL7MKepk/jAZFT//nxCQjAZZJNQy9DzEGn7Vvl+3wdiM81soASW3F2XmXoUFhw7QsM7MvnVB9xrboCQ0RoJoTz82eCmH/k7uE9aNXBYKYrpUXiK2QW+J3hvvo68GqktNUaRglSkh3wHmHU0Gl63Q+mut55bNOkctu1ACIdaHeUcbv1R/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI8Z2trDTf1oSYtRILlHh9VGM7yyUbj5F6Q2i0f1TBA=;
 b=SMVd1ZDTPCZeiVg4zhSBlx0yA2P/DCDoxCgPC6X12IO5hzdrpovSj9C95YuRN9mC1yWFOEgoFi3CkIqVfWk7+/YJKAcvjHPOmEv8WsQGZVTDMSM5iZlSyCqmXtEZM9k6n30/IfbxMFsSQNuh5Yx2id7ljVtgD5i4Kcs1ivHzC4qtPUGU5/YOApuCSLLJ3sT8sXJPURKf3WfcZDjQPo5vUa4qV2t+7uYNCRYsEr9IZ6wZJvS7dIHnkcLpr4JpOjHmeikIDxch0yHBA8ynXdZTRHjhyyvQSfgct5d4AYsKI/Fp7uGUlB8utmniwq5yoJN+SGjF+jPdFp/LgpbSM8uQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI8Z2trDTf1oSYtRILlHh9VGM7yyUbj5F6Q2i0f1TBA=;
 b=hjygiqNWQ3uC0nH+HYgEI2lAMUBZolk68lND/03nLwqUyzGM0OFTewAY+IoII8H91SvW0kbqZGN28D6kmQjhXK6AN0HQn+vBy0u+8tpFfm7rySke9A64rW3qSAY6YhE6Qet78z7HXr57leLO200Da6bhB6WSnGrrao3L8SAV6k2OHWxSyDXgK3qr6XgvtaGf3f476+zEP5r6TGARzd1s6iTTseu7UnJcBp2YhCUb5XJ9//Gz4ioZh2BKeTjybTQ0b6LyENIer77p6npr+bR55OBxthD5x1Hrcwg710ZusN3/4fOYhV//IPJRui8OC4YaNXBzKfs5+UfzSV5npxuP2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:26:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:26:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:23 +0800
Subject: [PATCH 11/15] imx8mq: phanbell: Drop SPL_POWER_LEGACY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-11-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc74b9b-dda4-40ad-961f-08de9fa127c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qBqo/tyYLtLXXyVJSlTIXgdsgTDPU0cIaaIixnrJ6E/+UQFPeymYkNa5ZNB5Vdkru3RrD6pdla3ih2pJrgspE5pSvCEqy9kaNY27B/R23q29bN+gtQukapqcRNETqjbxhn9fyfDf+5KTYqzbp0HxjCnbP8MR8zDRkTAez2Z4+V+POW7JqlkZjW1Vd1GKr8EiWLJihE+u5VESqXWtVavLMF2jMnKOgSFnHNPNxbCNJMLepzf5A6wSryWoiV0i5Ca3pr3DNMnMpct05BQWb/TB8gmKB0zkohF1nqA32TzVv9pr2U2qRcNBKFNSli8aBedmZrgbJ/6Yn5SUOLhfDxGcPVKa8qucfHfqVhLH64X/4WpOe5Ai4rl8XT/L3jsDstWvGm/RpcrI/DbAbfLkWwejOWS1m0fA3YB1E50GVt1IFSGzxOwbHoWhOLBVLmumP45olswY3/7IKhhvifS1dCH/eGTmZ0gBQa9I9XV4XwqKJKRRFsnLy1ZZ6X2xvPNwhw7oBIpiuFXejqb/oaK5rjbtIu0V0uzn9x4Ihu/GYB5l4Y8I5ZZq8x2blbxVMLnZZyp7hpGzBvHy0xqwNAx9onwlo/dgFN0x3TdNtjuObQfhte0axljqU0o0eK0eTCWVVmXKvm/Cy6g2xQ3rfR0zRRfWIyNjjGfQcLPe0hOrmuTy0mlTt7lSGJ2YmPwPWD/ZWBmMhirbeot/Xm1cVm4h5xv8eHrSmDA4YdwScBcte9xIhpjQuw+wh5JCpihq7X4765HsjbuS/Z2LHzNEg64BCeO8kBnvnXzzMuOhfSvSfcGRUec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHBqTGdkclhXK2FrZ3g0TGFmN1pLN0JKak9HWEJyLzBhNzh0WTdLZWlDcUp1?=
 =?utf-8?B?ZENFeEVEZ3JnQXZsdWcwaHpJenMrL3BTZjlUY0Ezb0ZDZWZ4amIwSE1ZME92?=
 =?utf-8?B?ZSt6Nm9saVVPUVBKVEJ6SGZuSlc5VUQ4a2VUU2s2VGxKK0EvOGxTSUtrSDRX?=
 =?utf-8?B?Z0J3b1dvSVNFUEZ3REFvT2trMndGNW9sTDFLaUFFa0pVTUt0eENDa0dMNXpJ?=
 =?utf-8?B?TE9aUVJEM1ZLS2pDVGRZWUw1RmdXTWpvZnZ1ZHkraklpRVdyTVRVWjZld2s1?=
 =?utf-8?B?ZzR6M1JXREFlQmMxZllreStKY3RKWW5WYTNudi9Hd0U3QTFYM1BzbzVKcnZH?=
 =?utf-8?B?cUtFd2tvdHNWQUY2NldnSW5GWms5djcwWDVjaFRQckJYb2dRUFdSZlNVQVZn?=
 =?utf-8?B?ZHdlV2hKTGkwY0wwQlBqMnBZb2VNWlMrcDh2UWtLMWVQK1YyYnJlRjNMc0Jy?=
 =?utf-8?B?TUNGZU5lQkRkdWZpNm9qTHBnakN3dFAwaEQzQm03bm9ueG5EQWI0cW5xd2do?=
 =?utf-8?B?MSt3OEg1UjVkSFQ2NkQ2Q0NPVHJTVWVrREx0bEFWTDBYL3ova1NKNlhrVGwv?=
 =?utf-8?B?ZDV2SWpzVVRqeDFlZDdQUHVNdit6Z1k2dTlvL2R0bHl0WUVYL0prNjJBN00w?=
 =?utf-8?B?ZkxXTTcxV2FUR2RqRytrbFNXMWpOdzkzcmRmbGNhQXp5UENqeXkzaHFqT202?=
 =?utf-8?B?Ti9UTGlOdXdZUGMzY3JSaldVOWxDZ3R5ZzNKZCszUThBRWRUWWhYYlRubnF2?=
 =?utf-8?B?eWI0cVVsZWF3QkxnVml1M3lVS01NbFFtY3l2TU9Idm9LZWQ1c2R3WCtuc1BG?=
 =?utf-8?B?V2xMZFFuSWlkQzZFUEVvVkhQK3gwbDYrR1hpMFVTbHVnaVVEWlllS0xMbFZG?=
 =?utf-8?B?UGFPaEpEVGcybmo3Rkw0SXNINk5RQ2tjVVRaTE16bjlQZzROUm5wZ0xVcDVB?=
 =?utf-8?B?YitGeUVZSDc4bWdacTZaalhwYTJUdU1DSVJpZjcxK215dUM5cElqektscm5z?=
 =?utf-8?B?UHpxZXNpNkU4MUZsUW8xTEJmY1R1SkhpT29IM2xQNWhpTjJkdVQwN0ZyTTQ0?=
 =?utf-8?B?dkhaMGkxVVlDVk1MR3RFUXJJSTczOGRhQXdDZkk1VzZMYTNDN1AwRkxqRUgw?=
 =?utf-8?B?clJZelVWUm12VlpSYmp3Ymd5WHk1QTBzS3ZoYVJtTk5jZVJCUmpYQnA2OTI4?=
 =?utf-8?B?VjJsMkVZNTFUamYwTWJRMW9CaUpSdm1uZlRybzhyTUxhYmtNemhLY0xBUDRZ?=
 =?utf-8?B?Y2h0QUFRSGpkUHZINm42TWtHN1dBRWVCdGtIVStrS20ydFRuK0JYa0IrSFpl?=
 =?utf-8?B?STRoS2IzdzQ2NDE5YmJZNmR5Yi9lclBnS3BhNG1XYWJ5QmxCcXlFWlIwL29H?=
 =?utf-8?B?S1JCQ0xMZ3cyaHVqVU55REdFeFhYOG5CU2xtWndGS091WDlGK1FuUUtjZFRL?=
 =?utf-8?B?YzZSVUJrWjJzZE9wblAxeGNZdE9POS9Mek9kbzdJSG1JdWhUbnRublMxZFN4?=
 =?utf-8?B?aUZqUldIRXcyQWdmYkt3b1lPRXdqZ1NwTWVTOWhvTkszakQ5OVM1RWNsbHl5?=
 =?utf-8?B?T1BMTTA3NjhNTm4yWUFoaXBoMDFDRmJ4dFAvLzAxeTdvZjhTVGlOT0k5aEQv?=
 =?utf-8?B?TGFuVGU2S05JQzZYdkFkRzBUeUlld0t4Y05CbE5WNk9UZVhzSnNhTU5mL042?=
 =?utf-8?B?L05QVVVLNGFvZ0ZuVzlXcHBab3hraW15TEpLdjJxRTFaeEVsU0RreGxmb3R2?=
 =?utf-8?B?T3FKTXJGTG9SZXFkekNHSHkyZ0RyRVMzM21aQmF2QXlESWE1MXFJb25rUlNa?=
 =?utf-8?B?Q01jVDUyRGN1c1FVNFlnUmw3dVNKeTEwS28rdzNTVUh5ZUZrOEl1V2xES0Rt?=
 =?utf-8?B?OHY2RGFQRmpkdzdlT1NrSndJeFVXYnlXb3lMK0QvdW9rZnBUaGxnRDd3KzBN?=
 =?utf-8?B?MHo3cnNWUnBJK0VhdVNsbGJHYjdndXRIenNmTlZFNmhrVW5USUMwWGtHMmdy?=
 =?utf-8?B?L3lhYWkrM2kyUk1GQ1p1SERVZ0lWMXNaYlRmUEZ4SFNBWHdXeEhQNURiVE1Y?=
 =?utf-8?B?cWh4WGJpZEE2TDBjSVh2YnNNSng1Zk1jVDRTQndPcExCa3N3MjVsOWJLdlhX?=
 =?utf-8?B?bjlKQ2QyNEt6eXV6MXBEQ1RuSjJLOWVWcE4wWFp3TjZUbVp2Z3c2djlYYmVD?=
 =?utf-8?B?aFFjRjlYOERKbFliQlZHT1VTOERTOVU3WmVpZHl6ZmJNWXdmaUtCRmtmOHM2?=
 =?utf-8?B?RkxuNDl4cjlPWVp4dkFlU0YyWk0xeHZ6c3JxSVVpUzhqRnljbHBBR2hjREdG?=
 =?utf-8?B?U21NeHc0TFpBTGVQRHc4SUk1WXEyaEpEenV6OWNqbFhHUE1pUWovdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc74b9b-dda4-40ad-961f-08de9fa127c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:26:04.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjcK7Nh/LOhg4svmrjxT697zHpsxkQEpwNIQmGsXMAVjaOd7Qh5kHUoiHGwH+uV4AC2jzjbhfuXWwFMnxmwP3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

This board does not have any code to call legacy power API, so drop the
selection of CONFIG_SPL_POWER_LEGACY.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mq_phanbell_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 6f93fa89990..4c95363ad07 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -85,7 +85,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y

-- 
2.51.0

