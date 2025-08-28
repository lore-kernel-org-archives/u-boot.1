Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66549CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF27A831D3;
	Thu, 28 Aug 2025 08:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iVPjZ8Wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 750EE831D5; Thu, 28 Aug 2025 08:35:15 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BB3831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0SG3/dEvKHF40i+ZOBTURS4NUaDgv+n7xo8KoHFVCRg8wvysLq9eYuus/yGwHCafeUoZs3R9nhDRIM6LVR7rtWv5aCHsheDw7oVfvBoNQ6kNWnJz4jDYznCLFHv8Ac0kVE1eCj70JfIxjaaT/6COpcav3BuWR8e8g/lAj67che+mVm28tutJc3nXxDsYIusO7W7sXDJiOmc4I7jrH35GztyL3L1FShZYjaLZ0Mjzx75fU/WL50Lir/HFWcDaI1w6vlhxn0kioS0vEzU4KljFSI5MjpSO0hQP22p8mr1djJsKPPmTmfCauIctGG44uN1TEsoYz+a2OWU1sgdA6w/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwDxtdG7t9xJB0MWMt9OlyVlL2vwkebXea7Ul2M3hb4=;
 b=H6XtlIo8wS864M22Rw5nXUR1ZQ1rRA1NaKozxJE5xfIy/kOZTo7jSLW10+GAwmBc6K5pjypVl4jBedBrK+4CYApqpfpeTRI2RlnCxS3Gwb8G9+P2Zw2apVgOWkA476o8d224JYCPDG+Vs4FsPtehhQvMDiIcPnDaljsmoXWLqgmJ85JjZ5q1784YiCXiT3Z612QCDHwSamwz4UOGhGCWMoSlH9cO647nMgeyXf+0ZGs2zRrXOdBXE01aHFlhKxFKIcKL4wll7hsP/jUSVzylCpB70i0noxj3UIeRQQikmRhxYOfqSMwo2vMJ96SSa6WNebALxkumLnEezHe81be7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwDxtdG7t9xJB0MWMt9OlyVlL2vwkebXea7Ul2M3hb4=;
 b=iVPjZ8Wo3fWMF4yjlIgwMoAL/a/dRrAouaGGQLkjQNumX57HC5vNNJlJt2wczXhlKzAJF1wM7CeTq5BmAVRIvvHRlyBuAr/B6OAUZ8m7r25+vyiiQ1XyV9sRo3YQCt8BZVJ7+XXIq9CGDEONIsGUo5d1kIR7kjM5vT3cRxbXS/mZjL/i/MTBbfWuRNtgLNHI9UnZABr5T9+I8Eh1B9NBUD1mXVo4M8rQfj97ne9/1nbHzSyITmsHq3uQHq0pkHPQpMjSFsCFTDuORJRe53lCYixZTGPK6ynWO2XImxHHCTIFTi7jadmGLaR0SwZ0yJtFb8GrataSOy1h7AgO24VTFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Thu, 28 Aug
 2025 06:35:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 06:35:11 +0000
Date: Thu, 28 Aug 2025 15:46:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de,
 Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: Re: [PATCH v2 1/2] power: pmic: pca9450: Add support for system reset
