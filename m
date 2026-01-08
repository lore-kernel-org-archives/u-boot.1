Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51BD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CFC84179;
	Thu,  8 Jan 2026 14:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wz+VSxNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EA5840FB; Thu,  8 Jan 2026 10:53:17 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5CF840F5
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGF/APwvaO8mq4jXP0ZTvqrFWWYxx6fYo4fSEakfBIJa9Eejv1896JPWTEzUVukSKw32aeXuvYk4Wt330RbuMQ6ze1W6pDAxzeEcB80RAtv+jUKFMzF2WnTQACPmtOxzb0ohkVZoFPsBNVQqLRqT2adm08LyskrUKjv3bBBcrS9P1Ot0euF8HCDeM+3BPI4RbNa4jcCAImG4l6QOf8Q5Im1LZftqk1OoROnKub0KZSyR823yomc7RojF8Yj3YC6FwqOg3wU8vrKWHgb+7Dxxo9W023YT1o60VtlRIg/4ctooSK/vQHyf/5Uv/Tu+h7Gf2dlNaLtRTwcAjgay+z4pdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPzmUDhPBVdMmzeOaKagJ6PH/S3VN/6hEx9tqTYsHgc=;
 b=nPdaHEsGbfwofrOsfSx/gXDFQK7QKYz6hsjsIWnHvQqHtKPb12M48k+Gz2i1JDmMPZZTIeBWHBYBdgFTj1yFGOn3bWcQxzWgbOv8gcs+bVLEOQAQ8iVavZfsznOZdzj8qIIzPzNVfF5cUk4be2AJycH/kjIwW1mrNIXf87XJ59mz1qjLkYlLkjSsBVm3+TvEfqkpREXgzBeC39Tbh39VmWX4A7CNU8koqiPc0+Eb4hGoVoaHxs0ETLKXOxHSmbnaRXQudq3yFloIDPD3xY9wzuMFL90zbBw1LWUe43nHh4ZsOcN/MZpcHVCq7kc3t9ym0CgCBsVg6/B8Ycw3SxWnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPzmUDhPBVdMmzeOaKagJ6PH/S3VN/6hEx9tqTYsHgc=;
 b=wz+VSxNpxxGmwLoyYUGFftdU0i+NN+MXhF81mJbfPa+rPo/WKFxblznljJDzI4SytYl3j8HOfeGQQnY85o467zsCXA5WFECsWhazrHnxOETw6jXDnAB+IfVfupXJxtPI8ii64yzwyt/DSGlXWjoRNBlPpGDWnHcWc+PjE5y6P0IImWLfgRsDGynCqHy86QqN68SghptwlXsJh//07hmXHIx2zotcDX6wPa4seNwehG3gNWe7fWYZkHx/VIwpk7ibUOgdvtdz3cXGw00HFHBwi8R5zfUppL39/qhruEZHRBVe9oaWoKT4pvRkBd0YQnJEG1aPe3omGWR6mjDEkOhvWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:07 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:52 +0800
