Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF727C19F4F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 00:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D7188724;
	Thu, 25 Apr 2024 02:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="Zg51LRcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB77D8872B; Thu, 25 Apr 2024 02:06:14 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 374CC88726
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 02:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-618944792c3so4813857b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714003566; x=1714608366;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBj9TijHfGZ4JOl4dYtK9zkbph1SAj1YBO52ABb4JFY=;
 b=Zg51LRcEZYPS3Kxs9JDrG1R+mmnObSb9Nlf9mAnem3TR2Zuv+fQ0qjtMXtuiOACs1K
 MUkxBYbbL37Y6gYZIEdNt4f52g8JQSbDrVbBmAO3KxuC/ahthErgCV4ER0L1L2a9RTz2
 DmZ4eXcOh19zfdMK0G5FAd3K7iQuGpCon/1trzVWilMpsmiL7gEGxizscMWba25zHTek
 OQU/Ab+zH+i+HkisPWv5k5wWgPJpwk/PHDrVzuDTFMlzdP95jQdz/uWqf40SeGM56bmI
 tNwlIzB16xPfOU0nKgaUboDHwsGWDd77f0+iRkYac5AcVXuG/Uw1TAbxLEw919WnM9Z7
 u1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003566; x=1714608366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBj9TijHfGZ4JOl4dYtK9zkbph1SAj1YBO52ABb4JFY=;
 b=BdWqajS+fJlhgRrY0JM1MdYZyS85WHFitWFMx7KRfYBC3EPpA8H+Bb6FnxU7KZbzpi
 yXENZ1P9P/z7V+lW2I/Fh4/oiuUliJibpAkqdWf/I7Mb0HLkIHs81P2q+ZkF6LuQQolP
 f1e2PASv827MRKrbHqf+o9UDFRA+PUHR+OPjgDn2oeCPiPbwe4zrRH3NS1pLxH1pr3pK
 tvxFz7vkkiUe3XjSZFZvBB0sg/N8PT2Yy+ErDAzOsnz7/jh0MQhXBPUpMs7QOZUCJt0s
 9/kOeGWz0clh/j6nN2aovRPaheWN0SlCUQX2SSbO6x1CwoMRijYEslIPkqoqvmC++fHO
 TS6g==
X-Gm-Message-State: AOJu0YwAfmu51YEHgOoPEMI/A3lXPIh+eqqj1dWsyRL7U4WSfUp6/ni3
 OoDmL8lcvMRlJk9/VpRPfQYVcFgwPJLXBwTPSweggyeArhb/zNAlrvRFCQZ+9GAaqkl1RoN8Fbc
 icA==
X-Google-Smtp-Source: AGHT+IHgLCbMnL21ZU7tb31CptMb8Rw2ibP+EfY+HJal1AZgiQQBx3SJPAGwxAeXyVzb/71YHavuUA==
X-Received: by 2002:a05:690c:3813:b0:61b:15c9:fd39 with SMTP id
 jx19-20020a05690c381300b0061b15c9fd39mr4548057ywb.24.1714003564987; 
 Wed, 24 Apr 2024 17:06:04 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 t201-20020a8183d2000000b0061870c6e41csm3291753ywf.6.2024.04.24.17.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:06:03 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/4] drivers: clk: adi: Add in SC5XX-family clock driver
Date: Wed, 24 Apr 2024 20:04:01 -0400
Message-ID: <20240425000515.21896-3-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds support for the SC5XX clock trees which are required for reading
clock speeds on the SoCs. This is largely a port of the same support for
Linux, which has not yet been submitted upstream.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

(no changes since v1)

 MAINTAINERS                                 |   1 +
 drivers/clk/Kconfig                         |   1 +
 drivers/clk/Makefile                        |   1 +
 drivers/clk/adi/Kconfig                     |  83 ++++++
 drivers/clk/adi/Makefile                    |  16 +
 drivers/clk/adi/clk-adi-pll.c               |  93 ++++++
 drivers/clk/adi/clk-adi-sc57x.c             | 206 +++++++++++++
 drivers/clk/adi/clk-adi-sc58x.c             | 222 ++++++++++++++
 drivers/clk/adi/clk-adi-sc594.c             | 231 +++++++++++++++
 drivers/clk/adi/clk-adi-sc598.c             | 308 ++++++++++++++++++++
 drivers/clk/adi/clk-shared.c                |  48 +++
 drivers/clk/adi/clk.h                       | 123 ++++++++
 include/dt-bindings/clock/adi-sc5xx-clock.h | 271 +++++++++++++++++
 13 files changed, 1604 insertions(+)
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-adi-pll.c
 create mode 100644 drivers/clk/adi/clk-adi-sc57x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc58x.c
 create mode 100644 drivers/clk/adi/clk-adi-sc594.c
 create mode 100644 drivers/clk/adi/clk-adi-sc598.c
 create mode 100644 drivers/clk/adi/clk-shared.c
 create mode 100644 drivers/clk/adi/clk.h
 create mode 100644 include/dt-bindings/clock/adi-sc5xx-clock.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f743ce9f9d..78e3d59f96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -609,6 +609,7 @@ S:	Supported
 T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
+F:	drivers/clk/adi/
 F:	include/env/adi/
 
 ARM SNAPDRAGON
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 017dd260a5..d8c619add4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -246,6 +246,7 @@ config CLK_ZYNQMP
 	  This clock driver adds support for clock realted settings for
 	  ZynqMP platform.
 
+source "drivers/clk/adi/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/at91/Kconfig"
 source "drivers/clk/exynos/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 638ad04bae..847b9b2911 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_COMPOSITE_CCF) += clk-composite.o
 obj-$(CONFIG_$(SPL_TPL_)CLK_GPIO) += clk-gpio.o
 
+obj-y += adi/
 obj-y += analogbits/
 obj-y += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
