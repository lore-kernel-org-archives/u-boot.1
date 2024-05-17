Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E7EC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 09:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2897E882D9;
	Fri, 17 May 2024 11:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02AE88495; Fri, 17 May 2024 11:47:46 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3008883BA
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 11:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+9MB5BM8YvplZ5sYF1BsL1HkRaAoAuRv76nFZ7DYFHfsn8kY7gWoaOJSxrAOKvt7lg/V1MgAjmz1LWaIUAm2Y1Nt9np4lLIf8zlCmfDOsQN8JXENAhenjcoptpzHNeHD6kZEZtWzTsWRsqugr/vLGjgJyCCh1T8jbAvCjEXz8p7rnr3uYfwaDQa6AfyYXjy78LeKT1foR1EoWZh7gNEtgE+qvzQURMXafubo4/mm6ZXet+1Zjlufyk4lR5Gfc7zFGijwowol22qt03xsDe4A9vciLVT69GdSmoKC/XilAgiHn0adV6Xfxb0ZN97zjg+jFstbKf0ySa+K+9XDjcbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYTSAWS6la6p1CaoDLQf+zpcMZvkKTOx/id1YCzylTc=;
 b=DyiMkj63QXfLv59Z9/rKsk72wRG4NZUBuLptEWDQxh/eJbXmUmN7yzeDHcHqKm535kSzHEy+p/Wdk0joKWCQaneCBL3oy2sTgKILTJW3K3uEq0llRx9Q/5Bcd90/Zd11SHPi8KcxFBAU1yVmk+Std0SAhSHGvx4G0Q2mX+5BHjEzF7YLGGzv4H5lIz/jYueXNUORm0WeuBqfJR5103RmoRSZopmPhC2cJoYl5S1jnJ4gY8Rwo7pcm4zsy9QxczF+xZ//X711HvmB4vUX59YPzULJcRG1tLcZrN6GQSpETg4clb0+Ngo4PTzwAy+5+EDVZB49LoIz6g91nxcwuvgTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0486.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 17 May
 2024 09:47:38 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Fri, 17 May 2024 09:47:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1 7/7] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Thread-Topic: [PATCH v1 7/7] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Thread-Index: AQHanjRUKqPA+mDrEkair7jWCOXsLbGMk8oAgA6uTTA=
Date: Fri, 17 May 2024 09:47:38 +0000
Message-ID: <BJXPR01MB0855BBB699F2FF59F1E699F8E6EE2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-8-minda.chen@starfivetech.com>
 <31783bbc-5efe-4721-aff7-53933c87baf5@denx.de>
