Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3801DC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8222F80740;
	Wed, 15 Jan 2025 14:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBACA80214; Wed, 15 Jan 2025 07:56:49 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20702.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4877E80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 07:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDrluJhAxoT1g2YntUCrZ/ETbNfVollSmDu9+cUqUwrZMJ9Y7qYJTF4DlRUqZ89VuC+AEw8pSggRNyZmoxZuGkvYJQVAPAwh+lcRbQP4nbRLU23cWSJBhByDlUbFK41Lis4MOqUSMpXcid5wz/bhPkIP9oucpUIpSmn6uZLH86yL+Uj0UGCLHxzZuisyOEv3JHCc+CYc6GIwXux+HstTDyUHhHeG7ZME57WLhQ+F++iuEVsgRB3MuLBJrnkP3vFk8AApnwAjHb7OkrmyGDOQwYUzse3oU1daMeWT5I5meJiDbirRc3ciqQmZl6p0rEVuAh8i9YPAjeV0I8i1H2Sx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1JwRFhMaQAkLfd6RSl3DWSmpPXNp7pn8THfJps/hY0=;
 b=MfyO19m5gW3YkH1bwZWIwc3OeEczO42K4vsTS3dSLSYp+qbLCEhhugmQF1t9SzqwH+i7V6G3ZtmzQl+oTzGqxhmq4psRN29NC2OM96WFUSWdfQ/QTbkFawAzMBgXbFKGDcsR+uZqVefb9Gm2XJR6mfd/C2fO1/PZrzqArJvsCBw4sEtvqngK2h++H4or2SpbvIG+4Zo8Naj4VNuDJWXtBvSIWZNNOtUt2XrYiIxcs+b3avoyiMU4p9krm7C82PB+oPrB/nJ9xCf6pY7vYk9Ot3drR0sy/YV+3NhySPZwtKmnOCWTtwOy45lcsLXJLlKekqVmjGkpIDHRjVb65Yzmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 06:56:39 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 06:56:39 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Minda Chen <minda.chen@starfivetech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
