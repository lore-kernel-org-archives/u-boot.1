Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A892F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC71843F9;
	Fri, 17 Apr 2026 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="f9d9EgAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B364841C2; Fri, 17 Apr 2026 14:25:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C1B83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0H/+LrYiHYC39JRGnvBSY25+iMlwNSs+Zi5QweNKQH/gmDbn6cmcw01v2J3YF5ErDQZw8UlItPXpeQB980FnKC3SVvVQRbqXDY9rchkrMIRxgsl1OXhoWGJMchC80RBjMN2GKbheJ5lst1X2QOs5Hvxdnv9pkKd206Lf8gjNMlAEq2HYdTf8wh0IdoI5dFECDWyijRe0yql3PlMzl5JaAEUaVzS9bEpIjc4OftB1jGk4bLFXrYQecIkc6ZXJiwY8uc++i718AIKpdB17xg5v9YnD7bqCM1VUsWw4UoApKB1WK04jvY9NLe/D40QUYgdhlWKofNpJ1T4rl3aQGxYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnGcDATHOxzOzavt8wlv42hwS+gDK+R5BVb9Ds+6lXI=;
 b=KLX2ukAsihtKkfeV7n+BfIxmlLH7geh7M4rUSjlHjJtO/esb3RV/Mzv4iY1ERaMYNsUWHbEb4g/8NAlNsHDPp/g408zT35oew5WaSMgSMh05zdq2mOn6rMs98PtxI3UCJ11vxnqtfPelXzIgu6Ox8lSMJ4/fmxT4VoQ3G/oO9r3kVMWZfmvLPZm/WbqXzSk5LCHPTbxayrwvYPP3PjsH0pl+x0SnxTS84In/7KjFCm9bWG56GsCtlry3zggi2Jdvu9XKJbYfwJXYS4fHpsFV5NGDonSMbjpfE6hVWURhprJhrtHULYtp/F3cCzcJBIsxp/l+1W4FTe1qrF2d3BRP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnGcDATHOxzOzavt8wlv42hwS+gDK+R5BVb9Ds+6lXI=;
 b=f9d9EgAoGwCxwZzUgPFeWC6oLFRMf89EK1Ta8AaF6eH4AaPMydz5NkMGyVwJZddBP33ImtEQOW4WqYdu5ZtnrQKAjaLKol5pwTYNyYEe9yRN6K+5tDXNEvP4lFYbZGxK2VXLtfOBw6RAOiV//bn70ZhXL9Zh1A9Oru6zx+t37y+jRlYsdrA47GQhfE1OEnaf7m8H8t0y6on6T0LImO7eZDJvMKCd2qnKZTesWweaYrCGMyz6K0dpXBXKRAzKPijSJw1UlBEE+Zi1f7PWkMFmg/OMBz3aoKjvSs5qEalGuTaE8tbr7rDw65c2ep770U5NTOk9Wmgb5Oba7CHLUVStWg==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DB9PR09MB6861.eurprd09.prod.outlook.com (2603:10a6:10:4c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:25:19 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:25:19 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 3/7] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v7 3/7] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHczmVAv4L9D4vFgE28/J4wnIJ6ng==
