Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B47D6204E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 09:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A81389541;
	Tue, 19 Nov 2024 10:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="wX6m5QHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDFA489541; Tue, 19 Nov 2024 10:32:47 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3E8892C6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFXq5dcuLojt7hUFyxOpFanXdoT7s01s9kta7iyKXu//vepXRivStIS07Ux6eeiuHaXtWqkRH7udYOtMlC2X4Y7NbztXtwjZIlOInB2WD2OfpvnTUkug94cnSzqdDMwIkws1I++sPl6BQkneCnfqQhZEypxB0AwbYeXviOZFQAWMfBr/5Aun0iVReIoidTYmCn8AQPTTznGhXRe2sadb+w9KnXgtRLQorj+OmVZTi4ch4ap/5ZGLkL/mq3fc6zpdQJpn42UwOANjeq4DxkaqyGhj14wRt1EYGLYNZw5Tsl9QkWtys6HGlev+wYE4vpXJ/YHake4BZatsPtzvI6SzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIzHYd7v6erHSbYGugt5fcfW+LfWE7cxLSm5KK+X3Pk=;
 b=H3ydjtvtgl8bFCMN1ldhaG0xBVv2jm3PcHU4p1MbzVohz8IWEzJhj60zKls45mowElXUTZVNECQuAxLHw9VPZnbbX6dTqfMoauBIZSIQ/ZeT/aSTVG7j0zVMicT6C14jA3/M4Z7sdsSohdM/JHIJ2sMHVHXtcgaL7tMlNlIit7qf1MmlIbhNgE8dN260C0HAVVwUTuAwJvJyf5ydS14BO17gEizPO9pExHDy144bJ4K/gS2Vwok5fY4j125ALownxRhEoFaRGe7Ka57hBSangdXH2e0DgaqN4vjS9LHnKO5SBFb5wCzVEc2bQXeKYrzTYHfUnM6Kv1ginUPPJlsFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIzHYd7v6erHSbYGugt5fcfW+LfWE7cxLSm5KK+X3Pk=;
 b=wX6m5QHwGKeFGZcoeHay5Y/twQIXHT3uKTlXrDuCPAwt1PNfeg27Xn3qOkizWPmwT27FjpME8phikDo4k5GuQ5c3JJkDf5NU61eNA1O2OPTS9kPQl+VjkvWGboN2/teM9oUadUcgy6M/CisVYLNvbtvMByoSJsDUMu5NfCTY67o=
Received: from AM0PR03CA0019.eurprd03.prod.outlook.com (2603:10a6:208:14::32)
 by DBAP195MB1018.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 09:32:39 +0000
