Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA80C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 18:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC7E87A00;
	Thu,  7 Mar 2024 19:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cinemo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=cinemo0.onmicrosoft.com header.i=@cinemo0.onmicrosoft.com header.b="XfPR8MSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4008787D66; Thu,  7 Mar 2024 18:43:11 +0100 (CET)
Received: from DEU01-BE0-obe.outbound.protection.outlook.com
 (mail-be0deu01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2622::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F068752B
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cinemo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vjaiswal@cinemo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE42KV3HZVBoGcbTUiS/ighH2lYny/8yTnrhAxbT9moFypUEo5iqPo/bQfK6MDRkFIUGZ73sNeZ1p5reWsPj6fc6vJfOw7uQFGbb9gfVGxmvHiPmVvRz1yP+FvEQkUIuWpi9x8nURD/Qg4X3FekKJaZJ5JCa2F6ygQvPCfeCj+K/UiF7EiUPZaKjzX4cEJs3aYI6R/wIp+MuKbDIWt1KiSElxaWGJGYwLy97ENPYkTC6FFV3BEr1k7zZdUR3uqOCq8TbbQb87iDXijn0XHhEIScDXnssf62Ks/B8aF76d1dDsYj3cOx4oUngqU2zwkJxl7s/5F/Grp0et0JdYaRecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M07AEx3nH+Dtja7Ilta2su6TdQz7CPKxLE95V55nHck=;
 b=PCyYA7FqLfO4fUUnGC7wenMfLmYl4OtoX2/0+4FJtT0TC7JMARmNHbAtRkOEkz2f5VWC6w6GbxidXfTsBr+3s2eN3N634A7XP95jQBAMUZTmnMdEsTpDoyNCa+1jBJr1P1isomBgj52n0KiBYG4h/f+4Fq7os1+fDnydT8EuYwlD/cRyIs7P8jLlLbewrAhxXY+7yxTQ916O+BazkWp4lw4egCQ6ue+jxn1oHIlFCv+AMpcNXEfEAFuJugmQGPdoGyaJCT9ktwpecCTso/drxC8+t4NeVkoPCQyO96DjBxAVUCrc9cwMStcns4pDxeWk2Q7DCtDU9s6J399LQ5hP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cinemo.com; dmarc=pass action=none header.from=cinemo.com;
 dkim=pass header.d=cinemo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cinemo0.onmicrosoft.com; s=selector1-cinemo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M07AEx3nH+Dtja7Ilta2su6TdQz7CPKxLE95V55nHck=;
 b=XfPR8MSNC7fc0r5i04bIhGcETan9rVvARKGGI1dJj0A2DKUxfMbRqshMU70TDmUTQAIJzJeRuVwQNCBtLTzrmXIlWddyTs9ySNvrKXNbUuGASbfF6cneS4qLlzqDDOE3E9dTM7P+1KR+W7swD4x1d/ZyLtVN3wtDgctiGWjm6RE=
Received: from FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:72::10)
 by FR4P281MB3726.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40; Thu, 7 Mar
 2024 17:43:06 +0000
Received: from FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ccb0:ff57:7c4e:e944]) by FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ccb0:ff57:7c4e:e944%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:43:06 +0000
From: Vivek Jaiswal <vjaiswal@cinemo.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: U-boot fails for khadas-edge -v
Thread-Topic: U-boot fails for khadas-edge -v
Thread-Index: AQHacIAKth58IDIIyk62Zj6csqiUFbEsf/6AgAAMMQ4=
Date: Thu, 7 Mar 2024 17:43:06 +0000
Message-ID: <FRYP281MB2969D2ABC5FF3EB2421E95E8AB202@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
References: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
 <CAOMZO5BhEmnVsmYdJgabZC1L6GrNc4WvMhRZNrFhemTvD3rpzQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BhEmnVsmYdJgabZC1L6GrNc4WvMhRZNrFhemTvD3rpzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cinemo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2969:EE_|FR4P281MB3726:EE_
