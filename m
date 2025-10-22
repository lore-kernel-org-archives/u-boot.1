Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA37CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35AC4838FA;
	Wed, 22 Oct 2025 09:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OeQt1Kms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7439A83303; Wed, 22 Oct 2025 09:08:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2FE82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNpZN7z2y4O8l8gOfLSSaLY0mmJaL032WEyFHPfdslp06ksgICvy9oGR3ZiNfvXn0FAn/eAhh1Dmcd0t/ooV7/uzVQb50rLpPeZEp4jQdZoX8L7BAr9BTiUTlsON6Yyt21QY5C6Bnbf5DYmo2l8qH3ulR84OHo0690+yaFH/MAstVFt8uvwFXEDedT1snFOXY8VWUkkvXp+xkAaX215qGXOQzdK9j5qa2q4s7DMx8Ix1U6e/mjJd3f0Eio/CdkoGthMuWi7bS5ylsMi15ruNuY2A99NQaS906z6pKJGbTUqkurm22Mziit8vQQ0hK2PSjun32KMcwdCtfm9cs4wIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvSIMLwy/JfnhdiIupK858z11oVGe8zFpzzGyF1gNpg=;
 b=JMs8cZfQ2n5yH3KgzDe6QOHUDdgLeXwKtxHhMrAlwmGeROj3I3dHzCnxAqL0iSgc55Wxv8/01aa38WFhApRxCtM19cjVPhXzRsYEhAdL6Ofmfp9H2wfYPhOZRnnw5is5CTiH6RbkPUx2IEzylL2XX1WweQGdfoS/+44n9itVpucrl4TWvIrKP6KtOTigidwqD/wAcIEMnbI3/O9gKhC+zPzqSagv6NMZF5zUPCOBsxxAVgPV4GrImHL34qXEGMs7dPq2aCTc/7di8Nc3mN6n7MrKUaO9SRTTFLR46bWy80kH3HpckUM+RSP9212CUqGS4dyDqUi/2YSjy7rWb1ufoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvSIMLwy/JfnhdiIupK858z11oVGe8zFpzzGyF1gNpg=;
 b=OeQt1KmsiHCXHAZVIyEhH4PzxYmiXF4oIWvlRpK7Y68PKuRCseiIk9Jm8WRBxUoag4l/ehQJCWhXMMFwyH22EZeQ7rqqtVL1tpHp6kXdqDgvGXEJF9yHOJSC5TPvldsY0k2ZJ/a6Jm/78dWdPXfX2a35gu1hD3xEAn3PEOFlY6pk9j4+NXLgdeMJjSxW0DvUHgcKvOzY9z0tfRLQ7P0WMPHnZEPmS1IaY17UiHLtqfm5bl/Hg24Igke3SiaW0kAmljcH9Ynh5E9GlTNR71E3KV0Gt/vTgnlGUSiA5MdIXLRkqq4Zao8sNCbxrp6Q+CfEbMKup51tEbBaDX2BpI9oCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB11879.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:08:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:08:08 +0000
Date: Wed, 22 Oct 2025 16:20:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 9/9] mmc: exynos_dw_mmc: add compatible for
 exynos7870-dw-mshc-smu
