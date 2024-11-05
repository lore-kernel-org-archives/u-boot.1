Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B896D2B931
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 13:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A43988ED9;
	Tue,  5 Nov 2024 14:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="laFpKTwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2915388FD2; Tue,  5 Nov 2024 14:56:39 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1876E88E60
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx0NtRhV0ehGw/ANrN7Ac5B3Fpaw8hLs0cWGzCd4gqiKvP23EU+e25rU2kheo/BPsbV0HAHRG2MVjcCfoB8Yp6snFYts/SPsglx57amp1/6mo2nah++sh2125Q722Z3+iSF2YCHAnjfn5YT4aQgJIQfX0UpdQPUF8ALXeq49+tArv/EzjBuLWKXOSY/k6rNFXlqhLdD/HmtqWvvwSkNrYzpsDuwzDpBo2zY3eSUNoRDwMu+iL/0nYqGS6bxHYWpq5PIl/s3WP6vu3yIolqLCXUnr/82psUQQB59Aq1DKbj/xMA+aXOXiqfy0eMbCBlHmEfQJVuwmb6GyPXpOtvrGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qR8UsFGUH1yMPEr2oEvCdQDZO0EosH0vfSBZNVEGKE=;
 b=BBef3XgnHPL5YsIPUePOMrRdnrYKaPa7uDYcG2oyE1kd8jRBOIPT16t+FCSXD+QFga9NOu9dKNnUt63OJmXd2iCUdeRiJ38WZXmxbougJIL3KAM4Bm8QWXbat4hIYey6MldaNQK+gj2S+ASWyx9NqclQ0x8bRWhDIOsArNXtDGWq8UwLDhiZCmSjkgYTpWny/LUHngQoGDZAAEv4w18oox+bSA2tDyO+xHPHhqvCnPbhanBoG0aJEV9awUCv7EBI3dh58gCIsf0ahlxQixT5jjRu4cI54e3Qq6nlUHzLh/vcNtm+btdbbV43NZHt6WMmESQrBOdWMMLbQETD+Aflrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qR8UsFGUH1yMPEr2oEvCdQDZO0EosH0vfSBZNVEGKE=;
 b=laFpKTwbPfFLEQ5ADX1Y9VtGWTcpjGzhDAd7XjmOZ7r61nxFPOgJ5HTOULBKmBPYAS+ISSDV3AONDWXZefzps3nLlAFLbdag4XQBBu/qri0C813FuyKzeSzpK7tWwIbLtTaD4XfVvVeD6HYEF1M5Rsd4jX0la6IeIzvk0RYtQtI=