x-ms-office365-filtering-correlation-id: f2d752d4-5159-4e41-4059-08dc3ece0bfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3rEkLcvKeEHBuPGE+2ljw5rNM4MVJMlcVblADCQ5kRy/QSGzmT6D5g+zr2FUlcG32xiIQAQKjqQR+I+MA1CV27z5i9QrPnovcbW2O/cNK/NAA95V3qn7CJTbzvx6NyzNO/PU1/tAcpmEY1P5XvEAtSHYXfqQfgH8KWMMNfU5BS8qq/4qnh0tLI/qb3uO0oZeNEVM8QRVRTTxgIyrw6yBOJUuwlVQ3ZIAejJQEtWFY0DGJhrFOD1hP7AgcdoC6RczISecPDnLzaMsMjbKPT4IsQXL1arNc4aRtgupgbm9ShhTh0DX3llOnTWJKZgk5rLs8FER7nDx52ja8478ldrISUrkGpZnuJVJKzNTPMI4aelL5lxXJeJ19M7jBPjWDbVlCMow5s4khcAustww3d8mSUu0XQJxOIulLuoW2xfs1F4xDh4zRJ/WjNitv6Y3eiZOxOKBjzI0v9jMyw7/6Vv3CVngFJgKHFXg5brToyHCABT/GAgyXvFxO1UaGuBadqez4YDXsippXZgTLBWdi+E0SQWANVKGRJN5ol3neY9DGaY4K5A9pxFJnOgvQAmpjKSQs/oV6IB4SajBIWM7FRVGYBeFPR+2wPpOAcY1eF6IRmgrz9cKFaTRP6G4XGf8vHipuoeLzxAQ5BpEgTdWrwlTtq9Xmo5CKT2IkyMR8CZqNuOScsCeo1myg+Zn4ZJe3f3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlhZitrc0dHMTJXL1hRWWpJekxJMTUwQ0dLV0MyRGxqREwydHNsZEZiNjhS?=
 =?utf-8?B?bGw5T0J0Q2FyTC82R0lKdmI2TERVMHR5MmZGclBtdnRjdVhsZTlySG5MY2hw?=
 =?utf-8?B?QUp4NEpndk5VN2d1dnN4cVhHbDRMYkdwS0EwZ2JxT3dMTjVDbjdQWlp5Q1lo?=
 =?utf-8?B?cWRvOGtYeWNGNmVucWV3N1NFZDV5cDlIY2lmNFpxc29QczdyYi9MOXNBMTdK?=
 =?utf-8?B?MDM2d3FTb1M1OG1KNjNkc2lBcDhDVWhWckl5blFXTEdBdVhFZ1l1Q3g4TTVj?=
 =?utf-8?B?WWllTjdmNE45d2QyOUpOMFJmS1I0cGJjR3JpTDM3UVh1dG1nQmhnZlFMeFZu?=
 =?utf-8?B?SmNjaWwyQ01zdzE3VzBOWStxc2g1azdTaUJ5Tk1GZjZpRGRER2lHSHN0cWNH?=
 =?utf-8?B?cUxyY2VHNnVrRzVZN3Zmak9xbzlrYkY1Rkx1dUNpeVZyMVV5N0hsNVRYT2FO?=
 =?utf-8?B?d0QwUFU4d3c2NGhmcU9ITXZ1VGFVTm9IRlg5Q0hEUzBRV0Y3a3RsYUVVRitC?=
 =?utf-8?B?N1NwYTRKdXNkSGNMcnh3V3ZLY08wTWNuREZYSEY4VldFTlBxbVNNeURpNVFs?=
 =?utf-8?B?d0g3RjROS0ZkczFmUlFXMjV3MVNDZWYrMEtRMDh4b0Y1VDhPY2hVbGFmd1My?=
 =?utf-8?B?aE1haTlrTnE1TENldit3T0MvbFpUR0RwT2t2NDhIWWtQellHQWFmUUppRThV?=
 =?utf-8?B?THdONmxoOUVxa2xtWFFGRENHT2N0REFPMHVDNGkrMlAxQk5hMGYwMGE2d21n?=
 =?utf-8?B?VHNkSkRITldlY2hjVVUwRHBxUlVwcFpOS25JQ2JUU0trcHlVcmJuN1N3YWRW?=
 =?utf-8?B?WkxPbmxnbG1ydlNUd2VGM0tXQTd2V2Nsc1BzOFRFTzU2MUhCOURGWnIzWnB2?=
 =?utf-8?B?MmQ1akdabFpYdk85N3VyMGtFekgzTUpKNWxuT0tXcEs4TXFIT09Fb3ZSN2F5?=
 =?utf-8?B?SU5RNmVVYmVZMk9QNC96Wm5jNnRybXBqLy9iNkczSEcrN0FUMG5NTlIwWGk0?=
 =?utf-8?B?MjArdnVENlhYLzJQa211RkpqU0tXcE1zdVJUWDYvUW1zRlU5QU5STkxqaGFI?=
 =?utf-8?B?ZnBBekhUV2UrblVOZDlzR3BraWlMNE85alpUQWI1TWxjdG1yK0Fzbjhzc0xj?=
 =?utf-8?B?RGJkZGM2Z3ZKNllSNk5QdWMrTFZYamcyM21LRUdrekVnSHBiaEp3bmNMdk9T?=
 =?utf-8?B?cUJ6S1cxcG83N3A5UndKTTBTUURCUTBKbDNya2JnMDNodkRXVmJYWTMrMDZJ?=
 =?utf-8?B?TWlJdzYrZDVza3l6WG9RTjlPdmJnOWhTWHF6eVJJNXVqQUVsSk4xckpxaG4v?=
 =?utf-8?B?U3hlczFCVVBlcDk2VXltbjFIWURYbGljNVArcUZnbU50RjVVeG9PNFZ5WGw5?=
 =?utf-8?B?alZUbkFQNy9nVkJ1V0loMG42MktscHBrazhsY2RCaS9NVkJKdGNXdlhaRTQy?=
 =?utf-8?B?R09IMktXRGRsWFJiNTRyU0ZVbzJSV2c0Y3h5TFJqL3JMS3MxUlBmMlFvNW1y?=
 =?utf-8?B?cE1FNTcrcUdYTlEzSC9KdGJKOWtCdVc2aFVwSzl3YWpiYlhYblorZVh6MmNT?=
 =?utf-8?B?cnRFVTZRbE1FU3MwaGRVMEhpTW5iWDRJNWt2OE1yMW9kN1U5WXpNTHFCQnlr?=
 =?utf-8?B?aG9LanAxYTFURFhrMERjTThzMmpiNnRPTjJkMEx1Zkl4RjZGWlZRRHJlbDRJ?=
 =?utf-8?B?V2JVUUZleVhsMjBRVUh6WXg3MWFoZVRhcjcyTkplb3Q4OStkL0xnVWV1VWx4?=
 =?utf-8?B?dVova3A3bUxBd1I5ZWFZbkJwUm45aXE1RmV2TENOZ2hnSDUzNjg3NGlSVGhp?=
 =?utf-8?B?VWY1UmxzTHZBUVc3R1Bma041ell2QU1PL3Y3Z1NFSExzcVJiY1I1ZWQwdWZx?=
 =?utf-8?B?QlEyb3ZJWDFEb0RuV3RjRStyL2RWeUphZ2dDWTN3aG1BcWRRRS85STd2UVBE?=
 =?utf-8?B?b0orNDV4NHZWQ3pLa3dGQU1HRUhKYVFTSE9BL3NZY2F1R3lkcjloTXZicG12?=
 =?utf-8?B?UFlqeEVocTRsdEdvREpkdTMrREE1bHA2SGtzaUtzRVhRUjFYN2V5citQR2sv?=
 =?utf-8?B?cGwzMUtaMkMzR0RTWnhzTWRkQ0YwZW53bjVvRUhmUnFnWEFJcXkrdTV3Wmxk?=
 =?utf-8?Q?9UFg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: cinemo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d752d4-5159-4e41-4059-08dc3ece0bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:43:06.4382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f67d7a5-8d31-49e4-bdef-c6169c4e9474
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 681SDGacES4xTxKOd8x9bUsfepE2NGE0p4d+kOAbDnLYlaw/NhiPE+Nb5vNGyA5EXLwwseZphYMW0qDlXhh/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3726
X-Mailman-Approved-At: Thu, 07 Mar 2024 19:12:02 +0100
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

