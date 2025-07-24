Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17D6C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291048363D;
	Thu, 24 Jul 2025 04:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mk8teorX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A5A83641; Thu, 24 Jul 2025 04:34:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEB68362A
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh6ZUoWbNO0agPG+OjpHJSBsLsJcJRrQLUIItvbPXyEx+sDq139y2OimB/NgvUi5m0rdfPa+Rfkxd7aGmwVLJ81T6s1sblj/t+HydsLs4G5LrNhZutPOJRka/n3G8/ljrOIhStOEkFE41zLh0bqsK8/N7SwMe8WOkdjB4F+sZktEQdIaNCNmEtKrFMMkr29cseO8n9ECk+WW0xIN+RLi32TGs1KNaMAvUWXWMNKtrwtNAUChrSJAxF7Dlmy6o5sW54EfLHDq9Mo4nzVuZjEEID6+3SQyeG+OjLwEaPj0dVMw+8z4PqLdTsVfoBs98PIisUfxEpHZRpO18dJRublKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmkLNC9wsy7VgYrHqKtXWRUfr4CJMsAYCA6RqcrhZyg=;
 b=o/Okr2voL5tDvlVLP431yDO7/5eeUbt6ktUkVqw9OVU6RMUUGA4TQR9V+ZANKexV5EhJT7JPkih2/u+WWZ+pEF65N79dvtZhEemMaKd6QGBGk7jCiRwYhCCJFwhjveGOGUYRkxqOEqKL2dCiwU4jXvmdkxMp6C1vuQQ7YcLdIMnUjPmnRV3CoDGkDOjCWU5brL7Fdb+/l/RR2GjzRq41eOkvBPwrNfwLMvBinD80ueGueHgsLJarAOs4xmBwYHqMcl3dyYUrvKU9b8J9VTLcv6dG5adKPOEAbvskBfTmtmMY0+iSSjuvxTPqA4fT2NGqUE1oseBRG4mkd50HV23ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmkLNC9wsy7VgYrHqKtXWRUfr4CJMsAYCA6RqcrhZyg=;
 b=mk8teorXe5oNfnBOXYoYJkI7U00Co60MgPNcDLP0bDghtlWEfC9NDR6+uxJ2lfKDobFT6ZT0XHQnVgVUUtjSD4Kov/r4DQiR4z166++eUFrS9IEQDguWl1eeS0N8v/hEycChBxbkKRrpk5kQdB8yPyWcrrEUYOd7h9v+75FFJAAatmPUNqtvGriQO1Nk9WBB0RpaOus4uYfX9AtpoAbPTO76hkGwAqoajCfQqI4kqIp1/pd6t5qewh3C6eoFhX4X48DWR+1IyyII9qZIsGKpr1wh30ogiKNUJfD62BvrzawkDgOafRBeInRPnnBXz8LOTvtOQlf6kZpjFkYXPBrcfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:34:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:34:07 +0000
