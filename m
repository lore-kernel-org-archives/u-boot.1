Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962FD5B870
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 03:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919E889152;
	Tue, 29 Oct 2024 04:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590F689169; Tue, 29 Oct 2024 03:16:54 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF62588C7B
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 03:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMTCKi5NkWbqYNdT828p4lGba76NXwejl/2Ybc9vZ8LDDfy04qS58W5be+DSstCYYWYb6ocTQzXW3TKZF+C8Z79T+YXOFromE2cH32vuZp+/+M6k4bXJjCWXeJX7A1FmVhcxcdcZepj4+hYPGh6sMVGo1uY2OrPjChVT61fyMj0LOfscjtq+r7tok0gK7qcGB613A6hsE2DXJNgUGhpSvUbTk6W6zmTEi0YLHCZG5yy6BwC/JKGeOCizC+LUy5OMCsqHzNsXrX3K7ZiNOLFjWQJ/HV/4FF4o4Rbzu6NWhRAEa3Aof+CoehT7i8/hXLdUFW6MMjGA1MChH34btfHn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg01QXqfqnPnaZOEOeJIAoJH9vG01qpWG7TIAP2SASw=;
 b=eGP+iwVbdc3HiJWWHxw9BuID2Q8h79jOyGaEAIAt99IUfkJTdL6puj/7KFMC0v38tdYCADCflrFXwzpP719X+2ABv44nPupZ6QV/dshYjFhkqnvNoDQRSYkOsKhTh/mJR+W/622pr774cQmoScebc1YaiqQPvcE0QO0vPCMYt1A9A4zvWrj8pMYn29ON8FH8Y5Xx+YI5qXcncOcuVQ1LKTFhCm78SS1ie/nOwpbioL391z4Njhc6/cDRQ6ehvYRZEXfMP3htN2IWam56OKsNHvbifcJqQijyjnSJVab9HbXZa59gyDY/XA4p4Y8F/xAZxQve8lnkZ4tQ62uNIoNBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1322.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Tue, 29 Oct
 2024 02:16:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Tue, 29 Oct 2024
 02:16:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, Nam Cao
 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 09/14] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Thread-Index: AQHbKNz964whLXf/jkiVt67VGhroArKbgvMAgAF4naA=
