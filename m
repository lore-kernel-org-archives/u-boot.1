Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A88CD484E
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0CDC80F0E;
	Tue, 12 May 2026 08:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="MMRTPqGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4BD81E18; Tue, 12 May 2026 08:33:54 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6082D801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjLFQRdZQ8K7x8bXdfTA0eZB5uFGMKlBMU5ynx+wpaX5HgK/Q8Z6EKzzOXrCY4++8c8/BLgy69B9p5LhMccwTduvN5d/b4Quq1v5PJFC+Jh/6PCoPYPdvJEmFsOnEegyxdgsgCcyjX9HSggyjfr0zUaTXbWT6mSyNaGzi9QSmSPMe6gOIw+UabE5V2y9QOf/CQRcMLptsY2WOh6CRADM0TgHovsDzQD5AJA73D3u+jU4GvtSpKCmIrhSHAB/RHFntjsmd3jD/6pybHsaK1CS2T34eVVO00eqCI0dfcmX8FVNUIzyCMXTfRjoJAHmKuyYU/Ft7FxTH0TUy65fdK6bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeKEm9jrx5tD4Mp/LXb74xhCx2HV9pYuhqQ82HgAOCs=;
 b=RxuF1sLd1q4wLvKpjBvTDPRPkbvzcGK/UfTacuuN7n/XCELUc4fFCGRRA9SETu3A7aSeTqQEi/cSvJ0ZJsK38HyOPhb/PIGz/xqb8HIUZuKtBJFOneyS0CfdlJAbCVcH20JrFxASiLfTpFbH1mJcRxhzAKANcwDEswJ2Sb5vxkac53cmDLaWxIyHML6DwPXLePggtZRmxsOjVS5I6tzt++JjB/OJM+flDFMGsx/9mQT7YpD6rz3wAEqf6GrdoS+AuZgtnl4kQ5Q6H4A7oJx+WUaWkfW3eeg4Ho4mXe90sKzSST2QsdBQAmbc04dtyLvFQhaRyGNJ+a3qaSx94BGJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeKEm9jrx5tD4Mp/LXb74xhCx2HV9pYuhqQ82HgAOCs=;
 b=MMRTPqGQMUXWGuFtJ8kOmQWHkNPt96D6Ct8sJnPRRxjykp9nW+FGv6M6j3DFJITbyORxmfXGrxlHNXdTNuV+VnuRsY36al2H3xwU7VILHuR2a+RF+c/tOzuP0ByT0ueIoJrj9Ge8qOCwFoycigIvuwAZ0NjyOrOYqBKEuBZz24j3wFNfXKFb5ALPssJy3PWk1LGlo83++RzbPDlQj7qdEkK10qPp0nNaIDDmRRMGEzYoFfudDC94LqdGKwmEzqWflcWOBvmiDJ4UW1jT5vGvZmjA6AxJnzBr8tocRKq/V7O5BQeLz4oWF7pb6tFrnyJBzW2Xdl5A0/Yx7OZAyWQIOw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB7636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 06:33:50 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:33:49 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "anshuld@ti.com" <anshuld@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/4] arm: mach-k3: Allow for calling get_reset_reason()
 twice
Thread-Topic: [PATCH 1/4] arm: mach-k3: Allow for calling get_reset_reason()
 twice
Thread-Index: AQHc4YKcGVKvs763D0+fOVFvWPXcCbYJ5EuAgAALPwA=
Date: Tue, 12 May 2026 06:33:49 +0000
Message-ID: <cec06ef35f788a5d638890f08c0065e81a124c1c.camel@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-2-alexander.sverdlin@siemens.com>
 <177856520963.106112.14407368040436691226.b4-review@b4>
