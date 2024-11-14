Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9B4D68B11
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 13:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066C08961E;
	Thu, 14 Nov 2024 14:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Als47nqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAB489616; Thu, 14 Nov 2024 14:28:02 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094578961F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 14:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptrck3wt9atRd8gRcf6O23z398FJWMtpRjuh8qhwx6cFUPzGjbrlHSQKbnWuWDv0Qh7Tiv5Qb8/BNzwCIlWQq3xpUJ1R0Yk4ZvvfwLAcU423blvmnJ0JqOCS6fxcew2UE3f80d21uPhjm4fQxx08niXeaG2wWbWba2/hpmX7n+IRxGVILz2vOWGvCiaK8hzJQjuhk89zgcnfsCPT8V31Znat9Aoky2hmCluzQkrsFq+4707I9re1XnhA+mn9R91Ta5Al+bmYuyl4A1NUqKfQwMHr4iJ5rpc9Zxnug3DqMf2iKbzfPdrBNXiu3ScuNzY7WpHDxQ43H0uEyIbFGagxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2MhG71KPw/D/xVlgtsU5PaklP0w7t5UGccB93wHDCs=;
 b=hp0myuAF0EvsN+JtcYLil/SSDZ9p9ZqT8KL+LXhGR3qcgyuSa42Aks5pstabgzGIyHYjnkUOuTLuVNdpIccOH9EUFXwq/mCYVIx6RTOux+RwzfIPxgQwXr2eREExRhNiw2kmKf0ky5BeQ/cK4/Gn8zBM8HMqV2lW5LLpDYyM64+sG0kH0yv45zK7NhjqJe4IKyTzYCf28AK1sk8Ppvod1sHryo9l75waXzYoiJxK/Kmw12susgiKi8/ZMtoKcro578w3irohhgVsktM/YTGbCNnCppHix7nrrEa10ztFPMDEjl0c4uFGritZUXBJuhL3D57GUqsp3B8sKQzSm2qWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2MhG71KPw/D/xVlgtsU5PaklP0w7t5UGccB93wHDCs=;
 b=Als47nqaCDoZvMcVVvOl0cvS+41yNFCyvzB+rhFVmcb+HyBfiSyWFo7oCB9cTDq4xxRnkTk+0iqYzG0xbUCRTY4h4fgBOO1nvIMBaKyOu5ngLEaY7QLiYXibLLqgWnIx5H+c/mshjJ94gD6/Fd6Isf7IX0eLzFFuWobPpgXnx4I=
