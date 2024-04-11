Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22DDCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C96B8816C;
	Thu, 11 Apr 2024 07:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rad.com header.i=@rad.com header.b="gb+OtQ3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21AA87FED; Thu, 11 Apr 2024 07:26:39 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C81881D0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lev_o@rad.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFQtvL0ytL1RXgU8sCwAxN4nnkkUMn9IO4QVPtOd8ridFw39zopFzFAC8GrdjxtuMjJo8bxZFuTPR+hjpmbzem5+PspeQmIhzf0SnfeN1wa3BiEzoz42bTm9KVrJmJdtdLnDMse0TS+jYQ7IsBykjUjgaZVMCfttE+nILAnB3zKsiF0j9XHUTD9vPfUs5YEuljRmilJrdPlVZMSx3FFPwkal+PECaXYeWYYlU1ZGZPaeT0yvfgKCpVYZufwwXdGZMgZuh0eUeZjOYPrvzQe9SFuug0xEtL5g4SeFHkD3ve61MeM3AkNj+zhmhLq5Zz4AQDbNQMn2PwPmHjv+4EAAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhYifwde7Y5yS+dCz0RzF/pb/UOj2QDJRg3bLyM6mes=;
 b=LMsOfmaW9hmPK0+/iWpQYSmibSFVgHZB5PxpF85Lb1KAWoj/kvcTgUvdREkfBCOV540zj6jsgziP1uXTvC/9XGUZo44R3L7tBow4WGomsY0qup+Q5vf53gfb/iTFrxi7L621r7eRROp8vBxO8MZQlXfOENZ0KK9/XNSwmnKvRTfvQLDls/bXBZIOprVHfHr4IaM0yhrlaxR0qAwuMAD3J8ZNq4GrpF3JVEtAWHIuKQlsgMjSpf6vlMWYztRmEgiArttD5LxiSKt3dSU90pzZwm6qzGZ5jUT/CO/m72rnDj3iCLmBQ9K8y0XNNtYBpEgPqKRZZ+oxhZhVKCV2M/jq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rad.com; dmarc=pass action=none header.from=rad.com; dkim=pass
 header.d=rad.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rad.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhYifwde7Y5yS+dCz0RzF/pb/UOj2QDJRg3bLyM6mes=;
 b=gb+OtQ3BCTin1KiQM3eiKq2OQOPYiIDl4SRGgsGHqRg4PD59M9Gw77L+l8gWwns0B8eFR1NLiIBh3+yLPtWACKYr+ImhqnZOtSlardWEs0faUJ5mIxncOeGCbXiX/s7cgiWLYBSPc8cEvP/nQv3vOUHkRWRR96J036TkY3a7YUc=
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com (2603:10a6:803:61::24)
 by DU5PR03MB10523.eurprd03.prod.outlook.com (2603:10a6:10:525::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 05:26:35 +0000
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f]) by VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 05:26:34 +0000
From: Lev Olshvang <lev_o@rad.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: On upgrade from uboot v2017 Comphy-0: UNCONNECTED   
Thread-Topic: On upgrade from uboot v2017 Comphy-0: UNCONNECTED   
Thread-Index: AdqLy51NquOOMCBYRXepJesXSP/Hzg==
Date: Thu, 11 Apr 2024 05:26:34 +0000
Message-ID: <VI1PR03MB452506B4048CA1731681C67C8D052@VI1PR03MB4525.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ActionId=828b6694-fa63-40e4-986b-c107cd639819;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ContentBits=0;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Enabled=true;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Method=Standard;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Name=defa4170-0d19-0005-0004-bc88714345d2;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SetDate=2024-04-11T04:18:17Z;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SiteId=f9047108-cc2c-4e48-97a3-43fad1b3bf9d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rad.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB4525:EE_|DU5PR03MB10523:EE_
x-ms-office365-filtering-correlation-id: 11d8c305-186d-4d60-158f-08dc59e7f422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfWTWtwOPUuE11yol8FFnbFyNZvl9hcsz5kGZwcFaU+blh7p0XMzGQt2uoeRUHsL4+aPTC8ixKuI/gPYjmdCKUbF/usuGo9RGwIIweBKnFbPPkV7BK+NwPFOM/PnxetnuS63h8h6RcvVghFFsY/hWc2QOQpFAfvPMg2PP/MR+QEbpe75HT7bZ9YI9hiBjYRyXpP+MF1Fv5rjrBdizT/sldiLplT8/RUrdkmOE4WbMtYkABCm+7VwNFA15rDk5OrBFDUrPFFkxMrBmg8Xod8eceeg2lq6O/3G0+djEvUVIZjJ2ini6n46OdB3WmnVbkaVdBNm8G0SU7NgU+KI69PSO0oHTfmmsouO38LN89txxFGp8mRGQhi9HHx8R7IKMFn5//101wB4Juwp5zGt0kt/TAXtGRiglBAnjX9KLN1NZqd6a3+UWw3Jfe2mlDAWUFdNSl1Kox0ELrvky6VJdunq76IAxkMRAirrxDb5HIJYd1dhRa9WBKU9hUK3+4kpOs6tM2VbVuO8LtgMxkDJjQ5+Grv8Ajmg8LWtcTq3I349v4/ImgeiSL5jOm+Ea0ItxoxN71sB8wfYGVmuc+fGqgI72pQ/lMcdupkSL7mhfViOYBxmSrBcIlE3aT2dtwwBlmeANzGR6Y+ZqPNqqQbgKnXe0jb94Bb4jeB74hP9c8wIMlh1FXrQyk22gO9wT6moDqgfS4ny4W90WFUYV2ClNE1aQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4525.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi9jTEtiL3I4alNyN1R1YTVPMkFxNTcvWTJMcWV1bDZFRk1reWFxYlRuUHB0?=
 =?utf-8?B?SnIxS2xiWUcrUWdDZkJpNVZDSTJvc2x4UlBkM2JaM1lib2dIMTFLUkRUcnpt?=
 =?utf-8?B?b0dBMjg3SjZZU283emFYZk1xSjgzb2hPRTBDS2QrS2lUT2dTYks1M2libWV0?=
 =?utf-8?B?SzRSejFFK1BnVFdaVEZLY1FqVTEyK094UXBEQWZDZlJtUERmN1VOYjIyaFhQ?=
 =?utf-8?B?Q2UzcHhPUjUxdUFLMlhYaGhJZE5YYndRdGQxbTBHZGlkTWM0YkFrYUYyenpt?=
 =?utf-8?B?Q0EyekpEZTlrQW5pVUxYVjdPNEgxNHRWSVUvUmpQc0xNM3ZXNnNlVnI4eWNQ?=
 =?utf-8?B?bDc2WEVkSEVlRmZWU1gvb1pMU2h6ZVIyUUE1UytGTEo5U2RZK1lyMzBZTWpV?=
 =?utf-8?B?UWtxQ3MxV1JNWWNYak9LUDc2UjVqV1NmR3hTZ0crQ0JKempYamY3KzhLdWdP?=
 =?utf-8?B?Z0dBcWFsbjRMVmtITTJWU2J2SXZuczJvb3Nvbmt1RkF3VzFYbVIrWk9jMUNF?=
 =?utf-8?B?TmZNa3l4NDNvVlFCdnV5b00ybTJBVmZqREs0UFVyKzBCWk55dm8yVHpzMlR3?=
 =?utf-8?B?WXZBbnFrMTZscmE2SUk0QXp6MC9BZHBMRE1uNHdZVVE2U2VIWEV4M3g3NjRu?=
 =?utf-8?B?UXJJRlRwUzlpbW1pWVIra3N0R2hRVlQvS2dBU0RaQkl0eVlUV0RmdWNIM1Ay?=
 =?utf-8?B?NzZmdGhhVi9hL3p3U1QwdmJDS1kyaTI3dXRUMlFpRUJ2RnpLM0F6L00vdFJz?=
 =?utf-8?B?ejJRMlVkZkVKNm5yZ0tTTzhOR3ZWUjZzWnFkcGhJUEF4Mmx3OFVKTzFzRk96?=
 =?utf-8?B?ZUQzeWRFU3JFOE0raUY0cGgxYkNMc3NMQk45Sk0zb0x5NkFwRzFkM1ViTk5m?=
 =?utf-8?B?NVpPUU12TDVEY2gwVDgrNmxjWTdRdkd4V2VPcWh3TlZ2WlVDTlVDclNuQ3V6?=
 =?utf-8?B?VGEvRzgzV3JWZXBhRkZjTUJIYnpDZkVESzduM3BWVkVESVlidCsydmpsU1Rj?=
 =?utf-8?B?UUZKRWRXc1FjUzdQeUxRaGFsc3dGeTNFRkVqQmQrdTFjWTNreDFXN0Z3RGRT?=
 =?utf-8?B?UlNDcWNCTTZRdlptRm1PNklqdlYxUzIrSnowc3loOEtnTDluTWkyUWNIM0da?=
 =?utf-8?B?bmRXU2RZdGk0a3I0ZE1RK1pzeVVLRmpUTjdJSnRya3FIcHZRN1BidTVxVFdO?=
 =?utf-8?B?bGhYdCtTajk2bTdoL1N6dTYrYnRBekFOYm9ET1cwN09GZUh3OGVIbmt1QU5x?=
 =?utf-8?B?dnhWYk5CN1AvYkduOUlzSXFDYWVkSDNsZithRkJnQ1lIb2dzc1VyYUFmUy9V?=
 =?utf-8?B?V1htY0NjRDJmRTFPeVRqWHVrSjBuUjlpVDJoQXlmb1lMZVRvRVNMUjhMZ2RT?=
 =?utf-8?B?QU1ibEkzTUtMeEJhYXpvSFk4bXVVWjh6Z3JDSXIreklZTXROOWlCdUpsTkR4?=
 =?utf-8?B?bzlLRSt5VUdkTVhQUUg0cWZEOE9RWndQNkx4b3JZOGtkWGZPR05hZFBCN0Ji?=
 =?utf-8?B?S1Vjc2xXWExUalFiOXl5VTk0aENUbE1ITE5vaitvdkZKL2JuWjFKWi82R0JH?=
 =?utf-8?B?TWZtZFkrc0s2dEtaWnhBVzZ3b1JYZmkwYUl0S1J3d05VbmF0VWhrTEViaFp5?=
 =?utf-8?B?VzFYeVMvcGVRdjRMbEt4dHlCOGZjT0ppQ3FzTGJRaFRVUkh2N1BwOElzMkVq?=
 =?utf-8?B?M1RKVWxpVVo1TnU3ZHgwdUVTQkZUb2Rjc3dEeHpncTdjYjI2R2xYVTVUdm1L?=
 =?utf-8?B?RmdBOGNOU2trem9lQTJGMitIbGJ3V00wL1JEOFZKL0NoQmxOYkkvVXppRzJj?=
 =?utf-8?B?d0FXNE9sbnRKWmd6N3BERTlYV0VGNFZVTUN4MWxIZmIzYmcyV2NjdjUwait2?=
 =?utf-8?B?Y0tHNHFNWFg2RGpoVVMyYVgxNHZXRk9kc2g3NFgza2trbHBzdDlJS0lpWHF2?=
 =?utf-8?B?U2tkbEhRQkhBamY3eUlWOVozRjRFSy9Ucy95cjJiK3Z5RW03cXB4YUl6TFhn?=
 =?utf-8?B?UkFVdWd5eUJEeXovUTJ1aEVNQ1MxbHVadXVJbFVjQjVjMmlEaTdLL3JONkdJ?=
 =?utf-8?B?bVJHZTU4akp4bzM4TGR4akljZnRpUmM0L1J0cmc2Y2VXRTJOUkdEZGQ1b0R2?=
 =?utf-8?Q?+AgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rad.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4525.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d8c305-186d-4d60-158f-08dc59e7f422
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:26:34.7524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9047108-cc2c-4e48-97a3-43fad1b3bf9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkBLAzKMUv2p1nJ2KrcjHbfz2jsgcfW1na7d/HIRXvAb8fVrONr41uYyiJoBvQ/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10523
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

