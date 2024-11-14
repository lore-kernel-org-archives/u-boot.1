Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBA5D65C7C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7BB88DDA;
	Thu, 14 Nov 2024 12:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="VH1QsC46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37694895ED; Thu, 14 Nov 2024 12:49:02 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B462788DD9
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8Zn1SJnZGuz4wHJnB4ugYLq6iShpXz++vROJUoMI5sDhSOuISZ1Pi+Rb0SK69+D23wrp+bFck7QP5yncy8emMXbZAr9Iif0p6Pry8kc4yiEXgNIzsghOkj+qwsGaYgmt+wuqmFvV9VF8tX+DavMpgpVys3c74CjZ3OoiSp5drgxGEEftRc+aRRDiOOHc3KVchP7ILU0yCub+cgzCYqlg1a6XyVLjWmZHp+FTyrbUHTJUnB8uKAjleB/Qpg+i62KV1OqtqqzNFMwYbkUWFckkXtJHKjpST5RebZDP1N9zUohlMStLy8fkg5Fj+ETX95bEimPNUJ4FgBDgocdA43yQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPvcm3XCMKeEDt/0MT5KePQxEncjth2gASRvpKIoC/Q=;
 b=ln9N7dEfD6rhEAbKYOF87qao4xhtx0Y6FXAG07PkdBwbHuCQZyxhtozVV/BmXBiqS4qtFkTblaxsIu4vVj6v42jwLrnaJTfEZASSq7vP9VkytgLoG79eH4ekMd06pFgnnBRmgwA65cWDo++2oGPbayIqaCx9Sx5Ma0u6h6S6y5Hj04PhgoTN9+0J1GtJ1icCofyFns5DHKst/Inz+efO1JBXDearyPhXrkptZlY3zDwIZyNBIltlwNt6Ns5IYwiRJA2rWR30jFNc+VmeoIp3bNXLF1BVC+Sf7ncWKgd/lpW0DGB9NsZxvKCo1a5WG+MT68h2Y9a2iqDPeLn6WBjyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPvcm3XCMKeEDt/0MT5KePQxEncjth2gASRvpKIoC/Q=;
 b=VH1QsC46CsEMamyoPaBkq8UTpT2zVzbG4f8lHhmUTQ3FNKkP2NFkxTgmLEPppa3zSS7t/l+FPl3ImwZ4kDrnay24trjVX/P5uLMd76tBR/ldzgme+Cbmh4iRUhSYe7aF72ds3Ua0ocazlYO2Y6kJgg8lZc0HJFfUDFpVaanJBVk=
