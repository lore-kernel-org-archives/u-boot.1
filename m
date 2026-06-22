Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C5BCDB466
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 00:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01F78467F;
	Mon, 22 Jun 2026 02:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Sq31TeJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B1C84832; Mon, 22 Jun 2026 02:32:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E3D842FC
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 02:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcmadn4/Cb1J/0R8wB2UCz2Dg/V8U49BBoxz4+fGjY7m6O40wL+o3tpjWOmL+lnnpiSo845ukJS+GBAyquMIcBAMTwLnGLlfuWKbDHDR7bHLG+z6QxkopRpBCzJBV439Enyd7hRanGlX7/JE1tDTqCuH8sh0vG8qZDPdQcV9ygY4nqKa4Y6ksYGKXx5L6bspaaecAXUm6LZAAlBpjLivu4Crpve2fpnQP98zUwG4Nr5o0Sd3/ZiAwMb3wtENlzj47g3/+oOxrbNx/oMtpCwjSNz4bFB3PjDetRdnYVEZBOKTNUqMrYIv0bE5FumU9wUYnBi7zZj305/dzjfmP6EuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEiI8cEyhdt5W4ydJMFFa8WDFR9QLA12GazkK/aMJ9U=;
 b=kQxDJm6y+uR8bVnvOiP+LoL6NKbq2qIzsimx/5zlj0WZ0xKxesHZBo4wtGFhOtmYgcrm5XYn5lmUC3nCMVsUWLGM23GOCOzP3zUtp4OyTtuYTSKCFLCGlBqZ7zWB3Xht9kZTYWfkZ5evJTh/aiJ8Y5uPqWzW34YE/iu7a6lkrmM/UjzJ1xyc9JjXAb6a4p5RUlonezF2F2cuGslg1c0sEOqlCoB37SSicj8CoyOYX6hZmE9Ly1NZjlk7k4HWxux058QEGWft70RRbkUl4FZK3DR/a3ZEc8IrKm2HFFkKisqE8uRWEA5KWMB1SR7S+v3Ay1IgH+SvwlXqSKImKbkPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEiI8cEyhdt5W4ydJMFFa8WDFR9QLA12GazkK/aMJ9U=;
 b=Sq31TeJcC9NfQ1LV4AKpHQ6aMY7n6lFQ5gUiQ+OnhBT7z72YVc+Wk/Y63gMQYWFu+mQ6cz+Zp6GTrHj7c8UUE0x7T234I1pjNq3XVzs+8NlE3ZhGVpq50jxwVHl2Wgq+ii4UCft7tysONl8KMN7+JLocoq3C6vsTVpamS75C2MP4NWJU6RW+pNg9IOiUXUcJLT6WEPplNV8qD4/5Rfuc7K1XCi7Z0tFm66FoYX4BSojwqiIj/pG09tCeO5jfS02rZ4TJ7bHhTGzxiIeqGnzEQq2AzvvIESjqzZ/8D9bfVOL2MbF8V7MDNkAVmps9byF+8TdJK6qAf9bp9FFEBcx9rQ==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:92::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 00:32:34 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 00:32:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Lukas Timmermann
 <uboot@timmermann.space>, Henrik Grimler <henrik@grimler.se>
Subject: RE: [PATCH v3 0/4] HS400 and HS400ES support for Exynos DW-MMC drivers
Thread-Topic: [PATCH v3 0/4] HS400 and HS400ES support for Exynos DW-MMC
 drivers
Thread-Index: AQHc+whupvyYStq1+0a6nHQJUFHiUbZJUywAgABzhHA=
Date: Mon, 22 Jun 2026 00:32:34 +0000
Message-ID: <MRWPR04MB123303E34B74C6122635666B388EF2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
 <DJEWROG7MD9R.MXZLB9VZ1KGA@disroot.org>
