Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD523E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 13:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E2A80137;
	Fri, 13 Dec 2024 14:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NWt+A3rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B1B80192; Fri, 13 Dec 2024 14:11:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9868A800D0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQdv6La45L3p8MjAiXTSHm6g+JCEQt8uaVzbmtQMXp6SscUqVS/fALlWMkvfhFmzxGwVld21/KRMp3QXULRg50VzTnksdhmcEG5ldFJWIHhh84YLKNixkyiETekhuVGkvQKZH1c4RY4ut0vuImC11BhS/JD/75f82u8UCCKhwpozGHVz7xppTHKebpy6kDp+9djw0VUWz6ZGODD40lqXSWXlkcAZa1CvbLgGhDFMtRxij2qJ2P+kHRX2nR/s+HQ1qANpN9TZ+gTF5M1HJJG4YIxmAbYcl5rflWPeBZy7X0Vcxql4QwN/txc+3rV0U/+p5PuQzc9Di+sc5r59kvOUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2ZRRtwTUOnW55ntRKz4SyfseWhr3R8+zOEBX99tfr4=;
 b=jz4UZ2meoxFh5tVXXBIJedk6NwwFJUyhGefgPOd/2hqbyzpzJ15JrdzmjBOan/R9Z/svOAbf4q6fYtqVorXQKpZAOE/xy/C9HdkPLEna7I7eTK9GoGGLryAWd9CwruFaiNJPBACtkLY/uXQUnzt7WExmg4j680GOBWwTBPzzFZTVziz34uF2wQ7tD72VHrxrjL7g4sEIrYJEhx2jD+k+kt2OcEUWFwgmdogHzHJUs+cLoFAXSOi4lDJ2aibN4v6/q1XAQXNgis0hWQAzh7rjKokvhUgr1d8TXiwsD2xGP7mGI548h/K7y1ML+mNRtr+nY7tYimFzNd+70qkl0LBQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2ZRRtwTUOnW55ntRKz4SyfseWhr3R8+zOEBX99tfr4=;
 b=NWt+A3rLiW2CAUcPDkykVSsFyv29WkcBBC2U57KJ5g68gLTWoiYIvQaziXSO6GX9+VYHQfATK3c5CI5cLDhh4BTkQdycWKfhGQQJMjIEaL6b/hS06+VK4XyXsHZ5dUKBpxwKg2V7017oh1WpcxiVkbzdXWtwJdcM+Su9QeMuhew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 13:11:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 13:11:03 +0000
