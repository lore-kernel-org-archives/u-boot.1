Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223CECA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1AA83AFD;
	Tue,  2 Sep 2025 11:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF9C83A1A; Tue,  2 Sep 2025 09:44:45 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DDD83253
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRnZsVlca/WH8ocfoXrZhhr+PWWJrdV8XBrgt5trL2Tuec+dTFMslENU/YcOr+Wrt105MGSxC+Sw16WNeTX1AayTCQwKPdFUMBeA7yMzgar9kHYTXAkYQv4TG73IXVbUxy+E3YqsH7juCqIyNqZjiEw5QSyy6bO+eMNzwY3PJKg6mZmSyE3HDG5lhWOLlVOH4tOtxvOMrWdY/fOOtjNEqdybpMTSPRdP1+r8ooqUcZF7H7xnkuENMMdCZAPBu3n9o8C6HutN0Jxk7EE85VejrupcGLsCbmx0YctsaD6qTJ1VNumzpxAHkz2KjnsryN+WY32f/gL8Zmj0jJnOidSwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MFnbnr4L17BzPDOgyARi8DWKgbqabsoasBr0fyHWAQ=;
 b=hb8I/AFa/gpGvFHZIX8iXyMcdcyZQ8HqnPdyL0BRLzkE1+19Q5cHn38qkTiqFFAu9w7PdgVWl1T2P/IZGLC7gTj0us275St3K1IscyaGDI2GAP9ikpvhr+duMQrPT/+jHe7EcUldlN1CBi54oDMd6D6I13XJLEs4hGuevtqg7IB23cOFI4yn/R7lcNANsTMtg4VPJH+OdFkm2STJ+lzNS/HhNc86VJn8gVRBl8Edenm/E3f0Vzn4SKLKBMklUdpG8RNalPJYTGvDqgfSt5a+BMnxXEk5agUROUA6MA0iRmpFY+wwtmC7r6udHpP/+1xiMniNgi5yJMv7AO0+XDxXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:44:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:44:38 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, E Shattow <e@freeshell.de>
Subject: RE: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
Thread-Topic: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
Thread-Index: AQHcGKuTWM2Kq+GOykaliHufSb7fJrR5QBQAgAZDXAA=
Date: Tue, 2 Sep 2025 07:44:37 +0000
Message-ID: <ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-5-hal.feng@starfivetech.com>
 <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
