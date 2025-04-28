Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D501C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B458782836;
	Mon, 28 Apr 2025 21:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KFftbRWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4BC9820FE; Mon, 28 Apr 2025 21:24:42 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA7880EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227b828de00so52911145ad.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868278; x=1746473078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SmUOF50WIfye4kAA4RJyskJ+XsrbvY6kLT5L8Z82KA=;
 b=KFftbRWz6/hEZdMU7MGnzCm36/4o9ItsG9ic4SzXocVJDNiJ+XjtX7jV7Ng4zQz4G0
 MfcH+8MwQ/2Wn3vP+1phWhIk/xFFX9VGgN0DfcC8+ReaPA0Lvx5NI+mQDLwCsOLx2OVt
 UawvJqVDoWzy2FUUO8evt3UtlEKRwVBSF2duU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868278; x=1746473078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SmUOF50WIfye4kAA4RJyskJ+XsrbvY6kLT5L8Z82KA=;
 b=JCimiG1xr94dUYfQPS7emKXufggIbbRaveZr2KvuuXNTBsIX0n4yKjneYz+rOMGX7U
 bmZaslx3vIVWs7kzCCQwNKggT7dIlF/hHZ6Pn9vuveyZ+nYpRSR6Z3rOHqlOcOyVD076
 NV4GU8S8+vOToPpYsc23d2XsRhMEUkeig1paFDpdIuXRDgDBMz0AWu/6fBvcbCpK6dxc
 lf/S3kttzS1H61ak5Y+jSPoyh/wYM7atRk7va+aj2XH98f8HKtOS5vUP7nFemZE0Pj5q
 olhwVG5t4Ux+GJvAWKlPO1wBqPPV+gtD7I01wa1vBcUdOMa9mXWweJw113QcgDKniGIa
 Gvhg==
X-Gm-Message-State: AOJu0YxpllX5BXb/fK6BdRCmr/IJn/kbhmGwT/pcnK59eZ2AHfZwZjOg
 499ktkMGhdXPWJBJ+0DfaJTzj7T8l8pGUOA3ntXO5SCZIMnaRFWUyaLk+JUYzJnxpwtx7XhMKU8
 =
X-Gm-Gg: ASbGncsg3qa3imlRc3/y+eJubVln04GDUvAjZo9H/TXtQ1JJbxoTmnwtrTtVBMTEDPv
 aedj+uM54Pr1bCoo1bc6OHLFN8YVa7l67cE8n9Ll8ywTTtmZA1C/zljKdH/xz2GyD0Uj00VnR66
 P+77FoC+malcJijpJLoEOjr+n2VHMQc8gwTeYoX7jrHf616X2q5B+d3k51FlgVFFtEKiuhz9Faa
 hdfCa3xKiXfAQEQRGyeXc9zaLlWEmugHRC9yrPBiqKlHno/u6NlnxRRHAhDXko9AoSBPWaTvH1J
 fBO2rKDLPxkiJE9eNI4ZRB0lkHgVplLBOBBMqgCThS0TTKqBGX77JXABZTlMyUNxaufVe5Tju9d
 mHQ==
X-Google-Smtp-Source: AGHT+IH3iGKCXru0zFwoevzt2FQJk7cRx9z6eQ9tEhhNLUEzsWMrmEC2k9pzvsJQOxu5BKq9H7ahGg==
X-Received: by 2002:a17:903:2311:b0:22d:b240:34fe with SMTP id
 d9443c01a7336-22de7028e1bmr3200005ad.25.1745868278038; 
 Mon, 28 Apr 2025 12:24:38 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50e7a40sm87382235ad.147.2025.04.28.12.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:37 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 05/17] spi: Add Qualcomm GENI SPI driver
Date: Mon, 28 Apr 2025 12:24:12 -0700
Message-ID: <20250428192427.3877612-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

Add a SPI driver for Qualcomm's GENI hardware.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/Kconfig         |  10 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-geni-qcom.c | 545 ++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+)
 create mode 100644 drivers/spi/spi-geni-qcom.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a3513f0a3ef8..9bdfc4c89204 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -430,6 +430,16 @@ config SPI_QUP
 	  mode supports up to 50MHz, up to four chip selects, programmable
 	  data path from 4 bits to 32 bits and numerous protocol variants.
 
