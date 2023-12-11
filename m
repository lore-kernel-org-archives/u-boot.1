Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F5BC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 14:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1DB87619;
	Mon, 11 Dec 2023 15:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="ZrB5N1kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D76E87073; Mon, 11 Dec 2023 15:49:28 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662F7876CC
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1702306164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR1mhgF2TLH45uTqy7uQKyUP/HzzAnKcX5AeKdnUfCA=;
 b=ZrB5N1kq6oMGswWvoMEsRmIedJfhXyoF7eBi7EyXfVNS5D78vUgbP7yWjfs6yBI1QaI8rC
 H2v0RZFujMJaLnX9NFSM6GzfE+PleWJ6pZ6DqFT6exYiXt8hKJi0+0nSZLPe7x6eBpwCJe
 1GTZEMGbqNwGf96hgphGeTq2hWRtHWE=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-77-oHR9AeY1Mzy2j6nxQvKScw-2; Mon, 11 Dec 2023 15:49:21 +0100
X-MC-Unique: oHR9AeY1Mzy2j6nxQvKScw-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB0988.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:61::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 14:49:18 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:49:18 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] configs: verdin-am62: Disable SPL FIT Overlay
Thread-Topic: [PATCH v1] configs: verdin-am62: Disable SPL FIT Overlay
Thread-Index: AQHaLDhQSoTVcffn9UK1D3+awJHwdbCkKf2A
Date: Mon, 11 Dec 2023 14:49:18 +0000
Message-ID: <8eb87f6e1f9a32958339086f7dbe5efdcc0fac59.camel@toradex.com>
References: <20231211134520.162773-1-francesco@dolcini.it>
In-Reply-To: <20231211134520.162773-1-francesco@dolcini.it>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB0988:EE_
x-ms-office365-filtering-correlation-id: 7669a847-d97d-4732-0bbb-08dbfa585a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 4jH/426mx7Vlq1Xb4wSeinohJnaHzW2SCSSnHdIv/LkOZleslNFjA2I9pNx7e5IbrG4aAvcQLv+XMaHW6WodMXwqVWyu37INIbJolEYxsfr/pZTVJNyricF7Go6u3RUG8hPj0AAWKXJs5oGo+pUJJuy4sE8bfVTAb3UwQ5YxDvGfZxXsIDsn2c2qCOFThWvMppz+URdvryVq1yWIvpcH3vz7kP6IDSO83vAyVt1ESds/YVH7BRj1wLEkQaWImov1V0WbuUdtAwx3POtjcSSGMf0tu2FazJ/gR5jc32AnSBe+xbPduynxjeZhPCrBkh6alQ2T+OvOIQCO9V1LooJefSM2DI9Zt60WEOzGyv2fT3J/IMgOG6AZiioD1ldL/ygk9UuppCP2weq/QkB/FhHJXx6FcBpdIaelC4GKVUn8IYRSl7D+xtsSFHMHFTku2jxwBiOGj0pM/YLUTARr5rPN2wZo+QLVChISbfUmDcLCKkl6wc/xtmSbrvJKGhGKtmpf7zWjv5qxUpCQTJHJNW8GdTgWLYvZ+cE505nY16yTvFGiSPe0FhLx5ZWE0SiV2+rzsz+/wJDk4nY3uUf/wKHhClZ2CH3O3r/oG5pJ2gscjVYnxwt9lPvxm+zmmzH8VULs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39850400004)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(107886003)(2616005)(122000001)(66556008)(66446008)(36756003)(38100700002)(38070700009)(86362001)(83380400001)(44832011)(5660300002)(6512007)(6506007)(71200400001)(8936002)(76116006)(8676002)(6486002)(66946007)(54906003)(66476007)(316002)(6916009)(64756008)(2906002)(4326008)(4001150100001)(41300700001)(478600001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFlHcTVTOUNua09kb2lkcld3T2RIRmZjZ1YzOFZvNlFVb2FEQWZpQVN1WjZ5?=
 =?utf-8?B?RnBDNDJRR0hsdVFPeXRYNUlCRnQ0UUFnOUJES0VVcm9qQjVNRjduRzROdWhh?=
 =?utf-8?B?WXJYVFI5Q1BwV1lnVk92cjcxZzNnZXJNYy9CMmlsWTFIRFRPOU5EckJRZ3A5?=
 =?utf-8?B?TmR3a21WVDhYbmF6NjUwOVZDU0tpL3NJeC9ucGxVMSs1YURvMW8xTm9aUkRr?=
 =?utf-8?B?dHQ2RWwrNFp0WFZjUUhQSE1FQzd2aXRVeDdoQVBPbEVuUVhKOWoyRkJlU1N5?=
 =?utf-8?B?a3hMU2t4NmJGNFdYN3A2aVdvM0N4a2FnZDR5QWZrUy8vUHkwZStxaS9VS0NP?=
 =?utf-8?B?b3BZcXZxRktlTzc5N3AySy9ZUHhITHBiOGNhVnU2U1JHNjV1b3drQVBmdEll?=
 =?utf-8?B?dVJXNk9zT2ZYOTdrTGpkcWpiYkQ0ZStuWnlQUmJ4anNKb3hFbWlmekRnZTZL?=
 =?utf-8?B?K2U5QldYYkxJL0s2QTRiVzNGTXdYRHFHRDlYTUE4dVZOZkZ5and3WVNBLzNV?=
 =?utf-8?B?eGUxSER1ZHdqcjJzR2M2RnIyWTlCZG1RWlNldHBWckZWd1FBcG5KblVJV3hW?=
 =?utf-8?B?WUdiWWRuWjRPZXNtSHJxaWMzLzlYQ0dIRTYyS0pqWitkTUZkRE5IOUZHbE45?=
 =?utf-8?B?ZFRyczJhZmFaeXYyTnZzajl3cnpwc2Z3aEVKQXRHbUxVdWluTWtSdUdESzAz?=
 =?utf-8?B?Mll0Y2FKQ21DcVBSb1NJVEFUamRpSkJwd09WQ2VEbW1XTnZFVklFWGFxVkRW?=
 =?utf-8?B?OW1NMWYvUnAxeVFFZGdqeFdKL0lwenB0N1FjSFhZOG9leHhsMDJmL2taNUxG?=
 =?utf-8?B?TUNVREhCa2czdFVnQnlkWC9IdDdOdXZrL3MvU1FQMGRHODVCNnJhY3Q2MmRS?=
 =?utf-8?B?MW92OUpOUHJzakcvalpSVm44emtudWlKUSt5QitXVVZJc0dQQWJieFRoSEZH?=
 =?utf-8?B?OGVlUXJkNEtQOStMNzBodkFKUEgxc0pCSDVMTTJCaFgyNmxKWUs0NkkvTE15?=
 =?utf-8?B?T1Z2MkUzT2hVNVhPNHJ0RkdYRnZPQ2hXdHNQcXR1L3dNUGs1Ymk0anZIMFNz?=
 =?utf-8?B?Zjd1dlhCVlJ2ZXkzQ1h4VnRwTk9vaTRhbmFVcENYVGE0ZTJ4SVdNTnhaS0dM?=
 =?utf-8?B?Y1FhWCs5OVkvQWtxN2ZWUzM2TzdReGJqY1VHVjFBMEQybTlIdTJZTFFiMms5?=
 =?utf-8?B?dEloOGUvOUdxTFRJUHE4cEZIc3VwcDNBQVFoZ3RYU2d6RWJNSENMMGNZY1lo?=
 =?utf-8?B?eUFyMnVtVGdXaytWQ1FzQ1g1eExHbTZZeHNVaUdGcjFobFYwZFU4NGlBb1No?=
 =?utf-8?B?cllMWFoxRXdjRTJSZk1rVWlmVDlLMkl5R2lMT2hZWHRWR2ZXaHQ4V2FJNHdI?=
 =?utf-8?B?eXJoaSsxUDVEMWtrV1M1Q08zQVhTR29wazMyT2ZISitOOGcwSEhmQm5od2Vp?=
 =?utf-8?B?Tm9OQThXVlY1c2MvOEFNeERUZ2ZiNW1JeXpJdzZsMFNxcHFncjR5eXoveFdI?=
 =?utf-8?B?U0FmdU1zT0VTelVteXQyaGVYcGkzT3RuN0g2aS8zNGk1c2N1UXM0cGJFbWtD?=
 =?utf-8?B?R0czcGkraHE5RHhJZnN4d2daaXgydlNxRnNxSGRiR2IreURzNGdVTVRWL1VU?=
 =?utf-8?B?aURFODFqVUYrWHpra2JRcC9CY3R6REs3WHJ4d2NYYVc0TEVMamxxRjFzUlJW?=
 =?utf-8?B?RXh5QnlWYTRJN0lyRDFPSk5iaHNCaXVqTjlkQWI3dEVhNUxjdlkzeVIyZ1hu?=
 =?utf-8?B?Yjgwb0thaEdWYStRUUZoL1ZKcFF6d1NFblk0UXZBSitGY1hINThrQnpZcktV?=
 =?utf-8?B?RG1XRTVlTHVpTk1mNEVxdGswVFJUZitPQk8xdzEwcG44NUxlWUp2Y0o3akl6?=
 =?utf-8?B?ekEwSWlvbVc0dXlGYXRmZm5SN2NnY0c5M09ES3JkNkc5RkF6NjdpcGF2SVpl?=
 =?utf-8?B?N2lBRE1wYkNpdmhHZWFQZFo5NFo0QUQxakxTa0VhR0FUZUtUK2o2dG5ONUtQ?=
 =?utf-8?B?WUdjVVg2bTRHRWtKdVZsOFpKb0lRaUt3bFNqWGNrU1pQK3BzNkxQcW1GT3hz?=
 =?utf-8?B?dzBnNmZSUEt4OHdZUnVPeVV2WkZYSkxHR1IzMThxamxVVGhjekFoSWdYQmQx?=
 =?utf-8?B?dW5NN3NuUEcwU0w0ZEMrajFYRVFObm1iVHBxQzdrUmRIVkhsdlBKdE5qM0Q0?=
 =?utf-8?Q?AapUQ4phi70GY0z0KoGaOzc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7669a847-d97d-4732-0bbb-08dbfa585a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 14:49:18.1551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zywut1Nay0a0MqSLYHEE1NDoivwPg5XHUSNZZ5YGBx/xy6YceRtXnP9/Nc7dvH7LisDKqpkPSPPvOOd3udQxdKrWbJQWIMoovgFGkNg9Ylw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB0988
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <F57DB8327A90ED499557E02074233633@CHEP278.PROD.OUTLOOK.COM>
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

T24gTW9uLCAyMDIzLTEyLTExIGF0IDE0OjQ1ICswMTAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gRnJvbTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXgu
Y29tPg0KPiANCj4gRGlzYWJsZSBDT05GSUdfU1BMX0xPQURfRklUX0FQUExZX09WRVJMQVksIHRo
aXMgaXMgbm90IHJlcXVpcmVkIG5vciB1c2VkDQo+IG9uIHZlcmRpbiBhbTYyLCBkaXNhYmxlIGl0
IHRvIHNhdmUgcHJlY2lvdXMgYmluYXJ5IHNpemUuDQo+IA0KPiBVcGRhdGUgZGVmY29uZmlnIHVz
aW5nIHNhdmVkZWZjb25maWcsIHRoaXMgYWRkcyBDT05GSUdfT0ZfTElCRkRUX09WRVJMQVkNCj4g
ZXhwbGljaXRseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFu
Y2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT4NCg0KQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8
bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiDCoGNvbmZpZ3MvdmVyZGlu
LWFtNjJfYTUzX2RlZmNvbmZpZyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL3ZlcmRpbi1h
bTYyX2E1M19kZWZjb25maWcgYi9jb25maWdzL3ZlcmRpbi1hbTYyX2E1M19kZWZjb25maWcNCj4g
aW5kZXggNzgwODYwMTgwODc5Li5jZGQ2YmE4YmFlZDQgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3Mv
dmVyZGluLWFtNjJfYTUzX2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdzL3ZlcmRpbi1hbTYyX2E1
M19kZWZjb25maWcNCj4gQEAgLTE3LDYgKzE3LDcgQEAgQ09ORklHX0VOVl9PRkZTRVQ9MHhGRkZG
REUwMA0KPiDCoENPTkZJR19ETV9HUElPPXkNCj4gwqBDT05GSUdfREVGQVVMVF9ERVZJQ0VfVFJF
RT0iazMtYW02MjUtdmVyZGluLXdpZmktZGV2Ig0KPiDCoENPTkZJR19TUExfVEVYVF9CQVNFPTB4
ODAwODAwMDANCj4gK0NPTkZJR19PRl9MSUJGRFRfT1ZFUkxBWT15DQo+IMKgQ09ORklHX0RNX1JF
U0VUPXkNCj4gwqBDT05GSUdfU1BMX01NQz15DQo+IMKgQ09ORklHX1NQTF9TRVJJQUw9eQ0KPiBA
QCAtMzMsNyArMzQsNiBAQCBDT05GSUdfU1lTX01FTVRFU1RfRU5EPTB4QjAwMDAwMDANCj4gwqBD
T05GSUdfRklUX1ZFUkJPU0U9eQ0KPiDCoENPTkZJR19TUExfTE9BRF9GSVQ9eQ0KPiDCoENPTkZJ
R19TUExfTE9BRF9GSVRfQUREUkVTUz0weDgxMDAwMDAwDQo+IC1DT05GSUdfU1BMX0xPQURfRklU
X0FQUExZX09WRVJMQVk9eQ0KPiDCoENPTkZJR19MRUdBQ1lfSU1BR0VfRk9STUFUPXkNCj4gwqBD
T05GSUdfRElTVFJPX0RFRkFVTFRTPXkNCj4gwqBDT05GSUdfQk9PVERFTEFZPTENCg==

