Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA4D65C7E
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 12:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43947881E7;
	Thu, 14 Nov 2024 13:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="idbcXy7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E2D88C0F; Thu, 14 Nov 2024 13:08:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A05F80AE6
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCVu+GYB0d4aqBGvj/AEsfK4tDO3GRi9I37Gp3ZcOCt6KUU/Bd3fUGlXghdxpm7rDV29tBahwlx5JINBu0LL4cFMrN2VhcxpyG2YbJGM0FxQgbibgywCgZb2RpC1seKbi05ceD9SRf7DTZ8guHuyn5gWKjr7Dtxxeho5SYhlK0jl2+uU/jhzizX5V276fJCT2weSXttwSnJVSorCzLlkXNvSCz+QavvVzIhBX7jJgCK6m9KlCJzUVYNzqlbWdwEXn0hHaTmmEObSvFcH3fUbC0yWVDqkEuBZMrr5bQzks4p2M1e8eiw8O1HoFi80N0a8DhvhBQ6lyFgj2kVICaC3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ir35oFdkaMs6gr97GvHZ5arI4N5BPP9cwxrD6NtgGA=;
 b=WwDX9E7xH5Sqam8h6Bp7HHJghWT1+lys2nM3Hltptgx2yV0a/5hLwr/fRCA3DK5rqP4eNEsZ2ax4XBZCWf+d95W+aYbj5n/B45F7RfG0gtph3FqwGQyXH/35xuvQq6rTe/0A1oDLbv5ph9ePz3xnJUoxdHa9ANOEspG0yoUnD45PRW7Aq30s+pUM4HnSfsZbGJNqQltK95k54bU6Cc4zxMLM6mG4INHlkgC+TxylC99bDVvOatLCckaCY0ehGIp8yxQSdEFgg+aUglOXNPU3f7AzLrM055VF/z/mit8BYHJPwN9mAuhlHZw16q29E6ScjgTm9eYy8xDFq5pLjnhrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ir35oFdkaMs6gr97GvHZ5arI4N5BPP9cwxrD6NtgGA=;
 b=idbcXy7iPXa+HkegG4/MuFKyLWOez3jKTkgPA3dE9j0Xgnk02qYyhy74I9McopNYUSpYrEmJq2LcRzqFgozzD5XW2rr4b4GUEAUgp7zX63f+0ESd4CWdsTreJHyCRmnXaAbi8UhamIfHXBppVVuSQE1LVfPUuQzNXX7uTMWEThM=
