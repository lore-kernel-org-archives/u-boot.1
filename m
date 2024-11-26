Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE616D5A6DC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 03:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227FF88E0A;
	Tue, 26 Nov 2024 04:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C49689430; Tue, 26 Nov 2024 04:53:54 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3293188DF4
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 04:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacobe.zang@wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3b9a0xR+jf3QEKEcgel/1+PK1mQUTUDjKOI0po8ss2/GG+Byo7gLqeWM0UrHtia7w+ctUrl7qXvK6IhPgO9m+0LzSQG2TB1hJialioytYG+8qiRAurah2nnbPYVSqmAxjz97BvCJYTFhWJ43wWg0c/FnWRFmw71ySlQrQ2LfT5uBye6lX1SkTxxXaeNfRlXL4bUvZLX4wOwTX47aAVgt/Nru6SaUsBq/A1uNF6Iz6JJdu2P6GQEXUwM8lJxGdVL8XTpc2RpW0OEZQ5mx9NW/G8d92FVBr505JqbgjDDZdsVc4VcdPfGkI7Z2jf02L98QwOVLaklFkf8O9/VZJZN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1znMlLvUP0+e3f5Dt2TvakQ4F+uk4m+4R6Sbm/L+r8=;
 b=SG6ZltlupDZyoY17o0hn0nN7gKIWuG8rzkueO0NwlqwKk8B8H9WsjlDd5vdyw8hEvZ28Oy/pdLMtPjsH0lJgrSbgupymG/0e8klmpE23uHLO3kcRQIkF6Spk6Ii8DuR6b2dYP9eF8jXS+px1xhFQZG/vOEuv3H9tYxMan19upjq06xSbZuw/cT/x0yJkHcsCLVxVwoxWPBf4CQsaQ6F0lTq67RfqsLz5UrxQJF2T0Zro3xqRjNhmNlDEqJ7jifbrw4CeDwtqKCAZbpFp+/O0T7lfq+M46W0bpPmsBc4R4jHjdH53jeBaB3JASComY2qzwIqpsa9G7hJfBASIl0H+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7019.apcprd03.prod.outlook.com (2603:1096:820:b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 03:53:44 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 03:53:43 +0000
Message-ID: <4e7f8b9f-cd64-4549-8f83-20e731f0ddc6@wesion.com>
Date: Tue, 26 Nov 2024 11:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Khadas Edge2 RK3588 board
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241119-edge2-v1-1-b10c5d7626ca@wesion.com>
 <a007795c-49b8-4ee7-835e-cd06255dc234@cherry.de>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <a007795c-49b8-4ee7-835e-cd06255dc234@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 788afcdc-b9ac-4e86-8433-08dd0dcdec16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnRwUC95YnNaUU9yZGVsMFRnRkJ4UG5lMTBsU2lQRExDSWZLSEhyUmZzL3pH?=
 =?utf-8?B?eTZ0MHExTTcwbGNIWGt5bSthLzkwMmZWNmkrd1ZyWkpTNnNaN3ZjdnVRWUpu?=
 =?utf-8?B?Y001RlZHcTFBSGJTbmVlTVBKRU5SSDFOUFUzWkxDV0dSbWx0QktPTlJObmpR?=
 =?utf-8?B?L3k2K0QyQVRzWVp2cXE1RGNUVzA3YVhTck9XeTQzd3F5OWc5cFZ6eWpVVkdl?=
 =?utf-8?B?QmhJTEt5dWRDbG5mVlliRUtoU1ZqQTIrL2ZvWUs4WXl1eEhETzNFUll1eWZz?=
 =?utf-8?B?RWZ1c2ppKzA4UmRPTUVobW5WWEFmdXZLNWkyN2hLZ1NMMWJxQ21PMlc2SWFV?=
 =?utf-8?B?N0txUE1ZYnIxMkxYc0VLWEdKL0RZd3pTVTNRSjhBM01vbjVaYkRXR0x0aCtQ?=
 =?utf-8?B?ZTZ5ZHhYOGpVbkJsdTZBT0hRRnVXWDlmOGV1ZDYwVjc1ZmxHZXl6WWZnTTZO?=
 =?utf-8?B?eXRRc3VEa0lOcXc4c3FYaEp0Z3BJMDVSR1VxZDFuUGdXdVdwQ1lrMGIxZ1J4?=
 =?utf-8?B?YXJjZFROS2VKY1FtdGs1dHlJMFpkc1QyWTRnRWpiZVlBcCtRbE9nanZWR1l1?=
 =?utf-8?B?dlpmTlA2RFJhK2wxaGhyckx2eGlvNTNRWlMzcTlNdEtWZ0hZNU1NTWxPbFpv?=
 =?utf-8?B?cXNuelAvQkRrNFJId21Yd1gwTlFGYi9aRC9RVXF0TVFIdmJuQlFlOFY4VjdS?=
 =?utf-8?B?cjl6Y1RGcm1YUHh6bXJBTVJXekRWVXhCNVlsOGQwVGtJMG0yYU81N1ZBa3FY?=
 =?utf-8?B?UzQyS1dYTEtidUU0d3VVMlBrbUlhZHFjcnZ3SUhtaVM1QlJ5VjIvMWZ3ZHJM?=
 =?utf-8?B?RUZiTWdGbG9EOUl2NDBpOHNPOXlXRllEWW15cXlTUXprOFBOaHFxbE8xZ3Rl?=
 =?utf-8?B?dG82RFdDNjZoMWNkMzJGMnNvWFloSmJvRnVnSkMySVV5WlBiYnM4dm1QVDFq?=
 =?utf-8?B?S0JucGtuTFhxQjNzbU9OK2lSamNQaEEvcWY3U3hia01xeG9waGlMMUtyQ3Ru?=
 =?utf-8?B?MU91OEdmdkt2QUdZVFoyZ1k1OGRUVnNEMzdKNGUzWit0Tk41MlBHZ2FQK1Zs?=
 =?utf-8?B?YW1nWmNkRHAveDk1djVjMTNXQXlZMmxsODJlM3YxUHM5SDdOSlVmREZkMFNq?=
 =?utf-8?B?S01NY0lGbEZ2VWVRN2FEbXd5UjRtelFjSzBxcGlCcTBSWmRtMVRpYzFjd0ls?=
 =?utf-8?B?TC9sTnBIMG1rNVVEemxIVk1xeTRTTUQ3dE9xSU9RcDdQeU5GeXNXUnFRVEox?=
 =?utf-8?B?TXFCdVJEQVVWZ1J3Mnlhc1EzVE9hNHRYT0JtQ0t2WUloR2tybVdIalhqRGlP?=
 =?utf-8?B?aVVMTldsRzYvUmFHNkJpTmRWbjQwVS9vZ2lZTzRzMTZ5S3A4UGxFamNaYmoy?=
 =?utf-8?B?T3lUcWhGVTBqamp6MjRKd2IvWmZLSHpxVkI4NEN5ektNVmpOMXhMckxKY1R5?=
 =?utf-8?B?OCtvUmRRZGswQjFaN0k2bytvcmd0WnZLdXFvN1VUNjh4N2ROVitXMHFrMXRC?=
 =?utf-8?B?UGs4M1o0aFlOYXBIYzhCUSsxVDNlbXVjVWE4aU52QW9hbmlVME9ST20wUHNY?=
 =?utf-8?B?ekZiQ2wzY0tscTlCaUhvcUlOdnF6NFZKZCtGMEl4U3hkNklwZVVBK2FwRDdS?=
 =?utf-8?B?YjJmclpUd1FrZkpmb0pKTXVFUC9uTlFvaEpBdXc3eG8zYzFPdXJGWmJjYzVJ?=
 =?utf-8?B?V0J6Tkg5cDA4UUdtMkcvT09YVFVXNTlvMW92YnlrbjlQT2VMa0NXQUtVK3hF?=
 =?utf-8?B?YXFCQlA5V0lxTlJtanJjQ1FvSzhFRldoYW1CZG5ycVdtR3M5M0RFWE5NOUth?=
 =?utf-8?B?SEU3OCtTek0rNmVkbEJ6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB7001.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZGaDNiSHBOL0Vjc3VieU1zbHNWNXZIcUJyYUdSYjY4VE4zSGFNVHBHaXJx?=
 =?utf-8?B?cFJZVUZsdGxJcEU3NUdTL3MzNllacndIcnQzS3U0S3NOZnMrOXkzeHZtZGx5?=
 =?utf-8?B?bUpDUElOMG9vT0dGbGswWG9Yb0ZUenoxSWtHSG9IaktCOEUrL0ZmaWlPTFlO?=
 =?utf-8?B?bklobVlPWWtCM0l0RVlBNS9ZSjlhbjQ2RFRpRXVVOUx4Yk51MWRzMVcwcGZR?=
 =?utf-8?B?R1hSSHFMVEhwdzNlRXlBTXpEMmFmOThQZWRha3JkQlQ5blJsQ0QreFUrVzVY?=
 =?utf-8?B?cnFyM3o5SFVGMkg4ekhMb0YvbUhVa3lLRjJ3VnNzZStuVURmQmJDZ2VwQmZ4?=
 =?utf-8?B?cGhKUVZTK3ZXSXZxb3R2bCs3aTdXSXArUFRqYU5tWUIyV1NjQllqT3N1UjFB?=
 =?utf-8?B?ZHo0d0pLMWtnL1l1T3hHNi90OGpTR1pEMGplNjhLYnhPYTVvMWJGMTkyNVZq?=
 =?utf-8?B?TzRLTUR1NWtiRTZGM3c5NXVVWEV3M2FXeGpobG8zRzVFS3l1UUVYUXdBYVU0?=
 =?utf-8?B?Y1AyNWlEUEYxUWgrK0hMTEk5elI1c1BtTEltR3dnZUhycUlQeDNTV1I1bTRh?=
 =?utf-8?B?V0N1U0tDaUNxZXh2YVdFY3dMVE4rOVRtZ3I2SXVJU0FxUWEvenJrYWJHSVdv?=
 =?utf-8?B?QnJzVkRKRTM1WnRjVFpiVHNLM25DM29JdW9nWGlIRGRYazRxcVJodlhMTEtS?=
 =?utf-8?B?dU1pWUJWVmFBc0tORzNpRjFIUEY3a2pEbEdtOFJXV0tRMDl6TzdyRXNpMDFj?=
 =?utf-8?B?NEM1ZFhSdmFmNU9vMFBRNUVmR3E2eFhZV2xnTGIxL3p3Um10MG05OTlsZWRM?=
 =?utf-8?B?VVRzWEVxQVdFRzZwUGtycndKRUtzbVE2ZDZMOEdiSU1BZUhWNnY1VEc5dXp0?=
 =?utf-8?B?ZURYazNUdlozdzNFQjE3TTNjcVZYTW5iZ3NFVzY0cEppd1RhOFAzOC9kR2dG?=
 =?utf-8?B?Yzg2WDFJM1RWUGJlTUlua0J3UzEyUWliUHNsMnhrQWNpRkxMZ3o4ZTBkQnMz?=
 =?utf-8?B?MUJKRDEzVWFVZ3VramUrMlQyd1I2UE1GRWkxZVVxMXJhYU93dXFpUnB0aHZZ?=
 =?utf-8?B?bExqb0hQODd1WmIzRXAycERBKzYwTFVadHBzNkhMMWo5ZzRNek1sby91Q2ZT?=
 =?utf-8?B?VkJmV29SY21jSEpZVVdEcnBQekJ0WnVvbWRqSWZ2cjFneDc0L2RQQ0pLUXg5?=
 =?utf-8?B?SHRsL3Y0dXFMZzBrd0ZEZCtPK29OZkFvdCtVMXk2MEx0SjlVUHZxc05wYVZV?=
 =?utf-8?B?cUpBM1VxcFdTaUU4eUEzeFJCOWllak5jTHJrWWJ1d3VlSUNGRWNyeWhKVFcy?=
 =?utf-8?B?SkdwbVNJdU5ac0Y0S1A2S1ZaWHlXcFViVGsxMHBYNS9VNEVlRUg0KzBqdjU2?=
 =?utf-8?B?YlpEQThxTFhQaWxVV1B1VmpFYU5zT3pKZklsQUxrZHY1ak03SmFKcVpBRVhO?=
 =?utf-8?B?bDNKM0RIeDNXVnZyK0Z0ZW9GYkJ5bGoxVXpPZTF4dEFYUFc1ZDhkdDh0VUUx?=
 =?utf-8?B?ZWN1ODE2cU94YXVhT2hkQ2JoUndFc2RvS0hIbnVjVC84SUdWUFVHQXYvN2tW?=
 =?utf-8?B?Wndac0NXYWxvK1F0K256bjlhbnplVHVVSUdrQml0d3BRZzRkSmdHN2tjQnB5?=
 =?utf-8?B?ZDVXQkFieEd6NG5yUjRKZzFCWWhOV2prV2x6eUJpQnJVRnhCRENPZExNM0Mw?=
 =?utf-8?B?NVpnbUpBK2toNUwzUnkrTHNsYzU4Ky9iSUJ5YnBPU0s3WkxIdE5uc3Y2QVBm?=
 =?utf-8?B?azVLOUxCeHljbWVFYTJYRnBoZmRPVkQ2b3VIQjN4Z2tGOGNQQmxRZEU1eHcw?=
 =?utf-8?B?OE00ZEFPZVpOaWJpdnBkcW5SeDFiOUxwS3JEK1Z0WGFzb200dEwvbndHZDZJ?=
 =?utf-8?B?R1hSUDBqQmhDVlV3SlNpMDJDSzRYbzBwdTRBZzFPQjR1cm1QM1dsZ3ZURyt0?=
 =?utf-8?B?L0RBVlFDN1lXSFdNdWlzUVJ0MmtkQjlFK1lXcHRXTVJteVdaTmpQYXlEOS9p?=
 =?utf-8?B?U1Y2Wk1vSjNSMGQyR043aXBJd2FRN1JGYlVmaEFYWG14NHpaWTJGMjg0a0FQ?=
 =?utf-8?B?QWVGL1EyZ0ZHaDY0ZFpNZExXNWViSVJMTEF1cVIrYlhrV3Vobk91ZmZxVURu?=
 =?utf-8?B?Wlh4aTBZbFVjQVFPeUh1bkJEVWo4MVFJUERrMndLaThwbnd0bHBkSVl1cmRG?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788afcdc-b9ac-4e86-8433-08dd0dcdec16
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 03:53:43.8403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZsFz/vLPcKegXpmNLvMlrkVjrnPUpLCZkkuLZ18neI0nNsGRlCqQYDD6e4y/fLq1wH5+bARRmcFkD+hphGq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7019
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



On 2024/11/25 22:05, Quentin Schulz wrote:
> Hi Jacobe,
> 
> On 11/19/24 8:46 AM, Jacobe Zang wrote:
>> [You don't often get email from jacobe.zang@wesion.com. Learn why this 
>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
>> by Khadas.
>>
>> There are tree variants depending on the DRAM size : 8G and 16G.
>>
>> Specification:
>>
>>      Rockchip RK3588S SoC
>>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>>      8/16GB memory LPDDR4x
>>      Mali G610MP4 GPU
>>      3x MIPI CSI 4x lanes
>>      2x MIPI-DSI DPHY 4x lanes
>>      32/64GB eMMC
>>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>>      1x HDMI 2.1 output, 1x DP 1.4 output
>>      USB PD over USB Type-C
>>
>> Kernel commit:
>> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
>>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>> Add support for Khadas Edge2
>> ---
>>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 +++
>>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 ++
>>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 +
>>   configs/khadas-edge2-rk3588s_defconfig        | 215 ++++++++++++++++ 
>> ++++++++++
>>   doc/board/rockchip/rockchip.rst               |   1 +
>>   include/configs/khadas-edge2-rk3588s.h        |  15 ++
>>   6 files changed, 272 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach- 
>> rockchip/rk3588/Kconfig
>> index b5a0e624a53..7d817e7f1bd 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
>>                - fan controller (AMC6821 emulation)
>>              * 80-pin Mezzanine connector
>>
>> +config TARGET_KHADAS_EDGE2_RK3588
>> +       bool "Khadas Edge2 RK3588 board"
>> +       select BOARD_LATE_INIT
>> +       help
>> +         Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board 
>> Computer)
>> +         by Khadas.
>> +
>> +         There are tree variants depending on the DRAM size : 8G and 
>> 16G.
>> +
>> +         Specification:
>> +
>> +         Rockchip RK3588S SoC
>> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
>> +         8/16GB memory LPDDR4x
>> +         Mali G610MP4 GPU
>> +         3x MIPI CSI 4x lanes
>> +         2x MIPI-DSI DPHY 4x lanes
>> +         32/64GB eMMC
>> +         1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>> +         1x HDMI 2.1 output, 1x DP 1.4 output
>> +         USB PD over USB Type-C
>> +
>>   config TARGET_NANOPCT6_RK3588
>>          bool "FriendlyElec NanoPC-T6 RK3588 board"
>>          select BOARD_LATE_INIT
>> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/ 
>> Kconfig"
>>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>>   source "board/hardkernel/odroid_m2/Kconfig"
>>   source "board/indiedroid/nova/Kconfig"
>> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
>>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>>   source "board/turing/turing-rk1-rk3588/Kconfig"
>>   source "board/radxa/rock5a-rk3588s/Kconfig"
>> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/ 
>> khadas-edge2-rk3588s/Kconfig
>> new file mode 100644
>> index 00000000000..dd7b6cd8054
>> --- /dev/null
>> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
>> @@ -0,0 +1,12 @@
>> +if TARGET_KHADAS_EDGE2_RK3588
>> +
>> +config SYS_BOARD
>> +       default "khadas-edge2-rk3588s"
>> +
>> +config SYS_VENDOR
>> +       default "khadas"
>> +
>> +config SYS_CONFIG_NAME
>> +       default "khadas-edge2-rk3588s"
>> +
>> +endif
>> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/ 
>> khadas/khadas-edge2-rk3588s/MAINTAINERS
>> new file mode 100644
>> index 00000000000..3f16923b0f2
>> --- /dev/null
>> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
>> @@ -0,0 +1,6 @@
>> +KHADAS-EDGE2-RK3588S
>> +M:     Jacobe Zang <jacobe.zang@wesion.com>
>> +S:     Maintained
>> +F:     configs/khadas-edge2-rk3588s_defconfig
>> +F:     include/configs/khadas-edge2-rk3588s.h
>> +F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
>> \ No newline at end of file
>> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas- 
>> edge2-rk3588s_defconfig
>> new file mode 100644
>> index 00000000000..208c72ca425
>> --- /dev/null
>> +++ b/configs/khadas-edge2-rk3588s_defconfig
>> @@ -0,0 +1,215 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
>> +CONFIG_SPL_GPIO_SUPPORT=y
>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_SYS_MALLOC_F_LEN=0x80000
>> +CONFIG_ROCKCHIP_RK3588=y
>> +CONFIG_ROCKCHIP_FIT_IMAGE=y
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +CONFIG_SPL_PAD_TO=0x7f8000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_SEPARATE_BSS=y
>> +CONFIG_SPL_MMC_WRITE=y
>> +CONFIG_SPL_MTD_SUPPORT=y
>> +CONFIG_SPL_ATF=y
>> +CONFIG_SPL_AB=y
>> +CONFIG_SYS_PROMPT="kedge2# "
>> +CONFIG_AUTOBOOT_KEYED=y
>> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
>> +CONFIG_AUTOBOOT_STOP_STR=" "
>> +CONFIG_CMD_BOOTZ=y
>> +CONFIG_CMD_DTIMG=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_SPI=y
>> +CONFIG_SPL_SPI_SUPPORT=y
>> +CONFIG_DM=y
>> +CONFIG_DM_SPI=y
>> +CONFIG_DM_MMC=y
>> +# CONFIG_DM_SPI_FLASH=y
>> +CONFIG_MMC=y
>> +# CONFIG_MMC_SPI=y
>> +CONFIG_CMD_SF=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_CMD_TFTPPUT=y
>> +CONFIG_CMD_TFTP_BOOTM=y
>> +CONFIG_CMD_TFTP_FLASH=y
>> +CONFIG_CMD_MTD_BLK=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>> +CONFIG_SPL_OF_CONTROL=y
>> +CONFIG_SPL_DTB_MINIMUM=y
>> +CONFIG_OF_LIVE=y
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned- 
>> clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>> +CONFIG_OF_U_BOOT_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names 
>> interrupt-parent assigned-clocks assigned-clock-rates assigned-clock- 
>> parents"
> 
> This config option doesn't exist upstream.
> 
>> +CONFIG_REGMAP=y
>> +CONFIG_SPL_REGMAP=y
>> +CONFIG_SYSCON=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_SARADC_ROCKCHIP_V2=y
> 
> This config option doesn't exist upstream.
> 
>> +CONFIG_CLK=y
>> +CONFIG_SPL_CLK=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
>> +CONFIG_FASTBOOT_BUF_ADDR=0xc00800
>> +CONFIG_FASTBOOT_BUF_SIZE=0x07000000
>> +CONFIG_FASTBOOT_FLASH=y
>> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_ROCKCHIP_GPIO_V2=y
> 
> This config option doesn't exist upstream.
> 
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_I2C_MUX=y
>> +CONFIG_DM_KEY=y
>> +CONFIG_RK8XX_PWRKEY=y
>> +CONFIG_ADC_KEY=y
>> +CONFIG_MISC=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_SPL_MISC=y
>> +CONFIG_MISC_DECOMPRESS=y
>> +CONFIG_SPL_MISC_DECOMPRESS=y
>> +CONFIG_ROCKCHIP_OTP=y
>> +CONFIG_ROCKCHIP_HW_DECOMPRESS=y
>> +CONFIG_SPL_ROCKCHIP_HW_DECOMPRESS=y
>> +CONFIG_SPL_ROCKCHIP_SECURE_OTP=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_HS200_SUPPORT=y
>> +CONFIG_MMC_HS400_SUPPORT=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_MTD=y
>> +CONFIG_MTD_BLK=y
>> +CONFIG_MTD_DEVICE=y
>> +# CONFIG_NAND=y
>> +# CONFIG_MTD_SPI_NAND=y
>> +CONFIG_SPI_FLASH=y
>> +CONFIG_SF_DEFAULT_SPEED=80000000
>> +CONFIG_SPI_FLASH_EON=y
>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_SPI_FLASH_MACRONIX=y
>> +CONFIG_SPI_FLASH_SST=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_XMC=y
>> +CONFIG_SPI_FLASH_XTX=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_DM_ETH=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>> +CONFIG_GMAC_ROCKCHIP=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_SPL_PINCTRL=y
>> +CONFIG_DM_FUEL_GAUGE=y
>> +CONFIG_POWER_FG_CW201X=y
>> +CONFIG_POWER_FG_CW221X=y
> 
> The above options do not exist upstream.
> 
> etc..
> 
> Please generate a defconfig that is actually made for upstream and 
> enables what's needed.
> 

Okay~ Thanks for correction! I will recheck ;-)

-- 
Best Regards
Jacobe Zang

