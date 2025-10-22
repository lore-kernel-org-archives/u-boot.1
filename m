Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649FFCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1731C83835;
	Wed, 22 Oct 2025 09:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED158334F; Wed, 22 Oct 2025 08:13:47 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20726.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E499B82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 08:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKf+XDPnThgfM44tba5g+9KGOBeZfjzmWlqFDNjaal6aCPocahBDrJTSNjX+NXrQ8FYlysJ/zGHAe4CUKP83bd73YpCywpVomOFt6sAaBbbOVVyOuNxaLpK87wykYTdLZaQXUbtprK1inDYrbkao7kdxueXgXoDg+QyDnjKACSkbJJ9zzwu0D+ivXuVo4VPQWS3Je15esrBELJWYXGVLXzxHrioBVG4to3JpGWrWyjCa1iSlhuenp60WI22GIwlKAuPhbWwS6GUt1K8bmvM3QQAMBL+iDLIFBDUfJht58Jw4PCUbi7R4GSrkkcBm2HaAZqEfS+iUoeW/GSfS08vLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPkImMbRP/ZHAdYLU8AA7r/ejtw12NAyPnjDco9UElQ=;
 b=dloNoeoa2ZhnilyrFMpn3v7lN42d7PXpqJlfaoZhfHMpDulNReWGqpmJUx/wqiQ+WoBIE2F1edN9ed0hTMszhVULlJrDqDPZgPTyXcEhZ90LM754BXbWmiaESoXBuOaWu3hTUdg0krDPWNGkKRMCoai2ftURBMxxCjhRvpe6OpARFJDOCU4pFkKc+wQuz5uctNF+4MO4BohXJCXVdJxjf/6Ry0WEd4jLzyndXacSiMZfLypJKeSf8jE3fY3fZ0gEgYNN7UbHnzYJEl0VAyQ09LUJu4oHOMTD5umHpTGMFY1K+xkZPRrsWfwsHKUXiTAYUv/ljAvRk+TiZM/gu/W+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 06:13:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 06:13:38 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [RFC 06/10] pcie: starfive: Add a optional power gpio support
Thread-Topic: [RFC 06/10] pcie: starfive: Add a optional power gpio support
Thread-Index: AQHcGKuU6hw0U3Do1U+GHfo0G568v7SAlpYAgE1q3LA=
Date: Wed, 22 Oct 2025 06:13:38 +0000
Message-ID: <ZQ2PR01MB1307F852550AE075408E0163E6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-7-hal.feng@starfivetech.com>
 <9b3b28cd-7ed7-454a-9bdb-1d56edf51719@freeshell.de>
