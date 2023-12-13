Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD56C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1F187579;
	Wed, 13 Dec 2023 17:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NlzckIwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F538780E; Wed, 13 Dec 2023 17:14:42 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD6B877DE
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=radu-nicolae.pirea@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuaBxtMhh7oLsEd4qEIbgKlFCPOMy4yAJwy8Wxm6Y+C5r6YANnNkkBUmvrzrMEjKrkHxb1dvapvJTOJKUG79+K94iZdaVRMlW1nlpbR66NeVekXRS4IyJxca3yb0NCWXxV+TFzvz22aj6AydOnKKdW40BJQzti6YKLabeZgfdeNeobarRxTHpT47x9NY7TG1VLD/+456kjKy1XOf3n3XMH3KTviTWp+3/+jJQa3UtLWjVbII8axhip5BsPr3CF+M01vAgwtLTzbXOk5S1ybleZBORLqzI5gvCTjc34RhQ5HH2y3DW6XBPyeKn+N2Wg8WlLEkVitWcBWP9+xbIv+xXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIk1jqt0Gmx1UUZX5ufSFhHur6ajZOVBLHUJiAnKVf8=;
 b=lVtUrg7juajpA8qUskhsqLB25ifoSXRTNsnnzZJTX8hYAygSvRVkfn1LtOvNtA+m2sqkf6aZqK2yF7gpxnbINy6tS+YLlzXFGORCnNWBJABr8H5CK1YSypfBdYSz4NVmVIIk+5j5bLQAq0vmddY4D/3OW/9okBC2aR1JX6uz8Ze9OZBcaZlnrRJtVcQyT8fc/mwfabd/FuP5QZYusLJ3Wk8gmiTIbowHLDE0sk3a3b5Y1ISO7A8+EewTCxW6ZMTzYzsy5eLaCIx8UxRUayP9YBEcbfesFo+XkxiBGPjpM5f9aXNd9U4j7Bd11rrtY4UHycbypIIhdyqs880IEGRYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIk1jqt0Gmx1UUZX5ufSFhHur6ajZOVBLHUJiAnKVf8=;
 b=NlzckIwvIZIRpnSCvmFM2omWU/7mxklFQUxB6bBROXpZwUcuTFJwdBW7NuJvZM9N7Zp9DR6B2diGcNrXqiE3h/m53RlH8HiWgZ9xIHCca437Dg9Q0tSr2oad+0pmdWRYDXCajuXo0T8i5dehvFKsZzFDDTEXRBA9VzTO+FUDNQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:14:38 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:14:38 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, nm@ti.com
Cc: u-boot@lists.denx.de, andrei.botila@oss.nxp.com,
 sebastian.tobuschat@oss.nxp.com,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v1 2/4] net: phy: nxp-c45-tja11xx: read PHY the speed from
 hardware
