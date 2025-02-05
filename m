Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A747C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11912805E7;
	Wed,  5 Feb 2025 16:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ej37zLM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D509806FE; Wed,  5 Feb 2025 16:40:52 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC53E80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewzei1nVo3RYAJouG6MDbesQj4+P0qDQPmf39+b6ExIRz9qsH3hOHz5hztVghQad9hzMtflltEt8gJsWts/ZJq0hy6/6P6okDWImdARfCYx+9BS5Zdg0t6Pf5LAyRzhNMDb+q2YTEwOgL63WRPjYxW99alDclrDvFKwPZbuFnn2IDGdVewBudY0alPNjWzw4UtxbCOHbzt+mGUo4huYl70/Gkcem1SXWDs/c5GUPKEwIdLbbEe9/YdBKds61J8Tq7k9fxD5qn84CC1E6T04H65Tn1wMdjXeaVIEQ/2h/0PbZkObqCac/UEMxmOaqLpEDkBkGBBoPPCXtXHXcJNEfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2T8jlCqgVttwFSz7JuVdVJaEIqaZiXRstdGJGzVoPg=;
 b=jHnU81Ltj6vH8To/2cAvMQ9E54D4XQMPuqtHHKGbfAUMiGbzy3HYXGdQqfEgzjgLNzhLm1wr+BYOYMboZ2XMgU/QZK9+RAs8r63L4+FLBV+x6GUK6BvalOlk4j05oYVgxJzexoYKlFLevbQKqmaDURPFQ5W8WQ8sG6Q8QiYczRz0/t5hc/UaxvXh0GmIfB5ZBbD3r0Yf1rBhubZTQg5+SITChTUmkBvZsWZ6HbkekkqKZ3WlrmVwTeDn1xHvhd9eoq55RBIbuxO5z2mxmAqzbRSJYlSsGUDthYC8FYYKpFZAG5cidiTIOcuaDFA3x5pGc0PfCh7JptGur/8OxKp3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2T8jlCqgVttwFSz7JuVdVJaEIqaZiXRstdGJGzVoPg=;
 b=Ej37zLM4RVBQ5kQ0oEeZlqT2SBvkFlmOOOjsqL0jaB9h3BZCwV9hu+gSMZjNf1k8BtwbjR/5hi6zGpJiEnDr0xKAT2FQAylEhZzFfKsC5qb2RW2gpjbEt+DJ3V9Wwla7Tjog/9XmVJWl+uZMnHAvFvaeNUztjh8Q23k7JMl9jN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10890.eurprd04.prod.outlook.com (2603:10a6:102:48b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:40:47 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:40:47 +0000
Message-ID: <18e356d3-de3b-4021-8ffe-e0b33d5db2cf@cherry.de>
Date: Wed, 5 Feb 2025 16:40:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rockchip: mkimage: Split size_and_off and
 size_and_nimage
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d58339a-d322-4036-6766-08dd45fb75e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0cwSmxWQTc3TlVkNVhtc2E5d2VTQVQ0UVByN1BBUmhxTXFtV2M3ekgzaGg1?=
 =?utf-8?B?TjMvTG0zbXhQdlJOMGIrN2Q1VmxYUHVzTXlWTm9JRUlVUjI3eDc5SGMvREhu?=
 =?utf-8?B?T25lS1dkSXpZWEpwVEJBYU43a0dsS0E2cGw2TEUrbVAwTU54Zzgxbk5QL3M1?=
 =?utf-8?B?WG1uNGNZd0ticitjMlJzaE1ybFdYVXVyUmlXV1RweGtOMnRCTW54WEc1bWk5?=
 =?utf-8?B?ZzZSdUlZSzBpR08wNFgrM3ZydDlOejg3MzZBZkdQUFdVdnBzOWFRWnRDamxi?=
 =?utf-8?B?RklaSkx3YW44cktuS1g3bUNsU1lacWk5akJTdHUxVWFVbCt3T0pueDBzZWl6?=
 =?utf-8?B?THpZY1Vxd21Dc0NQOHRKOHNIemVkSTd6Y2RJRkxMckhNd0VYb0o2TFF1eGUv?=
 =?utf-8?B?OVNUUkVoQXVkcE1YaWk2QUlRRjNjaFdvTitkVGxUQTA5R0liVFJrTlZRajZw?=
 =?utf-8?B?NmlHTnVpV1hxdi93Zzh4MHRwMzgxb2JYSjRvZHQyMkZUVWpaN09VYjI4MzFw?=
 =?utf-8?B?VXlkVjFRMkpyTHA5T1gyNGJPL1Q3Z2VRVVJWUWkxYTVCOGxSajF1QWZSU0Qr?=
 =?utf-8?B?QVZKdXBtQ1JVRjNSVXFPbzNCK0hzRWNrK2xxR1J4M2JuVmtiUWdFMmdXc0RT?=
 =?utf-8?B?SUFRVWJjUkVQc2V6N0Y3STl1MHJGbmxMc2dCMWt1QUVKTEtsM2xWOG1aUENB?=
 =?utf-8?B?Zm1HMU9JMmJiK21QNHVlMW1qMStjVW9UUlNiQTBBQy9hcWdNbnJPSlZGNFlD?=
 =?utf-8?B?M2luVjlVVWVQVG1UR1FRL0NGVzB1bE5lS2hUamdLWnNwSWYyYTBUeUJUWjRM?=
 =?utf-8?B?NkVGejZNZE50TlB0TlROZU9hcUZhQzBVWTk5RnJzZ0k4cGtIQ29zMDlMczdO?=
 =?utf-8?B?ZU9zTC9DUWtoZTI1M2Q4RHpROU5nR09RUU1CVTg5QlU4b3dGaXlKNml2Szc1?=
 =?utf-8?B?bHFOZy8xSi9BdG8vSDZJMmNzMk1LZXFxSktTaS9rU2l3ZDNyNFpzNHZNdWpj?=
 =?utf-8?B?ZTU5T2R0bFJzdmt2OTA2a0FkR0dmaGZkbFRHNkszVFluVW5GYUpCb01wU1Rp?=
 =?utf-8?B?ajhNL1FCWXBvUVB6L01GZFpPRWpBMWIrZ3ZZRjNEZmJyZmxSWlJ0dnhoU1M3?=
 =?utf-8?B?elJvaU84YURJWUJqS3N6U0hjM0xRdmpJeFJ3N0lkUytsT05Udi9CMDFBOUpL?=
 =?utf-8?B?OU5tNlJqZ2VlN3p3ZmVXcHhLYkZDUXBxV2liZWZHKzVSVUY1amVwTXVtSHVz?=
 =?utf-8?B?dGc2VjFSVFRBTHJiYXYxakJkNUxKOXUzUGMrOWxtbDB2RE8zR0F5a005WWF2?=
 =?utf-8?B?TEVvOXBRNjNxMjNpYTg3MkRNOGtGYjJZSXg3eWo2aUU2MkhrL2wxUG1jTUd0?=
 =?utf-8?B?SERCS0JKMmtHdWduQ3QxNkEyQUdUY3hNT0tPbk4yeEpzL0JJbHdHd3o2RzBs?=
 =?utf-8?B?bTROY3lOM3AvTnlvazBDK1lsWUVBQUNTcGdqaDEyczNselVHU2sxK0lWclNF?=
 =?utf-8?B?LzR2Y2xjQmtCd3dSZSswUVl1YytuU2JxR0pTN2kvTFJGbm1heGE5UzFTMitN?=
 =?utf-8?B?N1E5VTZadlNsZTdIK0tNbWx3amVkU253cTQvT3lIMTNISkNGWWQ3U1hDOUxQ?=
 =?utf-8?B?S3B0VUxYdjJuNi8xRklaQ2dvSHpjalNhVEdQanRBdFdxK2k5RlYzMXo1a3Vz?=
 =?utf-8?B?VUM3dS9FRE51Ky81UTdYbW5xRnMxdU1BbG55dURqbFJBSWlhQ3ZKU3JjWU9S?=
 =?utf-8?B?ZVpaSlo5cDcwT2JiYUV4VkZLTlMvdjdwSE9rSVNFVGphZzNVVndTa3hEbWdh?=
 =?utf-8?B?UWQ0ajlkcHlQNWlub1hmWXJQc1ladVYxVlZNWThYdzVUaEgyN0JjYjFkMFhE?=
 =?utf-8?Q?n19CovZpDoOEI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWtDck53alZuKzZVVHc2OEhDSkpJMmJpQmR1U2lqTlk4bmljYTJRd0thM0ZH?=
 =?utf-8?B?YTlKN0FDaFo1NWE4UlE2OVNLUzNFTEFpeHFsK08yM2Z5d2Z1eEk3Y0lWWm9L?=
 =?utf-8?B?NDdDUDVvWXdyWUhNZ1RUeWlZWmxNUlc3YU1YOWl4T1dqWWZBakhQakQ0Q2pm?=
 =?utf-8?B?TldJdlBWL3o2anIrV1V1aGU5c0lmc0JEaHdxUVN6Z29GZnZITzk1SnVEYWJj?=
 =?utf-8?B?YkZYa0N3SDI1NUNGdTlwTGNWY0dSTXNkTzFNb3BDc0tlVVZZV3NZbUx2WHFj?=
 =?utf-8?B?YkdIYXk2Z0hFeFRoditLOEhjMCtsTDd0QVN0WkZEQ0swV0cwN0h6czdtcmRI?=
 =?utf-8?B?QnZrY1hFTDZqeE5OTERNbE05aDhwdklGY1hVR2hJb3dxT3VpMWM2VmRBbUl2?=
 =?utf-8?B?RTlMT0xJU290NUh1cWFDWWpEeEVoNEdjWURhQ2YxWitxMXdNbEJGWElPQ3Zu?=
 =?utf-8?B?K2k4OTM3SS93QkgvZkh3RTNFNzYyam5JbjJRWjdZQzRPMnRUZDdWaXdBZVU3?=
 =?utf-8?B?OFladjV6TWNnekhlUXVDQUtCRXUyS3BxZDJXQ1Z6K2xSRXBWYVMxN3k2Z29U?=
 =?utf-8?B?dGV5V2hXdlNwdzdYZVJoTmRNKy8wY2lZTTRNUmZ2VHhQR2tFOVBhUm5TOW43?=
 =?utf-8?B?YmdlK2JMajhlUU12RlpkNU9KU2tmWGRaZVhyQ3hLb0lzelh6V2ExVXFOYVc3?=
 =?utf-8?B?OTFjQWkxZkMwZ0l5bHRQU0NtQW83ekRacS9KQUFTZ0dvbkZ4VW40LzI4UUdM?=
 =?utf-8?B?TEJEd3RTQ0pQbjlucnppZ24zdVc0enh2MVBZU3lrM3VXa3FOaGxYbGY2eEo1?=
 =?utf-8?B?OXJVTkhLMEYyekFNOVJ4Y0p3WkJ0bWJGcXBGQlJzb2prdU12Z3UwTndFeXBM?=
 =?utf-8?B?Q3BPbkY2OUZ3M1BPaHB4ZXRqakxXVmcrUFdTSTJaekdkYmJBRjFHejZDV2Mz?=
 =?utf-8?B?dFRPOERlbjRiTmRPdEpTQXZyLzlwN2EyK29Idml0bk1WbHFoRWFmbHA3c0k1?=
 =?utf-8?B?MS80dUpoUElUNy9LNjhRQjRhSm4rdjhFV3FQOTNidGRQUFBjdGlwcFdrb2Vn?=
 =?utf-8?B?RWVsNytFK1VkL3hvTWgyc2kvdGZ0ZGVucDdtcmxGSVFiQzRTVll1VmNtcnBC?=
 =?utf-8?B?b3hwdTIvazVjTEtGNzExV1JyZHZPbFpyNkhWRksvcG9uazYyNjIxMlA5Qld4?=
 =?utf-8?B?cUFSQkxqWkFUZUd2T0szVGliZlhHZUx5WWhvcm1ZQ0U0U3hqWm1EUjE5Ulgw?=
 =?utf-8?B?YU14VVoveXdBRXBnakZFcGhsWFJ0cXVIN1l2d0txQ3hkQnZ3cjJHUDBxUnZ2?=
 =?utf-8?B?WW5kc2dXZDUvd2JoVm1mOUwvaG9xWTdsdmN2UEVSQzlGc1RNb2JBOUliS0dB?=
 =?utf-8?B?bUJDVXpxTUxKMDE5VTlzemRqaVFTaTFkMHVHakZnTUdwRmxEYkoyT2VOUWR1?=
 =?utf-8?B?ZmZjd05CQUdoOTFJTC9sZXZjUWY5aWViRjlOMlQ3V1MwSFBqWXBpK05WVWMy?=
 =?utf-8?B?NnZKZmxjakpHNnhtUHVOUmt5c2k1dUREUG5VbFNMa1RpOURHOXcybXhvQ3lT?=
 =?utf-8?B?K3Y1Y3hlUXBVdldHYWtQVnoxdkEzVjFhWFVJV010R0ZIYkQyMGdyaXhUQ2Z4?=
 =?utf-8?B?MW5aK0g3b2VNM1dVeDIxRFJ6RFpvRDNIYlQ4azVjRTN3QUhMczlVMTVYazBS?=
 =?utf-8?B?bXJkQUZKdXJlS2ZnK2kzekJIRkNGdGRVRUZBd1pCNnZYK00rNEtKVWdYS1lj?=
 =?utf-8?B?ejVSRlNvZnMyVzBQODZwenljakw0Z3VGTnUvQ0VjZzIyUEcxQ3FnUVBDT0V6?=
 =?utf-8?B?Qk85NUszeXA0RVNEWDJSZ3NRT3V1VmxYc2Zza2hxWjdxTWc3bmllTVduK09M?=
 =?utf-8?B?eXFxQmE5N28wYWt3VnpqREV0RlptbmlERE05UDJCcXBwdXBKcFJxZjZ1alBD?=
 =?utf-8?B?bjdLT2JOVXZlcVQzZ2Q0WFFHYklSZjhzVnJ4bVAyeWMveVI0eUZBVkluakw5?=
 =?utf-8?B?UjhMVE5CbUdBa3NvNk5rSExoUDRvVXhYeEZUSVFYYktTTnJzcXFsNUtCd3Js?=
 =?utf-8?B?cGc2M1d3UmV4Y3A4dWNjK3VyeGRvbEpSSkZYMnZ5aUFBMHl4TmcrV1RWa1NS?=
 =?utf-8?B?WUpWMmxiMlRDVHRVQU4xQm9OeTFLb3l3M1oyOTlBdmJ2TzFxUiswN0Y3RFdT?=
 =?utf-8?Q?1SGpIiyDoD0EkxJlEQUjDQA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58339a-d322-4036-6766-08dd45fb75e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:40:47.5238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUTIP3DLVVdsNJ1aURxFWS1KGWLbUbm+k5KWk03DgYTJK2BNV3Zo3/MOJ1tRE6TY2sq2E7JdL3fZahpbf15MGKrE+ymBXh9q/og+ArIG0ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10890
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

Hi Jonas,

On 1/29/25 11:36 PM, Jonas Karlman wrote:
> Split 32-bit size_and_off and size_and_nimage fields of the v2 image
> format header into their own 16-bit size, offset and num_images fields.
> 
> Set num_images based on number of images passed by the datafile
> parameter and size based on the offset to the hash field to fix using a
> single init data file and no boot data file for the v2 image format.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 3e52236b15a8..de3fd2d3f3c2 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -34,15 +34,16 @@ enum hash_type {
>   /**
>    * struct image_entry
>    *
> - * @size_and_off:	[31:16]image size;[15:0]image offset
> - * @address:	default as 0xFFFFFFFF
> + * @offset:	image offset (unit as 512 byte blocks)
> + * @size:	image size (unit as 512 byte blocks)
> + * @address:	load address (default as 0xFFFFFFFF)
>    * @flag:	no use
>    * @counter:	no use
>    * @hash:	hash of image
> - *
>    */
>   struct image_entry {
> -	uint32_t size_and_off;
> +	uint16_t offset;
> +	uint16_t size;
>   	uint32_t address;
>   	uint32_t flag;
>   	uint32_t counter;
> @@ -56,16 +57,17 @@ struct image_entry {
>    * This is stored at SD card block 64 (where each block is 512 bytes)
>    *
>    * @magic:	Magic (must be RK_MAGIC_V2)
> - * @size_and_nimage:	[31:16]number of images;[15:0]
> - *			offset to hash field of header(unit as 4Byte)
> - * @boot_flag:	[3:0]hash type(0:none,1:sha256,2:sha512)
> - * @signature:	hash or signature for header info
> - *
> + * @size:	offset to hash field of header (unit as 4 bytes)
> + * @num_images:	number of images
> + * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
> + * @images:	images
> + * @hash:	hash or signature for header info
>    */
>   struct header0_info_v2 {
>   	uint32_t magic;
>   	uint8_t reserved[4];
> -	uint32_t size_and_nimage;
> +	uint16_t size;
> +	uint16_t num_images;
>   	uint32_t boot_flag;
>   	uint8_t reserved1[104];
>   	struct image_entry images[4];
> @@ -332,17 +334,18 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>   	printf("Image Type:   Rockchip %s boot image\n",
>   		rkcommon_get_spl_hdr(params));
>   	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
> -	hdr->magic   = cpu_to_le32(RK_MAGIC_V2);
> -	hdr->size_and_nimage = cpu_to_le32((2 << 16) + 384);
> +	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>   	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>   	sector_offset = 4;
>   	image_size_array[0] = spl_params.init_size;
>   	image_size_array[1] = spl_params.boot_size;
>   
>   	for (i = 0; i < 2; i++) {
> +		if (!image_size_array[i])
> +			break;

This isn't related to this change I believe, can you please make it its 
own commit so it doesn't get lost in the diff and has its own individual 
commit log?

>   		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
> -		hdr->images[i].size_and_off = cpu_to_le32((image_sector_count
> -							<< 16) + sector_offset);
> +		hdr->images[i].offset = cpu_to_le16(sector_offset);
> +		hdr->images[i].size = cpu_to_le16(image_sector_count);
>   		hdr->images[i].address = 0xFFFFFFFF;
>   		hdr->images[i].counter = cpu_to_le32(i + 1);
>   		image_ptr = buf + sector_offset * RK_BLK_SIZE;
> @@ -351,6 +354,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>   		sector_offset = sector_offset + image_sector_count;
>   	}
>   
> +	hdr->num_images = cpu_to_le16(i);
> +	hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));

Same here. Just do a migration commit (possibly one for struct 
image_entry and another one for struct header0_info_v2) first and then 
adapt so it handles image_size_array[1] = 0. We don't today so a 
separate patch explaining the usecase would be nice.

>   	do_sha256_hash(buf, (void *)hdr->hash - buf, hdr->hash);
>   }
>   
> @@ -497,10 +502,8 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>   			return;
>   		}
>   
> -		init_size = header0_v2.images[0].size_and_off >> 16;
> -		init_size = init_size * RK_BLK_SIZE;
> -		boot_size = header0_v2.images[1].size_and_off >> 16;
> -		boot_size = boot_size * RK_BLK_SIZE;
> +		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
> +		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;

Ditto. Separate patch for the le16_to_cpu would be nice as I assume this 
is not a side-effect of switching to two u16 instead of one u32. This 
likely fixes a bug :)

I was wondering if we shouldn't have CI to generate a handful of 
Rockchip dummy binaries with the header on different endianness so we 
can catch those. I remember we had someone fix those for v1 already.

>   	} else {
>   		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>   
> @@ -514,8 +517,9 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>   		}
>   
>   		image_type = ret;
> -		init_size = header0.init_size * RK_BLK_SIZE;
> -		boot_size = header0.init_boot_size * RK_BLK_SIZE - init_size;
> +		init_size = le16_to_cpu(header0.init_size) * RK_BLK_SIZE;
> +		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
> +			    init_size;
>   

Ditto, separate patch for le16_to_cpu.

Looks good otherwise!

Cheers,
Quentin
