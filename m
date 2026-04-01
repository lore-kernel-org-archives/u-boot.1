Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDAFD3517D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FAD383D8A;
	Wed,  1 Apr 2026 15:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="iH3DT1np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661FF83F5B; Wed,  1 Apr 2026 15:23:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1514783CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 15:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnYTYuh+Pd9crJyKejQCOdJUevQbtTOCAXUAxiYwph3gTGAV6usbw3aayUADYpF73cfCwmyvH5Wk4OLXO/HXawUFOXUv8yiEHk26u0gb3E8sivdAaWyQ7RtcIDpFASY0hH70Il5SFSmBjiQQUmJe86J5fOJy3HFqUFYU8sLCn3nom4pyRV66Vwp9bSr8arJrdTn6p3a2abZcrMla0cSVUI5VoLqViEY1wivq2miCD/lnV3Wx9klacxknKVC7L4n3/IiDJfObwIF7WxI9VB5tzUcNfipMyIRPPIm/89g0OlnOM/i7M1639xuCF46XpbfDyUf4OqTyhwHJa5sSVSSR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIuQhPAeSlIToM4OuExY2pPPMhHHPBE0GucD32RaWVs=;
 b=j6LwqmAZWB/s6dO/m/pXPPDGscoiHspTq1CGONm3iPhPAaxU0Q6bQj4oAB8h/ZrrDm8XIhP33YJbaxfOn7oXr3JkFdkeVJtVNyVrsQlEpfJ+qaR+3OfDm2HdiWqtt1c18hDvfj9GA5Hecijn4b0IW/6NyP7lyB8vH+cD/vqecj5TxQf/sWBVPJH5XQ5GfhvlMwClTWWKQDuOwhQylBVW7aPafnoEjaAEneOCpiglGCQwqYvE80pWj9pK0GWAhPGVyb7llGSWpi7IKNJU0teu0EBc+KOyX79pePWz42ttyt1VFVEdcJGW2WiDA3JgMKPfwKrkswRAQpZheFZe29q3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIuQhPAeSlIToM4OuExY2pPPMhHHPBE0GucD32RaWVs=;
 b=iH3DT1npqVdts5LHaqphzDTAYn87pMwPZWt54tkIWJWLygWceEo8m3kgdyOcvBCo03/UhlgCqgUa7x5sSZe3JAD+LNtvJPj+DAZ6jKwHObSfbuUOD8ouk6Z0LojrM/5k+sdsQGGbonpFpErHeyicfGZTg1wCKhJuFLYnishPWwscsqcZ/1I2vG12pM4WFckHJ66x8QMcvvLTPYgHzaK3z4BBLLOKHAzn8G5AuqjqXJo6TW/ye95hXdswgl30UfHcaQGoleIAYqUl6COXWtMSmLN4YO2UsvbkMsYsqSQWRa70Zh3cb6vI00duM32c6P3+R9+4gi6wQUtukoKpPI2kdw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:23:40 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:23:40 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "gregor.herburger@linutronix.de" <gregor.herburger@linutronix.de>