Received: from DU7P194CA0029.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::22)
 by DB8P195MB0503.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 13:56:34 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::69) by DU7P194CA0029.outlook.office365.com
 (2603:10a6:10:553::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 13:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 13:56:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 5 Nov 2024
 14:56:33 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Tue, 5 Nov 2024 14:56:33 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [PATCH 1/3] board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM
 timings
Thread-Topic: [PATCH 1/3] board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM
 timings
Thread-Index: AQHbLqY+SwMoFdLGaUSexV64ucEGTLKm/JOAgAGqaIA=
Date: Tue, 5 Nov 2024 13:56:33 +0000
Message-ID: <dd4375de733db0be1f7549a56c7c6985c2076f5a.camel@phytec.de>
References: <20241104104148.748331-1-c.stoidner@phytec.de>
 <20241104104148.748331-2-c.stoidner@phytec.de>
 <CAOMZO5AW5+nDHODrOMD2G6AZrzQbR5OiM85GaW6Q1dY_sx+iog@mail.gmail.com>
In-Reply-To: <CAOMZO5AW5+nDHODrOMD2G6AZrzQbR5OiM85GaW6Q1dY_sx+iog@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CB85B4D609C334483E001EFBC1176E6@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DB8P195MB0503:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2da6fe-ba70-47e4-1ede-08dcfda1a8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFhORW1VNkRsRzdUVEx3KzBBTU93eENzYXlxTXFVczhwanczcUdYeTJJa1RQ?=
 =?utf-8?B?cG5VN3JkU1pLOWdnU2ZkWG1mbStibTRwMDhlUU1PR3BQVTlWWEt1S3BQbHJR?=
 =?utf-8?B?YUFzMDdHeUpBbmh1UWVBbGY5S1lwZmRWQjltcE1PUC9ZT3NQRFh4d0JTUVJX?=
 =?utf-8?B?YkhTbCt0cG1va3NQQTNBSEhpSDFQN28wcXgwalB3Wjcwb3IzTHpFalBGK0dt?=
 =?utf-8?B?Q2dqdGxaY3pwNEc0OVRmQkxKajZiWjJxKzZrVml2OEVLZWphNHJ4bithYXIr?=
 =?utf-8?B?c0d5SUNrM0pPZlFaMitCVkxBc2JKMFFNNDY4WnVsM1J0QmU5L0o1T2VyK0w4?=
 =?utf-8?B?bUYvdlBTUDkxZDZFQndRYi93NzVpV3VVaU9SZTBFZkJGbm10SDk0NUhSZzdo?=
 =?utf-8?B?MkxMbUR4ZVdaclI5dkVyNGU3akhPZllaNlY5bHFndk93OVFhK0d2czNtZW9W?=
 =?utf-8?B?ZjdXS2l3UHhxSE9GMG5zblkybzRBQ0hqcmZBTWo1TmxrdElMbldyZDJ6ZjBL?=
 =?utf-8?B?azZjWXAxcnVxcm5UYUF5UmEyTnVSN0FtS1Yxa3FsM2FUWW1BSTdaWFFDSG1t?=
 =?utf-8?B?cU9FUk9ITjBBVmZsU2hJSTNNRHE0QkF5V0xSV0dlMEdmbVE3bTJFNDBtaVVL?=
 =?utf-8?B?ZDN0VSs5YTRyYkYzNXF4RGRLM1RkYjZnZUcyQ2dQeUhqa01yN3BRcmtWTlRh?=
 =?utf-8?B?Wkp2dTZaV1RjTzRtZWdOUzE2MFpIREdIMHJnNnNNb0lQZkI2a2kvSkxVcGRi?=
 =?utf-8?B?VkFxVGFqTVBJWGh6U29zT1U5Z0VaQnRGYzNISUdMTGRzZ3JJaWczWTk0NDNI?=
 =?utf-8?B?WVZHWURwWUhJZ0dlU1phWnJ4a1VIdzdrM1Y0ekwxeWw3YnlqSHBkT0FpZkd5?=
 =?utf-8?B?MitjY0JGaFFjeEVEVU1iVzhyVmJabU1wQzdXMU1RV0JxQThYcVF5VFlVcUtZ?=
 =?utf-8?B?a2owZklDNWdobkFmRVQ0VEVsVitCOXNCd1FVc091VWFKM3BLL2lZOW1mRFlR?=
 =?utf-8?B?YVNES1dLT21DZHlNbmszRllHR3d0WHNqOU5YQnZWTWhYbis0YjBJWERaeTRC?=
 =?utf-8?B?bGZiRE5vNnlYdDQzS2J1d2trb1JkMG81VnNRbXdsVmdiRGlSaVc3OW5GOUtS?=
 =?utf-8?B?U3RXR0NBY3k4bnR3Y29pMFJreU4razF3S2tSdDBsVTNKUVcxRkd0d0U4Z2hx?=
 =?utf-8?B?TEZUTEt5VlFrRDVVOXNWSkN4bzBIdXFESE5YS0J4NkV3Qm1CMGFCYkQwZnpx?=
 =?utf-8?B?cWRwaWVlQ2VVWlVXOGN1bXFlTUY2L2lTd2lrTHZzOTNDODI5NnIvbEtkMFBC?=
 =?utf-8?B?ZzZhWGM4bTJnRXlhaC9PanZDL1hYK3dWYzdrNTZXcHQwc1VqZkUzY3FVRVJz?=
 =?utf-8?B?bkhNbERaZm5HdS92RGZoZmdKWklIQVdNNi9aTjVEams3elF4Tm5aVE1TVEZ6?=
 =?utf-8?B?aEVFVFJvVDhXR0RWdXM2ZS9USUJLeGQ4RmhkNkdBMkZxalNyTWlHZjNOL2Z6?=
 =?utf-8?B?ZnRUR3dEM2pSWnF2aVpoa1VJWk5YMUtoTTBTTmVOclpFWnFScm56Q1JiK2FW?=
 =?utf-8?B?c0g0QXE2ME9XcHBsRCtReW1kQmg5NmYra1R5ZkpzUXBMNzRxL09KcnFOSVNO?=
 =?utf-8?B?MkkyV05LOVdJRGk1bzdTcFIvdkxSOXltd3ZaNEs2bFdYZXVFQ0dXZ283ajE4?=
 =?utf-8?B?bk5TTjZoeHVxUXFlaHVGSjJvRTBLdkovSEV4bGswaHVTK2VGZTRpajZUaVRI?=
 =?utf-8?B?YTh5UGxpYk5qTmp6UmVVVzJKekJOK0htSXY1YVFXR0lyYW83K2doRXRWMW1B?=
 =?utf-8?B?aFQ3WjdpTTBGZWFQb1BiZmZ0VGwrRVJkaVhRRU5FeGxJUlhHVlF4SURnV3h5?=
 =?utf-8?B?azdWNTJHMzMxd2VzMjkvZ1lKQjN5OWFMRDQyUGJiZVFic0E9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 13:56:34.3612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2da6fe-ba70-47e4-1ede-08dcfda1a8dd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0503
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

SGkgRmFiaW8sDQoNCk9uIE1vLCAyMDI0LTExLTA0IGF0IDA5OjMwIC0wMzAwLCBGYWJpbyBFc3Rl
dmFtIHdyb3RlOg0KPiBIaSBDaHJpc3RvcGgsDQo+IA0KPiBPbiBNb24sIE5vdiA0LCAyMDI0IGF0
IDc6NTLigK9BTSBDaHJpc3RvcGggU3RvaWRuZXINCj4gPGMuc3RvaWRuZXJAcGh5dGVjLmRlPiB3
cm90ZToNCj4gPiANCj4gPiBUaGUgcGh5Q09SRS1pLk1YIDkzIGlzIGF2YWlsYWJsZSB3aXRoIGEg
MUdCIHJhbSBjaGlwIG9yIGEgMkdCIHJhbQ0KPiA+IGNoaXAuDQo+ID4gQWRkIHRoZSByYW0gdGlt
aW5ncyBmb3IgdGhlIDJHQiBjaGlwLCBpbiBmb3JtIG9mIGEgZGlmZiBjb21wYXJlZA0KPiA+IHRv
IHRoZSBleGlzdGluZyBMUEREUjRYIDFHQiB0aW1pbmdzLiBXaXRoIHRoYXQsIHRoZSBTUEwgY2Fu
IHNlbGVjdA0KPiA+IHRoZQ0KPiA+IGFwcHJvcHJpYXRlIHRpbWluZ3MgYXQgc3RhcnR1cC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5
dGVjLmRlPg0KPiA+IENjOiBNYXRoaWV1IE90aGFjZWhlIDxtLm90aGFjZWhlQGdtYWlsLmNvbT4s
IENocmlzdG9waCBTdG9pZG5lcg0KPiA+IDxjLnN0b2lkbmVyQHBoeXRlYy5kZT4sIFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+LCBZYW5uaWMgTW9vZw0KPiA+IDx5Lm1vb2dAcGh5dGVjLmRl
PiwgUHJpbW96IEZpc2VyIDxwcmltb3ouZmlzZXJAbm9yaWsuY29tPiwgQW5kcmVqDQo+ID4gUGlj
ZWogPGFuZHJlai5waWNlakBub3Jpay5jb20+LCBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRl
Yy5kZT4NCj4gDQo+IEFzIFRlcmVzYSBwb2ludGVkIG91dCwgdGhlIGNvcnJlY3Qgd2F5IHRvIGFk
ZCBDYyBpcyBhcyBmb2xsb3dzOg0KPiANCj4gQ2M6IE1hdGhpZXUgT3RoYWNlaGUgPG0ub3RoYWNl
aGVAZ21haWwuY29tPg0KPiBDYzogQ2hyaXN0b3BoIFN0b2lkbmVyIDxjLnN0b2lkbmVyQHBoeXRl
Yy5kZT4NCj4gLi4uIGV0Yw0KPiANCj4gWW91IGNhbiBldmVuIHB1dCB0aGUgQ2MgbGlzdCBiZWxv
dyB0aGUgLS0tIGxpbmUgc28gaXQgZG9lcyBub3QgYXBwZWFyDQo+IGluIHRoZSBjb21taXQgbG9n
Lg0KPiANCg0KVGhhbmtzIGZvciB0aGUgaGludC4gSSB3aWxsIGRvIHNvIGZvciBteSBuZXh0IHBh
dGNoZXMuDQoNCj4gUGxlYXNlIHJ1biBjaGVja3BhdGNoIG9uIGFsbCB0aGUgcGF0Y2hlcyB0b28u
IFRoZXJlIGlzIGEgd2FybmluZyBvbg0KPiB0aGlzIG9uZSB0aGF0IGlzIGVhc3kgdG8gZml4Og0K
PiANCj4gLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwNCj4gfi9Eb3dubG9hZHMvMS0zLWJvYXJkLXBo
eXRlYy1waHljb3JlLWlteDkzLUFkZC0yR0ItTFBERFI0WC1SQU0tDQo+IHRpbWluZ3MucGF0Y2gN
Cj4gQ0hFQ0s6IFBsZWFzZSBkb24ndCB1c2UgbXVsdGlwbGUgYmxhbmsgbGluZXMNCj4gIzg3OTog
RklMRTogYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvbHBkZHI0X3RpbWluZy5jOjEzNTA6DQo+
IA0KPiArDQo+IA0KPiB0b3RhbDogMCBlcnJvcnMsIDAgd2FybmluZ3MsIDEgY2hlY2tzLCAxMDUx
IGxpbmVzIGNoZWNrZWQNCg0KQWN0dWFsbHkgSSBzYXcgdGhhdCB3YXJuaW5nLCBidXQgc2luY2Ug
dGhlIGZpbGUgd2FzIGF1dG9tYXRpY2FsbHkNCmdlbmVyYXRlZCBJIGRlY2lkZWQgdG8gbm90IGNo
YW5nZSBpdC4gQnV0IGhvbmVzdGx5LCB3ZSBoYXZlIG1lYW53aGlsZSBhDQpmZXcgbWFudWFsIGNo
YW5nZXMgaW4gdGhhdCBmaWxlLg0KU28gSSB3aWxsIGZpeCBpdCBhbmQgaW5sdWNkZSBpdCBpbiBh
IHYyLg0KDQpUaGFua3MsDQpDaHJpc3RvcGgNCg0KDQo=
