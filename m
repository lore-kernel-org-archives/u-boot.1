Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63CFC35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF00810F4;
	Mon, 17 Mar 2025 07:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E758D81100; Mon, 17 Mar 2025 07:09:16 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BA980F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdfNsOA1NrllH1LlszMBKm687ROmU2zQvTNIce9tYWbEjRKEQcMRpgteDiM7F28zLDFtYKEcEg7gJIVgeedj81ecfh4vU4PKKMjxkVx0W2wkb81r3c+yNaLyrRQao8bZVbOhhUnrrYoacOWqtEwyN4YXyqo+1shR2jZHizsadReGc72FH1E+NDoivVUEYgUTYX8C2sSgoerD3gMYqaE8hKu+qySwtvxsCP2Pfsps2pviJ4u+zxgzpmIw6CD3+jS88dsU0VpV+9kGXsApqL3fVQ6ElyuouRwExJpNBoG1Gr/tfWNbO/0dQNne4tA8SyBbg1w0kK6dW/EqZHrnMgtzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI4TS17HjuUGfjZg3AMhEhl+oucJHeJ3j9SYNCl4/Js=;
 b=DOALHYFc//t1qXQaqpbIux81+Rf4L282TdT4AgPQ3J++M2STNGZhb5h1aDIIB05v7SedGxccKNKPGi7WSnHyvATvYW+oxIDk23tEHV+7BvUz6rHB9bIsod6FdFv8VLkLAPmDDjd/Qv20Is8NwyS/OpOlhjPKr7ShuOYJh3JvtY36JIj8t+wOIeBtFHxPWLRUR/S5YbZEJ3ks/Q22/bCpmx9oUhE/BxA98EVITPKuqsSHhCHxt9ZY84+OE3TbEI6lVa32PublzhsZErHk5HUmPiRp3dZvObprpB1aCSZVZr7yOTEL8KacPD6nWzojalSNHZ1Ckd/kL1H1dXOEX/0Ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0848.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.37; Mon, 17 Mar
 2025 06:09:05 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Mon, 17 Mar 2025 06:09:05 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, E Shattow
 <lucent@gmail.com>
Subject: Re: [PATCH v7 0/8] Add Starfive JH7110 Cadence USB driver
Thread-Topic: [PATCH v7 0/8] Add Starfive JH7110 Cadence USB driver
Thread-Index: AQHbjl/iXhe4dWBGzk6fZndSjdjQPLN2urEAgAAuurA=
Date: Mon, 17 Mar 2025 06:09:05 +0000
Message-ID: <SHXPR01MB086327968E796EE26C083B47E6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
 <f40e5f42-3f29-448a-8c2b-76945f1ccc1e@denx.de>