Date: Fri, 17 Apr 2026 12:25:18 +0000
Message-ID: <20260417122213.147529-4-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DB9PR09MB6861:EE_
x-ms-office365-filtering-correlation-id: 89bb30cd-c9f5-416b-9c36-08de9c7c6376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: K/1FQLV44tLkUmbLfs5HKS+B5tQNCleB9tvoSWSSioNLZFPKWDCTbwxVMmczc25D3huD4PG9yqnLIzeKrkBHKBXSnZRvr4D7ls8RLUE0p1/dyejjRTqY+RQ1qFyM+noeuzSwqjqZGVTEGPP2hpr676vKtw/Dt1r6g3p6Q8MTUu4n3FDXVMtUybCZrbXOFXViPCdFR0SP5qDM9Py7CIc4Ms6R1POkZ8g7E9qs8c2eOzhmCQLjLADub1pfhNr/6VbY4bP+MHMHWSCj7KzK+D2IL/n43n5IkosbZ7C6yWXLCU9QdSERxEkluM/LFneC37W8h1+KV4FRgRua5sHoxbWDj8ob5kQuKquVz0G9GNVdKs8IYl3JZ0LIQC4W/CSnNY6zvDG29FvQXgBEqHmuEE496qQT3/SJSvu5XkznVGyWt3uvdOHs5gJdDuyJL6ERcJPGFU27jkbRS8EgMTevZZrg9hhPPheZ55WtJWb0quqjFXyKyLgLEfAFv+SmZiLvsGo8AGlZ4yBuY43Dlo53jGnKooPehGsMlfiMBeE6S+eyFUOkDjCUrOM28rK6RT+OEPYy56h/zZobx2WIbpPbc9pxoiHx79tbTIv66mA/PZLO7QGg4uWF92e+EqCHV15eEuQ8MoAfYtnQNegiUQivtfFnge2MdhfyCMcfEEaC/ied/QgiJBb6a+U7Sq5Je9LO5YBXzGdG6HWgM/58V2TMIux+htj4WelwbaUBSdW2iZya3KLgkbr24p+BOcU4oh4ejC5ERcRngAENQSd1KMiSTy0dEbX6MRHUs86Qb4vq3hHMvDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7AwWFIOMO3J86K+zaOTQPRYLr1tZFzKm2lFNnhPaYG14ma4Vv2wwkbjuwG?=
 =?iso-8859-1?Q?VA/FkvB61vaiiWUXICDJg48DrIRMWuqg42QSQQGurAYLNDKHFkH8MSzpqb?=
 =?iso-8859-1?Q?Sxqu6JzAkqizc64ZQQYIWfuq3S+HkweRh4m8STlR9xjQAaZ102QIDWtJBU?=
 =?iso-8859-1?Q?ePoNDyFxrEblzpdAOMPxwH+gIEZLdToBhoHPfP4F3tn3XDjRkdMmja5BJl?=
 =?iso-8859-1?Q?Spm4OQMKKSRbiNtFojijiYs+LXu77t+QcSpV9N1qCjlcD4DxtK7PZqblzT?=
 =?iso-8859-1?Q?h0u31vywVW9DFcP8eXkEnf/qbV9FulXLKv6uyiVvxmAQwuw1yiapnGWnoZ?=
 =?iso-8859-1?Q?NPMuvHX9+zCBWahyGa8QAude6ej4/hX6mq7u4yTkZD8wPe1F8yStjs0noB?=
 =?iso-8859-1?Q?S/UWtRKEXJ7VmfmFuS+VHlAA6Jf0HBAEQ6qn2mrFCETFxUSrELYNjcytGu?=
 =?iso-8859-1?Q?NriPsipkt8ueul9oDca/EaIdd2VP/1YA5U468MBuLo3d9Lie35bkmrsM31?=
 =?iso-8859-1?Q?acw2vSMERjciAVR237IXeMhYOT3ucBM487T4xl/OdakQe2GMapbn7L4RnL?=
 =?iso-8859-1?Q?Iqw69xc73X6GxuBdJXehMT0WGi61J4o3hDVLLdUx3Aq2Hy26/5fhDy3Upj?=
 =?iso-8859-1?Q?5kMpglAU9AGEgy348VhYpNHQr/UKoCNIlds3aTNyimDjhVzrCLnKDnX8pU?=
 =?iso-8859-1?Q?w8a5mSXlzZE8+vXND6CcQpnvuFp3vrli9WWhA4lNIXR1xHKaXHabyJpVUe?=
 =?iso-8859-1?Q?h17IG2JFk12as1iGS5lPAWXOXWETA593iejeY64pOTxoL1SvM+iPKBfJOx?=
 =?iso-8859-1?Q?kFTYCFDkUYbohA7AOvfla1/T72eIm6AfB0EeFcQ+6wOC1Y0TeSlkW3CIdD?=
 =?iso-8859-1?Q?Cs9sdKrbqBQp+/dkQyscdwbz9Y+7VchiJlq3oE8QmvJa86fF2HhpLoCHAT?=
 =?iso-8859-1?Q?UbnoXfe91IkCPGt5hAk97DvwDUwQ5OqhuwB84q+F0P3YW7n66SqHUtHpnu?=
 =?iso-8859-1?Q?wpr+jMvOKl04btkT7zJK/DM9pA7gI/Q9O3aQ5issKmBrHxBiWrB1p2nkq3?=
 =?iso-8859-1?Q?gN5hoprtDRQVhFciSIOmStkOWNGpCN4gyaQeOXjufFEbAGIbwEoxnrxBu6?=
 =?iso-8859-1?Q?0nAaHHW14ipcroHefAfDR02zmK47woKYSQtLlTCZptWfl6jEoszhiPFJjH?=
 =?iso-8859-1?Q?sCJjgeV9xiGZqBkI/38/hb/oyAgatqF94AGR8NDRGJqNTbCX6Wkc8K9yRF?=
 =?iso-8859-1?Q?smtNZlgW5xY79C7Ni97+I3JHbnZ4X1IAqeXgTYn4yf1+4xZ3n2soBOv2on?=
 =?iso-8859-1?Q?fBGz4JpbGMs1N5XrR8wTA1uRHNuHUOA6UHrbLZ5BsurDfY0g3WejFDMN3L?=
 =?iso-8859-1?Q?ppHJkyTCrIRr5u4nvjWKudJR4sZon8X9wr69uIJTD/gpNxUqvmaZKqpXfV?=
 =?iso-8859-1?Q?i7qefm4jkxvQODo6iftyBQR65AP0Pr6IE32yZHkMb6wl15BDVPMcA9p5lg?=
 =?iso-8859-1?Q?ouVeKEVCwIpm9NZut3nnLparnNngh/lLGjAuonYaAp6KJVpCJI81WuGdoJ?=
 =?iso-8859-1?Q?xmxXbWQKq7nd8Tu61vGHVsKHlInthIKz2tYoUAq2nWsuFvlF4ZsHn+qwxk?=
 =?iso-8859-1?Q?jNoYPzooCn7yy10ubbfKj1biGtWTVenBTP1qNDs9QotAlVi2IEopQLSU0v?=
 =?iso-8859-1?Q?XyqFLNhU4HTvWyCAA/bHl3M2e4b1myxyaz6ooB9vFDC8NbG1nEgwfqeXE1?=
 =?iso-8859-1?Q?7HAWyvIbptzl0C7Xg8ni+5G6FCj6Dg6LsDNhbh6w2wViIqFj/Ua20oUegN?=
 =?iso-8859-1?Q?qddSTdcYX8oLbDLoQBpK6313qzEA16A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bb30cd-c9f5-416b-9c36-08de9c7c6376
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:25:18.9333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy/HvTM0V+cnIuVGg44czQX5LotBi13fKZVb3kRBT43sES1L/9EV9Fw0A3K8L3xQwt1WCZhRzCnUYhmdNzzdtE9TV8MNtnT+W6sF/MESYNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6861
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Add a GPIO driver for the Intel EG20T Platform Controller Hub, which
exposes a set of 12 GPIOs via PCI MMIO.

