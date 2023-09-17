Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAAFCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 10:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C6786529;
	Sun, 17 Sep 2023 12:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="MMjDKOKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375BE864B3; Sun, 17 Sep 2023 12:13:53 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28A58469B
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 3DBBC12000B;
 Sun, 17 Sep 2023 13:13:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3DBBC12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694945630;
 bh=kSOlgG/16+1+VY/4iOTvVux7Pp8IXgKYDPN43PQm5TQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=MMjDKOKuqIJo0VHY5XszzGpZPaTjzQwLx7Ubnv97vN1B9g8t4A3AMciuUEmUBeT9H
 x7GpQHd9Lzlbo41vuJxO4S6jUiNVA1vN/uAGpsg/oyGa5Cnmp5NMelM42UzUcPxqzt
 sLlf5bPXg3t7EAAzTampwrrUwPVCJBZxaW3qiAlPkDFxubTYFPCn2SXFvbVpgOlma0
 gDgodTFNxn3yefuwXEmO56tY795VDy/8LeOoMOsRddFd7z3KzGYdYuNviUFuJUl0nL
 Sc2fs13Pa9nBUO23heeSWe0gzhK5sszJ36YnfppzWD3UPhunegYYCtFWIlhkFYH309
 J06Q9VSBfXyJQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Sun, 17 Sep 2023 13:13:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 17 Sep 2023 13:13:49 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
 <ivprusov@salutedevices.com>, <u-boot-amlogic@groups.io>,
 <u-boot@lists.denx.de>
Subject: [RESEND PATCH v1 2/2] clk: Add clock driver for Amlogic A1
Date: Sun, 17 Sep 2023 13:13:08 +0300
Message-ID: <20230917101308.1250-3-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917101308.1250-1-ivprusov@salutedevices.com>
References: <20230917101308.1250-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179908 [Sep 17 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/17 09:12:00 #21910978
X-KSMG-AntiVirus-Status: Clean, skipped
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

This patch adds basic clock driver for Amlogic A1 Family which supports
enabling/disabling some gates, getting frequencies and setting rate
with limited reparenting.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 arch/arm/include/asm/arch-meson/clock-a1.h |  23 +
 drivers/clk/meson/Kconfig                  |   8 +
 drivers/clk/meson/Makefile                 |   1 +
 drivers/clk/meson/a1.c                     | 681 +++++++++++++++++++++
 4 files changed, 713 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
 create mode 100644 drivers/clk/meson/a1.c

diff --git a/arch/arm/include/asm/arch-meson/clock-a1.h b/arch/arm/include/asm/arch-meson/clock-a1.h
new file mode 100644
index 0000000000..f6795f5e0c
--- /dev/null
+++ b/arch/arm/include/asm/arch-meson/clock-a1.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 - AmLogic, Inc.
+ * Copyright 2023 (C) SberDevices, Inc.
+ */
+
+#ifndef _ARCH_MESON_CLOCK_A1_H_
+#define _ARCH_MESON_CLOCK_A1_H_
+
+/*
+ * Clock controller register offsets
+ */
+#define A1_SYS_OSCIN_CTRL		0x0
+#define A1_SYS_CLK_CTRL0		0x10
+#define A1_SYS_CLK_EN0			0x1c
+#define A1_SAR_ADC_CLK_CTR		0xc0
+#define A1_SPIFC_CLK_CTRL		0xd8
+#define A1_USB_BUSCLK_CTRL		0xdc
+#define A1_SD_EMMC_CLK_CTRL		0xe0
+
+#define A1_ANACTRL_FIXPLL_CTRL0		0x0
+
+#endif /* _ARCH_MESON_CLOCK_A1_H_ */
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 994b44ad7a..cdc9d6f76c 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -21,3 +21,11 @@ config CLK_MESON_G12A
 	help
 	  Enable clock support for the Amlogic G12A SoC family, such as
 	  the S905X/D2
+
+config CLK_MESON_A1
+	bool "Enable clock support for Amlogic A1"
+	depends on CLK && ARCH_MESON
+	default MESON_A1
+	help
+	  Enable clock support for the Amlogic A1 SoC family, such as
+	  the A113L
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index a486b13e9c..d975f07aab 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_MESON_AXG) += axg.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a.o
 obj-$(CONFIG_CLK_MESON_G12A) += g12a-ao.o
