Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37DCD65C42
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 06:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC7E895C4;
	Thu, 14 Nov 2024 07:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="IwhRC1z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE480895C6; Thu, 14 Nov 2024 07:37:27 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB61895C0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9saBZA7yDqzT4R7XiZfWhsRY6Nhquxf0L2pxCm+cCTYJCp/+FeT0Hinu6Nid6e+tOqtNIdz2LDTV3D3P3KTjQlhIGYygoRWtZgco5NhPWlDR+oL75zdAK2D71zDkh9oKN3hz0TC3wOlvzEEDAgmF5y25OHRpOqnjHs4bNUxKSprk3gANfyWNeuZSDl7ldydH8r68AwfUPSB6BZ//oqZuyryTCy3eapvLetfGpRTOEjVyi1ePYrKkbLZivQE6qDWKjVoYCUSsCap6d1B0Qx7YTfAuBrhJcITNftdw4e8CdUPe3lKo1MDJdppGbkcWbSMrdqLISyMqNwemv8zZ+7m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GouCFaFrjU5/6bphx+yprvvq8tgjYzUwOE1POzQpmps=;
 b=PdbjqCC6x6FH53LjEAjgImEFXocafyUbeDhR6JsDOZtelVonVo8YfHER6qTRU8u37RIp04ISwmALwg/9TBx3CTtWPZliSCRWgYrH1jpeXhBo+gHQ50evIVsLDbsxL4FdAW2W0aH+U80BQQ3sZYuqpAYi/U1Fpok2Z2KbvJIwWqCmMjL3s+bHMghB2ltr2XFzumJusj8H22ZFh7m+GZFeU02HLaQYTXJLZuBEjfIu98n5KMwXV+V42k9sLytMKuV/LhklefbeX0CA6ikel4rBkbK9+XAf1AnBNO1glnZzA3v+lcRrGKOF/pRHKdmvyuJ+T2+OYWXgWK/VaY3hK7HjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GouCFaFrjU5/6bphx+yprvvq8tgjYzUwOE1POzQpmps=;
 b=IwhRC1z0HnKDzPFamiJb5qvjJschV0EM+RudiIXCTJRSQ9YQv33uUztv0BqTfvmU5OmcgDITQjDY0+s5faE+llCZegOPk+ACmkf0I0iq1XmWifJSPMi4QW0NeKxOYYuDmim4dwKjUolYTjklGCthSGslOWWt0pv6/PXNRokz7pg=
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by DU0P195MB1746.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Thu, 14 Nov
 2024 06:37:22 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::cc) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 06:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 06:37:21 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 07:37:20 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 14 Nov 2024 07:37:20 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: Christoph Stoidner <C.Stoidner@phytec.de>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Andrej Picej
 <andrej.picej@norik.com>, "sbabic@denx.de" <sbabic@denx.de>, PHYTEC Upstream
 <upstream@lists.phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Topic: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
