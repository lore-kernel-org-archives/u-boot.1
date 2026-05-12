Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C780CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE59D803C6;
	Tue, 12 May 2026 09:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="EZdLrXtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9514781E18; Tue, 12 May 2026 09:13:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98331801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL4ttOTND+Gf2QGl10QC3K4OpVcP9I+cTPHD26g7A6D14NmDeiLKCPd8ib92UFJGj14TRHAE6a0K1mZBPE57LX3HkVrNi9Nuc4uqlgcVQ/gP2ybQBy6nQ08a5qhNJQya5Oauyx0Z2n/WdqiOj8zbMfOuke/57GkDqWvB7jGDglEmAqqNq6BvAG5EE5WN7YdRsoW36XTVW0Ur6aEBiX6dELLnK4X55pjrYNA791agaS/E2aopqk9j10wweGFbiqwRgi8umEpJBnKI02Gi4NVEFBsn7Lv9mme1V7x/pvFbOwJ21ACMK+g6iBVmnU/nc3ScwrvTYPthpCT8hrrFve+1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+YLoRpF2iAlW5jMUeOuhh3FEhIE0VdBfZDwHdQGEWY=;
 b=SGd3Zs/sVXv44RwgIxViUyMNLs6lkFAarZ36MbBog0NgsywyNWi7rU3drPCQI1jnwGxwzdrybDE6TSo43kKLV8/Q5FCIspoS8WDY161r0ST/3c+WjKJpkppDpotLVC6c+QSuJxCUEuZGxKgICWGSl0/y56oGoKWh1p8CNp1e+/uJ16glYo5A/5lbwri6BGEkP5AZVuKsNwJN3/ASe+98jwdJ/fiUsfB5qX9rRT29fEcS9QeCZ3GH39ayuRUX3mMFwMBBwDibC/TTsLMTg4qVfseWepG1hTWFBGtegR7MaCzIBv0ZQG3PSTQsc+U4ts6o0g4ndyNhCHWC4wKBL1HdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+YLoRpF2iAlW5jMUeOuhh3FEhIE0VdBfZDwHdQGEWY=;
 b=EZdLrXtCtG5NQHQBScyUM8WI512zzEDdbrjpdW16jAJub+KRLv1zYYd1zOorGbm7poyWt8X3JqdJ5+kq82N6B/5dYVQGetSe7Mvu24/UGGWNudXMz7l8ARmMV/8AM/ASnY79lWuQSD9JRaTZLIbjc+kPO7dGP9M6I4IvHqolyewECcL8ELv4i3OVRJB/v0H3dJGKShNJVXvmW7ejjk/to18BAlz5Uj9AlDNhO0LEJD6CS8MgqgpgIlAdVjYPxZJaTGDvD1A6llFsE+OcBiF67ZAeBg7YN1BC/B9odTcdjpLGjDz7bY5jLly0CxcXxVM+GXlkGwep8ya4TRMuSfqqew==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:310::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 07:13:36 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:13:36 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] nxp: imx9: rename get_reset_reason() ->
 print_reset_reason()
Thread-Topic: [PATCH 2/4] nxp: imx9: rename get_reset_reason() ->
 print_reset_reason()
Thread-Index: AQHc4YKaBUvgzW39HUi0k4Hie4irDbYJ8Z6AgAAJDoA=
Date: Tue, 12 May 2026 07:13:36 +0000
Message-ID: <378666b27727d98f7af6b81a13386c24d90aa602.camel@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
 <20260512064111.GA5820@francesco-nb>
