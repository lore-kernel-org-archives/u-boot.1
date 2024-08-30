Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E2CA0EE0
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 05:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C53E88D02;
	Fri, 30 Aug 2024 07:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6310288C82; Fri, 30 Aug 2024 07:52:50 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20702.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B6888D08
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE4Tt6uQbcYhzFJZjal4oFOfzdzOo0Tzz6m9mUZwQQUYVkUYaCe+UuEdwOfLtCDBjE+0gypEsnqhNVu8hP2/O1FxdWlLahG9WxcdrAv0/LfHO+py8OSj29hAlWFQItftDEib5JLdr4c8vR2drNZpDyztkKMjKtKQm17iz0YRf8w/sIz9Qiswfhg/AD5athVwm8TO1fnp34ujWP5LdZyjWc69Q4nc5+yugQaCeF366yhAokAeB8yLR/EU+blIrnJXlF8sPZnjEPYRxGCRbcmbeDwgZEhbhqb2e3e9XTbB8dlIsOFR6zm3okzYwqsS4jPBlPD2e4D3mak9XAYwqQYf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffIuh/Tdh7y4z2d7FQ0RqoMNTcFh3933VDgaAHmAHs4=;
 b=G8Wrz5v243JWDSJy4ZaXyeBYW5Pm/J4W5SxQnozHJ4bqTSUThKMH1gYYTD3wEEoatGXm7G4dX4MFZt4q0ROR+aSHcO4NMG1q2zua3ZgJfotXCkvJQ6lA/J5yeeXUkeEwOZJMDDfVKqCfm6g6CRfMO3HNEF5Ji9V+GXe8FXryy762N6PvoGftQ7BHmt7l1qUeO2F+keIuxPbQBXe/+E1oIYdEBcf/Wr/T/pmhITAUYknMArJrdPgb6LvlhA+DNz51QVNvdEKzfENVEw3POyMCG7mzLGC/MarP9QYgK7lOwp7Ehavsb/aCNXUuzf1jew7m4iT0Y6zsghU11SEXK4f3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0751.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 05:52:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Fri, 30 Aug 2024 05:52:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: E Shattow <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
CC: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 7/9] dts: starfive: Add JH7110 Cadence USB dts node
Thread-Topic: [PATCH v4 7/9] dts: starfive: Add JH7110 Cadence USB dts node
Thread-Index: AQHa+bMkAl2iS8AhzEqT/71qm77Ak7I9qcKAgAACx4CAAaGyIA==
Date: Fri, 30 Aug 2024 05:52:38 +0000
Message-ID: <SHXPR01MB086383359CD92A74771FEF88E6972@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-8-minda.chen@starfivetech.com>
 <CAFA6WYOFFxO3ob+Fj9YEotLnxwTD1hJwX4oEZtiJjSCkzNkj=g@mail.gmail.com>
 <CANV2PTMc5ZeHSWgxJ+aX31S1GmV-KhfyTNg4JtM77fVk7CH61g@mail.gmail.com>
