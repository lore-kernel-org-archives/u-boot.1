Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CC0C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91492835C7;
	Wed,  9 Apr 2025 11:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h+qHibOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE206835D8; Wed,  9 Apr 2025 11:42:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DB983544
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2MOtlSV75UWN/1RyDUh2KiYA2kD2mz8NiFVAoASuRk8Us0Kve+1AcHPMhJbnW8TlVBrml/nSVZQqiVb8by0Vyw4Qa9SAuAGQf4m1gfhYZxveAOPVBynvjavvkTaLJ30+S9YqEesbsUyPpUkmZQdx+Rird9oHRKw3mWDAsrBlfplMmJJ8CV4RxPJBjH5gSSgNSx7k1+B2KxvIhGT2d4jSFFcAgzmItzYGFxqNff3Mouoyg19WmQdPFVmNuV9GuJ/Ak3DkIB6Ic0jg4sZXQqZ3/KWi7aHXu4dHGiyT9ujVo6WnYx6ZLc27nkgMq1RZJ5LOLcTAZOO/TIEgO+hBvrdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqm9LxSGCBW2eoLDhFBlDCFnPyLAY6rCMvSBJ/8W3Ck=;
 b=L+PdrL4uouMENwkZRoENVGVIKsSHoZnHYTX0bZW/CWHglxiiGVU0ga3TwHBVx7Vo1R59brd4j7x/8OaucQfuCDd10e99nYSlcKSa47UqDb3wK99zkVl9RspOKOhdOiCWAjzycl9SsOM5XaAJtY0otJb4qygcttupsACRY5CJPDQuQ9TR9ZTs68duv89uqdacke0yHS9FiLs+RrPPKAm8h9K6fJHFysIqYeMXVrCFdVzbBJ6lzwvxRHG0oDfuuF8sW7QxKhQ2eN45LEoVN/gsnLtV1N9A6XeJjfZNk/M2CVVd1UAmPdCY5xNTTQcdATZhgaYkbZC2IP4PlkhNd8IGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqm9LxSGCBW2eoLDhFBlDCFnPyLAY6rCMvSBJ/8W3Ck=;
 b=h+qHibOqc7yggCBK57HcuIN5VaUoiVULrfqBHUQImyopQw6wO4GIXfbgzpZZy2atUNJAyP+uxCYO3i8Yc0YLHLIHxDvkIW4sDuYm3n/M2D3tjCNXeq/KbmubMcqcKGa8u6FqEOk0rXBM0jCiuu5MxQZavVzraV5YujKHIaoAeBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9069.eurprd04.prod.outlook.com (2603:10a6:150:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 09:42:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:42:48 +0000
Message-ID: <f96cc4ee-58b6-4eb5-8dee-c73aa24565fa@cherry.de>
Date: Wed, 9 Apr 2025 11:42:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] rockchip: binman: Use the FIT template in the
 SPI image
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8232e13b-dab2-4bf2-c1d6-08dd774ae36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amhuS09BVWpsR280bkxyZVlJSEZTeFFFQ0ZaRi9aMmxJLzJuM3IvZVdBTCtn?=
 =?utf-8?B?cGxyNE5QS1N1OXkzdysybWxWei9rTDN5NG01eGRQRDNmUGcxLzdDdVhQMnpq?=
 =?utf-8?B?RjdyN1BxTUZUUzdMMDFySHZZanpKWGVGOVV0c0ZrUVJKOVR5bHNSY0JKeXVR?=
 =?utf-8?B?c1ZvSWtVRHZvd1dEUGNmd0pMS3FVNW1CZVB3djdIVWdXdTU5d1I1bGphZ3pu?=
 =?utf-8?B?S2dEaXk2WGZDWlJJdkFKdThOL1B6MFdLejRDd21BTG9GMEFPclBKRFdEUjh3?=
 =?utf-8?B?dXRuTURUT2o2Q041S3hPb092SmwyOUYvc3FicWlqUWtqS2JOd2JmdG0zdXBY?=
 =?utf-8?B?YVdRZ1FtTlNaRzl4THhHUXVRek5GMXJORTRxTWlRNldMV3NoSHBMUEE4UVR2?=
 =?utf-8?B?SW1mbTBSSkhYQ1kyL2ZnNEFpeWw3ZUYwdTFFUE9raytHNS9mK002T09oRXQ0?=
 =?utf-8?B?cm5YdnJzYnRoZmZ2Y1FBdlJDWVZ5VHVUdHdvOUFjNWxpbW1HSUhjMVp0bHpN?=
 =?utf-8?B?dG1ZQmJKVWtMcklMSDlTWkhkNSsvQy94QUluV2NMZDJPaHhjVXFzTW9XT0ZC?=
 =?utf-8?B?ZlNLYm84RmZMSm1LRjgxa2xFTWZpZFlrL0MzNG9yeUhzTnNtRlIvM2cxRGlH?=
 =?utf-8?B?SVFxaDdyZXpicjdyVm92NE9wSFAybE5ZS0Z2RUtOM0ZZM3RiR0JFRWt2cmNj?=
 =?utf-8?B?TlU4QlBoWGU1Y1hvR0MwSjJHa1ZNQUROdWU1S3hiMGxOSHlyWFhiVGR4NmdC?=
 =?utf-8?B?SDE0NmI3WGhGeURCTUJTZE1tdFJjNlh5eitWWU1YMVlwUnlkeTljYWZBOEty?=
 =?utf-8?B?THd0NzFsdTRZVWFlVmF2MFpwcUQ3R1l2eVkydkI3clZuOE82TlVRQTgweVRK?=
 =?utf-8?B?SUltK0ZuTzVLN1VKcDNmcUJFd3VBMGQxaE5iUVM4eGxLcmIxOHNJb2RMSmh0?=
 =?utf-8?B?VGZ5cWVmZnRzcVd4YTZXWTlZOUpmM0FSTld4Y1NOL3Nrd2xhSlNObDBSbWtP?=
 =?utf-8?B?c1JzWmxHWWFxbDhLb2JhRkpoV3o0OUpLTVZIR2QvOTZaUjM1bXMwNkpYY1Q5?=
 =?utf-8?B?TDJ6dkw3NjBiVFJwOXp1cSs2aTVsN2trNzdvZXd6QW5RZ0NjWkxnNDFrMkJu?=
 =?utf-8?B?a2pOU1Y5MnRKRlREVGQrcENSQ1ZQZ3VKMWdzTnIzOE80ckpXb1IyOFpPcnZT?=
 =?utf-8?B?VGJkSDVBVmV4WFZaM0Qzbk9ZM1ZkZ1VMaVlXSGtWUGNTc05DRDFMbGZmcjEx?=
 =?utf-8?B?d2FTZTdpTVJKSHdGcm91eDYrR0JpN2VML29JeGdITEplRVQ2NDhqUGNuWHpu?=
 =?utf-8?B?dzNXdzM1UmsycmpROGlCczF5T0Vzd093Yll3WEQ5aDFoU3p2OGxmcEh3eWJW?=
 =?utf-8?B?R0ltKzJucitIOHcyMXR4NVFZVHZid3N5QkpWU1BYaGo4QWtCR1lpYTI5TFhU?=
 =?utf-8?B?ZWs2S2pLWlFRM3lYWDZaWEtNdWl6Rks3R2k0Si9yRW1vZzdOV25HdkVKSEw3?=
 =?utf-8?B?UFo3aC9RbzM2SE9oQWVjUnJWVHc5OHZjNDVPS0dxcHpQZ2R1S245UUtGdEZm?=
 =?utf-8?B?L216TzNkQTE1aTRMTHlnZFI3SzB6UFUycW9LK2NsY0w0OUtYWTNDem9kekpV?=
 =?utf-8?B?UE04RC8vZWh5Z29tRTk2V3NNOVBqUUN1bkVUREJBWm11NTJSd1lBL3o5bVVT?=
 =?utf-8?B?QUpuWW9uN0tFQVVoemltQlVSQVdZUHVDM045SFJvZkJiOUttTWVubkszSG1n?=
 =?utf-8?B?OUpvZFpzOXoyZVZpMXJoc01LbTdUZVdEc0RmSXZ6V0JtMmZ3VlFwUDV2cEpi?=
 =?utf-8?B?RmZ0di9NaVloQm1oMzVnSjBvVnlOSXprMFZyQnF6ZUF1RllJZUsxT3A3RHhw?=
 =?utf-8?Q?6qDneXFcXx8Uc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lVQnAxT2MrZUtWTFhzTjdnUlBCTUE4TWxsSTFKdnh0cWtKYWorU3A2Wjkz?=
 =?utf-8?B?QXBKQU1CbzI2WU9xbWFtQmsvYUk4dVdNcjFZSVpLWVYybEU0elZyQXBWZFFx?=
 =?utf-8?B?UkVzK1JYaW9QMkdCSVJJZGZLK0lybHl6WWZ2MWkwNDhJbzNiVEJXVFV5UFdk?=
 =?utf-8?B?bFRwVlRtalhPbHlReFJTR0hVM0IzRzhURUJHa2tSQ29nUFlPYlRrL0hGQzla?=
 =?utf-8?B?OWpCdXdUTzY0NWhvT0JyZnZyZXNTUG1TWlRkUE9uSUNUOEV0aGZYNDY0MTBZ?=
 =?utf-8?B?aS9RUm1OSTBBK0d3czhmczlVbjE5Y29mb1ovbytHOTJrYVJKdzNiWGs0cUU5?=
 =?utf-8?B?V0dTT05GUmtmWnlpU3N2RlhJZXBrc1NiQmh2eXpyZVRjUk5pTWxqbUZLMHNW?=
 =?utf-8?B?cTVHN1NBSUxOd01WNHhuQjlnQ1ZIU2xPYU41dVN6R1RNVUN5bVphbjJuaGxs?=
 =?utf-8?B?RTlnUHJSS0xvT1dzVG81WS9YR2FhTm5sSnIrM09nQjgzK0g0OEo4U0xhS2lS?=
 =?utf-8?B?TVBFYlNDNlQzanhRZHdwNUllV1RwZE4vckVEZWpwSTVBbTNhNHpsVW1PS2Fo?=
 =?utf-8?B?ZFo0cUlidWQ4V3E5Y1U5ZnNBVzQ1cCtLZFBzWkp6Z2tBN2gvc3I5SzJjYy9I?=
 =?utf-8?B?OERkK2hGUWJuODNYVEZCK21pT1hHSk51SlBXU1BvQ1FxbDM2N1dpSFVibU94?=
 =?utf-8?B?L01xbVczWktWZGdiTDhFTzlPU09xZmx3a1dha3FCZmxacGd1MFNmTUY2cExD?=
 =?utf-8?B?NERYMG5rbHdYNHE5cmo5U3JtYnIwTXdLL0ZaSnIwR1FUL0tLODZDK01NT1lL?=
 =?utf-8?B?NC9ISmFhQnlyamRqa3lGbzU2TkRCc1lKZWRzZnVVaUVjdjY1ZFlEendLYlIr?=
 =?utf-8?B?ZWdsTHY5Q1pUT0NXbDVzVDg5ZUduRytqMDlMTlRaMGo2a2NuaXo3QmpDMXgx?=
 =?utf-8?B?bzl3SE41UEpsd1VoWmw3UHRpakVCOWM0ZHgwYUVicmptVUNZUTlQNFRzZ3ds?=
 =?utf-8?B?UzNTb2t4TWhSbEROMmdtT2FFVTgvOFBUdlpoSHN5VUFaNDJ4M2pOanlxNjh6?=
 =?utf-8?B?Z1AyMTMrT2hDeG9mYWJuMGtqVExPdGxjbTBzaEIvSk9SS2lqZjJUbkNKT2FU?=
 =?utf-8?B?emYwMlhGUVpWZ2VCbkhNTVNwZVlzVVpIdHBTNUoxUlIxeDkrcURLU1N3NCtp?=
 =?utf-8?B?V1BzVmNjeFFmc1ZZMS96SURBMjdzWHp0NEk1dHN5K1hQemFMdDMwbklrWTF4?=
 =?utf-8?B?NWNOU1BQWjdoRVllUk9QaUppdkoyVVVpdVdGVXdXbDJlTFFHcGhaYXFVT3NE?=
 =?utf-8?B?UWlUSVMzSFNabHRMbklzZm9veFNXdWY0blR3andDNWRYb3ZLZkpKa1lSVk82?=
 =?utf-8?B?aHJ6VXhwZ3VPYUtIbmFxbE1aWWpaUFIya0kzV3hMS2VSU01LOUpOOTEvVk5t?=
 =?utf-8?B?S0lnQTRUWDFtM1NmREpDc21aeFM5YVdZWnZNaUxHNHBESHhOVjZDbFp3RGJp?=
 =?utf-8?B?RHJvY2djcVYzVVBhc2UwMTRDb1N3K2JBNHlSdzk2TzVRQmxETzVWYm9qR0c3?=
 =?utf-8?B?SUZndUFPYkNjRHU3Y1hBaU00T3Z2T3RYSm85SmZVQm1KVzB1K1lNNUJCN2lK?=
 =?utf-8?B?cFFSZytzN0Z5L0Q0QXE1RTlHSlhhVmlUSWU5bmg5OU1idGF3eDY0RjNvSEhE?=
 =?utf-8?B?SjhVajhGbS9JTHJ2VkdOcFFlcFp1T1pwZmprNnFXVURpRlU0VUI3MWRESGdZ?=
 =?utf-8?B?dWtIWURLYnY1Q0k5eGhPRGFGMGJ0L2FXTnpUVjFBL3hQM2txVStGVGcxeUZH?=
 =?utf-8?B?cXFkb3NMQytNSHRydFB5SG5iK2p6MnpnT01UL09ZempVUDJ1RzlrdjdkWjFz?=
 =?utf-8?B?M2ZNbytlUlNnRHc1MGlVVlRDU2JGY0Nod2YzVWRtR0ZQTXorbVlBNHVyYTNE?=
 =?utf-8?B?dUxiZGp2cHRYbDdDeUxadFFQbmxYWHJaSHQ4am1FeVNoV21CeEx0VGd5NStH?=
 =?utf-8?B?endjMi9vL1d2dE81WTd3OFA1Sndld3pDVkxsaXIwczh4V3dZUW9NWXJQWTlE?=
 =?utf-8?B?T3Z6eFo2cS96VDR4MGZCNTdoNnQ0OFE0K25uN1NhemNRTGEwVTltRTlGZGVC?=
 =?utf-8?B?YjY3NUlwNzhTRk5aUFRidFR5Q0tRR1kxZlB4QUxjQ013L0FObFl2WXB0bElv?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8232e13b-dab2-4bf2-c1d6-08dd774ae36f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:42:48.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBGwXd+yiuSFyV2gRHNXAdA5UMvDykX38URf1Ws2b+EBxrc5A71RU86rw64kqDIwvuLMjFnMjuhPrXhEBTNdUdTjjot4XGc+Z9WfmUH/Hp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9069
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> At present simple-bin-spi relies on the u-boot.itb file created by the
> simple-bin image. Use the template to avoid this, since Binman may
> change to process images in parallel in the future.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v4:
> - Drop filename for the SPI FIT
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> 
> Changes in v3:
> - Keep the filename for the SPI FIT
> 
> This is an alternative for the issue reported and fixed in [1] and [2].
> 
> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
> [2] https://lore.kernel.org/u-boot/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de/

What about squashing with patch 04/10 ?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
