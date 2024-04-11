Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3498FCD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 01:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C918758B;
	Thu, 11 Apr 2024 03:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="ix0aSPsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08B688149; Thu, 11 Apr 2024 03:12:14 +0200 (CEST)
Received: from AUS01-ME3-obe.outbound.protection.outlook.com
 (mail-me3aus01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2818::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BA88701E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 03:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Leo_Maxwell@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITii3Yfa10iV/mS4OpPyJT7AYTpNXqjTk5VFjB8Wcz6gUEbjqEMcsLyX9TL3nLicL2G4fdLLz3A8IJcE7mCwxvU+nSRlZTZ49apXNdMq3hGorpOapL/aSzKF+/apiTwRNttbtESfFi5KwsHYsazcVaSk1r3cQe4U/oG13Jsk2gQtxxxKzvhxvudgmELndZvNy6wAtu6PNOPTh87HhfYHoMfkggm9EsVdnfTFUnKLVrNlWFQ9JLl/kQrifIy1wuqLGlPmU32U8/p+koxwuhCGoSAfc3A/QQnB8Zl8XKTMqrIMgxQVBtYsWvKbAtHuwJKir9ayFO67sb2QInrnAtTIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Cx4YNkrhKMqq7wtB2UmM/ndy1iiO7r8kDRW2EQCKV4=;
 b=MsRnB7S2QvyQ8+JwSe9ZHrHYnIIKW804H0+oFU2C64IJmEz6KSxdiXKFD78XxF6FPrhaRyVPW39qbVT1PM4p3uDo0h+9GqW9V+DURSu8PhBq/G+zILZx8oNwRAaERjTphhf0Eu0OtgWPLKM7ekfDI9GdTDR97hnhlktC2V5iMxSguO8MXRKUm/1ceGa2g0OvZ4616UoTO+fDLvLfBwEzBhniILC0I107JZ29C2I5nDb3BDuQWJO11x+Pgb4rCKxk//hcXsCukLNhpMTHyHgdTis/yzpQIT2OhVFOgsnbxZFG1FgTELFWRq0BdgWZT1TrG9GMudF8RAijhwYMStmicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Cx4YNkrhKMqq7wtB2UmM/ndy1iiO7r8kDRW2EQCKV4=;
 b=ix0aSPsbSyFb9goLKQHEcMF0WW+zBVKEmIbY2swqVC7kId4k2yC5itSro1ESQ46yXh+3y8zfd3YyD0Q6LEqAPVf1Oyd27UI5ZhkFnJc8EyO8xin5TiyXTFdNHROYuZG4WFS1NpeUBNyvoAHLXp6NioMSvIRXNi+1cEhSgnimhQmekgsH9lmlcQwPHH7WBnsEDV7dpE02+6segdjY4UDAcxc5YuMdkLddE/9UCiwEJ618u88OgojnWHIys3giDTbm5wAueoyCGOMmaYC2ZPQyXNDIcNr9eMKJrpKn40i10Piurhjfj8IkgWMZnq9O+zWYSPJQf3t1+1Z8+jewc83lNQ==
Received: from SY4P282MB2393.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:126::6) by
 ME4P282MB1064.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:95::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 11 Apr 2024 01:12:07 +0000
