Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F24CC83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7597B837B9;
	Fri, 11 Jul 2025 04:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pAss9ziU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5993D837B9; Fri, 11 Jul 2025 04:58:57 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EA7836EE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqFJ2Wlh/vYAaXq2vCsNjeKv6MvkxUTu46SYaYLDOdQzYXWBRLuetf78Tkc7V0Yx7jBGBTHNmsBm3P8pCzBnTdd7jRh+FPYupD3juYyVqgHO7vQYhK9L85eril3W5Jk7vixd5Kgn6Fxx17nLOXy2BRwUhNmnkcAxz5D6AqC10CM6bWZpkoz4H/EDb2bGaFzbUDpH1saUqkRDubOxJntoeyg+iHeiADg5AlAajQN0dOH8pQ8DHcGlGAZgogaYsJkmOovzGmuDD51zpiAr2RsgOz/0DPmn2hHelSs60tuHzzlTb10t6x5v7b/K3fe+ZhPBoejBmBa66Ti2QmPIKz4w2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWBLe4rktAhZVCboadtTRLxdu+OiAt4kJTh5EO7zkgc=;
 b=TC79/ufxXrQYKkNw1pcuIwdvGJDYldo1k4ap8kJMvgiHav8GQZkQju/0Z0Unt2cIziu666DmRoGLFcIdk9ZtIlU6jnCK2r1Ov95ajiVuf7X2UDkQ0w73R9TN1Y+MaRcJytqZrFxO5WfOR/oEJ6jzomj2JuW5VNd+DETHvdkPpRjOBwdNB85R42lDNS3EwE673GtgoE9ohAv1RlKsDaZljKheJCnGSQDXVVAPjEhD9tnpGavZGjXi58IVPiuGB0KcywL7JVOclTgzlxs/5HXiARxQJvgfM3Hf+wrGztKmeFH2NKhphUcE4R0q5Tu9xWqLBe7bUFW+IlPAgd3DVnvOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWBLe4rktAhZVCboadtTRLxdu+OiAt4kJTh5EO7zkgc=;
 b=pAss9ziU9Hrhep0IQuFcOw5V1Z3ziyhsasjN1BglBk1Y7hdlFAwijEU2UzbgLu9urm1WhZtNvGOaesj+g8UexO0ee18FgaQnzLvc2VM4OLE4Q5u11wP4U+kIkDPOTbDAxvahTGdWUOMDOrsRl9XwrLIt6TaH36/5yyJgE4M0XkfMNgI5UPDaGk9cmobnoquhlrGvGN2ZRPEqV3ug7Mar+vaQSrFTaw2Lb3tJT+vbuqzt25gIUYoUmn6vFLrAkImLvsPgkiNKtWg3bR0aJlexR4RtjNc2jUHLA7/Y+cEnBEGTEzMwU3lDIaj08s+cyUh0ew9ls7TH+wxNvtAjFeRrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10265.eurprd04.prod.outlook.com (2603:10a6:800:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 02:58:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 02:58:52 +0000
Date: Fri, 11 Jul 2025 12:09:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] configs: imx6ulz_smm_m2b: Add board watchdog reset
 configuration
