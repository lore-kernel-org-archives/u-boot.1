Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5656DCD6E43
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 02:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A15683FF5;
	Fri, 29 May 2026 04:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5212984659; Fri, 29 May 2026 04:15:13 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20710.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B4D8341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 04:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1jKD7/+ItrsUkhtk0q9wGHHsq/KH8kZn9sHbuX4D7LWMbY8krecbV/NPKOljLR5KrwXi9XF9zZDyaJaLeoQ5uZ6u7cqyCTJLuUMf9MhEn03My1PIoZagMbKOPbbUpiHHYOp8EJgTd+aJqJ9I78cbjCCHM+fi0SmYkB4FQZoIEVbHZghPQdXwQkbI3Z86Zgk4onFy7v8qZyt2ILlfuI1f1FBKziVW8OMVgUKLAHJjCU0SSm2AS9ezveRXd9YCzYjkQxQ5zWfvaD+1TF96mHD4hDdDA4toz7NH02jc/qb4t87cpDVXbRkLIvhS1zE+bvRiVj52UH7xt2ce5ogmSUNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyR1I034h72ezC1NN6EDftfyczWUGzkpACf+s6GCc6I=;
 b=iKPx3SW3r8Wy2ayzuf0Vfck5MRv1cPo76aik40SsJTRvXhUW/afWWhiow86LOJvNtM/QUfEscJ5FzIzudTkHoLhOzFWuW9Zldma6LGHPgNZcDpBFs/I5ycZMrcx1/XAihHsSlP3WvpK7spPLfaWhE0+bYYNA7QK/Yq1pj958m+hLZj+kYsJv2z5ygYGDzNRZ/ISeNCsQNjZVXr0SGAG3IL8Wkgi51UtEJ3iLgaJzq1fQZUcIXXSx7GKBTissW1Dr/7mdUWbJgltaYXNkyAWhoRkJKRqL1wCdErbXGvNf2Qu5FARDDzwPLNbZZHDdZYn6If2AGnZj7qz3qyMcXd3+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1337.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:15:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0071.014; Fri, 29 May 2026 02:15:02 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Francois Berder <fberder@outlook.fr>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] rng: jh7110: Fix invalid usage of dev_read_addr
