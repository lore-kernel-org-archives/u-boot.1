Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A8C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 08:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BE8801F5;
	Tue, 21 Jan 2025 09:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wmccyILs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013D880326; Tue, 21 Jan 2025 09:38:21 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE1C800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXEWpoRVnouspBG4gZ2jsdozufT3ONQMnBDSOZW6CApFmWOFZu6QhPAq4SQOjNFaileokNL3W7lQKXXKoXQJZ7v8KcwqIu9LHu3aNdIm0/AiNOW2fuDOjwar94w2Nryc79NnGy2Yx4z9ezNXjEVq2aNP2g6riYh+84r1mI08T24RiHaaDNDtD9z+uqSTUAt1VaHY99CE7Wvui85J4BVCaSyLzQ9Noh/YrzjM0k2IRqosR91D4RUBn13PgIeZ1tijQxDBKPMm9e7in2FO7+4zIAvjSARnJijN20m/ZMIUVwn9ndHYN6AUgaqUkpN9917nxbzwHsR//K2hghlPwG3CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aFijAw02or+aOSxbw7yhAGoxQxkQ2UY7uklnz0x12k=;
 b=hudVx36xqVaCBEvjV/XW7JZLjOVQLMCTm/FX+tPEhy1ZWRKF9rr5Hrg3jkPl++7VYsyGCwun4vhlRYXkxyf1a6cOpIuwxYt1q0pi8cpWXzVumQ4V8dEMqDLYYRxSd18CfBjrWTTFPnR49Es94uNuoqMCiYy6Azu0mUCE3ap40CWVkffBTdijVciv2mUJ04lgqEK2zzg7x+OY0014T+cvNoZSMgIyD/R/ubN9G42drk2QCMQ1VTjVYlYQz2MYJH3h/WXRg99hBJEKNTl53hl2C/hck/HSF4aXOZE5L666EyVf2tChC+sNUkXR0+zNI3b3n1kWZSBanwjslcjOpyK0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aFijAw02or+aOSxbw7yhAGoxQxkQ2UY7uklnz0x12k=;
 b=wmccyILsGnrm/afN9dcrH18fD4l4Ir9wiTTI3TXrTC2yZK1S5BmvHbvInI7/G7NYiXAEzAm8nzbtUmZHSJr37nZZa6ClMN0LYkpHS2fRnxokAtnRfUK8OMsWOJBjlurVOhJ0cDpy5N8EDuysiqOeTih0Bk1y/JiWsUnnP94oAtY=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 08:38:13 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::1f8c:661:11b5:86fc%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 08:38:13 +0000
From: "Erkiaga Elorza, Ibai" <ibai.erkiaga-elorza@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "ada@thorsis.com" <ada@thorsis.com>
Subject: RE: [U-Boot][PATCH v4 5/5] fpga: add new symbol for fpga_loadb
Thread-Topic: [U-Boot][PATCH v4 5/5] fpga: add new symbol for fpga_loadb
Thread-Index: AQHbazkCHyk+9f5yhEi+4fnI90ACnLMfoR+AgAFHwYA=
Date: Tue, 21 Jan 2025 08:38:13 +0000
Message-ID: <PH7PR12MB60003F7419889B79CF00A39AA0E62@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
 <20250120124402.1501320-6-ibai.erkiaga-elorza@amd.com>
 <011685c3-8316-40c1-8edd-60cac6cc2fc4@amd.com>
