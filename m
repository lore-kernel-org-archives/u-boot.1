Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C6CC27C4F
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 01:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A1987572;
	Mon, 24 Jun 2024 03:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5F48752A; Mon, 24 Jun 2024 03:28:12 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987B787572
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 03:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb+tGNSf4tdRYunH245VAckIJvB+PmMjUpbWB+blm53/4lIM+GVb9FFUx8/4jzfcbMCSKM1C/cNELUVSg4FH1FEg5nMDjOMSlyXLWm970NLApWxk31WmgpvklFkGjSdfQE0ghClaJiHgBgNNInx1uouGkknKaFr8xqxl+muznzg4XwlOiuIhKo7P3gBtpWNJKfh7wmRzbl+K9DUD8LOWe/2XNnqMn22+eKP2L1jYV5HsPyeE6feaWSlqgg0WE7rrcnMU8kuKhcsYq5hWZRImedey3hKXSuN0tdeUoJiybcKxBMRRtDz9icznHIq4CHpo6Y4DcpmvYO8PBM16OMaLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIcZF0tv24TWme1BconSReA41mIOZCTbbXuu8z75O4k=;
 b=eLeqDCiNjRpg91jYzrbfWs6FabcueKskB0NW1z8ctATN6LPNzesLD3riLY9gXWPjD1WtTwP/R/NwmfulE6R0y5ad1d9a+H9yzVisXYZDxuiMYt1+3+DGOaTaCf3UCl4+OJM5z392ri/5lc2oNQBRAwkFjAqnbfOCObAx9vFyW+s5rpmaP256WqZNdJuaOh1KwWCCF0AAlzs4PaEUnDaCbpfrlJAmrtDo22swb+u4DMxWoSlx8pP7SrKAtQ6zpC+kyPdox46g3m5Lw4EV9rT87a0ityg8MNkmnJhGNBOK65fqhYu4dAefKX3xI6g88351mJT4BPpZwHrc56lN1SKECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0560.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33; Mon, 24 Jun
 2024 01:28:04 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7677.036; Mon, 24 Jun 2024 01:28:04 +0000
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
Thread-Index: AQHanjRPIEXPrMMIQ0uF+i29iZxT/rGfqnSAgAAU4BCAMQidgIAFpyog
Date: Mon, 24 Jun 2024 01:28:04 +0000
Message-ID: <SHXPR01MB0863E8C1D1CD4A5AF958AA85E6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
 <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTPjYM1PO5QtwsLYAkTCnko2DqLL2yjfOgaZUvxUjxXr4A@mail.gmail.com>