Thread-Topic: [PATCH] rng: jh7110: Fix invalid usage of dev_read_addr
Thread-Index: AQHc7O3Qna1DZc8XoUaTRJfQLvSNerYkSA3w
Date: Fri, 29 May 2026 02:15:02 +0000
Message-ID: <ZQ2PR01MB1307AAA8B83F83A34073EB78E6162@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <FRWP194MB27908D1150FB7424A8C57402DA0B2@FRWP194MB2790.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <FRWP194MB27908D1150FB7424A8C57402DA0B2@FRWP194MB2790.EURP194.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1337:EE_
x-ms-office365-filtering-correlation-id: 89ec00c9-a60c-40d5-3395-08debd2817a8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: e+OpMS9AzKJOTRj0dvRufhRfpf2SA4DsTC1hACitMuTG6fC9Caw9dV7lR5wnZtREiZ0Q6WGtSuu1dmE+gXxSOkUoPP65y6xSsRShyr9AJv8rZimh42OCb2hNx2Zt8TS82w5NTrUZjssvVU4KKLq6ZIVzz9BNbPSsGEbfxiPIjNmIM/n/Exc5MDuvEQIOMENmUXXA1emdVaMIAOXmvvyPGI+Rr1b/nNkoBONznIdxcWzQdLi71PamIdYsIZcxQy+fEQ4NFq77XSAeEnPOwwc37WNyzZt3/L+C1e+e3vFqPPXTImBofC7zNgU/Pg+fJpASRsxppVVo5cKTg3a9+FipBYDuAXccmxWNMoeKkI804ve56J1JeBRbipDDDgcYP0lNf5gWFO7VRsR78MnxZyiHyMOzwYyk/bHppuaNP9QcY7GO3Sec9wQBQr1AfdgZXHto7pJTugc62V5E0VezKI4M01ct1j9fJ8ZEHbjjRcGc3dyh8af4yFE2mux2V8oMmcUGhuP1YUpZQLR170xDZ/uOs7Hl+xmUd1CLVM2JNm/oJru2NXjnoaMpIvk+kUfJHJ3b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU9YM1E5Tno2Sk9sanNEMVJFTExraEtnTUMwOHZvV0hsL255aUsxQ0Ywbjg0?=
 =?utf-8?B?L1M1dFZpVDlSa2ZodGNaNEtxc0xkb3NFNDlqT1NyakpzbnFjTnhaOFBIektE?=
 =?utf-8?B?V2IwMzNQMFpZVnhUNndnR2NBWEZNa0hrT3psaXduYUFsc2l3Q1ZNZE11cm9j?=
 =?utf-8?B?VGhIa3R0SWhSUG1UeUtsUlphZEExTTZPbWhwU1JrbnVIZ0d5R1ozTC96Zkx6?=
 =?utf-8?B?Wk1FMzh0T1hqUDFzc0E1YndMeVhVN0NpVVZDZFpuQTJHOXlMR2VTbHBMRDFS?=
 =?utf-8?B?Y0kxUng1eTJFZVlUczljMWtES0RDQ1REV0t0dDdUSDFQNk85NVVRNGpGWE52?=
 =?utf-8?B?Z1Fic3ZXeExkUmlvckdoOE44emZ1Y0ZHQmcvbHY4MFF2T0J0c0Vhc0R1T2Rp?=
 =?utf-8?B?ZDhrSXc4OXUzNXlzQTRUdGJPRXNIL1FMRGxCczU5djRyb2xKMDlSUjR5Slhr?=
 =?utf-8?B?SkRBUk5oZU1XSlF2c3E0dXp4Zyt3NzBmQnBaZ1ByVENUSFNKeHJTR1VFRnFt?=
 =?utf-8?B?YmQxaUhSK3g3SHc4SjdYT1pMM2VKSldsR0xMRFdsTFplbzI1RXQrR2JkbE5Y?=
 =?utf-8?B?bG1IdzdmTk9ZN3RmdEhxaTRZNk1pSmtlUWFzUm9ONjhEU1U0Y0pvbllCRGZh?=
 =?utf-8?B?cHBQMDAzZjlNcEYxVytzUDNwOFdtSCtHTTBwNUhrd3RhQnhkUHd4TkYySDFo?=
 =?utf-8?B?S1FqNFoyRnB5VmNtc0lLSTJVNUdKc0w2RXI4RTVWQmtoTkQyaVNZQzhMeTlY?=
 =?utf-8?B?MjhCMFRxTWdRbWNrWXhySTVmUUpOR2RlOUFsSU1DczNWc0xnMHQ2b09GR2NB?=
 =?utf-8?B?bnMweWhlRkJKRmJxanl1UFZYR0ozeGljV3hXU3Y3bFIzenIvcStnTjdDOCtr?=
 =?utf-8?B?bFBZWmM2V2ZmZWpqR09ESTJuQkxEQ1FRYXVRQWM5R0tqSG1GdUQ5aFZFc2Rw?=
 =?utf-8?B?dGJxa3RON1NCcGpIWFdUVzd2WFVNOEVOaG1TZVhYODEyUmw3Zzh2RCtBNWV3?=
 =?utf-8?B?dExYZlplcXRLckFSWGZvYkRBeEhhNi9acUNMOUw5emZESzZ6Z0xabjRVaVhx?=
 =?utf-8?B?R3d4S0xqMHR5eXFvOHloaDZ5RThsYVlnb2xoK0lNb3MwSDNqUWFHMGdIczNQ?=
 =?utf-8?B?NnR2OW85TWtMblBmbTg3S3FHZ0lJWWR0YWs4bmNMa2pPd21zblZHMGJBd2pV?=
 =?utf-8?B?RHFFbzJXSzlleStod1VpcGJQcW0wSTBzeFdDSitOZWU1R2R1SURLcVFPNFdX?=
 =?utf-8?B?clJ3L1lRR1VUVXRQa2JxMW4zRnB4MzBiVEk3YVFsR3pWaThqMTBERmg3eE9Q?=
 =?utf-8?B?OWMrY0RkbWNINW9wcmxaUU9Qb0lZamlHSUl1THhSWExGbzBpUFptcy9kU1dM?=
 =?utf-8?B?WGx6ZS81czJyaHMzQXlOSDkwTnV2RDF0NE41NDBKVTYrcTZzanJOU3EvaVVZ?=
 =?utf-8?B?V1laenJhaXRJSGNwUjk2UXdzZVYrc3NVVU9qblJvSFhEd1VheTBzT1hVbkpR?=
 =?utf-8?B?ZjdCc0hOT0Uyb0ZlQ3MvTHFrbHlZM2doSFM5TEI3UXpOaE5XcmR1ZG9KWklT?=
 =?utf-8?B?eUx2a25GZ0V2OUZ4MmVBekhXUWlWZHEzNXNtOE0waXZGT0VLeUUyU2lQNXB4?=
 =?utf-8?B?TjRkVy9EWUliMUxFUWljRUdWTlVqRHRGSDNBYkFIVEY4S2l3L2V6ODJ0dGNL?=
 =?utf-8?B?bDRSTUJvNWZKSWYrNktIaUZhVjgzNUx6QVJSdXpUZVBiNzZXWjR2QnRmdXpV?=
 =?utf-8?B?NjE1dmtDZ0F6TGNDMHlKOE5LRHNZUVpjUTJhM1pvZjdDM2dCbFB2UTZWQnhp?=
 =?utf-8?B?OWU1UFZRTVpWVGIxZlYwTTkwNkhXWWJ0cEI5Y2tpL25aRko4RmtWK2kwekR2?=
 =?utf-8?B?VnpNWVJISmtVQk40R2NpV21raHdZL2t1ZVBQU0oydnRIaHR4VDkzL1cxcWtW?=
 =?utf-8?B?U3h4aDhUTitCRzJmblhDSW5SVndrNGRIUGF0QXZIYlg4L09adHY1WU4ySVI5?=
 =?utf-8?B?K2JsU2lyeVBRZ01yZzdNL3hXTXp0VUdZZmFPd3Mrd0x1cHowNERrakYvdXdY?=
 =?utf-8?B?Vjk1SzN2Tld1K3VyaDBrOUN1NVB4M2pycWx6a0l1NGZTc2RqZjN4ZUl4Smxt?=
 =?utf-8?B?b2Z3SHI3cUxNRlJYUXdUTTlLRElYTnJMeGNPQlJYS0RaNzdINHgzNVNsQzBN?=
 =?utf-8?B?bEdOV3RLV2Q4UlBzV2Z0d0xPWDd0SjdlSURBTGY2TURzb2pWQVY3WVlDRWZC?=
 =?utf-8?B?MDNiRUhjL3BoQjh6ZUJsbitRQXZtdk9HUy9La003NCtSTHBtVEEzdjZGRkxJ?=
 =?utf-8?B?NTBHblNRZzB5UU82UjRQdXlncHdpK0ZSdytmdG1OU250SlJ2S3pPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec00c9-a60c-40d5-3395-08debd2817a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 02:15:02.6310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFnZ8d++8y/FxytvTau3HpfRHEl4NNurhK5P02MGkX178Zq7covK7HMTIS1/QNvis29RAoF9cNb4Q8myXiddxC/cmFLoLtpfO4kJIIwZo9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1337
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

