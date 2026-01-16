Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40CC79FBD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C443A80077;
	Fri, 16 Jan 2026 15:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="qL8F1u/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1908309A; Fri, 16 Jan 2026 14:59:28 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A6380077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coOKRx0vOOoUYGNUu/UvdoYgBX3eFlIplWSE5uV50e6Y6ZMDK5cYNxl/uat+EYdvrnj/k86gq4ET1AG3/Sh9n5tf5NtTJ//ZZ1nC8fC/mTRyxP6SQzSQOzF6i8vcw+99bPZB1FQFlAgEEbPjceSuYSWlG1t2jne1uNjSxF04mnoAEF9WK0gl3V6qFMHlNzQTdrCyYNPWQReIjMX+UrewbDIAEcVopgj79YcjRitqefuvHRD24E+Xr2QJFyr3TvQnx7GQ/WgQyo193LfCMfg6rUfmtE/ZmnfrRgFO+omY8EGlt5Biutv42MDEU8jZbGNaDXkFds6Ju0eQAQTylLY/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRfF+KgulUP1KlwwFWHWzT4QqrMlB5udp2r9/UguIH0=;
 b=JXiDKU4ohYjMmo1gwzhVaP4N7VEBODeZTMDYRX4y9t7uAngnG6ZOHtmX/4XNWm6IlbWg7jXo2cbGKFSYH/2KDX1T/57Rhwb9DDxJCho1vBKuBVU93Xv/lOW05k6YT36FEDY6uvDC920kW/38oALws7OpS3Ef0dneVbnYmR9j10J3fsP9L/qWy9s41B6uLOugOiK2PjXI30LDVezdvbXuA7NTFN1gro0On/p5U2bYzl2e6L+kOl1MGcLu11dE7bUhckUyiV9fNCyjgwskzT16H2/AzBAnvNUiNUdE55Sqnt8nn3z8H59HXMjzJUcvBG5jyKkMEjbCU1TZFpF34g5CiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRfF+KgulUP1KlwwFWHWzT4QqrMlB5udp2r9/UguIH0=;
 b=qL8F1u/X5Hx5aH0P/PCP2QHlzxziij5Ar1Y6BE+pUYDwzcyIZ3rRABji2zi+zRelyXXooqSLNFxZlvtrgTH2SxnD458gsM5rU56bf0x9EdL/MlE8GLLNKV7PUuTvk8f0DpQhLNj8q3cfLMEVa7jN8oKRqDCKtmIEytr9irpKo96vsMvWYrhYC27O5XAJ/0AdJBRso21Hw26GiTLaJ+23YKJ8wHEt3HpQkyBoi1qO8krIOQWAByDyOlCxqH0C73+MTI9gt4YeySDBSeDd2mBIDW3HHpDIJ/lLNcadRDLqHMYOdWsoTHv9xFnE3czFbPvWzuV6U27LcL3YA5bAAwt65g==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Fri, 16 Jan 2026 13:59:21 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 13:59:21 +0000
From: <Jamie.Gibbons@microchip.com>
To: <trini@konsulko.com>
CC: <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>,
 <michael@amarulasolutions.com>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>, <fberder@outlook.fr>
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Topic: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Index: AQHchWGRWanG+SXlbE+k2PlHaUCZCLVRupuAgAAHLQCAAaguAIAAC9iAgAAqhwCAATWFgA==
Date: Fri, 16 Jan 2026 13:59:21 +0000
Message-ID: <694fd0856209d75319393badf68188516c17d8f7.camel@microchip.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
 <20260114145842.GD3416603@bill-the-cat>
 <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
 <8b4d8980c4c16a2d0f6e1b566f85034047c24fd5.camel@microchip.com>
 <20260115193130.GI3416603@bill-the-cat>
