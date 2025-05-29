Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193AC5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 05:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35668331F;
	Thu, 29 May 2025 07:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A0/F2u8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9F283321; Thu, 29 May 2025 07:10:35 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9F1831D7
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so74476966b.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748495432; x=1749100232;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zb4aYV45N00iNXiI97BWpcFaBu+md2CP4FmscY/3vPM=;
 b=A0/F2u8BRpav8JUOtV+QUyJph+ZMYOv1mdB//La++U8BmAz7Y6/GG9q4x7vdJ1+rwJ
 L8LvL6BPw/FAceZCf4HJnH0p/nQDHIcdaSI8tfjNAXOVoYvh9IqoD2IQwyCaAoONyoRE
 ccXrRPYxwxfFfXIpuReceX5Z8ZYwbUaJ6jNas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748495432; x=1749100232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zb4aYV45N00iNXiI97BWpcFaBu+md2CP4FmscY/3vPM=;
 b=oxma0jheSgliBcuRVYjFK/669IRWF8lPb46VoMEqwkoAZ+Np3MSzpDYF08vlMNbX5A
 qQdrwHHHLtu56PfmBq9NMiFDhxAwnpigYDOKK1/xrdO3Pl1W5d6RqqetT9Uw0KqBRDOK
 5qkNWVz5ZThAheyj/D4yqA9T035smPdyAI+3F9SytuiDyhWaqbfOGc1xYnbBecNZ9k/P
 m+3okVF+qus/AtykAjlmp/u6LTK27HeIpjfgB0Fr6wawEoWVcswfEH0lvR44iMsO3U/y
 yb7CuYNW8j7mavAZMszh0UpfC8ICC5NpNdjCl1Lv6ivdN3se6cyCuZ1DWzfVKbbfUcwX
 dfcQ==
X-Gm-Message-State: AOJu0Yzkp28x9NNs00+4cUszuVA9P4Wo7QrTnChzhUYigm1vLwHlSkk/
 zEBzJ0Vpq1BSJrTiPS3Apfp5nFSJ99/uPuPq5CgWkWqWteyez3dhWx+P8R9tMVlTotZrAaQ1GfH
 tIpjGW53k4dP4
X-Gm-Gg: ASbGncu/4v+R19Zir+i/UHn78TGNK6tM3iqfp9EWFCQg148ay59EI0MFkaIVmjjz01G
 i/vc/vMmirQF2MVO/tD7mqlByJOJckft0VMP+9nTegJNt88XZyNGtgt5HhBuuKwcmPh6n2V/maD
 qlia8JIA6pTA96X1j5faJefxVGGg5THr5acB3GUU17Jbv5GZazZKmlFfleN7aR+PyErlD69CbwH
 G42VexAO+x+QD43wO7kZc9BX0j2oPwko8LnL7UgSohPHXSKK8wxWvR3Vo946LnvbNr/aRnlxbPt
 MRldA8FbkgJeNw6PbWfLGuodcFgo//h4PX/ZccNa8XYowm5+MAAl7mzSJwlZt/0C7KYgrrZ6AtR
 FCHbQFyFA+Fynx9XbLHO1Grj5/w==
X-Google-Smtp-Source: AGHT+IGHyHD8CwqToNtuCGEOhNjbVmCSTlngi6QambDKebX1LBFR8DNINFl0kN0p2yn6qbiinT+N4w==
X-Received: by 2002:a17:907:8e95:b0:ad2:4eef:d33a with SMTP id
 a640c23a62f3a-ad85b065bc8mr1726699566b.15.1748495430988; 
 Wed, 28 May 2025 22:10:30 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:71fa:236b:ca2b:119e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm70776566b.39.2025.05.28.22.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 22:10:30 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
Date: Thu, 29 May 2025 07:10:15 +0200
Message-ID: <20250529051024.42340-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Add i.MX6UL clk driver for i.MX6UL CLK driver model usage

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v3:
- Add all uarts definition
- Move OSC on top suggested
- Drop an invalid clock definition
- Move some pll before they are referenced

