Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EEAEBFD14
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D35D84199;
	Mon, 13 Apr 2026 10:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="akrk/FJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C693383B99; Mon, 13 Apr 2026 10:13:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA52183B99
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM89NKQKBap+QPISdKjO81W7CnSuMnKMQqS0dduLdBT6n5W6ug2bQ0yQ6tF/ZN98+TmnOZpksMQbkDA8Bp05UlCgaM2Hm6MloKPe7UyHKSBLUnwjUtaPWtOFfn/WU533YbAwGjvosSu0b35tADC29lL0y7Tj1r6lilf04oW9BT568cufmbgfQUckYSN7DO3FjnOUpE0qgWJ5VEIM84SNDdLanj5jH3ZRNmsJw4kuKnAWMPohmdL/p7qL45acPCRn72VV2MgdILP0ZD1E/vQ42AEdCnkYyM98NoPrzYMd0LbUNy5R8U/+yOrt5Bu9rfNbDQ8A+DXRhWtVQZjz6G/d2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2Yj2bHmit+6Y7m5Dp/EMtQUXxbqGkHwheJCXHQtMyw=;
 b=Sd7cJyBS116OW5IOtVyYz3cSc6Wng4Nichji4/oxx70uJrbpZk4i80WDhnOsVOP0Tmbb0cqFCSTrVMzyhxu9S13shsGw0GQ1SkS81l5zJyHTywdN8qQFL5q7hPM4e45ewiV2E/qtQ5TdsRlMfTjg6Fjt2a1YMMlf2j2e203sHnArvjzI1S95RQjwClqaZ2/g71Bhph32ChtGiYiu4juHeysMIdzF/TAoI18fO/4yAvntt6vLR/QX+ucnYGILAglzeg+bh6jMlaqJHqPkn/IZnZbBVTDvSV/d/VjzpjZsL6w3yMIQFx7Cc89913zXlR4M7vVzShOOeMtpyIVs4LVuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Yj2bHmit+6Y7m5Dp/EMtQUXxbqGkHwheJCXHQtMyw=;
 b=akrk/FJyBFoZIjoh9r7AqKu6/nPkXWewlBJc+0Vb6Zi0gp/F35PRIyuFUW5gLN3+vVMDqLAm1c3y5D7YpqNkn5zEO6B94h14N/BcG8XEmKOkUtfmRiFZm6nyQkPUfUYrJXIXsDgjXOUHb0JEmYVcKw+cG4D1CybPfDjdBlIbJnPQIbBa8voii8D38UllMQxl+s8IYIPiixN78E2TRve872OlqILnXADnH/qGUN6IJNnUGhoUlsPP2UssJB/w41HkiAY58KUMgguSwQfKqOTytPbuR0tFWYhS5zACXtjD2W9HUhi6yTKw47YZUAPvi0a04psv9ozMZauOxIHdU8gvgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:13:34 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:13:33 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Apr 2026 16:15:39 +0800
Subject: [PATCH v2 1/2] net: fsl_enetc: fix the duplex setting on the iMX
 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-netc-v1-1-8670e5ce2d49@nxp.com>