In-Reply-To: <20260512064111.GA5820@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9636:EE_
x-ms-office365-filtering-correlation-id: cd944af6-2b44-4280-8a06-08deaff5fc2d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|38070700021|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: GrRHvSTSWcEd33BmHfukkDaCt1+y/cSd2WQtWCYyPynsZNIRyfKRzr/EO5Nat2icP1vjTxSXxUVFAODKlWG8fLTfdlLRe1I9Fb6aDzKc3w2Jyk2fE4JXj8RFYIiddEpbFlydRAZgyb0aRBTQVXENdKVTwF6L3tuBLj91ywguudhJanwx58bxDUduOsFneG75iMqMVultkC7IkclCTyHuo5CW85K+3cJSzn734vqK06wTKdumUNTbGHLcloH4i1uZ7DlH5+MET952vksRuY7uBroy/+V3TRij5YcdcdFORAoCjXr79hh+E9IUVtD6tWtiGwkIxhGooP2afXupbutdfFI7OjSbuVDDtdLPBR8u9o6FEoDAfNHb2lUuqpZapurnwgripELC4m8NWLknWsZqvia2AyVrv5PZ5m1pz/WdhdmwJ9ci51yRvrbZZfLIDVYhavIMM5KDzwsv/l5dPgdiAIcgv92MSy2uzPKUyef0TYHdXsfrmruYfuuOcaD8xyjJkJ/rpg3lKGcYqeGphLRYKb3WHSQ8/sRvzTqXbMyUxFyh5fuqgAZDF3VD2nLl7zpkNMnpuMRiq0sxHiQiHZQhmrLrdzxv0CnUmE9EvMYQNKy2NPhfLsVP91DvOKcFmuVKPK/UKxlqMuV4A7oL+d0TlbquZJE5+22Yv/rVdQsY0eNWKCRRX1klqce5IbRlNNlKCHtjLgKEQ3JRfARLJMH49g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXI5RlU1dldreW9NMFRJNFc5Y0dHd0craURJeklCcW1tK09uV1ZGN3QwSE1E?=
 =?utf-8?B?OEUwSi9EbDVZcTFLMHVKWEtJZEtEMzZPMWJlTDdaSDNhWFAxS1p0MVNHM09D?=
 =?utf-8?B?L0tpQjdndUtiMytzSXFpakdTcWQyT2lvRHlpczZyYUFwYWwvQndTZzJiNCtE?=
 =?utf-8?B?MW01dE8weGVGL0Y2OTBFR2t5eUxwVEQ5d2dvOEhFM2h6ckplamRENng0anh3?=
 =?utf-8?B?eUxrdU9adFB5dlZxcFN1d3dVdGxJWlJ5TWlSeHk1Yi9nN3EwSjNJbkhmbDRJ?=
 =?utf-8?B?WTNPakkzUDlsWWNhOGkyMS9IRXUvY3J1WEhWMVNyL25DaDFvNk9LMEVKN1Jo?=
 =?utf-8?B?S1pTbWhna0FEZmtHc3kvUHRBOVB5cmUrRkxINGs0Um9aUDBtbjd0UldxeC90?=
 =?utf-8?B?QkJEN1VWQUlmandNZVd1ZzlwQ05jd3lFOE5OZWJ2M05Xb3BUUXJEM1VsazNm?=
 =?utf-8?B?QTZQczFIRWhRSG15WjU4RVdPTHZ0cDVCeUZ0MGhFczdUR2YyVE5EZWloa1hQ?=
 =?utf-8?B?UGJZd3pLT1BRVm5sYUs3Q3QzUDM2R00xdmN4YmhYUHpZenJ6UWExRFlqcXhQ?=
 =?utf-8?B?ZXJrNS9zNGk0WXYrVXBab0h2amtzanIxTzhRdTJ5eXhjTXl0L0g4VFRBemh6?=
 =?utf-8?B?dGlCbnZ2ODYyNW9JdzI3amdZaVBQNkpzOWg4bmhDQ0UzZHpSUFovK3kxVlJM?=
 =?utf-8?B?UmxRR2Qrck5CWVcwcGwvb3RBNVVWT3dBeGF5TFRFU2xQT2tiL0EwZE5xbDZT?=
 =?utf-8?B?Y1lqdUJRbXByQWk0UjZvcTMzclFXbXdMN2tXNjhQa0Ira1RIaEJzNTRvTlBL?=
 =?utf-8?B?UzdBY2ZFZC8yT0Rud3hjcm5WMVFSTno0TE9NSnB4WFI5b2J0T01Vclo4YVla?=
 =?utf-8?B?NEU2cEhuZ0Yxbkp0RzREcStsRWovNmdlb3JiMnhmK1hjK0ZMZUczdVRmUGh4?=
 =?utf-8?B?Sk8vSFBKTjZpNmx5QjZ4eXdEZ3pldHE3UjRpZjRGeDBReGRjSHZ1Zm9yQ2dV?=
 =?utf-8?B?ZmtFS3lsMnJ2RTM3K01SUTJzK0hQRmxsUGdSdGJDaGZBc0IrcTRONi9MbDdM?=
 =?utf-8?B?cVJvRllOOXJabXdtU2Q3WlVsOEgwSUR0UWZtU0x3eE5aR25OT3ZIZElWdDlh?=
 =?utf-8?B?TUNwL0pzK2hTWEZwZ0FoVDNKeFFUcFdQV21YeGZpUkYwOEo4N29IWUNvTmkx?=
 =?utf-8?B?QmwzZ1JDMncybFpGWldESEgycVFYVk5XcDJpalZ5RmdHM0RHNVIyWGxHbWha?=
 =?utf-8?B?TzFTVnJxWG1TTGhPendMSmk5b0pvZjY4ZzBrUGs4WWZxTU1oVUM3SjErZllx?=
 =?utf-8?B?d05GMi9aSDg3bGNwdXFSVWYyVXkzMFhCMXVwc0lDTitOR254YWNUZWZhNy9N?=
 =?utf-8?B?WU4xTTN3b1FsSThMSUVyNDBNaHp2ZXJ1ZEptcWlkeU9HbDgxbXl1dmMwTmFL?=
 =?utf-8?B?clNCWHVNWGVTdDFhTlhlOHppSkZELzB4bUZ5bmVBN1Jwa3FkSTJibGNrK3F2?=
 =?utf-8?B?bzZiaVVRMkh4MDV2elZnYnhEY2FEdWk2TDVKdXdBK1hScVJyM0NQU211aUth?=
 =?utf-8?B?VUZsbGxQNk4zejdYN0s4cTZ3TWFYQ2ozVkVuZ2JacENBL05vZkd4V0Y2UEtx?=
 =?utf-8?B?V3F3TGhJUjAvcERDaVc2aGlYVkRhMFlDV0xqdUNJSGh6Q2lKMHN1c2hHL29V?=
 =?utf-8?B?M28yOGRiTUdpeURzSU55aU5PTEJ4ZmxPQ0hDWHJWQVBmT2pSYUVkSWlmWnJU?=
 =?utf-8?B?eXVLTmhCNDVmcVlOWVR2YzJnUkgrdDNoeEV5bHZ1Tm00YkFFVTlNQndFZUVz?=
 =?utf-8?B?bDNKMG8vS3VwTTBCOGVBQ3dIb284dVBjUUZXM0dFcjdaUWpiamtLYWxid1Vx?=
 =?utf-8?B?QkhYd0xsZWNITTJ2bDRGZi81RGs3YnFjMlRWbWI1ZnVVNytyRkpWc2JzanVh?=
 =?utf-8?B?V0ZaK2s1YjNpMmNhYi9ZNW5ueDdYRDlReU1WQzYvcnFTODBsYXZxNmdtWjJ2?=
 =?utf-8?B?TjUwaTdiYVVzSEdHcWM2UWhNb0FwcHNsSFJnZGZCa3JXSzkrbW1XbEFUTVRN?=
 =?utf-8?B?R1d4UytIRnBKUUNUM21WeE9LRXdwUXJIbGsyUmV5U0l5SkROdlNNU3ljTkpN?=
 =?utf-8?B?YWJzTjJNTVl2MGdLd1FCRGY5bTRxbGtYbzBKLzFjVHhvSzlrWmh6WjB4cHhD?=
 =?utf-8?B?Q0VZTFF0UmF3R3VUNExrbHhKTmY0T2lqUW8zM2xtMDlmN1hxTmJKU1poUmZH?=
 =?utf-8?B?VDVDRTlFZnRMaTczS0h3Z04ycGZSa1Q1cFVFc0IxQXBaa0UxODZQZ282MkEv?=
 =?utf-8?B?NldOT2hmaVM2a01UbThRWENndTJTTG96UTJ5TDgwVXNwOThUejFxREk0Sndi?=
 =?utf-8?Q?c2S1ANxnLWPKyRyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D022F3F01F7EC43A5C440E208354B76@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd944af6-2b44-4280-8a06-08deaff5fc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:13:36.5569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXZieSSDLWBjcq7F+EF64HBM4HxsNX1JpnQle87LH+2NOYmIoKcCMGyNvUJMW2eCcrVXtBrIOCi0vY4MfdSS0y7GbA7foLOSv3THb0C+piQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9636
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