+obj-$(CONFIG_CLK_MESON_A1) += a1.o
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
new file mode 100644
index 0000000000..6b2b9e6925
--- /dev/null
+++ b/drivers/clk/meson/a1.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+#include <asm/arch/clock-a1.h>
+#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
+#include "clk_meson.h"
+
+/*
+ * This driver supports both PLL and peripherals clock sources.
+ * Following operations are supported:
+ * - calculating clock frequency on a limited tree
+ * - reading muxes and dividers
+ * - enabling/disabling gates without propagation
+ * - reparenting without rate propagation, only on muxes
+ * - setting rates with limited reparenting, only on dividers with mux parent
+ */
+
+#define NR_CLKS				154
+#define NR_PLL_CLKS			11
+
+#define EXTERNAL_XTAL			(NR_CLKS + 0)
+#define EXTERNAL_FCLK_DIV2		(NR_CLKS + 1)
+#define EXTERNAL_FCLK_DIV3		(NR_CLKS + 2)
+#define EXTERNAL_FCLK_DIV5		(NR_CLKS + 3)
+#define EXTERNAL_FCLK_DIV7		(NR_CLKS + 4)
+
+#define EXTERNAL_FIXPLL_IN		(NR_PLL_CLKS + 1)
+
+#define SET_PARM_VALUE(_priv, _parm, _val)				\
+	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
+			   SETPMASK((_parm)->width, (_parm)->shift),	\
+			   (_val) << (_parm)->shift)
+
+#define GET_PARM_VALUE(_priv, _parm)					\
+({									\
+	uint _reg;							\
+	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
+	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
+})
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+enum meson_clk_type {
+	MESON_CLK_ANY = 0,
+	MESON_CLK_GATE,
+	MESON_CLK_MUX,
+	MESON_CLK_DIV,
+	MESON_CLK_FIXED_DIV,
+	MESON_CLK_EXTERNAL,
+	MESON_CLK_PLL,
+};
+
+struct meson_clk_info {
+	const char *name;
+	union {
+		const struct parm *parm;
+		u8 div;
+	};
+	const unsigned int *parents;
+	const enum meson_clk_type type;
+};
+
+struct meson_clk_data {
+	const u8 num_clocks;
+	const struct meson_clk_info **clocks;
+};
+
+#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[])__VA_ARGS__,		\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_MUX,					\
+	})
+
+#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_DIV,					\
+	})
+
+#define CLK_DIV_FIXED(_name, _div, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.div = (_div),						\
+		.name = (_name),					\
+		.type = MESON_CLK_FIXED_DIV,				\
+	})
+
+#define CLK_EXTERNAL(_name)						\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { -ENOENT },		\
+		.type = MESON_CLK_EXTERNAL,				\
+	})
+
+#define CLK_GATE(_name, _reg, _shift, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = 1,					\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_GATE,					\
+	})
+
+#define CLK_PLL(_name, _parent, ...)					\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = (const struct parm[])__VA_ARGS__,		\
+		.type = MESON_CLK_PLL,					\
+	})
+
+static const struct meson_clk_info *meson_clocks[] = {
+	[CLKID_SPIFC_SEL] = CLK_MUX("spifc_sel", A1_SPIFC_CLK_CTRL, 9, 2, {
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+	}),
+	[CLKID_SPIFC_SEL2] = CLK_MUX("spifc_sel2", A1_SPIFC_CLK_CTRL, 15, 1, {
+		CLKID_SPIFC_DIV,
+		EXTERNAL_XTAL,
+	}),
+	[CLKID_USB_BUS_SEL] = CLK_MUX("usb_bus_sel", A1_USB_BUSCLK_CTRL, 9, 2, {
+		-ENOENT,
+		CLKID_SYS,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+	}),
+	[CLKID_SYS] = CLK_MUX("sys", A1_SYS_CLK_CTRL0, 31, 1, {
+		CLKID_SYS_A,
+		CLKID_SYS_B,
+	}),
+	[CLKID_SYS_A_SEL] = CLK_MUX("sys_a_sel", A1_SYS_CLK_CTRL0, 10, 3, {
+		-ENOENT,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+	}),
+	[CLKID_SYS_B_SEL] = CLK_MUX("sys_b_sel", A1_SYS_CLK_CTRL0, 26, 3, {
+		-ENOENT,
+		EXTERNAL_FCLK_DIV2,
+		EXTERNAL_FCLK_DIV3,
+		EXTERNAL_FCLK_DIV5,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+	}),
+
+	[CLKID_SPIFC_DIV] = CLK_DIV("spifc_div", A1_SPIFC_CLK_CTRL, 0, 8,
+		CLKID_SPIFC_SEL
+	),
+	[CLKID_USB_BUS_DIV] = CLK_DIV("usb_bus_div", A1_USB_BUSCLK_CTRL, 0, 8,
+		CLKID_USB_BUS_SEL
+	),
+	[CLKID_SYS_A_DIV] = CLK_DIV("sys_a_div", A1_SYS_CLK_CTRL0, 0, 10,
+		CLKID_SYS_A_SEL
+	),
+	[CLKID_SYS_B_DIV] = CLK_DIV("sys_b_div", A1_SYS_CLK_CTRL0, 16, 10,
+		CLKID_SYS_B_SEL
+	),
+
+	[CLKID_SPIFC] = CLK_GATE("spifc", A1_SPIFC_CLK_CTRL, 8,
+		CLKID_SPIFC_SEL2
+	),
+	[CLKID_USB_BUS] = CLK_GATE("usb_bus", A1_USB_BUSCLK_CTRL, 8,
+		CLKID_USB_BUS_DIV
+	),
+	[CLKID_SYS_A] = CLK_GATE("sys_a", A1_SYS_CLK_CTRL0, 13,
+		CLKID_SYS_A_DIV
+	),
+	[CLKID_SYS_B] = CLK_GATE("sys_b", A1_SYS_CLK_CTRL0, 29,
+		CLKID_SYS_B_DIV
+	),
+	[CLKID_FIXPLL_IN] = CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
+		EXTERNAL_XTAL
+	),
+	[CLKID_SARADC] = CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
+		-ENOENT
+	),
+	[CLKID_SARADC_EN] = CLK_GATE("saradc_en", A1_SYS_CLK_EN0, 13,
+		CLKID_SYS
+	),
+
+	[EXTERNAL_XTAL] = CLK_EXTERNAL("xtal"),
+	[EXTERNAL_FCLK_DIV2] = CLK_EXTERNAL("fclk_div2"),
+	[EXTERNAL_FCLK_DIV3] = CLK_EXTERNAL("fclk_div3"),
+	[EXTERNAL_FCLK_DIV5] = CLK_EXTERNAL("fclk_div5"),
+	[EXTERNAL_FCLK_DIV7] = CLK_EXTERNAL("fclk_div7"),
+};
+
+static const struct meson_clk_info *meson_pll_clocks[] = {
+	[EXTERNAL_FIXPLL_IN] = CLK_EXTERNAL("fixpll_in"),
+
+	[CLKID_FIXED_PLL_DCO] = CLK_PLL("fixed_pll_dco", EXTERNAL_FIXPLL_IN, {
+			{A1_ANACTRL_FIXPLL_CTRL0, 0, 8},
+			{A1_ANACTRL_FIXPLL_CTRL0, 10, 5},
+	}),
+
+	[CLKID_FCLK_DIV2_DIV] = CLK_DIV_FIXED("fclk_div2_div", 2,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV3_DIV] = CLK_DIV_FIXED("fclk_div3_div", 3,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV5_DIV] = CLK_DIV_FIXED("fclk_div5_div", 5,
+		CLKID_FIXED_PLL
+	),
+	[CLKID_FCLK_DIV7_DIV] = CLK_DIV_FIXED("fclk_div7_div", 7,
+		CLKID_FIXED_PLL
+	),
+
+	[CLKID_FIXED_PLL] = CLK_GATE("fixed_pll", A1_ANACTRL_FIXPLL_CTRL0, 20,
+		CLKID_FIXED_PLL_DCO
+	),
+	[CLKID_FCLK_DIV2] = CLK_GATE("fclk_div2", A1_ANACTRL_FIXPLL_CTRL0, 21,
+		CLKID_FCLK_DIV2_DIV
+	),
+	[CLKID_FCLK_DIV3] = CLK_GATE("fclk_div3", A1_ANACTRL_FIXPLL_CTRL0, 22,
+		CLKID_FCLK_DIV3_DIV
+	),
+	[CLKID_FCLK_DIV5] = CLK_GATE("fclk_div5", A1_ANACTRL_FIXPLL_CTRL0, 23,
+		CLKID_FCLK_DIV5_DIV
+	),
+	[CLKID_FCLK_DIV7] = CLK_GATE("fclk_div7", A1_ANACTRL_FIXPLL_CTRL0, 24,
+		CLKID_FCLK_DIV7_DIV
+	),
+};
+
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id,
+						       enum meson_clk_type type)
+{
+	struct meson_clk_data *data;
+	const struct meson_clk_info *info;
+
+	data = (struct meson_clk_data *)dev_get_driver_data(clk->dev);
+	if (id >= data->num_clocks)
+		return ERR_PTR(-EINVAL);
+
+	info = data->clocks[id];
+	if (!info)
+		return ERR_PTR(-ENOENT);
+
+	if (type != MESON_CLK_ANY && type != info->type)
+		return ERR_PTR(-EINVAL);
+
+	return info;
+}
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
+
+	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	SET_PARM_VALUE(priv, info->parm, on);
+
+	return 0;
+}
+
+static int meson_clk_enable(struct clk *clk)
+{
+	return meson_set_gate(clk, true);
+}
+
+static int meson_clk_disable(struct clk *clk)
+{
+	return meson_set_gate(clk, false);
+}
+
+static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	u16 n;
+	ulong rate;
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	n = GET_PARM_VALUE(priv, info->parm) + 1;
+
+	rate = meson_clk_get_rate_by_id(clk, info->parents[0]);
+
+	return rate / n;
+}
+
+static int meson_clk_get_parent(struct clk *clk, unsigned long id)
+{
+	uint reg = 0;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (info->type == MESON_CLK_MUX) {
+		reg = GET_PARM_VALUE(priv, info->parm);
+		if (IS_ERR_VALUE(reg))
+			return reg;
+	}
+
+	return info->parents[reg];
+}
+
+static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	const struct parm *pm, *pn;
+	ulong parent_rate_mhz;
+	unsigned int parent;
+	u16 n, m;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	pm = &info->parm[0];
+	pn = &info->parm[1];
+
+	n = GET_PARM_VALUE(priv, pn);
+	m = GET_PARM_VALUE(priv, pm);
+
+	if (n == 0)
+		return -EINVAL;
+
+	parent = info->parents[0];
+	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
+
+	return parent_rate_mhz * m / n * 1000000;
+}
+
+static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
+{
+	ulong rate, parent;
+	const struct meson_clk_info *info;
+
+	if (IS_ERR_VALUE(id))
+		return id;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	switch (info->type) {
+	case MESON_CLK_PLL:
+		rate = meson_pll_get_rate(clk, id);
+		break;
+	case MESON_CLK_GATE:
+	case MESON_CLK_MUX:
+		parent = meson_clk_get_parent(clk, id);
+		rate = meson_clk_get_rate_by_id(clk, parent);
+		break;
+	case MESON_CLK_DIV:
+		rate = meson_div_get_rate(clk, id);
+		break;
+	case MESON_CLK_FIXED_DIV:
+		parent = meson_clk_get_parent(clk, id);
+		rate = meson_clk_get_rate_by_id(clk, parent) / info->div;
+		break;
+	case MESON_CLK_EXTERNAL: {
+		int ret;
+		struct clk external_clk;
+
+		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
+		if (ret)
+			return ret;
+
+		rate = clk_get_rate(&external_clk);
+		break;
+	}
+	default:
+		rate = -EINVAL;
+		break;
+	}
+
+	return rate;
+}
+
+static ulong meson_clk_get_rate(struct clk *clk)
+{
+	return meson_clk_get_rate_by_id(clk, clk->id);
+}
+
+/* This implements rate propagation for dividers placed after multiplexer:
+ *  ---------|\
+ *     ..... | |---DIV--
+ *  ---------|/
+ */
+static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
+{
+	unsigned int i, best_div_val;
+	unsigned long best_delta, best_parent;
+	const struct meson_clk_info *div;
+	const struct meson_clk_info *mux;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+
+	div = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	if (IS_ERR(div))
+		return PTR_ERR(div);
+
+	mux = meson_clk_get_info(clk, div->parents[0], MESON_CLK_MUX);
+	if (IS_ERR(mux))
+		return PTR_ERR(mux);
+
+	best_parent = -EINVAL;
+	best_delta = ULONG_MAX;
+	for (i = 0; i < (1 << mux->parm->width); i++) {
+		unsigned long parent_rate, delta;
+		unsigned int div_val;
+
+		parent_rate = meson_clk_get_rate_by_id(clk, mux->parents[i]);
+		if (IS_ERR_VALUE(parent_rate))
+			continue;
+
+		/* If overflow, try to use max divider value */
+		div_val = min(DIV_ROUND_CLOSEST(parent_rate, rate),
+			      (1UL << div->parm->width));
+
+		delta = abs(rate - (parent_rate / div_val));
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_div_val = div_val;
+			best_parent = i;
+		}
+	}
+
+	if (IS_ERR_VALUE(best_parent))
+		return best_parent;
+
+	SET_PARM_VALUE(priv, mux->parm, best_parent);
+	/* Divider is set to (field value + 1), hence the decrement */
+	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
+
+	return 0;
+}
+
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate);
+
+static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
+{
+	int i;
+	ulong ret = -EINVAL;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		ret = meson_clk_set_rate_by_id(clk, info->parents[i], rate);
+		if (!ret) {
+			SET_PARM_VALUE(priv, info->parm, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate)
+{
+	switch (id) {
+	case CLKID_SPIFC_DIV:
+	case CLKID_USB_BUS_DIV:
+		return meson_composite_set_rate(clk, id, rate);
+	case CLKID_SPIFC:
+	case CLKID_USB_BUS: {
+		unsigned long parent = meson_clk_get_parent(clk, id);
+
+		return meson_clk_set_rate_by_id(clk, parent, rate);
+	}
+	case CLKID_SPIFC_SEL2:
+		return meson_mux_set_rate(clk, id, rate);
+	}
+
+	return -EINVAL;
+}
+
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return meson_clk_set_rate_by_id(clk, clk->id, rate);
+}
+
+static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
+{
+	unsigned int i, parent_index;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, clk->id, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	parent_index = -EINVAL;
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		if (parent_id == info->parents[i]) {
+			parent_index = i;
+			break;
+		}
+	}
+
+	if (IS_ERR_VALUE(parent_index))
+		return parent_index;
+
+	SET_PARM_VALUE(priv, info->parm, parent_index);
+
+	return 0;
+}
+
+static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
+{
+	return meson_mux_set_parent_by_id(clk, parent_clk->id);
+}
+
+static struct clk_ops meson_clk_ops = {
+	.disable	= meson_clk_disable,
+	.enable		= meson_clk_enable,
+	.get_rate	= meson_clk_get_rate,
+	.set_rate	= meson_clk_set_rate,
+	.set_parent	= meson_clk_set_parent,
+};
+
+static int meson_clk_probe(struct udevice *dev)
+{
+	struct meson_clk *priv = dev_get_priv(dev);
+
+	return regmap_init_mem(dev_ofnode(dev), &priv->map);
+}
+
+struct meson_clk_data meson_a1_peripherals_info = {
+	.clocks = meson_clocks,
+	.num_clocks = ARRAY_SIZE(meson_clocks),
+};
+
+struct meson_clk_data meson_a1_pll_info = {
+	.clocks = meson_pll_clocks,
+	.num_clocks = ARRAY_SIZE(meson_pll_clocks),
+};
+
+static const struct udevice_id meson_clk_ids[] = {
+	{
+		.compatible = "amlogic,a1-peripherals-clkc",
+		.data = (ulong)&meson_a1_peripherals_info,
+	},
+	{
+		.compatible = "amlogic,a1-pll-clkc",
+		.data = (ulong)&meson_a1_pll_info,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(meson_clk) = {
+	.name		= "meson-clk-a1",
+	.id		= UCLASS_CLK,
+	.of_match	= meson_clk_ids,
+	.priv_auto	= sizeof(struct meson_clk),
+	.ops		= &meson_clk_ops,
+	.probe		= meson_clk_probe,
+};
+
+static const char *meson_clk_get_name(struct clk *clk, int id)
+{
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+
+	return IS_ERR(info) ? "unknown" : info->name;
+}
+
+static int meson_clk_dump(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+	struct meson_clk *priv;
+	unsigned long rate;
+	char *state, frequency[80];
+	int parent;
+
+	priv = dev_get_priv(clk->dev);
+
+	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	if (IS_ERR(info) || !info->name)
+		return -EINVAL;
+
+	rate = clk_get_rate(clk);
+	if (IS_ERR_VALUE(rate))
+		sprintf(frequency, "unknown");
+	else
+		sprintf(frequency, "%lu", rate);
+
+	if (info->type == MESON_CLK_GATE)
+		state = GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
+	else
+		state = "N/A";
+
+	parent = meson_clk_get_parent(clk, clk->id);
+	printf("%15s%20s%20s%15s\n",
+	       info->name,
+	       frequency,
+	       meson_clk_get_name(clk, parent),
+	       state);
+
+	return 0;
+}
+
+static int meson_clk_dump_dev(struct udevice *dev)
+{
+	int i;
+	struct meson_clk_data *data;
+	const char *sep = "--------------------";
+
+	printf("%s:\n", dev->name);
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+
+	data = (struct meson_clk_data *)dev_get_driver_data(dev);
+	for (i = 0; i < data->num_clocks; i++) {
+		meson_clk_dump(&(struct clk){
+			.dev = dev,
+			.id = i
+		});
+	}
+
+	return 0;
+}
+
+int soc_clk_dump(void)
+{
+	struct udevice *dev;
+	int i = 0;
+
+	while (!uclass_get_device(UCLASS_CLK, i++, &dev)) {
+		if (dev->driver == DM_DRIVER_GET(meson_clk)) {
+			meson_clk_dump_dev(dev);
+			printf("\n");
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1

