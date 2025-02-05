Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C14C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4223080C7E;
	Wed,  5 Feb 2025 14:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="hv5OD8C6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9151D80207; Wed,  5 Feb 2025 11:15:58 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3847E80711
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFo1xhOJZ6HK7yh/U7uRI+cfCBPwah+cet8FFmwIKdYOHtayOZSVyuwEjoX87YTtNlnS2BGWbk685DtM1HfLMR8YUJwCeiBL70GXgfEloiDnD+58u5+isRjgIQpTUY1nLg24OJZh+MjoUa7NdFiSEVezSm7K8G5HjQE0mNzYN9YGI9H682C8DvZgXWqBg0N5e0l8gOnfmRDWJ92WHZE7gDm0dj93i9MhEtNKwCPfmvDcbffiDJmRgVeDqHGVMKN13wjAk7TI+HMCdnWSnLEqBloUD+s3SC/AdSHHHT+K6njBMpEF+eSSNzqEQ6I8yxXg3Y02nA+UWVNH6PlVNB7v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCFxh7qrjP8/0K25Ubemmvb9B3rHJMr/nVvIEIflTl0=;
 b=RbJTzZszB/Jg+1qyJph7u4REBQk1nhGVCwljShJJ5xETl8MxPxO1l0PxyF7mhAm5wjapNhzhRsnd8njX+anTW3dy0Yk1KIqXFDl7pOfuWBCfBcnfmL5YkAlutEDzmoHrX40UqRgs0qecTCrA4QYQ15DwtN85T20ibjCPmwp0ZIMPBbtZeoJdmqcgy8XXWfWwQteOHV2KsJbVhr/8J3KkCHPYLg0/32JCKX/zf08/CmKzwsMWDnav42+FI8kNGzRSbAzopR0884y/bO1ZjgMkLDBkvOm3PpHLiqtNJMPiFuo7fLmESVrl2Hn/thmjaBfG1Yl8JmWrWJ0GgwVepx1QsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCFxh7qrjP8/0K25Ubemmvb9B3rHJMr/nVvIEIflTl0=;
 b=hv5OD8C6Lqq96iFqh7NUqxhnPtML0eaSHPPK6AZsiIGaKNN7Niy5xaW5h5yVxWRY6uNCpoMtzItbIOHxrFn/hPmYbMQd8yXxP3fPjWFvo/GPoJ05Ugq1lh3vyueVWks7ki4SAvJ/8X1/mc7BTEIAFy/no65cNMl52oTWjdwCdv+n3joFL73b770QwG2YWHx+vbiMABvoGGV/nX4hsTr/PgVYjpVlYQlVaGNttR4/LSBGly9GaGB3YmWbXAO6v3s5aVZypu8khJgvdCWLDUyWtPHf5NdzOTt5qIXC/LsQIzpKl7Rpq4P3A7bsAerhhFCsMSlgrp7Fhu9K/YIkxgDydA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:50 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:50 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 13/20] drivers: clk: introduce clock driver for RP1
