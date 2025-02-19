Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9862C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27A980FFC;
	Wed, 19 Feb 2025 14:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rh9H74GT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBDC809A4; Wed, 19 Feb 2025 08:25:10 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F74C800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT2C9LrIz9Ftswwn/c9w6xJmSCUv5xuy6exqPcneWRiUonMERH8nEQsb1B46kcFb0e2p99mtiKTH09p172SfC5tMBBpWsawMo2Jr+VxoxaoQGU3pZuDLpEBsNUScLT0b/5Q4TuukI0mObi4mtvj05R33P5ac22LoaVFjapYOnrewn652OMUOwEcyax8vmji+SIO+A4zC8CzfSxuJjJWBpZcoZfD/plZyXceX7ddQ4JELAO0onk65QJlnF2jhu4APo56P2IZwFiFwJBWPrlhEeNsIEsdY1aYUtXGLrGVSJZ+Q5Cys02vkYs2ArbypbCwUd7gBLsbBIFglBZDsNBGn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvyV4KgoEvizNLtthB+o62w5Bnygh7KVtNDndKfJyXo=;
 b=eyMC8OMKh3lwLX6GhHaE05h0dt6Hzi3Y6ibz1lOyKabcBQNzw44lJxe8lPB4wiWPCd0qkOi25dxOvaQYNSLO4DodWaY1QBi8xywgukz+hBoD69kNeYeiOkO9GRRuulCXDzDtIwl7+oB2lCntbtdfVPHxrgfVFFwkurRkWiTKD27BrlNleB59agiGachcOUMkTV9mvzBS58a9qG2x+3OlIEa2UxvtoXvSTUOEGyNaRywjC1wlD3I7pF0WXwoDrl8MbNjJFYbuOpnelZg012dG8/nYJkmBeIhXSuwaMzw+k6AawLfxA3K7tHuc44BYeWQ6GoYfXxo8ohf4tcN5l9qjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvyV4KgoEvizNLtthB+o62w5Bnygh7KVtNDndKfJyXo=;
 b=rh9H74GT806PTJu1KXi2g5aJBb9zdLbdmDl9E4GoahRuT8iUjRnIhzOSBa+ABuqH/ROuS2p5cGt6NxDqZpeQgnXLokrAdTMYypakBj4qjLFccNyHX+8lNYx69OkmJABZxjgfOEzk4fqXX9iLnNjQ3ZkB0b9PFZezZBgxOzuQTNrzAuWQDtPt/ljlgg4s2yRHgRNfRmVbqm+saL7V/hCf5est/4r2Bmh/604MCsTL77YepXmUdPIiK1cCgJCXSd+Ea0WZRuxStUU0bcdFKkzWKUDAI0/AgGshmGX8hX6f+B8HNvdFkqZlCKN3iqXDSmTiK0cNbranzJ+TOZ7UK9S2Qg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:25:04 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:25:04 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 20/26] arm: socfpga: agilex5: Add SPL for Agilex5
 SoCFPGA
Thread-Topic: [PATCH v2 20/26] arm: socfpga: agilex5: Add SPL for Agilex5
 SoCFPGA
