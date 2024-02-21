Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6084DC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 09:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4516787E2A;
	Wed, 21 Feb 2024 10:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="ZY1xpuoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926C387E2C; Wed, 21 Feb 2024 10:19:17 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A03D87E2A
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 10:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1708507144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbvO/FieuWnQQblyeGohAj9YAKUFLN2TTJ6H8AEVnYI=;
 b=ZY1xpuoGZ/gW4VhO2Vc/fGHS7yhizObHl9Of/5lPQXsMFBA3uFdZWjceL4FEpnO2qkDSOP
 yCo9LTyHz4L5KJhYXjezYyD4ebzyDAe0F2b+bK9mWseCO3MpOdwVCPTPkF2/Cz1jg1Dy6Z
 QeIGtMbJiiEjEenTAuX5sDTedehPsP0=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-67-1XniFH1gOQiuT4mmbuKtKw-2; Wed, 21 Feb 2024 10:18:59 +0100
X-MC-Unique: 1XniFH1gOQiuT4mmbuKtKw-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB1025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Wed, 21 Feb 2024 09:18:51 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 09:18:51 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "lukma@denx.de"
 <lukma@denx.de>, "aford173@gmail.com" <aford173@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "festevam@denx.de"
 <festevam@denx.de>, Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "fathi.boudra@linaro.org"
 <fathi.boudra@linaro.org>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Thread-Topic: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Thread-Index: AQHaY/5gZYdkB5EVoU6hnE51jmgU4LEUbqAAgAAXnYA=
