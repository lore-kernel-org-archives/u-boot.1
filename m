Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF91CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 09:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E537849BF;
	Tue, 23 Jun 2026 11:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Wmhba71O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755D3849CE; Tue, 23 Jun 2026 11:10:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBC3848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 11:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbvxPKVJ2Z18dHzDJR+a6+pe3+kx4v+hWVbZVJTy5tvPh1XG9evl3Sk6gQjfa8ZY7jG1cH5EK3/hD6ZqzbSWVlFnOi2p6I0tjK/BLbBz4+bGJa8f3682PL2SyqAEctCwK/LTdfymbyd3lpExZts0k8SldIm9h5znOcR0S2lk7EWNFfAdfYot6Uv2VXmAf1e+lQS5RhHHCMRlMobXEhdMm1Bsk95W4z7ftKtwMexIroynSAwCtUM+1/nBGwPfoyxAUb+a34r5MNqeWaPIT7NFNd+4pN18lftcqjpvOzcpaCG593rihlJ3m7BwN1fhIL7uj0oqqmCH+EShbFT8pjBrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/1s3O/K413swkCzr5cRZr7clIdAr2UQ+mVYASArrkE=;
 b=C9MOalYm/DFYhfC/UWx386ZkMulkOCZBZ8RGj5/ZKQql6x0raZola3jI3hmBHOyK4ySgMVPum8mWJUEMmff8gPCD1jS64fqZn4rODgI4WboPdEguu5yE/WZN9zCv+vCLedYrEo/8qEOly8YvAur34YS53lxz0TGJqK7ILPzm0Oml24hzQ75rfrggyYuYmiGtDOQ3HG9EO7gN9ovAQqw7aR7UcOxsmWkxzssBldumbpUMtBMjh7X8auOEpNOgRWShQDBwM/IrCxhyNmTHE0uY/OBmHYfaysYTPHsuLrtKTslwIDkxlMx9eCro5PtfriG1eQ5Wa+giYZ3qBuvxj2hAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/1s3O/K413swkCzr5cRZr7clIdAr2UQ+mVYASArrkE=;
 b=Wmhba71O0PjkJCJPfamHzcuG/nI8XKRb5UvYoo3+JRB60OH275B+TbLUy1dzYS/UEye/gv9WfI2LTP9/VMYYRxWZ9QZ551i3j+ULV9x+25+juE0bFS29kafxTJ4XCoZ2M55GQMXgRSABk3YlMz1A76w7WVhG+GenQZxcshtbTOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 09:10:41 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:10:41 +0000
