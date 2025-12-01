Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD266D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4706983935;
	Mon,  1 Dec 2025 04:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eHqvtryC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4255C83935; Mon,  1 Dec 2025 04:10:46 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6AE83B0D
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0IAg98dAoqZcGACSP+BFcOtXl34WIhL8HQavg+mqX5L5TDpbi3ZpKTNDl8da1QQcGE2TRAufFmbq28yJaZ+V/NPoJR/B4Zh4JK6h0dRUKEiRtVHVYtzLA+59oIhhC1dWxdM469RcudN85kJq19hmZi6Jn1jRiSBhC3bQAb0dSk5EumyghLWNkuOx6lxvnZCpAXbEgFez/YKKjGlmegs5u3FoC2fFmZnfHR0ta8arHOU4fJEe1n36hAjpP8KN1oLItez5WZXuINXdd95AWOauD7lYc+zIdGoWXJIpY0/ARCrtJY/xObz7Kn9olroSGp06/YKrqTMKdVo62NBExxpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXfKfbPDl5xxda7AaxtSBcPUyxjMf5g95rrtySBv2FI=;
 b=LBDNPeHuUqfa4XQ7tUXJQD+x6tPkz2cLjeJXUpFhNxaZ149527wy0BZOCD+o893w27r6BdokCkbVuxi0k1Icim+onLyXSNlVHFhW+r2rcf055fhg8Z6B9Rk43TEFr9RqtyIghz8V7D7JmvyrZ/V/C70a3A0RU7hvweP6mdGIkg33I7+ekjAqB/51i1VGukqv5mn7QJYrpQl0akBy5vzWo9Rye27asbRuwfdreZHJqLwy+jJMYip5JmsE/dxP5g1b9TXXrYzP340ZiqpZ7b/rdJ6QZMJ8QIVk4cp+n5N7+N61dyPMzhzlI55druFyzA4shO21iU7IKx2ZEgzntq5k0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXfKfbPDl5xxda7AaxtSBcPUyxjMf5g95rrtySBv2FI=;
 b=eHqvtryCoJhdTELZ5uyK/MpRLtwMbKllJZLG6tjr/liZbLOqmR37jQfis2XlDeY/jKJo3SeJzOvsIDNO121W0YiYE1G7OwxVzblVzOhO42G1gzODfTS4H8UKl8EIAu3X+aB2E82eLBIgc4HqLWtviCzM2FzCzo+WjdWx+IFcH9UEVQ0QT6A3TX4y0/SGtxWfbrMEd+6i96OAUCCiHQaDBEnaqbdVOw2z7TUOauFqJFR8h1FL0dWbW9t+Zx7xVItUWwrgoqvXfraSSGRLlHX2RdlNshI5kKYGBe2D6wasnmY6+xr3UvLDXBwsgm4Fde4agXxlqLJVOiwL3RwHdYT1Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:10:35 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:10:35 +0000
