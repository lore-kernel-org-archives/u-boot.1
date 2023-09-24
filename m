Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09559CE7A88
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 03:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208168684C;
	Sun, 24 Sep 2023 05:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="B+Df9zyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38D5868D1; Sun, 24 Sep 2023 05:27:34 +0200 (CEST)
Received: from IND01-BMX-obe.outbound.protection.outlook.com
 (mail-bmxind01acsn20807.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7011::807])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7206286552
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 05:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tjjh89017@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1V3owz+LS8QRPq+zNrHxPAlYWiKKrs9qiTgZn3/xN+7lKmUt/VK5s8qByiKou13TLTIzMkuEeagnq0vpY2cW0WgzwRY8jjmbTDkvYZ22HDluV6hHlLQNPPugYjUbN6+sUah6Is3WwlJdA1TfiZeQdU5a27MVwCo/3QtZyO0NapijrBnsGhdA6O8ZZcYuM92ODsXjhL50EDLNgQScJCJzXIjbtTvPMMbwhASc8uRAkzaQh7WERCJBuIrjQtUpSmoePQSKgYINAoYQtdHBT7iPx2Pe0I/82g74izW+lIlvfdLO0S/64VMDYPTLo5K5xJwiMzRbWX3S8kEDiqIG/fCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axnMKWcG/Ie/ZVXu/YRhCxvHF6frcmI9kj5LR8IxPHY=;
 b=HP5W2QQrElLoAUN6NuMM4tejUPKAJZ+DDmcu/deEPphBtGLkfPpPGK5UnW960MFuZuZrrBj3aoLg9bEZD9uDyuC/dylOWfH0B0rdd0PIEUBMaCh/Uhs5ty1V+jZkoeNjWkIS+zAUuHWonNri+TzFpOEzH21NbPjURu+P+ACZT9irT/7Jo0qadpK//GAU7caOmHBCdeN0hJ5xXhf9bMQWtYP2jusnCoOWuiaMYjoYTXsO5RY65RhrlVbyqdjzSidXq2G67cy/1eyd3miwS3gZthBeWgizwznwQ3x8Xllegu012/KHqt2wXtuUzThSaD1xbggRTdo430q9GxiCSWgO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axnMKWcG/Ie/ZVXu/YRhCxvHF6frcmI9kj5LR8IxPHY=;
 b=B+Df9zybIzaZ8EM4BrZx4hAtRufItT71rcfb90MCmNQVhxQqM4jmaEtrPWc9gWw9sdPDTGbjqanapKb8C8ZK+Wxvx6/GbiXgKr67WvTQv69i1bRZ6kCAg69evl+QvzX1QHdZmvcq/On4moHaumSiSPiQ71kmkxRFr3j9BtGwzfWow4zexKi+0gzNeq14+ZpF+IGCRXigWysTuDdthZvXLf7s/7mGzjjJ6CeA7hfrfVL4/YTry6FJ32o5DtuEVHgHzuq/yx0N1b9rAtGe4KtDLQ51vbseDCvA4ehQeCmAMXZoUtEC0S7QAR5thfd92u7yGAcZXWaTp3w4anNW+5cntA==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN0P287MB1380.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:183::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.27; Sun, 24 Sep 2023 03:27:27 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278%7]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 03:27:27 +0000
From: =?big5?B?tsAgpnSxag==?= <tjjh89017@hotmail.com>
To: Simon Glass <sjg@chromium.org>
CC: Matthias Brugger <mbrugger@suse.com>, Peter Robinson
 <pbrobinson@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: rpi: set boot_targets with correct macro expansion
