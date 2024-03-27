Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E8DC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 02:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7463E8812F;
	Wed, 27 Mar 2024 03:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="m9eiS0fq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B508F88080; Wed, 27 Mar 2024 03:03:29 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0723.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9550F88133
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 03:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8ITPZeH0dcr3VSavqiFR7PZ05b6/WhFh3kAgZXtnonkZu9M4U83FdVHRP1YfAO4bNGYSgXUs6r6d+IDAsiTbe8zOaQm/F60D2O9+kSvLmQCZq32e//7/yEQoF8SRXoQahJJCwXzCypArd9RQ1ai4KMsRxUYpFuzpYoMtQzKHYJtxM9nqW+rGanMrKcy4s3it0du2xBJ18LnSbg0QcObK95nY8Ut2kOVSb67dn7ecJAGb+2o/oAJQ4YGm9rE0JrUVAgVn7WRz31kWRuDnpAu+Vo67FjGwetv5AbBOzelLS9k0wiHm9ODIs1kUvFp0sYnSh2cejNhp93NGApGkfAlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQVF0r3wJzhCc+Auyj1rzMOAWnY7jb3/xMczqEo5pnM=;
 b=Penz3AJ2BYzKMisIfTjRkVkPAHS+lWxzPJeI+p7I8OG+tBgc7sGoE5lEeJLMN/OLNGHXLodCi8qrZ+hznIKtQpbnlhYcoXs5fjbWXUh/rpcNLS5w4kJiU+z/9n59EvjT8uWUGcFLryKO2jvmD+5OkLLx+xf8PdSWcSZq9XUAWrPYyiMY+qXswH8J5NY8L5LJ7twf2SVsYhRchzz71RXCU9dOTtocG4s0jicdr2K40DRTA8UNunRcJjgwoFjTinQT14Ft3w39jFfR4vE2SwQcBvyS46CderKblNs4iZYt1nUDczp/n0QYpx+OkLgx1ibbwXqAN0T9DgZvx1mKoN3WBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQVF0r3wJzhCc+Auyj1rzMOAWnY7jb3/xMczqEo5pnM=;
 b=m9eiS0fq7kAQ8YEsNyqQCBl+e67Eas03mGLR4uyukdt5+WPPIuSCgyPiRzNqxq0cdBkIvyh47THJM8lJdnC7oMDDrlLtRbQTCfsKcHQkQ/BISVFuTeJ+YKZcb2VDHkdF+zXjhc3m5OQain0o1JCIxJBHGfLkDv87OwVjL/tp8n4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 02:03:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 02:03:25 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, Jacky Bai
 <ping.bai@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "saproj@gmail.com" <saproj@gmail.com>,
 "judge.packham@gmail.com" <judge.packham@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v3 3/3] configs: Enable RTC pcf2131 support
