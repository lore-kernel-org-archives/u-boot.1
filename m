Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20A8E7E36D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 11:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF21984099;
	Fri,  3 Apr 2026 13:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bBi3KnKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B2B8341A; Fri,  3 Apr 2026 13:01:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B45AD84099
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 13:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEVYTfZ6jwT9gDwuc78FOBuGJgRwSS/AiV/ge8AEGl9BlMGzzgHnTZXCGY6QJlNSiAn9Y4LeM0t/YUv22DN5mOOT7C7ExaanrublTlXf7UW0gqUmDVTT6FZxmm3uotE52w5jOj3nF4+Wu620xdTJAt2TBnQi1KoFqmNyVZz7AaPvx3UfdDf03kehUn5zadmCqliIJpQy8X8q3qRO/XW5mL32G2fw81eDplEDoQWPdcVsvc+d8pvKuCARo3g69g0TUN2GBoXaUC2N1dkWGOgo7dYA122+qN9TqLoNkReP+qT92O4gb2dl538SZH57ZgOjdUoguXU7/jtpTdLuBeRjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezCyr4hwGoYR/LCj3nke3RjIiYVDQKGw/IK5U+KN4II=;
 b=l6XEmDd6N+3vTlr36AV5FpKetOUXeHKrzrcuulE9kpcr2TnDtX2flVGgIdfsQaNfOpQlwLB73QJ90mO9ES58EqGxiF4VcQj3dybAcqKdD/vAvwHPrjzS726PvGSOJ2k/iybvVHQdWeO2XUCOvdatos1oz/ALDNdENVyLEYj+7jVenOq8gOjuJUvL0CkViQ1jeStA1iRvunXGpowVdewI+363JY+B6EIUch59qRX9R+OlM1Oa/ry+5w02DN4AM073iXZI0hkz/4Z/Iegd+6Ux99pI3zP9Z+rys/XYYOCtG22NXoh5GYZ564exjp+xpT2w57ZwuggryN+ukh/B/LNAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezCyr4hwGoYR/LCj3nke3RjIiYVDQKGw/IK5U+KN4II=;
 b=bBi3KnKDh09X/evlniSeINkvES8yvEVqKwojQtz0HCRE9SgRlTvJ3Yzjs7Jn/u1QPNUnloUbIP6v5wXhaiNkEBqn4MalVcVPj8T8RjZF8KtEwRiUVyA3oLesHSKK33rf+rT/ec5DX4ZbR8hNDeUU/WEPJL/454USSBdDl2OBn+t6m8kiout84i42SkacB/qjQ1/AzfBMnGMvupUGpJMI2fK1kYNaOtb1UbgvFdSCydeJ4DnOglyhbzDdSUJ7GcPLkQCIgebSH5Y2lw1RDmafJK3U2PvDUayOb9ZEBfC4p8dhNOIsx6DmrBMYd34Bz1eaI9Fx2qkskYZI7NFR264+/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Fri, 3 Apr
 2026 11:01:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 11:01:50 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 03 Apr 2026 17:41:26 +0800
