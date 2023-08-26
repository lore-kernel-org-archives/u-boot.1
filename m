Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B6C83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 07:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B4B86B10;
	Sat, 26 Aug 2023 09:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="emeKtOm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC76869C9; Sat, 26 Aug 2023 09:42:29 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA88C86B10
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 09:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693035746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uvtg7ijWi1ADpUb9Ie/5SuE8/R7xCzMgPsYuLOOU2aE=;
 b=emeKtOm9rMQfW2yQET2AY0ldxf/fCe+iscr997ovyFu3mOQOzyVN4zTbpqZlrKOUOH3oy4
 pww8FYnvCeJFcyI6CRFrFkLKL+KZKXGf7WEyofCYC0cIIuYxsTt6AkMOokm7WrIBR+7IP8
 rd+0R1W+MXynPcWtWiq69htrjECOXFc=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-ZhWKVh4JOk6uttWYVQ30TA-1; Sat, 26 Aug 2023 09:42:21 +0200
X-MC-Unique: ZhWKVh4JOk6uttWYVQ30TA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1093.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sat, 26 Aug 2023 07:42:20 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 07:42:20 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
CC: "paul.liu@linaro.org" <paul.liu@linaro.org>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "festevam@denx.de" <festevam@denx.de>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>, "aford173@gmail.com"
 <aford173@gmail.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v2 1/3] arm: dts: imx8mm: move firmware/optee node to
 common imx8mm-u-boot.dtsi
Thread-Topic: [PATCH v2 1/3] arm: dts: imx8mm: move firmware/optee node to
 common imx8mm-u-boot.dtsi
