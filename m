Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA879C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 05:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEAB882E2;
	Mon, 24 Jun 2024 07:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397C5882E6; Mon, 24 Jun 2024 07:38:26 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769C68823C
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 07:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naeHhgUP7vHcZjSMu+u4HeAi/zp2iMEP5B6fCnjRYv1QGvFQ7R8UW7rI+YY+Lxa3PjBepPX6lCmTFCsSyXUey/jx3UwqEbvbkXY9f8WZkbuqPZRrS/f/Vvvh6+9q/Lq8jJUTOGo4HztP9C7JW7Db62eKgC3O6SXueTXBIOpZ+n6MwBs3HqXFpevzkF/t0ZBd5X8uNd0y0H66g9LekfZYumjwUU2RLacaRBFKSmVz4tAeEgr545puysDBR2RL6uzakBdYyL4VFvCtHWeffJT0b9FpEthyLyTB6OEtiT1S4eKfuJbbbq8QOC5Bnrv4Dv+Rm+MlAAxXHhSsptLTN+waLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e4dJ17hb1GOPviQrv+G+egdNRWT28Eg0uxcfc/KqTY=;
 b=jJbpbN1Fpk6CYdO3Zc55dkRLXtG6//m5XajMon2nIj2XJYpAU1OxBm7kAydKF+uXSKuFQw/ye19CvdM6qFNHWAM26I0VmVuRBLBaca/9XwPsbdLCbvu/Fc7KTtxZk0pVwOSwv/GVzFlBvLUqrTNN+0ikcqKT2gQXCkctOoOj+q/zdmiCEW/1sRCygnJj2Rrz7zg1fGvqtI0ZHh38I8sRo/UjyTIgqzwF+7c8nRhkDhB079/o3ByT3qREePmD4mx+Qc1GmP/qQb5eTIormRuIDLe7uJUUwJpkfPYXkZpgT1RLa+CIlAkzckJ1hhs7354W/VTZasSxFV/tEcbw1bMxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0845.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33; Mon, 24 Jun
 2024 05:38:16 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7698.025; Mon, 24 Jun 2024 05:38:16 +0000
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
Thread-Index: AQHanjRPIEXPrMMIQ0uF+i29iZxT/rGfqnSAgAAU4BCAMQidgIAFpyoggAA/3ICAAAYLsA==
Date: Mon, 24 Jun 2024 05:38:16 +0000
Message-ID: <SHXPR01MB0863D6497FBDA1990BD0C943E6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <CANV2PTM8zp4cQu4vyuz5itm0mhoMiagV_=GUbsp87RUFTmQsNw@mail.gmail.com>
 <BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTPjYM1PO5QtwsLYAkTCnko2DqLL2yjfOgaZUvxUjxXr4A@mail.gmail.com>
 <SHXPR01MB0863E8C1D1CD4A5AF958AA85E6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTPjAEz1x7AJ=9D63pxRk4VmVb-qO+VWW5SOotE3aP0U9g@mail.gmail.com>
