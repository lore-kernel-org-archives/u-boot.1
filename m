Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8EC87E4D;
	Fri, 12 Apr 2024 22:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VXEOHpCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB82881FB; Fri, 12 Apr 2024 22:31:16 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B567B87DD3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmH+ne1NzUpSfHZ6bCM3mP60jkm+u/1S4QrBigdTeD36ItyfTJwt1BtAbfDpPBYYnj709oSgjKwsVISQbSCgYKFSZo8JsID6rNfFFgFOnwxD0dvYEHwArahAm4BVvDhjtbNZ2nIy9+320hZwI/SoxUEpwXAQmjfRgZetXbLXkfU3AQrgySMVPcVXYQ+Y7gbpora1l9Jmp2U/OVgQRQQ4dmfVXfkmnLIGHrAyxxjYHU06iflJluYtSBKSk4a0BCJfduQB3yXuxzsN9XQL31JykmP7uzsQBEI5OtUZBHqPXb6KQY5KmxhuDV88HDY8AE7QXetjxCSfy4XKwT8MsN0FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA5Zxji32L3wQpo2395rUrP1AllgkFlFy+PrOSRiZMg=;
 b=EfNRYsY0wvEFCFZ38SfxdtCNUTWlgX/naxsMdVR5iZA+ZbTVtSg2ami1uzfpMD+FFaPoayygXX7qZA6tasuTyPnfWepznXDpHCu48RqFp3Y9AJBkPKPyQo8xBgtShNPUitVPgTMrW3tXQAfOv4xhDlqI7r9SoN3zy8PMj1diacO/JasXVsQWj9/HueihANhobvG7XTC3P4KedMV2CMPOSBRQf6w7y9nf/xpzL0PloHlD21CboRsCJMPFTIV+wtYTu9xlveoJf2NjcWYoLSLnj5+USQqzTlr5+tJZojuyZi/Z3siqIm2C1WGPyW73ikUKmTp32Un9t+fk71SIDNYgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA5Zxji32L3wQpo2395rUrP1AllgkFlFy+PrOSRiZMg=;
 b=VXEOHpCdis4d5EiIvL9zqrma/8piWbbNKuTepMIinX3vAAWIlLBpvkRQWRpazWny/OzXHrdNdYr+g7BwZSmPXkH36oG8VFCojnM7xSZ9VRTxF8laOA3DhM/9g1x9NZ0fRuFFZCZvLdN2tVjz7OYDdr/HLDRHxc63Bqzm391UcTdADO1v6IqW7nZDYEUdyMHIbfKhN+W9V+3LSerkBV5CjbDAmnSEJaEz4w90orTZVnBCII9CX2LKbjiwtRdgg3yBpYgBb301tcCkPhoFPQ+E2493T+lSb7RtuLB8YL9R5LDsoVXHcJV6pXu3VxV/FUlo1CajIgH5NFGiPc8Uj6tBTw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:31:13 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:31:13 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>
CC: "vigneshr@ti.com" <vigneshr@ti.com>, "d-gerlach@ti.com"
 <d-gerlach@ti.com>, "afd@ti.com" <afd@ti.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "nm@ti.com" <nm@ti.com>,
 "martyn.welch@collabora.com" <martyn.welch@collabora.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "rogerq@kernel.org" <rogerq@kernel.org>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v4 3/7] board: ti: am62x: am62x: include env for DFU
