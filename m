Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64131D3517D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 13:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7B283D8A;
	Wed,  1 Apr 2026 15:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Aqe0XJLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B55884020; Wed,  1 Apr 2026 15:27:58 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94F383CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 15:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYNS1byY3LcEkWyhiOL9B7ppXDt0zu8U3aqqGNFHc8tFFR1C4RN60siut3UocSmuK0Vck4FFAzRmn4tiCem2bqXDmxyt1BGH/fVYDJTtKBMYutrX/9kBul3qaBw5in1Q0TMY5PN4chFf4nayBcBLqqtTQcXx4xi6h2C5UNwrtx5cQr/Q03aK+bKP6V1hFMoPaeUna+JwTV79RSXblAbyBViWqarl0nBthdw2qGIpRoTsaxYrN2YeRFtEpRpZausGmyuoXkW9eJ0yvDzUZGXCMCiK7n6K+9XU6KCQA2LhDBp/IYf67TpSWgzE7iGPHNu8Lg2HxBiDtF9hwM/NfrjnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd0PRm65fbtjrdCUoGEs8Sf2jL9dOy5M9Hj8goPeaXA=;
 b=DXn4PMefxqd2xG9fk7b0NFUmUy4rst9T/NSz+yMFHxsOQy0C/xHNCMNsvTxDt2X2MXX700b9ouplHM223RKg2wBqygS3l2JWXOYLdbWbFv1FzHNmXYlzs3+Xq03wMI1VBCsTSNklJL2H91VNSz4BYKMowrUguRjkOIrY3pryYBJHnAYqrO3AcfHiAMF76DtWLqK2d53qAy55A8qw9e7W2td7U2ypIGCZw09aWkw6gLATxjYTtRm1sIeYkTcYP9qVaBXzFWjLx/WjzQxPo6F7O4EyCsv/3wUUd3i0cf0G4k9q4t1GMlz8HmnvyUC1jdiv4I8BuyLkxcbymlzb4wBdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd0PRm65fbtjrdCUoGEs8Sf2jL9dOy5M9Hj8goPeaXA=;
 b=Aqe0XJLXutICbJRC3LSuhtAlliVVQnxVpVyNXU9mN27NKjNvsGFNmgHWWab5OgWhNG9GdWRheeQdocxvQXfsAHGLQ+SswSPJI43S9L7xSTywM/7uteHvpiJqbflPLSD1kGCkbuNlJRMB+kMJwk+/lSoS0w3omOnr77eJO6g4h3NtXriR/ftl2r8UaIXjZ2i70cI8/0J8SmtuSnKd1UfT9yliBQ7uinqTPPH6PXE5bD/H7+j6PWiDjOeM5QALeSjX4csdL+0dUHYTav2QGxyAqRMpFmTLi6WiTnajr2h6JHQqDd0/SN2RsJNLeAuZVVdgm+fUAuFtkj2+3qxv+ru1Ow==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by VI0P195MB3010.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 13:27:52 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 13:27:52 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: Benjamin Hahn <B.Hahn@phytec.de>, Leonard Anderweit
 <l.anderweit@phytec.de>, "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>, Yannic
 Moog <y.moog@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, "matteo.lisi@engicam.com"
 <matteo.lisi@engicam.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Thread-Topic: [PATCH v2 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Thread-Index: AQHcwEOCOIoIF6KOP0uPlywlV2LOWLXKNiUA
Date: Wed, 1 Apr 2026 13:27:52 +0000
Message-ID: <98f8f5174cd3d830c3555b28f46c698af4caec41.camel@phytec.de>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
 <20260330-power-legacy-v2-3-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-3-47dde3182a2c@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|VI0P195MB3010:EE_
x-ms-office365-filtering-correlation-id: e832439a-e99e-4ccf-8cfc-08de8ff27a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: FVrN5WwLFAwf9LyGoga5bCC9DxQTmmkX0rOtmE4nhSyfounqfXBT/0NOabSHNEH2LnVunCQYQ3jWxd3AoI+KaUAg9E66aZbItK7TfLKAelVJuvIzQaAMgew/o3SulL4vCAl4+67jWjIFpGpqcrCofedhjEODWPyE5TpKJ0CduNFo1+EQcYHR5yAbITu6UBiO0OI2LnOfAjLjEXe5ubsfUJbgRLtwWw0OD7sprkmgziowqyeF4VCFjMCVsu41gY3n1hHnXIPRCaPC67tUnZ5FIQFilU+K7dbr7c7GXgqk4gJAuKXZmNWWTGueJSnq81CdU4K64qYiUj47zWyfhInbs308bxbMUMy5HOshnLEDC9UFLBhHglFhYCFT9ipkSl8ToRABh2hliPhYyIuvkfpBKPIPEKd8VP7nvJuEO774FG32hauZz1j1HzhSflZtFCXB0L+R0t8gdcKaAdtCi//7k1r76K3Flfkh+n2yzcPk8yfbDfju7351vvpk11+9t22mH+N4/GaH0R65O6/K4uTIf4AeN+MMM/kYDvtNxgB2jRLdCm7+zGmKDzhpljmDXfYAMpP7NpdW2NPrcNzTSZFkEhCRpU4+Dulr7vCbx3BfrtKkqFEm1n4pOa9SRUISefzk2EdWTbPEAzZUEFPPUBNF0QR/0TnIIfVneF9DMLdFF4THJYfgu8O/KwxnOnoq/RYMPizuOekN70JqBfsE3pb6B6FxHiJIxAjN740G3CWcv+85tagXgVVW14PhaxbC1PCuE8VQvUpOC+YbaLocmpP1x0GNb5wqUgX7AmQhx77Neh8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlAwV1pCZmtSUXNHSGVhVnRsc1lVTzVrV2UzZGtySVQxYmx5Z25LVExtZkZs?=
 =?utf-8?B?OW15NWpyU3RDV0g2c3RjemJlMVk5N2o1Q00wdXdyLzFQWFBsRmp5MkVMeTZa?=
 =?utf-8?B?QU1ua1VtdnpDckYrRUxUY2loNGYrUlp5V20wYW1sY0MxQW1tdHZyUmVlNHZ5?=
 =?utf-8?B?elFPQjVDTnFNSE5wUzNqVlp5N1oyemRxM1hrYU9nTlE4MW1WdjhTZDVyRjM2?=
 =?utf-8?B?YUJUcnBUZFJQMXk1RmJxVzc4MTBhMFNSL3cxT2YrSENYR1IzbjQ0aFNLR0pY?=
 =?utf-8?B?SjBnUThTMlJmQ2plMWlYM1BWZDBhYVpKK3BkZDc2eVAxak01bm9mbFJaM2Nq?=
 =?utf-8?B?OEZwNE5laWNPUlhpZWJDdkV0b01LQnZiQ2NjWVdRWG1WNi9kYnhUaW04dXJt?=
 =?utf-8?B?VUxXb0l3bHBQNUNmUkorWGpRYU1wUWxUTVUzSnR3R2duWGo0a1BJbnZseEFE?=
 =?utf-8?B?emdXeUtpMTJEdnhKUFA4eUtOQWFVYTkyNTE2S2tBVThoaGk3RXNHdnNOejVa?=
 =?utf-8?B?MFdBT0t4MkIvL3hDRmhJcXc1ZTNwdHlTRzZIQjZ6YkM1Sm5xdEg0YS8xOGl2?=
 =?utf-8?B?b2FmYlJmVEpPQ0Q2aGZqNlRMcWM2U0EwZjQ3cWNLMVg2TGloUXoxc3NyVnJJ?=
 =?utf-8?B?YkkyWmFIOE9ScmFJcDA4bjB5UU13Ryt0MnhxRDVTRzl0djlHZGpidERNaTR0?=
 =?utf-8?B?NFZ6bzEyVVZKeXV0SFpoUjhMWjhjaTljc0NSMzJXaFhNeVdzbml3SmFZcTh4?=
 =?utf-8?B?Zlo4dlBvNlFFSlhzY2JDaTNrQjgwRmFmd3F2QXpCTk4rbmdGUWpqRGRJWmlI?=
 =?utf-8?B?L21xMzB0L1djM1AwZ1VoMVpNdWRKWTJubi9iVnVXejhZQUxKekRVN0gzL0hy?=
 =?utf-8?B?ZlNYRlRzVmZ4MWxFNUVvOW1qTWE4T2hZUGZ0cnBpYWs0VGZPclpRVW10V2ww?=
 =?utf-8?B?cTY4RHZOU2dtMjdscDlFL0QzcWVBT2M5eUI1VXZVa1IxeVNySldGM1l0dVlD?=
 =?utf-8?B?cWswaWVVcE00Q0VKMjdjUFJUK09FNnBKSU93ZGFsSVE1S1BXVmVuZTU3TGU3?=
 =?utf-8?B?bXpOZEhESWdQLzdaUnl5UDYwYitvdzVIQlVySUJRenNCYWUwV2tqVXhibXhk?=
 =?utf-8?B?RXBuQi9QNVBEOTBKeWp6U1ZJa25INkhvR21RTnlScmZLVjZBU0pMc1dYNEdL?=
 =?utf-8?B?ZTdRVjIycGlxbnVwNzhaMHUrSjNObGllK2RMOVJmR04zcGV0UERpdm90bXk3?=
 =?utf-8?B?WXhiUEVZUFh5SFUwSFVSeFN6SktUekR1dElPSFY4QUNva09GeUFmNldCOXJT?=
 =?utf-8?B?RkQzS1lPc0t3cnJQQm1NbmhBM2h1emVFMnM5NSt2TlBESmlFQmd5SlVxZ3hl?=
 =?utf-8?B?Y2F6K1JOc3hkRnNCRTE1UTFXVW94cEExQjg4RTVMbGordGp5RkM4aU83UjhO?=
 =?utf-8?B?RVdYMGd0SFN5MmlMQ2hXL2dtTkY1enlhNHNPUUYyRXBQVmhvSGowRFNPaE5o?=
 =?utf-8?B?Y2owcmFIUGM5ekRsYWhCdUNvYzRobndacmNqMDRIeE5QeTAxSEpiSUxTR1Nu?=
 =?utf-8?B?RUxqMGZRbG10dm5mbFhOQWdnT1NrVkN4KzdDRStINGNsTmluckFNR09WcDhL?=
 =?utf-8?B?eFpEMGZiU0ltVEVDVkg3YUJBeDc1aCtYT2twdWNoM0N5eXdSUWk3YU40YUQ0?=
 =?utf-8?B?dXJ6UnFodmp6N1pvNEZLb0l3V2tibFdPUms1Zk5KRk14c2RXdlM5Z1hXci8r?=
 =?utf-8?B?OWY2dzZINzM0bHEzc2QrSzlZNVFSV1RJVEY0QW5hdUtzVTRvTSt0SjFzenlE?=
 =?utf-8?B?cWJnYUNFV0lGQlpCaTJTOHhvS1JWSnF5T2hGNHlBcFZEdXhEUFZCVSt3NjlP?=
 =?utf-8?B?K0xLWUNnUkthZkNvU2NLdmwrdmQvVkhKR2ZiNENTSXdPdVFuc2wveFZkUnp6?=
 =?utf-8?B?dyt5dEo5d1ROK1gwNWpyeFlaSVVEK0w5Z0ZqbXF0WjNseFNYK2M0L0dDbVFm?=
 =?utf-8?B?QkRPaVQyRjNGc0dKa2sweEpnalVTdDkxUWtLMFEvRFhDQmlkK2REZkJKYnh0?=
 =?utf-8?B?V3dYYUg1d1BHbkw1cFRYZXZhdXFyYmFwV3hYOGpGSCtCYjFWdTc5WDJRRzM4?=
 =?utf-8?B?R2xXU2lrR1NRSUd3OWF6K2t3ZWZvSTlod2MvTmRETDVja09LQ2V5RHE2MStv?=
 =?utf-8?B?M1dhY1ZDM1JtQmc1cGh4RkY3TTlQTzdGeHhaM1hZQS95OFdvZ1VCaE9rYmsy?=
 =?utf-8?B?THVQTC9nV21mN29JUEozOUJGZWdTTVN5ajR1OUNFQzAxVWV4YVdQMGN5YXBw?=
 =?utf-8?B?WjhXTU9FL1JYL3ZyS1ZxRTdja056R3dqUHJEOTNBSmQ4eGRWTmNydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62F9882232F0114AA47FA57412E474F8@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e832439a-e99e-4ccf-8cfc-08de8ff27a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 13:27:52.6592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyJwZLnKoKaTHEBvKhq6Htzv6njSDeYUfHJi2g5g8rbSvayPtibrQwOvZUCjlRN/aR74k562Z6YphYm2DwDgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3010
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

QW0gTW9udGFnLCBkZW0gMzAuMDMuMjAyNiB1bSAyMjowNCArMDgwMCBzY2hyaWViIFBlbmcgRmFu
IChPU1MpOg0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IENvbnZl
cnQgdGhlIGJvYXJkIHRvIHVzZSBETV9QTUlDIGluc3RlYWQgb2YgdGhlIGxlZ2FjeSBTUEwgSTJD
L1BNSUMNCj4gaGFuZGxpbmcuDQo+IA0KPiBDaGFuZ2VzIGluY2x1ZGU6DQo+IC0gRW5hYmxlIERN
X1BNSUMsIERNX1BNSUNfUENBOTQ1MCwgYW5kIFNQTF9ETV9QTUlDX1BDQTk0NTAgaW4NCj4gZGVm
Y29uZmlnLg0KPiAtIERyb3AgbGVnYWN5IFNQTCBJMkMgYW5kIFBNSUMgb3B0aW9ucy4NCj4gLSBS
ZW1vdmUgbWFudWFsIEkyQzEgcGFkIHNldHVwIGFuZCBsZWdhY3kgcG93ZXJfcGNhOTQ1MF9pbml0
KCkgdXNhZ2UuDQo+IC0gVXNlIERNLWJhc2VkIHBtaWNfZ2V0KCkgd2l0aCB0aGUgRFQgbm9kZSAi
cG1pY0AyNSIuDQo+IC0gVXBkYXRlIFBNSUMgcmVnaXN0ZXIgcHJvZ3JhbW1pbmcgdG8gdXNlIHN0
cnVjdCB1ZGV2aWNlIEFQSS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVj
LmRlPg0KPiAtLS0NCj4gwqBhcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9v
dC5kdHNpIHwgMjIgKysrKysrKysrKy0tDQo+IMKgYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1m
cHNjL3NwbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NiArKysrKysrKy0tLS0tLS0tDQo+IC0t
LS0tLS0tLS0NCj4gwqBjb25maWdzL2lteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZ8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAxMCArKystLS0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2Vy
dGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0
cy9pbXg4bXAtbGlicmEtcmRrLWZwc2MtdS1ib290LmR0c2kNCj4gYi9hcmNoL2FybS9kdHMvaW14
OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9vdC5kdHNpDQo+IGluZGV4IDEzMjBmMTU0MGVkLi5mOTE3
YjcxYmU5MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDhtcC1saWJyYS1yZGstZnBz
Yy11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNj
LXUtYm9vdC5kdHNpDQo+IEBAIC0zMyw2ICszMywxOCBAQA0KPiDCoAl9Ow0KPiDCoH07DQo+IMKg
DQo+ICsmcGluY3RybF9pMmMxIHsNCj4gKwlib290cGgtYWxsOw0KPiArfTsNCj4gKw0KPiArJnBp
bmN0cmxfcG1pYyB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsNCj4gKyZ7L3NvY0AwL2J1
c0AzMDgwMDAwMC9pMmNAMzBhMjAwMDAvcG1pY0AyNS9yZWd1bGF0b3JzfSB7DQo+ICsJYm9vdHBo
LWFsbDsNCj4gK307DQo+ICsNCj4gwqAmcmVnX3VzZGhjMl92bW1jIHsNCj4gwqAJYm9vdHBoLXBy
ZS1yYW07DQo+IMKgfTsNCj4gQEAgLTc4LDExICs5MCwxMSBAQA0KPiDCoH07DQo+IMKgDQo+IMKg
JmkyYzEgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4g
wqANCj4gwqAmcG1pYyB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4g
wqB9Ow0KPiDCoA0KPiDCoC8qIFVTQjEgVHlwZS1DICovDQo+IEBAIC0xMjAsNiArMTMyLDEyIEBA
DQo+IMKgDQo+IMKgJnVzZGhjMiB7DQo+IMKgCWJvb3RwaC1wcmUtcmFtOw0KPiArCS8qDQo+ICsJ
ICogTERPNSBvdXRwdXQgZGVwZW5kcyBvbiBTRDJfVlNFTCwgYnV0IG5vIHdheSB0byByZWFkIGJh
Y2sNCj4gU0QyX1ZTRUwNCj4gKwkgKiB3aGVuIHVzaW5nIFNESEMgY29udHJvbGxlciBWU0VMRUNU
IHRvIGNvbnRyb2wgU0QyX1ZTRUwuDQo+IFNvIGRyb3ANCj4gKwkgKiB2cW1tYy1zdXBwbHkgdG8g
YXZvaWQgZnNsX2VzZGhjX2lteCByZWFkIGJhY2sgd3JvbmcNCj4gdm9sdGFnZS4NCj4gKwkgKi8N
Cj4gKwkgL2RlbGV0ZS1wcm9wZXJ0eS8gdnFtbWMtc3VwcGx5Ow0KPiDCoH07DQo+IMKgDQo+IMKg
JnVzZGhjMyB7DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2Mv
c3BsLmMNCj4gYi9ib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2Mvc3BsLmMNCj4gaW5kZXgg
MDgxMTE2NDFhYTYuLmFhMjJhZDAwMzBjIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvaW14
OG1wLWxpYnJhLWZwc2Mvc3BsLmMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1m
cHNjL3NwbC5jDQo+IEBAIC05LDkgKzksNiBAQA0KPiDCoCNpbmNsdWRlIDxhc20vYXJjaC9pbXg4
bXBfcGlucy5oPg0KPiDCoCNpbmNsdWRlIDxhc20vYXJjaC9zeXNfcHJvdG8uaD4NCj4gwqAjaW5j
bHVkZSA8YXNtL21hY2gtaW14L2Jvb3RfbW9kZS5oPg0KPiAtI2luY2x1ZGUgPGFzbS9tYWNoLWlt
eC9ncGlvLmg+DQo+IC0jaW5jbHVkZSA8YXNtL21hY2gtaW14L214Y19pMmMuaD4NCj4gLSNpbmNs
dWRlIDxhc20vbWFjaC1pbXgvaW9tdXgtdjMuaD4NCj4gwqAjaW5jbHVkZSA8aGFuZy5oPg0KPiDC
oCNpbmNsdWRlIDxpbml0Lmg+DQo+IMKgI2luY2x1ZGUgPGxvZy5oPg0KPiBAQCAtNDYsNDUgKzQz
LDMyIEBAIHZvaWQgc3BsX2RyYW1faW5pdCh2b2lkKQ0KPiDCoAlkZHJfaW5pdCgmZHJhbV90aW1p
bmcpOw0KPiDCoH0NCj4gwqANCj4gLSNkZWZpbmUgSTJDX1BBRF9DVFJMIChQQURfQ1RMX0RTRTYg
fCBQQURfQ1RMX0hZUyB8IFBBRF9DVExfUFVFIHwNCj4gUEFEX0NUTF9QRSkNCj4gLSNkZWZpbmUg
UEMgTVVYX1BBRF9DVFJMKEkyQ19QQURfQ1RSTCkNCj4gLXN0cnVjdCBpMmNfcGFkc19pbmZvIGky
Y19wYWRfaW5mbzEgPSB7DQo+IC0JLnNjbCA9IHsNCj4gLQkJLmkyY19tb2RlID0gTVg4TVBfUEFE
X0kyQzFfU0NMX19JMkMxX1NDTCB8IFBDLA0KPiAtCQkuZ3Bpb19tb2RlID0gTVg4TVBfUEFEX0ky
QzFfU0NMX19HUElPNV9JTzE0IHwgUEMsDQo+IC0JCS5ncCA9IElNWF9HUElPX05SKDUsIDE0KSwN
Cj4gLQl9LA0KPiAtCS5zZGEgPSB7DQo+IC0JCS5pMmNfbW9kZSA9IE1YOE1QX1BBRF9JMkMxX1NE
QV9fSTJDMV9TREEgfCBQQywNCj4gLQkJLmdwaW9fbW9kZSA9IE1YOE1QX1BBRF9JMkMxX1NEQV9f
R1BJTzVfSU8xNSB8IFBDLA0KPiAtCQkuZ3AgPSBJTVhfR1BJT19OUig1LCAxNSksDQo+IC0JfSwN
Cj4gLX07DQo+IC0NCj4gwqBpbnQgcG93ZXJfaW5pdF9ib2FyZCh2b2lkKQ0KPiDCoHsNCj4gLQlz
dHJ1Y3QgcG1pYyAqcDsNCj4gKwlzdHJ1Y3QgdWRldmljZSAqZGV2Ow0KPiDCoAlpbnQgcmV0Ow0K
PiDCoA0KPiAtCXJldCA9IHBvd2VyX3BjYTk0NTBfaW5pdCgwLCAweDI1KTsNCj4gLQlpZiAocmV0
KQ0KPiAtCQlwcmludGYoInBvd2VyIGluaXQgZmFpbGVkIik7DQo+IC0JcCA9IHBtaWNfZ2V0KCJQ
Q0E5NDUwIik7DQo+IC0JcG1pY19wcm9iZShwKTsNCj4gKwlyZXQgPSBwbWljX2dldCgicG1pY0Ay
NSIsICZkZXYpOw0KPiArCWlmIChyZXQgPT0gLUVOT0RFVikgew0KPiArCQlwdXRzKCJObyBwbWlj
QDI1XG4iKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQly
ZXR1cm4gcmV0Ow0KPiDCoA0KPiDCoAkvKiBCVUNLeE9VVF9EVlMwLzEgY29udHJvbCBCVUNLMTIz
IG91dHB1dCAqLw0KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBfQlVDSzEyM19EVlMsIDB4
MjkpOw0KPiArCXBtaWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMTIzX0RWUywgMHgyOSk7
DQo+IMKgDQo+IMKgCS8qIEluY3JlYXNlIFZERF9TT0MgYW5kIFZERF9BUk0gdG8gT0Qgdm9sdGFn
ZSAwLjk1ViAqLw0KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMCwg
MHgxQyk7DQo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMk9VVF9EVlMwLCAweDFD
KTsNCj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMCwgMHgxQyk7
DQo+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0syT1VUX0RWUzAsIDB4MUMpOw0K
PiDCoA0KPiDCoAkvKiBTZXQgQlVDSzEgRFZTMSB0byBzdXNwZW5kIGNvbnRyb2xsZWQgdGhyb3Vn
aA0KPiBQTUlDX1NUQllfUkVRICovDQo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNL
MU9VVF9EVlMxLCAweDE0KTsNCj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxQ1RS
TCwgMHg1OSk7DQo+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzEs
IDB4MTQpOw0KPiArCXBtaWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMUNUUkwsIDB4NTkp
Ow0KPiDCoA0KPiDCoAkvKiBTZXQgV0RPR19CX0NGRyB0byBjb2xkIHJlc2V0ICovDQo+IC0JcG1p
Y19yZWdfd3JpdGUocCwgUENBOTQ1MF9SRVNFVF9DVFJMLCAweEExKTsNCj4gKwlwbWljX3JlZ193
cml0ZShkZXYsIFBDQTk0NTBfUkVTRVRfQ1RSTCwgMHhBMSk7DQo+IMKgDQo+IMKgCXJldHVybiAw
Ow0KPiDCoH0NCj4gQEAgLTEyMCw4ICsxMDQsNiBAQCB2b2lkIGJvYXJkX2luaXRfZih1bG9uZyBk
dW1teSkNCj4gwqANCj4gwqAJZW5hYmxlX3R6YzM4MCgpOw0KPiDCoA0KPiAtCXNldHVwX2kyYygw
LCBDT05GSUdfU1lTX0kyQ19TUEVFRCwgMHg3ZiwgJmkyY19wYWRfaW5mbzEpOw0KPiAtDQo+IMKg
CXBvd2VyX2luaXRfYm9hcmQoKTsNCj4gwqANCj4gwqAJLyogRERSIGluaXRpYWxpemF0aW9uICov
DQo+IGRpZmYgLS1naXQgYS9jb25maWdzL2lteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZyBiL2Nv
bmZpZ3MvaW14OG1wLQ0KPiBsaWJyYS1mcHNjX2RlZmNvbmZpZw0KPiBpbmRleCBhMjNlNjA0NDI1
ZC4uNGE4OTM4ZDNlNDMgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvaW14OG1wLWxpYnJhLWZwc2Nf
ZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvaW14OG1wLWxpYnJhLWZwc2NfZGVmY29uZmlnDQo+
IEBAIC05LDcgKzksNiBAQCBDT05GSUdfU0ZfREVGQVVMVF9TUEVFRD04MDAwMDAwMA0KPiDCoENP
TkZJR19FTlZfU0laRT0weDEwMDAwDQo+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHgzQzAwMDANCj4g
wqBDT05GSUdfRU5WX1NFQ1RfU0laRT0weDEwMDAwDQo+IC1DT05GSUdfU1lTX0kyQ19NWENfSTJD
MT15DQo+IMKgQ09ORklHX0RNX0dQSU89eQ0KPiDCoENPTkZJR19ERUZBVUxUX0RFVklDRV9UUkVF
PSJmcmVlc2NhbGUvaW14OG1wLWxpYnJhLXJkay1mcHNjIg0KPiDCoENPTkZJR19JTVg4TV9PUFRF
RV9MT0FEX0FERFI9MHg3ZTAwMDAwMA0KPiBAQCAtMTA1LDggKzEwNCw2IEBAIENPTkZJR19GQVNU
Qk9PVF9NTUNfVVNFUl9TVVBQT1JUPXkNCj4gwqBDT05GSUdfRkFTVEJPT1RfTU1DX1VTRVJfTkFN
RT0ibW1jMiINCj4gwqBDT05GSUdfTVhDX0dQSU89eQ0KPiDCoENPTkZJR19ETV9JMkM9eQ0KPiAt
IyBDT05GSUdfU1BMX0RNX0kyQyBpcyBub3Qgc2V0DQo+IC1DT05GSUdfU1BMX1NZU19JMkNfTEVH
QUNZPXkNCj4gwqBDT05GSUdfSTJDX0VFUFJPTT15DQo+IMKgQ09ORklHX1NZU19JMkNfRUVQUk9N
X0FERFI9MHg1MQ0KPiDCoENPTkZJR19TVVBQT1JUX0VNTUNfQk9PVD15DQo+IEBAIC0xMzgsMTUg
KzEzNSwxNiBAQCBDT05GSUdfUEhZX0lNWDhNUV9VU0I9eQ0KPiDCoENPTkZJR19QSU5DVFJMPXkN
Cj4gwqBDT05GSUdfU1BMX1BJTkNUUkw9eQ0KPiDCoENPTkZJR19QSU5DVFJMX0lNWDhNPXkNCj4g
LUNPTkZJR19TUExfUE9XRVJfTEVHQUNZPXkNCj4gwqBDT05GSUdfUE9XRVJfRE9NQUlOPXkNCj4g
wqBDT05GSUdfSU1YOE1fUE9XRVJfRE9NQUlOPXkNCj4gwqBDT05GSUdfSU1YOE1QX0hTSU9NSVhf
QkxLQ1RSTD15DQo+IC1DT05GSUdfUE9XRVJfUENBOTQ1MD15DQo+ICtDT05GSUdfRE1fUE1JQz15
DQo+ICtDT05GSUdfRE1fUE1JQ19QQ0E5NDUwPXkNCj4gK0NPTkZJR19TUExfRE1fUE1JQ19QQ0E5
NDUwPXkNCj4gwqBDT05GSUdfRE1fUkVHVUxBVE9SPXkNCj4gK0NPTkZJR19ETV9SRUdVTEFUT1Jf
UENBOTQ1MD15DQo+IMKgQ09ORklHX0RNX1JFR1VMQVRPUl9GSVhFRD15DQo+IMKgQ09ORklHX0RN
X1JFR1VMQVRPUl9HUElPPXkNCj4gLUNPTkZJR19TUExfUE9XRVJfSTJDPXkNCj4gwqBDT05GSUdf
RE1fUk5HPXkNCj4gwqBDT05GSUdfRE1fU0VSSUFMPXkNCj4gwqBDT05GSUdfTVhDX1VBUlQ9eQ0K
PiANCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwg
NTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWlj
aGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFy
a3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQg
TWFpbnogfCBTdC5Oci4gMjYvNjY1LzAwNjA4LCBERSAxNDkwNTk4NTUNCg==
