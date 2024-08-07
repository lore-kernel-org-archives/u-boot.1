Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69212C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F7C88B54;
	Wed,  7 Aug 2024 11:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CS7puFWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9AD88B6E; Wed,  7 Aug 2024 11:25:34 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112E588AD4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+tpgKXsEnsLfe1iyNkqJCPwQTx6nWnJGcLXeqXP8QtoL1GluVXO9pVXwIi7iC+t+jlDEV7zO2fcejhQKGYlgh4cenL7sDm58pxhp2FaoMMaG96RJT+ORvSxFxV4R1/Bw4yO8kz0Wh2WhVRoJU9ZYOusFnCteY758I03hL09c80B2Z+4J9N3L8IhUg7+Db2QXkxzHqYVTNTuwXW1newgCuChIhKY5bAndsiyiRiRp64pRVBWmLvBWO053WxlWdi3mIfAIHhRqfRKPHFn2WRb4P1HskhzUZ0TympZVOU3f++RjG3ExbrWmW5scuusCQXQ+PcB/B+33rBX/vHidlXBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvbX5PBQ72avQSrgAW7cOOvcqU1LFy1PGn4MiHtK258=;
 b=Gox6MOT89Oo3KPKI2hV9v7Un5vQMjHoMX8iGR75W1GFRfw6Nnc/MV53/FryUWC0htZPeY0aI/UC70pVTls1FbKZQL2tfK6r3zN+xUylYEYxflFlx8J618/M0t4mXsDf2w7prWhL6BdtKz1ykK3kVdoY672XopkyN3ADqlu2Kv299cyShHAJq+2B7EA9FLzLMKu7fgAM99LWIn0WAs1DN1OXd1PUWzR6NK0GHyfx8V8MdTs3vY9zVxc0cURC1hnfteaFUXILDqiqB9R7QIRrdwtf8jxgyoDU/0vQfR0o3WXh8lZaWpV0mrtvDtla6xUJfPtgWlBgyN7fjNKXaVwKHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvbX5PBQ72avQSrgAW7cOOvcqU1LFy1PGn4MiHtK258=;
 b=CS7puFWd9YO9r5TS2QU0DYWoT0ktDMQK77mmG/cymEN9eYqGPf6caJlb8TN9OsKyUuQ1Gapbwc3HPEnhpmJuSI/Jc9B1hzoZToV7M1Az6PGLIwisD5glEDZqS5yQTjhIucmCMj7o3sxmg6FeWZjhE5ZvVySvRzkdz3HDeUVMAqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 09:25:27 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 09:25:27 +0000
