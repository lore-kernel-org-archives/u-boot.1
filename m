Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6148BD5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 12:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A022388D70;
	Fri,  8 Nov 2024 13:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="FCdThldu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6968878A; Fri,  8 Nov 2024 13:56:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DA988DF5
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 13:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSt9pI7NK8NZrlYhF4xCOWuFSTg9UnhUccCYFAtfYhaG99SN5QFBCYMPEmbBuV2hBfX0BUifY/7MMmJLt2fLMOBDAfBNsDF7AvtgbGp17IR8+2+NrK5I7XxvPDz8zC7W5WdReUK8Mu56BD2YOOYOuPcIdDE728rvuLK7iudWq2pVLc2RZHBpMHOT/2pA00g/aK/wyCyixUkyBKpZUluOhW9EE5bdIBMSJ8GlcmJ8UefuojuQ+ey9gko27WAzzkQah/kkTzK/FR4xD48llOOik/Bdx94/NY5ST3cijVQG4G8ATlujObOJMgTLQp5f33y7Nm7hNuxXchsfTTwkAkcvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2oLDQOA1IIpL+thno/IpOTojzXRwvMPqQ8Fsd4LMF0=;
 b=mU9xMRuii0ehKT7nKOepdR/vooAVCKlvFfNEUfdchr2OCFUc8FIpty/IU/rK4X5sOX362GX9m2XD7mRvthQF4zHu2IZ3IAm/dYsUcfvWpOxDfhBEU3+NlM8fXESMrcpDxwOSQEDuq6fSmCp4M8dqY04frxxvbuz+sxxFGys+MPjyZEh52N+sfIzg3ij6PskBbor4ltd4bFqcKhtCeNyaEX1dam6J9dt6VUkynzLC1X3h2Cof8M3GFL40YmdvDNz1YQYYXW9fszCk/28UTUYyqJH7YHYe+Qg6mxk0uvwzA0h4wO+Hn+fyUNBBgPhV1SXYJP9lgupLXZtCoj88AXdv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2oLDQOA1IIpL+thno/IpOTojzXRwvMPqQ8Fsd4LMF0=;
 b=FCdThldu3UNTH+6VVdi9V1whBsUsJFFMqnUpzJoP8M0SqgT4WRFp1sHZHjQnzB7WrS7lbotuNw/h6AhkwyS9G32jrmuAEKlCZpYrahEb5FPJPrqhNtvo5dPm2XKjew3uJhNVrEHGYSq7c9YK3LoHRB0fk5ENs5H/pU0vlKRO0KI=
