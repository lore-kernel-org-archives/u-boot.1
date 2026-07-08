Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C9EC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9674084AB8;
	Wed,  8 Jul 2026 14:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qV3UQ3ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C978497A; Wed,  8 Jul 2026 07:39:23 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEB9838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 07:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hehongbo918@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37ff8e0ad0fso356184a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 22:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783489159; x=1784093959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rl+PHzHsVgd2MoxJEEhrNNhbXu7vG3Zrkd74rgtXbmo=;
 b=qV3UQ3ho0PMUcbT47E9MifhMzvx3Re/94vOXiijBdFhwxw8fslmsA9pYf+87NmDUFJ
 prUbk9PEDzx6urs3QPhRp1o4aYFnAy5AMn6ZuoTeXEfDGYaXszdvD3q7PhUlhG4I0ZZk
 Ypk5IG79Az6XSL0XBH4p+i4mmE80ndodcTqwcy+uHR9qdjG+dxgQk/RFaZwzcMkLpXno
 lJxqfrEeJqhY9K7DBulRCRHz7Eya1fk/TQJ9bYiKtbRB6L2bKCYGicKEh9W+Tocqs6AP
 p4OHY+vGQiP6RkV+GF1/x0fx1jyWfVUzatS05YuRz5Fo75JKp2GWmYk5oqPlO8PiuX8A
 ihvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783489159; x=1784093959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rl+PHzHsVgd2MoxJEEhrNNhbXu7vG3Zrkd74rgtXbmo=;
 b=ILVOAQhT1VyMnlGY2nTmJOZcWuZzGWtJvYnDPOC1dL9ErH44xgcYjf1dCPn/D3SId9
 7flOG4glI/YK4r53AhDXqqWG4PkBpyfhLK+jDMN3Agoqp07J6pFVHNV6FkehaH2Zaxsa
 6rSmk31vuGoGt504P7w7IKFOXXYlLH7AbXTrjfhELYfApQNYPieKUsXRT8S3cYZJbEej
 ez9wDJFScnfMU2ONpUrEiM/bPZHnPyeUtgXzRg2c17SZb2UJHr+m/psDip9jAdE0OKTt
 w/EW+RmLitTOfrlUx8/UJKBHsB3hFsBbuV6X6t9LWrkZzQIRshFzi7NqDg0LGWlhtsMn
 VTYQ==
X-Gm-Message-State: AOJu0YzRlrmPyTOY2oGJguQGIw7Yik22WtgeFFXQGP7/mcaKfxM7zOPr
 TNMDlFPevl1jM199/sUPOWAUtaGZGwafw1qHYvGJkvf+ROtQcCYb1uuC3ZcaHg2WgsDCPIt0
X-Gm-Gg: AfdE7cmoCHC75BZs5VYTtAavgYufVXEZ+2Z1Yh9S1juIxiPKF1/RThb20ysZAOulpyq
 8ETeD5KFehFZVLT6FBYuHrBh5TEUefi/Urdp5tnt2i4ILi4zDs/fjCoZay8yqnJS+FwSn13JHPz
 znVY6KOb9ApJn20+tB8wGMxyU1Ei9UAOJ4RT6j1yrbOmH5p9Tky2uzwv67KnSST4VxgAZC3mpy+
 MWmV69amV6p6+AI5Gc/b8jx6FMbVBt331B0TnOh9k/wmWbcDgYvav8C+h9076MJC4YTjuNC++me
 xorBfDEOVCvvKkyerEZ3AumA5QIFXswRTQhA1yckybGzzxLfjh6indTAjrs4bnv/y39m0qmrSjI
 WztI5VsGbdcVlN8/1V88MbWUsq/UFdMIFI9cJQeylyUNgX3fhzxJfen02hriLgeDQJ4OwkcGTQa
 WWGpDXNdKv1yuTRizK6iaX55nPxOBqPU6U0Q==
X-Received: by 2002:a17:90b:2f06:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-38941101dfemr1027958a91.7.1783489159055; 
 Tue, 07 Jul 2026 22:39:19 -0700 (PDT)
