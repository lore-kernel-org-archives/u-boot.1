Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F59E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 03:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA478959A;
	Fri,  6 Dec 2024 04:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775F088F27; Fri,  6 Dec 2024 03:15:51 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41412895C1
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKlBiBkVGmxYnxECtuJewcExH9AA+tfDUJtON3A62F1iO4lWahnFyZgl/Y8CUZMtsaadVVv8uxc2GZz4ICj6+pjnkl3g7W4M2LruCiesCjiVHibU//6ok9UJi5SDs1lKSGA7NG75tlv3VRciugH4RkW9t2fAiBOc0JpN2jDNGUKfetxMYuOAaFXVHB+lwqpJmy93DegBxGRII7YPRDtoRS8T4SVF95+dhwm3VXyZViMfVZINUNnig7F7L/LeIV7izJF9JhCnQsnMGgsKew9YMgB6u9hvALgxk0YpHT3K4Z78P50ISqCGZ/31kjEiwMHbTimk6rng7YpA3a9jabGLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsYYpDy4YtephfvANZ5fOKPQVElbPOyuw+vMZ2EWwug=;
 b=LYWRYiDVaVWqjTMo2459AhvyreT0xMoW9lg6CDinEfuaUtj5CC1/f9Lt0HjXH4N3YR/KrHIAsUYf3aADYTAtUwMfzoCMQ9T+PS+lBlKEQacTNxV+9tl3VoFQOEvJYj1xxgJAfQ5Cbh8nMoGZ2RVTgZosUapCaS9LWSLYJx5OWCB7yCglYwcFX0G+gCn1M4C/Si7Btb0aTs2sX9o9nvKbd4OyQRwRxuQV/1cVQl+kATuz5ngB6NCMSqxLvROVwVMKjvz1FJJhLpBpDqLkUdbmqlocC2t1GqmE4yHnaBkm3fh8Lg19IJV26Nn1ADRV2cQAQlMhL6ixA90qPg9P5+oa3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Fri, 6 Dec
 2024 02:16:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Fri, 6 Dec 2024
 02:16:07 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, Bo Gan
 <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 02/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Thread-Topic: [PATCH v7 02/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
Thread-Index: AQHbRTBU1L2i+i4SoEyVX9rpPL5kb7LWdQeAgAH/4SA=
Date: Fri, 6 Dec 2024 02:16:07 +0000
Message-ID: <ZQ2PR01MB1307FD96BA7FA8C4354DF53DE631A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-3-hal.feng@starfivetech.com>
 <CANV2PTO5HwM6p_Q2mRx+B4n21ZWtrNrdVfmJp357MdDxWAcrQg@mail.gmail.com>
In-Reply-To: <CANV2PTO5HwM6p_Q2mRx+B4n21ZWtrNrdVfmJp357MdDxWAcrQg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
x-ms-office365-filtering-correlation-id: aa21f954-c33b-471d-ecc0-08dd159bf16e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|38070700018; 
x-microsoft-antispam-message-info: oqezi8TKPcQp7ZoWOOgvWfSSVj+2hiePn36anaENdkF4f051370vXG3u+/FWwBlM7A/guXe2Mxk/8GHBR2ls0QAlh1a2r2f8UFB+Gnux+zLTAoTCL+3ULZiYbPeBoL+exyS02+HDxDLB+oHnUNBaoQKO33lto9q2WHWP7CJEOLylt8ifaFAYkJ+RYP4EYKjsRodVIlO43R9j/SGwfjpXTXusYnoygkgSmSr7lc7YFReUhsqVZSjJN1wcsa3IP0GGrqBk/0L88dZ/sEJWfWSOUNEU2I/w6ftR3gX3SXo68x0dPHREs29Xn0Vps55k3DbvEcINcCn4Zi/73yRoUuKm8qBoEmpuRKe4VSjsl74N9nX+GdIFTE6/JFKIYsQVJzK/9lj8aiIzKT/6yl2/PRUh7zPJmvZ8GblRJbofb1iTaS/WC1CTqQYiPR4YvvQtmZfV280Rs5X82d1xDkbpPAQYZ4aOqxlruCcqcktjzR7sMJss/aSAX+E32hQWx+SoaIs2t/1eWImYnwcA3YnRux9+J9v12AJ03p/PfpeMFecufdgihBr5j6mjCAj5/J0MBAAyGXLBaL+wO0exL6y1CiHm5DWegdGkPW9hNdX2cLnvTgvSPuPclRDYLlm+s8cnvQ/f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRmMjYrUFNLeUx1a05vKzBiNS83bjMvL2phT0FlOFRvejdVM0dSaHNTNGRM?=
 =?utf-8?B?RnA0N3NXZ1Rpb2dsZGxJMlZUb0dHYmFNM1Rhb3k0eWE5V0wwTmRGMlBpK0Zm?=
 =?utf-8?B?TUhBR0hFeEZhTEJtY3VjZHYwN0VxT1FnTlZ5cWZnZ0FHWTdiQXE0eE5aVHVE?=
 =?utf-8?B?WU1RL0d0SXJXb2lqV0pWNy9QeDFVN2lJM041RzBwRjBwemd1T1ZLWG9sUi9y?=
 =?utf-8?B?Uy92ZHBhV1JwYy9ERHR0Z09TY0JhMms5QTlJVzZudGhTdmhybDY1d1ZnNUJH?=
 =?utf-8?B?MllDVnNwSW0rZTd3R3VZYllaUVVLMk14cHdSOWNpTVYxT2xxLy8yclJsVkZT?=
 =?utf-8?B?bVJGRSt5TFBQT2puNjVDUEdGb3kxTVZnRGc3SjlyaFJhU0VlRzh6NWZ1U3By?=
 =?utf-8?B?UFNiZ2VaanN2UjY5ODhGaHptTXF5ckJJZWRIZldnZUpGZmJxVmV2YlBwenpC?=
 =?utf-8?B?cUZqV1VJbE5QQVNMMlJpbFpBakVtU1E5V1ZzTkRVRzhGejk3WElwQVlMRS9s?=
 =?utf-8?B?Mko3eDNmNnhJU0daR1R4Zklxd2lNRW9DcWVNRWd3Ym5sK0YwZWhCSy9vZHM0?=
 =?utf-8?B?N3VjVjVrTVdpUG1xL3lHUmQvSGFRNVc1eDA1ZEdCSHd2MnlQbUxFb3VPQXh2?=
 =?utf-8?B?alhBK1U2ZDdnbkVMZ29iaERRSzJxbVE2WGYvS05KSEFGNUVvMEsrd3I0Vlpp?=
 =?utf-8?B?YmgvTnU2VEM1UlI2TVcwSmNudklpcmNvTVlJK2dROTRxZUVOdlpSZE9jM2hS?=
 =?utf-8?B?Y1Y2YnJzSDJHMlJnSlJselVvMjdWQ1JqN1VIYzRGcUJqTk5YRlFPV1liMHE1?=
 =?utf-8?B?V1cvWXNSd05DM3NHR2ZDVXI2cUNLR1BZTnNtYXVNdm5QM0c2cUd3MGlXVGJJ?=
 =?utf-8?B?RkU0clR2WVNDSmlWdklEVjFuU2tuZDJVV0VCbDJtQ1V4aVZZTHRpYVBSKy9j?=
 =?utf-8?B?MEk3K25UTFV4YkV5ckVNZ2YyUm9hT3hCZUZRN1BKOTVObEVsUW4vTDkwVDJP?=
 =?utf-8?B?c3RnenBWL1p6STg0NnRwUjBSbysxNEdOd3RMaEdZNXkvNU9vaEJDUnBTTnRl?=
 =?utf-8?B?RzV4dWVOK0gweGszbk56WS9IV0dzUXpWdjBBR0I2UEcvK2F4cE83ZGQ1S0wx?=
 =?utf-8?B?Zk12QnVaclJpelExTmNkYVM2VzNZRnFHR01IdUh0aVJhd09JRzNwYW5TZGhR?=
 =?utf-8?B?SGVOWWZ2K3VVb3V6UXdRdEo4d25PVGNQaFRtS1k4K0M5TUJYOUxCYVN4bW1o?=
 =?utf-8?B?RlJPbGJqVG1VSitRbXc5VnBUV2xGa25pK1R6cU1nSkhpblhrVXhaZGVzc0NH?=
 =?utf-8?B?dlFpMkQ3SmU2MitneFA5bk9mdnJLdCs5dkFjdWtuemF0OHdFUUNYS0ZSa0Nn?=
 =?utf-8?B?UlZBV1FCdWpjOWlwQ2VOcmxxQWcrQStqNzhhZzZiZjFGN1JZdVNqcWNqSHhp?=
 =?utf-8?B?Z0krTkowMjlHSkhYTXVJRC85RzYwMzZsdmlzUXlXRmgvZG9wZ0g1MGRCcUhy?=
 =?utf-8?B?eW05TDRFMU44UHM3Nlg1UWtXby9JeEEwTUh4T3ZFbmtBWlJ3elZqMlJlaFpJ?=
 =?utf-8?B?NnhxL3k2Nk1jeHEyeEVZSi9lWm5pZVVtaVVKeHNSMWF1ZlNzREtUdUhRS3px?=
 =?utf-8?B?Y0JuSjN0eTBGT0dUMTZ6dDYzQVREdmR4RVEwQTgwNTRqWFlkeWtlaVFDWGdt?=
 =?utf-8?B?Y1kzSnp4WncvTXVzeU05akFHWHN4eU02WDFNOFdRckV0Skd1VDJudUc1TlU0?=
 =?utf-8?B?d3BLUTVBWG03ZXFyZDFGWUZ5S2kxSjZ2M1R0V2JKVVZLSGtOcXRKVGJIYUZ6?=
 =?utf-8?B?VlFkQlFJZFNOY0I3dTdKVjZ5TjBHejg5Z1htMkt2bmFINWgrcytrT0VzQ0ZH?=
 =?utf-8?B?ckNQZ3VhS2kzZE5Fa2gzaW5sMnJmSVdYdis3WHdDN3N5bmU1TXJMaU5TYUx0?=
 =?utf-8?B?MHNIZ2tTMnBNalRGV3g3TUZ3V2x5enNFN2RHVjJTSTlSbnhHS0V1VlpZUkdJ?=
 =?utf-8?B?QllXUVJSaDZRaFNDWW1ueEQwSkNSYStmYjd6R0x3MG82ekQyREpFa3ZLeG9i?=
 =?utf-8?B?NkxXS2dnVmFpWTQ1N2pHRE9FMmp5Y1FBc01PWndUSFA5TkpJUXB5MWhmTVRn?=
 =?utf-8?Q?vyDHyN+kFHjKVRk3M8p2Qkj6w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21f954-c33b-471d-ecc0-08dd159bf16e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:16:07.1041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ofTyQd+l43YoAyl9cTfzGnv+bevzax5ENHBmE/yi7sOB9A6W/QEj+IOwozCiDwKxkd5ZiDl83eNiwBUnivbax1Xuy++bWfAHr8hrevNcUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Fri, 06 Dec 2024 04:03:43 +0100
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

PiBPbiAwNS4xMi4yNCAwMzowNywgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiBNb24sIERlYyAyLCAy
MDI0IGF0IDc6MDXigK9QTSBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBBZGQgdS1ib290IGZlYXR1cmVzIHRvIHRoZSBVLUJvb3QgZGV2aWNl
IHRyZWUuDQo+ID4NCj4gPiBUZXN0ZWQtYnk6IEFuYW5kIE1vb24gPGxpbnV4LmFtb29uQGdtYWls
LmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEUgU2hhdHRvdyA8bHVjZW50QGdtYWlsLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogRSBTaGF0dG93IDxsdWNlbnRAZ21haWwuY29tPg0KPiA+IEFja2VkLWJ5OiBT
dW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFs
IEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLjEwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYi11LWJvb3QuZHRzaSB8IDMzICsrKysrKysrKysrKysr
Ky0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAtdS1ib290LmR0c2kgICAgICAgICAgICAg
fCAzNCArKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gv
cmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2ItdS1ib290LmR0c2kN
Cj4gPiBiL2FyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2It
dS1ib290LmR0c2kNCj4gPiBpbmRleCAzMDEyNDY2YjMwLi43OTUzNDU5ZTY3IDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2It
dS1ib290LmR0c2kNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlz
aW9uZml2ZS0yLXYxLjNiLXUtYm9vdC5kdHNpDQo+ID4gQEAgLTYsNiArNiwxMCBAQA0KPiA+ICAj
aW5jbHVkZSAiYmlubWFuLmR0c2kiDQo+ID4gICNpbmNsdWRlICJqaDcxMTAtdS1ib290LmR0c2ki
DQo+ID4gIC8gew0KPiA+ICsgICAgICAgYWxpYXNlcyB7DQo+ID4gKyAgICAgICAgICAgICAgIHNw
aTAgPSAmcXNwaTsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICAgICAgICAgY2hvc2VuIHsN
Cj4gPiAgICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gICAgICAgICB9Ow0KPiA+
IEBAIC0yNyw2ICszMSw5IEBADQo+ID4NCj4gPiAgJnVhcnQwIHsNCj4gPiAgICAgICAgIGJvb3Rw
aC1wcmUtcmFtOw0KPiA+ICsgICAgICAgcmVnLW9mZnNldCA9IDwwPjsNCj4gPiArICAgICAgIGN1
cnJlbnQtc3BlZWQgPSA8MTE1MjAwPjsNCj4gPiArICAgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDwy
NDAwMDAwMD47DQo+ID4gIH07DQo+ID4NCj4gPiAgJm1tYzAgew0KPiA+IEBAIC0zOSwzMCArNDYs
NDUgQEANCj4gPg0KPiA+ICAmcXNwaSB7DQo+ID4gICAgICAgICBib290cGgtcHJlLXJhbTsNCj4g
PiArICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDI1MDAwMDAwMD47DQo+ID4NCj4gPiAtICAg
ICAgIG5vci1mbGFzaEAwIHsNCj4gPiArICAgICAgIGZsYXNoQDAgew0KPiA+ICAgICAgICAgICAg
ICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArICAgICAgICAgICAgICAgL2RlbGV0ZS1wcm9wZXJ0
eS8gY2RucyxyZWFkLWRlbGF5Ow0KPiA+ICsgICAgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMDA+Ow0KPiA+ICAgICAgICAgfTsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmc3lz
Y3JnIHsNCj4gPiArICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmc3lzY3JnIEpINzExMF9TWVND
TEtfQ1BVX1JPT1Q+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgPCZzeXNjcmcgSkg3
MTEwX1NZU0NMS19CVVNfUk9PVD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICA8JnN5
c2NyZyBKSDcxMTBfU1lTQ0xLX1BFUkhfUk9PVD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICA8JnN5c2NyZyBKSDcxMTBfU1lTQ0xLX1FTUElfUkVGPjsNCj4gPiArICAgICAgIGFzc2ln
bmVkLWNsb2NrLXBhcmVudHMgPSA8JnBsbGNsayBKSDcxMTBfUExMQ0xLX1BMTDBfT1VUPiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnBsbGNsayBKSDcxMTBfUExMQ0xL
X1BMTDJfT1VUPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnBsbGNs
ayBKSDcxMTBfUExMQ0xLX1BMTDJfT1VUPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8JnN5c2NyZyBKSDcxMTBfU1lTQ0xLX1FTUElfUkVGX1NSQz47DQo+ID4gKyAgICAg
ICBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwwPiwgPDA+LCA8MD4sIDwwPjsgfTsNCj4gPiArDQo+
ID4gICZzeXNncGlvIHsNCj4gPiAgICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICB9Ow0KPiA+
DQo+ID4gICZtbWMwX3BpbnMgew0KPiA+ICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gLSAg
ICAgICBtbWMwLXBpbnMtcmVzdCB7DQo+ID4gKyAgICAgICByc3QtcGlucyB7DQo+ID4gICAgICAg
ICAgICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICAgICAgICAgfTsNCj4gPiAgfTsNCj4gPg0K
PiA+ICAmbW1jMV9waW5zIHsNCj4gPiAgICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+IC0gICAg
ICAgbW1jMS1waW5zMCB7DQo+ID4gKyAgICAgICBjbGstcGlucyB7DQo+ID4gICAgICAgICAgICAg
ICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICAgICAgICAgfTsNCj4gPg0KPiA+IC0gICAgICAgbW1j
MS1waW5zMSB7DQo+ID4gKyAgICAgICBtbWMtcGlucyB7DQo+ID4gICAgICAgICAgICAgICAgIGJv
b3RwaC1wcmUtcmFtOw0KPiA+ICAgICAgICAgfTsNCj4gPiAgfTsNCj4gPiBAQCAtNzgsNiArMTAw
LDkgQEANCj4gPiAgICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICAgICAgICAgZWVwcm9tQDUw
IHsNCj4gPiAgICAgICAgICAgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gKyAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsMjRjMDQiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcg
PSA8MHg1MD47DQo+ID4gKyAgICAgICAgICAgICAgIHBhZ2VzaXplID0gPDE2PjsNCj4gPiAgICAg
ICAgIH07DQo+ID4gIH07DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9kdHMvamg3
MTEwLXUtYm9vdC5kdHNpDQo+ID4gYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtdS1ib290LmR0c2kN
Cj4gPiBpbmRleCA1MmMxZDYwODU5Li4yMWEyYWIxNzg5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
cmlzY3YvZHRzL2poNzExMC11LWJvb3QuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvZHRzL2po
NzExMC11LWJvb3QuZHRzaQ0KPiA+IEBAIC00Niw2ICs0NiwxNSBAQA0KPiA+ICAgICAgICAgICAg
ICAgICB9Ow0KPiA+ICAgICAgICAgfTsNCj4gPg0KPiA+ICsgICAgICAgdGltZXIgew0KPiA+ICsg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInJpc2N2LHRpbWVyIjsNCj4gPiArICAgICAgICAg
ICAgICAgaW50ZXJydXB0cy1leHRlbmRlZCA9IDwmY3B1MF9pbnRjIDU+LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjcHUxX2ludGMgNT4sDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNwdTJfaW50YyA1PiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY3B1M19pbnRjIDU+LA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjcHU0X2ludGMgNT47DQo+ID4g
KyAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgIHNvYyB7DQo+ID4gICAgICAgICAgICAgICAg
IGJvb3RwaC1wcmUtcmFtOw0KPiA+DQo+ID4gQEAgLTczLDEwICs4MiwzNSBAQA0KPiA+ICAgICAg
ICAgYm9vdHBoLXByZS1yYW07DQo+ID4gIH07DQo+ID4NCj4gPiArJmdtYWMwX3JnbWlpX3J4aW4g
ew0KPiA+ICsgICAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICAmZ21h
YzBfcm1paV9yZWZpbiB7DQo+ID4gICAgICAgICBib290cGgtcHJlLXJhbTsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsmZ21hYzFfcmdtaWlfcnhpbiB7DQo+ID4gKyAgICAgICBib290cGgtcHJlLXJhbTsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyZnbWFjMV9ybWlpX3JlZmluIHsNCj4gPiArICAgICAgIGJv
b3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+ID4gKyZzdG1tYWNfYXhpX3NldHVw
IHsNCj4gPiArICAgICAgIHNucHMsd3Jfb3NyX2xtdCA9IDw0PjsNCj4gPiArICAgICAgIHNucHMs
cmRfb3NyX2xtdCA9IDw0PjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZnbWFjMCB7DQo+ID4gKyAg
ICAgICBzbnBzLHBlcmZlY3QtZmlsdGVyLWVudHJpZXMgPSA8OD47IH07DQo+ID4gKw0KPiA+ICsm
Z21hYzEgew0KPiA+ICsgICAgICAgc25wcyxwZXJmZWN0LWZpbHRlci1lbnRyaWVzID0gPDg+OyB9
Ow0KPiA+ICsNCj4gDQo+IFJlZHVuZGFudCAmc3RtbWFjX2F4aV9zZXR1cCAmZ21hYzAgJmdtYWMx
IHByb3BlcnR5IG92ZXJyaWRlcw0KPiAodXBzdHJlYW0gaGFzIGFsbCB0aGVzZSkuIERyb3AuDQoN
Ck9LLiBBY3R1YWxseSB0aGVzZSBwcm9wZXJ0aWVzIGFyZSB1bnVzZWQgaW4gVS1Cb290Lg0KDQo+
IA0KPiA+ICAmYW9uY3JnIHsNCj4gPiAgICAgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICB9Ow0K
PiA+IC0tDQo+ID4gMi40My4yDQo+ID4NCj4gDQo+IFRoZXJlJ3MgYWxzbyBhIHJlZHVuZGFudCAm
UzdfMCB7IHN0YXR1cyA9ICJva2F5IjsgfTsgd2hpY2ggY2FuIGJlIGRyb3BwZWQsIGl0DQo+IGlz
IG5vLW9wIHNpbmNlIHRoYXQgYWxpYXMgaXMgYWxyZWFkeSBzZXQgdG8gYmUgc3RhdHVzPSJva2F5
Ii4NCg0KT0suIERyb3AgaXQuDQoNCj4gDQo+IEkgdGVzdGVkIG9uIFN0YXI2NCBuZXR3b3JrIGZ1
bmN0aW9uIGFuZCBjb2xkIGJvb3QsIGlzIGZpbmUuIFdoYXQgcmVtYWlucyBhcmUNCj4gdGhlIGxp
YmVyYWwgdXNlIG9mIGJvb3RwaC1wcmUtcmFtIHByb3BlcnRpZXMsIHRoZSBEUkFNIE1lbW9yeSBD
b250cm9sbGVyDQo+IGRtYyB3aGljaCBkb2VzIG5vdCBhcHBlYXIgeWV0IGluIExpbnV4LCB0aGUg
dGltZXIge30gbm9kZTsgZWxzZXdoZXJlIHRoZQ0KPiBlZXByb20gYW5kIHVhcnQgb2Ygd2hpY2gg
dGhlIGVlcHJvbSBhbmQgYm9vdHBoLXByZS1yYW0gcHJvcGVydGllcyBjYW4NCj4gcHJvYmFibHkg
Z2V0IHVwc3RyZWFtIGVhc2lseSBlbm91Z2ggbGF0ZXIgb24uDQo+IA0KPiBZb3VyIGNob2ljZSBp
ZiB5b3Ugd2FudCB0byB0cmltIHRoZXNlIHJlZHVuZGFudCBwcm9wZXJ0aWVzIGhlcmUgb3IgaWYg
aXQgc2hvdWxkDQo+IGJlIGRvbmUgYXMgYSBsYXRlciBjbGVhbi11cCBwYXRjaCwgYXMgdXBzdHJl
YW0gZG9lcyBub3QgaGF2ZSB0aGUgc2FtZSB2YWx1ZXMNCj4gZm9yIHRoZXNlIHByb3BlcnRpZXMg
YWxsLg0KDQpJIHByZWZlciB0byBzZW5kIGEgY2xlYW4tdXAgcGF0Y2ggYWZ0ZXIgc29tZSBjaGFu
Z2VzIGxpa2UgcXNwaSBhbmQgZWVwcm9tIGFyZQ0Kc3luY2VkIHRvIHVwc3RyZWFtIExpbnV4LiBC
ZWNhdXNlIHRoZSBjbGVhbi11cCB3b3JrIGlzIG5vdCB0aGUgcHVycG9zZSBvZg0KdGhpcyBzZXJp
ZXMgYW5kIEkgd2lsbCBub3RlIGFsbCBwcm9wZXJ0aWVzIHRoaXMgc2VyaWVzIGNoYW5nZXMgaW4g
dGhlIGNvdmVyIGxldHRlci4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
