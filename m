Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DF5CCF9EC
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CC583881;
	Mon, 27 Oct 2025 14:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB1F80422; Mon, 27 Oct 2025 09:15:05 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633DD800B6
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 09:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJf7uLZ+qzdT4b/cHS18Fcb7GrX31gxZQbxA2AMpgiazB25ZVuKSBTgOlqdCn6ZcdYPCuLZVp8KmiVTlf0/6+61B1x1xmxEVNpTzYbOEE9/laWZkQ77oVeTO7pkCghlj+6jerokbZ8RA57PYyNWa5sUNwOONVQXDCva6NTnZ63iMdl/z6JOJCTYQq9k0MPFpjtPYHVhf3ZLxg61VdVgEUB/HtF8hIKpDGghPA/qAjVCaynpp692ZMTa482Qtsa2HtgrVsUlPsIxckxGFak2hOJ03un0eVl45LsXjqWZoowC6m00MAusybd6NwgnnFubhoJ0gzFJ+64x3jMS8duk0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmOQwiiNmEVQL/rSkS/4jvf8YYBL6aXgiAogDJmyeDU=;
 b=XSlq8SwpbHfyjEzR/AqDj+kg81Eg+YcJ85ZFOQyap8YX2v/Hn4d5Yc2BWImkh20zoQRZ6IMrn40bbAxM9P3wrkzhB3tPjC2+oZT6x8kl8VCaZs4RFuYVX8HDC2wHc4B3ar0F4BDNItHU49KFnXWD9yvBKi/4VXs3vmrtJiy0cQS/vkQ3Sy+cpzlPsPCvdg4+dPRQSI87uLr9wpstdEeu9XDNgr21QxoZxJ6KXqPTYn6z/9OA0tgzCAxgKCZOI/IlcNs73/qT7hwlPt0hV5Vh+6XDNkJ1i23SA+vgvzTaJHQFMkoKZi5UoWw8WQXU3VTHt/JacSi0ZO82mQ6oHhhrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.19; Mon, 27 Oct
 2025 08:14:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Mon, 27 Oct 2025
 08:14:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Topic: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Index: AQHcRMSITAF/Ez7TCUSKxA/KpCGn6bTRIJ0AgARk6SA=
Date: Mon, 27 Oct 2025 08:14:55 +0000
Message-ID: <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
 <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
