Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D15CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 11:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1528341A;
	Fri, 15 May 2026 13:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJapwbv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E38283AA9; Fri, 15 May 2026 13:13:22 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F9880086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ9OMKdzVTEbWSwixvwu0V4ccH7+qhPQ9qKm1rjjhHBj+J//Yo9PDmgv+NDeI0yw+2c4xii9681zoEC2UNnItc6wBwhsfuCkHCh/BUtcWxNBRDO91m7K5GV35QcLPLhkjuB6tUj59R4JKE+llF2qbGIB+RrbHaKu1do4luoIV07emsmLgwcLfz4DcmXQKUyLw8hoo2rOQF7VFYwm/0BrykN3DO+p+/HcXTpPVWrbL5gw8TZEgLYcMWrSBvSIgFJ8NxrIKqaI9jTcI4cUkPKKbLeezOxIuw7piTPKDfbCSAfl6Lp49dYj5s0RqLtzHMH9mLmbdYyra2uBJeOFffCYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aUqCc/aQbOv6A1WIClOLMk3Yl02idDF4GzmEHYmKWY=;
 b=X68t+p8chqrFvG+pNaF5O8NP6PXjA+HmhmCE6Y5Mp5pyb7aj7tBHaYqsKvki+houqb1xXR0oricXoiaIgFMyv+U7UgjI8TvXpqTnGAipAvB9EQGl6Gl1S3obaq/lQMjHbV9MwlPKEBXIywKqBy5m98CemafSxBdlejbTJH4wKlbBOpxtX3OiM/cbeynKFIYKfU6DdH68lIEcqnWN1qZCE7R8AWP5ilBQ6Au2c+hJDlaWd7BCSN/bnuZ3oCrHvEkwmilDmFiIxZ0UkmEGUhVv45kSvIEQ3gw9BrM4MmI7ueZ6ijOZbFdCHLtCOwMWGlPRO1rvlXie25nKJjgvzi9GtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aUqCc/aQbOv6A1WIClOLMk3Yl02idDF4GzmEHYmKWY=;
 b=bJapwbv6cVVjjo4F29KXQ5QOR+hlAshr9+8k9ykJfIfSsAnigHEdEWO/hrQkZsGb7Jqz5JcynDwhMP0oL8tKtT8AuBw4sqGu8re6ZMs9dEgWmShacExIceCTewuMhs3aaQrhR4RLWesZ6YqB5FLpNVBX+5kUorzIUI5/Yv/H0/k=
