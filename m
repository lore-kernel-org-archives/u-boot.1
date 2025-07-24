Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CC9C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E270835B3;
	Thu, 24 Jul 2025 04:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oWnr2Kmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1776F835C9; Thu, 24 Jul 2025 04:03:20 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3906783287
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teq0LzZeO863fpzu6e2626tBtBIYpBQgkUgz3CslE6AUvUnh0sGOFs+qB/QT318XD9FWHdL6Ml+mHF/pa+BlA05CU79MjlI9CvKukxwY9M0GGQApg7ZWjIfpCOTkjeXEMvKxnEyzH9emv5Fg303EOx0XawPSNBrDi9wBO0l9/f5VqfmqNJeixBx4GBbLl6wDltbYyeFXEEEc7A8e92ogjGE/XHsHUTIc/MeooDMPAlzk6K6tJJYBgZ3GB7mqLK6IglBAEeD5DkwxP2edAGp12QVoanoWMEFu+6GFWLsAjNu9P+cnugDaiCivklHL7x7r8WG6hjLq1nUtEdUyEJTxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE4JBUjUgVgYkbTOBysoiMPJH9ztRtEwxxvUnRzu+KI=;
 b=aUMTwW+6rPhNPzuGVYTNzZ+7KQWEP6RNvSKB0+4Shy8igGDhg6em64wRAS0vmPg/9PA4KXdkfW3I1H6cR+eFz1h7UxhO6O/FudwXHbLQGU1VfuMrLmSco4evhMhp9T0VBkZqZA4HAazXXxQHTcVmkvhho4B5v4TArHCJb6J4YcgeoQwUsKnI5wsT+5nNSa7TBN7AVVE4I3qyIATAfz2EgDH2O5IRbzT5E1Q8GEXTzOTlzbvPThkni0SF9nlbLVJD4e9Ik7HXg2JICB6877zsWnTfuIQJlFzaEvCdxFU4+P1N2VVLOp73ukxjxzKH5LbyHPAuFfuA+ockdi17JxqE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE4JBUjUgVgYkbTOBysoiMPJH9ztRtEwxxvUnRzu+KI=;
 b=oWnr2Kmw+glzvHotTb1FkUG6fDM5SuTw3dDwp3ijBdfjDgj0tvKfpOvN3EWn9qKbaDpepV/UFX4sS0MPPqk4xggBxe9nEJs/WlqnBwdFjQSLLgCw74N0V+zOD3j7LIROJ0xt6M+3yACpWW9gynV8dqQ8TjbIBQdSxy1TY71MYtkBCY/M56PTNFn2jI9nVi/R2xHIMvMB1nxH4q/t8zDRKz7HzGfgVqj26QF4QSekbu/MSFTD81wjnHAU962RQImYtFnAi2t1ksloGHaMKL3RgK3jfH0uS0FA6uULijDALioQ5MHPtnyU8aEgUt+xDryqx501hck31D7eosuZHUi4vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:03:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:03:16 +0000
