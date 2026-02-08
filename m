Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5F7EF06E2
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 13:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27B583C6C;
	Sun,  8 Feb 2026 14:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="auIDquSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E958183C54; Sun,  8 Feb 2026 14:20:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFCE83C30
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 14:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGRyqY3DuNUw+JrI7SyQWRRTA1UeLXGJ+ydnJWpD+o2KVjmOcoPBdbAaYbQLwJDulh5OWatwr5boM5jE70dLS8lBkJh/TNZrL7+8iPKAyhaR1QZAzsICLEy7HxJKs3yHQcMBF8bwARGleMZiUKz87yVp/QpOZL75PPOT+R5SNe/uGL8ttPQVp4xDXcSA8TdKEutxlQDyd9eygQrZb/rAaXiB6GmcBVCkZx7jMUvK3812l5XjnY49/SUElm0QLf43+sDkFZ26745g8l1/lg3rQ/9/oJ65ZZvgrEcrQbBHViruUxrxe20e5b8v7d+ar44zL05aL5e1C25Se9FXp/FYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Slx749yX/9jhAT+FW9BzQZrpy482UZGUpebZh+D7Jts=;
 b=xotI5bOlf+ldx7u/I39hG1ZeU8GFVSujKUXQAYWSi0Nl2TSqq8okxhMVAZNJYpqbfburfBUAjbN8Q+s08388kDQUBceoQLkXwA6/dafO9RkXJVxfhIC5dDQu/YGqiSG2HaSDCvLyCxEn6/psvX1s961FCBbQTiICpwC9xF9V9uFg/gl4GN4OyFWz1i6jaE1KhAhNi7ONiwp3i7BHLYeeLjP3QEmirzlPIGwmcvq4tHYmOJ3XRZYprCq8eyxSGyDhaWT/ZpDsWswhfwV1IUrzqmlZ5zRG0sm/uvIRxWF+gi2rAoF0o4Kaq0r+E3DrEnPhEQ8iIbtpQJdqWL8eQg8bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Slx749yX/9jhAT+FW9BzQZrpy482UZGUpebZh+D7Jts=;
 b=auIDquStenZd4bLnbVN4zs6+ugtNHgALR1p404KWdf3+F7ZId9dn1kWZNcsOKMvjMSoEqSrfmMmN4N+RbDwYBmQmq46pHMTTVofz5JcnGJQ8EVWf9HGdXIJ4a7Hu9FAXuYr9vabhx4tVZif4c7unypHIudhqFqwRt1E+oy8wgxawFT3nQ/UCdU4lsZeKcfL4dPNOSIdJwpCdQNb3Z3/a2ozqDncchXoduzyE0+GA7yT77ULh4jSLSo8JmkuL3TQDlJWCtR2LQYIt+DU0THpKZPukTrFVBYKovVhOMOroT8x25WJZ9lf+NaYONb1P5VAfllWkYXm42zwZeP7FqHXLlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:20:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:20:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 08 Feb 2026 22:34:42 +0800
