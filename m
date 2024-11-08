Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3025D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 12:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40981890AD;
	Fri,  8 Nov 2024 13:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="G1UnR58O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3219B88278; Fri,  8 Nov 2024 13:59:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2A28900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 13:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+Fo/9XBFI3F0SX8Yt17EYUHVS9J17p7/NWI/uELT1xx7xHQgOLxJpUJyVx9KYV4TNm+DIytBJsfYblXXCyqkU344pvMVlPEz5iTe1c0E3WxUL7ZOsio+o/NVpBTSVO/yF9a4Ruy4z0zA/541lL/h5AgJvrRUqvo316zLUTsn7AjpaSSkB33ZvgC9KFn/7lvCGghA+UNgDW7s3EBy+FwtOPm2EHUi8oKlFVUOZCw565vMiSLHGkwE8Dpx1e/rZNYrYbmVKizpzsZys0leZSa2HRoPka97TWHbvFLcSEVWFAI0aPVWXKs4ui6fL+StUw6n++75B29pOSibQheDQwJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmLeBjdcwB8x3Py/ddWh0pbppOcQM0+6qbx37KRlFXk=;
 b=jSrzKIbp7gK11AG+l0u1EwX2XQ/AowNjRbvCy+L3Buxs9nvC5MSS589JxpIbRdQFT4oSp5yFkW3C3Ta/bPB0luFnz8hvLCCji2W2ZxKuw7QqaAoC2MGjhLngeNCd/xTOtwNI9kKuSsxfm0hWmzMeYPX+PBBOgNMvE31xtgxYyMVsId1DTOqsQ/kxYcoW7Dai1vH1u/g5atoBHwbi+u7pq3Qjt/doZXR6RP9T3mVIJEos3RoYCaB6PbdGcRSlyclmAryIZEFRQ9InUBXGw/6tPcwfzc52ebkM+bSizMV4z3Knqh4QhWZKKScF9GZbSdHj3o30cq4KD8tmx5C+pvWgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmLeBjdcwB8x3Py/ddWh0pbppOcQM0+6qbx37KRlFXk=;
 b=G1UnR58OSlbNtOR0gQ4YCSlAYAT4CePXIX0wncK6ZE24NLr8CUUO3+gKu7+p44zA8IfpFL8xUIyQ1m/O5euwzf18DiJhUmOr3nvaCyv46fvIX70MscQcAAO6O2Y+DwImq76HgaSeA0SPMnAS6jlQPBEk44TssJa2RwIKEExHt0g=