In-Reply-To: <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
x-ms-office365-filtering-correlation-id: 98b2eea9-334d-4ed7-174b-08de1530e97d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|38070700021; 
x-microsoft-antispam-message-info: dr+xP6EkGScUSt0rmAW6THTZozdOd2t+oHH8Y+ET127L3I+v7CaTnycOqvmN/DZyKRNad5MiN7lD7yEWARL3vtLSYi9cv+jAf0uzlDkF4YrxNLr2s2+299zg9IpaaFUPohZhktDqSvfEwq/OMBC/zODisNVkIQPEJ8GzQ8hzIzX3SKMYPy588UnAXRc4INDdFRYtesz8J1JW+D+Et1WuPNj/mlOKOvyjedCFK81w2vTZp4aVQRC05LhfqQxZkXphiM+RH5gK/+FBqqqnmAu5GBjM6dC+RYn8aKqXK/eMdMq+txMt6crV4ZvlpczkxkFP21xzv8+Isxp3PMDpDyRUQ33mmrypVhSRAyo81d5CmTEGdCf0l9hIKTzpObE5BaWqEZLQRuTFRurpXl5wVBd+5OqN0PDNRwAhFPefxhKWttAZoKsmYGTE2KgJfZaM/A8tuzdrLnQkQ1EZuEFAiJilgofi3PZVskr864G/tZM+UTdFwBUw/bZtQOk2N8X/C4Ld/M3rwB6+H3ueyQaW+Uw3h2tGje1UFZJN8MBKWn//AbgfxEByD02JkriVl10LNXBsdE7pnAWvG3/Gjya2yn5nIfFPsip1I3ele1HqfV3EOXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(41320700013)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZadFU5KzI0SXdhUEo5MUI4OHh1TDM1VWp3anlKSXJma2YwRldGQXdZS2Nl?=
 =?utf-8?B?NDZvd2FnOWVpNWVOVVBnZk95N3ZyUlhVT2hOY0NXT1pjSWJqYURLUjRSamRR?=
 =?utf-8?B?R2cyNWt0eEpQUlMwc2xxOHlrUUJlSkh3YWFTRmRqN0NyOTdlUWFxOXRTVEtW?=
 =?utf-8?B?UFdqeWRIaG9uV1huWitibXI2TTNRZWFtYXpIRXB6ZWQxOXpWeXQ4MmpVMGZh?=
 =?utf-8?B?RVhFd3ZmaW5FNEpHeU9CekZtVlNsVGNFTWtNVGI4eWRSLzFtS1BSbFV6c2ZU?=
 =?utf-8?B?Y1oyTER3eFh0c0hGei9mczcxTUI5OGtUSWRESGNKek5KVHhqQnk5MS9sRzN2?=
 =?utf-8?B?eVkwSHVRd2pTUWN0YzNJbkxMc2VZNC83Uk8yYVdxTml1elc2M3NvaU5WdlVN?=
 =?utf-8?B?WjBYY0hBUmlmYUUxdXpPYTEraVdTcGs0MUg3ZTEyQklYc2RVaDFTUkhhQVNh?=
 =?utf-8?B?L3VqdGoxRWFjSC9ZOFdFUWFnVDByYy9keURYZm42amZnVDlDS1hKMTVMaVNv?=
 =?utf-8?B?Y05pWC9VcGM3V1FvU3poSDhNcDl5alN3b2xkRktCZlpYcDRNMGpNTGYzaUt1?=
 =?utf-8?B?dXdLT0hlRUdacE1FYTFCazhTeStuc20rZ0Q3ZlcxcGtaMEJLQVMzZDRPdzB4?=
 =?utf-8?B?NW50dWJtSlJyTTFvdjNrVkt1Q1JnTW9ZekdCZlJUWFJvTElZaGhHeG9lbWRq?=
 =?utf-8?B?SjdodFRlQngvTUNDRmpYdEYrQ1dqK0RQMTVJSWtZdjZYeWJXQ0llMnJlT3Fw?=
 =?utf-8?B?OU1jYnVib2hOQW5tMHk2Z2VwL01BbWdwRVNUd3pManpHU3hITzBNTHByRkVO?=
 =?utf-8?B?cWhFdFVZb0tRTkZJWGFxOWo1MTRuV1RuRldNSGc0a3JJYzJrazVDMi9qRC8z?=
 =?utf-8?B?blZNUUQzSSt2blJ0RzE4bGh0b2JRVkYvd3F4cU9GRWhRZFhRMGxNYThYNXFO?=
 =?utf-8?B?TGpnUkk2NlRUNXdSNWYvNmdnYVM1L05pTGJSS1BYbWNzNUUxK211LzlOY2dG?=
 =?utf-8?B?QTEvZVdIckNLTGVIWUJjd2VPcXRhZ1ZiNTgvK1NlVjR0MzNsM3lLamNWcUF5?=
 =?utf-8?B?UG5WM0RJOHF0NWI2Rm9mcVhvTVBVaEt0RlVyTVFnQUxjQjArR2IydWkyQUdu?=
 =?utf-8?B?eGlTSXhYZWZHZi9GRnYvblRjZ2VOYkpPNGpyOUNDWVhzYW13K0w4ZUJrVHRX?=
 =?utf-8?B?UThhU0lMVStrQzhMOE1xR05zNHUxWUdlMzJCd1h1cU55Nldhc3o2bmFlbEhO?=
 =?utf-8?B?RGlWd1ZkK2dWU1pkeEJYS1N2OVJMWDlBejMzMTEyWGRSTjNleDlZZCtDQUVI?=
 =?utf-8?B?V2hsZmNacmI5aW8vY1NZL2s2MnBLbGhwMHZoR29HeEhyUGtlRHJGS2xNVGRo?=
 =?utf-8?B?T0daM0xQWkt3djFib1pHbmh3MGZzd2E1a0thQW1ZTW5jRDF6c1JSY0hDMzh6?=
 =?utf-8?B?cTlRL21KMDdUdGhuUkZMTW96UjFUR1c2Q0VCd0RocEFxM1JzZGlwWTJNWkxQ?=
 =?utf-8?B?d3BBcUVMd09YbzRqVXh6TDJNVDJJeDdiRGNROU5LWGM0dktIS011Smx0cWtN?=
 =?utf-8?B?VWo1T3hOUXVJRmFlc0s5NmZxR0VaWm9qMnBqUVpZL2dWM1hOb29sSXR3NEh4?=
 =?utf-8?B?cG1mSHlXMDBqRFdzeTJoVkRlUUhuajZ4VnVDOWJ4dnF3MHJVRVlTSGwrcFpJ?=
 =?utf-8?B?cUdtczBZWUVDZXYrSHJwQ3dQank5THlUcVVRaVNKMm0zK3pDS0NPTkpDclFk?=
 =?utf-8?B?blpsQWRGSHp2c3NGZGIwTkNLblZ6VDQvOEVjek9HVEpjcUpkTVFJVCtOdXZB?=
 =?utf-8?B?cHN1MVZjNXNtZFFkVmhZSlQ3alpYL1BEZTVseDl4M29kWDNubHBUL08zZEpx?=
 =?utf-8?B?QlhyWjVCdzR6QzN1NGM5OVFFU1VqVExVYnVxUlFLMnhHendkWXBDb3ZaNFNC?=
 =?utf-8?B?VFNLcThlU1BxdWZxVzBsejh6clQ3Sm8rTzlIMTErQ09wVFZybFRFSEdoSzZv?=
 =?utf-8?B?Rldwb2ZDbTlnNmpsM0Y1UFNKNVBMUjhsRUFHRWFGOXVza2JJNG91Z1BYOVVy?=
 =?utf-8?B?R2N3cXo2Z3B3LzVkTDVMdTRTaFRBbnVXSjhvUkNkNU9mTlg2c2FSTkNCckc5?=
 =?utf-8?Q?dRGZAb7jGjHOzJ1xf7q7gDHlz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b2eea9-334d-4ed7-174b-08de1530e97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:14:55.3007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ1raLRq08YGDFnAoG0YItvt5Bw7JD56U9idTkfoicz7r1go+n/s/RypJ7nPzjWQvVHOIn7m9uRROe2SzamAz4lq3D/wyI8isWVvwYqpA8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:02:31 +0100
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

