Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAE6C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141FB820EB;
	Tue,  1 Apr 2025 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="iLboxT9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7261881ECD; Tue,  1 Apr 2025 09:44:41 +0200 (CEST)
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDFFC801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw6RKeeoBcqBLhkyMKMbvvHorkP3vFJGvluMedQ1NrSUv7ds3uELBnaETLYbt2MKbM/BK7omXbiE8eoCO8HlCmD6A0/c96kU1ytnKQYo8Po6PJ5jJCzdQ1apr7JlRELcg1tYOsehQLpuUkHHOe1lsqY7PefdupSr8UbnqG693cLhmYdDHP7AYwO3mMaoaJvlBY9fWcGeO6N1EAxcz3GkAmjArlLElAbKEwFB37tY1QmBnv43f2ERHcPb4tlAeYY/81aw/iAn51nmkpDeNv/uqb90Ea7MCH5RiQsyGeyY2hg8E1UwbuEeaU5e8YtGoWeD37QF6cptO7o8/9R0MYh/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu0kc8N7O6PfnYM6OwG4wOoHV04rxh8OCX4XIY0holI=;
 b=mi1Wl1s5PzFJu62Hg6zZsM1giy5YS3/ylki4pCFMBwxeGRPIhEzTpgfKLzByPjDBuMTBArJ7jk0WnhZvfw9QRQo513pMBmQ+SCzoSeT69QuEkgZO2xb8gcYYnTKPviM8ccpCeyudFvitKa0yShIxn9hV6VKlCl1Rk3aJZ28NV+v6xp6acQF8iR/JCK4Vb1P/Kf8dYY2ZzB6eOHQeVGmuikCEXpqnoFtk+c39Ml/lQW+YbCtU6E6tGjBSrzS5JpAhhuVgU5QuvCW6TsKe5u8ATtR8R5763jGPSeKlmGI5I3WXASYRCgyHvUysp2UwqyNLC4fvgT9WRgUSSAmCfAxu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu0kc8N7O6PfnYM6OwG4wOoHV04rxh8OCX4XIY0holI=;
 b=iLboxT9xecMKr/W8V3mYUOtGn9gWrCwbkhX98zss4e15Fhc9CFhnD0IK93YDzRDkqHbmicO+KYUdyUvxniQNgD1YvJYdLTPWUrBARmTyAi2ZGvvIA0yvl41VH7G8+54EryIuoIWEvrw4zU5owJqE09sjp4JcogK64SRPchEZLc2ojHYRPvLrAQWRVOttZlEMbniQg8holqM01fI73E4m5FN4n8Gv+AhcJ6jmKO8VdMwOSSa/cXXg2mTJ7S3WnztNBai0LXb3pkSGZ2eKnilaK5dNPMIvTnkiogNuT7X32FgHC59mECw4yM5o+MTfCSKHT8yU2ulnbS0l1j7T54t7QA==
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8)
 by SY0P300MB0627.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 07:44:34 +0000
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b]) by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b%3]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 07:44:34 +0000
From: =?gb2312?B?xaMg1r666g==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] bootm: Support load images when os is elf
Thread-Topic: [PATCH] bootm: Support load images when os is elf
Thread-Index: AQHbotmQFUbPbx3tOUiywapevR3vOQ==
Date: Tue, 1 Apr 2025 07:44:34 +0000
Message-ID: <ME0P300MB130922F2666257BD3431535C9FAC2@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB1309:EE_|SY0P300MB0627:EE_
x-ms-office365-filtering-correlation-id: ffd1507b-43a6-45ce-cffb-08dd70f10bfa
x-microsoft-antispam: BCL:0;
 ARA:14566002|15030799003|461199028|5062599005|8062599003|8060799006|19110799003|7092599003|15080799006|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info: =?gb2312?B?TGRrSFRKNXJianZ0czUrTGRYUkhNZmpBSkJaQjZHY2krQnp6MUhNUENObkk3?=
 =?gb2312?B?YlBIM2pqZmJ0bU9GNnNCUnBaOG1mR0wzQVhnci9Rek5CcUhORk1PVndRV01L?=
 =?gb2312?B?M1F3QndIMzEwOTRLNjlvZ0FOQmh4S1NSbGdnYUpTaGdoV1FTaXFWQTRvNlhk?=
 =?gb2312?B?RHE4eDc0NjJSUWorc3ZaanJMUytUamJPU2JWRklhSzlZQjVPNVFjMGNxdlcr?=
 =?gb2312?B?TWxpTFdXVWg4SXNaS1V1dC9vanc1VmppOHQ4bko3MFB1TXJyZTA4NTdKdVUr?=
 =?gb2312?B?MFlvdWdZdHM1RFEwZlhRQUVGdFlvcXp6MjRjMEhnMklIQjg3c3JYS2x5UGNP?=
 =?gb2312?B?dzNVcGFvRkJKRzBYeE1HVVJtcFMxcTN5bjBVRHNDNGpKM1ltMDJJdnZBbnRx?=
 =?gb2312?B?T2dKOGdZV3U0UzEvNGw5S3FSZjhjeEdyTDA2dUdyZGtkMUhEcE5GeGh3d1ll?=
 =?gb2312?B?R0tpc0hxZFJ2aU9xUlhJZXF0L2FQQmtzOUlsMmtxOHFOZXVpRmxRWUI5ekkw?=
 =?gb2312?B?MjUwYWk4a2x5SUY0QzlXUlk5OEZ1SmdPaDJHblhOTUN2ZUJtTjc4bm9vYnh3?=
 =?gb2312?B?QjEydFJMcElJNi9vV3djNEtPTHZqVFpWTVZiL01IR3FjbFBRYmRjUHRMdUQv?=
 =?gb2312?B?MWJ6TEwvaHBmWEgwL0pnU1ZxbThWRHFFazl3eFJ0SFpIdGtVcXAyOHNnSmdO?=
 =?gb2312?B?cG9sWjgyS2ZmeHpNYjVhc3Q4UThqSGZIbG5icFdUQVhtbmJNaVF5OXlHeDU2?=
 =?gb2312?B?b20wZlZtcWxpeVFIRlVQSWdDWndTaUhMVVFLTmRUV05Xb2YzTWJ2eUFDWEs5?=
 =?gb2312?B?K1J3Rm5aY2NoVWt3U3RsM0pNMGpqUGx5U09mcWJ4cGU3MGJsKzNya2Rka2RT?=
 =?gb2312?B?bGVONStibkFGSEZ4RXU5WGJXeWM4dW5VVVZJdFM3Y1dBVlFLazk2SncvQ3Ry?=
 =?gb2312?B?dW9oaFByR3dkbDMrVWtTZ2pEak0rKzhuRWc5a2haUGl1QWZNV3U5VktBQnFo?=
 =?gb2312?B?ZkphQUxqNzJsSDIrcVdhTGFFN0xMc0hmYjRQeXhnTUVob3BiUktxeXdVeElY?=
 =?gb2312?B?QVVHUmpneTZBSUh4TG9UZTF6ajRObmxzY3RzanhGeFBscXdKSmxhaStMdGM5?=
 =?gb2312?B?TkxVTUV6YTd3N3JhSVFMeW1qU1RhMnJNM2FIalErUDNvclhxVkIrdGJVUVFt?=
 =?gb2312?B?N3BKSjNoOEg2T1lPM2ZvK2RLZFkxSncwNm92UWNUeXdKcG0xZGE4czM3bndz?=
 =?gb2312?B?L21OKzZ4TUdCUUNDVHNGZmZCZUhuZm4zUE5zNkNUZ3FFTk9kUWM2V3RSdlI3?=
 =?gb2312?B?ODNvaGtYNXhNL2h0SW5zS01pYlJGbUFZZll3VWcvRkJYWThacjJmN1ppVW5R?=
 =?gb2312?B?ZHdKNVhBZEYyUmtSQ0x6QXhoTHlvWmdRWFRpTmZKSUVkeHVUcVR2N0diOGlC?=
 =?gb2312?B?YjAzaUZRb0lwdEtMOWtCc3JsVU1IMndpVjlmdXI1TkxTeFQxaW5DY3ZFYUZa?=
 =?gb2312?B?ekxjUFZhR09wd3g1WDFCUUdUSnp1bzVaREh4eE1QM2FhYjJUQ3ZCQ1lMdUNq?=
 =?gb2312?B?REpqbmovRWlYaFd5VnFjeElMY1NQWC9CQ3F2ZFNMK0hvSHBPeE5pNVR5aFcr?=
 =?gb2312?B?eWpwQ2hCM0Z1VVQ3WmxZcHcybEczWEE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z1EvaXBGZExyNGZBTW8vMWRwWUtGWk1YS0VLbVFyYzZOb2JtUnlhOEtDbU0x?=
 =?gb2312?B?bGhXa2loc3VqUW5maG13RmcwV0EySTkxTytaKzFtSUdqa2VvdlI4RmRNdWo3?=
 =?gb2312?B?d1pZUitqdzMrM2huZkIrZzdPUUZQcERhOWViSVNHdTZFenRLOVJtUG4zL1gr?=
 =?gb2312?B?MUZvMm9LRXA2eXp6RmZtY0FsUlIxaXRTYThsZWM5OVE1U0RKSy9IK3VMTDlY?=
 =?gb2312?B?ekJhS2lZTHEyaERGS2ZlY044R0FzbHhkekgwQ2pzV040bkc3UnVyblM4b3Rz?=
 =?gb2312?B?bU82Mm1LeXZTVUt0VU5jRjB0SmRHd3NZOGZRYXp4UlBSRDQ2a0wxSDZPNGtx?=
 =?gb2312?B?VjNYNHZOd0RVZmp0U0lYd2xoV3pSWC9FakZsaVZnUXRGZGhXUnNlRFJIeHpt?=
 =?gb2312?B?aTB0Sm01Uzdoc2l1NGp0UWx0U2QwbExMVkR4SkRZaERHSXlYUUZPWGxtVko3?=
 =?gb2312?B?ZWhxL1RWOXFWVHQvenZ5K0pTbmFZYWk3NFlQV1NOZ1FJam1yY25pOHk3b0JL?=
 =?gb2312?B?cktBNlJyOGhKL0hkZnBKNU93SGsxZmdXQldmeU5lNllUQVpwOURDbEdpMHQv?=
 =?gb2312?B?ZEY1QlN0MzlhMnFFWjhTNU14V2NJRXpBMjRKOXNJTkw0aU40dlkvb3owcXpQ?=
 =?gb2312?B?OW5GOTgwOWlSNXkxMlljOWFXdXBHY2xPOXBLc1lzb1IwUnZpS0UxblhnR3BI?=
 =?gb2312?B?TGdFdnRkOFVUMmp5MzV3RnpUZzJhR3MwRXJLVnA3dlZUSm44dVBDSFdpTnFJ?=
 =?gb2312?B?VERxMU9mbUR1dEZHeFZxb2N3QXBwZTdNMEMyNzZycWtTcHZBY1VGanJmVGZG?=
 =?gb2312?B?U2FrYlpSY2NjNVBPcmZzS3p2cy93L243N21xVGxVQ3VCSi9wWHcyU0hWSEF1?=
 =?gb2312?B?V3ZCRG9IT1F2TTVHMDJHT1o0MWI5cTkyaFJTWVF3ajc2UEJoY1pKK3EvZGMy?=
 =?gb2312?B?T044SWxHdW9FWklzakJITGx5WkZaREg1cld2RGNnMithM0RTUERSUXJjK21N?=
 =?gb2312?B?RkxFOG1ESGQ1QjlpOUtiMld6cXh2V3hXOWF1RVJxNVdlcGZjMkVHcHYxNUNH?=
 =?gb2312?B?bEVmSVN1dzAzWEFDdmd6SG1HcStzVzROUzA1YUhxNnJiSXdZK0FHV25LNGNo?=
 =?gb2312?B?UFBEdm1XbTR5SHZsTXVkczRlamVxR1F1Y3NnWlBCRW5sZGhuNEVWU3UvZU5a?=
 =?gb2312?B?NFRHQm1HenNFNDdPSU9xa09oZEx3MkFDUjlkTWJkQTlpcXpPT2J4bDF5WFBH?=
 =?gb2312?B?Q2tvZUwrcG1mVmhNa3dLSnlwem9BRS9jaHdJYlphMkNxN2xDVWV4VDBXcUtY?=
 =?gb2312?B?anloV2tZY0MwTzM5MTViVTBNdkRSZ0FTSno2ZWY1Q2E2SThpSy9QZ2kxbkph?=
 =?gb2312?B?czBnWGNYaHowV0E3ZHc5SFpVU25IRGd2aVBaK0NuKzNEQWZ3Q1IzRVlaRTRr?=
 =?gb2312?B?SzQ3NHYvZXJFYVlmSkVZZUhyaFZHSHI5OGlZOVVnKzFMdkh3elVJUEZZRGxI?=
 =?gb2312?B?N2Irb1ovbjRSbXkrVWg1MG00dHY5bmVMOHgzQWtIUlh0ZS9TLzF1YXVGNUhS?=
 =?gb2312?B?cWduT0ZPK2xWQ2dhb29rbGZuTHNkbmlVMjArMUszemh5MkJJTjlZbjc2cFRJ?=
 =?gb2312?Q?d9T4oaJXpLn265IuZIcqbAHAT+XUoQs02a6Rg+vH2Qvw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd1507b-43a6-45ce-cffb-08dd70f10bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 07:44:34.6310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0627
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

