Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD30C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C032482ABA;
	Tue, 29 Apr 2025 19:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KOg6phlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3263282A39; Tue, 29 Apr 2025 18:42:13 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF3E582958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vkv//HbvQKG3V5ob/vP1IrNA20r05fDYc4JoGOmVaz8fUb5vGn5hdH4ZuvgDjJplLZVp9Yx8WgYPCVgRmVAshw5Xsm1sKIvu4vHkDBSF8dpYBULiEX98PHH9wyRaSwC1yL1iomSyD1OrAVMnNK4XJKvd5siwZwoyfJHRTUOQ+331R7xdnx+8tkW/ReirwwlLEiYLDYCsmuSG2ZPm5zbDe1wLKswWvwDghBFntqhixaitM9CRvyQaLfnRBpyJ2WX0p3xkU/OaM/Ii6e1w1HGmFh5Ckff6qfS92B5L07UQvEOrtYzYzxd3NjOlWJYYK0sn7iWkCWVQfDwWoM3TmgyZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jna0kx0gBvH4ZYOhehMEOruwcqpPoOwljiD7obulOs=;
 b=C9P56Tj4q1PgiUKtlsEbQotvAAHqjkHsLy1v27Xz2B69zPvYSp8A6C3J/Zuj3BKldTV3DH4y9X3hZtX6BF2MVyUf9XlQrZOBcjA134k0vvqYWfJ0Qu/6VnC+kl6MxWjDxbaslsw58EzqTQGJTrJsjfuQ+RR3yapXPRU2Jh5xsMnz2dzvDKd+61bKlvX9p8j3gtjwpIbsnXqonqOAklqFrGzWj3Tp43scr8iB9Nq/VrYv0WaeGEjhm6m9xBCz+7LBZatE+LurhGxG2eNP+T/ctPg6ydC3FNv8WNRsw/D/cP/6jCYwerroQzWTVleZdTUGeoW5FvVcZWn7Sf0meNlEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jna0kx0gBvH4ZYOhehMEOruwcqpPoOwljiD7obulOs=;
 b=KOg6phlVqvO+gRBmNWhDO0buAc76CdCKQkwl4BAu6rF86Wpkr+TQwrH4hWbkgX/cS1DVXEs7OEDDh/0vHzJMb3jPgQU6U9bYzbsMfzUvO0hx7dArr6mZZyopAELMXaV/ShXPUJQ3JEyBRlqiUKduWP920pb6+B+MyTj9eAVt+uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 16:42:08 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 16:42:08 +0000
Message-ID: <f0d8cb7b-fcab-4ecd-b16d-99ecb0afe4fc@cherry.de>
Date: Tue, 29 Apr 2025 18:42:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: rockchip_sdhci: Enable by default for all
 supported SoCs
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Andy Yan <andyshrk@163.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Elon Zhang <zhangzj@rock-chips.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Ricardo Pardini <ricardo@pardini.net>,
 Sam Edwards <cfsworks@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Xiaobo Tian <peterwillcn@gmail.com>
