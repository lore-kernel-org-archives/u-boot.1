Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B261C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 08:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CD088974;
	Fri,  5 Jul 2024 10:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A15883BA; Fri,  5 Jul 2024 10:23:54 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20724.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF748897C
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 10:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu3eP1Vh5rLI1h8mfYZKa+k5qQSon5WXRWiCdaKBQYgtpY6mCCe/4fh4khsYjmFXCmWhxVwx0TI79dLDa6M8fedY9OdzYgApxciQmBWbMg99Zy0ESc+JlGbRUPdcyOsJT8dAfQqTtm9thJx6FFfdaCgIhll7n442yKO0eBsX6eNV+L5pNM0IPIyixjZ7CkGeLQ0HCkTkDLqnEp220H/+akQNJkaCUKJ7OW8FjsdYWIm6F+oT9TP5m11/iUn9Ce6Us6v5btBt2u4QDxnw7J/24UYNCpnUQKzOFg3RgmNG/KWsFSSr92b6vYi+XMu86Oc+/4Gai3nnsdZlgH02dVyz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts7FDjy4VxURL7Q3cxnax6r5SkA2r2GgBPE0AJoSE5Q=;
 b=U+/z7PHpIsToJMIPzycUY5mc5meqX7uquuZfWXQmMALs6IflOub92+1U9VEFQHE91fAXnXPWQCeCFXio6pp7sWk5uCv6aP7WLHNlHu6Kr12hp+5sg85wqv8KcTbJCpQuz0JQ195vIslpSR6b1SAdnj3seYyeK7i7o9pqR6fMHaz7JdaKhPyR/igyo2AR1FhzYxJIM1qMNS+7qjCW/S7Y784lLE/7OSptdiH92RwWC+7lYN3jdLl3NamrmlRpn7NkbFf3BYsGrszbv7dlHjOGTyaXsO9+lxMnw2cw11Fr7FuWWTEMH3R3NdADNlCV4SgFpj6xlwWQRIDS5Bq2T8dXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0816.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.41; Fri, 5 Jul
 2024 08:23:46 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7719.036; Fri, 5 Jul 2024 08:23:46 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Roger Quadros <rogerq@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, E Shattow
 <lucent@gmail.com>
Subject: Re: [PATCH v2 1/8] usb: cdns3: Set USB PHY mode in
 cdns3_core_init_role()
Thread-Topic: [PATCH v2 1/8] usb: cdns3: Set USB PHY mode in
 cdns3_core_init_role()
Thread-Index: AQHazdYPHF4R1FhI30KBtlh4OQf2WbHmkOIAgAE8wPA=
Date: Fri, 5 Jul 2024 08:23:46 +0000
Message-ID: <SHXPR01MB086363C32D96A51018E6543EE6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <20240704055014.55117-2-minda.chen@starfivetech.com>
 <cacb69e4-1710-4162-8ec6-3850ec5f4a80@kernel.org>
