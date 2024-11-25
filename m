Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF30DD3B7EF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7B288EF5;
	Mon, 25 Nov 2024 09:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="HovoEyBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81B588901; Mon, 25 Nov 2024 09:29:06 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E3088F48
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBtcQiiEKY6rLPa2QJGCxA5CF9Ltwkc7LN66o7imKGOrl8z2uRBlJDb2TLVZPli8oqHywZ1hIzgWA3aMPNL+FBx0t9QkqthQbvo6Wj9RbYkLIl43G5tL7FUDgKImAZ+ZF/+nwEmOlJTg+mwuOlh5pj7cjnojFdN3o7Wt+d+wU8R0ozU/EjqGBF63HKLyNvD/toxJkSI8c8wHDYpmrrvv9cfcPdfXVMURnc9pZmhmak5D4p7Sc6uWjFJRdACSBcHREqLTVPUAzOU0nBS6fU+zybc/mvLbczSXnwDEg30KTA9yj0RCuYHmaCd1ot53kPVyJM4SFnF22tXMbtZ6zVLlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmhkkDlzyAle4DOPWjrgzrqthYoecww7NP+f5VyHGcQ=;
 b=BZSxW3R50EEc8+hQWlbr/k6j7gyOq4srX36+Q1QygNeTYsbaxJxqfunc7wcWrlm46l0lqG8RBHCQ2p2LwEQkLi3nj8175V01pZEzB1PX0RCzODrW+l3Mpp1ukc/D1a38zV3FGuZMVCEOmu0Dp8FgEuyAHTv9ID2Y9JKB1oQ2KV96+CtYLjsFo5LLHJ+mBk2KhJVi4ngCnJQ9YJHfl1oR3g9dm4xP2FlUELHeJwSQOzr/+z/+zhfc4c4lvnpmUfppcjWkFWHKp0XcmMf6A+SGU074iHrPQQmAvpz+aebG/xOFLUih3vygf6zfco9DGF6MrfxWHn0IEKrZBZCRO6dBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmhkkDlzyAle4DOPWjrgzrqthYoecww7NP+f5VyHGcQ=;
 b=HovoEyBjVC5dU93h7Rl2Sc1oaHthU/mgIyC2N7m1bc+tHecAK8VFdXVe87vPIi3qNIFlfBo4lTSz0oBPfsI8W6CZWFuBV4gnp8HiRCEV9tn/L+tCTxTUz4Iop8hUpFId/h2ExiuXZgCHRHizn4wed/sMwAfsjLJssQruowINrcM=