In-Reply-To: <CANV2PTPjYM1PO5QtwsLYAkTCnko2DqLL2yjfOgaZUvxUjxXr4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0560:EE_
x-ms-office365-filtering-correlation-id: 21834d35-3682-46c5-ef67-08dc93ece54e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|41320700010|7416011|1800799021|38070700015; 
x-microsoft-antispam-message-info: GK1daSVGGN+alNklblmszXDGZQ+75cj9Ns8DiG5dYYk40BeMO26Qt/gnzMALjXXpT67Bo05jLARQQD4jxHMdhzv6bTKNY0b+y6ZUo2mhoeo9FV8DH9nqilNI586RZi4p5GLBx6aUCDLMuCE5B3g72R0L91O5uQxDC0lcQnNBKtjov1JwGo468eyvLkEMq6MMBEx2rwB+5ZA9YYP02aXZkMLSKAEZTGHlF4LrpPyv4YqgcC20kx4PwUuRIO3/vronnU3IZD0Ttn9YyKr9FTj6Rsrewc4Vzq8CDqbpY68y6byAnQqU/Q2SPVOP6KHDXvufZDLi9Mz3vfnf/5YpQpP/7OnQe/Roq02qZMYA2F+BjHwHkX6e1gY17MaKPZMyBBxZgYLRS1TpinaI6WEAVnifv0lVG0M3RMS99/iDoBhItKBM0Iy3wdRoksyr2MaBTDwMbwalrIRGtPyfhK4fFXCEJLwzu5KA0bvpmJD4g5t4wkDn0i3B619y7jSBxZ84X229n4BQVoHDiHA1XjGEJd4Vwz+JXKcvnRr0T2MxjEg7A/wbDX8az3eofYmQvGZKK+1q/vWrZX+g7Tvd4HMc1O19jd9atIyhZerbAxxY+QkqHpS8h6bxIW+Dkuh4TarvWwzF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230037)(366013)(41320700010)(7416011)(1800799021)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0U4MUN4ZzI1cDhXRktXMjQxR2VIUDFHbkowRjVORWJ5N0RiVE9KU0FzYXd4?=
 =?utf-8?B?TWxyazliUGhzVE4wUmZZV0x3SFc2SmlmS0tudllKSWFxd0tUb2src1o4Y2w1?=
 =?utf-8?B?ajJ6OE5kMGZiWmhjcEc1QnFzYzhMY0xScktzMFk0NTVobGpnY3YvUDQ5aTdH?=
 =?utf-8?B?cnBEUnV6MUNWSHJ5eHZnZ2JSSy9mQlNMdUVxcFN1RFlXWmRSTytxS2tUMUY3?=
 =?utf-8?B?bGx5MGhZa0FlS1paV1J0RnlUQkJmVjd0S0Q4OUxIenpvTnpHN3ZOQUFsMU5t?=
 =?utf-8?B?U2dMSVRnSDhzemZBallSQyttQXZ0bURkNmRGQlppTWFxdEVVTWMrLzFKcUx4?=
 =?utf-8?B?WG1LbW4rejBnSEtDVGU5aU82MWtwMDREN0Qwa3FCWU9UTlB0S3dxVFp6VTZu?=
 =?utf-8?B?VmtkZHhKWXVWR29HVkxHdEFYNzlvVklzRFVycm50Um92M2xodExNZUtlb256?=
 =?utf-8?B?bnBpblY1K21tTGJjbk9mVEpwMUh6VDlMdFhxY2RyaXMzd3ZzNzZkVHJ5Z1kz?=
 =?utf-8?B?bElDM3VOdkFLU2hrSkFvd2xoZG1QRjNwaEswYmZGSlZNVXJDOTQvc0FxUElW?=
 =?utf-8?B?Y0xSWUptS0JiSy9QYVRIYnAxVit3QkZtcFlCcnhEcm5NMGttb3kxSkJnTVh1?=
 =?utf-8?B?aitYdElZSVBUZ3RqOVBvb0xlZzh3aWpoeEFydTNjeDgxeXhDdFZaNDAwdFdm?=
 =?utf-8?B?b2VXUDRPamF6dlkzVy9LMWJUd3QyOE9CRVlBOGZpclczQ2NUbHlkTG9VVzMw?=
 =?utf-8?B?OE1UWFYvMWVMSEQvTkRsc3o0US9vU1M0L3JMOTN1cVJKbkcyMnFsaTBjV1Nz?=
 =?utf-8?B?bDUwL3pieFlLNWlHR1VEeitDKzdzL25yQUtwaCtyUUdYUnBPcXdQSGVTdGNG?=
 =?utf-8?B?c2RIT0orMlhVQ0FrYms5eHo1TTMyV2xtY1dkc2J0UnNsalFLMzljNUNlWlBS?=
 =?utf-8?B?ZmU2aGVRbEFPbjZmMThnTzBscGcwemUyYkR6NytMNWY4OEJIVngxaTJTYnl1?=
 =?utf-8?B?NDEzNjIxVlBxeWs5SCtMcExrRzlPWkUyL0NiV1c4SG1xVlkya0l2K0hpeDlD?=
 =?utf-8?B?WXBvOTg2WUhoR2VUQkwyWlBDNEdtbW02ekdjSmJOQmdFUXRRa1FJM0Rmc3hN?=
 =?utf-8?B?Y2MydFpuSWVobmNyZzBPM2czZXF5OHpiZVFmQmhDRGJpV1RCNDEvczVwMnJi?=
 =?utf-8?B?cVJ3Y291elU1TXhCUEhLVCtjN3ZXeEF4bVdLckMyVG5Sb2lSbDBTUWV2WnlI?=
 =?utf-8?B?Nk9zYy9CQ2JwOGRPUXg5QjBrQmUwanRKUW8wYms3TmNrSXNzN1VhWEdLbDJ2?=
 =?utf-8?B?ZTJtWHdDUDd3U3lndUxuUWdzZ09WOE1wYk53SmpjYXpzakUxc3FTa3FQZlMr?=
 =?utf-8?B?Skx6aDdPS1ZqdXErMlRPb2NvRGxFeXBlLy95aFFmSjBXN2xKZ1FqUGxDbG1W?=
 =?utf-8?B?L0dVbVZyT2JpZXBvL3Z4Z0ptV3RMT3NobXJIYkppcm01YWdoRFlxYzl2MkpN?=
 =?utf-8?B?S2NoZ29RVUxpZEFxb1o4dWYwVitMc0loenM1Q1NLNnozeUpwYVFnbW5Qa3A2?=
 =?utf-8?B?c2tDVG1rK1FXUjZldERoL1NWNE91R296cEQxYXM5dGNldDNZekk0R1BkSzB0?=
 =?utf-8?B?ekJoOXdOdmtXUGllMXR0ajY4NEdWM0VXRU9zT1N2SEFwb0dCMVRuV3JWMHhQ?=
 =?utf-8?B?NmZjWkRjamFsMGJUcXlWM3dnbHdRQ0pPMTdHT083blBiUnZlb1F3WDZoaG13?=
 =?utf-8?B?SEQzRTd3Z1JWSU9yVjBXMHFzc3NweXlhalZlMi9ocjJvZUxCdndyNS9zS2VZ?=
 =?utf-8?B?Qk9Eb1pzNllGazhiaWxMcXh5QnZDODFGTExESFcwT2Y2aUt2VlVNWkM3clBN?=
 =?utf-8?B?ZHFoa3ZEMUF6QkxVWE84UlNLQnhuclJKRUN5VndaOUdScGZDUTJRd1ZVK0d2?=
 =?utf-8?B?dVR6ckYrNmxUT215UEkvRklNU1hMb2ZTSFZjeTZxbjlDNi90dDk1clBnRUtS?=
 =?utf-8?B?R1RvT2VPbDRpeEpMWkNrVVk2cHFLS3FSSGVTdFMvZWRnTWlTNjRPWXhFVU9s?=
 =?utf-8?B?SUdtclgzYXMwUGFsZk5XWXgxMlR6dFVKc01veFM2T0tlOE5GOHdINEgwNDhh?=
 =?utf-8?Q?LdxDJ6Gg1wJTB0TmdzCeTufF1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 21834d35-3682-46c5-ef67-08dc93ece54e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 01:28:04.8472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzQR8JElhm7/nszGGuiep4XjJK5CcL0o9NLeoQn7iBV5Uae4ZLL1r1feYzGQia/n/qtg7Zv22/COA/bjG/NKCQmoDaCprCRZXNDno93s5Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0560
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

