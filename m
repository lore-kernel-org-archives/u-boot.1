Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048D5E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79B98422D;
	Wed, 24 Dec 2025 09:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="426jKxtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF4E84227; Wed, 24 Dec 2025 09:24:54 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF64084212
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHSczp2GAq5WMp77t1M1ff893jy1rGQYmN2UAkT8mQEgndVhzf955Phorswzi7uVNmCloZwI4uzdOOuUR19gnL2BQ9QhFYiRLt2ZGTURIx1AxGzOE3tNX1RNfLTHr2Nr8ZoGj+L2r6EnGLaEPWKGfeEnjBy0wYmE2l7J3xDQm0cqAN2O0mHPPRu6WCkvOa8XkvlTs3R7niPzg/r3Z4avs/cbu319WsXsMD9OtBOm7e6ekL/BConFk+DHqKZR3J91NO8LQUlQ++fIU469JjKyxbkAJlQMw1uC//7M5v3qoBH3vaxq7696OBngaIODXYMWUQ/FlV90ZP43a27+68F1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=GW5L42sH5UVPAIOd/QlX6uNei6CvYnPaL0X446ESRkO3jROECYAEYi7UbG87+IiHVPwuIeg4aXh12BXtNisAO8j3R80pGr0PLG/eqgPNnCSsdhihUQYho+jWiNxLXMYw8TCMHVkC/xg8qBpBnY/msYZQgpHO9uek7mkkYL6Uh312jQy7CY0vh7DSszZm1gQsjhHb22Da8ygu8+UwH0oJWDmb68ko0qOTrlRG83hMLIIruEVTjAE808pTS4deKkD1C5ISXhhlyqQYh6JzP1gBh7/R4yB4+56fgAcivVjHHhz9Ill8Fs9bSjaLRciDVyvckJr15RbZZsU/k80M9XPL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=426jKxtxTW4wIe/shCEi5SnRV0CeqJlou4fLKWo9Jbwv21OaJ5dLTP/Yt0Ea1pX9gZPM3mjEynEuoFHryTDXSWFx0Db9fA/+wK3D1fIF8lwhedoQxh4HeAHZuh+JbJSRqPUxn0ajim/p3kXG5tg+j+qLzJyDpip0kcMy+nR382s8mvfu/X07Y5qo/QWSQOFOZ86BSIrksonNjScWmYVqwrJCqysgRPlgW7QiMePkhcp+7cCAtqyigLvIwgyS0F8+9qGJtW0Yyl/tAkUb41ofDKeUJ8whDHBGqJw5E517RwbfyJYrAIYDxZ/rmpmVAzujaMozffPTbpg7S53qF+/gmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 10/19] net: airoha-pcs: an7581: sync with linux code a
 bit
