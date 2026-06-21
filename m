Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB9CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A660F84873;
	Sun, 21 Jun 2026 21:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iQqRVDXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B1384874; Sun, 21 Jun 2026 18:47:05 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A621F84873
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 18:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xerikasxx@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-662ebb1329aso1522704d50.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782060421; x=1782665221; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=355d4vBVVif5dNO+7Z5hmivfmHon7iUpYyY8CklPJD4=;
 b=iQqRVDXgdodou7MIu4/YQqmD79Hb27w8Uwug/MeVK9AQKKQ5g4dkcwIVFEFpzp3IaO
 0TF/CU/IWLGhZdAhAEMuyZqtWRD1SBKo5i9fh4C9wClK8+r2AAq8pYn7+hmGB7M60HIz
 Enub3UHUTPgnmPKNT8/PvVFF2jgpgnqT6RF7M7gMxhsuchyeKRvl9P5s063n9MVrtI9X
 nrzR/40m3ly0gyrgz7MIDayk10jzA9hv4fkGxqLarkfppZ5uoUonTMHTPOUJBLMUP3eW
 4IGngdz7XzVts+cTzy4eMGiUkDjBECQ3l5LfVVJ7/UuHy9MJi6BZaXWp++RhHpmsKmbW
 8a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060421; x=1782665221;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=355d4vBVVif5dNO+7Z5hmivfmHon7iUpYyY8CklPJD4=;
 b=STOqKCyykfVKYlOXWkcHTVJrkbL2fQ4lwtxZaa+YSbJWkoCwmghU89FzQnKrVPyq6Y
 +xmwR3jkyl+q4k86cLteXKZJhpZy1RbqB9LUuI0SDlUVm9zhM8CJpg4pms4gw9SYzYkK
 jGo2ozSrqtgI5XQeQr2hOuL5F45P3kSUs6ba3sxBax6ZmTK3Utn7w3roZtZvBEZp+lxR
 ZxPw4fjIvkHfBh1ycQqvz+jU/e8v8sQfjmT1/S2DdJq1H5aknHOGlT5Gs9DbUxDBKNOT
 n6lYwgT1X6EvpGib8ChCMKASIvErr7UpUWZi231WWbGIHJtEZEH0ZT2ftcPmikSOTH8O
 wjxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJMAisZ9Xc1y1Lx9m6QlmCu8aaz2cqU/n/q2Br1j0VEh/031CtMqiGF55bxqrlIiUuYRFwGBA=@lists.denx.de
X-Gm-Message-State: AOJu0YxeUl0w3gk272UUdr4sT1DjQRtakkQvwYtqQlvcNPzaoGJUm3DW
 RPCVG/dG5LaKTDSJ3QKnFMOdf/ojg5s0sQI93RuDYTy+t6EASKLxROo+
X-Gm-Gg: AfdE7cm4X8H6VfcnVu/RQB8NSz0K2wbkNBZuPAcjK1MkJ70hBd+n/0IIoIdA00SYRqN
 ekRYAKKop0699+ZA9tDMP+BODMC10CAFAzFUzOJ/PcekD2hWQRqaO5iwZF1Ib6HuXKDsbBcM3Qp
 PX6GtqYZK0bN+vaFYlseSmq9KN8H2gYG9CqGMSih2vhacLJMVJwB5u48zcftqX4AsIBfbqQCIY/
 841QuwE+Jy/ZCK9GAmU/YIqmDPn/NdUa42nUkSP6eMbxA6Pgbc3C9hCReiCmb40AYw5RfyUklgR
 m+6o8tyxDW1RgkryUNHxsJSAOf8m2e8ZA3gkvGTH0pdNUfLtQ4rU9NKcvPVElQcWPXTEXUn08lJ
 4bqnAIojnbiYR3oZqcBVh3F3b39NYvOpk1CRI6F5zyPfhW5OnbG9eHpyvd45hK62bFA+3upxP1Y
 xz4m/8NbQRPotr8IE=
