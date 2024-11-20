Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A95D6E2CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 08:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19334891E8;
	Wed, 20 Nov 2024 09:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="FGLb0H8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0A289672; Wed, 20 Nov 2024 09:15:11 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9E688C0F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8V+zZs7evrE5wyPmhypupyX24ClnY/G2Llz4XN6ewnGqbU4hFOh5B9XeRTkUcxYN60k1kdNYfBXRtbuSpsBk3f+pyw/RFmf453JCVBWZj+AXGpK8B5fbwN/n5jVHBSbPQ7Qw+BJdLzzZGMzTyn/wsHMPcAFypXaE+Aregs0izX+Xqlxlp6poGVavjdxHJyoe1WOtUf3Rvh6z6yYHWsvQgu1vKowHg8mYGOmj8J8HzzjwjjY6/UGCXCfCLV63mLffkkomS8DCQAZOrxr4Mbsnup+1rTFnKlv5Os8ShV0JoVnJy1cdky7IU5XvS6JzHkMrn3cJHADK916tT6tzcglpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhMs2Ny65jHnj7ZcnjkMco79TlqIzJu04bnSvYj1ZVo=;
 b=mt53nJRte1DvGg3PtsxPAm3BKLIL5959fXRxIxCKlcZUHsqNN7chEtOaG3Vf1c7XG7cEP+yHB7tKfEfIXyvYIOn+Eywi9gi+PIYHbQtVtrb9SHAgOaAIG8MvYLG+2QogVLQoCEooL93eavRJbps7HsDt+8nmg2yWsbX6vLV/NYItuuQzxI9PbOMhtG1owpalDmEdVF0dUGVVOtcDUraQVPlEawUbZxYqFs/NvWqSz0Ts395CQ3AhkVo0LXp+AWswJXU6EP6xNSuTZrp39RG1Yzuc4X4wZ8QaYJN4kVTMwPFOPqQyNQFBuiXST7oh5z+n1c1VPKZK/Eny+QDCKiHFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhMs2Ny65jHnj7ZcnjkMco79TlqIzJu04bnSvYj1ZVo=;
 b=FGLb0H8UYJbKI8gpZzH5tJrcQ41Gvz5I+zf/dj+O80pLYWafkJlLdJKckMYzMQfc46MXZK4KZqyTwIwnjd5xfmk0jaDN/Tk/LaPgzad4+EsaRqPAUZ5Zr/DbW2aigyaYJ/pQ1Hrfyj+bgxKad3n+RCD9cmfgFhR07saiVO2cpdM=
