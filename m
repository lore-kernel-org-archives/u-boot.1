Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11186C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1560288168;
	Fri, 19 Jul 2024 03:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AFB88113; Fri, 19 Jul 2024 03:31:48 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F2588168
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVZwByLkjQNzbBcaZ/04+MS09a/OC0o93JpR3wvHJL+MmSwpyx6yrZ7laC6a9q+liI1+hkzOwuy9BVzyo2VF2kjJlgVizMYSTE2lKXz83sk/imumwbV8jAlfVS/QpB08pI2eiKO8g1geYEyZD/o1mLsVcIfeB0InHnuoCdL88CEiqFop//OgbPaqCusgXFvq63ehUum6a30fI4SCDDZUOj1dS9ELugLMcdE304b68JIF+RJiN3M+cluKV+LJbjALiEdTgh0mWgfQqBP4n0LuAuzHB3vS15r/PSK5/H+zqBjulGHMA68UrVe7K2NUTukiolkQwCXozpewTCwRPDAIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Sxa19OZxJTB9k9ukW9YjGJOoiIwzR2DnldlKLulpE=;
 b=I7XwV0b8K46cy7C37m9VWlM1TVQYpWZ76GRKxDKXx/2vnlQjmb8J9zuykU0lvv/01WZOrNEjvd+M0a9PQOByS/QHCNL39k1vVFxNvi+b5y7nDZfq9DLyxXw6IHHsOIW2qymjFaw8rJrmRyyE3zx5DXssg+XPMyISmFJHjIVsuL0EP6n8IPH1EBAxM5FZd6Pbr8otPNxqXO5gLAbbPJ98JVk1sNOwlFDZ3Vx0Ety/Xej26zRK3mp/2xMEJnLdpgagWgOa1VuCocfcHm03KmEJn33KuKll3nDweJGK2kqmOkeVtcNV9MW/BzsXpCDk0jBKLnVz8zq9T+BMid5kHXf9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0558.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:31:41 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:31:41 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, E Shattow <lucent@gmail.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC83XSBBZGQgU3RhcmZpdmUgSkg3MTEwIENh?=
 =?utf-8?Q?dence_USB_driver?=
