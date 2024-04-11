Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85024CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFC6881D0;
	Thu, 11 Apr 2024 05:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cMLMfvXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64541881FE; Thu, 11 Apr 2024 05:23:13 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA75881E7
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9DtXa21+am3ElJyz10wPA80g7AR5+DIJ/MpTWo/nnLIZv1d2VcNvUXxoqGKpPhMg7sUQa2nADDln+9wuNXffbfxKOCD98a9PiR5m8I71ZiQbzeTVuns/gJsLTMr0CcBLKJ+NWQMkbfLoBuHcxmSeO4CMplYqQRQtQuhchhdINTrvhk+dlFYhhK00BBbrriXYlrisZCFxNMeb32bAIq6/tQCAKGTdsTbC+3rDbalgjw1lv1asD1ZdTJV8oVnX2XSlljxWcCmk4zynuy2xLeRxBO+LjGjaaLpcl4TMc8z6baMFfkBNd5rEAQgeRgd87DKbXmZbV7G2UMq78rWzVUoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=kOSqcdU55JsCxQuI1hkej2gDmszB0xyLAYf2os70VNX4yZ0bnpBsLUQPUzLNwnb3X7OO8YwC2Ua03L7df0GP6kKHnwgQ/8mBuU/ZPas3ASvab0kPbCW9zSU4gGLpliSh0nWqwjmMdRG3c5auTJtFvdvBNTBHRwq1egh388u3Ivsd/i79AnWcasojIYPchmeotikhrWmw5cw19JwuWE2lRirdr5Jo8u7i4xJIGeTdx0gokyk4FmhVbjyq1pmE7JgqyLS5AeGHlmsN65i3kGg5fEvGhqNow3jUr+pYkNhIGiz2Ybrs9oxveydHu+0hxjYYeXy/wuRMylQkst5TXILGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=cMLMfvXvRxHHMFtGWSSaLHMHI5yTRYRUcAqSiZggMeLVjra+lmpWwYyXj4v/dvHfCOyuIN46ae6zTz0uQbe56XbL8mXVtfoJvUDnDxZV0HDJ1/zsZad6qGunOTi0Ddetp4VpZOkoCCUpBuEa2fmdovCN10N7EXzTWbjeJqlq+AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 03:23:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 11 Apr 2024
 03:23:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Apr 2024 12:23:02 +0800
