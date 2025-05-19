Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD0C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF8681FEE;
	Mon, 19 May 2025 16:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="jH4Kr8CF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D0882B5B; Mon, 19 May 2025 16:58:45 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D74381E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 16:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFj/xX1X39iW+FMvqNTWGt2H6f/Hy9kUMZog0ltUHv6V+uphq+85heMY1pfpV6Cf4Vz8HNnekhuco/ZSUTkaR4tzlO8fw7/pTtOZtFdtYbaLhbW52h1Y7LPCWyjjYlBe0L5XCQ1zGArKj/dXzlMgyRwvCKbZ9MmZ4Y72d+jATx0NWkV1zGOQTR0VLVeX5nPP2iQpOpPaSeQt/dbGdXFbgEvkukA5c+roo41wB3KJlc0paWIx4zmP8qnpRpayDOUAXEchKgVe1hhOrJELk6akQn39qlDSQCBuV8DTgT6afZowS/l+0foGPoa2OXZzIxkxcg6N7aLaOau7EYwLNOwi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEAyj12a0CeYCVbkUZ1l6roHbyV0fDk5eCx05yr6vPQ=;
 b=h+eVO5ro9VcY7Yl8HJnqOS2UUK8idFHM/9KY2KwqRmuR7yr6dsfLHfqbDYfWnAMmvfKnq+fP2KU9h78nt5PpPsSqmNY8lZ3DPkoOTVBEVjf3dGipW3nBOEdkEn9ZKLv+re/iX6c60DNOeRNctM1MGnHkY7tm2cUFugPziAeitLn3M8r/32qFmj+gYc2GtnZ+V2iZX2Rb21nW97nrWE2Cj1FERa9HpCPz2K1xoJOzXJX+LFlf/qhX/WdOnumWg6r/DPWDxXgDtX+ha71s8EWpIyIzfiNIyRi3/8TnBDoXtvAxgSu1xxJj3qEm1b+TDumW2a2JKWHT1knHSb+baoPDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEAyj12a0CeYCVbkUZ1l6roHbyV0fDk5eCx05yr6vPQ=;
 b=jH4Kr8CFHIx60wf5TUvPSzU1yad8idH33oCBweOgcJOJtlO4DzRZeMzTsbdAHIrdZrCfc+mrybTe5wmAFsB9qJeuYZkcMGRcf/VW1z0vUZAdS+P3n4XjBwqH2uwP+xQakS7u1v4AMQ7YytbBoWkKuQ9r/TN1uUZwQlGTbncTCMM=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by BY1PR07MB11194.namprd07.prod.outlook.com (2603:10b6:a03:5b2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 14:58:38 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::5ee9:2fcc:af97:aed7%5]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 14:58:38 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Thread-Topic: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Thread-Index: AQHbu5Fxz0lwA0vEHUqimb5OZeGX1bPVh/WAgASdeXY=