Changes in v2:
- None

 drivers/clk/imx/Kconfig      |   8 +
 drivers/clk/imx/Makefile     |   1 +
 drivers/clk/imx/clk-imx6ul.c | 290 +++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx6ul.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index d17a54fb9b3..705d4a8e2ac 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -14,6 +14,14 @@ config CLK_IMX6Q
 	help
 	  This enables DM/DTS support for clock driver in i.MX6Q platforms.
 
+config CLK_IMX6UL
+	bool "Clock support for i.MXUL"
+	depends on ARCH_MX6
+	select CLK
+	select CLK_CCF
+	help
+	  This enables DM/DTS support for clock driver in i.MX6UL platforms.
+
 config CLK_IMX8
 	bool "Clock support for i.MX8"
 	depends on ARCH_IMX8
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index a89ee7acb12..b10221a195c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-gate2.o clk-pllv3.o clk-pfd.o
 obj-$(CONFIG_$(PHASE_)CLK_IMX6Q) += clk-imx6q.o
+obj-$(CONFIG_$(PHASE_)CLK_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_CLK_IMX8) += clk-imx8.o
 
 ifdef CONFIG_CLK_IMX8
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
new file mode 100644
index 00000000000..bd52c1d487c
--- /dev/null
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Amarula Solutions Software Engineering
+ * Michael Trimarchi, Amarula Solutions Software Engineering, michael@amarulasolutions.com
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <log.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <dt-bindings/clock/imx6ul-clock.h>
+
+#include "clk.h"
+
+static int imx6ul_clk_request(struct clk *clk)
+{
+	debug("%s: request clk id %ld\n", __func__, clk->id);
+
+	if (clk->id < IMX6UL_CLK_DUMMY || clk->id >= IMX6UL_CLK_END) {
+		printf("%s: Invalid clk ID #%lu\n", __func__, clk->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct clk_ops imx6ul_clk_ops = {
+	.request = imx6ul_clk_request,
+	.set_rate = ccf_clk_set_rate,
+	.get_rate = ccf_clk_get_rate,
+	.enable = ccf_clk_enable,
+	.disable = ccf_clk_disable,
+};
+
+static const char *const pll_bypass_src_sels[] = { "osc", "dummy", };
+static const char *const pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
+static const char *const bch_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
+static const char *const gpmi_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
+
+static const char *const enfc_sels[] = { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m",
+					 "pll3_pfd3_454m", "dummy", "dummy", "dummy", };
+static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
+static const char *const periph_sels[] = { "periph_pre", "periph_clk2", };
+static const char *const periph2_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m",
+						"pll4_audio_div", };
+static const char *const periph_clk2_sels[] = { "pll3_usb_otg", "osc", "pll2_bypass_src", };
+static const char *const periph2_clk2_sels[] = { "pll3_usb_otg", "osc", };
+static const char *const perclk_sels[] = { "ipg", "osc", };
+
+static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m", "pll2_pfd0_352m",
+					       "pll2_198m", };
+static const char *const uart_sels[] = { "pll3_80m", "osc", };
+static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
+
+static int imx6ul_clk_probe(struct udevice *dev)
+{
+	struct clk osc_clk;
+	void *base;
+	int ret;
+
+	/* Anatop clocks */
+	base = (void *)ANATOP_BASE_ADDR;
+
+	clk_dm(IMX6UL_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
+
+	ret = clk_get_by_name(dev, "osc", &osc_clk);
+	if (ret)
+		return ret;
+
+	clk_dm(IMX6UL_CLK_OSC, dev_get_clk_ptr(osc_clk.dev));
+
+	clk_dm(IMX6UL_CLK_PLL2,
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_bus", "osc",
+			     base + 0x30, 0x1));
+	clk_dm(IMX6UL_CLK_PLL3,
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3", "osc",
+			     base + 0x10, 0x3));
+	clk_dm(IMX6UL_PLL3_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll3_bypass_src", base + 0x10, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(IMX6UL_PLL3_BYPASS,
+	       imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
+				 pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6UL_CLK_PLL3_USB_OTG,
+	       imx_clk_gate(dev, "pll3_usb_otg", "pll3_bypass", base + 0x10,
+			    13));
+	clk_dm(IMX6UL_CLK_PLL3_80M,
+	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
+	clk_dm(IMX6UL_CLK_PLL3_60M,
+	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
+	clk_dm(IMX6UL_CLK_PLL2_PFD0,
+	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
+	clk_dm(IMX6UL_CLK_PLL2_PFD1,
+	       imx_clk_pfd("pll2_pfd1_594m", "pll2_bus", base + 0x100, 1));
+	clk_dm(IMX6UL_CLK_PLL2_PFD2,
+	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
+	clk_dm(IMX6UL_CLK_PLL2_PFD3,
+	       imx_clk_pfd("pll2_pfd3_396m", "pll2_bus", base + 0x100, 3));
+	clk_dm(IMX6UL_CLK_PLL6,
+	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0,
+			     0x3));
+	clk_dm(IMX6UL_CLK_PLL6_ENET,
+	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
+
+	/* CCM clocks */
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -EINVAL;
+
+	clk_dm(IMX6UL_CLK_GPMI_SEL,
+	       imx_clk_mux(dev, "gpmi_sel", base + 0x1c, 19, 1, gpmi_sels,
+			   ARRAY_SIZE(gpmi_sels)));
+	clk_dm(IMX6UL_CLK_BCH_SEL,
+	       imx_clk_mux(dev, "bch_sel", base + 0x1c, 18, 1, bch_sels,
+			   ARRAY_SIZE(bch_sels)));
+	clk_dm(IMX6UL_CLK_USDHC1_SEL,
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
+	clk_dm(IMX6UL_CLK_USDHC2_SEL,
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
+	clk_dm(IMX6UL_CLK_ECSPI_SEL,
+	       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1, ecspi_sels,
+			   ARRAY_SIZE(ecspi_sels)));
+	clk_dm(IMX6UL_CLK_UART_SEL,
+	       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1, uart_sels,
+			   ARRAY_SIZE(uart_sels)));
+	clk_dm(IMX6UL_CLK_ENFC_SEL,
+	       imx_clk_mux(dev, "enfc_sel", base + 0x2c, 15, 3, enfc_sels,
+			   ARRAY_SIZE(enfc_sels)));
+	clk_dm(IMX6UL_CLK_PERCLK_SEL,
+	       imx_clk_mux(dev, "perclk_sel", base + 0x1c, 6, 1, perclk_sels,
+			   ARRAY_SIZE(perclk_sels)));
+	clk_dm(IMX6UL_CLK_PERIPH_PRE,
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
+	clk_dm(IMX6UL_CLK_PERIPH2_PRE,
+	       imx_clk_mux(dev, "periph2_pre", base + 0x18, 21, 2,
+			   periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels)));
+	clk_dm(IMX6UL_CLK_PERIPH_CLK2_SEL,
+	       imx_clk_mux(dev, "periph_clk2_sel", base + 0x18, 12, 2,
+			   periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels)));
+	clk_dm(IMX6UL_CLK_PERIPH2_CLK2_SEL,
+	       imx_clk_mux(dev, "periph2_clk2_sel", base + 0x18, 20, 1,
+			   periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels)));
+	clk_dm(IMX6UL_CLK_PERIPH,
+	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
+				5, periph_sels, ARRAY_SIZE(periph_sels)));
+	clk_dm(IMX6UL_CLK_AHB,
+	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
+				    base + 0x48, 1));
+	clk_dm(IMX6UL_CLK_PERIPH_CLK2,
+	       imx_clk_divider(dev, "periph_clk2", "periph_clk2_sel",
+			       base + 0x14, 27, 3));
+	clk_dm(IMX6UL_CLK_PERIPH2_CLK2,
+	       imx_clk_divider(dev, "periph2_clk2", "periph2_clk2_sel",
+			       base + 0x14, 0, 3));
+	clk_dm(IMX6UL_CLK_IPG,
+	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
+	clk_dm(IMX6UL_CLK_ENFC_PRED,
+	       imx_clk_divider(dev, "enfc_pred", "enfc_sel", base + 0x2c, 18,
+			       3));
+	clk_dm(IMX6UL_CLK_ENFC_PODF,
+	       imx_clk_divider(dev, "enfc_podf", "enfc_pred", base + 0x2c, 21,
+			       6));
+	clk_dm(IMX6UL_CLK_GPMI_PODF,
+	       imx_clk_divider(dev, "gpmi_podf", "gpmi_sel", base + 0x24, 22,
+			       3));
+	clk_dm(IMX6UL_CLK_BCH_PODF,
+	       imx_clk_divider(dev, "bch_podf", "bch_sel", base + 0x24, 19, 3));
+	clk_dm(IMX6UL_CLK_PERCLK,
+	       imx_clk_divider(dev, "perclk", "perclk_sel", base + 0x1c, 0, 6));
+	clk_dm(IMX6UL_CLK_UART_PODF,
+	       imx_clk_divider(dev, "uart_podf", "uart_sel", base + 0x24, 0,
+			       6));
+	clk_dm(IMX6UL_CLK_USDHC1_PODF,
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
+			       11, 3));
+	clk_dm(IMX6UL_CLK_USDHC2_PODF,
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel", base + 0x24,
+			       16, 3));
+	clk_dm(IMX6UL_CLK_ECSPI_PODF,
+	       imx_clk_divider(dev, "ecspi_podf", "ecspi_sel", base + 0x38, 19,
+			       6));
+
+	clk_dm(IMX6UL_CLK_APBHDMA,
+	       imx_clk_gate2(dev, "apbh_dma", "bch_podf", base + 0x68, 4));
+	clk_dm(IMX6UL_CLK_ECSPI1,
+	       imx_clk_gate2(dev, "ecspi1", "ecspi_podf", base + 0x6c, 0));
+	clk_dm(IMX6UL_CLK_ECSPI2,
+	       imx_clk_gate2(dev, "ecspi2", "ecspi_podf", base + 0x6c, 2));
+	clk_dm(IMX6UL_CLK_ECSPI3,
+	       imx_clk_gate2(dev, "ecspi3", "ecspi_podf", base + 0x6c, 4));
+	clk_dm(IMX6UL_CLK_ECSPI4,
+	       imx_clk_gate2(dev, "ecspi4", "ecspi_podf", base + 0x6c, 6));
+
+	clk_dm(IMX6UL_CLK_USBOH3,
+	       imx_clk_gate2(dev, "usboh3", "ipg", base + 0x80, 0));
+	clk_dm(IMX6UL_CLK_USDHC1,
+	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
+	clk_dm(IMX6UL_CLK_USDHC2,
+	       imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4));
+
+	clk_dm(IMX6UL_CLK_UART1_IPG,
+	       imx_clk_gate2(dev, "uart1_ipg", "ipg", base + 0x7c, 24));
+	clk_dm(IMX6UL_CLK_UART1_SERIAL,
+	       imx_clk_gate2(dev, "uart1_serial", "uart_podf", base + 0x7c, 24));
+	clk_dm(IMX6UL_CLK_UART2_IPG,
+	       imx_clk_gate2(dev, "uart2_ipg", "ipg", base + 0x68, 28));
+	clk_dm(IMX6UL_CLK_UART2_SERIAL,
+	       imx_clk_gate2(dev, "uart2_serial", "uart_podf", base + 0x68, 28));
+	clk_dm(IMX6UL_CLK_UART3_IPG,
+	       imx_clk_gate2(dev, "uart3_ipg", "ipg", base + 0x6c, 10));
+	clk_dm(IMX6UL_CLK_UART3_SERIAL,
+	       imx_clk_gate2(dev, "uart3_serial", "uart_podf", base + 0x6c, 10));
+	clk_dm(IMX6UL_CLK_UART4_IPG,
+	       imx_clk_gate2(dev, "uart4_ipg", "ipg", base + 0x6c, 24));
+	clk_dm(IMX6UL_CLK_UART4_SERIAL,
+	       imx_clk_gate2(dev, "uart4_serial", "uart_podf", base + 0x6c, 24));
+	clk_dm(IMX6UL_CLK_UART5_IPG,
+	       imx_clk_gate2(dev, "uart5_ipg", "ipg", base + 0x74, 2));
+	clk_dm(IMX6UL_CLK_UART5_SERIAL,
+	       imx_clk_gate2(dev, "uart5_serial", "uart_podf", base + 0x74, 2));
+	clk_dm(IMX6UL_CLK_UART6_IPG,
+	       imx_clk_gate2(dev, "uart6_ipg", "ipg", base + 0x74, 6));
+	clk_dm(IMX6UL_CLK_UART6_SERIAL,
+	       imx_clk_gate2(dev, "uart6_serial", "uart_podf", base + 0x74, 6));
+	clk_dm(IMX6UL_CLK_UART7_IPG,
+	       imx_clk_gate2(dev, "uart7_ipg", "ipg", base + 0x7c, 26));
+	clk_dm(IMX6UL_CLK_UART7_SERIAL,
+	       imx_clk_gate2(dev, "uart7_serial", "uart_podf", base + 0x7c, 26));
+	clk_dm(IMX6UL_CLK_UART8_IPG,
+	       imx_clk_gate2(dev, "uart8_ipg", "ipg", base + 0x80, 14));
+	clk_dm(IMX6UL_CLK_UART8_SERIAL,
+	       imx_clk_gate2(dev, "uart8_serial", "uart_podf", base + 0x80, 14));
+
+#if CONFIG_IS_ENABLED(NAND_MXS)
+	clk_dm(IMX6UL_CLK_PER_BCH,
+	       imx_clk_gate2(dev, "per_bch", "bch_podf", base + 0x78, 12));
+	clk_dm(IMX6UL_CLK_GPMI_BCH_APB,
+	       imx_clk_gate2(dev, "gpmi_bch_apb", "bch_podf", base + 0x78, 24));
+	clk_dm(IMX6UL_CLK_GPMI_BCH,
+	       imx_clk_gate2(dev, "gpmi_bch", "gpmi_podf", base + 0x78, 26));
+	clk_dm(IMX6UL_CLK_GPMI_IO,
+	       imx_clk_gate2(dev, "gpmi_io", "enfc_podf", base + 0x78, 28));
+	clk_dm(IMX6UL_CLK_GPMI_APB,
+	       imx_clk_gate2(dev, "gpmi_apb", "bch_podf", base + 0x78, 30));
+#endif
+	clk_dm(IMX6UL_CLK_IPG,
+	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
+	clk_dm(IMX6UL_CLK_I2C1,
+	       imx_clk_gate2(dev, "i2c1", "perclk", base + 0x70, 6));
+	clk_dm(IMX6UL_CLK_I2C2,
+	       imx_clk_gate2(dev, "i2c2", "perclk", base + 0x70, 8));
+	clk_dm(IMX6UL_CLK_I2C3,
+	       imx_clk_gate2(dev, "i2c3", "perclk", base + 0x70, 10));
+	clk_dm(IMX6UL_CLK_PWM1,
+	       imx_clk_gate2(dev, "pwm1", "perclk", base + 0x78, 16));
+
+	clk_dm(IMX6UL_CLK_ENET,
+	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
+	clk_dm(IMX6UL_CLK_ENET_REF,
+	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+
+	struct clk *clk, *clk1;
+
+	clk_get_by_id(IMX6UL_CLK_ENFC_SEL, &clk);
+	clk_get_by_id(IMX6UL_CLK_PLL2_PFD2, &clk1);
+
+	clk_set_parent(clk, clk1);
+
+	return 0;
+}
+
+static const struct udevice_id imx6ul_clk_ids[] = {
+	{.compatible = "fsl,imx6ul-ccm" },
+	{ },
+};
+
+U_BOOT_DRIVER(imx6ul_clk) = {
+	.name = "clk_imx6ul",
+	.id = UCLASS_CLK,
+	.of_match = imx6ul_clk_ids,
+	.ops = &imx6ul_clk_ops,
+	.probe = imx6ul_clk_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