In-Reply-To: <177856520963.106112.14407368040436691226.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB7636:EE_
x-ms-office365-filtering-correlation-id: ca3b5dda-cdcc-4a31-2531-08deaff06d52
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|38070700021|11063799003|56012099003|3023799003|18002099003|22082099003;
x-microsoft-antispam-message-info: IlEmNQX5/sHRfBt2syed08BFxl+nmUDdDY2Zqzz0bCpOPilWcsqp4JRJOgMcAOwGhYJsDMKyePIj+NbkeWe3RAV6guBNH8b539ef5Jnl6TnK2I355ZfwJkgr1c7SV3dfJAfGWDZg5ma/eci/uVyRT2NT6d1EDFdsQDaYirW+WNw8dJzNBBwXKaF+nRcJFcIvLtiMxruoM+KX8e/nJHgkqg5UXkepmregf5sbbx4C957l+L/1NDRorKIm2JvioYFkxTlw5Ays+YTn3N+NYwrK9pWbyaUqYZCZpb+sMPbneHqimlY20Kte4dhacSAq6Jq3Wcj2PrflO5WwwZbhDgY1Vy4e5zuA0KlyvB/5uTAZG2lvtKnRgrz8WyZZQu5qJ4eHgkXzvay2oAw6gU+bPStjCyNUcLDylWjStS4sYi86BJJO7ikohxxiF7LOMkvtTXAiftdYL53iQpmUa57nvZmh473NoiNCRw50o4ZqpGsj0gCo9y9q2FS0lIcN5bCa8Ft1RxUDNp8J9l0JiMtsxTUT1ctltxWcgB2e+RggbPsadaS1plhVNBdaLX424Ok+z3Zvwy0kPPxvjhVKaE+IN32tlGUbRSnFKNmACYQBs36j///+gsR2mLwYAAyGqbMvnz40tDMqubX75jB7qN2vymtx/N89uvFfzlEKDWgVp8US2s5GgjV9aQlisHZGhRvFogIkcwyB9lqvhwwAU6n8fi2GSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(38070700021)(11063799003)(56012099003)(3023799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJUTnpjNjFnREpKY0xPU2gxSkFGUjRXN0pZQ0QwSEVTUzlqdHRxUGt5NjN2?=
 =?utf-8?B?VW5mcDN2Y2Zid1hiMHFEUTBjVkpxazFlWFNCWHNpM3NocnFGb1hSSDZyVGRi?=
 =?utf-8?B?Y2JmZVhLYXdzY2hWbDdaY1g5Q3dqK1hrTmJCTXk2V2M1QXRYSFZHOWVGREV6?=
 =?utf-8?B?bzlLWW1MQ1JlWWFDZUJBOFNlcmFVZlkxNFhzNXhxaFZ0ZGhLZEdmWE15UEQ0?=
 =?utf-8?B?Vm1tZjV0MkhIcHBMWkFUdUhRVGtoSERIY1ZnNzRJeklkRndzQlEvcVc5Lzd5?=
 =?utf-8?B?alVZTUJ6RjRlUGFhSUU1Znh1bU0yL2ZBODNod0swVUQ2elBnL0JvS3laSHU5?=
 =?utf-8?B?NDRMNnlWVExXZ0pUTWxuNndQMzhOUlVLb0lBSGhnNDlWcmlTeGVQL3ZBTmQ1?=
 =?utf-8?B?eGY2TmswNklBRVJ1RDQ2d0FHcDh2cTcveVlOb2ZqdFlVamNuUkw3VU5TUXRN?=
 =?utf-8?B?aGpHa0s2YXRjMGthbXFNMzJjNE9iTzA2bUJ6VWFhTDY2K1ltQk9POVg0bi9J?=
 =?utf-8?B?akZlc2Q5b212KzVDR3NVOXRFZmw0SURaOWxjdElqT3psWHZUYjc1Ukp5K05w?=
 =?utf-8?B?bGNPWlhEbEVpVjZnV1Foek5vZk5FQlE0QXB6T0c4TUVtNEJTZEhSWTF5Y21F?=
 =?utf-8?B?ZmtKWUJUZmc3Z1dsdTNxZWZIUVJjeXo1UkI1Y0trTzBUZ3NFVDVyQTd2cUN6?=
 =?utf-8?B?enRBTHJ6bjFWTk9CRG5wTjQxTEhhZ25lWUFXVm1nam9pTXg1ZVBTVkJYOTNV?=
 =?utf-8?B?NkZpeW11UzlvNSs3OTkvcVFHc3JXWFVRS1NOaWNmckQzY2psM1hUWkJhY0dK?=
 =?utf-8?B?MUE3VmRGcWZrSHZUaUVVcVFaSEdzb2Q5SHRiYXhja1ZHb2Vid3M2UFUwcUNL?=
 =?utf-8?B?WWFOc1krOXFabkRtV2Q2M0F1NzAxZHAweW9JMEU0SG5vR1oyU2p4Y09NZ0g0?=
 =?utf-8?B?bzYyck0wbjFHWmJrK1NxWXR5bFFnMnFRUmF2WGhXNGtNYVo5U0NIdEUvUzlI?=
 =?utf-8?B?MkI2d2FweTFoYm9vRTVmOVJucVBsOUNiWFQvS04zaTZiSGFWSUttbitGVHBs?=
 =?utf-8?B?MDdtRTBxNHQyeFpvQ0MrVm5STlgvcWo1MmpQa1R4ejg3dytENUlibUwyU0pz?=
 =?utf-8?B?Z1BmVFpZNFkvTWtjMXdIVXo5eHc2TCtsRnlRYTZFRWVXU09MNU9kemNLbHY3?=
 =?utf-8?B?eGl5cmJqc2h6c3VwWDFZMU1admIxUklKM1lBRHZYaUZlNEpWeWhPOXlwSElM?=
 =?utf-8?B?UVB3bnN0ck8vYWJ5ajd4aEpxdjEvU3Y5R1JqRk5FR3BRd2RYZXh2MGJWNkZL?=
 =?utf-8?B?SlU3QmZIRXRjWWVqYVBHZVFEdjFpdnpYMlJCV250WDBPcW9pM2lCVGpkZVVT?=
 =?utf-8?B?b082bGhFVlNMYkVJMU1iNXBwU2RuMkhNL1lhQ3hyYmZSM0tzMElzUnhIU2hy?=
 =?utf-8?B?MXJOWFdaNDhPQlBHWGtVeExyTzZLRmxaejU3M0wzT01aSWVJZzlxUkw1V00r?=
 =?utf-8?B?b0lSWEJuRWVDR1FSQ3NGVGU0MFNiRnpVRjViNXB5L2h3T1luc1JibjJ0THZO?=
 =?utf-8?B?ZlFvc1NCbk9FQ2Y3cXhvTHRyWUlRYlAwTkZONC9FTUQ4U1lURkZudkxVeHd4?=
 =?utf-8?B?cjhwWWJ2M0ZuaWhpVjkxaUdiY0c3V1lWS1g4KzFZc2J3YjFTTVJjYTYzSzlj?=
 =?utf-8?B?Y2dDVUNJaGdoYXpzdUVxenh1TmMvUHVZWEYzVGRHanlrMzlRVkVwUnVVQklw?=
 =?utf-8?B?OTBNb3RYdndLbHIyUkw4SkpuTFBTN1V1OEl5VjlrWXNWQ1FsQmQ1NzZVYUx2?=
 =?utf-8?B?Z0c3akc4YWRCUTlIV1Y5Wk1xeDRYaHFSUmpUZnBjS3M3djJaQ3dJOGpybm1P?=
 =?utf-8?B?a0NqcGZjZW91ZlVKaDk3L3I4WjBIdzNMVWFJNEs4Y1gvNlhZUHZMM241bzNG?=
 =?utf-8?B?K1lMeDBSTHY1WHJxdklPQ1grTFg2VExJRGJZNVFZSWFEWU9reksxSTZxL1A0?=
 =?utf-8?B?Tm15WWo4Wm01SlNaUGprdXdhT2xiZ3dlRmpONFVub3VHb25HUXpKcUFTSU1N?=
 =?utf-8?B?Z0RRS1l1Ykl0blEyUjZiZmJ0djA3QmNGMkY0a3NhdEt6bStHbVZob0ZZbE9q?=
 =?utf-8?B?ZzhuN2grZWhPSE8rKzRFRzFqMkhnQ05ONU1hQzV2cU1wU3VnVk01czFWV2Q0?=
 =?utf-8?B?eGFKaEszRmNiMk9SOStGS2tENUEvY1ViVkJWRGlNMzdLcmdSYm54TU5FSmtP?=
 =?utf-8?B?OUk4OTNNOFhSdjRDQ0tXb2YrdVNHN1FRSlUyeWlVSDZ2QnowaURNcU8zckFz?=
 =?utf-8?B?Qi9hZGJYM090TDNZNGkwQ254L1RSaG1qbXc4Unh3THFBamJqR1M3eEtYRFM5?=
 =?utf-8?Q?i7YoEjtcHAhI6A4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7A33C82E6AA434D926445C915FFFB89@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3b5dda-cdcc-4a31-2531-08deaff06d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:33:49.2861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajNix7GSDRfedUn7uxRjJRiICt4Xj72YYI9RYbngIUAA7Zby/8uCnRE0KIrOqJGikQKn2517MnnLRMtRHX5GPVbDPZXsGuiNUM7pPxrMiYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7636
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