Message-ID: <0ee5047b-3421-4657-a4ef-6261954fe526@cherry.de>
Date: Tue, 23 Jun 2026 11:10:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rockchip: odroid-m1s/rk3566 watchdog support
To: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: b647441c-4aab-435b-fb29-08ded1074c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: WbAm9VBBvXyaF5rUsavVgkdrUEAEtewbD8hxhjOpuwVp9dcHe28cFMjdT695K31y18VEV5q/ru9W9f8LzcMcQ6eEN+Qxn0sMLqwRztYis7Zz9F4Bb0HCsGIipfd1cOY7Ho9WAWETEY0qS+5doG5hxxph97yYPenQRq6EaQAiZZLcbwfa8rAHt41jQCSja4qKB5XxyLSgW7gCTnkg3wGgiUXTi0lzdG9JsC8WUGU88n05U5fDn4rqG4dAYP+oUuo5keaVJgrXhj2w6aOS3voxMPnfZfvGODwqd7zlvdT3aC9N3NaYjm8kxCSt57N7tOQSufIZA8I48w/TbStsz3jV//XFxitnXmTS6xGVf63i9+I+bJL/k9oYn0I3xOPwIQVQICkdyEYpKwJ/89PawS4neuy3os0rCE71dosBARhgPPd6CcNpGoQVteXeT+d+OjI4/h/8/DljuIlRYl5UHQwKPFkzmbmnEpRLLfSif+pBO1vKLxYEXYko+06MmiqDWCNidgPFsq573S0Bc+oULolx47D+p/+ohpPt4PXQaftgDW/qjArXo2CXD9S5SGie9N6VWtlLQPs+Ats9dltGpF0QWt9Kqwz6dc9Ir5Z9J7UTl2+8Y6s3HUA1uNhfvZ2kfnJImi02fwHibSMxuChSMy32AfidRC0M5R4DGGdFVJc4qcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhQWm9CMmM4U0dBdFNaNTlyWUl0dlF6KzZWTHBsdUJSdlhHVHJzVmxhTDBl?=
 =?utf-8?B?S2MzL3F1UG5SdDc2QWp0UkRYTWViRElNRGgxNjczNHhGREFPSXdhVTVFTFBx?=
 =?utf-8?B?N0syZ2ZqZVZwL1M3VWpLcW5TckM4bFBQcTFDVWRFSnpJQmtkWWYvN2tMbmsw?=
 =?utf-8?B?cDQ2UlZhSHNVRW9wWTNwOHVnSGlPOFV6a3J1WmMyU2JWeUR0WnFTT2c3UnBB?=
 =?utf-8?B?b205MEd3ckxwb2hyQWZwSlhtbGhUYWZvSFF5N2FnU3VtYXNuYjkwK1pmeE5m?=
 =?utf-8?B?L21iOXN1emZmTGRhbndLaDdrcVAzLzkvVlQ3dWt4QUg3YjB4T0lwMmVjZFQ4?=
 =?utf-8?B?dVJrQi9QWnR3dUo3NVFzV2NTeElOdzhKRGlnTnVUOVlURmxDN016eTErWWhM?=
 =?utf-8?B?Yml5bmIwc3FNaWxIbkJ5bUdPZTJ4RkhJeEhuY1AwcmxpNlJGK3J6TndzbVVo?=
 =?utf-8?B?b3hqRGhXZ0k4STQyUVBJK2lkd1ZVVzRHSjAxV05uSnkxZmJFck5ZTkFkbWhF?=
 =?utf-8?B?MlJzSGZxdFdXOFJHOER6MXhCclJKYVJYdm5DNFgyKzlkSjlRU3hoQmYyRi9U?=
 =?utf-8?B?czFsWEZpdHpMT2IvTXBhNXdWU1lUNmpYTVNzM3ZnbkprZFpFNjFpdVlnOHpY?=
 =?utf-8?B?V25kd0xDaTZJbG1nR0lTY2p2c21sblAwY0hRelZlb3Z5T0lrb09VbElqRlpN?=
 =?utf-8?B?dWdlYXd4N2IzN081elpGUE5nTEpuUHZuSnBkbk9yS0c4b1VObi83bEN4V2JY?=
 =?utf-8?B?bEVVWjJEaCtnUVZzOEczU29yOUlTdUt4aTJGeGpLQlhnUG1mV2FUZTh1MHlr?=
 =?utf-8?B?QXAydEQ3VUhnUTBJUGNnaTNyc2VZWWxPbDdHcy9zMWdzK2toUVZtT3Q2azdP?=
 =?utf-8?B?U0NOVURJdXoweWduN1dUSS9uRUkwc2dLRUM3MWNrOW9TWmlJZTdtb2NoWi90?=
 =?utf-8?B?dUt4VlRkYjJaRFZ0RGp3TitoRzduZFJMUVJ2ZjdCNHMvRk9PZy81S2JBM3Fu?=
 =?utf-8?B?R1lSY0p1WjJEaXZHR1RzR3B4R2VIYnl6dUcrWTVUelVYVVZGL1F4Q0RUZSt4?=
 =?utf-8?B?U1VicDlyZ1cxMEpHWmc0Wi9CRkRFZU9pK3Z5UnZrRXhkMW4xQ0NRdklZM3Bz?=
 =?utf-8?B?cjBmaXJod3kwWHBHZ1dSZFJyajlqaEFIN016MFF2TlBuaXJhZlNhenVYYXFH?=
 =?utf-8?B?RVVhYThDZVI1TGlHSGZvanpNbTdhZlFtVmhoem5WTHU2S3FQTDIwRHdBbUY5?=
 =?utf-8?B?R2xYQkgvSlptSHFJWmJMRVV4ME1rV2FzUjBNUStJN0k0UG9pSFZEWUFELzN4?=
 =?utf-8?B?bjN6Mmo4cjlYcW1LSkpWS2xOYStIYjBLNzdsUzl1UEYrOElWZzQ1UE1wZE9X?=
 =?utf-8?B?OUhIcXpKMTNZdjcrK0xRQ0kvQ3JVQmZXcWlqVlBrcElHdXRueXptNVhvYmF2?=
 =?utf-8?B?Q0pRbUR2L1l5ZlZIQmRSdjZSdWduNjExRS82MVl1TzVVcEJ5Tld4TnYxSUJJ?=
 =?utf-8?B?K0RycyswYWRDRk9mV1dzdktIME1NUFFxbGZzNjFQa2dwcHFmRURvd3d1N2xL?=
 =?utf-8?B?ZzQ5ZW15R3AvMTBlOEo0LzByOXRraFpBQTNDU0RvRkFvbEhtMmpnLysvakQ0?=
 =?utf-8?B?ZG4xRXVIY3Jxc2FvK05FcVdNbFRxNyt3T1h2d3hGM2VRSGkzU29FajRzcnVn?=
 =?utf-8?B?alJ6djZTUWtwREhhWG5XMWRxNFo0aytQM01OMGJqVElPWi9zQ1dyTjB3RURF?=
 =?utf-8?B?VUJOYmV1Nis2UzJJT3ArR1hzQy83OTNWZVQzOU1ReGMrWWVkdFR2S3huS3VF?=
 =?utf-8?B?VjZKUnAvcnJLVlVuNHJhVDVrejUxWTBncXBDbXVDNVJoWjhVUGlCTkJzL1VR?=
 =?utf-8?B?SXdwRzBqVlFwL0Rvb3VNdWtFb1ZyWXZiMlk1RTZqeGk5Z3FaVGJCeTZ1Y044?=
 =?utf-8?B?K1EyY1FscGt1VFdyekhkSG52aGdkLzdXVHErMWhqQmhMa2NKN3F0WG5heE1s?=
 =?utf-8?B?cjgyYS9xUHFWVWoxSUJwcGQ1dWlVdWJNVml2TVRub0lZTGh2MGNvdnUwaEFa?=
 =?utf-8?B?U29ESzdVV0lOcm1ycFRBOEhIZGtNSEIvc2xwWHh6aENzVGZCTFJZRUZZREdv?=
 =?utf-8?B?TW56NEZPb2U4RzE1N2h0TlpWa1ljK1hVZy9QSGpEWk1LcjNZaHQ5UFEvNngy?=
 =?utf-8?B?cjJ1Njl0RG1iWEp5eC9CS2xuL0ZqdnpyVVBnMTI3WU1MWnlsdEJyc25IUDhz?=
 =?utf-8?B?VTVZWkc5ZzdTZG8vUDdYNnI0TG1uTkFVZHQ5akpGVG1ORisvWk5lUVN6TTNR?=
 =?utf-8?B?amY4NGVnWEpadzg1RWtmSnlsTG02YUNHK2puaENyeWVpaG5aaUhIUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b647441c-4aab-435b-fb29-08ded1074c58
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:10:41.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydsx3Vywvr7EB5UiGCdLrOZbDwrJ3xcch3b9x8dzZdj688OP0eiHCiL4ycj7ycK0BFK9JvQ2coPGF+XAu4M/V4ajIGRz4bB0kQl+JoUrbjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Hi Andreas,