Subject: RE: Lab failure on JH7110 (StarFive VisionFive 2)
Thread-Topic: Lab failure on JH7110 (StarFive VisionFive 2)
Thread-Index: AQHbYpNJyCJ0caAOoU2c12HQJOJf7rMXb3ng
Date: Wed, 15 Jan 2025 06:56:39 +0000
Message-ID: <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
In-Reply-To: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
x-ms-office365-filtering-correlation-id: 20039df0-6a54-4031-507e-08dd3531c2c7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7053199007|38070700018; 
x-microsoft-antispam-message-info: QLtjpXmQI+fXCnRWlY7IBXWRTjMnH2h6EoiXV1cDAA08sZ+pZaqqz50l+XDAzoKGfqsvW5ob5MINXwvXh8lM2POHKb552qEG+v0whrlKU811Naxp37P0k5cK/PIJQfES0Xb/TbY1uzWIjAeQkOeZJQkh8C0nwnkEgu8/FtHPAWB9BWIrd5RYo8HFVMoXcSXoLk7/FfxJc2F2/2RN8mPnUazHizE26DiJ4OgfEunJCjyhMdsmzp+tjVG2Ra7pZBCtd1IYcYTDspJuNb+YOjGrXm21U54cRkgHwI3hC61//+FhjqzYyxtK1TBolkFr/oQB7QhxEJuKoKOMY80E6iJ31DSiqjTBeXHgar2renWIxFfzFI/kYMq3g/vcgRtFB7VI61DTKs3nzbZl5bK17qKtWJu0GTjE0w0MORhlxnNK/DHT26xGwShIcp6CodcZtU7vXIjUDzPVnmZbJOKsuSvAAyPoSLNSUYw8fO9sBIEwcIjB0uBUFyCnEnEtwGuNW08X1/yYW7J9BOtSlGWcCET6fL1TQFWZ5dME9eMKt7L9vp82lsiFCwiidezXw0k9Q2vtNsbBwzlYS+GRA6XYxu00uJp2sMLPhWTkinaNI1F1/Ao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7053199007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUxxN1lzdFQ5MCtWc2ViV21TNThiVFhNTDJqQkpOWitaeVdFWXkzS1EzRmVk?=
 =?utf-8?B?aGVhb1ZFOUJacHNMWWwrV1phRGJwT2dFakRJTmZOTTRtdXJyVkU1cUx0TTRj?=
 =?utf-8?B?NVhlMFRsdldKLy84SUdWaW9NUTArQjlIdzdoRVJGdktiVDBORHZwRFluaWQ2?=
 =?utf-8?B?R1lsL2p1b1gyVHlNeEJYL0hmR0lHVG01QWRzL0Rmbm9IOVFkd3hGdyt2R1Zl?=
 =?utf-8?B?UXVvbGg2NXFCZjRndEZINW45aWUxT0dhaklwRHg0VnRIbnIrUnEvbzRLUVVK?=
 =?utf-8?B?WFBBYnoxMVRYYmdiTEc0L1V6QmhpZ2ozVDliUVNsSStaSExyRG4ydWpzNXRS?=
 =?utf-8?B?aVZlSXBCZ0NrTzNkYUE3VndpNGRNTytyL0JXeHpOZ1BkSVg4b24wbytxUE45?=
 =?utf-8?B?OVNvTnJwNlpWSEVEY1lXaUxhcFVKYnhadkRpN2ZQbE42aXNTNk9VZkdNeWZ4?=
 =?utf-8?B?THQzbGhaR3VIQ3p4TFFSaXpSemg3NzA0bDdWNFZWNHpVVVgyN1NiVE5LN0dV?=
 =?utf-8?B?VnJQVkU0NFROTEFweTJ6VUVRbldBREZ6VkpOVUVqVFpYNFpsamNLUjNaY3VT?=
 =?utf-8?B?MkNESG03V3lsZ0pDWVhoNTBBeUhPSzZOSkVyTVZMSExVV2taV3NxOEx6NkFw?=
 =?utf-8?B?MFE5K3ZhL0tOTjE1ZVZIRUhUcGhQSlhIOHR4ZmVyczhneHBiTzFSbkRwdmhJ?=
 =?utf-8?B?K0xHUkY2LzBUOGFncWdza2dWRXFDWWJkanFKVVRCYlpRblRjQUpnZ0d2MlE1?=
 =?utf-8?B?V0NrMkU0bnZoTnV5MWlZN3VkUXhHKzNwaUVkZHIwK1NjRjkvWTFncTZleUZ4?=
 =?utf-8?B?MFhvMXBaY1ZpTnBkTE53Y3dZRlVOWm1CeVU2aWszc3ZFR0xNUDI1ejhTcGRW?=
 =?utf-8?B?Q280a3JYODNmbzI5OUI2WFBaWFBRa2w3SU5xZERuN1h0QTRpZ2hkejU0Yjd2?=
 =?utf-8?B?cVVjMlRsbnNhYmYwUjhIOUZGZDZ3TWNHRTdoUUhqdDBSMFRZRnc2cnVJL0Jv?=
 =?utf-8?B?OHpjNGxOUzV0VUFXbXRMZ01zKzY5c1VPYk95VmJORVhrTlZTSGxVRjgxeFBJ?=
 =?utf-8?B?WmViazIxYWNnY01YTDI1WE0yTW52VFNQU2VJajI4RWRCZmE1Y1I3b0haMEVX?=
 =?utf-8?B?SWhtVnkycjJ5eGxwdlBKczVtaDJqMGNuOGQzaktjQmN4d2cyVWVrODF3RFNL?=
 =?utf-8?B?VkRFQ21sMVExTmduWm1Lcm5zWEJIRTJ6OFhTWlVUNEVVeHkxNlZpMTFRSC90?=
 =?utf-8?B?QnV6VWNBempISU5RUno4ODlUZVV3d01tcmF2Mm9tSmxWSFRzeDUzd1FsQUQr?=
 =?utf-8?B?Vyt2TEh5bHN3SUZVWWVyRXV3WjhCSnFpTVpmZDdTNWlCWkwrUnFpdldtSjhr?=
 =?utf-8?B?SDUyZCt0ZVNqT2JGL25hMkJtTzd5eVdXd2orUUNERjJhaTloRUYrM1ZnOS81?=
 =?utf-8?B?ZDgxeWIrZmNIbGlFaXRQbHNXSnJhUkNncWZrZU1lNWNBRGhiejN1T0QzNE9R?=
 =?utf-8?B?Q0xTYzk4dThaSWdaN20ybGJjVm1NMGZUWUFCbVp6RnJ3QStIalAyeGhaRElu?=
 =?utf-8?B?bVUrNXdhd29ncVpFQVk5QkQ0QjdPRmpTQ1FyTTRER293ZnZHYWgwMEhIR3hn?=
 =?utf-8?B?L0NyUDZoSlpUZ0pNSXZnZTU3L0E4d0lLUk1tUk4xeTdXK2VyaDFLR0kwZU5C?=
 =?utf-8?B?dVBWUTB5NDE0aGJjRlZGc2ErR3VIbE1ad0RhV1lIYnpxS1FMTEhYSzNhMzVq?=
 =?utf-8?B?K25tU1k2UW5qVHNzZHFxQUpHNjNkYXVkZTIwZ29vSmdrMzIvQkJSMG85Vmoz?=
 =?utf-8?B?azFSZkVrUkg3N2pTZy94K0hZWkFPejduYTVFbThsbmlmd1VaWklvTmpOeTVV?=
 =?utf-8?B?R09LbHpDcEtrRFVmKzhERWFsTVJDZlFUS1loUThmWGpWbFBRTnlLa1MrV1Qv?=
 =?utf-8?B?T2oydlBKQmwyazhnOC9OMzRoaGxJd3kvenowUko1RUV2Qy9HRmVsMW8zdElL?=
 =?utf-8?B?M2lSZHVVQzkvd3FkS1QvNVRMd04xQmc1RFRUNy9NSys1amhJc1Q1dVdCUHBD?=
 =?utf-8?B?TUhpL2xWL2NBeTF2VnBtbmlFYzIyYkMvUHQ4dGh1WFpVMWVncXlMczR1NVdD?=
 =?utf-8?Q?3NFOIVa1ykutSJnWPVb91R572?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 20039df0-6a54-4031-507e-08dd3531c2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 06:56:39.3603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3vNACDCth0OC3xh5+Ht7qDHFqC6zXdcqd+xGlQje9EdxuPUmvckxYQfOAJYupaT8OGo15ospsXoDVh8AtU6Rj8zM2k6iCv3qKhrHUhcZ+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Wed, 15 Jan 2025 14:37:07 +0100
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