In-Reply-To: <DJEWROG7MD9R.MXZLB9VZ1KGA@disroot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PR3PR04MB7209:EE_
x-ms-office365-filtering-correlation-id: 83409a9e-5dfd-49cd-fcfe-08decff5c0fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|366016|56012099006|11063799006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 9D29nHSkuLRcTFi1YTQWEb4opQwZxoWv6zNZcEkWA26+p92dr/ibKY7XCYESlF5S4ZreUMgb+WLO4RFfU/ZKVD+x7XNcaIEuzBSlAoxRaeXia4FTTx6wc/CYq135zQ+UUlxik8D8SqqehXfM4nq2wDnVeMFW2u6311Bd+54nWg7BiCJCgj0DPDuoHkR9FJklfLnPbqFk5OSYELG6oi/QMo3amfTT5oI8aVpSakR76i1sUkr0O/5VCvhfVLvoRj7H1ctbEDZQtXU4R2UHQUkGwROCQ/QwqdWBl7l3WH8CZvPmUEIkmQlsT/PcgMonB7qBjInmJPTzciR6Vhx3OYBmnNXbLrpoBm6dCd4BmhQj4+NskZqf2hf+syMiqlSC4Pnb2FBiEk3Vka+9tZRLA2av7q6AsJQJFjbN/ycztAh/jddzKu0qARl8txs9+0fv92e1YYZbw9W4TgrXoe0lr6wa03Lx/LMuHCKZmD66PMuIluDslxJ6kKtiUGEJlvPTD0kpx1mx3HecIHIQJUtl0zeUGmtfEegwvdjhZMkJlTJAnY0/nsRD/SxgsZ9aTQomnKIBD8tCrD+BQedu8gBGj9eVF6Y4wtNy9b+Zim05wiLNwahfHKJrDz3v3YlaklSHWhZPCfiC9XpVW6+fh5tXclnFHZj2hV+Zfjd4hUxJov+uOKBlVWifYWjdLyrNRrINraO3wzb6imBDa6ILHfCffKXs437rZKewpoiHNzFOo0hxZzg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0lSOTJBWjA1cXFjMExHempDSWt4T2oyb0tBdENrcm5lQWRTQk1rNklxVE5E?=
 =?utf-8?B?WWlob01xMys3YWxGak9zbkZCQlhabWN3d2x2aU5Fc2VpdjFwRFc2WEE2SVFN?=
 =?utf-8?B?YjVUanR4VkNlTmZkUmdrdXlQMWxYVWFMUkRtRHZQcStkd21HNjRYOXpBVTQr?=
 =?utf-8?B?MG11U0wwUTZnc2l5bXZqcUFvaVhvNHRXNVpjTjhudzgrRDAxME5oRWdkVDR6?=
 =?utf-8?B?RXBST2xwdzhuV084U2dGZWx5M094Q253TXFIc1ZabVFsUE9rNzdFS2h4N0hH?=
 =?utf-8?B?djFUbk03UHl0UXNyOStxTEVaWExkVElWVVZWWVdXQ0taNkd2SklvVGdxSU56?=
 =?utf-8?B?STJnRCtyWXZrVlRKK0NEc0srbkZhOHlTNGlVM1lPNnFtMzAwSDdLRVNvcjF2?=
 =?utf-8?B?QjZZZGFxN2k5cXpQMEFZcWdIUEQwRmQ4S0x6Nlp0T2oxTkE1YjRaVDdVVUdy?=
 =?utf-8?B?a2g2ZVNGWkJFbEF0MGlVUUVhMXFxSlB4aVh2UnRuRXJuaUpRUDNrMGpwT2hz?=
 =?utf-8?B?K25acE04UWViOFQxYmZNejJ5dVdiVUJUaC9yTWEvNGtNa0NSUHhLbVlrNDBz?=
 =?utf-8?B?L212dTFmTkZzZUhVcmtIeU5HUVIyYUd5azU5OWJURE0yeFF6dDBQckdlTGpq?=
 =?utf-8?B?VFphcHFrY3lHTGc1R2E1NTlPdmNscFRWYWtLcnpuRTJVRWNYQUdDdFNDZVp0?=
 =?utf-8?B?a0VSU0hUQUpwekZsbDdBN25yaFhlaW5mSjJCd2VzdnJHcTFSYTdsT2RiLzJG?=
 =?utf-8?B?NGljTHNxUXloSC9CaHNNZzVoTFJiYW53blRSOWx0V3FCVS9WV0Q0Yk1sZHZ1?=
 =?utf-8?B?Q2l2YzZDM3gvOUhVZ254TWZHc3dDWGVKV3lBMzcra1g4ZDk0ZGxUVWMxQVNP?=
 =?utf-8?B?TkJ6WnhHeG8wTkhVZ09jTGNnZzhxSGdKTGI2QmdPbGNIZVpBVUdScTNnbVFF?=
 =?utf-8?B?MGJuNnhLMzVVenp2SVdjbndvQ1Vuc0pWNVdsVDlna2FYV2ZjWVBjVVo4TUtT?=
 =?utf-8?B?RzJOQjBjNjA4V1B4WWgwV0laS3VaenZBTUp6dGdYZ2ZHd3h5c09hVW4vQjN1?=
 =?utf-8?B?Zk4wMXo3U1ZyT1M0dWg0Vm9xbWVvUnBuUVZCdXdwaFhPOC9kd25KZVUyUzNY?=
 =?utf-8?B?SkJsVzYvaGpuNWpaQXhqV05EU0hoRU5OL0ZCU2hUbW5yQzNoODRrZ3EvYjMx?=
 =?utf-8?B?U1Vmd2ZMUUZEMDh5NHplWXNiNXBra3hSeUM5TWlVOHJkejFxZ0F6SzJsTTZk?=
 =?utf-8?B?aDN0NGlvYUpGaVpJS3praDZEMXl3dDRURFRqZmNZOFNES2ptN2lHc0lBWXZn?=
 =?utf-8?B?SUt2WFV4LzZaUXhCYmJWbnRGV00wSEVWUEhhdTQrM1c5R09kcExUVVdqcUtz?=
 =?utf-8?B?UEFrMVhZY1dnUjNTd0Y2aERXT0R6QmhXZjZDMVRrd3FGWVBTRytxT3ZtRXlT?=
 =?utf-8?B?N1YyYkhoZnhjNmVKbXNiY3U5NktUVEdBZ1VMNkVTdG8zc1I0eVFmemNKVG5L?=
 =?utf-8?B?WUdLYXVrcXdIclBPOEMyYnh0Y1QyUENScVd6YSt2TnQ2R2RpeWdUcWlsbjdW?=
 =?utf-8?B?dVUzbE05RXlMRmRNWU1tamliK1BaSFpjVHp2Qnk5S245ekxtNFYyaDF1ME5l?=
 =?utf-8?B?Zi9YRXlBa0R2VGxhTDQ2VnR2d3YrOE9ackFzcmYxYUtDdlFwc2F4dWJ2SGV6?=
 =?utf-8?B?TGk4LzBIdGtnZ1FRdmJsbjhON2lvbFhaS0pZVWIvR09NNjd6eGc4d0tXZ3h0?=
 =?utf-8?B?MDhQbTE5dThHNklObkdDNU9WaVd6ZGFWZmt4VTN1Zmw1TjRUWmM5bHF0aEo3?=
 =?utf-8?B?bFpkOG9ra1UwZGlFZEVrM2pNZkx6RVNKWTBuVUdQaUpRM0FTb1k3bHZ2T0pU?=
 =?utf-8?B?UEhjRnk4WXE4L3E3RjMveDJlN0R1cEd6MUU2TWtTWUJVUDJQV01ieS8rQnhV?=
 =?utf-8?B?Y3hOUy91M044OWFjL1QxQVJKSkNTcjBiNkhVUzZzalhCUjdqeWNud0Y1UExq?=
 =?utf-8?B?ZnRzbU04TkgzQVpIQ2J0V0h2UisvOHFVQWJBQ0VrcStUNWVScUxyRkJYMVUx?=
 =?utf-8?B?dWtleFJWdXVXMlkrSFR3OU5oZ3AyS2VoUm5YK1dpc3lCTEdRc2xvQ3BLY1Bo?=
 =?utf-8?B?R1BLTU94dUxwVmUyT2pIaGkwYjM2dng2dXhjNzBPNWU4K0NWajJQbzhuT1hE?=
 =?utf-8?B?T1J5c3Y5bDY1Q2k2ekNsQmVlQkZTUlk3eEplZ3NyVGNMSGJlZkh6SzJ0WFly?=
 =?utf-8?B?ZklrR3N4b0M2d1NrakxndnQ0bHBXVEFVcXFJeHhjN1ljUHFIN1B4cElrV2Er?=
 =?utf-8?Q?U2c679odrjxFPWkCOJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83409a9e-5dfd-49cd-fcfe-08decff5c0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 00:32:34.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hJfjIZMin8/bCwIy+Vl8QUAzdSmytI2jfbUI3gnBkezXyDVlG6wQHjkeYCiPF+a+QKkLAdDGEJ9yaul9t1XUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNF0gSFM0MDAgYW5kIEhTNDAwRVMgc3VwcG9ydCBm