On 6/20/26 12:08 AM, Andreas Zdziarstek wrote:
> [You don't often get email from andreas.zdziarstek@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> I experimented with the Synopsys DesignWare watchdog on an Odroid-M1S
> (RK3566). On current master, the watchdog is present in device-tree.
> After activating the relevant options in .config, U-Boot tried probing
> it but failed, aborting at a failing clk_enable(). Current next branch
> already has a patch for that in the driver (d62801d09441) and with that
> wdt query and servicing works.
> 
> However, a timeout or wdt expire causes a hung SoC. There are two
> possible "global resets" the watchdog may trigger, set in the CRU
> registers, as per the TRM. Default is the "second" reset.
> 
> Unfortunately, the TRM is rather tight-lipped about what each one really
> does. Per experimentation: Setting it to the "first" global reset fixes

As per TRM (2.8.4 Global Software Reset):

"""
glb_srstn_1 resets almost all logic except some registers just 
supporting hardware reset.
glb_srstn_2 resets almost all logic except GRFs and GPIOs.
"""

which is similarly worded in PX30 TRM for example.

> the hang and makes the watchdog work as expected in U-Boot. This is the
> first patch. As the PX30 does the same thing in its arch_cpu_init(), I
> believe this to be the way to go but I am curious to hear if anybody has
> more technical insight on this.
> 

I'm not sure there's much more we can know (would debugging this with 
JTAG help? I've never used it so don't know). But it's been a pain point 
on various Rockchip SoCs already, I'm quite surprised the default is 
still global reset 1 and not global reset 2.

Cheers,
Quentin
