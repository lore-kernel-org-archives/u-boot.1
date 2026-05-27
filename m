Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B18CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA372844CF;
	Wed, 27 May 2026 16:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="quBRQVCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A836846B4; Wed, 27 May 2026 16:29:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F06839A8
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTk3zReO/8xBD634P+ZrsK0VfRugT3yPLsRpGbVH28L2eKyEAFdJQC3HI86HAprCfJtljhKAupwNLhTPccVaqMkHOiPyJnBNY2DxL7DLKPR+GJEk6HMBg6VncTdoj+Tggecx0hM6H17uHEquQHml5ULtBVoMt99+QEyAZS5tfTE3Clv6atACrhaNzb8Fv3miVM/SA1Ge7vrpQLh6xyd0+cggwH9A5kLjABK4+MS9xuvkyij0Q2vJaEX4VmQvyWW9orALC6b3ChtrMjd2uyosbXZNhXnYvTRmIhpktAi90gfk4Z5lfo0dX8sYsqT7tOHAYPX0eKmcPwk9BIigAKgpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY+Cc9mYBJR56h3Oy2qCYEEOZRsgz5RJ9PES4DPqY2k=;
 b=jejfilR6KW7ldgyeBnXqsqASQ6uOzAUpKujMmpyY16v90kadBwGMDOnhYkYw+Tx3hgVJLOFHbpqa2h4vLKbbtHW4V8Y4v8SLF/9P56HdeqYYTqdeXgONcMh0onH7KJB4nTle+tfu5MVINioI41Cqls50yf7nBEyZKPMR0WeXuKli65sf+8nh/npq6+bdBK91MDoqeIJiBQ7jJfFmxkQVZWbC5Rh0973x2q5Pl3IjS6qRA3BunN3xrEcXPQrf2Y4uJQmdcPFAqPgUJAl4RIhvAaXcNz8rRVTfHkYWFeiJuVknX1BfsikqzwobukfSygfSE4z+V94wKmwpCVWO1DZwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY+Cc9mYBJR56h3Oy2qCYEEOZRsgz5RJ9PES4DPqY2k=;
 b=quBRQVCTPRoBfHpGXCDW6wUvLq8291633OEw4D7mN2+Q0WdB0q+kV44W2GVWi3z2QTdPchmNJ4aJ6YE0scEo+JHlE/Yndzts/4/IbbBfUDuWdZW64+gAAG0UJr+LKuySIlfxCphf/5ZcpilQHoqn2oaVHthhbgWzAOHseMhF4ho2uB7Iq7qBv5hZ0WcevsljqnsDsyAXLpaSAOVrgxsqAaQAt4unlLyyd84H0aSoXHqy/qnIU+/pc8QiDkAdiOx82RcalnToSpat8BQgyPIUaNnrpqR7hSoAcve6pngTS28ZMM6h8TQsLmD2cGNUrjFbCADbm4ntEqIYa+1TVdHDUw==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB8015.eurprd04.prod.outlook.com (2603:10a6:102:c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:29:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 14:29:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Simon Glass <sjg@chromium.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Peter Robinson
 <pbrobinson@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: RE: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
Thread-Topic: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
Thread-Index: AQHc7NYdjEOm1E5sxE2NKE4UF6Lj/rYhFFiAgADbTHA=
Date: Wed, 27 May 2026 14:29:37 +0000
Message-ID: <MRWPR04MB123306B6BA8249EBBC856412A88082@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-6-be3597b85b5e@nxp.com>
 <CAFLszThr_osXm8kdJr8aXEN0uZwk_-FV9EsB2s=oWqTDbu6cUw@mail.gmail.com>
In-Reply-To: <CAFLszThr_osXm8kdJr8aXEN0uZwk_-FV9EsB2s=oWqTDbu6cUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PA4PR04MB8015:EE_
x-ms-office365-filtering-correlation-id: d9d42b11-d027-4220-3f1b-08debbfc6183
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|19092799006|376014|1800799024|22082099003|18002099003|38070700021|4143699003|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: zfhx7hHziadvDXbz/3ad1y3Fl1H+yFBt7iJ9tZMBJoHoo8J5I27iNpgO+k0ip6wfc4GsKrnyHMuiAhgR8ANZ6GwyShq4D3C3S87CWZvBPnghWK08X54/iLcbjPlweeowpdu+nc2AGd5wCAsl0fsG4+THA9xA3trlGQLXlROq3hMpYS8Y2qxf7E5TZF6q1K/BgHWa5J3GSsp0RWQOZbwBllK1jYhF85LEf8vS0NH83T7WxUwJd0Vu1jo8uef91KvCtvVnX6t+qudbUxaeTa0Ieh2XC+J/y8JeFSBa2duXMjxDDsEQ4c64SiJDlm7b7UhZDOAR3ucLKb+/f5QHusQCof0PnDeakX4PpwDW9fW7ONNhBsh1CGbQIOd4Z2dLbJHZ2GExQmAfcOibeJKEEjA77c7kqw97cruDqWjMSII5QaDmpIHcvFU2xQCsgthChiewOGqpZVQX4uYlK9t8qvvBV8N4PTnF1uTJGE1EjE9r7B0uz0MdjDqjk948pm5zIwyDoQ65XUlTy2Xnwgi3EIMzS4Bv1a+t6YUfAY83CbpCOYAH9gmFx1x+Lfr++I34KBGX3Qn8v17PdX5yQ2mDKl3I0bg4mXZokvb/tzoEiw/DQ+D41nVp1TD0KhUDl+9Oj1cSIs8jymbBdFlX4UBvUI1QL+SLuSSxGFRZiwwr0ak7miXwnXyFNMot+ZA4isfz1ZlFwyBeyinrHkJUz0bwiOj4LDW4eSSrY1DWH11MYckJ8EVOhEj9xaa1F7FJ4lKxnPRx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFRCVU5VR05yc0VCN3hQL2I0WjE4Z0xSQVV4bXVLbGwxdnJMcnQ4alkrZ1Zi?=
 =?utf-8?B?K2tTTjdFNEZyaTB5S1ZvOGl3TnRwUm9DN2Joc0RhNjhuYXVTTUg0dEZVdHhQ?=
 =?utf-8?B?UmtBTzlKTjM0ZmJFSlhFV3dUNHlCSFgxL1NJZS9zVlVqWHVuTFVTeWtEWStw?=
 =?utf-8?B?OXhXbHJQVmNJMHZwYnROU1NoRTVGbVprZUZyV016MUlIZWhVMTlZajRNTHdX?=
 =?utf-8?B?UjBwQVdQM1hRcnM5RUFlb1ZPUnNUN1ZwVlp3ZkV6ZGt4YVFsTHdBM284VkI1?=
 =?utf-8?B?U3hHak5VS1ZkYVZ4T3l2blFvM21kUC9ScTk2bkxyOE9zcHQ3K3kxY3o4UDB5?=
 =?utf-8?B?QlNIb203azBIZHQwTEtkcW5DY0FuK001ZzhtYzhkNkUzcUxvRUk2QW1zaG1Z?=
 =?utf-8?B?TzJ5dWFWcmVHZENYUHhVb281d01sR1FIcXRlY0gwUDBKMzRnQkpNOExHeUp5?=
 =?utf-8?B?N1pXcHdiN2NHcjVueUpzc3JLTndVcTI3amt6NUduUEkzWEZRY1Q5bG1xbVNr?=
 =?utf-8?B?aE8yeWdjMmZYUzkwRnhCMTl0dXBKU3J6M3NLQmoyUCtsN1Z0NVU0VkE2bkNz?=
 =?utf-8?B?L0NYTjRpS2l5amNlclFyN0JpNUtkNDhvSSt6L3puZWdyWTRaN1duZGxUQVVs?=
 =?utf-8?B?cUpGRk93SGc1b0dEL3VnWUtFSVhmemdGN1ozKy9Wa3dFejNUTU1zK3NCcm8y?=
 =?utf-8?B?cWpCeDFUL0pocmZ3bFY1MjFGMFJsMXIybGpFVU93T1EyeUhyUzdadjVGNWZO?=
 =?utf-8?B?YTEvKy9nekNwVkQyNHlnN0JwNTRSZFRSL1ExbUthN1ZhZFlJWDNZdGd1cWNX?=
 =?utf-8?B?Syt3TjkvTE8wSXJjRHRHVk1Zak10RmwzZDVJdExJQ3UxNE9kcVNYUHR5WERq?=
 =?utf-8?B?KzgrV3N6djY3L2tuSDJVakNqVzkrWk5vbGp4c3U3enlJTTY0V29tRXFjTlAz?=
 =?utf-8?B?L01NOEJ5bnFZSStPSHliU2hhbHduc3UrR2tKbU1KMXhpUm5YclBLNWx2UG9w?=
 =?utf-8?B?dkdFQW83aEtCWVNVem1qcjZldGtiOHNsUjk0cXQ5TVJZVTRuN3JGd0NqR0NU?=
 =?utf-8?B?QjMwVTBRcTA0RTFmVzd6SHV4cFYyc0V0WXA2dnFraUdMOG9pRWN2VVF1YTM3?=
 =?utf-8?B?SStia2IrZEordzlMK0p5YU1JcVVldkhBQ2ozREg1a3V6SCtoTVZjQ3BTZStX?=
 =?utf-8?B?QmlIQ2FqQUhQNnVXdStrZGdNNUxQTUxBZGp6RTJ0ZEdybkd1emNuRVhqUkZN?=
 =?utf-8?B?U0NnMHRvbkhSb0J0WEJmVHNnY0o1K2oxNUtHZVYzWW5pZEd2RlNkSU9oc0Ex?=
 =?utf-8?B?K05TeElTRDlFSTdBbWgrYktES3NMaUE1SDQ5MlZUMFZ5aitpK21VN3lybmRs?=
 =?utf-8?B?UEpYMXF4OGhyU2tqOElpdWIwYmRnREo4Q0NoczBzYWtMRGpWbEFIbXNTdXhE?=
 =?utf-8?B?cnVjeDhlWFAwemNqOUhkRGZtRERRRHlucVJQdmxHT1FDRXpqeGt6dEpVc2NJ?=
 =?utf-8?B?QnNkZmdKakFLWEFMTWo0RWJWZElOdVJWbFVsVWxITFI3YW1FME93T1QreTIr?=
 =?utf-8?B?Qml2NUduME1DNUlJWmJYMWZXaG9vSmFKRy81RVV1M2ZBTmh0S3pjVnFvOUMr?=
 =?utf-8?B?SWtHajFRcHg4akFMM3pmcGNpSzhCdDJYcngyUXNrcnphOTl6eXdidlAxR1lX?=
 =?utf-8?B?Q2JpM3JlZ3RHNDk4d3gvRTdyN2hwdmtmb2p2YVRYTVRhdFVmVnFnMEM0L0pt?=
 =?utf-8?B?elduQUNSZldybG9aZWh6bUw0TXZNQ1lXRUNnb2o3Y2c2eEdpZjBzUGtmYmVw?=
 =?utf-8?B?TzhMUkdENVRVb2FnWEVEdkNVQ29JMERuaUQ2aVNDY1ZENncrNklsWkEzQm1w?=
 =?utf-8?B?YTdOdlhuOGlqc0ZEbWlGaXh4TXlVS2RyYkYxWXdTaUNHQm40QTE5azdMbEtm?=
 =?utf-8?B?RnZ3SHI2WGZvRzVVdkJCVy8ra2hkU0lnZTgvWkZOZnU2SXFuT29PNE5jMjFs?=
 =?utf-8?B?U1ZJRU5HN3N6UThPVGhvM3I1cEZNTEZuelFxSm9JK0ZPY2NxN3c0RUhsQVpa?=
 =?utf-8?B?ek1yL0hjL0h0SEo3a1lwRjdMQVdvMklUdHZtRlRBeUp6Qk5oeFVsUFVGQkM5?=
 =?utf-8?B?ZmxQOExZOFFIZUwzTHpodEFPYVcrY3dzcks1RTQ0ZlNDV1QybkdLcDFtYWVV?=
 =?utf-8?B?SUErSElyZWlKRjJPUG9GbHVybWgweXJpYldhSzJzM3o2aUtsVkY2S01pUFlO?=
 =?utf-8?B?MjR6S2NpekwvTWtqYlJSSVVhMTRPd3hNU2FudTZCVmEzRVZMeWluVW9FQ1Zs?=
 =?utf-8?Q?6i/s8U5Qe1FKuQ1k8T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d42b11-d027-4220-3f1b-08debbfc6183
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 14:29:37.5254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CuFgkJxV+S1Yw/kDGfHL1O2wCfJzTstVSl/8N0lRnRE4A4FQQ5vsOP5WVo5iBH6Zab5ASlAUOO14dgPmGlBm/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8015
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

SGkgU2ltb24sDQoNClRoYW5rcyBmb3IgZ2l2aW5nIGEgbG9vay4NCg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDYvNl0gbmV0OiBtdnBwMjogY29udmVydCBGRFQgYWNjZXNzIHRvIG9mbm9kZSBBUEkN
Cj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiAyMDI2LTA1LTI2VDA3OjI1OjA5LCBQZW5nIEZhbiAo
T1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+IG5ldDogbXZwcDI6IGNv
bnZlcnQgRkRUIGFjY2VzcyB0byBvZm5vZGUgQVBJDQo+ID4NCj4gPiBDb252ZXJ0IG12cHAyIGRy
aXZlciBmcm9tIGxlZ2FjeSBmZHRkZWMvZmR0XyogQVBJcyB0byB0aGUgb2Zub2RlLQ0KPiBiYXNl
ZA0KPiA+IGludGVyZmFjZXMuDQo+ID4NCj4gPiBSZXBsYWNlIHVzYWdlIG9mIGRldl9vZl9vZmZz
ZXQoKSwgZmR0ZGVjX2xvb2t1cF9waGFuZGxlKCksDQo+ID4gZmR0ZGVjX2dldF9pbnQoKSwgZmR0
X3BhcmVudF9vZmZzZXQoKSwgYW5kIHJlbGF0ZWQgaGVscGVycyB3aXRoIHRoZWlyDQo+ID4gb2Zu
b2RlIGVxdWl2YWxlbnRzLCBpbmNsdWRpbmcgZGV2X29mbm9kZSgpLCBvZm5vZGVfcGFyc2VfcGhh
bmRsZSgpLA0KPiA+IG9mbm9kZV9yZWFkX3MzMl9kZWZhdWx0KCksIG9mbm9kZV9nZXRfcGFyZW50
KCksIGFuZA0KPiA+IG9mbm9kZV9mb3JfZWFjaF9zdWJub2RlKCkuDQo+ID4NCj4gPiBSZW1vdmUg
ZGlyZWN0IGRlcGVuZGVuY2llcyBvbiBnZC0+ZmR0X2Jsb2IuDQo+ID4NCj4gPiBNYWluIGNoYW5n
ZXM6DQo+ID4gLSBVc2Ugb2Zub2RlX3ZhbGlkKCkgaW5zdGVhZCBvZiBpbnRlZ2VyIGNoZWNrcyBm
b3Igbm9kZSBwcmVzZW5jZQ0KPiA+IC0gU3dpdGNoIGZpeGVkLWxpbmsgZGV0ZWN0aW9uIHRvIG9m
bm9kZV9maW5kX3N1Ym5vZGUoKQ0KPiA+IC0gUmVwbGFjZSB1Y2xhc3NfZ2V0X2RldmljZV9ieV9v
Zl9vZmZzZXQoKSB3aXRoDQo+ID4gICB1Y2xhc3NfZ2V0X2RldmljZV9ieV9vZm5vZGUoKQ0KPiA+
IC0gVXBkYXRlIHN1Ym5vZGUgaXRlcmF0aW9uIGFuZCBkZXZpY2UgYmluZGluZyB0byB1c2Ugb2Zu
b2RlDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gZHJpdmVycy9uZXQvbXZwcDIuYyB8IDU0DQo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0K
PiANCj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbXZwcDIuYyBiL2RyaXZlcnMvbmV0L212cHAyLmMg
QEAgLTU0MzYsMTUNCj4gPiArNTQzNiwxNCBAQCBzdGF0aWMgc3RydWN0IGRyaXZlciBtdnBwMl9k
cml2ZXIgPSB7DQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgaW50IG12cHAyX2Jhc2VfYmluZChzdHJ1
Y3QgdWRldmljZSAqcGFyZW50KSAgew0KPiA+IC0gICAgIGNvbnN0IHZvaWQgKmJsb2IgPSBnZC0+
ZmR0X2Jsb2I7DQo+ID4gLSAgICAgaW50IG5vZGUgPSBkZXZfb2Zfb2Zmc2V0KHBhcmVudCk7DQo+
ID4gKyAgICAgb2Zub2RlIG5vZGUgPSBkZXZfb2Zub2RlKHBhcmVudCk7DQo+IA0KPiAnbm9kZScg
aXMgbm93IG5vIGxvbmdlciB1c2VkIGJ5IHRoZSBsb29rIG9mIGl0LiBEbyB5b3Ugc2VlIGEgd2Fy
bmluZz8NCg0KSSB1c2UgIi4vdG9vbHMvYnVpbGRtYW4vYnVpbGRtYW4geDI1MCAiLCBJIG1heSBt
aXNzIHNvbWV0aGluZy4NCmluZGVlZCBubyB1c2VyLCBJIHdpbGwgcmVtb3ZlIGl0LiANCg0KPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbXZwcDIuYyBiL2RyaXZlcnMvbmV0L212cHAy
LmMNCj4gPiBAQCAtNTQ3OCw4ICs1NDc3LDkgQEAgc3RhdGljIGludCBtdnBwMl9iYXNlX2JpbmQo
c3RydWN0IHVkZXZpY2UNCj4gKnBhcmVudCkNCj4gPiAgICAgICAgICAgICAgIHNwcmludGYobmFt
ZSwgJ212cHAyLSVkJywgaWQpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAvKiBDcmVhdGUgY2hp
bGQgZGV2aWNlIFVDTEFTU19FVEggYW5kIGJpbmQgaXQgKi8NCj4gPiAtICAgICAgICAgICAgIGRl
dmljZV9iaW5kKHBhcmVudCwgJm12cHAyX2RyaXZlciwgbmFtZSwgcGxhdCwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mZnNldF90b19vZm5vZGUoc3Vibm9kZSksICZkZXYpOw0KPiA+
ICsgICAgICAgICAgICAgcmV0ID0gZGV2aWNlX2JpbmQocGFyZW50LCAmbXZwcDJfZHJpdmVyLCBu
YW1lLCBwbGF0LA0KPiBzdWJub2RlLCAmZGV2KTsNCj4gPiArICAgICAgICAgICAgIGlmIChyZXQp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiBUaGlzIGlzIGEg
YmVoYXZpb3VyYWwgY2hhbmdlIC0gdGhlIG9sZCBjb2RlIGlnbm9yZWQgYmluZCBmYWlsdXJlcyBh
bmQNCj4gY29udGludWVkLCB0aGUgbmV3IGNvZGUgYWJvcnRzIGFuZCBsZWFrcyB0aGUgYWxyZWFk
eS1hbGxvY2F0ZWQgcGxhdA0KPiBhbmQgbmFtZS4gUHJvYmFibHkgdGhlIHJpZ2h0IHRoaW5nLCBi
dXQgcGxlYXNlIG1lbnRpb24gaXQgaW4gdGhlDQo+IGNvbW1pdCBtZXNzYWdlICh0aGUgIk5vIGZ1
bmN0aW9uYWwgY2hhbmdlcyIgY2xhaW0gaXMgbm90IHF1aXRlDQo+IGFjY3VyYXRlKSBhbmQgZnJl
ZSBwbGF0L25hbWUgb24gdGhlIGVycm9yIHBhdGguDQoNCldpbGwgdXBkYXRlIGNvbW1pdCBtZXNz
YWdlIGluIHYyLg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9tdnBwMi5jIGIv
ZHJpdmVycy9uZXQvbXZwcDIuYw0KPiA+IEBAIC00NzMxLDMzICs0NzMxLDM0IEBAIHN0YXRpYyBp
bnQgbXZwcDJfcG9ydF9pbml0KHN0cnVjdA0KPiB1ZGV2aWNlICpkZXYsIHN0cnVjdCBtdnBwMl9w
b3J0ICpwb3J0KQ0KPiA+IC0gICAgICAgICAgICAgcGFyZW50ID0gZmR0X3BhcmVudF9vZmZzZXQo
Z2QtPmZkdF9ibG9iLCBwaHlfbm9kZSk7DQo+ID4gLSAgICAgICAgICAgICByZXQgPSB1Y2xhc3Nf
Z2V0X2RldmljZV9ieV9vZl9vZmZzZXQoVUNMQVNTX01ESU8sIHBhcmVudCwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcG9ydC0+bWRpb19k
ZXYpOw0KPiA+ICsgICAgICAgICAgICAgcGFyZW50ID0gb2Zub2RlX2dldF9wYXJlbnQocGh5X25v
ZGUpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKCFvZm5vZGVfdmFsaWQocGFyZW50KSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBXZSBzaG91bGQgYmUg
Y2FyZWZ1bCByZXR1cm5pbmcgLUVOT0RFViBhcyBpdCBoYXMgYSBzcGVjaWFsIG1lYW5pbmcNCj4g
d2l0aCBETS4gVGhpcyBpcyBhIHNtYWxsIGJlaGF2aW91cmFsIGNoYW5nZSB2ZXJzdXMgdGhlIG9s
ZCBjb2RlLCB3aGljaA0KPiBwYXNzZWQgYSBuZWdhdGl2ZSBvZmZzZXQgc3RyYWlnaHQgdGhyb3Vn
aC4gV29ydGggbm90aW5nIGluIHRoZSBjb21taXQNCj4gbWVzc2FnZSwgb3IgZHJvcCB0aGUgY2hl
Y2sgc2luY2UgdGhlIGNhbGwgYmVsb3cgd2lsbCByZXR1cm4gYW4gZXJyb3INCg0KSSB3aWxsIGRy
b3AgdGhlIGNoZWNrIGluIHYyLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IGFueXdheS4NCj4gDQo+
IFJlZ2FyZHMsDQo+IFNpbW9uDQo=