Message-ID: <ace13491-2e9a-45d8-b485-94ae7b02246d@cherry.de>
Date: Wed, 7 Aug 2024 11:25:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] pinctrl: rockchip: Add gpio_request_enable() ops
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 23948f78-c2bd-4a24-e341-08dcb6c2dfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXZvNHNJYjRwekRjcHVKN0pTcDI2N1dUQ1MxMWNiVE1iblArdlFXOXF3cUFk?=
 =?utf-8?B?NHFFajZnZ2N6N1RnSVZGNVhNMDFtUGlwcGtXMUJQa3kreC9xTGpqeEVoNGNH?=
 =?utf-8?B?WkVJMjh6Z29Zak4rOTYvVWZ1K2FzRkNQaDAyaXJaOHliQXJTMWQyTFQzVGUv?=
 =?utf-8?B?bG5RRmpwOFNOM05ZRjNZK0ZJRC9aOTV5cjNmYnV0S2JaSTZubmxNeXRVSHZv?=
 =?utf-8?B?dW1XSEdESXU2OXRnMVZrVTVVWGQvbTg3NDlMMlBacEhSRngzZE9PMjdJM1VY?=
 =?utf-8?B?VFQzeExYSmdhT1lidEQ4OTFmWTIwWUVnRVVZckVLTDdocWpadzc3dEszcE9H?=
 =?utf-8?B?cFRCbC85MjAxWi9EOGZDeXduMEIrY3pVRHpxR1ZOOG1zenVwZWlOUkI2VVV4?=
 =?utf-8?B?VGhWcVMvdEhMUzRaQWY4T1JaK05OeTVvVVdGM0l6a3RBOGV5empLVHBiOXZM?=
 =?utf-8?B?L2FMUjMvS0M2RXVCY2hEQVFGWlh5bjNuK0pqeWFxNFVSeWNxNUJnclhqMjhY?=
 =?utf-8?B?SnB5Y0dIeWk0Wjc3TEZLdmZMWlVxU2RGdXVLdDFmK042RERhRnpXUlA0Qzlh?=
 =?utf-8?B?Uko5ZnpGWkNJditZa2FjTVFpNml0M3dnOHQzWmk5SCtXd3lTSDJkNE8yeTM0?=
 =?utf-8?B?ZnJhelI4UDY0Vnp3UXExaUlWOVhZVlZ0VFZodFFGM3dDTlJ1Qjk2a0ZmZTRE?=
 =?utf-8?B?T09YZ3NLSmltQnBoOU1BRGdIMFl2M2ZrZkVIRjRMaElVNVF4aTM4WS9LeTdU?=
 =?utf-8?B?OFN3NkxOYzg1d1RObE1NSG1WWlZQNkYrSTZSWHAyUmdHOEhudGMwM0RpSTcw?=
 =?utf-8?B?RXZrazFhOEpIYkNlOG8rclBpYVlEZ2tIb3ZOelFtNFNneUZ3eklDS1ZlaGl2?=
 =?utf-8?B?MGZkRnZ4T1NaQXQ3b0QwVHZhNTJxdnNTdWdZVlVOd05CTmM4ZHpJYXhKc3hB?=
 =?utf-8?B?ZjUwNkh2S0lieWhiZEFGUEZHemtESE1KWlJ5aFRVUnl0bkhxazJuTm5mVkU5?=
 =?utf-8?B?WmlEd1RZTUNmK1hJWDVTRHZuNkpleEVTUFUxSkxHNEJBNVpVQjBMNTdnVElP?=
 =?utf-8?B?QUQ0eVhFRVJUM25DTVdqVmVHaTcvRjBHdlBjbEQyOUpkbDVSUkptV2xVUExq?=
 =?utf-8?B?NFRBVUMxN3JYUDlMTmt4cDZjVzVpRjJIQmg0WWxWSnc2SDNHUmhTWnUyRm9T?=
 =?utf-8?B?SVNSQzVXUjJ4NkRzTzlBYmdTOWtmdU5jWUd0UjJKOUtoM1VZV0JZZnRwZFJU?=
 =?utf-8?B?M1BITjV3MHhMSnlOTEtObHgyaEZjMFk3WFlWMkRQbHF3bUI2c0g1SzVRMGNv?=
 =?utf-8?B?NHBJanFLNUFBZ0xxVjExRTJuTnRKbzFCNEVxMnFJYTdLd3loOGhhR01UMTZa?=
 =?utf-8?B?UlRCYXlMaWtGTjUybXZVUkFxNUFDOFpTSkFGUGpKdE5jendiaG44UmJiMmlR?=
 =?utf-8?B?QnQ5U0F6ajhsc2R2R3oxTkw0TVV0clZ0SFQ3U1NJTEdlVmVXVnFTUTFseWNE?=
 =?utf-8?B?WlB1eHhNUmRlLzBKUGZ4aEFqUlhrbFUrRFBXU1U4b0lVc2tualRBS1FtVGds?=
 =?utf-8?B?OEpsc3BxTjd1bk5RQW1EREtHT1Z3N1pwSlRBSjdQWVNtQ2VaNTNybi9yZ2Vm?=
 =?utf-8?B?NUFzNW1kaFVVK3VCRmpvNXBKcHV4R09mY2haejVzYjRsdE1SNk9vTi9sMGk3?=
 =?utf-8?B?b1V3U2piS1JPNVIyZmFkQ3N3Z0U3M2RtQjhCQUFCck5iWTdrNlhRL3ZxdlJl?=
 =?utf-8?B?clQ4a01hRVc3dTBDMWtlM2Mwa0FBQ1UvQzVoa25Ec2tJRkFUR1ZOUU9YNGUz?=
 =?utf-8?B?VzF0UXE0dVNBcWROT1dUZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjM1YnJhQVRFSy9jamFnMlpwS09Od1VETm5vUmh4aU5aUEtaVXpwZ3p4STE5?=
 =?utf-8?B?TjJBZ2djZVZWTGFWTGVEZ3RlY0RLem9TT2c3MEZHR2E2RTluZEhSTFdyaUxH?=
 =?utf-8?B?Vk9COGJkVEd3RXhCRVkwUHdXbS9TTSsvZTJWYmdvRWhnT25ZZ0orVWJ4bHJQ?=
 =?utf-8?B?NWwvL3BubzBQdlFISjBUN3VnWWF3UVIzeWFYeE9McDJUVlh3RENnOXpuQi9Z?=
 =?utf-8?B?ZzRud1l5OE5SNkFWNXZCZTdsaTh0UmkvVXgxVk5iWVpoSVRzSWt5Rms0NDFP?=
 =?utf-8?B?NXNhQ2JzT0xadlBWenJ1d1RsMlM1Ukg1U1R1VWh4OEo2eTNaUFFOTmtRbGZk?=
 =?utf-8?B?SVBlMXVGejRZRkJ3ZnRPSWoxUDZWYjZoTXpVelgwbmoranBsczJjV3g4MnRC?=
 =?utf-8?B?T05heERPZ09OWnRqWEdacHZVQ05oaFN5VVRXMHpJSzB3Z29zZ3R4bGhNcUxq?=
 =?utf-8?B?Y3VrNHlrcXlUUi9WR2M1b2hBUitjZE14UkVlcUgrdlVtMVJ5RjdKWnpTNEhi?=
 =?utf-8?B?eWxNWHNXajd3WVEyT1YvL2xhQXptNkNJQk1yS0QzRUNCN2E4R1g4WExBall5?=
 =?utf-8?B?ZnJLOXBsVVM1Wm8wY3RDS1BEelBtdEQ5ZklidlpSbDVGb3BnTHdmaHhDZUpl?=
 =?utf-8?B?NDZDKzU2TlFNWVJaTVhyc1RNRGJiTkJwRHpmTlB2QnJLRHRiaWY3VGJtcDlP?=
 =?utf-8?B?YnltSEt4b2c3NTVVQnhlMGhkd0J5SDIzRFpqR2tFeDgvdzg0Q1RlYUt6ZFMy?=
 =?utf-8?B?NExLYW1xK29KMzltSkUzbmpsWnljaS9UT0puZU5vK2VMSjk2a2gvNEY5NnpD?=
 =?utf-8?B?aFY1TnJvTGFLQ0QyZG0wSEJvdjF2ZlBRNGk0eTRYc01Cc2s3SlFOQ2Nnd0pN?=
 =?utf-8?B?eGVYSG95WEdaTGgxR00zTlZaT0h1MGp6c3I3Y2F5bDlKY3dGYWhiQzZrMVJu?=
 =?utf-8?B?a29UU0NZOUw5QTBMU0xuUlhaTWRUakR3Yis2bFlyZlFldUJlNytzandnMEp4?=
 =?utf-8?B?TkhSRXMvT0c3ZVpYeVBNZWkwU3FDdFd4V05JRE0vWUJmVURQbGRUd0dZQ05C?=
 =?utf-8?B?QkdxTFhydElWNUtkVHprNzNnSklrYzFaQlkwclFtbjVVNHNXeUJEZjEwWnJ3?=
 =?utf-8?B?QVFpR2RDSUNJUW9mNWovTEZKODFuSDhudlNJNVl5MmJscWErQmJVWDdNSlRI?=
 =?utf-8?B?TGJ3c0pERFpIQlF1Yk83dUVQRFI2dVNaSEpLY2VGZGI4TXl4SEpRS0Z1YkdI?=
 =?utf-8?B?YUVxRlM2STg4SVZLYmhRTHY3WXpQQmxySzA5L1c4M0xkL0RuYkNzK1IwMmZZ?=
 =?utf-8?B?LzVtbGF4Z0MvdnordG5EQThzSTM2UDZITnFuMWpKTkYyaXliTFlSMXpmb0Y4?=
 =?utf-8?B?d3Q0eW1LRi9qOGdTV3lCN1VlUGdPNDErcmw4cVBPOGlVT1JBSW1pQ0w1YkNF?=
 =?utf-8?B?aS8xQ05oVlVKUksvcmlodzhmT0puMndwV0Rnc2tueWFkU2lWMGNZYWI4MFZ4?=
 =?utf-8?B?MUdwYU8xWm5VT05MMklwUjE1MnFvSng4WlFvMVBaa05uMlUyNkpDZEZxUVB4?=
 =?utf-8?B?eWR2M1MyeTdBYUpJK3c3WHNyakhyRU9zQ3lLS3BEVHZxUHVBSXpRQldHVUc2?=
 =?utf-8?B?T3ozeEN0allWU05JRUNYTkozOFBzTDZRV0QzUk1DS0FKVDhkLzBpRjd5UHoy?=
 =?utf-8?B?QUNaaDJESzRmYVh1UHNsRkJlQWk4NThlTmdGSWM5L2oxNFpxSE1jKzQ4Wi9T?=
 =?utf-8?B?VnY2bWFZTnFGNGxNd0FVaktzeGI4WkhvVU91NkU4dkpvbVM3OHNNQXZSWnNO?=
 =?utf-8?B?TEloNWJWcTJNRW5nR1VhdmhneDVBcC9aYjlnd2xpUUkrZzA2M1BHeUFmZ3lQ?=
 =?utf-8?B?Sm1QeTdRaUdiRWh3S2dndlA2TnE5MWVuT1BncjdvOFJmaUhTckVXNS9UY1NQ?=
 =?utf-8?B?RERmSDcwalhFS1ptVjR3bEE3WDZuTkJ2ek1DY1V3T0xQQ255Z0RBaEZqVGQv?=
 =?utf-8?B?SjVscGp0ZVdOVWg1ZEREUVZlNG1DdEdja3F6VWw0SXFKbXcybHhRS3F5MUlj?=
 =?utf-8?B?dDVPQ1hpVVlFQ09NeVRQbUhSR1dIazRUc2VhWUsyVEk0WS9BWlVpdXdLU0RX?=
 =?utf-8?B?eVN0aEpCQ01jL2Y5MXEwaEZMbVRwNDZLU3VOKzZIUVdtd2JmTWVPU0JDSmZW?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23948f78-c2bd-4a24-e341-08dcb6c2dfb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:25:27.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tw5O9YxarzJNbxDEXYNHR36aJLuQgnePy8nzQB+gTs+7c+wgQ0PSbj9h+guO5uWWyd5J/V5dAH8N2WhVasCsIby9Q75XU1KgInjdPfpbR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
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

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Implement gpio_request_enable() ops so that the gpio request() ops can
> be implemented and a gpio requested pin automatically is pinmuxed for
> gpio use, similar to Linux kernel.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
