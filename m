Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D2CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB6483937;
	Wed, 22 Oct 2025 09:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA21B83303; Wed, 22 Oct 2025 09:12:19 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658A282E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lvj84LNEanKT//LcDzLgqTN/cvEGOuGTzKhTt0M3uPyIkids9DcNBBffd0+wJZOiSjqL64WRNVcLRQPWfg8vIdfgu9aDNeDsMDIsBczHxaSymjkQ7sVMu4Id+TGmYfXrV5Sd7aWS0NLToHCoF/rYZtBFoQJMTbFtBOpOILxsXi8mgIBn+Rf7C1oO+GUgn/0wsVj6P4I/WZcFAE8fFCZ0Ucre43on710KbrkoaMxyDdLYq93MWov3wmz0n3+qvOy3QekVd/jOpf2tB72I3PjvKG3bqQzDjfY5jRytuu7WOMEuCYd/QpfmTMIoY8Bjna/yQ6NVGg0lsxhY3PP9hIr3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSQMTWwBbv6X7Np4NN/QWK3KME1GE6a+Eh6MmX8txBw=;
 b=TDQh8srl59y6/qpAfA+gYfJuhco050HB8gBIZmoUyvr3A7y3fHkECy/MFneYeSudn0jCstIRPpnpgj77EFAEhfj1wNh6v7PPSTek+VH/qWgpH0qV0CQ+boaJTaQnMBMbIdJw1+ybRM9bFLUbjz9GeWBEgsdpZJ6OUgniGdjJ2slx1UsHunTVSrJYlCVCnCgCnPvb42AAta5K8GCYqvSaQ7OF/7GgecCBFVbzJrVRSgHM1aFuRcRFi13ovJANtStDGLhV1XNBvHHVb6flxEC214F1xZCMJHCRnv4wPQeUcGt3Mu8+1NeUuJA/WyEdAtUlRtUv/5d5OVTF29x9HrhFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1177.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:12:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 07:12:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [RFC 08/10] configs: visionfive2: Add VisionFive 2 Lite DT to
 OF_LIST
Thread-Topic: [RFC 08/10] configs: visionfive2: Add VisionFive 2 Lite DT to
 OF_LIST
Thread-Index: AQHcGKuVgvmT11bpyUazqBo/JNawgLSAnlUAgE1y3oA=
Date: Wed, 22 Oct 2025 07:12:12 +0000
Message-ID: <ZQ2PR01MB1307B68BC0E5D082145AC9DEE6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-9-hal.feng@starfivetech.com>
 <18cfc0c4-e351-409b-b611-aabd4b2ab81e@freeshell.de>
