Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7DEFF60CE
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 06:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6436883DA7;
	Tue, 31 Mar 2026 08:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="kw5DKfbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C1783DBF; Tue, 31 Mar 2026 08:29:26 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE4583A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg9MrtyszVnaiwGwo86L/HBVLE5Ri6hIF4513aKkXvKSZxLC5XD+1I+3fXiRlc/5lsT/8uJ99DNRaocuVPQxFg5pWXMpURgRHXvODztsjPkwZFRs4InC/KeY9abNvRoUlmI6Gvres3v/JcPhpw1TBBoHkxyhnRZVS1osrkAZDG01r7K50ZpLdvfHiKQyg5EKcdgF7O5NAiMGMUCjtGtTC3OB4nakbw8asFPtot9+r5EoCSiMxLo6ZabyfXDGI4uGoS+Z9rbqcDKblG+FbEgvgSpgWCumD2iMHv2pV/qaLCWKdKmgUflWuVkrdSE+B2BIgoVFl914yRu3HI+oYoqEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA1DBrCSgbekWrMrrxZTQ12Qmfj/Qbt32XiL750KHdI=;
 b=rlqvvDmMFzDUwcMUat1/u9KpvhjE8kN5+rSPVpLzPUK+4y88j6EbYCFfNg6gWOmxV0qLrAD8xWT/1vouKXbm2dccbbNliqI9tbq7Jh6exiDVOhtM6nnTHXpMy4ZbB749ryMqByw1apV2/rh0J/adICvZrCsS/kJWVV/YebrgWi61FIw7UjZKFA/ye2LYlhcRDMIIjkdekaXn3mLyQvJfN6T2I/Yetm0NBWbUwyqfk3hUv1ckfuvPLcRDYgylpYNlZR+anJdx6+1IYAZWmarRzRQ+yghyC/CBGNXYl3xysczAgd5exTvU+U3D3rYs6SQ4erEwcCUVSr8UbTDlk0qR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA1DBrCSgbekWrMrrxZTQ12Qmfj/Qbt32XiL750KHdI=;
 b=kw5DKfbkQ0uU7G5jIX88vdA7VIQsuHS/4LVeodi7vLxeyEYIbfXWoDH5uUtc9xAePuHcEMl4EcRsYp2sFFpMWKi2OC5ESMsZcXTgS4JYsw2Sx5a/NQ2AYXxER2N+zoy/v2XYPsvhB4wSP+qPwXx4fKFu+8iq0+kGfGVCZMBZdOFVjs0r/tos5Q7JMCZEjMSHg5YaNJ6JPX5vLZuMKPXrCriuCuKsSpdg6lacVK7OSQinBC7/9CcrCD30cJewCJyNvQ9fG5akzrvtVPyck+4OsHPUzAjahNVFdxBLf2RlMX9MniY77u3LrghxiA4zIfEGYHIu3Q6bb/jvoNzqJYL++A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:611::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:29:21 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 06:29:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "ngotra27101996@gmail.com"
 <ngotra27101996@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "casey.connolly@linaro.org"
 <casey.connolly@linaro.org>, "S4210155@student.rmit.edu.au"
 <S4210155@student.rmit.edu.au>
Subject: Re: [PATCH v2] common: cli_hush: fix console_buffer overflow on boot
 retry
Thread-Topic: [PATCH v2] common: cli_hush: fix console_buffer overflow on boot
 retry
