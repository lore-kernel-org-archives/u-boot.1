Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055CBD3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46624895C5;
	Mon, 25 Nov 2024 01:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF8588E77; Mon, 25 Nov 2024 00:30:56 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006FC88E24
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glHnr8iUeokh8h9XKgBJHk4Fq2TG9AJr+Wjht0JdwIpfe0PKb4UGuOZbiGH2xN9gYDR4WocpDDop0jxDQUXUzbt8hwsay6YyOIQnIrKXG43Qx0GAeCAkGZ+d5ZYhde9JEJzZNySwPJKdLAIxup6fdX/ykiY15Fv5MQqGsl6WfmJgZvseHyAnaHeF/WAG50B6qPvGjjzqny3mY5J4hINjavTtdmDUC79idJCP6gMfCVfv0OIa3xivCTyzf9qnIz5xIzfVeK1TaK7V5rguaxHK1sqoE95BI/nLxRmZWULvDwlIekbpr9dsx/xpcHU3fYskGZb4nMhbq5+kBKBzNtiiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N36hBOe5ZzHLovJlySu1/bmoPyWw/iRkrQh4eKDPes=;
 b=laH/dUIqMoE09nvhwUKELjHaRfH1yEAWT/xM3KG72VljLF4j7NKr5kgBAnvcIRcEX2PQxcsQnQgseHWm1XpoKty4odJljzBnSjlOSo4tnMn8sb3+9Zng2XOvzsWxBeOVvnttAVk3TQ5WvwXyfECP4avFTYCD3U0qWynFA+v5y+GePUe+rly5sYzSzzrZIu9mbHlJIQEpunq7GOcirjoQNO0ZQ2ouyP5OzI0H3qy/8DjXxGspGDOcxVoq6YKSlvruSdVICYB73blYnGhnlbi1bbb7GqBwUYwwSTp4pEHfLmrV953/4pFbBo1kKb/7hS27VAH4wyKtuleOlcyN92CADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn (10.2.1.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Sun, 24 Nov 2024 23:31:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Sun, 24 Nov 2024
 23:31:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell
 <dmoo_dv@protonmail.com>, Conor Dooley <conor.dooley@microchip.com>, Nam Cao
 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Thread-Topic: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Thread-Index: AQHbOieWt6KNhYRav0OxhRy1MCwBbLK9/JQAgATiZoCABDnXAA==
Date: Sun, 24 Nov 2024 23:31:08 +0000
Message-ID: <ZQ2PR01MB1307E24359DEB55E5ABB8569E62DA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
 <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
In-Reply-To: <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_
x-ms-office365-filtering-correlation-id: faad055e-1ae7-4fd9-1d4f-08dd0ce012bc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|38070700018; 
x-microsoft-antispam-message-info: +oVgoAvtSHbtmKBLpQ2ImpfVseCdT+bD6nE+7uFzKxfKHIZzAxgW/37VfVOqkqhOuqZfWfougzHSW32hn6g7Y0a9VbdHAYy21w6y8e7ZNDgX3BJ0W/dL3Kg+m6PjKd0X++5WlrO5paup9ET5a5MRlRF8SfViyTc11VU7LELj+Zq55isv+qTa1t534AhZuCFGkfYmeLM+oWy04PYfpMdzPgyY/pbjgylZO61680ntI674jC+ET4iWQjIaqq0hjJFPDl07lIBUGVpfzr0qekAyw5TMMBdUFsCdrVLe4aMEyienBxviXCWm6UrR+8sUIw1t0G6y03TpTWQ8j8jg/b5TtguRBoNojcw/QnPGMj/MF5a7FCm89T0PtWVa8zkX0Ir7FdmLeDDIQiYpdA6Oh2y3gkvb9fjoAwF0c+eX2hq7WUj+2Dph9mCLHeWt9yo3nnRnV1kjp0FirepJPlaavsszKC7IXzkTrog0npnIv4fRusAmGDa7maEOS3SDdBMDUpXoeLYUZTrQ/2aW/0S6puOz2IyVWAyiDAW8Ti3YNSLNN7EWhWxccqH1qi/Htcn7OIaqdOs1fi6Cs8B/wVQQNJzDfbaMc0WMoz2kKtS+EGAMQNL8bWgoAweylIESabMOqsZc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBVVDBwMnE5N1VEMktwMGhGaERiOEpkazJhTWt0aDZGVjBsQWc4ZzZhL0M5?=
 =?utf-8?B?MGVkNlo3aDBwdUJNd2k3ZEdRd20rcnVKR2tBcnRDNUFzaUozRHVVT2JSV0NH?=
 =?utf-8?B?anFadDFqNHRWU01FbXBJUDFxQ0dBZm9tR1JiVXJqdXMwS21FNjZMUUZZWmJU?=
 =?utf-8?B?VEVnQnlsUlU3c3A0VkdFclBrZEFXYnhSQUhEWHoxNGNjVmJtaTU5cmdnVnBF?=
 =?utf-8?B?OGhOK25OUXArbFBISTh0ZDgyTy9adytwU1FWd2QrR1d3YW1qWnpWV24yUjZz?=
 =?utf-8?B?ajNvLzJYL3YvbHhKNUVaR25mKzlPVXlaTlZnamNUY3BYMHFKbHlXVStJcmYy?=
 =?utf-8?B?d05nMEora1BRbnRTRmcvZXlLL0NIOXUwOWI5S3NlYkZFL3dkZDBGeGZwWTV1?=
 =?utf-8?B?YlRKd1NHUnRlSU5YRFhFVStlZ0M3SHZWdXk2ZUlkTVQ3eGhNTDl5R3lRNFVZ?=
 =?utf-8?B?cmIwWnFTeDBBeGxZUmNXQkhsUDVTWjVleVRUNE1MVTNMc3FvWlZBSmlDRDZH?=
 =?utf-8?B?M0NXTHZGLzNWRzM3RzJrUWFkRlNWYy96ZjZGdWhDUTlvMEdzcUcxaHdYbGpt?=
 =?utf-8?B?cHcwMGY1SktqS09SMDFSYXF0YzNkVHB6RWxUTlA3YThzVWVKSm1VT21FRUd1?=
 =?utf-8?B?eEdzbERYa0x3Z0xQd2JDdytCTGMxMWhyWGpCSi82cFd4YTZZUTJMRFV6emhT?=
 =?utf-8?B?cGdrL0JVQUszN1VsdDNsSHl6c0s4SVg0S3JiOG5qd3U4RXhQUGRhREJJTXcy?=
 =?utf-8?B?N0xmYVJPQ0hDVWFXa3NIcm5jTEhYTnI1SFVUaUUzRDFzUnRuNkpiN1Y3NHRs?=
 =?utf-8?B?cXAzUzhQdTFmdlZVUFZ3VE90VGd2TTVIdnFnQklaMUJQWWNvRHpGTVROd0cv?=
 =?utf-8?B?cVVYNkFOdE1uU1FVMHpoM2QvRWVOUzNHcGJ4a0g2REJjVzAzcEdFZk1aaWht?=
 =?utf-8?B?UjNBSFNGMk1JT2o0dDYrOVo4UXpDZS82YkVERmZPNy9FcXZ4L050QlBaeEN3?=
 =?utf-8?B?TjdLNzBqQ0hvQzVxWC96V0cwZU9Bd1doNVlLTnVhQ3hqZ3JERmZLSTBza0dV?=
 =?utf-8?B?RWw4cE4yZ1FRdnZqOWw5cnZCMUdXWXM2K0NyeUN0NzJRVXFkUGdjM21WWUR1?=
 =?utf-8?B?eDR5eWNIUHV4aWovNEdRYmd3a0pRMmZIYWFzNUkvaVh3aG9OM3diQkQvUzE0?=
 =?utf-8?B?b0hXcDlmOWdIcXNJMmtjVWhJRGo2RDI1Y2x2MXhzcnd6N0cxYkJUQ25oOFZR?=
 =?utf-8?B?ZHJSQkN3cG84eHBvNGhKcGtYNm9icW9zU1VPTHptYkFHbnFCc2RQR1ArRm5R?=
 =?utf-8?B?WWt2MUNZUlNmd3VoNS9DV3pLWUNlaHdiYWJMLzRSWUFqUDBmOHB3MTFQc0F6?=
 =?utf-8?B?QWRwS0NPd081TUQ3VkZHbVc4NFlJT0dQZzBOWk1KenBoNlN2VHZPYzNENU9V?=
 =?utf-8?B?eHJwM2NiS0hZZmNSVFdtWVZKZzVWenBsZitRYkNkaGpqbjB6S1gwT1RRL1Q2?=
 =?utf-8?B?M09JSm5MSmN5aTFlQ3dsWW1VSWhlTFloWDYrVWdFWDJ6dGU2OU10TWpLQlpK?=
 =?utf-8?B?UldSd1BqaW1HUGQ0dkxtZzZZRXFjV3JaWTY3NGt1QjFHU05udkxUdmRLZDJh?=
 =?utf-8?B?dVFLNGNzRkljejlkN0J4NkdXK2Z3K3Z4ZGw1eWN0eHBNc255MDFpOTBYcFJF?=
 =?utf-8?B?NHBuczBYcDU2cGtGL0Y3S0hEZlF3M2tJbjIrTE5MaHdrdTNsNEJFd3h1N05z?=
 =?utf-8?B?b1hKNkR3VndnVk5BTzZwUmpNZ2MraGp3L1JwdGdZbENuKzdicEk3NzdWd05F?=
 =?utf-8?B?a3I4RUpBMkVlYTBSYnlubnNKTmhWQVhoSWdsanZIWWVGeFM3VTFrMDdXU1ZO?=
 =?utf-8?B?MGJKQldwd1cwRkluT2R6cDhOUmE3VTZESGJTQXA3elZlRFpZV3FGQlJtYmFK?=
 =?utf-8?B?cDhKc0tpZmJzM1VFSy95Z1dvbVhlcnN5SmRoQmxUR1B1MHl3U2ZzRWx3SUpx?=
 =?utf-8?B?MmtvOTQwQzhmd3hmVUE0ZXlGZzZLWjF0R1Q4ekV5SmZiZXNTRkpIWEhvZVRF?=
 =?utf-8?B?aG16SS94di93bldveWtzZFpxRmZGRVduOWxBZUxtSmE4ZExTZzc4cktSeStN?=
 =?utf-8?Q?3zSYAYxtKg+JpWKlMKKVNgg3y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: faad055e-1ae7-4fd9-1d4f-08dd0ce012bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2024 23:31:08.2501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NN48I4eud5hY6lr7cDeDLXaTMN99cxnifghTllxteVf/rAzdw2Yp4S8lPqN4/SlqDpFLs4WzNm3lSb4axCl475vjjuJsFrz7SkglnjkSxkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1307
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

PiBPbiAyMi4xMS4yNCAxNDo0MiwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiBNb24sIE5vdiAxOCwg
MjAyNCBhdCA4OjA24oCvUE0gU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gT24gVHVlLCAxOSBOb3YgMjAyNCBhdCAwNzoz
NSwgSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IEFkZCB1LWJvb3QgZmVhdHVyZXMgdG8gdGhlIFUtQm9vdCBkZXZpY2UgdHJlZS4NCj4g
PiA+DQo+ID4NCj4gPiBGb3IgZm9sbG93LXVwIHdvcmssIEkgd291bGQgc3VnZ2VzdCBtaW5pbWl6
aW5nIFUtQm9vdCBzcGVjaWZpYyBEVA0KPiA+IGJpdHMuIFlvdSBjYW4gZWl0aGVyIHJlLXVzZSB3
aGF0J3MgYXZhaWxhYmxlIGluIHVwc3RyZWFtIERUIG9yIHB1c2gNCj4gPiBVLUJvb3Qgc3BlY2lm
aWMgY2hhbmdlcyAoZWcuIGJvb3RwaC0qIHByb3BlcnRpZXMgZXRjLikgdXBzdHJlYW0uDQo+ID4N
Cj4gPiBGV0lXOg0KPiA+DQo+ID4gQWNrZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAbGlu
YXJvLm9yZz4NCj4gPg0KPiA+IC1TdW1pdA0KPiANCj4gU3VtaXQsIHdpdGggdGhlIHdob2xlIHNl
cmllcyBhcHBsaWVkIHRoaXMgVS1Cb290IHNwZWNpZmljIERUIGFkZGl0aW9uIGlzDQo+IGNvbmZp
bmVkICh3aXRoIGV4Y2VwdGlvbiBvZiB3aGF0IEkgY29tbWVudCBvbiBiZWxvdyBmb3IgcnggZGVs
YXkgdmFsdWVzIG9uDQo+IFZGMiAxLjNiKSB0byBhIHNpbmdsZSBpbmNsdWRlIGZpbGUuIExvb2tp
bmcgYXQgbGludXgtbmV4dCB0aGVyZSBpcyBhIGJpdCBvZiByZS0NCj4gb3JnYW5pemF0aW9uIHNp
bmNlIHRoZSBGcmFtZXdvcmsgLyBEZWVwQ29tcHV0aW5nDQo+IEpINzExMCBtYWluYm9hcmQgbW92
ZWQgbW9yZSBub2RlcyBvdXQgb2YgdGhlIGNvbW1vbiBmaWxlIGFuZCBpbnRvIGJvYXJkDQo+IHNw
ZWNpZmljIGR0cy4gV2hlbiB1cHN0cmVhbSBkdHMgc2V0dGxlcyBhZ2FpbiB0aGVuIHRoZXJlIHdp
bGwgYmUgc29tZSBtb3JlDQo+IHdvcmsgdG8gdXBkYXRlIHRoaXMgYW55d2F5cy4gSXMgaXQgYW55
IGJsb2NrZXIgZm9yIHlvdSBub3c/DQo+IA0KPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwg
RmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLjEw
LXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYi11LWJvb3QuZHRzaSB8IDQzICsrKysrKysrKysr
KysrKysrLS0NCj4gPiA+ICBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAtdS1ib290LmR0c2kgICAgICAg
ICAgICAgfCAzNCArKysrKysrKysrKysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDczIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNiLXUt
Ym9vdC5kdHNpDQo+ID4gPiBiL2FyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25m
aXZlLTItdjEuM2ItdS1ib290LmR0c2kNCj4gPiA+IGluZGV4IDMwMTI0NjZiMzAuLmZhYzllMTZm
YjEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlz
aW9uZml2ZS0yLXYxLjNiLXUtYm9vdC5kdHNpDQo+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2R0cy9q
aDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNiLXUtYm9vdC5kdHNpDQo+ID4gPiBAQCAt
Niw2ICs2LDEwIEBADQo+ID4gPiAgI2luY2x1ZGUgImJpbm1hbi5kdHNpIg0KPiA+ID4gICNpbmNs
dWRlICJqaDcxMTAtdS1ib290LmR0c2kiDQo+ID4gPiAgLyB7DQo+ID4gPiArICAgICAgIGFsaWFz
ZXMgew0KPiA+ID4gKyAgICAgICAgICAgICAgIHNwaTAgPSAmcXNwaTsNCj4gPiA+ICsgICAgICAg
fTsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgY2hvc2VuIHsNCj4gPiA+ICAgICAgICAgICAgICAg
ICBib290cGgtcHJlLXJhbTsNCj4gPiA+ICAgICAgICAgfTsNCj4gPiA+IEBAIC0yNyw0MiArMzEs
NzAgQEANCj4gPiA+DQo+ID4gPiAgJnVhcnQwIHsNCj4gPiA+ICAgICAgICAgYm9vdHBoLXByZS1y
YW07DQo+ID4gPiArICAgICAgIHJlZy1vZmZzZXQgPSA8MD47DQo+ID4gPiArICAgICAgIGN1cnJl
bnQtc3BlZWQgPSA8MTE1MjAwPjsNCj4gPiA+ICsgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDI0
MDAwMDAwPjsNCj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICAmbW1jMCB7DQo+ID4gPiAgICAgICAg
IGJvb3RwaC1wcmUtcmFtOw0KPiA+ID4gKyAgICAgICBjb21wYXRpYmxlID0gInNucHMsZHctbXNo
YyI7DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAgJm1tYzEgew0KPiA+ID4gICAgICAgICBib290
cGgtcHJlLXJhbTsNCj4gPiA+ICsgICAgICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3LW1zaGMiOyB9
Ow0KPiANCj4gPiA+ICsNCj4gPiA+ICsmcGh5MCB7DQo+ID4gPiArICAgICAgIHJ4LWludGVybmFs
LWRlbGF5LXBzID0gPDE5MDA+OyB9Ow0KPiA+ID4gKw0KPiA+ID4gKyZwaHkxIHsNCj4gPiA+ICsg
ICAgICAgcngtaW50ZXJuYWwtZGVsYXktcHMgPSA8MD47DQo+ID4gPiAgfTsNCj4gDQo+IEhhbCwg
cGxlYXNlIGRyb3AgdGhlIG92ZXJyaWRlIG9mIHJ4LWludGVybmFsLWRlbGF5LXBzIG9uIHBoeTAg
YW5kIHBoeTEgYW5kDQo+IHNpbXBseSBub3RlIGluIHRoZSBjb3ZlciBsZXR0ZXIgdGhhdCByeCBk
ZWxheSB2YWx1ZXMgZm9yDQo+IFZpc2lvbkZpdmUyIDEuM2IgbmV0d29yayBwaHkwIGFuZCBwaHkx
IG5vdyBmb2xsb3cgdGhlIHVwc3RyZWFtIGR0cy4NCj4gVGhlIGVmZm9ydCB0byBrZWVwIHRoaW5n
cyB0aGUgc2FtZSBhcyBleGlzdGluZyBVLUJvb3QgaXMgYXBwcmVjaWF0ZWQsIGhvd2V2ZXIsIEkN
Cj4gdGhpbmsgaXQgd2lsbCBjYXVzZSBhIHByb2JsZW0gaGVyZS4NCg0KQWdyZWVkLCBJIGFsc28g
cHJlZmVyIGtlZXBpbmcgdS1ib290IERUIHNldHRpbmcgdGhlIHNhbWUgYXMgTGludXggYW5kIHRo
aXMgd29uJ3QNCmNhdXNlIGFueSBlcnJvcnMuDQoNCkJlc3QgcmVnYXJkcywNCkhhbA0K
