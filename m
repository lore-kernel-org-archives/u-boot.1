Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501C2C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8739582E17;
	Tue, 24 Jun 2025 15:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="j22tnrag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A04982C84; Tue, 24 Jun 2025 12:26:01 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B66B82BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLz/5U+cy9HujHTxywUNlkwG+8CuHhZGAjfK+WzbxTn5sLDvoedXWab5EqVcBbMQCousTQcxBuUr9qtcyVngK2UxTF8oZ2rhtuyMTUbcEOKzMtUr/SqHcnDL2RVVCIdnJp8hH5eHNgUhWU2B5YYUC8P4QqNEBuID+H/DeyYLg1opHv3YGibYlzYH5R/0xVgugLrLVO0J6cd7pKsRYRTls2G2fbHYdgnEYLppxdlJ468BXDnVneLxT3NhZjIY6EVzp6AId2NYweayUOpUMkCgmn/r7xEamM2y0rmAN16n1UIbr32SEFVoAVh1Ko2LfPjTo+8J0GMXb9lARkUyMdqL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uTznaV1B6/F1Shg6Bz8x38BeITRynE4mWaRhcp8xyc=;
 b=C1ldzzvMtrDdiRDnfSrr2g//sQ60WHdPSPt23SSzhIZ4Hof50g9+a/F5sCFFLpsJ4ww1XKqE9xxw8wWAXtq/jB5hh4mo5EeX1rsuyKIW3iEwrjBXawHIrK4x+dhA4Rq4qwBf/frwk+xgmHu3yndD5rciTSWeMLgGwGw/1Uffa+8CNzjzD0uUNS9ccwzLv15dGuVdmC7vWLdUbFs+thftpued7y2MSiQdsa2ug3V6NWACxtvQqPn4c+yvqgKN8Lw6Iwuaiw2H8+9vpyIpBdq6Ms5lOiz3gAYqvGwTQPdQ5Hunsx420Hh/4fviJ+AIbV1cwC0yryK/f5Uo5HuxoRzCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uTznaV1B6/F1Shg6Bz8x38BeITRynE4mWaRhcp8xyc=;
 b=j22tnragboVx/Jy+1wBBITSmBbAHHwFwRIELftSq6x8t5t0vbgX9khJ5vhQf1gvjm2T9JHHHNfYD4Fd1c6DOr1FVj4ZVq++qqVMa/mbWVceeZjlYDQwOfujPbfXPMH4bIl/RFvvxiYZib4ZJh2sa9+o0Xtdbv3jIO5bwe/oawcaAj0JXAP5s5YbG0mFfvIEw6RkPisrxGJgpPA4+4X1S/Xc3tD9aAzL2QME0mrNNg2czm0RYq4rO8uSnBw9OI/Q5Gv1kuqp+VwcVaNl5fctxqpy2vyjbrlQ9LUIjEqsXyzWMfwUXI4BJsG7BOKB8HsgIa5hcJrISExvFy5Eg1eVSEg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AS1PR09MB5543.eurprd09.prod.outlook.com (2603:10a6:20b:4a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:25:58 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:25:58 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 02/11] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v2 02/11] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHb5PJfhAkn1Q+LEkWzgYz0Lzi53g==
