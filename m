Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB1DD4921D
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 13:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972698911E;
	Mon, 18 Nov 2024 14:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="CfUz0OlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336258931E; Mon, 18 Nov 2024 14:09:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F3288DDA
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 14:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzYT2FV9jXEs4SwTebcyiCeLomdcp8Lf99FfuD31+cMFUVGUKwTXBbG2COWlMfeYOfQwRG9FqvSgfOQsNakX6X/USALP9aFfop1YRFxhllula5ZIyX7Skuc0Yk+T173EsvOFukrYpCVPUQ/K6yQB4+yFvkTgRUEAvTGT1i74trfded5esJMYAoNLQtp4pq5gilxZxer+GJxywLYb6KqmLoSXFRlFE1NMsDJqxSp2ficgCW+73sN6fS/XWZfyzQuCwh5RN4xA3BkxWQVwjQb+NFLWqqa85fPLNb1UG1GX8xOwloPNEzNoz6EqYGoMWqZl5jUJ57O4HLMZN42xSgU+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG/NFaKzOK1p3+CbKMhAqXIa0vFxOosvljWgrFDLPpk=;
 b=SoJWfrRFltIMrzth4udTgWH7x5q+lcSSfyHRxooz4XHQc408D8h9m92NC9XAjtFlc3sQiXK65q6bc2T87tZawkmgmNIc7YFzzU1XxwZc2FRvGn83LWcYxYCRrfi1T/PbZcz57lveX0Sek7PNrQFodl82YAqr02arfDQAqWjPeCjndd3gJVr2tEC05sgbtCR54qbtyLgOHC1Co4QEnCxIGqfdetdg1uk0xk0AZl6OUY1cIrUjF196LrO3qAQql/LOwJSQxn8kFIR8R4g/OuS+/Sz1BIk7FDaBK8wRhT7cvezKHrFHfyIXiwnkZFAhSgm/4US3dVwUEI6X8Gtdb6fdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG/NFaKzOK1p3+CbKMhAqXIa0vFxOosvljWgrFDLPpk=;
 b=CfUz0OlMLLuzDaDzjAtBwPIpq650pvJVHVlJVZUaBmHcG1/o8iWyfdyiiZGACC5kq2VAss5hEbVYzSbdnP4m9b274JbXVFXYg4nQeRLuUIj56nl7fMqC9cu40aAORvF+bTbzjbmzKduz9/D19VJH9FJGr9B/5BXAmlgPlfGbIXg=