Date: Thu, 24 Jul 2025 11:13:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] imx93_evk: Remove unneeded header files
Message-ID: <20250724031351.GB18395@nxa18884-linux.ap.freescale.net>
References: <20250723134557.1972331-1-festevam@gmail.com>
 <20250723134557.1972331-2-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723134557.1972331-2-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 499e9c80-d861-4774-a7ca-08ddca564118
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cc4xWxUv653p+EQmEi/D+0C30ifJOweYzB88VmX+78ptOGXPl5XFCz97iUhf?=
 =?us-ascii?Q?BU1FEYq1qNqeRhpsAbqa8G687WYBK13AvtGgJ1IeJeZh4HoaYp94oalaGETq?=
 =?us-ascii?Q?30wpdA67PaI24k+CPXbSxnVUfDeXtV+5e79ueHCShDg68WnodkIER/6/B0RF?=
 =?us-ascii?Q?l28sOLw1FsGsllFrF1zoh5WuVwGNKujPgleyh4KBN+qfqMhqOB0C+PZubjL+?=
 =?us-ascii?Q?8BUUr+Lr7oDWvPqAgNxd4S8dyw38S4ueUIjO18Jq9FR94C959m1ZXP/ZKcwR?=
 =?us-ascii?Q?K4WNA/djHpqU5q9g7a986YUbxwTMMSjmxW8VZw80kF7bAY1/v+MEA8ExFWx4?=
 =?us-ascii?Q?1/YWai3vd3rKQX2QvRt5KgOtFcd5l4Z82w+ZpvjTXawxdHSNyc1lcfUgqS9u?=
 =?us-ascii?Q?Pap77Gi7rbHs+6O+08SG+cmFJVlpRuaymzGgwLuhBh74nMiHhAzCvRvdHeL3?=
 =?us-ascii?Q?euzhw2G15wvslKFif1Xdbzau6GPhfCMkm33IM1hSkyZAjBTjSul2P1vD4Vm5?=
 =?us-ascii?Q?WTi9qSaYFRdBBT/SXxUlRfnis/vmJYYdRmib4TaF2NQanSPnFOf2Bq67vJey?=
 =?us-ascii?Q?5IG3bjSg+ZheFB3AJddBSXDv9/S7GwbhB/xlZ1UuML2HXjyujQ1hW+pTJUsw?=
 =?us-ascii?Q?CNrdiVjhw0a5Up50sztlKCmemyprMOeO0Q2sOgph8UyhMyU1MKrlrQRIhH0A?=
 =?us-ascii?Q?n/3fEY/YGbKHmDuNfbCh19ICOvWpMlasHLBvWHCXNOzVtb4uDxPW3nGltgSy?=
 =?us-ascii?Q?gSlTl0yC74DTMeShOa9jkNuvmXjeo+XQSEzuF12c8qmUepFoXuAVhs0CZt1i?=
 =?us-ascii?Q?I/SSWUBnhN00O19GuklbH58cAwrBTf9WBhvmmql0ALCyrgw/7mFD4Yz+egC/?=
 =?us-ascii?Q?FKuI+1Vh7AqQyz8JYuNDvhgL7ZPOABDsVbHQsPuUm0QuBKgR1vImdRJI2ph1?=
 =?us-ascii?Q?ZUjIUP9lYRPF5ycjM399tsez/fezjkhXgNHEvEpvuoVTLyuPCdNriKCK10Rq?=
 =?us-ascii?Q?ksGFQldHAJU/OGyVQJ43LbkNrWxobEcgQ6jkDqMiWSosEQ92Hg5Cq9h0HZtU?=
 =?us-ascii?Q?/jbyoEQCBWFtZvsiMv9d6+Cve5856D9VH4BVblXJ8M/nrgEgHA9gJ8YHhh31?=
 =?us-ascii?Q?T9JelQg/6Xd1uy5XqUOtKKjmPTEAseKSlZqThNBDjJilvIy/Xu/aW/zkrP/N?=
 =?us-ascii?Q?EJTO0ALDnjkSF/UDKTOH6WaUsPm7fHBnnW8QAhxXJVud8dlMqwVHtFG25pfl?=
 =?us-ascii?Q?EMplhY+hGcy5MUmzLbeAGizVLUj9RCcYYKJN0c/bilXhgZqkAyPz+t6RJyvi?=
 =?us-ascii?Q?XXXsb2g+BSzVGpkmORRgp0KP1SFtyi9C74jiKXQ+ZJoOlnKfshy/lrltn0IW?=
 =?us-ascii?Q?Tk9pBxwmAoZsseiyFQkPxsj+1j9tKWyPq2keznZL/B+s/Cvhk3iLwbFA8Esy?=
 =?us-ascii?Q?uRQkLA9soQT7uqzwdkbmi1jcsPfnqsGqnyaZelqgQwD4FuRmkyKCwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoXkZdQE+4VEMmd1m0sqBRxqhYNzsN4gRZjyB7kkUorokQt5QwHgwU4GaAKq?=
 =?us-ascii?Q?qEfAwLb1zduPfs6uhfIyx1115ZhvC2rOVbalo6UTxecJkKL+xesu1KNvuFu0?=
 =?us-ascii?Q?kYqLTYdsjIIzt79YlU5VtsOW7JZ6MpgTKnuIH3gJ7SSsV+ov1CnnxpdY+jme?=
 =?us-ascii?Q?Modf3LSyRyDQwu0shFr+eWANISKaWM4VTJ0hJGNhCRzb0/FBr94qeME7jh89?=
 =?us-ascii?Q?Twf0YkB6OX0HHsiVBFjQBQZUhZCnlG5zapz133ov/tU6Nu9Hq6vIqKJlLJUW?=
 =?us-ascii?Q?fl6YNM6+uw760W/HrkzCvPpUhDVZbJmex82NjfhSas9a5DIOosXCoXpczcDJ?=
 =?us-ascii?Q?uqCERZXRnj2OUBgF1/Fj5VCs06fZSP4ya6f7TgyeVWOmayUcGmA+FNuhdkV3?=
 =?us-ascii?Q?DEz1OLl0G9nB9/8y1VCho2AszvWwZ/ghVtV4tzUDrxU5bnQCzxr9vhOMGVjM?=
 =?us-ascii?Q?kjgU8nWXwr2TbZFX3cG5KVBU+vH0oJBt1io1YvhfQ1gt+Rw3AZhXULhbhO5e?=
 =?us-ascii?Q?jWIQ15yq3Cwe04n0AA8J76Tqu/htdxk8v6Xfx/5ltcj7rJqZybI7fJPGNf6j?=
 =?us-ascii?Q?Ie/dEd/wC/VWpv8aHGq68d1UYEQhk1T9eOBm6MFJPax0bUqMLpefdu+4KtWN?=
 =?us-ascii?Q?7JN9kR/WzDS5U0nxcm9FpAIIxsEKjJCEPx6DyRMNh2RHNOvhMh63w4TC2JI8?=
 =?us-ascii?Q?VfXMTu6WnEteQca3lQQt85gLVPf10L/RVnZwRIFgq00ip0f+Qe7O7RPcXNyb?=
 =?us-ascii?Q?imOFo6gyu461EvGNS1n0eRdnZc1Ch2iJmjUp3c0iaq7KChQXgQtl3HnqBeeQ?=
 =?us-ascii?Q?B+Du+Jxgd7OtsrPhMisCFlCaul8AYJfTKjzXXBT2IAWohNfAUaWYNzOq6CtP?=
 =?us-ascii?Q?X7HdRjGXmI3HKnZkAWN5ml4bSXdO70bEj7HxHTJMlHlcSgl2ubAen8N7G72l?=
 =?us-ascii?Q?C3W3FEN1PgMCk8hSuh6Wr9+XDS+3G38nPpiaYMf+69YR20ttVKwPsEtpREDT?=
 =?us-ascii?Q?kavNiApB4S62xmbVs9wJFh+gmjIxWk5aQtDIPOBkLrw7PUZC8hshT7Y+DetQ?=
 =?us-ascii?Q?AkIXO9gaUEKfYSgTCmkFKbPK/3bFIp1dBN/xJTwYjUTUiM1gLs/2V95fwhXY?=
 =?us-ascii?Q?QcnvTmDQ0GZd00y6DjYyPzjJrKDcWIdMMzr6ok9UeFj+IXIu9/GdjMy+CUxg?=
 =?us-ascii?Q?SL3JO9Ml3dQAypZygXzUzjUyhwLHuRg51m3j6o1HyKd4mKYkxijIkLwDQXMb?=
 =?us-ascii?Q?aCN/EXzT0widJUJ6Ryo6ZK+nySR6hARUufpd9ylYtZ6Vrm/L/3/vCZ4veYne?=
 =?us-ascii?Q?stxisJ1CIZHswFTwrrZGpscvhCZHkh4emk7gIWzH6ZkLDfKAdu652n1qMG6+?=
 =?us-ascii?Q?Cams3+yFFUD1+67AQa0kJ8LP/enx9AN2BEYYAL3bC6iyRIDD8P4FidlJIAMp?=
 =?us-ascii?Q?gaf+xV8RSSfrXUkJbuO5ZHYY1yY33bo03wnkSshHPHB6ihgK+ufqbAIoMXaI?=
 =?us-ascii?Q?n/PV5mzkrAh93Y5k2jysvd+ylg3aR8uoGZQyuqqWQRafq6CulQvtFGVOG5kW?=
 =?us-ascii?Q?gDXKUB0WEt208Ntfwx1axhH/3/2p8RrKzONjH3c3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499e9c80-d861-4774-a7ca-08ddca564118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:03:16.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9nyOi7RO0jnAfuSA2NVk9uKzAvdIhLtfNjNmUgIIm9hK2uQSUa8vegJSNpecTboBj15hSyHifNNdRoTWnUNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
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

On Wed, Jul 23, 2025 at 10:45:56AM -0300, Fabio Estevam wrote:
>There is nothing in this file that makes use of the definitions from
>sizes.h and stringify.h.
>
>Remove them.
>
>Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
