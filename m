Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E445EE776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C4A842C3;
	Wed, 24 Dec 2025 17:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="PELB186+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0A084295; Wed, 24 Dec 2025 16:45:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F8E84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8yBvBkXFnC/VYUICcdDGppIxPQNhwTOAWmlL/BHyE4EkfYIdPHtsmbaC3CVNNEmUc/97/cwymcOOAnjEmyQkwvzlbJ9VAclnxy3ue0CFbTQTm0FDRsvuqbFKG0MKxm8Z+vtXExgIHETz7ZVWD04+PX4GcSYRk29TNKxARz95xLXKRlvF1jFC883BcMjNve2tzmfMgrjIYfSkQdixFuomwW+hN8q57NsEwrDebZw15+/gWK7A5n6K2ObJOZcxhW4d+QQeB9yI/A9jLqt6HdaKwhKnuLIy2DHjhjd6haQl/1C+7ynwC9vbQIGxYGdh6/9woI+QnOC8MnObtzZvXIUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa8MX01ePpTiKtkbxdybjZIYW5PECFN4RbXmrcJFYq8=;
 b=X8y2CZ04xDQkf2m+O2R+VrG1TVWE2Qv21Jd7qf8siSHFen0cBUgeRFLfjfy3q2n4E82pFgbkA7S89WEs4ZOilwcUCE3Zck7/0s97xomQduhrIYmYUcSPGXOVs+Sz6+HdwDBeWX5JMMEbJi1O4Y9sLNQ8dewdN5fT3ApX74Fa9BoWE7GLQTOQHE+Lry8gxE4bym+BWzN3wfNaZcZP2wX+Ctbky8KZW9r4rYsCZKLdefdhUyN8/4+1dC00wOp6+JsQwEC0o26ClMsf4D3QBQ5mwbv5ead1WCVxcZ0MojyfzQl06In45IU7C9fzHgy9h9/CzsEYejzRubTlAMdQvUMRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa8MX01ePpTiKtkbxdybjZIYW5PECFN4RbXmrcJFYq8=;
 b=PELB186+bJAUuDq4oG67opiydKted+ozl/L2XbWR9e9YsPB9FHv08L8yBIiNLFd6dSr/3KfNCEGw5u8w9U7fh9ikFzOWWPvG/BKW0RryR/GSmlkdU04gd+mfBMNyv24Usa09mAKxnIoHqWtSXYWSoLZ+Z5qEMD2H9IOEKOOL8vC7JEpUEVPrRt5D3gyGPxI2MdEzuFad5sVLZ4NzZsCd7+zQ6KXVnpXXgKca06BRKnD3jnFn8RIHvDfrk7gdBOGHBFm1VxiL5UezYU6JdFJArH8EWYzEziRXz7tG27K4H2A3mFhQ43xXrfVVHxnDeI0V7yCpbW5Ub5xU5+Zq6KA7bQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:45:47 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:45:47 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 2/8] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v5 2/8] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHcdOxfRUWza4oSX0yckh0yN6pimg==