In-Reply-To: <011685c3-8316-40c1-8edd-60cac6cc2fc4@amd.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1bfa8776-a9e8-4ca9-8963-164c04762352;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-21T08:37:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH7PR12MB7258:EE_
x-ms-office365-filtering-correlation-id: 79346740-4584-4b58-ed77-08dd39f6f1c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Q1l4cnZjZkQ2cUtkR1JmazlNZisyMVJLL3hQWEdnMmk5YzdHYlRpbGgrcExh?=
 =?utf-8?B?U210VHl4aUR1YnFhTm9mb00ySm1kVk84NDNSM3RJR0xuTVk3SW90SkQwa1Mv?=
 =?utf-8?B?Y01ybjBaTFRzcE5QaUJiOC9aOUMwRVpHYkVwWkhDRVYxMGNQbGd2STY1QXN1?=
 =?utf-8?B?QUl0eDFXZ1J3ckwxSzI0VG9QSXA5QjJ1eGxTRW5BUHVqK0ZqbmZPYVlSdDNo?=
 =?utf-8?B?QUUvUlhQOWlac1VvRG5nREhFZGg1L2h2OFoweHpBQzBQL29XckxJMmdIcmI0?=
 =?utf-8?B?ZVBqQXNzVDhRVldoTjIydENnSEk4NCtLUE1IVXlGaFdMamk4NnZXV2o4ckVQ?=
 =?utf-8?B?aWRpZWVMQUhxNnFpMEZWNDhITWVZR3crVjZlWGlzZ05WV0Jhb2FJWXFSZGFh?=
 =?utf-8?B?aDV0a0NpS3RQMGo2NGVmazV6clVtY0JUMXZYL2xhTnVYNWtQbGJZQjlXa0tN?=
 =?utf-8?B?d2pGRzRJelI5Kzc3akJFWWhFNy95TjB4VzRodlNoSGxRMDZ2R29EL1AyTkVN?=
 =?utf-8?B?bmVjZXZJZFY4ODBINXliOGx5RHA5YmF2VmsyWWtkY1ZlSFR0VzBBNVN2UnZ5?=
 =?utf-8?B?anZhNkltY1cybDIvcStQKzM2WmM5bnQvRTJhTGVLY0I0Tk90b2xLRlk0aTZk?=
 =?utf-8?B?b2dqRDdCTWRieWtIdzVrSDRnMHFmbjdLS0twS0NWWkxlQkY3V0JBVFdFcWt6?=
 =?utf-8?B?VjByS3JDajJISUxkWnFPeGFoZVIrK01HQWhLZ01kZ1YrSDZ2bU4vZlI1eFV5?=
 =?utf-8?B?TXJqNUFSdy9RaTZZTndWRzhkRVppZVV6MnpYNWVKTjJHajhBVmlsTTQxWVNs?=
 =?utf-8?B?YjlQOGU5TVZOeHBualYzdVpiT2NKaUZ3MUI1Y2FKR29yZnhRYmtXczl3dDhj?=
 =?utf-8?B?K3M1M1JMelRtWGRLaTh0Ny9UZnBXNjU3R005SFBJSC9SWXN1LzhLNjhpeXVC?=
 =?utf-8?B?VkJucGNCUm1zMU1HdlQ3a3BHRWdUK21Bd0VhYVc2SDFGZFovMjkxWXFkRXFB?=
 =?utf-8?B?TUtmcFRtUXlmbzFpUzhRbVlkVnNYN096TWxMNVg0eTE4djhhRUpGZGJpcW9J?=
 =?utf-8?B?ZHdUWVhmYkZRc0hFMHExcEF4ZklJNDFuaCtJbHQvM0FCdFdSaHZuZ05EYklk?=
 =?utf-8?B?NjNBdG9WM1RGcUVIU1NtaEVCQWJFWVVVWHhuUWV3d1lPTFpjS2ZJbWlsaG1E?=
 =?utf-8?B?YWZNdi9SSmw2UUhlbWdPaWxPdldrVS90b2VnaDd1N3FDM3diQ3g5cU1XYkFl?=
 =?utf-8?B?NWErMXlOTFBVWWhuc09kclJxclh3NnVQaVJOOTl4Z1hGL0p5ell4ZEwreWs0?=
 =?utf-8?B?RTV1Zit2akQ2RDYwTlV3QWpBU0p3YVZzZEFYM3J1QzVkWnJyZk9TQ0RxSGp0?=
 =?utf-8?B?TWt0bGJQUGt0MjNZT09IczlIcUxaYmpJOWxDS1VRSklNSmJ3bmNjUUtvRzhy?=
 =?utf-8?B?NkhaVW0wL2JQWkYvbUduWHZNc2Q0MVliNGhnTmI5enF2alFaL3had1VwSFVL?=
 =?utf-8?B?alBEemE5ekJHR2llaHJudzU2NXprR3lNNnh1WVZXY2hJWnBlbUg3ZGlxTElj?=
 =?utf-8?B?Qk9zaFMzV3FhbnJQVllHblc0RXkzNGlwdTRVLzluNTZkWmFoRGt2N1ZMQTlk?=
 =?utf-8?B?bXUrSjRPQXBQbzY4UnR4OE11dEpyOE94Yi8wNTVrZzVEdHJrdXNIWXdRSGpQ?=
 =?utf-8?B?STd0Y3ZVd2NrMk1qYmJPNFZuWUNrYXZWVFZid3hEY2E5ek1ncmQrbkF3ZGRn?=
 =?utf-8?B?bDJGemQvTXRKMUxIS1l2Z0xKYVhmUFJBVGpPaklmMUpyYnMwYmJkSUxkOTlC?=
 =?utf-8?B?VGlQdGIwaEUySXc4QzNvaWIxQVRvTHlaTTYzMGpoTE1BeDZVZFBuYWpOWUpW?=
 =?utf-8?B?aUt6RkdFZGt1cVBlbXhFTkNYeXRaRlhFZjBsblVhaHFtZ2Y1UUdMWmRWMlp0?=
 =?utf-8?Q?BNKlrtsuyVpmpgUELchxRjInjWrxzGjh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTU4cjFaRXpnVWVxVVZFbW5IS0t2US9od1EvWERWVHlzcllxL0pLbDN3UjNy?=
 =?utf-8?B?djdtY0R4bGc5bG9kWEc1UmFhYjJkL2dyN280ME9xUUVqb0RkUTQ4UmhDbGRK?=
 =?utf-8?B?WWNZTVNSUExMTkRFTUZDRi83cndRdDJuWkhzWDBUQzhUazUxWEh0WUMrMFo5?=
 =?utf-8?B?dE8rREcrdGpSQjNzVWVzQnhNV2NHSjNCVkpUTDdsNkJheCtHMHhXWG40NnN1?=
 =?utf-8?B?SFZRS1NjaDNyVnlsZnluZ0dCbkphZmpEbFl1TDU2ekpOOFhnMHZJTlBLQnA3?=
 =?utf-8?B?QlRmQkxRS1NhaExRUG5EbkFrUmdtRkd0S2NmdERJR2NzWkl1c29TN1FIcVhT?=
 =?utf-8?B?MXFpaXR2dzBaVTVtOXhYd1VTaXhaQzFyVFVmUnEyZHdGdTcrb3p5V0FCRlNM?=
 =?utf-8?B?aFpYTjNYUU1zdGlsZk5WNkJQU2s3b1RyNkJkd0JJWHdzSXJXTTlIOGFnNUxX?=
 =?utf-8?B?NmJZWDJXRUpYV1BtOGNudkxqeGlUUld3MmlzRXUrdm9MWEJwMFlVR1g3dkJK?=
 =?utf-8?B?ajQvMzBqL0JkamlxZ1ZQV2xWd0FDcjBTYU9ITVp2V2RRUWNRUE5hYXh4Q3Qy?=
 =?utf-8?B?YzM5WVJaMk15TzB0RXN6TytVY09HTHlwQ2cwMUJTTHdFNDBnVzFZRDY2T1J2?=
 =?utf-8?B?Z2ZxcXlKSHVvSElwOWFMUnk3ZENEbFl2S3lrcWk0ZS95YWh4KzVKR0pzUGxm?=
 =?utf-8?B?eGNDYU5pT0JYQVpnOVV6eUlNTVhNcytvaHh1VitTYXBxQzVOV0xhUFF5OWVl?=
 =?utf-8?B?eXhsNG90OGJSV3dsZHVTQWtnYStScFJ5WHV0VkcyT3k4R0tCM3BJVEtvMkpk?=
 =?utf-8?B?RVNSbWlNd09oY044eVR2Y1h0SnZ2ZSswQVcyZGhIaVJPUzVEVEQrVGFYVWlM?=
 =?utf-8?B?bHhkcUdQZVJvdDN6c0RlRlVzdXlLZ3E3cnY5aEpPbXBwRzNuNElNZWxOeTIy?=
 =?utf-8?B?eko5dTM3NlovbFB1bTNwS0daMG5peEpHTmV3NzRoZDVWWlVlaXE2RTFnaTN5?=
 =?utf-8?B?UTNCcmR0VnRaRjNvVmxuRmlMWFdCMDhIZG1TdkpXclFpVUhiWnNLNEg5cVlF?=
 =?utf-8?B?MTVQRHY4OWxocWxhRE1lNmpQWm1CdDgvbHVNM0p5MmNzTThBOXhSR1ozRi9s?=
 =?utf-8?B?bEN6RUFvQm9SVUtNWUxhUkZ0d1o2ekVuUTJDakxEZWNsbWYwaCtXUHNETGc4?=
 =?utf-8?B?RDBkTVlVL2RRdnBCdGtOMVhmNk0rNnk1SWlGay9wZDZpaG44UnNFR2FKSkMy?=
 =?utf-8?B?OTJaQU9LdmQ2eW1yNGNWblBXd2JSbDNXSFpFMkRnb1ZVTnBhOVI4eGRlckts?=
 =?utf-8?B?eHF1ZjhpNGZ1T1JuZEFnanVRWnBzS0FSUmV6RjB5TFJTdUJYdVZMUGRvOUxN?=
 =?utf-8?B?T3YyRnVxOU81ekpoK09tY0FoaWtZUUpOUWtnVXBod05WMUdBN0lvVXpxcnFL?=
 =?utf-8?B?UDNvRVV2My9XZkNTSEM0UmQ5MTdpTUIzNFZZZGNPQnhFU3JRNGQ4QVZZYTJV?=
 =?utf-8?B?Wm4zbkViMTNieE5PU0hZWllBN0c2NWVQcXBaODhqT2JMaGxGSXlNK0xROGw3?=
 =?utf-8?B?WjVJbWVXaUxTUWhFMmRKMEpOUkIzYzNsaVpMelNzYktZQjJKNis2WERSUnkz?=
 =?utf-8?B?K2JQSFZuZ2ZMRG55ZVRGc2tOUGR4SkE4djdlSVBpQUJtaHRhYUQ3cGdmcnZX?=
 =?utf-8?B?SUxMemRkOEtkS1YwYmlXSWdRQThLOU9BbzhFbmhqaFRTd1pRQXFmSHNIOXVL?=
 =?utf-8?B?MEFVbHhhYkU3UXJQYm4wNFhIL1ZmcVI5TlFUYjhSMEgxdlF6UjR1cXJZT1Fm?=
 =?utf-8?B?R2E1am1pVGxCck1wdnRjdGswREsvYjlicUpvandKemRGTXVKVDdzd2M2MVdm?=
 =?utf-8?B?QVF0ZEo4R3ZxWXduQ1gydUlkMTh1YngyMkVaTjA1cTBOSFB3VzZ6TlhBdy9j?=
 =?utf-8?B?TlVqeHlwUmFhSWVpMjBZT2pEc1dObjBtaGxyKy96K0dTeVlLSFdlSFNucHJX?=
 =?utf-8?B?L2ZKWHVMN3Y1NXU1Y3piRkgzSkZUWTdSZEJPT1JpeFd5K1YyZ0JKN3hSMU1H?=
 =?utf-8?B?endjRGNSeVhlS0lWSXZ4ZW1GUWQ5TEtKREpKaU9EektkTmRIUm13MVVNdTVR?=
 =?utf-8?Q?Ps2s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79346740-4584-4b58-ed77-08dd39f6f1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 08:38:13.6859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qH00lRbgfOCmrzBU6qD7nebAkNxpeoPX7Dvd87h6y8ud1RkgNQzgNGjjVzVXFSCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWljaGFsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2lt
ZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSAyMCwgMjAyNSAxOjA0IFBNDQo+IFRvOiBFcmtpYWdhIEVsb3J6YSwgSWJhaSA8aWJhaS5lcmtp
YWdhLWVsb3J6YUBhbWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IGFkYUB0aG9y
c2lzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1UtQm9vdF1bUEFUQ0ggdjQgNS81XSBmcGdhOiBhZGQg
bmV3IHN5bWJvbCBmb3IgZnBnYV9sb2FkYg0KPg0KPg0KPg0KPiBPbiAxLzIwLzI1IDEzOjQzLCBJ
YmFpIEVya2lhZ2Egd3JvdGU6DQo+ID4gQWRkaW5nIG5ldyBzeW1ib2wgZm9yIHRoZSBmcGdhIGxv
YWRiIGNvbW1hbmQgd2hpY2ggaXMgZXhjbHVzaXZlIHRvDQo+ID4gWGlsaW54LiBEZWZhdWx0IHZh
bHVlIGlzIHkgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBJYmFpIEVya2lhZ2EgPGliYWkuZXJraWFnYS1lbG9yemFAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPg0KPiA+IChubyBjaGFuZ2VzIHNpbmNlIHYxKQ0KPiA+DQo+ID4gICBjbWQvS2NvbmZpZyB8
IDcgKysrKysrKw0KPiA+ICAgY21kL2ZwZ2EuYyAgfCA4ICsrKysrKy0tDQo+ID4gICAyIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvY21kL0tjb25maWcgYi9jbWQvS2NvbmZpZyBpbmRleCBjOTYwMDQ5ODc4Ny4uNTVh
OGQ0MTg5YTQNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9jbWQvS2NvbmZpZw0KPiA+ICsrKyBiL2Nt
ZC9LY29uZmlnDQo+ID4gQEAgLTExODYsNiArMTE4NiwxMyBAQCBjb25maWcgQ01EX0ZQR0FfTE9B
RFANCj4gPiAgICAgICBTdXBwb3J0cyBsb2FkaW5nIGFuIEZQR0EgZGV2aWNlIGZyb20gYSBiaXRz
dHJlYW0gYnVmZmVyIGNvbnRhaW5pbmcNCj4gPiAgICAgICBhIHBhcnRpYWwgYml0c3RyZWFtLg0K
PiA+DQo+ID4gK2NvbmZpZyBDTURfRlBHQV9MT0FEQg0KPiA+ICsgICBib29sICJmcGdhIGxvYWRi
IC0gbG9hZCBiaXRzdHJlYW0iDQo+ID4gKyAgIGRlZmF1bHQgeQ0KPiA+ICsgICBkZXBlbmRzIG9u
IENNRF9GUEdBICYmIEZQR0FfWElMSU5YDQo+ID4gKyAgIGhlbHANCj4gPiArICAgICBTdXBwb3J0
cyBsb2FkaW5nIGFuIEZQR0EgZGV2aWNlIGZyb20gYSBiaXRzdHJlYW0gYnVmZmVyDQo+ID4gKw0K
Pg0KPiBKdXN0IHRyeWluZyB0byB3cmFwIG15IGhlYWQgYXJvdW5kIGhvdyB5b3Ugc29ydGVkIG91
dCB0aGVzZSBLY29uZmlnIGVudHJpZXMuDQo+DQo+IHlvdSBoYXZlIGluIGhlbHAgZnBnYV9jb21t
YW5kcw0KPiBsb2FkYg0KPiBsb2FkcA0KPiBsb2FkYnANCj4NCj4gQnV0IGluIEtjb25maWcgeW91
IGhhdmUNCj4gTE9BRFANCj4gTE9BREINCj4gTE9BREJQDQo+DQoNCkFncmVlLCBJIHRoaW5rIHRo
ZSByaWdodCBvcmRlciBzaG91bGQgYmUgbG9hZGIsIGxvYWRwLCBsb2FkYnAgaW4gYSB3YXkgdGhh
dCBmaXJzdCB3ZSBoYXZlIHRoZSBmdWxsIGJpdHN0cmVhbSBwcm9ncmFtbWluZyBjb21tYW5kcyBh
bmQgdGhlbiB0aGUgdHdvIHBhcnRpYWwgb25lcy4NCg0KPiBBbHNvIEtjb25maWcgZGVzY3JpcHRp
b24gZm9yIGxvYWRwIGFuZCBsb2FkYnAgaXMgdGhlIHNhbWUNCj4NCj4gZnBnYSBsb2FkcCAtIGxv
YWQgcGFydGlhbCBiaXRzdHJlYW0NCj4NCj4gZnBnYSBsb2FkYiAtIGxvYWQgYml0c3RyZWFtDQo+
IGZwZ2EgbG9hZGJwIC0gbG9hZCBwYXJ0aWFsIGJpdHN0cmVhbQ0KPg0KPiBUaGF0IHNob3VsZCBi
ZSBhbHNvIGNsZWFyLiBJdCBpcyBsb2FkaW5nIGJpdHN0cmVhbSBpbiBCSVQgb3IgQklOIGZvcm1h
dC4NCj4NCg0KQWdyZWUNCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