Received: from MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 11:13:12 +0000
Received: from MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049]) by MW6PR12MB7088.namprd12.prod.outlook.com
 ([fe80::e56b:9894:876a:c049%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 11:13:12 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Simek, Michal" <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Tom
 Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Lucien.Jheng <lucienzx159@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, SkyLake.Huang
 <skylake.huang@mediatek.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: RE: [PATCH v5] net: phy: fix duplicate eth_phy binding
Thread-Topic: [PATCH v5] net: phy: fix duplicate eth_phy binding
Thread-Index: AQHc4t09BX5YL+ZazkKwIOJv7wJtObYL9dwAgAL5frA=
Date: Fri, 15 May 2026 11:13:11 +0000
Message-ID: <MW6PR12MB708859452C870D4233A80B12FB042@MW6PR12MB7088.namprd12.prod.outlook.com>
References: <20260513133344.1288865-1-pranav.vinaytilak@amd.com>
 <5f8a52d8-765b-4a52-96b3-1258558bd500@mailbox.org>
In-Reply-To: <5f8a52d8-765b-4a52-96b3-1258558bd500@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-15T11:09:13.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7088:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: 34735e20-3e8f-4474-a45e-08deb272f3ce
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021|18002099003|22082099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: bqZa31R86d1Agb5D8sIRrFoAeB+kUsN/ch4P9FzdjHaQ+sEr9AtU9svMVQkinSQbXyZbWD6MGbMV/SQFsyCoUNoFjlUzG4fGCuq9f696S1kSCKxGhkmP9N86RZuuF2Wvyqi61RY7qF1s6DjwqbMKFa+lmbo/9erYV6YS355BRYK7ZUW8chh5MNZw6AWrwT8FKWeqSZUbc3lLKcFvZmEjLlzaAQcOJ3B3+Z8VEABZuuUwo8T82gfEJi5w6dFIcsTYRpyb++PHL0hE8Y82coSQoFv28wTb8105joiM5eOvcJxCIx+htDKK17ZcrJh7juj2wC+0hJOV0EKBfRBjO/SPsiQGjqUB59MYwg6+pSpRmQc/fMdEnHYXW817SgOeGJJedF8QYcHTev2JZflwJFOgWEaGbxULMDRj+IEIQrcece6S/+3d+54dUSdLgjbrsmRyIOT+Zepi9yOSH6MTvNhbjiyIb8lZR6z68IClXfryn0rulSxdCitR5cUqcGWRDTtCHtXtoCzhLTk97jO4Ujv0GPsoMMsIE4o/n+LoQRbrPJ3A4hPyw8JWtE7gMD230bRssVUtcjcje6WKNaj+R2W/T8yEllbCtHPPRW6+Hv+3wtkjG4IEq4Yky9fHFlHacJn1+O9qmfJRVo6ttpRAc3ZDa6mIS0ruwLmEpHebvMlP5DVHlx8MZxiy+RnEe23zeSTEnQN21vfDNHq7iDs4BKSdfKB5HAAvX33WwRmh9riwyfZvysfCMtTk61GB0R+7SZPn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7088.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZIMWRnMXpQSnA1ZnM1V1JqRnl0dXdwV0ZhOUNhZjFaWjVDRXRmb3JQZERo?=
 =?utf-8?B?Uy9SQzdEUzFFd3BVeWUxR2NaaTE2TWtDU1ZVUmN6cUJPcENGTnlYaWxqZmMw?=
 =?utf-8?B?cHBnL093bnhpZ2t0VHZsNUdOQU50VzJqSTNCU2JENjFEb09NNHlQbzR3T0Zs?=
 =?utf-8?B?dlJSSVBVQVcyMDNFeTFGMVdCSmxrUUFUTzNNYU5kZS8zTlRFTGlNRmlkbzZo?=
 =?utf-8?B?VG9QZGY5a2t3WlBsdkNoSXpSWmRva0FOWlNjOFFrSFVoWXQ2d1luOHVuVEta?=
 =?utf-8?B?czdONWo4d08yOHkxSzlhZ0ZXaHB4RURra3pPR0NuWWVRQTVsZWFwN0VGUW1v?=
 =?utf-8?B?VDlRVlZVQS91UDlpSjNJZlJSWmdXWEd3VlovT0l4U2UrUG12VlBqaUZ1VUEy?=
 =?utf-8?B?Nllpd3dqOStJeFozU3drYVZlTm0yRHJzL2RoWkFJYUZlVnhHN3FwZ3A5Ukp5?=
 =?utf-8?B?SzRNeE9QMHJ5Z2pLeDM1TVlrOUNUK0lJeW50Mm1SRFlPeFgxYnZCUVR2U09X?=
 =?utf-8?B?aGVwdGpBMjJnbCtyemdWd2FLaXI0VG9vMXpUWDg0YzNHYnFrRFBOVnloTStE?=
 =?utf-8?B?ckVoQnNHSXB3UnVFTGgyY29MTk1kTjRrTWs2RWlpT1luS3BLcXRxR2tMWmZ0?=
 =?utf-8?B?MFdlckg2NmNMYnZ6Nkx6N1B1L09JODB2NmdDZU9Xd1g1eGxBSjBpUVFrcGlS?=
 =?utf-8?B?amNuS0cyanJ4MzdFVFIzVzFKTkJCdGw0Vit0dVVKQzdNbzlaanU2c3BzV2wz?=
 =?utf-8?B?NEx5TDhxN3Mya3drNzlxQnh3MzhGUktkck52eWllTVNXczZ0SENRZmF3Zml5?=
 =?utf-8?B?MThPY1dJUUo2NFN0bW8yZjVDNlJJZ2xrWjhpc1BBWTQvZWc2akV3NjJQWGRn?=
 =?utf-8?B?R0lnRllXelk5eWJJbDJkb2pnZkRZbmIyaDM0dlA2Q3RLQ2VyWk1aRWdSNUJi?=
 =?utf-8?B?bWFrdXJxaEltSSs2RTQ2K1poSlFvUDVwSGYzNjh0b2pObTRwYnpadkNHZFpy?=
 =?utf-8?B?NzFqbW9KMzUxMVUrTHBweWFaVTdXZFRna1VZRDFhM0tKSzBzUTJETStOSE9a?=
 =?utf-8?B?bUNycUMxaGxudlVlN3dDZE1EU1ovbDA4S3hXWnlGTFRjV0tBaFVpM3pnU2oy?=
 =?utf-8?B?d0toMlpwVTVtbFhlSW9TSEVkN3pUektvRms5eHJQbGttUFdHUVExanJsRGJu?=
 =?utf-8?B?dDJjZnRvUlNjaXc3dmVPUERwT1p2NDU3UEFhUWxURHhnRjJLTzNKdlMzRkVn?=
 =?utf-8?B?SXRtRU9zTGxxLzRBT1RKclIrSHVaY21paC9QWVhCNXcxeDVGd05aUmpib3Ay?=
 =?utf-8?B?WXJmMXdra1g2SDJoK044bEFWWjh3WVBLNnRoSThSUlovbG1pVlFYa2pTbkNl?=
 =?utf-8?B?Y1FrWTRuRUNCQ2V3aVlEak5WQ1BNeStsM1RPQzNrdmRobUdOdXY4ZTlwYmFt?=
 =?utf-8?B?M0xjdjFKSDgwV2E3Q1J5NkZHaTdOeDZQT1JzbWtwTXJIbXA0SjJZUWhIdEV2?=
 =?utf-8?B?bkVYMVFsUkM2cWhzNndlOW52aVo5UisvMEZDdE10ajJyREZPUVQ2Ym5zRTJz?=
 =?utf-8?B?UGZVT0s0TFVadkkwVGhQY3NSTnRRR0hMRDdFYjBCZDFYN1RZbXYvTTlORkFG?=
 =?utf-8?B?QnljOFRRMW9SRGhOWXh6aUYyRUxQTmR6VnNkWXpVSDk5SE9iUzVTMXpydHN0?=
 =?utf-8?B?ODdnMjZyZkhEZXpzU0dhYzdtZEZuM3RoT3l0T2xUUGF2bzhmRll6T1FYcUNh?=
 =?utf-8?B?S21qb3h1V2J2VlFBYmpKRTBvU0szUlNPREJWa0VUL0NpN3ZsZU84S3hDWm1s?=
 =?utf-8?B?K0xVSmI1QWZKL1NubFMvRzRLRnhwNHkrWnZ1UnlqRDF6b09aQklmanFFRFMz?=
 =?utf-8?B?ZTlla1RQczNhRzZ5T01MKzJVSFhVVU80Zms2TkNycEwrZ1BmRUNSbnVnVXlD?=
 =?utf-8?B?YmZ3UytKWm8wYWdHSzl1SktqZkptN0JqNGd0SmY1ME95QWViajArY0p5NjFZ?=
 =?utf-8?B?N25tSlplOUg3QzFVRjQ4ZnhWVTBTMkJhNG5PMHRXVS8yMi9UdkRZbFFQSXFL?=
 =?utf-8?B?TGpQUnc2L2Y2cE9pWUppSFJ5Smlxc0YzTWZhNERMa1JQK1JYOFU3LytxU1dV?=
 =?utf-8?B?ZERTUGMrQ29LYllGZENvZ1E2N3lSckZaQWNBcWJ1b2V2NmJvdk5wUFUzdnA2?=
 =?utf-8?B?QndqdHBsRVpLbUo3aWJNZ0I0SDBWQWxSNDNBUDJJUGlDMituQU92SVhBYTIz?=
 =?utf-8?B?bmE3bTVNc0c2aU5IdlQ4a3I2ZGJOYUg5RlVITG83YU5NVm9mZzZlL2xpZUhD?=
 =?utf-8?Q?PfoxUrtWInt9Ugk93B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34735e20-3e8f-4474-a45e-08deb272f3ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 11:13:11.8536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjrnNlgV1OLap7IgyfjWLkm300cqi3/xx6Z8xv5N7r8zCDYe9v//OgRLxPcuimwZmcWD8ls9dckeLfa3e5nT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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

UHVibGljDQoNCkhpIE1hcmVrLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXkgMTMsIDIwMjYgNzowOSBQTQ0KPiBUbzogVmluYXkgVGlsYWssIFByYW5hdiA8UHJh
bmF2LlZpbmF5VGlsYWtAYW1kLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gQ2M6IGdpdCAoQU1ELVhpbGlueCkgPGdp
dEBhbWQuY29tPjsgQmVnYXJpLCBQYWRtYXJhbw0KPiA8UGFkbWFyYW8uQmVnYXJpQGFtZC5jb20+
OyBKZXJvbWUgRm9yaXNzaWVyDQo+IDxqZXJvbWUuZm9yaXNzaWVyQGFybS5jb20+OyBUb20gUmlu
aSA8dHJpbmlAa29uc3Vsa28uY29tPjsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBQ
YXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBmb3NzLnN0LmNvbT47DQo+IEx1Y2llbi5K
aGVuZyA8bHVjaWVuengxNTlAZ21haWwuY29tPjsgU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy0NCj4g
dmFkYXBhbGxpQHRpLmNvbT47IFNreUxha2UuSHVhbmcgPHNreWxha2UuaHVhbmdAbWVkaWF0ZWsu
Y29tPjsgTWFyZWsNCj4gVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBS
YW1vbiBGcmllZA0KPiA8cmZyaWVkLmRldkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjVdIG5ldDogcGh5OiBmaXggZHVwbGljYXRlIGV0aF9waHkgYmluZGluZw0KPg0KPiBPbiA1
LzEzLzI2IDM6MzMgUE0sIFByYW5hdiBUaWxhayB3cm90ZToNCj4gPiBXaGVuIGJvdGggQ09ORklH
X1BIWV9FVEhFUk5FVF9JRCBhbmQgQ09ORklHX0RNX0VUSF9QSFkgYXJlDQo+IGVuYWJsZWQsDQo+
ID4gZXRoX3BoeV9iaW5kc19ub2RlcygpIGNhbGxlZCBmcm9tIGV0aF9wb3N0X2JpbmQoKSBhbHJl
YWR5IGJpbmRzIHRoZQ0KPiA+IGV0aGVybmV0IFBIWSBub2RlIHRvIGV0aF9waHlfZ2VuZXJpY19k
cnYuIEhvd2V2ZXIsDQo+ID4gcGh5X2Nvbm5lY3RfcGh5X2lkKCkgY2FsbGVkIHZpYSBwaHlfY29u
bmVjdCgpIGFsc28gYmluZHMgdGhlIHNhbWUgUEhZDQo+ID4gbm9kZSwgcmVzdWx0aW5nIGluIGR1
cGxpY2F0ZSBlbnRyaWVzIGluIHRoZSBETSB0cmVlLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgY2hl
Y2tpbmcgYXQgdGhlIGJlZ2lubmluZyBvZiBwaHlfY29ubmVjdCgpIHdoZXRoZXIgdGhlIFBIWQ0K
PiA+IGlzIGFscmVhZHkgYm91bmQgdmlhIHVjbGFzc19maW5kX2RldmljZV9ieV9waGFuZGxlKCku
IElmIHNvLCBza2lwIGFsbA0KPiA+IGdlbmVyaWMgYmluZGluZyBtZXRob2RzIGFuZCBmYWxsIHRo
cm91Z2ggdG8gcGh5X2ZpbmRfYnlfbWFzaygpLiBBbHNvDQo+ID4gYXNzaWduIHBoeWRldi0+bm9k
ZSBmcm9tIHRoZSBhbHJlYWR5IGJvdW5kIERNIGRldmljZS4NCj4gPg0KPiA+IEZpeGVzOiA2OGE0
ZDE1MDYxMDkgKCJuZXQ6IHBoeTogQmluZCBFVEhfUEhZIHVjbGFzcyBkcml2ZXIgdG8gZWFjaCBu
ZXcNCj4gPiBQSFkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYW5hdiBUaWxhayA8cHJhbmF2LnZp
bmF5dGlsYWtAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+IC0gVXNl
IGludCByZXQgaW5zdGVhZCBvZiBib29sIHBoeV9ib3VuZCBhbmQgZ290byBvdXQNCj4gPg0KPiA+
IENoYW5nZXMgaW4gdjQ6DQo+ID4gLSBSZW1vdmVkIElTX0VOQUJMRUQoQ09ORklHX0RNX0VUSF9Q
SFkpLCB1c2UgcnVudGltZSBjaGVjayB2aWENCj4gPiAgICB1Y2xhc3NfZmluZF9kZXZpY2VfYnlf
cGhhbmRsZSgpDQo+ID4gLSBGaXggaW5kZW50YXRpb24gb2YgYmluZGluZyBtZXRob2RzIGJsb2Nr
DQo+ID4gLSBBc3NpZ24gcGh5ZGV2LT5ub2RlIGZyb20gdGhlIGJvdW5kIERNIGRldmljZSdzIG9m
bm9kZQ0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIE1vdmVkIGR1cGxpY2F0ZSBiaW5k
aW5nIGNoZWNrIHRvIGJlZ2lubmluZyBvZiBwaHlfY29ubmVjdCgpDQo+ID4NCj4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+IC0gTW92ZSBkdXBsaWNhdGUgYmluZGluZyBjaGVjayB0byBjYWxsZXIgcGh5
X2Nvbm5lY3QoKQ0KPiA+IC0gVXBkYXRlIGNvbW1pdCBkZXNjcmlwdGlvbg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9uZXQvcGh5L3BoeS5jIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9waHkvcGh5LmMgYi9kcml2ZXJzL25ldC9waHkvcGh5LmMgaW5kZXgNCj4gPiBkN2UwYzRm
ZTAyZC4uN2Q2OThmMDBjMDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L3BoeS5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L3BoeS5jDQo+ID4gQEAgLTI0LDYgKzI0LDcgQEAN
Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Vy
ci5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLmg+DQo+ID4gKyNpbmNsdWRlIDxk
bS91Y2xhc3MtaW50ZXJuYWwuaD4NCj4gPg0KPiA+ICAgLyogR2VuZXJpYyBQSFkgc3VwcG9ydCBh
bmQgaGVscGVyIGZ1bmN0aW9ucyAqLw0KPiA+DQo+ID4gQEAgLTkyNyw2ICs5MjgsMTQgQEAgc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoeV9jb25uZWN0KHN0cnVjdCBtaWlfZGV2DQo+ICpidXMsIGludCBh
ZGRyLA0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2ID0gTlVMTDsN
Cj4gPiAgICAgdWludCBtYXNrID0gKGFkZHIgPj0gMCkgPyAoMSA8PCBhZGRyKSA6IDB4ZmZmZmZm
ZmY7DQo+ID4gKyAgIHN0cnVjdCB1ZGV2aWNlICpwaHlfZGV2Ow0KPiA+ICsgICBpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArICAgLyogU2tpcCBiaW5kaW5nIGlmIFBIWSBhbHJlYWR5IGJvdW5kIGJ5IGV0
aF9waHlfYmluZHNfbm9kZXMoKS4gKi8NCj4gPiArICAgcmV0ID0gdWNsYXNzX2ZpbmRfZGV2aWNl
X2J5X3BoYW5kbGUoVUNMQVNTX0VUSF9QSFksIGRldiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgInBoeS1oYW5kbGUiLCAmcGh5X2Rldik7DQo+ID4gKyAgIGlm
ICghcmV0KQ0KPiA+ICsgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+DQo+ID4gICAjaWZkZWYgQ09O
RklHX1BIWV9GSVhFRA0KPiA+ICAgICBwaHlkZXYgPSBwaHlfY29ubmVjdF9maXhlZChidXMsIGRl
dik7IEBAIC05NDcsOSArOTU2LDEzIEBADQo+IHN0cnVjdA0KPiA+IHBoeV9kZXZpY2UgKnBoeV9j
b25uZWN0KHN0cnVjdCBtaWlfZGV2ICpidXMsIGludCBhZGRyLA0KPiA+ICAgICAgICAgICAgIHBo
eWRldiA9IHBoeV9jb25uZWN0X2dtaWkycmdtaWkoYnVzLCBkZXYpOw0KPiA+ICAgI2VuZGlmDQo+
ID4NCj4gPiArb3V0Og0KPiA+ICAgICBpZiAoIXBoeWRldikNCj4gPiAgICAgICAgICAgICBwaHlk
ZXYgPSBwaHlfZmluZF9ieV9tYXNrKGJ1cywgbWFzayk7DQo+ID4NCj4gPiArICAgaWYgKHBoeWRl
diAmJiAhcmV0ICYmICFvZm5vZGVfdmFsaWQocGh5ZGV2LT5ub2RlKSkNCj4gPiArICAgICAgICAg
ICBwaHlkZXYtPm5vZGUgPSBkZXZfb2Zub2RlKHBoeV9kZXYpOw0KPiBJcyB0aGUgIXJldCB0ZXN0
IG5lY2Vzc2FyeSBpbiB0aGlzIGNvbmRpdGlvbmFsID8NCg0KWWVzIGkgY2hlY2tlZCwgIXJldCBp
cyBuZWNlc3NhcnkgYXMgdWNsYXNzX2ZpbmRfZGV2aWNlX2J5X3BoYW5kbGUoKSBhbHdheXMgc2V0
cyBwaHlfZGV2PSBOVUxMIG9uIGVudHJ5LCB3aGVuIGl0IGZhaWxzIHRvIGZpbmQgYW4gYWxyZWFk
eSBib3VuZCBQSFkgcGh5X2RldiBpcyBOVUxMLiBSZW1vdmluZyAhcmV0IHdvdWxkIGNhbGwgZGV2
X29mbm9kZShOVUxMKSB3aGljaCBkZXJlZmVyZW5jZXMgYSBOVUxMIHBvaW50ZXIgYW5kIGNyYXNo
ZXMuDQoNCiFyZXQgYWxzbyBzZXJ2ZXMgYXMgYSBndWFyZCBmb3IgdGhlIGFzc2lnbm1lbnQgb2Yg
cGh5ZGV2LT5ub2RlIGl0IHNob3VsZCBvbmx5IGhhcHBlbiB3aGVuIHRoZSBQSFkgaXMgYWxyZWFk
eSBETSBib3VuZC4gV2hlbiBiaW5kaW5nIG1ldGhvZHMgcnVuIChyZXQgIT0gMCksIHRoZXkgYWxy
ZWFkeSBzZXQgcGh5ZGV2LT5ub2RlIGNvcnJlY3RseSBzbyBubyBuZWVkIHRvIGFnYWluIHNldCBw
aHlkZXYtPm5vZGUgaW4gdGhhdCBjYXNlLg0KDQpUaGUgIW9mbm9kZV92YWxpZChwaHlkZXYtPm5v
ZGUpIGNoZWNrIGlzIHJlZHVuZGFudCBhbmQgY2FuIGJlIGRyb3BwZWQuIEluIHRoZSByZXQgPT0g
MCBwYXRoLCBvbmx5IHBoeV9maW5kX2J5X21hc2soKSBydW5zIGFuZCBpdCBuZXZlciBzZXRzIHBo
eWRldi0+bm9kZSwgc28gIW9mbm9kZV92YWxpZChwaHlkZXYtPm5vZGUpIGlzIGFsd2F5cyB0cnVl
Lg0KSGVuY2UgY29uZGl0aW9uIGNhbiBiZSBzaW1wbGlmaWVkIHRvOg0KDQppZiAocGh5ZGV2ICYm
ICFyZXQpDQogICAgcGh5ZGV2LT5ub2RlID0gZGV2X29mbm9kZShwaHlfZGV2KTsNCg0KVGhhbmtz
ICYgcmVnYXJkcywNClByYW5hdiBUaWxhaw0K
