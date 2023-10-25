Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38114C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 16:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5133C87AD6;
	Wed, 25 Oct 2023 18:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="UUripsE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1DE87B04; Wed, 25 Oct 2023 18:01:39 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADC187B07
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 18:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698249696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RksRL/x3bvH2GLwdRRgRdxdW+e6/om4Erp08vgnFX1M=;
 b=UUripsE5tl15ZZ0J9OeeAW8l8jKzZGfBt/T+7zaCu4EwIDThHUCmVte6G+FsO7nw8sjRI+
 uBMtSFf1H+uooGN+YHOvacBtRmpFhhp7whLI6iEx6s/6/8dDxoIPkdjYATWiZ6fqsMazFW
 lbWpsS70f+feXfMRWPV/f+WEEU2AxPw=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-62-pLuD-lDWPjOCZ9yaq-2w6A-1; Wed, 25 Oct 2023 18:01:33 +0200
X-MC-Unique: pLuD-lDWPjOCZ9yaq-2w6A-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1160.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Wed, 25 Oct 2023 16:01:32 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 16:01:32 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "festevam@denx.de" <festevam@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0LBYqXaAgAAMigCAABTWgIAAIPoAgAAVaICAAas2AA==
Date: Wed, 25 Oct 2023 16:01:31 +0000
Message-ID: <2442c84e27ac3271ae17d1e7b272d624cdbf22cf.camel@toradex.com>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
 <4faf5846-9aa8-4396-84fa-8d36c9b4fef9@prevas.dk>