Thread-Topic: [RFC PATCH v1 13/20] drivers: clk: introduce clock driver for RP1
Thread-Index: AQHbd7brDjRxS0Vj0UK0xdoVp3M/+g==
Date: Wed, 5 Feb 2025 10:15:46 +0000
Message-ID: <2562959a824dd9268e5a2ccd93c67232614a5e1d.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: d0e7caaa-85ca-4f69-5a46-08dd45ce1104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nPaunY5ETTv1Uj7d8rxbWTVI5olnivr7/70ar2ZbRqVkGV0EOxSlF4ByPX?=
 =?iso-8859-1?Q?SEn2iRJfrVC5nnTbAznnr8b9m15TbKiUUB/cV7wxIIf3hD2mcsnm4X4nrm?=
 =?iso-8859-1?Q?qCWF2y9cJh/mC15lwc4o9Eysku+4U4YW9S3qwRbNRYskhFOv4ZZwsGNvHy?=
 =?iso-8859-1?Q?P/ad7lHIHcWi3cTO+kZV/19Q5wdaLTxxaV2hMzGA6HghlRxhqO3UF+504D?=
 =?iso-8859-1?Q?/L4OehXERrFRVAqXflBZlgngBcNPYaaT49kVZIYXHbFA5P83AXETRQMbN8?=
 =?iso-8859-1?Q?lHVaUdjhNO616wpEcYPOWemm3lZCC0t4GvWhtF7Oqu8q+kXkDhitu/F8Eu?=
 =?iso-8859-1?Q?q2xM8GaeZbeFtXhAtjwGjZJPosaEjykKd6X9XJytKi0bzLMuUSSvGBQhRL?=
 =?iso-8859-1?Q?Tcfb7RPPfLDlgFxpGcTW0RXKxqGkxOjaA70LtC4GA2BmhBjn7Eds3LSuCP?=
 =?iso-8859-1?Q?m4Sd7XE3fwlsQCoWqvpe3C24dV5eYJajd2HS1joOU2GIcyerWsGlSJcAGK?=
 =?iso-8859-1?Q?CqV3TBEXdSpd5Th86JmIBmSvRV0nH2rklnoh4wawU2QDNt1bXYGWQXUxY5?=
 =?iso-8859-1?Q?decKS8s+LnRI6WzhpVEOQbbk4UlNqcws+wR4k0V4qFjR2qlX8K1srz8vaR?=
 =?iso-8859-1?Q?zBN9XPrzAkQ/cXnYwBtvd57bAaT7ppBQ/wJCFKsi618d9pHW32fj/o+sgk?=
 =?iso-8859-1?Q?g+iXRO/Et5OwMiMxzJAvW6rwWPUWxcnH78++Ryjo2QnhxU3iDJQS0elL/K?=
 =?iso-8859-1?Q?TtTXkMCqIY838Qck2gFabqUK8sr43ODfoKxbZ7kOTePCKqvviWuHQR0bDA?=
 =?iso-8859-1?Q?45SgBQt0gP8ixNEoLD3ZcSDmDAmjJnXVe1KH8RM/7Q+Y25bVufDRoqWzIH?=
 =?iso-8859-1?Q?8p03A9P4Vhzlj0s0VUW8/tv6XwBCrC0aw3L6JNSVzEARoNhLd+YWSC9PmW?=
 =?iso-8859-1?Q?kUC4XY7Aod4RwiQh56LcvRzHaTsYj64yfpk4z2L5Ini9qPKsbZTd7o7XvW?=
 =?iso-8859-1?Q?pdE8DG50QBbZIdRVQ7DZ0xlH5RfOyuEjoOsiWId6ksCwBCREiDNj3hE659?=
 =?iso-8859-1?Q?SMCjlEBbg/v8IO0fWjSr2Rn+KXhjaU3XkmVgvESf7ad+F/5WHqvpil/00l?=
 =?iso-8859-1?Q?K0UHulRb9qlQ23Q/iOi189lpbGAp8Q7ksV1aSa/zkpHrt1u9reQ7G6SCNp?=
 =?iso-8859-1?Q?p86wlFihwMonnMN7kTuZeZG+vx2Cxmdc/1UoP3jI+TGvu7gNwGInFiK/DK?=
 =?iso-8859-1?Q?7ohJmalGqjdxKB6jOrDshMWXp579RXVg0DQ8wFt3rbCgHvbM9ATtAEnN1i?=
 =?iso-8859-1?Q?2P4bjCBNqeBbL2Q94cHV01es6ptnHfw61rOM71uJqI7vROJLgLTb0zI/XG?=
 =?iso-8859-1?Q?HKa7tKb8P/0JIIu/3Ldx7m5SQhOskmLn+GAYhXFtCNkTz4FcujbN8KGzpy?=
 =?iso-8859-1?Q?a4QSWsd983M9X9k+YPyldwXmtBr7b3qZd/mHYdoKl/Wyg1HvI7gDu+MD7T?=
 =?iso-8859-1?Q?ez2KQqzH+RBqipQ0WEwH6c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tAK9bQmZ8cBtypqlnnAeVrdy08VWEZopPLwqX7S/O6c+Mn0V1pIdKga5qh?=
 =?iso-8859-1?Q?1NBAyfMqnxKq4Lr8tjfYn0oiwcoZegdliKrYAlgkQpGPffev1qRCL2wfno?=
 =?iso-8859-1?Q?rOdL+tbVuLoedHWWRHUV9NcxcrBW+/5f/1/16LDFQaz0nhA39160NlyC0l?=
 =?iso-8859-1?Q?Or9eUd/azxI5mOA3xyGEI/bq6wjhwc27GzKNhvUyYdbLlui4tzHTVRmlmt?=
 =?iso-8859-1?Q?yWSf7WE2khsT2dYpIDRNzE/f2gyPEX63yRtRWPr6mKoGQcBTWjQ8PxFgN6?=
 =?iso-8859-1?Q?JMkpzjwPnDpV3ig7qyfgQP5658+lYxkybpKAB/FXtv/VG6dIr/jAh7lEdz?=
 =?iso-8859-1?Q?8EeukcsfLLglE0S8eVFW1s7vwlkZh/itUJCUQdpItdwQMM0IkS6esZpy13?=
 =?iso-8859-1?Q?OwIGOM+ae/fJIIlkh8zskpoULcEvO5f+PxOm1S+u/Geks6mqVHYaQoPU0V?=
 =?iso-8859-1?Q?rB/bs52L6kCFtzudsdxVVUbfdNLgrhhdFKNmkaTmMx2qtP8nawHRILp+3d?=
 =?iso-8859-1?Q?8oeLVCdkVo36WeRpfJ2o5OVZz8DzjU1cKZbpbY8HLQfPjpN4Z2bZdYfGA1?=
 =?iso-8859-1?Q?j6BMqYjuYRjiXkROsqDKmCm6LrTLM2gf3Yae5XHMemQ+iw8jUPRd/qY+xV?=
 =?iso-8859-1?Q?v3PXHTyh7HRj7fadWdfEE8F1OtnvJD5yYlcA67oF553H5xKv+5WJwUCbM9?=
 =?iso-8859-1?Q?bh1hKTPjP+5QPi6F1nU1QQft27JdQXfbN8g57tqoIU9K/RBnJqW1nSRFqk?=
 =?iso-8859-1?Q?nwpExSPuk1WIHNwlD/Is3j0HhlqPWv37/zV0/c/vDmyGSIdCwnXc0669vp?=
 =?iso-8859-1?Q?MC/5KjeyOwJmLAK/sF15fr1Ihihp3vbrTC0PtJegt+tyFjOiHV+ahClpKl?=
 =?iso-8859-1?Q?d6QdH+NItAIPpfwrgQhtElYY9XEC0fQSC4uLQV/DUY2q4a6hnr1xibTp5J?=
 =?iso-8859-1?Q?taYvjrV7QTqX7sm514l0GsUA1ajkCETWjZzDC4reLFXwvQO8TteKotTiwB?=
 =?iso-8859-1?Q?mRT4q5OzYQE/nRddldNJMdV58cIj4IGVwPErcBBiPCNv7RsBVe1cGLv0Ea?=
 =?iso-8859-1?Q?zijUCufsUGeGY98JSDHe0E4RLBMxm7dQhb8Au1ZmbBfpA4UcxnykfPjdOl?=
 =?iso-8859-1?Q?WWHoQ3A8UkrBJMSq3N3xceBgmRg+n+BpGEdI8venWKUssVRbGptMyAn8Iu?=
 =?iso-8859-1?Q?Uo7wJL6noNVtNayi1xspqzxyaoTtlL6bTLyj+9Zi21udhX6PUm9rDzcV7L?=
 =?iso-8859-1?Q?62gqGRtICt5oMo14Ib4fdVNi6LrGs39GpTe5oL/N9rdkcx1bCkR1Pj5d1z?=
 =?iso-8859-1?Q?4D2RjZDv1Udd2kPaw2YV605FcDX7V7W1DHbLprWJvO1EjJY13i9vrhOCfG?=
 =?iso-8859-1?Q?6nbGJCc2PCvLlCHhYNGRMkyzTvgGds7SgtR9rhyskgtwWD0I1sYxnFld1A?=
 =?iso-8859-1?Q?O2CMqmx0s8Gm7d8tWN0qwj6SKh88mhr2PIL1ie89Km4AWj3rhQYNnfandh?=
 =?iso-8859-1?Q?rgenoL7XkT3MfJJeuPnL0s2J9qcb1nAnZoXDAHu/S05ASnd3GyJrnGTxbn?=
 =?iso-8859-1?Q?zKpROBr5J2pY9KTIaHQjN59bFi5SkHmNTgLangWYe2Lkm4korVNau0JLU+?=
 =?iso-8859-1?Q?t/G59CL8rc1bgTKUZdTBRfdki0NYxqbU9jiWJ6Wv+PFH1H3O7e2mGY/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e7caaa-85ca-4f69-5a46-08dd45ce1104
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:46.2985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdgVPzJFrvpuYaDFJ/DDvUE7lcdTkw/h4oWGvpVGSOA8SC/amvIRad3e6c90QEGcSzvzEMyn/s82/agzBM2AvDsOQa6nwSm9hs+A88jH3aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Introduce clock driver for RPI5 RP1 chip. It is intended to
work with a clock controller connected to the RP1 chip of RPI5.
Current implementation supports only RP1_CLK_ETH_TSU clock.
Additional clock could be added to the rp1_data array if needed.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/clk/Kconfig   |   7 ++
 drivers/clk/Makefile  |   1 +
 drivers/clk/clk-rp1.c | 280 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 drivers/clk/clk-rp1.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 017dd260a5..869d7591a6 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -163,6 +163,13 @@ config CLK_OCTEON
 	help
 	  Enable this to support the clocks on Octeon MIPS platforms.
