Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92477C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 07:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9B7876DD;
	Mon, 15 Jan 2024 08:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="KSHdqwBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB60E87708; Mon, 15 Jan 2024 08:29:18 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE47876FA
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 08:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1705303754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xW9P/GtDh1yjoI+9zPjsmbMMjBs9DENObfYh3tv4KY=;
 b=KSHdqwBcTirAU7l7JhLxP27E/rrGNnUy4HkqNCHNr6iywxQmU5liwwj5ypuZi8nuYiAbQO
 JjQjGaqZVfilTbN3Urb2wM7o/qpVSSE0F4G7dV35muknL0mEhLDoIXKru/EENx+kQZ43Vk
 nq4aBecLvBZViq+kF5r3innE/zL72JA=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-ouG45K6JOX2agbAxKJYX2w-1; Mon, 15 Jan 2024 08:29:12 +0100
X-MC-Unique: ouG45K6JOX2agbAxKJYX2w-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0951.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:52::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.26; Mon, 15 Jan 2024 07:29:10 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 07:29:10 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "festevam@gmail.com"
 <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Thread-Topic: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Thread-Index: AQHaRmF/BewvNZ4GFEuONQZhYzn777DafIMA
Date: Mon, 15 Jan 2024 07:29:09 +0000
Message-ID: <3c06a1bcc9fe02989972e1f84c843ef59788fb9d.camel@toradex.com>
References: <20240113204542.GA3000@francesco-nb>
In-Reply-To: <20240113204542.GA3000@francesco-nb>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0951:EE_
x-ms-office365-filtering-correlation-id: 038483f8-f420-4549-7b74-08dc159baa3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: gO5GFszsHmcK0Rh4rWKChz8dLGJhNXOzW08JG04CH0ob59KXy8KLYkafGJjkOuP/aPCdGOCkv1z0MAW/oUXOLnFOHvJPhMawHLn5tqwnfCaj4cagKD4rwFSfuZXPRN+LZdEbyGbpsl08g14Zh35qiJQoX9ehlah1vT6rh5FJbC9wFL4Ggp5plvagR+WdB95ZDr+B5JcvTxXOg+UxSthHjA8+zbHoSnrkRbWVFJxvNOGqF6Z3Tw3ShgQuWjgtaq4kS6d8w4yV5xt++VOn23yV3h8paW7nau21LsGHVkHT/rX7xqJjvWlJMLFR5pa5rCLNQaZNUjWcwM7MFxBOcZ4Oz4tlNRyJINGM4hVrTWEqWI4ho7MsYZ7LmLxKb3Uvm7oBh2+qBESB6bwqXgfIi3L7sAFmLTmBDM5rj3uJWNJWOv3IUz/vrx8ZoDj8hxaSTiK1INQVALgh6um5NWFi45vdV+JR7l8d0oLZ47XtL1koAzs8DbKpB/IjP9227aPZu6jqdT49Zk8LIo/bmzR62KohqnZQvR4bI9jFVRnvCC2UB9/LJnuID/0Uh3senhEdXzwhtX+/l0v1lvtav/xxLXT3Vv5ktJDBQA7Zj0h26XBGX6458gLdpdF/HlK5qCpWmAOr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39840400004)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6512007)(2616005)(107886003)(122000001)(38100700002)(44832011)(4326008)(8676002)(5660300002)(2906002)(8936002)(6486002)(478600001)(6506007)(53546011)(71200400001)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(41300700001)(76116006)(91956017)(38070700009)(36756003)(86362001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0hCemlKUGpueERoUjVGVHZXUExZKzR2QzhBTmpldDlxQmRFZWVUVFY2ZEM3?=
 =?utf-8?B?bk5qdE9aR3JIR0JUWGZWaWxIQkJxMkdRQXN6QmtpcDRpKy9YbUhrUFVQOEZh?=
 =?utf-8?B?TlZHcmNyZnRxRE5MTUxEQzFtdWZZY1JRSTVOUlEvL1hqSFRJWXMwcEJmZ0VU?=
 =?utf-8?B?dG9sckVhcGNTNENZNms5bU1TbjgrMmdIOHF4clB1U0RVZTFpNXU3ZlZ0dUN6?=
 =?utf-8?B?dDFFc21EU0VLMGtOUFhQMkVVUzdEdnZwNlVBS2VyM2ZhSzB3U2tQdGgydk5M?=
 =?utf-8?B?dDRnNkR5QnRQZkU0WnlFMTA4dnc4dXdoWmtyTmJHcUtHRHBINWgxYUptZ2sw?=
 =?utf-8?B?d0VYZG1EeU5JOURXUlpkeEVENWNraGIwOGJvY3hoZWRSK1VPcXBNWHlzQVQr?=
 =?utf-8?B?YW1qNGoxVjdXajRqR0w0MHBSdlpvTGMrTmYzWWlqWmRHRmhQaUVIVHB5bkFM?=
 =?utf-8?B?SWhEcnZSdEJkNi85M0dyWkpCanl2SE5SRlIrdTdaUWtGaHBjdkZ2Y2s0Mmk3?=
 =?utf-8?B?bTh6MG5sL1NyQ1JLaHFWOVNoQXZXQ2lzVHo0NjNOMDN0UVlmNW05SmhQQ3pJ?=
 =?utf-8?B?aXBlOCthSHVjN0k0MmpiUGRxZ2JQZWcrOWhTLzQ4ckxTM1BZdkJ5OVFXcGxp?=
 =?utf-8?B?SlFSYmM2UGE4SC9jRDBTQXZYZTgzVFlCRnVPSmtmM0pCaXUyMldDMytGWG1y?=
 =?utf-8?B?MEV3b0I4RHRIYzF3UmVQS2dDY01nK2hpTVQxdXk5bjdWNkRMTDRZekwvZEQv?=
 =?utf-8?B?a1ZiblY4Zy8xMXZ6T1huUXlpZDA3SVo2RjhVN0NJbEdKUUdUVlUwY1lrY09z?=
 =?utf-8?B?WG1jTzg5V1V3SUx5b0dGZHJRcElXK0RwekhXNHMrSjNKS3BUeFlWSHN4eTVE?=
 =?utf-8?B?ang0SDNmVm1qUUtDSnlHV3VST3NtTXhJZnpSTGM1akg3ZWNpSTBtbXFOZXgy?=
 =?utf-8?B?eXVyUHp1TnRuak1SSndreExCUEo0Z041cnZPK0M5bEY4VFJlSkQwaW5vQkZN?=
 =?utf-8?B?Y1VMUGNyWVB4QW9pSGtnU29GK2VEZGVFdGhNNUNlaXFVWE5ibi9ZenNxRjRl?=
 =?utf-8?B?N2I3QUxoZWlldzhZaE9IZVpield1V3J0N2NCMmp5Qi93MlFpekhLRERvRG0v?=
 =?utf-8?B?M1h2Qm1ucERHT3lCK0J3RXNzTDdBZ09QN1AwVk5BSkhvVVdKK2UyL3pLK2JE?=
 =?utf-8?B?S241ODMrdnZaWDc1WHk0NVhUMldYdCtSQjYyWWVrQVJpUVlQVTBRN0padDQz?=
 =?utf-8?B?b2dBV2NOenBFbkpYZVRVOUZkM2gyNFdTSFp5a29xclV3UXQ3MUpmNFM4bzht?=
 =?utf-8?B?UTcyQ2VVUG9oUzZET1RqREpwT3FwbHVPSGp2cFBZSHJ1WmJaRVhmUm5iaHYx?=
 =?utf-8?B?dTE0Z3VQWjZWNjVDOUFaSHVmYUVCRWhIYTd2NmhpTE9QajJEWXdsY1ovQ0gv?=
 =?utf-8?B?ekRQZ3pCMk92T01VWll1bjVTcEF0bUdJTWY4cldnSE5yd1dLZjBUYzFMS2wx?=
 =?utf-8?B?NVBteHloVXBSQXFpR3hBaTlYcUVPWGJMdnR0ZHBFcmxUaUhNVUNDV1pQdG9z?=
 =?utf-8?B?UXB3L3JUZjVUNnRUeTQ0b2FJazgvdmpiakRxVy9Sb2tocFlpeVhrWlhEQS81?=
 =?utf-8?B?RGxCWWw0TWFGSmduWUptbEJualJERkJZcFM4bWtyZUV1TFBudXVsdHBCNlFa?=
 =?utf-8?B?dnBoYWJsMHlqbElWMDFMUGJGdjhpODY4Z0sydDJXQVdzM0VJZTRrRmlFanZl?=
 =?utf-8?B?QTRUZkMvcjR3Y1lJL09JM1NEVkRLU3E3YWkwdEd0Y2c1cjJ1TmhrcUlYUlM2?=
 =?utf-8?B?R1B3M05tS1hDek4rU1VLZTJXYUo3dmdRTHg0Y2cxRU5oZGVtYWZ4MVNuenNG?=
 =?utf-8?B?c0pVM1VDR2NmVnRQaDJCSmYwOWhHNXNMdktEdHpJV0FwM242Tk4zYXJQVVpB?=
 =?utf-8?B?NlkwRDY3aG9ZVWlkRFpMUVN6dDVuUGlTZnRZYjZocnBrMWlFdTViSDQ2ZGNo?=
 =?utf-8?B?WE4vQnJyT2ZjdHF0Z3M2YVM1NzBiMWVkZGZsRllZOFg5UXc2cjd4TW9PZzQ0?=
 =?utf-8?B?V1EzbEVWeXJERU9SaVczdGU2UFVYL3hLdWlkSUY3YkZSaGJQN2p2VUJTbWpN?=
 =?utf-8?B?Y0RpTFN6OVliZzRqMWtZYmNPQkcrU0poQ2tnRmQzTElvcDNjQVhCamUyZHg4?=
 =?utf-8?B?SnRWUHZSSDlSM3dVQ2w5Y3JzYS9Ea3VtdGtTTE5CakpRbmp6aTJyak4weEtq?=
 =?utf-8?Q?r1kslt5HieloXYUnHtwIbmgK3OxHmsAy4IPUPBe43c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 038483f8-f420-4549-7b74-08dc159baa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 07:29:09.9661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3Bwx8B5nZQDSXnJX4kHDFxpoo7hNgm/b+HPoKvkmJh0A6BFhNR94WHqrI/WL17oeDCNEaHRcNto3JlvyM+QtU0+OhalD3nLRvPLVwDv3M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0951
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <19E2A6978470784BB9F7CCBBFB74AA14@CHEP278.PROD.OUTLOOK.COM>
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

SGkgR3V5cw0KDQpPbiBTYXQsIDIwMjQtMDEtMTMgYXQgMjE6NDUgKzAxMDAsIEZyYW5jZXNjbyBE
b2xjaW5pIHdyb3RlOg0KPiBPbiBTYXQsIEphbiAxMywgMjAyNCBhdCAwNjo0MDoxOVBNICswMDAw
LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gSGkgTWFyZWsNCj4gPiANCj4gPiBUaGFua3Ms
IHNlZW1zIGxpa2UgYSBkZWNlbnQgaWRlYS4gSSBndWVzcyB3ZSBqdXN0IGRpZCBub3QgZG8gaXQg
YXMgdGhvc2UgcHJldmlvdXMgcmV2aXNpb25zIHdlcmUganVzdA0KPiA+IHNhbXBsZXMNCj4gPiBi
dXQgd2l0aCB0aGlzIGNoYW5nZSBjYW4gc3RpbGwgYmUgdXNlZCBtdWNoIGVhc2llciAoZS5nLiB3
aXRob3V0IHJlcXVpcmluZyBtYW51YWwgaW50ZXJ2ZW50aW9uKS4NCj4gPiANCj4gPiBPbiBTYXQs
IDIwMjQtMDEtMTMgYXQgMTk6MzMgKzAxMDAsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiA+ID4gVGhl
IG9sZGVyIGkuTVg4TSBNaW5pIFZlcmRpbiBTb01zIGJlZm9yZSByZXYuIDEuMUMgY2FtZSB3aXRo
IDIwIE1IeiBTUEkgQ0FODQo+ID4gPiBjb250cm9sbGVyIG9zY2lsbGF0b3IsIHRoZSBuZXdlciBT
b01zIHVzZSA0MCBNSHogb3NjaWxsYXRvci4gSGFuZGxlIGJvdGggYnkNCj4gPiA+IG92ZXJyaWRp
bmcgdGhlIG9zY2lsbGF0b3IgZnJlcXVlbmN5IGp1c3QgYmVmb3JlIGJvb3RpbmcgdGhlIGtlcm5l
bC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbngu
ZGU+DQo+ID4gPiAtLS0NCj4gPiA+IENjOiAiTlhQIGkuTVggVS1Cb290IFRlYW0iIDx1Ym9vdC1p
bXhAbnhwLmNvbT4NCj4gPiA+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
DQo+ID4gPiBDYzogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXgu
Y29tPg0KPiA+ID4gQ2M6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXgu
Y29tPg0KPiA+ID4gQ2M6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3Jh
ZGV4LmNvbT4NCj4gPiA+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT4NCj4gPiAN
Cj4gPiBBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5j
b20+DQo+IA0KPiBNYXJjZWwsIHRoYXQgcGF0Y2ggaXMgYnVnZ3kuDQo+IA0KPiBUaGUgYXNzZW1i
bHkgdmVyc2lvbiBtYWtlcyBzZW5zZSBvbmx5IGZvciBhIHNwZWNpZmljIG1ham9yL21pbm9yDQo+
IGhhcmR3YXJlIHZlcnNpb24uDQoNClllcywgc29ycnksIEkgZGlkIG5vdCBsb29rIGF0IGl0IGNh
cmVmdWwgZW5vdWdoLg0KDQo+IFNvIHdoYXQgeW91IG5lZWQgdG8gY2hlY2sgaWYgcmV2aXNpb24g
PCAxLjFDLCB3aGlsZSB0aGUgY29kZSBmcm9tIE1hcmVrDQo+IGNoZWNrIGp1c3QgZm9yIHRoZSBh
c3NlbWJseSB2ZXJzaW9uIEMuDQo+IA0KPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiDCoGJvYXJkL3Rv
cmFkZXgvdmVyZGluLWlteDhtbS92ZXJkaW4taW14OG1tLmMgfCAxOSArKysrKysrKysrKysrKysr
KysrDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9ib2FyZC90b3JhZGV4L3ZlcmRpbi1pbXg4bW0vdmVyZGluLWlteDht
bS5jIGIvYm9hcmQvdG9yYWRleC92ZXJkaW4taW14OG1tL3ZlcmRpbi1pbXg4bW0uYw0KPiA+ID4g
aW5kZXggYjI3ODFiNTFkNmEuLjhiYzFhNTFlZWIxIDEwMDY0NA0KPiA+ID4gLS0tIGEvYm9hcmQv
dG9yYWRleC92ZXJkaW4taW14OG1tL3ZlcmRpbi1pbXg4bW0uYw0KPiA+ID4gKysrIGIvYm9hcmQv
dG9yYWRleC92ZXJkaW4taW14OG1tL3ZlcmRpbi1pbXg4bW0uYw0KPiA+ID4gQEAgLTE0Miw2ICsx
NDIsMjUgQEAgaW50IGJvYXJkX3BoeXNfc2RyYW1fc2l6ZShwaHlzX3NpemVfdCAqc2l6ZSkNCj4g
PiA+IMKgI2lmIGRlZmluZWQoQ09ORklHX09GX0xJQkZEVCkgJiYgZGVmaW5lZChDT05GSUdfT0Zf
Qk9BUkRfU0VUVVApDQo+ID4gPiDCoGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpibG9iLCBzdHJ1
Y3QgYmRfaW5mbyAqYmQpDQo+ID4gPiDCoHsNCj4gPiA+ICsJY29uc3QgY2hhciAqY2Fub3NjcGF0
aCA9ICIvb3NjaWxsYXRvciI7DQo+ID4gPiArCWludCBjYW5vc2NvZmYsIGZyZXEsIHJldDsNCj4g
PiA+ICsNCj4gPiA+ICsJY2Fub3Njb2ZmID0gZmR0X3BhdGhfb2Zmc2V0KGJsb2IsIGNhbm9zY3Bh
dGgpOw0KPiA+ID4gKwlpZiAoY2Fub3Njb2ZmIDwgMCkJLyogTm8gQ0FOIG9zY2lsbGF0b3IgZm91
bmQuICovDQo+ID4gPiArCQlnb3RvIGV4aXQ7DQo+ID4gPiArDQo+ID4gPiArCWlmICh0ZHhfaHdf
dGFnLnZlcl9hc3NlbWJseSA8IDIpwqDCoMKgwqDCoMKgwqAgLyogcmV2LiBBIG9yIEIgKi8NCj4g
SSB3b3VsZCBzdWdnZXN0IGEgc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoLg0KPiANCj4gRmly
c3QgeW91IG5lZWQgdG8gY2hlY2sgYWxzbyBmb3IgbWFqb3IvbWlub3IgdmVyc2lvbi4gVGhlIHJl
dmlzaW9uDQo+IHJlc3RhcnQgZnJvbSBBIGV2ZXJ5IHRpbWUgdGhlcmUgaXMgYSBjaGFuZ2UgaW4g
YSB2ZXJzaW9uLg0KPiANCj4gU2Vjb25kIEkgd291bGQgc2V0IHRoZSAyME1IeiBvc2NpbGxhdG9y
IG9ubHkgZm9yIG9sZGVyIHZlcnNpb24gYW5kIGRvDQo+IG5vdGhpbmcsIG5vdCBzZXQgYW55dGhp
bmcsIGZvciB0aGUgbmV3ZXIgb25lLg0KDQpZZXMsIEkgYWdyZWUuIFNvIHdvcnN0IGNhc2UgaXQg
d2lsbCBhbHdheXMgdXNlIHRoZSBuZXcvZml4ZWQgc2V0dGluZy4NCg0KPiBPbiBTYXQsIEphbiAx
MywgMjAyNCBhdCAwNDo1Mjo1N1BNIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPiA+IE9u
IFNhdCwgSmFuIDEzLCAyMDI0IGF0IDM6MzTigK9QTSBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IFRoZSBvbGRlciBpLk1YOE0gTWluaSBWZXJkaW4gU29N
cyBiZWZvcmUgcmV2LiAxLjFDIGNhbWUgd2l0aCAyMCBNSHogU1BJIENBTg0KPiA+ID4gY29udHJv
bGxlciBvc2NpbGxhdG9yLCB0aGUgbmV3ZXIgU29NcyB1c2UgNDAgTUh6IG9zY2lsbGF0b3IuIEhh
bmRsZSBib3RoIGJ5DQo+ID4gPiBvdmVycmlkaW5nIHRoZSBvc2NpbGxhdG9yIGZyZXF1ZW5jeSBq
dXN0IGJlZm9yZSBib290aW5nIHRoZSBrZXJuZWwuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+IA0KPiA+IEFwcGxpZWQsIHRoYW5r
cy4NCj4gDQo+IEZhYmlvLCB5b3Ugd2VyZSB0b28gZmFzdCAuLi4gcGxlYXNlIHJldmVydCBpdC4N
Cj4gDQo+IEZyYW5jZXNjbw0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