Thread-Index: AQHcwL4MyJZnxU2LrEWkDaHE8WYRubXILe0A
Date: Tue, 31 Mar 2026 06:29:21 +0000
Message-ID: <dfc913a900fea2f7525479f71dff89a78c4259ca.camel@siemens.com>
References: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
In-Reply-To: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7085:EE_
x-ms-office365-filtering-correlation-id: cd8b20eb-7f10-45e6-3a89-08de8eeed840
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|10062099007|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: MCzXf+AGiOm3NBpLZWPuZ7EbvlqYfVPh+KITQwhnDap7oNBsc4PAF6ZJ47rERmhpuoTBeg9QUfU21YVs6u4HFFjJRBw51IHAVevAX0QU6SoLTsMPOdiU4b9il6jHUlgzEfaDCDV1e+9AQX/zkSAXYLGedXbWbDHiSue1uy4gPCx3odJI6dwRpsgBO9yZlzuo08qEZ5K7opbxvTDaHvHDcInMW2/ff1V742bbqA7Hy44ScSxUlWYvtjsE5KrXyYrlSaWoL5lrHyewiJz3QgMZuVN1dNdj13iVteA2YcvBPystv/l5KsyClvNq+7KZiZsTlPBlxWJvyZsHyKQKau96IWXja1jhHM3fQm41DxtvltSVjj/GXJNTDWMAtRdLEkuZ9Y44z7fM0Czrn3brR+0T0+GQHvAJT2gvggZrF3sv0q3EybTiAFJ9PHsjLH8rs/ID4xmSx9dPAXsj5uYq8FmQlVsszcBZmBP60Qaf01xbcxXujhmhI5uXLg/fiGJdRjqeDdxhgSNz+t+ikNEBe5GL6R/omREV68mEPoUwxSPFDBtUheAU+mwC311xpqZvj3qsscmPQYJ5HYxCqFbwDOXXz/SylchEMnCOlTFKJun79qKOZBALy498b2wxhUzuq0P8te+RcBeNQ6AjuX3LFsJ4WIm1hZoDtd4M9QHrm/jcPQ3C6AaJhE8YwWmFjC/Q+NIiSYA2VV/hmvBpWnKVHIkUK5Ii+Iw9ihCfE0wme+Y9qFE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(10062099007)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnpHdG95Q2xGaWtaSGtCZkVqODI2WngxMEl2T1pjaTRnOVZheGJJUm45cWRK?=
 =?utf-8?B?U0pRbE1XUVczK1pZWWNRSDU4Ukh1QTZITnp1L0RKMWg0QXhIbkNWeUFHNkJC?=
 =?utf-8?B?djVubG5rcWowZDRQYURGSHFGQjdqVWpKOGViMnQ2MGM5d01hUjhORXhqakZ1?=
 =?utf-8?B?dDZVUXNqMmFWdXZyK3FNWU1UdkhIc0tLK2JuZUg5T3JVWCtkL2lObDNTbmpn?=
 =?utf-8?B?QzlxR0RwMUlIdEs1M0syazdjS2RQMFFHVktIa0ZxVzhUQTBWT3M0WVZTUGtr?=
 =?utf-8?B?RzlnWkZjMXcxb2lXQktYWk54Sm12MzNlMjk0UzRlWXRVM0dzVzhOU3lnWFQ2?=
 =?utf-8?B?UVhDOUQyL0syakM5NERzTVY5KzF5ckNubDFpc1RiZTArVi9qaTVsRXRINWFE?=
 =?utf-8?B?dFM4QmZDWkhpcHpmR20rQndyRFlCQjU1V3VyZXlaRHp3Yi93cFlrdVNOdDNy?=
 =?utf-8?B?SWFZcVNqeU0rMExIMU5xcEI2a1RiMEVUaC94RGRyOXVPaGNjeXJjaVozRTdC?=
 =?utf-8?B?ZUlwSjFwZ1U2YjgwdldMbVdUd2toeHBKVm5XTVlhUkhxYStseGRFVFpFU0la?=
 =?utf-8?B?dzBsUEpnTlZOQmt5ek5YWU1tWXp0OE8rR1l1dGRhTnpTTW5SRlhzWDhLa29i?=
 =?utf-8?B?ZVlEV2xpYWQ1TVNVOXpaNFRRY045d2x3N3NWYWo4dDBOSTBsK2s3RFdHZk5t?=
 =?utf-8?B?MlY5RjZnTnVSZ1I0OE5SM091UjhmRWVzYlExbkVyNVRUU2xEbFZ0V2NXaFM2?=
 =?utf-8?B?bUxvTi9SU3h4TExHL0NWeTc1N05LMXNDSExWS2FGeWk1SnpCK3h3S2MrODgz?=
 =?utf-8?B?dnR6VHg3VDhVckV1RUwrRmtqUDNUTUE4cm9sbm1tL29NWkxwb2ZYYTFrczJs?=
 =?utf-8?B?TFJwc3ZnUEFzK3pYS201TzVOMEZRMHBpay9hMksyK2xFZ3gvZjNDQXJuSklk?=
 =?utf-8?B?bE1UOVNHd293Q1JvYUU1QnN2MXZqcUdMWWZrOS9Uc1hnUUF1Sngxc2crSmNB?=
 =?utf-8?B?UG1CS1J6ZStKY09yRENkTTB5L2kxZlVvL3Z2UENjQXA2RjFmcE5WdVNXTnFl?=
 =?utf-8?B?cmhpRkY5YytmNlI4L2ZBeFpyRDQ5MTU1T1FsWjhTMWNWOFBFVWZRS2wxc0xx?=
 =?utf-8?B?YUJpSzRjQzdMRnhrMkVRWVlHMmJIcHo4bTNNYWJyZ2M1RkFjRFFuNER0MVpl?=
 =?utf-8?B?b3g4OFpQbk5FN0YybG5OQjdyenlTeHAzVlJKdWxFeFg5R2YxeTNvM1ExS0g1?=
 =?utf-8?B?VUd1aU1KMWs3b1h6dHpNK3gwQ0hiODNQN3ZNc29kNGp5MTRXZ214TXFtby9F?=
 =?utf-8?B?S01HZXRpNFVvUk1EMWdMdHZSUGtmS0UvWE9oM0g5RmY2RlY0NFhQb3Z0VEVu?=
 =?utf-8?B?b2Q0M3Y0ZXBPY2lnclV0dC9pV3hYNFBralUwUVdTNGhEMHRkQWluKzJlRTVY?=
 =?utf-8?B?K2s4My9JVURtaDdVYjF3dCtJZjNiaHdoc01vZ1E3RVdURWp3Q1RZcFg4bGhz?=
 =?utf-8?B?YVlVdzZ4b2FKblA3WnNzZ3RaeGRCYnRndExnUi81cjZraERrQUxiUUxmRGRi?=
 =?utf-8?B?NDRWSWtCOVppSDNrUUprT1BWV0ZsMkYvZzhOYjlCREQ4Y2pSMS9HVlJralN6?=
 =?utf-8?B?NHpKWTl3RTNuN3dJYVlhSXRJME1LeWE0NmE2eTFjY1NkTW9ZZVpYZUhtS0Vk?=
 =?utf-8?B?UWsvdGNuZVBhSHFJU1p0MkQwdXBjb0VSbzArbzd5NGRhNUNHcU1vUzQ4Y2Jk?=
 =?utf-8?B?YTVqZnJkcmlzZUNIVWR3Q1RMMWcvWHI3OGdEMUdPS3BjZlhvQzVPWHFjSEZI?=
 =?utf-8?B?a0phaHVFSDVIdURtVElNU2FIdXZ6WE9TVVJmSkk0dkVSVW9IcHU2RXBqTG5Y?=
 =?utf-8?B?a05wRTJ2akNjeWQ4QmtZTXVIWG5XOW5wMXVSTnQ5Y0VOc0dBVDdVT3k2azhr?=
 =?utf-8?B?aHkrMFQxSUhVbEc0eDg3NzlyVGVrY1RlUXpaaFl1TUtneDVjZ0ZWejhQRzZs?=
 =?utf-8?B?TmFWbG12dVlXcjJML0ZrNDJjK1ptNUQ2SHE5NEwyZW5TNmJlU1FjbWszUHl5?=
 =?utf-8?B?eUxUNEgxeEFTRTZWYUpVanZqTlE3NkVJNDVwU0EycmJNQ3BWcG9jNXZrazJi?=
 =?utf-8?B?M0FBM3JubnBQdG43Tmcra20rUWFWWXBjeUdJYzZYSGUzaURzMGVrYzRPWnhx?=
 =?utf-8?B?UVppUHpsNVZoNVl1Q3pmbzU0WVVHcnNCOGVDMUJIYWxMMmJaSk1nd0NBdXdQ?=
 =?utf-8?B?U2oxbHljK3BZUlM3QXVsclNjRVV2eHpCNlAxSzNueXQvZXNZaXhBK2lRbTZZ?=
 =?utf-8?B?OGRRZDd4UWxiQ0hyV1dsYmxKZUhUdldScVY2ZU5qUUluLzFlNWsyZTlpWkls?=
 =?utf-8?Q?R/Hi4CGK96WZQBx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F1681A16EE554A87F7CA42869DB150@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b20eb-7f10-45e6-3a89-08de8eeed840
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:29:21.4078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb2Is/M+dBHMNEISNhD5iFzPerhTEqDHGhgbt1L9tDCLMl8N469WM+lqnFIhILIs4DHOyVYgtwlxxJpkWXf7wDP5vKwwMCa+LU9jPsU6Feg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7085
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

