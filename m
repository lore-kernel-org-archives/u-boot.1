Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18035C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 20:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB5A8778F;
	Fri, 10 Nov 2023 21:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="jh2wtGuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5693887545; Fri, 10 Nov 2023 21:24:18 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1228778F
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 21:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1699647855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gccWwYr2vaFD70kAukUcRDbTtUExL/yXud5UbDVKCTM=;
 b=jh2wtGuMEQeTvpTp9mBE17xFJkkom2bsdIisF4ae/NNbZZAuomhDY8eYWstawhqZvvYKP2
 zubK5dU5K79ycNBoJGIP4AhNurFCNIYVY5Dzt+eT0jWHROSgUstyXhpwzeWBvBzz65bggy
 iCl4waLY7qK+ynG2oHyElOTXURNWHFw=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-45-1tXxsXnnPUqVcD6ue-JA8g-1; Fri, 10 Nov 2023 21:24:14 +0100
X-MC-Unique: 1tXxsXnnPUqVcD6ue-JA8g-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0792.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Fri, 10 Nov 2023 20:24:10 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d172:8199:e9cd:858f]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d172:8199:e9cd:858f%3]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 20:24:10 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "macpaul.lin@mediatek.com"
 <macpaul.lin@mediatek.com>, "marex@denx.de" <marex@denx.de>,
 "fparent@baylibre.com" <fparent@baylibre.com>, "aouledameur@baylibre.com"
 <aouledameur@baylibre.com>, "trini@konsulko.com" <trini@konsulko.com>
CC: "bear.wang@mediatek.com" <bear.wang@mediatek.com>, "sam.shih@mediatek.com"
 <sam.shih@mediatek.com>, "chunfeng.yun@mediatek.com"
 <chunfeng.yun@mediatek.com>, "Ryder.Lee@mediatek.com"
 <Ryder.Lee@mediatek.com>, "macpaul@gmail.com" <macpaul@gmail.com>,
 "weijie.gao@mediatek.com" <weijie.gao@mediatek.com>, "pablo.sun@mediatek.com"
 <pablo.sun@mediatek.com>, "GSS_MTK_Uboot_upstream@mediatek.com"
 <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH v5 1/2] arm: mediatek: add mt8195 SOC support
