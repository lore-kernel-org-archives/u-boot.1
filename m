Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E5CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0807803C6;
	Tue, 12 May 2026 11:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ZdnF2InF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CC28394E; Tue, 12 May 2026 11:15:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7653980398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY3/kPxSBTBltZ4lmxNwdvtR9YaqZxf//A1kuNb/wFqfbSpgF000ZCz/V2bFE0I7I5/YkkNOZlKwbMUSaXmL/Xgu7LmboVEykC8FnhbqIlg+oPofwL7p5dSU7RXIgXMXjPEKn2c7GLgVL+5BMw47dQUPvo2NohdkuUCinjd5HLVz0oSsL+Q7FJkGUIznt4Z2Ge4g30ZknWJ7k9DL5yZD7aG2PzIHWsGKucPZrz3NkOluvpHZdputHIFyc6txFBN5ykItjYEqAFTc2NApv2pnB38RQiTsh4+0Gf6XcAsfs/anyywirhWELk1dooKHoHGae/7ys3Uq+Xqqb/g+4Ne9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taGDwXij9Ldwp1xaDJEu4vjxjPAwjFFgAv/gohaJOBI=;
 b=cQgpmCAAgc37z9OZZ6NxfcZouuB9pTEYFIVaEy2IVNyHUqesSTyAnTMoqtDZKi1ctmg1C36whysosd/J2luM/T68ggPEtncOdxeUskSBnjZzcXmzMhx2kxoqa76tE6NfjzSjHfBvV0HHfkVYwsmm+M8FLWWX4MdF8EpPD46zSnosIcw9H63k2Ye7JI+vbDm9J98whI1d9DWENq8r4HpaMyNfaXbgdPMk33jippTZUOPuuJGg2Lq9eTnlq6SyCceIujVaxuP/XlFqaWNuG0zHmJ+x3gehXlIqJwXn0fiIMZtWhSij9BS0s0qK3gLc3fG2yyJZCUq52TMb77h4b0029g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taGDwXij9Ldwp1xaDJEu4vjxjPAwjFFgAv/gohaJOBI=;
 b=ZdnF2InFlNgi7RruNpG9THSUho2Lo6raYCBTXIBRy/3gZCK8ljrfD4gJRNZGQE+c2+6gcMgYIzyT8A581wOumiFiF3Vc17q8YchenbrIFiFm6OuI52x9JGGGtkhhCqfCiOYEjPreLg/gKtEjQzEMWmScDE7zErWcfMX1hOqBH5J1Ula9YQ4NdqgI/YVXRWFGfzIg4vr6a9xJ6tu33gTZ5tcH/TUTYkPTUVenNBYXX7yN0+5rGYmMDXHqExx9miU1at1yxFReAFMzL8+HfKVJyuR7qQXHKfzMH1Y4+7K710xAkFTvEXKEglSKxrxqJMSSO6UvkBulQaK+wttRI72W/g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PR3PR10MB4095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:15:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:15:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "u-boot@ew.tq-group.com" <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 8/8] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