References: <20250429154453.2155923-1-wens@kernel.org>
 <20250429154453.2155923-2-wens@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250429154453.2155923-2-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU2PR04MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: c83c181e-3806-4f81-fe9f-08dd873cc84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFlLWFBuMG5tYmZiajA4NmRTcC9ITC9uWkhDTVhhemZLUllKZm5wRHJ2SEVk?=
 =?utf-8?B?VFR4ZHlsWnAvT051eC93dGtmckM3c2N0VmJJUnlUS24rMS8wMjNuRlgzSE8x?=
 =?utf-8?B?bVNzM3p2ZUdYM0JpQ1F4YXZTR0Y3Z3VjYmtCNVRFRklza3RzckNFMkpiK0N1?=
 =?utf-8?B?bkFpelhtaDF5L3MxY2JkRjZxSXV6MnVDQk8vMzBDVlRiMW1ybGJXdjR0S3hE?=
 =?utf-8?B?eXcxL2NwR2JZelFvMm1QQkRHOXhFazlWNFp4UDkxelFReGZKL01rMUpKM1kz?=
 =?utf-8?B?WDBmelRweTBBVEJHclFORmtrWWZWcEEzQW1QODh3N2F2UVlNWVhjaVc3aXNj?=
 =?utf-8?B?MnNGa05Eblg3MUZHdG1tNkRtRkw3ZG1zZ3J0NkEyb3A1WTRiVHY0dXh3Tzky?=
 =?utf-8?B?NDVoUFRtZGdKcGhJK0ZXSktNbmFTOG91bUJiVWFLYmpkOC9Ycm1kS1dsM0hz?=
 =?utf-8?B?cTRxR2JLclZEbHphSHA1UkFocTFqNGJHRW0vdWo5R3ZFWnZHUVNLT05ad2Jr?=
 =?utf-8?B?SUs1ZlovVkJiY0U4a1pYK2l2aExOVjltMlZ1bjhGMmk4Yis3QlZuZ0krSnJO?=
 =?utf-8?B?MUhZY2h5SVFYTEVDM0FoMWh4K0hoa3Z5RklSbS9HdXh3QkRMdlBuckVxMkxT?=
 =?utf-8?B?TWpYNEFnWCszRi9XL0M1c2tpR2FDdnQvLytkUUFUUncyUjhMSkM1R00vTmo2?=
 =?utf-8?B?em9lVEZRc21YRmNkbXNiUHVrdWJ5dktWRmViYzRRb2JkYllzaUVMNGVWZ2ly?=
 =?utf-8?B?L21oOVJEc2ZjVldvSFp4cFI2b0xkaVJYcGhvTk9CLzJVb1hqWVZKeDY5cnlY?=
 =?utf-8?B?Qnc0S25TaUVWeEI2MFd6S0QwK2hEeU80cG1LQmc4TXk0UDNlNkRhWTh4WFdG?=
 =?utf-8?B?NTFwclpySzZES25JVFN0Rk9rMEY2czFPdTNRTm9TUjB2N2xDOXBaYnhyZXdv?=
 =?utf-8?B?U1RtejRzNE9Id3lBRnlhZ1R2U0R1bTVOVmFybXJmR3FTd2lXdWVGcUJiSEpT?=
 =?utf-8?B?WUNuTC80WE8yVkdqYWN5Z3hOMkVQMzF0UnVPaFZLOTM0RUpWRm5pVFBFaU0v?=
 =?utf-8?B?YnMyOXpBZ1AzWGQrcnA1TnJWSDNuQzU4V3hwS2s3WDRmUzUwYjdLamQvNGho?=
 =?utf-8?B?S2t4NWUxM3FxcU1jM3JncWtxOFVyVUR4NmNXblZMZk5tcExFQkZCUHA4Q2Fw?=
 =?utf-8?B?QkhOS1pENEVuOFUxdFVzb0ZTUDNmTWFvblRSQ2xyd2VHUUdNcWVVR3NHa0o2?=
 =?utf-8?B?dmNZSzNFb0hYRFY3dU1aaW5QWVBBM09yYy9EeVNCTEtxQXNnNjQyYTNodEFO?=
 =?utf-8?B?Y29JaTUxYlkwdkZIaEoydGpPUStHMjg2a2xVbUlidUpqbUNhK0ZJY1RlTURK?=
 =?utf-8?B?eERUUm81UDNoZWhoaDBBcWdZQmRGaEUzKzI1NmRNSG9kOE9FRlFkQmxPK2U2?=
 =?utf-8?B?ZDI0bDhjaXU4YmsvcE1KY1EyT0FLMFRaMkMrc2lqWG9DU0tKWUFGVnJDNC9y?=
 =?utf-8?B?Wk9KN3JPRnY0NkJOTXRWYjR4cEdvWjBQZGZWQytFcTZUUldsWXlMU3NlNEdH?=
 =?utf-8?B?NXVOdUhGSnJMY21SNFZTSUlXUytaNkFOTWFzWWswdkZQSFFENDA3WmRQTmZ0?=
 =?utf-8?B?eG9lTUE2VWErRklvY2Q1T0NXZFBJc2xrQUNiN0JzellTSTVMWEZVeHFnZzFH?=
 =?utf-8?B?d3poYzE2anljMUtkcTlsczh3Q2RDY1F4Ukdpem9XWEZRRXdPNmVERkh6bUZp?=
 =?utf-8?B?MzREd1JVanV5YTJaSHpLeC8zZnNvYzhYUkZCejUvRDlmaHc1THdpY3h2Vmdk?=
 =?utf-8?B?d0s5dklnejloYUFRRng0Wk9kU1YyMzlHaFE4ajFoWiszQStNYUl5dVpaR1Jv?=
 =?utf-8?B?bWN4N3JSSFFTZHZGbWVSaVVEMUhCYm16ZC9zdXZvMjYxeXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhVNUN2QlVFT0RxaHRBUmtWYTFPVUprdWdGVkhqengvNkVIalJ2aEt3dXJt?=
 =?utf-8?B?c20vUWNrSUlrejdkbHVxZXEvdXRCOElzOW9KbWZwK0dpMUppZnlVdmpqSkZU?=
 =?utf-8?B?dUZqNHlBaHJIMGxJbmYwV3hRcnd3Qkg3bGRMZTAxOHVSc3hkbnZyei9DTCtM?=
 =?utf-8?B?TU1PTDV4ZVNzT0ZMaTJuK3NpMzJqeVRLb3hEbkZXODRzeTNHbjBKT0Q5ZTc0?=
 =?utf-8?B?WmwzcDR2dTVHM1kzRVVnZWh2Ri90czZ4YXVyMFYxS0RRNXJTN3l1VnJIVDZP?=
 =?utf-8?B?M2xTbTVXVmpNT3Bva0cxMVhyYUhadGdGMnV0MVFNMXdrczlkck5mTE56ZENI?=
 =?utf-8?B?L3ZBejJldjk2UmZnYURCZHZWVkllYVFFczc0a0xONVJoRm02N0ZiRnBPNjNH?=
 =?utf-8?B?cGI4a3RqZkFUS0dGMHRGNDJhK3VVdG9EQlZQTHZYOWN6SERtQzd2anhzdlov?=
 =?utf-8?B?c2xhb2RXSW1wK1lPVFVET2JRQUZmSGJZTkkyeUh6TEpGUWtKcVhTOVpxOTU4?=
 =?utf-8?B?eGFQMUR1d09HYXlBdERrdHVjTWZVUVRHak45dmFGSWh3dUVPdFBaMGlhWGp4?=
 =?utf-8?B?cTd1SmhCNlRDTEZ1N1NLR0VsMGxYelh3R2xwdGZDSjhBNlZucTkyWkkyV1Jh?=
 =?utf-8?B?Ly9ScEdib25RS0RBWjU3djAvcCs0RHNqaGlwK2s4cUVBeVBXWnZPOTIzSERN?=
 =?utf-8?B?eHpVV1JhNVMvR0REZkZCVmlsOVo5Z3hrOWpBd2l3Vno0dHhwaWtQd1pQRDVB?=
 =?utf-8?B?dms1OGpuYWpieng1SUF5QzJ6eGJodzlpZ3hXQnlJZjNEYVowUUptOXAyRnRV?=
 =?utf-8?B?RkU5UnorTmZvaUU4ajFzckVSdjMxNUpvRTdPazB3Yjd4QjVGOUpBRXI0RTY0?=
 =?utf-8?B?bmVXK0F4aGhBU2lFTHVQcklnWDF6QWY1ZStCOGR6Qi94SGZLdTdiMHJGNzg0?=
 =?utf-8?B?a2V6Vmg0dGxWbDlWdTJkRFFDbTYrRGxVNTBEcjAvWU9idzZEd3JCRWhXamFz?=
 =?utf-8?B?eUpqQVZkMEt2aitQMFpacE16MVRRbEhmNjZ6YVpWTnJPaHF6TENrS2N3QWpK?=
 =?utf-8?B?SWxvWkxnSlRKd0lXN0J2UHFsU0ZpUkpnV1ZLS25rNzJVU3VuSnk0eU9jblY4?=
 =?utf-8?B?ZEJvZ0NYZFptcVdCbjVJK1ljVDF2REVTVFFMT05wSHdXUDhiR3A4K2N4UkZ6?=
 =?utf-8?B?eGlRenlBbU1rdThWSitDRzY3Z2srUy9OQ21jNkx2Sm9TZU04ME1mY25NdVI1?=
 =?utf-8?B?a3VCWithY3d0UXVEWThpUEFXVDlORzJEUFYxNVlyM1BwWHMzSFA5Q2Z4M3l5?=
 =?utf-8?B?UkVmczZxY0gzb0dnVDNwb29MWWdxTEVmdm9TeGRJSVY5ZXNObm9LQ2lYa1Rh?=
 =?utf-8?B?RnhUZWdkVENVZ2pFMGI3T0syNzI0U0wwWWozSlhJY3c0RUsvTkdKcU1sNDV2?=
 =?utf-8?B?TUhVRU1JaWFzSERHV2x2ZHJxejFHaVgvTWhuenEvWndxQjgyR1BMODR2QTlY?=
 =?utf-8?B?VEJXaE1peWY3bExUb05WRlAvMmwycGY1bGFNSmxLWStZVm5SRTh6V2lHUWh4?=
 =?utf-8?B?d09hMDNzNngzNlRxY0ZGRmwzUldZeVpPK25NYWdWa2s0YzZ4TjJJNWE4T1dU?=
 =?utf-8?B?RUI5NlNkV0NyUllyY0o4L0grNTNNVkovTThZeDM2WER1cVYycnJNeFNjOVpa?=
 =?utf-8?B?RTZGSlhKQVVqYS93bjZPZVNQMHpGK1h4VEZSZnNTbEpOT1VWOEpIejJ0Szlx?=
 =?utf-8?B?K2tNREc4SjBLZDgrRUtxOTU5OExEam1WRk54UzgxUnBjWFFBVVJDMTQ2RjRh?=
 =?utf-8?B?TFRaZllzdm9XSUFDR2RKU21lL2J5czZUQ3hLeHpkbk1idFNReDNmcFpJcXVk?=
 =?utf-8?B?ZWdibUVBdFB2SE5YbTVsdnFQVXFoU1VkVFV6Q2tYZGVoRnJwMDRlZXl3VUZK?=
 =?utf-8?B?T2FrTENCeitNOGJzb21uZFJ0eVFNVmZreU9DT2lTWFdtbUU2cnFXL0pwSjlX?=
 =?utf-8?B?SFlwMFZZdHFKbWdpdThDbEVOdUlJMnhYaVdDUVBOTnhMZGs4cHFNcmV1cWdV?=
 =?utf-8?B?WktIWXBOS1cyS0lublE0VitlQU1iM2RKTnI1U1UxK3BoSFRZOWk2ekViWmxV?=
 =?utf-8?B?SHRsNFBzQXBnajkvdytsUVF1VGN2S2N1bkZGRmlrem1jelZuU2FYblhNUG96?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c181e-3806-4f81-fe9f-08dd873cc84c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:42:08.6239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F9PEFE70jstTmndcSwNK1jwLMh+zoChYN77TNZyeDt5eWzliXBlUY8CeoKPteyWsZix/HHEkhSUePT10ROjLp1Up7vfa3FxBuAuXRr4ta8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:22 +0200
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

