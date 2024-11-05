Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E9AD2B925
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 13:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E87884DB;
	Tue,  5 Nov 2024 14:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Z2OQS0Qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7260A88FCC; Tue,  5 Nov 2024 14:30:17 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4729188360
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE15IJu3qwRcbZU9EQybwqO/7Vmmh+RSrivsrGj4JU7GOI0eLlmT80rHM9Etof8co6F+IHHSUb9+m/i/CKQ5ji2VNGko4mEvleAVhMLyaSemawJHMohHYfI6JQH/g7/hAesVzr9xP5xz3OLv84apI1XyCLOAbnedVTQEInHJlkMIRaHQK4jR00boA+mWYZAHdeLEfJ5zgneDFyEs7PT3/utOYXdJkdC2afUp4hJ/oqOAaW/UhD8X/Jg/JplGLGkpv5I6RyHnPmi8THR6IpZHVmfmu8w/mt9IXokUIYBF4iVI52pslZX0JSu9lMban5Y0CXGzpr8Y+mpYr0dZimnvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D6UZZnG9Xps35aF+niPaPWRWPo0Jpg6uGpwcuZR7PY=;
 b=BZhi9DydXh5qvX48IFnG7z1OD/mt5tzympG2E2HZMx1QqOfOx+xPZekTev7T5vdQsyyiTzHJ2iddR/X37O0NGjNzJnfRGqQmFoVPDHbVgB6xBYhgSSab52Kt85gFVApF3tyeqVFyRosnVPiCNcfxdRJcPmJ7frLUonx+8UGaXD82CzAmJEty+rIFRdgx0x/8kEzn+v6+0HOTeZ0E7gwvPSwDkMDIfbxZKk5rXwaZ71EPdxtDt5VYQjVTclWrsi27sNMqMOzbxTUPcqWCEJV3+aXvXUkMajW7y0eMoYNhWmT/eH2EanSBZwyUexzZVLELCejCifB2UD+yWlaLgYUfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D6UZZnG9Xps35aF+niPaPWRWPo0Jpg6uGpwcuZR7PY=;
 b=Z2OQS0Qja8Yx6XqubxHZDMIQzgnd0yotOzYuq8YEHx7zt6Ztj2zwpx7p1w9dKZ5qUtsnCQPRq550OTp6FK+BshhfdfQP6FZ2dqnh2Z+6e/MJoDXf2o0Y0WCtsGN+vS4w47O6u6a6pV4GxujaYCs0J0APUluBkFA5dc478v/m6nk=
