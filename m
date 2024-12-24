Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4176DE77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 15:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907B280786;
	Tue, 24 Dec 2024 16:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZWnrg3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FF88074B; Tue, 24 Dec 2024 16:34:17 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B9F0807A7
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 16:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noNf22mzgbGfHzg8HOVP2k0E3ay4UFA6jk7E9LH/EWoIqno9nXSkgrO+sCQ7u4ujArI/XUtNrFdIN4gwG9B9e1ZXpJ9GduZsJSef0zT0jTanxBA64c5niUG2NzU1anrHz3dptdQPrjRN+SHs3FKRTFMRZGq3+VPPk7TyNBE1o1dU8WnXz7wdGnCwSdNQrnA0Qr0z6CNI9dpoeEpN6SM06+M1QDmILUoTr6LKrhjI5NJ839Gnk5prv9R3ocaUlbbruEFTOwRBldaJ81/08NymrMwGuJ6zbHN2OvJ8n4TQmDrgpiq6q0kHlisLnS9JQ3+gQTf/PcfDUIKtD2/Fvr9NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCV3kq2RDw8Tfa+vZNi8NgsCt5m8qZhwlDmM3B/SyVI=;
 b=BWdNkuiOtJlW7aYrzbnocJ6cljRy/eerybIrqPou/QWMwNQPrdJQ/NcWctveYT4E7KzP9/DHdH5a9/MRyccduusECST89ApUcnfoeUUz+fXtCnXGyxHajQOM8/9o2mLrlhSVv/YpPkiEHwK2psd4GRW5A6OknJhOqVSaJx4V/LJU41CwbhWJuUQ4wFg0lVA3lHvuo6Sl7neHCoSNwGd8WoF9n4Mp1CQYJ8Wuij9eRvdDrddobX8yuVIQlhzXE11apAB2AMMu/xNIjqsWTt7uI1EDn/CrBG3onjLJoQUkZd5tWYjPXTZx0HFPLj4qMzznB1vS99UqBdn/KpTkyudwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCV3kq2RDw8Tfa+vZNi8NgsCt5m8qZhwlDmM3B/SyVI=;
 b=rZWnrg3wH3D6hOQ2TCnhqGAdQg//OA2iCavUQCMyhMiJdESU4Pf91CfN0sp0bTlK6a4QF/VAQ7SNrrmNJfRr2ZKxtMCHCio2K33whI9E7UxCSRIgW+1q4vBcrzAMTdIx+ued0IuPKL7w/iMHygmUo1Edhh7f5uLFxLYKLKyIEqE=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 15:34:05 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 15:34:04 +0000
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
Thread-Index: AQHbUuuptd7FUcpnCUS5nrWl0znWTLL0ECIAgAF7q+A=
Date: Tue, 24 Dec 2024 15:34:04 +0000
Message-ID: <SA1PR12MB86971D338EE7CCDED324172D98032@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
 <63291d8d-ca66-4e8a-a9aa-efba47a1f505@denx.de>
