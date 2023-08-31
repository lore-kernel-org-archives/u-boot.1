Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9932EC83F32
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 09:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59FD86558;
	Thu, 31 Aug 2023 11:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NBL7uU62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCF486558; Thu, 31 Aug 2023 11:39:58 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5B886556
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 11:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roman.azarenko@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXVvYAX4tv/Vk+sJURTcGoKv338cRlJhyoRYLGya3lqifGvINHGpXt+U6mUT9x552asnni2WZ5zNZDfMsIWO7w7m63AcWmUKmy76avt3fWVs6VRhJMAFTfOBsXyX0bnp5Hkon6KmmprHK4+49am9vHW3S6MrwC72EI/Jkh+cWF1sQOWNEtGfotchxgH86Th7zwKEH/SyyanuQ5SM/5PTWRWMtjvj3O7M7zTOOshdcf79zqgq5ruMsFozpWQ66DPJOq04pCQhVUcCNw6YCgnJ/WJBhSxgB0gRm726bjAjuAD6FI8QzZVa5xw2ZJleXt7KFePWYTICJ1JEFjwyyFgbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT+U9PhVuhr6IF5zDz69b61V+ZyskmCPg97u07AaO1g=;
 b=ezh0xeGqPzvu4EknYY2fIu+pILqCSMqMr3rkW8Mt+XP+MRaQaFR6aA+QSvvfkFpolKWHTGnE2CzVFK2HRgTstcP5sxKXona3YPfRmJWf9L8r1+53gfkMCFUv7/h0CvKmvLNaOWmpDM43Q/Jzd40a0dbztER8vQ2HvJ31D/adoD8gaDv/CjQEuQdG+giytcxmQ5A5M1i2a8QKQtLPvWEe/k0K4Wzt2McMkqJ7UIhoSjI0K6sbqO+pEyrVooIMnKfa9FYDOb4x7XgkJWV1km6EfI/YATGG8B7VqXb4Wn28+zC/PjpnP8C+bt1hSE+s0J6FHbUVyHKd3HqpEgi0e9bEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT+U9PhVuhr6IF5zDz69b61V+ZyskmCPg97u07AaO1g=;
 b=NBL7uU62NCiTqfJAskptEHPfOhm+lZ+HyAGpzfLYVqb0fdi3ZpS1f6Ehix7ybkXZKyxUcpI7PyHjk4ozbKojeAs8qrdprXEEWUS7w0GgbUbDDA8fLvYj2zqZqaC8IVFft83pjU2xnoq7h/nLrJ7OKqUNbSzbv+7rBLwhyyr8Dy0=