Date: Tue, 24 Jun 2025 10:25:57 +0000
Message-ID: <20250624102449.324410-3-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AS1PR09MB5543:EE_
x-ms-office365-filtering-correlation-id: a56e6009-3105-4148-3764-08ddb309825c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tjPLkH8BHm96ALY3VLXwX7GVhHsUkXl0wGvoYEjH7e4ZdU+1tHN1VSgcWh?=
 =?iso-8859-1?Q?oK8xhsnJq9OSMZol4ILulDAwoMsHPxMkJA93lWSBq/DZz4JaDN57iHNNI8?=
 =?iso-8859-1?Q?hz4FXZ2Z4xW+6cwHki0suhdGTuMKWIFc64MOB2ysZSGqvshswzQW792byx?=
 =?iso-8859-1?Q?nfFCHVqTSvkZtRx80cKdmAbe7w9njoks2lUSXOO5ULw92pii23zr30YJiF?=
 =?iso-8859-1?Q?Ku70dW13Js/JmLlzajFlLrfHhej+cLZAX98ba2gFAL2ZlkFjFEY++LSBwI?=
 =?iso-8859-1?Q?ZKMLvHwm4IDEdJcXv+nAauIAHU21msb++AKST/JXdhrVQ2CJ49IIAxOBMS?=
 =?iso-8859-1?Q?HAsCPVc9KRmAZ5/3ymUSjyhi2I15KnFhPQBHkY0rwqZEuPHzBNQECnVKsu?=
 =?iso-8859-1?Q?xIHIxx+JrAqNvDu3x2nH6laNAn/DaVqcr7GuxKDkLMukUUIOOwP1LiSkP2?=
 =?iso-8859-1?Q?rgRwYDvKtlpNJCCr2b9jZl8CGdlQ3scjStAYV+gWiuXFcmJjOR/lmqEuEG?=
 =?iso-8859-1?Q?kpC1FHeT017griOzfk2vpwtux/TzKZR+BxGc38mtMXseCczh1jdIxlI/Dv?=
 =?iso-8859-1?Q?UGFtxsBDDssIM4RBQRZuRsVvJFvsnSA9tn9ePPyZ8YQb5BXfAtBfXZQbyQ?=
 =?iso-8859-1?Q?zj5xi1JllnMj9fcpDZtahHtOZ1WXBvcOiN5lToQL0KKXsX5N4tAsk8GcI3?=
 =?iso-8859-1?Q?JFW3iW0cY0yRsf/I1RTTI/sXfrzPB1osWvX6puebUV3mZ+uFnCIg/swKns?=
 =?iso-8859-1?Q?axaoJP65uEKvSliIWvxLzi/3rrAQp9+RtJivINa/t4kwVmJ1eZE1MmGMq8?=
 =?iso-8859-1?Q?0EPtK6zDJ16K19J9e49mHwpLBSbZ++WN64WWp5p9EVitFRdQFeTBxD9sgZ?=
 =?iso-8859-1?Q?zQ6fp+/2gd/NOPoWWikktTaZQpgE6Z5Pp9DDORisAo/XBsiDJNjgvrXoaA?=
 =?iso-8859-1?Q?bs8688XF1Isc9xqcM97THZq3eQQGRBREa13XO7ECTYsA1eI6UAhkfubbpB?=
 =?iso-8859-1?Q?ftUlzjl6U92hl7T2iKujxODRQlpvrpzx8Ye7HjzZJQ1AL3mCGune+WlMPB?=
 =?iso-8859-1?Q?0WcTJwl0nzyMoe/hQDHi8nFw1LrEk6zHNheYYUMnchbXAFmzRD5V5mVD3i?=
 =?iso-8859-1?Q?4Tqi/pDb7yU+0BW+GPzklzvRlz2vINsbIdwONubvYkDf/3TBRBK/iTAzYq?=
 =?iso-8859-1?Q?frA6jmBfWozx7PxHQdRxb33e8ZE4IfM6Kac5GUeJaaeFOtAfhhcMP2N5hX?=
 =?iso-8859-1?Q?Sczkg0Kfh/4AyoBKgJkYxgP6fSx6kBnqMu9elAZcQCKghnYtBi31+MUo3o?=
 =?iso-8859-1?Q?dceUWZA6rfkPOw2cB9czxBiK+c2lFAmpi8W5D8hYj9kC2mL9MovjmqgMbE?=
 =?iso-8859-1?Q?rlJ+hSVLzAxG2e8wGuH7+GlhsnKlr9c5EOTCSq+nnDYFVZnLjjyT2DBUTP?=
 =?iso-8859-1?Q?5VjAPKzSAtFvQvtDLxFaRqqSMGlSlPKN6DgH9NDYovfZDSR9kK0basLTVO?=
 =?iso-8859-1?Q?KMZjIgOVbzYgPjRJOd0HaGvlVqbWlz1p0pC+/ovYCDE18iSE4rBapYIIK8?=
 =?iso-8859-1?Q?tNBvz3w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Eo1zvymXIgTQQ3TE1wBrx71LMfwQOFVGiMOBldWL2ZNrsrpWhCfjZnhrtZ?=
 =?iso-8859-1?Q?ASH2IV1Cxnx2unsZW3KPpnR1O3kfvRBY4k9VmzUuQHeh9e+H2dU7Xx6ROO?=
 =?iso-8859-1?Q?ngkp4wgzK2ihdEoX22Vbe73JefLhKMOSybmOtb+fXAeeHBq2K1Ss7hhlDD?=
 =?iso-8859-1?Q?i0XsGq20+zeFr9srtcuL9YAQxyeEHzt3LIRcPyfM09qJan7sWJdLApFGTg?=
 =?iso-8859-1?Q?UGmjiVerpDzSejYu0jo5MxntKO9lrXrY9q43smhYxRNvM3JGkIhN/RPMLs?=
 =?iso-8859-1?Q?1CMFrAO0faiLNgE0zKhnGLhc6s9qRtBXaZimU65RZesMBYpZ97Zc/6o74R?=
 =?iso-8859-1?Q?qeTONfYkfZmrnQV6vlMlH0CNfEVhAnjERX/+3IFKn60sXFGWHP37Z554+v?=
 =?iso-8859-1?Q?bFj0iVKiE98xv0XqvesqLNrO8d5BbHK5gD83QdSPSocp2HIq2ev1kgGEPp?=
 =?iso-8859-1?Q?W+i5JVzM2+kHVgzJxaCT1J/hCL7o7Ynj7OZsKhxUUROWHPuchXOd1161Om?=
 =?iso-8859-1?Q?StNZIQCJ7NMgBz4YjrSOXoeacJWtlLmvstZKPbkK8DnlZA1dG4p5cr9TPL?=
 =?iso-8859-1?Q?B7N6bwp8IMckSYfymMeVo7AZyw8tR0WlXdnzWZleTt7yzOV2hOncmaxVdv?=
 =?iso-8859-1?Q?QBu3fqLX4U51b1U546t2+e/PrfY83e5wuP6qRQuvKRtS4oqUiMK43l7TrV?=
 =?iso-8859-1?Q?p1zCOY6Hz1xy+wMgXFJuYIIr5L4GOTgyzPPSFj2jt8C/o6tw9I6WaEUXrn?=
 =?iso-8859-1?Q?EIROtmFcIzIhrpd37UhelLoO1dWWk1l7K2M5MmDUxDBP8igjeISnMCHoY4?=
 =?iso-8859-1?Q?iGb4D566hjPd2k0XJnE46UUFjg4Cbdax/PbU0ouzMLDi5e9YOOkRz0eq4o?=
 =?iso-8859-1?Q?gdki7ldvUKij6b86JcAIScJVwvrCDl0X4SAxHfd9bcHuV1catqd74Sd+Kb?=
 =?iso-8859-1?Q?rXx4ZgcIs7OzecWihmKbv186ora1RfFaRkiJbSQmTrI/dkGaZ5y+ep8uL9?=
 =?iso-8859-1?Q?3dzh6TCEze1n+XxCNSXuWp7KA5MGnKcVIQlepyytl9qVVfGG5NX9lr6BQa?=
 =?iso-8859-1?Q?Nc0/LnPn/EnMftmoyb8orccWKP193Pmmtbp6a7bf57PGVt2yB0ZFa89C6R?=
 =?iso-8859-1?Q?zYBcyQ+oVPB8EMqOt+ZAWaIqacPdOqBPcI6RXyLbvPKTQWMf5H3oTU3Dfp?=
 =?iso-8859-1?Q?Kr4EtKm+sU83l3itB+A5nYm0tgUGOunp/4GjlZ1iTp4DjkA1PvmJi6C8q/?=
 =?iso-8859-1?Q?izP1Tawks8nX+qny3JxtmIuXaBj7fn+t+qzeKHMmat+CVSGnLeJvn47K4x?=
 =?iso-8859-1?Q?jJbF1Hp0zHXYQimDUlhJqzbFXdFCbUuurCSkIt3I6KpecKUW5B+mRiYCPe?=
 =?iso-8859-1?Q?D4YUMU5P3SjNMEQeJcRkARMEW7/lnaXKQYwPdg73suTL916asImgPERZ53?=
 =?iso-8859-1?Q?fGNMMhzeq2KBETJ5hBSGS/ZwTNVF6B1a2eXzXdxSBkz8+RWU2swRWwuU4j?=
 =?iso-8859-1?Q?N2Fuzn0naISslrMAYGKeipbgDmZHr0k/P5hSn4xzkm6ZMxuQpklv6+9lSx?=
 =?iso-8859-1?Q?yjBfTB1HdHg4XnGP7kL3SsVwTZxqNxf2vO3fSAJYU9NIyOSuZ+OLBhRpR+?=
 =?iso-8859-1?Q?KE4sATRlVorWiBAsaQdi0dRhOaMxE7tM3Na/XPZodBtU8vjCzbp+RxaA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e6009-3105-4148-3764-08ddb309825c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:25:57.9246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25XJLaW9uQK3jSWlmF3EFAbbMgjONIHzdgWGACd4jGn0sensJfN+aKmaj2Cb7WcUJ9EsA+RO+oyg+HgCPzYFO/bhwM+dC+yuuf4jP/fBAUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5543
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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
 drivers/gpio/eg20t-gpio.c           | 138 ++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/gpio/eg20t-gpio.c

diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index e350121395e..bc59a628c79 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -7,3 +7,4 @@ F:  arch/riscv/cpu/p8700/
 F:  arch/riscv/include/asm/arch-p8700/
 F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
+F:  drivers/gpio/eg20t-gpio.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e11109fb56d..3a45c1e1158 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -731,3 +731,10 @@ config SPL_ADP5585_GPIO
 	  Support ADP5585 GPIO expander in SPL.
=20
 endif
+
+config EG20T_GPIO
+        bool "Intel EG20T GPIO driver"
+        depends on DM_GPIO && DM_PCI
+        help
+          Enable this to support the GPIO controller found in the Intel EG=
20T
+          Platform Controller Hub.
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d64c14db5cf..23b18401f9a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -81,3 +81,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+=3D gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+=3D ftgpio010.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+=3D adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+=3D rzg2l-gpio.o
+obj-$(CONFIG_EG20T_GPIO)	+=3D eg20t-gpio.o
diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
new file mode 100644
index 00000000000..d41ca4bfb17
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <pci.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+#include <log.h>
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
+
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
+	struct gpio_dev_priv *uc_priv =3D dev->uclass_priv;
+
+	priv->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, PCI_REGION_MEM);
+	if (!priv->base) {
+		debug("failed to map GPIO registers\n");
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count =3D 12;
+	uc_priv->bank_name =3D "eg20t";
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
+	.priv_auto_alloc_size =3D sizeof(struct eg20t_gpio_priv),
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
