Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A21CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A491586E3D;
	Tue, 12 Sep 2023 14:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Jm5RFVZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA83586E71; Tue, 12 Sep 2023 14:20:22 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF38A86E3D
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1694521219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMb84f89b2JKwsKzsxUl4qeKaWki8uBqTmdLs1AE99o=;
 b=Jm5RFVZrTQWiAd4FpR8Tdm1Pm/sYIy61UnhGNfu1OKMS8U/PYucj+Wgd5lHdkPOvXB2AI1
 8i+xlIeCb91PdTkH+s4dxuGe9I/bOAF09fUuZRnDgQ4xiwOZPx7A8gn0LA5p87PilLaM8R
 DiIVUMvwzVpcmThjCB1YsWolKMqpz7Y=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-54-YN0qMxQJOsam5mGDA-66vg-1; Tue, 12 Sep 2023 14:20:17 +0200
X-MC-Unique: YN0qMxQJOsam5mGDA-66vg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0079.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 12:20:15 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 12:20:15 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "nm@ti.com"
 <nm@ti.com>, "j-kacines@ti.com" <j-kacines@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "sabiya.d@ti.com"
 <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>
Subject: Re: [PATCH v3 13/16] arm: dts: Introduce am69-sk u-boot dts files
Thread-Topic: [PATCH v3 13/16] arm: dts: Introduce am69-sk u-boot dts files
Thread-Index: AQHZ4kTOCAlWfeEuskqOaigLg/CJmrAXIm0A
Date: Tue, 12 Sep 2023 12:20:14 +0000
Message-ID: <c404a39ce71abe4e4fb3a7cc143cb62e7779f802.camel@toradex.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-14-a-nandan@ti.com>
In-Reply-To: <20230908110551.861575-14-a-nandan@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0079:EE_
x-ms-office365-filtering-correlation-id: 449a933d-ed6e-4082-b813-08dbb38a9e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Yc3LBwvexgs0ExXJHlvZbbtX0pc96Gx9S/6H7IfGQQT7Zf16Zc6cE/ZEGLtb8C+WnsZVhM0SXLbmdM/WZHoWzPDujCXw/fhyXyh9o1vPbQEGHyA6X9KvqREiUkYayq05KM8XS/HAElSsWlhGq8f0JgAdk0YGx9xfV7l63DlHdFrNX1XQ8vJFDYijcOAnRgWd65BNbuveencru1B8dCACCBNW7YSCVyONjCtkMwX5uE62nkUVh7D1LHz7m+UdVaClYnGA3FXiWyf4ARgU0aE16+7pczfVk8Alg1bv/IbaD5mIzArsM0ATmB1i2C5QfXZxO6vbRtcPAtjHRXpk5RMBu43Nxt9EsTHGuryHbFI5BbSMpCgK+8PJhBWgvJeFUdH3rPMRaUkulA+2/KPinxm1Bai8xyzhuJQcmY9XKE5xELp53kOKijbfn0NL7cOM+LYX3WXKsoH/RGpH3tv6eFG3SXRB+4WVIwOn1aPcP2GNxxPsdAzmY4SANpZA1NFoYkpOFGdcfSR1F2N9+nz1fzIe3XZBcAzGj0jf4fKnsoaxsAg3OqDFOSlXr80s8BVmFCoUb10UM2tyUjeDTIGJlyIPYu//Qzrz2UHl5/k2teZPVcvkyZ4kmYQODW0DQtu618UG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39850400004)(396003)(136003)(346002)(1800799009)(451199024)(186009)(921005)(122000001)(6486002)(71200400001)(6506007)(83380400001)(110136005)(36756003)(86362001)(38070700005)(38100700002)(26005)(2906002)(41300700001)(6512007)(966005)(478600001)(5660300002)(316002)(8936002)(8676002)(2616005)(66946007)(7416002)(66556008)(66446008)(44832011)(66476007)(76116006)(64756008);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L095R2xZU0E0WUJHM3ZwNTlOVVh1bnNOeUN0N1R4NTdPUTBjR2hvN3pQTGZ6?=
 =?utf-8?B?SEpvRllYbTQ4amtEc0RhdGJySytPZmdXeDhlRUlYUkxqWDdGQmxRZ24yVnRP?=
 =?utf-8?B?Y1M2NTBCNmR1MVBXMDdyUHRiR09QZ2svMVVGU2dTWkNmcGh2alRFc2hNNnpO?=
 =?utf-8?B?N25mRmV1QjQySWpCdmY1cCtjV0FUMXc4SG9EZ1BNUXNsUGtYazF6b0dQTllm?=
 =?utf-8?B?Nys1bC9wWDFFUXJvWmhySHQvQ0FsWml1c3UraXZNUEpTOU4rcXJoWTFIVFZq?=
 =?utf-8?B?MXZLcEg4TGI1WDA2RmZlOHJjUkxUbE43VTdnZlIwdzNLUGxBZ2lNaTkvZEVo?=
 =?utf-8?B?dUtyUXNDS0hXVHhKZlVzMndDZC9vM283b3VKRlNidkVGRk5oY2NHVDdIbkFB?=
 =?utf-8?B?UWJEbDJNQkZLK1NBWFFBS3lmWlNRTUVNYXFoQS9GWGs1MDkzRWRBVVRrL05J?=
 =?utf-8?B?Zi9yUjRjOHdFTkdFZEhBdVdIWFV3YWxzOXhidVRQMnBJRFVWZStQalRDTGpV?=
 =?utf-8?B?MjJodnFjVUVyVTI3dTFiczhvUlhrejk1cUtmbkNHZjFrcjQ0bFY5aGN4VTly?=
 =?utf-8?B?WFB4em1yRmRZb3hIODZkMjVadWtlYUxodW9vL0FJdnlBMk55ekdKN2JNSDdk?=
 =?utf-8?B?Ri9YT3RFc2UwQ2tYOXliRVpPb2l4SUZXeHNPTDJoUCtDSXhDZnNKY3pZb001?=
 =?utf-8?B?dy9OT01MNzlnY3A3K1d2M1pZbENHTHQ1OFlPbDBwNE1zeTdxNjdNVjdpMEYr?=
 =?utf-8?B?Vmt4c3lBUUNma0JubVN5RDNLQTlIUEhFUC9KamJtT2RrQktoTjRIYWZEY29t?=
 =?utf-8?B?NGNDc21aclJ3cXNCWDlvN1Y5ZkIwdVJmbEVsY3lXZ0V5NGozVjZpMVdtRmdE?=
 =?utf-8?B?bEY1MVhJZXBleWdVTHphb2hzM1g0UFVpNktDL3picFBxM0FqWEUxT0x6QWxO?=
 =?utf-8?B?SmNtZE1PcXUvdGZtcUxyY09GK0pNVFhkbGRvck1jRzVLVlNUYitKTmF4WlZn?=
 =?utf-8?B?dEFtdXpDdWRJejVPb2dpc0hJMWh1VE1JNktMOGJ5Uk9vbHo1dDNoeis5NTNz?=
 =?utf-8?B?VUd2T2Z5Z3NTR3pNKzk4a29vY2Vuc3h3UDcvQnYwZWJkclMreXdjSzIyT0xZ?=
 =?utf-8?B?M0FMQnBIQjY5SlhpSnd6QTBLZkp6akx1OE5LVTZzSE1LcHRxZ3FKWmxHYk1k?=
 =?utf-8?B?MnZ4ZUdVRXJMOUs5bVo4TXBaY3poTjZKclJoYitWQ1YydmUxRU13K3VuZ0dH?=
 =?utf-8?B?TnRkeWp5L0Y2WTd6S2ZoTFlDTUo0ZEM2RHdZT0IwUHFmUXEyQ3cyeFJLbFF3?=
 =?utf-8?B?ekxwSzJvRnFYMTdZOE1qaVMzZ3dFMHN2ZXV0NENYSWtvOEo0WlhrUmNMdzVE?=
 =?utf-8?B?Ri9id04vcldVOHFyZzF4WDVjc2J6N1VVOUlaRDN6YTh0bGVReEF2MzYwai8w?=
 =?utf-8?B?bmFhTkFWT3dnK3cyVW0yZHpiZ2xZYzNWYTlhSHF4WHY1N0NPaStTZkFxTXlH?=
 =?utf-8?B?WVN4cFNINGFsUWtVNkJsakQxRUd5dm5VTktRanZ6MmdOUTc4Q01RZHh5bFpW?=
 =?utf-8?B?SGovVm9DdTVhNmQwK1pXdFNabCtFSkJsa21TVXdWelQwa01xRWgxdWZ5L2J4?=
 =?utf-8?B?cm5IenJzNmVaNnRCeWtwaUpBUXRxWExEZUVtdlBDME16Vk00eUxhMnZBY2hY?=
 =?utf-8?B?L2oxc3VKLy9NRHFvY0oyZEhyZ0R0dkxQVU9EREZlZmIrb0EyaXVadlhmTTY5?=
 =?utf-8?B?Z0hoNmpybEVZZzF6SDIvZWtUa3A3cmE0aTJLeFhGekpmMDQwQ1VCY2lkRlpC?=
 =?utf-8?B?cGdPSi9RRVZwUTU1c3hKb2o1RjR2VkxpZWdZNHFDWHVhUlZTUnRBMDZvcTI0?=
 =?utf-8?B?NkNkM2RyTjMvUU5QVVRMakR3SzRqWVJqMmVweUt6SUhxQ2VjZSsxd0lOSTdT?=
 =?utf-8?B?bFVYOFJHOWdGbXFhV2ZWU2FoOHdzaG9MMWR1eGR6VmUxbVZPd0xGVEtUZ2ht?=
 =?utf-8?B?c0ZvT3U1eFFhOEZsWVFNcnhXbjZGTWlzQTlJSGllVmdZQjlNWDlYR0NtWUVT?=
 =?utf-8?B?Vnhicko5UVJMS0xMVFdrQVZGTnI5OEJtQ0ZJVlZuRjhkS3Y1WXZkd29tK1ov?=
 =?utf-8?B?ZFA3cG9teUliS1dObHVZNGRUd05hK3JSRkZVS2VvKzJ1WlI0cWFPV3hQdEN6?=
 =?utf-8?B?Snc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 449a933d-ed6e-4082-b813-08dbb38a9e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 12:20:15.0066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNL0W/I9ApqfqhfIyvoECDN4hdcWTH03vehugts/lpsSUsRfRD6DWM64ArBLj8l5lNYKVJb29p0F+ZwbwA3rv6iFioSjOrizsFakZDGZDds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0079
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <36CD2F563412D44D94643B065D496D6A@CHEP278.PROD.OUTLOOK.COM>
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