Thread-Index: AQHZ1r107kW+SEc1fESLSeKseXanMK/8NDIA
Date: Sat, 26 Aug 2023 07:42:19 +0000
Message-ID: <5e66d4d6ed7226b562c792e33fe1fa822a46f536.camel@toradex.com>
References: <20230824190144.980883-1-tharvey@gateworks.com>
In-Reply-To: <20230824190144.980883-1-tharvey@gateworks.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1093:EE_
x-ms-office365-filtering-correlation-id: 2ca334ac-682c-4727-3d79-08dba607fa78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: xKVD+wvjZbC8ErB2LI2lceNYRSOQbmU6S1xQ5U9sDPuo9YzX+HA8GtMaUwhfoBSSnkDnm8gN83u0NjGaLmOkTC5mmueEg58DaVDZdVSfyzAXwIJyIUUXqJPUdoWglQ+mwrgAPDYIMC9AVYi6dBi9JIRx6HKezwSO+6vuqRPNvzrBhODIQys0hOJb8g6LUUvZyoMOSRGCb9XxOmwaC88HGM2CBwaYFoBp01LRfDuAsUsNNA3yEAFLxqMm/IWgAqR8UU0eEmUjZ15ql2BbR2fDLI3RiBXWp4LIVTzjjIVRthd53KdoSt5ea5z3m129JuZtKEaOGl17GxZZ8loD0lYuZZ1TCzqXlQPsWJTmyNcN/eviioZIwEpFjr2in7vJW/FXL+V+JZZLLDMf18f34baMZpZI5AVcMipTs5wAgeHSS9ftZnvMWXWm1blH3HDCNlE5FNEWav5Ls4+yyX7R2o6w16FSRSPGP+N/tRTgfIMRoi+sGu/YM7FLXssckhUIIesrqloFgvNQFn/krSZun7noDrSVb2YzjNzo3ZFrRcdvnTElFYipSxmxl/rtXe1TUmkyDMxQQkfYZdczrTOfhIyGSgYIoEJ34XFn2jNWQfNngoOVjnCdpscm3uS5kBprPWjuMW7D2c1hxfA24XtUSeJ1/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39840400004)(366004)(396003)(1800799009)(451199024)(186009)(8676002)(4326008)(64756008)(66446008)(91956017)(66556008)(26005)(6506007)(66946007)(76116006)(66476007)(71200400001)(122000001)(41300700001)(6512007)(316002)(5660300002)(8936002)(478600001)(7416002)(44832011)(6486002)(54906003)(110136005)(2616005)(2906002)(83380400001)(86362001)(38070700005)(36756003)(38100700002)(32563001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTlVb3RLeDhkdDVJdXA1N2FmbmVOVjlwQlVrREM0ZlZnQWY4MEwwY2RMZ0dW?=
 =?utf-8?B?MjBycWw0V3RiWHkwMkJtaHRiYzAvMFlmdmRIQ2tmRXptRmVBNC9nd25sV2c0?=
 =?utf-8?B?bVJKSldPQWFHQ3NaOWxDcGJmblJYaE5TL21SWjQvamRvTW1KZ0ZjTVBVMkow?=
 =?utf-8?B?QnVra1g1V2VDdzJQSUdEU2Y4TDRlQTFBcngrWEg0dkhUbG9qUlNoZzI4VC9C?=
 =?utf-8?B?aDA4MCsxbFB2cmFXZW1CK3l6MDZpTE51TG94bHU0QU9LdHNOL2Iwcks3SFRL?=
 =?utf-8?B?RVpHWlB0dXhWeXRtclM3bi9YS3hhZkZGY3F6MVhhcmVyb1BST1l5cVhlbDl6?=
 =?utf-8?B?UGkyK3JjTGpKcXpWTml0bm9kRnlKTDN0SU9nTWYvNTR1UkV3aHlsdkJyc3lF?=
 =?utf-8?B?YVZueXY3dm1mTzFQMS92ZEJEMU5OVlNocVEyNHhTbjBqMHl1TjBDQWx0TVNm?=
 =?utf-8?B?ajlxRkpFbEVEQWNNemEzQnRheVZPTG1GaHBSTUgySk1BOVJFQ3l3cUVxY0lC?=
 =?utf-8?B?VFk1cjc1R0xQbU53N0V5a0dCcmNseThhUG1zeE9kY2syc1ZDTzYxUUtTNlAr?=
 =?utf-8?B?UkpxSEFsTGxiQUMzbVZHLzZ1b1BlWTVzTExvK1BRWW5xUGIzU1RYbGtIenhM?=
 =?utf-8?B?Nm83QkVnRUhqODhBdldMOVZuUEx4aXc4c080eVpFaktMandDZEw3RjJqdmsx?=
 =?utf-8?B?K0lxYXFHQm92N3U0YXp5QlNRcGx5WWZZN1VMSGFKQUhKcGhZcC9UTTJIRkZj?=
 =?utf-8?B?WFFGS0ZKNmVXTzUwR2JxeVlTMGdxWnp5eGwrcTNqcmNvckhsUis2NGMzK2ZP?=
 =?utf-8?B?WGhmRjg2RnBaTXgrcEdVQU9rY1NkUzc3YnRXR2VlYjhFbTB1MkNGZDdILytx?=
 =?utf-8?B?eDB0TjRvZGxLZmVrMUZTZkZLNXN0dDl6UGJMWU9OWEJMR2IxTDF5Wk5aaUF0?=
 =?utf-8?B?aFpZbHY3c1dxVzNyVHFCd0RlYmtKZVozQm1YZFlySm0yQnl1MUVRUnViOGw5?=
 =?utf-8?B?dWgvZjRmMzAvQm9yS0kwVVBmTjJiTXY5L29KZmRyRjFwQWEyQm9rRzJpSDBO?=
 =?utf-8?B?WGJ5TFVwRTU4dmkycjRHMFNRNFlpbDd3T3g4V0ptNE9vK200QWVodzgyTlU4?=
 =?utf-8?B?bzZWOVRFWXd3YzNhcWFsTit5ZVVoRFN5YXpFc1NJSmluMTFUbzZvRzZLZUFB?=
 =?utf-8?B?N09zVGt4Q1cxaEE0aFFPQ1V0ZEFRdVduUlNEVkdXTFZNV2tsSExRdVNITTVi?=
 =?utf-8?B?ZVZTVEx0eUliWTRRUHU4bUQ4VjlvaWEzZmtld2pNQnF5ZEFhRm5jdzk0NU1C?=
 =?utf-8?B?Qk5Xb25UWmxDZjIzdWsvRnh4RHdUV1VSTFg3OUtEL2ExajdDOTA4L2VXZkxO?=
 =?utf-8?B?YjdOWnJhYkpMMCtvSzRnN0JhRkcrZHRHMFp3Nm5BVkk3QXpVa1MyNWFjZmhG?=
 =?utf-8?B?S1d0R1ZRbW14akhjM3FZQWNrWm5ocFNGNjVhMktRdDlJZW9odVgrV3VFVE5J?=
 =?utf-8?B?MFBhOWgwK21hejJ2QjNGZmx6RVEwcFpsRG4zRXVId2JCMHRBRExNVWxySXQ5?=
 =?utf-8?B?UjlOS1lrb3R4S3hwUDdFZHhneVk0ZmtFVU9KNUdabWNJaTVQTlEwaXlHMXcr?=
 =?utf-8?B?N2tCZ2dTVml0eVR3RnFMTmUrWis5MVNNQkRyVDhLZmZRZXozWmJjMFpTSU5J?=
 =?utf-8?B?UWNGQ0g4Y0xKSzdYR0Zab3FsU1FwVWVQYngzUHA3REI0UXc0S1BkbUMyUjhY?=
 =?utf-8?B?TG5oc3lFWk1acFVhN3ErUW9ZRlI2eC9lSFU4aFJsVTNjTm0rRjl3RVZST1or?=
 =?utf-8?B?Q1JJcU96WVpFUzFHOEZDWENGM1Q2VUI2aHM1VFJBSzE1aFRDR2cyTmxyVUtX?=
 =?utf-8?B?L0grWDVxRFJKRjVPYVVzKzg2cGt3cy9maHU5aS9qazUxcnRHS0FXNDJuY1Fq?=
 =?utf-8?B?REwvblJHbDNTczNPVHNFSUpHdC9qVTlrcGpZY3RIYm4rYUcrYXh2SGk2SUFW?=
 =?utf-8?B?RWFIdnI1NTdaSk1TaVRFOW4wa3o0QXN2dFdKNnlHak5Obzh5SVpuaitsQ2ph?=
 =?utf-8?B?b3dRTlBSR3dnSXRvQVdBWUR0UTZTOHgxekNTdTlGdDFWUGRmL28rVjYxS0JY?=
 =?utf-8?B?K0dwb2NKQUZCMDNHM25GY0tDRG5UYnNseG1OWFVTVUVxQmgrSXZ0SXJ6ZXBB?=
 =?utf-8?Q?B98pI7MjXkngD762SBEHne8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca334ac-682c-4727-3d79-08dba607fa78
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2023 07:42:20.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v38v42nKD1Itvyr0Rrt8DNBWPhtBBUz3IuNE7PUxx9WZYxFRGolPTz+1d/vcOgGKLlv8jvI96ZJxEDXnkU//p7Nw2c+Zjdfx0Vc1ZvMWuBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1093
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <73BF80134990C64CA5149658954C06CF@CHEP278.PROD.OUTLOOK.COM>
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

SGkgVGltCgpUaGFua3MhCgpPbiBUaHUsIDIwMjMtMDgtMjQgYXQgMTI6MDEgLTA3MDAsIFRpbSBI
YXJ2ZXkgd3JvdGU6Cj4gTW92ZSB0aGUgZmlybXdhcmUvb3B0ZWUgbm9kZSB0byB0aGUgY29tbW9u
IGlteDhtbS11LWJvb3QuZHRzaSBhbmQKPiBwcm90ZWN0IGl0IHdpdGggYW4gaWZkZWYgQ09ORklH
X09QVEVFIGFzIGl0IGlzIGEgbWVhbmluZ2xlc3Mgbm9kZQo+IHdpdGhvdXQgdGhlIG9wdGVlIGRy
aXZlciBlbmFibGVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0
ZXdvcmtzLmNvbT4KPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZGVueC5k
ZT4KCkZvciB0aGUgZW50aXJlIHNlcmllcy4KClJldmlld2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4KCj4gLS0tCj4gdjI6IGFkZGVkIEZhYmlvJ3Mg
cmIgdGFnCj4gLS0tCj4gwqBhcmNoL2FybS9kdHMvaW14OG1tLWNsLWlvdC1nYXRlLW9wdGVlLXUt
Ym9vdC5kdHNpIHwgNyAtLS0tLS0tCj4gwqBhcmNoL2FybS9kdHMvaW14OG1tLWNsLWlvdC1nYXRl
LXUtYm9vdC5kdHNpwqDCoMKgwqDCoMKgIHwgNyAtLS0tLS0tCj4gwqBhcmNoL2FybS9kdHMvaW14
OG1tLWV2ay11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA3IC0tLS0t
LS0KPiDCoGFyY2gvYXJtL2R0cy9pbXg4bW0ta29udHJvbi1ibC1jb21tb24tdS1ib290LmR0c2kg
fCA3IC0tLS0tLS0KPiDCoGFyY2gvYXJtL2R0cy9pbXg4bW0tcGhnLXUtYm9vdC5kdHNpwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDcgLS0tLS0tLQo+IMKgYXJjaC9hcm0vZHRzL2lteDht
bS11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDkgKysr
KysrKysrCj4gwqBhcmNoL2FybS9kdHMvaW14OG1tLXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRz
acKgwqAgfCA3IC0tLS0tLS0KPiDCoDcgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0
MiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDhtbS1jbC1p
b3QtZ2F0ZS1vcHRlZS11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg4bW0tY2wtaW90LWdh
dGUtb3B0ZWUtdS0KPiBib290LmR0c2kKPiBpbmRleCA0ODRlMzE4MjRiODUuLmQxMmNlNjA2OWNj
NyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9kdHMvaW14OG1tLWNsLWlvdC1nYXRlLW9wdGVlLXUt
Ym9vdC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDhtbS1jbC1pb3QtZ2F0ZS1vcHRlZS11
LWJvb3QuZHRzaQo+IEBAIC02LDEzICs2LDYgQEAKPiDCoCNpbmNsdWRlICJpbXg4bW0tdS1ib290
LmR0c2kiCj4gwqAKPiDCoC8gewo+IC3CoMKgwqDCoMKgwqDCoGZpcm13YXJlIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb3B0ZWUgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJsaW5hcm8sb3B0ZWUtdHoiOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWV0aG9kID0g
InNtYyI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gLcKgwqDCoMKgwqDC
oMKgfTsKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoHdkdC1yZWJvb3Qgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ3ZHQtcmVib290IjsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFtOwo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9kdHMvaW14OG1tLWNsLWlvdC1nYXRlLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2lt
eDhtbS1jbC1pb3QtZ2F0ZS11LWJvb3QuZHRzaQo+IGluZGV4IDE4NzhjNGUxM2ZiZS4uMjE5NTA0
ZjYxMTA1IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tY2wtaW90LWdhdGUtdS1i
b290LmR0c2kKPiArKysgYi9hcmNoL2FybS9kdHMvaW14OG1tLWNsLWlvdC1nYXRlLXUtYm9vdC5k
dHNpCj4gQEAgLTYsMTMgKzYsNiBAQAo+IMKgI2luY2x1ZGUgImlteDhtbS11LWJvb3QuZHRzaSIK
PiDCoAo+IMKgLyB7Cj4gLcKgwqDCoMKgwqDCoMKgZmlybXdhcmUgewo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBvcHRlZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImxpbmFybyxvcHRlZS10eiI7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZXRob2QgPSAic21jIjsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiAtwqDCoMKgwqDCoMKgwqB9Owo+
IC0KPiDCoMKgwqDCoMKgwqDCoMKgd2R0LXJlYm9vdCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIndkdC1yZWJvb3QiOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0
cy9pbXg4bW0tZXZrLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2lteDhtbS1ldmstdS1ib290
LmR0c2kKPiBpbmRleCAxMzY4OGVjMGQwZjIuLjE1NTY3MGRhMThkMSAxMDA2NDQKPiAtLS0gYS9h
cmNoL2FybS9kdHMvaW14OG1tLWV2ay11LWJvb3QuZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9p
bXg4bW0tZXZrLXUtYm9vdC5kdHNpCj4gQEAgLTExLDEzICsxMSw2IEBACj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB3ZHQgPSA8Jndkb2cxPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFtOwo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IC0KPiAt
wqDCoMKgwqDCoMKgwqBmaXJtd2FyZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG9wdGVlIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGNvbXBhdGlibGUgPSAibGluYXJvLG9wdGVlLXR6IjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1ldGhvZCA9ICJzbWMiOwo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Owo+IC3CoMKgwqDCoMKgwqDCoH07Cj4gwqB9Owo+IMKgCj4gwqAm
YWlwczQgewo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OG1tLWtvbnRyb24tYmwtY29t
bW9uLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2lteDhtbS1rb250cm9uLWJsLWNvbW1vbi11
LQo+IGJvb3QuZHRzaQo+IGluZGV4IDY1ZGZkMzM3MjVlZS4uMWFkOWQ0OWExMTE4IDEwMDY0NAo+
IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0ta29udHJvbi1ibC1jb21tb24tdS1ib290LmR0c2kK
PiArKysgYi9hcmNoL2FybS9kdHMvaW14OG1tLWtvbnRyb24tYmwtY29tbW9uLXUtYm9vdC5kdHNp
Cj4gQEAgLTE2LDEzICsxNiw2IEBACj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3
ZHQgPSA8Jndkb2cxPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1w
cmUtcmFtOwo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IC0KPiAtwqDCoMKgwqDCoMKgwqBmaXJtd2Fy
ZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9wdGVlIHsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAibGluYXJv
LG9wdGVlLXR6IjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG1ldGhvZCA9ICJzbWMiOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+
IC3CoMKgwqDCoMKgwqDCoH07Cj4gwqB9Owo+IMKgCj4gwqAmY3J5cHRvIHsKPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vZHRzL2lteDhtbS1waGctdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14
OG1tLXBoZy11LWJvb3QuZHRzaQo+IGluZGV4IDNjZWQ5N2NmYWFmYS4uYzllMGI0NDIwNTAwIDEw
MDY0NAo+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tcGhnLXUtYm9vdC5kdHNpCj4gKysrIGIv
YXJjaC9hcm0vZHRzL2lteDhtbS1waGctdS1ib290LmR0c2kKPiBAQCAtMTEsMTMgKzExLDYgQEAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdkdCA9IDwmd2RvZzE+Owo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07Cj4gwqDCoMKgwqDCoMKg
wqDCoH07Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoGZpcm13YXJlIHsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgb3B0ZWUgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJsaW5hcm8sb3B0ZWUtdHoiOwo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWV0aG9kID0gInNtYyI7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gLcKgwqDCoMKgwqDCoMKgfTsKPiDC
oH07Cj4gwqAKPiDCoCZhaXBzNCB7Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bW0t
dS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14OG1tLXUtYm9vdC5kdHNpCj4gaW5kZXggMDM1
MjgyYmYwYjAwLi5hODQzYmI4NTFlYWYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDht
bS11LWJvb3QuZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2kKPiBA
QCAtNyw2ICs3LDE1IEBACj4gwqDCoMKgwqDCoMKgwqDCoGJpbm1hbjogYmlubWFuIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11bHRpcGxlLWltYWdlczsKPiDCoMKgwqDCoMKg
wqDCoMKgfTsKPiArCj4gKyNpZmRlZiBDT05GSUdfT1BURUUKPiArwqDCoMKgwqDCoMKgwqBmaXJt
d2FyZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9wdGVlIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAibGlu
YXJvLG9wdGVlLXR6IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG1ldGhvZCA9ICJzbWMiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKyNlbmRpZgo+IMKgfTsKPiDCoAo+IMKgJnNvYyB7Cj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tdmVyZGluLXdpZmktZGV2LXUtYm9vdC5k
dHNpIGIvYXJjaC9hcm0vZHRzL2lteDhtbS12ZXJkaW4td2lmaS1kZXYtdS0KPiBib290LmR0c2kK
PiBpbmRleCAyYjI2OGY1NWNiOTUuLjI0ZTU2NWEwNmMyZiAxMDA2NDQKPiAtLS0gYS9hcmNoL2Fy
bS9kdHMvaW14OG1tLXZlcmRpbi13aWZpLWRldi11LWJvb3QuZHRzaQo+ICsrKyBiL2FyY2gvYXJt
L2R0cy9pbXg4bW0tdmVyZGluLXdpZmktZGV2LXUtYm9vdC5kdHNpCj4gQEAgLTYsMTMgKzYsNiBA
QAo+IMKgI2luY2x1ZGUgImlteDhtbS11LWJvb3QuZHRzaSIKPiDCoAo+IMKgLyB7Cj4gLcKgwqDC
oMKgwqDCoMKgZmlybXdhcmUgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvcHRl
ZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gImxpbmFybyxvcHRlZS10eiI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtZXRob2QgPSAic21jIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfTsKPiAtwqDCoMKgwqDCoMKgwqB9Owo+IC0KPiDCoMKgwqDCoMKgwqDCoMKg
d2R0LXJlYm9vdCB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxl
ID0gIndkdC1yZWJvb3QiOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBo
LXByZS1yYW07CgpDaGVlcnMKCk1hcmNlbAo=