Date: Wed, 24 Dec 2025 15:45:47 +0000
Message-ID: <20251224154449.946780-3-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 25aa31ca-a463-4b0d-9637-08de430381ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jUesOJ7eb+fzdVBo2O7OMV8MAeAj2GW3KM2J92s6UccCmL+Pyi5L3osqg5?=
 =?iso-8859-1?Q?opMIEECqMree8I9TfnukBLi+8u0p1Rx/r03jaBgue5AJcxqSjbJINJOcrT?=
 =?iso-8859-1?Q?xI6H8s04DA6DBWgM7uLADAqXYY5O7SQWS01R7Yy4sVeCHz2vzw/MYZ6KJ4?=
 =?iso-8859-1?Q?5Gnp/SmQ9hdW4Bn3/hsEdlmWZPDd4E0SmML8k6nsBtpe6q6K1lDyZZpI62?=
 =?iso-8859-1?Q?e4mxGtQsE+fycU5hh+TFVniJVC/gURA+t4x6m2OBlf/Yl8jF7fd24+1b4T?=
 =?iso-8859-1?Q?gTGH9vlR9mXu+UY9KTQX7LcgDCMFWoExXFq+ab91gE9kWffZjGrA9euZRr?=
 =?iso-8859-1?Q?n0PqGSOVw4WaRjm0R41lAzuJPj1zulCm7haQnIkk8k3gq95kQC2KpO2YjZ?=
 =?iso-8859-1?Q?1HOGvwGjVn80im7U7FwlarimtgRWvcZQr25zNzfw1tKKDG8FRJtKiVR7Ra?=
 =?iso-8859-1?Q?f9tGqCxP9CDYC4AFrJtO6xm2uF6W9XJHVCOFi/Kp4pEfyCG/oycfbdnB4M?=
 =?iso-8859-1?Q?Mvq4GaiH+GhnBuTVzjw1vr8InIgqY8DdsZvf6jcKbO/rlrzkAOch5tco8r?=
 =?iso-8859-1?Q?HJnsuX1MTRL7qKdP65McLqltiKx6wBfVsLPxAR7KbIUnu2Il2s544Ov8u2?=
 =?iso-8859-1?Q?CKfriuHWzY/LZKyAegBWnqazCRjwFrxzbKtbw1IdIH7YunLQlH1ZnU8ASn?=
 =?iso-8859-1?Q?Ar8QyO+9NOC/tazzrpHcYT0ILcKzhhMQ4EaZL1xmiMJftihD7r2fQ9Bl2E?=
 =?iso-8859-1?Q?0Qq71F+D/vtiBgCoID/VHrn0yhjf8umFPyF98cGT8dr72YFm9fl2LyCb2t?=
 =?iso-8859-1?Q?x3eOl9nOTLKTzgc89Pq6Rhnt5Nsx6LdkXtUoe4M79GQpo1vEUkhBNl6zlq?=
 =?iso-8859-1?Q?9xInqZz0qGKSobOPV4LRSFpoD16N35CNjVxSgLnRUZMXxyWtqO9eNDm+mc?=
 =?iso-8859-1?Q?Fg8Z9ONIG+CsxuqaE+GqWsUdDj8bf+J5mr8T4koWof9v7K+enqhKo+2atY?=
 =?iso-8859-1?Q?TgLNSIfVOlPSGi6K+zkhkHMkhwVXl4VlpXVkYOQtKeeuZ2TExAcBdrNI6o?=
 =?iso-8859-1?Q?Mg91MCwxoF853sI0ycLN5iBAJGBTOXBwghbLQbV4e1mS03v4C1irNodt6p?=
 =?iso-8859-1?Q?Z/r4NCViZxPZFWkuifESPhsTYcYPFCKG7bUPh/CPzLA/ttjrPjZr8VoRYy?=
 =?iso-8859-1?Q?SBC6GiziAkr02zqDbo/DIWxlEqQB3Q7NfIE0QB3FFuqDdHEsoJ+9bsThWH?=
 =?iso-8859-1?Q?kBSwSLvCRVpdLnYlNW5sbHipiqn7lyLNRFJdo0uNcanBgbEc8meR4tPlEo?=
 =?iso-8859-1?Q?/z+VZkorFJMShHYk8r8rMorR9q+UHymBT0rfozECnD+2PkLXo8QHuBhcZt?=
 =?iso-8859-1?Q?ncz6qkxCrvhkoX6Thsks15dX6uSK8bnMyysWe5R2PILCLlLb2J070ySDi4?=
 =?iso-8859-1?Q?KH7Vl0YfIfg6NhZjpiUdKkr69db7McwSw3OzzcPMC0g2KWG8m0xqnfJzX3?=
 =?iso-8859-1?Q?40Ot2uKlXvcMncZjImI3WDQwtZ+M5aRKidXih6YonGsmA+kZpuzm9Gdl56?=
 =?iso-8859-1?Q?0K977+scoNGmk5/7Yj5BZCvhJAUe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ds8NHR3TJYBQR1Q3ZOgPSDPqBsY8tJ+znEsC8MXSo+8ccZdbghtDO4OfXM?=
 =?iso-8859-1?Q?BIf3slkwM2oSuCcENvAjMx9/KIxaDlkIx5ukqkhPO24XYVIEipOYbi0Vb4?=
 =?iso-8859-1?Q?qAcXlyDHS1YrOB2256IRJHfjXUwkyjHVvNh2Adi1I7sBv07Ag7Iadl8dnL?=
 =?iso-8859-1?Q?ZQ/M7ec36Xfo4NKvZn0Fx5RlDg0tR+G7Hdv1RUc+RlTtsbIdD84Jau3y5r?=
 =?iso-8859-1?Q?TmWd/ZP9+2eXEcdykGnMkSpChhOqXIxEP0csJAv9HE5N2k/UepQnuSu1Cb?=
 =?iso-8859-1?Q?cXOW+SJXkI3iGi5imRGuUpPhKYCT3jhcrfZDqalI4A9YuvyHX2zM6ZfYAR?=
 =?iso-8859-1?Q?feGWsuX1/PKp26cMp6Zb3o7GH1HcQooFd1E4pegoh8TBdXHOZwBh6tKi3c?=
 =?iso-8859-1?Q?z+PusAHhsBgl+XFjB6fqiuaXCE2JFY8AKt7eV6K3j+ZtqT1xAj1KNe9093?=
 =?iso-8859-1?Q?KbZ2x/jwxIFDKNNzkvWry74lOmQCYjl4vkdmNJhxNw/4qz6jz0o+r79NTo?=
 =?iso-8859-1?Q?WFItWdEvpnP7/C1ewffLaTyUQJtQVIkqvke2RaGYcsiXNd8HeXcC4vbIHN?=
 =?iso-8859-1?Q?SHP1+rhQ6P33w4aZD/V1Ozx2abHd2lsiDQwAW7OjUKtEa5zfKvYxo9hr3g?=
 =?iso-8859-1?Q?CZ//PlgfYKLDx8dIRc3Y9ydgWznL5BIr0qKAvXdnaVnBE4RTHMPrK2XA7c?=
 =?iso-8859-1?Q?uUiLFETg2nDSWsW6KQfc04UtEsUcFfMVSD3+0x1w7YgNGPz3pxeayQSX7e?=
 =?iso-8859-1?Q?zQDpiB+NcXPHbnw/tjrxjQzmSkSO1ZsVJuCQXENSRoUjvOWq+8t8OX16Po?=
 =?iso-8859-1?Q?tjlwr6j1uefLaotl/wZC/lgVuJrrQIAYN4L12/I5eMA3nfexL8Y5IJWdYc?=
 =?iso-8859-1?Q?IPa5l4tg3gs1Qs1CTviLj1mJTsuj8HVPciK5C89i2gp2vaStn9dM17aSEU?=
 =?iso-8859-1?Q?DiY5AwjAcSxB2ptDzxFlLtRC2pMVtXbcD2AXFq/5DBR+tQcpctf9TwnVAC?=
 =?iso-8859-1?Q?HDu1EaRNm1rkAjvK9XlL8GkmeQFmPb8ulUaQFpycJAVpPWXQOV9ne+4h+6?=
 =?iso-8859-1?Q?LjnXXsUM/iE1XULKm+hDagy6KZ2loCbR1DJ4dLoC+TW8FGxoFfu//R8nS/?=
 =?iso-8859-1?Q?H+PzM8BXQQ+YuCnLuVwuPN+nDybkkqyABNQz7DNA6LuFjdIwWsaIoIlAYa?=
 =?iso-8859-1?Q?fEVgbSjxz0oSoqCKEWcJUjdaOTPbWg694kel440U/aJxK5ab43aqa+SZt0?=
 =?iso-8859-1?Q?WjzujRuwgT5gBaXzL0WW8HHHrw4BrHS0zIUHr6LExby5uuPsLgG4nY7wgm?=
 =?iso-8859-1?Q?X4s/i/OcbR3epYc+UqbioZnBHQRXIrCj54l+LoZkHhmp+HU4akrl63Sv2b?=
 =?iso-8859-1?Q?BnsO7GsOC5oV/3UmZSf3V6D/bOV35sG7pWA34aqG1jat1CtKh7TDDN7EA1?=
 =?iso-8859-1?Q?Ozfs6x8+Ox8rTZi9wZzMCCbr3fjciKxqvDklzL0X2F2M2M1SEeNWwio6M7?=
 =?iso-8859-1?Q?rInsT9RXAuygNBxxGnFql/Uwn3dBo0A6/DzRdJqkM5BoqKZiFLlHhu0s25?=
 =?iso-8859-1?Q?uO9gcy8nxHmTfy66UjmrW2KCynEy0/Xrk7lgm0HAmauQEA5bD1blYuU1ri?=
 =?iso-8859-1?Q?e11Otw4B/wwVBUP4lzGdo/Qb89ESxB7ZIutDVeLlWnV3zgoQUuZ1ri72+e?=
 =?iso-8859-1?Q?QIWyMio76UILHzqutrAtWzi6Eukhv1XCC4JH0YDeON4IR85TA1T7y+XEDv?=
 =?iso-8859-1?Q?lkLJ7MuaZLIJCyLy8xhsIMyhHrUomK4yccuen8tBVjXsX+RYnuwQi3zz4m?=
 =?iso-8859-1?Q?MZxca/qK984hWmXfRCTonbrCTmuW7WM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa31ca-a463-4b0d-9637-08de430381ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:45:47.2581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZkIalzjcuxX+08Bcdl8S8uByU+xHVsKHFfm4HV8woGsTMTq2ytkmg2HZGS23trKYbMouP7Xi15B/hEW9J+ASr4ZjRu+bg4knVOfiTic9Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

