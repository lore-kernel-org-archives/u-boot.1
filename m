Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ADAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 03:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57FE87A00;
	Mon, 25 Mar 2024 04:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2446A87D64; Mon, 25 Mar 2024 04:10:34 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20701.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B3A87861
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 04:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMSYIlOUcnCpPo3nkJldgI57PRK1ASOfpPKaPENJEQUZJpKzCS/hGBSYE9WuWS7eyr8uBIHjj2DJ64PEY7bRxhMbh5gp5zBrJA9dU+O2HTPcFx0l7ilSKJ4ceCsMRqRmwH5Ops4fAR92X789r5QkDINQSygATAp94uH5T9+cho2eQ/jRSHHWaFPe/gko2I9T/SK3LAuyBIfi0HJLMSkoF4VKTbkqSJFGWrjccIoy5HKyUJ4vqCChEjalVyMhP6ZSzBI2B5LQO6XlXn8cY5qyhYOkH3wvQBjuGbAiXiik4l5vS8IWo3j0A+3ib4m++0HNpsVBKQaPyTpNslCp+3hvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwIbh6OOy9DAEmkyBjPjXxP19PZKRhuJvqT7CmRwCE8=;
 b=gPoRATqGEp5jBjj3w6mx336NGVXeRgIz2qt0ClpW7+JCM9GDthnBw1nElT/pccaWVgPNqh3Z+ZA8G3D3q2DeqbzNZ0lXibocSCSVPrfgVumsn5AFbh+p/TMJYIn6q2tSD9sT/OTWmtCgAkEGgxyiAAuQtAtmWqsRV4rpUFaVCS4RDUO+m6gzp8BqrWEDvp4PbN6WEYv1ICDkhpqziuXhnrdjMpCc3E0jIZkeXdGEAeg1T9q8m5+YqsUcAr+2d/3eldGlHi3Ty8wYjKeQq6TREMK0zgOBvN2SFry7q8uAoLK0LwzZ19NCrORADKaF9tzlKX2A2EE3tgmA3hkcDUwhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Mon, 25 Mar
 2024 03:10:23 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7409.026; Mon, 25 Mar 2024 03:10:23 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Hal Feng
 <hal.feng@starfivetech.com>
CC: Lukasz Tekieli <tekieli.lukasz@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Chanho Park <chanho61.park@samsung.com>, Shiji Yang
 <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyIDAvNl0gcmlzY3Y6IGFkZCBzdXBwb3J0IGZvciBN?=
 =?gb2312?Q?ilk-V_Mars_board?=