In-Reply-To: <CANV2PTMc5ZeHSWgxJ+aX31S1GmV-KhfyTNg4JtM77fVk7CH61g@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0751:EE_
x-ms-office365-filtering-correlation-id: 8696fe14-d08a-4ea2-9949-08dcc8b7f472
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: K075mysercngTycdcMZ1W8uHC1uHUsuOmDIriUjq4aIEpWrqYwLtUnB/Ql75BxVMCw1l2er1SB5KrUk0axhq1ksjUmvRhXApLUXBrMVmG3Qwzj+Sq5wKqDdsJp7V2n2K7zPnoWjQzURvoGfk6t3XKAbKjH9gmcefOHrv7TdJTHMxKRnahTPPyuXZd47IuLKeSdiGFndBuZcTpavjXhvGd5TmGsSoWCPKJ0caFs1udsqUlT4VkJ3sa8xshLYKvA4JMHxCMltfZOMJqxVgYEF7C2NYIdfWIwX9Q7NWdjv4D7jE7w6A+liFVfpVkMWVDaJd6OAhL4QzWIsbdnpRbtB8goMkC25HBE3648mXoBa99fOJddg3PtFqz2XBncuoVInVPB+gedDygaYosQGNJ6x3NY/YihtV9FvLOS0bw660dO8Qja6mHlGSRYVu80D2nAomb6NHGLEKH5znrJw6RZbpYoEMlAPPonYVaTa3Zgl7XrN0Kd3IlGhfeMscqmTYAKU2JeD/HTs/U5yZYFfYM2cVzbKOWmOYy80yBBiFk3O52Hdo4o2u/ZNMjY+pfYGpoeivVGxY//Vepfau7IA19t+G14Wzk4h3PpXhTIIzGSgJpA/2DG3iVSfy5kOk8ft+l+b3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0c3a05SS0x0Z29UWGd6bFRMY3UxY2k0aW5mWXJDWGEwRFVJNk9JRnV2cTdE?=
 =?utf-8?B?RmlCYUJYSGNCbFhZbkJwZUxkbXI3R2hjdTB4NXNCandmMXdJQVlkKzlDY1VL?=
 =?utf-8?B?MVJHY1F1ZjloNEhUUXFNOFRac0d2L0wrRHBZMkhxeXBpR0srSEFvTU45V2NH?=
 =?utf-8?B?MUFZSzJMNnorMEw2VFB4SHFFSHlwZlhEczF4a2txNFlrT3ZlTDRuVDk5dldq?=
 =?utf-8?B?RTA5NjZKeUIrZ2dOc1FBVmxkbjJBejNWQ3FEODRwaU10NUVQMFhieE5mcFpv?=
 =?utf-8?B?RVdZZXdicjd6OG9MUDEyL0tkdmRLcklTaGo2blc0enUydUxVYlhBdld5UWZ6?=
 =?utf-8?B?eldYZlNQTTNPUit6MVA5SjA5NkM3ZDllWE85YXQ1b25FbkgzbzRuR1pnWjUz?=
 =?utf-8?B?bWxLazc4NFZ4UWNJN3h5ZmJ1bUpkNkI5WkkxVENOK2FTRjZoYSt4NGpVL2RP?=
 =?utf-8?B?VnBCVXhMUHVYdWdGdVplc3YvbjkxY3QwNUlNR1AvMGwxNndMVWoxSTVvVTd0?=
 =?utf-8?B?cU1ieXJqeHphSUExUm1UOG45NU9rcU1ON0daZ0RxWmtIY0F5dkt3Q3BGNDB3?=
 =?utf-8?B?cTBTS2pVaiswRG1hRVBIb3p5K2Erd3I4c0ZkT2NKbStrL0drRXBoSmlSNS9Q?=
 =?utf-8?B?QVpWRmwwaU9GazNzdko5UENlRU9hUHllYXY1K25teGxFUkdYYytybFl2QUVp?=
 =?utf-8?B?bUZXK3ByN1lGRHVkblVveGp3U245YWtTczIxTE5vRzh4Wk9jR2Y2S3R6YUJS?=
 =?utf-8?B?NkJXcTZjc2t3dkJpRDdvdlRaSzU0RDc0aFgwMWtXYXR1cHFycXJSOXpJL0o0?=
 =?utf-8?B?b1hJb0Q4VXFPVlp3YXp1RWlyMmdpbmZkZkxYNnR0R1JzcWl2TnhHM3l3ZTJh?=
 =?utf-8?B?anZkdGZWQ2U5ZGdRYnhsN2xtRVA1U3ZwRDQ3MGtmam9CdkZUT3dUYTZVeFlx?=
 =?utf-8?B?TlVreG1ZZkM5VkxiaUhhV3l2SDBERCtFN1l3RHRqR0l4LzdxWDVhUzlSSE9I?=
 =?utf-8?B?TVJRYkNSU3VaeW1VTHMxbU5IY1ZhN3BTM0o3cUkyS2lNaFVScFhEbFZWRzJs?=
 =?utf-8?B?ZW05d3EzWTVnenRnZ3htWTRRQUE5TmUra3o2WjRWUzc3ZGpQS3poMFIwR2J0?=
 =?utf-8?B?OVVONlliSUVSUERmNm9FcEtGc2NMbkRZSEphL3NrZzZXMHhXOURUalg0MkY0?=
 =?utf-8?B?K01Hc1ZyaTJoSkI2TGIzUHZiZSswaDZiVGs1WjhkckNXQ0pqK3AvUjYyRjNN?=
 =?utf-8?B?YjAxaUhJdThkbzNnVy90UkFlc0hPOWM1c0dYMnpLemtnQ1hkRmVBcE4xNTd6?=
 =?utf-8?B?bXNKRXExQjBDSnR4L3drUzBvUXN0akV6TE12SC9EWFBIUnRadjJsbmQ1aGRT?=
 =?utf-8?B?YmVPc3FvZWk5dFRxQU5GeTViaHZQSkYxeDBxZC9DQ3dEdmt1MStjMG03ajNy?=
 =?utf-8?B?MjdWRWQ1azN1NFdPTEZLOWNJdDhJd0xmYUhwMWJmZnp1Ujc0VER0TG16bmxl?=
 =?utf-8?B?S3VHRlZvZWxhQi9yMW1zc3ZJRFVWWm5LYXBJUmxCclZlOXlNeXAzS0I3S3JQ?=
 =?utf-8?B?eVo0MGZ1V215RzA5c1BNTWoyNXJkbnRHZ1pvcHk2SWtjM043c1RhOVVCVmcw?=
 =?utf-8?B?b2hOR0lpd2tWSG56NkVjdWp0aVhpOFFxTzJtRzk5L3B1dlRPdktPZmtKQVNV?=
 =?utf-8?B?c1BDcXVmclhSWEYyOG1SS1NycXlCNjZXWDZOb3dudjN0K2hJUkxwMjNZenlJ?=
 =?utf-8?B?ZEp6NG4yNk9vckJXc3NST3BWYkJqbi93S3FjYWw1OTFuMzZ6T0R5amVOR21i?=
 =?utf-8?B?WFIvK2JkdEF3TVljQUpRbXo3RnZ5bGo4dWg3Ym5Fdy9icGZFYVhpU0VBd0du?=
 =?utf-8?B?UzJIcEtrMHFKK2F0NDNRSjRJVW1Wa1I5cS81Sk93Ty8weDRYM2JyVkUramI5?=
 =?utf-8?B?SVRqQUpKQUlvdDVtd2x6Um9KWW9oTS9BNkVCLzg1RGp5YXVxelVzVTFrRHVl?=
 =?utf-8?B?bHBkOE83TXc0dUdtSXUvazhRSXpjNE1xL2k1MmwxOHlGNWMwYzJCd05NYnYw?=
 =?utf-8?B?VmRnMWhDSVI1cUVKcVhwTUtlWk45K0hRc3l3dzllMXlIaEw1dngvamdTLzE3?=
 =?utf-8?Q?HWdSyPnGYwPk4jJtmANhmYyMX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8696fe14-d08a-4ea2-9949-08dcc8b7f472
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 05:52:38.4902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKdCY2lAZzoZRl6mdFj2aBHe9a8RKKSIqk+tI64uKpRNkTWbT6wrHZ8BHjhhMJPZyjDdbnVzCbfi44cNmwTqDZblVp47C2qJghPz4ZtYaCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0751
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