Subject: [PATCH v5 4/5] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-imx93-of-v2-v5-4-9eb3c64ff160@nxp.com>
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
In-Reply-To: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9143731f-cfee-41e1-ae9b-08dc59d6b690
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCEM9mPvu0xvj1qDZl4y2Kd+B7/mXCZwyhDjTR+ilcMRc9ddjKPXz8s0X1TnLo7gZm/411r3lpudKsHYz6RgS36FHXBb+9+FeQtNF+JIn/7SuQ1mrS5SUNRcy/KtfqIx1KRoYm6nMWjRgmfkDy0nOAKfLe6clHYcVYOO8QXt76+/mit+ANW5d6pRUIZu1fmJ7urYNB4Z6RCqYM5HlOyND/IVOUkuVSI3yEhsV1wBae/Jvq9MrvNrF+LkOqm+uk/N2yRgMGbhtSGyA6zVPkld0qICdJvyRPoX9+ySb/mCNVpCYtgyuYcf1WobA1Pgz2ud79TeeqEoxk//kEWzVY+HvNw3YGtWm8e+FW00sqGfUNlpxuMPKmLXiaui7GBwx8eZB3IbR6kce4r8HHGdtHu1m7fBCxe1GQ2ACTgQ+5gemSeFIxpaDlwFRndah64f5n0tb1tCtaKXzRQahPdxV0CI6TdFJbkORBjcjPrJRbcz7I7c+fmIr1eleq1BqtDTYAGjMduh1raY8oCMEJbz71MidXXh1YTJFHlWfTuyorbs0rYUoukYTJ6RmFTfQJ8NndYM9070ZoCSHV4iHdf7sDG+4cKiSXIqb/NHoVKb/rYK426DBtqsgSC2U9eeLVoLkqf7HvaQDacWfSUNsVL9ysOGlD2HfOP+PnAKSIm5CouGxqoXKumM/vf3LkKPtUoPpQSQLMdD34YY/zUJxD95mOnQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnE4enpCdGJCMU1iblFlMFp1d2tic3BpM2NRNVNMUEd0b2IwNmhzRS8vYjFI?=
 =?utf-8?B?R2dFNWk3dDhTcHdGOXV0WDkrODU0Ly9GM1pwWmFyU3Z1THV2cVpCb3kxWFFZ?=
 =?utf-8?B?a3d6djVCak9tNVdqV0s2T3lLYm85TFVad2F6elgrUzAyWWZuNGF2N29LR052?=
 =?utf-8?B?S1NuTHJBSTJJc0t5NXp6bm5FOExtOTVaUHo5azNycE5GTm9IanFCd3lBUjdY?=
 =?utf-8?B?LzNJMVZ0djkyeDcxWFg0aXppZEdsVm9obUo1OFc1SmsvTXBjN01EdzJEOEdB?=
 =?utf-8?B?MUxWTGJCY0ZJTUMzM1A5RFlRaUdrWVE4aDk5MTlGR2lSaDMvQ3l1UzFvVFJL?=
 =?utf-8?B?SFB2VWYzeEphM3NFMEdYRU5FYy85NHZyS1pjdkdxMFBqZlhCbXJzckI2M0xR?=
 =?utf-8?B?VFM1K2lZYzdaQ1lsZmZvMFlkU0FXbDFUdm5UN242eWM4ZWR2U29yU3FRUGFE?=
 =?utf-8?B?NlVjcW5tMCs5RExNRjYwYXdVOElIQ3VMUXZUeXFMQWZZQXlHM2ZYYUpmazFr?=
 =?utf-8?B?S1Q4MWU4NHQzK1M1Y1lya3JCanpwUVVMZEs5aE02QnREQkNqeHpGMysza1ZQ?=
 =?utf-8?B?bldEVW1sK0NtU0tZSnphVjdIM2N5NkZ6OWpoMk0vYVN2ME41SkZ3eHl1bXJs?=
 =?utf-8?B?V2ZhcWVrUDNGWUpFTFFFbW5XTWh0dnZyL1g3b1EwY0JrNzEwTjRHeENGejZU?=
 =?utf-8?B?M0xyQzhTQ3VZV3kwcDh4K0NFR3NHWFhibzFBU3VXWXp0Q3BzQjlpVkxiekNR?=
 =?utf-8?B?N0pIOFpQUnFyalF5ekJ5a3FzSEkzajkvM3MvRFE4SjAwQ2E5TWlyMm1jOEdo?=
 =?utf-8?B?U29sbXZ0aWhHVWhHZGtNQ09GckxPNFRBNTE4dFZBSTdjcXlBc1NIeEUzOElY?=
 =?utf-8?B?TGZ3UE5TcDNBUE9JZVZuQ3RjdnIyNnBaeEpJTG0vWHpRMHFzSnA2TXdzS2x4?=
 =?utf-8?B?Q2FXdERuVWdtRFhxVEVyNUV1NysxcHptMWtvU2tQT1UyWmZtODZRT3NaT2Zm?=
 =?utf-8?B?ODByTjZDUFhST0V4N1AvUTR3dzZRK3Q0SmpEdzRVbzlNRzkwcDVxR3k5NWNp?=
 =?utf-8?B?RCt0T29QZktzMFRRZW5GbTltN3plWDgzYVNjbkU2bXcyRXNOU0NaR2ZCbHlQ?=
 =?utf-8?B?WUFGTlY2VG5MNXNTWVBYTm91M2xSOGJlVmVqcVFXQjVqNUQrbWlkdWhHU29h?=
 =?utf-8?B?SGxyYWJqRzM3OGRVVVozOVVISVlTMFh5UVBONlFrU0JpeG1PZnFNanR1MWQw?=
 =?utf-8?B?QzFsOFRYdEwwR05yMTVhZndnQU1jeXY4eVMwclBTRWtBSDkzTkl2TjBLeDJ6?=
 =?utf-8?B?dEp3QVA3d2N4bDU3YllSTVNWb0RkMU1UdVpDdTlQakZHZUlKRjdtNUZjQWpy?=
 =?utf-8?B?VEU0aDN3c2FOcmo0YlZaN3JuSGh0SDFsMDc0b1g5S3hKVUk0K2dxc1ZtTFp0?=
 =?utf-8?B?NFBzNUJqMnlibGpFTjM5MFo1ZUxoalBGOHE2NjRJOE1SSWcybTNBNTNWQStq?=
 =?utf-8?B?VFcwQUVNU3NVTk9mekRXc0o2blBsRThQN01oYlFNN2g4VHpkS2oweVF0dnZO?=
 =?utf-8?B?eEcwdXBTK09kckxFUnl4UFZmRGJSQzY5aDVSTkdLY1FrbnROcFhTRXlmUlVo?=
 =?utf-8?B?dmwvZEpuWE0xUUgrZ3IyRUJVbHBybkJNcFp5UDQ4Q2ZneUttMlh6QTFKRFJq?=
 =?utf-8?B?cmpOQ1N5T2NVNGxWMTZSV01YbEgwWGVFbS9GSTlVS2srNUxOMkhRbDAxS1VO?=
 =?utf-8?B?bExQNVZnaU5QSkRNR2Jqdk9DRnN4d1JSQ2JMZi90THNQOGkrYmpoTkZOMFMx?=
 =?utf-8?B?Rm4zOTY1WXdldk1IeG4wbW1FdjNBNWo1YmVwRVRqZVFNRjQxa0E0MXFjZ3pJ?=
 =?utf-8?B?dVYwcGV2VUFSZVF2dTkwWGpxT3N4YzV5d1J5MWJMZnQ3VFhvZ1dwTDJ3eUcx?=
 =?utf-8?B?K1Z2N0hmREUyZCtKemJJZzhMZVRobHd5dUtaZFkreFB1ODlFbVVvL1Ayblli?=
 =?utf-8?B?SWJDd3F0V0hPSFg5WldFYm5WK3dzK2ZRalNVUm8rT25rYzhWTUZiK1VJcmxU?=
 =?utf-8?B?UzFGanVhVEZFTlN6Y1NUK2IyU3NVa2M1L3FlNlBtNzVuMVNWeWxNeXlESlB2?=
 =?utf-8?Q?wTVde24lqF2gLPhCzDlMByw+z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9143731f-cfee-41e1-ae9b-08dc59d6b690
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:23:10.1699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9yKUkCP612tYasgGPZqRV2Oe2/DuykVqWcKhAtUobhn3SHvYgbQ+ZoCIy0/0ex8E5OrXTUyT3rkzjdtGtuqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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

The PLL clk needs use anatop base, otherwise wrong PLL address will
be used.

Fixes: 9c153e46661b ("clk: imx: add i.MX93 CCF driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index ce10d795316..f0cb797d975 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -289,7 +289,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2_DIV2,
 	       imx_clk_fixed_factor("sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
 
-	base = (void *)ANATOP_BASE_ADDR;
+	anatop_base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX93_CLK_ARM_PLL,
 	       imx_clk_fracn_gppll_integer("arm_pll", "clock-osc-24m",

-- 
2.35.3