Thread-Topic: [PATCH v2 0/6] riscv: add support for Milk-V Mars board
Thread-Index: AQHae7tV6vLRGlgeEUi1Ldp0897lgLFHy9Cg
Date: Mon, 25 Mar 2024 03:10:23 +0000
Message-ID: <BJXPR01MB085553074644A86617F2485CE636A@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0534:EE_
x-ms-office365-filtering-correlation-id: 3dc59c48-e78b-49d1-d132-08dc4c791c83
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1fkeI7eTjSWnk1R+lkgES+RQltGJwkcU1RmLNx4M+WzW/+OQFB8symbIrI3odyuvs12nHsM12hTPAODRWhdj88HyAhuXoU2Kq83EzzijnCywgFJa6Z4nqXbaoNnqNn/7n6+e1PLgdEPOYcE2GYLSffNVJPv2o/AeLQRZd4NahE8WkZhqGHhAHCOIWTy2fVg686EAMQNMneA7SEt8w8vkeUuI5fsdvlR5Y0NY0hN80PiW6Rb7w9jaZ4yD2afzxi1MVHbVt8fjqqN82uDxmom5wjpOXI8cBzBKmzv622KgweM40myenXFBtqG1yHkmDDxhOD2hEtjoYud386+oocXYL4hRBFgNk52jLLizCOKfw9hsPzFqm0PP+lwzqxJoQflEDgjaKWMvEyNPv5/KPCVlFdk6bppXwzOVgMbAuvUy/5jUKhzbuqsr4DQmm/RwDvVhXvcCkPQKXoPZcTf8bynzwQpgg2iGSn7fJtIYEoefLcSjkUBiCQllfJt4yVpcgKN8YEeLW+fsmoMBCrLv/sBglJXbJirF9CZpB1/FWbnSsa08v4Miab1cSA8NExMBXzUyS2jaBcRGpjxE4YCzRLPE8vVMsr58hrIYO8Q7GptxwCkxmSqz1PZM6n/gHXruQX4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(41320700004)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dXdYQTBJQ3NsQUljNWt1WG9Yb3ZSbWxxbExTZHV0SjRIdENlaXZpdkVmKzU3?=
 =?gb2312?B?TVFzUmxCNVBPK0l4QkN6NWZqTUhsOUNQOGk4UWtWZmlwV3pQcGEwVW85MzJr?=
 =?gb2312?B?enlSUUtkR3BlWncxb09BcTRaTVIyOWI1b3g0Ukg0RlZpc3lxdGhaT2RoV1Vq?=
 =?gb2312?B?eUwwbXY5VjYvT1VMMERueW9SY21IM202eW9rczREdWNISTJ1ckdxdG13ZEFa?=
 =?gb2312?B?ZVpOSFJBU3ppWVNZYjRkOUFRNTE2L3hVVjZYWnJCZ1hoT3hFWVpYNzhLaVBC?=
 =?gb2312?B?VUVhNXBNMkZnb2N6a2RlRlJ2MGlEL2I5UWQ5MWczdTUyVVhXZFBLMzU3Tkhz?=
 =?gb2312?B?WnJhQk5EUERuUzh1VTM3NXhOY0RsVmZBNkFITGowRHNJSWxlOHpXMUdHNEda?=
 =?gb2312?B?aWFvT3Zmb0ROZHdsVit5ekJZQkdrOER5bkNZM1dZdk9NUGJDeC9Ia1ZtK0ZD?=
 =?gb2312?B?MitVaTRlWGRtNEdmaFQxYjdZZnU1aU4xWDEvTytSZkkvUHJMell0WFprb2dW?=
 =?gb2312?B?aDBoc0lGcWVzeUs2bVJ4NFkxdWRyZVlEWWRvNHhBRlQreUd2ancwM1R5V29K?=
 =?gb2312?B?aEQrL2JLRXhsOEFMRitPVndzU1h0RStIQUpLeXZMbEtYR3pENVZrSkFHckd1?=
 =?gb2312?B?QUxESHA2ZHJzNUJMT2tBd3dyd3BhUDVaYWZrakxtRUtWaGlOVmYvWExZTUVX?=
 =?gb2312?B?dE1qSkZCdTNieWNqRXFheHIxL2loSVFSQ0FkTnFvNmNuLzhHTWVoelFSb1Bz?=
 =?gb2312?B?dE1hT3F0MTdwcmZ4WFJZeWFMU0x5QXduUkJQYmJmYmpiNi9xRkNuOTZRK1R1?=
 =?gb2312?B?MHJSMmJ5ZnNwbnpVaytyWG53bFBQcUVnSDZVejY2dzQwdVViZ2pscUx4bTdF?=
 =?gb2312?B?WUpYZC9EdlVlb0lsNk16b0dQOEFzcC9semJTQlJ3dGdnNGNvVXJNK1lkcHpr?=
 =?gb2312?B?QnMxeTllS2g3K09vYmNLamhUeDVNNG5FYlpuQnhST3Evb0x2cmtQYTVJRVB2?=
 =?gb2312?B?ZFh4eGtBTk0rd2orNERCTEdsUk1FaHo3VXJtWVZNbm9paDdycm9iSXNtK25z?=
 =?gb2312?B?K0RhNzFZTTJheG1PdGR6ZnRMSGdZNjVQUU4vM1AwdFAzNGQyb2JjMEQrMmRP?=
 =?gb2312?B?UE1SakVxSFdGa1duVnhCTFQzR3ZUK0RKOGZnazVISElCR3lYZkVLelNnUGRm?=
 =?gb2312?B?MHlMTGYwNEg0eDNEVG1rM3R3WXp0b3lDc3h4N2JOVzA2dUVraWhSRVZCRE0r?=
 =?gb2312?B?bFdlSEdFcEtvVG5RYUkrekxJSW1KSWU1cyt5ajdrS3dUUlEwVUZiRHZLMGVk?=
 =?gb2312?B?eU5uaVdGWVFFMkh5OW1ZS0Fmd0xuSU9GVEZEeURSajhnV01vTGRrVzNsYnlQ?=
 =?gb2312?B?WkdmVFF3aXpnaXVHbVVpYjRlK2hnOExhd1p1Z0FEUVJuL2N6eUliT0w2cE45?=
 =?gb2312?B?c2FieHJNcTBCVHdFSHZ2YTRjOFp0cFFtb1lFSHdTTUNVSzdVSWtaUnNKc05D?=
 =?gb2312?B?SjdGbUJ4Q0ZYWTROWHgwRlJoQ3A0K1JnYkFVYS82QTZPeWF2Y0JGK0Q3VERo?=
 =?gb2312?B?bDVFeVhWWTlIODJGQ0o5TytYbjM1UnU1dGd6dXlxbTFHSU42azB6SmtSL294?=
 =?gb2312?B?T1ZoZ1A0SW9kRUJiZFN0cUJ5UW5SdDBaaEN5SXJpaDBib29KL3Q1ZUxkU2Rn?=
 =?gb2312?B?QWd3b05HblhYenl1NGxDN3B5bzd4ek9Yb01lZnI5SjJ5SnJUdmlSQ0xTWGMr?=
 =?gb2312?B?eHVkNHFGQm5FdDljWGdNbVhvWW1ySDZ6MGUrS0dqRlNCVEZuKzNUeFdQOVJy?=
 =?gb2312?B?NFc3Ymw3S0FXaUNnV3RPSy9LYXBZT2wwdXFKTG9nRHE0M25jZnRJbWtkT2dk?=
 =?gb2312?B?VFZrZHBJOXdmSmd6ZUJwbUVsMnd3emY1aXJXaGp2dkJiOFZuaHp2RFltMUMy?=
 =?gb2312?B?QXcxNHNlYmdKem9YOTR4RGRuOEx5UkQvMWRpdUVRREZpdjJxcFh3WUEwM09u?=
 =?gb2312?B?K1FBY0RZV0JpUWJwcklGSnl4MmZ6Yk5HUWwzWWptWkJOQVZQWWFmMVBucVBJ?=
 =?gb2312?B?Ym1sbWlEWVZZTjhUYXgwYko1TFJpTXZRbDAveGpEZXN5Y2JpNWpRemlhaE14?=
 =?gb2312?Q?QHwzmpJWG9mW/JirIn9bipJYh?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc59c48-e78b-49d1-d132-08dc4c791c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 03:10:23.2683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk+0bxMpqt008GFebCW0LTzH8w85T4rD3ZzLRZ8T2tw/tcsniyB0isY0Bgzm6C6K/6TZaC7vPmYEWEw3ECcO96u64aTuqIPmtFaMbKQKcMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0534
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

