Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D2AC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 16:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04ED1811C1;
	Mon,  3 Mar 2025 17:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TLwtvS39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AF4811DF; Mon,  3 Mar 2025 17:25:10 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFDC811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 17:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXEeylGn+8eJqLpkiM2SBJtlmCwxaVfcPmzRqyYuRHb1v0TA9As9tsyT5ZHvRhO34+7NIhHMBezxCm+OXbGnW4kCiJqomX2eddiNr2IeZauiIdYfGqvW+K1HpwoMQ/kfyhwZpxy9SKiGN9e3p3Ys04NBuwxqR22JpfViJT0tHLwYHdRECgIjocTq7J1bWI/nZA9bZ7uFlu6prMUAlfZrUL5Arxzjh3aCSEGJW3CQdpXPlBcc+TYgz0jYBMQ55oSd91HtNqfekTdkWUM5IemFQzu3sGVBnLcsLMK+emPhDcCJdUuZUY4uL6ah9JEycW2ljVN7simatw8dDgTxre9jVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du5odTHTWt9xiNP//SafKSWPlce2b7/spB8TygvSd9s=;
 b=bs9Fn86T27Fl4e+VNlkcNUQ4+ye8AzLOlrxEbHLabuQzC0Yzra7H4c7H4MjvP9WtveQquxNr/gP7pjEYaRNzQIcHdFngMnio8plGckaBwfhpcmABN1hPbMztxGIDBB+Vf6rTbCUgq6DdcWPNYwgRQbc7cknXWhtdg1OEqJ3J45K7VxGTHgVCe9JPi8eHYK0FkFTc6v+F/PfvYkZbgPeBno1Fl70vhoTjKGEQIAN964La3EXlZMMNtJDvdwyccW//ZVUPXtJM+9erJkpS6nWCW4uRsuy2oV4/azShubKFELK25UCzFLfMVd2JgF7pBbheKldkgPwet2crCj80myerWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du5odTHTWt9xiNP//SafKSWPlce2b7/spB8TygvSd9s=;
 b=TLwtvS39eaewOvAb2b4NxB8ZqLF6eL6Mjkc0j6q7GJNG6F8g0FYC2Swo0v7Lcu4MbrSHzzngCzYcHjvPBwkFQZverXFjPhRG7Z8P3cqfASNB6j1jXx7DjzUeJnNgpMFCJ/oycok/cpwBBTifYIPePukc5nurvCuIP607b3UlPQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9098.eurprd04.prod.outlook.com (2603:10a6:10:2f1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:25:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:25:05 +0000
Message-ID: <ef383185-68dd-444a-9e95-6a7c64ff0d80@cherry.de>
Date: Mon, 3 Mar 2025 17:25:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: ecdsa: fix prevent memory leak in
 ecdsa_add_verify_data
To: Anton Moryakov <ant.v.moryakov@gmail.com>, u-boot@lists.denx.de
References: <20250225134959.33438-1-ant.v.moryakov@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250225134959.33438-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7da0cf-05b7-4855-d67c-08dd5a6ff4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2JPT05LTkR1a2g4UUtwME9CQTlxV1ZTNEZ4Mmc3S3ZBT0VkWnZtcldpODJK?=
 =?utf-8?B?R0NiK3dhdngxcGh1dW8xQVgzcGlNaHQ2aHBUVlZVdzJJYWtMTTNiZzNwbFpW?=
 =?utf-8?B?V0lqVDAzOHVXYkZma202RHdqSmdLaHZ2Z09LL1lObXU3S0prSG1TeHVFajRY?=
 =?utf-8?B?N2E1bU9PemY4NFdka0ZLWjhZQysvb2RSQmhwYUpZUCtXQSt4TzFxeDdWSHFh?=
 =?utf-8?B?SitucEo2WlByeUlpRUV3c2taMGYxMW1YQ0xRaTE4UEwxbVpCWTZRcGxNaSt2?=
 =?utf-8?B?T05GOXZEaVN4aUV4djU0R05nY3V3TXcrTVMwSllaRTZ6TlhVc080eVIrVmVt?=
 =?utf-8?B?YkszaGFpYUhWRzRrNi9hd1hFOHFldDY2d0greTNtVTIybnY1ajdVdzFTVk9p?=
 =?utf-8?B?T2R1ZEZXdEFYSUxUT0RLZGk5eS9hQktvQW5WdGtIdDRDNU1ldlpRVUhRbHBn?=
 =?utf-8?B?Y2RCRlJaVVlwTEZ4QVUwZytHVGRDUSs1K1hwVzRPYm55WDkyWnAvRUNRb3Mr?=
 =?utf-8?B?TGRldWNrLzdpU2hUVGFaMnVneWhBcG5PbndWSVd5RGZVVFZLZXk0eWhwUUZk?=
 =?utf-8?B?N1ZNYjdDMFZjczFISlY3cHAvKzFjeEozZi91blJBTlk4MXVhUFllMUgzWnEy?=
 =?utf-8?B?Q3h1SVh1N080TGNIcGFiYjl2UXRObjYzVlVSblN6eEx0dDB6S1ZhU01xU2pa?=
 =?utf-8?B?Z1NlMnpCbTNUVzA0RWZBY0pvdnJpdmRkODIvQk9VYmdqV0RTU1FPUEZ0Znp3?=
 =?utf-8?B?UmwwdFJZRUNJRW5OMm83ZGtBZjRDS3NsNDRUSzdORDlEL0tQVENwSVRjMUtp?=
 =?utf-8?B?aUh3SUFYTTJYZWlQUnhjVHR6N25wTStkTDZTaWRuVlQ0UUorQ2hxR3M3bkhl?=
 =?utf-8?B?STZTeFZmVmkwZ1o4SFk4YkhycDJsNnowdzcrY2NKUHVUVUJLV2RDR2lQZGc2?=
 =?utf-8?B?bFRIalM0TjNEWTNCS1Rhd1hURnJ3R1VXK2U2TDlSOWtQUmNiODFBZU94ZG5j?=
 =?utf-8?B?QTBOY28xU2dKMHd2RVBPMHZMUEFwWVlqSWZNbmJ2ZzhBTXl0bWZuL2RLY1g0?=
 =?utf-8?B?b3JUYnVuOTEzWDVrcEppNEVHVmNTZURHbnh6TFp3c3hPbE1wamhRTHMwbjdG?=
 =?utf-8?B?emtsYTFUNGVEZDBPVUVWdTVTbkQ2OEkveXlsSEREL1JjS2ZuMVVoY0xQYmFv?=
 =?utf-8?B?allSMHNydzdkL0VyS050Ynp1VlB3T2pGOUZpa3ZsK2NaOUhJY2orMlhWeG9G?=
 =?utf-8?B?Yy9semNoRjR3QWVOVzM5T2FLSThMVHFpYXlsSmQ0Y0Vhek5uazRCU3psdCtX?=
 =?utf-8?B?d0xyRVJ4TGFHMWJ1WE1ERHM5Q2VzSHF4NTFqTFNVeGFUNEM3ZjdSVFVRTEpa?=
 =?utf-8?B?Z29ZMCtkNTZCMGZqQlRLbTJoOTdzbVg5Yk1SVjYrS3U1VjdQdHpYcFhTUTNN?=
 =?utf-8?B?V2dOaEZHUXhLaXJWSWt3cCtXQUdCaU96b1RnUTJIZWhWL2lyY05WREF6TnJr?=
 =?utf-8?B?VnVuelNmTElHUkxKU2pwM1hYdkxBQXc5dU1QbHRMVDJwYXdDS3RGNGJRN0t5?=
 =?utf-8?B?eG11eDNXQTlIZWFuRWNrUnJJVGdpY2lTeFRuNXJjV3dzbWVvMjBraWp2WEU1?=
 =?utf-8?B?aXZnbWRDc0VVM0lUOEVyd2RGeFFib3ZCWnNVZ0tCR2d5aXZlYXF5anNMRk9N?=
 =?utf-8?B?SnNkRlZSYVVpUE5MaEFVV2VyUUFuWGMxbFErbmtMak83SWlONWxudGVkNVFa?=
 =?utf-8?B?eDZyTnc2bHdwV1Znamx6V013aHlvZTRVaUJiSERvMVZ2UXRISlBkcVMzN2g4?=
 =?utf-8?B?NWh1UzY2UzI1dWVLZVhnWVVCTGJZaHVrVXZDQjFvOFdNbjJreEYrZWdSUTRu?=
 =?utf-8?Q?oXxtDWEBdcQKD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtRNE1XMFZSY0RNUy9xVmFPckIyeEYzY1FlTHBSd1BqVzVDSlgreEV0Ynkw?=
 =?utf-8?B?UWZJYmI3eVZXVnc1RXBFazl2eHJEbGN0RGp0eFhFK052R0tmZkJKT2R3ekNN?=
 =?utf-8?B?MllYM21na3hFUGFuS3dTekhNYXl3MjJKVEdqSjFGcjRGejdETDRuc0Y5T3FQ?=
 =?utf-8?B?Um5OenhwbG1qZTE0VERxN1BvTWZmUlVta0V2N0UzYjB0d2NCY2xScFZnVGRa?=
 =?utf-8?B?YmV1UURUdmFjRzBGUC8zVUFranVHWHlHSWQ0bzBpNytQQUV2d3YwdTVXNlI5?=
 =?utf-8?B?dm81cFNJejFKUVozTmlwRGtRREEraUtuWlhQUW9tTXQ4WTQxWnlXN29jdkd4?=
 =?utf-8?B?K1FSK1FlQVMxTkpSdmxVdEt4dS9HU1NISjFOclZqaWJ6TlZGS0lGa0dScGVq?=
 =?utf-8?B?eDM0WlhZWGdKSVp4c3pXWmRxT0ovdlRNN2hVdk9naDNVTkxQN1VJMDR0ZVZj?=
 =?utf-8?B?eTIzTUhaU0dNYTZHVXBuME1mdDdRNDUwbDRqMFcxSXZ5OXdKMlhSbVRDYUV6?=
 =?utf-8?B?RkpyaXA2dHRpcUM3N2JxL1lLYUViRVd3M2phd0ZnL21SaWlkTmZZV3lNNmJI?=
 =?utf-8?B?RWQxSjJtaHVDT1IwMnhaUURLSmpaMUNVQms2UDhsNElRS2hwZWZORXlWdmlK?=
 =?utf-8?B?R3J5dzBzVnRhdkhQUnF2UjVaU1B5VWlzOUxQNk1Ka1VUV2xtZTA1RlZoek5u?=
 =?utf-8?B?K0c5ZkM1MzZ4Tk9pNEVhaUhJeFR3bk4ybUhMNmxiRzltR3pvVmVoUUQySWp6?=
 =?utf-8?B?cXJpWU1DTGJpM3NUVVl4MVVEbTAyZ1dkVkQ3QmJ6U2ZKOElrc1hHZnpaYWxl?=
 =?utf-8?B?VS9ReU5YMTNIaFJHSGlaNy9DMVdLRWtRRVZKZ1AweDdZdFhUQWl2OEN6ZVZG?=
 =?utf-8?B?bm51UkZVTTFrcHJLcWgwby83VC9FeFJtZEsvdXUwdUcwRS9Nd3RsUnB0MFo0?=
 =?utf-8?B?dkppVnkzNFpSNCtZVWM0REtUVFU4VXRsemJTYVp2ei8wOUQxUnBlRFdiQVp2?=
 =?utf-8?B?WittamVBTnNnc3pCNVorNmQyeW1hWFBqNGxXTjRPcUxnekl0Zmk0VHAvQWFp?=
 =?utf-8?B?cGlWTDZpalpSUmhacmtPSkd4Y1FMNkl5MXRVSnhCTVNwMktLR213U0N3eUxG?=
 =?utf-8?B?bm9uZ2VrQXdCdUZ6VVFONnFDK2FwTjUwVGkyWWNHNGI0bjdpbEtvRUE5bjJl?=
 =?utf-8?B?VEVHUUZIaHY2WDRMMm1vZVJpbHpyMCtEc0lDNE15ZnFvVWpXZXhpeGtTWHNR?=
 =?utf-8?B?MTU5a2t5d2hrNE1kMXprZ0Raa2dMbTR3WWRsY1grbXo5S0ZkS0EzdEFxQjkw?=
 =?utf-8?B?RjhUMXZEOXlwRUJiRmtYVTZjbWRsVnhHVzR5OVBYVmlqVGpVYzBRY0cvekNI?=
 =?utf-8?B?eHo4bTF2NnhhbDJ4NGZaaFRzUzVzTEI5RTI4VmVCdUM5czFWMkoxZnJBYXd6?=
 =?utf-8?B?SFJDVWpOeTZ5UkZaS0VyQUZGeTUwajgrWFViajJwT3hlUFRqMkZ0SG5WZVoz?=
 =?utf-8?B?ZVlQRUFwK2NVVk1rRjZWWjhMQlRwR3hkSnR0SUdqWHh5M044bW5NNGNiMDg0?=
 =?utf-8?B?c05ON0g0azJPVFdzbjIwUGJ2Q2dHSE0rUjZnaU4rLytMWnFxQWNiZlhRM3pv?=
 =?utf-8?B?VitNUW1kblgvYzNJMnVsSjVOSTJuTy9WZVN3bXRlMVVtaHVCcEI3cktpTnNv?=
 =?utf-8?B?QmNkbXR6V1c1SHVtNG1nNVB5SXA1REJIM0FkdWhKMDVGYmJUcm5EODErWTVN?=
 =?utf-8?B?ZWs2SThzNzduYndZbFJwdnRwUkxlVDNINjdGUFl3REEzL3ZOd09aZURZVVZy?=
 =?utf-8?B?OWtIUGZqdEJTSGtPVDNUYXJObU5UajduODh0aFdqY2FMdlRtc2tFaDhiTnp6?=
 =?utf-8?B?ejdpdmV6cmFLUitRRkl0dTN2ZUs2NG13Q25XRmVpdXJyZzF4dkFOYnVyU2RJ?=
 =?utf-8?B?TGwwUVBmc24yQm0rQklxRWdUdmduMVJWaHQ2aXRkNmp2bVJxOW9laUc1Mjln?=
 =?utf-8?B?K2JFZmE4MkxGWDh0TDNDMUFaZXBXNzZ0eG5VQ01wbit5M3pnRTh3ZXZ4RWhP?=
 =?utf-8?B?N3VVd2g5a1liNVErZC85S1Bnb1JhQjNWazFwbzlKbkI2TWZyYTJRcU9IaWNC?=
 =?utf-8?B?d1FhMDZTVms3Wnc3RlV1SzJadHozTUpjQUtaanM4YmYrNHdNclY5aUFpczlR?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7da0cf-05b7-4855-d67c-08dd5a6ff4e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:25:05.6111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEOV5Ud59Ge3CeMpimVyimkl0BVVGj9n0oj2MzIJEB0kppKJlKB5jFVyjeMzloErrB3k28x6aAGMb/IZA/g3a3BejneoqdXjtHUhWSOdlGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9098
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

Hi Anton,

On 2/25/25 2:49 PM, Anton Moryakov wrote:
> - Ensure `free_ctx` is called in both error and success paths.
> - Fix memory leak in `ctx.signature` when `do_add` fails."
> 
> Triggers found by static analyzer Svace.
> 
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>   lib/ecdsa/ecdsa-libcrypto.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 1c5dde6069..f0095e9dbc 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -363,8 +363,10 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
>   	ret = prepare_ctx(&ctx, info);
>   	if (ret >= 0) {
>   		ret = do_add(&ctx, fdt, fdt_key_name, info);
> -		if (ret < 0)
> -			ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
> +		if (ret < 0) {
> +			free_ctx(&ctx);
> +			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
> +		}

If I read the code properly, this is changing nothing in terms of 
behavior, I believe this is a false positive from the static analyzer.

We don't return in the if block, so free_ctx() will be called.

ret will be set appropriately and the return value as well, we don't 
need to return earlier.

What am I missing here?

Cheers,
Quentin