Date: Wed, 21 Feb 2024 09:18:51 +0000
Message-ID: <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
In-Reply-To: <20240221075516.GA5131@francesco-nb>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB1025:EE_
x-ms-office365-filtering-correlation-id: 52b9dec5-55b4-4ebe-5d0e-08dc32be1e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: iFRHP+dGGgW3d+MpGkPjX9gQQAbQJWQXc9dTbQX6yzdOD5+N3hDbw2R7JrSKD7XBHiF1brQSfSTk1qZOs6OK6eR4qwtW7xiiIZVAQ/LGyDxK4pax3nQRiBdnAm509DOCPWM4+WSlycB3KAxSRHNwDikhnfhcUTxkDr5/qdJ4FevP5soa+rm5SbOej/DfJvNyec68+SaeaXn++Adc3lC7RRksLFNoTMMW6miv9464tW6kJ4ksugupIg9DJLNed+Sj5OnjpYI0rlg3skfO+ZH7wgYw5pvksQ156XdL/l+A18qv4kb9bFjI52fb5Q9RZwXkfA9izLhiFYKnJYJY1PEhPTMCUkN6LlVRz7de9PRACgti9rYnswEKbL06RW5XUeS9vdy/uWxdpbFdl5mStmTpkKtssmI4TbCaoRhFtEhWBBiXeGh+FhP5qe1gA+MCp8A/nUEoGpPMx5VWjVdt7Z80Y1ApEHOSnXWACjXjNbsUsH0vPpUpf9cftO5xrpXCp+oKMioZQ3zbQck8OXO0YONTCIgBjhnQytpOLiHMeG1zhlBDyTtzzfyNwCwFuR+jqGB4MlBZIQvLFSs+H2csa6GxOlG3LmG23XTZ0GVPqvZmf8+dcbjcQHWzs/nlKhudmtpJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1JIZ1lpVHRRMnlVOU9aUkFjYm11aHdDcEE3UmRxM212SDZxam9vK2R2TzRs?=
 =?utf-8?B?aE03SjZrb2p2dTBUWW1KYnNxMTlJQVR2cDcyNFZienVWYkFiRkd6Y2ZhbDJM?=
 =?utf-8?B?cldTWitEMEduUUV1OU9LU1BNYUJaZVY4VkZQcEg2dStCWEoxZm1PTWFmOTJU?=
 =?utf-8?B?Z0l1QnJZQlplMTZ6dGdRTURCNGR5V2JNOFNvTzRKdjBuUGFrT1duRWZIRmpL?=
 =?utf-8?B?VENpaEFBS3YxRjNZMlBmMjZtTEUvTFFzT2ZGaUpoM1B4clBBWTVFNjNTQkhI?=
 =?utf-8?B?V2YzMW81MTY0em1ycjFyV1cyMHRtNVU0QVJiMnpJTytPQkVGL2FFV2YzYmhU?=
 =?utf-8?B?NWxIdVhIUEk1NUtiMWdjcmNKeVBiUUNTUVFYdjFoUzFuUGtrekZRS1ZZSU80?=
 =?utf-8?B?TGY3dkFEWW5MZ3Q2bU1LUThWMTlBV2NoTVpra08yd0QycGF6eTF4NFhucmZm?=
 =?utf-8?B?aExOZ3lIVGRZa3FBTTd0ZnVBbEVqNlhHTVR5Si8xckhma3VsSXhPOGRnVkVR?=
 =?utf-8?B?SmRYRzh6Q20xajRYZEZMS2YzUG1GRXV6UHJkOUN1NUhvNHlkVkVCa0NzVHhD?=
 =?utf-8?B?dXhXcW41NWF4b0pLdElQZUVhQ2s2RHMwUklmcEZGZWE1WjFHLy9oWDIxUEcr?=
 =?utf-8?B?RWJtK2w5aEhrQmxXMk9RVTljck9FdkFLa3FpQzBzQS9IN2RLUXYrbGNIcTBS?=
 =?utf-8?B?SlJJQ2M5STczZXJYdnBBbkM0aUFWSllSdmY0NFRUYmsrVm55bFUva2hGRUpU?=
 =?utf-8?B?d2ZvZisvb3I5SGNlNldHZmdKS1hGdjhpVllVd2UvblZpZnd4RGd3STdwZ0s2?=
 =?utf-8?B?MHh3d1VrbXcvNVNpY29kcU81c3VUNFl2QmdhMXJnQzAyZzlNUlJ3N1Jmamw1?=
 =?utf-8?B?REtKMnlZV0V4Q25iUExCbmVhQUVCQ3Y1UlU0QmdZVEp1VWtlMjA2aWFiM2I1?=
 =?utf-8?B?VVUveUtlaDlmbTMwZ3BnRjdrRVQ3ZG9kNmdxdDNzM0gxVG4vRUYxaXF0ckJU?=
 =?utf-8?B?YzBqSWVGZTA5UEU4SWtjcXo4N3pOTGtFc0FUYWVwVTV0VTNtY1U0QndDdVdx?=
 =?utf-8?B?aytCSm5tRkFVeVVRaUF6U1RRaXpiYTZxclQ4RzNCcHR2Q1d1OEtkYW1qWFow?=
 =?utf-8?B?OXZsSzBLb3VVZE9qeG9BNjZyN1h3RXpUMGIzRUhPR3FRWHowOEtrU29JTkxs?=
 =?utf-8?B?QWRLTE9BR1FaVWFEUWk2NkY3NExYSHpXcWZHS3RMdWZHTGJzdWx1TExiT2t2?=
 =?utf-8?B?bGNCclhrUG1uazRuN0VNZTFRYW1rZmZ2M09WdzBRcExIY094SU5SdkNtVFNF?=
 =?utf-8?B?Z0ZHZ1hQSmNmeU9vRUV3Sk1NQkhybDdMUzhXTHhPK0hSZkVwNmF2aUQyeFdI?=
 =?utf-8?B?ampITVhGZmMxUDdKdWxwM3RVeDNIZ05MQlFQK2JpZ2JFbWc2Y1NHaEFlVSsr?=
 =?utf-8?B?dFlvekhRdkNGUkljT1ZmNm9PcWxIUW5NcmhpamlIWUpjeHI3QzNjUTQ2UVVD?=
 =?utf-8?B?dG9oQXlKSGE2NGZFQ0tjWldsMHdOL1ZMUGJZcWxIZWg5MmFuL0FGSlV5VWQ0?=
 =?utf-8?B?cEZWM0VITm1FTlBoYjdRNmtLdVpYQjhld0JzbWdiUHdjcndVYlRUeFUxdUpv?=
 =?utf-8?B?YkxTVE1FcGxYMVhZZTk2R2lLWDFROWc5MTdGK0NkSWFrVVQ3ZlpTS1RzSVkr?=
 =?utf-8?B?ZktlK3FvakZkNnptVktCVFZ3YW11Um02V0RidXkxL050Z3NscFNTVk5JOTRk?=
 =?utf-8?B?bGdYMXVPU3VFTXFuMnl6TEkzU00zZ3N2VFJoTFlYUGRoeGVkNzYwYmp4MExG?=
 =?utf-8?B?ZktzdnkxVWlzYlI1WTVKODh1a2lQUVUzOHJXdkFnT09xN0hxZWVzYm5lYW9I?=
 =?utf-8?B?SEhQMTZwdkM0ZzR2dzd5RGx5LzVhS1NTdnBRYVNaNUlVOFpJNHhZWC92akdM?=
 =?utf-8?B?ZHh1Mit2MnNWNi9RbW1CaFhnU1laRU9HcTJoalpkZ0JSR0FGZGNMbmFUcWxx?=
 =?utf-8?B?R0ljSlBWRmNCb245NEVEcWhHUVdjSmVtUjhOMVNYdUllMlFqR0UybWZpSnBF?=
 =?utf-8?B?VGJHMWdtZ21KdWtoYUxycldwVy8rcGdsTEIxZUcycFphZVRqczhFVmJXQXRa?=
 =?utf-8?B?VCt4UWhaS2J2VEVwZlJyaGNLb1g1OGxJbndwclVvZmN0bStlYUR2KytIK0Vk?=
 =?utf-8?B?c2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b9dec5-55b4-4ebe-5d0e-08dc32be1e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:18:51.2493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYh7S9Bhvaz1ZWph1zY3rMjCqWlhY9A8OACVTY+flAPmC8QURUGx3l7fopNIR+iGuV456R4V4mFkN7xm56MI+iE11R7JPkaLMutX6a8E/WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1025
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <0906546E2DF40E40AE18622E826EDE88@CHEP278.PROD.OUTLOOK.COM>
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