Subject: [PATCH 3/3] nxp: imx8mp_evk: Add board_mmc_get_env_dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-imx8m-uart-spl-v1-3-c3e81cadd160@nxp.com>
References: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
In-Reply-To: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: 30db6588-edff-4de3-3010-08de6714c429
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXBTak5Hajd3K2NLYzZwdmovQURLajE4N2F5MllXVlFUTEdIb2lCL2Z4bklQ?=
 =?utf-8?B?V0Nib0ZjOXNiMlgreWdicEFuNnB1Nm1CY29BNmxLQlhWbWJRWEpiTTF6am9v?=
 =?utf-8?B?ZkFnUWo4ZSswNjZGVTBNc1FDSCtGL1JLeEFTaS9MRWlJRk9ia2tZMUdTYW43?=
 =?utf-8?B?V01jbEp0eExObCtuNmlTOU9uWUpqY0NCR2h4UlNrNmpoSzNrQ1g0NGthdFg0?=
 =?utf-8?B?UFd4V3VkT1Q0U21GQTE2dklaZEJyUDNYLzBVSnZhamVBYkRFYzl1MFBvZUVO?=
 =?utf-8?B?Q21PNy9DQ3JnMDgxUjJiNkZ4UTZRZGdiWGFiKzYwUFRDOXB4cWVOUytTV2dM?=
 =?utf-8?B?R2RjSHNNVlI2bDh4ejFyMFVsdFozS0M5Y1BrcDZpY3oydkFkTnd5bkVjejY3?=
 =?utf-8?B?YmJJOTB6NGlOTVBlSWtOaEZpdTFwWEliZmlac3ZDSm5ZVWI1MmduVkphMzBD?=
 =?utf-8?B?bXJJQU04bDVMS2x3Z3dPeVhRZXJnU0JJL2tkT0FldjhHenZRUUVDRWVLeXl2?=
 =?utf-8?B?eE94VzVjN3paenI2QjRDcVg1d1psRjJ1R3VPNHMrQlRBUG8xb09yVFR3c3Zx?=
 =?utf-8?B?TThXekpBWlNSRWt5QkIybUY4MWpZbkhWQkFXeldxZ05haXNXanpjYzVIdUlq?=
 =?utf-8?B?d3lnWW04ZlZvWGVocWxscEZEZ05KUG44RnVCejF4MGVKZGk5aXpObXNsdDZt?=
 =?utf-8?B?T3l2V0w3emErMzNNWVFaSk1HM0hESjZtazkyZG5UaExwVElGbGRSSWw5ZFBw?=
 =?utf-8?B?RzAvNmh6Q0I2YzJMZkhjaXo4bmxLN01OZlU2MThLWndxMUh6eW1zSTA0OEZZ?=
 =?utf-8?B?TDRrdmlTa2FRb3czb3lRYWcwZ3ArOUdxMkxBT0hhK1RZKzUvcUVwL29RcG5L?=
 =?utf-8?B?TDJZajRqemRBRmgwOWx1enBuZ1VzMGVLa1dHbnlvd096eER5eDM1ai9LSitL?=
 =?utf-8?B?VEptOFJlV3A4K2MreWljbHJtZ0txemgyQjVlcTQrQlBhQ3ptMk5oNW9FVHMv?=
 =?utf-8?B?V0pXOTdkSDcva0FRNGNHaTBMcVFMSE9raU5BczZzTEtNNHRUcmZMT3hnZWlC?=
 =?utf-8?B?TWtjRm1STDVqb1dKaXpvT1lZM0FmYnV0a1NFSXN6dUpIZjNvamVVNXRtakRR?=
 =?utf-8?B?Y2YzU0tjL043Z0F2dFh0V1JWa2VOeW1sTFp4MjZJWUlaN2VyeWxPUkVPWlBM?=
 =?utf-8?B?cGY5NE9oNEVVUkRhKytDUklob3ZIYkNtb0Vvajd5YVY1dFV6cWEva2xnNW1O?=
 =?utf-8?B?a1V6TlAvblB3UkU2WHU3OUhOSENDM3U3d1hKMDlZVVc3d2xZVGJ4b0FQMmR6?=
 =?utf-8?B?d2lVdDg3OE54NTNTdFhtc0tLV3YyKzhQb29QZXdsM3FTczVjK2hXbS9GeXhw?=
 =?utf-8?B?dkNmdVQzUmMxd1NNVUJpWE5ZSU1RK2w4L3dPcTJqMWVPYUducGZWb0IyOUV6?=
 =?utf-8?B?UEdnc2ZQZmFXWWhydnFvSTQyVHJqVEhyWGZKeXV4OURHck1QV3lySy85OFlF?=
 =?utf-8?B?OHdtdTNsUEp5R1R5c0lrNk81WE5udmVuSzdFbStaMlNxN25lTWNsUHZjaSta?=
 =?utf-8?B?aUowMVU1aGRZaXJoek82T2dNRjNVMEI2ZkZLelk1c3RBY0dOTlFUNEcxY3Vx?=
 =?utf-8?B?czB0dnZES1MxL3JraS9OUEJ0WHRBeUJFbWxRTzNrbTJmK1BzOURzVk1IVklM?=
 =?utf-8?B?VEFmbWloQm1Ga2cxR3dFVVhpUDhuSWx4WVFPL2l4ZTgrL3VhblhXdEdla3Nh?=
 =?utf-8?B?VVdLMmNpUkh4QjBLdnR5S1Z6L1dzMmNzWVFrd1AydkZiclpRTFFQNFhWbkYv?=
 =?utf-8?B?S3J6OEl5TG00ekpIQ0hnQy82TU4ySEcvaERvbWFQcVZQK1pzNHJMSHBUckZh?=
 =?utf-8?B?eVNWd3BCYlR3OGNRSmhHcTlqN2lCSGdwWVpQV2pEL2tSVGdSU2Q4NDJNKzA5?=
 =?utf-8?B?amgyTjBiTFY3WHUwL0liZFJRTkQrY2tvem9STVEvekZ4NThSazJVMU9DT3g5?=
 =?utf-8?B?ckZGWWpqVXUwYUZpVWloZU1YOVZuNmpVNWhJYUZxbSs4THBmTFFqYkNJRkxS?=
 =?utf-8?B?Q3I3VVdVdnZwTk1kTUtHT3hsTytUeVl0NnZQcHB2R0RmbGpPVFBqODVJR3pU?=
 =?utf-8?B?Tzh2TVlDWTJIcExkTmNucGIybmdTa3dQQjh6Y3NNQ3VxaDJvRW5aazRBS0RC?=
 =?utf-8?Q?7SrWnUxO/OUrYX/RnOTEYr4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJxUk42Qms1Tkk2NHZDeEpzV041NEFtMXl3cVhRRmJzMDFML2JMck9nK0FC?=
 =?utf-8?B?OGh5aFI2QW4wT3J1Rk5VR1ZSbk9Ua29WY09XbjJteVBvS2Qwd1FHbTdvSi90?=
 =?utf-8?B?TEx3aDdpbE5ndkNIZXlVRGw0TzR3a2ZPTGgzcWJxWFVjRnl5ckF6YXl0Y3Uw?=
 =?utf-8?B?TUliVUZBNEo2bHRCditnQkplRForUjJOM0oyaUFPNlkxS0tpRWpyaFFyS3Yx?=
 =?utf-8?B?Vmc5a3RhTlR4aW5ISUxmdkRidVlQakp2ZmliV0Zyb0lYM25QYWFQaisxUGVa?=
 =?utf-8?B?SlIrU2ZCbmhmUStqWE0zLzRFZVgzRlhRVlJMZnZvQ2k0V3BkUVpMNExOL203?=
 =?utf-8?B?eThRRFBSKzhub3Zva2JEOGxzRUNUTmJ5clVka3Y3L2JMeC9mM1kyTGNhanlP?=
 =?utf-8?B?RG10WEpQOVB4K1d6RDR2bEw5Ky9rTDR6SW82WUJWNy95Z1U3UmJsWml5eXZM?=
 =?utf-8?B?czljYVo5dXFHT0ZKRTYvdG1QTEM0THBab2RQcUl6dXZXQ0ZkR3RvL0xyeHhQ?=
 =?utf-8?B?TWhqbjhhNnhmQmRTeXZtUC9INWhiUEhLYlRTVWwxV3Q3dHBBUkF6U3o5T0dL?=
 =?utf-8?B?ZWplSUwyUUUvVmMrSVlqMmlHT0NiUFRUY2VPZmVJM21ZV1F0c1FyTi8zVExj?=
 =?utf-8?B?WVBBMjh5eGVmU1hoazRYY0FGV3VMVFhBS1hpU3owUW52UktkTmtQenhBMkU2?=
 =?utf-8?B?ZnRONjVOTTV0SkhIVzhpUnJicHdJSHZOQUZnVHFzemJXMnE5eE9yMXF6a3Mz?=
 =?utf-8?B?eE94RHZBS3dndVRnWUI4bUNrR0lkOFdJZ3pRb1hyRnBJM1B1UU1OT2RkeGVk?=
 =?utf-8?B?bVV5SzFSTUxWRFhQWm1ESzZKRzFmSGRzc21SRTJuUzBGUzdnZjRBNkwxREt6?=
 =?utf-8?B?OTNXTnl5MEYzVlV6ZTBldGxEbFdEVGNQRWQxTTdKRlRnczl6TFEzL3J1cHor?=
 =?utf-8?B?clBqa3diSFNYeEpKQXdjak5HT0ZYemY5N2pZRkdJZDBtYUgxN1puemNqN1U1?=
 =?utf-8?B?amdUaVVIZitBb1JqRWViSEcwSzhvR1F1SGRnOCs4VXFmeWg5NEZmVExmTkhU?=
 =?utf-8?B?elJETCtNMVluWjRBSXd6TG0zUU5VSVp0Vmx3VTh2VjdNSjd2Ry9Rbk5DYmVP?=
 =?utf-8?B?QmNhOWZVT2JjZktzeTBqOENRVjZaeFlMU3ZSUGlKUXVUbFd2cHd0c0o1enhm?=
 =?utf-8?B?QmtiMTVWZG5hZHZmWFpXNWZoZVdMaHVIQzJld1E1VWNLR3VHYk5LUGpFRlpk?=
 =?utf-8?B?R2RIcEZJaTNZdHJ5ZTgwR2hNSVV5T1Jjd21CZ1JsWURPcmNKdmwxb3c1M2w0?=
 =?utf-8?B?UjNmNUlMUzNDenZPMzk4VEM1emNvQjkwMDBjS3NYeHpabkR1REFSUHE3U1Nm?=
 =?utf-8?B?K0twQ05mUWZ6MWsrZ3ZxUU5FMHhscXFSTlJONWMzaUhzTGhESncxdzE4REpF?=
 =?utf-8?B?MzNSaTBmMXViczRLaVhnODRzek0wSkNwRndyaHM3U2g2L3g2MUJCYnIzRGhy?=
 =?utf-8?B?QUc5WGZhOTNsS01kRVgzTk9USUEwRzJub0Q0RG9CZldjV2hyNU9HMUtTaGZn?=
 =?utf-8?B?YTdWV0xqK2NHa3piM3MxaDNNOGt0YmhTR1pHeFE1WHc3UEdaNWQraVoyRU9L?=
 =?utf-8?B?R3hGR1VuRXNlVVI0VW5TZUw4VHdjYzk0S1JiR1p1V05xS2UvYjgrZ1FHa2ZQ?=
 =?utf-8?B?b3pGUEFjSjIrd3RpUk9VdTBFdFFBN3V4TjdJSlVYM2J1VnovaHNWWnFZaHdI?=
 =?utf-8?B?eVhFOTFML1pHUm4zNXhyK1pEeUZRdlVtSHI1bUdRYlZzZ3BpQjBhaHJlNCtn?=
 =?utf-8?B?RUZIM1cweEtBTnprcXBRZlZQV1ppQ2VuRHBQajRFOEl5Y1hSNHVzVkZxcEtn?=
 =?utf-8?B?R2RGVTBFb2pDbVpnY0JPb2ppb1EwcnZCbmRvVkZ4WXd4aFFtRWlTODRhUytI?=
 =?utf-8?B?QTBvNEZTd25IMXE3WVV3dHZoaTd0WjdyYy8xS3BoR0dPbnFOQzUwd1pYZTBy?=
 =?utf-8?B?KzAzZFNObCtIYjN2UUVRc1FVS3B6YU9BLzlnRk16SnRZMkdpMXIzeDVwa2Fa?=
 =?utf-8?B?d0FYaVczM2xXQVhvQUVwN1lqREE1SkROOE5BTldrNlE0eVZ4b0crQ2h5Zzll?=
 =?utf-8?B?T2xDQ3QwandLVFBILzVwSU9iR3hQQlFQVWRXZFNUVzBJUGF1c1IrTHZqQUFx?=
 =?utf-8?B?QktzaWt4Z3Z0T3lobXZhNGFGdlI1QVRwSyt3NE93MktYdTMvN2VHYktHbnZW?=
 =?utf-8?B?OXFQVWJFblA1ei92SkpUNXQySkw3Nk1YU1htUENpbkdFa3VSeDFENzNJWS9D?=
 =?utf-8?B?YmxlRlVHZktkNEh3SXVFSGh6bGVkZ3JiTGtxbkF5RjlzK1BEZ3oyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db6588-edff-4de3-3010-08de6714c429
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:20:02.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOqgK8a0XxvG37U81Y6psi2HHqrdUxV6nLR7NmT68OtIKuE+IYiAtFbFjp/T034YBDrRfGDwsozOw7Cwjzs5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813
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

From: Peng Fan <peng.fan@nxp.com>

When booting from eMMC, there is error log:
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... MMC: no card present

Add board_mmc_get_env_dev() to get the correct device number.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mp_evk/imx8mp_evk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/nxp/imx8mp_evk/imx8mp_evk.c b/board/nxp/imx8mp_evk/imx8mp_evk.c
index 489e5ad4d43..e17100e51ec 100644
--- a/board/nxp/imx8mp_evk/imx8mp_evk.c
+++ b/board/nxp/imx8mp_evk/imx8mp_evk.c
@@ -28,6 +28,13 @@ struct efi_capsule_update_info update_info = {
 };
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+#endif
+
 int board_late_init(void)
 {
 #if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)

-- 
2.51.0

