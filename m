Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A351C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5FD88126;
	Tue,  2 Apr 2024 15:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Kieao0r7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D08788151; Tue,  2 Apr 2024 15:56:05 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1020487E9B
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqSLvVDKCsnmEVtkYtyHtAMV7jmsgdj1ugrkPpzMU1CymdUjzKuzwK+U50fssaTsxVA9B74kC7U5lIY56BY+z63kBtQbd2j0LyiRkhGyjg81hpARqsX/6wlPhCCY0LRdfiaMfXlHhR8E+raORt1Xr+MkJHIg/Vj3coh7CSdybq+Ubok6GJ8dZtz+jUgoBEAmiVblSbgBzTOGNqkcewE5Byhgm1rYKZeLPZyJvbkhtGFBIqWw4w0VTh17SBEn/lnyg65j8aXnDMDLYKjRqxNNk3NI1GBf76grhyfgfVhzxnCi+d/GHdX9+k/If4U9D1O5D9fObla8+OOzgReKK0rY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UWrjvCLcPrWl8IuAam7+ulSGC7jDMoT2Xc/Y/m5dfA=;
 b=lS/5qwBzOtW2mFP26tSACq5b5EjI+n63W8rHAyRJNzpomT3TpFXJe06xzU+fkpnQqd06DNkjBvvyQ7pIwGs68d32hetFXFf2qhxLOO7hpt2eSJG0nPH7WPPJHnvHaClsy2gm39Mvs84xquwaJi78IQaTLTI5ENpvBJbyFlvginxm0sbq1UBl7UifczXIZ68KGrCCubb8EbIDR2Rjrb9e05YwimNlaDGTGx6UXf2I0Eqyq9JTaAget8TGSvkEf6r7w55ji6gecJooG1qVQj+F6cZ7U2/vu+kWJ61iFz9Olu7gJvhnk1M6FB4k4TWnECiE++ojY7OFhishIasggWA+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UWrjvCLcPrWl8IuAam7+ulSGC7jDMoT2Xc/Y/m5dfA=;
 b=Kieao0r7s/dUqCXGW/c6/d1yRaNmEGWCuYHC0lecDNwzNgT+h25RrWsg1KJ611gwlCiqhKAxTXx5IkqW3laJvfLBiLtrZYNs7HY4jwyiZfxsRmgDwvOY4PAzKpJ135p0S81VRoEJsHvL2TQ7tT5D7vC1msXaZ54y53mVP/J8j7pD/4kddylXpUlXs9lurkrss4ff2ydPEeEtUenFq3UJZ+09fkBhVwLHVeRgEBGwHnl9IJeXo6XPb7nFCrve1fj4WbUMSnfG4it06IuwOYif9N+m462SU5UhJVFunAkHH4PxBnfjb/uv39Y01ZmcN1iZLwrZHhKAYLiLSTHw4qdoDg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:56:01 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:56:01 +0000
