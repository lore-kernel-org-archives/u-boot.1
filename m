Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CB3C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 08:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E355876B6;
	Fri,  1 Dec 2023 09:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="GSbjCd0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD45876DE; Fri,  1 Dec 2023 09:43:59 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141FE8760A
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 09:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1701420234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riIdBNFcuxkhZe0NIBZfwo+aAR9Cfy299DG9xrJ4dbI=;
 b=GSbjCd0XQJVRfq3jiECVhUS0inlllf1+Kk4UtUHGniHL73AZX9XMiMZK6AzaOX011Eou4K
 c0375gvNUHq/6Ql6kTJcL5iNwxGx7Fr9MOG9r2TPLElGDb3SlV/2zcqOjiwXbEkMMZXEO/
 MtRs8b3rIMqnz5mBiZJ8MZlI4n9f740=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-BfdSs1UePn6si-iTU1WPRg-1; Fri, 01 Dec 2023 09:43:52 +0100
X-MC-Unique: BfdSs1UePn6si-iTU1WPRg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Fri, 1 Dec 2023 08:43:50 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 08:43:50 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "nm@ti.com"
 <nm@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "bb@ti.com" <bb@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>
Subject: Re: [PATCH v5 09/17] board: ti: j784s4: Add board support for J784S4
 EVM
Thread-Topic: [PATCH v5 09/17] board: ti: j784s4: Add board support for J784S4
 EVM
