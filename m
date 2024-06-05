Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B56C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 12:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0BF88286;
	Wed,  5 Jun 2024 14:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23BD788096; Wed,  5 Jun 2024 03:56:22 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20712.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::712])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8552F88250
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 03:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjvdIXDg63JAw78T+ERUX0NeMFu7iR3Pf8zAPDBf58g2sXY20P9JXk25ggS7qVxemu9oXApTqJr5fzf3QGJTs77aYhNrhD8PDpMqMjY5L9jQ29wjhtm821fbmfB8qiNTVuOXN8N74IghUcLipHjhroaNWplqzManUhLKbg2nNKa9Y483fP2pL8D5Fz3A7J6forIm72BPHpjLXq9ZcGXNRprhv9WWGawbmj8opC2F/MOz3hW8NJbqNKwiHjMdbqReS0iPqYE+01WOqm5eL6wY0/JTPw6PssL/CNxPKW5KJnGhjy97xncYvmCXTmbWObiSzn65We88TRD9pU2BEKb2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+Z561rfK2l0cQF/wgaTuGSmawT6K/z7Ue57vE/jjFI=;
 b=BZEwI57UmZ6vTKwJFGsN2v2Cky/GVpOnz/BmUeCJXYvFrBut/RW0Z0lzfdpuyBRzM+LmMac7jjnjRhuBDvRj24yt8UraP4Kv9t89yMPATRe/HHtShyxDRRjuCgavB+RN6wOYrYJgodmSlVFfQtY1lbKxPPoXoqh2ZoDWFOp+3Kk3SVc9gikAwUVu0XcKjHInzRE1vhzZV8HjRNijeozYejl0X81NCAmzEZqvJoJjWao4tz3PcRb2zyR/4yzy3zQeBW3mEaWDEIP74q4j/YWbN7jpvHB42x4bqX2GY3GKRdOEWL+FNyF8FDrwR/dqXMFo82MB9gMp0NMo2Orc1+lJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1291.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Wed, 5 Jun
 2024 01:56:13 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Wed, 5 Jun 2024 01:56:13 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Rick Chen
 <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Thread-Topic: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Thread-Index: AQHatbnIbiLxXnmCIEekLm54C2xuSbG2froAgAHmwtA=
Date: Wed, 5 Jun 2024 01:56:13 +0000
Message-ID: <ZQ2PR01MB13070E142612139A6D955820E6F92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
 <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
