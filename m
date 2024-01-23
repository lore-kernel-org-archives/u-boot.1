Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A63C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 07:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CAF87AEC;
	Tue, 23 Jan 2024 08:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="f9uzz0bM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5B187B36; Tue, 23 Jan 2024 08:39:51 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27A8879B3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 08:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1705995589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WVBR/okqNGLsWYWNmrpYD0LsFHwLupAT13mpNt87WQ=;
 b=f9uzz0bMCAg5ZLR+lJT4zLS/+Oee4iC7f0yXVPkHXQgE1pSTw/mDu954JtvibbgeWWhwkN
 OvuIb1SM9CXYlNTnd9odCQfnbxxMeHv6ysFcEsTN/29Af5iNEFb3H6XRg2zcDt5ROc+DDf
 UcSUPVHMMSSiYgduI5LVU30cmFyZzKg=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-76-ol9xoeV4PBCZwlMwqP085A-2; Tue, 23 Jan 2024 08:39:48 +0100
X-MC-Unique: ol9xoeV4PBCZwlMwqP085A-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0805.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 07:39:45 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 07:39:45 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "jpaulo.silvagoncalves@gmail.com" <jpaulo.silvagoncalves@gmail.com>
CC: =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
Thread-Topic: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
Thread-Index: AQHaTW79YlhMpY2cYEWcyoKHu8g2urDnBAcA
Date: Tue, 23 Jan 2024 07:39:44 +0000
Message-ID: <40ef4bbae5d5280f1ae16ed97b0d622bcfb8aaea.camel@toradex.com>
References: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
In-Reply-To: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0805:EE_
x-ms-office365-filtering-correlation-id: ac8f337d-0312-442a-c3dc-08dc1be67808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: O20jTCrYweZp3I//V3eR7Yx+LuVniow1M2xnackxQoQ3WfNlwa6N7l7Kds5DzpzxbynUNAN0u569DkcVCJWDMUODn2y0jFlzGxHa4KL8wMfhGDzeL6TijsJUBz9LpEbSsW8wkokshc0i+Z1/whr9nPoyAYhbcAyWznFUZQevVRRGKmYNlcpNKPhpJU56pdA2z8XQHvcTuM0fbk810pM6/IGwA/im/dn3kmIqqBtwgOL7FPUbsSQLmTQLs7QFpEfD53hFWkwhV9BUUMb/TmJ9L0pHZlE47DvqbZPJZnEFZ1xlgWwxUx3mg4lcD5rEVGUYOwZFrB4XjlURn33ce08oMwGj64bP6GOkmnZP2EMUFCwqX438Y5rx16cFzNSBgL/f4gJTFUtesqk5KpdeDLcgmczt3MqjDwiUHC5h/EutTxEL+Ju2Vcf3DQYBbpVGS+aXHDbaAKSrDcrkV6sxZi0pluto0bqrjRkIXg//G2o5eo+rHxH88OPlRkybARp6f2e8k+fIsKYZzCLshU3yQTFV42y7QNps+ykjCFi5UdItU+r1G/52cIxnXtpqfF5ngkcr9a/OdwFCouCzuszN+yneN4Lx3qqXvljjBY6XfvUfXoaloyYmBbCCk+P3eizA78nT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(396003)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6916009)(5660300002)(66946007)(66446008)(76116006)(66476007)(54906003)(64756008)(66556008)(316002)(26005)(6486002)(6506007)(6512007)(71200400001)(478600001)(83380400001)(4326008)(44832011)(36756003)(2906002)(86362001)(122000001)(38100700002)(41300700001)(38070700009)(8936002)(8676002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1dsTTdjdEZWYkN6NmlUdFBzWlRWNk1na2pvdVBqRWJieW52dEFrdmg5dmlE?=
 =?utf-8?B?UzJBQnV2a2hzb09HaGtWQXhZQklpa0U2dyt3RWJ6cVBlbXJlb1R1cWNnOS9n?=
 =?utf-8?B?S0RmSkNxditsd0FrK3ZCT3NyVjRNOEt2MFBzZHFvSzVBV3JNMDVKdmJVVEMw?=
 =?utf-8?B?NHUvaHdMMDRRZURDWFovTk1XcHRXd2M5a2dnL3Z1NGM1WHZteEtGb1VmcDhL?=
 =?utf-8?B?SXo0YlVEbmVYNUVqMVdlQ05MYVp5WktqYlp2N09VQWN2d1BiSGhzTjdHTzB2?=
 =?utf-8?B?SCtZa0I2WDgyeEJtdVN1NURhcGx1eFFOWU5wTGJvdW85clJpeW1xRERiZkJv?=
 =?utf-8?B?cGM2djI2WmFDN1VxL3RyTHI2dmo2ZjlmWDVpSnVMV3ZZTUgyWjhoRmZEc2xn?=
 =?utf-8?B?cFk3M1dHZ1g4RUdXYldnWlZEZGxSb1c1TndlOTF0QlB6T2tURW5DRUw2OWhR?=
 =?utf-8?B?Z3FaOW1MRXVLUjNlMkgwZklaNFNZQ2hiM0N5cGN6dzNFdDFSODdjQUEwMEc2?=
 =?utf-8?B?R0ZnWk9JUkVUSGttNTJWeGROa0RQaUcyeHVtcHpHd2ovZmhZMWpVb3pneXdC?=
 =?utf-8?B?TmxoUkJwVHNmTWdEK0NEWXBzZDBrQXROYTB5U3BlejMwTUJWMXVHUDZtU05p?=
 =?utf-8?B?R1R4ay9MdEh5b05ZUHFWcC84NjRtSGNYM09MRGwwRnljWTNaeGF6WG93bFIv?=
 =?utf-8?B?clBrUHpETEJMcW9DaG9MS2dYTUw2S09BWlN4aG52cEpIcFlwUmM1MzNMdHNn?=
 =?utf-8?B?cUlGc28vVFZ2alpOUFFhRHZCaFpRUG0rNjZVVXJleU43RkgvMGJUZ2JtMDVs?=
 =?utf-8?B?Lyt5dUkySU1KNVprNFdHeHg1SVlycUcxYk9GZGVwTUF6VnB5VWFCa2gzOCtB?=
 =?utf-8?B?Z2syM051S1luTUU0bWkvYzJXV2J5YXZKckk4N1ZIRVZqQnYza2xXM25LY29M?=
 =?utf-8?B?UmZUQm00Wi9jbk03V3RiZmNKNXFsd1NvY3JYYzhSZ2lHNGs2TFVmU1cySE9W?=
 =?utf-8?B?WWd2NGk4M0JQcG9xaEtFWTE3V2Q2eTBtNXl5ejdtQzlWTSt4cmd4Q1RCSTNK?=
 =?utf-8?B?MHloODdXbUJ5QkRoRkRXaXBEb1hISTlmYWFhKzIvWGpOWEtyd3o0Z09vOGVz?=
 =?utf-8?B?MlhNRExiK0pRUGw2TjFnUnFQYk15cTlLeTc1MWg4ZWczdEFwdERYcEhlMjRk?=
 =?utf-8?B?WWxLYlRQMlpuM2d2R0RjUnJOWVJicS8rbFJRMnltZkdqZlJNR3NxNVdrUFlQ?=
 =?utf-8?B?QUdhZ2NNVGRGODcrWFArbitsdHk3b1NkcU8wRGhRajAxdDF3Z1NTYjk0VkhB?=
 =?utf-8?B?WVpKaU9TQ1QxYTdycjRpdWhxbmRlYkZZejdoTGZUTWVFbG5zcndxVFFGQ3ds?=
 =?utf-8?B?cGtYRkJ3emdBL1YyUlRCRmRkYzBSK3RSSmtBSkNaT2xORnhtK2lPNFdlUEJo?=
 =?utf-8?B?ZldkbS8rVmJXVlB2bVYrMjk0OGZjNm9DRVV4Y2ZvOEtiY2Izblk3a09QUU9V?=
 =?utf-8?B?ZjhDVFM3K01NZjNLcDFTNkx6YUJib0tWbmRjSFQyaUxlNHI2UUVyRnBtN0dE?=
 =?utf-8?B?NkxLNUJndU0xUlZyQ1pZbUcxZlM5VVBNL3pyYXZiWUNLODNtdHRkcDdSYWFt?=
 =?utf-8?B?Y1pyUUVLTWVKR2ZUQTZ4bE1oL3FOMGE2TTRQR2dYbWxZSXhYdUVyRTh0YlMw?=
 =?utf-8?B?dkd0OTgvS1JTU0xhckxQdDgxV0JZK2VQNmdINXdtQnBWZFYwYmlaVEtzYVYr?=
 =?utf-8?B?ZHk1dTlpa0hVT0VnL3F5Z3BXQVlVSkRCSlhOYUNoL2lvUTRiNUxEMkNGVlRn?=
 =?utf-8?B?ZnRUN1UyY09hN1pNdUhKTGhRTUZVSmFCbmFHWjRMVm5OYVdvSDBoOWpuMzdk?=
 =?utf-8?B?Tm1nQ2lsaUxCWmhlRC9xRkFydzFwTUp2UFRpbTNNb0ZzVFRaM055Mm1JVWt0?=
 =?utf-8?B?Ny8rZjd4K3ZwQjMxQUFENDRrVTZhVWEzYkNvckg2dmpacXdmZlVvNG04NXRu?=
 =?utf-8?B?OTNQYzlvc2ZyMGM4eHovZDJJWmJwZUVoNHZRUlh4bFR6RTR1QzBla0RaOUJ5?=
 =?utf-8?B?YnErdFB4MEZ0eURRbTJ3MmFtK0ZpMjdoMWJHelNZWG5SR2pIM0ZYZXN2SDhK?=
 =?utf-8?B?eS94OWtKMDBGTzNZTUpJM3l3RHpPMXg3VnFUWDg1R3VpckhDdXhCVVlsMUd1?=
 =?utf-8?B?YUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8f337d-0312-442a-c3dc-08dc1be67808
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:39:44.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYrHXSItX9VjHaJAuQXubTqJrr7y/nCJBKeLDBZ7q7pgjMYDwUC7ZAVvFy6YrwRrO53dKWbuKP4/Dy6ACofS0vD8lmCMpDxblA2RWIvAdNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0805
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <98162603DCC1CE4EB1CE707F1D187FC5@CHEP278.PROD.OUTLOOK.COM>
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

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDE3OjA5IC0wMzAwLCBKb2FvIFBhdWxvIEdvbmNhbHZlcyB3
cm90ZToNCj4gRnJvbTogSm9hbyBQYXVsbyBHb25jYWx2ZXMgPGpvYW8uZ29uY2FsdmVzQHRvcmFk
ZXguY29tPg0KPiANCj4gQWRkIG5ldyBhcGFsaXMgaW14NiBhbmQgY29saWJyaSBpbXg2L2lteDcg
cHJvZHVjdHMgSURzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9hbyBQYXVsbyBHb25jYWx2ZXMg
PGpvYW8uZ29uY2FsdmVzQHRvcmFkZXguY29tPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IMKgYm9hcmQvdG9yYWRl
eC9jb21tb24vdGR4LWNmZy1ibG9jay5jIHwgOSArKysrKysrKysNCj4gwqBib2FyZC90b3JhZGV4
L2NvbW1vbi90ZHgtY2ZnLWJsb2NrLmggfCA5ICsrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3RvcmFkZXgvY29t
bW9uL3RkeC1jZmctYmxvY2suYyBiL2JvYXJkL3RvcmFkZXgvY29tbW9uL3RkeC1jZmctYmxvY2su
Yw0KPiBpbmRleCA3MTg3ZTFiYTM3Ny4uN2FmZmMyOTAzOTUgMTAwNjQ0DQo+IC0tLSBhL2JvYXJk
L3RvcmFkZXgvY29tbW9uL3RkeC1jZmctYmxvY2suYw0KPiArKysgYi9ib2FyZC90b3JhZGV4L2Nv
bW1vbi90ZHgtY2ZnLWJsb2NrLmMNCj4gQEAgLTE0Nyw2ICsxNDcsMTUgQEAgY29uc3Qgc3RydWN0
IHRvcmFkZXhfc29tIHRvcmFkZXhfbW9kdWxlc1tdID0gew0KPiDCoAlbNzRdID0geyAiVmVyZGlu
IEFNNjIgRHVhbCAxR0IgSVQiLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRBUkdFVF9JU19F
TkFCTEVEKFZFUkRJTl9BTTYyX0E1MykgfSwNCj4gwqAJWzc1XSA9IHsgIlZlcmRpbiBBTTYyIER1
YWwgMUdCIFdCIElUIizCoMKgwqDCoMKgwqDCoMKgwqDCoCBUQVJHRVRfSVNfRU5BQkxFRChWRVJE
SU5fQU02Ml9BNTMpIH0sDQo+IMKgCVs3Nl0gPSB7ICJWZXJkaW4gQU02MiBRdWFkIDJHQiBXQiBJ
VCIswqDCoMKgwqDCoMKgwqDCoMKgwqAgVEFSR0VUX0lTX0VOQUJMRUQoVkVSRElOX0FNNjJfQTUz
KSB9LA0KPiArCVs3N10gPSB7ICJDb2xpYnJpIGlNWDZTIDI1Nk1CIizCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFRBUkdFVF9JU19FTkFCTEVEKENPTElCUklfSU1YNinCoMKgwqAg
fSwNCj4gKwlbNzhdID0geyAiQ29saWJyaSBpTVg2UyAyNTZNQiBJVCIswqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBUQVJHRVRfSVNfRU5BQkxFRChDT0xJQlJJX0lNWDYpwqDCoMKgIH0sDQo+
ICsJWzc5XSA9IHsgIkNvbGlicmkgaU1YNkRMIDUxMk1CIizCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBUQVJHRVRfSVNfRU5BQkxFRChDT0xJQlJJX0lNWDYpwqDCoMKgIH0sCQ0KPiAr
CVs4MF0gPSB7ICJDb2xpYnJpIGlNWDZETCA1MTJNQiBJVCIswqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgVEFSR0VUX0lTX0VOQUJMRUQoQ09MSUJSSV9JTVg2KcKgwqDCoCB9LA0KPiArCVs4MV0g
PSB7ICJDb2xpYnJpIGlNWDdEIDUxMk1CIizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFRBUkdFVF9JU19FTkFCTEVEKENPTElCUklfSU1YNynCoMKgwqAgfSwNCj4gKwlbODJdID0g
eyAiQXBhbGlzIGlNWDZEIDUxMk1CIizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVEFSR0VUX0lTX0VOQUJMRUQoQVBBTElTX0lNWDYpwqDCoMKgwqAgfSwNCj4gKwlbODNdID0g
eyAiQXBhbGlzIGlNWDZRIDFHQiIswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBUQVJHRVRfSVNfRU5BQkxFRChBUEFMSVNfSU1YNinCoMKgwqDCoCB9LA0KPiArCVs4NF0g
PSB7ICJBcGFsaXMgaU1YNkQgMUdCIElUIizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFRBUkdFVF9JU19FTkFCTEVEKEFQQUxJU19JTVg2KcKgwqDCoMKgIH0sDQo+ICsJWzg1XSA9
IHsgIkFwYWxpcyBpTVg2USAyR0IgSVQiLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVEFSR0VUX0lTX0VOQUJMRUQoQVBBTElTX0lNWDYpwqDCoMKgwqAgfSwNCj4gwqB9Ow0KPiDC
oA0KPiDCoHN0cnVjdCBwaWQ0bGlzdCB7DQo+IGRpZmYgLS1naXQgYS9ib2FyZC90b3JhZGV4L2Nv
bW1vbi90ZHgtY2ZnLWJsb2NrLmggYi9ib2FyZC90b3JhZGV4L2NvbW1vbi90ZHgtY2ZnLWJsb2Nr
LmgNCj4gaW5kZXggZWE1OGJkNDNiMTcuLmI3ODM1MzdjZTc2IDEwMDY0NA0KPiAtLS0gYS9ib2Fy
ZC90b3JhZGV4L2NvbW1vbi90ZHgtY2ZnLWJsb2NrLmgNCj4gKysrIGIvYm9hcmQvdG9yYWRleC9j
b21tb24vdGR4LWNmZy1ibG9jay5oDQo+IEBAIC0xMDIsNiArMTAyLDE1IEBAIGVudW0gew0KPiDC
oAlWRVJESU5fQU02MkRfMUdfSVQsDQo+IMKgCVZFUkRJTl9BTTYyRF8xR19XSUZJX0JUX0lULCAv
KiA3NSAqLw0KPiDCoAlWRVJESU5fQU02MlFfMkdfV0lGSV9CVF9JVCwNCj4gKwlDT0xJQlJJX0lN
WDZTX05PV0lOQ0UsDQo+ICsJQ09MSUJSSV9JTVg2U19JVF9OT1dJTkNFLA0KPiArCUNPTElCUklf
SU1YNkRMX05PV0lOQ0UsDQo+ICsJQ09MSUJSSV9JTVg2RExfSVRfTk9XSU5DRSwgLyogODAgKi8N
Cj4gKwlDT0xJQlJJX0lNWDdEX05PV0lOQ0UsDQo+ICsJQVBBTElTX0lNWDZEX05PV0lOQ0UsDQo+
ICsJQVBBTElTX0lNWDZRX05PV0lOQ0UsDQo+ICsJQVBBTElTX0lNWDZEX0lUX05PV0lOQ0UsDQo+
ICsJQVBBTElTX0lNWDZRX0lUX05PV0lOQ0UsIC8qIDg1ICovDQo+IMKgfTsNCj4gwqANCj4gwqBl
bnVtIHsNCg==

