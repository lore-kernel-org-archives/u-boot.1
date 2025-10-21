Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444ACCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 12:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4849A832BC;
	Tue, 21 Oct 2025 14:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B1A82B20; Tue, 21 Oct 2025 11:20:27 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11949807B1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWKtU8JkeGkB8d7vJzs1UTjM9LOK/OIu6IcChI45NTVNSXIFZZf3fIPpSA0AiNyuGl8Pv+rSGtWLWOAHED0VXe/OYH/IFOW6HomvgCYSEOyMrYQ+S78GYTdMdIDDzY6BAjKYJSk6mF57t3Xxaxjk7QW74VllL98MIPtuUln/EzJ58nEmO7F1W2kL+Us8D14ZLO62Y48hUf63EqlID0B6RInq28+0N/nfQQ43O6NeLmrsoYcGXto9OoDTfDuAdwXL8UdCrW8N3T5Ik1R/TP2li+CELJCGqD1X5Tr/JdCSQOCqXO0oacjhRx+EjDGAwrDEIdJ5PEvb3SpuBjLKvYod7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLWJui7BkucgsUGav2UwWPIqHcJ9lXAMn9+yZELDMTk=;
 b=Xd6mLmn3TRfRKpb/s8YNFoeTBz9lTG2r0ThE4wY0h5fTf7UmvOUyWZpvLNV7AK95xCiQJnTlx5ueI2mKz7U/AwY5vW7QPzRqqtcYj2JGs6Ah7PlPpdcg1kOp1WGCTdZgk7MER0PmymO54B19pHnwg+LD1Bs+BB6pAlM/swonlkhvC1Ce/0JfGeNZWzKpBSXi7PZMd3kuQ/f/kjx3wYzuRaRSluriy6laVWnh4vyHfg60sN6Si3/CI/8zUhjakppDPAL74TFKd7RE3Ya3ueUXmpPf62ReRoEn2BC3Fh0VnkqV+AMd0sqz3qVSNeW+xhY83QsXWVfngb4TW15LpIlGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1209.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 09:20:19 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 09:20:19 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>
Subject: RE: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
Thread-Topic: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
Thread-Index: AQHcGKuSTa2ZnHjz5k+TrORZYVPfb7R5PSoAgAcybwCATCs1IA==
Date: Tue, 21 Oct 2025 09:20:19 +0000
Message-ID: <ZQ2PR01MB1307068E11800715ED166144E6F22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-4-hal.feng@starfivetech.com>
 <3f7547d9-5abb-42d9-9bf8-02329ced4364@canonical.com>
 <b1a0ad61-f844-408a-81e9-078fd3b52462@freeshell.de>
