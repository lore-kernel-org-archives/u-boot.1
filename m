Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0188BC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 15:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC42A882FA;
	Sun, 19 May 2024 17:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZeyYnX2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ABF882D0; Sun, 19 May 2024 17:08:10 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE19C88303
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 17:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1edf506b216so50249355ad.2
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716131284; x=1716736084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQwPtoe7kjI22YMcw9/mTWJX/MFpz7PfvQmddf1LtWE=;
 b=ZeyYnX2PYTIcA0iqcsRsOslM858v5F/B9eHvH11ltRdmuieXbS8Zyb/dTEWO0/B4iT
 VEyvEO76MaLA6PU2BAIRShya9K5XuhTzW4aIHbdwYkVbi4+fYg0OgILXboXbOohvbwao
 j/rGLD9hInJSHVJa5lds3byQBP4BRjvePQPF2aIY8S/GblZxRbDwUTMIyvWBk3oEahIi
 HCilyWsBDsa54wbC3P1gmA50bab+loUn49uKLZTDQlxuhBiXXaecvzUe2SHp0svuKC2z
 byH49ASbFfJ7oFlMvlOTLdMgAc/+mI4qI9MSjE24Wki5LjFNtg7/AAeyNtjpI850FNBp
 f3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716131284; x=1716736084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQwPtoe7kjI22YMcw9/mTWJX/MFpz7PfvQmddf1LtWE=;
 b=TzkZB7mFZcRlJ6+jiiP7MJlDfy8QQS2FTI/nQFaGvRe6v3ni1XPoUJpVJfi7O/B2b/
 setTpiwGOLofjOy8xZMVzFowp44RBSpq7chbYl9eOGWO+zznUeYzjy1JLDC2sM8/6mWY
 Rp16W/W9sNXIJTGVBub4jpYOXRsgVewV5r8vUIuwUOQwsxw6ErvQwNOz1TqqB3th6oRj
 tbXz1lSiFACu1p65x87NMYmpFMqrk93pMwgkWDnA+2BQZutaoA/cV7Qhc2tvl+SuawRe
 XwAdeAn/+mqYR7do0chCIiLISugclwqTnFLRtnfmHg9vz1+boCtfpS1WfyYckPP72n1u
 D5tA==
X-Gm-Message-State: AOJu0YyHpMq60kiKJVyBRxAlAunLX+kNz3WLOd4b/Xdgy5LN3Vf3rjKf
 Y71tzhVfTRCjDl7qPyYNk35aJfv1IL+Mut7r/fZkhLBG8PBnmFhYkOu49U9thlY=
X-Google-Smtp-Source: AGHT+IHJXWJr3vscH5W3QjBjJg6j157vTGqxBdIIyF6eAEWoeycp3Js+kOtoIQrhodD7YLLSPoXaTA==
X-Received: by 2002:a05:6a20:12d3:b0:1af:a72f:4317 with SMTP id
 adf61e73a8af0-1afde201ce7mr28257501637.44.1716131283575; 
 Sun, 19 May 2024 08:08:03 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2b3493asm17692711b3a.191.2024.05.19.08.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 08:08:03 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 2/4] clk: sophgo: cv1800b: Add clock controller driver for
 cv1800b SoC
Date: Sun, 19 May 2024 23:07:08 +0800
Message-ID: <20240519150736.13203-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240519150736.13203-1-seashell11234455@gmail.com>
References: <20240519150736.13203-1-seashell11234455@gmail.com>
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

Add clock controller driver for sophgo cv1800b SoC

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 drivers/clk/Kconfig              |   1 +
 drivers/clk/Makefile             |   1 +
 drivers/clk/sophgo/Kconfig       |  14 +
 drivers/clk/sophgo/Makefile      |   6 +
 drivers/clk/sophgo/clk-common.h  |  74 +++
 drivers/clk/sophgo/clk-cv1800b.c | 794 +++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800b.h | 123 +++++
 drivers/clk/sophgo/clk-ip.c      | 594 +++++++++++++++++++++++
 drivers/clk/sophgo/clk-ip.h      | 288 +++++++++++
 drivers/clk/sophgo/clk-pll.c     | 284 +++++++++++
 drivers/clk/sophgo/clk-pll.h     |  74 +++
 11 files changed, 2253 insertions(+)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
 create mode 100644 drivers/clk/sophgo/clk-ip.c
 create mode 100644 drivers/clk/sophgo/clk-ip.h
 create mode 100644 drivers/clk/sophgo/clk-pll.c
 create mode 100644 drivers/clk/sophgo/clk-pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9acbc47fe8..d9d518d703 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -257,6 +257,7 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
+source "drivers/clk/sophgo/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/starfive/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 847b9b2911..f9b90a38b0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
+obj-$(CONFIG_CLK_SOPHGO) += sophgo/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
 obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
