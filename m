Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37314CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6200386BB4;
	Tue, 17 Oct 2023 11:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="InsAc23s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1856686BAA; Tue, 17 Oct 2023 11:37:22 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A7D86BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1697535438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E9/lGWRKeViuxFEUC5oge3UWr3LKi/5up2QKO4YOZ8=;
 b=InsAc23ssHZyE2UndvZ5j9qSGnjnlPtw83HOQRcq260/3iNwL5svCN8IASnkR04IMIhwIK
 3/EC/NNPVq+bzJrbASkx17P59Yu2llgCL1bx2aOjVeRqSdKMyqJkAR0TDMJnjZyMKqZfTD
 2XBXoFZFxSboBKgkJfV9LU71ltGvt9I=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-GvGVaP0BNL29QZsTbeA-UQ-1; Tue, 17 Oct 2023 11:37:17 +0200
X-MC-Unique: GvGVaP0BNL29QZsTbeA-UQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR1P278MB1172.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Tue, 17 Oct 2023 09:37:15 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:37:15 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "sbabic@denx.de" <sbabic@denx.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>
Subject: Re: [PATCH v1] board: toradex: verdin-imx8mp: enable usb device and
 fastboot support
Thread-Topic: [PATCH v1] board: toradex: verdin-imx8mp: enable usb device and
 fastboot support
Thread-Index: AQHZ2ffztWNQcPGufk6yF3m9pFMDZbAASM6AgE2+RoA=
Date: Tue, 17 Oct 2023 09:37:15 +0000
Message-ID: <88f5d27669f65a3d5a5218617fb99b45482c4f56.camel@toradex.com>
References: <20230828213803.454303-1-marcel@ziswiler.com>
 <CAOMZO5BF7Couci7E79=c5+4pryt1QNVh=YULvdW3ok0+TOo1Aw@mail.gmail.com>
