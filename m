Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D866D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E54C895E3;
	Mon, 25 Nov 2024 01:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C013895AC; Mon, 25 Nov 2024 00:38:04 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C112892A0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGrGj79pkFwKqK7mkcfA+7HIK16ROj/VwRToOqiAackMzIAA+XkuwYvhHsTZsk2JXthfWafCxatNPc8VdPe9faqazKoxIFHrFMF4vpCTb6h10F2btzc+O16u2HDegrRCysNTx8IVI+VYlfJyu+ggiIno4yhqpLhHmxyhE0Ww0f2kTqfgxBMr6jVRhx26Xnm1QPsYzUOjcxfQMJlPXCJKFYKmaWMvicv4cmcJOFDBlIIFx+EXZNZjol2jjh2SC8h/pUkas+fW+GLKLmYi3Pp1kpYQdssLXpArV9X5BL8FL6lbeom/65W35ENWiUVhbi5Iu1e7mj2oAxqDoR6yQeI15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TPKvnCn3uLfkW8AfFG/LwoNnjbWFbBLFyZlKp/OqYw=;
 b=Mfdboe67AZT4YA1tHXqdwWljEuDWAZH9PQKxzws+01RhfO0v1dLsM1pxivVVRQh+E2QpClRGnediFKZD1c4nyGawyR+Ixs7geCfrWfAjoQqVVuZT0mBsbCi5qGAHhIoBO8xMznb+TTvYoNSXcUnxp6w79idtK32FWNTtYVuFCjWblJln3FDHPwfMRIQGvBYuxuNQLUOTQnBrc06/vMNqo84C/Dz2xPoLqJqKc9uec9lVDBdgn76x7py/ylPluxaHif8MoVsMWXs9KjycVQjrVJOwSgiACnxwuFcu3cLSb9UuF4HOfqcl+lNaLDyUcIgsH6AbSEGL0nuLklFgbVwxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Sun, 24 Nov
 2024 23:38:13 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Sun, 24 Nov 2024
 23:38:13 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <lucent@gmail.com>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, Bo Gan
 <ganboing@gmail.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v5 08/11] riscv: dts: jh7110: Support multiple DTBs in a
 Fit image
Thread-Topic: [PATCH v5 08/11] riscv: dts: jh7110: Support multiple DTBs in a
 Fit image
Thread-Index: AQHbOieZgthA3xoT20u8FMIS5mNs4LLDC0QAgAQTBcA=
Date: Sun, 24 Nov 2024 23:38:12 +0000
Message-ID: <ZQ2PR01MB13072D1DE7FDB5F7E4C01EAFE62DA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-9-hal.feng@starfivetech.com>
 <CANV2PTNBzZUaMGmOU6xQzsz7fBcxs4XkA+OksQmbvGQX0zqC8g@mail.gmail.com>
