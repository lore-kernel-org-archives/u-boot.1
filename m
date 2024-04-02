Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC95C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 17:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D681D8818C;
	Tue,  2 Apr 2024 19:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AiViEFSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB3388193; Tue,  2 Apr 2024 19:25:41 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0701.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F3B88170
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 19:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZaQpEnpx8Nn2Bm4bCeTyvuQZMEp4Iu5cUy/Jhr6VRbKxiSAV3prlpjMa4gFPJQaS9exxiCLmYsZR+B+kSDzNdoHPT8OL2QasLQl9IhY7Oz68bfQZeLPa6y4sdQjn+inIue7ll+xQlZZS4ghEaJ/hWa3IBuUer+8ree8BI+6dSOXWa9vEKiJKEzpjKl7hHODFvezFvs5gHQqgMvGeU7VvqdGaMtAd6JTj05JiaJKmSYnOmtPPbS+qax7rXHekBiT689J/wrnKroQxmQmh+iap+x/xYWSY8ghHFQuUDwcWqaNwe7bVtg3gefE/YyLtzwfm0NS4Ts6p1jjr8z/P6Gfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCgQ5OVoQXKJopQThXAxiijYJYXdVBD+llrnnMDaSqw=;
 b=T6WihJ8BbNBpzs95QUvB8t9XcbHVJvR10AjHDL9+UfnSFIYpfiYwzvxOSFnjVe2Vhds31ov00yPeR3A2u46akBvk5eYj/UUw6LaNkBRi0+EhTDBpMEntSqwWqga1cvYCphO/YkXpG6WifnNAy/lRMyffCAIg0BfuVT31mtejK0XoMT6DHwUEEEPtvXUVqcAEV5gzsszWvLr5NHMq3PFhQQnyL/lFkEe+exIg9WkHkt/nr7TujCjcSKhURfrU5XzRH0VydkMhXArcZwjrwi62CGkp++n+4p/za2GEWQEadCPNwiQAB4jxhl8VdqmEqGLFbfs+GbtVQUnxNqhi0GZxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCgQ5OVoQXKJopQThXAxiijYJYXdVBD+llrnnMDaSqw=;
 b=AiViEFSvcPJLVKYSvLDGwFiZkce5DYQcAq9Cn7Y2OWXIcs6XZQ2iHLtm+c4bLhmDaWUl7tbKF9xuQuuMDj9UAlnqFWILKuFYPvcSKFhtduFtFbq9Du8GMX7b9ywutn+/k1/qhf3/wenwtIyXekRYvgibc35NyvqvgfQ9BgtrWaE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:25:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 17:25:37 +0000
From: Josua Mayer <josua@solid-run.com>
To: Christian Gmeiner <cgmeiner@igalia.com>, Fabio Estevam <festevam@gmail.com>
CC: "baruch@tkos.co.il" <baruch@tkos.co.il>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Topic: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Index: AQHagupfeCyR0yAEZkOTDgJ/agaMMLFTNLqAgAIK/oA=
Date: Tue, 2 Apr 2024 17:25:37 +0000
Message-ID: <bd075a6b-6af6-4bad-92c3-2bb6ea28c4ba@solid-run.com>
References: <20240330213555.2889619-1-festevam@gmail.com>
 <e2a4c7068920316b3d631f2db0880235@igalia.com>
