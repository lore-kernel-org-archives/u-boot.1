Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E70C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 22:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958E686828;
	Fri, 25 Aug 2023 00:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="ZSLDvu8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79BF086828; Fri, 25 Aug 2023 00:47:05 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A7B8687F
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 00:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1692917219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1N4Ggt30hvjOGT7Wg/k0kd+ccOjYGxd0S176787wv0=;
 b=ZSLDvu8Sl5mgx/NYZb3MPhh4kk7vfuZjnyENZAHPfg0xKwUG4n9YrtcsWWKDddY2wJnBMJ
 FJyunf05VMiuQnLn0fOFfXPYb1Rw5gAjvMQYU96f5TBRmFKHDCxG0R96brUS/+9n9vjcmF
 E8zR6hE/O85O2RWcT1SoLNdjlQk106I=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-WiOkyAqlMjKjvX49P58gGQ-1; Fri, 25 Aug 2023 00:46:58 +0200
X-MC-Unique: WiOkyAqlMjKjvX49P58gGQ-1
Received: from GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4b::13)
 by ZR0P278MB0124.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:46:56 +0000
Received: from GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
 ([fe80::51be:f573:f81b:71eb]) by GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
 ([fe80::51be:f573:f81b:71eb%4]) with mapi id 15.20.6699.028; Thu, 24 Aug 2023
 22:46:56 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "festevam@gmail.com" <festevam@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "marex@denx.de" <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>, "aford173@gmail.com" <aford173@gmail.com>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: Re: [PATCH v7 1/2] phy: phy-imx8mq-usb: add vbus regulator support
