Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C25CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC7D83A15;
	Mon,  1 Sep 2025 15:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C168399C; Mon,  1 Sep 2025 10:01:47 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146EF831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 10:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muCs/J+jybzawCVja8w4kdO0WGNtZgbATtz8C8UNgsnGpslYmTPvZUkWl7vDTyPhQqkraHawdixJJt8MaqJSpKbR/HKwj+GMr5p1O8m81Ic9SCLkXnLeQzzAIt1TzM5LvRYmKoiaf163dbAKbbLHR8tN9Ev1wQ07AIcRkJHmKVgJ44lvYVqV0W9KlN5WNJIqJC+RbYAZSzTA1jhY4t9EvdsNkWSN4IkhDfQlAbkuePceeqqNIx0OBq6X21XS01EkdGgAdUZTIdEqtFHmw3+bAOi0wCS3zfD4+4yzoZ/UT3w7tfgWxMGR/GyKlzXFZqbFWgfVIjI7A/hKsr3JMAj/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOFKrLbV9nHVly8kXWxTpwhlgNq5Lb4Q2LHXCjBGip0=;
 b=WdPyEvsuWu/9RK1TgvBVsTpM7cK5sGPdtdGPwKcqgQDNnF/mszjDplPoqJgaRiYBUFQUYOU1xPya19E1G54CRGgMojycvAd+WcFOrNgKyEdJPhp98ajEXaJi4L2NyBTzTS17rA3VojXpvdeOdvCk0T4ySzZbXtFUKJ7Av+I1ALCFyx6uTnJcnsxjeXcSOi22qnaUIsSsabE4EP+SaZgh4d+M/gwePrruW5p+37m7wh5JzJ6aEl9LzF+5MUoWO4AjRxfYGwIjabzNpuKCLLS4kV4TYQJWQ2P5UggmXryLONBFxPfmQ7D0u005G854wB5CovQl6mPFHjhfzH/4TkMMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 1 Sep
 2025 08:01:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 08:01:38 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] pcie: starfive: Fix the incorrect use of dev_err()
Thread-Topic: [PATCH v1] pcie: starfive: Fix the incorrect use of dev_err()
Thread-Index: AQHcFwB6OOZWvoYkiE+GaJoIQ/M1O7R231cAgAcevFA=
Date: Mon, 1 Sep 2025 08:01:38 +0000
Message-ID: <ZQ2PR01MB130724A9C59541E593B10C30E6072@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250827031156.109432-1-hal.feng@starfivetech.com>
 <CAOMZO5C4bMcHWo576rFdJXtwXD_Ars7cQob_KS+3Xxof5-EMLg@mail.gmail.com>