Received: from AS4P190CA0041.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::15)
 by AS2P195MB2169.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 13:09:23 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::d9) by AS4P190CA0041.outlook.office365.com
 (2603:10a6:20b:5d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21 via Frontend
 Transport; Mon, 18 Nov 2024 13:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 13:09:22 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 18 Nov
 2024 14:09:22 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 18 Nov
 2024 14:09:22 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 18 Nov 2024 14:09:22 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "masahiroy@kernel.org" <masahiroy@kernel.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "trini@konsulko.com" <trini@konsulko.com>, "bb@ti.com"
 <bb@ti.com>, "marex@denx.de" <marex@denx.de>, "leon@georgemail.eu"
 <leon@georgemail.eu>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>
Subject: Re: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
Thread-Topic: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
Thread-Index: AQHbMGGXHF7InSEWBk6OjdXJSPN+urK2YlsAgAH/NgCABKMSgA==
Date: Mon, 18 Nov 2024 13:09:22 +0000
Message-ID: <3396724843f1676d065770333e57803762174646.camel@phytec.de>
References: <20241106153544.1277835-1-sjg@chromium.org>
 <87efb07d6eb10e7c7ad45e8bee741f485931f8de.camel@phytec.de>
 <CAFLszTiqjD3GYP_A--+KGVpyNs9gF=3APkrrwCcqoJo+-3DqEw@mail.gmail.com>
In-Reply-To: <CAFLszTiqjD3GYP_A--+KGVpyNs9gF=3APkrrwCcqoJo+-3DqEw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <27993270E17CCF45A25F1EB2D39D8D95@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AS2P195MB2169:EE_
X-MS-Office365-Filtering-Correlation-Id: 000731cc-4ca4-4233-4807-08dd07d2388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhvcnVtV1dVWDBLMjJqR2pldEhOVEY2ejNvQldxeENRTWNwQ2xPQmdYMEc1?=
 =?utf-8?B?ZkFxRXl5eDZ4cjNZY29aVWN4SmUwRnU3b0JQdEZKZlpkalR2cCt2WSthOVdX?=
 =?utf-8?B?RFBWK3ViZHVzUUJzOTVicWpHcUQ1Nk9OYWZrSVNSbmgvTzdPSHA1RWxyMmZD?=
 =?utf-8?B?S0g0ZldPRks2ZzZrTWFpMUMraTlkNS83SytkSVVlUCtXd1UrZ3ZqSXVGQzFv?=
 =?utf-8?B?bGV3bDN5cnJXdlEyMUp6RUw3RGdPTy9kcnZ3cEUvNGFsMkduYStHUjBYenFW?=
 =?utf-8?B?d1l4Yy8yb3VobEF0Q0ZzSDRGbFpXZnZxTmtpZEg2TzNZQ0FnWnB0VHVXRHZv?=
 =?utf-8?B?enFUM3ZLVU5wenFvT3pLMlNBWjYzMFJFYXlaNW4yai9VVG9WQTlEWHBEUElz?=
 =?utf-8?B?dWpNYmt4dGJuV0N4VE5ubG02NGNqVjN0RW5xL3NSbnJpcU9ERHJNN2xIbHBt?=
 =?utf-8?B?eDMrREZnVTYwMHBDamtyNVF0SXdvUHNhcUZtTy9qOE9kZWF4M1ZRTlVsSGhI?=
 =?utf-8?B?SGE1U1RjTFVteHFaVWpzMXV2ZnVOd01haExsRm05T2ZnaElsOEwwNWpIYk9R?=
 =?utf-8?B?N3VJamNDZnEvWWs5YzIwMjZiSUFFZUdobzZhZHlxb2NaUFRLVFFUNm03NHJu?=
 =?utf-8?B?bU1TdHpUVUc2TmxhSXVtRUxtZXlYcU9hTGhQSzZ3b0JHZWxDY2JWdzFiWVd4?=
 =?utf-8?B?QkN6TVYvd3pkYXhzWlBSN05HNXRGcDZyTnBSV2tNS2lPN2ZlUENPWStxUDB5?=
 =?utf-8?B?RWF6VWZyNERuYi9SOFpTR2hNVjhNMlJteGVWYWE1UWZ1ME8xcExoZ1pRSVRB?=
 =?utf-8?B?M3lTeDdtN05ZVXdzSWIzZC9lMTkvK29id1p0U3VCZml1V2cvR0drQWs1R25w?=
 =?utf-8?B?d0ZlTGlMOHFzeGZqTldnV01NREk3c1FaOW1wUWQ0dUFYNnBnSlpyMVhVc2dj?=
 =?utf-8?B?cG9HK2FFVnRvUXZGL2dQZUUzL2VTMFRLdG5TWSsrRWFTSzdaaVgwY2xVVDMr?=
 =?utf-8?B?aGdiTWg5ZG5rRER5TGJQK1dQK0J1ZEVlZlZ2QTArTlFDZlBmNFFCb1RPVUZh?=
 =?utf-8?B?OGc1NDdWbXZvT3UyZmRZbmFFeVlHR0dyeVNUb1BQWmtvd2VpVzdnaXRTVVdI?=
 =?utf-8?B?RjBxRUt4RkU4K1c4eWdBN255V1BnNGZIOThpMW9ySnJnbjYrNTkrS1ptTDZv?=
 =?utf-8?B?YWV6STNyUjM5VzZoYlhmbU5sMjFUY0p1aHVsUWhFbk9BSGtwVXlWKzFJRXJX?=
 =?utf-8?B?emRRbDI3ZWxhcG5TQStFRFlvRFlHWW1IMmxCeC90VlNtS3Z3bU13MVhsdnp4?=
 =?utf-8?B?alRYZTcrVytYcXpLTHZmc2lYOEJHdFpFYWQzMmdWMk1rME13a282T0VGRDND?=
 =?utf-8?B?WXJFNlVOcFgvdms4aUwwSWJqOVdsdnhER3d6WnY4aVA4NEhBL0huNDBZaEEv?=
 =?utf-8?B?dTQwV2k1NWpuYkNqa0piNlV6TyszbTJzbHNuOUhBTXVVRDJMRk5WWlUwZUJK?=
 =?utf-8?B?WWRwRW5YQ2hPNmlMU3BxVWt1ajhMY3Vta2tMZ2NXTnBPOTBVZmN5Z1Q0QUd2?=
 =?utf-8?B?ZUZpeE9DOU00R2RuYnUvRjI4dVAzYUYyUkR3SElYcG50bWNwSk01YW5jTlF3?=
 =?utf-8?B?aTFqSUQ2aTFlM3hER2duemtvN3FKVWg1bkVmdDJPZTAzd3RlVk03MjJDWC9h?=
 =?utf-8?B?U2pkMDA3blk0KzVHcEFSc3g1S0lpTElHcEMzZEhmQ3NwQXdlL1JCOVRrS2Z4?=
 =?utf-8?B?TUZaVVN0YUxja3JUMzliYTZ5UmpPQWZXSnJTOGhWdGtjckhNVlA4SDMybFE3?=
 =?utf-8?B?K0NiR3pEMFZXYnl1RzRFbmhvSHdnTy9jWXFETCtqY2pOSkdnK3RwWGpabGNW?=
 =?utf-8?B?cFYwcUptSDduUWdNVW96VHBzdzZZUVZ3RXF4eGdaSTdJZGhXM1FiQXVQKzlq?=
 =?utf-8?Q?RCMnzedA8Pk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 13:09:22.9450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000731cc-4ca4-4233-4807-08dd07d2388f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2169
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

T24gRnJpLCAyMDI0LTExLTE1IGF0IDA3OjIwIC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGkgWWFubmljLA0KPiANCj4gT24gVGh1LCAxNCBOb3YgMjAyNCBhdCAwMDo1MSwgWWFubmljIE1v
b2cgPFkuTW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIFNpbW9uLA0KPiA+IA0K
PiA+IE9uIFdlZCwgMjAyNC0xMS0wNiBhdCAwODozNSAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6
DQo+ID4gPiBUaGlzIGZsYWcgd2FzIGxvc3QgYnkgYSBwcmV2aW91cyBjaGFuZ2UgYW5kIGhhcyBu
ZXZlciBiZWVuDQo+ID4gPiByZXN0b3JlZC4NCj4gPiA+IFdpdGhvdXQgaXQsIGJpbm1hbiBjYW5u
b3QgZnVsbHkgaGFuZGxlIG1pc3NpbmcgYmxvYnMgd2hpY2ggYXJlDQo+ID4gPiB0aGVtc2VsdmVz
IGlucHV0cyB0byBta2ltYWdlLg0KPiA+ID4gDQo+ID4gPiBEaXNjdXNzaW9uIG9uIHRoaXMgYXQg
WzFdIGluZGljYXRlZCB0aGF0IHRoaXMgd2FzIG5lY2Vzc2FyeSBidXQNCj4gPiA+IHRoZQ0KPiA+
ID4gcGF0Y2ggd2FzIG5vdCB1cGRhdGVkLg0KPiA+ID4gDQo+ID4gPiBSZXN0b3JlIHRoZSBmbGFn
IHNvIHRoYXQgYWxsIG1pc3NpbmcgYmxvYnMgYXJlIHJlcG9ydGVkLg0KPiA+ID4gDQo+ID4gPiBM
aW5rOg0KPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3Bh
dGNoLzIwMjIxMjA2MDIwMzM2LjMxNTQ2NS0xLXRyaW5pQGtvbnN1bGtvLmNvbS8NCj4gPiANCj4g
PiBzb3JyeSBJJ20gcGlja2luZyB0aGlzIHVwIHNvIGxhdGU7DQo+ID4gQXMgSSBhbSB3b3JraW5n
IG9uIE9QLVRFRSBhZGRpdGlvbiB0byBpbXg4bSBib2FyZHMgWzFdLCB0aGlzIHBhdGNoDQo+ID4g
Z290IG15IGludGVyZXN0Lg0KPiA+IEkgYXBwbGllZCB0aGUgcGF0Y2ggb24gdG9wIG9mIG15IHBh
dGNoc3RhY2sgYW5kIHRyaWVkIHRvIGJ1aWxkDQo+ID4gKHBoeWNvcmUtaW14OG1wKSB3aXRoIG1p
c3NpbmcgdGVlLmJpbg0KPiA+IGJpbmFyeSBhbmQgZ290IHVuZXhwZWN0ZWQgcmVzdWx0czoNCj4g
PiANCj4gPiANCj4gPiBJbWFnZSAnaW1hZ2UnIGhhcyBmYWtlZCBleHRlcm5hbCBibG9icyBhbmQg
aXMgbm9uLWZ1bmN0aW9uYWw6DQo+ID4gdGVlLmJpbg0KPiA+IA0KPiA+IEltYWdlICdpbWFnZScg
aXMgbWlzc2luZyBvcHRpb25hbCBleHRlcm5hbCBibG9icyBidXQgaXMgc3RpbGwNCj4gPiBmdW5j
dGlvbmFsOiB0ZWUtb3MNCj4gPiANCj4gPiAvYmlubWFuL3NlY3Rpb24vZml0L2ltYWdlcy90ZWUv
dGVlLW9zICh0ZWUuYmluKToNCj4gPiDCoMKgIFNlZSB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgeW91
ciBib2FyZC4gWW91IG1heSBuZWVkIHRvIGJ1aWxkIE9wZW4NCj4gPiBQb3J0YWJsZQ0KPiA+IMKg
wqAgVHJ1c3RlZCBFeGVjdXRpb24gRW52aXJvbm1lbnQgKE9QLVRFRSkgYW5kIGJ1aWxkIHdpdGgN
Cj4gPiBURUU9L3BhdGgvdG8vdGVlLmJpbg0KPiA+IA0KPiA+IFNvbWUgaW1hZ2VzIGFyZSBpbnZh
bGlkDQo+ID4gDQo+ID4gDQo+ID4gU28gYnVpbGQgZmFpbHMgZXZlbiB0aG91Z2ggdGVlLmJpbiBp
cyBtYXJrZWQgYXMgb3B0aW9uYWwuDQo+ID4gRGlkIEkgbWlzcyBhbm90aGVyIHBhdGNoIHRoYXQg
bXVzdCBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggdGhpcw0KPiA+IG9uZT8NCj4gPiANCj4g
PiBCZWZvcmUgdGhpcyBwYXRjaCwgSSBzZWUgdGhlIGZvbGxvd2luZyBvdXRwdXQuDQo+ID4gDQo+
ID4gDQo+ID4gSW1hZ2UgJ2ltYWdlJyBpcyBtaXNzaW5nIG9wdGlvbmFsIGV4dGVybmFsIGJsb2Jz
IGJ1dCBpcyBzdGlsbA0KPiA+IGZ1bmN0aW9uYWw6IHRlZS1vcw0KPiA+IA0KPiA+IC9iaW5tYW4v
c2VjdGlvbi9maXQvaW1hZ2VzL3RlZS90ZWUtb3MgKHRlZS5iaW4pOg0KPiA+IMKgwqAgU2VlIHRo
ZSBkb2N1bWVudGF0aW9uIGZvciB5b3VyIGJvYXJkLiBZb3UgbWF5IG5lZWQgdG8gYnVpbGQgT3Bl
bg0KPiA+IFBvcnRhYmxlDQo+ID4gwqDCoCBUcnVzdGVkIEV4ZWN1dGlvbiBFbnZpcm9ubWVudCAo
T1AtVEVFKSBhbmQgYnVpbGQgd2l0aA0KPiA+IFRFRT0vcGF0aC90by90ZWUuYmluDQo+ID4gDQo+
ID4gDQo+ID4gV2l0aCBzdWNjZXNzZnVsIGJ1aWxkLg0KPiANCj4gVGhlIHByZXZpb3VzIGJlaGF2
aW91ciB3YXMgYSBidWcsIGF0IGxlYXN0IHRoYXQncyB3aGF0IEkgY29uY2x1ZGVkLg0KPiBJdA0K
PiB3YXMgaWdub3JlZCBzZWN0aW9ucyB3aXRoaW4gc2VjdGlvbnMsIGluIHNvbWUgY2FzZXMuDQo+
IA0KPiBEbyB5b3UgaGF2ZSB0ZWUgaW4gdGhlcmUgdHdpY2U/IEl0IHNlZW1zIHN0cmFuZ2UgdG8g
Z2V0IHRoaXMgY2FzZS4NCg0KTm8sIG5vdCBhcyBmYXIgYXMgSSBhbSBhd2FyZS4NCg0KPiANCj4g
SWYgeW91IGNhbid0IGZpZ3VyZSBpdCBvdXQsIGNhbiB5b3Ugc2VuZCBwYXRjaGVzIG9yIHNoYXJl
IGEgdHJlZT8NCg0KWWVzLCBJIGRpZCBzdXBwbHkgcGF0Y2hlcyBpbiBteSBwcmV2aW91cyBjb21t
ZW50LCBzZWUgWzFdIChCYXNlZCBvbiBpbXgNCnRyZWUpLg0KDQpBbnl3YXksIEkgZGlkIHNvbWUg
ZGlnZ2luZyBpbiBiaW5tYW4gYW5kIHNvIGZhciB0aGlzIGlzIHdoYXQgSSBmb3VuZDoNCg0KU2lu
Y2UgaW4gdGhpcyBwYXRjaCB5b3UgYWRkIC0tZmFrZS1leHQtYmxvYnMgdGhlIGRlZmF1bHQgRmFs
c2Ugd2lsbCBiZQ0Kb3ZlcnJpZGRlbiBpbiB0aGUgY2FsbCB0byBiaW5tYW4uIA0KVGhpcyBUcnV0
aCB2YWx1ZSBpcyBwcm9wYWdhdGVkIHVudGlsIHRoZSBmb2xsb3dpbmcgaGFwcGVuczoNCg0KRW50
cnlfdGVlX29zLk9idGFpbkNvbnRlbnRzKCkgLT4gRW50cnlfYmxvYi5PYnRhaW5Db250ZW50cygp
wqANCih0aGlzIGNhbGxzIGdldF9pbnB1dF9maWxlbmFtZSgpIHdoaWNoIHJldHVybiBOb25lIHNp
bmNlIHRlZSBpcw0KbWlzc2luZynCoA0KLT4gRW50cnkuY2hlY2tfZmFrZV9mbmFtZSgpLg0KY2hl
Y2tfZmFrZV9mbmFtZSBzZXRzIGZha2VkIHRvIFRydWUgYW5kIHRoaXMgY2F1c2VzIHRlZS1vcyB0
byBiZSBhZGRlZA0KdG8gdGhlIGxpc3Qgb2YgZmFrZWQgZW50cmllcyB3aGVuIGNvbnRyb2wuQ2hl
Y2tGb3JQcm9ibGVtcygpIGNhbGxzDQpFbnRyeV9ibG9iLkNoZWNrRmFrZWRCbG9icygpIGxlYWRp
bmcgdG8gdGhlIG91dHB1dCBpbiBteSBwcmV2aW91cw0KbWVzc2FnZS4NCg0KWWFubmljDQoNClsx
XQ0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2xpc3QvP3Nlcmll
cz00MzE2OTUmc3RhdGU9Kg0KDQoNCj4gDQo+ID4gDQo+ID4gWWFubmljDQo+ID4gDQo+ID4gWzFd
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjQxMTA3LXBoeXRlY19pbXg4
bV9vcHRlZS12Mi0wLWJiYzM3NDdhNjBlOEBwaHl0ZWMuZGUNCj4gPiANCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+ID4gPiBGaXhl
czogOTM2ODVkMGRjYjkgKCJNYWtlZmlsZTogV2l0aCBCSU5NQU5fQUxMT1dfTUlTU0lORz0xIGRv
bid0DQo+ID4gPiBlcnJvciIpDQo+ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gQ2hhbmdlcyBpbiB2
MjoNCj4gPiA+IC0gVXNlIExpbms6IGFuZCBhdm9pZCBhIGxpbmUgYnJlYWsNCj4gPiA+IA0KPiA+
ID4gwqBNYWtlZmlsZSB8IDMgKystDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL01ha2VmaWxl
IGIvTWFrZWZpbGUNCj4gPiA+IGluZGV4IDcyNzVhMDJmMjRjLi5mOTJmNDZiM2FiNyAxMDA2NDQN
Cj4gPiA+IC0tLSBhL01ha2VmaWxlDQo+ID4gPiArKysgYi9NYWtlZmlsZQ0KPiA+ID4gQEAgLTEz
OTgsNyArMTM5OCw4IEBAIGNtZF9iaW5tYW4gPSAkKHNyY3RyZWUpL3Rvb2xzL2Jpbm1hbi9iaW5t
YW4NCj4gPiA+ICQoaWYgJChCSU5NQU5fREVCVUcpLC1EKSBcDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAtLXRvb2xwYXRoICQob2JqdHJlZSkvdG9vbHMgXA0KPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJChpZiAkKEJJTk1BTl9WRVJCT1NFKSwtdiQoQklO
TUFOX1ZFUkJPU0UpKSBcDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWlsZCAt
dSAtZCB1LWJvb3QuZHRiIC1PIC4gLW0gXA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAtLWFsbG93LW1pc3NpbmcgJChpZiAkKEJJTk1BTl9BTExPV19NSVNTSU5HKSwtLQ0KPiA+ID4g
aWdub3JlLW1pc3NpbmcpIFwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLS1hbGxv
dy1taXNzaW5nIC0tZmFrZS1leHQtYmxvYnMgXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAkKGlmICQoQklOTUFOX0FMTE9XX01JU1NJTkcpLC0taWdub3JlLW1pc3NpbmcpIFwNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1JIC4gLUkgJChzcmN0cmVlKSAtSSAkKHNy
Y3RyZWUpL2JvYXJkLyQoQk9BUkRESVIpDQo+ID4gPiBcDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAkKGZvcmVhY2ggZiwkKG9mX2xpc3RfZGlycyksLUkgJChmKSkgLWEgb2YtDQo+
ID4gPiBsaXN0PSQob2ZfbGlzdCkgXA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JChmb3JlYWNoIGYsJChCSU5NQU5fSU5ESVJTKSwtSSAkKGYpKSBcDQo+ID4gDQo+IA0KPiBSZWdh
cmRzLA0KPiBTaW1vbg0KDQo=