new file mode 100644
index 0000000000..59b51608fe
--- /dev/null
+++ b/drivers/clk/sophgo/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+config CLK_SOPHGO
+	bool
+
+config CLK_SOPHGO_CV1800B
+	bool "Sophgo CV1800B clock support"
+	depends on CLK
+	select CLK_CCF
+	select CLK_SOPHGO
+	help
+	  This enables support clock driver for Sophgo CV1800B SoC.
diff --git a/drivers/clk/sophgo/Makefile b/drivers/clk/sophgo/Makefile
new file mode 100644
index 0000000000..caec76222b
--- /dev/null
+++ b/drivers/clk/sophgo/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y += clk-ip.o clk-pll.o
+obj-$(CONFIG_CLK_SOPHGO_CV1800B) += clk-cv1800b.o
diff --git a/drivers/clk/sophgo/clk-common.h b/drivers/clk/sophgo/clk-common.h
new file mode 100644
index 0000000000..95b82e968d
--- /dev/null
+++ b/drivers/clk/sophgo/clk-common.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CLK_SOPHGO_COMMON_H__
+#define __CLK_SOPHGO_COMMON_H__
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+#define CV1800B_CLK_OSC 1
+#define CV1800B_CLK_BYPASS 2
+#define CV1800B_CLK_ID_TRANSFORM(_id) ((_id) + 3)
+
+struct cv1800b_clk_regbit {
+	u32 offset;
+	u8 shift;
+};
+
+struct cv1800b_clk_regfield {
+	u32 offset;
+	u8 shift;
+	u8 width;
+};
+
+#define CV1800B_CLK_REGBIT(_offset, _shift)	\
+	{					\
+		.offset = _offset,		\
+		.shift = _shift,		\
+	}
+
+#define CV1800B_CLK_REGFIELD(_offset, _shift, _width)	\
+	{						\
+		.offset = _offset,			\
+		.shift = _shift,			\
+		.width = _width,			\
+	}
+
+static inline u32 cv1800b_clk_getbit(void *base, struct cv1800b_clk_regbit *bit)
+{
+	return readl(base + bit->offset) & (BIT(bit->shift));
+}
+
+static inline u32 cv1800b_clk_setbit(void *base, struct cv1800b_clk_regbit *bit)
+{
+	return setbits_le32(base + bit->offset, BIT(bit->shift));
+}
+
+static inline u32 cv1800b_clk_clrbit(void *base, struct cv1800b_clk_regbit *bit)
+{
+	return clrbits_le32(base + bit->offset, BIT(bit->shift));
+}
+
+static inline u32 cv1800b_clk_getfield(void *base,
+				       struct cv1800b_clk_regfield *field)
+{
+	u32 mask = GENMASK(field->shift + field->width - 1, field->shift);
+
+	return (readl(base + field->offset) & mask) >> field->shift;
+}
+
+static inline void
+cv1800b_clk_setfield(void *base, struct cv1800b_clk_regfield *field, u32 val)
+{
+	u32 mask = GENMASK(field->shift + field->width - 1, field->shift);
+	u32 new_val = (readl(base + field->offset) & ~mask) |
+		      ((val << field->shift) & mask);
+
+	return writel(new_val, base + field->offset);
+}
+
+#endif /* __CLK_SOPHGO_COMMON_H__ */
diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
new file mode 100644
index 0000000000..a82deb44d3
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/clk-provider.h>
+
+#include "clk-common.h"
+#include "clk-cv1800b.h"
+#include "clk-ip.h"
+#include "clk-pll.h"
+
+struct gate_data {
+	u32 reg;
+	u8 shift;
+};
+
+struct div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	int initval;
+	u8 flags;
+};
+
+struct bypass_data {
+	u32 reg;
+	u8 shift;
+};
+
+struct mux_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+};
+
+#define CV1800B_DIV_FLAG (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST)
+
+static const char *const clk_cam_parents[] = {
+	"clk_cam0pll",
+	"clk_cam0pll_d2",
+	"clk_cam0pll_d3",
+	"clk_mipimpll_d3"
+};
+
+static const char *const clk_tpu_parents[] = {
+	"clk_tpll",
+	"clk_a0pll",
+	"clk_mipimpll",
+	"clk_fpll"
+};
+
+static const char *const clk_axi4_parents[] = { "clk_fpll", "clk_disppll" };
+static const char *const clk_aud_parents[] = { "clk_a0pll", "clk_a24m" };
+static const char *const clk_cam0_200_parents[] = { "osc", "clk_disppll" };
+
+static const char *const clk_vip_sys_parents[] = {
+	"clk_mipimpll",
+	"clk_cam0pll",
+	"clk_disppll",
+	"clk_fpll"
+};
+
+static const char *const clk_axi_video_codec_parents[] = {
+	"clk_a0pll",
+	"clk_mipimpll",
+	"clk_cam1pll",
+	"clk_fpll"
+};
+
+static const char *const clk_vc_src0_parents[] = {
+	"clk_disppll",
+	"clk_mipimpll",
+	"clk_cam1pll",
+	"clk_fpll"
+};
+
+static const struct cv1800b_mmux_parent_info clk_c906_0_parents[] = {
+	{ "clk_tpll", 0, 0 },
+	{ "clk_a0pll", 0, 1 },
+	{ "clk_mipimpll", 0, 2 },
+	{ "clk_mpll", 0, 3 },
+	{ "clk_fpll", 1, 0 },
+};
+
+static const struct cv1800b_mmux_parent_info clk_c906_1_parents[] = {
+	{ "clk_tpll", 0, 0 },
+	{ "clk_a0pll", 0, 1 },
+	{ "clk_disppll", 0, 2 },
+	{ "clk_mpll", 0, 3 },
+	{ "clk_fpll", 1, 0 },
+};
+
+static const struct cv1800b_mmux_parent_info clk_a53_parents[] = {
+	{ "clk_tpll", 0, 0 },
+	{ "clk_a0pll", 0, 1 },
+	{ "clk_mipimpll", 0, 2 },
+	{ "clk_mpll", 0, 3 },
+	{ "clk_fpll", 1, 0 },
+};
+
+static struct cv1800b_clk_gate cv1800b_gate_info[] = {
+	CV1800B_GATE(CLK_XTAL_AP, "clk_xtal_ap", "osc", REG_CLK_EN_0, 3,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_RTC_25M, "clk_rtc_25m", "osc", REG_CLK_EN_0, 8,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TEMPSEN, "clk_tempsen", "osc", REG_CLK_EN_0, 9, 0),
+	CV1800B_GATE(CLK_SARADC, "clk_saradc", "osc", REG_CLK_EN_0, 10, 0),
+	CV1800B_GATE(CLK_EFUSE, "clk_efuse", "osc", REG_CLK_EN_0, 11, 0),
+	CV1800B_GATE(CLK_APB_EFUSE, "clk_apb_efuse", "osc", REG_CLK_EN_0, 12,
+		     0),
+	CV1800B_GATE(CLK_DEBUG, "clk_debug", "osc", REG_CLK_EN_0, 13,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_XTAL_MISC, "clk_xtal_misc", "osc", REG_CLK_EN_0, 14,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_APB_WDT, "clk_apb_wdt", "osc", REG_CLK_EN_1, 7,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_WGN, "clk_wgn", "osc", REG_CLK_EN_3, 22, 0),
+	CV1800B_GATE(CLK_WGN0, "clk_wgn0", "osc", REG_CLK_EN_3, 23, 0),
+	CV1800B_GATE(CLK_WGN1, "clk_wgn1", "osc", REG_CLK_EN_3, 24, 0),
+	CV1800B_GATE(CLK_WGN2, "clk_wgn2", "osc", REG_CLK_EN_3, 25, 0),
+	CV1800B_GATE(CLK_KEYSCAN, "clk_keyscan", "osc", REG_CLK_EN_3, 26, 0),
+	CV1800B_GATE(CLK_TPU_FAB, "clk_tpu_fab", "clk_mipimpll", REG_CLK_EN_0,
+		     5, 0),
+	CV1800B_GATE(CLK_AHB_ROM, "clk_ahb_rom", "clk_axi4", REG_CLK_EN_0, 6,
+		     0),
+	CV1800B_GATE(CLK_AXI4_EMMC, "clk_axi4_emmc", "clk_axi4", REG_CLK_EN_0,
+		     15, 0),
+	CV1800B_GATE(CLK_AXI4_SD0, "clk_axi4_sd0", "clk_axi4", REG_CLK_EN_0, 18,
+		     0),
+	CV1800B_GATE(CLK_AXI4_SD1, "clk_axi4_sd1", "clk_axi4", REG_CLK_EN_0, 21,
+		     0),
+	CV1800B_GATE(CLK_AXI4_ETH0, "clk_axi4_eth0", "clk_axi4", REG_CLK_EN_0,
+		     26, 0),
+	CV1800B_GATE(CLK_AXI4_ETH1, "clk_axi4_eth1", "clk_axi4", REG_CLK_EN_0,
+		     28, 0),
+	CV1800B_GATE(CLK_AHB_SF, "clk_ahb_sf", "clk_axi4", REG_CLK_EN_1, 0, 0),
+	CV1800B_GATE(CLK_SDMA_AXI, "clk_sdma_axi", "clk_axi4", REG_CLK_EN_1, 1,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C, "clk_apb_i2c", "clk_axi4", REG_CLK_EN_1, 6,
+		     0),
+	CV1800B_GATE(CLK_APB_SPI0, "clk_apb_spi0", "clk_axi4", REG_CLK_EN_1, 9,
+		     0),
+	CV1800B_GATE(CLK_APB_SPI1, "clk_apb_spi1", "clk_axi4", REG_CLK_EN_1, 10,
+		     0),
+	CV1800B_GATE(CLK_APB_SPI2, "clk_apb_spi2", "clk_axi4", REG_CLK_EN_1, 11,
+		     0),
+	CV1800B_GATE(CLK_APB_SPI3, "clk_apb_spi3", "clk_axi4", REG_CLK_EN_1, 12,
+		     0),
+	CV1800B_GATE(CLK_APB_UART0, "clk_apb_uart0", "clk_axi4", REG_CLK_EN_1,
+		     15, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_APB_UART1, "clk_apb_uart1", "clk_axi4", REG_CLK_EN_1,
+		     17, 0),
+	CV1800B_GATE(CLK_APB_UART2, "clk_apb_uart2", "clk_axi4", REG_CLK_EN_1,
+		     19, 0),
+	CV1800B_GATE(CLK_APB_UART3, "clk_apb_uart3", "clk_axi4", REG_CLK_EN_1,
+		     21, 0),
+	CV1800B_GATE(CLK_APB_UART4, "clk_apb_uart4", "clk_axi4", REG_CLK_EN_1,
+		     23, 0),
+	CV1800B_GATE(CLK_APB_I2S0, "clk_apb_i2s0", "clk_axi4", REG_CLK_EN_1, 24,
+		     0),
+	CV1800B_GATE(CLK_APB_I2S1, "clk_apb_i2s1", "clk_axi4", REG_CLK_EN_1, 25,
+		     0),
+	CV1800B_GATE(CLK_APB_I2S2, "clk_apb_i2s2", "clk_axi4", REG_CLK_EN_1, 26,
+		     0),
+	CV1800B_GATE(CLK_APB_I2S3, "clk_apb_i2s3", "clk_axi4", REG_CLK_EN_1, 27,
+		     0),
+	CV1800B_GATE(CLK_AXI4_USB, "clk_axi4_usb", "clk_axi4", REG_CLK_EN_1, 28,
+		     0),
+	CV1800B_GATE(CLK_APB_USB, "clk_apb_usb", "clk_axi4", REG_CLK_EN_1, 29,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C0, "clk_apb_i2c0", "clk_axi4", REG_CLK_EN_3, 17,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C1, "clk_apb_i2c1", "clk_axi4", REG_CLK_EN_3, 18,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C2, "clk_apb_i2c2", "clk_axi4", REG_CLK_EN_3, 19,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C3, "clk_apb_i2c3", "clk_axi4", REG_CLK_EN_3, 20,
+		     0),
+	CV1800B_GATE(CLK_APB_I2C4, "clk_apb_i2c4", "clk_axi4", REG_CLK_EN_3, 21,
+		     0),
+	CV1800B_GATE(CLK_AHB_SF1, "clk_ahb_sf1", "clk_axi4", REG_CLK_EN_3, 27,
+		     0),
+	CV1800B_GATE(CLK_APB_AUDSRC, "clk_apb_audsrc", "clk_axi4", REG_CLK_EN_4,
+		     2, 0),
+	CV1800B_GATE(CLK_DDR_AXI_REG, "clk_ddr_axi_reg", "clk_axi6",
+		     REG_CLK_EN_0, 7, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_APB_GPIO, "clk_apb_gpio", "clk_axi6", REG_CLK_EN_0, 29,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_APB_GPIO_INTR, "clk_apb_gpio_intr", "clk_axi6",
+		     REG_CLK_EN_0, 30, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_APB_JPEG, "clk_apb_jpeg", "clk_axi6", REG_CLK_EN_2, 13,
+		     CLK_IGNORE_UNUSED),
+	CV1800B_GATE(CLK_APB_H264C, "clk_apb_h264c", "clk_axi6", REG_CLK_EN_2,
+		     14, 0),
+	CV1800B_GATE(CLK_APB_H265C, "clk_apb_h265c", "clk_axi6", REG_CLK_EN_2,
+		     15, 0),
+	CV1800B_GATE(CLK_PM, "clk_pm", "clk_axi6", REG_CLK_EN_3, 8,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_CFG_REG_VIP, "clk_cfg_reg_vip", "clk_axi6",
+		     REG_CLK_EN_3, 31, 0),
+	CV1800B_GATE(CLK_CFG_REG_VC, "clk_cfg_reg_vc", "clk_axi6", REG_CLK_EN_4,
+		     0, CLK_IGNORE_UNUSED),
+	CV1800B_GATE(CLK_PWM, "clk_pwm", "clk_pwm_src", REG_CLK_EN_1, 8,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_UART0, "clk_uart0", "clk_cam0_200", REG_CLK_EN_1, 14,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_UART1, "clk_uart1", "clk_cam0_200", REG_CLK_EN_1, 16,
+		     0),
+	CV1800B_GATE(CLK_UART2, "clk_uart2", "clk_cam0_200", REG_CLK_EN_1, 18,
+		     0),
+	CV1800B_GATE(CLK_UART3, "clk_uart3", "clk_cam0_200", REG_CLK_EN_1, 20,
+		     0),
+	CV1800B_GATE(CLK_UART4, "clk_uart4", "clk_cam0_200", REG_CLK_EN_1, 22,
+		     0),
+	CV1800B_GATE(CLK_H264C, "clk_h264c", "clk_axi_video_codec",
+		     REG_CLK_EN_2, 10, 0),
+	CV1800B_GATE(CLK_H265C, "clk_h265c", "clk_axi_video_codec",
+		     REG_CLK_EN_2, 11, 0),
+	CV1800B_GATE(CLK_JPEG, "clk_jpeg", "clk_axi_video_codec", REG_CLK_EN_2,
+		     12, CLK_IGNORE_UNUSED),
+	CV1800B_GATE(CLK_CSI_MAC0_VIP, "clk_csi_mac0_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 18, 0),
+	CV1800B_GATE(CLK_CSI_MAC1_VIP, "clk_csi_mac1_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 19, 0),
+	CV1800B_GATE(CLK_ISP_TOP_VIP, "clk_isp_top_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 20, 0),
+	CV1800B_GATE(CLK_IMG_D_VIP, "clk_img_d_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 21, 0),
+	CV1800B_GATE(CLK_IMG_V_VIP, "clk_img_v_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 22, 0),
+	CV1800B_GATE(CLK_SC_TOP_VIP, "clk_sc_top_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 23, 0),
+	CV1800B_GATE(CLK_SC_D_VIP, "clk_sc_d_vip", "clk_axi_vip", REG_CLK_EN_2,
+		     24, 0),
+	CV1800B_GATE(CLK_SC_V1_VIP, "clk_sc_v1_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 25, 0),
+	CV1800B_GATE(CLK_SC_V2_VIP, "clk_sc_v2_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 26, 0),
+	CV1800B_GATE(CLK_SC_V3_VIP, "clk_sc_v3_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 27, 0),
+	CV1800B_GATE(CLK_DWA_VIP, "clk_dwa_vip", "clk_axi_vip", REG_CLK_EN_2,
+		     28, 0),
+	CV1800B_GATE(CLK_BT_VIP, "clk_bt_vip", "clk_axi_vip", REG_CLK_EN_2, 29,
+		     0),
+	CV1800B_GATE(CLK_DISP_VIP, "clk_disp_vip", "clk_axi_vip", REG_CLK_EN_2,
+		     30, 0),
+	CV1800B_GATE(CLK_DSI_MAC_VIP, "clk_dsi_mac_vip", "clk_axi_vip",
+		     REG_CLK_EN_2, 31, 0),
+	CV1800B_GATE(CLK_LVDS0_VIP, "clk_lvds0_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 0, 0),
+	CV1800B_GATE(CLK_LVDS1_VIP, "clk_lvds1_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 1, 0),
+	CV1800B_GATE(CLK_CSI0_RX_VIP, "clk_csi0_rx_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 2, 0),
+	CV1800B_GATE(CLK_CSI1_RX_VIP, "clk_csi1_rx_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 3, 0),
+	CV1800B_GATE(CLK_PAD_VI_VIP, "clk_pad_vi_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 4, 0),
+	CV1800B_GATE(CLK_PAD_VI1_VIP, "clk_pad_vi1_vip", "clk_axi_vip",
+		     REG_CLK_EN_3, 30, 0),
+	CV1800B_GATE(CLK_PAD_VI2_VIP, "clk_pad_vi2_vip", "clk_axi_vip",
+		     REG_CLK_EN_4, 7, 0),
+	CV1800B_GATE(CLK_CSI_BE_VIP, "clk_csi_be_vip", "clk_axi_vip",
+		     REG_CLK_EN_4, 8, 0),
+	CV1800B_GATE(CLK_VIP_IP0, "clk_vip_ip0", "clk_axi_vip", REG_CLK_EN_4, 9,
+		     0),
+	CV1800B_GATE(CLK_VIP_IP1, "clk_vip_ip1", "clk_axi_vip", REG_CLK_EN_4,
+		     10, 0),
+	CV1800B_GATE(CLK_VIP_IP2, "clk_vip_ip2", "clk_axi_vip", REG_CLK_EN_4,
+		     11, 0),
+	CV1800B_GATE(CLK_VIP_IP3, "clk_vip_ip3", "clk_axi_vip", REG_CLK_EN_4,
+		     12, 0),
+	CV1800B_GATE(CLK_IVE_VIP, "clk_ive_vip", "clk_axi_vip", REG_CLK_EN_4,
+		     17, 0),
+	CV1800B_GATE(CLK_RAW_VIP, "clk_raw_vip", "clk_axi_vip", REG_CLK_EN_4,
+		     18, 0),
+	CV1800B_GATE(CLK_OSDC_VIP, "clk_osdc_vip", "clk_axi_vip", REG_CLK_EN_4,
+		     19, 0),
+	CV1800B_GATE(CLK_CSI_MAC2_VIP, "clk_csi_mac2_vip", "clk_axi_vip",
+		     REG_CLK_EN_4, 20, 0),
+	CV1800B_GATE(CLK_CAM0_VIP, "clk_cam0_vip", "clk_axi_vip", REG_CLK_EN_4,
+		     21, 0),
+	CV1800B_GATE(CLK_TIMER0, "clk_timer0", "clk_xtal_misc", REG_CLK_EN_3, 9,
+		     CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER1, "clk_timer1", "clk_xtal_misc", REG_CLK_EN_3,
+		     10, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER2, "clk_timer2", "clk_xtal_misc", REG_CLK_EN_3,
+		     11, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER3, "clk_timer3", "clk_xtal_misc", REG_CLK_EN_3,
+		     12, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER4, "clk_timer4", "clk_xtal_misc", REG_CLK_EN_3,
+		     13, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER5, "clk_timer5", "clk_xtal_misc", REG_CLK_EN_3,
+		     14, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER6, "clk_timer6", "clk_xtal_misc", REG_CLK_EN_3,
+		     15, CLK_IS_CRITICAL),
+	CV1800B_GATE(CLK_TIMER7, "clk_timer7", "clk_xtal_misc", REG_CLK_EN_3,
+		     16, CLK_IS_CRITICAL),
+};
+
+struct cv1800b_clk_div cv1800b_div_info[] = {
+	CV1800B_DIV(CLK_1M, "clk_1m", "osc", REG_CLK_EN_3, 5, REG_DIV_CLK_1M,
+		    16, 6, 25, CLK_IS_CRITICAL),
+	CV1800B_DIV(CLK_EMMC_100K, "clk_emmc_100k", "clk_1m", REG_CLK_EN_0, 17,
+		    REG_DIV_CLK_EMMC_100K, 16, 8, 10, 0),
+	CV1800B_DIV(CLK_SD0_100K, "clk_sd0_100k", "clk_1m", REG_CLK_EN_0, 20,
+		    REG_DIV_CLK_SD0_100K, 16, 8, 10, 0),
+	CV1800B_DIV(CLK_SD1_100K, "clk_sd1_100k", "clk_1m", REG_CLK_EN_0, 23,
+		    REG_DIV_CLK_SD1_100K, 16, 8, 10, 0),
+	CV1800B_DIV(CLK_GPIO_DB, "clk_gpio_db", "clk_1m", REG_CLK_EN_0, 31,
+		    REG_DIV_CLK_GPIO_DB, 16, 16, 10, CLK_IS_CRITICAL)
+};
+
+struct cv1800b_clk_bypass_div cv1800b_bypass_div_info[] = {
+	CV1800B_BYPASS_DIV(CLK_AP_DEBUG, "clk_ap_debug", "clk_fpll",
+			   REG_CLK_EN_4, 5, REG_DIV_CLK_AP_DEBUG, 16, 4, 5,
+			   REG_CLK_BYP_1, 4, CLK_IS_CRITICAL),
+	CV1800B_BYPASS_DIV(CLK_SRC_RTC_SYS_0, "clk_src_rtc_sys_0", "clk_fpll",
+			   REG_CLK_EN_4, 6, REG_DIV_CLK_RTCSYS_SRC_0, 16, 4, 5,
+			   REG_CLK_BYP_1, 5, CLK_IS_CRITICAL),
+	CV1800B_BYPASS_DIV(CLK_CPU_GIC, "clk_cpu_gic", "clk_fpll", REG_CLK_EN_0,
+			   2, REG_DIV_CLK_CPU_GIC, 16, 4, 5, REG_CLK_BYP_0, 2,
+			   CLK_IS_CRITICAL),
+	CV1800B_BYPASS_DIV(CLK_ETH0_500M, "clk_eth0_500m", "clk_fpll",
+			   REG_CLK_EN_0, 25, REG_DIV_CLK_GPIO_DB, 16, 4, 3,
+			   REG_CLK_BYP_0, 9, 0),
+	CV1800B_BYPASS_DIV(CLK_ETH1_500M, "clk_eth1_500m", "clk_fpll",
+			   REG_CLK_EN_0, 27, REG_DIV_CLK_GPIO_DB, 16, 4, 3,
+			   REG_CLK_BYP_0, 10, 0),
+	CV1800B_BYPASS_DIV(CLK_AXI6, "clk_axi6", "clk_fpll", REG_CLK_EN_2, 2,
+			   REG_DIV_CLK_AXI6, 16, 4, 15, REG_CLK_BYP_0, 20,
+			   CLK_IS_CRITICAL),
+	CV1800B_BYPASS_DIV(CLK_SPI, "clk_spi", "clk_fpll", REG_CLK_EN_3, 6,
+			   REG_DIV_CLK_SPI, 16, 6, 8, REG_CLK_BYP_0, 30, 0),
+	CV1800B_BYPASS_DIV(CLK_DISP_SRC_VIP, "clk_disp_src_vip", "clk_disppll",
+			   REG_CLK_EN_2, 7, REG_DIV_CLK_DISP_SRC_VIP, 16, 4, 8,
+			   REG_CLK_BYP_0, 25, 0),
+	CV1800B_BYPASS_DIV(CLK_CPU_AXI0, "clk_cpu_axi0", "clk_axi4",
+			   REG_CLK_EN_0, 1, REG_DIV_CLK_CPU_AXI0, 16, 4, 3,
+			   REG_CLK_BYP_0, 1, CLK_IS_CRITICAL),
+	CV1800B_BYPASS_DIV(CLK_DSI_ESC, "clk_dsi_esc", "clk_axi6", REG_CLK_EN_2,
+			   3, REG_DIV_CLK_DSI_ESC, 16, 4, 5, REG_CLK_BYP_0, 21,
+			   0),
+	CV1800B_BYPASS_DIV(CLK_I2C, "clk_i2c", "clk_axi6", REG_CLK_EN_3, 7,
+			   REG_DIV_CLK_I2C, 16, 4, 1, REG_CLK_BYP_0, 31, 0),
+};
+
+struct cv1800b_clk_fixed_div cv1800b_fixed_div_info[] = {
+	CV1800B_FIXED_DIV(CLK_CAM0PLL_D2, "clk_cam0pll_d2", "clk_cam0pll",
+			  REG_CAM0PLL_CLK_CSR, 1, 2,
+			  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+	CV1800B_FIXED_DIV(CLK_CAM0PLL_D3, "clk_cam0pll_d3", "clk_cam0pll",
+			  REG_CAM0PLL_CLK_CSR, 2, 3,
+			  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+	CV1800B_FIXED_DIV(CLK_MIPIMPLL_D3, "clk_mipimpll_d3", "clk_mipimpll",
+			  REG_MIPIMPLL_CLK_CSR, 2, 3,
+			  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+	CV1800B_FIXED_DIV(CLK_USB_33K, "clk_usb_33k", "clk_1m", REG_CLK_EN_1,
+			  31, 3, 0),
+};
+
+struct cv1800b_clk_bypass_fixed_div cv1800b_bypass_fixed_div_info[] = {
+	CV1800B_BYPASS_FIXED_DIV(CLK_USB_125M, "clk_usb_125m", "clk_fpll",
+				 REG_CLK_EN_1, 30, 12, REG_CLK_BYP_0, 17,
+				 CLK_SET_RATE_PARENT),
+	CV1800B_BYPASS_FIXED_DIV(CLK_USB_12M, "clk_usb_12m", "clk_fpll",
+				 REG_CLK_EN_2, 0, 125, REG_CLK_BYP_0, 18,
+				 CLK_SET_RATE_PARENT),
+	CV1800B_BYPASS_FIXED_DIV(CLK_VC_SRC1, "clk_vc_src1", "clk_fpll",
+				 REG_CLK_EN_3, 28, 2, REG_CLK_BYP_1, 0,
+				 CLK_SET_RATE_PARENT),
+	CV1800B_BYPASS_FIXED_DIV(CLK_VC_SRC2, "clk_vc_src2", "clk_fpll",
+				 REG_CLK_EN_4, 3, 3, REG_CLK_BYP_1, 3,
+				 CLK_SET_RATE_PARENT),
+};
+
+struct cv1800b_clk_mux cv1800b_mux_info[] = {
+	CV1800B_MUX(CLK_CAM0, "clk_cam0", clk_cam_parents, REG_CLK_EN_2, 16,
+		    REG_CLK_CAM0_SRC_DIV, 16, 6, 0, REG_CLK_CAM0_SRC_DIV, 8, 2,
+		    CLK_IGNORE_UNUSED),
+	CV1800B_MUX(CLK_CAM1, "clk_cam1", clk_cam_parents, REG_CLK_EN_2, 17,
+		    REG_CLK_CAM1_SRC_DIV, 16, 6, 0, REG_CLK_CAM1_SRC_DIV, 8, 2,
+		    CLK_IGNORE_UNUSED),
+};
+
+struct cv1800b_clk_bypass_mux cv1800b_bypass_mux_info[] = {
+	CV1800B_BYPASS_MUX(CLK_TPU, "clk_tpu", clk_tpu_parents, REG_CLK_EN_0, 4,
+			   REG_DIV_CLK_TPU, 16, 4, 3, REG_DIV_CLK_TPU, 8, 2,
+			   REG_CLK_BYP_0, 3, 0),
+	CV1800B_BYPASS_MUX(CLK_EMMC, "clk_emmc", clk_axi4_parents, REG_CLK_EN_0,
+			   16, REG_DIV_CLK_EMMC, 16, 5, 15, REG_DIV_CLK_EMMC, 8,
+			   2, REG_CLK_BYP_0, 5, 0),
+	CV1800B_BYPASS_MUX(CLK_SD0, "clk_sd0", clk_axi4_parents, REG_CLK_EN_0,
+			   19, REG_DIV_CLK_SD0, 16, 5, 15, REG_DIV_CLK_SD0, 8,
+			   2, REG_CLK_BYP_0, 6, 0),
+	CV1800B_BYPASS_MUX(CLK_SD1, "clk_sd1", clk_axi4_parents, REG_CLK_EN_0,
+			   22, REG_DIV_CLK_SD1, 16, 5, 15, REG_DIV_CLK_SD1, 8,
+			   2, REG_CLK_BYP_0, 7, 0),
+	CV1800B_BYPASS_MUX(CLK_SPI_NAND, "clk_spi_nand", clk_axi4_parents,
+			   REG_CLK_EN_0, 24, REG_DIV_CLK_SPI_NAND, 16, 5, 8,
+			   REG_DIV_CLK_SPI_NAND, 8, 2, REG_CLK_BYP_0, 8, 0),
+	CV1800B_BYPASS_MUX(CLK_AXI4, "clk_axi4", clk_axi4_parents, REG_CLK_EN_2,
+			   1, REG_DIV_CLK_AXI4, 16, 4, 5, REG_DIV_CLK_AXI4, 8,
+			   2, REG_CLK_BYP_0, 19, CLK_IS_CRITICAL),
+	CV1800B_BYPASS_MUX(CLK_PWM_SRC, "clk_pwm_src", clk_axi4_parents,
+			   REG_CLK_EN_4, 4, REG_DIV_CLK_PWM_SRC_0, 16, 6, 10,
+			   REG_DIV_CLK_PWM_SRC_0, 8, 2, REG_CLK_BYP_0, 15,
+			   CLK_IS_CRITICAL),
+	CV1800B_BYPASS_MUX(CLK_AUDSRC, "clk_audsrc", clk_aud_parents,
+			   REG_CLK_EN_4, 1, REG_DIV_CLK_AUDSRC, 16, 8, 18,
+			   REG_DIV_CLK_AUDSRC, 8, 2, REG_CLK_BYP_1, 2, 0),
+	CV1800B_BYPASS_MUX(CLK_SDMA_AUD0, "clk_sdma_aud0", clk_aud_parents,
+			   REG_CLK_EN_1, 2, REG_DIV_CLK_SDMA_AUD0, 16, 8, 18,
+			   REG_DIV_CLK_SDMA_AUD0, 8, 2, REG_CLK_BYP_0, 11, 0),
+	CV1800B_BYPASS_MUX(CLK_SDMA_AUD1, "clk_sdma_aud1", clk_aud_parents,
+			   REG_CLK_EN_1, 3, REG_DIV_CLK_SDMA_AUD1, 16, 8, 18,
+			   REG_DIV_CLK_SDMA_AUD1, 8, 2, REG_CLK_BYP_0, 12, 0),
+	CV1800B_BYPASS_MUX(CLK_SDMA_AUD2, "clk_sdma_aud2", clk_aud_parents,
+			   REG_CLK_EN_1, 3, REG_DIV_CLK_SDMA_AUD2, 16, 8, 18,
+			   REG_DIV_CLK_SDMA_AUD2, 8, 2, REG_CLK_BYP_0, 13, 0),
+	CV1800B_BYPASS_MUX(CLK_SDMA_AUD3, "clk_sdma_aud3", clk_aud_parents,
+			   REG_CLK_EN_1, 3, REG_DIV_CLK_SDMA_AUD3, 16, 8, 18,
+			   REG_DIV_CLK_SDMA_AUD3, 8, 2, REG_CLK_BYP_0, 14, 0),
+	CV1800B_BYPASS_MUX(CLK_CAM0_200, "clk_cam0_200", clk_cam0_200_parents,
+			   REG_CLK_EN_1, 13, REG_DIV_CLK_CAM0_200, 16, 4, 1,
+			   REG_DIV_CLK_CAM0_200, 8, 2, REG_CLK_BYP_0, 16,
+			   CLK_IS_CRITICAL),
+	CV1800B_BYPASS_MUX(CLK_AXI_VIP, "clk_axi_vip", clk_vip_sys_parents,
+			   REG_CLK_EN_2, 4, REG_DIV_CLK_AXI_VIP, 16, 4, 3,
+			   REG_DIV_CLK_AXI_VIP, 8, 2, REG_CLK_BYP_0, 22, 0),
+	CV1800B_BYPASS_MUX(CLK_SRC_VIP_SYS_0, "clk_src_vip_sys_0", clk_vip_sys_parents,
+			   REG_CLK_EN_2, 5, REG_DIV_CLK_SRC_VIP_SYS_0, 16, 4, 6,
+			   REG_DIV_CLK_SRC_VIP_SYS_0, 8, 2, REG_CLK_BYP_0, 23, 0),
+	CV1800B_BYPASS_MUX(CLK_SRC_VIP_SYS_1, "clk_src_vip_sys_1", clk_vip_sys_parents,
+			   REG_CLK_EN_2, 6, REG_DIV_CLK_SRC_VIP_SYS_1, 16, 4, 6,
+			   REG_DIV_CLK_SRC_VIP_SYS_1, 8, 2, REG_CLK_BYP_0, 24, 0),
+	CV1800B_BYPASS_MUX(CLK_SRC_VIP_SYS_2, "clk_src_vip_sys_2", clk_vip_sys_parents,
+			   REG_CLK_EN_3, 29, REG_DIV_CLK_SRC_VIP_SYS_2, 16, 4, 2,
+			   REG_DIV_CLK_SRC_VIP_SYS_2, 8, 2, REG_CLK_BYP_1, 1, 0),
+	CV1800B_BYPASS_MUX(CLK_SRC_VIP_SYS_3, "clk_src_vip_sys_3", clk_vip_sys_parents,
+			   REG_CLK_EN_4, 15, REG_DIV_CLK_SRC_VIP_SYS_3, 16, 4, 2,
+			   REG_DIV_CLK_SRC_VIP_SYS_3, 8, 2, REG_CLK_BYP_1, 8, 0),
+	CV1800B_BYPASS_MUX(CLK_SRC_VIP_SYS_4, "clk_src_vip_sys_4", clk_vip_sys_parents,
+			   REG_CLK_EN_4, 16, REG_DIV_CLK_SRC_VIP_SYS_4, 16, 4, 3,
+			   REG_DIV_CLK_SRC_VIP_SYS_4, 8, 2, REG_CLK_BYP_1, 9, 0),
+	CV1800B_BYPASS_MUX(CLK_AXI_VIDEO_CODEC, "clk_axi_video_codec",
+			   clk_axi_video_codec_parents, REG_CLK_EN_2, 8,
+			   REG_DIV_CLK_AXI_VIDEO_CODEC, 16, 4, 2,
+			   REG_DIV_CLK_AXI_VIDEO_CODEC, 8, 2, REG_CLK_BYP_0, 26,
+			   0),
+	CV1800B_BYPASS_MUX(CLK_VC_SRC0, "clk_vc_src0", clk_vc_src0_parents,
+			   REG_CLK_EN_2, 9, REG_DIV_CLK_VC_SRC0, 16, 4, 2,
+			   REG_DIV_CLK_VC_SRC0, 8, 2, REG_CLK_BYP_0, 27, 0),
+};
+
+struct cv1800b_clk_mmux cv1800b_mmux_info[] = {
+	CV1800B_MMUX(CLK_C906_0, "clk_c906_0", clk_c906_0_parents,
+		     REG_CLK_EN_4, 13,
+		     REG_DIV_CLK_C906_0_0, 16, 4, 1,
+		     REG_DIV_CLK_C906_0_1, 16, 4, 2,
+		     REG_DIV_CLK_C906_0_0, 8, 2,
+		     REG_DIV_CLK_C906_0_1, 8, 2,
+		     REG_CLK_BYP_1, 6,
+		     REG_CLK_SEL_0, 23,
+		     CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE),
+	CV1800B_MMUX(CLK_C906_1, "clk_c906_1", clk_c906_1_parents,
+		     REG_CLK_EN_4, 14,
+		     REG_DIV_CLK_C906_1_0, 16, 4, 2,
+		     REG_DIV_CLK_C906_1_1, 16, 4, 3,
+		     REG_DIV_CLK_C906_1_0, 8, 2,
+		     REG_DIV_CLK_C906_1_1, 8, 2,
+		     REG_CLK_BYP_1, 7,
+		     REG_CLK_SEL_0, 24,
+		     CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE),
+	CV1800B_MMUX(CLK_A53, "clk_a53", clk_a53_parents,
+		     REG_CLK_EN_0, 0,
+		     REG_DIV_CLK_A53_0, 16, 4, 1,
+		     REG_DIV_CLK_A53_1, 16, 4, 2,
+		     REG_DIV_CLK_A53_0, 8, 2,
+		     REG_DIV_CLK_A53_1, 8, 2,
+		     REG_CLK_BYP_0, 0,
+		     REG_CLK_SEL_0, 0,
+		     CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE),
+};
+
+static struct cv1800b_clk_audio cv1800b_audio_info[] = {
+	CV1800B_AUDIO(CLK_A24M, "clk_a24m", "clk_mipimpll",
+		      REG_APLL_FRAC_DIV_CTRL, 0,
+		      REG_APLL_FRAC_DIV_CTRL, 3,
+		      REG_APLL_FRAC_DIV_CTRL, 1,
+		      REG_APLL_FRAC_DIV_CTRL, 2,
+		      REG_APLL_FRAC_DIV_M, 0, 22,
+		      REG_APLL_FRAC_DIV_N, 0, 22,
+		      0),
+};
+
+static struct cv1800b_clk_ipll cv1800b_ipll_info[] = {
+	CV1800B_IPLL(CLK_FPLL, "clk_fpll", "osc", REG_FPLL_CSR, REG_PLL_G6_CTRL,
+		     8, REG_PLL_G6_STATUS, 2, CLK_IS_CRITICAL),
+	CV1800B_IPLL(CLK_MIPIMPLL, "clk_mipimpll", "osc", REG_MIPIMPLL_CSR,
+		     REG_PLL_G2_CTRL, 0, REG_PLL_G2_STATUS, 0, CLK_IS_CRITICAL),
+};
+
+static struct cv1800b_clk_fpll cv1800b_fpll_info[] = {
+	CV1800B_FPLL(CLK_MPLL, "clk_mpll", "osc", REG_MPLL_CSR, REG_PLL_G6_CTRL,
+		     0, REG_PLL_G6_STATUS, 0, REG_PLL_G6_SSC_SYN_CTRL, 2,
+		     REG_PLL_G6_SSC_SYN_CTRL, 0, REG_MPLL_SSC_SYN_CTRL,
+		     REG_MPLL_SSC_SYN_SET, CLK_IS_CRITICAL),
+	CV1800B_FPLL(CLK_TPLL, "clk_tpll", "osc", REG_TPLL_CSR, REG_PLL_G6_CTRL,
+		     4, REG_PLL_G6_STATUS, 1, REG_PLL_G6_SSC_SYN_CTRL, 3,
+		     REG_PLL_G6_SSC_SYN_CTRL, 0, REG_TPLL_SSC_SYN_CTRL,
+		     REG_TPLL_SSC_SYN_SET, CLK_IS_CRITICAL),
+	CV1800B_FPLL(CLK_A0PLL, "clk_a0pll", "clk_mipimpll", REG_A0PLL_CSR,
+		     REG_PLL_G2_CTRL, 4, REG_PLL_G2_STATUS, 1,
+		     REG_PLL_G2_SSC_SYN_CTRL, 2, REG_PLL_G2_SSC_SYN_CTRL, 0,
+		     REG_A0PLL_SSC_SYN_CTRL, REG_A0PLL_SSC_SYN_SET,
+		     CLK_IS_CRITICAL),
+	CV1800B_FPLL(CLK_DISPPLL, "clk_disppll", "clk_mipimpll",
+		     REG_DISPPLL_CSR, REG_PLL_G2_CTRL, 8, REG_PLL_G2_STATUS, 2,
+		     REG_PLL_G2_SSC_SYN_CTRL, 3, REG_PLL_G2_SSC_SYN_CTRL, 0,
+		     REG_DISPPLL_SSC_SYN_CTRL, REG_DISPPLL_SSC_SYN_SET,
+		     CLK_IS_CRITICAL),
+	CV1800B_FPLL(CLK_CAM0PLL, "clk_cam0pll", "clk_mipimpll",
+		     REG_CAM0PLL_CSR, REG_PLL_G2_CTRL, 12, REG_PLL_G2_STATUS, 3,
+		     REG_PLL_G2_SSC_SYN_CTRL, 4, REG_PLL_G2_SSC_SYN_CTRL, 0,
+		     REG_CAM0PLL_SSC_SYN_CTRL, REG_CAM0PLL_SSC_SYN_SET,
+		     CLK_IGNORE_UNUSED),
+	CV1800B_FPLL(CLK_CAM1PLL, "clk_cam1pll", "clk_mipimpll",
+		     REG_CAM1PLL_CSR, REG_PLL_G2_CTRL, 16, REG_PLL_G2_STATUS, 4,
+		     REG_PLL_G2_SSC_SYN_CTRL, 5, REG_PLL_G2_SSC_SYN_CTRL, 0,
+		     REG_CAM1PLL_SSC_SYN_CTRL, REG_CAM1PLL_SSC_SYN_SET,
+		     CLK_IS_CRITICAL),
+};
+
+static int cv1800b_register_clk(struct udevice *dev)
+{
+	struct clk osc;
+	ulong osc_rate;
+	void *base = devfdt_get_addr_ptr(dev);
+	int i, ret;
+
+	ret = clk_get_by_index(dev, 0, &osc);
+	if (ret) {
+		pr_err("Failed to get clock\n");
+		return ret;
+	}
+
+	osc_rate = clk_get_rate(&osc);
+	clk_dm(CV1800B_CLK_OSC, clk_register_fixed_rate(NULL, "osc", osc_rate));
+	clk_dm(CV1800B_CLK_BYPASS,
+	       clk_register_fixed_rate(NULL, "bypass", osc_rate));
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_ipll_info); i++) {
+		struct cv1800b_clk_ipll *ipll = &cv1800b_ipll_info[i];
+
+		ipll->base = base;
+		ret = clk_register(&ipll->clk, "cv1800b_clk_ipll", ipll->name,
+				   ipll->parent_name);
+		if (ret) {
+			pr_err("Failed to register ipll %s\n", ipll->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_fpll_info); i++) {
+		struct cv1800b_clk_fpll *fpll = &cv1800b_fpll_info[i];
+
+		fpll->ipll.base = base;
+		ret = clk_register(&fpll->ipll.clk, "cv1800b_clk_fpll",
+				   fpll->ipll.name, fpll->ipll.parent_name);
+		if (ret) {
+			pr_err("Failed to register fpll %s\n", fpll->ipll.name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_div_info); i++) {
+		struct cv1800b_clk_div *div = &cv1800b_div_info[i];
+
+		div->base = base;
+		ret = clk_register(&div->clk, "cv1800b_clk_div", div->name,
+				   div->parent_name);
+		if (ret) {
+			pr_err("Failed to register div %s\n", div->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_fixed_div_info); i++) {
+		struct cv1800b_clk_fixed_div *fixed_div =
+			&cv1800b_fixed_div_info[i];
+
+		fixed_div->base = base;
+		ret = clk_register(&fixed_div->clk, "cv1800b_clk_fixed_div",
+				   fixed_div->name, fixed_div->parent_name);
+		if (ret) {
+			pr_err("Failed to register fixed div %s\n",
+			       fixed_div->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_bypass_fixed_div_info); i++) {
+		struct cv1800b_clk_bypass_fixed_div *bypass_fixed_div =
+			&cv1800b_bypass_fixed_div_info[i];
+
+		bypass_fixed_div->div.base = base;
+		ret = clk_register(&bypass_fixed_div->div.clk,
+				   "cv1800b_clk_bypass_fixed_div",
+				   bypass_fixed_div->div.name,
+				   bypass_fixed_div->div.parent_name);
+		if (ret) {
+			pr_err("Failed to register bypass fixed div %s\n",
+			       bypass_fixed_div->div.name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_mux_info); i++) {
+		struct cv1800b_clk_mux *mux = &cv1800b_mux_info[i];
+		int parent;
+
+		mux->base = base;
+		parent = cv1800b_clk_getfield(base, &mux->mux);
+		ret = clk_register(&mux->clk, "cv1800b_clk_mux", mux->name,
+				   mux->parent_names[parent]);
+		if (ret) {
+			pr_err("Failed to register mux %s\n", mux->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_mmux_info); i++) {
+		struct cv1800b_clk_mmux *mmux = &cv1800b_mmux_info[i];
+		int clk_sel, parent, idx;
+
+		mmux->base = base;
+		clk_sel = cv1800b_clk_getbit(base, &mmux->clk_sel) ? 0 : 1;
+		parent = cv1800b_clk_getfield(base, &mmux->mux[clk_sel]);
+		for (idx = 0; idx < mmux->num_parents; idx++) {
+			if (clk_sel == mmux->parent_infos[idx].clk_sel &&
+			    parent == mmux->parent_infos[idx].index)
+				break;
+		}
+		ret = clk_register(&mmux->clk, "cv1800b_clk_mmux", mmux->name,
+				   mmux->parent_infos[idx].name);
+		if (ret) {
+			pr_err("Failed to register mmux %s\n", mmux->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_audio_info); i++) {
+		struct cv1800b_clk_audio *audio = &cv1800b_audio_info[i];
+
+		audio->base = base;
+		ret = clk_register(&audio->clk, "cv1800b_clk_audio",
+				   audio->name, audio->parent_name);
+		if (ret) {
+			pr_err("Failed to register audio %s\n", audio->name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_bypass_mux_info); i++) {
+		struct cv1800b_clk_bypass_mux *bypass_mux =
+			&cv1800b_bypass_mux_info[i];
+		int parent;
+
+		bypass_mux->mux.base = base;
+		parent = cv1800b_clk_getfield(base, &bypass_mux->mux.mux);
+		ret = clk_register(&bypass_mux->mux.clk,
+				   "cv1800b_clk_bypass_mux",
+				   bypass_mux->mux.name,
+				   bypass_mux->mux.parent_names[parent]);
+		if (ret) {
+			pr_err("Failed to register bypass mux %s\n",
+			       bypass_mux->mux.name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_bypass_div_info); i++) {
+		struct cv1800b_clk_bypass_div *bypass_div =
+			&cv1800b_bypass_div_info[i];
+
+		bypass_div->div.base = base;
+		ret = clk_register(&bypass_div->div.clk,
+				   "cv1800b_clk_bypass_div",
+				   bypass_div->div.name,
+				   bypass_div->div.parent_name);
+		if (ret) {
+			pr_err("Failed to register bypass div %s\n",
+			       bypass_div->div.name);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cv1800b_gate_info); i++) {
+		struct cv1800b_clk_gate *gate = &cv1800b_gate_info[i];
+
+		gate->base = base;
+		ret = clk_register(&gate->clk, "cv1800b_clk_gate", gate->name,
+				   gate->parent_name);
+		if (ret) {
+			pr_err("Failed to register gate %s\n", gate->name);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int cv1800b_clk_probe(struct udevice *dev)
+{
+	return cv1800b_register_clk(dev);
+}
+
+static int cv1800b_clk_enable(struct clk *clk)
+{
+	struct clk *c;
+	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
+
+	if (err)
+		return err;
+	return clk_enable(c);
+}
+
+static int cv1800b_clk_disable(struct clk *clk)
+{
+	struct clk *c;
+	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
+
+	if (err)
+		return err;
+	return clk_disable(c);
+}
+
+static ulong cv1800b_clk_get_rate(struct clk *clk)
+{
+	struct clk *c;
+	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
+
+	if (err)
+		return err;
+	return clk_get_rate(c);
+}
+
+static ulong cv1800b_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk *c;
+	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
+
+	if (err)
+		return err;
+	return clk_set_rate(c, rate);
+}
+
+static int cv1800b_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk *c, *p;
+	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
+
+	if (err)
+		return err;
+	err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(parent->id), &p);
+	if (err)
+		return err;
+	return clk_set_parent(c, p);
+}
+
+const struct clk_ops cv1800b_clk_ops = {
+	.enable = cv1800b_clk_enable,
+	.disable = cv1800b_clk_disable,
+	.get_rate = cv1800b_clk_get_rate,
+	.set_rate = cv1800b_clk_set_rate,
+	.set_parent = cv1800b_clk_set_parent,
+};
+
+static const struct udevice_id cv1800b_clk_of_match[] = {
+	{ .compatible = "sophgo,cv1800-clk" },
+	{ },
+};
+
+U_BOOT_DRIVER(sophgo_clk) = {
+	.name      = "cv1800b_clk",
+	.id        = UCLASS_CLK,
+	.of_match  = cv1800b_clk_of_match,
+	.probe     = cv1800b_clk_probe,
+	.ops       = &cv1800b_clk_ops,
+	.flags	   = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/sophgo/clk-cv1800b.h b/drivers/clk/sophgo/clk-cv1800b.h
new file mode 100644
index 0000000000..1e7107b5d0
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv1800b.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _CLK_SOPHGO_CV1800_H_
+#define _CLK_SOPHGO_CV1800_H_
+
+#include <dt-bindings/clock/sophgo,cv1800.h>
+
+#define CV1800_CLK_MAX			(CLK_XTAL_AP + 1)
+#define CV1810_CLK_MAX			(CLK_DISP_SRC_VIP + 1)
+
+#define REG_PLL_G2_CTRL			0x800
+#define REG_PLL_G2_STATUS		0x804
+#define REG_MIPIMPLL_CSR		0x808
+#define REG_A0PLL_CSR			0x80C
+#define REG_DISPPLL_CSR			0x810
+#define REG_CAM0PLL_CSR			0x814
+#define REG_CAM1PLL_CSR			0x818
+#define REG_PLL_G2_SSC_SYN_CTRL		0x840
+#define REG_A0PLL_SSC_SYN_CTRL		0x850
+#define REG_A0PLL_SSC_SYN_SET		0x854
+#define REG_A0PLL_SSC_SYN_SPAN		0x858
+#define REG_A0PLL_SSC_SYN_STEP		0x85C
+#define REG_DISPPLL_SSC_SYN_CTRL	0x860
+#define REG_DISPPLL_SSC_SYN_SET		0x864
+#define REG_DISPPLL_SSC_SYN_SPAN	0x868
+#define REG_DISPPLL_SSC_SYN_STEP	0x86C
+#define REG_CAM0PLL_SSC_SYN_CTRL	0x870
+#define REG_CAM0PLL_SSC_SYN_SET		0x874
+#define REG_CAM0PLL_SSC_SYN_SPAN	0x878
+#define REG_CAM0PLL_SSC_SYN_STEP	0x87C
+#define REG_CAM1PLL_SSC_SYN_CTRL	0x880
+#define REG_CAM1PLL_SSC_SYN_SET		0x884
+#define REG_CAM1PLL_SSC_SYN_SPAN	0x888
+#define REG_CAM1PLL_SSC_SYN_STEP	0x88C
+#define REG_APLL_FRAC_DIV_CTRL		0x890
+#define REG_APLL_FRAC_DIV_M		0x894
+#define REG_APLL_FRAC_DIV_N		0x898
+#define REG_MIPIMPLL_CLK_CSR		0x8A0
+#define REG_A0PLL_CLK_CSR		0x8A4
+#define REG_DISPPLL_CLK_CSR		0x8A8
+#define REG_CAM0PLL_CLK_CSR		0x8AC
+#define REG_CAM1PLL_CLK_CSR		0x8B0
+#define REG_CLK_CAM0_SRC_DIV		0x8C0
+#define REG_CLK_CAM1_SRC_DIV		0x8C4
+
+/* top_pll_g6 */
+#define REG_PLL_G6_CTRL			0x900
+#define REG_PLL_G6_STATUS		0x904
+#define REG_MPLL_CSR			0x908
+#define REG_TPLL_CSR			0x90C
+#define REG_FPLL_CSR			0x910
+#define REG_PLL_G6_SSC_SYN_CTRL		0x940
+#define REG_DPLL_SSC_SYN_CTRL		0x950
+#define REG_DPLL_SSC_SYN_SET		0x954
+#define REG_DPLL_SSC_SYN_SPAN		0x958
+#define REG_DPLL_SSC_SYN_STEP		0x95C
+#define REG_MPLL_SSC_SYN_CTRL		0x960
+#define REG_MPLL_SSC_SYN_SET		0x964
+#define REG_MPLL_SSC_SYN_SPAN		0x968
+#define REG_MPLL_SSC_SYN_STEP		0x96C
+#define REG_TPLL_SSC_SYN_CTRL		0x970
+#define REG_TPLL_SSC_SYN_SET		0x974
+#define REG_TPLL_SSC_SYN_SPAN		0x978
+#define REG_TPLL_SSC_SYN_STEP		0x97C
+
+/* clkgen */
+#define REG_CLK_EN_0			0x000
+#define REG_CLK_EN_1			0x004
+#define REG_CLK_EN_2			0x008
+#define REG_CLK_EN_3			0x00C
+#define REG_CLK_EN_4			0x010
+#define REG_CLK_SEL_0			0x020
+#define REG_CLK_BYP_0			0x030
+#define REG_CLK_BYP_1			0x034
+
+#define REG_DIV_CLK_A53_0		0x040
+#define REG_DIV_CLK_A53_1		0x044
+#define REG_DIV_CLK_CPU_AXI0		0x048
+#define REG_DIV_CLK_CPU_GIC		0x050
+#define REG_DIV_CLK_TPU			0x054
+#define REG_DIV_CLK_EMMC		0x064
+#define REG_DIV_CLK_EMMC_100K		0x06C
+#define REG_DIV_CLK_SD0			0x070
+#define REG_DIV_CLK_SD0_100K		0x078
+#define REG_DIV_CLK_SD1			0x07C
+#define REG_DIV_CLK_SD1_100K		0x084
+#define REG_DIV_CLK_SPI_NAND		0x088
+#define REG_DIV_CLK_ETH0_500M		0x08C
+#define REG_DIV_CLK_ETH1_500M		0x090
+#define REG_DIV_CLK_GPIO_DB		0x094
+#define REG_DIV_CLK_SDMA_AUD0		0x098
+#define REG_DIV_CLK_SDMA_AUD1		0x09C
+#define REG_DIV_CLK_SDMA_AUD2		0x0A0
+#define REG_DIV_CLK_SDMA_AUD3		0x0A4
+#define REG_DIV_CLK_CAM0_200		0x0A8
+#define REG_DIV_CLK_AXI4		0x0B8
+#define REG_DIV_CLK_AXI6		0x0BC
+#define REG_DIV_CLK_DSI_ESC		0x0C4
+#define REG_DIV_CLK_AXI_VIP		0x0C8
+#define REG_DIV_CLK_SRC_VIP_SYS_0	0x0D0
+#define REG_DIV_CLK_SRC_VIP_SYS_1	0x0D8
+#define REG_DIV_CLK_DISP_SRC_VIP	0x0E0
+#define REG_DIV_CLK_AXI_VIDEO_CODEC	0x0E4
+#define REG_DIV_CLK_VC_SRC0		0x0EC
+#define REG_DIV_CLK_1M			0x0FC
+#define REG_DIV_CLK_SPI			0x100
+#define REG_DIV_CLK_I2C			0x104
+#define REG_DIV_CLK_SRC_VIP_SYS_2	0x110
+#define REG_DIV_CLK_AUDSRC		0x118
+#define REG_DIV_CLK_PWM_SRC_0		0x120
+#define REG_DIV_CLK_AP_DEBUG		0x128
+#define REG_DIV_CLK_RTCSYS_SRC_0	0x12C
+#define REG_DIV_CLK_C906_0_0		0x130
+#define REG_DIV_CLK_C906_0_1		0x134
+#define REG_DIV_CLK_C906_1_0		0x138
+#define REG_DIV_CLK_C906_1_1		0x13C
+#define REG_DIV_CLK_SRC_VIP_SYS_3	0x140
+#define REG_DIV_CLK_SRC_VIP_SYS_4	0x144
+
+#endif /* _CLK_SOPHGO_CV1800_H_ */
diff --git a/drivers/clk/sophgo/clk-ip.c b/drivers/clk/sophgo/clk-ip.c
new file mode 100644
index 0000000000..d571fa671b
--- /dev/null
+++ b/drivers/clk/sophgo/clk-ip.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <dm.h>
+#include <div64.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+
+#include "clk-common.h"
+#include "clk-ip.h"
+
+static int get_parent_index(struct clk *clk, const char *const *parent_name,
+			    u8 num_parents)
+{
+	const char *name = clk_hw_get_name(clk);
+	int i;
+
+	for (i = 0; i < num_parents; i++) {
+		if (!strcmp(name, parent_name[i]))
+			return i;
+	}
+
+	return -1;
+}
+
+/* GATE */
+#define to_cv1800b_clk_gate(_clk) \
+	container_of(_clk, struct cv1800b_clk_gate, clk)
+
+static int gate_enable(struct clk *clk)
+{
+	struct cv1800b_clk_gate *gate = to_cv1800b_clk_gate(clk);
+
+	return cv1800b_clk_setbit(gate->base, &gate->gate);
+}
+
+static int gate_disable(struct clk *clk)
+{
+	struct cv1800b_clk_gate *gate = to_cv1800b_clk_gate(clk);
+
+	return cv1800b_clk_clrbit(gate->base, &gate->gate);
+}
+
+static ulong gate_get_rate(struct clk *clk)
+{
+	return clk_get_parent_rate(clk);
+}
+
+const struct clk_ops cv1800b_clk_gate_ops = {
+	.disable = gate_disable,
+	.enable = gate_enable,
+	.get_rate = gate_get_rate,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_gate) = {
+	.name = "cv1800b_clk_gate",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_gate_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* DIV */
+#define CLK_DIV_EN_FACTOR BIT(3)
+
+#define to_cv1800b_clk_div(_clk) container_of(_clk, struct cv1800b_clk_div, clk)
+
+static int div_enable(struct clk *clk)
+{
+	struct cv1800b_clk_div *div = to_cv1800b_clk_div(clk);
+
+	return cv1800b_clk_setbit(div->base, &div->gate);
+}
+
+static int div_disable(struct clk *clk)
+{
+	struct cv1800b_clk_div *div = to_cv1800b_clk_div(clk);
+
+	return cv1800b_clk_clrbit(div->base, &div->gate);
+}
+
+static ulong div_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_div *div = to_cv1800b_clk_div(clk);
+	ulong val;
+
+	if (div->div_init == 0 ||
+	    readl(div->base + div->div.offset) & CLK_DIV_EN_FACTOR)
+		val = cv1800b_clk_getfield(div->base, &div->div);
+	else
+		val = div->div_init;
+
+	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
+}
+
+static ulong div_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_div *div = to_cv1800b_clk_div(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 val;
+
+	val = DIV_ROUND_UP_ULL(parent_rate, rate);
+	val = min_t(u32, val, clk_div_mask(div->div.width));
+
+	cv1800b_clk_setfield(div->base, &div->div, val);
+	if (div->div_init > 0)
+		setbits_le32(div->base + div->div.offset, CLK_DIV_EN_FACTOR);
+
+	return DIV_ROUND_UP_ULL(parent_rate, val);
+}
+
+const struct clk_ops cv1800b_clk_div_ops = {
+	.disable = div_disable,
+	.enable = div_enable,
+	.get_rate = div_get_rate,
+	.set_rate = div_set_rate,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_div) = {
+	.name = "cv1800b_clk_div",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_div_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+#define to_cv1800b_clk_bypass_div(_clk) \
+	container_of(_clk, struct cv1800b_clk_bypass_div, div.clk)
+
+static ulong bypass_div_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_bypass_div *div = to_cv1800b_clk_bypass_div(clk);
+
+	if (cv1800b_clk_getbit(div->div.base, &div->bypass))
+		return 0;
+
+	return div_get_rate(clk);
+}
+
+static ulong bypass_div_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_bypass_div *div = to_cv1800b_clk_bypass_div(clk);
+
+	if (cv1800b_clk_getbit(div->div.base, &div->bypass))
+		return 0;
+
+	return div_set_rate(clk, rate);
+}
+
+static int bypass_div_set_parent(struct clk *clk, struct clk *pclk)
+{
+	struct cv1800b_clk_bypass_div *div = to_cv1800b_clk_bypass_div(clk);
+
+	if (pclk->id == CV1800B_CLK_BYPASS) {
+		cv1800b_clk_setbit(div->div.base, &div->bypass);
+		return 0;
+	}
+
+	if (strcmp(clk_hw_get_name(pclk), div->div.parent_name))
+		return -EINVAL;
+
+	cv1800b_clk_clrbit(div->div.base, &div->bypass);
+	return 0;
+}
+
+const struct clk_ops cv1800b_clk_bypass_div_ops = {
+	.disable = div_disable,
+	.enable = div_enable,
+	.get_rate = bypass_div_get_rate,
+	.set_rate = bypass_div_set_rate,
+	.set_parent = bypass_div_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_bypass_div) = {
+	.name = "cv1800b_clk_bypass_div",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_bypass_div_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* FIXED DIV */
+#define to_cv1800b_clk_fixed_div(_clk) \
+	container_of(_clk, struct cv1800b_clk_fixed_div, clk)
+
+static int fixed_div_enable(struct clk *clk)
+{
+	struct cv1800b_clk_fixed_div *div = to_cv1800b_clk_fixed_div(clk);
+
+	return cv1800b_clk_setbit(div->base, &div->gate);
+}
+
+static int fixed_div_disable(struct clk *clk)
+{
+	struct cv1800b_clk_fixed_div *div = to_cv1800b_clk_fixed_div(clk);
+
+	return cv1800b_clk_clrbit(div->base, &div->gate);
+}
+
+static ulong fixed_div_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_fixed_div *div = to_cv1800b_clk_fixed_div(clk);
+
+	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), div->div);
+}
+
+const struct clk_ops cv1800b_clk_fixed_div_ops = {
+	.disable = fixed_div_disable,
+	.enable = fixed_div_enable,
+	.get_rate = fixed_div_get_rate,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_fixed_div) = {
+	.name = "cv1800b_clk_fixed_div",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_fixed_div_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+#define to_cv1800b_clk_bypass_fixed_div(_clk) \
+	container_of(_clk, struct cv1800b_clk_bypass_fixed_div, div.clk)
+
+static ulong bypass_fixed_div_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_bypass_fixed_div *div =
+		to_cv1800b_clk_bypass_fixed_div(clk);
+
+	if (cv1800b_clk_getbit(div->div.base, &div->bypass))
+		return 0;
+
+	return fixed_div_get_rate(clk);
+}
+
+static int bypass_fixed_div_set_parent(struct clk *clk, struct clk *pclk)
+{
+	struct cv1800b_clk_bypass_fixed_div *div =
+		to_cv1800b_clk_bypass_fixed_div(clk);
+
+	if (pclk->id == CV1800B_CLK_BYPASS) {
+		cv1800b_clk_setbit(div->div.base, &div->bypass);
+		return 0;
+	}
+
+	if (strcmp(clk_hw_get_name(pclk), div->div.parent_name))
+		return -EINVAL;
+
+	cv1800b_clk_clrbit(div->div.base, &div->bypass);
+	return 0;
+}
+
+const struct clk_ops cv1800b_clk_bypass_fixed_div_ops = {
+	.disable = fixed_div_disable,
+	.enable = fixed_div_enable,
+	.get_rate = bypass_fixed_div_get_rate,
+	.set_parent = bypass_fixed_div_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_bypass_fixed_div) = {
+	.name = "cv1800b_clk_bypass_fixed_div",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_bypass_fixed_div_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* MUX */
+#define to_cv1800b_clk_mux(_clk) container_of(_clk, struct cv1800b_clk_mux, clk)
+
+static int mux_enable(struct clk *clk)
+{
+	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
+
+	return cv1800b_clk_setbit(mux->base, &mux->gate);
+}
+
+static int mux_disable(struct clk *clk)
+{
+	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
+
+	return cv1800b_clk_clrbit(mux->base, &mux->gate);
+}
+
+static ulong mux_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
+	ulong val;
+
+	if (mux->div_init == 0 ||
+	    readl(mux->base + mux->div.offset) & CLK_DIV_EN_FACTOR)
+		val = cv1800b_clk_getfield(mux->base, &mux->div);
+	else
+		val = mux->div_init;
+
+	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
+}
+
+static ulong mux_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	ulong val;
+
+	val = DIV_ROUND_UP_ULL(parent_rate, rate);
+	val = min_t(u32, val, clk_div_mask(mux->div.width));
+
+	cv1800b_clk_setfield(mux->base, &mux->div, val);
+	if (mux->div_init > 0)
+		setbits_le32(mux->base + mux->div.offset, CLK_DIV_EN_FACTOR);
+
+	return DIV_ROUND_UP_ULL(parent_rate, val);
+}
+
+static int mux_set_parent(struct clk *clk, struct clk *pclk)
+{
+	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
+	int index = get_parent_index(pclk, mux->parent_names, mux->num_parents);
+
+	if (index < 0)
+		return -EINVAL;
+
+	cv1800b_clk_setfield(mux->base, &mux->mux, index);
+	return 0;
+}
+
+const struct clk_ops cv1800b_clk_mux_ops = {
+	.disable = mux_disable,
+	.enable = mux_enable,
+	.get_rate = mux_get_rate,
+	.set_rate = mux_set_rate,
+	.set_parent = mux_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_mux) = {
+	.name = "cv1800b_clk_mux",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_mux_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+#define to_cv1800b_clk_bypass_mux(_clk) \
+	container_of(_clk, struct cv1800b_clk_bypass_mux, mux.clk)
+
+static ulong bypass_mux_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_bypass_mux *mux = to_cv1800b_clk_bypass_mux(clk);
+
+	if (cv1800b_clk_getbit(mux->mux.base, &mux->bypass))
+		return 0;
+
+	return mux_get_rate(clk);
+}
+
+static ulong bypass_mux_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_bypass_mux *mux = to_cv1800b_clk_bypass_mux(clk);
+
+	if (cv1800b_clk_getbit(mux->mux.base, &mux->bypass))
+		return 0;
+
+	return mux_set_rate(clk, rate);
+}
+
+static int bypass_mux_set_parent(struct clk *clk, struct clk *pclk)
+{
+	struct cv1800b_clk_bypass_mux *mux = to_cv1800b_clk_bypass_mux(clk);
+	int index;
+
+	if (pclk->id == CV1800B_CLK_BYPASS) {
+		cv1800b_clk_setbit(mux->mux.base, &mux->bypass);
+		return 0;
+	}
+
+	index = get_parent_index(pclk, mux->mux.parent_names,
+				 mux->mux.num_parents);
+	if (index < 0)
+		return -EINVAL;
+
+	cv1800b_clk_clrbit(mux->mux.base, &mux->bypass);
+	cv1800b_clk_setfield(mux->mux.base, &mux->mux.mux, index);
+	return 0;
+}
+
+const struct clk_ops cv1800b_clk_bypass_mux_ops = {
+	.disable = mux_disable,
+	.enable = mux_enable,
+	.get_rate = bypass_mux_get_rate,
+	.set_rate = bypass_mux_set_rate,
+	.set_parent = bypass_mux_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_bypass_mux) = {
+	.name = "cv1800b_clk_bypass_mux",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_bypass_mux_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* MMUX */
+#define to_cv1800b_clk_mmux(_clk) \
+	container_of(_clk, struct cv1800b_clk_mmux, clk)
+
+static int mmux_enable(struct clk *clk)
+{
+	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
+
+	return cv1800b_clk_setbit(mmux->base, &mmux->gate);
+}
+
+static int mmux_disable(struct clk *clk)
+{
+	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
+
+	return cv1800b_clk_clrbit(mmux->base, &mmux->gate);
+}
+
+static ulong mmux_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
+	int clk_sel = 1;
+	ulong reg, val;
+
+	if (cv1800b_clk_getbit(mmux->base, &mmux->bypass))
+		return 0;
+
+	if (cv1800b_clk_getbit(mmux->base, &mmux->clk_sel))
+		clk_sel = 0;
+
+	reg = readl(mmux->base + mmux->div[clk_sel].offset);
+
+	if (mmux->div_init[clk_sel] == 0 || reg & CLK_DIV_EN_FACTOR)
+		val = cv1800b_clk_getfield(mmux->base, &mmux->div[clk_sel]);
+	else
+		val = mmux->div_init[clk_sel];
+
+	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
+}
+
+static ulong mmux_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
+	int clk_sel = 1;
+	ulong parent_rate = clk_get_parent_rate(clk);
+	ulong val;
+
+	if (cv1800b_clk_getbit(mmux->base, &mmux->bypass))
+		return 0;
+
+	if (cv1800b_clk_getbit(mmux->base, &mmux->clk_sel))
+		clk_sel = 0;
+
+	val = DIV_ROUND_UP_ULL(parent_rate, rate);
+	val = min_t(u32, val, clk_div_mask(mmux->div[clk_sel].width));
+
+	cv1800b_clk_setfield(mmux->base, &mmux->div[clk_sel], val);
+	if (mmux->div_init[clk_sel] > 0)
+		setbits_le32(mmux->base + mmux->div[clk_sel].offset,
+			     CLK_DIV_EN_FACTOR);
+
+	return DIV_ROUND_UP_ULL(parent_rate, val);
+}
+
+static int mmux_set_parent(struct clk *clk, struct clk *pclk)
+{
+	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
+	const char *pname = clk_hw_get_name(pclk);
+	int i;
+	u8 clk_sel, index;
+
+	if (pclk->id == CV1800B_CLK_BYPASS) {
+		cv1800b_clk_setbit(mmux->base, &mmux->bypass);
+		return 0;
+	}
+
+	for (i = 0; i < mmux->num_parents; i++) {
+		if (!strcmp(pname, mmux->parent_infos[i].name))
+			break;
+	}
+
+	if (i == mmux->num_parents)
+		return -EINVAL;
+
+	clk_sel = mmux->parent_infos[i].clk_sel;
+	index = mmux->parent_infos[i].index;
+	cv1800b_clk_clrbit(mmux->base, &mmux->bypass);
+	if (clk_sel)
+		cv1800b_clk_clrbit(mmux->base, &mmux->clk_sel);
+	else
+		cv1800b_clk_setbit(mmux->base, &mmux->clk_sel);
+
+	cv1800b_clk_setfield(mmux->base, &mmux->mux[clk_sel], index);
+	return 0;
+}
+
+const struct clk_ops cv1800b_clk_mmux_ops = {
+	.disable = mmux_disable,
+	.enable = mmux_enable,
+	.get_rate = mmux_get_rate,
+	.set_rate = mmux_set_rate,
+	.set_parent = mmux_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_mmux) = {
+	.name = "cv1800b_clk_mmux",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_mmux_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* AUDIO CLK */
+#define to_cv1800b_clk_audio(_clk) \
+	container_of(_clk, struct cv1800b_clk_audio, clk)
+
+static int aclk_enable(struct clk *clk)
+{
+	struct cv1800b_clk_audio *aclk = to_cv1800b_clk_audio(clk);
+
+	cv1800b_clk_setbit(aclk->base, &aclk->src_en);
+	cv1800b_clk_setbit(aclk->base, &aclk->output_en);
+	return 0;
+}
+
+static int aclk_disable(struct clk *clk)
+{
+	struct cv1800b_clk_audio *aclk = to_cv1800b_clk_audio(clk);
+
+	cv1800b_clk_clrbit(aclk->base, &aclk->src_en);
+	cv1800b_clk_clrbit(aclk->base, &aclk->output_en);
+	return 0;
+}
+
+static ulong aclk_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_audio *aclk = to_cv1800b_clk_audio(clk);
+	u64 parent_rate = clk_get_parent_rate(clk);
+	u32 m, n;
+
+	if (!cv1800b_clk_getbit(aclk->base, &aclk->div_en))
+		return 0;
+
+	m = cv1800b_clk_getfield(aclk->base, &aclk->m);
+	n = cv1800b_clk_getfield(aclk->base, &aclk->n);
+
+	return DIV_ROUND_UP_ULL(n * parent_rate, m * 2);
+}
+
+static u32 gcd(u32 a, u32 b)
+{
+	u32 t;
+
+	while (b != 0) {
+		t = a % b;
+		a = b;
+		b = t;
+	}
+	return a;
+}
+
+static void aclk_determine_mn(ulong parent_rate, ulong rate, u32 *m, u32 *n)
+{
+	u32 tm = parent_rate / 2;
+	u32 tn = rate;
+	u32 tcommon = gcd(tm, tn);
+	*m = tm / tcommon;
+	*n = tn / tcommon;
+}
+
+static ulong aclk_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_audio *aclk = to_cv1800b_clk_audio(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 m, n;
+
+	aclk_determine_mn(parent_rate, rate, &m, &n);
+
+	cv1800b_clk_setfield(aclk->base, &aclk->m, m);
+	cv1800b_clk_setfield(aclk->base, &aclk->n, n);
+
+	cv1800b_clk_setbit(aclk->base, &aclk->div_en);
+	cv1800b_clk_setbit(aclk->base, &aclk->div_up);
+
+	return DIV_ROUND_UP_ULL(parent_rate * n, m * 2);
+}
+
+const struct clk_ops cv1800b_clk_audio_ops = {
+	.disable = aclk_disable,
+	.enable = aclk_enable,
+	.get_rate = aclk_get_rate,
+	.set_rate = aclk_set_rate,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_audio) = {
+	.name = "cv1800b_clk_audio",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_clk_audio_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/sophgo/clk-ip.h b/drivers/clk/sophgo/clk-ip.h
new file mode 100644
index 0000000000..09d15d86dc
--- /dev/null
+++ b/drivers/clk/sophgo/clk-ip.h
@@ -0,0 +1,288 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CLK_SOPHGO_IP_H__
+#define __CLK_SOPHGO_IP_H__
+
+#include <clk.h>
+
+#include "clk-common.h"
+
+struct cv1800b_mmux_parent_info {
+	const char *name;
+	u8 clk_sel;
+	u8 index;
+};
+
+struct cv1800b_clk_gate {
+	struct clk clk;
+	const char *name;
+	const char *parent_name;
+	void __iomem *base;
+	struct cv1800b_clk_regbit gate;
+};
+
+struct cv1800b_clk_div {
+	struct clk clk;
+	const char *name;
+	const char *parent_name;
+	void __iomem *base;
+	struct cv1800b_clk_regbit gate;
+	struct cv1800b_clk_regfield div;
+	int div_init;
+};
+
+struct cv1800b_clk_bypass_div {
+	struct cv1800b_clk_div div;
+	struct cv1800b_clk_regbit bypass;
+};
+
+struct cv1800b_clk_fixed_div {
+	struct clk clk;
+	const char *name;
+	const char *parent_name;
+	void __iomem *base;
+	struct cv1800b_clk_regbit gate;
+	int div;
+};
+
+struct cv1800b_clk_bypass_fixed_div {
+	struct cv1800b_clk_fixed_div div;
+	struct cv1800b_clk_regbit bypass;
+};
+
+struct cv1800b_clk_mux {
+	struct clk clk;
+	const char *name;
+	const char * const *parent_names;
+	u8 num_parents;
+	void __iomem *base;
+	struct cv1800b_clk_regbit gate;
+	struct cv1800b_clk_regfield div;
+	int div_init;
+	struct cv1800b_clk_regfield mux;
+};
+
+struct cv1800b_clk_bypass_mux {
+	struct cv1800b_clk_mux mux;
+	struct cv1800b_clk_regbit bypass;
+};
+
+struct cv1800b_clk_mmux {
+	struct clk clk;
+	const char *name;
+	const struct cv1800b_mmux_parent_info *parent_infos;
+	u8 num_parents;
+	void __iomem *base;
+	struct cv1800b_clk_regbit gate;
+	struct cv1800b_clk_regfield div[2];
+	int div_init[2];
+	struct cv1800b_clk_regfield mux[2];
+	struct cv1800b_clk_regbit bypass;
+	struct cv1800b_clk_regbit clk_sel;
+};
+
+struct cv1800b_clk_audio {
+	struct clk clk;
+	const char *name;
+	const char *parent_name;
+	void __iomem *base;
+	struct cv1800b_clk_regbit src_en;
+	struct cv1800b_clk_regbit output_en;
+	struct cv1800b_clk_regbit div_en;
+	struct cv1800b_clk_regbit div_up;
+	struct cv1800b_clk_regfield m;
+	struct cv1800b_clk_regfield n;
+};
+
+#define CV1800B_GATE(_id, _name, _parent,				\
+		     _gate_offset, _gate_shift,				\
+		     _flags)						\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.gate = CV1800B_CLK_REGBIT(_gate_offset, _gate_shift),	\
+	}
+
+#define CV1800B_DIV(_id, _name, _parent,				\
+		    _gate_offset, _gate_shift,				\
+		    _div_offset, _div_shift, _div_width,		\
+		    _div_init, _flags)					\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.gate = CV1800B_CLK_REGBIT(_gate_offset, _gate_shift),	\
+		.div = CV1800B_CLK_REGFIELD(_div_offset, _div_shift,	\
+					    _div_width),		\
+		.div_init = _div_init,					\
+	}
+
+#define CV1800B_BYPASS_DIV(_id, _name, _parent,				\
+			   _gate_offset, _gate_shift,			\
+			   _div_offset, _div_shift,			\
+			   _div_width, _div_init,			\
+			   _bypass_offset, _bypass_shift,		\
+			   _flags)					\
+	{								\
+		.div = CV1800B_DIV(_id, _name, _parent,			\
+				   _gate_offset, _gate_shift,		\
+				   _div_offset, _div_shift, _div_width,	\
+				   _div_init, _flags),			\
+		.bypass = CV1800B_CLK_REGBIT(_bypass_offset,		\
+					     _bypass_shift),		\
+	}
+
+#define CV1800B_FIXED_DIV(_id, _name, _parent,				\
+			  _gate_offset, _gate_shift,			\
+			  _div, _flags)					\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.gate = CV1800B_CLK_REGBIT(_gate_offset, _gate_shift),	\
+		.div = _div,						\
+	}
+
+#define CV1800B_BYPASS_FIXED_DIV(_id, _name, _parent,			\
+				 _gate_offset, _gate_shift,		\
+				 _div,					\
+				 _bypass_offset, _bypass_shift,		\
+				 _flags)				\
+	{								\
+		.div = CV1800B_FIXED_DIV(_id, _name, _parent,		\
+					 _gate_offset, _gate_shift,	\
+					 _div, _flags),			\
+		.bypass = CV1800B_CLK_REGBIT(_bypass_offset,		\
+					     _bypass_shift)		\
+	}
+
+#define CV1800B_MUX(_id, _name, _parents,				\
+		    _gate_offset, _gate_shift,				\
+		    _div_offset, _div_shift, _div_width, _div_init,	\
+		    _mux_offset, _mux_shift, _mux_width,		\
+		    _flags)						\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.gate = CV1800B_CLK_REGBIT(_gate_offset, _gate_shift),	\
+		.div = CV1800B_CLK_REGFIELD(_div_offset, _div_shift,	\
+					    _div_width),		\
+		.div_init = _div_init,					\
+		.mux = CV1800B_CLK_REGFIELD(_mux_offset, _mux_shift,	\
+					    _mux_width),		\
+	}
+
+#define CV1800B_BYPASS_MUX(_id, _name, _parents,			\
+			   _gate_offset, _gate_shift,			\
+			   _div_offset, _div_shift,			\
+			   _div_width, _div_init,			\
+			   _mux_offset, _mux_shift, _mux_width,		\
+			   _bypass_offset, _bypass_shift,		\
+			   _flags)					\
+	{								\
+		.mux = CV1800B_MUX(_id, _name, _parents,		\
+				   _gate_offset, _gate_shift,		\
+				   _div_offset, _div_shift,		\
+				   _div_width, _div_init,		\
+				   _mux_offset, _mux_shift, _mux_width,	\
+				   _flags),				\
+		.bypass = CV1800B_CLK_REGBIT(_bypass_offset,		\
+					     _bypass_shift),		\
+	}
+
+#define CV1800B_MMUX(_id, _name, _parents,				\
+		     _gate_offset, _gate_shift,				\
+		     _div0_offset, _div0_shift, _div0_width, _div0_init,\
+		     _div1_offset, _div1_shift, _div1_width, _div1_init,\
+		     _mux0_offset, _mux0_shift, _mux0_width,		\
+		     _mux1_offset, _mux1_shift, _mux1_width,		\
+		     _bypass_offset, _bypass_shift,			\
+		     _clk_sel_offset, _clk_sel_shift,			\
+		     _flags)						\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_infos = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.gate = CV1800B_CLK_REGBIT(_gate_offset, _gate_shift),	\
+		.div = {						\
+			CV1800B_CLK_REGFIELD(_div0_offset, _div0_shift,	\
+					     _div0_width),		\
+			CV1800B_CLK_REGFIELD(_div1_offset, _div1_shift,	\
+					     _div1_width),		\
+		},							\
+		.div_init = { _div0_init, _div1_init },			\
+		.mux = {						\
+			CV1800B_CLK_REGFIELD(_mux0_offset, _mux0_shift,	\
+					     _mux0_width),		\
+			CV1800B_CLK_REGFIELD(_mux1_offset, _mux1_shift,	\
+					     _mux1_width),		\
+		},							\
+		.bypass = CV1800B_CLK_REGBIT(_bypass_offset,		\
+					     _bypass_shift),		\
+		.clk_sel = CV1800B_CLK_REGBIT(_clk_sel_offset,		\
+					      _clk_sel_shift),		\
+	}
+
+#define CV1800B_AUDIO(_id, _name, _parent,				\
+		      _src_en_offset, _src_en_shift,			\
+		      _output_en_offset, _output_en_shift,		\
+		      _div_en_offset, _div_en_shift,			\
+		      _div_up_offset, _div_up_shift,			\
+		      _m_offset, _m_shift, _m_width,			\
+		      _n_offset, _n_shift, _n_width,			\
+		      _flags)						\
+	{								\
+		.clk = {						\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),		\
+			.flags = _flags,				\
+		},							\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.src_en = CV1800B_CLK_REGBIT(_src_en_offset,		\
+					     _src_en_shift),		\
+		.output_en = CV1800B_CLK_REGBIT(_output_en_offset,	\
+						_output_en_shift),	\
+		.div_en = CV1800B_CLK_REGBIT(_div_en_offset,		\
+					     _div_en_shift),		\
+		.div_up = CV1800B_CLK_REGBIT(_div_up_offset,		\
+					     _div_up_shift),		\
+		.m = CV1800B_CLK_REGFIELD(_m_offset, _m_shift,		\
+					  _m_width),			\
+		.n = CV1800B_CLK_REGFIELD(_n_offset, _n_shift,		\
+					  _n_width),			\
+	}
+
+extern const struct clk_ops cv1800b_clk_gate_ops;
+extern const struct clk_ops cv1800b_clk_div_ops;
+extern const struct clk_ops cv1800b_clk_bypass_div_ops;
+extern const struct clk_ops cv1800b_clk_fixed_div_ops;
+extern const struct clk_ops cv1800b_clk_bypass_fixed_div_ops;
+extern const struct clk_ops cv1800b_clk_mux_ops;
+extern const struct clk_ops cv1800b_clk_bypass_mux_ops;
+extern const struct clk_ops cv1800b_clk_mmux_ops;
+extern const struct clk_ops cv1800b_clk_audio_ops;
+
+#endif /* __CLK_SOPHGO_IP_H__ */
diff --git a/drivers/clk/sophgo/clk-pll.c b/drivers/clk/sophgo/clk-pll.c
new file mode 100644
index 0000000000..a277c3ad3d
--- /dev/null
+++ b/drivers/clk/sophgo/clk-pll.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <div64.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+
+#include "clk-common.h"
+#include "clk-pll.h"
+
+#define PLL_PRE_DIV_MIN 1
+#define PLL_PRE_DIV_MAX 127
+#define PLL_POST_DIV_MIN 1
+#define PLL_POST_DIV_MAX 127
+#define PLL_DIV_MIN 6
+#define PLL_DIV_MAX 127
+#define PLL_ICTRL_MIN 0
+#define PLL_ICTRL_MAX 7
+#define PLL_MODE_MIN 0
+#define PLL_MODE_MAX 3
+#define FOR_RANGE(x, RANGE) for (x = RANGE##_MIN; x <= RANGE##_MAX; x++)
+
+#define PLL_ICTRL GENMASK(26, 24)
+#define PLL_DIV_SEL GENMASK(23, 17)
+#define PLL_SEL_MODE GENMASK(16, 15)
+#define PLL_POST_DIV_SEL GENMASK(14, 8)
+#define PLL_PRE_DIV_SEL GENMASK(6, 0)
+#define PLL_MASK_ALL                                                 \
+	(PLL_ICTRL | PLL_DIV_SEL | PLL_SEL_MODE | PLL_POST_DIV_SEL | \
+	 PLL_PRE_DIV_SEL)
+
+/* IPLL */
+#define to_clk_ipll(dev) container_of(dev, struct cv1800b_clk_ipll, clk)
+
+static int cv1800b_ipll_enable(struct clk *clk)
+{
+	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
+
+	cv1800b_clk_clrbit(pll->base, &pll->pll_pwd);
+	return 0;
+}
+
+static int cv1800b_ipll_disable(struct clk *clk)
+{
+	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
+
+	cv1800b_clk_setbit(pll->base, &pll->pll_pwd);
+	return 0;
+}
+
+static ulong cv1800b_ipll_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
+
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 reg = readl(pll->base + pll->pll_reg);
+	u32 pre_div = FIELD_GET(PLL_PRE_DIV_SEL, reg);
+	u32 post_div = FIELD_GET(PLL_POST_DIV_SEL, reg);
+	u32 div = FIELD_GET(PLL_DIV_SEL, reg);
+
+	return DIV_ROUND_DOWN_ULL(parent_rate * div, pre_div * post_div);
+}
+
+static ulong cv1800b_ipll_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 pre_div, post_div, div;
+	u32 pre_div_sel, post_div_sel, div_sel;
+	ulong new_rate, best_rate = 0;
+	u32 mode, ictrl;
+	u32 test, val;
+
+	FOR_RANGE(pre_div, PLL_PRE_DIV)
+	{
+		FOR_RANGE(post_div, PLL_POST_DIV)
+		{
+			FOR_RANGE(div, PLL_DIV)
+			{
+				new_rate = DIV_ROUND_DOWN_ULL(parent_rate * div
+							      pre_div * post_div);
+				if (rate - new_rate < rate - best_rate) {
+					best_rate = new_rate;
+					pre_div_sel = pre_div;
+					post_div_sel = post_div;
+					div_sel = div;
+				}
+			}
+		}
+	}
+
+	FOR_RANGE(mode, PLL_MODE)
+	{
+		FOR_RANGE(ictrl, PLL_ICTRL)
+		{
+			test = 184 * (1 + mode) * (1 + ictrl) / 2;
+			if (test > 20 * div_sel && test < 35 * div_sel) {
+				val = FIELD_PREP(PLL_PRE_DIV_SEL, pre_div_sel) |
+				      FIELD_PREP(PLL_POST_DIV_SEL,
+						 post_div_sel) |
+				      FIELD_PREP(PLL_DIV_SEL, div_sel) |
+				      FIELD_PREP(PLL_ICTRL, ictrl) |
+				      FIELD_PREP(PLL_SEL_MODE, mode);
+				clrsetbits_le32(pll->base + pll->pll_reg,
+						PLL_MASK_ALL, val);
+				return best_rate;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+const struct clk_ops cv1800b_ipll_ops = {
+	.enable = cv1800b_ipll_enable,
+	.disable = cv1800b_ipll_disable,
+	.get_rate = cv1800b_ipll_get_rate,
+	.set_rate = cv1800b_ipll_set_rate,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_ipll) = {
+	.name = "cv1800b_clk_ipll",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_ipll_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+/* FPLL */
+#define to_clk_fpll(dev) container_of(dev, struct cv1800b_clk_fpll, ipll.clk)
+
+static ulong cv1800b_fpll_get_rate(struct clk *clk)
+{
+	struct cv1800b_clk_fpll *pll = to_clk_fpll(clk);
+	u32 val, syn_set;
+	u32 pre_div, post_div, div;
+	u8 mult = 1;
+	ulong divisor, remainder, rate;
+
+	if (!cv1800b_clk_getbit(pll->ipll.base, &pll->syn.en))
+		return cv1800b_ipll_get_rate(clk);
+
+	syn_set = readl(pll->ipll.base + pll->syn.set);
+	if (syn_set == 0)
+		return 0;
+
+	val = readl(pll->ipll.base + pll->ipll.pll_reg);
+	pre_div = FIELD_GET(PLL_PRE_DIV_SEL, val);
+	post_div = FIELD_GET(PLL_POST_DIV_SEL, val);
+	div = FIELD_GET(PLL_DIV_SEL, val);
+
+	if (cv1800b_clk_getbit(pll->ipll.base, &pll->syn.clk_half))
+		mult = 2;
+
+	divisor = (ulong)pre_div * post_div * syn_set;
+	rate = (clk_get_parent_rate(clk) * div) << 25;
+	remainder = rate % divisor;
+	rate /= divisor;
+	//remainder = do_div(rate, divisor);
+	return rate * mult + DIV_ROUND_CLOSEST_ULL(remainder * mult, divisor);
+}
+
+static ulong cv1800b_find_syn(ulong rate, ulong parent_rate, ulong pre_div,
+			      ulong post_div, ulong div, u32 *syn)
+{
+	u32 syn_min = (4 << 26) + 1;
+	u32 syn_max = U32_MAX;
+	u32 mid;
+	ulong new_rate;
+	u32 mult = 1;
+	ulong divisor, remainder;
+
+	while (syn_min < syn_max) {
+		mid = ((ulong)syn_min + syn_max) / 2;
+		divisor = pre_div * post_div * mid;
+		new_rate = (parent_rate * div) << 25;
+		remainder = do_div(new_rate, divisor);
+		new_rate = new_rate * mult +
+			   DIV_ROUND_CLOSEST_ULL(remainder * mult, divisor);
+		if (new_rate > rate) {
+			syn_max = mid + 1;
+		} else if (new_rate < rate) {
+			syn_min = mid - 1;
+		} else {
+			syn_min = mid;
+			break;
+		}
+	}
+	*syn = syn_min;
+	return new_rate;
+}
+
+static ulong cv1800b_fpll_set_rate(struct clk *clk, ulong rate)
+{
+	struct cv1800b_clk_fpll *pll = to_clk_fpll(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 pre_div, post_div, div;
+	u32 pre_div_sel, post_div_sel, div_sel;
+	u32 syn, syn_sel;
+	ulong new_rate, best_rate = 0;
+	u32 mult = 1;
+	u32 mode, ictrl;
+
+	if (!cv1800b_clk_getbit(pll->ipll.base, &pll->syn.en))
+		return cv1800b_ipll_set_rate(clk, rate);
+
+	if (cv1800b_clk_getbit(pll->ipll.base, &pll->syn.clk_half))
+		mult = 2;
+
+	FOR_RANGE(pre_div, PLL_PRE_DIV)
+	{
+		FOR_RANGE(post_div, PLL_POST_DIV)
+		{
+			FOR_RANGE(div, PLL_DIV)
+			{
+				new_rate = cv1800b_find_syn(rate, parent_rate,
+							    pre_div, post_div, div,
+							    &syn);
+				if (rate - new_rate < rate - best_rate) {
+					best_rate = new_rate;
+					pre_div_sel = pre_div;
+					post_div_sel = post_div;
+					div_sel = div;
+					syn_sel = syn;
+				}
+			}
+		}
+	}
+
+	FOR_RANGE(mode, PLL_MODE)
+	{
+		FOR_RANGE(ictrl, PLL_ICTRL)
+		{
+			u32 test = 184 * (1 + mode) * (1 + ictrl) / 2;
+
+			if (test > 10 * div_sel && test <= 24 * div_sel) {
+				u32 val = FIELD_PREP(PLL_PRE_DIV_SEL,
+						     pre_div_sel) |
+					  FIELD_PREP(PLL_POST_DIV_SEL,
+						     post_div_sel) |
+					  FIELD_PREP(PLL_DIV_SEL, div_sel) |
+					  FIELD_PREP(PLL_ICTRL, ictrl) |
+					  FIELD_PREP(PLL_SEL_MODE, mode);
+				clrsetbits_le32(pll->ipll.base + pll->ipll.pll_reg,
+						PLL_MASK_ALL, val);
+				writel(syn_sel, pll->ipll.base + pll->syn.set);
+				return best_rate;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int cv1800b_fpll_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct cv1800b_clk_fpll *pll = to_clk_fpll(clk);
+
+	if (parent->id == CV1800B_CLK_BYPASS)
+		cv1800b_clk_setbit(pll->ipll.base, &pll->syn.en);
+	else
+		cv1800b_clk_clrbit(pll->ipll.base, &pll->syn.en);
+
+	return 0;
+}
+
+const struct clk_ops cv1800b_fpll_ops = {
+	.enable = cv1800b_ipll_enable,
+	.disable = cv1800b_ipll_disable,
+	.get_rate = cv1800b_fpll_get_rate,
+	.set_rate = cv1800b_fpll_set_rate,
+	.set_parent = cv1800b_fpll_set_parent,
+};
+
+U_BOOT_DRIVER(cv1800b_clk_fpll) = {
+	.name = "cv1800b_clk_fpll",
+	.id = UCLASS_CLK,
+	.ops = &cv1800b_fpll_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/sophgo/clk-pll.h b/drivers/clk/sophgo/clk-pll.h
new file mode 100644
index 0000000000..bea9bd8a43
--- /dev/null
+++ b/drivers/clk/sophgo/clk-pll.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __clk_SOPHGO_PLL_H__
+#define __clk_SOPHGO_PLL_H__
+
+#include <clk.h>
+
+#include "clk-common.h"
+
+struct cv1800b_clk_synthesizer {
+	struct cv1800b_clk_regbit en;
+	struct cv1800b_clk_regbit clk_half;
+	u32 ctrl;
+	u32 set;
+};
+
+struct cv1800b_clk_ipll {
+	struct clk clk;
+	const char *name;
+	const char *parent_name;
+	void __iomem *base;
+	u32 pll_reg;
+	struct cv1800b_clk_regbit pll_pwd;
+	struct cv1800b_clk_regbit pll_status;
+};
+
+struct cv1800b_clk_fpll {
+	struct cv1800b_clk_ipll ipll;
+	struct cv1800b_clk_synthesizer syn;
+};
+
+#define CV1800B_IPLL(_id, _name, _parent_name, _pll_reg, _pll_pwd_offset,	\
+		     _pll_pwd_shift, _pll_status_offset, _pll_status_shift,	\
+		     _flags)							\
+	{									\
+		.clk = {							\
+			.id = CV1800B_CLK_ID_TRANSFORM(_id),			\
+			.flags = _flags,					\
+		},								\
+		.name = _name,							\
+		.parent_name = _parent_name,					\
+		.pll_reg = _pll_reg,						\
+		.pll_pwd = CV1800B_CLK_REGBIT(_pll_pwd_offset, _pll_pwd_shift),	\
+		.pll_status = CV1800B_CLK_REGBIT(_pll_status_offset,		\
+						 _pll_status_shift),		\
+	}
+
+#define CV1800B_FPLL(_id, _name, _parent_name, _pll_reg, _pll_pwd_offset,	\
+		     _pll_pwd_shift, _pll_status_offset, _pll_status_shift,	\
+		     _syn_en_offset, _syn_en_shift, _syn_clk_half_offset,	\
+		     _syn_clk_half_shift, _syn_ctrl_offset, _syn_set_offset,	\
+		     _flags)							\
+	{									\
+		.ipll = CV1800B_IPLL(_id, _name, _parent_name, _pll_reg,	\
+				     _pll_pwd_offset, _pll_pwd_shift,		\
+				     _pll_status_offset, _pll_status_shift,	\
+				     _flags),					\
+		.syn = {							\
+			.en = CV1800B_CLK_REGBIT(_syn_en_offset, _syn_en_shift),\
+			.clk_half = CV1800B_CLK_REGBIT(_syn_clk_half_offset,	\
+						       _syn_clk_half_shift),	\
+			.ctrl = _syn_ctrl_offset,				\
+			.set = _syn_set_offset,					\
+		},								\
+	}
+
+extern const struct clk_ops cv1800b_ipll_ops;
+extern const struct clk_ops cv1800b_fpll_ops;
+
+#endif /* __clk_SOPHGO_PLL_H__ */
-- 
2.41.0