SGkgRnJhbmNlc2NvLA0KDQpPbiBUdWUsIDIwMjYtMDUtMTIgYXQgMDg6NDEgKzAyMDAsIEZyYW5j
ZXNjbyBEb2xjaW5pIHdyb3RlOg0KPiBPbiBNb24sIE1heSAxMSwgMjAyNiBhdCAxMDoxMjozMVBN
ICswMjAwLCBBLiBTdmVyZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4g
PGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBSZW5hbWUgZ2V0X3Jl
c2V0X3JlYXNvbigpIGludG8gcHJpbnRfcmVzZXRfcmVhc29uKCkgYXMgdGhlIGxhdHRlciBiZXR0
ZXINCj4gPiBkZXNjcmliZXMgdGhlIGZ1bmN0aW9uYWxpdHkuIGdldF9yZXNldF9yZWFzb24oKSBj
YW4gbm93IGJlIGEgZ2xvYmFsIHN5bWJvbA0KPiA+IHByb3ZpZGluZyBhIHJlc2V0IHJlYXNvbiBh
cyBzdHJpbmcuDQo+ID4gDQo+ID4gTm8gY2hhbmdlIGluIGJlaGF2aW91ciBleHBlY3RlZC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCBhcmNoL2FybS9pbmNsdWRlL2FzbS9h
cmNoLWlteDkvc3lzX3Byb3RvLmggfCAyICstDQo+ID4gwqAgYXJjaC9hcm0vbWFjaC1pbXgvaW14
OS9zY21pL3NvYy5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+IMKgIGJvYXJkL254cC9p
bXg5NF9ldmsvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0K
PiA+IMKgIGJvYXJkL254cC9pbXg5NV9ldmsvc3BsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgMiArLQ0KPiA+IMKgIGJvYXJkL3RvcmFkZXgvc21hcmMtaW14OTUvc3BsLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiANCj4gSXQncyBtb3JlIHRoYW4ganVzdCB0
aGVzZSBib2FyZHMNCj4gDQo+ICQgYWNrIC0tY2MgLWwgZ2V0X3Jlc2V0X3JlYXNvbiBib2FyZA0K
PiBib2FyZC90b3JhZGV4L3ZlcmRpbi1pbXg5NS9zcGwuYw0KPiBib2FyZC90b3JhZGV4L3NtYXJj
LWlteDk1L3NwbC5jDQo+IGJvYXJkL254cC9pbXg5NTJfZXZrL3NwbC5jDQo+IGJvYXJkL254cC9p
bXg5NF9ldmsvc3BsLmMNCj4gYm9hcmQvbnhwL2lteDk1X2V2ay9zcGwuYw0KDQp0aGFuayB5b3Ug
Zm9yIHRoZSBxdWljayByZXZpZXchIFlvdSBhcmUgcmlnaHQsIEkndmUgbWlzc2VkDQp0d28gYm9h
cmRzISBXaWxsIGNvcnJlY3QhDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==
