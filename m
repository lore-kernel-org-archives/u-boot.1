Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3689CE784B9
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7843870DE;
	Mon,  2 Oct 2023 16:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="CuFKb1pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3988714B; Mon,  2 Oct 2023 16:50:23 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B877C86E03
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1696258221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dn4dKpaQFIL5E+2pEBNIFmKK0bPiEa9uq5jXNHaWqhA=;
 b=CuFKb1pbJRkvauLMt8hSJ99T3LX93eVfKb5BQCDn0kbGbRMER3o+iQnLsZTD1odHUTz/Av
 meoMO2EmPipqgidbzeWCjKTKHue1lLCJgurmnATV3ydc5gwLlFCPEsqOmxZTDMJ7gVO2gc
 Al84ZSNdEprQ7i4QWRlDj0fgo9UIWu8=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-j7AhxbJrOrW1xHoTBfyYCg-2; Mon, 02 Oct 2023 16:50:19 +0200
X-MC-Unique: j7AhxbJrOrW1xHoTBfyYCg-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0149.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Mon, 2 Oct 2023 14:50:17 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 14:50:17 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "hiagofranco@gmail.com" <hiagofranco@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Hiago De Franco
 <hiago.franco@toradex.com>
Subject: Re: [PATCH] toradex: colibri_imx7: Enable nand/emmc detection and set
 boot variant
Thread-Topic: [PATCH] toradex: colibri_imx7: Enable nand/emmc detection and
 set boot variant
