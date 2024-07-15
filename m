Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4F3C3DA45
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 08:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF4687D87;
	Mon, 15 Jul 2024 10:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TEyeGeZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BAD87EFA; Mon, 15 Jul 2024 10:16:49 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A3C85B66
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URcf3g0Nl2UEtSaBrhEUhHSIftPEg/2ZxH06V2spcAOssxdiiOAfbiMhuOER/6NXXcH6mcMSIOKPNfAxBXslLB9XUEgXPClURMfGa96y8vjSHeDEbu+XNtyUiymLvSfTpP9WKISjJ9IoM+Mt9AFmumFZp+G7zVzTV+MYvX0adaDpOVPDj6y65xwDZ04iBFEx0gPweSTvJLVytT+RKsNv8/dkSuuy2fJU4yLRGrw90peG6r220KAfpY1pgUPbYkFVDjSyhXRBOl8iIML6HQPKkZ3UNJjyXxK6VI4f03cuG7dhwPeFDSPdZPABCSNNjYVlEsU2hsIKcWMYqBfoBmwvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1mPOPWv1K4bYajchrZfY4o75xTcch+FZUpznqVYPH0=;
 b=x9EVXSbWOagvqInSuoqKztb2INiCbO0rAB3ptYVjtS8M+ugpVycn3DzB10YJiMhtZJp3ZC4NdjJWz9aALpYbdrwMaOkYGBQQfSeCz8ByJc6eUR3c11DerDnnfGQV4PB74GpdP10MMFnjntiovhPKtMiHP2fpAh6xZ9Sqk+pVE/wIhG0iNrkyXGrdPm2FPTTWE8Wf5+5viLnWZEX2usC3ecV0/j0DQG/ZCD0fyn5wKRoxoq9dqv1XxN+xSSTNAocAetG/hqU0i4pkG0X/GiJJILtcsZM1hkKFq1DGSAvWMm2jFH1kIRdOdZtGhlj2H3LQ31l3Gdky+yJ5wIIQ3Uovqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1mPOPWv1K4bYajchrZfY4o75xTcch+FZUpznqVYPH0=;
 b=TEyeGeZ22Tba1H0JIhcdoNUYcqkOU9t/LQgSL9ta05zb22a0Q8mC4DBQFZd8+QMqrZAmdFIVuw/Rh3H1gzDO3mXer6iDs9kVIBNOFnPic2ubqKf683SNIqUpHPCoUnfgPwmgcbAqtFSe+B07wwWjJjdmWHf4Y5tlCwPUaVAxaZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 08:16:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 08:16:45 +0000
