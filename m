Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D89CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE245837B6;
	Wed, 22 Oct 2025 09:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V0wkiwMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3134E832BC; Wed, 22 Oct 2025 08:12:32 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B3F82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 08:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlPusRKEZRTR5/gETVi3GsBchGNiXT5KO0iV4I1NYsJIauQJB76GItMdw+qjzuh89MGFOEsFMys5cVJA+k2f3deNdFG/3A9ti10U8M8g6nm3vgyMIUrxkz9kmpufJXvKmVK1taA5N3fJBlDfPSXrgq0DJ1zENYgIv91dW3HbKZ74Ed5oKR0vGpjGT8ud36fw+dvqnU/R9wpDzaND2Cm5LYiMH8BMe7493fRpmk1CLQnMO3eZ+jR624vQxionkpbkKcn7gS50VZfIzVtx4DsaGra47AEIxbFPnxqyaqTf+WGXuYu2Ilspo2C8YYkugyj7jv2JHkmx9gO13fz7GXGXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFXmES4CYKixs6gDNRbwF7ZuSK5TH+oqbiUEO0PfXWU=;
 b=SpFvKdCfViHWc0I92t/AMhZrSHlQVCZlOLHRBG/vEYo0RC+bbZyrgfs8EYqtwj5bN6Bsantz6gqIAJSRw3T6SKh+55dJ+PQHghcUbalGpaZFpqUEFDbNgN1Xv0Q/zCvhBt2HkPyqhi+z+jO7caH6bkdJr0G99TcEnlZpRsMVth+uDfJJB4MQjEdE6b1X4Sk2j4K6jQ0saIGuNrW5tXZcDv1BV4qYmhBSr4cjicJRDmn0B1XeOBrs+p7SrVvK1RMlY5UKVXo4HEZCCMfye+IaV+pG2rI2xZsiHcGXJoobB1nyx9ArfHknllEXX9ninwPZIvty1iGuZd1ruLdhopoqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFXmES4CYKixs6gDNRbwF7ZuSK5TH+oqbiUEO0PfXWU=;
 b=V0wkiwMOWUQGI7VTKMy/WrMtCcSnQwNJ+NwYshDWh+FOdA5VjvxO4nlEqsG+1q6nV8Ykv6TQZPAPhyvpP0/vMWN8K0oZAwvjZig5XuV4gLWXZTbeGQrCEk4J9hA5B93j8jER05pNJ1xsJiDnbjIoTVwstl1yGD/PjbfEsWhNrDGlOK486za5ZxaiyvCtSRAQ7uW3tg4X6v5reV96Gm3kj3sb0N8VQR4/NjLniesbNxHseuzNd9z/tN2ita2Lv4ZUqsbEVC0pV/c7RpgYlYg1tXmIeDdZQwq+oLxZXYJ24sqR1aC5H38yoOoa+IP6sZjs11M6CuGfa0KfApB3iGdZoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:12:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:12:27 +0000
