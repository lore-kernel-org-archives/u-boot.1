Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E982D3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DA5895FB;
	Mon, 25 Nov 2024 10:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="pj75ahtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C898189963; Mon, 25 Nov 2024 10:16:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0D788B0B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8nwnJngqxLkO5Q/M3rAnHqK5CNPRv5/MNCldsOTgn1r13LCGHMchhU5yeLJTiBDpEslgCMGXWvghELai+3s71kxWVZHwVipOuYZmQLrkV76CqCZeXX7BhC9XZV/Wmi/Ljm++5ULp6AyBFghUiaj/+Bj2NRQdIzjJaDyiG5xvWlIAj9tf0K0tgdFJ1vhrpFGT6NkJ8kWygUEtpoLBFXEm6WIi21rSTDHNk6kZlmU+QLZlU+RGz8cXAunufRogEoyX3HWOCCfhPgXJ+AN3dguFs9lRh0+c52+CtWWIAppBQ9QKeze+v0slUPAiVuRcdcLL3osMvrrlpJTZ75Irh4r9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWnXo+YnBNNzgWMfVb2UxxRBPS68gow0bZO3vg5Paow=;
 b=A3PxxRd2GhuS7+uN7bV8wkKDY6EgTZbKfbaXIvosG5WAjlPBqI0ytTq1djg+3WalAMO3KkATmc1/tu+vpAtg90CTUWf0pDiS/ca4XLyMVeN8toQPbpMhXubyGGOi33VRRTtTtGUCpmsVm58teQXk2B2ULc2mLf4rlV7XnwXsMI2lUO2gqSpT4Spe4TpAWo3bNtQLirVhEg4Z4rlDJhuYHTewDcrWGPM9VpaJ6zkfNDNCmObX+ouvA6BleMUtqX+N113+BVk9db5mfQhCJdpvE1mVDtFnxYgG+nUFcaL51E4cRsfW9OQKX3DU6Is+v8I2XwP6zauJkdXr9Q5xMOMbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWnXo+YnBNNzgWMfVb2UxxRBPS68gow0bZO3vg5Paow=;
 b=pj75ahtFMKaNtMeD4TgFtFVhO9jOYjZ7vdVbzONhCG+/BHFpdarO9w/EsvyF27Mgmr/bMYSC4PvmkCJ31vd1UJG9eC1YqmcWiSfo6YlJpCpqpbGt15wjc+pUjbcu0cztK3dZHBVxGgUVv0AutgHXtWWeUvrbfvz39J1K0GLVDlU=