Received: from DB8PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:10:be::39)
 by GV1P195MB1738.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 13:30:11 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::fa) by DB8PR03CA0026.outlook.office365.com
 (2603:10a6:10:be::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 13:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 13:30:10 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 5 Nov 2024
 14:30:10 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Tue, 5 Nov 2024 14:30:10 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [Upstream] [PATCH 2/3] board: phytec: imx93: Add eeprom-based
 hardware introspection
Thread-Topic: [Upstream] [PATCH 2/3] board: phytec: imx93: Add eeprom-based
 hardware introspection
Thread-Index: AQHbLqZIvv266aOuJkWDkvpHpV4VzrKnE+0AgAGLrYA=
Date: Tue, 5 Nov 2024 13:30:10 +0000
Message-ID: <f0b80fc78a1bf46ab0552c43adbb5bf9fc5980ec.camel@phytec.de>
References: <20241104104148.748331-1-c.stoidner@phytec.de>
 <20241104104148.748331-3-c.stoidner@phytec.de>
 <aa8f4b25-64f2-4ad1-9cc0-db1ed96cbc58@phytec.de>
In-Reply-To: <aa8f4b25-64f2-4ad1-9cc0-db1ed96cbc58@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <625A331B9716B547B3CB22068B918B18@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|GV1P195MB1738:EE_
X-MS-Office365-Filtering-Correlation-Id: 34666e9f-0655-4a39-b8b2-08dcfd9df8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWR1bDlheVg1WkIyMFVJcFhBby9OcUhiblhWN0k4TDczU0xjTTRXUjEyUm5u?=
 =?utf-8?B?SFg1c3pwNDhGb1Zwc3lWM3ZFOFFZbVFZMXpKakUxVGtKaGMwaWhhM1NJeFdC?=
 =?utf-8?B?aHJxdkJZNVB1TFZoalFnNTI1dm1kei8zTHBIRmZ1Zk5kNmtJQlU5UGJLamZE?=
 =?utf-8?B?cktWMUk2UFZCZjFsdmRPYzI5TTVPZlI1OGhaRXJLcldlb004UXA5WkwxT0Jy?=
 =?utf-8?B?R2lxUHdEZTlrcVJiSU5ucUZab2tLb0RZRXFXaUdJK0NSdXFQMndYbXYzMExC?=
 =?utf-8?B?S0syMFh4NDBWOEdKanVoSDA2bGx3bExPbWJScXJqamdVWDhVd3VJMDk4N1A0?=
 =?utf-8?B?TXNHR0F6UEx3QkJKSjluR0JvdTIwbU9rOGw0MUZ0VEVJa3ZjSUZobXpqbXFG?=
 =?utf-8?B?dDIvN2VwWlpuVGc4UWRmaE9VeWJrQmdHWWttY1g0UFhyNHJFSXBuTzBLRk9Q?=
 =?utf-8?B?Ykt1azV0aGJlYkN6SC9zVS9KU2crLzNpejFIamJQQmp0K29WeEU4MUlxcENr?=
 =?utf-8?B?dmJuN0k2RmZlUzFoMGRvVVZYa2JpbGd4YzhNb2dKQVE3L1BRZ3pSWDB5djdG?=
 =?utf-8?B?TmZjY1dBY1hsYTFncVBlZUtic2lHb1gyTjFYZGMza2ZVcHZCTnVVT2NFUkRz?=
 =?utf-8?B?dnNYdHl6N2s5YkRaTHdUeGxkYzhPbDFRbHd4UHQ3clZzWUN1RGxDQktiQUto?=
 =?utf-8?B?cW1mYnhrUUVSc2EwTEo3aFNYcEl3NUZsTzJpUnNHeEZkdmkwZGVnZVRnN3Y1?=
 =?utf-8?B?bW02VUl0ZU9aSERHblExbVhaQy9TeWtRN0tOM1YvQlBKdnF3RnVLaFh3ckZw?=
 =?utf-8?B?MENRR0JqUkQwTWZBYXV3SWhBdVpqalI1VUcyUW9OOE1WQUtjOVVmR3c5dkZ2?=
 =?utf-8?B?UU53YWpwZFNJak9jeVNLQzZDdFFFaEZkUnBiNVBkVDRPV2swYzJ4NVE0TjRG?=
 =?utf-8?B?QXpKU0lQeFloSStiQzFDaWdxRTVGNEhXeHJCTFdHejhzM0Joa1NQcVQzekgw?=
 =?utf-8?B?NGNXNGZYVG5zWlpVL0l0Q1NYTjBPSHJmTnczL1BKSXVGMHNLaVp6eXVjNU5S?=
 =?utf-8?B?YVUrNWU3c1YxVTRITnlmWnE4RGw5T00vc3Z2V08zaHgrbWpLNlAyVEdFd3RK?=
 =?utf-8?B?L1dYbkN2TTc4UUxQZkxtSFd4SGc0QU4zbWIxZTBDNUZqVzNlMVIxdlg0V1ZU?=
 =?utf-8?B?SG1rQlYzSWNDYUF0R05yRVgwUG03akFyVW90cGhtenJxbmtUeGg4S3hWeEgr?=
 =?utf-8?B?M0krR28ydk4zeTVHZ2pkZUVuM1FtTGVLSlhHWVRERUpwUTlJNk1WakswVjgr?=
 =?utf-8?B?WHBwL29reFRtTmVqMjRKaVZhT3dPTlZ1TjQwSExSV1dPNGwwVHBsTnlQdWJq?=
 =?utf-8?B?YlR4MjQ1M3VGMmEwUlRHVDVDVWVYTW1XWmJSMUhxL0Z3clMzb0FMYzlhc3FS?=
 =?utf-8?B?ZUdzQVNjUTlMQklnOFhlMFpBbkpOVkhIUTNFdFZOR1lWbmtTT1FYRUJXY2tu?=
 =?utf-8?B?Rk5rS1hJZEh1bXN5RHZLdm1oV25zejdzYXVKamdhbFRLVHZKSzhib1Ftd3Er?=
 =?utf-8?B?TmU0Y29uZWc3clJnMGpiRC9JaVlMOTVIK2JLRmNZcG5Uam45cFFCejV3U05z?=
 =?utf-8?B?eW8yQkU3enhTSm9WZFlhTDNFTDNkTEFPbTE4NzhOTGNndGZFZVkzTjRKdVAx?=
 =?utf-8?B?aHVFWnZCaElZT0hicDdoY1FZTFN5aTlTOGJmNDBBaXA4cFR3TmV6RFlBck5Y?=
 =?utf-8?B?VlpoVE5oTkJHcVJrbmtaREwrUHJXUjVsS2xyZVlTWUNqN3FnR3h0bnFGNnN5?=
 =?utf-8?B?QkJONGVrSTh6a1ptNUhnbjkwQ1F0QkN1eVM2SXB1TFRQTW10ZHNla1lZU0hR?=
 =?utf-8?B?QkpDdklTcXh0OURpSUIzN1Y2bWE3S3hFUTRPTlpBeE9vdHc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 13:30:10.5722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34666e9f-0655-4a39-b8b2-08dcfd9df8d7
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1738
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

SGkgV2FkbWluLAoKT24gTW8sIDIwMjQtMTEtMDQgYXQgMTQ6NTMgKzAxMDAsIFdhZGltIEVnb3Jv
diB3cm90ZToKPiBIaSBDaHJpc3RvcGgsCj4gCj4gQW0gMDQuMTEuMjQgdW0gMTE6NDEgc2Nocmll
YiBDaHJpc3RvcGggU3RvaWRuZXI6Cj4gPiBUaGUgcGh5Q09SRS1pLk1YIDkzIGlzIGF2YWlsYWJs
ZSBpbiB2YXJpb3VzIHZhcmlhbnRzLiBSZWxldmFudAo+ID4gdmFyaWFudAo+ID4gb3B0aW9ucyBm
b3IgdGhlIHNwbC91LWJvb3QgYXJlOgo+ID4gLSB3aXRoIG9yIHdpdGhvdXQgSFM0MDAgc3VwcG9y
dCBmb3IgdGhlIGVNTUMKPiA+IC0gd2l0aCAxR0IgcmFtIGNoaXAsIG9yIDJHQiByYW0gY2hpcAo+
ID4gCj4gPiBUaGUgcGh5Q09SRSdzIGVlcHJvbSBjb250YWlucyBhbGwgaW5mb3JtYXRpb24gYWJv
dXQgdGhlIGV4aXN0aW5nCj4gPiB2YXJpYW50Cj4gPiBvcHRpb25zLiBBZGQgZXZhbHVhdGlvbiBv
ZiB0aGUgZWVwcm9tIGRhdGEgdG8gdGhlIHNwbC91LWJvb3QgdG8KPiA+IGVuYWJsZS9kaXNhYmxl
IEhTNDAwIGFuZCB0byBzZWxlY3QgdGhlIGFwcHJvcHJpYXRlIHJhbQo+ID4gY29uZmlndXJhdGlv
biBhdAo+ID4gc3RhcnR1cC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIFN0b2lk
bmVyIDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4KPiAKPiA8c25pcD4KPiAKPiA+IC0tLSBhL2JvYXJk
L3BoeXRlYy9waHljb3JlX2lteDkzL3BoeWNvcmUtaW14OTMuYwo+ID4gKysrIGIvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OTMvcGh5Y29yZS1pbXg5My5jCj4gPiBAQCAtMyw2ICszLDcgQEAKPiA+
IMKgwqAgKiBDb3B5cmlnaHQgKEMpIDIwMjMgUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkgKPiA+IMKg
wqAgKiBBdXRob3I6IENocmlzdG9waCBTdG9pZG5lciA8Yy5zdG9pZG5lckBwaHl0ZWMuZGU+Cj4g
PiDCoMKgICogQ29weXJpZ2h0IChDKSAyMDI0IE1hdGhpZXUgT3RoYWNlaGUgPG0ub3RoYWNlaGVA
Z21haWwuY29tPgo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBQSFlURUMgTWVzc3RlY2huaWsg
R21iSAo+ID4gwqDCoCAqLwo+ID4gwqAgCj4gPiDCoCAjaW5jbHVkZSA8YXNtL2FyY2gtaW14OS9j
Y21fcmVncy5oPgo+ID4gQEAgLTEyLDExICsxMywyMSBAQAo+ID4gwqAgI2luY2x1ZGUgPGFzbS9n
bG9iYWxfZGF0YS5oPgo+ID4gwqAgI2luY2x1ZGUgPGFzbS9tYWNoLWlteC9ib290X21vZGUuaD4K
PiA+IMKgICNpbmNsdWRlIDxlbnYuaD4KPiA+ICsjaW5jbHVkZSA8ZmR0X3N1cHBvcnQuaD4KPiA+
ICsKPiA+ICsjaW5jbHVkZSAiLi4vY29tbW9uL2lteDkzX3NvbV9kZXRlY3Rpb24uaCIKPiA+IMKg
IAo+ID4gwqAgREVDTEFSRV9HTE9CQUxfREFUQV9QVFI7Cj4gPiDCoCAKPiA+ICsjZGVmaW5lIEVF
UFJPTV9BRERSwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDUwCj4gPiArCj4gPiDCoCBpbnQgYm9h
cmRfaW5pdCh2b2lkKQo+ID4gwqAgewo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCA9IHBoeXRl
Y19lZXByb21fZGF0YV9zZXR1cChOVUxMLCAyLCBFRVBST01fQUREUik7Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBy
aW50ZigiJXM6IEVFUFJPTSBkYXRhIGluaXQgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7Cj4gPiArCj4g
PiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiDCoCB9Cj4gPiDCoCAKPiA+IEBAIC00MCwz
ICs1MSw0NCBAQCBpbnQgYm9hcmRfbGF0ZV9pbml0KHZvaWQpCj4gPiDCoCAKPiA+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gMDsKPiA+IMKgIH0KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBlbW1jX2Zp
eHVwKHZvaWQgKmJsb2IsIHN0cnVjdCBwaHl0ZWNfZWVwcm9tX2RhdGEKPiA+ICpkYXRhKQo+ID4g
K3sKPiA+ICvCoMKgwqDCoMKgwqDCoHU4IG9wdGlvbiA9IHBoeXRlY19pbXg5M19nZXRfb3B0KGRh
dGEsCj4gPiBQSFlURUNfSU1YOTNfT1BUX0ZFQVQpOwo+IAo+IEkgYW0gdGhpbmtpbmcgYWJvdXQg
ZnV0dXJlIFNvTXMgdXNpbmcgc2ltaWxhciB2YXJpYW50cy4KPiAKPiAKPiAKPiA+ICvCoMKgwqDC
oMKgwqDCoGludCBvZmZzZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAob3B0aW9uID09
IFBIWVRFQ19FRVBST01fSU5WQUwpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBlcnI7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBDaGVjayAiSU8gVm9sdGFnZSAx
djgiIGZsYWcgaXMgc2V0ICovCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAob3B0aW9uICYgMHgwMSkg
ewo+IElmIHlvdSBhYnN0cmFjdCBhd2F5IHRoZSBvcHRpb24gZGV0YWlscyBpbnRvIGFuIG93biBm
dW5jdGlvbiwgZS5nLiAKPiBwaHl0ZWNfZ2V0X2lteDkzX2lvX3ZvbHQoKSwgeW91IGNvdWxkIHJl
ZHVjZSB0aGUgYW1vdW50IG9mIGNvZGUgaW4KPiB5b3VyIAo+IGJvYXJkIGZpbGVzLiBBbHNvLCBp
ZiBTb01zIGNoYW5nZSB0aGUgb3B0aW9uIGxheW91dHMgZm9yIGEgc3BlY2lmaWMgCj4gZGV0YWls
IChmb3Igd2hhdGV2ZXIgcmVhc29uKSwgeW91IHdvdWxkIGhhdmUgYW4gYWJzdHJhY3Rpb24gbGF5
ZXIgdG8gCj4gZGV0YWlscyB3aXRoIGl0Lgo+IAoKWWVzLCB0aGF0IG1pZ2h0IG1ha2Ugc2Vuc2Uu
IEkgd2lsbCBzZW5kIGEgdjIgZm9yIGl0LgoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBvZmZzZXQgPSBmZHRfbm9kZV9vZmZzZXRfYnlfY29tcGF0X3JlZyhibG9iLAo+ID4gImZz
bCxpbXg5My11c2RoYyIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAweDQyODUwMDAwKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAob2Zmc2V0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBmZHRfZGVscHJvcChibG9iLCBvZmZzZXQsICJuby0xLTgtdiIpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gPiArwqDCoMKgwqDCoMKgwqB9
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gPiArZXJyOgo+ID4gK8KgwqDCoMKg
wqDCoMKgcHJpbnRmKCJDb3VsZCBub3QgZGV0ZWN0IGVNTUMgVkRELUlPLiBGYWxsIGJhY2sgdG8K
PiA+IGRlZmF1bHQuXG4iKTsKPiA+ICt9Cj4gPiArCj4gPiAraW50IGJvYXJkX2ZpeF9mZHQodm9p
ZCAqYmxvYikKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGh5dGVjX2VlcHJvbV9k
YXRhIGRhdGE7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBwaHl0ZWNfZWVwcm9tX2RhdGFfc2V0
dXAoJmRhdGEsIDIsIEVFUFJPTV9BRERSKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGVtbWNf
Zml4dXAoYmxvYiwgJmRhdGEpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4g
PiArfQo+ID4gKwo+ID4gK2ludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpibG9iLCBzdHJ1Y3QgYmRf
aW5mbyAqYmQpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgZW1tY19maXh1cChibG9iLCBOVUxM
KTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gK30KPiA+IGRpZmYgLS1n
aXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9zcGwuYwo+ID4gYi9ib2FyZC9waHl0ZWMv
cGh5Y29yZV9pbXg5My9zcGwuYwo+ID4gaW5kZXggMTdhODczNmM3My4uY2Y5Yzk0ZWI0NSAxMDA2
NDQKPiA+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL3NwbC5jCj4gPiArKysgYi9i
b2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9zcGwuYwo+ID4gQEAgLTMsNiArMyw3IEBACj4gPiDC
oMKgICogQ29weXJpZ2h0IChDKSAyMDIzIFBIWVRFQyBNZXNzdGVjaG5payBHbWJICj4gPiDCoMKg
ICogQXV0aG9yOiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPgo+ID4g
wqDCoCAqIENvcHlyaWdodCAoQykgMjAyNCBNYXRoaWV1IE90aGFjZWhlIDxtLm90aGFjZWhlQGdt
YWlsLmNvbT4KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgUEhZVEVDIE1lc3N0ZWNobmlrIEdt
YkgKPiA+IMKgwqAgKi8KPiA+IMKgIAo+ID4gwqAgI2luY2x1ZGUgPGFzbS9hcmNoL2Nsb2NrLmg+
Cj4gPiBAQCAtMjAsNiArMjEsOCBAQAo+ID4gwqAgI2luY2x1ZGUgPHBvd2VyL3BjYTk0NTAuaD4K
PiA+IMKgICNpbmNsdWRlIDxzcGwuaD4KPiA+IMKgIAo+ID4gKyNpbmNsdWRlICIuLi9jb21tb24v
aW14OTNfc29tX2RldGVjdGlvbi5oIgo+ID4gKwo+ID4gwqAgREVDTEFSRV9HTE9CQUxfREFUQV9Q
VFI7Cj4gPiDCoCAKPiA+IMKgIC8qCj4gPiBAQCAtMjcsNiArMzAsMTMgQEAgREVDTEFSRV9HTE9C
QUxfREFUQV9QVFI7Cj4gPiDCoMKgICogd2hlbiBwY2E5NDUxYSBzdXBwb3J0IGlzIGFkZGVkLgo+
ID4gwqDCoCAqLwo+ID4gwqAgI2RlZmluZSBQQ0E5NDUwX1JFR19QV1JDVFJMX1RPRkZfREVCwqDC
oMKgIEJJVCg1KQo+ID4gKyNkZWZpbmUgRUVQUk9NX0FERFLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDB4NTAKPiA+ICsKPiA+ICsvKgo+ID4gKyAqIFByb3RvdHlwZXMgb2YgYXV0b21hdGljYWxseSBn
ZW5lcmF0ZWQgcmFtIGNvbmZpZyBmaWxlCj4gPiArICovCj4gPiArdm9pZCBzZXRfZHJhbV90aW1p
bmdzXzJnYl9scGRkcjR4KHZvaWQpOwo+ID4gK3ZvaWQgc2V0X2RyYW1fdGltaW5nc18xZ2JfbHBk
ZHI0eF85MDBtaHoodm9pZCk7Cj4gPiDCoCAKPiA+IMKgIGludCBzcGxfYm9hcmRfYm9vdF9kZXZp
Y2UoZW51bSBib290X2RldmljZSBib290X2Rldl9zcGwpCj4gPiDCoCB7Cj4gPiBAQCAtNDQsOCAr
NTQsNTYgQEAgdm9pZCBzcGxfYm9hcmRfaW5pdCh2b2lkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoHB1
dHMoIk5vcm1hbCBCb290XG4iKTsKPiA+IMKgIH0KPiA+IMKgIAo+ID4gK2VudW0gcGh5dGVjX2lt
eDkzX2Rkcl9lZXByb21fY29kZSB7Cj4gPiArwqDCoMKgwqDCoMKgwqBJTlZBTElEID0gUEhZVEVD
X0VFUFJPTV9JTlZBTCwKPiA+ICvCoMKgwqDCoMKgwqDCoFBIWVRFQ19JTVg5M19MUEREUjRYXzUx
Mk1CID0gMCwKPiA+ICvCoMKgwqDCoMKgwqDCoFBIWVRFQ19JTVg5M19MUEREUjRYXzFHQiA9IDEs
Cj4gPiArwqDCoMKgwqDCoMKgwqBQSFlURUNfSU1YOTNfTFBERFI0WF8yR0IgPSAyLAo+ID4gK8Kg
wqDCoMKgwqDCoMKgUEhZVEVDX0lNWDkzX0xQRERSNF81MTJNQiA9IDMsCj4gPiArwqDCoMKgwqDC
oMKgwqBQSFlURUNfSU1YOTNfTFBERFI0XzFHQiA9IDQsCj4gPiArwqDCoMKgwqDCoMKgwqBQSFlU
RUNfSU1YOTNfTFBERFI0XzJHQiA9IDUsCj4gPiArfTsKPiBeIElNTyB0aGlzIGJlbG9uZ3MgaW50
byBpbXg5M19zb21fZGV0ZWN0aW9uLmggZmlsZQoKVGhhdCBlbnVtIGlzIGluIHNwbC5jLCBiZWNh
dXNlIHRoZXJlIGlzIG5vdGhpbmcgbGlrZQpwaHl0ZWNfZ2V0X2lteDkzX3JhbV90eXBlKCksIGJ1
dCB3ZSB1c2UgdGhlIGdlbmVyaWMKcGh5dGVjX2lteDkzX2dldF9vcHQoKSBpbnN0ZWFkLiBTbyB0
aGF0IGlzIHZlcnkgc2ltaWxhciB0byB5b3VyIGNvbW1lbnQKYWJvdXQgcGh5dGVjX2dldF9pbXg5
M19pb192b2x0KCkgYWJvdmUuCgpJIHdpbGwgYWRkIGEgcGh5dGVjX2dldF9pbXg5M19yYW1fdHlw
ZSgpIHRvIGlteDkzX3NvbV9kZXRlY3Rpb24uYwphbmQgYWxzbyBtb3ZlIHRoZXJlYnkgZW51bSBw
aHl0ZWNfaW14OTNfZGRyX2VlcHJvbV9jb2RlIHRvCmlteDkzX3NvbV9kZXRlY3Rpb24uaCAuCgpU
aGFua3MsCkNocmlzdG9waAoKPiAKPiBSZWdhcmRzLAo+IFdhZGltCj4gPiArCj4gPiDCoCB2b2lk
IHNwbF9kcmFtX2luaXQodm9pZCkKPiA+IMKgIHsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQ7
Cj4gPiArwqDCoMKgwqDCoMKgwqBlbnVtIHBoeXRlY19pbXg5M19kZHJfZWVwcm9tX2NvZGUgZGRy
X29wdCA9IElOVkFMSUQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBOT1RFOiBJbiBTUEwg
bHBpMmMzIGlzIG1hcHBlZCB0byBidXMgMCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcGh5
dGVjX2VlcHJvbV9kYXRhX3NldHVwKE5VTEwsIDAsIEVFUFJPTV9BRERSKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChyZXQgJiYgIUlTX0VOQUJMRUQoQ09ORklHX1BIWUNPUkVfSU1YOTNfUkFNX1RZ
UEVfRklYKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiA+
ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBoeXRlY19pbXg5M19kZXRlY3QoTlVMTCk7Cj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAoIXJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwaHl0ZWNfcHJpbnRfc29tX2luZm8oTlVMTCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAoSVNfRU5BQkxFRChDT05GSUdfUEhZQ09SRV9JTVg5M19SQU1fVFlQRV9GSVgpKSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYKPiA+IChJU19FTkFCTEVEKENPTkZJ
R19QSFlDT1JFX0lNWDkzX1JBTV9UWVBFX0xQRERSNFhfMUdCKSkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGRyX29wdCA9IFBIWVRFQ19JTVg5M19M
UEREUjRYXzFHQjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlIGlmCj4g
PiAoSVNfRU5BQkxFRChDT05GSUdfUEhZQ09SRV9JTVg5M19SQU1fVFlQRV9MUEREUjRYXzJHQikp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRkcl9v
cHQgPSBQSFlURUNfSU1YOTNfTFBERFI0WF8yR0I7Cj4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ug
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRkcl9vcHQgPSBwaHl0ZWNfaW14
OTNfZ2V0X29wdChOVUxMLAo+ID4gUEhZVEVDX0lNWDkzX09QVF9ERFIpOwo+ID4gK8KgwqDCoMKg
wqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgc3dpdGNoIChkZHJfb3B0KSB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBjYXNlIFBIWVRFQ19JTVg5M19MUEREUjRYXzFHQjoKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaXNfdm9sdGFnZV9tb2RlKFZPTFRfTE9XX0RSSVZF
KSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2V0
X2RyYW1fdGltaW5nc18xZ2JfbHBkZHI0eF85MDBtaHooKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgUEhZVEVDX0lNWDkz
X0xQRERSNFhfMkdCOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldF9kcmFt
X3RpbWluZ3NfMmdiX2xwZGRyNHgoKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKg
wqDCoMKgwqBkZHJfaW5pdCgmZHJhbV90aW1pbmcpOwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
Owo+ID4gK291dDoKPiA+ICvCoMKgwqDCoMKgwqDCoHB1dHMoIkNvdWxkIG5vdCBkZXRlY3QgY29y
cmVjdCBSQU0gdHlwZSBhbmQgc2l6ZS4gRmFsbCBiYWNrCj4gPiB0byBkZWZhdWx0LlxuIik7Cj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAoaXNfdm9sdGFnZV9tb2RlKFZPTFRfTE9XX0RSSVZFKSkKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRfZHJhbV90aW1pbmdzXzFnYl9scGRk
cjR4XzkwMG1oeigpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGRkcl9pbml0KCZkcmFtX3RpbWluZyk7
Cj4gPiDCoCB9Cj4gPiDCoCAKPiAK