PiBPbiAyNC4xMC4yNSAxODo1OCwgRSBTaGF0dG93IHdyb3RlOg0KPiBIaSBIYWwsIHRoaXMgaXMg
dmVyeSBnb29kLCBJIGhhdmUgc29tZSBzdWdnZXN0aW9uIHRvIGltcHJvdmUgbW9yZS4NCj4gDQo+
IE9uIDEwLzI0LzI1IDAxOjU5LCBIYWwgRmVuZyB3cm90ZToNCj4gPg0KPiAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCj4g
PiBUaGlzIHBhdGNoIHBpY2tlZCBmcm9tIFsxXSBpcyBqdXN0IGZvciB0ZXN0IGFuZCBjYW4gYmUg
aWdub3JlZC4NCj4gPiBkdHMvdXBzdHJlYW0gc2hvdWxkIGJlIHN5bmNlZCByZWd1bGFybHkgd2l0
aCBkZXZpY2V0cmVlLXJlYmFzaW5nLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUwODIxMTAwOTMwLjcxNDA0LTEtaGFsLmZlbmdAc3RhcmZpdmV0ZQ0K
PiA+IGNoLmNvbS8NCj4gPg0KPiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCj4gPg0KPiA+IFZpc2lvbkZpdmUgMiBMaXRl
IGlzIGEgbWluaSBTQkMgYmFzZWQgb24gdGhlIFN0YXJGaXZlIEpINzExMFMgU29DLg0KPiA+DQo+
ID4gQm9hcmQgZmVhdHVyZXM6DQo+ID4gLSBKSDcxMTBTIFNvQw0KPiA+IC0gMi80LzggR2lCIExQ
RERSNCBEUkFNDQo+ID4gLSBBWFAxNTA2MCBQTUlDDQo+ID4gLSA0MCBwaW4gR1BJTyBoZWFkZXIN
Cj4gPiAtIDF4IFVTQiAzLjAgaG9zdCBwb3J0DQo+ID4gLSAzeCBVU0IgMi4wIGhvc3QgcG9ydA0K
PiA+IC0gMXggTS4yIE0tS2V5IChzaXplOiAyMjQyKQ0KPiA+IC0gMXggTWljcm9TRCBzbG90IChv
cHRpb25hbCBub24tcmVtb3ZhYmxlIGVNTUMpDQo+ID4gLSAxeCBRU1BJIEZsYXNoDQo+ID4gLSAx
eCBJMkMgRUVQUk9NDQo+ID4gLSAxeCAxR2JwcyBFdGhlcm5ldCBwb3J0DQo+ID4gLSBTRElPLWJh
c2VkIFdpLUZpICYgVUFSVC1iYXNlZCBCbHVldG9vdGgNCj4gPiAtIDF4IEhETUkgcG9ydA0KPiA+
IC0gMXggMi1sYW5lIERTSQ0KPiA+IC0gMXggMi1sYW5lIENTSQ0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9qaDcxMTBzLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlLmR0cyAgICB8IDE1OSArKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1OSBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGR0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZp
dmUvamg3MTEwcy1zdGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS5kdHMNCj4gPg0KPiA+IGRpZmYg
LS1naXQNCj4gPiBhL2R0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZpdmUvamg3MTEwcy1zdGFy
Zml2ZS12aXNpb25maXZlLTItbGl0ZS5kDQo+ID4gdHMNCj4gPiBiL2R0cy91cHN0cmVhbS9zcmMv
cmlzY3Yvc3RhcmZpdmUvamg3MTEwcy1zdGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS5kDQo+ID4g
dHMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwLi4zMDg0
MmIwY2QxZg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kdHMvdXBzdHJlYW0vc3JjL3Jp
c2N2L3N0YXJmaXZlL2poNzExMHMtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLWxpDQo+ID4gKysrIHRl
LmR0cw0KPiA+IEBAIC0wLDAgKzEsMTU5IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wIE9SIE1JVA0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjUg
U3RhckZpdmUgVGVjaG5vbG9neSBDby4sIEx0ZC4NCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1
IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPiAgKi8NCj4gPiArDQo+ID4gKy9k
dHMtdjEvOw0KPiA+ICsjaW5jbHVkZSAiamg3MTEwLWNvbW1vbi5kdHNpIg0KPiA+ICsNCj4gPiAr
LyB7DQo+ID4gKwltb2RlbCA9ICJTdGFyRml2ZSBWaXNpb25GaXZlIDIgTGl0ZSI7DQo+ID4gKwlj
b21wYXRpYmxlID0gInN0YXJmaXZlLHZpc2lvbmZpdmUtMi1saXRlIiwgInN0YXJmaXZlLGpoNzEx
MHMiOyB9Ow0KPiAuLi4NCj4gDQo+IEZZSSBhcyBhIGZvbGxvdy11cCB0byBteSBlYXJsaWVyIGNv
bW1lbnRzIGFib3V0IG1vZGlmeWluZyB0aGUgZHRzIHN1YnRyZWUgSQ0KPiBoYXZlIG5vdyBhIHdv
cmtpbmcgcmVjb21tZW5kYXRpb246DQo+IA0KPiAxKS4gUmV0dXJuIHRvIHVzaW5nICJSRkMiIHN1
YmplY3QgcHJlZml4IGZvciB0aGUgc2VyaWVzIHdoaWxlIGFueSBtb2RpZmljYXRpb24NCj4gZXhp
c3RzIHRvIGR0cyBzdWJ0cmVlLiBUaGUgY29tbWVudCBzYWlkIGFib3V0IHRoaXMgaXMgZG8gbm90
IHBvc3QgYW55ICJETw0KPiBOT1QgTUVSR0UiIHR5cGUgcGF0Y2hlcyB0aGF0IHRvdWNoIGR0cyBz
dWJ0cmVlLCBob3dldmVyLi4uDQo+IA0KPiAyKS4gQWRkaXRpb25zIHRvIENPTkZJR19PRl9MSVNU
IHdpbGwgY2F1c2UgYSBidWlsZCBlcnJvciBpZiB0aGVyZSBpcyBub3QgYW55DQo+IGNvcnJlc3Bv
bmRpbmcgZmlsZSBpbiB0aGUgZHRzIHN1YnRyZWUuIFVzZSBhIHdvcmthcm91bmQ6DQo+IA0KPiBn
aXQgbXYNCj4gZHRzL3Vwc3RyZWFtL3NyYy9yaXNjdi9zdGFyZml2ZS9qaDcxMTBzLXN0YXJmaXZl
LXZpc2lvbmZpdmUtMi1saXRlLmR0cw0KPiBhcmNoL3Jpc2N2L2R0cy9qaDcxMTBzLXN0YXJmaXZl
LXZpc2lvbmZpdmUtMi1saXRlLXUtYm9vdC5kdHNpDQo+IHRvdWNoIGR0cy91cHN0cmVhbS9zcmMv
cmlzY3Yvc3RhcmZpdmUvamg3MTEwcy1zdGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS5kdHMNCj4g
Z2l0IGFkZA0KPiBkdHMvdXBzdHJlYW0vc3JjL3Jpc2N2L3N0YXJmaXZlL2poNzExMHMtc3RhcmZp
dmUtdmlzaW9uZml2ZS0yLWxpdGUuZHRzDQo+IGFyY2gvcmlzY3YvZHRzL2poNzExMHMtc3RhcmZp
dmUtdmlzaW9uZml2ZS0yLWxpdGUtdS1ib290LmR0c2kNCg0KVGhhbmsgeW91IGZvciBwcm92aWRp
bmcgYW5vdGhlciB3YXkgdG8gZGVhbCB3aXRoIHRoaXMgc2l0dWF0aW9uLg0KDQpXaXRoIHlvdXIg
bWV0aG9kLCANCjEuIFRoZSBzaXR1YXRpb24gd2lsbCBiZSBtb3JlIGNvbXBsaWNhdGVkIGluIHRo
aXMgcGF0Y2gsIGJlY2F1c2UgSSB0cnkgdG8gbW9kaWZ5IHRoZQ0KY29tbW9uIGR0c2kgKGpoNzEx
MC1jb21tb24uZHRzaSkuDQoyLiBUaGUgbWFpbnRhaW5lcnMgaGF2ZSB0byByZXZlcnQgdGhlIHRl
bXBvcmFyeSBkZXZpY2UgdHJlZXMgd2UgYWRkZWQgaW4gYXJjaC9yaXNjdi9kdHMvDQphZnRlciB0
aGUgc2FtZSBkZXZpY2UgdHJlZXMgYXBwZWFyIGluIGR0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3Rh
cmZpdmUvLiBJdCB3aWxsIGJyaW5nIG1vcmUNCndvcmsgdG8gdGhlIE9GX1VQU1RSRUFNIG1haW50
YWluZXJzLg0KDQpJIHRoaW5rIGl0IG1heSBiZSBlYXNpZXIgZm9yIG1haW50YWluZXJzIHRvIG1l
cmdlIHRoZSB1LWJvb3QgcGF0Y2hlcyBhZnRlciB0aGUNCkxpbnV4IGRldmljZSB0cmVlcyBoYXMg
YWxyZWFkeSBhcHBlYXJlZCBpbiBkdHMvdXBzdHJlYW0vLg0KDQo+IA0KPiBBbHRlcm5hdGl2ZWx5
IGZvciB5b3VyIGxvY2FsIGRldmVsb3BtZW50IGVudmlyb25tZW50Og0KPiANCj4gZWNobyAnI2lu
Y2x1ZGUNCj4gIi9wYXRoL3RvL2xpbnV4LmdpdC9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZl
L2poNzExMHMtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLQ0KPiBsaXRlLXUtYm9vdC5kdHNpIicNCg0K
TWF5YmUgeW91IG1lYW4gIi9wYXRoL3RvL2xpbnV4LmdpdC9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0
YXJmaXZlL2poNzExMHMtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLWxpdGUuZHRzIg0KDQo+ID4gYXJj
aC9yaXNjdi9kdHMvamg3MTEwcy1zdGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS11LWJvb3QuZHRz
aQ0KPiANCj4gVGhpcyAiLXUtYm9vdC5kdHNpIiBzdWZmaXggZmlsZSB3aWxsIGdldCBwaWNrZWQg
dXAgYnkgdGhlIGJ1aWxkIHN5c3RlbQ0KPiBhdXRvbWF0aWNhbGx5IHdoZW4gdGhlcmUgaXMgYSBj
b3JyZXNwb25kaW5nIGZpbGUgKGVtcHR5IGZpbGUgaXMgb2theSkgaW4gZHRzDQo+IHN1YnRyZWUu
IFRoZSBlbXB0eSBmaWxlIGluIGR0cyBzdWJ0cmVlIGlzIGEgc2ltcGxlIGdpdCBmaWxlIG9wZXJh
dGlvbiB3aXRoIG5vDQo+IGFjdHVhbCBjb250ZW50LiBJdCBpcyBub3QgcGVyZmVjdCBhcyBhbiBh
bnN3ZXIgYnV0IGl0IGlzIGJldHRlciBmb3IgdGhlIHJldmlldw0KPiBub3csIGFuZCBmb3IgYW55
b25lIGVsc2UgcmVhZGluZyB0aGlzIHRoYXQgbWF5IHdhbnQgdG8gZG8gdGhlIHNhbWUuDQo+IA0K
PiBZb3UgY2FuIHNlZSB0aGlzIGluIHRoZSB3b3JraW5nIGV4YW1wbGUgb2YgUkZDIHYxIHNlcmll
cyBmb3IgTWlsay1WIE1hcnMgQ00NCj4gcmUtaW50cm9kdWN0aW9uOg0KPiANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjUwOTI1MDUzMjMzLjE4NzQwMjctMS1lQGZyZWVzaGVs
bC5kZS8NCj4gDQo+IGFuZCB0aGUgZm9sbG93LXVwIGFzIHYyIHNlcmllcyBhcyB0aGlzIGxhbmRz
IGluIGRldmljZXRyZWUtcmViYXNpbmc6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy91
LWJvb3QvMjAyNTEwMjEyMzEwMjEuMTk2MzM2LTEtZUBmcmVlc2hlbGwuZGUvDQo+IA0KPiBJIGhv
cGUgdGhhdCBpcyBhIGdvb2QgZXhhbXBsZSB0byBmb2xsb3cgZm9yIHYzLCB2NCBvZiB5b3VyIHNl
cmllcw0KPiANCj4gMykuIElmIHlvdSBmb2xsb3cgUkZDIC0+IFBBVENIIC0+IFJGQyB0aGUgdmVy
c2lvbiBkb2VzIGluY3JlbWVudCAoUkZDIHYxLA0KPiBQQVRDSCB2MiwgUkZDIHYzLCAuLi4pDQoN
ClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9ucy4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