Date: Wed, 24 Dec 2025 11:24:00 +0300
Message-ID: <20251224082409.1347373-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: b0493595-51e2-4f97-843d-08de42c5e824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ezfrVQqGFbKJCpOMT1xNG3Odz6JZsWxV493g06bY0G5e8Q/f2ivaPdBMrZb+?=
 =?us-ascii?Q?W45cJLh1wjRrT6u4tm/QQ+1BRsnXplEMCMjkJgEKH/tseh83uzH+Saskns14?=
 =?us-ascii?Q?YhHG5jhkNa0+kby8j8T+5qa8h2glhINhuirw3uh/ZJwslqRj/OCxURYjSKW+?=
 =?us-ascii?Q?DqnBS9RHnc+VubU3fFW39ylKlWCOujGezaSX1dqCbCBOvLWelq48gAeWOKqY?=
 =?us-ascii?Q?41J9zHwxq9/fXhZAd85w3Mf2mzA0Z6QeN/ROuQeuy+IyiBMpTdbWc5yoHZjd?=
 =?us-ascii?Q?NgzPL5a9RqcJ0pBgY4QbIr3bYbHEN8LHtRYLg3ohlWlYBXqomauqsPwapwf9?=
 =?us-ascii?Q?VIstfYXxA4zc6FUZJqquNwCxYG+GRJFXZ/SL9kCOvLN1FipFO7xAABXD/O3U?=
 =?us-ascii?Q?1tp1aHl/H1w/WdKI7PWitla+FIZipSmVP1uHgnwwLqVYsz/QbzjYbOwCrERw?=
 =?us-ascii?Q?pnAJEZ3+r+pAMyUckDsi04yiiN+CL/Re2h7YL2mTlI4JV0NoSCEaNUjMjAh1?=
 =?us-ascii?Q?jWfA59PjcnduSrbdIS0AEwFa0nUyhX0Xu41OfK07pl/LNgh0DCkV6+c7knpk?=
 =?us-ascii?Q?xCwDuEfNoWO1nfyIbnXk3Ch+BZ7nFWMbHRIo2VMkik91aIC7Wc6YuUZhsIdc?=
 =?us-ascii?Q?Ml0aMM5iOgixBXSm1KtiTeUDGHMXMVHe3GPvEfoGwMdzSj3jMfg6ehYf6apF?=
 =?us-ascii?Q?ADWomoB8tSFhCD+pjP3Yk1alpw7rAA85Vr92N5a6nZCFtwDiL/qBJDr2NgcH?=
 =?us-ascii?Q?NQxpsuCKn9Pxp/+5KQGZCxSNmITlZupDcCYn0b3qqcA8M5oUQbDYx7HWLJW/?=
 =?us-ascii?Q?2po18aDpS0SWA3O+juAlp0vLu2MH4kj2rT+YPz5mnm7a1SM0VANznoU5UxN2?=
 =?us-ascii?Q?D91fmbSE6tnwvLAmsid7YqTvGnt+ugO7FGLxVQQZecBcZuRJ5+G/9x6RoAoC?=
 =?us-ascii?Q?KQX55xbFFng/3Vsn9ypKYO0UkzGRvvOAAqSrEO9aqetqmbMOY4Q8N+fMF/rq?=
 =?us-ascii?Q?9wLgQ6YzXlwv6YGrS6tEyR5wAZdjvHYp6s7cw0ffj67axLMXMTjk6ld1pepy?=
 =?us-ascii?Q?1nMhPbaHfqhksWKp1wP4HReYR2LEGcjHCfA9/pB2GMj60yvlwo1LuuECD1ly?=
 =?us-ascii?Q?9Vn5dGo0OBAV7ynbPAqtdirbIiuHobpz1kCzo9rgBPZgRPfQEHzPi1GolN5j?=
 =?us-ascii?Q?5ITQWhUnkEWATr18xHnquHXc7mMexoHDD1ogKZMV7cYFYjwKR2MvCJaa1Mx+?=
 =?us-ascii?Q?IQOo4+7zGXm0j0+ihiSUBias4qwyBgvN9hDsA4W7FpF1Tq5pdUe7oYCgPqsF?=
 =?us-ascii?Q?jgBznEkfMevtsqjAxCe0O0qjobBmbzQW+rYg81VHDbKaqeuwYO64vPeIFTXX?=
 =?us-ascii?Q?MEwfOwiCnkbUwHYoSzXetz7ZJwzW4kFKJk+g+4y1xwP20uzci0Ch+Mg9M+yJ?=
 =?us-ascii?Q?UjSJLRzDEKASNdszS/BcoTcE7l90Acrg85s/kBxdTbwUmnrr4YFcmj9H53dZ?=
 =?us-ascii?Q?pm9osV8NptTO+7zoLShi2zKcHhAGn1Hk88eFFgKYSZnInI3C+2OI/VE+7A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyTyGiDMkRxuezNdi9TkEFQub/uTsTc9IPvLXMZC9AKRzwhchDtpCOuKPaIZ?=
 =?us-ascii?Q?kgtgvEa+qf5uJDA7UfJTjKHEOg4Pa3rp/haAPZIgAmDJoGNby+2oX4pACsqQ?=
 =?us-ascii?Q?GuRw3GhUa9G9Q73rjCVZ1rFCl4OO43U4e5P/JQaZuI+VgFOFNlNdQQwNB5Ro?=
 =?us-ascii?Q?OjeeM7VjXt3yvD8G/Yw11Uu5ZNWKx9Htp67HE/h/ec5Apu3lcKYxFKl/IiH/?=
 =?us-ascii?Q?zVm52xA8o0Fg4VM5Q4y1BUo94lk/HJbYp+AES8Ob4Kymx3VxnjTQ6T1sBT2q?=
 =?us-ascii?Q?bmDX3IT99aWL9VJhrmyci5rfjgd3yM6pu/0aVFVimz8jzytn4P8xDPJWjc7I?=
 =?us-ascii?Q?yIvxttGxM1/85Gz7F232I89iJemQtOa9ODzOp9PGfUbhA6ce37Rzl/h9Uubz?=
 =?us-ascii?Q?yWWMMYaKebma/ATgOZ+Pj5Yqebknrkx3crTcYX1tMM2uIND5MKkIgMk5TyWf?=
 =?us-ascii?Q?llJMpQsHGwi1TDAwDR2w1kTD4+Zk/3qb/bk+0rJGnAagOezo1xnuSOxwzwoc?=
 =?us-ascii?Q?3nJVeVZW+AJtBNiCJ/xfcv/2SRIOgSxyzmEn6xMvs5lOy5uEWS2UQ1X4MAau?=
 =?us-ascii?Q?klesYalLvZLuSTW3OPJgyNemprG/12/6ESXHTWPowqJVXbPS8Yem7gHtogQS?=
 =?us-ascii?Q?xc2gW6Aiw1b210Kr4Z0MqHVZSIdy6ThR/BkzYgRHiHlhiwBEbtFVFkXw/94d?=
 =?us-ascii?Q?1sixjhoVG7NlKP/JA45eldfj6xiUaTvAb1a3s1TupAzCVGPk3r6eNWqXOhMc?=
 =?us-ascii?Q?5BlayO/quFuXrF2Ifd7r7HfX+zWTGfCQWNzd7Vov0HOOxiFDYmPLEZgmKgbc?=
 =?us-ascii?Q?KE6VVB1BnZYSB7NzeJFjOTTsbmNJemwHGvcB0OupMmZcRPSNPLm4sPnv9ao3?=
 =?us-ascii?Q?E+otAhrdygwEL6iZpgBaemeSDrNiN/720XmaAnMjo51x0n2HRIsoO8DjuOQg?=
 =?us-ascii?Q?JqHRnh7ZSEDxdKyNsDvmeCzALIvNecna7na1nanIi4faVha/4+XrKkkyouWa?=
 =?us-ascii?Q?Az5afiW1W5j3c/GNiX8vxRueRfSRgTfbAr9kCWh3aWGKXeXrnLLM40daNmrB?=
 =?us-ascii?Q?aCQeqJAjrwWB27BeIomX41UzAeoffZsriYWmsH5zi1JCqMCQ5lDpjVSqgM20?=
 =?us-ascii?Q?BMsfS/JX8kb34lsdAiVgonbA86+Q7wqD6bmy8oQ9Zqbr3QRB8fHOkWh5bcFr?=
 =?us-ascii?Q?B83lgRPdr/m514liMtqP2Sopiprh7EYdtYYOhcScqKo21NVWIn7ApO7CH84e?=
 =?us-ascii?Q?ZsZpFuTP7g0CxMMzv98mBIKnX0kYYhV951EvXQNknuOA9F5D+TvW+/tdrTRL?=
 =?us-ascii?Q?NxFxVlloHC1PHiDkFjWRFgt/oocjc65SXoFyick7AaYToB8vsWkfJTdsFcVb?=
 =?us-ascii?Q?mQ1f0RWK+UM+9ORsAn6otSuLlY2/R8DHGdVkFnB4CZtmipGWL5lBkamdeKcw?=
 =?us-ascii?Q?puP4FtDHnaeeagUuyNEuQqvQW2Au/3BzOWyacR31MFg58xMpEqXaOSU9JI4T?=
 =?us-ascii?Q?yWzE5kZReB+kaEabSz22fODBw5vTbpPzYOoakf8ZtC5pwuvbwjTFNt7Ow1jU?=
 =?us-ascii?Q?Ne5rNJEltlNfytatishX8Ft1Xk25ShNwgUPkjW7DYreK9yfr+xJvIDh9365O?=
 =?us-ascii?Q?FoMaUwXD6vzOMVJsZYHS78Fg/XzzDfl5PKLspAuXCE32wKhlATh/HlneW7Xv?=
 =?us-ascii?Q?WISqBiXSOVjt/EdCCUqYqV+R5Sj6GiVYAJZKSR47WIaqIqWZcMeI9lTnJ/f2?=
 =?us-ascii?Q?iob9/ZctFW/EH2L8zgY+f0S0nDs2B/E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b0493595-51e2-4f97-843d-08de42c5e824
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:50.5662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai8hCfXm8UGHrQi096dq8JhhRYBtBgntErN+00ScovJAvXPUvqmJvcPyQ5DuAdS4E80xXWtiZwit4vM5kd+waDcrN0VVfD6J/hKAtMYsudM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