Received: from AS8PR08MB9813.eurprd08.prod.outlook.com (2603:10a6:20b:616::19)
 by AS8PR08MB8369.eurprd08.prod.outlook.com (2603:10a6:20b:56c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 09:39:52 +0000
Received: from AS8PR08MB9813.eurprd08.prod.outlook.com
 ([fe80::785c:ef75:649f:d3cc]) by AS8PR08MB9813.eurprd08.prod.outlook.com
 ([fe80::785c:ef75:649f:d3cc%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 09:39:52 +0000
From: Roman Azarenko <roman.azarenko@iopsys.eu>
To: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "punit1.agrawal@toshiba.co.jp"
 <punit1.agrawal@toshiba.co.jp>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "massimo.pegorer@vimar.com"
 <massimo.pegorer@vimar.com>, "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
Thread-Topic: [PATCH v2] tools: ensure zeroed padding in external FIT images
Thread-Index: AQHZ1yuazzKpqTxGjUmKsfGwSpmdg6/7T1OAgAQNnACAAKYyAIAELLWA
Date: Thu, 31 Aug 2023 09:39:52 +0000
Message-ID: <bdab65fe23d334a0f5df076df6c1d793cd4d72ab.camel@iopsys.eu>
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
 <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
 <89ab674dc53557f093d42fe4ca54ca4a14f8a276.camel@iopsys.eu>
 <CAPnjgZ0Be-fAjFWNwmuHjEvtDCNypDYtH-8+5Son2_S7LeJe4g@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Be-fAjFWNwmuHjEvtDCNypDYtH-8+5Son2_S7LeJe4g@mail.gmail.com>
Accept-Language: en-GB, en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR08MB9813:EE_|AS8PR08MB8369:EE_
x-ms-office365-filtering-correlation-id: 7a7d6e4d-2ecb-4418-8a31-08dbaa063a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+V7RpxOC8uZlLkJ5cPpPEoXVN8EFlHU2n02lYUeC3T9VNU8aiyBRAZR4j4JQL5b+ucINzNQXZ4vC7yNHdMr5Km7WVeuMfXjCwl5FLawihlQmEWhgFma1ZfHFOYofV1iKQIHw0o8xJZ6lvqwH8WT8u3+7CDGN3YPpXlorIVo6w15ea+Z9jk9NQU4OChdjs10yoVK9aZ2JST+Yhivc+oC2DpZpgKcPLmoZbl2Bp1nM62sHuIBQal2JYYogDWHNn8f2C4hwGPMI/mNlXOwD4y0bdFKRSk7yIRwTM3e95xsP2/kwTyu2KQxVGV578ltR+goGz8fA1Bswr6UVotbLuFmKQXkyJaDu8+zUFnWZagi32VHIfDgjJyryky7I4BpivPeRISAUMNF9osds9y29xUS7w6AjvFXLVq1zQNaKY1Ogt7pvltgEXL6R3v6mhMByjM/tsExmgMVIoC5Bhg6YG5QOI0wUepaih9jUF7Bff2u+ZD5oWhSgYhp14GMf6iTf9AxHRuUDF/PpElTBPSU7PSTScABoPqJOeVZAWyWe8Mi4T00wnXi41TJ9ecDvSV6hO7LHr8bORQ+lqPVBWfga+n/AXfmfSR4ZpIfjBVzk/eTyWE6BnGOki+JSqwmEthBy2z2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB9813.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39850400004)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(38070700005)(38100700002)(316002)(41300700001)(5660300002)(4326008)(8676002)(83380400001)(2616005)(44832011)(86362001)(26005)(36756003)(2906002)(8936002)(66556008)(71200400001)(6506007)(64756008)(6486002)(66446008)(54906003)(66476007)(91956017)(76116006)(122000001)(478600001)(110136005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N25FUFBDSDJwR1F0aTBJOUF4d0txT25WKzA5ZTIrazB5TmJMSTQ4aEREU014?=
 =?utf-8?B?cUsyT3pGTGhYNkFFZXdiSUVieU40UWp6ZTZvT0RCbDlzL2M4elQ2V3dtZzVV?=
 =?utf-8?B?Q2tGWUhBWDFUVHVYWHlNVzJvWnRzL3ByUzF5QWtMWlhHYnpybDN1SDF4VUFX?=
 =?utf-8?B?aWJSL0R2YkF6RjBYbTRkQjYyN3pxZDBPcTJGamFzdjZLTDV3M2dNM1UxRWVW?=
 =?utf-8?B?OEIyYWxsSHpmdXB6TW9aN1ZnWFlCWlRLbkk0eXRRbVpxRDNjUGRrRVlySVNw?=
 =?utf-8?B?UlpPUUNWdmwzTXl5cExhQkRGMlVHM2dRUkVMQ1RjNk5PZm5sTmErWnpyUDVI?=
 =?utf-8?B?eVRJQU5CVTR3OU9NcklNMjduaHlhdWhHbHdRSTFZYjFFUy84d0NVcE5zWlpz?=
 =?utf-8?B?MUJTREhmcCsvTGRTRVJ5d1YvcWFiTzVobWRPMlN4elJGKy9KVXlkOHZPelRq?=
 =?utf-8?B?TnU1RktmQjlpYW0ycDFwUWZTMWZ0RVVYek83bTlZcmZ5eW9MWWJNWHQxVENJ?=
 =?utf-8?B?QnpCaWR6M1o4bXJUTEV6QU9SWEFQV1FxNk5uVDJyUjdzdGY1eWFxVDRqbFQy?=
 =?utf-8?B?V3puWmlYRjZtd1NZSHNLYnByazVoUWtBdTRDcE8rV1pyVWkrU3paMlRqd2RW?=
 =?utf-8?B?WXhVY29Gd1ZCUTlYYXZKZE9acG9WemhvbTQ2d29MajZuZDNxTTBtZmxWT3Ar?=
 =?utf-8?B?YlYva2Y5Ulp5MU02dkl6YkI5T1JCWktUeENCakYxaDBnVHFHOUJMWHV3YVpr?=
 =?utf-8?B?OEFKU0l0MEFYMDFOa2JiSUxkZnhTRnpIcmtueVk2TnhXeFRBMnFHdWdYQWNy?=
 =?utf-8?B?WitRVm9XRm5seHlQZ3pRSmplZHJ5U3ZBSld4TERPb3lCKzkvRFg1cVB2c0ZB?=
 =?utf-8?B?QS8vcHBjck12ajkrSy9aNTRBc3prTXIwaERURkVDVWcxQVVjYS9TZmRmSncy?=
 =?utf-8?B?a2pwVk8yOXdmTGttRXpxZWZsQ1YxTUoxV3NpOCt0MlRJUWN0YnZEa3ZLZVZS?=
 =?utf-8?B?YlN6SldxNFc0ckxMOUhyTUYyVWdiOCtiMXF0OVFyTG5xNEpQKzY1aUVWMDlO?=
 =?utf-8?B?eTdaRWFrS1R2VzY3OEN0Ykd5NHY3aVliTG5KVDNMckt1MFF3bWozWVhjWFJJ?=
 =?utf-8?B?cTNqcS93SkptUkhUSStuZ0psd3Z3cVRJYm1Bb0dkM0xNNzdnKzZIOUtSM3RF?=
 =?utf-8?B?ZW85OE9JRmdoVHgxSHpBVGViZzJsMmF1TWExUnl4L0JFM3pmb0NLYUFhWDIv?=
 =?utf-8?B?S1dYRXIvak5LZmlaQ2JuKzlzSDlKMnErZVR3WHlQNk9JajdQZ0VaOG9ZWnlU?=
 =?utf-8?B?VDZQOUFmaVNhTzZ4NGl4bnAzb2JXY1VGT1ZkdGhvb1p4YUJkdW00UzVBTGE5?=
 =?utf-8?B?blVwREhPdjI4bTJ0VHJZYjhQWlN2WE9aNURwVG9BTkJzY084WWlBRCt4ZVMz?=
 =?utf-8?B?U0pEWTBXKzZsU292Zy9qalVOQjFkWGp4b1hIb0M2Ni84VEtQeG1tZG9ZSkZW?=
 =?utf-8?B?blRDa0NOdDN5TTBHTEpiNUx3ZjNMV2FjNjRYL25rcUxpN3FpSUw2czRrT1c1?=
 =?utf-8?B?MktoL0hpK2NqM2FydCtEc1Bkc3JhVHJZSGYyd2pYOVZzUUxEay9xRUFNbEdY?=
 =?utf-8?B?UkRyZjR6TXkrMm5PdGpVMFpYUElTQnhtdXBHaW5UWXh5KzRXRGFPZjVOemw4?=
 =?utf-8?B?MnJZNGVvKzZhR1lrdnBlczdiS3RXdktzMTYwVUFLcTJtWVI4SFJTcWo0TkIv?=
 =?utf-8?B?NHFmcFNvVDVERFBISVlMTm9HeloyZzNEM2ZNS01EclJSSFRybDJLN3hVT0hp?=
 =?utf-8?B?WjRITDdVWUI0NVVuWlVNeXZqVkRuUUVIbzZ1VjB5N0xyck1uOWFsSSsyYk51?=
 =?utf-8?B?ek5xSm9DTDVIbXAxRVhPQjVteVR6THYrcFpyeG9qOWUwdjBYdGwvNVpiaDZt?=
 =?utf-8?B?UkVzSXM5bHorMVZnTFVudXd5R3pQaWlIMVJnQWp4dlZQUkx4QXlmS2czUW5I?=
 =?utf-8?B?ZUZpbk5uektUUlRnbGpJY04zVnY2N1RHUlpjUGlsVGluTmFWdjdOa3hDSFJF?=
 =?utf-8?B?cEhiZUNtOEpmc3dNWVlaYk9DT20zdDY1aW5ONnZkSmw4ZHJ3TEF6UTVCcDNl?=
 =?utf-8?B?NkpseXQ0MHZGR1dHdnZ6UnpqNWxZS2tmcXlpSTNrQTd3R1AydHQrdzRoNTFi?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A57E3BB02116D4EB31946E84B86DFCD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB9813.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7d6e4d-2ecb-4418-8a31-08dbaa063a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 09:39:52.6843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+5yjjVn1DaYu9sy0XHoFvWE4XebFNPS3AOebqIYjDc2ongQN7X4JFyou4YDGenUozY+4KxoGv0Iyu8LaiDQcRh321B4QiDUur7dJGPWuVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8369
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

PiBPbiBNb24sIDI4IEF1ZyAyMDIzIGF0IDAyOjAwLCBSb21hbiBBemFyZW5rbw0KPHJvbWFuLmF6
YXJlbmtvQGlvcHN5cy5ldT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCAyMDIzLTA4LTI1IGF0
IDEyOjA2IC0wNjAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gPiA+ID4gQEAgLTU2NCw5ICs1NjQs
MTMgQEAgc3RhdGljIGludCBmaXRfZXh0cmFjdF9kYXRhKHN0cnVjdA0KPiA+ID4gPiBpbWFnZV90
b29sX3BhcmFtcyAqcGFyYW1zLCBjb25zdCBjaGFyICpmbmFtZSkNCj4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoCAvKiBQYWNrIHRoZSBGRFQgYW5kIHBsYWNlIHRoZSBkYXRhIGFmdGVyIGl0ICovDQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgZmR0X3BhY2soZmR0KTsNCj4gPiA+ID4gDQo+ID4gPiA+
IC3CoMKgwqDCoMKgwqAgbmV3X3NpemUgPSBmZHRfdG90YWxzaXplKGZkdCk7DQo+ID4gPiA+IC3C
oMKgwqDCoMKgwqAgbmV3X3NpemUgPSBBTElHTihuZXdfc2l6ZSwgYWxpZ25fc2l6ZSk7DQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqAgdW5wYWRkZWRfc2l6ZSA9IGZkdF90b3RhbHNpemUoZmR0KTsNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoCBuZXdfc2l6ZSA9IEFMSUdOKHVucGFkZGVkX3NpemUsIGFsaWdu
X3NpemUpOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGZkdF9zZXRfdG90YWxzaXplKGZkdCwg
bmV3X3NpemUpOw0KPiA+ID4gDQo+ID4gPiBJIGRpZG4ndCBrbm93IHRoYXQgd2FzIGFsbG93ZWQu
Li5JIHRob3VnaHQgaXQgbmVlZGVkIGZkdF9vcGVuX2ludG8oKSA/DQo+ID4gDQo+ID4gVGhlIGlu
dHJvZHVjdGlvbiBvZiBmZHRfc2V0X3RvdGFsc2l6ZSgpIGNvbWVzIGZyb20gY29tbWl0IGViZmU2
MTFiZTkxZQ0KPiA+ICgibWtpbWFnZTogZml0X2ltYWdlOiBBZGQgb3B0aW9uIHRvIG1ha2UgZml0
IGhlYWRlciBhbGlnbiIpLiBUaGUgY29tbWl0DQo+ID4gbWVzc2FnZSBkb2Vzbid0IGRlc2NyaWJl
IHRoZSBjaG9pY2Ugb2YgdGhpcyBmdW5jdGlvbiB2cyBmZHRfb3Blbl9pbnRvKCkuDQo+ID4gDQo+
ID4gUGVyc29uYWxseSBJJ20gdW5hYmxlIHRvIGRlZmluaXRpdmVseSBjb21tZW50IG9uIGl0LiBJ
IGNhbiBvbmx5IGJsaW5kbHkNCj4gPiBndWVzcywgdGhhdCBiZWNhdXNlIHdlJ3JlIG9ubHkgY2hh
bmdpbmcgdGhlIHRvdGFsIGxlbmd0aCBvZiB0aGUgZmR0DQo+ID4gc3RydWN0LCBhbmQga2VlcGlu
ZyBhbGwgb3RoZXIgZmllbGRzIHRoZSBzYW1lLCB3ZSBkb24ndCBuZWVkIHRvIGFsbG9jYXRlDQo+
ID4gYSBuZXcgZmR0IHN0cnVjdCB3aXRoIGEgZGlmZmVyZW50IHNpemUuDQo+IA0KPiBJIGFtIG5v
dCBzdXJlIGlmIGl0IHdvdWxkIGNhdXNlIHByb2JsZW1zLiBJIGRvIHVuZGVyc3RhbmQgdGhhdCB5
b3UNCj4gZGlkbid0IHdyaXRlIHRoZSBjb2RlLiBZb3UgY291bGQgY29weSB0aGUgcGVvcGxlIHdo
byBkaWQgKGFuZCB0aG9zZQ0KPiB0aGF0IHJldmlld2VkIGl0KSBmb3IgdGhlaXIgaW5wdXQuDQo+
IA0KDQpAS2V2ZXIsIEBQdW5pdCwgQFRvbSwgY291bGQgeW91IHBsZWFzZSBjb21tZW50IG9uIHRo
aXMgcmVtYXJrIGJ5IFNpbW9uPw0KVGhhbmsgeW91IQ0KDQo+IENvdWxkIHlvdSBhZGQgYW5vdGhl
ciBwYXRjaCBiZWZvcmUgb3IgYWZ0ZXIgdGhpcyBvbmU/DQoNCkknbGwgbG9vayBpbnRvIHRoaXMg
YXMgd2VsbCwgYW5kIHNlZSBpZiBJIGNhbiBmaWd1cmUgaXQgb3V0IGFuZCB0aGVuDQpwb3N0IHYz
IG9mIHRoZSBwYXRjaHNldC4gVGhhbmtzIQ0K