In-Reply-To: <31783bbc-5efe-4721-aff7-53933c87baf5@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0486:EE_
x-ms-office365-filtering-correlation-id: 00c00d62-9b40-4329-ce2d-08dc76566370
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PC5sSBy7YvaImWZ7zvY38g2bLANMyHkNrdnLosGWe6dXPVxT0/wL/VFCR4dRlipzlAPRMo8DLQV/Rm4ORSXfzEJEbawt1/NGj1VHzvyryt35iGDOdSjKg/K5Ft/QQFQUhM1M/yv7aKLpn0ikCX6s5Fb4VZmxGT0aUdrA+ZOyc63jdfj0D7r3PBX5oSwaOKxXPN5pCnDcOwQE89TE4k89GOfbLxg95twSi1+lW4gb5jJUT1LPIZ1MQ7B41GyOvh2RxLBlWA6glp1B+5Dz0AHBm2MMvphHL4YagS6h4SG/IxFLSrMmYVVOuUo1phNvlA3SZpbOC8xdQnV4up1zx2aKRyVoMrtlohkjzy+gsQOJNt05PauUWgAgYzPLAvoQiq3KiobO4ywWU3XbatFrCQS5lLSuWdm3ZYYGIczdldo9k+xyilibx7U4rrsWmu3n7uKjctnnuUjzuJMSVcYcC8c0YlL+RV+P635ZpWi+pQ8KO+bxpXGl/Y35fsnebbBeD8BRiuymmWfZlMcCxYiWS7dGoE4d6Wqt60gujvR7IjHrWDzkzea8PEuEujUFMZ7e8bWv9zapuY8gsjjTUzwsECccZGdu6YBkK1OAsAj5oYlnYbYHcSTOCif+IctnS81SpCPKDzMypjxqzqSK1XiZGygnCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(41320700004)(1800799015)(7416005)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk9aWkJ2YUpINVV2SXE4NlBXKzVLY1dpRzA3dWdFQ1cyOXBvc1dLNWlyZTBI?=
 =?utf-8?B?S2l6SjN0N2JnRlZNcjd5LzI2dUswd2k1QjdySC92dENhV0t1OHF6dFQrdDBY?=
 =?utf-8?B?b0I5Szc3RkJOb0FRK0xkeVNPMnJNWm9qN01uWGZrZGIxSFc4OVhOY0FqR1Zy?=
 =?utf-8?B?cW9TVmdxRHRSK0VCaVp6dm9nM0tsaE0xNHg1d0FHbm01R0hidE9FRkZqMEtY?=
 =?utf-8?B?dkVZWmkxS0Zyd25UOTZpcmZidGJxZ2tGT2ttcVFkYjlsdFV0ZldBTUJ6c3lM?=
 =?utf-8?B?SXdYbUdWeU5TKzhadmpSOUpBd0RYanNNeW50K1UxTk1VVTMreTR4VjFKeDAx?=
 =?utf-8?B?OHFmVTA1YzE0NWQ4d2NvcnpTMjd4cllVLzk2ZkpyMGQ5YzVkbkZ0dzhXRG5k?=
 =?utf-8?B?NVB3QVEvcmg3RHZad2RzMjYrL0VYT2cwcE8vRG5kQmswYXZiNlB2Q0luQ3pi?=
 =?utf-8?B?R2ZtakFvSUJtR29SZEZjMHkwTnNDZjlJRHRhZElOcWEzQnJLc1JyYWtVWnRC?=
 =?utf-8?B?M2kzTVFOZ2t4SmJGeWxpQ0VYeDNSZC9tRFNQTDNCZFJUcUpKWndkYkcvNHdL?=
 =?utf-8?B?bFZOZFFOTlg1SkpCVEZRMVlyR2E0Tk00SzAvdEJRUzhPQmZwcnZ0dnB4WGNM?=
 =?utf-8?B?WFJNK0lLdXo5ZFR6WnM2d3hZWkYyYVgxMXptelBndlJpekNveVVvak5hMllo?=
 =?utf-8?B?MUlSeG1ubHk3dXJCSlR3Q20rTU8xTXlRaDkvN0Z4OE80ajdGSHNjYURBa3Zt?=
 =?utf-8?B?dXpBM0VtYW9yTURudkdtTlh3dWJCbWFZNmF6c0h0Z3JNd0QxY0NRL01oKytZ?=
 =?utf-8?B?UHQwYUMwaG1Cd0ttN041cWtyT2pGNkFUMi9KSDJnMVVNeDI5Z0VyME93Z3dy?=
 =?utf-8?B?ZVBRUmkyWDRGRHdxcWJ4bVVJZjFpd2U1ang2dmtUcDRwWXhRdkowd0RKcGVl?=
 =?utf-8?B?VVBEOW5heDluZW9wTW4vSWh0bXJlRkZnazVVVlg3bTVaMFBFS0gwQ0JibHRs?=
 =?utf-8?B?eTQwbEdxMlFDUFR3bW1PRENrN3RlRnFDUWFxWHU1cnhnelh5L3l1TWFVNTNz?=
 =?utf-8?B?WmdrQng4bHR3RS9ESE9mUEh6THV2L1psLzdBMlhKOGpyOW96dkg2bmhwOEk2?=
 =?utf-8?B?ajQ3R1FyRXZpVThBZHN1UjFBQU95ZHlKNXd5RnVKOXViZlQ4WmJCWFVqdlpy?=
 =?utf-8?B?c0pneEp3eWNHVVMzcnd2K1lock43WElhQWRFYTJSSnBranR0M1ZPR3pKbDN1?=
 =?utf-8?B?Mk12VmgrS09IajlLUXUrU3dYSVc4aTlBdVFob1c5WmdkUmF3U1JxY0RSTlV2?=
 =?utf-8?B?aXNTMUY1cHhiSFpEeDNHZklDamdpblRkOEE1c3pIb3NSUW9uVk15VmtXbVUv?=
 =?utf-8?B?TGRvOVRlQ1pBTGtIN3hvaTFHUkZLWlJVT2UrdlZONVdSb2tBYWdid0dkMWhO?=
 =?utf-8?B?azhsWXE0TUhJS3hZRHRSUGJVWWNtMSs3TkFodjFWd1lZRDVCUWVpUlg2UHU1?=
 =?utf-8?B?UzNLUnBpdkllZnRVQTJud25aYnlwNEQxOWdIRlE1bGcydjlnRjZOa1RSaURI?=
 =?utf-8?B?eUdtVDNrWG5Ga0NZcG42c0FCVXcyMm9EdzNoV081UnczL1V3RWR3OHU5bUVO?=
 =?utf-8?B?REIrUFgxUVdnZnh6WGUvUjJtYzIrUmFMSnJDUHVQS0s3enZQTHVhTWx5eFhj?=
 =?utf-8?B?RW5SMUdERlgvRzRCNHdkV1JQaHBPbHVGdmFBcVZ5RHh6ckFFQXRkZmh1MWxx?=
 =?utf-8?B?U1ZnZHYyVVIvM2lHQWNCcXFHZ1dqQ0ZOY0hZL1p2Vk91Z0JpT0twcll0NHpF?=
 =?utf-8?B?S0o5QmJZT3RVT2RiR3d1N1BlSjkyYXJJVVdldm9PZFBDc2ZCS0luR3V5QXhn?=
 =?utf-8?B?UEJZdy9jMWZ2VThHQ3ptTmQxTGNZbjdQdTJ5QWZZaGRHcW1mUFFMQmZyV3Vy?=
 =?utf-8?B?TDhzWUFucDNHQkVKMHU2MnBoTFd0c0x4M2ZnL0tPMXczTTNzRGR2MVVSS2xC?=
 =?utf-8?B?RFpZUzc5ZytYaFpTQS9KRm83ZWZmM0YzVmRSUVZiU0N3b2E1bXA0TWVpV2JO?=
 =?utf-8?B?WjM0SityYktEQ09FdklDZGw2NFN5SjlFUkJHVHkxVU5rWU8zYlo2SVJ5bVg4?=
 =?utf-8?B?aDJkYVB4eUk3bzFoVlIvNmQ0NWZ2L244QWhhcmN0Q0F0eHZGbVl6V2hQaGN4?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c00d62-9b40-4329-ce2d-08dc76566370
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 09:47:38.7022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SEE9ZqQp6NgSjKG5GGcQqs/ZmYXYZvRl83CDvG/RHgKp5uOhToEQHh/qnHseJdu5OCXeN24aj0VpxljfueQeN05U7zrFLOk3OoLRvZOTJEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0486
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