DQoNCj4gDQo+IFRoZSBNaWxrLVYgTWFycyBib2FyZCBpcyB0ZWNobmljYWxseSB2ZXJ5IGNsb3Nl
IHRvIHRoZSBTdGFyRml2ZSBWaXNpb25GaXZlIDINCj4gYm9hcmQuDQo+IA0KPiBXaXRoIHRoaXMg
cGF0Y2ggc2VyaWVzIHRoZSBWaXNpb25GaXZlIDIgVS1Cb290IFNQTCB3aWxsIGRldGVjdCB0aGF0
IGl0IGlzIHJ1bm5pbmcgb24NCj4gYSBNaWxrLVYgYm9hcmQgYW5kIHBhdGNoIHRoZSBkZXZpY2Ut
dHJlZSBhY2NvcmRpbmdseS4NCj4gVGhpcyBpcyB0aGUgc2FtZSBhcHByb2FjaCB0aGF0IGhhcyBi
ZWVuIHRha2VuIHRvIGhhbmRsZSB0aGUgZGlmZmVyZW5jZXMNCj4gYmV0d2VlbiB0aGUgVmlzaW9u
Zml2ZSAyIDEuMkIgYW5kIDEuM0EgcmV2aXNpb25zLg0KPiANCj4gdjI6DQo+IAlkbyBub3Qgc2V0
IGRlZmF1bHQgZmR0IGZvciBWaXNpb25GaXZlIDINCj4gCWRvIG5vdCBvdmVyd3JpdGUgL3NvYy9p
MmNAMTIwNTAwMDAvZWVwcm9tQDUwL2NvbXBhdGlibGUNCj4gDQoNCkhpIEhlaW5yaWNoDQogICAg
SSB3aWxsIHRlc3QgdGhpcyBzZXJpZXMgcGF0Y2ggZmlyc3QuIE5leHQgdmVyc2lvbiBwbGVhc2Ug
Y2MgSGFso6xIZSB3aWxsIGhlbHANCnRvIHJldmlldyB0aGlzIHNlcmllcyBwYXRjaC4NCg0KTWlu
ZGEgDQoNCj4gKioqIEJMVVJCIEhFUkUgKioqDQo+IA0KPiBIZWlucmljaCBTY2h1Y2hhcmR0ICg2
KToNCj4gICByaXNjdjogZG8gbm90IHNldCBkZWZhdWx0IGZkdCBmb3IgVmlzaW9uRml2ZSAyDQo+
ICAgZWVwcm9tOiBzdGFyZml2ZTogZnVuY3Rpb24gZ2V0X3Byb2R1Y3RfaWRfZnJvbV9lZXByb20o
KQ0KPiAgIHJpc2N2OiBzZXQgZmR0ZmlsZSBvbiBNaWxrLVYgTWFycw0KPiAgIGJvYXJkOiBzdGFy
Zml2ZTogc3VwcG9ydCBNaWxrLVYgTWFycyBib2FyZA0KPiAgIHJpc2N2OiBzdGFyZml2ZTogYXZv
aWQgaW5jbHVkaW5nIGNvbW1vbi5oDQo+ICAgZG9jOiBkZXNjcmliZSBNaWxrLVYgTWFycyBib2Fy
ZA0KPiANCj4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXJjaC1qaDcxMTAvZWVwcm9tLmggICB8
ICAgOSArKw0KPiAgYm9hcmQvc3RhcmZpdmUvdmlzaW9uZml2ZTIvc3BsLmMgICAgICAgICAgICAg
IHwgMTAwICsrKysrKysrKysrKysrLS0NCj4gIC4uLi92aXNpb25maXZlMi9zdGFyZml2ZV92aXNp
b25maXZlMi5jICAgICAgICB8ICA0OCArKysrKy0tLQ0KPiAgLi4uL3Zpc2lvbmZpdmUyL3Zpc2lv
bmZpdmUyLWkyYy1lZXByb20uYyAgICAgIHwgICA5ICstDQo+ICBjb25maWdzL3N0YXJmaXZlX3Zp
c2lvbmZpdmUyX2RlZmNvbmZpZyAgICAgICAgfCAgIDEgLQ0KPiAgZG9jL2JvYXJkL3N0YXJmaXZl
L2luZGV4LnJzdCAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRvYy9ib2FyZC9zdGFyZml2
ZS9taWxrLXZfbWFycy5yc3QgICAgICAgICAgICB8IDExMSArKysrKysrKysrKysrKysrKysNCj4g
IGRvYy9ib2FyZC9zdGFyZml2ZS92aXNpb25maXZlMi5yc3QgICAgICAgICAgICB8ICAxOCArKysN
Cj4gIDggZmlsZXMgY2hhbmdlZCwgMjY4IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKSAg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGRvYy9ib2FyZC9zdGFyZml2ZS9taWxrLXZfbWFycy5yc3QN
Cj4gDQo+IC0tDQo+IDIuNDMuMA0KDQo=