Received: from DU7P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::22)
 by PR3P195MB0666.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 12:08:49 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::b0) by DU7P195CA0012.outlook.office365.com
 (2603:10a6:10:54d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 12:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 12:08:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 13:08:48 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Thu, 14 Nov 2024 13:08:48 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [Upstream] [PATCH v2 0/3] Add support for all variants of the
 phyCORE-i.MX93 SOM
Thread-Topic: [Upstream] [PATCH v2 0/3] Add support for all variants of the
 phyCORE-i.MX93 SOM
Thread-Index: AQHbNeU17+NBuui1XEGnDkxYQotCr7K1jTeAgAESJgA=
Date: Thu, 14 Nov 2024 12:08:48 +0000
Message-ID: <85a51489bcdfbdc9b232b8e71d8b14eae49492ae.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <d4ad41bc-114d-457e-8c5b-58774fad91b6@phytec.de>
In-Reply-To: <d4ad41bc-114d-457e-8c5b-58774fad91b6@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6AA479EDC7354481F11DF6B120411C@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|PR3P195MB0666:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a830704-0994-41e5-d02a-08dd04a51924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3RjV1Q0dGN1dnVEdTF4cy9tWmpaR2w2N3VpdVE4eUU0OEk1TDB6cmdaUTFn?=
 =?utf-8?B?ZHRXb1pLT0pHTEpGdWhLb0RzL2djd1JIMEhERkk3TGpkU2U1WUd3aThsVUQw?=
 =?utf-8?B?cXNDRmRqK1NaSHR0aHdzbjc3cGRzNWlTcEJwNVlTMzVpVXY3OXBYZjBDaVdL?=
 =?utf-8?B?cWVic2pRQlZ4OWc1bTlBeE8ySHg5Zko5QnloaWRxcGd2TXRJTkpmVmFVTmFP?=
 =?utf-8?B?Mlh2NVFNMTBESDRLb2ExN0dmMVR3STF4cGc4NHRFWUhMWXdGYXFyNXpPNWhn?=
 =?utf-8?B?VnZlN1FuTS96aG1TakFIR3loc2puUFovdWZaNVhQQk1hdlNPNkc5SmlJbGNX?=
 =?utf-8?B?Ykw2VjgrSGpFNTY5ZmNpT3FmQ2pWak1SL0NTeUdrMVJCR2g5MmhGT1lCR25z?=
 =?utf-8?B?cEVNdE1jSTcwMmRITkRWY1hlbURDMVJMSG5idW83Mjh1Vkh0SjgvRjRmdHhS?=
 =?utf-8?B?UHZHZ3VXTWM3MVlPQU9TTFRGV0VXUm9lWHBjMVpYVEFBa003dTNpVmw5Rm5K?=
 =?utf-8?B?a2RjV1d3d3BpYXNOaFdYSkpzSXNWZ3hzRE5DOXNXNEpOa0NSVGwxUS9vaXJz?=
 =?utf-8?B?aWNBQWtmRElwcURyUUVaZmx5Nkx2NFpLQTEycEpzUGdkU0JYNzZGWjkzOS8x?=
 =?utf-8?B?Z1htcFJSN1JIZ1Jkd3d5Mm0xSnF3SzFCTmltTU1XRk1oMGQ1b0lwQ1p4L3Vl?=
 =?utf-8?B?WWR1U2t3UVQ2R0tPSkVJNWp4TjhUN0x6Y3hPNEZwOTQ2bFdGbXBFYVpTd1ky?=
 =?utf-8?B?RTR3M005WWFzUVJrQkxVMkxMdkZhZGVSNDFscnlYcFBrc0lNTHd3dkFJbUVj?=
 =?utf-8?B?SjZkaktDMlFjRDRhSkJiTHphS01yM2lmQ283eVhabnhTQnByZWtZeG1Nb1h3?=
 =?utf-8?B?c2ZYUE50bHhnTmlmaVhnN2N2SE9sRktIQkhQcU1EOXJzSnNVa25zRmg1emtm?=
 =?utf-8?B?ajQ0Vkszb3gyd29BNzlURWdDUzJTdlVMdVMxczliaVVpVjlkaFhpRE5PcENn?=
 =?utf-8?B?Nlh4TDVuaVJCMUdVcndNRU1kWnlIa2FSbjRtQlZlTG04d3pXUlB6OG1oV2x2?=
 =?utf-8?B?UUFVN01CczFwRzgyS0JKTU5RZGx4aFJWcnRnbDFiK2krbmFHMmFkOUd5bXZJ?=
 =?utf-8?B?dkYrejlMcE91aE9ING1ST3pqOTBmVVdGclFQME8rYURPYlJOQ2JPZ0ZseWlL?=
 =?utf-8?B?UEdFVDhFZUtvdVlBUGZ3RjBUVEhmbkJzRGlBa1VJUVRzM21nZ2hweFhyY2No?=
 =?utf-8?B?bk1uUUQ4Z3NLUGVYdWI5NGtqVHZHdnhFRlRPdmc3VE1wRk5OZjZTMFZWSEx1?=
 =?utf-8?B?UkVJYStDaGpENEVpNkJrSC9KL01BVE1md0ppY0JHdU1CNEFPTGpYYzFMRU4r?=
 =?utf-8?B?UXlWNGtxSVBwQWxYb0UrSVRqSnZnN0ZIaHo0QkdtL1BDUHRqQlJqdVEwc2c3?=
 =?utf-8?B?cHUzK2tFU293cVNqTVhTemV0TC9USUxzUlN0djAvYXIxemt5QkM5VVg1UFlk?=
 =?utf-8?B?eFgzYmZvOW0vekNpVU4yc1FGUjl1Q0pDd1JQL2lSMHlXWXhOK0dYTUZQTExn?=
 =?utf-8?B?ZlFYN2RXdTkvbWFTbW1HYmppdmhXdEplZUJSRXZoaTVxNDBVVEFSQkxOa3li?=
 =?utf-8?B?SkpNREF6OXNaZEoyNW5CRVJPMkpyaThmSm92bklWeVoyK25tTnhpdVVobGpo?=
 =?utf-8?B?aDMzMzdCdlNWVm9zSGNPZFBjQ1BwUjZpQ2laYU9KdzZnYTAvM1ZyMXRqQTMv?=
 =?utf-8?B?ZTM5eU5ST2pmd1d5YlVXdkRMNHZ4dVhibEd5c2h3dlVKT0k2dzNrZC8xNjRn?=
 =?utf-8?B?VWduRXB5WXUwWXRqSEZHM3hDelVqanRrb3BZWWFEM29VUXllc0NqZ3VhMUpW?=
 =?utf-8?B?MlBCVXhJRm93RkF6ZzAwYVBhLzhCek80V2l6UVFrMUFuVnc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 12:08:49.3811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a830704-0994-41e5-d02a-08dd04a51924
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0666
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

DQoNCk9uIE1pLCAyMDI0LTExLTEzIGF0IDIwOjQ3ICswMTAwLCBXYWRpbSBFZ29yb3Ygd3JvdGU6
DQo+IA0KPiANCj4gQW0gMTMuMTEuMjQgdW0gMTc6MDAgc2NocmllYiBDaHJpc3RvcGggU3RvaWRu
ZXI6DQo+ID4gVGhlIHBoeUNPUkUtaS5NWCA5MyBpcyBhdmFpbGFibGUgaW4gdmFyaW91cyB2YXJp
YW50cyAoZS5nLg0KPiA+IGRpZmZlcmVudCByYW0NCj4gPiBzaXplcywgZU1NQyBIUzQwMCB5ZXMv
bm8pLiBJdCdzIGVlcHJvbSBjb250YWlucyBpbmZvcm1hdGlvbiB3aGljaA0KPiA+IGZlYXR1cmVz
DQo+ID4gdGhlIGV4aXN0aW5nIG1vZHVsZSBzdXBwb3J0cy4NCj4gPiANCj4gPiBFeHRlbmQgdGhl
IGV4aXN0aW5nIGJvYXJkLWNvZGUgdG8gc3VwcG9ydCBhbGwgdGhlIFNPTSB2YXJpYW50cy4gVGhl
DQo+ID4gc3BsL3UtYm9vdA0KPiA+IGV2YWx1YXRlcyB0aGUgZWVwcm9tIGluZm9ybWF0aW9uIGFu
ZCBlbmFibGVzIHN1cHBvcnRlZCBmZWF0dXJlcw0KPiA+IGFjY29yZGluZ2x5Lg0KPiA+IFRoZSBy
ZXN1bHRpbmcgc3BsIGFuZCB1LWJvb3QgYmluYXJ5IGlzIGFibGUgdG8gYm9vdCBlYWNoIHBoeUNP
UkUtDQo+ID4gaS5NWCA5MyBTT00NCj4gPiB2YXJpYW50IG9uIGVhY2ggY2FycmllciBib2FyZC4N
Cj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IA0KPiA+IHBhdGNoICMxOg0KPiA+IC0gcmVt
b3ZlIG11bHRpcGxlIGJsYW5rIGxpbmVzDQo+ID4gLSBhZGQgdXBkYXRlIG9mIDFHQiByYW0gdGlt
aW5ncyB0byBjb21taXQgbWVzc2FnZQ0KPiA+IA0KPiA+IHBhdGNoICMyOg0KPiA+IC0gZW5jYXBz
dWxhdGUgaGFuZGxpbmcgb2YgZmVhdHVyZSBmbGFnIFZPTFRBR0UgaW50byBvd24gZnVuY3Rpb24N
Cj4gPiAtIG1vdmUgZGVmaW5pdGlvbiBvZiBlbnVtIHBoeXRlY19pbXg5M19kZHJfZWVwcm9tX2Nv
ZGUgaW50byBoZWFkZXINCj4gPiBmaWxlDQo+ID4gDQo+ID4gcGF0Y2ggIzM6DQo+ID4gLSBqdXN0
IHJlbmFtZSBpbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcgYW5kIGFkZCBuZWVkZWQNCj4g
PiBDT05GSUdzLA0KPiA+IMKgwqAgaW5zdGVhZCBvZiBjcmVhdGluZyBhbiBlbnRpcmVseSBuZXcg
c2Vjb25kIGRlZmNvbmZpZw0KPiANCj4gRG9uJ3QgZm9yZ2V0IHRvIHVwZGF0ZSB0aGUgZG9jcyAi
QnVpbGQgVS1Cb290IiBjaGFwdGVyIG1lbnRpb25pbmcgdGhlDQo+IG5ldyBkZWZjb25maWcuDQoN
Ckdvb2QgcG9pbnQsIHRoYW5rcyEgSSB3aWxsIGFkZCB0aGF0IGluIHRoZSB2My4NCg0KPiANCj4g
DQo+ID4gLSByZW1vdmUgd3JvbmcgY29tbWVudCBmcm9tIGlteDkzLXBoeWJvYXJkLXNlZ2luLXUt
Ym9vdC5kdHNpDQo+ID4gLSBpbXByb3ZlIGNvbW1pdCBtZXNzYWdlDQo+ID4gDQo+ID4gQ2hyaXN0
b3BoIFN0b2lkbmVyICgzKToNCj4gPiDCoMKgIGJvYXJkOiBwaHl0ZWM6IHBoeWNvcmUtaW14OTM6
IEFkZCAyR0IgTFBERFI0WCBSQU0gdGltaW5ncw0KPiA+IMKgwqAgYm9hcmQ6IHBoeXRlYzogaW14
OTM6IEFkZCBlZXByb20tYmFzZWQgaGFyZHdhcmUgaW50cm9zcGVjdGlvbg0KPiA+IMKgwqAgYm9h
cmQ6IHBoeXRlYzogaW14OTM6IEFkZCBwaHlDT1JFLWkuTVggOTMgc3VwcG9ydCBmb3IgYWxsIFNP
TQ0KPiA+IHZhcmlhbnRzDQo+ID4gDQo+ID4gwqAgYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJk
LXNlZ2luLXUtYm9vdC5kdHNpIHzCoCAyNSArLQ0KPiA+IMKgIGFyY2gvYXJtL21hY2gtaW14L2lt
eDkvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsNCj4gPiDC
oCBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3NvYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAyICstDQo+ID4gwqAgYm9hcmQvcGh5dGVjL2NvbW1vbi9LY29uZmlnwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDggKw0KPiA+IMKgIGJvYXJk
L3BoeXRlYy9jb21tb24vTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEgKw0KPiA+IMKgIGJvYXJkL3BoeXRlYy9jb21tb24vaW14OTNfc29tX2RldGVjdGlv
bi5jwqDCoMKgwqAgfCAxMTEgKysrDQo+ID4gwqAgYm9hcmQvcGh5dGVjL2NvbW1vbi9pbXg5M19z
b21fZGV0ZWN0aW9uLmjCoMKgwqDCoCB8wqAgNTEgKysNCj4gPiDCoCBib2FyZC9waHl0ZWMvcGh5
Y29yZV9pbXg5My9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjggKw0KPiA+IMKg
IGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJTwqDCoMKgwqDCoMKgwqAgfMKg
wqAgNyArLQ0KPiA+IMKgIGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL2xwZGRyNF90aW1pbmcu
Y8KgwqDCoCB8IDc5Mw0KPiA+ICsrKysrKysrKysrKysrKystLQ0KPiA+IMKgIGJvYXJkL3BoeXRl
Yy9waHljb3JlX2lteDkzL3BoeWNvcmUtaW14OTMuY8KgwqDCoCB8wqAgNTEgKysNCj4gPiDCoCBi
b2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9zcGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA0OCArKw0KPiA+IMKgIC4uLmVnaW5fZGVmY29uZmlnID0+IGlteDkzLXBoeWNvcmVfZGVm
Y29uZmlnfSB8wqDCoCA0ICstDQo+ID4gwqAgMTMgZmlsZXMgY2hhbmdlZCwgMTA2NCBpbnNlcnRp
b25zKCspLCA2NyBkZWxldGlvbnMoLSkNCj4gPiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYm9hcmQv
cGh5dGVjL2NvbW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmMNCj4gPiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgYm9hcmQvcGh5dGVjL2NvbW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmgNCj4gPiDCoCBy
ZW5hbWUgY29uZmlncy97aW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnID0+IGlteDkzLQ0K
PiA+IHBoeWNvcmVfZGVmY29uZmlnfSAoOTglKQ0KPiA+IA0KPiANCg==
