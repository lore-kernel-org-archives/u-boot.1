Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3224E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B085E803D2;
	Sat,  4 Jan 2025 04:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TTMEMHXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8855880462; Sat,  4 Jan 2025 04:19:53 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E8F804C8
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2EvQk0pHKw/8jbo+nIYY9PdSq9lg8ND3jQGw7fIp09La6hP6JDA1v4Qz4ExYXVdvIdNvHGTDmuefPOOAYLkPeIru5cDx+c2NLBC0p+h96pMneEchZq6czsG5ioaxNDwG7fBv9b3lv/wIxvXRkwYdde5PzY+67s0H+CjJ2imnTh29sewZgoUMW9IDhM1eqjqQ8C7HKmxn3jvyjIzM74svnJIgAaUlcp3pIv0mUL6D8ryr5d9nZQdDmKjWWzDgLqlHOIAudeW/WXawkCFZ4zkKM9X6pXk7DtumF/T5MkNtDh0BnniJz8sGrR3EsU2Zqo0PLzGkmYUm7LAmHuHx5DIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqsK1AfZMq+58pHg23Kearh5CjpP+5D+IVvLxUgaOFM=;
 b=eUInMBLnIFPlsu1sd2qqM8SkrkRfYh7sAIl8/YIBuN51LZPZLlXHTSDYH6Erv37Vz6xu0OnH2IlZUj90Rog7qsf04yt5iHCNTABoQCniCOkj4Mc8FQluqnijFlatx2f/my8tiz3migXMoJDcllGK8s8gnLuju+jm5oo0mT3PCVH/zatZweNRXatO1/R3rmVaLSBT13hNwPOpD0aYRmf4zkMky7ByuK/R65GfoN9yQ2Uk8BUUYyGG0+bE3sGTYYmuZSv3eOYAHNxFqZCK/uXYhUcG3z3MtasTkq8c3WWlgB7juilfGIkoZRQGS66X8MZc5Ykv7OHzato2e1zEFLM8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqsK1AfZMq+58pHg23Kearh5CjpP+5D+IVvLxUgaOFM=;
 b=TTMEMHXHwNgBPs/c7jrf7j7kmef2Y02dRdDNvzltC/vUxfuZXEfoM1cvDs3DGGSGDSLqYg3LlNsYQ3sub+HwZu9yrskTizfYrtbz58P8ckEZ0prCk7q6trhGxOy/j11ntGjczvWeNrPoh09zOR4zwrwQDdl0aH+gWDiIqFC07sq1v8VA9avMwk9mrTQ4++q2O13EWIbYHiaP+0g8nVmKO70lJqlOQA3ge31Dq3c7NR7a2+pLrTpVE8yULrbkInKKS5vo0/P84zC7TGn9rdxHfvTc06LwfaxLh6tC6IN7n01Zmqt1hTlSB0r1YYWmb/ZHocZKjCTphOI1gSO2U4XZcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:39 +0800