In-Reply-To: <cacb69e4-1710-4162-8ec6-3850ec5f4a80@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0816:EE_
x-ms-office365-filtering-correlation-id: 4f503fbd-3df8-4ce5-c5fc-08dc9ccbca56
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|41320700013|38070700018|921020; 
x-microsoft-antispam-message-info: 56+iedMFSRcvF7QeFLZaCbq+qK1VObPn17IxLn1eDQaASPXpTI5K54DuZL/OD3xk9nQ8ntIv+G9/e90RiRklbDnuliNbjaXt0xlD7jEqbZ2wHFjfdZ/fyk30s6+Yj8R0JBWKKqtDhZdv/Cx5mp+cuy4XKxIvAuHcbmTcewY0wUTQ4d2gjI043QCPsBDbGx/F/HKc2PZL9d3s3IXsa5ZxG5W4UzK4PCdx9/Uc/CS66wNSqvEjPVQqoqJRA2Gbu0eq9QYx07oWE9ljGA5975a4CE+yEiBR6+xYFW2EZkWqDzTWI9G8TmAJmxTGP/O+h6RKtEgzSJJn+r2hLp/1WPJgnk35P+aW2Kz/1sb6vdjpNfxfyaPO9niuAgettJClfbsTAwYprp8ulA196Jpr9e13Dm91v9AmTS2InESzLTPc7txOpIqgZSGe4iMNoRfTPfA/D3HKR70pklslyAUekBpFrfRITx/WoX7X6LUC8RYVLnEsEpDl1iFWfpmog3cUe7oXXn1yWs/W/Vwi1qMeaAibqsL11o/R4xXXeiE2DHSowZ/H0uuXx/mKEyZ/j11VYFL7R3qoOeJYeqJgYi8xwejlz/sAlEy5Dpt7RCumqZZzzH+gGwEIenbXXKP9G74VxzLg8VDYD6zuvl5ToH77Ue3RJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(41320700013)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmJHSzlxT0w4VVU3YUVXa1JDM2VBakJPSjRwL0w4dldSUVFJakloMmd6SzlD?=
 =?utf-8?B?cUYxa3FYdHBTaDdqUEluY050OEZSOGtsa2JJRkh3THQ2TzlmdWtINjRhaWVr?=
 =?utf-8?B?UmwvSUFDVDJSa3Mzdlo2NnYzNWZ3MEJCcXVVc2p6aXZHTTlOOHZZUW9SZHRr?=
 =?utf-8?B?RHRVSjlEOUZIOGUzcDYxYUw5aXZmWkMvWWVUTEVHOG9ZdXAwNkRWNFNYMkcy?=
 =?utf-8?B?TVR0OEtKL0IrRUIyV2dteDhQYXFzZE9sK2Q5Y1VBRk9nMGRZTjdxYk1iN0xJ?=
 =?utf-8?B?VStCaC9JTEJGUHhaVXE5NldXZWZ0TTRsdjJPRzlINUV2OUtJM1lLWDJUTllm?=
 =?utf-8?B?S2o3TkgyRnNkNjlCdzR1UkFhcWI0U093SmNnejhzR2NHUmd3Mzc3bC9ZRnJJ?=
 =?utf-8?B?OWNkUWozNnJ4ZFU0UWpuazdJNndZa1ljd01BZ3NsS0J2YXFKTXJ4VDhRSkVG?=
 =?utf-8?B?cDVzWEJHcGVCRXRJdjM4c3dzczh0Y3RjdUdFaHc3b1M4RUVDMy9DVG9oZFVP?=
 =?utf-8?B?Y0oxbHQ2K21Pc2ZEWFVXaUQvbUlYaUNFbndweWZtZmRBYkZwRjNlZ2JhbmZQ?=
 =?utf-8?B?MjExbURiOXpheFoxWVBpR0xNWGtidlIrazZEbU1kRG1WYVJPakFBWm92OUho?=
 =?utf-8?B?Z2tieVNPdEd2WWhSWWJBaCtjL2hTaVRWYzZnMlBIbEs0NU0ycFQrTTFRb1cz?=
 =?utf-8?B?L0tUaXFLbVl5MmQyRzR2c3VIZU42aHZodTJTWFRHa3pwZ3VSbVA4OW1rYWFr?=
 =?utf-8?B?RnBnd25oaWkxbnA4aHF4OTVUdnNmRVBLbVRKZlFoVnZ4MXhwNms3VjhGTyty?=
 =?utf-8?B?a05YSzJGRmdqRU1KOHRQU0xFRUdIMWVaSU9OM2xYMkVzWEhiLzNEbjFEMmRa?=
 =?utf-8?B?c0RaQWRwUHBPV2xuWlJ5RElOS3NUazFSbnJMTHVxZzZjdml6K0w0Mkl4Ni9O?=
 =?utf-8?B?aG5qR296Z0RRMFU1Q1M1UlIrbUs0R2ZCM1lUOXJGaHdTRUNOKzk2Z2I3MlEx?=
 =?utf-8?B?eEJhVzB2K2Zmd0Q0NjdNV2pkaW5ZVE1YR3U1VGRGaTROUmkvUEx2a2w4SlRM?=
 =?utf-8?B?SWxBY1lGVjhMeW04czR0dnZUUkRKclhBVXF2ZjN0ZU40WWVLdm5jU2lkV3N2?=
 =?utf-8?B?dDlWN1B6b0Z2RE1RN1ZyYmFaWmtBRnBTTmN4QmZKM1RUUlh1MGh2SkhjMndE?=
 =?utf-8?B?Myt5MmlvNXhiVjJxelhHQUZDeFdQWlpxTzJjTmVvZys1WlVvZGNRenVqYzF5?=
 =?utf-8?B?RHpaVEdLTlhEQ0RMUWFJT1NOSWduSHl5ZkpsVDhjNzlNWVYvejJBcndacmVB?=
 =?utf-8?B?WGVoWldCdEpmV0xlbHgxUDkrNzhTM3BZcTdhTEJiV1ZJZDFoaHNTZ2xDbTRx?=
 =?utf-8?B?bW9nVmdWNXg5RnJPQzlDZlJrUTZpS1dWSmRCb1VRS2Y0LytNMS8xVjAvQzlM?=
 =?utf-8?B?ZWtmd2dYWFRkamVSK1JsVzVrelcrRHNwVVJMTldKcGE5ZTgwK2o0aDYwNnUy?=
 =?utf-8?B?VDlYcGdRVlI5TDJxRDRRc2t0c2lnNGUrOXFSem96Q1Y4aFgvMVUzTjNPTkxE?=
 =?utf-8?B?L0RrNWVsdklVMktJMFpmaGUwRE1JUUNrY2lZb3NDeTgvQXFJKzg2aGk0cTgw?=
 =?utf-8?B?aDRteCtDaGk1UlcrQTl4UHhXR1h6K1E5T0NXV2E0QU1xS0NjK0g5L1B3TGZh?=
 =?utf-8?B?d1Y5M014R04rNUJ3MFgzOE5QRFFJa2Zyc2NGWm1TUWFSN1ByUG9QWFpDU0E5?=
 =?utf-8?B?ckZHakJQWVBuSVpNOWI0cG5IU1B4ZWlFL29BVjVPOUMzRXlEZEwyVjNwdFFB?=
 =?utf-8?B?eEwzQWhkUDZ4TXB6SVFleXBVM3JDREhvMXVodE0rc1luaHRMdHJJbFRPb3hZ?=
 =?utf-8?B?TkFLZ01XRTd6VEl4Z21SM1ZHWmtWT3dDWnM1eitZZUhmVHN4K0xSVGtiak1s?=
 =?utf-8?B?YUNYYUdjUUsvYnBjRGM2aEFLK0xrdGlrUjhqWFY0cjdDTlF0eUFlWkF2RXQz?=
 =?utf-8?B?Q0xCb2RnWGJXZFFyRzl4RTdvWUtLbzNLVkdxYlVIQ2V4Q2RvNmw2bkpvaFpl?=
 =?utf-8?B?Z2N3VVAxeko3cGtLeEtidUVhdGhYNEkrU21UWm5LakFDMjRzQlJPd1A5Wi9k?=
 =?utf-8?Q?Bv0tc/F3SS76/dbw79/cDYC1H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f503fbd-3df8-4ce5-c5fc-08dc9ccbca56
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 08:23:46.6318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXTc2j5FjWJN1v1+CxspLdZOkhsaOMktV6u3uPTsnRaBdt73NDH9Pb3eGqlZ8BsXP4n9OITII8qke32m4GKNc5sWZB+uJKP/tkpxznLw3oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0816
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

