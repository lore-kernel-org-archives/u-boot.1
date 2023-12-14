Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB42AC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1EB87AD4;
	Thu, 14 Dec 2023 18:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+1bElWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E94787ADB; Thu, 14 Dec 2023 18:11:35 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E9A87AC7
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj4dLuJvgYZbljVOF8cxEdo9UxWNpzrYp5YkzB+7IFwNMVhDJRoo8CmsKpMTEc+/IyIsJhPJr6kdyZBfik6pXlnFTe9FPyQSGx5DcsNorqEz3grIY7XCUgziHVtFSK3IFXkmJTdhLxRhgmU9hVRAKaMNltRRVLSRpvTenfUFnwRALTjY7K1T8Gw5IycD3Oaz0nCt9UbQdyH2PxokAqU9XV//WptYtTU+aJfiiCjtB9sBTWcrcUOm5pGLr/fAhCk8z3u5UzSZfr5YPskublMZraWVML7Un409HNMxrXbfAzSyw1CDISonlZDY6uxOrLFIod69QVqidy2G/QFEC5CK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4gw9eRAC/A6U+snPJJk7AJP+LKn8Wa/YGk3BmrykCs=;
 b=kMIiJd4w0lxQeE9HwSxyegcR+lNUPpUX1upeK85FvzfcN/75TqG/t9dCAlN6b5wp8+In2PjIvh9B+/Qn85ktj3q49wtxW05NHTOFNMoNIF8gbUvcvTIvqAQ53U0Zpr/AFF6QznlJwpk/34lPPQnjaR4hEZ4yoLjtO598YXtourv0dgjvK9h7+kEYq88zf5Hh/9KXiNd5fp9F/dpCgVSth6/skU1P4cKsCM48r+o9jhHnn3KfPZ61EfSbyEAh1Wjii4VSdle3rF1F2Ycx8YY3hTZlsFHC2K4EIou4V7W4VCEAiC475Mjqk93lxvFBtCwC0cNiTkxwB8uBjmc8mX8Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4gw9eRAC/A6U+snPJJk7AJP+LKn8Wa/YGk3BmrykCs=;
 b=A+1bElWWIZxaPRCJQf8fZxvnVrcktcJhUls8b4dmvFaLRsZAIv/iKZznYO6jArqq2oK5mjyhfkAnM+BagrHzybSxgWxvOXNHjMGsECrXqML57a/nW4fx2lz2JvoQfOI+c4t6CtDOTK4db0zF4Z/SCjjOjQqaIhOgw+unI/qA6qI=