Date: Tue, 29 Oct 2024 02:16:53 +0000
Message-ID: <ZQ2PR01MB1307ECC05DF3D34F747475DBE64B2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1322:EE_
x-ms-office365-filtering-correlation-id: 8f7c0441-c588-43d8-ff64-08dcf7bfc17c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: Sg+DdfKuwr8mRvfDOoy8AswYc6SuD34lZNpZyy/mlVjur8GzQa6ROHQNhrHtuIJH2Rnn/QqtUf41Z01+FP09dT4408q/SluOBBAAPtW0ibtcZ7XHGx0FoQsUWnP9DR+P2SoLeDKgxZDsSmZO0KHfp5DDBD9LkPwF2tAgTuA9Nn1gKXutlLgSc6rKg5fp+RgzbzJv5lSdVkOMSCmdO1zV9JQkpO3wlli0Jp07I+f+wcyDCqzrs+Ku4kDRA3FfkvU5o593T3ybPZeVJJnZ9eYOhomCOSNXTw7gbWbR8JJqblYefTeOLq7PKvbt0kr1I1XXGTaYPbbTmovBAy4lQZDCgHxtd5z+NnElQYHodNJu7cnlvRCzEM5RJWHxj3j0rChYs+83QHO6+hOCffu8gVZzouULMVl+7Fv0oI8GgWqkGO9s08n0NdAcwEX4qo1YYC08PDAGM0Ak73ekbAQoASgdiHwdh5rwLQsqIdMcJ3mLM6KhUNJhM27litqCExB7XSd4nMgbPEpUPa1IZJsZLd+161Dp938WE8G2jNyVIjXa6DeNX43yZQtNYqfz1h5EdnRQ4D6A0BtriF6FCZz9CxDwBhXjx3t5qM32J0QMPHCA82pfo2u8Iejgm1PyUrOaDdVD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnB2UHdyY3BRWjZKajA4dnRobjJzUVdtR0pjYnp3ejhwWnhnOWRXV3hOeHp5?=
 =?utf-8?B?eSt2VmtYczd5ZGFVN3lIekVFelJQdCt5OEIrTmpQa2FWeWhzczBhaGdqWENr?=
 =?utf-8?B?ak0zZUxqN3RsWTZFYVltVTBlZnZlc0hIcXRPbkh5Tkh6em5hRndHbFRRTGhl?=
 =?utf-8?B?ZmxscklWcXpOYjNPSWpNVytqYlgwY1dRNllGcG5OemozR2MyUXJBRDNiTWpx?=
 =?utf-8?B?VVhsd1hnSGZkT2lCazlxakZuYWhucGJMMnhqOXlPcDF2TmhUaDJQSy9WZDRn?=
 =?utf-8?B?dEdCZlltaEYwQVdUUm5jdUpBUkZIVm00MGdETFdLVGdOT09ZMk1rZ1FBU1Yr?=
 =?utf-8?B?MTFRckJ1cVJtWkFoUHhjR2FsaDBQK3Vqa2VuMEt1amYrSkxadzM4MlJtN3hx?=
 =?utf-8?B?QjUwL3hrOU9LTVJ6R1ZPT3lPMS9iYlppUThzdUJOY3lGZjFoQWxPTVZTTEww?=
 =?utf-8?B?L0dvR2RCaEdua3plNmorTWY0L21pRmxFM3F3ZHk2TUZXK2RXT3dWSE1aRUsw?=
 =?utf-8?B?L2tKOUFNZ2lVeE5FSjVJWDJJUElZZDA0ZFk5b1BWODF5N1ZQc1RPcU9EeFFx?=
 =?utf-8?B?dmNYZjNTSG5GQUZmK0NOWTl6RC9vUlQ1NWpTUk9EdE9KQStRNVRSSi9FUWh1?=
 =?utf-8?B?cGhYeWFEdUtqZVJWdnNuYmVIUlcrTVJHSTR0a29CcDVLdTJ2aHBxUnZJeXpw?=
 =?utf-8?B?NkJ0Q2VJZFF2QlJLdnNnWHFRL29aY1NqekdrenQ1L1BBbW96RGQ5NEhXc0RN?=
 =?utf-8?B?YlBra3VQVFRtMkFWQ0E1akVVbWNRc2tKcWxMSE5wTnAzcVI2MDVadlIraU0r?=
 =?utf-8?B?RiszMmRWdGRxbWtIM010N0M1MktYYXZaRzZwb3R0VU16d1JHWit0bktUK29T?=
 =?utf-8?B?Z2Rya2h5SkNtaVV0UGpYdlNUVEdSN2lCdFBKK0h4d0l6NkIzMUYvZ1pIY2ZI?=
 =?utf-8?B?ZTRmUEUvNVVQQjZrVnhJaFBteGJDbmYrVytSNWRMa05ybWcrTFZXVERoQzFO?=
 =?utf-8?B?aGVmcS8vZ1ZIclJ1cEJJcUhCNnA5VXdGVlZSMlY1bzR0Z20zSG9MQXgxc1dy?=
 =?utf-8?B?UDZyN1FYRVFJMHJoVmhCK28xRzRCVVNDUTNRVTAyOW9uMlJhN25xSC9uWHN1?=
 =?utf-8?B?bjhTOFpibG1ha3Z1bjBKWWJsMG03cDY4eTBTQnQwOW5tZ0J4R2wwYmxFTnR5?=
 =?utf-8?B?MlhFMEhJaytjS0NVbUo2ZVBnZ2lsaXZpbnVtck5VbDlPNkxPODBjenI2dmJ5?=
 =?utf-8?B?VHJKeUNML2h5dmswUzVCaVNKT1VVcGFWemZLWnZrRmZydXF3VnpjL0pHWFJJ?=
 =?utf-8?B?ZnFvalZqTUEzdHhyT1lteUI3ZUp2amQ2dElGTll4WE9QYm1nNDJqc2U0OWZT?=
 =?utf-8?B?NDk5SndieHF0U1Z3K2d6TEVjNXZ4c3hyTTc1L0ZjeEJCeTNvM0Zpa0p5WEdz?=
 =?utf-8?B?ZFhlR1IyQjVac0VRajdqMnlPWk1iNHdKVmw0a0dlajgrRDhSL3lIM1lYbjNB?=
 =?utf-8?B?WCtaL0MyZ1ZtZGNzTlRjeUpWdGRsR1Y5VE1yN3JobnN6OE5qdXc0ZXBvNm0r?=
 =?utf-8?B?eElYNU1YWVBqL2NHRHJic1Z0WkU4K2JIZUJWcmE1azdUMWJza3NjRno2Z3lj?=
 =?utf-8?B?ajk1cmhIVmh4Y2c2SUhFblBRcnpkSGRtb3cxNjMzbm9wby9yeEkwQXVTTlZl?=
 =?utf-8?B?OU9KT3FPQXo2Q3BRaTA3c0hqOWFqSTFNeUlQZTFzTzZMQVZlT01PQ1VIcVE1?=
 =?utf-8?B?TGdkakpTRlhTRWJlalRJMXV3ZnZxemJWSk1RSGcvQjdwNkxPd1lQaXE5eURI?=
 =?utf-8?B?TC83cmh5K1Rzd2NlVGF1emhvamxneWpIdm0xNXg3M01GUUU1Vnk4UDVpVHdj?=
 =?utf-8?B?SlNzU2VpRm45b052REJOK3JJZzlubVFiYzVoS09pVEhMMlQwbVZkVUZZMTdD?=
 =?utf-8?B?eENrTExFOVJmRUVXTHNlTjNYVUlrbm8wVmh4MjBmR0s0QW5tcTVCYjZKQ1lJ?=
 =?utf-8?B?U05sNjE5SGtWOTdlZVBSTXdOcmloNE16cTRvRDRPa0hERUcrZEYzbmd0amZH?=
 =?utf-8?B?SGc5VUJOUGdiMnRnT0NKdndJREcreXd6M1RYUkpiVkl0ejBIQ2tJTjg2Q1VW?=
 =?utf-8?Q?u8Dqu9DoCVezROFVIdCmiZnH4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7c0441-c588-43d8-ff64-08dcf7bfc17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 02:16:53.6690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHwAmNtlC4M5Kb9FPKF1yflyTcDHdUnXXVo+F75daVNTNf2WBj4Hh1D0u05UyG7gy8X9YpGt9MBbhOxqfARZ8b5Vz4YU9sTP6aA9qwaI7aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1322
