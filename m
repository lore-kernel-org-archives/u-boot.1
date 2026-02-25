Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FACE9B25A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F118366F;
	Wed, 25 Feb 2026 06:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZuCHbChX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECECB83946; Wed, 25 Feb 2026 06:56:58 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B33CE82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE8ybVMYKk8tfVw3HSkWJq8ReNLRXHuUUt4pZtytCBxkD6on4eP92t+OhtbMZQo6FdyYWOAQnSFuJgH4WK04ISD1c+AAbFWJAy3q4I8Yyc7iy1rzY6bkpVG3Td/95dhgy/tgskcSGKySLHGR5tpUPf/TQ8of/9AFK5KEnMmrz/2kxOfldbDGz4XECa3NSnlctOAFF1JcHAeCt47LC+wLwqiNVZY6eDkUQSKdoyzvYgIMws2OqGcB7wM/DGIDYZMX8TWU5K6sr6gX/4seMQH4dnvHgsa9yFsd7xlkub5yy4x+dMn2c8S55oNOAw6jHDb5fwnI1N+zxC463bZumPo7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05zm/Yn5z17AwTvJzveIdpeizahvdwLUAYws1r9WArQ=;
 b=Q2+D6UZbMKyEaLcKmDIM0dXFK8dAZkOVnhRZMTnS2jtw9CDXL3X3kWShbuvmY8yHp6a0FZG7zd1B+XqYH3Mv0g2dmKf3CQQ8iSxq7NS1daAC475Y0rNjaVUS/p+SJp6yNwQ1uM1UDvERDDlf1qPN5sqjSlnRau6y0mSoWHJQKsCClI8bfHgEqIewPrT2sc3vrYc/KO+/bbTqVwqzEQZ+eN6WF4UdOvk+pxEemtbryb5lRGOxJG6G7oW6FiQ+XLqOiHCcOBDE7A2c09BJJDW56/8s0fvXB5F6/X3QGw5O8e+Zvs8uUKNxiVdvlNFR/10AYC0dZUnW+y4wDHis9v+dmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05zm/Yn5z17AwTvJzveIdpeizahvdwLUAYws1r9WArQ=;
 b=ZuCHbChXdDn1cp7e4IT5rjhvfubC3FLelzYdePKEpE/NZ4dHwOu8FUx6l0QKsBVuI6eaUA/SzDHqHHijr2FMJZwkkzc0gYJeqUe86OvAUfkCTN/xhirWjyZWh10f2AQRooxWDuKiFW9XwPwrHBkxiO+EM9aMC0NXz2vRNOYAdryRfh3a8Kdau2MgH+vukemytvMSxW5e5E/9ekG/2j8TP49H5JkQ7erOVEZZentY+5x9afKGipQXCA4x+0ufDaJW4ZfG4vRpD+GpaOYPp0dH/yxRrF4TtBS+B4SRt+J8HOHwqKBUbIoQ/PiK/pkx3BGs5R6Si/4rMrO4huqsbPMSGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:56:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:56:53 +0000