based on linux kernel patches from
https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-stable/
created by Christian Marangi <ansuelsmth@gmail.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 16 ++++++++++++++++
 drivers/net/airoha/pcs-airoha.h        |  4 ++++
 drivers/net/airoha/pcs-an7581.c        |  8 +++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 16f0dac2951..1263092fcdd 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -775,6 +775,22 @@ static int airoha_pcs_probe(struct udevice *dev)
 
 	priv->xfi_rst = devm_reset_control_get_optional(dev, "xfi");
 
+	/* For Ethernet PCS, read the AN7581 SoC revision to check if
+	 * manual rx calibration is needed. This is only limited to
+	 * any SoC revision before E2.
+	 */
+	if (device_is_compatible(dev, "airoha,an7581-pcs-eth") &&
+	    priv->data->port_type == AIROHA_PCS_ETH) {
+		u32 val;
+
+		ret = regmap_read(priv->scu, AIROHA_SCU_PDIDR, &val);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(AIROHA_SCU_PRODUCT_ID, val) < 0x2)
+			priv->manual_rx_calib = true;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/airoha/pcs-airoha.h b/drivers/net/airoha/pcs-airoha.h
index f9e325511af..714d2ebe520 100644
--- a/drivers/net/airoha/pcs-airoha.h
+++ b/drivers/net/airoha/pcs-airoha.h
@@ -9,6 +9,8 @@
 #include <reset.h>
 
 /* SCU*/
