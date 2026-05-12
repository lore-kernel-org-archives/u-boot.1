Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2330DCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F61480398;
	Tue, 12 May 2026 10:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="dRkAlehm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BF9803C6; Tue, 12 May 2026 10:48:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD8D801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpC9LrRiLxRTFI2naRCCk/SY89JN8T1Ap0s0I/sgukZhuV1WZPRiKH2WJeychV8Xi6UeduyYBzVs5Tx2iQ+w8JrSzw8Fub8I/gilV/djZSxUzN4DmyBcCycwkCfCFH/85+U7tL4NBceu2p2KA4s46ZMRWw0uxe55PFih0LroJWYcQIUI5FBJCuKfUn0L8iaHH7JWXEIWvsaitm9P8G+x0OdLyYZni0SLmpaj+ukggUrXdJVHweaVkEHC+Rc0leIpHe5ZxBWrlqawNIMqJCr1hQMPLYwmyF24bkaObUiQ1VgxHSq+4vdDWLRac/qS1j/++0C5pyU2MbXvwOLiALoxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAfTrEGKmwsrQjNIwvaDfBhKTLnuN5/CPDbljeV2ZkA=;
 b=yvMtcKiCpivxKWCpf7TSWD0A01F8tkdY5cLa70M5tJWmYREYka1UZ3nf1IeqRVFq+u9KDMAXNjAFBNgmTbRH3I5Rm2YCbsQ2RL/rLD8anyirzD6JIT84sz1f8877PbT2Evy+WOBhaRxq9RH4CuiFGnIQKZ5wdEf7fRmOsis3GBqvlVFS1ZnrEDLJQCCplYQKJBwGt8C5IDhx76D0/zd6zqCzeP7ZbGm0VHD2vOgF9+pd3DAt7i7Dr+IV9/hYlapQ/YRKQLqfBGzKBtOE3aTLIKrT1A60CBYrdxP3yfx4Hh4JhG4kUQd8MVtdYcr1BsI6EM+q6yLkx627AlgdED2qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAfTrEGKmwsrQjNIwvaDfBhKTLnuN5/CPDbljeV2ZkA=;
 b=dRkAlehm9OBCb6l5jM4lsxSDV0sVZsShsLRDRKIRtazY7Kut4vV0wZSzHU4c5bUxXpkb8FHkf5SMmJwaB+kCCIxmCNvgAP+0XvKfnrc5AIuP3HgcSz4+7Dn0Hs4ZkG3F6Dcy+kAozjwpMryvH3NQKgQbVRbOSr0gP0UJe27CCTklPyWvjDDTB0ktUlH+FGTFQRv0PohpVgIVcFp3g93h9YaPd10WpfRDgLQjkIwxgsW5hQKxfGA0EDVKr+H6gSXRNPupU1G5c5QUfVnJOJku5aTAvPsvkADSZTPE8YnRdMjX1B1VudcRkdRelDQo3/PlwwR/dRamgIMPIgRK5Ptv+Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB8085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:48:43 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:48:43 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 4/8] rtc: pcf85063: add missing register definitions