References: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
In-Reply-To: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
To: Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10483:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8e7aca-3575-4705-a0d9-08de99348e11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YpVQ9Z/joqqFajfNszTGYXsfD57jxttVndXBXXFFLWUhc7eZHyeoT/jE6Mq1GABFs4+g0D6IDf5Zscmbvijs8Agl9v86MrpLwmoDjxRS3AxEp5bHVHwuY5KmBJK2sRMQxYn9AgSPSpGvYShQAdacs/hZQiKq/7KRoLgpDGR6/g9uAOuBbb18lyO8rS4zutRyerRFe7B751H7TyjpkPXbVfA050YXOU/fgBCUrqf+dlIckK4nWVoqFfzgVyi1tZXGW/CgSSEemPTGJVmuOf9KRhRlLfvj0KMOg24/sVF66eoyHs83fNZwqXpggeVvSnhfnEWT7Re8wSmzYUs9IH+8yCgaMGIny3h+37zXTDyZJ3Jdb+d+/svDN+nL6dBQpCdNNJquqqTdbGhU8FLGc+Avfx+mdYxGYft42YVfC6NFMezP4lN+3tjpTVcoz4YkRDsJ8fmv500Nyly9s74aDkyP6N/0Jd6gy8sTUiPueclcIzl6gQyjpAhkjk6xYvzNByixldNa1RkNBeSBxTB/Sa5qxB8EgMPUxAjpMYDjoVYTS3rEnOFRLlFLn0RtI8ksTQi6/ZbQzNzpTV8jmAAneo1Vfr2tdnnqpePF+P/fQd4to+FFSEKfVZzjPLgRz6IcpJ44N89HyuyH9se9YT7tgjKEdK5ETvje50A4Ra03QCNRX1QAc6V3iDU4as5QxSnJkNnqUSgRcSXHJeyD1nS5xwpZWy2w4H00/jJ4AevqT2/RIs8ViKFNs57ICW34MTwnkDeLfj/WsIEZ9mK+kpzbtot4XZCxkflEPhIHVzChpY9iLpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklSZmRlenpJWXFnRXo1N1llMTVNN0J3YTVWN1lqZHhSZjlRdzNGWlJRQ3d2?=
 =?utf-8?B?U2w2VHVKL2pWamVkSmFsZk1QbWxTVnBsOGZLWlh6ZUpyQWx6ZjJjcHdJRWky?=
 =?utf-8?B?emJrZisraSt0dVdSL0ZKQ1hCVlVBNW1taHZaaUd4dGUzc3VsUG8xMzMxOFlO?=
 =?utf-8?B?eVhVcTJnbExvOHlGSFAveVJzZ0xvd0dMV1BsT3RmcWg4R05hcnczc2JwY2h6?=
 =?utf-8?B?cTFaTGx5Qkl2ejc1TGN2UXF5a3VrdXdGTVhDRVNIN3I2VENNWlFEa3poYlFr?=
 =?utf-8?B?RGo2U3YvK25ob2RGRkVPcm1IVlk0M0NweGNrMDUvRDJlZ0h4Z0xKaVpMUzdB?=
 =?utf-8?B?VXoyZ0hpWDA2d1ZBT0NhWi9ydE0yeTN2c2h3T2xqQU5nV3k3bld4ZU5aWTVP?=
 =?utf-8?B?OFRuY1JmTks1NnhLa3NLV2djUE1lT1FjMGw0SjJmOVhhSWg4ckZGN1NoSVIw?=
 =?utf-8?B?cXcwZ1h2UHpDWElhRHNVb3o2bGl5L09lSS9VRld2OVd1WW03MWlacjl3K2Fw?=
 =?utf-8?B?bXBmV2RrVWVRV2lpVjVYYWtvbm9Mbk1oTXIxTW9GUFo2UUg4ZW4ranlUeklN?=
 =?utf-8?B?cHRBY1hwUi9OTmxqbUV2c05RU296SzJKNjc3QmlxSmM4UEtWMlhpdzd3VGR5?=
 =?utf-8?B?Q0lEQXFXQlFWMko0K1RNMXl1UzU2ZUFwSGppNzdFTFloSzY0MHp2TXpaVXRE?=
 =?utf-8?B?RjBlNWIzQjBFeUUwdUFGaE8wOFcyRFhvVnRTUHltV1I5V0w3OEFGRnVaZk5G?=
 =?utf-8?B?U1I1Rzd3NURrcFh5aThERXhQZEpqeDBLVnZ0OXZaQVg5SDh0bmtMMGc2VENx?=
 =?utf-8?B?ZjlyWmpqbHBLYjNyWEYyQis4cjRVbXlFbWJYalppUTJoTnUybHgza0hzdkR1?=
 =?utf-8?B?UG50N0t3ZmNSbHBxZm15QnBJWEZGd2dFRXYrYjJsUkdwV1lmTW9wTzd5OTJa?=
 =?utf-8?B?RDlWNkFHNFdKa3Ntb3E0TGNyYnREUGlQSlZwNUZHdkIreU9vTWJxaEFEdVYr?=
 =?utf-8?B?ZEgrL25MNlpCVGNtZ0RWT3o3RDlqaE5hbFE0L3owd0djcjZaNmRNUHFXUEp2?=
 =?utf-8?B?eDlVMWc5MzliY0YybjdHZXR1MVRVSXA5T3FYc0w3dURFR2V1dVlPZlRUMEdr?=
 =?utf-8?B?Mmp4S3lLSUxNSkZqT3lLOTg5a012SVB1YXhzVHJKby93MHF1V2NSSzBpUGlr?=
 =?utf-8?B?RnYrTGxpZXZTV2lnUVZXeUtoR0JzdWhxTlM4MDc5YjZJTzlHblJjRE9ydnJS?=
 =?utf-8?B?U1NaanlQaURrelRBOHV5VTRwOVZWNFdLb0JZVG1FcXQ3eTl1THBzV1FlcEhh?=
 =?utf-8?B?Tmp1eFZ6NW1oU3hwWVloUVdyckZobWx0WjFnWHJ3SEIrNkc5YzdrWVJuU1BM?=
 =?utf-8?B?R3dDYjN6bDRhWktBZklCR0Q2TWRUTzduU2NZQ0VxZzZtSVdvL2plZy9NR0hx?=
 =?utf-8?B?ejJHNXZQdkpNSWJPRUh4RW1qTDR5WU1NQVV2SDdsUXhYTmpKUy9yZ1Y1ZFM1?=
 =?utf-8?B?a3EzeWRaeVk4UUwyTDQ2TEl1bUUwMGlhOHdhd2xuWmNWV1lxdnVMUzZaQnV3?=
 =?utf-8?B?Qk5rdzZSRlhWTWxWdzFoT2g0bXRTWmJNdnoxL2RUUU9TK05YeUU2WnVvOW0r?=
 =?utf-8?B?TnZyUHpzS0tERzlBbzhYRzdQQ09Qci9leXV0M1hvdHVBYThFQ0FKUUlLUEVm?=
 =?utf-8?B?b1ppcDhHeVJTZXBmenE5cWQzTThvcHYzaTJUQnJFQmJEcWRlRmxXSW91ZCtS?=
 =?utf-8?B?Tlk3bFJENHNSRUcyeUhnd0V0NmFFdElnaEJ4WFlBNVNiZVlwVHNYaHl6TzFG?=
 =?utf-8?B?M1gwWm8xaEp2Q205MEF0Uk5kN09Lb3grenFRekkralhkMmpPZ0RGRHZhc1M1?=
 =?utf-8?B?dG5INTFhaHcyMXIyZUR6N1lJbWdOMWRjZk1JNEE2Skp3RDVmWTEyTnNxaFFX?=
 =?utf-8?B?RFZKK2pCaGRwQWpiamJLWnBXS1V5a3FBN2R3KzZxank4VFUyY0ZHZEM4VnRL?=
 =?utf-8?B?TG40a2hWMkVJdEhBTnZxMC91cmJ0Zk9OTnNqdU1aQnFKSkhyc1ZJVHN5TkNn?=
 =?utf-8?B?UC9Odllya0pjR2c2aUIzYkJKR2ZyWmsyTDZsWm01b3pUU2lzeVluSlVDd3ZV?=
 =?utf-8?B?Vlc1T2RSQ1JyLzRaS0dRcjdqRmcwS2haMTFuYm92YmozYno4T2ExR2gwV0x0?=
 =?utf-8?B?RlpyL1FmQ2hFQ242VXNZZFdDcUJSQVB0WmJ2ZVBOaisxdzlheVkwcmpDVml0?=
 =?utf-8?B?M0hHSlVBVlpPUWFweWFOKys3Qnd5MkQwcDVsZFRHR1FQYjZna2UwWlhOTG5i?=
 =?utf-8?B?aDRkdVpwZ241dmVPM1BLRjI3TDdMbUQrNERSenVxaDkwNWphUTNVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8e7aca-3575-4705-a0d9-08de99348e11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:13:33.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9pC9bdpcWrXlY57Xe/92UgW4uukhdK3Rhi+7U8BeefwoeDgavHxAn1yRwXWK7wh3fZ7mgHrDbnmdbEYsYrVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483
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

