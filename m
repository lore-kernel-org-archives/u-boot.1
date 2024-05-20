Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA8AC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 06:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3753488572;
	Mon, 20 May 2024 08:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7DC88658; Mon, 20 May 2024 08:21:04 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C37B88572
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxJ2ZY9eAR0O3awwzYgk1D+D57goPVhllCvvMAfmy3g2enOepKlXzyevvKOh9Tpmw/sCMZY3EozqWItAncOCWwGL93ZXkDsnNJpQ+xv8vGUoI2hnIRFweIN1jbBA6oNjAaKhioE7oEHUOpI2IzxuJ+f9MwViGhgQwjSK01vv09kHAavFqqmpZwDHoxhPIs8voBbIBnyLr1ux+6D2HyEAgqhwJWl982moMxnE2n6vgaqFszqWJoI7B6DIBkFRRkje0XuOPkmDBk+Jq0s5RCD1SihKkVglGMHSYesyr2gfzE9EQI5Lir+oW84SZP0upI3305mRhZUZTXC1sDFcvDnB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oACPgckzcKy8SfDweiXiNidZ3S7GdHB2gwL+sa3sv5Y=;
 b=BaVJ57y2guebU9QmaROhXSxIOo6kHSW/BI6MhxEQ8ke7fN2O6TrtcimO2cDQNk34mAtPGa6+pMkyWZtf2DDunUQVp3KNmfHLllJs9LI6C7g65tk78kw12GJ13DoHQa397Kt/W9ck7s83BQc5/qPtVmdSkLR/TBgU4JUqeAGEj2eOpWjMvCLD/ul9zNApkdqdKLQiIyw3bccOl0eoLG2hTWyFUNsXH85KS1IjKESXaZ27KCMPKil0u7DJLTE9EoEYh9XaF44/xI0EVIC/Iugq+YFDFEywsYuZbKkrFWGXS/2Gr+COwBcuileEMSOsjTln0ReiZpPo9tvoKKLPPCkaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0584.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 20 May
 2024 06:20:55 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Mon, 20 May 2024 06:20:55 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB driver