DQoNCj4gDQo+IEhpLA0KPiANCj4gT24gMDQvMDcvMjAyNCAwODo1MCwgTWluZGEgQ2hlbiB3cm90
ZToNCj4gPiBVU0IgUEhZIG1heWJlIG5lZWQgdG8gc2V0IFBIWSBtb2RlIGluIGRpZmZlcmVudCBV
U0IgZHIgbW9kZS4gU28NCj4gPiB0cmFuc2xhdGUgdG8gZ2VuZXJpYyBQSFkgbW9kZSBhbmQgY2Fs
bCBnZW5lcmljX3BoeV9zZXRfbW9kZSgpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZGEg
Q2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3VzYi9jZG5zMy9jb3JlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvY2RuczMvY29yZS5jIGIvZHJpdmVycy91c2IvY2RuczMvY29yZS5jIGluZGV4DQo+
ID4gMTJhNzQxYzZlYS4uMWU4NjNiZWQ4OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9j
ZG5zMy9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmMNCj4gPiBAQCAt
MTA3LDYgKzEwNyw3IEBAIHN0YXRpYyBpbnQgY2RuczNfY29yZV9pbml0X3JvbGUoc3RydWN0IGNk
bnMzDQo+ID4gKmNkbnMpICB7DQo+ID4gIAlzdHJ1Y3QgdWRldmljZSAqZGV2ID0gY2Rucy0+ZGV2
Ow0KPiA+ICAJZW51bSB1c2JfZHJfbW9kZSBiZXN0X2RyX21vZGU7DQo+ID4gKwlpbnQgbW9kZSA9
IFBIWV9NT0RFX0lOVkFMSUQ7DQo+ID4gIAllbnVtIHVzYl9kcl9tb2RlIGRyX21vZGU7DQo+ID4g
IAlpbnQgcmV0ID0gMDsNCj4gPg0KPiA+IEBAIC0xNzMsNiArMTc0LDMwIEBAIHN0YXRpYyBpbnQg
Y2RuczNfY29yZV9pbml0X3JvbGUoc3RydWN0IGNkbnMzDQo+ID4gKmNkbnMpDQo+ID4NCj4gPiAg
CWNkbnMtPmRyX21vZGUgPSBkcl9tb2RlOw0KPiA+DQo+ID4gKwlpZiAoY2Rucy0+ZHJfbW9kZSA9
PSBVU0JfRFJfTU9ERV9IT1NUKSB7DQo+ID4gKwkJbW9kZSA9IFBIWV9NT0RFX1VTQl9IT1NUOw0K
PiA+ICsJfSBlbHNlIGlmIChjZG5zLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX1BFUklQSEVSQUwp
IHsNCj4gPiArCQltb2RlID0gUEhZX01PREVfVVNCX0RFVklDRTsNCj4gPiArCX0gZWxzZSBpZiAo
Y2Rucy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpIHsNCj4gPiArCQltb2RlID0gUEhZX01P
REVfVVNCX09URzsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJVbmtub3du
IGRyIG1vZGUgJWRcbiIsIGNkbnMtPmRyX21vZGUpOw0KPiA+ICsJCXJldCA9IC1FSU5WQUw7DQo+
ID4gKwkJZ290byBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gZ2VuZXJpY19waHlf
c2V0X21vZGUoJmNkbnMtPnVzYjJfcGh5LCBtb2RlLCAwKTsNCj4gPiArCWlmIChyZXQpIHsNCj4g
PiArCQlkZXZfZXJyKGRldiwgIlNldCB1c2IgMi4wIFBIWSBtb2RlIGZhaWxlZCAlZFxuIiwgcmV0
KTsNCj4gPiArCQlnb3RvIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBnZW5lcmlj
X3BoeV9zZXRfbW9kZSgmY2Rucy0+dXNiM19waHksIG1vZGUsIDApOw0KPiA+ICsJaWYgKHJldCkg
ew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiU2V0IHVzYiAzLjAgUEhZIG1vZGUgZmFpbGVkICVkXG4i
LCByZXQpOw0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+ICsJfQ0KPiA+ICsNCj4gDQo+IFNob3VsZCB3
ZSBiZSBkb2luZyB0aGUgYWJvdmUgaW5zaWRlIGNkbnMzX2RyZF91cGRhdGVfbW9kZSgpIHNvIHRo
YXQgdGhlIFBIWQ0KPiBjYW4gYmUgcHV0IGluIHRoZSBjb3JyZWN0IHN0YXRlIGV2ZW4gZHVyaW5n
IHJvbGUgc3dpdGNoZXM/DQo+IA0KT0vvvIwgVGhhbmtzLiAgDQo+ID4gIAlyZXQgPSBjZG5zM19k
cmRfdXBkYXRlX21vZGUoY2Rucyk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8gZXJyOw0K
PiANCj4gLS0NCj4gY2hlZXJzLA0KPiAtcm9nZXINCg==
