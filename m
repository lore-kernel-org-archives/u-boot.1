Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B910EF99FF
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 09:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E3083DEC;
	Sat, 14 Feb 2026 10:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0C683DFF; Sat, 14 Feb 2026 10:26:57 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20723.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605B383DE4
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 10:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy7KBqvqglcU6hwpXQpA/2hF6WWzyRf6sF613rgdIDaahN0w3HUx3oBPp1W0k0GCflpD/sv6sCp7XFdJhRwKZKJxdkCeEiisDfsLSkBQiQ2bKX5dFLwNrwVUEgY6eA9HRNG+nV+Ln9f1qiE3tbc0F4vks+rVnJoxt7InFVeNim8rEed488v0YjohsRS70nRB+TCurOo80NWkddkCbrmm/vXulCoyq+67pV1+iU9fzmLcRdMzxiJBgyuK8RKdxBpTMIJ8iNYANKhLq3mtxhW8yEzmuTXo5d80mVFHH3u5U4jR6NCYqUJI7ASq39X35mBA7p6/uPu/HSQ6asjNUOZDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE4g9fLemy2v8ah/PKy3zuTWoaPxiWWYEOrWc/iS3HI=;
 b=Oq8W1ccABnFSBsZFIo8CB/OVaGVMtTuoHseeWcIk18buOAXaeGLnW+/o47cbQzIow24VUFaMej42/WaC/ZpTUp4hfnaNiK9iFwgC5Vp/55Nk7GqOgtWSpit7oWOPHIKUukj4c4Z1w17chhtS5fkbStYesmmXvpYtTvfLVSLZq2URB5cYHGeuuiwVUDd/WOlPntsnsxExfPLM+PkC6auPmDVwGxtLXLP+itwBx9IIkv5y3gaCtsPwkePmF97lLM7+WweoEvlyF2+kbsCckgqTx8jrv3sJCo0VExqyDR1rIV9JvmD1pZs5T/O/N4fDb1TYU0oNbzVi0xvY8W/zdHH4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1275.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.23; Sat, 14 Feb
 2026 09:26:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%5]) with mapi id 15.20.9587.022; Sat, 14 Feb 2026
 09:26:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo Liang <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 0/9] Add support for StarFive VisionFive 2 Lite board
Thread-Topic: [PATCH v1 0/9] Add support for StarFive VisionFive 2 Lite board
Thread-Index: AQHcRMSHxNA44CQ2BkSxr2T1Jwv/rrV64vUAgACDI4CAA6J5gA==
Date: Sat, 14 Feb 2026 09:26:45 +0000
Message-ID: <ZQ2PR01MB130703202F9949D83F0CA25EE66E2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <aYnDPqVzlesZqy2C@swlinux02>
 <0e28b0a3-0c85-4690-8429-fe3cc514dded@freeshell.de>
