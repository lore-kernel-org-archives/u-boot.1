Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789AC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319328141E;
	Tue,  4 Mar 2025 13:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V+T5BMsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2263D81429; Tue,  4 Mar 2025 13:37:26 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A0781335
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 13:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4U1dBtWRzTEDmfjNaNJ9bYw9SMyM6a6+xVX0+0G4KDVFcpucwwuZiQtO0jpB8Nqqt4c+Xyn4c18R+iQfnzV4KsU4SQl0ALBwlPZX/NPpgVWO3tE0EbD1U58qvw6BTz5U/5xhmfZcvw2aYt1+albdNZjpM04UfWyKYL71h9xTg0x9Yd+ESeLxFnfMFaexz3MR/PDGULGrIa09ktxtqxtg5ytPg9lgj+Ud1WqrvHrehmo+sSCYxs1uk4Sfazq+18lN4MoxNFLf3yxEiIVaQTTVkb9w/+Oi8TuqaeTnKaI/dtNgXOcVR7W0VES+SUp1msfU6vwou8vEEfC7DcnXH41PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBJbsU7zuOZbI/uLO0EkjcXurnkDu3nwsSsZHYsEAQE=;
 b=F9D3arK1Px05tQl7tOw+P65yYKiCy3mg+vjg7YrVM5gZ4qILqZEm+ORr0pkhSUKT7QIA6vS31sEfJkVpiU5UlpbWvSWTI2TD4ZVrowffCoknhq9y6QEsaTplpDSW9YnOHko1z8lKnVZaK5MyCUAeO/rBJKB3cJFKg3DhYsnnviBDdQdjoZp1J45m51qcqRfQv+PatgVkJCGttCoIGCo/oexNzZNJ5uSWLGeBRl2+bWpTF8DD7aRZayaFrKsx/PQMnTLehm9osYRp8SDSEtFKvNaCn2B4gjJUR9GmfaihR+bv7K+SYW3sKplXx0Of5bxjHnpIxi7yh2Ln+UoKT/kUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBJbsU7zuOZbI/uLO0EkjcXurnkDu3nwsSsZHYsEAQE=;
 b=V+T5BMsDrN/k4BzuTvmPM2pG+7Dr4pi+Rlc9td3xR7EYSfvfDYx+LCT4p4wKFDZdKfjZRzqAESXHvebzBean5KdQCWCXQMLzGdYhAScY8rH6QKoopQBYI1oPU7IRQMzbQKCTJhBm/ADa+altIN5yE6846vyGscMMg4DafD5KfDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 12:37:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:37:22 +0000