Thread-Topic: [PATCH v1 0/7] Add Starfive JH7110 Cadence USB driver
Thread-Index: AQHanjRPIEXPrMMIQ0uF+i29iZxT/rGfqnSAgAAU4BA=
Date: Mon, 20 May 2024 06:20:55 +0000
Message-ID: <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
In-Reply-To: <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0584:EE_
x-ms-office365-filtering-correlation-id: 718e85a9-9808-4c24-0cf5-08dc789501e5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3BivCMJ4UiMC2vDs6CzWMJoCdk7T/bXCJ6w06z4o2rauClmSDgfJEzcdQg/EF+NVutYYNxXpe2w8KZ/DLcnVPwXld7xM1MYWNO+RT9JCGcaGqVRt513nQSFlUo6JC2fjrzLj20F90WdD+QoW2QZKYHGZRrPFa38oWcHmJUvPyoBi9RBUK94+GRn4el9nsoxA1Vw50KFKwA0IrJSEL9s5O1cTL6bbZySy/t99VT4gydn5TSlus68Rrfmid5SK5KxetKV5g5UFVNpV8pvKdMyIonTOsS7Cifzjwx+szuequLxveuYZKufpEhtW8TOPsD63S50+xQa3b2wl1d3bHywlNeLfTdatyk83EJtCjjdcvpdjeI3ci5ILx8xOlApVAwQUxgZnuTZ/BdNrmhda0lIUmUX8FkCCI14AieIBiYr2NASgtiQGAKlTNMzFD4BZFfy/5veG4ZgCHN9SEBgPILVzMRtwEVRDFQGtw58vbLoORKFwLUXFlKrNKoHxdyaYE6UVgQ7Vv9cQN+VVaWp/h1YjA4vYyTMK+196pfYD0Yu52P6to3B/d05+RCFx5DnquB0dAIgey6ZLvBsORjZy2Qo5cpFvBq0jXQVmgN5+dGDdiWpJ0GGHtJM4LdE7EAmfLCx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVJFVGdmenpZT0t4aU5Ldm9sZG9YNklBR3NLbVFsbEFtMDdBdnJoWFVJWFdU?=
 =?utf-8?B?Ulk3K2dHWlVLMmJZbTNHRzRaTFNMbGQwQTF5dDdndGg1bmNQd1oxL2FHNUFH?=
 =?utf-8?B?Vk1CdzdSNDFVVTF2eWx4WC9BTWxFdmZ2SEl2Z3ZtaFV4Rzlxb3ArRXhMY0Fk?=
 =?utf-8?B?MCsvaXlyeERNaldLcjM4YXJ3L3k2N1FpUWdmSXhmYkwzN01pTm04Q0VTc0lV?=
 =?utf-8?B?TmNBQ25sL2tNZE5uUlFwdjlydnk2dTVGVXFtb0J0OEpxZW1KLzlBbithV3M4?=
 =?utf-8?B?NjcvdGlQTWN0Yml4MTVHM2l6MVNpdmRVa0ZMUGtxZWllakp2M29IWllIbHNw?=
 =?utf-8?B?RVNmWkJJMkZtU3o5ZVhVTlNiRVdkSWR1UU9jWENZc1ovL0xNb1hjMkhjTEs0?=
 =?utf-8?B?QWhYS2g4bHdlclIzWEFqbWFYNTNzS0ljQzFOMU4xMDhkdVpRcmUyVHo2TzBP?=
 =?utf-8?B?UDdVbmptQzl1dG0rUytHdXlNU1EvV1UrdHlROTFQQnRzM1dwZ1ArNFZ0Nmg4?=
 =?utf-8?B?WFkwU0JwdmNtVmRRdHF3R0s0YVNYUjRzK1dJUlAxN0x1RVFSRXl2V3MzV1E3?=
 =?utf-8?B?U1Q4WlArWGZQcjJENlZadDgzTkxFUnBQTTdDK1VqNEg5VUl3eWt5blg3dGlM?=
 =?utf-8?B?Sk05dHpWanA5TGdhTWZZUkRlaWo2ZUVXbHM2bEhuZzVndEo1R3dFcGwvL0sv?=
 =?utf-8?B?by9hUlFZNHRJM1RDNGtWbEExKzlQQzBVdFhaQ2Y0TjRpdEhXS3JBRWZhR0d3?=
 =?utf-8?B?eXF2S0VOclpESGlQZFBQU3dCZ1M3UmxtVHV2cFR2VWhNcG9IZjF2YWVPdU9m?=
 =?utf-8?B?U3pOeWJrYUJwRFZpVzR6c2JzaVZ1TnVYYjAxVEVXRWhTSlF4QndjaVNWbkFn?=
 =?utf-8?B?MU85M05tZHVhSmRWWHVUeWMvTlVwdUtpQ0FjdDhLOG5LS21PcXY4Qk44bE0w?=
 =?utf-8?B?THRGN0hTNzF3VzVpZEpnZVlmZktJcERLcnpOZlFTQWI0ZkNKdy8vV3lJWXow?=
 =?utf-8?B?b1NiRzNrVU45MnAvWjdaUUgzR1JlUW1NQWJNT0Zoa0RKcnZpWDJhZDdqL2Rw?=
 =?utf-8?B?VzY4WE9iREJyWnFEdVZ1c0VUWTYyTDFuQXdlQTkzdElVbHhTWmQ4aCtVQ3JW?=
 =?utf-8?B?N05jTEJ3T1N6cGpuZGYwVFppWXNGaTFDUFlYL0lzbzdsa2d1ZVF6RVZhK2Ry?=
 =?utf-8?B?ZlZlYzU2bHNEb2k3dlhOZjZuZkxVRUkxUE5LSVFmeWdVUU5ETFNwSU1uSXdj?=
 =?utf-8?B?RkNpNnc3d3ViektYcWordEdZNEI3bkw4SDNCVi9MYnlBWUI0SXRyQmxOT2U5?=
 =?utf-8?B?Qkp2SzZ5RlV1U2FiY3VvQzRlR1Y4UmltNitvYStKTjRTMThKS0k4blFReDFZ?=
 =?utf-8?B?TTJBYk1uTFdUSUhiZWl1MHloSFh4RXZ6VHlEWnlnUm1XWVZZRzg5ZkgxY09X?=
 =?utf-8?B?cXVMTXBVYitqd2xBdzNOelUvVnozbnc4TEZTWldHN0tJTXE2Y09haDhaM2ha?=
 =?utf-8?B?S2NLS2F5TUl2eUZTdVV2RmtIbEovMjFaMVlwdlBscFRqamx2YTgrTk9QUGVW?=
 =?utf-8?B?RjB0T2pIVVAyRjZPWDQ4d2ZhYVFJdTc3OFAyajZaMkY4SW5SenEyQXRnZWI5?=
 =?utf-8?B?cXpqMHlsV2dyS1o0dlM2TTBkNmhLUUVWZmsxVW1OMkdDSEwrRTVKcmFIa1Ey?=
 =?utf-8?B?cEl0Z2pOZHRmRWhmV0YzdDAwcEluNGtHb2JpRXIwWmg3YlR2WHBqRTVFM0lo?=
 =?utf-8?B?UFl4UHEvSDZLSE9vZnE0c0RCSmJYTkZTd3dhU1RySEpDWmwvUVhvTGI2SU9J?=
 =?utf-8?B?OTR4YzN1K04yVVF2UUY0V2pvVUJldFJjOSt0eW9qUWxUcEpxcEt5a1V5MkxJ?=
 =?utf-8?B?NWxNdnNGSUY0MHVFSzlaL2d4b1V6bVpiNmoxUmtGNkdqbG40SVZRZU9VblFi?=
 =?utf-8?B?UDZyZmNiT0d0NjBDU2NhSGZjQXV0Z3QrT3VxUWlLeTVJTmsvN2lPT2NOUHY0?=
 =?utf-8?B?Q040STFuUExkYVBYUlRDSlBuTTJ5RExlekN0bW5WcWNLZmNrVU1BUnBVSHdp?=
 =?utf-8?B?cVhtTWh2VHdZVDBFcngvcEM3eStlQmlrRjEyZmxiQjd5RU5yVi9VZVVXaEtG?=
 =?utf-8?B?N3hPeXV2N29FN1ZxcENrZzRkbVFZN1dXSkR0anVCK1d6bXRFRU5SYzB6bVJ5?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 718e85a9-9808-4c24-0cf5-08dc789501e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 06:20:55.6416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlghiRcorQ0rC+D2l5u1Cm/7ftyYJocAWo1u0BJbtftwQ/dxV8Or89brpKrNE2IK+JXDDKcPQsWVVt7wBr0bvrNhQcjjFW/IXP8oR47tXGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0584
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

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEUgU2hhdHRvdyA8bHVj
ZW50QGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI05bm0NeaciDIw5pelIDEzOjA2DQo+
IOaUtuS7tuS6ujogTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiDm
ioTpgIE6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT47IFJvZ2VyDQo+IFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPjsgTmVpbCBBcm1z
dHJvbmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+Ow0KPiBBbGV4ZXkgUm9tYW5vdiA8YXZy
b21hbm92QHNhbHV0ZWRldmljZXMuY29tPjsgU3VtaXQgR2FyZw0KPiA8c3VtaXQuZ2FyZ0BsaW5h
cm8ub3JnPjsgTWFyayBLZXR0ZW5pcyA8a2V0dGVuaXNAb3BlbmJzZC5vcmc+OyBOaXNoYW50aA0K
PiBNZW5vbiA8bm1AdGkuY29tPjsgUmljayBDaGVuIDxyaWNrQGFuZGVzdGVjaC5jb20+OyBMZW8g
WXUtQ2hpIExpYW5nDQo+IDx5Y2xpYW5nQGFuZGVzdGVjaC5jb20+OyB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgSGVpbnJpY2ggU2NodWNoYXJkdA0KPiA8eHlwcm9uLmdscGtAZ214LmRlPjsgU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MSAwLzddIEFk
ZCBTdGFyZml2ZSBKSDcxMTAgQ2FkZW5jZSBVU0IgZHJpdmVyDQo+IA0KPiBIaSwgdGhlcmUgaXMg
YSBjb21waWxlIHdhcm5pbmcuIEkgZG9uJ3Qga25vdyB3aHkuDQo+IA0KPiBPbiBTYXQsIE1heSA0
LCAyMDI0IGF0IDg6MDTigK9BTSBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIFN0YXJmaXZlIEpINzExMCBDYWRlbmNlIFVTQiBk
cml2ZXIgYW5kIHJlbGF0ZWQgUEhZIGRyaXZlci4NCj4gPiBTbyB0aGUgY29kZXMgY2FuIGJlIHVz
ZWQgaW4gdmlzaW9uZml2ZTIgYW5kIG1pbGt2IDcxMTAgYm9hcmQuDQo+ID4NCj4gPiBUaGUgZHJp
dmVyIGlzIGFsbW9zdCB0aGUgc2FtZSB3aXRoIGtlcm5lbCBkcml2ZXIuDQo+ID4NCj4gPiBwYXRj
aDE6IEFkZCBzZXQgcGh5IG1vZGUgZnVuY3Rpb24gaW4gY2RuczMgY29yZSBkcml2ZXINCj4gPiAg
ICAgICAgIHdoaWNoIGlzIHVzZWQgYnkgU3RhcmZpdmUuDQo+ID4NCj4gPiBwYXRjaDItMzogVVNC
IGFuZCBQQ0llIDIuMCAodXNiIDMuMCkgUEhZIGRyaXZpZXINCj4gPiBwYXRjaDQ6IENhZGVuY2Ug
VVNCIHdyYXBwZXIgZHJpdmVyLg0KPiA+IHBhdGNoNS03IGR0cywgY29uZmlnIGFuZCBtYWludGFp
bmVycyB1cGRhdGUuDQo+ID4NCj4gPiBNaW5kYSBDaGVuICg3KToNCj4gPiAgIHVzYjogY2RuczM6
IFNldCBVU0IgUEhZIG1vZGUgaW4gY2RuczNfcHJvYmUoKQ0KPiA+ICAgcGh5OiBzdGFyZml2ZTog
QWRkIFN0YXJmaXZlIEpINzExMCBVU0IgMi4wIFBIWSBkcml2ZXINCj4gPiAgIHBoeTogc3RhcmZp
dmU6IEFkZCBTdGFyZml2ZSBKSDcxMTAgUENJZSAyLjAgUEhZIGRyaXZlcg0KPiA+ICAgdXNiOiBj
ZG5zOiBzdGFyZml2ZTogQWRkIGNkbnMgVVNCIGRyaXZlcg0KPiA+ICAgY29uZmlnczogc3RhcmZp
dmU6IEFkZCB2aXNpb25maXZlMiBjYWRlbmNlIFVTQiBjb25maWd1cmF0aW9uDQo+ID4gICBkdHM6
IHN0YXJmaXZlOiBBZGQgSkg3MTEwIENhZGVuY2UgVVNCIGR0cyBub2RlDQo+ID4gICBNQUlOVEFJ
TkVSUzogVXBkYXRlIFN0YXJmaXZlIHZpc2lvbmZpdmUyIG1haW50YWluIGZpbGVzLg0KPiA+DQo+
ID4gIC4uLi9kdHMvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICB8ICAgNSAr
DQo+ID4gIGFyY2gvcmlzY3YvZHRzL2poNzExMC5kdHNpICAgICAgICAgICAgICAgICAgICB8ICA1
MiArKysrKw0KPiA+ICBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUyAgICAg
ICAgfCAgIDIgKw0KPiA+ICBjb25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2RlZmNvbmZpZyAg
ICAgICAgfCAgIDkgKw0KPiA+ICBkcml2ZXJzL3BoeS9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3BoeS9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3BoeS9zdGFyZml2ZS9LY29uZmlnICAg
ICAgICAgICAgICAgICAgfCAgMTkgKysNCj4gPiAgZHJpdmVycy9waHkvc3RhcmZpdmUvTWFrZWZp
bGUgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gPiAgZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5
LWpoNzExMC1wY2llLmMgICAgICAgIHwgMjExDQo+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICBk
cml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLXVzYjIuYyAgICAgICAgfCAxMzUgKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
IHwgICA3ICsNCj4gPiAgZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgIHwgICAyICsNCj4gPiAgZHJpdmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZpdmUuYyAgICAg
ICAgICAgIHwgMTg0ICsrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3VzYi9jZG5zMy9jb3Jl
LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKysNCj4gPiAgMTQgZmlsZXMgY2hhbmdlZCwg
NjUyIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGh5L3N0
YXJmaXZlL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvcGh5L3N0YXJm
aXZlL01ha2VmaWxlICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3BoeS9zdGFyZml2
ZS9waHktamg3MTEwLXBjaWUuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkv
c3RhcmZpdmUvcGh5LWpoNzExMC11c2IyLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdXNiL2NkbnMzL2NkbnMzLXN0YXJmaXZlLmMNCj4gPg0KPiA+DQo+ID4gYmFzZS1jb21taXQ6
IDE3NGFjOTg3NjU1Yzg4ODAxN2M4MmRmMTg4M2MwYzJlYTBkYzI0OTUNCj4gPiAtLQ0KPiA+IDIu
MTcuMQ0KPiA+DQo+IA0KPiBUaGUgY29tcGlsZSB3YXJuaW5nIGFzIGZvbGxvd3M6DQo+IA0KPiBJ
biBmaWxlIGluY2x1ZGVkIGZyb20NCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9kcml2
ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYzo3MDoNCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290Lmdp
dC9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOiBJbiBmdW5jdGlvbg0KPiDigJhiaXRtYXBfZmluZF9u
ZXh0X3plcm9fYXJlYeKAmToNCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9pbmNsdWRl
L2xpbnV4L2JpdG1hcC5oOjE3MDoxNzogd2FybmluZzoNCj4gaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24g4oCYZmluZF9uZXh0X3plcm9fYml04oCZOyBkaWQgeW91IG1lYW4NCj4g4oCY
ZmluZF9uZXh0X2JpdOKAmT8gWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ICAg
MTcwIHwgICAgICAgICBpbmRleCA9IGZpbmRfbmV4dF96ZXJvX2JpdChtYXAsIHNpemUsIHN0YXJ0
KTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAg
IHwgICAgICAgICAgICAgICAgIGZpbmRfbmV4dF9iaXQNCj4gICBDQyAgICAgIGRyaXZlcnMvdXNi
L2NkbnMzL2VwMC5vDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KPiAvaG9tZS91c2VyL3NvdXJj
ZS91LWJvb3QuZ2l0L2luY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oOjI2LA0KPiAgICAgICAg
ICAgICAgICAgIGZyb20NCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9kcml2ZXJzL3Vz
Yi9jZG5zMy9lcDAuYzoxOToNCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9pbmNsdWRl
L2xpbnV4L2JpdG1hcC5oOiBJbiBmdW5jdGlvbg0KPiDigJhiaXRtYXBfZmluZF9uZXh0X3plcm9f
YXJlYeKAmToNCj4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9pbmNsdWRlL2xpbnV4L2Jp
dG1hcC5oOjE3MDoxNzogd2FybmluZzoNCj4gaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rp
b24g4oCYZmluZF9uZXh0X3plcm9fYml04oCZOyBkaWQgeW91IG1lYW4NCj4g4oCYZmluZF9uZXh0
X2JpdOKAmT8gWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ICAgMTcwIHwgICAg
ICAgICBpbmRleCA9IGZpbmRfbmV4dF96ZXJvX2JpdChtYXAsIHNpemUsIHN0YXJ0KTsNCj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgIHwgICAgICAg
ICAgICAgICAgIGZpbmRfbmV4dF9iaXQNCj4gDQo+IA0KPiBJcyB0aGlzIHNvbWV0aGluZyBtaXNz
aW5nIGluIHRoZSBwYXRjaCBzZXJpZXM/DQo+IA0KPiAtRQ0KDQpJIGhhdmUgbm90IG5vdGljZWQg
dGhpcy4gSSBqdXN0IGNoZWNrIHRoaXMgaXQgaXMgcmlzYy12IGNvZGUgZG8gbm90IGNvbnRhaW4g
ImZpbmRfbmV4dF96ZXJvX2JpdCIgbWFjcm8gZGVmaW5lLg0K