Received: from AS9PR06CA0682.eurprd06.prod.outlook.com (2603:10a6:20b:49c::27)
 by AS8P195MB2043.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 08:28:48 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:49c:cafe::83) by AS9PR06CA0682.outlook.office365.com
 (2603:10a6:20b:49c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 08:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 08:28:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 09:28:48 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 09:28:48 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Mon, 25 Nov 2024 09:28:47 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "wahrenst@gmx.net" <wahrenst@gmx.net>
CC: Yannic Moog <Y.Moog@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, Andrej Picej <andrej.picej@norik.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Primoz Fiser
 <primoz.fiser@norik.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Topic: [PATCH v4 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Index: AQHbO2m655mv1wTilUe5fMsmnpmCI7LBdCoAgAYsVIA=
Date: Mon, 25 Nov 2024 08:28:47 +0000
Message-ID: <05db2b94c4eb28aefc33a13c6fb2fa324eb62ee7.camel@phytec.de>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
 <20241120163143.127862-3-c.stoidner@phytec.de>
 <371c6302-438b-45b6-944b-d513f74f38a5@gmx.net>
In-Reply-To: <371c6302-438b-45b6-944b-d513f74f38a5@gmx.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D67EBFCDDE09FF4B8D4E199E64B831E4@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AS8P195MB2043:EE_
X-MS-Office365-Filtering-Correlation-Id: 27779751-6ed8-4e19-0eba-08dd0d2b2f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXlTbWZNSTA3TzVUcmRtTm5WMHIzV1NzSFdPWEJnd1E2R0JkaWNiQUZ4Vm9D?=
 =?utf-8?B?UG9Ja0lGZlVUM0JERmw2SFJ4TG5wckRYdTV2aXhtYUpGLzFpS205K25BRWdE?=
 =?utf-8?B?RHpRcVZuaElpSkRUOUpjSDdWM1dSbktwT0dHL0R4U1JCM0J0ai9uaDIwTUJI?=
 =?utf-8?B?NDY4ZUw5MVNzQlpyTk1jcjczYVY2OUJ2R0V5MTd1OU5zbkVnUHh1OWUvWjQz?=
 =?utf-8?B?c2JvL29JWTd5bzkvdytqUndmcFJHd01Vcm8zVTZKQ3Vwb01EbitnQ1BFcWQy?=
 =?utf-8?B?NTM4Qld1WVhraTQ2OEdEa1VtNHhabGJhamJyV1pXbEpLeHkwWWlRdzhaamZE?=
 =?utf-8?B?KzhEVkYyUmhuOWNGWjdHOFlrY2pNU3dtNW1GajZpbCtqWnNFdHRvQWE4WUdW?=
 =?utf-8?B?SWxIdXZXQlpxYTZzSXBFOTZySE10WEdGK0k1bnNLUHYrVU5pSGRNU2hGS3Jh?=
 =?utf-8?B?UGROeU9xdmw3M010dWZpNkwvSGtYakc5RlVSbldkOGhFRjBHR1FkZG9OWUVj?=
 =?utf-8?B?VjVVQ09keXhLdURsWTU3OWh6b1BGTW5SRzlaM25vRWJsSURVaEgvbUl6dmpv?=
 =?utf-8?B?T2xWYkx6cjh5YmJYT0xCVExCNUdzOVlQakdLZ2JTQmtjanl0Z0padzNQUE1r?=
 =?utf-8?B?Yy9iMEdtK1hybE54eVJqV21mdzZrOUM5MlhqWUJ0VWhwYXFEbWpFaFlzRnRB?=
 =?utf-8?B?SHRpZ3AzdXNUNmphK25sNjRuRkErOWJ5cmVEWSs5VFBCdEoyNGdaS2syRUpw?=
 =?utf-8?B?QTN1cEQwTzV5QnpxVnZyUXJLS0QzR3RIREhKSFJWK29kT3dXcmtqQ3daUGFs?=
 =?utf-8?B?UGlldVYrTElsTXRCY0hCSFVOa3M4bjlaUklzWjY2MHhLdzdqMWRwNjRLZkhX?=
 =?utf-8?B?K1N4clpaMXNreDkvSHVsWmNJU3pJK1BEVjlsRnJ3dEdHUjZmb1Z6VWpmaUNx?=
 =?utf-8?B?aUt6bUdIdEpxUi9ZbzVYVXVXTmtsUlNEekJpQndQL2VlWXRiM3JJU3RaVHpG?=
 =?utf-8?B?RFJiSlBlT1Z0R251a09RS0JpeTM1cE90ZVdVVG5TazkyU1hXbzg5bVJDTDlQ?=
 =?utf-8?B?b0daRzl5UWFuOVcvRlRFVHZCdVVEUnUyZityaG5rem9RazdXODhMV09Ud3Nv?=
 =?utf-8?B?U1NtVVBXY283MEs0UDNYTU1ZaFE3ZzY2ZG9wTGJWT3F5cnprMzUrWWVwdHpT?=
 =?utf-8?B?VFV3R0dQRWFLSGRoVm1uTmlNVzV2blBhZXE1RXRnd29Zb0p2QVFGRzNYYW00?=
 =?utf-8?B?a0NEOWdtRFFDMzBBRW91UGRkaC9Vb1FZaEhxOGlEUWd0V2dDcHpJaFljM1lU?=
 =?utf-8?B?Y1kyNzR2bWZhcnJtd1RPdzZQbXZJMlNSdlNoaVV3c1liZkx6ZW1zcVJYcGhx?=
 =?utf-8?B?OEdpWEE0czgydnMyalBQaTRuOGlDUFpNN01lZVQ2QTlmT0pTSHNSNmhqQUwx?=
 =?utf-8?B?U1ZWS0ltTmdiSmVrVWdjRVY2RWdMR0kwR3lZZUx4dEpZK0ZJcEFIVHRRektm?=
 =?utf-8?B?REpQejNEU0szaWd0MUVQeXl0TDVhNndMZWFCTk9hWTdydzBlbkNBbjJ6cGs2?=
 =?utf-8?B?QmRRVnB0UXVqemd2Q3JpWW5ZQitkOWpuVGRMOG5iVU9ROW9ZUWZwbU5OUS83?=
 =?utf-8?B?dEZBSnV6S1U2bWE1bm1RdFdLcXQyS0cwWHRIUGgvZmZZZkZrcjBhWnFOTEho?=
 =?utf-8?B?dU5GWFI5ZUh2WnFiZEtBL0N5bk1GRDA4b1Z4Vk5ZejRkdVplRDZ6YnQ0VzBY?=
 =?utf-8?B?UHA2S2U5S2ZsR3BaRFF5RytWZmxEbUNQQXNvbUo5QUdocnJCb25NZFM0MG9D?=
 =?utf-8?B?MC9CR2RQUStXS3RUdHFXOEc4eWV1RUNiSTNsc28xYzFKQnBRN2VXZ1NrR3Iz?=
 =?utf-8?B?OTBZekg1RXFwMWFrbVlkZVlyWHBVeXV3VGtnRzZjZitqVGNnUnN6N0NzR3VY?=
 =?utf-8?Q?p31liW6YmeAtKNbrl7g3hAa9w9FbQWdQ?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:28:48.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27779751-6ed8-4e19-0eba-08dd0d2b2f75
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2043
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

SGkgU3RlZmFuLAoKT24gRG8sIDIwMjQtMTEtMjEgYXQgMTE6MTIgKzAxMDAsIFN0ZWZhbiBXYWhy
ZW4gd3JvdGU6Cj4gSGkgQ2hyaXN0b3BoLAo+IAo+IEFtIDIwLjExLjI0IHVtIDE3OjMxIHNjaHJp
ZWIgQ2hyaXN0b3BoIFN0b2lkbmVyOgo+IAoKWy4uLl0KCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kKPiA+IGIvYXJjaC9h
cm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpCj4gPiBpbmRleCA2ODk3Yzkx
ZjRkLi43MDJkODZmNGUwIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJv
YXJkLXNlZ2luLXUtYm9vdC5kdHNpCj4gPiArKysgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9h
cmQtc2VnaW4tdS1ib290LmR0c2kKPiA+IEBAIC0xMzksNiArMTM5LDEzIEBACj4gPiDCoCAmdXNk
aGMxIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBib290cGgtcHJlLXJhbTsKPiA+IMKgwqDCoMKgwqDC
oMKgwqBib290cGgtc29tZS1yYW07Cj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKg
wqDCoMKgICogUmVtb3ZlIHBpbmN0cmwgYXNzaWdubWVudHMgb25jZSB0aGV5IGFyZSBhZGRlZCB0
byBpbXg5My0KPiA+IHBoeWNvcmUtc29tLmR0c2kKPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4g
K8KgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInN0YXRlXzEwMG1oeiIs
ICJzdGF0ZV8yMDBtaHoiOwo+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJs
X3VzZGhjMT47Cj4gPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTEgPSA8JnBpbmN0cmxfdXNkaGMx
XzEwMG1oej47Cj4gPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTIgPSA8JnBpbmN0cmxfdXNkaGMx
XzIwMG1oej47Cj4gPiDCoCB9Owo+ID4gCj4gPiDCoCAmdXNkaGMyIHsKPiA+IEBAIC0yMTUsNiAr
MjIyLDQ4IEBACj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBNWDkzX1BBRF9FTkVUMl9SRDNfX0dQSU80X0lPMjfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+ID4gwqDCoMKgwqDCoDB4MzFlCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoD47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoC8q
Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBSZW1vdmUgcGluY3RybF91c2RoYzFfMTAwbWh6IGFuZCBw
aW5jdHJsX3VzZGhjMV8yMDBtaHoKPiA+IG9uY2UgdGhleQo+ID4gK8KgwqDCoMKgwqDCoMKgICog
YXJlIGFkZGVkIHRvIGlteDkzLXBoeWNvcmUtc29tLmR0c2kKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
Lwo+ID4gK8KgwqDCoMKgwqDCoMKgLyogbmVlZCB0byBjb25maWcgdGhlIFNJT04gZm9yIGRhdGEg
YW5kIGNtZCBwYWQsIHJlZmVyIHRvCj4gPiBFUlIwNTIwMjEgKi8KPiA+ICvCoMKgwqDCoMKgwqDC
oHBpbmN0cmxfdXNkaGMxXzEwMG1oejogdXNkaGMxLTEwMG1oemdycCB7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYm9vdHBoLXNvbWUtcmFtOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZzbCxwaW5zID0gPAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfQ0xLX19VU0RIQzFfQ0xLwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgMHgxCj4gPiA3YmUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0NNRF9fVVNESEMxX0NNRMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDB4NAo+ID4gMDAwMTM5ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfREFUQTBfX1VTREhDMV9EQVRBMMKg
wqDCoMKgwqDCoMKgwqAweDQKPiA+IDAwMDEzOGUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0RBVEExX19VU0RIQzFfREFUQTHC
oMKgwqDCoMKgwqDCoMKgMHg0Cj4gPiAwMDAxMzllCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBMl9fVVNESEMxX0RBVEEy
wqDCoMKgwqDCoMKgwqDCoDB4NAo+ID4gMDAwMTNiZQo+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFp
biB3aHkgdGhlIHBpbiBjb25maWd1cmF0aW9uIGZvciAxMDAgTUh6IG9mCj4gREFUQTAKPiAmIERB
VEEyIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBvdGhlciBkYXRhIHBpbnM/CgpUaGUgZGlmZmVyZW5j
ZSBpbiB0aGUgdmFsdWVzIGlzIGR1ZSB0byBkaWZmZXJlbnQgZHJpdmUtc3RyZW5ndGgKc2V0dGlu
Z3MgcGVyIHBpbi4gVGhlIHZhbHVlcyBhcmUgdGhlIHJlc3VsdCBvZiBtZWFzdXJlbWVudHMgd2UK
ZGlkIGZvciB0aGUgZU1NQyBpbnRlcmZhY2UuIFRoZXJlLCB3ZSBhZGp1c3RlZCBlYWNoIHBpbidz
CmRyaXZlLXN0cmVuZ3RoIHRvIGdldCBpdCdzIGJlc3Qgc2lnbmFsIHF1YWxpdHkuCgpSZWdhcmRz
LApDaHJpc3RvcGgKCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBM19fVVNESEMxX0RBVEEzwqDCoMKgwqDCoMKgwqDCoDB4
NAo+ID4gMDAwMTM5ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBNWDkzX1BBRF9TRDFfREFUQTRfX1VTREhDMV9EQVRBNMKgwqDCoMKgwqDCoMKgwqAw
eDQKPiA+IDAwMDEzOWUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgTVg5M19QQURfU0QxX0RBVEE1X19VU0RIQzFfREFUQTXCoMKgwqDCoMKgwqDCoMKg
MHg0Cj4gPiAwMDAxMzllCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBNl9fVVNESEMxX0RBVEE2wqDCoMKgwqDCoMKgwqDC
oDB4NAo+ID4gMDAwMTM5ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfREFUQTdfX1VTREhDMV9EQVRBN8KgwqDCoMKgwqDCoMKg
wqAweDQKPiA+IDAwMDEzOWUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX1NUUk9CRV9fVVNESEMxX1NUUk9CRcKgwqDCoMKgwqDC
oDB4MQo+ID4gNzllCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiA+ICvC
oMKgwqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBuZWVkIHRvIGNvbmZp
ZyB0aGUgU0lPTiBmb3IgZGF0YSBhbmQgY21kIHBhZCwgcmVmZXIgdG8KPiA+IEVSUjA1MjAyMSAq
Lwo+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybF91c2RoYzFfMjAwbWh6OiB1c2RoYzEtMjAwbWh6
Z3JwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290cGgtcHJlLXJhbTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290cGgtc29tZS1yYW07Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNsLHBpbnMgPSA8Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9DTEtfX1VT
REhDMV9DTEvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDEKPiA+IDdiZQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFfQ01EX19V
U0RIQzFfQ01EwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHg0Cj4gPiAwMDAxMzllCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9E
QVRBMF9fVVNESEMxX0RBVEEwwqDCoMKgwqDCoMKgwqDCoDB4NAo+ID4gMDAwMTM5ZQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9TRDFf
REFUQTFfX1VTREhDMV9EQVRBMcKgwqDCoMKgwqDCoMKgwqAweDQKPiA+IDAwMDEzYmUKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0Qx
X0RBVEEyX19VU0RIQzFfREFUQTLCoMKgwqDCoMKgwqDCoMKgMHg0Cj4gPiAwMDAxM2JlCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NE
MV9EQVRBM19fVVNESEMxX0RBVEEzwqDCoMKgwqDCoMKgwqDCoDB4NAo+ID4gMDAwMTNiZQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BBRF9T
RDFfREFUQTRfX1VTREhDMV9EQVRBNMKgwqDCoMKgwqDCoMKgwqAweDQKPiA+IDAwMDEzYmUKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURf
U0QxX0RBVEE1X19VU0RIQzFfREFUQTXCoMKgwqDCoMKgwqDCoMKgMHg0Cj4gPiAwMDAxM2JlCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFE
X1NEMV9EQVRBNl9fVVNESEMxX0RBVEE2wqDCoMKgwqDCoMKgwqDCoDB4NAo+ID4gMDAwMTNiZQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDkzX1BB
RF9TRDFfREFUQTdfX1VTREhDMV9EQVRBN8KgwqDCoMKgwqDCoMKgwqAweDQKPiA+IDAwMDEzYmUK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19Q
QURfU0QxX1NUUk9CRV9fVVNESEMxX1NUUk9CRcKgwqDCoMKgwqDCoDB4MQo+ID4gNzllCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiA+ICvCoMKgwqDCoMKgwqDCoH07Cj4g
PiDCoCB9Owo+ID4gCg==
