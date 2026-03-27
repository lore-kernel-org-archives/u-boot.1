Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FE210F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4D28419C;
	Fri, 27 Mar 2026 17:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="W6KbNbFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388CD83FC6; Fri, 27 Mar 2026 15:13:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2421A81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtL3JOtCoBQjm/nU9uTi5flL/YorZDxXx+X45qcvt0YxYLV+svysEf6VelMYBlDyjaOpueKyaJcFN9NIRSjg5fhSzk+e0wGOcqL01Tp2It8GyCA3MzoY/TTCjEkcM5Yr5dVBQQxVRLitWOvs9FPQYdL97MaKE9LjXsN6Ver8n9c5dehtlEP1AaD68Yeu81vGIi2E0RiKNXeK0zc8eSV2rEyGfcAaNcwKlk/F/2QHtwkD58wUWZiwYmcEZYyPiu2RNVO0EEpfiPJeppwKS/AqfR5I7vJ316immhlsWdcziirMtERtZQStnDtCPQHzj++WSnHbdmLteKinrrZ+0Y3hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJLxQ7sUu6r9oN3Yappj8c4cYmEQtf9wU8nasTXh9z0=;
 b=egRtvIMT9ne4lzVroiG57Ucx8opkHi8qeDLn6ycEoxgRI2g651wqmZ/eLkwW6NxP9vi8KEo8Vlv6+WsUKg1a4JmWEw/+oypj1wDI/YBx+LHQ7gUM1fptBj3b9fJG8bfm+vTDWy+v6W9v+Sd6YKlBN+FJq15UdoVeJeNC7CS9CmipcSmeTwOOrFdTBstEkIa+pvWCl2jfxa1FyajJQqYnSqcZ9+llapSlX+HzUG7W3ekcgmoiuB4OSwu27UWLJfTycHNcPAu96SUA0Yz+bEL5Zyu7IX+IsOXlAh9FiEhIuewl0L2S6qE7jZ6V+A04MXLrSkKls8X3+3St/WeLH2FJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJLxQ7sUu6r9oN3Yappj8c4cYmEQtf9wU8nasTXh9z0=;
 b=W6KbNbFmlyc1v39VdO7szYrqBYvhiH5ZD7tw5OdeDmBIENtIT2/rZ8FCS50kCG3UT4HdENC8x9xWwb1d/i53tsymTim0nBm4d+HeytB7Sj2KDPsbiJyVZc5FSdcvNmPPyGzWzlfGd+B+bTgOCJny0D8NBuaLUl9Fgui6bmJOSAvNSWoyfvvnS4UJQY7YvHs3J0zA9DIZLjosswMMwY505HXBmNosQxUeL+YbyMJxmoZ/yTC+GO9wPXNpPr5hqJMHAsrU9Meo3h+UZSs8qW/wVdEnFvOYJ4FYmDdOTrYjUUwDIF76UCwUIA3V9Nig5IxKA2pJrV3K7ljRRpxRbLLD3A==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GV4PR09MB8437.eurprd09.prod.outlook.com (2603:10a6:150:2da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:12:52 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:12:52 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v6 3/7] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v6 3/7] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHcvfPNGvxljGn+JEOep4agtCeCBw==