Thread-Topic: [EXT] Re: [PATCH v3 3/3] configs: Enable RTC pcf2131 support
Thread-Index: AQHafy33VEJrS7uSkU2mMluKt8XfarFKlt4AgABAXUA=
Date: Wed, 27 Mar 2024 02:03:25 +0000
Message-ID: <AS4PR04MB93860A28F4EB5EFD274972FFE1342@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240326033801.228419-1-joy.zou@nxp.com>
 <20240326033801.228419-4-joy.zou@nxp.com>
 <CAOMZO5CQrHf0Qwx2A1wR5yFqC2GiHJ3yza7LqL1kib0LvyKrYQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CQrHf0Qwx2A1wR5yFqC2GiHJ3yza7LqL1kib0LvyKrYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|DB9PR04MB8250:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAKKXULwO8TikBTGGFLeAg3TPpSw+sKQMaJwv8VOGd4azuXlgUo/91GVkWA9Sezk8NI1tq3jCsW7rI864ZjRrACD+k2MEvpx9P34d7+ZCFMyKjLnVcRImA5C8q7i+5AbnfesmAPQQ5QdLQq0Rw0ZeVR++8SQ/SDIxqQBoUq3uvXRU25z44MmZd02/deEqCABVCeDV8ol2aTg+MFkkIlhdQwlkaGHHdlkUQ6bnbllJBJoVWSAdlk+qH1+MSpkUJ9UH2ZDw6caPDD3alhKHWtFvUJIOg4eeYoWkIcGl/161CGQ3AsDFWuoQ3rS73sEkKsZz0MNvgU5wYFdlalAbM+HBfynAEprVOaACUs2hhUXuO40PBB45pzvnE/Bqh9IQR3+g4OFsIRtM12KIF9iZVF9IMX6kTD3O+2LWLCapL6TZTvO9A/2ObYYWe8Jfpdzlw+fn8vRpnHlNW4822rIzXenTKzwh1xHiCuBfEGUY+bKzNGC//qfsw4Wzini6wVl27uiQ3qtxWLr7VNaB9wMz69o/oE7FZpNEnyt3WYwab/24E6r0eVQY2dRQRgKzAH51mTlhEyxXirfZ7CBTEfOLB5/x5PkFsHHHSN+kzafoNVlIW1sgEs0d5viXOF5DhTkNo4hV8NWV8dX/KFHuI7YAuBTWEEbW166IXoUKMdYtq5if4c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STdvVmEremRIM1h6eHVHSTNWbzJpOVpnY2ZXckNTTEUzbGsxaHJvSFY5SlFU?=
 =?utf-8?B?RWhRY1kxazNMSTNURU12bVQrMTQ4V3VXakpKckszTCt0aXUzNUtiZm13MWYw?=
 =?utf-8?B?b2UyNGpHdmdpLzBVckhCOEFZR1J5K0JTNWFHa1B6L2xmSTAyOVRMS1VHVk0z?=
 =?utf-8?B?TEVqWnlLZFpwTWQ2ekNlTjc0VVowQ245dmtNcExUSFRkdHpMTk9PVjNPTXNy?=
 =?utf-8?B?RzJKbE80bTg5dXIzOWR2QnU3TWMzZFNVSUxaQkhoRWlCdFNEdHJyU1c2bmFx?=
 =?utf-8?B?WE16MDE0UUphNEVWZ1dnSGswdStJRFM3YmJsald6SlA3eWQwc0xJV2w2cjgr?=
 =?utf-8?B?SndINEVQVGRSVktFakFPd0QxMUduMlQ5bUU3TTBtV0poVXpJR1E0WFJxYzFX?=
 =?utf-8?B?SkU3UTQ1REliYkNWOUhiL05acTF2OFppeDVHdXovVTk2NmZqMFV1MGU3SXh1?=
 =?utf-8?B?VGw3ZWc3OUk3cTEwWE1zVlJrQWxZMHRaOFJ5TDF4eEVOMlNuNWVKVmI2b0Y0?=
 =?utf-8?B?NjJYdVVLajZrTFF3eGJaeHlkK3lXZkt3eHgzcHlMVlNIRGdUQ3NUckozK0ph?=
 =?utf-8?B?WUYxanIzMUpBRnVxSE90a1FJcW0yTTRRZzcxNXczdFJ6QThHRW1YYk92OWpl?=
 =?utf-8?B?NFJucWVyWUd1YWowVmVmWnhyOHBjSFZONW54VnRqVVVaaTNBQmNlQmVtU0JH?=
 =?utf-8?B?OFFtS1lhZUZUdHZrQnhETFFJU3Y1MDhzQ3E4M3VOaHF4Q2VQanFKTDRzRlNw?=
 =?utf-8?B?WlpjekU1eFF3bm9tYlB0K3A0MDI1eHJSRTRDNFc4M1M2eDlNd2VCWXFzVHo1?=
 =?utf-8?B?RmR6M3BncE11eWxiKy9TYjBwTFZMNFdsWm9lemd6aVhwRnBhNFRpRFc1Y2Z4?=
 =?utf-8?B?MVBlZzBPNmJ5VDhZNWVTcHZwZ2xiM1RhY3JVVlBickpUcTBIMG53UnBScDlK?=
 =?utf-8?B?NW53Wmo3MittMzBaZ1J0dUJBNFg2T1RIaXVkVEwwU1V0MVpFY3djMFVpcVBG?=
 =?utf-8?B?WTNWQUgyVEtZNCt0c08yd2FWV1h6T0V0WXdJZERHU2RxNnIxSWE3OUsvY3h6?=
 =?utf-8?B?ejJDUUticFV6NGQyZmY5TjNUZFYzeU5aK0M5b3RwUGZWK1RiY3crRDJqSE5w?=
 =?utf-8?B?Y2lVV1AvdFplYzlvN3ZsVWpwTkh4QTN0c29Mb1U1TzBQb2pkU1ZlNHI1Ull1?=
 =?utf-8?B?Q0NPSFE2bGw5OHd4UVhWUkdtTmk0QUFlSGYraFgrS01KR2JLa1htd1NpS0sx?=
 =?utf-8?B?aUpLWFBtc001Nkt2YUJlRVd3eHpHL3Y4dzhabkx3QnJ0NDR5ODJORWtXNVo3?=
 =?utf-8?B?cGdaVGI1Q3NEak1HZkQ3ZDRqUzFNQVFxeENweTI2cDBBSGRUSURpRTkwb0lk?=
 =?utf-8?B?Ym5zbDFHVC9KRTQ2a09ZS1RaL0MvSnE2ZVI0ZGM1Mm1CUFEwdWkrdlFkd3E2?=
 =?utf-8?B?OTdkWWppN3JYeGtxMHc3UG9yYk80emVRUXRRN3Q1cU9xR3JjU1psdDI5WnZH?=
 =?utf-8?B?VTN3MjljVVI4bS9lZEt0a2JPZDVIZ1dTdmFhcitGZXppVUkzTzZ1VEVMZGlF?=
 =?utf-8?B?b0dSaGpGTllHSDJYeXF5MlhnOGZ6OE1lL2k4MG4yRW9hUzhtU3ZWa1E5VUxm?=
 =?utf-8?B?SWorMjVuaWJPU0xUU2Nqakg2anlORHVlZ0RjeGF5UTFkWVZ4MGNtNmRCQzNw?=
 =?utf-8?B?ZmNNS3huMnB3L09WWDI1TnZmUjJvYXRCMDJGaHl6dGk2eXZrbVEwUlhYUG9X?=
 =?utf-8?B?L1FMdVFwcCt5bklaM0ZUbXp5MldtV3lHeXRSUDZNc1dYbStnT0NCTWVwQzY0?=
 =?utf-8?B?T1AzQnNwNkp2eUtOOElXSisyeDY5NE1vL3VXcmpUUU1hSTVWYWJyL0dsa1Ft?=
 =?utf-8?B?NGtaOFRRam5VS0l6WnhuOUdvZHFMNkZMWUh2Q0FTUllYT0cwM2FzR1RLL3Nz?=
 =?utf-8?B?bU1PZnJnOE9RVEhySTczclNYSmphTzN5MVd4dGtPWlNoeGY1Vmlrdm9iT2NH?=
 =?utf-8?B?VnI1RmpWL2VoVUhSUDltTldseHhRenN3VzVNRSs4dUZWMjNjVWtQdldzb2lD?=
 =?utf-8?B?Rmh5bkJ4aDVyS0RZS3dyREFGZXJUZ2hRUVdiWXU3RXp3a2MvN1FSVmlHbVhp?=
 =?utf-8?Q?TTjY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5253db12-36d3-4ebd-e66b-08dc4e02164a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 02:03:25.0605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AfBVd+60Mnpu4TJCnqsQbulURqCQILmlMbZZctwC6gNLFLiiQ5U3eWkUVWJPRax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250
