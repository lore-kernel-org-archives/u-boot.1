Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8AED16268
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FC988CB9;
	Mon, 14 Oct 2024 16:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Kj5OUACi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A825689063; Mon, 14 Oct 2024 16:03:49 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89C588970
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+jeczcyzd1vlXS+uMuUbhpcxtb8LNiwYDeYSJ6QlIns9oXkuAQ5rROFIF+IjXQb8QX3Jo64EqQLm7MJFpeH7dIJzotVJ5g8LN/RpvFBKVNrelguH2T+TVFSx61EkMkZdOkixvRljACKvpHZWkMIQkXENLWbe1XhUmFHQxHFxiFYaAltCNnh/463DwH6KpvD6XwkVBFucrh/XCnoRT4UVZLKQdkCuxtrnEmy07clYmPFgfOJEOUV+kUKZ32hpjAO5le2tHDm/v70DrdD9NkuH3afa5p7Aw/eXx3jxKurt8JzkRgYM8G2y5GWEn9G2KLmJ99vR7ymq0k6dvFJ+/hSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TubwIAoFZ/gSWYJxiH922whkw9RFDbee3BCzcPjLJ1o=;
 b=m9Gsrm067MlUHFQMeDYfzUao7T+/Oydp+0SVxGUE67Dksw/I1KjwWJoDqzHet0X5+tn2fKVcM7MGxUB9+sH+2AJHkiK6E8XmSn4j9vvETwtlmv8ncn0m5GS4yGs4aME8TvRxOHtvnGCHdkr1QCGxLc4z9BdSWzh90ueNXBgNnCNAk0GnYwcBgTV3TjoHP/6aWuS6KwXwsr5EJ7ab72TLXfkypyYYr6qduUdizGH/BiAjbqUskB6Hz4YaNiQksYhtYwxI32o7W9gRheXhEpubDlaZ3Z09tb2k3q29b/MDRnOS6W+ocPrhcl6LPlNHwB/MBpWBYHR9J4sBL8of99tAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TubwIAoFZ/gSWYJxiH922whkw9RFDbee3BCzcPjLJ1o=;
 b=Kj5OUACiA4pfEwrHh3+3w8eee7E/4GwOxk1HUDbapabe5QnCF+UWWiXHqAyUJjH9mMHRhWtTlUhvnIwOg7KcFpb80dM4byy2GvTajgsv+HR7fJICqK0HnQam4wq21R0Dqg2ShDu4IfQMhXYZvjlcEYQDZR78M91VbvXBgdTP4kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9265.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:03:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:03:39 +0000
