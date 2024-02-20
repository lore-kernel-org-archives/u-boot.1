Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846DFC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 19:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DED88006;
	Tue, 20 Feb 2024 20:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="pSmaSXca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339F688006; Tue, 20 Feb 2024 20:51:33 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CD487FF2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 20:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1708458686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otaGvmXMCSSMUNNEZfVdutCEE2it49YB1leT5gqUK4E=;
 b=pSmaSXcarbkz/krHp7Wk1JrXlL9NJbdSlOn5wOUKFzg5ZMHoCJQFRjcKT5IH8kPjjQHTDh
 s6rfQe7FRlWStu05S8L9ntUASIm7pIxL8r5w24YEJf317m0blh6JSURrfcYLsokYyKm7ti
 EYeKL7rwJf/AL2KEhhq2fR28rwCJOKE=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-54-2I98aNIgPueukN3AiIQqlg-2; Tue, 20 Feb 2024 20:51:24 +0100
X-MC-Unique: 2I98aNIgPueukN3AiIQqlg-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0963.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 19:51:22 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb30:77cf:2697:f38c]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb30:77cf:2697:f38c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 19:51:22 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "festevam@gmail.com"
 <festevam@gmail.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "trini@konsulko.com" <trini@konsulko.com>, 
 "treding@nvidia.com" <treding@nvidia.com>, "clamor95@gmail.com"
 <clamor95@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sahaj.sarup@linaro.org"
 <sahaj.sarup@linaro.org>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 0/7] toradex: fix reset and hardware detection
 regressions
Thread-Topic: [PATCH v1 0/7] toradex: fix reset and hardware detection
 regressions