In-Reply-To: <b1a0ad61-f844-408a-81e9-078fd3b52462@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1209:EE_
x-ms-office365-filtering-correlation-id: cdaa1bd2-082d-41bc-77f5-08de10830dd9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: HFgWuHKOJ4iTw5KNDDo87k9RHOo9A6eqYYnSA8Nh7+VSeKF5Ff2esMTO1sHsmMAo6rx4EAvvv3C6LgIgUQVHNMufiSg+qHClJDdpFU2+53Nb1T+eyY/4SM3c65TkQtF5WAr1/CSftD7FoZUen5po9LyTl3mVyMe19czlGIbWUyZU9ghHAGGkX7bFwES1ML0ogVFZJpIxFKPSdAjh4xq7SlzEyhNpGGzgrqi5HbLxiKCDZhmSUoSHjZlxZfdtZPDsqgPvjED0veOmhmpgCghZbEde2xOTJercbEeBlnkf3X0TLybQKAG/0PV/Hc3cGGK+GqHa2CI4gvkmo3xOLYdmKScqvvSCxJdv2UMjvpR3cOYCZrr/XzpDdKFYGrICpGvBmGu/VvOZ7MGwKGbbjFqm6aYrV36GDbMij4SofAJIHyvG74csyutYWEi6QcjrMwXioXSxY7KUYSC10h3ztTWWWXDcLLnJnQR6Gjz1LqTMqLQGQ/waX3dQznR1B0/bUXJBDUJ49fFbE5nzSUA6Z0KayiBvuO1X5ECD8PNbOzlBXgQd7vbFowIRG0+a5fW0WK/wY9BOZOn6hBAnaBmeTg2m7mO/PbE/Gwj9MDcN61hctRg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0sxVzFLYm5jaGlmUWxVdHZucDJHbG1JYk55eStVS1BrdkNXU29kZE1VQ05s?=
 =?utf-8?B?Z3NTRzBZYzVkeVZ0RDQzaENiaTRQZjRKUTFSNkxuamVzZDN5OHRYc0R0dndK?=
 =?utf-8?B?dkgwVHdDem1zMFpiTXNOM05pOG9TZ3RKT1NWZ2Y3d3o0dCtlTnpvbWRFUzVi?=
 =?utf-8?B?aWs5ekV4bTFZYWZ4NVVvcnlmN0pCUncvKzF1VW1WOXV5TUFxT3NwTUl4T0lS?=
 =?utf-8?B?eXVEWG01d2tNR21NdjVCMjY4cXQyOU4yL1dYeEc5bTVZNzY4c3hBQ2sxemY5?=
 =?utf-8?B?dkJZWU9XVGNwcmZXKy9iZDMwb1lwYXpnci91b3dEQ3hYQ0svb1N3eUdjKzh6?=
 =?utf-8?B?YS8rYkc2M0VNeGMzbzRReWNXajRaVVZvWkhQMjJ5Z3ByeEg5a2ZBYUVzb1pk?=
 =?utf-8?B?M085QVpUV1hWUU55MVZzTXZMbURaekwwVTIzVHhBQjNhUmtxc0VGY21yZk9m?=
 =?utf-8?B?V3NBNm1nRG5GaklQQUpaWTg5TG9aMEFyUjdTbGdwc25JU2JZYmo2RWpCQUQ0?=
 =?utf-8?B?SHhXWGNKeFJQUHcvSDY0SEFLN0doYitCNzFCaTZ3M0IvdTlCQ2wrdmxTeFZ0?=
 =?utf-8?B?N09qTmh3MEFQVHJHSGtIYklWMDJ5VVR2REhsZ2IvUHhXQW52REtiUi9va29E?=
 =?utf-8?B?WnRQSldSSnhVQ1JXdDY2VDJ3azZreXJzR1hTZlY4QjZLaUpQc0U0aTBsOGRK?=
 =?utf-8?B?dXIraE9ZdVZNYWhBQlpkM3FjU3VIdG1UTXFqQktqNzNYa3RnMzMzUlB3Q2pi?=
 =?utf-8?B?d3ZwTnBpMFdoUGNPOS9pWGQ4eW1ETEZ4SnZNV2NoWHdrcEI0Ty9MRGV0V0Zr?=
 =?utf-8?B?OTNPN1dQSnhjM2ZuUGlKc3REbmFzRDNnemF1bGUybHhadUFOUWpOL2puSVM1?=
 =?utf-8?B?d0NVUlFGU1NMSjY4YVNGL21nbTZnS0g5NXlnR1NhWjFxQ01MRENsMFc5U1Nq?=
 =?utf-8?B?L2hLdmx2K1F6WXJwMEREZE0vTUp6VmFvcW5IU3pYYVphR25TczUyK3luRFFQ?=
 =?utf-8?B?UW10TDB4MGhBQVBaTHQ4c3U4VVBzanBibEZpdmNNOVdoUGJ2S2JFaDRuOXpE?=
 =?utf-8?B?M0NpUkJMUkhUMyswckJQUjVHUWRuOU0rMy9ia0VFY0hYWE5EbGdQWDRVRkFG?=
 =?utf-8?B?RUExTURxd1dCUS9QdkNjWVVBOG52OTUvMmdXTVNHcWRWU3pSM2tpUDhzWFZM?=
 =?utf-8?B?OGlmdHFOMWNVc0R4YlpvbmhncFhpYTdpVDB0aTVNWDhDZThnblNwUENmOGJk?=
 =?utf-8?B?SlNNL3JCWFdTUVNxQmtwcis4cUxMb1gwbVJPUGhEZDVjKzBqOXc4NVRMQnpO?=
 =?utf-8?B?SlB1R3lraWJpUG1XVHlhNmJPSkkrc2xWVEJsTUdOUGxXcC95RUpYQzZ2Z3R4?=
 =?utf-8?B?SDMzNHpFTGxFd1ZjZWlKZHY4RGlHL0JDSUxsYThFdnFzSkRGNEtxSkh2aklE?=
 =?utf-8?B?SDV0WHVPR01iaHl1QlhjVFJSc3lYYkk0MVRmUkFnYTROYldsaFh2WCtDbThv?=
 =?utf-8?B?dk5iRVp2WDdtSU93Vk9CMlNjYlk0VUFJREtqYVVDbkMzY09vb2ZocDlLT2Zk?=
 =?utf-8?B?cFpuTlNobW40S3pOSnkwaCtmTCs5ckFya0NMQkd3RVhlaEVRc3lmVWphSVhr?=
 =?utf-8?B?SHIreTlDWm1hSGpUMmR2RVZweUJoaXllOFZGZWQxWk1xcTM4bjRSMEgwN3I5?=
 =?utf-8?B?TjByendDdzk3MS9TQk5EZ0xTTFJOQTVLNjdQRmx6ejBzRFdXTytQem1PUmd2?=
 =?utf-8?B?WWV5Rjl3SDhNaUFKa3VDRDlmazd3S016Z0VoOXF1U3FSRytGMUVENlA1czZB?=
 =?utf-8?B?QzMrRWtCQktabDA5bCtoWC9GaVl2Zi9HZDhvOHJSTzhHaUlXV2pRL1dyNFJX?=
 =?utf-8?B?TmJKV2R3OFUwNmx3QitFeDZzYTFGRXJ4T25uQnZiYXBiN1hBdnpkY0l6Smpi?=
 =?utf-8?B?ZHM1VngvYTZkQTVpNTZVem5GYWp4c1FuRDc0OFBJaGh2TDJZRmNsemRRNDVT?=
 =?utf-8?B?QlcrTlNzcGMyT1FUcmRVc0RUdXNiajRFeElib0ZxRlA0VzV5NC9LOUFyTHRk?=
 =?utf-8?B?MFppM2tlTlo0VjJucmY0NnpYWE9SZVlzQVc2eG5kUlFXVm1pTGJtbGM0NFMx?=
 =?utf-8?Q?ZQQbXSBFiCqi0of12ipLFCOfm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaa1bd2-082d-41bc-77f5-08de10830dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 09:20:19.2056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5iJpAWcfVjt3ErCi/3IwYubxO85EHFbT7QVFPJyycJcVtqDQGp+uHXzPv3I1pZwdpKAjFfY1jlLmeS8VSSEjks7q1LbgDNzgB79HVJid+Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1209
