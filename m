Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F22A87C9A;
	Wed,  7 Feb 2024 16:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Kpk0odIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1590887CE8; Wed,  7 Feb 2024 16:23:17 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FA08789B
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1707319394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJlU/c212AnjkVabFtY5etT4Jpx+lDhC7rCy2Umww10=;
 b=Kpk0odIe4RCRoB3rPCO9nO9HvUEa1IxnoJTHD+PXdU6bPXzPmcoPIKoV2HIUm9AsYE6bnj
 f9XLjw9TYUpArpzLbszlM4UW+zbnvcetrGrG15yaHyNmkESJXnf37D74Ixr3wsbzuscqm+
 SQGaoC+WUwxIVzEMhKGsyIgf2ks0GZY=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-oE5ZldlbNSmA2m36pSjaDg-1; Wed, 07 Feb 2024 16:23:13 +0100
X-MC-Unique: oE5ZldlbNSmA2m36pSjaDg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.37; Wed, 7 Feb 2024 15:23:11 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb30:77cf:2697:f38c]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb30:77cf:2697:f38c%6]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 15:23:10 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: REGRESSION: [PATCH 5/9] toradex: Use checkboard() instead of
 show_board_info()
Thread-Topic: REGRESSION: [PATCH 5/9] toradex: Use checkboard() instead of
 show_board_info()
Thread-Index: AQHaFd2HGTAr/HJ2/kCx1SfWDLvs2LDppoKAgBXhIoA=
Date: Wed, 7 Feb 2024 15:23:10 +0000
Message-ID: <102745d532a1fffa810160f06592a34eab321b6a.camel@toradex.com>
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-6-sjg@chromium.org>
 <e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com>
