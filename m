Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF1C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E703487457;
	Thu, 26 Oct 2023 09:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="U+6imOXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADAB87224; Thu, 26 Oct 2023 09:36:00 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DED874F8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698305756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2g+T37JKXqVTnXP83EWI6l9adRjJoq1E8dAheTOxDoQ=;
 b=U+6imOXgQm3qmbsBsihJoaHYBqhhodEhvd/990Ak7ZxSnt6GEVCr44kluLzAn8QwV73+4G
 PL7QFrRlH95eoY+CI4Zd5yHWkOYuli1hao0BskCiyqV7BODx8qTKJI+C8IFoKfgtmR8bGP
 i+nRzr43uOrchVulSWOH+QBA1jreT0s=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-FJ8Dm7NZO56n-beSEYfXyA-1; Thu, 26 Oct 2023 09:35:54 +0200
X-MC-Unique: FJ8Dm7NZO56n-beSEYfXyA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB1074.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Thu, 26 Oct 2023 07:35:52 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:35:52 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "festevam@denx.de" <festevam@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0LBYqXaAgAAMigCAABTWgIAAIPoAgAAVaICAAas2AIAAKvkAgADaFYA=
Date: Thu, 26 Oct 2023 07:35:52 +0000
Message-ID: <132abd8fa3d6fdb8580d10f6a581fd451752ccf1.camel@toradex.com>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
 <4faf5846-9aa8-4396-84fa-8d36c9b4fef9@prevas.dk>
 <2442c84e27ac3271ae17d1e7b272d624cdbf22cf.camel@toradex.com>
 <3c3ebabe-fd7b-45a4-aefd-13d74b146f30@prevas.dk>
