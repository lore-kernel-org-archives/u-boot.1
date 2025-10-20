Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E79BCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 04:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936E883893;
	Mon, 20 Oct 2025 06:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CE182E34; Mon, 20 Oct 2025 05:41:23 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7356807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 05:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwDmOmpZb66VW2qceIlQ5MLvp2FC360oUjXlyRZdZbqG0FJ9tbEmqRV+oL5zC1p8EUv3Rv09PXO6CgTdYjWevsXBQFEtcTu4XfP5qwkEuileSgRQ5bsWli8bvCjueck9gmqeCw/3op+uIY3XUljQEXXwWTw1F2dM2Rvim0AYTqConJ5nh3y2/AbzGnG4+GNQofsDUuFn8ljTpKMWmsbWSpKBv8IS0pNxhJlf+UIkZR+sgpWandZPFXm2z5e7Y/1mS5oU3X4ClrYyCoajsJt/Z+R3O0D7bajE4U/gAEIhApoWD5smlhUz8ktlSp+QOkJ2qLhV/ZgIjgJxgIGxfpcGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4khz0R4DPgY53SGtc7IvDM6LfYX1Vju0/bx/pgMgF5E=;
 b=RpNAaHqDlYkxyBxveyJs3OxnwspxDaanzKWAiwEZTJjfYdZKPOYCHtYouzsC0T2qvdD2hV+EDISq7QELyZTVix0Vo4I8UAX9g/ngJZYEfjnghdsSCiDuOR/0UUK6S0D0PFEQzZqipSTnDo1pMzm17ZxUd6eCUoJNF0fQiDGRE+O1vuOtxLk5U9WzaCRObH3ObgzbgEGPPhgwffPz6tk9adlF5g1mZG2KrSFjodUSgam//3PNTSl5vE0FhkbEE81M0q5A94Ov5VAo2ttIcprB7Fn8ucBk4bGJ3LfLEL1wZx9xd+CVhDXnePh7aJzur0ENECKEOJk2XowDPYEEKsHncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1162.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 03:41:14 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 03:41:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Yao Zi
 <ziyao@disroot.org>, Minda Chen <minda.chen@starfivetech.com>
CC: Simon Glass <sjg@chromium.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Leo <ycliang@andestech.com>, Rick Chen
 <rick@andestech.com>, E Shattow <e@freeshell.de>
Subject: RE: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
Thread-Topic: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
Thread-Index: AQHcPzVo4a+6Mj7gwUmDqJgRURvjz7TKZupg
Date: Mon, 20 Oct 2025 03:41:14 +0000
Message-ID: <ZQ2PR01MB1307C9C9F97C13440B5BB4D3E6F52@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
 <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com> <aPGc12v2H5sCZNMi@pie>
 <1d44df95-a7fc-4217-9f22-788c70fe38bc@canonical.com>
