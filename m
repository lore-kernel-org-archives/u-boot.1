Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95ACD3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F9B895A9;
	Mon, 25 Nov 2024 10:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="sBo1Qmox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F95895C5; Mon, 25 Nov 2024 10:24:11 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C1E88E0F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmFxP30h3Gg5OzlUqRVw+KdO88GokITajabtZBpQfWYryAj5D2rVZevqbYNUauNvvjEBTlGkmTCMtG5whmxISPfAScarH4luq/kAF44yDdWuo+DPDWdqVY5q8FvqdNKMvKr2attyrtD+hck4FwQmPYQDAmA6JCcDKKRj+7I30YMypJF155f5GHjiMl/C3rXs6VeRVz7FKJIPas107/ygsJaNc1s59cfkELHR6ops4GxBHFb+vkS8Sh/l91K3DUd4QE5hcQg6yG+SG73nFPLqWYZDF/1SpQDDPA/vIVAROigwLIH5TzauEGfN+66zfATk5NjXmSnKgM+GK2qhAFqZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72jENUk25uZKCbmozIl8+UcxTJxq70dLV+t4nKcq8KE=;
 b=j11epjK6uxb81xqiAOMJT2HjNxk7kzs8zYv6YTCPKJazmFFPOgIbbT8DRfbNoR4Vz+nx4MTLJExw6VOgyU6ihM1FJK4aK2pQH2FBLjUAanjutMOvGm5Zze/QQ+HxJlD1pi5x7cMME9qSmDrmxfzV2zVBY8T0j5N78SUvEgQp+BYeWJKS4QCBwwnjwm3po2cfyrai2fjL3QsiuzoybzGjNYlCPMDRCzMIZipQoc9/oFkM+VWiqqnLEvrSmhEek1Su2fEkQBgSCQdjGhGXF/NxNb98tuG1nQVDj9gwCv9+NVzF1Fr7xpsV+qtxABx96SQhEuzjSkTkSFb729rIGei45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72jENUk25uZKCbmozIl8+UcxTJxq70dLV+t4nKcq8KE=;
 b=sBo1QmoxN6f6noiyOcMSSPd9z6X43ZuGYlxFWHOVDNREjOSB941qwUKkrW6C2s+oGadKmyd8/oh4PKqDdac+GEgEbsYooBdpXFEo1Ygc+J2+/uVrioTRhG5r0zcIy80/UPx+KJBEAz4dT8L8mtxAoABw4RAFhYxAonTgbcpiqxo=
