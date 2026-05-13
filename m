Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870F9CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169648466C;
	Wed, 13 May 2026 16:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fU1IL3mP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D776F84663; Wed, 13 May 2026 16:10:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF9180F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRmaR09V63OxKWhyb5sVHchGJB+K9/KNQ/pzLfkZRms6U0fi1rYMMCYHk2JPovUagajOuuHKBHgRizvJ8G/2G7SDFArCc6AQkq0BiUHLlKyVG5oVXm752XQbtZ/JR5gd/m1DNq2rThiFnEwgBnMTMv3tPp+WfSnZ0fUx1w5I/EKgawaDfmG2T7+llof5OBt84wy4Qt0GNLtgOAAECoQfcQS6p5Ed7M97Hruv7fvUwk3X1RTdgO3nG95RCy2NPdLiUf7OwSTKXpX5B5GgjinRHc48fAjYlKwbPVxnR0N7Pzs5Tpc7p5e5g8w4v+OArMfbboYQWjsWlAHXYu85O/zKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W05rL7QTDtM2v1FaKqUb9/sMJdN1uNXZZwFKWdlTa6I=;
 b=XGOO6ED/FFzgZoq7sx28y5at1oR6iz+DCQaf/AvERf8oKeLEtc9AjR8xgyPl1xEynpLb+D26j9Uhzlr6QlZ672zjC6nMPzpl3dYJBZEaoo0NmmS28t1g2zkVAY0l/yqKdlEPvrlIP6z+xVmxyI8s1+rOEEuE+XZ08Uh+n2+clDdO4qpE+6ihlzd8mFsw/SHAcyaJn6pug+lwBXZMG6UZmcNrqIJO4/rvyFITenNZ9+8LzrmWyTUCshyWJKO7Sq8nT62QyuoquWsA/dh7j2dxS0/sIYqyNsnbA2HMRBvIqbLo3DQ8DUWmWiPwUpXd1Qm8/boK5WYWul2gzDsz9elAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W05rL7QTDtM2v1FaKqUb9/sMJdN1uNXZZwFKWdlTa6I=;
 b=fU1IL3mPnorNm4lL3m70iac4jmN4rJKykzBaDs1Rc9NQHMJmFDgp7SsbJYEjV4oBTSySYmS11LDAVQvLH8IApmRlvFkkjDGS+LoyyULc/1OWZy39w/B+75jDLAFSiycz2cqKqSeq/GgaIJIfQ03Vh1TU5eDkmXUh6MiOJSLfbhPp0YvrKgZXtl1mYKX59/PteLnM5OIVqPx7yZflWdGyhmKqTi52dgyl35xcBxA9EDq59ZkLdqhjjmW3M0EmnQqogW/vLmu6vDC2rnYhBVCOtRYjk1Dr67NgMh2fzexXYf687plyNeHvKwEwei+/Jl+/EveX9uHjlQIjF3AEe5MFHQ==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PA2P195MB2570.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:424::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:10:19 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:10:19 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Dominik Haller <D.Haller@phytec.de>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 4/7] include: env: phytec: Drop legacy RAUC boot logic
Thread-Topic: [PATCH 4/7] include: env: phytec: Drop legacy RAUC boot logic
Thread-Index: AQHc4qjQiYZ3FH2EVEeBHG7SFvBRgLYL/yIA
Date: Wed, 13 May 2026 14:10:19 +0000
Message-ID: <e08226f57898346f0401b04dfd042175ce4a4857.camel@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
 <20260513071905.83522-5-w.egorov@phytec.de>
