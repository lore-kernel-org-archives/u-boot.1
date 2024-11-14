Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E702BD65C57
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 07:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352A6895AC;
	Thu, 14 Nov 2024 08:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Q4ZibQMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C12895D2; Thu, 14 Nov 2024 08:51:09 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4665D895D7
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg6TYYmKR7e4eHmpoS9Qno/dpaCL3Y2wNAaN7irjekTOcbiqMJ+LgI11Rn5ERbCezEeRHxDmxyoYtGwu+SfmxjcBhtYToo9JjGnjd04NApTQjWUS7lMYAbi8rIIeXxKWyx7Ktx5OF4yWKHQRq6ZGQxFmaBElLpDu62L5zpggYwYxIM4jtF3lCyC5kN4Meg8LSabSXNUNn3FaAoHMYHGYtGGEPBF+t52VETSn0OISf8FRA2i0U61XovhxoiWscINKnpi02t2/KnKhFxRu9fsDdssMTeEbGJ6mE3IIxX9ffYdPDxKwYfZaTlAQyoGSC5U5K3zRQkGy5u/CoWTkHgKYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90oPHgd3E9BZtaqvVX+cFp3523k78Q8xDei3zN3pVHQ=;
 b=SrxD+YfrqGcIhI4xG7b7WMKjgFGQMNoAE3CHAx6o17VYeKbrTfC/52Fr3da/mH4zrT45kBQ1C6tXev9pGtVofKNY2u2s5gV6Zo3wYcEYi9qKK1qswErMgpCJvIwNAotCbwK3kfcXLqDhkSGTQoW0j0lwXZcDRtNuyOB6Z3oUmwZ4OXVW06Lj/zBtNVTlM9qFmMhmkQ8aix3hc/VPaEUzwp4pXRb5DiPqICd9NWdl3g8OmLl1IHRNHuT1H7phmIvBEZS6bEq4Y0z4ZZbJyJCg+701/WEPk1j0lp0Q7KEhcdR7YZIo+dZdrikF+jO2SqtSM73nPwSuBriA69fQjhQF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90oPHgd3E9BZtaqvVX+cFp3523k78Q8xDei3zN3pVHQ=;
 b=Q4ZibQMBWm22S0z4sxXIKZqtX21DoStnFkAWFsoy4AeCbOiVxrR21KRBHYjiBzqCvEg87SdPM439azoPw/WYPYUk+rjZQqcWVrTD0/5mM0/LtK57z9AuTuDvdoXccgLDUndbBTx3ytxKCXU9y7VV2+TPCeZTHKjuPuiTEZ7qptk=