Thread-Index: AQHbgeAr1IS0rdQI/Uun+0fj3uxUVLNOOwFg
Date: Wed, 19 Feb 2025 07:25:04 +0000
Message-ID: <SN6PR03MB3583705968F2AB315E5C1F86A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-21-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-21-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: a33ab3f9-5abe-48ee-fa8d-08dd50b6877e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cqESgGQ7ltJ65TCqqMU1L/5zNgyPUHAj8p/jIrObW2bG06IlULhrRaIjXVkF?=
 =?us-ascii?Q?DltzX1hFrXGtQQLN6aIZUUsQjygzVmBRQgzMqe2rVJnFUUoNkCm0yRwfscy/?=
 =?us-ascii?Q?q/U61RHWjNFLC8PloLSmohqb0E7rRpTO6H9wLjlS83IQ1pMgx27W0orCDv3g?=
 =?us-ascii?Q?uHqIwLEJRTXtrp56zJ/3iOv9yslxCZGpFwiDpuJ2AIZXfDYvcbkZHWHQQHZW?=
 =?us-ascii?Q?y2Fn6C4XcvHlGt3PMkvyfT6gib8uGoTreLv3N+yTJkkNIiAZQ5JCKA2z/bPx?=
 =?us-ascii?Q?j2469q+ia8tgnRzktIeFDiD7qv/E+VJG4HBETNk+7w7Fp32I3A74y3/SBkOe?=
 =?us-ascii?Q?fYrUBNOmoDhTw2Vtt+ws+GbbcKO+C3dMKdo8xlreZf7ideP8WWcGoHoKCcuO?=
 =?us-ascii?Q?LvPrh1vIuLrJcesIXtHz4D+4lSFpbPEfNjWrubiNoSFIgMrbfwMgJHVNl4Z3?=
 =?us-ascii?Q?DJaSOAy+wbTuf6R+XxWh1/DwLGMuxrDo5Q7+5HC4KCiEAlx+eXVn6l3aN/PD?=
 =?us-ascii?Q?PAnL11faSmtWoQwtCYKfE+H5RXSpKGdC+c8T5WsER3S2C5DGDw62l7OfDPBB?=
 =?us-ascii?Q?peiS2ibNAPTA6l31ALuBj9AbJbBjgO+U2LzD7kPwZGKDEl72ke9iWbhmm6u9?=
 =?us-ascii?Q?/NnlIvD7qZe5E5cIwHVBNvDFdihRft/kFP68T269ASMqetvGOjjEFc8XjVsg?=
 =?us-ascii?Q?IaBbnIY/9N/NeN4HBRE7abyUT+G2DgnR9KJLHa+7WbYQDUHvfYNMmimFpSfr?=
 =?us-ascii?Q?udN/kOdI03ZH18TRVrmyBJKrqvlPAYpkwUuGmr0QKd+Apg3Bw0M6bO03CdTY?=
 =?us-ascii?Q?T49SKBtfmrHa5V2M8CuBmM6Q6inSJkYEAUlZFF3gm5Ga/oYcEqVudqRhwMi3?=
 =?us-ascii?Q?iOcDUFmylhyMaZ3UM20pxU7JNr6DsYDToPHicq3VxTUvD57FrpPOBXLlGEOq?=
 =?us-ascii?Q?yJlOB4TyHubgJLvx8AESQKPmyJSCD3QgXMoPMr09HkqjunCIM9vcc39rp2SR?=
 =?us-ascii?Q?tWzKCbj6EEbYo5+rcsRay40dPec8A7IyX3JXid7jM8Gp/9H0nkAxMcRxgKKq?=
 =?us-ascii?Q?mKqNuPhKoGtoyIPEGli6MqDxVEnY4j4hCKWkdsJ1MHgJWsjKiVp6cm924oby?=
 =?us-ascii?Q?hV8X9j8aQta7R2nT9B10jlqqVSVlJBI/jovcA35BlMWl3XU9TFLeD5f9eCOb?=
 =?us-ascii?Q?rJYe8VBMlvU8sEjLiyCQ6BWnqM0AYdLCmpNZkvS4YaX6mcrf4Unt96e5FJxN?=
 =?us-ascii?Q?wPp5r+cCmuEEsz7SHBuC2Wwku8wKFajhEN/opcHVkuF9rfsRoUYkgsQzTXI9?=
 =?us-ascii?Q?fQZJwZMIlykbCIzDcUxPg2OLt6l3UQ2aqSjF9idmRrXbM8xjc0yxJSC7QNt6?=
 =?us-ascii?Q?ktae+vmOSUaw+onq3N4F0vZuEjNq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7g0j5o+BWGd1HK93+4f1HfoGr4mhNW86cEccvJCqEdOMdCYf2LeBOKowvTMd?=
 =?us-ascii?Q?t5RcHAuqRZVGoEr/kBLoQo2Q1ylO7JnUwIBfelSaFgRwYANmPushFn20pARo?=
 =?us-ascii?Q?X+p9usCKEdnOLEzuXcTAJaiwqKGMZKLFy2yWZMuTDMGhVeAOGZTgX9Xu8cbo?=
 =?us-ascii?Q?FiAtjNHvekol4YL2lsPJMxyoidCBY6X2LMKn8KnvpP+737fWpZnh/4v0pRJ0?=
 =?us-ascii?Q?CnpQkYw0azfX+LeaIyrJPU9A3Y/KDoJWTf7BnCGZdDWALYTZK/QzoiPn0D/h?=
 =?us-ascii?Q?VviaoYRV7P/AyKO4qiu+GffX0r7POfSXY7QWj60SA1J8cFW7EvMgfujIuHZa?=
 =?us-ascii?Q?JKLCCt0RN9R/TKWq656wNDyNDCt3nE+JwCGZ8TeU9fHnMVgVbKNRMQe13jWQ?=
 =?us-ascii?Q?HUpMBzFiWQjbA75NVhBhCklligAA7Pr3q/+NBOaYDm83on0VxjoQpA5Lvqnm?=
 =?us-ascii?Q?I3bwL3j92HUl4AwITojmAjQTX0SplPjZvXNZ6TywBJVx7Zi3MMkl00h5TuJN?=
 =?us-ascii?Q?u9zcVAohqb89ZjmAKFGQfeN7XpYRRAfeQ4/8ghLl+fHZgOD9GAJHoRDbJunZ?=
 =?us-ascii?Q?UpyalptBb8MOwZkKwGKWHRfqMqHSiSFSQQ0p/wDQsUDJbVzAA+yMl0TDl18S?=
 =?us-ascii?Q?MMr0O8/mUHDxlowkha5aLiTwPh2LySlC8rROSCa8V8SFKqx0mDuSnkTpWLpw?=
 =?us-ascii?Q?hXtUrsLOIvtoyR/uFhk1OETgh98wrlf4ZYLCEbgjBQkv8q31ThAMwSArrIk2?=
 =?us-ascii?Q?o4J2GnBI2QkxBucg/PXAdzOolYKn2KMoyw2lUN+Z+YFMHNUUttryb0DOajxx?=
 =?us-ascii?Q?2amKBZAaeRztrEKqmWRVJ+qMTcDGkXU69CcZY8f1jkqMC66/TvmH+MQl4JeU?=
 =?us-ascii?Q?dV1vJzNOKKAM0u9UeWu4FE0a8uUh8u3/AML9g7m9Q+TuFtauxwDet38Qi9Hw?=
 =?us-ascii?Q?UztQ2RbH/6RTFHVpaNp7dNi0NehU9HQRaKg1MvFuXYGag9ZORamlAYWCYSZ6?=
 =?us-ascii?Q?cvbpZ7zy2B+4Qe0fBNc3Pv9K9toiqyzSWUbj/iNydxpWIBl0AkRiXILuj1e+?=
 =?us-ascii?Q?8r+beDLgINw0JlwQGGMIgHAEEp++GJsYEk1ZLqahiWexxf8T2SF2Z/vNnAeK?=
 =?us-ascii?Q?o4tnVFu4RAm7wS5RQmUG8bycagEUBs03CvPJpbTAE162e+2++0e8SJXhwi/m?=
 =?us-ascii?Q?3sptVmrL8luKe2VIqfHR/3ZKd/NHAD37uo8gtc12wHaAImdN+6uUxCpTN8VM?=
 =?us-ascii?Q?5EYTDR71BeXTv7tMJ+kBymFC0k2JtvtacsTHHJr/MUOYx6CT/M+tMh0X81Ea?=
 =?us-ascii?Q?4BJs0tXXCm0ifwPfqhqNiN2ucEp9roduJgI7BciPifmDcOqgOGaZ31Hxx3ve?=
 =?us-ascii?Q?lQlZxfCY3I26d+obpkMvPB2QCpW96ZXRKO2SzZOAxzvcmsvK4KyXTJ92vK8q?=
 =?us-ascii?Q?o9kWZu1suRYU605Fy0DVmAgufHTzlyXk3Z3ZEUfM3b45H0TzpWf+rhQQ8PzW?=
 =?us-ascii?Q?Dq5hv5qVk7/HcuFP9rMYUG3FL7C3E2/fCY+QjImlFf1qnhzdQMykpN3BJT/f?=
 =?us-ascii?Q?5sfmcxIt9oYfq/KZoOQAI3Y8Nb0jjz8KfWAq3Kto?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33ab3f9-5abe-48ee-fa8d-08dd50b6877e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:25:04.3375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkoh9NAPvwlMeFO55jvq8SLJDQ9NeXq2gXu0570bFwY48fR0T8Xn0ZgCOTuqBFfBL2nG8MMN3nPHz9nqhpdpd1Q8vxvk2pdmq1jVnLwz9xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 20/26] arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPG=
