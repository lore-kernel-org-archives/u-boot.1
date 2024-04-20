Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07658C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34DCA88629;
	Sat, 20 Apr 2024 12:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="myX3ypbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2DC881BC; Sat, 20 Apr 2024 09:09:46 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB62F8811C
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2b137d666so22276015ad.2
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596981; x=1714201781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zC0PKcOYM9gJnsVKNa6OqOHyC4aCGQRCDrdV9g0CX8=;
 b=myX3ypbXBpkBNJJ0dHe5HXXFQZ3hCF3kVdkaUif4IX+LPLqKqnrLUmeVdfxw4WpE2A
 q3VbM2n6Y+e77+nel4XSJVcUrYMLnn9ipqH2K2ia5fMgZMxRSz+od21P4O3KWCo3VG41
 zcL/eyjB0vaWBuW2Y/g7Ru48x6Fcgy+nUjQqrwsLzb2zYwPua8mjeqJMkat80wXD5IuN
 EmxnhlrBOj7HKVQuOl8+BeH0OjUc/XMqUq+aD/qpEb/CN1GLSkqtSEtC9aTlFr03uKWO
 SgIUoRS5aMGR5G3zenHi9qB3nXKMnw2oXqrCXy3Evgi0Reopsi9oiskSsVD73jr7ZB+o
 CpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596981; x=1714201781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zC0PKcOYM9gJnsVKNa6OqOHyC4aCGQRCDrdV9g0CX8=;
 b=fhR2KYOnlrP7+iV7kc8u5UChEgtcEk+zjV7YT6fzDNthRP7yeDsMG/tJZve5Gl5E7D
 kYFnmflLV/BZIVYaDkfeVGRUmu/n6RbLc58CjQd4FgaM6Q5KjNymXRDtzNfhcXK22wuz
 BLS4ORirqRX9zlF3FntEZpCvF7YOoOtWRfWSk535rqH/y1MA93rFmv3wY5VD8Z1nO746
 nfEN6rK297XM8L+tw86ZCfwyBAZCRyNi069SlCf4tLpcWF14FOi2j55XQbnb+Wx5WH9p
 OJ+xjre5Pf3fxgYStFsSPuzYyQ/IyC9XEcDOTFq/oktS/vTzuDh1SudvORT1EqkKfghd
 Bx5w==
X-Gm-Message-State: AOJu0YwXepw4fOE7dgz07P0Ckn6/nlJrGMrlPqmXdGGXJW6Nmx2ZOqAY
 5eSEg4oKqT36FKZ/OIDwPCu9F8mal20a6qRbQWc01EAo7Vt6q7kR191kRIdQvIo=
X-Google-Smtp-Source: AGHT+IGWtR8/XptdLKdn8XCf2MKffs9vx+84afRhZQmW3oUQjI0ldWM6tEKMoDziqbJAsC1HPzg8Ww==
X-Received: by 2002:a17:902:8f83:b0:1e3:999a:9726 with SMTP id
 z3-20020a1709028f8300b001e3999a9726mr4149724plo.29.1713596981469; 
 Sat, 20 Apr 2024 00:09:41 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170903248500b001e43576a7a1sm4443065plw.222.2024.04.20.00.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:09:41 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hai Pham <hai.pham.ud@renesas.com>, Igor Prusov <IVPrusov@sberdevices.ru>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 1/3] spi: cv1800b: Add spi nor flash controller driver for
 cv1800b SoC
Date: Sat, 20 Apr 2024 15:08:23 +0800
Message-ID: <20240420070923.9154-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070923.9154-1-seashell11234455@gmail.com>
References: <20240420070923.9154-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

Add spi nor flash controller driver for cv1800b SoC

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 drivers/spi/Kconfig        |   8 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/cv1800b_spif.c | 321 +++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 drivers/spi/cv1800b_spif.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 612434633b..35030ab355 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -168,6 +168,14 @@ config CF_SPI
           Enable the ColdFire SPI driver. This driver can be used on
           some m68k SoCs.
 
+config CV1800B_SPIF
+	bool "Sophgo cv1800b SPI Flash Controller driver"
+	depends on SPI_MEM
+	help
+	  Enable the Sophgo cv1800b SPI Flash Controller driver. This driver
+	  can be used to access the SPI NOR flash on platforms embedding this
+	  Sophgo cv1800b IP core.
+
 config DAVINCI_SPI
 	bool "Davinci & Keystone SPI driver"
 	depends on ARCH_DAVINCI || ARCH_KEYSTONE
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 14bdb97f18..32d7bf7237 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_BCM63XX_SPI) += bcm63xx_spi.o
 obj-$(CONFIG_BCMSTB_SPI) += bcmstb_spi.o
 obj-$(CONFIG_CF_SPI) += cf_spi.o
 obj-$(CONFIG_CORTINA_SFLASH) += ca_sflash.o
