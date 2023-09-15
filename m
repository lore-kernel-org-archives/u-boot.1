Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB6EED604
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 15:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE5686545;
	Fri, 15 Sep 2023 17:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="ZKlRbYoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AF386560; Fri, 15 Sep 2023 17:17:38 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922C98654A
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 17:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joao.goncalves@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1694791056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cp939nDLMlSVRGKHlAaF1B+1vzFvuHHuIYPJyWE3Q8s=;
 b=ZKlRbYoPodWTrqlO5D8C8n7hqPzGijZZRQKSQm1j3EWflogocjsX2TpVcm9G8h+XZd0Qkq
 2NFYEi5hA4jKxs0486NJs4sh5ydcc8QJvrJJObh49xQ4C43Sixy5A9wWvyocAd1Tpmn6J6
 fBLgmp+aSFGynK1yZLsNgubBL6XN6iU=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-62-9ynGrwV-P1KJoGZKy01YnQ-1; Fri, 15 Sep 2023 17:17:34 +0200
X-MC-Unique: 9ynGrwV-P1KJoGZKy01YnQ-1
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::5) by
 GV0P278MB0952.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:51::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 15:17:32 +0000
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6528:7071:f23d:6401]) by ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6528:7071:f23d:6401%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 15:17:32 +0000
From: =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>
CC: "lukma@denx.de" <lukma@denx.de>
Subject: Re: USB: error messages on DWC3 gadget endpoint dequeue
Thread-Topic: USB: error messages on DWC3 gadget endpoint dequeue
Thread-Index: AQHZ59VTV1XKDqmqN0a6Mhj0jFvbb7Ab5rEAgAAZIAA=
Date: Fri, 15 Sep 2023 15:17:32 +0000
Message-ID: <ea2b02c46b6159db5d9e5c22dcd4788fa0f53243.camel@toradex.com>
References: <6c9901297ce8cda6ec83304187582b3d658a6457.camel@toradex.com>
 <bb43c4d4-8d01-49a7-76b1-2f1a3c78918f@prevas.dk>
