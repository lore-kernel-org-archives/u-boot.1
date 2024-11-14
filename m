Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC81DD68B31
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 15:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493F689624;
	Thu, 14 Nov 2024 16:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="PKczYM5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F918962A; Thu, 14 Nov 2024 16:21:33 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3954895D6
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 16:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbN4pQjIWeGHCGmgwh/ZjMI7s9+Vp2bG0K8/7OjDNxB5iJ0V1IJm/6ot6/vdcA68H1VpjuLZjIjwO6jiFv8EkeM9Vvi/nOHe2I/BLhLk+yIPJ0M4nI/PuNHWhTu9ElvFb3If6wy01ZDUtWK14fNC2NqsOCmSCfEQZpQgWaG3ROmoNprSLuDXzB0dmNEkFbyb8OrPvMzetwnbXY+MNW+F3+bWzz6FXP7MG3JSNrSwfHi94JXMOq5dOmPGA/FR+bArNoDpqTA2NMrzqL54XK2pOMfzpEsus8H0VT3+1cTvAUPYXhnaaD95bKTRpOnzuHVG4QJ2JuueYvLJAmTPhAgKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQURbKZ33wLLw8mR2yazu9ukBPz7IYNNcJELAPZjcSo=;
 b=QLzDwYWe88psKb547cUykwg5Toc3n4GRP9ilxFL2GoVgq4gifodpUlzHPLhnVUTAgy8fVwkx6iTS+JXl8xYS6Y7zHJWbT9WeW4o27yQaUfIOknNrJnS2Rc/Zd92iH0kayzFPqIeiyITEa4tud7IGrrx1ALacVsDfdHw10i+6roQce1dUi6F/favuIK5YEMZNwCM4Tf6GXDFXIGPKteZBo+FvFNTK60h4XDmjBhBvYcytE6VOtlK6ILjuLY+C61qnUVqkE5YqFdQo73EpQ//0G6NMMF9QIk8XG9AWRkMrJhZaeTu/SPCZ9F4OjEmE+y8Dkv0chLZSt3NY2ToB+GNNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQURbKZ33wLLw8mR2yazu9ukBPz7IYNNcJELAPZjcSo=;
 b=PKczYM5ysrO0PJvYYvIf0MPOMeyVchPoPHCBF9e3kTXNyjYLQ4Pw9psjPxiG8TfQ2QyiCAdKcMQ89d3jfPMlk/IDzPZ0MGNedruKo/arWUT6SDPg9/NxnBfpo1iWRki4QhWmAzvFnBNIvv2xj8tiB/78EinNl79ixRUk/VYwbM4=