Date: Wed, 25 Feb 2026 15:12:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: mtk-sd: add mediatek,mt8189-mmc compatible
Message-ID: <aZ6gwSLjH8IYY_uE@nxa18884-linux.ap.freescale.net>
References: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc6e17-b630-40a5-5be1-08de7432ac98
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8qLZSJ49WiT+tHWdOl5gTXTEoiI5u6zZ64dH74XUt70taUhtZSI8HFX1We56?=
 =?us-ascii?Q?wyp3yjFXUvTDWTiyLE4+qdIv4gtKvBIMThIm5b/7hY18xQEDZsmmQKkrdeax?=
 =?us-ascii?Q?N4s97TT4YXmydK4vjYrZiiDGzknjtQAU4OJVHnm2XNHnMK+wdkJmDY80W4o1?=
 =?us-ascii?Q?4mtaHcY5cqqPvOuoyqptXiZaWfuW+/Uy74VuAhU370SsTff3IFtb7c63Yl9p?=
 =?us-ascii?Q?qTqYqEzHMPpuydTCEpyt4tIfPnj+Ly6mMsHj+lrqOiF0uurXb711HKT02KUY?=
 =?us-ascii?Q?9Om3D6XdQJSCtMD0OyjzJjTif+jJuKt32Q73SeAs9EgLYlvGPXqTEAqU4Z6U?=
 =?us-ascii?Q?kPg3laashCap4V/Tw5KDI1iTsIKUKWSuycMeKhSk55MWnSgYOd5tnoWn3JH9?=
 =?us-ascii?Q?GqZ42/JZISJKbxrYSC8jq24LBmNEOKhvJgECKm4MsDTEb5d7P4Y6QXE6Uyq9?=
 =?us-ascii?Q?LxzCtNUSG/H5tIiYSECDpB3swW1mur/cAvpnI9V6LpWr1UyNUwFZBcdspvlY?=
 =?us-ascii?Q?RUGxMBInjmSlbBtVRpwVCVaj5otRk/aOguHcUowpH6/rd6C6sliTHZH3AESB?=
 =?us-ascii?Q?6vgzyQtnsc6qpTPDyxgTtg7MywvVvYeD179s2T7CXXWmqT3xYLvIJXUQnIKL?=
 =?us-ascii?Q?QRlW5i3+5BuZPa475bxRmt60Q71F29525svUbFOZUc2b4Fn4Y2GJeLm4dMJy?=
 =?us-ascii?Q?cUTq7R0TnSL7gT+kLVhFY+fkjhYRVXfMh5KGXKtPXgykb/z//ZQtednfkN7S?=
 =?us-ascii?Q?HyzO9rGOejAFT7epriYyS8v3vH4VKik/ZiSlygioof/v2781z4b1n3jz7yk8?=
 =?us-ascii?Q?cz8kBi+I94PeFCu/XOmSOELdRPM2v1npDYfFnY7aDrooMsCw1NZpV4sCXnIu?=
 =?us-ascii?Q?Na6ZY5iTNGnNx4MxiNawJXzDgV/lfNBtc0L023ZFJFX03zIMA+JIcvf5vShl?=
 =?us-ascii?Q?AGUnHoSAWEZBNILVy0JXA8K05HX0RL+TRMQWgFyZt/L2BqHUdzJk+UykSGT8?=
 =?us-ascii?Q?2JH/DN9Wn7SzXQuLGwyKYwlJa9YLfXxGc8NB8+RERXgla84FegURg/SjeIV7?=
 =?us-ascii?Q?tA+zOpKmw039scGE+CMMISKgY98yiMz/ud38Fd3hgi354FIoc80keLsdd9qQ?=
 =?us-ascii?Q?QPxXoy4S5e3OiNCv6B+cBCXJtXB+05uJPRUpMpH2agBudtZ7MOqReMK8AftC?=
 =?us-ascii?Q?RD08EjON/iVw8gybE4pxEj4RKAXOqACFajpau9GOtTLCBmmiQUVJtIayd7JY?=
 =?us-ascii?Q?rwnMmOTl0TwE+1AMJLuN43rRuVmhXQCcqE6Q5K1fUfnxRenvFKaD7z0lwC0O?=
 =?us-ascii?Q?aJZGf+702uDKcLRcEDHppzZLzE/oQdRyJoZjUA3tpAy+1orM7gYDeZA1AzPI?=
 =?us-ascii?Q?NUgZUj5QcS9X1VJZf91RbbUoOSsDq+b9DeQBLWq4DAmyk/6r38dWBtCxbapJ?=
 =?us-ascii?Q?y9adr2W9pQ2rGLmlknXz7xX4BUJcHtI1sB5jKuaEIo9p2r2stk/DiiYiZ9+W?=
 =?us-ascii?Q?5T+6VxKrqW+zR2gt8ivCKcm/LZbB0do40/PIzeD/kMRZAlDTq/d0eBTgJugU?=
 =?us-ascii?Q?XaIVCEw+A+zGDnRixJhlw00A3kmZWWW7Tc1IoFmXgP+KWCN+YI1NvLks+PO7?=
 =?us-ascii?Q?/hdJ9UHk/2lYCmPNIW5NL18=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(19092799006)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/OdoUT/lzwtR9d0iYxmZ/GnOhjexewGN9aOwLPnl/ksLoADpkyR9YxF2uWJ2?=
 =?us-ascii?Q?z1ZdlK9eNF1dgPa7GLNr/Q7vmUbI5j3FakS7CfYcT0Tw3R+JtejJnX4/hX8j?=
 =?us-ascii?Q?KxlqR4TZx+qgSj4SjyOr8WLd+a5MHHIJm56WmB1ywVfffMAx1VYVNAelIRUD?=
 =?us-ascii?Q?OpWgb6cPIfgRw51Bp782rDcJaT29e1TfekEy+JTGrp0j/pMXZpRajeqpQk0w?=
 =?us-ascii?Q?qe5tSigrxX8Xh8dnBwPP31aXN3fvipOZ1uJbu4Ur84G9mLgA2MruQ+20z8vL?=
 =?us-ascii?Q?borWuTP/JwaYF846OR9GerHGiZzldNOWOyLNKj+1VMYmvt99zzWD/jDO+HJM?=
 =?us-ascii?Q?GcgRFQOKDoSQNn358ExU2Q7hpBpnmSVm+bk24yyH06uVZ6vmtHOgaefPBeOU?=
 =?us-ascii?Q?Nzu3b1dlJ+FCf1OsxoBHIOUjlyEshZ1PBoRsgWRAddAlGLK2oQC5Zc5tAsoo?=
 =?us-ascii?Q?ydvzzhOyXsqoIa2nIW/2L7adXRldRkZ7mzpe1Gaxla29T8eWSjYLhGC2m099?=
 =?us-ascii?Q?Y9MryZPcT9dGBJETAlfDeoNslqiEiitnN7XQqU5H62cbd6yhaLdeqqPXO2xz?=
 =?us-ascii?Q?j58HBQSrEB0m0kJy2KLaMyre92XJJl+cc2XgDtm07xZrW0ywUmGzyaF+3K1t?=
 =?us-ascii?Q?h/6zPdMs6q4NBGQJWQjmiksQVtfySVmxD8vqyrzHVipoBrYpgeCWKgrKvQhA?=
 =?us-ascii?Q?qZhinH5tSsVQzTc1ExixNSxKuY9XyfIHOC4FcsHpxJfQUBvj2DfYauzpcYwb?=
 =?us-ascii?Q?+yrbRr7yfYpAFIDrcSh9l7im51HXLl4FJtSdk6gP4FE52hv5N2A4RE/vNh/R?=
 =?us-ascii?Q?zP4Wr9rixfiwRfzZwkGAk0uVbrGuxvDIRcv5pmr+U6HA6JnEIrDQ3FKqWW4b?=
 =?us-ascii?Q?4xnb0ww9GafxwjRRKXXZHvKeO8odZS3KSSV6M+8cHz1Esam2ok716HXj22uq?=
 =?us-ascii?Q?D4L6SSXLA+H7A5SpUl2TKfAGHYK5y+Or7kcIGWQbajtoiSLusaWsCPKZ1Xso?=
 =?us-ascii?Q?e+Jx5f9QFEjxERZRskLbKPImS3mkXm0YGTkAhS6KL30MaOCKlZ6PEDfk8R9G?=
 =?us-ascii?Q?ObB3v1/oRz8sOuWcpMrJYF68rVoSd0UAKfluGc0F121K8j8vb+lQPT0TH1YK?=
 =?us-ascii?Q?QOvcCP8IMyFQMrk6fgO0oRh+ZLiElupMMRaV8vEzXEo0qI1hlNjAr+ZEk7UE?=
 =?us-ascii?Q?QY1L24oWM13AwioNoE81Yw7RfjUpGKVXbNABfVmIYYEv2bHaDb1F2ekfrJrc?=
 =?us-ascii?Q?igUYiJ70QtRHsRB6VHsRO0yHFoqT/hL5MdqLdw1ttNrt77ZU2j6mMIbx/bmG?=
 =?us-ascii?Q?K4xB10LgI7Sf0aQ/NYUqRcfmSiR9zbjQ6ibn+IR2I6KEl2VmgcExtBYB0P8u?=
 =?us-ascii?Q?7swglvTUP0atbg5FOktJV0kDikzDuJ/zHB/k+JcDYJV3YhajrSHXPQGuEKFl?=
 =?us-ascii?Q?TbqM3z/6cj0rt9BbCk0cXE4ul992/hKbFHt6DhH3C7P06l6DGdM+lvhduwSr?=
 =?us-ascii?Q?MFoC0rA9BXwRb7Dcw22FDY0Afu8inCkeNHqI9kAQ6jQY13frLrzLUnqwTcHk?=
 =?us-ascii?Q?dc/kP0OcVoetM54GcpuD0ZgW33iblmMyKJIrC3Rwre6I3kS0G8aLjc2bK2m3?=
 =?us-ascii?Q?QmzkN4ceKdUmwC/Y+Rqq5I29Cxfa6TSBMLkdhPSV4RxY6qKmV+y3np3JEWn5?=
 =?us-ascii?Q?Y3mo0vf7lrtPsYGsCf0o1IqyrKuARXWNgrDLI2jet4ofaR33v5KZ19F6vmeh?=
 =?us-ascii?Q?t2TKuOeYug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc6e17-b630-40a5-5be1-08de7432ac98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:56:53.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9eq0bSo/eDXuV144TOeA5wg7bE6YT0LqGH5L3Nig0hLBWHNavYaEO1Ox/EBKCBdEjeVvSNR+ZLjJN57BvPCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
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