In-Reply-To: <63291d8d-ca66-4e8a-a9aa-efba47a1f505@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB7689:EE_
x-ms-office365-filtering-correlation-id: 9012cc66-d8fa-44b5-6370-08dd24306636
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VVk2Qlh0V25lSkg2czlEb1hjOVYxRUk4cUxtY1hLMGI2MTRmK20zbU0xVm44?=
 =?utf-8?B?QlNPZUZ5TWxtdWxVSDUxeW1sSDFJRkpTbHJVNG82L1VqT2phbVB1V3FUNkVs?=
 =?utf-8?B?bDQwZ3JVUXdubXBlRTYyOUlabi9ZYkIrVVkrcVVKaTBYMzJ2bm5IZmVVS3NY?=
 =?utf-8?B?SEFQSGNxVG1kOXFZSUxZZkpXYzBwOFJBNkRQNDZReStzeDNnTW1tOW5YTll1?=
 =?utf-8?B?NGhXNnhXOFJDYmJ6Nm94eEdqdGdMYWVTY25TeHFFR09Tams2YTRtYldIQ1Zp?=
 =?utf-8?B?aG5EL1ZPMXoyNjAveFQ3eHRraHdVQWlieG1xQW1SSTVqYk0wRHN0aE9WNUlP?=
 =?utf-8?B?OWVNUDFMT3UwQ0ZkclJJSEFvOVdXRkJrYVF1NFp5bDRQcm9RMDMrcy9HT3lL?=
 =?utf-8?B?TEdoQWxVUHp1Z2hTUUFsUE94MDh2ZmZZa1hDTWxZUkRhN011L2hyRDY5MStn?=
 =?utf-8?B?bHpsL0dpTkoyVDB6VmZOcFJJdFJiTGRwSUY1bXJDa3lhcDFJcHN5NDRRY0hJ?=
 =?utf-8?B?TDZzbjRsY2JpY1V2TERwUmxUM1BlZklUeGlpUXFHWVR0NnREL0tMYi9FQ214?=
 =?utf-8?B?SzJ5RHBEeWY1TkZ3VjNHUmVUc2pLZjI5MTZFZHJMN1Z3ZUdpTHEwbmtPSGg0?=
 =?utf-8?B?OWJyZEJJcC9DYWxxOWtQOUdxbGJwWjJDL0pYbHlEamR1YmN2NmlMbS93dUE2?=
 =?utf-8?B?WnhxaStxV0UxbUF6eEZXTHNUak52MG1WWnRRWDhTS3BCSkMrZGsyVTNBczdM?=
 =?utf-8?B?RGE4czNNOVJmZkRsNmFldVdmSE9uVEZxUFlYazV0NTVsOE42MklkQzJXdXJ5?=
 =?utf-8?B?NkFhTnhNWlB2SUNrZXBMRFVLRmkxWG5WVWVYMVB5aFFOaFJlcFNMdmhFQkNa?=
 =?utf-8?B?Z1JPalhieHM2UW5acU1HZzNta2EyTFhvZ1lvaE1jWjBiR1lZdDVMYzRldnFH?=
 =?utf-8?B?d09yVHQyZVNLa1UzQUwxZlMzZjFTV0F2TVFtZzc3cmhac1ZZbmhxdXhwR2tr?=
 =?utf-8?B?UEwvQ2ZWTEpkZ21DdUdSWDh1NEI4b1M5SFprektHcWg0N0hvZEFHb2t6dndn?=
 =?utf-8?B?OS9vUDFta0xoZjlRTngvOTE0NVJGYmJQNndlNm03UTAxU0JRNWxPVmtvMFlE?=
 =?utf-8?B?dTRLelplMDdOdWM0S2NJZG53M2Y3QzdQdlh0TDBCdWE4LzNjN2ptLzUxWVVX?=
 =?utf-8?B?QnFUZzA1cEhXNkNzaUJldTkrVnVndmp1VjJESzNSV0pMVmEzVi9LOG5saVc2?=
 =?utf-8?B?djY1SnpxSm91MTF0SXJFMjRmUmdnRkpaYjMvckRXTlFsOWtBMzRsWmJpbW1T?=
 =?utf-8?B?TXllaGtZcWZDUTgrOEdncDJtbWphVUJQOExqMHVrWE9DSTIyV2tRYzJwU01L?=
 =?utf-8?B?dUIzN3g4djlET2FBZHV0QWZsSm53Qys3UGt2d2g4bXRSaGpTVytQZE1NdFN3?=
 =?utf-8?B?eGxnUW5QR0VuVVlkMGdSQXN6dmtUM09EbG9VS2RpY0F2dXVvUTk0TFkxM1VF?=
 =?utf-8?B?eHc2WElNR0czL0pVUGlpdFpDR2EzNzBqNGUwLzU0ckdQVTlvK0JqTHh4OHdp?=
 =?utf-8?B?aHZianlTUHRnWkV6WVNkVDUyeFQ2ZzRhWXpoeWg5eXhIblBrS2dDL3EvN3dB?=
 =?utf-8?B?dy9BSFhodFNOaUlwOEtBQXpKYytiMXhsd25UV0tOK0gzak5TSXQ5STR0elFj?=
 =?utf-8?B?VThtZlp2OHgxSDRDS3ZGeXlMVStsNG9IeXVlS0ZuRkR5cWsvOFBoZ0FDSTBE?=
 =?utf-8?B?RU1ucUREVW1FMGVyY0YxSlJ6cmJYRWhoaXdHcElXT0RVQ1JvWGtMekdaamhQ?=
 =?utf-8?B?RllxQ2VtQjlDWFVYc0JvVERjejZQWVRqeXpvRHJZM3JPRjl6TEdYNHc1S3ZI?=
 =?utf-8?B?VGZHRVlGeFZjRkNYUVc0SzJmdDltSWF4UmEzMUFQUjZGSlYwQ2g1S1FoQXZS?=
 =?utf-8?Q?Q5maSDawOa7+/XZDWLeYRbKpJNYi9eo8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1VqUjBVZ0dOU0FJbDVqaEFZUTJ5a0YrdUoxZkc3c2xIR1BxbkFsaDhDOHJ6?=
 =?utf-8?B?VGc3cDNrdWJ3YlFnbUZERUVmcXh2ZGZaWmUwaFVmUzJySnRweEVTQTBoVlhN?=
 =?utf-8?B?NUNwYWx6NlNtTVlNWUFkL3U0UUdlOUMzQW84bTNnL1Zuc2lJbzlkcG5BcUY3?=
 =?utf-8?B?cVNDVTBsTmFjTVBBclBtUER2WDJVN1V5cHdHN0tkVVdtaGhVL1Z2SkYvV0hw?=
 =?utf-8?B?ODk3RElSTHRMckh5UmZFS2JiV09MMHRmaFlBZG5CYlcrT3YxTWFndmFDQnlk?=
 =?utf-8?B?QjlqMG9xMVZLU1dxdjNqOUc3RjcvQndnMEtBd3VIYWErS2N2MmZmTi9uaEVM?=
 =?utf-8?B?QmZrUVloVFZNeEVSRzliSlg5OUljbWVPUk5hZ1IvWmtkVkNDVDhQNWtuU3FV?=
 =?utf-8?B?bWNldWh3ZXlUQWdPOUFSTFpvdWFOalNCdlE4SzFaeGxjTVFobTdIbUFVejJ0?=
 =?utf-8?B?NVcwR0lvYlYvRFBZdXZXMHVVc0EwNCtydFJtQVYvMEI2L29qcDBOV25jcUx4?=
 =?utf-8?B?YWVOSzJUTDA0ZlRuanlFb0NycitPVHV0aERUQnVpNmp5bU90Qk94UkxMcGlM?=
 =?utf-8?B?STNIT1NWaDN0ZGY4emVtcHBHK2lGbjdlOUZ1OUF4bU12KzBxUFJ4ZG56N1Rp?=
 =?utf-8?B?ODFlWGIzVWlFNkExNVNFQ1Z0UjFob1JOdU9iSWxTdkVKNXpkMlJZTlAwbFpR?=
 =?utf-8?B?Vk9Mc3JURjVwdGdOeHZGUVIxdkpPTE5Sc2ZtMkNHYXFnYk9nTmlZZDNzZ1lo?=
 =?utf-8?B?ZC9uN3NNUmNDY3FDN0kwWi9hRWYrT0I5QTloS1RmTFZ0NHA4OGUybnJhM2o0?=
 =?utf-8?B?dTBSWHFpcC9welZRU3ZOSG9QQkNDNU5OU2F3UStOV1prSGswbytWSGFzUnpS?=
 =?utf-8?B?MGxZYWIrRWwvTy92R2xxTGZWZFlOSjJ2d0FKR3o0RWo3cjlMUGI3WjZGZ1ZZ?=
 =?utf-8?B?M3hPVUE4YnRmUFdjNm1ObXRZYkM5ZGVPMWJ1cW1oWmsxS0xYVGVRbXRUNkNo?=
 =?utf-8?B?WDkwMnpuZkJOS3pBODZnQUIzRUtYUmpZZEx3Vlo4MkY1b3BrZU9hcnhHWi9j?=
 =?utf-8?B?S3VVaEpsdGVJVzVvMG83UG15azRrR2NZWTNqOHJLLzFtUm00MkJ0OStSY1pC?=
 =?utf-8?B?UDhqWDQzNGVmSkY3cEx4bVc1RGFDclQ1TExoWDBrQnM0N2VaUk15RjlKakZB?=
 =?utf-8?B?SmhRdDdETnJ6MzV3V1RoY0JQL21sWEJRdDRuR3o5NlNwL0YrSmRKMWJKVjFD?=
 =?utf-8?B?cnMvRXhiZUJLT0wzMVp4MFNmdExab2tHOW5abTJ1KzFxenpQZkNlN1JQV1lI?=
 =?utf-8?B?cXVDWDdOZm9ReDZXQWQ4OGNKYlpmTjhmMFlYc3k5a2NUcDZNUnNaVXlZc2lv?=
 =?utf-8?B?VHRYa1AxU3J3Y1loQjB1UkpFei9mc083VjZkMWxaL1ZNdDdZSG9wUTNKVjNq?=
 =?utf-8?B?cXBJUUpETTlocVhzZ3piK1F4VTNKa1A1TThVRCtjWTFYVXpnWC80MHZJSFdN?=
 =?utf-8?B?VzYrZWE2Sm9pRldIc3lzTldnTlNMQ2tydjVPSFEyTDl1SUo5WGRtMmRrdkZl?=
 =?utf-8?B?Vy8ydEwyRmJuRVhCN2lXL2pCdUhMNkQ5d3FKd0FuL1ZFSHZOV2RZSGNXRitn?=
 =?utf-8?B?bVl0b2I5dnNCbmVrNDFNUDZlNjM2UTRPY002MkM4WkV3Z2lzbkQ4U3dWVXdt?=
 =?utf-8?B?OWQ3bWtHaXVTN1I5TUE5Q3g3Q3hKd3hmbldwRHVwZUVhaGRFQ2xicVkvRThZ?=
 =?utf-8?B?VThFZk85OGdCN1hmVVQ5MmlaSUNEQXp4NzlxcGpzZkE2V1pJVFltSDE1QUhw?=
 =?utf-8?B?NG1wSVRmdzlMWXpkK2p3OUZlVzJLMUZ0cHY4Ky9CNFNqay9vbFJOUk5JT1Jl?=
 =?utf-8?B?WVdFVTk2Sys4K0c1cVhsbS85eUNKb21yby9vKzNoMXNnMlN6ZGpPWjY0VkVs?=
 =?utf-8?B?eUo0eE9nUUpmd0xJQ1NOZTFWQnRxaEI0a0RHcnkrTklTYm5oUWF1RzdTYlcr?=
 =?utf-8?B?RWV4NU4vWVd0WXRhQk9mWGcrcW1aOStTSENiSWVPMzgvaVFHbTJkUFdQcVlz?=
 =?utf-8?B?K2VjbjZ2NWNnc25qaXZ5QThtdXdQcDdlUTdwTXUrUVVOTUVCaTRreWJRbExn?=
 =?utf-8?Q?rdKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9012cc66-d8fa-44b5-6370-08dd24306636
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 15:34:04.7790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdkZpa7ceUkD1guZJiSHJFJRkfUh50UlzIwQ93lOqGn2zOY6rdT59GiDuesZ8tqvWZ/dWNA6H73l2VMWayQeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMjMsIDIwMjQgMTA6MjIgUE0N
Cj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGU7DQo+IHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZzsgai1odW1w
aHJleXNAdGkuY29tDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47
IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiB2aWduZXNockB0aS5jb207IHUta3VtYXIx
QHRpLmNvbTsgdHJpbmlAa29uc3Vsa28uY29tOyBzZWFuZ2EyQGdtYWlsLmNvbTsNCj4gY2FsZWIu
Y29ubm9sbHlAbGluYXJvLm9yZzsgc2pnQGNocm9taXVtLm9yZzsgd2lsbGlhbS56aGFuZ0Bicm9h
ZGNvbS5jb207DQo+IHN0ZWZhbl9iQHBvc3Rlby5uZXQ7IHF1ZW50aW4uc2NodWx6QGNoZXJyeS5k
ZTsgVGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbTsNCj4gcC1tYW50ZW5hQHRpLmNvbTsgZ2l0
IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIG10
ZDogc3BpLW5vcjogRml4IHRoZSBzcGlfbm9yX3JlYWQoKSB3aGVuIGNvbmZpZw0KPiBTUElfU1RB
Q0tFRF9QQVJBTExFTCBpcyBlbmFibGVkDQo+IA0KPiBPbiAxMi8yMC8yNCAzOjMwIFBNLCBWZW5r
YXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBAQCAtMTU3
OCw4ICsxNTgwLDggQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWQoc3RydWN0IG10ZF9pbmZvICpt
dGQsIGxvZmZfdCBmcm9tLA0KPiBzaXplX3QgbGVuLA0KPiA+ICAgCXN0cnVjdCBzcGlfbm9yICpu
b3IgPSBtdGRfdG9fc3BpX25vcihtdGQpOw0KPiA+ICAgCWludCByZXQ7DQo+ID4gICAJbG9mZl90
IG9mZnNldCA9IGZyb207DQo+ID4gLQl1MzIgcmVhZF9sZW4gPSAwOw0KPiA+ICAgCXUzMiByZW1f
YmFua19sZW4gPSAwOw0KPiA+ICsJdTMyIHN0YWNrX3NoaWZ0ID0gMDsNCj4gPiAgIAl1OCBiYW5r
Ow0KPiA+ICAgCWJvb2wgaXNfb2ZzdF9vZGQgPSBmYWxzZTsNCj4gPg0KPiA+IEBAIC0xNTkzLDE4
ICsxNTk1LDIzIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRfaW5mbyAqbXRk
LCBsb2ZmX3QNCj4gZnJvbSwgc2l6ZV90IGxlbiwNCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAl3aGls
ZSAobGVuKSB7DQo+ID4gLQkJYmFuayA9ICh1MzIpZnJvbSAvIFNaXzE2TTsNCj4gPiAtCQlpZiAo
bm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gLQkJCWJhbmsgLz0gMjsNCj4g
PiAtDQo+ID4gLQkJcmVtX2JhbmtfbGVuID0gU1pfMTZNICogKGJhbmsgKyAxKTsNCj4gPiAtCQlp
ZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gLQkJCXJlbV9iYW5rX2xl
biAqPSAyOw0KPiA+IC0JCXJlbV9iYW5rX2xlbiAtPSBmcm9tOw0KPiA+IC0NCj4gPiArCQlzaXpl
X3QgcmVhZF9sZW4gPSBsZW47DQo+IA0KPiBzaXplX3QgcmVhZF9sZW4gc2hvdWxkIGJlIGRlY2xh
cmVkIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhpcyBmdW5jdGlvbi4NCj4gDQo+ID4gICAJCW9mZnNl
dCA9IGZyb207DQo+ID4NCj4gPiArCWlmIChDT05GSUdfSVNfRU5BQkxFRChTUElfU1RBQ0tFRF9Q
QVJBTExFTCkpIHsNCj4gDQo+IFRoZSBpbmRlbnQgaGVyZSBuZWVkcyB0byBiZSBwdXNoZWQgb24g
dGFiIFJJR0hUIC0+IC4NCj4gDQo+IERvIHlvdSBuZWVkIHRoaXMgZnVuY3Rpb25hbGl0eSBpbiBT
UEwgPyBJZiBzbywgeW91IG1pZ2h0IG5lZWQgYSBtYXRjaGluZyBLY29uZmlnDQo+IFNQTF9TUElf
U1RBQ0tFRF9QQVJBTExFTCBzeW1ib2wgLg0KDQpUaGlzIGZ1bmN0aW9uYWxpdHkgaXMgbm90IG5l
ZWRlZCBmb3IgU1BMLg0KDQo+IA0KPiA+ICsJCWlmIChub3ItPmFkZHJfd2lkdGggPT0gMykgew0K
PiA+ICsJCQliYW5rID0gKHUzMilmcm9tIC8gU1pfMTZNOw0KPiA+ICsJCQlpZiAobm9yLT5mbGFn
cyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gKwkJCQliYW5rIC89IDI7DQo+ID4gKw0KPiA+
ICsJCQlyZW1fYmFua19sZW4gPSBTWl8xNk0gKiAoYmFuayArIDEpOw0KPiA+ICsJCQlpZiAobm9y
LT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gKwkJCQlyZW1fYmFua19sZW4gKj0g
MjsNCj4gPiArCQkJcmVtX2JhbmtfbGVuIC09IGZyb207DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiAg
IAkJaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTX1NUQUNLRUQpIHsNCj4gPiArCQkJc3RhY2tf
c2hpZnQgPSAxOw0KPiA+ICAgCQkJaWYgKG9mZnNldCA+PSAobXRkLT5zaXplIC8gMikpIHsNCj4g
PiAgIAkJCQlvZmZzZXQgPSBvZmZzZXQgLSAobXRkLT5zaXplIC8gMik7DQo+ID4gICAJCQkJbm9y
LT5zcGktPmZsYWdzIHw9IFNQSV9YRkVSX1VfUEFHRTsgQEAgLQ0KPiAxNjEzLDIwICsxNjIwLDMx
IEBADQo+ID4gc3RhdGljIGludCBzcGlfbm9yX3JlYWQoc3RydWN0IG10ZF9pbmZvICptdGQsIGxv
ZmZfdCBmcm9tLCBzaXplX3QgbGVuLA0KPiA+ICAgCQkJfQ0KPiA+ICAgCQl9DQo+ID4NCj4gPiAr
CQlpZiAobm9yLT5hZGRyX3dpZHRoID09IDQpDQo+ID4gKwkJCXJlbV9iYW5rX2xlbiA9IChtdGQt
PnNpemUgPj4gc3RhY2tfc2hpZnQpIC0gb2Zmc2V0Ow0KPiA+ICsNCj4gPiAgIAkJaWYgKG5vci0+
ZmxhZ3MgJiBTTk9SX0ZfSEFTX1BBUkFMTEVMKQ0KPiA+ICAgCQkJb2Zmc2V0IC89IDI7DQo+ID4g
Kwl9DQo+ID4NCj4gPiAgICNpZmRlZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiA+ICsJCXUzMiBy
ZW1haW5fbGVuOw0KPiA+ICsNCj4gPiAgIAkJcmV0ID0gd3JpdGVfYmFyKG5vciwgb2Zmc2V0KTsN
Cj4gPiAgIAkJaWYgKHJldCA8IDApDQo+ID4gICAJCQlyZXR1cm4gbG9nX3JldChyZXQpOw0KPiA+
IC0jZW5kaWYNCj4gPiAtDQo+ID4gLQkJaWYgKGxlbiA8IHJlbV9iYW5rX2xlbikNCj4gPiArCQly
ZW1haW5fbGVuID0gKFNaXzE2TSAqIChub3ItPmJhbmtfY3VyciArIDEpKSAtIG9mZnNldDsNCj4g
DQo+IElzIHRoaXMgY2FsY3VsYXRpb24gY29ycmVjdD8NCj4gDQo+IEl0IHVzZWQgdG8gYmUgY2Fs
Y3VsYXRlZCBhczoNCj4gDQo+IGJhbmsgPSAodTMyKWZyb20gLyBTWl8xNk07DQo+IHJlbV9iYW5r
X2xlbiA9IFNaXzE2TSAqIChiYW5rICsgMSk7DQo+IHJlbV9iYW5rX2xlbiAtPSBmcm9tOw0KPiAN
Cj4gTm93IHRoZSBiYW5rIGlzIGNhbGN1bGF0ZWQgYXM6DQo+IA0KPiBiYW5rID0gbm9yLT5iYW5r
X2N1cnIgKyAxOw0KPiANCj4gPw0KPiANCj4gV2h5IG5vdCBrZWVwIGNhbGN1bGF0aW5nIGJhbmsg
ZnJvbSBvZmZzZXQgPw0KPiANCj4gTWF5YmUgdGhpcyB3aWxsIHdvcmsgPw0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS9z
cGktbm9yLWNvcmUuYyBpbmRleA0KPiA2OTE5NjJlZjI3MS4uYmRmYmQ0NGYzMGMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGkvc3BpLW5vci1jb3JlLmMNCj4gQEAgLTE1NzgsMTAgKzE1NzgsMTEgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX3JlYWQoc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBmcm9tLA0KPiBzaXpl
X3QgbGVuLA0KPiAgIAkJCXNpemVfdCAqcmV0bGVuLCB1X2NoYXIgKmJ1ZikNCj4gICB7DQo+ICAg
CXN0cnVjdCBzcGlfbm9yICpub3IgPSBtdGRfdG9fc3BpX25vcihtdGQpOw0KPiAtCWludCByZXQ7
DQo+ICAgCWxvZmZfdCBvZmZzZXQgPSBmcm9tOw0KPiAgIAl1MzIgcmVtX2JhbmtfbGVuID0gMDsN
Cj4gICAJdTMyIHN0YWNrX3NoaWZ0ID0gMDsNCj4gKwlzaXplX3QgcmVhZF9sZW47DQo+ICsJaW50
IHJldDsNCj4gICAJdTggYmFuazsNCj4gICAJYm9vbCBpc19vZnN0X29kZCA9IGZhbHNlOw0KPiAN
Cj4gQEAgLTE1OTUsNyArMTU5Niw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBt
dGRfaW5mbyAqbXRkLCBsb2ZmX3QgZnJvbSwNCj4gc2l6ZV90IGxlbiwNCj4gICAJfQ0KPiANCj4g
ICAJd2hpbGUgKGxlbikgew0KPiAtCQlzaXplX3QgcmVhZF9sZW4gPSBsZW47DQo+ICsJCXJlYWRf
bGVuID0gbGVuOw0KPiAgIAkJb2Zmc2V0ID0gZnJvbTsNCj4gDQo+ICAgCQlpZiAoQ09ORklHX0lT
X0VOQUJMRUQoU1BJX1NUQUNLRURfUEFSQUxMRUwpKSB7IEBAIC0NCj4gMTYyNywyNCArMTYyOCwy
NCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcmVhZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90
IGZyb20sDQo+IHNpemVfdCBsZW4sDQo+ICAgCQkJCW9mZnNldCAvPSAyOw0KPiAgIAkJfQ0KPiAN
Cj4gLSNpZmRlZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiAtCQl1MzIgcmVtYWluX2xlbjsNCj4g
KwkJaWYgKENPTkZJR19JU19FTkFCTEVEKFNQSV9GTEFTSF9CQVIpKSB7DQo+ICsJCQliYW5rID0g
KHUzMilmcm9tIC8gU1pfMTZNOw0KPiArCQkJcmVtX2JhbmtfbGVuID0gU1pfMTZNICogKGJhbmsg
KyAxKTsNCj4gKwkJCXJlbV9iYW5rX2xlbiAtPSBmcm9tOw0KPiANCj4gICAJCQlyZXQgPSB3cml0
ZV9iYXIobm9yLCBvZmZzZXQpOw0KPiAgIAkJCWlmIChyZXQgPCAwKQ0KPiAgIAkJCQlyZXR1cm4g
bG9nX3JldChyZXQpOw0KPiAtCQlyZW1haW5fbGVuID0gKFNaXzE2TSAqIChub3ItPmJhbmtfY3Vy
ciArIDEpKSAtIG9mZnNldDsNCj4gLQkJaWYgKGxlbiA8IHJlbWFpbl9sZW4pDQo+IC0JCQlyZWFk
X2xlbiA9IGxlbjsNCj4gLQkJZWxzZQ0KPiAtCQkJcmVhZF9sZW4gPSByZW1haW5fbGVuOw0KPiAt
I2VuZGlmDQo+IC0JCWlmIChDT05GSUdfSVNfRU5BQkxFRChTUElfU1RBQ0tFRF9QQVJBTExFTCkp
IHsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmIChDT05GSUdfSVNfRU5BQkxFRChTUElfRkxBU0hfQkFS
KSB8fA0KPiArCQkgICAgQ09ORklHX0lTX0VOQUJMRUQoU1BJX1NUQUNLRURfUEFSQUxMRUwpKSB7
DQo+ICAgCQkJaWYgKGxlbiA8IHJlbV9iYW5rX2xlbikNCj4gICAJCQkJcmVhZF9sZW4gPSBsZW47
DQo+ICAgCQkJZWxzZQ0KPiAgIAkJCQlyZWFkX2xlbiA9IHJlbV9iYW5rX2xlbjsNCj4gICAJCX0N
Cj4gKw0KPiAgIAkJaWYgKHJlYWRfbGVuID09IDApDQo+ICAgCQkJcmV0dXJuIC1FSU87DQo+IA0K
PiBJIGFtIHN0aWxsIHdvcnJpZWQgYWJvdXQgdXNpbmcgc3RhY2tlZCBwYXJhbGxlbCBhbmQgQkFS
IHRvZ2V0aGVyLCBpcyB0aGF0IGV2ZW4NCj4gcG9zc2libGUgb3IgYXJlIHRoZXkgbXV0dWFsbHkg
ZXhjbHVzaXZlID8NCg0KV2lsbCBjaGVjayB0aGUgYWJvdmUgaW1wbGVtZW50YXRpb24gYW5kIHVw
ZGF0ZSB0aGUgcGF0Y2guDQpGTEFTSF9CQVIgYW5kIHN0YWNrZWQgcGFyYWxsZWwgY29uZmlndXJh
dGlvbiBkb2VzbuKAmXQgZGVwZW5kIG9uIGVhY2ggb3RoZXIuDQoNClRoYW5rcw0KVmVua2F0ZXNo
DQo=