Subject: [PATCH v1 1/3] net: fsl_enetc: fix the duplex setting on the iMX
 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-enetc-v1-1-e42ae28ae3fe@nxp.com>
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
In-Reply-To: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f6449a-7e27-43ce-e50d-08de9170685d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lqoaOLBs7UZy7xUMIZju5vK/3AN7Xf5MHjBERkBnUIABUWgru0Oe/ive1HV4AwNdopK1wZ25UB8EMtqXBJmwvUi6p0skApoYY01VB1qsG8Wwxrq+MNuPVdxLkMYBe0tXIXgcFHC+f6RLGBrFMC/3yTgTaAyvFISL3fnteGqQERLqSkcb+tvtAitMv12x7PN9YG0YZBTuKFGYvj06WEaDJXFfUnzz2FfLqDITxm43ogZQOwxrSLZbDt62xea33u6qvzBKlqjAb3GGYJybQVkbBSK1Rgs/tC+q1OPQDyv47OkcIHjgMJNUzTwI9mk0AXqFa0CZKzVW6SQGOEX+rEe3Mpb2G7Xn6OJS/6Q1ez2Z5gAmPzUSPXaqBpEpIz6l+qn2bO0j9ksR4x/U2GU+3fjm/aNiAR+Yl245Qn+qE9ptU3bIEX63c/71nf/XZVMn51G1FFINhJONzGR6EDi7PImdCOnkXVTQyPKW4aRcnZiG8+lPN/u5orBOjLoiYZ0J8sWqlR1FBeSuYIRBeBZBsc6CgxdU0yh3JaLzB5NDfs1qQoC+ZJe0H8B5Cay93aMxOQR6JDuH+Af7hM6wXfpkb7YPxOvj1hAa2/KUf3rcBU+9R5wqADui4jYD3p3h7co92jPjUkwLmvzfqQZa9BnTHfC0lvfNzYbcdFRoQeOi0WvW/y+GS7a7vU6fmYBwx+ReimzCZf4SXInVZ5QrfkQ0INjn20sRAkvP2FUaULuR3/xthbTcsA9rEMVH3eAJhT0O5wuksUuYhDkwp0Qw/FKcK/4593BE20U5lXBXvAQqXPAjqPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K050WnhYaUtha1JQeWx1TDh6RWM4ZkpXYStsMEtMRnpuNWF5eFpWWmRoVFdR?=
 =?utf-8?B?c21reGNVYVFrdDdybTZLbTlrZTRBczNpVk5ZTGgraklOb0FDVWNKVEJWSW50?=
 =?utf-8?B?bUdPY3p2MEJ0R1ZhZVRuOFpOU29ZODVuMmpMeHlJTGd1b1U0NTFqblZJVis1?=
 =?utf-8?B?dU5UNmFIZWpHVU13M0hqUnFCalczeVdacWRCYkVEUHVsZDJLbnhvN1FIU2Zr?=
 =?utf-8?B?UkIwQk9KV1VCZ2FnOXJ6aVZiWU9WQUVXb1ZIT3J1d2M3d1RGZTFYZzBHeVA3?=
 =?utf-8?B?N0toekpuckFUNndLMlM0Z1JtdUw4bi9PNlAxQ3U2eVJiWUlaUXNZQUZEbTM0?=
 =?utf-8?B?YytyUzliNW5wTldyaTFaVUVtRWtuMFF5R0tuWXg2a1ZxU1lVUE5TVVNtdzVp?=
 =?utf-8?B?anZzTEJZa0h1SXJjMVdRS0FtaHl3MjBQbHBDMi9jTm8rUkJWcXA0VXo1VHU2?=
 =?utf-8?B?S0VRdTdnRTd5RGZGVE1acUJSb3dEM0tYdSt2aGxINEtJcWthalFKa2RMNHl0?=
 =?utf-8?B?SkVvQXVxYlJZQWpKd2JKKzM2cWhMalZWU21RcnNIVWF6R3ZBL2RxK2R6Z1hi?=
 =?utf-8?B?MisrZGpMMmFaZGVtbmNodmxwa2kwcHVweHFPeFAwanJQaG1pV0l0VUxiRGdL?=
 =?utf-8?B?NndoMmZmRmpMNzhGbmlDUTRQMVN3RDkzSlUyUTZXQVRPMlcyWlJkNXBlNWdo?=
 =?utf-8?B?L1o0MmtRWEMybms0amREamMvRGNJeUsvVFJMVGxranJhZEpBV00rQng2bDg5?=
 =?utf-8?B?Nk5MU2xGaVg4blpXV0lsZFZac1RJTm9FeEZnV0JFZmtSTkQwejVuV1pQVGFp?=
 =?utf-8?B?SmI2ZGovRjJSWFVEQndnT2lrMVM2amdoei9NNVgxMFN0TGdIeU05ZXR0NG9x?=
 =?utf-8?B?YjJnbGhaVk1xK0tlZ1F0bVcyWVorYWFFcnJ1cE9ubi91aVJyYTVYUkIwV0Jr?=
 =?utf-8?B?YUJ1V01VN1BweUFXUVhBc1RWdmRUM2RxemhOMlhacVIyWEs0UlVrWGFMM25m?=
 =?utf-8?B?UnZqQ0VvZS9UYnkybGUxWHNpRkp2bnJCOGN2VTVSM3BjTGozS1pMd2o1ZDc2?=
 =?utf-8?B?d0k0dDlxSTcxbnlOb0w0STlDMVdOais1MjVpQ1d2NnJGeTZ6MU5nNUlFQ0N3?=
 =?utf-8?B?QkRxRzdidXZONlNEYnpJQjhYYkVMZEZseWRLblJwMDhTMmhiS3RncmVvQlI0?=
 =?utf-8?B?Q2RMaXYxSk1PZjU2a211UTZyUW8rR0tsdGlvOUFDVkNMN09OWVdOajJmNGZL?=
 =?utf-8?B?aDVFcnA0UkVrb09iVG94cndGdkx1N2JKMVY1UjIvemRlSGVMOTFKbWVEWHls?=
 =?utf-8?B?aUptM1dkNTlXTTVid3JZUlp5N3RPR3RhbFNqNXJ3U3dQRzhWTzVtYXQzbFUw?=
 =?utf-8?B?Nm1PRTJ2alcwVStZUW8wbkVWdlM2M3RqRUdJb1Z1Nll5Q3Ztdk5RcFNaanR3?=
 =?utf-8?B?dEZuR2ZTamZucUVyUlVZdGx5ZFprclcxSGZTdjJIOFZkYy9TOWUvejlNdXdF?=
 =?utf-8?B?Mm1lN0lNZ2VCQks2czA3bThWSWhYcFgvTHlxeW1mdnlmcWtnVzNkYVp2OURE?=
 =?utf-8?B?WU11QVZKWkJpcTZYZHAvVUgyTGZ4MTJuMldUU3VURU0rRXFOL2VNMFZ0bzBZ?=
 =?utf-8?B?Wk11VXRiY096anZNdUZDcE8renliZlRXckhsdWJDZ0tVQm45LzlPeERvNm5F?=
 =?utf-8?B?TUZUTnZjNVh6c1NUOFhTQWpKQmRBNDJHR2MzN2FoRTFlZUZuRzVSWWk4THZ4?=
 =?utf-8?B?aE9ZNFRIRFhSSDJicHFwZ2UyVW9jaDFMUXVteUlDNE1nYzFCUGlJTXpKbEIx?=
 =?utf-8?B?eklERXBqeGk0U1dRYkwzdnd6TjlYa3BGa3YrZEkyZUZleTVJbVVJV2VZTXRo?=
 =?utf-8?B?T0l3clFqMHZLV0VpcFBQYXpZTmlHOEtPWWt2Tm5wY0lHeWhITlpSeGNwWnlX?=
 =?utf-8?B?NHNEM3VpTnZ6TDVLZllvblJ5Y2RqK1hMbFJqRkFUL2R1LzBGZHhoU2U2NDFq?=
 =?utf-8?B?cXpnME5YT2VpYUpzVVE0NUNnbVBWL0pGVHUvVlBZL0xIT3p2TXlNaDE2Z1pJ?=
 =?utf-8?B?ZXlSUk1MbW1xZjFZbDljWkFTZmRGNUVZUFNKY2RJUEdob2d4UHY1TEROYWx4?=
 =?utf-8?B?Rnp5NUpWMCs0cWtjZ2preUJOSWVGZHllVWozSUFXSTloZWFxSnh3OG9kWEY4?=
 =?utf-8?B?U2lVYkovaXdsL05ES1dyVDJSZUZIS2ptVXNaRDRxUVFLSlFLRWc5dXUraXds?=
 =?utf-8?B?RitML1RtOUtZVGlPdExncEc0LzI0ZDV3R01acU1FdkFiQlVlc0hpemFOcEEw?=
 =?utf-8?B?M3FTYzlIRThaMUR5L3Izb2hWb2NPK01ZbjVzRzhnR2xsWUg1WGZoQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f6449a-7e27-43ce-e50d-08de9170685d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:01:50.8297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqUGzXvutdCyoiMGK3NRmIfujUTsMvh5uTKWkkQgppfGh6XRn5+Sm3hUxnzD+Wj9egNNXNmeM5C0zZSYrHPvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
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
2.43.0