In-Reply-To: <CANV2PTPjAEz1x7AJ=9D63pxRk4VmVb-qO+VWW5SOotE3aP0U9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0845:EE_
x-ms-office365-filtering-correlation-id: 11fe5980-9a69-4eaa-d5b7-08dc940fd8fd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230037|1800799021|7416011|366013|41320700010|38070700015; 
x-microsoft-antispam-message-info: xvGtD9SD6GqkR38M1/JcSiuXs0eBG8l0sZRuK3OZ4hrEmK5ew1pETf8swjjh3DhyT++g3bhkTO7PRj9fh+Tk98OUstjILd7WtOrtKSJqD3Bt3U6KYgAPVwV/wzrucQ7IGfF/byibBWo3V2HsXkEaWpZfzHOEDjfFl6rzTeKriLuHB07Vi+rm7JbMxE/A0ux2wPX+mSTByMrneeoSG2yusCrROGsBqq64Ihe7yOxiBRFHqTPBPstTCzQ1OOHCQSy1r7DAWWgfUo48lKK3mcMFQRddQuFwi8ehNFMZ6xQkx+GWhlWVeqIBkSN/5wCeiqJgbXju2E7ztlx8XaIwD1uHsSYq2BQHBODc9XWqF/Ebjq7pt1WikHP2KXP1fqN1vivqPeotzW9YST5wXlMLWLucUdXXBHPj6J3f/uPneFxl8XlDRuE1SWCmOHQD3F+DDJ1NhWdtKc2rAxpTdKstk2ZbqZ6jVt6mecXNch9JklcvCYHru1RvnnO9OgL65+ZE5fUqGbfLaFsdm+OjT2Xa322YdtyOenYqc3rpJMw9qBg1dBh96jk9Hpse1R8sNonb04rZxhPJDxpJ7UuExnUN29A1ju2wpjgSWs5JfndV5ShCxJjwRtiD13NExhsSUBf4GdEv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230037)(1800799021)(7416011)(366013)(41320700010)(38070700015); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxXdWlILy8yWDFuRmVCL01rMzAzYjRKUC9PQkFOUWFOMUEzZzIzZXEvb1NP?=
 =?utf-8?B?NnRCTTJZZ3dEa2dST3BHenRUQUI0RldYNlVxYk9VUHFtWExkNVlmVVRyQlRZ?=
 =?utf-8?B?d3FvaFpaWVQ5UTJBNm9nd3R0cVZIbGtGSkloSjY4YjZoeVhUNmlWNFhwN2U5?=
 =?utf-8?B?ZytsTVB0ckhsc3NMQVRpMFR4RzRuUC90VXlObFZoSU9MRmVCNndOUC9id3FG?=
 =?utf-8?B?VlltazI4aXJSSzJUQUE0MXc3R1dhR2x4bzk1R0dOb3pRVWUydVBjU3ZFZTha?=
 =?utf-8?B?ejNCelFBUVZjcE1zdW1HV0hoMWtWakdkS2FibUUzcG9wQlNHWE9lKzVVVENa?=
 =?utf-8?B?elFwL1ZLNlpnajlmSEZBN2h4cEZkdXZGQzlmZjJIcERyRHN1VDZhNTV4cmlY?=
 =?utf-8?B?UnVKTW1MQkVHT3FSUWRISDZvT2lSdFhlZTRqVkM5Vy9Wbis5bHJYOS8xMGhO?=
 =?utf-8?B?ck9zUzJWRTZYc1dYVm9IenZYZTVaWUVMdzU3MytjMGpmWWJjTEovYTVpOU9p?=
 =?utf-8?B?RmFiQWR5SHFpbUg4UTRWZ000RWIwdWdqdE4rWXBxTFg5ZXc5NE5hZ0Q2MGIx?=
 =?utf-8?B?dlgranRqZHYyQ2lxTnROSzRzaWhPRGVWM1hVbGxGV2pEaUJUZnB5L3FEZzVT?=
 =?utf-8?B?a2kxbnlVQTRTQlpKYUc3RStGQ3d1dTdUMHA2ODhGRC9IMndLaEo4dkExdE5x?=
 =?utf-8?B?UVhaZ3pLQXNMUG1kNWpJeUYvL3JGNU1WYU1tZUI1NnlRSHpwdzlNQmpxNWtO?=
 =?utf-8?B?MHRCZlppQVNVOUhYQnVQbmpmUGZDWVBnSGRWOXBqTlJ5TlJoRjhkL1dOaG02?=
 =?utf-8?B?UmY5bVUyUDVuSGpGamhYd1lrWGFyMTBjYk5aKzhiQ2ZmVTRuYWZENFkwdXNv?=
 =?utf-8?B?ZkJXS09TTnUyYnI5aUFYMkw2SEFJMk4zR1Z3VmR0SWNGM2lJR01ZQzZtRDRJ?=
 =?utf-8?B?bXdHekh3SFJ2dER4eUZ0Q2RRTDAvUk5BRStBZjltMFlqSzFTMXlKTHBUUkFG?=
 =?utf-8?B?UVNOaUJNSURDTmd5dHBNcEwzNkIzd0UrbWRVcGw1ZWsvR1kxVVFFKzZkR2lI?=
 =?utf-8?B?cFlrUENTanhsdHY3aitjdmdiR013blZDeXEvVTk2bllGV2JjTFZnVzMvUHMv?=
 =?utf-8?B?QW5XODcvNlB3M3lZSjZ3V1BoR2VZYXFiTWkyY1hXcndZb1paaituSFhoSDlx?=
 =?utf-8?B?OXpCM2Zld3d5Ny9UWGpHOXgrVUdXYndSaXlKNjNnWlFGVGxNL3N2alNJYjJw?=
 =?utf-8?B?NkMwU1VSMEc5eXRFTjZ6aW96YklxV1M5eTNPVTc5K25FVlhtM0g5NUlpNXhB?=
 =?utf-8?B?R2U2Y251eThNd3VzbTIrL1BuZlFMWW1FZEVvcDliTS9xS0tOL0JTZFhRQ3pu?=
 =?utf-8?B?djBtcVBrM3RXS3FlTVAvbUZZUXpGN2NYMldOMmpEanJqWTRVcXNRTElOWUNq?=
 =?utf-8?B?L2xWVU4vckpnelErNFR0MmhnY2UxcmkxSGJGU2c2MWpLYVA5UkJ2Y0gxQzJq?=
 =?utf-8?B?enA3VGZDSWZlWHFXMjl2NXZrakl0bnNNK0ViY0RmM1NQQ2Qzc2ZYLzUxbnMw?=
 =?utf-8?B?SUNpTStqTStmUXBpNVI4MVp4TkdISEs0NGJXVFpOTjhybmJ1VzltQXlJMDl0?=
 =?utf-8?B?RHRIeUxucjV1ajdkUWtWamdSRmphYllmN3RhR1NxalluSnZORUxFcUYvdVN4?=
 =?utf-8?B?amFQMExmRnErejhFeHNKNTErUm9ET2dWbWFTcGNBTmxvbU9Bd0dlWlBTR25y?=
 =?utf-8?B?ZjZkUmVpUy9UcnJRS2w5TGFSM2daUzJ5aGpzL05VTml5UUdESzVnVWxkekFx?=
 =?utf-8?B?RWNQbk9aOFcyS2xZckZMWUswY20zZHpIeTZVQU5Kdmd1WCszdmthT1N6QWtU?=
 =?utf-8?B?SVJTNW8wNy9qV0U0VTRUbk03RHBOakREcXR6SlZuVlRDVENnV0F0NFF2dmtV?=
 =?utf-8?B?QXdiempRY0RNZE82OTdxNlpOZTZNdElJR1FZNWdPaFFkL3ArakpTQ3RxaWlE?=
 =?utf-8?B?WUsySjVzZFZ3MHYvNzA1MU1IaHI1dGtqeElsUG9JYnY2dVFtWk1rbTB5THhZ?=
 =?utf-8?B?ekxkeG1jV3Y0dDZxUjNIODh2MnZOMVRwRG5DS3E1NXQyTzRsVkhjT0FnWXhp?=
 =?utf-8?Q?0k1cM3hr1qj1apTAtaqBPgntf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fe5980-9a69-4eaa-d5b7-08dc940fd8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 05:38:16.5224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGBl3ubtiR/DBRKVcBV8uvjAb1f3Leh+eXn/7bqR8HV5HtxArAkrJI9zjDEYZL8JPpEmhgm8MGFIkZbkWACjOSrzcB1P0Wu/Uqvn+v56G/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0845
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