SGkgU3VtaXQNCg0KT24gV2VkLCAyMDI0LTAyLTIxIGF0IDA4OjU1ICswMTAwLCBGcmFuY2VzY28g
RG9sY2luaSB3cm90ZToNCj4gSGVsbG8gU3VtaXQsDQo+IA0KPiBPbiBUdWUsIEZlYiAyMCwgMjAy
NCBhdCAwNjo0MDo1NlBNICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiA+IEFsc28sIGVuYWJs
ZSByZXNldCBkcml2ZXIgd2hpY2ggaXMgYSBwcmVyZXF1aXNpdGUgZm9yIFBDSWUgc3VwcG9ydC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxpbmFyby5v
cmc+DQo+ID4gLS0tDQo+ID4gwqBjb25maWdzL3ZlcmRpbi1pbXg4bXBfZGVmY29uZmlnIHwgOSAr
KysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvY29uZmlncy92ZXJkaW4taW14OG1wX2RlZmNvbmZpZyBiL2NvbmZpZ3Mv
dmVyZGluLWlteDhtcF9kZWZjb25maWcNCj4gPiBpbmRleCAyMmI4YTMzNGRmYS4uZDhiZDY0NDMy
MmIgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZmlncy92ZXJkaW4taW14OG1wX2RlZmNvbmZpZw0KPiA+
ICsrKyBiL2NvbmZpZ3MvdmVyZGluLWlteDhtcF9kZWZjb25maWcNCj4gPiBAQCAtMTg1LDMgKzE4
NSwxMiBAQCBDT05GSUdfVVNCX0dBREdFVF9WRU5ET1JfTlVNPTB4MWI2Nw0KPiA+IMKgQ09ORklH
X1VTQl9HQURHRVRfUFJPRFVDVF9OVU09MHg0MDAwDQo+ID4gwqBDT05GSUdfSU1YX1dBVENIRE9H
PXkNCj4gPiDCoENPTkZJR19IRVhEVU1QPXkNCj4gPiArQ09ORklHX0RNX1JFU0VUPXkNCj4gPiAr
Q09ORklHX1JFU0VUX0lNWD15DQo+ID4gK0NPTkZJR19QQ0k9eQ0KPiA+ICtDT05GSUdfUENJRV9E
V19JTVg4PXkNCj4gPiArQ09ORklHX1BIWV9JTVg4TV9QQ0lFPXkNCj4gPiArQ09ORklHX0NNRF9Q
Q0k9eQ0KPiA+ICtDT05GSUdfTlZNRT15DQo+ID4gK0NPTkZJR19OVk1FX1BDST15DQo+ID4gK0NP
TkZJR19DTURfTlZNRT15DQo+IA0KPiBUaGlzIHdpbGwgaW5jcmVhc2UgdGhlIHUtYm9vdCBwcm9w
ZXIgc2l6ZQ0KDQpZZXMsIEkgY2hlY2tlZCBhbmQgaXQgaXMgYWN0dWFsbHkgc2xpZ2h0bHkgbW9y
ZSB0aGFuIDMyIEsuDQoNCj4gYW5kIG1hcmdpbmFsbHkgaW5jcmVhc2UgdGhlDQo+IGJvb3QgdGlt
ZSAoYmVjYXVzZSBvZiBhIGJpZ2dlciBiaW5hcnkgdG8gYmUgcmVhZCBmcm9tIHRoZSBlTU1DKS4N
Cg0KVGhhdCB3YXMgYWxzbyBteSBjb25jZXJuLg0KDQo+IEFwYXJ0IG9mIHRoYXQgZG8geW91IGV4
cGVjdCBhbnkgb3RoZXIgaW1wYWN0IG9uIHRob3NlIGNoYW5nZXM/IFNQTA0KPiBiaW5hcnkgc2l6
ZSBzaG91bGQgbm90IGJlIGFmZmVjdGVkLCBjb3JyZWN0Pw0KPiANCj4gQXNraW5nIHRoaXMgb3V0
IGxvdWRseSB0byBjb25maXJtIHRoYXQgbm90aGluZyB1bmV4cGVjdGVkIGlzIGdvaW5nIHRvDQo+
IGhhcHBlbiBiZWNhdXNlIG9mIHRoZXNlIGNoYW5nZXMuDQoNCk90aGVyIHRoYW4gdGhhdCBJIGFj
dHVhbGx5IGdhdmUgaXQgYSBxdWljayB0cnkgYW5kIFBDSWUvTlZNZSBkb2VzIGluZGVlZCB3b3Jr
IGFuZCB0aGUgcmVndWxhciBib290IGlzIG5vdA0KYWZmZWN0ZWQgKG90aGVyIHRoYW4gdGhlIHNs
aWdodCBzaXplIGFuZCBib290IHRpbWUgaW5jcmVhc2UsIG9mIGNvdXJzZSkuDQoNCj4gRm9yIG15
IGN1cmlvc2l0eSwgY2FyZSB0byBzaGFyZSB3aGF0J3MgdGhlIHVzZSBjYXNlPyBEbyB5b3UgcGxh
biB0byBoYXZlDQo+IHRoZSBPUyBzdG9yZWQgaW50byBhbiBOVk1FIGRldmljZT8NCg0KRm9yIHVz
IHRoZSBxdWVzdGlvbiBpcyBiYXNpY2FsbHkgd2hldGhlciB0aGF0IHVzZSBjYXNlIGRvZXMgbWFu
ZGF0ZSBlbmZvcmNpbmcgc3VjaCBjaGFuZ2VzIGZvciBlYWNoIGFuZCBldmVyeQ0KY3VzdG9tZXIu
IFBsdXMgdGhlIHJlZ3VsYXIgZXhwZWN0ZWQgbWFpbnRlbmFuY2UgZWZmb3J0IGFueSBzdWNoIGNo
YW5nZSBicmluZ3Mgd2l0aCBpdCwgb2YgY291cnNlLg0KDQo+IEZyYW5jZXNjbw0KDQpDaGVlcnMN
Cg0KTWFyY2VsDQo=

