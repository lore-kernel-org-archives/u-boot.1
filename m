Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D81D1F9AA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0639283B24;
	Thu,  4 Dec 2025 11:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jYt0sCVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8281883F9C; Thu,  4 Dec 2025 11:25:08 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F42E83AEF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHjIQGNXzkoMKzDi1XPmhp8sTN3jtfqUY4Q+8RVVWrUERT5k+HBDARQ3iYGuckZ4Z1qipTsX5NmhZXKtnI1MiUj4tI8GqAqFNHtZbrkFHfOPgEuE/rTv3yagkUMzSj4lvO1WeJk1DieESqU6L744W0JyeRFoA8mLRTsX6H0/hRxvIm5bp/K1Qkyncwrhq6/MoVm3UC+rvEXv5MA+iZPPpWhpoXR+4G/AUT5xUw0AT2yJj1Z6A9itYaPWMH5KQ7OtopcpHD0q2tj6TAjqHBLdTNmPvtAttx6V0Nw08gFttxg2prQuwoHZE5RAINVHWL5LWey39/XB6xoUfzMxIpvkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNSUHPat4anqXPFD/tZ5Z3vVdWM2Ax7zrNkgvg6KfK4=;
 b=rpErFfuBqwI1RH2+3cRCt+a8hdih764MIwWKbdaXNaT5JF2R0UvMtHv+p//LrUtT9NKhA8I3VwHVfMZZZHMwDYw9mV6MhnASmeoWipV6QkbLJEBRDE6lkZtEtHRpmQG+EnjNm0l9IdhFIPG3IG7iPO0rSbbxH+D+nYyMLVpTJvldsD/LFYr9RyT49V3iq18YM/VUFVqQ3yDO42m9zr4ifV6prNg0esfdZJoUcDbVk9/JvJ4rZmr7kSMVBttpdmdY6+7H14g0K5o5NOv+WS+MhUxgp//RKh8yPwwCXShA3Td3k+UG+VYou4J0wrv51SD54yK96BbbSrigbT0LAMALzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNSUHPat4anqXPFD/tZ5Z3vVdWM2Ax7zrNkgvg6KfK4=;
 b=jYt0sCVxx4RrikZGPQiJaHfIQdo8RhxFiYpK4AnYqGlHy7tyeE6BOZrF/j3nwPiWK0vrQBMnvFVo4wxodynwG8wjf4p7n8e/0iPJDO585bN3lyh4a9k0PPsBG/6VgRRo/KT/XtD1XcKHfSGeSpECBX7B69jbtUgeFCQJhmoSNal+cylCsWOPR6MrSS8IJsZf7TNK9m9sg+uGAtxaIt8M3ZN01Cpu1SwynXJOtPnI+OnMZ3h5GXueiECJ8wbujyhaqOu1dJy0vCaERIrw6dZnSoT0U6gODZIQNft8eqq+73/QGufjSPHgK/PxKmXLpkO52TDfsN93lsm+2mzwO3K37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB5267.namprd03.prod.outlook.com (2603:10b6:a03:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:25:02 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:25:01 +0000
Message-ID: <4e9267e2-e219-4680-a7e6-8c89fa46fcf6@altera.com>
Date: Thu, 4 Dec 2025 18:24:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: arria10: Disable mkeficapsule tool build
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20251204020810.24716-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251204020810.24716-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f99c0e-b3c1-43f1-ae41-08de331f6193
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eitySkpGN1ZVTUFNWVpLeUVqNXZIWnEzcVNBRlVKWkJPWU5kbWR4ZUZPREpu?=
 =?utf-8?B?TXZ5WjRyWW5id2VjeXl4bEpDNnd6dHk4c2Z3bFhUb3FOOTgvdDFFeEsvdXdE?=
 =?utf-8?B?VkV3WEpXL3R6RjAyenBiMytyMzllcVh0QnQyRXRrTXV4VDhNTjZKSGY5UFNW?=
 =?utf-8?B?YlJxZ1pWS05OclFWcHBMZEk2RXJqZ3JRVVdxS3FNdlR3V0ZlZ0J0K3hnNWpK?=
 =?utf-8?B?NUJLaWs4RmN5WElra0JpL2FTaTd1OHdyNTdhd004WUc5STN5c0hISjBvSUZZ?=
 =?utf-8?B?dHkyN2FQd2NpSDRiZEFka0JqdlFIU1M0YnFJdHU4WWNXbEJlS2JtdnhoRVN4?=
 =?utf-8?B?a1JOOVovTmhmL3BUV2RlaG5aekRPZmpybU9lT09vMnBqaUo5UGduUmN1L2l1?=
 =?utf-8?B?RnFsOEJKMHFEakNIbHRkdHR1WHJBQVJLci9UTzkvT0FCWThsa1QwcGJqLzJu?=
 =?utf-8?B?dTJURDVlSy90SEVKZjlCN1lYRUxqajJVSVVyN1hyTE9PWlBwYmtRVmRkcng4?=
 =?utf-8?B?dUgvNFVBcEdoOHg2MC9sNTc3V3N6elJuVDl5djFwVDExbU13a1Z0ZC8vRjBB?=
 =?utf-8?B?MFJZdUNrQjBZcXMwdjRwMTVUUW83NERjYTdnQUhEaUJPajF0NWNtcnQrN3B1?=
 =?utf-8?B?NGZGRVhNSk1lcXVuTEF4cDIzekFVbjFycnNBdytJTEpyR05iRkVYUlJBRnZj?=
 =?utf-8?B?cXVKekMrbFRZRW9DeDJGMFdlSE1YT3gxNFM5SU1IREtVNVEweTdGOHNEMmhR?=
 =?utf-8?B?azhVaU0zN3RZTkRzVGJzYUpmcTN0cEdXU2pnYUhENzhZd0R6Q0pjaU5yQUh5?=
 =?utf-8?B?OTM4RU8rRU4yU2lkaTc3WlNqYTRsRlMwcEFteHNXbWtFRndielB3UnFjTW81?=
 =?utf-8?B?Qk9JRmdiRWpDb20wTFRLL3R3NW9aRFo2THNsL0tzamVwQzNLL2kwenNMbS82?=
 =?utf-8?B?eW05N0MvZnAzSG4vZnd4ZGE3d3lPMXVFQTROeGZmMDc0OXNsMUVPSzhQQjc5?=
 =?utf-8?B?blIrQnFTaHVneE1FMmg0WE12YUtoTExrUEtUOElIVjZNSFBGZDBVVURhbTB3?=
 =?utf-8?B?bzVLeUN1dFVyQnl6aUJLcWRQTi9ScUMvZEdBeGVMNW5PR1RIK0prTkcwMFNF?=
 =?utf-8?B?UUlhM0g1M05QL2hVNmVLRjhDR1AySTV2UmlHaUVuYkdGbXFGRXlQZ21sVDlW?=
 =?utf-8?B?dHNIeTFwUTBURm03N29LaU9nNE5XYjZkR2ZYaWhDakVuc1BTTm5XUndzV0Jl?=
 =?utf-8?B?MElyNi9ldDZCQjNMY3UwUG9KWGlVNFJrbytueGltL2c2ejhEdG1samcwZTUx?=
 =?utf-8?B?L01LTVlUS1d1VUF5ZHBqbGNIR2JYd1B2OGJ0OEplamZzdTRuNGtOWE9Jak5F?=
 =?utf-8?B?YitYaml4ZFMvVEdqSUNPWHNGdFhMVTZrR0swejRkWm5tSE9RN2ViSWY4VDZP?=
 =?utf-8?B?ejhYMVF4cjlBaDE1VDZFcVlqTDVjb2ZjSVhpeHlvVWdlRWhQVmhkNTU5Wkhp?=
 =?utf-8?B?T2kxQndGNDZOUE9XL0RpaHpXY1RPdXV1V2JWWG05alVZVzF0REhzOGlHRkpN?=
 =?utf-8?B?Y0k3NHU2dms4am9TYUlISVppNU5VeXdiTzEzMnFBc2tKaXVNVnlRNTlHR3VS?=
 =?utf-8?B?MllzUThoVHdUMzlGSjRHUEh4OHl3Y1RDVm5aSnJvSjIwNUNCeFF3V29OdjZs?=
 =?utf-8?B?L2ZVeXhuWllFbmNHai9hTUo4RDh3QWxjR29vbXZwL1dDTW1PKzB0WGtKSUNp?=
 =?utf-8?B?NEtrRVMwdFlmMlpRQWdVQzYrV1Z4V1pNWFBmdVY1bEtDZU1CS25kTWtXN2NU?=
 =?utf-8?B?WjI0cUs3YlNXZlRFNWNqdzlVeDFsWERiSlNXWFlQODRTbXVaZzUzTzUrelFM?=
 =?utf-8?B?R24vUitZcTdJV1gyRWpFRTd3OEw1dTArcnNwTXhGWUt4c3NOMTRYYTJER2Rs?=
 =?utf-8?Q?uicbbvf3Y+2+MZ5lvuRfOq4wqWHF+pdK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZqclhkRlB3dm9Zb2pabXFjUGtFSU0vbFY2TU9wL2NzU0hFc3g4blBjRitu?=
 =?utf-8?B?NG9tQ1ZFVnpVTGF4SWM5dURQZzRlVktWZm5LS25vR2hTb05yY0U3a1YrWHpQ?=
 =?utf-8?B?WTkvZ2p5Y256S0ZUeHhJM3NPdUcycjZCTXF6ZG94MHZjS1BPUFMwQUROTTY0?=
 =?utf-8?B?am4wZVBTMEJ5MTdNVmx3aGtER29XVlJUMnR6dGpNUi9BNW9tK1UxcXluN2hr?=
 =?utf-8?B?WTNvaUY5MVlEODQvcUJYZ25wNElyckN4MUhDREN0WlZWcGJrazROU2VxaVp3?=
 =?utf-8?B?UUhjM2IxZGtGZi9DYkxnc0pzUmc5NkhlV1FUR2ZSUXlEU09xNWNYSXpEWUV0?=
 =?utf-8?B?ZUZ0MllkZHlndE8weTV3OHNyeDZKcjdvbHl3SHV5dWo0L1JwUlZhVTludDdG?=
 =?utf-8?B?ZU9weWtiWVMvWGNHdXVoRTE3ZnJXdUFOMm9zdExBN3NSUUQxKzE3VXJTbUtG?=
 =?utf-8?B?ZDZzdnJSLys3dkxKVkJaRnBtUDVkelpxbDIyRlhyMjVxLzhZVFRMbmZkRmRY?=
 =?utf-8?B?V0YwVGl2UUp2NEFKK3ovZThycmxUdi9wbDFLN3pMZDVrMjVINTJ2dGNLNHQ0?=
 =?utf-8?B?RlJMQVBuVGQ5Tzkrb0F4dXovM2JSb0pjc1Q0ZWtpdThnR0NiNmxKZkdVVmxk?=
 =?utf-8?B?VTFNZ1Z0K0E2MG1BSGx0L2pTeGRmRU10VHVra1I3bVlDZ1R3VUdTTnZoU0k4?=
 =?utf-8?B?cHJZTFpSem1qNk5IREs0d3lzaWp5eXg5Z3FVc1Q5c1RYSG42QWowQWkyaTNi?=
 =?utf-8?B?bEp1SFEzOENNMGJlR2xsRS9WOS9pN0JxZm9sU3lKc1BnYVdYTmlFbVlydE5v?=
 =?utf-8?B?TGF4REwrL0F5d2M3VlRyZU5sRngzY0JJc05BL1JSUWs2UHZqdEhDa1c1UzJa?=
 =?utf-8?B?TEw5Tm5xT05mVXBvL1BnMlUvVlhlS1FBY0VGSnM3Tk85cFMveFRwcHdtcThJ?=
 =?utf-8?B?Y2VHSXkwUGlKd3lKSG44NUhBL0Fzait3cXFFb1RZTFJQajJrQXZ2NndSMk9q?=
 =?utf-8?B?TnhyRm12d1N2eDZqRytCWkRpRkd2VmR0WVBnTmd5bEMraHlQdVAzcHpPZldP?=
 =?utf-8?B?dnhaOWoxcVdFMStaTmpNR3BxN0FTUW85dTYrN0xURXNWSEJkd25SWm1JVUNp?=
 =?utf-8?B?NXAzd3pkRjZYeTNOa1JhUWpUNTZPVkRjZmNBZVF1cGc0andDTGZwN0o1eEZH?=
 =?utf-8?B?Mm1haks3dVpXSHMrUnliUHI4NnlvMmgrc00rMU5MWUlPeGVNVFZ2cVlpa2Ju?=
 =?utf-8?B?UTNKaCtNOEdyc21pK0FrM0YyTVIzKzFkRndtK1hpYWJhbXR5YkxZWHBmdE9Z?=
 =?utf-8?B?czJGdVM5cEptbWxEVTVPNkxSK0lDMjRsRHBNWTA4MDhDWWM3Y2dvRW1GckRW?=
 =?utf-8?B?UmJxL1ZMbjN4aFBkUlVCa2E4MVhxbEdGUnA3cG8yRzhUMkNnWEttQURTRVVD?=
 =?utf-8?B?NjZscmM3US9qNFlFT2RSMWJLUkVvTFVpV2V0TzVBdFpNaSs0dUtyN2VmUjRu?=
 =?utf-8?B?aVR6SXU4SzRvTlJ3enU0aG80STd2MGNZWkhreWpxK2FsdzhLeXhtZnlFNVhV?=
 =?utf-8?B?RkROTU9KWUN0QVVGTFRJVmEvS2hWMU13cXJLdDNVemdqNzJUemFucUlNTFpD?=
 =?utf-8?B?VW5jeURscExibm1pU2dIUVROb0dQQXZxV3dBRk01YjZ5a2djd3o4MFc0ZndI?=
 =?utf-8?B?L0RVVjdNbHUraXo3MUtoTUk5dUw3aXR5dERsUGNoTHpBVWhjN3diditXOTJ4?=
 =?utf-8?B?YXAxUGtDbmJlbi8yOWlNTUxFL05XTjM4MjkzREVmdGlmM3AvUXFMU2R5dGwv?=
 =?utf-8?B?WFdhWEdqKzRRZHduUEs3N1h6OU4vb0VCZ1Y5TE80azhUY2kwVzJkakpXSUJE?=
 =?utf-8?B?YmZaSU9HMmJkYzZTdE0veEdoYmtKN2xwR1VKRjY3UjkzT3dJcTRKZldoMzFj?=
 =?utf-8?B?Y2VLQkd4cEd3d1FaQ3JWbFpxUFh3SVArSThRRmRTNDUrcVp4K2cycVl2eTdv?=
 =?utf-8?B?RGVwekJHNFpPT3l4R0kveHZ0ZXp5S3l6c29yZkhsYXBaWDUwaUFBSXBWZHgv?=
 =?utf-8?B?Nng1UGZIb0dydVFTS2tQTTRLNithdCswU0ZFeFBUay9yQXgwcFZRMnZpWkdl?=
 =?utf-8?B?eGlRaHlmWEZib2dIVkoxK2QzN0hoUnhDUVJCMXdYS2Vpcm5MSXM0REtDOGRu?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f99c0e-b3c1-43f1-ae41-08de331f6193
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:25:01.3685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXWGbRfjNHvqAbHWKG+jF8KYcQund+AOEo6K4G9wPnV7WxDy2BuMSiWVh2x/WPpacF120ayhpOrSL8V28dvMOZfNBwwoA1ntlDTJDgPJgqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5267
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


On 4/12/2025 10:08 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> mkeficapsule tool will be built by default if EFI_LOADER is set due to
> commit b7a625b1ce49 ("tools: Build mkeficapsule tool by default if
> EFI_LOADER is set").
>
> This will cause compilation error on all our SoCFPGA devices, hence we will
> be disabling this config as we do not utilize this tool.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_arria10_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index 76fdc0aa4a6..b32f40ae408 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -68,3 +68,4 @@ CONFIG_DESIGNWARE_APB_TIMER=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC2=y
>   # CONFIG_SPL_WDT is not set
> +# CONFIG_TOOLS_MKEFICAPSULE is not set

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