DQoNCj4gDQo+IEhpLA0KPiANCj4gT24gU3VuLCBKdW4gMjMsIDIwMjQgYXQgNjoyOOKAr1BNIE1p
bmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
Pg0KPiA+DQo+ID4gPg0KPiA+ID4gTWluZGEsIGNhbiB5b3UgdGVzdCBVU0IgSG9zdCBmdW5jdGlv
biBvbiBWaXNpb25GaXZlMj8gSSBndWVzcyB0aGF0DQo+ID4gPiBpdCBpcyBjb25uZWN0ZWQgdG8g
dGhlIFVTQi1DIHBvcnQuIEZvciB0aGUgYm9hcmRzIHdpdGggSkg3MTEwIGFuZA0KPiA+ID4gbm90
IGFueQ0KPiA+ID4gVkw4MDUgVVNCIGNvbnRyb2xsZXIgdGhpcyBDYWRlbmNlIFVTQiBpcyB0aGUg
b25seSB3YXkgdG8gaGF2ZSBob3N0DQo+ID4gPiBVU0IuIEl0IGlzIHZlcnkgbXVjaCB3YW50ZWQg
dG8gaGF2ZSBob3N0IFVTQi4gVGhhbmtzISAtRQ0KPiA+ID4NCj4gPg0KPiA+IEluIFZGMiwgUENJ
ZTAgY29ubmVjdCB3aXRoIFZMODA1IFVTQiAzLjAgaG9zdCBjb250cm9sbGVyLiBOb3cgUENJZQ0K
PiA+IGRyaXZlciBoYXZlIGNvbW1pdCB0byBVYm9vdCB1cHN0cmVhbSBjb2RlLiBVU0IgMy4wIGNh
biBiZSB1c2VkIGluIHVib290DQo+IHVwc3RyZWFtIGNvZGUuDQo+ID4gTWlsay12IG1hcnMgYWxz
byBjb25uZWN0IFZMODA1IGFuZCBjYW4gdXNlIFVTQiAzLjAgaG9zdCB0b28uDQo+IA0KPiBObyBu
byBJIGFtIGFza2luZyBhYm91dCBDYWRlbmNlIFVTQiBvZiBKSDcxMTAgQ1BVLiBUaGlzIFZMODA1
IGlzIG5vdCB0aGUNCj4gcXVlc3Rpb24sIHNvcnJ5IHRoYXQgbXkgcXVlc3Rpb24gd2FzIG5vdCBl
YXN5IHRvIHVuZGVyc3RhbmQgYmVmb3JlLg0KPiANCj4gPg0KPiA+IFlvdSBjYW4gdXNlICJwY2kg
ZSIgY29tbWFuZCB0byBhY3RpdmUgVVNCIDMuMCBob3N0IGNvbnRyb2xsZXIgYW5kIHRoZW4NCj4g
PiAidXNiIHJlc2V0IiB0byBzY2FuIHVzYiBkZXZpY2VzLiAgSWYgeW91IGhhdmUgYW55IGlzc3Vl
IGFib3V0IHRoaXMuIEFsc28gcmVwbHkgaXQNCj4gaW4gdGhpcy4gVGhhbmtzLg0KPiANCj4gQ2Fu
IHlvdSBzaG93IHRoYXQgSG9zdCBVU0IgaXMgZnVuY3Rpb25pbmcgb24gVkYyIHdpdGggdGhlIEpI
NzExMCBDUFUgQ2FkZW5jZQ0KPiBVU0IsIG5vdCB0aGUgVkw4MDUgY29udHJvbGxlcj8NCj4gDQpW
RjIgY2FkZW5jZSBVU0IgaXMgZHIgbW9kZSBkZXZpY2UuSSBjYW50IHRlc3QgaXMgd2l0aCBob3N0
Lg0KDQo+IFRoaXMgaXMgbmVlZGVkIHNvIE1pbGstViBNYXJzIENNIGFuZCBQaW5lNjQgU3RhcjY0
IGNhbiBoYXZlIFVTQiBIb3N0Lg0KPiBUaGVyZSBpcyBubyB1c2Ugb2YgVkw4MDUgYW5kIHdlIG5l
ZWQgSkg3MTEwIENhZGVuY2UgVVNCIHRoZW4uDQo+IA0KPiBUaGFua3MhDQo+IA0KPiAtRQ0KPiAN
Ck9rYXkuIEkgd2lsbCB0ZXN0IGNhZGVuY2UgVVNCIGhvc3QgaW4gc3RhcjY0IGJvYXJkLg0KDQo+
ID4NCj4gPiA+IE9uIFN1biwgTWF5IDE5LCAyMDI0IGF0IDExOjIw4oCvUE0gTWluZGEgQ2hlbg0K
PiA+ID4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGksIHRoZXJlIGlzIGEg
Y29tcGlsZSB3YXJuaW5nLiBJIGRvbid0IGtub3cgd2h5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gU2F0LCBNYXkgNCwgMjAyNCBhdCA4OjA04oCvQU0gTWluZGEgQ2hlbg0KPiA+ID4gPiA+IDxt
aW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gQWRkIFN0YXJmaXZlIEpINzExMCBDYWRlbmNlIFVTQiBkcml2ZXIgYW5k
IHJlbGF0ZWQgUEhZIGRyaXZlci4NCj4gPiA+ID4gPiA+IFNvIHRoZSBjb2RlcyBjYW4gYmUgdXNl
ZCBpbiB2aXNpb25maXZlMiBhbmQgbWlsa3YgNzExMCBib2FyZC4NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBUaGUgZHJpdmVyIGlzIGFsbW9zdCB0aGUgc2FtZSB3aXRoIGtlcm5lbCBkcml2ZXIu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gcGF0Y2gxOiBBZGQgc2V0IHBoeSBtb2RlIGZ1bmN0
aW9uIGluIGNkbnMzIGNvcmUgZHJpdmVyDQo+ID4gPiA+ID4gPiAgICAgICAgIHdoaWNoIGlzIHVz
ZWQgYnkgU3RhcmZpdmUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gcGF0Y2gyLTM6IFVTQiBh
bmQgUENJZSAyLjAgKHVzYiAzLjApIFBIWSBkcml2aWVyDQo+ID4gPiA+ID4gPiBwYXRjaDQ6IENh
ZGVuY2UgVVNCIHdyYXBwZXIgZHJpdmVyLg0KPiA+ID4gPiA+ID4gcGF0Y2g1LTcgZHRzLCBjb25m
aWcgYW5kIG1haW50YWluZXJzIHVwZGF0ZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBNaW5k
YSBDaGVuICg3KToNCj4gPiA+ID4gPiA+ICAgdXNiOiBjZG5zMzogU2V0IFVTQiBQSFkgbW9kZSBp
biBjZG5zM19wcm9iZSgpDQo+ID4gPiA+ID4gPiAgIHBoeTogc3RhcmZpdmU6IEFkZCBTdGFyZml2
ZSBKSDcxMTAgVVNCIDIuMCBQSFkgZHJpdmVyDQo+ID4gPiA+ID4gPiAgIHBoeTogc3RhcmZpdmU6
IEFkZCBTdGFyZml2ZSBKSDcxMTAgUENJZSAyLjAgUEhZIGRyaXZlcg0KPiA+ID4gPiA+ID4gICB1
c2I6IGNkbnM6IHN0YXJmaXZlOiBBZGQgY2RucyBVU0IgZHJpdmVyDQo+ID4gPiA+ID4gPiAgIGNv
bmZpZ3M6IHN0YXJmaXZlOiBBZGQgdmlzaW9uZml2ZTIgY2FkZW5jZSBVU0IgY29uZmlndXJhdGlv
bg0KPiA+ID4gPiA+ID4gICBkdHM6IHN0YXJmaXZlOiBBZGQgSkg3MTEwIENhZGVuY2UgVVNCIGR0
cyBub2RlDQo+ID4gPiA+ID4gPiAgIE1BSU5UQUlORVJTOiBVcGRhdGUgU3RhcmZpdmUgdmlzaW9u
Zml2ZTIgbWFpbnRhaW4gZmlsZXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIC4uLi9kdHMv
amg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICB8ICAgNSArDQo+ID4gPiA+ID4g
PiAgYXJjaC9yaXNjdi9kdHMvamg3MTEwLmR0c2kgICAgICAgICAgICAgICAgICAgIHwgIDUyICsr
KysrDQo+ID4gPiA+ID4gPiAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvTUFJTlRBSU5FUlMg
ICAgICAgIHwgICAyICsNCj4gPiA+ID4gPiA+ICBjb25maWdzL3N0YXJmaXZlX3Zpc2lvbmZpdmUy
X2RlZmNvbmZpZyAgICAgICAgfCAgIDkgKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvcGh5L0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gPiA+ID4gPiAgZHJpdmVy
cy9waHkvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4g
PiA+ICBkcml2ZXJzL3BoeS9zdGFyZml2ZS9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgMTkg
KysNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3BoeS9zdGFyZml2ZS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgfCAgIDcgKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcx
MTAtcGNpZS5jICAgICAgICB8IDIxMQ0KPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+
ID4gPiA+ID4gIGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtdXNiMi5jICAgICAgICB8
IDEzNSArKysrKysrKysrKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdXNiL2NkbnMzL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ID4gPiA+ID4gPiAgZHJpdmVycy91c2IvY2Ru
czMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ID4gPiA+ICBkcml2
ZXJzL3VzYi9jZG5zMy9jZG5zMy1zdGFyZml2ZS5jICAgICAgICAgICAgfCAxODQNCj4gPiA+ICsr
KysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyAgICAg
ICAgICAgICAgICAgICAgICB8ICAxNyArKw0KPiA+ID4gPiA+ID4gIDE0IGZpbGVzIGNoYW5nZWQs
IDY1MiBpbnNlcnRpb25zKCspICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPiA+IGRyaXZl
cnMvcGh5L3N0YXJmaXZlL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+ID4g
ZHJpdmVycy9waHkvc3RhcmZpdmUvTWFrZWZpbGUgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4g
PiA+ID4gZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC1wY2llLmMNCj4gPiA+ID4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC11c2Iy
LmMNCj4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvY2Ru
czMtc3RhcmZpdmUuYw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBiYXNl
LWNvbW1pdDogMTc0YWM5ODc2NTVjODg4MDE3YzgyZGYxODgzYzBjMmVhMGRjMjQ5NQ0KPiA+ID4g
PiA+ID4gLS0NCj4gPiA+ID4gPiA+IDIuMTcuMQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFRoZSBjb21waWxlIHdhcm5pbmcgYXMgZm9sbG93czoNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbQ0KPiA+ID4gPiA+IC9ob21lL3VzZXIvc291cmNlL3Ut
Ym9vdC5naXQvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmM6NzA6DQo+ID4gPiA+ID4gL2hvbWUv
dXNlci9zb3VyY2UvdS1ib290LmdpdC9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOiBJbiBmdW5jdGlv
bg0KPiA+ID4gPiA+IOKAmGJpdG1hcF9maW5kX25leHRfemVyb19hcmVh4oCZOg0KPiA+ID4gPiA+
IC9ob21lL3VzZXIvc291cmNlL3UtYm9vdC5naXQvaW5jbHVkZS9saW51eC9iaXRtYXAuaDoxNzA6
MTc6IHdhcm5pbmc6DQo+ID4gPiA+ID4gaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g
4oCYZmluZF9uZXh0X3plcm9fYml04oCZOyBkaWQgeW91DQo+ID4gPiA+ID4gbWVhbiDigJhmaW5k
X25leHRfYml04oCZPyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiA+ID4g
PiAgIDE3MCB8ICAgICAgICAgaW5kZXggPSBmaW5kX25leHRfemVyb19iaXQobWFwLCBzaXplLCBz
dGFydCk7DQo+ID4gPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+DQo+ID4gPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgZmluZF9uZXh0X2JpdA0KPiA+
ID4gPiA+ICAgQ0MgICAgICBkcml2ZXJzL3VzYi9jZG5zMy9lcDAubw0KPiA+ID4gPiA+IEluIGZp
bGUgaW5jbHVkZWQgZnJvbQ0KPiA+ID4gPiA+IC9ob21lL3VzZXIvc291cmNlL3UtYm9vdC5naXQv
aW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmg6MjYsDQo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICBmcm9tDQo+ID4gPiA+ID4gL2hvbWUvdXNlci9zb3VyY2UvdS1ib290LmdpdC9kcml2ZXJz
L3VzYi9jZG5zMy9lcDAuYzoxOToNCj4gPiA+ID4gPiAvaG9tZS91c2VyL3NvdXJjZS91LWJvb3Qu
Z2l0L2luY2x1ZGUvbGludXgvYml0bWFwLmg6IEluIGZ1bmN0aW9uDQo+ID4gPiA+ID4g4oCYYml0
bWFwX2ZpbmRfbmV4dF96ZXJvX2FyZWHigJk6DQo+ID4gPiA+ID4gL2hvbWUvdXNlci9zb3VyY2Uv
dS1ib290LmdpdC9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOjE3MDoxNzogd2FybmluZzoNCj4gPiA+
ID4gPiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhmaW5kX25leHRfemVyb19i
aXTigJk7IGRpZCB5b3UNCj4gPiA+ID4gPiBtZWFuIOKAmGZpbmRfbmV4dF9iaXTigJk/IFstV2lt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ID4gPiA+ICAgMTcwIHwgICAgICAgICBp
bmRleCA9IGZpbmRfbmV4dF96ZXJvX2JpdChtYXAsIHNpemUsIHN0YXJ0KTsNCj4gPiA+ID4gPiAg
ICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ID4gPiAgICAg
ICB8ICAgICAgICAgICAgICAgICBmaW5kX25leHRfYml0DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IElzIHRoaXMgc29tZXRoaW5nIG1pc3NpbmcgaW4gdGhlIHBhdGNoIHNlcmllcz8N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IC1FDQo+ID4gPiA+DQo+ID4gPiA+IEkgaGF2ZSBub3Qgbm90
aWNlZCB0aGlzLiBJIGp1c3QgY2hlY2sgdGhpcyBpdCBpcyByaXNjLXYgY29kZSBkbw0KPiA+ID4g
PiBub3QgY29udGFpbg0KPiA+ID4gImZpbmRfbmV4dF96ZXJvX2JpdCIgbWFjcm8gZGVmaW5lLg0K
