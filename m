Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FE8FF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271538429E;
	Tue, 28 Apr 2026 05:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EV2XUC4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1690E841DF; Tue, 28 Apr 2026 05:23:31 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A5E84277
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MROIAADaeM8gYAysw5qV8ya5SuTJSKYmpTMzpV4gSg7GDLXUpTtOwmNAjyMFlRBSmWFqP8rkqHTByvOwgnLqnyTWhaBRVOH2MNSPGOEdrcOXChfMOSU1C8DYU6+co1+NiNmkdX6+o/TfZF+xtXTc80wdampB4lxtQFoZj5ZJOZJOcZGgQ8iBhNPwusUy4n8wbXF7hvda9AW43VLqmRyHyimydkC8h0d91WDkTcNWYeMuL09KKnxdQ0w5/e/Qu+uRYjNe8eNZdumj88Z9KoFBqGlnLIivUOg/YYCAJD6hSf172aGWRQu6jPbSOyEhFRYoT5awp1MwKFMa4mEvvM4DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCe4p18yZ+DoKEkZFLqk7VIiaNV62wsMPitdtHAJ9eM=;
 b=GyPNYGf8jzmWdStCIoXkpOdotDDgI7f5ErjsA6NPvMHUcMb9SYlCvCDUA1iR0pieptxepJkHFjHfrf2AyqeiYp5VsQdV9ymfQEQOtgsQaOhW1rzZnpfrD15WAyswiYDdiMFsb6ShwCA4Qjpw1slL3HC8ZGpFKDOyZr6JkJbMAwqyqzBZuQvE3MqX31AYcMIKar537w2IPrej7eeqGnYwIc+3+Q9hwZn7u9IPpvIBHHN0SLbo+O/U0yH+CyYTavaVDwAmALpH+9xQS7Q9iLQa9Rmd+X6UCEF/BEZjanqKXYijzG0D8x7+d4QOtmPtmFwrhS3su9HiS8+B73C/kL110Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCe4p18yZ+DoKEkZFLqk7VIiaNV62wsMPitdtHAJ9eM=;
 b=EV2XUC4n3kwlzvoqAR4zCVNZXrdOX2r+Tz6cPBYAGHBldOg6qzkN6sCecxcTjmkGnTTwiZm02GQh2skmHqY+C2rEdWZuLxaNXz+Powr/79ktOigKVaFDKPAoE4Inp+Xqf94CF8uB5tdSngjml36JMgk35Dr/CSHvOEDzgFd9vZZhzfMmByaL/+bN14icgRMZQ/ZxLXrQeokht5xwGPvbBlZGootKi5WQDzEjdbULiT7VRDMf1CPajnMoGI5Y8O7Lth6gXbcJGFwYrH6yIM+aHVWT0hQiwnl0MzHCXNu0SK8gjEiMSmEpIABo9AQQcRQblzP41hWbjHt6/aEv1uffcQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5266.namprd03.prod.outlook.com (2603:10b6:a03:22d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:23:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:23:25 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: Re: [PATCH v1 7/9] clk: s10: Refactor S10 clock driver
Thread-Topic: [PATCH v1 7/9] clk: s10: Refactor S10 clock driver
Thread-Index: AQHcwxEw5eFJls/k7EayB5nDHfrqPLXpXOkAgALxxgA=
Date: Tue, 28 Apr 2026 03:23:24 +0000
Message-ID: <e659171e90784f2d9d42e442cc27e1eac23f9374-544b-4ea7-a26b-61b62c5ff5f0@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-8-alif.zakuan.yuslaimi@altera.com>
 <c566d6bd-ae38-431d-a43f-326abdce3e69@altera.com>
In-Reply-To: <c566d6bd-ae38-431d-a43f-326abdce3e69@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-clientproxiedby: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|BY5PR03MB5266:EE_
x-ms-office365-filtering-correlation-id: 0ccd9929-6789-4b0c-8346-08dea4d5820c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: W8/+x+TsvQ1yNhqm4tyhMhV+cx9AVRLy1gu8WREH2j9PimQ8VcHNZEFTUHYD0PMSR5Dtnd2jJJ0DAf2HKtMbCHHQ3mlVb+VUS2LJw2JBaxPqGhdjOzPKWISxkKL9+xc77lL7NHrsW+7wuoKR/ycChJ6IUxJqq85msoirxd12OEW+RM7cifzA2RJ2mceT8vgq7xlrwAQSR9PzwDkVN+CbxKro7eu7yQaVzv2ND+FIrM9NGsyn/+Fk5ukPjKsGN+V0J0xb1F+Xd9lCK+Cp92wG8WcDdEcLmJ6Gk1tpiVOBIjQUWYlMuwF9W/p050OSiixAli7qBQ7WEAr0JqSDSe5lR2ACMznOR2UOZn8bOTtRcWs/4CfALaKztt9tw4rGLc/WxZAvWpkSTaKFvsoq5mpz/mJysE7KWzKNSPjidp29Qre9yYYlxD7y5Pbrs++uUb2iWDfvLOdOKOKFMsJQcM+9OFa4FEDm2mPNan+3mUk+PdeHFMAZOZ70FTxK4h+BCIoVA8A+12RG57U2KWX0WuVNoHE/XIJCKuGxTC4N/ythih372tfgvRD3oQ5vjCH4iRbsYi09m9CtZMa5Dvd7UWg+Qku/Jf1xqTIC/XKU7CFOBaqxlmPpZUqega1x9isBHlWGYEOA/+7tO2rdOb9A0p36cEVJf3QZ0WbtGvnGXX2Ni9BsYcLksVLH09OLY5d08pgWjcj+1YxJ1w9Nf7hzsKHgIYUtcrFiOmR2ODT7QT09Fl8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uFBxeifyG7vpl9/KeTeLkQaA7U5OeowN0lBzKZBNkHiXfdUGF98w7+0JPx?=
 =?iso-8859-1?Q?cq9RsH9CXvSLaLN+5etmIJ6QrDRE86nBRCZg5cpK854v5dexBVJbPtx4Ex?=
 =?iso-8859-1?Q?+HJ7j0iPsHoAfzgOda5lGEv7zmArCyOg21dBlHy93FaIJ//vEQCzZStGH4?=
 =?iso-8859-1?Q?UFv5KWKUqpNn/GCcqyXx/JtCwIaMXfQM5tUTYSEH0bmRTL6EQWYOFQbd6s?=
 =?iso-8859-1?Q?EkYH+RmOlo3/W+ufwJfxm/RgJ0Vdi3OtpWtvE9mR8gw30lPkQFVfS2xjug?=
 =?iso-8859-1?Q?7ZQ3BoX7EtCUfPj0Z0cGHKcfNDHy9pLoL92LS26l/ffab8kGAMeJ7hKl3L?=
 =?iso-8859-1?Q?havKoGxKSofjJyo0ZpZfjgMQJWBwBlGXJIkm2rMCLZZzis1uBe+i/EQCyC?=
 =?iso-8859-1?Q?X7AvDEqD/X4zMF0sCVajzkDqm1zY67SphLpSQ2ACnW+kwfRXcEz2hGAgt2?=
 =?iso-8859-1?Q?9/xCGhnrX6fcxlqHbdyeWt9sfIIWomq7xQtE47/6reoC0T+bAC1L7iYzmu?=
 =?iso-8859-1?Q?XJe8GL62V+Ws5H6iwvJjTJKj/W5r2h7yRNnNoO+l4PEjZENO0TAMZZTrxc?=
 =?iso-8859-1?Q?Br00VJ6eI4V2e0dEoT6wCQUrSHZrDizVwQIaSP7uvZzpoT7f2gdVTps5Ps?=
 =?iso-8859-1?Q?85HKK8rHuA2ZRSHFeFdlkCR8usx7L65Y2DtvLoL2KfSSSVbctCa07Qw6UU?=
 =?iso-8859-1?Q?zMoycEEfVlZp6+fxFhp+8jATo3aWB7F+aRl6a0o0HdM1RyuNEZ5zdS00VJ?=
 =?iso-8859-1?Q?fdFBlr8w9rbJBQbLQqamCarGeSJwFjrwzTheCJUi2btean11SHcYf0LmuE?=
 =?iso-8859-1?Q?XNKT31edv3tpeP9a4r8mzzmWbluW3zwPk6rDd1Lf32V0ex/xII1q2JT5KC?=
 =?iso-8859-1?Q?1R5LgKNYi4QFuxuYz63UrySuyso+a2UZEHL895rpYE/CMXdpwsJ89CJfdS?=
 =?iso-8859-1?Q?hy1Zp094bDoMDkeGavzPPj7BVfWpxIhfMFe8QLOQRBq7xoEPKVbl7/2Iw9?=
 =?iso-8859-1?Q?hnum8hC18CAZMvLpMz28Z8VeeOWJC/LDUAU3Cqp9YxtRRRPVR57DN2+Yls?=
 =?iso-8859-1?Q?6OwsxpmPtcrLjW1BulCAx03/TJvyVR3qi8d9F3KX933xUblnG0FHqlv71x?=
 =?iso-8859-1?Q?jd3ArMydthDBNgTCF2zmsCGPgVR4jXeifgz982+4OBe6p4QR98GNxz9TLu?=
 =?iso-8859-1?Q?29MHRG0CfDnxZIYVSbPvKu0Y2rG3ceKRGWc9soI6VuXqniGAP7w5FTuwqw?=
 =?iso-8859-1?Q?AI7sPcSOT0LeXEZCS0QImz3IEpj8d76w3V9bSagfR38jiGq7XrNi2lNVWU?=
 =?iso-8859-1?Q?OwaQjxvWaW2k7Y7vK8BJvjRKuUK0TsT49gVpi6cO0p9N0O7Kss/Dao6IOI?=
 =?iso-8859-1?Q?lG5v6SvrU7SoYutTyYuZtyPYnXAqn4AGTZESXn4YYwGuMqLtHNSAZ4R2yv?=
 =?iso-8859-1?Q?rCXEeikuZAWDSfyvvBi9oEuP7wSubg8c9ER3tyC96SMsh4WTcR6ZiclPx3?=
 =?iso-8859-1?Q?LCVHj/v6BYQ0HHaz5p7pyfOS9uwhZCuiyjULW6KbVF3VQBR6iWZq26k0IE?=
 =?iso-8859-1?Q?6CUCN0ufVGXeQ7+kQ+uz0RXStIxN86X9mUFmfU71gI7XFtTjWOJs/XUueA?=
 =?iso-8859-1?Q?oCW3NNqfu1diFHfGbMiwXvKtO3lUFGH2cpFctaqY7LtOBO6d/868eX8lNn?=
 =?iso-8859-1?Q?vdRqMk0DgVHLL9/Df4AqYcrl7ALc0qa/pcOBfHvTWN/xUdKorbktp5ihZa?=
 =?iso-8859-1?Q?yEjTrCQOpsSOXpUOIc7tQIWMybyjZcorWiOZws5kx31OlgsG1XgaAsBZM5?=
 =?iso-8859-1?Q?Ul2mFWwlWjLp3cChBgbVg4uBxl+EQc4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A92FDC019DBEF144A89EC6DAEE05F729@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccd9929-6789-4b0c-8346-08dea4d5820c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:23:24.9863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z46rOxmJ31f247M23JfhE0Un5Jrx8JEuoMMEQd/nJFkztNBd91Ll8lXCLpqakYfNNRhcyc/qUbPEh3NVgKT1ZImw060fcjz4lfy3cw6D6GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5266
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

Hi Tien Fong,=0A=
=0A=
On 21/4/2026 5:30 pm, Chee, Tien Fong wrote:=0A=
> Hi Alif,=0A=
> =0A=
> =0A=
> On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:=0A=
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>>=0A=
>> Refactor Stratix10 clock manager driver to support driver model, =0A=
>> following=0A=
>> Agilex clock driver.=0A=
>>=0A=
>> Create a new clock driver, clk-s10.c, for Stratix10 which supports the=
=0A=
>> driver model. This allows several APIs such as enable/disable clock, and=
=0A=
>> get clock rate to be supported.=0A=
>>=0A=
>> This driver will be initialized during SPL to bring up the clock as earl=
y=0A=
>> as possible. The clock initialization process are refactored into this =
=0A=
>> new=0A=
>> driver from clock_manager_s10.c during clock driver probe.=0A=
>>=0A=
>> Excluding Stratix10 from legacy method of obtaining clkmgr base =0A=
>> address in=0A=
>> mach-socfpga/misc.c as the base address is already obtained during clock=
=0A=
>> driver probe during SPL initialization.=0A=
>>=0A=
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>> ---=0A=
>> =A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +=0A=
>> =A0 arch/arm/mach-socfpga/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 2 +=0A=
>> =A0 arch/arm/mach-socfpga/clock_manager_s10.c=A0=A0=A0=A0 | 449 ++------=
-----=0A=
>> =A0 .../include/mach/clock_manager_s10.h=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 17=
6 +-----=0A=
>> =A0 arch/arm/mach-socfpga/misc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 3 +-=0A=
>> =A0 arch/arm/mach-socfpga/spl_s10.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 7 +-=0A=
>> =A0 drivers/clk/altera/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 1 +=0A=
>> =A0 drivers/clk/altera/clk-s10.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | 591 ++++++++++++++++++=0A=
>> =A0 drivers/clk/altera/clk-s10.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | 202 ++++++=0A=
>> =A0 9 files changed, 861 insertions(+), 571 deletions(-)=0A=
>> =A0 create mode 100644 drivers/clk/altera/clk-s10.c=0A=
>> =A0 create mode 100644 drivers/clk/altera/clk-s10.h=0A=
>>=0A=
>> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>> index c58d8f85e33..863e0b763d8 100644=0A=
>> --- a/MAINTAINERS=0A=
>> +++ b/MAINTAINERS=0A=
>> @@ -159,6 +159,7 @@ F:=A0=A0=A0 arch/arm/mach-socfpga/=0A=
>> =A0 F:=A0=A0=A0 board/altera/stratix10-socdk/=0A=
>> =A0 F:=A0=A0=A0 board/intel/agilex-socdk/=0A=
>> =A0 F:=A0=A0=A0 configs/socfpga_*=0A=
>> +F:=A0=A0=A0 drivers/clk/altera/=0A=
>> =A0 F:=A0=A0=A0 drivers/ddr/altera/=0A=
>> =A0 F:=A0=A0=A0 drivers/power/domain/altr-pmgr-agilex5.c=0A=
>> =A0 F:=A0=A0=A0 drivers/sysreset/sysreset_socfpga*=0A=
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ =0A=
>> Kconfig=0A=
>> index aec0fb7b1c8..c7ecdc4055f 100644=0A=
>> --- a/arch/arm/mach-socfpga/Kconfig=0A=
>> +++ b/arch/arm/mach-socfpga/Kconfig=0A=
>> @@ -149,8 +149,10 @@ config ARCH_SOCFPGA_STRATIX10=0A=
>> =A0=A0=A0=A0=A0 select ARMV8_MULTIENTRY=0A=
>> =A0=A0=A0=A0=A0 select ARMV8_SET_SMPEN=0A=
>> =A0=A0=A0=A0=A0 select BINMAN if SPL_ATF=0A=
>> +=A0=A0=A0 select CLK=0A=
>> =A0=A0=A0=A0=A0 select FPGA_INTEL_SDM_MAILBOX=0A=
>> =A0=A0=A0=A0=A0 select GICV2=0A=
>> +=A0=A0=A0 select SPL_CLK if SPL=0A=
>> =A0=A0=A0=A0=A0 select ARCH_SOCFPGA_SOC64=0A=
>> [...]=0A=
> =0A=
>> diff --git a/drivers/clk/altera/clk-s10.h b/drivers/clk/altera/clk-s10.h=
=0A=
>> new file mode 100644=0A=
>> index 00000000000..f5be1e68500=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/clk/altera/clk-s10.h=0A=
>> @@ -0,0 +1,202 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0=0A=
>> + *=0A=
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>=0A=
>> + *=0A=
>> + */=0A=
>> +=0A=
>> +#ifndef=A0=A0=A0 _CLK_S10_=0A=
>> +#define=A0=A0=A0 _CLK_S10_=0A=
>> +=0A=
>> +#ifndef __ASSEMBLY__=0A=
>> +#include <linux/bitops.h>=0A=
>> +#endif=0A=
>> +=0A=
>> +#define COUNTER_FREQUENCY_REAL=A0=A0=A0 400000000=0A=
> =0A=
> =0A=
> COUNTER_FREQUENCY_REAL 400000000 defined in clk-s10.h but never =0A=
> referenced in clk-s10.c.=0A=
> =0A=
> Example: https://github.com/u-boot/u-boot/blob/ =0A=
> e3405917a1806971d9e72a94186b299f05581e1a/drivers/clk/altera/clk- =0A=
> agilex.c#L357=0A=
> =0A=
> =0A=
> Best regards,=0A=
> =0A=
> Tien Fong=0A=
> =0A=
Sure, I will implement this in Stratix10 clock driver as well, I will =0A=
include this in v2 submission after testing this.=0A=
=0A=
Thanks,=0A=
Alif=0A=
=0A=