Received: from DU2PR04CA0295.eurprd04.prod.outlook.com (2603:10a6:10:28c::30)
 by FRZP195MB2633.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:13d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 13:27:56 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::93) by DU2PR04CA0295.outlook.office365.com
 (2603:10a6:10:28c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 13:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 13:27:56 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 14:27:56 +0100
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 14:27:55 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 14 Nov 2024 14:27:55 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: Christoph Stoidner <C.Stoidner@phytec.de>
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
Thread-Index: AQHbNeU5VQPRpaJgd0q5L0+QzB2wqLK2QsEAgABXCYCAABuugA==
Date: Thu, 14 Nov 2024 13:27:55 +0000
Message-ID: <c44edecde5ba3d006baaa0c58a45f1f6c5476260.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
 <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
 <2b1aec9b611a3106a4c59b53db2e84a697791f8d.camel@phytec.de>
In-Reply-To: <2b1aec9b611a3106a4c59b53db2e84a697791f8d.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94B3C257C6BFF0449086033E32D06DEB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B94:EE_|FRZP195MB2633:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9dc136-45b3-411b-9f19-08dd04b026b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UStoSTNacncxaXlJTjFTekl6ay96T29XNVp4TzlzeGtiZUxDRnQ0aHJ2dTZP?=
 =?utf-8?B?WGNCeW4xZ0tUa0E1bWY5M2VsQTVZNFF2SFpQbFVERTB6K1hZOVo0Ulg3OUkv?=
 =?utf-8?B?QUNCUUNnd0VJcWt3MSs5dTQ2aFlvN0dXL05lT2xvMDBxWnRNV2J3ZHNVUXlo?=
 =?utf-8?B?NzE4OW0wenVPcnpidUl1WXo4dVlwVE5OY1oyWXJocVM4d05DWW1rOTVkRHZH?=
 =?utf-8?B?Vlhnb1Q3S0lrN0ErOXVGU0tSdDcxenB1dFNWWWw3aXBqckp3QnducUFPbXp4?=
 =?utf-8?B?MUlTdFM4dlhkMXl4MG5yV0I4RWY5MFR0YjB0SGRKZ1R4RUdqZXc1c2hvWEsw?=
 =?utf-8?B?djRYeXhXai9KY2drTldHYmdiNkpCL3pDaTErTGx0UlZEcUhKTkhPR2haU1Bt?=
 =?utf-8?B?eG56bmlDSE1mTnZVQS8xb0lad0wxU0hOUG52VFVZTVlCYmZKN2cvakFSampO?=
 =?utf-8?B?dUFTcjdMSWFiNXhlRHlOZzFQRE1ydlpYSnRyalEwRjJoN084Q3NxMWlUcXpC?=
 =?utf-8?B?RE5HZng5NFNsNGliaUJZd2lpazlraUt2KzhQU3hVSWt2Ly9vQ21jNXFwNG9T?=
 =?utf-8?B?Q2EzNHA2Tzc5Tmk1UE1wdzl2Tk9jaUZwR3NsRDV3YkJlQUdwU3lLUjA1UkJq?=
 =?utf-8?B?OGVPc3ZXSVp2ZisraCs4QlF4Y3JQelFJUHZaRUtOM0k5YzREMWJnRU0vdzg0?=
 =?utf-8?B?bEJKU01QOGpkTXl0eFV2dE5TNFdjZjBuNFVJVGI0d3I3bkFYdGc3K2c5d3d3?=
 =?utf-8?B?Z1R2RmFwVnJ2dk53YWlvKzdtRUxlTDZZSTJDaUhPREdzcnc2S2dWTjFJREFz?=
 =?utf-8?B?MDhFWGliV0kyN05HR3ZDYXkrZSt6d2p4WkFCSHVTcytJTEExb1JXcEkwQVE4?=
 =?utf-8?B?S2xkTlJyUWl1N3pqNDNpWWJ5SG5OeHp5bWJHQThDTHo2WjFyREZzNkNwdDVl?=
 =?utf-8?B?b1VBcmFCUDNodSt3Q3ZRelc4MkRhanVQcCtDM1BPZW9mb21ZZCtQaityaUxh?=
 =?utf-8?B?M1pYWmhPL1h6Nk9NRmxNb05OUE05VzVuQUdaUVMvOUdXQ29qdDZVb1YrZVlC?=
 =?utf-8?B?NjVVaVUrTTRFM0V2QkpLeDdoUUZ3dlkzR0RHR29CZW8wWkVER1dxd24vUnQ0?=
 =?utf-8?B?aEhkUDM5V2VLMFUxc3lUZGpUdjhEYmJsNlhhalR4MDM3THJhUEtwZzZDU2lW?=
 =?utf-8?B?OGcrQVp0NVY0RGxzUVNsVGpyZXZBUVNjN2p6N3YzdmhtOTMzZmN1LzBZMWVF?=
 =?utf-8?B?L3ZXMnRCZzloQm1hMlM5RDR5QUlPeEtlMnY3VTdqZHFZTmFYOEVqL25FZTBa?=
 =?utf-8?B?L3hVejQwMnBJcVdBem9SZW11RzNtUUttZWFxTXlubVpOMkI5NzJrTUFTQVow?=
 =?utf-8?B?a2V2ZHdqcUVROWgrdENJMGNCZThKNXdCSTlRSUQvYnRqZXcvNnRtajlGMHFo?=
 =?utf-8?B?S1FPSFVLQXpobVRhWGhKSXdhM2VsTXQ2eEdnWHM3KzJTcllLRno0RG1jeWVU?=
 =?utf-8?B?a21SYUROenVSRWYvNkFySVFwTzl5VXBqYnMrZTJaQzZMTnE3ejMwZ1ZuUk9D?=
 =?utf-8?B?Rk5IRDRzcFBiT2h2MktXSEdUc2M4UjIwbnp5TjR1TWlTV0s2dXIydnVkSDIz?=
 =?utf-8?B?ejVRTkNhMEJHUG1WeGZ1bHlVTkR5V2RDd3BRL3hISi9YZGxmU3NkWGNVeEdh?=
 =?utf-8?B?eUdLbVFtMmw5a3pkQU1qVGpveHM1eHFISmIrOWxwOGIzdXVMcjZEUkZwTnBF?=
 =?utf-8?B?OFhnV2J3YlU4WkNOeUk2ZFk5cU5sd3VsV21wVmFWM0JOZ3crc2VSTUo4SjRx?=
 =?utf-8?Q?KZZDCQ8RheB8f2i8N/hnNqU7RisQ/MpUffNxY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 13:27:56.5980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9dc136-45b3-411b-9f19-08dd04b026b4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP195MB2633
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

T24gVGh1LCAyMDI0LTExLTE0IGF0IDEyOjQ4ICswMTAwLCBDaHJpc3RvcGggU3RvaWRuZXIgd3Jv
dGU6DQo+IA0KPiANCj4gT24gRG8sIDIwMjQtMTEtMTQgYXQgMDc6MzcgKzAxMDAsIFlhbm5pYyBN
b29nIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0xMS0xMyBhdCAxNzowMCArMDEwMCwgQ2hyaXN0
b3BoIFN0b2lkbmVyIHdyb3RlOg0KPiA+ID4gVGhlIHBoeUNPUkUtaS5NWCA5MyBpcyBhdmFpbGFi
bGUgaW4gdmFyaW91cyB2YXJpYW50cyAoZS5nLg0KPiA+ID4gZGlmZmVyZW50IHJhbQ0KPiA+ID4g
c2l6ZXMsIGVNTUMgSFM0MDAgeWVzL25vKS4gRW5hYmxlIGhhcmR3YXJlIGludHJvc3BlY3Rpb24g
Zm9yIHRoZQ0KPiA+ID4gaW14OTMtcGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnLCBzbyB0aGF0IGR1
cmluZyBzdGFydHVwIHRoZSBTT00NCj4gPiA+IG1vZHVsZQ0KPiA+ID4gdmFyaWFudCBjYW4gYmUg
ZGV0ZWN0ZWQsIGFuZCB0aGUgaGFyZHdhcmUgY2FuIGJlIGNvbmZpZ3VyZWQNCj4gPiA+IGFjY29y
ZGluZ2x5Lg0KPiA+ID4gVGhlIHJlc3VsdGluZyBTUEwgYW5kIHUtYm9vdCBiaW5hcnkgc2hhbGwg
YWJsZSB0byBib290IGVhY2gNCj4gPiA+IHBoeUNPUkUtaS5NWCA5MyBtb2R1bGUgdmFyaWFudCBv
biBlYWNoIGNhcnJpZXIgYm9hcmQuIEZpbmFsbHkNCj4gPiA+IHJlbmFtZQ0KPiA+ID4gaW14OTMt
cGh5Ym9hcmQtc2VnaW5fZGVmY29uZmlnIHRvIGlteDkzLXBoeWNvcmVfZGVmY29uZmlnLCB0bw0K
PiA+ID4gaGlnaGxpZ2h0DQo+ID4gPiBpdHMgU09NIHNjb3BlLg0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiA+
ID4gLS0tDQo+ID4gPiBDYzogTWF0aGlldSBPdGhhY2VoZSA8bS5vdGhhY2VoZUBnbWFpbC5jb20+
DQo+ID4gPiBDYzogQ2hyaXN0b3BoIFN0b2lkbmVyIDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4NCj4g
PiA+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT4NCj4gPiA+IENjOiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+ID4gPiBDYzogIk5YUCBpLk1YIFUtQm9vdCBU
ZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+ID4gPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT4NCj4gPiA+IENjOiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCj4gPiA+
IENjOiBQcmltb3ogRmlzZXIgPHByaW1vei5maXNlckBub3Jpay5jb20+DQo+ID4gPiBDYzogQW5k
cmVqIFBpY2VqIDxhbmRyZWoucGljZWpAbm9yaWsuY29tPg0KPiA+ID4gQ2M6IFdhZGltIEVnb3Jv
diA8dy5lZ29yb3ZAcGh5dGVjLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGluIHYyOg0K
PiA+ID4gLSBqdXN0IHJlbmFtZSBpbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcgYW5kIGFk
ZCBuZWVkZWQNCj4gPiA+IENPTkZJR3MsDQo+ID4gPiDCoCBpbnN0ZWFkIG9mIGNyZWF0aW5nIGFu
IGVudGlyZWx5IG5ldyBzZWNvbmQgZGVmY29uZmlnDQo+ID4gPiAtIHJlbW92ZSB3cm9uZyBjb21t
ZW50IGZyb20gaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gPiA+IC0gaW1wcm92
ZSBjb21taXQgbWVzc2FnZQ0KPiA+ID4gDQo+ID4gPiDCoGFyY2gvYXJtL2R0cy9pbXg5My1waHli
b2FyZC1zZWdpbi11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2DQo+
ID4gPiArKysrLS0NCj4gPiA+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRBSU5F
UlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+ID4g
PiDCoC4uLng5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcgPT4gaW14OTMtcGh5Y29yZV9kZWZj
b25maWd9IHwgNA0KPiA+ID4gKysrLQ0KPiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+IMKgcmVuYW1lIGNvbmZpZ3Mve2lteDkzLXBo
eWJvYXJkLXNlZ2luX2RlZmNvbmZpZyA9PiBpbXg5My0NCj4gPiA+IHBoeWNvcmVfZGVmY29uZmln
fSAoOTglKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDkzLXBo
eWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gPiBiL2FyY2gvYXJtL2R0cy9pbXg5My1waHli
b2FyZC1zZWdpbi11LQ0KPiA+ID4gYm9vdC5kdHNpDQo+ID4gPiBpbmRleCAyNWM3NzhiYjA3Li4y
MjQ1NDYxMDMyIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJk
LXNlZ2luLXUtYm9vdC5kdHNpDQo+ID4gPiArKysgYi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9h
cmQtc2VnaW4tdS1ib290LmR0c2kNCj4gPiA+IEBAIC0yLDE1ICsyLDE3IEBADQo+ID4gPiDCoC8q
DQo+ID4gPiDCoCAqIENvcHlyaWdodCAoQykgMjAyMyBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0K
PiA+ID4gwqAgKiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiA+
ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBQSFlURUMgTWVzc3RlY2huaWsgR21iSA0KPiA+ID4g
wqAgKg0KPiA+ID4gwqAgKiBQcm9kdWN0IGhvbWVwYWdlOg0KPiA+ID4gLSAqIHBoeUJPQVJELVNl
Z2luIGNhcnJpZXIgYm9hcmQgaXMgcmV1c2VkIGZvciB0aGUgaS5NWDkzIGRlc2lnbi4NCj4gPiA+
IC0gKiBodHRwczovL3d3dy5waHl0ZWMuZXUvZW4vcHJvZHVrdGUvc2luZ2xlLWJvYXJkLQ0KPiA+
ID4gY29tcHV0ZXIvcGh5Ym9hcmQtc2VnaW4taW14NnVsLw0KPiA+ID4gK8KgwqAgaHR0cHM6Ly93
d3cucGh5dGVjLmRlL3Byb2R1a3RlL3N5c3RlbS1vbi1tb2R1bGVzL3BoeWNvcmUtaW14LQ0KPiA+
ID4gOTEtOTMvDQo+ID4gPiDCoCAqLw0KPiA+ID4gwqANCj4gPiA+IMKgI2luY2x1ZGUgImlteDkz
LXUtYm9vdC5kdHNpIg0KPiA+ID4gwqANCj4gPiA+IMKgLyB7DQo+ID4gPiArwqDCoMKgwqDCoMKg
wqBtb2RlbCA9ICJQSFlURUMgcGh5Q09SRS1pLk1YOTMiOw0KPiA+ID4gKw0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoHdkdC1yZWJvb3Qgew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb21wYXRpYmxlID0gIndkdC1yZWJvb3QiOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB3ZHQgPSA8Jndkb2czPjsNCj4gPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiA+ID4gYi9ib2FyZC9waHl0ZWMvcGh5
Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiA+ID4gaW5kZXggY2VhODE3ZmZkYy4uNzE4Zjg5YTA4
NCAxMDA2NDQNCj4gPiA+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlO
RVJTDQo+ID4gPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0K
PiA+ID4gQEAgLTksNSArOSw1IEBAIEY6wqDCoMKgwqDCoCBhcmNoL2FybS9kdHMvaW14OTMtcGh5
Ym9hcmQtc2VnaW4tdS0NCj4gPiA+IGJvb3QuZHRzaQ0KPiA+ID4gwqBGOsKgwqDCoMKgwqAgYm9h
cmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvDQo+ID4gPiDCoEY6wqDCoMKgwqDCoCBib2FyZC9waHl0
ZWMvY29tbW9uL2lteDkzX3NvbV9kZXRlY3Rpb24uYw0KPiA+ID4gwqBGOsKgwqDCoMKgwqAgYm9h
cmQvcGh5dGVjL2NvbW1vbi9pbXg5M19zb21fZGV0ZWN0aW9uLmgNCj4gPiA+IC1GOsKgwqDCoMKg
wqAgY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcNCj4gPiA+ICtGOsKgwqDC
oMKgwqAgY29uZmlncy9pbXg5My1waHljb3JlX2RlZmNvbmZpZw0KPiA+IA0KPiA+IEhvdyB3aWxs
IHlvdSBoYW5kbGUgdGhpcyB3aGVuL2lmIHlvdSBoYXZlIGFub3RoZXIgYm9hcmQ/DQo+IA0KPiBU
aGF0IGlteDkzLXBoeWNvcmVfZGVmY29uZmlnIGhhcyBubyBtb3JlIGRlcGVuZGVuY3kgdG8gdGhl
IGNhcnJpZXINCj4gYm9hcmQuDQoNCk5vdCB0cnVlLCANCkNPTkZJR19ERUZBVUxUX0RFVklDRV9U
UkVFPSJpbXg5My1waHlib2FyZC1zZWdpbiINCkl0IGhhcyBhIGRlcGVuZGVuY3kgdG8gYSBib2Fy
ZC4gVGhhdCBpcyB3aHkgSSBhbSBhc2tpbmcuDQoNCllhbm5pYw0KDQo+ICBUaGF0cyB3aHkgSSBy
ZW5hbWVkIGl0LiBUaGUgaW50ZW50aW9uIGZvciB0aGUgZGVmY29uZmlnIGlzwqB0aGF0DQo+IHRo
ZSByZXN1bHRpbmcgU1BMIGFuZCB1LWJvb3QgYmluYXJ5IGNhbiB0byBib290IGVhY2ggcGh5Q09S
RS1pLk1YIDkzDQo+IG1vZHVsZSB2YXJpYW50IG9uIGVhY2ggY2FycmllciBib2FyZC4NCj4gDQo+
IFRoYXRzIHdoeSB0aGUgY2FycmllciBib2FyZCBpcyBubyBtb3JlIHJlbGV2YW50IGhlcmUuDQoN
Cj4gDQo+ID4gDQo+ID4gQWxzbywgcGxlYXNlIHVwZGF0ZSBkb2N1bWVudGF0aW9uIQ0KPiA+IA0K
PiA+IFlhbm5pYw0KPiA+IA0KPiA+ID4gwqBGOsKgwqDCoMKgwqAgaW5jbHVkZS9jb25maWdzL3Bo
eWNvcmVfaW14OTMuaA0KPiA+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaW14OTMtcGh5Ym9hcmQt
c2VnaW5fZGVmY29uZmlnDQo+ID4gPiBiL2NvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcN
Cj4gPiA+IHNpbWlsYXJpdHkgaW5kZXggOTglDQo+ID4gPiByZW5hbWUgZnJvbSBjb25maWdzL2lt
eDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZpZw0KPiA+ID4gcmVuYW1lIHRvIGNvbmZpZ3MvaW14
OTMtcGh5Y29yZV9kZWZjb25maWcNCj4gPiA+IGluZGV4IDE4YTQwODdlNGIuLmNmOTgwMDExOGEg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9jb25maWdzL2lteDkzLXBoeWJvYXJkLXNlZ2luX2RlZmNvbmZp
Zw0KPiA+ID4gKysrIGIvY29uZmlncy9pbXg5My1waHljb3JlX2RlZmNvbmZpZw0KPiA+ID4gQEAg
LTYsMTMgKzYsMTMgQEAgQ09ORklHX1NZU19NQUxMT0NfRl9MRU49MHgyMDAwMA0KPiA+ID4gwqBD
T05GSUdfU1BMX0xJQkNPTU1PTl9TVVBQT1JUPXkNCj4gPiA+IMKgQ09ORklHX1NQTF9MSUJHRU5F
UklDX1NVUFBPUlQ9eQ0KPiA+ID4gwqBDT05GSUdfTlJfRFJBTV9CQU5LUz0yDQo+ID4gPiArQ09O
RklHX1BIWVRFQ19TT01fREVURUNUSU9OPXkNCj4gPiA+IMKgQ09ORklHX0VOVl9TT1VSQ0VfRklM
RT0icGh5Y29yZV9pbXg5MyINCj4gPiA+IMKgQ09ORklHX0VOVl9TSVpFPTB4MTAwMDANCj4gPiA+
IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHg3MDAwMDANCj4gPiA+IMKgQ09ORklHX0lNWF9DT05GSUc9
ImFyY2gvYXJtL21hY2gtaW14L2lteDkvaW14aW1hZ2UuY2ZnIg0KPiA+ID4gwqBDT05GSUdfRE1f
R1BJTz15DQo+ID4gPiDCoENPTkZJR19ERUZBVUxUX0RFVklDRV9UUkVFPSJpbXg5My1waHlib2Fy
ZC1zZWdpbiINCj4gPiA+IC1DT05GSUdfU1BMX1RFWFRfQkFTRT0weDIwNDlBMDAwDQo+ID4gPiDC
oENPTkZJR19BSEFCX0JPT1Q9eQ0KPiA+ID4gwqBDT05GSUdfVEFSR0VUX1BIWUNPUkVfSU1YOTM9
eQ0KPiA+ID4gwqBDT05GSUdfT0ZfTElCRkRUX09WRVJMQVk9eQ0KPiA+ID4gQEAgLTIwLDYgKzIw
LDcgQEAgQ09ORklHX1NZU19NT05JVE9SX0xFTj01MjQyODgNCj4gPiA+IMKgQ09ORklHX1NQTF9T
RVJJQUw9eQ0KPiA+ID4gwqBDT05GSUdfU1BMX0RSSVZFUlNfTUlTQz15DQo+ID4gPiDCoENPTkZJ
R19TUExfU1RBQ0s9MHgyMDUxOWRkMA0KPiA+ID4gK0NPTkZJR19TUExfVEVYVF9CQVNFPTB4MjA0
OUEwMDANCj4gPiA+IMKgQ09ORklHX1NQTF9IQVNfQlNTX0xJTktFUl9TRUNUSU9OPXkNCj4gPiA+
IMKgQ09ORklHX1NQTF9CU1NfU1RBUlRfQUREUj0weDIwNTFhMDAwDQo+ID4gPiDCoENPTkZJR19T
UExfQlNTX01BWF9TSVpFPTB4MjAwMA0KPiA+ID4gQEAgLTMxLDYgKzMyLDcgQEAgQ09ORklHX1NQ
TF9JTVhfUk9NQVBJX0xPQURBRERSPTB4ODgwMDAwMDANCj4gPiA+IMKgQ09ORklHX1NZU19NRU1U
RVNUX1NUQVJUPTB4ODAwMDAwMDANCj4gPiA+IMKgQ09ORklHX1NZU19NRU1URVNUX0VORD0weDkw
MDAwMDAwDQo+ID4gPiDCoENPTkZJR19SRU1BS0VfRUxGPXkNCj4gPiA+ICsjIENPTkZJR19BTkRS
T0lEX0JPT1RfSU1BR0UgaXMgbm90IHNldA0KPiA+ID4gwqBDT05GSUdfRElTVFJPX0RFRkFVTFRT
PXkNCj4gPiA+IMKgQ09ORklHX09GX1NZU1RFTV9TRVRVUD15DQo+ID4gPiDCoENPTkZJR19CT09U
Q09NTUFORD0ibW1jIGRldiAke21tY2Rldn07IGlmIG1tYyByZXNjYW47IHRoZW4gaWYgcnVuDQo+
ID4gPiBsb2FkaW1hZ2U7IHRoZW4gcnVuIG1tY2Jvb3Q7DQo+ID4gPiBlbHNlIHJ1biBuZXRib290
OyBmaTsgZmk7Ig0KPiA+IA0KDQo=