Message-ID: <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
Date: Fri, 13 Dec 2024 14:11:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241211033934.23044-6-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f460913-e927-417e-4da1-08dd1b779864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGxBSVRxNnRYOHcvV3ZGTHVxSllXVXFnL01DRjZ0UVE1V0RPVmVBRThkTVBa?=
 =?utf-8?B?dTE5ODFUbWtab04zSnY4NHo2clRNU0VESnpHdjRuOWRqMGdCL2g2Y0VWZ3Ev?=
 =?utf-8?B?QmQ1cThlL2lIMUZaNTUxcDJOUDZqRitxOVJYRC9IYlJDdVNVUExTWjNEeEVC?=
 =?utf-8?B?MlQwVEVGQjJZR0ZSMkMwN3ZwS2t6aENTUFhNbFVES1ZCbUFTZ3dnTTlubXRE?=
 =?utf-8?B?S3ZRTTEzWDhURXZwUXlLTEdXVlQ3UkFkbUtNSktqQVJTTFFwdEhHV3BRLzZE?=
 =?utf-8?B?Y0d5QnFMM2lQbzFsTDhlM0Y5M0wvTTYvUjVKaVUwVkVOYmJ4a0swc081bnlu?=
 =?utf-8?B?NkVLR3J6THU5d2FjZ3Bab2d5WnI4NWM2djB1bFk4Ri94eVZwRzVMcVhxTjJz?=
 =?utf-8?B?UXc5aENydWpSdHRhN3dZSUMxMkY1dzRoWVlHUTdXQ1k5a1hhYnpDUU5vYTFR?=
 =?utf-8?B?SFNaWW9BQUVnYjR0S0ExYVZ3ekJJRFNWSEY3KytBZUZncXVESkF3SmtoUGZj?=
 =?utf-8?B?OGVzS3ovVVdsZ1lvclp4T2dCUmpMVVorZU1aajFwM2xrTjhKb1RiS2RlaVMx?=
 =?utf-8?B?RHgvTzNIc1ROY3hCSlRYaTZ0c1M2cVBnQjdMWDY5SHV1eXJIWTB4MHUwV0xI?=
 =?utf-8?B?V24xR1BIaVdRWmpLeVVTNDdRTWk0WjZ5N1p5TVNpdFVLUVUyUzkreUZ2bTFQ?=
 =?utf-8?B?ZnFyZW1HUjVKcWlnY20veFl4SHBPNHJWOUx4MGpaOFVJUTJXNDFwc3pXYWZQ?=
 =?utf-8?B?NW1tUUU5Z0lrbEZsT0dwUHVQNHhtdituYlV5ekwvRWwrVkN5UVd0S3dtS01v?=
 =?utf-8?B?NlJpcUFzbHRhaE02MTdwYWNWTWRleVVPWGw4K0ZmK2ExTHVZQ1N6K3FNcC9C?=
 =?utf-8?B?eGxLUWN4OHFoSWg1TzRwb05ON21saE9HZnp6SFYxREtWU0N6TjhZMHNJd1Rn?=
 =?utf-8?B?TkhYQXN5Znh0TDl5MmUxU2JWM1RNSXZkZms2ejNHSVpwejRjZlZOa29OcUdB?=
 =?utf-8?B?VTlYRVNpMkw4eUwyaWN3eEt1SzAxUEcwVVJ6Qk9KKzQ1UEh6Q3VlK01ZWHBB?=
 =?utf-8?B?Yk9uUExPSE50QWtDZnJrdllsWTdhTE5KanJNUUg0SWNhZWh4elhHS0Z2eEtS?=
 =?utf-8?B?Y0NTWXppQzU5OXRQcmREd3BmZFNQQ3d6Y2hKNmE3TjMyVm9RM2tMQVhLZ3Zu?=
 =?utf-8?B?TCthbkxJVFhPMmFqdGZ1d2dYRWNiNTJjczVzSmkwY29mR1E4M0NnbTJiQktk?=
 =?utf-8?B?bGNwSDNtdzZSZ1JkZ0lnNlNsclgzWWtvaEp6TmZEWS9TTGdNNWlGRktQbGR4?=
 =?utf-8?B?RXd2WHVjZGlsRE95cWFHQmk0MXF6ZFpwQmZMdkZ6b2NGMlNkTEQzNkRTOCtl?=
 =?utf-8?B?RlZBQi81bnFxN0RwQjJHUUxaRnZqTnBOYW1hZkpKeGIvdXZ0dkJIejE2N0l6?=
 =?utf-8?B?aHRHRHVPR21ETkk2aVFSc0RTOW92LzFrM3JLQlQ5U1ZMSlo0QWVsbzFtbHJB?=
 =?utf-8?B?TXBydGF4UkpiSzd1N1ozSHBHOXdoTFU4SzNrYlMyK0VkUGFEc2NhbThGNGww?=
 =?utf-8?B?Tkt1RVd6RUdQTmJJRnlrdldUcll6STU4L3FMVjdLZzR0R0ZGQ004TmFQb2ZV?=
 =?utf-8?B?VTZUb0hZQ2t4RW5wRHhHVWJwSkZKZCtDQzRtQ2xFeFVGN3dZTTVYeUxseitT?=
 =?utf-8?B?OE9QUFRrdjBlTE0vNHh0alFaS0xlYk9ESVBGTGQ2c1p0bVUrcUFrQU5VbFNM?=
 =?utf-8?Q?I7WJEOJBwK2LZHDrcg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a055RjRFK1JKWHV4RHZWeTl3VXg5aTFaSi9raEhUUXlBZ1VWekhHTTY5OHRU?=
 =?utf-8?B?c3JzUDhEVjRNY0FuU2xlS0ZKa2lZQ2dudkpQWXVuNzVyR1JOeUlJQmRTc3pw?=
 =?utf-8?B?NWVKaHlWM1pIY0RqQmNwdHBwS1ZYSmNlbEtUQ1pRNDJDbGtwWjE5eHQ0alNH?=
 =?utf-8?B?czE3MS9qUm04alZEZU9velhOYlBWK1RxdVVqRCs4eEZNVmwxcVgrbFRlM21P?=
 =?utf-8?B?aE1VL21CVDZpTmZyNExzVHNjK3ZIRDZCZ3Y3QzE3c2RuODEvZ1NMeUw2dVYv?=
 =?utf-8?B?Wmh4ZGpPNVlNT2U3dnNkTm9veTA4N1FiMmxjemU4TXMwaWlSRHZiM2xDMGVL?=
 =?utf-8?B?UUxtc3c3R3hPSWlqK1FIUGpjZVY2aHMyM0tqRDZwWmJNQ1c2MUFRRTVUTldD?=
 =?utf-8?B?ZTI1TFhVVDZ0U0xjNFRHOC9DNC9zM2h5YXZsWlFPblU5NHhSTHpBZDNkanJu?=
 =?utf-8?B?UWhJamxjaGZzOVBjSWNadDJFVjZGWUJaa1dQa1FVeG9KcWRKMUMxd01yQ3hs?=
 =?utf-8?B?b0FrQk84cER4UXpaZjVNVWw2N2RDRWlIKzZtTDVSZHJzS3pNaUE0M3RrNWUz?=
 =?utf-8?B?cC9ua2xTVHZtOFAvM1pSN0tUSm83bE9ud1dIWVRBTk5waFJnRkErdHA3VUFj?=
 =?utf-8?B?eGViMEdyZldKUCswMnFrQWNHQThuVHUyZStYNmsvWGRhMnVjdjJHV2t1TjU5?=
 =?utf-8?B?QXFzcDJ0L0tZSDUxWWswTWhzSDFZOEwyTFpoV2tuaTlvTFdpcVNJcmk0QW1k?=
 =?utf-8?B?cDZxK1JoVUp1SUpmSWJOQTVPZHpwSkpZRmdSc1ZacXRoamovbldMUGhoaDNH?=
 =?utf-8?B?WVhrZHhrVWNhTGcwUVBDQ3d4SW04Qkl4NW5IZFdER2dlU0NtSm9RQnVpU0Nm?=
 =?utf-8?B?OGcxYlRuenpXUG1IeVpXdHVtZXpyV3ZwaDFGUENqNDB0aytWY0E1b1cxNU1p?=
 =?utf-8?B?RzF5ekR2NnhnQWdQNjVwODNrcXE2ditPQ2pDMzgrN09XT3ZFTUdSY0FZV1li?=
 =?utf-8?B?bDI2Rnc5MVpoclVGTno1SWI0NjFtZGdqRFJ0ZjkrcXRCNm5hMVIzZnhrcWk3?=
 =?utf-8?B?dWNWVWl6OGQ3WTBjTFNwVUwyamhFRWh1RndxOUpSRmE1eWtXdCtTV1ZnRUd4?=
 =?utf-8?B?YTNRckNLLy9RS3B1ZXkvQ0dtcjRsZExVamI4aGlkUzFaNkVUaDc4ZzdCN3Zq?=
 =?utf-8?B?ZFdtbjJpQTZKUEgxMjhIKzNwK1BVZFJ4Rjh5NGhQTzdqZDNyc3AzQkF6VWEy?=
 =?utf-8?B?U2VsY2hlWFVIWjFUZUlTcitjRTgwaEtmUTlXbVJKSm9zdVZBRlJXWXJ3dGtj?=
 =?utf-8?B?Z241UVBnaWVoUWdsUjFydEx6Tmt6TGgxdmp5V1I5SjAyT2krQlU0MjUvVlF5?=
 =?utf-8?B?T1NGVURHZkFWWlc0RENNWUlRR0g0ZjF2L2ZxY1VXaENsTDZsVmJ6cXl1aVp1?=
 =?utf-8?B?eXRuTTJPS013K1RWRzYrTGhPMGZ1SjdaaHZ3U1dtUThoMVdrR0hwdHA4ZU9a?=
 =?utf-8?B?LzlreEtlNmduWFozTmZ2UmJyZTREMXM5S1ZvKzRPZFMyYWNGcTY3Q1RvMGlR?=
 =?utf-8?B?OUV1YmR4eVpLck8vK2xiRmJVdEdveEx0enlKZk04YmNhd0FEWklPRGFZcUdj?=
 =?utf-8?B?enJNektBcVFBVENZM05jUTdqN1NOYW1KKzJEMWxaOVhWUG5HMnQ0NlVaUXY1?=
 =?utf-8?B?VGJDZm9TcHdmRGsxSWVuMlRUTEFrZHJFS2VRNWsrNlNDbWhsRmtRNlJnN2xo?=
 =?utf-8?B?REZMWjZtcG53YTY0RStXVkhWTElhbGFGR3l5U2FoY3Bpa1I0RG10OWZMbWk2?=
 =?utf-8?B?bXZaS0hDQkNxeDRMcHVmTEVtcWdpRW5zZVoveGxnT3lSM1kzRC84ZkQ0K0o5?=
 =?utf-8?B?VkxYcVJ5TUcvczE3YWJaNFB5ekduSHJmQ3lBRlZ0Z1VoRXIxMWFYdzh5Lzc3?=
 =?utf-8?B?VUhwekxxVHF3QmprWVlOdHRTTmZUNnVhNCtta0c0TFNLQ2xwQmF0aW9mN0ZU?=
 =?utf-8?B?ZVVJNVZINjVWZDVSRnJEdVdLWUVSTW9ZZDhWaWlWTnJnTmxoZmtvcW9Sa3VO?=
 =?utf-8?B?Nk00N2VYaFpSREFnZkxhOVkrRk8vQVNYclBnMHJ3MkVTcyt2OVZadWcwUGZi?=
 =?utf-8?B?Q1JKQmRHVEJ4MWJVam9xVTJ3TWpkT0RBM3ZwUXd5SGFBdWRiaVNKSkI5M3o3?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f460913-e927-417e-4da1-08dd1b779864
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 13:11:02.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWuNzbugTtF/4fFHDFQpOyT7S1hd0T/1qWkz6SLH7B5DuHzxrXgwdjt7TcB5lYbX8KC7a5ka+cqUpevDpKr251Rdeym8h1E44GisbasUrGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
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

