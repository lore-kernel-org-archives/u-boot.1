Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF132C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C44882CB0;
	Mon, 26 May 2025 09:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pH7l8J0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5A482CED; Mon, 26 May 2025 09:11:33 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6BA82B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXmKTf16bBok3183hY6FkmEPECu8+UBgMdXcdsbD4lBcxC29EMMiah9hysX1so/a5UiTYoy8MPzNyDG+GYvOn8g8XX2XX6wTP7q31Yd7NGvpEwosgCDmrjCXmzUWRiuK8qN+EkSLpQHS/2m67pSjmcU0y2RfZJsA1s1aZFzA+8ccIvk5dcu55yTwJPV31ioFv9rVvQ1eSfkYqZr+Y7/oqAMb10GZ1STIbvznGC1ZT9Wol741FP6f9luQosGUEzsLEg/h5HFsLSCMQJIud2QCUsiqVOIoihlQ7cZnkVlOojRkG0ex/CcBISfyaoLvMCzx91eeH6EZ4EJD0OJLkHnI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN33KU8/jHHHOe8jKW6PZIA8V25902+Hmw6YKBsmJBk=;
 b=yzkmHi15M7jHPQtT8PzmgODz3spHpgZK6+lm1mcZC6RDvGKexLp6/p7d8tMeEAseSuIHj6UKMfGDnL6h5tX3LkvDRZsdAB8R/ZyzuA1rNZEn4906XEB5ZTMxbIriQFvpZ7dni/jxDIB8zuVky6hTU6dLM5OgTBCnTN8ARcCsIjz6pjLV5SoxsIJXoxYjssinF0RP2P1LOa4Dpzc+Ccxgo0NYOEFElL5azDWAZgkod0kxVEw6doALR5wBfszJI9lCzjN3Oc1e2IU4deqJOORVzelRD/HYVm011m8wZOcmO9BGyw1mTvaPm+yxpf10pCMukiM1B0gdO/P0xalDXbw2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN33KU8/jHHHOe8jKW6PZIA8V25902+Hmw6YKBsmJBk=;
 b=pH7l8J0ZEc2Bz9N5cfhRaSInnZxWJ498EOsQh2m9CLLPFbbomQWrNWPc+E+dtN9lH4+AOsEFkppMbEHVeXnMQSTQKuw8XoEgRy3zyuRX7OudpAf/M0/2ROmh8EkKtAI4iyFY+4qtQW5U+aJtiqtP5wXw2lju4kS+BV/8uXEOvAoXtcUQVm+Okotn9Wd2cr8sf/qcxXguI61VwBFnM5TQMNJojbQufQgVf4XHC9PgSsa8ox3rgwHnXrbfrdkzxh+CDwVHPhWWLAANXJYoPbTlMmzwCYNPuRtFC2iGkZA12J7Hfax2S6jjpgb6ufwJCU+Xvy8xW5385KSHxnpIdp7MwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 07:11:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:11:29 +0000