+#define AIROHA_SCU_PDIDR			0x5c
+#define   AIROHA_SCU_PRODUCT_ID			GENMASK(15, 0)
 #define AIROHA_SCU_WAN_CONF			0x70
 #define   AIROHA_SCU_ETH_MAC_SEL		BIT(24)
 #define   AIROHA_SCU_ETH_MAC_SEL_XFI		FIELD_PREP_CONST(AIROHA_SCU_ETH_MAC_SEL, 0x0)
@@ -1173,6 +1175,8 @@ struct airoha_pcs_priv {
 
 	struct reset_ctl *xfi_rst;
 	struct reset_ctl_bulk rsts;
+
+	bool manual_rx_calib;
 };
 
 struct airoha_pcs_match_data {
diff --git a/drivers/net/airoha/pcs-an7581.c b/drivers/net/airoha/pcs-an7581.c
index a95eb8d54d1..746ff55d72f 100644
--- a/drivers/net/airoha/pcs-an7581.c
+++ b/drivers/net/airoha/pcs-an7581.c
@@ -1261,7 +1261,7 @@ static int an7581_pcs_phya_bringup(struct airoha_pcs_priv *priv,
 	udelay(100);
 
 retry_calibration:
-	an7581_pcs_cdr_reset(priv, interface, true);
+	an7581_pcs_cdr_reset(priv, interface, priv->manual_rx_calib);
 
 	/* Global reset clear */
 	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
@@ -1300,6 +1300,12 @@ retry_calibration:
 
 	an7581_pcs_cdr_reset(priv, interface, false);
 
+	/* Manual RX calibration is required only for SoC before E2
+	 * revision. E2+ SoC autocalibrate RX and only CDR reset is needed.
+	 */
+	if (!priv->manual_rx_calib)
+		return 0;
+
 	/* It was discovered that after a global reset and auto mode gets
 	 * actually enabled, the fl_out from calibration might change and
 	 * might deviates a lot from the expected value it was calibrated for.
-- 
2.51.0