In-Reply-To: <9b3b28cd-7ed7-454a-9bdb-1d56edf51719@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
x-ms-office365-filtering-correlation-id: 8957d738-783e-4321-a7f6-08de11322445
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: z1OMC6lrNn/TLRVIeUiCECKuTjdVAAiIhicNYoBejEQWm+4xGqjvnf7jnQ99eHptrxVkgtwLT8GPFdyCgSZFlbemBHc+rWW6u4a6MpQDD8Jz3mBvDXLv/bOV4tRWb5TDe+340J6FeznGHeRjoCmo3d8AvOJNw9s7yg9W8sQrkYnU32cZs9sJLbz0mpwK0TP02oYDXFIzTOT2RVas8PiyXLjxnxHSEVO37qqV9JSzVplfLF34fWQL3dPgT9E+eTiF9ZaW86r9L+RNmENnJmsEKVKs6pcD++zvSjWfSafzJ3ODIQ7ypJhQcJO9bEZPTSFYrUQc12oxKwDSm2tCeUOff6C+JP56T1aDNa1Uah3H8VyWosOOwhk/LY9LuUyWOOCvIYcUZ9zBcigTDsMBMPPJu0lDmd5oEJnZJD6taSvPNEADpIIF2WgGzzmv02/wutB5vJFH4RJu5UAgMbhxxKQ0u2jBHG6wV7DjVXvdPuH1KvdVqRRgpqmSXBaYShVrQ01h8oTlUVmqWMR36T9uH7+ngKC9RXfvDZcABtlefFek2X0rRlCXwNbimlpHsrGIxARj1UupJlh2ZHft4RKNO2ZN0feb6uDVIozfwzs9l3KiaBk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mnladkg2ZG9PMmJsNE5wVEM5NzBnOVVicGxlZHQxZENmMm9FaWJFSW1xbHIv?=
 =?utf-8?B?RlVtcXRIcVEyb3ZTYy9wQTYyZ3Z6ZDJkMjdGSUtkZDJqRk5jV0ZJVGpGSXFD?=
 =?utf-8?B?cFBNWE90bndJRElGYzlkUGIvZTdFZGRvbExFWXZZZEw2aXdhMkl6ektUai91?=
 =?utf-8?B?NmRxbjRQTS9FNVJFbG1pM2Fqb29FTExZaHRHRkswRUZTemlBL3F5UnUxem1i?=
 =?utf-8?B?MVM3akxwRTU3Ym1GVGhTd0Q4b3VKbHR1VFVFTWJEdzVPWnNXZE5lSVl6SzB0?=
 =?utf-8?B?SlpEMURKbU52RUk3Q0RpOGtPUUN4UlZhWFlDd0dHS2VML2p2TFVUM2F5bk1w?=
 =?utf-8?B?QmN1ZElwNnN1UHVpMmVySWNrbzgveHV6dGJySURNaUFWL3pJS25EcHYwbGZW?=
 =?utf-8?B?ZkEraG1qU3RhKzc2clM4WStLQmZ0bjlzUC93S0w4K0FoVVU2SXNmQUgrTGZq?=
 =?utf-8?B?alpmblVCUi9oSVY5L2NyNExEcHcwNlVGeENKdEdqWkV3Y040M255dStkd1lp?=
 =?utf-8?B?enFNR3liaGQ2c3lScnBlZklhWEVnYzFYcldGcWRiOUVBNXM2WHVLQkQ1Y1Ft?=
 =?utf-8?B?Q3VLNDFFem1JOVgvbnJPTzVKdzB5eFpVNGI2Zm5WV2F4eTBKSExSVVpLdGJN?=
 =?utf-8?B?cUFLU0lnK0J0ZHg5ODNLeGxXUDdjTmVxM1JOOUVZUm5Da2JJamUrQ0xNdVZ2?=
 =?utf-8?B?bjFLcldTSUpDeWhqdDN2OTFQeTVzR0dEZUNUQjl6MWowci9rYjIyeXRsT2Fv?=
 =?utf-8?B?SWdBRWIzTlVyMVpGWERwL1lUWnU1ZFpnamJ1NC9IN3NmYW02SGhJSjBWclhQ?=
 =?utf-8?B?aUlucFBUd1dVUTRyQ2xhWnpJbGE4TlMxdmlIcHFxeWdiaHd3R1hBVFluWFpV?=
 =?utf-8?B?ZlpxWVprN1V6elV3Sk8yNVNUSDk4YUUrNTJYdlBMMzFXNExOZS9nSFE4NXFi?=
 =?utf-8?B?OTBTbGRsaUNMdmlzOE1pbFo1a21zbnEvNzFQSW42RVhVQVlqU2Z0K3dPeEtM?=
 =?utf-8?B?OERIN2prVHRoRkNTOVlDby9aRDBna2pvSjJxcUVOVy85QWdMckFjeWI5akg5?=
 =?utf-8?B?ODlxQ1lzc25ZT0JWeTU5YkJReVhwNWJFRlJrSkdlTXJhNHp2Y3k3UnZSQnJo?=
 =?utf-8?B?cG04TFp6USt6U25tVDJHWmFUZ0xTYXNUQ3k0MVNkVE9vZGxDdlFTdEtRNHlh?=
 =?utf-8?B?MnlmejJkWXZHWmkyaTVkdVVTdG50NTZUUUd5c253emZvRWNvR3lkV3N6Wjc1?=
 =?utf-8?B?Z0FrMGVXN0ZrNGsvU3k1bGxMaDZGOUozVTU0dHFFSXhhaStYMFZiaWU1N0pz?=
 =?utf-8?B?MFFadmtJdVZ1T2pjTHJ0TVZCdGF0d2E5U2drVE1aa3k4WE5IR1lnT0VuUXJj?=
 =?utf-8?B?c3AwcklhQXROL3VGTVYyVlJGRkFqQmNZaW9meTN0NEY3ck4rMFJyZ0p0Qnlr?=
 =?utf-8?B?alZOdTg4dnY1cnpPeTU1LzI2RWZGQnF2MURxUEo2SllrTEd2empDdmpML3BS?=
 =?utf-8?B?Tjc0UGovOUU3OW1QSkNYeGVhdVVEUXFXN3prdk4xaXJYOWdISDBBcEVjYkts?=
 =?utf-8?B?RnBRR1A4RWVyYmVad1FMeHhudGZjYnhzd3hXVGFMa1lyeklZaGFLcjZXWVRN?=
 =?utf-8?B?djBBRXhsYk94R2tUR3Y4TVpYZk85VGNTM3lSMkRwVWg0S3VmNVJtZElzZmcx?=
 =?utf-8?B?TTJJeXVZSkdRRktjZTIxY2lxNk1oZGRWYXNKZGQ1RnY2eWMxbkwvYnlTZ21Y?=
 =?utf-8?B?c3NSNkpXcDJaTlJ4YVU2UDdsc3ZPWk93N2k0WHNiWVJFdkVJTWJySVd2VUZt?=
 =?utf-8?B?VEdYM1ZjNmFwZVhGeGNQam5sZUIrM2hFdFdqcS9QOHM0dFBLeXJYOU4vb0hu?=
 =?utf-8?B?bDhHRkRmUWdYbllleTFDcCtEeGtMMHVUcERweW1rWW5nZDlkd0t6cHNKWGl2?=
 =?utf-8?B?MmV3S1didGFrUmpTbnpWZHdWSjVwdHF3RGNRdlVwYlErWjM4akx2Q2s0SFc4?=
 =?utf-8?B?WU9nL0htNUdLMDIwRFlraVlJdXkrK1haem93d2JTMHRXN2RxWGhjRmsvdTRF?=
 =?utf-8?B?ZlZ5VWJBWWlwL0g2SGFtYnhTQmdtYTlqTlhmU0x6bUZ3Nk9COEVjYUJUWEpo?=
 =?utf-8?Q?BldZQ91Rl67n6gZsqn14rsKy+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8957d738-783e-4321-a7f6-08de11322445
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:13:38.7412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlmrH+ukc4wEk8jOBFAQLx3F0kJ48Dp/rtHtJa/SwrspJHz1zwBKVgkcng8jno7vaQLXCF9o324AnyW5lDHf79wUije3PdCVSqF8ZPZLq+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