Thread-Topic: [PATCH v2 4/8] rtc: pcf85063: add missing register definitions
Thread-Index: AQHc4T8p2zhyDF48oUyHJIxmpudd97YKFcYA
Date: Tue, 12 May 2026 08:48:43 +0000
Message-ID: <7c39812371a60b3ffcaaa2f297d1428e478b620b.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-5-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-5-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB8085:EE_
x-ms-office365-filtering-correlation-id: 330c9589-b5e6-47d9-77f5-08deb00345c4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|55112099003|56012099003|22082099003|18002099003|11063799003;
x-microsoft-antispam-message-info: DxyCM6wJ/KZpPDbJHTh1ctq1+kusFSz9uupOiWJ4OwqHcAXJgJPFiac6XLYxD4m5NkmIU/vLTY//NMo9dMX5Rmdju02IR+jyyhIEKHG1PxNzjyZaHsdWdGh85RB/lZMZKoUuV2f/2WVBYI+tqPOMTwHCBLvh3fkp8YEKFCnFPghDR9ct6WPrwidqVR9lgQfo0zGQ6CZK5GNpU6a5qdOHz/N8Ik87uqAfzxP+vj8/olZFtZvzHYgwUYksLrX/FTiQ62znOAA57Gc1DSzrKXzZjC7+eQGnTLn+o7I+IJ460MwLvE+BZYvvSzJRPGpPTwUA0ff3H0yA1C01bFoIKH7ISJjGeTNqsbV1v7AvxCB2PPpPc/oqUy7KswJI7dF+qcPD9aHhyl++/vyfiDGoPUxY5CHSotPYD/DeRbEzLar5NOIYABd3xeS1SW94SUrLhX7WDyQk/e2k87+KJ3cJ0Hn6fvkNWaDcci1CdB+ZuBDhPWH4NZUf8LwxWfY1i2Tj0FnCJ+EyTfZ9ljMFmerQb/dpGZnjZAIZW1X5NA/K3QkOymarW3jFIBxxfMk5arRqRGJ2JPVFEdBPOlWQf0HDVz0Zt6HcBYbCv0hN+BVv2oSb5iw8lHEVymNIUaa3lCw5emgfFuCtfPPoxyQEdDUWUegwD887NjkNaVZuCVfvUWAVaP9K5yUVMfVhFmZ97Nzht540xhohKgF9Zf5FrLXTNFyKQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STVRU3FTSTE5NDhLT0dYRjkycGdVellsTFJXTERGL3E2SUJZMkVTbEdLeFFq?=
 =?utf-8?B?QlZZd1dTY1czblVtenVtYThkNmVoamZHSFNWaDFnc1pYeCt2Q203akpsV1dq?=
 =?utf-8?B?Ymg2cUxtc0kxYkYyN3Ezb0puNStWYVpKSktmNTdPZHFDQkg3TVdjcjE1aWU2?=
 =?utf-8?B?Z0RjM2w3TnE0RmdBWFhDbXhZcFhyMXBUaDFNTlZFajV3MHJtcExWdXhlV2Rm?=
 =?utf-8?B?ekZDRmJkd2xtb1NVSE9sNFY2NFhEbC9yS3kyU055dmMrL0hyT2xKNjRxU3hX?=
 =?utf-8?B?OXlPZE9GSWtnbzdNNTdBa0czRzJxK0kzZFJVbGhtT1pqa2Q5bUN0M0pham1x?=
 =?utf-8?B?Zzg5Rkxkb0gzOG82RlZtSSsrMkoyVFJ3QTZSQmlTYWo3ZUdQWkxoREpZUFJV?=
 =?utf-8?B?dzE4c0I4ZXZ5Q0hrdVJFN09OUUxNZG5EeThJa0phSmM3N2hBMStYRDRFLzl5?=
 =?utf-8?B?YzJQSHd3a1EzYTFuUkNlYnZGVmUxWU5KL3IvaXhKWGFlRkgrRFVtTllKQi96?=
 =?utf-8?B?M1g3eXZyclEvQ3VTa0NCbEhjSENvYmVMSXJWKzdRc3NSdjNlcmN2Q0huYkVy?=
 =?utf-8?B?WGEwdjFqZ0FnU2VoazdCK3ppTE1yMkRPM3N0UW9vRDlBczdMd0pxbE5xNWdk?=
 =?utf-8?B?Y2ltUXJPbWlQNzRsVktxdnRlL3kzSEw3cUVTb3BHZTlrNFIwM3B6SC9Tb3Vo?=
 =?utf-8?B?VW1sTGh0UzFNMmNOQjVSTjFGYWVnelJxWW5sTVU4cUFMWms4WDBldGlZZGNy?=
 =?utf-8?B?SnJMMHZUQS9NRnBrd1VYQmd3Uk4zdExWSkkycDdKSHA0STFzTnQ0OVhhTmRw?=
 =?utf-8?B?d2kyMzk3a0wrWEM3VnRVZjlIR0hOc093czVnNTJoRGc2ams0d1F2aUNPWnY1?=
 =?utf-8?B?aGVsYXkxbG1HWGFGNm9MUndFOGp4MWJRMGRsRUgrZ0RRcmtMaEFjbUQya0Ru?=
 =?utf-8?B?MDRKSDRzRE5xWlRnTEQxN3UrTm9XbW96dzcra2ZyTWc2YW5UWklKNG01Ymlr?=
 =?utf-8?B?aXAzOXBKcVpQRzhGZUh4enFUMno4VEIxUStqK2FLRWdGbnkwQWtuUGljaS9L?=
 =?utf-8?B?b1hPL3RHMVA1V3pSUE9jYk96SWdMcVlSZ0JnR1YwZHpKYW9DQVNJaDZnUnNN?=
 =?utf-8?B?WUg5NVh3aUNHZ0tlL2s4ZHNLNWF4TGIrTjJDU2tUQ1ZPWDBSb3NzN1B3Szdv?=
 =?utf-8?B?TnA5b3N5eUdsRXExYjdhWnhvWnJNZFM1NnFMRWtDTndQNEl0Tm5JMzZTOVla?=
 =?utf-8?B?aE5mbHVKVFdqZ1IxUkRVZ2FjZ3gzTDlZa2RPRVFRS2V1OU9UOVNRcDhrRnJp?=
 =?utf-8?B?WmRpSC8yODE2UkcwcFArR1F2TEZRams5ZzhmZ3BDOEVOazNNVHZwZlJvRExp?=
 =?utf-8?B?VHFVelorUDhWS0dmdzlXdk5xWlhOLzlhN1d3RmlET0NvKzdwNVp6SnZEeGpz?=
 =?utf-8?B?Tm8wTVp2YThiTFZWK3UrcURVdzl1MmlWYks1QmMybU94cUZSbVhCQUJHU05Q?=
 =?utf-8?B?bGx0TmNHbm5UQnRTelJpNjR1UnhiQ21NOUFDeWtSQnRicDV6eWdYY25FYjZX?=
 =?utf-8?B?V0lzamtZcVNSWmVEYVpPTkhVekhSUGxHYnRWdTVleXdES1VqZURhQk02MEND?=
 =?utf-8?B?YUM3VXJYS2lVL05nTW5od2JWcldDRE5YUkUyS1NrRERHT3E1T1hScGEzTkZI?=
 =?utf-8?B?cWZYOTlsOUdZT0ZGMUFoWDdQL3d0UkgyOVNENVRUMDYreW1MQVJ3d2l4R2Vq?=
 =?utf-8?B?UEVyaUdpR2hVR3JhT00vSzNiOEFUVDZ5TzFROGZTVERPdHljY2FxUjBiUVhv?=
 =?utf-8?B?L2o1eWYrK003bU1qc09Qa3JLaXZyRTBPVXpudlhDRDVrcldmWnJLcVEzL255?=
 =?utf-8?B?SmJjMkQrZ0QzU25NQmQ0eG8reUVuUUtMSDZmTVBackFlOVM2dFlGb21aQ2Nl?=
 =?utf-8?B?VmE5MHVta3pjeDdQbkZMK05YdTVWc0NaSGhCSGxvVzVQYXp4TFB1Z1FPbk56?=
 =?utf-8?B?REtka2F0MTVkcUxudStPRC82NTVSaWoxK2d4c2YzVlVMb2NiaXowNWhYSVdI?=
 =?utf-8?B?N042ZWthWG9mS1lTN2d0dGNkNGx6Qm1oejJaOXllOEJOdTQ4dmptd0xUNjVt?=
 =?utf-8?B?bTkzYmsydWhqNkxTNjFhZGJPMFFOQmFFM01jUUozeEJmYmJsRWtyenRBbGZw?=
 =?utf-8?B?M2wvdlpRc3c4dnpFeDRHdXB6UDBUeGhOQnJKb3VuSGRHZWp6eW5xcXNVanhv?=
 =?utf-8?B?S2hnc3F5VHcrWU9QbTNVQ0k5cXJZbXF2eGx6K1ZBb1hOMGo3ditOcGpHaEh1?=
 =?utf-8?B?dHZheWpTVHhCbWF0OVJLdXJCelRKNzZuT3BtM0c1SjE3MHQ1d1RWMXVWcmtN?=
 =?utf-8?Q?V3iqKDPQLR6Bl4/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A43E128D9CE4DA46B0FD6B11CF479DA4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 330c9589-b5e6-47d9-77f5-08deb00345c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 08:48:43.4672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxkZvuWKFxli0YR8FSZ5Bt/JZKFALe+inFxNjzKamde6Y970XUm4iZl222DmldgSL4bpu7uHRDoQvuXjS7dPvD57zCeNI/pKEHlR00/SSv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8085
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

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjA5ICswMjAwLCBBbGV4YW5kZXIgRmVpbGtlIHdyb3Rl
Og0KPiBGcm9tOiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3Vw
LmNvbT4NCj4gDQo+IFN5bmMgZGVmaW5pdGlvbnMgZnJvbSB1cHN0cmVhbSBsaW51eCB2Ni4xOS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBGZWlsa2UgPGFsZXhhbmRlci5mZWlsa2VA
ZXcudHEtZ3JvdXAuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9ydGMvcGNm
ODUwNjMuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ydGMvcGNmODUwNjMuYyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gaW5kZXgg
MTgzYTIxNGEzZTkuLjA2Yzg1ZDkzOWUwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3J0Yy9wY2Y4
NTA2My5jDQo+ICsrKyBiL2RyaXZlcnMvcnRjL3BjZjg1MDYzLmMNCj4gQEAgLTExLDExICsxMSwz
MyBAQA0KPiDCoCNpbmNsdWRlIDxkbS9kZXZpY2VfY29tcGF0Lmg+DQo+IMKgDQo+IMKgI2RlZmlu
ZSBQQ0Y4NTA2M19SRUdfQ1RSTDEJCTB4MDAgLyogc3RhdHVzICovDQo+IC0jZGVmaW5lIFBDRjg1
MDYzX1JFR19DVFJMMV9TUgkJMHg1OA0KPiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQ1RSTDFfQ0FQ
X1NFTAlCSVQoMCkNCj4gKyNkZWZpbmUgUENGODUwNjNfUkVHX0NUUkwxX1NUT1AJCUJJVCg1KQ0K
PiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQ1RSTDFfRVhUX1RFU1QJQklUKDcpDQo+ICsjZGVmaW5l
IFBDRjg1MDYzX1JFR19DVFJMMV9TV1IJCTB4NTggLyogU29mdHdhcmUgcmVzZXQgY29tbWFuZCAq
Lw0KPiArDQo+ICsjZGVmaW5lIFBDRjg1MDYzX1JFR19DVFJMMgkJMHgwMQ0KPiArI2RlZmluZSBQ
Q0Y4NTA2M19DVFJMMl9BRgkJQklUKDYpDQo+ICsjZGVmaW5lIFBDRjg1MDYzX0NUUkwyX0FJRQkJ
QklUKDcpDQo+ICsNCj4gKyNkZWZpbmUgUENGODUwNjNfUkVHX09GRlNFVAkJMHgwMg0KPiArI2Rl
ZmluZSBQQ0Y4NTA2M19PRkZTRVRfU0lHTl9CSVQJNgkvKiAyJ3MgY29tcGxlbWVudCBzaWduIGJp
dCAqLw0KPiArI2RlZmluZSBQQ0Y4NTA2M19PRkZTRVRfTU9ERQkJQklUKDcpDQo+ICsjZGVmaW5l
IFBDRjg1MDYzX09GRlNFVF9TVEVQMAkJNDM0MA0KPiArI2RlZmluZSBQQ0Y4NTA2M19PRkZTRVRf
U1RFUDEJCTQwNjkNCj4gKw0KPiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQ0xLT19GX01BU0sJMHgw
NyAvKiBmcmVxdWVuY3kgbWFzayAqLw0KPiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQ0xLT19GXzMy
NzY4SFoJMHgwMA0KPiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQ0xLT19GX09GRgkJMHgwNw0KPiAr
DQo+ICsjZGVmaW5lIFBDRjg1MDYzX1JFR19SQU0JCTB4MDMNCj4gwqANCj4gwqAjZGVmaW5lIFBD
Rjg1MDYzX1JFR19TQwkJCTB4MDQgLyogZGF0ZXRpbWUgKi8NCj4gwqAjZGVmaW5lIFBDRjg1MDYz
X1JFR19TQ19PUwkJMHg4MA0KPiDCoA0KPiArI2RlZmluZSBQQ0Y4NTA2M19SRUdfQUxNX1MJCTB4
MGINCj4gKyNkZWZpbmUgUENGODUwNjNfQUVOCQkJQklUKDcpDQo+ICsNCj4gwqBzdGF0aWMgaW50
IHBjZjg1MDYzX2dldF90aW1lKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHN0cnVjdCBydGNfdGltZSAq
dG0pDQo+IMKgew0KPiDCoAl1OCByZWdzWzddOw0KPiBAQCAtNzQsNyArOTYsNyBAQCBzdGF0aWMg
aW50IHBjZjg1MDYzX3NldF90aW1lKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGNvbnN0IHN0cnVjdCBy
dGNfdGltZSAqdG0pDQo+IMKgDQo+IMKgc3RhdGljIGludCBwY2Y4NTA2M19yZXNldChzdHJ1Y3Qg
dWRldmljZSAqZGV2KQ0KPiDCoHsNCj4gLQlyZXR1cm4gZG1faTJjX3JlZ193cml0ZShkZXYsIFBD
Rjg1MDYzX1JFR19DVFJMMSwgUENGODUwNjNfUkVHX0NUUkwxX1NSKTsNCj4gKwlyZXR1cm4gZG1f
aTJjX3JlZ193cml0ZShkZXYsIFBDRjg1MDYzX1JFR19DVFJMMSwgUENGODUwNjNfUkVHX0NUUkwx
X1NXUik7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBpbnQgcGNmODUwNjNfcmVhZChzdHJ1Y3Qg
dWRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB1OCAqYnVmLA0KDQotLSANCkFsZXhh
bmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