In-Reply-To: <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
x-ms-office365-filtering-correlation-id: 948e30c6-5595-4f4b-d269-08dde9f4918f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: 0BBJzcZMWvEuLv8qx9JMXDMkwIxKGlWmYZqeO+s5M4AWs+KM0Fz/qW1Qb7vTCm3copNOGQ1dU12AqMxK7hpn0Puy5jlCDtrVJK2pTQwh+fifG9OFtYTNIR3Ey8j1OiGgTtP/3GbBxp2yyIKw2z4T5smdxAusKgNn475ZGMBuiwv3pSecqZXkLeFieVrv/VTDjf5Wc2cprFoDXuu40kSnIt+rjFqulvDExHKEai9SC/nP3MFBvd+6lD15s7GKwBny9zqyqnt2w6mFhqSrvsi7+FUoE6YvOeJpil5gwk0p7HVzmy6ebtr0/ShfR5z1E+siiRxFrAH+AbHzb2OL4cIhQOXri69+SHY/oZmSw5A1mmk2mTVYrKaPjfkXo5GJ7KZYlbJb2s0rmMQECkxn6ND/6MgK9QN8FcHISO3GAHpBZ8Rl1aL34lRhnBaTlPuHI/FTeFm/scIR/bdXHyXj0VTtzJFqXcYGJ/hhjx7lyw4n4RvnLmEt8mt4Ax9x7igfe+461n1I09qPHgh4SsNnyXL9WLk5C4qANmRMikXeYTR3ufLcBn7rKC/pOxBQc0N3D/kGbXwijjQL9bHZZXBKMuRnd4Vz6+T0E4ETdTjWRXnjLbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVM1b2NUSk42RmFoTUU4MnlPZ21MM0pJT25vdk5BY2hWZmp2VTFnS3pycy9C?=
 =?utf-8?B?czJjRnd0a1Mra3pqK0psNUxHNDJ3c2VFb0N6VXlDcUFIMXJWVjRtclEyalJx?=
 =?utf-8?B?RTk1Ym5TTm55dWxWZWJuY0pJWldBaERXM2NzRkV1SHNCMHQxRTVFMnJSRUEr?=
 =?utf-8?B?Y3lHUEdkNHh4MkFzcUFMRHZhNG1zM21RZ3FKakErekE4SGxNV0xFNmdDeHo3?=
 =?utf-8?B?WUdSY09OZWtUTHo1R1BXcmY2c2I0KzMyVnFuRndBUEhRcmUycUJxUFNVRTlF?=
 =?utf-8?B?eGllbHVSMTFReWRVL1hSV1llQ0dXc0xVczhXS2pBaFNUZnRpUGVCZDFmbzJw?=
 =?utf-8?B?bmVhNExMbWk3SUg1U0lpYXArVkRYT0kwODhINTJYaEpaVzA3ZEt3UmZKNExj?=
 =?utf-8?B?Z1lJQmhVSDRPa1FRdTR5MktjQXRNTU8yY2FQNS8xL2MrRlRxM08yQUg1NVcw?=
 =?utf-8?B?dlcwQkI3cVNxSytBU0FsZS9tcU9tS1VVVlVUN1NvemV4aGw5Q0NQOXVEbndx?=
 =?utf-8?B?SFNJOXhCeE5xZ0ZHcUFZQ3NjOGE2R2d3ZjRyNmR6MEc0QWd6KzA1b29PaWUy?=
 =?utf-8?B?c2I2UWVUdFNpN3gvQ2ZjQzFMRjlqdWRLSUw1N0ttbzFYL0NObTlCNE5jOEZ0?=
 =?utf-8?B?S0JWTWhCbjRXaHoxVXl2ZGkrY2w5VXhNOHJHcytzV0tQM3BCVE0zdWFXVW14?=
 =?utf-8?B?NnV0OEFrdU1TdnhaUEw1d2dFNGtNZVRhdUlCbjdkQVh3NTdkdEwwc1BrVkZm?=
 =?utf-8?B?a3lsQkk5RjY4MnRRZzJuN3cxTHpHc3ZsSThhR3JvdWFlajIrM2lXNmtnRVpn?=
 =?utf-8?B?TWVUUy9qWG5UaU41Rm5sTytkTVhyalBLYVo5MmdnM1dmOWNRL1l5RG5hK1dh?=
 =?utf-8?B?cHcxcGpBWEJZd3dtSTQ2bHB1UHdVMDhtWGFFdVZjdUowZ3g5Y3YwOTZqL1hr?=
 =?utf-8?B?MzFraFVETCtjVkpPTEZrNm8rUkcySitka2ptMmsyWUtQU0p3YXlMcDZ2aXN3?=
 =?utf-8?B?aFdqSlJpVzg5cEg1VDZrR3J5Wit6SXNaSlFCeHpqdkJYMThSMGVnODg3Y0l6?=
 =?utf-8?B?UTFkaE50TGhnd3p6YlJaVEd4UG12U2NuckhnOVdMOUdZRVA3RXlaUFFnZXND?=
 =?utf-8?B?Vm1tOUMvMHlCajlpMWU2TkJzZU9waXcxTWNFSy9kblU4Mis4UzA2STU3ckV2?=
 =?utf-8?B?V0laTWdLZU5BVk53QVg2cyt0TE9sZTJkNEFSTFY5ek91aGhCbko5MVRTb1Ix?=
 =?utf-8?B?SFczdHRrQU1CVmlxM0U1Tll0KzIybmhkamYwU0NEY0E1a3F4cGQxM1VlZmRD?=
 =?utf-8?B?MS82aEpWYnNNZHl1dWVPdVk3S25XZkxOaTN5WkdITVFjUG1wdmhpS2FXZmw3?=
 =?utf-8?B?T3RqVnZ2Y1hvS0RwakU3ajg5L2tDMnZrcUgvZTdFZmp0VUpVUXBiTHBKZU9t?=
 =?utf-8?B?eEhrTGRPRTlRSk1wMWtPQjV1cEhLczdnazJ3YzlPaGw5cmhscWozYzFRc2xx?=
 =?utf-8?B?TFEvSGV5bFN1SlhyOVlkNFk5SmcvamNEeE9UdE1sZVZSWjJpOEl2ZnB4MEd3?=
 =?utf-8?B?bWlUSTN6NHRsYlFnMk1YaHlNYkJNNWdzZi9GY0xZZWtCeWtXT3dkYytPRlI4?=
 =?utf-8?B?aWRlWHYwU0tkdnJmY1AyR1ducEtjeVZSN09sMjNXSzlZZ2NFZWhNelREZ05a?=
 =?utf-8?B?c2VWMzloa3FUUDBHWEUvd1ZsdmdQUXJ4UUFKMUp5b05EZWNsdGZ3ekVGUmh2?=
 =?utf-8?B?VWVSQ3Nld2IwaUlscmNHSGNxdStsaU5ETDRKd0pVa0xpM2xlQ0dkNnVrOGFS?=
 =?utf-8?B?RWFWbUVRUDEzVE9XWnlkMGcwSTJQWS9EdHJBT3RvWCs4UEszODRqcDkzR285?=
 =?utf-8?B?RWN1NXlnbldVZWk5bkpyU0dTTzFSSUQwUVFyZEp2V1ZoMGdXcDZNNC93ZUVB?=
 =?utf-8?B?bHczRng4UFRPazJJSldFcWtJODZwdlZ4L1RFdkwzWm9RaDNIOC9oRHIrYWlN?=
 =?utf-8?B?aGl0c2w2MEprRk0yb2dGcVoycUdqZWVKZEl4d3BWUVNEeFdSMUxvU0kwTUFj?=
 =?utf-8?B?Y2RrUDM0NGtYQmR6QlZtSCtrem94T2Z2aDNkSHhvRnVVaisycWxDeXdObTVw?=
 =?utf-8?Q?wvRIujpAjgRS8sxUfh6i2oxqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e30c6-5595-4f4b-d269-08dde9f4918f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 07:44:37.9436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z29m7KTGUwKQz7K89bY1RTM5Yesd0Dd2ssd4KGz/bZ4tfGYWJlewfsmCQDxf7FZzRRZIm4sSZYDvh+VH7yFox2TGNujsJm8r7953uN4St+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:12:53 +0200
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

