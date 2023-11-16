Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A70CC54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 10:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BDA87206;
	Thu, 16 Nov 2023 11:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="EE7ZLq9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3D78749F; Thu, 16 Nov 2023 11:57:36 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AF38654D
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1700132252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Y7url4p1JCLwN9f0a8XVJvBJEf27u8usasNcdx77Gs=;
 b=EE7ZLq9L8CEcswrCaInsbLzd3yQgVdWl/oOTP7KqFmaoV07v8f0YYC+ON5+VOKqRl0x4su
 uCCh/kPOJbDT4zV9Au1XhxHudaxe5umdj+5XhCfQl6YJb4e1/IEObzGDJiYn7K91D0v/s7
 pRiIbVdaKRkGsfxaZFpSUgJ/2bUv5A8=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-45-GOiF0bbQPFaeaMXebhjR3w-1; Thu, 16 Nov 2023 11:57:30 +0100
X-MC-Unique: GOiF0bbQPFaeaMXebhjR3w-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0125.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.21; Thu, 16 Nov 2023 10:57:28 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2%6]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 10:57:28 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "festevam@gmail.com" <festevam@gmail.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Topic: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Index: AQHaB96XRXORtSp5rEyqWMgsCwfvILBbvWuAgAAByACACug8AIAWQDIA
Date: Thu, 16 Nov 2023 10:57:27 +0000
Message-ID: <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
In-Reply-To: <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0125:EE_
x-ms-office365-filtering-correlation-id: c10a2dd2-26d1-4694-fadd-08dbe692d2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: DpJispC+n+JG5jgJn4JbaN7njRS6RBqeiTDV7KDuz2TSAv31p66KSADBAjeCmZWYNtMTJr6T4LZAaOwONwoNFqjynYjyp4wpitITe30CktiB7c1gmL9yLOY6glgOzH4ueKhFa0bjTG4EjIX+hxrWruZg92c0iL72TEIUm6uCJ4nx6SKgK124xlOoH00yaNWw7YX8EUaj4ob6ofWT5VLLYNJvIdE4YnnkNy6vpvBYFYXkD5ng3jJspzG+3YSQGEUZ9+6l1U0sMne0fxoMPu7NTYTiDURmnJQg++VlTPP8wFuJBJDXG+DapibEt//HnKZYXgvr1pCx0XCOx4rM61AoQO7BY4+vCOkmHy1A4vjg1oeEH+kHE4gY6WElIBEL+cpCd+Ch4LgUWokv826n3z+IqB9IzsIkvLQTjf7rILFWMOyHz52rd5xLDaIztybvxV931rJCyfyucgEY1v2g03Rorj4bEfVrMT+I1EgbMQXacC6nLu2bDGjzqdh/XXGcwHvxnBf4NbdjonwkQBPgHeV+dlzwvkVpjUi4AZ5KiLhHZ0pwS1dU7kyHe6WXVsQ74NTycaF+7H+y8Y3J+lH5bjaW8n/RQlNMXoVNjJkusWk7Tpzg7HpfdkfvUj+7+7tjcdM+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(71200400001)(478600001)(38070700009)(6512007)(6506007)(53546011)(2906002)(6916009)(316002)(54906003)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(86362001)(5660300002)(6486002)(41300700001)(44832011)(38100700002)(36756003)(122000001)(4001150100001)(2616005)(8936002)(4326008)(8676002)(83380400001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5pWDlwSjg1UU0xNlJublJjTlZMMjdUenZUdGh6Y3FLZW1kbkV4cndsdUFM?=
 =?utf-8?B?OUVpMC8rNFVTaWNOY1doTDJWVXNIS1p4K3B4ZHNDditiVG5oQmtSYzFTclJK?=
 =?utf-8?B?ZVpMUVFHQ1IwUms1dWY1cWd0SmRMemtFSXJvcGJnUnhhekZNZWdsNzJrTkFL?=
 =?utf-8?B?WHRIdzhxUGdkRjNjTGw3YjJpamoyeHdybGJ0emdrdXozb0pHMWQzajFHMXB4?=
 =?utf-8?B?OXU0d3oxbExBZHNYdjRwNktSTllkVUxVNzM2WmdwZXhkQVFCOTIzdDg3TnpD?=
 =?utf-8?B?MGdPMEZ0M2U3VnMrNE9yWEJFV1dYVWFHUUFFc3ZuNnlIcEl2RHl4YzkzdUdQ?=
 =?utf-8?B?NTZxZEFkYzlGSm5SVEtPM1U2b3JWMWc4UisxdVJ0Mnlnc3BjWS9WYlJ2SHcz?=
 =?utf-8?B?NmlQbEhDWCtMajJCaDRmTFRQVmRuS2lOamxkQTRwUnM1MFA2dmo0a09iRGcx?=
 =?utf-8?B?d3pCeVFJYTBMcEdYSUlFUS9ic0RzVU05aDgyZDNubmE1blIvRTZHU3JyakVU?=
 =?utf-8?B?d1h2anMvSmhPYlVuMUptU1ZkT01ZdWc5cmNmMVRacTRkNFBJeVpDaXNndTBU?=
 =?utf-8?B?eU1wb3FUYnlLRzEzamlFNWJSUGFjcmRnbUI3NlM4Y0IxcVZxenJldzNmT2lt?=
 =?utf-8?B?NjVaUmhmMDkwZmxxMk1JT0JlUFJUMlBkdGduYWJGRFB6VVdtZ2FINWNaTHBE?=
 =?utf-8?B?Q2hFQjA3MzRZTkQwYi8wWDJKWjZxUTNVckFFQ2VDUTQzOURQY0JVYjNSalRE?=
 =?utf-8?B?Q0h0NzhGQmZ2N3haRlFsNW9WMjM2UXMxM2t5c01WUDlnNnZVM2hQUnIzb09W?=
 =?utf-8?B?TENOUUM2dFpvTlVUUDZMdlNpSzdlSk9VazZzWGdjcWgzWmVld3kzbXhITXMz?=
 =?utf-8?B?dmJXYlJSR1RvT1NxeVovZThabnVnd3JpTjRvSGlPUGtCeHlKRUVicEdycXgx?=
 =?utf-8?B?amhPS1A4ZVMyNUZ2TTBKRmsvVU5FdVB3V1RvZTRUeEtWZXdCQzB1a2xXTFd6?=
 =?utf-8?B?blpFZFFxdGc5R2ZEUVNabVJwTnJBSFVjRTFWNlNsS0dlb2VTLzNFY20xNzk3?=
 =?utf-8?B?OVJEamM1WWtVR1dPN2xuNk5tUnlvYzFmbXQydlVjUys0djNONWJTTmtWRU9u?=
 =?utf-8?B?eWtaeTlpOXExWTRiZkVackZSekxrdDBCT1M0Q00zOFIyVXJyb1VMREpkdkpO?=
 =?utf-8?B?VVVnRFpiNUhIeHB2WHBLQ0ZSR0FrS3J2SXBBZVdFL04ybzd4ejk4bzNuUTMv?=
 =?utf-8?B?M1J1YVllckRiYmdDQUNDZENub1FLL1FOcmtCYm5YRnV0SXBQdVBqaHY4RzND?=
 =?utf-8?B?aW91dHRUcWRIcXB2bjg5UHJJS1AxZTM0aG9YMTRsWEFqdEhBclNwOUJBLzd4?=
 =?utf-8?B?RHNTNitVNjg5Mm9YeE14akloaHRDWlg3dCsxNzcweUZKbi9tNTFUWDE3OVZr?=
 =?utf-8?B?aUQ1bHVxeXc3TmZwK2piWjJOUnBLOXVZNVdHbEpHRnFYRmJ3MnVITmRoVHNW?=
 =?utf-8?B?K3RISU4zeFNqTTNUakpXWnE0cm5BZlNTaTJyK253Wms1S29IQkxSNnEzMEZJ?=
 =?utf-8?B?L0dDSHBwMEI1MjVNSVY4QXBqVHpJZkJzV3VnQm1scWxMQklzcEtnOU9Tc2tF?=
 =?utf-8?B?bTFLK0VodDhITytiQ3QySk5US2FoSk5WV21OMzhpMmlmNDhDMVR6MG9KRW1z?=
 =?utf-8?B?RVhrWHB5MmtLanVXM04wdzZPR2J1L05LM1ZrYndyRUxaZTIyZm45Mnoyd0V5?=
 =?utf-8?B?d0JpRlI4cXY0dGZJYjRZZmJoODR3MzI4MmhqL3FoR1ZVYjFZQjNma3hCU1Rt?=
 =?utf-8?B?STh5UmNQUkNwMjhneFZOWWRrMFp5Q1JoWEdKdC9uS0ZhWjlxYUh5OStRcVRv?=
 =?utf-8?B?WEVqbGQxWlpLZHFTaVZVSmpveUdqcjBMbytMZmtsUGVrdFNmNEU5L3BzR3Jy?=
 =?utf-8?B?dGdvRXNOR0R0Vmk2cXkrd3ZEbklPU1VaQ1FXZHNVdUxYelJ3QUhSRkdPSWMy?=
 =?utf-8?B?ZGdsbE1SWWVsR3R6ZFFobVg2ZEQ3aWJPTXkxNjY0VHY4MFBtN3RsSXJiTjl6?=
 =?utf-8?B?d0YydG02VWpkNG56VWcrRlEzUUxRTkQrRGdiSS9XTGF1NjdzZFBLV2htcWZW?=
 =?utf-8?B?ZFFlRkQ2TFM1SjNnK0FvTCt0Q3owZEhJUDVpK09xZGNiV3k5V25MUnA0Y3RU?=
 =?utf-8?Q?rJPbIuS6JdTHSATKR0fkAb4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a2dd2-26d1-4694-fadd-08dbe692d2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 10:57:27.8738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qjvDrkbA8PFpkY9N8w2QWR1tG6rJlwfd9x55xzIoOOoMOP/gTOGGMBiUNlDtAeicY/VHWAmBu3l1RgZmXyJmccRfO57X/mvUJK7xfbFGV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0125
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <DB1F7A13EBA0EC4594D869482F5E6E5C@CHEP278.PROD.OUTLOOK.COM>
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