Thread-Topic: [PATCH v4 3/7] board: ti: am62x: am62x: include env for DFU
Thread-Index: AQHaRTThuu5IqTIXXkufCmqsnBzCRrFlpk0A
Date: Fri, 12 Apr 2024 20:31:13 +0000
Message-ID: <5ae050879f42090e004b4f37da4001284e1a0b4d.camel@siemens.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-4-sjoerd@collabora.com>
In-Reply-To: <20240112085317.1866449-4-sjoerd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3912:EE_
x-ms-office365-filtering-correlation-id: ac3dbf73-7e5d-4fc9-e028-08dc5b2f7f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKeJu4CD9tC7k8qdEwcgiLGjrXjBSIYs3IQr2xmQEfOriFHK5cFE7Y0pgnG2vhfNzP674gzqsP0OtFDjJzuAMu2v6oxrtGjfDmaOPRx1lgGH2WZbtLgt6+zNXMOA8odNeD5uUEPBk3Vjaj8HHkWtzxXSclKlZnCRQOG5B1l+pgqANKzRd2SSedWypiQlGYZx5HoT7RcH1eewCeeXeB4xaH3l+IentHZf0tpdzB3R0LvO9utdbuuD/y32+7A8BV+Q4tNrqW4tBRNz9U5G2E30ajrK1Gh2t8EBl4pvv7LOV5XaC56gwu8p7JtutRvKC11H6SRviKL34UdeAXiSlGmV3F7x4/jR/FjndNehFzH0+uU2aVBq0pcXASGpdPvbJvqfWb4H1J4/QTzek4tlunCq+0QuJ02TWdZ6gWpbtBmXlf16SKFz5AgfxUByjZlNeFE5d3AXyKDuuPTYgTJTDuyRtefOd0oEWXrfBP+se8puFXz/Q7Tp66tTsREc6Yifj72y9/7KI180IcZGDEoZw/YW5FDFp3q90p56W5OkcK2qW2IaMGtq3eZ6W0/Lito4ewHL5eD54XGfc+cAAs/dQ0AatHE7FgvLHJeRu+vSfcHUTdEYDJ8EEVe/wnOuHecH+6Ctal87RtO+SBJUPRCfWNfZbOcTGJhpkXnGab7VBzL+flQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU9mK2g5bWpYZnZSb3llbHQwOWIvNGp5bU9hZ0UwV0l2SEhlTFduN3g4VkZs?=
 =?utf-8?B?M2dpdnJ2VjJZVWNVa29rdzBwVUJjMG9zbHMwUEFXTEwvT2d2dzBQTFU4WStL?=
 =?utf-8?B?bmtvMklIM3Y4S1hveGlZK0tYSW9KWmZvSk5EQk12eUVGNlJMR09Gd29hS1pr?=
 =?utf-8?B?ZkNwc0pXdlFzSTd1ZnY3SnBPR0VBRHpIYlFtemx5NW5lN1dRSG5GMUVtN0hn?=
 =?utf-8?B?cmsvTy9qeGJqNExjNFVjRHdHQU4zL2lRaXRpamtIcmNnd3Jmai9kSzNXOU00?=
 =?utf-8?B?T2g2VmNodE1ES29IN21CVXhSdWF5c0hqWnhHV0V6RXlURDNhakNJa1VSWHhW?=
 =?utf-8?B?NjIzODRCelpGZVZnUEhBQUJ0OHUyVVpSbzFFUnVhV3BFODBMejdjdjUycG9v?=
 =?utf-8?B?cUNnY2haQjVJUEkrNGFaemdpTzliVElYYTA0dlVjaUNNemdCYmVsS0RCMldC?=
 =?utf-8?B?TkxINjQvOWlrSnZRVDVZWHcrQzhmMFJUaWlQa09xbml1cmc5WWZYNEVYUDJj?=
 =?utf-8?B?eU1SQ29LaldSUWlVWkNSczZobU5ha3Iyencxb0thWXJrQyszZzVVd3BXUFhq?=
 =?utf-8?B?a0dEOG1QMkhjWTlrOEJNVHZHNVBxQzlWb3ZLcmRGd3VrWk9MM29qd0liS05T?=
 =?utf-8?B?YU4xU001V2lDM2N0MDh5aUwxNTFva3pXRXptMm10cWo3M3NHNDlsQzBNSkNr?=
 =?utf-8?B?NmIySmlYdVkyTUxMa3JvcFhhN0pIZGVuMG9xdWFBNE9yUUxwSkZ4dzA5M2k2?=
 =?utf-8?B?U0x2RDM0cW9pemdxbXNvalBJK1BGdWRaeDhhRkhLZ0NEdlR2YWMyeU9pSlpS?=
 =?utf-8?B?c2pSTDl3MEErWkR0T0dwRGhtZ2FkRmpyWlJVTU1hTlNyUGhEd2NQMGhTb2px?=
 =?utf-8?B?eHJ2dVFQeXlyZ1IzRldoZGY2T1RBdnZvYWQ3Y1RYdm1UVkp3V1FlbGpWOXdS?=
 =?utf-8?B?eWdZd0JtL2RBeFZhKzFMZ3JJWlJua3c1eTduRUcyUUdWODJLRWp2MFFpYUlN?=
 =?utf-8?B?eUNSQmZEYmtRT0UwOTRkSWxKUVUwdlJNM3hGcFZYK0RzVDJnRUE3Z3F4RmZH?=
 =?utf-8?B?WmIrV0hqQjNmMjBUTTlxdUpFSGptQmNpZlB3M1hPVDFnV0hXT1dEVHNGbUxD?=
 =?utf-8?B?cHNYUmdyeEoxWlRXNVVyeFVwWHB6cHQ1YjROdm5VbFVlbnZlRkh4UWU3WFk3?=
 =?utf-8?B?d3lHWncxTmo5T3hPcUVVNWlzUWhSaTJEVnFDT0RVMnZVYlplU3NRUDVpWW9p?=
 =?utf-8?B?cjVaSHVrZ0tnQzJvWFhhdlQybDFuNTlqeWE5QUdVbVlVK1ExZnR5ZEJtZGky?=
 =?utf-8?B?YWdDMjljbW1HTW5YQVpJMFlRSEtOcjNhRE1QV3hXZjIrUFpISDRPTEVWa1c3?=
 =?utf-8?B?V2dZTGVOTlJKSkhZN1BCNlEzK0tPTXhPVGh4blRPSkRDMWlPNzZlaERJZFVL?=
 =?utf-8?B?YXM4My9Lcnk5aDZkTngwQnh6Rzdjc0VLdStlUUh3V3RuNUcwUHAzTWlrWnBx?=
 =?utf-8?B?M1lmM01uL1ZYOHU3OUswbTYwWWsyVmdoOENqWFM4cWdjaytHNXNvZ3R2dlFy?=
 =?utf-8?B?dFFNSkVwTWVrWFdBQnBaMVVZT21aNGcwTzBPU3FzVno0VFdsSEtRQkJtYTJp?=
 =?utf-8?B?Wkh3S01jck1SUHV1eUg1bVJHNW5lRHIwMlJXWkN1eUhGWCtUeFVyd2dZenpp?=
 =?utf-8?B?Z0E2VVdtanlETGhLczJzN1k1QW9mNTlqbkVUM1JCcVdDMmphQXE2VHptWlpP?=
 =?utf-8?B?czIrOTVENFIvZ2hjWStjV1FBaEZQQVhMbTZuL0g3QmRLaHVvRmFrbkJDODNh?=
 =?utf-8?B?U2xFVzg0VlBUNFFwVzVKV0ZtdDFsRWlNQ0lUdVQ2R2psS0JWUlZnc2xpUEhJ?=
 =?utf-8?B?NkxpbmJwZ2t0cUFaWW1ldlVpZkhGTHc2dUlnYmd2a1d5eXlWSHNETi96ZWFq?=
 =?utf-8?B?RldRMWRMNEt1cXhGUGV0b0dzRUtQOG5iS2RKeStvbWY3c25reXJkK0wvT09p?=
 =?utf-8?B?eUNaZDBXYjRNbExXMjkvV2tYVFdhbUZvZlZKVE03UGNzZ1Y4SU41UEZPVGJW?=
 =?utf-8?B?bDZGNkJQendGSHdXTDhQWG5UQTc5OXJUd0N3akVZelU1eFZRS05UZ0QvbVFX?=
 =?utf-8?B?YjhNNjB1MjNlQzdoeW9OV1NKUHBId2ZYMWhNUU00TkpIVkRiamFXK0pPd2Fm?=
 =?utf-8?B?OEVkbHJ4UDZlNC9zem9aRVdZTGxSSnB0N3NGS0pJR3RKQTN5QTBmYVNkREVK?=
 =?utf-8?Q?mmzFcn9alI1kiKHiYzbIv8qqScNbX8nfDopdTI4fLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <737CD243882CAF4E83BB3CAE558682F8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3dbf73-7e5d-4fc9-e028-08dc5b2f7f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:31:13.2278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jqjUw40UffpaAUicddRx85juDwE24XB+ZoaknaZcvyiDuElcnQ0qrk3vEIRWEmYgPLdiqwS3Z+ci0aTyQ/VW0RQXi33xjIXrH3d96i0Gko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
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