=20
+config CLK_RP1
+	bool "Raspberry Pi RP1-based clock support"
+	depends on PCI && CLK
+	help
+	  Enable common clock framework support for Raspberry Pi RP1
+	  support.
+
 config SANDBOX_CLK_CCF
 	bool "Sandbox Common Clock Framework [CCF] support "
 	depends on SANDBOX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 638ad04bae..74d1408369 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_MACH_PIC32) +=3D clk_pic32.o
 obj-$(CONFIG_SANDBOX_CLK_CCF) +=3D clk_sandbox_ccf.o
 obj-$(CONFIG_SANDBOX) +=3D clk_sandbox.o
 obj-$(CONFIG_SANDBOX) +=3D clk_sandbox_test.o
+obj-$(CONFIG_CLK_RP1) +=3D clk-rp1.o
diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
new file mode 100644
index 0000000000..94e1227134
--- /dev/null
+++ b/drivers/clk/clk-rp1.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Clock driver for RP1 PCIe multifunction chip.
+ *
+ * Copyright (C) 2024 EPAM Systems
+ *
+ * Derived from linux clk-rp1 driver
+ *   Copyright (C) 2023 Raspberry Pi Ltd.
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/math64.h>
+
+#include <dt-bindings/clk/rp1.h>
+
+#define GPCLK_OE_CTRL			0x00000
+
+#define CLK_ETH_TSU_CTRL		0x00134
+#define CLK_ETH_TSU_DIV_INT		0x00138
+#define CLK_ETH_TSU_SEL			0x00140
+
+#define FC_NUM(idx, off)		((idx) * 32 + (off))
+
+#define DIV_INT_8BIT_MAX		0x000000ffu /* max divide for most clocks */
+
+/* Clock fields for all clocks */
+#define CLK_CTRL_ENABLE			BIT(11)
+#define CLK_DIV_FRAC_BITS		16
+
+#define KHz				1000
+#define MHz				(KHz * KHz)
+
+#define MAX_CLK_PARENTS	16
+#define DIV_U64_NEAREST(a, b) div_u64(((a) + ((b) >> 1)), (b))
+
+struct rp1_clockman {
+	struct udevice *dev;
+	void __iomem *regs;
+	spinlock_t regs_lock; /* spinlock for all clocks */
+};
+
+struct rp1_pll_core_data {
+	const char *name;
+	u32 cs_reg;
+	u32 pwr_reg;
+	u32 fbdiv_int_reg;
+	u32 fbdiv_frac_reg;
+	unsigned long flags;
+	u32 fc0_src;
+};
+
+struct rp1_pll_data {
+	const char *name;
+	const char *source_pll;
+	u32 ctrl_reg;
+	unsigned long flags;
+	u32 fc0_src;
+};
+
+struct rp1_pll_ph_data {
+	const char *name;
+	const char *source_pll;
+	unsigned int phase;
+	unsigned int fixed_divider;
+	u32 ph_reg;
+	unsigned long flags;
+	u32 fc0_src;
+};
+
+struct rp1_pll_divider_data {
+	const char *name;
+	const char *source_pll;
+	u32 sec_reg;
+	unsigned long flags;
+	u32 fc0_src;
+};
+
+struct rp1_clock_data {
+	const char *name;
+	const char *const parents[MAX_CLK_PARENTS];
+	int num_std_parents;
+	int num_aux_parents;
+	unsigned long flags;
+	u32 oe_mask;
+	u32 clk_src_mask;
+	u32 ctrl_reg;
+	u32 div_int_reg;
+	u32 div_frac_reg;
+	u32 sel_reg;
+	u32 div_int_max;
+	unsigned long max_freq;
+	u32 fc0_src;
+};
+
+struct rp1_pll_core {
+	struct clk hw;
+	struct rp1_clockman *clockman;
+	const struct rp1_pll_core_data *data;
+	unsigned long cached_rate;
+};
+
+struct rp1_pll {
+	struct clk hw;
+	struct clk_divider div;
+	struct rp1_clockman *clockman;
+	const struct rp1_pll_data *data;
+	unsigned long cached_rate;
+};
+
+struct rp1_pll_ph {
+	struct clk hw;
+	struct rp1_clockman *clockman;
+	const struct rp1_pll_ph_data *data;
+};
+
+struct rp1_clock {
+	struct clk hw;
+	struct rp1_clockman *clockman;
+	const struct rp1_clock_data *data;
+	unsigned long cached_rate;
+};
+
+struct rp1_clk_change {
+	struct clk *hw;
+	unsigned long new_rate;
+};
+
+struct rp1_clk_change rp1_clk_chg_tree[3];
+
+static inline
+void clockman_write(struct rp1_clockman *clockman, u32 reg, u32 val)
+{
+	writel(val, clockman->regs + reg);
+}
+
+static inline u32 clockman_read(struct rp1_clockman *clockman, u32 reg)
+{
+	return readl(clockman->regs + reg);
+}
+
+static struct rp1_clock_data rp1_data[] =3D {
+[RP1_CLK_ETH_TSU] =3D {
+			.name =3D "clk_eth_tsu",
+			.parents =3D {"xosc",
+				    "pll_video_sec",
+				    "clksrc_gp0",
+				    "clksrc_gp1",
+				    "clksrc_gp2",
+				    "clksrc_gp3",
+				    "clksrc_gp4",
+				    "clksrc_gp5"},
+			.num_std_parents =3D 0,
+			.num_aux_parents =3D 8,
+			.ctrl_reg =3D CLK_ETH_TSU_CTRL,
+			.div_int_reg =3D CLK_ETH_TSU_DIV_INT,
+			.div_frac_reg =3D 0,
+			.sel_reg =3D CLK_ETH_TSU_SEL,
+			.div_int_max =3D DIV_INT_8BIT_MAX,
+			.max_freq =3D 50 * MHz,
+			.fc0_src =3D FC_NUM(5, 7),
+	},
+};
+
+static u32 rp1_clock_choose_div(unsigned long rate, unsigned long parent_r=
ate,
+				const struct rp1_clock_data *data)
+{
+	u64 div;
+
+	/*
+	 * Due to earlier rounding, calculated parent_rate may differ from
+	 * expected value. Don't fail on a small discrepancy near unity divide.
+	 */
+	if (!rate || rate > parent_rate + (parent_rate >> CLK_DIV_FRAC_BITS))
+		return 0;
+
+	/*
+	 * Always express div in fixed-point format for fractional division;
+	 * If no fractional divider is present, the fraction part will be zero.
+	 */
+	if (data->div_frac_reg) {
+		div =3D (u64)parent_rate << CLK_DIV_FRAC_BITS;
+		div =3D DIV_U64_NEAREST(div, rate);
+	} else {
+		div =3D DIV_U64_NEAREST(parent_rate, rate);
+		div <<=3D CLK_DIV_FRAC_BITS;
+	}
+
+	div =3D clamp(div,
+		    1ull << CLK_DIV_FRAC_BITS,
+		    (u64)data->div_int_max << CLK_DIV_FRAC_BITS);
+
+	return div;
+}
+
+static ulong rp1_clock_set_rate(struct clk *hw, unsigned long rate)
+{
+	struct rp1_clockman *clockman =3D dev_get_priv(hw->dev);
+	const struct rp1_clock_data *data =3D &rp1_data[hw->id];
+	u32 div =3D rp1_clock_choose_div(rate, 0x2faf080, data);
+
+	if (hw->id !=3D RP1_CLK_ETH_TSU)
+		return 0;
+
+	WARN(rate > 4000000000ll, "rate is -ve (%d)\n", (int)rate);
+
+	if (WARN(!div,
+		 "clk divider calculated as 0! (%s, rate %ld, parent rate %d)\n",
+		 data->name, rate, 0x2faf080))
+		div =3D 1 << CLK_DIV_FRAC_BITS;
+
+	spin_lock(&clockman->regs_lock);
+
+	clockman_write(clockman, data->div_int_reg, div >> CLK_DIV_FRAC_BITS);
+	if (data->div_frac_reg)
+		clockman_write(clockman, data->div_frac_reg, div << (32 - CLK_DIV_FRAC_B=
ITS));
+
+	spin_unlock(&clockman->regs_lock);
+
+	return 0;
+}
+
+static int rp1_clock_on(struct clk *hw)
+{
+	const struct rp1_clock_data *data =3D &rp1_data[hw->id];
+	struct rp1_clockman *clockman =3D dev_get_priv(hw->dev);
+
+	if (hw->id !=3D RP1_CLK_ETH_TSU)
+		return 0;
+
+	spin_lock(&clockman->regs_lock);
+	clockman_write(clockman, data->ctrl_reg,
+		       clockman_read(clockman, data->ctrl_reg) | CLK_CTRL_ENABLE);
+	/* If this is a GPCLK, turn on the output-enable */
+	if (data->oe_mask)
+		clockman_write(clockman, GPCLK_OE_CTRL,
+			       clockman_read(clockman, GPCLK_OE_CTRL) | data->oe_mask);
+
+	spin_unlock(&clockman->regs_lock);
+
+	return 0;
+}
+
+static int rp1_clk_probe(struct udevice *dev)
+{
+	struct rp1_clockman *clockman =3D dev_get_priv(dev);
+
+	spin_lock_init(&clockman->regs_lock);
+
+	clockman->regs =3D dev_remap_addr(dev);
+	if (!clockman->regs)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id rp1_clk_of_match[] =3D {
+	{ .compatible =3D "raspberrypi,rp1-clocks" },
+	{ /* sentinel */ }
+};
+
+static struct clk_ops rp1_clk_ops =3D {
+	.set_rate =3D rp1_clock_set_rate,
+	.enable =3D rp1_clock_on,
+};
+
+U_BOOT_DRIVER(clk_rp1) =3D {
+	.name =3D "rp1-clk",
+	.id =3D UCLASS_CLK,
+	.of_match =3D rp1_clk_of_match,
+	.probe =3D rp1_clk_probe,
+	.ops =3D &rp1_clk_ops,
+	.priv_auto	=3D sizeof(struct rp1_clockman),
+	.flags =3D CLK_IGNORE_UNUSED,
+};
--=20
2.34.1