In-Reply-To: <CAOMZO5C4bMcHWo576rFdJXtwXD_Ars7cQob_KS+3Xxof5-EMLg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
x-ms-office365-filtering-correlation-id: 138ce03c-5e7b-426e-15e4-08dde92dc78c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: U5v29jdxROh9IdFwmd2bLqqp5cKPcFozFQ78XV+hKT8hdezJqX3pm0h6ImNuqwfjDZA6X67be7EqSjZ0oQICKSRQmOs3+VNGFc3EoVsj8EtDAwsJQc/T8CPd+hOUIrI852bMut9vc+zhe+1nDdattYrZ1dLnneqd6y+1aW4BV/JohwdLexOwV1uvuHTphYtzsvCK13u6Zyk6O5U7XW/d0qGEadrBsayKGbk71VhooACEZi0Z+Ei1THgOlq51gadRCceWbrYui7aaT/rxuOEBGjWS389KZEHp91xHImbJvvL1BiMSFMbrr/Ls0jdCJZp0RNmGlytfkLbtFOPiBits1EXTU2f/t0YOl+nPfd38gtZOGRLQ8mkhrK+sh2MvOWipBjZ+Mzp37aqvPL10PMIjnYrjyGtaygMmqsIH24HT6VYfunSgzST1XBHvT7R03C9K4lqJryoe9wa5iMzcGOz9WDKvKf1PwnUMz8STsQ/RNQ34Fp2ulfIHXkjlb35kdTKrlo6tJlXORwdB5M4AjNSPxDg5/0x2NBxRmIgHY+1Jeuxbn24ouyUC5YVueOG1EtwsXHtfwTyL7fZ9cxcGcvwBV+qSu5/BQFUbkeoxDkGW3vk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBDMWRLQkJ0bEFOUVkrTEI5djU2WHlOT1RMY1RidHJMMGpzTDIzNDRVOHFK?=
 =?utf-8?B?UXh0Zk1ML1ZZUVFYZCt0N1F2dUhJVGJ4SnJSWGVQWTkvVXZjYStweGhhREUy?=
 =?utf-8?B?eDZKbHFQZjJjTVdPMVMxaXMyT2NKTE9QWFpFdHdMTkR1VDkwVXJRbURJVG0r?=
 =?utf-8?B?NTFISjRiWjlFZklUMmtkZzNMR0VoaFBOUWxUMkw2KzFOZDNvVlU2OFNVaWRX?=
 =?utf-8?B?cmlNWUdsaFJrSWhtd1c4MHdHWTVGWU5lc25EWkF5RGVVM1YzZUlOVm4zUWIz?=
 =?utf-8?B?Z2RWY1ZnNWNqcVBQdUdqNWRCem0xYVBNaFU1d0lSNE5xdnQ1MEpWQjBiRFJR?=
 =?utf-8?B?MG84V2lDTHNWQzY0dzZlUGtBMG1KU29pbm0zOWJWV0ZaZVh4eDNFQVk3bEdZ?=
 =?utf-8?B?cGpoaUlBV2F4MXVNSjA2RWozOWhRazlqeUhFTWZ1S2lLa2N2NWw4dUd2WmdQ?=
 =?utf-8?B?Z3pRY3dxd1BGczJaQW5ScThaN3lvYkZGUkJ5cG16TGl3NnhJclMxTVNjYlQ5?=
 =?utf-8?B?N3RvSFEzT0Zib20vR1FwemxxazJwcTYyVE8yYllIVllVNDBpWExlS1d3YlVx?=
 =?utf-8?B?VGtkN3psNGFVZzk4NjdvMWFsQVhycXcvNE02QzEyb2p5MlJKSTlmUUJaRCsv?=
 =?utf-8?B?NVFIUU16cFJlbys2bDc1ai9MczFlL1lHdjNQYjBKYm5BQkFKQllPUXVCd2pE?=
 =?utf-8?B?cTFRcEFxOHpBMFo3MTF0aVZBTy9NWC9PYVVXaDRHcXUvSE1DdXN5Qks1VGdl?=
 =?utf-8?B?OE0vK2lNYzVSVkJwT0xKYW9udnA5RVYzM1VNdWkyZGkzY1UrM2E2Nko0K0xi?=
 =?utf-8?B?K3QrUVNIMXhTZ0pBeE1ZcEp4SUV2bmlFZ2V0b3dJcXFRYUI2K05lRVFrQ2ZB?=
 =?utf-8?B?MGV2eGNLWTVpMXFBdUtiUHovTmlKVFkxaGxpZWtmY2pZUm0wclhtc0lNejZT?=
 =?utf-8?B?c2xQdWowVHhhMWlYbVRCNDZWd3RTYVRRbFdlSWUyWWJFVkNrdzJneGluS1Vk?=
 =?utf-8?B?U0xBaXVxWjZLenR2NFlyU0VwRHJKdG1NYmh6c0t6SEsrMzBJS3g0OUVpRjVQ?=
 =?utf-8?B?cVZIcDU5ZGZqSlpCZkVRRGwxTjArOERiU0d4L0F6Vm1NQ0JZRHhmTWlnSW5q?=
 =?utf-8?B?Y083M2tVeVU0em9ORlcrK2R3bE5EMUl3bXRlU1E2azRnZDdsY20yZVBjZE9L?=
 =?utf-8?B?R1pSZ2QrdmVoakZ6QnR5elcvMWZBRmFIWTZBbTZsTGlnL08xNnE3dTNCa2Q3?=
 =?utf-8?B?WEIzdEFZcDk3cnEwbjUxYjRMRzdHdzA0SXNQeEhjTTFndkwxanRJWGlMdlRa?=
 =?utf-8?B?VVZGUFRGcml2QTNXWC95M2p2V2tBQ3JNd0Z2UlhTZFFtT1loZWZ5eHVjWTI4?=
 =?utf-8?B?UTZkdTdBNXJsN2xlK0I2SHlqSmdzcmJWWXFlbGRXUjQvUlA3L21sazNiNXhZ?=
 =?utf-8?B?TEkzTzR4MmI4Rnd0d1ZQY0dnYmp3NGU5bEFYd1BTalJWT0ZiWk51ZlZKdWM0?=
 =?utf-8?B?UXZxcUZRUEt4TFFhVkFzR0t0OHdETXNSdnVja1JiRmFsTE1TbXppUmxvaFRk?=
 =?utf-8?B?aUQ4VThSUktacWVhYVJ2QkJwTXFGV3psRDUydEhqNlNFUTMwM0toOTVqZU4x?=
 =?utf-8?B?S0tnclMwZlBDRjhQb25oOHEwWjZpeEhJR3NkT3RIZmoyMFIvemhUOFBsSmtx?=
 =?utf-8?B?M0F5bWdjZ2VxUE5zVXVvZXhrZzdOVStuWmdZRGIydUVpWlZFRnErVkFLSVhM?=
 =?utf-8?B?aEFFTmZmUUFwM0ZoK0hFeC9acUhxaVB3Z1Uxd3llQnF4eWlDYWV5VFhPY2Ux?=
 =?utf-8?B?Qi8zT2UvcldibGRHUCs2cVZNMEZwQVNzWEFEbzZ4dkFtOUZQMGFEb2diU3FB?=
 =?utf-8?B?b3M5MU44R1JJeWFGMUFXRmlVVXZ3dW84ZXJzMW41eE0xNGIvOW4zK3BhTmFN?=
 =?utf-8?B?TVQremtzK3hBMjFBRThtWkRkdjBXQVBFOFNvTHV5QVFZY05SZzZNK1FUdmR2?=
 =?utf-8?B?cFF6QnBYNktqR0tTMXgxVU9ibGhyZUNHbEJueHZSNUpRb3U5bFhKdFJlWkcr?=
 =?utf-8?B?MlFPNm1FS01vNTBCWVdMakhxbU9CSVR2OU82YlBtQnVwVXZiTGk3djdLWmVI?=
 =?utf-8?Q?mLQxzKa9bcctCtu2y/XyNVIuy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 138ce03c-5e7b-426e-15e4-08dde92dc78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:01:38.6706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Rj4/aRb6CHhryeAXa80GbxM77tmJTZEMm1xX/Hc5Phjil5xvVBfHJQH1XXhGx+bxY9NrgEyS/0F0RU+8EWi8WYu50YvBSyPY+LnRHIFLrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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