In-Reply-To: <4faf5846-9aa8-4396-84fa-8d36c9b4fef9@prevas.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1160:EE_
x-ms-office365-filtering-correlation-id: 93574564-72de-48fd-9b7f-08dbd573a81b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hKWRB6Xh/fB8KjlIusRDQwIMyu7baZ3bCEu7b7E42i7HpbXZAglVWas8oap6Bv6xJt7C4jvj1XihXN+cHDDCrxtHyLSPuOluyg6FiySLFc4r72W83MrLeL7UKEC7mW5HbNEk8Ggl7XW6dAkPbGQys0wMhxU8/joiZArtLtsadOhzENEx9NEtKc8oc5y/OYmnIZ6jGluych8wCRsX2WldS3PSma5tRPiUFJaPUOrTkCUbvyhVGEEhSqFej1Za4DK4lCN9udsyKxd3/yeLuoTZCqOmiYALvGr7ruGevHDo9q6HsNEbcl/JYltB5Q9d04xMDeXNjwJQeSkM/TQgAVv92EP4iggs3wRSToCGG8gAiIXZ6GSlN2F/DuA9ueVWmZt4u+TYMUIezx2WoPVdnenpi9XrrB1qFMccYWsptU81HSdKxzT476zpltpUVrCnp+IuBTgQLpy62ARvk3NYuuLwR3LkcrMFjjHqfeX4ztE0cyGLIidPgvvjHa0ZhxbcySrss1hzhuDhlyxK42zSdPBDF8VHwHrRrjw+SntukTxuNH/2PDATHK6cT1gFihah4QA88CiQamCotdPeCd802hXyNn8pna8CnzQY6dSa2loxZkxdOc6N09TW63QkNUh/5khE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(26005)(38100700002)(83380400001)(6512007)(2616005)(4001150100001)(122000001)(36756003)(86362001)(38070700009)(2906002)(71200400001)(41300700001)(76116006)(64756008)(6506007)(110136005)(54906003)(316002)(66556008)(66446008)(66476007)(6486002)(8936002)(478600001)(91956017)(66946007)(44832011)(4326008)(8676002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFhobnlqNXJOZENDaE1mbk5PVlRIdGdnNTViV3pFOVp6MjMvOGZTVkR0cFV1?=
 =?utf-8?B?NzY2RXkycFZUZE9lS3RDckxibkQ5RUVySzNMVHVoNVZNSGpwM1Vqc2c2MjEv?=
 =?utf-8?B?a2tiemZwUEc3Q3JQMWRZM09Ebi8wQkhoOEJESXROV2tTY203ODV2WkdHcGcy?=
 =?utf-8?B?YnBxSDFHRmxoU0ZjcTBJMzA2dUxQOVFxdjl5MktjODVzR3FMbGtRdnJHbGx0?=
 =?utf-8?B?UUszemh3MjgvaVJKa2NvVm1XdnB3eW15eFphWUtBTlNFUUxGRUtRbnA1UzA1?=
 =?utf-8?B?c2dxQlhiTGNqNUlEWG9CQXNXUnVhTjRpSHc3QmVDRTVENmJOTkg0eUpUZERs?=
 =?utf-8?B?aVBmTk55ajV0YUJEMm5mT3pQVUVmNkJVTktmUzBmRm93UkJPM3BqRkkvZlNC?=
 =?utf-8?B?cE1vMDBHaWg2eVJOWTNKS09oYWZjd1pGSDdqVmZIdytEcXZEdHhIQTZJMU1E?=
 =?utf-8?B?cjhqTlVHdmhJUEoyR1l2Z0YzMUxsYzF6Q1ZqSDNobnA0c2krajlNQm83OFEy?=
 =?utf-8?B?SkQ5U1dqU0JmK0RZeG1rcjhSUE5WK3RJcEpCdzZqdGJiWEJlU1FmSzEzc3R0?=
 =?utf-8?B?UDdrc1NRT2pUVmY3Q0pRUG9BTkhCSFcxZEQ0eDFLTW4zSVRpZFllYS85SFRx?=
 =?utf-8?B?WC83bjVNaWNTMnBkTmpISEhUOGVxc2ZoTDBERXR4UEFHdkVseE14bXlhQ2Y5?=
 =?utf-8?B?R01QWTNmZm1vUWFQY1NUS3RjZmRCekRmd0NpVnJYYmxqY1p4QllYU3NPdlBC?=
 =?utf-8?B?bnJvdG5IbFk1S1RpdE9ONDJJS3dlRE5NdWNvVlpySENlaFUwSHFjQWN5WUlu?=
 =?utf-8?B?aklJM3hudVNocFJVckZnTy84OWYwZG44YUg3QXZZZjhSaS8rSHR2dUdyZTZV?=
 =?utf-8?B?M0hNMXJ6cWZXUU1naEJvcFFpbm0zL0VCYXoydlRwRWZOTDdsQXVhazQ2L0hZ?=
 =?utf-8?B?NG5zckxqb2NhMUhmYmVGdnBEellqUDltN0tyaVRqRWppZlB1QzNoTGFLZGlh?=
 =?utf-8?B?aSt5ek1Vbk9tNC82R3h2ZU9GRjgxaytXUnJ5UnhjZzNQUldDV0xadm9Mandp?=
 =?utf-8?B?K1dJUklsMCtDWWY1Q2dMZ3dIeTNlVkJSQTRVK2xjTWxhNlJZN1dYWFUvbEtD?=
 =?utf-8?B?N2pKQmRBQ1lUVk0vTFk4emFMUkRFMEtpNFlnVFRQTjlnSmNOV3g0bWhOVWp3?=
 =?utf-8?B?clhDcW9XME5kNGgvQXpNcHRLQWxFSGJXcU9uRHo4VU5aWnZDTmJIMjI1YWFz?=
 =?utf-8?B?R0txUERiMlcwenNSMzlkeUFWMUNJRnc4SUJmVVgzTUtnbEg5MDlQYkFlQ1hF?=
 =?utf-8?B?Y1dtai82c2I4NU9ZanNjZjNsVS9OSGZqWHp0dXlrTjBwU0EvTm5MeXlNNVkw?=
 =?utf-8?B?ZEk3Y0N0ZmNSRmNXTFZuQldsN0lEd2M0VHNoK0tNT3lYemNQcWFWS3FFR2NP?=
 =?utf-8?B?bU9raUlKRXZ3ZWxGVTlHb21JL01ZZ3I3T3luMDE2aWM2QVA3MDdITDZRd1Vh?=
 =?utf-8?B?dDAxWkJhVytsMXpFQXovOU45enUxdG1QT3M2ZVJMYUZMYW9IdkZRMFJLdTdS?=
 =?utf-8?B?cXVXTjlmSW51TnZiaTZFTHRGbzZJdmR6bldWVzhGNWRCS09vbngrcXJLUEFF?=
 =?utf-8?B?UXR2dHhzekRwdzR0OVhRMlYxd01EbXliblRLdzdyd2VpODNQaFJQbE1UeWl0?=
 =?utf-8?B?aWIyNWVrd0E5b1Z4VWZwbnhubUk0ZHVvTGs1RU1WV0huOWhSRHY4WDUwSENj?=
 =?utf-8?B?T29RUzJ2WXIzdXRseG1MUUFtNGhwSHp1Y1ZRQyszN0dmWTAvRy9PbU9ZcDF3?=
 =?utf-8?B?Um5xWldHNUt4dm10Q2V1L0RGZ0ZRU1ArWGhUN2ZweGgvWXczSDR2OE5GQ0xn?=
 =?utf-8?B?V21lREZBVFVVa1VDa3crcjZTQmVjUmc0MDBQbnc2MmRRN0dKL05hdjYyRmZ0?=
 =?utf-8?B?dUp2aFZvTlZ1a2ZtQVd0ZXNETVNyeTU3UTR3N2p5bFU2WTRXS0FMMW53cExW?=
 =?utf-8?B?aTdFdTZPVzBKZ2taaEl5a21zVlRTaDY2Zm1hQUNFTVdoVVpGdlZYZkJ6M01J?=
 =?utf-8?B?OGNBaDJQYmMrZWIwWGd3V29YQTZOZzY4RGU4Y3F4Sm1nQXhML3BrRm15emJr?=
 =?utf-8?B?MmFPeXN4MTk1TFhxeVdJNHYxOFcyT3hVaEc3NkRudWo0bHBlbWJISjlMQ3RL?=
 =?utf-8?B?R1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93574564-72de-48fd-9b7f-08dbd573a81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 16:01:32.0832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMbgDv9EV+T240vJ7zQE6vO0pymk8WOshZDafUjZyBsMDjsdKxvLxvL/GsnxHmyWpIjlz9xhoUfmqQa/K6zhgsnUsfE+ZKLrr8b0fqVb5oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1160
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <EC43961750ADEE44BC55FB242A5301CA@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUmFzbXVzDQoNCk9uIFR1ZSwgMjAyMy0xMC0yNCBhdCAxNjozMiArMDIwMCwgUmFzbXVzIFZp
bGxlbW9lcyB3cm90ZToNCj4gT24gMjQvMTAvMjAyMyAxNS4xNSwgTWFyY2VsIFppc3dpbGVyIHdy
b3RlOg0KPiANCj4gSGkgTWFyY2VsDQo+IA0KPiB0bDtkcjogY2FuIHlvdSB0cnkNCj4gDQo+IEBA
IC0zMzAsNyArMzM1LDcgQEAgc3RhdGljIGludCBzcGxfcm9tYXBpX2xvYWRfaW1hZ2Vfc3RyZWFt
KHN0cnVjdA0KPiBzcGxfaW1hZ2VfaW5mbyAqc3BsX2ltYWdlLA0KPiANCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNzLmJhc2UgPSBwaGRyOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3MuZW5kID0gcDsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3MucGFnZXNpemUgPSBwYWdlc2l6ZTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3MucGFnZXNpemUgPSAxMDI0Ow0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1lbXNldCgmbG9hZCwgMCwgc2l6ZW9mKGxvYWQpKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxvYWQuYmxfbGVuID0gMTsNCj4gDQo+IGFuZCBhbHNvIHB1dCAxMDI0IGluIHRo
ZSBiaW5tYW4gbm9kZSBzbyB1LWJvb3QuaXRiIGlzIGFsc28gMTAyNC1ieXRlDQo+IGFsaWduZWQ/
DQoNClRoYXQgZGlkIG5vdCBoZWxwLg0KDQoNCj4gVGhpcyB3aWxsIGxpa2VseSBicmVhayB1c2Ig
Ym9vdCAod2hlcmUgcGFnZXNpemU9PTEpLCBzbyBpZiB5b3Ugd2FudCB0aGUNCj4gYmluYXJ5IHRv
IHdvcmsgd2l0aCB1c2IgeW91IGNhbiBtYWtlIHRoZSBSSFMgaW5zdGVhZCAiKHBhZ2VzaXplID4g
MSA/DQo+IDEwMjQgOiAxKSIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgaXQgd2lsbCB3b3JrLCBidXQgT1RPSCBteSBhbmFseXNpcyBiZWxvdyBkb2Vzbid0IGZp
bmQgYW55DQo+IG90aGVyIChmdW5kYW1lbnRhbCkgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBvbGQg
YW5kIG5ldyBjb2RlLg0KPiANCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMTAtMjQgYXQgMTM6MTcg
KzAyMDAsIFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+ID4gDQo+ID4gPiANCj4gPiA+IGFuZCB0
aGlzIHdvcmtzIGp1c3QgZmluZS4gQnV0IGluIG15IGNhc2Ugc3MtPnBhZ2VzaXplIGlzIDEsIHdo
ZXJlYXMgeW91DQo+ID4gPiBoYXZlIDUxMi4NCj4gPiA+IA0KPiA+ID4gSnVzdCBleGFjdGx5IGhv
dyBhcmUgeW91IGJvb3Rpbmc/IEl0IHNheXMgIkJvb3QgU3RhZ2U6IFByaW1hcnkgYm9vdCINCj4g
PiA+IHdoZXJlYXMgSSdtIGRvaW5nIHNlcmlhbCBkb3dubG9hZCB3aXRoIHV1dSAoaS5lLiAiQm9v
dCBTdGFnZTogVVNCIGJvb3QiKS4NCj4gPiANCj4gPiBZZXMsIHJlZ3VsYXIgZU1NQyBib290Lg0K
PiANCj4gW3NuaXBdDQo+IA0KPiA+IA0KPiA+IEF0IGxlYXN0IEkgYW0gbm90IGF3YXJlIHRoYXQg
d2Ugd291bGQgYmUgZG9pbmcgYW55dGhpbmcgc3BlY2lhbCBmb3IgZU1NQyBib290Lg0KPiANCj4g
V2VsbCwgSS93ZSB1c3VhbGx5IGRvIGJvb3QgZnJvbSBlTU1DIChleGNlcHQgZHVyaW5nIGJvb3Rz
dHJhcCB3aGVyZSB3ZQ0KPiB1c2UgdXV1KSwgbW9yZSBwcmVjaXNlbHkgZnJvbSB0aGUgZU1NQyBi
b290IHBhcnRpdGlvbnMsIGJ1dCB0aGF0IGRvZXNuJ3QNCj4gZW5kIHVwIHVzaW5nIHRoZSBzcGxf
cm9tYXBpX2xvYWRfaW1hZ2Vfc3RyZWFtKCkgYnV0IGluc3RlYWQgdGhlIGV4cGVjdGVkDQo+IHNw
bF9yb21hcGlfbG9hZF9pbWFnZV9zZWVrYWJsZSgpLg0KPiANCj4gUGVyaGFwcyBzb21lIE5YUCBm
b2xrcyBjYW4gZXhwbGFpbiB0aGUgbG9naWMgYmVoaW5kDQo+IA0KPiBzdGF0aWMgaW50IGlzX2Jv
b3RfZnJvbV9zdHJlYW1fZGV2aWNlKHUzMiBib290KQ0KPiB7DQo+IAl1MzIgaW50ZXJmYWNlOw0K
PiANCj4gCWludGVyZmFjZSA9IGJvb3QgPj4gMTY7DQo+IAlpZiAoaW50ZXJmYWNlID49IEJUX0RF
Vl9UWVBFX1VTQikNCj4gCQlyZXR1cm4gMTsNCj4gDQo+IAlpZiAoaW50ZXJmYWNlID09IEJUX0RF
Vl9UWVBFX01NQyAmJiAoYm9vdCAmIDEpKQ0KPiAJCXJldHVybiAxOw0KPiANCj4gCXJldHVybiAw
Ow0KPiB9DQo+IA0KPiBBcHBhcmVudGx5IHRoYXQgImJvb3QgJiAxIiBpcyBhbiBpbmRpY2F0aW9u
IHRoYXQgImVNTUMgZmFzdCBib290IG1vZGUiDQo+IGlzIGVuYWJsZWQgKG5vdCB0byBiZSBjb25m
dXNlZCB3aXRoIGZhc3Rib290IHdoaWNoIGlzIGEgVVNCIHByb3RvY29sDQo+IHRoYXQgb25seSBi
ZWNvbWVzIHJlbGV2YW50IG9uY2UgVS1Cb290IHByb3BlciBpcyB1cCBhbmQgcnVubmluZykuDQoN
Clllcywgd2UgdXNlIGVNTUMgZmFzdCBib290IG1vZGUuDQoNCj4gQXMgSSd2ZSBjb21wbGFpbmVk
IGFib3V0IHByZXZpb3VzbHksIHRoZSBST00gQVBJIGlzIGFsbW9zdCBlbnRpcmVseQ0KPiB1bmRv
Y3VtZW50ZWQuIFRoZXJlJ3Mgc29tZXRoaW5nIGluIGlteDkzcm0ucGRmICh3aGljaCBpcyB3aGVy
ZSBJIGhhdmUNCj4gdGhhdCBlTU1DIGZhc3QgYm9vdCBpbmZvIGZyb20pLCBidXQgSSBoYXZlIG5v
IGlkZWEgaWYgdGhhdCBhcHBsaWVzIHRvDQo+IGlteDgvaW14OG1wIGFzIHdlbGwuDQo+IA0KPiBB
cmUgdGhlcmUgYW55IGFsaWdubWVudCByZXF1aXJlbWVudHMgb24gdGhlIGRlc3RpbmF0aW9uIGFu
ZC9vciB0aGUgc2l6ZQ0KPiBwYXJhbWV0ZXI/IElzIHRoZXJlIHNvbWUgdGltaW5nIHJlcXVpcmVt
ZW50cyBzbyB0aGF0IGlmIHdlIHJlYWQgdG9vIGxhdGUNCj4gdGhlIGRhdGEgaXMgbG9zdD8gU28g
Y291bGQgZS5nLiBhIGJ1bmNoIG9mIHByaW50ZiBkZWJ1Z2dpbmcgYnJlYWsgYm9vdD8NCj4gDQo+
IEJlY2F1c2UgSSByZWFsbHkgY2FuJ3Qgc2VlIHRoZSBmdW5kYW1lbnRhbCBkaWZmZXJlbmNlIGJl
dHdlZW4gbm93IGFuZA0KPiB0aGVuLiBCb3RoIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGNvbW1pdCBp
biBxdWVzdGlvbiwgdGhlIGNvZGUgZG9lczoNCj4gDQo+IC0gcmVhZCAxMDI0IGJ5dGVzIGF0IGEg
dGltZSwgc2VhcmNoIGVhY2ggY2h1bmsgZm9yIEZEVCBtYWdpYw0KPiANCj4gVGhpcyB0aGVuIGdp
dmVzIHRoZSAiRmluZCBpbWcgaW5mbyAweDQ4MDJiMDAwIg0KPiANCj4gLSBtYWtlIHN1cmUgdGhl
IGxlZnRvdmVyIHdpdGhpbiB0aGF0IDEwMjQgY2h1bmsgaXMgYSBmdWxsIEZEVCBoZWFkZXINCj4g
KHVzdWFsbHkgb2ssIHNvIG5vIG91dHB1dCkNCj4gDQo+IC0gcmVhZCB0aGUgRkRUIHNpemUgZnJv
bSB0aGF0IGhlYWRlciwgcm91bmQgdXAgdG8gYSBtdWx0aXBsZSBvZiAxMDI0LA0KPiBmZXRjaCB0
aGF0IC0gdGhhdCdzIHRoZSAiTmVlZCBjb250aW51ZSBkb3dubG9hZCAxMDI0Ii4NCj4gDQo+IEFu
ZCB0aGVuIHRoZSBmbG93IGRldmlhdGVzLg0KPiANCj4gVGhlIG9sZCBjb2RlIHdvdWxkIGRvIHRo
ZSBmYWtlIHNwbF9maXRfbG9hZCB0byBmaWd1cmUgb3V0IHRoZSBtYXhpbXVtDQo+IG9mZnNldCAo
dGh1cyB0aGUgcmVhbCB0b3RhbCAuaXRiIHNpemUpLCB0aGVuIHRha2UgdGhhdCByZW1haW5pbmcg
c2l6ZSwNCj4gcm91bmQgdXAgdG8gLT5wYWdlc2l6ZSAoNTEyKSwgYW5kIGZldGNoIHRoYXQgd2l0
aCBvbmUgZmluYWwNCj4gcm9tX2FwaV9kb3dubG9hZF9pbWFnZShwLCAwLCBpbWFnZXNpemUpOy4N
Cj4gDQo+IE15IGNvZGUgaW5zdGVhZCBkb2VzIGEgbnVtYmVyIG9mIHJvbV9hcGlfZG93bmxvYWRf
aW1hZ2UoKSBjYWxscywgd2hlcmUNCj4gZWFjaCBzaXplIGFyZ3VtZW50IGlzIHJvdW5kZWQgdXAg
dG8gdGhlIC0+cGFnZXNpemUgZnJvbSB0aGUgYm9vdF9pbmZvDQo+IHF1ZXJ5IChpLmUuIDUxMiku
IFNvIGl0J3MgcG9zc2libGUgdGhhdCBmb3Igb25lIG9mIHRob3NlIGNhbGxzLCB0aGUNCj4gZGVz
dGluYXRpb24gaXMgb25seSA1MTItYnl0ZSBhbGlnbmVkIChiZWNhdXNlIGEgcHJldmlvdXMgY2Fs
bCBmZXRjaGVkIGFuDQo+IG9kZCBudW1iZXIgb2YgNTEyIGJ5dGUgYmxvY2tzKSwgYW5kIHRoYXQg
ZG9lc24ndCBoYXBwZW4gaW4gdGhlIHByZXZpb3VzDQo+IGNhc2Ugd2hlcmUgYWxsIGJ1dCB0aGUg
bGFzdCByb21fYXBpX2Rvd25sb2FkX2ltYWdlKCkgaGF2ZSBmZXRjaGVkIDEwMjQNCj4gYnl0ZSBh
bGlnbmVkIGNodW5rcy4NCj4gDQo+IFdoYXQgYW0gSSBtaXNzaW5nPw0KDQpHb29kIHF1ZXN0aW9u
LiBTb21lIG1vcmUgZGVidWdnaW5nIHJldmVhbGVkIHRoYXQgd2UgYXJlIG1pc3NpbmcgNDY0IGJ5
dGVzIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGJ1ZmZlci4gV2h5DQp3b3VsZCB0aGF0IGJlPw0K
DQo+IFJhc211cw0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

