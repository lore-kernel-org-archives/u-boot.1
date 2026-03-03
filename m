Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E9EEB365C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 03:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4C383F59;
	Tue,  3 Mar 2026 04:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="af0ixTO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78EF83F63; Tue,  3 Mar 2026 04:35:24 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D15383F4C
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 04:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV+Mg8TuZB6VHDI3U69sVjGreA+C8+X1GUoVKEAP2TIUkRRxTiRYcoCnDH/nnqw1hzykRrj04sYqL0bQabXl0JcbCTNz+iRlhjkCFiyFPfJqwCilJ/2Wq9bqahcPk/q+YS4GqlEoq+XAoGdpR/c8u3v6tjBbDMFpsVDXmAsgkDQYW8NqgGbnoWeLSVeT70GnCbhImg/t2/6fTVD1PgD+GbfWjpLQJYk4qU0W248rWlUSiJPWxyFJL3X++03m/rVizGJGGIsY69g9Cs3Z0FjAkba0s4DY9hrmchDm0Relfia89gdUZAW+S2osAZektWLPtVaCPDepFkCDaKxnY/H8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkrDSjEn1VAMnz4L9R50/yP/I/YQXUcqqruljOSuQn0=;
 b=vD+O53UxErISU9CdrRhjHz5f85Bq8bw4lKlFpmUmTZw7ahO6wCPnNFLKeab3WzD9Yc/233PMcbvotDZPuB5Q9xKwqnyqu/B569Szh86v1chhhkbvfPYawsjW/bSJDOyU5QZX8ai+Lmwc0oqdeqRWgmNMw9tpymsKyiuIYYSwBG7gA6nhAhvoFKVl/AkBK+qI4INvF/YFn96fDkONZQmXfuqV4SxD/i6RinO2ue0V5k3Z8uHylBQymk/n+FGPKia/vHYC7me7KgVLiuNdhkKDPObykA7NTRqJNpIXhUIIC57t2f3iATChchw4WFm9pGGo9BymMfV1Q52ze6uJvgkL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkrDSjEn1VAMnz4L9R50/yP/I/YQXUcqqruljOSuQn0=;
 b=af0ixTO04AlEYCO9b1UKfgvHGlnCdlbuWYW8tvl44TT27kwypzVSTjvXw1ctK9TL8WiQt2Yx5fjYPGRKEb4qvhGvZSVG4tRM180KGOk7JLnYO22rcX11k04swjzy1v7KDeRgmFdNBdLQ34MwOWKCqARW5fXpLPMaWvWffoeUg+VGhhnG61Pqpj2KdlxaYVizliLVmRqgJTyT8kgnCDoVt+0YxNnrEjyScL9bA9Yit3cCt1NcqfUaZpGfW4VPhQolZd+FuFlPQ3OTfaMQX17dpTBH/AoFM3FTOZOZWfA3CPUb8Y3PIBdHhDHdzTl1nl/T0Uxc8FDkTfy47sdq56vQHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 03:35:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Tue, 3 Mar 2026
 03:35:18 +0000
Date: Tue, 3 Mar 2026 11:37:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de,
 samuel@sholland.org, Guodong Xu <guodong.xu@riscstar.com>