DQo+IA0KPiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCA5OjQ34oCvUE0gU3VtaXQgR2FyZyA8c3Vt
aXQuZ2FyZ0BsaW5hcm8ub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gT24gVGh1
LCAyOSBBdWcgMjAyNCBhdCAwNzowMSwgTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFyZml2ZXRl
Y2guY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBBZGQgSmg3MTEwIENhZGVuY2UgVVNCIGR0
cyBub2RlLCBWaXNpb25maXZlMiBkZWZhdWx0IHNldHRpbmcgaXMgVVNCDQo+ID4gPiAyLjAgZGV2
aWNlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmRhIENoZW4gPG1pbmRhLmNoZW5A
c3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9kdHMvamg3MTEwLXN0YXJm
aXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICB8ICA1ICsrDQo+ID4gPiAgYXJjaC9yaXNjdi9kdHMv
amg3MTEwLmR0c2kgICAgICAgICAgICAgICAgICAgIHwgNTMNCj4gKysrKysrKysrKysrKysrKysr
Kw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gQ2Fu
IHlvdSB0cnkgdG8gZXZhbHVhdGUgaWYgdGhpcyBTb0MgY2FuIHN1cHBvcnQgT0ZfVVBTVFJFQU0/
IEkgY2FuIHNlZQ0KPiA+IGNvcnJlc3BvbmRpbmcgRFQgc291cmNlcyB3ZWxsIHN1cHBvcnRlZCBi
eSBkdHMvdXBzdHJlYW0uIEFGQUlDUywgeW91DQo+ID4gYXQgbGVhc3QgbmVlZCB0byBhZGQgYSBN
YWtlZmlsZSBmb3IgUklTQy1WIGhlcmU6DQo+ID4gZHRzL3Vwc3RyZWFtL3NyYy9yaXNjdi8gZm9y
IHdoaWNoIHlvdSBjYW4gcmVmZXJlbmNlDQo+ID4gZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9NYWtl
ZmlsZS4NCj4gPg0KPiA+IFRoaXMgaXMgbm90IHNvbWV0aGluZyB0byBiZSBjb25zaWRlcmVkIGFz
IGEgYmxvY2tlciBmb3IgdGhpcyBzZXJpZXMNCj4gPiBidXQga2luZCBvZiBmb2xsb3ctdXAgd29y
ay4NCj4gPg0KPiA+IC1TdW1pdA0KPiA+DQpZZXMuIFdlIHdpbGwgc3VwcG9ydCBPRl9VUFNUUkVB
TSAuDQpIYWwgd2lsbCBkbyB0aGlzIGpvYi4NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9yaXNjdi9kdHMvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4gPiBiL2Fy
Y2gvcmlzY3YvZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPiA+ID4gaW5k
ZXggZTExYmFiYzFjZC4uNDQ3ODViYmVlMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvcmlzY3Yv
ZHRzL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPiA+ID4gKysrIGIvYXJjaC9y
aXNjdi9kdHMvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4gPiBAQCAtMzc4
LDMgKzM3OCw4IEBADQo+ID4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ICAgICAgICAgfTsN
Cj4gPiA+ICB9Ow0KPiA+ID4gKw0KPiA+ID4gKyZ1c2JfY2RuczMgew0KPiA+ID4gKyAgICAgICBk
cl9tb2RlID0gInBlcmlwaGVyYWwiOw0KPiA+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
ID4gPiArfTsNCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2R0cy9qaDcxMTAuZHRzaSBi
L2FyY2gvcmlzY3YvZHRzL2poNzExMC5kdHNpDQo+ID4gPiBpbmRleCAyY2RjNjgzZDQ5Li43YmY5
YjJhMDNhIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9kdHMvamg3MTEwLmR0c2kNCj4g
PiA+ICsrKyBiL2FyY2gvcmlzY3YvZHRzL2poNzExMC5kdHNpDQo+ID4gPiBAQCAtMzcxLDYgKzM3
MSw1OSBAQA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4NCj4gPiA+ICsgICAgICAgICAgICAg
ICB1c2IwOiB1c2JAMTAxMDAwMDAgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtdXNiIjsNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJhbmdlcyA9IDwweDAgMHgwIDB4MTAxMDAwMDAgMHgxMDAwMDA+Ow0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHN0YXJmaXZlLHN0Zy1zeXNjb24gPSA8JnN0Z19zeXNjb24gMHg0PjsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3RnY3JnDQo+IEpINzExMF9TVEdD
TEtfVVNCX0xQTT4sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnN0
Z2NyZw0KPiBKSDcxMTBfU1RHQ0xLX1VTQl9TVEI+LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPCZzdGdjcmcNCj4gSkg3MTEwX1NUR0NMS19VU0JfQVBCPiwNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc3RnY3JnDQo+IEpINzExMF9TVEdD
TEtfVVNCX0FYST4sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnN0
Z2NyZw0KPiBKSDcxMTBfU1RHQ0xLX1VTQl9VVE1JX0FQQj47DQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJscG0iLCAic3RiIiwgImFwYiIsICJheGkiLA0KPiAi
dXRtaV9hcGIiOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVzZXRzID0gPCZzdGdj
cmcNCj4gSkg3MTEwX1NUR1JTVF9VU0JfUFdSVVA+LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPCZzdGdjcmcNCj4gSkg3MTEwX1NUR1JTVF9VU0JfQVBCPiwNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc3RnY3JnDQo+IEpINzExMF9TVEdS
U1RfVVNCX0FYST4sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnN0
Z2NyZw0KPiBKSDcxMTBfU1RHUlNUX1VTQl9VVE1JX0FQQj47DQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICByZXNldC1uYW1lcyA9ICJwd3J1cCIsICJhcGIiLCAiYXhpIiwNCj4gPiA+ICsg
InV0bWlfYXBiIjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHVzYl9j
ZG5zMzogdXNiQDAgew0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21w
YXRpYmxlID0gImNkbnMsdXNiMyI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDAgMHgxMDAwMD4sDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweDEwMDAwIDB4MTAwMDA+LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8MHgyMDAwMCAweDEwMDAwPjsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gIm90ZyIsICJ4aGNpIiwgImRldiI7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MTAwPiwg
PDEwOD4sIDwxMTA+Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRl
cnJ1cHQtbmFtZXMgPSAiaG9zdCIsDQo+ICJwZXJpcGhlcmFsIiwgIm90ZyI7DQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBoeXMgPSA8JnVzYnBoeTA+Ow0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaHktbmFtZXMgPSAiY2RuczMsdXNiMi1waHki
Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICB9Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIHVzYnBoeTA6IHBoeUAxMDIwMDAw
MCB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInN0YXJmaXZl
LGpoNzExMC11c2ItcGh5IjsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDAgMHgxMDIwMDAwMCAweDAgMHgxMDAwMD47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBjbG9ja3MgPSA8JnN5c2NyZw0KPiBKSDcxMTBfU1lTQ0xLX1VTQl8xMjVNPiwNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmc3RnY3JnDQo+IEpINzExMF9TVEdDTEtf
VVNCX0FQUF8xMjU+Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMg
PSAiMTI1bSIsICJhcHBfMTI1bSI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBzdGFy
Zml2ZSxzeXMtc3lzY29uID0gPCZzeXNfc3lzY29uIDB4MTg+Ow0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCj4gPiA+ICsgICAgICAgICAgICAgICB9Ow0K
PiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIHBjaWVwaHkwOiBwaHlAMTAyMTAwMDAgew0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcx
MTAtcGNpZS1waHkiOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAw
eDEwMjEwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICNw
aHktY2VsbHMgPSA8MD47DQo+ID4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgICAgICAgICAgICBwY2llcGh5MTogcGh5QDEwMjIwMDAwIHsNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLXBjaWUtcGh5IjsN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgxMDIyMDAwMCAweDAg
MHgxMDAwMD47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAjcGh5LWNlbGxzID0gPDA+
Ow0KPiA+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gPiArDQo+ID4gPiAgICAgICAgICAgICAg
ICAgc3RnY3JnOiBjbG9jay1jb250cm9sbGVyQDEwMjMwMDAwIHsNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLXN0Z2NyZyI7DQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MTAyMzAwMDAgMHgwIDB4MTAw
MDA+Ow0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+ID4NCj4gDQo+IEkgbm90ZSB0aGF0IEhh
bCBGZW5nIHNheWluZyBlYXJsaWVyIHRoaXMgd2VlayB0aGV5IHdvdWxkIHRha2Ugb24gT0ZfVVBT
VFJFQU0NCj4gb2YgSkg3MTEwIGJvYXJkczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9aUTJQUjAxTUIxMzA3M0VGM0JEN0E2NEYyQzA5OEFBOEZFNjg4MkANCj4gWlEyUFIwMU1CMTMw
Ny5DSE5QUjAxLnByb2QucGFydG5lci5vdXRsb29rLmNuLw0KPiANCj4gSXQgaXMgYSBnb29kIHRp
bWUgZm9yIHRoaXMgd29yayB0byBiZWdpbi4NCj4gDQo+IC1FDQpZZXPvvIwgSGFsIEZlbmcgd2ls
bCBkbyB0aGlzIGpvYi4NCg==
