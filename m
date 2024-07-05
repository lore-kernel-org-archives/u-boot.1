Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0993C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 05:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B57884FC;
	Fri,  5 Jul 2024 07:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A58F8860B; Fri,  5 Jul 2024 07:33:34 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20724.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55520884FC
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 07:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlVT86gnslL/kvSDv1uUKLyjrnSxoPdA2qJ1jkC3lHlPotdlisaQatO3l9iiBpPaiAcKs4W4ihtS4OsyheJB51jBPk2WW7TNi9LTWAAgkl6bL2Inc7+/811GvqKINQlZDxDsjiJWIYnmzKmBcvOGzZJ4BAwBItII0NOia7zfERi5aH0ztzQySRR0jpfP60+XAZhx4hEJXEWPcPVGamJVaQjXYftkzHSaDxDM12lSMQzxCgbCW9oTzz17jAi9VSGZnhfZd15EUgejSWx6oCpMtM+M98yf3eYtB/7Gnvdfaac9D8VPJAhXAouk8F2wwoJg+4p7PnrqyAhT+GyDBW3EzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh5sNN1JOSP+tgjNVcEzgotWx3wQWksNCcVCfkKDRR4=;
 b=gWggKBz43pFRUUdQ36vKoIIc/2taqWvGHPU22Yh2se+hfie7wg+i7nX0AryEystulMCfzBIePR99PLCrfe2KW0iHSK5WCklu+2o25YcvMnFhHnWz56/JyE0MG0vq7j35u3St7Xcr/ATbBaHzNCiCx4d46qe11Z8RQt4fcx3u1jt/1cvstxTdIC6Qp3s19bCJPUzSKGXrmHy4wREjc9UY1LLkbdkge3YdizBVjV2ARo4+HhL/2EUAEY7YAL1hrd9GBouRTaNnP3o2K3J4qdmwRMbF+VJpxEU5YJ6SOigg3mgUG5sdDKeJPCDe7FdBZDwRmA58oQAuhch6otAFT914KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0485.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.41; Fri, 5 Jul
 2024 05:33:25 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f124:3ea4:85a8:8a65]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::f124:3ea4:85a8:8a65%3])
 with mapi id 15.20.7719.029; Fri, 5 Jul 2024 05:33:25 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: E Shattow <lucent@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMC83XSBBZGQgU3RhcmZpdmUgSkg3MTEwIENh?=
 =?utf-8?Q?dence_USB_driver?=
Thread-Topic: [PATCH v2 0/7] Add Starfive JH7110 Cadence USB driver
Thread-Index: AQHazdYPLfQISprNP0SqG3gNc0bDZLHmj54AgADEcQCAAEh48A==
Date: Fri, 5 Jul 2024 05:33:25 +0000
Message-ID: <BJXPR01MB0855D0BE2C3ED9545D23F79CE6DF2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
 <9067a38f-1ebe-40bc-821c-e1cbeb49a615@gmx.de>
 <CANV2PTO68ZfZdHR8_n3ou+suVEZ3ZbW8q_yTufeTOFEY-HFw_g@mail.gmail.com>
