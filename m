Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E638D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B7983BC9;
	Thu,  4 Dec 2025 05:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s+nroNCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A476583C7B; Thu,  4 Dec 2025 05:14:50 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD76583BB1
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/fiCQHY58cVuDcEn3HQ/SZVWkb6iQ/2eMD5pdvBELyVAh5SRXaV2SJav1N5SA9UnYumdOa/N/ZFyQKutHqv1BAfNIISjXiR4x480hJSU/gmCsEVvkYL+xG2cSd4hyZ6d4/tFxEqx1y92I9I2hgPqQuRMVXFwX7GBI3tGYd8JJFmoaJG3Ew4QQVIyNOLvHEawOw9m8Q/OOOSRHT+D3G54mxdbDLrNzDT2C0dfh8o8YzThkMNggW/lnu6Olc7pzLJwgBk457ftrOo/satMMTpSv5y+Roy0EuDECJXO4cUPw+fafU0JoOrW/308wztveLs7PU22fSsn9u+P/Ngoq/1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD+J+EGCpP9ET7XmJW/RbbLogMN4mAUEZ2TYMnrgXiE=;
 b=q5YR92l+DgAezYf6iz/MYBQihvgBh6tVz/Piu+PR/67J76WKRkxDnLBXvSxDHbdI/j1qvHz78wPOQrT5gZnPUeN+LQEkeT7JTiePhS9n2iWRTUO0JgCLmenSnr8q3DaMReeFeT/TOVJggsNpGGh70B8aoBTERfFDXFJGDSHhCdpI7clsE+AyIBzJLj9hLDPI1yLnX48c7yShGA8odu442zaTRMDQ5O86JIJ2mXzljhVsEsj5QIujoGVkyEmYMUX4aUP/5BSpW3TLkR81L5MY0PXTUXPh1dRZ9XJt4Z9Pa4UOWv6QL/26chhtDIC0iMUeIfKEVJPa7ZC7aly0dfD7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD+J+EGCpP9ET7XmJW/RbbLogMN4mAUEZ2TYMnrgXiE=;
 b=s+nroNCR5amvejfS4lQTcjWchKxY3CP6tfmrHlc/ftUTqjHOjt8ampkm2fVn+mjgqEC6458NUt+TrpVGUPmasKhFxSjfHsAFr1ZykRH0MT2SUKtKDOZ16rR3h4rxlBO9e7NvsPg2803MXBbSDLPZhboWUR3VSF7XEq3jAvCwE3O+p1GfKTqOa4IdLmqupNHgCPD4fHhZM0b57bI18omr4kwEDRXYnlUDoOsshmfb69m1SxIuwLWtBCs2nHl+WrQNZvnovR/DqYDDUj42H+7wxtWnTA2EVjcBPvvnUBMEHgwSjXdF+BzBzxcH3IyDPGaLgb15roxubJ2TNAoLrjnGig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 01/19] net: mdio-mt7531-mmio: fix switch regs initialization
