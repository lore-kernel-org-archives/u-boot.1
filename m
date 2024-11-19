Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F88D6204F
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 09:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76316894F4;
	Tue, 19 Nov 2024 10:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Aduaut3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C9E894C0; Tue, 19 Nov 2024 10:44:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::713])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6000894F4
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBlR7LnS4+8U2Xr1TjELHt0/jW/OpUOe7emsbNOVB0sBi1jQ6dRSZddM3qnYg4V3IElkgHI82aX7Pe2TazFoHPl+OQdnLBQEwj7pAx12svIveR0R6b4yFy/qW/Ycgsj+LjrieIEkB66tUti0UedfELjAj5I5wtj+M1+tQcveEB2S0ozHNq6pwUCgKIgYGtApCay5lQIwZJ4bu8/oGhlfmRoKmuv3gqRUOty1ctx97VgmTl0BfJlco2CSaKs6/Eq7stYX9/jUIMfxXNrIjRBQ4JhRTGEhtgPo+ZOnJloAbxgX8+fCPhNXKrLviFQX1wVs/FMIzvPVuRVtfWkeueEBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaMgjgVKmxKHZKFq6TOcJZ6JD2siIELfkY3XwP9WaGI=;
 b=TRaWEPrPpglVU+HwNc5NE6P8lxd6G9wsmFa3rh+alSAjvhk36tZCZNBj0RquF5+hHcf2tcF051tBpIbZLGVGDsHAqe6YTsfng8ZgE8hWCP2aaVhN1dVC0oxVnxIcqsaJE3CwzeV00yM4RabUlCGKpRwLGtXmeLF8XDG/3WKXZeir63KFDxCgdXmiMfooxpyEyu/UUPdjnBSAtHcy1LyFev7Elzk4LUJDMIzL2mngAJZLXkEOwHbinxVCFHIllEa8CKclVNsyn88EhjZGPH/aG4CkzkfGoszcWt8NC4QYV+5amamt9khU0doYAMqXzs2QkRpap6U9AV5k2Cj6djTqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaMgjgVKmxKHZKFq6TOcJZ6JD2siIELfkY3XwP9WaGI=;
 b=Aduaut3tqBY9PET9yNGR8s7aJmrk3boVONnAeuZyyyLjITZDMxIXFhxjyjYWkD7TfbN2hr+Vi5Y1VrGJ70+wq9bjroihUm6jNaeCBDnYywHMAM1VlJe+T00+cOtosQDQ7gOcHOl7XPOTXMjcjz3KprzLCYiTUd/5ZmpJDZigo0s=