Thread-Index: AQHaI4R91s1YHnkmmU2kZgAn8krLWLCUHiAA
Date: Fri, 1 Dec 2023 08:43:50 +0000
Message-ID: <bfec8d32af29525118437eeed32ac9e2c8cbc554.camel@toradex.com>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-10-a-nandan@ti.com>
In-Reply-To: <20231130115552.3580995-10-a-nandan@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0083:EE_
x-ms-office365-filtering-correlation-id: 7a5e810e-acbb-439e-7f9d-08dbf249a429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: nTT89mQ1EzNJZ+pZxUSrPxmNa0rUU7ZJbiu7FIWIslJHsWAe6ddmepZQZZze/g4j5wqgrlf/9He/GGlETgiaoxaD17uAiQWCJhIbIA/1Qx6LAyGQSH+XZqjRW03/us/D6mG2mjqAXjO8E4O/htb/pnKhDHAGdAzb8qIlh70mCIHATLXEMiMourQ5dcRnXH7TzHtphLLmm7W3bm9T3lDKIAaqzWB7iS3YpZPKlJMM8LOE5rzbXD8cru0rjdZ8qhhNnlax0tNHWMjjrYNxwIaNn7LiDhSRpavGUTH6g9Y7V38QixD4oGOIWkGhje4qQA1SfvWFiNxXXR6k0t9mp1DwDTSpLVGqTFySyKc3Zz8zkzESRIUMRgLU9HseOihkDl/8P7rTxrJfAyuapprGpUPq8PYzyDfYSNg+9UOiORrUlUN3MKG8NIyX+iGknBCwuwZE0V6MGf8b3XqpZ7K5PS6AAi3cELAXkneBPmSXwWzGBtrlBREpjswizcyM6pNBh5SdGUGA1OODXzZ+k61cx/mJx2t6hlWs9iNWHC+2ewyvfHfP8Z+OkbDy1pQuDrrxa53kEwNWfdw2LRupCX+DTcQGgId4KfpZTLVztklccGZ/1fpr5s4Ukh0/40fKIgSVUCre
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(26005)(38100700002)(2616005)(8936002)(8676002)(86362001)(6506007)(6512007)(122000001)(6486002)(966005)(76116006)(316002)(66476007)(66556008)(110136005)(71200400001)(66946007)(66446008)(64756008)(478600001)(2906002)(38070700009)(41300700001)(921008)(36756003)(44832011)(4001150100001)(5660300002)(7416002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjR6MlljUmIwM3dEajRva1l5ZXdCbTJpdlg4UGo1WE5pNjdxbUx3RWN3NFZ1?=
 =?utf-8?B?MElVY2MyQlhsSlBKUGwyTHE3NlJ4b1pHdG5vdldTRkdxeVNUcy9sSlFsK3Bh?=
 =?utf-8?B?LzJoMkJxY2Y5Q0xIZ1g1am9DbFBydWwyeHJTQmtvU1o3ZkNtQXFEWFhNZGVx?=
 =?utf-8?B?c1dMNEF4TG9UcXF0MjBwUEpTTC9wTjEzekpiUzdiVE9kc1YvbTdXOGNRTjl0?=
 =?utf-8?B?VzRlRzBacWdHdUVNUEZPT0hheE4xUDhvaGd5UVRwMFI4bjhjcmtSN01IUVRm?=
 =?utf-8?B?alZWMEcva2VpZ21pem1PeHdleXpRVlQwa2E0Mld2ZmtrOTJ0Nmx1QUN3N1J2?=
 =?utf-8?B?d3NlMERnMXl6UDErTzRITnl6Y1dBRHRuTEs2czhEOHNUNWU2NHQ5Z1ZwSC81?=
 =?utf-8?B?Z3VIS2p5eGhEWHBYUjI2VmxLQ2tnc0lOWk5Ldk56TUtSMXlmZVVWY3ozaVBx?=
 =?utf-8?B?dkJFOHFST0RtZ0RWQk54L2NVWFRCaFM0OHo3R216ZTdUT1I0dTJQRGNNeFBs?=
 =?utf-8?B?NGFvUHBOUEFsQmNwNG1ZN0V3MkkxN0cvclBraXprSDZuMEVOVW9oREoyVU5Z?=
 =?utf-8?B?d05QYzZhSGhqblI4dlVGdTFaTnBSSW9DSHBWY1c4UWdibmV1ZFZ4ckp6dWdO?=
 =?utf-8?B?bFdiZGQ4UnlMdTBMSi9mUW5MQXNJWXptVE5Bd0ZUSnFUSERwSnlMdUJjcGJL?=
 =?utf-8?B?QzgwN0pzUmZQSHNDTnJ6UU50c29VS2JJN0I2V0tIUEtnOFpMWjRLSkVkZ3px?=
 =?utf-8?B?TVFoRHBJbWRLOEFVTUdZUzRwaDRrMFRvQ1IxZEZVSXZDMWVTcmIrRmYrOGVq?=
 =?utf-8?B?UjlrZG5GYkczbTJaTUQ3N3BSUTk2bWladkk0eGRyT2ErQXB0dXZ3b2drYmIx?=
 =?utf-8?B?azgrdGp5akhWTnFqZHBINjE4S3RKQ2Z1NWNGSG93ejhKdDBUNVUvYW4ydGM0?=
 =?utf-8?B?L2dZbHdwTHBCa2piYStPZktMSUdJK2VKQ2laZmIzelpRZ1FsTGk4Mk1NMHE0?=
 =?utf-8?B?OVNRN0lSZmlyRmVRZ3IrTm80T2VhUk9TRGRrZWlWWW8zd3hKcHhpK0UwaklG?=
 =?utf-8?B?VldhcmJMcElibGNaODJXM2hBOGpaSVJXbFZoSGUwNmh3OWxaNEhraURxNllW?=
 =?utf-8?B?MU93eHJZZzhpOE5pSjVyZVRUZWxQUEQ1NXFSWis2Q2pYdGRFWHdBUVNNL1Fv?=
 =?utf-8?B?cXJSSjYzby9ac2RRTU5teTZQTW4vTnNjTHlyL1VLbUw4aURHUGRSTFdDcXAw?=
 =?utf-8?B?bUVRNmlVdmg4aVQ1RDlrT3NUZy9Iay82eDNmaS9VTlVtbDZmUmZKMFBWRGg4?=
 =?utf-8?B?cElCWnVOQjYwTUdjTmlwbnZaQjNaVlJPOWl1YmUvOXQ0cWlzV1QwM3A3bEFG?=
 =?utf-8?B?NjNyUUtzNlhCUFluWTRUYVIrRkUrQkZnWjZOVnphTzNpRW5teWUyaWpybTBV?=
 =?utf-8?B?MnZkYmxkVEZvdWdzditmVnkrVTN0Sk90eFVKc1dJT2VOV1FkYVJUN3EveStB?=
 =?utf-8?B?KzVUNzRzRGF0ME5uUkxjcEJBVVFiM1doN1RoUGk3ak5hQ0tCdnI2cDFSN0J2?=
 =?utf-8?B?SmRSU0gyMlNwVFEyQkFacGtJNmI1SnovZEhmaTF6ZmplVXlZcCtUejJSc3VQ?=
 =?utf-8?B?SGZWdVF1RGlrNUh1cnp2SDMraHFLSmJVUHpQbXEwTTJTZ2tvMTU0VGswQnBB?=
 =?utf-8?B?YlN3cTkrYk5GN3lUUmxpMjA4RExhQmFuLzZoL1JMeEgxSkJGSG5GV1VJMDFS?=
 =?utf-8?B?Smt2dmlTVEQxa0NlZ3FidGJpWkJFUFNtWTMrc1FXL2J0WnB3K1lYN0xLVUtU?=
 =?utf-8?B?ZmUrZDZvVDF6ZVdtV0dlbzhQYldITzZmV1FRdHF3VVVTOUYvVG81YTMzL2d3?=
 =?utf-8?B?MERvRmxpK0JBaVhXS0dTUU1abS8ySzAvOFdYODd2ZXFna3BzL2piMmJMKzdF?=
 =?utf-8?B?RUhwbElFVThJajczNjFRL2xhYzBwYWdFd0RUY2Q4VHhnRTZMNnU1Q2ZnN1JO?=
 =?utf-8?B?YjdGd0lDdDFtRGtRT0Z6Mmt5ekpLaEJjRlRYSkFpZ2xPbCtXdXFscCtkb2E1?=
 =?utf-8?B?K25qWENJTGNZamdzOTFsREZOMWFDbTg4SlM1ZEZWMUpJL0ZNS0Y3cFNmRlVl?=
 =?utf-8?B?RlJFaG9UdW0rcS9ocm5YUTRocC90L0NjWTBYTk92THdRTGRodVJNMWpWb01G?=
 =?utf-8?B?dlE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5e810e-acbb-439e-7f9d-08dbf249a429
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 08:43:50.3658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi3EN1tqX+7lKIac4JfoMkSRLrEYJ+CRPKBi6kW7EVKpnexEcgQ4LAN+S73iLI4LYsveTKepu2vFwSh3QsaztbonR0rNaI50G631wTKw+5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0083
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <9651326099E9C346B76354928FDFE061@CHEP278.PROD.OUTLOOK.COM>
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

SGkgQXB1cnZhIA0KDQpUaGFua3MgZm9yIHRoZSB1cGRhdGUsIGhvd2V2ZXIsIGl0IGRvZXMgbm90
IHNlZW0gdG8gY29tcGlsZS4gU2VlIGJlbG93Li4uDQoNCk9uIFRodSwgMjAyMy0xMS0zMCBhdCAx
NzoyNSArMDUzMCwgQXB1cnZhIE5hbmRhbiB3cm90ZToNCj4gQWRkIGJvYXJkIGZpbGVzIGZvciBK
Nzg0UzQgRVZNLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFyaSBOYWdhbGxhIDxobmFnYWxsYUB0
aS5jb20+DQo+IFsgYWRkIGVudiBhbmQgYm9hcmQgc3BlY2lmaWMgeWFtbCBmaWxlcyBmb3IgYmlu
bWFuIF0NCj4gU2lnbmVkLW9mZi1ieTogTmVoYSBNYWxjb20gRnJhbmNpcyA8bi1mcmFuY2lzQHRp
LmNvbT4NCj4gWyBjbGVhbmVkIHVwIHRoZSBlbnYgZmlsZXMgXQ0KPiBTaWduZWQtb2ZmLWJ5OiBN
YW5vcml0IENoYXdkaHJ5IDxtLWNoYXdkaHJ5QHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFz
bmF2aXMgU2FiaXlhIDxzYWJpeWEuZEB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFwdXJ2YSBO
YW5kYW4gPGEtbmFuZGFuQHRpLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC9hcm0vbWFjaC1rMy9LY29u
ZmlnwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoGFyY2gvYXJtL21hY2gtazMvajc4NHM0L0tj
b25maWcgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBib2FyZC90aS9q
Nzg0czQvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrKysNCj4gwqBib2FyZC90aS9q
Nzg0czQvZXZtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiDCoGluY2x1ZGUvY29uZmlncy9qNzg0czRfZXZtLmjCoMKgwqAgfCAy
MCArKysrKysrKysrKysrKysrKw0KPiDCoDUgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMo
KykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1rMy9qNzg0czQvS2NvbmZp
Zw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC90aS9qNzg0czQvTWFrZWZpbGUNCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgYm9hcmQvdGkvajc4NHM0L2V2bS5jDQo+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvY29uZmlncy9qNzg0czRfZXZtLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLWszL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWszL0tjb25maWcNCj4gaW5k
ZXggMTUwZDBiZmExNC4uNDQ1YjQ5ZTI0NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1r
My9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtazMvS2NvbmZpZw0KPiBAQCAtMTU3LDUg
KzE1Nyw2IEBAIHNvdXJjZSAiYXJjaC9hcm0vbWFjaC1rMy9hbTYyeC9LY29uZmlnIg0KPiDCoHNv
dXJjZSAiYXJjaC9hcm0vbWFjaC1rMy9hbTYyYXgvS2NvbmZpZyINCj4gwqBzb3VyY2UgImFyY2gv
YXJtL21hY2gtazMvajcyMWUvS2NvbmZpZyINCj4gwqBzb3VyY2UgImFyY2gvYXJtL21hY2gtazMv
ajcyMXMyL0tjb25maWciDQo+ICtzb3VyY2UgImFyY2gvYXJtL21hY2gtazMvajc4NHM0L0tjb25m
aWciDQo+IMKgDQo+IMKgZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtazMvajc4
NHM0L0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWszL2o3ODRzNC9LY29uZmlnDQo+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjAzZDNmOTEzNzENCj4gLS0tIC9kZXYv
bnVsbA0KPiArKysgYi9hcmNoL2FybS9tYWNoLWszL2o3ODRzNC9LY29uZmlnDQo+IEBAIC0wLDAg
KzEsMzUgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIN
Cj4gKyMNCj4gKyMgQ29weXJpZ2h0IChDKSAyMDIzIFRleGFzIEluc3RydW1lbnRzIEluY29ycG9y
YXRlZCAtIGh0dHBzOi8vd3d3LnRpLmNvbS8NCj4gKyMJSGFyaSBOYWdhbGxhIDxobmFnYWxsYUB0
aS5jb20+DQo+ICsNCj4gK2lmIFNPQ19LM19KNzg0UzQNCj4gKw0KPiArY2hvaWNlDQo+ICsJcHJv
bXB0ICJLMyBKNzg0UzQgYm9hcmQiDQo+ICsJb3B0aW9uYWwNCj4gKw0KPiArY29uZmlnIFRBUkdF
VF9KNzg0UzRfQTcyX0VWTQ0KPiArCWJvb2wgIlRJIEszIGJhc2VkIEo3ODRTNCBFVk0gcnVubmlu
ZyBvbiBBNzIiDQo+ICsJc2VsZWN0IEFSTTY0DQo+ICsJc2VsZWN0IEJPQVJEX0xBVEVfSU5JVA0K
PiArCXNlbGVjdCBTWVNfRElTQUJMRV9EQ0FDSEVfT1BTDQo+ICsJc2VsZWN0IEJJTk1BTg0KPiAr
DQo+ICtjb25maWcgVEFSR0VUX0o3ODRTNF9SNV9FVk0NCj4gKwlib29sICJUSSBLMyBiYXNlZCBK
Nzg0UzQgRVZNIHJ1bm5pbmcgb24gUjUiDQo+ICsJc2VsZWN0IENQVV9WN1INCj4gKwlzZWxlY3Qg
U1lTX1RIVU1CX0JVSUxEDQo+ICsJc2VsZWN0IEszX0xPQURfU1lTRlcNCj4gKwlzZWxlY3QgUkFN
DQo+ICsJc2VsZWN0IFNQTF9SQU0NCj4gKwlzZWxlY3QgSzNfRERSU1MNCj4gKwlzZWxlY3QgQklO
TUFODQo+ICsJaW1wbHkgU1lTX0szX1NQTF9BVEYNCj4gKw0KPiArZW5kY2hvaWNlDQo+ICsNCj4g
K3NvdXJjZSAiYm9hcmQvdGkvajc4NHM0L0tjb25maWciDQoNCldoZXJlIGV4YWN0bHkgd291bGQg
dGhhdCBvbmUgY29tZSBmcm9tPw0KDQrirKJbemltQHRvb2xib3ggdS1ib290LmdpdF0kIG1ha2Ug
ajc4NHM0X2V2bV9yNV9kZWZjb25maWcNCiAgSE9TVENDICBzY3JpcHRzL2Jhc2ljL2ZpeGRlcA0K
ICBIT1NUQ0MgIHNjcmlwdHMva2NvbmZpZy9jb25mLm8NCiAgWUFDQyAgICBzY3JpcHRzL2tjb25m
aWcvemNvbmYudGFiLmMNCiAgTEVYICAgICBzY3JpcHRzL2tjb25maWcvemNvbmYubGV4LmMNCiAg
SE9TVENDICBzY3JpcHRzL2tjb25maWcvemNvbmYudGFiLm8NCiAgSE9TVExEICBzY3JpcHRzL2tj
b25maWcvY29uZg0KYXJjaC9hcm0vbWFjaC1rMy9qNzg0czQvS2NvbmZpZzozMjogY2FuJ3Qgb3Bl
biBmaWxlICJib2FyZC90aS9qNzg0czQvS2NvbmZpZyINCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9r
Y29uZmlnL01ha2VmaWxlOjk2OiBqNzg0czRfZXZtX3I1X2RlZmNvbmZpZ10gRXJyb3IgMQ0KbWFr
ZTogKioqIFtNYWtlZmlsZTo1ODY6IGo3ODRzNF9ldm1fcjVfZGVmY29uZmlnXSBFcnJvciAyDQoN
Cj4gKw0KPiArZW5kaWYNCj4gKw0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvdGkvajc4NHM0L01ha2Vm
aWxlIGIvYm9hcmQvdGkvajc4NHM0L01ha2VmaWxlDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAwMDAuLjNmYzcwZWI4ZmINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9i
b2FyZC90aS9qNzg0czQvTWFrZWZpbGUNCj4gQEAgLTAsMCArMSw3IEBADQo+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsjDQo+ICsjIENvcHlyaWdodCAo
QykgMjAyMyBUZXhhcyBJbnN0cnVtZW50cyBJbmNvcnBvcmF0ZWQgLSBodHRwczovL3d3dy50aS5j
b20vDQo+ICsjCUhhcmkgTmFnYWxsYSA8aG5hZ2FsbGFAdGkuY29tPg0KPiArIw0KPiArDQo+ICtv
YmoteSArPSBldm0ubw0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvdGkvajc4NHM0L2V2bS5jIGIvYm9h
cmQvdGkvajc4NHM0L2V2bS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAuLjQ4NTdjOWQyZjYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9ib2FyZC90aS9qNzg0
czQvZXZtLmMNCj4gQEAgLTAsMCArMSwzOCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKy8qDQo+ICsgKiBCb2FyZCBzcGVjaWZpYyBpbml0aWFs
aXphdGlvbiBmb3IgSjc4NFM0IEVWTQ0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBU
ZXhhcyBJbnN0cnVtZW50cyBJbmNvcnBvcmF0ZWQgLSBodHRwczovL3d3dy50aS5jb20vDQo+ICsg
KglIYXJpIE5hZ2FsbGEgPGhuYWdhbGxhQHRpLmNvbT4NCj4gKyAqDQo+ICsgKi8NCj4gKw0KPiAr
I2luY2x1ZGUgPGltYWdlLmg+DQo+ICsjaW5jbHVkZSA8aW5pdC5oPg0KPiArI2luY2x1ZGUgPHNw
bC5oPg0KPiArDQo+ICtERUNMQVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4gKw0KPiAraW50IGJvYXJk
X2luaXQodm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAraW50IGRyYW1f
aW5pdCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBmZHRkZWNfc2V0dXBfbWVtX3NpemVfYmFzZSgp
Ow0KPiArfQ0KPiArDQo+ICtpbnQgZHJhbV9pbml0X2JhbmtzaXplKHZvaWQpDQo+ICt7DQo+ICsJ
cmV0dXJuIGZkdGRlY19zZXR1cF9tZW1vcnlfYmFua3NpemUoKTsNCj4gK30NCj4gKw0KPiAraW50
IGJvYXJkX2xhdGVfaW5pdCh2b2lkKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICt2b2lkIHNwbF9ib2FyZF9pbml0KHZvaWQpDQo+ICt7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2NvbmZpZ3Mvajc4NHM0X2V2bS5oIGIvaW5jbHVkZS9jb25maWdzL2o3ODRzNF9ldm0u
aA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4xYjc4MDEzNGNh
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9jb25maWdzL2o3ODRzNF9ldm0uaA0K
PiBAQCAtMCwwICsxLDIwIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlciAqLw0KPiArLyoNCj4gKyAqIENvbmZpZ3VyYXRpb24gaGVhZGVyIGZpbGUgZm9y
IEszIEo3ODRTNCBFVk0NCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgVGV4YXMgSW5z
dHJ1bWVudHMgSW5jb3Jwb3JhdGVkIC0gaHR0cHM6Ly93d3cudGkuY29tLw0KPiArICoJSGFyaSBO
YWdhbGxhIDxobmFnYWxsYUB0aS5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfX0NPTkZJ
R19KNzg0UzRfRVZNX0gNCj4gKyNkZWZpbmUgX19DT05GSUdfSjc4NFM0X0VWTV9IDQo+ICsNCj4g
KyNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiArDQo+ICsvKiBERFIgQ29uZmlndXJhdGlvbiAq
Lw0KPiArI2RlZmluZSBDRkdfU1lTX1NEUkFNX0JBU0UxCQkweDg4MDAwMDAwMA0KPiArDQo+ICsv
KiBOb3cgZm9yIHRoZSByZW1haW5pbmcgY29tbW9uIGRlZmluZXMgKi8NCj4gKyNpbmNsdWRlIDxj
b25maWdzL3RpX2FybXY3X2NvbW1vbi5oPg0KPiArDQo+ICsjZW5kaWYgLyogX19DT05GSUdfSjc4
NFM0X0VWTV9IICovDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

