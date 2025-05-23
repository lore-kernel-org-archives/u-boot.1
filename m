Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5368C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4333883439;
	Sat, 24 May 2025 01:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YRP2lUEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DE18334D; Sat, 24 May 2025 00:58:54 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933FD8333D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so514626b3a.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041131; x=1748645931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUTu9sdvjQ7FF6Zjm8DSC6RJjMx8vh/W1Q0khGCKIFU=;
 b=YRP2lUExnPe87AYPBY5n9xXfXlRQ0Zx5vLNqSxWEfv0f7YpxndS/dB+/hHNhl059sY
 eOEheskYRP8JLC5nqDs5/H38Vf20xsKNaQJdrptPK3OGmiBZIlMxQDTOiBOQexprjDut
 zvg75R4cKuhDuA796IxF4ySSXSmajXWm4f5Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041131; x=1748645931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUTu9sdvjQ7FF6Zjm8DSC6RJjMx8vh/W1Q0khGCKIFU=;
 b=M9nNzs4cZuocLUcz99I8xs+jhHcafzVYnH4j+sL1i+rnBUOiT9m3smAGPn5MvBeKIP
 5GIiETDJGf+LBfFrDPYmJqd5shfis0dht52pPUhcsO7fz/KUhifsfHTcg+turLLacAL+
 gVfZ5Juyj41BGLEs2sE5sKD1lnLo0Hn8sBKud8ekL9vbR6ypzhu/OXmBxp49Qh+/SZHl
 iculTkg32tEQgPe2AXrqE+NldcFxIuMBZO9bYHp9hxW4Y+MrjKJoEbbLnQNZESbmI+h7
 7x3JGCnlbGsnSLZDw5pIgv72IebCQDJ41KTXctb8dbPhq4dhuSk9jbBctQ5TejNGY5MD
 al1g==
X-Gm-Message-State: AOJu0YwNQcxph+kOQH8WVn0JyBiLJ2b7fFU8ZLmxuxBNUm5OlIZk0ld1
 S5p4yN18uWVootWY8nomfp0cqtH3td6UQ/h+fHBtb4haMH0mSm97m/rc8lkzOiTx6pV0/Wg2tml
 UGWw=
X-Gm-Gg: ASbGncv4K6C4HESsNWIa4YUwTzTWl0JoQ10vE7A0oL6lO6Q52Wc2lM7gTYvDIg+53fn
 fUfEtwjwSGO2AB6DGIrCxQXFtZkKhlZsaBdCpJgWabEv3A6Tn0XwBq7QvBsw+5LdOf8fULoNLcR
 6AwVKqfk0x3a/z14b6atWZs1LkbnXTZ2muwNUDyy/+CH+raUqX1HZ+STu/L/+e4BbsXoL32yBLY
 4EaGbzxP0hbdZVcAJbkgscF3QIshGM2/GNrxozr/zaXWH/npgo+ACEdr22rDZNV4A6TYz/D0XeI
 xSiKzb0nsxNpDWuOgHpqQLihWjEZ++VEeS0h4Qp3poNp7f4mPgdlkbNm2Q8Ot0WyBabbj8kBArM
 Ktb6ZydwLOsrKIgc=
X-Google-Smtp-Source: AGHT+IET8rUfrU3d63zpossutCMhTF1OITcX7eN0CWdYxxaKCg2AF3UFj4RQjZpEB2CcCqqiuErRhA==
X-Received: by 2002:a05:6a20:ce43:b0:1f5:8d30:a4db with SMTP id
 adf61e73a8af0-2188c1e85aemr1660324637.9.1748041130937; 
 Fri, 23 May 2025 15:58:50 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf8e13csm13284770a12.45.2025.05.23.15.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:50 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 02/28] clk: qcom: Add driver for sc7180
Date: Fri, 23 May 2025 15:58:17 -0700
Message-ID: <20250523225845.2311989-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

The clks are already configured properly by coreboot on sc7180, but this
is good enough to make the MMC and USB drivers work.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/Kconfig        |   8 ++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-sc7180.c | 153 ++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-sc7180.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3ea01f3c969a..f310fd0d78f6 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -111,6 +111,14 @@ config CLK_QCOM_SM8650
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
index e13fc8c10717..ddca98950d47 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
new file mode 100644
index 000000000000..e5b9c4f46f41
--- /dev/null
+++ b/drivers/clk/qcom/clock-sc7180.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for Qualcomm sc7180
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+#include "clock-qcom.h"
+
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s3_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	{ }
+};
+
+static ulong sc7180_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP1_S2_CLK: /* UART8 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x18278,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		/* DT has 150000000 but this is actually rounded to 200000000 */
+		WARN(rate != 150000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		clk_rcg_set_rate(priv->base, 0xf060, 0, 0);
+		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		/* TODO: Actually set a rate here */
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk sc7180_clks[] = {
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x502c, 1),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x8201c, 1),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 1),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 1),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x52008, BIT(22)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x52008, BIT(24)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x12008, 1),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x1200c, 1),
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
+	debug("%s: clk %ld: %s\n", __func__, clk->id, sc7180_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		fallthrough;
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
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct qcom_power_map sc7180_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
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
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_sc7180) = {
+	.name		= "gcc_sc7180",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_sc7180_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
Sent by a computer, using git, on the internet