Hi Naoki,

On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
> 
> [1] https://radxa.com/products/rock5/5c
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v3:
> - fix compile error
> Changes in v2:
> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
> - include/configs/rock-5-rk3588s.h: fix include order
> ---
>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>   configs/rock-5-rk3588s_defconfig            | 94 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   include/configs/rock-5-rk3588s.h            | 15 ++++
>   10 files changed, 239 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>   create mode 100644 configs/rock-5-rk3588s_defconfig
>   create mode 100644 include/configs/rock-5-rk3588s.h
> 
> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> new file mode 100644
> index 000000000000..be1a2f9ae7bb
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&saradc {
> +	bootph-pre-ram;
> +	vdd-microvolts = <1800000>;
> +};
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> new file mode 100644
> index 000000000000..bb1cc9e4a279
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-rock-5-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a532..e1487ecb0464 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>   	  Front-panel connectors for audio and case-power, -leds
>   	  Powered by either 12V, ATX power-supply or PoE
>   
> +config TARGET_ROCK_5_RK3588S

This should be TARGET_ROCK_5C_RK3588S?

> +	bool "Radxa ROCK 5C RK3588S2 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +
>   config TARGET_SIGE7_RK3588
>   	bool "ArmSoM Sige7 RK3588 board"
>   	select BOARD_LATE_INIT
> @@ -398,6 +404,7 @@ source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
>   source "board/radxa/rock5b-rk3588/Kconfig"
>   source "board/radxa/rock-5-itx-rk3588/Kconfig"
> +source "board/radxa/rock-5-rk3588s/Kconfig"