In-Reply-To: <3c3ebabe-fd7b-45a4-aefd-13d74b146f30@prevas.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB1074:EE_
x-ms-office365-filtering-correlation-id: b89a35f6-76d8-48c0-6157-08dbd5f62ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 78X0KR66W6j2SPIOzHXw/mnAxUfx1pw0zMdRdFaBU5HKkmVx7sUFbjlr61XZJqHtAL/gFGa4CUI234b2gVK3OR3xvlfhY7CNvt7VqsM2K83EA/vD/WNUbtijmswkvZiYFzGKbudJ0MZD2rN8k4Mwd4S3z/x3y/y2JgHgip75cpSGxBrsLj1sT14044eqscnW05rjftZ8q7t4r4h9boGjfOIPS4pujBygkv0PfDeXcCSGtQZWUCEJUfLjw7862sA55NTSjUw1LRZKrquBGZAlgPWDnec9DSNjJflY/qKhp4pM+WRgFeh6d+Zmw71X+5Bjtznm4dRVLDydCTJGascejbb2/omeDfTZRm9ekynXJvRHXe54UyThKH7rQVgH1XlBfRuWOOPYxqUnATXPmfIs25JdXKnSqN6Vr9T7S5iHpcEqzBj0BmlwtaTyIuND+/k1FIVtPsy9h2ljszCHApfPnnmeVEi1AKWD2xtdvLAqRzuryeCXgW3tFFMT04dOSO87367MRDkTQk/lm03g3d2wV3Az6yvUOOWocgjCJoouGBW4BBQ3H6aiaYXyIhh95ouNYvSOz7MXnHiM/4HA666QlJZL0Ujfv3iZjKQFEWknCio=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(6512007)(44832011)(41300700001)(122000001)(5660300002)(26005)(966005)(6486002)(8676002)(4326008)(8936002)(478600001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(36756003)(91956017)(110136005)(38070700009)(6506007)(71200400001)(86362001)(38100700002)(2906002)(4001150100001)(83380400001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG55SmM3UytaMTR6eWhhTXg1YW9WNURvVjZQeTdydFpZNDZ2ZG9YOGNLNUpB?=
 =?utf-8?B?TkpmZGZMeUs4MDNGUVorR0NqK0ozNXVPNnpISUtWYWE5Yk9NcUV2UXZsM3hj?=
 =?utf-8?B?NzNUcVUxRW1CaDZZeWE0TUh6TUI1KzlEMjhkVFdudHpyVVRNMUlUSWlQRGov?=
 =?utf-8?B?bjBaRnh4RlJQZW9SQzUvUzAzaFlPSU5FcEQ4REZ0aEx1OHZuOGkzcXhBTDJT?=
 =?utf-8?B?cUtDVnB1M2RaVXU0Y2YwMXlJRjRqWVRoQzNtQ05sWXFNbjJtRzJOdU5UZHhF?=
 =?utf-8?B?YUVHMk9yTCthV215K3Y5QjRHMlhvTTJxNlpFaHRQY1FIa09EY3RLbDh0eU9C?=
 =?utf-8?B?OGhObVM0dU8wWjZrMlg1UnJoU2Nsc0taQVU0OUw2ZHRzcmRxQTBrT3NmQk1E?=
 =?utf-8?B?NGdoTzZSZlBRbEEyQzZ2TjVKN2dEZ2RZTE9Pa1Z6R1pKdm9yUjE2SjJpOGEv?=
 =?utf-8?B?RjYwYktabHpHWjlpejV6ck9iQ2oxUkd2Qm9pcHEwNExoUDB6MlM0Q2kzSlcy?=
 =?utf-8?B?eGo4UnpBWVNHZ3U5UmZtY1VVeEVOUGpwdTk0K28yM1pRMVNvUE8yUWpEY1Vy?=
 =?utf-8?B?andWb2R0TW1tOCtKWko2UExiZXpjOVJuKzlOSUloU240ZHllb0E3ZTYyT2d5?=
 =?utf-8?B?RkFqckxoek41RGdheFFvZGcvbzd0aG1wQS9mNFRrMXprZW5XWUZwRlBROTBL?=
 =?utf-8?B?K1FJeE43WktPelpXUElPV1lPWU53WWpaRUVlaTNHbUNLVG1nMnV5eXZ3cXNt?=
 =?utf-8?B?M0p0alJIenlPQTdUcTFrOUMrZHBNYnJadWdHNkNoQWhWVFBKRTN5bTNRNEMy?=
 =?utf-8?B?R0E3ZlZUZWRsdkUwNVlaRFBINWVKNkJmTEZxUVRQR1UwVDVEbm5EbzlCTDJK?=
 =?utf-8?B?aWMyV1dLZlQwN3ZBWkpkOGJHUXFSTVQ3OXZYdUZMbnhQTHpraFl2UEJmRGhv?=
 =?utf-8?B?NHJhWW13UWRtWW14a2NQUk55OEM3bVptU1hodmpSM2diTDlEb2RZQldHTjdR?=
 =?utf-8?B?R2dYZEk3TEY4UmZadUdaTkFaMHgrbEQ5UzhkZVB6dGlGYUd0OFJtVFhsakdr?=
 =?utf-8?B?SFlVUnNSc3poam8zRFc3bWFVNFJwa3J2NVU1UlZKdUppa2FjTnJBelZvWE9S?=
 =?utf-8?B?Ti9Nb21ReEtNMGpqdmlWVUYyYXoxQW1yN1lkM0ZuMjZPanR5Smp5WTh5MVhw?=
 =?utf-8?B?R1dBTkFnRFFzNVBZL2tLdXVEN2d0WGR3b0lmcWw0U2ZMMkp0Vkg5RVVIOGg0?=
 =?utf-8?B?TUFwdE9tVzdxUlQ4K1puYnFmUldTWC85TmU3MFZ3L0dzamxMUXNKSHMwYTBp?=
 =?utf-8?B?bzRabWRaSG9kQkpLSG9RQmIranRpT21jcHZFTE1oV3FVMy9qVDdrM3Bkdndn?=
 =?utf-8?B?V1pSSTlocVl0VXR5Wmd2SWFUYzFRWlIrL3hNWnZQNENMbnNTMi9zQWdMWFc5?=
 =?utf-8?B?YXBKcVNsK0dDU2hqWm01OEIxM3p1NnNmSDg0alBpOFA5a1dTRmo0VHhIYkdr?=
 =?utf-8?B?N0VvVmlKK1JkaCs1ampjckU5NEtYd0lsRm5TNHBYU3BPazdnU2dDbzR3K05L?=
 =?utf-8?B?VHpvb1NXZDFxTzJJbkxYVlhRL0JZS0ZaQW5lNE04ZitiY1VTN3BlZEg0WlV3?=
 =?utf-8?B?RmxlSUhhRWt1OUNPcUg3SmxvcHB2NmhwNWgvQ2pIcDFJYTU3Y2R2TFZ4Vk9l?=
 =?utf-8?B?VzIwOHhYbHhkMDVCbGt3cStoVkk3YkhTaWV2aWwyYmQvNkJJUTk0cnZjdFFq?=
 =?utf-8?B?S2pyQ0ZURkpTWkFQb0ZGME10L2ZWVWdxRnVRb29WY0xkelV3eElIdHpPZzlS?=
 =?utf-8?B?TUVNMnphbVRoV0dVTkpWQTR6ZHM0ayt4cDhSNStzdFdUR3dtUWV6S0VRYmtX?=
 =?utf-8?B?SHJQeElWelJQQ1JhSHFFYnRMZ244c2Nwb0pqVHk0KzIxYVpWckYyVUJMYWdC?=
 =?utf-8?B?RFlCY0QyN252TVNzT2EyQVg4cmFwWWxZL1FmZkxCWUZ4UVY4UWhTNS9xVjhy?=
 =?utf-8?B?ZEhBT1ZDRWQzMGlnZUMvOFpjSnpjTldycWc1T1NzeFlGOFRaWmR6Q0huZUEr?=
 =?utf-8?B?dDNxVmFVYU9PZDB4UGNlRS9lM2sxTGsyb0NLclo2NzB4WW1FQW55bTVlWUhE?=
 =?utf-8?B?SlJKa2lQcU5zMGRQcEFxOE13TnFaNjhIMy9NVkZTVlFsakV4Z1dHNldDU0I4?=
 =?utf-8?B?d3c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a35f6-76d8-48c0-6157-08dbd5f62ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 07:35:52.4382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5SiENUYimZAR/2ExpjjedSVawNu/BtRsCvwJU+2jKbuwghV6bjuYYP2TkmUe8jZ/X2tlevdSVkYjWt2xelD1HNKhpQTTuJ9aMYPe8JPR4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1074
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <60A265CEC620B944A8F7952B4937CE80@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUmFzbXVzDQoNCk9uIFdlZCwgMjAyMy0xMC0yNSBhdCAyMDozNSArMDIwMCwgUmFzbXVzIFZp
bGxlbW9lcyB3cm90ZToNCj4gT24gMjUvMTAvMjAyMyAxOC4wMSwgTWFyY2VsIFppc3dpbGVyIHdy
b3RlOg0KPiA+IEhpIFJhc211cw0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyMy0xMC0yNCBhdCAxNjoz
MiArMDIwMCwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gDQo+ID4gPiBXaGF0IGFtIEkgbWlz
c2luZz8NCj4gPiANCj4gPiBHb29kIHF1ZXN0aW9uLiBTb21lIG1vcmUgZGVidWdnaW5nIHJldmVh
bGVkIHRoYXQgd2UgYXJlIG1pc3NpbmcgNDY0IGJ5dGVzIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGJ1ZmZlci4NCj4gPiBXaHkNCj4gPiB3b3VsZCB0aGF0IGJlPw0KPiANCj4gW3NsYXBzIGZvcmVo
ZWFkXQ0KPiANCj4gCQlieXRlcyA9IGVuZCAtIHNzLT5lbmQ7DQo+IAkJYnl0ZXMgKz0gc3MtPnBh
Z2VzaXplIC0gMTsNCj4gCQlieXRlcyAvPSBzcy0+cGFnZXNpemU7DQo+IAkJYnl0ZXMgKj0gc3Mt
PnBhZ2VzaXplOw0KPiANCj4gCQlyZXQgPSByb21fYXBpX2Rvd25sb2FkX2ltYWdlKHNzLT5lbmQs
IDAsIGJ5dGVzKTsNCj4gLi4uDQo+IAkJc3MtPmVuZCA9IGVuZDsNCj4gDQo+IFNvIEkgZmlndXJl
IG91dCBob3cgbWFueSBieXRlcyBtdXN0IGF0IGxlYXN0IGJlIGZldGNoZWQgdG8gaG9ub3IgdGhl
DQo+IGN1cnJlbnQgcmVhZCwgcm91bmQgdGhhdCB1cCB0byB0aGUgc3MtPnBhZ2VzaXplIFt3aGlj
aCBpcyBhIG5vLW9wIGluIHRoZQ0KPiB1c2IgZG93bmxvYWQgY2FzZSBiZWNhdXNlIHRoYXQgaGFz
IC0+cGFnZXNpemU9PTEsIHNvIEkgZXZlbiBjb25zaWRlcmVkDQo+IGxlYXZpbmcgdGhhdCByb3Vu
ZGluZy11cCBvdXRdLCBmZXRjaCB0aGF0IG1hbnkgYnl0ZXMsIGJ1dCB0aGVuIHJlY29yZA0KPiB0
aGUgb3JpZ2luYWwgdXBwZXIgYm91bmQgYXMgdGhlIG5ldyBlbmQgb2YgdGhlIHZhbGlkIGRhdGEu
IFRoYXQgY2FuDQo+IGNlcnRhaW5seSBhY2NvdW50IGZvciBsb3Npbmcgc29tZXRoaW5nIDAgPCBm
b28gPCBwYWdlc2l6ZSBudW1iZXIgb2YgYnl0ZXMuDQo+IA0KPiBTbyBsZXQncyB0cnkgaWYgY2hh
bmdpbmcgdGhhdCBsYXN0IGxpbmUgdG8NCj4gDQo+IMKgIHNzLT5lbmQgKz0gYnl0ZXM7DQo+IA0K
PiB3b3JrcyBiZXR0ZXIuDQoNClllcywgdGhhdCBjdXRzIGl0LiBQbGVhc2UgZmluZCB0aGUgZml4
IGhlcmUgWzFdLg0KDQo+IFJhc211cw0KDQpUaGFua3MgYWdhaW4gZm9yIGFsbCB5b3VyIGhlbHAh
DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEwMjYwNzMyMjAuMjQ0Mzg3
LTEtbWFyY2VsQHppc3dpbGVyLmNvbQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

