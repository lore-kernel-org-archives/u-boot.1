Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62E1CD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 03:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4554F83EEF;
	Tue, 12 May 2026 05:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vFTsbwcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F268E8464D; Tue, 12 May 2026 05:23:58 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8AA83CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf7BsTR0ISt0tBEorbRBNFO8LWyTOqkbS77M1hQGnfmSMC+PmsytcG2qf0uCRlC8Os3aKbp5bdZakWBTsaTWZYnJ+W9usm69stMg00lY+wu0rA0MdC0mqmWBlVlar4OCKKryfoRoVBLYAfdiPDnSLgsLoZF7GEGe5uWjOL8Vb3KK4gTDPZyKW+3ZWUYgiQQ6hyrPBPywsIgP7W/eVV42uv7Nz0muZBRmfhgchM0aDfHSLdtdZ6aCj0lAfYAlLf5B1mQEVlKokUR8/sEsXOP9IhDQw/AqPS0G6T+vREib6CMx7JRyYdrvT02jW+rjt5a/6Jl8dcniTXeZPlmDDUcvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7pXWFNuEpMsvnLQnDUAnj8qvAWrb76VqENbvrIQYmk=;
 b=e1BMNr1zhSyoeCFl6uryz4S4BKONms8tXYInU2d4YS3pph8EwRNDUb7wBcQvNCZBn7/0FPjjWNiFJkeW/fNHlPhFQyiRGrbHSMWu4VvdDUjraXOzqM9UHtCKo+ZcTQtJSkdzFEPwnPF8bOHpZRuqy5QOvkIk/dpccIVMnmknFUnvetnxN4DdBua+5OFxoIZYcMsrxQyaRH0yPYE3/n+Exz385ShqNcdcVv3p2xpYL8NiKPdS/PCx3oQ2kjPx+rgdFh/LG+eRbaO+v/im23gWli4ZLWGScUKzwsAavW42zjEJxuuCBhukClAjRVNn2ehTcpAbXlUiSOF28oXuTtjjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7pXWFNuEpMsvnLQnDUAnj8qvAWrb76VqENbvrIQYmk=;
 b=vFTsbwcQOxbPsuT5ud2bsYd6mDSZRxp7lp1iH2szSuGuEnL2pNUzVnhhZH/FvWNHyH0fA3rshZ+YMK86njrd7IPcPFb7rVFR65ZXTFAl8P1LsBdyG21LL9y1NxxL5LzoTMPYA2Ujw52z+Lv3Y0MZ8jD1UU+XSYo/qk73/fOZk6y3ZhSEPYj2oqFoNtimywQsDFmmzPtm18IHk5Vk4ghgppKvdNMCVI/J2CjuHa6vjRFmsKXcJwSjkjMNHszKt3hvSgZtqIekxHICy6eWJF9vynm3UNB/k2TjeEpHiEjW2GGutU8YSKEyMZV8UXtvrYab+1gN8EW+Dfr8N3jP57UPDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU7PR04MB11236.eurprd04.prod.outlook.com (2603:10a6:10:5b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:23:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:23:53 +0000
From: alice.guo@oss.nxp.com
To: jerome.forissier@arm.com,
	trini@konsulko.com,
	u-boot@lists.denx.de
Cc: alice.guo@nxp.com, ye.li@nxp.com, xiaoning.wang@nxp.com,
 tharvey@gateworks.com, marek.vasut+renesas@mailbox.org
Subject: [PATCH RESEND v1] net: fsl_enetc: fix the duplex setting on the iMX
 platform
Date: Tue, 12 May 2026 11:26:30 +0800
Message-Id: <20260512032630.980534-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0258.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU7PR04MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb2fe7f-7cf8-4fb4-f4fd-08deafd5e462
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SujI3Fg2acp/gnbkwe49q3zBd7/Xpls7sU8MeWPfMlwF9z+VNFkdBnbP3PzLCvfV4Zdn58WNyaQlMEclcGurHNrZZ3IJkFHMImGihq8sGJd+7ieYN0bRPKlN/YFiypjxj+TWx8gpjPz44Lsa9xULrWQFG3eVWmE2KZd5zLcWRoX9SZmbWWeAcVlIN1Akv3dYeMloOB3mj4qjUASKDVxGqTvC5ubLqZ8YZRyhDuclSgHNmsEF20ns10viy4uFgGRXwxdj14FPxszqHkf0/6IUyiDWC4A3qMwyFAuX+cirIV0pXPzqKdTEaBDsWabgmkY8XB2im1X6ziJSZzefY58XLYM4J4/iPVCJmZdhDaBRZP6B8sxYgiBmAycoEE0CnsusgWEhNGKUHLX32dYrshSUqUgu8mdm5rKYKXuwyO8JWdk/oawVue3DcUyzflhLOkN0sfVR1t1zi/kTboI14g274sM8X4laSQj7egLu2Yyj5xHq33cCsVdh+vgEAkH2FTOw+f+kIVZaWsJS0qVDrTrEPtE5Tpl5yLIDg4OsFpIw6I5JtXcDAaoTqA/ld/ZGxuTDqBeqjIU93qGF+mFofGSRB9NdE5Z5z4EfV1iNeCzyuFjsyuxl+VMzzAIAc9chZSgHneWk+aZCP8ELchyIbvevuvVJwrlzCvv9pHunKb2STfER5uOWRfP3vWLNnKivXBp3R0wiepsFXBDgxl2ws4YsmVUnRdOb/hqbwvYiNINSu2UD5I9HM3dBweZ+YDpMS2Z4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JahFMwdL35tcXe48AayjcIXuwMxrOqfMkSCoyqvHqzJVsOKy/EJM6jr3mSFA?=
 =?us-ascii?Q?kjLggYLcc2FpbhgAY6r677UR0JeJrKAE2n1MhRS0jOSISRtzPs2XdBBLBhxv?=
 =?us-ascii?Q?jLtyW+wteH7xn7u9IgczxQrGnHd5x3v/8QsKRpsC9ascSswxg8n78Xi/dsok?=
 =?us-ascii?Q?TSZ0HWmdF2AQBbghH056oeR1BR5iufEXJgiQiPrOGbQPKgmoKLO0kFaeYzeK?=
 =?us-ascii?Q?/CPD3DLIeHLHrERD822eZJT7deRoNhTb9dEgXsJztwZ/8wBgYASjKY2SyQJp?=
 =?us-ascii?Q?2dm9rfCLQOl82ov893gx7xVxYTmjKuFR0SMaSAqzMIfzqLZb2v7gbC0hD4Rf?=
 =?us-ascii?Q?MWcAxcbdyyl5+vrsyQyxq0IjKxQpoctUmaYulKyw5/I8SJ5zSYpNoyMdUo7E?=
 =?us-ascii?Q?ekFOhs+DhROTy8atSSmP9TWKiRpU9f06dPeYMPbpATcZxvmXwggARpuWPb++?=
 =?us-ascii?Q?V7JoeAy/OIQPAlIWhwaGl6todL/HeXZALV/MlbHYIoSR5ouW8WWJUkyCf8Mc?=
 =?us-ascii?Q?3+bXq/4LO+B3GUzhFK++mhJ3qctotKxSyB2+vqWc7HXePrHuhm3twGgdLXYA?=
 =?us-ascii?Q?KP91U4qBaeg36rBnm8acVr5qGPibtQlBIOSTm7UEfIXKtIrjBzKgg/KrHG0U?=
 =?us-ascii?Q?GZtBPaPlqEGFxqZD7OnBr79NV8o1eC2HQ4GG/oycqV7msvJamMTrqz5IMxOI?=
 =?us-ascii?Q?bQaMbyoPLmOByTdpXlDqu5i+oI38NKcEydZ3DPvZrs6t8xu80AYKYsY5SN7T?=
 =?us-ascii?Q?r0/fEpfxwtlNCRpelDArXiiMm76z9l6PSFs4ue+PGmRSFy2+ZyrAPKmc4prS?=
 =?us-ascii?Q?GpMmio36FLruh9YLPfvzw6pPXPOaxKtFKF1pdKzRvL3rVwRaFMtigVF4xeCN?=
 =?us-ascii?Q?Sdoe4imTQbL0POkyWso9w3n79iADPHN7mvxG3OihyBFbBN4/fhd+bKpKP6pQ?=
 =?us-ascii?Q?mKBLZ9ZL8ykajtXo60U0i7zPTMWQ9RKwYOs5uwlsvraJtLsyz+I9JV065GyO?=
 =?us-ascii?Q?4Y/T2r5pRfhey43DIGQbkmbblukLB3DNm19w9m+WqL3ecGQAckfoJsjt/3Iw?=
 =?us-ascii?Q?mmts9Q5zgNIvxl8a83/yijsaaCBfWsOvTECcH3gXAQfA/8xmVCv+MlnbUGrg?=
 =?us-ascii?Q?UAcFeL0zvvclIlY2xb2BkRCfzgZiGG9Aw1r1iN8RBfI7Hp+/97DgzNfgewv6?=
 =?us-ascii?Q?1/U/HGiNxqw838Z9RZXzRKI1MGnJFXXDE8SdMLqIX1TEzlmNRR/UMsl9isFg?=
 =?us-ascii?Q?2oYqiBgO7CNNkPksLe7QK+db9K5DsP57xqKVUX/zlbjm/rHsTw2/WvdhDJXJ?=
 =?us-ascii?Q?PaNsbOecfotwjq2CNXq/ysLhTzB5AZNUKDa0EIoVz6ROKdskbSunA4DYyk43?=
 =?us-ascii?Q?VhAVxrU0/IcXG0tF6XedcDXO32NvXdjOkGXFSbR2xLKBlWWGsMc0Pwcax88r?=
 =?us-ascii?Q?WcfwhcG81lST71s+hbUrR0iaoe2HIkJH3cs5b3qrpngIyxnJYlTs/DVUSaS+?=
 =?us-ascii?Q?Tl0KeA+/n4hXAyojjPukb74nWa6oCUGAZR/OxaFncnz1+14CLz9A3mzDr7xf?=
 =?us-ascii?Q?SMN6tN3AeK7kZXd9NWv5rgdlIm0AR9YtrCHluAI1/9Np9bQT3Bwu71mKI77Y?=
 =?us-ascii?Q?jbYcU/ZQgh1DNsxNz2gOssX0FEmkKeHbDAF0EIcnOIkaPw8XIoGXzIWG6otk?=
 =?us-ascii?Q?B6G4SXHt4f+5kch5/NMS+2JWQVD3Qev+wL/WBLZuKsvnKF4cg3Bbfi/bvwyn?=
 =?us-ascii?Q?criUgMJwOg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2fe7f-7cf8-4fb4-f4fd-08deafd5e462
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:23:53.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWg6I/t6ce8CmlBMd/YkozYf2XqHEv9f8aiHpz2XKMXX9Y4Fu2GWQJqYTmcQyyLe+SNg1O7TWl/L7Y/MG5YC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11236
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
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/net/fsl_enetc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 206f1a381bb..b07193e4e83 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <pci.h>
 #include <miiphy.h>
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/build_bug.h>
@@ -396,7 +397,7 @@ static int enetc_init_sgmii(struct udevice *dev)
 /* set up MAC for RGMII */
 static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 {
-	u32 old_val, val, dpx = 0;
+	u32 old_val, val = 0;
 
 	old_val = val = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 
@@ -416,15 +417,14 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
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