SGVsbG8gRmFiaW8sDQpUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGUgbWF0dGVyLg0KDQpDYW4g
eW91IHBsZWFzZSBzZW5kIG1lIHRoZSBsaW5rIG9mIHRoZSBraGFkYXMtZWRnZS12LXJrMzM5OV9k
ZWZjb25maWcgaW4gbWFpbiBsaW5lLg0KSSBhbSBub3QgYmVlbiBhYmxlIHRvIGZpbmQgYW55ICBt
YWlubGluZSBicmFuY2ggaW4gaHR0cHM6Ly9naXRodWIuY29tL2toYWRhcy91LWJvb3QNCg0KYXJl
IHlvdSBzYXlpbmcgdG8gdXNlIHRoaXMgb25lPw0KaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91
LWJvb3QvYmxvYi9tYXN0ZXIvY29uZmlncy9raGFkYXMtZWRnZS12LXJrMzM5OV9kZWZjb25maWcN
Cg0KQmVzdCBSZWdhcmRzLA0KVml2ZWsgSmFpc3dhbA0KDQoNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCkZyb206IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4N
ClNlbnQ6IFRodXJzZGF5LCBNYXJjaCA3LCAyMDI0IDU6NTcgUE0NClRvOiBWaXZlayBKYWlzd2Fs
IDx2amFpc3dhbEBjaW5lbW8uY29tPg0KQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RA
bGlzdHMuZGVueC5kZT4NClN1YmplY3Q6IFJlOiBVLWJvb3QgZmFpbHMgZm9yIGtoYWRhcy1lZGdl
IC12DQoNCltZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gZmVzdGV2YW1AZ21haWwuY29t
LiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KSGkgVml2ZWssDQoNCk9uIFRodSwgTWFyIDcsIDIw
MjQgYXQgMTE6NTbigK9BTSBWaXZlayBKYWlzd2FsIDx2amFpc3dhbEBjaW5lbW8uY29tPiB3cm90
ZToNCj4NCj4gSGVsbG8gVS1ib290IFRlYW0sDQo+IEkgYW0gdXNpbmcgdGhlIHUtYm9vdCBmb3Ig
S2hhZGFzIEVkZ2UtdiByazMzOTkgcm9ja2NoaXA6ICBodHRwczovL2dpdGh1Yi5jb20va2hhZGFz
L3UtYm9vdC90cmVlL2toYWRhcy1lZGdlcy12MjAxNy4wOS1yZWxlYXNlLXYxLjAuMD90YWI9cmVh
ZG1lLW92LWZpbGUNCj4gQW5kIEkgYW0gdXNpbmcgY29uZmlndXJhdGlvbiBmaWxlIDogaHR0cHM6
Ly9naXRodWIuY29tL2toYWRhcy91LWJvb3QvYmxvYi9raGFkYXMtZWRnZXMtdjIwMTcuMDktcmVs
ZWFzZS12MS4wLjAvY29uZmlncy9yazMzOTlfZGVmY29uZmlnDQoNClRoYXQncyBhbiBvbGQgb3V0
LW9mLXRyZWUgcmVwb3NpdG9yeSwgbm90IHN1cHBvcnRlZCBieSB0aGUgVS1Cb290IGNvbW11bml0
eS4NCg0KVHJ5IGtoYWRhcy1lZGdlLXYtcmszMzk5X2RlZmNvbmZpZyB3aGljaCBpcyBzdXBwb3J0
ZWQgaW4gbWFpbmxpbmUgVS1Cb290Lg0K
