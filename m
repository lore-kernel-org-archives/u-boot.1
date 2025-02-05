Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4973CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 11:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89203800B3;
	Wed,  5 Feb 2025 12:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JaXE7o7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74A2801BE; Wed,  5 Feb 2025 12:37:25 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7B980040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 12:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijrYfKZBvtsMggvA+9VwB7bxjWZGEgycY7Rznk2OEgmWCpgsLbNpksCCXDDgXnZnO2QBfVB2O1P0jVGM7M2DAo1TOooSkYrCkGEaN+JspNd5CpV+gvNwYgysdOOTfG5xqvvbivRkfOefC3xVPvtgqzvx7o8dzETE4MJ9X/iAETOtysWtPq232ij8vMlKLDNtzsxgUVyRyHYn8oq8Y8JMt5yAqouT2dMqlvQox/pzdv80KsrbbhoG+hxp6+qeMN/QJ5yIP3QJSm0XpsWvZ6sKYN3XQuunSNu/az+7BC5duMo6jNGv19Y0AxM/FqfJMFc0Dh5hGoXjjHyauqakNNEG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFCM6PSFRULksAfKvwpvINd+8muCeFF9FY6JrgnqnTQ=;
 b=X3AoqNeJkpGHrEVUmtNJqd5twLIPfG5r9u8oYjDJJ2tTtyUBuyM4DTN4XAQJinaeRZjMuFZk/8uKcNktxJ7sDJxSSZrcbyqUf360xvAm9jTUUjzmkNmMH84LATpwDZ5opzEWwzBBlcjM/yIcRsWYvqTDLSAGg4ryymHHeCmOOVlrH5FiO0qu+CtGRDgUOtkkCMLFmTE9KKXNcw5D0Nc04QU3TPfyf74gV7JfzrJ2h+nzv6xHQyCG6C7BY7BC1o773x0nApH5VgjGRyRURX8DpZ747p42XeptF1BTskOEAMvvDyINKknKwbDMmND4sGV7y0gvItXqSc4f+PQd0S9ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFCM6PSFRULksAfKvwpvINd+8muCeFF9FY6JrgnqnTQ=;
 b=JaXE7o7OsYCV3PCXaDLb38piwbPhelRlgP0jhK26QG+Z7mPxdi8q601Mb/aqqJp84/wjxMeCZ+ERvrR/P5MseonLns4wqztwFnjNRiDJCBbVU8mA+WeDU6l46/bhYJWfeEZSuiszZBO0VGB+Jxu5/TuBl1eo5924wf5InNhpvQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:37:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:37:21 +0000