Received: from localhost ([115.238.104.202]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d12fcd8esm2127717a91.3.2026.07.07.22.39.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 22:39:18 -0700 (PDT)
From: hehongbo918@gmail.com
To: u-boot@lists.denx.de
Cc: Honbo He <hehongbo918@gmail.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Johan Jonker <jbx6244@gmail.com>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2] serial: esp32: add driver for esp32 series chips
Date: Wed,  8 Jul 2026 13:39:08 +0800
Message-ID: <20260708053911.55985-1-hehongbo918@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Honbo He <hehongbo918@gmail.com>

Add a driver model serial driver for Espressif ESP32 UART
controllers. The driver supports ESP32, ESP32-S3 and ESP32-S31 UART
register variants, including baud-rate setup, FIFO access and basic
port initialization.

Signed-off-by: Honbo He <hehongbo918@gmail.com>
---
 drivers/serial/Kconfig        |   7 +
 drivers/serial/Makefile       |   1 +
 drivers/serial/serial_esp32.c | 312 ++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/serial/serial_esp32.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index e221800d5d0..f0e8a0b8026 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1069,6 +1069,13 @@ config HTIF_CONSOLE
 	  console. The HTIF device is quite common in RISC-V emulators and
 	  RISC-V ISS so this driver allows using U-Boot on such platforms.
 
+config ESP32_SERIAL
+	bool "Espressif ESP32 UART support"
+	depends on DM_SERIAL
+	help
+	  Select this to enable UART support for Espressif ESP32 family
+	  devices using the U-Boot driver model.
+
 config SIFIVE_SERIAL
 	bool "SiFive UART support"
 	depends on DM_SERIAL
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 66088b44eb6..44fb2170f9a 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_COREBOOT_SERIAL) += serial_coreboot.o
 obj-$(CONFIG_CORTINA_UART) += serial_cortina.o
 obj-$(CONFIG_DEBUG_SBI_CONSOLE) += serial_sbi.o
 obj-$(CONFIG_EFI_APP) += serial_efi.o
+obj-$(CONFIG_ESP32_SERIAL) += serial_esp32.o
 obj-$(CONFIG_MCFUART) += serial_mcf.o
 obj-$(CONFIG_SYS_NS16550) += ns16550.o
 obj-$(CONFIG_S5P_SERIAL) += serial_s5p.o