In-Reply-To: <f40e5f42-3f29-448a-8c2b-76945f1ccc1e@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0848:EE_
x-ms-office365-filtering-correlation-id: 6d398d70-da62-49ca-e972-08dd651a38e1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: V0ghBhC9jJm3KwneVed0Zv9HsLtVO6SqTYCTmZMenjKiscHBfmVUsbVHZ1GW3Hh+tvA0MPtaCL+E8x0mlpuBKZCcIMvknCONgQr63q0hkkpiRzp7XT6EAWwgAzamd+37cyjgF/SE1764SgeWFBkeig9e/foSX2rUxInHNll8JI3uWStwGzkk2Hy+d+IsCCf1vJOrPTK7ygtr0UrWIq4rYyCC0zc+SpqJ10Wn0tot9Br2RzT0RhK8r1+OPu1ptTfK4owfIigJeMhfN63bV86zs2OrlhZOSN1HHBXOYGdR+7Z4oYMlTxQu9a/f2CQujex1guZejwDB3mgRa/k6dYI94kQaYySTcDCeaX8QWvFff1p9qt+iljn4aDgHzZzCWU/DogxnOLHFBKs++hd04qNLzohEu3nJ+PF/4diqRQy794aY4hac5DMPABBuSEFzfay7DjZOZQ4EA820q2oJTaK+XOnHzSgaRI0t6bAyI3dO0r1yZ6ezwfEhZiGbT8UAv14UdbSiEFXHca6CtW3/0FxaXoDWn72IEwMaN/5xtpFQVLyjTVr8ABSlnoH/e9sze+VfgvrrPAFag/ykHybtyabZK+gn9Al3e9ZpDfpm4zQgYkQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE8rdDB4dm9tWDltZC80R2FRWTQxSStLcHV5NVhkSHVFZmM4T05kQ0J4WGNG?=
 =?utf-8?B?cDY5NlhqdnJTenBQNHJRb2F2UXc2MFlNMWZiSFBjU3ZYR2FWVE1BdlJBcmRl?=
 =?utf-8?B?ZWhReEIvR3dLbjZNVm5LclBqSC9ScS9Sa3B0ZnFVcEM4WmMrazJsd0xKcGlr?=
 =?utf-8?B?YmFWYXZtZDJhV3BjT3lJRXQ5c09lYjVnMU4wdDdNeXg0cHRldW5ZL2NJMkN2?=
 =?utf-8?B?ZjBZdzNrdXl4WUgwOGswOUpvUHBkZ3QvK3M2cWh3ekhMMTdLS0hsYm80Y1Bs?=
 =?utf-8?B?d283MkJGMGZucXdsZis0bWE4TWgxazVMV2FFSzVmL0Eydzl0QkJ6OFp2cFFn?=
 =?utf-8?B?QXZMRE1WVXpmeGx2R3JyV2h0eXQ3QUNDczVWVEg0ZmE1cmFVeVRXdVNEanJH?=
 =?utf-8?B?dVB5T1BPdTBKZm9EQjhsWDgxbGJ0NkV1QzBiWnhsUWwwOEpVblBhMWpMNTV6?=
 =?utf-8?B?Qkd6ZmNiQ3podlZ0NGpiZVRLaG9rN3NydlAydjBEb2dFTFVaRGcxQk02bmhJ?=
 =?utf-8?B?TTZmeXFNck8vTHRkUUJMU1V5UkFudk0xbk9iSUtYd081ZERrUHpoc0VMZk55?=
 =?utf-8?B?bVFtWHlBUG1qMzZVT28vZGIxWEwrUzZJb0x1bzNLL0ZCQi9zZitOeFROVDRu?=
 =?utf-8?B?TjZZcXdTMEhUYlJ6T2tZOE9qZldtQzd4WW51cnlDQUVrUXF4dzhVdzlYbHYr?=
 =?utf-8?B?M041YkRhYzF0S0RCU3VYQTVGdmU3S3lMOXlwQVpMbGhla1VFSm1QK3cwcTNj?=
 =?utf-8?B?R2RHaThIRmd4L2Q0QitJU2RMZEYweWREa1FDaDl4ZkdHOXBkZDgzMmNablBH?=
 =?utf-8?B?cEhTR21BSkNmS0kyblFPWTJGMzgyQ21XTUw0LzJTR3ZyZkp5UFNTMlMzUEJr?=
 =?utf-8?B?ZGh3S0VKYTM4dVhJTzFEZ21GQkVSOE1sTGV1VGhVZVRROXhLUjlhWmV0M0Z6?=
 =?utf-8?B?MUJsMWRFYWJHay9JL0lnRlJUREpuZXRpSFV6STlFL21aamJGTjQrNHlXakxR?=
 =?utf-8?B?c0l0MmxXY1A3TDAzRzB1Y2Urbm1TaGVnV0NkMzVZM0ZvMlEwMTIrakY3UkM4?=
 =?utf-8?B?M3V3T3V4WVRyMGIxNmI1SEZWeEhzNTdVRERqVmxEK2NLUWN0OGRLYlpJT3lk?=
 =?utf-8?B?N1Q4UGc1T0xmNmFoWkc4THlRYS9HTlFYTlQ5Qk10Q3hjUkN4cUNua2hlYVNN?=
 =?utf-8?B?NUs0YlNnK0tkd29TTHF6cWtFOCszNUUvR25Fb0dSaGtMU1E4YmtFN00rZmpU?=
 =?utf-8?B?L3FHMTJIOExJNWtaSnRaTjhvajBlOUxSdS9XblA3THoxZ285eThzNDhrNEhM?=
 =?utf-8?B?MDhUMHJka2NUNWdUcmYrejkvWE02ZllRN3ltV0g0WEQ5TGlQUlpNcGdlY3p3?=
 =?utf-8?B?YytyMW1pUXhMcU10cXNXbmtSZXJMamM3Ty9TVWtaamdJdkFkUW1sNnNqRjI5?=
 =?utf-8?B?aTY2MVQwMitYMzNueHlNWDBOQjJjcVptNnFPcVpZcmc0eVJZSVFNNHl0YWpy?=
 =?utf-8?B?cjI0SGEvTlFlZFNsdlZYSG1pUzhUQmNBSXBkcVplZk5CK2NsOFRqZnZtaHoz?=
 =?utf-8?B?UW9JWktTaGVIQno2V1J1SzE0U1FJZ0Q2L3A4d1kzWDYwOWE5Z2tZbTVLUzZt?=
 =?utf-8?B?YjFPM1dzQUdIdnErMFc3T2FRbzdHTFVuSm9vSXJyd3BLS0ZwQjJsamtmQVJU?=
 =?utf-8?B?bTZzSjU3OWRvYmtIeHN1OERDdGFCc21LcjMvNFhlbUZUVVdBT24xOWVTUXhY?=
 =?utf-8?B?WDhYbzQ3Nk9QVVdFYnc3YXpFUU5ubVQ5MDFoVS9wQUdQZDRkRDVwdFJZTUc3?=
 =?utf-8?B?YkdjU1RpclJmMGlONWptbEY4QUVoUGJoa3NyaXZsKzRMRnluamUvNUNIK3RK?=
 =?utf-8?B?K1ZIWHY3WTFLdHhLUHdWR1BCODZCVzRaKytZRmV1NjNIN2htNnNrcEJYc0JD?=
 =?utf-8?B?STlyRjhBbWhVQWkzd0Z0NTYxTHRmSmpseXBmandMb095djRwcTJoNW5qdXpR?=
 =?utf-8?B?UGxwT2ZyUXJZMzBsd0RhQUNtZ3lEZmRUbG5oQ25TRm1OSk45bUpLbkRPZ2NM?=
 =?utf-8?B?S1ZhWWpBU3RYZ2p1Z0JDb0hYTVV5TTVDQXY4N1BvM0E3YThzRUQrSG5LS0s1?=
 =?utf-8?B?d1hpbFVvdDNqdDVOaGxsb2ZHQnlEdEF6SWhMSktaZWt6aE1VQTUySXpyWWJQ?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d398d70-da62-49ca-e972-08dd651a38e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 06:09:05.3960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rwHJ9cB1JYh7qbZl/hPnPe8ax+frg86+CgXvYjFi6YtLWNcu3mRLgyz12yxGV75McXkxJPljLJRiLx4n5jJAO8in4XhIMc1WfjeUV8+E4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0848
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