Received: from DU6P191CA0062.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::11)
 by VI1P195MB0496.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:24:06 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::3b) by DU6P191CA0062.outlook.office365.com
 (2603:10a6:10:53e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 09:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 09:24:05 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:24:05 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:24:05 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 25 Nov 2024 10:24:05 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yunus Bas <Y.Bas@phytec.de>
Subject: Re: [PATCH 2/3] phycore_imx8mm: Move default bootcmd to board env
Thread-Topic: [PATCH 2/3] phycore_imx8mm: Move default bootcmd to board env
Thread-Index: AQHbPOennnvoDcTWMU+wuVqkSqsngLLHrPcA
Date: Mon, 25 Nov 2024 09:24:04 +0000
Message-ID: <540825069a6a3ac54774b638cfad61690d6293a6.camel@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
 <20241122102833.4061689-2-y.bas@phytec.de>
In-Reply-To: <20241122102833.4061689-2-y.bas@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A4EA5C342AEB04180144F0F916AE190@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|VI1P195MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: be6d3046-a3fa-41d8-66b3-08dd0d32e8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2s3cnB2bFNCU01SZUNpUXY5WVRuV05UMFdrV2NsbldwN01VcGE4RjFnRUxO?=
 =?utf-8?B?eTZqL2ZWcUxyOSsxbmhLR0g0V1l2TmFyZEJiY2VFRERvUDFpdnNzYTl0dXgv?=
 =?utf-8?B?SXJCc0dVZmVMemJpTSt2V0JIdVVlQ0Vkd2xXSE9OUjc2cldFMmVUQ1dXSkhv?=
 =?utf-8?B?aS9mVm8ydmZweXgrZStHNHBEMVlVekN4YUI1cFc1aWxFanBQSXBJRWlCN3JU?=
 =?utf-8?B?ZnI3Ui9GMmh0MWpmNXo4aWNIM1BDSWM4anZmVzNBZmx3TmREZU41a3dSMVVk?=
 =?utf-8?B?VkpOL0xGRU1UcmlodmF6cmx3NjdtUWVGMFdZWmtIR0Q4L0ZVZVVqeTl1N0tG?=
 =?utf-8?B?SnM5QkVkZm9MazA1QWlGNzcrMnhGRjI2NFVPTjJyOUwvWlRVYU9NeXhoTUhL?=
 =?utf-8?B?VmZLckg0WmNaWm9ndnpDem8vdDYxd0RMazIyRGsyVW9DTVdsVVN4bW5uMHVo?=
 =?utf-8?B?THNxNll6S3RDMVlPV05qZzRjWW5XcXZIMWdra1Vpdm80TDhNbDBEd05PVGtW?=
 =?utf-8?B?eTFsVkpiTXZaZXRzcjU3eUE1UzliMnV0T3QySE5FRm9Td3B4RmhFWnZJNGow?=
 =?utf-8?B?MzJyb20yTjZLVnZZTktoTXA5SnhYWVkzcVBUZkdUYkZtczhzeWNCaTB1OW5F?=
 =?utf-8?B?bDZ6T2dVK0ZNcnBOSkJNaWpNM3B0YlFOak5PUHovbVhWUFUrVzJFeXlEYlZB?=
 =?utf-8?B?U3pLMVlBUjVxVnVpdzNpSjFYR2wyTDNuYloyU2ZzeEVKbmxwcGwvMDRZaU1X?=
 =?utf-8?B?U3RXQmV3VFZ6dDVHNkFOdk5JUGpScENucXhoN3l1QTZ3ZWJZWVNmTUtVZENF?=
 =?utf-8?B?eW5jYUorbElUV0V2RE4yY0xlM1VtajBzRjhXZ2pKMEhzdW1CRkVIYm54ZFpT?=
 =?utf-8?B?cW9oN2d2cm0ycE9YS0ZNRWYrbDR1d1UyM2xoUkpEOHpobGRYSkV3d0d1enhi?=
 =?utf-8?B?K1BlY0JmS0J1Y2JQNTBqdEFMV2g4cFkrTVNFR1JXQ01kNGVreVRKbzBMYk1S?=
 =?utf-8?B?NGFSS0UrbW1GWENKSG54RGZMSFp3TnZHcnRDdGdpdHcyb1pRY0luYWJHU05s?=
 =?utf-8?B?TFdQcVZTc0Y4WnVLSGZFaHlCMVc0SmN4cmQranhmdjVoNjFRYXZHdi9rOVhx?=
 =?utf-8?B?UkI5cy93T2FpWWxxL1RadHZDbHRPUXNWWG0rQWplNXI2M0VLakk4cFhSZXVk?=
 =?utf-8?B?YXRhM1E5UXRhdDZJRURIUUdjQkw5dWdvT2QzSWxmWkxISEgvUUpDbmF0T09F?=
 =?utf-8?B?TGJYcExmam1QNFZUNkMxTFR0T1lNam1Gd1p4NFJHTXZSTk9MTEwwUHdoQTVH?=
 =?utf-8?B?WVJYUFFqczNVT05rV2VNRHA4QitPUGRQOFJ0eXBBbVFwa0FIWDZNaHUrVXpU?=
 =?utf-8?B?T3VuL1BIVGhBbVZkZ0k4UExxdEdYWjBVcHB5SFNwdDY4dGJZMHplT0tpRG05?=
 =?utf-8?B?WGMxVFJOZVA5VWk0OUVYYXpGWlhiNVpUemlQQ01oZE55RTRNYUpMQjc3WkJX?=
 =?utf-8?B?blRYZ1VlZ3prUHNnN25LdW9EOUgrZWhSTkdEYUtZaWtMYnphU29PVDFzcUda?=
 =?utf-8?B?cHR4bnpmUkxtdjRNblBJWDZNMTZxZnhnUmNyWXlvc3BxbHRJdDc4SXFlUDgv?=
 =?utf-8?B?ajJHcGl4UGM3bm13Z2pFK1hqRGZ3R3hJeEZPQk00RHZ6SElkTCtkZ29UbUFo?=
 =?utf-8?B?Y2VjVHpmT3RCMUtMV05vZWt0SUc4dkFkcWpObkRoRzFrMnRFeGpLMW5hTWhp?=
 =?utf-8?B?TzBBa1NSWThSMGdTNkl2N0pDZ0tncXpHak92d1duOC9DcjZFdU1jeUtvUjlG?=
 =?utf-8?B?SFkzQUtrcnRMS3pKVDZ1ODhMV3dXVEZxNStBVURhQm5Za1lJOEROa2Y1a0JG?=
 =?utf-8?B?NWw5KzJ3cmFSa1hHdkQ5b3VSbU90MDdqRXE1Zk9QSGtoWi8rc25IcnZJWlpy?=
 =?utf-8?Q?+C6/ixqCEutBC9VuC+pCxPLJOaOR3Eb3?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:24:05.9057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6d3046-a3fa-41d8-66b3-08dd0d32e8ad
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0496
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

T24gRnJpLCAyMDI0LTExLTIyIGF0IDExOjI4ICswMTAwLCBZdW51cyBCYXMgd3JvdGU6DQo+IE1v
dmUgdGhlIGRlZmF1bHQgYm9vdGNtZCBmcm9tIHRoZSBkZWZjb25maWcgdG8gdGhlIGJvYXJkIGVu
dmlyb25tZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVudXMgQmFzIDx5LmJhc0BwaHl0ZWMu
ZGU+DQpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQoNCj4gLS0t
DQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3BoeWNvcmVfaW14OG1tLmVudiB8IDkg
KysrKysrKysrDQo+IMKgY29uZmlncy9waHljb3JlLWlteDhtbV9kZWZjb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMiAtLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtbS9waHljb3JlX2lteDhtbS5lbnYNCj4gYi9ib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg4bW0vcGh5Y29yZV9pbXg4bW0uZW52DQo+IGluZGV4IGIyZjYxODQzOTk1Li4yMDU4YmY1
OTIzNSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3BoeWNvcmVf
aW14OG1tLmVudg0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZV9p
bXg4bW0uZW52DQo+IEBAIC0xLDMgKzEsMTIgQEANCj4gK2Jvb3RjbWQ9DQo+ICsJbW1jIGRldiAk
e21tY2Rldn07DQo+ICsJaWYgbW1jIHJlc2NhbjsgdGhlbg0KPiArCQlpZiBydW4gbG9hZGltYWdl
OyB0aGVuDQo+ICsJCQlydW4gbW1jYm9vdDsNCj4gKwkJZWxzZQ0KPiArCQkJcnVuIG5ldGJvb3Q7
DQo+ICsJCWZpOw0KPiArCWZpOw0KPiDCoGNvbnNvbGU9dHR5bXhjMiwxMTUyMDANCj4gwqBlbW1j
X2Rldj0yDQo+IMKgZmR0X2FkZHJfcj0weDQ4MDAwMDAwDQo+IGRpZmYgLS1naXQgYS9jb25maWdz
L3BoeWNvcmUtaW14OG1tX2RlZmNvbmZpZyBiL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bW1fZGVmY29u
ZmlnDQo+IGluZGV4IDVlNTllZmU1NjQ5Li5jOGZiY2M5MTBkOCAxMDA2NDQNCj4gLS0tIGEvY29u
Zmlncy9waHljb3JlLWlteDhtbV9kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9waHljb3JlLWlt
eDhtbV9kZWZjb25maWcNCj4gQEAgLTMwLDggKzMwLDYgQEAgQ09ORklHX0ZJVD15DQo+IMKgQ09O
RklHX0ZJVF9FWFRFUk5BTF9PRkZTRVQ9MHgzMDAwDQo+IMKgQ09ORklHX1NQTF9MT0FEX0ZJVD15
DQo+IMKgQ09ORklHX09GX1NZU1RFTV9TRVRVUD15DQo+IC1DT05GSUdfVVNFX0JPT1RDT01NQU5E
PXkNCj4gLUNPTkZJR19CT09UQ09NTUFORD0ibW1jIGRldiAke21tY2Rldn07IGlmIG1tYyByZXNj
YW47IHRoZW4gaWYgcnVuIGxvYWRpbWFnZTsgdGhlbiBydW4gbW1jYm9vdDsNCj4gZWxzZSBydW4g
bmV0Ym9vdDsgZmk7IGZpOyINCj4gwqBDT05GSUdfREVGQVVMVF9GRFRfRklMRT0ib2Z0cmVlIg0K
PiDCoENPTkZJR19TWVNfQ0JTSVpFPTIwNDgNCj4gwqBDT05GSUdfU1lTX1BCU0laRT0yMDc0DQoN
Cg==
