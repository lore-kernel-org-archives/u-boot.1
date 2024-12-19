Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF7E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 08:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A498021D;
	Thu, 19 Dec 2024 09:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED488022B; Thu, 19 Dec 2024 09:28:39 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070e.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2408021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp0Bf+PltYh7GZONQwbxpFZpcvXT+GeA6QtdoV64cpkHygRNlsnQCj6le/aMzepL+bPHtELdrQWNSErY+yD8+AbmHvdhCzwWCbX3Q4ydOJRxC+0O/mjaRGhptLgj8DwlWBq5BgZK2xP4zNkoG5ISzN9g53oTZIivVZtksnV3CyrmkMG5SG55uc21mJn5/82G9R1LOL37eNb9bJr9AEYdOHB2IMnAejW5nYsabGnW9ZS75udaHsexVDGls1HFx0/WY0U2H/CU7Bg/kg28GSa8crwMdLn7K/nbUFzffBBdmGo0yaTczBmxhnu5SeT1o40G37OpJMFrTJqY/anqbNv5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74TXry9CwuUTfVgPkvl6UU2+HMbWdD9iwS1h7dVoL1s=;
 b=NJ+z8v0xW3OHclzagLE//nVxGDtMbKjw6aQWKUHoLWi5gj0a4ke5RIl3rCXzsztLKjvtAcA4lwl56eabMVT1Efi1NBDLPVUSCKp7Kd5mMTulJVii9U2op6EazxANYMR7xGRhBozFc7MwQUVgAEaIw2EWm1CS2nEmcPyxPEcUkg+nO6Y7hpypEDeyhqmhKGpw4nmp5XkLZmjkf26VQ2mMjFS2dAexDr7AWaaYrlNXDGXtBZ01Xyg180XhBOTNWGn4blp8m3Vs9B/CKnwoj4/jvTImy++qe+GFFBm3+VvAlvgRf5W61q4mkoFFIF6VYVsFwrYRBjQ9Rxz+UUu8VllgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0733.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 19 Dec
 2024 08:28:56 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.8272.005; Thu, 19 Dec 2024 08:28:56 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: E Shattow <e@freeshell.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjUgNC84XSB1c2I6IGNkbnM6IHN0YXJmaXZlOiBB?=
 =?utf-8?Q?dd_cdns_USB_driver?=
Thread-Topic: [PATCH v5 4/8] usb: cdns: starfive: Add cdns USB driver
Thread-Index: AQHbHFTAIPor7lZGHkOk4Y7uM2GlVbKCdpiAgGZrgoCABMTHkA==
Date: Thu, 19 Dec 2024 08:28:56 +0000
Message-ID: <SHXPR01MB086372ED1907B5F07B556666E606A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
 <20241012031328.4268-5-minda.chen@starfivetech.com>
 <31f013c0-fce7-4d9f-83a5-c7067119a994@denx.de>
 <e95e2ea7-580e-4d4a-8478-f340dcef426a@freeshell.de>