The driver implements basic GPIO operations (input/output direction,
value read/write, and function query) using the U-Boot driver model
infrastructure. It maps the required BAR1 region via `dm_pci_map_bar`
and uses internal registers to control pin state and direction.

This driver is required for platforms using EG20T, such as P8700-based
systems, to access GPIOs through the standard U-Boot DM GPIO framework.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/MAINTAINERS |   1 +
 drivers/gpio/Kconfig                |   7 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/eg20t-gpio.c           | 141 ++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/gpio/eg20t-gpio.c

diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index d03491d0f0c..8b95f53ab32 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -7,3 +7,4 @@ F:	arch/riscv/cpu/p8700/
 F:	arch/riscv/include/asm/arch-p8700/
 F:	configs/boston-p8700_defconfig
 F:	arch/riscv/dts/boston-p8700.dts
+F:	drivers/gpio/eg20t-gpio.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0b5466b39b8..94d77c0e6a6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -762,4 +762,11 @@ config MPFS_GPIO
 	help
 		Enable to support the GPIO driver on Polarfire SoC
=20
+config EG20T_GPIO
+        bool "Intel EG20T GPIO driver"
+        depends on DM_GPIO && PCI
+        help
+          Enable this to support the GPIO controller found in the Intel EG=
20T
+          Platform Controller Hub.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 863557e45ce..729723bfe48 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -82,3 +82,4 @@ obj-$(CONFIG_GPIO_SCMI)		+=3D gpio_scmi.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+=3D adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+=3D rzg2l-gpio.o
 obj-$(CONFIG_MPFS_GPIO)	+=3D mpfs_gpio.o