Message-ID: <4e7d8797-8fc7-43cf-ba8c-085476ba9fcf@cherry.de>
Date: Wed, 5 Feb 2025 12:37:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: Fix SPL link error for Radxa ROCK Pi 4
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, dsimic@manjaro.org,
 pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-2-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129132529.807031-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9298528c-10f0-473c-804d-08dd45d9738f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1E1QkRPNVcybml4WDQ3LzFBcXVxdnlrWnRiQ2VucW4wa3FUVGpuWStCRENE?=
 =?utf-8?B?UDNUNUFEcUI2aGVkREJqeEVhRlhKZ1dUREhhSmFXYkovdDcrdEwzZDJERk5O?=
 =?utf-8?B?OEY2dTREOU9tc1lyZFlvZ0QyT0lCbXJQRmJpK3ZyenhnSlhGMVBjQk5RUXp5?=
 =?utf-8?B?VXljWHQyVW5HanFQZFVaL3RKVklpK1BrU01CcTgyM2lBNDBFNTZRR0Y4VnBi?=
 =?utf-8?B?S1RsQjJNUk9GRlVMTW5BWVJCS0ZaZmJUMHg0L0lENW95VXpTT3FsTlU2eFdr?=
 =?utf-8?B?cnduRnVMSXQzaEtnNW5SbVpwNVkrd0hRWERwZHhhVFRLRkp5TzFxd2NXaTJE?=
 =?utf-8?B?Umh4Wno0NXZOakNhTVZNSDZLeXhIRXkzTHZ1aHlxMklsMWtGdGQ4a1ZkbUpv?=
 =?utf-8?B?Tm5TV213TG1rRk9taUV2Q1N5K1VCcTNYVnAveXJDY0VPSXFGVzJaYThOLy8r?=
 =?utf-8?B?RDNkTVY3UGJ6bWJia044Q1ljRi9YcU5QOFJoU3FVYS9QbFlJT0tsSFBTME1O?=
 =?utf-8?B?bTRhRmZxUFBYTTRSd3pQU29TWitZL3Q1VW1QWENHZWJ0VndEUmI4SkZSSnF3?=
 =?utf-8?B?QTNVQ3hjc0FOaGR5c2ZFQXh3MnRGM0ZEemVmSWRFUklJSWlkNFlYckwyMUpG?=
 =?utf-8?B?dklmQ2VUTHd6dVhKVUtsK2V0UlZvNlltdm1VWEd2aVNFODNTdDNNVDg1bEh2?=
 =?utf-8?B?aCtFWkFiOWQ3WWlYaEluMUZZcnk0T1hYem9aNzJCaU1ZejUzT0txVHllN3Jr?=
 =?utf-8?B?MWx2UEkxL01rS1hPSTFBUTZXbEdEOVZxSzAyaWRQdXBpenJsS0dQdEFZaGFu?=
 =?utf-8?B?Qm5pTlVBVmgrc29mSXNWcjl4NC9oNWlRYjJjUEVqN04zV0dFOTMzLzhBMXRS?=
 =?utf-8?B?blcxeW9Xc0RrRUJzTXY1RzdGNkxXbXdXWlBGNkFTN2lsNFBlZFYvNUFGZi9V?=
 =?utf-8?B?aTVMR2UwZFRTMk84OENhWmk4eFNveE5xNmViZDQxa2lVMlVXWnlTVXppM3Vw?=
 =?utf-8?B?dTVBZFhmYW9NVm1FZ092SVZsZ0JHRDNBcVNHSkNWUmprWmN2UHhFRWVjeVg1?=
 =?utf-8?B?VEI3RjhiWXBqNU9TL0tMTmptWkJzMXNPMlRCSXlLU3VrblN6UzEwL2V3RzFJ?=
 =?utf-8?B?L3lUYTZIREtIdzJRY3Y5OS9NRHF6YXc4T0VtL1ZpVHVsNHY5ZWpsWTVLSSs0?=
 =?utf-8?B?TWRZcks2eGpnM01zbjlwWkRJYWdkbjFIREl1c3VpdnJtUENITlJwVUZwSnBN?=
 =?utf-8?B?aHJ4SlhzUkVEUnFGMHJ0aEhCNkdON0lvaEhOeDNncGEwaWtjcTd0dGV0N0dz?=
 =?utf-8?B?ZWxPS3pXMC9Fc1IzMkIyZGVDOHVURG42TTZFeW9CUzFlMTRUNTA1MncvcmR3?=
 =?utf-8?B?dVY3V0ZwMWhCRG5XcXpjQ0ZlU3NTdzhWdjNPUHJvYXYzQXR6aDZsYllpUG50?=
 =?utf-8?B?d2o1Und0MFo5bGsxeGpjczNiSlcxT0pSc1pDenl5a3ZsanYzS1YvdHA3TDhY?=
 =?utf-8?B?Ykw4ci9NWnp0ZW1sYUx6Q2ZrUjl2V3MvZGtGSkU2US9hRHkrRzdCQkhkS0hK?=
 =?utf-8?B?c1BBV01sQi83ejdNWlVmNlJVeVRzS1hySktYQVVSS010TFVLQzUwOERjUUF4?=
 =?utf-8?B?M0JwKzhUaThaUTl5bHdNejlDVlU0VHA2U0dzVGU0MmYvb24vRkx5OEdFcFFi?=
 =?utf-8?B?dHd2OGVEdDUxL2o4NmQ4cGFIWGV5Y2llZDBXemNodUpxVUd0NXFveEJhajRv?=
 =?utf-8?B?WHdDMjU3WmhkV1RjejEwWmcrU3pSRDBONTJBYmp3bmN5MmxHSlNORURkWHFE?=
 =?utf-8?B?NzhkVnA4eW1qSU50REoyR3ZWakhublBtRlZYVytFY0QwZzYyK3RLTkRGanJD?=
 =?utf-8?Q?z+mrSPVs1yfpn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlMeDFQRW1jNlFwR2lJTG5vMlF4ZmM0M0JhRjlxOGh2RVhLMEh1bW1FQ3Fj?=
 =?utf-8?B?Z1BNVXhSanI0TE1kNU5nc3E1ZlpvWUZoVWxhbWdwKytvVGlsMEpUTTdTTlRU?=
 =?utf-8?B?eEtySUFVNWlvNHZ5T1ZwMW5wU09TdHlYUWZqWWlCMGFJNTh5a1JINjBoSXhh?=
 =?utf-8?B?YXF0dnJaYnUyaVplbkx3bEg3NjlMTWtaTFhJa1JEblUzaFRPcUN2R2dETDJj?=
 =?utf-8?B?S1F4bkZZQ2dQMEdYSDVwbjRhUHZqbHBjZTlXa09lNGhZVG0xRTdBcnJJaTBs?=
 =?utf-8?B?dzhXSE0vRUJ2Mk5sci8va01xVDN0Y1pjZjV2RDJEYnZGS0N4TkVLRGdFbnZN?=
 =?utf-8?B?bGNNQUp3Q1JYLzUreEJBMkI2cHJVNlIxYXNzcVZTd0hab2RoWm1JZmhyTThG?=
 =?utf-8?B?bWNjMFFOOElybnhwQ2dUT0VxeUkzODl2UjBBakJOVXdmM2dXd2xjOHJxWVRY?=
 =?utf-8?B?OXhpSnBGVUQ1dythZlVqZENlenl4QXhmcFBJaUZQdkk0Q1o3NDFDL3daM0JL?=
 =?utf-8?B?b2YwNWk2NktmWTk4aDJVbGZxci9yZVhXVE03QzQzQ3c1OEpZSTJ5dFlBUHhx?=
 =?utf-8?B?QlE0UkRhNzBvc3FWSHlMNWovangvNUQ2Qm5QenptNXlNQWFvbmppK2Q1ZXIz?=
 =?utf-8?B?SjgybE5CWG9KM0orankyMnNLT0Nia283V20yTTBKODU2d0ZpRnk5OTZHRkw5?=
 =?utf-8?B?Z0dHQ1A0bzJJRkk4aEJkL2lnTGE5NWg2YnQ2UUtpZDhYMEk1MkJ3MVFiR0tv?=
 =?utf-8?B?QzdVdm5wcUFKeHVSVDVwV1lUUk51NGlHVUNGVWJ0aUVQQzBRaVhUSERxb0oz?=
 =?utf-8?B?QUlzSHNrVlo4bnF5STNFdmhobXZYdGRUR1p2cWgwWGlXQ3hoOXJ1Mng4MGZG?=
 =?utf-8?B?ZGVYQzFrTS93RVliM292NE1GZzNYK1JLV013bmsrZWdlZDlsUUtSZDJMdUdh?=
 =?utf-8?B?NklJcksxK2ZMTVU4cDREcFV3ckh5NHo1dFZLTWFnUUExWThZUGFJTngyQTNW?=
 =?utf-8?B?TUJFdHJscHZCRkdYd3ludjQvaFphNVhZNU52aHQ2OENhU0lwcGlvNlNrd1JH?=
 =?utf-8?B?dVlOQVhKQWIzZ3Fra2o1WjFOd3Q1K1BtUkJodWNTVTlxN2wzYnV2T1o0L2Fr?=
 =?utf-8?B?R041NDFjWXc4bTRSQ3NTQmRiNkpVZGRmMUdGSmljTTJLUkJ0bVprTjFIckZu?=
 =?utf-8?B?Wk1wQTNYTHpBOFlsSDZzdXJMam9iTVR5VitlM0hEdmw3YXVSWkhBQk9YZHI2?=
 =?utf-8?B?ZG1QZm5ZWWFUM0paZ2dtRGpRZ1Q0b2tPZU5CTFgyOGsrUWtFSG9jL3J4OXRL?=
 =?utf-8?B?Y282bFc5Wk9GdlZYWlFNZi9sbVhtd3EyS3hrRTArR3JTSjlnQmdCNnd6Rngr?=
 =?utf-8?B?QzFGQ2FmeDl1enM1N2l0a25FWko1MkNEUElGc0lCSDdrTkFnOGtWZUxhRGJ1?=
 =?utf-8?B?RCtZeWhMaDYzZUV1Y2JEbGNNcXJUSmlVZEY0bk5tUk1yLzBIZk5tdWtZM1Bj?=
 =?utf-8?B?YzhBQXg4Z2hoWlZidEltUUkwNGdtaG9sOTU1TDdJNzZnSHpsNlIxWDJGZVB2?=
 =?utf-8?B?N0VIek4vbUFyOUxmemNpazlZVmRSZHRLNGcwRmdOYS9lUGRWczFEOEducVcz?=
 =?utf-8?B?SVRYTlNocnQ0OTFIU01zb21TdHR4KzhJWlNsdDk2Qjl2OHJ5Nko2M2tzdThq?=
 =?utf-8?B?Q2xSUUxQNm84cENwK3R4SjFnMVRDV0NKQk93U0tvSlNHMEo3RTdBSSs0Q1hS?=
 =?utf-8?B?dCt2UmZvU3pnS2xoK2tJaUNLbVZvdVh3bXp2SUpXL0licStCRHRYanlRUWRo?=
 =?utf-8?B?WWUyd0EwSEZjMWV6VWJrM053QjlDdytRWFpmNE5OZTRWSlZLd0F4aExNajlY?=
 =?utf-8?B?YU5OY2k5cTJoeThvOUNnMUtKbzNwd3plK1E5YjdwVm9mYlFLTnVZZHpMTmRx?=
 =?utf-8?B?MnRqa2pRbC9lREhjR2NtVjd4NkVpY0w0WjhvVUJYM3JZRW1MTXFONDlxYzdT?=
 =?utf-8?B?QnEvZ2dhYzVpWlpnbkdiNlZ0Y1dOOXRqSTRGZGNOQlkvMkcxNXdQWEMrY1VJ?=
 =?utf-8?B?VS9yWXQzb0M0VTc3TTk3Mk4wWkhES1VjNDhYTi9SNzBZU3ZqMFhQWERZVnRr?=
 =?utf-8?B?TXV5QlJKWE1lSGljYVRJbWZzeUZZYVJqRGtNSEZHT0JCMHNrcWl2LytDWUYw?=
 =?utf-8?Q?13QIx5bYUd6caYpj9I8gzL8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9298528c-10f0-473c-804d-08dd45d9738f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:37:21.0687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XQ6THSBHNtac32EZtOPTVBv4ATkQFFpdHPvEZxsIiyUrzafqeV0qMSsyoankHsUdl4DP1BTpnXO6Wj4AjzUrmJwyfhBcxID+Pp0ab/fyw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019
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

