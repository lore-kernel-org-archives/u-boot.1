Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C054C52D70
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 15:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050E688813;
	Tue,  6 Aug 2024 17:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J607sLqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5098882F; Tue,  6 Aug 2024 17:13:10 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B65887B4
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 17:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG84z++yfI/x3KbWduRHVL+kgPDqWn6oVJSheIfmUtDrODaRsePxMwoH26b8pqwshbzHBw5+PFPPczOp2hJuwyXcTk3kHq0PTItJB9E6L5HdYC6AlmXw674iKMrIPxvKfx3z/cLBuhEJ6DZTJIOGZPOjatu/6zMZMNicfpO9S0VRvicoyj3cXQXmKGmFCnuc7qGt1eBf1HS7ueUrBl3xd90FtbDd6+sLLZZEO7+VnOs7CKepFVuPmdG/su+I4MzyHhsdpQwdHmg1dOU6gSIz/7G3htu8lvg8R8Vb971enVGdArkIh7D2pkDxEHl7xpVN3r+zyP747mD7MgBatyTuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtNeMJzSUXDo4vsQAbX4+rNmctOPmwU5r66uaf3UgMI=;
 b=Sut0ZkFuaUbo6esKhmo6W/35W+PyjMQn6kSr7ZDoL/cxI8feplBLnpR9j0cQeLLEDhqwGpfwoBKpu949TVoZq6NXm64IOJ41R60M/qIdI7KUipUCzqMBm+Ck5hxuFwtL0MpQnHUWyxiw+8ftxu0714UeYGIgTcbWCV/DTAw8phDwqr1NcdEekjzUeZ8yDJ07d3vJLo+BKoEbIq+11I3+xYH8ySFhowzbQBkAbf7y/eXc/vZoyBlCdINWI/WtCZCoKb466hrZ78GV+8sAz6ZSlh1sJIl++NCCBCE/1nDOs5CwRhvvXpcWhG6+MRw1Gph+kPn+XofG+Odb+7RR7gM8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtNeMJzSUXDo4vsQAbX4+rNmctOPmwU5r66uaf3UgMI=;
 b=J607sLqsHvK4itejDHhKMWlBOyqSODA6/p9XPY/6S+zc769T2IGlDrYzdgv/lVXjfilj37lXACum4BgEkpMQcG10XTXOqSpLHxcTPjEcWBobKtI1u/kyICZ278DPj/R+MAAeFkkHQB5qWAPQwvwmt2kgfVLAZpso+NZeGcuIc3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 15:13:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 15:13:00 +0000