Message-ID: <5af76218-0952-4bda-bc6c-d4c0ca4aee75@cherry.de>
Date: Mon, 14 Oct 2024 16:03:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] board: rockchip: Add Hardkernel ODROID-M2
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241003195941.340519-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241003195941.340519-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f02d04c-f941-4ffd-add5-08dcec5900f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDVZSGtkbUJiVGcvRk40Z1Q5Qm5laXNnbFJkY2FvanJOdm1wZ3YzK2lndysr?=
 =?utf-8?B?eS9PeXZaZWdnR2ZHZW1pbE1hUWU1QXZtQWNlTjVxcXdoWnFTa3Q5S1d6Ym11?=
 =?utf-8?B?Q1JZQW5PS0k5LzcxT2tkQWtrdVJuS1BOMzgxWnc0Z05QOHFyV01Yck5pU0Ny?=
 =?utf-8?B?REtGVlpwUFVDQkZ1NGdMSFZWWkxhVHRPalBLQVBnSFh3K08vbEs3S3VWR1Z6?=
 =?utf-8?B?a2Q1MEF5TzZPcitpTit3T25MWkJDK2dxSVBrZnRqNVRjVE1aTVVrVzQ0SHZs?=
 =?utf-8?B?MkJ3citTR2JPYkpXWmhPSnUvdGduWEkySzhqRGJwVC94VGsybk1YZkRvaVlH?=
 =?utf-8?B?eWEyUTBaRk5wTVJGNGU2RVdhVHh4TCtmN1JQOGppYlFxU1BmOXVvMlBOVnJF?=
 =?utf-8?B?MFljYncwYldzZWE2dUhHYlFUK01HRTRmcjNtbmlOVVQ5K00wQnVkc29QUmsy?=
 =?utf-8?B?Q0hEQkVsVjFMTk9xQWVja0QvN2NuVHkyYTRSdVF5Nm40Z2xmbktVWEVwblB0?=
 =?utf-8?B?RHQ2MFFRUjRTL3Y1MXZzd1RLZzhsZFZES2VzZW5aMzJuOVFWS3pJb0t2Mkp5?=
 =?utf-8?B?NkVKQkIrQXlnTndPZ1JEU0pmS1hBZE0xYWVEYkFyTldYV0xSbXUxU1NHYnlj?=
 =?utf-8?B?MGJnN01qQ0F3U2ZsTEZPNG5NTW9tNFhUcEJOVE9qdFB1cVQxYWhoemowZTdT?=
 =?utf-8?B?UHFXWEVtbDZONlBNRUwzTzRseFFpbEJiUnArbFp6MDMwaGsweHRTaDEzQnU3?=
 =?utf-8?B?L0psdUFxR2k2OGQxb3IzSkxkUk14ZWFkMEVWbWFvMFduZ0xKdExtT0I1UmZF?=
 =?utf-8?B?S3hnVWxGL2dFMDlaTFlQTGdpMC9OWmE4dlB2WU5Ub25KTlM5WWdQeTFvWTBy?=
 =?utf-8?B?UjJlSDkxczVuWVc2NE10aUtwTkV4VXp2aWdTWGExOHM2Wk9RWU1mMlI2QzNU?=
 =?utf-8?B?blpHQlpaOTg3aXU2MkVUSnJZTXZFUHg1TDE5NWZPS3pmaWIyM0Rwb0drOXZD?=
 =?utf-8?B?WTN6V2ZDeFlGQWFzQjQ1SkJGaTJMc2wvTEZCUjRqYlczQk1idE4rMWVOaVB0?=
 =?utf-8?B?a09YMU9KSGJld21rclh6b0luempCOHhjNzZZdDgrWkxZU01EUVF0MUd1QXF4?=
 =?utf-8?B?Z0JuY0IySGxqaTBnN3orVldHNkE1L09uVlE2VVFBdkNmTStIcVNFR2Z6cjIy?=
 =?utf-8?B?dmd3YkphZk5yRjNKYW5kVy9mS05FSThrZzd0TlN1Sm5LTmkyRkNNQXkwaFo5?=
 =?utf-8?B?eWp3VXlzb0o5c2VZQjhNT05RY2luT0Y5RFZTelFGS3hPMDVlb2V1dndlMGJK?=
 =?utf-8?B?eGhyalB4TXFhUEROTURtTFU3OGJGUTB5Q1dJODBWakRWVm1FZ0JHU2NTT0RZ?=
 =?utf-8?B?WmMreWtTeTcva1QwKzJnVmphWjRSaTZ6VlcvUjlqWUVqYWYzN3dYZDhuNnQ4?=
 =?utf-8?B?eFIzWE9wbHRiQm45YUJZVTV1QTZaVklNd1dmLzhSMG9CbzZaWjFyT2Y1WWc1?=
 =?utf-8?B?MjdpZHVqd2x4dHkrQWhveXRFYi9za1lKQ0JqcG9SOWNqMmt6c2JRMGZFNzZp?=
 =?utf-8?B?VUI4NElvdkgvUDhOcWI1ZXZHcFpwaE9lTG8zZC9VUzN6Rm9DamUvVXlvY3hT?=
 =?utf-8?B?eEpaRGlWckhkemY3YU5MdE9IQUlzemhYWFlqdmdmdXduWnh0WkhLcmVCWVBx?=
 =?utf-8?B?azZWazQycEhaZmlWbUZMbzgwVFQyaTJuRVovdloxSllnNExBeVhjMFlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dNTWhpK0tkTUJMKzhZRVZ2UFFXK0FzWnJuRGRISXlubDdvSDh4TUdTK2d2?=
 =?utf-8?B?NE93eHpYRGZNL2w0TmQ1TzhtZ1FIV0VzYkgvN3VkelpiSWRZY0JNcDFJVERJ?=
 =?utf-8?B?QllhWDU1c05OOWxXaXQ2eHRBdWFiK3hNMklpaktzUGdCTHBLamg0WEFNVWxx?=
 =?utf-8?B?clRnRU9YVXppOStkRkpoVVJTZTdQVFNRV2RWbm02V0VlOVlIaWJ5L05zY096?=
 =?utf-8?B?SWZCWXRqTTlaOXhzNDYzUlVqV09JQ1AzS0xoV1dQRlJFZ0phQ2h1Rnh1Vkk1?=
 =?utf-8?B?OFhOYzcvcVlFZis1cjc2Qmo1YitTaFF0UG0veWVaeTQ3eTVGK2NCSGFpdGNv?=
 =?utf-8?B?bkNvWkZNVWdQa0syYWw2SGMycXRUR1ZhbVVMR0RROFRNZDlwVFFxYnJMQUxT?=
 =?utf-8?B?SVd2S2hRNEY4Wm14VHRXZ2ExRmk0NGlRSGhhcERHMzBqYkxiWi9VaVpiRFJZ?=
 =?utf-8?B?TmZKSGw3d0E0L1NWcFg2dnFkOENuM0ZnWForejNMdExBTnd0Zk5ybDkzK0N1?=
 =?utf-8?B?eHlINndmVXphemJMenUvWjUyZVJkMVlrSjZ1a0c1U0FWMy8xSFArY3BHUEZ0?=
 =?utf-8?B?M0lRY0x2QVpsSXByc1RSRHIvcDVRSXlrOURSNExiOVUxNmxoN09jSUFzczdj?=
 =?utf-8?B?RXRWRnhLM2NYcnRYYldkVEl6WjMwbm15YVZuMHlMLzluYjNNS3VnYzhYQWNx?=
 =?utf-8?B?bnFJSE02Tkt4aTIvM2s3UHY2ZHJLM0Z5MTNYT1dmdjJRUHJwL1BRMExLamJz?=
 =?utf-8?B?ZHR1dFdGNDRvaWhoSUtIVUZGajlZSXU5RFlZM2czVFE2U3hPM1ZnUWtsc202?=
 =?utf-8?B?aEdTZWJwSFh4UmZLWWZrU0FYeEJXUHMrVlBSZm5ZL0g3NjUwNXZCbFZUTURo?=
 =?utf-8?B?WmxaaHBYRWNxYnRrRW41eEgzTkpLem5GOUhFakZ3ZHRWRnZ6UU5zdDl3elIr?=
 =?utf-8?B?Mno5c0xaVzhxUFBGSnYzNExONnlvMW9rUmNSUk50a1Mvc2dWbGI4TThEVWUr?=
 =?utf-8?B?aHNQTFF1Q2g5aVlDL3NmNzZRejRPNERmVHVmNHFPWGxvV3E3K2VwWDdIZ0Jq?=
 =?utf-8?B?c3YycFBiS0JLcUJCNTc1bndyYWZWeUI1THNPckV0cmNBK0lBeVBOeHRiN1NU?=
 =?utf-8?B?MVlRaGRCbEVWaHJIWVRvYTZJRWRUNkRhVW5WdmNzcXRLQ0VPamc0cmFwcDk4?=
 =?utf-8?B?K01tWmR1K1FLNW92U3VSZk44MDU2cW45aERyRnBrZVB2TWN3aUEwVExCZ2Rr?=
 =?utf-8?B?aVBYOU5HZnVhZzMxb3hETjdJc2xpNlBxNmJVT3YyRCs1T1ZkUUxRajRSekhQ?=
 =?utf-8?B?QThwMTZibEYyRWhyaUpDOXZZQ2wzd1Y3anVMQW1BU2ZmTHRMV0JGMUlyNE1v?=
 =?utf-8?B?RFY1NDgzMGJSUGN1bzlMaUxjcnU3d3JaYnM1SW1LbG5ucjhLMDFaMkZFcnZJ?=
 =?utf-8?B?NzJyRGFrd2pVd1ZXSzRCYUMrczhNd2FVdlpDQlFITVQyYU12VmxEWEFBSnZX?=
 =?utf-8?B?M3R2aEZhWDJCczdpYUxnNVpTaG1GYnFsaGFVODd1aGpBaytvZGxUSy9QWnlT?=
 =?utf-8?B?aXVNRTFSa3VnVjB4SVhVcG5ORDN5VGlhUlY3b2lGc3hWQW8yY2JENVFIS0kw?=
 =?utf-8?B?eXIwOFJKY2FMRFQ4a0toT3pKaUxwb0k3QVV4WW00ZUM2ZFlaVXJDaXV2SWxx?=
 =?utf-8?B?THMzRmdOQjJOdFdCZnZnQWlHRVZyZk1RRnlGWFkwdkE2OG1OcWI0aGVKeXNh?=
 =?utf-8?B?TnMxbml2bjZybmRqL1d5cHNpTXBuOTRwVmk4ZHowSmw0a0pNWXNuM051Vk4w?=
 =?utf-8?B?aU1ETXAyWGZGR3cwWTVJcDVGRDF6cjAzMmd6NFFhTDNndk5nV0lrdEZBNVZJ?=
 =?utf-8?B?OVhENWVvSjBLUW15bHdHTHd5NjlPYlVUUmhIU3RWeFFyVGxnK3htVjF0SHB1?=
 =?utf-8?B?YmMyUTJmZWdzdkkyRFdlTUNwWE4xM1Z5TUZNWUs5RnpmYm5aMFdMSUQ1eStY?=
 =?utf-8?B?Q3FSczMwS1IwZ2NhNWhJYy9HMDF0dG4vZDRjNlFTN2VTdThTSWJsRUU5U2NK?=
 =?utf-8?B?V3J1djEwalM3eG9qYnVhdjJUdUhobHJNNEdXc3BlYTNVczRZdVJWTmdOc01m?=
 =?utf-8?B?ZXpqZExzWG92VG5GR3FzNHlGbTJFcThuU1VNdXgvUGZNcnlSYWp4SjZHb1o0?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f02d04c-f941-4ffd-add5-08dcec5900f9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:03:39.4238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuPu8l5stRqKDviOa254NFfqX9NhNUYF3qu6DsLXAVkb0eLKZnUpzaBrLRnoAes5gCeU2aQvT5tEeCPYCJQkC6j6IZ0BJJvDY450qW/wCsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9265
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

On 10/3/24 9:59 PM, Jonas Karlman wrote:
> This series add support for the RK3588S2 based Hardkernel ODROID-M2.
> 
> Features tested on a ODROID-M2 16GB rev1.0 20240611:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - PCIe/NVMe
> - USB gadget
> - USB host
> 
> Jonas Karlman (2):
>    arm64: dts: rockchip: Add Hardkernel ODROID-M2
>    board: rockchip: Add Hardkernel ODROID-M2
> 

Looks good to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