Date: Wed, 13 Dec 2023 18:14:21 +0200
Message-Id: <20231213161423.258870-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0077bc-e627-4f80-415f-08dbfbf69afe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0PYiOYaQmHX3CP3Q8Bi0GwNC+WM+wzYmP7dVZO0I6xbuimQhcXc+1aJ5EoXq4a/3sz7rJwyu2xQczoo85zPReNLt71Jg67Z2ZtP7PlRKp3rfJQ84niAq1yd3UW4BjVL0quZAvxjxEr8kO9MLkLdkp/7Ga4geX2MxCJp2QdYGxXhYdSgbCrcKi2hj+byMQtytfWtOKQ0Jgjg9vCq7RkJ+SKX2rAbIbFIzAWvvV5SSA0ubFSp1ankwwBh3m53RjzV4Tg2qDiTDm8VbGuf0J8tbcpiLYdVzw/YHszYCu59+hV84U61nB052NEfaHFz10NvtIGtzppAlkqdueZbu+fY+YSBDQWkxADH+upx+yAZD1VV0fDa8fTG7uUtOlzA8Td06YPQUyIl4XcFhHjI1HmocjjeBwEePOlAHDP75yODKLr1T2BYjxnog5BHVcUFt9IL70bHaqeE7adOypbfia/sd/zHf/cqp+wGwbCm0tUtA6Sx2sJ64WKlLRhRbp55KtSXfzMBWEANlVfw6daTBTUc1Llikpm+1RzFsR2n+jBnPV2mEwqrqBuovN2Xfa9mECP6GhERked5DISAka5Bperf3B7DBFI45lhMxRdS14GBcbIkp6HLJjAGR5nmG6iIpc56
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8954.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(38350700005)(83380400001)(6506007)(2616005)(6512007)(1076003)(52116002)(316002)(6666004)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(38100700002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tpbRiMqQwUIFkDpqbLwTKFdA8aI4wl8RdOxAMd/I2sWtcVcFTUU/Y59tH4lr?=
 =?us-ascii?Q?05l82BgZHsLybWllNevmekyuv2XZgzZOefR0Q7OB+N4TvYRKROUD3Ueoqk9J?=
 =?us-ascii?Q?9ViFKREXVlt2MQqFKn81G02KbtW66nYOO3wVvjcP8I+cy4qxfSknTLXT0Feh?=
 =?us-ascii?Q?M5OvCfOLn0MzYCgC/+cuLxjtEf1czqF+c83icectqjh9bzBFiRq538IIKCky?=
 =?us-ascii?Q?BSAAnHEtusLG9ERrCm7H0ANOHhx5GT8EPDBdqb76vteNGM5pXzgvurLyVKUb?=
 =?us-ascii?Q?hnRRsv0O/fPIwg/gZZOOGIOquciPWYvUCR/ToaeJHt1CPB6DhtlOxJysWBbS?=
 =?us-ascii?Q?7H2P3nOy+wxhynsilET/yE02GrQayZ4QK5UawVjx5gGhRNfOnza3lpEQ9MVF?=
 =?us-ascii?Q?+PLFFcr4p8lpu+QAhk6X0GuWLmtkQxNR+Vjp75+dpQWAsHct50md4IYVrOKV?=
 =?us-ascii?Q?I3W5VeWUlKMdyFYKwwTg5brrYQ8hj7dSshRwUBviFtuxGjkZUVslw5K1Fbhm?=
 =?us-ascii?Q?sQLptg3dDabgoiLbdtNplSt/iCL/rFMTSM/vxZV8iMYCgkxk4oLPB66KtR4f?=
 =?us-ascii?Q?d8eGQe2ujNLj6t4VY+vtCsm65KEabBfy3U7u4LwxITg9r8fCqigNVT5gj784?=
 =?us-ascii?Q?rEinWVO6QRlX2KVbT8iQKr8wbgOKu7EjuCfRwfGsSxrRsq3A3s+/gffuSx3P?=
 =?us-ascii?Q?tPz1N/ry7jKOlgZu2ayTjTDPXdgpb4l1c7Ve+5OOv6iqdgeWlC2P/kENSEj7?=
 =?us-ascii?Q?QtYkwP23cFZ/0FF71Z1r5uLpxzKNY1YnkabjMM88iVmHexXUQYrq5Sy5j1Eo?=
 =?us-ascii?Q?LEU57i4+uXMzHW25tG9U9IIoNEbiJZnWmkro6AES9+SYO31MwWs+FbJms2Df?=
 =?us-ascii?Q?tHs0tb3IcCd2x9RTAPxF5E0GzFLJQR9DTY8e+z8Oi4R9e+JjAIz6U4/BegH5?=
 =?us-ascii?Q?tWKZ1emYLvQIilncUyFI0RQuCytoJI23A0e1wIMtdwwO7pfoXq2BwsTdKD5z?=
 =?us-ascii?Q?NvhEEwL0bO1P5KyW5NwN0sRAsL+G5Mri//3IStGqY21RSWCp9onAWMlVX9uo?=
 =?us-ascii?Q?/OqWoikCDCaD/lQQrPdTZFw1fn4nGH3ajw3UWyrK9QsZy7YKMokaa+RnHTAP?=
 =?us-ascii?Q?A47r8GyotgCsK55hBTId81DmHfd1qucLMVL2mECe4G06/vWRr7RhnmLRBGgg?=
 =?us-ascii?Q?STPI0Uz4OokQdpcrS/YXpwpVq5fTu8/yCTrWMf+PjTD7DuwGeAp6WapAMtKY?=
 =?us-ascii?Q?crGZNXD86wt3+G1In4wO6gf6s9ePAGnpV+BtVkWhVFQipcNa6wZFa9v5KUMi?=
 =?us-ascii?Q?SBtBBH/jruK/Uq7Fr9u5pLtcojTLmc855ehNlqGs2WoZ6Jxic3NP6vok8jpl?=
 =?us-ascii?Q?7UvB898D/wGcJhOFQHNjaQJcILLJknAa29rNlikgsOChMASr5YGD/4+7PdAd?=
 =?us-ascii?Q?WwQzUazLK4TnAjNQ03iabJ8v/9w2XvSc9lPCRpYPG7MOrFtHkgmrMO+0VTsW?=
 =?us-ascii?Q?m3uvtftG01n5/pxtD8FqyWbbPAJS18uJrCaHIV5VSWJZmNnBZEtVRcZcHC7T?=
 =?us-ascii?Q?4+utXkJCsQ6PVr4fe2l34h5sEIGZh5hrOMQDFEYRBEhc8lp3bzI1rPt1+7It?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0077bc-e627-4f80-415f-08dbfbf69afe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:14:38.5557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebuPjygj5dmv5rSU07IXoPt0W9tvzxOsUiW45q/N4Z3Xj/lhjmJiB+NJmXK/DltNLedM7LNDRjbKLIZZKYeJeeZxMrM4CbiKCg8/08n/7v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
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

Read PHY speed from hardware instead of assuming 100Mbps by default.
The TJA1103 works only at 100Mbps, but the driver will support more PHYs.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 38fb38b9fb..27d871c4b6 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -306,13 +306,33 @@ static int nxp_c45_config(struct phy_device *phydev)
 	return nxp_c45_start_op(phydev);
 }
 
+static int nxp_c45_speed(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_PMA_CTRL1_SPEED100)
+		phydev->speed = SPEED_100;
+	else
+		phydev->speed = 0;
+
+	return 0;
+}
+
 static int nxp_c45_startup(struct phy_device *phydev)
 {
 	u32 reg;
+	int ret;
 
 	reg = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT1);
 	phydev->link = !!(reg & MDIO_STAT1_LSTATUS);
-	phydev->speed = SPEED_100;
+	ret = nxp_c45_speed(phydev);
+	if (ret < 0)
+		return ret;
+
 	phydev->duplex = DUPLEX_FULL;
 	return 0;
 }
-- 
2.34.1