PiBPbiAyOS4wOC4yNSAxNTo0NCwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMjku
MDguMjUgMDg6MDksIEhhbCBGZW5nIHdyb3RlOg0KPiA+IHBjYl9yZXZpc2lvbiBpcyBzdG9yZWQg
aW4gdGhlIHBjYl9yZXZpc2lvbiBmaWVsZCBvZiBBVE9NNC4gQ29ycmVjdCBpdC4NCj4gPiBNb3Zl
IHRoZSBmdW5jdGlvbiBkZXNjcmlwdGlvbiB0byB0aGUgaGVhZGVyIGZpbGUuDQo+ID4gUmVtb3Zl
IHRoZSBmdW5jdGlvbiBjYWxscyBpbiBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi8uDQo+ID4N
Cj4gPiBGaXhlczogYWVhMWJkOTViNjFlICgiZWVwcm9tOiBzdGFyZml2ZTogRW5hYmxlIElEIEVF
UFJPTSBjb25maWd1cmF0aW9uIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwgRmVuZyA8aGFsLmZl
bmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9h
c20vYXJjaC1qaDcxMTAvZWVwcm9tLmggICB8ICA1ICsrKysrDQo+ID4gICBib2FyZC9zdGFyZml2
ZS92aXNpb25maXZlMi9zcGwuYyAgICAgICAgICAgICAgfCAxOCArKysrKystLS0tLS0tLS0tLQ0K
PiA+ICAgLi4uL3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUyLmMgICAgICAgIHwgMjAg
KysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICAgLi4uL3Zpc2lvbmZpdmUyL3Zpc2lvbmZpdmUyLWky
Yy1lZXByb20uYyAgICAgIHwgMTEgKystLS0tLS0tLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2FyY2gtamg3MTEwL2VlcHJvbS5oDQo+IGIvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9hcmNoLWpoNzExMC9lZXByb20uaA0KPiA+IGluZGV4IDZkMGEwYmEwYzRh
Li4wMjVmMWQzMmM0OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Fy
Y2gtamg3MTEwL2VlcHJvbS5oDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNo
LWpoNzExMC9lZXByb20uaA0KPiA+IEBAIC05LDYgKzksMTEgQEANCj4gPg0KPiA+ICAgI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIGdldF9wY2JfcmV2aXNp
b25fZnJvbV9lZXByb20oKSAtIGdldCB0aGUgUENCIHJldmlzaW9uDQo+ID4gKyAqDQo+ID4gKyAq
IEByZXR1cm46IHRoZSBQQ0IgcmV2aXNpb24gb3IgMHhGRiBvbiBlcnJvci4NCj4gPiArICovDQo+
ID4gICB1OCBnZXRfcGNiX3JldmlzaW9uX2Zyb21fZWVwcm9tKHZvaWQpOw0KPiA+DQo+ID4gICAv
KioNCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMNCj4g
Yi9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zcGwuYw0KPiA+IGluZGV4IDNkZmE5MzFiNjU1
Li45MDFlN2I1OGYzNiAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZl
Mi9zcGwuYw0KPiA+ICsrKyBiL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3NwbC5jDQo+ID4g
QEAgLTEyNiwxOSArMTI2LDEzIEBAIGludCBib2FyZF9maXRfY29uZmlnX25hbWVfbWF0Y2goY29u
c3QgY2hhcg0KPiAqbmFtZSkNCj4gPiAgIAkJICAgICFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zy
b21fZWVwcm9tKCksICJTVEFSNjQiLCA2KSkgew0KPiA+ICAgCQlyZXR1cm4gMDsNCj4gPiAgIAl9
IGVsc2UgaWYgKCFzdHJjbXAobmFtZSwgInN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25m
aXZlLTItdjEuMmEiKQ0KPiAmJg0KPiA+IC0JCSAgICAhc3RybmNtcChnZXRfcHJvZHVjdF9pZF9m
cm9tX2VlcHJvbSgpLCAiVkY3MTEwIiwgNikpIHsNCj4gPiAtCQlzd2l0Y2ggKGdldF9wY2JfcmV2
aXNpb25fZnJvbV9lZXByb20oKSkgew0KPiA+IC0JCWNhc2UgJ2EnOg0KPiA+IC0JCWNhc2UgJ0En
Og0KPiA+IC0JCQlyZXR1cm4gMDsNCj4gPiAtCQl9DQo+ID4gKwkJICAgKCFzdHJuY21wKGdldF9w
cm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTBBIiwgNykNCj4gfHwNCj4gPiArCQkgICAg
IXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwgIlZGNzExMGEiLCA3KSkpDQo+
IHsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiAgIAl9IGVsc2UgaWYgKCFzdHJjbXAobmFtZSwgInN0
YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiKQ0KPiAmJg0KPiA+IC0J
CSAgICAhc3RybmNtcChnZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgpLCAiVkY3MTEwIiwgNikp
IHsNCj4gPiAtCQlzd2l0Y2ggKGdldF9wY2JfcmV2aXNpb25fZnJvbV9lZXByb20oKSkgew0KPiA+
IC0JCWNhc2UgJ2InOg0KPiA+IC0JCWNhc2UgJ0InOg0KPiA+IC0JCQlyZXR1cm4gMDsNCj4gPiAt
CQl9DQo+ID4gKwkJICAgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJW
RjcxMTBCIiwgNykNCj4gfHwNCj4gPiArCQkgICAgIXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJv
bV9lZXByb20oKSwgIlZGNzExMGIiLCA3KSkpDQo+IHsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiAg
IAl9DQo+ID4NCj4gPiAgIAlyZXR1cm4gLUVJTlZBTDsNCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQv
c3RhcmZpdmUvdmlzaW9uZml2ZTIvc3RhcmZpdmVfdmlzaW9uZml2ZTIuYw0KPiBiL2JvYXJkL3N0
YXJmaXZlL3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUyLmMNCj4gPiBpbmRleCBiZmJi
MTFhMmVlNy4uZjM4NDMzZTk0YWMgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvc3RhcmZpdmUvdmlz
aW9uZml2ZTIvc3RhcmZpdmVfdmlzaW9uZml2ZTIuYw0KPiA+ICsrKyBiL2JvYXJkL3N0YXJmaXZl
L3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUyLmMNCj4gPiBAQCAtNTksMjAgKzU5LDEy
IEBAIHN0YXRpYyB2b2lkIHNldF9mZHRmaWxlKHZvaWQpDQo+ID4gICAJCWZkdGZpbGUgPSAic3Rh
cmZpdmUvamg3MTEwLW1pbGt2LW1hcnMuZHRiIjsNCj4gPiAgIAl9IGVsc2UgaWYgKCFzdHJuY21w
KGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJTVEFSNjQiLCA2KSkgew0KPiA+ICAgCQlm
ZHRmaWxlID0gInN0YXJmaXZlL2poNzExMC1waW5lNjQtc3RhcjY0LmR0YiI7DQo+ID4gLQl9IGVs
c2UgaWYgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTAiLCA2
KSkgew0KPiA+IC0JCXN3aXRjaCAoZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2VlcHJvbSgpKSB7DQo+
ID4gLQkJY2FzZSAnYSc6DQo+ID4gLQkJY2FzZSAnQSc6DQo+ID4gLQkJCWZkdGZpbGUgPSAic3Rh
cmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi0NCj4gdjEuMmEuZHRiIjsNCj4gPiAt
CQkJYnJlYWs7DQo+ID4gLQkJY2FzZSAnYic6DQo+ID4gLQkJY2FzZSAnQic6DQo+ID4gLQkJCWZk
dGZpbGUgPSAic3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi0NCj4gdjEuM2Iu
ZHRiIjsNCj4gPiAtCQkJYnJlYWs7DQo+ID4gLQkJZGVmYXVsdDoNCj4gPiAtCQkJbG9nX2Vycigi
VW5rbm93biByZXZpc2lvblxuIik7DQo+ID4gLQkJCXJldHVybjsNCj4gPiAtCQl9DQo+ID4gKwl9
IGVsc2UgaWYgKCFzdHJuY21wKGdldF9wcm9kdWN0X2lkX2Zyb21fZWVwcm9tKCksICJWRjcxMTBB
IiwgNykgfHwNCj4gPiArCQkgICAhc3RybmNtcChnZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgp
LCAiVkY3MTEwYSIsIDcpKSB7DQo+IA0KPiBXaGVyZSBib2FyZHMgYm90aCB3aXRoICdhJyBhbmQg
J2InIGV2ZXIgc2hpcHBlZD8NCj4gSSBoYXZlIG9ubHkgc2VlbiAnQScgYW5kICdCJyBpbiBwYnVm
LmVlcHJvbS5hdG9tMS5kYXRhLnBzdHJbNl0uDQoNCllvdSdyZSByaWdodC4gVGhlcmUgYXJlIG5v
IGJvYXJkcyBtYXJrZWQgIlZGNzExMGEiIG9yICJWRjcxMTBiIi4gTGV0J3MgcmVtb3ZlDQp0aGUg
Y29tcGFyaXNvbiBvZiAiVkY3MTEwYSIgYW5kICJWRjcxMTBiIi4NCg0KQmVzdCByZWdhcmRzLA0K
SGFsDQoNCj4gDQo+IFRoZSBjaGFuZ2UgbG9va3MgdGVjaG5pY2FsbHkgY29ycmVjdC4NCj4gDQo+
IFJldmlld2VkLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDxoZWlucmljaC5zY2h1Y2hhcmR0QGNh
bm9uaWNhbC5jb20+DQo+IA0KPiA+ICsJCWZkdGZpbGUgPSAic3RhcmZpdmUvamg3MTEwLXN0YXJm
aXZlLXZpc2lvbmZpdmUtMi12MS4yYS5kdGIiOw0KPiA+ICsJfSBlbHNlIGlmICghc3RybmNtcChn
ZXRfcHJvZHVjdF9pZF9mcm9tX2VlcHJvbSgpLCAiVkY3MTEwQiIsIDcpIHx8DQo+ID4gKwkJICAg
IXN0cm5jbXAoZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20oKSwgIlZGNzExMGIiLCA3KSkgew0K
PiA+ICsJCWZkdGZpbGUgPSAic3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12
MS4zYi5kdGIiOw0KPiA+ICAgCX0gZWxzZSB7DQo+ID4gICAJCWxvZ19lcnIoIlVua25vd24gcHJv
ZHVjdFxuIik7DQo+ID4gICAJCXJldHVybjsNCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvc3RhcmZp
dmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+IGIvYm9hcmQvc3RhcmZp
dmUvdmlzaW9uZml2ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4gaW5kZXggMzg2NmQw
N2Y5ZDQuLjQzYjhhZjRmYzU5IDEwMDY0NA0KPiA+IC0tLSBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lv
bmZpdmUyL3Zpc2lvbmZpdmUyLWkyYy1lZXByb20uYw0KPiA+ICsrKyBiL2JvYXJkL3N0YXJmaXZl
L3Zpc2lvbmZpdmUyL3Zpc2lvbmZpdmUyLWkyYy1lZXByb20uYw0KPiA+IEBAIC01MzUsMTkgKzUz
NSwxMiBAQCBpbnQgbWFjX3JlYWRfZnJvbV9lZXByb20odm9pZCkNCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiAgIH0NCj4gPg0KPiA+IC0vKioNCj4gPiAtICogZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2Vl
cHJvbSAtIGdldCB0aGUgUENCIHJldmlzaW9uDQo+ID4gLSAqDQo+ID4gLSAqIDEuMkEgcmV0dXJu
ICdBJy8nYScsIDEuM0IgcmV0dXJuICdCJy8nYicsb3RoZXIgdmFsdWVzIGFyZSBpbGxlZ2FsDQo+
ID4gLSAqLw0KPiA+ICAgdTggZ2V0X3BjYl9yZXZpc2lvbl9mcm9tX2VlcHJvbSh2b2lkKQ0KPiA+
ICAgew0KPiA+IC0JdTggcHYgPSAweEZGOw0KPiA+IC0NCj4gPiAgIAlpZiAocmVhZF9lZXByb20o
KSkNCj4gPiAtCQlyZXR1cm4gcHY7DQo+ID4gKwkJcmV0dXJuIDB4RkY7DQo+ID4NCj4gPiAtCXJl
dHVybiBwYnVmLmVlcHJvbS5hdG9tMS5kYXRhLnBzdHJbNl07DQo+ID4gKwlyZXR1cm4gcGJ1Zi5l
ZXByb20uYXRvbTQuZGF0YS5wY2JfcmV2aXNpb247DQo+ID4gICB9DQo+ID4NCj4gPiAgIHU4IGdl
dF9kZHJfc2l6ZV9mcm9tX2VlcHJvbSh2b2lkKQ0KDQo=
