Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8317DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3150883D4;
	Mon, 29 Jul 2024 10:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KwRLtN+N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677788855C; Mon, 29 Jul 2024 10:48:14 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9112788276
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og/0W4CIJDLYxmXOOCxBoVSxnEdvDuQwqsB7gPKOf82A/i6JVpz84UUDUq7nggxaV4DVtKIbn0fwd6kriUY2fMAevaOI9hrJNOkusuotp8Uy8R2R6M3F6dCkVYyvFfH1/aV3n1RaKwm2yzkX6B2Ub3MdSB0r4sX7Pi4S6pWtEobS5plojbVLE8qCSya/qe/FbmgJ+pa1CZhnWTW19ciKktXNovOj+94/puyfwwZeWHnZ/El7brhS4Mb+da0ZSuWU+5rkHM/S1GHKoqYRYXgOeDRQfxqK5D95QKS5CWIWLWw6Nm6BZMKd64WosOTCKuaBT1Rx79wcmVWOjRZFlVFpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ktg7H8hK5BD+taAEM/Ya4bFZggVb7a3S/V0BBBTttwI=;
 b=BhQCUMZkKSi5ZX60W44K8Insjf4sFieyyTq2RYwdnKteS3u9L0weelqsYEfpya3C0VOdFYmgJWqux2kw8nLjvzt3eEuli0OG28LBH8/rcojddXODCDCErPrqBobm1jyXAO/F8P0r+QKWg0AmpJ3iNxrtCU/Z1JZOyGUP0KVDiLMp777jNkBpRVHavxL6VR8gAoyoirOMF9y5UtDKPzJtpi78rGphzAqjsjKll/l1LEKxv+VyOHAN5gvO6TlOEA0WoTS1HkIKCwKegfqFPNlTZVBmEmhKX6Iqst93DOfIplD3iEqC5eWALDdn+ybo4tI063+KNNrPQyxsph3zoDDE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktg7H8hK5BD+taAEM/Ya4bFZggVb7a3S/V0BBBTttwI=;
 b=KwRLtN+NCQubk5kXjZzgVcyAB+FACifWVx4ybS2uiZToV98Tv+tiRpLTsGzh34LmvzG/MSfaw6I2kaxX0B8T4tXm5mAbMmcuWyqA553XNVJmPWDtRsR5m3sLFqtDmgahJGMozQ3ZJu9VXyT/El3QCnJV951R+wH+rfZ/zptcfSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 08:48:10 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 08:48:08 +0000