SGVsbG8gbGlzdCwNCg0KTXkgYm9hcmQgaXMgTWFydmVsbCBBcm1hZGEgMzcyMCBFc3ByZXNzb2Jp
biB2YXJpYW50DQpJIGFtIHRyeWluZyB0byB1cGdyYWRlIGZyb20gdWJvb3QgdjIwMTcgdG8gbGF0
ZXN0IG9uZQ0KSSB3YXMgYWJsZSB0byBnZXQgdG8gdWJvb3Qgc2hlbGwgcHJvbXB0IGFmdGVyIGRp
c2FibGluZyBhbG1vc3QgYWxsIGFuZCBsZWF2aW5nDQpvbmx5IG5ldHdvcmsuDQpGb3IgYSBuZXR3
b3JrIGJvYXJkIGhhcyBNYXJ2ZWxsIHN3aXRjaC4NCkkgYWRkZWQgc29tZSBkZWJ1ZyBwcmludHMg
dG8gZHJpdmVycy9waHkvbWFydmVsbC9jb21waHlfYTM3MDAuYw0KDQoNClRoZSBib290IGNvbnNv
bGUgaXMNCg0KVS1Cb290IDIwMjMuMDcuMDIgLyAyR0ItMDAwMTItZzA1MzM0MmIzYjItZGlydHkg
KEFwciAxMSAyMDI0IC0gMDc6NTU6NTMgKzAzMDApDQoNCk1vZGVsOiBNYXJ2ZWxsIEFybWFkYSAz
NzIwIENvbW11bml0eSBCb2FyZCBFU1BSRVNTT0Jpbg0KRFJBTTogIDIgR2lCDQpDb3JlOiAgMzYg
ZGV2aWNlcywgMTggdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQpjb21waHlfYTM3MDBf
ZmluZF9sYW5lIHBvcnQgMA0KY29tcGh5X2EzNzAwX2ZpbmRfbGFuZSBwb3J0IDANCmNvbXBoeV9h
MzcwMF9maWxsX2NmZyBwaHlfbW9kZSByZ21paQ0KY29tcGh5X2EzNzAwX2ZpbmRfbGFuZSBwb3J0
IDENCmNvbXBoeV9hMzcwMF9maW5kX2xhbmUgcG9ydCAxDQpjb21waHlfYTM3MDBfZmluZF9sYW5l
IHBvcnQgMQ0KY29tcGh5X2EzNzAwX2ZpbGxfY2ZnIHBoeV9tb2RlIHNnbWlpDQpJbml0aWFsaXpl
IHNlcmRlcyBudW1iZXIgMA0KU2VyZGVzIHR5cGUgPSAweDAgaW52ZXJ0PTANCkluaXRpYWxpemUg
c2VyZGVzIG51bWJlciAxDQpTZXJkZXMgdHlwZSA9IDB4MCBpbnZlcnQ9MA0KSW5pdGlhbGl6ZSBz
ZXJkZXMgbnVtYmVyIDINClNlcmRlcyB0eXBlID0gMHgwIGludmVydD0wDQpDb21waHkgY2hpcCAj
MDoNCkNvbXBoeS0wOiBVTkNPTk5FQ1RFRCAgIDEuMjUgR2Jwcw0KQ29tcGh5LTE6IFVOQ09OTkVD
VEVEICAgMS4yNSBHYnBzDQpDb21waHktMjogVU5DT05ORUNURUQNCk1NQzoNCkxvYWRpbmcgRW52
aXJvbm1lbnQgZnJvbSBub3doZXJlLi4uIE9LDQpOZXQ6DQpXYXJuaW5nOiBldGhlcm5ldEAzMDAw
MCAoZXRoMCkgdXNpbmcgcmFuZG9tIE1BQyBhZGRyZXNzIC0gYTI6ZTY6MDM6MDQ6ZmI6NzENCmV0
aDA6IGV0aGVybmV0QDMwMDAwDQpXYXJuaW5nOiBldGhlcm5ldEA0MDAwMCAoZXRoMSkgdXNpbmcg
cmFuZG9tIE1BQyBhZGRyZXNzIC0gNzI6M2I6Nzc6ODY6Njk6ODMNCiwgZXRoMTogZXRoZXJuZXRA
NDAwMDANCg0KDQpJIHdvbmRlciAgd2hhdCBTZXJkZXMgdHlwZSAwIG1lYW5zPw0KDQpIZWxwIHdp
bGwgYmUgZ3JlYXRseSBhcHByZWNpYXRlZCwNCkxldg0KDQoNCg0KDQo=