A

From: Tien Fong Chee <tien.fong.chee@intel.com>

Add SPL support for Agilex5 SoCFPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile      |  3 +
 arch/arm/mach-socfpga/spl_agilex5.c | 89 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefil=
e index b6897ba42b1..c038882e3c5 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -66,6 +66,8 @@ obj-y	+=3D reset_manager_s10.o
 obj-y	+=3D wrap_handoff_soc64.o
 obj-y	+=3D wrap_pll_config_soc64.o
 obj-y	+=3D ccu_ncore3.o
+obj-y	+=3D system_manager_soc64.o
+obj-y	+=3D timer_s10.o
 endif
=20
 ifdef CONFIG_TARGET_SOCFPGA_N5X
@@ -109,6 +111,7 @@ obj-y	+=3D spl_n5x.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
 obj-y	+=3D spl_soc64.o
+obj-y	+=3D spl_agilex5.o
 endif
 else
 obj-$(CONFIG_SPL_ATF) +=3D secure_reg_helper.o diff --git a/arch/arm/mach-=
socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
new file mode 100644
index 00000000000..c87e9ed1641
--- /dev/null
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <hang.h>
+#include <spl.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/arch/clock_manager.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/misc.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/system_manager.h>
+#include <wdt.h>
+#include <dm/uclass.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret =3D spl_early_init();
+	if (ret)
+		hang();
+
+	socfpga_get_sys_mgr_addr("sysmgr@10d12000");
+	socfpga_get_managers_addr();
+
+	sysmgr_pinmux_init();
+
+	/* Ensure watchdog is paused when debugging is happening */
+	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
+	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
+
+	timer_init();
+
+	ret =3D uclass_get_device(UCLASS_CLK, 0, &dev);
+	if (ret) {
+		debug("Clock init failed: %d\n", ret);
+		hang();
+	}
+
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
+	preloader_console_init();
+	print_reset_info();
+	cm_print_clock_quick_summary();
+
+	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-ccu-config", &dev)=
;
+	if (ret) {
+		printf("HPS CCU settings init failed: %d\n", ret);
+		hang();
+	}
+
+	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-firewall-config", =
&dev);
+	if (ret) {
+		printf("HPS firewall settings init failed: %d\n", ret);
+		hang();
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_ALTERA_SDRAM)) {
+		ret =3D uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			debug("DRAM init failed: %d\n", ret);
+			hang();
+		}
+	}
+
+	mbox_init();
+
+	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
+		mbox_qspi_open();
+
+	/* Enable non secure access to ocram */
+	clrbits_le32(SOCFPGA_OCRAM_FIREWALL_ADDRESS + 0x18, BIT(0)); }
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