X-Mailman-Approved-At: Tue, 21 Oct 2025 14:51:30 +0200
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

PiBPbiAwMy4wOS4yNSAwNToyOCwgRSBTaGF0dG93IHdyb3RlOg0KPiBPbiA4LzI5LzI1IDAwOjMz
LCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPiA+IE9uIDI5LjA4LjI1IDA4OjA5LCBIYWwg
RmVuZyB3cm90ZToNCj4gPj4gRGlyZWN0bHkgcmV0dXJuIHRoZSBERFIgc2l6ZSBpbnN0ZWFkIG9m
IHRoZSBmaWVsZCBvZiAnRHh4eEV4eHgnLg0KPiA+PiBNb3ZlIHRoZSBmdW5jdGlvbiBkZXNjcmlw
dGlvbiB0byB0aGUgaGVhZGVyIGZpbGUuDQo+ID4+DQo+ID4+IEZpeGVzOiBhZWExYmQ5NWI2MWUg
KCJlZXByb206IHN0YXJmaXZlOiBFbmFibGUgSUQgRUVQUk9NDQo+ID4+IGNvbmZpZ3VyYXRpb24i
KQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPj4gLS0tDQo+ID4+IMKgIGFyY2gvcmlzY3YvY3B1L2poNzExMC9zcGwuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPj4gwqAgYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS9hcmNoLWpoNzExMC9lZXByb20uaMKgwqDCoMKgIHzCoCA4ICsrKysr
KystDQo+ID4+IMKgIC4uLi92aXNpb25maXZlMi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmPCoMKg
wqDCoMKgwqDCoCB8IDE3DQo+ID4+ICsrKy0tLS0tLS0tLS0tLS0tDQo+ID4+IMKgIDMgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2NwdS9qaDcxMTAvc3BsLmMNCj4gPj4gYi9hcmNoL3Jpc2N2
L2NwdS9qaDcxMTAvc3BsLmMgaW5kZXggODdhYWY4NjUyNDYuLjNhZWNlN2Q5OTViIDEwMDY0NA0K
PiA+PiAtLS0gYS9hcmNoL3Jpc2N2L2NwdS9qaDcxMTAvc3BsLmMNCj4gPj4gKysrIGIvYXJjaC9y
aXNjdi9jcHUvamg3MTEwL3NwbC5jDQo+ID4+IEBAIC00MSw3ICs0MSw3IEBAIGludCBzcGxfZHJh
bV9pbml0KHZvaWQpDQo+ID4+IMKgwqDCoMKgwqAgLyogUmVhZCB0aGUgZGVmaW5pdGlvbiBvZiB0
aGUgRERSIHNpemUgZnJvbSBlZXByb20sIGFuZCBpZiBub3QsDQo+ID4+IMKgwqDCoMKgwqDCoCAq
IHVzZSB0aGUgZGVmaW5pdGlvbiBpbiBEVA0KPiA+PiDCoMKgwqDCoMKgwqAgKi8NCj4gPj4gLcKg
wqDCoCBzaXplID0gKGdldF9kZHJfc2l6ZV9mcm9tX2VlcHJvbSgpID4+IDE2KSAmIDB4RkY7DQo+
ID4+ICvCoMKgwqAgc2l6ZSA9IGdldF9kZHJfc2l6ZV9mcm9tX2VlcHJvbSgpOw0KPiA+PiDCoMKg
wqDCoMKgIGlmIChjaGVja19kZHJfc2l6ZShzaXplKSkNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGdkLT5yYW1fc2l6ZSA9IHNpemUgPDwgMzA7DQo+ID4+IMKgIGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L2luY2x1ZGUvYXNtL2FyY2gtamg3MTEwL2VlcHJvbS5oIGIvYXJjaC8NCj4gPj4gcmlzY3Yv
aW5jbHVkZS9hc20vYXJjaC1qaDcxMTAvZWVwcm9tLmgNCj4gPj4gaW5kZXggNDVhZDJhNWY3YmMu
LjZkMGEwYmEwYzRhIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Fy
Y2gtamg3MTEwL2VlcHJvbS5oDQo+ID4+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJj
aC1qaDcxMTAvZWVwcm9tLmgNCj4gPj4gQEAgLTEwLDcgKzEwLDEzIEBADQo+ID4+IMKgICNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPg0KPiA+PiDCoCDCoCB1OCBnZXRfcGNiX3JldmlzaW9uX2Zyb21f
ZWVwcm9tKHZvaWQpOw0KPiA+PiAtdTMyIGdldF9kZHJfc2l6ZV9mcm9tX2VlcHJvbSh2b2lkKTsN
Cj4gPj4gKw0KPiA+PiArLyoqDQo+ID4+ICsgKiBnZXRfZGRyX3NpemVfZnJvbV9lZXByb20oKSAt
IHJlYWQgRERSIHNpemUgZnJvbSBFRVBST00NCj4gPj4gKyAqDQo+ID4+ICsgKiBAcmV0dXJuOiBz
aXplIGluIEdpQiBvciAweEZGIG9uIGVycm9yLg0KPiANCj4gTm8uIFRoaXMgaXMgbm90IGNvbnNp
c3RlbnQgd2l0aCBnZXRfbW1jX3NpemVfZnJvbV9lZXByb20oKSByZXR1cm4gdmFsdWUNCj4gd2hp
Y2ggdXNlcyAwIGFzIHNob3J0LWNpcmN1aXQgcmV0dXJuIHZhbHVlIGlmIHJlYWRfZWVwcm9tKCkg
ZmFpbHMuDQo+IA0KPiBJdCBpcyBub3QgaW1wb3J0YW50IHRvIG1ha2UgdGhlIGRpc3RpbmN0aW9u
IGhlcmUgaWYgZWVwcm9tIHJlYWQgZmFpbGVkIG9yIHRoZQ0KPiBkYXRhIHdhcyBub3QgYSB2YWxp
ZCBzaXplIChpLmUuIHplcm8gZnJvbSBzdWNjZXNzZnVsIGVlcHJvbSByZWFkKS4NCg0KT0suIFdp
bGwgcmV0dXJuIDAgaWYgcmVhZF9lZXByb20oKSBmYWlscy4NCg0KPiANCj4gPj4gKyAqLw0KPiA+
PiArdTggZ2V0X2Rkcl9zaXplX2Zyb21fZWVwcm9tKHZvaWQpOw0KPiA+PiDCoCDCoCAvKioNCj4g
Pj4gwqDCoCAqIGdldF9tbWNfc2l6ZV9mcm9tX2VlcHJvbSgpIC0gcmVhZCBlTU1DIHNpemUgZnJv
bSBFRVBST00gZGlmZg0KPiA+PiAtLWdpdCBhL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL3Zp
c2lvbmZpdmUyLWkyYy1lZXByb20uYyBiLw0KPiA+PiBib2FyZC9zdGFyZml2ZS92aXNpb25maXZl
Mi92aXNpb25maXZlMi1pMmMtZWVwcm9tLmMNCj4gPj4gaW5kZXggMTdhNDQwMjBiY2YuLjM4NjZk
MDdmOWQ0IDEwMDY0NA0KPiA+PiAtLS0gYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi92aXNp
b25maXZlMi1pMmMtZWVwcm9tLmMNCj4gPj4gKysrIGIvYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2
ZTIvdmlzaW9uZml2ZTItaTJjLWVlcHJvbS5jDQo+ID4+IEBAIC01NTAsMjMgKzU1MCwxMiBAQCB1
OCBnZXRfcGNiX3JldmlzaW9uX2Zyb21fZWVwcm9tKHZvaWQpDQo+ID4+IMKgwqDCoMKgwqAgcmV0
dXJuIHBidWYuZWVwcm9tLmF0b20xLmRhdGEucHN0cls2XTsNCj4gPj4gwqAgfQ0KPiA+PiDCoCAt
LyoqDQo+ID4+IC0gKiBnZXRfZGRyX3NpemVfZnJvbV9lZXByb20gLSBnZXQgdGhlIEREUiBzaXpl
DQo+ID4+IC0gKiBwc3RyOsKgIFZGNzExMEExLTIyMjgtRDAwOEUwMDAtMDAwMDAwMDENCj4gPj4g
LSAqIFZGNzExMEExL1ZGNzExMEIxIDogVmlzaW9uRml2ZSBKSDcxMTBBIC9WaXNpb25GaXZlIEpI
NzExMEINCj4gPj4gLSAqIEQwMDg6IDhHQiBMUEREUjQNCj4gPj4gLSAqIEUwMDA6IE5vIGVtbWMg
ZGV2aWNlLCBFQ3h4OiBpbmNsdWRlIGVtbWMgZGV2aWNlLCB4eDogQ2FwYWNpdHkNCj4gPj4gc2l6
ZVtHQl0NCj4gPj4gLSAqIHJldHVybjogdGhlIGZpZWxkIG9mICdEMDA4RTAwMCcNCj4gPj4gLSAq
Lw0KPiA+PiAtDQo+ID4+IC11MzIgZ2V0X2Rkcl9zaXplX2Zyb21fZWVwcm9tKHZvaWQpDQo+ID4+
ICt1OCBnZXRfZGRyX3NpemVfZnJvbV9lZXByb20odm9pZCkNCj4gPj4gwqAgew0KPiA+PiAtwqDC
oMKgIHUzMiBwdiA9IDB4RkZGRkZGRkY7DQo+ID4+IC0NCj4gPj4gwqDCoMKgwqDCoCBpZiAocmVh
ZF9lZXByb20oKSkNCj4gPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBwdjsNCj4gPj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiAweEZGOw0KPiANCj4gTm8sIGludmVydGVkIGxvZ2ljLCBzZWUgYWJv
dmUgcmV0dXJuIG9mIDB4RkYgYXMgYW4gZXJyb3IgY29uZGl0aW9uIGlzIHN1c3BlY3QuDQoNCkRp
dHRvLg0KDQo+IA0KPiA+DQo+ID4gTGV0J3MgYXNzdW1lIHNvbWVib2R5IGNsZWFyZWQgdGhlIEVF
UFJPTSBhbmQgdGhlIFNQSSBmbGFzaC4NCj4gPg0KPiA+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8g
YXNzdW1lIHRoZSBtaW5pbXVtIGVuY29kYWJsZSBSQU0gc2l6ZSAoMSBHaUIpDQo+ID4gaW4gdGhp
cyBjYXNlLCBqdXN0IHRvIGxldCB0aGUgYm9hcmQgYm9vdCB0byB0aGUgY29uc29sZSB0byBhbGxv
dw0KPiA+IHdyaXRpbmcgdGhlIEVFUFJPTSB3aXRoIHZhbGlkIGRhdGEgYWdhaW4/DQo+ID4NCj4g
PiBUaGUgY3VycmVudCBwYXRjaCB0byBzaW1wbGlmeSB0aGUgY29kZSBsb29rcyBjb3JyZWN0Lg0K
PiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEhlaW5yaWNoIFNjaHVjaGFyZHQgPGhlaW5yaWNoLnNjaHVj
aGFyZHRAY2Fub25pY2FsLmNvbT4NCj4gPg0KPiA+PiDCoCAtwqDCoMKgIHJldHVybiBoZXh0b3Vs
KCZwYnVmLmVlcHJvbS5hdG9tMS5kYXRhLnBzdHJbMTRdLCBOVUxMKTsNCj4gPj4gK8KgwqDCoCBy
ZXR1cm4gKGhleHRvdWwoJnBidWYuZWVwcm9tLmF0b20xLmRhdGEucHN0clsxNF0sIE5VTEwpID4+
IDE2KSAmDQo+ID4+IDB4RkY7DQo+ID4+IMKgIH0NCj4gPj4gwqAgwqAgdTMyIGdldF9tbWNfc2l6
ZV9mcm9tX2VlcHJvbSh2b2lkKQ0KPiA+DQo+IA0KPiBZZXMsIGxhdGVyIGZhbGxiYWNrIHRvIDJH
IHNpemUgY29uZmlndXJhdGlvbiBtYWtlcyBzZW5zZS4gQ29tcGF0aWJsZSBwcm9kdWN0cw0KPiB3
aXRoIGxlc3MgdGhhbiAyRyBkbyBub3QgZXhpc3QgYW5kIHByb2JhYmx5IG5ldmVyIHdpbGw7IHRo
ZXJlIG1heSBiZSBzb21lDQo+IGRldmVsb3BlciBib2FyZHMgd2l0aCAxRyBidXQgbm9uZSBJIGhh
dmUgZXZlciBoZWFyZCBvZiBkaXJlY3RseSBpbg0KPiBjb252ZXJzYXRpb25zIHNpbmNlIDIwMjMu
IFRoZSBvdGhlciBjb21tb24gc2l0dWF0aW9uIHdpdGggemVybyBvcg0KPiB1bmluaXRpYWxpemVk
IEVFUFJPTSB3b3VsZCBiZSBhIGZhaWxlZCByZWFkIG9mIGVlcHJvbSBpLmUuIFJUQyBtb2R1bGUg
YXQNCj4gc2FtZSBpMmMgYWRkcmVzcyBvciBtaXNzaW5nIGRldmljZXRyZWUgbm9kZXMgYXQgU1BM
IHBoYXNlLg0KPiANCj4gMS4gRERSIHNpemUgZGV0ZWN0aW9uIGhldXJpc3RpYyBzaG91bGQgaGFw
cGVuIGZpcnN0IHdpdGhvdXQgbmVlZCBvZiBlZXByb20sIGlmDQo+IHBvc3NpYmxlLg0KPiANCj4g
Mi4gRWxzZSB3YXJuIEREUiBkZXRlY3Rpb24gZmFpbGVkIGFuZCByZWFkIHNpemUgZnJvbSBlZXBy
b20gY29uZmlnDQo+IA0KPiAzLiBFbHNlIHdhcm4gZWVwcm9tIG1lbW9yeSBjb25maWcgaW52YWxp
ZCBhbmQgc2V0IHNpemUgc2V0IHRvIGRlZmF1bHQgMkcuDQoNCkFjdHVhbGx5LCBpZiB0aGUgdS1i
b290IGZhaWxzIHRvIHJlYWQgRERSIHNpemUgZnJvbSBFRVBST00sIGl0IHdpbGwgdXNlIHRoZSBz
aXplICg0R0IpDQpkZWZpbmVkIGluIHRoZSBtZW1vcnkgbm9kZSBvZiBkZXZpY2UgdHJlZS4gDQoN
CldpdGggc29tZSBkZWJ1Z2dpbmcsIEkgZm91bmQgdGhhdCB0aGUgcmVhc29uIHdoeSB0aGUgU1BM
IGZhaWxzIHRvIGJvb3Qgd2hlbiB0aGUNCkVFUFJPTSBjcmFzaGluZyBpcyB0aGF0IHRoZSB1LWJv
b3QgRkRUIHNlbGVjdGlvbiBkZXBlbmRzIG9uIHRoZSBwcm9kdWN0IElEIHJlYWQNCmZyb20gRUVQ
Uk9NLiAgVGhlcmUgaXMgbm8gZGVmYXVsdCBGRFQgZm9yIFZGMiB1LWJvb3QgdG8gdXNlIG5vdy4N
Cg0KT25lIHNvbHV0aW9uIGlzIHRoYXQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvZHRzL2Jpbm1hbi5kdHNpIGIvYXJjaC9y
aXNjdi9kdHMvYmlubWFuLmR0c2kNCmluZGV4IGI1MTg1NjBiYjk0Li5iMWJhY2FmNzk5NiAxMDA2
NDQNCi0tLSBhL2FyY2gvcmlzY3YvZHRzL2Jpbm1hbi5kdHNpDQorKysgYi9hcmNoL3Jpc2N2L2R0
cy9iaW5tYW4uZHRzaQ0KQEAgLTkyLDEwICs5Miw3IEBADQogICAgICAgICAgICAgICAgICAgICAg
ICB9Ow0KIA0KICAgICAgICAgICAgICAgICAgICAgICAgY29uZmlndXJhdGlvbnMgew0KLQ0KLSNp
Zm5kZWYgQ09ORklHX01VTFRJX0RUQl9GSVQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGVmYXVsdCA9ICJjb25mLTEiOw0KLSNlbmRpZg0KIA0KICNpZiAhZGVmaW5lZChDT05GSUdf
T0ZfQk9BUkQpIHx8IGRlZmluZWQoQ09ORklHX01VTFRJX0RUQl9GSVQpDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEBjb25mLVNFUSB7DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCndoaWNoIG1lYW5zIHVzaW5nIHRoZSBmaXJzdCBGRFQgKGpoNzExMC1k
ZWVwY29tcHV0aW5nLWZtbDEzdjAxKSBpbiBPRl9MSVNUIGFzIHRoZQ0KZGVmYXVsdCBGRFQuDQoN
CkJlc3QgcmVnYXJkcywNCkhhbA0K
