Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573FC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AEFC832AD;
	Mon, 11 Aug 2025 14:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="js8Dj5zA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6C1832BC; Mon, 11 Aug 2025 14:32:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F6F831EA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izPEnL0I4PHGAYSgowdrYVOzmJSu9ia+3zffy5tfcD2LZ1FPUPcLog468bYvq1x0dEE4q2Sq9mfZoz7COjyqqNK0vRlBG7GmBfgvwIGFX3XvBlvD3JGqQO/1Hnu/gMktYiXJl2zQEMB9GMBKI058RgRZmdMIZvtUnEDEWvk4Fcoimw4igNZercZUGMdINzQfmWRCyGDzBokqTVrwLe8UFrtoS2JQqPAbMg0ZdQq8WWoOGL0f7L3qjgfan6HJOTVj6YNXnUnqhqmZnW3nJ3fKPDMf4aOtj1GYn/I6ZGLCLrZEP4VphOSr394PHJkEL01HytOxVbhDWtiymhIu0aBL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX0lYBHHhePHw/cnuRpMtgjfVLZ3CeybCLSydMX71Kw=;
 b=t5VgMy9F3fyWqxZ41oNljTN5Cn8DLAGMKGdUTwaRD+qKoCFsxt2UHVM3/PJjhmupSNyDAuTnhuu+cP/q+USI9Lzb1mNfdOWyaLwBSU4qj7k189F00DKrvGAEla2XFXpuhQr+BO6EDxK/KMLen3GsKvFIqvaPZEGmFMw3ogIivMcPyPvSgF6q8d1QuolfFVTsRU+ag5ncPKVDJmVyA34pOs0nJQjRpmiIrAMaDBOqjRmwS1lm4L9f7DeFRur9Ba8TGV5FR/u4jSI0j5SvA+QCOqcLMsMR+XMF3OJN7Wqmv2RMLotDUlk/zslZhbHU+zaEZY5WWmpJBDVh8pr/AuzJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX0lYBHHhePHw/cnuRpMtgjfVLZ3CeybCLSydMX71Kw=;
 b=js8Dj5zAQeQHn6MewvMd70MJAaUgS1yYQD612+WrRazNyRfbT0WF6Rn7XiDlcLYE9fvEvmWUsskX2eSDYhh6+lgCdnqqxMWbrGN6wjoVN7wzlAcEyQUoBaUQA4yDKrQfafclaDiuQemtaa+SaLvCG5QsZieZ+imwChjbvXwNEEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7853.eurprd04.prod.outlook.com (2603:10a6:102:c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.9; Mon, 11 Aug
 2025 12:32:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 12:32:55 +0000
Message-ID: <607c7cf6-6e16-4135-9b51-b1822b3e3ac3@cherry.de>
Date: Mon, 11 Aug 2025 14:32:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB OTG: make dwc2 otg driver dependent on Exynos platform
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
References: <20250804094353.28658-1-m95d+git@psihoexpert.ro>
 <6541cce1-f779-46fe-b3c8-e76303e59eab@kwiboo.se> <aJHurWqRi92fyO+C@GRAPHRT>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aJHurWqRi92fyO+C@GRAPHRT>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e77c64-5028-4cd4-1d94-08ddd8d3322a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzVaemI3RVVVdzdDVjVvNW9RK2V6K3pMc09DQjJZc1g3d1lUS2JZVTF5eXFO?=
 =?utf-8?B?UVMrM2t3QWNhOWthYVJwYWx0bmo0NUcvWWpyczJxZ2FUNEJWVDloVnhxMW9l?=
 =?utf-8?B?UlJLeDdOVFpoNm8rSHE0UEh1cSttbkNIN1BlSXpnaXA0bnAyRXJLcm1HSnBZ?=
 =?utf-8?B?Y0JFOHpCTUZvUzdKY28zazBORlRMZEtMb0h4YW9jMklEUENxMGFzWnJZcHpz?=
 =?utf-8?B?anFvL2hTOThYYkNHcUxOZUZTZlZmcU91WUJIeTRvMWR3Sk52NjdzT1F4Yk80?=
 =?utf-8?B?RHBBWkw2Vmd2RURYUlE3R3A4OGdTc283cXF1ZnF4d0w5RUVSSTNSRjJVTkhz?=
 =?utf-8?B?a1hxdUVvZVl0SS92V3VzL0hwbVBIY3UyOVpxOXNwOUdkdGorVnM4b1E3OThJ?=
 =?utf-8?B?cXN1VHNJRURWOE1CUWg5ZUhlNFdCQVpWMFNnY1Y3K1JRZkVDVUxGSXpFdTJu?=
 =?utf-8?B?Z3lQTHluTXY2ZlFYWWwyMERiOHNoVlZWZmJWNGJsU0JoWDU5RG9JQ24zOE5D?=
 =?utf-8?B?Uy80eTRmYVY3ZXAwMDdsZUNUVWxIbSt5L2dnWlFWRm12ZFF2VVJNY2tGWTE5?=
 =?utf-8?B?bVh4c0ZJVHJhNVlXODVRbFBteHBrK0Uza25VNXhHbng1NEIzYStBOEhsdDFK?=
 =?utf-8?B?ckhxUkpGRUtGTWZwZlFYTHVjR3haVUlWMVZOTGkxcDJaSE9ZQVYvd0lyL3BX?=
 =?utf-8?B?ODMxcDhvZVQ0NW15TktIWE83QzZaZ3RLa3E3a0Q0SzQwNnNNMDc5YUFUTHQw?=
 =?utf-8?B?K204VlRVUFdnNmcxQ0VtTXVKQ3gwSmJQOEpROEFxSk5pRVBVSDJKdFJ1VEkx?=
 =?utf-8?B?aCtBbVJodWNyNC9MZXNNSjZGTDZTTmZ4RFNzSGJzVHM5ZmRXeUxYb3dwLzFu?=
 =?utf-8?B?QmtKSlJJS2V6NFlKbk90R2xVS3F3OHFpYXBMNTBUaDQ1MVloWU5YNG8xV2d4?=
 =?utf-8?B?dWNjWnI1aGtNaHJ0c2RHMW9NLy96cUJkd1hHRnFtM3Rqc2pLTkZVend2d2lS?=
 =?utf-8?B?N2pVcGluVHZpaUlOZ3kraU95U2hkVjNzT1MrN1ZnY0hINVVnb09TTXdBVFlr?=
 =?utf-8?B?OU9VdEMzUXVBRnJkekpSdHhXRUV3NmlnK1BYZ2VXekV3WmxXdFY5akRjTkxj?=
 =?utf-8?B?SGhZS2FTclpDT2I4Zm5hd04wUm4vaGlFRlZyK09sVVJ4VWZFY0xTK1FJSmVS?=
 =?utf-8?B?VXpaZEh2WDVVSldDMzRZYWQ0ZjdVN2FlS1ZieEZDQmZBd1RWK0kvZy84UFI4?=
 =?utf-8?B?WU9ZdWJXRUZZMWl1WEJsQjE5Z3o3c2NWMFA3ajd6RTdPL0cvVTRlMlZPSGti?=
 =?utf-8?B?TlU0R3BWR2JYMjVycWdzZzY2M0VYbWdLUTg5N0FLS2ZIQ2lrazJyNXE2MXJm?=
 =?utf-8?B?dXM1UE5DOWx1NWRBbitzUXRNZGh0TElxVlNoWFRhYlhaeXR4bVFad29lQjFD?=
 =?utf-8?B?KzIyK2FEaDlBNENnTGlTWFVKSnNIV1VOSWhWRUJuUmx5Ym83RmhlektSL2Jr?=
 =?utf-8?B?UEVXZ091LzZxNE5pa2JJbzl0c253N0VqcU1ack85a1RnN1B4RExXUm5qeU1z?=
 =?utf-8?B?Q2plc2hFV3R2aGtpTlUySFA1V1JXaUpMUDV4N080Ukg3TEtSdG5GQjdmK2d2?=
 =?utf-8?B?ampSaE1WdUNIV0xoYUpwV09FQ2JVd3VYcDlDZmM1MGtGNzh1NGJuOSs1TnQx?=
 =?utf-8?B?VHZSZGdwZTlFd2llN25wc21na3RzR2JQa2ttUVlKNEx2UzFPMHM3dXd2Y2pr?=
 =?utf-8?B?RDNha1JUTGZKdlh6NnhYTTV0TTd3b3RNWnBmdTVkTUk5OFI0dFovQ1k1bTZ2?=
 =?utf-8?Q?QbrNZfCuZKuf7yoKIOkd9DAY+QiiXIG1Le5sQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlNUkR6UnhESUZhdlcvSm5ldTBmWHVVOVhIODY3SEMwMjVxR0lodHYxeDI3?=
 =?utf-8?B?TWEvcTl4MVUwcHJsOWIrWHYrY3dNZ2JDZ0dHRVdQVG5CdFA5ci82Tk9zTER4?=
 =?utf-8?B?Wjh6SVV0TkR6Sjhnb2tYamRoSUQ4NE15ZDhGcUJ0Y3JlRnRpa3NhRHBNRFo2?=
 =?utf-8?B?TUhMQ2hubC9mUzBUam9Yc09iUitHYjVBbkphUThld3BvSVFsRGlZSDRqOVVJ?=
 =?utf-8?B?WGRnRXlNeEdXRjdhbVVzRXpMZGtWdGtsSW05ZkNlbithYzlyWlJaTjVJd2V2?=
 =?utf-8?B?UUE0amM5YmhVT0ZBbTRsdUNiS0o5bEY4RVN0R1c4SWoxKytaNzBDbkVMa3h1?=
 =?utf-8?B?bkVqK1hSQlorVkFFMEVvWUJvWUc0RlBMYXRvOHdlSCtQRlVxaDF5dmhWTkty?=
 =?utf-8?B?alJzRHRrN1dKQitRUmN3U2YyYUltb3ZhTVg0Y05za1Aza3Z4M1pqNWhRRkdP?=
 =?utf-8?B?a0NQd3dnck44VXlqZnJIb3pIYTlyTFJDNDBkUE8rUUpwN0lCR01ySGpwcitK?=
 =?utf-8?B?eCtqSkFtN1FIQndVTjVqK3lzQnNrV3BHeUFOSlRWdEhSNGduVzl2SUZEZjl2?=
 =?utf-8?B?RXdXb3RsdUZEd1BmaU9nK1UvNU9GT0NSbjdUdHVJUDdxLzk4d3lsWjZzd2RH?=
 =?utf-8?B?Y2E1ZzNDTW1FVXBFMGFOS0hkUlF0Q3hsOGx3THUvS1pFNXdDTXFVVm5DaVVx?=
 =?utf-8?B?SVBQT25Dc28rc3JiNmtmRFBUNFV3WHdNbzg4a2ZtTHVlYW9QYS9lQ3ZmQnEy?=
 =?utf-8?B?T0wxSHVJM3puRUVIVlVoMVFYRjNYNXQzRWgzOFM1NGR2ZlBPRS9rdHpuRW4r?=
 =?utf-8?B?VU9wVUtpc2ZkQzZOWlpiT01ITi9XYjFnWjNWRC8rVU9ab0FuNWZYcnVZZ3BP?=
 =?utf-8?B?UURjNXFCNjlyMnhVT1dTeld0ZTZoVUJSdnBVcWJsSE9iRWJDR2hkQy9XVkcy?=
 =?utf-8?B?Vjh3WU10QjFXNkNaa2hOK0JRMnFlTUE0d29JbnQyQmtCQ3AwQW52eFd3VmFq?=
 =?utf-8?B?OFAyL3B3ekxRcW5jcGV0bHpvd1BjRVlNMXNMckRhMXM4M2lyQ3JwbjlLczBp?=
 =?utf-8?B?TUhENjN5d2dDRnBQZU11ak9HMkhueEwwUnliSnFhOGhzWUxYTUdNcnVyNnZ1?=
 =?utf-8?B?eVRtZTVLWDRtdFZWUCt6S0hRWVBTR2ZhSjF3QSsybGFIbjFCNDJ3b0Yybnh4?=
 =?utf-8?B?dm5INUdnTHU3SksvODRUZmdrQk5NTG1KVFh5UEkxVU1OWFJRTDJjTGpBb0JI?=
 =?utf-8?B?N0hwMnhPK3RzM3g4ZHFhMURHMFhKdVZ3S0tWVjM4Z05ncXREUjQrRmFIVGQ2?=
 =?utf-8?B?eHNZTWFRbXl5Sys0bHl4dXpNNGx1dDIrTTl5c3EwSkhlbWVtN1hHRUJuc2F6?=
 =?utf-8?B?OHAvd3UwY3R3UkVUejFoclczUmlvOVZaUFJMcnBvMmlEUHhIWnNVWjhSWVNU?=
 =?utf-8?B?MVpqMVk5Z3lwckJDOXBYWWE4V3BOcWlSeTFpb2k1TFNnNGttVFNuZDVvbzJu?=
 =?utf-8?B?Qk8yaHpraEltS2N2R0xKTGx4cGNsdnNpWGwreTFqanByQm5lc1ZGL0dUNTBo?=
 =?utf-8?B?NnViZUcvMjk4cGoyMGRIL0VVaVR5bmV2RmZsWWFHR0xlMWdCdnlWcVpNdzh6?=
 =?utf-8?B?L1JXbjNVYVVzNEZtalBTaHBEd3JGV0gvOW1wMnd4bWJZVk03aFlhenBYSDNL?=
 =?utf-8?B?Q0tTa0VmRkRiTVpLMGtJZUp4VEtRV0I5UHlkR09UZXFxWXZ3VnV5OVVzRDVQ?=
 =?utf-8?B?QkNVdCtNTVI1emllOUlQa0RvRmtFblRiN1VucGN4cXRKcjlDcnNGUUVnSnVZ?=
 =?utf-8?B?S0M3NC80WCtqQ0EvQ1NuZW5wUWhNV3BQVndIZGlXYk5MbDBkbTRTc1lvWU5s?=
 =?utf-8?B?RGZKaEVVc2h1NVlhL0pHdEZyMHJYU08vYS9ZdGtoMk05T2dhNEpHbjVzWkxY?=
 =?utf-8?B?ekIrOXlrRndySGltUlJadnhJNVQ0am9OTHFlYkZ1amdKc2JkakMyZDRBTDNh?=
 =?utf-8?B?UHZkeEx3YlJTRFR1YlhGV25RT0xpWWQ3M2k1eHBOQ1N4dG14bVRtUmg4WUV6?=
 =?utf-8?B?MXFaVFFFUFZIQmRBZ2l1ZXAwNHgxQU8vU2JEQVZSU0hta2Y0Qm5yeEVra3Uz?=
 =?utf-8?B?RmYwTjNuMlVBbjAzTWp0WS93Ykt0azBjWktmSG80aE55cDdyTE52MDVUbk1p?=
 =?utf-8?B?Z0RRZlJaWldzM3Y5d1NlOWxaeHVqZXdNb0RlbTBjQkcveXo0WGZaUDMxVXdt?=
 =?utf-8?B?OTZmQUt0c3hwWjRPMVhkV2k4TWtBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e77c64-5028-4cd4-1d94-08ddd8d3322a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:32:54.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcLbCatZ0kvbMSLGQFu+p5el5GiGc4kLHjxM7JBcngXNBAqCSJ0EmePW9aJekFsweFDdRBuVMMQc5vL6LZzAybgtu6dDj94me9cZ7hS/vlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7853
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

On 8/5/25 1:44 PM, Marius Dinu wrote:
> On Mon, 2025-08-04 14.42.11 ++0200, Jonas Karlman wrote:
>> Hi Marius,
>>
>> On 8/4/2025 11:43 AM, Marius Dinu wrote:
>>> drivers/usb/gadget/dwc2_udc_otg_phy.c uses s5p_cpu_id,
>>> which is only defined for Exynos CPUs.
>>>
>>> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
>>> ---
>>>   drivers/usb/gadget/Kconfig | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>>> index 46a83141481..deabcb3e51f 100644
>>> --- a/drivers/usb/gadget/Kconfig
>>> +++ b/drivers/usb/gadget/Kconfig
>>> @@ -108,10 +108,11 @@ config USB_GADGET_AT91
>>>   
>>>   config USB_GADGET_DWC2_OTG
>>>   	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
>>> +	depends on ARCH_EXYNOS5
>>
>> There are other platforms using this driver not just exynos.
>>
>> You should probably change
>>
>>    if (s5p_cpu_id == 0x4412)
>>
>> into something like
>>
>>    if (IS_ENABLED(CONFIG_ARCH_EXYNOS5) && s5p_cpu_id == 0x4412)
>>
>> instead of breaking use of this driver for other platforms.
>>
>> Regards,
>> Jonas
>>
>>>   	select USB_GADGET_DUALSPEED
>>>   	help
>>>   	  The Designware USB2.0 high-speed gadget controller
>>> -	  integrated into many SoCs. Select this option if you want the
>>> +	  integrated into many Exynos SoCs. Select this option if you want the
>>>   	  driver to operate in Peripheral mode. This option requires
>>>   	  USB_GADGET to be enabled.
>>>   
>>
> 
> I'm sorry. I'm unable to fix this driver. My C skills are not that good.
> I didn't even know this was a bug.
> 
> BTW, what's the difference between IS_ENABLED(CONFIG_something) and
> CONFIG_IS_ENABLED(something) ? I saw both variants.
> 

https://docs.u-boot.org/en/latest/develop/codingstyle.html#conditional-compilation