PiBPbiAyNi4wNS4yNiAxNjo1OCwgRnJhbmNvaXMgQmVyZGVyIHdyb3RlOg0KPiBkZXZfcmVhZF9h
ZGRyIHJldHVybnMgRkRUX0FERFJfVF9OT05FICgtMSksIG5vdCBOVUxMLCBpbiBjYXNlIG9mIGVy
cm9ycy4NCj4gUmVwbGFjZSBkZXZfcmVhZF9hZGRyIGJ5IGRldl9yZWFkX2FkZHJfcHRyLg0KPiBS
ZXBsYWNlIGVycm9yIHRvIEVJTlZBTC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jb2lzIEJl
cmRlciA8ZmJlcmRlckBvdXRsb29rLmZyPg0KPiAtLS0NCj4gIGRyaXZlcnMvcm5nL2poNzExMF9y
bmcuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JuZy9qaDcxMTBfcm5nLmMgYi9k
cml2ZXJzL3JuZy9qaDcxMTBfcm5nLmMgaW5kZXgNCj4gZWIyMWFmZTRlN2MuLmQ1NDg5OGM2N2Y2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3JuZy9qaDcxMTBfcm5nLmMNCj4gKysrIGIvZHJpdmVy
cy9ybmcvamg3MTEwX3JuZy5jDQo+IEBAIC0yMzMsOSArMjMzLDkgQEAgc3RhdGljIGludCBzdGFy
Zml2ZV90cm5nX29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2UgKmRldikgIHsNCj4gIAlzdHJ1Y3Qg
c3RhcmZpdmVfdHJuZ19wbGF0ICpwZGF0YSA9IGRldl9nZXRfcGxhdChkZXYpOw0KPiANCj4gLQlw
ZGF0YS0+YmFzZSA9ICh2b2lkICopZGV2X3JlYWRfYWRkcihkZXYpOw0KPiArCXBkYXRhLT5iYXNl
ID0gZGV2X3JlYWRfYWRkcl9wdHIoZGV2KTsNCj4gIAlpZiAoIXBkYXRhLT5iYXNlKQ0KPiAtCQly
ZXR1cm4gLUVOT0RFVjsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCXBkYXRhLT5oY2xr
ID0gZGV2bV9jbGtfZ2V0KGRldiwgImhjbGsiKTsNCj4gIAlpZiAoSVNfRVJSKHBkYXRhLT5oY2xr
KSkNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFy
Zml2ZXRlY2guY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg==