Subject: Re: [PATCH v2 1/2] console: add console_flush_stdin()
Thread-Topic: [PATCH v2 1/2] console: add console_flush_stdin()
Thread-Index: AQHcwdUBvQ086lMNcEion2U+Lfm7wrXKMdUA
Date: Wed, 1 Apr 2026 13:23:39 +0000
Message-ID: <4949364a3bb44781932b0f751d98e6e1a814d6b4.camel@siemens.com>
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
In-Reply-To: <20260401124128.178799-2-gregor.herburger@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3283:EE_
x-ms-office365-filtering-correlation-id: f3bfc949-1d5b-4e57-8081-08de8ff1e399
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: gg4diQGBAhXrYM0eowXqk9tjG43VSrnTtXTVKhhrvcn5KreyGSyTxoJc8s2ulGodTA543i10HzjVmc+FWnmSIdomSEI/ZIx9n0Bvrh6lxg8wMzrXsnxK/oCpY60X3QC/7QAtWywRdllXLO9q8V18wTDYA0Vkiikn+wON26fPSaUQX8+YCF7dYpbvrjQDaYy5YtFZQO5QZx0cRMtQNFj8k4aT3wNCvq4NrineH7lTktFvRo6BcYMqMpzE+PzocgCSONOLQBwmiYvxAJ6PhUvBCalOEFkg29R0Juy2BSpXH8lCKCYvFjW/NzaU0ZwT7TdmkQLb2pxu6csnKHMRMGCw1bwDx689hv//QAd7w6Axndf0kxI8FOedaK0gwGYR8j4SxMmkE6oWp7VbhQRsYiXQ4lSVuJ3JXLSFAMBaet8flBFrF1QW0o6oZo7RAqcpynwi07OuPl10hbyUYAe58O6GqvrkVrrAR8swmCRocXrimTuEG678sb7hZoiRiEXB1n5gQRdqCPSxNtiKU32p7b/Q1D0W64YEErg/pMZOaiaBqMSBdOTosy4oPX4lfkB4ArP1EkqAPcHJpgOTC8EU3L1vXKQqC09akiUeRDhn4bHK/SqlM9ILS+4vD57v3twgUAXTla11sZ92Q/s2VriQ94JZlymu2reOAc0j/4rm6tjKOLpKi1adBuDLK9+1izjbBpHAlou/6lm6OzjnhH1VjGrRdW0d59zJh4XWUFVuMJsBRlk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9aOS9kU3Y1dVpTOFlPWXdJN05WbVc2SUhlQmRzTG1XSGxjcnA4a3l0UVNP?=
 =?utf-8?B?VzVSQ3pSU3FRQ1I0amQrd0lHczd4Q3o0ODFDTmdKNVJjL2gzNmRHMEpXdmN0?=
 =?utf-8?B?c2NXNXIxZk1UVjlNTVpFdE9NQWNlcWQvb0Y1R3VoWWVZWGZybXQ2SWJhMXR3?=
 =?utf-8?B?Vk1KS05UUFVoVXJieDdLMXVJK1g2Vml3Rnl4UkZLeGNtY0EvSUpQeGkvajRE?=
 =?utf-8?B?L2VxMjRjY0YrK0lPVDJMaG0vcHNMOG4xU3E5TE9jbkY1QTFETkYyVmxqUVFj?=
 =?utf-8?B?SEZhRzNIekdtWTYvcWhQbUdiQ0IxQ0FvWW5RaFF0eGFQN3FJanp6cUtsSkpS?=
 =?utf-8?B?TU1ZaUVnRzVoTDNlVmo5T0xJbkFnVWVJdkszVStobXJ1S1V6VW53V3Mxb0tl?=
 =?utf-8?B?UENaU2lYdm84Y0swTXNyTStWM2hjTGQyRkxUM1JTSVBpU01pc29BZ3hFd3pY?=
 =?utf-8?B?NE92MUtGMUYraHBRRDRCcXE4QTNZNHZLOUJSUGV1VHU4V3JLMy8zNUh4VXJD?=
 =?utf-8?B?Wm1uYVEyY29NZmJKVWpsYXhlYTFoSHZEeHpicStYMlJwVlIyMDJEUkhrbTZp?=
 =?utf-8?B?M1VSbDMwQnFWaEFHN3VpQUZDWlUzT1FsS2IxVmdUL2o5eU4vcUE3TnpBOFFE?=
 =?utf-8?B?eFc0UFVHeVV4N3o3TzRGZWI3eW8rQVowZXV6c0VBRldCNDl5citGcUJyOER1?=
 =?utf-8?B?N0xBYnpjSU1kN1JUU2pnSE5CZ29hZldWb290QXBhNVpTUXhIY2hEd3VaT2s1?=
 =?utf-8?B?OEc0a09XY05BZFpRUFVHNUI4amVxTEVJTkE1b3duZVpCazJONTl4ZmFmT0lv?=
 =?utf-8?B?UllaTXRuS3ZtbmRlZC9HTXk5Y0hHZEFQZk4rMmJZYW56b2xLaDVjRDN5Qm4y?=
 =?utf-8?B?Y0J2VGNWMXNBU1ZGWEcyV2Y3NUgvM3d1WkZsNzRYMkYwVDBZVVVLcDZPRzlw?=
 =?utf-8?B?b1drVDlWdnozbFJDZitTeEtnVkNVdmgzRzhSOUVVQ3lPMmY0ZkticXlVTjk1?=
 =?utf-8?B?bHpFY1o3VjdhUURPUTE1bjU5dGZsM1h3WGFwejZJdGJvZGI2Vkp1SUQ1WVNO?=
 =?utf-8?B?T1UyT1daU2dHRUN1dHVWQnJqUHdWN2VBWTNTVnZ5YmMzRldXR2tQWGkyS2Yv?=
 =?utf-8?B?UWZCWnY2eStQKzBXT0Q4Y1Rwbi9Va3JHK3ZnbzZwbVMzcDBpK21Ic2dBZGNi?=
 =?utf-8?B?T2EzMTZOYnBxaW5iZy9YNVNNSVVhZEtlVGlicjRacXVQMGpLUHFJYWxlVG1x?=
 =?utf-8?B?VVlPb2o4YWRPaTZhWUxxRzlud2RlTmM3SGxoTFdlNEFwMXFNSXY0QjEyQTFo?=
 =?utf-8?B?R3lmMmpia0NZdmY3VkZlelc2cEhRdHdCUGhFaVFrTEtOYmxGN1JwSmdKYlcr?=
 =?utf-8?B?Z1BVVXpSMEJHVnhyWEhUVGRpdkNHamlRTGpLMkpaV2htS1FJMlpUc1BNS3R1?=
 =?utf-8?B?RGRFNkpoNm1LWFNGMjJRN05ZcUxxcXlLdjY1OU9hSlVuMGRrV1BoTmdaK0Mr?=
 =?utf-8?B?cHNabmxDYUN5elA5VEVpdGtOWnZsWVd2L0N1bzZuSGYyUGF1clBIYjNnazBr?=
 =?utf-8?B?czloQnkxRGpTek13NGhLY2ppdGlMZGhwS2Fxa20raWJCdmxkV2k1UGNUYmln?=
 =?utf-8?B?TXA3QVVrL2g0aEl3NmdmNEM4eDdic0lWYjZQeWdyQkRxeWFQUGxSSVB4ZU9Y?=
 =?utf-8?B?OVhKeWwzTWFWVUNmMXhaNFIxQjdOREF3MkMvampPM3hmdWZjY1hIZ2EyOHpk?=
 =?utf-8?B?Y3krRmpNcENmdktoWTUwcFpNNy9Tb0J5dWZJdjZwSDFvN0dpSlNaMlZLVkxK?=
 =?utf-8?B?eDZ2Q09LUlZ2bjZFL3NyV2gydXpOcGFrQ0s2U2IvNzZMV1grd1dmZ3NMRXpZ?=
 =?utf-8?B?V0xHNnZGa0JsamRzTWY1cWhadXIwOUlHcmZNcTFwL2JZUDdoU1YwdDlnM1V5?=
 =?utf-8?B?MVc4YnRmbm1jTDAvM3Z6SEVOaXZRUGd4WUtSRG5mSitoSWlwdm9pSk5hVjJQ?=
 =?utf-8?B?K3pSQ0MvVDZJcmJEQmhaMjR3WlBSSWFONVJCd0F6NUc4M3kySkJMSUlDaWR5?=
 =?utf-8?B?Zi9zOVYxRlpjNXk0a01sdVdBNEQ1TjkzS3I5NUJWQTFoUDhXSUtXV0JKRFZp?=
 =?utf-8?B?UU9pU0lMZDNRSTMzKzRoR3lZYm5IUVhJZndMTlR0bjI4dW5ycDBNRkpJWFhu?=
 =?utf-8?B?eEoydmM2WkdoU01kL2pTMGZ2S09Cbm83MEdUYVdzVmNaTmZ4Wkxwdi81UlBk?=
 =?utf-8?B?N3FSbUdjbERMQVhiRkNKT0VLVGJOZHNmc1o4Tis3aWhXVFEwaE5Md2lkMHN4?=
 =?utf-8?B?c28raXkrVkRLOXcvNitpT05taXFlWHZLaWxSL29SUVoxMmgzOEhKdFZFc0p5?=
 =?utf-8?Q?de3t/MmHOn9GRT8mbz1SR9Fjx8eA7okHMf2dy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <703A948E2E81AF41AD8A85325FC275A2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bfc949-1d5b-4e57-8081-08de8ff1e399
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:23:40.1033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZomIisMevmhUqScw7XFnAuevr4V5HsZhZCtQlL6JftBmaqy94Qlg6HzhOARpjW1YYRIQusAtuXUU4gTjgbsBBGbjnxKhvOJ/H6l10DV4GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3283
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