b3IgRXh5bm9zDQo+IERXLU1NQyBkcml2ZXJzDQo+IA0KPiBPbiAyMDI2LTA2LTEzIDEzOjEzICsw
NTozMCwgS2F1c3RhYmggQ2hha3JhYm9ydHkgd3JvdGU6DQo+ID4gU2luY2UgdXBzdHJlYW0gZHRz
IHZlcnNpb24gdjcuMCssIEV4eW5vcyA3ODcwIGRldmljZXMgaGF2ZSBhbg0KPiBleHBsaWNpdA0K
PiA+IGBidXMtd2lkdGggPSA8OD5gIHByb3BlcnR5LiBUaGlzIHJlc3VsdHMgaW4gdGhlIFUtQm9v
dCBkcml2ZXIgdHJ5aW5nDQo+ID4gdG8gaW5pdGlhbGl6ZSB0aGUgSFM0MDAgbW9kZSwgd2hpY2gg
YXBwZWFycyB0byBmYWlsLiBUaGUgSFM0MDANCj4gc3VwcG9ydA0KPiA+IGFkZGVkIGluIHRoZSBE
Vy1NTUMgRXh5bm9zIGRyaXZlciBhcHBlYXJzIHRvIGhhdmUgYW4gaW5jb21wbGV0ZQ0KPiBpbml0
DQo+ID4gc2VxdWVuY2UuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHRoZSBtaXNz
aW5nIHBpZWNlcyB0byBlbmFibGUgSFM0MDAgc3VwcG9ydCwNCj4gYW5kDQo+ID4gYWRkaXRpb25h
bGx5IGFkZHMgc3VwcG9ydCBmb3IgSFM0MDBFUyB0b28uDQo+ID4NCj4gPiBUaGUgbGFzdCBwYXRj
aCBpbiB0aGUgc2VyaWVzIGFsc28gZW5hYmxlcyBIUzQwMEVTIHN1cHBvcnQgaW4gdGhlDQo+ID4g
ZXh5bm9zLW1vYmlsZSBkZWZjb25maWcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXVzdGFi
aCBDaGFrcmFib3J0eSA8a2F1c2NobHVzc0BkaXNyb290Lm9yZz4NCj4gDQo+IEp1c3QgYSBidW1w
OyBmYWlsdXJlIHRvIHB1bGwgdGhpcyBzZXJpZXMgd291bGQgcmVuZGVyIHVwc3RyZWFtIHN0YWJs
ZSBVLQ0KPiBCb290IHYyMDI2LjA3IG9uIHRoZSBTYW1zdW5nIEdhbGF4eSBKNyBQcmltZSAoc2Ft
c3VuZy1vbjd4ZWx0ZSkNCj4gdW5hYmxlIHRvIGxvYWQgYW55IG9wZXJhdGluZyBzeXN0ZW0gZHVl
IHRvIGxhY2sgb2YgYSBzdG9yYWdlIGRldmljZS4NCj4gDQo+IEFzIG9mIHlldCBJIGRvIG5vdCBz
ZWUgdGhlIHNlcmllcyBpbiBtYXN0ZXIsIG5leHQsIG5vciBpbiB0aGUgTU1DDQo+IEN1c3RvZGlh
biB0cmVlLg0KDQpJIHNlZSB0aGlzIHBhdGNoc2V0IHdhcyBkZWxlZ2F0ZWQgdG8gcHJvbSwgbm90
IG1tYyBtYWludGFpbmVyLg0KTWlua3l1IG1heSBwaWNrIGl0IHVwPw0KDQpodHRwczovL3BhdGNo
d29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvbGlzdC8/c3VibWl0dGVyPTg4Njk4JnBhcmFt
PXN0YXRlJm9yZGVyPXN1Ym1pdHRlcg0KDQpSZWdhcmRzDQpQZW5nDQo=
