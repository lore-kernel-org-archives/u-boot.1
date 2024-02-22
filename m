Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48CEC54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 12:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1E8880A2;
	Thu, 22 Feb 2024 13:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="PjdxOQGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A34880A6; Thu, 22 Feb 2024 13:47:49 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719E088021
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 13:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1708606065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHDQ5DzRROOmKW+SlEimB1AywAnLf0F+bhDdsRm/m2c=;
 b=PjdxOQGBf2fkrk9+EvzAeyHiNS31Fy43tlzsJH5SpSK9G+jpysC/PLpdoO2MHnG3ZjosV1
 e24abe3AxEL6ejOf2vf2lqzaStublhAUD+Mo9nXvHcTUewfAIlutGAQOLnOHfk0BUpWScP
 6ChHPRFuXeB0ib/OKRHK+kmVi3aztVM=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-62-f2I1a1iQO5SpxE-WgIbmOg-2; Thu, 22 Feb 2024 13:47:38 +0100
X-MC-Unique: f2I1a1iQO5SpxE-WgIbmOg-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0961.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Thu, 22 Feb 2024 12:47:34 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 12:47:34 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "lukma@denx.de" <lukma@denx.de>, "aford173@gmail.com"
 <aford173@gmail.com>, "daniel.thompson@linaro.org"
 <daniel.thompson@linaro.org>, "festevam@denx.de" <festevam@denx.de>, Andrejs
 Cainikovs <andrejs.cainikovs@toradex.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "sjg@chromium.org" <sjg@chromium.org>,
 "fathi.boudra@linaro.org" <fathi.boudra@linaro.org>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Thread-Topic: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Thread-Index: AQHaY/5gZYdkB5EVoU6hnE51jmgU4LEUbqAAgAAXnYCAAFcKgIABdZyA
Date: Thu, 22 Feb 2024 12:47:34 +0000
Message-ID: <648e7d9fc85cdb71ca2a44894618549d1dd72d46.camel@toradex.com>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
 <20240221143119.GA9552@francesco-nb>