Message-ID: <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
Date: Mon, 15 Jul 2024 10:16:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240714194948.1271135-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 35515194-ec79-453d-5f61-08dca4a67724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjRjUHhpNE9mYUxOYVFQZTYxditONldCUWFLS2lrTEU5NVdWRk5RVVBKSnlI?=
 =?utf-8?B?QnVQS1YxaGV3L01DNTBONUsxMWFJSFhRQ1pWdTU1b2FydVIwTk1VRWNyaFlF?=
 =?utf-8?B?Y25mU2ZlQUNIczkvcHhaL2ltUlhJeGtraGNJWVJ5cHBlSytqQXFtZXUxT1ZV?=
 =?utf-8?B?MitWcXljN1BuS082UE5vTGE1b2xoOGsvUm41Rm5XR1ZHU0FCdlduRDUyVjhu?=
 =?utf-8?B?YUNrSWZyaWJ0MXR4bGNiSnJLRWkrYThHajJ3eXlQc2NxQWF0YUUyOGFIL3BE?=
 =?utf-8?B?alI2anRJb0RjMUI2YUFKME8wU2RDZzcrRVBkK0RyZG9YRTRvQkhzNHN3UkVW?=
 =?utf-8?B?dk9lY29SZEZyb085TERwNm9ZYkUzYUJuSUdWMlBQdTRsVFNtc3FzZ05PNys2?=
 =?utf-8?B?SklPNmN6VS82eFdRcDlLaG0xL3Z5LzlDRERmL21wUzB3cFFsZEpXK0R4dXFQ?=
 =?utf-8?B?L2N3bytSRUtVZDZYb3VveVl1T0pXOGlDTUFKaTJ5aTYwTFo0dEZnVFk5R0Zi?=
 =?utf-8?B?ZTR0cTArdHliVUQ1Rms5OVBoZkthWGcvSko2UFYrUzRwTEhVcE4yYlBJWlFo?=
 =?utf-8?B?eEY1a0YvTTRGQ29HZlZzUTFsOXFuYWFLbUdWdzdYZmVoeE4wTTlXaUNLam1U?=
 =?utf-8?B?dGk2YzZUS2JZN0NSbkFYUkRwb05IMHZHTUJ1SWgwNXE3K3RVL2REcDdtS1hI?=
 =?utf-8?B?ZGEwVW8vd3dqMkFmZEJoakdiY3JEU1JlUU9wWlhXN09yTWpQaGJEcXRTZ3h5?=
 =?utf-8?B?QmpJYlR2dUVBRXFxWTE1d2RIb3psbHJEZ0FoYUVZUHE1ZkJKQTdha2N6andG?=
 =?utf-8?B?RmpBYmo2UUJFcVVINk5mVm1lMDFKZzFpMVM5cWNOMG5wRkg3bnlvcDV6SHhk?=
 =?utf-8?B?ZmtqdWp4REoyUXhzL2pib3BNU1pUcjd6TXJyaXB6UHZ0Y1pEZ3VJVWlLNFRC?=
 =?utf-8?B?bTFjME9zQjVDTnhvMzlJTm9ZVmtROE1QOTZuZ3pzQU03Tkh2S3dTc0dhQkli?=
 =?utf-8?B?ZTRPQzBUS3VYSW90cjNiZ1FXUk00RW5hQS9GbzUwN1NNU010bncxUko2MHg2?=
 =?utf-8?B?OU1TaDgrejh0dS9CUmdNaUhmcEZnWVNUcnFDVjdTWEU0Y2V1VUR2ZWg0QkYz?=
 =?utf-8?B?SUNWb2Q0dng0cVZKa3RaQUFxcFFlOHN3MVBwcUZ2aEhJSXB1UytGNzVQV0tr?=
 =?utf-8?B?Y0lkZWpwS3hNb2NFVGdQZGt6YWc4MWNML1ZlS1l5bE5QQUs1OWNLS0dhT3Qv?=
 =?utf-8?B?dThDVWJXY1ZLQndCSFJ4YW91dmFwbjV0RXFvYTNubER4dHFGbm8xRVlyT2Er?=
 =?utf-8?B?QStTQmtqd2tvdUdpUUhyakRSenQ5cnBia0o5VkhBREphdERYeDhUWUhhdEgx?=
 =?utf-8?B?ZjhUM3pRNEFDWldQVjF6QlluU2JIbWhveFV4cWJ0eU5wT1FpUHlIdWZBaWdN?=
 =?utf-8?B?RCtlZG9MWnRkblVOWEI3b2R4NXhSNUpEaHVxSXVmRERpeExFbXZ4UVlTNFRw?=
 =?utf-8?B?ejRpcFJQc2RXUm83YnJaY1pSMWMzL1NVZVJUSlJpdERDdDVmNTF6UGNtMVNs?=
 =?utf-8?B?dnp1SE9qb1FaWXRNcEc3MDhiL2p5aENZcmYyUlhTcWZnV0pVV3lRdWxWVFBS?=
 =?utf-8?B?WGc5d0lpNENUbzNPQkVvdFkwZXMvMUlxUWRPSTZ2bnhpZFZwOE9XK3Y1bnZL?=
 =?utf-8?B?UUUveFVjWlZBWmo4OU03REtSQ3VMOE1yQ1BGMDlyWTNnZjltcVdaYUUwWW5o?=
 =?utf-8?Q?NVqi3jcdduyxqGoOm4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2syUldjN1ZQZkRuVW5STjFWbzA1UkM5c2FOdHgyRjB0RUlSTWV6WElBWWpp?=
 =?utf-8?B?VUd4T3UzRHd2dkRUWFlrVHhnSFlWbmhrdDFYWmdJVE5xdmFiVHBESEwyTFll?=
 =?utf-8?B?a2lZQ2J0RkFicVdkY2s1STVYdTFuV3RFTi81M3dBNEVKMmZSY1gzejdiVTF4?=
 =?utf-8?B?NFQ1VDVSOEF0bUMrYXE4MkdoTERDVThqbzBRb1ZaNXpwSU5JeHJ5bDhDemtD?=
 =?utf-8?B?OGJ4OERDZi9jNUhQNXlJWDdXaUpHSm13aGJDSnVPYk1CcWczL21YY3V5eVk3?=
 =?utf-8?B?Q1BvSXhXelhEWWtwVGpURm00eDlBTmZlblUyZ0t1OU9DN09Pa1dodjEwajRv?=
 =?utf-8?B?T0MxQzJMK3FxdXg1Q1NUZVpEeEFZN1hjYU1oUjFyVmxuWXU2dFFiMmdyS3hY?=
 =?utf-8?B?K0JmMmZiV2lvL2VIZk1Kb2xwZzRmT0o5Yk1YMm5vRzVXVkp4N3FSZzNIZUJL?=
 =?utf-8?B?SFh6WEhDS2xyaEF6VWZNdjEwTVhQVVFGd3lnSXcxcnFIa1BMd2NmcFpsVDBP?=
 =?utf-8?B?dmlQSjlEUzd2eHpmMnRONGg1QUJZVUgrNHRvdXU3clNhKzFYYVVoNC9aM1k3?=
 =?utf-8?B?bzRBYzArbXFzd20rcEZPRTJoWDduWllKdUV5elJNb2w4MDF2dk9nZHVWaU5j?=
 =?utf-8?B?czJZYkEwSjZEL1loMXZmNysvY3JObGt3NTdxeDYzUFJuTlM1QWxMK2NwSmoz?=
 =?utf-8?B?Y1VMeUtiOUQxaU55NEhlTkh1clZMT3ErdFFaS1JRYnpxaGhZd09CMnJ4MDlm?=
 =?utf-8?B?MEwwOWNuNXZ5YVUzblJRYjFUdUl4N29NajRVS0tYR0VuZ3dJbXhqbk4vSVZa?=
 =?utf-8?B?R0tDYmU3dURGN2c5NDdXYVMvLzNZRnpDbWREWHFUZE9Wb3RubnVYN1gxUzha?=
 =?utf-8?B?dnJWRkNuMUtYWmpaMytQekdsR0g4UmVRNGs0TGVRUURzNDZ4VVVKZldZK0F1?=
 =?utf-8?B?MzZmNHV3TjVtUzBUZHM0QzJHWmMwL2tVL3hpSUtsU0xIUW42b3NGRWlRbDZm?=
 =?utf-8?B?bnZIVDJ3SzVzZUtBaE5Ic09RUCs5T1B0S2hEVTQ1dEtoNmVFWDcwMkJZeG9I?=
 =?utf-8?B?SXFWc0xYb21IK1JBdUo5WlZQT3V6Nk1qMUZQV0x1eTVCeklCZ2g5WGR4bkZp?=
 =?utf-8?B?Z0JGdFpycHhmMjAxR2MvNHpTelZQalBqcXVpcEtaZGIvWW1iWW9HM3ZpSFVG?=
 =?utf-8?B?SlJudnN3QVB1NWxLYXFhMTJKa083SGh3UWpLdFNwamFsdUhxNXY0ejNIWGdr?=
 =?utf-8?B?ekUzbEtSdmUvU09rWkNVMFBVamE4NHYzMEV2ZTV3MGU0OTAzZlpyMDU0ckh4?=
 =?utf-8?B?UG5uQWl1cUJaQTRUZFlPZ01ZZkJKK09aUzZUZG4xLzlvSFk1ckU2MFpZeWVP?=
 =?utf-8?B?V2FJZUwwTkhnOUJsbWtXTS9MY2UyTGdyaERUWWZ4dHFxZ1N4bWE4djlQSWtU?=
 =?utf-8?B?dlYvREF1aUx4bjB4U2RGeWxSTGJrL08zSDNjZUpPS3JkcEJZSEx2V0dqT2hG?=
 =?utf-8?B?cjNrenY5ZERWRE11NXRpNy9pVGpwVXZEb0cwUGdWYnduTXNYYUlhTVBIZWhh?=
 =?utf-8?B?WDJ4VnhIaWhwVUNJM3psdlRQRVJ1cjIxNWlxc2RnbGhLTHVXb040TG05N0xG?=
 =?utf-8?B?ZVJjTlA3a2s4d0NYWVFBYVpvcmx5WmRHZ3FqQkJjb0VvcG51MXA5cWlNUW1V?=
 =?utf-8?B?K1NER1paNmQycmdXTWhXenFqYndFVjhFZXJsRThkdjg2QlZmYVRzbnFrNXg0?=
 =?utf-8?B?eXpjTXJicG5Fc0tiTW5FenhmZjVxUlRYWDZxYzdKM1JKRzlWM2tHR0RRSEU5?=
 =?utf-8?B?Vk5CZUk3SzB5b3pwYWFCdmtDUElNY0VkbGFuNzUyR21waWxQdTJVanlCSHBD?=
 =?utf-8?B?WitOTGE2cHBoNlVDSStpNEdzZS9mS2xqb1BvdE9PZ3RXSC9FNzI0VXcyZTlj?=
 =?utf-8?B?SnFuOFJSVzY1ajArZ2xseXlxNUJmUzJZYlFJUXR3aGVTZlVGR0oySS9EbHg1?=
 =?utf-8?B?Sjc4WjRHZnFYUmdzamM1aTV4dEQ2U3o0dDhadmJxdVcxem1JYmY5eWgxRUsw?=
 =?utf-8?B?bTJMbFJ0dlVXb3k1Y3pZZC81WHZSUWVSZFMwaTl1aEk1M1grVTZnUEdRYjBK?=
 =?utf-8?B?WlpYWTc4eGQyZ2JXNUFIQ1pUZ1ZiRm1zZXFabW9DaGxtdjJ6amprME5xYjB2?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35515194-ec79-453d-5f61-08dca4a67724
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 08:16:45.1286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvnhGnj7NntSQ3Adaf0OHyGULcjVwDr7gVJN7OixWs4kd+COJDCIzg48r+/ugTSTLCIJHK5Birsq+mFPPqi0Ymdogo3nffI/jvto1g99KxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434
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