In-Reply-To: <e2a4c7068920316b3d631f2db0880235@igalia.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM0PR04MB7043:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zhlja5hzqA8au7PDgM4SYEO1v2/rVgn5czDb1SXMYjXrSspVrWul9KXkrNpPG9G4Q8AE16TAxyNmVR/DqomIYvX+vKK4NMAmxc3pqk2JDN9kVWWpEHmwUS7PGwbTi3D0KOb4x6Z1t4TRi49AHOzlcpfx6t9yW/uXGJ+5xd9TgmnF79tYUSRPfRW2Nau4jzRrkbPfGOlS7r7c+V+H8Ds7qEkbdh3cOyx5WRoklIgKg43GmM3o4Oh9sM9s1kASsJyLzvIqXEBN6rKsU7R2ZUKKc+KdwWsWtEe1v2nSELJ5X0yRscgFuiTIDMAE7r2y37U00hbSQ4BvsoJWxCg/SlzmjIZlFLzsrBIYC1xfh5wjd54S5q/KO2kvu+ZHqo7BVtk5PzeMXzOPEXboA8tgiiNEggMsqhXGwNiAmd80KmYajETPN6N1mrKjtBdyQFv4wxbCr4l2cyan9ba8G4hJr84nfCY0lQ71dEU8r1/fZXmvmuSjkekmANDQx2I9ejADWXb8nnmVJtjG5DaPxSedM63DkJN9/4h7XekrMV2JEn+oHL3c4WYUcDcwEGX1t5oWl230iBpnchr5v+zYPjTsiEc0r1RL0hO/xREk3Nnh831RDBfXuYTgKPOhbgbRMU4HW1j/7cJJs0eWuTS5MlcUw3Ei2QeZeIJXBcOw/YLGVF89CE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1ltNDhaSzNhNCsya1FLSUZLTk5hcFdKZ2tlZFRxbkNNN2tCMndtSTRVenZy?=
 =?utf-8?B?YXo2c1VaYjFGZ0VFc0RPd09hNndkL2ZlOW41VS9WbWhCOU93QitYK0ZQTm5a?=
 =?utf-8?B?WEd5bEQzeW9GamZRdkM2L1dHK2JXUFZzcUFBb3RTOGJ6M2EzSGl5NXNpSnNN?=
 =?utf-8?B?MFVDMk1JVXNpSFdVN1BhUlE3b3M4NUdMUWJPQlpPc2p2c3dYMlp0Z2hUUkVa?=
 =?utf-8?B?M1p6WTZLdytieEdpa1MzWGN0RWhqTWQzekxaajBYOWc1NXdqbDRFNFNMZjlq?=
 =?utf-8?B?enhLWTRWWlBaellUbGh1L3RTUEJFUW1mRElCMjZPVnhZbzdBYVF0N2NwdjFr?=
 =?utf-8?B?UHBkcEUzaUhxdFZMWDJaa0tZT05samgvYUFWRDhIVHJmVmQ2M0lCZ2pHQVFJ?=
 =?utf-8?B?d1BOVmdCb1IxdFh3Z1ZDUTlNZjZEOEpkMWd5U216V3pvRVc4b3VUMWpxNDlO?=
 =?utf-8?B?cU5iNzNsQXh0dUZvVXg0SkxWZ0ZIb1dTZUJlalpUWXhRZzcrRlIyd2VNdmsz?=
 =?utf-8?B?T2NZTGFYMWdSYWdQbDYxN2p2UitlWXRCWmdYdWZkUHkrK3lkWitQNXovWWFn?=
 =?utf-8?B?K2NjYlBsbnczeFZOc2VsNmJmeithMDI5NWRPNUFhcG1DZThYenlsakpSNVRH?=
 =?utf-8?B?d1NCV3N3eU9EU3Q4cTFiMTBNQ01SSFd5aEtUNUlIM0VjM1VzQkN4dzdMeU5T?=
 =?utf-8?B?WnJjL3NMYmpwbWZXVTFiSFNvaGo4WE90SFhRQW9qRUtmTkhtWmNtcGVHVTZE?=
 =?utf-8?B?WktaM2x6WS9lYVJZc2VwTldaTTFDdDhFL1lTLzVKNytpdytiem5TUEVTa3h2?=
 =?utf-8?B?Z2R2MmtPZG5qWSszaFoyVEozUnBUMklmUzRGSE1hZ0wvdkRVZ1FDQzVNMSs1?=
 =?utf-8?B?VEQ2ZFdhMkdoWGc5aFppcnJxNGR2dWQ1R1NmRzZRUnhNMVIxWUY5alNhbVhJ?=
 =?utf-8?B?c3RPWCtoOXdlcW5Vb2R3dktpamlEdFAzTGxYYXR4VnpwVVhvUEtFb3JjWXNK?=
 =?utf-8?B?NlBYRHE0amhpOUVSVEpYMUozc3I4WnpyUWNHT2dqTDBRVlBZcUQzcDBtLy80?=
 =?utf-8?B?cmlHWHdOMm5HcVpXcm9CSC9OMk9XVm5TZTNYU1B0STVSWUh4VHFMYjhVaHRM?=
 =?utf-8?B?bDNIR20reEViY1d2TGRLeFVJaU1WNGFxYUlFbTNvL2NoZldKeDlmdGxGTVho?=
 =?utf-8?B?MGN3VWR4dkdjTU03dzRTWGFoZDFLTlM2bXcwaWFKTTV0a08vdG5IYzVsclNH?=
 =?utf-8?B?bG81Yjk2T0FOVCtZRjZKN2pzdllEdWF6Y0oyK25QM0tVNWxlbWdhSlBpcXkw?=
 =?utf-8?B?YzZWeFByYXBOMWorZGFSd3RqQUlnVTVIVGk5clZHRm5UaTgxekt4eTc4Ymcr?=
 =?utf-8?B?TkNKd1NlWUpJVDVtQVEyRk93THBZL215YkxjSnptK1Zta0VRMzgxTnNhR1Ba?=
 =?utf-8?B?c2pPejdYa3N5cU1WbDNycUpUU3M1dG5PaWhUaWxwN0ZvMkJoMUp2NXVLYW16?=
 =?utf-8?B?eXdkMmF1eHF0bU1ua1lTWDhzOUFkR3VDVnZ3Q3NLQmxpTXV4Y3lDY2l0ZURs?=
 =?utf-8?B?aTkxZnBkMFF6b1hYOFRDWVM1by9QY25hZWdWUy9VK2g5TnV2RFZwYUcrTzFa?=
 =?utf-8?B?NDBWb25sZDhjaUZIZVNqdVB4cWN4MGllektHM0Z5TTd1c250TkVHZzdROENG?=
 =?utf-8?B?QnByTnRXcFcvQzBVdDlBdGtYSit2TWppLzBudFBja2I1dUl1bkJoQ05qTHVV?=
 =?utf-8?B?OHNrVk8yMjNKMXpxMGgzVXZocjBCUVFEbmtkZ1RabTBWMEMyMU5kTk5DWkZQ?=
 =?utf-8?B?VDMraHcrRHBhWWhOdXVaRzhSdjJ5V1RjbG1qais1aGUza0pjdUI3ZWhnaERv?=
 =?utf-8?B?ME5zcExKaXNyRSttT3ZFY0E5WmVCNm1xTDRCd09pZlFZM09HejdBemZLcVRl?=
 =?utf-8?B?N1MxcVc1ZzF1dXBwL0RHdlRFVXhCWEJWZzlycHI0RGYyam9VWmlnWStQUTFM?=
 =?utf-8?B?RG84K2NnVmlHaVNKTmhtcGxRcjRHc2dYR0ZhdEtEcGlSK0FsU3ROWFBweTMx?=
 =?utf-8?B?cXRnbWhUc1NwSFlVaHVzTmtXeUEwaEJhTVBjVWoyNTRFQ0s1b0JlSEtjZXR1?=
 =?utf-8?Q?dQR8JgMZf+wX7eG9lN3yuyVnz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1409C3A844F4664DB9B4BCC88CCEED56@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5e164e-4385-4a9b-bfcc-08dc5339e99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 17:25:37.7101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22sp7gEzb5YoCnCTFCMsVRRdnUGpyaSIT535l1BayVIawMB9yuklJ5Eq3iel0YkRZcDuDjD95m4qolxdsAuMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043
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