+obj-$(CONFIG_CV1800B_SPIF) += cv1800b_spif.o
 obj-$(CONFIG_DAVINCI_SPI) += davinci_spi.o
 obj-$(CONFIG_DESIGNWARE_SPI) += designware_spi.o
 obj-$(CONFIG_EXYNOS_SPI) += exynos_spi.o
diff --git a/drivers/spi/cv1800b_spif.c b/drivers/spi/cv1800b_spif.c
new file mode 100644
index 0000000000..9c077f3ff9
--- /dev/null
+++ b/drivers/spi/cv1800b_spif.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <spi-mem.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <wait_bit.h>
+
+#define CV1800B_SPI_CTRL_SCK_DIV_MASK                GENMASK(10, 0)
+#define CV1800B_SPI_CTRL_CPHA                        BIT(12)
+#define CV1800B_SPI_CTRL_CPOL                        BIT(13)
+
+#define CV1800B_SPI_CE_MANUAL                        BIT(0)
+#define CV1800B_SPI_CE_MANUAL_EN                     BIT(1)
+#define CV1800B_SPI_CE_ENABLE                        (CV1800B_SPI_CE_MANUAL | \
+						      CV1800B_SPI_CE_MANUAL_EN)
+#define CV1800B_SPI_CE_DISABLE                       CV1800B_SPI_CE_MANUAL_EN
+#define CV1800B_SPI_CE_HARDWARE                      0
+
+#define CV1800B_SPI_DLY_CTRL_NEG_SAMPLE              BIT(14)
+
+#define CV1800B_SPI_TRAN_MODE_RX                     BIT(0)
+#define CV1800B_SPI_TRAN_MODE_TX                     BIT(1)
+#define CV1800B_SPI_TRAN_FAST_MODE                   BIT(3)
+#define CV1800B_SPI_TRAN_BUS_WIDTH_1_BIT             0x0
+#define CV1800B_SPI_TRAN_BUS_WIDTH_2_BIT             BIT(4)
+#define CV1800B_SPI_TRAN_BUS_WIDTH_4_BIT             BIT(5)
+#define CV1800B_SPI_TRAN_ADDR_3_BYTES                (3 << 8)
+#define CV1800B_SPI_TRAN_ADDR_4_BYTES                (4 << 8)
+#define CV1800B_SPI_TRAN_WITH_CMD                    BIT(11)
+#define CV1800B_SPI_TRAN_GO_BUSY                     BIT(15)
+#define CV1800B_SPI_TRAN_DUMMY_CYC_MASK              GENMASK(19, 16)
+#define CV1800B_SPI_TRAN_DUMMY_CYC_OFFSET            16
+#define CV1800B_SPI_TRAN_BYTE4_EN                    BIT(20)
+#define CV1800B_SPI_TRAN_BYTE4_CMD                   BIT(21)
+
+#define CV1800B_SPI_FF_PT_AVAILABLE_MASK             GENMASK(3, 0)
+
+#define CV1800B_SPI_INT_TRAN_DONE                    BIT(0)
+#define CV1800B_SPI_INT_RD_FIFO                      BIT(2)
+#define CV1800B_SPI_INT_WR_FIFO                      BIT(3)
+
+#define CV1800B_FIFO_CAPACITY           8
+#define CV1800B_DEFAULT_DIV             4
+
+struct cv1800b_spif_regs {
+	u32 spi_ctrl;
+	u32 ce_ctrl;
+	u32 dly_ctrl;
+	u32 dmmr_ctrl;
+	u32 tran_csr;
+	u32 tran_num;
+	u32 ff_port;
+	u32 reserved0;
+	u32 ff_pt;
+	u32 reserved1;
+	u32 int_sts;
+	u32 int_en;
+};
+
+struct cv1800b_spi_priv {
+	struct cv1800b_spif_regs *regs;
+	uint clk_freq;
+	uint mode;
+	int div;
+};
+
+static int cv1800b_spi_probe(struct udevice *bus)
+{
+	struct cv1800b_spi_priv *priv = dev_get_priv(bus);
+	struct clk clkdev;
+	int ret;
+
+	priv->regs = (struct cv1800b_spif_regs *)dev_read_addr_ptr(bus);
+	if (priv->regs == 0)
+		return -EINVAL;
+
+	ret = clk_get_by_index(bus, 0, &clkdev);
+	if (ret)
+		return ret;
+	priv->clk_freq = clk_get_rate(&clkdev);
+
+	/* DMMR mode is enabled by default, disable it */
+	writel(0, &priv->regs->dmmr_ctrl);
+
+	return 0;
+}
+
+static void cv1800b_spi_config_dmmr(struct cv1800b_spi_priv *priv, struct spi_nor *flash)
+{
+	struct cv1800b_spif_regs *regs = priv->regs;
+	u32 read_cmd = flash->read_opcode;
+	u32 val;
+
+	val = CV1800B_SPI_TRAN_MODE_RX | CV1800B_SPI_TRAN_WITH_CMD;
+
+	switch (read_cmd) {
+	case SPINOR_OP_READ_4B:
+	case SPINOR_OP_READ_FAST_4B:
+	case SPINOR_OP_READ_1_1_2_4B:
+	case SPINOR_OP_READ_1_1_4_4B:
+		val |= CV1800B_SPI_TRAN_ADDR_4_BYTES |
+		       CV1800B_SPI_TRAN_BYTE4_EN | CV1800B_SPI_TRAN_BYTE4_CMD;
+		break;
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_1_1_2:
+	case SPINOR_OP_READ_1_1_4:
+		val |= CV1800B_SPI_TRAN_ADDR_3_BYTES;
+		break;
+	}
+
+	switch (read_cmd) {
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_FAST_4B:
+		val |= CV1800B_SPI_TRAN_FAST_MODE;
+		break;
+	}
+
+	switch (read_cmd) {
+	case SPINOR_OP_READ_1_1_2:
+	case SPINOR_OP_READ_1_1_2_4B:
+		val |= CV1800B_SPI_TRAN_BUS_WIDTH_2_BIT;
+		break;
+	case SPINOR_OP_READ_1_1_4:
+	case SPINOR_OP_READ_1_1_4_4B:
+		val |= CV1800B_SPI_TRAN_BUS_WIDTH_4_BIT;
+		break;
+	}
+
+	val |= (flash->read_dummy & CV1800B_SPI_TRAN_DUMMY_CYC_MASK)
+	       << CV1800B_SPI_TRAN_DUMMY_CYC_OFFSET;
+	writel(val, &regs->tran_csr);
+}
+
+static void cv1800b_set_clk_div(struct cv1800b_spi_priv *priv, u32 div)
+{
+	struct cv1800b_spif_regs *regs = priv->regs;
+	u32 neg_sample = 0;
+
+	clrsetbits_le32(&regs->spi_ctrl, CV1800B_SPI_CTRL_SCK_DIV_MASK, div);
+
+	if (div < CV1800B_DEFAULT_DIV)
+		neg_sample = CV1800B_SPI_DLY_CTRL_NEG_SAMPLE;
+	clrsetbits_le32(&regs->dly_ctrl, CV1800B_SPI_DLY_CTRL_NEG_SAMPLE, neg_sample);
+}
+
+static int cv1800b_spi_transfer(struct cv1800b_spi_priv *priv,
+				u8 *din, const u8 *dout, uint len, ulong flags)
+{
+	struct cv1800b_spif_regs *regs = priv->regs;
+	u32 tran_csr;
+	u32 xfer_size, off;
+	u32 fifo_cnt;
+	u32 interrupt_mask;
+
+	if (din) {
+		/* Slow down on receiving */
+		cv1800b_set_clk_div(priv, CV1800B_DEFAULT_DIV);
+		interrupt_mask = CV1800B_SPI_INT_RD_FIFO;
+	} else {
+		interrupt_mask = CV1800B_SPI_INT_WR_FIFO;
+	}
+
+	writel(0, &regs->ff_pt);
+	writel(len, &regs->tran_num);
+
+	tran_csr = CV1800B_SPI_TRAN_GO_BUSY;
+	if (din) {
+		tran_csr |= CV1800B_SPI_TRAN_MODE_RX;
+	} else {
+		tran_csr |= CV1800B_SPI_TRAN_MODE_TX;
+		if (!(flags & SPI_XFER_BEGIN) && (priv->mode & SPI_TX_QUAD))
+			tran_csr |= CV1800B_SPI_TRAN_BUS_WIDTH_4_BIT;
+	}
+	writel(tran_csr, &regs->tran_csr);
+
+	wait_for_bit_le32(&regs->int_sts, interrupt_mask, true, 3000, false);
+
+	off = 0;
+	while (off < len) {
+		xfer_size = min_t(u32, len - off, CV1800B_FIFO_CAPACITY);
+
+		fifo_cnt = readl(&regs->ff_pt) & CV1800B_SPI_FF_PT_AVAILABLE_MASK;
+		if (din)
+			xfer_size = min(xfer_size, fifo_cnt);
+		else
+			xfer_size = min(xfer_size, CV1800B_FIFO_CAPACITY - fifo_cnt);
+
+		while (xfer_size--) {
+			if (din)
+				din[off++] = readb(&regs->ff_port);
+			else
+				writeb(dout[off++], &regs->ff_port);
+		}
+	}
+
+	wait_for_bit_le32(&regs->int_sts, CV1800B_SPI_INT_TRAN_DONE, true, 3000, false);
+	writel(0, &regs->ff_pt);
+	clrbits_le32(&regs->int_sts, CV1800B_SPI_INT_TRAN_DONE | interrupt_mask);
+
+	if (din)
+		cv1800b_set_clk_div(priv, priv->div);
+	return 0;
+}
+
+static int cv1800b_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			    const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev->parent;
+	struct cv1800b_spi_priv *priv = dev_get_priv(bus);
+	struct cv1800b_spif_regs *regs = priv->regs;
+
+	if (bitlen == 0)
+		goto out;
+
+	if (bitlen % 8) {
+		flags |= SPI_XFER_END;
+		goto out;
+	}
+
+	if (flags & SPI_XFER_BEGIN)
+		writel(CV1800B_SPI_CE_DISABLE, &regs->ce_ctrl);
+
+	if (din || dout)
+		cv1800b_spi_transfer(priv, din, dout, bitlen / 8, flags);
+
+out:
+	if (flags & SPI_XFER_END)
+		writel(CV1800B_SPI_CE_ENABLE, &regs->ce_ctrl);
+	return 0;
+}
+
+static int cv1800b_spi_set_speed(struct udevice *bus, uint speed)
+{
+	struct cv1800b_spi_priv *priv = dev_get_priv(bus);
+
+	priv->div = DIV_ROUND_CLOSEST(priv->clk_freq, speed * 2) - 1;
+	if (priv->div <= 0)
+		priv->div = CV1800B_DEFAULT_DIV;
+
+	cv1800b_set_clk_div(priv, priv->div);
+
+	return 0;
+}
+
+static int cv1800b_spi_set_mode(struct udevice *bus, uint mode)
+{
+	struct cv1800b_spi_priv *priv = dev_get_priv(bus);
+	struct cv1800b_spif_regs *regs = priv->regs;
+	u32 val = 0;
+
+	if (mode & SPI_CPHA)
+		val |= CV1800B_SPI_CTRL_CPHA;
+	if (mode & SPI_CPOL)
+		val |= CV1800B_SPI_CTRL_CPOL;
+	clrsetbits_le32(&regs->spi_ctrl, CV1800B_SPI_CTRL_CPHA | CV1800B_SPI_CTRL_CPOL, val);
+
+	priv->mode = mode;
+
+	return 0;
+}
+
+static int cv1800b_spi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct cv1800b_spi_priv *priv = dev_get_priv(bus);
+	struct cv1800b_spif_regs *regs = priv->regs;
+	struct spi_nor *flash = dev_get_uclass_priv(slave->dev);
+	u32 old_tran_csr;
+
+	if (!(op->data.nbytes > 0 && op->data.dir == SPI_MEM_DATA_IN) ||
+	    !(op->addr.nbytes > 0 && op->addr.nbytes <= 4))
+		return -ENOTSUPP;
+
+	old_tran_csr = readl(&regs->tran_csr);
+	writel(CV1800B_SPI_CE_HARDWARE, &regs->ce_ctrl);
+
+	cv1800b_spi_config_dmmr(priv, flash);
+
+	writel(1, &regs->dmmr_ctrl);
+	memcpy(op->data.buf.in, (void *)priv->regs + op->addr.val, op->data.nbytes);
+	writel(0, &regs->dmmr_ctrl);
+
+	writel(CV1800B_SPI_CE_ENABLE, &regs->ce_ctrl);
+	writel(old_tran_csr, &regs->tran_csr);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops cv1800b_spi_mem_ops = {
+	.exec_op = cv1800b_spi_exec_op,
+};
+
+static const struct dm_spi_ops cv1800b_spi_ops = {
+	.xfer      = cv1800b_spi_xfer,
+	.mem_ops   = &cv1800b_spi_mem_ops,
+	.set_speed = cv1800b_spi_set_speed,
+	.set_mode  = cv1800b_spi_set_mode,
+};
+
+static const struct udevice_id cv1800b_spi_ids[] = {
+	{ .compatible = "sophgo,cv1800b-spif" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_spi) = {
+	.name      = "cv1800b_spif",
+	.id        = UCLASS_SPI,
+	.of_match  = cv1800b_spi_ids,
+	.ops       = &cv1800b_spi_ops,
+	.priv_auto = sizeof(struct cv1800b_spi_priv),
+	.probe     = cv1800b_spi_probe,
+};
-- 
2.41.0