In-Reply-To: <1d44df95-a7fc-4217-9f22-788c70fe38bc@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1162:EE_
x-ms-office365-filtering-correlation-id: d9de53be-150e-4690-ea69-08de0f8a8539
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700021; 
x-microsoft-antispam-message-info: RQuDN6ed8TtkENGQwcPy941q3EonyEsUMPfTFJ+/yMxhFOPw6ykpZ6suxUN98gN1+4KCLELZzto7eL31lpc31RzLkzwBYGOP/JOJWDD0tv2Vg5r+DF3jnevQpilyzveby4f6H9Yuo+mRupV7Haf9WWWzIA/acVI1cLi0HsEDdOlT8cN11cHbvogkFAOB6v5LMp/ph1a8lVWVN7GipZ56mtMu0ctHmFvE+N7Xha/s4QqpecOX1nZlFPDdfIHYB4n/mzIimjo5+BHn9Vf4IfdheZ9YIaAAVTA7qpE7z1zTEWXqFZwghC+95HbQXF7tfNvM/VnW+QYrU9TMxXOr5W71AnO6J6kbYD7o4bWUXoq5eSuNO/xV2rh0dh2NqYKNQvJL/kNMGghEIiSmak7NS39DhlzY3bAdkmXwk+rY+AaS7KNbQvtzeeWhLWYVOl6ScqCwZLwgrlxdkLDnWSCLOWO8vneEtauXRlKCeydp7imZE6LuvezvpdZspY1PfNtIWbaMt+IhIXnOulkX3rWevWs1lI/s8XZq0zwHuhPRPuhjmZiV/CkuT3sn8oiVPYZ0RAyXtgXbyWNJTiqz+VPLxSQ56gGQG/elCjLUYn6GqRxUuJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2ErazRBaktPb1diZlhBTWxJR1hkeVg3QWloYjcyWDNWaTFzRjh0SXE0Z2xy?=
 =?utf-8?B?L1NRdnNIQU5YY0tYTEJsNlJsY05KakF3dm44TnNLVjJqSVBHT2JvdkdSMnd5?=
 =?utf-8?B?VitlcXVBcmt2Z2tTZVVkZmRwaUJXWmZGNGxLS25UTEM1YVdRa2xNeHBlUm5E?=
 =?utf-8?B?ZnQ3SzA0WkN6c3RabE4wNUVWWXV0MDQ0b0wyUk9VaElIWlppMHcxanNjbUJ2?=
 =?utf-8?B?LzNvWExVdktxTHovUE9iVEtUeVNIcGFic2xUU3dMRlNnTlhKUmxoVnJRQ1NY?=
 =?utf-8?B?NFdkNU1KQnNvRDZjNEJXVXNKdTM4WUEvbUhXTnp4OHlzemlMTTZGODc0alp6?=
 =?utf-8?B?NFowbmNlamtSZmRvSGZTSUJxUG0yK0gwaHJ4T0tqZEhHSTEyZDlXZEt6QnRt?=
 =?utf-8?B?b3Niam5YTldOcTEvblVnOEVyUHYyNUV4NmRmUmtrMkUzbmlZZHByaVBTa1N1?=
 =?utf-8?B?eUxDcUtMMTNnRUhLM0h0Qk1CTEI5VU9QVlV0SkR0NDZWajBTSU9nd0ZmMnFE?=
 =?utf-8?B?V3hIUG1QajJhblVTR05DNndueGdkMjdueVpsRktQM3JZNEpzemhLcFZKb0E3?=
 =?utf-8?B?alVOWmp3REthM1lRS0xhcE9qRkpRaWt3bDE1dlY1K01hSktjVkN0SGZCTzVB?=
 =?utf-8?B?QkdHWExUUWxmMXNtU3d0d1o4TzZvUWNyOHE1YmIzQk1MQmNWdFY2Y1ByT3NS?=
 =?utf-8?B?b3JLRWEvQk1WYzJDTkkyTGszOG5YQ1VBS2JsVVZKbmpnTnJWK3ExYnVhOWZx?=
 =?utf-8?B?clVNZkxPd0xTM3pEZjJLZWNqbEduUzdEQ1YraUxUMHpINVoyVVNmcGxhRFYy?=
 =?utf-8?B?bklxQnJWdEtWSU5Ud1NhQXRabWtnZWlXTUVVTytDc2w1dWdkNkh2d3ppRDYy?=
 =?utf-8?B?amlxeTFFTkx6a2pucmtJbWdXcTMzN0NKQWpJVXdsWTN1MmEyMzMrV054Nlkz?=
 =?utf-8?B?blZJZ05GNnNsejNHVDRENE5vMWxDWnE1Sm51bWVwSUxRakJaaWlSdnRTU2hr?=
 =?utf-8?B?eUc1VnAxUThkV291TFRSN01vdDJiVFBEVGJFM3k4S0Vta25VbjZTVVkxWjRE?=
 =?utf-8?B?WXYwbnBIN0wyeEUrdFJ0azVEbXVRRFd4TmdQZDNLWW1XUVoxRHg1THhmYjFD?=
 =?utf-8?B?cEl1em05UU00enBXakp5Mlk2WmhLRUxtUkdkMFdGRmc4V1NTc0cwK1JzWTc2?=
 =?utf-8?B?dzhMeXY1YzcxYmsxQm5pbTVLSGZyTlRlb2pYUVpUOElISkhST1Y4ZTJVem9Y?=
 =?utf-8?B?d3AyQTNTR3F0RWovbWhrT0NWK29RRVRIdzVOVlBhamJ4Y21DaFVld3g5VlRD?=
 =?utf-8?B?ZXJWeStCYmszcDhSWXk4Z01HY0RRRE1mVGlibHBZNjZJZjlWZjJlNlpZcDhG?=
 =?utf-8?B?bmhiTHpwaDJadDloeExPWTlpQU9nRXBYRFZqUzM0QUJzT1RQRXJmYk11WHFv?=
 =?utf-8?B?NFd3a0xXT210eGpQWjRTOVU3ei9XYWFRakhrRE0zK3dYNlpMa3A0TnYrRUpW?=
 =?utf-8?B?RWtzRmhCY0wydTBIaUtPaTc4d1MxSWdVU1VsR1BqYVdPV1BBOC9sT1FXVDhl?=
 =?utf-8?B?b1BIZlQwWW5pZTlKUmFRWTk0UHdBSEMxQWhiOXlxVDB3dTZOVlZZRHFLaGF1?=
 =?utf-8?B?SEVSQmFCd09vd1NyK1ZVNkIvalp4TGtPYm5mb2xubVA5Q3o2ZUpPeHNoTEFT?=
 =?utf-8?B?dUhXMzViVzhrNVdteU1BKzRpc0JEQjJIbGtpLzYzQlNMNTJGei9MWVBhWTNN?=
 =?utf-8?B?V3RnVitwTnpCUnpOMklIMmNweEUwUlM4Y05sRGpRVzFBdU1mK05kNXRvQTJh?=
 =?utf-8?B?WWNQOVBpNXM5Q1FDQjF5RThBN3lpR3JHNkxMMjFLK2Y1T2NJOHAzZ2FjQWlP?=
 =?utf-8?B?Rk1rRk11SWJmblJUQXBNMEhvZVcyYktQdUhtdFI2YWxFRHhYRXlCRWJ3ZFhH?=
 =?utf-8?B?VnFHalF1MWtxbWFDNE5IOWRPUnJrZWtkOGJZTFRhV0JaUkZORDhsRjhXWjVR?=
 =?utf-8?B?YVprVU1jd290a21oSGFhMWdFamc5ejI3WW5tRFBkZUdZRXN0bTZkU2dxZkNp?=
 =?utf-8?B?eEtEZUJvN3RaSW5sZHRmOFpQYWM4bVZ0dmtUWCtHSHNzcXlwWStMUW5JbUxX?=
 =?utf-8?Q?hDxSEWh2Ot6r1yR1UNgaIn+fE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d9de53be-150e-4690-ea69-08de0f8a8539
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 03:41:14.7719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyPsvY0wJvwuKT9CeVbmkeE0atUjl2goSYx3wdXWWdulu9lQcjsW3o2LJE+4iNKbh0K8ehNXh9Alkc1GJQbWR89VtpOgYq/lwSNs81juSMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1162
X-Mailman-Approved-At: Mon, 20 Oct 2025 06:31:54 +0200
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