On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> If CONFIG_EFI_CAPSULE_FIRMWARE_RAW, CONFIG_SPL_ENV_SUPPORT, and
> CONFIG_SPL_DFU are enabled, linking u-boot-spl will fail.
> 
>    LD      spl/u-boot-spl
> ld.bfd: drivers/dfu/dfu.o: in function `dfu_init_env_entities':
> /home/radxa/u-boot/drivers/dfu/dfu.c:173:(.text.dfu_init_env_entities+0x24): undefined reference to `set_dfu_alt_info'
> 
> Compile mach-rockchip/board.c for SPL.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   arch/arm/mach-rockchip/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 5e7edc99cdc..e697df7ebcb 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -22,10 +22,10 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   # we can have the preprocessor correctly recognise both 0x0 and 0
>   # meaning "turn it off".
>   obj-y += boot_mode.o
> -obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>   endif
>   
>   ifeq ($(CONFIG_TPL_BUILD),)
> +obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o

This is probably a tiny bit too enthusiastic.

This means the whole content of board.c will be compiled for SPL whereas 
it currently is compiled only for proper.

This means we need to be careful about what's in board.c.

Most IS_ENABLED(CONFIG_<config>) should probably be changed to 
CONFIG_IS_ENABLED(<config>) so that it handles SPL symbols too and 
doesn't attempt to build stuff for SPL when only proper symbols are 
selected (and not their SPL counterpart).

E.g.

- EFI_PARTITION
- SYS_DCACHE_OFF
- USB_GADGET
- DM_USB_GADGET

seems to have SPL symbols too, but

- EFI_HAVE_CAPSULE_SUPPORT
- ROCKCHIP_USB2_PHY
- FASTBOOT
- MISC_INIT_R
- ROCKCHIP_EFUSE (though does only build for proper (see the use of 
$(XPL_) in Makefile))
- ROCKCHIP_OTP (though does only build for proper (see the use of 
$(XPL_) in Makefile))
- BOARD_RNG_SEED
- RNG_ROCKCHIP

only have proper symbols.

Maybe it makes more sense to move the efi-specific part of board.c into 
efi.c and build that one whenever we actually need it?

What do you think?

Cheers,
Quentin