Message-ID: <d80662f8-2672-4640-b484-5ccb93203376@cherry.de>
Date: Tue, 6 Aug 2024 17:12:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] pinctrl: rockchip: Use
 syscon_regmap_lookup_by_phandle()
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::19)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e20da5b-3497-4d84-75c0-08dcb62a42e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFJqUnl6bmhHTllhc1RrSnZFNU01SXNZL0ZSanhuNFB5YVZ2TmdlNTRSa3Nr?=
 =?utf-8?B?KzErZXcxV0hxZUtqd1Z2Mm1sdnZSUFRPTXZ0eHQ5dHFxempybnpIRjJaR0RS?=
 =?utf-8?B?TEhzS0pML0FBVERkYSs5OGlRTVdydTdYTDl5clRicEt3M09uc0I5U3RMK0NV?=
 =?utf-8?B?OU9Cd1FEdU5DR1RtOXFiakNaQmVDUmRzd3Ewa3NJNHgydHdrcjExZzlFK09F?=
 =?utf-8?B?S3M5MlppRVRzS01WRkx0K2dSNXEzUGZOYXZrK0hEK01FdXBDRmROTFdydHZ5?=
 =?utf-8?B?M0JFVnZEZDFSUTRYeDFXY2hOSXMrT0pUUzUrN1M0dWhmMkJJbVZObWl0VFZE?=
 =?utf-8?B?VWVRUy9JbS8zRUt2ZW1KK09pWDFycVFIT2FjQnFHWWlmYXdpRVBQRURIY1Ew?=
 =?utf-8?B?SmgvV0ZBcS91MGhKQnBnd2lia0h4UkpPSTFWcHNZbUU3ZlcwMTFmTk11L21R?=
 =?utf-8?B?VVkyTXNrQk03NWxUMU5jWHFnbHo2WWlMYVRlTTNiS2lhVENSUXFBNGlERzI1?=
 =?utf-8?B?NG54U0pRRmZQSnR6aGJBZk5nVG95M1hWNWljZEVIODl2bUpiZmJwUWJJVjVZ?=
 =?utf-8?B?N01oMDlBN29XWHVlWSszQldROHVkUCszZHV1RFgyYW1LeHFTckdvaDN1bC9E?=
 =?utf-8?B?Qm8rN3g4MzUyQ05LSWNwVDZnbm9OaVN2ckJydTl3K0NESlQ5ZVQ4R2x5c00v?=
 =?utf-8?B?Q0JKWCtaNzY0RXpqZkJ3bms4VlpUSmFDemxiOXh3QVVzMW5ObC9ycmhWdVgz?=
 =?utf-8?B?WDBCQjIxeHU3RERsUm1NRVZZd3VWUWgrcjZEeVIvbHRPVTBQY2h2REVEWEsv?=
 =?utf-8?B?OXl6RnEvWkU1c1ppSHpUcEVEL1cvbEFRWHN4TWZ2czFpS1dMdGFrZTRhYjFi?=
 =?utf-8?B?L09PY2cvQWQ5bi84cjR2aWpaTC81bCthQ2FSUG1tdWY4RFBia3l2V1p3VURF?=
 =?utf-8?B?RURWSFdCVlBTbGxReUpOcEhrZzEvZ3VIaUNkNXlyMEtvdTZBRWd5SDA4bGlE?=
 =?utf-8?B?OTN5QU90dU1zbHBucVg0b2Z4UWVtbDNrbVNrZ2JldUxvVHhmTlE0ZkxGSUpK?=
 =?utf-8?B?TS91RlpSZFlCZFNJUnVCQ3g1Q01iVGp3NG8wdE85Y3JROXpHRTRheEo0OGE1?=
 =?utf-8?B?ZDB2NHFTYnRoN1JjMFBZTDdPMnNDdmVjRDIxMFBkSDVkczU5VmJDRnlVb0RZ?=
 =?utf-8?B?NllhL2NvT0FkNHNBbGphMDJ1QUV3NWc4bDB0MDJuVG5FSnpMWTdaN0RtY2pP?=
 =?utf-8?B?OHJBVXZqM3pBWEVuRjREVWxUZE5CaE15TGdGR0RMZlA4Q1doWHBQeDNXVlo2?=
 =?utf-8?B?ay93L0NaYTFrazlhVDdtMnkyRXJhNlkvWWJXbW90MHhCa3huY2ZURy9DQVhh?=
 =?utf-8?B?WGNtdmpYL0JLOFFyODRMS1BXMm9kNHJmc1dtTmo3ZERKZjRLdlBCWkkvQmto?=
 =?utf-8?B?WnpRMS9nK0JYRm1aK0lUNHVRSFY3bUtkRHFjblhhYUVNRnBrWWFaem05RXk4?=
 =?utf-8?B?SHBlZVFJOU5NSVR1WUtLRzkySkprbDJ3ai9Ub0h2WUFRZzJlZTJYdnVRaXd4?=
 =?utf-8?B?TlBtSjVxWm1adHl4bUpBUkhyRnlTL2t0S2J6N1FFa0RDK0R2MXovZmhzOUJ2?=
 =?utf-8?B?MDR3b3lPU3htSUFhcGkzWVlrcTdjNVVScUpSTUllMkI4bTJ1SGx5OFpvWm1W?=
 =?utf-8?B?dUVSNmp1T3IzWlBudXlaYzg4eDJXN2Rud3J2V0svNkxiVEdFZTllMllDSnNo?=
 =?utf-8?B?M010cC9FSy82aGJmL2I5Q1dPNkVXK1BHdmpXVmVyOHVSVEhXaWFzeFlqVUxV?=
 =?utf-8?B?Q2RTTVZZTnRpSWsweHFNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZDZ2F6Q3NqNzVMUU12UUcyN25JRHRUNzhQdGNiZE5PQi9RNkREL0JKVTRR?=
 =?utf-8?B?SnlJWXVrTmtjcjZkem9heEtYalBxeXY5QWFNL1hmeWdkQ3F4VGc0Mkt3a0Ni?=
 =?utf-8?B?eFFnWW5zWC8rQzVFSlRjRjRMU3Mwa0V1TEVCZXFBUUNqeWZZZnZWR1dITTZR?=
 =?utf-8?B?dWYvQzloWmxudWtqTWZkVVp6MU4rU2xIZVZkSkhtSEJ5VEI5T3hLa3lyVSt2?=
 =?utf-8?B?WWFYK241VWI4MDJockFFOHlzMlQ3NWlKWndpdmFPWGk0S3BVd3lXMmwyKzZV?=
 =?utf-8?B?V3NoTnFGb1VRTDdEdjVnWnpkcTJFQzUvNVVpeGdsekdTTXl1NWpPTGdGWGFw?=
 =?utf-8?B?cjlaZWRjSGo4K3FBenlkRytzTGZ3YUdRTmpGYU1YcS9sZVJiMkVLN2xGSzBQ?=
 =?utf-8?B?UTE4U1BoZWVtdDA0Ujd5b3diT0tDODRzdGdBdk44OEZubGpkcGZualVlUlRQ?=
 =?utf-8?B?UGVWc1l1QVlPaVlxMGwrMmUrK0w1R2N2K2t2ZzFmRHY4Z3JPSTZPOEZwOVpF?=
 =?utf-8?B?ZFRBQW13SllvQ09RbStqK05FTlRWdTBqK2Y1RFBqckRTenZlNTlMYUZJTFQw?=
 =?utf-8?B?V2JBVi9Hb1dqUXY5M0Q3blczOVRoSmpRaHJ6L0JpeEFhNER6OEZhRjdudkdl?=
 =?utf-8?B?bUFBMmpGUzZVcFpPMmw0Q2M5RXRwUEVNUnU3VXMraGNHYlhrd1lGSWNvTW9F?=
 =?utf-8?B?MTcyNHMvcGw5cUd5cDNxbzZCR05jaGQ2SkJ1Qm9ZbFpTcG1CQm5KSmtid2xG?=
 =?utf-8?B?bndrV0l4MFVBeUFYTVlTWGxqQk14b1FNbnNJT2V4dTB1RElIVG9BVGZEZE1Q?=
 =?utf-8?B?T0RCamNaV2NEVit2Sld0VTZRaWd0ZzBLVnF3Z3VXRHNPNHdIM0NLUldNL2s2?=
 =?utf-8?B?NVltUnZnSE5UTXJ1NTk3OFJJSTRDRjBHMkxvd3hibWZXN3NaOE92RmY4WFNZ?=
 =?utf-8?B?UFUzMVJNWGNPV09CM3RjdWNtdTkzSVFjZm8zZ09DRDRRSDBXWDJmT3VNTEUv?=
 =?utf-8?B?dzFENWxHVFptRTlaLzFmQnZkaHFkM05OSVJjek9haFF6U1NTUFM5bU04VGpT?=
 =?utf-8?B?VllkTnhheUxtc0lVeVFNN3ZFclc2dkFrakZyUWNIUVhCdmdmdnV4MHJLcWNw?=
 =?utf-8?B?T3ExMnQrdm9ZY3lxS3ZKM0ZsM0VoMy81cFhGYUh5WDVUQWNQdHkrSDUzVDAx?=
 =?utf-8?B?QUF2Q3R0LzJZL1RIVmJvWHNOdGVJckNHOEIvNXBMbmZKZ3pyL2tKbzNsc2Jt?=
 =?utf-8?B?ZnVLK3ZXZFlHRDVVaEtoWmd6bzEzZlBFQ2pkNHhVY24valhRSk1XNjY2R2J1?=
 =?utf-8?B?M0hKK2wwdnpCczArazRHbklwbEVmbzhEa1UwY3RTRUEzaUpKOUJkeDFBcFF6?=
 =?utf-8?B?OUN5WXZ1SUt5ZDFvUWw4TlF2R01hT0ZMVGgyTjBOcmRaY25BYncrdUtzNWc5?=
 =?utf-8?B?MVhVZnhCKytxSHVQRnVCdDhxdXlCeEhDVlRzNldVWDJvb3d4Uy9CUGlKVEty?=
 =?utf-8?B?QU0wZGpMa0VOYzh3NjlTcWNUOHRJYzYwVU5DUndheUF6ZjlBVGx2aWN1b2tN?=
 =?utf-8?B?Slp1eHkzV3lRYXJqaW52ZUt2MDhaYjNHdmlKcm5kSDljV0VrTGluc3JaSitO?=
 =?utf-8?B?VWJZRGJqSmpJblI5TVhWM2ppOExqN0hwb2hOWlRiVXplUlROSWVuaFNFVnU0?=
 =?utf-8?B?NktlbjZmOCtodjkvd2gxYjE5ZGxpbmhacnpuS1RIOVdmTitFNlpRWnRPcWxn?=
 =?utf-8?B?WC8wTmZXUU84dFgvTmN0dEpYVkEzWC9DN2pNQ1V2RUF3dk9oeHJCaUJoWDR3?=
 =?utf-8?B?bU94b3ZOcHpSTzBNNGdYRGM0QS9iRitsRFZBd2FsNUIzMURaTWJqQ2NESHlu?=
 =?utf-8?B?REJaY3NueW8rdjlUMEFDMFVFaUlDRGdlWVRiSlcxRTcwWHd0RTJhdnVNM2lt?=
 =?utf-8?B?NVM5ZjBNN3g0N2ZzSnplUm9kMVFPOGpBVFpUclJ3Qm1qL3IxU0dXV2ozWDB2?=
 =?utf-8?B?akRJejlYSlBoZnNNL29XWlZ5VWNOK29yUjhETzF1cy9Id2xBNlZQYjhLU0tV?=
 =?utf-8?B?Q3dwU2puRXhzaEZmeTIxOFRJTFluY3FoejlpcVBhdWJucTduZEFCWUd6eU44?=
 =?utf-8?B?RDA1c2pwYzEvRkdOOUFCZ2haUWtvRUozdjF5RXczcFkrM2ZKR3h0OXZNMnNw?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e20da5b-3497-4d84-75c0-08dcb62a42e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:13:00.8592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E43zB7l3usRwfmFFA7r2JlfSzr6O2WhleOS2JHY4pbVT1i+G6x04tFpgvg+5Eep7/2Mmnse50gyRVmtiZXTlm2TGDtmRYQexC4h2eEn11w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9426
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
> Use syscon_regmap_lookup_by_phandle() to simplify the code.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