Received: from DU7P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::13)
 by PR3P195MB0667.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 15:21:28 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::7a) by DU7P191CA0009.outlook.office365.com
 (2603:10a6:10:54e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 15:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 15:21:28 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 16:21:27 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Thu, 14 Nov 2024 16:21:27 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Yannic Moog <Y.Moog@phytec.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, Andrej Picej <andrej.picej@norik.com>, "sbabic@denx.de"
 <sbabic@denx.de>, Primoz Fiser <primoz.fiser@norik.com>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Topic: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Index: AQHbNeU4q5bCcuoD+UGXrAKl1foggLK1i7qAgAFJdQA=
Date: Thu, 14 Nov 2024 15:21:27 +0000
Message-ID: <3d979ca81678c2aede5014351d203be30941725f.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-3-c.stoidner@phytec.de>
 <ede9c065-04d3-47de-9d68-0b2c4659a834@phytec.de>
In-Reply-To: <ede9c065-04d3-47de-9d68-0b2c4659a834@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F62F4793F9DA294A87B25A6BC3774811@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|PR3P195MB0667:EE_
X-MS-Office365-Filtering-Correlation-Id: fec376ae-9bdf-4998-d99c-08dd04c002b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU5kaVJUZ3NUUW9rMVQrTUJQcCtOaFlSR2JXclpDaEhnTWVZTWpoTUJOcEpG?=
 =?utf-8?B?bGhNWU1zcE9hYnJQOUUxN2xla0xNazlOTlpjS09MalJDUWMvaWRJblpZMnhS?=
 =?utf-8?B?ZVZjeXJKNmtKNEZJR0NFckVLZXlJV25QcndLbnNxK2FJYmJMU2lLbkIvNVJT?=
 =?utf-8?B?YlJoZTBTd1ZNT0hVL0RVbnM0UmVTZmxaMHdyeG5kUVdIVHlMZE5Yc2l6U3hL?=
 =?utf-8?B?V0Q0THFyNTRJOUVpcjA4UFd0T0hhdENxZTVUMmZaWjJQNUV6dFJyaWZsSWE4?=
 =?utf-8?B?ZDhUL2h6cGo1VkF4TThEcVVrVGFLRlJZSWFvWlY3WnRYSU9CQlRYVnF0bkVP?=
 =?utf-8?B?SE1LWlVTNjNaT0dJWVlNT3RxS2VsYmJJRDhPQkVoK2dGazhkWFlKSFJ5bEdQ?=
 =?utf-8?B?Mnh2SXRDMW1GWTlpUlRRQ0ZmREltOEJVMW5FWWRUVGdFY1JXRUFmWGNVdEJ4?=
 =?utf-8?B?Y1d6YjkwY0NrM2F6RlNUUlAzQU1mQjJ1a2xiY3UzMC9wNEQrRFllcFNFVEU4?=
 =?utf-8?B?ckZTMnBHM3VpQ3d4UjB5c0p1ZnhEMWJDTzhrTmRNSWhIVTJjTHgzZHUzQmdZ?=
 =?utf-8?B?aFBtc0NRRm9RUnlnZ0Mrc29iR0d0RmgrRDZ1SDRCN2dySFZHS3FWUmdTanpk?=
 =?utf-8?B?azhUakdmRTB2WHZVckFHbW16WVNYb0lMTEVmc0VGNWtHUmZreEdkZ2RzOFhF?=
 =?utf-8?B?eFI0VjV0TnlDQ1F2N3dUNWRmS2hJYThSOTJoWHVjOTEzVnhTSGcyVDRpTy8w?=
 =?utf-8?B?L1RWK0xEYzBwT3BLbnNPU3hKZjFpaG15VHlHK0FXM2RkYUswcEs1YUN6ZEZH?=
 =?utf-8?B?NCtyZkVCNlk2WHY3V0xCcFM5TTA2b3M5RXFwMjd5eTRSVWhVRlYzYjJRUUhR?=
 =?utf-8?B?R0grcjBNY2VaVDUyalRTL0p3YVNPTGxkQVIzZUtKaFZDUlh0WEtpUXhwU201?=
 =?utf-8?B?TENYcE9ibS81YzhDcVRURVJZRkFZMVUyL1BBWGJ0R21NQzdCcFFyTDlKbS9Y?=
 =?utf-8?B?b0FQOW55UnN6L2RVK3UrcDA3TUFNUDVaaUxRS1B1R2liVHk0MGRHMVFXZy9V?=
 =?utf-8?B?L0xnQUlkNEE0eHN1dU5Va29KVEF2bjF0VEgxVXJxZ1YzWnRtU2g1VG94NVNW?=
 =?utf-8?B?Zy9hQktmNUIxaW4zVVNEdUJFbi9qVHVOZDFobU5OS1Rrb0xReFl3ZXhMaGdo?=
 =?utf-8?B?cHIxaVplSVFpQXdMWGlEVXBucmNmT25SR2JudGtMU24rNU0vM0F4QUdJZklS?=
 =?utf-8?B?cmQ1YjlNWjlvZzlXTnJyYUF2TWNnZEpnYS9QZ0Jydm1Gb0RlNjMzMUlhNml4?=
 =?utf-8?B?QzFGQ3hSSUR1WXNzOUpEMmZ1a1ZyWmc2bWRBcW5GRnBQVUZMQmsxditldVk5?=
 =?utf-8?B?RjF1bEFNenc3Q2RET2M5dDVpRERvUnNJc1BkMzZFZ1R4MVozZjNiYVRTZ081?=
 =?utf-8?B?RmV6cWJ4di9hUk5nODIyMWIvL2xWdzVLYWliNWNzL1g4LzA5eWtLMWQxWFpo?=
 =?utf-8?B?WnJwWWszSURnL1YzWjNZY3BvbURrcTM0TE55ckc1RytkNExQa2wvMURQRW5P?=
 =?utf-8?B?bnlndDdsOFNBZFJYUDg0SEhQeE5Qd09zUTJlVWdtUGRiajExV1UxcEtBaGJL?=
 =?utf-8?B?TzJoeDRoVDNtbVpCeUZJaEJRTjdsZkpJNWZkOUd2clpFQ3FYbFZObVRIOWtX?=
 =?utf-8?B?R1p1bEFYUkVOakRWNFZNTCtRNTM2WU91ZnBEeTNIMDRqMGZpQnRHbEkyMm8v?=
 =?utf-8?B?ODQzeXNvdm1aV1QwOENYQ0FyZXh0aGMrNk54c1NiMkNlcWhYeHRJYUlRUCtJ?=
 =?utf-8?Q?uC2i6976T4bASqEslqwf1kGnryXOD5WGEDAtc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:21:28.1688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec376ae-9bdf-4998-d99c-08dd04c002b7
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0667
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

DQoNCk9uIE1pLCAyMDI0LTExLTEzIGF0IDIwOjQyICswMTAwLCBXYWRpbSBFZ29yb3Ygd3JvdGU6
DQo+IA0KPiANCj4gQW0gMTMuMTEuMjQgdW0gMTc6MDAgc2NocmllYiBDaHJpc3RvcGggU3RvaWRu
ZXI6DQo+ID4gVGhlIHBoeUNPUkUtaS5NWCA5MyBpcyBhdmFpbGFibGUgaW4gdmFyaW91cyB2YXJp
YW50cy4gUmVsZXZhbnQNCj4gPiB2YXJpYW50DQo+ID4gb3B0aW9ucyBmb3IgdGhlIHNwbC91LWJv
b3QgYXJlOg0KPiA+IC0gd2l0aCBvciB3aXRob3V0IEhTNDAwIHN1cHBvcnQgZm9yIHRoZSBlTU1D
DQo+ID4gLSB3aXRoIDFHQiByYW0gY2hpcCwgb3IgMkdCIHJhbSBjaGlwDQo+ID4gDQo+ID4gVGhl
IHBoeUNPUkUncyBlZXByb20gY29udGFpbnMgYWxsIGluZm9ybWF0aW9uIGFib3V0IHRoZSBleGlz
dGluZw0KPiA+IHZhcmlhbnQNCj4gPiBvcHRpb25zLiBBZGQgZXZhbHVhdGlvbiBvZiB0aGUgZWVw
cm9tIGRhdGEgdG8gdGhlIHNwbC91LWJvb3QgdG8NCj4gPiBlbmFibGUvZGlzYWJsZSBIUzQwMCBh
bmQgdG8gc2VsZWN0IHRoZSBhcHByb3ByaWF0ZSByYW0NCj4gPiBjb25maWd1cmF0aW9uIGF0DQo+
ID4gc3RhcnR1cC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggU3RvaWRuZXIg
PGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiA+IC0tLQ0KPiA+IENjOiBNYXRoaWV1IE90aGFjZWhl
IDxtLm90aGFjZWhlQGdtYWlsLmNvbT4NCj4gPiBDYzogQ2hyaXN0b3BoIFN0b2lkbmVyIDxjLnN0
b2lkbmVyQHBoeXRlYy5kZT4NCj4gPiBDYzogU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+
DQo+ID4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gPiBDYzogIk5Y
UCBpLk1YIFUtQm9vdCBUZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+ID4gQ2M6IFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4gQ2M6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVj
LmRlPg0KPiA+IENjOiBQcmltb3ogRmlzZXIgPHByaW1vei5maXNlckBub3Jpay5jb20+DQo+ID4g
Q2M6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2VqQG5vcmlrLmNvbT4NCj4gPiBDYzogV2FkaW0g
RWdvcm92IDx3LmVnb3JvdkBwaHl0ZWMuZGU+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoN
Cj4gPiAtIGVuY2Fwc3VsYXRlIGhhbmRsaW5nIG9mIGZlYXR1cmUgZmxhZyBWT0xUQUdFIGludG8g
b3duIGZ1bmN0aW9uDQo+ID4gLSBtb3ZlIGRlZmluaXRpb24gb2YgZW51bSBwaHl0ZWNfaW14OTNf
ZGRyX2VlcHJvbV9jb2RlIGludG8gaGVhZGVyDQo+ID4gZmlsZQ0KPiA+IA0KPiA+IMKgIGFyY2gv
YXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaSB8wqAgMTkgKysrDQo+ID4g
wqAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDIgKw0KPiA+IMKgIGFyY2gvYXJtL21hY2gtaW14L2lteDkvc29jLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0NCj4gPiDCoCBib2FyZC9w
aHl0ZWMvY29tbW9uL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgOCArKw0KPiA+IMKgIGJvYXJkL3BoeXRlYy9jb21tb24vTWFrZWZpbGXCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPiA+IMKgIGJvYXJkL3BoeXRlYy9j
b21tb24vaW14OTNfc29tX2RldGVjdGlvbi5jwqDCoMKgwqAgfCAxMTENCj4gPiArKysrKysrKysr
KysrKysrKysNCj4gPiDCoCBib2FyZC9waHl0ZWMvY29tbW9uL2lteDkzX3NvbV9kZXRlY3Rpb24u
aMKgwqDCoMKgIHzCoCA1MSArKysrKysrKw0KPiA+IMKgIGJvYXJkL3BoeXRlYy9waHljb3JlX2lt
eDkzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyOCArKysrKw0KPiA+IMKgIGJv
YXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NSArLQ0KPiA+IMKgIGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL3BoeWNvcmUtaW14OTMuY8Kg
wqDCoCB8wqAgNTEgKysrKysrKysNCj4gPiDCoCBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9z
cGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0OCArKysrKysrKw0KPiA+IMKgIDEx
IGZpbGVzIGNoYW5nZWQsIDMyNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IMKg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9waHl0ZWMvY29tbW9uL2lteDkzX3NvbV9kZXRlY3Rp
b24uYw0KPiA+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9waHl0ZWMvY29tbW9uL2lteDkz
X3NvbV9kZXRlY3Rpb24uaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14
OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gPiBiL2FyY2gvYXJtL2R0cy9pbXg5My1w
aHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+IGluZGV4IDY4OTdjOTFmNGQuLjI1Yzc3OGJi
MDcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUt
Ym9vdC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUt
Ym9vdC5kdHNpDQo+ID4gQEAgLTMwNSw0ICszMDUsMjMgQEANCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gPiArDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgZWVwcm9tQDUwIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYm9vdHBoLXByZS1yYW07DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJv
b3RwaC1zb21lLXJhbTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0
aWJsZSA9ICJhdG1lbCwyNGMzMiI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJlZyA9IDwweDUwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFnZXNp
emUgPSA8MzI+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2Y2Mtc3VwcGx5
ID0gPCZidWNrND47DQo+ID4gK8KgwqDCoMKgwqDCoMKgfTsNCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqDCoMKgZWVwcm9taWRANTggew0KPiANCj4gUGxlYXNlIHVzZSBhIGdlbmVyaWMgbm9kZSBuYW1l
LCANCj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3MuaW8vZW4v
bGF0ZXN0L2NoYXB0ZXIyLQ0KPiBkZXZpY2V0cmVlLWJhc2ljcy5odG1sI2dlbmVyaWMtbmFtZXMt
cmVjb21tZW5kYXRpb24NCj4gDQo+IFdpdGggdGhhdCBmaXhlZCwNCg0KSW4gZmFjdCwgaXQgaXMg
YmV0dGVyIHRvIHJlbW92ZSB0aGlzIGVlcHJvbWlkIG5vZGUuIA0KDQpXZSB3YW50IHRvIGF2b2lk
IHRoZSB1c2Ugb2YgdGhlIGlkLXBhZ2UgYW55d2F5LCBiZWNhdXNlIHRoYXQgSUQgcGFnZQ0KaXMg
YSB2ZXJ5IGNoaXAtc3BlY2lmaWMgZmVhdHVyZSB0aGF0IGNvbXBsaWNhdGVzIGZpbmRpbmcgYSBj
b21wYXRpYmxlDQpyZXBsYWNlbWVudCBlZXByb20tY2hpcCwgd2hlbmV2ZXIgbmVlZGVkLg0KDQpT
byBJIHdpbGwganVzdCByZW1vdmUgdGhlIGVlcHJvbWlkIG5vZGUgaW4gYSB2My4NCg0KPiANCj4g
UmV2aWV3ZWQtYnk6IFdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRlPg0K
