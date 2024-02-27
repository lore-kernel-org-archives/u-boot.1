Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363D2C54E49
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869518806A;
	Tue, 27 Feb 2024 17:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="c+u6f6Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B82C87969; Tue, 27 Feb 2024 17:19:04 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D302587D8A
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1709050740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xa1kSETWH2/2nGY2gS2SZbs0XMiEki29pXbWnrJ0LCM=;
 b=c+u6f6Pve+y9vrrPpXe9uoHpaw71ahuT9+2jkI0qDbmhFbNBNDBg/5Uua0KkT6fWfJZUPM
 aOnHsugMfeNJAq5pabffY1VBcj2RSgYd1VVXPpyDoVBiHddBcaGUR8xkPJYP59Vby/VJGP
 dsV8yrV5WEjnzseZK24frqUnfP+jKkQ=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-6gLEiG-9P3CI7LY1M2GBPw-1; Tue, 27 Feb 2024 17:18:58 +0100
X-MC-Unique: 6gLEiG-9P3CI7LY1M2GBPw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0749.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:50::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 16:18:55 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6%5]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 16:18:55 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "seanga2@gmail.com" <seanga2@gmail.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, "afd@ti.com"
 <afd@ti.com>, "christianshewitt@gmail.com" <christianshewitt@gmail.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "naoki@radxa.com" <naoki@radxa.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "bb@ti.com" <bb@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "b-kapoor@ti.com" <b-kapoor@ti.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "n-francis@ti.com" <n-francis@ti.com>, "christian.gmeiner@gmail.com"
 <christian.gmeiner@gmail.com>, "mr.bossman075@gmail.com"
 <mr.bossman075@gmail.com>, "marex@denx.de" <marex@denx.de>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "lukma@denx.de" <lukma@denx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "sabiya.d@ti.com"
 <sabiya.d@ti.com>, "nm@ti.com" <nm@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "trini@konsulko.com" <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "cnsztl@gmail.com" <cnsztl@gmail.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v10 12/15] arm: dts: Introduce am69-sk u-boot dts files