PiBPbiAyOC4wOC4yNSAwMzoxNCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gT24gV2VkLCBBdWcg
MjcsIDIwMjUgYXQgMTE6MjbigK9BTSBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNv
bT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBVc2UgZGV2X2luZm8oKSBpbnN0ZWFkIG9mIGRldl9lcnIo
KSB3aGVuIGZpbmlzaGluZyB0aGUgcHJvYmUgZnVuY3Rpb24uDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9wY2kvcGNpZV9zdGFyZml2ZV9qaDcxMTAuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvcGNpZV9zdGFyZml2ZV9qaDcxMTAuYw0KPiBiL2RyaXZlcnMvcGNpL3Bj
aWVfc3RhcmZpdmVfamg3MTEwLmMNCj4gPiBpbmRleCA1MWFjYTczNTlmZi4uZjIyNTYzMDdhYjMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpZV9zdGFyZml2ZV9qaDcxMTAuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWVfc3RhcmZpdmVfamg3MTEwLmMNCj4gPiBAQCAtMjkyLDcg
KzI5Miw3IEBAIHN0YXRpYyBpbnQgc3RhcmZpdmVfcGNpZV9wcm9iZShzdHJ1Y3QgdWRldmljZSAq
ZGV2KQ0KPiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gPg0KPiA+IC0gICAgICAgZGV2X2VycihkZXYsICJTdGFyZml2ZSBQQ0llIGJ1cyBwcm9i
ZWQuXG4iKTsNCj4gPiArICAgICAgIGRldl9pbmZvKGRldiwgIlN0YXJGaXZlIFBDSWUgYnVzIHBy
b2JlZFxuIik7DQo+IA0KPiBPciBtYXliZSByZW1vdmUgdGhpcyBsaW5lLg0KPiANCj4gV2UgZG9u
J3QgbmVlZCBkcml2ZXJzIHN0YXRpbmcgdGhhdCB0aGV5IHByb2JlZCBzdWNjZXNzZnVsbHkuDQo+
IA0KPiBQcm9iZSBlcnJvcnMgYXJlIGhlbHBmdWwgdG8gcHJpbnQ7IHByb2JlIHN1Y2Nlc3MgaXMg
bm90Lg0KDQpBZ3JlZSB3aXRoIHlvdS4gTGV0J3MgcmVtb3ZlIHRoaXMgbGluZS4gVGhhbmtzLg0K
DQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg==