Received: from CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 17:11:28 +0000
Received: from CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe]) by CH2PR12MB5004.namprd12.prod.outlook.com
 ([fe80::cd8a:4814:157c:bbe%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 17:11:28 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
Subject: RE: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Thread-Topic: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Thread-Index: AQHaLcnrcXLqWFrP7kCnupYBvmLgQ7CnYXKAgAGWz9CAAAuZgIAAAGxg
Date: Thu, 14 Dec 2023 17:11:28 +0000
Message-ID: <CH2PR12MB500405650DD1385734E82341F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
References: <20231213134007.2818069-1-neal.frager@amd.com>
 <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
 <CH2PR12MB50043CB2CCF03CFF39ED5768F08CA@CH2PR12MB5004.namprd12.prod.outlook.com>
 <a366b338-7e02-42a4-b5ac-b295c37c0dfe@amd.com>
In-Reply-To: <a366b338-7e02-42a4-b5ac-b295c37c0dfe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_|PH8PR12MB6721:EE_
x-ms-office365-filtering-correlation-id: 7e1b636f-a021-4b69-83c3-08dbfcc7b5e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TB6Xsif4+TU4Uhfpn8WWoLd6bgJP3v0GMM12B6O6mZHOONaUXDhx9PBs+L3kCx6nnk86zNQ3Et8YUxEC63+uWep0fK7LpdIq4RqVRAC1x3cMCXvV/+7IJrvuaVvNk4wtzKbyep2Je8HIlGmV4AkxNzUDoYUSHaryiR8ogAUpqhWpPJm8H25PQOakdCRGjapF6LNaxsk115vWIuyN7Z2ePd7Vhu+Rr+bGv9g44Q66vg6QOSQRb/xJp9MjoVtN33eVz54rq2aYxecfQRxGh0A2TieW2GtC2s6qS4A9uYTy2WVTCUZw1SS4q4RL+ktPVxT2vGFsAs+PvkJDkjbvnOzTOAxQjPbjTpTuujwSiQL+T+eVPSEcNGaQH2qCiAGQd4lPcLiLLo5u4zJcRMV0dZB+0RCXoctyYIeLnk8J2GPeDzZ5/Uo96La2ASYWD228LnrjjcHWGEMhtFW+yaoWNmmdoazUIU8IzWHbs73vF8hUrzk4jDkBpX8JnHKGkshP+p6kOztEV+UXh+Jj8JwhmhK1o2qezvGzGi2zLc54HBYI3ToAT59ZZvOyjAxPr7yXjSsEDTirqWl/k9Qs6VlBI65sKBgjXrMr2mCxvsCTAiWGN9n53EGTFT+dysIyWwuAiHAI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(8936002)(4326008)(8676002)(71200400001)(83380400001)(478600001)(52536014)(110136005)(55016003)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007)(316002)(7696005)(6506007)(5660300002)(122000001)(2906002)(41300700001)(86362001)(38100700002)(33656002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHNnK0RLOXJaZnhNNEs3aFFwVXkrdFRXOTBZcEdMbU8vR1RvVm82dm1ya2Nu?=
 =?utf-8?B?QmQyazlyUjAwbnhDYXNXcFJBWEpQUEJBSUdKTnJWVDk1TE1wSmZ5SWJ4dUlN?=
 =?utf-8?B?V2VEWGRLZURhVUF5YjBpbzZHSUZ2UVRWT3V5T0N1S2Zabi9qcC9ZNXdPdWVO?=
 =?utf-8?B?VlVnNEhrYTRvODVxeG9PRDk5NWJYZm1oa3lNaEs5ZW01QTlJNHdtekxiWTZ4?=
 =?utf-8?B?WXBnYmkvdVUvSUVNNU1nQVVQbHBFdUdtUjZpVjhwNmF4UmhQM1BjZ2M1WWFB?=
 =?utf-8?B?YzV1K2RmZ2Q3M0VTWEVtUDVmVnRIczRJLy9ZRXRGbmU3dkFqdm83KzdhMmpG?=
 =?utf-8?B?MWdtaFZCVEpiWFR1Tk5RdVhheHFOTU00SFpSdDhWZGxEZWMySENDeHh4UkJH?=
 =?utf-8?B?RzNnSGxMbHlQeFg5RTZlWTU0cW5OOWNyQk1GZDM1S1d1bDVuaW9OdWtHMzMz?=
 =?utf-8?B?ejhyNnJmbE9NQ2M2NmtFaFhRbWt0SngxVis0ZU9DaytRSnR5dmJRYkNmT0oy?=
 =?utf-8?B?M3VEWnBQNTZnUTVTNGhYRE5NNTB4WmtyaWtybWtyT05QNmtkMitDL00yQVYz?=
 =?utf-8?B?YTdpQzBvdGV4cjhJZ0s3eFFuZUtsKzRoVU56VFVJVW0wM2szQVY0amJYcDlt?=
 =?utf-8?B?OTIxa0FFYS9pa0JwaUVRRHZ4T3pZN0lUVzlKRzZDSnVZSXVhTHJhQitmUVZn?=
 =?utf-8?B?cVJ3SThOaTcxbjVpSVZOcW5rUURrTkplNC9pUGh2UGlveEJWZ21RTzRraXhp?=
 =?utf-8?B?MUZwYmk2R3l0NlhOQnp4Yjd6enFnc1IxdEt1K0VjaHJqWUNrQ2xnenR5MDBQ?=
 =?utf-8?B?MHlqT3RMRW0yYXVJa0RYVDVNOUV4Q1h1dkVjY1ZQZDNOSjRzV1lCbUVQWEox?=
 =?utf-8?B?dnh5cXNoNG9ZZ0ZGaDV4a29CRXNCaXlKTng3UHIxVUppRm9tVlJwNU9RMXVy?=
 =?utf-8?B?cHF4Sk5idzBZS3V6SytXendScU41MXBRTjBSWitTYmFQVXVZNzQxbEQxYVlF?=
 =?utf-8?B?Vzl1S2hHQ2lEbnhocXpyS1RqTVc5VmtJenJVbDZBR1hzOUVmUUh3aW1McTZ2?=
 =?utf-8?B?VkxkdUVrbnV5R0lVOWZQaXNlUUpCZkV3QmVOMlFmaXhXU2FOcHdTSnNvV05o?=
 =?utf-8?B?MTFOV2c4UVpPTW9VZ0FReFFKZ281QkxXd1d6S2ZUcGtINzNnK3BqZTduWXBN?=
 =?utf-8?B?MTBuTFVFNnBGSVY0NXFaQUszYnRIalhUL1V0Nk80cmdCaTNta3owVkgvS3hM?=
 =?utf-8?B?d2pBWFdzdmhmeWx3S3ZwSWovOWhNeWw1R292UkNTUzRhTVRNd1JsUVQvV1c1?=
 =?utf-8?B?ZXdzZUIzaVRzNnppSnZaQTVYbm9xOFN6Skh3dmJIRkFvU2hacllWa2VJU0JE?=
 =?utf-8?B?c2VDRy9QQ1M0NURNSWE1dlI2dEN4QlZDU2pPUUlDUmlQUW1xa0tBeXlIWUxS?=
 =?utf-8?B?OStOMytQMUpKcFdKb0xZaHEyazN0a2FUUGRpMVpERHZIcGpPMFBSMEFiemhh?=
 =?utf-8?B?Vy91YlBiN0R4b2V0YTBwY1hMMDNvU0IwV214Z0tRQW16UGFTMUlyYnJiSm1H?=
 =?utf-8?B?UjFtRWVDQVlVSk1KK28yOW44c0ZpT3dsVmJLTHlSbjNiK2RCSDhpQjRoV3R4?=
 =?utf-8?B?MTRrczU2VnNyTUkyQWJTdVZpQTQ5Ri9yQWM1RGZONDU4dDE3UW1BcWtqc1dw?=
 =?utf-8?B?cjlLZDFNNDBra3NRd3pqQUlnWUJ6eVlqdDlGWXNhZlVsbndydGZRanoxY1JN?=
 =?utf-8?B?em5Hc0pvSDBLc0tGL2RoNjcrOGRNN3g1UHNaVVN6WUdUWkE2eC9ocmJIOHNS?=
 =?utf-8?B?UUNHdlM1V1pWSkY3VzVoWWUrTC9sdGtjeVpjL25EenlLMzBSZVVXRHkydWNB?=
 =?utf-8?B?NTBIN3FCR1BCSTZIWFozYWlFRFd2TUNWY1QzMmZYNXNnN2p4NUlJdldBM01u?=
 =?utf-8?B?WXZtWjBKTmE2cEt5S2lIYzl3SU9VNzV2MWFrZGRSWWNQYk5hZmVsR1haRG9M?=
 =?utf-8?B?amJFa1A4M0xZL1NxUy9JcjkwakFsRlVLYy9tUENmUFdjQ1BXSU5KMXd2QXhw?=
 =?utf-8?B?U3pmVS92NmVneklBbTBKY0RsT2NpcTNrVXFKaXp1dDVsNEorRmViVTFMNkFE?=
 =?utf-8?B?TXZHZmVUK2tIeC92ZkVlL2hXZ1dydmZsOVFydVU4YURCdnU3UkRlamJSSlNC?=
 =?utf-8?Q?p12DVhYWXWnSFBmflFZ92oU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1b636f-a021-4b69-83c3-08dbfcc7b5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 17:11:28.3532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWUztRBYgKgi+Ct8ujVik5lN+ILSlC4vRoP174ASt847vtKoqxp41cpGRBEGTDvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

SGkgTWljaGFsLA0KDQo+IA0KPj4gVGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgazI0IHNvbSBjbG9j
a2luZyBjb25maWd1cmF0aW9uIHN1Y2ggdGhhdCB0aGUgc2VyZGVzDQo+IA0KPj4gQ29ycmVjdHMg
dGhlIC4uLg0KPiANCj4gT2suDQo+IA0KPj4gY2xvY2tzIGFyZSBjb3JyZWN0bHkgZW5hYmxlZCBh
bmQgdGhlIHVzYjAgaXMgY29uZmlndXJlZCB0byB1c2UgdGhlIHBzZ3RyDQo+PiByZWZjbGsyIGZv
ciB1c2IzIG1vZGUuDQo+IA0KPj4gSSBzb3J0IG9mIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoaXMg
cGF0Y2ggYnV0IGl0IHNob3VsZCBiZSBiZXR0ZXIgZGVzY3JpYmVkLg0KPj4gUHJldHR5IG11Y2gg
c2VyZGVzIGNvbmZpZ3VyYXRpb24gc2hvdWxkIGJlIGNhbGxlZCBmcm9tIHUtYm9vdCBiZWNhdXNl
IHdlIGFscmVhZHkNCj4+IGhhdmUgcHNndHIgZHJpdmVyIGFuZCB1c2IzLjAgY2FuIGJlIGNvbmZp
Z3VyZWQgb3V0IG9mIGl0Lg0KPj4gQnV0IHdlIGNhbid0IHRvdWNoIGR3YzMgZHJpdmVyIG5vdyB0
aGF0J3Mgd2h5IHRoZSBvbmx5IHdheSB0byBkbyBpdCBpcyB0bw0KPj4gY29uZmlndXJlIHZpYSBw
c3VfaW5pdC4NCj4+IEJ1dCBpdCBzaG91bGQgYmUgY2xlYXIgZnJvbSBjb21taXQgbWVzc2FnZSB0
aGF0IGl0IGlzIHdvcmthcm91bmQgbm90IHJlYWxseQ0KPj4gc29tZXRoaW5nIHdoYXQgc2hvdWxk
IGJlIGhlcmUuDQo+IA0KPiBJIHdpbGwgcmUtdGVzdCB0aGlzIHdpdGhvdXQgdGhlIHNlcmRlcyBh
ZGRpdGlvbnMgdG8gc2VlIGlmIHRoZXkgYXJlDQo+IHJlYWxseSBuZWNlc3NhcnkuDQo+IA0KPj4g
VGhpcyBwYXRjaCBhbHNvIGNvcnJlY3RzIHRoZSBjb25maWd1cmF0aW9uIG9mIG1pbyBwaW5zIG1p
bzc2IGFuZCBtaW83Nw0KPj4gd2hpY2ggc2hvdWxkIGJlIGNvbmZpZ3VyZWQgYXMgZ3BpbyBwaW5z
Lg0KPiANCj4+IFRoaXMgaXMgZGVmaW5pdGVseSBmaW5lLg0KPiANCj4gR29vZC4NCj4gDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogTmVhbCBGcmFnZXIgPG5lYWwuZnJhZ2VyQGFtZC5jb20+DQo+IA0K
Pj4gWW91IG1lbnRpb25lZCB0aGF0IFNQTCBkaWRuJ3Qgd29yayBiZWZvcmUuIElzIGl0IGJlY2F1
c2Ugb2YgaW5jb3JyZWN0IHNlcmRlcw0KPj4gY29uZmlndXJhdGlvbj8gQmVjYXVzZSB0aGF0J3Mg
c291bmRzIHdlaXJkIGJlY2F1c2UgeW91IGRvbid0IG5lZWQgc2VyZGVzDQo+PiBpbml0aWFsaXph
dGlvbiBmb3IgYm9vdGluZyBvdXQgb2YgcXNwaS4gVGhhdCdzIHdoeSBsb29raW5nIGZvciB3aGlj
aCBpcyB0aGF0IGJpdA0KPj4gd2hpY2ggbWFrZSBTUEwgd29yayBvbiBLRDI0MC4NCj4gDQo+IFRo
ZSBTUEwgd29ya3MuICBUaGUgaXNzdWUgaXMgdGhlIHNhbWUgYXMgSSBoYWQgd2l0aCB0aGUga3Iy
NjANCj4gYm9hcmQuICBUaGUgc2QgY2FyZCBpbnRlcmZhY2UgaXMgb3ZlciB1c2IsIHNvIHVubGVz
cyB0aGUgdXNiMw0KPiB3b3JrcyBjb3JyZWN0bHksIHUtYm9vdCBoYXMgbm8gc2QgY2FyZCBpbnRl
cmZhY2UgYW5kIGNhbm5vdA0KPiBmaW5kIHRoZSBMaW51eCBrZXJuZWwgYW5kIGZpbGUgc3lzdGVt
Lg0KPiANCj4gU28gd2hhdCBJIG1lYW50IHdhcyB0aGF0IEkgY2Fubm90IGJvb3QgdXAgcHJvcGVy
bHkNCj4gd2hlbiBzdGFydGluZyBmcm9tIHRoZSBTUEwuICBUaGlzIGlzIHdoYXQgdGhpcyBwYXRj
aCBpcw0KPiBtZWFudCB0byBmaXguDQoNCj4gV2hhdCBJIGhhdmUgc2VlbiBvbiBLRDI0MCB3YXMg
dGhhdCBJIGNvdWxkIGdldCB0byB1LWJvb3QgcHJvbXB0LiBBbmQgZm9yIHRoYXQgDQo+IHlvdSBk
b24ndCBuZWVkIGFueSBzZXJkZXMgaW5pdGlhbGl6YXRpb24gYXQgYWxsLg0KDQpZZXMsIGFncmVl
ZC4gIEkgY2FuIGdldCB0byB1LWJvb3QgcHJvbXB0IHRvbyB3aXRob3V0DQphbnkgYWRkaXRpb25h
bCBwYXRjaGVzLg0KDQo+IEZvciBib290aW5nIE9TIHlvdSBuZWVkIGl0IGlmIHlvdSB3YW50IHRv
IHVzZSBVU0IzLjAuDQoNCkFuZCBmb3IgdGhlIGtkMjQwLCBzZCBjYXJkIHJlcXVpcmVzIHVzYjMu
MCBhbHNvLg0KDQo+IFRoYXQncyB3aHkgSSB3YW50IHRvIG1ha2UgaXQgY2xlYXIgd2hhdCBtYWtl
cyBrZDI0MCB0byBib290IHUtYm9vdC4NCj4gQW5kIHdoYXQgbWFrZXMgdG8gYWNjZXNzIHNkIG92
ZXIgdXNiIHRvIGJvb3QgT1MuDQoNClVuZGVyc3Rvb2QuICBUaGUgaXNzdWUgSSBhbSB0cnlpbmcg
dG8gc29sdmUgaXMgZW5hYmxpbmcNCnNkIG92ZXIgdXNiIHRvIGJvb3QgT1MuDQoNCj4gQW5kIG5v
IGlzc3VlIHRvIGFkZCBzZXJkZXMgaW5pdGlhbGl6YXRpb24gdG8gcHN1X2luaXQgdG8gZ2V0IGJv
b3QgT1MgcGFydCB0byANCj4gd29yayB0aWxsIHNvbWVvbmUgaGFzIHRpbWUgdG8gd2lyZSBwc2d0
ciBkcml2ZXIgd2l0aCBkd2MzIHRvIGNvbmZpZ3VyZSBpdCBhdCBydW4gDQo+IHRpbWUuDQoNCklz
IHNvbWVvbmUgY3VycmVudGx5IHdvcmtpbmcgb24gd2lyaW5nIHBzZ3RyIGRyaXZlciB3aXRoIGR3
YzM/DQoNCklmIHRoaXMgd2VyZSB0byBoYXBwZW4gc29vbiwgdGhhbiB0aGlzIHBzdV9pbml0X2dw
bC5jIHBhdGNoDQp3b3VsZCBiZWNvbWUgdW5uZWNlc3NhcnkuDQoNCkJlc3QgcmVnYXJkcywNCk5l
YWwgRnJhZ2VyDQpBTUQNCg==