PiBPbiAwMy4wOS4yNSAwNzo0OCwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiA4LzI4LzI1IDIzOjA5
LCBIYWwgRmVuZyB3cm90ZToNCj4gPiBHZXQgYSBvcHRpb25hbCBwb3dlciBncGlvIGFuZCBlbmFi
bGUgaXQgaWYgaXQgaXMgdmFsaWQuDQo+ID4NCj4gDQo+IEkgc2VlIHRoaXMgYXBwZWFycyB0byBi
ZSBhIG5vcm1hbCB0aGluZyB0aGF0IG5lZWRzIGltcGxlbWVudGVkIGluIFUtQm9vdCB0bw0KPiBo
YXZlIHBhcml0eSB3aXRoIExpbnV4IGtlcm5lbCwgYnV0IHRoZSBjb21taXQgbWVzc2FnZSBzaG91
bGQgaGVscCBtZQ0KPiB1bmRlcnN0YW5kIHdoeSBzbyBJIGRvbid0IGhhdmUgdG8gdGhpbmsgc28g
aGFyZC4NCj4gDQo+IEV4cGFuZCB3aHkgdGhpcyBpcyB1c2VmdWwgYW5kIGhvdyB0aGlzIGlzIGlt
cGxlbWVudGVkIGluIExpbnV4IGtlcm5lbCwgd2hhdCBpcw0KPiB0aGUgQVBJIHJlZmVyZW5jZSBv
ciBzb21ldGhpbmcgdG8gZ2l2ZSByZWFzb24gd2h5IFUtQm9vdCBjYW4gZXhwZWN0IHRoZQ0KPiBk
ZXZpY2V0cmVlIHByb3BlcnR5IHRvIGJlIHByZXNlbnQgZnJvbSB1cHN0cmVhbSBkZXZpY2V0cmVl
LXJlYmFzaW5nLg0KDQpPSy4gV2lsbCBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZXMuIFRoYW5r
cy4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFsIEZl
bmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNp
L3BjaWVfc3RhcmZpdmVfamg3MTEwLmMgfCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2ll
X3N0YXJmaXZlX2poNzExMC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9wY2llX3N0YXJmaXZlX2poNzEx
MC5jDQo+ID4gaW5kZXggNTFhY2E3MzU5ZmYuLmY2YjUwZDEyYTkwIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGNpL3BjaWVfc3RhcmZpdmVfamg3MTEwLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9wY2llX3N0YXJmaXZlX2poNzExMC5jDQo+ID4gQEAgLTQ1LDYgKzQ1LDcgQEAgc3RydWN0IHN0
YXJmaXZlX3BjaWUgew0KPiA+ICAJc3RydWN0IHBjaWVfcGxkYSBwbGRhOw0KPiA+ICAJc3RydWN0
IGNsa19idWxrCWNsa3M7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY3RsX2J1bGsJcnN0czsNCj4gPiAr
CXN0cnVjdCBncGlvX2Rlc2MJcG93ZXJfZ3BpbzsNCj4gPiAgCXN0cnVjdCBncGlvX2Rlc2MJcmVz
ZXRfZ3BpbzsNCj4gPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gPiAgCXVuc2lnbmVkIGlu
dCBzdGdfcGNpZV9iYXNlOw0KPiA+IEBAIC0xODQsNiArMTg1LDEwIEBAIHN0YXRpYyBpbnQgc3Rh
cmZpdmVfcGNpZV9wYXJzZV9kdChzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJCWRldl9l
cnIoZGV2LCAicmVzZXQtZ3BpbyBpcyBub3QgdmFsaWRcbiIpOw0KPiA+ICAJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICAJfQ0KPiA+ICsNCj4gPiArCWdwaW9fcmVxdWVzdF9ieV9uYW1lKGRldiwgImVu
YWJsZS1ncGlvcyIsIDAsICZwcml2LT5wb3dlcl9ncGlvLA0KPiA+ICsJCQkgICAgIEdQSU9EX0lT
X09VVCk7DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0yMDUs
NiArMjEwLDkgQEAgc3RhdGljIGludCBzdGFyZml2ZV9wY2llX2luaXRfcG9ydChzdHJ1Y3QgdWRl
dmljZSAqZGV2KQ0KPiA+ICAJCWdvdG8gZXJyX2RlYXNzZXJ0X2NsazsNCj4gPiAgCX0NCj4gPg0K
PiA+ICsJaWYgKGRtX2dwaW9faXNfdmFsaWQoJnByaXYtPnBvd2VyX2dwaW8pKQ0KPiA+ICsJCWRt
X2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5wb3dlcl9ncGlvLCAxKTsNCj4gPiArDQo+ID4gIAlkbV9n
cGlvX3NldF92YWx1ZSgmcHJpdi0+cmVzZXRfZ3BpbywgMSk7DQo+ID4gIAkvKiBEaXNhYmxlIHBo
eXNpY2FsIGZ1bmN0aW9ucyBleGNlcHQgIzAgKi8NCj4gPiAgCWZvciAoaSA9IDE7IGkgPCBQTERB
X0ZVTkNfTlVNOyBpKyspIHsNCj4gDQo+IC1FDQo=