Message-ID: <edaaac09-22e5-4d6b-90e0-16f672206255@cherry.de>
Date: Tue, 4 Mar 2025 13:37:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: ecdsa: fix prevent memory leak in
 ecdsa_add_verify_data
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Anton Moryakov <ant.v.moryakov@gmail.com>
References: <20250206214758.353228-1-ant.v.moryakov@gmail.com>
 <174106331644.1753567.4740910842414947988.b4-ty@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <174106331644.1753567.4740910842414947988.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6b7886-72a2-40e2-1765-08dd5b194f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFd4Y1laQWZINzhiL0RDNHFCR21qY2llaGFiaC9pMmQybDBLZ0k2TVFaM0Jk?=
 =?utf-8?B?aHZORGV5OU1SdWN5WGhuL0VjdXVVMkxZcFRWOSt5TDZnckc0TXNZWVh6VHNa?=
 =?utf-8?B?TXlvOWJsWEtmcjRLWnE1WFI3VlEzaHVBTE9DUzBjQWYwTVRnSFhHUFBad2JG?=
 =?utf-8?B?aFZ6RjhFU283V1RiLy8vbU1ZZUtSOHpubEVjMy9ILzdPZU5ETGo5c2xoazk0?=
 =?utf-8?B?QXQwaDl2YUZrN25BRGJZM29jUTh1bVo2QU5mbXR2Ymg1aGtNQzZDN1luaW44?=
 =?utf-8?B?dCtvb1hMdWdtbHVIdXBuQzlBMHRMZHpZaTVQN3hTT2VIeUUyai9NSXhmN0Ja?=
 =?utf-8?B?SDZqTHlBR2hLTnFrTytWQmlJRTJLTE5pT2xzclBTclV2QjBEM0FmOGhEaHF6?=
 =?utf-8?B?UjVKQXZHUWl2NVJhSUxsMjdKR2kwdDNhV0hiNHdvVFlzbTRNRzN3aE1Jc1E1?=
 =?utf-8?B?Ym9lYmQ2dkJHdFJXM0luV3kwcm4vNVZTYzM0a0hvVU9FeG5tM3A1eGlzWUxz?=
 =?utf-8?B?d002a3Y5WjlyV0t3aFB5YlIrenlsbVA5ZGt6SWpzcUYxakk0VXNKd1FHcXJP?=
 =?utf-8?B?UThxYld5NkhwQm5HRnJBQ2JIeWpjVjBmdVZ1MG1yc1l2UzJEMkpqOXhMcldx?=
 =?utf-8?B?cFd4cFFpUm5rUUdhM0dybnlJQVZPcWYvRFp5ZENsM201RlRlZWtNWjlLKzFM?=
 =?utf-8?B?ejQyZzczdTJnQTdCc281d25tc2xNWUZTN1REU2U3SDY5MWhmM1ZFcW80K3pp?=
 =?utf-8?B?K3dnVkp0ejZDNWtRMFdSVEpPL3VZbHU4Mys4WmY5aWNoK1hOSmJqbXorcTMw?=
 =?utf-8?B?V29lN0pOOGhSdHVrcXhlZEM5VisyMWVEczFKR2lCT3pKRHRQREFiMWUwRUJB?=
 =?utf-8?B?bUh1TzBKMjVmYXM2MjRISzQ2TzkxRDJlT0ZvbE9mZzFrM3AxME02dTU4SEg4?=
 =?utf-8?B?Yzd0SzdJdXRnLzl2N3U3WFE1a3p4VDVGUUNvWlNrUEpBVG9mM25sOU9STXJv?=
 =?utf-8?B?bUZLRGErQThZV3FzaEx0bWVCRFRLTXVVeVdsYkVYZjlSbkt4YTlFa3ovRVRk?=
 =?utf-8?B?allLMUZnTnpIZXZzN2RZcjM5b2pOMWFGRVZVUERBUFd4a0dOM0hqRjE3djNJ?=
 =?utf-8?B?eXdHZ3hJa0Q0bGlDUDVXVHdpUTJGc1kvNFY2RThmWmxDVFZZYThJMGVLY29L?=
 =?utf-8?B?QW5nSEFRaTVIUUNQMXhSWTQ0MDBMVHJoUFN4M0pIWHgyQlBzL2VyQTRmVHBN?=
 =?utf-8?B?MHF3R0pKYUd4dE5hek16U0E0OXVlTE1YbUVoWDNWNlZyVHEyeks5RndmNHdE?=
 =?utf-8?B?WTcyUTBwVTMxQ3JHd1MyQnJmaTU1WWFhZGZ0dmdBZnVaRVR5ZnN6T0MxV01t?=
 =?utf-8?B?b05ZSVphTXVLbENucG9GM0NhZGtIOFBoOWMvMUhjU25hQ0puNndLK254MzZm?=
 =?utf-8?B?VVUvV1JIM0gvakxJMExkcW5MQ2lQSkV5U1FVUkxQUHJRRktKN092N2NIN2Zt?=
 =?utf-8?B?aVhwMTczYnNoaDkzVmdvWHBZYjVkNWlLMUpoMEdLWDEvTVo1SzRQaS9uR1Vu?=
 =?utf-8?B?b2J4Mnh2YytKd1VCdksrSktZZGZmQTNmMFBHMUNJQS9talplUzdmSjM4Y0Ro?=
 =?utf-8?B?NWxMMysyOXAxb0pIZGFveENNMDd5VG9LL1l6Nm9IdWZuMnFZQUxOdGRLbnVa?=
 =?utf-8?B?Ty9mdlF6RU5RdXp5RlVWMzNEQVNBRWVJc0psODVyWk9udlNlbzBpb2x2NU81?=
 =?utf-8?B?a09rUTdFYnZuVzJ0SUZPWE9LdzlYWlNpbysvQXAyTVVhUWdCTzRxQXRmVk8w?=
 =?utf-8?B?Y2NlLzJPbG1KV2RzcjYxS29FRmgxeHVjak16L1Btbis0Nnp5QUxvME84VG1S?=
 =?utf-8?Q?KEcNchOCPvyyn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L09SaTQ4MFBuYU02emRrczJ5MnBDVStKSGlRbG1LMEhzUUJLY1RuQ2FQMWNE?=
 =?utf-8?B?YmdGZDVtcWg3eURCNk9YcldWUk5jaG1QYmlUVXpveG9nVTVDVGhBaWlwUkEx?=
 =?utf-8?B?NjJQZDBHSU1oU2NFaS95dWNHVW9PTjhnOEtmdTlneWMxK2JodFp1T05uQi8y?=
 =?utf-8?B?V1czbzl1dkYxbVUxTmhOT2VXd3h6Tnd1VkJtOHFBcHV3dFFUZkZvVmRzMDlr?=
 =?utf-8?B?NGprd3hYM2xTMUQySGdQNEpTU3djcnZ0UVNhcVpZbHJNdDIvc29DS1MrRmxR?=
 =?utf-8?B?dGlDQnRwSUNBbXZVdGtuSVVBeFVYc1lZOUk4Y2k1TVMrUXYzTytBUTVwQjRC?=
 =?utf-8?B?eExMVDhqVmVxQTBNZzdlUGRyeWRHTWkwWUdQNFZ2bW5YZ1lNT3ZhanVHZTc4?=
 =?utf-8?B?YTVXeU1YbG9UTlFuUzFZRlg3cThNWkYwcHJReG1hV0FyRjM5ek40VWs5a0Ux?=
 =?utf-8?B?Zk1zRzNFZU1tU1VEWTk1TDd6dVNMQUJHWXlHa29jZlBDV003MkJ0b2I4Znhl?=
 =?utf-8?B?dFhsWWJ5OWVkSEI4b0s3dkxRSDAyZWJiaWVQSnI1cmpISldVejQ4YVp4MThK?=
 =?utf-8?B?b3JwUlc3cStPMEtRaXJyOTVhMEpoYUN0WGZhUHBwMkcwaVFiY0JBTGtwdVdG?=
 =?utf-8?B?YUxQK2lXbmZyNitYUkM3ZjBjUmgrY1RvZE5SQUVKQmZ2OFJGV2ltZkxtQ1RB?=
 =?utf-8?B?bURLUTY2Z2FMbFNKVWdBMStGRWptWEpDU2dWQ1NueEJVSFhsNnJBU0tDRnlT?=
 =?utf-8?B?MVhMNGdLWHVjbEo1aXhhTUJpaTJOTkJwZHUvUnkzRXBNTzRPVUZTNlYvczBj?=
 =?utf-8?B?dk9PalBHZ0x5Z1krQU9nT2Qra0t1MEhGVGVFcVRxVWlOZzVNTWpiVzJnazEv?=
 =?utf-8?B?cHJqR3F2RU1naEdIUHpCMWJxZ2dMUGxUakpqUGQzYzArZjhKV01kbmdmL3Fk?=
 =?utf-8?B?R2ZBNWFhaW9wQUdzUkFwL09nZVMzOVVHLzVHOHJoUEh6UlczNnlud3I1NWdO?=
 =?utf-8?B?cHJsNENiWVR5bzM0TksweXV1eUJZQXhWdjFHb1NyaVlMOXRvbk0yT2M3OU9X?=
 =?utf-8?B?YTh6TTR2SUJlSzEwYTBlazd0TG1zNGtRZ3QvUHVMN2pTRzBTMEcraTJ5NmNO?=
 =?utf-8?B?ZFJuaVNMQXRCcHdjcGdrQm0zT2gxdFhwbThiZW5FRCtZUS9oRGxrZ0ROS0Jw?=
 =?utf-8?B?dGlvcW4zWnVTOHVHNVcrWHdrWWdSK3ZSTExJK1B2MXIxd3NsaVVBNTJqVnQ1?=
 =?utf-8?B?Nzl5eEFBaXpicUlKZUZPUXZMNnd3VlRHQ0Q0RzE1NVplSzdocVg4NWk5b25l?=
 =?utf-8?B?LzhTKzM2VmZ4NnhESDlrc3MxdXd6Y0lBQzRaZmJqRjZCU3NEaHgxTkRiWTVa?=
 =?utf-8?B?S0pydG5iQWN0OWFONjNiUTBZL1gwN0IvQ21EcVg3eHZObmRNM2VGV0ZKWXo0?=
 =?utf-8?B?MTRDa2xOSHZYVG1NRnA4QzBQUDNZU04yRTduVVBRVjBHUUo0emRHa0NOU09p?=
 =?utf-8?B?WDdTSE4zSlE2ZjNydlh0MFhlem9yZ0U3aC9pQkRBcTdjelhlUEYzcGZCRkFV?=
 =?utf-8?B?dTUweTY5R0R4QjVSZnBISk8wYSt6c3I5MEZEWWN4V0t1M2VHUkZuMHY5NEtP?=
 =?utf-8?B?QVV3MFlJQVdudWJuMGdKZU5lZ3lVQkMrdlVMaEJvaGNwUHc4RllOR3NQNmhW?=
 =?utf-8?B?VTFLYy9rQjZjY054eExEdkQ1UHR0MXVyWjIxU2RPREQrZ0M5SlpxZFFlbmJT?=
 =?utf-8?B?RUp2bHhGOEhXRXlVeThRT1hWY0QvV0VJSnR1cWFQS3N3WEpXVzhnNDhid3Zq?=
 =?utf-8?B?VVJIdWowc3pMZzNXSWpEaHhPUWF1OFY1OW4yeWJ3YXdycWpyNkFoSlpjWExn?=
 =?utf-8?B?anEyK2dsZ3V5MUxVT2JrS2RhbHlBUkQ5NGdub0ZYT2V3dTdlQWhrYnZRNDc2?=
 =?utf-8?B?SWpOYUVQUGNBOXM1eUlkNTV4K0p5czJOalFKQmR2NDhlOU8ycUROVUEyRXlT?=
 =?utf-8?B?ejN2eDllQmdPWU1Ycm03T1E3VU5VWGtRaE9CeExjNkR0TFBEcW92T0lrUEJF?=
 =?utf-8?B?NnVYTjRnUjRHbDBMNGVVNkZ1dG5MMGc0dDdFNVhiN0FoMTYzU0hnOFJaZkR1?=
 =?utf-8?B?bGMrRlIrTm92cENNYVBobnZ0TXMraGl2SEM1d1FKRktHVURaang1UE5OVTUr?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6b7886-72a2-40e2-1765-08dd5b194f75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 12:37:22.3513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r9Y+XP4W7GC3MV2d37as1WR5gmu8pZmHw50LvFYa5PGEmoY2MMteLA57YRrxyKaDk4BTX0URmavsTKz3Rlr8Ck1Labbx6Q09b95WP/QOTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
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

Hi Tom,

On 3/4/25 5:41 AM, Tom Rini wrote:
> On Fri, 07 Feb 2025 00:47:59 +0300, Anton Moryakov wrote:
> 
>> - Ensure `free_ctx` is called in both error and success paths.
>> - Fix memory leak in `ctx.signature` when `do_add` fails."
>>
>> Triggers found by static analyzer Svace.
>>
>>
> 
> Applied to u-boot/next, thanks!
> 

I believe this commit is not doing anything at all, especially not what 
it says it is doing.

I believe this is a false positive from the static analyzer?

Cheers,
Quentin