Thread-Topic: [PATCH v10 12/15] arm: dts: Introduce am69-sk u-boot dts files
Thread-Index: AQHaZpZiEm33n5qL9kS6YwBBFyhIdrEeZCMA
Date: Tue, 27 Feb 2024 16:18:55 +0000
Message-ID: <0498255bedaef533afb71d852fe426a0d8a7d80b.camel@toradex.com>
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <20240223202153.3756094-13-a-nandan@ti.com>
In-Reply-To: <20240223202153.3756094-13-a-nandan@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0749:EE_
x-ms-office365-filtering-correlation-id: e72f6287-097e-4dc1-7709-08dc37afcb69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 6TTpQtzU+P9LIfPNZK4IZr9juiyELQGNE6AqSrjxhXvQOZFlwOl/dhXhDy/t7R0P6Fg1w6LzaYHR1ewa10aUgqRilLJEvGXyWT3MlD+9Edqj4vCbxQzEAR6BIi7dLb9TbHScYjwKwonAG65hjcek4qFPELeyndI/0jRZGFqeVaF6j1wUgSlix3bS25QrCMexbmbyHnmud4Ctbuq1KoPE82wrJ+29I//7ghklXhxcguAZ60SmkTQcEzCmja3ss5bWYGbTjATd3mwfhhXHfCu5HiTUD3BofJ5wJo0BbLke6Y6dQZaYueUguZ2wxat7zEjXSd6JZ9brS3JpJAHJb7ULyIl9ql8EKLbxPVErfpi7gYXbeHFZ5i0D91hKtIKb+0Mn9xdlvQzSs0203J+deRhiUiCRxy261t3jB6acO++XWDHnPIvQ4SAXChcjMyn1w9tbNhSDulncdINNZioIFs9jERerlG5RFU1IO54h/kNNzED4oBSLhWf2lJRaI+gqHnKmeCM8wx/i1c3+wO98nIZfet/qObIgx+LKWK28W4VTKoJGiUtxs5SezzIX55MPtt7QX/tH5FewoxOzLkW+ezQwfoUqp0ligmDrP9KN9Utz0Ix7wSeXwAGR0x9kFio8PBUPAPSP2iAsEi0mL0y0OVku9jg73XKvPFVq6zCZag14BC1V0wPptm1PR8ttk/I9WJKKpxO7vN1O6/TKCrAFamuqeynKxUTTntK5tr+huaBTfsI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009)(921011); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXBhb2plcjNEdWR6dzRWUVBpeU1qa0NQUWdjaHJPeTRUTVJnbEVVenB4UTd3?=
 =?utf-8?B?b3hNaEtseHh3Zk9GZUF5WXR0ZE9sWTFPYTFFNkd0akNERkpTWkkrYkZudkg5?=
 =?utf-8?B?WEhLd1hqb215dlZoZ0wyWUx4OFZxUkhoakFUQnRJM2Q4dDlsZnN1bTRKWklq?=
 =?utf-8?B?OHBxbldkNzZFQ1g0eHJTaGRXUkowRzNSdlgyWkNNSS9Ib3VTRm80WXdyTStq?=
 =?utf-8?B?ekJaVGQrNjRDcDZIZ0hnMGQ1ajBjQXpCVXVmeG9KQU1pdE84ZUczVVYrK1Ez?=
 =?utf-8?B?bUVJcElySXVyb3lydzZIQ0FpMVVpYUhLbVlMOHdwM2lGSGY5aUF2L3Z4TVJ4?=
 =?utf-8?B?ZTNGT1FtWVJLN2VPc2NONENNY2RWdUpvU0o3blprSmFZd1pZQi9iTG1kbzNI?=
 =?utf-8?B?Z2VCL09GaTkwRUdhRldGVytsblp5bENZdUF2QmU4YU0vWDVyclhYNE50ZExu?=
 =?utf-8?B?M0RSVmRlZElkMzJodWdZREhlM0lJY2JQcjZ3em9ZWGdxSlpkcm5yeXdrU3d3?=
 =?utf-8?B?N2dIUHNQdXkrczdDc3QxcTc5dUJ5bWw4WGpKVE9MZmw0cXp5R3VVaGp4bmJU?=
 =?utf-8?B?VCt5VVEyL2VjMG1xWGRTSmFOM1RLSW81WkUxUzd0NkZnRWlIcEQrWDBHbThh?=
 =?utf-8?B?dmg0azdqWnJDdFZVWHViaFJTZmJNcTNpeGFWNzQvREFFYUpNU3A1aithZGxO?=
 =?utf-8?B?UkZuVXBkaXRiVjkwSmJtS25MNVYyWVhKcVRBUTZtTlZibmZEamFwSFp3bUFN?=
 =?utf-8?B?SjRBTFlzREtFWXIwRS9wa2xRbm0yWTBYUFBUYXFlRXVuZlZsemM4RmF0blYw?=
 =?utf-8?B?dmNxb2VNb2JoSTZwZEhFUXJ1dmZoSE11ditCMjRVS01WWUJYS2hYK1ByTUhR?=
 =?utf-8?B?N2Z3Zkg4NktWYnVhbjBMM1JGYlhNQi9DWU91SXhkQU1YbmlhaVF1d2xaSmcv?=
 =?utf-8?B?ZCtHQnVrYkpHYlhqM2tpakxyVnQyeExIWXF3VmdyT1pRSWhKcHZQZlFLZmo1?=
 =?utf-8?B?ampvS3pFMUZnY0N3WTBvWTFINlZqN2k2WTc0VXpsUjQrWHZ1bVh5MGdkU3Rr?=
 =?utf-8?B?Z2dBVWlPYTlYOVA4SVQzMHpJNnRpbDBIaXpvSVAxT25sM1g1YW9vbVY0QzR0?=
 =?utf-8?B?dmgzdUE4c0VLcjNtQ2p1SmJMN3MyZmpkU1I5NlJSNGZHd3pxbkY5cUFpV2N4?=
 =?utf-8?B?T2hJNklXVURiZ1BjRkdsSDgxR0VLR0JKTm5MWEU1Rm5aVE9QclNVNGRPdlZ4?=
 =?utf-8?B?MmR4dlZTc1dmaDFqL01vYUNFY2RHYmVoNTZxTXZVYVdKZDV2bVlIanVkR0Iw?=
 =?utf-8?B?anVxbFdkUkltOTdnS25mdEZnbWdHRU96cTBqTEs3dXI1Z0hzT0dibW96NnJj?=
 =?utf-8?B?LzRONkgrTnBSMnRZTEhKbnFQbVlPVitrb2ZDTVNjeTduNmxWYkx2b0dXU2l5?=
 =?utf-8?B?UVdYOUN3ZFpKZEorWEs1SER0dFhRcXc0d2h2bkpaRjY2MkpmNTlEQnNvbVV1?=
 =?utf-8?B?ZlRFQ25YdnFsbHhpWUJPYWZPQlNaWXlCK053VXRHemgvLzZjbWF3Z1BSQW5q?=
 =?utf-8?B?UGNqZVowWk16M3hJaWpRL1JCdGVlUzROUGpNT3JpV0xrMTdVOFZhRStJVW1t?=
 =?utf-8?B?dElOSHBkdmdQYnhTQTY2QmJMcWkvL0IvZEppWHJsN2RxdXpmSmpIOE1SSEdB?=
 =?utf-8?B?RzZkaXBBWUxGQ3FsZU1mcnNNNmRLTDN0d0dQZU1aNGZGVVFjQStGTXN0YkNL?=
 =?utf-8?B?Y1o2UmFWdWdPdFV1RmZoVjJQdzZ1K0FGT0Q2c0VXR1huRytYVFRnQzRkTGJ0?=
 =?utf-8?B?THRCQWFndzUvN0VXV2lCN3dPSHFkNFRzOUxMZTRhVGVXMEMwcVI0MnZ0em1s?=
 =?utf-8?B?STR1aFd1NkhVSXZEa0NYeU95U2lDOVdOQnZCcWlWMWl0Y1ZFc1k0YVBKZmg0?=
 =?utf-8?B?emdhdU9YTklmR002d3FBdWQ0NXdCRGxRVzhRbWNINW9KS0RIQ1dxT0F4ek5k?=
 =?utf-8?B?TUliZ1EwVnJaTk1ZV3l2UmVNRVZqZkZJM3lTbTU2YTdKdzE2MklZbGhwc2Ni?=
 =?utf-8?B?L29LbHAzZXk2L1ZXNDkybHcySkl1NEMzRzRoS3lmM3EraUpuSzJKa3RLMVBS?=
 =?utf-8?B?cEU3dU5NWTNmZXZPdWp3OFIzQlFwQmhhTjUwa0ZGc1JsdWRDRmF4TS83Z09B?=
 =?utf-8?B?UHc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e72f6287-097e-4dc1-7709-08dc37afcb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 16:18:55.1129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKQn37YqvBP8fAVpQm0PbUks3iM0OO5Rf/jOBkcdr85HvYaf8ygM2Et7Tvb2xp9XBRr69CdY2w8YzJ946RlZr01ur9igiyQjVkWUupQvFpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0749
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <55D602D37BEE1745991B40AEA943AF34@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Tue, 27 Feb 2024 17:25:20 +0100
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