In-Reply-To: <e95e2ea7-580e-4d4a-8478-f340dcef426a@freeshell.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0733:EE_
x-ms-office365-filtering-correlation-id: 64d58c06-4b06-452e-0c00-08dd20072e10
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|7416014|366016|38070700018|921020; 
x-microsoft-antispam-message-info: Ga0ChL0bYg/l8Uhe4TEg14vQeO7SZiQZLk2zsFXmo2hidNMWDRvwaaLAQ2aeGDpFVav7y7LmE5kRT4Y7CmCe6a9DRwvX1SuRiWWEBWGcj04D1AIturvN4GpXQOVnT9PLgVnnporaleejp7eVO2Lp7bZbOCA/zdiGzqgVxhFvDhQjUwgW9VoalrhL+Sg2pNJPCrvP33v/lqMbjMWRpmw2+zig0d94/EiB0e/FxLiuBZ8UCEHXgJ7O6jA/6mWwjheCPkz3ZUpHY+GWG/tkj0N2s3VmOWySxAEt1+DHkhbP9A0jA+5+qNUGv4AF5t3+nEZ7WxNqx4ye0SRyTRfbqIYHzyQ3qKYhQHs+DMqnRcHI6Y0SpI6y4a9Iq3KYE7T6xasE16T+ctfp62+J4DmK2ELJf3o3XpQKsgwGuRKgORGa9w+KPBR8bfduA0WtKQq8OAP7K5Z/oZR/y7tmiyBNR4AM40m5hj6K51CaFBnaIzij5u3v78ETLD1p3N65ROU1oo9QndyW2c6k+Q5CEjoMuyyDBUTxmTFIP+n0oxkh/tuPum3jT/Al2M2SdkWTHihYAJJQnswfehro/QOzzkJx7nDm2S1m/qmG0he8/r1V9WHv4pc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(1800799024)(7416014)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjh5cDlIdHZKK2NaTGEyY002Q0RGaEhwVEhLQVhWUHlnVGpvSnVPRVMxdHJJ?=
 =?utf-8?B?MnRxVWszb2NQOU5NSG85eEN6WEl4NTZmdmQ2b0hoc3EwQ0thZ3M2Ykc1ZzBk?=
 =?utf-8?B?RXhZYTE1NGpZM2ZKZ05WQy95SzhLMk0za1VMSkpqNnVtZ1UxRkYzWVpJZ1lS?=
 =?utf-8?B?bzAvZVc5R1ZNWGsxR0RMZ3BYcUtJeUI2U3JScHJDZnYvNkEzNE1jZlovdUt6?=
 =?utf-8?B?bWV5bmZqNGlqdmtTVVNFcngyZlI4bmRDbHFwSWJTVGhadDh3Zkg0dGRmb2FP?=
 =?utf-8?B?SGt6bytXR2w0N0dWeVBXMUY5QnZYVU44aXRoOVJpeENoRW04VG1UbTRpNlFL?=
 =?utf-8?B?V1dtRU5pSHZacVMzamNVbmJGbG1JZmxDWTBRRDVXVWtSUFZKWlc2R1U2S3Jh?=
 =?utf-8?B?MWp3czBIeTFDaEV2RHg2OTNveDFqQVR0KzI2MWVBN1UreWJlMEhRSFI5NUJX?=
 =?utf-8?B?QTVaL3ozaSthZkttRVhSL1V5K2x0K3NMNkRFcTNYdmxzaGFyblNZU0t3d2Ft?=
 =?utf-8?B?d0pmVnlaMHZQNnZiWDZDN1FYZC9OTXBxUEtpNGdRZWJ5ZndNSkRyaWIzbTQv?=
 =?utf-8?B?ZlFsS2FYSVBISjZQQThUd2NpUWlQOVF4a3ZPMmRxSU11aWlXN0Myc1luQzJC?=
 =?utf-8?B?cVBYS2xCZndzSUthZzRPSjRESWRwcWJxQThzYXJRc2h4Q1VUK2R1NWVabHMv?=
 =?utf-8?B?RDd5TVgvRXRMdnB6Z2FwZlowcjVmeVpwTVBTSVQ3TE5Hd0tVSUVmMXQ1QTU2?=
 =?utf-8?B?SDUramswY0VqNVp1OHRhMnFFZTVMK0ZkVWxmQWI2ZjdIM01kUGRFQThrNzJ5?=
 =?utf-8?B?QTcrVlpIZ1FTOFNxT09HWFJ0YU8ycXdUNXhmTmpuUFR0NW1PN2U4UmNtalo4?=
 =?utf-8?B?M0gvb2RtN3BON2o3UHRMNVFRUm4vdlBVVXdpYS9lcjUrdG1UYXAreDMwcXNX?=
 =?utf-8?B?YnEwa1JRbmN2aXh0WURkSW9iL3R2TGdidUtwNVRDbGczRTROaFpHdHBGYW1r?=
 =?utf-8?B?SFBtbjZQNnRtWnhjMFF0Y21mRXU0T2hrNFBheko2K1BCZS9PMXZvL2FJM2hL?=
 =?utf-8?B?anNqVTE0ZUJnT1BEelpRazFBUkNqQVJSNjEzQ2RlYU1EYndNTzE2djZIV2tU?=
 =?utf-8?B?Yk84Y1RpVTVBNDZlT29mVThBTFhjaUl6NmtaMEpLTE4zMmxlVFFOTkJ3NFpE?=
 =?utf-8?B?VTdvS21keU1TckluVU1LbTZONGo4dmM5L3QrVTJ2VnVISE4rbGtTTUtMbVBp?=
 =?utf-8?B?LzYxeE8zUXEzbXJFRzFQVXFMekI1R2hacjBud0ZmVFNBMUdDSHlyV1B3bjdU?=
 =?utf-8?B?V09MUEJRUzNWNkZNS3d1OXA0ZlZZNzlYQ2txa3BVOUMvdTdidUNYbnA2aU8r?=
 =?utf-8?B?d0ppaWp1NTR1ZzJ3aVlpamNzOEtqQUNReERwbjczTUJaOTZ0Si9udjFoVW00?=
 =?utf-8?B?VnNaY2NUcWk0QWRKRlJTVHJsTzREVjZ3d1dpc1hBSE5wckRwYTBVZDNLWWZP?=
 =?utf-8?B?cFZEOEV4YzBZa3pEYmVFL3NVcHFPT0dRZm00NzlJMVY5Yi8vS2ZzY2JEcERh?=
 =?utf-8?B?eFE3NlVLMjFCSm5SQzlsazdOL29MdkNIempsVmVlaWc3RWhvN0N1SWpqeExK?=
 =?utf-8?B?WG5xcUlyQU5WTUtkS3BpQ0UzekYvZ3M1WDhydFAyY0prOUpacFNmc2ZkbWFp?=
 =?utf-8?B?TW9ja1hkN2tGS09EYUIwQW5EVmM1Uy9PSmI0NllXbzQyU20zc3d2RXAzMVd3?=
 =?utf-8?B?WGlaUUpWSWtCb3NUU1VqUE1kSmJGdExua1BIT2Q1MGFlT1ZPQWs5Q2RCTkp1?=
 =?utf-8?B?WEhXQWhDeE0weUVnYzVsbFVaSnJoT0JkMlAyUmpKbFpDV3VUZlQ5dnR6T0Jk?=
 =?utf-8?B?U1RhY0hNM0t1bEhUemYxUlBwdlNEbi9NdWtObkRCbzFTQnJwcjdIWEFnTGxU?=
 =?utf-8?B?cGlXQkNhQm1PdEtid25zRzZxa0tTZUtSUENxdFphejJtWFErOEZnUnFvOTdi?=
 =?utf-8?B?dE14Y21KRy9QY3RIbU5CVjZVdW1id3grTkhXY2JTOG5WM09kYVN0NlpiaTNo?=
 =?utf-8?B?dXNwbkNpcUxiT0xVT1phZXlsN3JMUjJhVS9aM0cwaVRPdzdYa2NQOHVGeTNO?=
 =?utf-8?B?VjJzWURoRHN3NEROWUM2UGh6MFBSQUg5TDJEMWJMSmdhQS8xdG1kOHMwalN5?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d58c06-4b06-452e-0c00-08dd20072e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 08:28:56.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIh4E4iPNlwBwO7uYyj3XtSbO+aGBYyZuTPUuwWMcfNT0HjSRQBDJ2fQBmLqrsM20jaMKczZsXE9fW9xcUqHX6NqMIEvSItjGAFnSTf407k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0733
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

