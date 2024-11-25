Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C9D3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2E889A16;
	Mon, 25 Nov 2024 11:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="VxPnta23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD90689A0B; Mon, 25 Nov 2024 11:18:40 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D1089A17
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcYpJSUHSEmZXhjCdLyHcz2MC5rpzvht2lRMnlu0EsjAE5XE5GddeEuzpBzuZUl1zgOIhCgXpkFwaqteo1Z7WVce/LeL1tmPLjqbcQTyOiboiXm/FCmO8Qw8s6MvPkLNHEjwVGIM95QJhc4lil7JJHheUUxIa0874zbkYuuHN7vp2V+tw3jazY7rwY96RXdZOh5WeyAV5vLnDmKROB3/EoAgreXms+bmdICSPWslqzME6vYKsn8vGGghwc1+tnnrW7jxe1MRTY1JoLhw75e5/QQcLlHrbJhcI0rKXneXWOGpxtO6XdRBs/yBR+RoRJsxaM9IxSQYwxVGPa/J3Szv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F14UaZNxZIs69LCnU6jApoDu7cifvB0jigeBTGcxO+4=;
 b=D8X116bUSvQpzjZCiJB0x3uQYDvrfIXsZuM3jvZESlIAi3SbK2qJrErn6EKs1PxKfNt6wRSp5OcN+jc/dCvRQHyPvajFy68yv0NvBCCkiQhIlFv2yxzHg9w36F9cmBcMAnPtqpDeoEmcEBzioqt7n4RMRFt4QzfPmvvudCzXakU7ybPd4Mf5u1RwcYp1wepehRHB47hMeVW3Kg2TuHSTXkO/WWqpQiAxLX7Z9nCFFyJtD6JcpyqvR3eZ71bW8E5ZRtYxwA4QAzpkEePGLZ482l+gsSwoW0PVhl0UN1kogmWd3cNoGdpFMI/Zla6uc41uz3wbhMMiDca84RzDkE1ZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F14UaZNxZIs69LCnU6jApoDu7cifvB0jigeBTGcxO+4=;
 b=VxPnta23oozl+ZO4A3Sr6urfI0HPfp1OMopHvGJ2ghpngk3202tURzsy34nzm2tMGRh7xK4j/v4B9I4uoY+4B6GMe35SO1gcpv011wZzqv0bYHRnCsJu3D/V96HMsp6LnbzBAwuLr1m8CQFAaEg9wXjG+4RCzuFSUI/eLHGUHQs=