+obj-$(CONFIG_EG20T_GPIO)	+=3D eg20t-gpio.o
diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
new file mode 100644
index 00000000000..18dc5214c43
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <pci.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+
+enum {
+	REG_IEN		=3D 0x00,
+	REG_ISTATUS	=3D 0x04,
+	REG_IDISP	=3D 0x08,
+	REG_ICLR	=3D 0x0c,
+	REG_IMASK	=3D 0x10,
+	REG_IMASKCLR	=3D 0x14,
+	REG_PO		=3D 0x18,
+	REG_PI		=3D 0x1c,
+	REG_PM		=3D 0x20,
+};
+
+struct eg20t_gpio_priv {
+	void *base;
+};
+
+static int eg20t_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm, pval;
+
+	pm =3D readl(priv->base + REG_PM);
+	if ((pm >> offset) & 0x1)
+		pval =3D readl(priv->base + REG_PO);
+	else
+		pval =3D readl(priv->base + REG_PI);
+
+	return (pval >> offset) & 0x1;
+}
+
+static int eg20t_gpio_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 po;
+
+	po =3D readl(priv->base + REG_PO);
+	if (value)
+		po |=3D 1 << offset;
+	else
+		po &=3D ~(1 << offset);
+	writel(po, priv->base + REG_PO);
+
+	return 0;
+}
+
+static int eg20t_gpio_direction_input(struct udevice *dev, unsigned int of=
fset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm &=3D ~(1 << offset);
+	writel(pm, priv->base + REG_PM);
+
+	return 0;
+}
+
+static int eg20t_gpio_direction_output(struct udevice *dev, unsigned int o=
ffset,
+				       int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm |=3D 1 << offset;
+	writel(pm, priv->base + REG_PM);
+
+	return eg20t_gpio_set_value(dev, offset, value);
+}
+
+static int eg20t_gpio_get_function(struct udevice *dev, unsigned int offse=
t)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	if ((pm >> offset) & 0x1)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops eg20t_gpio_ops =3D {
+	.direction_input	=3D eg20t_gpio_direction_input,
+	.direction_output	=3D eg20t_gpio_direction_output,
+	.get_value		=3D eg20t_gpio_get_value,
+	.set_value		=3D eg20t_gpio_set_value,
+	.get_function		=3D eg20t_gpio_get_function,
+};
+
+static int eg20t_gpio_probe(struct udevice *dev)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	struct gpio_dev_priv *uc_priv =3D dev->uclass_priv_;
+
+	priv->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, 0, 0,
+				    PCI_REGION_TYPE, PCI_REGION_MEM);
+	if (!priv->base) {
+		debug("failed to map GPIO registers\n");
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count =3D 12;
+	uc_priv->bank_name =3D "eg20t";
+
+	return 0;
+}
+
+static const struct udevice_id eg20t_gpio_ids[] =3D {
+	{ .compatible =3D "intel,eg20t-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(eg20t_gpio) =3D {
+	.name	=3D "eg20t-gpio",
+	.id	=3D UCLASS_GPIO,
+	.of_match =3D eg20t_gpio_ids,
+	.probe	=3D eg20t_gpio_probe,
+	.priv_auto =3D sizeof(struct eg20t_gpio_priv),
+	.ops	=3D &eg20t_gpio_ops,
+};
+
+static struct pci_device_id eg20t_gpio_supported[] =3D {
+	{ PCI_VENDOR_ID_INTEL, 0x8803 },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(eg20t_gpio, eg20t_gpio_supported);
--=20
2.34.1