In-Reply-To: <CANV2PTO68ZfZdHR8_n3ou+suVEZ3ZbW8q_yTufeTOFEY-HFw_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0485:EE_
x-ms-office365-filtering-correlation-id: c8c3b5a4-cfb5-40c8-74d5-08dc9cb3fe0b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|41320700013|38070700018; 
x-microsoft-antispam-message-info: h5olE1aXPchwSEZtdlF0i8PVgOqUHZZEuI1qPPtYk19rc/YQKfv/Qo1wWHGPT+jSxVSS8WpbvL3m6DkwSMzWkZndN7pAztYQBvVctuy+RPskKzTPFhJWKq530U6eAgE0ZoYOrrM/+L8OGUDR+1ParlxPU3QrqKO72/DS+p9t/9c7Dvaxxp0Ds/7UC1QzsMT1oIUmfA803S/zAfYbFBkXuiG4PYUz/cIRJiXSh6LAXnFShmFLHw8cdOd6a7+t7U53Aongae24UOY370I09eP529GzTaTvmkOnn+J2Hpzj/bEdIeeg5zDOSXUbydUJLHaRzz4z6F6UlrCLIhIBLQwxbhUdcmKQRJAJ4sHHA/SEo5cv+nED8K/uQv52qvsgESyKHxODtRwC95g6RPenBEwRwe2ZsE6fx1gDsjmeoCqeeFSr7nZTJ8iZ9aw0MKdA/8bnGtZ3wVzeZZ/Yc0TDKJYzzw7drUfg3EKR6Hogn9XyUDS0K0cz6lPPpUq4a6BJy333MzSqpTHXJ69a78Zdt6z97O+2G6x0XgbkPDh4TJoFI0wpX1D00fFFdSnfg7L0gHVR6DLxjVnVyD8s3dG6vxaxbF6GpZL9nwObC0bXF5DpTsSSv2SnPz5xl3x686dPq6rh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(41320700013)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJCYytVVTJwN1hoR3E2ZnBGVWVFTk1IcVBuMVNacDRjMXFwcktwd2RmSHdV?=
 =?utf-8?B?NFhHOFMwMWRjaWV2NkZ2NUd3V2VhZm5YRk83Zk5TeGFpWW95aUZybzVyTmxW?=
 =?utf-8?B?OFVTN1JJV0ZyUGdxTzQyd20reXc4SzZJMlJOelduSVdjOUV6anhZU2Zsc214?=
 =?utf-8?B?SlNCR2IwbEdYeFd1NUs1Rm9JZi9uRDRDcjEvVytrYVZ5ZkdtdnpjOFU4TTlZ?=
 =?utf-8?B?VXZ5QzV0aDI3OXd5OUltWjBWcDNYYiswTUZ0eUZaUmd5dDdkVDc4SEJmODRk?=
 =?utf-8?B?RUxScll1T1RRNkJEcGx2WmlGNW4zeE1BTy9iSEo2MVVjNmpTbUh1WjZVWkFi?=
 =?utf-8?B?cCtxMHplcU5wVjdZanJ2NWpTaVBVTmNweHJFQ0pybTBwTjVwYnNzNDF1R2Ey?=
 =?utf-8?B?Z2FqeWJwZk92WmZlaDNQZjdkeUtOZlVua1Yxd0NvU2JINkN1cnd3NmR2anZ5?=
 =?utf-8?B?UmhhQW1GcGZmeTdWS1dmb3UycEZLYXhqeE5MOU42V0VidU83OWx6bE1hTEZh?=
 =?utf-8?B?NGdJdHhmQkNmYm1XZmZtUUlnTUZZcVp0eGhGalJOaTBVdVd2Zm9tdmxPWVJG?=
 =?utf-8?B?OW5vL3dpTXA4UWphN3NCUzRQZTk1V3JCbE9nTm1BY2liaWN2ZlZHcy9FdHRD?=
 =?utf-8?B?OFV1S0xIRG5LcFZKUWMreHZKV2pLd2ROK3VmV3ZpUWpKSEhPSDVCWlRNbmh0?=
 =?utf-8?B?MW5GRHpVS0RhRERsT09PZE9PZDgzeE1SN3BrL0xOZFNKMEN0VEkrTnEvWkRC?=
 =?utf-8?B?ckk0Z3dXcnQxSzU5RGZ3NkxjTVhMRm0vUVFEd3NBbzU0TmQ4WSs0K1lGVkVx?=
 =?utf-8?B?VS9qMkVoNlF5ZlVLQkFPTXpNNnBmb012eUk5OXJpZVpubWo5ZlYyUzU3RmI1?=
 =?utf-8?B?MnJzTGZKdHZHVlk4OWNaQ0hRSnRRNHpwNDRWWDlYSXlqb3pxQ09FaWZGcUdp?=
 =?utf-8?B?STdYUy9uYW5jamZ1bHU0a0ltQ3ZjaWg0ZnhERDIyR0pKbGRKTDl1ajBOelJ6?=
 =?utf-8?B?ZkhLMDk0UkJqaG82ekxJMkpjbDEvVEgzSTk1T0xGWkZNVXA5MWV6a0orU01R?=
 =?utf-8?B?cUJQa3FVblNHRUt6NFpLVUJseUh5RGRqSjZFV3NVaVhNK0xqcG0wVnJpb3Y2?=
 =?utf-8?B?RzJ5Q2FsRlFkaktuS1g2YUxodEVBNU0wLzR4MmxxYnlYMUFuRHRyeUY3RHFm?=
 =?utf-8?B?Mm1Mdy9kdEphcHhBRjVJMWJIbjF3L0EvcGFuWlovcGVSSktmSlpDZFdGcVAw?=
 =?utf-8?B?eGZzcVdnazFsVTNQMm9CVWU3ZWt5dCtiblB2L3IvcEFVd09XYVJrZWV4Vmho?=
 =?utf-8?B?NUtCOVdGaXVuMVFrUmpPc0pEZllsMTJJZnlqR1l5NUJaSTZaSFlqK21LN3dV?=
 =?utf-8?B?Z1kybEdST2lJQXFJOVZFT2Rub1VhQUNVL0RZNzhab1NqeW1zdWM1TVpqUnNB?=
 =?utf-8?B?d2drM3hvTXhUQmVuRit0dHRIOXdSczJ4WVM5M2l1L1dMVGtLSjhJOHJRV1Zh?=
 =?utf-8?B?azQ3a0F3N2MyaUY3a3FBR3h2emt2L0dFWGt0SDRHNndPV080VHBTK1VDckl5?=
 =?utf-8?B?MzJMeG94WWdzeVhDQWRMMkVDS09lTmhlTDUwTEVid2NaaWVQaGdjeVJOWEFj?=
 =?utf-8?B?R0FTZGRraHpqVWhsTE5XSi9VajZCQlY4MzRyWnBEODVwcDFFUVNUY1JGbEJO?=
 =?utf-8?B?S0xlYUp1UUVRTktGOXpQODA1ZFRJaDlJKzZJRzN4N0NLQXd6OEdOaFA1MkFQ?=
 =?utf-8?B?SXVCcXlpNkdIUjZJSjgrS2tyUGEvZE8vTjZhK1ptRURhWUROQ044aWxWVXk0?=
 =?utf-8?B?RWN5L0pvVHA5cVZOVk9wZmduZW1lZ1VaUmtJbE9WNFdMRWthOS9FckJNTVBz?=
 =?utf-8?B?OVc3YnI5M3lXR2JSMVZGVmN4dHUrRVFyZFQ1a01tOXB5RW56Q2h0SXhtWTFL?=
 =?utf-8?B?MjFCZnRiS3dIUjU1VUpyTjU0K1dxR0JhaFNkdGticXM2Sitteld5UkthN3Qx?=
 =?utf-8?B?T0QyQ3lBcGdsNm91Y1VFUjQ1VnBmMTdhQzdqZjVOdzNycUZwc1pFcGMzU3VT?=
 =?utf-8?B?NU01WXo1S2ZqNXBNcVRzNUU0MFBNZ2tTK0xhWXRwVlFjWjZpSWFTYnJFenhs?=
 =?utf-8?Q?SS949EeIKQQkqQP4NQbWXaq4u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c3b5a4-cfb5-40c8-74d5-08dc9cb3fe0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:33:25.4683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Lz+SYgSLA7moVkjpItT812h0hVEounoRaAXWTl1bhn1A2OuGjysDr6sQZ7VgXxGkm8HikLz9dID4qtomKWtk+BOOCnaNrKWQi2YfGDUGJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0485
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

