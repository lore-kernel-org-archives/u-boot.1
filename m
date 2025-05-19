Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B81C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 10:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDCD81FEE;
	Mon, 19 May 2025 12:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ANyliCfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7028382AC4; Mon, 19 May 2025 12:48:20 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D73381E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjzjaZc2j7ZjDqhc2reifD8O16BUNbKIGV1TOJRSBzss/xv9N87hz0ZwWFo3kh95U3OipUS/OpKP/jTb/q7vgYQ5XVjIV34S09lpkvun9BTR5dnyL+WLWeb3u2/MAuDV4gWBX3ZIGBF0PKPi6i1Qt31l2zR6UfhlszsrD+iTu2GJjsTej7+57BRRw2kYA2osLl0wqoSCx5ZXkI9n+Z1RULZ6dpqaCvChm7S7mSY1ZVW4XTD9CoFtWtyK7547Qz7onBy49OZpnaklQzfSQ1hJeu0xhDSolKGCT6Wcqen0//9hwZG+ujaI02XS05RWjPcJDehIRPT3VUs2hH9B1TFfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMzX+I3fEHqbDgs5vceuqpS73oShQnRAJYX768iGQMs=;
 b=n18d7qd0aEi4awGyHrAf03WEl4cBccLiHzvnZutP7oQKELiCqknXdFTANzw3AZukwe6VHi2qWAKTzGK2SIzsmTDipVNUZLYpxOiRfUn1HkPbMyPTD7f4C7rHiYbD6Qh6T0VKa+3xQ5f2GNpODA4oetuhiZ/zNQYRcYNc/jr9L71P9DU3meeE4UyR2x9fj5wJ/S7wzql9AY17iClofDZ1gZ4C52E24kQEroT4kjk/1l6bAZl0nQ8SmEBI2s2UlAk2l4SRKpHky0tjXGiv8NYiCuFIvqPnnwAiIuv8pDHdXvuzUD45zeTFXp79Zkmumca9Y1kyR84pU/xZU2fozNAtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMzX+I3fEHqbDgs5vceuqpS73oShQnRAJYX768iGQMs=;
 b=ANyliCflaNnp9bgo162MnLtQSc9M1hAyK5LXHoNDd+DAClx1ObnjN/sHL92Mgwdw4r7BkzkN9E/ACaF9SE3N0xHU06EbevmcoDY7O8D1qXnjs4dWjnGeE9i5vQU48x9xVDvI40EmrZQdQmKDH9PzSLU2iUPrTPajGeWus9f3p7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 10:48:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:48:16 +0000