SGkgQW5zaHVsIQ0KDQpPbiBUdWUsIDIwMjYtMDUtMTIgYXQgMTE6MjMgKzA1MzAsIEFuc2h1bCBE
YWxhbCB3cm90ZToNCj4gT24gTW9uLCAxMSBNYXkgMjAyNiAyMjoxMjozMCArMDIwMCwgQS4gU3Zl
cmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2dsb2JhbF9kYXRhLmggYi9hcmNoL2FybS9pbmNs
dWRlL2FzbS9nbG9iYWxfZGF0YS5oDQo+ID4gaW5kZXggYjJlYzQ1MGY5MDAuLmMyYjIwYTFkZGU2
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2dsb2JhbF9kYXRhLmgNCj4g
PiArKysgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9nbG9iYWxfZGF0YS5oDQo+ID4gQEAgLTEwNSw2
ICsxMDUsOSBAQCBzdHJ1Y3QgYXJjaF9nbG9iYWxfZGF0YSB7DQo+ID4gwqAgI2lmZGVmIENPTkZJ
R19BUkNIX0lNWDhVTFANCj4gPiDCoMKgCWJvb2wgbTMzX2hhbmRzaGFrZV9kb25lOw0KPiA+IMKg
ICNlbmRpZg0KPiA+ICsjaWZkZWYgQ09ORklHX0FSQ0hfSzMNCj4gPiArCXUzMiByZXNldF9zcmM7
CQkJLyogQ2FjaGVkIHJlc2V0IHNvdXJjZSByZWdpc3RlciAqLw0KPiA+ICsjZW5kaWYNCj4gDQo+
IFNpbmNlIHdlJ3JlIHRyeWluZyB0byBtYWtlIHRoaXMgYW4gYXJjaGl0ZWN0dXJlIGFnbm9zdGlj
IGhvb2sgdGhhdCB1c2VycyBjYW4NCj4gb3ZlcnJpZGUsIEkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxk
IGhhdmUgaXQgY29uZGl0aW9uYWwgb24gQ09ORklHX0FSQ0hfSzMuDQo+IA0KPiBJTU8gaGF2aW5n
IGl0IGluIGJkX2luZm8gd2hpbGUgbWFraW5nIGl0IGFjY2Vzc2libGUgdG8gdXNlciB2aWEgJ2Jk
aW5mbycgY29tbWFuZA0KPiBjb3VsZCBiZSBiZXR0ZXIgaW5zdGVhZCBvZiBvbmx5IGRpc3BsYXlp
bmcgaXQgYXQgVS1Cb290IHNwbGFzaCBhcyB3ZSBkbyBub3cuDQoNCkkgYWdyZWUsIGludGVncmF0
aW5nIGludG8gYmRpbmZvIHNvdW5kcyBiZW5lZmljaWFsIQ0KVGhlIGFib3ZlIHZhcmlhYmxlIGlz
IGEgcmF3IHJlZ2lzdGVyIHZhbHVlLCBzcGVjaWZpYyB0byBLMyBmYW1pbHksIG5vdCBuZWNlc3Nh
cnkNCm1ha2luZyBzZW5zZSBmb3IsIHNheSwgaS5NWC4gQSBgY2hhcipgIHBvaW50aW5nIHRvIGEg
ZGVjb2RlZCByZXNldCByZWFzb24NCmNvdWxkIG9mIGNvdXJzZSBtYWtlIHNlbnNlIGZvciBhbGwg
cGxhdGZvcm1zLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=
