Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE57D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D12883AB8;
	Sun, 18 Jan 2026 14:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SWSkk8Wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11224836AC; Sat, 17 Jan 2026 22:07:17 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6C882BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 22:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f3fba4a11so3046945b3a.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768684031; x=1769288831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkYPpuM3qbPTzexn9reufaENEIl+B6CZ2hQRw3eimgw=;
 b=SWSkk8Wk6VI6AEksaTvw8YxuHCE2NOdSdzKN5HoZ51gDbOqsZnl9VHWDayqGjr3Y+D
 t+cwnd2PFvKUlsbRqGezb8Sb6J/AB8YY5nFnLdsiiZc4ogq/q+TgpQ6Bqao/QOSG36PN
 FhqYPCfyOw0Cpb9hf9/aBuc9JGLY29BX76yArrb61PMAuUDozcDJ9ZBOkU4LMp91fn3j
 zQex3z/jIy68/6eJRgwyB41H5S6SEKtZv84UJoDcEh5OxMFMAqw+4Agk2VhgFewb05e4
 9L9i/iM6ic3KiYxAxX2vgLAFjGaSY3YVvp2R3rdnIO8qFsW8nK0XlmqS86nGwTjflJ7q
 ZmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768684031; x=1769288831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SkYPpuM3qbPTzexn9reufaENEIl+B6CZ2hQRw3eimgw=;
 b=knAr/aBPdKAGnDATOonvtopflO49AL55qZKDhJK9ULQpxJRNpv16BiGBFAtfLr5qgb
 99I2kSv80GkSRLCy+x8H7hAfR33TJEO3J3ypu6Gmd2j85oUoBYPgI4FsN22iEGksx0wI
 Z5yu1149rXKW2JPuEO24gCGSFDkj4U+NVWzVYaUSSdF5GHZVEqLMhgXc5eOZ3xJWPuWe
 5B5GF+pRHp+3eKJ+QLHXzKIFMK7GLuvZhPif/86RxfJtAjgFzxWwU+SOzkaYY4wX1aIu
 4z9i6IRU0pl8/raX8HMduoTBq1DvEhcL+OoeFDpRYubAUpfwIzTjtBL7UrfWJqy7dTq8
 ghFw==
X-Gm-Message-State: AOJu0YzetuNgy15UGJAqE3kXT9NT1PdLc7MTwPLhS4GxiGfEqJzsQBur
 13/MC7dQH3HLABOb8P9BVtgPz9SuLks9EamjyYAqi7dPPOye30RqKZYDJUpBag==
X-Gm-Gg: AY/fxX6WF2Xye9oTTUjN+a14KWXTTxBhxQBWWDEicTM9TbcmA2lNLaTZAZXs1zfEtfw
 d9id+gt9Q/hRjaQpvcgBoNTHXAAtdDCgwnFXv800zKzzRwQh/+etNmrVCn7A1gjTTtV4CUFrq1W
 vu1uUNAML1s7rg87L/Dzy3t6mBShdfL3PlvI+e/x2JbIAogJdxxXg5ehY5iYD37QSzwu9Rm5DzL
 vjqhX8ZHc7DhzVzAkaCd7PwzrM6Rr8hpze/265OIrbWXFMP0EqOMdZwsNSe0hzz60oev8Bloago
 +g+dIX/ad42OFAtHDwYKiAthYwQo0isWWkdzzlG7DXAvZM4wqJVLGfH5gJKMRkKMqEg0LuuthZw
 +3nebQGFXqAWUWbS9F+SG0cr0mvfR1js7W3qO+0kwC1jNaw4oYOjTTqKSRl7VH87L0hu2AhZQB7
 +7ZIkqBquu2EkTjEM95LxZia323xZ6f3LvuBBabOZp97TMS7JdA2z8oY1e/RfjAVcyNMreSgM=
X-Received: by 2002:ac8:5702:0:b0:501:1466:8419 with SMTP id
 d75a77b69052e-502a168eb01mr98108381cf.29.1768676827859; 
 Sat, 17 Jan 2026 11:07:07 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:07:07 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Junhui Liu <junhui.liu@pigmoral.tech>,
 Raymond Mao <raymond.mao@riststar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Raymond Mao <raymond.mao@riscstar.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 07/17] clk: spacemit: Add support for K1 SoC
Date: Sat, 17 Jan 2026 14:01:41 -0500
Message-Id: <20260117190231.977686-8-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Junhui Liu <junhui.liu@pigmoral.tech>

Add clock support for Spacemit K1 SoC.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Raymond Mao <raymond.mao@riststar.com>
---
 drivers/clk/Kconfig               |    5 +-
 drivers/clk/Makefile              |    1 +
 drivers/clk/spacemit/Kconfig      |   31 +
 drivers/clk/spacemit/Makefile     |    7 +
 drivers/clk/spacemit/clk-k1.c     | 1793 +++++++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h |   79 ++
 drivers/clk/spacemit/clk_ddn.c    |   93 ++
 drivers/clk/spacemit/clk_ddn.h    |   53 +
 drivers/clk/spacemit/clk_mix.c    |  403 +++++++
 drivers/clk/spacemit/clk_mix.h    |  224 ++++
 drivers/clk/spacemit/clk_pll.c    |  157 +++
 drivers/clk/spacemit/clk_pll.h    |   81 ++
 include/soc/spacemit/k1-syscon.h  |  149 +++
 13 files changed, 3074 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/clk-k1.c
 create mode 100644 drivers/clk/spacemit/clk_common.h
 create mode 100644 drivers/clk/spacemit/clk_ddn.c
 create mode 100644 drivers/clk/spacemit/clk_ddn.h
 create mode 100644 drivers/clk/spacemit/clk_mix.c
 create mode 100644 drivers/clk/spacemit/clk_mix.h
 create mode 100644 drivers/clk/spacemit/clk_pll.c
 create mode 100644 drivers/clk/spacemit/clk_pll.h
 create mode 100644 include/soc/spacemit/k1-syscon.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85cc472b4cb..85da15bcaad 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -275,11 +275,12 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
-source "drivers/clk/sophgo/Kconfig"
-source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sifive/Kconfig"
+source "drivers/clk/sophgo/Kconfig"
+source "drivers/clk/spacemit/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/stm32/Kconfig"
+source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/thead/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..dabbb3af4b6 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
+obj-$(CONFIG_CLK_SPACEMIT) += spacemit/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
 obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