X-Mailman-Approved-At: Tue, 29 Oct 2024 04:41:37 +0100
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

PiBPbiAyOC4xMC4yNCAxMTozNSwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiBTdW4sIE9jdCAyNywg
MjAyNCBhdCA2OjU54oCvUE0gSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gVG8gc3VwcG9ydCB0aGUgb3RoZXIgSkg3MTEwIGJhc2VkIGJvYXJk
cywgYWRkIHUtYm9vdCBkZXZpY2UgdHJlZSBmb3INCj4gPiB0aGVtLg0KPiA+DQo+ID4gQ2M6IEhl
aW5yaWNoIFNjaHVjaGFyZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4NCj4gPiBDYzogSCBCZWxsIDxk
bW9vX2R2QHByb3Rvbm1haWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxoYWwu
ZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2R0cy9qaDcx
MTAtbWlsa3YtbWFycy11LWJvb3QuZHRzaSAgICAgICAgICB8IDExICsrKysrKysrKysrDQo+ID4g
IGFyY2gvcmlzY3YvZHRzL2poNzExMC1waW5lNjQtc3RhcjY0LXUtYm9vdC5kdHNpICAgICAgIHwg
IDYgKysrKysrDQo+ID4gIC4uLi9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjJhLXUt
Ym9vdC5kdHNpICAgIHwgIDYgKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0
aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9kdHMvamg3MTEwLW1p
bGt2LW1hcnMtdS1ib290LmR0c2kNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
ZHRzL2poNzExMC1waW5lNjQtc3RhcjY0LXUtYm9vdC5kdHNpDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IGFyY2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEu
MmEtdS1ib290LmR0c2kNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2R0cy9qaDcx
MTAtbWlsa3YtbWFycy11LWJvb3QuZHRzaQ0KPiA+IGIvYXJjaC9yaXNjdi9kdHMvamg3MTEwLW1p
bGt2LW1hcnMtdS1ib290LmR0c2kNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAuLjJhZDQwNjg1NDkNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJj
aC9yaXNjdi9kdHMvamg3MTEwLW1pbGt2LW1hcnMtdS1ib290LmR0c2kNCj4gPiBAQCAtMCwwICsx
LDExIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIE1JVA0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgU3RhckZpdmUgVGVjaG5vbG9neSBD
by4sIEx0ZC4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiamg3MTEwLWNvbW1vbi11
LWJvb3QuZHRzaSINCj4gPiArDQo+ID4gKyZwaHkwIHsNCj4gPiArICAgICAgIC9kZWxldGUtcHJv
cGVydHkvIG1vdG9yY29tbSx0eC1jbGstMTAtaW52ZXJ0ZWQ7DQo+ID4gKyAgICAgICByeC1pbnRl
cm5hbC1kZWxheS1wcyA9IDwxOTAwPjsgfTsNCj4gDQo+IEZvciBIZWlucmljaCwgd2hhdCBpcyB0
aGUgb3JpZ2luIG9mIHJ4LWludGVybmFsLWRlbGF5LXBzIDE5MDAgdmFsdWU/IFJlZmVyIHRvOg0K
PiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2xpc3QvP3Nl
cmllcz00Mjk5MDggIg0KPiByaXNjdjY0OiBkdHM6IHN0YXJmaXZlOiBNYXJzIGV0aGVybmV0MCBw
aHkgZGVsYXkgdmFsdWVzIHN5bmMgd2l0aCB1cHN0cmVhbQ0KPiBMaW51eCAiDQo+IA0KPiBGb3Ig
SGFsLCBJIHRoaW5rIHdlIHNob3VsZCBub3QgcmVwbGFjZSB0aGUgcngtaW50ZXJuYWwtZGVsYXkt
cHMgcHJvcGVydHkgaGVyZQ0KPiBhbmQgdGhlbiB0aGUgcGh5IGRlbGF5IHBhdGNoIGZvciBNYXJz
IChhcyBtZW50aW9uZWQpIGlzIG5vdCBuZWVkZWQuIENhcnJ5aW5nDQo+IHRoaXMgdmFsdWUgZnJv
bSBiZWZvcmUgT0ZfVVBTVFJFQU0gY3JlYXRlcyB3b3JrIGZvciBmdXR1cmUsIHVubGVzcyB5b3UN
Cj4gcHJlZmVyIHRvIGF2b2lkIGNoYW5nZSBpbiBmdW5jdGlvbmFsaXR5IGNvbXBhcmVkIHRvIGJl
Zm9yZSBPRl9VUFNUUkVBTS4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvZHRzL2po
NzExMC1waW5lNjQtc3RhcjY0LXUtYm9vdC5kdHNpDQo+ID4gYi9hcmNoL3Jpc2N2L2R0cy9qaDcx
MTAtcGluZTY0LXN0YXI2NC11LWJvb3QuZHRzaQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gaW5kZXggMDAwMDAwMDAwMC4uOWRmMWU1ZGI1NQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAtcGluZTY0LXN0YXI2NC11LWJvb3QuZHRzaQ0KPiA+
IEBAIC0wLDAgKzEsNiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MCBPUiBNSVQNCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI0IFN0YXJGaXZlIFRl
Y2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImpoNzEx
MC1jb21tb24tdS1ib290LmR0c2kiDQo+IA0KPiBUaGVyZSBpcyBhIHNhbWUgc3RvcnkgaGVyZSBm
b3IgUGluZTY0IFN0YXI2NCBhYm91dCBkZWxheSB2YWx1ZXMuIFJlZmVyIHRvOg0KPiANCj4gaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2xpc3QvP3Nlcmllcz00Mjk5
MDYNCj4gInJpc2N2NjQ6IGR0czogc3RhcmZpdmU6IFN0YXI2NCBldGhlcm5ldDAgcGh5IGRlbGF5
IHZhbHVlcyBzeW5jIHdpdGggdXBzdHJlYW0NCj4gTGludXgiDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyNDEwMjMtZ3V0cy12ZXJzdXMtMWEyYmNmZGZiZWMyQHNwdWQvDQo+ICJb
UEFUQ0hdIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBVcGRhdGUgZXRoZXJuZXQgcGh5MCBkZWxheSBw
YXJhbWV0ZXIgdmFsdWVzIGZvcg0KPiBTdGFyNjQiDQo+IA0KPiBJdCBpcyB5b3VyIGNob2ljZSBp
ZiB5b3Ugd2FudCB0byBkdXBsaWNhdGUgdGhlIHVwc3RyZWFtIHBhdGNoIGhlcmUgdG8gY2hhbmdl
DQo+IHRoZSBwcm9wZXJ0eSBub2RlcyAob3Igbm90KSB1bnRpbCB0aGUgbmV4dCBkdHMgc3luYyBm
cm9tIHVwc3RyZWFtLCBvciBjaGVycnktDQo+IHBpY2sgYSBkdHMgc3luYyAod2hlbiB0aGF0IGJl
Y29tZXMgcG9zc2libGUgYWZ0ZXIgdXBzdHJlYW0gbWFrZXMgdGhpcw0KPiBhdmFpbGFibGUpLiBU
aGUgcHJvYmxlbSBhZmZlY3RzIG9ubHkgZXRoZXJuZXQwIHdoaWNoIGlzIHdlbGwta25vd24gYXMg
ImRvZXMNCj4gbm90IHdvcmssIHRyeSBhIGRpZmZlcmVudCBuZXR3b3JrIHBvcnQiDQo+IGFuZCBz
byBpdCBpcyBub3QgYW55IHRyb3VibGUgdG8ganVzdCBpZ25vcmUgdGhlIHByb2JsZW0gaGVyZSwg
bWFraW5nIHRoaXMgZml4IG5vdw0KPiBjcmVhdGVzIG1vcmUgd29yayBmb3IgdXMgaW4gdGhlIGZ1
dHVyZS4gU3RhcjY0IGhhcyBhIHdvcmtpbmcgc2Vjb25kYXJ5DQo+IG5ldHdvcmsgcG9ydCBldGhl
cm5ldDEgYW5kIHNvIG5vIGNoYW5nZSBpcyByZXF1ZXN0ZWQgZnJvbSBtZS4NCj4gDQo+IFRoZSBw
aHkgZGVsYXkgdmFsdWUgcGF0Y2ggZm9yIFUtQm9vdCBhbmQgU3RhcjY0IGNhbiBiZSBkcm9wcGVk
IGluIGZhdm9yIG9mDQo+IHRoZSBPRl9VUFNUUkVBTSBzZXJpZXMgYW5kIGFueSBhY3Rpb24gb3Ig
bm9uLWFjdGlvbiB5b3UgZGVjaWRlIGZvciB0aGlzLg0KDQpUaGFua3MgZm9yIHlvdXIgdGltZWx5
IGZlZWRiYWNrLiBUaGVyZSBpcyBubyBuZWVkIHRvIHJlcGxhY2UgdGhlIHJ4LWludGVybmFsLWRl
bGF5LXBzDQpwcm9wZXJ0eSBmb3IgTWFycyBhY2NvcmRpbmcgdG8geW91ciBuZXcgdXBkYXRlLiBM
ZXQncyB1c2UgdGhlIHZhbHVlcyBmcm9tIHVwc3RyZWFtDQprZXJuZWwgZGlyZWN0bHkuIEkgd2ls
bCB1cGRhdGUgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