diff --git a/drivers/clk/adi/Kconfig b/drivers/clk/adi/Kconfig
new file mode 100644
index 0000000000..5745bedf88
--- /dev/null
+++ b/drivers/clk/adi/Kconfig
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+config COMMON_CLK_ADI_SHARED
+	bool "Enable shared ADI clock framework code"
+	help
+	  Required for shared code between SoC clock drivers. Automatically
+	  selected by an appropriate SoC-specific clock driver version.
+
+config COMMON_CLK_ADI_SC598
+	bool "Clock driver for ADI SC598 SoCs"
+	select DM
+	select CLK
+	select CLK_CCF
+	select OF_CONTROL
+	select CMD_CLK
+	select SPL_DM if SPL
+	select SPL_CLK if SPL
+	select SPL_CLK_CCF if SPL
+	select SPL_OF_CONTROL if SPL
+	select COMMON_CLK_ADI_SHARED
+	depends on SC59X_64
+	help
+	  This driver supports the system clocks on Analog Devices SC598-series
+	  SoCs. It includes CGU and CDU clocks and supports gating unused clocks.
+	  Modifying PLL configuration is not supported; that must be done prior
+	  to booting the kernel. Clock dividers after the PLLs may be configured.
+
+config COMMON_CLK_ADI_SC594
+	bool "Clock driver for ADI SC594 SoCs"
+	select DM
+	select CLK
+	select CLK_CCF
+	select OF_CONTROL
+	select CMD_CLK
+	select SPL_DM if SPL
+	select SPL_CLK if SPL
+	select SPL_CLK_CCF if SPL
+	select SPL_OF_CONTROL if SPL
+	select COMMON_CLK_ADI_SHARED
+	depends on SC59X
+	help
+	  This driver supports the system clocks on Analog Devices SC594-series
+	  SoCs. It includes CGU and CDU clocks and supports gating unused clocks.
+	  Modifying PLL configuration is not supported; that must be done prior
+	  to booting the kernel. Clock dividers after the PLLs may be configured.
+
+config COMMON_CLK_ADI_SC58X
+	bool "Clock driver for ADI SC58X SoCs"
+	select DM
+	select CLK
+	select CLK_CCF
+	select OF_CONTROL
+	select CMD_CLK
+	select COMMON_CLK_ADI_SHARED
+	depends on SC58X
+	help
+	  This driver supports the system clocks on Analog Devices SC58x-series
+	  SoCs. It includes CGU and CDU clocks and supports gating unused clocks.
+	  Modifying PLL configuration is not supported; that must be done prior
+	  to booting the kernel. Clock dividers after the PLLs may be configured.
+
+config COMMON_CLK_ADI_SC57X
+	bool "Clock driver for ADI SC57X SoCs"
+	select DM
+	select CLK
+	select CLK_CCF
+	select OF_CONTROL
+	select CMD_CLK
+	select COMMON_CLK_ADI_SHARED
+	depends on SC57X
+	help
+	  This driver supports the system clocks on Analog Devices SC57x-series
+	  SoCs. It includes CGU and CDU clocks and supports gating unused clocks.
+	  Modifying PLL configuration is not supported; that must be done prior
+	  to booting the kernel. Clock dividers after the PLLs may be configured.
diff --git a/drivers/clk/adi/Makefile b/drivers/clk/adi/Makefile
new file mode 100644
index 0000000000..f3f1fd92e5
--- /dev/null
+++ b/drivers/clk/adi/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2022 - Analog Devices, Inc.
+#
+# Written and/or maintained by Timesys Corporation
+#
+# Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+# Contact: Greg Malysa <greg.malysa@timesys.com>
+#
+
+obj-$(CONFIG_COMMON_CLK_ADI_SHARED) += clk-shared.o clk-adi-pll.o
+
+obj-$(CONFIG_COMMON_CLK_ADI_SC594)  += clk-adi-sc594.o
+obj-$(CONFIG_COMMON_CLK_ADI_SC598)  += clk-adi-sc598.o
+obj-$(CONFIG_COMMON_CLK_ADI_SC58X)  += clk-adi-sc58x.o
+obj-$(CONFIG_COMMON_CLK_ADI_SC57X)  += clk-adi-sc57x.o
diff --git a/drivers/clk/adi/clk-adi-pll.c b/drivers/clk/adi/clk-adi-pll.c
new file mode 100644
index 0000000000..372baa9c11
--- /dev/null
+++ b/drivers/clk/adi/clk-adi-pll.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <asm/io.h>
+#include <dm/device.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+
+#include "clk.h"
+
+#define ADI_CLK_PLL_GENERIC "adi_clk_pll_generic"
+
+struct clk_sc5xx_cgu_pll {
+	struct clk clk;
+	void __iomem *base;
+	u32 mask;
+	u32 max;
+	u32 m_offset;
+	u8 shift;
+	bool half_m;
+};
+
+#define to_clk_sc5xx_cgu_pll(_clk) container_of(_clk, struct clk_sc5xx_cgu_pll, clk)
+
+static unsigned long sc5xx_cgu_pll_get_rate(struct clk *clk)
+{
+	struct clk_sc5xx_cgu_pll *pll = to_clk_sc5xx_cgu_pll(dev_get_clk_ptr(clk->dev));
+	unsigned long parent_rate = clk_get_parent_rate(clk);
+
+	u32 reg = readl(pll->base);
+	u32 m = ((reg & pll->mask) >> pll->shift) + pll->m_offset;
+
+	if (m == 0)
+		m = pll->max;
+
+	if (pll->half_m)
+		return parent_rate * m * 2;
+	return parent_rate * m;
+}
+
+static const struct clk_ops clk_sc5xx_cgu_pll_ops = {
+	.get_rate = sc5xx_cgu_pll_get_rate,
+};
+
+struct clk *sc5xx_cgu_pll(const char *name, const char *parent_name,
+			  void __iomem *base, u8 shift, u8 width, u32 m_offset,
+			  bool half_m)
+{
+	struct clk_sc5xx_cgu_pll *pll;
+	struct clk *clk;
+	int ret;
+	char *drv_name = ADI_CLK_PLL_GENERIC;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	pll->shift = shift;
+	pll->mask = GENMASK(width - 1, 0) << shift;
+	pll->max = pll->mask + 1;
+	pll->m_offset = m_offset;
+	pll->half_m = half_m;
+
+	clk = &pll->clk;
+
+	ret = clk_register(clk, drv_name, name, parent_name);
+	if (ret) {
+		pr_err("Failed to register %s in %s: %d\n", name, __func__, ret);
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return clk;
+}
+
+U_BOOT_DRIVER(clk_adi_pll_generic) = {
+	.name	= ADI_CLK_PLL_GENERIC,
+	.id	= UCLASS_CLK,
+	.ops	= &clk_sc5xx_cgu_pll_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/adi/clk-adi-sc57x.c b/drivers/clk/adi/clk-adi-sc57x.c
new file mode 100644
index 0000000000..b17563f044
--- /dev/null
+++ b/drivers/clk/adi/clk-adi-sc57x.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-bindings/clock/adi-sc5xx-clock.h>
+#include <linux/compiler_types.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static const char * const cgu1_in_sels[] = {"sys_clkin0", "sys_clkin1"};
+static const char * const sharc0_sels[] = {"cclk0_0", "sysclk_0", "dummy", "dummy"};
+static const char * const sharc1_sels[] = {"cclk0_0", "sysclk_0", "dummy", "dummy"};
+static const char * const arm_sels[] = {"cclk1_0", "sysclk_0", "dummy", "dummy"};
+static const char * const cdu_ddr_sels[] = {"dclk_0", "dclk_1", "dummy", "dummy"};
+static const char * const can_sels[] = {"oclk_0", "oclk_1", "dclk_1", "oclk_0_half"};
+static const char * const spdif_sels[] = {"oclk_0", "oclk_1", "dclk_1", "dclk_0"};
+static const char * const gige_sels[] = {"sclk1_0", "sclk1_1", "cclk0_1", "oclk_0"};
+static const char * const sdio_sels[] = {"oclk_0_half", "cclk1_1_half", "cclk1_1",
+	"dclk_1"};
+
+static int sc57x_clock_probe(struct udevice *dev)
+{
+	void __iomem *cgu0;
+	void __iomem *cgu1;
+	void __iomem *cdu;
+	int ret;
+	struct resource res;
+
+	struct clk *clks[ADSP_SC57X_CLK_END];
+	struct clk dummy, clkin0, clkin1;
+
+	ret = dev_read_resource_byname(dev, "cgu0", &res);
+	if (ret)
+		return ret;
+	cgu0 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cgu1", &res);
+	if (ret)
+		return ret;
+	cgu1 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cdu", &res);
+	if (ret)
+		return ret;
+	cdu = devm_ioremap(dev, res.start, resource_size(&res));
+
+	// Input clock configuration
+	clk_get_by_name(dev, "dummy", &dummy);
+	clk_get_by_name(dev, "sys_clkin0", &clkin0);
+	clk_get_by_name(dev, "sys_clkin1", &clkin1);
+
+	clks[ADSP_SC57X_CLK_DUMMY] = &dummy;
+	clks[ADSP_SC57X_CLK_SYS_CLKIN0] = &clkin0;
+	clks[ADSP_SC57X_CLK_SYS_CLKIN1] = &clkin1;
+
+	clks[ADSP_SC57X_CLK_CGU1_IN] = clk_register_mux(NULL, "cgu1_in_sel", cgu1_in_sels,
+							2, CLK_SET_RATE_PARENT,
+							cdu + CDU_CLKINSEL, 0, 1, 0);
+
+	// CGU configuration and internal clocks
+	clks[ADSP_SC57X_CLK_CGU0_PLL_IN] = clk_register_divider(NULL, "cgu0_df",
+								"sys_clkin0",
+								CLK_SET_RATE_PARENT,
+								cgu0 + CGU_CTL, 0, 1, 0);
+	clks[ADSP_SC57X_CLK_CGU1_PLL_IN] = clk_register_divider(NULL, "cgu1_df",
+								"cgu1_in_sel",
+								CLK_SET_RATE_PARENT,
+								cgu1 + CGU_CTL, 0, 1, 0);
+
+	// VCO output == PLL output
+	clks[ADSP_SC57X_CLK_CGU0_PLLCLK] = sc5xx_cgu_pll("cgu0_pllclk", "cgu0_df",
+							 cgu0 + CGU_CTL, CGU_MSEL_SHIFT,
+							 CGU_MSEL_WIDTH, 0, false);
+	clks[ADSP_SC57X_CLK_CGU1_PLLCLK] = sc5xx_cgu_pll("cgu1_pllclk", "cgu1_df",
+							 cgu1 + CGU_CTL, CGU_MSEL_SHIFT,
+							 CGU_MSEL_WIDTH, 0, false);
+
+	// Dividers from pll output
+	clks[ADSP_SC57X_CLK_CGU0_CDIV] = cgu_divider("cgu0_cdiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU0_SYSCLK] = cgu_divider("sysclk_0", "cgu0_pllclk",
+						       cgu0 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU0_DDIV] = cgu_divider("cgu0_ddiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU0_ODIV] = cgu_divider("cgu0_odiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC57X_CLK_CGU0_S0SELDIV] = cgu_divider("cgu0_s0seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC57X_CLK_CGU0_S1SELDIV] = cgu_divider("cgu0_s1seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 13, 3, 0);
+
+	clks[ADSP_SC57X_CLK_CGU1_CDIV] = cgu_divider("cgu1_cdiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU1_SYSCLK] = cgu_divider("sysclk_1", "cgu1_pllclk",
+						       cgu1 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU1_DDIV] = cgu_divider("cgu1_ddiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC57X_CLK_CGU1_ODIV] = cgu_divider("cgu1_odiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC57X_CLK_CGU1_S0SELDIV] = cgu_divider("cgu1_s0seldiv",
+							 "sysclk_1", cgu1 + CGU_DIV, 5,
+							 3, 0);
+	clks[ADSP_SC57X_CLK_CGU1_S1SELDIV] = cgu_divider("cgu1_s1seldiv",
+							 "sysclk_1", cgu1 + CGU_DIV, 13,
+							 3, 0);
+
+	// Gates to enable CGU outputs
+	clks[ADSP_SC57X_CLK_CGU0_CCLK0] = cgu_gate("cclk0_0", "cgu0_cdiv",
+						   cgu0 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC57X_CLK_CGU0_CCLK1] = cgu_gate("cclk1_0", "cgu0_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC57X_CLK_CGU0_OCLK] = cgu_gate("oclk_0", "cgu0_odiv",
+						  cgu0 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC57X_CLK_CGU0_DCLK] = cgu_gate("dclk_0", "cgu0_ddiv",
+						  cgu0 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC57X_CLK_CGU0_SCLK1] = cgu_gate("sclk1_0", "cgu0_s1seldiv",
+						   cgu0 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC57X_CLK_CGU0_SCLK0] = cgu_gate("sclk0_0", "cgu0_s0seldiv",
+						   cgu0 + CGU_SCBF_DIS, 0);
+
+	clks[ADSP_SC57X_CLK_CGU1_CCLK0] = cgu_gate("cclk0_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC57X_CLK_CGU1_CCLK1] = cgu_gate("cclk1_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC57X_CLK_CGU1_OCLK] = cgu_gate("oclk_1", "cgu1_odiv",
+						  cgu1 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC57X_CLK_CGU1_DCLK] = cgu_gate("dclk_1", "cgu1_ddiv",
+						  cgu1 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC57X_CLK_CGU1_SCLK1] = cgu_gate("sclk1_1", "cgu1_s1seldiv",
+						   cgu1 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC57X_CLK_CGU1_SCLK0] = cgu_gate("sclk0_1", "cgu1_s0seldiv",
+						   cgu1 + CGU_SCBF_DIS, 0);
+
+	// Extra half rate clocks generated in the CDU
+	clks[ADSP_SC57X_CLK_OCLK0_HALF] = clk_register_fixed_factor(NULL, "oclk_0_half",
+								    "oclk_0",
+								    CLK_SET_RATE_PARENT,
+								    1, 2);
+	clks[ADSP_SC57X_CLK_CCLK1_1_HALF] = clk_register_fixed_factor(NULL,
+								      "cclk1_1_half",
+								      "cclk1_1",
+								      CLK_SET_RATE_PARENT,
+								      1, 2);
+
+	// CDU output muxes
+	clks[ADSP_SC57X_CLK_SHARC0_SEL] = cdu_mux("sharc0_sel", cdu + CDU_CFG0,
+						  sharc0_sels);
+	clks[ADSP_SC57X_CLK_SHARC1_SEL] = cdu_mux("sharc1_sel", cdu + CDU_CFG1,
+						  sharc1_sels);
+	clks[ADSP_SC57X_CLK_ARM_SEL] = cdu_mux("arm_sel", cdu + CDU_CFG2, arm_sels);
+	clks[ADSP_SC57X_CLK_CDU_DDR_SEL] = cdu_mux("cdu_ddr_sel", cdu + CDU_CFG3,
+						   cdu_ddr_sels);
+	clks[ADSP_SC57X_CLK_CAN_SEL] = cdu_mux("can_sel", cdu + CDU_CFG4, can_sels);
+	clks[ADSP_SC57X_CLK_SPDIF_SEL] = cdu_mux("spdif_sel", cdu + CDU_CFG5, spdif_sels);
+	clks[ADSP_SC57X_CLK_GIGE_SEL] = cdu_mux("gige_sel", cdu + CDU_CFG7, gige_sels);
+	clks[ADSP_SC57X_CLK_SDIO_SEL] = cdu_mux("sdio_sel", cdu + CDU_CFG9, sdio_sels);
+
+	// CDU output enable gates
+	clks[ADSP_SC57X_CLK_SHARC0] = cdu_gate("sharc0", "sharc0_sel", cdu + CDU_CFG0,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC57X_CLK_SHARC1] = cdu_gate("sharc1", "sharc1_sel", cdu + CDU_CFG1,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC57X_CLK_ARM] = cdu_gate("arm", "arm_sel", cdu + CDU_CFG2,
+					    CLK_IS_CRITICAL);
+	clks[ADSP_SC57X_CLK_CDU_DDR] = cdu_gate("cdu_ddr", "cdu_ddr_sel", cdu + CDU_CFG3,
+						CLK_IS_CRITICAL);
+	clks[ADSP_SC57X_CLK_CAN] = cdu_gate("can", "can_sel", cdu + CDU_CFG4, 0);
+	clks[ADSP_SC57X_CLK_SPDIF] = cdu_gate("spdif", "spdif_sel", cdu + CDU_CFG5, 0);
+	clks[ADSP_SC57X_CLK_GIGE] = cdu_gate("gige", "gige_sel", cdu + CDU_CFG7, 0);
+	clks[ADSP_SC57X_CLK_SDIO] = cdu_gate("sdio", "sdio_sel", cdu + CDU_CFG9, 0);
+
+	ret = cdu_check_clocks(clks, ARRAY_SIZE(clks));
+	if (ret)
+		pr_err("CDU error detected\n");
+
+	return ret;
+}
+
+static const struct udevice_id adi_sc57x_clk_ids[] = {
+	{ .compatible = "adi,sc57x-clocks" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_sc57x_clk) = {
+	.name = "clk_adi_sc57x",
+	.id = UCLASS_CLK,
+	.of_match = adi_sc57x_clk_ids,
+	.ops		= &adi_clk_ops,
+	.probe = sc57x_clock_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/adi/clk-adi-sc58x.c b/drivers/clk/adi/clk-adi-sc58x.c
new file mode 100644
index 0000000000..05a0feddec
--- /dev/null
+++ b/drivers/clk/adi/clk-adi-sc58x.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-bindings/clock/adi-sc5xx-clock.h>
+#include <linux/compiler_types.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static const char * const cgu1_in_sels[] = {"sys_clkin0", "sys_clkin1"};
+static const char * const sharc0_sels[] = {"cclk0_0", "sysclk_0", "dummy", "dummy"};
+static const char * const sharc1_sels[] = {"cclk0_0", "sysclk_0", "dummy", "dummy"};
+static const char * const arm_sels[] = {"cclk1_0", "sysclk_0", "dummy", "dummy"};
+static const char * const cdu_ddr_sels[] = {"dclk_0", "dclk_1", "dummy", "dummy"};
+static const char * const can_sels[] = {"oclk_0", "oclk_1", "dclk_1", "dummy"};
+static const char * const spdif_sels[] = {"oclk_0", "oclk_1", "dclk_1", "dclk_0"};
+static const char * const reserved_sels[] = {"sclk0_0", "oclk_0", "dummy", "dummy"};
+static const char * const gige_sels[] = {"sclk0_0", "sclk1_1", "cclk0_1", "oclk_0"};
+static const char * const lp_sels[] = {"sclk0_0", "sclk0_1", "cclk1_1", "dclk_1"};
+static const char * const sdio_sels[] = {"oclk_0_half", "cclk1_1_half", "cclk1_1",
+	"dclk_1"};
+
+static int sc58x_clock_probe(struct udevice *dev)
+{
+	void __iomem *cgu0;
+	void __iomem *cgu1;
+	void __iomem *cdu;
+	int ret;
+	struct resource res;
+
+	struct clk *clks[ADSP_SC58X_CLK_END];
+	struct clk dummy, clkin0, clkin1;
+
+	ret = dev_read_resource_byname(dev, "cgu0", &res);
+	if (ret)
+		return ret;
+	cgu0 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cgu1", &res);
+	if (ret)
+		return ret;
+	cgu1 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cdu", &res);
+	if (ret)
+		return ret;
+	cdu = devm_ioremap(dev, res.start, resource_size(&res));
+
+	// Input clock configuration
+	clk_get_by_name(dev, "dummy", &dummy);
+	clk_get_by_name(dev, "sys_clkin0", &clkin0);
+	clk_get_by_name(dev, "sys_clkin1", &clkin1);
+
+	clks[ADSP_SC58X_CLK_DUMMY] = &dummy;
+	clks[ADSP_SC58X_CLK_SYS_CLKIN0] = &clkin0;
+	clks[ADSP_SC58X_CLK_SYS_CLKIN1] = &clkin1;
+
+	clks[ADSP_SC58X_CLK_CGU1_IN] = clk_register_mux(NULL, "cgu1_in_sel", cgu1_in_sels,
+							2, CLK_SET_RATE_PARENT,
+							cdu + CDU_CLKINSEL, 0, 1, 0);
+
+	// CGU configuration and internal clocks
+	clks[ADSP_SC58X_CLK_CGU0_PLL_IN] = clk_register_divider(NULL, "cgu0_df",
+								"sys_clkin0",
+								CLK_SET_RATE_PARENT,
+								cgu0 + CGU_CTL, 0, 1, 0);
+	clks[ADSP_SC58X_CLK_CGU1_PLL_IN] = clk_register_divider(NULL, "cgu1_df",
+								"cgu1_in_sel",
+								CLK_SET_RATE_PARENT,
+								cgu1 + CGU_CTL, 0, 1, 0);
+
+	// VCO output inside PLL
+	clks[ADSP_SC58X_CLK_CGU0_VCO_OUT] = sc5xx_cgu_pll("cgu0_vco", "cgu0_df",
+							  cgu0 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, false);
+	clks[ADSP_SC58X_CLK_CGU1_VCO_OUT] = sc5xx_cgu_pll("cgu1_vco", "cgu1_df",
+							  cgu1 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, false);
+
+	// Final PLL output
+	clks[ADSP_SC58X_CLK_CGU0_PLLCLK] = clk_register_fixed_factor(NULL, "cgu0_pllclk",
+								     "cgu0_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 1);
+	clks[ADSP_SC58X_CLK_CGU1_PLLCLK] = clk_register_fixed_factor(NULL, "cgu1_pllclk",
+								     "cgu1_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 1);
+
+	// Dividers from pll output
+	clks[ADSP_SC58X_CLK_CGU0_CDIV] = cgu_divider("cgu0_cdiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU0_SYSCLK] = cgu_divider("sysclk_0", "cgu0_pllclk",
+						       cgu0 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU0_DDIV] = cgu_divider("cgu0_ddiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU0_ODIV] = cgu_divider("cgu0_odiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC58X_CLK_CGU0_S0SELDIV] = cgu_divider("cgu0_s0seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC58X_CLK_CGU0_S1SELDIV] = cgu_divider("cgu0_s1seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 13, 3, 0);
+
+	clks[ADSP_SC58X_CLK_CGU1_CDIV] = cgu_divider("cgu1_cdiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU1_SYSCLK] = cgu_divider("sysclk_1", "cgu1_pllclk",
+						       cgu1 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU1_DDIV] = cgu_divider("cgu1_ddiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC58X_CLK_CGU1_ODIV] = cgu_divider("cgu1_odiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC58X_CLK_CGU1_S0SELDIV] = cgu_divider("cgu1_s0seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC58X_CLK_CGU1_S1SELDIV] = cgu_divider("cgu1_s1seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 13, 3, 0);
+
+	// Gates to enable CGU outputs
+	clks[ADSP_SC58X_CLK_CGU0_CCLK0] = cgu_gate("cclk0_0", "cgu0_cdiv",
+						   cgu0 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC58X_CLK_CGU0_CCLK1] = cgu_gate("cclk1_0", "cgu0_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC58X_CLK_CGU0_OCLK] = cgu_gate("oclk_0", "cgu0_odiv",
+						  cgu0 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC58X_CLK_CGU0_DCLK] = cgu_gate("dclk_0", "cgu0_ddiv",
+						  cgu0 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC58X_CLK_CGU0_SCLK1] = cgu_gate("sclk1_0", "cgu0_s1seldiv",
+						   cgu0 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC58X_CLK_CGU0_SCLK0] = cgu_gate("sclk0_0", "cgu0_s0seldiv",
+						   cgu0 + CGU_SCBF_DIS, 0);
+
+	clks[ADSP_SC58X_CLK_CGU1_CCLK0] = cgu_gate("cclk0_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC58X_CLK_CGU1_CCLK1] = cgu_gate("cclk1_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC58X_CLK_CGU1_OCLK] = cgu_gate("oclk_1", "cgu1_odiv",
+						  cgu1 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC58X_CLK_CGU1_DCLK] = cgu_gate("dclk_1", "cgu1_ddiv",
+						  cgu1 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC58X_CLK_CGU1_SCLK1] = cgu_gate("sclk1_1", "cgu1_s1seldiv",
+						   cgu1 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC58X_CLK_CGU1_SCLK0] = cgu_gate("sclk0_1", "cgu1_s0seldiv",
+						   cgu1 + CGU_SCBF_DIS, 0);
+
+	// Extra half rate clocks generated in the CDU
+	clks[ADSP_SC58X_CLK_OCLK0_HALF] = clk_register_fixed_factor(NULL, "oclk_0_half",
+								    "oclk_0",
+								    CLK_SET_RATE_PARENT,
+								    1, 2);
+	clks[ADSP_SC58X_CLK_CCLK1_1_HALF] = clk_register_fixed_factor(NULL,
+								      "cclk1_1_half",
+								      "cclk1_1",
+								      CLK_SET_RATE_PARENT,
+								      1, 2);
+
+	// CDU output muxes
+	clks[ADSP_SC58X_CLK_SHARC0_SEL] = cdu_mux("sharc0_sel", cdu + CDU_CFG0,
+						  sharc0_sels);
+	clks[ADSP_SC58X_CLK_SHARC1_SEL] = cdu_mux("sharc1_sel", cdu + CDU_CFG1,
+						  sharc1_sels);
+	clks[ADSP_SC58X_CLK_ARM_SEL] = cdu_mux("arm_sel", cdu + CDU_CFG2, arm_sels);
+	clks[ADSP_SC58X_CLK_CDU_DDR_SEL] = cdu_mux("cdu_ddr_sel", cdu + CDU_CFG3,
+						   cdu_ddr_sels);
+	clks[ADSP_SC58X_CLK_CAN_SEL] = cdu_mux("can_sel", cdu + CDU_CFG4, can_sels);
+	clks[ADSP_SC58X_CLK_SPDIF_SEL] = cdu_mux("spdif_sel", cdu + CDU_CFG5, spdif_sels);
+	clks[ADSP_SC58X_CLK_RESERVED_SEL] = cdu_mux("reserved_sel", cdu + CDU_CFG6,
+						    reserved_sels);
+	clks[ADSP_SC58X_CLK_GIGE_SEL] = cdu_mux("gige_sel", cdu + CDU_CFG7, gige_sels);
+	clks[ADSP_SC58X_CLK_LP_SEL] = cdu_mux("lp_sel", cdu + CDU_CFG8, lp_sels);
+	clks[ADSP_SC58X_CLK_SDIO_SEL] = cdu_mux("sdio_sel", cdu + CDU_CFG9, sdio_sels);
+
+	// CDU output enable gates
+	clks[ADSP_SC58X_CLK_SHARC0] = cdu_gate("sharc0", "sharc0_sel", cdu + CDU_CFG0,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC58X_CLK_SHARC1] = cdu_gate("sharc1", "sharc1_sel", cdu + CDU_CFG1,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC58X_CLK_ARM] = cdu_gate("arm", "arm_sel", cdu + CDU_CFG2,
+					    CLK_IS_CRITICAL);
+	clks[ADSP_SC58X_CLK_CDU_DDR] = cdu_gate("cdu_ddr", "cdu_ddr_sel", cdu + CDU_CFG3,
+						CLK_IS_CRITICAL);
+	clks[ADSP_SC58X_CLK_CAN] = cdu_gate("can", "can_sel", cdu + CDU_CFG4, 0);
+	clks[ADSP_SC58X_CLK_SPDIF] = cdu_gate("spdif", "spdif_sel", cdu + CDU_CFG5, 0);
+	clks[ADSP_SC58X_CLK_RESERVED] = cdu_gate("reserved", "reserved_sel",
+						 cdu + CDU_CFG6, 0);
+	clks[ADSP_SC58X_CLK_GIGE] = cdu_gate("gige", "gige_sel", cdu + CDU_CFG7, 0);
+	clks[ADSP_SC58X_CLK_LP] = cdu_gate("lp", "lp_sel", cdu + CDU_CFG8, 0);
+	clks[ADSP_SC58X_CLK_SDIO] = cdu_gate("sdio", "sdio_sel", cdu + CDU_CFG9, 0);
+
+	ret = cdu_check_clocks(clks, ARRAY_SIZE(clks));
+	if (ret)
+		pr_err("CDU error detected\n");
+
+	return ret;
+}
+
+static const struct udevice_id adi_sc58x_clk_ids[] = {
+	{ .compatible = "adi,sc58x-clocks" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_sc58x_clk) = {
+	.name = "clk_adi_sc58x",
+	.id = UCLASS_CLK,
+	.of_match = adi_sc58x_clk_ids,
+	.ops		= &adi_clk_ops,
+	.probe = sc58x_clock_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/adi/clk-adi-sc594.c b/drivers/clk/adi/clk-adi-sc594.c
new file mode 100644
index 0000000000..c80bbf9728
--- /dev/null
+++ b/drivers/clk/adi/clk-adi-sc594.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-bindings/clock/adi-sc5xx-clock.h>
+#include <linux/compiler_types.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static const char * const cgu1_in_sels[] = {"sys_clkin0", "sys_clkin1"};
+static const char * const cgu0_s1sels[] = {"cgu0_s1seldiv", "cgu0_s1selexdiv"};
+static const char * const cgu1_s1sels[] = {"cgu1_s1seldiv", "cgu1_s1selexdiv"};
+static const char * const sharc0_sels[] = {"cclk0_0", "dummy", "dummy", "dummy"};
+static const char * const sharc1_sels[] = {"cclk0_0", "dummy", "dummy", "dummy"};
+static const char * const arm_sels[] = {"cclk1_0", "dummy", "dummy", "dummy"};
+static const char * const cdu_ddr_sels[] = {"dclk_0", "dclk_1", "dummy", "dummy"};
+static const char * const can_sels[] = {"oclk_0", "oclk_1", "dummy", "dummy"};
+static const char * const spdif_sels[] = {"sclk1_0", "dummy", "dummy", "dummy"};
+static const char * const spi_sels[] = {"sclk0_0", "oclk_0", "dummy", "dummy"};
+static const char * const gige_sels[] = {"sclk0_0", "sclk0_1", "cclk0_1", "dummy"};
+static const char * const lp_sels[] = {"oclk_0", "sclk0_0", "cclk0_1", "dummy"};
+static const char * const lpddr_sels[] = {"oclk_0", "dclk_0", "sysclkin_1", "dummy"};
+static const char * const ospi_sels[] = {"sysclk_0", "sclk0_0", "sclk1_1", "dummy"};
+static const char * const trace_sels[] = {"sclk0_0", "dummy", "dummy", "dummy"};
+
+static int sc594_clock_probe(struct udevice *dev)
+{
+	void __iomem *cgu0;
+	void __iomem *cgu1;
+	void __iomem *cdu;
+	int ret;
+	struct resource res;
+
+	struct clk *clks[ADSP_SC594_CLK_END];
+	struct clk dummy, clkin0, clkin1;
+
+	ret = dev_read_resource_byname(dev, "cgu0", &res);
+	if (ret)
+		return ret;
+	cgu0 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cgu1", &res);
+	if (ret)
+		return ret;
+	cgu1 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cdu", &res);
+	if (ret)
+		return ret;
+	cdu = devm_ioremap(dev, res.start, resource_size(&res));
+
+	// Input clock configuration
+	clk_get_by_name(dev, "dummy", &dummy);
+	clk_get_by_name(dev, "sys_clkin0", &clkin0);
+	clk_get_by_name(dev, "sys_clkin1", &clkin1);
+
+	clks[ADSP_SC594_CLK_DUMMY] = &dummy;
+	clks[ADSP_SC594_CLK_SYS_CLKIN0] = &clkin0;
+	clks[ADSP_SC594_CLK_SYS_CLKIN1] = &clkin1;
+	clks[ADSP_SC594_CLK_CGU1_IN] = clk_register_mux(NULL, "cgu1_in_sel", cgu1_in_sels,
+							2, CLK_SET_RATE_PARENT,
+							cdu + CDU_CLKINSEL, 0, 1, 0);
+
+	// CGU configuration and internal clocks
+	clks[ADSP_SC594_CLK_CGU0_PLL_IN] = clk_register_divider(NULL, "cgu0_df",
+								"sys_clkin0",
+								CLK_SET_RATE_PARENT,
+								cgu0 + CGU_CTL, 0, 1, 0);
+	clks[ADSP_SC594_CLK_CGU1_PLL_IN] = clk_register_divider(NULL, "cgu1_df",
+								"cgu1_in_sel",
+								CLK_SET_RATE_PARENT,
+								cgu1 + CGU_CTL, 0, 1, 0);
+
+	// VCO output inside PLL
+	clks[ADSP_SC594_CLK_CGU0_VCO_OUT] = sc5xx_cgu_pll("cgu0_vco", "cgu0_df",
+							  cgu0 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, false);
+	clks[ADSP_SC594_CLK_CGU1_VCO_OUT] = sc5xx_cgu_pll("cgu1_vco", "cgu1_df",
+							  cgu1 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, false);
+
+	// Final PLL output
+	clks[ADSP_SC594_CLK_CGU0_PLLCLK] = clk_register_fixed_factor(NULL, "cgu0_pllclk",
+								     "cgu0_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 1);
+	clks[ADSP_SC594_CLK_CGU1_PLLCLK] = clk_register_fixed_factor(NULL, "cgu1_pllclk",
+								     "cgu1_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 1);
+
+	// Dividers from pll output
+	clks[ADSP_SC594_CLK_CGU0_CDIV] = cgu_divider("cgu0_cdiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC594_CLK_CGU0_SYSCLK] = cgu_divider("sysclk_0", "cgu0_pllclk",
+						       cgu0 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC594_CLK_CGU0_DDIV] = cgu_divider("cgu0_ddiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC594_CLK_CGU0_ODIV] = cgu_divider("cgu0_odiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC594_CLK_CGU0_S0SELDIV] = cgu_divider("cgu0_s0seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC594_CLK_CGU0_S1SELDIV] = cgu_divider("cgu0_s1seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 13, 3, 0);
+	clks[ADSP_SC594_CLK_CGU0_S1SELEXDIV] = cgu_divider("cgu0_s1selexdiv",
+							   "cgu0_pllclk",
+							   cgu0 + CGU_DIVEX, 16, 8, 0);
+	clks[ADSP_SC594_CLK_CGU0_S1SEL] = clk_register_mux(NULL, "cgu0_sclk1sel",
+							   cgu0_s1sels, 2,
+							   CLK_SET_RATE_PARENT,
+							   cgu0 + CGU_CTL, 17, 1, 0);
+
+	clks[ADSP_SC594_CLK_CGU1_CDIV] = cgu_divider("cgu1_cdiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC594_CLK_CGU1_SYSCLK] = cgu_divider("sysclk_1", "cgu1_pllclk",
+						       cgu1 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC594_CLK_CGU1_DDIV] = cgu_divider("cgu1_ddiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC594_CLK_CGU1_ODIV] = cgu_divider("cgu1_odiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC594_CLK_CGU1_S0SELDIV] = cgu_divider("cgu1_s0seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC594_CLK_CGU1_S1SELDIV] = cgu_divider("cgu1_s1seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 13, 3, 0);
+	clks[ADSP_SC594_CLK_CGU1_S1SELEXDIV] = cgu_divider("cgu1_s1selexdiv",
+							   "cgu1_pllclk",
+							   cgu1 + CGU_DIVEX, 16, 8, 0);
+	clks[ADSP_SC594_CLK_CGU1_S1SEL] = clk_register_mux(NULL, "cgu1_sclk1sel",
+							   cgu1_s1sels, 2,
+							   CLK_SET_RATE_PARENT,
+							   cgu1 + CGU_CTL, 17, 1, 0);
+
+	// Gates to enable CGU outputs
+	clks[ADSP_SC594_CLK_CGU0_CCLK0] = cgu_gate("cclk0_0", "cgu0_cdiv",
+						   cgu0 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC594_CLK_CGU0_CCLK1] = cgu_gate("cclk1_0", "cgu0_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC594_CLK_CGU0_OCLK] = cgu_gate("oclk_0", "cgu0_odiv",
+						  cgu0 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC594_CLK_CGU0_DCLK] = cgu_gate("dclk_0", "cgu0_ddiv",
+						  cgu0 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC594_CLK_CGU0_SCLK1] = cgu_gate("sclk1_0", "cgu0_sclk1sel",
+						   cgu0 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC594_CLK_CGU0_SCLK0] = cgu_gate("sclk0_0", "cgu0_s0seldiv",
+						   cgu0 + CGU_SCBF_DIS, 0);
+
+	clks[ADSP_SC594_CLK_CGU1_CCLK0] = cgu_gate("cclk0_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC594_CLK_CGU1_CCLK1] = cgu_gate("cclk1_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 1);
+	clks[ADSP_SC594_CLK_CGU1_OCLK] = cgu_gate("oclk_1", "cgu1_odiv",
+						  cgu1 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC594_CLK_CGU1_DCLK] = cgu_gate("dclk_1", "cgu1_ddiv",
+						  cgu1 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC594_CLK_CGU1_SCLK1] = cgu_gate("sclk1_1", "cgu1_sclk1sel",
+						   cgu1 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC594_CLK_CGU1_SCLK0] = cgu_gate("sclk0_1", "cgu1_s0seldiv",
+						   cgu1 + CGU_SCBF_DIS, 0);
+
+	// CDU output muxes
+	clks[ADSP_SC594_CLK_SHARC0_SEL] = cdu_mux("sharc0_sel", cdu + CDU_CFG0,
+						  sharc0_sels);
+	clks[ADSP_SC594_CLK_SHARC1_SEL] = cdu_mux("sharc1_sel", cdu + CDU_CFG1,
+						  sharc1_sels);
+	clks[ADSP_SC594_CLK_ARM_SEL] = cdu_mux("arm_sel", cdu + CDU_CFG2, arm_sels);
+	clks[ADSP_SC594_CLK_CDU_DDR_SEL] = cdu_mux("cdu_ddr_sel", cdu + CDU_CFG3,
+						   cdu_ddr_sels);
+	clks[ADSP_SC594_CLK_CAN_SEL] = cdu_mux("can_sel", cdu + CDU_CFG4, can_sels);
+	clks[ADSP_SC594_CLK_SPDIF_SEL] = cdu_mux("spdif_sel", cdu + CDU_CFG5, spdif_sels);
+	clks[ADSP_SC594_CLK_RESERVED_SEL] = cdu_mux("spi_sel", cdu + CDU_CFG6, spi_sels);
+	clks[ADSP_SC594_CLK_GIGE_SEL] = cdu_mux("gige_sel", cdu + CDU_CFG7, gige_sels);
+	clks[ADSP_SC594_CLK_LP_SEL] = cdu_mux("lp_sel", cdu + CDU_CFG8, lp_sels);
+	clks[ADSP_SC594_CLK_LPDDR_SEL] = cdu_mux("lpddr_sel", cdu + CDU_CFG9, lpddr_sels);
+	clks[ADSP_SC594_CLK_OSPI_SEL] = cdu_mux("ospi_sel", cdu + CDU_CFG10,
+						ospi_sels);
+	clks[ADSP_SC594_CLK_TRACE_SEL] = cdu_mux("trace_sel", cdu + CDU_CFG12,
+						 trace_sels);
+
+	// CDU output enable gates
+	clks[ADSP_SC594_CLK_SHARC0] = cdu_gate("sharc0", "sharc0_sel",
+					       cdu + CDU_CFG0, CLK_IS_CRITICAL);
+	clks[ADSP_SC594_CLK_SHARC1] = cdu_gate("sharc1", "sharc1_sel",
+					       cdu + CDU_CFG1, CLK_IS_CRITICAL);
+	clks[ADSP_SC594_CLK_ARM] = cdu_gate("arm", "arm_sel", cdu + CDU_CFG2,
+					    CLK_IS_CRITICAL);
+	clks[ADSP_SC594_CLK_CDU_DDR] = cdu_gate("cdu_ddr", "cdu_ddr_sel",
+						cdu + CDU_CFG3, CLK_IS_CRITICAL);
+	clks[ADSP_SC594_CLK_CAN] = cdu_gate("can", "can_sel", cdu + CDU_CFG4, 0);
+	clks[ADSP_SC594_CLK_SPDIF] = cdu_gate("spdif", "spdif_sel", cdu + CDU_CFG5, 0);
+	clks[ADSP_SC594_CLK_SPI] = cdu_gate("spi", "spi_sel", cdu + CDU_CFG6, 0);
+	clks[ADSP_SC594_CLK_GIGE] = cdu_gate("gige", "gige_sel", cdu + CDU_CFG7, 0);
+	clks[ADSP_SC594_CLK_LP] = cdu_gate("lp", "lp_sel", cdu + CDU_CFG8, 0);
+	clks[ADSP_SC594_CLK_LPDDR] = cdu_gate("lpddr", "lpddr_sel", cdu + CDU_CFG9, 0);
+	clks[ADSP_SC594_CLK_OSPI] = cdu_gate("ospi", "ospi_sel", cdu + CDU_CFG10, 0);
+	clks[ADSP_SC594_CLK_TRACE] = cdu_gate("trace", "trace_sel", cdu + CDU_CFG12, 0);
+
+	ret = cdu_check_clocks(clks, ARRAY_SIZE(clks));
+	if (ret)
+		pr_err("CDU error detected\n");
+
+	return ret;
+}
+
+static const struct udevice_id adi_sc594_clk_ids[] = {
+	{ .compatible = "adi,sc594-clocks" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_sc594_clk) = {
+	.name = "clk_adi_sc594",
+	.id = UCLASS_CLK,
+	.of_match = adi_sc594_clk_ids,
+	.ops		= &adi_clk_ops,
+	.probe = sc594_clock_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/adi/clk-adi-sc598.c b/drivers/clk/adi/clk-adi-sc598.c
new file mode 100644
index 0000000000..d4a16ac960
--- /dev/null
+++ b/drivers/clk/adi/clk-adi-sc598.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-bindings/clock/adi-sc5xx-clock.h>
+#include <linux/compiler_types.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static const char * const cgu1_in_sels[] = {"sys_clkin0", "sys_clkin1"};
+static const char * const cgu0_s1sels[] = {"cgu0_s1seldiv", "cgu0_s1selexdiv"};
+static const char * const cgu1_s0sels[] = {"cgu1_s0seldiv", "cgu1_s0selexdiv"};
+static const char * const cgu1_s1sels[] = {"cgu1_s1seldiv", "cgu1_s1selexdiv"};
+static const char * const sharc0_sels[] = {"cclk0_0", "dummy", "dummy", "dummy"};
+static const char * const sharc1_sels[] = {"cclk0_0", "dummy", "dummy", "dummy"};
+static const char * const arm_sels[] = {"dummy", "dummy", "cclk2_0", "cclk2_1"};
+static const char * const cdu_ddr_sels[] = {"dclk_0", "dclk_1", "dummy", "dummy"};
+static const char * const can_sels[] = {"dummy", "oclk_1", "dummy", "dummy"};
+static const char * const spdif_sels[] = {"sclk1_0", "dummy", "dummy", "dummy"};
+static const char * const spi_sels[] = {"sclk0_0", "oclk_0", "dummy", "dummy"};
+static const char * const gige_sels[] = {"sclk0_0", "sclk0_1", "dummy", "dummy"};
+static const char * const lp_sels[] = {"oclk_0", "sclk0_0", "cclk0_1", "dummy"};
+static const char * const lp_ddr_sels[] = {"oclk_0", "dclk_0", "sysclk_1", "dummy"};
+static const char * const ospi_refclk_sels[] = {"sysclk_0", "sclk0_0", "sclk1_1",
+	"dummy"};
+static const char * const trace_sels[] = {"sclk0_0", "dummy", "dummy", "dummy"};
+static const char * const emmc_sels[] = {"oclk_0", "sclk0_1", "dclk_0_half",
+	"dclk_1_half"};
+static const char * const emmc_timer_sels[] = {"dummy", "sclk1_1_half", "dummy",
+	"dummy"};
+static const char * const ddr_sels[] = {"cdu_ddr", "3pll_ddiv"};
+
+static int sc598_clock_probe(struct udevice *dev)
+{
+	void __iomem *cgu0;
+	void __iomem *cgu1;
+	void __iomem *cdu;
+	void __iomem *pll3;
+	int ret;
+	struct resource res;
+
+	struct clk *clks[ADSP_SC598_CLK_END];
+	struct clk dummy, clkin0, clkin1;
+
+	ret = dev_read_resource_byname(dev, "cgu0", &res);
+	if (ret)
+		return ret;
+	cgu0 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cgu1", &res);
+	if (ret)
+		return ret;
+	cgu1 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "cdu", &res);
+	if (ret)
+		return ret;
+	cdu = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "pll3", &res);
+	if (ret)
+		return ret;
+	pll3 = devm_ioremap(dev, res.start, resource_size(&res));
+
+	// We only access this one register for pll3
+	pll3 = pll3 + PLL3_OFFSET;
+
+	// Input clock configuration
+	clk_get_by_name(dev, "dummy", &dummy);
+	clk_get_by_name(dev, "sys_clkin0", &clkin0);
+	clk_get_by_name(dev, "sys_clkin1", &clkin1);
+
+	clks[ADSP_SC598_CLK_DUMMY] = &dummy;
+	clks[ADSP_SC598_CLK_SYS_CLKIN0] = &clkin0;
+	clks[ADSP_SC598_CLK_SYS_CLKIN1] = &clkin1;
+
+	clks[ADSP_SC598_CLK_CGU1_IN] = clk_register_mux(NULL, "cgu1_in_sel", cgu1_in_sels,
+							2, CLK_SET_RATE_PARENT,
+							cdu + CDU_CLKINSEL, 0, 1, 0);
+
+	// 3rd pll reuses cgu1 clk in selection, feeds directly into 3pll df
+	// changing the cgu1 in sel mux will affect 3pll so reuse the same clocks
+
+	// CGU configuration and internal clocks
+	clks[ADSP_SC598_CLK_CGU0_PLL_IN] = clk_register_divider(NULL, "cgu0_df",
+								"sys_clkin0",
+								CLK_SET_RATE_PARENT,
+								cgu0 + CGU_CTL, 0, 1, 0);
+	clks[ADSP_SC598_CLK_CGU1_PLL_IN] = clk_register_divider(NULL, "cgu1_df",
+								"cgu1_in_sel",
+								CLK_SET_RATE_PARENT,
+								cgu1 + CGU_CTL, 0, 1, 0);
+	clks[ADSP_SC598_CLK_3PLL_PLL_IN] = clk_register_divider(NULL, "3pll_df",
+								"cgu1_in_sel",
+								CLK_SET_RATE_PARENT,
+								pll3, 3, 1, 0);
+
+	// VCO output inside PLL
+	clks[ADSP_SC598_CLK_CGU0_VCO_OUT] = sc5xx_cgu_pll("cgu0_vco", "cgu0_df",
+							  cgu0 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, true);
+	clks[ADSP_SC598_CLK_CGU1_VCO_OUT] = sc5xx_cgu_pll("cgu1_vco", "cgu1_df",
+							  cgu1 + CGU_CTL, CGU_MSEL_SHIFT,
+							  CGU_MSEL_WIDTH, 0, true);
+	clks[ADSP_SC598_CLK_3PLL_VCO_OUT] = sc5xx_cgu_pll("3pll_vco", "3pll_df",
+							  pll3, PLL3_MSEL_SHIFT,
+							  PLL3_MSEL_WIDTH, 1, true);
+
+	// Final PLL output
+	clks[ADSP_SC598_CLK_CGU0_PLLCLK] = clk_register_fixed_factor(NULL, "cgu0_pllclk",
+								     "cgu0_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 2);
+	clks[ADSP_SC598_CLK_CGU1_PLLCLK] = clk_register_fixed_factor(NULL, "cgu1_pllclk",
+								     "cgu1_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 2);
+	clks[ADSP_SC598_CLK_3PLL_PLLCLK] = clk_register_fixed_factor(NULL, "3pll_pllclk",
+								     "3pll_vco",
+								     CLK_SET_RATE_PARENT,
+								     1, 2);
+
+	// Dividers from pll output
+	clks[ADSP_SC598_CLK_CGU0_CDIV] = cgu_divider("cgu0_cdiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC598_CLK_CGU0_SYSCLK] = cgu_divider("sysclk_0", "cgu0_pllclk",
+						       cgu0 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC598_CLK_CGU0_DDIV] = cgu_divider("cgu0_ddiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC598_CLK_CGU0_ODIV] = cgu_divider("cgu0_odiv", "cgu0_pllclk",
+						     cgu0 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC598_CLK_CGU0_S0SELDIV] = cgu_divider("cgu0_s0seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC598_CLK_CGU0_S1SELDIV] = cgu_divider("cgu0_s1seldiv", "sysclk_0",
+							 cgu0 + CGU_DIV, 13, 3, 0);
+	clks[ADSP_SC598_CLK_CGU0_S1SELEXDIV] = cgu_divider("cgu0_s1selexdiv",
+							   "cgu0_pllclk",
+							   cgu0 + CGU_DIVEX, 16, 8, 0);
+	clks[ADSP_SC598_CLK_CGU0_S1SEL] = clk_register_mux(NULL, "cgu0_sclk1sel",
+							   cgu0_s1sels, 2,
+							   CLK_SET_RATE_PARENT,
+							   cgu0 + CGU_CTL, 17, 1, 0);
+	clks[ADSP_SC598_CLK_CGU0_CCLK2] = clk_register_fixed_factor(NULL, "cclk2_0",
+								    "cgu0_vco",
+								    CLK_SET_RATE_PARENT,
+								    1, 3);
+
+	clks[ADSP_SC598_CLK_CGU1_CDIV] = cgu_divider("cgu1_cdiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 0, 5, 0);
+	clks[ADSP_SC598_CLK_CGU1_SYSCLK] = cgu_divider("sysclk_1", "cgu1_pllclk",
+						       cgu1 + CGU_DIV, 8, 5, 0);
+	clks[ADSP_SC598_CLK_CGU1_DDIV] = cgu_divider("cgu1_ddiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 16, 5, 0);
+	clks[ADSP_SC598_CLK_CGU1_ODIV] = cgu_divider("cgu1_odiv", "cgu1_pllclk",
+						     cgu1 + CGU_DIV, 22, 7, 0);
+	clks[ADSP_SC598_CLK_CGU1_S0SELDIV] = cgu_divider("cgu1_s0seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 5, 3, 0);
+	clks[ADSP_SC598_CLK_CGU1_S1SELDIV] = cgu_divider("cgu1_s1seldiv", "sysclk_1",
+							 cgu1 + CGU_DIV, 13, 3, 0);
+	clks[ADSP_SC598_CLK_CGU1_S0SELEXDIV] = cgu_divider("cgu1_s0selexdiv",
+							   "cgu1_pllclk",
+							   cgu1 + CGU_DIVEX, 0, 8, 0);
+	clks[ADSP_SC598_CLK_CGU1_S1SELEXDIV] = cgu_divider("cgu1_s1selexdiv",
+							   "cgu1_pllclk",
+							   cgu1 + CGU_DIVEX, 16, 8, 0);
+	clks[ADSP_SC598_CLK_CGU1_S0SEL] = clk_register_mux(NULL, "cgu1_sclk0sel",
+							   cgu1_s0sels, 2,
+							   CLK_SET_RATE_PARENT,
+							   cgu1 + CGU_CTL, 16, 1, 0);
+	clks[ADSP_SC598_CLK_CGU1_S1SEL] = clk_register_mux(NULL, "cgu1_sclk1sel",
+							   cgu1_s1sels, 2,
+							   CLK_SET_RATE_PARENT,
+							   cgu1 + CGU_CTL, 17, 1, 0);
+	clks[ADSP_SC598_CLK_CGU1_CCLK2] = clk_register_fixed_factor(NULL, "cclk2_1",
+								    "cgu1_vco",
+								    CLK_SET_RATE_PARENT,
+								    1, 3);
+
+	clks[ADSP_SC598_CLK_3PLL_DDIV] = clk_register_divider(NULL, "3pll_ddiv",
+							      "3pll_pllclk",
+							      CLK_SET_RATE_PARENT, pll3,
+							      12, 5, 0);
+
+	// Gates to enable CGU outputs
+	clks[ADSP_SC598_CLK_CGU0_CCLK0] = cgu_gate("cclk0_0", "cgu0_cdiv",
+						   cgu0 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC598_CLK_CGU0_OCLK] = cgu_gate("oclk_0", "cgu0_odiv",
+						  cgu0 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC598_CLK_CGU0_DCLK] = cgu_gate("dclk_0", "cgu0_ddiv",
+						  cgu0 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC598_CLK_CGU0_SCLK1] = cgu_gate("sclk1_0", "cgu0_sclk1sel",
+						   cgu0 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC598_CLK_CGU0_SCLK0] = cgu_gate("sclk0_0", "cgu0_s0seldiv",
+						   cgu0 + CGU_SCBF_DIS, 0);
+
+	clks[ADSP_SC598_CLK_CGU1_CCLK0] = cgu_gate("cclk0_1", "cgu1_cdiv",
+						   cgu1 + CGU_CCBF_DIS, 0);
+	clks[ADSP_SC598_CLK_CGU1_OCLK] = cgu_gate("oclk_1", "cgu1_odiv",
+						  cgu1 + CGU_SCBF_DIS, 3);
+	clks[ADSP_SC598_CLK_CGU1_DCLK] = cgu_gate("dclk_1", "cgu1_ddiv",
+						  cgu1 + CGU_SCBF_DIS, 2);
+	clks[ADSP_SC598_CLK_CGU1_SCLK1] = cgu_gate("sclk1_1", "cgu1_sclk1sel",
+						   cgu1 + CGU_SCBF_DIS, 1);
+	clks[ADSP_SC598_CLK_CGU1_SCLK0] = cgu_gate("sclk0_1", "cgu1_sclk0sel",
+						   cgu1 + CGU_SCBF_DIS, 0);
+
+	// Extra half rate clocks generated in the CDU
+	clks[ADSP_SC598_CLK_DCLK0_HALF] = clk_register_fixed_factor(NULL, "dclk_0_half",
+								    "dclk_0",
+								    CLK_SET_RATE_PARENT,
+								    1, 2);
+	clks[ADSP_SC598_CLK_DCLK1_HALF] = clk_register_fixed_factor(NULL, "dclk_1_half",
+								    "dclk_1",
+								    CLK_SET_RATE_PARENT,
+								    1, 2);
+	clks[ADSP_SC598_CLK_CGU1_SCLK1_HALF] = clk_register_fixed_factor(NULL,
+									 "sclk1_1_half",
+									 "sclk1_1",
+									 CLK_SET_RATE_PARENT,
+									 1, 2);
+
+	// CDU output muxes
+	clks[ADSP_SC598_CLK_SHARC0_SEL] = cdu_mux("sharc0_sel", cdu + CDU_CFG0,
+						  sharc0_sels);
+	clks[ADSP_SC598_CLK_SHARC1_SEL] = cdu_mux("sharc1_sel", cdu + CDU_CFG1,
+						  sharc1_sels);
+	clks[ADSP_SC598_CLK_ARM_SEL] = cdu_mux("arm_sel", cdu + CDU_CFG2, arm_sels);
+	clks[ADSP_SC598_CLK_CDU_DDR_SEL] = cdu_mux("cdu_ddr_sel", cdu + CDU_CFG3,
+						   cdu_ddr_sels);
+	clks[ADSP_SC598_CLK_CAN_SEL] = cdu_mux("can_sel", cdu + CDU_CFG4, can_sels);
+	clks[ADSP_SC598_CLK_SPDIF_SEL] = cdu_mux("spdif_sel", cdu + CDU_CFG5, spdif_sels);
+	clks[ADSP_SC598_CLK_SPI_SEL] = cdu_mux("spi_sel", cdu + CDU_CFG6, spi_sels);
+	clks[ADSP_SC598_CLK_GIGE_SEL] = cdu_mux("gige_sel", cdu + CDU_CFG7, gige_sels);
+	clks[ADSP_SC598_CLK_LP_SEL] = cdu_mux("lp_sel", cdu + CDU_CFG8, lp_sels);
+	clks[ADSP_SC598_CLK_LP_DDR_SEL] = cdu_mux("lp_ddr_sel", cdu + CDU_CFG9,
+						  lp_ddr_sels);
+	clks[ADSP_SC598_CLK_OSPI_REFCLK_SEL] = cdu_mux("ospi_refclk_sel", cdu + CDU_CFG10,
+						       ospi_refclk_sels);
+	clks[ADSP_SC598_CLK_TRACE_SEL] = cdu_mux("trace_sel", cdu + CDU_CFG12,
+						 trace_sels);
+	clks[ADSP_SC598_CLK_EMMC_SEL] = cdu_mux("emmc_sel", cdu + CDU_CFG13, emmc_sels);
+	clks[ADSP_SC598_CLK_EMMC_TIMER_QMC_SEL] = cdu_mux("emmc_timer_qmc_sel",
+							  cdu + CDU_CFG14,
+							  emmc_timer_sels);
+
+	// CDU output enable gates
+	clks[ADSP_SC598_CLK_SHARC0] = cdu_gate("sharc0", "sharc0_sel", cdu + CDU_CFG0,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC598_CLK_SHARC1] = cdu_gate("sharc1", "sharc1_sel", cdu + CDU_CFG1,
+					       CLK_IS_CRITICAL);
+	clks[ADSP_SC598_CLK_ARM] = cdu_gate("arm", "arm_sel", cdu + CDU_CFG2,
+					    CLK_IS_CRITICAL);
+	clks[ADSP_SC598_CLK_CDU_DDR] = cdu_gate("cdu_ddr", "cdu_ddr_sel", cdu + CDU_CFG3,
+						0);
+	clks[ADSP_SC598_CLK_CAN] = cdu_gate("can", "can_sel", cdu + CDU_CFG4, 0);
+	clks[ADSP_SC598_CLK_SPDIF] = cdu_gate("spdif", "spdif_sel", cdu + CDU_CFG5, 0);
+	clks[ADSP_SC598_CLK_SPI] = cdu_gate("spi", "spi_sel", cdu + CDU_CFG6, 0);
+	clks[ADSP_SC598_CLK_GIGE] = cdu_gate("gige", "gige_sel", cdu + CDU_CFG7, 0);
+	clks[ADSP_SC598_CLK_LP] = cdu_gate("lp", "lp_sel", cdu + CDU_CFG8, 0);
+	clks[ADSP_SC598_CLK_LP_DDR] = cdu_gate("lp_ddr", "lp_ddr_sel", cdu + CDU_CFG9, 0);
+	clks[ADSP_SC598_CLK_OSPI_REFCLK] = cdu_gate("ospi_refclk", "ospi_refclk_sel",
+						    cdu + CDU_CFG10, 0);
+	clks[ADSP_SC598_CLK_TRACE] = cdu_gate("trace", "trace_sel", cdu + CDU_CFG12, 0);
+	clks[ADSP_SC598_CLK_EMMC] = cdu_gate("emmc", "emmc_sel", cdu + CDU_CFG13, 0);
+	clks[ADSP_SC598_CLK_EMMC_TIMER_QMC] = cdu_gate("emmc_timer_qmc",
+						       "emmc_timer_qmc_sel",
+						       cdu + CDU_CFG14, 0);
+
+	// Dedicated DDR output mux
+	clks[ADSP_SC598_CLK_DDR] = clk_register_mux(NULL, "ddr", ddr_sels, 2,
+						    CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+						    pll3, 11, 1, 0);
+
+	ret = cdu_check_clocks(clks, ARRAY_SIZE(clks));
+	if (ret)
+		pr_err("CDU error detected\n");
+
+	return ret;
+}
+
+static const struct udevice_id adi_sc598_clk_ids[] = {
+	{ .compatible = "adi,sc598-clocks" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_sc598_clk) = {
+	.name = "clk_adi_sc598",
+	.id = UCLASS_CLK,
+	.of_match = adi_sc598_clk_ids,
+	.ops		= &adi_clk_ops,
+	.probe = sc598_clock_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
new file mode 100644
index 0000000000..dcadcafa9d
--- /dev/null
+++ b/drivers/clk/adi/clk-shared.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ */
+
+#include "clk.h"
+
+static ulong adi_get_rate(struct clk *clk)
+{
+	struct clk *c;
+	int ret;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	return clk_get_rate(c);
+}
+
+static ulong adi_set_rate(struct clk *clk, ulong rate)
+{
+	//Not yet implemented
+	return 0;
+}
+
+static int adi_enable(struct clk *clk)
+{
+	//Not yet implemented
+	return 0;
+}
+
+static int adi_disable(struct clk *clk)
+{
+	//Not yet implemented
+	return 0;
+}
+
+const struct clk_ops adi_clk_ops = {
+	.set_rate = adi_set_rate,
+	.get_rate = adi_get_rate,
+	.enable = adi_enable,
+	.disable = adi_disable,
+};
+
diff --git a/drivers/clk/adi/clk.h b/drivers/clk/adi/clk.h
new file mode 100644
index 0000000000..f230205c31
--- /dev/null
+++ b/drivers/clk/adi/clk.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Ported from Linux: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#ifndef CLK_ADI_CLK_H
+#define CLK_ADI_CLK_H
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+#include <linux/clk-provider.h>
+
+#define CGU_CTL         0x00
+#define CGU_PLLCTL      0x04
+#define CGU_STAT        0x08
+#define CGU_DIV         0x0C
+#define CGU_CLKOUTSEL   0x10
+#define CGU_OSCWDCTL    0x14
+#define CGU_TSCTL       0x18
+#define CGU_TSVALUE0    0x1C
+#define CGU_TSVALUE1    0x20
+#define CGU_TSCOUNT0    0x24
+#define CGU_TSCOUNT1    0x28
+#define CGU_CCBF_DIS    0x2C
+#define CGU_CCBF_STAT   0x30
+#define CGU_SCBF_DIS    0x38
+#define CGU_SCBF_STAT   0x3C
+#define CGU_DIVEX       0x40
+#define CGU_REVID       0x48
+
+#define CDU_CFG0     0x00
+#define CDU_CFG1     0x04
+#define CDU_CFG2     0x08
+#define CDU_CFG3     0x0C
+#define CDU_CFG4     0x10
+#define CDU_CFG5     0x14
+#define CDU_CFG6     0x18
+#define CDU_CFG7     0x1C
+#define CDU_CFG8     0x20
+#define CDU_CFG9     0x24
+#define CDU_CFG10    0x28
+#define CDU_CFG11    0x2C
+#define CDU_CFG12    0x30
+#define CDU_CFG13    0x34
+#define CDU_CFG14    0x38
+
+#define PLL3_OFFSET 0x2c
+
+#define CDU_CLKINSEL 0x44
+
+#define CGU_MSEL_SHIFT 8
+#define CGU_MSEL_WIDTH 7
+
+#define PLL3_MSEL_SHIFT 4
+#define PLL3_MSEL_WIDTH 7
+
+#define CDU_MUX_SIZE 4
+#define CDU_MUX_SHIFT 1
+#define CDU_MUX_WIDTH 2
+#define CDU_EN_BIT 0
+
+extern const struct clk_ops adi_clk_ops;
+
+struct clk *sc5xx_cgu_pll(const char *name, const char *parent_name,
+			  void __iomem *base, u8 shift, u8 width, u32 m_offset, bool half_m);
+
+/**
+ * All CDU clock muxes are the same size
+ */
+static inline struct clk *cdu_mux(const char *name, void __iomem *reg,
+				  const char * const *parents)
+{
+	return clk_register_mux(NULL, name, parents, CDU_MUX_SIZE,
+		CLK_SET_RATE_PARENT, reg, CDU_MUX_SHIFT, CDU_MUX_WIDTH, 0);
+}
+
+static inline struct clk *cgu_divider(const char *name, const char *parent,
+				      void __iomem *reg, u8 shift, u8 width, u8 extra_flags)
+{
+	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+		reg, shift, width, CLK_DIVIDER_MAX_AT_ZERO | extra_flags);
+}
+
+static inline struct clk *cdu_gate(const char *name, const char *parent,
+				   void __iomem *reg, u32 flags)
+{
+	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT | flags,
+		reg, CDU_EN_BIT, 0, NULL);
+}
+
+static inline struct clk *cgu_gate(const char *name, const char *parent,
+				   void __iomem *reg, u8 bit)
+{
+	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg, bit,
+		CLK_GATE_SET_TO_DISABLE, NULL);
+}
+
+static inline int cdu_check_clocks(struct clk *clks[], size_t count)
+{
+	size_t i;
+
+	for (i = 0; i < count; ++i) {
+		if (clks[i]) {
+			if (IS_ERR(clks[i])) {
+				pr_err("Clock %zu failed to register: %ld\n", i, PTR_ERR(clks[i]));
+				return PTR_ERR(clks[i]);
+			}
+			clks[i]->id = i;
+		} else {
+			pr_err("ADI Clock framework: Null pointer detected on clock %zu\n", i);
+		}
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/include/dt-bindings/clock/adi-sc5xx-clock.h b/include/dt-bindings/clock/adi-sc5xx-clock.h
new file mode 100644
index 0000000000..4a5373d114
--- /dev/null
+++ b/include/dt-bindings/clock/adi-sc5xx-clock.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ */
+
+#ifndef DT_BINDINGS_CLOCK_ADI_SC5XX_CLOCK_H
+#define DT_BINDINGS_CLOCK_ADI_SC5XX_CLOCK_H
+
+//ADSP-SC594
+#define ADSP_SC594_CLK_DUMMY 0
+#define ADSP_SC594_CLK_SYS_CLKIN0 1
+#define ADSP_SC594_CLK_SYS_CLKIN1 2
+#define ADSP_SC594_CLK_CGU1_IN 3
+#define ADSP_SC594_CLK_CGU0_PLL_IN 4
+#define ADSP_SC594_CLK_CGU1_PLL_IN 5
+#define ADSP_SC594_CLK_CGU0_VCO_OUT 6
+#define ADSP_SC594_CLK_CGU1_VCO_OUT 7
+#define ADSP_SC594_CLK_CGU0_PLLCLK 8
+#define ADSP_SC594_CLK_CGU1_PLLCLK 9
+#define ADSP_SC594_CLK_CGU0_CDIV 10
+#define ADSP_SC594_CLK_CGU0_SYSCLK 11
+#define ADSP_SC594_CLK_CGU0_DDIV 12
+#define ADSP_SC594_CLK_CGU0_ODIV 13
+#define ADSP_SC594_CLK_CGU0_S0SELDIV 14
+#define ADSP_SC594_CLK_CGU0_S1SELDIV 15
+#define ADSP_SC594_CLK_CGU0_S1SELEXDIV 16
+#define ADSP_SC594_CLK_CGU0_S1SEL 17
+#define ADSP_SC594_CLK_CGU1_CDIV 18
+#define ADSP_SC594_CLK_CGU1_SYSCLK 19
+#define ADSP_SC594_CLK_CGU1_DDIV 20
+#define ADSP_SC594_CLK_CGU1_ODIV 21
+#define ADSP_SC594_CLK_CGU1_S0SELDIV 22
+#define ADSP_SC594_CLK_CGU1_S1SELDIV 23
+#define ADSP_SC594_CLK_CGU1_S1SELEXDIV 24
+#define ADSP_SC594_CLK_CGU1_S1SEL 25
+#define ADSP_SC594_CLK_CGU0_CCLK0 26
+#define ADSP_SC594_CLK_CGU0_CCLK1 27
+#define ADSP_SC594_CLK_CGU0_OCLK 28
+#define ADSP_SC594_CLK_CGU0_DCLK 29
+#define ADSP_SC594_CLK_CGU0_SCLK1 30
+#define ADSP_SC594_CLK_CGU0_SCLK0 31
+#define ADSP_SC594_CLK_CGU1_CCLK0 32
+#define ADSP_SC594_CLK_CGU1_CCLK1 33
+#define ADSP_SC594_CLK_CGU1_OCLK 34
+#define ADSP_SC594_CLK_CGU1_DCLK 35
+#define ADSP_SC594_CLK_CGU1_SCLK1 36
+#define ADSP_SC594_CLK_CGU1_SCLK0 37
+#define ADSP_SC594_CLK_SHARC0_SEL 38
+#define ADSP_SC594_CLK_SHARC1_SEL 39
+#define ADSP_SC594_CLK_ARM_SEL 40
+#define ADSP_SC594_CLK_CDU_DDR_SEL 41
+#define ADSP_SC594_CLK_CAN_SEL 42
+#define ADSP_SC594_CLK_SPDIF_SEL 43
+#define ADSP_SC594_CLK_RESERVED_SEL 44
+#define ADSP_SC594_CLK_GIGE_SEL 45
+#define ADSP_SC594_CLK_LP_SEL 46
+#define ADSP_SC594_CLK_LPDDR_SEL 47
+#define ADSP_SC594_CLK_OSPI_SEL 48
+#define ADSP_SC594_CLK_TRACE_SEL 49
+#define ADSP_SC594_CLK_SHARC0 50
+#define ADSP_SC594_CLK_SHARC1 51
+#define ADSP_SC594_CLK_ARM 52
+#define ADSP_SC594_CLK_CDU_DDR 53
+#define ADSP_SC594_CLK_CAN 54
+#define ADSP_SC594_CLK_SPDIF 55
+#define ADSP_SC594_CLK_SPI 56
+#define ADSP_SC594_CLK_GIGE 57
+#define ADSP_SC594_CLK_LP 58
+#define ADSP_SC594_CLK_LPDDR 59
+#define ADSP_SC594_CLK_OSPI 60
+#define ADSP_SC594_CLK_TRACE 61
+#define ADSP_SC594_CLK_END 62
+
+//ADSP-SC598
+#define ADSP_SC598_CLK_DUMMY 0
+#define ADSP_SC598_CLK_SYS_CLKIN0 1
+#define ADSP_SC598_CLK_SYS_CLKIN1 2
+#define ADSP_SC598_CLK_CGU0_PLL_IN 3
+#define ADSP_SC598_CLK_CGU0_VCO_OUT 4
+#define ADSP_SC598_CLK_CGU0_PLLCLK 5
+#define ADSP_SC598_CLK_CGU1_IN 6
+#define ADSP_SC598_CLK_CGU1_PLL_IN 7
+#define ADSP_SC598_CLK_CGU1_VCO_OUT 8
+#define ADSP_SC598_CLK_CGU1_PLLCLK 9
+#define ADSP_SC598_CLK_CGU0_CDIV 10
+#define ADSP_SC598_CLK_CGU0_SYSCLK 11
+#define ADSP_SC598_CLK_CGU0_DDIV 12
+#define ADSP_SC598_CLK_CGU0_ODIV 13
+#define ADSP_SC598_CLK_CGU0_S0SELDIV 14
+#define ADSP_SC598_CLK_CGU0_S1SELDIV 15
+#define ADSP_SC598_CLK_CGU0_S1SELEXDIV 16
+#define ADSP_SC598_CLK_CGU0_S1SEL 17
+#define ADSP_SC598_CLK_CGU1_CDIV 18
+#define ADSP_SC598_CLK_CGU1_SYSCLK 19
+#define ADSP_SC598_CLK_CGU1_DDIV 20
+#define ADSP_SC598_CLK_CGU1_ODIV 21
+#define ADSP_SC598_CLK_CGU1_S0SELDIV 22
+#define ADSP_SC598_CLK_CGU1_S1SELDIV 23
+#define ADSP_SC598_CLK_CGU1_S0SELEXDIV 24
+#define ADSP_SC598_CLK_CGU1_S1SELEXDIV 25
+#define ADSP_SC598_CLK_CGU1_S0SEL 26
+#define ADSP_SC598_CLK_CGU1_S1SEL 27
+#define ADSP_SC598_CLK_CGU0_CCLK2 28
+#define ADSP_SC598_CLK_CGU0_CCLK0 29
+#define ADSP_SC598_CLK_CGU0_OCLK 30
+#define ADSP_SC598_CLK_CGU0_DCLK 31
+#define ADSP_SC598_CLK_CGU0_SCLK1 32
+#define ADSP_SC598_CLK_CGU0_SCLK0 33
+#define ADSP_SC598_CLK_CGU1_CCLK0 34
+#define ADSP_SC598_CLK_CGU1_OCLK 35
+#define ADSP_SC598_CLK_CGU1_DCLK 36
+#define ADSP_SC598_CLK_CGU1_SCLK1 37
+#define ADSP_SC598_CLK_CGU1_SCLK0 38
+#define ADSP_SC598_CLK_CGU1_CCLK2 39
+#define ADSP_SC598_CLK_DCLK0_HALF 40
+#define ADSP_SC598_CLK_DCLK1_HALF 41
+#define ADSP_SC598_CLK_CGU1_SCLK1_HALF 42
+#define ADSP_SC598_CLK_SHARC0_SEL 43
+#define ADSP_SC598_CLK_SHARC1_SEL 44
+#define ADSP_SC598_CLK_ARM_SEL 45
+#define ADSP_SC598_CLK_CDU_DDR_SEL 46
+#define ADSP_SC598_CLK_CAN_SEL 47
+#define ADSP_SC598_CLK_SPDIF_SEL 48
+#define ADSP_SC598_CLK_SPI_SEL 49
+#define ADSP_SC598_CLK_GIGE_SEL 50
+#define ADSP_SC598_CLK_LP_SEL 51
+#define ADSP_SC598_CLK_LP_DDR_SEL 52
+#define ADSP_SC598_CLK_OSPI_REFCLK_SEL 53
+#define ADSP_SC598_CLK_TRACE_SEL 54
+#define ADSP_SC598_CLK_EMMC_SEL 55
+#define ADSP_SC598_CLK_EMMC_TIMER_QMC_SEL 56
+#define ADSP_SC598_CLK_SHARC0 57
+#define ADSP_SC598_CLK_SHARC1 58
+#define ADSP_SC598_CLK_ARM 59
+#define ADSP_SC598_CLK_CDU_DDR 60
+#define ADSP_SC598_CLK_CAN 61
+#define ADSP_SC598_CLK_SPDIF 62
+#define ADSP_SC598_CLK_SPI 63
+#define ADSP_SC598_CLK_GIGE 64
+#define ADSP_SC598_CLK_LP 65
+#define ADSP_SC598_CLK_LP_DDR 66
+#define ADSP_SC598_CLK_OSPI_REFCLK 67
+#define ADSP_SC598_CLK_TRACE 68
+#define ADSP_SC598_CLK_EMMC 69
+#define ADSP_SC598_CLK_EMMC_TIMER_QMC 70
+#define ADSP_SC598_CLK_3PLL_PLL_IN 71
+#define ADSP_SC598_CLK_3PLL_VCO_OUT 72
+#define ADSP_SC598_CLK_3PLL_PLLCLK 73
+#define ADSP_SC598_CLK_3PLL_DDIV 74
+#define ADSP_SC598_CLK_DDR 75
+#define ADSP_SC598_CLK_END 76
+
+//ADSP-SC58X
+#define ADSP_SC58X_CLK_DUMMY 0
+#define ADSP_SC58X_CLK_SYS_CLKIN0 1
+#define ADSP_SC58X_CLK_SYS_CLKIN1 2
+#define ADSP_SC58X_CLK_CGU0_PLL_IN 3
+#define ADSP_SC58X_CLK_CGU0_VCO_OUT 4
+#define ADSP_SC58X_CLK_CGU0_PLLCLK 5
+#define ADSP_SC58X_CLK_CGU1_IN 6
+#define ADSP_SC58X_CLK_CGU1_PLL_IN 7
+#define ADSP_SC58X_CLK_CGU1_VCO_OUT 8
+#define ADSP_SC58X_CLK_CGU1_PLLCLK 9
+#define ADSP_SC58X_CLK_CGU0_CDIV 10
+#define ADSP_SC58X_CLK_CGU0_SYSCLK 11
+#define ADSP_SC58X_CLK_CGU0_DDIV 12
+#define ADSP_SC58X_CLK_CGU0_ODIV 13
+#define ADSP_SC58X_CLK_CGU0_S0SELDIV 14
+#define ADSP_SC58X_CLK_CGU0_S1SELDIV 15
+#define ADSP_SC58X_CLK_CGU1_CDIV 16
+#define ADSP_SC58X_CLK_CGU1_SYSCLK 17
+#define ADSP_SC58X_CLK_CGU1_DDIV 18
+#define ADSP_SC58X_CLK_CGU1_ODIV 19
+#define ADSP_SC58X_CLK_CGU1_S0SELDIV 20
+#define ADSP_SC58X_CLK_CGU1_S1SELDIV 21
+#define ADSP_SC58X_CLK_CGU0_CCLK0 22
+#define ADSP_SC58X_CLK_CGU0_CCLK1 23
+#define ADSP_SC58X_CLK_CGU0_OCLK 24
+#define ADSP_SC58X_CLK_CGU0_DCLK 25
+#define ADSP_SC58X_CLK_CGU0_SCLK1 26
+#define ADSP_SC58X_CLK_CGU0_SCLK0 27
+#define ADSP_SC58X_CLK_CGU1_CCLK0 28
+#define ADSP_SC58X_CLK_CGU1_CCLK1 29
+#define ADSP_SC58X_CLK_CGU1_OCLK 30
+#define ADSP_SC58X_CLK_CGU1_DCLK 31
+#define ADSP_SC58X_CLK_CGU1_SCLK1 32
+#define ADSP_SC58X_CLK_CGU1_SCLK0 33
+#define ADSP_SC58X_CLK_OCLK0_HALF 34
+#define ADSP_SC58X_CLK_CCLK1_1_HALF 35
+#define ADSP_SC58X_CLK_SHARC0_SEL 36
+#define ADSP_SC58X_CLK_SHARC1_SEL 37
+#define ADSP_SC58X_CLK_ARM_SEL 38
+#define ADSP_SC58X_CLK_CDU_DDR_SEL 39
+#define ADSP_SC58X_CLK_CAN_SEL 40
+#define ADSP_SC58X_CLK_SPDIF_SEL 41
+#define ADSP_SC58X_CLK_RESERVED_SEL 42
+#define ADSP_SC58X_CLK_GIGE_SEL 43
+#define ADSP_SC58X_CLK_LP_SEL 44
+#define ADSP_SC58X_CLK_SDIO_SEL 45
+#define ADSP_SC58X_CLK_SHARC0 46
+#define ADSP_SC58X_CLK_SHARC1 47
+#define ADSP_SC58X_CLK_ARM 48
+#define ADSP_SC58X_CLK_CDU_DDR 49
+#define ADSP_SC58X_CLK_CAN 50
+#define ADSP_SC58X_CLK_SPDIF 51
+#define ADSP_SC58X_CLK_RESERVED 52
+#define ADSP_SC58X_CLK_GIGE 53
+#define ADSP_SC58X_CLK_LP 54
+#define ADSP_SC58X_CLK_SDIO 55
+#define ADSP_SC58X_CLK_END 56
+
+//ADSP-SC57X
+#define ADSP_SC57X_CLK_DUMMY 0
+#define ADSP_SC57X_CLK_SYS_CLKIN0 1
+#define ADSP_SC57X_CLK_SYS_CLKIN1 2
+#define ADSP_SC57X_CLK_CGU0_PLL_IN 3
+#define ADSP_SC57X_CLK_CGU0_PLLCLK 4
+#define ADSP_SC57X_CLK_CGU1_IN 5
+#define ADSP_SC57X_CLK_CGU1_PLL_IN 6
+#define ADSP_SC57X_CLK_CGU1_PLLCLK 7
+#define ADSP_SC57X_CLK_CGU0_CDIV 8
+#define ADSP_SC57X_CLK_CGU0_SYSCLK 9
+#define ADSP_SC57X_CLK_CGU0_DDIV 10
+#define ADSP_SC57X_CLK_CGU0_ODIV 11
+#define ADSP_SC57X_CLK_CGU0_S0SELDIV 12
+#define ADSP_SC57X_CLK_CGU0_S1SELDIV 13
+#define ADSP_SC57X_CLK_CGU1_CDIV 14
+#define ADSP_SC57X_CLK_CGU1_SYSCLK 15
+#define ADSP_SC57X_CLK_CGU1_DDIV 16
+#define ADSP_SC57X_CLK_CGU1_ODIV 17
+#define ADSP_SC57X_CLK_CGU1_S0SELDIV 18
+#define ADSP_SC57X_CLK_CGU1_S1SELDIV 19
+#define ADSP_SC57X_CLK_CGU0_CCLK0 20
+#define ADSP_SC57X_CLK_CGU0_CCLK1 21
+#define ADSP_SC57X_CLK_CGU0_OCLK 22
+#define ADSP_SC57X_CLK_CGU0_DCLK 23
+#define ADSP_SC57X_CLK_CGU0_SCLK1 24
+#define ADSP_SC57X_CLK_CGU0_SCLK0 25
+#define ADSP_SC57X_CLK_CGU1_CCLK0 26
+#define ADSP_SC57X_CLK_CGU1_CCLK1 27
+#define ADSP_SC57X_CLK_CGU1_OCLK 28
+#define ADSP_SC57X_CLK_CGU1_DCLK 29
+#define ADSP_SC57X_CLK_CGU1_SCLK1 30
+#define ADSP_SC57X_CLK_CGU1_SCLK0 31
+#define ADSP_SC57X_CLK_OCLK0_HALF 32
+#define ADSP_SC57X_CLK_CCLK1_1_HALF 33
+#define ADSP_SC57X_CLK_SHARC0_SEL 34
+#define ADSP_SC57X_CLK_SHARC1_SEL 35
+#define ADSP_SC57X_CLK_ARM_SEL 36
+#define ADSP_SC57X_CLK_CDU_DDR_SEL 37
+#define ADSP_SC57X_CLK_CAN_SEL 38
+#define ADSP_SC57X_CLK_SPDIF_SEL 39
+#define ADSP_SC57X_CLK_GIGE_SEL 40
+#define ADSP_SC57X_CLK_SDIO_SEL 41
+#define ADSP_SC57X_CLK_SHARC0 42
+#define ADSP_SC57X_CLK_SHARC1 43
+#define ADSP_SC57X_CLK_ARM 44
+#define ADSP_SC57X_CLK_CDU_DDR 45
+#define ADSP_SC57X_CLK_CAN 46
+#define ADSP_SC57X_CLK_SPDIF 47
+#define ADSP_SC57X_CLK_GIGE 48
+#define ADSP_SC57X_CLK_SDIO 49
+#define ADSP_SC57X_CLK_END 50
+
+#endif
-- 
2.43.2