From: Chao-ying Fu <cfu@mips.com>

Implement initial board-level support for the P8700 Boston SoC.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                      |  11 +
 arch/riscv/dts/Makefile                 |   1 +
 arch/riscv/dts/boston-p8700.dts         | 264 ++++++++++++++++++++++++
 board/mips/boston-riscv/Kconfig         |  43 ++++
 board/mips/boston-riscv/MAINTAINERS     |   9 +
 board/mips/boston-riscv/Makefile        |   8 +
 board/mips/boston-riscv/boston-lcd.h    |  20 ++
 board/mips/boston-riscv/boston-regs.h   |  38 ++++
 board/mips/boston-riscv/boston-riscv.c  |  30 +++
 board/mips/boston-riscv/checkboard.c    |  43 ++++
 board/mips/boston-riscv/config.mk       |  15 ++
 board/mips/boston-riscv/lowlevel_init.S |  18 ++
 board/mips/boston-riscv/reset.c         |  15 ++
 configs/boston-p8700_defconfig          |  98 +++++++++
 drivers/clk/Kconfig                     |   2 +-
 include/configs/boston-riscv.h          |   9 +
 16 files changed, 623 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 include/configs/boston-riscv.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b4896544868..8eb12d4eb4e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,16 @@ config TARGET_XILINX_MBV
 config TARGET_ASPEED_AST2700_IBEX
 	bool "Support Ibex RISC-V cores on Aspeed AST2700 SoC"