Received: from AM8P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::21)
 by AS8P195MB1847.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:50b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 07:50:59 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::a1) by AM8P189CA0016.outlook.office365.com
 (2603:10a6:20b:218::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 07:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 07:50:59 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 08:50:59 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 14 Nov 2024 08:50:59 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "bb@ti.com" <bb@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "leon@georgemail.eu"
 <leon@georgemail.eu>, "marex@denx.de" <marex@denx.de>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, "masahiroy@kernel.org"
 <masahiroy@kernel.org>
Subject: Re: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
Thread-Topic: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
Thread-Index: AQHbMGGXHF7InSEWBk6OjdXJSPN+urK2YlsA
Date: Thu, 14 Nov 2024 07:50:58 +0000
Message-ID: <87efb07d6eb10e7c7ad45e8bee741f485931f8de.camel@phytec.de>
References: <20241106153544.1277835-1-sjg@chromium.org>
In-Reply-To: <20241106153544.1277835-1-sjg@chromium.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD09CF55CD8EFA44A9DD72960C7BBEF4@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AS8P195MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d95f3da-3dfc-4ffa-893c-08dd04811460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0x2NHN3NG9EU2pieUErQzlhL2hreFgzZlZMbjBYMGNzcGkyU1VRU3BnbWVn?=
 =?utf-8?B?SFRsZnR4WkliWFV5QjlEMjFmUW9mR1VhaFZtMkUzb01NNmx5M0sza1NFcUZy?=
 =?utf-8?B?Y0M3QzNXSHc4c2xKUFhBTzJuK2FPUWR0bGtIaXd2U1ptZ2dXUTVJU1hpL1Bw?=
 =?utf-8?B?UDgwcWpzdjRUU1M5Sm1LcHQ1M2w4MVV6LzVvRGJmeWM5c05leTI3WnVGZTIy?=
 =?utf-8?B?c0FSVVh2VzlGN2VjaVdGdlhqZGg4NVVicnR5QkdPK3BDbEV3RlBmOThCWDlQ?=
 =?utf-8?B?US9lOW5sWkJDbXVIUDMrbGY2QjVzM3BQdEZiRG1keXB1L21SNzlkcWNKM1ZL?=
 =?utf-8?B?STNHWk5ZOVh6UFQyVHBnRWpSQjdBdEVGeThaMXI1SWdxc0N5cGFkYWpDdVB5?=
 =?utf-8?B?Z1ZGeGljdXZETFV1YTNlSUFzZWJnVlNJSEUzYjRSWXlNWkdsd3drMjQrd1RL?=
 =?utf-8?B?SGg5YVE1QzJEdEMrd0N1dzJzZXpvTThGZ25Ddk1hN1VNT0VqVm5lUDRDV1cy?=
 =?utf-8?B?T2NZeGJucVJydUhvZVJJa0JHMXVROFZ5eEJCdVAveDNkb3d4aXo3RVhoSkJw?=
 =?utf-8?B?cXRKcW1GYjltYzV0MTljS2xyeTdJVEdyempIRTc5VndKQWdya0grSzhRM1lu?=
 =?utf-8?B?OVZ2NUJwVVJ2L2laYkMyUFNnMEhuVWNYUVVoaEhiT1ZLWjdwWDB1MnJTM2cr?=
 =?utf-8?B?L2hhK3JKcUNVZUkvVTU2eVF0K1Jhd3JUOG9EREJzaWZZNzBoWDhKc1FMMVd0?=
 =?utf-8?B?UjBsOXVkVXJqaVlkTW93TU9LQjAzMU9wbWRsR3VlSldtWjMrZzBxOWJscGpT?=
 =?utf-8?B?Rk56dzRXMkZIQjdaTTRUYTZuVlV3UHZ3cm9EVXh2Y2Z5N2xiMFpxQ3o2bFEx?=
 =?utf-8?B?bWVBbFZZbVZwS3VzbmZPdndrL29qemZ3ek1hL213OVc1RFRSZXUzMnlORkIv?=
 =?utf-8?B?L0JxOHlHcmkwVW5xN0EwWHpxeHhNaFF0M01HdGlwZS81NzlkdDR2VFlDMmU5?=
 =?utf-8?B?d1g1RWsyTEYyeStzc051VmN0dGxUaVRBb0tsb1Z0eklMTWJOTWlBakFRZCtG?=
 =?utf-8?B?WnhpMmh3U3l4Ymx4Q3g1a0NLenZKQWZ1eXJOUDM0NXg2NzZxU3ZVR2xENkU2?=
 =?utf-8?B?RmNzeDNrSEdCK1VpSFgvUW5mMkkyUWpxVm4xWDRQZXQvVE91SG03MmU5aGcr?=
 =?utf-8?B?R3E3cmY2d1QwVkJkY1V4QnFmaVAvR2k5WUZIbnpZSXN3MmNEcW55NkVXMnEw?=
 =?utf-8?B?Qk40YmJzL2k1VTE4dzNYU3RvMGxsVm95Mk9sR2Ivbkx5LzRBU1FlUW5RQmdx?=
 =?utf-8?B?dXQ4UVU1NjdDKzJNeHBUSUtzRDBzTHBxTkVQTEhoei9oV2lyTUhiSVhoblZI?=
 =?utf-8?B?akxUUGIrYyt5RGJqTk93MU1tVzB0RFBRVjlHaU5EZ2N3TGozMVhvcW1JV3FE?=
 =?utf-8?B?SkxkSitnV0M5bU83TTdZQ0dONmk4NzBna2ptNmFHYUFUb2Q4QWZiSkZLcmlI?=
 =?utf-8?B?aWg5d2pzV2FXemlJZjh5TU83cEJZQlJ5M2RzaFBzOUdHVTA2dEJRUmlrcWJE?=
 =?utf-8?B?aUxwZUxRR3pTUWtodTBmTnRnMlBNLzA4OG1KN3BOMWVuNlhqM2xRQmFsYUFj?=
 =?utf-8?B?eUJkVzlDbUFPck5lVlBldmk3dkgvbjVHbEYvbFdpdndwMktVTDZqZ2o0K0lo?=
 =?utf-8?B?QW9NajV1bzQ2K2diSkRzNnJCWWdhY3VhcEpMd0xPZkpQZ1doZUJsamdHbkpt?=
 =?utf-8?B?TnVKY3dCWjc1RXNQMzkwVnVKaDZtM1pwbWM2ZHBoWi9sSTVXZUkwMmpxMGJu?=
 =?utf-8?B?WnQzckJJRGY3Z01jLzZHSnczellPemZDNlF1dXJBYXh1dVp3ckVsTXdBbWhv?=
 =?utf-8?B?SHJGeS9RSVdYRVoxVHhFRnZYRTQ3Y3RnQWlJT0lOQmtYRGc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 07:50:59.5329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d95f3da-3dfc-4ffa-893c-08dd04811460
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1847
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

SGkgU2ltb24sDQoNCk9uIFdlZCwgMjAyNC0xMS0wNiBhdCAwODozNSAtMDcwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IFRoaXMgZmxhZyB3YXMgbG9zdCBieSBhIHByZXZpb3VzIGNoYW5nZSBhbmQg
aGFzIG5ldmVyIGJlZW4gcmVzdG9yZWQuDQo+IFdpdGhvdXQgaXQsIGJpbm1hbiBjYW5ub3QgZnVs
bHkgaGFuZGxlIG1pc3NpbmcgYmxvYnMgd2hpY2ggYXJlDQo+IHRoZW1zZWx2ZXMgaW5wdXRzIHRv
IG1raW1hZ2UuDQo+IA0KPiBEaXNjdXNzaW9uIG9uIHRoaXMgYXQgWzFdIGluZGljYXRlZCB0aGF0
IHRoaXMgd2FzIG5lY2Vzc2FyeSBidXQgdGhlDQo+IHBhdGNoIHdhcyBub3QgdXBkYXRlZC4NCj4g
DQo+IFJlc3RvcmUgdGhlIGZsYWcgc28gdGhhdCBhbGwgbWlzc2luZyBibG9icyBhcmUgcmVwb3J0
ZWQuDQo+IA0KPiBMaW5rOiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJv
b3QvcGF0Y2gvMjAyMjEyMDYwMjAzMzYuMzE1NDY1LTEtdHJpbmlAa29uc3Vsa28uY29tLw0KDQpz
b3JyeSBJJ20gcGlja2luZyB0aGlzIHVwIHNvIGxhdGU7IA0KQXMgSSBhbSB3b3JraW5nIG9uIE9Q
LVRFRSBhZGRpdGlvbiB0byBpbXg4bSBib2FyZHMgWzFdLCB0aGlzIHBhdGNoIGdvdCBteSBpbnRl
cmVzdC4NCkkgYXBwbGllZCB0aGUgcGF0Y2ggb24gdG9wIG9mIG15IHBhdGNoc3RhY2sgYW5kIHRy
aWVkIHRvIGJ1aWxkIChwaHljb3JlLWlteDhtcCkgd2l0aCBtaXNzaW5nIHRlZS5iaW4NCmJpbmFy
eSBhbmQgZ290IHVuZXhwZWN0ZWQgcmVzdWx0czoNCg0KDQpJbWFnZSAnaW1hZ2UnIGhhcyBmYWtl
ZCBleHRlcm5hbCBibG9icyBhbmQgaXMgbm9uLWZ1bmN0aW9uYWw6IHRlZS5iaW4NCg0KSW1hZ2Ug
J2ltYWdlJyBpcyBtaXNzaW5nIG9wdGlvbmFsIGV4dGVybmFsIGJsb2JzIGJ1dCBpcyBzdGlsbCBm
dW5jdGlvbmFsOiB0ZWUtb3MNCg0KL2Jpbm1hbi9zZWN0aW9uL2ZpdC9pbWFnZXMvdGVlL3RlZS1v
cyAodGVlLmJpbik6DQogICBTZWUgdGhlIGRvY3VtZW50YXRpb24gZm9yIHlvdXIgYm9hcmQuIFlv
dSBtYXkgbmVlZCB0byBidWlsZCBPcGVuIFBvcnRhYmxlDQogICBUcnVzdGVkIEV4ZWN1dGlvbiBF
bnZpcm9ubWVudCAoT1AtVEVFKSBhbmQgYnVpbGQgd2l0aCBURUU9L3BhdGgvdG8vdGVlLmJpbg0K
DQpTb21lIGltYWdlcyBhcmUgaW52YWxpZA0KDQoNClNvIGJ1aWxkIGZhaWxzIGV2ZW4gdGhvdWdo
IHRlZS5iaW4gaXMgbWFya2VkIGFzIG9wdGlvbmFsLg0KRGlkIEkgbWlzcyBhbm90aGVyIHBhdGNo
IHRoYXQgbXVzdCBiZSB1c2VkIGluIGNvbmp1bmN0aW9uIHdpdGggdGhpcyBvbmU/DQoNCkJlZm9y
ZSB0aGlzIHBhdGNoLCBJIHNlZSB0aGUgZm9sbG93aW5nIG91dHB1dC4NCg0KDQpJbWFnZSAnaW1h
Z2UnIGlzIG1pc3Npbmcgb3B0aW9uYWwgZXh0ZXJuYWwgYmxvYnMgYnV0IGlzIHN0aWxsIGZ1bmN0
aW9uYWw6IHRlZS1vcw0KDQovYmlubWFuL3NlY3Rpb24vZml0L2ltYWdlcy90ZWUvdGVlLW9zICh0
ZWUuYmluKToNCiAgIFNlZSB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgeW91ciBib2FyZC4gWW91IG1h
eSBuZWVkIHRvIGJ1aWxkIE9wZW4gUG9ydGFibGUNCiAgIFRydXN0ZWQgRXhlY3V0aW9uIEVudmly
b25tZW50IChPUC1URUUpIGFuZCBidWlsZCB3aXRoIFRFRT0vcGF0aC90by90ZWUuYmluDQoNCg0K
V2l0aCBzdWNjZXNzZnVsIGJ1aWxkLg0KDQpZYW5uaWMNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3UtYm9vdC8yMDI0MTEwNy1waHl0ZWNfaW14OG1fb3B0ZWUtdjItMC1iYmMzNzQ3YTYw
ZThAcGh5dGVjLmRlDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEdsYXNzIDxzamdAY2hy
b21pdW0ub3JnPg0KPiBGaXhlczogOTM2ODVkMGRjYjkgKCJNYWtlZmlsZTogV2l0aCBCSU5NQU5f
QUxMT1dfTUlTU0lORz0xIGRvbid0IGVycm9yIikNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYy
Og0KPiAtIFVzZSBMaW5rOiBhbmQgYXZvaWQgYSBsaW5lIGJyZWFrDQo+IA0KPiDCoE1ha2VmaWxl
IHwgMyArKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KPiBpbmRleCA3Mjc1
YTAyZjI0Yy4uZjkyZjQ2YjNhYjcgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxlDQo+ICsrKyBiL01h
a2VmaWxlDQo+IEBAIC0xMzk4LDcgKzEzOTgsOCBAQCBjbWRfYmlubWFuID0gJChzcmN0cmVlKS90
b29scy9iaW5tYW4vYmlubWFuICQoaWYgJChCSU5NQU5fREVCVUcpLC1EKSBcDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0tdG9vbHBhdGggJChvYmp0cmVlKS90b29scyBcDQo+
IMKgCQkkKGlmICQoQklOTUFOX1ZFUkJPU0UpLC12JChCSU5NQU5fVkVSQk9TRSkpIFwNCj4gwqAJ
CWJ1aWxkIC11IC1kIHUtYm9vdC5kdGIgLU8gLiAtbSBcDQo+IC0JCS0tYWxsb3ctbWlzc2luZyAk
KGlmICQoQklOTUFOX0FMTE9XX01JU1NJTkcpLC0taWdub3JlLW1pc3NpbmcpIFwNCj4gKwkJLS1h
bGxvdy1taXNzaW5nIC0tZmFrZS1leHQtYmxvYnMgXA0KPiArCQkkKGlmICQoQklOTUFOX0FMTE9X
X01JU1NJTkcpLC0taWdub3JlLW1pc3NpbmcpIFwNCj4gwqAJCS1JIC4gLUkgJChzcmN0cmVlKSAt
SSAkKHNyY3RyZWUpL2JvYXJkLyQoQk9BUkRESVIpIFwNCj4gwqAJCSQoZm9yZWFjaCBmLCQob2Zf
bGlzdF9kaXJzKSwtSSAkKGYpKSAtYSBvZi1saXN0PSQob2ZfbGlzdCkgXA0KPiDCoAkJJChmb3Jl
YWNoIGYsJChCSU5NQU5fSU5ESVJTKSwtSSAkKGYpKSBcDQoNCg==