diff --git a/drivers/serial/serial_esp32.c b/drivers/serial/serial_esp32.c
new file mode 100644
index 00000000000..16b687fb5c1
--- /dev/null
+++ b/drivers/serial/serial_esp32.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Honbo He <hehongbo918@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_SERIAL
+
+#include <clk.h>
+#include <dm.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <serial.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+
+#define UART_FIFO			0x00
+#define UART_INT_ENA		0x0c
+#define UART_INT_CLR		0x10
+#define UART_CLKDIV			0x14
+#define UART_STATUS			0x1c
+#define UART_CONF0			0x20
+
+#define UART_CLKDIV_FRAG_SHIFT	20
+#define UART_CLKDIV_FRAG_MASK	0xf
+
+#define UART_TX_FLOW_EN		BIT(13)
+#define UART_LOOPBACK		BIT(12)
+#define UART_STOP_BIT_1		BIT(4)
+#define UART_PARITY_EN		BIT(1)
+#define UART_PARITY			BIT(0)
+
+#define UART_BIT_NUM_8		(3 << 2)
+
+#define UART_BIT_NUM_MASK	GENMASK(3, 2)
+#define UART_STOP_BIT_MASK	GENMASK(5, 4)
+
+#define UART_RXFIFO_CNT_SHIFT	0
+#define UART_TXFIFO_CNT_SHIFT	16
+#define UART_FIFO_LEN		128
+
+#define UART_UPDATE_TIMEOUT 10000
+
+struct esp32_uart_soc_data {
+	u32 reg_update;		/* UART_ID_REG */
+	u32 reg_update_bit; /* UART_REG_UPDATE */
+	u32 clkdiv_mask;
+	u32 fifo_cnt_mask;
+	u32 rx_fifo_rst;	/* UART_RXFIFO_RST */
+	u32 tx_fifo_rst;	/* UART_TXFIFO_RST */
+
+	bool broken_fifo_rst; /* true for ESP32, false otherwise */
+};
+
+/* Information about a serial port */
+struct esp32_uart_plat {
+	void __iomem *base; /* address of registers in physical memory */
+	const struct esp32_uart_soc_data *data;
+	u32 clock_rate;
+};
+
+static const struct esp32_uart_soc_data esp32_uart_data = {
+	.clkdiv_mask = 0xfffff,
+	.fifo_cnt_mask = 0xff,
+	.rx_fifo_rst = BIT(17),
+	.tx_fifo_rst = BIT(18),
+
+	.broken_fifo_rst = true,
+};
+
+static const struct esp32_uart_soc_data esp32s3_uart_data = {
+	.reg_update = 0x80,
+	.reg_update_bit = BIT(31),
+	.clkdiv_mask = 0xfff,
+	.fifo_cnt_mask = 0x3ff,
+	.rx_fifo_rst = BIT(17),
+	.tx_fifo_rst = BIT(18),
+};
+
+static const struct esp32_uart_soc_data esp32s31_uart_data = {
+	.reg_update = 0x98,
+	.reg_update_bit = BIT(0),
+	.clkdiv_mask = 0xfff,
+	.fifo_cnt_mask = 0xff,
+	.rx_fifo_rst = BIT(22),
+	.tx_fifo_rst = BIT(23),
+};
+
+static u32 esp32_uart_read(struct esp32_uart_plat *plat, u32 offset)
+{
+	return readl(plat->base + offset);
+}
+
+static void esp32_uart_write(struct esp32_uart_plat *plat, u32 offset, u32 val)
+{
+	writel(val, plat->base + offset);
+}
+
+static u32 esp32_uart_field(u32 val, u32 mask, u32 shift)
+{
+	return (val >> shift) & mask;
+}
+
+static u32 esp32_uart_rx_fifo_count(struct esp32_uart_plat *plat)
+{
+	const struct esp32_uart_soc_data *data = plat->data;
+	u32 status = esp32_uart_read(plat, UART_STATUS);
+
+	return esp32_uart_field(status, data->fifo_cnt_mask,
+				UART_RXFIFO_CNT_SHIFT);
+}
+
+static u32 esp32_uart_tx_fifo_count(struct esp32_uart_plat *plat)
+{
+	const struct esp32_uart_soc_data *data = plat->data;
+	u32 status = esp32_uart_read(plat, UART_STATUS);
+
+	return esp32_uart_field(status, data->fifo_cnt_mask,
+				UART_TXFIFO_CNT_SHIFT);
+}
+
+static int esp32_uart_update(struct esp32_uart_plat *plat)
+{
+	const struct esp32_uart_soc_data *data = plat->data;
+	int timeout = UART_UPDATE_TIMEOUT;
+
+	if (!data->reg_update_bit)
+		return 0;
+
+	setbits_le32(plat->base + data->reg_update, data->reg_update_bit);
+	while ((esp32_uart_read(plat, data->reg_update) & data->reg_update_bit) &&
+	       timeout--)
+		;
+
+	return timeout < 0 ? -ETIMEDOUT : 0;
+}
+
+static int esp32_uart_reset_fifo(struct esp32_uart_plat *plat)
+{
+	const struct esp32_uart_soc_data *data = plat->data;
+	u32 mask = data->tx_fifo_rst;
+	int ret;
+
+	/*
+	 * uart2 of ESP32 doesn't have any register to reset Tx_FIFO or Rx_FIFO,
+	 * and the FIFO_RST of uart1 may impact the functioning of uart2
+	 * so use soft reset instead
+	 */
+	if (data->broken_fifo_rst) {
+		while (esp32_uart_rx_fifo_count(plat))
+			esp32_uart_read(plat, UART_FIFO);
+		return 0;
+	}
+	mask |= data->rx_fifo_rst;
+
+	setbits_le32(plat->base + UART_CONF0, mask);
+	ret = esp32_uart_update(plat);
+	if (ret)
+		return ret;
+
+	clrbits_le32(plat->base + UART_CONF0, mask);
+	return esp32_uart_update(plat);
+}
+
+/*
+ * div = clkdiv_int + clkdiv_frag / 16
+ * baudrate = uart_clk / div
+ */
+static int esp32_serial_setbrg(struct udevice *dev, int baudrate)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+	const struct esp32_uart_soc_data *data = plat->data;
+	u32 div, int_div, frag;
+
+	if (!plat->clock_rate || baudrate <= 0)
+		return -EINVAL;
+	if (plat->clock_rate > (UINT_MAX >> 4))
+		return -EINVAL;
+
+	/* shifting left by 4 bits to preserve frag field */
+	div = (plat->clock_rate << 4) / baudrate;
+	int_div = div >> 4;
+	frag = div & UART_CLKDIV_FRAG_MASK;
+
+	if (!int_div || int_div > data->clkdiv_mask)
+		return -EINVAL;
+
+	esp32_uart_write(plat, UART_CLKDIV,
+			 int_div | (frag << UART_CLKDIV_FRAG_SHIFT));
+
+	return esp32_uart_update(plat);
+}
+
+static int esp32_serial_getc(struct udevice *dev)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (!esp32_uart_rx_fifo_count(plat))
+		return -EAGAIN;
+
+	return esp32_uart_read(plat, UART_FIFO) & 0xff;
+}
+
+static int esp32_serial_putc(struct udevice *dev, const char ch)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (esp32_uart_tx_fifo_count(plat) >= UART_FIFO_LEN)
+		return -EAGAIN;
+
+	esp32_uart_write(plat, UART_FIFO, ch);
+
+	return 0;
+}
+
+static int esp32_serial_pending(struct udevice *dev, bool input)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (input)
+		return esp32_uart_rx_fifo_count(plat);
+
+	return esp32_uart_tx_fifo_count(plat) ? 1 : 0;
+}
+
+static int esp32_serial_probe(struct udevice *dev)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+	const struct esp32_uart_soc_data *data;
+	u32 conf0;
+
+	data = (const struct esp32_uart_soc_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+	plat->data = data;
+
+	esp32_uart_write(plat, UART_INT_ENA, 0);
+	esp32_uart_write(plat, UART_INT_CLR, 0xffffffff);
+
+	conf0 = esp32_uart_read(plat, UART_CONF0);
+	conf0 &= ~(UART_PARITY | UART_PARITY_EN |
+		   UART_BIT_NUM_MASK | UART_STOP_BIT_MASK |
+		   UART_LOOPBACK | UART_TX_FLOW_EN);
+	conf0 |= UART_BIT_NUM_8 | UART_STOP_BIT_1;
+	esp32_uart_write(plat, UART_CONF0, conf0);
+
+	return esp32_uart_reset_fifo(plat);
+}
+
+static int esp32_serial_of_to_plat(struct udevice *dev)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+	struct clk clk;
+	int ret;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->base = (void __iomem *)(uintptr_t)addr;
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (!ret) {
+		ret = clk_get_rate(&clk);
+		if (!IS_ERR_VALUE(ret))
+			plat->clock_rate = ret;
+	} else if (ret != -ENOENT && ret != -ENODEV && ret != -ENOSYS) {
+		dev_err(dev, "failed to get clock: %d\n", ret);
+		return ret;
+	}
+
+	if (!plat->clock_rate)
+		plat->clock_rate = dev_read_u32_default(dev, "clock-frequency", 0);
+
+	if (!plat->clock_rate) {
+		dev_err(dev, "missing clock\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct dm_serial_ops esp32_serial_ops = {
+	.putc = esp32_serial_putc,
+	.pending = esp32_serial_pending,
+	.getc = esp32_serial_getc,
+	.setbrg = esp32_serial_setbrg,
+};
+
+static const struct udevice_id esp32_serial_ids[] = {
+	{ .compatible = "esp,esp32-uart",
+	  .data = (ulong)&esp32_uart_data },
+	{ .compatible = "esp,esp32s3-uart",
+	  .data = (ulong)&esp32s3_uart_data },
+	{ .compatible = "esp,esp32s31-uart",
+	  .data = (ulong)&esp32s31_uart_data },
+	{ }
+};
+
+U_BOOT_DRIVER(serial_esp32) = {
+	.name = "serial_esp32",
+	.id = UCLASS_SERIAL,
+	.of_match = of_match_ptr(esp32_serial_ids),
+	.of_to_plat = of_match_ptr(esp32_serial_of_to_plat),
+	.plat_auto = sizeof(struct esp32_uart_plat),
+	.probe = esp32_serial_probe,
+	.ops = &esp32_serial_ops,
+#if !CONFIG_IS_ENABLED(OF_CONTROL)
+	.flags = DM_FLAG_PRE_RELOC,
+#endif
+};
-- 
2.34.1

