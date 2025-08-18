Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C919CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 03:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B061833D1;
	Mon, 18 Aug 2025 05:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UsQGMVxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E30783420; Mon, 18 Aug 2025 05:29:12 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C17833C6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 05:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnQDOhSIYY09dDuEwrg/7vPeygQ5p8Ll2P/ZD+pPgE9c9f2CxTmzs9od+3pTcOvWlMgb4jnlyJle0kZNKV1/FJLBLhsCNamINZ11OkGv2K6YEDWSMExFgq51LUN1SqUjg0eOlwLi1jQO/GL7v/NyO3wuzIIW7iuVDH8AUgmk5I65vR5GKU3jp8uGdCGv1W5vx9CdKET6aieiast00Tvop3SVhXIOvADM6B8RuOfWKns//vB+49x/i3lgCJSltU96vKvGZg9H7pZXN2ID+Ws/yHtp9ltCi4X1AZSs+vymBjaGuXCLRAHuN1nzXtf3iMdEjhg1LBb5Ni2dpsbWqdHAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0056HV4/ec7b6LPvWudSBtoiOrcxBkLQ/HqA8RlVyE=;
 b=iLIePBsqaoC3uK5upHG7WbY4Ny7pXcHeSd6Wb0HXdpqpTbP+4AF+pSioEaKEz3m5dDneZx+PqyVgUqwRkIfn8Q9T8bTuIxxm7lBPWvXpNdSNIuhIi8QkEh1i8BwQ1EAvwOllMVEGqTVGuE/2NRNc2N1RAsdFM756/PCzT7iVjUE7cKWr1OEJ/SM8IAbAVx9/EQ3WaZWVgsbR2mb+SKlg70bRmHPuguFENUf09WINe1/PpUt+PLQxEJ05ycXAUL0+RdORreNQI+VQuYr16SissTJYk+QgiFKvb5IeHBk4sKwa8z7zmk4gSM4zRB2Ydt0etD201Y7xhvkdgJG+2zkmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0056HV4/ec7b6LPvWudSBtoiOrcxBkLQ/HqA8RlVyE=;
 b=UsQGMVxdt7K04L4zRqcvfw5bUmaOYHeJLILFFV5gsazdu0tR5vW4nl9dzwoyOghKieuRxD30xTCLCb9uireofdeaaUa2aF5PeAkfS1BJgxKcB+IXbogsHrsRkeHzhTewMZH9K2tJBpsDLxXsHJ4AoVExWw0yBwyNjUebP4mCN+h0mcEt0CkuVNLJ42Oi6Qbua9UGkVe8W7tJMw6HrQdb1D1JUP/C4sJ4RleMq+Z/Xuw72CPbf/9RnaH8tzRUVtbnQ2euCHfpv/UaJfqGLyceHl5rT7WAXlwPaPjGDcpfhrCAW5VbXaxKixFHC+lrdC1TqOMigGkdTFXA/IPOruu5Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10616.eurprd04.prod.outlook.com (2603:10a6:800:263::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.10; Mon, 18 Aug
 2025 03:29:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 03:29:08 +0000
Date: Mon, 18 Aug 2025 12:40:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] mmc: sdhci-cadence6: fix SPDX-License-Identifier to
 GPL-2.0-or-later