SGkgU2pvZXJkIQ0KDQpPbiBGcmksIDIwMjQtMDEtMTIgYXQgMDk6NTIgKzAxMDAsIFNqb2VyZCBT
aW1vbnMgd3JvdGU6DQo+IEluY2x1ZGUgc3RhbmRhcmQgVEkgSzMgZGZ1IGVudmlyb25tZW50DQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTam9lcmQgU2ltb25zIDxzam9lcmRAY29sbGFib3JhLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IE1hdHRpanMgS29ycGVyc2hvZWsgPG1rb3JwZXJzaG9la0BiYXlsaWJy
ZS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gDQo+IChubyBjaGFuZ2VzIHNpbmNlIHYzKQ0K
PiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBBZGQgZGZ1IHZpYSBlbnZpcm9ubWVudCByYXRoZXIg
dGhlbiBjb25maWcgaGVhZGVycw0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBNaW5pbWl6ZSBj
b25maWcgY2hhbmdlcyB0byBqdXN0IERGVSBjb25maWd1cmF0aW9uDQo+IA0KPiDCoGJvYXJkL3Rp
L2FtNjJ4L2FtNjJ4LmVudiB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3RpL2FtNjJ4L2FtNjJ4LmVudiBiL2JvYXJkL3Rp
L2FtNjJ4L2FtNjJ4LmVudg0KPiBpbmRleCBlNTNhNTVjMzhmYi4uMDY1MWI5Y2Q3Y2IgMTAwNjQ0
DQo+IC0tLSBhL2JvYXJkL3RpL2FtNjJ4L2FtNjJ4LmVudg0KPiArKysgYi9ib2FyZC90aS9hbTYy
eC9hbTYyeC5lbnYNCj4gQEAgLTEsNiArMSw3IEBADQo+IMKgI2luY2x1ZGUgPGVudi90aS90aV9j
b21tb24uZW52Pg0KPiDCoCNpbmNsdWRlIDxlbnYvdGkvZGVmYXVsdF9maW5kZmR0LmVudj4NCj4g
wqAjaW5jbHVkZSA8ZW52L3RpL21tYy5lbnY+DQo+ICsjaW5jbHVkZSA8ZW52L3RpL2szX2RmdS5l
bnY+DQo+IMKgDQo+IMKgbmFtZV9rZXJuPUltYWdlDQo+IMKgY29uc29sZT10dHlTMiwxMTUyMDBu
OA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29t
DQo=