From: Clark Wang <xiaoning.wang@nxp.com>

The iMX and LS platforms use different bits in the same register to
set duplex, but their logics are opposite.
The current settings will result in unexpected configurations in
RGMII mode.

Fixes: e6df2f5e22c6 ("net: fsl_enetc: Update enetc driver to support i.MX95")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index a4ba27904bc..766aea035d3 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <pci.h>
 #include <miiphy.h>
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/build_bug.h>
@@ -388,7 +389,7 @@ static int enetc_init_sgmii(struct udevice *dev)
 /* set up MAC for RGMII */
 static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 {
-	u32 old_val, val, dpx = 0;
+	u32 old_val, val = 0;
 
 	old_val = val = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 
@@ -408,15 +409,14 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 		val |= ENETC_PM_IFM_SSP_10;
 	}
 
-	if (enetc_is_imx95(dev))
-		dpx = ENETC_PM_IFM_FULL_DPX_IMX;
+	if  (enetc_is_imx95(dev))
+		val = u32_replace_bits(val,
+				       phydev->duplex == DUPLEX_FULL ? 0 : 1,
+				       ENETC_PM_IFM_FULL_DPX_IMX);
 	else if (enetc_is_ls1028a(dev))
-		dpx = ENETC_PM_IFM_FULL_DPX_LS;
-
-	if (phydev->duplex == DUPLEX_FULL)
-		val |= dpx;
-	else
-		val &= ~dpx;
+		val = u32_replace_bits(val,
+				       phydev->duplex == DUPLEX_FULL ? 1 : 0,
+				       ENETC_PM_IFM_FULL_DPX_LS);
 
 	if (val == old_val)
 		return;

-- 
2.34.1