DQoNCj4gT24gMy82LzI1IDc6MjAgQU0sIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gQWRkIFN0YXJm
aXZlIEpINzExMCBDYWRlbmNlIFVTQiBkcml2ZXIgYW5kIHJlbGF0ZWQgUEhZIGRyaXZlci4NCj4g
PiBTbyB0aGUgY29kZXMgY2FuIGJlIHVzZWQgaW4gdmlzaW9uZml2ZTIgYW5kIHN0YXI2NCA3MTEw
IGJvYXJkLg0KPiA+DQo+ID4gVGhlIGRyaXZlciBpcyBhbG1vc3QgdGhlIHNhbWUgd2l0aCBrZXJu
ZWwgZHJpdmVyLg0KPiA+DQo+ID4gVGVzdCB3aXRoIFN0YXI2NCBKSDcxMTAgYm9hcmQgVVNCIDMu
MCArIFVTQiAyLjAgaG9zdC4NCj4gPiBUaGUgY29kZSBjYW4gd29yay4NCj4gPg0KPiA+IFRoZSBT
dGFyZml2ZSBKSDcxMTAgaGFzIGVuYWJsZSBDT05GSUdfT0ZfVVBTVFJFQU0uIFRoZSBkdHMgaXMg
ZnJvbQ0KPiA+IGtlcm5lbA0KPiBBcHBsaWVkIGFsbCBleGNlcHQNCj4gDQo+IFtQQVRDSCB2NyA4
LzhdIE1BSU5UQUlORVJTOiBVcGRhdGUgU3RhcmZpdmUgdmlzaW9uZml2ZTIgbWFpbnRhaW4gZmls
ZXMuDQo+IA0KPiBDYW4geW91IHBsZWFzZSByZWJhc2UgdGhlICJNQUlOVEFJTkVSUzogVXBkYXRl
IFN0YXJmaXZlIHZpc2lvbmZpdmUyIG1haW50YWluDQo+IGZpbGVzLiIgYW5kIHNlbmQgaXQgc2Vw
YXJhdGVseSA/DQo+IA0KPiBJIGFscmVhZHkgc2VudCBVU0IgUFIsIHlvdSB3ZXJlIG9uIENDLCBz
byB5b3Ugc2hvdWxkIHNlZSB0aGUgMS84Li43LzggcGF0Y2hlcw0KPiBhcmUgYWxyZWFkeSBvbiB0
aGVpciB3YXkgdG8gdS1ib290L21hc3RlciAuDQo+IA0KPiBTb3JyeSBmb3IgdGhlIGFieXNtYWwg
ZGVsYXkgaW4gcmVwbGllcyBvbiBteSBzaWRlLg0KDQpUaGFua3MhIEkgd2lsbCByZXNlbmQgdGhl
IG1haW50YWluZXIgcGF0Y2gNCg==
