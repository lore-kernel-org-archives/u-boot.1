Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808E41048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B3B383F20;
	Sat, 28 Feb 2026 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t0T5rYe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C9E83EEF; Sat, 28 Feb 2026 02:43:10 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814E183EEF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrV9w6UPrclB/seHAyriFCcDW6MiN3CeHRBLnjcKDVvskpxpbrvCLP6a6wnhEsy/J3AKqVHcLPwRmqE7qy1+NzThUKD0kQidX0ppOqVFmuyhtwv6L4unSsyXCkLMWxzN0MWuia7/lk3qcxhxRDYmJiMmMTPMzbU5XiixmW3weCHUNXzOdqn9Y++P46NlvnsVBwx7Q13FSWXOSiJW9EWjGcRf0Ut9HqUriLoFI+5G8iZsfYsZGrCyxHtnraIbjS8MothoFNWdgRF7ptbLpSFdLGuGx+5j3JgxDK0iZdOgoxH38so9DK++RLvbSZDMc9TikiPeOlWTuOr9QdCWzyA+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOyinlz+nsccGb8HFUaIJkYePUqPurQn41jBhrJ+a8g=;
 b=nTon4MKniAQRQQQgu06J3rNYaEP08toWoJ27UOfI/bTGTXkSRmmBcR66/cGLGehwUgH8uJJkskuR2fDERAWvT7WSdO6HCHGerZSRDK1EQR1DPaQaHN8WNmrwoJXJAd+KoEA6lxqxqzpPHsnLMp3chBzfHvPbIr3mprIfKR6qfXAD01C5tFRPKXI/p5SfKPOFR1Hdpq0DY5QJpexS4iiRgt8G/e+JIPQRf+SIrnxmkPNDEMllAlMDW8QDtTW9PSK3QD3CG3Isdz9kCGZDEny3KOrDAW6fWw4PcSk7ZK7Os7mQQntyJWSPNC3U8MZ6G/GTA2ujpeoCd6sn0jpGYQsQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOyinlz+nsccGb8HFUaIJkYePUqPurQn41jBhrJ+a8g=;
 b=t0T5rYe8d5qw1TmoWxipBvHDd9k0J/W88kSaHSS7KMbPNDWUWH40pFsuBK2EGLA2Xylplc0qAVITlco69aSHEbnxzeSA+gQcI+hRBsb7edRcR/x9J8MvEYcaxA4QAnn8vsS3gQ64T+lEY4UvDZXYq4cHBwBsgrKW9rupq4MAezGKlBy7Y1ANbLIfEQ8a27JrDhbvYzHaW53k3dIkHnEeqvpjjI2HWg/gJvp+GxoviMJnlSjLyyJQwESDuZFNnxujP0lG8gBFhNU4wJ8X6IPdLR83E7lWKzcYPf9DdmCjXZ4tTWnzIbMFRTWxlbK4gF+Y7ewQBpOIhlvLw9ICJIU0Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:43:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:43:02 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:21 +0800