In-Reply-To: <20260115193130.GI3416603@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|CY8PR11MB7797:EE_
x-ms-office365-filtering-correlation-id: 24cd6f8c-4ad1-4ef4-e2e8-08de55077302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d3Q3aVRuUnJ5K0x3R2xYRzFyYzhNcUFKcEp5YVN4a0dNWEQ4TXN0cVlSRG1B?=
 =?utf-8?B?NmpJN3krTGI4c0Y4c3lxMlExRGpXc1pTL3Z0QjhGaWF2OHIzNlhlcGJiL2g5?=
 =?utf-8?B?WlBSeSt4cTN1QjhnY29CbGRUMjVMelNGeUhJY1ExRUdkbmh5RmZJL2ZYRTVz?=
 =?utf-8?B?QVhLdDFSQlZrejh2SFRWRG9KcjFEUFIvazd0ekp6aDdqSnFUZW91ejlUd2o2?=
 =?utf-8?B?ald2YkNvK0pLaXd0aGRkVkhUYWtIN3I1VnI5dmtXMUxrVnByT0NCOHF0MjU5?=
 =?utf-8?B?ZjU2b0dnRGk5SFM2RWEvandGdTV6bUt4KzB0RjlVME5DZnhIQ3dhbWFOaWs3?=
 =?utf-8?B?bmk1eStGdnc0Smt2SlZXMEFJd1pjYlZkUkRvSTl4ang3VVNLNDBLbFBTeGpi?=
 =?utf-8?B?ditWQTFOcVdpR2hxdDV1Z1F4TCtoRURsYUxZTmgrcGZYbXpUSFlKMWgxK0Vq?=
 =?utf-8?B?eHBZNG00SW9SQVdLSlV4OEVWVjVkQkZJMkM5Vjk2VnQrZlltQmg3S1JUY1FH?=
 =?utf-8?B?S1lYZXVPbEttdkFxTWhBbmdDK0hWNStWQzl2VUFkdm9CMzcvU2NiRWFCWlA5?=
 =?utf-8?B?VlhOQTdRQWZTcFRtZnVSMFIvMHZqeWpTdWhRZVd5eFZJV25ZSHJ0UTBmdmxa?=
 =?utf-8?B?dE91TU1KNHBySXRueFdOY3VlU3pIaElyU29pRERNcjVnODhlZ2VleFExRDFM?=
 =?utf-8?B?NmJCNEt2WUV4RkNOREtVUTJxZnVzK2tlUmJHZW1tUEJ2aUVmOGIwUitBV0Iy?=
 =?utf-8?B?NUNIayt6d3NCazkrTHY3RUR5Mk1yUE84Q3lXNHIxb2lZVHlSMmVEMi9jbEUr?=
 =?utf-8?B?b01xV2VoZEV2aWUxQTdMNnB0bXdVSFc5WGVPZFJ3SEh6QkwzMHZxK3J4TFRW?=
 =?utf-8?B?cWZUeFc0ZG1BSTVnblFBanhDV01NQ3RCYVArUWxtOFJyS2kzWXQrYklvZVBE?=
 =?utf-8?B?UUp1TzFxYnE4TVFkbjN4YmErWEdSQTc3WC95dDFGU0hMa3lKeGVtNC85d2Er?=
 =?utf-8?B?ZGdQYUloQlhNTS8zdlFJWUY3eXhlRi9wdTZXN0NoSmdUS1ZHWFRISjNRbnJE?=
 =?utf-8?B?eEMwZHRXNnVxdVo5K3dsWVJBKzdGY2luRGhtOXJsVzk5RW9xTDQ3QmgwajRP?=
 =?utf-8?B?bUYxWkVVT0JkeUdHM05VSW5jQW5ySEJXV3BDZit3OWxzQXh4K3lmMmVzaWVH?=
 =?utf-8?B?UTNwT3h2T3AwLzR3Sy9xOWduenNyWk9NMnFaVklqMHNpNDJTLzhoa1RJUnph?=
 =?utf-8?B?RDZRVTZoSlJZQ05uVWprR2V3MGc0QjhBYmRVdDBVbXlZblgwSUhYVEFHWXBV?=
 =?utf-8?B?Q3ZOTUJpQklQcXVIemVjQkZiRjdYMmdENmIzTGRnTVB3d29FY3RjakdCWnBJ?=
 =?utf-8?B?OTdzUVhWTjhmRjkzbHlQYyswMEo0VkJLQWRQSW1panMyM29Bc250T01pb1Zi?=
 =?utf-8?B?Y0dTMzVEQUttRlRZUEFHL211aHROcUpnWUtGb3lvaEZXNldvbWxEVUxCQ2Ft?=
 =?utf-8?B?ZmJhZDBGYzZKMG9XYy9mWHlsOW5QejdSMlFQaXJ5WHJPRWFxZVBGcE5KREJl?=
 =?utf-8?B?ZXVmMUVEbkZ6RmRkdE5iWmhvMEpZVzlvbXpYWDl1Mms0OTFMTURGTGcyTEFp?=
 =?utf-8?B?YTBGRDdQR1RFV1RkeStNNkplc0dGRnZXLzFKZXoyWi91OGlHSzdoV1J2NTVl?=
 =?utf-8?B?Vy9LRjlsN25uc3JSRDhldFFWMVlGTlgyUWNycEpGNnNwNFVkcFdyalc0Q0oy?=
 =?utf-8?B?N3dESHlaUFhnNHlSR0dtWXFucE01OVNueWJGWDhMSmUwTWNTVkdkdWtYdDhT?=
 =?utf-8?B?Ri85SllwYTFTaWkzVUFOUkQ3czBtMEdOcFRPdElkdkNURHF4Q1FmRlBqMmlv?=
 =?utf-8?B?REZNaE8xUmVPdEo1WCs0MkNPaEJrcXROSkJwNnRWMEFMcWlOZ1hsL2VINVI5?=
 =?utf-8?B?R2t1eFE1b1g0OGtmcUdCS3c1cFhiZmdvVW90bExVNVpHcWxmOUV1RGg1WkFU?=
 =?utf-8?B?dUt4dHZkQXJ3MVVDVnl5Yld3NXlES0NHcDYybGs3WER2bnNGbWJnR0hBbmc0?=
 =?utf-8?B?N2VreFZvQ2NyT25XTXNGUzRwRndpaWt2K0FtYW9LQUQrUTFiRHg4NzRma3dG?=
 =?utf-8?B?dmROTngvVjA1WnJwSTFxTTdtNml1R2did21xd1BzVG1sTlBmbmlyVmVhaDdU?=
 =?utf-8?Q?H5h+CJNqxohq7aEysFlKd9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGV6RjgrY1pQZ243Zld2WCtLU2dhZDNKL2QzR2xTRTZEQ1p1M1ZGMVZNUm9L?=
 =?utf-8?B?eG1iSVVvYnZCNWl2NUp4MThxSXo1TFNTM1MycHJDN0IySk9jbWY4U1hvMVc4?=
 =?utf-8?B?eVdHNHBnQnRrTGMvSjN3WERSckFkTFRXbGVOeW4ybGVySmFRa2QwR3ZZRDVF?=
 =?utf-8?B?WGNpTlY5VGpFVHpoaTQ3ZUVhUWxnUUxFOXRUb1NzMEhlVE9kUkFQZVRtNUUy?=
 =?utf-8?B?VGVRYmFOQW1ZTlE5RGc5blFXZDRmZEdvRVdmeVR4VDI2ekQ3cVJ0VnRnSDFh?=
 =?utf-8?B?T3RlYnkzc2VFQ09uMGh4SEJHQ0V6bjA1ZXh4N3BrdTBxSUUwZzlqRkoza3ZP?=
 =?utf-8?B?d2FOL3lnL055c3FjdHJ5WU9ZeFlPQnlmZkxzZE5OZUROQkJYZlBOVWJxZmhZ?=
 =?utf-8?B?MmNZMnR5Ry9BdSsvTDdtZndybkh4c284TFlSaHpoaVpRRDVYVkg5VHA5dDVN?=
 =?utf-8?B?cDFlYUQxdUN4NnZZMTk0L1NyOEMzSXN6cXJtQnBhTXJ4V1RFYWxtRVBrZnkx?=
 =?utf-8?B?dlFnYlc0N1A4cFFxWlRPSGRmYnVYb2VGYWlvYkxVSll3Z1BpTzhvZ2lWanB5?=
 =?utf-8?B?RzdJWWFpaEV4UEFweUZ3M1pUUmhuc0FrN2t1TXJheGlkTWRFU2VXK1FOV2hV?=
 =?utf-8?B?Qm90eEhqZHJObEo2eVkvMklFSTBHNXdPQzRZbWdVZ3VPcDNicnEwdVhxKytR?=
 =?utf-8?B?WFMrWm1ZUWRFZkk5cVFhMDV4Qjd0UmNlMStxSXZyYkloWFFxdklSaXV5T1VR?=
 =?utf-8?B?Z2lrUG10N0h4YjZmdm1XWkhDY3dQc2xCL25heGdZZ2l2cXQraytLd3VtZ2Zi?=
 =?utf-8?B?b29GWXY5Nk13TXZXWFF3SWE1TVNxelFQZDNJbEVUQmtQeS9XNUs0RVpyb2dL?=
 =?utf-8?B?dmdmbVNGTXlKOFFMMTFJOTdjN0xwc3huRkhtWHlHU011M3REMmp6YVgrY0pE?=
 =?utf-8?B?QUlXMVFlWEVZYjRnM0JIRVpvTy8vck9GdmsvQW1rU09DVCt4UXh3WXV4UXhY?=
 =?utf-8?B?eXlZQlFpQWRJRE5JS29tTlVaUzFUMnJYTWZKWmJCMmJ6UVBKSEREdDU2RTlw?=
 =?utf-8?B?Qi80Rm9WREdaQURQVXFpamlSZWxXT0Q4dWdFUFZCdkxMKyt3b0NLNzFObFl5?=
 =?utf-8?B?aWdzRUJCZ3hWM2xYUTh6R3NoVXh5UkhwMUpjeWo1Y1dCYVFhamdJcWlmTHlC?=
 =?utf-8?B?RnlPRHg3MjR4VmRzVTU4cUlFZitzVHFYTHJxZllGeFNkNVhYNzdLMm13VEVW?=
 =?utf-8?B?cjVjcDF5ODFzY2pYVllrV1lFTEtENVAwaDVuYUZkQTZHSFJZZmg0aFBsZFB3?=
 =?utf-8?B?TENkTTRXSlNpMGRLUFlpWnUwN0dpZVhkT04rQzNpWFVTd2Q0eWo5NHRpSUlY?=
 =?utf-8?B?c0czZDhJSEQrdnlaVlcyQTlMSnZZelhzVk5KQi83NEZwcmxsMlptTlgxcEtH?=
 =?utf-8?B?Ui9GSGUrZ2RvaVFCMWpMdDFMc01WUEtFVU5VNEVteEViZ3FpTlJHQjhPMkVL?=
 =?utf-8?B?eEt5eUZ6QitOK0h0US91dnFFTHN3V0IrblV2MnRvTlB5czBORTZYUW5KMWRZ?=
 =?utf-8?B?cWdBdXZMdGdOYmVvRjMzYk1DWmc1NFpMYms0QlViZTZIVkN4THowazIzeGdL?=
 =?utf-8?B?ZHRYSzZHN3F5dlpxNDg5bjdsajAyUjJYdHVpdlZLNlVIQVA5endPMkpFTDh1?=
 =?utf-8?B?MHZmRkczMnNSUmowQVVpQWZ4cmIrMUowTjBnYXpiMUdaUGNBUGxMbUl1cHpV?=
 =?utf-8?B?VkFmMEUrK3NpbnRrUjNTeFRYYSt3N1hMM0hITjY1Wlk5anN0bThVNzNXNmtE?=
 =?utf-8?B?UytQUVQyMFdLUi95K01qdHBPVzY4Qjh1NXJFRVFSVUp4eGF3UWNvLzVEYzZE?=
 =?utf-8?B?T0dVRzAxM21MVDZCQzBuOVlNcWZzRWJoa2gxeGFjOWQwakFWdmErQ053TGdl?=
 =?utf-8?B?UHJSTHJYL0cxY2hNZ1JubXh2c3VHSnFLbUx1d25XNkg4ZVR3RFkyYXNFR2Nu?=
 =?utf-8?B?ZHdZM3h1ODlwNW5IZktaNGROck5qUTF5QnBlQzJhVmUxRXRUZ3Radzl2TFpw?=
 =?utf-8?B?UnUzK0tmQytIaGFHcU1tSDlNdzFBOU8vSndTSjFWMmVNaXZ6REY0elJkNm9n?=
 =?utf-8?B?Q0g4SERtcURUalp0Y2hYeUVIbkQ3dktLbG1TaXhITnUxNUsyK0pvRk1OT3g3?=
 =?utf-8?B?UDh1eDQzMkxJK0JPd2dTNDdVSWxzWHNyV3ExSHUxN2g1b1BwNWtkUzkyOHU0?=
 =?utf-8?B?bHFvQUU3dWVJWTVNUXlXdGR2L0hjSWZNN3VsbGVlZUdnVEtndFZmcHNUVHRU?=
 =?utf-8?B?QjNUaEk1T1NXN0l6RmNvZEptU2xNYk1qSS9najJhNFZndGp2dUdHcWZJb29w?=
 =?utf-8?Q?QNgApH3MKItAlAE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3754552D44669E47AF1882B7DC241EFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cd6f8c-4ad1-4ef4-e2e8-08de55077302
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 13:59:21.5721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnxivDprmSlWSsq97Wd3TjbfjOD8d7TLAsFhM54dLXUwAXevSkChrGiOyAQITUfSu4axHk6bzgPL85k4ULa5aHO9uiixi2dXtGlCyZ5Ozk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-Mailman-Approved-At: Fri, 16 Jan 2026 15:56:25 +0100
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

