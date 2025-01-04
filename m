Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA98E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604D0804CE;
	Sat,  4 Jan 2025 04:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vYiZVU2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4418F804C8; Sat,  4 Jan 2025 04:19:51 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31BE98042F
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKSQmiv0hyHEMgt5PnjyxTiBGGFyE7JgUovITTAMfOQgqtpD9M1dyusGsz0LSmQClus3AzJYF6AoFfhA/Fp1GDTUuMV9dEb5T+BgGxisr0NTN6NQ6EUUNEkDXYQBOBax8lIpH85J27Cgd3SIvQhRIYsAEY4oS8EZMUn5QGN1nFgghU3L3YYYR44MpTejfQlp+d0laXWoNu+w9C40HtTc/MoZ9t/WHFGk2aJJn4EZ5s4RCpOAOEOW3HvVZkRkWM5R2mFWiEtSTR8PvDZ/2oSRfQra1zoEmbLm6kA1UAO/yyujYQlBHJWazMnCWv+TvOnwhTUqe2SHGR2+E3f4QPVKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=WgW/Jq8o7/bSZsWxBgf4Vf3Lru+SlMpLo+rs/4wllfsDQxSPN2N9EXi4gwAPikZV5pfzSN//GrT8i2NG2mvvqyopfpET/2JLYosNfEkLKYFuIkneKIz17BKq4VV5ENO+POG8APZuL0NDO459S5NduBBGEqQ6PnK+nF/0r1AkiAPF2RM0eLne1Yk8CdF+WlCLWARTlbYJCpBU9VlKsR3GJFhWG7gqTD54xl2IvkvzDAsAhRlaZK+UkWd5x9AdHKIseI4o2br6PiZPSvBW1QSWUBmTNZnJptPIQ3stJyJWvQhFMv99ZTdgohdAbqEWEQDTDntwm96RhSt9YDck1Irf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=vYiZVU2zVLr+QDQfE2lYBiQDJoUnoR+GUhgSqo6BWwk9TK5JIcP/OQ4w4WqXqjw/DQTv5yTYYceVf2Whc1ayOPsPmF9wZdaYNQdJvBMltF5jQcUYs7fwhRtPcWLCElM3SPhvx/RkK84ws75j1GknOuITUYRTC4jh0RWWwRNvXp4py5pmVXWll55kwp8Wg5MJExP+wF3KkScVW4H22K16+7UMsfjoFUoSrh9f+Zb+rgHSOk0S7AujrY61o90p1T5a2QYDWqe8bor/QS/63ptsiwLQo3lsxngIW9GZGQ/d8VZcI3hKV0+ceP7ca7WsSVX4QH6xNi6x4QpD1QVyRvCBcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:38 +0800
Subject: [PATCH 04/12] imx: imx8mp_evk: Enable dynamic settings to mmcdev
 and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-4-e09618cc1d65@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5d33087-29f4-457d-cc69-08dd2c6ea25b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnlMaktQK0U3emtTc0pvaHI1NWFVL3lheHBVczNLSTBrRmNwTktuMlpldHBK?=
 =?utf-8?B?TmExNjJWbXFlNWJVczl5KzBxVmNuM0VQWHMxaFdRNEt6RzdDeWllbUVOZUN0?=
 =?utf-8?B?QW5uYm1heEN6TTdOaHdPNUE4QVpOYzNyaE9SdGtyOFluRmJpS09pMEtYMzMv?=
 =?utf-8?B?aHpXeDRBcUIvUmlwUnZGNVZFd3RHQzIrQUcwU2JFa0JwUEthV0krb2xKR3Yr?=
 =?utf-8?B?bkVRQTgvT3VkM3V4czZWS3dLSXpKR2dtV0dxUG1ZUUNEa2QzWkxOQ2VDL3ZB?=
 =?utf-8?B?aFZINGZDM0hxYm9PWEtGOXd5cGJpbVVTV1BzS25LY24rcGErdE56VE9BQVMx?=
 =?utf-8?B?ekp2c1ZKOWtlRWFWbXJ3emlwaW5oYmljYjBvVGRjZHFBK291M25VUnJZQlgx?=
 =?utf-8?B?ZUNJQlJhTUEvZ3J0WXJVZ1QxYSt5OGRSK0gzVVYvRHlIYndKUktCTzhtQTdP?=
 =?utf-8?B?YnhSYU1oTDduNXdHLzF1ekNXZlNFR3ZJVEZzZDJ5TnFYRFRUYTkrNGVyQlUw?=
 =?utf-8?B?RDgyeGh1RURtMWlJZm15ZGh3QmtqejcrSkdsNnJRbEt1M1RnTGUxSm9CU28y?=
 =?utf-8?B?Zk1RVllnZzF5SW1adldmK1NSWUhTNkFxd2x2TjVETzUydlV3SVNGK0JidGpC?=
 =?utf-8?B?NGZQeWlDTm5HakJ1Z3dMUHhZVGFuQldIODlaY2hPMkRzTzVoWkpxLzFUV2lX?=
 =?utf-8?B?ZllyMXkybmZKYWdabVNSYlN1VVBNeDlSWTdnWG91eUFrVnhXbUJSY3NaOVVF?=
 =?utf-8?B?V0k1VG1zK0U1M3BrQnovaFpiSVNzcWpIZmgzMWgwNWxwNEp4UUhRNEZJdjJp?=
 =?utf-8?B?QVRZamJrQjFRR1hVYVJpQ3dQVnpqZHlla05RQWdjRUVFN2F2dmlhWEc2cEs3?=
 =?utf-8?B?cGVlWnB4b09SeUZWNWl1di90Y1lwbEFpMllmWllwQVhnR2JidTFpWklXRnZM?=
 =?utf-8?B?WWFVY3RGaFJFYk9OcTArTDdrMHpGbDhadDdCMzNCWmNnTC9zWE9Wa09zWUdB?=
 =?utf-8?B?a2MrQ2VuRUhoTEphdXVLSW43aFVQUTkrRmp5YnB2TFVDRENydHo2M2JjSVNr?=
 =?utf-8?B?eGo2ZzNXUUxRdkNwSzQwemcyQ2Uvd3g3MUpQdWZuNEh3cTllTGxTamw0NFpY?=
 =?utf-8?B?azJvYkVlUzVpeHVhcld6WktjUENHU2ZCK3lGdGsrTDRub3U2Wmh0V1NQUzFK?=
 =?utf-8?B?OEZFRys2OXFBbWtnT2dVQ2U1enpsbExkRkdtQ0QzWk13d3ZGUUFwOXlPNEVJ?=
 =?utf-8?B?QWF0S3lDZ2xWVFk0QzJTUUFrQk5PRHNsVnN6QUEyWjFRcDhRZXlkRm1qcjcz?=
 =?utf-8?B?ZEZid05pN3ozODg1SFdlakh3MDBsalpJY3U3NkViVngrU2F1K1NTWE0ySlNB?=
 =?utf-8?B?VmpOWVJSNEpSYzZDbnFyVXRPMFNoSXhuMk1KcGYwZDNRL2pjN1czeVVINzMz?=
 =?utf-8?B?NU5YaUs3T09JS3RPTTBaajdQTnBxVTBuU1pVSmZDbFd1d1JqODBwTlUrT2xz?=
 =?utf-8?B?WTdZY2RxTTZSZ2NkaUFCa05yVk9YS0R4aUFjTmFaUjd5SWJ1R0k0d29yWC9K?=
 =?utf-8?B?bWwwQ0xMLy9HeW9CV3lycTZZT3FqSHZFVXJsOHVQZjV0WTNUYWh4NmhzbU5C?=
 =?utf-8?B?UTBXdDdhaFpQbWY0eFpWZXRMN2tNSXhnWTJkMTJsTDhqZkpjT3YwUTdMUGpL?=
 =?utf-8?B?Q3RtNEZJVERnSU9BRi9uSHBYRVpBM1ZhbXRVdEZUeDczUmJrRlN3T3VTQ2Nv?=
 =?utf-8?B?UDM4ZWhoWWU5djdSekVmTUhwdEVjYVc4cmRDa1NFdk53LzRpN2tUWjMyMDQ5?=
 =?utf-8?B?QkMxN2Nzd21sTXBWdGx2VlQ4cytxZ1gzenVBWlFicFBKaWNCRmlYMFNhaHBS?=
 =?utf-8?B?K0pzLzZmclNlUnVmM3FLK2xlT0RsUHh6UHg4VVRwTG41N2NjR0hjbzhsYzJi?=
 =?utf-8?Q?wu4wRWU1z+nFzpJNshx1b9OykraEOsTC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdGTHFyYThzUExkSlVaVER0QkJjcDlPSVV0UURqcTVJcEt2ZGg3cXNUOXpq?=
 =?utf-8?B?SDVtK0JwbDhnZFBCbUxzcFRDVStSOXhkTUw3NHBzRUtKeHN5eXNmcWV6bUp1?=
 =?utf-8?B?UEVlK3oxN012MmFNekhJQ3VhZHRJSk52eVlXNWYxOGdYZEVPQ3JFTHNhVG44?=
 =?utf-8?B?dVcyT2UyeFlISzBRbWIzMUkvbCtMU1h2NE80NXBJRTFVYVV1ZklValdvOVlG?=
 =?utf-8?B?RTM0Tm9YSWV6c25CTDdlS2Z2UUNIZ3JaRDZTZ1VWaTQ5OTl6cXZJaFh5dUdv?=
 =?utf-8?B?eXcweUM0Z2E4c1FBU0pxK21XWnFJZTRGamxWY1hQM2pmdmV0eXl1bDRORzhE?=
 =?utf-8?B?cndkeEJlSTdlZGtwQXJMeXJFZUFZZGROL3NXMjNqVkFRL3NRdlArV0E2NE93?=
 =?utf-8?B?c3BUeGd6cDAxVVhPcU1qcEFVdmpvMTBFU1pSMFRIbDRaU2tjSi9aVlpQMXVn?=
 =?utf-8?B?aVdURWovdm1weFh3NWVqaUFVS05jVllnMUp6b1hacktoK3F0d1lvaFE0VC9J?=
 =?utf-8?B?Y0JHSmtubUFLNjdjYnJ3dTE2QUE4UElLOFBaeUtrZStVdEhTVXlTanJIQmxn?=
 =?utf-8?B?OGVMYzdLeExKWnk0aWR3aWg4RmlYR3gwVWNxK2UrdHJ2SmNoRjBKUnJhRHlj?=
 =?utf-8?B?OFhjcGZHdnRUNzl2NkhjMXY5YTRNSFlYckp5Q3gzVDVUanBWd0YxQzZMaldq?=
 =?utf-8?B?NnVnOUlJdmZPY21OL1MyVjBleU5xOVU2OFZaU05VQlRkaE9Cd2MzbC96WDZI?=
 =?utf-8?B?Y2VJK1F4d3VDcWdKQmo1anhSZ2tPY2lGK21kRm1NZTM3U0VEeWRLbk9YaEM1?=
 =?utf-8?B?bkY4NVlGNUg3MUlveW5hM0QxalR0T3RkODhDejhKak8wUGEyMU9LM1RDbnVN?=
 =?utf-8?B?TnBaVGVIR2ltSzI0S0QvN3I1L2RxdlJ6WUczK0lUQnZuT2VKbW9Ic1R5cEdu?=
 =?utf-8?B?eDkzTENndHl5OTlveW1wbGxKZngvWGlvNnB2SlR3cDJPVG5CQWxJUVNSbzBt?=
 =?utf-8?B?VDVhN1FuRCs2aWpYZUV6Wk81Z3NmRENOYWJzNkF2dStKc2hTb3dUNTdVY0xi?=
 =?utf-8?B?dXNRQ1JadWNrbDBoTzdjQ0YxNzRodFZHUnlLSmZTdDVWNk5NVXkwaFVvcG1Q?=
 =?utf-8?B?UlNwSnJTUHIxOFhSUTBrMVdVb0l3Umt0MEVxM1JXNFdjZXFXajZJRVdPR1Nh?=
 =?utf-8?B?SE53bGFET1IzRkFEVVNrdU5HckZKTnNoWERQY2p2dUpVbUNoUklLS2pHL09C?=
 =?utf-8?B?aXFndEpKWk85SHcyU3hVQzdlQkF6RGJybEwvTU1JengveDV6WFZ0QW04MU94?=
 =?utf-8?B?a2xGWXNHbUQ4OVFtY2lFQ2lHZlNwMGtUWjIrczVhUysxNXE0akMzeFdYS0VP?=
 =?utf-8?B?ZklIUUg3MEhOVkZjdytaQlFXV3ZvWUVYUUl4UDBXUkFqSW1BdDNjMTJvL2g5?=
 =?utf-8?B?RTdpVXhhMkVxTFU0TUdNYXVhdGZDTGQ3QlRuTXhnQ05JK3Jha2JUZWJ3NTQ0?=
 =?utf-8?B?TUJ4SnBKSHgrSWhuUjhVQ2FqUzRKTEVNSktWa0RnRlBoakxZSDZSZmNoNC9v?=
 =?utf-8?B?R2xrSWgzRVdRTlhwQS9XY3Z5Z1o5cnA4cjZvdExxL1dRNEZpNElxWmZRcVlr?=
 =?utf-8?B?b2NFTU5sOW96M2hNUzJlY3l5SVJ0M2IzMWlha3BINTdLdWh2U3hVRjNlVnhs?=
 =?utf-8?B?bmo3MGs5a2J4U0xKQ3g4VU1vRThXQjNiMTVrTzYwS1dzeFhpamdsa29NakRx?=
 =?utf-8?B?OCsrOXhuS1NBN3IxaVZWbWJUQ3Z2RTlxNVpVWVo0akpSTEVRSGNOaGhZZ0lv?=
 =?utf-8?B?bFQvYUN3MGhwRWtWUFR6c05KOTZneDFEUFk4TExsc0J2dnVmOENoNFR4WTZl?=
 =?utf-8?B?R1dhNjg1SGVlNXlIRVlpTjI0RjdZY2VVT1kyeHZnZGVkUFk0NXBNV3B2ZWY3?=
 =?utf-8?B?dkpFL0twMUxxTC8yMGUxaWlVWk1hWU9iSmxVcFRIc2M5bG52WE15ZEsyRUtW?=
 =?utf-8?B?TUJUcFNROUtEeHlUTVM1SnJRdm5VQWljQUZpNEtuMVpCcWlGbWRGREE4NFk3?=
 =?utf-8?B?Z0ZXQkRYTFphN0Q3NmU0bkQ1TUc5NHpYV2puUW1tL0FiaUNmUTg3OUE3SFdU?=
 =?utf-8?Q?y8GM85EmvkmpOvpn0Opv0Bng3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d33087-29f4-457d-cc69-08dd2c6ea25b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:43.9210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZmx0QLDad05Dfdbcrcy0L3lFxnYb9zMjWY6iydvmZk/4n6qLK45jopKWghLwr3fxALP/v59xhzzXZuCNtpMYg==
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/common/Makefile         | 2 +-
 board/freescale/imx8mp_evk/imx8mp_evk.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index c2c86c0dd08252e8feef5d2f2f5176af408020ac..468a06725c1e470d0d36f79e8a25e31799562e9b 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
 obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
 obj-$(CONFIG_POWER_MC34VR500)	+= mc34vr500.o
-ifneq (,$(filter $(SOC), imx8ulp imx9))
+ifneq (,$(filter $(SOC), imx8m imx8ulp imx9))
 obj-y				+= mmc.o
 endif
 
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 024b46ef8bc28bd8f6085cc9cc290b719b37fd66..2ff067bc6752135f323398e620e37ef11d1b91bb 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
 #include <env.h>
 
 int board_init(void)
@@ -12,6 +13,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MP");

-- 
2.35.3