Thread-Index: AQHbNeU5VQPRpaJgd0q5L0+QzB2wqLK2QsEA
Date: Thu, 14 Nov 2024 06:37:20 +0000
Message-ID: <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
In-Reply-To: <20241113160037.65679-4-c.stoidner@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <449122D380E53746911218A2900B9FAC@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DU0P195MB1746:EE_
X-MS-Office365-Filtering-Correlation-Id: e5504ca6-9829-4e3e-b6ab-08dd0476cae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVozSnBWcHNsalFhaFQ1R1A5QW40dlVFcWtXYVJ2MFVJYnJndkd2V3JLS1FP?=
 =?utf-8?B?SU94ZCsvdlZicStSVVhMU3ZUS0t0aldFck00N2UzMTN4alR0QUVnUWtSUHNx?=
 =?utf-8?B?bDBUcFVlWGFiVEUvenlRcWdzWCs1eC9Mckw3T1hQaVErRm5MVktwZkY0dnJh?=
 =?utf-8?B?SG1CditrSk81SE1Icy92ZkNzLzMybFlnUHlZRDF5MjJPblB5d1RyT3QwbXlM?=
 =?utf-8?B?eXhMSTMvY3FWWi9hV0E2bXRpdm1EMkJTTHVGTXdzTXpza004My9uWURCZXFM?=
 =?utf-8?B?OEQxaXRPN21vUWRmSjRJeTc0NGJuajBhWERmY3Y2REZ1N29XQ0c3WFdkMVJv?=
 =?utf-8?B?Nk94alcvSkxQNlhPNVQ4V1BGQmpSYys3VjVMamwxS0hBZDJUbW1jRU9jQjdD?=
 =?utf-8?B?VDlyaUVMOCtiTCtTbFZhNFdLV3JVQTVpeWEycFRoWm9FRGlPWDY0VEZja3Bq?=
 =?utf-8?B?T1JWM2dVSGRBTGtidmNwS0g5N2dYY2ZMTmRWTnE2WFdNZHFFcEYvQng1YUpl?=
 =?utf-8?B?Q00xMlhobUo1cHYyR0NPVUE2dmtSTUFSVVZ2cDJSNzJESktJVzRvNzE5Vnl1?=
 =?utf-8?B?bVUxQ29RQTEwVHhMdkdhNGRVWnFYTlVsTEYwR0NOSWE4cW9JUXZnTXozNVJ3?=
 =?utf-8?B?R2VqZkUrU0N3Vm1FN05YQms0L2NrUEU1TGVvbVhsVkt6akJGeEZJQWJOWnQz?=
 =?utf-8?B?MGNXNWFmYjIrSGZBT2JrR0FKOFk4aWVCOFIza0JBU0J6R0U0Nzk1R3RSaldO?=
 =?utf-8?B?VE1zdVhiOHZBbGxISHQxQkNITTZSNERVOHY0cXA1anNXdXJPOU9GYWtqZXl2?=
 =?utf-8?B?aTREY01RVHpONktSM3UwNko4NmdORzVGTUphRzZGSGxMNDVKeWw0cjFORy9m?=
 =?utf-8?B?eW5YSkt3WGRiWFhuMEdHMGF1clZVa0h6VWdObkwxSWl0ZXE5dFFrQXp2Z3Y1?=
 =?utf-8?B?YmNNWmc0TlNseXFVT1phU2drcnRVb2hFcW1GcURSTDFwS090UWR2d0syWk5t?=
 =?utf-8?B?V1dES0tObk1uTXJ6RS9XZ1dQZjJoSHdrOHhwYVZ2UE5aNHJPTXg5YW1JNERK?=
 =?utf-8?B?UUFtZXZkNGZrZTJjVVV5d29Ob3dNOEFMLzgwSFlQK2NnOHArYVZyaUpDM0la?=
 =?utf-8?B?S3NzQWpKcUx4OUFxYU1HMXJHRElPNE8yQ0ZtaEpGdDJXTnVGdDNNQm1mWUJB?=
 =?utf-8?B?TU5xWjhiSTF5VjF6ZGlxZTJyUHZ5VDVSd0RsblExcnhSZU5oNlBrUm81bDFN?=
 =?utf-8?B?WldyakcrSGNnWkFtSnJvSmVvYVYrdHVEeDhQUWJsaFlIQ2tCT08rZU5xSnNz?=
 =?utf-8?B?Q1pRSEhZTW1DTFpJUzMzYTFUbzdSZTczNit4Ym1Jd3lEalFtMUxBeTN6ZUN0?=
 =?utf-8?B?Nk54OVNFS0dZR3Rkd2wvOXN2R2liN2lNZ21VSGNnYkNvaWtCdU1kQTI5RVJT?=
 =?utf-8?B?eUJJaXNiQWlCQTRzb3pVRmtFbmNmSGtuZlBOVjROdWp2djViOGVOd092TjRj?=
 =?utf-8?B?ejkzOXBkR0tsTEdSREU0ZWtYV2lOaUpVaFBhTFlnVmk4Qllha0hDL0Q5RGdL?=
 =?utf-8?B?MVA2cXNPL1hsTUhzVWJvcHJYRXk4Smk5cXBFRWJ4TzJESHdRTERrRGlsMDVF?=
 =?utf-8?B?eUt0SWRnNGZWUnVydzRSZDdpWUpMc2ZNclZQdXdJcnhSSWV1ZDZvY08rOGhO?=
 =?utf-8?B?QlQ3ZDgrRzFHS1pVS3RvMHBPQkI4V0hCL3phQ1dvdzlYUHgyRUtCRlZWNDJD?=
 =?utf-8?B?a2IxVFVTM3NpNm11eVh4UGxCbXVzNGQzNEZadG5UNVZtd0J1UGFoZk9IcnpI?=
 =?utf-8?Q?7CCtYSuyzOsUNKSElLHC3bMdtzog3QUWf3hH0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 06:37:21.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5504ca6-9829-4e3e-b6ab-08dd0476cae4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1746
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