Date: Thu,  4 Dec 2025 07:14:15 +0300
Message-ID: <20251204041433.3459826-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f08cfe-6f3f-42c8-aebf-08de32eba75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BaLFsC+c1olEwVePCgHEl8YT+ZFxyNy81EIkjV1ur7VE81H+f/3HmUSAU1WB?=
 =?us-ascii?Q?tJp+41ujWfG9yWL1rK6KC8IRRBS/X4qALpgRRm26ciJ1IRQlYAZMAbRFcAen?=
 =?us-ascii?Q?VC/c2Aoh/zChxPJdCi9kgjzaT+Zq/AbAsHmyKcZa7VR336bDa1DpLXCf5/Qx?=
 =?us-ascii?Q?7A3sPQxu2u61rkjKc6NQtuhc03ttQ4/fLNLGPsmJCGcUwZmHSeZCpP3cV0zE?=
 =?us-ascii?Q?pb0x0d7QAc5ZRtcnkVisklxTLD9OiUk/ZI/pe+MKBMUMWYnfGSDNnSq0mqzn?=
 =?us-ascii?Q?tm7/vRj+Jj6Q2xlrqMhYeDaqjXme7z7yzlJywNDV1ASZSw8oCYGqm2CeSYjs?=
 =?us-ascii?Q?BQ9NWxM8kSs16Y0ExCB14ErBSZsUHXZo5s1CeA0d8lXnrsR6hxdMr2b6b5vT?=
 =?us-ascii?Q?ArIEQ+G5mCM25tEy8medd8L/SiWt1/IiEchNCK48VMrdlrvGPVKFcztMIMgN?=
 =?us-ascii?Q?YTm5H2GWq/yWijwOaDVWAw7OciDbag/MQc4ZqpVP+zerePeiBhIE5Jo6ZjIs?=
 =?us-ascii?Q?1uOZHPs0cLRpCSsImF+NW7TFRjJ4Vo8quAEiDGFowWIX5P0lb+583s+GhH6V?=
 =?us-ascii?Q?yApQ7QiYOSAGdPVSx56ed2pHR9Qee0psrcLai6DGLN8JqfF9F3KnmPFfi3cS?=
 =?us-ascii?Q?/S0NJWxC5ZuDrlfK0DEBt6Nlxg8f+9vI/oOmQAcSTV8dtEDrWoNe2AFSWqRl?=
 =?us-ascii?Q?51mdBAjgCH2ZjR7d+bEj3RhvuocThuv/iur2hosTHf0KoO+f/1AwdJCWeV7k?=
 =?us-ascii?Q?CUmcsgM4ykFGoQp9uY9hKFSwqSbcL9bZLm3eFJKAzeOl3WWVvCWI2XpiFeZE?=
 =?us-ascii?Q?R3VikK/qxqeiOToq0pD7X35IKliTefvrLVx4Qfg75wSOJSDssqBld3L3Woym?=
 =?us-ascii?Q?778JxT9eNPukUNtAcWmMtjg43E71K8oYx2aU9mJ59xqa3qiK7BVfwPkjXwnX?=
 =?us-ascii?Q?LRQmSU/2lwskR8yikRcXVYW+OaRxz3ayh3V8PEAQTTowd+f2xZm6zeysiF48?=
 =?us-ascii?Q?+oeWRpASeKDDPbDOOkRdEIy0GAuWtblRK+mZqaHmgzYUAGRxWhRpOGwf02Mv?=
 =?us-ascii?Q?jRQyJ7VA0Zmc/XpxtBq/2e8FJ+AgzJ7vF1v0K2uwLvlCq2Z6n/lesm+fDrWO?=
 =?us-ascii?Q?UbcjYg6/cLkmkxsH84/9Esac3rvzCCHs+ygEXNqLyxGbJQFzlr3UmlzCEwGG?=
 =?us-ascii?Q?iPxrRVX8RU2qIh6s8R1frBA6v7ij7fRpgmDmjVVgJ9Cwh0Rgmy75HPEtvJKX?=
 =?us-ascii?Q?Sa0AKlX+W02txRADoB/hNc5Qfa7HW5Eyvm3pROsHVAhU55H4Btf+7KmRuxu3?=
 =?us-ascii?Q?CkdsRlUYBUqF10YyLu50UmkVoGrOmXBIzp0EUZ/kIsBxeyMaC9qDMWBFkOFG?=
 =?us-ascii?Q?YJ/mdQR3T07qrxiRvglm8LqnQ8nGloK1v1yF1luPLSJarg54FYzMAWJdg64R?=
 =?us-ascii?Q?a03Dv/kilQn0rE/DKj8FQyAT8zYSK7VKCqShjrsDHVtk6HzSc2ciHC2eKhmv?=
 =?us-ascii?Q?F1eB8n33boTOXmQCCeDCcJKXvRlLuxx0XjDWBcrkwnktTrJAwsjKhynRaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sXr8TXJ6s2P4TgrrOAFoOZ5/++dGSpSEKEmlQ8Ekzw/U9kfNR/v32zyhbWJd?=
 =?us-ascii?Q?o0OxUsV7gTe6FGVLzXYtkMCCzvDsXy+M8aoXDe74xoY4J+LR0Ki3kPZ71vw2?=
 =?us-ascii?Q?fJQlxiGR04W9e8GGXw3EKleznOQXA5zMHnuDrtS0v6g2cUQ+cQl/W6y+Q8Fi?=
 =?us-ascii?Q?VbXc0Y5hxQMmaIcYDfhURUhKgSbRx0FrkXzu4g2qilQAaQYzyBXunyF8WarV?=
 =?us-ascii?Q?Uhlf7F7WlXHJXWhkGMb4b1KQoqMa6m3fxhQm8+dLB5VdOkwyLp+4RBjgqdSz?=
 =?us-ascii?Q?PJIjiJo6Yfxg/hkTfHVQKQBC68/ZQS4jJAVDq2oE/5tNjTDrtvgsONb4+TOX?=
 =?us-ascii?Q?ltFiiwKj5OqozBLY5/TR2OF4SxtX/k+yQMsLkt5CwIuVm9l6kuRuZPJEVL0M?=
 =?us-ascii?Q?KCbJpe6TySjq7ntDrooRwfTkml40o2LUY0WgRN6zyWmjalW7W/TnffR1G6XF?=
 =?us-ascii?Q?c9aTMgVGLdh9N91zhDJpByYUhF1AfNKlXeVl+23cc3jC1yrSO10GTwBcWSpL?=
 =?us-ascii?Q?8wdthvkdYsUxof1uqBHukE8prDmExXwJwBvnpo01RTOpbQnPU9PkMivyRqUJ?=
 =?us-ascii?Q?wfhYq5aNc+/EgjcXbkA9IqJM8Cg7BaIP32OQqrfFjESA3MF93o0Q8JJC2keu?=
 =?us-ascii?Q?f1swYOp94tTp4NNjWbSqZCmRK9yhKn0i2L4K2NCIhnfhDU0eZ17jDy0egWkj?=
 =?us-ascii?Q?XTVU8OSoUvStUh/i+4G3Wk5LcL7lV2cUWeE4PMnWSwT2wKuFLaSop3VMSHM1?=
 =?us-ascii?Q?zDrpAoZUGrSUkRdBnv8oFbSKwgikh+TDX3po+jLi/bGLwoAr/RPAdh1zUMzy?=
 =?us-ascii?Q?/NkJKVmjZQrHT75d6TBlqqdteb9IcIuptxu7R+8c3jL+hzRZ36RN8N8ytufB?=
 =?us-ascii?Q?LSESIQp+gOUXh+Bos5TSBX9h8qe/fgt9jVhtCyf8jCn3aJ/y5cpUNDxmJFSv?=
 =?us-ascii?Q?yqLhpJZj3vhYDa4eMVWHc+LN5FbzXDmTWA75jW6EOlYKW5dVp1yDuFMB3D4W?=
 =?us-ascii?Q?1w+qRPmvzph30R2YUI4aPaXfd9cugv66Nrl0b3eqjQ+Jtak/9Vz14s4kv9gQ?=
 =?us-ascii?Q?h/VOb1TGXJI3vOpuz9DAT5qkD2Pf0xqdHB1rrtNiMn/TBRX+aH/FS05nnbd/?=
 =?us-ascii?Q?7IriL/HMplwpQlDnKxJ3FoNbL/7U/eBts5aY6vDjdzl+pdpq+wQtW29htCPf?=
 =?us-ascii?Q?Y2rJKvXAA+XFPGcGdEOUjnv1JLihpKmmcRcm4BbtwCaF7hxpsPDhtmREk9kY?=
 =?us-ascii?Q?Us/KprtA/Ts6FctAGtYjCBh7as0axlbHeNKjqby9f7TjFpwtPQo9yBywtGRw?=
 =?us-ascii?Q?l+DjlKL0/cZss2I22aschXyHmbBQp6Tb/UCQNgQocxFTPjTXrfRBpdB1Qmjy?=
 =?us-ascii?Q?mIRrnaRYM9EAhIgmtEcrAd0+ISmDUnT1e9sLBfZnMwc1LO24hQoG6aDvhwHx?=
 =?us-ascii?Q?SDGmCYkxrnRjX51iKs7aGz6GUObBEFerNYxSzE1X7ikID4kjuO3hIyxhUOmF?=
 =?us-ascii?Q?6XbnatBM990Qmfo/PxCMZIDW/mwcPOkv8ZokhUf80WCTaPBrtrfzS3jtXoZt?=
 =?us-ascii?Q?Lvxx20r7UpPlbtz7YaO8ddWhsW60SUHGKYOY9sRHkEfmmPSosI7ax7UX89wa?=
 =?us-ascii?Q?LsjKBYOGcvVmCVF1Q/+E5OI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f08cfe-6f3f-42c8-aebf-08de32eba75b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:44.2004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOWAMHUCbZTCGLQ+92IzFPoMYsljSylGDSWgk6yEHJkiTZ+mQzNQjEwmUmiaWFzOCwzOaX576h/7ibDA7RcnierCM9ZLWvVICvXcM0AJ6Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

mdio is a child node of the switch, see example:

  switch: switch@1fb58000 {
    compatible = "airoha,en7581-switch";
    reg = <0 0x1fb58000 0 0x8000>;

    mdio: mdio {
      #address-cells = <1>;
      #size-cells = <0>;
    };
  };

so to get a switch base address, we need to lookup for a parent node

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/mdio-mt7531-mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
index 3e325ca58da..5a0725010f2 100644
--- a/drivers/net/mdio-mt7531-mmio.c
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -151,8 +151,13 @@ static const struct mdio_ops mt7531_mdio_ops = {
 static int mt7531_mdio_probe(struct udevice *dev)
 {
 	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	ofnode switch_node;
 
-	priv->switch_regs = dev_read_addr(dev);
+	switch_node = ofnode_get_parent(dev_ofnode(dev));
+	if (!ofnode_valid(switch_node))
+		return -EINVAL;
+
+	priv->switch_regs = ofnode_get_addr(switch_node);
 	if (priv->switch_regs == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-- 
2.51.0

