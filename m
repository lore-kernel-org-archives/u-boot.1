Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21522CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECCE68353A;
	Tue, 16 Sep 2025 11:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WF1UPmvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B688354B; Tue, 16 Sep 2025 11:45:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B794783537
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZtSkoKH5GvwAWmplBjpAvw2ggNOq4b7RXTE1W3iIUXhV09+/Cw6/Lh+ua+op6v/qwdtGuxT7pCkXl7B1g1aYW/01U/0kHX/lgHqaD/Nnj90K9OK9rtWQC4cNJaWsYEN9HjujaszNQhnsssMIfyP31qFDUgfr4oYXQQwZyB8XdV0z9zGjyyINltlO0AY33aXYS1cX1+Bzxz/AIX324Z+u50BqaN6YAlWRbaQ8xS+qmvKJNwNDU046gaEFx7f8WwGIf33BdWO8OZf+2puGPMKpKTGi4fk48ojTVzDCdsUMVXeoz+hDmW76aPXr191qi5S+bQd8QfNUTaIlOooOWqeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb8VNqCMKOBPZzCVszWCtjNIc9mYUVkEozNdlSMB+3k=;
 b=Bs9aYdU788YvAyTGTOaYXLm9NTnmhweWKLvg0ZcRVblG+t1+V01ixCzhgW89EYDv+jcmlCJR6S37xUgGj6Tp5R3uz2CvSixWrEc/sWAR3qEAsVA0ahz/xAdBQR1o0VqbLNKFKQTfm/z6Q/Vc2MRvJMlkx+oVgO8ERY0xZxXc/OBXo//EY/nsEV38k9FK3L1r/ec5logIKd5TmX9xsMLcoCQcXTTOhzxoK2AMZK9TM5sHuqW3xa6+vrBcu2TusjEQioAiOvmBc02xOtRIoi4ySes1H53ZGR/qE5NE+BwXbFoBz56Z/05JFUw0bwhMWudhDHsxvFhrC9znZrsNNmOYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb8VNqCMKOBPZzCVszWCtjNIc9mYUVkEozNdlSMB+3k=;
 b=WF1UPmvyh6XmP5yx3OJ6PtytlP14Ax4SNC6Qc5GbZXh+AcKDPKCn/KilPUXD31OKlGcYqlb2gplQQIy14Wzj3V252kb/aj7MtR68C1BVFcVK0jmC4FL94FoUavPeQQIT/fOy1EDjIj963+yaUTPy1IeNyRDpe2FJVSDmsdZSVGLx6htFP/tU6XycVgb0F3iLLKDLTuvdIpmR1pxfPQjAxB4vS+RtC8yP8vB0bgVCzfcNMxBiMLjPuWsHPDtYyxkd+Fn6luRyiDR9ARD42ly9ks85klkC/bApc6XQgtt2ZOHyygabTWl9NaD97LBHVwJtL6Wl+C0sUE/W3SHQGD6LOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 07/12] pinctrl: nxp: Add i.MX94 daisy register offset
