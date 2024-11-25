Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD6D3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D590B895A9;
	Mon, 25 Nov 2024 10:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="U0iiHfR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CB6899F1; Mon, 25 Nov 2024 10:26:44 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B7188E0F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDCAn4hifpiXyOxLQyJit2ywntclszmwfCFS5KSTafsVvdd+L4gGxcsJQlfjI5bysOaDotx9mLzEgUzXhK7fMObSXy1EZOxKRZK5DNAvW7FCyvKeiJKZls5XUI/izMw7W+NT3DjDLRqmLdD5/IzLigg9+G5AoNYgg+fA5Q7YDlDo14kAStRCaH2D26Du7CzeGgtblBUjASJ9h7JIfqUjreOmTF+Qep9COxpzdben6Xx49sSTL2kEuCtDHA+auFvQSp905OIgINmbRVdnCc9/WfH3dr3dt5lD886N+tYdiwFa3z53QZVprbz2NcQL4d6vcltFmP9VRf7QZNPLpL650g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hlK6FUNJ6pf/tQenqqRSa8d8XCapqEkIN3YSgUR+Do=;
 b=wZHnr6sKVmuRxGCfjPTyvWslTDqiRnGsZFslXBJaBTaFBPoy9fENPitc2jO8/jopuB6JqXefjtGayRbpPnZZLoCfSQjAl6+MpfTC2OOyZLsLXCGpeq4O/rWgEC8r3A8BSjBnxTljZBQXB+f3hJi2VKPxj4tl9q8qPuvgnoyawbNf0NkgMEuFSdQPVu1XLLLXlI4q61df8l6J00XsE7y8S2rGOK43CdMFTFPKCa/dv5dJ3YgHQbjl22atSKNWQmkpTAXa1RV7I58XkcTdEiPuHEIwLscQn+aZCsAqGFeR3YL+I4X5BfjNanwud4sCl8BsMU2GSfxAVhJHN/myxG3tvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hlK6FUNJ6pf/tQenqqRSa8d8XCapqEkIN3YSgUR+Do=;
 b=U0iiHfR+LZTWT1WiScCBpwX9+bm93nIS8tEyYuLSbT38YIYuXzxTtfvw1+hnbljP1ie6JyLdized9jF1OD9A9cGn42d2CUfvBkI0Xp7mLLkaIjQIKAPYax5fIUsMmXysj/DonbM4MKbvVbUjqoz/I8lSv8HOSwrUYy1FpZdC1eM=