Thread-Topic: [PATCH v2 8/8] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
Thread-Index: AQHc4T9B7XN+MpGJGk6MC7UftdQ2J7YKHSgA
Date: Tue, 12 May 2026 09:15:08 +0000
Message-ID: <a1157d3794f49750aa51aa147057c7a3ae2e1a41.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-9-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-9-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PR3PR10MB4095:EE_
x-ms-office365-filtering-correlation-id: 17845fc9-d5a8-4eb1-5e1a-08deb006f6cd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799003|55112099003|38070700021;
x-microsoft-antispam-message-info: e7vLuRX3KsFYp06R+he9z0ILqTwi+P73dgzVEIUd4RILTQJOxRuNYIfJPTY202oFvqH5V1OIpXKVbbl1nZuvsxjfrIxw3WcZV2Bo/cOyQ1nCezdMJo7wY8BpNdfBHUdgT7lDu/++utv16nOnE5oY6wY68P2y4g8e1yZBZLX/h3g3jzw7ogiL7++OXow7Sget1jnQXYafwGboOnEWMOa3EwObwyjL8TIZVmFDRXoQkAW8FnJhkmQMgCLMaxLFoA7LnFUb6RxPQvfI8MvPX70dTSIlt02yxslUvJmmShu6X+MChzFWFKVm85yNM5yboWOTJrgbSwHmBr+zVGYoWX7CG+/X/bTsaM+ZUIMiBJnRYR2Q4O+imEB7kHoWzytGKbh60nP2xcpLyWFNzOaIX2gCsNEi0D0hAQjSJOLQl57exD7cKDhizc+Q/BKU7p7Kki2B4yTlXcGk5IZeYYIHCGqBV5i+ZUlrBhp3zcKKUJda2u3DtZv/6rxWx2LrhQafy2HIvy2fda+Uo72BZbDMtlq3MBCPb1TDI1Q32CL/HKwGYHLQ97QzhLbU5XufYDbQQu+LiPMOBQrO/fXzsgcMeefBSFRMGFJ79vgVfYg+tuU/AzLjRMnymgpOgx0V+L+4J+tLI//6otqcRzPTmQqEj0YQ/mnZ35h4jb0agRtb68R3mqzUkGlXSIoqUEt6sZ+Z9f+eK7Ws25N7MHbaSwRnMkLVcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm9iS1dDeUdwTVBmSWVqMFJRUitlcWpkM1RqSi9SVDBzLzE4OHJnd2hMZVNx?=
 =?utf-8?B?NkU0bVA0OHRtT1RTNTFoUXpiazQ1K3VDRVVOTWZXdldiZWdYM2xlUmt0aWJk?=
 =?utf-8?B?Q0d5SkNkaXpVbW1jSUllVjg5Um9SdlRzUnVUSldTakZ5cmk4Nko3R2dNT2lj?=
 =?utf-8?B?Qzk4TTh4UVBIblVMdWRmc285dmM0WGJzeFNqbDh5U05BLzdqSmphS3NqVmVr?=
 =?utf-8?B?enZDbE56ckVHZWF1ZE4wYUR0S1dhNi9JUlZiS25JeVdrZVhDSVI3eDBKOVUv?=
 =?utf-8?B?KzBOa3R2cHhuV0FVY2o3Z3JxSkxMMXdFekFja1c1cTZMNUQ2YW9kazBNS2ts?=
 =?utf-8?B?dGo2UDY0TnozdnZCbktHem42a1pKa3VWWnRqRHRvbUNxZGliVlZLMks3UEJK?=
 =?utf-8?B?a1oyUEJ6Y0NYUWwzWlc4STNlbmZHUVlRSm16NTdtM0QzODdJK2ErdjFvdWhk?=
 =?utf-8?B?UGw4R2NxeEJuN3Q3UEwwSmowSzRnaUExYndRU3UxM3Q1cXBIWkVSNHNMZk9i?=
 =?utf-8?B?bG9ObVM0dXlWcHhpSEJWNG1yYUN5d01ZK29adnE5aVdPcjB6U3lhaDZ4RjlJ?=
 =?utf-8?B?ZWlzdUVQa2lKN1NqeWV1bzRCT2ZxaGlRVVhHRHFlS1NVZ1d4NDhkVFZDV3Fz?=
 =?utf-8?B?VG42aWdDZHBEalExWkxWRWZxYjZXcWVka2FOWkFBY05ad1oyald1NHR4WEhv?=
 =?utf-8?B?Yml3aHNpQXd0ZDFZSEkyWWdtbTJRQlVUY25oblhvVEljQUtKL2hIZ2pQTDBv?=
 =?utf-8?B?NWxVQ2pTZGtJUndXOWpxNnM5ZENIUkdmVXFtTWIrRXlHbzdrb0V1VVlJdVYx?=
 =?utf-8?B?TTBxZE0xa1dVb1B5aDIzZ0JzZTlKVHZsenFCT3Ayc1dXZThmQ2xyOVo2Tlpw?=
 =?utf-8?B?MnVYejAxbWx1aXBJMmtqZmxNdEM2NlJBVlBNQW1xVnBrd0ZuZkcrM1UrcXJT?=
 =?utf-8?B?WlRVY1JTZDFoQnZhOEJoWHh3RmFBa3hEMFl1ajBROHhlOFd0MzRDL2tyS3I2?=
 =?utf-8?B?V0JMeWlVSnhTNStLNnF0OS9yT1piL3NwUGdJTzNvVTUwakNzRWVuUURoMVhH?=
 =?utf-8?B?QU5BOUFxbGt6Wm9yMU9ZMlFzVnJoQmV0dlJGUnNmOWFPNGxncUtBcHE5Y0Vs?=
 =?utf-8?B?Q212dEZsVDcvcTUwRm82Vk5IOWRWNTFuNXdlOHdaSVY2WndZZ01wZU12aE1k?=
 =?utf-8?B?WUlQV1NXOUpFWGNOeUhZbURmWlNuWFVhdlNLUnA0a0ZBQkdaWmxHNC9WREl1?=
 =?utf-8?B?dEVHa0lpZzhsYll2clN2Z2x5KzJ6ekZGQ05qVW9JT0FaNnZwZUg2SklNbmNL?=
 =?utf-8?B?SmZlaVYyYjRQYWJWSjl3VGNCK0wwMk1zL0F5dmpEbklYS21STUdWekJEaGR5?=
 =?utf-8?B?bmQxZTlRcklXd0hwRisxYkVWdkpMVHhPRFRRQUZLZXFMSWNhSHJOck4yUmRs?=
 =?utf-8?B?MHoxWVdCTWh0eHBhVERIb2dmU2IzTThwTzNjdDQ0UlRObklpVlJCbTduREhU?=
 =?utf-8?B?dWp6WUlkc0NWU2hmNlZPNXd3ZWNPQStoUldVWFdkOTVSTS9hNlZ1SXF1bTdI?=
 =?utf-8?B?bjB5d0hzOUlrL0haRTVENEMwSEVBd2xWb2dLWFR3c3QxRUNFekdaNkJkaXc5?=
 =?utf-8?B?d0c5eVZUb1dhY1EyeUhTQTFKVVBHNUxaQ0U4eUNlcWYwUGxZbWhSRm1HZjNk?=
 =?utf-8?B?R25UOUJPak5DV3hXSTc4QnptdHZCMTBXejQ3b0ZYbTJqaGoyTWRpeC8wOWNU?=
 =?utf-8?B?SmZ2VVAyTXkrakFNS3hQa3hlcHFOamJacVhlQVIzYmVFOEl6SHFPbU5DQmxW?=
 =?utf-8?B?THEyMnJiSlRMd2piSnJsNDdwR085cDRXUDRlWGZGbGd6M0dxbGpWNmpwNE9n?=
 =?utf-8?B?dEVMakZVd2p6Tm1RSnpFMTVFd3owZGFYaG9md2NSNFJUbTB4OEdZMEo1TThF?=
 =?utf-8?B?bDloODEvUmZ3VGwvQldtK0MzNXAxdVY4cVBGL1EvdTNpU3VnaWxJQTV1aEE3?=
 =?utf-8?B?aVcwbFhnRWwzdmdtb2NjY292dE00a3JvdThpdXBsMm8yV1BLWTJhY2kxVGkw?=
 =?utf-8?B?Y1NQZmFhZ0c5cVIxV1JXZ0xoODM3Q24rbVN4MUs1cTdYYzZPNXU4bm1Qbk4x?=
 =?utf-8?B?ZUd1bThsYk1kMEVGYllRTjE2ckcxRVgvNUlvNnRNdWdna0k5TzhrQWVFbmFz?=
 =?utf-8?B?bSs0VHBBdEVMNVErcHUwNko4NS8vRGNhMEw5dVY5S2xZdFhzSTRyQjc4Ylhw?=
 =?utf-8?B?aXJOWmh4Z3FHM0VMMGVTOGRjdytTR3dlbGNPRmtCRXJRR2JaQXloV2FxYUFn?=
 =?utf-8?B?aXd0SnV3YU9ocnBVb2hLOG5WVkN4ekJiM0dnZlpOcFJXdmwwZjRnUHBJZUNS?=
 =?utf-8?Q?9xoLg8HqrnrIY4edqGr0yvZVlw5gHm3gOtOGH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF04FB74809AA843A64C3F75F246F44F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 17845fc9-d5a8-4eb1-5e1a-08deb006f6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:15:08.9802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b/8wC2izFSyslkL3EkXq4EXg3DBL5qn6do+IhKR0+4C13OPyPwseyyFVYjIyEH+a5d74aeoHDsYFnn1R7TQ3Dhm8RWe8iCMwO53HVMRG0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4095
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