DQo+IA0KPiBPbiA1LzQvMjQgNTowMyBQTSwgTWluZGEgQ2hlbiB3cm90ZToNCj4gPiBBZGQgVVNC
IHJlbGF0ZWQgZmlsZXMgdG8gU3RhcmZpdmUgdmlzaW9uZml2ZTIgTUFJTlRBSU5FUlMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVS
UyB8IDIgKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi9NQUlOVEFJTkVSUw0KPiBi
L2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL01BSU5UQUlORVJTDQo+ID4gaW5kZXggZDdmNjM4
ZjliNC4uMWZhZjgzZjU4MSAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9zdGFyZml2ZS92aXNpb25m
aXZlMi9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL2JvYXJkL3N0YXJmaXZlL3Zpc2lvbmZpdmUyL01B
SU5UQUlORVJTDQo+ID4gQEAgLTYsMyArNiw1IEBAIEY6CWJvYXJkL3N0YXJmaXZlL3Zpc2lvbmZp
dmUyLw0KPiA+ICAgRjoJaW5jbHVkZS9jb25maWdzL3N0YXJmaXZlLXZpc2lvbmZpdmUyLmgNCj4g
PiAgIEY6CWNvbmZpZ3Mvc3RhcmZpdmVfdmlzaW9uZml2ZTJfZGVmY29uZmlnDQo+ID4gICBGOglk
cml2ZXJzL3BjaS9wY2llX3N0YXJmaXZlX2poNzExMC5jDQo+ID4gK0Y6CWRyaXZlcnMvcGh5L3N0
YXJmaXZlLw0KPiA+ICtGOglkcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1zdGFyZml2ZS5jDQo+IA0K
PiBUaGFua3MgIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRl
Pg0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2ggc2V0ISAgSSB3aWxsIGZvbGxvdyB0
aGUgY29tbWVudHMuDQo=