Thread-Topic: [PATCH v7 1/2] phy: phy-imx8mq-usb: add vbus regulator support
Thread-Index: AQHZtbu1a7cbZqd92USwxGna9CiDSK/6TkoA
Date: Thu, 24 Aug 2023 22:46:56 +0000
Message-ID: <167ed7f9d29ee0d7babe950dbaedda7233885cd1.camel@toradex.com>
References: <20230713185608.3647122-1-tharvey@gateworks.com>
In-Reply-To: <20230713185608.3647122-1-tharvey@gateworks.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0679:EE_|ZR0P278MB0124:EE_
x-ms-office365-filtering-correlation-id: 495b647a-e872-4647-88f9-08dba4f404fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: qIj9BMoBaRcvGXx+CbWy/i6OQcewmtTl01Zv1inIu662VLeEgPNQPdxp7soOpEgxTXXvyBuAmhq6RRVmCcYmee3ygM1dCdkAxyJK1D4Z4HIyuR6YRu1d6qo2MmiNuZuq6P0UM3moJMR9k9p/41kR4vc/whSQcRvF/t/FjOszibdQgzRQNH+NCoaAF57qNcv9YROUjkiMvXGiMNvMkGRB53r1Q2TdEXRWceWFk8Omxro6AHWe8mqoeUa8PRkBzaMFnVl2pEoh12G7MCrjUGvi7S4oRnZD5hBoei/0uhSV7RDITSbsIby00YA07JZLzm144vyCO82pizrKImDLwmcvJ69no+u6G2lDx5XE54gn6BvUuI/AO+AVfT8YhGprc9S4z9cPZVSYKUE8Sk7P163R1LkJofU9zvK3MNO+u3Kq5L+NCawCUy1VPi69KxNoujAIpz8Hcsx40Sfddt6JHSeCEPGXgW0CSstUWQENOmppaD9LPvqbonNGNFpjjSUxX6vOyOHWmEyECQGVlbZDDyqMpHBjUTSFGFOvmQcBCdFgB4M/2jalmS/nWzQ3cjACBenkQkw/LfEDWH+mJWDs766qF3rupV+aBZH+ADZPGOztzz0vouKOurSFBK/zLKwfRd6Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39840400004)(136003)(396003)(376002)(1800799009)(186009)(451199024)(6512007)(38070700005)(122000001)(38100700002)(44832011)(5660300002)(2616005)(2906002)(66946007)(91956017)(76116006)(83380400001)(478600001)(4326008)(8936002)(6486002)(316002)(64756008)(66446008)(8676002)(66556008)(66476007)(54906003)(71200400001)(6506007)(41300700001)(110136005)(36756003)(86362001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGEvZkdJQ0M2cFk2N2VQQzRvT2cwV3FnZllVdDNmYVJIQ3FCRFN2dURadmRm?=
 =?utf-8?B?YkpDdWV1a0lxK21zTDVrc3k0UmdjNUdnUXZpTURuSjdQYVR2clZIY1JuVk9r?=
 =?utf-8?B?Zkw3TzByVXhrakxMK0pwV3dMYTNlQjBJU0d6dkd6b1JTNUJXOGFmWGh3SERJ?=
 =?utf-8?B?WnNFcnZIUm5tbU4zelh2VmpHVHNsSTBOMDBNV0E2Q2pXZlZZUlcxUU4yc1Fl?=
 =?utf-8?B?c0lWNkFlRnUzZ09DSmRQTU02VHVzYUJnbXk1YVdJTlZOeEJwdUVIV3J2ZTFR?=
 =?utf-8?B?cGxEeTlCNllCazFYYWkzVnhFelVzOFh2VEdhUm9uZXo1UFdMbm1wQWVUR0ox?=
 =?utf-8?B?NGc2Y2I3VngvWEhnNTNFbnFRanVMMlQrR2NoZVp6V2JXUmVrUy9xakkyR25x?=
 =?utf-8?B?bEVRSW9WckNuNmdGRlhiUEpGb2xWV0xZbU9yY2hCOEFDVGw3Q01RclNhalFs?=
 =?utf-8?B?UEZpRVIxMTljdlY2NmxnQUd3YzJiVENBK3BRRmQyNi9HRGZYNHVPVDhxUmNI?=
 =?utf-8?B?OURwQUFLMTJ3VWI2MnNSTHZ0Q1A0bXhhRXhxVGpOZVo1SGFpcVl0aXo3cW4r?=
 =?utf-8?B?c1ZCb0ZLcWswSDRTNDhFenlvSjNqVUpPVTd4QTFhTnFhWXN2S21jUnc1WjFo?=
 =?utf-8?B?QkJ1SG1jeUZYdWREcHhsZ29wdTFrNWoxOWZFcUpVL3lJbXk3b0QxNjFoQWdV?=
 =?utf-8?B?KzgvTDF4N21OZ1N4UkhXSmJ0d1BORXliSVJmOThMYkdzaWEzUVhncGV2Wm1R?=
 =?utf-8?B?OEZUTEhLY2pkKzluaHN5bnRYRVh3dWVKWC9pTm05czRoL2E2M3c4RytCWEtV?=
 =?utf-8?B?N0ljZHdUS3Nyei91bnIyTjJIQnM0S1BzQldhYnROd0cxa0tiTlQrK3pPWUIx?=
 =?utf-8?B?Wm5zamNUMlNpT3RHZXNMeGJLNjZjM2p5RWs5Z00rT0NhT0Y5UHVXNkRMOUI0?=
 =?utf-8?B?WmJYS29oeTZIeXV0eGVobDNIKzk0bkZBTy80NCtuanhISzM0WlRrNUVYLzNq?=
 =?utf-8?B?dUpZSU51L2d6R1ZJMFd4VHBXR1NadjdUL1lnZjRiVHg2U3VaVnBhOW82bmhU?=
 =?utf-8?B?a1NhaEJpaTNrUTFrSktQKzhTT2xQNUtuWSs3OTRyMFVENVFJZmtNNFBreU1F?=
 =?utf-8?B?bzRqZVBaWjNWREV1dStHNVhrM1lJOTY0WEt3NnNMY3dHYUlOZlcySk9XejZ1?=
 =?utf-8?B?em8vQlY4ZVdhT2NJNzRRakJ0V2lmNWRZS2Y5Y3ZPbzFKMm44T3ZKQk9mV3FL?=
 =?utf-8?B?SXRHVy91aGk1M2JEVDVtU2tXem5ZbTNkUjAyMVlESGlVbllnWjgySVB5bTBC?=
 =?utf-8?B?bERDS3pJMVNxMHFIZ0Y2R2xteEV1NHVXQW5yR2t2ZXRHZDVuRnFpQzhmcy9E?=
 =?utf-8?B?WVR1emNtUGliRzYyaCtLUGV6a0U2aFB4R2FydG9LazZyQlI3cGtnaWhSSjdU?=
 =?utf-8?B?TjgrNk9ya1RnNndUREtuZ05nUW9mVzM2YnpVZG5DNGlBczQ2ckFIUzkzeFMy?=
 =?utf-8?B?TXBYMGh6YWRaczFtbytTZHpJLzBNSzc2Z2t1RXArcU9oTXBtYUxKekp1YXJB?=
 =?utf-8?B?ZEIvTC95c1huaVFOMHhKSHZBMStxd05BWHAxUi9TclNlbnI2SzVZVkhPc0VP?=
 =?utf-8?B?K2FCMHVrNFRraHl0Ri9aV3MwTnFScE9saTF4cXFTLzlkN2czSGVuVkR2TEo5?=
 =?utf-8?B?cEZuOHp5dHV3WVFzdGkvZnhBdlVscGVFOVVMSWR1N0lGYllhVEtJakJycUJm?=
 =?utf-8?B?dVNrbGV6YnpHejgvOEpHcks2bGNKTFdBNUV0R1JvKzlKU0pFNGZQZ2F1a0dY?=
 =?utf-8?B?YjVRMUt0K1k3b2Q3YmdscHJhR2F3dk9uMldhY21nY21rdDdNamV3UDJlRUZx?=
 =?utf-8?B?VGdXN3U2TjFMa3d4TGg0UE9YNVVnekZ6UEt1amd5MVk3K0FiczRMTUh3RWpK?=
 =?utf-8?B?eUJMU1hQUWxwaVVOR1RaQ1ZNTXVDSjl0VVExT3hlc0FwL0ZkQUVVYlFNYURv?=
 =?utf-8?B?L0Ria3lPbzVydmh3eHI2MjNVdWNFMkZGQlhMb1FuMVpMNmJhWGI4U0JEVWg0?=
 =?utf-8?B?c2hFNjJiQTluYUN0bzNqWlZzTDRPZ3Fnd2pWMVhtekxLWHkrMStqMy9LamJl?=
 =?utf-8?B?VVdibFZMNmZkYzMwRTUzc3NyRjNiRURGSDVQeXRTVEhKTlFhdzRCd3ljMVZw?=
 =?utf-8?B?T0pIZW15SWhxMSsyNGw4eDRGbm91V0lLZHZhd0JKNnZiQUpXMkIrbHVaQlp1?=
 =?utf-8?B?bG1wclN2bjdLNUZlcHZaMElUbUxnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0679.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 495b647a-e872-4647-88f9-08dba4f404fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 22:46:56.5434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGLj1iCgPkc7h1TftfgXuKfN4cmclQkk8VAEhP+rYXgbsh00apCC1EUHTc+vtQAChqDYPAKkTZUc05xMeQcTZN1WCtK7Ey/FJtYGneJ6AsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0124
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <9B45F22EDFDE824899C69FD426C073D6@CHEP278.PROD.OUTLOOK.COM>
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

SGkgVGltCgpUaGFua3MhCgpPbiBUaHUsIDIwMjMtMDctMTMgYXQgMTE6NTYgLTA3MDAsIFRpbSBI
YXJ2ZXkgd3JvdGU6Cj4gQWRkIHN1cHBvcnQgZm9yIGVuYWJsaW5nIGFuZCBkaXNhYmxpbmcgdmJ1
cy1zdXBwbHkgcmVndWxhdG9yIGZvdW5kCj4gb24gc2V2ZXJhbCBpbXg4bXAgYm9hcmRzIGluIHRo
ZSB1c2IzX3BoeTAgYW5kIHVzYjNfcGh5MSBub2Rlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBUaW0g
SGFydmV5IDx0aGFydmV5QGdhdGV3b3Jrcy5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFkYW0gRm9yZCA8
YWZvcmQxNzNAZ21haWwuY29tPgo+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVu
eC5kZT4KClRlc3RlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+Cgo+IC0tLQo+IHY3Ogo+IMKgLSBhZGQgI2lmZGVmIHByb3RlY3Rpb24gYXJvdW5kIGNs
a19kaXNhYmxlIGVycm9yIHBhdGgKPiAKPiB2NjoKPiDCoC0gbW92ZSBjaGFuZ2VzIHRvIGNsayB0
byBzZXBhcmF0ZSBwYXRjaAo+IMKgLSBzb3J0IG5ldyB2YXJzIGluIHJldmVyc2UgY2hyaXN0bWFz
IHRyZWUgc3R5bGUKPiAKPiB2NToKPiDCoC0gcmVtb3ZlICNpZiBDT05GSUdfSVNfRU5BQkxFRCBh
cm91bmQgc3RydWN0IG1lbWJlcnMKPiDCoMKgICh5b3UgY2FuIG5vdCBjb25kaXRpb25hbGx5IGlu
Y2x1ZGUgaWYgdXNpbmcgaWYgKENPTkZJR19JU19FTkFCTEVEKGZvbykpICkKPiDCoC0gcmVwbGFj
ZSBjbGsgJyNpZiBDT05GSUdfSVNfRU5BQkxFRChDTEspJyB3aXRoICdpZiAoQ09ORklHX0lTX0VO
QUJMRUQoQ0xLKSknCj4gCj4gdjQ6Cj4gwqAtIHVzZSByZWd1bGF0b3Jfc2V0X2VuYWJsZV9pZl9h
bGxvd2VkIHRvIGhhbmRsZSByZWd1bGF0b3IgcmVmZXJlbmNlCj4gY291bnRpbmcKPiDCoMKgIGVy
cm9ycwo+IMKgLSBhZGRlZCBNYXJlaydzIHJiIHRhZwo+IAo+IHYzOgo+IMKgLSBjaGFuZ2UgcHJf
ZXJyIHRvIGRldl9lcnIKPiDCoC0gYWRkICNpZiBDT05GSUdfSVNfRU5BQkxFRCBhcm91bmQgdmJ1
c19zdXBwbHkgaW4gc3RydWN0Cj4gwqAtIGFkZCBmYWlsIHBhdGggdG8gZGlzYWJsZSBjbG9jayBp
ZiByZWd1bGF0b3IgZW5hYmxlIGZhaWxlZAo+IAo+IHYyOgo+IMKgLSBwcm90ZWN0IHJldCB3aXRo
IF9fbWF5YmVfdW51c2VkIGluIGNhc2UgQ09ORklHX0NMSyBhbmQKPiDCoMKgIENPTkZJR19ETV9S
RUdVTEFUT1Igbm90IGRlZmluZWQKPiDCoC0gYWRkIGVycm9yIHByaW50cyBvbiBmYWlsdXJlcwo+
IMKgLSBhZGQgQWRhbSdzIHJiIHRhZwo+IFNpZ25lZC1vZmYtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2
ZXlAZ2F0ZXdvcmtzLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvcGh5L3BoeS1pbXg4bXEtdXNiLmMg
fCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BoeS9waHktaW14OG1xLXVzYi5jIGIvZHJpdmVycy9waHkvcGh5LWlteDhtcS11c2Iu
Ywo+IGluZGV4IDY5ZjAxZGU1NTUzOC4uOWZhNzhlZjRkYTNkIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvcGh5L3BoeS1pbXg4bXEtdXNiLmMKPiArKysgYi9kcml2ZXJzL3BoeS9waHktaW14OG1xLXVz
Yi5jCj4gQEAgLTE0LDYgKzE0LDggQEAKPiDCoCNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgo+IMKg
I2luY2x1ZGUgPGxpbnV4L2Vyci5oPgo+IMKgI2luY2x1ZGUgPGNsay5oPgo+ICsjaW5jbHVkZSA8
ZG0vZGV2aWNlX2NvbXBhdC5oPgo+ICsjaW5jbHVkZSA8cG93ZXIvcmVndWxhdG9yLmg+Cj4gwqAK
PiDCoCNkZWZpbmUgUEhZX0NUUkwwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAweDAKPiDCoCNkZWZpbmUgUEhZX0NUUkwwX1JFRl9TU1BfRU7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgQklUKDIpCj4gQEAgLTgxLDYgKzgzLDcgQEAgc3RydWN0IGlteDhtcV91c2JfcGh5
IHsKPiDCoCNlbmRpZgo+IMKgwqDCoMKgwqDCoMKgwqB2b2lkIF9faW9tZW0gKmJhc2U7Cj4gwqDC
oMKgwqDCoMKgwqDCoGVudW0gaW14OG1wcV9waHlfdHlwZSB0eXBlOwo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCB1ZGV2aWNlICp2YnVzX3N1cHBseTsKPiDCoH07Cj4gwqAKPiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgdWRldmljZV9pZCBpbXg4bXFfdXNiX3BoeV9vZl9tYXRjaFtdID0gewo+IEBAIC0x
NzMsOSArMTc2LDkgQEAgc3RhdGljIGludCBpbXg4bXFfdXNiX3BoeV9wb3dlcl9vbihzdHJ1Y3Qg
cGh5ICp1c2JfcGh5KQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdWRldmljZSAqZGV2ID0gdXNi
X3BoeS0+ZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW14OG1xX3VzYl9waHkgKmlteF9w
aHkgPSBkZXZfZ2V0X3ByaXYoZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHZhbHVlOwo+ICvC
oMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gwqAKPiDCoCNpZiBDT05GSUdfSVNfRU5BQkxFRChDTEsp
Cj4gLcKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gY2xrX2Vu
YWJsZSgmaW14X3BoeS0+cGh5X2Nsayk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50ZigiRmFpbGVkIHRvIGVuYWJsZSB1
c2IgcGh5IGNsb2NrXG4iKTsKPiBAQCAtMTgzLDEyICsxODYsMjYgQEAgc3RhdGljIGludCBpbXg4
bXFfdXNiX3BoeV9wb3dlcl9vbihzdHJ1Y3QgcGh5ICp1c2JfcGh5KQo+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gwqAjZW5kaWYKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoGlmIChDT05GSUdfSVNfRU5BQkxF
RChETV9SRUdVTEFUT1IpICYmIGlteF9waHktPnZidXNfc3VwcGx5KSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJlZ3VsYXRvcl9zZXRfZW5hYmxlX2lmX2FsbG93ZWQo
aW14X3BoeS0+dmJ1c19zdXBwbHksIHRydWUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAocmV0ICYmIHJldCAhPSAtRU5PU1lTKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBlbmFibGUg
VkJVUyByZWd1bGF0b3I6ICVkXG4iLCByZXQpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqAvKiBEaXNh
YmxlIHJ4IHRlcm0gb3ZlcnJpZGUgKi8KPiDCoMKgwqDCoMKgwqDCoMKgdmFsdWUgPSByZWFkbChp
bXhfcGh5LT5iYXNlICsgUEhZX0NUUkw2KTsKPiDCoMKgwqDCoMKgwqDCoMKgdmFsdWUgJj0gflBI
WV9DVFJMNl9SWFRFUk1fT1ZFUlJJREVfU0VMOwo+IMKgwqDCoMKgwqDCoMKgwqB3cml0ZWwodmFs
dWUsIGlteF9waHktPmJhc2UgKyBQSFlfQ1RSTDYpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAwOwo+ICsKPiArZXJyOgo+ICsjaWYgQ09ORklHX0lTX0VOQUJMRUQoQ0xLKQo+ICvCoMKg
wqDCoMKgwqDCoGNsa19kaXNhYmxlKCZpbXhfcGh5LT5waHlfY2xrKTsKPiArI2VuZGlmCj4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIGludCBpbXg4bXFf
dXNiX3BoeV9wb3dlcl9vZmYoc3RydWN0IHBoeSAqdXNiX3BoeSkKPiBAQCAtMTk2LDYgKzIxMyw3
IEBAIHN0YXRpYyBpbnQgaW14OG1xX3VzYl9waHlfcG93ZXJfb2ZmKHN0cnVjdCBwaHkgKnVzYl9w
aHkpCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB1ZGV2aWNlICpkZXYgPSB1c2JfcGh5LT5kZXY7
Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbXg4bXFfdXNiX3BoeSAqaW14X3BoeSA9IGRldl9n
ZXRfcHJpdihkZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgdmFsdWU7Cj4gK8KgwqDCoMKgwqDC
oMKgaW50IHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBPdmVycmlkZSByeCB0ZXJtIHRv
IGJlIDAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgdmFsdWUgPSByZWFkbChpbXhfcGh5LT5iYXNlICsg
UEhZX0NUUkw2KTsKPiBAQCAtMjA2LDYgKzIyNCwxNCBAQCBzdGF0aWMgaW50IGlteDhtcV91c2Jf
cGh5X3Bvd2VyX29mZihzdHJ1Y3QgcGh5ICp1c2JfcGh5KQo+IMKgwqDCoMKgwqDCoMKgwqBjbGtf
ZGlzYWJsZSgmaW14X3BoeS0+cGh5X2Nsayk7Cj4gwqAjZW5kaWYKPiDCoAo+ICvCoMKgwqDCoMKg
wqDCoGlmIChDT05GSUdfSVNfRU5BQkxFRChETV9SRUdVTEFUT1IpICYmIGlteF9waHktPnZidXNf
c3VwcGx5KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJlZ3VsYXRv
cl9zZXRfZW5hYmxlX2lmX2FsbG93ZWQoaW14X3BoeS0+dmJ1c19zdXBwbHksIGZhbHNlKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCAmJiByZXQgIT0gLUVOT1NZUykg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2Vy
cihkZXYsICJGYWlsZWQgdG8gZGlzYWJsZSBWQlVTIHJlZ3VsYXRvcjogJWRcbiIsIHJldCk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+
ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiBAQCAtMjI0LDYgKzI1
MCw3IEBAIHN0cnVjdCBwaHlfb3BzIGlteDhtcV91c2JfcGh5X29wcyA9IHsKPiDCoGludCBpbXg4
bXFfdXNiX3BoeV9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQo+IMKgewo+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgaW14OG1xX3VzYl9waHkgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsKPiAr
wqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHByaXYtPnR5cGUg
PSBkZXZfZ2V0X2RyaXZlcl9kYXRhKGRldik7Cj4gwqDCoMKgwqDCoMKgwqDCoHByaXYtPmJhc2Ug
PSBkZXZfcmVhZF9hZGRyX3B0cihkZXYpOwo+IEBAIC0yMzIsOCArMjU5LDYgQEAgaW50IGlteDht
cV91c2JfcGh5X3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoAo+IMKgI2lmIENPTkZJR19JU19FTkFC
TEVEKENMSykKPiAtwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IC0KPiDCoMKgwqDCoMKgwqDCoMKg
LyogQXNzaWduZWQgY2xvY2sgYWxyZWFkeSBzZXQgY2xvY2sgKi8KPiDCoMKgwqDCoMKgwqDCoMKg
cmV0ID0gY2xrX2dldF9ieV9uYW1lKGRldiwgInBoeSIsICZwcml2LT5waHlfY2xrKTsKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJldCkgewo+IEBAIC0yNDEsNiArMjY2LDE0IEBAIGludCBpbXg4bXFf
dXNiX3BoeV9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgI2VuZGlmCj4g
K8KgwqDCoMKgwqDCoMKgaWYgKENPTkZJR19JU19FTkFCTEVEKERNX1JFR1VMQVRPUikpIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gZGV2aWNlX2dldF9zdXBwbHlfcmVn
dWxhdG9yKGRldiwgInZidXMtc3VwcGx5IiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZwcml2LT52YnVzX3N1cHBseSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdl
dCBWQlVTIHJlZ3VsYXRvcjogJWRcbiIsIHJldCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAwOwo+IMKgfQo=