In-Reply-To: <e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0800:EE_
x-ms-office365-filtering-correlation-id: 0e4e9a5d-baf6-4f9c-8a5e-08dc27f0b1c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: a4fz1GhSISPu9K0sYrQmW3pTZ/6emKn09sqSNS3FpUWd3LJqKUwe6QT1wt9iuUcvc+XDw1RY42YEaYF7JbXFz8O2zUxg5uyFbKfq2Gomlkq5xLCEoZE3J+6aO2AT8oRQxcVh8GS9trwoJ/cu08rmgbgBnzAdHX5K+osjwaGkuWoBKY0Zk2XJmPjxUu5BChv77ksbs62kUuBP2zrWZNP+vQ1WYlIR8DOTqtbHUt2pvqYyYUilA9+vu4nQXXvqQq5g46+3xKy3ih1mnB+406sXP3fPe8/ME7R83+l+cmxZ/B2paeX0OMQVA1kwLfqq/XHxAlUvICv7UxBXI0WAn/N0LFQL9pKzvyVoU2eu0AlVitpr3hFKzuokBNykR6MUeGqMq2/2cAtBOfcUVTv6kccqMq63NReYczYhMLz8NlfnsjRzE2wSLg0VcumBZwe7lzPV7aDxP9ovEYT6xP6lkN0YVs7Om2HihvczyKheA1mDGdLVpGJpe+K4vlziaUigU1ycXJyhuZYzZ5KVSl8F/1Y27kBaUAEZtqg3Cw6zbMou3jPViL9u4/IeYtCbsdsjUkONlFEUQa9B68vq7tLJv+L06hIOT8rjkpKL8bdn52HjdQEjhuCSm3JkvyLNTEER0fYr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(122000001)(38100700002)(44832011)(5660300002)(2906002)(4001150100001)(478600001)(6506007)(71200400001)(2616005)(26005)(6486002)(6512007)(8676002)(316002)(8936002)(4326008)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700009)(86362001)(36756003)(41300700001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JiU3RPTHE3aUZkaE55V3ZqWTRoNm8wa1U2SE9EL2s1S0xPMGc3L0dtTmtY?=
 =?utf-8?B?K1JHdlpkbUsxYXI4N24zQ2J3ZVFka0dYc3RYZk9iOFJTOGxVdnZyQjg4ZzFE?=
 =?utf-8?B?d09HZUtYV3g4MlpJdnllUll6UDZ6STFoVDlDeGhKRS81eHg3VG1SS2xzeGsx?=
 =?utf-8?B?ODJDajRtamVtREszcVgrMS9MMGpISzlBL21ldUttTGYrMDgzeDZZMWVzemNv?=
 =?utf-8?B?aHprM2JrYVRnVDE0RWZkU3Q1WE9DeENqU0JQN0tsZmwrSmRVTXpHQ1hvWjdB?=
 =?utf-8?B?TWplTUpWaWpCSE5Ic241aWpLTEZXL3cxcG5FOFQwQUkrbDUrWCszTUhhd0pt?=
 =?utf-8?B?dm9nQ3hSb2JrZnB1aVh3QzZaalEwdjVZR09pUXliNWM5YnNyR3hZaDVxV2RO?=
 =?utf-8?B?WnVadVpUc0sxQzlMOTVtajkzU1paUzJuY0RxbUx5TklxSTI0ZzNvV055TDhP?=
 =?utf-8?B?dkJZaEJ2VERhaXA3cWFjaHZUSzlRTkoyWFhOcEFhZE1WcVpRY0tJK2RRcVgv?=
 =?utf-8?B?SmdLeEsrblRzdDlKVXBFTkloaWVRSlZKR29yV1lxR2EvSXY2aVMxRVp1TTUz?=
 =?utf-8?B?dGZMS3FIZVViZWEwRXpHTzM0L0Q2L1k2T1NrM3B4U3NIMUUxenN2MWNIaHpN?=
 =?utf-8?B?MkNtS2xlWGpVT1BIMUNWenVIbUcxSGRmeW01ZDJvL1RGcGE4UnRVZ0RVbXN5?=
 =?utf-8?B?VXVWR0xJTS8rYjRWMzJCcUdLa3Ztd1dab3o4NG42VDk1VTJacHd4ZGJDWmtD?=
 =?utf-8?B?eDRHNDBROXVlekkzSldRa0NqMXltQmJhRXl3ZndXVU5BSzNMZzRpM2JiakFo?=
 =?utf-8?B?UzJQQ1FndG5UUy91OXpWYXZ2UzBVSEN1Z3JuUUtvdDhUTE01U3VxOFZ2OXla?=
 =?utf-8?B?YkVXcDdaS1haSGRYZEdhNDM1SFNIV081bUxjeUxFckhHY1hvYlFuUUdnbWlp?=
 =?utf-8?B?OHovMklOM29JNEhDc05oT0xLcEFzUmNzMTgydmprblA1bWw5T3AzOVYxbEl5?=
 =?utf-8?B?NVdMM01NZU1NQkF2YVpiWXJ1TytYYWJ0aUk2WTQwU1hmcWRLanU5Wm9IS3dp?=
 =?utf-8?B?R2JhV3hTSWFXdkM3N2U4MDczRWZnWVRCcm84NitRbkxOWlZFa29pazZ0cGZn?=
 =?utf-8?B?TlpNUXZJc3NVcExpRTZzN1JjUHYyOEdLc2JXOVExRkFEbk5rdk9hb3djNE9w?=
 =?utf-8?B?bXZSUzBpS1YxTVo0SXFVQkN1RzBTSC90MFR1TzVqYVN5bFM5aFdNQjdOc2Vx?=
 =?utf-8?B?SFJHNWx4R2ZnTHJaY3VGRlFueXJPbFdZZXhPaUY5SzB5WEdINDltWEh0ZGxj?=
 =?utf-8?B?aXFrQm53VkxOUHhrYUZyNitWSE1lSlcxckh6NGFGV2l1bGIvQ21xU0lma0Zq?=
 =?utf-8?B?ejUrbGJSdlVwTWNYejNadnZEU2tpOC9OSEJwc3hYWEVGN2NSTC9sK3VCY1BW?=
 =?utf-8?B?bFdCdVI4UHlVaHlHaENwYVBLVkduNnAzdDA3V2RIRThoOHdrWjBOc1Bjb1Ay?=
 =?utf-8?B?N0xHeWVXeVh3MVlpa0ZrNVhWTTNTeEpINFhzdGZvbERvbG0zMkl6NmlFT09K?=
 =?utf-8?B?NXhkZUV4bCtWNUdkSk9Zb0JJeEg5RlYwQWprVEVKSEVtOEQ2UUJBMXZVVFNy?=
 =?utf-8?B?ZkFMMFNaWnFnN0Z2VjBYajJVQ3BwL0Z0ZEdka3hJeE04TjFmMUpIZm9oYi8v?=
 =?utf-8?B?S2gwazRKVmttZGIrTkxDdEozYUt3V2gzOHF5TUxhTXdPdVVRcmVXRDZ3SEk4?=
 =?utf-8?B?UDRlOXo0dzdtRUhBZ09hd2dqdEN4K0c3RXh2NGpaVGpSZWZ0SjdJWU5zU09y?=
 =?utf-8?B?KzlPWHpaOWprMEhuWGxmYUtPbXdhM3kyYU9CYnU3WlJRZDUxNjlmVERoQWdW?=
 =?utf-8?B?SzAwTkgyZi9TRVVVTUV0NHdTWTh6OWhvd2FGRTlGcFRUK1RkVDVPK0lLK3Bz?=
 =?utf-8?B?WWRYd2Npb3gyVHMxb29JaitKbFlNcFBnSWV4em96RVp4bU5EcVd4L0dscHJa?=
 =?utf-8?B?TWFjbWxRZGpXcnUvY242VWFEUnZCd1NZSi9mK1MvNVBjY0xBSmlqZ29GVmNL?=
 =?utf-8?B?SmRieStXRHNSQ3VCMGUxaGN1WTNwRG4vb1BwVHgvWFBYOHk0bWRLRllXMlgw?=
 =?utf-8?B?eU1rZ0UxQ0ZwT3dEeVpkaVpmUnczUkx0dDBtbDZrekJIdzNpY3JSU1dFZ3Q2?=
 =?utf-8?B?YUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4e9a5d-baf6-4f9c-8a5e-08dc27f0b1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 15:23:10.7840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FKAd/gmaSynA6s9iU52SeQ5YhiCMWyKqqaNGzx9T9yvjP4aV1e6VAzz7spD9EqVzNAsLmKPoVwx+8ZNdjTMVIDGwI0f9yewi2FFDaI++x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D6324564738EC044AE19306CDF5C3F64@CHEP278.PROD.OUTLOOK.COM>
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

R2VudGxlIHBpbmcgb24gdGhpcy4gQW55IG9waW5pb24gb24gdGhhdCBtYXR0ZXIgbXVjaCBhcHBy
ZWNpYXRlZC4gVGhhbmtzIQ0KDQpPbiBXZWQsIDIwMjQtMDEtMjQgYXQgMTg6MTYgKzAxMDAsIE1h
cmNlbCBaaXN3aWxlciB3cm90ZToNCj4gSGkgU2ltb24NCj4gDQo+IFNvcnJ5LCBJIG1pc3NlZCB0
aGlzIG9uZSwgYWxzbyBkdWUgdG8gYSBsb25nZXIgWG1hcy9OZXcgWWVhciBhbmQgbGF0ZXIgc2tp
aW5nIHZhY2F0aW9uLg0KPiANCj4gT24gU3VuLCAyMDIzLTExLTEyIGF0IDE5OjU4IC0wNzAwLCBT
aW1vbiBHbGFzcyB3cm90ZToNCj4gPiBCb2FyZHMgY2FuIHVzZSBhIHN5c2luZm8gZHJpdmVyIGlm
IGEgcGFydGljdWxhciBtb2RlbCBuYW1lIGlzIG5lZWRlZC4NCj4gDQo+IE9rYXksIGJ1dCBzbyBm
YXIgd2UgZGlkIHByaW50IG1vcmUgdGhhbiBqdXN0IGEgbW9kZWwgbmFtZToNCj4gDQo+IE9uIEFw
YWxpcy9Db2xpYnJpOg0KPiANCj4gTW9kZWw6IFRvcmFkZXggMDAyOCBBcGFsaXMgaU1YNlEgMkdC
IElUIFYxLjFEDQo+IFNlcmlhbCM6IDEwODY3NDk5DQo+IA0KPiBPbiBWZXJkaW46DQo+IA0KPiBN
b2RlbDogVG9yYWRleCAwMDU4IFZlcmRpbiBpTVg4TSBQbHVzIFF1YWQgNEdCIFdCIElUIFYxLjFB
DQo+IFNlcmlhbCM6IDE0NzcyOTEzDQo+IENhcnJpZXI6IFRvcmFkZXggRGFobGlhIFYxLjFBLCBT
ZXJpYWwjIDEwODcwMzE2DQo+IA0KPiBPcHRpb25hbGx5IHRoZXJlIHdvdWxkIGV2ZW4gYmUgZGlz
cGxheSBhZGFwdGVycyB3aXRoIHBvdGVudGlhbGx5IG1vcmUgbW9kZWwgKHNlcmlhbCkgaW5mb3Jt
YXRpb24uDQo+IA0KPiBOb3cgd2l0aCB5b3VyIGNoYW5nZSB3ZSBnZXQgdGhlIGZvbGxvd2luZzoN
Cj4gDQo+IE9uIEFwYWxpcy9Db2xpYnJpOg0KPiANCj4gTW9kZWw6IFRvcmFkZXggQXBhbGlzIGlN
WDZRL0QgTW9kdWxlIG9uIEFwYWxpcyBFdmFsdWF0aW9uIEJvYXJkDQo+IE1vZGVsOiBUb3JhZGV4
IEFwYWxpcyBpTVg2IFF1YWQgMkdCIElUDQo+IE1vZGVsOiBUb3JhZGV4IDAwMjggQXBhbGlzIGlN
WDZRIDJHQiBJVCBWMS4xRA0KPiBTZXJpYWwjOiAxMTIxMTA3Mw0KPiANCj4gVGhlIGZpcnN0IGxp
bmUgZ2V0cyBwcmludGVkIGZyb20gdGhlIGluZm9ybWF0aW9uIGluIHRoZSBkZXZpY2UgdHJlZSwg
dGhlIHNlY29uZCBMaW5lIGZyb20gdGhlIGZhbGwtYmFjayBpbg0KPiBvdXINCj4gYm9hcmQgZmls
ZSAod2hpY2ggc28gZmFyIHdhcyBvbmx5IHVzZWQgZm9yIHRoZSBjYXNlIHdoZW4gd2UgZmFpbGVk
IHJlYWRpbmcgdGhlIENvbmZpZ0Jsb2NrKSBhbmQgdGhlIHRoaXJkIGFuZA0KPiBmb3VydGggbGlu
ZXMgYXJlIHRoZSBwcmV2aW91cyBpbmZvcm1hdGlvbi4gVWdseSwgYnV0IHNvIGZhciBzbyBnb29k
Lg0KPiANCj4gT24gVmVyZGluOg0KPiANCj4gTW9kZWw6IFRvcmFkZXggVmVyZGluIGlNWDhNIFBs
dXMgV0Igb24gVmVyZGluIERldmVsb3BtZW50IEJvYXJkDQo+IA0KPiBIZXJlIG9ubHkgdGhlIGRl
dmljZSB0cmVlIGluZm9ybWF0aW9uIGdldHMgcHJpbnRlZCBhbmQgdGhlIENvbmZpZ0Jsb2NrIGlz
IG5vdCBldmVuIHJlYWQgYXQgYWxsIHdoaWNoDQo+IHN1YnNlcXVlbnRseSBmYWlscyBkZXRlY3Rp
bmcgdGhlIHZhcmlhbnQgKGUuZy4gV2ktRmkgdnMuIG5vbi1XaS1GaSkgYW5kIGxhdGVyIEV0aGVy
bmV0IGZhaWxzIGR1ZSB0byBhbg0KPiBpbnZhbGlkDQo+IE1BQyBhZGRyZXNzLiBUaGlzIGRvZXMg
bm90IGxvb2sgZ29vZC4uLg0KPiANCj4gQW55d2F5LCBJIGRvbid0IHByb3Bvc2UgdG8ganVzdCBy
ZXZlcnQgeW91ciB3b3JrIGJ1dCBpbnN0ZWFkIGxvb2tlZCBpbnRvIGNvbnZlcnRpbmcgb3VyIHBy
ZXZpb3VzDQo+IHNob3dfYm9hcmRfaW5mbyAobm93IHRkeF9jaGVja2JvYXJkKSB0byBhIHByb3Bl
ciBzeXNpbmZvIGRyaXZlci4gVGhlIGJhc2ljcyBhY3R1YWxseSB3b3JrZWQgcXVpdGUgc21vb3Ro
bHkNCj4gYnV0DQo+IHdlIHdvdWxkIG5lZWQgbW9yZSB0aGFuIGp1c3QgU1lTSU5GT19JRF9CT0FS
RF9NT0RFTCwganVzdCBsaWtlIHlvdSBkbyB3aXRoIENPTkZJR19TWVNJTkZPX0VYVFJBLiBPZiBj
b3Vyc2UsIEkNCj4gY291bGQganVzdCBkbyBhIENPTkZJR19TWVNJTkZPX1RPUkFERVgsIHdpdGgg
ZS5nLiBTWVNJTkZPX0lEX0JPQVJEX1NFUklBTCBhbmQgb3B0aW9uYWxseQ0KPiBTWVNJTkZPX0lE
X0JPQVJEX0NBUlJJRVIgb3Igc29tZXRoaW5nIGJ1dCBtYXliZSBhIG1vcmUgZ2VuZXJpYyB3YXkg
b2YgZXh0ZW5kaW5nIHN5c2luZm8gd291bGQgbWFrZSBtb3JlDQo+IHNlbnNlLg0KPiANCj4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+IA0KPiA+IFVwZGF0ZSB0aGlzIGJvYXJkIHRvIHVzZSBjaGVja2Jv
YXJkKCkgZGlyZWN0bHksIHJhdGhlciB0aGFuIGhhdmluZyBhDQo+ID4gd2VhayBmdW5jdGlvbiBs
YWlkIG9uIHRvcCBvZiBhIHdlYWsgZnVuY3Rpb24uDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCBhcyBt
ZW50aW9uZWQgYWJvdmUsIHRoaXMgZG9lcyBub3QgcXVpdGUgbGVhZCB0byBhbnkgZGVzaXJlZCBi
ZWhhdmlvdXIuDQo+IA0KPiA+IE1ha2UgYWxsIHRoZSBjaGVja2JvYXJkKCkgZnVuY3Rpb25zIGNh
bGwgdGhlIG5ldyB0ZHhfY2hlY2tib2FyZCgpIHNvDQo+ID4gdGhhdCB0aGUgc2FtZSBpbmZvcm1h
dGlvbiBpcyBkaXNwbGF5ZWQuDQo+IA0KPiBOb3QgcXVpdGUuDQo+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IMKg
Ym9hcmQvdG9yYWRleC9hcGFsaXMtaW14OC9hcGFsaXMtaW14OC5jwqDCoMKgwqDCoMKgwqDCoCB8
IDIgKy0NCj4gPiDCoGJvYXJkL3RvcmFkZXgvYXBhbGlzLXRrMS9hcGFsaXMtdGsxLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gPiDCoGJvYXJkL3RvcmFkZXgvYXBhbGlzX2lteDYvYXBh
bGlzX2lteDYuY8KgwqDCoMKgwqDCoMKgwqAgfCAzICsrLQ0KPiA+IMKgYm9hcmQvdG9yYWRleC9h
cGFsaXNfdDMwL2FwYWxpc190MzAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+IMKg
Ym9hcmQvdG9yYWRleC9jb2xpYnJpLWlteDZ1bGwvY29saWJyaS1pbXg2dWxsLmMgfCAyICstDQo+
ID4gwqBib2FyZC90b3JhZGV4L2NvbGlicmktaW14OHgvY29saWJyaS1pbXg4eC5jwqDCoMKgwqAg
fCAyICstDQo+ID4gwqBib2FyZC90b3JhZGV4L2NvbGlicmlfaW14Ni9jb2xpYnJpX2lteDYuY8Kg
wqDCoMKgwqDCoCB8IDMgKystDQo+ID4gwqBib2FyZC90b3JhZGV4L2NvbGlicmlfaW14Ny9jb2xp
YnJpX2lteDcuY8KgwqDCoMKgwqDCoCB8IDIgKy0NCj4gPiDCoGJvYXJkL3RvcmFkZXgvY29saWJy
aV90MjAvY29saWJyaV90MjAuY8KgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+ID4gwqBib2FyZC90
b3JhZGV4L2NvbGlicmlfdDMwL2NvbGlicmlfdDMwLmPCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0K
PiA+IMKgYm9hcmQvdG9yYWRleC9jb2xpYnJpX3ZmL2NvbGlicmlfdmYuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMiArLQ0KPiA+IMKgYm9hcmQvdG9yYWRleC9jb21tb24vdGR4LWNvbW1vbi5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gPiDCoGJvYXJkL3RvcmFkZXgvY29t
bW9uL3RkeC1jb21tb24uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxICsNCj4gPiDC
oDEzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gW3NuaXBdDQo+IA0KPiANCj4gQ2hlZXJzDQo+IA0KPiBNYXJjZWwNCg==