SGkgR3JlZ29yIQ0KDQpPbiBXZWQsIDIwMjYtMDQtMDEgYXQgMTQ6NDAgKzAyMDAsIEdyZWdvciBI
ZXJidXJnZXIgd3JvdGU6DQo+IEFkZCBhIGNvbW1vbiBoZWxwZXIgY29uc29sZV9mbHVzaF9zdGRp
bigpIHRvIGRyYWluIGFsbCBwZW5kaW5nDQo+IGNoYXJhY3RlcnMgZnJvbSBzdGRpbi4gVGhpcyBj
b25zb2xpZGF0ZXMgdGhlIG9wZW4tY29kZWQNCj4gd2hpbGUgKHRzdGMoKSkgZ2V0Y2hhcigpIHBh
dHRlcm4gdGhhdCBhcHBlYXJlZCBpbiBtdWx0aXBsZSBwbGFjZXMNCj4gYWNyb3NzIHRoZSB0cmVl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3JlZ29yIEhlcmJ1cmdlciA8Z3JlZ29yLmhlcmJ1cmdl
ckBsaW51dHJvbml4LmRlPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdlcyBz
aW5jZSB2MSkNCj4gDQo+IMKgY21kL2Nvbml0cmFjZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDQgKystLQ0KPiDCoGNtZC9lZmljb25maWcuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA2ICsrKy0tLQ0KPiDCoGNtZC9lZmljb25maWdfc2JrZXkuY8KgwqDCoMKgwqDCoMKg
IHzCoCA0ICsrLS0NCj4gwqBjb21tb24vYXV0b2Jvb3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxMSArLS0tLS0tLS0tLQ0KPiDCoGNvbW1vbi9jb25zb2xlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxMiArKysrKysrKysrLS0NCj4gwqBpbmNsdWRlL2NvbnNvbGUuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDUgKysrKysNCj4gwqBsaWIvZWZpX2xvYWRlci9lZmlfY29uc29sZS5j
IHzCoCA3ICsrKy0tLS0NCj4gwqA3IGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDIz
IGRlbGV0aW9ucygtKQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3
LnNpZW1lbnMuY29tDQo=