T24gRnJpLCAyMDIzLTA5LTA4IGF0IDE2OjM1ICswNTMwLCBBcHVydmEgTmFuZGFuIHdyb3RlOgo+
IEZyb206IERhc25hdmlzIFNhYml5YSA8c2FiaXlhLmRAdGkuY29tPgo+IAo+IEludHJvZHVjZSB0
aGUgYmFzZSBkdHMgZmlsZXMgbmVlZGVkIGZvciB1LWJvb3Qgb3IgdG8gYXVnbWVudCB0aGUgbGlu
dXgKPiBkdGJzIGZvciB1c2UgaW4gdGhlIHUtYm9vdC1zcGwgYW5kIHUtYm9vdCBiaW5hcmllcy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBEYXNuYXZpcyBTYWJpeWEgPHNhYml5YS5kQHRpLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBBcHVydmEgTmFuZGFuIDxhLW5hbmRhbkB0aS5jb20+Cj4gLS0tCj4gwqBh
cmNoL2FybS9kdHMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMg
Ky0KPiDCoGFyY2gvYXJtL2R0cy9rMy1hbTY5LXI1LXNrLmR0c8KgwqDCoMKgwqAgfCAxMDUgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjktc2stdS1i
b290LmR0c2kgfMKgIDI1ICsrKysrKysKPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTMyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMv
azMtYW02OS1yNS1zay5kdHMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvazMt
YW02OS1zay11LWJvb3QuZHRzaQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvTWFrZWZp
bGUgYi9hcmNoL2FybS9kdHMvTWFrZWZpbGUKPiBpbmRleCAxYmNkYmVhOWU1Li5iYjdhZTc5NzQ1
IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2R0cy9NYWtlZmlsZQo+ICsrKyBiL2FyY2gvYXJtL2R0
cy9NYWtlZmlsZQo+IEBAIC0xMzMwLDcgKzEzMzAsOCBAQCBkdGItJChDT05GSUdfU09DX0szX0o3
MjFTMikgKz0gazMtYW02OC1zay1iYXNlLWJvYXJkLmR0YlwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgazMtYW02OC1zay1yNS1i
YXNlLWJvYXJkLmR0YlwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgazMtajcyMXMyLWNvbW1vbi1wcm9jLWJvYXJkLmR0YlwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgazMtajcyMXMyLXI1LWNvbW1vbi1wcm9jLWJvYXJkLmR0Ygo+IC1kdGItJChDT05GSUdfU09D
X0szX0o3ODRTNCkgKz0gazMtYW02OS1zay5kdGJcCj4gK2R0Yi0kKENPTkZJR19TT0NfSzNfSjc4
NFM0KSArPSBrMy1hbTY5LXI1LXNrLmR0YlwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrMy1hbTY5LXNrLmR0YlwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgazMt
ajc4NHM0LWV2bS5kdGJcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGszLWo3ODRzNC1yNS1ldm0uZHRiCj4gwqBkdGItJChDT05G
SUdfU09DX0szX0FNNjQyKSArPSBrMy1hbTY0Mi1ldm0uZHRiIFwKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vZHRzL2szLWFtNjktcjUtc2suZHRzIGIvYXJjaC9hcm0vZHRzL2szLWFtNjktcjUtc2su
ZHRzCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwLi44Yzc4OWM0ZjI4
dmFsdWF0aW9uIG1vZHVsZSAoRVZNKSBpcyBhIHBsCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2Fy
Y2gvYXJtL2R0cy9rMy1hbTY5LXI1LXNrLmR0cwo+IEBAIC0wLDAgKzEsMTA1IEBACj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCgpTaG91bGQgYmU6CgpHUEwtMi4wLW9ubHkK
CkJUVzogV2h5IGlzIFRJIG5vdCByZWxlYXNpbmcgdGhlaXIgZGV2aWNlIHRyZWVzIHdpdGggYSBt
b3JlIHBlcm1pc3NpdmUgbGljZW5zZSBsaWtlIEdQTC0yLjAtb3ItbGF0ZXIgT1IgTUlUCmxpa2Ug
bW9zdCBvdGhlcnMgZG8/Cgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjItMjAyMyBUZXhh
cyBJbnN0cnVtZW50cyBJbmNvcnBvcmF0ZWQgLSBodHRwczovL3d3dy50aS5jb20vCj4gKyAqLwo+
ICsKPiArL2R0cy12MS87Cj4gKwo+ICsjaW5jbHVkZSAiazMtYW02OS1zay5kdHMiCj4gKyNpbmNs
dWRlICJrMy1qNzg0czQtZGRyLWV2bS1scDQtNDI2Ni5kdHNpIgo+ICsjaW5jbHVkZSAiazMtajc4
NHM0LWRkci5kdHNpIgo+ICsjaW5jbHVkZSAiazMtYW02OS1zay11LWJvb3QuZHRzaSIKPiArCj4g
Ky8gewo+ICvCoMKgwqDCoMKgwqDCoGNob3NlbiB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHRpY2stdGltZXIgPSAmbWN1X3RpbWVyMDsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsK
PiArwqDCoMKgwqDCoMKgwqBhbGlhc2VzIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVtb3RlcHJvYzAgPSAmc3lzY3RybGVyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZW1vdGVwcm9jMSA9ICZhNzJfMDsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsKPiArwqDC
oMKgwqDCoMKgwqBhNzJfMDogYTcyQDAgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb21wYXRpYmxlID0gInRpLGFtNjU0LXJwcm9jIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmVnID0gPDB4MCAweDAwYTkwMDAwIDB4MCAweDEwPjsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDYxIFRJX1NDSV9QRF9F
WENMVVNJVkU+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDwmazNfcGRzIDIwMiBUSV9TQ0lfUERfRVhDTFVTSVZFPjsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVzZXRzID0gPCZrM19yZXNldCAyMDIgMD47
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmazNfY2xrcyA2MSAw
PjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXNzaWduZWQtY2xvY2tzID0gPCZr
M19jbGtzIDYxIDA+LCA8JmszX2Nsa3MgMjAyIDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZrM19jbGtzIDYxIDI+Owo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwyMDAwMDAw
MDA+LCA8MjAwMDAwMDAwMD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRpLHNj
aSA9IDwmc21zPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGksc2NpLXByb2Mt
aWQgPSA8MzI+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aSxzY2ktaG9zdC1p
ZCA9IDwxMD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFt
Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGRtX3RpZnM6IGRtLXRp
ZnMgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gInRpLGo3
MjFlLWRtLXNjaSI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRpLGhvc3QtaWQg
PSA8Mz47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRpLHNlY3VyZS1ob3N0Owo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYm94LW5hbWVzID0gInJ4IiwgInR4IjsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWJveGVzPSA8JnNlY3VyZV9wcm94eV9t
Y3UgMjE+LCA8JnNlY3VyZV9wcm94eV9tY3UgMjM+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBib290cGgtcHJlLXJhbTsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICt9Owo+ICsKPiAr
Jm1jdV90aW1lcjAgewo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsKPiArwqDCoMKg
wqDCoMKgwqBjbG9jay1mcmVxdWVuY3kgPSA8MjUwMDAwMDAwPjsKPiArwqDCoMKgwqDCoMKgwqBi
b290cGgtcHJlLXJhbTsKPiArfTsKPiArCj4gKyZzZWN1cmVfcHJveHlfc2EzIHsKPiArwqDCoMKg
wqDCoMKgwqBzdGF0dXMgPSAib2theSI7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07
Cj4gK307Cj4gKwo+ICsmc2VjdXJlX3Byb3h5X21jdSB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RhdHVz
ID0gIm9rYXkiOwo+ICvCoMKgwqDCoMKgwqDCoGJvb3RwaC1wcmUtcmFtOwo+ICt9Owo+ICsKPiAr
JmNiYXNzX21jdV93YWtldXAgewo+ICvCoMKgwqDCoMKgwqDCoHN5c2N0cmxlcjogc3lzY3RybGVy
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ0aSxhbTY1
NC1zeXN0ZW0tY29udHJvbGxlciI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1i
b3hlcz0gPCZzZWN1cmVfcHJveHlfbWN1IDQ+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgPCZzZWN1cmVfcHJveHlfbWN1IDU+LAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPCZzZWN1cmVfcHJveHlfc2EzIDU+
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYm94LW5hbWVzID0gInR4IiwgInJ4
IiwgImJvb3Rfbm90aWZ5IjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vdHBo
LXByZS1yYW07Cj4gK8KgwqDCoMKgwqDCoMKgfTsKPiArfTsKPiArCj4gKyZzbXMgewo+ICvCoMKg
wqDCoMKgwqDCoG1ib3hlcz0gPCZzZWN1cmVfcHJveHlfbWN1IDg+LCA8JnNlY3VyZV9wcm94eV9t
Y3UgNj4sIDwmc2VjdXJlX3Byb3h5X21jdSA1PjsKPiArwqDCoMKgwqDCoMKgwqBtYm94LW5hbWVz
ID0gInR4IiwgInJ4IiwgIm5vdGlmeSI7Cj4gK8KgwqDCoMKgwqDCoMKgdGksaG9zdC1pZCA9IDw0
PjsKPiArwqDCoMKgwqDCoMKgwqB0aSxzZWN1cmUtaG9zdDsKPiArwqDCoMKgwqDCoMKgwqBib290
cGgtcHJlLXJhbTsKPiArfTsKPiArCj4gKyZ3a3VwX3VhcnQwIHsKPiArwqDCoMKgwqDCoMKgwqBi
b290cGgtcHJlLXJhbTsKPiArwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAib2theSI7Cj4gK307Cj4g
Kwo+ICsmb3NwaTAgewo+ICvCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDAgMHg0NzA0MDAwMCAweDAg
MHgxMDA+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDB4MCAweDUwMDAwMDAwIDB4MCAw
eDgwMDAwMDA+Owo+ICt9Owo+ICsKPiArJm9zcGkxIHsKPiArwqDCoMKgwqDCoMKgwqByZWcgPSA8
MHgwIDB4NDcwNTAwMDAgMHgwIDB4MTAwPiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDww
eDAgMHg1ODAwMDAwMCAweDAgMHg4MDAwMDAwPjsKPiArfTsKPiArCj4gKyZtY3VfcmluZ2FjYyB7
Cj4gK8KgwqDCoMKgwqDCoMKgdGksc2NpID0gPCZkbV90aWZzPjsKPiArfTsKPiArCj4gKyZtY3Vf
dWRtYXAgewo+ICvCoMKgwqDCoMKgwqDCoHRpLHNjaSA9IDwmZG1fdGlmcz47Cj4gK307Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9rMy1hbTY5LXNrLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0v
ZHRzL2szLWFtNjktc2stdS1ib290LmR0c2kKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAuLmM4OTQ0NDk5ZTgKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvYXJjaC9hcm0v
ZHRzL2szLWFtNjktc2stdS1ib290LmR0c2kKPiBAQCAtMCwwICsxLDI1IEBACj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCgpEaXR0by4KCj4gKy8qCj4gKyAqIENvcHlyaWdo
dCAoQykgMjAyMiBUZXhhcyBJbnN0cnVtZW50cyBJbmNvcnBvcmF0ZWQgLSBodHRwczovL3d3dy50
aS5jb20vCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgImszLWo3ODRzNC1iaW5tYW4uZHRzaSIKPiAr
Cj4gKyZtY3VfdWRtYXAgewo+ICvCoMKgwqDCoMKgwqDCoHJlZyA9wqDCoCA8MHgwIDB4Mjg1YzAw
MDAgMHgwIDB4MTAwPiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPDB4MCAweDI4
NGMwMDAwIDB4MCAweDQwMDA+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8MHgw
IDB4MmE4MDAwMDAgMHgwIDB4NDAwMDA+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqA8MHgwIDB4Mjg0YTAwMDAgMHgwIDB4NDAwMD4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDwweDAgMHgyYWEwMDAwMCAweDAgMHg0MDAwMD4sCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDwweDAgMHgyODQwMDAwMCAweDAgMHgyMDAwPjsKPiArwqDCoMKgwqDCoMKg
wqByZWctbmFtZXMgPSAiZ2NmZyIsICJyY2hhbiIsICJyY2hhbnJ0IiwgInRjaGFuIiwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ0Y2hhbnJ0IiwgInJmbG93IjsKPiAr
wqDCoMKgwqDCoMKgwqBib290cGgtcHJlLXJhbTsKPiArfTsKPiArCj4gKyZzbXMgewo+ICvCoMKg
wqDCoMKgwqDCoGszX3N5c3Jlc2V0OiBzeXNyZXNldC1jb250cm9sbGVyIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJ0aSxzY2ktc3lzcmVzZXQiOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290cGgtcHJlLXJhbTsKPiArwqDCoMKgwqDC
oMKgwqB9Owo+ICt9Owo=