SGkgVG9tDQoNCk9uIFRodSwgMjAyMy0xMS0wMiBhdCAwODowOSArMDEwMCwgTWFyY2VsIFppc3dp
bGVyIHdyb3RlOg0KPiBIaSBTdGVmYW5vDQo+IA0KPiBPbiBUaHUsIDIwMjMtMTAtMjYgYXQgMTA6
MzYgKzAyMDAsIFN0ZWZhbm8gQmFiaWMgd3JvdGU6DQo+ID4gT24gMjYuMTAuMjMgMTA6MjksIFJh
c211cyBWaWxsZW1vZXMgd3JvdGU6DQo+ID4gPiBPbiAyNi8xMC8yMDIzIDA5LjMyLCBNYXJjZWwg
Wmlzd2lsZXIgd3JvdGU6DQo+ID4gPiA+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBmaXhlcyBhIHJlZ3Jl
c3Npb24gaW4gdGhlIGVNTUMgZmFzdCBib290IG1vZGUgY2FzZSB3aGVyZSB0aGUgYnVmZmVyDQo+
ID4gPiA+IHdhcyBtaXNzaW5nIDQ2NCBieXRlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBjb2Rl
IGZpZ3VyZXMgb3V0IGhvdyBtYW55IGJ5dGVzIG11c3QgYXQgbGVhc3QgYmUgZmV0Y2hlZCB0byBo
b25vcg0KPiA+ID4gPiB0aGUgY3VycmVudCByZWFkLCByb3VuZHMgdGhhdCB1cCB0byB0aGUgc3Mt
PnBhZ2VzaXplIFt3aGljaCBpcyBhIG5vLW9wDQo+ID4gPiA+IGluIHRoZSBVU0IgZG93bmxvYWQg
Y2FzZSBiZWNhdXNlIHRoYXQgaGFzIC0+cGFnZXNpemU9PTFdLCBmZXRjaGVzIHRoYXQNCj4gPiA+
ID4gbWFueSBieXRlcywgYnV0IHRoZW4gcmVjb3JkZWQgdGhlIG9yaWdpbmFsIHVwcGVyIGJvdW5k
IGFzIHRoZSBuZXcgZW5kIG9mDQo+ID4gPiA+IHRoZSB2YWxpZCBkYXRhLiBIb3dldmVyLCB0aGlz
IGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlIHJvdW5kaW5nIHVwDQo+ID4gPiA+IHRvIHRo
ZSBzcy0+cGFnZXNpemUuIEZpeCB0aGlzIGJ5IHJlY29yZGluZyB0aGUgYWN0dWFsIGJ5dGVzIGRv
d25sb2FkZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogNGI0NDcyNDM4ZjVhICgiaW14OiBz
cGxfaW14X3JvbWFwaTogYXZvaWQgdHJpY2t5IHVzZSBvZiBzcGxfbG9hZF9zaW1wbGVfZml0KCkg
dG8gZ2V0IGZ1bGwgRklUDQo+ID4gPiA+IHNpemUiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIGFuZCBmaXhpbmcgdGhpcywgYW5kIHNv
cnJ5IGZvciB0aGUgdHJvdWJsZS4NCj4gPiA+IA0KPiA+ID4gQWNrZWQtYnk6IFJhc211cyBWaWxs
ZW1vZXMgPHJhc211cy52aWxsZW1vZXNAcHJldmFzLmRrPg0KPiA+ID4gDQo+ID4gDQo+ID4gQW5k
IHRoYW5rcyBmb3IgYWxsIHlvdXIgd29yayAtIEkgd2lsbCBhcHBseSB0aGlzIGZpeCBzb29uLg0K
PiANCj4gQW55IG5ld3Mgb24gYXBwbHlpbmcgdGhpcyBmaXg/IE5vdGUgdGhhdCBtYXN0ZXIgc3Rp
bGwgc3RheXMgYnJva2VuIGFzIG9mIHRvZGF5Lg0KDQpBbmQgdHdvIHdlZWtzIGxhdGVyIHN0aWxs
IGJyb2tlbiENCg0KQW55d2F5LCBJIGZlZWwgaS5NWCBtYWludGFpbmVyc2hpcCBzZWVtcyByYXRo
ZXIgc3RhbGxlZCBhdCB0aW1lcyBtb3N0IG9mIHRoZSB0aW1lLiBJIGRvbid0IHdhbnQgdG8gY3Jp
dGljaXNlDQphbnlib2R5IGtub3dpbmcgaG93IGJ1c3kgb3VyIHRyYWRlIGNhbiBnZXQuIEhvd2V2
ZXIsIGlmIGl0IGhlbHBzIHRoZSBjYXVzZSBUb3JhZGV4IHdvdWxkIGJlIHJlYWR5IHRvIHN0ZXAg
dXAuDQpMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4gVGhhbmtzIQ0KDQo+ID4gUmVnYXJkcywN
Cj4gPiBTdGVmYW5vDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