Received: from AM2PEPF0001C708.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::e0) by AM0PR03CA0019.outlook.office365.com
 (2603:10a6:208:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 09:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C708.mail.protection.outlook.com (10.167.16.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 09:32:38 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 10:32:38 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 10:32:38 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Tue, 19 Nov 2024 10:32:38 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Primoz Fiser <primoz.fiser@norik.com>
CC: Yannic Moog <Y.Moog@phytec.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, Andrej Picej <andrej.picej@norik.com>, "sbabic@denx.de"
 <sbabic@denx.de>, Wadim Egorov <W.Egorov@phytec.de>, "m.othacehe@gmail.com"
 <m.othacehe@gmail.com>
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Topic: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Index: AQHbNeU53U95sTpb5UKeBgkqmviyVrK2ZQGAgAfqYYA=
Date: Tue, 19 Nov 2024 09:32:38 +0000
Message-ID: <3259ca16e9c1cf3b736938c7958bf9e21afaf62f.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
 <4f65f0a2-d0f7-4b0c-934f-d32c0a36be11@norik.com>
In-Reply-To: <4f65f0a2-d0f7-4b0c-934f-d32c0a36be11@norik.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0CD6962DDABC458ACA40731CD23774@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C708:EE_|DBAP195MB1018:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e12676-33f2-4b80-b529-08dd087d1bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFVZUzg0dzV4WVIzMHQ0U3FlYUtBZktHSmMwVm0wUE5CdFVxaGltbk4zcVFS?=
 =?utf-8?B?aG1jZW9KcjdCYWNqVS9OTys0RUdtWjVrMjcveEZNMXJteE5SVVFWM3VMY2lx?=
 =?utf-8?B?NU1ybGhlanMrNUNYNzMwL2ViQ1J4Yll2anNhSXpqMVdpNGl1YkdiT2pKVC9Q?=
 =?utf-8?B?bHdIcEdSdktqT01nMVlOdnJuckl2NUxRZFIvVCt5M3hjNVJOVVh3d2xSOHRo?=
 =?utf-8?B?YitrZlB2a3gyeUZtdWpnOEI3V3lJdUF4bjV2R1pJM2tIQ3lDb204aUxXUDRZ?=
 =?utf-8?B?TjdpeksvMndEeVlaTjN2ZnQ4RU9qaVBOZ0tqZlk3U3NkWWhJekNPL0dRSi9u?=
 =?utf-8?B?U1lMcGJBenE3YW1kZDNHUXpSM1lpWWZBa3BjK3JORjc2SmtpdEdRbFE5czdP?=
 =?utf-8?B?YVhpemFqeFgyT1llQzRWZHN5Y1kyMmFjeDJlbVp6WEptZ1ArM3FYdmJWVVdq?=
 =?utf-8?B?cEZtQjEzZkFCalExWE9GUnFWeHJVNGRneHA4TmxjN1ZDN3A1U05pL0pzSk9n?=
 =?utf-8?B?ekJRMGxBVWlzdXdSSkRhSW1JUm9icEJBdTVvQ2l4THB6aWIva1Fta3YrQmxZ?=
 =?utf-8?B?YjRaTEFNMlVoanRwTDV3ZHk0YW91cXBzdHJRTSs4RXVib2pET1YrOHd4REh2?=
 =?utf-8?B?MWZlS1d0UkhJQXp5Lzh6RVptbUo5WTBCK3ovZUdxcURtV1laaGhLRHRnS3hO?=
 =?utf-8?B?eFF0eS9hbHlqTjZsRlVRYTlUVy9rMm5qMDd5NGhqTmR1RlFEMThkcE5qQVF2?=
 =?utf-8?B?ZjRUa1FCblNDYzhWdzY3cWt3bGN4WGVzbWZkQXJaOEEyQWMxVW8vMW96b2Nv?=
 =?utf-8?B?WWY4YjJjcWJueGtYZHRJaUt6ZHRWckdvTmRDSFRtRS9aZzhmQ29YQktlMjdW?=
 =?utf-8?B?YVZjT2NwOCtMMWpEVktxVVBLcllNZ2NNNVNxbjgxWDRiWmxjL2c0cDBWNFZC?=
 =?utf-8?B?V3hEWlBPdGZQZnVObTFpUERLN2xlelpwMllCaGtOVGR4OFVhOU1FMVdiMG5o?=
 =?utf-8?B?T1R0aWphNjhYdVEvdytTc1RWWEpqbnlKbVRydCtBRTd0WWZyS2tLS2JiQ252?=
 =?utf-8?B?RlZVQ28rUVp4bkRjSzhWeGxWTDltMlpSQ2lGdGIzc1VqQTNnbjNKdVY3Rk4z?=
 =?utf-8?B?eFNTdVQ3RlRpbXVkQ1lXWHgydjh0Z1RXbUNzUDJnL3MzbFNIQkNNSnZrZVFu?=
 =?utf-8?B?Vi9sdEk2UnpVdE1waWtGN2FmYVZMM0s4YVBjMnpjUXI1Uk1oVnRzdllmQUlJ?=
 =?utf-8?B?UG1nQW5oMlFobHpSWkszYkVFcS8xVmVQZzllcERJVXBRdWJTZ05TUkVjYU4z?=
 =?utf-8?B?SWtSS3lJWXE0L29xZEsvb3VlTFlkUGZIanNzQTdiTGt5ZXVhVzJ3S0Zxc3BE?=
 =?utf-8?B?Si9jb2RoQzM4c2RtWnRtdUZWeHBkS0U5VHRwc1NiWThGZXN3ZHBsR3VlUWhm?=
 =?utf-8?B?UVNROElwdTRHZnlvQmdTNmVnZ2RkOXdKMk8veFZlS3NlOVRWUkFvejE4Z0dm?=
 =?utf-8?B?WXJnMHp1Z0ZKbGk5SCtsVjY3Q0pkSFVhdHBFN0hseEN2Nlp5OWhFeURqa1Qx?=
 =?utf-8?B?YytyLzVIL3pJMG9SOVIvNStZU1dLRU80a1lCMEpzNzI4Rm9kM1Q3TmJFZTlL?=
 =?utf-8?B?eXBmeFRjN2FOODE5OXJzeUhoclpjbUdtNytKbnErdHNkSmdVUUJITWhUKzhQ?=
 =?utf-8?B?cWY5M3Vva2lqRHF6THZUdkV2eHpBWWJMdWVWZWNNcFAzYnRDekpBTjhvN3dQ?=
 =?utf-8?B?RzdwTUd2V0JiNFpRVk00NUUvS1F5aTFZcFVCSXNMUi9kWmlCRENxRVI4Rmk2?=
 =?utf-8?Q?5x0uMTDfGVBQYVvKWiXHi6umT8MpnfiDLgOeg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 09:32:38.9515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e12676-33f2-4b80-b529-08dd087d1bfa
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C708.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1018
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

DQpPbiBEbywgMjAyNC0xMS0xNCBhdCAwOTozOSArMDEwMCwgUHJpbW96IEZpc2VyIHdyb3RlOg0K
PiBIaSBDaHJpc3RvcGgsDQo+IA0KPiB0aGlzIHBhdGNoIGRvZXNuJ3QgYXBwbHkgYW55bW9yZSBv
biBsYXRlc3QgbWFzdGVyLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcmViYXNlIGZvciB2Mz8NCj4g
DQo+IFRoZW4gSSBjYW4gdGVzdCBpdCBvbiB0aGUgYm9hcmQuDQoNClllcywgSSBkbyB0aGF0IGZv
ciB0aGUgdjMuDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0LA0KQ2hyaXN0b3BoDQoNCj4gDQo+
IFRoYW5rcywNCj4gQlIsDQo+IFByaW1veg0KPiANCj4gT24gMTMuIDExLiAyNCAxNzowMCwgQ2hy
aXN0b3BoIFN0b2lkbmVyIHdyb3RlOg0KPiA+IFRoZSBwaHlDT1JFLWkuTVggOTMgaXMgYXZhaWxh
YmxlIGluIHZhcmlvdXMgdmFyaWFudHMgKGUuZy4NCj4gPiBkaWZmZXJlbnQgcmFtDQo+ID4gc2l6
ZXMsIGVNTUMgSFM0MDAgeWVzL25vKS4gRW5hYmxlIGhhcmR3YXJlIGludHJvc3BlY3Rpb24gZm9y
IHRoZQ0KPiA+IGlteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZywgc28gdGhhdCBkdXJpbmcg
c3RhcnR1cCB0aGUgU09NDQo+ID4gbW9kdWxlDQo+ID4gdmFyaWFudCBjYW4gYmUgZGV0ZWN0ZWQs
IGFuZCB0aGUgaGFyZHdhcmUgY2FuIGJlIGNvbmZpZ3VyZWQNCj4gPiBhY2NvcmRpbmdseS4NCj4g
PiBUaGUgcmVzdWx0aW5nIFNQTCBhbmQgdS1ib290IGJpbmFyeSBzaGFsbCBhYmxlIHRvIGJvb3Qg
ZWFjaA0KPiA+IHBoeUNPUkUtaS5NWCA5MyBtb2R1bGUgdmFyaWFudCBvbiBlYWNoIGNhcnJpZXIg
Ym9hcmQuIEZpbmFsbHkNCj4gPiByZW5hbWUNCj4gPiBpbXg5My1waHlib2FyZC1zZWdpbl9kZWZj
b25maWcgdG8gaW14OTMtcGh5Y29yZV9kZWZjb25maWcsIHRvDQo+ID4gaGlnaGxpZ2h0DQo+ID4g
aXRzIFNPTSBzY29wZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggU3RvaWRu
ZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiA+IC0tLQ0KPiA+IENjOiBNYXRoaWV1IE90aGFj
ZWhlIDxtLm90aGFjZWhlQGdtYWlsLmNvbT4NCj4gPiBDYzogQ2hyaXN0b3BoIFN0b2lkbmVyIDxj
LnN0b2lkbmVyQHBoeXRlYy5kZT4NCj4gPiBDYzogU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbngu
ZGU+DQo+ID4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gPiBDYzog
Ik5YUCBpLk1YIFUtQm9vdCBUZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+ID4gQ2M6IFRvbSBS
aW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4gQ2M6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5
dGVjLmRlPg0KPiA+IENjOiBQcmltb3ogRmlzZXIgPHByaW1vei5maXNlckBub3Jpay5jb20+DQo+
ID4gQ2M6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2VqQG5vcmlrLmNvbT4NCj4gPiBDYzogV2Fk
aW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0ZWMuZGU+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2
MjoNCj4gPiAtIGp1c3QgcmVuYW1lIGlteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZyBhbmQg
YWRkIG5lZWRlZA0KPiA+IENPTkZJR3MsDQo+ID4gwqAgaW5zdGVhZCBvZiBjcmVhdGluZyBhbiBl
bnRpcmVseSBuZXcgc2Vjb25kIGRlZmNvbmZpZw0KPiA+IC0gcmVtb3ZlIHdyb25nIGNvbW1lbnQg
ZnJvbSBpbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+IC0gaW1wcm92ZSBjb21t
aXQgbWVzc2FnZQ0KPiA+IA0KPiA+IMKgYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2lu
LXUtYm9vdC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDYNCj4gPiArKysrLS0N
Cj4gPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJTwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+IMKgLi4ueDkzLXBoeWJv
YXJkLXNlZ2luX2RlZmNvbmZpZyA9PiBpbXg5My1waHljb3JlX2RlZmNvbmZpZ30gfCA0DQo+ID4g
KysrLQ0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4gwqByZW5hbWUgY29uZmlncy97aW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmln
ID0+IGlteDkzLQ0KPiA+IHBoeWNvcmVfZGVmY29uZmlnfSAoOTglKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4g
PiBiL2FyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+IGlu
ZGV4IDI1Yzc3OGJiMDcuLjIyNDU0NjEwMzIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vZHRz
L2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRz
L2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gQEAgLTIsMTUgKzIsMTcgQEAN
Cj4gPiDCoC8qDQo+ID4gwqAgKiBDb3B5cmlnaHQgKEMpIDIwMjMgUEhZVEVDIE1lc3N0ZWNobmlr
IEdtYkgNCj4gPiDCoCAqIENocmlzdG9waCBTdG9pZG5lciA8Yy5zdG9pZG5lckBwaHl0ZWMuZGU+
DQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KPiA+
IMKgICoNCj4gPiDCoCAqIFByb2R1Y3QgaG9tZXBhZ2U6DQo+ID4gLSAqIHBoeUJPQVJELVNlZ2lu
IGNhcnJpZXIgYm9hcmQgaXMgcmV1c2VkIGZvciB0aGUgaS5NWDkzIGRlc2lnbi4NCj4gPiAtICog
aHR0cHM6Ly93d3cucGh5dGVjLmV1L2VuL3Byb2R1a3RlL3NpbmdsZS1ib2FyZC0NCj4gPiBjb21w
dXRlci9waHlib2FyZC1zZWdpbi1pbXg2dWwvDQo+ID4gK8KgwqAgaHR0cHM6Ly93d3cucGh5dGVj
LmRlL3Byb2R1a3RlL3N5c3RlbS1vbi1tb2R1bGVzL3BoeWNvcmUtaW14LQ0KPiA+IDkxLTkzLw0K
PiA+IMKgICovDQo+ID4gwqANCj4gPiDCoCNpbmNsdWRlICJpbXg5My11LWJvb3QuZHRzaSINCj4g
PiDCoA0KPiA+IMKgLyB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgbW9kZWwgPSAiUEhZVEVDIHBoeUNP
UkUtaS5NWDkzIjsNCj4gPiArDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHdkdC1yZWJvb3Qgew0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ3ZHQtcmVib290
IjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdkdCA9IDwmd2RvZzM+Ow0K
PiA+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0K
PiA+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCBj
ZWE4MTdmZmRjLi43MThmODlhMDg0IDEwMDY0NA0KPiA+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDkzL01BSU5UQUlORVJTDQo+ID4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14
OTMvTUFJTlRBSU5FUlMNCj4gPiBAQCAtOSw1ICs5LDUgQEAgRjrCoMKgwqDCoMKgIGFyY2gvYXJt
L2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LQ0KPiA+IGJvb3QuZHRzaQ0KPiA+IMKgRjrCoMKg
wqDCoMKgIGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzLw0KPiA+IMKgRjrCoMKgwqDCoMKgIGJv
YXJkL3BoeXRlYy9jb21tb24vaW14OTNfc29tX2RldGVjdGlvbi5jDQo+ID4gwqBGOsKgwqDCoMKg
wqAgYm9hcmQvcGh5dGVjL2NvbW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmgNCj4gPiAtRjrCoMKg
wqDCoMKgIGNvbmZpZ3MvaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnDQo+ID4gK0Y6wqDC
oMKgwqDCoCBjb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ID4gwqBGOsKgwqDCoMKg
wqAgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OTMuaA0KPiA+IGRpZmYgLS1naXQgYS9jb25m
aWdzL2lteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZw0KPiA+IGIvY29uZmlncy9pbXg5My1w
aHljb3JlX2RlZmNvbmZpZw0KPiA+IHNpbWlsYXJpdHkgaW5kZXggOTglDQo+ID4gcmVuYW1lIGZy
b20gY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gPiByZW5hbWUgdG8g
Y29uZmlncy9pbXg5My1waHljb3JlX2RlZmNvbmZpZw0KPiA+IGluZGV4IDE4YTQwODdlNGIuLmNm
OTgwMDExOGEgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9k
ZWZjb25maWcNCj4gPiArKysgYi9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ID4g
QEAgLTYsMTMgKzYsMTMgQEAgQ09ORklHX1NZU19NQUxMT0NfRl9MRU49MHgyMDAwMA0KPiA+IMKg
Q09ORklHX1NQTF9MSUJDT01NT05fU1VQUE9SVD15DQo+ID4gwqBDT05GSUdfU1BMX0xJQkdFTkVS
SUNfU1VQUE9SVD15DQo+ID4gwqBDT05GSUdfTlJfRFJBTV9CQU5LUz0yDQo+ID4gK0NPTkZJR19Q
SFlURUNfU09NX0RFVEVDVElPTj15DQo+ID4gwqBDT05GSUdfRU5WX1NPVVJDRV9GSUxFPSJwaHlj
b3JlX2lteDkzIg0KPiA+IMKgQ09ORklHX0VOVl9TSVpFPTB4MTAwMDANCj4gPiDCoENPTkZJR19F
TlZfT0ZGU0VUPTB4NzAwMDAwDQo+ID4gwqBDT05GSUdfSU1YX0NPTkZJRz0iYXJjaC9hcm0vbWFj
aC1pbXgvaW14OS9pbXhpbWFnZS5jZmciDQo+ID4gwqBDT05GSUdfRE1fR1BJTz15DQo+ID4gwqBD
T05GSUdfREVGQVVMVF9ERVZJQ0VfVFJFRT0iaW14OTMtcGh5Ym9hcmQtc2VnaW4iDQo+ID4gLUNP
TkZJR19TUExfVEVYVF9CQVNFPTB4MjA0OUEwMDANCj4gPiDCoENPTkZJR19BSEFCX0JPT1Q9eQ0K
PiA+IMKgQ09ORklHX1RBUkdFVF9QSFlDT1JFX0lNWDkzPXkNCj4gPiDCoENPTkZJR19PRl9MSUJG
RFRfT1ZFUkxBWT15DQo+ID4gQEAgLTIwLDYgKzIwLDcgQEAgQ09ORklHX1NZU19NT05JVE9SX0xF
Tj01MjQyODgNCj4gPiDCoENPTkZJR19TUExfU0VSSUFMPXkNCj4gPiDCoENPTkZJR19TUExfRFJJ
VkVSU19NSVNDPXkNCj4gPiDCoENPTkZJR19TUExfU1RBQ0s9MHgyMDUxOWRkMA0KPiA+ICtDT05G
SUdfU1BMX1RFWFRfQkFTRT0weDIwNDlBMDAwDQo+ID4gwqBDT05GSUdfU1BMX0hBU19CU1NfTElO
S0VSX1NFQ1RJT049eQ0KPiA+IMKgQ09ORklHX1NQTF9CU1NfU1RBUlRfQUREUj0weDIwNTFhMDAw
DQo+ID4gwqBDT05GSUdfU1BMX0JTU19NQVhfU0laRT0weDIwMDANCj4gPiBAQCAtMzEsNiArMzIs
NyBAQCBDT05GSUdfU1BMX0lNWF9ST01BUElfTE9BREFERFI9MHg4ODAwMDAwMA0KPiA+IMKgQ09O
RklHX1NZU19NRU1URVNUX1NUQVJUPTB4ODAwMDAwMDANCj4gPiDCoENPTkZJR19TWVNfTUVNVEVT
VF9FTkQ9MHg5MDAwMDAwMA0KPiA+IMKgQ09ORklHX1JFTUFLRV9FTEY9eQ0KPiA+ICsjIENPTkZJ
R19BTkRST0lEX0JPT1RfSU1BR0UgaXMgbm90IHNldA0KPiA+IMKgQ09ORklHX0RJU1RST19ERUZB
VUxUUz15DQo+ID4gwqBDT05GSUdfT0ZfU1lTVEVNX1NFVFVQPXkNCj4gPiDCoENPTkZJR19CT09U
Q09NTUFORD0ibW1jIGRldiAke21tY2Rldn07IGlmIG1tYyByZXNjYW47IHRoZW4gaWYgcnVuDQo+
ID4gbG9hZGltYWdlOyB0aGVuIHJ1biBtbWNib290OyBlbHNlIHJ1biBuZXRib290OyBmaTsgZmk7
Ig0KPiANCg==