new file mode 100644
index 00000000000..fd96ec8fd2e
--- /dev/null
+++ b/drivers/clk/spacemit/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2025, Junhui Liu <junhui.liu@pigmoral.tech>
+
+config CLK_SPACEMIT
+	bool "Clock support for SpacemiT SoCs"
+	depends on CLK
+	select REGMAP
+	help
+	  This enables support clock driver for Spacemit SoC
+	  family.
+
+if CLK_SPACEMIT
+
+config CLK_SPACEMIT_K1
+	bool "SpacemiT K1 clock support"
+	select CLK_CCF
+	default SPACEMIT_K1
+	help
+	  This enables support clock driver for Spacemit K1 SoC.
+	  It's based on Common Clock Framework.
+
+config SPL_CLK_SPACEMIT_K1
+	bool "Enable Spacemit K1 SoC clock support in SPL"
+	select SPL_CLK_CCF
+	default SPACEMIT_K1
+	help
+	  It allows to use the Spacemit K1 SoC clock driver in
+	  SPL.
+
+endif
diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
new file mode 100644
index 00000000000..824e94d1f74
--- /dev/null
+++ b/drivers/clk/spacemit/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+
+obj-$(CONFIG_CLK_SPACEMIT) += clk_ddn.o clk_mix.o clk_pll.o
+
+obj-$(CONFIG_CLK_SPACEMIT_K1)	+= clk-k1.o
diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
new file mode 100644
index 00000000000..9401703b125
--- /dev/null
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -0,0 +1,1793 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <regmap.h>
+#include <linux/clk-provider.h>
+#include <soc/spacemit/k1-syscon.h>
+
+#include "clk_common.h"
+#include "clk_ddn.h"
+#include "clk_mix.h"
+#include "clk_pll.h"
+
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+#define K1_PLL_ID		100
+#define K1_MPMU_ID		200
+#define K1_APBC_ID		300
+#define K1_APMU_ID		400
+
+struct spacemit_ccu_data {
+	struct clk **clks;
+	size_t num;
+	unsigned long offset;
+};
+
+/* APBS clocks start, APBS region contains and only contains all PLL clocks */
+
+/*
+ * PLL{1,2} must run at fixed frequencies to provide clocks in correct rates for
+ * peripherals.
+ */
+static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
+	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
+};
+
+static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
+};
+
+static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLL_RATE(1600000000UL, 0x0050cd61, 0x43eaaaab),
+	CCU_PLL_RATE(1800000000UL, 0x0050cd61, 0x4b000000),
+	CCU_PLL_RATE(2000000000UL, 0x0050dd62, 0x2aeaaaab),
+	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
+	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
+	CCU_PLL_RATE(3200000000UL, 0x0050dd67, 0x43eaaaab),
+};
+
+CCU_PLL_DEFINE(CLK_PLL1, pll1, pll1, "clock-24m", pll1_rate_tbl,
+	       APBS_PLL1_SWCR1, APBS_PLL1_SWCR3, MPMU_POSR, POSR_PLL1_LOCK,
+	       CLK_SET_RATE_GATE);
+CCU_PLL_DEFINE(CLK_PLL2, pll2, pll2, "clock-24m", pll2_rate_tbl,
+	       APBS_PLL2_SWCR1, APBS_PLL2_SWCR3, MPMU_POSR, POSR_PLL2_LOCK,
+	       CLK_SET_RATE_GATE);
+CCU_PLL_DEFINE(CLK_PLL3, pll3, pll3, "clock-24m", pll3_rate_tbl,
+	       APBS_PLL3_SWCR1, APBS_PLL3_SWCR3, MPMU_POSR, POSR_PLL3_LOCK,
+	       CLK_SET_RATE_GATE);
+
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D2, pll1_d2, pll1_d2, "pll1", APBS_PLL1_SWCR2,
+		       BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D3, pll1_d3, pll1_d3, "pll1", APBS_PLL1_SWCR2,
+		       BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D4, pll1_d4, pll1_d4, "pll1", APBS_PLL1_SWCR2,
+		       BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D5, pll1_d5, pll1_d5, "pll1", APBS_PLL1_SWCR2,
+		       BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D6, pll1_d6, pll1_d6, "pll1", APBS_PLL1_SWCR2,
+		       BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D7, pll1_d7, pll1_d7, "pll1", APBS_PLL1_SWCR2,
+		       BIT(6), 7, 1);
+CCU_FACTOR_GATE_FLAGS_DEFINE(CLK_PLL1_D8, pll1_d8, pll1_d8, "pll1",
+			     APBS_PLL1_SWCR2, BIT(7), 8, 1, CLK_IS_CRITICAL);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D11, pll1_d11_223p4, pll1_d11_223p4, "pll1",
+		       APBS_PLL1_SWCR2, BIT(15), 11, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D13, pll1_d13_189, pll1_d13_189, "pll1",
+		       APBS_PLL1_SWCR2, BIT(16), 13, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D23, pll1_d23_106p8, pll1_d23_106p8, "pll1",
+		       APBS_PLL1_SWCR2, BIT(20), 23, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D64, pll1_d64_38p4, pll1_d64_38p4, "pll1",
+		       APBS_PLL1_SWCR2, BIT(0), 64, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D10_AUD, pll1_aud_245p7, pll1_aud_245p7, "pll1",
+		       APBS_PLL1_SWCR2, BIT(10), 10, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_D100_AUD, pll1_aud_24p5, pll1_aud_24p5, "pll1",
+		       APBS_PLL1_SWCR2, BIT(11), 100, 1);
+
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D1, pll2_d1, pll2_d1, "pll2", APBS_PLL2_SWCR2,
+		       BIT(0), 1, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D2, pll2_d2, pll2_d2, "pll2", APBS_PLL2_SWCR2,
+		       BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D3, pll2_d3, pll2_d3, "pll2", APBS_PLL2_SWCR2,
+		       BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D4, pll2_d4, pll2_d4, "pll2", APBS_PLL2_SWCR2,
+		       BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D5, pll2_d5, pll2_d5, "pll2", APBS_PLL2_SWCR2,
+		       BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D6, pll2_d6, pll2_d6, "pll2", APBS_PLL2_SWCR2,
+		       BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D7, pll2_d7, pll2_d7, "pll2", APBS_PLL2_SWCR2,
+		       BIT(6), 7, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL2_D8, pll2_d8, pll2_d8, "pll2", APBS_PLL2_SWCR2,
+		       BIT(7), 8, 1);
+
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D1, pll3_d1, pll3_d1, "pll3", APBS_PLL3_SWCR2,
+		       BIT(0), 1, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D2, pll3_d2, pll3_d2, "pll3", APBS_PLL3_SWCR2,
+		       BIT(1), 2, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D3, pll3_d3, pll3_d3, "pll3", APBS_PLL3_SWCR2,
+		       BIT(2), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D4, pll3_d4, pll3_d4, "pll3", APBS_PLL3_SWCR2,
+		       BIT(3), 4, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D5, pll3_d5, pll3_d5, "pll3", APBS_PLL3_SWCR2,
+		       BIT(4), 5, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D6, pll3_d6, pll3_d6, "pll3", APBS_PLL3_SWCR2,
+		       BIT(5), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D7, pll3_d7, pll3_d7, "pll3", APBS_PLL3_SWCR2,
+		       BIT(6), 7, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL3_D8, pll3_d8, pll3_d8, "pll3", APBS_PLL3_SWCR2,
+		       BIT(7), 8, 1);
+
+CCU_FACTOR_DEFINE(CLK_PLL3_20, pll3_20, pll3_20, "pll3_d8", 20, 1);
+CCU_FACTOR_DEFINE(CLK_PLL3_40, pll3_40, pll3_40, "pll3_d8", 10, 1);
+CCU_FACTOR_DEFINE(CLK_PLL3_80, pll3_80, pll3_80, "pll3_d8", 5, 1);
+/* APBS clocks end */
+
+/* MPMU clocks start */
+CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
+		MPMU_ACGR, BIT(13), 0);
+
+CCU_FACTOR_DEFINE(CLK_PLL1_76P8, pll1_d32_76p8, pll1_d32_76p8, "pll1_d8_307p2",
+		  4, 1);
+
+CCU_FACTOR_DEFINE(CLK_PLL1_61P44, pll1_d40_61p44, pll1_d40_61p44,
+		  "pll1_d8_307p2", 5, 1);
+
+CCU_FACTOR_DEFINE(CLK_PLL1_153P6, pll1_d16_153p6, pll1_d16_153p6,
+		  "pll1_d8", 2, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_102P4, pll1_d24_102p4, pll1_d24_102p4,
+		       "pll1_d8", MPMU_ACGR, BIT(12), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_51P2, pll1_d48_51p2, pll1_d48_51p2,
+		       "pll1_d8", MPMU_ACGR, BIT(7), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_51P2_AP, pll1_d48_51p2_ap, pll1_d48_51p2_ap,
+		       "pll1_d8", MPMU_ACGR, BIT(11), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_57P6, pll1_m3d128_57p6, pll1_m3d128_57p6,
+		       "pll1_d8", MPMU_ACGR, BIT(8), 16, 3);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_25P6, pll1_d96_25p6, pll1_d96_25p6,
+		       "pll1_d8", MPMU_ACGR, BIT(4), 12, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_12P8, pll1_d192_12p8, pll1_d192_12p8,
+		       "pll1_d8", MPMU_ACGR, BIT(3), 24, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_12P8_WDT, pll1_d192_12p8_wdt, pll1_d192_12p8_wdt,
+		       "pll1_d8", MPMU_ACGR, BIT(19), 24, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_6P4, pll1_d384_6p4, pll1_d384_6p4,
+		       "pll1_d8", MPMU_ACGR, BIT(2), 48, 1);
+
+CCU_FACTOR_DEFINE(CLK_PLL1_3P2, pll1_d768_3p2, pll1_d768_3p2,
+		  "pll1_d384_6p4", 2, 1);
+CCU_FACTOR_DEFINE(CLK_PLL1_1P6, pll1_d1536_1p6, pll1_d1536_1p6,
+		  "pll1_d384_6p4", 4, 1);
+CCU_FACTOR_DEFINE(CLK_PLL1_0P8, pll1_d3072_0p8, pll1_d3072_0p8,
+		  "pll1_d384_6p4", 8, 1);
+
+CCU_GATE_DEFINE(CLK_PLL1_409P6, pll1_d6_409p6, pll1_d6_409p6, "pll1_d6",
+		MPMU_ACGR, BIT(0), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_204P8, pll1_d12_204p8, pll1_d12_204p8,
+		       "pll1_d6", MPMU_ACGR, BIT(5), 2, 1);
+
+CCU_GATE_DEFINE(CLK_PLL1_491, pll1_d5_491p52, pll1_d5_491p52, "pll1_d5",
+		MPMU_ACGR, BIT(21), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_245P76, pll1_d10_245p76, pll1_d10_245p76,
+		       "pll1_d5", MPMU_ACGR, BIT(18), 2, 1);
+
+CCU_GATE_DEFINE(CLK_PLL1_614, pll1_d4_614p4, pll1_d4_614p4, "pll1_d4",
+		MPMU_ACGR, BIT(15), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_47P26, pll1_d52_47p26, pll1_d52_47p26,
+		       "pll1_d4", MPMU_ACGR, BIT(10), 13, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_31P5, pll1_d78_31p5, pll1_d78_31p5,
+		       "pll1_d4", MPMU_ACGR, BIT(6), 39, 2);
+
+CCU_GATE_DEFINE(CLK_PLL1_819, pll1_d3_819p2, pll1_d3_819p2, "pll1_d3",
+		MPMU_ACGR, BIT(14), 0);
+
+CCU_GATE_DEFINE(CLK_PLL1_1228, pll1_d2_1228p8, pll1_d2_1228p8, "pll1_d2",
+		MPMU_ACGR, BIT(16), 0);
+
+CCU_GATE_DEFINE(CLK_SLOW_UART, slow_uart, slow_uart, "clock-32k", MPMU_ACGR,
+		BIT(1), CLK_IGNORE_UNUSED);
+CCU_DDN_DEFINE(CLK_SLOW_UART1, slow_uart1_14p74, slow_uart1_14p74,
+	       "pll1_d16_153p6", MPMU_SUCCR,
+	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
+CCU_DDN_DEFINE(CLK_SLOW_UART2, slow_uart2_48, slow_uart2_48,
+	       "pll1_d4_614p4", MPMU_SUCCR_1,
+	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_GATE_DEFINE(CLK_WDT, wdt_clk, wdt_clk, "pll1_d96_25p6", MPMU_WDTPCR,
+		BIT(1), 0);
+
+CCU_FACTOR_DEFINE(CLK_I2S_153P6, i2s_153p6, i2s_153p6, "pll1_d8_307p2", 2, 1);
+
+static const char * const i2s_153p6_base_parents[] = {
+	"i2s_153p6",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DEFINE(CLK_I2S_153P6_BASE, i2s_153p6_base, i2s_153p6_base,
+	       i2s_153p6_base_parents, ARRAY_SIZE(i2s_153p6_base_parents),
+	       MPMU_FCCR, 29, 1, 0);
+
+static const char * const i2s_sysclk_src_parents[] = {
+	"pll1_d96_25p6",
+	"i2s_153p6_base"
+};
+
+CCU_MUX_GATE_DEFINE(CLK_I2S_SYSCLK_SRC, i2s_sysclk_src, i2s_sysclk_src,
+		    i2s_sysclk_src_parents, ARRAY_SIZE(i2s_sysclk_src_parents),
+		    MPMU_ISCCR, 30, 1, BIT(31), 0);
+
+CCU_DDN_DEFINE(CLK_I2S_SYSCLK, i2s_sysclk, i2s_sysclk, "i2s_sysclk_src",
+	       MPMU_ISCCR, CCU_DDN_MASK(0, 15), 0, CCU_DDN_MASK(15, 12),
+	       15, 1, 0);
+
+CCU_FACTOR_DEFINE(CLK_I2S_BCLK_FACTOR, i2s_bclk_factor, i2s_bclk_factor,
+		  "i2s_sysclk", 2, 1);
+/*
+ * Divider of i2s_bclk always implies a 1/2 factor, which is
+ * described by i2s_bclk_factor.
+ */
+CCU_DIV_GATE_DEFINE(CLK_I2S_BCLK, i2s_bclk, i2s_bclk, "i2s_bclk_factor",
+		    MPMU_ISCCR, 27, 2, BIT(29), 0);
+
+static const char * const apb_parents[] = {
+	"pll1_d96_25p6",
+	"pll1_d48_51p2",
+	"pll1_d96_25p6",
+	"pll1_d24_102p4",
+};
+
+CCU_MUX_DEFINE(CLK_APB, apb_clk, apb_clk, apb_parents, ARRAY_SIZE(apb_parents),
+	       MPMU_APBCSCR, 0, 2, 0);
+
+CCU_GATE_DEFINE(CLK_WDT_BUS, wdt_bus_clk, wdt_bus_clk, "apb_clk", MPMU_WDTPCR,
+		BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_RIPC, ripc_clk, ripc_clk, "apb_clk", MPMU_RIPCCR, 0x1, 0);
+#endif
+/* MPMU clocks end */
+
+/* APBC clocks start */
+static const char * const uart_clk_parents[] = {
+	"pll1_m3d128_57p6",
+	"slow_uart1_14p74",
+	"slow_uart2_48",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_UART0, uart0_clk, uart0_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART1_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+
+static const char * const twsi_parents[] = {
+	"pll1_d78_31p5",
+	"pll1_d48_51p2",
+	"pll1_d40_61p44",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+/*
+ * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
+ * Combine functional and bus bits together as a gate to avoid sharing the
+ * write-only register between different clock hardwares.
+ */
+CCU_GATE_DEFINE(CLK_TWSI8, twsi8_clk, twsi8_clk, "pll1_d78_31p5",
+		APBC_TWSI8_CLK_RST, BIT(1) | BIT(0), 0);
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+CCU_MUX_GATE_DEFINE(CLK_UART2, uart2_clk, uart2_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART2_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART3, uart3_clk, uart3_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART3_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART4, uart4_clk, uart4_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART4_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART5, uart5_clk, uart5_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART5_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART6, uart6_clk, uart6_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART6_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART7, uart7_clk, uart7_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART7_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART8, uart8_clk, uart8_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART8_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_UART9, uart9_clk, uart9_clk, uart_clk_parents,
+		    ARRAY_SIZE(uart_clk_parents), APBC_UART9_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_GPIO, gpio_clk, gpio_clk, "clock-24m", APBC_GPIO_CLK_RST,
+		BIT(1) | BIT(0), 0);
+
+static const char * const pwm_parents[] = {
+	"pll1_d192_12p8",
+	"clock-32k",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_PWM0, pwm0_clk, pwm0_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM0_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM1, pwm1_clk, pwm1_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM1_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM2, pwm2_clk, pwm2_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM2_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM3, pwm3_clk, pwm3_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM3_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM4, pwm4_clk, pwm4_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM4_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM5, pwm5_clk, pwm5_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM5_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM6, pwm6_clk, pwm6_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM6_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM7, pwm7_clk, pwm7_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM7_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM8, pwm8_clk, pwm8_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM8_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM9, pwm9_clk, pwm9_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM9_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM10, pwm10_clk, pwm10_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM10_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM11, pwm11_clk, pwm11_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM11_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM12, pwm12_clk, pwm12_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM12_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM13, pwm13_clk, pwm13_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM13_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM14, pwm14_clk, pwm14_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM14_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM15, pwm15_clk, pwm15_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM15_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM16, pwm16_clk, pwm16_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM16_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM17, pwm17_clk, pwm17_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM17_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM18, pwm18_clk, pwm18_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM18_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_PWM19, pwm19_clk, pwm19_clk, pwm_parents,
+		    ARRAY_SIZE(pwm_parents), APBC_PWM19_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+
+static const char * const ssp_parents[] = {
+	"pll1_d384_6p4",
+	"pll1_d192_12p8",
+	"pll1_d96_25p6",
+	"pll1_d48_51p2",
+	"pll1_d768_3p2",
+	"pll1_d1536_1p6",
+	"pll1_d3072_0p8",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_SSP3, ssp3_clk, ssp3_clk, ssp_parents,
+		    ARRAY_SIZE(ssp_parents), APBC_SSP3_CLK_RST, 4, 3,
+		    BIT(1), 0);
+
+CCU_GATE_DEFINE(CLK_RTC, rtc_clk, rtc_clk, "clock-32k", APBC_RTC_CLK_RST,
+		BIT(7) | BIT(1) | BIT(0), 0);
+
+CCU_MUX_GATE_DEFINE(CLK_TWSI0, twsi0_clk, twsi0_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI0_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TWSI1, twsi1_clk, twsi1_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI1_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TWSI4, twsi4_clk, twsi4_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI4_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TWSI5, twsi5_clk, twsi5_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI5_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TWSI6, twsi6_clk, twsi6_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI6_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TWSI7, twsi7_clk, twsi7_clk, twsi_parents,
+		    ARRAY_SIZE(twsi_parents), APBC_TWSI7_CLK_RST,
+		    4, 3, BIT(1) | BIT(0), 0);
+
+static const char * const timer_parents[] = {
+	"pll1_d192_12p8",
+	"clock-32k",
+	"pll1_d384_6p4",
+	"clock-3m",
+	"clock-1m",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_TIMERS1, timers1_clk, timers1_clk, timer_parents,
+		    ARRAY_SIZE(timer_parents), APBC_TIMERS1_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+CCU_MUX_GATE_DEFINE(CLK_TIMERS2, timers2_clk, timers2_clk, timer_parents,
+		    ARRAY_SIZE(timer_parents), APBC_TIMERS2_CLK_RST, 4, 3,
+		    BIT(1) | BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_AIB, aib_clk, aib_clk, "clock-24m", APBC_AIB_CLK_RST,
+		BIT(1) | BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_ONEWIRE, onewire_clk, onewire_clk, "clock-24m",
+		APBC_ONEWIRE_CLK_RST, BIT(1) | BIT(0), 0);
+
+/*
+ * When i2s_bclk is selected as the parent clock of sspa,
+ * the hardware requires bit3 to be set
+ */
+CCU_GATE_DEFINE(CLK_SSPA0_I2S_BCLK, sspa0_i2s_bclk, sspa0_i2s_bclk, "i2s_bclk",
+		APBC_SSPA0_CLK_RST, BIT(3), 0);
+CCU_GATE_DEFINE(CLK_SSPA1_I2S_BCLK, sspa1_i2s_bclk, sspa1_i2s_bclk, "i2s_bclk",
+		APBC_SSPA1_CLK_RST, BIT(3), 0);
+
+static const char * const sspa0_parents[] = {
+	"pll1_d384_6p4",
+	"pll1_d192_12p8",
+	"pll1_d96_25p6",
+	"pll1_d48_51p2",
+	"pll1_d768_3p2",
+	"pll1_d1536_1p6",
+	"pll1_d3072_0p8",
+	"sspa0_i2s_bclk",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_SSPA0, sspa0_clk, sspa0_clk, sspa0_parents,
+		    ARRAY_SIZE(sspa0_parents), APBC_SSPA0_CLK_RST, 4, 3,
+		    BIT(1), 0);
+
+static const char * const sspa1_parents[] = {
+	"pll1_d384_6p4",
+	"pll1_d192_12p8",
+	"pll1_d96_25p6",
+	"pll1_d48_51p2",
+	"pll1_d768_3p2",
+	"pll1_d1536_1p6",
+	"pll1_d3072_0p8",
+	"sspa1_i2s_bclk",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_SSPA1, sspa1_clk, sspa1_clk, sspa1_parents,
+		    ARRAY_SIZE(sspa1_parents), APBC_SSPA1_CLK_RST, 4, 3,
+		    BIT(1), 0);
+
+CCU_GATE_DEFINE(CLK_DRO, dro_clk, dro_clk, "apb_clk", APBC_DRO_CLK_RST,
+		BIT(1) | BIT(0), 0);
+CCU_GATE_DEFINE(CLK_IR, ir_clk, ir_clk, "apb_clk", APBC_IR_CLK_RST,
+		BIT(1) | BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TSEN, tsen_clk, tsen_clk, "apb_clk", APBC_TSEN_CLK_RST,
+		BIT(1) | BIT(0), 0);
+CCU_GATE_DEFINE(CLK_IPC_AP2AUD, ipc_ap2aud_clk, ipc_ap2aud_clk, "apb_clk",
+		APBC_IPC_AP2AUD_CLK_RST, BIT(1) | BIT(0), 0);
+
+static const char * const can_parents[] = {
+	"pll3_20",
+	"pll3_40",
+	"pll3_80",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_CAN0, can0_clk, can0_clk, can_parents,
+		    ARRAY_SIZE(can_parents), APBC_CAN0_CLK_RST, 4, 3,
+		    BIT(1), 0);
+CCU_GATE_DEFINE(CLK_CAN0_BUS, can0_bus_clk, can0_bus_clk, "clock-24m",
+		APBC_CAN0_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_UART0_BUS, uart0_bus_clk, uart0_bus_clk, "apb_clk",
+		APBC_UART1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART2_BUS, uart2_bus_clk, uart2_bus_clk, "apb_clk",
+		APBC_UART2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART3_BUS, uart3_bus_clk, uart3_bus_clk, "apb_clk",
+		APBC_UART3_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART4_BUS, uart4_bus_clk, uart4_bus_clk, "apb_clk",
+		APBC_UART4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART5_BUS, uart5_bus_clk, uart5_bus_clk, "apb_clk",
+		APBC_UART5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART6_BUS, uart6_bus_clk, uart6_bus_clk, "apb_clk",
+		APBC_UART6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART7_BUS, uart7_bus_clk, uart7_bus_clk, "apb_clk",
+		APBC_UART7_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART8_BUS, uart8_bus_clk, uart8_bus_clk, "apb_clk",
+		APBC_UART8_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_UART9_BUS, uart9_bus_clk, uart9_bus_clk, "apb_clk",
+		APBC_UART9_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
+		APBC_GPIO_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_PWM0_BUS, pwm0_bus_clk, pwm0_bus_clk, "apb_clk",
+		APBC_PWM0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM1_BUS, pwm1_bus_clk, pwm1_bus_clk, "apb_clk",
+		APBC_PWM1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM2_BUS, pwm2_bus_clk, pwm2_bus_clk, "apb_clk",
+		APBC_PWM2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM3_BUS, pwm3_bus_clk, pwm3_bus_clk, "apb_clk",
+		APBC_PWM3_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM4_BUS, pwm4_bus_clk, pwm4_bus_clk, "apb_clk",
+		APBC_PWM4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM5_BUS, pwm5_bus_clk, pwm5_bus_clk, "apb_clk",
+		APBC_PWM5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM6_BUS, pwm6_bus_clk, pwm6_bus_clk, "apb_clk",
+		APBC_PWM6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM7_BUS, pwm7_bus_clk, pwm7_bus_clk, "apb_clk",
+		APBC_PWM7_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM8_BUS, pwm8_bus_clk, pwm8_bus_clk, "apb_clk",
+		APBC_PWM8_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM9_BUS, pwm9_bus_clk, pwm9_bus_clk, "apb_clk",
+		APBC_PWM9_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM10_BUS, pwm10_bus_clk, pwm10_bus_clk, "apb_clk",
+		APBC_PWM10_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM11_BUS, pwm11_bus_clk, pwm11_bus_clk, "apb_clk",
+		APBC_PWM11_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM12_BUS, pwm12_bus_clk, pwm12_bus_clk, "apb_clk",
+		APBC_PWM12_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM13_BUS, pwm13_bus_clk, pwm13_bus_clk, "apb_clk",
+		APBC_PWM13_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM14_BUS, pwm14_bus_clk, pwm14_bus_clk, "apb_clk",
+		APBC_PWM14_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM15_BUS, pwm15_bus_clk, pwm15_bus_clk, "apb_clk",
+		APBC_PWM15_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM16_BUS, pwm16_bus_clk, pwm16_bus_clk, "apb_clk",
+		APBC_PWM16_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM17_BUS, pwm17_bus_clk, pwm17_bus_clk, "apb_clk",
+		APBC_PWM17_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM18_BUS, pwm18_bus_clk, pwm18_bus_clk, "apb_clk",
+		APBC_PWM18_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_PWM19_BUS, pwm19_bus_clk, pwm19_bus_clk, "apb_clk",
+		APBC_PWM19_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_SSP3_BUS, ssp3_bus_clk, ssp3_bus_clk, "apb_clk",
+		APBC_SSP3_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_RTC_BUS, rtc_bus_clk, rtc_bus_clk, "apb_clk",
+		APBC_RTC_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_TWSI0_BUS, twsi0_bus_clk, twsi0_bus_clk, "apb_clk",
+		APBC_TWSI0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI1_BUS, twsi1_bus_clk, twsi1_bus_clk, "apb_clk",
+		APBC_TWSI1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI2_BUS, twsi2_bus_clk, twsi2_bus_clk, "apb_clk",
+		APBC_TWSI2_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI4_BUS, twsi4_bus_clk, twsi4_bus_clk, "apb_clk",
+		APBC_TWSI4_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI5_BUS, twsi5_bus_clk, twsi5_bus_clk, "apb_clk",
+		APBC_TWSI5_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI6_BUS, twsi6_bus_clk, twsi6_bus_clk, "apb_clk",
+		APBC_TWSI6_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI7_BUS, twsi7_bus_clk, twsi7_bus_clk, "apb_clk",
+		APBC_TWSI7_CLK_RST, BIT(0), 0);
+CCU_FACTOR_DEFINE(CLK_TWSI8_BUS, twsi8_bus_clk, twsi8_bus_clk, "apb_clk", 1, 1);
+
+CCU_GATE_DEFINE(CLK_TIMERS1_BUS, timers1_bus_clk, timers1_bus_clk, "apb_clk",
+		APBC_TIMERS1_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TIMERS2_BUS, timers2_bus_clk, timers2_bus_clk, "apb_clk",
+		APBC_TIMERS2_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
+		APBC_AIB_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_ONEWIRE_BUS, onewire_bus_clk, onewire_bus_clk, "apb_clk",
+		APBC_ONEWIRE_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_SSPA0_BUS, sspa0_bus_clk, sspa0_bus_clk, "apb_clk",
+		APBC_SSPA0_CLK_RST, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_SSPA1_BUS, sspa1_bus_clk, sspa1_bus_clk, "apb_clk",
+		APBC_SSPA1_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_TSEN_BUS, tsen_bus_clk, tsen_bus_clk, "apb_clk",
+		APBC_TSEN_CLK_RST, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_IPC_AP2AUD_BUS, ipc_ap2aud_bus_clk, ipc_ap2aud_bus_clk,
+		"apb_clk", APBC_IPC_AP2AUD_CLK_RST, BIT(0), 0);
+#endif
+/* APBC clocks end */
+
+/* APMU clocks start */
+static const char * const pmua_aclk_parents[] = {
+	"pll1_d10_245p76",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DIV_FC_DEFINE(CLK_PMUA_ACLK, pmua_aclk, pmua_aclk, pmua_aclk_parents,
+		      ARRAY_SIZE(pmua_aclk_parents),
+		      APMU_ACLK_CLK_CTRL, APMU_ACLK_CLK_CTRL, 1, 2, BIT(4),
+		      0, 1, 0);
+
+static const char * const emmc_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d4_614p4",
+	"pll1_d52_47p26",
+	"pll1_d3_819p2",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_EMMC, emmc_clk, emmc_clk, emmc_parents,
+				 ARRAY_SIZE(emmc_parents),
+				 APMU_PMUA_EM_CLK_RES_CTRL,
+				 APMU_PMUA_EM_CLK_RES_CTRL, 8, 3, BIT(11),
+				 6, 2, BIT(4), 0);
+CCU_DIV_GATE_DEFINE(CLK_EMMC_X, emmc_x_clk, emmc_x_clk, "pll1_d2_1228p8",
+		    APMU_PMUA_EM_CLK_RES_CTRL, 12,
+		    3, BIT(15), 0);
+
+CCU_GATE_DEFINE(CLK_EMMC_BUS, emmc_bus_clk, emmc_bus_clk, "pmua_aclk",
+		APMU_PMUA_EM_CLK_RES_CTRL, BIT(3), 0);
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+static const char * const cci550_clk_parents[] = {
+	"pll1_d5_491p52",
+	"pll1_d4_614p4",
+	"pll1_d3_819p2",
+	"pll2_d3",
+};
+
+CCU_MUX_DIV_FC_DEFINE(CLK_CCI550, cci550_clk, cci550_clk, cci550_clk_parents,
+		      ARRAY_SIZE(cci550_clk_parents),
+		      APMU_CCI550_CLK_CTRL, APMU_CCI550_CLK_CTRL, 8, 3,
+		      BIT(12), 0, 2, CLK_IS_CRITICAL);
+
+static const char * const cpu_c0_hi_clk_parents[] = {
+	"pll3_d2",
+	"pll3_d1",
+};
+
+CCU_MUX_DEFINE(CLK_CPU_C0_HI, cpu_c0_hi_clk, cpu_c0_hi_clk,
+	       cpu_c0_hi_clk_parents, ARRAY_SIZE(cpu_c0_hi_clk_parents),
+	       APMU_CPU_C0_CLK_CTRL, 13, 1, 0);
+static const char * const cpu_c0_clk_parents[] = {
+	"pll1_d4_614p4",
+	"pll1_d3_819p2",
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d2_1228p8",
+	"pll3_d3",
+	"pll2_d3",
+	"cpu_c0_hi_clk",
+};
+
+CCU_MUX_FC_DEFINE(CLK_CPU_C0_CORE, cpu_c0_core_clk, cpu_c0_core_clk,
+		  cpu_c0_clk_parents, ARRAY_SIZE(cpu_c0_clk_parents),
+		  APMU_CPU_C0_CLK_CTRL, APMU_CPU_C0_CLK_CTRL,
+		  BIT(12), 0, 3, CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(CLK_CPU_C0_ACE, cpu_c0_ace_clk, cpu_c0_ace_clk,
+	       "cpu_c0_core_clk", APMU_CPU_C0_CLK_CTRL, 6, 3, CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(CLK_CPU_C0_TCM, cpu_c0_tcm_clk, cpu_c0_tcm_clk,
+	       "cpu_c0_core_clk", APMU_CPU_C0_CLK_CTRL, 9, 3, CLK_IS_CRITICAL);
+
+static const char * const cpu_c1_hi_clk_parents[] = {
+	"pll3_d2",
+	"pll3_d1",
+};
+
+CCU_MUX_DEFINE(CLK_CPU_C1_HI, cpu_c1_hi_clk, cpu_c1_hi_clk,
+	       cpu_c1_hi_clk_parents, ARRAY_SIZE(cpu_c1_hi_clk_parents),
+	       APMU_CPU_C1_CLK_CTRL, 13, 1, 0);
+static const char * const cpu_c1_clk_parents[] = {
+	"pll1_d4_614p4",
+	"pll1_d3_819p2",
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d2_1228p8",
+	"pll3_d3",
+	"pll2_d3",
+	"cpu_c1_hi_clk",
+};
+
+CCU_MUX_FC_DEFINE(CLK_CPU_C1_CORE, cpu_c1_core_clk, cpu_c1_core_clk,
+		  cpu_c1_clk_parents, ARRAY_SIZE(cpu_c1_clk_parents),
+		  APMU_CPU_C1_CLK_CTRL, APMU_CPU_C1_CLK_CTRL,
+		  BIT(12), 0, 3, CLK_IS_CRITICAL);
+CCU_DIV_DEFINE(CLK_CPU_C1_ACE, cpu_c1_ace_clk, cpu_c1_ace_clk,
+	       "cpu_c1_core_clk", APMU_CPU_C1_CLK_CTRL, 6, 3, CLK_IS_CRITICAL);
+
+static const char * const jpg_parents[] = {
+	"pll1_d4_614p4",
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d3_819p2",
+	"pll1_d2_1228p8",
+	"pll2_d4",
+	"pll2_d3",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_JPG, jpg_clk, jpg_clk, jpg_parents,
+				 ARRAY_SIZE(jpg_parents),
+				 APMU_JPG_CLK_RES_CTRL,
+				 APMU_JPG_CLK_RES_CTRL,
+				 5, 3, BIT(15), 2, 3, BIT(1), 0);
+
+static const char * const ccic2phy_parents[] = {
+	"pll1_d24_102p4",
+	"pll1_d48_51p2_ap",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_CCIC2PHY, ccic2phy_clk, ccic2phy_clk, ccic2phy_parents,
+		    ARRAY_SIZE(ccic2phy_parents), APMU_CSI_CCIC2_CLK_RES_CTRL,
+		    7, 1, BIT(5), 0);
+
+static const char * const ccic3phy_parents[] = {
+	"pll1_d24_102p4",
+	"pll1_d48_51p2_ap",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_CCIC3PHY, ccic3phy_clk, ccic3phy_clk, ccic3phy_parents,
+		    ARRAY_SIZE(ccic3phy_parents), APMU_CSI_CCIC2_CLK_RES_CTRL,
+		    31, 1, BIT(30), 0);
+
+static const char * const csi_parents[] = {
+	"pll1_d5_491p52",
+	"pll1_d6_409p6",
+	"pll1_d4_614p4",
+	"pll1_d3_819p2",
+	"pll2_d2",
+	"pll2_d3",
+	"pll2_d4",
+	"pll1_d2_1228p8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_CSI, csi_clk, csi_clk, csi_parents,
+				 ARRAY_SIZE(csi_parents),
+				 APMU_CSI_CCIC2_CLK_RES_CTRL,
+				 APMU_CSI_CCIC2_CLK_RES_CTRL, 20, 3, BIT(15),
+				 16, 3, BIT(4), 0);
+
+static const char * const camm_parents[] = {
+	"pll1_d8_307p2",
+	"pll2_d5",
+	"pll1_d6_409p6",
+	"clock-24m",
+};
+
+CCU_MUX_DIV_GATE_DEFINE(CLK_CAMM0, camm0_clk, camm0_clk, camm_parents,
+			ARRAY_SIZE(camm_parents),
+			APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(28), 0);
+CCU_MUX_DIV_GATE_DEFINE(CLK_CAMM1, camm1_clk, camm1_clk, camm_parents,
+			ARRAY_SIZE(camm_parents),
+			APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(6), 0);
+CCU_MUX_DIV_GATE_DEFINE(CLK_CAMM2, camm2_clk, camm2_clk, camm_parents,
+			ARRAY_SIZE(camm_parents),
+			APMU_CSI_CCIC2_CLK_RES_CTRL, 23, 4, 8, 2,
+			BIT(3), 0);
+
+static const char * const isp_cpp_parents[] = {
+	"pll1_d8_307p2",
+	"pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_GATE_DEFINE(CLK_ISP_CPP, isp_cpp_clk, isp_cpp_clk, isp_cpp_parents,
+			ARRAY_SIZE(isp_cpp_parents),
+			APMU_ISP_CLK_RES_CTRL, 24, 2, 26, 1,
+			BIT(28), 0);
+static const char * const isp_bus_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d8_307p2",
+	"pll1_d10_245p76",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_ISP_BUS, isp_bus_clk, isp_bus_clk,
+				 isp_bus_parents, ARRAY_SIZE(isp_cpp_parents),
+				 APMU_ISP_CLK_RES_CTRL,
+				 APMU_ISP_CLK_RES_CTRL, 18, 3, BIT(23),
+				 21, 2, BIT(17), 0);
+static const char * const isp_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d4_614p4",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_ISP, isp_clk, isp_clk, isp_parents,
+				 ARRAY_SIZE(isp_parents),
+				 APMU_ISP_CLK_RES_CTRL,
+				 APMU_ISP_CLK_RES_CTRL,
+				 4, 3, BIT(7), 8, 2, BIT(1), 0);
+
+static const char * const dpumclk_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d4_614p4",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_DPU_MCLK, dpu_mclk, dpu_mclk,
+				 dpumclk_parents, ARRAY_SIZE(dpumclk_parents),
+				 APMU_LCD_CLK_RES_CTRL2, APMU_LCD_CLK_RES_CTRL1,
+				 1, 4, BIT(29), 5, 3, BIT(0), 0);
+
+static const char * const dpuesc_parents[] = {
+	"pll1_d48_51p2_ap",
+	"pll1_d52_47p26",
+	"pll1_d96_25p6",
+	"pll1_d32_76p8",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_DPU_ESC, dpu_esc_clk, dpu_esc_clk, dpuesc_parents,
+		    ARRAY_SIZE(dpuesc_parents), APMU_LCD_CLK_RES_CTRL1, 0, 2,
+		    BIT(2), 0);
+
+static const char * const dpubit_parents[] = {
+	"pll1_d3_819p2",
+	"pll2_d2",
+	"pll2_d3",
+	"pll1_d2_1228p8",
+	"pll2_d4",
+	"pll2_d5",
+	"pll2_d7",
+	"pll2_d8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_DPU_BIT, dpu_bit_clk, dpu_bit_clk,
+				 dpubit_parents, ARRAY_SIZE(dpubit_parents),
+				 APMU_LCD_CLK_RES_CTRL1,
+				 APMU_LCD_CLK_RES_CTRL1, 17, 3, BIT(31),
+				 20, 3, BIT(16), 0);
+
+static const char * const dpupx_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d4_614p4",
+	"pll1_d8_307p2",
+	"pll2_d7",
+	"pll2_d8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_DPU_PXCLK, dpu_pxclk, dpu_pxclk,
+				 dpupx_parents, ARRAY_SIZE(dpupx_parents),
+				 APMU_LCD_CLK_RES_CTRL2, APMU_LCD_CLK_RES_CTRL1,
+				 17, 4, BIT(30), 21, 3, BIT(16), 0);
+
+CCU_GATE_DEFINE(CLK_DPU_HCLK, dpu_hclk, dpu_hclk, "pmua_aclk",
+		APMU_LCD_CLK_RES_CTRL1, BIT(5), 0);
+
+static const char * const dpu_spi_parents[] = {
+	"pll1_d8_307p2",
+	"pll1_d6_409p6",
+	"pll1_d10_245p76",
+	"pll1_d11_223p4",
+	"pll1_d13_189",
+	"pll1_d23_106p8",
+	"pll2_d3",
+	"pll2_d5",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_DPU_SPI, dpu_spi_clk, dpu_spi_clk,
+				 dpu_spi_parents, ARRAY_SIZE(dpu_spi_parents),
+				 APMU_LCD_SPI_CLK_RES_CTRL,
+				 APMU_LCD_SPI_CLK_RES_CTRL, 8, 3,
+				 BIT(7), 12, 3, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_DPU_SPI_HBUS, dpu_spi_hbus_clk, dpu_spi_hbus_clk,
+		"pmua_aclk", APMU_LCD_SPI_CLK_RES_CTRL, BIT(3), 0);
+CCU_GATE_DEFINE(CLK_DPU_SPIBUS, dpu_spi_bus_clk, dpu_spi_bus_clk,
+		"pmua_aclk", APMU_LCD_SPI_CLK_RES_CTRL, BIT(5), 0);
+CCU_GATE_DEFINE(CLK_DPU_SPI_ACLK, dpu_spi_aclk, dpu_spi_aclk,
+		"pmua_aclk", APMU_LCD_SPI_CLK_RES_CTRL, BIT(6), 0);
+
+static const char * const v2d_parents[] = {
+	"pll1_d5_491p52",
+	"pll1_d6_409p6",
+	"pll1_d8_307p2",
+	"pll1_d4_614p4",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_V2D, v2d_clk, v2d_clk, v2d_parents,
+				 ARRAY_SIZE(v2d_parents),
+				 APMU_LCD_CLK_RES_CTRL1,
+				 APMU_LCD_CLK_RES_CTRL1, 9, 3, BIT(28), 12, 2,
+				 BIT(8), 0);
+
+static const char * const ccic_4x_parents[] = {
+	"pll1_d5_491p52",
+	"pll1_d6_409p6",
+	"pll1_d4_614p4",
+	"pll1_d3_819p2",
+	"pll2_d2",
+	"pll2_d3",
+	"pll2_d4",
+	"pll1_d2_1228p8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_CCIC_4X, ccic_4x_clk, ccic_4x_clk,
+				 ccic_4x_parents, ARRAY_SIZE(ccic_4x_parents),
+				 APMU_CCIC_CLK_RES_CTRL,
+				 APMU_CCIC_CLK_RES_CTRL, 18, 3,
+				 BIT(15), 23, 2, BIT(4), 0);
+
+static const char * const ccic1phy_parents[] = {
+	"pll1_d24_102p4",
+	"pll1_d48_51p2_ap",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_CCIC1PHY, ccic1phy_clk, ccic1phy_clk, ccic1phy_parents,
+		    ARRAY_SIZE(ccic1phy_parents), APMU_CCIC_CLK_RES_CTRL, 7, 1,
+		    BIT(5), 0);
+
+CCU_GATE_DEFINE(CLK_SDH_AXI, sdh_axi_aclk, sdh_axi_aclk, "pmua_aclk",
+		APMU_SDH0_CLK_RES_CTRL, BIT(3), 0);
+static const char * const sdh01_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d4_614p4",
+	"pll2_d8",
+	"pll2_d5",
+	"pll1_d11_223p4",
+	"pll1_d13_189",
+	"pll1_d23_106p8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_SDH0, sdh0_clk, sdh0_clk, sdh01_parents,
+				 ARRAY_SIZE(sdh01_parents),
+				 APMU_SDH0_CLK_RES_CTRL,
+				 APMU_SDH0_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+				 BIT(4), 0);
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_SDH1, sdh1_clk, sdh1_clk, sdh01_parents,
+				 ARRAY_SIZE(sdh01_parents),
+				 APMU_SDH1_CLK_RES_CTRL,
+				 APMU_SDH1_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+				 BIT(4), 0);
+static const char * const sdh2_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d4_614p4",
+	"pll2_d8",
+	"pll1_d3_819p2",
+	"pll1_d11_223p4",
+	"pll1_d13_189",
+	"pll1_d23_106p8",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_SDH2, sdh2_clk, sdh2_clk, sdh2_parents,
+				 ARRAY_SIZE(sdh2_parents),
+				 APMU_SDH2_CLK_RES_CTRL,
+				 APMU_SDH2_CLK_RES_CTRL, 8, 3, BIT(11), 5, 3,
+				 BIT(4), 0);
+
+CCU_GATE_DEFINE(CLK_USB_AXI, usb_axi_clk, usb_axi_clk, "pmua_aclk",
+		APMU_USB_CLK_RES_CTRL, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_USB_P1, usb_p1_aclk, usb_p1_aclk, "pmua_aclk",
+		APMU_USB_CLK_RES_CTRL, BIT(5), 0);
+CCU_GATE_DEFINE(CLK_USB30, usb30_clk, usb30_clk, "pmua_aclk",
+		APMU_USB_CLK_RES_CTRL, BIT(8), 0);
+
+static const char * const qspi_parents[] = {
+	"pll1_d6_409p6",
+	"pll2_d8",
+	"pll1_d8_307p2",
+	"pll1_d10_245p76",
+	"pll1_d11_223p4",
+	"pll1_d23_106p8",
+	"pll1_d5_491p52",
+	"pll1_d13_189",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_QSPI, qspi_clk, qspi_clk, qspi_parents,
+				 ARRAY_SIZE(qspi_parents),
+				 APMU_QSPI_CLK_RES_CTRL,
+				 APMU_QSPI_CLK_RES_CTRL, 9, 3, BIT(12), 6, 3,
+				 BIT(4), 0);
+CCU_GATE_DEFINE(CLK_QSPI_BUS, qspi_bus_clk, qspi_bus_clk, "pmua_aclk",
+		APMU_QSPI_CLK_RES_CTRL, BIT(3), 0);
+CCU_GATE_DEFINE(CLK_DMA, dma_clk, dma_clk, "pmua_aclk", APMU_DMA_CLK_RES_CTRL,
+		BIT(3), 0);
+
+static const char * const aes_parents[] = {
+	"pll1_d12_204p8",
+	"pll1_d24_102p4",
+};
+
+CCU_MUX_GATE_DEFINE(CLK_AES, aes_clk, aes_clk, aes_parents,
+		    ARRAY_SIZE(aes_parents), APMU_AES_CLK_RES_CTRL, 6, 1,
+		    BIT(5), 0);
+
+static const char * const vpu_parents[] = {
+	"pll1_d4_614p4",
+	"pll1_d5_491p52",
+	"pll1_d3_819p2",
+	"pll1_d6_409p6",
+	"pll3_d6",
+	"pll2_d3",
+	"pll2_d4",
+	"pll2_d5",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_VPU, vpu_clk, vpu_clk, vpu_parents,
+				 ARRAY_SIZE(vpu_parents), APMU_VPU_CLK_RES_CTRL,
+				 APMU_VPU_CLK_RES_CTRL, 13, 3, BIT(21), 10, 3,
+				 BIT(3), 0);
+
+static const char * const gpu_parents[] = {
+	"pll1_d4_614p4",
+	"pll1_d5_491p52",
+	"pll1_d3_819p2",
+	"pll1_d6_409p6",
+	"pll3_d6",
+	"pll2_d3",
+	"pll2_d4",
+	"pll2_d5",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_GPU, gpu_clk, gpu_clk, gpu_parents,
+				 ARRAY_SIZE(gpu_parents), APMU_GPU_CLK_RES_CTRL,
+				 APMU_GPU_CLK_RES_CTRL, 12, 3, BIT(15), 18, 3,
+				 BIT(4), 0);
+
+static const char * const audio_parents[] = {
+	"pll1_aud_245p7",
+	"pll1_d8_307p2",
+	"pll1_d6_409p6",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_AUDIO, audio_clk, audio_clk, audio_parents,
+				 ARRAY_SIZE(audio_parents),
+				 APMU_AUDIO_CLK_RES_CTRL,
+				 APMU_AUDIO_CLK_RES_CTRL, 4, 3, BIT(15),
+				 7, 3, BIT(12), 0);
+
+static const char * const hdmi_parents[] = {
+	"pll1_d6_409p6",
+	"pll1_d5_491p52",
+	"pll1_d4_614p4",
+	"pll1_d8_307p2",
+};
+
+CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(CLK_HDMI, hdmi_mclk, hdmi_mclk, hdmi_parents,
+				 ARRAY_SIZE(hdmi_parents),
+				 APMU_HDMI_CLK_RES_CTRL,
+				 APMU_HDMI_CLK_RES_CTRL, 1, 4, BIT(29), 5,
+				 3, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_PCIE0_MASTER, pcie0_master_clk, pcie0_master_clk,
+		"pmua_aclk", APMU_PCIE_CLK_RES_CTRL_0, BIT(2), 0);
+CCU_GATE_DEFINE(CLK_PCIE0_SLAVE, pcie0_slave_clk, pcie0_slave_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_0, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_PCIE0_DBI, pcie0_dbi_clk, pcie0_dbi_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_0, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_PCIE1_MASTER, pcie1_master_clk, pcie1_master_clk,
+		"pmua_aclk", APMU_PCIE_CLK_RES_CTRL_1, BIT(2), 0);
+CCU_GATE_DEFINE(CLK_PCIE1_SLAVE, pcie1_slave_clk, pcie1_slave_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_1, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_PCIE1_DBI, pcie1_dbi_clk, pcie1_dbi_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_1, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_PCIE2_MASTER, pcie2_master_clk, pcie2_master_clk,
+		"pmua_aclk", APMU_PCIE_CLK_RES_CTRL_2, BIT(2), 0);
+CCU_GATE_DEFINE(CLK_PCIE2_SLAVE, pcie2_slave_clk, pcie2_slave_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_2, BIT(1), 0);
+CCU_GATE_DEFINE(CLK_PCIE2_DBI, pcie2_dbi_clk, pcie2_dbi_clk, "pmua_aclk",
+		APMU_PCIE_CLK_RES_CTRL_2, BIT(0), 0);
+
+CCU_GATE_DEFINE(CLK_EMAC0_BUS, emac0_bus_clk, emac0_bus_clk, "pmua_aclk",
+		APMU_EMAC0_CLK_RES_CTRL, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_EMAC0_PTP, emac0_ptp_clk, emac0_ptp_clk, "pll2_d6",
+		APMU_EMAC0_CLK_RES_CTRL, BIT(15), 0);
+CCU_GATE_DEFINE(CLK_EMAC1_BUS, emac1_bus_clk, emac1_bus_clk, "pmua_aclk",
+		APMU_EMAC1_CLK_RES_CTRL, BIT(0), 0);
+CCU_GATE_DEFINE(CLK_EMAC1_PTP, emac1_ptp_clk, emac1_ptp_clk, "pll2_d6",
+		APMU_EMAC1_CLK_RES_CTRL, BIT(15), 0);
+
+#endif
+/* APMU clocks end */
+
+static struct clk *k1_ccu_pll_clks[] = {
+	&pll1.common.clk,
+	&pll2.common.clk,
+	&pll3.common.clk,
+	&pll1_d2.common.clk,
+	&pll1_d3.common.clk,
+	&pll1_d4.common.clk,
+	&pll1_d5.common.clk,
+	&pll1_d6.common.clk,
+	&pll1_d7.common.clk,
+	&pll1_d8.common.clk,
+	&pll1_d11_223p4.common.clk,
+	&pll1_d13_189.common.clk,
+	&pll1_d23_106p8.common.clk,
+	&pll1_d64_38p4.common.clk,
+	&pll1_aud_245p7.common.clk,
+	&pll1_aud_24p5.common.clk,
+	&pll2_d1.common.clk,
+	&pll2_d2.common.clk,
+	&pll2_d3.common.clk,
+	&pll2_d4.common.clk,
+	&pll2_d5.common.clk,
+	&pll2_d6.common.clk,
+	&pll2_d7.common.clk,
+	&pll2_d8.common.clk,
+	&pll3_d1.common.clk,
+	&pll3_d2.common.clk,
+	&pll3_d3.common.clk,
+	&pll3_d4.common.clk,
+	&pll3_d5.common.clk,
+	&pll3_d6.common.clk,
+	&pll3_d7.common.clk,
+	&pll3_d8.common.clk,
+	&pll3_80.common.clk,
+	&pll3_40.common.clk,
+	&pll3_20.common.clk,
+};
+
+static const struct spacemit_ccu_data k1_ccu_pll_data = {
+	.clks		= k1_ccu_pll_clks,
+	.num		= ARRAY_SIZE(k1_ccu_pll_clks),
+	.offset		= K1_PLL_ID,
+};
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_mpmu_clks[] = {
+	&pll1_d8_307p2.common.clk,
+	&pll1_d32_76p8.common.clk,
+	&pll1_d40_61p44.common.clk,
+	&pll1_d16_153p6.common.clk,
+	&pll1_d24_102p4.common.clk,
+	&pll1_d48_51p2.common.clk,
+	&pll1_d48_51p2_ap.common.clk,
+	&pll1_m3d128_57p6.common.clk,
+	&pll1_d96_25p6.common.clk,
+	&pll1_d192_12p8.common.clk,
+	&pll1_d192_12p8_wdt.common.clk,
+	&pll1_d384_6p4.common.clk,
+	&pll1_d768_3p2.common.clk,
+	&pll1_d1536_1p6.common.clk,
+	&pll1_d3072_0p8.common.clk,
+	&pll1_d6_409p6.common.clk,
+	&pll1_d12_204p8.common.clk,
+	&pll1_d5_491p52.common.clk,
+	&pll1_d10_245p76.common.clk,
+	&pll1_d4_614p4.common.clk,
+	&pll1_d52_47p26.common.clk,
+	&pll1_d78_31p5.common.clk,
+	&pll1_d3_819p2.common.clk,
+	&pll1_d2_1228p8.common.clk,
+	&slow_uart.common.clk,
+	&slow_uart1_14p74.common.clk,
+	&slow_uart2_48.common.clk,
+};
+#else
+static struct clk *k1_ccu_mpmu_clks[] = {
+	&pll1_d8_307p2.common.clk,
+	&pll1_d32_76p8.common.clk,
+	&pll1_d40_61p44.common.clk,
+	&pll1_d16_153p6.common.clk,
+	&pll1_d24_102p4.common.clk,
+	&pll1_d48_51p2.common.clk,
+	&pll1_d48_51p2_ap.common.clk,
+	&pll1_m3d128_57p6.common.clk,
+	&pll1_d96_25p6.common.clk,
+	&pll1_d192_12p8.common.clk,
+	&pll1_d192_12p8_wdt.common.clk,
+	&pll1_d384_6p4.common.clk,
+	&pll1_d768_3p2.common.clk,
+	&pll1_d1536_1p6.common.clk,
+	&pll1_d3072_0p8.common.clk,
+	&pll1_d6_409p6.common.clk,
+	&pll1_d12_204p8.common.clk,
+	&pll1_d5_491p52.common.clk,
+	&pll1_d10_245p76.common.clk,
+	&pll1_d4_614p4.common.clk,
+	&pll1_d52_47p26.common.clk,
+	&pll1_d78_31p5.common.clk,
+	&pll1_d3_819p2.common.clk,
+	&pll1_d2_1228p8.common.clk,
+	&slow_uart.common.clk,
+	&slow_uart1_14p74.common.clk,
+	&slow_uart2_48.common.clk,
+	&wdt_clk.common.clk,
+	&apb_clk.common.clk,
+	&ripc_clk.common.clk,
+	&i2s_153p6.common.clk,
+	&i2s_153p6_base.common.clk,
+	&i2s_sysclk_src.common.clk,
+	&i2s_sysclk.common.clk,
+	&i2s_bclk_factor.common.clk,
+	&i2s_bclk.common.clk,
+	&wdt_bus_clk.common.clk,
+};
+#endif
+
+static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
+	.clks		= k1_ccu_mpmu_clks,
+	.num		= ARRAY_SIZE(k1_ccu_mpmu_clks),
+	.offset		= K1_MPMU_ID,
+};
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_apbc_clks[] = {
+	&uart0_clk.common.clk,
+	&twsi2_clk.common.clk,
+	&twsi8_clk.common.clk,
+};
+#else
+static struct clk *k1_ccu_apbc_clks[] = {
+	&uart0_clk.common.clk,
+	&uart2_clk.common.clk,
+	&uart3_clk.common.clk,
+	&uart4_clk.common.clk,
+	&uart5_clk.common.clk,
+	&uart6_clk.common.clk,
+	&uart7_clk.common.clk,
+	&uart8_clk.common.clk,
+	&uart9_clk.common.clk,
+	&gpio_clk.common.clk,
+	&pwm0_clk.common.clk,
+	&pwm1_clk.common.clk,
+	&pwm2_clk.common.clk,
+	&pwm3_clk.common.clk,
+	&pwm4_clk.common.clk,
+	&pwm5_clk.common.clk,
+	&pwm6_clk.common.clk,
+	&pwm7_clk.common.clk,
+	&pwm8_clk.common.clk,
+	&pwm9_clk.common.clk,
+	&pwm10_clk.common.clk,
+	&pwm11_clk.common.clk,
+	&pwm12_clk.common.clk,
+	&pwm13_clk.common.clk,
+	&pwm14_clk.common.clk,
+	&pwm15_clk.common.clk,
+	&pwm16_clk.common.clk,
+	&pwm17_clk.common.clk,
+	&pwm18_clk.common.clk,
+	&pwm19_clk.common.clk,
+	&ssp3_clk.common.clk,
+	&rtc_clk.common.clk,
+	&twsi0_clk.common.clk,
+	&twsi1_clk.common.clk,
+	&twsi2_clk.common.clk,
+	&twsi4_clk.common.clk,
+	&twsi5_clk.common.clk,
+	&twsi6_clk.common.clk,
+	&twsi7_clk.common.clk,
+	&twsi8_clk.common.clk,
+	&timers1_clk.common.clk,
+	&timers2_clk.common.clk,
+	&aib_clk.common.clk,
+	&onewire_clk.common.clk,
+	&sspa0_clk.common.clk,
+	&sspa1_clk.common.clk,
+	&dro_clk.common.clk,
+	&ir_clk.common.clk,
+	&tsen_clk.common.clk,
+	&ipc_ap2aud_clk.common.clk,
+	&can0_clk.common.clk,
+	&can0_bus_clk.common.clk,
+	&uart0_bus_clk.common.clk,
+	&uart2_bus_clk.common.clk,
+	&uart3_bus_clk.common.clk,
+	&uart4_bus_clk.common.clk,
+	&uart5_bus_clk.common.clk,
+	&uart6_bus_clk.common.clk,
+	&uart7_bus_clk.common.clk,
+	&uart8_bus_clk.common.clk,
+	&uart9_bus_clk.common.clk,
+	&gpio_bus_clk.common.clk,
+	&pwm0_bus_clk.common.clk,
+	&pwm1_bus_clk.common.clk,
+	&pwm2_bus_clk.common.clk,
+	&pwm3_bus_clk.common.clk,
+	&pwm4_bus_clk.common.clk,
+	&pwm5_bus_clk.common.clk,
+	&pwm6_bus_clk.common.clk,
+	&pwm7_bus_clk.common.clk,
+	&pwm8_bus_clk.common.clk,
+	&pwm9_bus_clk.common.clk,
+	&pwm10_bus_clk.common.clk,
+	&pwm11_bus_clk.common.clk,
+	&pwm12_bus_clk.common.clk,
+	&pwm13_bus_clk.common.clk,
+	&pwm14_bus_clk.common.clk,
+	&pwm15_bus_clk.common.clk,
+	&pwm16_bus_clk.common.clk,
+	&pwm17_bus_clk.common.clk,
+	&pwm18_bus_clk.common.clk,
+	&pwm19_bus_clk.common.clk,
+	&ssp3_bus_clk.common.clk,
+	&rtc_bus_clk.common.clk,
+	&twsi0_bus_clk.common.clk,
+	&twsi1_bus_clk.common.clk,
+	&twsi2_bus_clk.common.clk,
+	&twsi4_bus_clk.common.clk,
+	&twsi5_bus_clk.common.clk,
+	&twsi6_bus_clk.common.clk,
+	&twsi7_bus_clk.common.clk,
+	&twsi8_bus_clk.common.clk,
+	&timers1_bus_clk.common.clk,
+	&timers2_bus_clk.common.clk,
+	&aib_bus_clk.common.clk,
+	&onewire_bus_clk.common.clk,
+	&sspa0_bus_clk.common.clk,
+	&sspa1_bus_clk.common.clk,
+	&tsen_bus_clk.common.clk,
+	&ipc_ap2aud_bus_clk.common.clk,
+	&sspa0_i2s_bclk.common.clk,
+	&sspa1_i2s_bclk.common.clk,
+};
+#endif
+
+static const struct spacemit_ccu_data k1_ccu_apbc_data = {
+	.clks		= k1_ccu_apbc_clks,
+	.num		= ARRAY_SIZE(k1_ccu_apbc_clks),
+	.offset		= K1_APBC_ID,
+};
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+static struct clk *k1_ccu_apmu_clks[] = {
+	&emmc_clk.common.clk,
+	&emmc_x_clk.common.clk,
+	&pmua_aclk.common.clk,
+	&emmc_bus_clk.common.clk,
+};
+#else
+static struct clk *k1_ccu_apmu_clks[] = {
+	&cci550_clk.common.clk,
+	&cpu_c0_hi_clk.common.clk,
+	&cpu_c0_core_clk.common.clk,
+	&cpu_c0_ace_clk.common.clk,
+	&cpu_c0_tcm_clk.common.clk,
+	&cpu_c1_hi_clk.common.clk,
+	&cpu_c1_core_clk.common.clk,
+	&cpu_c1_ace_clk.common.clk,
+	&ccic_4x_clk.common.clk,
+	&ccic1phy_clk.common.clk,
+	&sdh_axi_aclk.common.clk,
+	&sdh0_clk.common.clk,
+	&sdh1_clk.common.clk,
+	&sdh2_clk.common.clk,
+	&usb_p1_aclk.common.clk,
+	&usb_axi_clk.common.clk,
+	&usb30_clk.common.clk,
+	&qspi_clk.common.clk,
+	&qspi_bus_clk.common.clk,
+	&dma_clk.common.clk,
+	&aes_clk.common.clk,
+	&vpu_clk.common.clk,
+	&gpu_clk.common.clk,
+	&emmc_clk.common.clk,
+	&emmc_x_clk.common.clk,
+	&audio_clk.common.clk,
+	&hdmi_mclk.common.clk,
+	&pmua_aclk.common.clk,
+	&pcie0_master_clk.common.clk,
+	&pcie0_slave_clk.common.clk,
+	&pcie0_dbi_clk.common.clk,
+	&pcie1_master_clk.common.clk,
+	&pcie1_slave_clk.common.clk,
+	&pcie1_dbi_clk.common.clk,
+	&pcie2_master_clk.common.clk,
+	&pcie2_slave_clk.common.clk,
+	&pcie2_dbi_clk.common.clk,
+	&emac0_bus_clk.common.clk,
+	&emac0_ptp_clk.common.clk,
+	&emac1_bus_clk.common.clk,
+	&emac1_ptp_clk.common.clk,
+	&jpg_clk.common.clk,
+	&ccic2phy_clk.common.clk,
+	&ccic3phy_clk.common.clk,
+	&csi_clk.common.clk,
+	&camm0_clk.common.clk,
+	&camm1_clk.common.clk,
+	&camm2_clk.common.clk,
+	&isp_cpp_clk.common.clk,
+	&isp_bus_clk.common.clk,
+	&isp_clk.common.clk,
+	&dpu_mclk.common.clk,
+	&dpu_esc_clk.common.clk,
+	&dpu_bit_clk.common.clk,
+	&dpu_pxclk.common.clk,
+	&dpu_hclk.common.clk,
+	&dpu_spi_clk.common.clk,
+	&dpu_spi_hbus_clk.common.clk,
+	&dpu_spi_bus_clk.common.clk,
+	&dpu_spi_aclk.common.clk,
+	&v2d_clk.common.clk,
+	&emmc_bus_clk.common.clk,
+};
+#endif
+
+static int clk_k1_enable(struct clk *clk)
+{
+	const struct spacemit_ccu_data *data;
+	struct clk *c;
+	struct clk *pclk;
+	int ret, i;
+
+	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
+	for (i = 0; i < data->num; i++) {
+		if (clk->id == data->clks[i]->id) {
+			c = data->clks[i];
+			break;
+		}
+	}
+	if (i == data->num)
+		c = clk;
+
+	pclk = clk_get_parent(c);
+	if (!IS_ERR_OR_NULL(pclk)) {
+		ret = ccf_clk_enable(pclk);
+		if (ret)
+			return ret;
+	}
+	ret = ccu_gate_enable(c);
+	return ret;
+}
+
+static int clk_k1_disable(struct clk *clk)
+{
+	const struct spacemit_ccu_data *data;
+	struct clk *c;
+	struct clk *pclk;
+	int ret, i;
+
+	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
+	for (i = 0; i < data->num; i++) {
+		if (clk->id == data->clks[i]->id) {
+			c = data->clks[i];
+			break;
+		}
+	}
+	if (i == data->num)
+		c = clk;
+
+	pclk = clk_get_parent(c);
+	if (!IS_ERR_OR_NULL(pclk)) {
+		ret = ccf_clk_disable(pclk);
+		if (ret)
+			return ret;
+	}
+	ret = ccu_gate_disable(c);
+	return ret;
+}
+
+#define K1_CLK_OPS(name)				\
+static const struct clk_ops k1_##name##_clk_ops = {	\
+		.set_rate = ccf_clk_set_rate,		\
+		.get_rate = ccf_clk_get_rate,		\
+		.enable = clk_k1_enable,		\
+		.disable = clk_k1_disable,		\
+		.set_parent = ccf_clk_set_parent,	\
+		.of_xlate = k1_##name##_clk_of_xlate,	\
+}
+
+static const struct spacemit_ccu_data k1_ccu_apmu_data = {
+	.clks		= k1_ccu_apmu_clks,
+	.num		= ARRAY_SIZE(k1_ccu_apmu_clks),
+	.offset		= K1_APMU_ID,
+};
+
+struct clk_retry_item {
+	struct ccu_common *common;
+	struct list_head link;
+};
+
+static LIST_HEAD(retry_list);
+
+static int k1_clk_retry_register(void)
+{
+	struct clk_retry_item *item, *tmp;
+	int retries = 5;
+	int ret;
+
+	while (!list_empty(&retry_list) && retries) {
+		list_for_each_entry_safe(item, tmp, &retry_list, link) {
+			struct ccu_common *common = item->common;
+
+			ret = common->init(common);
+			if (ret)
+				return ret;
+
+			list_del(&item->link);
+			kfree(item);
+		}
+		retries--;
+	}
+
+	return 0;
+}
+
+static int k1_clk_register(struct udevice *dev, struct regmap *regmap,
+			   struct regmap *lock_regmap,
+			   const struct spacemit_ccu_data *data)
+{
+	int i, ret;
+
+	for (i = 0; i < data->num; i++) {
+		struct clk *clk = data->clks[i];
+		struct ccu_common *common;
+
+		if (!clk)
+			continue;
+
+		common = clk_to_ccu_common(clk);
+		common->regmap = regmap;
+		common->lock_regmap = lock_regmap;
+
+		clk->id = common->clk.id + data->offset;
+
+		ret = common->init(common);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int k1_clk_probe(struct udevice *dev)
+{
+	struct regmap *base_regmap, *lock_regmap = NULL;
+	const struct spacemit_ccu_data *data;
+	int ret;
+
+	clk_register_fixed_rate(NULL, "clock-1m", 1000000);
+	clk_register_fixed_rate(NULL, "clock-24m", 24000000);
+	clk_register_fixed_rate(NULL, "clock-3m", 3000000);
+	clk_register_fixed_rate(NULL, "clock-32k", 32000);
+
+	ret = regmap_init_mem(dev_ofnode(dev), &base_regmap);
+	if (ret)
+		return ret;
+
+	/*
+	 * The lock status of PLLs locate in MPMU region, while PLLs themselves
+	 * are in APBS region. Reference to MPMU syscon is required to check PLL
+	 * status.
+	 */
+	if (device_is_compatible(dev, "spacemit,k1-pll")) {
+		struct ofnode_phandle_args mpmu_args;
+
+		ret = dev_read_phandle_with_args(dev, "spacemit,mpmu", NULL, 0, 0,
+						 &mpmu_args);
+		if (ret)
+			return ret;
+
+		ret = regmap_init_mem(mpmu_args.node, &lock_regmap);
+		if (ret)
+			return ret;
+	}
+
+	data = (struct spacemit_ccu_data *)dev_get_driver_data(dev);
+
+	ret = k1_clk_register(dev, base_regmap, lock_regmap, data);
+	if (ret)
+		return -EPROBE_DEFER;
+
+	return k1_clk_retry_register();
+}
+
+static int k1_apbc_clk_probe(struct udevice *dev)
+{
+	struct regmap *base_regmap, *lock_regmap = NULL;
+	const struct spacemit_ccu_data *data;
+	int ret;
+	struct clk clk;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &base_regmap);
+	if (ret)
+		return ret;
+
+	clk_register_fixed_rate(NULL, "clock-1m", 1000000);
+	clk_register_fixed_rate(NULL, "clock-24m", 24000000);
+	clk_register_fixed_rate(NULL, "clock-3m", 3000000);
+	clk_register_fixed_rate(NULL, "clock-32k", 32000);
+
+	/* probe PLL controller */
+	ret = clk_get_by_index(dev, 5, &clk);
+	if (ret)
+		return -EPROBE_DEFER;
+
+	/* probe MPMU controller */
+	ret = clk_get_by_index(dev, 4, &clk);
+	if (ret)
+		return -EPROBE_DEFER;
+
+	ret = regmap_init_mem(dev_ofnode(dev), &base_regmap);
+	if (ret)
+		return ret;
+
+	/*
+	 * The lock status of PLLs locate in MPMU region, while PLLs themselves
+	 * are in APBS region. Reference to MPMU syscon is required to check PLL
+	 * status.
+	 */
+	if (device_is_compatible(dev, "spacemit,k1-pll")) {
+		struct ofnode_phandle_args mpmu_args;
+
+		ret = dev_read_phandle_with_args(dev, "spacemit,mpmu", NULL, 0, 0,
+						 &mpmu_args);
+		if (ret)
+			return ret;
+
+		ret = regmap_init_mem(mpmu_args.node, &lock_regmap);
+		if (ret)
+			return ret;
+	}
+
+	data = (struct spacemit_ccu_data *)dev_get_driver_data(dev);
+
+	ret = k1_clk_register(dev, base_regmap, lock_regmap, data);
+	if (ret)
+		return -EPROBE_DEFER;
+
+	return k1_clk_retry_register();
+}
+
+static int k1_pll_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count)
+		clk->id = K1_PLL_ID + args->args[0];
+	else
+		clk->id = K1_PLL_ID;
+
+	return 0;
+}
+
+static int k1_mpmu_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count)
+		clk->id = K1_MPMU_ID + args->args[0];
+	else
+		clk->id = K1_MPMU_ID;
+
+	return 0;
+}
+
+static int k1_apbc_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count)
+		clk->id = K1_APBC_ID + args->args[0];
+	else
+		clk->id = K1_APBC_ID;
+
+	return 0;
+}
+
+static int k1_apmu_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count)
+		clk->id = K1_APMU_ID + args->args[0];
+	else
+		clk->id = K1_APMU_ID;
+
+	return 0;
+}
+
+static const struct udevice_id k1_pll_clk_match[] = {
+	{ .compatible = "spacemit,k1-pll",
+	      .data = (ulong)&k1_ccu_pll_data },
+	{ /* sentinel */ },
+};
+
+K1_CLK_OPS(pll);
+
+U_BOOT_DRIVER(k1_pll_clk) = {
+	.name		= "k1_pll_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_pll_clk_match,
+	.probe		= k1_clk_probe,
+	.ops		= &k1_pll_clk_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_mpmu_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-mpmu",
+	  .data = (ulong)&k1_ccu_mpmu_data },
+	{ /* sentinel */ },
+};
+
+K1_CLK_OPS(mpmu);
+
+U_BOOT_DRIVER(k1_mpmu_clk) = {
+	.name		= "k1_mpmu_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_mpmu_clk_match,
+	.probe		= k1_clk_probe,
+	.ops		= &k1_mpmu_clk_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_apbc_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-apbc",
+	  .data = (ulong)&k1_ccu_apbc_data },
+	{ /* sentinel */ },
+};
+
+K1_CLK_OPS(apbc);
+
+U_BOOT_DRIVER(k1_apbc_clk) = {
+	.name		= "k1_apbc_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_apbc_clk_match,
+	.probe		= k1_apbc_clk_probe,
+	.ops		= &k1_apbc_clk_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_apmu_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-apmu",
+	  .data = (ulong)&k1_ccu_apmu_data },
+	{ /* sentinel */ },
+};
+
+K1_CLK_OPS(apmu);
+
+U_BOOT_DRIVER(k1_apmu_clk) = {
+	.name		= "k1_apmu_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_apmu_clk_match,
+	.probe		= k1_clk_probe,
+	.ops		= &k1_apmu_clk_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_rcpu_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-rcpu" },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(k1_rcpu_clk) = {
+	.name		= "k1_rcpu_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_rcpu_clk_match,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_rcpu2_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-rcpu2" },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(k1_rcpu2_clk) = {
+	.name		= "k1_rcpu2_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_rcpu2_clk_match,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+static const struct udevice_id k1_apbc2_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-apbc2" },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(k1_apbc2_clk) = {
+	.name		= "k1_apbc2_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_apbc2_clk_match,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_common.h b/drivers/clk/spacemit/clk_common.h
new file mode 100644
index 00000000000..dda9264caf3
--- /dev/null
+++ b/drivers/clk/spacemit/clk_common.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Copyright (c) 2025-2026 RISCStar Ltd.
+ *
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CLK_COMMON_H_
+#define _CLK_COMMON_H_
+
+#include <linux/clk-provider.h>
+
+struct ccu_common;
+
+typedef int (*ccu_init_fn)(struct ccu_common *common);
+
+struct ccu_common {
+	struct regmap *regmap;
+	struct regmap *lock_regmap;
+	const char *name;
+	const char * const *parents;
+	size_t num_parents;
+	ccu_init_fn init;
+
+	union {
+		/* For DDN and MIX */
+		struct {
+			u32 reg_ctrl;
+			u32 reg_fc;
+			u32 mask_fc;
+		};
+
+		/* For PLL */
+		struct {
+			u32 reg_swcr1;
+			u32 reg_swcr3;
+		};
+	};
+
+	struct clk clk;
+};
+
+#define CCU_COMMON(_id, _name, _parent, _init, _flags)			\
+	.name		= #_name,					\
+	.parents	= (const char *[]) { _parent },			\
+	.num_parents	= 1,						\
+	.init		= _init,					\
+	.clk		= { .flags = _flags, .id = _id, }		\
+
+#define CCU_COMMON_PARENTS(_id, _name, _parents, _num_p, _init, _flags)	\
+	.name		= #_name,					\
+	.parents	= _parents,					\
+	.num_parents	= _num_p,					\
+	.init		= _init,					\
+	.clk		= { .flags = _flags, .id = _id, }		\
+
+static inline struct ccu_common *clk_to_ccu_common(struct clk *clk)
+{
+	return container_of(clk, struct ccu_common, clk);
+}
+
+#define ccu_read(c, reg)						\
+	({								\
+		struct ccu_common * const __ccu = (c);			\
+		u32 tmp;						\
+		regmap_read(__ccu->regmap, __ccu->reg_##reg, &tmp);	\
+		tmp;							\
+	 })
+#define ccu_update(c, reg, mask, val) \
+	({								\
+		struct ccu_common * const __ccu = (c);			\
+		regmap_update_bits(__ccu->regmap, __ccu->reg_##reg,	\
+				   mask, val);				\
+	})
+
+#endif /* _CLK_COMMON_H_ */
diff --git a/drivers/clk/spacemit/clk_ddn.c b/drivers/clk/spacemit/clk_ddn.c
new file mode 100644
index 00000000000..7b93f30d5c3
--- /dev/null
+++ b/drivers/clk/spacemit/clk_ddn.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ *
+ * DDN stands for "Divider Denominator Numerator", it's M/N clock with a
+ * constant x2 factor. This clock hardware follows the equation below,
+ *
+ *	      numerator       Fin
+ *	2 * ------------- = -------
+ *	     denominator      Fout
+ *
+ * Thus, Fout could be calculated with,
+ *
+ *		Fin	denominator
+ *	Fout = ----- * -------------
+ *		 2	 numerator
+ */
+
+#include <dm/device.h>
+#include <regmap.h>
+#include <linux/clk-provider.h>
+#include <linux/rational.h>
+
+#include "clk_ddn.h"
+
+#define UBOOT_DM_SPACEMIT_CLK_DDN "spacemit_clk_ddn"
+
+static unsigned long ccu_ddn_calc_rate(unsigned long prate, unsigned long num,
+				       unsigned long den, unsigned int pre_div)
+{
+	return prate * den / pre_div / num;
+}
+
+static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
+					    unsigned long rate, unsigned long prate,
+					    unsigned long *num, unsigned long *den)
+{
+	rational_best_approximation(rate, prate / ddn->pre_div,
+				    ddn->den_mask >> ddn->den_shift,
+				    ddn->num_mask >> ddn->num_shift,
+				    den, num);
+	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
+}
+
+static unsigned long ccu_ddn_recalc_rate(struct clk *clk)
+{
+	struct ccu_ddn *ddn = clk_to_ccu_ddn(clk);
+	unsigned int val, num, den;
+
+	val = ccu_read(&ddn->common, ctrl);
+
+	num = (val & ddn->num_mask) >> ddn->num_shift;
+	den = (val & ddn->den_mask) >> ddn->den_shift;
+
+	return ccu_ddn_calc_rate(clk_get_parent_rate(clk), num, den, ddn->pre_div);
+}
+
+static unsigned long ccu_ddn_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ccu_ddn *ddn = clk_to_ccu_ddn(clk);
+	unsigned long num, den;
+
+	ccu_ddn_calc_best_rate(ddn, rate, clk_get_parent_rate(clk), &num, &den);
+
+	ccu_update(&ddn->common, ctrl,
+		   ddn->num_mask | ddn->den_mask,
+		   (num << ddn->num_shift) | (den << ddn->den_shift));
+
+	return 0;
+}
+
+static const struct clk_ops spacemit_clk_ddn_ops = {
+	.get_rate = ccu_ddn_recalc_rate,
+	.set_rate = ccu_ddn_set_rate,
+};
+
+int spacemit_ddn_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_DDN,
+			    common->name, common->parents[0]);
+}
+
+U_BOOT_DRIVER(spacemit_clk_ddn) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_DDN,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_ddn_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_ddn.h b/drivers/clk/spacemit/clk_ddn.h
new file mode 100644
index 00000000000..cde761bdc43
--- /dev/null
+++ b/drivers/clk/spacemit/clk_ddn.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Copyright (c) 2025-2026 RISCStar Ltd.
+ *
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CLK_DDN_H_
+#define _CLK_DDN_H_
+
+#include <linux/clk-provider.h>
+
+#include "clk_common.h"
+
+struct ccu_ddn {
+	struct ccu_common common;
+	unsigned int num_mask;
+	unsigned int num_shift;
+	unsigned int den_mask;
+	unsigned int den_shift;
+	unsigned int pre_div;
+};
+
+#define CCU_DDN_MASK(_num_shift, _num_width)					\
+	GENMASK((_num_shift) + (_num_width) - 1, _num_shift)
+
+#define CCU_DDN_DEFINE(_id, _var, _name, _parent, _reg_ctrl, _num_mask,		\
+		       _num_shift, _den_mask, _den_shift, _pre_div, _flags)	\
+static struct ccu_ddn _var = {							\
+	.common = {								\
+		.reg_ctrl	= _reg_ctrl,					\
+		CCU_COMMON(_id, _name, _parent, spacemit_ddn_init, _flags)	\
+	},									\
+	.num_mask	= _num_mask,						\
+	.num_shift	= _num_shift,						\
+	.den_mask	= _den_mask,						\
+	.den_shift	= _den_shift,						\
+	.pre_div	= _pre_div,						\
+}
+
+static inline struct ccu_ddn *clk_to_ccu_ddn(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	return container_of(common, struct ccu_ddn, common);
+}
+
+int spacemit_ddn_init(struct ccu_common *common);
+
+#endif /* _CLK_DDN_H_ */
diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
new file mode 100644
index 00000000000..a1158512a92
--- /dev/null
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ *
+ * MIX clock type is the combination of mux, factor or divider, and gate
+ */
+
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <div64.h>
+#include <regmap.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+
+#include "clk_mix.h"
+
+#define UBOOT_DM_SPACEMIT_CLK_GATE		"spacemit_clk_gate"
+#define UBOOT_DM_SPACEMIT_CLK_FACTOR		"spacemit_clk_factor"
+#define UBOOT_DM_SPACEMIT_CLK_MUX		"spacemit_clk_mux"
+#define UBOOT_DM_SPACEMIT_CLK_DIV		"spacemit_clk_div"
+#define UBOOT_DM_SPACEMIT_CLK_FACTOR_GATE	"spacemit_clk_factor_gate"
+#define UBOOT_DM_SPACEMIT_CLK_MUX_GATE		"spacemit_clk_mux_gate"
+#define UBOOT_DM_SPACEMIT_CLK_DIV_GATE		"spacemit_clk_div_gate"
+#define UBOOT_DM_SPACEMIT_CLK_MUX_DIV		"spacemit_clk_mux_div"
+#define UBOOT_DM_SPACEMIT_CLK_MUX_DIV_GATE	"spacemit_clk_mux_div_gate"
+
+#define MIX_FC_TIMEOUT_US	10000
+#define MIX_FC_DELAY_US		5
+
+int ccu_gate_disable(struct clk *clk)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+
+	ccu_update(&mix->common, ctrl, mix->gate.mask, 0);
+
+	return 0;
+}
+
+int ccu_gate_enable(struct clk *clk)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_gate_config *gate = &mix->gate;
+
+	ccu_update(&mix->common, ctrl, gate->mask, gate->mask);
+
+	return 0;
+}
+
+static unsigned long ccu_factor_recalc_rate(struct clk *clk)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+
+	return clk_get_parent_rate(clk) * mix->factor.mul / mix->factor.div;
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk *clk)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_div_config *div = &mix->div;
+	unsigned long val;
+
+	val = ccu_read(&mix->common, ctrl) >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	return divider_recalc_rate(clk, clk_get_parent_rate(clk), val, NULL, 0, div->width);
+}
+
+/*
+ * Some clocks require a "FC" (frequency change) bit to be set after changing
+ * their rates or reparenting. This bit will be automatically cleared by
+ * hardware in MIX_FC_TIMEOUT_US, which indicates the operation is completed.
+ */
+static int ccu_mix_trigger_fc(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+	unsigned int val;
+
+	if (common->reg_fc)
+		return 0;
+
+	ccu_update(common, fc, common->mask_fc, common->mask_fc);
+
+	return regmap_read_poll_timeout(common->regmap, common->reg_fc,
+					val, !(val & common->mask_fc),
+					MIX_FC_DELAY_US,
+					MIX_FC_TIMEOUT_US);
+}
+
+static unsigned long
+ccu_mix_calc_best_rate(struct clk *clk, unsigned long rate,
+		       struct clk **best_parent,
+		       unsigned long *best_parent_rate,
+		       u32 *div_val)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	unsigned int parent_num = common->num_parents;
+	struct ccu_div_config *div = &mix->div;
+	u32 div_max = 1 << div->width;
+	unsigned long best_rate = 0;
+
+	for (int i = 0; i < parent_num; i++) {
+		struct udevice *parent_dev;
+		unsigned long parent_rate;
+		struct clk *parent;
+
+		if (uclass_get_device_by_name(UCLASS_CLK, common->parents[i],
+					      &parent_dev))
+			continue;
+		parent = dev_get_clk_ptr(parent_dev);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_get_rate(parent);
+
+		for (int j = 1; j <= div_max; j++) {
+			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
+
+			if (abs(tmp - rate) < abs(best_rate - rate)) {
+				best_rate = tmp;
+
+				if (div_val)
+					*div_val = j - 1;
+
+				if (best_parent) {
+					*best_parent      = parent;
+					*best_parent_rate = parent_rate;
+				}
+			}
+		}
+	}
+
+	return best_rate;
+}
+
+static unsigned long ccu_mix_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = &mix->div;
+	u32 current_div, target_div, mask;
+
+	ccu_mix_calc_best_rate(clk, rate, NULL, NULL, &target_div);
+
+	current_div = ccu_read(common, ctrl) >> div->shift;
+	current_div &= (1 << div->width) - 1;
+
+	if (current_div == target_div)
+		return 0;
+
+	mask = GENMASK(div->width + div->shift - 1, div->shift);
+
+	ccu_update(common, ctrl, mask, target_div << div->shift);
+
+	return ccu_mix_trigger_fc(clk);
+}
+
+static u8 ccu_mux_get_parent(struct clk *clk)
+{
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_mux_config *mux = &mix->mux;
+	u8 parent;
+
+	parent = ccu_read(&mix->common, ctrl) >> mux->shift;
+	parent &= (1 << mux->width) - 1;
+
+	return parent;
+}
+
+static int ccu_mux_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+	struct ccu_mix *mix = clk_to_ccu_mix(clk);
+	struct ccu_mux_config *mux = &mix->mux;
+	u32 mask;
+	int i = 0;
+
+	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+
+	for (i = 0; i < common->num_parents; i++) {
+		if (!strcmp(parent->dev->name, common->parents[i]))
+			break;
+	}
+
+	if (i == common->num_parents)
+		return -EINVAL;
+
+	ccu_update(&mix->common, ctrl, mask, i << mux->shift);
+
+	return ccu_mix_trigger_fc(clk);
+}
+
+int spacemit_gate_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_GATE,
+			    common->name, common->parents[0]);
+}
+
+static const struct clk_ops spacemit_clk_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.get_rate	= clk_generic_get_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_gate) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_GATE,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_gate_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_factor_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_FACTOR,
+			    common->name, common->parents[0]);
+}
+
+static const struct clk_ops spacemit_clk_factor_ops = {
+	.get_rate	= ccu_factor_recalc_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_factor) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_FACTOR,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_factor_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_mux_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	u8 index;
+
+	index = ccu_mux_get_parent(clk);
+	if (index >= common->num_parents)
+		index = 0;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_MUX,
+			    common->name, common->parents[index]);
+}
+
+static const struct clk_ops spacemit_clk_mux_ops = {
+	.set_parent	= ccu_mux_set_parent,
+	.get_rate	= clk_generic_get_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_mux) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_MUX,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_mux_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_div_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_DIV,
+			    common->name, common->parents[0]);
+}
+
+static const struct clk_ops spacemit_clk_div_ops = {
+	.get_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_div) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_DIV,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_div_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_factor_gate_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_FACTOR_GATE,
+			    common->name, common->parents[0]);
+}
+
+static const struct clk_ops spacemit_clk_factor_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.get_rate	= ccu_factor_recalc_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_factor_gate) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_FACTOR_GATE,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_factor_gate_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_mux_gate_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	u8 index;
+
+	index = ccu_mux_get_parent(clk);
+	if (index >= common->num_parents)
+		index = 0;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_MUX_GATE,
+			    common->name, common->parents[index]);
+}
+
+static const struct clk_ops spacemit_clk_mux_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.set_parent	= ccu_mux_set_parent,
+	.get_rate	= clk_generic_get_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_mux_gate) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_MUX_GATE,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_mux_gate_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_div_gate_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_DIV_GATE,
+			    common->name, common->parents[0]);
+}
+
+static const struct clk_ops spacemit_clk_div_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.get_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_div_gate) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_DIV_GATE,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_div_gate_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_mux_div_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	u8 index;
+
+	index = ccu_mux_get_parent(clk);
+	if (index >= common->num_parents)
+		index = 0;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_MUX_DIV,
+			    common->name, common->parents[index]);
+}
+
+static const struct clk_ops spacemit_clk_mux_div_ops = {
+	.set_parent	= ccu_mux_set_parent,
+	.get_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_mux_div) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_MUX_DIV,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_mux_div_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_mux_div_gate_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	u8 index;
+
+	index = ccu_mux_get_parent(clk);
+	if (index >= common->num_parents)
+		index = 0;
+
+	return clk_register(clk, UBOOT_DM_SPACEMIT_CLK_MUX_DIV_GATE,
+			    common->name, common->parents[index]);
+}
+
+static const struct clk_ops spacemit_clk_mux_div_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.set_parent	= ccu_mux_set_parent,
+	.get_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_mix_set_rate,
+};
+
+U_BOOT_DRIVER(spacemit_clk_mux_div_gate) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_MUX_DIV_GATE,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_mux_div_gate_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_mix.h b/drivers/clk/spacemit/clk_mix.h
new file mode 100644
index 00000000000..bd733a93f6c
--- /dev/null
+++ b/drivers/clk/spacemit/clk_mix.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Copyright (c) 2025-2026 RISCStar Ltd.
+ *
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CLK_MIX_H_
+#define _CLK_MIX_H_
+
+#include <linux/clk-provider.h>
+
+#include "clk_common.h"
+
+/**
+ * struct ccu_gate_config - Gate configuration
+ *
+ * @mask:	Mask to enable the gate. Some clocks may have more than one bit
+ *		set in this field.
+ */
+struct ccu_gate_config {
+	u32 mask;
+};
+
+struct ccu_factor_config {
+	u32 div;
+	u32 mul;
+};
+
+struct ccu_mux_config {
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_div_config {
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_mix {
+	struct ccu_factor_config factor;
+	struct ccu_gate_config gate;
+	struct ccu_div_config div;
+	struct ccu_mux_config mux;
+	struct ccu_common common;
+};
+
+#define CCU_GATE_INIT(_mask)		{ .mask = _mask }
+#define CCU_FACTOR_INIT(_div, _mul)	{ .div = _div, .mul = _mul }
+#define CCU_MUX_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
+#define CCU_DIV_INIT(_shift, _width)	{ .shift = _shift, .width = _width }
+
+#define CCU_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,		\
+			_mask_gate, _flags)				\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON(_id, _name, _parent, spacemit_gate_init,	\
+			   _flags)					\
+	}								\
+}
+
+#define CCU_FACTOR_DEFINE(_id, _var, _name, _parent, _div, _mul)	\
+static struct ccu_mix _var = {						\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		CCU_COMMON(_id, _name, _parent, spacemit_factor_init,	\
+			   0)						\
+	}								\
+}
+
+#define CCU_MUX_DEFINE(_id, _var, _name, _parents, _num_p, _reg_ctrl,	\
+		       _shift, _width, _flags)				\
+static struct ccu_mix _var = {						\
+	.mux	= CCU_MUX_INIT(_shift, _width),				\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_init, _flags)		\
+	}								\
+}
+
+#define CCU_DIV_DEFINE(_id, _var, _name, _parent, _reg_ctrl, _shift,	\
+		       _width, _flags)					\
+static struct ccu_mix _var = {						\
+	.div	= CCU_DIV_INIT(_shift, _width),				\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON(_id, _name, _parent, spacemit_div_init,	\
+			   _flags)					\
+	}								\
+}
+
+#define CCU_FACTOR_GATE_FLAGS_DEFINE(_id, _var, _name, _parent,		\
+				     _reg_ctrl,	_mask_gate, _div, _mul,	\
+				     _flags)				\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON(_id, _name, _parent,				\
+			   spacemit_factor_gate_init, _flags)		\
+	}								\
+}
+
+#define CCU_FACTOR_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			       _mask_gate, _div, _mul)			\
+	CCU_FACTOR_GATE_FLAGS_DEFINE(_id, _var, _name, _parent,		\
+				     _reg_ctrl,	_mask_gate, _div, _mul,	\
+				     0)
+
+#define CCU_MUX_GATE_DEFINE(_id, _var, _name, _parents, _num_p,		\
+			    _reg_ctrl, _shift, _width, _mask_gate,	\
+			    _flags)					\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.mux	= CCU_MUX_INIT(_shift, _width),				\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_gate_init, _flags)	\
+	}								\
+}
+
+#define CCU_DIV_GATE_DEFINE(_id, _var, _name, _parent, _reg_ctrl,	\
+			    _shift, _width, _mask_gate,	_flags)		\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.div	= CCU_DIV_INIT(_shift, _width),				\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON(_id, _name, _parent,				\
+			   spacemit_div_gate_init, _flags)		\
+	}								\
+}
+
+#define CCU_MUX_DIV_GATE_DEFINE(_id, _var, _name, _parents, _num_p,	\
+				_reg_ctrl, _mshift, _mwidth, _muxshift,	\
+				_muxwidth, _mask_gate, _flags)		\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),			\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),			\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_div_gate_init, _flags)	\
+	},								\
+}
+
+#define CCU_MUX_DIV_GATE_SPLIT_FC_DEFINE(_id, _var, _name, _parents,	\
+					 _num_p, _reg_ctrl, _reg_fc,	\
+					 _mshift, _mwidth, _mask_fc,	\
+					 _muxshift, _muxwidth,		\
+					 _mask_gate, _flags)		\
+static struct ccu_mix _var = {						\
+	.gate	= CCU_GATE_INIT(_mask_gate),				\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),			\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),			\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		.reg_fc		= _reg_fc,				\
+		.mask_fc	= _mask_fc,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_div_gate_init, _flags)	\
+	},								\
+}
+
+#define CCU_MUX_DIV_FC_DEFINE(_id, _var, _name, _parents, _num_p,	\
+			      _reg_ctrl, _reg_fc, _mshift, _mwidth,	\
+			      _mask_fc,	_muxshift, _muxwidth, _flags)	\
+static struct ccu_mix _var = {						\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth),			\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),			\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		.reg_fc		= _reg_fc,				\
+		.mask_fc	= _mask_fc,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_div_init, _flags)	\
+	},								\
+}
+
+#define CCU_MUX_FC_DEFINE(_id, _var, _name, _parents, _num_p,		\
+			  _reg_ctrl, _reg_fc, _mask_fc, _muxshift,	\
+			  _muxwidth, _flags)				\
+static struct ccu_mix _var = {						\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),			\
+	.common = {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		.reg_fc		= _reg_fc,				\
+		.mask_fc	= _mask_fc,				\
+		CCU_COMMON_PARENTS(_id, _name, _parents, _num_p,	\
+				   spacemit_mux_init,			\
+				   _flags)				\
+	},								\
+}
+
+static inline struct ccu_mix *clk_to_ccu_mix(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	return container_of(common, struct ccu_mix, common);
+}
+
+int ccu_gate_enable(struct clk *clk);
+int ccu_gate_disable(struct clk *clk);
+
+int spacemit_gate_init(struct ccu_common *common);
+int spacemit_factor_init(struct ccu_common *common);
+int spacemit_mux_init(struct ccu_common *common);
+int spacemit_div_init(struct ccu_common *common);
+int spacemit_factor_gate_init(struct ccu_common *common);
+int spacemit_div_gate_init(struct ccu_common *common);
+int spacemit_mux_gate_init(struct ccu_common *common);
+int spacemit_mux_div_init(struct ccu_common *common);
+int spacemit_mux_div_gate_init(struct ccu_common *common);
+
+#endif /* _CLK_MIX_H_ */
diff --git a/drivers/clk/spacemit/clk_pll.c b/drivers/clk/spacemit/clk_pll.c
new file mode 100644
index 00000000000..56da70af58a
--- /dev/null
+++ b/drivers/clk/spacemit/clk_pll.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#include <dm/device.h>
+#include <regmap.h>
+#include <linux/bug.h>
+#include <linux/clk-provider.h>
+
+#include "clk_pll.h"
+
+#define UBOOT_DM_SPACEMIT_CLK_PLL "spacemit_clk_pll"
+
+#define PLL_TIMEOUT_US		3000
+#define PLL_DELAY_US		5
+
+#define PLL_SWCR3_EN		((u32)BIT(31))
+#define PLL_SWCR3_MASK		GENMASK(30, 0)
+
+static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *pll,
+							       unsigned long rate)
+{
+	struct ccu_pll_config *config = &pll->config;
+	const struct ccu_pll_rate_tbl *best_entry;
+	unsigned long best_delta = ULONG_MAX;
+	int i;
+
+	for (i = 0; i < config->tbl_num; i++) {
+		const struct ccu_pll_rate_tbl *entry = &config->rate_tbl[i];
+		unsigned long delta = abs(entry->rate - rate);
+
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_entry = entry;
+		}
+	}
+
+	return best_entry;
+}
+
+static const struct ccu_pll_rate_tbl *ccu_pll_lookup_matched_entry(struct ccu_pll *pll)
+{
+	struct ccu_pll_config *config = &pll->config;
+	u32 swcr1, swcr3;
+	int i;
+
+	swcr1 = ccu_read(&pll->common, swcr1);
+	swcr3 = ccu_read(&pll->common, swcr3);
+	swcr3 &= PLL_SWCR3_MASK;
+
+	for (i = 0; i < config->tbl_num; i++) {
+		const struct ccu_pll_rate_tbl *entry = &config->rate_tbl[i];
+
+		if (swcr1 == entry->swcr1 && swcr3 == entry->swcr3)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void ccu_pll_update_param(struct ccu_pll *pll, const struct ccu_pll_rate_tbl *entry)
+{
+	struct ccu_common *common = &pll->common;
+
+	regmap_write(common->regmap, common->reg_swcr1, entry->swcr1);
+	ccu_update(common, swcr3, PLL_SWCR3_MASK, entry->swcr3);
+}
+
+static int ccu_pll_enable(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	struct ccu_common *common = &pll->common;
+	unsigned int tmp;
+
+	ccu_update(common, swcr3, PLL_SWCR3_EN, PLL_SWCR3_EN);
+
+	/* check lock status */
+	return regmap_read_poll_timeout(common->lock_regmap,
+					pll->config.reg_lock,
+					tmp,
+					tmp & pll->config.mask_lock,
+					PLL_DELAY_US, PLL_TIMEOUT_US);
+}
+
+static int ccu_pll_disable(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	ccu_update(common, swcr3, PLL_SWCR3_EN, 0);
+
+	return 0;
+}
+
+/*
+ * PLLs must be gated before changing rate, which is ensured by
+ * flag CLK_SET_RATE_GATE.
+ */
+static unsigned long ccu_pll_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_best_rate(pll, rate);
+	ccu_pll_update_param(pll, entry);
+
+	return 0;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_matched_entry(pll);
+
+	WARN_ON_ONCE(!entry);
+
+	return entry ? entry->rate : 0;
+}
+
+static const struct clk_ops spacemit_clk_pll_ops = {
+	.enable = ccu_pll_enable,
+	.disable = ccu_pll_disable,
+	.set_rate = ccu_pll_set_rate,
+	.get_rate = ccu_pll_recalc_rate,
+};
+
+int spacemit_pll_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	int ret;
+
+	ret = clk_register(clk, UBOOT_DM_SPACEMIT_CLK_PLL,
+			   common->name, common->parents[0]);
+	if (ret)
+		return ret;
+
+	if (ccu_pll_lookup_matched_entry(pll))
+		return 0;
+
+	ccu_pll_disable(clk);
+	ccu_pll_update_param(pll, &pll->config.rate_tbl[0]);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(spacemit_clk_pll) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_PLL,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_pll_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_pll.h b/drivers/clk/spacemit/clk_pll.h
new file mode 100644
index 00000000000..6c684cf56b9
--- /dev/null
+++ b/drivers/clk/spacemit/clk_pll.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024-2025 Haylen Chu <heylenay@4d2.org>
+ * Copyright (c) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Copyright (c) 2025-2026 RISCStar Ltd.
+ *
+ *  Authors: Haylen Chu <heylenay@4d2.org>
+ */
+
+#ifndef _CLK_PLL_H_
+#define _CLK_PLL_H_
+
+#include <linux/clk-provider.h>
+
+#include "clk_common.h"
+
+/**
+ * struct ccu_pll_rate_tbl - Structure mapping between PLL rate and register
+ * configuration.
+ *
+ * @rate:	PLL rate
+ * @swcr1:	Register value of PLLX_SW1_CTRL (PLLx_SWCR1).
+ * @swcr3:	Register value of the PLLx_SW3_CTRL's lowest 31 bits of
+ *		PLLx_SW3_CTRL (PLLx_SWCR3). This highest bit is for enabling
+ *		the PLL and not contained in this field.
+ */
+struct ccu_pll_rate_tbl {
+	unsigned long rate;
+	u32 swcr1;
+	u32 swcr3;
+};
+
+#define CCU_PLL_RATE(_rate, _swcr1, _swcr3)	\
+	{					\
+		.rate	= _rate,		\
+		.swcr1	= _swcr1,		\
+		.swcr3	= _swcr3,		\
+	}
+
+struct ccu_pll_config {
+	const struct ccu_pll_rate_tbl *rate_tbl;
+	u32 tbl_num;
+	u32 reg_lock;
+	u32 mask_lock;
+};
+
+struct ccu_pll {
+	struct ccu_common	common;
+	struct ccu_pll_config	config;
+};
+
+#define CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock) \
+	{									\
+		.rate_tbl	= (_table),					\
+		.tbl_num	= sizeof(_table) / sizeof((_table)[0]),		\
+		.reg_lock	= (_reg_lock),					\
+		.mask_lock	= (_mask_lock),					\
+	}
+
+#define CCU_PLL_DEFINE(_id, _var, _name, _parent, _table, _reg_swcr1,		\
+		       _reg_swcr3, _reg_lock, _mask_lock, _flags)		\
+static struct ccu_pll _var = {							\
+	.config	= CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock),		\
+	.common = {								\
+		.reg_swcr1	= _reg_swcr1,					\
+		.reg_swcr3	= _reg_swcr3,					\
+		CCU_COMMON(_id, _name, _parent, spacemit_pll_init, _flags)	\
+	}									\
+}
+
+static inline struct ccu_pll *clk_to_ccu_pll(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+int spacemit_pll_init(struct ccu_common *common);
+
+#endif /* _CLK_PLL_H_ */
diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
new file mode 100644
index 00000000000..331cc1d35bb
--- /dev/null
+++ b/include/soc/spacemit/k1-syscon.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* SpacemiT clock and reset driver definitions for the K1 SoC */
+
+#ifndef __SOC_K1_SYSCON_H__
+#define __SOC_K1_SYSCON_H__
+
+/* APBS register offset */
+#define APBS_PLL1_SWCR1			0x100
+#define APBS_PLL1_SWCR2			0x104
+#define APBS_PLL1_SWCR3			0x108
+#define APBS_PLL2_SWCR1			0x118
+#define APBS_PLL2_SWCR2			0x11c
+#define APBS_PLL2_SWCR3			0x120
+#define APBS_PLL3_SWCR1			0x124
+#define APBS_PLL3_SWCR2			0x128
+#define APBS_PLL3_SWCR3			0x12c
+
+/* MPMU register offset */
+#define MPMU_POSR			0x0010
+#define MPMU_FCCR			0x0008
+#define  POSR_PLL1_LOCK			BIT(27)
+#define  POSR_PLL2_LOCK			BIT(28)
+#define  POSR_PLL3_LOCK			BIT(29)
+#define MPMU_SUCCR			0x0014
+#define MPMU_ISCCR			0x0044
+#define MPMU_WDTPCR			0x0200
+#define MPMU_RIPCCR			0x0210
+#define MPMU_ACGR			0x1024
+#define MPMU_APBCSCR			0x1050
+#define MPMU_SUCCR_1			0x10b0
+
+/* APBC register offset */
+#define APBC_UART1_CLK_RST		0x00
+#define APBC_UART2_CLK_RST		0x04
+#define APBC_GPIO_CLK_RST		0x08
+#define APBC_PWM0_CLK_RST		0x0c
+#define APBC_PWM1_CLK_RST		0x10
+#define APBC_PWM2_CLK_RST		0x14
+#define APBC_PWM3_CLK_RST		0x18
+#define APBC_TWSI8_CLK_RST		0x20
+#define APBC_UART3_CLK_RST		0x24
+#define APBC_RTC_CLK_RST		0x28
+#define APBC_TWSI0_CLK_RST		0x2c
+#define APBC_TWSI1_CLK_RST		0x30
+#define APBC_TIMERS1_CLK_RST		0x34
+#define APBC_TWSI2_CLK_RST		0x38
+#define APBC_AIB_CLK_RST		0x3c
+#define APBC_TWSI4_CLK_RST		0x40
+#define APBC_TIMERS2_CLK_RST		0x44
+#define APBC_ONEWIRE_CLK_RST		0x48
+#define APBC_TWSI5_CLK_RST		0x4c
+#define APBC_DRO_CLK_RST		0x58
+#define APBC_IR_CLK_RST			0x5c
+#define APBC_TWSI6_CLK_RST		0x60
+#define APBC_COUNTER_CLK_SEL		0x64
+#define APBC_TWSI7_CLK_RST		0x68
+#define APBC_TSEN_CLK_RST		0x6c
+#define APBC_UART4_CLK_RST		0x70
+#define APBC_UART5_CLK_RST		0x74
+#define APBC_UART6_CLK_RST		0x78
+#define APBC_SSP3_CLK_RST		0x7c
+#define APBC_SSPA0_CLK_RST		0x80
+#define APBC_SSPA1_CLK_RST		0x84
+#define APBC_IPC_AP2AUD_CLK_RST		0x90
+#define APBC_UART7_CLK_RST		0x94
+#define APBC_UART8_CLK_RST		0x98
+#define APBC_UART9_CLK_RST		0x9c
+#define APBC_CAN0_CLK_RST		0xa0
+#define APBC_PWM4_CLK_RST		0xa8
+#define APBC_PWM5_CLK_RST		0xac
+#define APBC_PWM6_CLK_RST		0xb0
+#define APBC_PWM7_CLK_RST		0xb4
+#define APBC_PWM8_CLK_RST		0xb8
+#define APBC_PWM9_CLK_RST		0xbc
+#define APBC_PWM10_CLK_RST		0xc0
+#define APBC_PWM11_CLK_RST		0xc4
+#define APBC_PWM12_CLK_RST		0xc8
+#define APBC_PWM13_CLK_RST		0xcc
+#define APBC_PWM14_CLK_RST		0xd0
+#define APBC_PWM15_CLK_RST		0xd4
+#define APBC_PWM16_CLK_RST		0xd8
+#define APBC_PWM17_CLK_RST		0xdc
+#define APBC_PWM18_CLK_RST		0xe0
+#define APBC_PWM19_CLK_RST		0xe4
+
+/* APMU register offset */
+#define APMU_JPG_CLK_RES_CTRL		0x020
+#define APMU_CSI_CCIC2_CLK_RES_CTRL	0x024
+#define APMU_ISP_CLK_RES_CTRL		0x038
+#define APMU_LCD_CLK_RES_CTRL1		0x044
+#define APMU_LCD_SPI_CLK_RES_CTRL	0x048
+#define APMU_LCD_CLK_RES_CTRL2		0x04c
+#define APMU_CCIC_CLK_RES_CTRL		0x050
+#define APMU_SDH0_CLK_RES_CTRL		0x054
+#define APMU_SDH1_CLK_RES_CTRL		0x058
+#define APMU_USB_CLK_RES_CTRL		0x05c
+#define APMU_QSPI_CLK_RES_CTRL		0x060
+#define APMU_DMA_CLK_RES_CTRL		0x064
+#define APMU_AES_CLK_RES_CTRL		0x068
+#define APMU_VPU_CLK_RES_CTRL		0x0a4
+#define APMU_GPU_CLK_RES_CTRL		0x0cc
+#define APMU_SDH2_CLK_RES_CTRL		0x0e0
+#define APMU_PMUA_MC_CTRL		0x0e8
+#define APMU_PMU_CC2_AP			0x100
+#define APMU_PMUA_EM_CLK_RES_CTRL	0x104
+#define APMU_AUDIO_CLK_RES_CTRL		0x14c
+#define APMU_HDMI_CLK_RES_CTRL		0x1b8
+#define APMU_CCI550_CLK_CTRL		0x300
+#define APMU_ACLK_CLK_CTRL		0x388
+#define APMU_CPU_C0_CLK_CTRL		0x38C
+#define APMU_CPU_C1_CLK_CTRL		0x390
+#define APMU_PCIE_CLK_RES_CTRL_0	0x3cc
+#define APMU_PCIE_CLK_RES_CTRL_1	0x3d4
+#define APMU_PCIE_CLK_RES_CTRL_2	0x3dc
+#define APMU_EMAC0_CLK_RES_CTRL		0x3e4
+#define APMU_EMAC1_CLK_RES_CTRL		0x3ec
+
+/* RCPU register offsets */
+#define RCPU_SSP0_CLK_RST		0x0028
+#define RCPU_I2C0_CLK_RST		0x0030
+#define RCPU_UART1_CLK_RST		0x003c
+#define RCPU_CAN_CLK_RST		0x0048
+#define RCPU_IR_CLK_RST			0x004c
+#define RCPU_UART0_CLK_RST		0x00d8
+#define AUDIO_HDMI_CLK_CTRL		0x2044
+
+/* RCPU2 register offsets */
+#define RCPU2_PWM0_CLK_RST		0x0000
+#define RCPU2_PWM1_CLK_RST		0x0004
+#define RCPU2_PWM2_CLK_RST		0x0008
+#define RCPU2_PWM3_CLK_RST		0x000c
+#define RCPU2_PWM4_CLK_RST		0x0010
+#define RCPU2_PWM5_CLK_RST		0x0014
+#define RCPU2_PWM6_CLK_RST		0x0018
+#define RCPU2_PWM7_CLK_RST		0x001c
+#define RCPU2_PWM8_CLK_RST		0x0020
+#define RCPU2_PWM9_CLK_RST		0x0024
+
+/* APBC2 register offsets */
+#define APBC2_UART1_CLK_RST		0x0000
+#define APBC2_SSP2_CLK_RST		0x0004
+#define APBC2_TWSI3_CLK_RST		0x0008
+#define APBC2_RTC_CLK_RST		0x000c
+#define APBC2_TIMERS0_CLK_RST		0x0010
+#define APBC2_KPC_CLK_RST		0x0014
+#define APBC2_GPIO_CLK_RST		0x001c
+
+#endif /* __SOC_K1_SYSCON_H__ */
-- 
2.25.1