+config SPI_GENI_QCOM
+	bool "Qualcomm Generic Interface (GENI) SPI controller"
+	depends on ARCH_SNAPDRAGON
+	help
+	  Support for the Qualcomm Generic Interface (GENI) SPI controller.
+	  The Generic Interface (GENI) is a firmware based Qualcomm Universal
+	  Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
+	  bus protocols depending on the firmware type loaded at early boot time
+	  based on system configuration.
+
 config RENESAS_RPC_SPI
 	bool "Renesas RPC SPI driver"
 	depends on RCAR_64 || RZA1
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index da91b18b6ed3..29c20b888278 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
 obj-$(CONFIG_PIC32_SPI) += pic32_spi.o
 obj-$(CONFIG_PL022_SPI) += pl022_spi.o
 obj-$(CONFIG_SPI_QUP) += spi-qup.o
+obj-$(CONFIG_SPI_GENI_QCOM) += spi-geni-qcom.o
 obj-$(CONFIG_SPI_MXIC) += spi-mxic.o
 obj-$(CONFIG_RENESAS_RPC_SPI) += renesas_rpc_spi.o
 obj-$(CONFIG_ROCKCHIP_SFC) += rockchip_sfc.o
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
new file mode 100644
index 000000000000..c865da5dd6c7
--- /dev/null
+++ b/drivers/spi/spi-geni-qcom.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/iopoll.h>
+#include <spi.h>
+#include <log.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <dm/read.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <time.h>
+#include <soc/qcom/geni-se.h>
+
+/* SPI SE specific registers and respective register fields */
+#define SE_SPI_CPHA		0x224
+#define CPHA			BIT(0)
+
+#define SE_SPI_LOOPBACK		0x22c
+#define LOOPBACK_ENABLE		0x1
+#define NORMAL_MODE		0x0
+#define LOOPBACK_MSK		GENMASK(1, 0)
+
+#define SE_SPI_CPOL		0x230
+#define CPOL			BIT(2)
+
+#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
+
+#define SE_SPI_DEMUX_SEL	0x250
+
+#define SE_SPI_TRANS_CFG	0x25c
+#define CS_TOGGLE		BIT(1)
+
+#define SE_SPI_WORD_LEN		0x268
+#define WORD_LEN_MSK		GENMASK(9, 0)
+#define MIN_WORD_LEN		4
+
+#define SE_SPI_TX_TRANS_LEN	0x26c
+#define SE_SPI_RX_TRANS_LEN	0x270
+#define TRANS_LEN_MSK		GENMASK(23, 0)
+
+#define SE_SPI_PRE_POST_CMD_DLY	0x274
+
+#define SE_SPI_DELAY_COUNTERS	0x278
+#define SPI_INTER_WORDS_DELAY_MSK	GENMASK(9, 0)
+#define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
+#define SPI_CS_CLK_DELAY_SHFT		10
+
+#define SE_GENI_M_IRQ_CLEAR	0x618
+#define SE_GENI_M_IRQ_STATUS	0x610
+
+/* M_CMD OP codes for SPI */
+#define SPI_TX_ONLY		1
+#define SPI_RX_ONLY		2
+#define SPI_TX_RX		7
+#define SPI_CS_ASSERT		8
+#define SPI_CS_DEASSERT		9
+#define SPI_SCK_ONLY		10
+/* M_CMD params for SPI */
+#define SPI_PRE_CMD_DELAY	BIT(0)
+#define TIMESTAMP_BEFORE	BIT(1)
+#define FRAGMENTATION		BIT(2)
+#define TIMESTAMP_AFTER		BIT(3)
+#define POST_CMD_DELAY		BIT(4)
+
+#define BYTES_PER_FIFO_WORD	4U
+
+struct geni_spi_priv {
+	fdt_addr_t wrapper;
+	phys_addr_t base;
+	struct clk clk;
+	u32 tx_depth;
+	bool cs_high;
+};
+
+static void geni_se_setup_m_cmd(struct geni_spi_priv *priv, u32 cmd, u32 params)
+{
+	u32 m_cmd;
+
+	debug("%s: cmd=%#x, parms=%#x\n", __func__, cmd, params);
+	m_cmd = (cmd << M_OPCODE_SHFT) | (params & M_PARAMS_MSK);
+	writel(m_cmd, priv->base + SE_GENI_M_CMD0);
+}
+
+static void handle_se_timeout(struct geni_spi_priv *priv)
+{
+	int ret;
+	u32 m_irq;
+
+	writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
+
+	writel(M_CMD_CANCEL_EN, priv->base + SE_GENI_M_CMD_CTRL_REG);
+
+	ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
+				 (m_irq & M_CMD_CANCEL_EN) == M_CMD_CANCEL_EN,
+				 100);
+	writel(M_CMD_CANCEL_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
+	if (ret < 0) {
+		printf("spi-geni-qcom: Cancel failed. Abort the operation\n");
+
+		writel_relaxed(M_CMD_ABORT_EN, priv->base + SE_GENI_M_CMD_CTRL_REG);
+		ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
+					 (m_irq & M_CMD_ABORT_EN) == M_CMD_ABORT_EN,
+					 100);
+		writel(M_CMD_ABORT_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
+		if (ret < 0)
+			printf("spi-geni-qcom: Abort failed\n");
+	}
+}
+
+static int geni_spi_set_speed(struct udevice *dev, uint speed)
+{
+	/* TODO: Set a clk frequency or change divider here */
+	return 0;
+}
+
+static int geni_spi_set_mode(struct udevice *bus, uint mode)
+{
+	struct geni_spi_priv *priv = dev_get_priv(bus);
+	u32 loopback_cfg = 0, cpol = 0, cpha = 0;
+
+	if (mode & SPI_LOOP)
+		loopback_cfg = LOOPBACK_ENABLE;
+
+	if (mode & SPI_CPOL)
+		cpol = CPOL;
+
+	if (mode & SPI_CPHA)
+		cpha = CPHA;
+
+	if (mode & SPI_CS_HIGH)
+		priv->cs_high = true;
+
+	writel(loopback_cfg, priv->base + SE_SPI_LOOPBACK);
+	writel(cpha, priv->base + SE_SPI_CPHA);
+	writel(cpol, priv->base + SE_SPI_CPOL);
+
+	return 0;
+}
+
+static void geni_spi_reset(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct geni_spi_priv *priv = dev_get_priv(bus);
+
+	/* Driver may not be probed yet */
+	if (!priv)
+		return;
+}
+
+#define NUM_PACKING_VECTORS 4
+#define PACKING_START_SHIFT 5
+#define PACKING_DIR_SHIFT 4
+#define PACKING_LEN_SHIFT 1
+#define PACKING_STOP_BIT BIT(0)
+#define PACKING_VECTOR_SHIFT 10
+static void geni_spi_config_packing(struct geni_spi_priv *geni, int bpw,
+				    int pack_words, bool msb_to_lsb,
+				    bool tx_cfg, bool rx_cfg)
+{
+	u32 cfg0, cfg1, cfg[NUM_PACKING_VECTORS] = {0};
+	int len;
+	int temp_bpw = bpw;
+	int idx_start = msb_to_lsb ? bpw - 1 : 0;
+	int idx = idx_start;
+	int idx_delta = msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE;
+	int ceil_bpw = ALIGN(bpw, BITS_PER_BYTE);
+	int iter = (ceil_bpw * pack_words) / BITS_PER_BYTE;
+	int i;
+
+	if (iter <= 0 || iter > NUM_PACKING_VECTORS)
+		return;
+
+	for (i = 0; i < iter; i++) {
+		len = min_t(int, temp_bpw, BITS_PER_BYTE) - 1;
+		cfg[i] = idx << PACKING_START_SHIFT;
+		cfg[i] |= msb_to_lsb << PACKING_DIR_SHIFT;
+		cfg[i] |= len << PACKING_LEN_SHIFT;
+
+		if (temp_bpw <= BITS_PER_BYTE) {
+			idx = ((i + 1) * BITS_PER_BYTE) + idx_start;
+			temp_bpw = bpw;
+		} else {
+			idx = idx + idx_delta;
+			temp_bpw = temp_bpw - BITS_PER_BYTE;
+		}
+	}
+	cfg[iter - 1] |= PACKING_STOP_BIT;
+	cfg0 = cfg[0] | (cfg[1] << PACKING_VECTOR_SHIFT);
+	cfg1 = cfg[2] | (cfg[3] << PACKING_VECTOR_SHIFT);
+
+	if (tx_cfg) {
+		writel(cfg0, geni->base + SE_GENI_TX_PACKING_CFG0);
+		writel(cfg1, geni->base + SE_GENI_TX_PACKING_CFG1);
+	}
+	if (rx_cfg) {
+		writel(cfg0, geni->base + SE_GENI_RX_PACKING_CFG0);
+		writel(cfg1, geni->base + SE_GENI_RX_PACKING_CFG1);
+	}
+
+	/*
+	 * Number of protocol words in each FIFO entry
+	 * 0 - 4x8, four words in each entry, max word size of 8 bits
+	 * 1 - 2x16, two words in each entry, max word size of 16 bits
+	 * 2 - 1x32, one word in each entry, max word size of 32 bits
+	 * 3 - undefined
+	 */
+	if (pack_words || bpw == 32)
+		writel(bpw / 16, geni->base + SE_GENI_BYTE_GRAN);
+}
+
+static u32 geni_spi_get_tx_fifo_depth(struct geni_spi_priv *geni)
+{
+	u32 val, hw_version, hw_major, hw_minor, tx_fifo_depth_mask;
+
+	hw_version = readl(geni->wrapper + QUP_HW_VER_REG);
+	hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
+		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK_256_BYTES;
+	else
+		tx_fifo_depth_mask = TX_FIFO_DEPTH_MSK;
+
+	val = readl(geni->base + SE_HW_PARAM_0);
+
+	return (val & tx_fifo_depth_mask) >> TX_FIFO_DEPTH_SHFT;
+}
+
+static void geni_spi_drain_rx(struct geni_spi_priv *geni)
+{
+	u32 rx_fifo_status;
+	unsigned int rx_bytes;
+	unsigned int rx_last_byte_valid;
+	unsigned int i;
+
+	rx_fifo_status = readl(geni->base + SE_GENI_RX_FIFO_STATUS);
+	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * BYTES_PER_FIFO_WORD;
+	if (rx_fifo_status & RX_LAST) {
+		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
+		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
+		if (rx_last_byte_valid && rx_last_byte_valid < 4)
+			rx_bytes -= BYTES_PER_FIFO_WORD - rx_last_byte_valid;
+	}
+
+	for (i = 0; i < DIV_ROUND_UP(rx_bytes, BYTES_PER_FIFO_WORD); i++)
+		readl(geni->base + SE_GENI_RX_FIFOn);
+}
+
+static void geni_spi_hw_init(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct geni_spi_priv *geni = dev_get_priv(bus);
+	u32 demux_output_inv = 0;
+	u32 val, demux_sel;
+
+	writel(0, geni->base + SE_GSI_EVENT_EN);
+	writel(0xffffffff, geni->base + SE_GENI_M_IRQ_CLEAR);
+	writel(0xffffffff, geni->base + SE_GENI_S_IRQ_CLEAR);
+	writel(0xffffffff, geni->base + SE_IRQ_EN);
+
+	val = readl(geni->base + GENI_CGC_CTRL);
+	val |= DEFAULT_CGC_EN;
+	writel(val, geni->base + GENI_CGC_CTRL);
+
+	writel(DEFAULT_IO_OUTPUT_CTRL_MSK, geni->base + GENI_OUTPUT_CTRL);
+	writel(FORCE_DEFAULT, geni->base + GENI_FORCE_DEFAULT_REG);
+
+	val = readl(geni->base + SE_IRQ_EN);
+	val |= GENI_M_IRQ_EN | GENI_S_IRQ_EN;
+	writel(val, geni->base + SE_IRQ_EN);
+
+	val = readl(geni->base + SE_GENI_DMA_MODE_EN);
+	val &= ~GENI_DMA_MODE_EN;
+	writel(val, geni->base + SE_GENI_DMA_MODE_EN);
+
+	writel(0, geni->base + SE_GSI_EVENT_EN);
+
+	writel(geni->tx_depth - 3, geni->base + SE_GENI_RX_WATERMARK_REG);
+	writel(geni->tx_depth - 2, geni->base + SE_GENI_RX_RFR_WATERMARK_REG);
+
+	val = readl(geni->base + SE_GENI_M_IRQ_EN);
+	val |= M_COMMON_GENI_M_IRQ_EN;
+	val |= M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN;
+	val |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
+	writel(val, geni->base + SE_GENI_M_IRQ_EN);
+
+	val = readl(geni->base + SE_GENI_S_IRQ_EN);
+	val |= S_COMMON_GENI_S_IRQ_EN;
+	writel(val, geni->base + SE_GENI_S_IRQ_EN);
+
+	if (geni->cs_high)
+		demux_output_inv = BIT(spi_chip_select(dev));
+	demux_sel = spi_chip_select(dev);
+	writel(demux_sel, geni->base + SE_SPI_DEMUX_SEL);
+	writel(demux_output_inv, geni->base + SE_SPI_DEMUX_OUTPUT_INV);
+
+	writel(((8 - MIN_WORD_LEN) & WORD_LEN_MSK), geni->base + SE_SPI_WORD_LEN);
+	geni_spi_config_packing(geni, BITS_PER_BYTE, 4, true, true, true);
+
+	geni_spi_drain_rx(geni);
+}
+
+static int geni_spi_claim_bus(struct udevice *dev)
+{
+	geni_spi_hw_init(dev);
+	return 0;
+}
+
+static int geni_spi_release_bus(struct udevice *dev)
+{
+	/* Reset the SPI hardware */
+	geni_spi_reset(dev);
+
+	return 0;
+}
+
+static int geni_spi_set_cs(struct udevice *bus, bool enable)
+{
+	struct geni_spi_priv *priv = dev_get_priv(bus);
+	u32 m_cmd = 0, m_irq;
+	int ret;
+
+	debug("%s: enable=%d\n", __func__, enable);
+
+	m_cmd = enable ? SPI_CS_ASSERT : SPI_CS_DEASSERT;
+	geni_se_setup_m_cmd(priv, m_cmd, 0);
+
+	ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
+				 (m_irq & M_CMD_DONE_EN) == M_CMD_DONE_EN,
+				 100);
+	writel(M_CMD_DONE_EN, priv->base + SE_GENI_M_IRQ_CLEAR);
+	if (ret) {
+		printf("spi-geni-qcom: Timeout setting cs\n");
+		handle_se_timeout(priv);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int
+geni_spi_handle_tx(struct geni_spi_priv *geni, const u8 *dout, unsigned int tx_rem_bytes)
+{
+	unsigned int max_bytes;
+	unsigned int i = 0;
+
+	max_bytes = (geni->tx_depth - 1) * BYTES_PER_FIFO_WORD;
+	if (tx_rem_bytes < max_bytes)
+		max_bytes = tx_rem_bytes;
+
+	while (i < max_bytes) {
+		unsigned int j;
+		unsigned int bytes_to_write;
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+
+		bytes_to_write = min(BYTES_PER_FIFO_WORD, max_bytes - i);
+		for (j = 0; j < bytes_to_write; j++)
+			fifo_byte[j] = dout[i++];
+		iowrite32_rep((void *)(geni->base + SE_GENI_TX_FIFOn), &fifo_word, 1);
+	}
+	tx_rem_bytes -= max_bytes;
+	if (!tx_rem_bytes)
+		writel(0, geni->base + SE_GENI_TX_WATERMARK_REG);
+
+	return max_bytes;
+}
+
+static int geni_spi_handle_rx(struct geni_spi_priv *geni, u8 *din, unsigned int rx_rem_bytes)
+{
+	u32 rx_fifo_status;
+	unsigned int rx_bytes;
+	unsigned int rx_last_byte_valid;
+	unsigned int i = 0;
+
+	rx_fifo_status = readl(geni->base + SE_GENI_RX_FIFO_STATUS);
+	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * BYTES_PER_FIFO_WORD;
+	if (rx_fifo_status & RX_LAST) {
+		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
+		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
+		if (rx_last_byte_valid && rx_last_byte_valid < 4)
+			rx_bytes -= BYTES_PER_FIFO_WORD - rx_last_byte_valid;
+	}
+
+	if (rx_rem_bytes < rx_bytes)
+		rx_bytes = rx_rem_bytes;
+
+	while (i < rx_bytes) {
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+		unsigned int bytes_to_read;
+		unsigned int j;
+
+		bytes_to_read = min(BYTES_PER_FIFO_WORD, rx_bytes - i);
+		ioread32_rep((void *)(geni->base + SE_GENI_RX_FIFOn), &fifo_word, 1);
+		for (j = 0; j < bytes_to_read; j++)
+			din[i++] = fifo_byte[j];
+	}
+
+	return rx_bytes;
+}
+
+static int geni_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			 const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct geni_spi_priv *priv = dev_get_priv(bus);
+	unsigned int len = bitlen >> 3;
+	unsigned int rx_rem_bytes = din ? len : 0;
+	unsigned int tx_rem_bytes = dout ? len : 0;
+	int ret = 0;
+	u32 m_cmd = 0, m_irq;
+	ulong start;
+
+	if (len & ~TRANS_LEN_MSK) {
+		printf("spi-geni-qcom: transfer length too long (%d)\n", len);
+		return -EINVAL;
+	}
+
+	if (flags & SPI_XFER_BEGIN) {
+		geni_spi_hw_init(dev);
+		ret = geni_spi_set_cs(bus, true);
+		if (ret != 0)
+			return ret;
+	}
+
+	if (len) {
+		if (din) {
+			m_cmd |= SPI_RX_ONLY;
+			writel(len, priv->base + SE_SPI_RX_TRANS_LEN);
+		}
+		if (dout) {
+			m_cmd |= SPI_TX_ONLY;
+			writel(len, priv->base + SE_SPI_TX_TRANS_LEN);
+			writel(1, priv->base + SE_GENI_TX_WATERMARK_REG);
+		}
+
+		geni_se_setup_m_cmd(priv, m_cmd, FRAGMENTATION);
+
+		start = get_timer(0);
+		do {
+			ret = readl_poll_timeout(priv->base + SE_GENI_M_IRQ_STATUS, m_irq,
+						 m_irq != 0, 1000);
+			if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN)) {
+				rx_rem_bytes -= geni_spi_handle_rx(priv, din + len - rx_rem_bytes,
+								   rx_rem_bytes);
+			}
+			if (m_irq & M_TX_FIFO_WATERMARK_EN) {
+				tx_rem_bytes -= geni_spi_handle_tx(priv, dout + len - tx_rem_bytes,
+								   tx_rem_bytes);
+			}
+			writel(m_irq, priv->base + SE_GENI_M_IRQ_CLEAR);
+			if (m_irq & M_CMD_DONE_EN)
+				break;
+		} while (get_timer(start) < 100000);
+
+		if (!(m_irq & M_CMD_DONE_EN) || tx_rem_bytes || rx_rem_bytes) {
+			printf("spi-geni-qcom: Transfer failed\n");
+			handle_se_timeout(priv);
+			return -ETIMEDOUT;
+		}
+	}
+
+	if (flags & SPI_XFER_END) {
+		ret = geni_spi_set_cs(bus, false);
+		if (ret != 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static const struct dm_spi_ops geni_spi_ops = {
+	.claim_bus	= geni_spi_claim_bus,
+	.release_bus	= geni_spi_release_bus,
+	.xfer		= geni_spi_xfer,
+	.set_speed	= geni_spi_set_speed,
+	.set_mode	= geni_spi_set_mode,
+};
+
+static int geni_spi_probe(struct udevice *dev)
+{
+	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
+	struct geni_spi_priv *priv = dev_get_priv(dev);
+	int ret;
+	u32 proto, fifo_disable;
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->wrapper = ofnode_get_addr(parent_node);
+	if (priv->wrapper == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret < 0)
+		return ret;
+
+	proto = readl(priv->base + GENI_FW_REVISION_RO);
+	proto &= FW_REV_PROTOCOL_MSK;
+	proto >>= FW_REV_PROTOCOL_SHFT;
+
+	if (proto != GENI_SE_SPI) {
+		dev_err(dev, "Invalid proto %d\n", proto);
+		clk_disable(&priv->clk);
+		return -ENXIO;
+	}
+
+	fifo_disable = readl(priv->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+	if (fifo_disable) {
+		dev_err(dev, "FIFO mode disabled, DMA mode unsupported\n");
+		clk_disable(&priv->clk);
+		return -ENXIO;
+	}
+
+	priv->tx_depth = geni_spi_get_tx_fifo_depth(priv);
+
+	return 0;
+}
+
+static const struct udevice_id spi_geni_ids[] = {
+	{ .compatible = "qcom,geni-spi" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(geni_spi) = {
+	.name		= "geni_spi",
+	.id		= UCLASS_SPI,
+	.of_match	= spi_geni_ids,
+	.ops		= &geni_spi_ops,
+	.priv_auto	= sizeof(struct geni_spi_priv),
+	.probe		= geni_spi_probe,
+};
-- 
Sent by a computer, using git, on the internet