Date: Mon, 19 May 2025 14:58:38 +0000
Message-ID: <SJ2PR07MB97112B1C40CEB525086F92FF819CA@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <20250516162825.GA2939351@bill-the-cat>
In-Reply-To: <20250516162825.GA2939351@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|BY1PR07MB11194:EE_
x-ms-office365-filtering-correlation-id: a9aa7cb4-2915-4d82-23f7-08dd96e5a2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?YnBRN1VOc0g3bllUR0x4OURFR0M0R1dDZjBvS09wLzJZdmkycDJHbFJDNGg3?=
 =?utf-8?B?cUI0aG91SlRrWXc3Z2VCRldVKzZ2dDhRRStweUhkV2R3RFdmSWJta3ZTUnVJ?=
 =?utf-8?B?eG5aNG1vT2tIc0RBV05neHdQdTgrcmtkaENpVHYxUlRqdDRiMGFMNVozUXpV?=
 =?utf-8?B?TTE1Yys5cVVFQW50UEc3YmhPY3Q0eDVmcEg1bEFPbmJLVXlTZ3NqbDBkMTFJ?=
 =?utf-8?B?cW90QStQRHJRY0txby9QYlIwWWpsQnlhOFdIdjZQdlB3SUFMU2l3Ry8yTUdQ?=
 =?utf-8?B?THBxRlFFZW5XVWNBZFo3NlY1TDBWOVRLZG13Slp2Vm1NdjAvaXNLeHpHS1FH?=
 =?utf-8?B?QTQ1c3ZBU2tFeElGSG4vWXI5OXR5Qi8wQlVvYklBNURJS1BjczhvNEFwZmJP?=
 =?utf-8?B?aFM1eENyNFVDdEtkWnN5djRtZVBORnM0Q29PRUQzNHJnMjNxR2I5NUVXMmk3?=
 =?utf-8?B?QWF5SU8vMDdvdW9Fd0NNb2xzYkVuWkdZSzVYNU9Vc20raUVsRzFyZVV2SWhT?=
 =?utf-8?B?T1lVR25wd09pZmJ0VFpKK1EyR3NsTDNGNEY5R2t0aU9nU05WUDVWb0JFNTh2?=
 =?utf-8?B?WGJTWEo1WUFwTHRTV2J4N0RoSUJobUFKNHhjNmwxWkFzbVRUY1BtVktxb2dz?=
 =?utf-8?B?cWhRcUtMSFJCRFN3emJaaGNuWXVZMEh2S0U1QXlLeDJaM2xHWXJsTktrSEM1?=
 =?utf-8?B?QXdQVFd6Sng1Q0daOHVpQXljcHFQWEo2ZWxDQUQyTE95OUFNb3k1Y3JUMXJz?=
 =?utf-8?B?MUtqbmhmZXdrRi9DSXBKa0c1bjk5Rjc3aVVNWHhqWVh3VlRKWU5CNlEwTFJo?=
 =?utf-8?B?VjZlMFdaZjZXeE13RW1RQzNmc2xUb2tqSGhFdFNyZUxqNXhOSGFpZGlKWmFt?=
 =?utf-8?B?QjZzd2taUG9Hb3ppTEh4UldrTWpRLzZENDcxTk9VUm83Z0prM21EYUtUaXVT?=
 =?utf-8?B?MEMyUmxuc1JwdnQ5bXZTYWlGblMxQUpzNWFscW5qcnVYVDgvWW51OTNQUXRQ?=
 =?utf-8?B?REg3em92MTV0b2loTjhhSWdLZURObE5RalVYT3lxeWVzcXFlMHA2aTNVbTl3?=
 =?utf-8?B?M2RvTTlnTGFHRWF6dy92ekFSaDVTMktSZ3Bvc1RJN2ZSekJ1cWhHcENQM1dN?=
 =?utf-8?B?VnpIRFJHVEkyaFVvZ291RUQ1d0RxajRtSUJFQ09zUHhNZVd2Ri9zZ0c2em1w?=
 =?utf-8?B?Q0VHNVBlMmY4bzlsc1pKdmV3cTBvLzM1MnVrS3dNTDdyek9kT3ZXdEd1WDBx?=
 =?utf-8?B?bGZ5d3UrTjJRTHdhVXl3dUt2ajdyR3ZJcDFRSE1uUk1hZEF0M2gxWDk3QVJC?=
 =?utf-8?B?UjZsL3FUYVFrSTdvWWNoMmh0bHpJOU9kMlZGbCtxVVpxNXFwa0pnQno1WlQ4?=
 =?utf-8?B?aU9oVnZTTHlqOStjbGVOd0JLajdaaFB0d3lRa1RINVlGNE9MN2U5ZkE2cHRv?=
 =?utf-8?B?MFZJZUVXWVVpSjl2RWJySUxrVE1BMnNlYzBDOUFqeDl0SjNTRmJUSFU1dHpr?=
 =?utf-8?B?RU0xWXZ6ekN2YjlVa01BT1hXN1dJemdpYm43NlRZdEhZSzBxMU5EQ0IwU3Z6?=
 =?utf-8?B?VXcwOHdOaS9kWVdRMHVjZFFCVTRoTCs2REtNM0VoUDlLUFFVdzhtZVR2Q1lV?=
 =?utf-8?B?TWdyU3RMYXdYdUl2TTBxeW1LOGVNQklhZXVyNnh3YitpQUJxbTVEaVIwNkxx?=
 =?utf-8?B?VkZiR1NKd1VUUFNjR0s3WXlQL1JiTHBpY0Nwb3dJN1kxZCtyQzA2MTlvSGNP?=
 =?utf-8?B?WVlocVMybktJTFZPN2t3cGpUcVNNZExsbVRUQ2FvRnkvL3EzdUpJTW9TOU9N?=
 =?utf-8?B?cHBydDErbndLNEJ3K0pSZ1J3cHBqMjJRNlNTR25pa1pKeVdmZktndWpXZ3Rt?=
 =?utf-8?B?Ym9sd2J4dnhhUkxnZ2RMcks4aDEwRTU3bVFrM3h3M0QyaDdqK1dwaVFnb1VX?=
 =?utf-8?Q?/enWaWS7gAs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmJvUVVPd1RzU3oyN1JiYXR0NUNQcXI2ZTFXcXhnZXdTeHo1MWMzOXIxTnpO?=
 =?utf-8?B?bndiOGFCUUVFczNWb0FLb3l2SjVMZXNFaEhoVlRaNGNFM1JqMHR1SnVMOFRa?=
 =?utf-8?B?OFNncTNuWTY3T3dCc0RZQllpU2Y1TjJXWDdYdFhnNFRqdTlYOVVzbXFub3Er?=
 =?utf-8?B?NVBNb0Z6NEpMMUVnVGNvVEFieEFtRXZqMnFHZm5KSU0vN3pYUTdQWlRISW0r?=
 =?utf-8?B?YUNIMzVnaG9iSlVBMlB4TitiZDhWekc4WUZZVHNmRElTc0xGTC96K0JVMkhM?=
 =?utf-8?B?VGd3MTJ2UERaRDFKSEwzRjZudTgydzhabGFiZUZGbGg3bFMxUjZZQmlpL2Nr?=
 =?utf-8?B?RFpTOGhYcEJaZFcvL29qSmUwT2o3TzhKZkZqK1JpNkxOM2xFdzdtaEg1My90?=
 =?utf-8?B?dk1XNkRKeGk4bEo5OGl0dW1yOUN1bmxveW4wOVAyUnNyM0lZa1FSUmVIZHRN?=
 =?utf-8?B?ZkU4aHp3aTg3Q2ZoWFZ0Rk1pNjlBVjBjRnZWeCtSRFRKcXF2ajFuemluekVq?=
 =?utf-8?B?cDJDam9YUWxVR0UveUdxTFZydU9TMFB1MnduTTF0d1duY281ZlNEVXRPQk85?=
 =?utf-8?B?Ti9UWW04dExpRk5nTnlscWVkRVJRaHNoc0doRXZBa3Z2ZWxvL0g5dVFFWjNC?=
 =?utf-8?B?V2lTOFpJWFQzbW9CNnVQOTR3R1BrWWtnVmhZaW5tQUk4NzlwNzBuTVorSUc4?=
 =?utf-8?B?WFVKZ2N1UWpXZmNUZXU1SjRTMysvRndjODlGUzlNS3BGaEpUS2pNeWRoOGd6?=
 =?utf-8?B?RiswSVBSbTV0VFhXUDB1TGJYbmF4WEhoeUpqTWtROFBVeE9ZZGdKb2ErTWpt?=
 =?utf-8?B?cVM3TjB0V3k1S2g3TzFGc1ovVy9TT1lNVk5aenhaRXlJVGQxT0NKL2dJM0xw?=
 =?utf-8?B?QVVPQjlQVWkwZ1RMN2s1elhaREFxVFczSk1rYXNBUjdGbU03TWs3bTVqZGZB?=
 =?utf-8?B?V2l2SWx0ZUJQWDZiZ3dsMHd1eFJXem5BOTJkczljZzAzcGJoS1ZDWUdVZTA0?=
 =?utf-8?B?TG1uQ0d2NEw5TTdEMWRndndUN2lJT1dSSFJsU1NHZFlYN2hMZmpXS0h0VFY2?=
 =?utf-8?B?RTlNWjVhRnU4c2xrckRuNlJhVkRrKzlVdXVjYVZJVUNRUnpud0dVNXl3c0lU?=
 =?utf-8?B?TUVVYmh0Wjg3YlZiR0RFRHltS2dybDFTMFkxMkUwaXYrNmFCUHJYaWs5Ukwz?=
 =?utf-8?B?d0R5ZFk2Rng0cWJMU1hmNVpwS0FuUDRBTkVSbE8vRmhOMGNEWVhET1dlMys1?=
 =?utf-8?B?TnBKY05NbS9TUHFZeEIvbStpS2tjb0JqWURMRzFqR2xrS3gySXZ5a0dzUlFF?=
 =?utf-8?B?TVowZGN1VEZISFU5eDd5SzYrdG5GWnFuTWltLzVWVE5ZYksrWXE1TFgzZnc1?=
 =?utf-8?B?OWJPU2lOVFhjaStHdmVKYTh2VmQrWG00ZjZ5cXYybVpSNVRVREtzNlN0OE9j?=
 =?utf-8?B?VGVqbXhxL0VoZjZjNmNldWdFM1hzU1Z5VXF2bVN2S25UQmJPdmY0MUxTTldZ?=
 =?utf-8?B?VWp1Sk1vRmVOTTMyTUg3Nnl2VFVvTFhWVndocDdqRy9GK05Qc2NocUpFa084?=
 =?utf-8?B?dHJpc1RobzR1d2xMMldMMWpwOWR0Q29nWjRIcHRNT1lESHljdHJrcUV3dmF2?=
 =?utf-8?B?UHFQR1pmZ2FYREkzSXR5Z0tKNWVvaGg3cjZnSmY3OXZhVUVteUd0NHlSR3JG?=
 =?utf-8?B?a2FEbkF1R0hHT05XOXEyenRlU0EydHJrbVpoYkxzZG5hWDJ4dlhrVFlNTzk4?=
 =?utf-8?B?amFzTndRTHFxZlBwd0pTK2pzNWlzWFc2ZkFHNU5ydDJuSEt2OEU5SzN2N0tC?=
 =?utf-8?B?Wm1lV05qMzJxZEJUR1YyeWRpT1BNazJCNGVkblVKU25PNmVIQzV6UXFZcllh?=
 =?utf-8?B?V3JTOGFoRnBGSmFFZ3A0SHZhUUJxS2daQUFBSEhRRUJvbklEdEF6Y0FWeDZQ?=
 =?utf-8?B?U1BPdUtNeXRXOXRBR3RhTm9tM2J2N1lyQUowR2lwYm1sUm5CZkt5Z3lxT3FX?=
 =?utf-8?B?OTdkSFcrc0tsdXg0UTRnbFRWNTZVTFdNbGlKSzVBNitZR1Y4eU1KOWpqN0VX?=
 =?utf-8?B?aDBoK3F2dFdKRDZQaTltSUV3ODZaQWtGbkVPVS9PRm1kOHpqWG80Z3JmL2wx?=
 =?utf-8?B?OW1ZSHdSYW9YQzVLVXJDS0p4bWEzclRnTDFWWElEbytwR3dSTE1yLzZoVmY0?=
 =?utf-8?Q?9tsKkZ04rcNbtbJHJ931bjs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aa7cb4-2915-4d82-23f7-08dd96e5a2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 14:58:38.2140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoTwNaOnzCBAibCeL/e8tP84TtddE/M0qWiCCByXe5ttRpI9WMNihfjc4Zo5fpJGDaNw9U4GOSY/k7ON7YqHhBhBJOZSesG6F9fxiw0iZU+D0MTf2m9Z8gZSf7lvjKxlFpnECYEhrs+TXmBGDFj4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR07MB11194
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