In-Reply-To: <18cfc0c4-e351-409b-b611-aabd4b2ab81e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1177:EE_
x-ms-office365-filtering-correlation-id: 755641ad-d287-48ca-037d-08de113a52d8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|38070700021; 
x-microsoft-antispam-message-info: maDw6AiM9WdxPoSGrj8NWMo+mAuioyaiLQbVF3AEg/mJBxF5gN9ZiyM+8BjUidmBkPh1KCLQ2xdHCPajCLr1IuIQn7JsU9iKdgBlkbzEzKZP4RUh1Rqh1UTnKmp/ZBeZTFhI/R+KL9kQkIJl3wR81byiRJgac9ze6H+oR5KWe90TtDTBJA/xgBPB+MUQdbWVazHmVvvjQ5Am44d6qrcam41LpsSTR5AR/KuW7lizVDYy9AZ10hXIFMEM2iJ01+dNCImUW1zeQv0DwSVN6s1vdIcL2whGKwhs2NfVwZRPW3OdL3bZsJ3UyZfnuGHpk/ASfEAzCg4D3ekVOOpCinHmHpQjfxvZ1ET1aI3JYXgNy310O0ZKyXcEfS5o3uY7XDeCzNeD1Q+xOhpi9ULm7lkR/8Dn+M8it+hxTNQdY6SBLoHlytwTTIUuT2EtbIhe3SGAub+dll02pIRYW/Fnt81p8OI8gkF9q39dvymGmgjMdpciNQ8SV0rjkvy86m5ftwJbbOs6JIHDSaJbwCkFERRRLvJ06+xnLxxzdsfx58cddCEjeyd4IIiA9AGrBeDhzqsvuX7bxHyOJq/C0mCHTVJCfjaLuL831oef0YDMH/D1DTs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(41320700013)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3dEb3o5eHh6MnNiRWsyeVIrQ0ZkZ2xiUmlkOXg4K3czYnJETTVvM1N3WUhz?=
 =?utf-8?B?bkJQek9kUW1GUW50TjI5MUpia21yQWhBeVlZbHVGSlhCbXlJQUY2TEFDTEp2?=
 =?utf-8?B?L2xxQzB4NU5GWlFMOEJoNDdNUGZvVDgvbklCZzF3bUZUVWNxUVJmb0o0Z0Vk?=
 =?utf-8?B?c2d1ZlIzczhCS3FHUGZPRjFxT2hBVlEwb0FCd3RRaDl4Q1NHdzFyMGthcThu?=
 =?utf-8?B?QytWUVByQlFZQlBtRlVNWGl2Z1NsWlQyUE1wdE80dS8xeXFNOU1tdkxzU1Qx?=
 =?utf-8?B?eFFHWFp5OGRNUmM5UldTaUJCcUMvd2wxdGpBb0g2RlVWRjIrTUFMNWRxYnpD?=
 =?utf-8?B?cTZnc3VZWm1tRVl2aU40aWtjeGpUNE5PdEs1NTJWMXpVK3JoK2ErNmtCWG02?=
 =?utf-8?B?Z2drN3hZMXRWYXJzTXNNcmpJTFRqODF3bXRUdUNyZ2RRemdmVU42djAvalE0?=
 =?utf-8?B?a2tyVDIxNXNhNUZldXZrMmc4YTNpcVBOa09YNW16azFwbkJOREhjbzV0MU0z?=
 =?utf-8?B?YXZrcml3amVNUEpEMmYxZFJKQXhaTklZTmpMdklyaEtwSFFtWk1odmtIY0V4?=
 =?utf-8?B?L0pVU3oxb2cvVFNLT0t1Z2RyQmJNODQxRC9sVThmMDE0Wkl1QkpwajMrRmpC?=
 =?utf-8?B?NUEzU0tSRG1qMGFQUEpXMklqa3luQWp0eHprV290bXk2S3gxdXN5dWJldzlJ?=
 =?utf-8?B?aXNaUStCdmZJbldYbE9EVm9nME9rODY5VVd3RDRwV3c3d3F0SVhGT1h0NTcz?=
 =?utf-8?B?eEt5NUZ0b3lKVVZ6OXFLelpWMHVPc0V0Qmh2TFJ6Y0ZiT3NGemx4ZktMRUg3?=
 =?utf-8?B?UU5UWXp4WHVSS3VILzg3bjJ1cFA4WjZhNXlCR1JSOXhpaUcraHNjY1JMbXBw?=
 =?utf-8?B?dDFqMVd2dEFnOHdNMTJKTzd6Y21uWWtVZmZOZGtIK2gyMnA1bEpJVVQvekdh?=
 =?utf-8?B?Ti83WnY5OEZlNU1VdDRid3hpSk15OFlvZW5EQmpPOHg5Q09LZkhoc3RYdUo5?=
 =?utf-8?B?NlV3eER4cThYNXdnUGZ0TG41VUVvei9YU25KRkRoYklOeGp3b25oZTBhUnBH?=
 =?utf-8?B?cW1ERG5vRlZKVXI0MUw4ZG1acDFnb1ErR1lmSkRyeS9KM0IwZ1grNVZLWTIz?=
 =?utf-8?B?MklmUmZzcDRoSVZqc0NBTXJEMEY1eEU5am5PZVRTWklnN0dKRnBkQTk0dXox?=
 =?utf-8?B?WDVhU2pxSEN1eDNjZ2NFVFhuMWpXaXNMeVJlSEFwOEJFajh2bllGQzRSc1Vq?=
 =?utf-8?B?aGFVNmRCWjJDM21qTFpRTnNLcS82cEVSWVVkSDRxMmxQbno1aWJmUWl5emJF?=
 =?utf-8?B?dE9Zb1d3eEhQN3JtcTcrUmpPdXhBWDR2WnRYdUxPeG5jY0tGcS9YSXd4NTl6?=
 =?utf-8?B?cXpmQXFkTXVOMitLS3JkVUZGRWtRcmpHNll0aHVlQnBUejU3YlJKMytPUU16?=
 =?utf-8?B?Y3Z4R0drTmJtVEgwN3dMc0Zma2ErU01JWDJJbDBoLzNsNXl3cXdSYjFCa3RS?=
 =?utf-8?B?ODFFMStMVkw5VVpGMG1HMFJuSGZWcklTQ2hOYlR2ZE5vQjltMUdxc3FCUjNG?=
 =?utf-8?B?OEVrYitMZTFDL2RURVRaRm1OeFVsS1JoTDdpNUs5V1p4WXRpWC9zTkN0aWVq?=
 =?utf-8?B?SW5oMkF2UCtaY0piT2pyT09paFNsYjVmOFVsNzJPKzRnTVEvSjRhbDJUV3ZZ?=
 =?utf-8?B?MUJET1oxblR3NXE1a2hhd082SldHeG5kaW1DUC9wQy9BOUJrOUNNRGV5eHFM?=
 =?utf-8?B?bjRza0ZmcnBMMDV3bm5QMjVtMW1JYU11bHIwVkU4K3hXWnBVTHlyS3NsSEo3?=
 =?utf-8?B?RDZ5S2lBTkFoYVJIRTVoaURRZDB6VVlkQmMzaExRU3Q2clVrTFpOVUJMelhx?=
 =?utf-8?B?bUpXK2Uya3RBZlBScUlHZ1VsV0taVVNkT1F1bTM3OS96S3hxbjMyb2tUbkhI?=
 =?utf-8?B?WkRRSFQzcDN0NVc1M3N0R2xCbkNUWUNORlphcFhYL0loNXJwNFN1WlVjSFlL?=
 =?utf-8?B?eEREVXFNMDFZRWlSY1FtRHdzMTEyTHlXeVRrekxvUGZyOGhEUDB2dUVYUW9o?=
 =?utf-8?B?VDBONUpaVk1yN0RhMTJCdlFOUmRPK1lIOEJ0U0hoeXVqN3Q0dkpNbGd5THZV?=
 =?utf-8?Q?ODs9EZxGsKxPSJHfeMIlIfRLw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 755641ad-d287-48ca-037d-08de113a52d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 07:12:12.8766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwJoleKRBKIfr03N0qP3R84awsYzTAi0FOZ166tmQKTUIxLMdVSJlnF3lPnCJAdXQo53ogtmzqufWK7zlrwZhkXd3wcCw6PzGMsh5XjR3+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1177
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

