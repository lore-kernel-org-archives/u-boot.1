Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61343C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC1088B79;
	Wed,  7 Aug 2024 11:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N1Jww0y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B012588B74; Wed,  7 Aug 2024 11:49:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA63889D2
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+UaeC1+fGnufP4PVa231jpzV1tTnD8BmKYF2Q8XCpXWC10boivmERmKT4R7MP+GP59tWZ7/XcK8Ed1Y0rqLbOBnlrA5CsZJBDmBT/i/Wjza8HmEsUjFPtOz07cmG31Nuljs1DbEnyCKb+nA5BNYaFBAk60S8OkIrsrIMn9Q7tsQ//q9oKg9Mjq5XZVE9HkxCUaeMWpdFo95oRkZy5wyzHFxt7nc9wSQ39hdU/7u+/K4KX1KOlflcQn6yfKzhOOeS32t+OXf+y/oi8Vo/cU16bEx4BZD5hFfnn/a12gxq3bT3+G4pMm00TtdZrtPtaW4xYret22cGMiG80kSDRujtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw2UNY+le2fOAbhXVy/GbwYkvbnON2vrzH8eFfuqo5k=;
 b=dkHdKOaun4MmxVuS7GBKqCBzIHxEMc+HOLihiBKSfUuzFklzxLkgsJFvRk9NPJt7Ux0gSBIlFawWhZ1JP3vpfWrwIo4HkprgJGz2ekGbbILSStGtMmIPZiPoPbqGIG5zUzx8Yz3uMbtA1yIFIKX+bpQFRcE9Lt8FbDUVRpUkALL/eWuXEojfW7/H0oglp0TscaIpZwsLDqabHxfpQMC1qe4OqWUqJtnAobgdmUEcE/XikC1pbTQ0guBwbNz+TG028WvB5fYtFhZXmH/NfoH2bS6FfaQHdsEnXEwWWa43uYmFFtlBbrnjM2vvzFspJofFkZZUjozV8ZsbAosHP3qgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw2UNY+le2fOAbhXVy/GbwYkvbnON2vrzH8eFfuqo5k=;
 b=N1Jww0y5Cjuy+p4KQS17TpklzvFub84GlCtsixlTStE0CEa7bthvq7vhRrEwykcXGPG02PyrDYZ1Hz/Cz0c/Rv3sGJcXAg92G4fv/A2YuLrduSCzFdbS9VBh4YyNR7uXe+ZYY9kui5uT6K/a5cIqVLttZDpwzUVZ51e3M+j1tLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU4PR04MB10741.eurprd04.prod.outlook.com (2603:10a6:10:581::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 09:49:52 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 09:49:52 +0000
Message-ID: <4c80c067-b34a-43ee-9288-cc8c825372dd@cherry.de>
Date: Wed, 7 Aug 2024 11:49:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] gpio: rockchip: Get pinctrl device from
 gpio-ranges prop
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::7) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU4PR04MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: 709550c5-8614-470f-e2a8-08dcb6c648f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3FhSTZpSlpYZ2xjcm1WeERBUjQxT1hyR2tnWndQZzFpZVlwS3RXcnFrYjRq?=
 =?utf-8?B?RVdDaFpad05HYzlnR002N3krTGgraDBOck5FR1cwM0ZTaWlFNGsyajhhTE9V?=
 =?utf-8?B?VzZlTGltS296dURGMW5sSm5Fd1hQVFhKSmV0MGdpV3NYcWdTWmkrMm9KU2RM?=
 =?utf-8?B?UVhQdUltdFFxU0JPdVhkZ1B1SXdBTnBQOElBaHFucTdlVVNSbGx2cVQ2OFJ5?=
 =?utf-8?B?RjBwSEsvRzBaS3VBMGg1R2ZpaENQbkhzcXRSNUNldmxmSXBkWlFNa2pjaHY0?=
 =?utf-8?B?Q1ZEeFdncGQyOWE1SjR0Z0c0YUxLbkJvNG5idit4c2Y5YmJRRUxGUHhuSWYx?=
 =?utf-8?B?d3V4eDlLYjl3S0VBQWtnbHBMbkoxOC9INHYvdmFiZHRPbVR1MHJKR2FlUFhK?=
 =?utf-8?B?NU0xeWJ2QWdDYnF1WldObG92Z3NrS3RYRlZOdlhVR2t3eHY2bGcvaFdKWkha?=
 =?utf-8?B?N3JsNmJHWjhxekpkWkw2ajNVNkF6emFBQ0psWVhOZkhVWE1tY3o3cFFKS2R1?=
 =?utf-8?B?YmN5Sk1nSnhNTkJRZGxsOE5BNzhOL0hCa2xqUkg3M1c3NkFHVjdpTTlmbERG?=
 =?utf-8?B?WGtlbHh6RTkrQmZ0N1VuZ05ONFFhcWJHM1BaQytFODBNV2M2dEF4cSs3RkVi?=
 =?utf-8?B?T292V0JveHoxNlVIa1EwNGMyNTNsbzdLZGp6S09jdFBienlNdTZEb2F0RHVZ?=
 =?utf-8?B?b2RwZHN5SThEcVdRMnlLUGN5bzc0ZHgwdDBZQ2QvM3EwUE55K2V3dkpsajBW?=
 =?utf-8?B?OWJFUEdpK1dQc3JudmFxT1VteTNCbFN3eEZVWTBSa2QwTUNXZnBnRWthL0p4?=
 =?utf-8?B?WE9Jdkw2d3JaMXJhZWQ1Sis1d3EzVmRnTUo5U25kVDhybjZ4aUpySzhpbUZh?=
 =?utf-8?B?dWJ6Y1Zmc2tpZkNxcjhwc1F1N0MxNHNKYjRkUWlmak40ZFFvN0FiSk56Y1c2?=
 =?utf-8?B?eG9xTGE1dVU5MGVFS2hqSEhoSGhuSmdjN3U2M1Uxb1FyNERWMzBPUjg1YWRY?=
 =?utf-8?B?OUNYTEtVMmdYT0FFVTVoejd4RDU1VEdIbGVXSDJ2cC9lQXAxRDhTbUl3L1R5?=
 =?utf-8?B?QksrVFluRHZjTk5laVJrM1J5cW9YUTRhQ2o4UXVGQlNtQXBOelAyTlRlZkQ2?=
 =?utf-8?B?T3d1Y3hvYWpRdUphcjBNTlV0b3RsS3RFQVNocEVaVVpFSkhXM1hWNWFNcDI3?=
 =?utf-8?B?L05jMXRvZFd0Y0VwSlVTeS83bm01cWQzUzVvMU0vTW5VSjlMYzZrcGpRTHlM?=
 =?utf-8?B?Y1VvWHBRUGZzd2p1MktyMENjenJrckczS1d1anJUOUViZ1N4OGlSNi9peGsz?=
 =?utf-8?B?TEh4aTN2NVdoUklzejNZdDhoQkVMcTRhV2x2UEpSY1Bic0U5K042dzVPMVNi?=
 =?utf-8?B?Q1NrcW1YT21PZENraTNVSjBSQjNmaCswMHVGZlkxRXJmM2FPN3FLMHRuaHdR?=
 =?utf-8?B?UFlVZnZIQndqRjZ6VXVEVnpaVmNnZmhnZjJlaVZXYnN3U0EvSGJicHJBS3hZ?=
 =?utf-8?B?VS95aU5FczU5aW1SQmxhdVlyaDBzRlhuVFpmUmVZamh1MmNUOXRUOXVEWGo2?=
 =?utf-8?B?ZUdwQWlOaTRRUXlTVlVHVlVPa0NxRkJaTjdXdnZLRENnWTE5RzRnc0oxRlY2?=
 =?utf-8?B?U291RGY0VWlldE5hNFNJYkQyaWZVcGVySWlHQUdDWXkrYXNkT0ZKM3M3cEpO?=
 =?utf-8?B?NkpycytTL2tOT1ZSSllualNpUWJkTFpPYm5taFV0U1B5UTBmN1F6SkpKdjhy?=
 =?utf-8?B?Uk5WazZlbFk4S01zclpyeHpta3dhMkw3T1Z2aTZlZ0FLTnd0d1NsQ2txWm9B?=
 =?utf-8?B?VlFXbFpkVFlHRHN5RjJtUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STA5RkQwdEgxRE0vTTF6eXJ4d0o1cHRzK3RkSzZKOE9TK2x1ZlVKdG5FbFEz?=
 =?utf-8?B?YVVlbW94L2NZS1dYRDVYNXIyMW8xNVY3eDhYKytYRGhBWTd4aUJRd3VzZ1Er?=
 =?utf-8?B?L29zcFFhckxqam01ZTl1emc5V1BIZ0h5dHhIYXpXSDF4N3JxdzJTdXJvYS9O?=
 =?utf-8?B?VmN3QTJQOXJMa3FLK2JFS21DTVRXUm5ISTExQVA4Ym8wQk11cWs3cVhkdU1X?=
 =?utf-8?B?MUZyc0l0eTAzWnFNTldaaXB4SERHS0lTYlh1RXlUNVhRUDJxcjJUMnNuY2R4?=
 =?utf-8?B?ZzUySUMvL0xSdDdPS0ozeTJDMFV6N09acjJmd0RGTVl5TFNvQjdWZjhDVGw3?=
 =?utf-8?B?UEVYVTJiT2lZMzlKNlZ3ZmxkOEF6S0pDVXhxeWJMbDg2M1pFaTd4ejNHV280?=
 =?utf-8?B?Z3hQbmdVOVBuZmNWV0JyNDFBZyt3Z0FRVGFhdFRET2pLb0lrTWsrc0xYMDlO?=
 =?utf-8?B?dklGa3I0djRNZjlEQkJTRXh2ZFN0ZlhabjdpMTZ5SzBQRzJ3d3BCTFpkc2ll?=
 =?utf-8?B?bmVZbG54VzgweC9DRGhnOUxVN0lYVGFXeUgzQjJsdVAyMVFhZi9lQ0w3NHda?=
 =?utf-8?B?MDZHcFRNL1hLaTBPSGxBZU5IcHJZSzNlK0xLdXFmdkZkSWFLQkZ2NTYyT2Uw?=
 =?utf-8?B?ZkMxUzU5cWZNdlNWS1QxeE92aitKVTBsUkNJczUwQjB1VGJSY0FsMkUzK0Zh?=
 =?utf-8?B?NkI1bE5jTkNaY0NRRnF3emNKWkNjODg5NlhIVVpKT0NnNW8zeExIdEYzcXdN?=
 =?utf-8?B?YzIvRnY1K1dySGRjbmtHdllSKzN6R0laYVBmMWxjNTNEek1zRTB5ZHZXVnA4?=
 =?utf-8?B?SGdCWDhhbUpNaml0V1FkY1RzN0xzMWJUY2JIZmlhWERMbVJrQjFVT0I3dDUw?=
 =?utf-8?B?cWdHazlBTm55cWVGWU5oLzhxTVR2VitEVXllWVR4MmNNWEFrYnpHU3ZMUnBs?=
 =?utf-8?B?ejM1SzZwTkVHN2ZPRjg5RFBSTS9QV3J5SGlMYnJrZFIwdkpORU14NkJEOWlu?=
 =?utf-8?B?aWwvbkhEWUdoYytuWFkzZWQ2N2NTMGZUQ01nQy9tME1zc0RPNk55Zm9Ja0Vr?=
 =?utf-8?B?VW5UNDRIZVo0SzVralZLaHF5S3Jrek9UTmUvOEVwL1VBMlFpMGk4M1NlVzky?=
 =?utf-8?B?ZnAwQWFSZEhLVHVJTVAxZ3NlUUxjMW9pK1pOSk9BREg0VzV4YTdtWTlON2Na?=
 =?utf-8?B?QVdNZjVhcGZJZWV2RUFqeFR5Y1lKc3NVQXk0YjNaKzdOR0ZDR2lJNHFEMWh5?=
 =?utf-8?B?a3ZkN2JJaWl5RVc0WHR4UVducVEyWk9QVnBXOVpHZ3pXczNZZ3o0am1zd2lw?=
 =?utf-8?B?MHU4TlRTclNyaVpLcHdUWXlWT2w1OHNsVHg5SmRwZ3d4WVRBT1Q1SlZsNzB1?=
 =?utf-8?B?M29COEdYRW51S0Z4bm5ZaTN6Zk9WbUh5L1A0S3pHcnpOWFVwTVAwWDZ4K0o5?=
 =?utf-8?B?QnU0Q1NUaElnUlE3MHhidS93UVFtczU1V2ZDQXhxSmxLZkhvalAxSy85Z0V6?=
 =?utf-8?B?T1NiQmFOczNLMzdBRDd5eVN5VDFNWWxqZHYxVUNoNTJpOXBNbFY1akptTVRy?=
 =?utf-8?B?cks0V0xxNlVTY3hQRlZkOEF0R0hDUVN0Nmc4cThCVjdXS3F6ZzJCZmEvbmFn?=
 =?utf-8?B?L1I0V1kvdEdUdTBKNjhCTmp3aW4vcENmYys2NVNGREY0T0lxanhTdUxUc1My?=
 =?utf-8?B?Z2tQc3hsWWd4STViZERYand3eU16cy9jc3U2R0hDVUFsa2hoTTBVNDh3TnVM?=
 =?utf-8?B?TzJOK3crMERyNmlaSHUrd3FZa2NZRm05LytHQWdpQUhmM2ZPVVZuRzJSak40?=
 =?utf-8?B?RytMYkllendPT1hHaDNLREl3MEtiMXI5SDg2OU0vQUEvV0pFZ1N0ZXpmenox?=
 =?utf-8?B?N1Aybm9wdFRBVEtWNlg4Q0FPOWdibmhxYzZJOC9ZclFrZ29RZnpiZnlBdzZG?=
 =?utf-8?B?MWpGa0pHYzBxRkFiK0hSSFdrT3NubTJJZWdUZUNxUDR3STVYNlVuUXFrYXVM?=
 =?utf-8?B?Mm5ZcndTQUlaazJBNzVNekpkRXlQWWNmUUNrQzNjb21xTXprMi9uUXY5N2JR?=
 =?utf-8?B?Um93bGlMZ2tqd0ljeTc4bVYzem55Q29ZYSt1b1lSY3FMZTFNc3VkR0NBMTJK?=
 =?utf-8?B?WUtIYklpMmFveXV1MC9QWGtvZWMxOUdsN1JlaFM4VytVeDFXcURLeS9uRStQ?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 709550c5-8614-470f-e2a8-08dcb6c648f1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:49:52.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj4DRAsY6veBwhfC9RBjL02dxftB1usZZkhIPtMg0FtWouuxSM7OGCNbmm8vpUmS/jut9JHWaBCQcvl6/liN/xru7ldrpcWaGGV5WLqszhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10741
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
> Get pinctrl device from gpio-ranges phandle when the property exists,
> fallback to get the first pinctrl device.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2: Collect r-b tag
> ---
>   drivers/gpio/rk_gpio.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 24ba12dd820e..abece6409ae0 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -181,12 +181,6 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   
>   	priv->regs = dev_read_addr_ptr(dev);
>   
> -	if (CONFIG_IS_ENABLED(PINCTRL)) {
> -		ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	/*
>   	 * If "gpio-ranges" is present in the devicetree use it to parse
>   	 * the GPIO bank ID, otherwise use the legacy method.
> @@ -194,16 +188,33 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev),
>   					     "gpio-ranges", NULL, 3,
>   					     0, &args);
> -	if (!ret || ret != -ENOENT) {
> +	if (!ret) {
>   		uc_priv->gpio_count = args.args[2];
>   		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;

I assume this is broken if a bank has less than 32 GPIOs, e.g. rk3288 
and px30's GPIO0?

E.g. this would mean if gpio-ranges is proper in the DT (it isn't for 
PX30 today), GPIO1 would be detected as being GPIO0 because GPIO0 is 
only 24 pins?

I assume we could trick this by doing (base+nrpins-1)/32 which would 
make it much less likely to have overlaps (we would need multiple 
smaller banks to offset bank's bases enough).

> -	} else {
> +
> +		if (CONFIG_IS_ENABLED(PINCTRL)) {
> +			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
> +							  args.node,
> +							  &priv->pinctrl);

Could have been two separate commits here:
1) getting pinctrl from property
2) switching the order to save a call to uclass_first_device_err if we 
have a gpio-ranges property

> +			if (ret)
> +				return ret;
> +		}
> +	} else if (ret == -ENOENT || !CONFIG_IS_ENABLED(PINCTRL)) {
>   		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;

Oof, another issue here wrt amount of gpios in a bank. Seems like I 
opened another can of worms :/

>   		ret = dev_read_alias_seq(dev, &priv->bank);
>   		if (ret) {
>   			end = strrchr(dev->name, '@');
>   			priv->bank = trailing_strtoln(dev->name, end);
>   		}
> +
> +		if (CONFIG_IS_ENABLED(PINCTRL)) {
> +			ret = uclass_first_device_err(UCLASS_PINCTRL,
> +						      &priv->pinctrl);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		return ret;
>   	}

I'm getting a bit confused by the change of if conditions here...

Wouldn't it be much simpler to just do:

if (!priv->pinctrl && CONFIG_IS_ENABLED(PINCTRL)) {
     ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
     if (ret)
         return ret;
}

after the existing if-else and removing the uclass_first_device_err 
currently before it?

Also not sure to understand why we suddenly do not accept any error code 
(we used to accept everything but ENOENT).

Cheers,
Quentin