In-Reply-To: <0e28b0a3-0c85-4690-8429-fe3cc514dded@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1275:EE_
x-ms-office365-filtering-correlation-id: 8c6ad73c-8d20-491f-d5e3-08de6bab2c2f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: EkAcGkBjj1/Jsz4z8tSd668o5H28p3/77fATXLgIHJcVXb2cD39kroZINU9shq5T3UIOekNpQ3X2cDo+HXrsGZTCqrfDTiwf18IVw/DmsaQBYEo3VPK5cV25UMnmebboM/xNo8QK7LPaRJ4QXZrMk9m3CtEJt3ViSiOQGdPm0Srnj2e0cBZYPT7S22cqr1RBsHPTAI78P4J0jW+hzfbvaJirk7SEfFmO+sxgNXtRoU3R+5sYKzI4nO+N+TnA5Xis4669eKS4pnL4al3l8H7KgmOL6HTnfVlQoOAJ6MYubDQtTnIwU6fs8BhzsXMVBGTVTjf4MCLuZNVmACTIbTaWy0EkNgONsrSvUcXoWLoj+xAt0vNG4kvst84/qKwzb/Rg8gXZCd9cGf7eXbNrRdP/f0E69MQVDP98Cp3FK2lPuMA7zkPwgdHlAZ4VPMhMLOSAKM6xoeHCRNr/Qcpg/8Vllhgh44fd1oncRhsnwhhM67lGRNd+h59p0n0nFcbtH8xC75Krrfg+9L/OimFPdkjyWj85b8XFwd7HbkUzD9Lbk7eSrG1iSPPJx92CqNfizRautcbaKsw5oTwP3AT/NTnhXwUn3msgukXxz+zR8dnJDGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU9nWU50UThGbDRDYUtzTGMzWEZEcE5tUEp5Q3R5a2tJU0IzMTU5R1dHU2xO?=
 =?utf-8?B?U1g3RThMb05iWWhCazk0QWFuOCtNYitPeXVIeXNZTGY3VkhkL1hUQ0UxM25v?=
 =?utf-8?B?ZW9nbG1sNWFCSTIyd2FoeHB0RWVodjNlbFk2d3NRYXpVbkZsZ2hwNGNJTnFZ?=
 =?utf-8?B?S3MzR3V4ZUdaUXMxMFpaRzJUenFGWXgxRWxDRjM1djUzY2pDR3kvWTlNeTh3?=
 =?utf-8?B?ZDJ6Z3JpWFY1d1VERCtKV0JZWHVOSkRVVlB1dzA5VTVkbVJhT1Jyek1zeEkr?=
 =?utf-8?B?enhYYWNCWTFxN1h4U0R5T2pKWGRlYUoycWpIeTVCV0ZqbFVjbEZGOCtpTXNu?=
 =?utf-8?B?bU16MXdvbGlzamg4cndLNWhuYlMwMjZxTDlZdjhNdXV1azdzRy9OK1pwREta?=
 =?utf-8?B?ZmpMcXpGQVpzNzlMSXppTzdrL2ZFQWNKWlNXMEhzNlA3TVpmZWNmOHNUZDZS?=
 =?utf-8?B?NlBMaUV6aUFwY3VsTnBSaExMdzd2Mmd1ZWdEMlFFZlhmSkVMUlluNDBsSmhx?=
 =?utf-8?B?a1dZNkdRWHJLdWZDUy9TNU5XTWN1SmVyL2RHdHBvaFIxdHNtZE9pNTZhL3dP?=
 =?utf-8?B?RVpaWitqRVdnelFlWkFKTzZOcmNVUEpjaC9qVlNqTVVyOFl6R0pISXlVa2xu?=
 =?utf-8?B?cy9tdG94bnYxU0lWdFdDZndUcUhBZjhlbS94dEFrQUtnZzUxV3loYysrMWhJ?=
 =?utf-8?B?MldOaWFQTVpicmNHRlJueStqSUwyMjdHSGdabGM4bWw0YlZ3STVUam5sUGZC?=
 =?utf-8?B?c0ZMeWwwSlhZbnRxUE5aY1NEdk1DZEc4blJ4cll0QlQ0RGYwRVlMZ2JnNWha?=
 =?utf-8?B?UHlGOTlETUNKc3hxYkhucGo2UmRIbTZSTm1TRkZSUXhpSTQ0MlFVZjlSNk55?=
 =?utf-8?B?MU1KVGtzM3ZKendwNHFPeFdNTStEbVd0UktDN3U5Z2JtSk5zMzFiYjJvUXRn?=
 =?utf-8?B?NnkzNW90enVvMm8rdHpqT29rYkhwQkoyQkorVi9zN2xvTGlHZVFZcEkwaTBC?=
 =?utf-8?B?OW9xem9OaVdIdlM0dGc2ZG9GWFZDUDZlaWhjU09QQlR3TTVPSXNLRTkwYnk0?=
 =?utf-8?B?bktpUm53emtFS2IwZUN1YUdwQ2xLYXFXVHh2ZUxBd1NrQkZwZ1FPSDcwNDJs?=
 =?utf-8?B?cGZJS09vajJGMFM1UkRTMXNRUStXdUVQN2l4M09mRkhTSkZsdkx5WG9WZVUr?=
 =?utf-8?B?TXpNWDlPUmF4RjFrK1FpUFhlNkVMYkcyQzc2RHRRT0toVm5OejEwMWZvQm1S?=
 =?utf-8?B?UzZBcXdicEIzMmNVTWZ5bEsvZWRlc2lVR24wUmdYSnlhd2pJSEoyOHJ6YUxl?=
 =?utf-8?B?ZkdFc2s5L25CWXlBUU1HQWF4SkNwZ1BXRmorekNLSU5wWnBWTEZTMzhJYVB1?=
 =?utf-8?B?SEo1MnRGdHZDQndjd1JIRmdUUkhmUFBLVThqT0Fxb09XUmQ2ZEJQR1B6N0x3?=
 =?utf-8?B?amZJU20xeGFiblMzL2lndGpMRVNBV0tIK2psR1NoOVdpQm1RMWIyRU1VVGFr?=
 =?utf-8?B?ay9jYXlaWGtneWgza09meXJsMDNIK1hpVzJpeWhJTEQ2U0tpbE1MRzdlQ3BG?=
 =?utf-8?B?Q2gvSEZpNlozUTFjczNjbExrekdSS25jNS93OFllSkh6RHNRMWNObFZwcmps?=
 =?utf-8?B?aVlvaUE3K2ZsRjk5ZkxXN1RsU0dPeHlQajBQTVJySWdyVWRGUTlwWnpBY1dC?=
 =?utf-8?B?MEZGMXdPemNSSHBtKzNQMVdMclR6OU9oNHlBVmdlVmZBRkhObzhlY1NaMFV3?=
 =?utf-8?B?SWdKMmJUTytyWXNCZ2lLZC9JaVF0RWt3Q3R1d0NmdU9POHJ1alNXUWg2ZEQ2?=
 =?utf-8?B?QnFVTnlUbEtiTGE2YS9jblJIYmFXTTV5bTFMWlZjZlR4Z1dHOHJiMjVQOVBi?=
 =?utf-8?B?bHJsOFU2cDdDNFNEVW1SRk5OMEQyR3hUOEQ3dFJld1ZCWU1jWW9sWUlwVzJt?=
 =?utf-8?B?VW95M2xMYm1ObEIyaS9PMFZVUk5iRE1wamNSVnc1SnNORnVBRU5pazR4Njc0?=
 =?utf-8?B?cUl2NEptYmVid0dIc0VzaTFEZVFxR0E4QzM5UEtaQW1LUHplNWNSN3lBSlZW?=
 =?utf-8?B?RUFPWDN5enRpSkVkc093aXMrR0JQc0U4RW9pU280b2VNVXFMK3V3blpTRU94?=
 =?utf-8?Q?LznTBItH0r+uJNBK7k+qCypSL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6ad73c-8d20-491f-d5e3-08de6bab2c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 09:26:45.7807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxLfSFfDT+ufa72rEs8We3NY7MMDe7vSwUb4g8r9lFdKCZvsSwHalUcF+YQdEW8ARWBTo4siRvmwyUQqSWmdOAVd85gk0pYtIF7HtFVjr6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1275
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