X-Mailman-Approved-At: Wed, 27 Mar 2024 03:03:47 +0100
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDPmnIgyN+aXpSA2OjEyDQo+IFRvOiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT47IFllIExpIDx5ZS5saUBueHAuY29tPjsgSmFja3kgQmFpDQo+IDxwaW5nLmJhaUBueHAuY29t
Pjsgc2JhYmljQGRlbnguZGU7IHNqZ0BjaHJvbWl1bS5vcmc7DQo+IHNhcHJvakBnbWFpbC5jb207
IGp1ZGdlLnBhY2toYW1AZ21haWwuY29tOyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAu
Y29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2
MyAzLzNdIGNvbmZpZ3M6IEVuYWJsZSBSVEMgcGNmMjEzMSBzdXBwb3J0DQo+IA0KPiBDYXV0aW9u
OiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tp
bmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0
IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiAN
Cj4gDQo+IE9uIFR1ZSwgTWFyIDI2LCAyMDI0IGF0IDEyOjMw4oCvQU0gSm95IFpvdSA8am95Lnpv
dUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEVuYWJsZSBDT05GSUdfUlRDX1BDRjIxMjcgY29u
ZmlncyB0byBzdXBwb3J0IHBjZjIxMzEuDQo+IA0KPiBTdWJqZWN0IHNob3VsZCAgYmUgaW14OTNf
MTF4MTFfZXZrIHNwZWNpZmljOg0KPiANCj4gaW14OTNfMTF4MTFfZXZrOiBBZGQgUENGMjEzMSBS
VEMgc3VwcG9ydA0KV2lsbCBtb2RpZnkgdGhlIFN1YmplY3QuDQpUaGFua3MgZm9yIHlvdXIgY29t
bWVudHMhDQoNCkJSDQpKb3kgWm91DQo=
