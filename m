Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8675FC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6A4809A4;
	Tue, 18 Feb 2025 06:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B734807F1; Tue, 18 Feb 2025 03:51:02 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAB580017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+BG9xF11eRBBnwlvyZ4bo2QgbGxBYQ4rB+di/L8pbs/4ya0fn+CZ7/CxxKjjxX3VpOlm0MCE9jPqCaHcdXSVEpe6MAb2bYTi+W9r4FtM/Tw647a1vi2Pgk5YKIcamoBiol8x3hv0kRGpuF4sLd//aOsLugW3e3ASgrJiDlnjMzlWV5I2ZOVkYqX0Hhq01e4KcjtHylky6UoINSc0P3JV0Nu7gQm0MY7K1bS9tG/c/yYqAyGTsC9qaktRa7TwUOFhNxoZyF0pB3lBX1v6COYCJEAe3XXxGUw5nKWvwnESMa1fnN2On5/eeL2KJUrGXFxagOySkTz6RT7t+Ul5WvzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTbKRgjaCCviSy0PD00tJzmi2YwZ+r4NycZmeKlNBqo=;
 b=kkdfhQRxn1EX0kyZpQXglXV0N8qepROyESjBhoOQJITtrLSCGzdVXg2zGafqwOFj3TZrItu2XDGyDSGMbkCYRVX5E/xILmR5JekOpGO2MXXfAPDgaks/G5g8SBEpn2c9oRq4iTp7B0NlszRZUfrOyQkVfFZJdqw5r1Sez+Xtro4P7cL5Gec/LcznTo+QDfN0o/A56XWE4JE2GinTYNShSsf5rEkH8bD3K7XFU2gLfj57Z58lYq4+9phSCercuRbAuOxeUbsbxo0rvgmNNGHTXou4B7dtJ7ayebWTpdIJ5J3wvJgBBIm0UxGLOXnqvHaZjXY8Tu87HKWUPmdrt/Qiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Tue, 18 Feb
 2025 02:50:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8445.007; Tue, 18 Feb 2025
 02:50:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow
 <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>, "Leon M . Busch-George"
 <leon@georgemail.eu>, H Bell <dmoo_dv@protonmail.com>, Andreas Schwab
 <schwab@suse.de>, Nam Cao <namcao@linutronix.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 0/4] riscv: dts: starfive: simplify binman config