In-Reply-To: <20260513071905.83522-5-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PA2P195MB2570:EE_
x-ms-office365-filtering-correlation-id: 4b307cfe-1564-4923-ff13-08deb0f95d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: PWc8DBJPH8s6ZgqLt6GyHLsnan578HMt1OhK8oEqjkx/KukMlKu7NXs+re4aOyYQ+qu+38+lfktBG+zssdgBz9H9X3jLAGYIOa1GESrX01wTCrQw/S3nxnwTwgGcc/ZGrsnHUeRU+Xz0t1IdbjQ25b6CF9E9LeTnyd68zJRNnA4BPRXOoWUOSPRNC/tfBaI+uS/31i2woYEcz2bLHo5ZC1jJHvKPj5Vby5WukHMOxdrPJjVTqx2aPbzKhFo4pLyLPRtzOeSCMLaEuK+Ra9msyHb2IPGTumXc5tGEtxi++fkYyvL9EEd36xGRf57cHAThZrOzPK7vTqU9f57CTYRgQt5V5t8stghvSLz9ezpVjs7Y2kFsSt+1HQWjaesiottvwjfKVQ8Jx6H0PU4dXDRK/ovPr6A9an7fQqlB1cCA4aagOCWkotgP0nxVh36x8VH2Q7MlUfGEl+I+JtSnsUVrW/mA+FW+1JFYhpJrmTQOb12WZJLyGVg1RmS0Td1gOUD2HM78f0uDI+74kUeodagkZWfr6WqNXQIrY/8/SfAvDXB45dyqI0SB+GeGDwo3daZnlQG9Vycxc1WyxYcUBE/a3lvO/aqME24FepMZIPQPzcpuwNjLs6CnDlXeuQdKS6PgVwl3eBoRmNCArhI8IKXbha1ra24DMltaenqVp2IxYbBh/WoEJ1ZNN3JTrZngNCvCadc1SPcQOOoZjkmzbjBR1LxwsENor/IREWf2gyzg3RdWTFwihvLLyuo5qBsIpj6a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDNQRFlwNmpIT25JeEtTTzlyV2ZEdlpwdHlySk5jYXdYV2NMN2xtOTdUNUtj?=
 =?utf-8?B?YzNKekpGY0dtZVJqSFNFMm5UcGh4SE4vSjgyRGZJTEE4T2J4NEVtdEtzSmky?=
 =?utf-8?B?bm9oQWc5YWpQUGt2UjR0bGNqcFB1OFo1ZVpZMmVncWxVTlhxdjZWMFpWaTEw?=
 =?utf-8?B?eVpzeFlsc1M2amd1bUhFaGlhc0g0SlRDV3RxVVliNk5Sc1llVTBwSHVaaFls?=
 =?utf-8?B?ZEtma2h3NkVRbE42aDFqbnVmalAvbXBOSkNtblFvc0hGZVVOYWhJVzJ6Y3BE?=
 =?utf-8?B?eTh6THEwWEE1RURRazBuWVVBNW1jbTk4bm81bUxMQm83K3FENFJDdmN4R2Jh?=
 =?utf-8?B?WERtN0JuckJEakNNNHg0YmkycEhSMDROdlo3TTdYLzJxSThxTnNhWVR2U3M0?=
 =?utf-8?B?L1ROQVVkeFc5emdHZGpkNzRMQkF1c1NRVmZFUHVQc3RYWVJWZHZSYldrMTVt?=
 =?utf-8?B?N1RWaGJTUGVWVWt0Vm05T2RHbUowMEt1K29jVjdBb3VlZ1pja051TGg2Y0x3?=
 =?utf-8?B?VnJBVjJVQW9MSTZadUp4T3g2QXhiNHRaVGdRYk9tM2NZSXhZc0hLN0IyMlVL?=
 =?utf-8?B?L1FONWNhRkMwUWJzUkhmTFFma082RDdkcVhiYWtIay90MEw5T2RHR1ZBaXBW?=
 =?utf-8?B?TkpTQjhkdkN2bityUnRObmFyWXlONzlJdm1qcWtnbTZ3TlV3VTdYN0J6QzQx?=
 =?utf-8?B?MS8xR2U3ZmY2NVQxOTh2MEd4Nm1Yd0x3V0NRUjI3TXJVdjdEQ3hscTczcXgw?=
 =?utf-8?B?R2dCN2ZKaXluNzZUR3pTWnZwSVJkV1piZ2RhVHhKN1VGVWJ1cDErYmpXeU5m?=
 =?utf-8?B?V1BWeVJnYzBqNjlseHZOYXQzTGFQcnZpTHpVOEpNOG5LV0ljUFBGZzN5QS9j?=
 =?utf-8?B?NmszemF0Mi9IbnVjUDdjdHg0YUVsaVA1RkZOK2JZbGJ1MXp2U0xzbVpJMmRW?=
 =?utf-8?B?SjRvUDF4ci9PaG93NmZFakZMWXQxRTd4NXR1UUJmMTNXelR1UnA1RHhhV2xq?=
 =?utf-8?B?dkd1VkludTNaMUUreStyTCthUC9oY1IwL3BTRkVKZmRYUldUcUc5R28rOXh2?=
 =?utf-8?B?eTB1RHg2R2Y5NWp4N3pUWEtJOHZibGZUdjJoMktTbGJobkljWjN0bGhGNmVm?=
 =?utf-8?B?NXhqakZyaUhERFRpTVE0dWdZVkRpWkk1QzA4RGpJVy9VOGp1VndnMmZPSTZS?=
 =?utf-8?B?bTFDVzJuV2t4Q0NvN1o0dXhsSm5TbkxZV09Cek11RjU4U2I5TkNiR2E5dStC?=
 =?utf-8?B?dTlaVk9oTTl1MVJWUEZTWWZ3bDRJZDh5MTRFZFdJSnVSZHpaS082R0Z6Q09k?=
 =?utf-8?B?NXUxZW5IaTNhelNNWVpOZlpyY3U4RWE4ZFFqTW9lRkZxeTZYcnFjT0JuV0dk?=
 =?utf-8?B?WGs5N1RSVmM4K0xZc0JDMEV4QkNpVkJqU1lkZ3NDeDFGeFJESDhPbE9pWWpq?=
 =?utf-8?B?aW5rS3NWZENNK3hKK01PNmlnY2NSaDZlUU1wbEFOcHpYdUdSK3VpZVE4c3NI?=
 =?utf-8?B?RnVOZDYvWmFrQnFEZ09UWmFCN2NiYzFxK2EzdjhKdFQ0TFA2RjByaDhiM3lU?=
 =?utf-8?B?VnZKV1pwKzJIQjhhVndCWHJ3UzFmeG1BZEIxRmFNeUorcm9oZjRQRmMrS2Nr?=
 =?utf-8?B?TzEzWmV0c0p5NnJFL1hKWGNJcUJZMGRoeDJ4UWI2MEZJRmEzN1BIWVdNN1gz?=
 =?utf-8?B?VTVienBDejU2TmNqOXVJanRYUXg0SGM2bGdyT05WWDNsSnB5dWpRaUU4K3Vx?=
 =?utf-8?B?S2lBakN3RUQ0N2d5SDJ3SEdzQUEwcnlMVWoxQ2o3Y0R6TjNOVGppT1Uwdnc2?=
 =?utf-8?B?WFgyMmZPMzJNVWxpazNrZnpLV1hXcHhBaDBqYWVzOXVtM3d3NGFMMGVSTFF6?=
 =?utf-8?B?Z1drWTFFUGhGanZpVVNMV0pCRWRtSzF4Q0QzVnZuRndHQ2E0S2RPSHRKWFc1?=
 =?utf-8?B?UFRZVFFqR2pVdDliaHlqVFdZUlI4Sk9tTzlmNFJaNmVoVlJxZ1dwc1JHTUNG?=
 =?utf-8?B?MVlBTGlxak5nN3dpSTN5YmdEYTRSbWJXNkJIZWM2ZkhqUlVaMGRJZ0NJU0lG?=
 =?utf-8?B?RVRTQlNXMVRLTWI0UFJMYjEvWnBTMDliUHBTSElBeEhidVh1WU5SeFJFZFVT?=
 =?utf-8?B?bUN6dXZKUlozRFZRS3RYYW53a2did1h2L1RialBLeWFDbHBqdTR5eUxOQk5P?=
 =?utf-8?B?QTgvcHNlUG93RXJUem43L0FFd0VRMUl6TUFycERQSG1lSmRPaDZvYklaZVg3?=
 =?utf-8?B?VDByVGVUR2VEckNwZmorNjgzcVh1dDc2WWdIalJ1dzBrNHE5bjRPQ2l6dzlZ?=
 =?utf-8?Q?69zKXXYFq7/yCww3Pp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD52D2DCD1621E4F91869A055415C3FA@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b307cfe-1564-4923-ff13-08deb0f95d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 14:10:19.4048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fisVy8DCHL7SkpFFy/uA1MfDK6Jk/KH/xAjo3MdBMaV8LITmN1LmsY63mZfKCcCB2QnBspPHPt+NS2WZ1fDZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2570
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