Thread-Topic: [PATCH] arm: rpi: set boot_targets with correct macro expansion
Thread-Index: AQHZ7kycZqLrD6bmjE2DCfKGUg70MbAovtcAgACSHpY=
Date: Sun, 24 Sep 2023 03:27:27 +0000
Message-ID: <MAZP287MB0503060B9753239AB8E68C96E4FDA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
References: <MAZP287MB050324B04DDD0AA9C6DD905CE4FEA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
 <CAPnjgZ2Hg+b50MmiXrgQQdxmjrkeHW+wqHLfyvuJoUYj1mGAgQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Hg+b50MmiXrgQQdxmjrkeHW+wqHLfyvuJoUYj1mGAgQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [aPWc5hRf1725nT94QwpRmLs6KjqgxlC99iWSfxLIMaVjpjWFpwu3AexvIXaWH9DI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZP287MB0503:EE_|PN0P287MB1380:EE_
x-ms-office365-filtering-correlation-id: 48d038db-5c0a-4520-056d-08dbbcae2d72
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cTzQ7/4vt2WlC+2NSenIsZnBx3SGtF47ftLMLYYijA/SqjIJJvM05Uhw7X5EtxOHStG2vGjHaHSkFK+/MXr66mvttL4y7tpSwsCUGNhF71RGkcZmXMR3oDJ6WbKde4WU3Hru5WM8zp6h+b1A/2gOakDZ0s8P7si9Y1T+pmZflqoUB/Q6fshEwTDkuivKeIzD09ZlmTL5skYqT25uGoRx0e/k1/7dPBz+zqyvKjCgBco7HJ/jhmu8lES78dOmDlhzx55EGIqbaw5L7VTsKPCz3xGcnk4fIExC/Oty7LDixG7aIpNZd9jQ2U9dVI/ZhRAKdnvYXMQQq0PvIzah/E9YfdG6jpiZGATLzGl0J0NuIJjwtiTyk3GSIP7mlnMwBu62NstiteFbtnmzi1ui5uP0Ldp8GBg96/cnZ6CGAZPLk2jSEK0i/PlIvVb5g/i4zmxtsJuIff0pX0PGSf0yGJGJe7aBPIaBkpHltMngG8Ix4iZ7etSd90w8fNlmuLUmwdACiUltO4VJ3eIKR5QseCXysQgxG3vgVEF4C2ZSR0oBnOSXMITA1pt8Da55BEwnEFHA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?S29CYmhxMXlyUGp2UXYrcDB0eUs0WDZKUWd4WGlmZWsrbXRjUklZZmpLK1kyK3dO?=
 =?big5?B?UkNkL0VBNTVXREk1U2N3eEJuRXFFOHo0OVJWMkZKNkg5b2RQcVd3czRvN3ZIYWRp?=
 =?big5?B?bGhucTduMWxnQ1VoK2FEM3VSMW4zODVGRVJvR0FIOTBzNzgwcTVva1lZTk9zZDF2?=
 =?big5?B?RjZ0d096elI4a3NFK3QyUDluN2dOTU9GbllXakx6R2p4aWRIQ2ltSWh6QW9FM3Rl?=
 =?big5?B?UDNhSmtGb2c4M1FwankxR2NOamFESTVTQTExeTdlSnVHcU8rZXJsZlRqeCtTUmha?=
 =?big5?B?MXQwVHNSbjJmVDVDbmFzeVJzejhqRnNTWEVOWnVmd1pUUGdPQThwcE5LelNUcElP?=
 =?big5?B?Z3FkZTdDMkZxenM0cGJNaUJNZG80emZwT040d3pxYU1lZXlUZDd3OUE4RjlaYW80?=
 =?big5?B?LzYxcjZwVStWY0FjSzFxWnNUMmwxU2xxZmM3c2JVbWYvVlEzVnBEN0FMbjNOemti?=
 =?big5?B?aG4xMmw1SEhwOXNUbCtZOSswWER3MmRMWlE5dHVna0xtalhSY2VFZWFQdmR3RlRF?=
 =?big5?B?NzY5MHZ1ZWdBbVZVVE1vUXVEdE1jWHhuNWhna2lPSExPSGFkMkEwQ0FrdlB2Y1ND?=
 =?big5?B?bGhIQStpZlZTZFlvODJxTjVTamIycmRvd1hmMjJaYmZjYythOHBkSGN3RDhrMzNH?=
 =?big5?B?dGxzd25nVkZtV3p6RWFJYzB5b3hIQmRQaVBvVzdScWI2SFluU2RoYThzcnMzeTBY?=
 =?big5?B?UURyMHVPaFg0MTZhVHdJTE0zVzh5TnREdGZnd1NhQitTakE4dlA5R2JzN2RPQTJa?=
 =?big5?B?N045UHBLYWw0bkZkY0NyNE1aK1l0ZFVJc2dWUXJPS0p5K0ZNeVd6dExiZlQ2U3RI?=
 =?big5?B?Mm5uVEhyR0w0Qi8yNXd5eVhibVJSeEFjWWF5T01SS3h6Z0JmREROZjdrcnMrNHU5?=
 =?big5?B?eWNXZzZFM1ZFaDFEZEFJSTRMRld4OUpYaklYQXUvdWl3eGliaU8wSVd3b24xZUxn?=
 =?big5?B?ZlV1RU5JWllIeEl2R1dwZER0VkNTZHQwSlgyLzlmdnBDOFVYNlJYNGh3V3FSRlFp?=
 =?big5?B?clZaNEEzNHlISXFVNFlkNXNZMVdySnhhSFQ0QTdQNWdFMzhtVXZDTXdzclNzZHZx?=
 =?big5?B?QmMxd0xFZUlGemJHcmdBb1A1TUtzNlNiTmNXRXpXVExtT3lJZng2TWtnTE12NjVD?=
 =?big5?B?cnpDRFBtZklXVUxZRlpza3h2RG9iMG1adnJkZWVCZ1hMeml4aU1GYmdCcXFNMUhB?=
 =?big5?B?ZDdSL2dzNWV3WFNNZTI1OEJvYnNSRzhVU2JkQ21QTzRmaEl1TzZMRDdyYTV6V1Nh?=
 =?big5?B?TEYyalNwWmYvR3BhTmgvdE5PSjg5ekI0b055VTEyR3Q4emFoUUFiTmd4cWdITVBy?=
 =?big5?B?OHd4MEwxbE13Yjl6QXdzV1JBNEhLWS9jTi83clNveE8zSHNXTk9xblkyWkhFaEp6?=
 =?big5?B?QmFKVnJuSTVlTy84YzBWbFl0cGJSV0ZVSHh1VTdvSDduUUtEdUgyNHVTZTlOWmxm?=
 =?big5?B?S0NQZHJqamRnRjYrbjJVR0xPKzc2VEpTeWRkRy9MMDZwRTdCejlOcjFaQUVycVdI?=
 =?big5?B?SnV5d3RrTGE5aGh2VzhBMVZsUUhPQ2Q1Q2lvWC80ekd0WWh3UlNlK3BnWjBNNW84?=
 =?big5?B?WkVMS2FIaXVLRUx2RFVPNUVVd2VZTjVsQkNtSE9ad3FDOUlPRXJDbkR5bmJvampq?=
 =?big5?B?TDl2TXVBPT0=?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d038db-5c0a-4520-056d-08dbbcae2d72
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2023 03:27:27.5324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1380
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

U2ltb24gd3JvdGU6Cj4gWWVzLCB0aGlzIGlzIGEgJ2ZlYXR1cmUnIG9mIHN0YW5kYXJkIGJvb3Qs
IHdoaWNoIEkgaG9wZSB0byBmaXguCj4KPiBUaGUgb3JkZXIgeW91IHNwZWNpZnkgc2hvdWxkIGJl
IHRoZSBzYW1lIGFzIHRoZSBkZWZhdWx0IG9uZSwgc28gZG9lcwo+IGl0IHdvcmsgZm9yIHlvdSBp
ZiB5b3UganVzdCByZW1vdmUgdGhlIGJvb3RfdGFyZ2V0cyB2YXJpYWJsZT8KClRoYW5rIHlvdSBT
aW1vbi4KSSBhc2tlZCBteSBmcmllbmQgdG8gdGVzdCB3aXRob3V0IGJvb3RfdGFyZ2V0cyBhbmQg
aXQgYm9vdGVkIHdpdGhvdXQgaXNzdWVzLgpTbyBJIHNlbmQgYSBwYXRjaCB2MiB3aXRoIG5ldyBj
b21taXQgbG9nLgpQbGVhc2UgY2hlY2sgaXQuCgpUaGFuayB5b3UhClJlZ2FyZHMsCkRhdGUK