Received: from AM6P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::25)
 by GV2P195MB2307.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:15:56 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:209:83:cafe::cb) by AM6P192CA0012.outlook.office365.com
 (2603:10a6:209:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 09:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 09:15:55 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:15:55 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 25 Nov
 2024 10:15:55 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 25 Nov 2024 10:15:55 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yunus Bas <Y.Bas@phytec.de>
Subject: Re: [PATCH 1/3] phycore_imx8mm: Switch to using env text files
Thread-Topic: [PATCH 1/3] phycore_imx8mm: Switch to using env text files
Thread-Index: AQHbPOedN4kUPdfwh0eS4yFqTMFe2LLHqq8A
Date: Mon, 25 Nov 2024 09:15:54 +0000
Message-ID: <95a6dfb696d005ee5e84c903f39d100133f22710.camel@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
In-Reply-To: <20241122102833.4061689-1-y.bas@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA1F24C208139F49AD5E5E68751BCD73@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|GV2P195MB2307:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9d5787-ceb4-4195-b0f3-08dd0d31c47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ni9ER2tncUxWWCtMeTVLKzZicXdjNFk1T00wMjdnTjQ5dnhMdGppUUVHTEpF?=
 =?utf-8?B?aENpc29wSThlT3BsamttMlRUN3B1Tm4xUS9TekJoak1SQnpOOVdFS2pmMUhq?=
 =?utf-8?B?N1EyMCtEaDFVSU90Si81TlFJclRmL0FCV3hmM1hLTWMwR1BTNkZvSDN1YnRn?=
 =?utf-8?B?ZnJySTBuUXFWNWlXNjl5LzVoZ2pSbFZQY0ZRWE4zdEQzV2V5aTNseExpL3Vu?=
 =?utf-8?B?V2lRSHZJY1RBY3U4SS9yMEI4N0EzdldlWDBNNmJLc3lkK0Rob0thVWpDMFFM?=
 =?utf-8?B?VVVpZldWRlI1U1J4QXZLUzU0WSs3NElueTJGeTJRMkZxMFpqTEFSMTh6SXVD?=
 =?utf-8?B?M0NyZU5QV05WTmx4WjVEVDZBMitHb2dVRWgrWkk3bkJPdGl5QnZGYXovOHhN?=
 =?utf-8?B?cHQ1dTAxYmNKZW44eVQ3eUpCYkdjR1hITVBEZUZkZHM4OXhrSm12dkVXVWFB?=
 =?utf-8?B?UitVUEIydXdlMmVZakU5eWpYVFN3YVNTZUYvYlFGZmIrOVVaZlJ3RFJjdm5S?=
 =?utf-8?B?YWlhZUd0dTVqRnZ6UnVIK0Y1cnFkc0RySlZiVU1qYzRDVGtqZlJZM3ZtcXhh?=
 =?utf-8?B?OVVOL2hFSjluOEF5T2tjUWM3d3R3UFZhTll2NmRYRmppZ0ZoMHl3enVrYkJs?=
 =?utf-8?B?NVpnWnpGV1JXK3ZDOEcxS2l6U0Q3Q0IvT0MwOTNudW5kbllLZDVSK1NsOC9r?=
 =?utf-8?B?SlEzLzVHMGwrNmpZcFZJcHY4SmoycjhnclRvVlNySGpqcWVLa25VM0lRS2c2?=
 =?utf-8?B?U2xsRThxN0czalRKbDB3Qjk1UDNSYitPWGZVNGNyR2NoSUVWMWRkcVArWDl4?=
 =?utf-8?B?RUp4b0hRUGJnTlBnU3RRVlZkNVJMU3Q0eUVjNjhSeStYK0w2SnRqNDJtSDAx?=
 =?utf-8?B?Nzc1TXdDWm4zVlRPbklTU281MFpnRUhGY2I0WDhieEFzUXcwRTNDbngwcXd6?=
 =?utf-8?B?MGhIWngyM3B5K1NBUVJyZXpqMnZBSnVUVUtzVCtIS2pHQ1RqVXllTXV6OW1s?=
 =?utf-8?B?MmU3QllxRFFmR04vaUN0SlhTQUVXakhmYTdhSko2aTN0TmFUU2dMekhaVmMv?=
 =?utf-8?B?dE1FRXNqOVVwem5IVGRLSzE3ZXI1MHhwazY2Rjc1V3NVbkpXZ05od3FJV1Fv?=
 =?utf-8?B?OVhRdVRwMTZOckVnSHhnZnBWQVdUZXZHU2Z3RjR4ajU2VjhTdUIyenp0U1hM?=
 =?utf-8?B?bFl6KzZ6cVBJTHZVSHdwdUlUd2RqQTBhN0F2UkZ3emtYVmRDdjg0Q2diaEpi?=
 =?utf-8?B?TENyRGc3cTR0eGp4V2RpV2FNeGpyNmJtWXRvUkJaSjcrTVpkVUVNczdDMFE2?=
 =?utf-8?B?TENkaU5PUmJRTTVnZTlBMUp1d2VPb2tjUVpYSGFpUjYvUnFKaE5PRDRnbU40?=
 =?utf-8?B?Smp4MVo2UldMVDA0SElqbDZlWEdhSWJ3WTI4ZXRvSmJrdk82WjFhQTYwSi9V?=
 =?utf-8?B?MzJYcng5amE5U0Z1Vnk1d05SN1JkVXFGRjRrRnQ2am5IVEpoemVmK0FwZjZY?=
 =?utf-8?B?TEFHK1BNVFQ4YnNsRmExTlhYaU5wZVk4d3lFYXppcVFicEFRUFkvakoxMmFS?=
 =?utf-8?B?b3JZbVNmaFhpT21EaUgzYllDbDZFdWJsL2pSckV3TlFub3VNZmVFVHRJaE0w?=
 =?utf-8?B?b3RmNk1OOExPbk5panRxcHJKSzNjQVBJTm10SmI5U25GWlZaVWJTZ2txc3ZL?=
 =?utf-8?B?dERjYnpNV1REeTFKb3VzZXFFZ2JPcG4wYXp6NzdyaWxLYVJ1Mmg5TXpMeVFT?=
 =?utf-8?B?TTU5SHVsYlVtVmJkYXhWRC9hRFB4bnNOelpPdm9ZSTM5TlRaZXhUNlBVVklr?=
 =?utf-8?B?UFRwcGVabHBzM2dQNExEb01OVnYyNUlRK3lRNi9aL3NHRTJOVGQ4VnZ0b2xU?=
 =?utf-8?B?KzFtS05qbHZIRmNZdkRpK2dzTUVCZnNqbEFGYjhlNms2aWV3cGJLaW03N0ZJ?=
 =?utf-8?Q?VNEDF3vmS96r3e1KsDGgyKnq4YEf20Vn?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:15:55.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9d5787-ceb4-4195-b0f3-08dd0d31c47a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2307
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

SGkgWXVudXMsDQoNCnBsZWFzZSB1c2UgZ2V0X21haW50YWluZXIgc2NyaXB0IHRvIGdldCBhIGxp
c3Qgb2YgcGVvcGxlIHRvIHNlbmQgKGEgY29weSBvZikgdGhlIHBhdGNoZXMgdG8uDQpVc3VhbGx5
IE1haW50YWluZXJzIGFyZSBwdXQgaW4gVG86IGZpZWxkIGFuZCByZXZpZXdlcnMgQ2M6DQoNCkFk
ZGl0aW9uYWxseSwgSSBzdWdnZXN0IHVzaW5nIGEgY292ZXIgbGV0dGVyIHRvIHN1bW1hcml6ZSB0
aGUgY2hhbmdlcyBtYWRlIGluIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpPbiBGcmksIDIwMjQtMTEt
MjIgYXQgMTE6MjggKzAxMDAsIFl1bnVzIEJhcyB3cm90ZToNCj4gTW92ZSB0aGUgZW52aXJvbm1l
bnQgaW50byB0aGUgYm9hcmQgZGlyZWN0b3J5IGFuZCBjb252ZXJ0IGhlYWRlciB0byBhDQo+IHR4
dCBmaWxlLiBJbiBhZGRpdGlvbiwgdGhpcyBwYXRjaCBhbHNvIGFwcGxpZXMgZm9sbG93aW5nIGNo
YW5nZXM6DQo+IA0KPiAtIENoYW5nZSBkZWZhdWx0IG5mc3Jvb3QgcGF0aCB0byAvc3J2L25mcyBk
dWUgdG8gY29tcGxpYW5jZSB3aXRoIExpbnV4DQo+IEZIUyAzLjAuDQo+IA0KPiAtIFJlbmFtZSBz
cGVjaWZpYyB2YXJpYWJsZXMgYXMgc3RhdGVkIGluIHRoZSBib290c3RkIGRvY3VtZW50YXRpb24u
DQo+IFJlbmFtZWQgdmFyaWFibGVzOg0KPiAJZmR0X2FkZHIgPT4gZmR0X2FkZHJfcg0KPiAJZmR0
X2ZpbGUgPT4gZmR0ZmlsZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVudXMgQmFzIDx5LmJhc0Bw
aHl0ZWMuZGU+DQo+IC0tLQ0KPiDCoC4uLi9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZV9p
bXg4bW0uZW52wqAgfCA1MiArKysrKysrKysrKysrKysrKysrDQo+IMKgaW5jbHVkZS9jb25maWdz
L3BoeWNvcmVfaW14OG1tLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ2IC0tLS0tLS0t
LS0tLS0tLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDQ2IGRlbGV0
aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4
bW0vcGh5Y29yZV9pbXg4bW0uZW52DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tL3BoeWNvcmVfaW14OG1tLmVudg0KPiBiL2JvYXJkL3BoeXRlYy9waHljb3Jl
X2lteDhtbS9waHljb3JlX2lteDhtbS5lbnYNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMDAwMDAuLmIyZjYxODQzOTk1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYm9h
cmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL3BoeWNvcmVfaW14OG1tLmVudg0KPiBAQCAtMCwwICsx
LDUyIEBADQo+ICtjb25zb2xlPXR0eW14YzIsMTE1MjAwDQo+ICtlbW1jX2Rldj0yDQo+ICtmZHRf
YWRkcl9yPTB4NDgwMDAwMDANCj4gK2ZkdGZpbGU9Q09ORklHX0RFRkFVTFRfRkRUX0ZJTEUNCj4g
K2ltYWdlPUltYWdlDQo+ICtpcF9keW49eWVzDQo+ICtsb2FkaW1hZ2U9ZmF0bG9hZCBtbWMgJHtt
bWNkZXZ9OiR7bW1jcGFydH0gJHtsb2FkYWRkcn0gJHtpbWFnZX0NCj4gK2xvYWRmZHQ9ZmF0bG9h
ZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0gJHtmZHRfYWRkcl9yfSAke2ZkdGZpbGV9DQo+ICtt
bWNhcmdzPQ0KPiArCXNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29sZX0NCj4gKwlyb290
PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0gcm9vdHdhaXQgcncNCj4gK21tY2F1dG9k
ZXRlY3Q9eWVzDQo+ICttbWNib290PQ0KPiArCWVjaG8gQm9vdGluZyBmcm9tIG1tYyAuLi47DQo+
ICsJcnVuIG1tY2FyZ3M7DQo+ICsJaWYgcnVuIGxvYWRmZHQ7IHRoZW4NCj4gKwkJaWYgdGVzdCAk
e2RvZml0Ym9vdH0gPSAxOyB0aGVuDQo+ICsJCQlib290aSAke2xvYWRhZGRyfSAtICR7ZmR0X2Fk
ZHJfcn0NCj4gKwkJZWxzZQ0KPiArCQkJZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUgRFQ7DQo+
ICsJCWZpOw0KPiArCWZpOw0KPiArbW1jZGV2PUNPTkZJR19TWVNfTU1DX0VOVl9ERVYNCj4gK21t
Y3BhcnQ9MQ0KPiArbW1jcm9vdD0yDQo+ICtuZXRhcmdzPQ0KPiArCXNldGVudiBib290YXJncyBj
b25zb2xlPSR7Y29uc29sZX0gcm9vdD0vZGV2L25mcyBpcD1kaGNwDQo+ICsJbmZzcm9vdD0ke3Nl
cnZlcmlwfToke25mc3Jvb3R9LHYzLHRjcA0KPiArbmV0Ym9vdD0NCj4gKwllY2hvIEJvb3Rpbmcg
ZnJvbSBuZXQgLi4uOw0KPiArCWlmIHRlc3QgJHtpcF9keW59ID0geWVzOyB0aGVuDQo+ICsJCXNl
dGVudiBnZXRfY21kIGRoY3A7DQo+ICsJZWxzZQ0KPiArCQlzZXRlbnYgZ2V0X2NtZCB0ZnRwOw0K
PiArCWZpOw0KPiArCSR7Z2V0X2NtZH0gJHtsb2FkYWRkcn0gJHtpbWFnZX07DQo+ICsJcnVuIG5l
dGFyZ3M7DQo+ICsJaWYgJHtnZXRfY21kfSAke2ZkdF9hZGRyX3J9ICR7ZmR0ZmlsZX07IHRoZW4N
Cj4gKwkJYm9vdGkgJHtsb2FkYWRkcn0gLSAke2ZkdF9hZGRyX3J9Ow0KPiArCWVsc2UNCj4gKwkJ
ZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUgRFQ7DQo+ICsJZmk7DQo+ICtuZnNyb290PS9zcnYv
bmZzDQo+ICtzZF9kZXY9MQ0KDQpUaGlzIHVuZXhwbGFpbmVkIGNoYW5nZSBzbnVjayBpbjsgYXQg
bGVhc3QgSSBkb24ndCBzZWUgc2RfZGV2IGRlZmluZWQgYmVmb3JlLiBQbGVhc2UgdXBkYXRlIGNv
bW1pdA0KZGVzY3JpcHRpb24gb3IgcmVtb3ZlIGl0Lg0KDQpZYW5uaWMNCg0KPiArdXBkYXRlX2Jv
b3RpbWc9DQo+ICsJbW1jIGRldiAke21tY2Rldn07DQo+ICsJaWYgZGhjcCAke2xvYWRhZGRyfSAk
e3VwZGF0ZV9maWxlcGF0aH0vJHt1cGRhdGVfZmlsZW5hbWV9OyB0aGVuDQo+ICsJCXNldGV4cHIg
Zndfc3ogJHtmaWxlc2l6ZX0gLyAweDIwMDsNCj4gKwkJbW1jIHdyaXRlICR7bG9hZGFkZHJ9ICR7
dXBkYXRlX29mZnNldH0gJHtmd19zen07DQo+ICsJZmk7DQo+ICt1cGRhdGVfZmlsZW5hbWU9Zmxh
c2guYmluDQo+ICt1cGRhdGVfb2Zmc2V0PTB4NDINCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29u
Zmlncy9waHljb3JlX2lteDhtbS5oIGIvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgN
Cj4gaW5kZXggZTc0YTNmMTg0YzYuLjIwZTJhYjgzMmVlIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaA0KPiArKysgYi9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29y
ZV9pbXg4bW0uaA0KPiBAQCAtMjAsNTIgKzIwLDYgQEANCj4gwqAvKiBGb3IgUkFXIGltYWdlIGdp
dmVzIGEgZXJyb3IgaW5mbyBub3QgcGFuaWMgKi8NCj4gwqAjZW5kaWYNCj4gwqANCj4gLSNkZWZp
bmUgQ0ZHX0VYVFJBX0VOVl9TRVRUSU5HUyBcDQo+IC0JImltYWdlPUltYWdlXDAiIFwNCj4gLQki
Y29uc29sZT10dHlteGMyLDExNTIwMFwwIiBcDQo+IC0JImZkdF9hZGRyPTB4NDgwMDAwMDBcMCIg
XA0KPiAtCSJmZHRfZmlsZT0iIENPTkZJR19ERUZBVUxUX0ZEVF9GSUxFICJcMCIgXA0KPiAtCSJp
cF9keW49eWVzXDAiIFwNCj4gLQkibW1jZGV2PSIgX19zdHJpbmdpZnkoQ09ORklHX1NZU19NTUNf
RU5WX0RFVikgIlwwIiBcDQo+IC0JIm1tY3BhcnQ9MVwwIiBcDQo+IC0JIm1tY3Jvb3Q9MlwwIiBc
DQo+IC0JInVwZGF0ZV9vZmZzZXQ9MHg0MlwwIiBcDQo+IC0JInVwZGF0ZV9maWxlbmFtZT1mbGFz
aC5iaW5cMCIgXA0KPiAtCSJ1cGRhdGVfYm9vdGltZz0iCQkJCQkJXA0KPiAtCQkibW1jIGRldiAk
e21tY2Rldn0gOyAiCQlcDQo+IC0JCSJpZiBkaGNwICR7bG9hZGFkZHJ9ICR7dXBkYXRlX2ZpbGVw
YXRofS8ke3VwZGF0ZV9maWxlbmFtZX0gOyB0aGVuICIJXA0KPiAtCQkic2V0ZXhwciBmd19zeiAk
e2ZpbGVzaXplfSAvIDB4MjAwIDsgIgkvKiBTRCBibG9jayBzaXplICovIFwNCj4gLQkJIm1tYyB3
cml0ZSAke2xvYWRhZGRyfSAke3VwZGF0ZV9vZmZzZXR9ICR7Zndfc3p9IDsgIglcDQo+IC0JCSJm
aVwwIiBcDQo+IC0JIm1tY2F1dG9kZXRlY3Q9eWVzXDAiIFwNCj4gLQkibW1jYXJncz1zZXRlbnYg
Ym9vdGFyZ3MgY29uc29sZT0ke2NvbnNvbGV9ICIgXA0KPiAtCQkicm9vdD0vZGV2L21tY2JsayR7
bW1jZGV2fXAke21tY3Jvb3R9IHJvb3R3YWl0IHJ3XDAiIFwNCj4gLQkibG9hZGltYWdlPWZhdGxv
YWQgbW1jICR7bW1jZGV2fToke21tY3BhcnR9ICR7bG9hZGFkZHJ9ICR7aW1hZ2V9XDAiIFwNCj4g
LQkibG9hZGZkdD1mYXRsb2FkIG1tYyAke21tY2Rldn06JHttbWNwYXJ0fSAke2ZkdF9hZGRyfSAk
e2ZkdF9maWxlfVwwIiBcDQo+IC0JIm1tY2Jvb3Q9ZWNobyBCb290aW5nIGZyb20gbW1jIC4uLjsg
IiBcDQo+IC0JCSJydW4gbW1jYXJnczsgIiBcDQo+IC0JCSJpZiBydW4gbG9hZGZkdDsgdGhlbiAi
IFwNCj4gLQkJCSJib290aSAke2xvYWRhZGRyfSAtICR7ZmR0X2FkZHJ9OyAiIFwNCj4gLQkJImVs
c2UgIiBcDQo+IC0JCQkiZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUgRFQ7ICIgXA0KPiAtCQki
Zmk7XDAgIiBcDQo+IC0JIm5mc3Jvb3Q9L25mc1wwIiBcDQo+IC0JIm5ldGFyZ3M9c2V0ZW52IGJv
b3RhcmdzIGNvbnNvbGU9JHtjb25zb2xlfSByb290PS9kZXYvbmZzIGlwPWRoY3AgIiBcDQo+IC0J
CSJuZnNyb290PSR7c2VydmVyaXB9OiR7bmZzcm9vdH0sdjMsdGNwXDAiIFwNCj4gLQkibmV0Ym9v
dD1lY2hvIEJvb3RpbmcgZnJvbSBuZXQgLi4uOyAiIFwNCj4gLQkJInJ1biBuZXRhcmdzOyAiIFwN
Cj4gLQkJImlmIHRlc3QgJHtpcF9keW59ID0geWVzOyB0aGVuICIgXA0KPiAtCQkJInNldGVudiBn
ZXRfY21kIGRoY3A7ICIgXA0KPiAtCQkiZWxzZSAiIFwNCj4gLQkJCSJzZXRlbnYgZ2V0X2NtZCB0
ZnRwOyAiIFwNCj4gLQkJImZpOyAiIFwNCj4gLQkJIiR7Z2V0X2NtZH0gJHtsb2FkYWRkcn0gJHtp
bWFnZX07ICIgXA0KPiAtCQkiaWYgJHtnZXRfY21kfSAke2ZkdF9hZGRyfSAke2ZkdF9maWxlfTsg
dGhlbiAiIFwNCj4gLQkJCSJib290aSAke2xvYWRhZGRyfSAtICR7ZmR0X2FkZHJ9OyAiIFwNCj4g
LQkJImVsc2UgIiBcDQo+IC0JCQkiZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUgRFQ7ICIgXA0K
PiAtCQkiZmk7XDAiIFwNCj4gLQ0KPiDCoC8qIExpbmsgRGVmaW5pdGlvbnMgKi8NCj4gwqANCj4g
wqAjZGVmaW5lIENGR19TWVNfSU5JVF9SQU1fQUREUgkweDQwMDAwMDAwDQoNCg==