Message-ID: <bbd0ef04-a550-4180-a75c-63d665469832@altera.com>
Date: Mon, 1 Dec 2025 11:10:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] configs: cyclone5: Disable SPI in SPL
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-9-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-9-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: def228c2-3dbc-4dd9-fc9d-08de30873220
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFp2RjRwNnhUVVZDWWlsTDdqcmJnMjhnUnJ0Z0ZCQTc4VzVNM3VTWThodndq?=
 =?utf-8?B?RU9Zd3EwUUtKOUVJeUZ1ODZiUlI5enZNVFY1aDVVNC9tU2dRaWhtd0VGdlE3?=
 =?utf-8?B?c0YrOUk2a2dEejZwb2RvM1BQckRXL21UWUg5cW1sMnpCZSs4bmxHSE1pSER6?=
 =?utf-8?B?dTF1dWZ5ci85YjY3Vm1yY0h3MjRzbmRNYUFVM2s2NSswMzNuaWs3VDRaWGpv?=
 =?utf-8?B?b0wxb0NrWERTUnNtZUt3a1RKZGlVaDcwelNhcDZPYjh1S3c5bHozdExPbE44?=
 =?utf-8?B?M0JRS3l5RlNBbnR2UnJIYTF3NTVBK0xacmNOOXAwUnN4TWtYOHYrMEtDd2lZ?=
 =?utf-8?B?UDNRM2h0dUI1Z2hNQ2dHUE5BV3Y3T2xqRUJUaEo0Rnpadm0zSS9IN3M0ZnBr?=
 =?utf-8?B?T21DanJSVU91ekxKbjZMR0VlYmZLck9tUFZMa1lnd25PQXQ1dnlJR0FRSFFs?=
 =?utf-8?B?cERCL3ZQcXZyR1Q1R0NYTmNJRENZQ0RNWEpCakV4RCtpRlF6dUZJZWI5NHJl?=
 =?utf-8?B?amczdVkzZnpRMFRIZXczRDFZc2UvcnBPOVlMUFVkOUJ5RERkOGNSU09kVVR1?=
 =?utf-8?B?eHg2QVlyazhmNVBWQVJCZmZZaG9aS2U5bGpUOFp1TWl6ODJOa2JGTGhVL0F2?=
 =?utf-8?B?akhVRVRCb3lTZ3JQR3JselF2S2FhNEZaWUc3SU5hSndjd2FqUjBGRXFKZXlp?=
 =?utf-8?B?WlpjUFo2NE5ZOWtmVnNPanBLNW1yOW1iNUI1ekduSVRVaURzbkc4bU84aU1X?=
 =?utf-8?B?UUdsUzhYL3NEYk9VVXpxZmVrQTNkMEtmMW8vQ3JrUWdrZnhURmR0YTdEYXQz?=
 =?utf-8?B?OWFHellzWG1hU2g0bno0VCt3cU96MnNjNzNjdTlacytYTW5reG9abTE0elVn?=
 =?utf-8?B?ejVQbkxSU1JMMmRuMWVNbktmb0E1aFBjalViTks4Q29ReThyNVBIWkpnMkl5?=
 =?utf-8?B?ckl4ZnZ5NnlnUVBpYjhxcUUvblVlelgwNDhYL0tJUTJWV1NqdU9WY05pV0JQ?=
 =?utf-8?B?dk15VXlNazAwWGZsQmYrRWhqT2hQaC9KWTRPUG1hNm9PNzFFQVh0K04zTC9Z?=
 =?utf-8?B?dy8xbDRQN0FNaGRSNEpWdzZ1WDVsczAzWUp1WmF1dkIzWDZqdi9JYTJjeWFr?=
 =?utf-8?B?K0JRY2RCUGxrSGw0OVdUZG1SVXZWRlZqNEdZczJiS0RvajBZc1JDUXBFa0E0?=
 =?utf-8?B?MDdpaENlYnJJOVhSZ2xuV3c5T01nUnR2SFdFNVlTWjA3YmU0RGJZMDkraTVQ?=
 =?utf-8?B?RDlOZTE4dnE3R0VtdmJ1eVU5YVQ5Q1RDaTNhMTljMUlwL3dPNlJNc0FncG10?=
 =?utf-8?B?eFhBaUlKRCtub1N6cDZzdFNGNkZGUmd0NlJYTXZpTWtRTFNzS1lxemFxSXJP?=
 =?utf-8?B?ZHg2dnd0MlE3d2RRN1VqQ2s2YWpqVjB3OHoweDl5amVBY3hDOGp5TmNRVmJa?=
 =?utf-8?B?bzViazRVQlk5WUJLcWRsTU5VZm1BYUhrcVVOd25QOXFKOG53R0ZTZHJ4YTI0?=
 =?utf-8?B?TG5aWFBDc2l5VWpOUkI1QkF3dEhjWnB4MHhJK3F1K3ZLaFBFZjErbDNUNUli?=
 =?utf-8?B?WmlYcHpPeEhJM3lUVjQ0WWVwZFkzeCswMWtBTjB0WDFVVzVsL2lmWWVaSVRt?=
 =?utf-8?B?MjJYZ0Q5MmtLR3NCMCtKc0dxdm1JemptdzN4TXdkdDdweFVzNjVQTXFxWSsy?=
 =?utf-8?B?WkR2N1JTRFB2ZllCZGJuZURLaFlkQnY1S0pRL2NURDFhRWN0OTNyY2pJMksr?=
 =?utf-8?B?RExLTk5TVDF3Um84VU5Ub2Z0NGUvbmxzc0hIQTl1TXc3QXlQUFpEQ3lqdGR2?=
 =?utf-8?B?UUxPRE1rN2h5MjlhTGhWVUZIOTNSenRhaW1FaHVlYVBZbGFRZlEwODZFTnBJ?=
 =?utf-8?B?bW1RMU1YZktrN2wveGF4SU0vejh4Z2QvVUpjNzZVZzE5cnZ0bEx0R3dzZ0hr?=
 =?utf-8?Q?LK92R9WGBlXoAjlWSneyBGKQ35LLmiku?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FHOXRoTWZxRFVJY09tMEREYlhEOHpka2VhSWl1VUtoeDc1ZXdJMTdhRWZm?=
 =?utf-8?B?VnlBek5jZzF6Q2xRUTZyY1d3cEtZTWt6ajV6RVV3YzNqK255RDZyeUdrRU4z?=
 =?utf-8?B?RXYwZkpGWWVla0gwWlRPU2NPMU95NjY3dnhWUk9KRlZvMjdac29oQUJVcWs0?=
 =?utf-8?B?RHdJa3QyUG1nNmFZVm9iMGZTdWRNaTF1VWtKYWtBRXJEdGNQZUFLQlRUazNo?=
 =?utf-8?B?b3FjaGhLOVFiVDB0MUcxSVFRTUgySTFlaHpSREp0R2dqMWk4MVFBck5lY0FD?=
 =?utf-8?B?WjZOaWkvSHIzMGQ5Y3FvQ2ZiemwxSTVWQ0M0T05SSlBjcUFXdVdmZVhoQU40?=
 =?utf-8?B?NkxHazRpVU5reFowWHR2c1FqUTZyU0x4dFQyYURMbkZDakV4VmZ6VWtGMHdB?=
 =?utf-8?B?YnZhOGFyTXQ2bTRUY1ZQMTZFakVvMjh3cG1Td2ViRk9aM1hXNGlPL1pBSGkw?=
 =?utf-8?B?OFk0T3NYV2ZYRjV3SnM0WmwvOUhaVzB5ajFuK0JITTFjb3ZJTnNwTWk4UTZH?=
 =?utf-8?B?Z2t0SG9JK2ZiTnVrOXRNTDhXSWxRcE1uZEZzWnZGK2NXbVpiaWxjdWdGNkJL?=
 =?utf-8?B?QXI1U2lMUjg5QTBZZytWMzJwTWVDL3dQSzhYeDZrV0luSFhuYTJIQzJmMHBG?=
 =?utf-8?B?WEJCTzk3NHVZK29VVDNTVU5NL3NTVHcrSDEwTWFtTTQvQVFPdzNLUTNHZUhK?=
 =?utf-8?B?bDFPMStvTjJwM2FkTlRnRTV2VFI0ekwzak5VWkMyb2JIQXZHaVFrdVhsMFFt?=
 =?utf-8?B?YkRMUzN0T1dQTnQ1dk4rMUtKZmNYYkhGRVB0QnlYQXlGRFMzY2lWclVXNE1F?=
 =?utf-8?B?SnBDZDBDV05uOHdvQVVXUndMcEJ1YThIQ3k4dERPWTZhZkJybEQ4YjdQU2Vy?=
 =?utf-8?B?TGluVjB1OWFiS2JIMjNWUGhuaEZtM2xxd0Q2czhvWSsrb2tqUmttK2hhSDNn?=
 =?utf-8?B?R3RvZmZPRGNkMERJaVFka1BkQ29PN1duTjF6SDFKZ2l6M1JUaGJ1c3hsSk1r?=
 =?utf-8?B?RzFOUm9ObXM0bmFwdFFoWHFEdU1KblYyTGxqc0tpc3RsZ1VVZGdGSDhETDNm?=
 =?utf-8?B?eEF2akRQTUFuempzLy9aQW8wS2FGQVJ2bnZQMDBzQUdNTjc3VDU4TjgvNXkv?=
 =?utf-8?B?YkhaTWRzbm5MQ0dPYXk0S2FIQVdNRTBrM0d0N25VU1dIQVIzOUY3UW9JWldo?=
 =?utf-8?B?RSs5ekMrM1YzSURud3VVSHhIcHArQ2FCZEpLM1YxcnlTLzFmMTZpWDhJdmpX?=
 =?utf-8?B?SkdhV3hmME04UDh2VW9tOGxKdEdXSStEQUIvOWtHQ25wZHVwZUp4YnhaY0FT?=
 =?utf-8?B?bWR5U2s1dnZKNjkzcE8xS2xuOEZFTUpSZE9yMVhpdW1oMmRrNDI1dnJ6QnZh?=
 =?utf-8?B?WE5wdjBtUGJJQzJxeWV4TDhWMHlDaFBiVHY3RDB6NGRuQVNWOTFRT0R4Qkpa?=
 =?utf-8?B?a2NKdmtIL3owZDBtbmZ5aG5DdnJOZXRqSjh4cGVzZVBqMkNRcjFoZUROZEQz?=
 =?utf-8?B?bXNhMUxhZDhOL21KTE95N0p5T1UyMVpZYytwS1doREZna1M5UTRNeGFkdnVY?=
 =?utf-8?B?RVZYdTROWElaMHQ4OWlrUWRJNW56ZXJKV3RzUFJETXNHRU9xc2w1anB6aGJx?=
 =?utf-8?B?S2Q1dTB2TmQvSjhkM3Y0Sm9ONjJzM05yblVDNHFCdlJTQWZCakcxNzBqeG9X?=
 =?utf-8?B?NHJPSDdzSzZnKzlTbVJPanpQamdWM0FLcmk1bDBnaEZhOVBIa081ZVFtU1Yx?=
 =?utf-8?B?R3FLOThaVncyaXdQakgwSktIM01Gb2lpVmRSRFZiY09RVXk1SHNaNmJzK1Uv?=
 =?utf-8?B?VEpWM282Zlg1RVR2ZFN6Q29maWdEU200T2liNVJsRGFYajloWFNTZ2J5c1lN?=
 =?utf-8?B?NXNZeVF2V3plbTFJSEFnZjlyaWhkQ0JjT1d3aitjd3U5MmlvVlpKOU1EbDZM?=
 =?utf-8?B?Ylh1K1NZNFd2T3lvY1V5WVpnMEZnYjlYc1ptd0JNMWVIaWF3bXJvUHQ3ZzFL?=
 =?utf-8?B?TnZSV1pFYlE4RE1oY204MTk2cWl0UWpZZ0dUWisxeXo5TWVrT2ZSWk9yRnlr?=
 =?utf-8?B?VnU0ZW5iVFdEeSswQVBBSmFMK0JkbXVKbitZRUd5aloyNE5iTEhmeGNkQW5n?=
 =?utf-8?B?RUljN2RRdFpSeFRqZnhBbmZEZXFIRnVucC9teWl4Z2R4K0tWa2xVamV1SVp3?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def228c2-3dbc-4dd9-fc9d-08de30873220
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:10:35.7220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk2mOf81N1hvUhW+0b3tnoTeIQDGLzijJN1IbAegZYLqfy3edNjzYIcvp9ypfTfXFzVNeWJs4b+HZx3D99ky8PaI3pQcHvoVB+Q8+O4KEk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Disable support for using SPI in SPL to solve Cyclone V storage issue as
> the OCRAM is only 64kb. The SPI configurations are only
> required during uboot proper only.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_cyclone5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index 94bb05d20ff..6d9acf6c231 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>   CONFIG_SPL_STACK=0x0
>   CONFIG_SPL_TEXT_BASE=0xFFFF0000
>   CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
> +# CONFIG_SPL_SPI is not set
>   CONFIG_SPL_FS_FAT=y
>   CONFIG_TIMESTAMP=y
>   CONFIG_FIT=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