In-Reply-To: <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1291:EE_
x-ms-office365-filtering-correlation-id: a028555d-2c82-425e-9452-08dc8502adf9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|41320700004|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: mQcjQTH1rz1d1kqjMqwwqR5LNWHjD9BwY3lB2rJGuig1NdWYOP6h39e6jQmx3Kmr6BQBOhsXKpkAn4Q6tWNSZCPwTI/EBjSlqQWnPokNqAdZz0HjJ6YWgqgKBQqPZ8U6z9XwC1miPLBDr5yqVVgHvu1TuKrSmUR6ZT3/YrS5KOCf2WfK2S6d1gGdNZj4cNp84osA+tUs9ameaqKDZFq3QozMhcwmqAvGzpjTzjdpSkZP9mARMQWz2WsfU/j5xDZhOVqSr95N/qeRQu/5HxrtxkjECoxzhVT5rePPXQbNR+a+IqRC3vv1Pdpd0A/aVGY8OSDJQran833pvvfi+urcB7CfC683nvf/xPUM1QxKz9VwJh+6t567l+mDRN2O/2bB12qnazU/l8lpM718fK5fQxaNvH/136juWZ4hpUomPcW3hwLqUD6eqM6+bVxCVKAUt7nPK5sRie7KEvtzJwan2HYa6Lwm5rRpcYku+5HddyDo9cQb3PvypTXdsLMeDaA009lqkI6nm4KUsxoygBmTsqiS37Uzc/wcgt9SHZrm+R1CNB6C2gGwpRnjhMqarerJY4ek+EkRMTEFiRpBswFo8n4Q0a2bdZerSK8Hpi2Enj/uGpGW1sSpLFgI0D/tFf8f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(41320700004)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1udTRnLzAzWGxIMldmWWhDZlY4N1l0K1FzdHB0Q2xYOGFGQ0NuZ0t3UHBX?=
 =?utf-8?B?TDFVOWduczBQVkpzWFphNmIrVUlocUh6NE45RGc1SzJFVUYyR1pCZ3Vpak9i?=
 =?utf-8?B?SDlGaHdXWDNlSlRQY3Rpb0JBVEYxalgwZ1U5OVdrMGhaelB3bTNvQWZBOFhD?=
 =?utf-8?B?RnhET0FmVWFUVWNTRUV6VTcrZElLcTd4VGJBZEcxalIyVXp6cS9Id0MvNWV4?=
 =?utf-8?B?K0tMeTdVUlZKQnBXbWtSTnZGRFdibmdUeXF3Wnd1REpsYmpyUG81WG1mYVRz?=
 =?utf-8?B?eitYTldLeHZLb1BOZjRqMTNlaDBIQ3NxYzNiZlNDWDBBSkZydDlldVB1bmY4?=
 =?utf-8?B?Y3FWUEN4MXFKSTQyUjFYbkVhYmtCenZTZEsrUlVhUU1hT2krQ2ZwaGxXZUph?=
 =?utf-8?B?S3lqenZudnNKS3hmdWczU1dkUm9qUkN3b3FJN05PUnZVaEY0bnVHQy80cnZK?=
 =?utf-8?B?NHlQUHZPdk9zL1RqYndTczR3TTdpZXRtVE95QWJGTTduNmxmNWJnRTcvOHNL?=
 =?utf-8?B?NFJxaVdUVlR4QXZSWERBRjdaeTRMUkZLSEFtdmxhOTJINkRBalRBc0FyWStj?=
 =?utf-8?B?UU1UVllkMGltekVTTHFPS21WM051TkpwaEFjSDFEZWRTeWtIMVdRU3pyRndj?=
 =?utf-8?B?a3F4UHhmcGJ5REplWCswa1didTRTeHllL0ZGL1R6TU5EaEt2QW55Mi92cEEw?=
 =?utf-8?B?ZmNsdXRnMno5dXp0NWRFZnhIdFFMOXpOZm0xUVNhREtNV0xob09lLy9yRmsz?=
 =?utf-8?B?cmY3Z2VZenE3eitCTzRjLzNMeE9zMTVYVGhzRUhMaFFqOExkVkxMdFN2N1Jv?=
 =?utf-8?B?VE8xM2NaZWJUQWtXV0xUalc3S1ZXcUFKVXZJV0NHUG9rTHhXTFBJc2w3ajJB?=
 =?utf-8?B?OXY3Q0VwVllyZEpZOVBWTUdNN3FoZWxuS0d5VWNlNGJXcko4S2JVREkxR21Q?=
 =?utf-8?B?UkQ4Y1hqZjlRNHgyUUNNU01JbGt3eitlVUZ4Q0Z0UDlGdGdML3BPc0U4cXd4?=
 =?utf-8?B?Y0VhakxxVHEvQmFDeVlkQ01hNUM5R0hjNk5RSXdmdEJ3RGhmM1l3aUVBSHhq?=
 =?utf-8?B?UUFlckYxWGlYUUNRT0g1dEtEeEhuRWloYyt0N2Uvb3RoS1ZEYk96bmRJWFZz?=
 =?utf-8?B?TzlQUVJuN3ZGUnNoOFFZdEVTWU96L3VHMjZYbkNWZ2xVU09xa296K1ZQL1Y2?=
 =?utf-8?B?QmNQdU45bjNoNmFOc1pXOEkxNWpFRkd3c2FjNXlTNmxHL09uTnZyUjhhUWdN?=
 =?utf-8?B?U3VGWVRMZTZwTVZBbkYwNGJWeDYyY3hUQjVsR2ZjTUdTQi9HRCtJTnhhYW9L?=
 =?utf-8?B?MDVSTXdZbVl6cVdzYjU5VnZEaDJnN09PSXE4bm80OGRyZ2toQmo3YXNwdXRU?=
 =?utf-8?B?UVRXbVM2NWg4RGVLYWJxL211bDg2elVzZ2RiOUNUUENhYm5HVm1abFk1cFFH?=
 =?utf-8?B?Ynl3bmRsemhvdEV4TWFDSkFEWm5JeEorS0w4bE51b09nQ1VpcjdyV1kxVEV3?=
 =?utf-8?B?MEMvS0x3SEFva0drRXN2S2NzM3V2aDFtR09pcWRBTXlXL1NNejUvalFEaGhJ?=
 =?utf-8?B?c0ZqR040UW1ROWl2ZEQyckdKNStyQXJsYWRzQ05jL2JIaWN4TFdJTkgzQUUx?=
 =?utf-8?B?TmJEdmtiaThIR29jb0oybEtJMjBoeUU5RWF3MFM4YmRrUjZWWE42OHBnQ2lC?=
 =?utf-8?B?WE4xeDhHcFAwdXNBbUJZVFhJSi9ITVd6VnpLbzdONlB2ZDJYSlYzditRM2lV?=
 =?utf-8?B?cEl1VnVxK0R5bFNoNlN6WWU1R2szN2Z2eUNxS01VWU5xOHBIY1lXSCtySERV?=
 =?utf-8?B?bVNKSXlaS3VpQTkyNmlnOEM5SjlUNDZTUGlHblpkL0xQWXpJWUVrN2lmQWgw?=
 =?utf-8?B?UkR5bnpHVnZXc1RZTWxiWU56b01vTW1CYTRIcnNlcHFleXNDNE9CSDFsSTkw?=
 =?utf-8?B?ZnJNUzF4Y3BGZXB1TmdoR0s1L3l1Q1cyMDQzUGptR3ZIOGlLOStKa3R2OThv?=
 =?utf-8?B?T25YbU9Oc3VWLzM5K1hVOFJlZi9NVTBwTzYzcEpURVQvM1hoT3FUdFlkZ1lQ?=
 =?utf-8?B?RWhBMk9ubVJ3azg2ZlJzcC9LVHFjTTFKZVllTEpkbkUxWUpsSW0rcjNEUGVx?=
 =?utf-8?Q?fQokEZWK7NdgAmxzql7X+DPVQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a028555d-2c82-425e-9452-08dc8502adf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 01:56:13.4430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ815YnFFxbj/ALAxzaBzeNonVRWTj6u5DJP3N7hxUquGqqBQmHNk4XMIVdoswJMEBzK18MUCF5Ozzbs37uppSecIHcxgnDEAIlpWSK+DLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1291