Date: Wed, 22 Oct 2025 15:24:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Lukas Timmermann <uboot@timmermann.space>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: exynos_dw_mmc: Add compatible string for Exynos5250
Message-ID: <20251022072435.GA30163@nxa18884-linux.ap.freescale.net>
References: <20251014114057.67215-1-uboot@timmermann.space>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014114057.67215-1-uboot@timmermann.space>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a79ac73-98b1-4b4b-e826-08de1131f9a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGHo4gRTfy+RZn3fP918OmDrXpFQ94mmArmNHYp30BCrrBkrrXUjFnlr3t8r?=
 =?us-ascii?Q?4M0hiKxIxsqw9Iy/JzspH+Dv7s6G/dpygzU7JYOr63Gim2VNkFFw11DLn/T0?=
 =?us-ascii?Q?3DSq1J/cDYjwFCzekGVZiLz7yn11zdCwALiLsIBPYiQZxMlSqka+x1S9Zcm9?=
 =?us-ascii?Q?zIrBr2l8Ccz+j6ZSgBdV1G2FoQIAXYMhopYibcRuCv8Zt7Eg4IDa/vZNkwFF?=
 =?us-ascii?Q?SlJpcva4ejHAwpF2VwKX0fB8G99QN/LmU1CtIcNoqx6tTMFZHwUzfXxcVsMp?=
 =?us-ascii?Q?m4hmlD8tUrK73ggH6AWRhned5LPjRI6/xRee632u26N9Y03WH4qBg1a9aJ/t?=
 =?us-ascii?Q?l+pvZ8vryiV95Jw1iA1vQu6ZkQnWsHxAj1djUzqsimRvd7Q4HDDylPG3zywc?=
 =?us-ascii?Q?giKGJZuoTZPPKN3aTL1UpPRNewaIuaXSE4ZyoFMDKpUtchL7H78E9c2gW5NE?=
 =?us-ascii?Q?pkDcuqL/LjhUIhNLHMPocJDv+eBDTjGwM8p/u8w3WYFs5ZPxFb0prgt2vAzW?=
 =?us-ascii?Q?nAiXX4MLI/GybIsKIsP70J1JR1ZPbyBo5cpex6jn1o2AVZthJkPPH0FycOkw?=
 =?us-ascii?Q?2ezLIo9LvdJv8pe8rD9OrozgopQ2saOivYHLz93Mp50tzfATld+OCeJb5kh3?=
 =?us-ascii?Q?GC+uvhX/7Yy5SQ9C4K4x1ESfNfErYnuULXTqrVZp6oqbvXlLKZbIHJN1VW2v?=
 =?us-ascii?Q?0LjFl5O7Si+1vUGLDwwHTwZvlxMScz8+c57j+3th6rha4Xj4Mjva392x0Nbd?=
 =?us-ascii?Q?FQ6535HlbuFWdcLGrdpAu3dwJgkywpwjb/IjkFOaOZs1D5XVcI9efggEfCGQ?=
 =?us-ascii?Q?0PeuTqQco45BnGd+5/hZxkXyxMWegvqk1zi34yNASnKJam0EV2mrxTRtgCC+?=
 =?us-ascii?Q?ijViZwJu4D4CNXeyzzjjqnyCso3l02ZacEApVJWeD9xN1MX+oChfsW2zqToG?=
 =?us-ascii?Q?63Ob+k89slQHTPkgZkQ6kFYAGdXQnb0rJaHYaJGKo/hBr+o2TZnOeA7WFVdm?=
 =?us-ascii?Q?ynyIiGlRax/tHBfxUbuIqqv4xETDLAzuNEfh29VS13m8HZ0spH0sJFL8jY/y?=
 =?us-ascii?Q?xrw103CzVTm75thA3BJ/hcsg0spQPZRh8Z6uMbHtJU2GMwXsC1L3i9RAx+vZ?=
 =?us-ascii?Q?mlgeMfkqaZiphR+unPQ5soHkZ/cUlIXknCJsmHam4WvawXQQ+mr/AugWNjI8?=
 =?us-ascii?Q?QcQjWhXgISugxmAY/nR8aFjLfplVXfWrnjOQxzlI0d0JsIGWEFzeZvWAKF0S?=
 =?us-ascii?Q?VgZIArkEpoKY5w9CCMUa8dXvm9X4x70He3o1txxMbE1FCaW9ZVb0NfPyV0yy?=
 =?us-ascii?Q?czzCEPKrxjk9g0uxvUJvvxkEJCvtoAlbNyxsFN5/L/3aK565E10t5zkVq9Qn?=
 =?us-ascii?Q?o+PPSfJ/dsnIYCCYOn0zAI1U4fiAYHLJuPnHgrCaFmFE9+T8bSj34XYj8hQ7?=
 =?us-ascii?Q?QAbUOA9IqU3ToB8DTX6Dz5HUoRWuyiXgvHcenO/HwflguFRqh+3qitTlpdZ8?=
 =?us-ascii?Q?5q38d72os/2u9+FLFMIcel3Mf1vUNh4VOtil?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxMFJ+4hl87OXTxKvlAoYYpyjtwptbQimkBHR8vATbc21utUr/jyMEGS78nb?=
 =?us-ascii?Q?+w0BEK9alO00ToZrGFzF4myy9qAms4w0eX/6TA2LITuTrq2TU3Gj0KL7cjHj?=
 =?us-ascii?Q?HXZgkr71ZqnXIIOQRIFJzrCxK3KAtm4rccffVIzA9opyTMOj9HTjTQd3+UpO?=
 =?us-ascii?Q?ZaWRhqnMNpFMfSveIoStjTTcNhI1LLTm65Px/K/d3s6YHYL8uQPtA0xgz8qP?=
 =?us-ascii?Q?ozuuoOzxSqsk/8NlI1x++iPxJrhKat8QdFk51yYpUDmM2FXVUHJw0a+p1NU9?=
 =?us-ascii?Q?tau+IhopL/noNeI0xw0R2oXzs3Uc3jgaYx0BE9VcASxp3Vgx2hgGRJGRPezr?=
 =?us-ascii?Q?0DGTFYPtUyBg8brjys3RpzDwRMZ/bGGp8j5rTGqRv2RsVC/8lXldzkF/huoi?=
 =?us-ascii?Q?CEGixwJ58rnQ3agcYJ8cgVadEayzOFDnErMG1/+QbIUE4yK+Wdr9nH4XQoTC?=
 =?us-ascii?Q?YyVVQeNZwBOPI0zTiE73OZdIghr3Lca2aTxFzK78LBOjXATts0WQrWPByc8R?=
 =?us-ascii?Q?iMuye0oWPTB5Fx1lM2nYjcYCMVIM2myoloJZ6+ynIuTwy/yWThB2LiybvMsU?=
 =?us-ascii?Q?O7bX2xbY/yrcajWetDujqr7lDsiaSLFJndipLk30kzmsgkneComZ3kFgDkHz?=
 =?us-ascii?Q?GBOTZxW0wP5vnsOyuwz7bQbSFqVZ94/Xw5tPGAO43SlTREH16OGK8rcvkONg?=
 =?us-ascii?Q?/Pp9I5yq7gVsfi5a054qzIsmWI6/r3iQG9+TAJrTUVopkOVS/Be/I7Pea3Wj?=
 =?us-ascii?Q?G+FIcRNQwiIwLnLvFtjwmX7groL31FqXko7WLfOyiNyzNLltUaFR8o9890Rd?=
 =?us-ascii?Q?vD23H2w9iiStq3DJo006xC6vdxw30lHytLOwsKnSalGTRmZIyYUXNHbukUSM?=
 =?us-ascii?Q?CTFZM1yJTBoGuSUqXrGIz/8/7GSHRevVWQp8RAbtWjzlOYHDucEhjaDxS0lZ?=
 =?us-ascii?Q?K7tiqC+k6DDgBECowvAwn630uCMGhghZ55YiDZDZKYIHdrnxIrgstrqJvxI4?=
 =?us-ascii?Q?qB6/ZCF+7qfW6waUTIFT3kyMmobgyFgkIOY6SvxgfuNkpUGtQo9oF8YKWX7x?=
 =?us-ascii?Q?u+RCc+CZM1Z9WqVDhdvsGYeIGh3MoQQIjmxsewh7Dljce5y+HPEIoRaVZS39?=
 =?us-ascii?Q?AHtC+tHwHcKPPisz59F7DgaGVjOJ38fH9zadt/0URPFHVSybf7Hgi+eQtPAp?=
 =?us-ascii?Q?E/BVmfcu1SJ7YXNOKODARUVUm93cBbwsEWmSxlSPHio1QzvOpFw4chOb3tFn?=
 =?us-ascii?Q?ygHYIDFk7ppjlM+l2hf+5MSxX1dng/ilLI2xEO8BP0pvqnQyMvSdFO/BmaA7?=
 =?us-ascii?Q?0AzS8fzJMQqiYb4bvvZOMTgmqIf5XHDgFpbIeb9OaBvsZ1esc0uWBh7pE/NG?=
 =?us-ascii?Q?wVXP722yMxKv/opyxkTLXey0rSBHuCrrYHENfJn4N5PER5rkFR9H3tzn5qCz?=
 =?us-ascii?Q?crYXkyNsJ+E+sNPJ/ARdtNuJw4BAqXHXnloyENmnT4dOc/1PuRJ/SdSC9dIV?=
 =?us-ascii?Q?rU7/2AHpEFRlyINwRuhkKS8xpeZjT0GZPjp4yttFyFfuPf2j1E4Jy/HOT5RP?=
 =?us-ascii?Q?Jb7Ksle6CVxY8bvq9X2mQrrET6JSLRIvnzb6auxQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a79ac73-98b1-4b4b-e826-08de1131f9a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:12:27.5857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNbiOBqEd9cOMFx2K9sNCCIx/WSxFUJX1ak3rP9F/o73KA2Ul70MFTgfKQISOO+kNUH/rq/pMcuRsfKSlapbhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306
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

On Tue, Oct 14, 2025 at 01:40:32PM +0200, Lukas Timmermann wrote:
>This driver got successfully tested with an upstream device tree
>and an Exynos5250. The board in question is samsung-manta
>(Google Nexus 10) which we are getting ready for upstream.
>For the u-boot port was just this additional compatible string needed.
>
>Signed-off-by: Lukas Timmermann <uboot@timmermann.space>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