Where's the c gone?

>   source "board/rockchip/evb_rk3588/Kconfig"
>   source "board/rockchip/toybrick_rk3588/Kconfig"
>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
> diff --git a/board/radxa/rock-5-rk3588s/Kconfig b/board/radxa/rock-5-rk3588s/Kconfig
> new file mode 100644
> index 000000000000..86830be1eeca
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROCK_5_RK3588S
> +
> +config SYS_BOARD
> +	default "rock-5-rk3588s"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rock-5-rk3588s"
> +
> +endif
> diff --git a/board/radxa/rock-5-rk3588s/MAINTAINERS b/board/radxa/rock-5-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..ead6356131c1
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/MAINTAINERS
> @@ -0,0 +1,8 @@
> +ROCK-5-RK3588S
> +M:	FUKAUMI Naoki <naoki@radxa.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
> +F:	arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> +F:	board/radxa/rock-5-rk3588s/
> +F:	configs/rock-5-rk3588s_defconfig
> +F:	include/configs/rock-5-rk3588s.h

Why are all those files missing the c character?

> diff --git a/board/radxa/rock-5-rk3588s/Makefile b/board/radxa/rock-5-rk3588s/Makefile
> new file mode 100644
> index 000000000000..d9be0f42e6b9
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += rock-5-rk3588s.o
> diff --git a/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c b/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
> new file mode 100644
> index 000000000000..a840ca7698d4
> --- /dev/null
> +++ b/board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <adc.h>
> +#include <env.h>
> +
> +#define BOARD_ID	5
> +
> +struct board_model {
> +	unsigned int low;
> +	unsigned int high;
> +	const char *board;
> +	const char *board_name;
> +	const char *fdtfile;
> +};
> +
> +static const struct board_model board_models[] = {
> +	{
> +		0,
> +		50,
> +		"rock-5a-rk3588s",
> +		"Radxa ROCK 5A",
> +		"rockchip/rk3588s-rock-5a.dtb",

We already have a config and board files for the rock-5a... There should 
probably something to be done to merge them together or remove this part?

> +	},
> +	{
> +		2375,
> +		2425,
> +		"rock-5c-rk3588s",
> +		"Radxa ROCK 5C",
> +		"rockchip/rk3588s-rock-5c.dtb"
> +	},
> +};
> +
> +static const struct board_model *get_board_model(void)
> +{
> +	unsigned int val;
> +	int i, ret;
> +
> +	ret = adc_channel_single_shot("adc@fec10000", BOARD_ID, &val);
> +	debug("adc_channel_single_shot ret %d val %u\n", ret, val);
> +	if (ret)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
> +		unsigned int min = board_models[i].low;
> +		unsigned int max = board_models[i].high;
> +
> +		if (min <= val && val <= max)
> +			return &board_models[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model) {
> +		env_set("board", model->board);
> +		env_set("board_name", model->board_name);
> +		env_set("fdtfile", model->fdtfile);
> +	}
> +
> +	return 0;
> +}
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	const struct board_model *model = get_board_model();
> +
> +	if (model && !strcmp(name, model->fdtfile))
> +		return 0;
> +
> +	return -ENOENT;
> +}
> diff --git a/configs/rock-5-rk3588s_defconfig b/configs/rock-5-rk3588s_defconfig
> new file mode 100644
> index 000000000000..54043264de48
> --- /dev/null
> +++ b/configs/rock-5-rk3588s_defconfig
> @@ -0,0 +1,94 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5a"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK_5_RK3588S=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"

And now we default to ROCK 5A DTB... This is all very confusing with 
this little explained in the commit log.

Cheers,
Quentin