In-Reply-To: <CANV2PTNBzZUaMGmOU6xQzsz7fBcxs4XkA+OksQmbvGQX0zqC8g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
x-ms-office365-filtering-correlation-id: d4ec02d1-bceb-4322-5b05-08dd0ce10fd6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: QQGFQdf+ZN1MGdRZjxrQuxgqFBRsJXCs09XNWdPGWReqAF3PYGivFthvEq0v6a3FH+68fpZepRS/5Qi7kAvvKZw84UBQn0YHVVYzQc6LzoCWh/O/O+iSDVphemY8qcIq6YIyGBjLCKR39P+FPh+VPfMxtdiTQXujQCTp/YmgCzyKUbVzRizgqsyhxR6uoHz3PvwhldOGVLwd8BLBuesqd93jrfzKkkYU4ZHSq4w1PuPpevn6PzCjifnNMnhRnhiMrbq7t72VzZGB9LW2BdHXUvANEnsdpG1k/V262m8w/n14ZkDgUuHdRCWvjPM3tmlA91hfR34HL1gnyzOduMPY8X20eEMn4kUYjE6hWwhxaSFlDzl15TvoGhQd96tr/QoeUNekZlo1dxsArUG89BccQLzJWyBN++sEuPYrDqhDcbMGRvLVeKEcnWHAhPS7SULTy0UG7s/4M65mEJApxCI6tCh+GNG5Br93QxamNs3d9Skv1uawIrC7paJAdRogA2UyGETrP98xb9PyPAUF4JeK1dZnlAb12z0K2K1d2UOEqY8qMoqZJQ4zlyQkhH6NZkl8U3+etM/gagCcnQMbYLekOIg4OIkQrReq7u/5DKvYhyCnWU7RrlRN3FIPsJKyfFUH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(41320700013)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0JiNlVZQWE1d2Rlekt4bnZ3ek1Zd0hiTTlkVEJpV1ZDUGtNbnJXV09GTW11?=
 =?utf-8?B?bG5tTlVWZnhZRjV2Qnl4TFljdUI0RFBUZDMxaVkwY1JSeVdQRDhHV09OTDlM?=
 =?utf-8?B?TllmM3hjTnBYaTJaTHByY0xMeHpCU29vV0RMU1hRTUVHaTRHdXVzVDJmc1Nn?=
 =?utf-8?B?U3ViWTkxaFJXRHdkbVBZcWtEWFJaMUdJVnhZc0p2RGd0SGE1cldvT0hOdStR?=
 =?utf-8?B?SUtvY0NlZVpEbkl1ajFQZmFSNllPcUlDWUd1VzRBMW5FSGtTVEtpd2piaHZG?=
 =?utf-8?B?RXJlbTRZUnZlWTlEY3lkeG1PT2RxcHhsNnM2WVRsYkZWUmVQd2NLbm14UmZS?=
 =?utf-8?B?UTBIZnoybG9SMHcxSk5EY21mdEViWndJSm1ta1F0cnJhRFF1MXBvdGdINjZS?=
 =?utf-8?B?T2ExSktwVlFDMGxGTTU5RUthNUVPV0MrUEw4MEJiaTlaMkJlZC94ZEYra2d1?=
 =?utf-8?B?Q29vVjZOenFEdEhvRFo2Y3dnVk5La254K2NXY2lrRjNBdUhyUFhnTExCb0Rv?=
 =?utf-8?B?cnlRMzIxQU9FUXowbkYvVlRlUW56akhlVDNhMHpSTHBvNDk4NnJ1STA5dE95?=
 =?utf-8?B?S3lOOHA1OUxKelNiZ2RQOFlUYXF2ZEE2b1JTOVVPWHdtQlBvUmtMZ2dublZx?=
 =?utf-8?B?MWphTzJpNmh3dzZRN3VWNHVyOHhiaVdQamdQU2hvTzcxam5GUTFSU0VHdzJP?=
 =?utf-8?B?Y3k5RU5YOVYvZHBZRzdzTTZUWjdROHAxajNWb0dyRTdmdFdXSTUwWGVMWFRT?=
 =?utf-8?B?UzRqY0pHWlVCWkhnQWxmTFFIeDlSSkNTT1ROU1UzSUxUalY4c25hN1pZUGJr?=
 =?utf-8?B?WXU3dEhha1ptNzYrQ1R2RlE4a21uT1d6ZThmMmpzNC84M0ZRMFh2TFV2dloy?=
 =?utf-8?B?ZndsZVE2elFIWlRjWnRWcUFwZ2lvR0ZhbGtqZFJjbGlOUGVKTzJDeGpRY0lj?=
 =?utf-8?B?TkFnWHlBQWtwd3MvSGc4Y3hQS3RPTFRmeVNSOWV4dTZPelREc3IyVldsMWlU?=
 =?utf-8?B?WU1VUTFjQVB2S1U5Z1RQbVpjVTFlKzFkU0h0RUM1cFprRGFPQ3VGK1Y5Q0pL?=
 =?utf-8?B?NldSZzRzOUt3aWp0dEM4Q2oxTzVpb0lhVzNTaXcrM0drL1BPSCs4RHJhay9L?=
 =?utf-8?B?Z0x2MXFaTnBXS0JCQ2EveURNcS81TmpBT2pSajdhLys3NDhJNGM1c2x4MlpL?=
 =?utf-8?B?TDZaN3lYUXJxWHgrd2FGQWdySXdiR0k2U1RTSVgxbmJRY0Y3aHBTbXNXQWE0?=
 =?utf-8?B?NU44T01UNmR5Y1dyUytxeW15T1JXcWFyN2RJeTFGUnBtcVlOZnBKYzQyS0FB?=
 =?utf-8?B?VndqNHZMdW5ZZWtudFE4ZjYxeGdvTFBoK1FwcjZad2YyU01NTW5aTzBvcW5N?=
 =?utf-8?B?M3M1eENMVnQzYjU1Sm1XaEE4ZzdRamVxT1Y5RXpzZzI5RDY5bCt0QUVVcC9r?=
 =?utf-8?B?NWFRdklMekN3U25TYTZMYWMxT2pFQ0VuYmlxeEdybi9zcGQwT0hIOERsTi9k?=
 =?utf-8?B?VGRUbjBlbW1yZXEzNWRxUVMxcGxUM0xGVjFIL0xSMVFjZXJ3V3RQWTUwNGox?=
 =?utf-8?B?TDVEUENuNzNuZmd2djQ2S0NzMUJJa3B0NVQwdWxuM2xCdk9NdlVaRExJT2do?=
 =?utf-8?B?RjZuWHhGZVJYaTVVVk9GK1JsTE4zZjZjMUJPOGlFVW8ydXJUak5mVEdRVFpn?=
 =?utf-8?B?Ulh2cTd0TExPVHQ0OE0yS2U1Tm1hN3pHc0Yvanh6emtnSVJrUWdLL3lGZHFt?=
 =?utf-8?B?WUVRdlZ4MElpOE1JVlYySmNub3NnSmZzblQrTzdyVWRPK2RRenA0Nk5GQlZz?=
 =?utf-8?B?MHJKVldUcTVaTzkxWjQ2QkE3V2Y3Wld5dVVienZXQVlOWDErcmpKSHZhd2Nt?=
 =?utf-8?B?aEFFVTh5SFdxQWY4Z3JBcVVsWWdWWHhGMUkxc1hYVWdYR1k0OTZqelhwUTQw?=
 =?utf-8?B?Y3FnTDB1TUhUQ2doM2hUa0ZqWFA3OFp3bVREQ2hZRUNpcjhrRG91NFVSUzFX?=
 =?utf-8?B?TnBpVG5ENEJUdmljWmlEU29QL2N1TGtpbTg4Z3FPV1N2bkVOYXAvdWQ5UVpH?=
 =?utf-8?B?RUIzNHY0VmRwczdhbjhyYjVwQm1JZHN6dFNQRVNuWXY0V2Q0dzdnZjNSSVFh?=
 =?utf-8?Q?YcnAt3o8TAERP9Vy5ZcVi4dvr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ec02d1-bceb-4322-5b05-08dd0ce10fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2024 23:38:12.9300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bL54cs2b/enrca9ENnsMHVSXiu4/hq7zrOY5+tLlnDhRp0ySbeFysE7uUAfmEylyLGlJAhU563U4J42+62V9XVMKdW5/qJaMhAuLW/PtVJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