Message-ID: <20250828074626.GA30280@nxa18884-linux.ap.freescale.net>
References: <20250814094741.4177431-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814094741.4177431-1-primoz.fiser@norik.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7832306f-62f8-4382-a3f1-08dde5fd0957
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UJ7FF1nLd9YzWddyp/uych6uN1eHY4AWH/h6u/I9Cnv/Ku7n9j95PfaLWVwy?=
 =?us-ascii?Q?ux1DI150XpPzVDTx1oYU9zI2coVoEAFDDn2WQW0HPYrpBwefD/5Or9W3goht?=
 =?us-ascii?Q?j1mIBWCqdUhxWZwguZMdyjBk4fSoX8LecHqioJ4ANr2u8ifzZpKnB4hbzHED?=
 =?us-ascii?Q?9RBfkMRxqslTMd/1i61F9Ws54csTumLCYQk362vlaE8dMwpIu6JJX/GbofeI?=
 =?us-ascii?Q?Vd1gdHvJTNejWCadx03vWeVjnV1AwWHWZ2ln3zNbdAYZc/NLjp2mVCiteKHw?=
 =?us-ascii?Q?F3FQcJshtj2UkXXQPHYfFQBXivipcyrqB5OT8c3KN8+sK9TwpDSamAXMs2u6?=
 =?us-ascii?Q?Bw2gog3pea5lveS1SFQ5+PlvlkxDxRbWK4S5hhuwDZ4egnKogWBHuGJQAqGG?=
 =?us-ascii?Q?WOaek2lgzGHwQ8EddSJlreL15n/lCyRkGQXe92x5o4bkXFpa8oyqWKIRpf0R?=
 =?us-ascii?Q?H/zJq9rdDm4d40oevcrn5LSvVPDJMzj2GUs0WHV9JSMXIvX46x97kCKz9kMn?=
 =?us-ascii?Q?qCrxImI2Mykc/iSQfgKQ2qnr9VAczEFUqZsdWYVpnBWfj+S2y8eTWy2UJYuw?=
 =?us-ascii?Q?kbNJfk7ozop9bkBf+elc1dOlPP8fcBvyyLsFE6DTaB7uZlUT/89g6YFFUk+g?=
 =?us-ascii?Q?DKliJVO76B9UxfzrYZCwwPXLaAeZNXraw9+KywyTBnrJaTP2Ljj3xV4iCOEv?=
 =?us-ascii?Q?ErP5t7OCOLoFDNJbbbfoCgyirmktHsk50ZR+1Y7hG1qDf9N61tl3OR2hguxw?=
 =?us-ascii?Q?NZwBOykKIiq7vcIrjMRkMLKdtKbHUCFXuyF7qPmyhPJtk1NB9Sb8k71XD9MN?=
 =?us-ascii?Q?NFion1qmE9EQm1gSeG+50CZr+mPBQshh8RDMOSrotKBat6ZMA7Gej7mSn+LI?=
 =?us-ascii?Q?gZ0SMOuMRek5jWEazK5qgUYl1/b1gYeo+e1v3FH5mWI+4NWef7c4ABFQGHh2?=
 =?us-ascii?Q?/T9CZ+xdjByyTGm4SB3DU0wFad/xSIHKCh+Q2ElROpq4CURB61KQSpCoAu0l?=
 =?us-ascii?Q?JQqQCSnkD7biWK0ccXzxgHjfkeanraSsCjqX9MWRtJorJ7AovJPU1hccOKyT?=
 =?us-ascii?Q?WbOfBN3NoYLBuC83b/Zoh/iJNZm6aWY0xAULGb8HuAQ+9lpcOyJkIoTOpxqW?=
 =?us-ascii?Q?ClQ59/SxYgLMVEEA4qUxFccQfx0a8Ap5q3EqBlqVmZn+OHWtWPYVb+MiGiAE?=
 =?us-ascii?Q?E6BHUAZaj56Bgt3VmP3IIMdy78FZDXGbM7fnxR1333VipH0A/cyjJhTab1LS?=
 =?us-ascii?Q?0cN74Zn3SoH0hNWOuBaxDGZ933UnY6sRtzdE5x5r1UU0gOxPAzoXaynZBCt3?=
 =?us-ascii?Q?+lcSg5zk8mXfoKcX5ADjdepMv7eglLHQ06UL9QHOKz1tToVJbqD1/zf5QwSy?=
 =?us-ascii?Q?Bb854k6dl6aH9QKIhTmyvLFu7zupUbzkd9UdLd4JVsHRc0J2AU1u9b6B1/yG?=
 =?us-ascii?Q?5i+cHY+EC80=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZqKuXJRyi8ElvzizWr877eMh5HYATaBnz8gT8Gkr46PGVM26bGyXbCgbiGy?=
 =?us-ascii?Q?L2T+BdMQWeF5aBp+Q8GOvc0tgLUfARf3mjMXhFAvZZfuyb8Nnk5apd8G/YbY?=
 =?us-ascii?Q?YVT9xG1IFOh3M/gCZjx++ACrtVyeSzVTgjEraW4DfAdBQzeNXd1I62JhoXX0?=
 =?us-ascii?Q?C0LXj9ly2D2Or8oEm8TUxeXoSKcVofOTs/myhGNXJwlXNzDOXEqFnBaro3i9?=
 =?us-ascii?Q?+humclZMLohtIDsoeASMK+y03GMSKwwN08E7VBhyNq3Jy0cEkYgM4dVwahCC?=
 =?us-ascii?Q?TaSK+RofMwj8iKc3IhzphRtMJ/W6ecuJMSE2ExiY/JwYtkq+JSD4bMq0SSEV?=
 =?us-ascii?Q?JuZ4AZ6rBS9GvoNzQBPwdLGksPt7wzpKn7eXAH6UuZrGpgWciz04utKPcimf?=
 =?us-ascii?Q?m+QJKahVx/Temc2hX67OFNmmAvASQRPXQNoOX22YEdSTgiOLVtH4vbu26tv7?=
 =?us-ascii?Q?kP4DEWnHvlne358ah6V6jVw7nSrMZnnZpD+VBLJnHHAP2XriXuESqVKhMyUm?=
 =?us-ascii?Q?H4RYg7Jn6wi4DnuymvCnMtYDuAAPuvlqfbzFNFUvs0+xwYM5/DYhAqUYvUBu?=
 =?us-ascii?Q?l36bU/pIUtsvZm5JqxnZ/fQOnhdXcEo+D0ah4rFZ0okLwWf8dr7nHd+Wg4nX?=
 =?us-ascii?Q?pHmthpU+W8CeQeOcnfAJDfHSzbQjFwg9Lmg/84DKnDQPzc4eDsmayNQjtga4?=
 =?us-ascii?Q?MyuvKF+3rMvBgtoGAPWhrQ1IDZ7mJ65td/eeSkuaimgm659VZRzAvL4oUewa?=
 =?us-ascii?Q?5rykEWxb3oNF5MN/zf0YvXGQDInk4QRUTmpc/wvnpaPdQWloAQ0xehvKhuom?=
 =?us-ascii?Q?jzPXRUo3lk2AhbFOiw8UtRRe0ArDCu9qLSmm7cNho0JGhW2NKtd1KKKzSrhU?=
 =?us-ascii?Q?tsW8xt4Uq8rBliGOBHG8BWUC09xOKlGkduzFY/NHlr10gORYghxfbiY8XgKl?=
 =?us-ascii?Q?jGplWonwPA++/dSc1xDbQ98jTjo9ON7R3pJV8KZ6fut4pPso6sSTwBuP63Zc?=
 =?us-ascii?Q?WvmMwrX7fdtv9yaHMTNMiF0m24d1JtGAdWxu2hkfDs72k14nkdt1HYX60CvR?=
 =?us-ascii?Q?osgzmglqfP7EuSDW8OQqt7DE4VdkJdV2TRcteMixbKhkDkRL5ON/wd7O+B0r?=
 =?us-ascii?Q?V4NlFgKJciOOeFtv3Xo1MCD38hVzbrIt3z539TkTQDXzSg0797vwGUfQtOJu?=
 =?us-ascii?Q?AbnnuP3e+MWbf04b+/Z7ulVZRJsuKj0TZXrGkjjjPZ8yJXCMil//yi/8d073?=
 =?us-ascii?Q?tSYkALqkrIyZzIrZe+yvpGgohmEnsM8k+sTpjxpo2YmTlIrymhjREsrld5gt?=
 =?us-ascii?Q?cINnWnb7osoE1RM2AoRSqnBSFMsRnRYp2+C96gXa844yyb/PhWSHrjoB/7bH?=
 =?us-ascii?Q?TYKUTkDw5G9CiuhExPw/l9QsSXb5Abo+xv/zsJ/MTWj2IiMsqc6NhJEztyEW?=
 =?us-ascii?Q?9dW3YUt1yYN7n78G9nY77maOzq6rTvqYN7b+hspRHv2fXfzLajAjaWbpoGOT?=
 =?us-ascii?Q?80lKZVoLGmhIiXP1yhdjqTtWFsMvnYa3vLFbN47EbIh5/GEhnZmyMHSPjEds?=
 =?us-ascii?Q?9Fu9kP8lzcOreKf2kSgPZDXl4Iqrz+CCyJ7VoI5I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7832306f-62f8-4382-a3f1-08dde5fd0957
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:35:11.0268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbUN7Vsj+hHHkMP6RoeSJTLISyQw/hPQfmoDF/KVBfbkyMH+/exhYZ1kp09pZkeWkprP2Gbdz39r4dMpcNF6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
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

Hi Primoz,

Would you please rebase to
https://source.denx.de/u-boot/custodians/u-boot-mmc.git branch: next

I am collecting the power related patches, but there is conflict when
I apply this patchset.

Thanks,
Peng