SGkgTmdvLA0KDQp0aGFua3MgZm9yIHRoZSBwYXRjaCENCg0KT24gVHVlLCAyMDI2LTAzLTMxIGF0
IDEwOjI1ICswNzAwLCBOZ28gTHVvbmcgVGhhbmggVHJhIHdyb3RlOg0KPiBBZGQgY29uc3Rfc3Ry
Y3B5KCkgbWFjcm8gdG8gPGxpbnV4L2J1aWxkX2J1Zy5oPiB0aGF0IGVuZm9yY2VzIGF0DQo+IGNv
bXBpbGUgdGltZSB0aGF0IHRoZSBkZXN0aW5hdGlvbiBpcyBhIGNoYXIgYXJyYXkgKG5vdCBhIHBv
aW50ZXIpLA0KPiB0aGUgc291cmNlIGlzIGEgc3RyaW5nIGxpdGVyYWwsIGFuZCB0aGUgc291cmNl
IGZpdHMgaW4gdGhlDQo+IGRlc3RpbmF0aW9uIGluY2x1ZGluZyB0aGUgTlVMIHRlcm1pbmF0b3Iu
IEl0IHVzZXMgX19idWlsdGluX3N0cmNweSgpDQo+IHNvIHRoZSBjb21waWxlciBjYW4gb3B0aW1p
emUgdGhlIGNvcHkuDQo+IA0KPiBGaXggdGhlIGNvbnNvbGVfYnVmZmVyIGV4dGVybiBkZWNsYXJh
dGlvbiBpbiA8Y29uc29sZS5oPiB0byBpbmNsdWRlDQo+IHRoZSBhcnJheSBzaXplIHNvIHRoYXQg
c2l6ZW9mKGNvbnNvbGVfYnVmZmVyKSBpcyB2YWxpZCBhdCBjYWxsIHNpdGVzLg0KPiANCj4gUmVw
bGFjZSB0aGUgdW5ib3VuZGVkIHN0cmNweSgpIGluIGNsaV9odXNoLmMgd2l0aCBjb25zdF9zdHJj
cHkoKSB0bw0KPiBjYXRjaCBhdCBjb21waWxlIHRpbWUgYW55IGNvbmZpZ3VyYXRpb24gd2hlcmUg
Q09ORklHX1NZU19DQlNJWkUgaXMNCj4gc21hbGxlciB0aGFuIHRoZSBib290IHJldHJ5IGNvbW1h
bmQgc3RyaW5nLg0KPiANCj4gRml4ZXM6IDY1N2UxOWY4ZjJkZCAoImNsaV9odXNoOiBzdXBwb3J0
IHJ1bm5pbmcgYm9vdGNtZCBvbiBib290IHJldHJ5IikNCj4gU2lnbmVkLW9mZi1ieTogTmdvIEx1
b25nIFRoYW5oIFRyYSA8UzQyMTAxNTVAc3R1ZGVudC5ybWl0LmVkdS5hdT4NCj4gVG86IHUtYm9v
dEBsaXN0cy5kZW54LmRlDQoNClRoZSBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCB0byBtZSBhbmQg
eW91IGNhbiBhZGQgbXkNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRl
ci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KVGhlcmUgaXMgYSBzbWFsbCBpc3N1ZSB3aXRoIGhl
YWRlcnMgYW5kIHRhZ3MsIG1heWJlDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xh
dGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sDQpjb3VsZCBoZWxwIGhlcmUsIHBs
ZWFzZSByZWZlciB0byBvcHRpb25hbCAiRnJvbToiIHRhZywgd2hpY2ggd291bGQgYWxsb3cNCnlv
dSB0byBhdm9pZCB0aGUgZm9sbG93aW5nIGNoZWNrcGF0Y2gucGwgd2FybmluZyBtYWludGFpbmVy
cyB3b3VsZCBnZXQ6DQoNCldBUk5JTkc6IEZyb206L1NpZ25lZC1vZmYtYnk6IGVtYWlsIGFkZHJl
c3MgbWlzbWF0Y2g6ICdGcm9tOiBOZ28gTHVvbmcgVGhhbmggVHJhIDxuZ290cmEyNzEwMTk5NkBn
bWFpbC5jb20+JyAhPSAnU2lnbmVkLW9mZi1ieTogTmdvIEx1b25nIFRoYW5oIFRyYSA8UzQyMTAx
NTVAc3R1ZGVudC5ybWl0LmVkdS5hdT4nDQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIFJlcGxhY2Ugc3RybGNweSgpICsgQlVJTERfQlVHX09OIGFwcHJvYWNoIHdpdGggYSBuZXcg
Y29uc3Rfc3RyY3B5KCkNCj4gICBtYWNybyB0aGF0IGVuZm9yY2VzIGNvbXBpbGUtdGltZSBzYWZl
dHkgZm9yIHN0cmluZyBsaXRlcmFsIGNvcGllcw0KPiAtIEZpeCBjb25zb2xlX2J1ZmZlciBleHRl
cm4gZGVjbGFyYXRpb24gaW4gPGNvbnNvbGUuaD4gdG8gaW5jbHVkZQ0KPiAgIGFycmF5IHNpemUg
c28gc2l6ZW9mKGNvbnNvbGVfYnVmZmVyKSBpcyB2YWxpZCBhdCBjYWxsIHNpdGVzDQo+IC0gQWRk
cmVzcyByZXZpZXcgZnJvbSBSYXNtdXMgVmlsbGVtb2VzDQo+IA0KPiAgY29tbW9uL2NsaV9odXNo
LmMgICAgICAgICB8ICAzICsrLQ0KPiAgaW5jbHVkZS9jb25zb2xlLmggICAgICAgICB8ICAzICsr
LQ0KPiAgaW5jbHVkZS9saW51eC9idWlsZF9idWcuaCB8IDIzICsrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29tbW9uL2NsaV9odXNoLmMgYi9jb21tb24vY2xpX2h1c2gu
Yw0KPiBpbmRleCA3YmQ2OTQzZDNlZC4uMDQ4NTc3Y2I0MGEgMTAwNjQ0DQo+IC0tLSBhL2NvbW1v
bi9jbGlfaHVzaC5jDQo+ICsrKyBiL2NvbW1vbi9jbGlfaHVzaC5jDQo+IEBAIC04NCw2ICs4NCw3
IEBADQo+ICAjaW5jbHVkZSA8Y2xpX2h1c2guaD4NCj4gICNpbmNsdWRlIDxjb21tYW5kLmg+ICAg
ICAgICAvKiBmaW5kX2NtZCAqLw0KPiAgI2luY2x1ZGUgPGFzbS9nbG9iYWxfZGF0YS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2J1aWxkX2J1Zy5oPg0KPiAgI2VuZGlmDQo+ICAjaWZuZGVmIF9fVV9C
T09UX18NCj4gICNpbmNsdWRlIDxjdHlwZS5oPiAgICAgLyogaXNhbHBoYSwgaXNkaWdpdCAqLw0K
PiBAQCAtMTAyOSw3ICsxMDMwLDcgQEAgc3RhdGljIHZvaWQgZ2V0X3VzZXJfaW5wdXQoc3RydWN0
IGluX3N0ciAqaSkNCj4gICMgIGlmZGVmIENPTkZJR19SRVNFVF9UT19SRVRSWQ0KPiAgCSAgZG9f
cmVzZXQoTlVMTCwgMCwgMCwgTlVMTCk7DQo+ICAjICBlbGlmIElTX0VOQUJMRUQoQ09ORklHX1JF
VFJZX0JPT1RDTUQpDQo+IC0Jc3RyY3B5KGNvbnNvbGVfYnVmZmVyLCAicnVuIGJvb3RjbWRcbiIp
Ow0KPiArCWNvbnN0X3N0cmNweShjb25zb2xlX2J1ZmZlciwgInJ1biBib290Y21kXG4iKTsNCj4g
ICMgZWxzZQ0KPiAgIwllcnJvciAiVGhpcyBvbmx5IHdvcmtzIHdpdGggQ09ORklHX1JFU0VUX1RP
X1JFVFJZIG9yIENPTkZJR19CT09UX1JFVFJZX0NPTU1BTkQgZW5hYmxlZCINCj4gICMgIGVuZGlm
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbnNvbGUuaCBiL2luY2x1ZGUvY29uc29sZS5oDQo+
IGluZGV4IDhkMGQ3YmI4YTRjLi45N2NjZjVlNWY2YSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9j
b25zb2xlLmgNCj4gKysrIGIvaW5jbHVkZS9jb25zb2xlLmgNCj4gQEAgLTEwLDggKzEwLDkgQEAN
Cj4gICNpbmNsdWRlIDxzdGRib29sLmg+DQo+ICAjaW5jbHVkZSA8c3RkaW9fZGV2Lmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvZXJybm8uaD4NCj4gKyNpbmNsdWRlIDxjb25maWcuaD4NCj4gIA0KPiAt
ZXh0ZXJuIGNoYXIgY29uc29sZV9idWZmZXJbXTsNCj4gK2V4dGVybiBjaGFyIGNvbnNvbGVfYnVm
ZmVyW0NPTkZJR19TWVNfQ0JTSVpFICsgMV07DQo+ICANCj4gIC8qIGNvbW1vbi9jb25zb2xlLmMg
Ki8NCj4gIGludCBjb25zb2xlX2luaXRfZih2b2lkKTsJLyogQmVmb3JlIHJlbG9jYXRpb247IHVz
ZXMgdGhlIHNlcmlhbCAgc3R1ZmYgKi8NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnVp
bGRfYnVnLmggYi9pbmNsdWRlL2xpbnV4L2J1aWxkX2J1Zy5oDQo+IGluZGV4IDIwYzJkYzdmNGJk
Li5kNzc1YmYxYmY5MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9idWlsZF9idWcuaA0K
PiArKysgYi9pbmNsdWRlL2xpbnV4L2J1aWxkX2J1Zy5oDQo+IEBAIC03Niw0ICs3NiwyNyBAQA0K
PiAgI2RlZmluZSBzdGF0aWNfYXNzZXJ0KGV4cHIsIC4uLikgX19zdGF0aWNfYXNzZXJ0KGV4cHIs
ICMjX19WQV9BUkdTX18sICNleHByKQ0KPiAgI2RlZmluZSBfX3N0YXRpY19hc3NlcnQoZXhwciwg
bXNnLCAuLi4pIF9TdGF0aWNfYXNzZXJ0KGV4cHIsIG1zZykNCj4gIA0KPiArLyoqDQo+ICsgKiBj
b25zdF9zdHJjcHkgLSBDb3B5IGEgc3RyaW5nIGxpdGVyYWwgdG8gYSBjaGFyIGFycmF5IHdpdGgg
Y29tcGlsZS10aW1lIGNoZWNrcw0KPiArICogQGQ6IGRlc3RpbmF0aW9uIGNoYXIgYXJyYXkgKG11
c3QgYmUgYSBjaGFyIGFycmF5LCBub3QgYSBwb2ludGVyKQ0KPiArICogQHM6IHNvdXJjZSBzdHJp
bmcgbGl0ZXJhbA0KPiArICoNCj4gKyAqIEVuZm9yY2VzIGF0IGNvbXBpbGUgdGltZSB0aGF0Og0K
PiArICogKGEpIEBkIGlzIGEgY2hhciBhcnJheSwgbm90IGEgcG9pbnRlcg0KPiArICogKGIpIEBz
IGlzIGEgc3RyaW5nIGxpdGVyYWwgKGFkamFjZW50IHN0cmluZyBjb25jYXRlbmF0aW9uIHRyaWNr
KQ0KPiArICogKGMpIEBzIGZpdHMgaW4gQGQgaW5jbHVkaW5nIHRoZSBOVUwgdGVybWluYXRvcg0K
PiArICoNCj4gKyAqIFVzZXMgX19idWlsdGluX3N0cmNweSgpIHNvIHRoZSBjb21waWxlciBjYW4g
b3B0aW1pemUgdGhlIGNvcHkgaW50bw0KPiArICogaW1tZWRpYXRlIHN0b3JlcyByYXRoZXIgdGhh
biBlbWl0dGluZyBhIGZ1bmN0aW9uIGNhbGwuDQo+ICsgKg0KPiArICogTm90ZTogQHMgaXMgdXNl
ZCB0d2ljZSBpbiB0aGUgbWFjcm8gZXhwYW5zaW9uIGJ1dCB0aGlzIGlzIGludGVudGlvbmFsDQo+
ICsgKiBhbmQgc2FmZTogdGhlICgiIiBzICIiKSB0cmljayBlbmZvcmNlcyBhdCBjb21waWxlIHRp
bWUgdGhhdCBAcyBpcyBhDQo+ICsgKiBzdHJpbmcgbGl0ZXJhbCwgYW5kIHN0cmluZyBsaXRlcmFs
cyBoYXZlIG5vIHNpZGUgZWZmZWN0cy4NCj4gKyAqLw0KPiArI2RlZmluZSBjb25zdF9zdHJjcHko
ZCwgcykgKHsJCQkJCQlcDQo+ICsJQlVJTERfQlVHX09OKF9fYnVpbHRpbl90eXBlc19jb21wYXRp
YmxlX3AodHlwZW9mKGQpLCBjaGFyICopKTsJXA0KPiArCUJVSUxEX0JVR19PTihzaXplb2YoZCkg
PCBzaXplb2YoIiIgcyAiIikpOwkJCVwNCj4gKwlfX2J1aWx0aW5fc3RyY3B5KGQsIHMpOwkJCQkJ
CVwNCj4gK30pDQo+ICsNCj4gICNlbmRpZgkvKiBfTElOVVhfQlVJTERfQlVHX0ggKi8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