SGkgQXB1cnZhDQoNCk9uIFNhdCwgMjAyNC0wMi0yNCBhdCAwMTo1MSArMDUzMCwgQXB1cnZhIE5h
bmRhbiB3cm90ZToNCj4gRnJvbTogRGFzbmF2aXMgU2FiaXlhIDxzYWJpeWEuZEB0aS5jb20+DQo+
IA0KPiBJbnRyb2R1Y2UgdGhlIGJhc2UgZHRzIGZpbGVzIG5lZWRlZCBmb3IgdS1ib290IG9yIHRv
IGF1Z21lbnQgdGhlIGxpbnV4DQo+IGR0YnMgZm9yIHVzZSBpbiB0aGUgdS1ib290LXNwbCBhbmQg
dS1ib290IGJpbmFyaWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFzbmF2aXMgU2FiaXlhIDxz
YWJpeWEuZEB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFwdXJ2YSBOYW5kYW4gPGEtbmFuZGFu
QHRpLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC9hcm0vZHRzL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCAzICstDQo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjktcjUtc2su
ZHRzwqDCoMKgwqDCoCB8IDEwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgYXJj
aC9hcm0vZHRzL2szLWFtNjktc2stdS1ib290LmR0c2kgfMKgIDU0ICsrKysrKysrKysrKysrDQo+
IMKgYm9hcmQvdGkvajc4NHM0L01BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsr
DQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxNjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvazMtYW02OS1yNS1zay5kdHMNCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL2szLWFtNjktc2stdS1ib290LmR0c2kN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9kdHMv
TWFrZWZpbGUNCj4gaW5kZXggZTQ4NDExMmRkN2MuLmUzYTQ3ZDA1NWIwIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybS9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vZHRzL01ha2VmaWxlDQo+
IEBAIC0xNDEzLDcgKzE0MTMsOCBAQCBkdGItJChDT05GSUdfU09DX0szX0o3MjFTMikgKz0gazMt
YW02OC1zay1iYXNlLWJvYXJkLmR0YlwNCj4gwqAJCQnCoMKgwqDCoMKgwqAgazMtajcyMXMyLWNv
bW1vbi1wcm9jLWJvYXJkLmR0YlwNCj4gwqAJCQnCoMKgwqDCoMKgwqAgazMtajcyMXMyLXI1LWNv
bW1vbi1wcm9jLWJvYXJkLmR0Yg0KPiDCoA0KPiAtZHRiLSQoQ09ORklHX1NPQ19LM19KNzg0UzQp
ICs9IGszLWo3ODRzNC1yNS1ldm0uZHRiDQo+ICtkdGItJChDT05GSUdfU09DX0szX0o3ODRTNCkg
Kz0gazMtYW02OS1yNS1zay5kdGIgXA0KPiArCQkJwqDCoMKgwqDCoMKgIGszLWo3ODRzNC1yNS1l
dm0uZHRiDQo+IMKgDQo+IMKgZHRiLSQoQ09ORklHX1NPQ19LM19BTTY0MikgKz0gazMtYW02NDIt
ZXZtLmR0YiBcDQo+IMKgCQkJwqDCoMKgwqDCoCBrMy1hbTY0Mi1yNS1ldm0uZHRiIFwNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9rMy1hbTY5LXI1LXNrLmR0cyBiL2FyY2gvYXJtL2R0cy9r
My1hbTY5LXI1LXNrLmR0cw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMC4uZjE3N2Y1NjM1MjcNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9hcmNoL2FybS9kdHMv
azMtYW02OS1yNS1zay5kdHMNCj4gQEAgLTAsMCArMSwxMDYgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MjItMjAyMyBUZXhhcyBJbnN0cnVtZW50cyBJbmNvcnBvcmF0ZWQgLSBodHRwczovL3d3dy50aS5j
b20vDQo+ICsgKi8NCj4gKw0KPiArL2R0cy12MS87DQo+ICsNCj4gKyNpbmNsdWRlICJrMy1hbTY5
LXNrLmR0cyINCj4gKyNpbmNsdWRlICJrMy1qNzg0czQtZGRyLWV2bS1scDQtNDI2Ni5kdHNpIg0K
PiArI2luY2x1ZGUgImszLWo3ODRzNC1kZHIuZHRzaSINCj4gKyNpbmNsdWRlICJrMy1hbTY5LXNr
LXUtYm9vdC5kdHNpIg0KPiArDQo+ICsvIHsNCj4gKwljaG9zZW4gew0KPiArCQl0aWNrLXRpbWVy
ID0gJm1jdV90aW1lcjA7DQo+ICsJfTsNCj4gKw0KPiArCWFsaWFzZXMgew0KPiArCQlyZW1vdGVw
cm9jMCA9ICZzeXNjdHJsZXI7DQo+ICsJCXJlbW90ZXByb2MxID0gJmE3Ml8wOw0KPiArCX07DQo+
ICsNCj4gKwlhNzJfMDogYTcyQDAgew0KPiArCQljb21wYXRpYmxlID0gInRpLGFtNjU0LXJwcm9j
IjsNCj4gKwkJcmVnID0gPDB4MCAweDAwYTkwMDAwIDB4MCAweDEwPjsNCj4gKwkJcG93ZXItZG9t
YWlucyA9IDwmazNfcGRzIDYxIFRJX1NDSV9QRF9FWENMVVNJVkU+LA0KPiArCQkJCTwmazNfcGRz
IDIwMiBUSV9TQ0lfUERfRVhDTFVTSVZFPjsNCj4gKwkJcmVzZXRzID0gPCZrM19yZXNldCAyMDIg
MD47DQo+ICsJCWNsb2NrcyA9IDwmazNfY2xrcyA2MSAwPjsNCj4gKwkJYXNzaWduZWQtY2xvY2tz
ID0gPCZrM19jbGtzIDYxIDA+LCA8JmszX2Nsa3MgMjAyIDA+Ow0KPiArCQlhc3NpZ25lZC1jbG9j
ay1wYXJlbnRzID0gPCZrM19jbGtzIDYxIDI+Ow0KPiArCQlhc3NpZ25lZC1jbG9jay1yYXRlcyA9
IDwyMDAwMDAwMDA+LCA8MjAwMDAwMDAwMD47DQo+ICsJCXRpLHNjaSA9IDwmc21zPjsNCj4gKwkJ
dGksc2NpLXByb2MtaWQgPSA8MzI+Ow0KPiArCQl0aSxzY2ktaG9zdC1pZCA9IDwxMD47DQo+ICsJ
CWJvb3RwaC1wcmUtcmFtOw0KPiArCX07DQo+ICsNCj4gKwlkbV90aWZzOiBkbS10aWZzIHsNCj4g
KwkJY29tcGF0aWJsZSA9ICJ0aSxqNzIxZS1kbS1zY2kiOw0KPiArCQl0aSxob3N0LWlkID0gPDM+
Ow0KPiArCQl0aSxzZWN1cmUtaG9zdDsNCj4gKwkJbWJveC1uYW1lcyA9ICJyeCIsICJ0eCI7DQo+
ICsJCW1ib3hlcz0gPCZzZWN1cmVfcHJveHlfbWN1IDIxPiwgPCZzZWN1cmVfcHJveHlfbWN1IDIz
PjsNCj4gKwkJYm9vdHBoLXByZS1yYW07DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZtY3VfdGlt
ZXIwIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICsJY2xvY2stZnJlcXVlbmN5ID0gPDI1MDAw
MDAwMD47DQo+ICsJYm9vdHBoLXByZS1yYW07DQo+ICt9Ow0KPiArDQo+ICsmc2VjdXJlX3Byb3h5
X3NhMyB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArCWJvb3RwaC1wcmUtcmFtOw0KPiArfTsN
Cj4gKw0KPiArJnNlY3VyZV9wcm94eV9tY3Ugew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKwli
b290cGgtcHJlLXJhbTsNCj4gK307DQo+ICsNCj4gKyZjYmFzc19tY3Vfd2FrZXVwIHsNCj4gKwlz
eXNjdHJsZXI6IHN5c2N0cmxlciB7DQo+ICsJCWNvbXBhdGlibGUgPSAidGksYW02NTQtc3lzdGVt
LWNvbnRyb2xsZXIiOw0KPiArCQltYm94ZXM9IDwmc2VjdXJlX3Byb3h5X21jdSA0PiwNCj4gKwkJ
CTwmc2VjdXJlX3Byb3h5X21jdSA1PiwNCj4gKwkJCTwmc2VjdXJlX3Byb3h5X3NhMyA1PjsNCj4g
KwkJbWJveC1uYW1lcyA9ICJ0eCIsICJyeCIsICJib290X25vdGlmeSI7DQo+ICsJCWJvb3RwaC1w
cmUtcmFtOw0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmc21zIHsNCj4gKwltYm94ZXM9IDwmc2Vj
dXJlX3Byb3h5X21jdSA4PiwgPCZzZWN1cmVfcHJveHlfbWN1IDY+LCA8JnNlY3VyZV9wcm94eV9t
Y3UgNT47DQo+ICsJbWJveC1uYW1lcyA9ICJ0eCIsICJyeCIsICJub3RpZnkiOw0KPiArCXRpLGhv
c3QtaWQgPSA8ND47DQo+ICsJdGksc2VjdXJlLWhvc3Q7DQo+ICsJYm9vdHBoLXByZS1yYW07DQo+
ICt9Ow0KPiArDQo+ICsvKiBXS1VQIFVBUlQwIGlzIHVzZWQgZm9yIERNIGZpcm13YXJlIGxvZ3Mg
Ki8NCj4gKyZ3a3VwX3VhcnQwIHsNCj4gKwlib290cGgtcHJlLXJhbTsNCj4gKwlzdGF0dXMgPSAi
b2theSI7DQo+ICt9Ow0KPiArDQo+ICsmb3NwaTAgew0KPiArCXJlZyA9IDwweDAgMHg0NzA0MDAw
MCAweDAgMHgxMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MCAweDUwMDAwMDAwIDB4MCAweDgwMDAw
MDA+Ow0KPiArfTsNCj4gKw0KPiArJm9zcGkxIHsNCj4gKwlyZWcgPSA8MHgwIDB4NDcwNTAwMDAg
MHgwIDB4MTAwPiwNCj4gKwnCoMKgwqDCoMKgIDwweDAgMHg1ODAwMDAwMCAweDAgMHg4MDAwMDAw
PjsNCj4gK307DQo+ICsNCj4gKyZtY3VfcmluZ2FjYyB7DQo+ICsJdGksc2NpID0gPCZkbV90aWZz
PjsNCj4gK307DQo+ICsNCj4gKyZtY3VfdWRtYXAgew0KPiArCXRpLHNjaSA9IDwmZG1fdGlmcz47
DQo+ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2szLWFtNjktc2stdS1ib290LmR0
c2kgYi9hcmNoL2FybS9kdHMvazMtYW02OS1zay11LWJvb3QuZHRzaQ0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uYmVkMzMwZTZkNGUNCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9hcmNoL2FybS9kdHMvazMtYW02OS1zay11LWJvb3QuZHRzaQ0KPiBAQCAtMCww
ICsxLDU0IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+
ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDIyLTIwMjMgVGV4YXMgSW5zdHJ1bWVudHMgSW5j
b3Jwb3JhdGVkIC0gaHR0cHM6Ly93d3cudGkuY29tLw0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRl
ICJrMy1qNzg0czQtYmlubWFuLmR0c2kiDQo+ICsNCj4gKy8gew0KPiArCW1lbW9yeUA4MDAwMDAw
MCB7DQo+ICsJCWJvb3RwaC1hbGw7DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZtY3VfdWRtYXAg
ew0KPiArCXJlZyA9wqDCoCA8MHgwIDB4Mjg1YzAwMDAgMHgwIDB4MTAwPiwNCj4gKwkJPDB4MCAw
eDI4NGMwMDAwIDB4MCAweDQwMDA+LA0KPiArCQk8MHgwIDB4MmE4MDAwMDAgMHgwIDB4NDAwMDA+
LA0KPiArCQk8MHgwIDB4Mjg0YTAwMDAgMHgwIDB4NDAwMD4sDQo+ICsJCTwweDAgMHgyYWEwMDAw
MCAweDAgMHg0MDAwMD4sDQo+ICsJCTwweDAgMHgyODQwMDAwMCAweDAgMHgyMDAwPjsNCj4gKwly
ZWctbmFtZXMgPSAiZ2NmZyIsICJyY2hhbiIsICJyY2hhbnJ0IiwgInRjaGFuIiwNCj4gKwkJwqDC
oMKgICJ0Y2hhbnJ0IiwgInJmbG93IjsNCj4gKwlib290cGgtcHJlLXJhbTsNCj4gK307DQo+ICsN
Cj4gKyZzbXMgew0KPiArCWszX3N5c3Jlc2V0OiBzeXNyZXNldC1jb250cm9sbGVyIHsNCj4gKwkJ
Y29tcGF0aWJsZSA9ICJ0aSxzY2ktc3lzcmVzZXQiOw0KPiArCQlib290cGgtcHJlLXJhbTsNCj4g
Kwl9Ow0KPiArfTsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19UQVJHRVRfSjc4NFM0X0E3Ml9FVk0N
Cj4gKw0KPiArI2RlZmluZSBTUExfQU02OV9TS19EVEIgInNwbC9kdHMvdGkvazMtYW02OS1zay5k
dGIiDQoNCkRpZCBJIG1pc3MgYW55dGhpbmcgYW5kIHRoZSBkZXZpY2UgdHJlZXMgYXJlIG5vdyBy
ZWFsbHkgYWxzbyBpbiBhIHZlbmRvciBmb2xkZXIgaW4gVS1Cb290IGFzIHdlbGw/DQoNCj4gKyNk
ZWZpbmUgQU02OV9TS19EVEIgInUtYm9vdC5kdGIiDQo+ICsNCj4gKyZzcGxfajc4NHM0X2V2bV9k
dGIgew0KPiArCWZpbGVuYW1lID0gU1BMX0FNNjlfU0tfRFRCOw0KPiArfTsNCj4gKw0KPiArJmo3
ODRzNF9ldm1fZHRiIHsNCj4gKwlmaWxlbmFtZSA9IEFNNjlfU0tfRFRCOw0KPiArfTsNCj4gKw0K
PiArJnNwbF9qNzg0czRfZXZtX2R0Yl91bnNpZ25lZCB7DQo+ICsJZmlsZW5hbWUgPSBTUExfQU02
OV9TS19EVEI7DQo+ICt9Ow0KPiArDQo+ICsmajc4NHM0X2V2bV9kdGJfdW5zaWduZWQgew0KPiAr
CWZpbGVuYW1lID0gQU02OV9TS19EVEI7DQo+ICt9Ow0KPiArDQo+ICsjZW5kaWYNCj4gZGlmZiAt
LWdpdCBhL2JvYXJkL3RpL2o3ODRzNC9NQUlOVEFJTkVSUyBiL2JvYXJkL3RpL2o3ODRzNC9NQUlO
VEFJTkVSUw0KPiBpbmRleCBmZjAwY2M2MDg2OC4uOGIwM2E3YWRiMWUgMTAwNjQ0DQo+IC0tLSBh
L2JvYXJkL3RpL2o3ODRzNC9NQUlOVEFJTkVSUw0KPiArKysgYi9ib2FyZC90aS9qNzg0czQvTUFJ
TlRBSU5FUlMNCj4gQEAgLTgsMyArOCw5IEBAIEY6CWFyY2gvYXJtL2R0cy9rMy1qNzg0czQtZXZt
LXUtYm9vdC5kdHNpDQo+IMKgRjoJYXJjaC9hcm0vZHRzL2szLWo3ODRzNC1yNS1ldm0uZHRzDQo+
IMKgRjoJYXJjaC9hcm0vZHRzL2szLWo3ODRzNC1kZHIuZHRzaQ0KPiDCoEY6CWFyY2gvYXJtL2R0
cy9rMy1qNzg0czQtZGRyLWV2bS1scDQtNDI2Ni5kdHNpDQo+ICsNCj4gK0FNNjkgU0sgQk9BUkQN
Cj4gK006CUFwdXJ2YSBOYW5kYW4gPGEtbmFuZGFuQHRpLmNvbT4NCj4gK1M6CU1haW50YWluZWQN
Cj4gK0Y6CWFyY2gvYXJtL2R0cy9rMy1hbTY5LXNrLXUtYm9vdC5kdHNpDQo+ICtGOglhcmNoL2Fy
bS9kdHMvazMtYW02OS1yNS1zay5kdHMNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