Thread-Topic: [PATCH v2 0/4] riscv: dts: starfive: simplify binman config
Thread-Index: AQHbe62Pl3bR0UYeQU6kc3z5iy8NKLNMZlZA
Date: Tue, 18 Feb 2025 02:50:52 +0000
Message-ID: <ZQ2PR01MB1307D61EB29D1723474AE434E6FAA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
x-ms-office365-filtering-correlation-id: 085f17cf-bc3c-431c-6d9f-08dd4fc70f43
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: s6FsL7oAW3X63TVo06xf7wEEyEjojsxWhS5BUEDddNvK1LDAG8TJHaV2+rIEGYkSAGvjXf1geG+yJlNphz8aEKT5aHLolsqGL//8tZCgJWUSeWY+H7ew7oj37XSUDKVGegG4UfDi2G+qrbF5qLuPort4QXaXpcejM0xJVfapJ0MzPBmssUzbPbZYoFq9RUASR4kfHKRFFPoOfILvT/oMBT6O8KzcYbU2O80wB5h6FnRTz7bqGsxPcJAzs3+2cqjKoDByBg7hgJVufATS9IAJIBfVpTR9HEgZySiw0V3RksUWuah15E+teBli2aEMcmbmOzWDpfV+FdDg63v6eTiGRFGwjzbNFiNMhTdtVRACHUCESVOZ8Q3/oRdRXBTSenBeyYYhZ1s6ecIXk5S4GiahZYiOWrHRy2ETen1X5Trn3K6cU10eRAF5ul6uhRq6IFMI7M62JhJDEpIfNYFRZxFQGCceBST4iisAlRtCLK3PhZ0ghdYXhoES60q/K0v+csgea5sYZr5Djp/fS4z0E5X3QyKm91PLj4UPZ2Nsolg4emQrfrmqCDApS44juftBPn+kS6jAIgjBCwkrQo+WgCcZ3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(41320700013)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uOPHiTxwEuNU15/x3BuRLlJQbEDTalIuVPUaleDuYIGE+2Vl83Edg3dRZ4kd?=
 =?us-ascii?Q?hTZKrBjdiQ8i/HU2efkq1IuhsErOcV6jXJ2j1lK+kcY2zN5oReKrhdjuP+o3?=
 =?us-ascii?Q?yu9XZrOh4DDUr+zfZOwVnPyBwGoEIVNLFrqKisFQvPABxQlsDckQqj8ybJ8l?=
 =?us-ascii?Q?kVs32kc5AVamyP7JbATnJ+8Wfe7GcNCVGXYMDY4tgstdlwdTCQ4sCqt7Xn39?=
 =?us-ascii?Q?7z9e2RYVPKNMNIcCYRUftFdHV4OC1FA8hyda/ZxhLvismMNWZLJwD9vsqTK9?=
 =?us-ascii?Q?hka4ncna/SawEMyWhpVj70yxD6BfkNeWIiskivnxn77GY+n/2YGJi+UXV8SS?=
 =?us-ascii?Q?zq1VHuLss7l5S9RbhxIfYNUMKOan+xyLw3x2YXPQXqPOpsi/IZ9MiUxa8ztJ?=
 =?us-ascii?Q?idHO4jKrWg+ZGRUv79SS+fJMSrdN3gcjs1oSqCpqKz19ZG3X5hCtmFLqglRf?=
 =?us-ascii?Q?OhaP+Pw5rRm2jtqZsYoe8jNCNNh1y4tQ7pDWO2PqbbdxMZu7oqHuQ9sLoVzW?=
 =?us-ascii?Q?7EjqoWVhgZGMHGHrBA3oInhMHA9TzLQNqEXrXGJYxjdamdJ+87B50ReQdBTA?=
 =?us-ascii?Q?fdVpWjYqclZNxoPSSvOPwUd2ayAPyg9KR0Ban8FIYrZ3uLECOd3vC8NqRgNb?=
 =?us-ascii?Q?xXkuUqKygrGHrcWCu0GjuYomx/fwDkZnYmXtbQyc8gzIaiUxmBCCZdI3QxFn?=
 =?us-ascii?Q?wUHsoMwuWsGjkX1Iuh1eWDG0YhsdcQxkubqxmB+I59fttLbK+nULDEuF5D5o?=
 =?us-ascii?Q?6PQX4UkeTUjJTZwqo4KgDhaDBxSS3OI7iNo7Zcy2Qw+gY1llRx+MT2N/arEl?=
 =?us-ascii?Q?Y9F7TXrfonOGkuGSQZbE08XYCZTHnV+bDeO9488LdWy/fb/Eur3PsH0T6roW?=
 =?us-ascii?Q?RKClIFIATr+C0Dcn5s+7VEO9nts41Jkj4a3IuEg7fVpFJ23DoGYX6nWzI8Z/?=
 =?us-ascii?Q?3CSWlybfXMs5G5AzNTEWd3wsGL256Ixmlndi+RWeT0I6nM9MERhrVu5QXsAI?=
 =?us-ascii?Q?8GDFEdWTVWHOo7KwDRgIzF1NIpK8wShdEKhGTG96LI0rf6Eie/a4W3naNJ21?=
 =?us-ascii?Q?YqQw8kmngSQyL04TJIWeAQBkTtvTT6mNGSU5wT4FWpJST76VQKgRzE54+EI9?=
 =?us-ascii?Q?SQKC2AhSwG8QFefuRijWH8rcGCXQzIYGOO+O4iUeK1i5QFmnseqrS+4CzliT?=
 =?us-ascii?Q?A9ne5AHMBM8unuF/VHuC8f0g7AJAxuix7XCzg/ZwEV1gKoj065Wh6XdTxcaT?=
 =?us-ascii?Q?e1rT2jx5PhiLzlFICHCT12ULjzsTZa65i9aJ6VDVGUsvnHynxeg63MKkBz3W?=
 =?us-ascii?Q?8UdyIFbB2JLx9MT3RWDmfG7M1MKZu7009O6WXgi4YzCeGoqeEn46p8OufE7u?=
 =?us-ascii?Q?XrxZ+L34ZtnztWa1ceMsO+gPPt/HjsToY4sVHDQh+99zXTcfl6EuCardn9k3?=
 =?us-ascii?Q?ycZeUfhYQEeQk5Z+uuTZLKmleYcGGjH4y7naf4cMvH4PPVE7R0cx5xMy575w?=
 =?us-ascii?Q?crn/CwG3P1AkZWQdx4qz5ykJy2ji138a0MOzY0T3EeUW1P2O2EtEZ0hK/2sl?=
 =?us-ascii?Q?iXCpMO9m1Z1SzFUnnt6jmGH0K5TkyApKtd8CgVo4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f17cf-bc3c-431c-6d9f-08dd4fc70f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 02:50:52.9260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5fzOpwwJ18AV39DrL+e2yGL1bdwE1zbqA81bzYSaQvXrmZDAfgYMtSbLuCujdfxRN+ZZVu7466auHsxhNtq5Di49ETbGD1uqgqcKkKXseI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:44 +0100
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

> On 10.02.25 19:18, Heinrich Schuchardt wrote:
> All StarFive JH7110 are supported via starfive_visionfive2_defconfig.
> Up to now we have explicitly specified the multi-device-tree FIT configur=
ation.
> This more complicated than needed.
>=20
> Binman can use the information from CONFIG_OF_LIST to automatically
> generated a FIT image containing the necessary device-trees and
> configurations.
>=20
> This also removes the non-functional default configuration without a devi=
ce-
> tree that binman added up to now.
>=20
> Before the patch set booting on an unsupported device would fail in main =
U-
> Boot due to the lack of a device-tree in the default configuration.
>=20
> With this patch set booting will fail in SPL because there is no default
> configuration.
>=20
> v2:
> 	do not use a default configuration
>=20
> Heinrich Schuchardt (4):
>   riscv: dts: add OF_LIST handling to binman.dtsi
>   board: starfive: spl: strip off 'starfive/' prefix
>   riscv: dts: starfive: remove duplicate itb entries
>   riscv: dts: starfive: don't use a default configuration
>=20
>  arch/riscv/dts/binman.dtsi                    |  7 +-
>  .../dts/starfive-visionfive2-binman.dtsi      | 75 ++-----------------
>  board/starfive/visionfive2/spl.c              |  4 +
>  3 files changed, 14 insertions(+), 72 deletions(-)

Tested-by: Hal Feng <hal.feng@starfivetech.com>

Tested successfully on VisionFive 2 1.3b, SPL can successfully enumerate
each dtb in OF_LIST.

Best regards,
Hal