X-Received: by 2002:a05:690e:11c7:b0:663:2650:a498 with SMTP id
 956f58d0204a3-6632650c059mr3288934d50.61.1782060420986; 
 Sun, 21 Jun 2026 09:47:00 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8c3f1sm2498215d50.15.2026.06.21.09.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:47:00 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 21 Jun 2026 19:46:21 +0300
Subject: [PATCH 1/4] clk: qcom: Add driver for SC7180 GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sm7125-support-v1-1-5ad69a39781a@gmail.com>
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
In-Reply-To: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

From: Vitalii Skorkin <nikroks@mainlining.org>

Add a clock driver for the SC7180 SoC. This driver can enable necessary
clocks for UART, UFS, USB, and MMC.

Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sc7180.c | 273 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9ad233c83ac..95b650831a3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -166,6 +166,14 @@ config CLK_QCOM_SM8650
 	  on the Snapdragon SM8650 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SC7180
+	bool "Qualcomm SC7180 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon SC7180 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SC7280
 	bool "Qualcomm SC7280 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c0d95a6300e..1adca029b11 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
 obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
new file mode 100644
index 00000000000..38b1fefcf03
--- /dev/null
+++ b/drivers/clk/qcom/clock-sc7180.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm SC7180
+ *
+ * (C) Copyright 2025 Vitalii Skorkin <nikroksm@mail.ru>
+ *
+ * Based on Linux Kernel driver
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
+#define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
+
+#define SE8_UART_APPS_CMD_RCGR		0x18278
+#define SDCC2_APPS_CLK_SRC_REG		0x1400c
+
+#define APCS_GPLL6_STATUS			0x13000
+#define APCS_GPLL7_STATUS			0x27000
+#define APCS_GPLLX_ENA_REG			0x52010
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(51200000, CFG_CLK_SRC_GPLL6, 7.5, 0, 0),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static const struct pll_vote_clk gpll6_vote_clk = {
+	.status = APCS_GPLL6_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(6),
+};
+
+static const struct pll_vote_clk gpll7_vote_clk = {
+	.status = APCS_GPLL7_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(7),
+};
+
+static ulong sc7180_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s, requested rate=%ld\n", priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S2_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL6)
+			clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		clk_rcg_set_rate_mnd(priv->base, SE8_UART_APPS_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_SRC_REG,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return rate;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sc7180_clks[] = {
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x82024, 0x000001),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x8201c, 0x000001),
+	GATE_CLK(GCC_BOOT_ROM_AHB_CLK, 0x52000, 0x000400),
+	GATE_CLK(GCC_CAMERA_HF_AXI_CLK, 0xb020, 0x000001),
+	GATE_CLK(GCC_CAMERA_THROTTLE_HF_AXI_CLK, 0xb080, 0x000001),
+	GATE_CLK(GCC_CE1_AHB_CLK, 0x52000, 0x000008),
+	GATE_CLK(GCC_CE1_AXI_CLK, 0x52000, 0x000010),
+	GATE_CLK(GCC_CE1_CLK, 0x52000, 0x000020),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x502c, 0x000001),
+	GATE_CLK(GCC_CPUSS_AHB_CLK, 0x52000, 0x200000),
+	GATE_CLK(GCC_CPUSS_RBCPR_CLK, 0x48008, 0x000001),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK, 0x4452c, 0x000001),
+	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb024, 0x000001),
+	GATE_CLK(GCC_DISP_THROTTLE_HF_AXI_CLK, 0xb084, 0x000001),
+	GATE_CLK(GCC_GP1_CLK, 0x64000, 0x000001),
+	GATE_CLK(GCC_GP2_CLK, 0x65000, 0x000001),
+	GATE_CLK(GCC_GP3_CLK, 0x66000, 0x000001),
+	GATE_CLK(GCC_GPU_MEMNOC_GFX_CLK, 0x7100c, 0x000001),
+	GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK, 0x71018, 0x000001),
+	GATE_CLK(GCC_NPU_AXI_CLK, 0x4d008, 0x000001),
+	GATE_CLK(GCC_NPU_BWMON_AXI_CLK, 0x73008, 0x000001),
+	GATE_CLK(GCC_NPU_BWMON_DMA_CFG_AHB_CLK, 0x73018, 0x000001),
+	GATE_CLK(GCC_NPU_BWMON_DSP_CFG_AHB_CLK, 0x7301c, 0x000001),
+	GATE_CLK(GCC_NPU_CFG_AHB_CLK, 0x4d004, 0x000001),
+	GATE_CLK(GCC_NPU_DMA_CLK, 0x4d1a0, 0x000001),
+	GATE_CLK(GCC_PDM2_CLK, 0x3300c, 0x000001),
+	GATE_CLK(GCC_PDM_AHB_CLK, 0x33004, 0x000001),
+	GATE_CLK(GCC_PDM_XO4_CLK, 0x33008, 0x000001),
+	GATE_CLK(GCC_PRNG_AHB_CLK, 0x52000, 0x002000),
+	GATE_CLK(GCC_QSPI_CNOC_PERIPH_AHB_CLK, 0x4b004, 0x000001),
+	GATE_CLK(GCC_QSPI_CORE_CLK, 0x4b008, 0x000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x52008, 0x000200),
+	GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x52008, 0x000100),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, 0x000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, 0x000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x52008, 0x001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, 0x002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x52008, 0x004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, 0x008000),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x52008, 0x040000),
+	GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK, 0x52008, 0x080000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x52008, 0x400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, 0x800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x52008, 0x1000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x52008, 0x2000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x52008, 0x4000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x52008, 0x8000000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x52008, 0x000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x52008, 0x000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x52008, 0x100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x52008, 0x200000),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, 0x000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x1200c, 0x000001),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK, 0x12040, 0x000001),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, 0x000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, 0x000001),
+	GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK, 0x52000, 0x000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77014, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77038, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77090, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x77094, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x7701c, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x77018, 0x000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7708c, 0x000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 0x000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 0x000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 0x000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c010, 0x000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 0x000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 0x000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, 0x000001),
+	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK, 0x6a004, 0x000001),
+	GATE_CLK(GCC_VIDEO_AXI_CLK, 0xb01c, 0x000001),
+	GATE_CLK(GCC_VIDEO_THROTTLE_AXI_CLK, 0xb07c, 0x000001),
+	GATE_CLK(GCC_MSS_CFG_AHB_CLK, 0x8a000, 0x000001),
+	GATE_CLK(GCC_MSS_MFAB_AXIS_CLK, 0x8a004, 0x000001),
+	GATE_CLK(GCC_MSS_NAV_AXI_CLK, 0x8a00c, 0x000001),
+	GATE_CLK(GCC_MSS_Q6_MEMNOC_AXI_CLK, 0x8a154, 0x000001),
+	GATE_CLK(GCC_MSS_SNOC_AXI_CLK, 0x8a150, 0x000001),
+	GATE_CLK(GCC_LPASS_CFG_NOC_SWAY_CLK, 0x47018, 0x000001),
+};
+
+static int sc7180_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %s\n", __func__, sc7180_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
+		break;
+	}
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static const struct qcom_reset_map sc7180_gcc_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x26000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x26004 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sc7180_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0x0f004 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+};
+
+static struct msm_clk_data sc7180_gcc_data = {
+	.resets = sc7180_gcc_resets,
+	.num_resets = ARRAY_SIZE(sc7180_gcc_resets),
+	.clks = sc7180_clks,
+	.num_clks = ARRAY_SIZE(sc7180_clks),
+
+	.power_domains = sc7180_gdscs,
+	.num_power_domains = ARRAY_SIZE(sc7180_gdscs),
+
+	.enable = sc7180_enable,
+	.set_rate = sc7180_set_rate,
+};
+
+static const struct udevice_id gcc_sc7180_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sc7180",
+		.data = (ulong)&sc7180_gcc_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_sc7180) = {
+	.name = "gcc_sc7180",
+	.id = UCLASS_NOP,
+	.of_match = gcc_sc7180_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.54.0