Received: from DU2PR04CA0192.eurprd04.prod.outlook.com (2603:10a6:10:28d::17)
 by DBAP195MB0938.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:26:19 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::d9) by DU2PR04CA0192.outlook.office365.com
 (2603:10a6:10:28d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 09:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 09:26:19 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:26:18 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:26:18 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 25 Nov 2024 10:26:18 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yunus Bas <Y.Bas@phytec.de>
Subject: Re: [PATCH 3/3] board: phytec: phycore_imx8mm: Add RAUC boot logic to
 environment
Thread-Topic: [PATCH 3/3] board: phytec: phycore_imx8mm: Add RAUC boot logic
 to environment
Thread-Index: AQHbPOelhQ6Q9wJnAUemOLJReHoLxLLHrZYA
Date: Mon, 25 Nov 2024 09:26:18 +0000
Message-ID: <a91a2270cb8bbaf21683d8c0e4f3cef1edd6f7d1.camel@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
 <20241122102833.4061689-3-y.bas@phytec.de>
In-Reply-To: <20241122102833.4061689-3-y.bas@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FC1267B0D816146AD6994BD9EFFDD1B@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|DBAP195MB0938:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f8a358-d570-4e4c-f39d-08dd0d333828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0U0TSt2OUxaU1JNNmk0QktGY1FTVVNkcFBaMTl4ZTRZd3E3UkpJSjV1VEtj?=
 =?utf-8?B?VEdVSHZkUXBHcnB0RWNIRXU5aklOaXJkc25lZEpLSkVyTU5weG12T2o2b3R5?=
 =?utf-8?B?aVhjUzE5L0gwMUl6bklsM0llZVVNVW14ZWdOQ2YvbERnMzZmTmlkTHZPRSti?=
 =?utf-8?B?a0NGaGNCMmVNd0RMc1FXZjYxMmY3Nys2Nmt3V1RBazFhZEc5dFNiZDhzNVBo?=
 =?utf-8?B?eDI0SXFiall4Uzh2akFEUE9RZjJOdW45ZnV0c2VLTlI4b3RwTG9yMEtGT0Z0?=
 =?utf-8?B?N1pSbUJrb0dZdTYrNGI4Y2tKeGJndFB5ek5MVGJnTG0xalVmdThVL1RBclJ5?=
 =?utf-8?B?djE4TjlFSDlDYkRLQnM1S2diTTJmR0QveERPbXBDR2Q5bURMdmVhb3JjdXQr?=
 =?utf-8?B?ZnhyN29tTVc1MVJ3ZFlZVTBLSW5XY0EvU0ZsdGYwRUdONUVSQzJuN3hJMFNy?=
 =?utf-8?B?K2NHNWZEUjk0RGZhQ0FxY29yQTU5QTQzUXQ2OWRpMVhOOG14K1FPdkpGVjNP?=
 =?utf-8?B?Vy9LaC9BcnczbWZvZEJ3dC9TWGRNRFFpV1pJek02ZThpTWZvcUNTMTZHV0ZZ?=
 =?utf-8?B?anhaWEJ4U1YzM0RyeXZJc0VrUk5SV255WGhaWGFnSyt0RmJjR2FGb2VzSUdi?=
 =?utf-8?B?b05XdC9Fa1NQMjFiTm1lVXZOTE44cnFzZ2dxOHZ4SE1hWTJsVFRQeE9JWnJs?=
 =?utf-8?B?VlpVQTg3RlVHUnlnazZuWkxibTRWaVdsQXZGbmYvZ0hmSzNjRjBCaHpDZ3RN?=
 =?utf-8?B?SWwyT1J4MTFSeUZGbFBmS09YbzF0Qkg4cjk4L0dTc2svTDlMTjU5MmU4dVVT?=
 =?utf-8?B?aHB4NDhkbVk0NytTQ3RXN0pxYlR5bVkwYStHZ0d2SHhHMTNuMUJ3S0IwMkg5?=
 =?utf-8?B?UlNiMDhzTnNTdE1YZ1BFaFVTQnV1a0JDME5WT2lxcXUxUmxwT3U1WmxrSHIz?=
 =?utf-8?B?LzhQTDlwSEU4QnZ0cEJURkJaNnlhNTV0Q3R5dlhiU0JHNHo2cXVZY3NxNE9U?=
 =?utf-8?B?Y2RTS2IxcHdvK0ROeWFEWWxiWnhCTGFXTit6bUZDbXRXbUZJTW9BSERZUmpz?=
 =?utf-8?B?VW55Y3U2Nm12WE5jWE14TGNiRW1aVCtnN0t1ZHJONStsMmlzTm5kUi9FQ0VM?=
 =?utf-8?B?YSs5QldUalB4bHpqY3FRMUNBeURESnVxYVdoU1FDWU1WYTZBNXIrbjF0UlVO?=
 =?utf-8?B?VzhKMGNKS24vTkw1M2VvbTJJUEFkY2FLVEVsUVF6aDNkc1JzMWYrNHNLajlZ?=
 =?utf-8?B?bG96cWFjZ2h2ZG9qbzhuczl0NlJDRVYrUC9TSFVnSmM5dm4vUUQ0QkgzSDFF?=
 =?utf-8?B?ejJIVnVBaEM4dStUenRMOWtpRGZON1pKZmdLb0c4YjAwS0NycEkySlBMRUZV?=
 =?utf-8?B?K0VtOEJWQnBSQnZzZjdBWVNPVktPdERaU3hCbFBxSzRoQ2IvclpIK0d3QS9E?=
 =?utf-8?B?dFk2V3pmR2NoZU5sVDZJeG9mSWZOeVB1ait0T3h1UEo4VTkxVWs5QXBKZTgw?=
 =?utf-8?B?bVpTQ1MzdEJVeGZsWlR3SjF1ajBCVEltQ25pNUgzRklXbjhjeXcyMlphNERI?=
 =?utf-8?B?dW1BWkpYZkRndUVBS1p0YWpyaEtMdEhyUytjVTZmUTY1ZEhlaEtOalcwNzFJ?=
 =?utf-8?B?RkpUc09BNHFKTE5oWHNlc1J5T1BJOVNLOTRaOWNqNTl2TGY5czJtc2ZoZ2Vq?=
 =?utf-8?B?Wml4b0Y3aW8wb2llODZid1NnSERSQUt6eDhQZXdsYVVaMk50Lzh3TEw2NXNy?=
 =?utf-8?B?QjlJL3lTamxveThNUjQ4YUNTYW5DUmt3VUJHbjgrbnQ4SVJGYTVUWlhEUWM3?=
 =?utf-8?B?TTdHbjltUUN4UEdHZHVjUndCTEMvQnp6cGlpZHlvMXprblcrTnRLbGNYeG1E?=
 =?utf-8?B?bnZZdFFzUjZPRXo3S0xKTjRKSEZHSWxWVFJQQW8xNFV5WXZDV3NnTHRNL05Z?=
 =?utf-8?Q?K32rnj9UPJ+IjsO1hQdDgNG+72d/3Dwk?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:26:19.2554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f8a358-d570-4e4c-f39d-08dd0d333828
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0938
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

T24gRnJpLCAyMDI0LTExLTIyIGF0IDExOjI4ICswMTAwLCBZdW51cyBCYXMgd3JvdGU6DQo+IEFk
ZCBSQVVDIGJvb3QgbG9naWMgdG8gdGhlIGVudmlyb25tZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWXVudXMgQmFzIDx5LmJhc0BwaHl0ZWMuZGU+DQpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cg
PHkubW9vZ0BwaHl0ZWMuZGU+DQoNCj4gLS0tDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14
OG1tL3BoeWNvcmVfaW14OG1tLmVudiB8IDcgKysrKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZV9pbXg4bW0uZW52DQo+IGIvYm9hcmQvcGh5dGVj
L3BoeWNvcmVfaW14OG1tL3BoeWNvcmVfaW14OG1tLmVudg0KPiBpbmRleCAyMDU4YmY1OTIzNS4u
MTA3M2UxMzI3ZTYgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9w
aHljb3JlX2lteDhtbS5lbnYNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3Bo
eWNvcmVfaW14OG1tLmVudg0KPiBAQCAtMSw2ICsxLDExIEBADQo+ICsjaW5jbHVkZSA8ZW52L3Bo
eXRlYy9yYXVjLmVudj4NCj4gKw0KPiDCoGJvb3RjbWQ9DQo+IMKgCW1tYyBkZXYgJHttbWNkZXZ9
Ow0KPiDCoAlpZiBtbWMgcmVzY2FuOyB0aGVuDQo+ICsJCWlmIHRlc3QgJHtkb3JhdWNib290fSA9
IDE7IHRoZW4NCj4gKwkJCXJ1biByYXVjaW5pdDsNCj4gKwkJZmk7DQo+IMKgCQlpZiBydW4gbG9h
ZGltYWdlOyB0aGVuDQo+IMKgCQkJcnVuIG1tY2Jvb3Q7DQo+IMKgCQllbHNlDQo+IEBAIC0xNyw3
ICsyMiw3IEBAIGxvYWRpbWFnZT1mYXRsb2FkIG1tYyAke21tY2Rldn06JHttbWNwYXJ0fSAke2xv
YWRhZGRyfSAke2ltYWdlfQ0KPiDCoGxvYWRmZHQ9ZmF0bG9hZCBtbWMgJHttbWNkZXZ9OiR7bW1j
cGFydH0gJHtmZHRfYWRkcl9yfSAke2ZkdGZpbGV9DQo+IMKgbW1jYXJncz0NCj4gwqAJc2V0ZW52
IGJvb3RhcmdzIGNvbnNvbGU9JHtjb25zb2xlfQ0KPiAtCXJvb3Q9L2Rldi9tbWNibGske21tY2Rl
dn1wJHttbWNyb290fSByb290d2FpdCBydw0KPiArCXJvb3Q9L2Rldi9tbWNibGske21tY2Rldn1w
JHttbWNyb290fSAke3JhdWNhcmdzfSByb290d2FpdCBydw0KPiDCoG1tY2F1dG9kZXRlY3Q9eWVz
DQo+IMKgbW1jYm9vdD0NCj4gwqAJZWNobyBCb290aW5nIGZyb20gbW1jIC4uLjsNCg0K