Received: from DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) by GV1P195MB2034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 12:59:44 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::5c) by DUZPR01CA0185.outlook.office365.com
 (2603:10a6:10:4b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 12:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 12:59:44 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 13:59:43 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 13:59:43 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 8 Nov 2024 13:59:43 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "manut@mecka.net" <manut@mecka.net>, Yashwanth Varakala
 <Y.Varakala@phytec.de>
Subject: Re: [Upstream] [PATCH v2 5/6] doc: phytec: imx8mp: add OP-TEE
 documentation
Thread-Topic: [Upstream] [PATCH v2 5/6] doc: phytec: imx8mp: add OP-TEE
 documentation
Thread-Index: AQHbMO5malsLW26QLEiFj13roW5CCLKrdmAAgAHTKIA=
Date: Fri, 8 Nov 2024 12:59:43 +0000
Message-ID: <9a0a95e37095d1f4212df56fda58f19b8e7fbc48.camel@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-5-bbc3747a60e8@phytec.de>
 <1f2af2cd-47bf-4267-b7f7-13c08c3ab4e8@phytec.de>
In-Reply-To: <1f2af2cd-47bf-4267-b7f7-13c08c3ab4e8@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2B3F4FBDDA1A94CB7BD8E33F726BD77@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|GV1P195MB2034:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3c58a9-474c-4f79-41cd-08dcfff53787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHJ1aGVvaVhwUC9sdTVTd1A3eXdiS3NYYnZlLzcycDBtZWw4dGxXU2dxY1F2?=
 =?utf-8?B?TUk3SmxTZlpHamhneGc0MEdqMGhrYTQ2cG91Nyt0aGFpb1ZIZzlRbU9TYkl5?=
 =?utf-8?B?OFFrSkhDZS9JWGcyVytOUHR0Ly9GZkhWMlhWVTNDSTRNaFhpRHpVQzFKTGhR?=
 =?utf-8?B?anJzdURwbFRIdGRMMmxGcWJIK3grNk1HaFR3djM3R1dRWHpweFBpczRHRDMw?=
 =?utf-8?B?bStsSHN3MTFFSE52RFFyT3pqcTVRcENuai9KMHJVZXpPZVVyK2xxSHpNODF0?=
 =?utf-8?B?aGpaaHFDMFdLYzFWKzBkL3p4S0hlTjh1ZEhMZ3craWUvaDJYRmhMNlpkY1Bm?=
 =?utf-8?B?c1g0ZmtWN0lFZTRaN0FoZ3hFNysweVphS1NOdmp0Mnphc1dBWU9zRXVpSDN1?=
 =?utf-8?B?UVNwVmNVNDVFQVFnU1VVRXdibDhRUjI0c3p6aFBjbHk1eG8yWjBjOVQ1ZS8r?=
 =?utf-8?B?bC9JQVNHbjBqRVhaTHREcVRxUGlIcjdhMTk3bEc2N1BSYmZlSXNNbmxHY0kz?=
 =?utf-8?B?a2owRE9mQW9UZ1lEbTFVM2s0aXpIcEVHdmVrZ1hsaS84TlcxY0hkd0MrZEd1?=
 =?utf-8?B?aEdzNHBKenpib0lCMC9za3FhMmxuYmYxdWdzSEVSNkhFVjljZk96TUVUQU9W?=
 =?utf-8?B?QlQ3QXRralBzaDNhckUweGdxR1RzN1ZrUmM2V1k1R0k4L1BmbElqdXllUWZ4?=
 =?utf-8?B?a1dTUlZBNVNGT0dDSGhDcWtHNVRveEJpWk5yTHlLZHBBNDVOcEs1K2RSei9o?=
 =?utf-8?B?bW90ajd1T3c1cElXVldxMVcwYmRvaGVwNGVXditrK2RmbmJzNWRLS1dpZU0z?=
 =?utf-8?B?VVlsc1dNaW9RUG14YXhaL1BpejBUaXlTYndwdzhxWUx5eG1EYXdlMm5odXk1?=
 =?utf-8?B?MXpGRENEd2pCa09PRkZ5TU5yVklvQ3dRQ25BUktwbWZSUGcramZ2YXE2Zjll?=
 =?utf-8?B?YlFMYXZHazZjanRvZ2g2TW5IY09HKytRd3YwRnlBa2daQUw0dHJGcmEvd0hL?=
 =?utf-8?B?U0w4YjVjVlRqZVVNR3BHMWIrc2Nna3ZMeVdEUWl1ZFdGa0xTNlBpeDZveGs1?=
 =?utf-8?B?Yk9SSmlKMkdzS0tIY0NnSld0VHBqNkw3SVE0VHZhMmtDbVA3MHp1VWZBRTFa?=
 =?utf-8?B?K3Nxblo1RlpmbGllalE0SzdlaVNmVitwbVZYd3hjUjJpYlpnMGFkbHlMbmtw?=
 =?utf-8?B?RnRTMUVFRzNGZHV4V3h5aUM4QTZwdVo2a25CV0REK1c3M1lZRXRMcTVBL2NI?=
 =?utf-8?B?akZzQ2d5TTI5VGhVWGYvdzdMbTI1UU0rWGF5Um9vOVhRSFdnS1dLbnBKeWVD?=
 =?utf-8?B?d2NVZENXaTVWNTlMejZUVDZZeDk3dGZXTUpuV3FqYXFjUTUrZ3A4QnN3VDlP?=
 =?utf-8?B?Y3ozMDkvUUF3cU1YdEs0SjVVZ0I4bVhaeUMralh2WHZjekpRRE5MajR5QW9B?=
 =?utf-8?B?NGJDaU9oZEdsN2JOLzB2WG1NNFY0UnZva29iRnZtaTJIZWljRWUvajRZanl6?=
 =?utf-8?B?cEtUUlFCZ29yd3AvVDJaWkRiV0FPR3RuUWxGTnJ0S1VNWFhXM0VCLzRlcmww?=
 =?utf-8?B?WEp1dVUvTlRIOUdNc1pvUlZNaG02N1pZU25lNXdyaDdEMCtDSS9DVnp5d29B?=
 =?utf-8?B?RmduMmhueEpENTBwRVU0MzNFbERWYzlqNVRhMk41K3JxcGVhdWJmcFkyaWJk?=
 =?utf-8?B?c2pscGFEUEpxTWlnQkRqZ3lIZWp6em9yTTFjQUhMTkZzRFBQdnYvbWFnMk8r?=
 =?utf-8?B?U1dncGdyQVk4Szc4RTNvYzNwTDZ5Tm1HRmZUQjA1dGtCZ09xNXlZWS9GM0U2?=
 =?utf-8?Q?qEUuCzF6HijJcH8iV8J1tJln+avjFR320f8rU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:59:44.2824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3c58a9-474c-4f79-41cd-08dcfff53787
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2034
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

T24gVGh1LCAyMDI0LTExLTA3IGF0IDEwOjA3ICswMTAwLCBXYWRpbSBFZ29yb3Ygd3JvdGU6DQo+
IA0KPiANCj4gQW0gMDcuMTEuMjQgdW0gMDk6MjMgc2NocmllYiBZYW5uaWMgTW9vZzoNCj4gPiBB
ZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHBoeUJPQVJELVBvbGx1eCBpLk1YIDhNIFBsdXMgb24g
T1AtVEVFDQo+ID4gaW50ZWdyYXRpb24uDQo+ID4gQWxzbyBhZGQgbWlzc2luZyAnLScgdG8gVEYt
QSBidWlsZCBpbnN0cnVjdGlvbiB3aGlsZSBhdCBpdC4NCj4gDQo+IA0KPiBXb3VsZCBpdCBtYWtl
IHNlbnNlIHRvIG1vdmUgdGhlc2UgaW5zdHJ1Y3Rpb25zIGludG8gYSBtb3JlIGdlbmVyYWwgDQo+
IHNlY3Rpb24sIHNvIHRoZXkgY291bGQgYmUgcmV1c2VkIGJ5IG90aGVyIGlteCBiYXNlZCBib2Fy
ZHMgYXMgd2VsbD8NCg0KSSBoYXZlIG5vdCBwdXQgbXVjaCB0aG91Z2h0IGludG8gaXQuIEF0IGZp
cnN0IGdsYW5jZSB0aG91Z2gsIHdoZW4gcmVhZGluZyB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgYQ0K
Ym9hcmQgSSBkb24ndCB3YW50IHRvIGJlIHJlZGlyZWN0ZWQgdG8gb3RoZXIgcGFnZXMuIFNvIHVz
aW5nIGFuIGluY2x1ZGUgY29tZXMgdG8gbWluZC4gSXMgdGhhdCB3aGF0DQp5b3UgaGFkIGluIG1p
bmQgYXMgd2VsbD8NCiANCj4gDQo+IFNlZW1zIHlvdSBtaXNzZWQgdG8gdXBkYXRlIGlteDhtbS1w
aHlnYXRlLXRhdXJpLWwucnN0DQoNClNob3VsZCBiZSBpbiB0aGUgKG5leHQpIHBhdGNoIGZvciB0
aGUgaW14OG1tLCBhcyBUYXVyaSBpcyBiYXNlZCBvbiBwaHljb3JlLWlteDhtbS4gTGV0IG1lIGtu
b3cgaWYNCnlvdSBtZWFudCBzb21ldGhpbmcgZWxzZS4NCg0KWWFubmljDQoNCj4gDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQo+ID4gLS0t
DQo+ID4gwqAgZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5yc3QgfCAyNiArKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RvYy9ib2FyZC9waHl0
ZWMvcGh5Y29yZS1pbXg4bXAucnN0IGIvZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5y
c3QNCj4gPiBpbmRleCBmZGE3NTFhZWZmYi4uNGJjZmE5ZjM5Y2EgMTAwNjQ0DQo+ID4gLS0tIGEv
ZG9jL2JvYXJkL3BoeXRlYy9waHljb3JlLWlteDhtcC5yc3QNCj4gPiArKysgYi9kb2MvYm9hcmQv
cGh5dGVjL3BoeWNvcmUtaW14OG1wLnJzdA0KPiA+IEBAIC05LDYgKzksNyBAQCBRdWljayBTdGFy
dA0KPiA+IMKgIC0tLS0tLS0tLS0tDQo+ID4gwqAgDQo+ID4gwqAgLSBCdWlsZCB0aGUgQVJNIFRy
dXN0ZWQgZmlybXdhcmUgYmluYXJ5DQo+ID4gKy0gQnVpbGQgdGhlIE9QLVRFRSBiaW5hcnkgKG9w
dGlvbmFsKQ0KPiA+IMKgIC0gR2V0IGRkciBmaXJtd2FyZQ0KPiA+IMKgIC0gQnVpbGQgVS1Cb290
DQo+ID4gwqAgLSBCb290DQo+ID4gQEAgLTIwLDEwICsyMSwzMiBAQCBCdWlsZCB0aGUgQVJNIFRy
dXN0ZWQgZmlybXdhcmUgYmluYXJ5DQo+ID4gwqAgDQo+ID4gwqDCoMKgwqAgJCBnaXQgY2xvbmUg
aHR0cHM6Ly9naXQudHJ1c3RlZGZpcm13YXJlLm9yZy9URi1BL3RydXN0ZWQtZmlybXdhcmUtYS5n
aXQNCj4gPiDCoMKgwqDCoCAkIGNkIHRydXN0ZWQtZmlybXdhcmUtYQ0KPiA+IC3CoMKgICQgZXhw
b3J0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUNCj4gPiArwqDCoCAkIGV4cG9ydCBD
Uk9TU19DT01QSUxFPWFhcmNoNjQtbGludXgtZ251LQ0KPiA+IMKgwqDCoMKgICQgZXhwb3J0IElN
WF9CT09UX1VBUlRfQkFTRT0weDMwODYwMDAwDQo+ID4gK8KgwqAgJCAjIHdpdGggb3B0ZWUNCj4g
PiArwqDCoCAkIG1ha2UgUExBVD1pbXg4bXAgU1BEPW9wdGVlZCBibDMxDQo+ID4gK8KgwqAgJCAj
IHdpdGhvdXQgb3B0ZWUNCj4gPiDCoMKgwqDCoCAkIG1ha2UgUExBVD1pbXg4bXAgYmwzMQ0KPiA+
IMKgIA0KPiA+ICtCdWlsZCB0aGUgT1AtVEVFIGJpbmFyeSAob3B0aW9uYWwpDQo+ID4gKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gKy4uIGNvZGUtYmxvY2s6
OiBiYXNoDQo+ID4gKw0KPiA+ICvCoMKgICQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9P
UC1URUUvb3B0ZWVfb3MuZ2l0DQo+ID4gK8KgwqAgJCBjZCBvcHRlZV9vcw0KPiA+ICvCoMKgICQg
bWFrZSBDRkdfQVJNNjRfY29yZT15IFwNCj4gPiArwqDCoMKgwqAgQ0ZHX1RFRV9CRU5DSE1BUks9
biBcDQo+ID4gK8KgwqDCoMKgIENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIFwNCj4g
PiArwqDCoMKgwqAgQ1JPU1NfQ09NUElMRV9jb3JlPWFhcmNoNjQtbGludXgtZ251LSBcDQo+ID4g
K8KgwqDCoMKgIENST1NTX0NPTVBJTEVfdGFfYXJtMzI9YXJtLWxpbnV4LWdudWVhYmloZi0gXA0K
PiA+ICvCoMKgwqDCoCBDUk9TU19DT01QSUxFX3RhX2FybTY0PWFhcmNoNjQtbGludXgtZ251LSBc
DQo+ID4gK8KgwqDCoMKgIE89b3V0L2FybSBcDQo+ID4gK8KgwqDCoMKgIFBMQVRGT1JNPWlteC1t
eDhtcGV2ayBcDQo+ID4gK8KgwqDCoMKgIENGR19UWkRSQU1fU1RBUlQ9MHg1NjAwMDAwMCBcDQo+
ID4gK8KgwqDCoMKgIENGR19ERFJfU0laRT0weDgwMDAwMDAwIFwNCj4gPiArwqDCoMKgwqAgQ0ZH
X1VBUlRfQkFTRT1VQVJUMV9CQVNFDQo+ID4gKw0KPiA+IMKgIEdldCB0aGUgZGRyIGZpcm13YXJl
DQo+ID4gwqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiDCoCANCj4gPiBAQCAtNDIsNiArNjUs
NyBAQCBDb3B5IGJpbmFyaWVzDQo+ID4gwqAgLi4gY29kZS1ibG9jazo6IGJhc2gNCj4gPiDCoCAN
Cj4gPiDCoMKgwqDCoCAkIGNwIDxURi1BIGRpcj4vYnVpbGQvaW14OG1wL3JlbGVhc2UvYmwzMS5i
aW4gLg0KPiA+ICvCoMKgICQgY3AgPE9QLVRFRSBkaXI+L291dC9hcm0vY29yZS90ZWUtcmF3LmJp
biB0ZWUuYmluDQo+ID4gwqDCoMKgwqAgJCBjcCBmaXJtd2FyZS1pbXgtOC4xOS9maXJtd2FyZS9k
ZHIvc3lub3BzeXMvbHBkZHI0Ki5iaW4gLg0KPiA+IMKgIA0KPiA+IMKgIEJ1aWxkIFUtQm9vdA0K
PiA+IA0KPiANCg0K