In-Reply-To: <CAOMZO5BF7Couci7E79=c5+4pryt1QNVh=YULvdW3ok0+TOo1Aw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR1P278MB1172:EE_
x-ms-office365-filtering-correlation-id: e2bd7d05-2be0-48de-8905-08dbcef4a5c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: aKic3xqtzVUrj+q+WFLh6urkF24SnUV396Q5mlb/jEyPle+TY1xn2YY0iwSgiQTa2K1w0rwGXMt6JbodEK2Y+gUmacA/1EdhBNAIGGlEEH3WwuZAvFAnLEXJwF62KR7xXUggn+S1j0XxWCfYCEIzmz7exGDzJ6Jcef37djnGfECju1T/e7u3uAB0Es4+9bxV/Z9rqI6juflVVz0InvxxtX6bI3U+D5lUd6vg45U+DZCIElrOatfHfs4yFD7T0BHIzUlPI7y5rFvyeOCFDm06Av8eu/tnbvU7gyAGtGRd4uANHsvtED3r7BxuFNtdPR44NTPUkr7ntuQy4dKdJJFFEeSQKhaTh00xcOBtOoE93OBFQn+q8yMSPXk8uXhztKDGTpoCNWUylcrcMKkEofT6W50G3bSpkHoaAZbbZkeI1bWBO7zsv+PXW48CweEg6U34WtJcQCwjcBVvp2nVAbh7zx8u3fzycfp/F44OkF6b2A9idoLGd/cXfTn2HrCoJ2lcAgr+AZD/34rNKrxO5nYJMYlIbQ+SIOfBWJRm4uuWWRKNaAhHMll3isWCssbbsv/PsTug/0JiQqkAl9/rf7X5gKw46M0spWjlmPnFeE3gWdkgDAg18ovFRkS+leRIEhWQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(41300700001)(76116006)(66556008)(66946007)(316002)(66476007)(6916009)(66446008)(122000001)(83380400001)(54906003)(26005)(2616005)(38070700005)(64756008)(6512007)(53546011)(6486002)(6506007)(71200400001)(478600001)(8676002)(2906002)(4744005)(36756003)(4326008)(8936002)(5660300002)(44832011)(86362001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE5PYWI2bjBHenJsM2hSNEppdzFWek9sNDVzMHo2VEVXVTEyaUdWSkVhMC9q?=
 =?utf-8?B?WkVuSnRDZ1JwRit3cG1zSS9lbURGNlhLenNTbks1MU5hOFVmbWFvazhRU3pF?=
 =?utf-8?B?Zjh2Y0t5S0czMFBxTjUzckNoSlRxKzYwYkdGY1dWdzZxbloxdUdURWxlR21C?=
 =?utf-8?B?dmNCRGJsTStQMml6cE9QcWZJaFljSmxmTXlBa3A1ZS83TTZZQnluT3l0b25X?=
 =?utf-8?B?QldqNU5nVXpzOUJjMmZDWkxHWWc5RFhuSlJJMFdvNHdnZUpQakNPRFhBL2Zm?=
 =?utf-8?B?R013dVJmeHMzazR6bm1raUI1ZVgyYVBhZ0JFamMrcmVIaXRZckljczhIWUNz?=
 =?utf-8?B?VGNKWEFvVjFvZm1aU3hlSUxGVDZhbEw0NUNaYzVScGFkc2sreHZUbW0yQnlq?=
 =?utf-8?B?SDlTcDV3M2xGQ3RiSSs1dUM4dll0SUtmMXh5eWRONWN3YWd3dTI4Z3lWL2F3?=
 =?utf-8?B?Z2Z4VndCRTd4UGhFdGVzY0YzbmFOKzhzdUZZV250L2ljZWJENDZvMjN3dmlt?=
 =?utf-8?B?ZUFLTHI3cW9KY0Y3SGpkNlpTZ0s0T1VLRHd3eTNxbWJ1cSt0cGZzcTZMeDIr?=
 =?utf-8?B?Q2tTT2R3ZktBNHlNUFB5cHM2RWVBOTdUQ1IxOW81Q1pDNmtOeXNRY1BrSHZr?=
 =?utf-8?B?RmU2UzlEbFI3MmRYT1E3V0tnZXpIcUxlMnhXTjYyNjlxdmVCcXBJYmxmN2Jx?=
 =?utf-8?B?L1BYdXprSGpSVWpwVlhXOE1sSDZOSlZaMm5ST213b1pHeUdXTjN4bTlZT0JT?=
 =?utf-8?B?TVpvYVdmT0RQZUtXNDNVc25Qa3RCZXZhNE42ZGp3OW9JaUsvVXJFbUlqWTZF?=
 =?utf-8?B?NzFCUG9QcDVDcnp4OVZwRlpvVHN2NXJsREc5RmNMY0VVRmdVUjY4N2tPUFAy?=
 =?utf-8?B?U2hjOGV3ck9qTzZqTDlwTmZJd3RMNThaS2VKYWV3aEVFbUdXMGdkTW1SaFNH?=
 =?utf-8?B?WUVmT1IyUUtNS3dsandsQVVkTStoc1VLSE8zd3doY0tkYnlleERtTHZ6bDVJ?=
 =?utf-8?B?UEpsL215T0QzRnF6aUJickRpSjhQRWRrUUgrS2RnaERFN3ZjTmdjQmZoM2Fx?=
 =?utf-8?B?c1NvcHNQdWtrUjdRaEFTMitKT2hyRmY0QjViV25mMmNnM29GVlM0RU1TblZl?=
 =?utf-8?B?dHQvU3lEd0lMVlFkUVFzYnhPdlJJMkY4Ni9wRXJBUlFOZTJXbkJYeWVvblV3?=
 =?utf-8?B?RzY4VllIdGJWVlBKaVJ6M2RRMlUrM1RLSGxTY3MwKy8xT1NuNk8zeW1zODJh?=
 =?utf-8?B?a0l3VUlnYi81bnZSK202eE05aGVuSXhkOTZsSnkrR1ZCTmc4UWthSGw0NW42?=
 =?utf-8?B?ZVhBekNLQXRTUkY0NlB4ci96NmJzR1ZicUpha2t6RmMxcmZXd1Z1cHd0OHBl?=
 =?utf-8?B?MldzK0JIZzJlQmtwMEJGMzFqMzZTMXB6bnlyUWNNQjFvN2d3ZDJaNG9FTmph?=
 =?utf-8?B?Qk53K3ZwLzJkajRVSWNwbGxRMGc3VmFmcXVKKzBkODMwN2FPMU5PM0RGVkto?=
 =?utf-8?B?M0YzcDNvWEkxanUwbkZhaENFQVc0dDV2UzladVJTVE01S1ZPcVlWT01kM09B?=
 =?utf-8?B?Z254cUl2T2lNT21SbEVFL25GTnlIdEFzK043ZWZXYzBQTyt6MDlId0hPWm1K?=
 =?utf-8?B?VFJ1blRYWkZWRFY4Rnc5eWRNTEoxU2J0TXpldGEzbURBNWtBMzUyeGNYNzVh?=
 =?utf-8?B?a0U0ZlpxdTFzV1F6TmZhTUxNYVd2cUpDald0MjBIcnNnZmFDZzNkamN0MzZG?=
 =?utf-8?B?OTY0dmhib2Q2ZkJvMzJaUHpKVDJzL3YycFU3dTN4SmRkVzU0OHpJRXJxK1Bm?=
 =?utf-8?B?akFnTVBsNXlwRFVoTnU5eWkyYzA4aTUzTEx3bU05TGN4Ui90ZlFzeU1rWVVH?=
 =?utf-8?B?bFZuWnFNTWdQT2VhbFVNY0wxY0lrZlMwOE9LZ2k3emhHamR6bzFkUlVmcmxN?=
 =?utf-8?B?QWprNTlwR1AxSXJackpGQlRvMFVIczJQZkJBNE0renNaQTl5YlVKMzlMeWJP?=
 =?utf-8?B?VDFiU2w4RG1YTnRsLzU3WTkyQmZ5emdUK29MY25LWUN3cFdyNUtoTEovVWs4?=
 =?utf-8?B?d2gzdzVnYS9NYk5mZDY1VEdIdDRkSDdLcm5wYStEV2thUTh0c09YbUo1aEZL?=
 =?utf-8?B?UEh6TTFqNjVoMmFuZDNyaC9peEw4RzBuTTBNcHR4dWxFU2tEOEcxbzVPQkhh?=
 =?utf-8?B?cVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd7d05-2be0-48de-8905-08dbcef4a5c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:37:15.1550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nufhy1I5jOlev6YrViVbl1O0GMLrVz441h8LMgZGMluIsCa4VYLjMyOVwF+MyIfPH+L4dYRlrow3mED7UB00D5yx6NxSrEHZc8EIPSWRR+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1172
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <447370E384621A499A0988C080D48528@CHEP278.PROD.OUTLOOK.COM>
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

SGkgU3RlZmFubw0KDQpNYXliZSB5b3UgbWlzc2VkIHRoYXQgb25lIChpLk1YIDhNIFBsdXMgdnMu
IE1pbmkpPyBUaGFua3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg0KT24gTW9uLCAyMDIzLTA4LTI4
IGF0IDE5OjI0IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPiBIaSBNYXJjZWwsDQo+IA0K
PiBPbiBNb24sIEF1ZyAyOCwgMjAyMyBhdCA2OjM44oCvUE0gTWFyY2VsIFppc3dpbGVyIDxtYXJj
ZWxAemlzd2lsZXIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiBFbmFibGUgVVNCIGRldmlj
ZSBhbmQgZmFzdGJvb3Qgc3VwcG9ydCB3aGljaCBtYXkgYmUgdXNlZCB0byBsb2FkIHRoZQ0KPiA+
IFRvcmFkZXggRWFzeSBJbnN0YWxsZXIgRklUIGltYWdlLg0KPiA+IA0KPiA+IFdoaWxlIGF0IGl0
IGFsc28gZW5hYmxlIFVTQiBtYXNzIHN0b3JhZ2UgYWthIFVNUyBzdXBwb3J0Lg0KPiA+IA0KPiA+
IE5vdGUgdGhhdCB0aGUgaS5NWCA4TSBQbHVzIHJlY292ZXJ5IG1vZGUgc3VwcG9ydCBpcyBiYXNl
ZCBvbiB0aGUgVVNCDQo+ID4gYm9vdCBzdGFnZSBvZiB0aGUgQk9PVFJPTSBhbmQgZG9lcyBOT1Qg
cmVxdWlyZSBVU0IgU0RQIFNQTCBha2Egc2VyaWFsDQo+ID4gZG93bmxvYWRlciBzdXBwb3J0Lg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVy
QHRvcmFkZXguY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFt
QGRlbnguZGU+DQo=