Subject: [PATCH 07/13] imx91_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-7-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe28fba-f7ce-486c-4b3b-08de4e9bb929
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejhKK05GRFYwODBKcmRhRjJRQ29CSGptRzAyVXdYSm5pTGJlbmxQMDAvZkFs?=
 =?utf-8?B?b29JbGg4TlFCaTU0UEN3dXpPSHhUb3B2azFRUzQ1bmdGMmY4R1Q1eHNacXlU?=
 =?utf-8?B?aHNXWkZWMXVoT0wwQXlJcDBSZ3l3Ti9QNEs3TklyVHlBUSt0OVBtN1lmQWtw?=
 =?utf-8?B?elNKdkxWSFkwY1lUaDNXK0FaSkZNZzRtNXQwMCtzb1IzQTNmUUFvZUxTREtT?=
 =?utf-8?B?YVFoMFA3ajc0cHRVS3M5dy9hZ09jb3Q2K1hSb1hoRHdTZzNESHd2YWhCdGxh?=
 =?utf-8?B?RVNCM1lpb2Q5UVFSclVTZHVkYXAxNVhwWmJKeDAzek1tQndjNHRWZmMwZGZi?=
 =?utf-8?B?am1GU0EvLzEwYUNZQ05FVFpwVTN4Z0NOc28xc0FvQWx6L3BTZkw3YnJ6ek9C?=
 =?utf-8?B?OWNLWHc0V1NkYy8rangxUWY5UGFvRVVzTFpqbm12Z250SjhrVlVqeW9ET2Zl?=
 =?utf-8?B?MUxnZUl6cnRXYjVkOUpVMnROS25aZ0JQVGxGcW5SQ01DZFErUGhtekhHOXdO?=
 =?utf-8?B?d1EvMXhjOTZCMGVHakhiZEFiaHRGT2RrQmNnd25NQ0labm9CQk1vbm9GMjl2?=
 =?utf-8?B?Z2NCdHAvS1ZsWElURldNOG5HMlRZNW5KRVpGYXg4bWZ4U2Y3Tm0rMW5ZUklO?=
 =?utf-8?B?N3FDamw5YklYUXA5cDVONzU0MnBOcWx4bVROMjlZUDdlWER1RGt1UFRXRC9E?=
 =?utf-8?B?MElxaVNYMUp5YkZCaGZ0SWd4ak42K2lURmFsbTFMV2wvanc0VzdBTVpSdGJj?=
 =?utf-8?B?aFBiejlURWtPNW9wVXllMzludVRibXhZZkx3K0N6ZmxtVVlNMGdsdEptYjB0?=
 =?utf-8?B?clBGSk5CZm1QRnVGdzU1dTE5Ykt5L3BjTi9BTzZYREpIRHZSdWthSGdLcVVy?=
 =?utf-8?B?endGREQ3cmplVjNJZkxtbVpiL0VpenZiZUtTZHh4VEcwUUt6WDlSN2tZU2E5?=
 =?utf-8?B?Q3B6QmtSaFl3Qkt5dlJmWHFTZTJwSjREUnNFeDlYRUJDMDQzemFNdmdFY3hm?=
 =?utf-8?B?MGhudmw0UEtWdXdDYnhVaFJGQk9UenhjZ0tvK3hSOVgzQkJ5QWFmY3ZFcVcr?=
 =?utf-8?B?UzVFSjFmNVZnK2J1S01JRENrVFF2ZjdVYkE2dXB4SXpXNEpya3FGQkliblZI?=
 =?utf-8?B?R0NJNTRjSEpUMDBsdGRsRWl1QXAxeVVxaHV2VUR0a0ZuZFBXQmZlbjN6Q0g5?=
 =?utf-8?B?Nnd6OG1yd0NCOFUyLzh6NGNobjV3RHhMVVVYZEFINkhwTDBBMTJsa251K1ZV?=
 =?utf-8?B?MmloQ0FsbzlUeS81WGwyV2xKbUhodFU3V3ZCaGdmaWtWdTNqNnFDNFoxQTNk?=
 =?utf-8?B?OU5oNmtjNHhHb2tWT2ZmbGRTbWNta3d1eW02NGdJeUxwNHBjeDVpK0xMNHJN?=
 =?utf-8?B?c09jbmdqM2FQczJwbnJiWGpuQ1dvN1BoTFNHN3IyK21Zd3hiNlNVaEl2VDc4?=
 =?utf-8?B?M2V4bm5PNmMxUVJUcm0rYnNIVGl5ZURaV0dhaDJHbkl4UjVWM3RTanJlK1dx?=
 =?utf-8?B?QWEyc1M3YnU2bGpSU1dsd0F1aCtra1A5RWZKT1hzdmQ2K0JpYjY3cmNSdUt1?=
 =?utf-8?B?SHJwQzJ6WXNoSklDMjRKVnc0djE5ZXBjd3hRMUtyUWp4VjB1b0ZYclppN1pp?=
 =?utf-8?B?YXY1RVZPZ1BXWXVUWUd3OXZmM3dtcFVERUhoeENZSXhFTkNmZndGUWoxTHYv?=
 =?utf-8?B?TUg4NkJwQVZ0b3FzMDNWTkFCQWJoOEhFQXZoNUR0bVB0VVJKNFJiK0ZwT1d0?=
 =?utf-8?B?TkpBd2JrZmE4U3FhMjVTeGdJNTl3TEdUVFBMN2dzSEJEQkZhUTNuQk5SbDZv?=
 =?utf-8?B?Mlo5TzFhQWhwa0hkTEpwNHRlYW1iZk1RaVAvOHlsMi9iUUdGWWs3dWhDUGJU?=
 =?utf-8?B?QnRlajBUTElNOERNOUI4M1pGMUxKMHRpbk8xT052c1lsZG9oT1F5MHlQT3NY?=
 =?utf-8?B?eFBxcXlKTmZxalBXM3BuMVZON0JZRHdWRHNjdXZxWEs4SDM0VXpUa1JPNEJI?=
 =?utf-8?B?NTJINWFVQXl5cWNNUzRwWlJkOFZGOGZtRldiU2UxUXNUUW92K0E5eDlLMitZ?=
 =?utf-8?Q?ORt/FO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdMNStKdkczNmFGbFd5ckpUeHUrbmVTc0s3RVl0K2tQNjM2ZHQ0RDNxY2hD?=
 =?utf-8?B?N1JYV3JZVjNaZ1NiYndaeEkzSm41WmNUcTRHUkhuNy9taEpPdDcwUWtJdnlo?=
 =?utf-8?B?NUljWnBEUWhmSm5QRmxKbmVyMzIxdVNsbUlTeTRxcWxJUFlvZG9hTkZxZXRr?=
 =?utf-8?B?V1BlT1c5R2lOZ2hEK2NzK0plSFl3TVlzTVJqRndObXMxZmtDRU55K0M3dWNo?=
 =?utf-8?B?SjYxV3l1OURMd3ExbjN0d3NBMUJoK0ppdzg5STVUKzYxUGo3NzNnRGF5R0Vy?=
 =?utf-8?B?OFlxZXVzdGRzSHBVcUxGTE9hV2tRN1BkbldZdnF1QXBsenVFM3E1MXVDMHA2?=
 =?utf-8?B?QktnZ0JITStPOTZESndIeXZjN0tISkFLalNQaGdFSnpVa0d0UVhnU1MwTExx?=
 =?utf-8?B?VDNYS01TdHg0Q1RZOUw5UkZPcm1QWTI2ZFEvTGFHME9QQ2FyeWpGcmNUY2Rv?=
 =?utf-8?B?ZUFpcytIMDUrL2E2TFcweGd6QlJxMG5ISWJST0d1TnR1UTFpdTk4QXV3TnQ4?=
 =?utf-8?B?NFlXWTdOcVA1L1NmZWFrT1JrNEdLS3VuY2o3OVRxNDRFbmEyMVllTTFVMWU0?=
 =?utf-8?B?ei8wdnU4b3ZoaFBJUXZxM3JOSVlhblBXZC80WGlodXMvMmVzZ3BnOGQ0NGZW?=
 =?utf-8?B?WXJlWVVNaFhpK043aE1BK0MyR0FXVUlhVVNzdkNhUnlOSHRhTWdWaW1VdGNJ?=
 =?utf-8?B?S3lndVhhRndPRXRmMXhjZ1NpUEZxVC9rZXdTSklZZTVjeWJvWGc0RnpBeGFz?=
 =?utf-8?B?M0kwcUtGWDl0aDVpdFl6SVN2YXphYU1ER3BLUERMaFg3QXQySkFYek1PUkZQ?=
 =?utf-8?B?bncvbjNyQjNCT1gwTkhCNEtxM0Z6Mlk0MUxQUGsyWnp0SjBKR3dwbS9PcUph?=
 =?utf-8?B?ZXY1TFlkM2V4WUdFc0FFUllsejlMUXUyNzQ2Nmh0azhLQng2MG80M2ZjVFFp?=
 =?utf-8?B?dCtNSFhWRmdRcXo3aktLM3ArQWhxRkkwRVZsSG5idGJoSmd2VGdOUmgvNEtk?=
 =?utf-8?B?eGZvM1JYTXFZNXpFWkViNHB5dVZJYmpIVTZXOUZ5MVJtTllnT3NvUWpBZTZs?=
 =?utf-8?B?Y0Nlbzc4cTZSdk1RWmV4cHdhalVseWFNaHFBenFYd003enhCRWdJY1ZjUFdt?=
 =?utf-8?B?ZHUrSjIveTFpWTlUTEZUTDN4SEIwQU5UVUhtditySDF2aVBDSlZPRHdpdlNu?=
 =?utf-8?B?OVNXempKMlJzVS9wdEQ2ajhUTjJEQXRSNDJrWDJsT0M4bkVoZUVvQU5BaHVO?=
 =?utf-8?B?ZVhZaCtseGl6aU5ISVZUb0JDUHdnbWQwZ0RXeTY4QkNNSHZ6SEFSNldPa2gy?=
 =?utf-8?B?VnFjUDRrdFRSaVVuQlptb2JJQlRIVnV6Y0htUGV4V3gxN2RNbm1RUkptRUtJ?=
 =?utf-8?B?RXNmTHhLM1VKMlFGMjM3ckV5d0ErNk15amJLVDVtd051K1pxMjBPQWZyVm1s?=
 =?utf-8?B?TGIrQ0d0d3BQbldvSnJweXhLbG4zUnlsR1FJdFVrbFBZSXRHTGlmWllCcnpR?=
 =?utf-8?B?SlRkVkpJZE1YQTRnRWY5Zm80M0dDWkUveHZmazNBZEdLYzVHM05pZkNVVm5Z?=
 =?utf-8?B?UjliTzY1cXFqeHBZSVFCWHEvUDl3OXplTjNaUEZJZ1hPeFZkV3A2U3lZZXJ4?=
 =?utf-8?B?YkNvdGVLOTBhVFpnN3pVR25sdHN0SHBSeDU1ZVk4OVVxMkRBS0pzVUIwajlo?=
 =?utf-8?B?TThJblV4OXhHY1ZGOVhUc1VxWHg2aitpRUxDODJSZDFEK2pVT3RlMS9zVVND?=
 =?utf-8?B?RjBWa2piVWZId08yWjBmQ1llS1NOMmdRNWVIa3lwZWI2UmkzWWhjYTZQN014?=
 =?utf-8?B?S0ZwbURKeWpnV0NQUVgybHN4ZzMvK1BvYkVHNGNNYlRDNGxMbXdKQ1R3bi9i?=
 =?utf-8?B?NzBJNjlaTDdoNzUyR0xRYUcvd0FvMU5lclVORGJMVHlsYi9oUXBIN3NLR1BW?=
 =?utf-8?B?QlcxUFR4V1Aza3BUalk2VXpoVWhtMU9lUGcxa0hVajM5MnNmcFA5dUU4cjV4?=
 =?utf-8?B?dUVWS3ZWY2ZheXZCdWY3MHNCb3RLRXp6dnhLOStGRGRvZXA0WjlINkU1eVJM?=
 =?utf-8?B?N1RzYWJxM1d5UTBKNHhLbVdiYXJkZjNEVElJaTd3THBiYzJqbWhrYzhISi91?=
 =?utf-8?B?ZWxhTitGbXY4bG54MlpweFc5cHc5aGIrVlpiZWVROGlTdWt0SDB6REdlS05P?=
 =?utf-8?B?ZXA2YTdGbW9rTjAxbnVNTDd2ZGdqR2thSDJpNjJpOGlBWVJOWlJ5bUEyM011?=
 =?utf-8?B?bUczMHYwYzEvU0RMVXlYTEhyVWVGUzhmNisyU3RTM3FoMTZPam9KYWR3eWJW?=
 =?utf-8?B?TmI3UWNWZUlJTjZ0VUpiVVYvSms4bDlRUjEvWU8rL2g5cEtJQ1lxUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe28fba-f7ce-486c-4b3b-08de4e9bb929
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:06.7914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeK+boTclSDq4M8/TexQ1lZtjpXMZ1lVDvfFSdUNN6IaI2li3uyYCxiYqk4/42RkTFGNsaT+Km0yANtkm8XR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