PiBPbiAxMC4wMi4yNiAwMzoxMSwgRSBTaGF0dG93IHdyb3RlOg0KPiBIaSBMZW8sIEhhbCwgVG9t
LCBhbmQgSGVpbnJpY2gsIGV0LmFsDQo+IA0KPiBPbiAyLzkvMjYgMDM6MjEsIExlbyBMaWFuZyB3
cm90ZToNCj4gPiBPbiBGcmksIE9jdCAyNCwgMjAyNSBhdCAwNDo1OToyM1BNICswODAwLCBIYWwg
RmVuZyB3cm90ZToNCj4gPj4gVmlzaW9uRml2ZSAyIExpdGUgaXMgYSBtaW5pIFNCQyBiYXNlZCBv
biB0aGUgU3RhckZpdmUgSkg3MTEwUw0KPiA+PiBpbmR1c3RyaWFsIFNvQyB3aGljaCBjYW4gcnVu
IGF0IC00MH44NSBkZWdyZWVzIGNlbnRpZ3JhZGUgYW5kIHVwIHRvDQo+IDEuMjVHSHouDQo+ID4+
DQo+ID4+IEJvYXJkIGZlYXR1cmVzOg0KPiA+PiAtIEpINzExMFMgU29DDQo+ID4+IC0gNC84IEdp
QiBMUEREUjQgRFJBTQ0KPiA+PiAtIEFYUDE1MDYwIFBNSUMNCj4gPj4gLSA0MCBwaW4gR1BJTyBo
ZWFkZXINCj4gPj4gLSAxeCBVU0IgMy4wIGhvc3QgcG9ydA0KPiA+PiAtIDN4IFVTQiAyLjAgaG9z
dCBwb3J0DQo+ID4+IC0gMXggTS4yIE0tS2V5IChzaXplOiAyMjQyKQ0KPiA+PiAtIDF4IE1pY3Jv
U0Qgc2xvdCAob3B0aW9uYWwgbm9uLXJlbW92YWJsZSA2NEdpQiBlTU1DKQ0KPiA+PiAtIDF4IFFT
UEkgRmxhc2gNCj4gPj4gLSAxeCBJMkMgRUVQUk9NDQo+ID4+IC0gMXggMUdicHMgRXRoZXJuZXQg
cG9ydA0KPiA+PiAtIFNESU8tYmFzZWQgV2ktRmkgJiBVQVJULWJhc2VkIEJsdWV0b290aA0KPiA+
PiAtIDF4IEhETUkgcG9ydA0KPiA+PiAtIDF4IDItbGFuZSBEU0kNCj4gPj4gLSAxeCAyLWxhbmUg
Q1NJDQo+ID4+DQo+ID4+IFZpc2lvbkZpdmUgMiBMaXRlIHNjaGVtYXRpY3M6DQo+ID4+IGh0dHBz
Oi8vZG9jLQ0KPiBlbi5ydnNwYWNlLm9yZy9WaXNpb25GaXZlMkxpdGUvUERGL1ZGMl9MSVRFX1Yx
LjEwX1RGXzIwMjUNCj4gPj4gMDgxOF9TQ0gucGRmIFZpc2lvbkZpdmUgMiBMaXRlIFF1aWNrIFN0
YXJ0IEd1aWRlOg0KPiA+PiBodHRwczovL2RvYy1lbi5ydnNwYWNlLm9yZy9WaXNpb25GaXZlMkxp
dGUvVmlzaW9uRml2ZTJMaXRlUVNHL2luZGV4LmgNCj4gPj4gdG1sIE1vcmUgZG9jdW1lbnRzOg0K
PiA+PiBodHRwczovL2RvYy1lbi5ydnNwYWNlLm9yZy9Eb2NfQ2VudGVyL3Zpc2lvbmZpdmVfMl9s
aXRlLmh0bWwNCj4gPj4NCj4gPj4gTm90ZTogUGF0Y2ggMSBhbmQgMiBhcmUgdGhlIGtlcm5lbCBk
ZXZpY2UgdHJlZSBwaWNrZWQgZnJvbSBbMV0uIFRoZXkNCj4gPj4gYXJlIGp1c3QgZm9yIHRlc3Qg
YW5kIHBsZWFzZSBpZ25vcmUgdGhlbSBiZWNhdXNlIGR0cy91cHN0cmVhbSBzaG91bGQNCj4gPj4g
YmUgc3luY2VkIHdpdGggZGV2aWNldHJlZS1yZWJhc2luZy4NCj4gPj4NCj4gPj4gWzFdDQo+ID4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgyMTEwMDkzMC43MTQwNC0xLWhhbC5m
ZW5nQHN0YXJmaXZldA0KPiA+PiBlY2guY29tLw0KPiA+Pg0KPiA+PiBDaGFuZ2VzIHNpbmNlIFJG
QzoNCj4gPj4gLSBSZWJhc2Ugb24gdGhlIGxhdGVzdCBtYWlubGluZS4NCj4gPj4gLSBJbXByb3Zl
IHRoZSBjb21taXQgbWVzc2FnZXMuDQo+ID4+IC0gRHJvcCBwYXRjaCA3Lg0KPiA+PiBwYXRjaCAz
LCA0Og0KPiA+PiAtIFJldHVybiAwIGluc3RlYWQgb2YgMHhGRiBpZiByZWFkX2VlcHJvbSgpIGZh
aWxzLg0KPiA+PiBwYXRjaCA1Og0KPiA+PiAtIEtlZXAgZGVmYXVsdCBGT1JNQVRfVkVSU0lPTiAw
eDIuDQo+ID4+IC0gQ2hhbmdlIHdpZmlfYnQgZmllbGQgdG8gb25ib2FyZF9tb2R1bGUgZmllbGQg
YW5kIHVzZSBiaXQgMCB0byBtYXJrDQo+ID4+ICAgV0lGSS9CVC4NCj4gPj4gLSBEcm9wIGFsbCAi
bm9fZXRoMCIsICJub19ldGgxIiBjb25maWd1cmF0aW9uLg0KPiA+Pg0KPiA+PiBIaXN0b3J5Og0K
PiA+PiBSRkM6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgyOTA2MDkz
MS43OTk0MC0xLWhhbC5mZW5nQHN0YXJmaXZldA0KPiA+PiBlY2guY29tLw0KPiA+Pg0KPiA+PiBI
YWwgRmVuZyAoOSk6DQo+ID4+ICAgcmlzY3Y6IGR0czogc3RhcmZpdmU6IGpoNzExMC1jb21tb246
IE1vdmUgb3V0IHNvbWUgbm9kZXMgdG8gdGhlIGJvYXJkDQo+ID4+ICAgICBkdHMNCj4gPj4gICBy
aXNjdjogZHRzOiBzdGFyZml2ZTogQWRkIFZpc2lvbkZpdmUgMiBMaXRlIGJvYXJkIGRldmljZSB0
cmVlDQo+ID4+ICAgZWVwcm9tOiBzdGFyZml2ZTogU2ltcGxpZnkgZ2V0X2Rkcl9zaXplX2Zyb21f
ZWVwcm9tKCkNCj4gPj4gICBlZXByb206IHN0YXJmaXZlOiBDb3JyZWN0IGdldF9wY2JfcmV2aXNp
b25fZnJvbV9lZXByb20oKQ0KPiA+PiAgIGVlcHJvbTogc3RhcmZpdmU6IFN1cHBvcnQgZWVwcm9t
IGRhdGEgZm9ybWF0IHYzDQo+ID4+ICAgcGNpZTogc3RhcmZpdmU6IEFkZCBhIG9wdGlvbmFsIHBv
d2VyIGdwaW8gc3VwcG9ydA0KPiA+PiAgIGNvbmZpZ3M6IHZpc2lvbmZpdmUyOiBBZGQgVmlzaW9u
Rml2ZSAyIExpdGUgRFQgdG8gT0ZfTElTVA0KPiA+PiAgIGJvYXJkOiBzdGFyZml2ZTogc3BsOiBT
dXBwb3J0IFZpc2lvbkZpdmUgMiBMaXRlDQo+ID4+ICAgYm9hcmQ6IHN0YXJmaXZlOiB2aXNpb25m
aXZlMjogQWRkIFZpc2lvbkZpdmUgMiBMaXRlIGZkdCBzZWxlY3Rpb24NCj4gPj4NCj4gPj4gIGFy
Y2gvcmlzY3YvY3B1L2poNzExMC9zcGwuYyAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+
PiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLWpoNzExMC9lZXByb20uaCAgIHwgIDEzICst
DQo+ID4+ICBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9zcGwuYyAgICAgICAgICAgICAgfCAg
IDMgKw0KPiA+PiAgLi4uL3Zpc2lvbmZpdmUyL3N0YXJmaXZlX3Zpc2lvbmZpdmUyLmMgICAgICAg
IHwgICAyICsNCj4gPj4gIC4uLi92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMg
ICAgICB8ICA2NCArKysrLS0tDQo+ID4+ICBjb25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2Rl
ZmNvbmZpZyAgICAgICAgfCAgIDIgKy0NCj4gPj4gIGRyaXZlcnMvcGNpL3BjaWVfc3RhcmZpdmVf
amg3MTEwLmMgICAgICAgICAgICB8ICAgOCArDQo+ID4+ICAuLi4vc3JjL3Jpc2N2L3N0YXJmaXZl
L2poNzExMC1jb21tb24uZHRzaSAgICAgfCAgMjIgLS0tDQo+ID4+ICAuLi4vamg3MTEwLWRlZXBj
b21wdXRpbmctZm1sMTN2MDEuZHRzICAgICAgICAgfCAgNDkgKysrKysrDQo+ID4+ICAuLi4vc3Jj
L3Jpc2N2L3N0YXJmaXZlL2poNzExMC1taWxrdi1tYXJzLmR0cyAgfCAgNDkgKysrKysrDQo+ID4+
ICAuLi4vcmlzY3Yvc3RhcmZpdmUvamg3MTEwLXBpbmU2NC1zdGFyNjQuZHRzICAgfCAgNDkgKysr
KysrDQo+ID4+ICAuLi4vamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICAgICAg
fCAgNDYgKysrKysNCj4gPj4gIGR0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZpdmUvamg3MTEw
LmR0c2kgICB8ICAxNiAtLQ0KPiA+PiAgLi4uL2poNzExMHMtc3RhcmZpdmUtdmlzaW9uZml2ZS0y
LWxpdGUuZHRzICAgIHwgMTU5ICsrKysrKysrKysrKysrKysrKw0KPiA+PiAgMTQgZmlsZXMgY2hh
bmdlZCwgNDE4IGluc2VydGlvbnMoKyksIDY2IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4g
Pj4gMTAwNjQ0DQo+ID4+IGR0cy91cHN0cmVhbS9zcmMvcmlzY3Yvc3RhcmZpdmUvamg3MTEwcy1z
dGFyZml2ZS12aXNpb25maXZlLTItbGl0ZS5kdA0KPiA+PiBzDQo+ID4NCj4gPiBSZXZpZXdlZC1i
eTogTGVvIFl1LUNoaSBMaWFuZyA8eWNsaWFuZ0BhbmRlc3RlY2guY29tPg0KPiANCj4gVGhlIHNl
cmllcyBoYXMgZXJyb3JzIGFzIGl0IGlzIGFwcGxpZWQ6DQo+IA0KPiBodHRwczovL3NvdXJjZS5k
ZW54LmRlL3UtYm9vdC9jdXN0b2RpYW5zL3UtYm9vdC1yaXNjdi8tDQo+IC9jb21taXRzL21hc3Rl
cj9yZWZfdHlwZT1IRUFEUw0KPiANCj4gRm9yIGV4YW1wbGU6DQo+IA0KPiBodHRwczovL3NvdXJj
ZS5kZW54LmRlL3UtYm9vdC9jdXN0b2RpYW5zL3UtYm9vdC1yaXNjdi8tDQo+IC9jb21taXQvNGVh
M2FjYzAwMGE3OTNkMDRiYWU5MGVhYmZkYzQ3YmUzMTU4MGI4Nw0KPiANCj4gLSBDT05GSUdfT0Zf
TElTVD0ic3RhcmZpdmUvamg3MTEwLWRlZXBjb21wdXRpbmctZm1sMTN2MDENCj4gc3RhcmZpdmUv
amg3MTEwLW1pbGt2LW1hcnMgc3RhcmZpdmUvamg3MTEwLW1pbGt2LW1hcnNjbS1lbW1jDQo+IHN0
YXJmaXZlL2poNzExMC1taWxrdi1tYXJzY20tbGl0ZSBzdGFyZml2ZS9qaDcxMTAtcGluZTY0LXN0
YXI2NA0KPiBzdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLXYxLjJhDQo+IHN0
YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuM2IiDQo+IA0KPiArIENPTkZJ
R19PRl9MSVNUPSJzdGFyZml2ZS9qaDcxMTAtZGVlcGNvbXB1dGluZy1mbWwxM3YwMQ0KPiBzdGFy
Zml2ZS9qaDcxMTAtbWlsa3YtbWFycyBzdGFyZml2ZS9qaDcxMTAtbWlsa3YtbWFyc2NtLWVtbWMN
Cj4gc3RhcmZpdmUvamg3MTEwLW1pbGt2LW1hcnNjbS1saXRlIHN0YXJmaXZlL2poNzExMC1waW5l
NjQtc3RhcjY0DQo+IHN0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTItdjEuMmEN
Cj4gc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi12MS4zYg0KPiBjb25maWdz
L3N0YXJmaXZlX3Zpc2lvbmZpdmUyX2RlZmNvbmZpZyINCj4gDQo+IFRoZSBhYm92ZSBkb2VzIG5v
dCBhZ3JlZSB3aXRoIHdoYXQgSSByZXZpZXdlZCBvbiB0aGUgbWFpbGluZyBsaXN0LiBJIGFtIGxp
c3RlZA0KPiBhcyBoYXZpbmcgcmV2aWV3ZWQgdGhlIGNvbnRlbnQgYmVpbmcgYXBwbGllZC4gV2hh
dCB3YXMgYXBwbGllZCBpcyBzb21ldGhpbmcNCj4gY29tcGxldGVseSBkaWZmZXJlbnQgdGhhbiB3
aGF0IEkgcmV2aWV3ZWQhDQo+IA0KPiBNeSBxdWVzdGlvbjoNCj4gDQo+IFdoeSBhcmUgY2hhbmdl
cyB0byB0aGUgc2VyaWVzIGJlaW5nIG1hZGUgd2hlbiBhcHBseWluZyB0byB0aGUgdHJlZSwgd2hv
IGlzDQo+IG1ha2luZyB0aG9zZSBjaGFuZ2VzLCBhbmQgaG93IGNhbiB3ZSBnZXQgdmlzaWJpbGl0
eSBpbnRvIHRoZXNlIG1pc3Rha2VzPyBNeQ0KPiBxdWVzdGlvbiBpcyB2YWxpZCBldmVuIGlmIHRo
ZSBlcnJvcnMgYXJlIG5vdCBpbnRlbnRpb25hbCBvciB0aHJvdWdoIGFjdGlvbiBvZg0KPiBzb21l
IGF1dG9tYXRlZCBtZXJnZSBhbGdvcml0aG0uDQo+IA0KPiBUaGlzIGlzIGEgc2VyaW91cyBwcm9i
bGVtIHRvIGFzc29jaWF0ZSBjb250cmlidXRvcnMgd2l0aCBjb2RlIHRoZXkgZGlkIG5vdCB3cml0
ZQ0KPiBvciByZXZpZXcuDQoNCk1heWJlIHNvbWUgbWlzdGFrZXMgaGFkIGJlZW4gbWFkZSB3aGVu
IHNvbHZpbmcgdGhlIG1lcmdpbmcgY29uZmxpY3QuIExldCdzIGZpeCBpdC4NCg0KSnVzdCBjaGFu
Z2UNCg0KY29uZmlncy9zdGFyZml2ZV92aXNpb25maXZlMl9kZWZjb25maWcNCg0KdG8NCg0Kc3Rh
cmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlDQoNCkkgaGF2ZSBzZW50IGEg
cGF0Y2ggdG8gZml4IGl0LiBQbGVhc2UgY2hlY2suDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI2MDIxNDA5MTQyNC4yODQyOC0xLWhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20vDQoN
CkJlc3QgcmVnYXJkcywNCkhhbA0K