DQoNCj4gDQo+IA0KPiANCj4gT24gMTAvMTEvMjQgMjA6MzQsIE1hcmVrIFZhc3V0IHdyb3RlOg0K
PiA+IE9uIDEwLzEyLzI0IDU6MTMgQU0sIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4+IEFkZCBjZG5z
IFVTQjMgd3JhcHBlciBkcml2ZXIuIEFuZCBjZG5zIGNvcmUgZHJpdmVyIGFsc28gZ2V0IGRyIG1v
ZGUNCj4gPj4gZnJvbSB3cmFwcGVyIGRldmNpZSBkdHMgbm9kZSB0byBtYWtlIGl0IGlzIHNhbWUg
d2l0aCBTdGFyZml2ZSBjZG5zDQo+ID4+IFVTQiBMaW51eCBrZXJuZWwgZHJpdmVyLCBwcmVwYXJp
bmcgZm9yIGVuYWJsZSBPRl9VUFNUUkVBTS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWlu
ZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+PiAtLS0NCj4gPj4gwqAg
ZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA3ICsrDQo+
ID4+IMKgIGRyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAy
ICsNCj4gPj4gwqAgZHJpdmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYyB8IDE4Mw0KPiA+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiDCoCBkcml2ZXJzL3VzYi9jZG5z
My9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsNCj4gPj4gwqAgNCBmaWxlcyBj
aGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygrKQ0KPiA+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYw0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcNCj4g
Pj4gaW5kZXggMzViNjE0OTdkOWMuLjZjOTU5NWMzYzQ5IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2
ZXJzL3VzYi9jZG5zMy9LY29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL0tjb25m
aWcNCj4gPj4gQEAgLTU1LDQgKzU1LDExIEBAIGNvbmZpZyBVU0JfQ0ROUzNfVEkNCj4gPj4gwqDC
oMKgwqDCoCBoZWxwDQo+ID4+IMKgwqDCoMKgwqDCoMKgIFNheSAnWScgaGVyZSBpZiB5b3UgYXJl
IGJ1aWxkaW5nIGZvciBUZXhhcyBJbnN0cnVtZW50cw0KPiA+PiDCoMKgwqDCoMKgwqDCoCBwbGF0
Zm9ybXMgdGhhdCBjb250YWluIENhZGVuY2UgVVNCMyBjb250cm9sbGVyIGNvcmUuIEUuZy46DQo+
IEo3MjFlLg0KPiA+PiArDQo+ID4+ICtjb25maWcgVVNCX0NETlMzX1NUQVJGSVZFDQo+ID4+ICvC
oMKgwqAgdHJpc3RhdGUgIkNhZGVuY2UgVVNCMyBzdXBwb3J0IG9uIFN0YXJmaXZlIHBsYXRmb3Jt
cyINCj4gPj4gK8KgwqDCoCBkZWZhdWx0IHkgaWYgU1RBUkZJVkVfSkg3MTEwDQo+ID4+ICvCoMKg
wqAgaGVscA0KPiA+PiArwqDCoMKgwqDCoCBTYXkgJ1knIGhlcmUgaWYgeW91IGFyZSBidWlsZGlu
ZyBmb3IgU3RhcmZpdmUgcGxhdGZvcm1zDQo+ID4+ICvCoMKgwqDCoMKgIHRoYXQgY29udGFpbiBD
YWRlbmNlIFVTQjMgY29udHJvbGxlciBjb3JlLiBFLmcuOiBKSDcxMTAuDQo+ID4+IMKgIGVuZGlm
DQo+ID4NCj4gPiBLZWVwIHRoZSBsaXN0IHNvcnRlZC4NCj4gPg0KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUgYi9kcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZQ0K
PiA+PiBpbmRleCAxOGQ3MTkwNzU1ZC4uMDNkMWVhZGIyZmYgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlDQo+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL01h
a2VmaWxlDQo+ID4+IEBAIC05LDMgKzksNSBAQCBjZG5zMy0kKENPTkZJR18kKFNQTF8pVVNCX0NE
TlMzX0dBREdFVCnCoMKgwqAgKz0NCj4gPj4gZ2FkZ2V0Lm8gZXAwLm8NCj4gPj4gwqAgY2RuczMt
JChDT05GSUdfJChTUExfKVVTQl9DRE5TM19IT1NUKcKgwqDCoCArPSBob3N0Lm8NCj4gPj4gwqAg
b2JqLSQoQ09ORklHX1VTQl9DRE5TM19USSnCoMKgwqDCoMKgwqDCoCArPSBjZG5zMy10aS5vDQo+
ID4+ICsNCj4gPj4gK29iai0kKENPTkZJR19VU0JfQ0ROUzNfU1RBUkZJVkUpwqDCoMKgICs9IGNk
bnMzLXN0YXJmaXZlLm8NCj4gPg0KPiA+IEtlZXAgdGhlIGxpc3Qgc29ydGVkLg0KPiA+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1zdGFyZml2ZS5jIGIvZHJpdmVy
cy91c2IvY2RuczMvDQo+ID4+IGNkbnMzLXN0YXJmaXZlLmMgbmV3IGZpbGUgbW9kZSAxMDA2NDQg
aW5kZXggMDAwMDAwMDAwMDAuLmZhZDA1NDUxYzgwDQo+ID4+IC0tLSAvZGV2L251bGwNCj4gPj4g
KysrIGIvZHJpdmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYw0KPiA+PiBAQCAtMCwwICsx
LDE4MyBAQA0KPiA+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPj4g
Ky8qDQo+ID4+ICsgKiBjZG5zMy1zdGFyZml2ZS5jIC0gU3RhckZpdmUgc3BlY2lmaWMgR2x1ZSBs
YXllciBmb3IgQ2FkZW5jZSBVU0INCj4gPj4gQ29udHJvbGxlcg0KPiA+PiArICoNCj4gPj4gKyAq
IENvcHlyaWdodCAoQykgMjAyNCBTdGFyRml2ZSBUZWNobm9sb2d5IENvLiwgTHRkLg0KPiA+PiAr
ICoNCj4gPj4gKyAqIEF1dGhvcjrCoMKgwqAgTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2
ZXRlY2guY29tPiAqLw0KPiA+PiArDQo+ID4+ICsjaW5jbHVkZSA8YXNtL2lvLmg+DQo+ID4+ICsj
aW5jbHVkZSA8Y2xrLmg+DQo+ID4+ICsjaW5jbHVkZSA8ZG0uaD4NCj4gPj4gKyNpbmNsdWRlIDxk
bS9kZXZpY2VfY29tcGF0Lmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4+
ICsjaW5jbHVkZSA8bGludXgvdXNiL290Zy5oPg0KPiA+PiArI2luY2x1ZGUgPHJlc2V0Lmg+DQo+
ID4+ICsjaW5jbHVkZSA8cmVnbWFwLmg+DQo+ID4+ICsjaW5jbHVkZSA8c3lzY29uLmg+DQo+ID4+
ICsjaW5jbHVkZSA8bWFsbG9jLmg+DQo+ID4+ICsNCj4gPj4gKyNpbmNsdWRlICJjb3JlLmgiDQo+
ID4+ICsNCj4gPj4gKyNkZWZpbmUgVVNCX1NUUkFQX0hPU1TCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEJJVCgxNykgI2RlZmluZQ0KPiBVU0JfU1RSQVBfREVWSUNFDQo+ID4+ICtCSVQoMTgpICNkZWZp
bmUgVVNCX1NUUkFQX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdFTk1BU0soMTgsIDE2KQ0K
PiA+PiArDQo+ID4+ICsjZGVmaW5lIFVTQl9TVVNQRU5ETV9IT1NUwqDCoMKgwqDCoMKgwqAgQklU
KDE5KSAjZGVmaW5lDQo+IFVTQl9TVVNQRU5ETV9NQVNLDQo+ID4+ICtCSVQoMTkpDQo+ID4+ICsN
Cj4gPj4gKyNkZWZpbmUgVVNCX01JU0NfQ0ZHX01BU0vCoMKgwqDCoMKgwqDCoCBHRU5NQVNLKDIz
LCAyMCkgI2RlZmluZQ0KPiA+PiArVVNCX1NVU1BFTkRNX0JZUFPCoMKgwqDCoMKgwqDCoCBCSVQo
MjApICNkZWZpbmUNCj4gVVNCX1BMTF9FTg0KPiA+PiArQklUKDIyKSAjZGVmaW5lIFVTQl9SRUZD
TEtfTU9ERcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDIzKQ0KPiA+PiArDQo+ID4+ICtzdHJ1
Y3QgY2Ruc19zdGFyZml2ZSB7DQo+ID4+ICvCoMKgwqAgc3RydWN0IHVkZXZpY2UgKmRldjsNCj4g
Pj4gK8KgwqDCoCBzdHJ1Y3QgcmVnbWFwICpzdGdfc3lzY29uOw0KPiA+PiArwqDCoMKgIHN0cnVj
dCByZXNldF9jdGxfYnVsayByZXNldHM7DQo+ID4+ICvCoMKgwqAgc3RydWN0IGNsa19idWxrIGNs
a3M7DQo+ID4+ICvCoMKgwqAgdTMyIHN0Z191c2JfbW9kZTsNCj4gPj4gK8KgwqDCoCBlbnVtIHVz
Yl9kcl9tb2RlIG1vZGU7DQo+ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCBjZG5z
X21vZGVfaW5pdChzdHJ1Y3QgY2Ruc19zdGFyZml2ZSAqZGF0YSwgZW51bQ0KPiA+PiB1c2JfZHJf
bW9kZSBtb2RlKQ0KPiA+PiArew0KPiA+PiArwqDCoMKgIHVuc2lnbmVkIGludCBzdHJhcCwgc3Vz
cGVuZG07DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCByZWdtYXBfdXBkYXRlX2JpdHMoZGF0YS0+c3Rn
X3N5c2NvbiwgZGF0YS0+c3RnX3VzYl9tb2RlLA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBVU0JfTUlTQ19DRkdfTUFTSywNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgVVNCX1NVU1BFTkRNX0JZUFMgfCBVU0JfUExMX0VOIHwNCj4gVVNCX1JFRkNMS19NT0RF
KTsNCj4gPj4gKw0KPiA+PiArwqDCoMKgIHN3aXRjaCAobW9kZSkgew0KPiA+PiArwqDCoMKgIGNh
c2UgVVNCX0RSX01PREVfSE9TVDoNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIHN0cmFwID0gVVNCX1NU
UkFQX0hPU1Q7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBzdXNwZW5kbSA9IFVTQl9TVVNQRU5ETV9I
T1NUOw0KPiA+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4+ICsNCj4gPg0KPiA+IERyb3Ag
dGhlIG5ld2xpbmUgcGxlYXNlLg0KPiA+DQo+ID4+ICvCoMKgwqAgY2FzZSBVU0JfRFJfTU9ERV9Q
RVJJUEhFUkFMOg0KPiA+PiArwqDCoMKgwqDCoMKgwqAgc3RyYXAgPSBVU0JfU1RSQVBfREVWSUNF
Ow0KPiA+PiArwqDCoMKgwqDCoMKgwqAgc3VzcGVuZG0gPSAwOw0KPiA+PiArwqDCoMKgwqDCoMKg
wqAgYnJlYWs7DQo+ID4+ICvCoMKgwqAgZGVmYXVsdDoNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybjsNCj4gPj4gK8KgwqDCoCB9DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCByZWdtYXBfdXBkYXRl
X2JpdHMoZGF0YS0+c3RnX3N5c2NvbiwgZGF0YS0+c3RnX3VzYl9tb2RlLA0KPiA+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBVU0JfU1VTUEVORE1fTUFTSyB8IFVTQl9TVFJBUF9NQVNL
LA0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJhcCB8IHN1c3BlbmRtKTsN
Cj4gPj4gK30NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2NkbnMzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPiA+PiBpbmRleCBj
YmUwNmE5ZTdiNi4uOWQwYTU2ZmQwZTcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2Nk
bnMzL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4gPj4gQEAg
LTQxMCw2ICs0MTAsOSBAQCBpbnQgY2RuczNfYmluZChzdHJ1Y3QgdWRldmljZSAqcGFyZW50KQ0K
PiA+PiDCoMKgwqDCoMKgIG5hbWUgPSBvZm5vZGVfZ2V0X25hbWUobm9kZSk7DQo+ID4+IMKgwqDC
oMKgwqAgZHJfbW9kZSA9IHVzYl9nZXRfZHJfbW9kZShub2RlKTsNCj4gPj4gK8KgwqDCoCBpZiAo
ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9VTktOT1dOKQ0KPiA+PiArwqDCoMKgwqDCoMKgwqAgZHJf
bW9kZSA9IHVzYl9nZXRfZHJfbW9kZShkZXZfb2Zub2RlKHBhcmVudCkpOw0KPiA+IFNlcGFyYXRl
IHBhdGNoIGZvciBjb3JlIGNoYW5nZXMgcGxlYXNlLg0KPiANCj4gSGksIE1pbmRhLCBjYW4geW91
IHNlbmQgdjYgd2l0aCByZXF1ZXN0ZWQgY2hhbmdlcyBieSBNYXJlayBhbmQgZHJvcCBwYXRjaA0K
PiA3LzggKCJkdHM6IHN0YXJmaXZlOiBBZGQgSkg3MTEwIENhZGVuY2UgVVNCIGR0cyBub2RlIik/
IFRoYW5rcyEgLUUNCg0KSSBhbSBidXN5IHdvcmtpbmcgd2l0aCBhbm90aGVyIElDLiBOZXh0IG1v
bnRoIEkgd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24uDQo=