Subject: Re: [PATCH v2 14/16] power: pmic: add support for Spacemit P1 PMIC
Message-ID: <aaZXak9VFCAeSabr@shlinux89>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
 <20260210151459.2348758-15-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210151459.2348758-15-raymondmaoca@gmail.com>
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7863f3-f874-4382-4f39-08de78d5e41a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: SmVfXzjpVajVyv/fu0z2CIup9RNNgzCF1jj4sB3siAMEvwP7jpbYekDzKrhMSrNdwIekcEbXJCyuONLGy5ukhsui33FGtMIMS7kDJfqxrIEsTlP43GWYahX7sxU6wMv82NIgBht0o+pIhHEH+mS8toAwn7HbIjKguxciJy0p7ne3E8cnAYapMhYwp6Sa8UqHjB/CmKekoZwKJdqW14yulwVKMB8OSSy9qfQVuPzpY7dVZ5mTcgx5LAq07zbCguTcbABx0MgRS6Jn8jf1ELMyXERx0EL32ykx1KZzwV+qgGDGRBRw6q1R6ImCF6usnJrEZclm2kFQ24UUkNRSFKFIsKIeUBELcBdMhq5OaLIG59rT02VejI/jyKSFpDUPGCr+vjwgg0PeoqF0iY3Ov0NM/NIG6z+uOhDfK+A2La2X3bzXhtP7NH17jdz6/iL1FhDqx7NRE9Elca8LNxMDglUjxY6fNpescy4I/KNe4E0CtIVNzXM5sR4D3NXLPXyVmzpjiNCcmYGB6QlWD/l9/ts2RR9ItavYRRJ1DceANKSNIIzd7RgunafsC/HPqmJAdbAxb85nE5IQSJLv1/pyk71rCiglcrfDZ2r5m47WsRwYUC9uhk6p3okebXCWtOssQFC8CF5ZJeBdjMm8gknIJaOhQn9EEXMzoqSTEPm95jwtY1VlhMN53zMy6TQTrQVy6FsTseOKDpDDKcCLrTj19rY+nkcLDo6xbV3qZb+5b91ocI9Zivc4zOBIg6bmiZ6d0kMmqh6AJtnP6WPYeZVyED8rHSaKnDXPMwrpQeLF8IQIHWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cp4qRM9pQModiNnZbUasrPvCh47F9aGnNb7x9pVxLj8L5IjqE3mqeYgDYuHe?=
 =?us-ascii?Q?jTjBWDRfbsCUpmLRk2o3CROFDD12pGxu01Iqk7ZzK9CnhngytzysFuy3lcse?=
 =?us-ascii?Q?/EAVm0gQ+Z5CTTxzNYC7odzx+30ziFdXdpFjar1B5KSRtaXwqIgtnY93IuSB?=
 =?us-ascii?Q?i+QIXw7NPdcuigoFfv0FCfEdt+kgUfORg4F5yLEU9dUlz2oTaJWAoK+CpX2R?=
 =?us-ascii?Q?CHw563g17GAWfdCgf2PXmWwONE0rEqvN6isCrcT9AASEgWSq5H4QwB46XAu6?=
 =?us-ascii?Q?ymdXkiroj7nxaLn3jIZrPbAW/Ti00rMFKtc8TK9e5pmJE8KTpWDEgG0H+9CW?=
 =?us-ascii?Q?qVL5+XTrp+w+XsK9vtfEE5nEGL6L3+LEBJNJ0N7LgL+3lrdNv8xQD+8qcu+d?=
 =?us-ascii?Q?TD/MBeljOiQDb8jLdkFcwDXeIXqZca1PmpryZt3Xla3f17ckoOkwVkHV2I3o?=
 =?us-ascii?Q?Jr9acLLScezp+OZZ2VlQqJ76dm5s0aNmoP6QtbUQT86DA92gYcTGF3+S4jvU?=
 =?us-ascii?Q?U7x7GxTZt6Ld3oVI7rMZPt2/31ljVnoG2EgZah8gUK7c1PcRrkFTeftinmrX?=
 =?us-ascii?Q?/BZ6BYFWk+4n8L07qMrALW9v0xOnRCJWpU0aRINy/3tfiuxse2qsb/ED+jgn?=
 =?us-ascii?Q?yWXC/RpTP3w2AEtn2kZbLeMTnitaXlsYUHejx3cK2UAKC9MCzRvC8loSC5Sn?=
 =?us-ascii?Q?okDl+AMpPDmDOoHJiYNz2dp5RKOpoYcMUfkeHVVaDgu8vzq1QIBp6Zk6FrbH?=
 =?us-ascii?Q?nwJ3Qfu8L2zWJQcCrfOTbkWaIWZkCriW9prwHSQMnLUXgfbMFnWqbA++1yDU?=
 =?us-ascii?Q?l3eQ9/n8xl5baOln8Hb32GGUPvnyeCQ0vrKt7Ty0ED8SHgCrsvBnLem4QzOp?=
 =?us-ascii?Q?GWduwYoF07NWLq/hXN01U6ERCCa3BNoijA2arOi5Bl0w0Tw1sRr66GxjO1w0?=
 =?us-ascii?Q?pm0J2V8S/AF4PM0cAMl6Tel1QnIfHc/lyCCOPXBrGVMweA1emDMr5+GWLCBj?=
 =?us-ascii?Q?TkHitZX+OBYTYMzi2vUC1GPvRdJZSkoQOP1O7kPYeBnX5N0okO5k3MnWAGJk?=
 =?us-ascii?Q?8UGbD8ZhYqnnykcrTUcBFC/WA9c40d63Q8E/2TqCkiOOWMisn1yPVy5O8UtY?=
 =?us-ascii?Q?ywtM8bbeY7m0jmawa8YNOzMD7gsW5R1uUEfC6PtNTBMwxY0bvEhtkHHkQD3Q?=
 =?us-ascii?Q?IeBzqby1n84eJlybjNnZl+2azzdNlis6AfulrYPmaqNih9AY0+vgl/b9GKEH?=
 =?us-ascii?Q?mHaFsPm4BGwVeul9ZO591S/PzjFOJ5m1XQ5ElfdZiHuroc5GsfcKBiPR+o/H?=
 =?us-ascii?Q?GJtG+GcOufII2NNFmQAHjP5wa/jaibRj1Qy0ub7OdF/xeU7vvliI+K/h8GrO?=
 =?us-ascii?Q?wXiLCrAN/q2pleb7eCLMZ1m8MxX0cnGfHxNNTtVERPOdY3mN2hl1avTfLMyK?=
 =?us-ascii?Q?6l7K9GRlOQWuFC/E1ZZMbe6aL8RAJFlmjb/mUHKuYxSQI8p1YuBIuY2T4nAq?=
 =?us-ascii?Q?jHnFwR9ZwyBE/TqUgQpCjMsk8XB97r148YNuR1fKZOpQqPdJgbznEehYqqsG?=
 =?us-ascii?Q?kUBPOyT1ytF9bsGvRV0XRkmCkZWwPk65m1vpBvzVlLW8Nt8XEe5ls+DE1GQU?=
 =?us-ascii?Q?Mq0BHXRH8d1UUQRF7zOfLQDjE68pVZjnUuPCjtBTK2EnQ6hPJFDMw4Z81MCi?=
 =?us-ascii?Q?lcuy0srz7scUzGGn0oFsZp3lgzPtruUeyZ/oPuJ7/2xKTf4COtR4fgVYtO3J?=
 =?us-ascii?Q?oX3gNDOZ3g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7863f3-f874-4382-4f39-08de78d5e41a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:35:18.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLgfWflSn3ThJk59txOv+TDtf7tymln8OweFC5652GoJk15xPzzN3ODZiusc8HfO6WYF7MtsAhW6kkba6mQLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Tue, Feb 10, 2026 at 10:14:57AM -0500, Raymond Mao wrote:
>From: Raymond Mao <raymond.mao@riscstar.com>
>
>Spacemit's PMIC is used by Spacemit K1 SoC. It contains voltage
>regulators, GPIOs and Watchdog.
>
>Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
>Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