Date: Sun,  7 Sep 2025 04:37:37 +0800
Message-ID: <20250906203743.3352805-8-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a805e1-a8d5-4ee4-8c78-08ddf505cd06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRAsyTHeiN2oC9J328WIc7ad8vsMqZb2UZ1R6tvbI0CPgaBl9Ux2MTdux9pb?=
 =?us-ascii?Q?HRG4TmvQE+0kfE8AlHfS7an6G+Ppa9gRbps1uEA03iPggayD4gjDPzjDnA/d?=
 =?us-ascii?Q?Hx1gqLIiFVr6E1cNfeRDa1mQK4rAuqAKO8STKE+4XkBzIoRe0tUJKHOU0W2k?=
 =?us-ascii?Q?E0PJ26FG3ra5pGR9W66drswK0BXsiOdpw7B6ovEauiv+N/RCNJnjj1PAJ7x4?=
 =?us-ascii?Q?MMz0MlZhPV3UlDQfGbYmqbWwxsyyjLiGNK0nNGnAQFicjbKFNQ6YeB44OT5J?=
 =?us-ascii?Q?ufnuWba7h8p9pqw1LYX1VU4S5ygFfLbecC7oIayO3vrGafVHAXqZY5/zN/tE?=
 =?us-ascii?Q?KyIHp/fuobzV7euNw5Y31ddHPkpfBCik/YJyaw7Mcwid17ynMaA3H773S1rW?=
 =?us-ascii?Q?tbMUvVj4fzmxxmTMBhDRkPMfeqF96Knrp7CHg+1fEFtFS6FaXjxxMwrGxOdE?=
 =?us-ascii?Q?IOScFo6CQUg7J483BjtunELnah1AxL+KMjgeEJzvLp8+fJrblyHwnRvOr3sS?=
 =?us-ascii?Q?4OHTf76+YGsNUdTsfOpZi5G7HPsTRufYnHuOCNHEHxCQHHK+KvfPbN9FRtCi?=
 =?us-ascii?Q?CVtsgYohhuUjmsrk6vmetsoXutxasyvq7dBKCNVkEiH6R5HZos7pIdZ6Q0DR?=
 =?us-ascii?Q?N3LDN5v4wiAyURLSuJKL6kfR5JcSH4swMVQ4NO6Ya06K1fOHM+d25vLLibiK?=
 =?us-ascii?Q?X2hZpVxh7b5OEWSZLszBrFVWK7KBDGqQDVAdKvCZkaoVn6LYp/OS9GI+5Akl?=
 =?us-ascii?Q?/9xU8ZNOcQwZuKSAJeUJCz+PnCJy3FFqGOQavhSENTgsizox6B60KHS0R59j?=
 =?us-ascii?Q?tFRZAItuJiiENpC8kTfVNmQfYp16VAzMqc9CtYYod4gjw88YtnrE3Ua38Oj0?=
 =?us-ascii?Q?WwrpmQP1+m8zB6vofL4S34YIpehZOBs+cL/dtJTH5rXzvNgFGSi8Xk9lbIRa?=
 =?us-ascii?Q?Smb+cTJfZADAZO4h4Q5bbEqOXX3E2Jr5YW5xAq7lPzatQyfh8TJ80vmBfpvS?=
 =?us-ascii?Q?jhEMwMoOinrEy52pI5lNfLO3F+EhCAPY9hkQW1XnW4Y0Wn6XCl2YX+KtaCQR?=
 =?us-ascii?Q?Wa5Iq8qpqJ7vyTBL3qFYCdF65PfBK4smNn2peqRDKI+APZvx+KUQ/9c+QyYa?=
 =?us-ascii?Q?GyM8nMZOaioI3hFdz9W80/IZrJmflh6rNUV/Dp1P29qHh8EQCGytLZvINfwn?=
 =?us-ascii?Q?Z3um3167/auct8gYwPkpDEbJHGlTvf/MZzLYQG+faZhNXv54MBKO389BhdCR?=
 =?us-ascii?Q?bIm8AkS7xLmUwCotIFNGBFBXYoZ+aGDMGmD44MM7TSr6akGPu1k0m1783VAl?=
 =?us-ascii?Q?4seAaTgTou0Vi5d4imiZhgrviLfIpIyijBAp3pQk5reUJE73HFISBUD6qilY?=
 =?us-ascii?Q?cNQouLFdkT+vtG+oELD4guldO5x6blukXptyGpHyy8NyFBNGUhMWxMCRdUgp?=
 =?us-ascii?Q?luO7TZSQiFQvsA3l8RrIwIA5nnStPZ6tIxKIY6CJWVe0EPWP5Cd5Vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JY1J18gO3x3rmwVc1tMAmX0887mhvv/YWS84evV+hXf2LcX/ycjeiyD+l7nn?=
 =?us-ascii?Q?8Nh8fruwZlNXgSozcQERr5UJggRdz9dFTBfr/8FkKg0mkuLl3//5KOu+u1uq?=
 =?us-ascii?Q?RKVKrOOA9D30XKZHBeNR3N1YOTPcS6ckmgn97L9r1RDSbldYiCOVnTSzQRa4?=
 =?us-ascii?Q?Ai9tZkbCYEPSOBlBlx5tPHC7Bbetsb0PazPX7QNfAbgqznDsr2yCILd76Z+Q?=
 =?us-ascii?Q?ljCYo2jJL7S0sitEbIXj7eo1JS3ViT03h04fVJLYiu0AT8CjLHGpPVqRiFyX?=
 =?us-ascii?Q?2m6V9GS9TpbOm9KQ/jebP/x6u8VrTFhFliDWR+AXNas3174lB+aq0b4Hxqb+?=
 =?us-ascii?Q?CFa/iZ1zNkeCIUYsqDhxwLaTIDDaxe/mWGaoSMnIR6HYHMJuUChLzdJJAO8X?=
 =?us-ascii?Q?48tBupmJKafMgDDvUrdkJylkkcxQhe/uN66QyWgvs6h1x1ppv4qC8sH/yBxw?=
 =?us-ascii?Q?GfNQgUpAUwupVsLBVosduVGjgONLrXLvnmFyPsFjrJs3y3dHehN6LdEVn5fQ?=
 =?us-ascii?Q?nUMQ1qR+bX6vF/qLXIUffmbr0JPYcejruQk8gxsRkUc8+uvgAwawCenSDMR2?=
 =?us-ascii?Q?OP599/3DVR7Doub5UpCqflSUlzCYF8ZwBQnaBFIhQfqcvEXr22Kk1QyXCAw5?=
 =?us-ascii?Q?/muCTisRRNaoywGGuvuZPUMFduX2sas4581Fz4mmZroOee24L3RrbccwC1Ga?=
 =?us-ascii?Q?fXwHngLM5PK3zy67eUa1T+mkoeMmAaZSQMQqneYx+h6UuX8XRhe+agbcpfyW?=
 =?us-ascii?Q?GlaBMDHfvmazcG9OQdNuDVk9StGwGybGtxk5Kv26nDWJk+SUNin9iUEYm67q?=
 =?us-ascii?Q?U0P8FFuIIzy0XhoAM1mM78YQql/szp02PcECH6b3OcBY9aBswOqaOhwj5H4I?=
 =?us-ascii?Q?uWzwNDZV8gqH3LKGiBmAEDaFU+svNdOaV2BFAbrAsSSlF+7NPXRbgLz046yR?=
 =?us-ascii?Q?E34ya5f/lDR+ja7MWvYNweuMXVtpFY+RvE4zMqd/AqIaC8kUBYq/u1SmVOiC?=
 =?us-ascii?Q?wJPwoL8G9oY6ImFFG89uSKIurr3S1z9/FYptHvZwR9+/nqNP1IQwUS6+L+sX?=
 =?us-ascii?Q?2eVlOfjUZBi++V9dQcffShMk8GD9illlY40jgtNH7cdC+ZIwhfeRU2LYSeh6?=
 =?us-ascii?Q?CSQJdOetbvBihnG6acT6Ytl/FmP6PVDTs6HpvG8h0aEvnZOoifcX0BPLE1xa?=
 =?us-ascii?Q?J7qChUfGaauOf4v2E/YYrqqtHnX3PvSx9JMyFoj2/fKOTdHNKVs0fO7px8as?=
 =?us-ascii?Q?alhxic6dZM73PDJaiOCzo9av69vYuEmfGcgsDMwEwgcrN7cj7KhfpctvMKcv?=
 =?us-ascii?Q?KYnnjPP3NTjPBxkk07N70YzCRCvRUj8BpAEbwoDWIzXvr1nLWpT803/5V9Zz?=
 =?us-ascii?Q?CWjufsN/MsduSzVIn3F9kFIclleumKgIENxeWTBMToMkzcHZYqd4nWKinOZE?=
 =?us-ascii?Q?pG4sGmKPhLYgXys1P+1x3y5Kh8TekBSoH4H9PmD+gQ96xfUMZm+ypRaTcHDh?=
 =?us-ascii?Q?61uWWRbzaZm37Q5zKozZ6ooD2KljDaOCW44GBGrMjxLVO8TZN3xwjflm7lEW?=
 =?us-ascii?Q?508ZbNFBRbsRWje7PPYVOZjGw6+xdSaRI0fHuqO9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a805e1-a8d5-4ee4-8c78-08ddf505cd06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:42.3810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwmCrtTboONbOvoKM2koLUObpLt65h6Pj4abPl6+bJoh92sFtFST5U+hsvZjeJY/O2Mw71a3xFEIF/XwcIrXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

From: Alice Guo <alice.guo@nxp.com>

Define the daisy register offset for i.MX94 at 0x608 within the iomuxc
register space. This enables correct pad selection for daisy chain
configuration on i.MX94 platforms.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index aed47be337d..781835c6852 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -16,6 +16,7 @@
 #include "pinctrl-imx.h"
 
 #define DAISY_OFFSET_IMX95      0x408
+#define DAISY_OFFSET_IMX94      0x608
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -133,6 +134,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_IMX95))
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else if (IS_ENABLED(CONFIG_IMX94))
+		priv->daisy_offset = DAISY_OFFSET_IMX94;
 	else
 		return -EINVAL;
 
@@ -141,7 +144,7 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
 		return 0;
 
 	return -ENODEV;
-- 
2.43.0