Thread-Topic: [PATCH v2 0/7] Add Starfive JH7110 Cadence USB driver
Thread-Index: AQHazdYPLfQISprNP0SqG3gNc0bDZLHmj54AgBbLHsA=
Date: Fri, 19 Jul 2024 01:31:41 +0000
Message-ID: <SHXPR01MB086343E54A42A515E964795DE6AD2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
In-Reply-To: <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0558:EE_
x-ms-office365-filtering-correlation-id: 0091bd36-c92d-4412-f723-08dca7928a97
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: w7HqcTRTi5nZ+XeIjn8P4zjwqMipaSjFp60gKCMDOFZTm3fGj6QBkE/wCgVMXTw+/LIe5LO5GDHHWLkLuN2hiauMOapp9+vb0n9Op3OeYUjOwDH1H8dx5/whFbiugnbVKT1Kbjvmt376rdAhB4ZKlrT+8JqV/BoU4UAd/DzV8qiWcpaGUvzx085z/hJRnMY/97y/GTqgRv33dJyPOZBZAgaDbcQxX98bQaau9BZ5/kcpNc/vRRTQ84b2bLDYlbnAwDwVkEBb6RQArAkObZZztkrJFCo1xuwdN2dcGs02jExKFMtWm1oC/rm9eNVv3F4nKFn4RvdA9WcxH1Eqm4m5SibOb0213LeqbL46kBViUYCCyVINtvR7e9r7eEeMY7uSdFFlWRoakZdRalwCe2SlicJLu53WEWP4DwhNSuiZhG86ZGH9s0dOmYjKUa8zPb+kBE5vfc9K9zLfbbyaPAdZPdUGiMd8+y+6ilfrQQMhEQMbR+Yfjqn6YC2fVoMm7AhLiDeV8oj7/D5bSKuaIcem7bB21EHMB+A2js5p1YWzDev33RhBgrzMrYI7Az1xSp+9XRW0yHZ2wOXen1SMSXYSaKNs1llg+XK/p5fmiBu9jEKiDAXC99TIzzu7QfwXjoK7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21mTEJ6VUQ5Z0ZDY2hlYkZVUitsRm1iTGlNQVFjNElKbVd6cHV6by9TbDJY?=
 =?utf-8?B?NnJOb3g4L05IOVRQeVAzOThWQzljM3ZCTnd0WWZiTGdGUC9VeFRlY0tNeUZI?=
 =?utf-8?B?dVNlL3JXNDBkRTJTSDNZSzFGTkFNSmhSR21UR3lpdVE3MTh2R3Jwak80UjJs?=
 =?utf-8?B?UVVselp3bkpTenBJVHd6VmVweDllRWNmZk5uaHg5bkJQRUNvOWhjdCsvaWRp?=
 =?utf-8?B?U1ZiazVJcHhWcXVaL01YMS9UaDQ5MG5uV25qeXRmUHlYNFRDWldMK0l4dGdj?=
 =?utf-8?B?cy81WWdqakFBQ3gyajBnOFR0ODJXcWRRMzgxUFR2WmdiVXpnaG1MYXZUZUsx?=
 =?utf-8?B?L3Zqci9RWFhISXVVUWtzVjdwWlgzVTRvNm9adFZ0SzUrd21KQ29tTExwdk1R?=
 =?utf-8?B?WElnb2VOTS9YZEVRYXNwS2VjZDRyaGdiVmdVS05VbkZRSk5ZUUFyZFFEbGlm?=
 =?utf-8?B?SWVDbGFVbTIwd1paZEEwRGpHdnNMdmZVWThxTTJ0Z1daeHEzblRXbWNyd2pR?=
 =?utf-8?B?VjRublVYUTdqc0kzUVNMWk5NajBaRTFXRUxraHhUdkdUcmZ0QWZ3eDdCQmZy?=
 =?utf-8?B?U3dvczd0cWgrQ3ZtTXRJTE1XWjBRUVFoblQ0SUpPYS91ZjVMWjY3R0QvRHRq?=
 =?utf-8?B?MDZvRVNNdHpBQjBTWnJFcnA1VDZkQW1jME9SOE5NRllUVWw1V3Q4eElOU29Z?=
 =?utf-8?B?dSt0Q1IxdHdJcXBudXpOVUM1TjFYQ1kvVjBQVEJ1SElabGpaUEwxWFlXOEdm?=
 =?utf-8?B?cGxWQXE4WGYvUW1Ca3I4SnFzbG9pRTU1UllJREpJYUtma1hBdVg1QTJXM2M3?=
 =?utf-8?B?M1dMamhUM2FyMHJUU1c3UjAzM24rc05USklNa21UNXo3UnB5bVpSYWFsNFMr?=
 =?utf-8?B?REdvTkc2cU9pckRvaEhHNEpyZnEwdXJwNkRRTlZnOWwraUkwNGU2MlVUUXBm?=
 =?utf-8?B?VHVtWGo1Rk9sZ2RCOHZ3WmxiOUt2aVhCWUVRb1daRnB4WXpaTUtmZ3FsTzVW?=
 =?utf-8?B?VXVZQ00vSEh0azlTZmY4eVBBbjNYWFlsTGwyck1nb2h3MkxHeGhnMEg2K1lI?=
 =?utf-8?B?a1BCcG10ZTNTc2hBOCttSGg1Z1VFc3ZDSUxIRVVKMzhFMmhWdVVhNFdOSERw?=
 =?utf-8?B?cnBOM2VjTVlhTUxXYWVCOFphTmVVQWxrcWZpOFlhZk5qZmtJVm1FZUg4RFAx?=
 =?utf-8?B?eEVyQUx4K2xIVXVIakNtRnBlVnRCOW5TZUhWdUZyRjBDaTEwdFN5aFBnRVpw?=
 =?utf-8?B?aVF0aEUyS0lWa3pPem0rRjdwalpzNS9WTTMrK0gyNElwRXRZNFNKUktZMDRw?=
 =?utf-8?B?THdjeHlNbWp6K2w1M3FsS2IvVmhUN29GL3FWeGpxVk5LRFRXbDNtWXNHekNr?=
 =?utf-8?B?NnphRzBaOTlwanRUOWR1a2R6NzkzRDhodHRHQW1Ia2JyVkFSYXhibS9BemhG?=
 =?utf-8?B?NHMvWlA3UmVlVk10a0hObjY2eGVmLyt1NmFFZW81dENKVXJJSFpTemRMRFZz?=
 =?utf-8?B?N0NMaVVYWmUvK3VHTzRFdVdRbUhramRYZWR1bzRyMzN3UFlIeFZINU1hZURJ?=
 =?utf-8?B?ejFkMnNWUHhKdnNjd212SlNjejdVaTlOWHdyVnZ3VGdHS2p4dC9EMHcxQ3lB?=
 =?utf-8?B?RGQxdkhCeFE5Ti9kY25FaThoemZpT0NkNHlrSDZBTW1BQ1pEK1FRR2RkYTVH?=
 =?utf-8?B?TWdSejRzSkFRTG1QR05IVkcwUE9VVDBFQThaZFNNMWh4NEpESGNSZVdzTzNm?=
 =?utf-8?B?YVlnVStJaFdnMXJ6OXAwZ04zRlJWSG9qTWZ4enZ2NjhGaDJRQ1laS3R1ZXZE?=
 =?utf-8?B?dlhET3E1QW92QnpnK3NjMWpMcEZZVVZmeUtLRDF4ZG5rZnF4dms2d25SOTVn?=
 =?utf-8?B?Y3F4TTRHNTlGeFVKc3dhb1NDVnBSK09aeElWSUROa2ZNaDV4SCt1YUJ1UUNx?=
 =?utf-8?B?M3QrN3VxV05GSVFMS0tCTFVYVmpSMFZXektqbUVhR2oxejdqeTZuNnJpMHFT?=
 =?utf-8?B?S2dObmg5QVRISjdTTmRlWGVDUGRDMWt4U1E1N29OcVQ4TUtVLytMV0s0N3F2?=
 =?utf-8?B?UlZSN0RtcTVrV0puMENpNGlDNzlzTnU1cisweDJQK2tHWGtwNzVpdGdPQUlJ?=
 =?utf-8?Q?UnHJF5yl2CNUBX8WbL5miLN0o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0091bd36-c92d-4412-f723-08dca7928a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 01:31:41.1648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNleKHo+igPpx5xmTZ5ngVdt5OEh1OWJY/Up3AKZkRzRw2PaPj9CZKHY1SrLb+7OsxeGtL6PS2n7ahkHMOCbdUMjorG86h+0PZYtqYIQ3Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0558
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