SGkgVG9tLA0KDQpPbiBUaHUsIDIwMjYtMDEtMTUgYXQgMTM6MzEgLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOg0KPiBPbiBUaHUsIEphbiAxNSwgMjAyNiBhdCAwNDo1OToxOVBNICswMDAwLA0KPiBKYW1p
ZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IEhpIFRvbSwNCj4gPiANCj4gPiBP
biBUaHUsIDIwMjYtMDEtMTUgYXQgMTY6MTYgKzAwMDAsIEphbWllIEdpYmJvbnMgd3JvdGU6DQo+
ID4gPiBIaSBUb20sDQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgMjAyNi0wMS0xNCBhdCAwODo1OCAt
MDYwMCwgVG9tIFJpbmkgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgSmFuIDE0LCAyMDI2IGF0IDAy
OjMzOjA0UE0gKzAwMDAsDQo+ID4gPiA+IEphbWllLkdpYmJvbnNAbWljcm9jaGlwLmNvbcKgd3Jv
dGU6DQo+ID4gPiA+ID4gSGkgYWxsLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFNhdCwgMjAy
NS0xMi0yNyBhdCAxNjozNyAtMDYwMCwgVG9tIFJpbmkgd3JvdGU6DQo+ID4gPiA+ID4gPiBUaGUg
ZGV2bSBhbGxvYyBmdW5jdGlvbnMgdGhhdCB3ZSBoYXZlIG1heSBmb2xsb3cgdGhlIExpbnV4DQo+
ID4gPiA+ID4gPiBrZXJuZWwNCj4gPiA+ID4gPiA+IG1vZGVsDQo+ID4gPiA+ID4gPiB3aGVyZSBh
bGxvY2F0aW9ucyBhcmUgKGFsbW9zdCBhbHdheXMpIGF1dG9tYXRpY2FsbHkNCj4gPiA+ID4gPiA+
IGZyZWUoKSdkLg0KPiA+ID4gPiA+ID4gSG93ZXZlciwNCj4gPiA+ID4gPiA+IHF1aXRlIG9mdGVu
IHdlIGRvbid0IGVuYWJsZSwgaW4gZnVsbCBVLUJvb3QsIHRoZSB0cmFja2luZw0KPiA+ID4gPiA+
ID4gYW5kDQo+ID4gPiA+ID4gPiBmcmVlKCknaW5nDQo+ID4gPiA+ID4gPiBmdW5jdGlvbmFsaXR5
LiBUaGlzIGluIHR1cm4gbGVhZHMgdG8gbWVtb3J5IGxlYWtzIGJlY2F1c2UNCj4gPiA+ID4gPiA+
IHRoZQ0KPiA+ID4gPiA+ID4gZHJpdmVyDQo+ID4gPiA+ID4gPiBhdXRob3IgZXhwZWN0cyB0aGF0
IHNpbmNlIHRoZSBmdW5jdGlvbnMgaGF2ZSB0aGUgc2FtZSBuYW1lDQo+ID4gPiA+ID4gPiBhcyBp
bg0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBMaW51eCBLZXJuZWwgdGhleSBoYXZlIHRo
ZSBzYW1lIGJlaGF2aW9yLiBJbiB0dXJuIHdlIHRoZW4NCj4gPiA+ID4gPiA+IGdldA0KPiA+ID4g
PiA+ID4gZnVuY3Rpb25hbGx5IGNvcnJlY3QgY29tbWl0cyBzdWNoIGFzIGNvbW1pdCAwMGUxZmVk
OTNjOGMNCj4gPiA+ID4gPiA+ICgiZmlybXdhcmU6DQo+ID4gPiA+ID4gPiB0aV9zY2k6IEZpeCBt
ZW1vcnkgbGVha3MgaW4gZGV2bV90aV9zY2lfZ2V0X29mX3Jlc291cmNlIikNCj4gPiA+ID4gPiA+
IHRoYXQNCj4gPiA+ID4gPiA+IG1hbnVhbGx5DQo+ID4gPiA+ID4gPiBhZGQgdGhlc2UgY2FsbHMu
IFJhdGhlciB0aGFuIG1hbnVhbGx5IHRyYWNraW5nIGFsbG9jYXRpb25zDQo+ID4gPiA+ID4gPiBh
bmQNCj4gPiA+ID4gPiA+IGltcGxlbWVudGluZyBmcmVlKClzLCByZXdvcmsgdGhpbmdzIHNvIHRo
YXQgd2UgZm9sbG93DQo+ID4gPiA+ID4gPiBleHBlY3RhdGlvbnMNCj4gPiA+ID4gPiA+IGJ5DQo+
ID4gPiA+ID4gPiBlbmFibGluZyB0aGUgREVWUkVTIGZ1bmN0aW9uYWxpdHkgKG91dHNpZGUgb2Yg
eFBMIHBoYXNlcykuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgdHVybnMgREVWUkVT
IGZyb20gYSBwcm9tcHRlZCBzeW1ib2wgdG8gYSBzeW1ib2wgdGhhdA0KPiA+ID4gPiA+ID4gbXVz
dA0KPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+IHNlbGVjdCdkLCBhbmQgd2Ugbm93IHJlbW92
ZSBvdXIgbm9uLW1hbmFnZWQgYWxsb2MvZnJlZQ0KPiA+ID4gPiA+ID4gZnVuY3Rpb25zDQo+ID4g
PiA+ID4gPiBmcm9tDQo+ID4gPiA+ID4gPiBvdXRzaWRlIG9mIHhQTCBidWlsZHMuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiBJ4oCZdmUgZW5jb3VudGVyZWQgYSByZWdyZXNzaW9uIG9uIHRoZSBN
aWNyb2NoaXAgUG9sYXJGaXJlIFNvQw0KPiA+ID4gPiA+IEljaWNsZQ0KPiA+ID4gPiA+IEtpdA0K
PiA+ID4gPiA+IHdpdGggbWFpbmxpbmUgVS1Cb290Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFm
dGVyIGNvbW1pdCAyMTdjZjY1NmUyNDkgLSB0aGUgYXBwbGljYXRpb24gb2YgdGhpcyBwYXRjaA0K
PiA+ID4gPiA+ICjigJxkbToNCj4gPiA+ID4gPiBjb3JlOg0KPiA+ID4gPiA+IERlZmF1bHQgdG8g
dXNpbmcgREVWUkVTIG91dHNpZGUgb2YgeFBM4oCdKSwgVS1Cb290IGZhaWxzIHRvIGJvb3QNCj4g
PiA+ID4gPiBvbg0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiBib2FyZC4gQWZ0ZXIgdGhpcyBw
YXRjaCB3YXMgYXBwbGllZCB0aGUgSWNpY2xlIGtpdCBubyBsb25nZXINCj4gPiA+ID4gPiBib290
cw0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IGNyYXNoZXMgaW1tZWRpYXRlbHkgYWZ0ZXIgT3Bl
blNCSS4gQmV0d2VlbiB0aGlzIHBhdGNoIGFuZA0KPiA+ID4gPiA+IG1hc3Rlcg0KPiA+ID4gPiA+
IEhFQUQNCj4gPiA+ID4gPiB0aGUgZm9sbG93aW5nIGVycm9ycyBhcmUgZm91bmQgLSBwbGVhc2Ug
c2VlIGF0dGFjaGVkIGxvZ3MgZm9yDQo+ID4gPiA+ID4gbW9yZQ0KPiA+ID4gPiA+IGRldGFpbDoN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoMKgwqAgRmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5IGZv
ciBmZHQgYXQgMHhiZjM4NjIxMA0KPiA+ID4gPiA+IMKgwqDCoCBSZXF1aXJlZCBGRFQgcmVsb2Nh
dGlvbiBmb3IgYXBwbHlpbmcgRFRPcyBmYWlsZWQ6IDENCj4gPiA+ID4gPiDCoMKgwqAgQ291bGQg
bm90IGZpbmQgYSB2YWxpZCBkZXZpY2UgdHJlZQ0KPiA+ID4gPiA+IMKgwqDCoCBEZXZpY2UgdHJl
ZSBub3QgZm91bmQgb3IgbWlzc2luZyBGRFQgc3VwcG9ydA0KPiA+ID4gPiA+IMKgwqDCoCAjIyMg
RVJST1IgIyMjIFBsZWFzZSBSRVNFVCB0aGUgYm9hcmQgIyMjDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gU29tZXRpbWVzLCBJIGFsc28gc2VlIGFuIOKAnFVuaGFuZGxlZCBleGNlcHRpb246IElsbGVn
YWwNCj4gPiA+ID4gPiBpbnN0cnVjdGlvbuKAnQ0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IGEg
cmVzZXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIGxhc3Qga25vd24gZ29vZCBjb21taXQg
aXMgYmVmb3JlIHRoaXMgY29tbW1pdC4gSSB1c2VkIGBnaXQNCj4gPiA+ID4gPiBiaXNlY3RgDQo+
ID4gPiA+ID4gdG8gY29uZmlybSB0aGF0IDIxN2NmNjU2ZTI0OSAodGhpcyBwYXRjaCkgaXMgdGhl
IGZpcnN0IGJhZA0KPiA+ID4gPiA+IGNvbW1pdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTdGVw
cyB0byByZXByb2R1Y2U6DQo+ID4gPiA+ID4gLSBCdWlsZCBVLUJvb3QgZm9yIE1QRlMgSWNpY2xl
IEtpdA0KPiA+ID4gPiA+IC0gQm9vdCB1c2luZyBIU1MgcGF5bG9hZCBhcyB1c3VhbCAtIEkgdXNl
IG91ciBidWlsZCBzeXN0ZW0NCj4gPiA+ID4gPiBCdWlsZHJvb3QNCj4gPiA+ID4gPiBmb3INCj4g
PiA+ID4gPiB0aGlzDQo+ID4gPiA+ID4gLSBPYnNlcnZlIHRoZSBib290IGZhaWx1cmUgYWZ0ZXIg
dGhlIGFib3ZlIGNvbW1pdA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFueSBhZHZpc2Ugb24gdGhl
IHByb2JsZW0/DQo+ID4gPiA+IA0KPiA+ID4gPiBJdCdzIHJlYWxseSBzdHJhbmdlIHRoYXQgaXQg
YmlzZWN0cyBkb3duIHRvIHRoaXMgY29tbWl0LCByYXRoZXINCj4gPiA+ID4gdGhhbg0KPiA+ID4g
PiBzb21ldGhpbmcgZGV2aWNlIHRyZWUgcmVsYXRlZC4gRG8geW91IHN0aWxsIGhhdmUNCj4gPiA+
ID4gZmR0X2hpZ2g9MHhmZmZmZmZmZg0KPiA+ID4gPiBvcg0KPiA+ID4gPiBzbyBzZXQgaW4gdGhl
IGVudmlyb25tZW50PyBJdCB3YXMgaW4gYXQgbGVhc3Qgb25lIG9mIHRoZSBsb2dzLA0KPiA+ID4g
PiBidXQgSQ0KPiA+ID4gPiBjYW4ndCBzZWUgZm9yIHN1cmUgaWYgaXQncyBqdXN0IHRoYXQgdGhl
IG90aGVyIGxvZyBpcyBmcm9tDQo+ID4gPiA+IGJlZm9yZQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4g
Y29tbWl0IHRoYXQgYWRkZWQgdGhlIHByaW50IHdhcm5pbmcgYWJvdXQgbm90IGRvaW5nIHRoYXQs
IG9yIGlmDQo+ID4gPiA+IGl0DQo+ID4gPiA+IHdhc24ndCBzZXQuDQo+ID4gPiA+IA0KPiA+ID4g
QXBvbG9naWVzIGZvciB0aGUgZGFseSBpbiBteSByZXNwb25zZSwgSSB3YW50ZWQgdG8gZG8gc29t
ZSBtb3JlDQo+ID4gPiBkZWJ1Z2dpbmcgYmVmb3JlIGdldHRpbmcgYmFjayB0byB5b3UuDQo+ID4g
PiANCj4gPiA+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gYWJvdXQgZmR0X2hpZ2guIFdlIGhh
dmUgaXQgc2V0IGluIG91cg0KPiA+ID4gYm9vdA0KPiA+ID4gc2NyaXB0cy4gSSBjaGFzZWQgdGhp
cyBkb3duIHdpdGggYSBiaXNlY3QgdG8gOTIzNWRhOTQ0NmUgKGJvb3Q6DQo+ID4gPiBXYXJuDQo+
ID4gPiB1c2VycyBhYm91dCBmZHRfaGlnaD1+MCB1c2FnZSkuIEkgaGF2ZSBub3cgc2V0IGZkdF9o
aWdoIHRvIG91cg0KPiA+ID4gbWF4aW11bQ0KPiA+ID4gYWRkcmVzc2FibGUgdmFsdWUgaW5zdGVh
ZCBvZiB+MC4gVGhpcyBkb2VzIGdldCByaWQgb2YgdGhlIHdhcm5pbmcNCj4gPiA+IGFib3V0DQo+
ID4gPiBmZHRfaGlnaCBpbiBVLUJvb3QsIHNvIHRoYXQgcGFydCBpcyByZXNvbHZlZC4NCj4gPiA+
IA0KPiA+ID4gSG93ZXZlciwgaXQgZG9lc27igJl0IGZpeCB0aGUgdW5kZXJseWluZyBib290IGlz
c3VlIOKAlCBVLUJvb3Qgc3RpbGwNCj4gPiA+IGZhaWxzDQo+ID4gPiB0byBib290IGFsdG9nZXRo
ZXIuIER1cmluZyBzb21lIGJpc2VjdGlvbnMgaXQgb2Z0ZW4gZmFpbHMgdG8gYXBwbHkNCj4gPiA+
IGRldmljZSB0cmVlIG92ZXJsYXlzIGFuZCBkb2VzbuKAmXQgYm9vdCB0aGUga2VybmVsIC0gSSBo
YXZlIGF0dGFjaGVkDQo+ID4gPiB0aGUNCj4gPiA+IGxhdGVzdCBjcmFzaCBsb2cuDQo+ID4gPiAN
Cj4gPiA+IEZyb20gbXkgYmlzZWN0aW5nLCB0aGUgb3ZlcmxheSBicmVha2FnZSBzZWVtcyB0byBz
dGFydCB3aXRoIHRoZQ0KPiA+ID4gRFRDL2xpYmZkdCB1cGRhdGUgY29tbWl0ICgwNTM1ZTQ2ZDU1
ZC4uLikuIEFmdGVyIHRoYXQsIG92ZXJsYXkNCj4gPiA+IGFwcGxpY2F0aW9uIGNvbnNpc3RlbnRs
eSBmYWlscywgcmVnYXJkbGVzcyBvZiB0aGUgZmR0X2hpZ2gNCj4gPiA+IHNldHRpbmdzLg0KPiA+
ID4gQXMNCj4gPiA+IGFuIGFkZGl0aW9uYWwgcGllY2Ugb2YgaW5mb3JtYXRpb24gZGlzYWJsaW5n
IE1VTFRfRFRCX0ZJVCBhbGxvd3MNCj4gPiA+IHRoZQ0KPiA+ID4gYm9hcmQgdG8gYm9vdCBhcyBm
YXIgYXMgZmR0IGVycm9yLg0KPiA+ID4gDQo+ID4gPiBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBh
bnkgb3RoZXIgaWRlYXMuDQo+ID4gPiANCj4gPiA+IFRoYW5rcyENCj4gPiANCj4gPiBKdXN0IGZv
ciBzb21lIGZ1cnRoZXIgY2xhcml0eSwgYmVmb3JlIHRoZSBERVZSRVMgQ29tbWl0Og0KPiA+IMKg
LSBVLUJvb3QgYm9vdHMgZmluZSB3aXRoIG92ZXJsYXlzIGRpc2FibGVkIGFuZCBmZHRfaGlnaCBy
ZXNldC4NCj4gPiDCoC0gT3ZlcmxheSBhcHBsaWNhdGlvbiBjYXVzZXMgRkRUIGVycm9ycywgYnV0
IGJhc2UgYm9vdCB3b3Jrcy4NCj4gPiBBZnRlciB0aGlzIERFVlJFUyBDb21taXQgKGRtOiBjb3Jl
OiBEZWZhdWx0IHRvIHVzaW5nIERFVlJFUyBvdXRzaWRlDQo+ID4gb2YNCj4gPiB4UEwpOg0KPiA+
IMKgLSBVLUJvb3QgZG9lcyBub3QgYm9vdCBhdCBhbGwg4oCUIG5vIG91dHB1dCwgdG90YWwgY3Jh
c2guDQo+IA0KPiBTbyB0byBiZSBjbGVhciwgdGhlcmUncyBqdXN0IG5vdGhpbmcgb24gdGhlIHNl
cmlhbCBwb3J0IGZyb20gcG93ZXIgb24/DQo+IFRoZSBpbml0aWFsIGxvZ3MgSSB0aGluayBjb25m
dXNlZCB0aGUgc2l0dWF0aW9uIHNsaWdodGx5LiBJZiBubw0KPiBvdXRwdXQsDQo+IEkgd291bGQg
c3VnZ2VzdCBidW1waW5nIHVwIFNZU19NQUxMT0NfRl9MRU4gYSBsaXR0bGUgYml0IChtYXliZSAw
eDI4MDANCj4gaW5zdGVhZCBvZiAweDIwMDApIGFuZCBzZWUuDQo+IA0KU29ycnkgZm9yIHRoZSBj
b25mdXNpb24gYW5kIHRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIHdpbGwNCmF0dGVt
cHQgdG8gY2xhcmlmeSBiZWxvdy4NCg0KSW4gc3VtbWFyeSwgSSBmb3VuZCB0aHJlZSBpc3N1ZXMg
aW4gbWFpbmxpbmUgVS1Cb290IGJldHdlZW4gdGhlIHYyMDI2LjAxDQp0YWcgYW5kIHRoZSBtYXN0
ZXIgYnJhbmNoLg0KDQoxLiBObyBib290IChubyBvdXRwdXQgYXQgYWxsIGZyb20gVS1Cb290IG9u
IHRoZSBzZXJpYWwgcG9ydCkgLQ0KaW50cm9kdWNlZCBieSAyMTdjZjY1NmUyNCBkbTogY29yZTog
RGVmYXVsdCB0byB1c2luZyBERVZSRVMgb3V0c2lkZSBvZg0KeFBMIC0gZml4ZWQgYnkgeW91ciBz
dWdnZXN0aW9uIGFib3ZlOiBzL0NPTkZJR19TWVNfTUFMTE9DX0ZfTEVOPTB4MjAwMC8NCkNPTkZJ
R19TWVNfTUFMTE9DX0ZfTEVOPTB4MjgwMCBpbiB1LWJvb3QgZGVmY29uZmlncw0KDQoyLiBmZHRf
aGlnaCB3YXJuaW5nIC0gaW50cm9kdWNlZCBieSA5MjM1ZGE5NDQ2ZSBib290OiBXYXJuIHVzZXJz
IGFib3V0DQpmZHRfaGlnaD1+MCB1c2FnZSAtIGZpeGVkIGJ5OiBzL3NldGVudiBmZHRfaGlnaA0K
MHhmZmZmZmZmZmZmZmZmZmZmL3NldGVudiBmZHRfaGlnaCAweGJmZmZmZmZmaW4gaW4gb3VyIGJ1
aWxkIHN5c3RlbXMNCmJvb3Qgc2NyaXB0cw0KDQozLiBmYWlsZWQgb24gZmR0X29wZW5faW50byBm
b3IgRFRPLCBpLmUuIG92ZXJsYXkgYXBwbGljYXRpb24gZmR0IGVycm9yIC0NCmludHJvZHVjZWQg
YnkgMDUzNWU0NmQ1NWQgc2NyaXB0cy9kdGM6IFVwZGF0ZSB0byB1cHN0cmVhbSB2ZXJzaW9uDQp2
MS43LjItMzUtZzUyZjA3ZGNjYTQ3YyAtIG5vIGZpeCBpbXBsZW1lbnRlZCBhcyBvZiB5ZXQuIEFu
eSBzdWdnZXN0aW9ucw0Kb24gdGhpcyBhcmUgYXBwcmVjaWF0ZWQgYWxzby4NCg0KVGhhbmsgeW91
IGFnYWluLA0KSmFtaWUuDQo=