In-Reply-To: <bb43c4d4-8d01-49a7-76b1-2f1a3c78918f@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0873:EE_|GV0P278MB0952:EE_
x-ms-office365-filtering-correlation-id: 9c51e8ac-1ca4-4bad-70c3-08dbb5fee26e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: GMKpzR/u4k4+DCK8bN9r/KLoIj8a/0nIymGp2opx3UA7k9VJ1rER6CKATTlATs87QU3L3RQoAx+N5qW0ieLbNOPsQQxxhsw+UviOKeOK6q9ojbIQTUvhUIRgbnpmmYGiklaFuTN3ywzBRzXQWUE4KZUgMwBlQwX0LfoAyeRkrSYHZvUDRH71epzsNJI2Tdx9bQLtUHR2gKhoib06GwmvlgSsRnieXAACcKWRzEua5OQtrTQIPcF6YM1i0jrLOsX/kZBkAlNYheZ8Ccty+ZEJZjM+3RJZ4PI9UT6f/qHHqgSkbLFg7JNAYkGgkBXJc/okhRkgdQwGpbS4t1nIl7JYHVUCwaIozJQEbPUb/frbMul4PpEvf5FO6Z/Z1Tut9yx0wL8WPg5PbyzhLrPNmgZXh0PifpPzkrxsWeVFTkI8dHZ3UMBF7r3y5ODhsCIdiLBfTLckQ4FizVYMLcaJRFCltNXap/c/Qsf9ZoZhC8c+pqxZL84dEaESK3xQp0PI8e7nkmlhuXD+4sAvATNQIsnXctiYiP8Y3a5qJS5MkoPHo+s2f+QM9jR4GYi3wQ+1o8+Nz93GzQ62beDv29E6rryhVoUuNHkLC/bHbPZxlOxU1pA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(376002)(346002)(136003)(366004)(451199024)(1800799009)(186009)(71200400001)(6506007)(6486002)(6512007)(966005)(83380400001)(478600001)(26005)(2616005)(66574015)(2906002)(15650500001)(76116006)(64756008)(66946007)(66556008)(66446008)(66476007)(110136005)(91956017)(316002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(85202003)(86362001)(36756003)(38070700005)(85182001)(38100700002)(122000001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmZQQkpRaFNaQnVzL2xSQXh0dWVJZ3hHVUd0aFVmdFRKSTU0MFlJSUlmYlVq?=
 =?utf-8?B?TnAyUWdGSXpsa2dKMUtsNDNrK0pMZlpaZ25hTjhEVk9XNWxiNTdIY1BtTDl6?=
 =?utf-8?B?cTdabXhDaGhPeEMzMEVMaWZRMDZLMXVKZkozRzdaK1J5aVhNbnR5dFNMbWRP?=
 =?utf-8?B?UmUxVDVsMFBwVzk1S3Q2U2dkWkNmTWx5L3laejhuY2JBNnNGU0IrREhaUTRF?=
 =?utf-8?B?ZzkzdWt1MVVjWndoMzFHcEhpSzlISEkraDc3WEhzeWdya01nZzRrMDkxcWJl?=
 =?utf-8?B?RER3clN3MTFqTW9BTzdMMjBPUDBLcFpxWWV2K0VEL0FsNW5qV0pkbUZBbmgy?=
 =?utf-8?B?MUt1di9nZ1hQRklmc1c0bHJxWXFDSTJuUHBlQ1pWbGxYZEMwL3E1b21UUFFS?=
 =?utf-8?B?QW9vaXZ5Njd0VjZEUmZUN1NRRTVONFhhSHRDdjF2OUNKK25LVndqOUQ2KzlK?=
 =?utf-8?B?b3pZNStDVGsyWHlrTzcvQmVHNmJOdjJXTVlzblhRNlFVcmwvSlRUaHVoY1E2?=
 =?utf-8?B?Ym8vNG5iUWt0RGhsS2RFZVpyRENTamNZNW5WYktnVzNOZ1R5K1lsdDNpYWlB?=
 =?utf-8?B?VWp4blp5dXlFaFFTamE4WjdqbW9VR1V4ZVE2VnR1WnpINng4YzhiRWZ0ckps?=
 =?utf-8?B?eFYvYlNUM1V4S2NnNHUzdEM2VWxlL0Z1cmovZWFJVVkrQXY5QjdkZnBkczVC?=
 =?utf-8?B?YUJib1NUQWU3M3ZPM2xMZmtGNnJTRmdFeldFc0hwQ0hpeUtvTVhoYll2S3RO?=
 =?utf-8?B?cXpPNVQzNkQzMkRBUEpLWWpCZXY1L1VNSVBGbVlYaTRBQXkwZ1N4U05xV0Jl?=
 =?utf-8?B?dEpZTW9BVk9MeklRcGlobmZTN2dZTkY3YUlTUE1HVEdtTSs2Y0lxdzlKb1FF?=
 =?utf-8?B?QkxwZnUyNjR1MmFRblUvYnNJU2FwQWlvblhEY1FkOEpKeWwwZ0tPYk9GQi9P?=
 =?utf-8?B?Q3RWR1l5RlNSUDRnVW9EK1FEYmNTUHZQQTRmZ2lhWWlJY2h5eUh3eElGOGxs?=
 =?utf-8?B?U0o2ZWlma1Q2bWJ0TzRHVW5mU0xwdVhDYkJkWjQrUWYrRVN0ZXp0dFFUK1pr?=
 =?utf-8?B?ZHBqeEVPUjVlUEo5c3FnaXk0QkZKSUE0VWU0aC94d3dRcXQ2b2VScFA1Uzlo?=
 =?utf-8?B?aXJseFRYcnRqck44Y3ZvZ3h5WkFtNHkzbTRYa0VTdWMyYmNxeVEzcjMrSS9B?=
 =?utf-8?B?Um5DcDkycjZTK2tTVEtYZVV2b2lObXNxTGcyNU1vK0dTSmFpL01FUW1lVVRt?=
 =?utf-8?B?WjlWaTV5VC85ZGFkWGJqWVRDMWR5c210aGFrNXdjaGUxak55MjVmMDRpekJJ?=
 =?utf-8?B?WGhLTDBLdzBxNHJLMjQ1dXdvYXMwZEtPYkZuQkVIMFJPODZJMzRQR3gvSURt?=
 =?utf-8?B?MENjSGR1eGJRNDNtV3NlNUVtS3dncEtLRFRZR1RKYWQrbzFqZFErYkw4S2Iz?=
 =?utf-8?B?L1BXSGpMZkV3UUxPYnBRZ3pUYkZDZGI3MWRzZSthVlVIR2M4SXRwTmNRRUcv?=
 =?utf-8?B?Q3UwTG0yTC9aNVV5K2NuZnFMODMwRVVENTVGS1Nia1cvRVVGelJNZTlGcjNB?=
 =?utf-8?B?MzNIcUZRM0wrOFVob0Y4MjZBcGdTbG9LRmFHbUtGWmNkK3d4b0tTbFZvbHIy?=
 =?utf-8?B?Tk9ySGQzVklHSk1HTkYvNVhKdEVmSVlBMkljZ2RRblhNTTc3MnkrUkYxbktm?=
 =?utf-8?B?RE9Ja2VlZGh6ZUEvN2g4SkNyVHYrV1F4Zzg1VUZXZDJvK3lnWmVadU1HQVhi?=
 =?utf-8?B?dTJCMHBZb1pEeFlRQU5XWkM2eU94MHFYd0htRU1Xak41czRSQ2l4WVduR0ZV?=
 =?utf-8?B?ekRFZkdTOEk3S21acUU5dkdRdXdsVVNVRlZkbWk5RitQeEJGci9ZUWxTUmU5?=
 =?utf-8?B?RGdyUlJUaEVNNGJLbThRUGFGc1pYSnJ5N29kZk1ybGxiY3RxclYxVjYxeWQr?=
 =?utf-8?B?bFcxTnNjTldyMzZKQWJzekszSFJYTWhLLzk3QkhodmhDM3JVOFRBK0dhNUJw?=
 =?utf-8?B?VXpvZnVxOCtDUndBT1puMis2UDRpWE5KbGtlNjBlcWM5dXhZS0c2UVlHd2Ra?=
 =?utf-8?B?QjdoK2dDUEJhT0ppbTJ3NFRINFRndUVPOFJIN1UzNko1eHk5OUZ4a3JJTGhL?=
 =?utf-8?B?dmhIaklFeVY4cUNsQWxwMy9yd2hNVWxpR2QvVC9oaFlST0dPcHVxYU1uSmQ2?=
 =?utf-8?B?Z1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c51e8ac-1ca4-4bad-70c3-08dbb5fee26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 15:17:32.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nbyC6iJEVSqu9+/Q3DyEBbeDiS9xeeHKXGsJnON+HQIvY1Ml5ZVnqkr2a7E1FwpJ4qpvSnTNKMKAxUs0ZIkWfr21EESBacThRlQcvSigmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0952
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <DD1908914649DC4691888F97ABA8F474@CHEP278.PROD.OUTLOOK.COM>
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

SGkgUmFzbXVzLA0KDQpNYWtlIHNlbnNlIHRvIG1lLiBBdCBsZWFzdCBub3cgSSBrbm93IHRoYXQg
dGhlc2UgbWVzc2FnZXMNCmFyZSBub3QgYSBjcml0aWNhbCBlcnJvciBhbmQgd2lsbCBub3QgZ2l2
ZSBtZSBwcm9ibGVtcw0Kb24gdGhlIGZ1dHVyZS4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2ggdG9v
Lg0KDQpSZWdhcmRzLA0KSm/Do28gUGF1bG8NCg0KT24gRnJpLCAyMDIzLTA5LTE1IGF0IDE1OjQ3
ICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24NCj4gDQo+IE9uIDE1LzA5LzIwMjMgMTUu
MDUsIEpvw6NvIFBhdWxvIFNpbHZhIEdvbsOnYWx2ZXMgd3JvdGU6DQo+ID4gSGkgTWFyZWssDQo+
ID4gDQo+ID4gSSB3YXMgdGVzdGluZyBmYXN0Ym9vdCBpbWFnZSBkb3dubG9hZCBvdmVyIHVzYiBm
b3IgaW14OG1wIChmcm9tIHVzYg0KPiA+IHJlY292ZXJ5IHBhdGNoIG9mIHZlcmRpbi1pbXg4bXAp
IGFuZCBpIGFtIGhhdmluZyBlcnJvciBtZXNzYWdlcyBvbg0KPiA+IGVuZHBvaW50IHJlcXVlc3Qg
ZGVxdWV1ZSBmdW5jdGlvbiBvZiBEV0MzIGdhZGdldCBjb250cm9sbGVyLiBIb3dldmVyLA0KPiA+
IGRvd25sb2FkIGlzIHdvcmtpbmcgZmluZSwgc28gdGhpcyBtZXNzYWdlIG1heSBub3QgYmUgYW4g
ZXJyb3IuIFRoZXkgYXJlDQo+ID4gaGFwcGVuaW5nIGJlY2F1c2UgZmFzdGJvb3QgdHggYmVmb3Jl
IHNlbmRpbmcgYSBuZXcgdXNiIHJlcXVlc3QgZGVxdWV1ZQ0KPiA+IHRoZSBzYW1lIHJlcXVlc3Qs
IG1heWJlIHRvIGJlIHN1cmUgaXQgZG9lcyBub3Qgc2VuZCBpdCB0d2ljZS4gQ2FuIEkNCj4gPiBq
dXN0IGlnbm9yZSB0aGVzZSBtZXNzYWdlcz8gTWF5YmUgY2hhbmdlIGl0cyBsb2cgbGV2ZWwgdG8g
ZGJnIGluc3RlYWQNCj4gPiBvZiBlcnJvcj8gV2hhdCBkbyB5b3UgdGhpbms/IFRoZSBtZXNzYWdl
cyBJIGFtIHNlZWluZyBhcmUgYmVsb3cgYW5kIGFyZQ0KPiA+IHRoZSBvbmVzIHdpdGggIi4uLiB3
YXMgbm90IHF1ZXVlZCB0byBlcDFpbi1idWxrIi4gDQo+IA0KPiBXZSBhcHBseSB0aGlzIGludGVy
bmFsbHkgKHNvcnJ5IGlmIGl0J3Mgd2hpdGVzcGFjZSBkYW1hZ2VkKSwgYnV0IEkgbmV2ZXINCj4g
ZnVsbHkgdW5kZXJzdG9vZCB0aGUgcHJvYmxlbSBub3IgaG93IHRoZSByZWZlcmVuY2VkIGtlcm5l
bCB0aHJlYWQgd2FzDQo+IHJlc29sdmVkLCB3aGljaCBpcyB3aHkgSSBoYXZlbid0IHNlbnQgaXQg
dXBzdHJlYW0geWV0Lg0KPiANCj4gwqBkd2MzOiBnYWRnZXQ6IEhhbmRsZSBkZXF1ZXVpbmcgb2Yg
bm9uIHF1ZXVlZCByZXF1ZXN0IGdyYWNlZnVsbHkNCj4gDQo+IMKgVHJ5aW5nIHRvIGRlcXVldWUg
YW4gcmVxdWVzdCB0aGF0IGlzIGN1cnJlbnRseSBub3QgcXVldWVkIHNob3VsZCBiZQ0KPiBhIG5v
LW9wDQo+IMKgYW5kIGJlIGhhbmRsZWQgZ3JhY2VmdWxseS4NCj4gDQo+IMKgQ2hlY2tpbmcgb24g
bGlzdC9xdWV1ZSBlbXB0eSBpbmRpY2F0ZSB3aGV0aGVyIHRoZSByZXF1ZXN0IGlzIHF1ZXVlDQo+
IG9yIG5vdC4NCj4gwqBIYW5kbGluZyB0aGlzIGdyYWNlZnVsbHkgYWxsb3dzIGZvciByYWNlIGNv
bmRpdGlvbiBmcmVlIHN5bmNocm9uaXphdGlvbg0KPiDCoGJldHdlZW4gdGhlIGNvbXBsZXRlIGNh
bGxiYWNrIGJlaW5nIGNhbGxlZCB0byB0byBhIGNvbXBsZXRlZA0KPiB0cmFuc2ZlciBhbmQNCj4g
wqB0cnlpbmcgdG8gY2FsbCB1c2JfZXBfZGVxdWV1ZSgpIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0K
PiDCoEluc3BpcmVkIGJ5Og0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtdXNiL3BhdGNoLzIwMTkxMTA2MTQ0NTUzLjE2OTU2LTEtYWxleGFuZHJ1LmFyZGVsZWFu
QGFuYWxvZy5jb20vDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggZWI0MTZiODMyYWEuLjM3OGQx
OWQ4ZTk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTExMTMsNiArMTExMyw5IEBAIHN0YXRp
YyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwNCj4gDQo+IMKg
c3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiANCj4gKyBpZiAobGlzdF9l
bXB0eSgmZGVwLT5yZXF1ZXN0X2xpc3QpICYmIGxpc3RfZW1wdHkoJmRlcC0+cmVxX3F1ZXVlZCkp
DQo+ICsgZ290byBvdXQwOw0KPiArDQo+IMKgbGlzdF9mb3JfZWFjaF9lbnRyeShyLCAmZGVwLT5y
ZXF1ZXN0X2xpc3QsIGxpc3QpIHsNCj4gwqBpZiAociA9PSByZXEpDQo+IMKgYnJlYWs7DQo+IA0K
PiBSYXNtdXMNCg0K