Thread-Index: AQHZ9SgBlymGukDcBk6Dgiw9clO48LA2lTAA
Date: Mon, 2 Oct 2023 14:50:17 +0000
Message-ID: <684743400d2b2f2c48eccd930761bc886c2ad476.camel@toradex.com>
References: <20231002115749.15160-1-hiagofranco@gmail.com>
In-Reply-To: <20231002115749.15160-1-hiagofranco@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0149:EE_
x-ms-office365-filtering-correlation-id: bbd2965f-8b13-4015-da08-08dbc356e496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: vRmiqcPX2G8B8cfXSf6LmiJ18fsXhk4QZFBbj29K2sVZLqX4kuwXxAQasLWXK3H+ZSjLsbvvMzbcJB2HHWceK+baPY49hqa7T2YBxG/9MralP2GzJnbyLTpOkzeLu8mmF2siFjuEJ88xn62js9QktsXpS12c6azIvXnSxnpUM20jwcEfHfSGXCBIOu6C1YPsCpfUGoBngBPV3LFH57yCteLrphLxxTmz9SBehmyTVZVCwpN88lIjut+Lwi1X4Nk7AIP5015U6jDMLGORZz+iByheuJ0Fub5SMV8rWwHiSddAAWC09wvaVFdNs1XUgbECG5nQrH3wX6nYhfe57z18DJ8dsqrIBahd+vmYFfxvfxxJ6/bcejP7RAIQQEkcKubqNrzDGPtiz/Xs91TIeWNNUTe8f7Bp4Y5/nXTdqSE9PJOasOwuv3ltLw1Z8vGjodbuPFhECgTz3X+1gUrR6O/4ICkGtw5EugRZZXh0cfaejjVAz/5VEoSCw885F/3O+RFaKOemPbru3wvG+J55ag1g2JsN5q1BdhIsvU1GG8+BhyZoSXP4amvh6Hvos3PHd4x00KSdiGYcURYeczSF+JB6cp/EoSi9XNebblMrvGMO44GIFR5f8AxA1QITGgN6K5N3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39840400004)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(4326008)(8676002)(5660300002)(2906002)(8936002)(41300700001)(54906003)(64756008)(6916009)(76116006)(66946007)(66556008)(66446008)(66476007)(316002)(71200400001)(36756003)(2616005)(6512007)(107886003)(38100700002)(38070700005)(83380400001)(86362001)(122000001)(478600001)(6486002)(6506007);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRacCs5TE1Yd0c3ejZIc2R1b3BMcXROZGVxMmw0OFJyQm1RbFFTdDJzdU9F?=
 =?utf-8?B?MEJ1SC9uSHk4M0Zyb1JsNzZ4ZkdMcnoyVW5FU1JiTllld05lQUNaa3J0dkU5?=
 =?utf-8?B?VVUwWmNnZnNiakwrcXh1Z2JpRUlUcGFFakhVVm1JQm5IUENIUWFZYTNmYnEx?=
 =?utf-8?B?UDQwTVdURzZQRUdIS0pwSFFsaUlXYUJJRHVCd2VUbTVIejA2RUo4cGtOb2NU?=
 =?utf-8?B?SGpmSzRmd0xWd0E1MkhIODBSa2ZOVHZjbmI4YzVEd2J5YWl1a3AvUUdzc0M1?=
 =?utf-8?B?U2E1dnU0WFZCVXN4OHloMjRyVVZUbUE1T3c5Qm5iWmRkMmlSTUhJWThsalgy?=
 =?utf-8?B?WWJZRUl3b3REdWVRY3NDUFNudXpiZFRpKzVUaG8wdmhMVDVqNWxsbm9lZ3NT?=
 =?utf-8?B?anhJWTNGNkpTWkg2OWVMQ09YMUpsTnVYZlhXSnZRZEUxYTBuVWoyTk8rK0Zz?=
 =?utf-8?B?QWE3eUtsU0NEdjY0R1hYNTNRTlp3cTBIcFBXd3IvN3FtbkM4ZXNDQzEveG9j?=
 =?utf-8?B?SXQ3WmxWMzFpekNwenpnZWlhRXBTdVJkMGw5OXJGUEc3d1pIUjZXbTVPOW1L?=
 =?utf-8?B?ak85bnBiY0NZQWp2QVZPU0NCRkswRXdTZVhwZXhYcGRHQU42UUFMSFp1bWt4?=
 =?utf-8?B?Y0RWRDJtenRyVWQyNXZ5U3B2UDd6VnM0MWZjcGZ2a0dIQ3VVZzFhS3I1SElV?=
 =?utf-8?B?SnFhOW9IKzIzRG5jcVFoWUY5SUIxVlQ1MWl3ZHNMQ2ZNa3F4YVlhNG5sb3B4?=
 =?utf-8?B?aFdDUVFFQTdqV3dtYkQ5eWxlWlo5T3NUcHE2WmM2TmtCT3RSeHVheWFUaDRU?=
 =?utf-8?B?cUJ4NjdrSXAzTnZkRFhpTzlpdndjbmF4V2tJYkl4OFdoZEdZZWxyYkFjT1dr?=
 =?utf-8?B?K2JOVXFobTRzSzFnU0UrK0ZlQUdEWTlLcHVCRWtkMDNVQURZbE5PeGNwa0dH?=
 =?utf-8?B?SXY5dW9KNzZHaHBJZTRCR3RuZlkrNzVwRnBRQWRzWjNrSzFVWGRoK3FpY1Er?=
 =?utf-8?B?Mm5aelBlV0hJeEUzRm9pbVJzRjJUZVVrdUUzOTYrRlN3eXVLNjdsZ1N0TVJL?=
 =?utf-8?B?ZWZFaUxNMnhJQ0NYVG9SYVN1Z3c2cWhYYi96eFVKNG1uZUxaL3dlZTNCVWx3?=
 =?utf-8?B?MnNVOWgwcmdmU1haOHhjL2tDWVVhbjdockhIQWg0clVJVGtNTHlTeXlWN2gy?=
 =?utf-8?B?SDYvUE9BZDYySDd5N1J0Ym03NnZSUHlsazlYTWFNTUNsZHZCc0ptNFdCSHRQ?=
 =?utf-8?B?aU1oSmRFUXo0NFc1SVVqZ0hUbTlkOFZSY0NZMzZvYXRVaGd0MGtCb3JGem4v?=
 =?utf-8?B?bFljQjNHZVZxd0IrdHNxRThiOC8yQzN6RkQyWGxZdzdUMldBRTMxUGZHNWxh?=
 =?utf-8?B?UEFjbVEzdHlPU0VvVFVMRVQwcjRHVFFrV09UTjdIdG1JYkRpQzN0WnZ4SFpx?=
 =?utf-8?B?OUN1SC9UWGZ0TmZqd1praEMwSkZIVkhtQm95TFRNdUh1R25GdWwwVjhNUHV1?=
 =?utf-8?B?elZrZnZ2YW9DZWlrblVLa3p6TU1DMEMyVzhYT09SUXZuVlcyZkpXUi8rVHZm?=
 =?utf-8?B?cTVxdWEvd0dBL2g3cVdLNCtDN1Z5ZVY1Qy8zQ0pWcEdIMjMyT0sxaC9xSHNI?=
 =?utf-8?B?VWNsRTYvYTAyV1crK3RHb3B6MTNsMzZnZ0VoT0dUK3Q0N0hkZzF6SUN3Rmpv?=
 =?utf-8?B?QS9PZjU1Mmo1ZmZlNWZkRXRRMTRnbktVQ3kwWmRCRWtOZDBFNVI0blFNOXRr?=
 =?utf-8?B?WTFKWHRobEJlT3B2LzVBdmZKZFo1VzFMbW1MdHVOOUhxMDFpYWpaaGlmMXNT?=
 =?utf-8?B?SEpVS1VuYzlRc3JrU2pkVUhFL1pxNXFCRWx5U2RIQUVqK2IyQmE0RFgxMlhX?=
 =?utf-8?B?UzU2a2JFWEZ3dHRGRnZCWlM4cnVvdVlkbkRycHFXTmsyQ0UvZnpLT092VUVh?=
 =?utf-8?B?b3cyQ1pFV0d4bllnUjBxa2hSckZUaTA3RWo2N2ladjMvejhKK1hPTDZqQ2Yw?=
 =?utf-8?B?aDZGdXpLWkZiblNVMG4vY3p4MS9HQmZMVExpNHgxMjNSQTNTbkZ5OWh3TW1t?=
 =?utf-8?B?cTJqQTFKTFJRNmRzMGZtSVV2bWlvTUR5YzFENFhFZ3ZTYkJLOUJNUVRkOUtX?=
 =?utf-8?B?ejNzbU85VEdOYzF4VjRjS1N6ZFBuVndGOUdVdW8vMlc4bDlIK0FDMXdvVDZp?=
 =?utf-8?Q?CohdCEtBGKVqbB7jA5NslpA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd2965f-8b13-4015-da08-08dbc356e496
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 14:50:17.2754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDeHMB4pDF/vnMIR51HTDqHjKPeuphnQzQX3ag+yXDvenAEfZ9PV6yMwTyzCiaxE9Z8O6ASqBEl3IeCHg4WGZSZtob0KnZfnEWVQ8yY7XAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0149
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <A4F83ACFA7F88047AE211C5CA85696FF@CHEP278.PROD.OUTLOOK.COM>
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

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDA4OjU3IC0wMzAwLCBIaWFnbyBEZSBGcmFuY28gd3JvdGU6
DQo+IEZyb206IEhpYWdvIERlIEZyYW5jbyA8aGlhZ28uZnJhbmNvQHRvcmFkZXguY29tPg0KPiAN
Cj4gQWRkIGRldGVjdGlvbiBvZiBlTU1DIHZzIE5BTkQgZGV2aWNlcyBvbiB0aGUgQ29saWJyaSBp
TVg3DQo+IGJvYXJkLiBBIEdQSU8gaXMgY29uZmlndXJlZCB0byBkZXRlY3QgdGhlIHByZXNlbmNl
IG9mIGFuIG9uLWJvYXJkIHJlc2lzdG9yDQo+IHRoYXQgaXMgY29uZmlndXJlZCBkaWZmZXJlbnRs
eSBiYXNlZCBvbiB0aGUgZmxhc2ggbWVtb3J5IHVzZWQuIERlcGVuZGluZyBvbg0KPiB0aGUgZGV0
ZWN0aW9uIHJlc3VsdCwgdGhlICd2YXJpYW50JyBlbnZpcm9ubWVudCB2YXJpYWJsZSBpcyBzZXQg
dG8gJy1lbW1jJw0KPiBvciBjbGVhcmVkLCBpbmRpY2F0aW5nIHRoZSB0eXBlIG9mIHN0b3JhZ2Ug
ZGV2aWNlLg0KPiANCj4gVGhpcyBlbmhhbmNlbWVudCBpbXByb3ZlcyB2YXJpYW50IGRldGVjdGlv
biBkdXJpbmcgc3lzdGVtIGluaXRpYWxpemF0aW9uDQo+IHRocm91Z2ggVVNCIHJlY292ZXJ5IG1v
ZGUsIHdoZXJlIFUtQm9vdCBpcyBsb2FkZWQgZGlyZWN0bHkgdG8gUkFNLiBUaGlzDQo+IGFsbG93
cyB2YXJpYW50IGRldGVjdGlvbiBmb3IgYW4gYWNjdXJhdGUgZGV2aWNlIHRyZWUgc2VsZWN0aW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGlhZ28gRGUgRnJhbmNvIDxoaWFnby5mcmFuY29AdG9y
YWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0
b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gwqBib2FyZC90b3JhZGV4L2NvbGlicmlfaW14Ny9jb2xp
YnJpX2lteDcuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC90b3JhZGV4L2Nv
bGlicmlfaW14Ny9jb2xpYnJpX2lteDcuYyBiL2JvYXJkL3RvcmFkZXgvY29saWJyaV9pbXg3L2Nv
bGlicmlfaW14Ny5jDQo+IGluZGV4IDExOWU2N2I0N2YuLmYwMzU2YWYwMDggMTAwNjQ0DQo+IC0t
LSBhL2JvYXJkL3RvcmFkZXgvY29saWJyaV9pbXg3L2NvbGlicmlfaW14Ny5jDQo+ICsrKyBiL2Jv
YXJkL3RvcmFkZXgvY29saWJyaV9pbXg3L2NvbGlicmlfaW14Ny5jDQo+IEBAIC01Myw2ICs1Mywx
MSBAQCBERUNMQVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4gwqANCj4gwqAjZGVmaW5lIFVTQl9DREVU
X0dQSU8JSU1YX0dQSU9fTlIoNywgMTQpDQo+IMKgDQo+ICsjZGVmaW5lIEZMQVNIX0RFVEVDVElP
Tl9DVFJMIChQQURfQ1RMX0hZUyB8IFBBRF9DVExfUFVFKQ0KPiArI2RlZmluZSBGTEFTSF9ERVRf
R1BJTyBJTVhfR1BJT19OUig2LCAxMSkNCj4gKw0KPiArc3RhdGljIGJvb2wgaXNfZW1tYzsNCj4g
Kw0KPiDCoGludCBkcmFtX2luaXQodm9pZCkNCj4gwqB7DQo+IMKgCWdkLT5yYW1fc2l6ZSA9IGdl
dF9yYW1fc2l6ZSgodm9pZCAqKVBIWVNfU0RSQU0sIGlteF9kZHJfc2l6ZSgpKTsNCj4gQEAgLTYw
LDYgKzY1LDEwIEBAIGludCBkcmFtX2luaXQodm9pZCkNCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0K
PiDCoA0KPiArc3RhdGljIGlvbXV4X3YzX2NmZ190IGNvbnN0IGZsYXNoX2RldGVjdGlvbl9wYWRz
W10gPSB7DQo+ICsJTVg3RF9QQURfU0QzX1JFU0VUX0JfX0dQSU82X0lPMTEgfCBNVVhfUEFEX0NU
UkwoRkxBU0hfREVURUNUSU9OX0NUUkwpLA0KPiArfTsNCj4gKw0KPiDCoHN0YXRpYyBpb211eF92
M19jZmdfdCBjb25zdCB1YXJ0MV9wYWRzW10gPSB7DQo+IMKgCU1YN0RfUEFEX1VBUlQxX1JYX0RB
VEFfX1VBUlQxX0RURV9UWCB8IE1VWF9QQURfQ1RSTChVQVJUX1BBRF9DVFJMKSwNCj4gwqAJTVg3
RF9QQURfVUFSVDFfVFhfREFUQV9fVUFSVDFfRFRFX1JYIHwgTVVYX1BBRF9DVFJMKFVBUlRfUEFE
X0NUUkwpLA0KPiBAQCAtMTgzLDYgKzE5MiwxNiBAQCBpbnQgYm9hcmRfaW5pdCh2b2lkKQ0KPiDC
oAkvKiBhZGRyZXNzIG9mIGJvb3QgcGFyYW1ldGVycyAqLw0KPiDCoAlnZC0+YmQtPmJpX2Jvb3Rf
cGFyYW1zID0gUEhZU19TRFJBTSArIDB4MTAwOw0KPiDCoA0KPiArCS8qDQo+ICsJICogRW5hYmxl
IEdQSU8gb24gTkFORF9XRV9CL2VNTUNfUlNUIHdpdGggMTAwayBwdWxsLWRvd24uIGVNTUNfUlNU
DQo+ICsJICogaXMgcHVsbGVkIGhpZ2ggd2l0aCA0LjdrIGZvciBlTU1DIGRldmljZXMuIFRoaXMg
YWxsb3dzIHRvIHJlbGlhYmx5DQo+ICsJICogZGV0ZWN0IGVNTUMvTkFORCBmbGFzaA0KPiArCSAq
Lw0KPiArCWlteF9pb211eF92M19zZXR1cF9tdWx0aXBsZV9wYWRzKGZsYXNoX2RldGVjdGlvbl9w
YWRzLCBBUlJBWV9TSVpFKGZsYXNoX2RldGVjdGlvbl9wYWRzKSk7DQo+ICsJZ3Bpb19yZXF1ZXN0
KEZMQVNIX0RFVF9HUElPLCAiZmxhc2gtZGV0ZWN0aW9uLWdwaW8iKTsNCj4gKwlpc19lbW1jID0g
Z3Bpb19nZXRfdmFsdWUoRkxBU0hfREVUX0dQSU8pOw0KPiArCWdwaW9fZnJlZShGTEFTSF9ERVRf
R1BJTyk7DQo+ICsNCj4gwqAjaWZkZWYgQ09ORklHX0ZFQ19NWEMNCj4gwqAJc2V0dXBfZmVjKCk7
DQo+IMKgI2VuZGlmDQo+IEBAIC0zNDgsNiArMzY3LDExIEBAIGludCBib2FyZF9sYXRlX2luaXQo
dm9pZCkNCj4gwqAJCWVudl9zZXQoImJvb3RjbWQiLCAic2RwIDAiKTsNCj4gwqAJfQ0KPiDCoCNl
bmRpZg0KPiArCWlmIChpc19lbW1jKQ0KPiArCQllbnZfc2V0KCJ2YXJpYW50IiwgIi1lbW1jIik7
DQo+ICsJZWxzZQ0KPiArCQllbnZfc2V0KCJ2YXJpYW50IiwgIiIpOw0KPiArDQo+IMKgCXJldHVy
biAwOw0KPiDCoH0NCj4gwqAjZW5kaWYgLyogQ09ORklHX0JPQVJEX0xBVEVfSU5JVCAqLw0K