Message-ID: <20250818044013.GC13772@nxa18884-linux.ap.freescale.net>
References: <20250814120424.235254-1-Max.Merchel@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814120424.235254-1-Max.Merchel@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10616:EE_
X-MS-Office365-Filtering-Correlation-Id: ec793b09-a750-41ed-96b1-08ddde0763c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tH3dEj4C86LqG04NwGZwTZMgSCbpNjX2BtSJ0KRtXGFhMNcVdSvNR1ua6nAx?=
 =?us-ascii?Q?+f0ByYdk1dK+dWsDDpvl2gAOvMFf0VuA2GMcua9Yn0G8jhEd7RS8/+sNw038?=
 =?us-ascii?Q?b+xMf2gcKC6sJRSVHzgUvVoo+qD/L4TuYK6X4wjr9qfCZZ6Y7asuc2gT86fz?=
 =?us-ascii?Q?6ONqmdXcOueNPZJ0h1UKIXvpGx7icveGd6RJ64mZ7ImH/CqgnbZT8t2uiD+D?=
 =?us-ascii?Q?fr7iklYUxwHHMCTrZ6XSrm/01PTPIDDln5rnLgk1sUPDI1EtWEumhNAk0z09?=
 =?us-ascii?Q?CrcOwRt9s+A00rRnxMb3Xa22fb/ngqxacoHHn5QSwQFBO0k+b+v5yUygUa0I?=
 =?us-ascii?Q?dGoc8nXhu1lJqrstpxY/i4z2dLaJWdPvXe8ws1ri2dKV2fE94MeRFXyfJQM1?=
 =?us-ascii?Q?sxbWmcCujAaOeMzJVrQciZaa/6p1A+36lk4vlU9AShru2lj2vo1cvByjBN1W?=
 =?us-ascii?Q?syyTw6SATgAGOjdCxpa0YQpxYqHyOaH9BU2sj3cPNKdeydN+MHkycM/XDnu6?=
 =?us-ascii?Q?5aKaASUT1hxeDNgnKPKlzonxR+HUSfbBdaylFrSQNaFHzKoJ1Vi41RaCFp8c?=
 =?us-ascii?Q?+7CJlMdIJCT9bttw3bfTpI9u5Na+/baUoSwIEBn1QqCLX7A6l0jepWAntIA9?=
 =?us-ascii?Q?sdeyTD1O6GQixZ8J3dratd85iwssdBElgoTXZ514BBsOr5fJ/szCZU1nvhS7?=
 =?us-ascii?Q?0DjEcNNmZkf5zdxohACwXbkgLvhkqh5Ekf+8JGCwcZClpUPXwN7xeD2a+ExI?=
 =?us-ascii?Q?iexofs+wqLYDehUhrby2w7rTCRD+W+knZSRLH+5CPp4GSElTJ5rJezPtXMS0?=
 =?us-ascii?Q?u9gFeanXCBQX0aMh1+ggC4fd/mKHBVTKTAnSu+WQPBBwkBaSmzd8+/18GWdn?=
 =?us-ascii?Q?rTIZITXCfsXfTwlPcE5ciR8Yd5cCbVuk9ihi8aC/Ml90CSSTX1Z3NFuWX2Eg?=
 =?us-ascii?Q?oOmPIKGYWdPcWsD0fEGuxekEYoo6o8A7foQnt2I5rdXojgUkE7cvH1QN8G0t?=
 =?us-ascii?Q?/h4ofGfeFrbFXHOyqrDA/M5nClIgkjhkDqdCCFNHR89kRsKk6EyFce36xr/W?=
 =?us-ascii?Q?q8GxTFIVCOpfhDIQucjFB2KNmXYBu5PC4t4S2h5hTN0YvJXcmWivupuN1uB4?=
 =?us-ascii?Q?RRF2aRjDeR+AxN8QFOVdlz1R7Pg+QY8ZbDD4E6YeD0h1k8sziMLP+mVcROgU?=
 =?us-ascii?Q?kXFcfJLfd/0sBydpefYs9UwlleVY7ptKhrVlDht2Dmc2WglGgfPFpSSkYmgc?=
 =?us-ascii?Q?mjjDD7Ic2B2U0q6P6jQlNKzxjOnjZlL8c0H1sihhvyzI91ELW9JPmfaElmRq?=
 =?us-ascii?Q?QATfl3s69166/n6lH3KUa9gIwNh3TZCPh2Y8wV/5K1FLQFNVYnXdBtliKk/k?=
 =?us-ascii?Q?4RLewioxXDOHViuEXdsfb5PV8wsGteQLi6HXPUGdbjZ3b/P1tbzOQAwg2N8b?=
 =?us-ascii?Q?I7ADZmV6dtbe5y6pneY41sbeQ1eszpq9Yn5/0SmVlj02sdGYe86DSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRWL8C0mvMyLlrVKnXerk7IcK1d4eKysR4920zLqQBUl68G/D0Vyh3E/st5C?=
 =?us-ascii?Q?RB9otDHZasfBNUEeoQpOrQ7vPoYQX1cvegBSjOumrj9cdyVFGrG9y03ixtIk?=
 =?us-ascii?Q?ip2BxB9WEJwxomZ6+J+qbgOZO6eQJCoeSJNqGa6MKkodFG+LyxAYwaVXIA/5?=
 =?us-ascii?Q?dAmKHu7x9F1rjkZOa6CdNUY7yMHyzy0+BIGRBfGqVhva8SYhmImytVdYvMhH?=
 =?us-ascii?Q?cr+6kWEz5KKIV+b0dZiMr9CuDnHFU5lO9Hekkvm1aJPmq7zmX+nWfHtbFmV8?=
 =?us-ascii?Q?KH7CGLbt1JNisdcpGjoMhiHGjrLSL4z/ry927M7DHtSFeheyDXDUoBczo/QR?=
 =?us-ascii?Q?iU7V8RUJK1hbQA186DP58ix0zlQkoEt6R+I8Upe1eo8n+y2dXyVH3qrj72Ng?=
 =?us-ascii?Q?Z7Tqo4YP0u9eimvoEs4toUVkRXKpporEfWPKGNUv/lsy77ckfSj7ClLDkDoP?=
 =?us-ascii?Q?F2JusFk9HAMewyQ+NYyhmE35rzJy9yI4zPUan1Z/kN3cs9Bit/iRGbCdRGJX?=
 =?us-ascii?Q?0tX+Z8I+y86ay+xv/uXF988o6rLlzxJgE3gYFBfbzbZuvqY+NdJf6PCLG7DH?=
 =?us-ascii?Q?IURPf0YNNDFk/axmMJ0d0c/Ey/9jMv5NeBGBBq0GndJiQDf7TwWSQRDXvwL/?=
 =?us-ascii?Q?SftpIiDEzO8eLEmAcyMiu3y4dmYt6V4j1js3bzHMc836z+ZBC0KuHvhLqyEU?=
 =?us-ascii?Q?A6WAKls9B45BBGjoRCBHst9SQPK/hI7vY1P/8FWW9/fFphOeLlaenjGMWHJk?=
 =?us-ascii?Q?TXNS1LmEyZPPO4hQ3zYav7jxHUvuKsHVmKYGJokNqQRQgqcu+1dStwdFt4FB?=
 =?us-ascii?Q?Dt36zRh69qMfBJz7y8uYF2MJc0ATAfV8Tf+WjPTygpIHCh2XcQDmK42RuvZ6?=
 =?us-ascii?Q?ipWUB2BEp2sGSGXFIELEQVglP7D4tKkyN9A8Swv8RxdHKFalL8PItgKPUVoD?=
 =?us-ascii?Q?Oz7fmcP1JwEEd/h36zr3Jz79DS52X2umSDpG+oMAHF9blGBvlBshu+mvTkXP?=
 =?us-ascii?Q?T9gqwAi9hRY9YZMDXUdAmws1oGg3AqAkGJ4E9ZT4BHsPbeTR9ngebn0XsDKZ?=
 =?us-ascii?Q?f3hJJk5aIoqPaMGuZI4rHCB9jV+NrrCJ2x3VAKnZFVgPDLrvvv1slVXwJNYv?=
 =?us-ascii?Q?IM3tYZC0QxW830EfyV+ueFhJSJQAFSdew4yEhAxmSgWdHTIbS74IF3CsQRwc?=
 =?us-ascii?Q?sbsgIEN69I89ucGvxDqxjGeVcN4tVcCIjXDNSbT9/GA325BL5egrqCyA/7uN?=
 =?us-ascii?Q?3hW8Qm5OQa8YVqwcXqMLU9NsNBqAC5TDmRPTNfV6O98Vta/LwtTrYyJQTTQN?=
 =?us-ascii?Q?KQEn3LB82n9xj9n3wF7IbObG+q8T/g6zTaNUVVF4TxMbkE4AH1ZxcvhAGg3e?=
 =?us-ascii?Q?AUWomNJwC4zskh/nIez2kzLwuz6hGh+bSQkA6NgmuC8Fo6d42MAbOkIVDPfd?=
 =?us-ascii?Q?tuJFvIjS4axb4XS+RqrsE77MpZgG2Oe0tF/YfLBloImI2KxfLjtXXupGktih?=
 =?us-ascii?Q?TBdaYZontXBBxnn+pXVM9tHotkMpXW/7yEPbqnjJUTQTgyxK3y4eXUWfutRq?=
 =?us-ascii?Q?Ht/5QTVh6yZWxjcpk+TxkRo64akAWpnIVkhcSLlt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec793b09-a750-41ed-96b1-08ddde0763c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:29:07.7821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9uZP1YQSg/bTPzOavWLcDlnwxTnE5Ab4/BEFF36FZjUKjXANven1oIJfyJ3C6NSRz3f3vv7BqHXcPecpLh3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10616
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

On Thu, Aug 14, 2025 at 02:04:22PM +0200, Max Merchel wrote:
>GPL-2.0-or-platform_driver is not the correct license identifier.
>The -or- indicates that this is the -or-later variant of GPL-2.0.
>Furthermore, sdhci.h and sdhci-cadence.h are also licensed under GPL-2.0-or-later.
>The GPL-2.0-or-platform_driver is corrected to GPL-2.0-or-later.
>
>Fixes: fe11aa0b ("mmc: sdhci-cadence: Add support for Cadence sdmmc v6")
>Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

Need an Ack from Kuan to apply this patch

Thanks,
Peng