PiBPbiAwMy4wOS4yNSAwODoxNSwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiA4LzI4LzI1IDIzOjA5
LCBIYWwgRmVuZyB3cm90ZToNCj4gPiBTbyB0aGUgVmlzaW9uRml2ZSAyIExpdGUgRFQgd2lsbCBi
ZSBidWlsdCBhbmQgbWVyZ2VkIGludG8gRklULg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFs
IEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGNvbmZpZ3Mv
c3RhcmZpdmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9j
b25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2RlZmNvbmZpZw0KPiA+IGIvY29uZmlncy9zdGFy
Zml2ZV92aXNpb25maXZlMl9kZWZjb25maWcNCj4gPiBpbmRleCA1NDQxNDBjMDNmNy4uNWEwZTkx
OGM3MzMgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZj
b25maWcNCj4gPiArKysgYi9jb25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2RlZmNvbmZpZw0K
PiA+IEBAIC03OCw3ICs3OCw3IEBAIENPTkZJR19DTURfV0RUPXkNCj4gPiAgQ09ORklHX0NNRF9X
R0VUPXkNCj4gPiAgQ09ORklHX0NNRF9CT09UU1RBR0U9eQ0KPiA+ICBDT05GSUdfT0ZfQk9BUkQ9
eQ0KPiA+IC1DT05GSUdfT0ZfTElTVD0ic3RhcmZpdmUvamg3MTEwLWRlZXBjb21wdXRpbmctZm1s
MTN2MDEgc3RhcmZpdmUvamg3MTEwLQ0KPiBtaWxrdi1tYXJzIHN0YXJmaXZlL2poNzExMC1waW5l
NjQtc3RhcjY0IHN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItDQo+IHYxLjJh
IHN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiDQo+ID4gK0NPTkZJ
R19PRl9MSVNUPSJzdGFyZml2ZS9qaDcxMTAtZGVlcGNvbXB1dGluZy1mbWwxM3YwMQ0KPiBzdGFy
Zml2ZS9qaDcxMTAtbWlsa3YtbWFycyBzdGFyZml2ZS9qaDcxMTAtcGluZTY0LXN0YXI2NCBzdGFy
Zml2ZS9qaDcxMTAtDQo+IHN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4yYSBzdGFyZml2ZS9qaDcx
MTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNiDQo+IHN0YXJmaXZlL2poNzExMHMtc3RhcmZp
dmUtdmlzaW9uZml2ZS0yLWxpdGUiDQo+ID4gIENPTkZJR19NVUxUSV9EVEJfRklUPXkNCj4gPiAg
Q09ORklHX0VOVl9PVkVSV1JJVEU9eQ0KPiA+ICBDT05GSUdfRU5WX0lTX0lOX1NQSV9GTEFTSD15
DQo+IA0KPiBPa2F5LiBXaGlsZSB3ZSBhcmUgYWRkaW5nIGEgdGFyZ2V0IHdpdGggYSBkaWZmZXJl
bnQgKHlldCBzaW1pbGFyKSBDUFUgSkg3MTEwUywgSQ0KPiBoYXZlIHF1ZXN0aW9ucyBhYm91dCBp
ZiB3ZSBjYW4gYWxzbyBtYWtlIEpINzEwMCBhIHZhcmlhbnQgaGVyZSB0b28uIEhvdw0KDQpOby4g
VGhlIHBlcmlwaGVyYWxzIG9mIEpINzExMFMgYXJlIHRoZSBzYW1lIGFzIHRob3NlIG9mIEpINzEx
MCwgYnV0IGFyZSBxdWl0ZQ0KZGlmZmVyZW50IGZyb20gdGhvc2Ugb2YgSkg3MTAwLiBKSDcxMDAg
Y2FuIG5vdCB1c2UgdGhlIEpINzExMCBkZXZpY2UgdHJlZS4NCg0KPiBtdWNoIGRpZmZlcmVuY2Ug
aXMgYWxsb3dlZCBmb3Igb25lIFUtQm9vdCBib2FyZCB0YXJnZXQ/DQo+IA0KPiBJdCB3b3VsZCBi
ZSBncmVhdCB0byBoYXZlIGEgc2luZ2xlIFUtQm9vdCB0YXJnZXQgc3RhcmZpdmVfamg3MXh4X2Rl
ZmNvbmZpZyBmb3INCj4gZXhhbXBsZS4gSSBhbSBhd2FyZSB0aGF0IG1haW5saW5lIExpbnV4IGtl
cm5lbCBkZWZjb25maWcgY2FuIGJvb3Qgb24gSkg3MTAwDQo+IGJ1dCBzb21lIHBlcmlwaGVyYWwg
ZHJpdmVycyBkbyBub3Qgd29yayBjb3JyZWN0bHksIGFuZCBzbyB0aGVyZSBpcyBhDQo+IHJlcXVp
cmVtZW50IHRvIGNvbXBpbGUgTGludXgga2VybmVsIGFzIG5vbi1wb3J0YWJsZSBbMV0uIEhvd2V2
ZXIgSSB3YW50IHRvDQo+IGtub3cgd2hhdCBwcmV2ZW50cyBVLUJvb3QgZnJvbSBzdXBwb3J0aW5n
IGFsbCBvZiBKSDcxMDAsIEpINzExMCwgSkg3MTEwUywNCj4gd2l0aCB0aGUgc2FtZSBidWlsZCB0
YXJnZXQ/DQo+IA0KPiAxOiBodHRwczovL3dpa2kuZGViaWFuLm9yZy9JbnN0YWxsaW5nRGViaWFu
T24vU3RhckZpdmUvVmlzaW9uRml2ZVYxDQo+IA0KPiBBbnl3YXlzLCB0aGlzIGNoYW5nZSB0byBD
T05GSUdfT0ZfTElTVCBpcyBzb3J0ZWQgY29ycmVjdGx5IGFuZCBsb29rcyBnb29kIHRvDQo+IG1l
Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IEUgU2hhdHRvdyA8ZUBmcmVlc2hlbGwuZGU+DQo=