Received: from DB9PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:10:1da::17)
 by AS8P195MB2247.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 12:56:00 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::df) by DB9PR05CA0012.outlook.office365.com
 (2603:10a6:10:1da::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 12:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 12:56:00 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 13:55:59 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 13:55:59 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 8 Nov 2024 13:55:59 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "manut@mecka.net"
 <manut@mecka.net>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, PHYTEC Upstream <upstream@lists.phytec.de>,
 "sbabic@denx.de" <sbabic@denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [Upstream] [PATCH v2 2/6] phycore-imx8mp_defconfig: add optee
 load address
Thread-Topic: [Upstream] [PATCH v2 2/6] phycore-imx8mp_defconfig: add optee
 load address
Thread-Index: AQHbMO5mpd8TcTlkt0yU014H0Q7MpbKrchkAgAHWZIA=
Date: Fri, 8 Nov 2024 12:55:59 +0000
Message-ID: <98dc43a41ed8f8051b6f33761208766d448bc7b2.camel@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-2-bbc3747a60e8@phytec.de>
 <34054407-c686-4ebc-bd38-77ddc0e89625@phytec.de>
In-Reply-To: <34054407-c686-4ebc-bd38-77ddc0e89625@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B19BCB87BDCD4A85D5A08790AA9AD7@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AS8P195MB2247:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b3c7b2-f814-4371-eae1-08dcfff4b1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9qK01VRUFud0hRVUJSNTVxTCtkam5rNmFMWkZ4M1k0L1V1d0hoalNZQ0gx?=
 =?utf-8?B?UW1BMGdibzhONFhpMGl3WkNiZXhzNlRZK3I5c3liaXlUSlNFTThaRzEzOE5T?=
 =?utf-8?B?a3IxSmhQQlIwclZTNDBtTFdFTC9jQVluUHRJbUEvK05NYkVtZ2hBRE5IZld4?=
 =?utf-8?B?Qml1eDNKQXhtS1AyR3pRZGZYQWtsMDlsWkY3dko2KzZDTkFHeEdtR3RRVWRi?=
 =?utf-8?B?YjQvNnR2elJBVmJydXRDOGpxY1JNYlRVRUsveURGK29iTVpsZDlDYkhoMTNU?=
 =?utf-8?B?VkI5dGRvMGFpYXM2T3Y4R3Z2R2VjWEhOSUJxcFgvY1BxbXRRWmhsZmNGaDZn?=
 =?utf-8?B?TGlQc0ZxMVJwZTFualNYK2dCdVR2bEVGcFRUakNSWHFVTmUzcnZieUNoYXRi?=
 =?utf-8?B?Wm1jSEtQdEN4SkFwSWRTbGsxSTVSUUw1VFYvTDY2ekFZSmRoaU40Q3prRzZw?=
 =?utf-8?B?RU9QNnY5RDFTWGhwZnNudW12bjdoNEk1Rlo2d21EYzJ3a2cwZSszQSs0RXlU?=
 =?utf-8?B?LzA0N0M2bzFKcHBpaGhMNWVZYm9MMENEUVJPUHJtUElyYTRGZ1p6VVRvdUt0?=
 =?utf-8?B?N2U0K3RqMDNGVnhWRnVPTTFCbGVRd05aMy9Pc0tmem9VbGl6SnlESXp2ZU5W?=
 =?utf-8?B?Q2EvTlB3dmhKeXR2bDdGZGgrWitQUWVGUFp0U1N3QWhSNHhjVHNrVFZZa01o?=
 =?utf-8?B?N1kzUmE1V05FcGdSRWhKTm9USnh4YVJrWHhXN3JNVFQ4WnVBVE9HaVNldk5w?=
 =?utf-8?B?VmxobFI0N3J4UkRPK2l0OGsvV081SDM0bHZBckYvd3Jrb1NaRkpZVytiV0lW?=
 =?utf-8?B?NTdoQnFQMlFkdGNkQXBqWlhWVStUWHA0Z0M3ZHJTaXZZUzlYdGxJUHN5RUNF?=
 =?utf-8?B?QXVMalNhb3h6U3F2cUExUEczL21xdytDNVUxaHJrSzF5ZFRQOTBPdGQ2NU1q?=
 =?utf-8?B?YlBDNFJXNnpJMnFNRDNrZXJ4b3hhbVdHN1BNRjNtaWJCUnhlbWdRK0tZNlU1?=
 =?utf-8?B?SFFLS28rVnRldlpnVDlZcHUvL1hzdEE2dUZJQmtjVXByRmRJRHZ0ZGZabitR?=
 =?utf-8?B?QUNBeHpiWWZ1WTMzUngrTUZFcHdETXZncWozdkVEeVM1N0hUdGxpTGtxVXBG?=
 =?utf-8?B?VGxyUGhxRTNoV29yb3hTS0xWY2cwQndHZVBuSWJCb3FDMVI5UUNUeExRWUdq?=
 =?utf-8?B?OTJHRTAySGplRkF1OWplaEdzUjk4TmVyNWpyNHZzc2tjZ3BsZFBpMmdPN3NP?=
 =?utf-8?B?Q2dySENaalVXRCtaRjBSTEtoV0RiOVRNOFNmcFhzTVNXTDBMdVhvZkU5YWZM?=
 =?utf-8?B?UExha0NFYU0zWUNOak9qc1pDMlRKS0R2MGlpdHNZcGxuKzVyOWxCclhSa0dn?=
 =?utf-8?B?THJnZ05CK05OTld0YkRYT04xVnQrdWhPYnZVVnBUTHZpeEVSOFEvbEdIOGdR?=
 =?utf-8?B?bk84SjJsZTVYbXhjY3ExbXA3b0cxbHBYU1kxaFcxQ2Z1SzZ3RDh6WC95WnJ2?=
 =?utf-8?B?QmZDS1NiamFoTGxFN2NhN3NJeGp6MDVoU1FsdUpMMHJvYUtQOEZnQnBJSnA3?=
 =?utf-8?B?VStpWkdGems5UXVCQzJRNlhiZnd6MUl1Y3JBOCtzM2VqeTJaSWNNTWtVQnIy?=
 =?utf-8?B?Qno1alJIZEpnV3BjbG81cTk0M2ZDRWdFTGN6bk9kNTFjRDZONzJNeTd1eEZl?=
 =?utf-8?B?Ykk3ZW4xRkpsZUMwNjUrZDUvTWs4NGp6bVNqbVZxUStxcTcrMFBZRUh2OHVv?=
 =?utf-8?B?MGpJQ1dhQys4ZENab0ZybkNRdEI0bCtKa0ZPWW9kaS9xS1NJM2pCOU9yVDdw?=
 =?utf-8?B?Mk1MOTZYcXpuTTJveElDTHd1aFpFa0tpb2ttbnJvOXBJbFVjNEpmREViellY?=
 =?utf-8?B?aEZ6R0RmcFJucHp0aXRrZmlCVWJWcC9kdlBoQ214Ykh6ekE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:56:00.0946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b3c7b2-f814-4371-eae1-08dcfff4b1e6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2247
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

SGkgV2FkaW0sDQoNCk9uIFRodSwgMjAyNC0xMS0wNyBhdCAwOTo1MiArMDEwMCwgV2FkaW0gRWdv
cm92IHdyb3RlOg0KPiBIaSBZYW5uaWMsDQo+IA0KPiBBbSAwNy4xMS4yNCB1bSAwOToyMyBzY2hy
aWViIFlhbm5pYyBNb29nOg0KPiA+IFRoZSBwaHlCT0FSRC1Qb2xsdXggZXhwZWN0cyAweDU2MDAw
MDAwIGFkZHJlc3MgdG8gbG9hZCBvcHRlZS4NCj4gDQo+IFlvdSBhcmUgYWxyZWFkeSBkZWZpbmlu
ZyBhIGRlZmF1bHQgZm9yIElNWDhNX09QVEVFX0xPQURfQUREUiBpbiB0aGUgDQo+IG1hY2gtaW14
IEtjb25mLiBZb3UgY2FuIGRyb3AgdGhlIHBhdGNoZXMgdG91Y2hpbmcgdGhlIGRlZmNvbmZpZ3Mu
DQoNCkkgd291bGQgbGlrZSB0byBrZWVwIHRoZXNlIHBhdGNoZXMgYXMgdGhlIGRlZmF1bHQgdmFs
dWUgaXMgIm9ubHkiIHRoZXJlIHRvIGdldCBhIGZ1bmN0aW9uaW5nIGJ1aWxkLiANClRvIG1lIGl0
IHdvdWxkIHNlZW0gdGhlcmUgaGFzIGJlZW4gbm8gdGhvdWdodCBwdXQgaW4gdG8gd2hhdCB0aGUg
YWN0dWFsIGNvcnJlY3QgdmFsdWUgd291bGQgYmUgaWYNCmxlZnQgYXMgZGVmYXVsdC4gRG9lcyB0
aGF0IG1ha2Ugc2Vuc2U/DQoNCllhbm5pYw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBXYWRpbQ0KPiAN
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4N
Cj4gPiAtLS0NCj4gPiDCoCBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyB8IDEgKw0K
PiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyBiL2NvbmZpZ3MvcGh5Y29yZS1p
bXg4bXBfZGVmY29uZmlnDQo+ID4gaW5kZXggMTI0MGM3ZmNiZDAuLjkxMDEwOWFmZDgwIDEwMDY0
NA0KPiA+IC0tLSBhL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnDQo+ID4gKysrIGIv
Y29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcNCj4gPiBAQCAtNSw2ICs1LDcgQEAgQ09O
RklHX1NZU19NQUxMT0NfTEVOPTB4MjAwMDAwMA0KPiA+IMKgIENPTkZJR19TUExfR1BJTz15DQo+
ID4gwqAgQ09ORklHX1NQTF9MSUJDT01NT05fU1VQUE9SVD15DQo+ID4gwqAgQ09ORklHX1NQTF9M
SUJHRU5FUklDX1NVUFBPUlQ9eQ0KPiA+ICtDT05GSUdfSU1YOE1fT1BURUVfTE9BRF9BRERSPTB4
NTYwMDAwMDANCj4gPiDCoCBDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT049eQ0KPiA+IMKgIENP
TkZJR19TRl9ERUZBVUxUX1NQRUVEPTgwMDAwMDAwDQo+ID4gwqAgQ09ORklHX0VOVl9TSVpFPTB4
MTAwMDANCj4gPiANCj4gDQoNCg==