SGVsbG8gVG9tLCBJIGhhdmUgbWFkZSB0aGUgY2hhbmdlcyBhcyBkaXNjdXNzZWQgYW5kIHJlYmFz
ZWQgb24gbWFzdGVyLiBZb3UgY2FuIGZpbmQgdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIG15IGNvbW1p
dCBoZXJlOg0KDQpodHRwczovL2dpdGh1Yi5jb20vZW16MjI5L3UtYm9vdC9jb21taXQvNzM5ZmU5
NGUxZjgwOTZhOTAyNDFmNWE5MzQ4ZjNkY2NlNGViOTdjMQ0KDQpXaXRoIHlvdXIgYXBwcm92YWwg
SSBjYW4gaXNzdWUgYSBQUi4NCg0KDQpFcmljIFNjaGlrc2NobmVpdA0KDQpTZW5pb3IgRW1iZWRk
ZWQgTGludXggRW5naW5lZXIgSUlJICDigIsNCg0KDQoNCk5vdmFUZWNoLCBMTEMNCg0KMTM1NTUg
Vy4gMTA3dGggU3RyZWV0IHwgTGVuZXhhLCBLUyA2NjIxNeKAiw0KDQpPOiA5MTMuNDUxLjE4ODDi
gIsNCg0KICDigIsNCg0Kbm92YXRlY2hhdXRvbWF0aW9uLmNvbTxodHRwOi8vd3d3Lm5vdmF0ZWNo
YXV0b21hdGlvbi5jb20vPiB8IE5vdmFUZWNoTGlua2VkSW48aHR0cHM6Ly93d3cubGlua2VkaW4u
Y29tL2NvbXBhbnkvNTY1MDE3Pg0KDQpSZWNlaXB0IG9mIHRoaXMgZW1haWwgaW1wbGllcyBjb21w
bGlhbmNlIHdpdGggb3VyIHRlcm1zIGFuZCBjb25kaXRpb25zPGh0dHBzOi8vd3d3Lm5vdmF0ZWNo
YXV0b21hdGlvbi5jb20vZW1haWwtdGVybXMtY29uZGl0aW9ucz4u77u/DQoNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFRvbSBSaW5pDQpTZW50OiBGcmlkYXksIE1h
eSAxNiwgMjAyNSAxMToyOCBBTQ0KVG86IEVyaWMgU2NoaWtzY2huZWl0DQpDYzogdS1ib290QGxp
c3RzLmRlbnguZGUNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIFtSRkNdOiBkdGM6IEFkZCBLY29uZmln
IG9wdGlvbiB0byBwYWQgZGV2aWNlIHRyZWUgYmxvYg0KDQpPbiBGcmksIE1heSAwMiwgMjAyNSBh
dCAwMTozODoyNlBNIC0wNTAwLCBFcmljIFNjaGlrc2NobmVpdCB3cm90ZToNCg0KPiBUaGlzIHdp
bGwgYWxsb3cgYXJjaChzKSB0aGF0IHVzZSBkZXZpY2UgdHJlZSBibG9icyB0byBwYWQgdGhlIGVu
ZCBvZiB0aGUNCj4gZGV2aWNlIHRyZWUgc28gdGhleSBjYW4gYmUgbW9kaWZpZWQgYnkgYm9hcmQg
ZmlsZXMgYXQgcnVuIHRpbWUuIFRoaXMgd2lsbA0KPiBoZWxwIHByZXZlbnQgZXJyb3JzIHN1Y2gg
YXMgRkRUX0VSUl9OT1NQQUNFIGZyb20gb2NjdXJpbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEVy
aWMgU2NoaWtzY2huZWl0IDxlcmljLnNjaGlrc2NobmVpdEBub3ZhdGVjaGF1dG9tYXRpb24uY29t
Pg0KPiAtLS0NCj4gIGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAxMSArKysrKysrKysr
Kw0KPiAgYXJjaC9hcmMvZHRzL01ha2VmaWxlICAgICAgICB8ICA2ICsrKysrLQ0KPiAgYXJjaC9h
cm0vZHRzL01ha2VmaWxlICAgICAgICB8ICA0ICsrKysNCj4gIGFyY2gvbTY4ay9kdHMvTWFrZWZp
bGUgICAgICAgfCAgNiArKysrKy0NCj4gIGFyY2gvbWljcm9ibGF6ZS9kdHMvTWFrZWZpbGUgfCAg
NiArKysrKy0NCj4gIGFyY2gvbmlvczIvZHRzL01ha2VmaWxlICAgICAgfCAgNiArKysrKy0NCj4g
IGFyY2gvcG93ZXJwYy9kdHMvTWFrZWZpbGUgICAgfCAgNCArKysrDQo+ICBhcmNoL3Jpc2N2L2R0
cy9NYWtlZmlsZSAgICAgIHwgIDYgKysrKystDQo+ICBhcmNoL3NhbmRib3gvZHRzL01ha2VmaWxl
ICAgIHwgIDYgKysrKystDQo+ICBhcmNoL3g4Ni9kdHMvTWFrZWZpbGUgICAgICAgIHwgIDggKysr
KysrKy0NCj4gIDEwIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQoNCkkgbGlrZSB0aGUgY29uY2VwdCBhbmQgdGhlIGNsZWFudXAuIEhvd2V2ZXIsIEkgdGhp
bmsgd2Ugc2hvdWxkOg0KLSBQdXQgdGhlIGxpbmUNCkRUQ19GTEFHUyArPSAtcCAkKENPTkZJR19T
WVNfRFRDX1BBRF9CWVRFUykNCmluIHNjcmlwdHMvTWFrZWZpbGUuZHRzIHdpdGggdGhlIHJlc3Qg
b2YgdGhlIERUQ19MT0dJQyBhczoNCmlmbmVxICQoQ09ORklHX1NZU19EVENfUEFEX0JZVEVTLDAp
DQpEVENfRkxBR1MgKz0gLXAgJChDT05GSUdfU1lTX0RUQ19QQURfQllURVMpDQplbmRpZg0KDQpU
aGVuIHdlIGNhbjoNCj4gZGlmZiAtLWdpdCBhL2FyY2gvS2NvbmZpZyBiL2FyY2gvS2NvbmZpZw0K
PiBpbmRleCBlYTMzZDA3YzA4Ni4uYTg1Zjc1MWQxZTYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvS2Nv
bmZpZw0KPiArKysgYi9hcmNoL0tjb25maWcNCj4gQEAgLTYzLDYgKzYzLDE3IEBAIGNvbmZpZyBT
WVNfQ0FDSEVMSU5FX1NJWkUNCj4gICAgICAgIGRlZmF1bHQgNjQgaWYgUklTQ1YNCj4gICAgICAg
IGRlZmF1bHQgMzIgaWYgTUlQUw0KPg0KPiArY29uZmlnIFNZU19EVENfUEFEDQo+ICsgICAgIGJv
b2wgIkVuYWJsZSBEVEMgcGFkZGluZyINCj4gKyAgICAgaGVscA0KPiArICAgICAgIFRoaXMgd2ls
bCBhbGxvdyB0aGUgZmluYWwgZGV2aWNlIHRyZWUgb2YgeW91ciBzcGVjaWZpZWQgYXJjaCB0bw0K
PiArICAgICAgIGhhdmUgcGFkIHNwYWNlIGF0IHRoZSBlbmQuIFRoaXMgZW5hYmxlcyB0aGUgYWJp
bGl0eSBmb3IgdGhlIGRldmljZQ0KPiArICAgICAgIHRyZWUgdG8gYmUgbW9kaWZpZWQgaW4gcGxh
Y2UgYnkgYm9hcmQgZmlsZXMuDQoNCkRyb3AgdGhpcy4NCg0KPiArY29uZmlnIFNZU19EVENfUEFE
X0JZVEVTDQo+ICsgICAgIGludCAiU2l6ZSBpbiBieXRlcyB0byBwYWQgZGV2aWNlIHRyZWUgYmxv
YiINCj4gKyAgICAgZGVmYXVsdCA0MDk2IGlmIFNZU19EVENfUEFEDQoNCkFuZCBjaGFuZ2UgdGhl
IGRlZmF1bHRzIHRvIG1hdGNoIHRoZSBleGlzdGluZyB1c2Vycywgcm91Z2hseToNCiAgICAgICAg
ZGVmYXVsdCAzMjc2OCBpZiBYODYgJiYgRUZJX0FQUA0KICAgICAgICBkZWZhdWx0IDQwOTYgaWYg
QVJDIHx8IE02OEsgfHwgTUlDUk9CTEFaRSB8fCBOSU9TMiB8fCBSQ0FSXzY0IFwNCiAgICAgICAg
ICAgICAgICB8fCBSSVNDViB8fCBTQU5EQk9YIHx8IChYODYgJiYgIUVGSV9BUFApDQogICAgICAg
IGRlZmF1bHQgMA0KDQpBbmQgdGhlbiB3ZSBkcm9wIHRoZSAtcCBsaW5lcyBmcm9tIGFsbCBvZiB0
aGUgb3RoZXIgRFRDX0ZMQUdTLg0KDQpUaGFua3MhDQoNCi0tDQpUb20NCg==