Hi Caleb,

On 7/14/24 9:49 PM, Caleb Connolly wrote:
> We don't have audio support in U-Boot, but we do have boot menus. Add an
> option to re-map the volume and power buttons to up/down/enter so that
> in situations where these are the only available buttons (such as on
> mobile phones) it's still possible to navigate menus built in U-Boot or
> an external EFI app like GRUB or systemd-boot.
> 

Are those event codes properly defined in the DT already?

e.g. 
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts#L31

If so, what prevents us from simply patching the U-Boot DT to change 
that code? No additional code required anywhere, no need to maintain a 
list of mapping, etc...

If that isn't possible, .........

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: u-boot-qcom@groups.io
> ---
>   drivers/button/Kconfig         | 11 +++++++++++
>   drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
> index 3918b05ae03e..6cae16fcc8bf 100644
> --- a/drivers/button/Kconfig
> +++ b/drivers/button/Kconfig
> @@ -8,8 +8,19 @@ config BUTTON
>   	  U-Boot provides a uclass API to implement this feature. Button drivers
>   	  can provide access to board-specific buttons. Use of the device tree
>   	  for configuration is encouraged.
>   
> +config BUTTON_REMAP_PHONE_KEYS
> +	bool "Remap phone keys for navigation"
> +	depends on BUTTON
> +	help
> +	  Enable remapping of phone keys to navigation keys. This is useful for
> +	  devices with phone keys that are not used in U-Boot. The phone keys
> +	  are remapped to the following navigation keys:
> +	  - Volume up: Up
> +	  - Volume down: Down
> +	  - Power: Enter
> +
>   config BUTTON_ADC
>   	bool "Button adc"
>   	depends on BUTTON
>   	depends on ADC
> diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
> index cda243389df3..729983d58701 100644
> --- a/drivers/button/button-uclass.c
> +++ b/drivers/button/button-uclass.c
> @@ -9,8 +9,9 @@
>   
>   #include <button.h>
>   #include <dm.h>
>   #include <dm/uclass-internal.h>
> +#include <dt-bindings/input/linux-event-codes.h>
>   
>   int button_get_by_label(const char *label, struct udevice **devp)
>   {
>   	struct udevice *dev;
> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct udevice *dev)
>   
>   	return ops->get_state(dev);
>   }
>   
> +static int button_remap_phone_keys(int code)
> +{
> +	switch (code) {
> +	case KEY_VOLUMEUP:
> +		return KEY_UP;
> +	case KEY_VOLUMEDOWN:
> +		return KEY_DOWN;
> +	case KEY_POWER:
> +		return KEY_ENTER;
> +	default:
> +		return code;
> +	}
> +}
> +

....... I suggest to make this a weak function that can be overridden by 
boards (should it maybe be only defined in boards C file?) so that it's 
easy for people to come up with their own mapping without having to deal 
with two people/the maintainer disagreeing with what should be the one 
and true mapping for that key.

Cheers,
Quentin