DQoNCj4gDQo+IE1pbmRhLCBjYW4geW91IHRlc3QgVVNCIEhvc3QgZnVuY3Rpb24gb24gVmlzaW9u
Rml2ZTI/IEkgZ3Vlc3MgdGhhdCBpdCBpcw0KPiBjb25uZWN0ZWQgdG8gdGhlIFVTQi1DIHBvcnQu
IEZvciB0aGUgYm9hcmRzIHdpdGggSkg3MTEwIGFuZCBub3QgYW55DQo+IFZMODA1IFVTQiBjb250
cm9sbGVyIHRoaXMgQ2FkZW5jZSBVU0IgaXMgdGhlIG9ubHkgd2F5IHRvIGhhdmUgaG9zdCBVU0Iu
IEl0IGlzDQo+IHZlcnkgbXVjaCB3YW50ZWQgdG8gaGF2ZSBob3N0IFVTQi4gVGhhbmtzISAtRQ0K
PiANCg0KSW4gVkYyLCBQQ0llMCBjb25uZWN0IHdpdGggVkw4MDUgVVNCIDMuMCBob3N0IGNvbnRy
b2xsZXIuIE5vdyBQQ0llIGRyaXZlciBoYXZlDQpjb21taXQgdG8gVWJvb3QgdXBzdHJlYW0gY29k
ZS4gVVNCIDMuMCBjYW4gYmUgdXNlZCBpbiB1Ym9vdCB1cHN0cmVhbSBjb2RlLg0KTWlsay12IG1h
cnMgYWxzbyBjb25uZWN0IFZMODA1IGFuZCBjYW4gdXNlIFVTQiAzLjAgaG9zdCB0b28uDQoNCllv
dSBjYW4gdXNlICJwY2kgZSIgY29tbWFuZCB0byBhY3RpdmUgVVNCIDMuMCBob3N0IGNvbnRyb2xs
ZXIgYW5kIHRoZW4gInVzYiByZXNldCIgdG8gDQpzY2FuIHVzYiBkZXZpY2VzLiAgSWYgeW91IGhh
dmUgYW55IGlzc3VlIGFib3V0IHRoaXMuIEFsc28gcmVwbHkgaXQgaW4gdGhpcy4gVGhhbmtzLg0K
DQo+IE9uIFN1biwgTWF5IDE5LCAyMDI0IGF0IDExOjIw4oCvUE0gTWluZGEgQ2hlbiA8bWluZGEu
Y2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+DQo+
ID4gPiBIaSwgdGhlcmUgaXMgYSBjb21waWxlIHdhcm5pbmcuIEkgZG9uJ3Qga25vdyB3aHkuDQo+
ID4gPg0KPiA+ID4gT24gU2F0LCBNYXkgNCwgMjAyNCBhdCA4OjA04oCvQU0gTWluZGEgQ2hlbg0K
PiA+ID4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBBZGQgU3RhcmZpdmUgSkg3MTEwIENhZGVuY2UgVVNCIGRyaXZlciBhbmQgcmVs
YXRlZCBQSFkgZHJpdmVyLg0KPiA+ID4gPiBTbyB0aGUgY29kZXMgY2FuIGJlIHVzZWQgaW4gdmlz
aW9uZml2ZTIgYW5kIG1pbGt2IDcxMTAgYm9hcmQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBkcml2
ZXIgaXMgYWxtb3N0IHRoZSBzYW1lIHdpdGgga2VybmVsIGRyaXZlci4NCj4gPiA+ID4NCj4gPiA+
ID4gcGF0Y2gxOiBBZGQgc2V0IHBoeSBtb2RlIGZ1bmN0aW9uIGluIGNkbnMzIGNvcmUgZHJpdmVy
DQo+ID4gPiA+ICAgICAgICAgd2hpY2ggaXMgdXNlZCBieSBTdGFyZml2ZS4NCj4gPiA+ID4NCj4g
PiA+ID4gcGF0Y2gyLTM6IFVTQiBhbmQgUENJZSAyLjAgKHVzYiAzLjApIFBIWSBkcml2aWVyDQo+
ID4gPiA+IHBhdGNoNDogQ2FkZW5jZSBVU0Igd3JhcHBlciBkcml2ZXIuDQo+ID4gPiA+IHBhdGNo
NS03IGR0cywgY29uZmlnIGFuZCBtYWludGFpbmVycyB1cGRhdGUuDQo+ID4gPiA+DQo+ID4gPiA+
IE1pbmRhIENoZW4gKDcpOg0KPiA+ID4gPiAgIHVzYjogY2RuczM6IFNldCBVU0IgUEhZIG1vZGUg
aW4gY2RuczNfcHJvYmUoKQ0KPiA+ID4gPiAgIHBoeTogc3RhcmZpdmU6IEFkZCBTdGFyZml2ZSBK
SDcxMTAgVVNCIDIuMCBQSFkgZHJpdmVyDQo+ID4gPiA+ICAgcGh5OiBzdGFyZml2ZTogQWRkIFN0
YXJmaXZlIEpINzExMCBQQ0llIDIuMCBQSFkgZHJpdmVyDQo+ID4gPiA+ICAgdXNiOiBjZG5zOiBz
dGFyZml2ZTogQWRkIGNkbnMgVVNCIGRyaXZlcg0KPiA+ID4gPiAgIGNvbmZpZ3M6IHN0YXJmaXZl
OiBBZGQgdmlzaW9uZml2ZTIgY2FkZW5jZSBVU0IgY29uZmlndXJhdGlvbg0KPiA+ID4gPiAgIGR0
czogc3RhcmZpdmU6IEFkZCBKSDcxMTAgQ2FkZW5jZSBVU0IgZHRzIG5vZGUNCj4gPiA+ID4gICBN
QUlOVEFJTkVSUzogVXBkYXRlIFN0YXJmaXZlIHZpc2lvbmZpdmUyIG1haW50YWluIGZpbGVzLg0K
PiA+ID4gPg0KPiA+ID4gPiAgLi4uL2R0cy9qaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0yLmR0
c2kgICAgIHwgICA1ICsNCj4gPiA+ID4gIGFyY2gvcmlzY3YvZHRzL2poNzExMC5kdHNpICAgICAg
ICAgICAgICAgICAgICB8ICA1MiArKysrKw0KPiA+ID4gPiAgYm9hcmQvc3RhcmZpdmUvdmlzaW9u
Zml2ZTIvTUFJTlRBSU5FUlMgICAgICAgIHwgICAyICsNCj4gPiA+ID4gIGNvbmZpZ3Mvc3RhcmZp
dmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnICAgICAgICB8ICAgOSArDQo+ID4gPiA+ICBkcml2ZXJz
L3BoeS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiAg
ZHJpdmVycy9waHkvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
PiA+ID4gIGRyaXZlcnMvcGh5L3N0YXJmaXZlL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAx
OSArKw0KPiA+ID4gPiAgZHJpdmVycy9waHkvc3RhcmZpdmUvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgIHwgICA3ICsNCj4gPiA+ID4gIGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtcGNp
ZS5jICAgICAgICB8IDIxMQ0KPiA+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBkcml2
ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLXVzYjIuYyAgICAgICAgfCAxMzUgKysrKysrKysr
KysNCj4gPiA+ID4gIGRyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICB8ICAgNyArDQo+ID4gPiA+ICBkcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKw0KPiA+ID4gPiAgZHJpdmVycy91c2IvY2RuczMvY2RuczMtc3RhcmZp
dmUuYyAgICAgICAgICAgIHwgMTg0DQo+ICsrKysrKysrKysrKysrKw0KPiA+ID4gPiAgZHJpdmVy
cy91c2IvY2RuczMvY29yZS5jICAgICAgICAgICAgICAgICAgICAgIHwgIDE3ICsrDQo+ID4gPiA+
ICAxNCBmaWxlcyBjaGFuZ2VkLCA2NTIgaW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gPiA+IGRyaXZlcnMvcGh5L3N0YXJmaXZlL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+ID4gPiBkcml2ZXJzL3BoeS9zdGFyZml2ZS9NYWtlZmlsZSAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4gPiA+IGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtcGNpZS5jDQo+ID4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11
c2IyLmMNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9jZG5z
My1zdGFyZml2ZS5jDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IGJhc2UtY29tbWl0OiAxNzRh
Yzk4NzY1NWM4ODgwMTdjODJkZjE4ODNjMGMyZWEwZGMyNDk1DQo+ID4gPiA+IC0tDQo+ID4gPiA+
IDIuMTcuMQ0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFRoZSBjb21waWxlIHdhcm5pbmcgYXMgZm9s
bG93czoNCj4gPiA+DQo+ID4gPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20NCj4gPiA+IC9ob21lL3Vz
ZXIvc291cmNlL3UtYm9vdC5naXQvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmM6NzA6DQo+ID4g
PiAvaG9tZS91c2VyL3NvdXJjZS91LWJvb3QuZ2l0L2luY2x1ZGUvbGludXgvYml0bWFwLmg6IElu
IGZ1bmN0aW9uDQo+ID4gPiDigJhiaXRtYXBfZmluZF9uZXh0X3plcm9fYXJlYeKAmToNCj4gPiA+
IC9ob21lL3VzZXIvc291cmNlL3UtYm9vdC5naXQvaW5jbHVkZS9saW51eC9iaXRtYXAuaDoxNzA6
MTc6IHdhcm5pbmc6DQo+ID4gPiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhm
aW5kX25leHRfemVyb19iaXTigJk7IGRpZCB5b3UgbWVhbg0KPiA+ID4g4oCYZmluZF9uZXh0X2Jp
dOKAmT8gWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ID4gPiAgIDE3MCB8ICAg
ICAgICAgaW5kZXggPSBmaW5kX25leHRfemVyb19iaXQobWFwLCBzaXplLCBzdGFydCk7DQo+ID4g
PiAgICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ICAgICAg
IHwgICAgICAgICAgICAgICAgIGZpbmRfbmV4dF9iaXQNCj4gPiA+ICAgQ0MgICAgICBkcml2ZXJz
L3VzYi9jZG5zMy9lcDAubw0KPiA+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tDQo+ID4gPiAvaG9t
ZS91c2VyL3NvdXJjZS91LWJvb3QuZ2l0L2luY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oOjI2
LA0KPiA+ID4gICAgICAgICAgICAgICAgICBmcm9tDQo+ID4gPiAvaG9tZS91c2VyL3NvdXJjZS91
LWJvb3QuZ2l0L2RyaXZlcnMvdXNiL2NkbnMzL2VwMC5jOjE5Og0KPiA+ID4gL2hvbWUvdXNlci9z
b3VyY2UvdS1ib290LmdpdC9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOiBJbiBmdW5jdGlvbg0KPiA+
ID4g4oCYYml0bWFwX2ZpbmRfbmV4dF96ZXJvX2FyZWHigJk6DQo+ID4gPiAvaG9tZS91c2VyL3Nv
dXJjZS91LWJvb3QuZ2l0L2luY2x1ZGUvbGludXgvYml0bWFwLmg6MTcwOjE3OiB3YXJuaW5nOg0K
PiA+ID4gaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZmluZF9uZXh0X3plcm9f
Yml04oCZOyBkaWQgeW91IG1lYW4NCj4gPiA+IOKAmGZpbmRfbmV4dF9iaXTigJk/IFstV2ltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ID4gICAxNzAgfCAgICAgICAgIGluZGV4ID0g
ZmluZF9uZXh0X3plcm9fYml0KG1hcCwgc2l6ZSwgc3RhcnQpOw0KPiA+ID4gICAgICAgfCAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gPiAgICAgICB8ICAgICAgICAgICAg
ICAgICBmaW5kX25leHRfYml0DQo+ID4gPg0KPiA+ID4NCj4gPiA+IElzIHRoaXMgc29tZXRoaW5n
IG1pc3NpbmcgaW4gdGhlIHBhdGNoIHNlcmllcz8NCj4gPiA+DQo+ID4gPiAtRQ0KPiA+DQo+ID4g
SSBoYXZlIG5vdCBub3RpY2VkIHRoaXMuIEkganVzdCBjaGVjayB0aGlzIGl0IGlzIHJpc2MtdiBj
b2RlIGRvIG5vdCBjb250YWluDQo+ICJmaW5kX25leHRfemVyb19iaXQiIG1hY3JvIGRlZmluZS4N
Cg==