From: Peng Fan <peng.fan@nxp.com>

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx91_evk/imx91_evk.c |  2 --
 board/freescale/imx91_evk/spl.c       | 28 ++++++----------------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/board/freescale/imx91_evk/imx91_evk.c b/board/freescale/imx91_evk/imx91_evk.c
index cbd0a72bf4b..fca2521081b 100644
--- a/board/freescale/imx91_evk/imx91_evk.c
+++ b/board/freescale/imx91_evk/imx91_evk.c
@@ -5,8 +5,6 @@
 
 #include <env.h>
 #include <init.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/arch/sys_proto.h>
 
 int board_late_init(void)
diff --git a/board/freescale/imx91_evk/spl.c b/board/freescale/imx91_evk/spl.c
index 46bde93fe3b..2aa63a61b74 100644
--- a/board/freescale/imx91_evk/spl.c
+++ b/board/freescale/imx91_evk/spl.c
@@ -3,35 +3,19 @@
  * Copyright 2024 NXP
  */
 
-#include <command.h>
-#include <cpu_func.h>
-#include <hang.h>
-#include <image.h>
 #include <init.h>
-#include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
 #include <spl.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch/mu.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch-mx7ulp/gpio.h>
-#include <asm/mach-imx/ele_api.h>
-#include <asm/mach-imx/syscounter.h>
 #include <asm/sections.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-#include <linux/delay.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/ccm_regs.h>
 #include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/arch/trdc.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.51.0