Date: Thu, 24 Jul 2025 11:44:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Alice Guo <alice.guo@oss.nxp.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
Message-ID: <20250724034438.GH18395@nxa18884-linux.ap.freescale.net>
References: <20250721180205.2696763-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721180205.2696763-1-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 31616783-c00a-4a08-5dc6-08ddca5a8f2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RTHWSuCvciDU+5CMUfshz0z5sJBQYher0BnBdptK2v+h7npuXxOd0XmlSuad?=
 =?us-ascii?Q?6wFelVgJBtOHbJotImw2hqKpzYskFAnRm1XB3liomxi3/eYt9e3pxUTlPE73?=
 =?us-ascii?Q?cbqfNpkHN/vbS68mh5w8Whrefyuqjl9BXo+4Nd1IEwBRvX1yTF95r1bEEiMP?=
 =?us-ascii?Q?1dAmxq1LKhzXVkreGbv6YFcuN0yY19j0SgEeQ8yBGeK2OZmHzP4rGCON5slg?=
 =?us-ascii?Q?9qd3FWbJMbSFPLDBD5E+PiLZN0uVRRafGhH44UBGKpqYtiIA+yi8dJadJaed?=
 =?us-ascii?Q?yTJG5aSJXevt6xbX6JIGc9wMVezawza1vTpFY5tjvOeUpFOX5ZZhB/V65kj1?=
 =?us-ascii?Q?5uoRIqKQGcs2Z58Wx7Cf/OfL5PiTE5S+bCuOotVIb5Woy6OCcGRTXdGIdG/c?=
 =?us-ascii?Q?djN12+LtpwW12YPh/Yjt98lLaHztCc5dLBnsvLwCgWOHsA11hKC1tZsVolSh?=
 =?us-ascii?Q?yZcHk25TmcSWeF/4KAofZVwJvwmjvcuH723Cmc6ZA50norV48fBanGZenRVX?=
 =?us-ascii?Q?znfnjI0Mv/6rbL7O2W9wME/BHJOEFMoB+lEZa2/mXrj24EGkX8jHvAuQmCqb?=
 =?us-ascii?Q?P9VcJfmiMRII+DbXM8jP4U6glmf/eFveCoe7oe8zMSI6+wRZrKrcVdfoWcVV?=
 =?us-ascii?Q?WsDcHotkWMA9woFbFL0VIJBB5hrBW44BfGRfmR6U8/68LYqPm62pGq2Vkwlq?=
 =?us-ascii?Q?0BNNZYTpDJQB5Xg6xkwzsgOmJ3SZTGLVV4kmGncgRZSX0z/I6buXY/jWEFjd?=
 =?us-ascii?Q?Doz57rxvm6ucRcN3pK7BvoatEhTECSABAdJhlXYSHZL9JPJpq0w3tSpwAoZk?=
 =?us-ascii?Q?6Rh2ueI5rBqZmWHPmiYcwm3MancE9qwbZJd9NFPWmO9GanGinjuTkemynpzA?=
 =?us-ascii?Q?D2GUjxkPlMlNnXgwnn1hlbYa1VQqGS4ggXXLTfzvdxFHzAruWGLsdLRemC4j?=
 =?us-ascii?Q?lOiTCs4HuQAygE6Ryf6w7Fn7l1KqS2MLYiaxNXejUpo29YsWAXm518V0JCz+?=
 =?us-ascii?Q?Xq9HSC1rRlOJjGiHS9Yub3BMqp88g9Xw4rB2GjoZuhcTM6zjCzZQfX1pzBDW?=
 =?us-ascii?Q?F4dFzoxPLW04BS/uK+CZA57wDtWZFRqhh8cAVzO/6BvE42DDBLJSHP5gPPf5?=
 =?us-ascii?Q?DASGRa/sDtqqbdh4uoRm9JvzsVReYvHju8g5GAWhK8Ve0qmFYvQA2uy1neuT?=
 =?us-ascii?Q?tmnSKroWbSiztW3J0X2dDVXUY+RA7zaLZVEi1XXpVJz+9nu2rAiN2gv53+qG?=
 =?us-ascii?Q?gQKZSSOo4d/5rqMUt52hrZqdS32EiV/jlyeuxAL3BPKKjyzL1vEM2vSCmwPK?=
 =?us-ascii?Q?RrMZSxzp7R3qd17tlA9aix21ovMnWbaff/8yG6dfm6u+GbvH5USm/G+RKniN?=
 =?us-ascii?Q?LUpHtgQJblqRwaZ4c7hiAhv7EYSh0XFinn7wq02KfYlkAg3eB2U8RgErdMjT?=
 =?us-ascii?Q?t+QzI59sOIWhGMqyGoa55nR5ZYnxK4aOKoU7+6S677Y9oQbTAoz3UA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhqBcult1i3m3FKJY7s0vJ0yH3syqz2IyXDzhVF5rUJAmAjZF36p+0Om7ZAZ?=
 =?us-ascii?Q?LJruAhpwCF8QkKUXpq1PL+WTcO93g5yBcj1IaR7JrepgeTBuVQ6Tzq+DBgXb?=
 =?us-ascii?Q?f43hzGgow4WyEcfXQs7GPWu9nukVfRGzx/tfiHcICNihXuIah9FlufnxPi+e?=
 =?us-ascii?Q?2fXVCr1o+zAXVSgWHk+kRMg8+Bi7aUv9Ga2KGioBG1Cdy2DwhXjsqNuI/2Xx?=
 =?us-ascii?Q?l0M7nCftsO4ZDb2ed7ivp6Q7J3c0245YrCe4egw5KJFbeQU504S2pu0PP09j?=
 =?us-ascii?Q?jqmK/g+DvroAauWacETjGOteqzyitBTRKSmW+YHWyCCnug4ULSoYKSwrn+an?=
 =?us-ascii?Q?NQ5wfPgrIJhRUDSv707ppEqfzM2m3yIa0rqHJH43zFggwvVZMurAozDDtWoQ?=
 =?us-ascii?Q?6v2soglYFtZVuE8MWGdeaYiYaL/MdQjrSOBS67SvsQ6yDgDWHOSs+nwPlBKE?=
 =?us-ascii?Q?i9ZKsdgOAIN9VGz7rtPO/fjn+/QtBZPze8ZHMJ+wPPm/ST5qzNk5RPsO+Bc9?=
 =?us-ascii?Q?1W1wV0VXxJJomaUYa7Qv8buzIigNrLuzmsldeMvQioqqdpS6R7OltjVniV02?=
 =?us-ascii?Q?kmmV/9VpF20VdUj/GEL08q4/nbUjvntu2iujErU/vJaynQK5q81rOernVqZf?=
 =?us-ascii?Q?iO4Wg/8FRrQ+1KNorGWVQKahYSOBZa8pX7kQ46tdVmrl8IjC5PFwiRrPBhU/?=
 =?us-ascii?Q?aG9A0T3N6X00iMuv0IzqvARvrk0Jt0AMwijokSXj/+Fknq0c/oV6+MXjY60G?=
 =?us-ascii?Q?mtRQva/rEctTATENZT/UtImcZ01tUqhqLVtnjwYLvZgEv5nUkjc1gISJ9qAq?=
 =?us-ascii?Q?ZIxvm8yu7TOImMqNWY2sMRuTQFXBSJl2eUY9lZ2grDqNdXw9E65L61XaQr6f?=
 =?us-ascii?Q?FNHIDsJGu+lGBdzlQTfF9I/YHgsaowf2AtYtyKRWOi19pSGKZ5uswQyC9Sam?=
 =?us-ascii?Q?CQw3FwdNbGpfYrdRzaQS6kYwRRQNQNajhSubPc1JXh7tvqBOJh8qZlWzdNwu?=
 =?us-ascii?Q?FWzR/BKPwGliXDYhh+pxtq0QDcHcGEEWOZo5dXBLx5rkGnIakG/OfqZcZrl6?=
 =?us-ascii?Q?xqBSNRSgh6ma4uaK/EK0rQGffPmOidL/f/6gbilA0LNVTbXiADbKxgIkuRZR?=
 =?us-ascii?Q?MItJZVNibMnpJ+6sQIdksQolQtAP8Z8EWw+QZobKyHcVH4vkxYac+zwlD+sw?=
 =?us-ascii?Q?ctOVT6kfr3fs83DQgFsriXe2n4DEjDQnVZpgnPJIRb812xXDj5JSZGfZFLy2?=
 =?us-ascii?Q?WAWG7eSWzR0yBRl6xplisSKiaqJnjceDH2/7eM09bLiJwM7/KQ0+K+z2LXiO?=
 =?us-ascii?Q?Glxs6QBISv9MGKcdQfML7jp+Duh7LhVnE6y2dxA1fneH4BcUZtrwhU5ZP6Fq?=
 =?us-ascii?Q?6LkZO1TBvXo0T8CTROmDOnXhzovcDzTLIUThIJAkgGzd9XeGkyM/xXkm+6Fu?=
 =?us-ascii?Q?gcqWQB04/nO78U+/QgJRJsO42CJ+GDnkcTR9u/R5pENI5Smy7XcpMUGqqG5a?=
 =?us-ascii?Q?2HawKSaKGwvpqXnzDjI03HL9jVzL0pd+YOeD15eih5fVtJbZgbC/LHfCmceL?=
 =?us-ascii?Q?LnioQxm+tZ52R2FUc5BXJhAD6r2JwqxDFFDQEOAt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31616783-c00a-4a08-5dc6-08ddca5a8f2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:34:07.0008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+mMW4D8UVUVpk3dJf+WCAe16+hiIwEYyNT2Z8IxOdQlybt98FmyuP7e0uwCNBRC6K0NhFPeA+DwyZTjfIwruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991
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

Hi Tim,

On Mon, Jul 21, 2025 at 11:02:05AM -0700, Tim Harvey wrote:
>When the usb node is defined dr_mode="otg" ehci_usb_phy_mode() is called
>to determine the mode from status registers.
>
>The IMX95RM does not currently define the USBNC STATUS register but it is
>assumed to be an omission as the first three registers are defined.
>It has been expirimentally verified that the USBNC_PHY_STATUS register
>at offset 0x23C bit4 (USBNC_PHYSTATUS_ID_DIG) reads 0 when USB_ID is GND
>and 1 when floating.
>
>Use is_imx9() as this driver works for i.MX91, i.MX93 and i.MX95 and all
>of these determine the role based on the USBNC_PHY_STATUS register.

Just a question, does your board use USB2.0 port for SDP? And any public
patches ready for that?

>
>Fixes: 801b5fafd35d "(usb: ehci-mx6: Add i.MX95 support")
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