T24gV2VkLCAyMDI0LTExLTEzIGF0IDE3OjAwICswMTAwLCBDaHJpc3RvcGggU3RvaWRuZXIgd3Jv
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
dG9pZG5lckBwaHl0ZWMuZGU+DQo+IC0tLQ0KPiBDYzogTWF0aGlldSBPdGhhY2VoZSA8bS5vdGhh
Y2VoZUBnbWFpbC5jb20+DQo+IENjOiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5
dGVjLmRlPg0KPiBDYzogU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+DQo+IENjOiBGYWJp
byBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiAiTlhQIGkuTVggVS1Cb290IFRl
YW0iIDx1Ym9vdC1pbXhAbnhwLmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5j
b20+DQo+IENjOiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCj4gQ2M6IFByaW1veiBG
aXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT4NCj4gQ2M6IEFuZHJlaiBQaWNlaiA8YW5kcmVq
LnBpY2VqQG5vcmlrLmNvbT4NCj4gQ2M6IFdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRl
Pg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBqdXN0IHJlbmFtZSBpbXg5My1waHlib2Fy
ZC1zZWdpbl9kZWZjb25maWcgYW5kIGFkZCBuZWVkZWQgQ09ORklHcywNCj4gwqAgaW5zdGVhZCBv
ZiBjcmVhdGluZyBhbiBlbnRpcmVseSBuZXcgc2Vjb25kIGRlZmNvbmZpZw0KPiAtIHJlbW92ZSB3
cm9uZyBjb21tZW50IGZyb20gaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gLSBp
bXByb3ZlIGNvbW1pdCBtZXNzYWdlDQo+IA0KPiDCoGFyY2gvYXJtL2R0cy9pbXg5My1waHlib2Fy
ZC1zZWdpbi11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2ICsrKyst
LQ0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJTwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiDCoC4uLng5My1waHlib2Fy
ZC1zZWdpbl9kZWZjb25maWcgPT4gaW14OTMtcGh5Y29yZV9kZWZjb25maWd9IHwgNCArKystDQo+
IMKgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IMKg
cmVuYW1lIGNvbmZpZ3Mve2lteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZyA9PiBpbXg5My1w
aHljb3JlX2RlZmNvbmZpZ30gKDk4JSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMv
aW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5
Ym9hcmQtc2VnaW4tdS0NCj4gYm9vdC5kdHNpDQo+IGluZGV4IDI1Yzc3OGJiMDcuLjIyNDU0NjEw
MzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg5My1waHlib2FyZC1zZWdpbi11LWJv
b3QuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290
LmR0c2kNCj4gQEAgLTIsMTUgKzIsMTcgQEANCj4gwqAvKg0KPiDCoCAqIENvcHlyaWdodCAoQykg
MjAyMyBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KPiDCoCAqIENocmlzdG9waCBTdG9pZG5lciA8
Yy5zdG9pZG5lckBwaHl0ZWMuZGU+DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgUEhZVEVDIE1l
c3N0ZWNobmlrIEdtYkgNCj4gwqAgKg0KPiDCoCAqIFByb2R1Y3QgaG9tZXBhZ2U6DQo+IC0gKiBw
aHlCT0FSRC1TZWdpbiBjYXJyaWVyIGJvYXJkIGlzIHJldXNlZCBmb3IgdGhlIGkuTVg5MyBkZXNp
Z24uDQo+IC0gKiBodHRwczovL3d3dy5waHl0ZWMuZXUvZW4vcHJvZHVrdGUvc2luZ2xlLWJvYXJk
LWNvbXB1dGVyL3BoeWJvYXJkLXNlZ2luLWlteDZ1bC8NCj4gK8KgwqAgaHR0cHM6Ly93d3cucGh5
dGVjLmRlL3Byb2R1a3RlL3N5c3RlbS1vbi1tb2R1bGVzL3BoeWNvcmUtaW14LTkxLTkzLw0KPiDC
oCAqLw0KPiDCoA0KPiDCoCNpbmNsdWRlICJpbXg5My11LWJvb3QuZHRzaSINCj4gwqANCj4gwqAv
IHsNCj4gKwltb2RlbCA9ICJQSFlURUMgcGh5Q09SRS1pLk1YOTMiOw0KPiArDQo+IMKgCXdkdC1y
ZWJvb3Qgew0KPiDCoAkJY29tcGF0aWJsZSA9ICJ3ZHQtcmVib290IjsNCj4gwqAJCXdkdCA9IDwm
d2RvZzM+Ow0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRB
SU5FUlMgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiBpbmRleCBj
ZWE4MTdmZmRjLi43MThmODlhMDg0IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg5My9NQUlOVEFJTkVSUw0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9N
QUlOVEFJTkVSUw0KPiBAQCAtOSw1ICs5LDUgQEAgRjrCoMKgwqDCoMKgIGFyY2gvYXJtL2R0cy9p
bXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiDCoEY6wqDCoMKgwqDCoCBib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg5My8NCj4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5dGVjL2NvbW1v
bi9pbXg5M19zb21fZGV0ZWN0aW9uLmMNCj4gwqBGOsKgwqDCoMKgwqAgYm9hcmQvcGh5dGVjL2Nv
bW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmgNCj4gLUY6wqDCoMKgwqDCoCBjb25maWdzL2lteDkz
LXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZw0KPiArRjrCoMKgwqDCoMKgIGNvbmZpZ3MvaW14OTMt
cGh5Y29yZV9kZWZjb25maWcNCg0KSG93IHdpbGwgeW91IGhhbmRsZSB0aGlzIHdoZW4vaWYgeW91
IGhhdmUgYW5vdGhlciBib2FyZD8NCg0KQWxzbywgcGxlYXNlIHVwZGF0ZSBkb2N1bWVudGF0aW9u
IQ0KDQpZYW5uaWMNCg0KPiDCoEY6wqDCoMKgwqDCoCBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9p
bXg5My5oDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL2lteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNv
bmZpZyBiL2NvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gc2ltaWxhcml0eSBpbmRl
eCA5OCUNCj4gcmVuYW1lIGZyb20gY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25m
aWcNCj4gcmVuYW1lIHRvIGNvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gaW5kZXgg
MThhNDA4N2U0Yi4uY2Y5ODAwMTE4YSAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9pbXg5My1waHli
b2FyZC1zZWdpbl9kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9pbXg5My1waHljb3JlX2RlZmNv
bmZpZw0KPiBAQCAtNiwxMyArNiwxMyBAQCBDT05GSUdfU1lTX01BTExPQ19GX0xFTj0weDIwMDAw
DQo+IMKgQ09ORklHX1NQTF9MSUJDT01NT05fU1VQUE9SVD15DQo+IMKgQ09ORklHX1NQTF9MSUJH
RU5FUklDX1NVUFBPUlQ9eQ0KPiDCoENPTkZJR19OUl9EUkFNX0JBTktTPTINCj4gK0NPTkZJR19Q
SFlURUNfU09NX0RFVEVDVElPTj15DQo+IMKgQ09ORklHX0VOVl9TT1VSQ0VfRklMRT0icGh5Y29y
ZV9pbXg5MyINCj4gwqBDT05GSUdfRU5WX1NJWkU9MHgxMDAwMA0KPiDCoENPTkZJR19FTlZfT0ZG
U0VUPTB4NzAwMDAwDQo+IMKgQ09ORklHX0lNWF9DT05GSUc9ImFyY2gvYXJtL21hY2gtaW14L2lt
eDkvaW14aW1hZ2UuY2ZnIg0KPiDCoENPTkZJR19ETV9HUElPPXkNCj4gwqBDT05GSUdfREVGQVVM
VF9ERVZJQ0VfVFJFRT0iaW14OTMtcGh5Ym9hcmQtc2VnaW4iDQo+IC1DT05GSUdfU1BMX1RFWFRf
QkFTRT0weDIwNDlBMDAwDQo+IMKgQ09ORklHX0FIQUJfQk9PVD15DQo+IMKgQ09ORklHX1RBUkdF
VF9QSFlDT1JFX0lNWDkzPXkNCj4gwqBDT05GSUdfT0ZfTElCRkRUX09WRVJMQVk9eQ0KPiBAQCAt
MjAsNiArMjAsNyBAQCBDT05GSUdfU1lTX01PTklUT1JfTEVOPTUyNDI4OA0KPiDCoENPTkZJR19T
UExfU0VSSUFMPXkNCj4gwqBDT05GSUdfU1BMX0RSSVZFUlNfTUlTQz15DQo+IMKgQ09ORklHX1NQ
TF9TVEFDSz0weDIwNTE5ZGQwDQo+ICtDT05GSUdfU1BMX1RFWFRfQkFTRT0weDIwNDlBMDAwDQo+
IMKgQ09ORklHX1NQTF9IQVNfQlNTX0xJTktFUl9TRUNUSU9OPXkNCj4gwqBDT05GSUdfU1BMX0JT
U19TVEFSVF9BRERSPTB4MjA1MWEwMDANCj4gwqBDT05GSUdfU1BMX0JTU19NQVhfU0laRT0weDIw
MDANCj4gQEAgLTMxLDYgKzMyLDcgQEAgQ09ORklHX1NQTF9JTVhfUk9NQVBJX0xPQURBRERSPTB4
ODgwMDAwMDANCj4gwqBDT05GSUdfU1lTX01FTVRFU1RfU1RBUlQ9MHg4MDAwMDAwMA0KPiDCoENP
TkZJR19TWVNfTUVNVEVTVF9FTkQ9MHg5MDAwMDAwMA0KPiDCoENPTkZJR19SRU1BS0VfRUxGPXkN
Cj4gKyMgQ09ORklHX0FORFJPSURfQk9PVF9JTUFHRSBpcyBub3Qgc2V0DQo+IMKgQ09ORklHX0RJ
U1RST19ERUZBVUxUUz15DQo+IMKgQ09ORklHX09GX1NZU1RFTV9TRVRVUD15DQo+IMKgQ09ORklH
X0JPT1RDT01NQU5EPSJtbWMgZGV2ICR7bW1jZGV2fTsgaWYgbW1jIHJlc2NhbjsgdGhlbiBpZiBy
dW4gbG9hZGltYWdlOyB0aGVuIHJ1biBtbWNib290Ow0KPiBlbHNlIHJ1biBuZXRib290OyBmaTsg
Zmk7Ig0KDQo=
