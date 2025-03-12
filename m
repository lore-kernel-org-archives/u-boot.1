Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77CC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8189A807D9;
	Wed, 12 Mar 2025 06:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZOBT/OmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB63880FB9; Wed, 12 Mar 2025 06:14:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA30801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM05bFk9VGOObsdG8mE5GQsVOvdBYVNh64GGDScrCei5jgc+qmqUpn91G7XfJ2C5egRT7Eud7yP1k2IsqMjbu4dNQ5nN4QKzv21mrBsbo+TmbA2Z//fqwgdHmaFBSzKt5pDV3M+z5nfLkQP4OsGa7CRG8f+ffCvtUnZpFVIqgtJs2OlhIRRkdQEJfxTARbw1nA+05c5nS/rU1pDdGbIuO4qfk6EStcakwXCVnCQK8/CW2Su+OOaf+S/pYVsN0tgu2sQHYdwVR+nhOiZDBbe91CoHrie42W6W/wvsyRfs8sMbc9EPxN6a3+NNSgLvhvCbW0n8zxTJUk5q9wKogTWpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBHWEi9u4VZI6OYQdz8gfu6l6Uf6lnwdeK/7+kj8GAQ=;
 b=FVaYp9O6HeqcCmW6c+uJMkIvVG2W4hIET8Yu9p3zes/Pl0bPYZ5CJiLfwcyg0LzCPRtAwA7MeYh8ZJMtJU+M9VlOFwVW/ukCgR2kywEjohgd1qM67BcFhZJWaPK+CGY7BlpDHdRU6VkW+N+4z+osQZ1kdR/dq5WV1xj0ckLLX5w9lThvrxotMgQdqHGT9fJx/CLKcoBzkf3fza/iSBtx7cf48p3CPbAgtNsgG9EykGSp9JpVjcPsHBxOJfVCJBpVmpVmXixKnr/u5pBX1BJ5nBtYwWJsT6NNNeT/pJr0GAakzFQJFDls+mL+MSFOgFyJ1Q0Zw3Ig+5gA3ee/cVQkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBHWEi9u4VZI6OYQdz8gfu6l6Uf6lnwdeK/7+kj8GAQ=;
 b=ZOBT/OmDhzdzPsb/3hg5HEWf+/vWpd1becaBFgD9Gm2OCG4OPo9ODZwXds6kiNShdz5v2VwgG1TxbLLjFS4Nmrc/PyGuijUPxr8ka9VyPLs6oGqX9Nm8aFtMcwdZPnvURnkT9AVbpnD3IY4B9kiLZuqCPYVlCT20a0iyaU3y2HSgHpHGA7WoaH2fHitb7ARajMgHvV3GQ3QxqwDKwEVEn9SbbrEb25/CoGyb46uaesMedikOKo0SIFZI41lys8czcw7kBy6t4QsZZdIZkzx2jAW4z71i9wS+1RhzwigX1zgALof3bSOIfHNLdW5+v6rPuj0SQO7+lNl/cAUeSgiD7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11020.eurprd04.prod.outlook.com (2603:10a6:150:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:14:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:14:11 +0000
Date: Wed, 12 Mar 2025 14:21:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 03/10] clk: imx8mm: register UART clocks
Message-ID: <20250312062147.GB11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-4-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-4-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11020:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2bd51f-e42c-4851-6ffd-08dd6124b96f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nJTfzQ4peuS86oYyvZC3Z7saGazTHsUjt7Dh5mHqMeWTtAgAXlPSGqQgqd7A?=
 =?us-ascii?Q?5vIFWlErWINRnCss3fyujO/Qnc23L3K0krdcQmsS0Jgdy/g90vWRwoJldo9v?=
 =?us-ascii?Q?EajTqFQV3XprxXvBO12qzB16OZYDlOU2CsSgNm1atWCQjulrbJ0jnO9bhayp?=
 =?us-ascii?Q?+9440FZ+IjDLGQzg/Zzsv1JSbtp8FfWm7o5/m5p0mXXwozpw4zVmUrc8pvA1?=
 =?us-ascii?Q?j2SsM8v5f9JCVtvG6AlANJ1/mrqlGGKE3rmMEwHm2/S9nSlL2or6/jNuIIyo?=
 =?us-ascii?Q?V4s9pDwuYBSJWAeTAd6A1sJASX1GgP5yky1PzMj5u1UBErY8PmhlKHgzBTDD?=
 =?us-ascii?Q?ARbC+Dd+AWU5HHWZpPZoLOHG3h+MvSLIgnjO6l6uNEbWS4ZkpfyQV30Z26Tk?=
 =?us-ascii?Q?Puu40g4GNg1ICRIQptN6ea0+ZoVZUJ9LJPvYRjdA/3UDzZnUyda0YtfEv8g9?=
 =?us-ascii?Q?OX6dl6dnjFJt6V0kqB5Cxuhspr11HTV2yxJLPEfzY6AsDrEVsSfiAm8Uryl0?=
 =?us-ascii?Q?v0bmdSvj+NpEpKWxkvaKZm0NFyqGKNklzufMxI4Rg/iJnfUYUZRACR0ACSdv?=
 =?us-ascii?Q?Zqs/A4VgVr43dPNcLC5UpDI4S5CVSdDfsA1Why4tlOODt6a/JAdKcOdnRZS9?=
 =?us-ascii?Q?KDBJsu8Qgb1/zc3xAnE5OMucc9bai38jM4zfegmOyIuUD2Rua9K3gimhdX9D?=
 =?us-ascii?Q?zu6qw5NtrLNxqLei1KGf/dwU35zFd7a/q3+DH4ZGk5/aWJAIBvNtQ0CQl0Z6?=
 =?us-ascii?Q?p1NM/LAx9DVYcTRUHPo3X7WPUh7nfg2lYNlHfKLlB2hZFyYQ0Njo5krTm0UD?=
 =?us-ascii?Q?PRtzFBPJAEdzky3C788b79XokLvyi3jRZlg12g7W78RQbhatTDNJwS7GmxqJ?=
 =?us-ascii?Q?cphte9a8L38T0sk6Wyt8sMqH8H36KrDslbazGGKWNqm6v682vxZZIxmDLta0?=
 =?us-ascii?Q?tZR88bbftFYSEJeSxG1+smnpdbHSjfG+1ARBFOukYjy6tNswt0pTsPTe1g4Z?=
 =?us-ascii?Q?nJow3HbEY2ZptgTrmLDlVFjbjgWYeabDisHhXRjuaCEn77d55VEgbF6Tp9cu?=
 =?us-ascii?Q?e3SnbjytEgUauf9+Yhp11gb8Hn49S29iNKSo0NusWOOp6diwNrJNv9SLFGeS?=
 =?us-ascii?Q?MfJ+duSnpsd4s4I/HwocMWDBdA7Pf0TxSuT0YufPZXAofT7/WSD4cFmn5n8J?=
 =?us-ascii?Q?AJMir0R4wWPAnHK5YOP9HB8KxX+MM4JYfSPDo74YPOf5maGPl59Zf3qTwfRG?=
 =?us-ascii?Q?ajUztDT6Sf5scPhe70WTf1hQFSTCYildhX1KYYlviPBRUQwoTezj218xPk74?=
 =?us-ascii?Q?BcpclD82RSUrmWyBdmzqF+vhAza15YstEM2nIM6J1tkyzlZCvoTOYFoDOCxw?=
 =?us-ascii?Q?JAMjxlXgjbZxD/p3LNl57lAbPtwA06DBn9ANS8CGhouI+nGq9rJ7lVxU6Ggw?=
 =?us-ascii?Q?MhJeuHs4HTu2vHp3TO5DPP1NvpQRYFc3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTggdIdofeUm5CEeQFmuc+5abrzICZR2NiLkfjlqJgiRj5RDHYpanQNs7lUK?=
 =?us-ascii?Q?7tGsw+QNunbpkwqv7CW/yIYtkdXMoAzijFt5MSEOAGFJSgQpr+9kzNhjj+5Q?=
 =?us-ascii?Q?P6ZzIql0RmEUtCaJCraNGcCmfP1QA7MLQG4giiEK/gxlJubWUU2OR0GsKQ6Q?=
 =?us-ascii?Q?UN5a2RZcX0bJXWIihlKpebzDSNv/YpFr03qdP8JW+/FkVLE6z3cTXvRXIiEK?=
 =?us-ascii?Q?+m5YJe0NY/1IW3c2Yi7CJruaaSjM7pQMPj3Ou1uaHuH1Vaav+4qofp5iaiQL?=
 =?us-ascii?Q?rNlLF3gYB9PjZPSWwx19MQLMtmHFui04Ro+kEubA1zK7gLt697F1Undj//GK?=
 =?us-ascii?Q?QEuQzq1QbWLltF7l4OfAAtN9e1zrBEdlObMcvLC+RYb01wCUv2D12vAibXwn?=
 =?us-ascii?Q?rjIki/C1bOEGEhsPl4tUdFO58jcRTub9DykLJ6Z2v9nhLF2UAHkoiO+8xvwv?=
 =?us-ascii?Q?5wXNe/Zesu5sUD0+MGwurgBJR2lwZBMy5WjRQmZTvReBL1TucIk7FGWyEiQ3?=
 =?us-ascii?Q?fgm/FClAzQf670zqx53uR66Pu8GyuWkskTRnlZAtV0Q12e+Ci/2JwjsELRBi?=
 =?us-ascii?Q?a/NOTnBey/P+zX2tc0+IHaSNnSB+POqFxMzd6Zx6JyOUM2cfmQrh+UDZlCZw?=
 =?us-ascii?Q?78XU+nOnO+joOTCwMZb1eLTzkxCq7U+S3AHmx8EBrJx7wjpI+yoy7ML335cG?=
 =?us-ascii?Q?45kDomt5NiujkH7HI66pllDBU26C4Dwr3M3MbybAvS1/Ixy6BOoUbkTUlDQd?=
 =?us-ascii?Q?6lZDWS48Ky9cA2+ht1qJTljM+D4yFaQ6gSgTk1UCqcENiZwJUCQ2jX95Bmnn?=
 =?us-ascii?Q?aZkPVTt34Hdmjf0dUjGDadmWl71OzlqfEsA01C7ykMLZlizUcqtKSVsTultM?=
 =?us-ascii?Q?Y8z0m1uRgv+1iwsx+l8MAI8bzdi3PnVEFxhKuSeHIZyXHcndBqbkDA6LBjHj?=
 =?us-ascii?Q?LqYRlJ+1DiePMkOSTu6qfz0qZmQzh05AbzBzvEJymuN8fh6rgF0oBre+MsAd?=
 =?us-ascii?Q?8BtBNXkZdMu+vEt5BzfdEuDuckVb3VER1Y7oUGqNOdFMvGGPB05jrANpdI3B?=
 =?us-ascii?Q?QWUu3nR/mAWq0bOrLph4YWO0STodn3bvKywdu9MJKVxlsAQG5EBhIZR3LVyR?=
 =?us-ascii?Q?D7OQ9xYmsm2XKpN/2rNswXvpFKlc9IJ8ahsa6DL/o9i4TyNuonEUQIsiz5MF?=
 =?us-ascii?Q?ul/w3skziNIgTwsVvOL69c9A2qpKDouvafoXG0JtJPi5rGBiJKpne1EiCKaT?=
 =?us-ascii?Q?vAgvmH3ihIrOwQftd6pr5sTJDhsl3HrN6eeJzMH2pWQLv341ogpjqRha6Wey?=
 =?us-ascii?Q?wnCS/Q3DsCDWeYEpu/ITDjNNrpNNXGPvMfseAadHMPRzTHT9T+39I7Uswm2l?=
 =?us-ascii?Q?WAnaSX1Tp2h09Hg8sxGENiOYM8+M4CXmUmZGsXmCYm71nGj+NGbIa4KebFZw?=
 =?us-ascii?Q?evzkeO3MoVOSRsbi30s4hgT66Oa70p8XyMdLlOBA4yCXDJEcWaR701NdkcFg?=
 =?us-ascii?Q?V/x0SfOQfqj51DMmbCjXe8np/FeBDVZdwJKFUzr414YdmlyT31i534tHMIbk?=
 =?us-ascii?Q?o2ig0HzI+7g4zHzq7VfMuouMaRKUW6vj1hjolhTH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2bd51f-e42c-4851-6ffd-08dd6124b96f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:14:11.6817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctucDppou+PHmtFDS2qJhSJas9kHO9JUNeqRN0VO2COXcZSZmyanKX4x7u+Ppq6o8mmQwmhBMq/oWY/sCpel5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11020
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

On Tue, Mar 11, 2025 at 07:30:23PM -0500, Adam Ford wrote:
>In order to let the serial driver enable the clocks, the UART clocks
>must be registered first.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