SGkgRmFiaW8sDQoNCkFtIDAxLjA0LjI0IHVtIDEyOjEzIHNjaHJpZWIgQ2hyaXN0aWFuIEdtZWlu
ZXI6DQo+IEhpIEZhYmlvDQo+DQo+PiBGcm9tOiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVu
LmNvbT4NCj4+DQo+PiBUaGUgaS5NWDYgQ3Vib3gtaSBhbmQgSHVtbWluZ0JvYXJkcyBjYW4gaGF2
ZSBkaWZmZXJlbnQgUEhZcyBhdCB2YXJ5aW5nDQo+PiBhZGRyZXNzZXMuIFUtQm9vdCBuZWVkcyB0
byBhdXRvLWRldGVjdCB3aGljaCBwaHkgaXMgYWN0dWFsbHkgcHJlc2VudCwNCj4+IGFuZCBhdCB3
aGljaCBhZGRyZXNzIGl0IGlzIHJlc3BvbmRpbmcuDQo+Pg0KPj4gQXV0by1kZXRlY3Rpb24gZnJv
bSBtdWx0aXBsZSBwaHkgbm9kZXMgc3BlY2lmaWVkIGluIGRldmljZS10cmVlIGRvZXMgbm90DQo+
PiBjdXJyZW50bHkgd29yayBjb3JyZWN0LiBBcyBhIHdvcmstYXJvdW5kIG1lcmdlIGFsbCB0aHJl
ZSBwb3NzaWJsZSBwaHlzDQo+PiBpbnRvIG9uZSBub2RlIHdpdGggdGhlIHNwZWNpYWwgYWRkcmVz
cyAweGZmZmZmZmZmIHdoaWNoIGluZGljYXRlcyB0byB0aGUNCj4+IGdlbmVyaWMgcGh5IGRyaXZl
ciB0byBwcm9iZSBhbGwgYWRkcmVzc2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gW2ZhYmlvOiBBZGRlZCB0aGUgY2hhbmdlcyB0
byBpbXg2cWRsLXNyLXNvbS11LWJvb3QuZHRzaS5dDQo+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+PiBUZXN0ZWQtYnk6IENocmlzdGlhbiBHbWVp
bmVyIDxjZ21laW5lckBpZ2FsaWEuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIHNpbmNlIHYxOg0K
Pj4gLSBEaXNhYmxlIGV0aGVybmV0LXBoeSBhdCBhZGRyZXNzZXMgMCwgMSBhbmQgNC4NCj4+IC0g
UmVtb3ZlIHRoZSBmaXh1cCBvZiB0aGUgZmFrZSAweGZmZmZmZiBhZGRyZXNzIGJlZm9yZSBib290
aW5nIExpbnV4Lg0KPj4NCj4+IEpvc3VhIGFuZCBDaHJpc3RpYW4sDQo+Pg0KPj4gSSBnb3QgYWNj
ZXNzIHRvIGEgaW14NiBodW1taW5nIGJvYXJkIGFuZCBJIHdhcyBhYmxlIHRvIHRlc3QgaXQuDQo+
Pg0KPj4gVGhpcyBpcyB0aGUgbWluaW1hbCBmaXggSSBjYW1lIHVwIGJhc2VkIG9uIHlvdXIgc3Vn
Z2VzdGlvbnMuDQo+Pg0KPj4gVGhlcmUgaXMgbm8gbmVlZCB0byBmaXh1cCBvZiB0aGUgZmFrZSAw
eGZmZmZmZiBhZGRyZXNzIGJlZm9yZSBib290aW5nIExpbnV4LA0KPj4gYXMgdGhpcyBmYWtlIGFk
ZHJlc3MgZG9lcyBub3QgZXhpc3QgaW4gTGludXguDQo+Pg0KPj4gU3VjY2Vzc2Z1bGx5IHRlc3Rl
ZCBFdGhlcm5ldCBpbiBVLUJvb3QgYW5kIGluIHRoZSBrZXJuZWwuDQo+Pg0KPj4gR2l2ZW4gdGhh
dCBFdGhlcm5ldCBpcyBjdXJyZW50bHkgYnJva2VuLCBJIHN1Z2dlc3Qgd2UgZ28gd2l0aCB0aGlz
DQo+PiB2ZXJzaW9uIHRvIHJlc3RvcmUgRXRoZXJuZXQgZm9yIDIwMjQuMDQuDQo+Pg0KPj4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+Pg0KPiBJIGFtIGhhcHB5IHdpdGggdGhlIHBhdGNoIGFuZCBsb3Zl
IHRoZSBpZGVhIHRvIGZpeCBFdGhlcm5ldCBmb3IgMjAyNC4wNC4NCj4NCj4gVGVzdGVkLWJ5OiBD
aHJpc3RpYW4gR21laW5lciA8Y2dtZWluZXJAaWdhbGlhLmNvbT4NCj4NClBhdGNoIGxvb2tzIGdv
b2QgdG8gbWUsIHRvbyAoaG93ZXZlciBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIGhhbmR5DQpm
b3IgdGVzdGluZyB2ZXJzaW9uIHdpdGggbmV3IHBoeSkhDQo=