=20
+config TARGET_MIPS_BOSTON
+	bool "Support Mips Boston Board"
+	select DM
+	select DM_EVENT
+	select DM_GPIO
+	select DM_SERIAL
+	select OF_CONTROL
+	select DISTRO_DEFAULTS
+	imply CMD_DM
+
 endchoice
=20
 config SYS_ICACHE_OFF
@@ -119,6 +129,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 9b347fc3b50..63e3bd4c95f 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -16,6 +16,7 @@ dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-binman.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) +=3D ast2700-ibex.dtb
+dtb-$(CONFIG_TARGET_MIPS_BOSTON) +=3D boston-p8700.dtb
=20
 include $(srctree)/scripts/Makefile.dts
=20
diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.=
dts
new file mode 100644
index 00000000000..f27ebeda4a2
--- /dev/null
+++ b/arch/riscv/dts/boston-p8700.dts
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/boston-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	model =3D "p8700";
+	compatible =3D "img,boston";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		timebase-frequency =3D <25000000>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "riscv";
+			reg =3D <0>;
+			mmu-type =3D "riscv,sv39";
+			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb";
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+			clock-frequency =3D <25000000>;
+			bootph-all;
+			status =3D "okay";
+
+			cpu0_intc: interrupt-controller {
+				compatible =3D "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+			};
+		};
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x80000000>;
+	};
+
+	timer@16154000 {
+		compatible =3D "riscv,aclint-mtimer";
+		reg =3D <0x16108050 0x8>,
+			  <0x16154000 0x7ff8>;
+		interrupts-extended =3D <&cpu0_intc 7>;
+	};
+
+	gic: interrupt-controller {
+		compatible =3D "mti,gic";
+
+		interrupt-controller;
+		#interrupt-cells =3D <3>;
+	};
+
+	pci0: pci@10000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x10000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x40000000
+			  0x40000000 0 0x40000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci0_intc 1>,
+				<0 0 0 2 &pci0_intc 2>,
+				<0 0 0 3 &pci0_intc 3>,
+				<0 0 0 4 &pci0_intc 4>;
+
+		status =3D "disabled";
+
+		pci0_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci1: pci@12000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x12000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x20000000
+			  0x20000000 0 0x20000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci1_intc 1>,
+				<0 0 0 2 &pci1_intc 2>,
+				<0 0 0 3 &pci1_intc 3>,
+				<0 0 0 4 &pci1_intc 4>;
+
+		status =3D "disabled";
+
+		pci1_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci2: pci@14000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x14000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x16000000
+			  0x16000000 0 0x100000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci2_intc 1>,
+				<0 0 0 2 &pci2_intc 2>,
+				<0 0 0 3 &pci2_intc 3>,
+				<0 0 0 4 &pci2_intc 4>;
+
+		pci2_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+
+		pci2_root@0,0,0 {
+			compatible =3D "pci10ee,7021", "pci-bridge";
+			reg =3D <0x00000000 0 0 0 0>;
+
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			#interrupt-cells =3D <1>;
+
+			eg20t_bridge@1,0,0 {
+				compatible =3D "pci8086,8800", "pci-bridge";
+				reg =3D <0x00010000 0 0 0 0>;
+
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+				#interrupt-cells =3D <1>;
+
+				eg20t_mac@2,0,1 {
+					compatible =3D "pci8086,8802", "intel,pch-gbe";
+					reg =3D <0x00020100 0 0 0 0>;
+					phy-reset-gpios =3D <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
+				};
+
+				eg20t_gpio: eg20t_gpio@2,0,2 {
+					compatible =3D "pci8086,8803", "intel,eg20t-gpio";
+					reg =3D <0x00020200 0 0 0 0>;
+
+					gpio-controller;
+					#gpio-cells =3D <2>;
+				};
+
+				mmc0: mmc@2,4,0 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022000 0 0 0 0>;
+				};
+
+				mmc1: mmc@2,4,1 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022100 0 0 0 0>;
+				};
+
+				eg20t_i2c@2,12,2 {
+					compatible =3D "pci8086,8817";
+					reg =3D <0x00026200 0 0 0 0>;
+
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					rtc@0x68 {
+						compatible =3D "st,m41t81s";
+						reg =3D <0x68>;
+					};
+				};
+			};
+		};
+	};
+
+	plat_regs: system-controller@17ffd000 {
+		compatible =3D "img,boston-platform-regs", "syscon";
+		reg =3D <0x17ffd000 0x1000>;
+		bootph-all;
+	};
+
+	clk_boston: clock {
+		compatible =3D "img,boston-clock";
+		#clock-cells =3D <1>;
+		regmap =3D <&plat_regs>;
+		bootph-all;
+	};
+
+	reboot: syscon-reboot {
+		compatible =3D "syscon-reboot";
+		regmap =3D <&plat_regs>;
+		offset =3D <0x10>;
+		mask =3D <0x10>;
+	};
+
+	uart0: uart@17ffe000 {
+		compatible =3D "ns16550a";
+		reg =3D <0x17ffe000 0x1000>;
+		reg-shift =3D <2>;
+		reg-io-width =3D <4>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks =3D <&clk_boston BOSTON_CLK_SYS>;
+		clock-frequency =3D <25000000>;
+
+		bootph-all;
+	};
+
+	lcd: lcd@17fff000 {
+		compatible =3D "img,boston-lcd";
+		reg =3D <0x17fff000 0x8>;
+	};
+
+	flash@18000000 {
+		compatible =3D "cfi-flash";
+		reg =3D <0x18000000 0x8000000>;
+		bank-width =3D <2>;
+	};
+};
diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
new file mode 100644
index 00000000000..68c5fc50489
--- /dev/null
+++ b/board/mips/boston-riscv/Kconfig
@@ -0,0 +1,43 @@
+if TARGET_MIPS_BOSTON
+
+config SYS_BOARD
+	default "boston-riscv"
+
+config SYS_VENDOR
+	default "mips"
+
+config SYS_CONFIG_NAME
+	default "boston-riscv"
+
+config SYS_CPU
+	default "p8700"
+
+config BOARD_SPECIFIC_OPTIONS
+    def_bool y
+    select P8700_RISCV
+    imply SYS_NS16550
+
+config SYS_CACHELINE_SIZE
+    default 64
+
+config SYS_SDRAM_BASE
+    hex
+    default 0x80000000
+
+config SYS_INIT_SP_ADDR
+    hex
+    default 0x80200000
+
+config STANDALONE_LOAD_ADDR
+    hex
+    default 0x80200000
+
+config SYS_MAX_FLASH_BANKS_DETECT
+    bool
+    default y
+
+config PHY_REALTEK
+    bool
+    default y
+
+endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
new file mode 100644
index 00000000000..e350121395e
--- /dev/null
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -0,0 +1,9 @@
+BOSTON-RISCV BOARD
+M:	Chao-ying Fu <cfu@mips.com>
+S:	Maintained
+F:	board/mips/boston-riscv/
+F:	include/configs/boston-riscv.h
+F:  arch/riscv/cpu/p8700/
+F:  arch/riscv/include/asm/arch-p8700/
+F:  configs/boston-p8700_defconfig
+F:  arch/riscv/dts/boston-p8700.dts
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
new file mode 100644
index 00000000000..0615c677d23
--- /dev/null
+++ b/board/mips/boston-riscv/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2016 Imagination Technologies
+
+obj-y +=3D boston-riscv.o
+obj-y +=3D checkboard.o
+obj-y +=3D lowlevel_init.o
+obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/boston-lcd.h b/board/mips/boston-riscv=
/boston-lcd.h
new file mode 100644
index 00000000000..5f5cd0fe126
--- /dev/null
+++ b/board/mips/boston-riscv/boston-lcd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_LCD_H__
+#define __BOARD_BOSTON_LCD_H__
+
+/**
+ * lowlevel_display() - Display a message on Boston's LCD
+ * @msg: The string to display
+ *
+ * Display the string @msg on the 7 character LCD display of the Boston bo=
ard.
+ * This is typically used for debug or to present some form of status
+ * indication to the user, allowing faults to be identified when things go
+ * wrong early enough that the UART isn't up.
+ */
+void lowlevel_display(const char msg[static 8]);
+
+#endif /* __BOARD_BOSTON_LCD_H__ */
diff --git a/board/mips/boston-riscv/boston-regs.h b/board/mips/boston-risc=
v/boston-regs.h
new file mode 100644
index 00000000000..4d5ea8833ab
--- /dev/null
+++ b/board/mips/boston-riscv/boston-regs.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_REGS_H__
+#define __BOARD_BOSTON_REGS_H__
+
+#ifndef BOSTON_PLAT_BASE
+#define BOSTON_PLAT_BASE		(0x17ffd000)
+#endif
+#define BOSTON_LCD_BASE			(0x17fff000)
+
+/*
+ * Platform Register Definitions
+ */
+#define BOSTON_PLAT_CORE_CL		(BOSTON_PLAT_BASE + 0x04)
+
+#define BOSTON_PLAT_SOFT_RST		(BOSTON_PLAT_BASE + 0x10)
+#define BOSTON_PLAT_SOFT_RST_SYSTEM	(0x1 << 4)
+
+#define BOSTON_PLAT_DDR3STAT		(BOSTON_PLAT_BASE + 0x14)
+#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
+
+#define BOSTON_PLAT_BUILDCFG0           (BOSTON_PLAT_BASE + 0x34)
+#define BOSTON_PLAT_BUILDCFG0_IOCU     (0x1 << 0)
+#define BOSTON_PLAT_BUILDCFG0_PCIE0    (0x1 << 1)
+#define BOSTON_PLAT_BUILDCFG0_PCIE1    (0x1 << 2)
+#define BOSTON_PLAT_BUILDCFG0_PCIE2    (0x1 << 3)
+#define BOSTON_PLAT_BUILDCFG0_CFG_LTR  (0xf << 4)
+#define BOSTON_PLAT_BUILDCFG0_CFG_NUM  (0xff << 8)
+#define BOSTON_PLAT_BUILDCFG0_DP       (0x1 << 24)
+#define BOSTON_PLAT_BUILDCFG0_DP_MULT  (0xf << 28)
+
+#define BOSTON_PLAT_DDRCONF0		(BOSTON_PLAT_BASE + 0x38)
+#define BOSTON_PLAT_DDRCONF0_SIZE	(0xf << 0)
+
+#endif /* __BOARD_BOSTON_REGS_H__ */
diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-ris=
cv/boston-riscv.c
new file mode 100644
index 00000000000..64abe61c6e4
--- /dev/null
+++ b/board/mips/boston-riscv/boston-riscv.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <asm/encoding.h>
+#include <linux/types.h>
+#include <asm/arch-p8700/p8700.h>
+
+#define PMACFG0_PMP3_SHIFT	24
+#define PMACFG0_PMP3_MASK	(0xffUL << PMACFG0_PMP3_SHIFT)
+
+int board_early_init_r(void)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_MMODE))
+		return 0;
+	ulong pmacfg0 =3D csr_read(CSR_PMACFG0);
+
+	/*
+	 * Make the flash region (PMA entry corresponding to pmp3) uncached by
+	 * setting the CCA field in CSR_PMACFG0[31:24].
+	 */
+	pmacfg0 &=3D ~PMACFG0_PMP3_MASK;
+	pmacfg0 |=3D (ulong)CCA_CACHE_DISABLE << PMACFG0_PMP3_SHIFT;
+
+	csr_write(CSR_PMACFG0, pmacfg0);
+	asm volatile ("fence" ::: "memory");
+
+	return 0;
+}
diff --git a/board/mips/boston-riscv/checkboard.c b/board/mips/boston-riscv=
/checkboard.c
new file mode 100644
index 00000000000..c7bf6734433
--- /dev/null
+++ b/board/mips/boston-riscv/checkboard.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-lcd.h"
+#include "boston-regs.h"
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/p8700.h>
+
+int checkboard(void)
+{
+	u32 changelist, cfg, core, uarch;
+	u64 marchid;
+
+	lowlevel_display("U-boot  ");
+
+	printf("Board: Mips Boston RISC-V\n");
+
+	changelist =3D __raw_readl((uint32_t *)BOSTON_PLAT_CORE_CL);
+	if (changelist > 1) {
+		asm volatile ("csrr %0, marchid" : "=3Dr"(marchid)::);
+		core =3D (marchid >> MARCHID_CLASS_SHIFT) & MARCHID_CLASS_MASK;
+		uarch =3D (marchid >> MARCHID_UARCH_SHIFT) & MARCHID_UARCH_MASK;
+
+		printf("Core:  class%x uarch%x cl%x", core, uarch, changelist);
+
+		cfg =3D __raw_readl((uint32_t *)BOSTON_PLAT_BUILDCFG0);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM)
+			printf(" config %u",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM) >> 8);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR)
+			printf("%c",
+			       'a' + ((cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR) >> 4) - 1);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_DP)
+			printf(", x%u debug port",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_DP_MULT) >> 28);
+		printf("\n");
+	}
+
+	return 0;
+}
diff --git a/board/mips/boston-riscv/config.mk b/board/mips/boston-riscv/co=
nfig.mk
new file mode 100644
index 00000000000..c1e242f1088
--- /dev/null
+++ b/board/mips/boston-riscv/config.mk
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+quiet_cmd_srec_cat =3D SRECCAT $@
+      cmd_srec_cat =3D srec_cat -output $@ -$2 \
+			$< -binary \
+			-fill 0x00 -within $< -binary -range-pad 16 \
+			-offset $3
+
+u-boot.mcs: u-boot.bin
+	$(call cmd,srec_cat,intel,0x7c00000)
+
+# if srec_cat is present build u-boot.mcs by default
+has_srec_cat =3D $(call try-run,srec_cat -VERSion,y,n)
+INPUTS-$(has_srec_cat) +=3D u-boot.mcs
+CLEAN_FILES +=3D u-boot.mcs
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
new file mode 100644
index 00000000000..8fa85749e40
--- /dev/null
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+
+.data
+
+msg_ddr_cal:	.ascii "DDR Cal "
+msg_ddr_ok:	.ascii "DDR OK  "
+
+.text
+
+	.globl lowlevel_display
+lowlevel_display:
+	li	t0, BOSTON_LCD_BASE
+	jr	ra
diff --git a/board/mips/boston-riscv/reset.c b/board/mips/boston-riscv/rese=
t.c
new file mode 100644
index 00000000000..8e7e0572aad
--- /dev/null
+++ b/board/mips/boston-riscv/reset.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+#include <asm/io.h>
+#include <linux/delay.h>
+
+void _machine_restart(void)
+{
+	writel(BOSTON_PLAT_SOFT_RST_SYSTEM, (void __iomem *)BOSTON_PLAT_SOFT_RST)=
;
+
+	udelay(1000);
+}
diff --git a/configs/boston-p8700_defconfig b/configs/boston-p8700_defconfi=
g
new file mode 100644
index 00000000000..498ccb15b4c
--- /dev/null
+++ b/configs/boston-p8700_defconfig
@@ -0,0 +1,98 @@
+CONFIG_RISCV=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x1fc00000
+CONFIG_ENV_SIZE=3D0x40000
+CONFIG_ENV_SECT_SIZE=3D0x40000
+CONFIG_TARGET_MIPS_BOSTON=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"boston-p8700"
+
+CONFIG_DISTRO_DEFAULTS=3Dy
+CONFIG_FIT=3Dy
+CONFIG_FIT_VERBOSE=3Dy
+CONFIG_FIT_BEST_MATCH=3Dy
+CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
+CONFIG_SYS_PROMPT=3D"boston # "
+CONFIG_CMD_GREPENV=3Dy
+CONFIG_CMD_MEMTEST=3Dy
+CONFIG_SYS_MEMTEST_START=3D0x80000000
+CONFIG_SYS_MEMTEST_END=3D0x90000000
+CONFIG_BOOTDELAY=3D-1
+
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_ARCH_RV64I=3Dy
+CONFIG_DISPLAY_CPUINFO=3Dy
+CONFIG_DISPLAY_BOARDINFO=3Dy
+CONFIG_BOARD_INIT=3Dn
+#CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
+#CONFIG_CMD_NVEDIT_EFI=3Dy
+CONFIG_CMD_MII=3Dy
+# CONFIG_OF_PRIOR_STAGE=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_SMP=3Dn
+CONFIG_XIP=3Dy
+CONFIG_CLK_BOSTON=3Dy
+CONFIG_RISCV_ISA_C=3Dn
+CONFIG_SHOW_REGS=3Dy
+CONFIG_SYS_NS16550=3Dy
+
+CONFIG_CMD_PCI=3Dy
+CONFIG_CMD_SNTP=3Dy
+CONFIG_CMD_DNS=3Dy
+CONFIG_CMD_LINK_LOCAL=3Dy
+CONFIG_CMD_TIME=3Dy
+CONFIG_CMD_EXT4_WRITE=3Dy
+CONFIG_ENV_IS_IN_FLASH=3Dy
+CONFIG_ENV_ADDR=3D0x1ffc0000
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_MTD=3Dy
+CONFIG_MTD_NOR_FLASH=3Dy
+CONFIG_FLASH_CFI_DRIVER=3Dy
+CONFIG_CFI_FLASH=3Dy
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
+CONFIG_SYS_FLASH_USE_PROTECTION=3Dy
+CONFIG_SYS_FLASH_CFI=3Dy
+CONFIG_SYS_FLASH_PROTECTION=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_PCH_GBE=3Dy
+CONFIG_PCI=3Dy
+CONFIG_DM_PCI=3Dy
+CONFIG_PCI_XILINX=3Dy
+CONFIG_LZ4=3Dy
+CONFIG_CLK=3Dy
+CONFIG_EG20T_GPIO=3Dy
+
+CONFIG_MMC=3Dy
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_CMD_CPU=3Dy
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_DHCP=3Dy
+CONFIG_CMD_PING=3Dy
+CONFIG_CMD_EXT4=3Dy
+CONFIG_CMD_FAT=3Dy
+CONFIG_CMD_FS_GENERIC=3Dy
+CONFIG_OF_EMBED=3Dy
+CONFIG_CPU=3Dy
+CONFIG_MMC_SDHCI=3Dy
+CONFIG_MMC_PCI=3Dy
+
+CONFIG_UNIT_TEST=3Dy
+CONFIG_UT_LIB=3Dn
+CONFIG_UT_LIB_ASN1=3Dn
+CONFIG_UT_LOG=3Dn
+CONFIG_UT_TIME=3Dy
+CONFIG_UT_UNICODE=3Dn
+CONFIG_UT_ENV=3Dn
+CONFIG_UT_OVERLAY=3Dn
+
+CONFIG_SYS_LOAD_ADDR=3D0x80000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
+CONFIG_TEXT_BASE=3D0x1fc00000
+CONFIG_SYS_MALLOC_LEN=3D0x00800000
+CONFIG_SYS_BOOTM_LEN=3D0x04000000
+CONFIG_SYS_MAX_FLASH_SECT=3D1024
+CONFIG_PHY_ANEG_TIMEOUT=3D40000
+CONFIG_NET_RETRY_COUNT=3D10
+CONFIG_ENV_CALLBACK_LIST_STATIC=3D"io.coherent:io_coherent,"
+CONFIG_BOOTARGS=3D"root=3D/dev/sda rw earlycon console=3DttyS0,115200n8r"
+CONFIG_BOARD_EARLY_INIT_R=3Dy
+CONFIG_PCI_BRIDGE_MEM_ALIGNMENT=3D0x1
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b884a02bdeb..bee76671b20 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -59,7 +59,7 @@ config CLK_BCM6345
 	  clocks on BCM6345 SoCs. HW has no rate changing capabilities.
=20
 config CLK_BOSTON
-	def_bool y if TARGET_BOSTON
+	def_bool y if TARGET_BOSTON || TARGET_MIPS_BOSTON
 	depends on CLK
 	select REGMAP
 	select SYSCON
diff --git a/include/configs/boston-riscv.h b/include/configs/boston-riscv.=
h
new file mode 100644
index 00000000000..f1ee6f6032a
--- /dev/null
+++ b/include/configs/boston-riscv.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __CONFIG_BOSTON_RISCV_H
+#define __CONFIG_BOSTON_RISCV_H
+
+#endif /* __CONFIG_BOSTON_RISCV_H */
--=20
2.34.1