UmV2aWV3ZWQtYnk6IE1hcnRpbiBTY2h3YW4gPG0uc2Nod2FuQHBoeXRlYy5kZT4KCk9uIFdlZCwg
MjAyNi0wNS0xMyBhdCAwOToxOSArMDIwMCwgV2FkaW0gRWdvcm92IHdyb3RlOgo+IFJBVUMgc2xv
dCBzZWxlY3Rpb24gaXMgbm93IGhhbmRsZWQgYnkgdGhlIFJBVUMgYm9vdG1ldGgsIHdoaWNoIGFs
bAo+IHBoeXRlYyBLMyBib2FyZHMgdXNlLiBSZW1vdmUgdGhlIHVudXNlZCBlbnYtYmFzZWQgbG9n
aWMuCj4gCj4gU2lnbmVkLW9mZi1ieTogV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0ZWMuZGU+
Cj4gLS0tCj4gwqBpbmNsdWRlL2Vudi9waHl0ZWMvazNfbW1jLmVudiB8wqAgNCArLS0KPiDCoGlu
Y2x1ZGUvZW52L3BoeXRlYy9yYXVjLmVudsKgwqAgfCA1MiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiAtLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNTUg
ZGVsZXRpb25zKC0pCj4gwqBkZWxldGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9lbnYvcGh5dGVjL3Jh
dWMuZW52Cj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZW52L3BoeXRlYy9rM19tbWMuZW52Cj4g
Yi9pbmNsdWRlL2Vudi9waHl0ZWMvazNfbW1jLmVudgo+IGluZGV4IDk1ZDAyMDRiNmRhLi44MTI5
YjM1ZWE1ZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2Vudi9waHl0ZWMvazNfbW1jLmVudgo+ICsr
KyBiL2luY2x1ZGUvZW52L3BoeXRlYy9rM19tbWMuZW52Cj4gQEAgLTcsMTUgKzcsMTMgQEAKPiDC
oC8qIExvZ2ljIGZvciBUSSBLMyBiYXNlZCBTb0NzIHRvIGJvb3QgZnJvbSBhIE1NQyBkZXZpY2Uu
ICovCj4gwqAKPiDCoCNpbmNsdWRlIDxlbnYvcGh5dGVjL292ZXJsYXlzLmVudj4KPiAtI2luY2x1
ZGUgPGVudi9waHl0ZWMvcmF1Yy5lbnY+Cj4gwqAKPiDCoG1tY2FyZ3M9c2V0ZW52IGJvb3Rhcmdz
IGNvbnNvbGU9JHtjb25zb2xlfSBlYXJseWNvbj0ke2Vhcmx5Y29ufQo+IC0Jcm9vdD0vZGV2L21t
Y2JsayR7bW1jZGV2fXAke21tY3Jvb3R9ICR7cmF1Y2FyZ3N9IHJvb3R3YWl0IHJ3Cj4gKwlyb290
PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0gcm9vdHdhaXQgcncKPiDCoAkke29wdGFy
Z3N9Cj4gwqBtbWNsb2FkaW1hZ2U9bG9hZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0gJHtrZXJu
ZWxfYWRkcl9yfSBJbWFnZQo+IMKgbW1jbG9hZGZkdD1sb2FkIG1tYyAke21tY2Rldn06JHttbWNw
YXJ0fSAke2ZkdF9hZGRyX3J9ICR7ZmR0ZmlsZX0KPiDCoG1tY2Jvb3Q9ZWNobyBERVBSRUNBVElP
TiBXQVJOSU5HOiBtbWNib290IHdpbGwgYmUgcmVtb3ZlZCBpbiBmdXR1cmUKPiB2ZXJzaW9ucy4g
VXNlIHN0YW5kYXJkIGJvb3QgaW5zdGVhZC47Cj4gLQlpZiB0ZXN0ICR7ZG9yYXVjYm9vdH0gPSAx
OyB0aGVuIHJ1biByYXVjaW5pdDsgZmk7Cj4gwqAJcnVuIG1tY2FyZ3M7Cj4gwqAJbW1jIGRldiAk
e21tY2Rldn07Cj4gwqAJbW1jIHJlc2NhbjsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbnYvcGh5
dGVjL3JhdWMuZW52Cj4gYi9pbmNsdWRlL2Vudi9waHl0ZWMvcmF1Yy5lbnYKPiBkZWxldGVkIGZp
bGUgbW9kZSAxMDA2NDQKPiBpbmRleCA4OWUxN2ZmNzBlYy4uMDAwMDAwMDAwMDAKPiAtLS0gYS9p
bmNsdWRlL2Vudi9waHl0ZWMvcmF1Yy5lbnYKPiArKysgL2Rldi9udWxsCj4gQEAgLTEsNTIgKzAs
MCBAQAo+IC0vKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8KPiAtCj4gLS8q
IExvZ2ljIHRvIHNlbGVjdCBhIGJvb3QgcGFydGl0aW9uIGJhc2VkIG9uIGVudmlyb25tZW50IHZh
cmlhYmxlcwo+IGFuZCBzd2l0Y2gKPiAtICogdG8gdGhlIG90aGVyIGlmIHRoZSBib290IGZhaWxz
LiAqLwo+IC0KPiAtZG9yYXVjYm9vdD0wCj4gLQo+IC1yYXVjYm9vdHBhcnQwPTEKPiAtcmF1Y3Jv
b3RwYXJ0MD01Cj4gLXJhdWNib290cGFydDE9Mgo+IC1yYXVjcm9vdHBhcnQxPTYKPiAtCj4gLXJh
dWNpbml0PQo+IC0JZWNobyBCb290aW5nIFJBVUMgQS9CIHN5c3RlbTsKPiAtCXRlc3QgLW4gIiR7
Qk9PVF9PUkRFUn0iIHx8IGVudiBzZXQgQk9PVF9PUkRFUiAic3lzdGVtMAo+IHN5c3RlbTEiOwo+
IC0JdGVzdCAtbiAiJHtCT09UX3N5c3RlbTBfTEVGVH0iIHx8IGVudiBzZXQgQk9PVF9zeXN0ZW0w
X0xFRlQKPiAzOwo+IC0JdGVzdCAtbiAiJHtCT09UX3N5c3RlbTFfTEVGVH0iIHx8IGVudiBzZXQg
Qk9PVF9zeXN0ZW0xX0xFRlQKPiAzOwo+IC0JZW52IHNldCByYXVjc3RhdHVzOwo+IC0JZm9yIEJP
T1RfU0xPVCBpbiAiJHtCT09UX09SREVSfSI7IGRvCj4gLQkJaWYgdGVzdCAieCR7cmF1Y3N0YXR1
c30iICE9ICJ4IjsgdGhlbgo+IC0JCQllY2hvIFNraXBwaW5nIHJlbWFpbmcgc2xvdHMhOwo+IC0J
CWVsaWYgdGVzdCAieCR7Qk9PVF9TTE9UfSIgPSAieHN5c3RlbTAiOyB0aGVuCj4gLQkJCWlmIHRl
c3QgJHtCT09UX3N5c3RlbTBfTEVGVH0gLWd0IDA7IHRoZW4KPiAtCQkJCWVjaG8gRm91bmQgdmFs
aWQgc2xvdCBBLAo+ICR7Qk9PVF9zeXN0ZW0wX0xFRlR9IGF0dGVtcHRzIHJlbWFpbmluZzsKPiAt
CQkJCXNldGV4cHIgQk9PVF9zeXN0ZW0wX0xFRlQKPiAke0JPT1Rfc3lzdGVtMF9MRUZUfSAtIDE7
Cj4gLQkJCQllbnYgc2V0IG1tY3BhcnQgJHtyYXVjYm9vdHBhcnQwfTsKPiAtCQkJCWVudiBzZXQg
bW1jcm9vdCAke3JhdWNyb290cGFydDB9Owo+IC0JCQkJZW52IHNldCByYXVjYXJncyByYXVjLnNs
b3Q9c3lzdGVtMDsKPiAtCQkJCWVudiBzZXQgcmF1Y3N0YXR1cyBzdWNjZXNzOwo+IC0JCQlmaTsK
PiAtCQllbGlmIHRlc3QgIngke0JPT1RfU0xPVH0iID0gInhzeXN0ZW0xIjsgdGhlbgo+IC0JCQlp
ZiB0ZXN0ICR7Qk9PVF9zeXN0ZW0xX0xFRlR9IC1ndCAwOyB0aGVuCj4gLQkJCQllY2hvIEZvdW5k
IHZhbGlkIHNsb3QgQiwKPiAke0JPT1Rfc3lzdGVtMV9MRUZUfSBhdHRlbXB0cyByZW1haW5pbmc7
Cj4gLQkJCQlzZXRleHByIEJPT1Rfc3lzdGVtMV9MRUZUCj4gJHtCT09UX3N5c3RlbTFfTEVGVH0g
LSAxOwo+IC0JCQkJZW52IHNldCBtbWNwYXJ0ICR7cmF1Y2Jvb3RwYXJ0MX07Cj4gLQkJCQllbnYg
c2V0IG1tY3Jvb3QgJHtyYXVjcm9vdHBhcnQxfTsKPiAtCQkJCWVudiBzZXQgcmF1Y2FyZ3MgcmF1
Yy5zbG90PXN5c3RlbTE7Cj4gLQkJCQllbnYgc2V0IHJhdWNzdGF0dXMgc3VjY2VzczsKPiAtCQkJ
Zmk7Cj4gLQkJZmk7Cj4gLQlkb25lOwo+IC0JaWYgdGVzdCAtbiAiJHtyYXVjc3RhdHVzfSI7IHRo
ZW4KPiAtCQllbnYgZGVsZXRlIHJhdWNzdGF0dXM7Cj4gLQkJZW52IHNhdmU7Cj4gLQllbHNlCj4g
LQkJZWNobyBXQVJOOiBObyB2YWxpZCBzbG90IGZvdW5kOwo+IC0JCWVudiBzZXQgQk9PVF9zeXN0
ZW0wX0xFRlQgMzsKPiAtCQllbnYgc2V0IEJPT1Rfc3lzdGVtMV9MRUZUIDM7Cj4gLQkJZW52IGRl
bGV0ZSByYXVjc3RhdHVzOwo+IC0JCWVudiBzYXZlOwo+IC0JCXJlc2V0Owo+IC0JZmk7Cg==