Message-ID: <20251022082020.GI30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-9-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-9-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB11879:EE_
X-MS-Office365-Filtering-Correlation-Id: 884f66e2-eb85-44b2-16d1-08de1139c0c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TrpeJ4d38BaSrtXFt8gpx4/R4Wopg/DsfwSi/x5KsuC1zRULjxT/b/xekJTb?=
 =?us-ascii?Q?2eQKynWfmmnae+WdOf9UVLdpvP8bRmrEmPaWsFEzZqVx2XFoCEWhJcaPen6F?=
 =?us-ascii?Q?Ioci+rFELakEJ8UuhIffP/ktZcxokt11oirHdC4e2BpbrxvA+Ftm+e5U3pm6?=
 =?us-ascii?Q?//fXPWp/ZgwP8q8UGcCYS6VB35LA3C4ff/h89bshl1MuVzf4OyiGhMePbfPG?=
 =?us-ascii?Q?SPrtKDYgBQlH9PODemge2KC3W836JL7ITM1iB4Syuhah90TsYTeZujcPg7v5?=
 =?us-ascii?Q?Zn2H4abV4NkAZkiUv52Y8FIucrVD2aIKPkJcn5J9ahlZFQwtwzf1jV9pFl6d?=
 =?us-ascii?Q?JKhUvbsDp5WBlGJuOMnrUiDk2c0+2LW+R2ylackR6m5DUkSLH6HAbcA3P71Z?=
 =?us-ascii?Q?AwOpw6Fh1Nl98Pko4xL9mI2ufbvJh8EiUBwE0PctAoxBRuHGcx2yLKVSVM9x?=
 =?us-ascii?Q?kj93hBzn5NrSzUlUT0guWkj6X0bIYO1cMkmUP785In6zgMdJ4gDTP3Kdbgmn?=
 =?us-ascii?Q?r+Ajx+15BCVH/LE7Y8AUaGXOST7XRAwYH2BcyUkFO+Bt1q9wgtPlw3psQ2pT?=
 =?us-ascii?Q?hiSgyxoJv6XeJST4/khDaqT8thwBBCa1PIEHcsF6l4G6uxgTDKQVmhOqc0Ay?=
 =?us-ascii?Q?Bkb7ratobkGZHApIPh05TtexV4Sp77bHKy8vuGUew8MeCV8DzboOFm/LkzMk?=
 =?us-ascii?Q?eNCt3qBOYbbfWU0qMbs4nMrZmuGkPtwN63R2HQ30HZzrKy2ftIlXiP+xFXaq?=
 =?us-ascii?Q?BxbhnNwmEW6RSU4S6Cn3VmvP2PPRDOnmP3DOTxdTeu9zEcBSo33p/RWlx1Si?=
 =?us-ascii?Q?PoXyzubCaKDc1WBO8b5RYlspO4SdQ053Dq053BVsxzrKXU4Il9iai8xHzWqU?=
 =?us-ascii?Q?iHLo8rpmv3dsYaCMuCWik1/w4tKoD6u6qaiLDaWPJ3k5bxmYBiTczDPDW7KM?=
 =?us-ascii?Q?c3eK+wNeVZUwibMVJ9Y3AK1SCkUw/JrKP1pLL1J5n0IJcO/g/6ENmqQsEngz?=
 =?us-ascii?Q?swxt85MLMVcvpketHpyDNy8rwattEQNn7gIxRG8gdWtaqjoa07Pk6qzE82BB?=
 =?us-ascii?Q?o84OozUMXDc2sFXPrkxXmh+p/eiQYfqbbdNd1gMHljOQIfjMyKU5QoWgcW9x?=
 =?us-ascii?Q?ObemF9rBSfLqDpEG11hv8LPcNNWDWJXi4W0drLOG7h/ruHUpTbIHnH3Ui/t5?=
 =?us-ascii?Q?4IpbOU/egsWx3RfJkWZI44cPcAOkSdMKwODpBPbJeFhxiu+8De8cSCf1seYF?=
 =?us-ascii?Q?MOTRV636IDWR1bW5WLlHYds/r75QhgqYxPIyh0m1pe6ukKae4BJau+TcO+Sv?=
 =?us-ascii?Q?b8t+TmAzLR5CMv8bxLOWiz74Zcpqb4VxI9C2kuu4jsmvWyA3hr7O6GOdd7rK?=
 =?us-ascii?Q?/vISA0lfE12iracxL/gV8+96qynA+sq5U/ZEfhojhCXG8v/l7333a337GoNQ?=
 =?us-ascii?Q?6We8VkekAX9xgNt6qRJdPRHU8c4IB1DvFNud3zwjfPF43d30hoHNpUe/ZXBM?=
 =?us-ascii?Q?dzOdzY1d8YoZso3uGs2EliZ2aEMEhVQ3QK+V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEqZhp69ugi/eKQS/OPeGmtNL7j21oy3beKqpnZQTc5hSI9gKWZ4w2e3jrQO?=
 =?us-ascii?Q?Xdhddql8O26PvBAn5PzxfL1IvBdqf8TM6Fiy0FuJ/p7AE2BB5F5Q+Rg+ZQrB?=
 =?us-ascii?Q?NJpYM3BrnC9eNAEFXAMMVrUguYpoJCWtJNh6oEKiLysLB+USbsF0MYQqQX2W?=
 =?us-ascii?Q?lKTqVe7XkudOGzWWAK9V1hfUUnW3xp3ycI0gsQNWuYYPfb+xj6Q/MFKvtuEa?=
 =?us-ascii?Q?2+R1NxQ0VZU28wDaS2GY0Ae9+vWzw2mnc+yaozAPV7roRgnbcv3VoEi4KfbT?=
 =?us-ascii?Q?V4JxfRlREjBJxoOUYcQKQBEousC9cc/PtRPTXnlfEOan2QeiWB2REiX6nWHP?=
 =?us-ascii?Q?2UYQmB2WMYU6oq+NDilT9ncutchVC5M84X8Zx7Z0UlKScnoh5oBls+pcvD9Y?=
 =?us-ascii?Q?hALNUGPcWkBdWGhVYP3r0r5lRZRpRuP2Jgf33Uow5JjIgxg4Wspz3zvbzJ3m?=
 =?us-ascii?Q?Scfzq6C2/brWL03SN2UcMyH9xMVgGieZLiKdJmwCgzoIVJWCRSGPzLEJg4sH?=
 =?us-ascii?Q?2RL9OAg8cJ8fNjkp3uryiPVWscZMkNnix9kw5t5IO4syAs61X//dvhJRSjSN?=
 =?us-ascii?Q?Jv/J937Fm5tQPTV42H0PqofUA4ccTgmxZPvj/ZuF3KcO2QMOzOcqhK+srQn4?=
 =?us-ascii?Q?jCtm51x5UTKEKWHmPOUZvEENyiRmQ7wSWiJEoWPdKwdkjfDWq6D9xKqp8EzV?=
 =?us-ascii?Q?m5lEMlKJLvb1wKLcXae1kAvMw8a3SgGrHJ0772wOf1gq6FzmD9xKLnWnx+Jj?=
 =?us-ascii?Q?djvoFIAtaHauCCF99bThbtvcm4HKYsAuZIlpLBoQXs1PS1IF7WLIk749s8MZ?=
 =?us-ascii?Q?4gAgpeqKifYYiplAtbsdlLJyBLVvLSrNe50IdEuT+UawL3PxhnRNc38CYL7r?=
 =?us-ascii?Q?lHSKpyh3IOXUFk5T82dTOsmL1hYNm1BPCoZxdAHliiHVtST1JefS6nNIYTm4?=
 =?us-ascii?Q?+WWwIV5lDF3GGSvt2cZiFOJGcJE5iIPSjlQRPWIvFOonw/Hnh+yuFlqSQDwN?=
 =?us-ascii?Q?HWSvgNgU9gHfyvKAuH7QLl0nNI9W+oB9lZM4DkVO03Kbn+Pqz7chEzOzMA3n?=
 =?us-ascii?Q?oYIjaQHeD5ZO6yPM/chPYaMc00stYIjQDEROKbeejEHfmm8XSlnXaj01skA2?=
 =?us-ascii?Q?QBDbOorWKGc2lfVUJgZftPDCC+R9mfbZN3fXknD5IeSIrclX/MHyS/070HMp?=
 =?us-ascii?Q?1ZXHN2L6EWjeLrPkmpfU3O8lksGfaBtgkhqPrZGLIiPxs5SOr1KmCidYRFVR?=
 =?us-ascii?Q?Ot0Ri+nHFopEpWTYkmrywnGu9EJyA79J4VXQe7zUtV8v34GlOA4BhfQM0HvV?=
 =?us-ascii?Q?2IWrwTQAci6nsP4h0Rl5CKxL+QRqcERYn43PGP1zn3iGK36t/JWpeL4q7Oi0?=
 =?us-ascii?Q?qBfk5au1SHxcS//K+6FwqVf0UI4d94TGOkIWCc3ejLtAGNJkpI8TuUCRjRec?=
 =?us-ascii?Q?OJbnBGKIO1hNe9yGwiagQc7ralUndsE+dlvUG4H6bIC8mWIGWKebRiVlEqKU?=
 =?us-ascii?Q?K2Za32bQwRFKx6u2g36qwdrBhmTnVOSj3Yo2qFpzp21rXy2MYhqvv1VvXF6B?=
 =?us-ascii?Q?tms+wTmnjUbbDQ1vkfCe9OGY68RYsG+HZqaUyxuJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f66e2-eb85-44b2-16d1-08de1139c0c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:08:08.0024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H13ed5yFHDfB8OcXR+6DaBiYRrkhYbnMqCOQNNmbn7irl/31bow29sZyr6BUQtJU7WZkRvGCusTyGvZXefGKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11879
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:54:14PM +0530, Kaustabh Chakraborty wrote:
>Exynos7870 is documented in upstream dt-schema. Add it in the U-Boot
>driver.
>
>Note that here it seems that Exynos7 DW MMC is perfectly compatible with
>Exynos7870 DW MMC. It's not always true, especially in SDIO cards where
>data from a 64-bit FIFO is read in two 32-bit halves [1]. Since SDIO
>isn't used or implemented here, it's oblivious. But upstream's schema
>considers that quirk, so that compatible is followed.
>
>Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=7cbe799ac10f [1]
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
