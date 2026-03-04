Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3A3EB7EB2
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 09:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A7D839A8;
	Wed,  4 Mar 2026 10:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="SglgRqvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4100783D8A; Wed,  4 Mar 2026 10:22:37 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114A5838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 10:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2QRbJ2E0v5Bf6X9s1puPQAke1U4lSYpSBc/p6WVrZITxmHznWAa8ZCtw2AC5hMqki94ywEShJ/rZARrckLWzBV6YnOw8xueOKUB9rxm5OUt2cU6L1++QYOns8yofMV6GEMP+QeqBxj5uQj+QIt3A9CALvXYjKUn0h9e/xZ51bsCm28jP8OmXPellxDWLUkZChVjM5OEFV4rwKH+3usn7TwW3RQv37Wlj6VJgFvqDbyJxdVP25SKJbYUGwCAuQCfygKYyil46cxs94SkztnNEFEJerRhI7HG975iPrXTtYK/0RF6581tMfaRaws+n0DCpXgEMOpFCDqQ42JE74xteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw0kcwbK+FnbN1i4ELT0Nxax9Uckvft/5lkhp4Sl8dU=;
 b=nIsmS9dwavnuQYfeestINXxcGjNX2QFhaNdUpHuy9r3YT+GKTMEsNlbTB416afItsCRPawSrk0+gtgArRjcWJz7L9LPCmtwqIEZ+7BZ48zbyKGM8Z+oOYD8rlz5/h5sQUfcVGCMdP63DbW9QoeHLtg2JgHIMrmR/GOEA2ubvJ/0zZz48oeMvor9uMpUQkppFFzok/ygcxUY4cFm1tDoA6vLua/FVyoi6ym6uHVpQDRTdIAeU73cepejmmBmQ2TwME9mytCI6eWmkClWZcz9YeooPIrzP6mjrRsYTrcQDoXwyY9RXc12VhVTgel0jE7Y1DZ7kXbTyevHbTg6maMpC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw0kcwbK+FnbN1i4ELT0Nxax9Uckvft/5lkhp4Sl8dU=;
 b=SglgRqvx6A0VtwBlr+O1Y50OMBmsaJ6b99gxFStt6zCrhCaOLlc+tIbz1RlgVFL0xyPk2VD5JdRgYrDB82uRiuQBq1Yj6Mya3CBK+KWrbS3pzdM4IOVtgMQZXfY201a922QaMj1cnfw7K3qV7pd9vTPCckwICHo+kIHCQpfhvEFf0LTPiMMV1wtNHAZzxWXmNulhAAtRPbGBEV8iXQKgRIBRvBJvcRLiwM1tDUAmuRC8ymQdNFzAD8TVr/7bBEmkp+CgEeMAxTNbHthsvcgYfJfcctYWWy5SrMHpb/JuMJ0vVehozlyAN3BPcnvnrjyXuw4tDY8l83EmBU9s+J+7tw==
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS1PR10MB5770.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:22:29 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 09:22:28 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Thread-Topic: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Thread-Index: AQHcqpFJ1YF/KEaHMEuKGw0kLOVrwbWc9rWwgAEk/oA=
Date: Wed, 4 Mar 2026 09:22:28 +0000
Message-ID: <d175c4628cefe9d86ec7e8d44e05a85bf081f1ff.camel@siemens.com>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
 <20260303155335.GO1388590@bill-the-cat>