Message-ID: <678cad06-3b24-41d8-bd0a-9e075a68bb33@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/31] rockchip: rk3399: Enable random generator on all
 boards
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIAlTEoWuzVZQ5c9yu6/8X7gWcxQqiHHr9DD5NaPTPgluqxbpfoNlUT2Ag7vCoD9m6UyJi3jUR3FKkg55PdlBSy6YUik5dpBBmcPKMSJvwAbN69Mr9sX0p46KsQL1fA23sG51spo0pg9DKB+q4xtDHILZl6RR59wkukFgn1uEn8b6PPZIfTO3Wo/wfKZXdjyMto3dUHyl+egaL8v4/Yv2wJPJhx8XcbUKb8UaxXkP7KjrPbA+oLsoTdZFwm8mhdCvNuRS0A+AXqQvkOJRR/OEbBoiBN2jsXLZF+gqcIPQ7vuVsmzsiTF7dti72+7rZqeHjUrJPbo9n/gndxE4k8k3OB+cWBi6tnQioA9ej8Is6ljyUjJDEPIXgprTQ4oWQKl5MzjAjQvWA9o/POU+IdI8uZAPwGNrRoLrI4kr0vJBYJIKnquWpMPyHHKI9W4Ll+rJ+FCFGegjzAraN3VIYB5wQ3+42KnbS55U2dbiN1/wITSIIxgBW/o7NU8vdjhl4IdLy7u7YGgHxyvXSMl1NEECPV066fwMMYMnEk3/Xs7QACAhjjJiuE3OK9QYw7wkAtlOgIqANMzyDGP30Ee3mmcS8P1SQww6sD2kCQrvSKbNm1YleG91Qmvg+iGxsaY/aBXdFLTMIqD7Q/A6h9zYI6jw9bhdF2pxjWqS4v9YX47gYhdY7ReVP/7MEQuUYv599irGIqQoex1pr7TTUEYeCowsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNLRi9FVnBDMjdPWHBlWHN2R0xrQ05JOE9WMGR6YUpwS1lkY0JoeHJQMDlC?=
 =?utf-8?B?YzJxMnc2M3hwbFFMMUtPL3pvMm1YMzlNNVpOYUtPRHpFdU5rcHhYVTFyNkFw?=
 =?utf-8?B?ZTVyZmJ2UWZxV0dWNUtpQXJUcUt3Rnl0MjNZNzIxQmFVbWZzbVA3MXNQTXRz?=
 =?utf-8?B?UGtEdEFTbE43RXNsV25tQ1J3S0V6SGs3S0pqdEx6L2toNVhtMzQxOElDTnli?=
 =?utf-8?B?WXlnN1o2dkhNTkp3OExYWlk4ZE5PQ3NROGJCRllCdjk3eEJURFhjVGxkbEln?=
 =?utf-8?B?VjhVNEM3dGUvU0hxMlVwWmlHYVVOZVFYaksyUDJTd3ZhZTVzZ3QrWXFWem9E?=
 =?utf-8?B?M3o4YTZ4WXlsc01XU000UFBaWWZScTNlZnB0YzlkcjB5YTJOdjZmOTQ0VDlo?=
 =?utf-8?B?VDBVdzJNWUd3NGNxWHJ5a3Azb0NWY0RlMTRyRHVsRnBsMnFXNjRQZWtTT3BV?=
 =?utf-8?B?SlRPK1dpcnU5SGM0dHNMNE9paEpNVHliUGRoaW9RblhCL2VRRm55dUpDbUJX?=
 =?utf-8?B?SytVZTM3cjFNamo0S3pFeC8zSjVUVjBleWFWamY4UU1lRTJpZEpBYnRtV3M4?=
 =?utf-8?B?Um9yWjdYc3RDSTdYcUdDTGdiTWtsVjlzR0RzSEpxUkxTSU9Zb0NNS2ZDVzd3?=
 =?utf-8?B?WU1kNnVFRERiVmZtUXd0UE9lcGg3QVlydW1PWVVjWXVxRlFDZEdrWHd6dFIv?=
 =?utf-8?B?c2ZtcFkyZXhndnhhNkx3SllHcWlXUGV5UU10TkRRclFSbzRmSWF6Ynh4Qktl?=
 =?utf-8?B?b2xtcUNsbGUxZmJtQmx5bjNHQW5BVTMvT1RWZHlHVTB2dExUVWQ5R1ovTkRi?=
 =?utf-8?B?aU42bkNwb3V2N0labjhmbktsTWpMS3JGSDczWXFZei9iWHB1MVdCMG9hcDll?=
 =?utf-8?B?ZWNLdkt6QkRNc0JvWWlGMFhkcDJqYy94VGVMTFkyRXd1cjN2M012UEcrYVlv?=
 =?utf-8?B?SGVhQWV1Vm9zNzNwN1V2dmNyVkhsd2ZOT1p5ZE1XNitLL2lhS1dxRCtCT0xa?=
 =?utf-8?B?Zng2aHVhODJiMEh5UHE4MkF3eEhSUEQ2cC9tZUx0S0dabjIxZEp1YTB4VkNa?=
 =?utf-8?B?a3EzWGRyY3VYSGdCeXo4TTNUZFFxcXY5Nk1aR0FDMURXcjlZM3Y1U2gvTmxz?=
 =?utf-8?B?WkF1VGgzT09LV0NaYjNKdGwrSHZaa1ZoaXNPTVlWSHhKRU45WXlRbGc4WXRX?=
 =?utf-8?B?Q3hENXJ5TVRIenYzeVA4amVWMGJ5Qys4VEZZUTZFZ3MydDY4Nkp6dlg1QlQr?=
 =?utf-8?B?MXpHQVJ4VHZnWGFoTEVoNXN3b2lTUW5nMjBvTUhZbm1vNHhyUCtNbm1yU3Jm?=
 =?utf-8?B?WGFHYXhQbHRqWmNFeDJzejBTdW5jQlk0L0ZHaXdUZ3lHZlZDWmc4eEl5WkZ1?=
 =?utf-8?B?YU01TU84ZGMraGFrQjJSVWRZTGVnVk9JNzBjNGZYWVBVWjFMczh4N0FBYmJO?=
 =?utf-8?B?blZYazl5OVBvR1ViZTNuZ09ZbUFFaGNzOVo1UzI0djU2NWt3RVBScTg5L1Zz?=
 =?utf-8?B?c1F3dEdJNi9Pc0hGOWVZb2ZRWjYwenB3TGVWdFhBY2dMenVnUXRSTUJ3TGtl?=
 =?utf-8?B?VnVPbWtHKzNRVDB2K0lhNWpXREYvQjk2UWRabFVFWXB5T0N3ZmR1NHRVYmRG?=
 =?utf-8?B?SjNES2ZCMWoyck4rSytlb2VUdHJDRm9iM1R4bktsRGxpSEM4VXBNeW9jaGcv?=
 =?utf-8?B?Tk9IRnY5c003QTRHS3hhRTg0ME4rU0hXV0JjR2NkWkE0c0NDbXpESXJIZG5T?=
 =?utf-8?B?ZFJqTlp3bFFaQWtWTG5zVVlMbVVhMWdIVkkyZ2tBV2hZWFU4dVdqWU4ySHJC?=
 =?utf-8?B?cHNuZ1d6a2lpaHN6a2xEdFlma1pGMXJ2eldqS2ZZUk8xQ0lhbGxwSWlMZGNw?=
 =?utf-8?B?dmdFT1VkbzUrUXl3S1JjaUpYZjFIRCtYTkdvbXZYcGludU5nZHlhc2lob0Iv?=
 =?utf-8?B?SXNJNjdOZC83ajZBL2xnNWpYT1J4L0dtTEloV2NnamQySUZBckYwdGpzUThM?=
 =?utf-8?B?YmNWZTNNT0ZzWlMwYlNBOXVPbWgzd05QWmZ1YisrdWErdnJqOHRnYUU3NGRX?=
 =?utf-8?B?Y1I4c25GL3JSS3V4cjkra2NWWnc0NjRNNStDbHkva1JVVC9Ra0ZtelBYaU1D?=
 =?utf-8?B?cWE0Z0QvQzdoa0xiR1gydnFoQVVZekVjNGdTU1B1MDdoVkFaeHpVSFVINkJk?=
 =?utf-8?Q?lJRyjyw3nH5yNlpmnOLieqM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb534739-66cf-4c40-02d9-08dc531ca165
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:56:01.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDdWU//YOhQgjIGRLTpeMf5cCNZSxYJdASnLH72P8X0j8C6WWRC2TknNTuzL40HYa83oj2+b/Gc/LTzWemudZ1u6eeDa9folxOGB7nD0YImuX2hX9NH9I+gaq9k/TnG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
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

On 3/31/24 22:28, Jonas Karlman wrote:
> The RK3399 SoC contain a crypto engine block that can generate random
> numbers.
> 
> Imply DM_RNG and RNG_ROCKCHIP Kconfig options to take advantage of the
> random generator on all RK3399 boards.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