Message-ID: <20250711040912.GE1654@nxa18884-linux>
References: <20250708103537.27632-1-michael@amarulasolutions.com>
 <20250708103537.27632-2-michael@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708103537.27632-2-michael@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: 667e0bfa-9198-44a2-c0e3-08ddc026de34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdOLW0HuP5R/63ZHl2PTxK4WKlhyyyZ0ZT/4jwrKGPr4mXIzmKA/jH6aI5Dc?=
 =?us-ascii?Q?YV/vGurolpSRzduQgKbwW8YUniaGdHSo4V3oHkGXUxjuycvaUeP9PsrB/qis?=
 =?us-ascii?Q?PG4mVOGBSBS068ivj9LRzasdYsAse/giKTgOVEaQI3s1LO/qdVw8aEeUIjXQ?=
 =?us-ascii?Q?N4Mm+rZPTNXAgGDJGJuatxXYBDHCuVjGLZZmzhwJHt06Grc0ojetovn9faxg?=
 =?us-ascii?Q?+twtew4hVigOlNdi0gPYvIsXsDnf8uT3cpiogsUaFBLSBspYhU0POhLY1WQs?=
 =?us-ascii?Q?9bp9Yr1tDt068Ahwsr5AZOAQgkIZSjHAs1gy5OVb+NN+dO5nYRzolJUftZFq?=
 =?us-ascii?Q?A8AQILEogc8Sjxl6GgYInIeburXpv94MtEnlPQoGBxi30Z9Nw4rh91iMBQ8z?=
 =?us-ascii?Q?VvXuKQKa2kxfhVCvoXLavGe+o7zd/iifIGl5E8pSDu8dQyPrfMQNooxJiwiW?=
 =?us-ascii?Q?Qscg60MFYkOdVfUgaRi/enFYYtyNjeCQ0p1r+W3NjfFnm1GQuqqX0QKZSYR3?=
 =?us-ascii?Q?c1gCnL1uZVgPWhyPrP5ec+oG1jTMbqOHYnJuH8I+cAMkdEq8Qz9IFxg0/lSf?=
 =?us-ascii?Q?oLrSPeW6ZXwGigsEWvYK+Gglm8XFSLpmOkGBiOT9o9AmoLjuSG2JmM5VnDrh?=
 =?us-ascii?Q?RGtFVR5rjOv9RsfRub9vM5I7IUEwHrJRKWdOkfTfJpwEu61xGqzc563jpC6V?=
 =?us-ascii?Q?ASe20Ljn67EqXeS8CUskvE68mKRGCi3S655HRxmLQTOlYZaxK4TsofXtMCIs?=
 =?us-ascii?Q?07Y4+ekBSiptu2iK1ddsLBmfKvFAZN7nour/gVwkigd/FMUN6aOSry5nt/19?=
 =?us-ascii?Q?irrggrAJKLimlqApiLEWa8um5flkWqFauZ30UOZSiOnJ0A71KGubrhub1A34?=
 =?us-ascii?Q?bp3l3MyH0mPafv6Jv5Yc0GHFwmRT4wjXI56iEBYHYC1TiFC9g7x4+tsM2O1S?=
 =?us-ascii?Q?a+rKMBGmEqlHT0/pYPUqklk/arHXgo58bAUZwNrxbYvHP5iRs9GaBFVgl6CA?=
 =?us-ascii?Q?x/LGE9XPvJuJgqcvKOcDQejEoMfmqqZW2lbWHkvl+wh14FrTbkKu/a/oD6ip?=
 =?us-ascii?Q?kvLsCaGsUbnh/cEQK2izI7znLnbuRETMSXYYqGJw+NgVcHfpC2itMtm51MAy?=
 =?us-ascii?Q?NbQOdLd+DxeU04CvRm/1psz1TOT1Jq3mpB5xHEk8k28s1JiKIIvBVAPl3Ih6?=
 =?us-ascii?Q?fZ2/Mv6IP+IpBh8FyoZ01nTHH5lohCTYgAEzdNJcF+b9aldEnE6vzP5DRJhN?=
 =?us-ascii?Q?8xvscICOca5AV6scaBzBGQBRsVU0V1p6MYPOLEHgORRMGUQyGI3jkyOkuEk/?=
 =?us-ascii?Q?HzAZGXP31UfMWZ+w9HIgE1DOKHKRg8DGO6Gw0U8ZOTa9STFKcWuBpd9niBVX?=
 =?us-ascii?Q?9JYPt88RK4nAQNbQ5LnRcxzlrmXn0etx5WhHiERmmwrvi/FiT5xalPGuF4O+?=
 =?us-ascii?Q?siXvOie0/Xd2Hd0Lnbcsfe4Fo5FzkPgBVBxAmNEitrOf4V8JEW+nnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RnXSqpPAT1fYeZUvTADpvZTO92VScGJ42XR6huaUyMZem6TzdsDCZDO3LBUr?=
 =?us-ascii?Q?PEMvp3LAVwfVmCIQi+k+Q633jpwARq9xL5t3mllqOe7VjM9cTaoQpEadZItx?=
 =?us-ascii?Q?06tlxVEyTnu0rXBf9SObag08nkT1pt1FteLUU1yvNqfjZuqZomY8TSII1U/E?=
 =?us-ascii?Q?7ozDzH7t2vjSk9gB+Af9Q42uRRrmTG5q/7XPnEHIkwLdx8Woyh5/i0NaOIzR?=
 =?us-ascii?Q?PZhvsS9/wo/yQ4mHvfqAjiz3x+/QtMR8xJDQ42NERm7C3N+kXxtdhCnqM3JU?=
 =?us-ascii?Q?Dv8q+wM3Q/8OqxDShZFveVkTFNin4ya6UGxozPDIhoH44UrKUI3HFnAEL8cb?=
 =?us-ascii?Q?SNJA0QvBlTWWRZWgjcERYHd8uVqIRoFDUrGSx6XGI/ClG1dZhDFTfbyt3JYz?=
 =?us-ascii?Q?5ooVmFqteXmYiyZL1er23IN22Lynyvxeeh9xQAeKoyqhSI0wY1mJNmfdVs0U?=
 =?us-ascii?Q?ohtcRXiiNh4L12qbaR9BVEJU5ViWPkLAHZ74RJedv+TmMdQxBy1ClOEJY1If?=
 =?us-ascii?Q?qCU5GyC5t+ksBU0qgY42Aidvgo03GsJOpfgFmSf1OTO5jzdg/qrGm4dB7ndL?=
 =?us-ascii?Q?myLhM4RWGg5HdCkoqgrHzoC5Hj7b5ChrkrsdRkLg3QoXa2UwG2sCMk282/+5?=
 =?us-ascii?Q?++W+8BCjaf8HIAiHc1DCX1WSDr2kPp9frMKR3n6cDOHh7kbRx4FIl/Qnw4iP?=
 =?us-ascii?Q?BUKjFID0SG9vHA2hiVgWkY4Uv0w+9XhVoir6nbEh+cj2+FmH+mqFfp5QiYDS?=
 =?us-ascii?Q?h4T5vuA1qRl3Gsl4mUb2VcFrAwTyXutunQqJ0DfVdDHnY8nntoQ6Ynfdq00U?=
 =?us-ascii?Q?FvOtL8ZEJQvOpLzs64T77fA8tXAMwb8ypxRhbeWwaFHptouctcrMMMLb800Z?=
 =?us-ascii?Q?+34fHCNJJ4CddYO/9hGlT3hvtHSWk3gFbJn2bi8DJ88d8t8Nlh2Ku0pzTgh2?=
 =?us-ascii?Q?2Tt6ogeE54PH94EHxgHuB2JvNzBppUgpBOKvDNNmsrIJC2w1HRe5Rg8ZPv+C?=
 =?us-ascii?Q?0CrI+rNOzkVVxOcta8tJwrbwsqW1l49zbruunl466JNGRZswmZVJBDZf3r5z?=
 =?us-ascii?Q?MtuFaY06f2BgS3OCpQsZy2H9T3Tiyd4eeCd+zWsRbjF8l0G2vvflXgpcaCDI?=
 =?us-ascii?Q?jdNlXsOv66dzaU7uVnC+vGkK5Hpd6WdHpNexVzfUejuVIJhJfN1xA/H40DVy?=
 =?us-ascii?Q?Y6ovbHn23l57SOrGYf6Lk7rt183L9TCqqEUEbe1VqvHWOoHG8WN3CBgq04QH?=
 =?us-ascii?Q?wcQ02aSGowE89+JoghOnLAU3HB6q20TcVG0rFfGWdjfL/BVTdv4/dnpcpgjN?=
 =?us-ascii?Q?ZACYMX0L9q+lR5y7DuUy4iiaDTBwNE2BfxJK76eoAdQ0zoiRfMY73B0CToMo?=
 =?us-ascii?Q?p9Ng8jL2R4AhIi1OK3vgSHDnkp1EOFptrfn6m/moKwCS5zUHXsyd7vRS10IQ?=
 =?us-ascii?Q?WaYHtNqEuMN073s2uPKmc1SV30xIm1jpd8U1R2DgtYxHCiCtuFci61lR8xw+?=
 =?us-ascii?Q?H6vjsunLMfPrYbf2g7Dqa8FQgCgyT0ZVZMzurBAtfiFqIRsoGyPuCoyeDDjr?=
 =?us-ascii?Q?gsJAaZhsp1SSwhZcq32xUdTgu5CuXp+GzKFfSNtD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667e0bfa-9198-44a2-c0e3-08ddc026de34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:58:52.7105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHUfxWbz318eKf5Y7M6qhjxvbQ7K/YHC1LF94ha3I18Ke5ISRJDDTvSxmfVvwlQk9pmxdHlMjjKHWHg1ixcd8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10265
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

On Tue, Jul 08, 2025 at 12:35:29PM +0200, Michael Trimarchi wrote:
>Add the configuration that allow to reset the board from reset
>cmd
>
>Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>---
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
