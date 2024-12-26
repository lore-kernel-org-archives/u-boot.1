Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ED7E77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 03:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351408036B;
	Thu, 26 Dec 2024 04:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6BEJbqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA6A8036D; Thu, 26 Dec 2024 04:31:01 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D019980352
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 04:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGMIGKmKUIeX7nbe87TTUqnu/S94hHNwHfBjI14F46BkOZim09jLCgrLarrtvNTQeua5MWDEDxAHcomlfPCoYroiHSFFGegEP96+dmlAbLM4404hivtZadv55lQnwr4cZ6+MXSn1KqKd9tUm+lJu4H58cT/xd++KNQ6dYUtsiFrflaMN2W8raX3RDqUnHdq7gfoboWAaKQoPE67oAsTtyckNI7k6uPcXrbbUTq0VBAPH/t5WnYl43gn7GebIVJMx46HiMjC90ro98fhcJJik5COhdc9jJyaukGdcH8eZy13cG6ER9tx4VtAjvWjlMxXHIPBT+/Yn7rKVYlZlSY7jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzlkDIFSPatyCYDJ0F0OqjlPw/YuoAuYZkzc5eV2EdE=;
 b=wIh9zm6iQ8UDpHkMYXKNWDtrD5nYQZM/b1NY+KVzWk2Xek6spN3JNOcx+S8eAkXPyzmD5QaTnWMzGoOH3cS2AVI1yIrrUoclozcrYFDbU4y5eb/vBUtIG3XM0PeBwcayqAZuj0TRVw24TSKnMlX2bWeEINQ9E0IFKYnn6WWltfXqMXr1dKUy7LmOedk5g11DZvf+Gpd++EazmHcXAu/Tmg7pKGhGQbm2Vkw/I3MgPGxskJJZIOwuGIkEaEDoEGSaTcEz+J2PJpWUpF+HYg9XEAyIoy2Nw4/NJ+L5E86ab3zq3uywPg87OQrsl3Zn+UUym9Ex9umfE1nJUkBUwZNxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzlkDIFSPatyCYDJ0F0OqjlPw/YuoAuYZkzc5eV2EdE=;
 b=m6BEJbqWDUW3yOUiRlP1+SlIw7K/YzEK2oKcPOzDwwEzzBRQZiq1+rmyscCHVQNERJwc5Qf1Jn9PRtjIAbfgfGtGy2fDV/97O8zA8TohC2IE/U+kf/mFpWOy1vXPI7a9APBVfXqqiQejpoh2qX8RfyCvgThVY+ewQ9LMXzH2J6k=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Thu, 26 Dec
 2024 03:30:49 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8272.013; Thu, 26 Dec 2024
 03:30:49 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbUuuptd7FUcpnCUS5nrWl0znWTLL0ECIAgAF7q+CAAeNfAIAAd+tQ
Date: Thu, 26 Dec 2024 03:30:49 +0000
Message-ID: <SA1PR12MB86973436DC441C609801FE90980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
 <63291d8d-ca66-4e8a-a9aa-efba47a1f505@denx.de>
 <SA1PR12MB86971D338EE7CCDED324172D98032@SA1PR12MB8697.namprd12.prod.outlook.com>
 <148a7bd2-a243-4964-948d-abd3545b9e41@denx.de>