SGkgQWxleGFuZGVyLA0KDQpPbiBNb24sIDIwMjYtMDUtMTEgYXQgMTQ6MDkgKzAyMDAsIEFsZXhh
bmRlciBGZWlsa2Ugd3JvdGU6DQo+IEZyb206IEFsZXhhbmRlciBGZWlsa2UgPGFsZXhhbmRlci5m
ZWlsa2VAZXcudHEtZ3JvdXAuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEZl
aWxrZSA8YWxleGFuZGVyLmZlaWxrZUBldy50cS1ncm91cC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZl
cnMvcnRjL0tjb25maWcgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9LY29uZmlnIGIvZHJpdmVycy9ydGMv
S2NvbmZpZw0KPiBpbmRleCA2NWQ5YmY1MzNjYi4uMWM3MDNjMWUyMjkgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcnRjL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9ydGMvS2NvbmZpZw0KPiBAQCAt
MTYzLDYgKzE2Myw5IEBAIGNvbmZpZyBSVENfUENGODUwNjMNCj4gwqAJaGVscA0KPiDCoAnCoCBJ
ZiB5b3Ugc2F5IHllcyBoZXJlIHlvdSBnZXQgc3VwcG9ydCBmb3IgdGhlIE5YUCBQQ0Y4NTA2MyBS
VEMNCj4gwqAJwqAgYW5kIGNvbXBhdGlibGUgY2hpcHMuDQo+ICsJwqAgU3VwcG9ydCBmb3IgdGhl
IGZvbGxvd2luZyBjaGlwIGZlYXR1cmVzIGlzIGN1cnJlbnRseSBub3QgaW1wbGVtZW50ZWQ6DQo+
ICsJwqAgLSBOVk1FTQ0KDQpJJ20gY3VyaW91cywgd2hhdCdzIG1pc3NpbmcgaW4gTlZNRU0gaW1w
bGVtZW50YXRpb24/DQoNCj4gKwnCoCAtIENMS09VVCBnZW5lcmF0aW9uDQo+IMKgDQo+IMKgY29u
ZmlnIFJUQ19QQ0Y4NTYzDQo+IMKgCWJvb2wgIlBoaWxpcHMgUENGODU2MyINCg0KLS0gDQpBbGV4
YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