Message-ID: <60aa0dfc-0f21-4769-ac92-1f4ea5cbb12a@cherry.de>
Date: Mon, 19 May 2025 12:48:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com,
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
 <20250401050356.hqcksshomlgjeyno@uda0497581-HP>
 <CAFLszThKdxESi=SCLOy02aau5zyDsF36meyiCMrw4vhM6JDCtQ@mail.gmail.com>
 <920180ff-f5c9-4454-912d-f1e76a5aa322@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <920180ff-f5c9-4454-912d-f1e76a5aa322@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: bff5cb8d-4050-42b6-97df-08dd96c2a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nkk5NXZLUFo0T2dVcXIvS0d3ZDlTUjBvS1k4bks0M1ArOGJUaDdISUtjQ0NX?=
 =?utf-8?B?YXZrSjZCWFZmcHBWam5rSUZjbEtScnpFOU1rREpJSE5jYTZZQThnSHRlczds?=
 =?utf-8?B?MHh6L24wa2doN0dNL2JramJlbFZ4L3hHZU8rekVuUmVlcytRQ0t2bEpEbE9s?=
 =?utf-8?B?VVZJRmZvRkNyMnhvLzdXNnJsZmpKYzR2Yk9WRVRSYWxrVU5BQVNTMnlJc2p0?=
 =?utf-8?B?bVR2TmUvakxQY1owTXJTMVlIRi9zUUVZRC9EMHpLK3VmdTFyalBnaGZkektR?=
 =?utf-8?B?OXhKTEhlc1dKWmZlbmE3KzNHMHUxaldUdFFJeW53eXFwZlljUHp1VVVjVW54?=
 =?utf-8?B?cXQ1V3dUelV5NWxkNkZoclN6Q3RNTkVJY0NpOHB4Z1FBOE12NFhTNldSOGhU?=
 =?utf-8?B?QjFQNkxtdVNtK0hUdjB2K1FJdlMzWER6UmVvTFlQTFpzQ09iOUNnc1RRa3Rj?=
 =?utf-8?B?RERSd09WZGEwaE84YnY5ZldFR1lxSVBRNnpmUCtDS1BESGtmbk1mcjFrUndD?=
 =?utf-8?B?aDdNeDNtbnFBZkpOT3cydUpDUmxnSVk5YVRkTW5OcXA2djh4UDRlTERxOUpn?=
 =?utf-8?B?bGZGWmFpUFFlVk1xWmxSbEozTlYwVkVWVmY0akw1VlNJSEZ5c3dmQlJMa3Ev?=
 =?utf-8?B?YzJSdDNQWjRITGFNSk5HYnNvdlRSZlVwQi84VkkwOHJBckpYZENLcnQvR1B3?=
 =?utf-8?B?M3ZNSDRoTDA2dWppMWcwaVJGNDJwVC9oK1dyWG1GUFBTQ0pSc3V2MnpsOUhl?=
 =?utf-8?B?ZExqazFXUHRWZ2ppKzZ5RzVzRW91T2RuNVluUklsSFdscjc0RlBkellDeE1p?=
 =?utf-8?B?RXJSQ0J0SEhlRU1mRjNOVU4xWWp6Q285TlM0ZmFuRG1ZQW1FWmFOUWxDcWMw?=
 =?utf-8?B?dGVrTkxMdkRXL1FsZlJoNnRpZUdRdnMrL042OUJUdDVPQjM5cVZNcXFsZWxx?=
 =?utf-8?B?Z1kwVmlxSDAzdFBiVXFDRUxWRlRwcjdQUDJKUnZCRW15ZExFa3dTZjdPUlNk?=
 =?utf-8?B?cnRnSFpTUVF6Q0FZR0dwOXVhc3RKU1p0NXhNWUR3WXZYNUtsb0o2SEZmWUtF?=
 =?utf-8?B?VUd3SktUMGZuK2F1Tm53eUJKd3VhLzhSZ09lRE9DR3N4dzBSSEp6YnJjMlk0?=
 =?utf-8?B?QkEzUXBEWHZQZkNtT2dhL3hUZkpnS0hPRDNsN0pMUjNIbTB4eTNaWFhPNjRG?=
 =?utf-8?B?U0tJUEJiU20vd0E1cWJsWkN0NE1uYUpOOTFpakhvZ0s4LzZwWGVSSXd4TGNE?=
 =?utf-8?B?b1h4RmFjVmV0VXN3Z0owbThWVlFWTmc2VDRlekd2cmptZHVHeVFxd0c5MjYw?=
 =?utf-8?B?Ym1vaGVMM3FzUEpraUN0WUNTYTFzUFg3VmhiTGhRbnJKTld3anNQT3JEL0d4?=
 =?utf-8?B?a0thTVp0UTdQZE5wdlU0Y1ZndEFua1ZodTltQjFoYjVyU0FjdXFHK0N5M3Q4?=
 =?utf-8?B?RTRyR1hTcUFFRjYrYlRxQm5SOXBmV0lXb2I1bCtUVjQ2S0hFV0twaWhyQ2cw?=
 =?utf-8?B?T0wwVmdYd2lUUkg2TVJ0T25ueGJSWFFHcVZrbjRGWnJVMmxuSTlwYW8yeHEr?=
 =?utf-8?B?MmFiMjRQTXNjUTVWbVA2QnNTWWRVMkpmOFFNbHlrWERtczdtUm1WSWdBVy9T?=
 =?utf-8?B?bHUvY3FQOUh1dTFmOW5ORThRR0pUMThyb0R2aS9qY1d1dUhYRmFPMFN0emlS?=
 =?utf-8?B?UzlUZG1naDVaU3A5eXdDb0V2LzB6aTIwalJSdm9SV3l5dzY2SkRuRGx5eFZZ?=
 =?utf-8?B?dHB1RmlnVE1VS1Joa2laWkRHQmVkM3ljdzB4N2FQSTZpTkpoSm9kcG0xaUs2?=
 =?utf-8?B?TjVLVDZ4MkZiUU1HdWIrSjdvRlBqWmtVdEN1S3JIaENyTzhiaVNGNDRRbVlw?=
 =?utf-8?B?S29lZFpHMzUyYTZGclUwYSs5L1lwaFI3SmxjWVVjYlRyWnlUbElMRFFUaGlm?=
 =?utf-8?Q?WV+MzHOZxYE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVoTnZvZEQxVENLQnR0Tjd3T2tCSXUxUWhCSG5YdTczdDROdFBNcUxxUFBh?=
 =?utf-8?B?N1BabkpxNEpGRVlDR1NFdlk5dVhnMnRDZkxVcjMrOXlNRlllUkxqTysyUmtE?=
 =?utf-8?B?K1Fpd0tQa0JvYUo5c3lvWlgvZTA5dm81Mk1mN3RGcnRzcDBSaTJZWDNTQUNV?=
 =?utf-8?B?TDdvdkFWUXA5cFVzZDR2QldndmRHLzRod2NnRDU5TmplV2RvQkNwZGpnWUpZ?=
 =?utf-8?B?YXBFdkV2RkJlTlMzN2Z1N2FZVWNrZW1vRzIzMGsrS0k3bmpnVWFqT1lnWE13?=
 =?utf-8?B?eXlPT3VFK1F1dVhPQ3liUjJoOE81cTdIT0dTK0ppSStZQms3OHhselZqRy9Q?=
 =?utf-8?B?NmNQWEJtUnFiRzUrRzdBWFYyQnpBTit6dFdUYXVJSDY2RUNudFNmaHAxRFpC?=
 =?utf-8?B?Z1NFanFzYVJIQ3VWcTA5WVFjU1FpcTZMUk55WSsrYUo2c2N4TjNXcjIwUjRW?=
 =?utf-8?B?V1lUZTFXWGpWU0ZqTVlpRlJxV3dlc3RpL25IUjRqMkdIdVJzRmJPelJJaERF?=
 =?utf-8?B?Z21hcS8vaTllOTNvTWFmZG9qb1RUdFhwRzdNNjVac2ZqNjhmOG1EVVdWcVlM?=
 =?utf-8?B?K3pNK1pJUzJ3a3lDL0FRQmNsblJLQzU3WW9JTHZ4WFBGZjUyTDRwUGFsZTJ0?=
 =?utf-8?B?R0VmVFczNmNKY0lxRHBEdXgwMkhyaXFKTVJkQXF3YXo3TWp6THVsSlNnM1po?=
 =?utf-8?B?L21Vc0VBc010SlVUMVdxbWlYOVVxWkFnY3UwS1JUVjA4OCt0RTFNWmMrVnJr?=
 =?utf-8?B?VVJZRTVNUnMxNWxHQTNaczdKeHcvMUE3bmNvU2ZwbkFPSitENUVlSmZxamRr?=
 =?utf-8?B?bG9uUEdLYWdNeno0VFpMNkNjZWR5c29zc1l5TDJWK1doaGdrSUNFdFB1dUw4?=
 =?utf-8?B?dWg0dUNEelFXT0FIUlBwNTRNNmc2bnFBUFBsTTRwS1l6MmFHTHNiUTZUUVhv?=
 =?utf-8?B?VkEzTk5HZnQ4VGNhbG15UE1JUnJPcGdKTllLMDRKallmTFlFMytOVk15OHVH?=
 =?utf-8?B?NkFvWFJTQkQvb1hQamVVUTQwbmMxMFZZclp0ZVo3eU9CSE5FWnkxc0Vqczl1?=
 =?utf-8?B?UVhEWjZkMEc5K3o0MTNBcEs0WDBuZEZ5Ty9CYjJTb2JCOGR1S255WjVzT1Vq?=
 =?utf-8?B?MUtXdzdxQjNDQURtOWJEVW5KYVkzNldPZmNHK0lPd01PdGZHcE1heTJpaWM2?=
 =?utf-8?B?UVpybkhyV1ZZa0tILzNCZFF2by8wdzE3Z3A4Y2lnUGFOZmlCMm1JWkQrT1hm?=
 =?utf-8?B?cXV1WUhBalc4c3N1ODUzek0yY1JCUlNzNnBqSm1jcVVPYzQ4dEpXaS9jeGVB?=
 =?utf-8?B?ODFWOHRkSVJNZUdhdWdDK3BselhqQ25CVTRVNFRmUllJQ1RiM01UVUlqeW5P?=
 =?utf-8?B?eTl6NHcwam1ZY3BWLzQveElPYXNqVDY2SlBTLzAwV1lYUEFmYTlWcGlYVnQ4?=
 =?utf-8?B?NTA1MmRLV0NRdXBNeFZjY0dmbXBZcllabWFEZTJjdEoyYVhXVnZnUUdQUXkz?=
 =?utf-8?B?a3FNNUJPbnZxWTBZeHAxYWtvcTZIWWV0VTl3YzBqRUVjZ2VCaUtaZit3Wmxj?=
 =?utf-8?B?VGgva21zY0pnWnFXcW1LUTNJaWF3VWcyZzdhOFlid0ZjVVJCUTBHSmZwT0RL?=
 =?utf-8?B?VW1WdlcrSzcxZWVXbHFaaDc1WVpubnFiUHRUUkhwejhvYUEreUtrUXRiU3Ni?=
 =?utf-8?B?N1JTL0JLWEVrKzZ2dzh5YjNHYk42aHByWWMzdWZudTRhSThWeThtMlgyWHg5?=
 =?utf-8?B?ZEhOK0dlZWZRb0R0VFFsTzR2aXludHBGK1E3K05BVmd0d1N4MjRaQWd0WFE1?=
 =?utf-8?B?TkpCRXdmcWdha2xzQ0RwaVplcCtKYlhOOGdBWE5jS0pwOStUeGJxNmZqUEVq?=
 =?utf-8?B?UjFpT0QxVjVCQVQ5SUU3YjFRQnAzS2ZaTTBBcGlkZFJ1YS9RNlRpcFlhek95?=
 =?utf-8?B?TEEyK1JPNVhlYU5GZC8wVHE4VEZ3dzNuSzEvRmppNnhCL2hZbTg1c0o5ZzUw?=
 =?utf-8?B?czViNDFDZ3F4dlY3aFRYSlQ2WlE0dlJJOWRPdzF6Uk1NUGRDREQ3dzVTMHJZ?=
 =?utf-8?B?QTdMVkNhL3IvWHVnUTVaYitkUlMwdGVJZFBCa1BTTUhqbEcxRlE4ZVVoYmJV?=
 =?utf-8?B?RGdYWGFic2FjWkdXMDVMSFJ3VS8rM0tRMkNaaHRIVWpyTWlOVlJ4N0lzSjhm?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bff5cb8d-4050-42b6-97df-08dd96c2a95b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:48:16.7266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8ZJoXPwr9p2DIdqKppBZByLF/UD0QOcVeDYDf4FVilSfi/8Z2JEahJIw/jSxFUeKB0cYfHEo6NdhbRwOxI45XKzf14La85KhmgKSdB16qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153
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

Hi Moteen,

On 5/19/25 11:33 AM, Moteen Shah wrote:
> Hey Simon and Quentin,
> 
> Should I send one RFC for this for folks not using binman?
> 

If you already have code for it, sure. Otherwise, I guess whoever 
encounter a similar issues as yours for their boards can fix that 
themselves if you don't feel like working on that (as I assume your 
boards all are using binman already?).

Cheers,
Quentin