In-Reply-To: <148a7bd2-a243-4964-948d-abd3545b9e41@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB7571:EE_
x-ms-office365-filtering-correlation-id: c6e82f51-5170-40d2-9a0d-08dd255db191
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZW1tZDZjdDhXTlYwdlA5NGVPem5GZUNTS1VlcVpTb2JoRGpBdG1MRmhPWC8y?=
 =?utf-8?B?Vm9wQ1F4YkQydVVsbFI3VENSbEgrQ1RUdk1WTDljWlBwcm5pZFduV1RvSlda?=
 =?utf-8?B?Y0VkNkk5VjY0UVBUUVdJM1phRmZEV1AzVkwvVkdYWGtkTUVnNzVBV01ST3E3?=
 =?utf-8?B?ZmI5ZFdqMkVja1lEcStlM2Zjek5SSEpydTRtOVBveENJVmp1UnJnMVRKS29p?=
 =?utf-8?B?Q1oyQUN2OEdyRHBzNnphSmg1aHNrMjc0S1pma2Fvczd3Q1VzNWxBeVJadDFP?=
 =?utf-8?B?U3FzOWVnZ1ZWNm9QY1hnbmNIaTIreE80bkNYZjQwOVBValZhdUg1YklDU0lH?=
 =?utf-8?B?UlNuaGIwYkNYSnpPaGl5MkZaRkRTSE93V2h6TDZ5U0puditGamxTVTk2endI?=
 =?utf-8?B?YlVVc2F5bjhndUJtNUlvSGZJS1Ruc2hIaFpnL0swOWJvQVk3a3JvZkM1SkNp?=
 =?utf-8?B?d0s0SGkzTjBiWkxPcUNLcXowL25DaXljY2tGNWtvbW5INGJmSmRqNzdPUkRv?=
 =?utf-8?B?RjlJczAvdGdHTklGYlJ6QnVpNU9WL0RRVzA3R1VEaUwyU0ZkUktPOVhXUEhC?=
 =?utf-8?B?bTNyVWpuNTlUSTI0T3laUW9iamU5SW11TmVhL3NaV3Q5N1EzbjJDNllHOVJn?=
 =?utf-8?B?c1lueWdPR1VUaVMrY3BUQWl3WUpjV0RMV1poVUNUN2JpVFc2SFF4TXVBWm5T?=
 =?utf-8?B?ZVZoYjRpMzYxSVMvb0ZIbUJPR1d2NUM5c1paUWJtdXZQTUFYamtrOWhRek5a?=
 =?utf-8?B?N3JIbVdtUnQvU3owS0VVcHBCNFZ5NVk0M29hWkJOb2lBQWRPNTVLRmxJd0pD?=
 =?utf-8?B?MGRsQXg3KzRSMCtJWjBPcCtnaUQ0UDRKWXg4V2RNcVc0SGpONWc2VjhMTlpq?=
 =?utf-8?B?SW8wRVRidmRxQi9vNjZYUGUwRlJWdWZjeEFqcDFHeGpJKy95ZzVVa3hGMFgw?=
 =?utf-8?B?aWdqN2xZWlFGdjFVV014VURpZ1oyQ3RCNStmL0RPeE93cUFlczVJcHM5TWNi?=
 =?utf-8?B?WWdUWVRCSjVZc0NnYWZoYXNuZXZXWXc3QUZUQUdjdXlDOXVKa0JlTy81U2o5?=
 =?utf-8?B?YWtrUEgwTExaVnFYZUcyRXdrQnNBUDVlSEkrMVlZMVIxRndyZXhOcmhxeVNI?=
 =?utf-8?B?cS81UFVFOXFlMnh2MmYrTTFVYVBzVWVoQkZucHd1ZTJKRDRrRjNmZWhWVG5t?=
 =?utf-8?B?S2g4c2E5SDc5UTlObkdUbVF0T1h5SFFCRG1hR0QzNFQ1K1Vnb0owNklRTEdC?=
 =?utf-8?B?Z3Ztc3ZPa1NVcFVIaFNiVE1ncE9GVEhDSlRjVEE0MURuWHBodks2dW9PL1U3?=
 =?utf-8?B?NTBqVHgzdHdRTFZ2MTNMaVhINnByMVI5VVZOa2ZGQXpGZ3hvWXVUV3p1ZERq?=
 =?utf-8?B?bXF0aHdrQzJjQ0J0dTdCb0w3RG1zdFI0ZzZTNGVycUx6N2JZRTNYa0pLZFhi?=
 =?utf-8?B?YVMxZFE2SjUrSWRxY2oyRGZaZmZRWWJTSXMxa3I4RmsrNWpLa2ZjZEVqR0Jl?=
 =?utf-8?B?UjN5TUdkWGdlMndIV1VybCtmSjVPeE15SGVNc2hqS3hBQkYvdk5hN2JIQ3RT?=
 =?utf-8?B?bXVGdXBabnM5M1NPMUFQM2c5VUxKWWdHUFowMEJSKzViOWRXVFhsUU9Eb0lW?=
 =?utf-8?B?YTlsM2Q0TDAvVWo2aTR3bzBZZFZlVUlPVkhKWUFjNnZVOHJlSUpScnFSR1lW?=
 =?utf-8?B?Q0xiR2FBOVdkOVNGT3MzVC93a0tQcFVuY1dFQ2wyU1V4dHAvbDgzOG9nUDky?=
 =?utf-8?B?OTdYRnB0T1Bybld1bHROWk91Nm1JWXhGbnd4YUZkQVRvZ2w0SS9ZdGZpSUpU?=
 =?utf-8?B?blhHaHp1K1p0eXBpb1Ardlc2ejkwZmlFR3llZVJrZkNUcHVJOEpOWSs0RU5I?=
 =?utf-8?B?b1ZodGl2cEdUQWY1TXl4TEx6djBMcVIxZDJrd05FSlZwbTFKZmFJbE9TL2FY?=
 =?utf-8?Q?x4CozKcj0w4nNgWTSg6lgvX5oK3n2dVI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnpJcWlaakFXZzBpZGxzY09RTXpwaURqRk95Slc0enY1R0xNU0FnM3NPYWVK?=
 =?utf-8?B?TUhJR2pFOU9FbnMwbkJKTHpJamxDakI0bkRMQmNsaVJ1UVlKUVF6NitCdktl?=
 =?utf-8?B?RDN0SHJmOGxwSG5qcU1GS2tvSVlCVThJUTQ4TFhXcUtMUWI2eDVsWGVmSFdW?=
 =?utf-8?B?blVjd1V0dEVQd3dyWTBoNFVDZXlNMEtmNFZYUDVEQ2ZEWkJsQUxOelJpekFD?=
 =?utf-8?B?UWhuRHB1bHQyM3dNRGxOQW03Sm1mTWIxVTZIZEJLZEhlUjd4cFlZMVlRN0JP?=
 =?utf-8?B?bGNOdHdyaDM2bWdjUXNTWmY4UmtYbmY1RkQrYmlRd3paSlVWaVFmWW9ZZGpG?=
 =?utf-8?B?aHpvTFNFWXp6ajR2QTFMVmVZTzFxY3Urd3p3TnRaTk5qcGtIUVhSY2x3WEJi?=
 =?utf-8?B?dUhkSFppTys4elBrbndyT1lXck5RWGR1Mno2WFArSU9XS2tvWHdERkRRQkJR?=
 =?utf-8?B?R2IreWdOMWszbWc0VXRLdThxa3EwQVU0NERyNnlIQm1SUnBiVmhCcHVFTzFD?=
 =?utf-8?B?ZlJoaGVSc0F1SXh2b0FuaDF6c3FWc0FlWms5Vkxmb0FaYXdvWGtmRjJnR3cy?=
 =?utf-8?B?eTgzc1ZxR1o0dzNZY3JYclg0NlY0aWlPdlZSWkZ1aEtHcVNKN3BKTTQ4bmNN?=
 =?utf-8?B?UnQyVFdCb2dNNFJjSTRTczVudVV4NFcxS0RucHF1RUlIUmZ6OGx4azRsek5Q?=
 =?utf-8?B?Zm1Pc1BISUFRTlJaeDk1c2FBWUtIWGRNOEFHUFU4OFJqWXp2NjI5RFp6NDlQ?=
 =?utf-8?B?OWY2U0dVbTN1dk10QVpvVVVWMys4YXRkaHlUZWlhTUhlMjY4VUY0clhqMXlC?=
 =?utf-8?B?bmRnbHJEUTJHVytZeDdSNmJmKzNKOHdReVNIaERsQUthSUtWSHJaRW9STDZ1?=
 =?utf-8?B?UHdoVmdiZlErUlc5ZEhqTHgyWUkrSlFJRitxTzk2cjlrcDFPV0NQVVRFTGlu?=
 =?utf-8?B?alcxaS8xUWFRYzlaNjkrTlN0WHNJODViY1J3Szk2M0xvRUhBRHlhNkI1dHcy?=
 =?utf-8?B?K3d5b0J1ajVzVDJybllsMEUrRnBjVHovSGNJaktKb2paUnYzUGZaK0xWOFV5?=
 =?utf-8?B?U29NenVjM0JadHpwaGdhTHlFK0EvUkNoZ1lsZWtXUWw5TUVkREJydERIMVhh?=
 =?utf-8?B?cjJFV2pzbkFjWmNCWWJxaTVXVjJtT2l5YURaQnBxem8xN2pzcWRuZ3VBb3lx?=
 =?utf-8?B?aTlvUTZwOFYxLzk4MlpMMk5CODNOYnpsWjB1anZXTnc4Y3dreXVTSEt4WEpz?=
 =?utf-8?B?TEx2cDVDRkg0UE9US0t5cEloTXMrL2hvRlVOcEtYa2s4LzhMR1hOQlp2Q3cv?=
 =?utf-8?B?SEJ3bTM2aW9IWmpMd0JpcFNYY3VlYlZRY21wWVhiS3UzZnczS0tqbnZHY1Fr?=
 =?utf-8?B?ODZGVlFjZWVIeUlzOFQwUU00Mkk0YlFKYnVLUUsxZDdpdUNUZjJ4Ky9TcFJ1?=
 =?utf-8?B?NG5nWTJaWm40NkgrbGJodjFaMkZyV3pmbUNKZG9DZG1yMndEbDcvbXl3TGRP?=
 =?utf-8?B?Y3FvTnNUN29JUU44aDY4YWw1d2lDbnh6TDQxMncydWJqcUErQmNTNWJ5OTYx?=
 =?utf-8?B?MTNmUlpUcENkWnpMdFN1TTByMWxGZVVoTXYrNVA0STFSK1cwalBQTEFRS3Rn?=
 =?utf-8?B?L25BN0pXR0hHaFd1RGxrazg2SytDRFFGU0RSdWx0eGNGRmpiUUVwK3NWa0Z3?=
 =?utf-8?B?YzN6eWdDalNDaVBqUGV4UGVlaFFEN2doejY1THlaeEQzbitjaHpSZzgwR3FM?=
 =?utf-8?B?M1VqQnd3ZG1IN3ZyWldNWDNkK3RpeXVEZzFOcTJOLzg1MGlPcUZaMTR3bkxu?=
 =?utf-8?B?Mk9JaFZUVVZ0SzM0TzUrS05EWG5MeDFROEgxWVJsME5HTnJNZXNhbjJhSGhr?=
 =?utf-8?B?TDZnalB1V2czY3pPSkQzUGRuQ0hLcnpuUnJQVllmWm5zL1pSTm4yS3R1VnEv?=
 =?utf-8?B?Y1lTUWxaTCtCSEYrWjl2TmdJZ05sMFNwQWUrT2o2OXlra1hEU2gyOXBRZEJa?=
 =?utf-8?B?NHlDTisrOXpLNUxzV2d6ekZVSno5cGgyNnRGb3pFQXl5dGF5UXJKM0I1MkZv?=
 =?utf-8?B?d21SMUE3WTJRN3RrTjdQdngyVjFkTVR3SnVxUHJuMk5OWFZWUyszK2MwWjRZ?=
 =?utf-8?Q?WY1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e82f51-5170-40d2-9a0d-08dd255db191
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 03:30:49.7540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WESpreQMZvylBAzmT27UbVW3F1sd31nows5hrO53rCS/Z9d9qSK0LR+mSwaF0IzAhmGnr8wYjds9bimryNoATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyNiwgMjAyNCAxOjUx
IEFNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiB0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc7IGot
aHVtcGhyZXlzQHRpLmNvbQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5j
b20+OyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gdmlnbmVzaHJAdGkuY29tOyB1LWt1
bWFyMUB0aS5jb207IHRyaW5pQGtvbnN1bGtvLmNvbTsgc2VhbmdhMkBnbWFpbC5jb207DQo+IGNh
bGViLmNvbm5vbGx5QGxpbmFyby5vcmc7IHNqZ0BjaHJvbWl1bS5vcmc7IHdpbGxpYW0uemhhbmdA
YnJvYWRjb20uY29tOw0KPiBzdGVmYW5fYkBwb3N0ZW8ubmV0OyBxdWVudGluLnNjaHVsekBjaGVy
cnkuZGU7IFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb207DQo+IHAtbWFudGVuYUB0aS5jb207
IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBtdGQ6IHNwaS1ub3I6IEZpeCB0aGUgc3BpX25vcl9yZWFkKCkgd2hlbiBjb25maWcNCj4gU1BJ
X1NUQUNLRURfUEFSQUxMRUwgaXMgZW5hYmxlZA0KPiANCj4gT24gMTIvMjQvMjQgNDozNCBQTSwg
QWJiYXJhcHUsIFZlbmthdGVzaCB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+Pj4gQEAgLTE1
OTMsMTggKzE1OTUsMjMgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWQoc3RydWN0IG10ZF9pbmZv
DQo+ID4+PiAqbXRkLCBsb2ZmX3QNCj4gPj4gZnJvbSwgc2l6ZV90IGxlbiwNCj4gPj4+ICAgIAl9
DQo+ID4+Pg0KPiA+Pj4gICAgCXdoaWxlIChsZW4pIHsNCj4gPj4+IC0JCWJhbmsgPSAodTMyKWZy
b20gLyBTWl8xNk07DQo+ID4+PiAtCQlpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxM
RUwpDQo+ID4+PiAtCQkJYmFuayAvPSAyOw0KPiA+Pj4gLQ0KPiA+Pj4gLQkJcmVtX2JhbmtfbGVu
ID0gU1pfMTZNICogKGJhbmsgKyAxKTsNCj4gPj4+IC0JCWlmIChub3ItPmZsYWdzICYgU05PUl9G
X0hBU19QQVJBTExFTCkNCj4gPj4+IC0JCQlyZW1fYmFua19sZW4gKj0gMjsNCj4gPj4+IC0JCXJl
bV9iYW5rX2xlbiAtPSBmcm9tOw0KPiA+Pj4gLQ0KPiA+Pj4gKwkJc2l6ZV90IHJlYWRfbGVuID0g
bGVuOw0KPiA+Pg0KPiA+PiBzaXplX3QgcmVhZF9sZW4gc2hvdWxkIGJlIGRlY2xhcmVkIGF0IHRo
ZSBiZWdpbm5pbmcgb2YgdGhpcyBmdW5jdGlvbi4NCj4gPj4NCj4gPj4+ICAgIAkJb2Zmc2V0ID0g
ZnJvbTsNCj4gPj4+DQo+ID4+PiArCWlmIChDT05GSUdfSVNfRU5BQkxFRChTUElfU1RBQ0tFRF9Q
QVJBTExFTCkpIHsNCj4gPj4NCj4gPj4gVGhlIGluZGVudCBoZXJlIG5lZWRzIHRvIGJlIHB1c2hl
ZCBvbiB0YWIgUklHSFQgLT4gLg0KPiA+Pg0KPiA+PiBEbyB5b3UgbmVlZCB0aGlzIGZ1bmN0aW9u
YWxpdHkgaW4gU1BMID8gSWYgc28sIHlvdSBtaWdodCBuZWVkIGENCj4gPj4gbWF0Y2hpbmcgS2Nv
bmZpZyBTUExfU1BJX1NUQUNLRURfUEFSQUxMRUwgc3ltYm9sIC4NCj4gPg0KPiA+IFRoaXMgZnVu
Y3Rpb25hbGl0eSBpcyBub3QgbmVlZGVkIGZvciBTUEwuDQo+IA0KPiBTbyBTUEwgZG9lcyB1c2Ug
U1BJIE5PUiBpbiBub24tc3RhY2tlZC9wYXJhbGxlbCBtb2RlLCBhbmQgVS1Cb290IGRvZXMgdXNl
IGl0IGluDQo+IHN0YWNrZWQvcGFyYWxsZWwgbW9kZSA/IERvZXNuJ3QgdGhhdCBwb3NlIGEgcHJv
YmxlbSA/DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBGTEFTSF9CQVIgYW5kIHN0YWNrZWQgcGFyYWxs
ZWwgY29uZmlndXJhdGlvbiBkb2VzbuKAmXQgZGVwZW5kIG9uIGVhY2ggb3RoZXIuDQo+IElzIHRo
ZSB1c2Ugb2YgQkFSIHJlZ2lzdGVyIGFuZCBzdGFja2VkL3BhcmFsbGVsIG1vZGUgbXV0dWFsbHkg
ZXhjbHVzaXZlIG9yIGNhbiB0aGV5DQo+IGJlIHVzZWQgdG9nZXRoZXIgPw0KVGhlIEZMQVNIX0JB
UiBhbmQgc3RhY2tlZC9wYXJhbGxlbCBtb2RlIGNhbiBiZSB1c2VkIHRvZ2V0aGVyLg0KDQpUaGFu
a3MNClZlbmthdGVzaA0K
