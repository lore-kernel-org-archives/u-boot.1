Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBB8E63F3D
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 09:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C5C83AB7;
	Mon, 16 Feb 2026 10:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kvXDEqWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CB583C61; Mon, 16 Feb 2026 10:22:11 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C372E80050
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwxrUJF3IlD6ar51qJ2dL75i8UuLbyj2NSGB6pfFVYGQNTDV1W1xolZQVQe2sTC/lq2IKMzgEk7Rm/o4I0RcklzpmjSYUJ/UdsSDgm50uicXL2NhUyfhoohQje4m/8JT++XPMz3XW+9RBSU8SYgiZLLSzJFgViIccu+mQ5Uu/A+y1Ozpj79CYAWHlGtIJWrpC04pkHOC8BFjyqEKTYYN4vEX/z2rduFJ9jsoSFBFUmZ5LsbJqg+mzNEr4TUpcGERkdJiSpVZAJmMlhTDh4Axut+TBKagpMVv63aVnSd2tMGKMbqVDn9Pi5lWbPysJhMnYCRAJcy1BySIdZ6X0X1Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96lt+ZM4AJ0s6CbTLvv+At60kQrUNM1FKp2dz7CnRAE=;
 b=onA5QSjKveY6ZoILuoC9s3qk1EG8MM8PzQUJC0knk2asJNU13nnkAQ5d+ZJKq/+4ZULwDF+hIsTbKKYD7PkS8SsoM8FjW+BP/VDl6gqvUvhl2kgEkdz/36Ufq0UHuDcBuevaXyDkQoWiDqoJdfElTHJ8NQacZ0lh5d/zcCPRPBlwCQIpmHvgo7vwaYxCQGbxcHv3pOG8zkrnJLYV49dLHpRV9TTpUkneZuXCrRjYYCbxSK8NgzTGBBsvu/dfznAj+XONh6/LTiMNpyc/0CYbroIbo5kMkfDZzkYbWy1T4x9PjX9nHHQdcbin458bPVOS7eLGgwECJkLRMF2krIFnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96lt+ZM4AJ0s6CbTLvv+At60kQrUNM1FKp2dz7CnRAE=;
 b=kvXDEqWn+on/3GL05HkcYjbPd4RL2/w/aJ+WBYVZJlDnsnqBO74/Tco7HmGCeM/3tfra0LuKPDC2ff5mjmfqkIMca9x+vFf56KkOcQpWQKw8RztS7oxkIXaUx6ySnjBIVKfKdAY+/dPERG5PVITslgUD1Ov9mUzz7vwHJxqDfVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10223.eurprd04.prod.outlook.com (2603:10a6:800:229::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:22:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 09:22:00 +0000
Message-ID: <34da365d-38aa-4325-912e-cc2980ea1710@cherry.de>
Date: Mon, 16 Feb 2026 10:21:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
References: <20260126215601.837587-1-jonas@kwiboo.se>
 <0406debc-6a4b-4b8c-9f47-167376144743@cherry.de>
 <0670f2d7-89ad-47f0-90fc-de8ebe8dd81a@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0670f2d7-89ad-47f0-90fc-de8ebe8dd81a@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10223:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f86660-7365-4efd-48d9-08de6d3cd718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzhEMUY5MWRHbW9ZYlZpaGFtN1p3aUtQTGRPbzZRMC8yT3VWUXg3VDRFekpR?=
 =?utf-8?B?MjFhM3d1TVdXS3krTEN2bHpmODNuSFVKR2NBUk9vYW9iUzRBemFnbjQvcjZj?=
 =?utf-8?B?b1FRWnNFQnZ4UTdrV1hnSGdxWTl5QTljOEJSRzZaVm5GZjZRN2ttVG9lRE1h?=
 =?utf-8?B?c0hiYSt5MEduMVZHb01rc2VWOWw4YVlLWi9RNDRPdGhsSGVYOTdwRHgrdFhx?=
 =?utf-8?B?aU9NOE9OcVkrWm05aXcydDhPYmV3NnB6MCtCNHpHWWp2YXpMbDkwRTNWUVY0?=
 =?utf-8?B?YkJaanRWRjR2ZzRVcGx2dnNMNW5kdHY5VURDeXEreG5qUXVadnlXZ3JJbHZq?=
 =?utf-8?B?VG0zZTAwWkdNU1FVVTI3b3BxNlJlSThhbzFmdDdvM3RyQ2lFcmlTUW9NRHQ5?=
 =?utf-8?B?clhYSFJFRVltRVlBaWY5T1JwNWJzR2JSTjFWYnNaVlVMM1ZPTFQ5R1pFQjFy?=
 =?utf-8?B?THVvdksreDEzS1NlWFhqMkFOTWl6bVl0QXZwNk1uSStudkJqaGhDUExWaWh4?=
 =?utf-8?B?MzZVY0gzZ3prZW91TjkzNk94RGZHaVNjK1NoNVBjZlp2TnhhVThRSS9IUkpa?=
 =?utf-8?B?SHA2bi9pa29JRHlhb05kUG1SRlVQbVlUSWE3VDc5TXhBcUovdFgzTElVd0Yx?=
 =?utf-8?B?cGd6Z3kwQ2xHa1BUeGp6UUpuK3ZOdkNCQWtMYi80anN5dmIrRERxRDMwL2VT?=
 =?utf-8?B?Qk16YWpOeEhIOGM5dGhzOHJqY25FSGpybWw1SitmSExKVzMreVpHamdUMjdE?=
 =?utf-8?B?OEw4Z3hjNFg0UjUzdDBSQ2FTY2plOTNQRld2dHNUYStsdDIzREVSS3hDbDd2?=
 =?utf-8?B?SFl4VitiZE4zRDJ4aXFOb3JuSFN1OEgxNXJtZVI3RlRaLy91a3dhUElGcm12?=
 =?utf-8?B?eDRkZGRwSnFCUWdray91SnFhNjZ6bElXOG5wZ3lQOEZ5NjNUQzRKcTdjZXJ0?=
 =?utf-8?B?SDk2MC9DWDVFaUhEQ3dGamRWN3dRS0NkazlaVVk4OUNEL1dLN2ovRTdqYW5t?=
 =?utf-8?B?REpGTjBlTjVDaGtWTUN5UWo5Vjg2ZGJMTTlicksrY1RCM2taSGRLWis3TmU1?=
 =?utf-8?B?aVc2K1h5VTJzWGQyeDJlY0RHQkRUallkRWNjK2xGZzdaQmQ5VFZGcHQ4RFUr?=
 =?utf-8?B?SjJ2bHB0Tit2a1o0dStTQ29ZRlR1SEpJU1FZZ28xSWZOUW5HWW9pVFJMSko5?=
 =?utf-8?B?S0lFenJmMGdNSDZ2V1JEUE9TbS9kK25pUHFoSm9aajhEL0F6Q2FHZ3M3U1Ix?=
 =?utf-8?B?d2s3WGFSZm1NajZVdzAxeFQvejZqUDZVNXVKVHBKeHJqcVFoSkFadG5hbnNL?=
 =?utf-8?B?WkIrOFEybDh1eHZHVzMyWitiUjZ4QUZoV3M2SE00Z1Y2TmQwS2JlVUtwalBz?=
 =?utf-8?B?YWdNdk5XUVFaZGVRSDNTUmpUamdzNUJIc21lejhuZldGSklwSXlPM3IyT2Fi?=
 =?utf-8?B?ZkxBUVpnNmpPK2xtYmNMU2dZS2lXMGhZUDJhTW5nWjZJZ2VPdUlsSHdTR2k5?=
 =?utf-8?B?OFBjdGVHL0FEYnNtOURleDRPUGhKeFlmSXZpTUNiZE44aXVhTTJNSTVyaFNq?=
 =?utf-8?B?TERoVHB2TFlPdUphcWh0U0FibHY5ZzFJNUovK3A0OTBhTEZRSXhGdzQ4ajdJ?=
 =?utf-8?B?SVhVV1hhUldjamsyd0YvK0ZwTkl5NFhNNXRpYkttRFVZR2ptSUkwMmFBNlNN?=
 =?utf-8?B?RkxQL05kNUx6OUZkMm5kcElrQmhLbzg2WmIwNy85ckV1RkNaWCtoYlhSS3ht?=
 =?utf-8?B?M0hLb3o0bWQ0aXJ1TlRxa1dMQm1ySCt5STBBS1RQZllRdWJQSEZVRmZhYm9P?=
 =?utf-8?B?SHI3VnFUaXVybmJ5dk92Qmdsb3lqZGlqUHBYYWxCaFhmUnBVc3VoSnhHNHJx?=
 =?utf-8?B?NHhPWWpNNk9Od2ZBMHJHK0lsRkNibkkycjNTU1F1QmdXaklPaytIUlU0R0o2?=
 =?utf-8?B?ZlJ5T0JzK0l4YUtDNk5BVDdKOWx5UElYQWplVXBZQTNmVzNNeGg0cytURXRR?=
 =?utf-8?B?NkFiTEFQNkx3citDOXZrS3FtVUtTN0lteGdMaWJUQTJFNFNsY3BIZU5GK0ZS?=
 =?utf-8?B?bWFwWi9mRFpQQUQxMlZ1SVl4a0Z2eENrU0NDazFrbkp6UnFZZlhLcnk2L1gy?=
 =?utf-8?Q?83kQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZQQ01MWjVibHI5WEJPdVhhRUpveFV2aUhyc3RDSzNnN2kvTE1mOUN6TlRl?=
 =?utf-8?B?STlSVDNTUVh0aDMvMGJGV3dHU1JuTmpzTmsvSUVDTWw5RlNpYUhJZVdRQ25t?=
 =?utf-8?B?YnJzak83MkhmMkNVTVNNU1NVMXhVZHlrdFNnZnVDVVAwSE1veE9wNEpacW1p?=
 =?utf-8?B?Tm1nenlrVk11aVd4TUZ6MjdrYkhPbE9TZVpBSEFWdks5NnozUS9mbkpJcWV0?=
 =?utf-8?B?TjVoS3UyS0JHWXdKaDE1V3crWmhTTHpBK1lZeno2NHBFVDNxNzJEa1ByV0x1?=
 =?utf-8?B?bVZQVmE1WitLQm9OQUFVSjZCNHFzRFRjN0pwYVVseHl4bzZNVXRDTGd3VkFx?=
 =?utf-8?B?Q1l0a3RlTkRxOW5rTFQ1NlBmbkFPeitEYTFqeEkvak1heHpDUFpaa0MxRS9Z?=
 =?utf-8?B?RmRnQUZQWFNWc0xiSHZYaUVDS08vMVBBb05yWno1UmJLRGZJZGlYZk0wVUVJ?=
 =?utf-8?B?cUlTK1lpZURTYzdKeDEvQjU1NHUxWllDNnJpcFRXUG03MlNmTUwvTnJrK2Nn?=
 =?utf-8?B?WWxCcTZiaHRubUxSVTJmR2F5ZE50d3VtQndnNWNpekRLblNwSCtJSGExR1NF?=
 =?utf-8?B?WUZzcjkxMmp5SkkxR1dUSGtMUG1xdXh1MU4rNGpzczN6dm55QWVuWDc5UWFZ?=
 =?utf-8?B?bkgvTmZnTTZubHBGZlY2YnRUSENHYjM0N29lcTVXZ3U3NUlZeE94UkttRTFh?=
 =?utf-8?B?UHlJY3hpd2VnbjVxbHRiRnJWMUduU292MzV4a0VpRzM0aUVoc21iWjd0SHcy?=
 =?utf-8?B?MFc3dVlpc1kyN3pHZTd3emo4cUZlUENyOHhFRFh2QVNEN3Rub2VsUmNkMUNT?=
 =?utf-8?B?VGJrQks3Uyt5Z2FrY0llQ0MxNTJxdjF5c0t4eFVjSUFnaGJkV3h0SFVBQWNE?=
 =?utf-8?B?Y0NWNVJwSHhza0ltMmsyZjJteE1KaEpWWGFTQUhSeTNUbXF3cHQxc0dhaEUx?=
 =?utf-8?B?dEFseHJ0bzduZ05qL1dSaVpSR09FZExpNDBub1ZJdzNnRENGOStkS28vMWc4?=
 =?utf-8?B?VXdZY0lEeDlkcG01UXNtcTJHTzhIeFdMQ3ZDTGxvSUZ2ZUhoUVJvYno3K2h2?=
 =?utf-8?B?b3Y3aHVlYTR5d29KZyt4VGM5Y3AzM1FSL2hDMkliaWFqNXU3V0ZmZnlpQkFs?=
 =?utf-8?B?UnArT3FaYnhXSGxrUzBvT0Ftb3lRYzR0K05vOGhWVWllank5U0szbkh4MVpK?=
 =?utf-8?B?T0IxT1NRb3FwVk9XWmxtQWtESzREcjNDaHJ2WWxyQ1FaZkpJMUNyS05pQjdV?=
 =?utf-8?B?UFlCRURBb0F5aTBlVXJIUmQ0Tm93NnFZZjF2MVg5SHB1WVowZTNnZmdYOUNq?=
 =?utf-8?B?U2lESEFPelozMHNzYnRDZXp2MlYxdlVxMVFZZXJXTlVDWER4WlpGb2pkUnZz?=
 =?utf-8?B?ZUlFRjFtMjdKbHI2QkFET0FGd2w2UUw3RzI5YmFjWVdrb3l0RGpsL0dpdmpn?=
 =?utf-8?B?bjRSdm8wa0hXcms3ampoNjRzYUo5L1hzVkUreHdDUWdXTkVaa1JRU0xETE1t?=
 =?utf-8?B?NjA3Nk5FV0NyUmRjdGlYRGRaWUdtSkxjOXVZZmZrSXFOd3NoYzNBSUdhdHFI?=
 =?utf-8?B?TGlwRFBVWHhqb0NMS0dMWjU0L2dUeGFpak1FdEgvRER2ZXk3MnBQWG93Q09K?=
 =?utf-8?B?bE5KQ3IzYnZqbUpZOW5LSkZOL0pEV3ZmYTNlbG5BODgwZm5XMjhvMGwydEhX?=
 =?utf-8?B?TEhqNmRqS3Q4VUxwUVpGTU81azlQU0tpSDZnYnFrcmU1bGl2SlJwU1ZWZllu?=
 =?utf-8?B?Nlg3UU84ampxSnVGYmtBcXZYV3pKck1PNmlkdk5Wd0tHcjlsNThPc0tDN0xT?=
 =?utf-8?B?Q2liOEV2YUYrUm9TWDB2N0kvMjlmR2c3RjlmaVNqTXFYRG5GeENheFVxa0xp?=
 =?utf-8?B?OEdQRkVGdmNvY3k4TXM1QVkzemZpZFVoSURWbGpFMi9qaGl4dWMzdXpZamJm?=
 =?utf-8?B?cUNBcmN0RE9aaTJVbmRjM3JtWmlQQ2NQSWJTL2dkUitETk1lOUQ2Y3NReFZy?=
 =?utf-8?B?azZvWEZnNUFuMG1VRnBLcGM5ZDkrSUkxZzIweXZPNlJXS1QrTERBQ2E4U3M5?=
 =?utf-8?B?bm9KNFNoc0lZUjZKUWM5Uzh6b054anhKazIzNjRZR0psM09JS244R09haSsw?=
 =?utf-8?B?S1c4SStkbGI0eVRLVFpOZ01NdUpBY3Zia1VQMUpEd2xQSXRHVm8raVdkK3Nq?=
 =?utf-8?B?dnRFU0lXVkIxT1FxalJIN1NyZUVERHcvY281Q2h0REowSjN2eE1GcXY4S1p6?=
 =?utf-8?B?Y05oL1JvbjAvYkxnTDBHV2wxampDWWZjQnRFdHhxcXNrbVVHYlIyUzU0bk5Q?=
 =?utf-8?B?SkRndjlSME1CSkIrZ1FFSWErMkxkZ2MxT3JCeUxQcm9HU0l4eUZER0NTeGpn?=
 =?utf-8?Q?iQfxzZpaN9YufgsAGtb7Uxv5dvsAJ/tr7Je7w?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f86660-7365-4efd-48d9-08de6d3cd718
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:22:00.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZlZxx5kDiGtZWMjXf6B6EtoARaAp23+z7c0xzT6EcUtTtcstCy1JWFgfwXFv3gVNzQ1Xp3xdGFMSljqz6WzTg2BRHWFsPCaGBvQL0rQN4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10223
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

On 2/13/26 6:42 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2/13/2026 6:17 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/26/26 10:55 PM, Jonas Karlman wrote:
>>
>> [...]
>>
>>> -&usb_host0_xhci {
>>> -	dr_mode = "peripheral";
>>> -	maximum-speed = "high-speed";
>>
>> This is not set anymore after this patch is applied (dr_mode = otg and
>> no maximum-speed). Please keep this part as is and if actually fine to
>> remove, have a separate commit motivating the removal.
> 
> I disagree, these props may differ but the function they result in for
> U-Boot is the same, i.e. ums and rockusb commands can be used before and
> after this patch.
> 
> The board u-boot.dtsi included something minimal required to have ums
> and rockusb working, this can fully be replaced with upstream DT and
> U-Boot functionality stay the same. Something I think current commit
> message is already covering.
> 

I read the commit log as "code is already in upstream DTS so remove 
duplicated code", which isn't true as two properties aren't 
making/haven't made it.

At the very least, highlight those two changes and justify why it's fine 
not to have them anymore.

Can we enter SPL_DFU mode with dr_mode = otg? (I assume we could in the 
past?) You are the one who added those two properties in 2024 and it 
also wasn't really motivated back then, so why maximum-speed as well? 
And why is it fine to remove now?

Cheers,
Quentin