Hi David,

Thanks for your patch!

On Fri, Feb 06, 2026 at 02:50:06PM -0600, David Lechner wrote:
>Add support for MediaTek MT8189 MMC controller.
>
>According to [1], this is similar to, but not quite the same as
>mediatek,mt8196-mmc.
>
>Link: https://lore.kernel.org/linux-mediatek/20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com/ [1]
>Signed-off-by: David Lechner <dlechner@baylibre.com>
>---
> drivers/mmc/mtk-sd.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
>index 4928a880038..7a4bdee7496 100644
>--- a/drivers/mmc/mtk-sd.c
>+++ b/drivers/mmc/mtk-sd.c
>@@ -1979,6 +1979,16 @@ static const struct msdc_compatible mt8183_compat = {
> 	.use_dma_mode = true,
> };
> 
>+static const struct msdc_compatible mt8189_compat = {
>+	.clk_div_bits = 12,
>+	.pad_tune0 = true,
>+	.async_fifo = true,
>+	.data_tune = true,
>+	.busy_check = true,
>+	.stop_clk_fix = true,
>+	.enhance_rx = true,
>+};
>+
> static const struct udevice_id msdc_ids[] = {
> 	{ .compatible = "mediatek,mt7620-mmc", .data = (ulong)&mt7620_compat },
> 	{ .compatible = "mediatek,mt7621-mmc", .data = (ulong)&mt7621_compat },
>@@ -1990,6 +2000,7 @@ static const struct udevice_id msdc_ids[] = {
> 	{ .compatible = "mediatek,mt8512-mmc", .data = (ulong)&mt8512_compat },
> 	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
> 	{ .compatible = "mediatek,mt8183-mmc", .data = (ulong)&mt8183_compat },
>+	{ .compatible = "mediatek,mt8189-mmc", .data = (ulong)&mt8189_compat },

I not see this compatible being in dts/upstream or arch/arm/dts/,
so has this patch been tested with upstream U-Boot?

Thanks
Peng

> 	{}
> };
> 
>
>---
>base-commit: e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9
>change-id: 20260206-mtk-mmc-add-mt8189-compatible-6a71d5c710dc
>
>Best regards,
>-- 
>David Lechner <dlechner@baylibre.com>
>
>