Subject: [PATCH v2 03/13] pinctrl: nxp: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-3-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d3db28-802c-418a-967c-08de766ab5b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: VY+Hi+3Cqo4uowlZhxdFl/qcrqceRiN6K4fBdMLgOqLYs0tJUWN6WduPPQS5VgrR/Ky4mn70g0aX1J3ioJ0K4ee3imKb4J673Im9xiyYQSqc7i8AqzKqzKySc9w25LhWNSIWcO/ynOEhdiTaoAS0NYOAkXAGRl/bLAOP8ZDZIGNGsAeR33E66/wdCjq3gdjDsUtEc8CJtrLXr2CqwDAwmrj83K0zmxc9wVs2y1Ti2X68rtlK5jwObhchlzNz/7r9hLHJIbQyhYSCzQMtTtap/lSVvs017/F+drOu5uqy120jl95syKqqY2qtyRju6WvvqeUM9EPU+L0csfTDMPoVaYMEdcutFBjeGmB4dZDHrwOQVxmd2AyWAzwsBFqEGVKeN6Yw0Gn4z3Y5RDPfnudkpdSvwRfyA4ANiJhv3u34vLfkPS1L/UQSqzQSn1Dlz3bXhBY3GchsWwtpTL2yYEtv3Eggy04PK1TmrSb+qGT5DoStoVe4QI0plibL4b8CyfHSmGL4WQqN22AkkWpdpx7ED+4JOwzecj7CJxdP6dI89aXrb2SJ8FlqKoxdvVhq794m4PpgKy5AZj8D5nluKdEnWtFbh+7fk0QH0tkJl/wtzLk/Qm8iTcICyvXTwcZOKzrt+iPnItD91jhwvRnVpXgvbtY7O2lgrhVAK4svAT7R+tzcnyBrgL1oMktdoA8eyYxHdrRYIMmVBCh/8faXC3L+c+AEPI5AC755h/aE1RhYi+5cumXSz5OsHshsZCdbbl5Ajmi1TntT/0uJ0MnFaefu9SzLqxRheQO97Wx9SuTsF+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REpDd1BTSndGQi90Q0w0ejlNbXkzRzFMUEorYmNFQjNkZ1BvdXYwMUVJbFpM?=
 =?utf-8?B?T3Z1TkZ2NjA1WG1YNkNBR0kyMlVKU003RlRXc1k1SUtWajdLS2VXdHIxNzdv?=
 =?utf-8?B?TDVqS0N5UnRqRnVaVk8yV1puelh6QTFmZW94cmVoUjBiM3AvSmdRNTFiSTBL?=
 =?utf-8?B?ZTkrNTh2VjNzU1Q5MkxQWGFYYktqVVVuNXpvYjNNcnhuTnB5bWJESDZNTzJ3?=
 =?utf-8?B?TFRzYzRZdjhIMjl1VUlnMndNZ2tlUTd5MlNDbko5MUx6VlhJNEw2c1R4VnJ3?=
 =?utf-8?B?QVErRjFxS1I5dHo2a0dhV1hyVzUyUDBFTC90b2hKaDZ2d2ovczRnY2pxb2J1?=
 =?utf-8?B?MFlSUHJuQUtaczUzOGx1QStwR2hvcWVqYUVKdHRVblIvMEhIQkZCaEU0YS9Q?=
 =?utf-8?B?SW1KMU5FNlpySHRyNm0vLzFjY01vUGxzR1ZrZWxqRTVQd1VaTlE2akMvdkNy?=
 =?utf-8?B?VENKRW9KT1JCT256WmNORWVEb3NpL0d0RDNrUHZ1MFVzNVNVc0FsMHVSL2hV?=
 =?utf-8?B?czEyRlRsZUwxV25vZjhFaVJYbGFCZXZ4eGpRVXU1Tnd0WFRsL1dxVVdWQjNF?=
 =?utf-8?B?Nm14SmVzQXdiS2ZKUTRYTUlhYTB1QUF2TzVYTU1PWmdSalJDb2hxOHlpZ2VW?=
 =?utf-8?B?QmJzbTZEMThzNmRmcnRTdFluMU0xZ3FMSEE3UzdES2MyRFBMblVPcHgrQ2tq?=
 =?utf-8?B?MlgvbXFtTGl2WUdOQ0JCT3hCN2xlWGlwOHNnWHNLYzZjcmJGT0ZUVnFGY3Rx?=
 =?utf-8?B?MXFKdDRwZXEzUURVa3Z1aW1DTjZFbWFDSStnWnZzWTkvaG8wY2VJMGJwSjNU?=
 =?utf-8?B?WmZHSXVCeDdrSzhpZk9BS1M2dlJNbTNiUFQ3eEFzdS9xZktKcCtGNUdTLzlx?=
 =?utf-8?B?T0J1NHo5ank1cDdFaFFUaGsyMlhudU96OEVJSW1sMityMHdNL2tXZ3NuNXIw?=
 =?utf-8?B?VzZZOG1zQ1hvL00vVUU4U01Odkxway9NZVVUdjJIL0diTk80Y21UTEptQ3JJ?=
 =?utf-8?B?NzI4cGxhZ3N1WS81VVZwbUJJckt0R05ZTHAwaTV6cGV1L0RyZTN2NkxMNlFt?=
 =?utf-8?B?NnQ5bmhEcXJjTWdTNHFQT21kQlY5aXdmOE9lMGFjc1V5TXNsNVM2eW9LL0x6?=
 =?utf-8?B?YzdhWWtsd3hhZERTTVJZTXZWWjNSSHBkRGNHelhSTHRVdjlQZkNZQmNRMk9m?=
 =?utf-8?B?emRsdWF3blVNTUtJVGFRRFp4SERrZ2ZSQW0rd3lFL3ZFK3dUK01zRVV3SVNE?=
 =?utf-8?B?R2NKVEFIQy9hSUJWeDNDaTNmS05ZQUc3WDFhclg3STB4SHcrVWdXcDZBd1hH?=
 =?utf-8?B?THEweDhNL3ZHS1VJWUt3RVBFU201eWJUc3pJMDZuaUZYckgvYXpMQW1wYTgx?=
 =?utf-8?B?VVNQb2NrRFRnUDFhQk54WlMxd3ZOaXVTZWlVRlhTU21GS2VRWjNnWnRpajR2?=
 =?utf-8?B?OW1KZXJ1aTVwcWE2eitVYTc5L3A5OWtQUHFjOXc5NFVxcFVydFhYSHBYcnhz?=
 =?utf-8?B?ajN4SGhJQm1jcm1GRjJ5WTBVTG1Ra0pyVDlrVlp1Z25LRWpvODVQaGNSZmQw?=
 =?utf-8?B?R2xxaWJJZ1ZwZURsUmVXbVpKS3FoQ0tnZ2s1dE9SVmdkeklxZGFCMlBrWWh4?=
 =?utf-8?B?ekVyREhEV1lBY1BTZE9ISVZNK2JsNVNrZEZkN2tYeEJCMHNBQU4vczc3ZzlV?=
 =?utf-8?B?NjRPL3RZRGFqdDQ0UkUyeUZrQ1NDbXRKb3ZrN09BeDhsUXhVamE4MkRURU9I?=
 =?utf-8?B?UEh2cjhLOVlwVHdYUkpwV0tEbG0rUFZoRnRBaXZXdUp6eWhtYmYzMTc0V2JC?=
 =?utf-8?B?MGl1RCtvT1VzQWVFZEJBLzBYWmpzaW1HQ2JSNE5DdVV2ekVFTmx2WHJtOEwy?=
 =?utf-8?B?QTZpbHlNeGJzYytKZlhsbThHaEEzYTlhdUVYNEdVRzZFcEtzTkpkbTN2dFdH?=
 =?utf-8?B?a2R5Zmh5Q3plbEUzb2srVkIrbE1SdUUrUVZMK0ZRWW01bjlDSHQ1MlQ1d1BQ?=
 =?utf-8?B?WlFqa2w4eVNuRjd6cUdjRndaSHNQK0xLL0JibXZSbGlBR1JrRDZVSnBjc1ZR?=
 =?utf-8?B?YzhtYWFEZXZCS0xGMFZBYUdFQnJZYXNnekFsa2svbS9JZ1hOZ1hDdDV0eVA4?=
 =?utf-8?B?Y0tZbk5xSUJjeHozYk1NT2JHMk1WdTZ2a1p6OUVqdDJPdGtIbk1BQVNqRUJ1?=
 =?utf-8?B?VnphMUwzK01xRHpLQWJ1UERqTFBrRXNkTllEOTdCbEZiVDdpRnRVQmFlM3pJ?=
 =?utf-8?B?NlBNTitjU2NOYTBUWE50TmtZd3k0RGFFSEV4azdMWW9YZUtMY0FWaURrQ2U5?=
 =?utf-8?B?OUdDYTJhbHhLYVdDMUNHSVlPSVRsU1cvM0c4QzRYZUZ3QVgrcmJqUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3db28-802c-418a-967c-08de766ab5b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:43:02.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4OM9wAfNyIayuL1gpNBmOq8q2Js+g1HFFCBCCErsPOZ95JX1YljrYiFZNqp7VviBzhXo/vRvmUsjtmbJfnpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

From: Ye Li <ye.li@nxp.com>

Multiple pads can drive the same module input pin, and a daisy chain
register is used to select the active input path. This patch defines
DAISY_OFFSET_IMX952 (0x460) and allows binding on i.MX952.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 781835c6852..3cc2b85e151 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -17,6 +17,7 @@
 
 #define DAISY_OFFSET_IMX95      0x408
 #define DAISY_OFFSET_IMX94      0x608
+#define DAISY_OFFSET_IMX952     0x460
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -136,6 +137,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
 	else if (IS_ENABLED(CONFIG_IMX94))
 		priv->daisy_offset = DAISY_OFFSET_IMX94;
+	else if (IS_ENABLED(CONFIG_IMX952))
+		priv->daisy_offset = DAISY_OFFSET_IMX952;
 	else
 		return -EINVAL;
 
@@ -144,7 +147,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) ||
+	    IS_ENABLED(CONFIG_IMX952))
 		return 0;
 
 	return -ENODEV;

-- 
2.43.0