DQoNCj4gDQo+IE9uIFRodSwgSnVsIDQsIDIwMjQgYXQgNjoyNeKAr0FNIEhlaW5yaWNoIFNjaHVj
aGFyZHQgPHh5cHJvbi5nbHBrQGdteC5kZT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiA3LzQvMjQg
MDc6NTAsIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gPiBBZGQgU3RhcmZpdmUgSkg3MTEwIENhZGVu
Y2UgVVNCIGRyaXZlciBhbmQgcmVsYXRlZCBQSFkgZHJpdmVyLg0KPiA+ID4gU28gdGhlIGNvZGVz
IGNhbiBiZSB1c2VkIGluIHZpc2lvbmZpdmUyIGFuZCBzdGFyNjQgNzExMCBib2FyZC4NCj4gPiA+
DQo+ID4gPiBUaGUgZHJpdmVyIGlzIGFsbW9zdCB0aGUgc2FtZSB3aXRoIGtlcm5lbCBkcml2ZXIu
DQo+ID4gPg0KPiA+ID4gVGVzdCB3aXRoIFN0YXI2NCBKSDcxMTAgYm9hcmQgVVNCIDMuMCArIFVT
QiAyLjAgaG9zdC4NCj4gPiA+IFRoZSBjb2RlIGNhbiB3b3JrLg0KPiA+ID4NCj4gPiA+IC0gU3Rh
cjY0IHVzaW5nIFVTQiAzLjAgYW5kIFVTQiAyLjAgaG9zdCBtdXN0IGFkZCBiZWxvdyBib2FyZCBk
dHMgc2V0dGluZy4NCj4gPg0KPiA+IERvZXMgdGhpcyBtZWFuIGEgZnV0dXJlIHBhdGNoIGZvciBz
cGxfZmR0X2ZpeHVwX3N0YXI2NCgpIGlzIG5lZWRlZD8NCj4gDQo+IEFzIHNhaWQgYnkgSGFsIHRo
ZXkgd2lsbCBiZSBpbnRyb2R1Y2luZyBhIHBhdGNoc2V0IHRvIE9GX1VQU1RSRUFNIHRoZQ0KPiBK
SDcxMTAgYm9hcmQgc3VwcG9ydCBzbyB3ZSBzaG91bGQgcHVyc3VlIHRoYXQgZmlyc3QgdG8gZ2V0
IGR0cyB1cHN0cmVhbSAoTGludXg/KQ0KPiBhbGlnbmVkIHdpdGggVS1Cb290Lg0KPiANCj4gPg0K
PiA+IERpZCB5b3UgYWxzbyBoYXZlIGEgbG9vayBhdCB0aGUgVVNCIG9uIHRoZSBNaWxrIFYgTWFy
cyBDTT8NCj4gDQo+IFdpdGggTWluZGEncyBhZHZpY2UgZm9yIFN0YXI2NCBhcHBsaWVkIHRvIGpo
NzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPiBkaXJlY3RseSBhcyBhIHRlc3Qgb24g
TWlsay1WIE1hcnMgQ00NCj4gTGl0ZToNCj4gDQo+IFN0YXJGaXZlICMgdXNiIGluZm8NCj4gMTog
SHViLCAgVVNCIFJldmlzaW9uIDMuMA0KPiAgLSBVLUJvb3QgWEhDSSBIb3N0IENvbnRyb2xsZXIN
Cj4gIC0gQ2xhc3M6IEh1Yg0KPiAgLSBQYWNrZXRTaXplOiA1MTIgIENvbmZpZ3VyYXRpb25zOiAx
DQo+ICAtIFZlbmRvcjogMHgwMDAwICBQcm9kdWN0IDB4MDAwMCBWZXJzaW9uIDEuMA0KPiAgICBD
b25maWd1cmF0aW9uOiAxDQo+ICAgIC0gSW50ZXJmYWNlczogMSBTZWxmIFBvd2VyZWQgMG1BDQo+
ICAgICAgSW50ZXJmYWNlOiAwDQo+ICAgICAgLSBBbHRlcm5hdGUgU2V0dGluZyAwLCBFbmRwb2lu
dHM6IDENCj4gICAgICAtIENsYXNzIEh1Yg0KPiAgICAgIC0gRW5kcG9pbnQgMSBJbiBJbnRlcnJ1
cHQgTWF4UGFja2V0IDggSW50ZXJ2YWwgMjU1bXMNCj4gDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMN
Cj4gPg0KPiA+IEhlaW5yaWNoDQo+ID4NCj4gPiA+DQo+ID4gPiAxLiB1c2IgcGluIHNldHRpbmcN
Cj4gPiA+ICAgICAgIHVzYl9waW5zOiB1c2IwLTAgew0KPiA+ID4gICAgICAgICAgICAgICBkcml2
ZXItdmJ1cy1waW4gew0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxHUElP
TVVYKDI1LA0KPiBHUE9VVF9TWVNfVVNCX0RSSVZFX1ZCVVMsDQo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgR1BPRU5fRU5BQkxFLA0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdQSV9OT05FKT47DQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgYmlhcy1kaXNhYmxlOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
IGlucHV0LWRpc2FibGU7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgaW5wdXQtc2NobWl0
dC1kaXNhYmxlOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHNsZXctcmF0ZSA9IDwwPjsN
Cj4gPiA+ICAgICAgICAgICAgICAgfTsNCj4gPiA+ICAgICAgIH07DQo+ID4gPg0KPiA+ID4gMi4g
cmVsYXRlZCBkdHMgbm9kZSBzZXR0aW5nLg0KPiA+ID4gJnBjaWUwIHsNCj4gPiA+ICAgICAgIHN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gPiB9Ow0KPiA+ID4NCj4gPiA+ICZwY2llcGh5MCB7DQo+
ID4gPiAgICAgICBzdGFyZml2ZSxzeXMtc3lzY29uID0gPCZzeXNfc3lzY29uIDB4MTg+Ow0KPiA+
ID4gICAgICAgc3RhcmZpdmUsc3RnLXN5c2NvbiA9IDwmc3RnX3N5c2NvbiAweDE0OCAweDFmND47
DQo+ID4gPiAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiB9Ow0KPiANCj4gUXVlc3Rpb24g
SSBoYXZlIGlzOiAgIFdoZXJlIGlzIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGVzZSAibWFnaWNh
bCINCj4gbnVtYmVycyAweDE4IDAweDE0OCAweDFmNCA/ICBJcyB0aGlzIGEgZGVmaW5lZCBjb25z
dGFudCwgb3IgZWxzZSB3aGVyZSBpcyB0aGlzIGluDQo+IHRoZSBUZWNobmljYWwgUmVmZXJlbmNl
IE1hbnVhbD8NCj4gDQpUaGlzIGlzIFVTQiAzLjAgY29uZmlndXJhdGlvbi4gMHgxOCAweDE0OCBh
bmQgMHgxZjQgaXMgcmVnaXN0ZXIgb2Zmc2V0Lg0KTWlsa1YgQ00gaXMgVVNCIDIuMCBob3N0LiAg
SXQgaXMgbm90IG5lZWRlZC4NCkFuZCBJIGRvbid0IGtub3cgd2hldGhlciBWYnVzIHBpbiBpcyBH
UElPMjUgaW4gQ00gYm9hcmQuIElmIG5vdCwgSSB0aGluaw0KSnVzdCBzZXQgZHIgbW9kZSB0byBo
b3N0IGlzIE9LIGluIE1pbGstViBDTSBib2FyZC4NCj4gPiA+DQo+ID4gPiAmdXNiMCB7DQo+ID4g
PiAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gICAgICAgcGluY3RybC0w
ID0gPCZ1c2JfcGlucz47DQo+ID4gPiAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiB9Ow0K
PiA+ID4NCj4gPiA+ICZ1c2JfY2RuczMgew0KPiA+ID4gICAgICAgcGh5cyA9IDwmdXNicGh5MD4s
IDwmcGNpZXBoeTA+Ow0KPiA+ID4gICAgICAgcGh5LW5hbWVzID0gImNkbnMzLHVzYjItcGh5Iiwg
ImNkbnMzLHVzYjMtcGh5IjsNCj4gPiA+ICAgICAgIGRyX21vZGUgPSAiaG9zdCI7DQo+ID4gPiAg
ICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiB9Ow0KPiA+ID4NCj4gPiA+IC0gcHJldmlvdXMg
dmVyc2lvbg0KPiA+ID4gICAgdjE6DQo+ID4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3Byb2plY3QvdWJvb3QvY292ZXIvMjAyNDA1MDQxNTAzNTguMTk2MA0KPiA+ID4gMC0xLW1pbmRh
LmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbS8NCj4gPiA+DQo+ID4gPiAtIHBhdGNoIGRlc2NyaXB0aW9u
Lg0KPiA+ID4NCj4gPiA+IHBhdGNoMTogQWRkIHNldCBwaHkgbW9kZSBmdW5jdGlvbiBpbiBjZG5z
MyBjb3JlIGRyaXZlcg0KPiA+ID4gICAgICAgICAgd2hpY2ggaXMgdXNlZCBieSBTdGFyZml2ZSBK
SDcxMTAuDQo+ID4gPiBwYXRjaDItMzogVVNCIGFuZCBQQ0llIDIuMCAodXNiIDMuMCkgUEhZIGRy
aXZpZXINCj4gPiA+IHBhdGNoNDogQ2FkZW5jZSBVU0Igd3JhcHBlciBkcml2ZXIuDQo+ID4gPiBw
YXRjaDU6IEFkZCBKSDcxMTAgVVNCIGRlZmF1bHQgb3ZlcmN1cnJlbnQgcGluLg0KPiA+ID4gcGF0
Y2g2LTggZHRzLCBjb25maWcgYW5kIG1haW50YWluZXJzIHVwZGF0ZS4NCj4gPiA+DQo+ID4gPiAt
IGNoYW5nZToNCj4gPiA+ICAgICAgIHYyOg0KPiA+ID4gICAgICAgLSBwYXRjaCAxIE1vdmUgdGhl
IGFkZGVkIGNvZGUgdG8gY2RuczNfY29yZV9pbml0X3JvbGUoKS4gTXVzdA0KPiA+ID4gICAgICAg
ICBzZXQgUEhZIG1vZGUgYmVmb3JlIGNhbGxpbmcgY2RuczMgcm9sZSBzdGFydCBmdW5jdGlvbi4N
Cj4gPiA+ICAgICAgIC0gcGF0Y2ggMS00IGNvcnJlY3QgdGhlIGNvZGUgZm9ybWF0Lihmb2xsb3cg
TWFyZWsncyBjb21tZW50cy4pDQo+ID4gPiAgICAgICAtIHBhdGNoIDIgQWRkIHNldCAxMjVNIGNs
b2NrIGluIFBIWSBpbml0IGZ1bmN0aW9uLg0KPiA+ID4gICAgICAgLSBBZGQgbmV3IHBhdGNoNS4N
Cj4gPiA+DQo+ID4gPiBNaW5kYSBDaGVuICg4KToNCj4gPiA+ICAgIHVzYjogY2RuczM6IFNldCBV
U0IgUEhZIG1vZGUgaW4gY2RuczNfY29yZV9pbml0X3JvbGUoKQ0KPiA+ID4gICAgcGh5OiBzdGFy
Zml2ZTogQWRkIFN0YXJmaXZlIEpINzExMCBVU0IgMi4wIFBIWSBkcml2ZXINCj4gPiA+ICAgIHBo
eTogc3RhcmZpdmU6IEFkZCBTdGFyZml2ZSBKSDcxMTAgUENJZSAyLjAgUEhZIGRyaXZlcg0KPiA+
ID4gICAgdXNiOiBjZG5zOiBzdGFyZml2ZTogQWRkIGNkbnMgVVNCIGRyaXZlcg0KPiA+ID4gICAg
cGluY3RybDogc3RhcmZpdmU6IFNldHVwIFVTQiBkZWZhdWx0IGRpc2FibGUgb3ZlcmN1cnJlbnQg
cGluDQo+ID4gPiAgICBjb25maWdzOiBzdGFyZml2ZTogQWRkIHZpc2lvbmZpdmUyIGNhZGVuY2Ug
VVNCIGNvbmZpZ3VyYXRpb24NCj4gPiA+ICAgIGR0czogc3RhcmZpdmU6IEFkZCBKSDcxMTAgQ2Fk
ZW5jZSBVU0IgZHRzIG5vZGUNCj4gPiA+ICAgIE1BSU5UQUlORVJTOiBVcGRhdGUgU3RhcmZpdmUg
dmlzaW9uZml2ZTIgbWFpbnRhaW4gZmlsZXMuDQo+ID4gPg0KPiA+ID4gICAuLi4vZHRzL2poNzEx
MC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaSAgICAgfCAgIDUgKw0KPiA+ID4gICBhcmNoL3Jp
c2N2L2R0cy9qaDcxMTAuZHRzaSAgICAgICAgICAgICAgICAgICAgfCAgNTIgKysrKysNCj4gPiA+
ICAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMgICAgICAgIHwgICAyICsN
Cj4gPiA+ICAgY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZjb25maWcgICAgICAgIHwg
ICA5ICsNCj4gPiA+ICAgZHJpdmVycy9waHkvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxICsNCj4gPiA+ICAgZHJpdmVycy9waHkvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxICsNCj4gPiA+ICAgZHJpdmVycy9waHkvc3RhcmZpdmUvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgIHwgIDIxICsrDQo+ID4gPiAgIGRyaXZlcnMvcGh5L3N0YXJmaXZlL01h
a2VmaWxlICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gPiAgIGRyaXZlcnMvcGh5L3N0YXJm
aXZlL3BoeS1qaDcxMTAtcGNpZS5jICAgICAgICB8IDIwMg0KPiArKysrKysrKysrKysrKysrKysN
Cj4gPiA+ICAgZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11c2IyLmMgICAgICAgIHwg
MTM1ICsrKysrKysrKysrKw0KPiA+ID4gICBkcml2ZXJzL3BpbmN0cmwvc3RhcmZpdmUvcGluY3Ry
bC1qaDcxMTAtc3lzLmMgfCAgMTEgKy0NCj4gPiA+ICAgZHJpdmVycy91c2IvY2RuczMvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gPiA+ICAgZHJpdmVycy91c2IvY2RuczMv
TWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ICAgZHJpdmVycy91c2Iv
Y2RuczMvY2RuczMtc3RhcmZpdmUuYyAgICAgICAgICAgIHwgMTgzDQo+ICsrKysrKysrKysrKysr
KysNCj4gPiA+ICAgZHJpdmVycy91c2IvY2RuczMvY29yZS5jICAgICAgICAgICAgICAgICAgICAg
IHwgIDI1ICsrKw0KPiA+ID4gICAxNSBmaWxlcyBjaGFuZ2VkLCA2NjEgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0
YXJmaXZlL0tjb25maWcNCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0
YXJmaXZlL01ha2VmaWxlDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9z
dGFyZml2ZS9waHktamg3MTEwLXBjaWUuYw0KPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11c2IyLmMNCj4gPiA+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLXN0YXJmaXZlLmMNCj4gPiA+DQo+ID4gPg0K
PiA+ID4gYmFzZS1jb21taXQ6IDg5MzdiYjI2NWE3ZjIyNTFjMWJkOTk5Nzg0YTRlZjEwZTljNjA4
MGQNCj4gPg0KPiANCj4gVGhhbmtzIHZlcnkgbXVjaCBNaW5kYSwgSSBhbSBoYXBweSB0byBzZWUg
c29tZSBVU0IgSG9zdCBmdW5jdGlvbiBvbg0KPiBNaWxrLVYgTWFycyBDTSBMaXRlIGhlcmUuICAg
LUUgU2hhdHRvdw0K