DQpUaGlzIGV4dGVuZHMgdGhlIGJvb3RtIGNvbW1hbmQgdG8gYWxsb3cgZmluZCBpbWFnZXMgd2hl
biBvcyB0eXBlIGlzIGVsZi4NCg0KU2lnbmVkLW9mZi1ieTogTml1IFpoaWhvbmcgPHpvbmUubml1
emhAaG90bWFpbC5jb20+DQotLS0NCiBib290L2Jvb3RtLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Jvb3Qv
Ym9vdG0uYyBiL2Jvb3QvYm9vdG0uYw0KaW5kZXggODU0YWM3ZWM3MzguLmE1MWFhNjhhYTlkIDEw
MDY0NA0KLS0tIGEvYm9vdC9ib290bS5jDQorKysgYi9ib290L2Jvb3RtLmMNCkBAIC01NDUsNyAr
NTQ1LDggQEAgc3RhdGljIGludCBib290bV9maW5kX290aGVyKHVsb25nIGltZ19hZGRyLCBjb25z
dCBjaGFyICpjb25mX3JhbWRpc2ssDQogICAgICAgICAgICAgaW1hZ2VzLm9zLnR5cGUgPT0gSUhf
VFlQRV9LRVJORUxfTk9MT0FEIHx8DQogICAgICAgICAgICAgaW1hZ2VzLm9zLnR5cGUgPT0gSUhf
VFlQRV9NVUxUSSkgJiYNCiAgICAgICAgICAgIChpbWFnZXMub3Mub3MgPT0gSUhfT1NfTElOVVgg
fHwgaW1hZ2VzLm9zLm9zID09IElIX09TX1ZYV09SS1MgfHwNCi0gICAgICAgICAgICBpbWFnZXMu
b3Mub3MgPT0gSUhfT1NfRUZJIHx8IGltYWdlcy5vcy5vcyA9PSBJSF9PU19URUUpKSB7DQorICAg
ICAgICAgICAgaW1hZ2VzLm9zLm9zID09IElIX09TX0VGSSB8fCBpbWFnZXMub3Mub3MgPT0gSUhf
T1NfVEVFIHx8DQorICAgICAgICAgICAgaW1hZ2VzLm9zLm9zID09IElIX09TX0VMRikpIHsNCiAg
ICAgICAgICAgICAgICByZXR1cm4gYm9vdG1fZmluZF9pbWFnZXMoaW1nX2FkZHIsIGNvbmZfcmFt
ZGlzaywgY29uZl9mZHQsIDAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDApOw0KICAgICAgICB9DQotLQ0KMi4zOS41IChBcHBsZSBHaXQtMTU0KQ0K