Received: from DU7P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::7) by
 DU2P195MB2375.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:497::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Thu, 14 Nov 2024 11:48:54 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::5f) by DU7P195CA0023.outlook.office365.com
 (2603:10a6:10:54d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 11:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:48:52 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 12:48:51 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 12:48:51 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Thu, 14 Nov 2024 12:48:51 +0100
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
Thread-Index: AQHbNeU53U95sTpb5UKeBgkqmviyVrK2QsEAgABXCAA=
Date: Thu, 14 Nov 2024 11:48:51 +0000
Message-ID: <2b1aec9b611a3106a4c59b53db2e84a697791f8d.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
 <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
In-Reply-To: <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <807CCD3C4702C94C974468A289716972@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|DU2P195MB2375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf71d4d-6ff3-4dc9-df09-08dd04a24f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdsNVp1ejl4WERMS2pYdFU0MDc0MlRwOGc5bXhDSzI4K2p5QXFOblY5VEJq?=
 =?utf-8?B?aFBiREp1MFdUU2t2SDJlZXd5RnFQZUZONjg0U0xRcEF2c1hkWmRmMG45SVl3?=
 =?utf-8?B?ZWR6MnJGYkNpKy8vMXFpd2o2WDRWWGdEbnNVVndJamR0VnJqcTk1b2VMZm13?=
 =?utf-8?B?ZXAzbjRHQlg4NlZoakx1OHNUTUpaYW5vWGRGU3hSdTNMeGpUTlUwRXM4RWNN?=
 =?utf-8?B?RytoZWFyblJ1QmJ3TjROeU41VlplYldaVUxIYk1ORk1jMXFUQUgrTkVoaXRl?=
 =?utf-8?B?WlNjYXRWbXh2MVV6dGZQa0JaSW9yWUcrSnVFNlV2bzFjNjkzTTRGbW1Oanox?=
 =?utf-8?B?M2lpUTdMdWlHMkY1VTdyVkQ3dHdYT1hYVWYyeWc3bzA1cVNleDk0Zlgzdmc5?=
 =?utf-8?B?UzJmRnRaeWo4M3Z1aHdrcGlITmg4VTlGaUVaMmNKcHlCTmFWdG5FRnl0c3By?=
 =?utf-8?B?R2tzZTRUNC95eSs1aUUvY283WlhtTzF4NEsrSjRkQ1lHZEVmTkx3UU5PNVNN?=
 =?utf-8?B?UGhIMXhURHQ3S3BEaTlNckFTNlo4RXlVb3VVbjhYSW9ieXZrdGtVOHgvcVNG?=
 =?utf-8?B?M0xHWmNVQXZ6a2lLNHlQWkdTd0VadEQySTJqK1V6aG5rOWc4NTRHeUU1eDBp?=
 =?utf-8?B?ZVlwYVgzTmtOVi9RWmtGSmJhVjh4UE1jY3lIa3g4YVJheWpScTFtSzR2bFFs?=
 =?utf-8?B?Z2g0Y0twcndOMnlhM0FLNUJyV0wvdUo2L0luWTlHL3Q5dHF3NlgwMUROYWx3?=
 =?utf-8?B?b0p6MCt0bnJQSDRZL2R3U3NQejJQNnMvZVJ4VWpJTU5HdmE5S1drSkMxK0Uv?=
 =?utf-8?B?ZjYvN0k0VWZXbVJMaVY3S1JuSk91SlpFcTVFWHBJYUdQYXp2bXpjZ1JMeExK?=
 =?utf-8?B?T1VaajcrZmx1MjN6TWxGcmdsQTRpTG5uTzRyeGhGVW1jMTNIRElkYmZtV3cv?=
 =?utf-8?B?T1I4amp4dUI0bDlnK2pjKzBDcE5Jb29EVk1MeitKNSt5TXlnaXFtWC8vaTVJ?=
 =?utf-8?B?VDg1dXdReXoyTlNqeFNpYXcvWEkwQjBvcFY5TldHRmV4QlEyeFlQdGYvdmdl?=
 =?utf-8?B?aDBxWEx5TnZCUW9XSzJEdUcrZlFKdXd0Q3ovWEdrVjFVNVdUMDdTVVFDNE9J?=
 =?utf-8?B?ejU1aWJrZ0xlWEd1eVpRdWJQeDlOWkY3bWE2VHV2K2QwdmpFYXo4OFN6UnhP?=
 =?utf-8?B?TVB2OUtOOGNnblJkZFhsbDJDVUpJTHBaZWRiVXQvTHpjay9IYjdsL054Z1hP?=
 =?utf-8?B?T3ZFUnkwUVdsOE0rRTdUR1ZhTCtuTHNWeGVCQ3d1Y29HbHNHZXhURVJlUVM5?=
 =?utf-8?B?c3AxQmJGTnVFcmw0bGFlcDhRUVViTWsvRzBIWUFUNlFDYmdpQXA0dytlWlJi?=
 =?utf-8?B?b0FqYzFHWlpHd0JaeVgxQkVyWk5IZTYzdjNvMU9pQXRVWEJvejZZQzY5Wkxi?=
 =?utf-8?B?cVd5ZTd1VVlNNGFYWEx5TVFCWE5sWGpaVTkyTFdreURjSDY2VTBha3JNUVBL?=
 =?utf-8?B?WUh6cUJkOHg1Y1NhRUpveVFyVm8xeUtSb1Z2eWVHazhYclAydFJGTG15RDc5?=
 =?utf-8?B?YjB6N3FRTWdWSlJYZ1JzSmNEKzlOcXJRaEV5Y0F6NGoyTUhZSU45cUs5bVg1?=
 =?utf-8?B?YURWR21vbGZlaitYYlVBNFFNMWlTMkRLa0NWbDhLa0dpbWR1MFBFZHRJTUZQ?=
 =?utf-8?B?dXA1aWdTZ0gvK2NKVVloRWhJbENRQlBqTWt6cUJJSFMxUnVWd0VFenljNDhD?=
 =?utf-8?B?aUNoL2RSOHJkQyt3dktWdDZOMkNrbWZuTzJaZEFlbllOczhtK0FMZnZVKzBN?=
 =?utf-8?Q?WAJv5UfpgwL7TiKgJSQIyDLCeUG52YWSyWxmA=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:48:52.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf71d4d-6ff3-4dc9-df09-08dd04a24f81
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2375
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

DQoNCk9uIERvLCAyMDI0LTExLTE0IGF0IDA3OjM3ICswMTAwLCBZYW5uaWMgTW9vZyB3cm90ZToN
Cj4gT24gV2VkLCAyMDI0LTExLTEzIGF0IDE3OjAwICswMTAwLCBDaHJpc3RvcGggU3RvaWRuZXIg
d3JvdGU6DQo+ID4gVGhlIHBoeUNPUkUtaS5NWCA5MyBpcyBhdmFpbGFibGUgaW4gdmFyaW91cyB2
YXJpYW50cyAoZS5nLg0KPiA+IGRpZmZlcmVudCByYW0NCj4gPiBzaXplcywgZU1NQyBIUzQwMCB5
ZXMvbm8pLiBFbmFibGUgaGFyZHdhcmUgaW50cm9zcGVjdGlvbiBmb3IgdGhlDQo+ID4gaW14OTMt
cGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnLCBzbyB0aGF0IGR1cmluZyBzdGFydHVwIHRoZSBTT00N
Cj4gPiBtb2R1bGUNCj4gPiB2YXJpYW50IGNhbiBiZSBkZXRlY3RlZCwgYW5kIHRoZSBoYXJkd2Fy
ZSBjYW4gYmUgY29uZmlndXJlZA0KPiA+IGFjY29yZGluZ2x5Lg0KPiA+IFRoZSByZXN1bHRpbmcg
U1BMIGFuZCB1LWJvb3QgYmluYXJ5IHNoYWxsIGFibGUgdG8gYm9vdCBlYWNoDQo+ID4gcGh5Q09S
RS1pLk1YIDkzIG1vZHVsZSB2YXJpYW50IG9uIGVhY2ggY2FycmllciBib2FyZC4gRmluYWxseQ0K
PiA+IHJlbmFtZQ0KPiA+IGlteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZyB0byBpbXg5My1w
aHljb3JlX2RlZmNvbmZpZywgdG8NCj4gPiBoaWdobGlnaHQNCj4gPiBpdHMgU09NIHNjb3BlLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBTdG9pZG5lciA8Yy5zdG9pZG5lckBw
aHl0ZWMuZGU+DQo+ID4gLS0tDQo+ID4gQ2M6IE1hdGhpZXUgT3RoYWNlaGUgPG0ub3RoYWNlaGVA
Z21haWwuY29tPg0KPiA+IENjOiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVj
LmRlPg0KPiA+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT4NCj4gPiBDYzogRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiA+IENjOiAiTlhQIGkuTVggVS1Cb290
IFRlYW0iIDx1Ym9vdC1pbXhAbnhwLmNvbT4NCj4gPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT4NCj4gPiBDYzogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQo+ID4gQ2M6
IFByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT4NCj4gPiBDYzogQW5kcmVqIFBp
Y2VqIDxhbmRyZWoucGljZWpAbm9yaWsuY29tPg0KPiA+IENjOiBXYWRpbSBFZ29yb3YgPHcuZWdv
cm92QHBoeXRlYy5kZT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0ganVzdCBy
ZW5hbWUgaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnIGFuZCBhZGQgbmVlZGVkDQo+ID4g
Q09ORklHcywNCj4gPiDCoCBpbnN0ZWFkIG9mIGNyZWF0aW5nIGFuIGVudGlyZWx5IG5ldyBzZWNv
bmQgZGVmY29uZmlnDQo+ID4gLSByZW1vdmUgd3JvbmcgY29tbWVudCBmcm9tIGlteDkzLXBoeWJv
YXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gLSBpbXByb3ZlIGNvbW1pdCBtZXNzYWdlDQo+ID4g
DQo+ID4gwqBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2nCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNg0KPiA+ICsrKystLQ0KPiA+IMKgYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyICstDQo+ID4gwqAuLi54OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29u
ZmlnID0+IGlteDkzLXBoeWNvcmVfZGVmY29uZmlnfSB8IDQNCj4gPiArKystDQo+ID4gwqAzIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiDCoHJlbmFt
ZSBjb25maWdzL3tpbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcgPT4gaW14OTMtDQo+ID4g
cGh5Y29yZV9kZWZjb25maWd9ICg5OCUpDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiA+IGIvYXJjaC9hcm0vZHRz
L2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtDQo+ID4gYm9vdC5kdHNpDQo+ID4gaW5kZXggMjVjNzc4
YmIwNy4uMjI0NTQ2MTAzMiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9kdHMvaW14OTMtcGh5
Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5
Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gPiBAQCAtMiwxNSArMiwxNyBAQA0KPiA+IMKgLyoN
Cj4gPiDCoCAqIENvcHlyaWdodCAoQykgMjAyMyBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KPiA+
IMKgICogQ2hyaXN0b3BoIFN0b2lkbmVyIDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4NCj4gPiArICog
Q29weXJpZ2h0IChDKSAyMDI0IFBIWVRFQyBNZXNzdGVjaG5payBHbWJIDQo+ID4gwqAgKg0KPiA+
IMKgICogUHJvZHVjdCBob21lcGFnZToNCj4gPiAtICogcGh5Qk9BUkQtU2VnaW4gY2FycmllciBi
b2FyZCBpcyByZXVzZWQgZm9yIHRoZSBpLk1YOTMgZGVzaWduLg0KPiA+IC0gKiBodHRwczovL3d3
dy5waHl0ZWMuZXUvZW4vcHJvZHVrdGUvc2luZ2xlLWJvYXJkLQ0KPiA+IGNvbXB1dGVyL3BoeWJv
YXJkLXNlZ2luLWlteDZ1bC8NCj4gPiArwqDCoCBodHRwczovL3d3dy5waHl0ZWMuZGUvcHJvZHVr
dGUvc3lzdGVtLW9uLW1vZHVsZXMvcGh5Y29yZS1pbXgtDQo+ID4gOTEtOTMvDQo+ID4gwqAgKi8N
Cj4gPiDCoA0KPiA+IMKgI2luY2x1ZGUgImlteDkzLXUtYm9vdC5kdHNpIg0KPiA+IMKgDQo+ID4g
wqAvIHsNCj4gPiArwqDCoMKgwqDCoMKgwqBtb2RlbCA9ICJQSFlURUMgcGh5Q09SRS1pLk1YOTMi
Ow0KPiA+ICsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgd2R0LXJlYm9vdCB7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIndkdC1yZWJvb3QiOw0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2R0ID0gPCZ3ZG9nMz47DQo+ID4gZGlmZiAt
LWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJTDQo+ID4gYi9ib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IGNlYTgxN2ZmZGMu
LjcxOGY4OWEwODQgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMv
TUFJTlRBSU5FUlMNCj4gPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJ
TkVSUw0KPiA+IEBAIC05LDUgKzksNSBAQCBGOsKgwqDCoMKgwqAgYXJjaC9hcm0vZHRzL2lteDkz
LXBoeWJvYXJkLXNlZ2luLXUtDQo+ID4gYm9vdC5kdHNpDQo+ID4gwqBGOsKgwqDCoMKgwqAgYm9h
cmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvDQo+ID4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5dGVj
L2NvbW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmMNCj4gPiDCoEY6wqDCoMKgwqDCoCBib2FyZC9w
aHl0ZWMvY29tbW9uL2lteDkzX3NvbV9kZXRlY3Rpb24uaA0KPiA+IC1GOsKgwqDCoMKgwqAgY29u
Zmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gPiArRjrCoMKgwqDCoMKgIGNv
bmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gDQo+IEhvdyB3aWxsIHlvdSBoYW5kbGUg
dGhpcyB3aGVuL2lmIHlvdSBoYXZlIGFub3RoZXIgYm9hcmQ/DQoNClRoYXQgaW14OTMtcGh5Y29y
ZV9kZWZjb25maWcgaGFzIG5vIG1vcmUgZGVwZW5kZW5jeSB0byB0aGUgY2Fycmllcg0KYm9hcmQu
IFRoYXRzIHdoeSBJIHJlbmFtZWQgaXQuIFRoZSBpbnRlbnRpb24gZm9yIHRoZSBkZWZjb25maWcg
aXPCoHRoYXQNCnRoZSByZXN1bHRpbmcgU1BMIGFuZCB1LWJvb3QgYmluYXJ5IGNhbiB0byBib290
IGVhY2ggcGh5Q09SRS1pLk1YIDkzDQptb2R1bGUgdmFyaWFudCBvbiBlYWNoIGNhcnJpZXIgYm9h
cmQuDQoNClRoYXRzIHdoeSB0aGUgY2FycmllciBib2FyZCBpcyBubyBtb3JlIHJlbGV2YW50IGhl
cmUuDQoNCj4gDQo+IEFsc28sIHBsZWFzZSB1cGRhdGUgZG9jdW1lbnRhdGlvbiENCj4gDQo+IFlh
bm5pYw0KPiANCj4gPiDCoEY6wqDCoMKgwqDCoCBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg5
My5oDQo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29u
ZmlnDQo+ID4gYi9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ID4gc2ltaWxhcml0
eSBpbmRleCA5OCUNCj4gPiByZW5hbWUgZnJvbSBjb25maWdzL2lteDkzLXBoeWJvYXJkLXNlZ2lu
X2RlZmNvbmZpZw0KPiA+IHJlbmFtZSB0byBjb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmln
DQo+ID4gaW5kZXggMThhNDA4N2U0Yi4uY2Y5ODAwMTE4YSAxMDA2NDQNCj4gPiAtLS0gYS9jb25m
aWdzL2lteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZw0KPiA+ICsrKyBiL2NvbmZpZ3MvaW14
OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gPiBAQCAtNiwxMyArNiwxMyBAQCBDT05GSUdfU1lTX01B
TExPQ19GX0xFTj0weDIwMDAwDQo+ID4gwqBDT05GSUdfU1BMX0xJQkNPTU1PTl9TVVBQT1JUPXkN
Cj4gPiDCoENPTkZJR19TUExfTElCR0VORVJJQ19TVVBQT1JUPXkNCj4gPiDCoENPTkZJR19OUl9E
UkFNX0JBTktTPTINCj4gPiArQ09ORklHX1BIWVRFQ19TT01fREVURUNUSU9OPXkNCj4gPiDCoENP
TkZJR19FTlZfU09VUkNFX0ZJTEU9InBoeWNvcmVfaW14OTMiDQo+ID4gwqBDT05GSUdfRU5WX1NJ
WkU9MHgxMDAwMA0KPiA+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHg3MDAwMDANCj4gPiDCoENPTkZJ
R19JTVhfQ09ORklHPSJhcmNoL2FybS9tYWNoLWlteC9pbXg5L2lteGltYWdlLmNmZyINCj4gPiDC
oENPTkZJR19ETV9HUElPPXkNCj4gPiDCoENPTkZJR19ERUZBVUxUX0RFVklDRV9UUkVFPSJpbXg5
My1waHlib2FyZC1zZWdpbiINCj4gPiAtQ09ORklHX1NQTF9URVhUX0JBU0U9MHgyMDQ5QTAwMA0K
PiA+IMKgQ09ORklHX0FIQUJfQk9PVD15DQo+ID4gwqBDT05GSUdfVEFSR0VUX1BIWUNPUkVfSU1Y
OTM9eQ0KPiA+IMKgQ09ORklHX09GX0xJQkZEVF9PVkVSTEFZPXkNCj4gPiBAQCAtMjAsNiArMjAs
NyBAQCBDT05GSUdfU1lTX01PTklUT1JfTEVOPTUyNDI4OA0KPiA+IMKgQ09ORklHX1NQTF9TRVJJ
QUw9eQ0KPiA+IMKgQ09ORklHX1NQTF9EUklWRVJTX01JU0M9eQ0KPiA+IMKgQ09ORklHX1NQTF9T
VEFDSz0weDIwNTE5ZGQwDQo+ID4gK0NPTkZJR19TUExfVEVYVF9CQVNFPTB4MjA0OUEwMDANCj4g
PiDCoENPTkZJR19TUExfSEFTX0JTU19MSU5LRVJfU0VDVElPTj15DQo+ID4gwqBDT05GSUdfU1BM
X0JTU19TVEFSVF9BRERSPTB4MjA1MWEwMDANCj4gPiDCoENPTkZJR19TUExfQlNTX01BWF9TSVpF
PTB4MjAwMA0KPiA+IEBAIC0zMSw2ICszMiw3IEBAIENPTkZJR19TUExfSU1YX1JPTUFQSV9MT0FE
QUREUj0weDg4MDAwMDAwDQo+ID4gwqBDT05GSUdfU1lTX01FTVRFU1RfU1RBUlQ9MHg4MDAwMDAw
MA0KPiA+IMKgQ09ORklHX1NZU19NRU1URVNUX0VORD0weDkwMDAwMDAwDQo+ID4gwqBDT05GSUdf
UkVNQUtFX0VMRj15DQo+ID4gKyMgQ09ORklHX0FORFJPSURfQk9PVF9JTUFHRSBpcyBub3Qgc2V0
DQo+ID4gwqBDT05GSUdfRElTVFJPX0RFRkFVTFRTPXkNCj4gPiDCoENPTkZJR19PRl9TWVNURU1f
U0VUVVA9eQ0KPiA+IMKgQ09ORklHX0JPT1RDT01NQU5EPSJtbWMgZGV2ICR7bW1jZGV2fTsgaWYg
bW1jIHJlc2NhbjsgdGhlbiBpZiBydW4NCj4gPiBsb2FkaW1hZ2U7IHRoZW4gcnVuIG1tY2Jvb3Q7
DQo+ID4gZWxzZSBydW4gbmV0Ym9vdDsgZmk7IGZpOyINCj4gDQo=