Subject: [PATCH 05/12] imx: imx8mp_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-5-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: c841af4c-c6ca-4acd-b086-08dd2c6ea38a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0xJeElqeUdMdWt6UTF5THhmVDNsdVR5RDZZajhBUlVSY3EyVHVBYjdUNWJX?=
 =?utf-8?B?VTdtWnBNQmhjZ0hjbzFmblNldGxLRkxvcjV2MGFLbzZrS0F1OXlMNEE5OGV3?=
 =?utf-8?B?VnNmcmNoU3MzWlYrbUtraUlGcW9EWURvWWEydzBnd1pkYm95VWxtWjlkY2gr?=
 =?utf-8?B?MkRXWG0rU1dUQVlSOXQ4ZXZYdTc5enlBRGw0TEs5UVBsak1ocTNWZElEYjRY?=
 =?utf-8?B?TEp5bjRNcTFobWx3MG8rZnJZZFdUbXBWSEJvNWNyUmR5enNnRHpQNzl3VWtI?=
 =?utf-8?B?UHZoUFIydGJqOXUvd1IvMG1qQjIwc1dCWk5tK1RoRWNmSFlyNmo1b014Y0pV?=
 =?utf-8?B?azhMdWp0bWQ0TlIyRGdYSWJqbkZPQWdQd2U2N2lLdHZpTjlMMG84Q3g3MDls?=
 =?utf-8?B?TVloWnRFWjg2TWZ4UXFmdHZFQnBVYkVNcEdPdXB5Z3ExeGV5ZTY1ZWN4b2h2?=
 =?utf-8?B?eW5abFI2NHFaOURrRG9OLzcySk1rZGFMY2lpcGlKd09tdUhWaWhJeEllc3ZV?=
 =?utf-8?B?WFIyZUVVT05CZ3QzWDB3U1g0TGhzTjVaZnQrMEMyWUxBZ0xGd21Jc2RibFl2?=
 =?utf-8?B?Tkpaci9nY1FCbDgxOXhoVU1qMXNMcms0cEdKd3lZNUEyQk90L2grKzIwRjJ6?=
 =?utf-8?B?dkpPZnRrSnNoS1FXKysyWncxSGRiajZiNkJHRzFwTGNXRVMzMnppMVhvR3ZV?=
 =?utf-8?B?dTRNcDhBWURONHFmajF1R1RrRVVEdGlMUC9yQ2RjUHI2bkkzSUN0N2NJMmpS?=
 =?utf-8?B?OUJKWW43ZElwQ29ZbkVNZVgySlNDWUg2U2R0c0doTFV0b08reEQ5dVp2KzBo?=
 =?utf-8?B?S2p0UVBHRDZpTUtWY0xyaHZRYkcxaFVnL2NWN3lKZUVreU1aOXZ3M29ma2J3?=
 =?utf-8?B?Q0llRWh5QjJKWUJtbVFoWmZPQ3QwSis5WWYrV2d1K1dKN282WFBoWG9ZcDhz?=
 =?utf-8?B?Q2pmNkppM09UOTZ2aERPWXFhQkh4a2Y5NGxkZ2QvNDNBTHE3QVZWTmpvczVB?=
 =?utf-8?B?bll1aEFFMEpsK25KUll1SG1qOUtHVHRpbnQ1enM3aDlrRGNsRVo3dUNWZWVW?=
 =?utf-8?B?MDhFaU1sRTJXYkp6bDVqMW1HWEdyMXFTK1BwczJuR3FYdk44ZS9GcmUySDVJ?=
 =?utf-8?B?ajhKYXh5Rk1NVFBSUUFtZHdVdmR0cVM0eU5zRUplOU1BZFZ4MW9hNkdkOWRt?=
 =?utf-8?B?MHQ5YkZicDlwWjFyUEZQV2lXK3ZrSFBaRmtndmdFbTEwZzlFYWk2Z1dFVnph?=
 =?utf-8?B?aWY4Y3puT05vVTJmMGNzL25kbVo0YVZzMjRRZVV5a1ZRWlFVN24wa3M5ckNy?=
 =?utf-8?B?cGhNcWcvSWhOeXRkajh1ZnNuVkUvUHRJZGtLV3FaUVBVeTI3WTI4dTJUU1RC?=
 =?utf-8?B?cFdXdERJY3BaSUsxYjVZdXppd1poS0xYQkgwdTNPVkZYZE1vWU9hU1JkTXFN?=
 =?utf-8?B?VGhVRXlNZkxOd2VEdTBXd2RDakFMakdpZEZVS2hyVko4MW9keHlIbGpwUklR?=
 =?utf-8?B?Y0F2TS9pQVl2SSsrbzJCTWxvU1ZQN09wMWNLbUxJN3dxSDBqZjI5ZXRhZ3Q0?=
 =?utf-8?B?QnlkNVlaaUJMNzdTbXVvMEZXZ2tZTnl2alJGYjZ1dXhTcTNodTJaVXN4Rkty?=
 =?utf-8?B?RlRhZGdKeGRINVd4QXhPdnFHaEFlcDI0VmJWeWh5SXRGdGVoOFRWcVYwTTZI?=
 =?utf-8?B?TkpBQU9Kbno3SFY4ZHdXY1hzbG9pTGFndXhBaWxud0VROHFPRmtJdHE0TDlK?=
 =?utf-8?B?Wm5MaFcxR3ZYcW54SllrUUdhUW1kcldnM3ZDaWIvcmN0WVo1Vk1OWGkrRU1s?=
 =?utf-8?B?Tks2dG9UeVEybkNXUG1tU3pDUmVEdTh0Q2VPTUtldUwxVU9COGdNQUxBN29C?=
 =?utf-8?B?bUU3WWh3TzVmeHRoSUxyK0h1SEh5bit5RkFvTHpGbzN5VHE4cCtmWUNhbmJB?=
 =?utf-8?Q?pCWBVdARBlO+WRJ/pSNQQJsoSKP5wTgB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNzTStvN3dUU0RzTlNPRzI2V1BzekFuWkthTUhjSjBSSzNsMVRwS2lLdXQ1?=
 =?utf-8?B?YmRoeU1rT0ZydVFHZjVjYU5CV1VRa0xIdDE4Y0FYUFh2WUNjMDI5ZkFPQmtq?=
 =?utf-8?B?QU1EbVg1TXlaVkVVOXc5bDFGa1VpR0xOUDc2QmU1N2ZZd3hwZXdIK2pFenNY?=
 =?utf-8?B?M1BNUm1heXQyMTU3eWdWbklOaVVneHcxZ2lZWFFXbEttcEtUbHA1bHdqaXM3?=
 =?utf-8?B?WDBWeEFXZHJBQ2lMdWxaMzBma08rOG1nOXc4bXZUM0c0UHlIdFZFS0sxeXlw?=
 =?utf-8?B?NStOd3F0WmxPMGp4VkVnOXJlMUFrNGpjRy9VYWdFb2VIMEg5ZUs5U2tIZGlp?=
 =?utf-8?B?OHJXQWFJZ1Bla1Z6QVg2NzNvcWZBYmUveTZudStTckMxdHBwVWtTdkNwNWpH?=
 =?utf-8?B?aDV4NmtkdFI3SUM0VkRJR0pabUNXMzhFMlZPZTJTY2tsTkQ0dDdVSWlBcGJz?=
 =?utf-8?B?WUVoMjgxZ2hqVzhtMVFub1FrNmdZUkFwRHlhSHZWQzBWbEd4eTVCV2JUV2Ni?=
 =?utf-8?B?dDVHdkVRMVQ2RHhRRU1iLzBIU2dxaVN1N2t6Vjc3UVhNL3pjV3BlYUdVbjhz?=
 =?utf-8?B?M3NKdXMvNFh1MElKdFRMUURQelpnQ0xnTzB5QWpBYXNuTlYyYzFsTUJGRWEr?=
 =?utf-8?B?d0U0NDE3OEg5Z244b25DOFc5MXZia0F2K0h3aUdOUWZtblRnRWhxc2lhTHV2?=
 =?utf-8?B?OXRsbDlDbXVoR0V2a0hUYXJBaUdWd2RVS0s0TzJzdW9BenRzenlaN0NJQmwy?=
 =?utf-8?B?ZXNWeW9MeWE4bFpHR09kZjhidmZMdjhMV3ltTXk5ekErS1V2NUJWenF2blF1?=
 =?utf-8?B?bCtodDNPWkJKTSs5QUJqYThpR3NxeGNmNzlLTFQwTjFrWSt4Q0Y5U1AxNEJQ?=
 =?utf-8?B?MWgreHlOcWh5YXJUdzVUYVYrdStPZ0ZwRzJ1ZkljNFMrYzh6dkRETW9RR0Zq?=
 =?utf-8?B?azVmc3daeUo5SjNZRUxuRVVJMVIyMjZseTdYTVE3b1l2Q1l0MTB2UjFqWktF?=
 =?utf-8?B?bzFDVXhWZXU1NGRwY2RTVngwUzZxVFhSeTUrTE5DZGdNZU1tNFZQUTVhUm14?=
 =?utf-8?B?U25oZEVmd2FYUWc4cXpxcGtab2t1amI2OXVNQVpBd2pxYXBLQS9zMWpkNWJK?=
 =?utf-8?B?T2p5T2w2UzFDS3cyUWRHWE5YSHJhVXNqUmREbWd4dEJHZXFXV0puZWQ3eEp5?=
 =?utf-8?B?b1owWHliZkw5MVhDTTU1WXhMZzYrcmZqYTc3UG00b1BuZDUzTVZKQnQwV1VZ?=
 =?utf-8?B?OEZ1eE9lNEQzQ3VuTjhHK3BSR0JQZ3lpRDg0SHJNRkd1ZndUUGtaUkV1eUVF?=
 =?utf-8?B?L21TcEdzWlRVVUtjYTRXd3lPbEJ2RmZVeUcwVTgwUXNCSUIrNTdtYXBQRDRq?=
 =?utf-8?B?cDk2Mnc1c2ZJOHlobE0rRmlpeGg4amZwQ1ZsdTM1Y0dwVThjb3FiaitBMXRa?=
 =?utf-8?B?TEdRZEJzdWY3VFVzQ2hXNDdteEtvZHNKMVE0Y1FaNXA4MzFTYjE3ekQ5Mkl5?=
 =?utf-8?B?T2xCUWIzTmwzU2tiSEwvaEdocEZwa05RNWtwb01YUzNTVk8vM3U2TyttZ2Vl?=
 =?utf-8?B?NUlSUlhBclJiWWVEK2FkRW1uRS8xRHMycEs1NVM0Q3hLdlJwUnhHQlgzMGtM?=
 =?utf-8?B?aVZrcFcrcW5sUjlUS0g4NUs2ZHRlVEEvWExqc250MGFRNmJvRlZpeDFMaUZG?=
 =?utf-8?B?c1pscFhxdjRKNWQvZWYrMHo0d21TVCt0V3hDK0F4alpJdXN6YTdEM2VZekVS?=
 =?utf-8?B?eG42Tm1WY2dWNUl1dWlXNVlFMTFmclJWWDJWYUgvNUJSb2IzWkt4NGZzd20y?=
 =?utf-8?B?Nmo5R0I2R1JYTitpa1RaSXFMdmpyUDRFRXF0Z0MxWlVaZG51UlJkYmFJUTZq?=
 =?utf-8?B?Q2ZlZVpzMlVPa1IwaVAzTk93clA0Qk5iRTRXTi8vZnBRL3VTVzduVWJaQTBU?=
 =?utf-8?B?S2tXNnBIRUVnclk3dlF4NEZCcVlQa2ZudE01azhyQVdEYmlBRVNaZkJ5OS83?=
 =?utf-8?B?SFRTNjQ0R25YSG5UNnkrZEdTSGhrdDNOVmh4cnhjMXpMMUdrT3ZmeHR2OEZm?=
 =?utf-8?B?SXNiVkZBRWpsNnMxaHY1Yk5TdEJaYjRtNytuck1wdU1IUFB6WmxoWWU5OUxQ?=
 =?utf-8?Q?fCl4TQKzH6A3rd5YYVMi8u3RU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c841af4c-c6ca-4acd-b086-08dd2c6ea38a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:45.9111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uSzOJe5Z4aJ3/WbSW9bNwWSqjPvA3M2mFppnvpGBCo2nmtLUl3zEuQWj02E0xTFVyccjSYsUpvcYIVgq2arTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Move env to imx8mp_evk.env.
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env | 57 +++++++++++++++++++++++++++++++
 configs/imx8mp_evk_defconfig              |  3 +-
 include/configs/imx8mp_evk.h              | 21 ------------
 4 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index b254a50b091a05393d99db6000dcfcb4427dfa5f..0cf3c1baffeecc5d7475e6f7b8d77539aa9646a2 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -227,6 +227,8 @@ config TARGET_IMX8MP_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MP_NAVQP
 	bool "Emcraft Systems i.MX8M Plus NavQ+ board"
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/freescale/imx8mp_evk/imx8mp_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..18f6c6e200ede28201c95eb34c23a596e6771fb3
--- /dev/null
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.env
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2
+bootm_size=0x10000000
+console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
+fdt_addr_r=0x43000000
+fdt_addr=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+ip_dyn=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if run loadimage; then
+		run mmcboot;
+	else
+		run netboot;
+	fi;
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5369f8b84a4172434dcef142c854d06e3437caf1..6a8f9c64d9bf93e77a83dd5780f7295b3893703c 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mp_evk"
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
@@ -26,8 +27,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 741ee39db1a340136b57d9411d96bca995e0ebd2..dfb5cd22528ec4febee8a2fe069c17cfdd77decc 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -17,27 +17,6 @@
 
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 1) \
-       func(MMC, mmc, 2)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000

-- 
2.35.3