Received: from AM8P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::22)
 by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 08:15:05 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::63) by AM8P190CA0017.outlook.office365.com
 (2603:10a6:20b:219::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 08:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 08:15:04 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 09:15:04 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 20 Nov 2024 09:15:04 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, Christoph Stoidner
 <C.Stoidner@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Wadim Egorov <W.Egorov@phytec.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Andrej Picej
 <andrej.picej@norik.com>, "sbabic@denx.de" <sbabic@denx.de>, Primoz Fiser
 <primoz.fiser@norik.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [PATCH v3 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Topic: [PATCH v3 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Index: AQHbOqAyBM9an3UPCEqY5RyGEOjSkbK/wpWA
Date: Wed, 20 Nov 2024 08:15:04 +0000
Message-ID: <8939197a296dcd93c8e95ea2d2e0f1002e02d229.camel@phytec.de>
References: <20241119162907.17934-1-c.stoidner@phytec.de>
 <20241119162907.17934-4-c.stoidner@phytec.de>
In-Reply-To: <20241119162907.17934-4-c.stoidner@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F6A8554728A3248BDD52115411F8D25@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|VI2P195MB2491:EE_
X-MS-Office365-Filtering-Correlation-Id: e3796c9b-b904-4af1-1e00-08dd093b7044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M083ZUVYV1ZJYXBVQU0yM2ZJWVZvem5vdlVseHN3ZyttTnArT1Y4WldMTC9J?=
 =?utf-8?B?WU1KSkFjOEp0RzBkSGJadzV2eDV4UzFlRDlRSzA5dEhIOTMwV0FMaVFSVFlk?=
 =?utf-8?B?UFVtd2NwNWszQ0loMmJVZVNrMFo3cDdyK2E3OHFzL3NZZ3psY2daUytxZDQr?=
 =?utf-8?B?S1JGZHhIeWt3anQ5VmMySTJ4T0txaFJxZVk1UTkxV0VRZzFac21taGY3R1p4?=
 =?utf-8?B?MWxKSzRHYkllbXlxOXR2YU0vVXNycjUyQW9RbDM2VWpBdDVvVmViR1VCM1RR?=
 =?utf-8?B?Z0NNT3BIRlV3WnUyT3VKRmJQVDhwQXhiUzVmcno5V3pTMy9ERStaOHQvNWtk?=
 =?utf-8?B?cksxSVllb1ljTTNYQU5keTFXOGxhTlZVMWs3QUx2c29wQmdIQlRRVUx6eW12?=
 =?utf-8?B?NFRNWUFST2Y0ZnZlUXBvM1pQSDdySTBkUlVMZWthb1JSY1l4a3Q2UDhCd0pj?=
 =?utf-8?B?ZXBoQVltdEtjZy90c1F2R2dxMEJ6MlcrMUt6aVVGWEFDTTJjWjF0Z0t1QkQz?=
 =?utf-8?B?bFA5My9WbGloQ3RVcXR6c0ErTHNxNC9EcDJjb0VGakpZZElpdHlqRUpHL2pq?=
 =?utf-8?B?MEUyT1RVenhzVTg4QmVQcXR5dU5rL3pBeU53VnRtenFNQTBXcm51WVBoV2hz?=
 =?utf-8?B?ZmtTczdrL2oxYkhLaDArQnRtMkRnVHhmUWZKZVRYL2xPVC9xN1VGZXByUE83?=
 =?utf-8?B?THFmeEt1cXhCVUpsVUg1ZDlGOEh3MGg0UFVOVEdaYXpoelBSNkgrd2U3emRU?=
 =?utf-8?B?SnlMeW5jbm5TZVZnbU81NUV2dzJKZjNWWXU3T1gyeDJaU0w5dDFDR0M0cVRH?=
 =?utf-8?B?b1JVTnh4K3VaQ21VdHN5V2lUVHhuVUcwSHlXUmlmaDg5TlhGTWszMUpGN1ZS?=
 =?utf-8?B?YTlzQ24vSjFvbG9GNjFFVVNHemxQNmRJR2hHUlUwVDFtaXRRT3g5cmVUVjhz?=
 =?utf-8?B?ZHlSQWE1emQ4M2pLYWphM0VrM0RiaGhCdXpvcHRlUldNSVFpamJOSHJ0d0ZQ?=
 =?utf-8?B?SW1jaEQ4eTlVUXliYVlyczJmaHRDbmtYMlBuR2tZRmV4eFRlVE1ZcUt5TkVP?=
 =?utf-8?B?ajJZVVJKM2FKcG9Mc21JakF5UFRNRGx1NzRvTmtyZHlaM291a1hpUzUzMGN6?=
 =?utf-8?B?dlVVL21EaVpEUmRQcC9ZMXZkRkhyemhxdlA0WVlja2grNklrb0FqWW1CcW1v?=
 =?utf-8?B?bWFxelhCUkp2NVFhcHFWbStTd3ljeStka3I5ck9uSEFNNkpQUTRuMEdKWTZw?=
 =?utf-8?B?RjNmSjZxVmZWSnhHU0lEbTRybTBTd2ZsTU1HZU5IOWtpR1M2ZWE5SnF6MUQy?=
 =?utf-8?B?Y09OREt0WkFXMkhtZUFmUHZjbTN0d3NwTXRHL3pURGF0RllITDN2SCswRTd5?=
 =?utf-8?B?dk9TdmYvVXVUODJFWDNuSEdNbllDZXdXY3BtWE9sVlVqTTlJdHBkWlpOY1VF?=
 =?utf-8?B?SmkwdVMzMU0zdC8xK25aRzRnTTlSYnRnb041NHo5RnFlNitubWM0MldMYVdQ?=
 =?utf-8?B?cGVBMEZBaHlZYm5HQW0zTWpLOGI2S1g5NEorZHR1WkZyUDNpOXl3eTI5OVgv?=
 =?utf-8?B?MkhKWjl0bHBCVFJGNzFVZUhjTFBETzdGSGpVK0w3UEF6ZEdEY3hFcVlOQVVT?=
 =?utf-8?B?L3Frc1NTcWhIVlNZanlMbXA1RlNUWXlEOGxYalRmaUJzUk1lS0ZHbnd2eDVk?=
 =?utf-8?B?L25DRXpzd1JaRHo2YkpITkJsWnE0QWpyZ3R2N1VyaFNwZ00vc3kyakZkdmY3?=
 =?utf-8?B?V3RTdW9wWHJkbFZxTEJYTjllMFhHUDNRRzRMM1B1U2lwd3habXJvRkdMNGx1?=
 =?utf-8?Q?roWsEX2bWMP/sFknVhJDCTBiAxsWBtC5EVOGk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 08:15:04.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3796c9b-b904-4af1-1e00-08dd093b7044
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB2491
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

T24gVHVlLCAyMDI0LTExLTE5IGF0IDE3OjI5ICswMTAwLCBDaHJpc3RvcGggU3RvaWRuZXIgd3Jv
dGU6DQo+IFRoZSBwaHlDT1JFLWkuTVggOTMgaXMgYXZhaWxhYmxlIGluIHZhcmlvdXMgdmFyaWFu
dHMgKGUuZy4gZGlmZmVyZW50IHJhbQ0KPiBzaXplcywgZU1NQyBIUzQwMCB5ZXMvbm8pLiBFbmFi
bGUgaGFyZHdhcmUgaW50cm9zcGVjdGlvbiBmb3IgdGhlDQo+IGlteDkzLXBoeWJvYXJkLXNlZ2lu
X2RlZmNvbmZpZywgc28gdGhhdCBkdXJpbmcgc3RhcnR1cCB0aGUgU09NIG1vZHVsZQ0KPiB2YXJp
YW50IGNhbiBiZSBkZXRlY3RlZCwgYW5kIHRoZSBoYXJkd2FyZSBjYW4gYmUgY29uZmlndXJlZCBh
Y2NvcmRpbmdseS4NCj4gVGhlIHJlc3VsdGluZyBTUEwgYW5kIHUtYm9vdCBiaW5hcnkgc2hhbGwg
YWJsZSB0byBib290IGVhY2gNCj4gcGh5Q09SRS1pLk1YIDkzIG1vZHVsZSB2YXJpYW50IG9uIGVh
Y2ggY2FycmllciBib2FyZC4gRmluYWxseSByZW5hbWUNCj4gaW14OTMtcGh5Ym9hcmQtc2VnaW5f
ZGVmY29uZmlnIHRvIGlteDkzLXBoeWNvcmVfZGVmY29uZmlnLCB0byBoaWdobGlnaHQNCj4gaXRz
IFNPTSBzY29wZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBTdG9pZG5lciA8Yy5z
dG9pZG5lckBwaHl0ZWMuZGU+DQo+IFJldmlld2VkLWJ5OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92
QHBoeXRlYy5kZT4NCg0KUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRl
Pg0KDQo+IC0tLQ0KPiBDYzogTWF0aGlldSBPdGhhY2VoZSA8bS5vdGhhY2VoZUBnbWFpbC5jb20+
DQo+IENjOiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiBDYzog
U3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IENjOiAiTlhQIGkuTVggVS1Cb290IFRlYW0iIDx1Ym9vdC1pbXhA
bnhwLmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiBZYW5u
aWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCj4gQ2M6IFByaW1veiBGaXNlciA8cHJpbW96LmZp
c2VyQG5vcmlrLmNvbT4NCj4gQ2M6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2VqQG5vcmlrLmNv
bT4NCj4gQ2M6IFdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRlPg0KPiAtLS0NCj4gQ2hh
bmdlcyBpbiB2MzoNCj4gLSBhZGQgY29tbWVudCBhYm91dCBTb00tc2NvcGUgdG8gaW14OTMtcGh5
Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gLSByZWJhc2UgdG8gdGhlIGxhdGVzdCBtYXN0ZXIN
Cj4gLSBhZGFwdCBkb2MgYWNjb3JkaW5nIHRvIG5ldyBkZWZjb25maWcNCj4gDQo+IENoYW5nZXMg
aW4gdjI6DQo+IC0ganVzdCByZW5hbWUgaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnIGFu
ZCBhZGQgbmVlZGVkIENPTkZJR3MsDQo+IMKgIGluc3RlYWQgb2YgY3JlYXRpbmcgYW4gZW50aXJl
bHkgbmV3IHNlY29uZCBkZWZjb25maWcNCj4gLSByZW1vdmUgd3JvbmcgY29tbWVudCBmcm9tIGlt
eDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+IC0gaW1wcm92ZSBjb21taXQgbWVzc2Fn
ZQ0KPiANCj4gwqBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2nC
oMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKysrLS0NCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg5My9NQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPiDCoC4uLnlib2FyZC1zZWdpbl9kZWZjb25maWcgPT4gaW14OTMtcGh5Y29yZV9kZWZjb25m
aWd9IHzCoCAyICsrDQo+IMKgLi4uL3tpbXg5My1waHlib2FyZC1zZWdpbi5yc3QgPT4gaW14OTMt
cGh5Y29yZS5yc3R9wqDCoCB8wqAgOCArKysrLS0tLQ0KPiDCoGRvYy9ib2FyZC9waHl0ZWMvaW5k
ZXgucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAyICstDQo+IMKgNSBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiDCoHJlbmFtZSBjb25maWdzL3tpbXg5My1waHlib2FyZC1zZWdpbl9kZWZj
b25maWcgPT4gaW14OTMtcGh5Y29yZV9kZWZjb25maWd9ICg5OCUpDQo+IMKgcmVuYW1lIGRvYy9i
b2FyZC9waHl0ZWMve2lteDkzLXBoeWJvYXJkLXNlZ2luLnJzdCA9PiBpbXg5My1waHljb3JlLnJz
dH0gKDkxJSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQt
c2VnaW4tdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS0N
Cj4gYm9vdC5kdHNpDQo+IGluZGV4IGUwMDFlZTMyODguLjYzNWUyOTg1MDcgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiArKysg
Yi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gQEAgLTIs
MTUgKzIsMjIgQEANCj4gwqAvKg0KPiDCoCAqIENvcHlyaWdodCAoQykgMjAyMyBQSFlURUMgTWVz
c3RlY2huaWsgR21iSA0KPiDCoCAqIENocmlzdG9waCBTdG9pZG5lciA8Yy5zdG9pZG5lckBwaHl0
ZWMuZGU+DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkgN
Cj4gwqAgKg0KPiDCoCAqIFByb2R1Y3QgaG9tZXBhZ2U6DQo+IC0gKiBwaHlCT0FSRC1TZWdpbiBj
YXJyaWVyIGJvYXJkIGlzIHJldXNlZCBmb3IgdGhlIGkuTVg5MyBkZXNpZ24uDQo+IC0gKiBodHRw
czovL3d3dy5waHl0ZWMuZXUvZW4vcHJvZHVrdGUvc2luZ2xlLWJvYXJkLWNvbXB1dGVyL3BoeWJv
YXJkLXNlZ2luLWlteDZ1bC8NCj4gK8KgwqAgaHR0cHM6Ly93d3cucGh5dGVjLmRlL3Byb2R1a3Rl
L3N5c3RlbS1vbi1tb2R1bGVzL3BoeWNvcmUtaW14LTkxLTkzLw0KPiDCoCAqLw0KPiDCoA0KPiDC
oCNpbmNsdWRlICJpbXg5My11LWJvb3QuZHRzaSINCj4gwqANCj4gwqAvIHsNCj4gKwkvKg0KPiAr
CSAqIFRoZSBwaHlDT1JFLWkuTVg5MyB1LWJvb3QgdXNlcyB0aGUgaW14OTMtcGh5Ym9hcmQtc2Vn
aW4uZHRzIGFzDQo+ICsJICogcmVmZXJlbmNlLCBidXQgZG9lcyBvbmx5IG1ha2UgdXNlIG9mIGl0
cyBTb00gKHBoeUNPUkUpIGNvbnRhaW5lZA0KPiArCSAqIHBlcmlwaGVyeS4NCj4gKwkgKi8NCj4g
Kwltb2RlbCA9ICJQSFlURUMgcGh5Q09SRS1pLk1YOTMiOw0KPiArDQo+IMKgCXdkdC1yZWJvb3Qg
ew0KPiDCoAkJY29tcGF0aWJsZSA9ICJ3ZHQtcmVib290IjsNCj4gwqAJCXdkdCA9IDwmd2RvZzM+
Ow0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRBSU5FUlMg
Yi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiBpbmRleCBjZWE4MTdm
ZmRjLi43MThmODlhMDg0IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5
My9NQUlOVEFJTkVSUw0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJ
TkVSUw0KPiBAQCAtOSw1ICs5LDUgQEAgRjrCoMKgwqDCoMKgIGFyY2gvYXJtL2R0cy9pbXg5My1w
aHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiDCoEY6wqDCoMKgwqDCoCBib2FyZC9waHl0ZWMv
cGh5Y29yZV9pbXg5My8NCj4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5dGVjL2NvbW1vbi9pbXg5
M19zb21fZGV0ZWN0aW9uLmMNCj4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5dGVjL2NvbW1vbi9p
bXg5M19zb21fZGV0ZWN0aW9uLmgNCj4gLUY6wqDCoMKgwqDCoCBjb25maWdzL2lteDkzLXBoeWJv
YXJkLXNlZ2luX2RlZmNvbmZpZw0KPiArRjrCoMKgwqDCoMKgIGNvbmZpZ3MvaW14OTMtcGh5Y29y
ZV9kZWZjb25maWcNCj4gwqBGOsKgwqDCoMKgwqAgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14
OTMuaA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25m
aWcgYi9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+IHNpbWlsYXJpdHkgaW5kZXgg
OTglDQo+IHJlbmFtZSBmcm9tIGNvbmZpZ3MvaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmln
DQo+IHJlbmFtZSB0byBjb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+IGluZGV4IDMw
OTI2MmM0MzAuLmNmOTgwMDExOGEgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvaW14OTMtcGh5Ym9h
cmQtc2VnaW5fZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25m
aWcNCj4gQEAgLTYsNiArNiw3IEBAIENPTkZJR19TWVNfTUFMTE9DX0ZfTEVOPTB4MjAwMDANCj4g
wqBDT05GSUdfU1BMX0xJQkNPTU1PTl9TVVBQT1JUPXkNCj4gwqBDT05GSUdfU1BMX0xJQkdFTkVS
SUNfU1VQUE9SVD15DQo+IMKgQ09ORklHX05SX0RSQU1fQkFOS1M9Mg0KPiArQ09ORklHX1BIWVRF
Q19TT01fREVURUNUSU9OPXkNCj4gwqBDT05GSUdfRU5WX1NPVVJDRV9GSUxFPSJwaHljb3JlX2lt
eDkzIg0KPiDCoENPTkZJR19FTlZfU0laRT0weDEwMDAwDQo+IMKgQ09ORklHX0VOVl9PRkZTRVQ9
MHg3MDAwMDANCj4gQEAgLTMxLDYgKzMyLDcgQEAgQ09ORklHX1NQTF9JTVhfUk9NQVBJX0xPQURB
RERSPTB4ODgwMDAwMDANCj4gwqBDT05GSUdfU1lTX01FTVRFU1RfU1RBUlQ9MHg4MDAwMDAwMA0K
PiDCoENPTkZJR19TWVNfTUVNVEVTVF9FTkQ9MHg5MDAwMDAwMA0KPiDCoENPTkZJR19SRU1BS0Vf
RUxGPXkNCj4gKyMgQ09ORklHX0FORFJPSURfQk9PVF9JTUFHRSBpcyBub3Qgc2V0DQo+IMKgQ09O
RklHX0RJU1RST19ERUZBVUxUUz15DQo+IMKgQ09ORklHX09GX1NZU1RFTV9TRVRVUD15DQo+IMKg
Q09ORklHX0JPT1RDT01NQU5EPSJtbWMgZGV2ICR7bW1jZGV2fTsgaWYgbW1jIHJlc2NhbjsgdGhl
biBpZiBydW4gbG9hZGltYWdlOyB0aGVuIHJ1biBtbWNib290Ow0KPiBlbHNlIHJ1biBuZXRib290
OyBmaTsgZmk7Ig0KPiBkaWZmIC0tZ2l0IGEvZG9jL2JvYXJkL3BoeXRlYy9pbXg5My1waHlib2Fy
ZC1zZWdpbi5yc3QgYi9kb2MvYm9hcmQvcGh5dGVjL2lteDkzLXBoeWNvcmUucnN0DQo+IHNpbWls
YXJpdHkgaW5kZXggOTElDQo+IHJlbmFtZSBmcm9tIGRvYy9ib2FyZC9waHl0ZWMvaW14OTMtcGh5
Ym9hcmQtc2VnaW4ucnN0DQo+IHJlbmFtZSB0byBkb2MvYm9hcmQvcGh5dGVjL2lteDkzLXBoeWNv
cmUucnN0DQo+IGluZGV4IGNlMTdmYmVjNzguLmJkMTEwYTNlYmUgMTAwNjQ0DQo+IC0tLSBhL2Rv
Yy9ib2FyZC9waHl0ZWMvaW14OTMtcGh5Ym9hcmQtc2VnaW4ucnN0DQo+ICsrKyBiL2RvYy9ib2Fy
ZC9waHl0ZWMvaW14OTMtcGh5Y29yZS5yc3QNCj4gQEAgLTEsOSArMSw5IEBADQo+IMKgLi4gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+IMKgDQo+IC1waHlCT0FSRC1TZWdpbi1p
Lk1YOTMNCj4gLT09PT09PT09PT09PT09PT09PT09PQ0KPiArcGh5Q09SRS1pLk1YIDkzDQo+ICs9
PT09PT09PT09PT09PT0NCj4gwqANCj4gLVUtQm9vdCBmb3IgdGhlIHBoeUJPQVJELVNlZ2luLWku
TVg5My4NCj4gK1UtQm9vdCBmb3IgdGhlIHBoeUNPUkUtaS5NWCA5My4NCj4gwqANCj4gwqBRdWlj
ayBTdGFydA0KPiDCoC0tLS0tLS0tLS0tDQo+IEBAIC01MSw3ICs1MSw3IEBAIEJ1aWxkIFUtQm9v
dA0KPiDCoA0KPiDCoC4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+IMKgDQo+IC3CoMKgICQgbWFrZSBp
bXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gK8KgwqAgJCBtYWtlIGlteDkzLXBoeWNv
cmVfZGVmY29uZmlnDQo+IMKgwqDCoCAkIG1ha2UNCj4gwqANCj4gwqBCdXJuIHRoZSBmbGFzaC5i
aW4gdG8gTWljcm9TRCBjYXJkIG9mZnNldCAzMktCOg0KPiBkaWZmIC0tZ2l0IGEvZG9jL2JvYXJk
L3BoeXRlYy9pbmRleC5yc3QgYi9kb2MvYm9hcmQvcGh5dGVjL2luZGV4LnJzdA0KPiBpbmRleCA5
OTg0OGE5ZTk1Li5mYTMwNjk3NDY0IDEwMDY0NA0KPiAtLS0gYS9kb2MvYm9hcmQvcGh5dGVjL2lu
ZGV4LnJzdA0KPiArKysgYi9kb2MvYm9hcmQvcGh5dGVjL2luZGV4LnJzdA0KPiBAQCAtNyw3ICs3
LDcgQEAgUEhZVEVDDQo+IMKgwqDCoCA6bWF4ZGVwdGg6IDINCj4gwqANCj4gwqDCoMKgIGlteDht
bS1waHlnYXRlLXRhdXJpLWwNCj4gLcKgwqAgaW14OTMtcGh5Ym9hcmQtc2VnaW4NCj4gK8KgwqAg
aW14OTMtcGh5Y29yZQ0KPiDCoMKgwqAgcGh5Y29yZS1hbTYyeA0KPiDCoMKgwqAgcGh5Y29yZS1h
bTY0eA0KPiDCoMKgwqAgcGh5Y29yZS1pbXg4bW0NCg0K