PiBPbiAyMi4xMS4yNCAxNzoyMSwgRSBTaGF0dG93IHdyb3RlOiANCj4gT24gTW9uLCBOb3YgMTgs
IDIwMjQgYXQgNjowNuKAr1BNIEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IFN1cHBvcnQgbXVsdGlwbGUgRFRCcyBmb3IgSkg3MTEwIGJhc2Vk
IGJvYXJkcywgc28gdGhleSBjYW4gc2VsZWN0IHRoZQ0KPiA+IGNvcnJlY3QgRFQgYXQgcnVudGlt
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRl
Y2guY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2R0cy9qaDcxMTAtY29tbW9uLXUtYm9v
dC5kdHNpIHwgNjANCj4gPiArKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaQ0KPiA+IGIvYXJj
aC9yaXNjdi9kdHMvamg3MTEwLWNvbW1vbi11LWJvb3QuZHRzaQ0KPiA+IGluZGV4IGM0NDU1MzQ1
NWUuLjM5MjhkNTUxYzkgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9kdHMvamg3MTEwLWNv
bW1vbi11LWJvb3QuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvZHRzL2poNzExMC1jb21tb24t
dS1ib290LmR0c2kNCj4gPiBAQCAtMTEzLDIwICsxMTMsNzQgQEANCj4gPiAgICAgICAgICAgICAg
ICAgZml0IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpbWFnZXMgew0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZmR0LTEgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXNjcmlwdGlvbiA9ICJOQU1FIjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVzY3JpcHRpb24gPQ0KPiA+ICsgImpo
NzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiOw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsb2FkID0gPDB4NDA0MDAwMDA+Ow0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wcmVzc2lvbiA9ICJub25lIjsNCj4g
Pg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1Ym9vdF9mZHRf
YmxvYjogYmxvYi1leHQgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGZpbGVuYW1lID0gInUtYm9vdC5kdGIiOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBibG9iLWV4dCB7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWUgPQ0KPiAiZHRzL3Vwc3Ry
ZWFtL3NyYy9yaXNjdi9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNi
LmR0YiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZkdC0yIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGVzY3JpcHRpb24gPSAiamg3MTEwLXN0YXJmaXZlLXZpc2lv
bmZpdmUtMi12MS4yYSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxvYWQgPSA8MHg0MDQwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXByZXNzaW9uID0gIm5vbmUiOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmxvYi1leHQgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGVuYW1lID0NCj4gImR0cy91
cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12
MS4yYS5kdGIiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZHQtMyB7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2NyaXB0aW9uID0gImpoNzExMC1taWxrdi1tYXJz
IjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9hZCA9IDww
eDQwNDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29tcHJlc3Npb24gPSAibm9uZSI7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBibG9iLWV4dCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWUgPQ0KPiAiZHRzL3Vwc3RyZWFtL3NyYy9y
aXNjdi9zdGFyZml2ZS9qaDcxMTAtbWlsa3YtbWFycy5kdGIiOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBm
ZHQtNCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2Ny
aXB0aW9uID0gImpoNzExMC1waW5lNjQtc3RhcjY0IjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbG9hZCA9IDwweDQwNDAwMDAwPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcHJlc3Npb24gPSAibm9uZSI7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBibG9iLWV4dCB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmls
ZW5hbWUgPQ0KPiA+ICsgImR0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZpdmUvamg3MTEwLXBp
bmU2NC1zdGFyNjQuZHRiIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbmZpZ3VyYXRpb25zIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bmYtMSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2Ny
aXB0aW9uID0gImpoNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaXJtd2FyZSA9ICJvcGVuc2JpIjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9hZGFibGVzID0g
InVib290IjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmR0
ID0gImZkdC0xIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZi0yIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVzY3JpcHRpb24gPSAiamg3MTEw
LXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4yYSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZpcm13YXJlID0gIm9wZW5zYmkiOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2FkYWJsZXMgPSAidWJvb3QiOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZHQgPSAiZmR0LTIiOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25mLTMgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXNjcmlwdGlvbiA9ICJqaDcxMTAtbWlsa3YtbWFycyI7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpcm13YXJlID0gIm9w
ZW5zYmkiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2Fk
YWJsZXMgPSAidWJvb3QiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBmZHQgPSAiZmR0LTMiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mLTQgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXNjcmlwdGlvbiA9
ICJqaDcxMTAtcGluZTY0LXN0YXI2NCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGZpcm13YXJlID0gIm9wZW5zYmkiOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsb2FkYWJsZXMgPSAidWJvb3QiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZHQgPSAiZmR0LTQiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICB9Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgfTsNCj4gPiAtLQ0KPiA+
IDIuNDMuMg0KPiA+DQo+IA0KPiBBcmUgd2Ugc3VyZSBpdCBpcyBhIGdvb2QgaWRlYSB0byBoYXZl
IHNlcXVlbnRpYWwgbnVtYmVyaW5nIGZvciB0aGluZ3MgdGhhdA0KPiBvdWdodCB0byBiZSBvcmRl
cmVkIGJ5IGFscGhhbnVtZXJpYz8gU291bmRzIHRvIG1lIGxpa2UgYSBub2lzeSBjb21taXQgaW4g
dGhlDQo+IGZ1dHVyZSB3aGVuIGFkZGluZyBib2FyZCBzdXBwb3J0IGFuZCB0cnlpbmcgdG8gc29y
dCwgb3IganVzdCBwaWxpbmcgb24NCj4gc2VxdWVudGlhbCBhZGRpdGlvbnMuDQo+IA0KPiBmaXR7
IGltYWdlc3sgZmR0LTEgeyAuLi4gfSB9IH0NCj4gY29uZmlndXJhdGlvbnN7IGNvbmYtMSB7IGRl
c2NyaXB0aW9uID0NCj4gImpoNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiIC4uLiBm
ZHQgPSAiZmR0LTEiIH0gfQ0KPiANCj4gVGhpcyBpcyBwZXJoYXBzIG5vdCBhcyBnb29kIGFzIGl0
IGNhbiBiZSwgZm9yIGJlaW5nIGdpdCBjb21taXQgZnJpZW5kbHkgd2hlbg0KPiBhZGRpbmcgYm9h
cmQgc3VwcG9ydCB0aGF0IGlzIHNvcnRlZCBieSBuYW1lLg0KPiANCj4gV2hhdCBhYm91dD86DQo+
IA0KPiBmaXR7IGltYWdlc3sgZmR0LXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYiB7IC4uLiB9
IH0gfSBjb25maWd1cmF0aW9uc3sgY29uZi0NCj4gc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjNi
IHsgZGVzY3JpcHRpb24gPSAiamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi0NCj4gdjEuM2Ii
IC4uLiBmZHQgPSAiZmR0LXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYiIgfSB9DQo+IA0KPiBi
YXNlZCBvbiB0aGUgY29tcGF0aWJsZSBpZGVudGlmaWVyIGZvciB0aGF0IGJvYXJkIG9yIGRvZXMg
dGhhdCBicmVhaw0KPiBzb21ldGhpbmc/DQoNClllYWgsIGl0J3Mgb2sgYW5kIEkgd2lsbCBtb2Rp
ZnkgYWNjb3JkaW5nbHkuIFRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=