Message-ID: <adda6a86-06f2-4914-ac50-422473eff669@cherry.de>
Date: Mon, 29 Jul 2024 10:48:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Update otp node in u-boot dtsi to match
 v6.11-rc1
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240724074409.2758552-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240724074409.2758552-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB8PR04MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: e85a3ded-bb31-4167-9087-08dcafab2b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEV0UDVKQlBUS0J6WDRsWTlESXlkOHBaWDkvcUd3clM2NFdWbEFTM1VLRExq?=
 =?utf-8?B?a2NSM2xUK1J4MkNDWkYyMXltdU5mTzJkeGVETnY0N3JPMlh3V0E2b1oyTDhG?=
 =?utf-8?B?NlMxK25mVUlFV28xY2N4TXRuZTRUckl5U2x5SXJMTnltMGZmb2JaRW9QVGhp?=
 =?utf-8?B?TTZRUXhlSUEyQTRGYUFiWEFTMXcyS1VRblBWSTI5WktMUnpHa2FXVWptWnM4?=
 =?utf-8?B?dVVqV25FWm5CZi9FV2E3Q2R4MC9qL2J0aC9ORTFKdGNxWFQ2eTRFdmNDd1Bq?=
 =?utf-8?B?eTIyQTdkSWEvaExmaFpnc1haeDBEckZTUVJNcHNWTlpHR2NEU2l0RFM2Nmlw?=
 =?utf-8?B?ZW1TUlpiWDRKcFluZ2t2MVJrOWNtZi8rY2xkTlRlK3czTFRlSUVtT2RXWnR5?=
 =?utf-8?B?N0ZSQmxjU2orTEd3ZFV1aWJ0b2RCYy9tdzYxVmNmNW9PRC82TkN0M0k3TnB6?=
 =?utf-8?B?UmRqWjRKOHBTR1RNQ3NvbUJlRC9DRUJnZ1ZYVlo3elhOemY4OTFYVi9Icy9W?=
 =?utf-8?B?SlFHRVZqUFMxOS9LVGM3NDM4QzF2ZDkwSjVldXAyTnFnU0ZCQUEwVUx4MkNV?=
 =?utf-8?B?bGpyVXM0RHpCU21lYjYvQ29SOEJLSmwvV2ZwR0o4cDIyK0tsbVhESjBWRG1G?=
 =?utf-8?B?c3JPQTJHcXVlUjkrNURNUUIrdENtb3lVV3RoWkw0ZEd3aCtkQkJ0alhNYVZt?=
 =?utf-8?B?aDF3Y1FNenRQRlMxZlJQdGZCZko1aFB1aDE1QWRhZWc3L0JlY2xRdDZJem53?=
 =?utf-8?B?cmVzQ1pwbmNzTEZFWmRhQVhWaXU4VVR0T3JOdzNLMloySGUvMjJzaVU1MUZX?=
 =?utf-8?B?WkU1NzhkazRVcnRwWU9saVpXSy9IRkkxZ0hWS1Nhb2JaTk1hSDFxN3JDcVFK?=
 =?utf-8?B?UXRFUzdNTjRmK3RHUCtiZkxjeWVzVmk1dFFGR3hxRUs5eWpBdG9nSDAwVThR?=
 =?utf-8?B?U1pmWm0vZzNQVmFLaDYweUlNU2dYQWM2dlcxK2FGaHVPSmNtMDBUb2RtREdD?=
 =?utf-8?B?WGYrN2RpTlo3OVQ0M1B3b3ppUE0rWUlHa1NFZ3NmWVZmZUNJSTRTSS9Sa3JM?=
 =?utf-8?B?T1VzUDFwNEQwKzc5NUxMK20rV3hrWGhIS3BIMlJOVTd6QURWNXNGakNuLzUy?=
 =?utf-8?B?KzhBM1JFZlcwdndZbWRjaHF1a0RIWk9pc29KaGFuRDFzYXQ3ZTEvMFRSdzBk?=
 =?utf-8?B?dlVnUTRHbG04R01PcTJZSDZZdUlGOUdaTWZpWDNreXVFV3JMYitQVkMrTEFE?=
 =?utf-8?B?TzV1RzdsbTA0TEdJSW5iUjhkb0crWHdNcFRMK1ArblRqa2I3ZlF0OFlzWlcx?=
 =?utf-8?B?VU9DS05GZzZSTlFmTjhabDJUUU8waENmUUJzMTRQM2QwREZhbXc1Q0lTckdS?=
 =?utf-8?B?ZDcvM1E3UjY3bTdjT1J3VXdDVUYvYUdUZFVHV2lkM3lGKzBsUTJGL0pBN1Rj?=
 =?utf-8?B?NG5vSDBUaDJGREZ5MlM2L3d1Ti9zSVErcHRaMkFZclQyR0tCbVBzY0R0OUJs?=
 =?utf-8?B?R0lyRWJ4ZVhiZFNKL2NSMnI3Tm5nT0ZoNVVpUGhvOWhSd1VXYUNaeHFVN0xN?=
 =?utf-8?B?dmhpTUtRaTNJZ3ZQMWVuQUczK093K2pHNnB0R3dLUE12VHpvOUczNEhWNUJI?=
 =?utf-8?B?d0xmTlFrc1lYUmRDL05MWWJCaE9MUG1VUU1Zb2VFZDFwK2RMeWFtZzFZM2ky?=
 =?utf-8?B?bDNsM1Q3M0hteExDOGExS2g5d3VHeWZaQWozWnlZNHlKb3FrU2VQOXdnMXlT?=
 =?utf-8?B?Y3JPbWhQQnowSTIzTHdqNmx2bnNCUnk2S1RWd1p2cWh1YjYyQ1BSeUZLU2hj?=
 =?utf-8?B?VzdUYlRuVWJsVFVkUnZ3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlpzZXJsTmtiakhvNEZraCtIR2l2UkNIZXZHcVBzb1Azd3VibHBscVZseWlu?=
 =?utf-8?B?aDk4aDgxSXRVZDNRcnVnMjErZTkzclkvbzR4VEtoTkJRL0hqZTVRdTdjbGJJ?=
 =?utf-8?B?L0dKeE5ubVUvZWY3UzJLSWMvSlZGMVBZYU5hVllIdEphMVFYZnROQk1oUEhX?=
 =?utf-8?B?Z0ZiTTlGUFR4OHNvVUJiQVJHOVpTVnBsUlczZE5uRUJXaEJRV1M1S2xZZ0Yv?=
 =?utf-8?B?RFZLMkRSMGZXc1Vsa0JnbzJQM3doOVBLQ09oTmNHcitQYWphTnlrQnZGV2hB?=
 =?utf-8?B?UERzalBwYzZDemxkWlN4a0JtdjBydWZOMUYrbGVHbVpuVFhLVjZZYzFJM0M5?=
 =?utf-8?B?ai96UlhGSHdRQWdteG42TGZlNmozZUdKQnFiZy9RU3JGUnBHYld3bGZpbWxj?=
 =?utf-8?B?UFhkQVRyOU1sSEltY0Fxa21icWJFc3gzN1FjSVk4eFZXTTA2U1VTaWZ3VHgz?=
 =?utf-8?B?OUZUMUhTZkx3VHZxWUpqbGlqZVBnV2VZUmVPQ0NGRUZVMVZFRENhRjEwazdw?=
 =?utf-8?B?ekRIMGRwdjhZbmFhRVYvYkZTRFpUUGZsSDQrSnVPWnlsZDRzVW5IZTRKQ1Bj?=
 =?utf-8?B?MFpBVkE5STIrSHNzaS8vdG4rdFdvM1dsWFVEdHE4VkZ6UlpiNXljUWhhdVB4?=
 =?utf-8?B?aGRsQ21GeStWNW9ERmFEdTg5SXBVaWxlTzN4SlZ2b2UrZ24vZnpuR20xSFc4?=
 =?utf-8?B?Z0FCbzJNVW5CNzRlN1RDUCtJL1lzYnJuT0RveE0zNGJTTlZjTGFXTWJBUnZN?=
 =?utf-8?B?Z0JyWVRya2cvM29Zdnd6M05ETHQzSzlONFRCQ0p4UGdod0JEcWhyT1NPdE5m?=
 =?utf-8?B?OGxOZkx0Y2ZXc3IzcjNKckcxMjVWY2tDcWE1MmRBRFNvb0xCTFQzR2x6dWVF?=
 =?utf-8?B?cHdPWW1IdTMxR2E4S0dDRG5jNTNscndvdG5BOFBibG52SVBFdDlpb3lzd2sv?=
 =?utf-8?B?N3VRR0ttcm45M1hYTnFvSGtXZ3lqYzE5THhYVUt3NEYrdGVxWUYxV0dBYUFp?=
 =?utf-8?B?RmRnUUVYOXRIa0RyZ0pObWRZQVNVeEVDTmU2aFRlY01HMjB1TVo2MWgzOEF0?=
 =?utf-8?B?SHZSeHJ3MjRqNzhqbUErQmlSRHJXU1FmWmE1cXo0SUtQNjN0ZjY3TTdGZS95?=
 =?utf-8?B?SWgwdStPc01IK1BYT0lQU3JTU05pL0E3dXN0Y3VhbFM2NnlaRVl5dmtZa3g0?=
 =?utf-8?B?Yldmb2NDV2xUR0Y2VDJmY0JTT1V5djV5alZUOFNtZkEyald5d2RsQm1FT0JW?=
 =?utf-8?B?MkdWMG1tQ0pFR3JTakxqR2taVDdCU2tnUngxRVRUR3lkVzA2ZWltZnIyNW13?=
 =?utf-8?B?bTJtOGkxK1Q5b29HYlQwdExjUWxwSjNkalh1NTFKbjU3MFJ4ZzVDWGRvSmta?=
 =?utf-8?B?dkJ4NWgyQU13Um9pb2IrcU96NWZETkNubGVpL2ROTTc2RTNVQ0t0Z25iUW5i?=
 =?utf-8?B?eVNreEdyK01DRjdGY0duM1R5bk1hb0pRSDE0UlVrN0dmaWJKcVFrb2Y5THJy?=
 =?utf-8?B?dGhTem5yeld2ZkVZeFlrS01sY3pOMkh1aDNySlJrd0JnUTdVT21heTQ0T200?=
 =?utf-8?B?UTdSTXEzZ3czazgzWFMveUlHS1JVeVliZzl2TGhaQUlTcm5JM0ZmaVAvV1B4?=
 =?utf-8?B?UHhScVU2TmE2MkNPaDJkSnFPb1pFSjcwaHBmWXdXa3FIcktwM242Ym1UVGxo?=
 =?utf-8?B?UkZidUhvRzFCK1VnSmtPV2pEN1hCbS9xeVVITG9aWmV2MklxNFlSRnZSK1g2?=
 =?utf-8?B?a2ZmNTVldzlwL1NrNXlpVVJTczN3c2Q1R2tSckd1cGh0em5Hdm1aei8vL2N4?=
 =?utf-8?B?MkdTVXMzSVc1S2kxNXc1WHh4bFdTbTZtM095dWhtMUVnNlN6QTZWT1RXeDZs?=
 =?utf-8?B?TXQvQnFSU0JyN3krTzhHaDJhdk1DaTFBdjZHdnRzWXNtaDNMVGN4VHRhejM1?=
 =?utf-8?B?RkNRakd2WnJaNytNTDBwcUljb3pNSnNhZjd2bE1NWE9RVVoxQXNPWWcremt0?=
 =?utf-8?B?VmxRVFJSZXVJZ0NUNjVEaXRiY0pJcjZRRFphTnN5UDB2ejd1L1NWaTJXSlZ5?=
 =?utf-8?B?M2ZRMmR4NVNKVXgrUU92cEFkM2krSHhXbFNxb3ZBRmZMQ1l1RmVzUWUxSEV5?=
 =?utf-8?B?dnk3Smw5a2lvemxHa3B1enUwb3ZoKzI2NE1XR0g1KzI0VkVGdHp5OHpYOHhj?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e85a3ded-bb31-4167-9087-08dcafab2b57
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 08:48:08.3341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENHKSdKRBZ6lciTwDMs/8byJlkTWbPSeEIab2VSKvaNfIwvO4vF2nR5dzkBvTm0HhO93EcD573H34uMcF/dSYjDPBIo7dhd4tLc4pHBdAl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7193
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

On 7/24/24 9:44 AM, Jonas Karlman wrote:
> The merged upstream DT node for OTP differs slightly, update node in
> rk3308-u-boot.dtsi to match Linux kernel v6.11-rc1 in order to reduce
> possible issue in future when devicetree-rebasing v6.11-dts is merged.
> 

Why not simply cherry-picking the commit from devicetree-rebasing.git 
instead?

If you spend the time doing this, better do it once than twice?

(but I realize the v6.11-rc1 tag was only pushed half a day ago so maybe 
the timing was unfortunate :) ).

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