In-Reply-To: <20240221143119.GA9552@francesco-nb>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0961:EE_
x-ms-office365-filtering-correlation-id: 9b1602cb-cdba-4c46-385b-08dc33a47142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: RlRPRMrdFFYL9malK4sblAgVHsuP3UBlcVF2qj1UY9I7E8n7SVdTlByvzsOiYvAlNUqUe8yUBsL7GlOjCpF1RwzgzfSzWrL16N5g0CPB0vKdLvMQ049FGUypiv5YXrZmiH+i5VOvoc24+t3qPc55f/Dw/s6fmdoEijz1cw1KFXA2MaeCj5xj8DImKDXo5GIms3503Y57cO3ovCBL4J8AVzNRzj5ux0zMZiRjSEqrcy0JPlYC4XvFEHJQs71KsTlxJduSolOoywZlJ+Q2wZIfNDqTwep1ihvz0irxjkA+E6YmEObnIGG9/avb+8pdVDdp+Yxz3OrgnTub6EfhPWs/35PiHLeWt0UMIUzRQFiXCvUpjF9T++SFzgCL8pndKGdjEDn+aNtIoJXX2hsSBCYu9VOhK1XlKW/aJox0YuRRlL9C/odYqKCkZDslra5tKZbfRHRfylRnXQI717iYTMAa1eQsr+76WzcPO2OftUyKYR4YM24VdVe9DWGN5F5/jiW3QKjkzsoerlXoWc7/gNIqaAIayTuvwIE2dJoHacKhRqBMPmyMwvtFa94aHGFKhd2I0oQ72zoThkniSBdeh6yyzequebIpaNVLECYQOGLa0mmix1uBZxzRhEmeGFGYqj2j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBVM3dGK3J2a3ZFVmZOWkhmVllINFhWZys3V0lXdzZ4VWZjQmpEeUlNUTJR?=
 =?utf-8?B?L0c0aXVlVDNxQ3pqWldvdmJYcWZ1dVZOOUlxQ1o2WTZtWm9yUVFHNEtHaEhU?=
 =?utf-8?B?TGI0MjBVRGpZQmlLUDF1amdFR0hObDBET0tIN1UyZTgyUStORFJYazZNd3pk?=
 =?utf-8?B?QTJhdGl1VVhVWk44WXZzenF3ZUQ5ZElWRm5BSkgrTld6SVZBRWoxa0IrOTZN?=
 =?utf-8?B?cHE0YnY1MXRaN3dRbGxUTmswK0cwRFpIQmErSTFRMUJLMHQ3QkhNeTlCOHdl?=
 =?utf-8?B?VnY2dCtvRHBuMkNISForZFhEWVlCRnMvSVphdzZjdHpsZEtWSVF6NWhaRjcz?=
 =?utf-8?B?UFhRVUdNaUlyd2IxRldsNkJrNVBFRnNZM3VZeTlhUzJNOFhGYVVGRWp6NkJa?=
 =?utf-8?B?b3pWdXB2THVsOFdxVy9LeVJDRGM5NVZFZ3ZVZjhldkoramd5TGxiVkxObnNl?=
 =?utf-8?B?dG9xeXphbC9Pb2QxTGM0akJaR0UzU0hQa1JJMVBjNXlRQ1BkeCtiaW1BdkND?=
 =?utf-8?B?NUd0NEpEZVlrRis2MUVHWXBWejZwc0F0VmlqejRPeUVCK0YxSGIvaWJxMXZ3?=
 =?utf-8?B?SW5wclFsY1hiTzc0SHQzeHJ4NEY2U2Y5c2Q2L3U4Q3lBZTJFTFlVK0ZqZFZZ?=
 =?utf-8?B?dTVtM1lYcmVGeEZZZmFqRDdoRnZPZlVmY0oyZmNJU1cycEUxQlllaDg0MDd1?=
 =?utf-8?B?WWNNVWNHMkM5bU5hVU8wU1ZaRlMvcGQ5NnY3T054ZFRFbjY5NW95QzdZZ2wy?=
 =?utf-8?B?NnhzMVBNVzAyS1VIcW1FWSt3L1YzejBRZHVNYUF1amxCSnVORjV1T3ovREM1?=
 =?utf-8?B?TmpOQ2p1Q2sza0R3TFdLTjNtTjF2aG9lOTYxRGh3WnlCVFl2M3ZhenNZQ3NU?=
 =?utf-8?B?MlBUNlRCTkhqcHhDMVQ4KzY0dTAzWXRZL1crUWd2VTJrL2VRZ0gzZEdRWklY?=
 =?utf-8?B?M2pLTnlVUGdzTjB4eDM5NUExeGUwRTRNRG5EdU13MW9aSExtUWxYYU5xWmNu?=
 =?utf-8?B?d0Nsb1F1VXJaZllMM2w0eTVOaXY3WEJYYnBXWlVrRm9TcFYyeWVFQ1hUb2M2?=
 =?utf-8?B?bHN6NU5vZDlJYXN3ZllWbDB4M0VMektxRUEvUkV3cktVTXNFWVhSTU01K0sv?=
 =?utf-8?B?dEhuQmZUTWM0VktXMjF6SktrZk1yUjU5bmRvalN3UkNQU05tSHI2cG56dEFN?=
 =?utf-8?B?cG5iQXRBVEt3SXFUVjMvaTRrSnFEYWRrQkRodFRmYUJxZ242TTlLQTdod3JK?=
 =?utf-8?B?NjZCR0pBaU5HNms5Z0dEM3krUUJidnNqa1JQK1pSL2VQTHBJdmtSSzByckNI?=
 =?utf-8?B?Y0hXbUkyRkNRc3kzeVlPQW9CRmhOdWJ6SEhzVGk4SjJZODBiVU1NNHlubnpQ?=
 =?utf-8?B?YXdGbE9QNlNpRGpIcXAyeWMyM05FK2FOK1UvUGJYOU9VaHpoNktwL3VlQ2pm?=
 =?utf-8?B?dmZPTlRQMkhwZHpIR0NYQVVwdU5PQTJ0aWRVUTEyV3N1STRpWHhMckJ4WjRr?=
 =?utf-8?B?aDY3MElpWEZSa2F4OXkzSUhqWmVyRVZiNms5Lzc0MHI1bk5UMUwxWm9sMTBY?=
 =?utf-8?B?b1ZMT1BFQlgxYzhEQnEwUVRTQ2JzNEF3YXViNjJlOXZPUUlMQno2bDdueUxz?=
 =?utf-8?B?MXVpK0wwM25pd2duZVovSFpZQ3pybXdDdUNUTEZiU0tQbytVQkdZR25hb1RI?=
 =?utf-8?B?b2lxYWFaSTJWNnk5dHJZSVNvV2gyTjd5d2tlMmpBdnZ1S3A1V2syVDR4SnBo?=
 =?utf-8?B?YUtUc1padDF2cWFNNXkrdExqQ0kxSFlBYkhZRTRQVGpiclVGOTVJQk4vOU9J?=
 =?utf-8?B?MG84NHQ3b2V0bzM0cUh6dmR2cUdDQVFUanJVZHVVVk5qUU84WlpFMllMQitm?=
 =?utf-8?B?L1ZobDd2WEJ0YVFoRG5kYWNLekpaWkI1SmVsZy9DK0NQM3Q2bHNRd3hiby9k?=
 =?utf-8?B?bnE2ejM2bDRkVTFxZTUvQnJBSnczTWJoRUFVSVI1OFMxQnAzSDRTdUh0VHVG?=
 =?utf-8?B?ZEc4SnFQRjBWc2J6Q0dNcWJlWkRZUXRvNkl6bGtzbUtsbEw1Z2UzTWVxMUEy?=
 =?utf-8?B?dWdjZlF2UlY5QTd5SzdwbDc4ODRTM3BaOGppNFZ2YmdpY01wdThKTFRaN0Ew?=
 =?utf-8?B?REdLdGtrN2c4UGFxSkZ2YnpPdkJySzdmVUFIREVRVDNDRTVqa3JnRk05Q0hM?=
 =?utf-8?B?S0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1602cb-cdba-4c46-385b-08dc33a47142
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 12:47:34.7494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LY4KybVjALG6Epy17gH8Lu4nKFzPRevYzmcq42XEq+Qs1fZajq14VYzz+Lr9jRLO95CrbTh7/Sq1UeLHqt8ic3qByDQ/yQ/cMiinvdJy2Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0961
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <CFF60CA58D57AD43AA21AEAC75745422@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDE1OjMxICswMTAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gT24gV2VkLCBGZWIgMjEsIDIwMjQgYXQgMDk6MTg6NTFBTSArMDAwMCwgTWFyY2VsIFpp
c3dpbGVyIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wMi0yMSBhdCAwODo1NSArMDEwMCwgRnJh
bmNlc2NvIERvbGNpbmkgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEZlYiAyMCwgMjAyNCBhdCAwNjo0
MDo1NlBNICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiA+ID4gPiBBbHNvLCBlbmFibGUgcmVz
ZXQgZHJpdmVyIHdoaWNoIGlzIGEgcHJlcmVxdWlzaXRlIGZvciBQQ0llIHN1cHBvcnQuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFy
by5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGNvbmZpZ3MvdmVyZGluLWlteDhtcF9kZWZj
b25maWcgfCA5ICsrKysrKysrKw0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9jb25maWdzL3ZlcmRpbi1pbXg4
bXBfZGVmY29uZmlnIGIvY29uZmlncy92ZXJkaW4taW14OG1wX2RlZmNvbmZpZw0KPiA+ID4gPiBp
bmRleCAyMmI4YTMzNGRmYS4uZDhiZDY0NDMyMmIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2NvbmZp
Z3MvdmVyZGluLWlteDhtcF9kZWZjb25maWcNCj4gPiA+ID4gKysrIGIvY29uZmlncy92ZXJkaW4t
aW14OG1wX2RlZmNvbmZpZw0KPiA+ID4gPiBAQCAtMTg1LDMgKzE4NSwxMiBAQCBDT05GSUdfVVNC
X0dBREdFVF9WRU5ET1JfTlVNPTB4MWI2Nw0KPiA+ID4gPiDCoENPTkZJR19VU0JfR0FER0VUX1BS
T0RVQ1RfTlVNPTB4NDAwMA0KPiA+ID4gPiDCoENPTkZJR19JTVhfV0FUQ0hET0c9eQ0KPiA+ID4g
PiDCoENPTkZJR19IRVhEVU1QPXkNCj4gPiA+ID4gK0NPTkZJR19ETV9SRVNFVD15DQo+ID4gPiA+
ICtDT05GSUdfUkVTRVRfSU1YPXkNCj4gPiA+ID4gK0NPTkZJR19QQ0k9eQ0KPiA+ID4gPiArQ09O
RklHX1BDSUVfRFdfSU1YOD15DQo+ID4gPiA+ICtDT05GSUdfUEhZX0lNWDhNX1BDSUU9eQ0KPiA+
ID4gPiArQ09ORklHX0NNRF9QQ0k9eQ0KPiA+ID4gPiArQ09ORklHX05WTUU9eQ0KPiA+ID4gPiAr
Q09ORklHX05WTUVfUENJPXkNCj4gPiA+ID4gK0NPTkZJR19DTURfTlZNRT15DQo+ID4gPiANCj4g
PiA+IFRoaXMgd2lsbCBpbmNyZWFzZSB0aGUgdS1ib290IHByb3BlciBzaXplDQo+ID4gDQo+ID4g
WWVzLCBJIGNoZWNrZWQgYW5kIGl0IGlzIGFjdHVhbGx5IHNsaWdodGx5IG1vcmUgdGhhbiAzMiBL
Lg0KPiA+IA0KPiA+ID4gYW5kIG1hcmdpbmFsbHkgaW5jcmVhc2UgdGhlDQo+ID4gPiBib290IHRp
bWUgKGJlY2F1c2Ugb2YgYSBiaWdnZXIgYmluYXJ5IHRvIGJlIHJlYWQgZnJvbSB0aGUgZU1NQyku
DQo+ID4gDQo+ID4gVGhhdCB3YXMgYWxzbyBteSBjb25jZXJuLg0KPiA+IA0KPiA+ID4gQXBhcnQg
b2YgdGhhdCBkbyB5b3UgZXhwZWN0IGFueSBvdGhlciBpbXBhY3Qgb24gdGhvc2UgY2hhbmdlcz8g
U1BMDQo+ID4gPiBiaW5hcnkgc2l6ZSBzaG91bGQgbm90IGJlIGFmZmVjdGVkLCBjb3JyZWN0Pw0K
PiA+ID4gDQo+ID4gPiBBc2tpbmcgdGhpcyBvdXQgbG91ZGx5IHRvIGNvbmZpcm0gdGhhdCBub3Ro
aW5nIHVuZXhwZWN0ZWQgaXMgZ29pbmcgdG8NCj4gPiA+IGhhcHBlbiBiZWNhdXNlIG9mIHRoZXNl
IGNoYW5nZXMuDQo+ID4gDQo+ID4gT3RoZXIgdGhhbiB0aGF0IEkgYWN0dWFsbHkgZ2F2ZSBpdCBh
IHF1aWNrIHRyeSBhbmQgUENJZS9OVk1lIGRvZXMgaW5kZWVkIHdvcmsgYW5kIHRoZSByZWd1bGFy
IGJvb3QgaXMgbm90DQo+ID4gYWZmZWN0ZWQgKG90aGVyIHRoYW4gdGhlIHNsaWdodCBzaXplIGFu
ZCBib290IHRpbWUgaW5jcmVhc2UsIG9mIGNvdXJzZSkuDQo+ID4gDQo+ID4gPiBGb3IgbXkgY3Vy
aW9zaXR5LCBjYXJlIHRvIHNoYXJlIHdoYXQncyB0aGUgdXNlIGNhc2U/IERvIHlvdSBwbGFuIHRv
IGhhdmUNCj4gPiA+IHRoZSBPUyBzdG9yZWQgaW50byBhbiBOVk1FIGRldmljZT8NCj4gPiANCj4g
PiBGb3IgdXMgdGhlIHF1ZXN0aW9uIGlzIGJhc2ljYWxseSB3aGV0aGVyIHRoYXQgdXNlIGNhc2Ug
ZG9lcyBtYW5kYXRlDQo+ID4gZW5mb3JjaW5nIHN1Y2ggY2hhbmdlcyBmb3IgZWFjaCBhbmQgZXZl
cnkgY3VzdG9tZXIuIFBsdXMgdGhlIHJlZ3VsYXINCj4gPiBleHBlY3RlZCBtYWludGVuYW5jZSBl
ZmZvcnQgYW55IHN1Y2ggY2hhbmdlIGJyaW5ncyB3aXRoIGl0LCBvZiBjb3Vyc2UuDQo+IA0KPiBN
YXJjZWwsIGdpdmVuIGFsbCB5b3Ugd3JvdGUgaGVyZSBJIHdvdWxkIHBlcnNvbmFsbHkgYmUgZmlu
ZQ0KPiBvbiBoYXZpbmcgdGhpcyBlbmFibGVkIGluIHRoZSB2ZXJkaW5faW14OG1wIGRlZmNvbmZp
Zy4NCj4gDQo+IFdoYXQncyB5b3VyIGlkZWE/IEFyZSB5b3UgZ29vZCB3aXRoIGl0Pw0KDQpZZXMs
IEkgZG8gYWdyZWUuDQoNCj4gRnJhbmNlc2NvDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