PiBPbiAxNy4xMC4yNSAxNToxMiwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMTAv
MTcvMjUgMDM6MzMsIFlhbyBaaSB3cm90ZToNCj4gPiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAw
NzowNDo0OFBNICswMjAwLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPiA+PiBPbiAxMC8x
Ni8yNSAxODo1OCwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gPj4+IENvbW1pdCBhNjgx
Y2ZlY2I0MzQgKCJyaXNjdjogQWRkIGEgWmFscnNjLW9ubHkgYWx0ZXJuYXRpdmUgZm9yDQo+ID4+
PiBzeW5jaHJvbml6YXRpb24gaW4gc3RhcnQuUyIpIGNoYW5nZWQgdGhlIGhhcnQgc3luY2hyb25p
emF0aW9uIGluIHN0YXJ0LlMuDQo+ID4+PiBJdCB1c2VzIENPTkZJR19JU19FTkFCTEVEKFJJU0NW
X0lTQV9aQUFNTykgdG8gZGV0ZXJtaW5lIHdoaWNoDQo+IG1ldGhvZA0KPiA+Pj4gdG8gdXNlLiBJ
ZiB0aGUgbWFjcm8gZXZhbHVhdGVzIHRvIHRydWUgdGhlIG9sZCBiZWhhdmlvciBpcyBtYWludGFp
bmVkLg0KPiA+Pj4NCj4gPj4+IFRoZSBtYWNybyBldmFsdWF0ZXMgdG8gZmFsc2UgZm9yIFNQTCBi
dWlsZHMgd2hpY2ggd2FzIHVuaW50ZW5kZWQuDQo+ID4+PiBVc2UNCj4gPj4+IElTX0VOQUJMRUQo
Q09ORklHX1JJU0NWX0lTQV9aQUFNTykgaW5zdGVhZC4NCj4gPj4+DQo+ID4+PiBUaGlzIGZpeGVz
IGEgYm9vdCBmYWlsdXJlIG9uIFN0YXJGaXZlIEpINzExMCBiYXNlZCBib2FyZHMuDQo+ID4+Pg0K
PiA+Pj4gRml4ZXM6IGE2ODFjZmVjYjQzNCAoInJpc2N2OiBBZGQgYSBaYWxyc2Mtb25seSBhbHRl
cm5hdGl2ZSBmb3INCj4gPj4+IHN5bmNocm9uaXphdGlvbiBpbiBzdGFydC5TIikNCj4gPj4+IFJl
cG9ydGVkLWJ5OiBFbWlsIFJlbm5lciBCZXJ0aGluZw0KPiA+Pj4gPGVtaWwucmVubmVyLmJlcnRo
aW5nQGNhbm9uaWNhbC5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBIZWlucmljaCBTY2h1Y2hh
cmR0DQo+ID4+PiA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0KPiANCj4gZTY2
NDZiMzVmNDEwICgiUmV2ZXJ0ICJyaXNjdjogQWRkIGEgWmFscnNjLW9ubHkgYWx0ZXJuYXRpdmUg
Zm9yDQo+IHN5bmNocm9uaXphdGlvbiBpbiBzdGFydC5TIiIpIGhhcyBiZWVuIG1lcmdlZCB0aGlz
IG5pZ2h0LiBIZW5jZSB0aGUgY3VycmVudA0KPiBwYXRjaCBpcyBzdXBlcnNlZGVkLg0KPiANCj4g
aWJleC1hc3QyNzAwX2RlZmNvbmZpZyBmb3Igd2hpY2ggdGhlIG9yaWdpbmFsIHBhdGNoIHdhcyBk
ZXZlbG9wZWQgZG9lcyBub3QNCj4gYnVpbGQgdy8gb3Igdy9vIHRoZSByZXZlcnQgKCJ1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBfX2FzaGxkaTMnIikgb24gVWJ1bnR1DQo+IDI1LjEwIHVzaW5nIEdD
QyAxNS4yLg0KPiANCj4gPj4+IC0tLQ0KPiA+DQo+ID4gSGkgSGVpbnJpY2gsDQo+ID4NCj4gPiBU
aGFua3MgZm9yIHNlbmRpbmcgdGhlIHBhdGNoIQ0KPiA+DQo+ID4+DQo+ID4+IEhlbGxvIFlhbywN
Cj4gPj4NCj4gPj4gSXQgd291bGQgYmUgd29ydGh3aGlsZSB0byB1bmRlcnN0YW5kIHdoeSB5b3Vy
IG5ldyBtZXRob2QgZG9lcyBub3QNCj4gPj4gd29yayBvbiB0aGUgU3RhckZpdmUgVmlzaW9uRml2
ZSAyLiBJIG9ubHkgYWRkcmVzc2VkIHRoZSBLY29uZmlnDQo+ID4+IGlzc3VlLiBCdXQgSSBzdXNw
ZWN0IHRoZXJlIGlzIHNvbWV0aGluZyBicm9rZW4gaW4gdGhlIGFsdGVybmF0aXZlIHBhc3MuDQo+
ID4NCj4gPiBBIHBvc3NpYmxlIHJlYXNvbiBpcyB0aGF0LCBvbiBKSDcxMTAgbm90IGFsbCB0aGUg
Y29yZXMgc3VwcG9ydCBMUi9TQw0KPiA+IGluc3RydWN0aW9uczogdGhlIFM3IHNtYWxsIGNvcmUg
YWx3YXlzIHJhaXNlcyBhY2Nlc3MgZXhjZXB0aW9uIGZvciBpdA0KPiA+IHNpbmNlIHRoZSBpbXBs
ZW1lbnRhdGlvbiBvZiBMUi9TQyByZXF1aXJlcyBkYXRhIGNhY2hlIHRvIHByZXNlbnQsDQo+ID4g
d2hpbGUNCj4gPiBTNyBkb2Vzbid0IGhhdmUgb25lLg0KPiANCj4gQEhhbCwgQE1pbmRhDQo+IGRv
ZXMgdGhlIFM3IGNvcmUgZW50ZXIgVS1Cb290IFNQTCBhdCBhbGw/DQoNCk5vLCBJIHRoaW5rIFNQ
TCBydW5zIG9uIFU3NCBhdCBhbGwgYW5kIFM3IGlzIGRpc2FibGVkIGluIHRoZSBkZXZpY2UgdHJl
ZS4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQoNCj4gDQo+ID4NCj4gPiBUaGlzIGlzIGRvY3VtZW50
ZWQgaW4gU2lGaXZlIFU3NC1NQyBDb3JlIENvbXBsZXggTWFudWFsLA0KPiA+DQo+ID4+IExvYWQt
cmVzZXJ2ZWQgKExSKSBhbmQgc3RvcmUtY29uZGl0aW9uYWwgKFNDKSBpbnN0cnVjdGlvbnMgYXJl
DQo+ID4+IHNwZWNpYWwgYXRvbWljIGluc3RydWN0aW9ucyB0aGF0IGFyZSBvbmx5IHN1cHBvcnRl
ZCBpbiBkYXRhIGNhY2hlYWJsZQ0KPiByZWdpb25zLg0KPiA+PiBBcyB0aGUgUzcgY29yZSBkb2Vz
IG5vdCBoYXZlIGEgZGF0YSBjYWNoZSwgdGhlIExSIGFuZCBTQyBpbnN0cnVjdGlvbnMNCj4gPj4g
d2lsbCBhbHdheXMgZ2VuZXJhdGUgYSBwcmVjaXNlIGFjY2VzcyBleGNlcHRpb24uWzFdDQo+ID4N
Cj4gPiBBcyBTNyBhbHNvIHRha2VzIHBhcnQgaW4gdGhlIGluaXRpYWwgSEFSVCBsb3R0ZXJ5LCB1
c2FnZSBvZiBMUi9TQw0KPiA+IGluc3RydWN0aW9ucyBtaWdodCBqdXN0IGNyYXNoIGl0cyBib290
IHByb2Nlc3Mgd2l0aCBleGNlcHRpb24uDQo+ID4NCj4gPiBIb3dldmVyIEkgY291bGQgb25seSBj
b25maXJtIHRoZSBpZGVhIGRheXMgbGF0ZXIgd2hlbiBJIGhhdmUgYWNjZXNzIHRvDQo+ID4gYSBK
SDcxMTAgYm9hcmQuIFNpbmNlIGVhcmxpZXIgVG9tIGhhcyBtZXJnZWQgdGhlIHBhdGNoWzJdIHRo
YXQgcmV2ZXJ0cw0KPiA+IHRoZSBwcm9ibGVtYXRpYyBjb21taXQsIGRvIHlvdSB0aGluayBpdCdz
IGJldHRlciB0byB3YWl0IGZvciBtZSB0bw0KPiA+IGNvbmZpcm0gdGhlIGNhdXNlIGFuZCB3cml0
ZSB2MyBvZiB0aGUgcGF0Y2gsIGluc3RlYWQgb2YgZml4aW5nIGl0IHVwDQo+ID4gbm93PyBJJ2xs
IGNhcnJ5IHlvdXIgQ28tZGV2ZWxvcGVkLWJ5IHRhZyBpbiB2MyBpZiB5b3UncmUgb2theSB3aXRo
IHRoaXMuDQo+ID4NCj4gPj4gQmVzdCByZWdhcmRzDQo+ID4+DQo+ID4+IEhlaW5yaWNoDQo+ID4N
Cj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gWWFvIFppDQo+ID4NCj4gPiBbMV06DQo+ID4gaHR0cHM6
Ly9zdGFyZml2ZXRlY2guY29tL3VwbG9hZHMvdTc0bWNfY29yZV9jb21wbGV4X21hbnVhbF8yMUcx
LnBkZg0KPiA+IChDaGFwdGVyIDMuNiwgQXRvbWljIE1lbW9yeSBPcGVyYXRpb25zKQ0KPiA+IFsy
XToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy91LQ0KPiBib290LzE3NjA2MzYyOTkxNy4y
MTIyNzAuMTE0NTAzNDg3NjEzNjk5MTQyNA0KPiA+IC5iNC10eUBrb25zdWxrby5jb20vDQoNCg==