Thread-Topic: [PATCH v5 1/2] arm: mediatek: add mt8195 SOC support
Thread-Index: AQHaFBPc082aZX+r/UmEwBz8BOrr8w==
Date: Fri, 10 Nov 2023 20:24:09 +0000
Message-ID: <78245d2791000a64ca123db0ca4c063f2e1928d7.camel@toradex.com>
References: <20230804110448.24589-1-macpaul.lin@mediatek.com>
In-Reply-To: <20230804110448.24589-1-macpaul.lin@mediatek.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0792:EE_
x-ms-office365-filtering-correlation-id: b292f2b2-7b8a-4c9f-70ba-08dbe22aff1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: MXV8Ju0/Ntu6b22jJsb4ce6vOV+pNYbkuMQTD5x9zomxYfmIIV53elUS774AO1unatkO5tDW1zIENuWC4rqTUan+3crApaRAvMvDfWkJEsrm8NQo4ntg76ztlLcB8AxKgTvQKsvkrPTejtxFz64AgmMBxfK8qK4mjOSaZJlAv2skM4gjchrFQWyNyQYPdQn7zARSsSn6EW4WlKBHJ4chLuqnWNaCosMF2wGbLVItMDULz4yCKtgsZspLT6gFT87F95mP23EedvlR627UqVMp802L4Nz/S4wDHrNpej3vLLTRCOXQYTJuJiZDqUIGFXr2yDlzpny9m06fDi1qF6itKlLYiezRiGZJ9UumLTe66t2xSnLeByeds2BX5Eh0UCExSZo1p0t8O0xP365a2aPPDtHhNX0HOyChoNfcfLsgjKEKYc5JMHAcs7ha8OoEyr24W0X/NgRgSaUuM1gyG9lUcuJ3AQfyzLl2xbUj1wYIupFKyGC6rOwQ+Xl74nEjeAiICI2sTPEbkAiL0qGnwvEERkfbQF38aZs+OwDQgB+edvE0O+cAYs3pL2hQupSgtTUboP7DGcvcm7GHPBRsYjPCM8WrYHPmb92RXDRUojpxCqwNlh4UPXK+ql+UQH7JEu7n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39840400004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66556008)(5660300002)(7416002)(2906002)(76116006)(71200400001)(66476007)(54906003)(64756008)(66446008)(316002)(110136005)(86362001)(6512007)(38100700002)(66946007)(122000001)(83380400001)(478600001)(6506007)(6486002)(2616005)(8676002)(41300700001)(38070700009)(44832011)(36756003)(8936002)(4326008);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWw1b29qRDNCWGlIQXRzQlliTUl0aWZ6OEZKanFoVU5Ebnpzc09DQ0thYklp?=
 =?utf-8?B?S1VZTFc5YUtxajZZN2xOQmFWcnBTV2NQTDFHK2w4SFlIQ2hVeVhSWDk4ejY5?=
 =?utf-8?B?Vzk4b2kwRnJtL3Boc1FoaDlhVjRYNUZhbVZPZzVXbzFsVWVYQmFqMWczWE5v?=
 =?utf-8?B?Szl5UGFCMGh4bFlhcWh5ODRJNUFURk5PRGVPUng3RzhxZjdtY05JTkc4b1cw?=
 =?utf-8?B?TG5jQUFTZVM1dDFyaUw4YW9MRmtiejZiMVltWi9YaDRRRzdZL1NlZDR3eGVN?=
 =?utf-8?B?MlZBNDJVUDRjUVNvd2hxTVFobzFpSFJtYlM0UE1kcmdJMEFIVUw5Y0tmQkpp?=
 =?utf-8?B?ZlpMeTlRWGVuM1RMWVlPa1AycHN0YXdYRXBXZWpRdHRJZ1NNVzJRaHhHdmYy?=
 =?utf-8?B?ZTBUdS9WN1JTb0cvNUc3ZXhQR1VaWjJDSi91UVhHbGRqOE11am9TKytyWHMv?=
 =?utf-8?B?YWRrd1Jlc0NZck9Pd2FibFdpNVNGQnBPS1VZeFJSSzR6dW5mMXFnVk5JRndt?=
 =?utf-8?B?ZkJzVVJIclhIS0MzanV1ME5maTIrN1h6OGJweFp2VDYya1NyQ01VSktvVWo3?=
 =?utf-8?B?dGFZdCtoTlZudzRyWUpYTUZCT2twMlRuU1NHQjdZRWg4MmZlaE1POGc2NG8x?=
 =?utf-8?B?bkVFY1h4WU1JeU9GYS9tM0xQVXJGb0RKZ21NemNEYjg2dWk3blphbHp5L1R2?=
 =?utf-8?B?SVo1TlR1WkZWek5sRHVnWTFkN29scXBZMERzbHVnUW9wK0Fqa2svZDFvY1k0?=
 =?utf-8?B?N25CYisyNDNmb2tOLzZWb3gyZXVzUTNPWXRsSWNQeldpeGJES21MSGJUQ2tF?=
 =?utf-8?B?MytBSlVuZlMyaUpveXpCVjQyUXVjaDBFOFh2eDZKdkN3aFhEbXEvN3M0UFB3?=
 =?utf-8?B?VU9GTUxTSExiNXZ5cmM5b29KY3UyaW1EQ1JhOGFNRVpCTTFndTg0RzRUcE80?=
 =?utf-8?B?OEJUOEhuN2I5bEk3V2hXS2lIUi92QzY5eXkyV0I5NjkyMXY4TWRuMStncklt?=
 =?utf-8?B?SlJ4YThwSkdrQzduY1lXWVROOGQxTzZXRTU3YTc5UDZxaDM3Z0poOEJ2UTB0?=
 =?utf-8?B?K0pLd3hpclkvUVpiRHBzVTZ5ZkFCbFU2T2dpWVRjOFNWL2dHQ0t5aE5MdFB5?=
 =?utf-8?B?b2lMaXc2ZzFNT2U1YmhmNjJNV0M5OTRYVmUyOEhZaGJ6QkgwUmZBMkY5QjY4?=
 =?utf-8?B?a0hld2s3UGw2TWNrUFp1WDczUjFkSEMyeUNkZXZodmhia2FRbUY3dTVadlpv?=
 =?utf-8?B?ZTBwZ0xHZzBxR2U0dGJRRVBhTHRpNlkxVzltTElVd21zbXpWYzJqYmV6YXF5?=
 =?utf-8?B?eXI1NFpVTEVuL201TXZKZVRHdm9IMWZKbHN2WWZtOUlJUVpjYUozMzU0WUp2?=
 =?utf-8?B?MEV5MUJxUFE1dDc4Tyt0T0szQW5oM1hMdUNlUnRQRnlPRlBGRW5hY2dwMHJ0?=
 =?utf-8?B?Z1kwRVpOZnl3aHZIVXh4UENyLzkzS1ZLcERuRGhZWERJYURkaDJiK0kyQS81?=
 =?utf-8?B?YWN5NjZFSitrajRsZW9MbWk1MHozTmlPRDZFR2Q0SytMZ0FMTFdmZUpnVzZR?=
 =?utf-8?B?a3Rxa3Z3UUZkcGZYZGQrMXRNcWVOV2V1WC9aempLNHVibklyRkhsWVNVc0pj?=
 =?utf-8?B?b2VWV0ZNQXI2Rnpmd3ZmUTNuTmQrRHRHVlR6WWN2dXF4ZG1memwxVnhJQkFh?=
 =?utf-8?B?MUtQTzJWUmFsMk1iSlF3d2pzckZMRHEzNkVRSm9OYjhYVE1HYks0bklBcmR1?=
 =?utf-8?B?QU9jUGJPQ0JDeFF0Y3pLaGhnT04yTGZtU2RGVnNmeWxTZEhMNk4wMlVBd1Az?=
 =?utf-8?B?d2JJTmJVSTVnTm1oek8vdEdSR2hSZmxHdWgzWjlmWnV3MzBEdUI5Zzl4Tmo1?=
 =?utf-8?B?RjZjMVZMS1RINmszM0UxM3Jwb2JGTkFKWEFDaTVLVDV6VTA5RC9Pb2psQld1?=
 =?utf-8?B?QzR0ODB0R3JQL3IyYWJpNEZRMmFBKzNlRExTd1hZaWNXNlUrVndGTUU0YWlS?=
 =?utf-8?B?dUIrRzNrcENnNjArQ1lsMzI5YjlFT3F1UGdLRmVJajQyVWVxcS83b3VTdDFq?=
 =?utf-8?B?VEhHNkJVZTRqaUNnc2JSdnV6RElpWUY3T3lZeWFrdXpjUXErZ1A3aEl2UU0z?=
 =?utf-8?B?eTQxdzZuVkY2bVlJNG9nMTBkNTFNRjFnZFNWOURRa2l5UXRoUCtWcitnNFlF?=
 =?utf-8?B?OEhHQjFIQmxhUk9xWWZhNjN5WFkxVWdmbkwzakVIR2dsRmU4eHErakdrK2o5?=
 =?utf-8?B?dEJZc1NyeXZ4Y2xGaVFlaDdCb09nPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b292f2b2-7b8a-4c9f-70ba-08dbe22aff1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 20:24:09.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzwKLPKkAzJynL6EU+J69oXxmhwaPSX2Hfzj24oT5Y6oVZ5ato7NuzcWNIJfaHPhGY9a3Ah27WA2S7SlYpkVTW46js+xD6iPvifjp63HpAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0792
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E9944E96B6C2C846A2926377406B0296@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgZ3V5cw0KDQpPbiBGcmksIDIwMjMtMDgtMDQgYXQgMTk6MDQgKzA4MDAsIE1hY3BhdWwgTGlu
IHdyb3RlOg0KPiBGcm9tOiBGYWJpZW4gUGFyZW50IDxmcGFyZW50QGJheWxpYnJlLmNvbT4NCj4g
DQo+IFRoZSBNZWRpYVRlayBNVDgxOTUgaXMgYSBBUk02NC1iYXNlZCBTb0Mgd2l0aCBhIHF1YWQt
Y29yZSBDb3J0ZXgtQTczIGFuZA0KPiBhIHF1YWQtY29yZSBDb3J0ZXgtQTUzLiBJdCBpcyBpbmNs
dWRpbmcgVUFSVCwgU1BJLCBVU0IzLjAgZGV2aWNlIGFuZCBob3N0cywNCj4gU0QgYW5kIE1NQyBj
YXJkcywgVUZTLCBQV00sIEkyQywgSTJTLCBTL1BESUYsIGFuZCBzZXZlcmFsIExQRERSMw0KPiBh
bmQgTFBERFI0IG9wdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4gUGFyZW50IDxm
cGFyZW50QGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3Bh
dWwubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArDQo+IMKg
YXJjaC9hcm0vZHRzL210ODE5NS5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM3
MCArKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTMgKy0NCj4gwqBhcmNoL2FybS9tYWNoLW1lZGlh
dGVrL01ha2VmaWxlwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgYXJjaC9hcm0vbWFjaC1t
ZWRpYXRlay9tdDgxOTUvS2NvbmZpZ8KgIHzCoCAxMyArDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRp
YXRlay9tdDgxOTUvTWFrZWZpbGUgfMKgwqAgMyArDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRl
ay9tdDgxOTUvaW5pdC5jwqDCoCB8wqAgOTcgKysrKysrKw0KPiDCoDcgZmlsZXMgY2hhbmdlZCwg
NDk4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm0vZHRzL210ODE5NS5kdHNpDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L21hY2gtbWVkaWF0ZWsvbXQ4MTk1L0tjb25maWcNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxOTUvTWFrZWZpbGUNCj4gwqBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxOTUvaW5pdC5jDQo+IA0KPiBDaGFuZ2VzIGZv
ciB2MjoNCj4gwqAtIENvcnJlY3Qgbm9kZSBuYW1lIHRvIHQtcGh5IGZvciB1M3BoeTAuDQo+IMKg
LSBBZGQgcGxhdGZvcm0gY29tcGF0aWJsZSBzdHJpbmcgIm1lZGlhdGVrLG10ODE5NS10cGh5IiB0
byBhbGwgdXNiIHBoeSBub2Rlcy4NCj4gwqAtIHJlbW92ZSBjbG9jayBub2RlcyB0aGF0IHNvZnR3
YXJlIGNhbm5vdCBjb250cm9sbGVkIGluIHBoeSBub2Rlcy4NCj4gwqAtIFRlc3QgYW5kIGFkZCBi
YWNrICJtYWMiIGZvciBIT1NUIG9ubHkgeGhjaSBub2Rlcy4NCj4gDQo+IENoYW5nZXMgZm9yIHYz
Og0KPiDCoC0gUmV2aXNlIGRldmljZSBub2RlIG5hbWUgZnJvbSAieGhjaVg6IHhoY2lYQCIgdG8g
InhoY2lYOiB4aGNpQCIuDQo+IA0KPiBDaGFuZ2VzIGZvciB2NDoNCj4gwqAtIE5vIGNoYW5nZS4N
Cj4gDQo+IENoYW5nZXMgZm9yIHY1Og0KPiDCoC0gRml4IENvcHlyaWdodCB5ZWFyIHRvIDIwMjMu
DQo+IMKgLSBGaXggbWVtb3J5IG1hcCBpbiBkcmFtX2luaXQoKSB0byBzdXBwb3J0IDhHQiBvbmJv
YXJkIG1lbW9yeS4NCj4gwqAtIEFkZCAnI2lmICFJU19FTkFCTEVEKENPTkZJR19TWVNSRVNFVCkn
IHdpdGggcmVzZXRfY3B1KCkuDQo+IMKgLSBDb3JyZWN0IHJlc2V0X2NwdSgpIGZ1bmN0aW9uIHBy
b3RvdHlwZS4NCj4gwqAtIHJlYmFzZSBwYXRjaHNldCB0byB2MjAyMy0xMC5yYzENCj4gwqAtIEFk
ZCBtaXNzaW5nIGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTk1L0tjb25maWcuDQoNCltzbmlw
XQ0KDQpJIGZpbmFsbHkgZ290IG15IGhhbmRzIG9uIGFuIEVWSyBhbmQgZ2F2ZSB0aGlzIGEgdHJ5
LiBIb3dldmVyLCBJIGRpZCBub3QgZ2V0IHRoYXQgZmFyLiBUaGlzIGlzIHdpdGggbGF0ZXN0DQpk
b3duc3RyZWFtIFRGLUEgYXMgSSBzdGlsbCBzdHJ1Z2dsZSB3aXRoIHVwc3RyZWFtIHRoZXJlIGFz
IHdlbGwuIEFueSBpZGVhcz8NCg0KVS1Cb290IDIwMjQuMDEtcmMxLTAwMDU2LWc1MjM3ZjJiNDhi
YiAoTm92IDEwIDIwMjMgLSAxNTozMzozNCArMDEwMCkNCg0KQ1BVOiAgIE1lZGlhVGVrIE1UODE5
NQ0KRFJBTTogIDggR2lCDQptdHUzIHVzYkAxMTIwMDAwMDogY2xrcyBvZiBzdHMxIGFyZSBub3Qg
c3RhYmxlIQ0KbXR1My1wZXJpcGhlcmFsIHNzdXNiQDExMjAwMDAwOiBkZXZpY2UgZW5hYmxlIGZh
aWxlZCAtMTEwDQptdHUzLXBlcmlwaGVyYWwgc3N1c2JAMTEyMDAwMDA6IG10dTMgaHcgaW5pdCBm
YWlsZWQ6LTExMA0KYm9hcmRfaW5pdDogQ2Fubm90IGZpbmQgVVNCIGRldmljZQ0KaW5pdGNhbGwg
ZmFpbGVkIGF0IGNhbGwgMDAwMDAwMDBmZmU0NmE1MCAoZXJyPS0xMTApDQojIyMgRVJST1IgIyMj
IFBsZWFzZSBSRVNFVCB0aGUgYm9hcmQgIyMjDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

