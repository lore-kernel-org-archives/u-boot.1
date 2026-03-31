Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4A0FF60C8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 05:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D7683DA7;
	Tue, 31 Mar 2026 07:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JovvVKbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD2A83EB3; Tue, 31 Mar 2026 07:29:13 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9144F83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 07:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egy230p2Ki/IfJSwyt0IRAhnlY15/O62Nb30qzjBZlGnDUpVy6upiYySSlBj+R4MvyIPE+IK62v6QcJ4AzmiJWzlUifzCxdziWMY9whtQE/F97MSEggLyHTL7sqQ6AzeCa2Yrp5feId3P8j6AJDnjRctyGDSThF7+zkYiGFKfzkGiTtou/6rY+W1DXdYIobLQV5eI0gLPxvxT6ydezDVILOSa8PtUvW665pi2NIH6QRkPJecXBQ9iDuBEm6IDOZR7WpWR/WUyXEmo63n4+a+zksX2Mu0gf35+BvHTAEQxmzr/185MxaietSO7kDjHHu7nhnrW7H47JXRo8ccbfAHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyjGUY7joGa84aZGRUwgZp90cTGhE4xKplqPBQD0GpQ=;
 b=NVDe9ydJ74sMJX8Wv5GP2dwUWotuAwjZB2ljdlqSZVjN1PSYUIwsbfZn/D0y3e1lkmAXFWXuN7Z8Syjh3litGfOzuUCW8aUKWsfOItrERLS3sbMZgLQfEh2a6nzmlRLaiyfeCVmaeOZz5SkESyUiGISHSXoFg/fMjWauksHxkLTeUKfT+SXzKWa3nhJS3WoboQEGNU1INmApfdZtBg6BwxP4PfW41sxKJfDQPTDA30O+GtWdroymZp9QHdGPRubSBA/aqTI0Q+ys6mbkB0Vlv0Ix3nlz6OK8mbZi91edyeVfALndiQmoaDBnqSpKq+QV7lg5OMUMV9gdAd0gYTLfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyjGUY7joGa84aZGRUwgZp90cTGhE4xKplqPBQD0GpQ=;
 b=JovvVKbjGUbvsbxgGhl/euXdqjwmdqh9ulYoB7vgfQD/aBB9GDnslPXpbMO/ITGdO+XDXzmwhwAjoFrspMhR1oUcP/FQxePYpPDqRlrClB6FmjWJghwoZJtH0D04WSyn+ECjDv7guCtc7nwimeKvyCzkJT8peEK+Zp9X7ug/h1mzO9JrYlm+v8Wkwwa2+PrxWbyTI1yUlupxbVfILQvd1daq0D9qSKlYwhSjg7CxiKo4dHYL457ELK74Oh+TazoLV8aZu/EaDabmj5U0UfOw8xlmpQvS9yJuCRRTMx1u7G9e0JoUomAG7HEGfqL4AIUWEn9UUWWFnkQJOBNATLga/A==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AMBP195MB2790.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 05:29:10 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 05:29:10 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Leonard Anderweit <L.Anderweit@phytec.de>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Thread-Topic: [PATCH v2 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Thread-Index: AQHcwEOD+wt7BTHm5EWp8ho5Ysg+CLXIHhAA
Date: Tue, 31 Mar 2026 05:29:10 +0000
Message-ID: <c966f8f12237df28cc69ee2f12a99057f4b4dfce.camel@phytec.de>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
 <20260330-power-legacy-v2-3-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-3-47dde3182a2c@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AMBP195MB2790:EE_
x-ms-office365-filtering-correlation-id: 3f62209b-1ab9-42d8-13ca-08de8ee66fb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: mv9F4uVTvCxoDFlZcyUW3sIafAUtjay0M1RKvrrhSPNW6waWP8YZasVjMZAOSiP1JVmAzsMaJArlQnsivc8zQtW5Uu3exP2KMAHMz7QPzxpH/yAYFvAK9ZbdzBhZmdLgxHUEB/E1/3q5GiL68cuh8mRFJOppL4ar0ikxJakHvvxL9CsASufhH1g6zrJjWnOeqwaWrD6MfJDZU1Q2MlDIMag6qkz4z7jKxKVVqhVQHHx8Xjrr50+odcOHcc7k/QmB67GEPMTc+y4r15l5/LT/yiCRdeKrwVd1a+J6e9Fx5rQ3gjCRpKeKdMXtujeJtQCHmttMQhqS4f/RA4qFirKLgtnDewzwt/5pOwJcCcYuPKPyIDbxGwfodRL1BUkNJe/QLWz4cuLA3CbrNi8+p8H9iofKm8A09h+j3w8tAv7xBFNr1AB7TiPX85fI0VzclTNsLjrlbzFyG+e941ZPLfIxtLNgTixleIqvMPrX243uw4MQ/UGVbo/ROLA6tcL6AzMCFArnZ2bNKi5MBXZjFgcKaTRi1YSE8Ps4yyUwd/cWoFs3SqnHPj/ZupL4qHic9lrfO7aNQTV7DNFs7tXSQUleyN95Yd/Lvm/xHhBWoJMUmTKU1Y9xsjNYRV5a3EVaeKlNI+iLsacDGbY1Tmijn7NFZtiKOVTGynAwDPj7KxHC3sRyutU0szTEw7+aXqlsL22q7XKDr5ZEB2PQNX1dYyoskzv6FfDOp8vZbLwjVx+iyTPVWGJ3EEgretIaafTIsPP1qefos8yrjXvy0wweQMEsMHIrd/LGELUidl4j2iv5wIo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFRFcVdOVWpNSWRUQktXSnNpWmNVYVcrT3l3NTBBa3ZPT0VnRm5pT2E0U01H?=
 =?utf-8?B?ZGdMd2c2RHI2WUg1S3JFU2FFRDJNSThhY0hxNFdOcy8zUk9IMmZUN2hIWG9q?=
 =?utf-8?B?MnBDN2NmL0sxa2djNUloOFd1akNtZXZpeHh6cWx2NXNzamR0bEdHTFM0eTNj?=
 =?utf-8?B?MG9nUmpCVnR5dm0xYWs0MzhzRnVzTGViVnIrMzRLZjZMdkQxUHVyNUV1bUdR?=
 =?utf-8?B?NmluUHhDWVZWSFB5NEQxNFpYb0FMV2U0aW9qZTU1SXpBNzh2cGZsTjVubWVK?=
 =?utf-8?B?RGJOcS81MmNpaFdXSEtFQUZxUE93d1RyLzhNTWo4dy91TjNxdUwvMjk2K2cr?=
 =?utf-8?B?WjJqWW1QMnJrckk3clJIekluUndjZlRURElzSjZ4aG04NS92QjQwUktra2xx?=
 =?utf-8?B?MFpYMUJKQkVPVW1mTFFrQWtRTXoyVlBOSHVqcGdCcS9RWXRYOUhNKzVtcFN0?=
 =?utf-8?B?aVMzbW01SzJBbjRqVVlIaUE2RDVlckIzeVlURm5XbC9pUXV0UElnY1pIdXpX?=
 =?utf-8?B?QUF6ZldMcFdXMTVic21HVEJxSFM2QXVIRWN6UlcwVVc2aHBsSGEyV1FKNzBX?=
 =?utf-8?B?UjF6Z3ZGSFI4TVRBWk9OVkFCQTlwY2FzaGVBYnBYOWU2ZzlQTGhWYUx2ZWZo?=
 =?utf-8?B?WFJtUXlLZmJ6YWQzZkN4czRnMUNvZ3RCamZZZHh4NmFlQ1NYK2ljN2Voenp3?=
 =?utf-8?B?UDRuOEgzM3JJd3JYc0drdmR5aTdaU2QvbHlUcXIvT0FFSEpDQWl1akVkWWVY?=
 =?utf-8?B?MGdmKzhZOFRoVmNMak45YU5mbXEwQncvMkFTem9jcC9oUWpRUFNnakZjKzJU?=
 =?utf-8?B?N3huRkNkNnAxS25RL3Z5N3g0VDhIeExUbkhHMy8xNGhCMlZjbTA1MFo1cDZp?=
 =?utf-8?B?VHIxcUx6c3FzQTcxcXpzQTRtS2RaRU5nNk16U2U3UEs5S3RmUG14MjNzMndV?=
 =?utf-8?B?SExxcmo1UzlyRExnNWtlVHdNZDNZYjBVb1hwcGh3T2I4cG9WcWduWjFGb0Ur?=
 =?utf-8?B?NEdNQVFKQWVGTzNuMGhBY0hZY0hNUmtvNFlvWWEzc2hrUXlnMFJUcllmeVV5?=
 =?utf-8?B?ajh1K2FUSE9kb2V6N3lFbXNXMUVwTk5XcUc3QlZab2VkUVNuZk5tV3ZMUGRS?=
 =?utf-8?B?K21WOGdkTndMV2xYTlgvcWZ3ekFnVitjK05zOUQyUi83R0t5TGhGb0hDTVQ3?=
 =?utf-8?B?ckFtQnFPbW0ybVhZVzFZby9ZVTZsNnlJVVkvSmJ5bUJiSlQrT3ZMSXMxV2tW?=
 =?utf-8?B?MXdTekZicGpKZzhsV09PUkxVMmY3WXpFUE9BWlRnYkdwR1JDamN6RzhpMnd2?=
 =?utf-8?B?SjJZS3JNVU05VkUzVlo3b1g5eWR2a0NVTVo2S0FFa1RTWjVvRks0VTFOTUdV?=
 =?utf-8?B?OTR1eFFQVkVvSmtpaFZVQ0REM0VjOWdQV0g2NUVHSWpBY082NGo1MHlGSWhK?=
 =?utf-8?B?UVNaVDh6bjhVU3dIaEZxM0piM0MxaVR3TzRROWtpdXhvK3oyQzFVMjFpYmll?=
 =?utf-8?B?QStyMTVTVXh0eG91RXc2OWpuRzB2Zm5DSzI3bUtOMVZaTEZUZzdibWZCTWFh?=
 =?utf-8?B?ZU1uNzczWHcwUUdwK292dHhHcW9KemY5UTNhQXlVc2RlZWtOVEtZdFNZaVBS?=
 =?utf-8?B?S3RERnQ2QVU1YWd1WTBoOUhSUC9LMG56bkowR0FCeGNaNS9JbDhIMXZHY3Vo?=
 =?utf-8?B?RndGK0RiQi9tUC9rUDJ6WktPVm8vQkQvRDMyVldhbW80ZUxESmdKdDdIR0dk?=
 =?utf-8?B?TW9GMzFtdmNJODJxK2l2SjBUNGJXaWFqdWZIUExtRDJiek10RHhuN01iaG9y?=
 =?utf-8?B?RTRCWmRDQTNQK05CVVgwcVRGM0hFZzlRQStyb1FsNTBuc3hiVHhwbmt4MnNu?=
 =?utf-8?B?OVVRSVdaYjdsOVpkMStudmtKcGZ5Q2JWbjBYQUsvWmtKNG9hbFpyQXV3Zm4y?=
 =?utf-8?B?bUQ0MXhRL2VVYVlTcS9DOGpaRUZHekpFVHpHbXlyenF1TlZBN2FWY1VXYit5?=
 =?utf-8?B?UlNITkJranp6cTJ2NWMvYnFaNXZsV2QvOVZHM21rUHczMDVRNmNVdlJyQ1dL?=
 =?utf-8?B?M2FGci9qaHVGcXhma1k4MjJIVTNVaHFNejZodjhaTC9sRDJabk1FbjZsV1dv?=
 =?utf-8?B?dEFWUTZGelBNVWtWdXRsOExlNTFJbmpMdm5zcDdqdXI3Z0VEcVduQmJYdEJx?=
 =?utf-8?B?QUpMenhqbEJzc0gvNTZienBKOW9SaWlGYVNwYWQ2MVJmRzlaUDdTaldHUHJV?=
 =?utf-8?B?SXpyMjMzbzQzKzNSVjBrMkwxeFNHNkhVZzl1anRYMGNpRWxoTFdhN013Z0ds?=
 =?utf-8?Q?XJ3hjPh3MuuR1BTBlh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44CD553B2F36AF4F8AD4DF904478D847@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f62209b-1ab9-42d8-13ca-08de8ee66fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 05:29:10.0520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap6O0+IbPTg815OxHTUdNTUchsdrRyBRgEfMR6UL+0BXbf4+bc116k/jBbmTl7cg2NnJqhRdhA+oToTlMVQTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2790
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDIyOjA0ICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToK
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4KPiAKPiBDb252ZXJ0IHRoZSBib2Fy
ZCB0byB1c2UgRE1fUE1JQyBpbnN0ZWFkIG9mIHRoZSBsZWdhY3kgU1BMIEkyQy9QTUlDCj4gaGFu
ZGxpbmcuCj4gCj4gQ2hhbmdlcyBpbmNsdWRlOgo+IC0gRW5hYmxlIERNX1BNSUMsIERNX1BNSUNf
UENBOTQ1MCwgYW5kIFNQTF9ETV9QTUlDX1BDQTk0NTAgaW4gZGVmY29uZmlnLgo+IC0gRHJvcCBs
ZWdhY3kgU1BMIEkyQyBhbmQgUE1JQyBvcHRpb25zLgo+IC0gUmVtb3ZlIG1hbnVhbCBJMkMxIHBh
ZCBzZXR1cCBhbmQgbGVnYWN5IHBvd2VyX3BjYTk0NTBfaW5pdCgpIHVzYWdlLgo+IC0gVXNlIERN
LWJhc2VkIHBtaWNfZ2V0KCkgd2l0aCB0aGUgRFQgbm9kZSAicG1pY0AyNSIuCj4gLSBVcGRhdGUg
UE1JQyByZWdpc3RlciBwcm9ncmFtbWluZyB0byB1c2Ugc3RydWN0IHVkZXZpY2UgQVBJLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPgoKUmV2aWV3ZWQtYnk6
IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgpUZXN0ZWQtYnk6IFlhbm5pYyBNb29nIDx5
Lm1vb2dAcGh5dGVjLmRlPgoKCj4gLS0tCj4gwqBhcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJk
ay1mcHNjLXUtYm9vdC5kdHNpIHwgMjIgKysrKysrKysrKy0tCj4gwqBib2FyZC9waHl0ZWMvaW14
OG1wLWxpYnJhLWZwc2Mvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ2ICsrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tCj4gwqBjb25maWdzL2lteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZ8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKystLS0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMzgg
aW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2R0cy9pbXg4bXAtbGlicmEtcmRrLWZwc2MtdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14
OG1wLWxpYnJhLXJkay1mcHNjLQo+IHUtYm9vdC5kdHNpCj4gaW5kZXggMTMyMGYxNTQwZWQuLmY5
MTdiNzFiZTkwIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bXAtbGlicmEtcmRrLWZw
c2MtdS1ib290LmR0c2kKPiArKysgYi9hcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNj
LXUtYm9vdC5kdHNpCj4gQEAgLTMzLDYgKzMzLDE4IEBACj4gwqAJfTsKPiDCoH07Cj4gwqAKPiAr
JnBpbmN0cmxfaTJjMSB7Cj4gKwlib290cGgtYWxsOwo+ICt9Owo+ICsKPiArJnBpbmN0cmxfcG1p
YyB7Cj4gKwlib290cGgtYWxsOwo+ICt9Owo+ICsKPiArJnsvc29jQDAvYnVzQDMwODAwMDAwL2ky
Y0AzMGEyMDAwMC9wbWljQDI1L3JlZ3VsYXRvcnN9IHsKPiArCWJvb3RwaC1hbGw7Cj4gK307Cj4g
Kwo+IMKgJnJlZ191c2RoYzJfdm1tYyB7Cj4gwqAJYm9vdHBoLXByZS1yYW07Cj4gwqB9Owo+IEBA
IC03OCwxMSArOTAsMTEgQEAKPiDCoH07Cj4gwqAKPiDCoCZpMmMxIHsKPiAtCWJvb3RwaC1wcmUt
cmFtOwo+ICsJYm9vdHBoLWFsbDsKPiDCoH07Cj4gwqAKPiDCoCZwbWljIHsKPiAtCWJvb3RwaC1w
cmUtcmFtOwo+ICsJYm9vdHBoLWFsbDsKPiDCoH07Cj4gwqAKPiDCoC8qIFVTQjEgVHlwZS1DICov
Cj4gQEAgLTEyMCw2ICsxMzIsMTIgQEAKPiDCoAo+IMKgJnVzZGhjMiB7Cj4gwqAJYm9vdHBoLXBy
ZS1yYW07Cj4gKwkvKgo+ICsJICogTERPNSBvdXRwdXQgZGVwZW5kcyBvbiBTRDJfVlNFTCwgYnV0
IG5vIHdheSB0byByZWFkIGJhY2sgU0QyX1ZTRUwKPiArCSAqIHdoZW4gdXNpbmcgU0RIQyBjb250
cm9sbGVyIFZTRUxFQ1QgdG8gY29udHJvbCBTRDJfVlNFTC4gU28gZHJvcAo+ICsJICogdnFtbWMt
c3VwcGx5IHRvIGF2b2lkIGZzbF9lc2RoY19pbXggcmVhZCBiYWNrIHdyb25nIHZvbHRhZ2UuCj4g
KwkgKi8KPiArCSAvZGVsZXRlLXByb3BlcnR5LyB2cW1tYy1zdXBwbHk7Cj4gwqB9Owo+IMKgCj4g
wqAmdXNkaGMzIHsKPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNj
L3NwbC5jIGIvYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNjL3NwbC5jCj4gaW5kZXggMDgx
MTE2NDFhYTYuLmFhMjJhZDAwMzBjIDEwMDY0NAo+IC0tLSBhL2JvYXJkL3BoeXRlYy9pbXg4bXAt
bGlicmEtZnBzYy9zcGwuYwo+ICsrKyBiL2JvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9z
cGwuYwo+IEBAIC05LDkgKzksNiBAQAo+IMKgI2luY2x1ZGUgPGFzbS9hcmNoL2lteDhtcF9waW5z
Lmg+Cj4gwqAjaW5jbHVkZSA8YXNtL2FyY2gvc3lzX3Byb3RvLmg+Cj4gwqAjaW5jbHVkZSA8YXNt
L21hY2gtaW14L2Jvb3RfbW9kZS5oPgo+IC0jaW5jbHVkZSA8YXNtL21hY2gtaW14L2dwaW8uaD4K
PiAtI2luY2x1ZGUgPGFzbS9tYWNoLWlteC9teGNfaTJjLmg+Cj4gLSNpbmNsdWRlIDxhc20vbWFj
aC1pbXgvaW9tdXgtdjMuaD4KPiDCoCNpbmNsdWRlIDxoYW5nLmg+Cj4gwqAjaW5jbHVkZSA8aW5p
dC5oPgo+IMKgI2luY2x1ZGUgPGxvZy5oPgo+IEBAIC00Niw0NSArNDMsMzIgQEAgdm9pZCBzcGxf
ZHJhbV9pbml0KHZvaWQpCj4gwqAJZGRyX2luaXQoJmRyYW1fdGltaW5nKTsKPiDCoH0KPiDCoAo+
IC0jZGVmaW5lIEkyQ19QQURfQ1RSTCAoUEFEX0NUTF9EU0U2IHwgUEFEX0NUTF9IWVMgfCBQQURf
Q1RMX1BVRSB8IFBBRF9DVExfUEUpCj4gLSNkZWZpbmUgUEMgTVVYX1BBRF9DVFJMKEkyQ19QQURf
Q1RSTCkKPiAtc3RydWN0IGkyY19wYWRzX2luZm8gaTJjX3BhZF9pbmZvMSA9IHsKPiAtCS5zY2wg
PSB7Cj4gLQkJLmkyY19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0NMX19JMkMxX1NDTCB8IFBDLAo+
IC0JCS5ncGlvX21vZGUgPSBNWDhNUF9QQURfSTJDMV9TQ0xfX0dQSU81X0lPMTQgfCBQQywKPiAt
CQkuZ3AgPSBJTVhfR1BJT19OUig1LCAxNCksCj4gLQl9LAo+IC0JLnNkYSA9IHsKPiAtCQkuaTJj
X21vZGUgPSBNWDhNUF9QQURfSTJDMV9TREFfX0kyQzFfU0RBIHwgUEMsCj4gLQkJLmdwaW9fbW9k
ZSA9IE1YOE1QX1BBRF9JMkMxX1NEQV9fR1BJTzVfSU8xNSB8IFBDLAo+IC0JCS5ncCA9IElNWF9H
UElPX05SKDUsIDE1KSwKPiAtCX0sCj4gLX07Cj4gLQo+IMKgaW50IHBvd2VyX2luaXRfYm9hcmQo
dm9pZCkKPiDCoHsKPiAtCXN0cnVjdCBwbWljICpwOwo+ICsJc3RydWN0IHVkZXZpY2UgKmRldjsK
PiDCoAlpbnQgcmV0Owo+IMKgCj4gLQlyZXQgPSBwb3dlcl9wY2E5NDUwX2luaXQoMCwgMHgyNSk7
Cj4gLQlpZiAocmV0KQo+IC0JCXByaW50ZigicG93ZXIgaW5pdCBmYWlsZWQiKTsKPiAtCXAgPSBw
bWljX2dldCgiUENBOTQ1MCIpOwo+IC0JcG1pY19wcm9iZShwKTsKPiArCXJldCA9IHBtaWNfZ2V0
KCJwbWljQDI1IiwgJmRldik7Cj4gKwlpZiAocmV0ID09IC1FTk9ERVYpIHsKPiArCQlwdXRzKCJO
byBwbWljQDI1XG4iKTsKPiArCQlyZXR1cm4gMDsKPiArCX0KPiArCWlmIChyZXQgPCAwKQo+ICsJ
CXJldHVybiByZXQ7Cj4gwqAKPiDCoAkvKiBCVUNLeE9VVF9EVlMwLzEgY29udHJvbCBCVUNLMTIz
IG91dHB1dCAqLwo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMTIzX0RWUywgMHgy
OSk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzEyM19EVlMsIDB4MjkpOwo+
IMKgCj4gwqAJLyogSW5jcmVhc2UgVkREX1NPQyBhbmQgVkREX0FSTSB0byBPRCB2b2x0YWdlIDAu
OTVWICovCj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzAsIDB4MUMp
Owo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMk9VVF9EVlMwLCAweDFDKTsKPiAr
CXBtaWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsKPiArCXBt
aWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMk9VVF9EVlMwLCAweDFDKTsKPiDCoAo+IMKg
CS8qIFNldCBCVUNLMSBEVlMxIHRvIHN1c3BlbmQgY29udHJvbGxlZCB0aHJvdWdoIFBNSUNfU1RC
WV9SRVEgKi8KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMSwgMHgx
NCk7Cj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxQ1RSTCwgMHg1OSk7Cj4gKwlw
bWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMSwgMHgxNCk7Cj4gKwlwbWlj
X3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFDVFJMLCAweDU5KTsKPiDCoAo+IMKgCS8qIFNl
dCBXRE9HX0JfQ0ZHIHRvIGNvbGQgcmVzZXQgKi8KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0
NTBfUkVTRVRfQ1RSTCwgMHhBMSk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfUkVT
RVRfQ1RSTCwgMHhBMSk7Cj4gwqAKPiDCoAlyZXR1cm4gMDsKPiDCoH0KPiBAQCAtMTIwLDggKzEw
NCw2IEBAIHZvaWQgYm9hcmRfaW5pdF9mKHVsb25nIGR1bW15KQo+IMKgCj4gwqAJZW5hYmxlX3R6
YzM4MCgpOwo+IMKgCj4gLQlzZXR1cF9pMmMoMCwgQ09ORklHX1NZU19JMkNfU1BFRUQsIDB4N2Ys
ICZpMmNfcGFkX2luZm8xKTsKPiAtCj4gwqAJcG93ZXJfaW5pdF9ib2FyZCgpOwo+IMKgCj4gwqAJ
LyogRERSIGluaXRpYWxpemF0aW9uICovCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaW14OG1wLWxp
YnJhLWZwc2NfZGVmY29uZmlnIGIvY29uZmlncy9pbXg4bXAtbGlicmEtZnBzY19kZWZjb25maWcK
PiBpbmRleCBhMjNlNjA0NDI1ZC4uNGE4OTM4ZDNlNDMgMTAwNjQ0Cj4gLS0tIGEvY29uZmlncy9p
bXg4bXAtbGlicmEtZnBzY19kZWZjb25maWcKPiArKysgYi9jb25maWdzL2lteDhtcC1saWJyYS1m
cHNjX2RlZmNvbmZpZwo+IEBAIC05LDcgKzksNiBAQCBDT05GSUdfU0ZfREVGQVVMVF9TUEVFRD04
MDAwMDAwMAo+IMKgQ09ORklHX0VOVl9TSVpFPTB4MTAwMDAKPiDCoENPTkZJR19FTlZfT0ZGU0VU
PTB4M0MwMDAwCj4gwqBDT05GSUdfRU5WX1NFQ1RfU0laRT0weDEwMDAwCj4gLUNPTkZJR19TWVNf
STJDX01YQ19JMkMxPXkKPiDCoENPTkZJR19ETV9HUElPPXkKPiDCoENPTkZJR19ERUZBVUxUX0RF
VklDRV9UUkVFPSJmcmVlc2NhbGUvaW14OG1wLWxpYnJhLXJkay1mcHNjIgo+IMKgQ09ORklHX0lN
WDhNX09QVEVFX0xPQURfQUREUj0weDdlMDAwMDAwCj4gQEAgLTEwNSw4ICsxMDQsNiBAQCBDT05G
SUdfRkFTVEJPT1RfTU1DX1VTRVJfU1VQUE9SVD15Cj4gwqBDT05GSUdfRkFTVEJPT1RfTU1DX1VT
RVJfTkFNRT0ibW1jMiIKPiDCoENPTkZJR19NWENfR1BJTz15Cj4gwqBDT05GSUdfRE1fSTJDPXkK
PiAtIyBDT05GSUdfU1BMX0RNX0kyQyBpcyBub3Qgc2V0Cj4gLUNPTkZJR19TUExfU1lTX0kyQ19M
RUdBQ1k9eQo+IMKgQ09ORklHX0kyQ19FRVBST009eQo+IMKgQ09ORklHX1NZU19JMkNfRUVQUk9N
X0FERFI9MHg1MQo+IMKgQ09ORklHX1NVUFBPUlRfRU1NQ19CT09UPXkKPiBAQCAtMTM4LDE1ICsx
MzUsMTYgQEAgQ09ORklHX1BIWV9JTVg4TVFfVVNCPXkKPiDCoENPTkZJR19QSU5DVFJMPXkKPiDC
oENPTkZJR19TUExfUElOQ1RSTD15Cj4gwqBDT05GSUdfUElOQ1RSTF9JTVg4TT15Cj4gLUNPTkZJ
R19TUExfUE9XRVJfTEVHQUNZPXkKPiDCoENPTkZJR19QT1dFUl9ET01BSU49eQo+IMKgQ09ORklH
X0lNWDhNX1BPV0VSX0RPTUFJTj15Cj4gwqBDT05GSUdfSU1YOE1QX0hTSU9NSVhfQkxLQ1RSTD15
Cj4gLUNPTkZJR19QT1dFUl9QQ0E5NDUwPXkKPiArQ09ORklHX0RNX1BNSUM9eQo+ICtDT05GSUdf
RE1fUE1JQ19QQ0E5NDUwPXkKPiArQ09ORklHX1NQTF9ETV9QTUlDX1BDQTk0NTA9eQo+IMKgQ09O
RklHX0RNX1JFR1VMQVRPUj15Cj4gK0NPTkZJR19ETV9SRUdVTEFUT1JfUENBOTQ1MD15Cj4gwqBD
T05GSUdfRE1fUkVHVUxBVE9SX0ZJWEVEPXkKPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfR1BJTz15
Cj4gLUNPTkZJR19TUExfUE9XRVJfSTJDPXkKPiDCoENPTkZJR19ETV9STkc9eQo+IMKgQ09ORklH
X0RNX1NFUklBTD15Cj4gwqBDT05GSUdfTVhDX1VBUlQ9eQo=