Date: Fri, 27 Mar 2026 14:12:52 +0000
Message-ID: <20260327141029.628483-4-uros.stajic@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GV4PR09MB8437:EE_
x-ms-office365-filtering-correlation-id: 0b0e30df-0ed3-4ce5-7a22-08de8c0aef7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: v8kbugYbqicGwWfjR27+GZBHUvfgHNCbkg9zRwRuvo+/ws2hEpai8XDngO64PWDqO+s6yllpE8pCO/xgzifYkv9hS8+WjTgEK/5Go0dF9BG7NrmGxPD0kXSXOL0U1+NlXG1Jn9oZBk/V9kNoJJEcOqkJFln6YZyX2vd9jJ8hW1tTam9Ar2T9Q9dK/hfZEs4nwIyr7DXlKslAV3j3jC3njsKtUP29BpvCjXw7+3k1OcXKIZoHMrFy2j4StG5gSro97zOUglyyPb4DbZcdMocjgFmfWv5skvQ3iuOPM4e5IgTgKLeT/s0DB37p4QIsazuVCLU1KUQ+nWqeHzDmF/IW2oYVJVCsJT5g8/vSVAtHGIzmiG4a7z8cWsBgDlURj4rrYmfdc6S85AWs/oKTEbxHeE5gDhRPX4vlqIwFdU/eTf/8+KN5exztHW/HR/K0rP3ak6DfrQ0sFL0o9ZT97izZFBWAVZDosYg6iKwIHN87PcpE6XyYbdhWrx1jUJcK590LgsfL6+SX8L2nzBl53eiiWEv98tl3mMUJbbNTGuWSUo9dElFNRqaaQYsohBm9StrkIAkxC8A3N014kJn+T1//MieWbnNTunzSM8sFUv+VH/wZ4MMIuRCCktqCGEIp5G6LE4Qi/i4vy9snpjlWQtNuiZ1NRjiIxGqr5C5SPwREspRXQUEXKXfEcnzvhLfdSek+l7RJqPo8PCeHWzuQ5d1Fnxetu33sj5PDxAHeCprxzpuT9aPqS6e+z02r9FmymHza4S6GnlZNTVGtNADcbfP2aLI9B8Bl2/xKalIz2Pb3PAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i9mMyfqWcZtbY3yQV3fTNskvX69UdlsmkPv8jHqYJonYDUb5PSfATCi2eA?=
 =?iso-8859-1?Q?dCD9dSpZ9b8+0CaQR+WUq6kbW6XMQc9RkaNjKr/ythJE4/z2d+EgBAqL+k?=
 =?iso-8859-1?Q?PlS8Um8AKHqvvK3FHXz2pFYX9MIvRekZMVL+WL5IWfp4NdS1IhG73cqbDt?=
 =?iso-8859-1?Q?/b2NgRasIEYo77qc2TsSdWLkOSp1+OtwT97PqPhzb5MyfhrpA14EJ8GgqG?=
 =?iso-8859-1?Q?GLi+gQqPSIfokvI25Zn18w+k9BqzCobNTz4saWF1B8ZGhp08ZvrAMQwXld?=
 =?iso-8859-1?Q?Qllgr5+fVv5sDavdVRE4SyXkc/L1KBZrL04k7Fzxk0CJBLGDW+G55kN8kl?=
 =?iso-8859-1?Q?3M31LcQFm8dGa2y+0rW0zWRHxMG92EZAuTA7jqLxk5LJPsibQjtsNpVw4x?=
 =?iso-8859-1?Q?5Dj4Lk5sRSECydufN37/ZODRrCwBEC7+PRVGGyZdS5jVx4MhShOkwRFoNN?=
 =?iso-8859-1?Q?myTMLYNaGUJklR+d2EhhQYKMFuAcUIC4aPDjj0UPVe+2HrZUxzdHLxFctH?=
 =?iso-8859-1?Q?BPcJHS4nugZGtqprhLW6HDYfNgmmjj+tf8hX/lje4esf7PDx3BbvoSjXUB?=
 =?iso-8859-1?Q?2QlngVdk6B/PNu/sNSpVP2ZZ+Mqr+KDecgydkR/L0V3as1gMhsu/uG99Ps?=
 =?iso-8859-1?Q?3hZ6g+Ajmc/WpTnNRNYxn+otZ1wiJ8Ji6QpjTGMu1eDFh3Wr0mjakIWjFb?=
 =?iso-8859-1?Q?ZRqOF6Z+tLCXjzleDPtLSp2o2k0cieL+ptihsl+D+FWV9nxwRXKkfl+hlY?=
 =?iso-8859-1?Q?tZrmVgcRo7aMpSe9q45ty9JRqrmJNoxQKtFy1vBtSvsPKixL27lydAYV9h?=
 =?iso-8859-1?Q?sDpurikb8vw+R7C1DaPx6a5iILYlvZeaSpaUctgig/J4wA9uQdqWNyN7Uw?=
 =?iso-8859-1?Q?K70tfvM8OrSiRqpzyTIdcM6SAxGlEjgdYHJbhk2tf6VJqRN6/Msgdb/9BC?=
 =?iso-8859-1?Q?dPndiaN1nF/oV/GTxcjwvSgemN1fKqUWgC0h9ivjQw1eNSwO8cT72kJApY?=
 =?iso-8859-1?Q?riwg+VCN5vMIj3v7yiojzsuJjcX1Dg5ph2WoJDXdfeLoOFXTIodK3Dc9tY?=
 =?iso-8859-1?Q?m1wUiaKGjI2+dUS5Qz9PnYUdnRmWHwh7twqM1+E2s+k4RAAsu3P11VqzeH?=
 =?iso-8859-1?Q?MkY65LtZXRTUVoOEzV0LXXk2rrrTL7gzaYeOWqAPO9EaUlkvAzlpx+iYEW?=
 =?iso-8859-1?Q?Dsb/qcoBuAlzuWIQkn52ZMnFM6pJlto0vXM3KmM85b9hZpC8FJMvdF/Yox?=
 =?iso-8859-1?Q?9xT4qrDddPKXA3dZ0hM1ilwTL6WSMVTkfySl2+TN3//BGxkt38eXZciqZC?=
 =?iso-8859-1?Q?izAlWFpmQNChllaFTtUR73f4LBaR4mRe810Z/+h0aGRJO4LNsGu8KRUf5W?=
 =?iso-8859-1?Q?FHVVkMdihgrE7Zm3NjmwxmGM8ry8hIigNL8vCctaGPvlCCEp+htx46JpSo?=
 =?iso-8859-1?Q?uLJoeWaSbNZliR5NiAGpta3o7sDbo8335Ghy94Tayd6SnFaf47sdCfZLYe?=
 =?iso-8859-1?Q?d4iZ9q0gXMmJxiPif1pWJwk3jxZKlEThjgVr3oa6rlbsTB4kVPbMYBCsCg?=
 =?iso-8859-1?Q?/1JmNXcgYzuRDEtiiI1lrdZfhq6FnydWOd0WehIpvIIBbWMg2uNf5TfbPd?=
 =?iso-8859-1?Q?DBIfMKiYVJa0FR8a/4AH56taJZIYQhQeMA8A9XQoxIxA8UKatfZ2cTUIb0?=
 =?iso-8859-1?Q?DJxF9OvH2XtQG1jUmDkZIp/rG8At6la91SXZoaoCQUP3GCOAAWUDE9Wnb+?=
 =?iso-8859-1?Q?u5L5tz2K3/bvFPqtIdVl/609/DEgmUzJTvIFWESIJaUOMEuYw3iu7za8q7?=
 =?iso-8859-1?Q?Ztcneq/8STbQbCUhriwrtETlLx2cOHI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0e30df-0ed3-4ce5-7a22-08de8c0aef7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:12:52.8431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3vwVXso8xQgZEXlrdZsjtPziPX9pL7YIGGWP2pB3JYe+mFKcHkK5SrcUFjPS5uY4AvpWELDnAejeA00KsRyCUkKBzAq9wxYm7dIUUxb/lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB8437
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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
index 60c5c54688e..66d99ba6c98 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -747,4 +747,11 @@ config MPFS_GPIO
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
index 910478c0c7a..3a823614253 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+=3D gpio_slg7xl45106.o
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