X-Mailman-Approved-At: Wed, 05 Jun 2024 14:35:38 +0200
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

PiBPbiAwNC4wNi4yNCAwNDozMiwgRSBTaGF0dG93IHdyb3RlOg0KPiBIaSBIYWwsDQo+IA0KPiBJ
bnN0ZWFkIG9mIG1hbnVhbCBkdC1iaW5kaW5ncyBzeW5jIGNhbiB3ZSBwbGVhc2UgYWRvcHQgT0Zf
VVBTVFJFQU0gZm9yDQo+IEpINzExMCA/DQoNClllYWgsIEkgd2lsbCB0cnkgdG8gZG8gaXQgcmVj
ZW50bHksIGFsdGhvdWdoIEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGUgVS1Cb290DQpkcml2ZXJz
IGFuZCBMaW51eCBkcml2ZXJzIGFyZSBjb21wYXRpYmxlIHNvIHRoYXQgdGhleSBjYW4gdXNlIHRo
ZSBzYW1lIERULg0KDQpCZXN0IHJlZ2FyZHMsDQpIYWwNCg0KPiANCj4gDQo+IE9uIE1vbiwgSnVu
IDMsIDIwMjQgYXQgNjo1N+KAr0FNIEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29t
PiB3cm90ZToNCj4gPg0KPiA+IFRoZXJlIGFyZSBkaWZmZXJlbmNlcyBpbiBjbG9jayAvIHJlc2V0
IGR0LWJpbmRpbmdzIGJldHdlZW4gVS1Cb290IGFuZA0KPiA+IExpbnV4LiBTeW5jIHRoZW0sIHNv
IGl0IGlzIGZlYXNpYmxlIHRvIHVzZSBPRl9VUFNUUkVBTSBmb3IgU3RhckZpdmUNCj4gPiBKSDcx
MTAgU29DLg0KPiA+DQo+ID4gSGFsIEZlbmcgKDQpOg0KPiA+ICAgZHQtYmluZGluZ3M6IGNsb2Nr
OiBqaDcxMTA6IFN5bmMgd2l0aCBMaW51eA0KPiA+ICAgZHQtYmluZGluZ3M6IHJlc2V0OiBqaDcx
MTA6IFN5bmMgd2l0aCBMaW51eA0KPiA+ICAgY2xrOiBzdGFyZml2ZTogamg3MTEwOiBTeW5jIGNs
b2NrIGRlZmluaXRpb25zIHdpdGggTGludXgNCj4gPiAgIHJpc2N2OiBkdHM6IGpoNzExMDogU3lu
YyBjbG9jayBhbmQgcmVzZXQgZGVmaW5pdGlvbnMgd2l0aCBMaW51eA0KPiA+DQo+ID4gIC4uLi9k
dHMvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICB8ICAgNiArLQ0KPiA+ICBh
cmNoL3Jpc2N2L2R0cy9qaDcxMTAtdS1ib290LmR0c2kgICAgICAgICAgICAgfCAgIDIgKy0NCj4g
PiAgYXJjaC9yaXNjdi9kdHMvamg3MTEwLmR0c2kgICAgICAgICAgICAgICAgICAgIHwgIDI4ICst
LQ0KPiA+ICBkcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstamg3MTEwLXBsbC5jICAgICAgICAgfCAg
IDYgKy0NCj4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLWpoNzExMC5jICAgICAgICAgICAg
IHwgIDQ0ICsrLS0tDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9zdGFyZml2ZSxqaDcxMTAt
Y3JnLmggICB8IDE4MCArKysrKysrKysrKy0tLS0tLS0NCj4gPiAgLi4uL2R0LWJpbmRpbmdzL3Jl
c2V0L3N0YXJmaXZlLGpoNzExMC1jcmcuaCAgIHwgMTQ0ICsrKysrKysrLS0tLS0tDQo+ID4gIDcg
ZmlsZXMgY2hhbmdlZCwgMjQzIGluc2VydGlvbnMoKyksIDE2NyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+DQo+ID4gYmFzZS1jb21taXQ6IGVhNzIyYWE1ZWIzMzc0MGFlNzdlODgxNmFlYjcyYjM4NWU2
MjFjZDANCj4gPiAtLQ0KPiA+IDIuNDMuMg0KPiA+DQo=