In-Reply-To: <20260303155335.GO1388590@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5019:EE_|AS1PR10MB5770:EE_
x-ms-office365-filtering-correlation-id: 198bca4e-ebc6-4e5e-7dc9-08de79cf8e28
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7142099003; 
x-microsoft-antispam-message-info: epw3QGcKZuBXn73zuQFKkFAk5TcWjYzlk0OwWmkiLaBhxptzUV4889Xpe084XlYf9FPiUabLUbVZF9Fc17zX0vKqKu+H6Lyi/vaw4l6bOk3bAE6HyxTP9QJWqzWRC2jU4jWx3pMAIEm8bSkqXciolB4n0iQlz8yISYaQi6VoTcZpFT1+tb21nP13+JhgYElGSFuQ5gucCpKinCaVQFPlJElOea7DoXH7R0khg2rNbuyKYTTlrmrAOCJb8xuCttDW/fzVEuNYnDjrraROhVA1hQt4nR1OAP78VZ6IscHZbCg6BDYeyEi5I0krUONrsG4uUUyNC35mUoML9f5gBcRdX0OVHWowFsIzBJQBw/wo7ae5pUH+UjL9V9/5s22WF6cZVTFvadSM2iezjntjoJKfgSnCaDEpbAg76OoC+deGPRxph95N8Y9qVtWa1BBNnRj6ik2WP+dU9uTeQt+cuypPSWighW7mu0IWeFxHHo5awk9L4+AwWS2LHPm+MQnXjk8GVor0xpsSo4qb4SCTMl8yAmQl6wxyb8d34hguQ3+l8O7r5xxxYpdblzU972+/CKRKinuEUaFT0ncxqmg3dk0SVPRTWe0TSgUdTmSCSHWNg7htv/YYb2NUOK2BLIBmYPSacEN+QdDeqLpDCwelLoMzcyN3+rpRvuUoTei0ozy4q2+Kf10iW/kqPvy6hyDeYwrBlWhfXXPX3R3yZGmcYrlcESK+RFguUNj7W6FoGlSeVlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7142099003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1NNUXplUFo5RmgrSTljQ3ZYdGw3NStzWTJ5aWh6aURQcXJJS0RFd0dtejhK?=
 =?utf-8?B?alh4ejZWdmNYZnhGb1AySkwvQTREOTRybkpRanZ5MU5QcE5nb2dOMG1TZElp?=
 =?utf-8?B?czhKYTI0NzQrQ0JJR3ZCckNtbHRHMHM2dDZwR0NwOFpSTUJ6c0UyWDRJejVY?=
 =?utf-8?B?Q2NmK01yVUxKR01NdkpXMm5adUhqKzdkNzZDNzB0aFlWc2tqS3krRG1hQXBk?=
 =?utf-8?B?TnJDbkdpc2dPeStPakNEcTBFaCt3a2doeXV1YkV2SXdiVVN2cklabHh2ZTZG?=
 =?utf-8?B?eDZ5bW1ydG5DUnZ2UG0yejE0N013Q0FsOEhnZTJ0eEZiTjZhTGhBR2lsNkNC?=
 =?utf-8?B?OXAwTGoyemszWm1UcFFYcmhsN0k2T3E5OHFERkE2RkE4K1hnbmkwM3BiSmpF?=
 =?utf-8?B?SytCanhpb1F4VXYyamRFM3FEMXgrUGV1NVZKN1lvQUsybmVMZkVsdnI5K2c1?=
 =?utf-8?B?RkVLVTN2cHZwYkZVaGRsV292QlQzNVhXUkM0blJVVGVVVklBVEd2aWNGcXVr?=
 =?utf-8?B?SE1yVEUwTkVybHBtM3Q1bi92amI4K0lWdXRRNUJ4NzN0bDdZcHJwbWJ2c0hQ?=
 =?utf-8?B?QWc0eWFjRytVSzduamtPNDRobUx1Mys5b215WG81a0lIelJDZXlYZGZhbXlL?=
 =?utf-8?B?ZWFyOWlqRlQyNFhXRmFQVFp3cDVaSUdXQi94U3B2UURCYTIrNWkzOGdzdlJH?=
 =?utf-8?B?SDB0Z3pMYmlNRUh3ZGVJTDZJeFZ2eXRzV2RNcjk4VGl5dUhBaVhhNXl2akxM?=
 =?utf-8?B?WHRwWGxCZStSMkhnOVBKN3d3ZmREVlMxelMzVzN4SFN2OTZVVFFka1Yxc0F5?=
 =?utf-8?B?ZXRZRFhVZ1B4YTJMTFhvQStpRlNOTE9aZ2tJLzZidmdHYnlaUVlaczNYRXZP?=
 =?utf-8?B?Um41Y0JDNVhXL3NWMDdZRUs2dTJJYUpJbDZLRDI3QTRnTy9kYTVBOC9BU2Jt?=
 =?utf-8?B?cFEvZzFMSmNJR3FsaFp3WmpvMXhNSkdWT01IS0ZrSzg3R3BkeW1hSWk2Z01X?=
 =?utf-8?B?TWp3bmdnZ1RtbXRZYkVISUtQM2llQjQ2cTkrKy85OHdyMlJjZFQvYnU1R2tR?=
 =?utf-8?B?TzM4bDE5cnZUM3I4Z3BVVXczekkzTDdVU0VsOThseitFTE9zWFloR0xFcW9v?=
 =?utf-8?B?aHdtR3diNHNnR0hiUjVIWFlrcmZFUnZZNEcrcEI3UzhLL2g2a1dYSDk0YUR1?=
 =?utf-8?B?OFJZS2JWTVQ2aDdORHZxa3lvVGI1aFRpNDNhbklEK3lxVE1yb0dXNkpKZ2ds?=
 =?utf-8?B?ekZhb25vYW1SS2dadzhGWDNYbmVXSFMxc0RXcW1tWlNIQU5pajlpTEphZ3lp?=
 =?utf-8?B?RUIxdTJnaU5Tai8xYlp3VzJ5bkk2U3BpVVRvYlI2eVJBOVdPSmVwczZsTmZJ?=
 =?utf-8?B?NlZPZGhRQ0o2S0VqYjJzZXBMRFI4d3BVcnZPUFF6eVdWQUtobW4rbm5LS01n?=
 =?utf-8?B?TUEzWUgxQnYrb015eGs2dFRQOFRXc2Q5WE1FZFlCUUcyTm02RVFHdFArYmYz?=
 =?utf-8?B?WlVjcy9UQ0lZSFExU3NMOGZaeWtuMUMyTXNBQTFwa2R2d3lHNmNOVmdQNCtq?=
 =?utf-8?B?Z1ljV0kyaWpDcW5WNDhoU3hNWTZZTDlLaUNCUDN4RGQ5RTl2ZlRaWWVlSjFk?=
 =?utf-8?B?bjVxcGRnbHRQaGx0ajVGaEZGejExNlZWNzFnVE93dkRoZHM0YnBxSkdhSE5n?=
 =?utf-8?B?MW9KUlU1M1V6VTAvWFNabndOL0tkUkJXNElQTmFkeUtnclJYYnhUMitENmRJ?=
 =?utf-8?B?VjBkbUVZQXUwUTNMOG9FMG1WZzM0WFkvYUF1SVBVSE15OUd5RnZIQmxjSkN2?=
 =?utf-8?B?NFBZNDBkSmh1V0pXYVBjWStDWHg5T1NGUkhCYnNuSkMzYXV4WHVEL3BaREVp?=
 =?utf-8?B?dVlRM1NzRHRzSDZybzNSaThQM0x4Y0ZDaWJpMkVxcjdLRVZJVTVodEdqOFUz?=
 =?utf-8?B?QktpRzViWVFaNHlwaCs1NC9tbXl2aWlTRkZmOFY1YWZxeTBrVDNnSW9CbVBk?=
 =?utf-8?B?RWh6ampUMU5QV1YwSUdtMlFtRlpXTHg0K0M0bnk3ZXhidUZvRzZKN21tZU93?=
 =?utf-8?B?R1JQSDJmaHZLSjkzQWRNR2sxOVpaRHpZVWdESVJwcmRaVjR1ZHpDaFBIb2Mw?=
 =?utf-8?B?ZVlkLzFUSGh0T0Q5TjJTVnZsQ1EyMWpLdjFmY05nendndm9zK1RLNlpCZm9E?=
 =?utf-8?B?MmM3VWRkZjNlTFlDWUhRZDhqaU9EUHBjcU5rbkF3L1VjcjdQWWszSkg3dnlz?=
 =?utf-8?B?T3djTmVoSmQxaENBb08xbTFGaXIrbmpyYlJmZUNQcXZMU01UOGY2TGc5cHUx?=
 =?utf-8?B?dWpZdFhzZzYvTDZwTDhXOUJVbldOR1oyK3BRM1RWa2pJWE1JdVhWdnA1NTVo?=
 =?utf-8?Q?i+ewZ9O2Ywi+CYNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF3A27319AAE0449977AA473653F5A54@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 198bca4e-ebc6-4e5e-7dc9-08de79cf8e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 09:22:28.3251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVUbElB1au6zACBa1dB8xzmgwVTwK8iip6QUFjP1cxwzjLaX0nj1xp00W4BGTwNGC82yyHh1PUlKaopTRYvImpyTTScQxongF6utoRyibMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5770
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

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDA5OjUzIC0wNjAwLCBUb20gUmluaSB3cm90ZToNCj4gT24g
VHVlLCBNYXIgMDMsIDIwMjYgYXQgMDk6MDg6NTlBTSArMDEwMCwgQWhtYWQgRmF0b3VtIHdyb3Rl
Og0KPiA+IEhlbGxvIFRvbSwNCj4gPiANCj4gPiBPbiAzLzIvMjYgMjM6MDksIFRvbSBSaW5pIHdy
b3RlOg0KPiA+ID4gVGhlcmUgaXMgYSBmbGF3IGluIGhvdyBVLUJvb3QgdmVyaWZpZXMgYW5kIGdl
bmVyYXRlcyBzaWduYXR1cmVzIGZvciBGSVQNCj4gPiA+IGltYWdlcy4gVG8gcHJldmVudCBtaXgg
YW5kIG1hdGNoIHN0eWxlIGF0dGFja3MsIGl0IGlzIHJlY29tbWVuZGVkIHRvDQo+ID4gPiB1c2Ug
c2lnbmVkIGNvbmZpZ3VyYXRpb25zLiBIb3cgdGhpcyBpcyBzdXBwb3NlZCB0byB3b3JrIGlzIGRv
Y3VtZW50ZWQgaW4NCj4gPiA+IGRvYy91c2FnZS9maXQvc2lnbmF0dXJlLnJzdC4NCj4gPiA+IA0K
PiA+ID4gQ3J1Y2lhbGx5LCB0aGUgYGhhc2hlZC1ub2Rlc2AgcHJvcGVydHkgb2YgdGhlIGBzaWdu
YXR1cmVgIG5vZGUgY29udGFpbnMNCj4gPiA+IHdoaWNoIG5vZGVzIG9mIHRoZSBGSVQgZGV2aWNl
IHRyZWUgd2VyZSBoYXNoZWQgYXMgcGFydCBvZiB0aGUgc2lnbmF0dXJlDQo+ID4gPiBhbmQgc2hv
dWxkIGJlIHZlcmlmaWVkLiBIb3dldmVyLCB0aGlzIHByb3BlcnR5IGl0c2VsZiBpcyBub3QgcGFy
dCBvZiB0aGUNCj4gPiA+IGhhc2ggYW5kIGNhbiB0aGVyZWZvcmUgYmUgbW9kaWZpZWQgYnkgYW4g
YXR0YWNrZXIuIEZ1cnRoZXJtb3JlLCB0aGUNCj4gPiA+IHNpZ25hdHVyZSBvbmx5IGNvbnRhaW5z
IHRoZSBuYW1lIG9mIGVhY2ggbm9kZSBhbmQgbm90IHRoZSBwYXRoIGluIHRoZQ0KPiA+ID4gZGV2
aWNlIHRyZWUgdG8gdGhlIG5vZGUuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggcmV3b3JrcyB0
aGUgY29kZSB0byBhZGRyZXNzIHRoaXMgc3BlY2lmaWMgb3ZlcnNpZ2h0Lg0KPiA+IA0KPiA+IERv
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB0aGlzIGlzIGEgYnJlYWtpbmcgY2hhbmdlDQo+
ID4gZm9yIEZJVCB3aXRoIHNpZ25lZCBjb25maWd1cmF0aW9ucz8NCj4gPiANCj4gPiAtIE5ldyBV
LUJvb3QgaGFzaGVzIG1vcmUgdGhhbiBpbnRlbmRlZCBmb3Igb2xkIEZJVA0KPiA+IC0gT2xkIFUt
Qm9vdCBoYXNoZXMgbGVzcyB0aGFuIGludGVuZGVkIGZvciBuZXcgRklUDQo+IA0KPiBTYWRseSB5
ZXMsIHNpbWlsYXIgdG86DQoNCkknbSBhIGJpdCBjb25mdXNlZCB3aHkgdGhpcyBkb2Vzbid0IGNh
dXNlIGFuIG91dGNyeS4gQXJlbid0IGJvdGggdGhlDQpwcm9ibGVtIGFuZCB0aGUgcHJvcG9zZWQg
Zml4IGEgZGlzYXN0ZXIgZm9yIGFueW9uZSByZWx5aW5nIG9uIEZJVA0Kc2lnbmF0dXJlcz8gOi0p
DQoNCklmIEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUgZGVzY3JpcHRpb24gcmlnaHQsIHRoZSBwcm9i
bGVtIGlzIHRoYXQgdGhlDQpgaGFzaGVkLW5vZGVzYCBwcm9wZXJ0eSBpcyB1c2VkIGZvciB2ZXJp
ZmljYXRpb24gYXMgaXMuDQpJIHdvbmRlciB3aGV0aGVyIGEgc2ltcGxlciBmaXggdGhhdCBkb2Vz
bid0IGJyZWFrIGNvbXBhdGliaWxpdHkgaXMNCnBvc3NpYmxlIGJ5IHRyZWF0aW5nIHRoaXMgcHJv
cGVydHkgZGlmZmVyZW50bHkuDQoNCkNvbnNpZGVyIHRoZSBjb25maWcgZnJvbSB0aGUgZXhhbXBs
ZSBhdA0KaHR0cHM6Ly9kb2NzLnUtYm9vdC5vcmcvZW4vbGF0ZXN0L3VzYWdlL2ZpdC9zaWduYXR1
cmUuaHRtbDoNCg0KICAgIGNvbmZpZ3VyYXRpb25zIHsNCiAgICAgICAgZGVmYXVsdCA9ICJjb25m
LTEiOw0KICAgICAgICBjb25mLTEgew0KICAgICAgICAgICAga2VybmVsID0gImtlcm5lbC0xIjsN
CiAgICAgICAgICAgIGZkdCA9ICJmZHQtMSI7DQogICAgICAgICAgICBzaWduYXR1cmUtMSB7DQog
ICAgICAgICAgICAgICAgYWxnbyA9ICJzaGEyNTYscnNhMjA0OCI7DQogICAgICAgICAgICAgICAg
dmFsdWUgPSA8Li4uY29uZiAxIHNpZ25hdHVyZS4uLj47DQogICAgICAgICAgICB9Ow0KICAgICAg
ICB9Ow0KICAgICAgICAuLi4NCiAgICB9Ow0KDQpUaGUgZXhhbXBsZSBkb2Vzbid0IGFjdHVhbGx5
IGxpc3QgdGhlIGBoYXNoZWQtbm9kZXNgIHByb3BlcnR5LiBJdCB3b3VsZA0KYmUNCg0KaGFzaGVk
LW5vZGVzID0gIi8iLCAiL2NvbmZpZ3VyYXRpb25zL2NvbmYtMSIsICIvaW1hZ2VzL2tlcm5lbC0x
IiwNCiIvaW1hZ2VzL2tlcm5lbC0xL2hhc2gtMSIsICIvaW1hZ2VzL2ZkdC0xIiwgIi9pbWFnZXMv
ZmR0LTEvaGFzaC0xIjsNCg0KSXMgdGhlcmUgYSBsZWdpdGltYXRlIHVzZSBjYXNlIHdoZXJlIHRo
aXMgdmFsdWUgd291bGQgYmUgYW55IGRpZmZlcmVudD8NCk1heWJlIGZvciBhZGRpbmcgc29tZSB1
bnVzZWQgcHJvcGVydGllcyB0aGF0IGFyZSBvbmx5IHVzZWQgZm9yDQpkb2N1bWVudGF0aW9uIHB1
cnBvc2VzPyBJZiB0aGVyZSBhcmVuJ3Qgc3VjaCwgdGhlIGBoYXNoZWQtbm9kZXNgIHZhbHVlDQp3
b3VsZCBiZSBhY3R1YWxseSByZWR1bmRhbnQgYW5kIGNhbiBiZSBjYWxjdWxhdGVkIGF0IHZlcmlm
aWNhdGlvbiB0aW1lLg0KTm8gbmVlZCB0byB3cml0ZSBpdCBpbnRvIHRoZSBmaXQgaW1hZ2UuDQoN
ClNvIGFuIGFsdGVybmF0aXZlIGZpeCBjb3VsZCBiZSB0byBtYWtlIHUtYm9vdCB3b3JrIHdpdGhv
dXQgdGhlIGBoYXNoZWQtDQpub2Rlc2AgcHJvcGVydHkuDQpGb3IgYmFja3dhcmRzIGNvbXBhdGli
aWxpdHkgd2l0aCB2dWxuZXJhYmxlIHUtYm9vdHMgd2UgY291bGQgcmVhZCB0aGUNCnZhbHVlIGlm
IHByZXNlbnQuIEluc3RlYWQgb2YgdXNpbmcgaXQgYXMgaXMsIHUtYm9vdCBjb3VsZCBjYWxjdWxh
dGUgdGhlDQppbnRlcnNlY3Rpb24gd2l0aCB3aGF0IGl0IHdvdWxkIHVzZS4gSWYgdGhlIHJlc3Vs
dCBpcyBlcXVhbCBvciBhIHN1YnNldA0Kb2YgdGhlIGNhbGN1bGF0ZWQgdmFsdWUgaXQncyBmaW5l
IHRvIHVzZSBhbmQgYW4gZXJyb3IgaWYgbm90LiBTbyBldmVuDQppZiBhbiBhdHRhY2tlciBjYW4g
bW9kaWZ5IHRoZSBgaGFzaGVkLW5vZGVzYCB2YWx1ZSwgdS1ib290IGNvdWxkbid0IGJlDQp0cmlj
a2VkIHRvIG1lc3MgdXAgdmVyaWZpY2F0aW9uLg0KTWF5YmUgaXQgbWFrZXMgc2Vuc2UgdG8gYWxz
byBpc3N1ZSBhIHdhcm5pbmcgYWJvdXQgdW52ZXJpZmllZA0KcHJvcGVydGllcy4NCg0KY3UNCkx1
ZHdpZw0KDQotLSANCkx1ZHdpZyBOdXNzZWwNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