Received: from SY4P282MB2393.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f031:bba5:aded:b4cf]) by SY4P282MB2393.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f031:bba5:aded:b4cf%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 01:12:07 +0000
From: Maxwell Leo <Leo_Maxwell@outlook.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Tinkering Problems when Compiling on Apple Silicon
Thread-Topic: Tinkering Problems when Compiling on Apple Silicon
Thread-Index: AQHai61F3l7k7aO4iEyO+chjCRzj1Q==
Date: Thu, 11 Apr 2024 01:12:07 +0000
Message-ID: <5F58835A-DC85-480D-9623-7E8313E2F617@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [0gAMfouV8Lz192tNcyo/NDp5fz7p8gSJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY4P282MB2393:EE_|ME4P282MB1064:EE_
x-ms-office365-filtering-correlation-id: 178f283c-7f1d-49b2-9cda-08dc59c467f1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SkHU8IYnK+PqX9VusipX/KmWqSMF1TJ69zwEQT3+MvHy4pSgNFagQRZWECIfPY3gjzm98tFVmcZ2gQqwG5QdSVBeJpFE8t65d1Sxk64WlywXBfpToMK5d96m3BpJZBw4WGGRnUOKPDRQCDCnzlnIWVZIY5h4eyY3ebWTnfWLBPBFgFieo363JbGrGIV1XaXYZFbqUTPYT4EgWrvCL//eCxaHazW/66yXB29Z9IRjjOAfV7+8lMnnpwHoaE2Jvv0GvMWL9HnMDD2kqDWLFcLa45IwaxC30xh2Q5eGusGcoP5lr8GlvecYyxG+0wgte/NFojNUvmT+0vwhc07dgh0xaUWGxigLWnxuH/0p93r51skmBom2NKtJAmp5R55KQM7LyaW/MCUhheWHa4q+Pz73lima8MhM5oxr1WoDdEksBbA7pR9TpZpdq1ncmmozQKzHKCtM7M54v7uRWlTyxY14jVEQg/I55vFWJsMCIp/UbAEyLrl6pweyNQgoCjoUDHnDML4UkUa0c219y5mLCvFoyM8SoQNcl2x8UQWpHdVwaFJP8TJ8BgRting7jV5qaCsueVeBnCdzlLqUPUHYTF8Fr7ejJS9CusQ26OsvkAzqKPCdEipdrD6onOgdN5RYZT4hPv7UwhcvygUts7UwnnIIpQZoTHWG+OMYeuYxqZcuOlskRDhdxGmNOGWT9/5zrTsq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1F5Wm5wdXcyYjBoQXIzdjFtNTd6N3Q3Ry9zN1U1Z2dUOFVuKytYYXdYRTlY?=
 =?utf-8?B?S0hTTjhYT2NuT3M0c0pGOStwYmZYemcyTjRieGtvbXg2MERESU5Od0VqWGtD?=
 =?utf-8?B?TVNncVlPS3Y0N1o5VUZTKzhaODY4Ykx6dVd3S1VGRklPeHRpaGhObWJ1MVdQ?=
 =?utf-8?B?czR1ZWFaaGpSZjhQakRROWhUUnJUaUY2Y21EVWM2cjRPZTNScTlCMnZsOGtN?=
 =?utf-8?B?WjJoTmZWUXVzZVZOeWlENjZkTWhGRnRELzFNK0p4cnBJdmF2eVNRc3lVVWpy?=
 =?utf-8?B?WTQrSFRSa3dKc3FFbVMrOG1Wck5ma2pEcU5XQnU1NHBHeEpCTmNSY2VDcVEv?=
 =?utf-8?B?dytTM0t1NkZkV1Y5Q3pwZDJ4NWtxMW9ZNHg5aEpwaG50dW9xL296KzVpY2R3?=
 =?utf-8?B?dllqMWs5b1Q1LzkxRk1rbUpGNFk2dm96ckhaeGY3UHBmVXpiOXJ2RFVUbzBp?=
 =?utf-8?B?Tml5bGxoVHJCVG52ZUZDZGhLU1NNRHNUWHE1U0JkQWg2SmtoRUEwZU04Mm9H?=
 =?utf-8?B?U29DbVdGLy9iRDNDV3V0bm5hWTUwVDVDWTNxcVkyaEJTS20wS0tXbDFiRWl1?=
 =?utf-8?B?RVlwMENzU3lBdVF0Sjgzbm5tL3RkVXlWMEJXTGgwRHNTaUhKcmh6Y216Vmdv?=
 =?utf-8?B?UHc0bDFKYTVQOVVaQUdWRUtQckV1TFZHdUsxYmJMTlh5VWtYNzNiSzc2eS9N?=
 =?utf-8?B?VWlQM0kxWWNSVkJoYmZoNlZkSi9ldGNvRHZrKzBGRFUrTVl5TW1mTFozdkZa?=
 =?utf-8?B?ZlgrTHVGYjZyVElybXJZTFVobm9EbFNRbzZRNTB5WWowNE9zOTBjSEJmUld2?=
 =?utf-8?B?bGZmbzU2ZWEyVkVrWld2RUVpZGwzM1pGTmNmM3l5TnF3M3lGNWU2RnNiWlp4?=
 =?utf-8?B?MjN1MUh3NU1CMDgxZGZhN2tIQlQ0UThkVmV1UUl6ME1jSkYvSGtkcDFBR2ZC?=
 =?utf-8?B?TUJpYVlUWW8rODVXWDlnSUovb1QyRUxNYUJGdU1DU0k0eTd3WmFnZ2JJK3hJ?=
 =?utf-8?B?KzhlWnZqbHozVFU1V0V0TkpNVlVXMzVZT0lkT1BObmVhMlFOaVlsM2s0Qm00?=
 =?utf-8?B?dXhaNnhjMHFHbUxxdHZJTk16bWMxd0huNThrdVVORXNNSEdlSis2UitiTmgr?=
 =?utf-8?B?bzhNd1gwNHJtY3o5UWg4YW4vYk9mZk1QSE5SNkI0TzljVDFJTldIWmttT2d1?=
 =?utf-8?B?NGd5UDFvcmVOVERTMU4yNm9LdTNadkNTcDgxZ0FuTzYzVElNbGhPRjYyQkdt?=
 =?utf-8?B?RHFqcGNlYTBXOHkyZjFHMWZmU0Iza3FIYkw4cDdTMlUwanBCSmhVWTFBYWdm?=
 =?utf-8?B?SVdoSlBmb1U1Vm56Z2dhUFpDSk8vT0wzNXdraHZmeVJMRVBCemw1RjR1M3VK?=
 =?utf-8?B?Vk9UN3g0c2RzcVN5K1hQalhTZkUvSHdHM0daSXk5Y0ZlTkVGemVBTmh4ODdI?=
 =?utf-8?B?a3Y2N3ZsNUZoQlU4elkvRDlDVThwMTlNeitFelBTVmY4Qlh3NTNqM3dsbnhS?=
 =?utf-8?B?UVppeDRRMHJPcUlJYlZ6bzJvTmhqUlhSWVc4SUcxcVAzM2dMMmRPQ3kyQ1B6?=
 =?utf-8?B?MnA4N2hlbEozekt6ZDMvSVRkd253V2VwVTZyR2lOOUVMcGdKS2NpS1hiYTdY?=
 =?utf-8?B?M2t5SDkxcnBNeEd4dWI0TzNraXhuTk9kLzRCZ1V1VDY3cFJ2ZkprejIzL3Qy?=
 =?utf-8?Q?f7vZFeSCSHJv1ZM+glV8?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2393.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 178f283c-7f1d-49b2-9cda-08dc59c467f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 01:12:07.2028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1064
X-Mailman-Approved-At: Thu, 11 Apr 2024 03:23:26 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

RGVhciBEYXMgVS1Cb290IERldmVsb3BlcnM6DQoNCkkgcmVjZW50bHkgdHJpZWQgdG8gY29tcGls
ZSB0aGUgT3BlbldSVCBzeXN0ZW0gb24gYSBNYWMgd2l0aCBBcHBsZSBTaWxpY29uLCBidXQgZW5j
b3VudGVyZWQgcHJvYmxlbXMgcmVsYXRlZCB0byBVLUJvb3QuDQoNClRoZSBwcm9ibGVtIGlzIHRo
YXQgdGhlIGNvbXBpbGVyIGlzIG5vdCBhZGRpbmcgc3lzdGVtIFB5dGhvbjMgbGlicmFyeSBieSBk
ZWZhdWx0IHdoZW4gY29tcGlsaW5nIHRoZSBQeU1vZHVsZSBpbiBzb21lIGxpYnMsIHB5bGliZmR0
LCBmb3IgZXhhbXBsZS4gSW4gdGhlIE1ha2VmaWxlIG9mIHB5bGliZmR0LCB0aGUgbGluZSDigJwk
KGNhbGwgaWZfY2hhbmdlZCxweW1vZCnigJ0gIGludm9rZXMgdGhlIHB5bW9kX2NtZCBkZWZpbmVk
IGluIHRoZSBNYWtlZmlsZSwgYW5kIGl0IGZ1cnRoZXIgaW52b2tlcyB0aGUgZ2NjIGNvbW1hbmQg
YXMgYmVsb3c6DQoNCi9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9zdGFnaW5nX2Rpci9ob3N0L2Jp
bi9nY2MgLXNoYXJlZCAtTC9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9zdGFnaW5nX2Rpci9ob3N0
L2xpYiAtTC9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9zdGFnaW5nX2Rpci9ob3N0cGtnL2xpYiAt
TC9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9zdGFnaW5nX2Rpci90YXJnZXQtYWFyY2g2NF9nZW5l
cmljX211c2wvaG9zdC9saWIgLU8yIC1JL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L3N0YWdpbmdf
ZGlyL2hvc3QvaW5jbHVkZSAtSS9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9zdGFnaW5nX2Rpci9o
b3N0cGtnL2luY2x1ZGUgLUkvVm9sdW1lcy9EZXZlbG9wL29wZW53cnQvc3RhZ2luZ19kaXIvdGFy
Z2V0LWFhcmNoNjRfZ2VuZXJpY19tdXNsL2hvc3QvaW5jbHVkZSAtSS9Wb2x1bWVzL0RldmVsb3Av
b3BlbndydC9zdGFnaW5nX2Rpci9ob3N0L2luY2x1ZGUgLUkvVm9sdW1lcy9EZXZlbG9wL29wZW53
cnQvc3RhZ2luZ19kaXIvaG9zdHBrZy9pbmNsdWRlIC1JL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0
L3N0YWdpbmdfZGlyL3RhcmdldC1hYXJjaDY0X2dlbmVyaWNfbXVzbC9ob3N0L2luY2x1ZGUgLXN0
ZD1nbnUxMSAtSS9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9idWlsZF9kaXIvdGFyZ2V0LWFhcmNo
NjRfZ2VuZXJpY19tdXNsL3UtYm9vdC1uYW5vcGktcjJzLXJrMzMyOC91LWJvb3QtMjAyNC4wMS9z
Y3JpcHRzL2R0Yy9saWJmZHQgYnVpbGQvdGVtcC5tYWNvc3gtMTQuMC1hcm02NC1jcHl0aG9uLTMx
Mi9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9idWlsZF9kaXIvdGFyZ2V0LWFhcmNoNjRfZ2VuZXJp
Y19tdXNsL3UtYm9vdC1uYW5vcGktcjJzLXJrMzMyOC91LWJvb3QtMjAyNC4wMS9zY3JpcHRzL2R0
Yy9saWJmZHQvZmR0Lm8gYnVpbGQvdGVtcC5tYWNvc3gtMTQuMC1hcm02NC1jcHl0aG9uLTMxMi9W
b2x1bWVzL0RldmVsb3Avb3BlbndydC9idWlsZF9kaXIvdGFyZ2V0LWFhcmNoNjRfZ2VuZXJpY19t
dXNsL3UtYm9vdC1uYW5vcGktcjJzLXJrMzMyOC91LWJvb3QtMjAyNC4wMS9zY3JpcHRzL2R0Yy9s
aWJmZHQvZmR0X2FkZHJlc3Nlcy5vIGJ1aWxkL3RlbXAubWFjb3N4LTE0LjAtYXJtNjQtY3B5dGhv
bi0zMTIvVm9sdW1lcy9EZXZlbG9wL29wZW53cnQvYnVpbGRfZGlyL3RhcmdldC1hYXJjaDY0X2dl
bmVyaWNfbXVzbC91LWJvb3QtbmFub3BpLXIycy1yazMzMjgvdS1ib290LTIwMjQuMDEvc2NyaXB0
cy9kdGMvbGliZmR0L2ZkdF9lbXB0eV90cmVlLm8gYnVpbGQvdGVtcC5tYWNvc3gtMTQuMC1hcm02
NC1jcHl0aG9uLTMxMi9Wb2x1bWVzL0RldmVsb3Avb3BlbndydC9idWlsZF9kaXIvdGFyZ2V0LWFh
cmNoNjRfZ2VuZXJpY19tdXNsL3UtYm9vdC1uYW5vcGktcjJzLXJrMzMyOC91LWJvb3QtMjAyNC4w
MS9zY3JpcHRzL2R0Yy9saWJmZHQvZmR0X292ZXJsYXkubyBidWlsZC90ZW1wLm1hY29zeC0xNC4w
LWFybTY0LWNweXRob24tMzEyL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rpci90YXJn
ZXQtYWFyY2g2NF9nZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3UtYm9vdC0y
MDI0LjAxL3NjcmlwdHMvZHRjL2xpYmZkdC9mZHRfcm8ubyBidWlsZC90ZW1wLm1hY29zeC0xNC4w
LWFybTY0LWNweXRob24tMzEyL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rpci90YXJn
ZXQtYWFyY2g2NF9nZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3UtYm9vdC0y
MDI0LjAxL3NjcmlwdHMvZHRjL2xpYmZkdC9mZHRfcncubyBidWlsZC90ZW1wLm1hY29zeC0xNC4w
LWFybTY0LWNweXRob24tMzEyL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rpci90YXJn
ZXQtYWFyY2g2NF9nZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3UtYm9vdC0y
MDI0LjAxL3NjcmlwdHMvZHRjL2xpYmZkdC9mZHRfc3RyZXJyb3IubyBidWlsZC90ZW1wLm1hY29z
eC0xNC4wLWFybTY0LWNweXRob24tMzEyL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rp
ci90YXJnZXQtYWFyY2g2NF9nZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3Ut
Ym9vdC0yMDI0LjAxL3NjcmlwdHMvZHRjL2xpYmZkdC9mZHRfc3cubyBidWlsZC90ZW1wLm1hY29z
eC0xNC4wLWFybTY0LWNweXRob24tMzEyL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rp
ci90YXJnZXQtYWFyY2g2NF9nZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3Ut
Ym9vdC0yMDI0LjAxL3NjcmlwdHMvZHRjL2xpYmZkdC9mZHRfd2lwLm8gYnVpbGQvdGVtcC5tYWNv
c3gtMTQuMC1hcm02NC1jcHl0aG9uLTMxMi9zY3JpcHRzL2R0Yy9weWxpYmZkdC9saWJmZHRfd3Jh
cC5vIC1ML1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L2J1aWxkX2Rpci90YXJnZXQtYWFyY2g2NF9n
ZW5lcmljX211c2wvdS1ib290LW5hbm9waS1yMnMtcmszMzI4L3UtYm9vdC0yMDI0LjAxL3Njcmlw
dHMvZHRjL3B5bGliZmR0Ly4uL2xpYmZkdCAtbyBidWlsZC9saWIubWFjb3N4LTE0LjAtYXJtNjQt
Y3B5dGhvbi0zMTIvX2xpYmZkdC5jcHl0aG9uLTMxMi1kYXJ3aW4uc288aHR0cDovL2xpYmZkdC5j
cHl0aG9uLTMxMi1kYXJ3aW4uc28+DQoNCkFwcGFyZW50bHkgaXQgdHJpZXMgdG8gbGluayBzZXZl
cmFsIGZpbGVzIHRvZ2V0aGVyIGJ1dCBpdCBnaXZlcyB0aGUgZXJyb3I6DQoNCmxkOiB3YXJuaW5n
OiBzZWFyY2ggcGF0aCAnL1ZvbHVtZXMvRGV2ZWxvcC9vcGVud3J0L3N0YWdpbmdfZGlyL3Rhcmdl
dC1hYXJjaDY0X2dlbmVyaWNfbXVzbC9ob3N0L2xpYicgbm90IGZvdW5kDQpVbmRlZmluZWQgc3lt
Ym9scyBmb3IgYXJjaGl0ZWN0dXJlIGFybTY0OiAiX1B5QXJnX1VucGFja1R1cGxlIiwgcmVmZXJl
bmNlZCBmcm9tOiBfU3dpZ1B5T2JqZWN0X293biBpbiBsaWJmZHRfd3JhcC5vICJfUHlCb29sX0Zy
b21Mb25nIiwgcmVmZXJlbmNlZCBmcm9tOiBfU3dpZ1B5T2JqZWN0X3JpY2hjb21wYXJlIGluIGxp
YmZkdF93cmFwLm8gX1N3aWdQeU9iamVjdF9vd24gaW4gbGliZmR0X3dyYXAubyAiX1B5Qnl0ZUFy
cmF5X0FzU3RyaW5nIiwgcmVmZXJlbmNlZCBmcm9tOiBfX3dyYXBfZmR0X21hZ2ljIGluIGxpYmZk
dF93cmFwLm8gX193cmFwX2ZkdF90b3RhbHNpemUgaW4gbGliZmR0X3dyYXAubyBfX3dyYXBfZmR0
X29mZl9kdF9zdHJ1Y3QgaW4gbGliZmR0X3dyYXAubyBfX3dyYXBfZmR0X29mZl9kdF9zdHJpbmdz
IGluIGxpYmZkdF93cmFwLm8gX193cmFwX2ZkdF9vZmZfbWVtX3Jzdm1hcCBpbiBsaWJmZHRfd3Jh
cC5vIF9fd3JhcF9mZHRfdmVyc2lvbiBpbiBsaWJmZHRfd3JhcC5vIF9fd3JhcF9mZHRfbGFzdF9j
b21wX3ZlcnNpb24gaW4gbGliZmR0X3dyYXAubyDigKYNCg0KQnV0IGludGVyZXN0aW5nbHkgZW5v
dWdoLCB3aGVuIEkgbWFudWFsbHkgYWRkIHRoZSBsaWJyYXJ5IGF0IOKAnC9vcHQvaG9tZWJyZXcv
Q2VsbGFyL3B5dGhvbkAzLjEyLzMuMTIuMl8xL0ZyYW1ld29ya3MvUHl0aG9uLmZyYW1ld29yay9W
ZXJzaW9ucy8zLjEyL2xpYi9saWJweXRob24zLjEyLmR5bGli4oCdIHRvIHRoZSBmaXJzdCBnY2Mg
Y29tbWFuZCwgaXQgcnVucyBmaW5lLiBIZW5jZSBJIHRoaW5rIHRoZSBsaWJyYXJ5IGlzIHRoZSBt
YWluIHByb2JsZW0gaGVyZS4NCg0KQWZ0ZXIgZXhlY3V0aW5nIHRoZSBtb2RpZmllZCBjb21tYW5k
LCB0aGUgY29tcGlsZSBnb2VzIG9uIHdpdGhvdXQgY29tcGxhaW5pbmcgYXQg4oCcUFlNT0QgcmVi
dWlsZOKAnSwgYnV0IHNpbWlsYXIgcHJvYmxlbXMgb2NjdXJlZCB3aXRoIG90aGVyIGxpYnMuDQoN
CkFzIG1hY09TIGlzIGEgY29tcGxldGVseSBQT1NJWCBjb21wYXRpYmxlICpuaXggb3BlcmF0aW5n
IHN5c3RlbSBhbmQgQVJNNjQgaXMgYmxvb21pbmcsIEkgc2luY2VyZWx5IGhvcGUgdGhhdCB5b3Ug
Z3V5cyBjb3VsZCBjb25zaWRlciBmaXggdGhlIGNvbXBpbGluZyBvbiBBcHBsZSBTaWxpY29uIHBs
YXRmb3JtLiBUaGFua3MhDQoNCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5Lg0KDQpMZW8g
TWF4d2VsbA0KQXByIDExdGgsIDIwMjQNCg0K