Received: from AM0PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::34)
 by AS2P195MB2195.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 09:44:21 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::d9) by AM0PR10CA0024.outlook.office365.com
 (2603:10a6:208:17c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 09:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 09:44:21 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 10:44:21 +0100
Received: from Florix.phytec.de (172.25.0.13) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 10:44:20 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Tue, 19 Nov 2024 10:44:20 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: Yannic Moog <Y.Moog@phytec.de>
CC: Wadim Egorov <W.Egorov@phytec.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Andrej Picej
 <andrej.picej@norik.com>, "sbabic@denx.de" <sbabic@denx.de>, PHYTEC Upstream
 <upstream@lists.phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Topic: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Index: AQHbNeU53U95sTpb5UKeBgkqmviyVrK2QsEAgABXCACAABuvgIAHnTAA
Date: Tue, 19 Nov 2024 09:44:20 +0000
Message-ID: <367f2203e016e8031f51235a33547dc221737d6f.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
 <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
 <2b1aec9b611a3106a4c59b53db2e84a697791f8d.camel@phytec.de>
 <c44edecde5ba3d006baaa0c58a45f1f6c5476260.camel@phytec.de>
In-Reply-To: <c44edecde5ba3d006baaa0c58a45f1f6c5476260.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD1DDF6B2B6A6E418D6AC07CF4519DEB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|AS2P195MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ba4347-3a9b-4fdf-5af6-08dd087ebeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWVpRkV0YWpBVVExNys0YlR4cE82SlVTWE5zem5kZ0ZaeHZob04ySTNjMVJi?=
 =?utf-8?B?Qk1IMldRbzB4N01jN213eFg2Q2tJS0V1NnVqQlYrVzhFdVhQRGVaekVaQ05q?=
 =?utf-8?B?SzNnWVY1Y3pzNFFaNHJjSkllTFF3QXFpbEk3VWpSMk9TdTYyZWJMcXhybUd2?=
 =?utf-8?B?MmVKblJBalpEMXh5elgvL0U0ZkJFaU1hNGlOUkFaY2p5cnlOV3VWRHRieHd6?=
 =?utf-8?B?TStNbTl3UWpZdTFaYlMvUG9WM3MxVkxocUxVUGxuK0w1SUVLNk9kMzV6a1Ru?=
 =?utf-8?B?Q2VRZ2ZGQjU2ek5vU3gzbksyTlRWSlhVdmZxNjQxbGNjRzFDNHRZT25TdjNC?=
 =?utf-8?B?NzBxd2UyMVVMSGI3UW0vbGlvNnJRMGx4a1FVak94T3RFcTkxVFMwSmd1cEQ2?=
 =?utf-8?B?VTlyaS92TkhDb3hHRXV4N2xUYzIveXlNU3FkL0dpQWl2ekJHbExlY21RZVF4?=
 =?utf-8?B?SGN1VlV2N3RGYTdmOVF3QXdzNkRKZlFFZ2s3c2NBc2VnVTRzb3hFNVJFdlo2?=
 =?utf-8?B?QzRGK2JOS0pDVldlYll4RlJvcHAwdE5xclZHbHhmczl0ajJ3b1dsb0l3WDZ0?=
 =?utf-8?B?RGoyamR6cnlKN0tDLzhQZXRmU3VJb0w0TE9HL2JzTkxsZWpKelMrN0o4RDFK?=
 =?utf-8?B?TkNrM2d3M25wR3BCSm9JUExzSE9aMFFXVFgyaXhhNlJDeUhVSXFiY2xqVzkx?=
 =?utf-8?B?U1F5ZWVWd25jRmN6Vm5aY2ZVZGI1SE94cFlhOEhzZEE4YWhVblR2VEhPeEFz?=
 =?utf-8?B?YjlHOXE3VERrYmJzVUJOS3hRYXFRZlUwZHM0eDVNanQ5eFJkSXdlOHExaDIw?=
 =?utf-8?B?NWJzS2xSZ2EyQjVFQmVMNjVSbXc3WWFYbndTYWhLaUQydW5OaEduKzF2WStq?=
 =?utf-8?B?SmJxYjJxQTVXU2V6SzBKRForTUx3Qjg3QnMzNHE3MWV5Z2F4YUlNTUNQdnZF?=
 =?utf-8?B?YVJ1dzhIQTFZVlVFME9BcGViMUJsOFpKeXpORC8vOHJ3VHl0a2w1cDNLN0hQ?=
 =?utf-8?B?dkhtU0tXNmpJeXhZeUlEV1VZTmNGSEVYNXZHUUNGN1gzWVk1KzRrcTJLYU03?=
 =?utf-8?B?c1p2cm9Rc0RFWjF0NUQya3J4MGdhaUhkeVNMSW5HdTRobnNJMzcweHIwNHRV?=
 =?utf-8?B?ZTFRZ1N3aDcwQW91a3lhL2dzQUpZQW0vZy9HM0djYWJrcm03SVVxV3laaUxG?=
 =?utf-8?B?Y1pyNkV1Z3lNNGNKN1NiU1d4blBYT0NhZWZWdDNZTXdkam5hTGVQZXNZWjEv?=
 =?utf-8?B?Rk81bmhqbXhYRG9hdUlUdGhnbzlLNlJrSTBIZnI2UElSSGVqTmpWZ2tYOFVK?=
 =?utf-8?B?MHhpb2VOV1BDd0tBM0xZR3pkSlFhdmFEMldjWlJpS3hacTYra0poeDg5SndS?=
 =?utf-8?B?NUxsR0ZRQkw2Q3UyY2l6VWNYby95R3orRGo4V0dITzB1Z0VkQ1pYRkl0Q0dS?=
 =?utf-8?B?Um1WV3FGc3RuRW9wZFRTeFl3OFhHYnpRTkNtVE10UW5QUndvR3U1ZjQxWE5C?=
 =?utf-8?B?OGJNZTNCbmY2Mzd0M0orWEtCbjErZjg5dWdZM3lvNFFWUm1vUm1DSmlBOVFt?=
 =?utf-8?B?UWRKUnhNQnBZR2svc3V4SDZFcXRPS3B1ZW5DbXdoNzBuQ21RWEI1dkl3K1lW?=
 =?utf-8?B?MDlNNHVXb0piWEpyT0t6amNjL1FhTnZoZGlHdjU4bDZ6ZFIrSTc0b2N2Rzkw?=
 =?utf-8?B?MkR4a3hHQlZUaEJNY2NvemlJbnI3TXJFZ3J6M0xWV05JMWx6YXA4OU05cC9Z?=
 =?utf-8?B?blB2SDBuS2lDakhGa3dUb0N3TVFOeFRwbjdFY3BldWtEU2FXOGljL3ZwTm9D?=
 =?utf-8?Q?fcYi8c5FfB5DBouFUpYXqGnvpBHZz9vWFmi6w=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 09:44:21.4467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ba4347-3a9b-4fdf-5af6-08dd087ebeb5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2195
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

DQpPbiBEbywgMjAyNC0xMS0xNCBhdCAxNDoyNyArMDEwMCwgWWFubmljIE1vb2cgd3JvdGU6DQo+
IE9uIFRodSwgMjAyNC0xMS0xNCBhdCAxMjo0OCArMDEwMCwgQ2hyaXN0b3BoIFN0b2lkbmVyIHdy
b3RlOg0KPiA+IA0KPiA+IA0KPiA+IE9uIERvLCAyMDI0LTExLTE0IGF0IDA3OjM3ICswMTAwLCBZ
YW5uaWMgTW9vZyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgMjAyNC0xMS0xMyBhdCAxNzowMCArMDEw
MCwgQ2hyaXN0b3BoIFN0b2lkbmVyIHdyb3RlOg0KPiA+ID4gPiBUaGUgcGh5Q09SRS1pLk1YIDkz
IGlzIGF2YWlsYWJsZSBpbiB2YXJpb3VzIHZhcmlhbnRzIChlLmcuDQo+ID4gPiA+IGRpZmZlcmVu
dCByYW0NCj4gPiA+ID4gc2l6ZXMsIGVNTUMgSFM0MDAgeWVzL25vKS4gRW5hYmxlIGhhcmR3YXJl
IGludHJvc3BlY3Rpb24gZm9yDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBpbXg5My1waHlib2FyZC1z
ZWdpbl9kZWZjb25maWcsIHNvIHRoYXQgZHVyaW5nIHN0YXJ0dXAgdGhlIFNPTQ0KPiA+ID4gPiBt
b2R1bGUNCj4gPiA+ID4gdmFyaWFudCBjYW4gYmUgZGV0ZWN0ZWQsIGFuZCB0aGUgaGFyZHdhcmUg
Y2FuIGJlIGNvbmZpZ3VyZWQNCj4gPiA+ID4gYWNjb3JkaW5nbHkuDQo+ID4gPiA+IFRoZSByZXN1
bHRpbmcgU1BMIGFuZCB1LWJvb3QgYmluYXJ5IHNoYWxsIGFibGUgdG8gYm9vdCBlYWNoDQo+ID4g
PiA+IHBoeUNPUkUtaS5NWCA5MyBtb2R1bGUgdmFyaWFudCBvbiBlYWNoIGNhcnJpZXIgYm9hcmQu
IEZpbmFsbHkNCj4gPiA+ID4gcmVuYW1lDQo+ID4gPiA+IGlteDkzLXBoeWJvYXJkLXNlZ2luX2Rl
ZmNvbmZpZyB0byBpbXg5My1waHljb3JlX2RlZmNvbmZpZywgdG8NCj4gPiA+ID4gaGlnaGxpZ2h0
DQo+ID4gPiA+IGl0cyBTT00gc2NvcGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gQ2M6IE1hdGhpZXUgT3RoYWNlaGUgPG0ub3RoYWNlaGVAZ21haWwuY29tPg0KPiA+
ID4gPiBDYzogQ2hyaXN0b3BoIFN0b2lkbmVyIDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4NCj4gPiA+
ID4gQ2M6IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPg0KPiA+ID4gPiBDYzogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiA+ID4gPiBDYzogIk5YUCBpLk1YIFUtQm9v
dCBUZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+ID4gPiA+IENjOiBUb20gUmluaSA8dHJpbmlA
a29uc3Vsa28uY29tPg0KPiA+ID4gPiBDYzogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+
DQo+ID4gPiA+IENjOiBQcmltb3ogRmlzZXIgPHByaW1vei5maXNlckBub3Jpay5jb20+DQo+ID4g
PiA+IENjOiBBbmRyZWogUGljZWogPGFuZHJlai5waWNlakBub3Jpay5jb20+DQo+ID4gPiA+IENj
OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRlYy5kZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IENoYW5nZXMgaW4gdjI6DQo+ID4gPiA+IC0ganVzdCByZW5hbWUgaW14OTMtcGh5Ym9hcmQtc2Vn
aW5fZGVmY29uZmlnIGFuZCBhZGQgbmVlZGVkDQo+ID4gPiA+IENPTkZJR3MsDQo+ID4gPiA+IMKg
IGluc3RlYWQgb2YgY3JlYXRpbmcgYW4gZW50aXJlbHkgbmV3IHNlY29uZCBkZWZjb25maWcNCj4g
PiA+ID4gLSByZW1vdmUgd3JvbmcgY29tbWVudCBmcm9tIGlteDkzLXBoeWJvYXJkLXNlZ2luLXUt
Ym9vdC5kdHNpDQo+ID4gPiA+IC0gaW1wcm92ZSBjb21taXQgbWVzc2FnZQ0KPiA+ID4gPiANCj4g
PiA+ID4gwqBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2nCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4gPiA+ID4gNg0KPiA+ID4gPiArKysrLS0NCj4g
PiA+ID4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+ID4gPiA+IDIgKy0NCj4gPiA+ID4g
wqAuLi54OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnID0+IGlteDkzLXBoeWNvcmVfZGVmY29u
ZmlnfSB8DQo+ID4gPiA+IDQNCj4gPiA+ID4gKysrLQ0KPiA+ID4gPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiDCoHJlbmFtZSBjb25m
aWdzL3tpbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcgPT4gaW14OTMtDQo+ID4gPiA+IHBo
eWNvcmVfZGVmY29uZmlnfSAoOTglKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+ID4gPiBiL2Fy
Y2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LQ0KPiA+ID4gPiBib290LmR0c2kNCj4g
PiA+ID4gaW5kZXggMjVjNzc4YmIwNy4uMjI0NTQ2MTAzMiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
YXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gPiA+ICsr
KyBiL2FyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+ID4g
PiBAQCAtMiwxNSArMiwxNyBAQA0KPiA+ID4gPiDCoC8qDQo+ID4gPiA+IMKgICogQ29weXJpZ2h0
IChDKSAyMDIzIFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+ID4gPiA+IMKgICogQ2hyaXN0b3Bo
IFN0b2lkbmVyIDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4NCj4gPiA+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAyNCBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KPiA+ID4gPiDCoCAqDQo+ID4gPiA+IMKg
ICogUHJvZHVjdCBob21lcGFnZToNCj4gPiA+ID4gLSAqIHBoeUJPQVJELVNlZ2luIGNhcnJpZXIg
Ym9hcmQgaXMgcmV1c2VkIGZvciB0aGUgaS5NWDkzDQo+ID4gPiA+IGRlc2lnbi4NCj4gPiA+ID4g
LSAqIGh0dHBzOi8vd3d3LnBoeXRlYy5ldS9lbi9wcm9kdWt0ZS9zaW5nbGUtYm9hcmQtDQo+ID4g
PiA+IGNvbXB1dGVyL3BoeWJvYXJkLXNlZ2luLWlteDZ1bC8NCj4gPiA+ID4gK8KgwqAgaHR0cHM6
Ly93d3cucGh5dGVjLmRlL3Byb2R1a3RlL3N5c3RlbS1vbi1tb2R1bGVzL3BoeWNvcmUtDQo+ID4g
PiA+IGlteC0NCj4gPiA+ID4gOTEtOTMvDQo+ID4gPiA+IMKgICovDQo+ID4gPiA+IMKgDQo+ID4g
PiA+IMKgI2luY2x1ZGUgImlteDkzLXUtYm9vdC5kdHNpIg0KPiA+ID4gPiDCoA0KPiA+ID4gPiDC
oC8gew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBtb2RlbCA9ICJQSFlURUMgcGh5Q09SRS1pLk1Y
OTMiOw0KPiA+ID4gPiArDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB3ZHQtcmVib290IHsNCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIndkdC1y
ZWJvb3QiOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdkdCA9IDwm
d2RvZzM+Ow0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMv
TUFJTlRBSU5FUlMNCj4gPiA+ID4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJ
TkVSUw0KPiA+ID4gPiBpbmRleCBjZWE4MTdmZmRjLi43MThmODlhMDg0IDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiA+ID4gPiAr
KysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiA+ID4gPiBAQCAt
OSw1ICs5LDUgQEAgRjrCoMKgwqDCoMKgIGFyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdp
bi11LQ0KPiA+ID4gPiBib290LmR0c2kNCj4gPiA+ID4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OTMvDQo+ID4gPiA+IMKgRjrCoMKgwqDCoMKgIGJvYXJkL3BoeXRlYy9j
b21tb24vaW14OTNfc29tX2RldGVjdGlvbi5jDQo+ID4gPiA+IMKgRjrCoMKgwqDCoMKgIGJvYXJk
L3BoeXRlYy9jb21tb24vaW14OTNfc29tX2RldGVjdGlvbi5oDQo+ID4gPiA+IC1GOsKgwqDCoMKg
wqAgY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gPiA+ID4gK0Y6wqDC
oMKgwqDCoCBjb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ID4gPiANCj4gPiA+IEhv
dyB3aWxsIHlvdSBoYW5kbGUgdGhpcyB3aGVuL2lmIHlvdSBoYXZlIGFub3RoZXIgYm9hcmQ/DQo+
ID4gDQo+ID4gVGhhdCBpbXg5My1waHljb3JlX2RlZmNvbmZpZyBoYXMgbm8gbW9yZSBkZXBlbmRl
bmN5IHRvIHRoZSBjYXJyaWVyDQo+ID4gYm9hcmQuDQo+IA0KPiBOb3QgdHJ1ZSwgDQo+IENPTkZJ
R19ERUZBVUxUX0RFVklDRV9UUkVFPSJpbXg5My1waHlib2FyZC1zZWdpbiINCj4gSXQgaGFzIGEg
ZGVwZW5kZW5jeSB0byBhIGJvYXJkLiBUaGF0IGlzIHdoeSBJIGFtIGFza2luZy4NCj4gDQo+IFlh
bm5pYw0KDQoNClRoZSBpbXg5My1waHljb3JlX2RlZmNvbmZpZyB1c2VzIHRoZSBpbXg5My1waHli
b2FyZC1zZWdpbi5kdHMNCmFzIHJlZmVyZW5jZSwgYnV0IGRvZXMgb25seSBtYWtlIHVzZSBvZiBp
dHMgU09NIChpbXg5My1waHljb3JlKQ0KcGVyaXBoZXJhbHMuIEkgd2lsbCBhZGQgYSBhY2NvcmRp
bmcgY29tbWVudCBpbnRvIHRoZQ0KaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kgdG8g
bWFrZSBpdCBjbGVhcmVyLg0KDQo+IA0KPiA+IMKgVGhhdHMgd2h5IEkgcmVuYW1lZCBpdC4gVGhl
IGludGVudGlvbiBmb3IgdGhlIGRlZmNvbmZpZyBpc8KgdGhhdA0KPiA+IHRoZSByZXN1bHRpbmcg
U1BMIGFuZCB1LWJvb3QgYmluYXJ5IGNhbiB0byBib290IGVhY2ggcGh5Q09SRS1pLk1YDQo+ID4g
OTMNCj4gPiBtb2R1bGUgdmFyaWFudCBvbiBlYWNoIGNhcnJpZXIgYm9hcmQuDQo+ID4gDQo+ID4g
VGhhdHMgd2h5IHRoZSBjYXJyaWVyIGJvYXJkIGlzIG5vIG1vcmUgcmVsZXZhbnQgaGVyZS4NCj4g
DQo+ID4gDQo+ID4gPiANCj4gPiA+IEFsc28sIHBsZWFzZSB1cGRhdGUgZG9jdW1lbnRhdGlvbiEN
Cj4gPiA+IA0KPiA+ID4gWWFubmljDQo+ID4gPiANCj4gPiA+ID4gwqBGOsKgwqDCoMKgwqAgaW5j
bHVkZS9jb25maWdzL3BoeWNvcmVfaW14OTMuaA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvY29uZmln
cy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gPiA+ID4gYi9jb25maWdzL2lteDkz
LXBoeWNvcmVfZGVmY29uZmlnDQo+ID4gPiA+IHNpbWlsYXJpdHkgaW5kZXggOTglDQo+ID4gPiA+
IHJlbmFtZSBmcm9tIGNvbmZpZ3MvaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnDQo+ID4g
PiA+IHJlbmFtZSB0byBjb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ID4gPiA+IGlu
ZGV4IDE4YTQwODdlNGIuLmNmOTgwMDExOGEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2NvbmZpZ3Mv
aW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnDQo+ID4gPiA+ICsrKyBiL2NvbmZpZ3MvaW14
OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gPiA+ID4gQEAgLTYsMTMgKzYsMTMgQEAgQ09ORklHX1NZ
U19NQUxMT0NfRl9MRU49MHgyMDAwMA0KPiA+ID4gPiDCoENPTkZJR19TUExfTElCQ09NTU9OX1NV
UFBPUlQ9eQ0KPiA+ID4gPiDCoENPTkZJR19TUExfTElCR0VORVJJQ19TVVBQT1JUPXkNCj4gPiA+
ID4gwqBDT05GSUdfTlJfRFJBTV9CQU5LUz0yDQo+ID4gPiA+ICtDT05GSUdfUEhZVEVDX1NPTV9E
RVRFQ1RJT049eQ0KPiA+ID4gPiDCoENPTkZJR19FTlZfU09VUkNFX0ZJTEU9InBoeWNvcmVfaW14
OTMiDQo+ID4gPiA+IMKgQ09ORklHX0VOVl9TSVpFPTB4MTAwMDANCj4gPiA+ID4gwqBDT05GSUdf
RU5WX09GRlNFVD0weDcwMDAwMA0KPiA+ID4gPiDCoENPTkZJR19JTVhfQ09ORklHPSJhcmNoL2Fy
bS9tYWNoLWlteC9pbXg5L2lteGltYWdlLmNmZyINCj4gPiA+ID4gwqBDT05GSUdfRE1fR1BJTz15
DQo+ID4gPiA+IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImlteDkzLXBoeWJvYXJkLXNl
Z2luIg0KPiA+ID4gPiAtQ09ORklHX1NQTF9URVhUX0JBU0U9MHgyMDQ5QTAwMA0KPiA+ID4gPiDC
oENPTkZJR19BSEFCX0JPT1Q9eQ0KPiA+ID4gPiDCoENPTkZJR19UQVJHRVRfUEhZQ09SRV9JTVg5
Mz15DQo+ID4gPiA+IMKgQ09ORklHX09GX0xJQkZEVF9PVkVSTEFZPXkNCj4gPiA+ID4gQEAgLTIw
LDYgKzIwLDcgQEAgQ09ORklHX1NZU19NT05JVE9SX0xFTj01MjQyODgNCj4gPiA+ID4gwqBDT05G
SUdfU1BMX1NFUklBTD15DQo+ID4gPiA+IMKgQ09ORklHX1NQTF9EUklWRVJTX01JU0M9eQ0KPiA+
ID4gPiDCoENPTkZJR19TUExfU1RBQ0s9MHgyMDUxOWRkMA0KPiA+ID4gPiArQ09ORklHX1NQTF9U
RVhUX0JBU0U9MHgyMDQ5QTAwMA0KPiA+ID4gPiDCoENPTkZJR19TUExfSEFTX0JTU19MSU5LRVJf
U0VDVElPTj15DQo+ID4gPiA+IMKgQ09ORklHX1NQTF9CU1NfU1RBUlRfQUREUj0weDIwNTFhMDAw
DQo+ID4gPiA+IMKgQ09ORklHX1NQTF9CU1NfTUFYX1NJWkU9MHgyMDAwDQo+ID4gPiA+IEBAIC0z
MSw2ICszMiw3IEBAIENPTkZJR19TUExfSU1YX1JPTUFQSV9MT0FEQUREUj0weDg4MDAwMDAwDQo+
ID4gPiA+IMKgQ09ORklHX1NZU19NRU1URVNUX1NUQVJUPTB4ODAwMDAwMDANCj4gPiA+ID4gwqBD
T05GSUdfU1lTX01FTVRFU1RfRU5EPTB4OTAwMDAwMDANCj4gPiA+ID4gwqBDT05GSUdfUkVNQUtF
X0VMRj15DQo+ID4gPiA+ICsjIENPTkZJR19BTkRST0lEX0JPT1RfSU1BR0UgaXMgbm90IHNldA0K
PiA+ID4gPiDCoENPTkZJR19ESVNUUk9fREVGQVVMVFM9eQ0KPiA+ID4gPiDCoENPTkZJR19PRl9T
WVNURU1fU0VUVVA9eQ0KPiA+ID4gPiDCoENPTkZJR19CT09UQ09NTUFORD0ibW1jIGRldiAke21t
Y2Rldn07IGlmIG1tYyByZXNjYW47IHRoZW4gaWYNCj4gPiA+ID4gcnVuDQo+ID4gPiA+IGxvYWRp
bWFnZTsgdGhlbiBydW4gbW1jYm9vdDsNCj4gPiA+ID4gZWxzZSBydW4gbmV0Ym9vdDsgZmk7IGZp
OyINCj4gPiA+IA0KPiANCg==