DQo+IA0KPiBPbiA3LzQvMjQgMDc6NTAsIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gQWRkIFN0YXJm
aXZlIEpINzExMCBDYWRlbmNlIFVTQiBkcml2ZXIgYW5kIHJlbGF0ZWQgUEhZIGRyaXZlci4NCj4g
PiBTbyB0aGUgY29kZXMgY2FuIGJlIHVzZWQgaW4gdmlzaW9uZml2ZTIgYW5kIHN0YXI2NCA3MTEw
IGJvYXJkLg0KPiA+DQo+ID4gVGhlIGRyaXZlciBpcyBhbG1vc3QgdGhlIHNhbWUgd2l0aCBrZXJu
ZWwgZHJpdmVyLg0KPiA+DQo+ID4gVGVzdCB3aXRoIFN0YXI2NCBKSDcxMTAgYm9hcmQgVVNCIDMu
MCArIFVTQiAyLjAgaG9zdC4NCj4gPiBUaGUgY29kZSBjYW4gd29yay4NCj4gPg0KPiA+IC0gU3Rh
cjY0IHVzaW5nIFVTQiAzLjAgYW5kIFVTQiAyLjAgaG9zdCBtdXN0IGFkZCBiZWxvdyBib2FyZCBk
dHMgc2V0dGluZy4NCj4gDQo+IERvZXMgdGhpcyBtZWFuIGEgZnV0dXJlIHBhdGNoIGZvciBzcGxf
ZmR0X2ZpeHVwX3N0YXI2NCgpIGlzIG5lZWRlZD8NCj4gDQo+IERpZCB5b3UgYWxzbyBoYXZlIGEg
bG9vayBhdCB0aGUgVVNCIG9uIHRoZSBNaWxrIFYgTWFycyBDTT8NCj4gDQo+IEJlc3QgcmVnYXJk
cw0KPiANCj4gSGVpbnJpY2gNCj4gDQpNYXliZSB0aGUgVVNCIHBpbiBzZXR0aW5nIGNhbiBiZSBh
ZGRlZCB0byBkdHMuIEJ1dCBWRjIgZG8gbm90IGNvbnRhaW4NClVTQiB2YnVzIHBpbiBkZWZhdXQg
c2V0dGluZy4NCj4gPg0KPiA+IDEuIHVzYiBwaW4gc2V0dGluZw0KPiA+IAl1c2JfcGluczogdXNi
MC0wIHsNCj4gPiAJCWRyaXZlci12YnVzLXBpbiB7DQo+ID4gCQkJcGlubXV4ID0gPEdQSU9NVVgo
MjUsIEdQT1VUX1NZU19VU0JfRFJJVkVfVkJVUywNCj4gPiAJCQkJCSAgR1BPRU5fRU5BQkxFLA0K
PiA+IAkJCQkJICBHUElfTk9ORSk+Ow0KPiA+IAkJCWJpYXMtZGlzYWJsZTsNCj4gPiAJCQlpbnB1
dC1kaXNhYmxlOw0KPiA+IAkJCWlucHV0LXNjaG1pdHQtZGlzYWJsZTsNCj4gPiAJCQlzbGV3LXJh
dGUgPSA8MD47DQo+ID4gCQl9Ow0KPiA+IAl9Ow0KPiA+DQo+ID4gMi4gcmVsYXRlZCBkdHMgbm9k
ZSBzZXR0aW5nLg0KPiA+ICZwY2llMCB7DQo+ID4gCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4g
fTsNCj4gPg0KPiA+ICZwY2llcGh5MCB7DQo+ID4gCXN0YXJmaXZlLHN5cy1zeXNjb24gPSA8JnN5
c19zeXNjb24gMHgxOD47DQo+ID4gCXN0YXJmaXZlLHN0Zy1zeXNjb24gPSA8JnN0Z19zeXNjb24g
MHgxNDggMHgxZjQ+Ow0KPiA+IAlzdGF0dXMgPSAib2theSI7DQo+ID4gfTsNCj4gPg0KPiA+ICZ1
c2IwIHsNCj4gPiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAJcGluY3RybC0wID0g
PCZ1c2JfcGlucz47DQo+ID4gCXN0YXR1cyA9ICJva2F5IjsNCj4gPiB9Ow0KPiA+DQo+ID4gJnVz
Yl9jZG5zMyB7DQo+ID4gCXBoeXMgPSA8JnVzYnBoeTA+LCA8JnBjaWVwaHkwPjsNCj4gPiAJcGh5
LW5hbWVzID0gImNkbnMzLHVzYjItcGh5IiwgImNkbnMzLHVzYjMtcGh5IjsNCj4gPiAJZHJfbW9k
ZSA9ICJob3N0IjsNCj4gPiAJc3RhdHVzID0gIm9rYXkiOw0KPiA+IH07DQo+ID4NCj4gPiAtIHBy
ZXZpb3VzIHZlcnNpb24NCj4gPiAgICB2MToNCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQwNTA0MTUwMzU4LjE5NjAwLTEtDQo+IG1pbmRhLmNo
ZW5Ac3RhcmZpdmV0ZWNoLmNvbS8NCj4gPg0KPiA+IC0gcGF0Y2ggZGVzY3JpcHRpb24uDQo+ID4N
Cj4gPiBwYXRjaDE6IEFkZCBzZXQgcGh5IG1vZGUgZnVuY3Rpb24gaW4gY2RuczMgY29yZSBkcml2
ZXINCj4gPiAgICAgICAgICB3aGljaCBpcyB1c2VkIGJ5IFN0YXJmaXZlIEpINzExMC4NCj4gPiBw
YXRjaDItMzogVVNCIGFuZCBQQ0llIDIuMCAodXNiIDMuMCkgUEhZIGRyaXZpZXINCj4gPiBwYXRj
aDQ6IENhZGVuY2UgVVNCIHdyYXBwZXIgZHJpdmVyLg0KPiA+IHBhdGNoNTogQWRkIEpINzExMCBV
U0IgZGVmYXVsdCBvdmVyY3VycmVudCBwaW4uDQo+ID4gcGF0Y2g2LTggZHRzLCBjb25maWcgYW5k
IG1haW50YWluZXJzIHVwZGF0ZS4NCj4gPg0KPiA+IC0gY2hhbmdlOg0KPiA+IAl2MjoNCj4gPiAJ
LSBwYXRjaCAxIE1vdmUgdGhlIGFkZGVkIGNvZGUgdG8gY2RuczNfY29yZV9pbml0X3JvbGUoKS4g
TXVzdA0KPiA+IAkgIHNldCBQSFkgbW9kZSBiZWZvcmUgY2FsbGluZyBjZG5zMyByb2xlIHN0YXJ0
IGZ1bmN0aW9uLg0KPiA+IAktIHBhdGNoIDEtNCBjb3JyZWN0IHRoZSBjb2RlIGZvcm1hdC4oZm9s
bG93IE1hcmVrJ3MgY29tbWVudHMuKQ0KPiA+IAktIHBhdGNoIDIgQWRkIHNldCAxMjVNIGNsb2Nr
IGluIFBIWSBpbml0IGZ1bmN0aW9uLg0KPiA+IAktIEFkZCBuZXcgcGF0Y2g1Lg0KPiA+DQo+ID4g
TWluZGEgQ2hlbiAoOCk6DQo+ID4gICAgdXNiOiBjZG5zMzogU2V0IFVTQiBQSFkgbW9kZSBpbiBj
ZG5zM19jb3JlX2luaXRfcm9sZSgpDQo+ID4gICAgcGh5OiBzdGFyZml2ZTogQWRkIFN0YXJmaXZl
IEpINzExMCBVU0IgMi4wIFBIWSBkcml2ZXINCj4gPiAgICBwaHk6IHN0YXJmaXZlOiBBZGQgU3Rh
cmZpdmUgSkg3MTEwIFBDSWUgMi4wIFBIWSBkcml2ZXINCj4gPiAgICB1c2I6IGNkbnM6IHN0YXJm
aXZlOiBBZGQgY2RucyBVU0IgZHJpdmVyDQo+ID4gICAgcGluY3RybDogc3RhcmZpdmU6IFNldHVw
IFVTQiBkZWZhdWx0IGRpc2FibGUgb3ZlcmN1cnJlbnQgcGluDQo+ID4gICAgY29uZmlnczogc3Rh
cmZpdmU6IEFkZCB2aXNpb25maXZlMiBjYWRlbmNlIFVTQiBjb25maWd1cmF0aW9uDQo+ID4gICAg
ZHRzOiBzdGFyZml2ZTogQWRkIEpINzExMCBDYWRlbmNlIFVTQiBkdHMgbm9kZQ0KPiA+ICAgIE1B
SU5UQUlORVJTOiBVcGRhdGUgU3RhcmZpdmUgdmlzaW9uZml2ZTIgbWFpbnRhaW4gZmlsZXMuDQo+
ID4NCj4gPiAgIC4uLi9kdHMvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICB8
ICAgNSArDQo+ID4gICBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAuZHRzaSAgICAgICAgICAgICAgICAg
ICAgfCAgNTIgKysrKysNCj4gPiAgIGJvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL01BSU5UQUlO
RVJTICAgICAgICB8ICAgMiArDQo+ID4gICBjb25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2Rl
ZmNvbmZpZyAgICAgICAgfCAgIDkgKw0KPiA+ICAgZHJpdmVycy9waHkvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgIGRyaXZlcnMvcGh5L01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBkcml2ZXJzL3BoeS9zdGFyZml2
ZS9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgMjEgKysNCj4gPiAgIGRyaXZlcnMvcGh5L3N0
YXJmaXZlL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gICBkcml2ZXJzL3Bo
eS9zdGFyZml2ZS9waHktamg3MTEwLXBjaWUuYyAgICAgICAgfCAyMDINCj4gKysrKysrKysrKysr
KysrKysrDQo+ID4gICBkcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLXVzYjIuYyAgICAg
ICAgfCAxMzUgKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL3BpbmN0cmwvc3RhcmZpdmUvcGlu
Y3RybC1qaDcxMTAtc3lzLmMgfCAgMTEgKy0NCj4gPiAgIGRyaXZlcnMvdXNiL2NkbnMzL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gICBkcml2ZXJzL3VzYi9jZG5zMy9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICAgZHJpdmVycy91c2IvY2Ru
czMvY2RuczMtc3RhcmZpdmUuYyAgICAgICAgICAgIHwgMTgzICsrKysrKysrKysrKysrKysNCj4g
PiAgIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICB8ICAyNSAr
KysNCj4gPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDY2MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0YXJmaXZlL0tjb25m
aWcNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9zdGFyZml2ZS9NYWtlZmls
ZQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcx
MTAtcGNpZS5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvc3RhcmZpdmUv
cGh5LWpoNzExMC11c2IyLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9j
ZG5zMy9jZG5zMy1zdGFyZml2ZS5jDQo+ID4NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiA4OTM3YmIy
NjVhN2YyMjUxYzFiZDk5OTc4NGE0ZWYxMGU5YzYwODBkDQoNCg==