Received: from DU7PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::12) by GVXP195MB1664.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:6a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 10:18:34 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::20) by DU7PR01CA0018.outlook.office365.com
 (2603:10a6:10:50f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 10:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 10:18:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 11:03:31 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 11:03:31 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Mon, 25 Nov 2024 11:03:31 +0100
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
Thread-Index: AQHbO2m655mv1wTilUe5fMsmnpmCI7LBdCoAgAYsVICAABO3gIAABsIA
Date: Mon, 25 Nov 2024 10:03:31 +0000
Message-ID: <09138aea8ba35d7bb8d4d8d7912f4cc54a96862b.camel@phytec.de>
References: <20241120163143.127862-1-c.stoidner@phytec.de>
 <20241120163143.127862-3-c.stoidner@phytec.de>
 <371c6302-438b-45b6-944b-d513f74f38a5@gmx.net>
 <05db2b94c4eb28aefc33a13c6fb2fa324eb62ee7.camel@phytec.de>
 <8c8607a0-f8b0-438e-886e-a637a561366c@gmx.net>
In-Reply-To: <8c8607a0-f8b0-438e-886e-a637a561366c@gmx.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <205C570FD1BAE349B87262E824126699@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|GVXP195MB1664:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8d5720-ee1c-42c5-607e-08dd0d3a846e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUUxWjY3bXdLcHBBdGVxdjd1VGN3YjlHWkhMYVFwSSt0VWJRd0s2aG0yOUlO?=
 =?utf-8?B?RFprNjV1OGNkb3NVUTdheGMwRndWd2Qxc2l1ZzlDVEx6N21OQXlkVjBRTExj?=
 =?utf-8?B?N0kwaFJKRDNuSzIreTVtYUxDL2dPRUlVVHRub0x6UFVrWmxoVDdJU1lzTDRr?=
 =?utf-8?B?SGtKMXRCWHBDTFdDeElqUmhITWxEYUdoY0VyZGVMNnZPZUZNQ1JNRzdNNGRV?=
 =?utf-8?B?MDMwY29oQ0VucW5ZcFVWMjRPUEc3dHp4ejZUNG1jNkJZdkRYcDhTUXI1MWsx?=
 =?utf-8?B?OVNUL0hvSEdaUEd0bGdTaURVTndYRlZ2ZDIwMnpZT1JlYnVxNnBVa2NtUGRV?=
 =?utf-8?B?dnNjamRXSmRZQ2wxQkhTSWFURUpWNDR0Qm9qcVpUSXJzcm5DQzZITmJ2WHlD?=
 =?utf-8?B?UVlrUTRGTDg3ZDNySEM4VFBNQXFXbHk2UFpic0dNNGFGZmdHN3RKc3FRcVdL?=
 =?utf-8?B?dXVCY1ZGak1Ra3MxakZ4YUJ6eVZPQi92SUlvTEtIOEtmdUVyeVdLNFhGQUtN?=
 =?utf-8?B?Vlp1WHlLcERFTTVXcWN4ZGtwcngxcy8zQTFKbjU1cHNjRnlTcC9JOXFRSzlF?=
 =?utf-8?B?MWVQcmVuMnZxVjlrYUoxbXFqMzJJL0hpcDUvdlQ3RUZvTEU3QnV1KzBRNEFx?=
 =?utf-8?B?N2RrWWI5T3QvS3FFMkxjM3g0ZnJ0d2NEenpnRWJhdG1VcWRNUlliaUR2Qk45?=
 =?utf-8?B?YlF0amcrM0J6Ly80K1VXaStQU0dLa0o2UTkwMkxHazZUc2M2MEdsa29HRGx4?=
 =?utf-8?B?NlgzMGFrZzVsVSsvUzN4VnF0ajk1Z1FHeDk0bi8wczJ6MG1MMlVGdnFWakhL?=
 =?utf-8?B?bDhXRTBpOWY5VVc5STh5bUUwZDN0THZNRmE2MGwrZk5tK3NiWjVzQzh3aDJ2?=
 =?utf-8?B?TTdYVXZWaThOandYRDBXZjk3aFVVOHc2NWNCZnNrcVVvSmdxTGtkUjlHL2FF?=
 =?utf-8?B?UEtkcVk4QXlGZWROQlN0QUk3RDErNkhWbys1V0VaK3JwdFZ4clhQOG1sNmRV?=
 =?utf-8?B?VDBlMnA2aWEzZDFET0RUbW9vT1dsK2FKMFI2NjAzMFhZQzJoWkhFVEl5N3Fl?=
 =?utf-8?B?cFlTU2dYdmZ6QXByWldYcDJ4L0dIL1F2N0kwVXo0eDZScGpyN0VaNURZdUlR?=
 =?utf-8?B?Z2FrUjJhV0MwR3NGdlFDa2ZPKzNMcFdDQzZXQW9jYWMwa2dzQVhpZGFPTEds?=
 =?utf-8?B?RGpwZnlLSXAxUTJzVHZWNFNaRVFYMVhQTVV1eWVpTlpIREx2bWtJczl4TGlC?=
 =?utf-8?B?SWMyRFZHVUs1THdOVVFia1JHT0g4Uk1CSU9qK0phd1VkRnViRVNUYWRVZzg5?=
 =?utf-8?B?Q1VrZDZZRHZXRHRQdXlueFhRTTQwM1Zac0xXS1hWK0ZBQkRGaXhuQVBNZXNH?=
 =?utf-8?B?Qy82cU5VQ0RrVE5hTkRteUhHcFRhRDVVM2dDK1RScmg5T1VIdWs2SG5zN1FW?=
 =?utf-8?B?VzYvaEJLd3ZEbVdKZ3E5LzRxMlhkNFRqWUQxcWxFaEhTdEd6YWViL1h1OTBO?=
 =?utf-8?B?aUM1ZG9rc3pnRzZISzROZ2xqUEwvcFlSWkptbVErRVl1OEI0UTVxOU5zRHJ6?=
 =?utf-8?B?cHpZY0RCQ2RvaDVHVUpoOFFXZHJJTHpXSkxYV0o4WjJBZnhRTTR6bkpvZHpk?=
 =?utf-8?B?RHNKMVJDZTV2ZEQrbUFRTHF3WExpUUVZRVNFVkNlVzVVcDlQUjFmbFo3cDRy?=
 =?utf-8?B?Zm5DUG1Eb1dkd3E5aUVhVnVvbHlmYlk2d0Y4SVhsTmJtdUw0a3BNUkdOUVE3?=
 =?utf-8?B?Wk56TGtMU0h2SnRMMnEySy94MjRvclZiTnB6Rys1YlllVnpCYmRwTmV1UWVG?=
 =?utf-8?B?WGE2OGQxSEVPNU5yamV6RldGbFBvMmRjdXpvdTVoOTJ5WWFwUjV3YXFESzYz?=
 =?utf-8?B?aTc5NXFiTEYyRmpuNngxTzhCSnBtNWtkR3dUMm5Oa3Mrd0owRm45U0M1czBl?=
 =?utf-8?Q?lR+sgxQkzsrr6wCXbb4n27Ue2CfYtL6l?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 10:18:33.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8d5720-ee1c-42c5-607e-08dd0d3a846e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1664
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

SGkgU3RlZmFuLAoKT24gTW8sIDIwMjQtMTEtMjUgYXQgMTA6MzkgKzAxMDAsIFN0ZWZhbiBXYWhy
ZW4gd3JvdGU6Cj4gSGkgQ2hyaXN0b3BoLAo+IAo+IEFtIDI1LjExLjI0IHVtIDA5OjI4IHNjaHJp
ZWIgQ2hyaXN0b3BoIFN0b2lkbmVyOgo+ID4gSGkgU3RlZmFuLAo+ID4gCj4gPiBPbiBEbywgMjAy
NC0xMS0yMSBhdCAxMToxMiArMDEwMCwgU3RlZmFuIFdhaHJlbiB3cm90ZToKPiA+ID4gSGkgQ2hy
aXN0b3BoLAo+ID4gPiAKPiA+ID4gQW0gMjAuMTEuMjQgdW0gMTc6MzEgc2NocmllYiBDaHJpc3Rv
cGggU3RvaWRuZXI6Cj4gPiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kKPiA+ID4gPiBiL2Fy
Y2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQo+ID4gPiA+IGluZGV4
IDY4OTdjOTFmNGQuLjcwMmQ4NmY0ZTAgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vZHRz
L2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpCj4gPiA+ID4gKysrIGIvYXJjaC9hcm0v
ZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpCj4gPiA+ID4gQEAgLTEzOSw2ICsx
MzksMTMgQEAKPiA+ID4gPiDCoMKgICZ1c2RoYzEgewo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oGJvb3RwaC1wcmUtcmFtOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1zb21lLXJh
bTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFJl
bW92ZSBwaW5jdHJsIGFzc2lnbm1lbnRzIG9uY2UgdGhleSBhcmUgYWRkZWQgdG8KPiA+ID4gPiBp
bXg5My0KPiA+ID4gPiBwaHljb3JlLXNvbS5kdHNpCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgICov
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgInN0YXRl
XzEwMG1oeiIsCj4gPiA+ID4gInN0YXRlXzIwMG1oeiI7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
cGluY3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMT47Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcGlu
Y3RybC0xID0gPCZwaW5jdHJsX3VzZGhjMV8xMDBtaHo+Owo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oHBpbmN0cmwtMiA9IDwmcGluY3RybF91c2RoYzFfMjAwbWh6PjsKPiA+ID4gPiDCoMKgIH07Cj4g
PiA+ID4gCj4gPiA+ID4gwqDCoCAmdXNkaGMyIHsKPiA+ID4gPiBAQCAtMjE1LDYgKzIyMiw0OCBA
QAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgTVg5M19QQURfRU5FVDJfUkQzX19HUElPNF9JTzI3Cj4gPiA+ID4gwqDCoMKgwqDCoMKgMHgz
MWUKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKgo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFJlbW92ZSBwaW5jdHJsX3VzZGhjMV8xMDBtaHogYW5k
Cj4gPiA+ID4gcGluY3RybF91c2RoYzFfMjAwbWh6Cj4gPiA+ID4gb25jZSB0aGV5Cj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgICogYXJlIGFkZGVkIHRvIGlteDkzLXBoeWNvcmUtc29tLmR0c2kKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBuZWVkIHRv
IGNvbmZpZyB0aGUgU0lPTiBmb3IgZGF0YSBhbmQgY21kIHBhZCwgcmVmZXIKPiA+ID4gPiB0bwo+
ID4gPiA+IEVSUjA1MjAyMSAqLwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmxfdXNkaGMx
XzEwMG1oejogdXNkaGMxLTEwMG1oemdycCB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFtOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBib290cGgtc29tZS1yYW07Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGZzbCxwaW5zID0gPAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0NMS19fVVNESEMxX0NMS8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4MQo+ID4gPiA+IDdiZQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0NNRF9fVVNE
SEMxX0NNRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEz
OWUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oE1YOTNfUEFEX1NEMV9EQVRBMF9fVVNESEMxX0RBVEEwwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDC
oDB4NAo+ID4gPiA+IDAwMDEzOGUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBMV9fVVNESEMxX0RBVEExwqDCoMKg
wqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBMl9f
VVNESEMxX0RBVEEywqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzYmUK
PiA+ID4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHdoeSB0aGUgcGluIGNvbmZpZ3VyYXRpb24g
Zm9yIDEwMCBNSHogb2YKPiA+ID4gREFUQTAKPiA+ID4gJiBEQVRBMiBpcyBkaWZmZXJlbnQgZnJv
bSB0aGUgb3RoZXIgZGF0YSBwaW5zPwo+ID4gVGhlIGRpZmZlcmVuY2UgaW4gdGhlIHZhbHVlcyBp
cyBkdWUgdG8gZGlmZmVyZW50IGRyaXZlLXN0cmVuZ3RoCj4gPiBzZXR0aW5ncyBwZXIgcGluLiBU
aGUgdmFsdWVzIGFyZSB0aGUgcmVzdWx0IG9mIG1lYXN1cmVtZW50cyB3ZQo+ID4gZGlkIGZvciB0
aGUgZU1NQyBpbnRlcmZhY2UuIFRoZXJlLCB3ZSBhZGp1c3RlZCBlYWNoIHBpbidzCj4gPiBkcml2
ZS1zdHJlbmd0aCB0byBnZXQgaXQncyBiZXN0IHNpZ25hbCBxdWFsaXR5Lgo+IFRoYW5rcyBmb3Ig
dGhlIGV4cGxhbmF0aW9uLiBTbyB5b3UgbWVhc3VyZWQgYWxzbyB0aGUgMjAwIE1IeiBjYXNlPyAK
PiBCZWNhdXNlIHRoZXJlIGFyZSBubyBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZSBkYXRhIHBpbnMu
CgpZZXMsIHdlIG1lYXN1cmVkIGFsc28gZm9yIDIwMCBNSHouIFRoZXJlIHRoZSBzYW1lIHZhbHVl
IHdhcyBwZXJmZWN0CmZvciBhbGwgcGlucy4KCj4gCj4gUmVnYXJkcwo+ID4gCj4gPiBSZWdhcmRz
LAo+ID4gQ2hyaXN0b3BoCj4gPiAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBM19fVVNESEMxX0RBVEEzwqDCoMKg
wqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBNF9f
VVNESEMxX0RBVEE0wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUK
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1Y
OTNfUEFEX1NEMV9EQVRBNV9fVVNESEMxX0RBVEE1wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4
NAo+ID4gPiA+IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBNl9fVVNESEMxX0RBVEE2wqDCoMKgwqDC
oMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBN19fVVNE
SEMxX0RBVEE3wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNf
UEFEX1NEMV9TVFJPQkVfX1VTREhDMV9TVFJPQkXCoMKgwqDCoMKgCj4gPiA+ID4gwqAweDEKPiA+
ID4gPiA3OWUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqB9Owo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBu
ZWVkIHRvIGNvbmZpZyB0aGUgU0lPTiBmb3IgZGF0YSBhbmQgY21kIHBhZCwgcmVmZXIKPiA+ID4g
PiB0bwo+ID4gPiA+IEVSUjA1MjAyMSAqLwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmxf
dXNkaGMxXzIwMG1oejogdXNkaGMxLTIwMG1oemdycCB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFtOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBib290cGgtc29tZS1yYW07Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZzbCxwaW5zID0gPAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0NMS19fVVNESEMxX0NMS8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4MQo+ID4gPiA+IDdiZQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg5M19QQURfU0QxX0NN
RF9fVVNESEMxX0NNRMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+
IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBMF9fVVNESEMxX0RBVEEwwqDCoMKgwqDCoMKgwqAKPiA+
ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzOWUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBMV9fVVNESEMxX0RBVEEx
wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzYmUKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9E
QVRBMl9fVVNESEMxX0RBVEEywqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAw
MDEzYmUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoE1YOTNfUEFEX1NEMV9EQVRBM19fVVNESEMxX0RBVEEzwqDCoMKgwqDCoMKgwqAKPiA+ID4g
PiDCoDB4NAo+ID4gPiA+IDAwMDEzYmUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBNF9fVVNESEMxX0RBVEE0wqDC
oMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzYmUKPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRB
NV9fVVNESEMxX0RBVEE1wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEz
YmUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oE1YOTNfUEFEX1NEMV9EQVRBNl9fVVNESEMxX0RBVEE2wqDCoMKgwqDCoMKgwqAKPiA+ID4gPiDC
oDB4NAo+ID4gPiA+IDAwMDEzYmUKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9EQVRBN19fVVNESEMxX0RBVEE3wqDCoMKg
wqDCoMKgwqAKPiA+ID4gPiDCoDB4NAo+ID4gPiA+IDAwMDEzYmUKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOTNfUEFEX1NEMV9TVFJPQkVf
X1VTREhDMV9TVFJPQkXCoMKgwqDCoMKgCj4gPiA+ID4gwqAweDEKPiA+ID4gPiA3OWUKPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPjsKPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqB9Owo+ID4gPiA+IMKgwqAgfTsKPiA+ID4gPiAKPiAK