Hi Chen-Yu,

On 4/29/25 5:44 PM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The rockchip_sdhci driver supports the alternative MMC controller found
> in newer Rockchip SoCs. This controller is used for eMMC. Almost all
> defconfigs for Rockchip platforms with this controller have it enabled.
> 
> Enable it by default for all supported Rockchip SoCs. Disable it
> explicitly in defconfigs that previously didn't have it enabled.
> 

Same remark as patch 1, maybe only keep changes that wouldn't be covered 
by a simple make savedefconfig after your patch?

[...]

> diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
> index 5dc72ebd82a7..e90390f6daff 100644
> --- a/configs/orangepi-5-rk3588s_defconfig
> +++ b/configs/orangepi-5-rk3588s_defconfig
> @@ -54,6 +54,7 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +# CONFIG_MMC_SDHCI is not set
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_XMC=y
>   CONFIG_PHY_MOTORCOMM=y

[...]

Seems like the OrangePi 5B has sdhci enabled, but we don't support it in 
U-Boot (yet), so fine :)

> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index f2f0e7dbe601..94377a1a1419 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -481,6 +481,11 @@ config MMC_SANDBOX
>   
>   config MMC_SDHCI
>   	bool "Secure Digital Host Controller Interface support"
> +	default y if ROCKCHIP_RK3399
> +	default y if ROCKCHIP_RK3528
> +	default y if ROCKCHIP_RK3568
> +	default y if ROCKCHIP_RK3576
> +	default y if ROCKCHIP_RK3588
>   	help
>   	  This selects the generic Secure Digital Host Controller Interface.
>   	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
> @@ -713,6 +718,7 @@ config MMC_SDHCI_ROCKCHIP
>   	bool "Arasan SDHCI controller for Rockchip support"
>   	depends on ARCH_ROCKCHIP
>   	depends on MMC_SDHCI
> +	default y

I guess this is fine compared to patch 1 because of the depends on 
ARCH_ROCKCHIP.