PiBPbiAwOS4wMS4yNSAyMDozNywgU2ltb24gR2xhc3Mgd3JvdGU6DQo+IEhpLA0KPiANCj4gSSBh
bSBzZWVpbmcgYSBsYWIgZmFpbHVyZSBvbiB0aGlzIGJvYXJkIHdpdGggdGhlIHRlc3RfZG1fY29t
cGF0IHRlc3RbMV06DQo+IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSBG
QUlMVVJFUw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA1NTlfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXyB0ZXN0X2RtX2NvbXBhdA0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiA1NjB0ZXN0L3B5L3Rlc3RzL3Rlc3RfZG0ucHk6MjA6
IGluIHRlc3RfZG1fY29tcGF0DQo+IDU2MSBhc3NlcnQgbm90IGJhZF9kcml2ZXJzDQo+IDU2MkUg
QXNzZXJ0aW9uRXJyb3I6IGFzc2VydCBub3QgeydzdGFyZml2ZV9ncGlvJ30NCj4gDQo+IFdvdWxk
IHlvdSBoYXZlIHRpbWUgdG8gdGFrZSBhIGxvb2ssIHBsZWFzZT8gQSBwYXRjaCB0byBmaXggYSBz
aW1pbGFyIHByb2JsZW0NCj4gb24gYW5vdGhlciBib2FyZCBpcyBbMl0uDQo+IA0KPiBSZWdhcmRz
LA0KPiBTaW1vbg0KPiANCj4gWzFdIGh0dHBzOi8vY2kudS1ib290Lm9yZy91LWJvb3QvdS1ib290
Ly0vam9icy8xNDM5NA0KPiBbMl0NCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L3Vib290L3BhdGNoLzIwMjQwNjExMjAwMTU2LjIyNDU1Mg0KPiA1LTE5LXNqZ0BjaHJvbWl1
bS5vcmcvDQoNCkkgd2lsbCB0YWtlIGEgbG9vay4gVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpI
YWwNCg==
