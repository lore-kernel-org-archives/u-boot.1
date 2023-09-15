Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87673EE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 13:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7C9864E8;
	Fri, 15 Sep 2023 15:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="GGVzaRJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8FF86489; Fri, 15 Sep 2023 15:05:46 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC7E86680
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 15:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joao.goncalves@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1694783142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MIsAo84uk09QdWqW2BUTByvuZqLUzHTB8yWL87UEeJY=;
 b=GGVzaRJyVtPl+tnJJ5Z2C44cI9Vh+k4T6vCfjSZ4j/MIZY+K/k0m6GqTFfY/LRR+tKYavS
 HBqeIJQNFjHdqFxBsNiPc5kRkSbgCCgXmOLLVN/i8h+Ji1cnjJQgRnQ5v+aoYhfyWaFdhU
 jkgMg7JOdIptBP1EL5jBU2rSUNj+FfQ=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2110.outbound.protection.outlook.com [104.47.22.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-65-_QJJFGDaNOmTrPBE4mvLHw-1; Fri, 15 Sep 2023 15:05:41 +0200
X-MC-Unique: _QJJFGDaNOmTrPBE4mvLHw-1
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::5) by
 GV0P278MB0928.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 13:05:39 +0000
Received: from ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6528:7071:f23d:6401]) by ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6528:7071:f23d:6401%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 13:05:39 +0000
From: =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>
CC: "lukma@denx.de" <lukma@denx.de>
Subject: USB: error messages on DWC3 gadget endpoint dequeue
Thread-Topic: USB: error messages on DWC3 gadget endpoint dequeue
Thread-Index: AQHZ59VTV1XKDqmqN0a6Mhj0jFvbbw==
Date: Fri, 15 Sep 2023 13:05:39 +0000
Message-ID: <6c9901297ce8cda6ec83304187582b3d658a6457.camel@toradex.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0873:EE_|GV0P278MB0928:EE_
x-ms-office365-filtering-correlation-id: fff3d3cf-950e-4bfb-c284-08dbb5ec758d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +enljzJFDHNuZR1CtCAuNCv8EhytsPLI7t8GUTujx3vGRN0e7b0i2AJ4RYw0H5sLJIjOHld83cOqW2959t2OiP/xrhdaf57Ab6JhedAs4qyW2eF5x9DcMRXxuvsA+hB4GDunTSsnIny7H2dxwbRbal68M7mxk3/hJ2fhjYveSbc+hMqx/2IGBkTLgl52l513But1taQRRfQWjxFUHtbuVngkg+rZt3YxVtiO5uGgqerLUe2gtDFm+ybO5aTTiPwqrRtToD9NTAks2VR7OXwOEEHwjO+CD5syK/TjqBSvWPkkrD9sM/SAUlPYPSu5rWtHoGXzzf1D9aqCpU8GlRSk2h8Agm156wQ+7/3S9pg7JOvzyrZWfTb5AYAAXZnH52xuEziHz+/PW1VOBg99qWiONPJLj33VGV9bl9LPb2JgwI8fKb8h9YLuLmeaC2yTESNxZFfyesETDmVB7URcpA66iShOr0E812UaG6LjDN9PONVm80IubE2YVOLfC3L+ATZbQKzs9QpK24vd7gZ9e8eNMoa3P9/b1XpupETUo+8vVQOcp+SVEh9n+DGVZQpW/sS4eu90dValRKAhzc4LGPuXbp+vudh94z9zQXKTBhNSPy6D/aepTG+QOE7Xf/VcyQe1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(346002)(136003)(376002)(396003)(366004)(1800799009)(451199024)(186009)(110136005)(83380400001)(71200400001)(26005)(66446008)(66476007)(2616005)(66556008)(66946007)(64756008)(76116006)(316002)(91956017)(8936002)(4326008)(8676002)(6512007)(5660300002)(41300700001)(15650500001)(6486002)(6506007)(2906002)(478600001)(86362001)(122000001)(85182001)(36756003)(85202003)(38070700005)(38100700002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUw2MFZ0akoxbzNMQmRKWE9CQzlzQjluZkJaNFc4U2E3ak5xMzlUbE8zT0dI?=
 =?utf-8?B?Yk5tVkR6S1gxZG5ReVBNN1ViVWhHSitjUzdaRTNTQyt2RHV5YVlrK1ZVdTJG?=
 =?utf-8?B?SXJGYVFXdDhGMnZQTHVBY3dOd05XN2Y3OXkwdHBMZWk3MjVacVRrUFRtcUpn?=
 =?utf-8?B?UE9OTVVLaVpsa2VaU2M2Tm1MMkloY2h2ZVc3Wlo2ZlBkZDV3dUVTRTBsY0l3?=
 =?utf-8?B?YytweGRLUkVWKytaZ2Yxam82dS96R2t2Rmh3U2V0c0FhSjdnOVNUNVZ4U1VW?=
 =?utf-8?B?R0NMb1R5c2w4SVcwcWh0WlR5bk5CNVNkYzM5cHNnVXVNSnJaVFN6cTNEQXZV?=
 =?utf-8?B?ZzMyREN2Zk5KcGhNUHV2WnM5cmdXV2JsOHh1cEV0aXN0blFGVDJNZlRndHBH?=
 =?utf-8?B?NWRCckJZTXdVcno3dWVaNE1SYVR4eTJhc2hiYUtUZWFyR3N5ZFBNZzVROWNF?=
 =?utf-8?B?STVYNGljR09KSjQvdmtaWE9KQ0ZUdExuT1BNZ3kwcnhmNGsxY1FIRStPU0Iz?=
 =?utf-8?B?UHZ2NXd0czZmaEhjaklxU2lhK1pIeFY3eVB4QWVrRFdhSFRJZU5TcTcvT3hY?=
 =?utf-8?B?VnQzQnhQTHNJWEVzVEp2eHhxcWFCZWJxNTkraXA4ZUE0WmNzeUxOOFRvclIz?=
 =?utf-8?B?NTJPMDhETGZwUWxNYUxta2t5N1VSYmpuakFOVTVIeHVXUDVnWE5yZ2RlQ0NO?=
 =?utf-8?B?eERybFRBU0Z0dE5CZWk1cjhIY01GVkRpbk1ydVlvY0ZuczZSSU0xZG1EVnhi?=
 =?utf-8?B?dWdQcXF1K1lKQU5EenFBSzJUTk9TTUErZXVDc29BZzdmTjRrMGxYNjhVY2Jo?=
 =?utf-8?B?eWFjWm4zNXZRTzJBRTNjbGoyRy9ibGg5OWV2clR1UkpoUU1OanBxSEV0VC9K?=
 =?utf-8?B?Mnl0QVFmRE90bmFUQUtkK2lMQThMYlhieUlKZHNQU0hoR0NCbHlVS3lTUGpz?=
 =?utf-8?B?enJBN3d0Q1BUTUVWencySXpmQTI0cktQQk1wa09FVzRJeTlHaDZ1bHB0cENu?=
 =?utf-8?B?TjJrYzBXTjMybVFEM1QrZy9PT2N3RUFzL1NJczBYZXY2UGNkMlZKTVYrS2xo?=
 =?utf-8?B?MmlKRmxBV215RjN5OFI2TjhBZUVuc085MUpSRmtuWXlKL3hPZVVLMFVMRWpS?=
 =?utf-8?B?LzNzVGhnSFBlU2UzTVd2WXZJUjVBZTlSTHhBcnBhbXJqa01GeG9vMkk5MzA5?=
 =?utf-8?B?eTV3WjJXTkRFOXROQ0JFNHErYUJHYWUvOUtpcFQ4UnZTZlQrMThLd3ptZVdi?=
 =?utf-8?B?NHBVaWY0WWthODJkRUliNllxa3dNR0x0S3pKKzBVTmgxdEVwL1RLVmJyc0Vn?=
 =?utf-8?B?bzdMR1pXcFJUSG9aRUVNOUtkcURqR2h2Y3IyMWRjLzFNeFVLa0VROVVOL2V0?=
 =?utf-8?B?cjJrQm9kSGlpYStYd09YUno4R0JqdlUvdG1WQ1NwVDJXZjc2WEN2TEN5eEgw?=
 =?utf-8?B?ZmJxNnc4ZDRkWnI2eVNrTCtLcGF1RDhpRGZoYVNUUm5iUmFVNHZKU09DU3JX?=
 =?utf-8?B?QWpxYUVCWjVzY2pCejF2Ti9mV3V4azViSERyZE9jblNXcUxrK0hWcko3ZjU4?=
 =?utf-8?B?ejJNbmpoYkFYM2k3R2pnVkFTV3ZoMTE2eTFaSnRQR2kxdWZ0K3ArZUJuanpJ?=
 =?utf-8?B?dHhyVFZDWm1zV1dDWWkxK1FJY2Zvc2tJNHl5bmkvMUg1V00zQ1FtSjVFZUhW?=
 =?utf-8?B?alBVZWpQOFNNNmxNcFUzUjhDTFFrYnVmdEhyU1dwQURQOGczTHBLTDVmRlZa?=
 =?utf-8?B?K3A0T3VJTGNwM2RiS0Q2WTlrcEF4NGxlRlVReXYyd1lKeWtUaE5RVGZXcWlu?=
 =?utf-8?B?UGxuQUpicmFqYTJ5ZTZsNTNrWHZ4MTFURnNkRi9HNFFCL1JwUUNITnJNdzhX?=
 =?utf-8?B?VlNVWXNRbVFrZm1IS0JUMFN0L1BrTG43b0JCNytTNHBuZTJyaTVDMmlMNTNl?=
 =?utf-8?B?eHBXMGNrdVVmY0E1K3VrUmI2QWdUMTFOMU0vSitZTUQrc0F1ZzFkWDhrME5N?=
 =?utf-8?B?L3p3OG1ZeFZXVHA2YVNmTG80YitUQ0NQZGM4TDR4OU1BS0hKZTBVdnJmb3hq?=
 =?utf-8?B?MXR4M1Q4a2cwRlFrUWh3YmJka0N4NG1uZWhoQ1ZrdzFsWC9tYktMdllxRzR1?=
 =?utf-8?B?M285QWsyaGNKRTNCQ2NZcEJXdjNPOUVlSkk2NXFTOTJRTG54ckNjdC8rVkdM?=
 =?utf-8?B?bmc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0873.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fff3d3cf-950e-4bfb-c284-08dbb5ec758d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 13:05:39.2185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3reQb+WULqPmmh7LptSqrRGzYRBCY5XcLn9U5Gn2HphjJnBLtGKW7l4dsARoFwAu1spaFQ61moCANes4cBkhV5YZYzPnIlUMWBjfLoqCDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0928
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E354504BC79DF441A938D5FEF933830A@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Fri, 15 Sep 2023 15:24:17 +0200
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

SGkgTWFyZWssDQoNCkkgd2FzIHRlc3RpbmcgZmFzdGJvb3QgaW1hZ2UgZG93bmxvYWQgb3ZlciB1
c2IgZm9yIGlteDhtcCAoZnJvbSB1c2INCnJlY292ZXJ5IHBhdGNoIG9mIHZlcmRpbi1pbXg4bXAp
IGFuZCBpIGFtIGhhdmluZyBlcnJvciBtZXNzYWdlcyBvbg0KZW5kcG9pbnQgcmVxdWVzdCBkZXF1
ZXVlIGZ1bmN0aW9uIG9mIERXQzMgZ2FkZ2V0IGNvbnRyb2xsZXIuIEhvd2V2ZXIsDQpkb3dubG9h
ZCBpcyB3b3JraW5nIGZpbmUsIHNvIHRoaXMgbWVzc2FnZSBtYXkgbm90IGJlIGFuIGVycm9yLiBU
aGV5IGFyZQ0KaGFwcGVuaW5nIGJlY2F1c2UgZmFzdGJvb3QgdHggYmVmb3JlIHNlbmRpbmcgYSBu
ZXcgdXNiIHJlcXVlc3QgZGVxdWV1ZQ0KdGhlIHNhbWUgcmVxdWVzdCwgbWF5YmUgdG8gYmUgc3Vy
ZSBpdCBkb2VzIG5vdCBzZW5kIGl0IHR3aWNlLiBDYW4gSQ0KanVzdCBpZ25vcmUgdGhlc2UgbWVz
c2FnZXM/IE1heWJlIGNoYW5nZSBpdHMgbG9nIGxldmVsIHRvIGRiZyBpbnN0ZWFkDQpvZiBlcnJv
cj8gV2hhdCBkbyB5b3UgdGhpbms/IFRoZSBtZXNzYWdlcyBJIGFtIHNlZWluZyBhcmUgYmVsb3cg
YW5kIGFyZQ0KdGhlIG9uZXMgd2l0aCAiLi4uIHdhcyBub3QgcXVldWVkIHRvIGVwMWluLWJ1bGsi
LiANCg0KVS1Cb290IDIwMjMuMTAtcmMzLTAwMDI4LWdjOTlkMDUyYzc2IChTZXAgMTQgMjAyMyAt
IDE1OjU5OjIyIC0wMzAwKQ0KDQpDUFU6ICAgRnJlZXNjYWxlIGkuTVg4TVBbOF0gcmV2MS4xIDE2
MDAgTUh6IChydW5uaW5nIGF0IDEyMDAgTUh6KQ0KQ1BVOiAgIEluZHVzdHJpYWwgdGVtcGVyYXR1
cmUgZ3JhZGUgKC00MEMgdG8gMTA1QykgYXQgNDdDDQpSZXNldCBjYXVzZTogUE9SDQpEUkFNOiAg
NCBHaUINCkNvcmU6ICAxNjggZGV2aWNlcywgMjggdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFy
YXRlDQpXRFQ6ICAgU3RhcnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVy
eSAxMDAwbXMgKDYwcw0KdGltZW91dCkNCk1NQzogICBGU0xfU0RIQzogMSwgRlNMX1NESEM6IDIN
CkxvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBNTUMuLi4gT0sNCkluOiAgICBzZXJpYWxAMzA4ODAw
MDANCk91dDogICBzZXJpYWxAMzA4ODAwMDANCkVycjogICBzZXJpYWxAMzA4ODAwMDANCk1vZGVs
OiBUb3JhZGV4IDAwNTggVmVyZGluIGlNWDhNIFBsdXMgUXVhZCA0R0IgV0IgSVQgVjEuMUENClNl
cmlhbCM6IDE1MDA3MDk4DQpDYXJyaWVyOiBUb3JhZGV4IERhaGxpYSBWMS4xQywgU2VyaWFsIyAx
MDk1MjYzMQ0KU0VDMDogIFJORyBpbnN0YW50aWF0ZWQNCk5ldDogICBldGgxOiBldGhlcm5ldEAz
MGJlMDAwMCwgZXRoMDogZXRoZXJuZXRAMzBiZjAwMDAgW1BSSU1FXQ0KSGl0IGFueSBrZXkgdG8g
c3RvcCBhdXRvYm9vdDogIDAgDQpWZXJkaW4gaU1YOE1QICMgDQpWZXJkaW4gaU1YOE1QICMgZmFz
dGJvb3QgMA0KZHdjMy1nZW5lcmljLXBlcmlwaGVyYWwgdXNiQDM4MTAwMDAwOiByZXF1ZXN0IDAw
MDAwMDAwZmZiMjljNDAgd2FzIG5vdA0KcXVldWVkIHRvIGVwMWluLWJ1bGsNClN0YXJ0aW5nIGRv
d25sb2FkIG9mIDMwODQgYnl0ZXMNCmR3YzMtZ2VuZXJpYy1wZXJpcGhlcmFsIHVzYkAzODEwMDAw
MDogcmVxdWVzdCAwMDAwMDAwMGZmYjI5YzQwIHdhcyBub3QNCnF1ZXVlZCB0byBlcDFpbi1idWxr
DQoNCmRvd25sb2FkaW5nIG9mIDMwODQgYnl0ZXMgZmluaXNoZWQNCmR3YzMtZ2VuZXJpYy1wZXJp
cGhlcmFsIHVzYkAzODEwMDAwMDogcmVxdWVzdCAwMDAwMDAwMGZmYjI5YzQwIHdhcyBub3QNCnF1
ZXVlZCB0byBlcDFpbi1idWxrDQpkd2MzLWdlbmVyaWMtcGVyaXBoZXJhbCB1c2JAMzgxMDAwMDA6
IHJlcXVlc3QgMDAwMDAwMDBmZmIyOWM0MCB3YXMgbm90DQpxdWV1ZWQgdG8gZXAxaW4tYnVsaw0K
U3RhcnRpbmcgZG93bmxvYWQgb2YgODYgYnl0ZXMNCmR3YzMtZ2VuZXJpYy1wZXJpcGhlcmFsIHVz
YkAzODEwMDAwMDogcmVxdWVzdCAwMDAwMDAwMGZmYjI5YzQwIHdhcyBub3QNCnF1ZXVlZCB0byBl
cDFpbi1idWxrDQoNCmRvd25sb2FkaW5nIG9mIDg2IGJ5dGVzIGZpbmlzaGVkDQpkd2MzLWdlbmVy
aWMtcGVyaXBoZXJhbCB1c2JAMzgxMDAwMDA6IHJlcXVlc3QgMDAwMDAwMDBmZmIyOWM0MCB3YXMg
bm90DQpxdWV1ZWQgdG8gZXAxaW4tYnVsaw0KZHdjMy1nZW5lcmljLXBlcmlwaGVyYWwgdXNiQDM4
MTAwMDAwOiByZXF1ZXN0IDAwMDAwMDAwZmZiMjljNDAgd2FzIG5vdA0KcXVldWVkIHRvIGVwMWlu
LWJ1bGsNClN0YXJ0aW5nIGRvd25sb2FkIG9mIDQ3MTczNDAwIGJ5dGVzDQpkd2MzLWdlbmVyaWMt
cGVyaXBoZXJhbCB1c2JAMzgxMDAwMDA6IHJlcXVlc3QgMDAwMDAwMDBmZmIyOWM0MCB3YXMgbm90
DQpxdWV1ZWQgdG8gZXAxaW4tYnVsaw0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCi4uLg0KLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4NCi4uLg0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCi4uLg0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCi4uLg0KLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
DQpkb3dubG9hZGluZyBvZiA0NzE3MzQwMCBieXRlcyBmaW5pc2hlZA0KZHdjMy1nZW5lcmljLXBl
cmlwaGVyYWwgdXNiQDM4MTAwMDAwOiByZXF1ZXN0IDAwMDAwMDAwZmZiMjljNDAgd2FzIG5vdA0K
cXVldWVkIHRvIGVwMWluLWJ1bGsNCmR3YzMtZ2VuZXJpYy1wZXJpcGhlcmFsIHVzYkAzODEwMDAw
MDogcmVxdWVzdCAwMDAwMDAwMGZmYjI5YzQwIHdhcyBub3QNCnF1ZXVlZCB0byBlcDFpbi1idWxr
DQoNCg0KDQpUaGFua3MsDQpKb2FvIFBhdWxvICANCg==