Thread-Index: AQHaZCrD0cRNnWdHM0Syw3z6WU5nHLETpEgA
Date: Tue, 20 Feb 2024 19:51:21 +0000
Message-ID: <67db966e36a39a3e2b8ef398946b29b208c6ba81.camel@toradex.com>
References: <20240220182926.101161-1-francesco@dolcini.it>
In-Reply-To: <20240220182926.101161-1-francesco@dolcini.it>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0963:EE_
x-ms-office365-filtering-correlation-id: 44cf70a4-1334-40f0-b4bb-08dc324d503c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: fjZ9pnpIT4IWMYpIlBm4PqAvw24A1yDpATL0v5P0VtlSV8Q6g/O3RY39hyXTGSuYpdmsjgIIkVGhpzjdhNYbccZTWXczuEoqxMSAqKN6urDBjEEjwKeZ1mWMJeftja6y2SVwdVNeEBgZOgjHCjmnkhWSbvV3qjGkib0Lb4LvYv7kEPhtCcer4YYof9H/aJvPnl/sfzRKP6vX8nBidcSVvTvcpdT92EztwlwoW4UwLVLQuZ8R7JMc2+ZehD6zbD0MzMfMjDTtFUX8iMC6/4u77i9PYSPSjI5iKjAV+Q1ezpd0ViFB/2W965PUAFt8ali4NAgOA/IPTxaTytthV5KenGjhNy98XN5an2WJKhsbujJUxs9FoN3pTR6iCCTM66j2Ey7Lw9d5AF7LDm0pMPQKCnX85P5io4vXO8f+GMR8dQW2TXGq02oGUEqgg1+a+ZZUDVqSRrGAdHsTrlurBNQ9yMZiGpsbfpVIWQs4C7SHTzBKuviXznU+RW04TAueVagCYdBf+ZSENFRgfELIV5J41QEvtW2lL25PvwUDFL55Vs/N4Xi3HDYCULjR4W6W91ZwFcutwV+gKn57ufs8e0s0unD84x0JIJQE+GGnxxOYxcQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nlgydzl3S1pYOHlQblNpQ3dFRmlPUGdzTjBuaGQ5Y1NPK0l3dHptUEh1OFhZ?=
 =?utf-8?B?TmxuMHIxOWt3SEdodWs5NlFuTTFSWnhpVU95VWFlR2U2NWFzbEw1QXliZkps?=
 =?utf-8?B?U2FjZTBwVTQyVm1DbjVmcCs2THZ4eDBFeU81REdFalNiY0FIRlhKUDllMVNX?=
 =?utf-8?B?L1h2ZmtvV3hQeGx4RUxzQ3ZVUWFQeUdWSFBsVWRJcGl5UEtucGxCQ2JaK0ZW?=
 =?utf-8?B?eVB5WWIxYXp5TzRIR0FNc1IwcHdkOE4wRUFJVzNvdUIveG50OU5Xc2NTQWNH?=
 =?utf-8?B?Nmp0MjlTQkVrZk5MUTZKTlV5UzZEUmEzcGFPZVY4RlBSVHdxTFNBMm9oZ05N?=
 =?utf-8?B?bm9VNlo3MWxCSCtSU005NUtpZm5oNmZpOUozdEhWM2F0RnBBV1hZaHd2d2xH?=
 =?utf-8?B?alhNaThnTWpHUnpML1NPTEcyVkhnME5aNDJhNWFHRGxoQ2x3VkhXeGNuaTl1?=
 =?utf-8?B?bWdMWnZLVVo0N04rbkc3SVdzbmFFOFhNZndOR3FwaUdUZytuRmpNNncxTDhG?=
 =?utf-8?B?bVlnUmtkS1J0K1JobksyZUswdzJrbUpielVoV1c1NHFzRWNNaFhMcFk1eG9N?=
 =?utf-8?B?ZlU4N2FuVko4Z05rekJJeHN2TUdqUnRZOWwrZ2JGTmM4Q2w0KzlRSGlYSmlx?=
 =?utf-8?B?RGdDUHBRTFRWOHI3UDBtSTNhdmc5WHljWFBBR1oybWRrcUVHOWVrWFRDR1RC?=
 =?utf-8?B?MmtwV1hscEo0enZ1RGpkOFhkTy9TWjltWHdIaE91T3FOOUx3Rm5qRjRNMW5M?=
 =?utf-8?B?bXBTMVdya0RjSWNFbFpXWnlRRnlodUZrbUNGYU52ckM5TGhtaDBGMGVQMUFI?=
 =?utf-8?B?Wmc1L3BLRTEzM0ZHOFVnTExWRkNDM1N2NUkvQ24xWFh3SkpxUzljMzAyUFVL?=
 =?utf-8?B?UnBta1F6Sm1UcDBRUXhBVW5mVjV2Qm9rcFlEYzZtLzFaQkZxbmNzaG9CZ1VC?=
 =?utf-8?B?K3NOdmEyemk2Qk9YaHlMalYrKzQ4QjI5VmZBSDFuUUhrbGF2ZjBDaFV6UU1y?=
 =?utf-8?B?Sms4c3k4WHh5aS9US0xkMGZQMXErQXNpKzcxMmJhTzlubFVVZnU1UmV4cERO?=
 =?utf-8?B?SjhDV01OODB6dnBRa2s4RFNVaC9wMndCdUhDZ2d1U2cyT0hpcEhWa29CTzVL?=
 =?utf-8?B?K1JFb2tFVnVlUUJoMjVJKzE4V2g1R1lmbElZbDhHWlVsN1huRU14ZDV6eWVr?=
 =?utf-8?B?YlRYa2JrRjVyelc0RkYycFBLMjNmbnE3RW1VcU83dEJNT2hoUUtIV0J2MkM3?=
 =?utf-8?B?VTk2TXVRMjZUV1ZUM1Bwc0pxTHBKNlRIcGZSR1dTZ0hCTElDZU5ZcENhWTBw?=
 =?utf-8?B?OUJlUWRxcm1iOHF1SzU4b2ZEaXl3MXNwZnl2aS82MlFsYkFYWTA1eFI5alNO?=
 =?utf-8?B?RTd5dmpvUXMxUURFVUZ0L2I1WllzT3lMd2U0VTc5U1p1KzlveEdqUkt4RVpU?=
 =?utf-8?B?NWRqWXByRXBUVENMbXpmR3BQNVQ3WUI3T3MySnZEMXgrWDlPbU40ZUs4MlNm?=
 =?utf-8?B?SzYwUlRZaGdDclU1cDFDV2RtaUdkZHh3dkgrc3F4dExSTWV4U25qcXJEd28v?=
 =?utf-8?B?ZUt6TzFiNkdCc0Npayt1SmFDQzNaOGRLMTU2VHpSTFowUS9VcHFwaFFmMFBx?=
 =?utf-8?B?T0FnaHRVR1ZnWCtlVGJRZEJaU0dnSGZlUFJyYk1GbTJzb0p5eVRiV2JlOVBT?=
 =?utf-8?B?NEJvL090eXF4b2h5c1lYaE83UW8weHRhS202alFlZUg4MnBxSXhYZGtSREhm?=
 =?utf-8?B?T3kxT2dPMWlyaVhxZkNBM3FLQWZRaXRna3FGVDB0and1SVZrN1dmd0NCUnUr?=
 =?utf-8?B?Q1JmOGJFWE9hY2hVNFZySkFOWFZaV2NCanZEWFl3U2pkSjVsNjEyd2ZrWEQz?=
 =?utf-8?B?Tmc3TzdmOXhybkxEbkRISnJEUW9LMzJ6d2VYK2Zud2FQUnBnMGFzblM1LzhK?=
 =?utf-8?B?TE1OUTIvbjdVNGpwd3NCQ2xqblA4QlJPNG44Q0xOZjV6R1NSWlErZitaYlkx?=
 =?utf-8?B?S0hNU0FMaXZiUmUvK3MwT3hKSjZuVjQrWWhCQjUveXJHdEIyaW9PaHRJOEds?=
 =?utf-8?B?M2dWdnRxK0dyTjFlbmdueVR2VTRTZjdIR1U1bVp6WTNQLzZJMnhoMnp5VkVz?=
 =?utf-8?B?MUtmMktrNVdHNnBMNFprUGV1cGd1SHdWSmFmYjlOWllPMk1EZDdqMUtLcnV6?=
 =?utf-8?B?Z2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cf70a4-1334-40f0-b4bb-08dc324d503c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 19:51:21.9390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuNQMBNSgoHktS7ctt/fsHt6da9Dfb8TFKBz7RxYQLOMkHXbidXd4CcEpgx6uM+B705e2HLKbnUKpSV6+5vd9zoNfeymRybjcFPhmdcCUVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0963
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <126855E51B67D14FB36C04A87748F86B@CHEP278.PROD.OUTLOOK.COM>
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

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE5OjI5ICswMTAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToKPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5j
b20+Cj4gCj4gVGhpcyBzZXJpZXMgZml4ZXMgdHdvIHJlZ3Jlc3Npb25zIGFmZmVjdGluZyBtdWx0
aXBsZSBUb3JhZGV4IGJvYXJkcwo+IChpLk1YLCBUSSBhbmQgVEVHUkEgYmFzZWQpIGFuZCB0YXJn
ZXRzIHRoZSBjdXJyZW50IG1hc3RlciwgZS5nLiB2MjAyNC4wNCByZWxlYXNlLgo+IAo+IFUtQm9v
dCBgcmVzZXRgIGNvbW1hbmQgaXMgYnJva2VuIG9uIGFsbCBUb3JkZXggaS5NWDYqIGJhc2VkIFNv
TXMgc2luY2UKPiB2MjAyMy4wNywgdGhpcyBzZXJpZXMgZml4ZXMgaXQgZW5hYmxpbmcgdGhlIGB3
ZHQtcmVib290YCBkcml2ZXIuCj4gCj4gU2luY2UgdjIwMjQuMDQtcmMxIHJlYWRpbmcgdGhlIFRv
cmFkZXggY29uZmlndXJhdGlvbiBibG9jayBpcyBub3Qgd29ya2luZwo+IHByb3Blcmx5IGFueW1v
cmUsIHRoZSBzZXJpYWwgbnVtYmVyIGFuZCB0aGUgaGFyZHdhcmUgdmVyc2lvbiBhcmUgbm90IHJl
YWQKPiBjb3JyZWN0bHksIHByZXZlbnRpbmcgdGhlIGJvYXJkIGZyb20gZnVuY3Rpb25pbmcgY29y
cmVjdGx5ICh3cm9uZyBtYWMgYWRkcmVzcywKPiB3cm9uZyBEVCwgLi4uKS4gVGhpcyBpcyBmaXhl
ZCBieSByZWFkaW5nIHRoZSBjb25maWcgYmxvY2sgaW4gYEVWVF9TRVRUSU5HU19SYCBhbmQKPiBh
ZGRpbmcgYSB0b3JhZGV4IHN5c2luZm8gZHJpdmVyLiBJbiBhZGRpdGlvbiB0byB0aGF0LCB3ZSBu
b3cgdXNlIGEgcmFuZG9tIG1hYwo+IGFkZHJlc3MgaW4gY2FzZSB0aGUgY29uZmlnIGJsb2NrIGlz
IGludmFsaWQuCj4gCj4gCj4gUmVwb3J0ZWQtYnk6IFNhaGFqIFNhcnVwIDxzYWhhai5zYXJ1cEBs
aW5hcm8ub3JnPgo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBS1oxTHZN
NDVNQjhOMENxZ1UrQzdpOT1CamI2a3FOVHhXbzJUdjQwN0hLTFd0Q01rQUBtYWlsLmdtYWlsLmNv
bS8KPiBSZXBvcnRlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+Cj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZTQwZWQ5M2JkOGYz
NzFlYzU2YjhmYzQ1MWRjYjQ1OGYzY2U2ZGNiYS5jYW1lbEB0b3JhZGV4LmNvbS8KPiBSZXBvcnRl
ZC1ieTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pgo+IENsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pZMlpEV0FRdVRsUmpWOUhAZnJhbmNlc2NvLW5i
LwoKRm9yIHRoZSB3aG9sZSBzZXJpZXM6CgpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJj
ZWwuemlzd2lsZXJAdG9yYWRleC5jb20+ClRlc3RlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJj
ZWwuemlzd2lsZXJAdG9yYWRleC5jb20+ICMgVmVyZGluIGlNWDhNIFBsdXMKCj4gRW1hbnVlbGUg
R2hpZG9saSAoNik6Cj4gwqAgdG9yYWRleDogRml4IHJlY3Vyc2l2ZSBjYWxsIHRvIGNoZWNrYm9h
cmQKPiDCoCB0b3JhZGV4OiBSZW1vdmUgbm90IG5lY2Vzc2FyeSBtb2RlbCBwcmludHMgZnJvbSBj
aGVja2JvYXJkKCkKPiDCoCB0b3JhZGV4OiBjb21tb246IFVzZSBTRVRUSU5HU19SIGV2ZW50IHRv
IHJlYWQgdG9yYWRleCBjb25maWcgYmxvY2sKPiDCoCBhcm06IGR0czogUmVmYWN0b3IgZGV2aWNl
IHRyZWVzIHVzaW5nICImey9hbGlhc2VzfSIgc3ludGF4Cj4gwqAgdG9yYWRleDogY29tbW9uOiBB
ZGQgc3lzaW5mbyBkcml2ZXIKPiDCoCB0b3JhZGV4OiBjb21tb246IFVzZSByYW5kb20gbWFjIGFk
ZHJlc3MgaWYgdG9yYWRleCBjb25maWcgYmxvY2sgaXMKPiDCoMKgwqAgbWlzc2luZwo+IAo+IFBh
cnRoIFBhbmNob2xpICgxKToKPiDCoCB0b3JhZGV4OiBpbXg2KjogZml4IHJlc2V0IHVzaW5nIHdk
dC1yZWJvb3QgZHJpdmVyCj4gCj4gwqBhcmNoL2FybS9kdHMvZnNsLWlteDhxbS1hcGFsaXMtdS1i
b290LmR0c2nCoMKgwqAgfMKgwqAgNiArCj4gwqBhcmNoL2FybS9kdHMvZnNsLWlteDhxeHAtY29s
aWJyaS11LWJvb3QuZHRzacKgIHzCoMKgIDYgKwo+IMKgLi4uL2R0cy9pbXg2ZGwtY29saWJyaS1l
dmFsLXYzLXUtYm9vdC5kdHNpwqDCoMKgIHzCoCAyOCArKystCj4gwqBhcmNoL2FybS9kdHMvaW14
NnEtYXBhbGlzLWV2YWwtdS1ib290LmR0c2nCoMKgwqAgfMKgIDM2ICsrKy0tCj4gwqAuLi4vZHRz
L2lteDZ1bGwtY29saWJyaS1ldmFsLXYzLXUtYm9vdC5kdHNpwqDCoCB8wqAgMTQgKysKPiDCoC4u
Li9hcm0vZHRzL2lteDdkLWNvbGlicmktZXZhbC12My11LWJvb3QuZHRzaSB8wqAgMTQgKy0KPiDC
oC4uLi9kdHMvaW14OG1tLXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzacKgwqDCoCB8wqAgMTYg
Ky0KPiDCoC4uLi9kdHMvaW14OG1wLXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzacKgwqDCoCB8
wqAgMTYgKy0KPiDCoC4uLi9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2LXUtYm9vdC5kdHNp
wqAgfMKgwqAgNCArCj4gwqBhcmNoL2FybS9kdHMvdGVncmExMjQtYXBhbGlzLXUtYm9vdC5kdHNp
wqDCoMKgwqDCoCB8wqAgMTIgKysKPiDCoGFyY2gvYXJtL2R0cy90ZWdyYTIwLWNvbGlicmktdS1i
b290LmR0c2nCoMKgwqDCoMKgIHzCoCAxMiArKwo+IMKgYXJjaC9hcm0vZHRzL3RlZ3JhMzAtYXBh
bGlzLXUtYm9vdC5kdHNpwqDCoMKgwqDCoMKgIHzCoCAxMiArKwo+IMKgYXJjaC9hcm0vZHRzL3Rl
Z3JhMzAtY29saWJyaS11LWJvb3QuZHRzacKgwqDCoMKgwqAgfMKgIDEyICsrCj4gwqAuLi4vYXJt
L2R0cy92ZjYxMC1jb2xpYnJpLWV2YWwtdjMtdS1ib290LmR0c2kgfMKgwqAgNCArCj4gwqBib2Fy
ZC90b3JhZGV4L2FwYWxpcy1pbXg4L2FwYWxpcy1pbXg4LmPCoMKgwqDCoMKgwqAgfMKgIDEwIC0t
Cj4gwqBib2FyZC90b3JhZGV4L2FwYWxpcy10azEvYXBhbGlzLXRrMS5jwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCA3IC0KPiDCoGJvYXJkL3RvcmFkZXgvYXBhbGlzX2lteDYvYXBhbGlzX2lteDYuY8Kg
wqDCoMKgwqDCoCB8wqAgMjEgLS0tCj4gwqBib2FyZC90b3JhZGV4L2FwYWxpc190MzAvYXBhbGlz
X3QzMC5jwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4IC0KPiDCoC4uLi90b3JhZGV4L2NvbGlicmkt
aW14NnVsbC9jb2xpYnJpLWlteDZ1bGwuYyB8wqDCoCA3IC0KPiDCoGJvYXJkL3RvcmFkZXgvY29s
aWJyaS1pbXg4eC9jb2xpYnJpLWlteDh4LmPCoMKgIHzCoCAxMCAtLQo+IMKgYm9hcmQvdG9yYWRl
eC9jb2xpYnJpX2lteDYvY29saWJyaV9pbXg2LmPCoMKgwqDCoCB8wqAgMjAgLS0tCj4gwqBib2Fy
ZC90b3JhZGV4L2NvbGlicmlfaW14Ny9jb2xpYnJpX2lteDcuY8KgwqDCoMKgIHzCoMKgIDggLQo+
IMKgYm9hcmQvdG9yYWRleC9jb2xpYnJpX3QyMC9jb2xpYnJpX3QyMC5jwqDCoMKgwqDCoMKgIHzC
oCAxMCAtLQo+IMKgYm9hcmQvdG9yYWRleC9jb2xpYnJpX3QzMC9jb2xpYnJpX3QzMC5jwqDCoMKg
wqDCoMKgIHzCoMKgIDcgLQo+IMKgYm9hcmQvdG9yYWRleC9jb2xpYnJpX3ZmL2NvbGlicmlfdmYu
Y8KgwqDCoMKgwqDCoMKgwqAgfMKgIDEwIC0tCj4gwqBib2FyZC90b3JhZGV4L2NvbW1vbi9LY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGJvYXJk
L3RvcmFkZXgvY29tbW9uL3RkeC1jb21tb24uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEz
NyArKysrKysrKysrKysrLS0tLS0KPiDCoGJvYXJkL3RvcmFkZXgvY29tbW9uL3RkeC1jb21tb24u
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxIC0KPiDCoGNvbmZpZ3MvYXBhbGlzLWlt
eDhfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4g
wqBjb25maWdzL2FwYWxpcy10azFfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAxICsKPiDCoGNvbmZpZ3MvYXBhbGlzX2lteDZfZGVmY29uZmlnwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArCj4gwqBjb25maWdzL2FwYWxpc190
MzBfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsK
PiDCoGNvbmZpZ3MvY29saWJyaS1pbXg2dWxsLWVtbWNfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqAg
fMKgwqAgNCArCj4gwqBjb25maWdzL2NvbGlicmktaW14NnVsbF9kZWZjb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArCj4gwqBjb25maWdzL2NvbGlicmktaW14OHhfZGVmY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGNvbmZpZ3MvY29s
aWJyaV9pbXg2X2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0
ICsKPiDCoGNvbmZpZ3MvY29saWJyaV9pbXg3X2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGNvbmZpZ3MvY29saWJyaV9pbXg3X2VtbWNfZGVmY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqBjb25maWdzL2NvbGlicmlfdDIw
X2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKg
Y29uZmlncy9jb2xpYnJpX3QzMF9kZWZjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAxICsKPiDCoGNvbmZpZ3MvY29saWJyaV92Zl9kZWZjb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgY29uZmlncy92ZXJkaW4tYW02
Ml9hNTNfZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgY29u
Zmlncy92ZXJkaW4tYW02Ml9yNV9kZWZjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsKPiDCoGNvbmZpZ3MvdmVyZGluLWlteDhtbV9kZWZjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgY29uZmlncy92ZXJkaW4taW14OG1wX2RlZmNv
bmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqA0NSBmaWxlcyBj
aGFuZ2VkLCAyODQgaW5zZXJ0aW9ucygrKSwgMTk0IGRlbGV0aW9ucygtKQo+IMKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtL2R0cy90ZWdyYTEyNC1hcGFsaXMtdS1ib290LmR0c2kKPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvdGVncmEyMC1jb2xpYnJpLXUtYm9vdC5kdHNp
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL3RlZ3JhMzAtYXBhbGlzLXUtYm9v
dC5kdHNpCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL3RlZ3JhMzAtY29saWJy
aS11LWJvb3QuZHRzaQo=