Date: Mon, 26 May 2025 16:21:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 02/13] configs: imx8m*_venice: enable GPT support
Message-ID: <20250526082115.GN19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-2-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-2-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c12544-b46c-4c9f-b462-08dd9c248965
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?URNddqjIWcG+8vbDMkYqlZzzZamVTlnlsfNnSwF0341SzIqQ2N443RsdugFR?=
 =?us-ascii?Q?2g9GHPCVyqSC9ADFa5eKrfY4cAKvjxbl6GP081Q9dMXmuC0UhFeif4PmSndr?=
 =?us-ascii?Q?FV30mFPHPDMeavj1wfJwZUWeA59ckiDywBcLQi6RT7tjy4FPMLaGKclbRWt1?=
 =?us-ascii?Q?nlx0KYGjqFHqxzOWPk2JdVMgdUDg8QGtITI4FzhBO5kTPE7ycpSswbyqv251?=
 =?us-ascii?Q?msiWGrvVpDwsytCMlAtnfdNKzkbaWjHNfjC4RQfGvw8ko2dSsPcWI3Jdpk07?=
 =?us-ascii?Q?XEB19cJ8BlA5PD/On9SuPHz6UxoHAZBGzdm934nXLQLpnVQFcngMHoe4MUKt?=
 =?us-ascii?Q?99AUY/g6ru4IzsE7M3VJlO5GfX70R7rIlymPLWUUht7eadgaTq5mMfZkMoRe?=
 =?us-ascii?Q?NBlpZotf+OWnkoU5E5WPPifvjzf6BywxF6VMuS6CJx+9a3+64rVh6cMc/zYZ?=
 =?us-ascii?Q?qRAge9LIs4cpkvMZY71xclWAVwdFvOHOu5ttwloRkhm9ZBEpCeyT84To95ot?=
 =?us-ascii?Q?bY5WUssuC9EweahBVWDcMp23QEsb4nmu8+ZRSXZJPBaCMH8c3TPvwm6Np6bC?=
 =?us-ascii?Q?V3B5bLNITCaSrb34Ls/zrkHV0VsZD9MORzEvAef3B0sfwZJXjmHOMI48muoo?=
 =?us-ascii?Q?hzl6/7gUzKfOpjLQ9sX1ffCcD9QBBoSVHTvpi7Ob1AQwhx514lLDGyuKkiA6?=
 =?us-ascii?Q?iIMgYzIBGsbyWESfQyES6m9oH3/koenHtUVmrbhBm11aYG8IDZAhPS204XSO?=
 =?us-ascii?Q?dRvddtxSDeqdAxWZqwCKTZCy2xwF3uSKlZq9l9TH+7DPwYiqrwP8U2dO3osg?=
 =?us-ascii?Q?9O0BBZKVbFHuVYaXPTIu5h+7tcSjFwPURAtXwxnlEklQ0aUnPiW9kdSmqbMa?=
 =?us-ascii?Q?An/5IU/3UyzCV1aO2YCME7d0icI8tFtoRZjEmyx+MsryHtvl+Zd9F3Bwu9LK?=
 =?us-ascii?Q?vY6/S0xe1odzFQmzmz2oLMFOfdhW6dvC2eAZ7bGLPqcSlD2492obTsaAVLBX?=
 =?us-ascii?Q?BV8aTxLAggJ0ynppUihXSDvqKA0hnEnO7TXiwFrkLPk/EakTa84tHcU2PqyT?=
 =?us-ascii?Q?3nMmqWQZvY6QyWghWyLKbuovB3wgaa23vu1tkJznHM3Xa7vwdBOa7r112ocy?=
 =?us-ascii?Q?4h0IjB8Beps2BKfvXuKYR89TjajA+VwBflzqg8tM0mzv/hrCtLKHSkLMMZTb?=
 =?us-ascii?Q?dUNPln+Bh+Cdwz2dihopelFvxFjAGlsjpL5rD48Tcv7w9xDlB6p+MlacEBSD?=
 =?us-ascii?Q?EmXxdQfQaVnyqTOZqap0VsKFeDxj8GBQvt/WCKBrcF+xv7giW9m0lddHo4EO?=
 =?us-ascii?Q?x4WQrn0a+S7bbi3P27RS5f5GKYC5u3Fm+PjyFSmESVt9xAYOoGdjWBt/AN1c?=
 =?us-ascii?Q?6l4dCq6dC7YxymrvhipPXBi69qxCWG5iHw8q4EBE1hsBVrq2iN6RlCtslWF4?=
 =?us-ascii?Q?7V7qmXVqqPrFe9jiZRY0Fzv8cllA1yqresvgzv7cH12BOC0NihIvXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kjQ0jAa1N17hGx3co8suHdpMUSmLKPRlHmydSVA1JuuDyjnEkjq/yydny/X?=
 =?us-ascii?Q?fiXL3hQ+Tnl0KlyFpMhnf+e2+ikGOQe3NqMFGYR0zPsdS78wOnce5HBrm7dT?=
 =?us-ascii?Q?CPvoIzHckU7SWnjhXc0JmblErxnMf+jVrOnal01PC41SGn1PcII0MTRzpICg?=
 =?us-ascii?Q?hZEhtilmXmepzydjqHD5b6gUxR/iZjDkdVVpw1lOGTgTXoqEHQugPJ5NK522?=
 =?us-ascii?Q?oZtYu4aWEf7mp6aTh3p1os+yp19hC2N2hINpHVOwxmOysUWoLV+wodeWZNfJ?=
 =?us-ascii?Q?Ib8w/zJbEJFD0F/64XCgxwrKtvlZ8ueX4MbhU5/ylcwmtC9wu0I6t2YtH6zv?=
 =?us-ascii?Q?ttDPyZEU4sdPBltnPcSQnsVKuRFSnJ5x+7C4K/qHAeMjcfw4QvKy4UdKyXer?=
 =?us-ascii?Q?n/g3M5dK+6IPjm/rXQKpoB7Qg0fniu051BBXlR7Un6wpUfdILT0KatVwK54o?=
 =?us-ascii?Q?mWpXWqLGKDWdhmPVBQDHFxfyhqb6ljuQK7+Zn+YWnMNW/+gIGGfSu1fGx0up?=
 =?us-ascii?Q?Ejn+4kbxZGvFy0sCIje3k2YcSz+sKNH5CgRB7f/XCswcdoBM03vW+iYeSNqi?=
 =?us-ascii?Q?kgdKNLBNjqi16o8Lwrzjk5D9yRYdtFcd6BIgFqd4rIZ3z5Irp/NgSF6gjYOg?=
 =?us-ascii?Q?PUZwRyxC3M28HCePdzPIomJgR8R/W2QQ6BAdVYAVGd/bWXPCG5v0sGFC5S8v?=
 =?us-ascii?Q?ssOMgFnn9/sXnttk3FpoDWCekNLLG7WbPqfUE5RbCH4Box2fPsI0HYsimAY+?=
 =?us-ascii?Q?OOJpu2JsyadaZ4gn4NG6KgmuHdUaizdguagqC6JNm/dmm80at0OxYc9PILpa?=
 =?us-ascii?Q?aao99ede0DITX4ajqg5vy3kuevjyW+NqGV6qwfUXIq2lF9bZ8re7/fdKygSc?=
 =?us-ascii?Q?99/sywHBoR63IusXbvWkhx2z1N+OUguGnWQPMNpFkbAgHAbwiSB1QQehiBdM?=
 =?us-ascii?Q?AVnmov7bmSbFIpbJK1jChRz0+HxoahmR9grx1L1HdKVbE21DI/wrgynlYABJ?=
 =?us-ascii?Q?ugr+yjvJj4oCvZuM3haDMc8o73JqLdfBAamhRsSyF8VtcegulRjOw8gSfCGt?=
 =?us-ascii?Q?iKudUc/qXp0RPbDL2thKZoxFxrudgGP04MWRiRqStDXr/Vny6T+bg26r6At1?=
 =?us-ascii?Q?WyH2y69pKfniAgOxwBAUzsfwklghjWFIhCdqTjV7B2JSGcoVUNU2bEZ+0yPC?=
 =?us-ascii?Q?3qyG/ToEJXUssY6HlpRfaiAy/DULFCbj6kCdVQdWVvk1dIHUq6GwgDDQ/IQg?=
 =?us-ascii?Q?74JdVpLTgXC44PrGN6O6vLL77/SfLMz8lGOO3ZJ7pwZe6198aT5lv+R6Her+?=
 =?us-ascii?Q?e+K0ck7Zy19R6AbnZWSboafZ2zHVUKyl97Yen3EsV1iFIg65iXPh/Y8gJxFN?=
 =?us-ascii?Q?cNn3d7a/jh5MQ7B4CHyJj6jDAWWl2FuVm9hX93CYdsgAot/4bVAMlpdvDfrK?=
 =?us-ascii?Q?L2EgDztDjgPsXySEKNar46M/wfzRPBBivHueFxQvf5xGeRqXyIzv99j2DJd5?=
 =?us-ascii?Q?j6SfJohev4WFKVJkJZB3ojjV8ClaluN7FFwGB4YIw02+gDeDrRQOu/RpSYN2?=
 =?us-ascii?Q?xPucwOkzpglxx8UdPp7e+NOLRY/gjYWBYtH0NkUL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c12544-b46c-4c9f-b462-08dd9c248965
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:11:29.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kelnAVHHdpCV7xRcXVZQxj7ouI0On7p2dKaDrNvTYNOPaamHPmURmVH6zujkes/lZnGcugfETxB78jcoyDRe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
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

On Fri, May 23, 2025 at 10:20:07AM -0700, Tim Harvey wrote:
>Enable support for working with General Partition Tables via the 'gpt'
>command. Also enable support for generating random UUID's for GPT.
>
>See: doc/README.gpt for examples
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
