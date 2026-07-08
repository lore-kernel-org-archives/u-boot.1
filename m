Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FA4C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB8C84A04;
	Wed,  8 Jul 2026 14:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQn5wwgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7FA84A0B; Wed,  8 Jul 2026 14:55:11 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351C8849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 14:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hehongbo918@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso768592a91.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783515308; x=1784120108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9lP+cA+hWTUduqis0XvzVrOcCus/YL/tFMPoa4cbvA=;
 b=bQn5wwgm0SziWKWYq6Yb0DWTrW1uWVZol+OdZw4DZiQ+N9Y50o1C51a3DUEqZJUJN1
 dOJg67aIY8SXvRnkmVo/AiS8DhaQobpXY6Arpin0cxoxY0dm3RPQhFZosrPpZIRUNjJK
 bg0V1GTxAuQRuEMzC8rLxIwcA6BGHpOA0lu8Oj9ZsnRkm82q9RYjphDDaztYM14qZPIY
 bjHXLlOkcsDxCQrwmb34/BBzdTnqa+f0jK4POkp7LPr4kNgPNh2qSCzjERNM2DW8eSui
 Y6KyuaSrgV3kOFri3jqTP8l0hXZ9flCEieKul84kqeO5a3X1GNtDk542u4HvasO2NkgX
 rqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783515308; x=1784120108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9lP+cA+hWTUduqis0XvzVrOcCus/YL/tFMPoa4cbvA=;
 b=oDdx1zsTxC4fu4InvsLpl2wJSpBkSWyDr1d2vng5R+k8qbvHEj6CyBh/eXbWMQ+2qN
 9KUdaYrvQIUXec0G0KASBQGthWy4xMARxm3Ff9aie6XPmC+GYFOpXDSbBYYjwX/R0E5m
 /YsMfW9l9PhgQ3t5miWfJKzSqNnFZrwg540Y9lsFpQrfUgp9AgRQhHXa3z8QNBVj+7Fh
 Jbf+kZrXe9LSFGTbEktkF6Q2L2BAVM6/rMlUJDPTJrgyPricsnMbUA46qejRsIUgq0jt
 44qNtkFVVMBLc+vtddHUDjDWt08dT5bpnTz52tZ6WKTVlZTmpFphRvtIAmB4p8eTvmb8
 yNTw==
X-Gm-Message-State: AOJu0YzYh1oTWIatGEIoldofGZg0Z+y7Foj5ZHx3NGJ+Qxiu+bn3ocsS
 9Kgr+iWIRyXETCEFlxORY6ITNnbENpa6n4N5WtjbJHzrZ0QonA5N2Vn4Eyd303mi0krFzK0F
X-Gm-Gg: AfdE7cl3q8H/AkzFXgBHl8rlPP0ViRpMQ1QNIKcrfWjmtEWPmdMSmAZgSrxxxYghbkz
 NTNgbMqrhzUjVoqCwvs9HycWgHFeLioPd0Xi1O2peJmzD0SFe2eXPs8NkFhZx/izC4DmUfmRFks
 /N2TuAEAiyzUJAGcnr+/yuoU7tWihBXFlQv9vhWHLrea19LNmkg7wyrb04iuWvmsR8ys8w/bXVE
 s33fAYVprNl7FoVzkdal4P0XW4xPf220yNtEoZ+oKz+/m4e97QMOpymh+oiwLcXbvPUX/gU0T4v
 spDsJNyRNLPIDWfgq5D78fK6GODanqT6OyYSTlAWlGlKNWHsue6Yw0qqx1mGimV30YuGFXg2QhH
 EQbs7l9HFCvfuK3IBQDRUySRYq4eznu7w5n2VFdzrcTDw0v7oJwU8YyugJmNAMGObHtv36LkWGh
 CrQKSf+S6nflpCkAop8Q==
X-Received: by 2002:a17:90b:4b86:b0:381:854:dba4 with SMTP id
 98e67ed59e1d1-38941cc597cmr2277048a91.20.1783515307424; 
 Wed, 08 Jul 2026 05:55:07 -0700 (PDT)
Received: from localhost ([39.182.8.83]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-389051cbd33sm1117996a91.10.2026.07.08.05.55.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jul 2026 05:55:06 -0700 (PDT)
From: hehongbo918@gmail.com
To: u-boot@lists.denx.de
Cc: Honbo He <hehongbo918@gmail.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Luca Weiss <luca.weiss@fairphone.com>, Daniel Palmer <daniel@0x0f.com>,
 Yao Zi <me@ziyao.cc>, Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v3] serial: esp32: add driver for esp32 series chips
Date: Wed,  8 Jul 2026 20:54:06 +0800
Message-ID: <20260708125425.70745-1-hehongbo918@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Honbo He <hehongbo918@gmail.com>

Add a driver model serial driver for Espressif ESP32 UART
controllers. The driver supports ESP32, ESP32-S3 and ESP32-S31 UART
register variants, including baud-rate setup, FIFO access and basic
port initialization.

Signed-off-by: Honbo He <hehongbo918@gmail.com>

Changes in v3:
- Add debug UART for early print output

---
 drivers/serial/Kconfig        |  15 ++
 drivers/serial/Makefile       |   1 +
 drivers/serial/serial_esp32.c | 367 ++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/serial/serial_esp32.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index e221800d5d0..ffc58d663ff 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -276,6 +276,14 @@ config DEBUG_UART_ATMEL
 	  will need to provide parameters to make this work. The driver will
 	  be available until the real driver-model serial is running.
 
+config DEBUG_UART_ESP32
+	bool "Espressif ESP32 UART"
+	depends on ESP32_SERIAL
+	help
+	  Select this to enable a debug UART using the ESP32 UART driver. You
+	  will need to provide parameters to make this work. The driver will
+	  be available until the real driver-model serial is running.
+
 config DEBUG_UART_BCM6345
 	bool "BCM6345 UART"
 	depends on BCM6345_SERIAL
@@ -1069,6 +1077,13 @@ config HTIF_CONSOLE
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
index 00000000000..a3c03b6fc1b
--- /dev/null
+++ b/drivers/serial/serial_esp32.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Honbo He <hehongbo918@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_SERIAL
+
+#include <clk.h>
+#include <debug_uart.h>
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
+static u32 esp32_uart_read(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static void esp32_uart_write(void __iomem *base, u32 offset, u32 val)
+{
+	writel(val, base + offset);
+}
+
+static u32 esp32_uart_field(u32 val, u32 mask, u32 shift)
+{
+	return (val >> shift) & mask;
+}
+
+static u32 esp32_uart_rx_fifo_count(void __iomem *base,
+				    const struct esp32_uart_soc_data *data)
+{
+	u32 status = esp32_uart_read(base, UART_STATUS);
+
+	return esp32_uart_field(status, data->fifo_cnt_mask,
+				UART_RXFIFO_CNT_SHIFT);
+}
+
+static u32 esp32_uart_tx_fifo_count(void __iomem *base,
+				    const struct esp32_uart_soc_data *data)
+{
+	u32 status = esp32_uart_read(base, UART_STATUS);
+
+	return esp32_uart_field(status, data->fifo_cnt_mask,
+				UART_TXFIFO_CNT_SHIFT);
+}
+
+static int esp32_uart_update(void __iomem *base,
+			     const struct esp32_uart_soc_data *data)
+{
+	int timeout = UART_UPDATE_TIMEOUT;
+
+	if (!data->reg_update_bit)
+		return 0;
+
+	setbits_le32(base + data->reg_update, data->reg_update_bit);
+	while ((esp32_uart_read(base, data->reg_update) & data->reg_update_bit) &&
+	       timeout--)
+		;
+
+	return timeout < 0 ? -ETIMEDOUT : 0;
+}
+
+static int esp32_uart_reset_fifo(void __iomem *base,
+				 const struct esp32_uart_soc_data *data)
+{
+	u32 mask = data->tx_fifo_rst;
+	int ret;
+
+	/*
+	 * uart2 of ESP32 doesn't have any register to reset Tx_FIFO or Rx_FIFO,
+	 * and the FIFO_RST of uart1 may impact the functioning of uart2
+	 * so use soft reset instead
+	 */
+	if (data->broken_fifo_rst) {
+		while (esp32_uart_rx_fifo_count(base, data))
+			esp32_uart_read(base, UART_FIFO);
+		return 0;
+	}
+	mask |= data->rx_fifo_rst;
+
+	setbits_le32(base + UART_CONF0, mask);
+	ret = esp32_uart_update(base, data);
+	if (ret)
+		return ret;
+
+	clrbits_le32(base + UART_CONF0, mask);
+	return esp32_uart_update(base, data);
+}
+
+/*
+ * div = clkdiv_int + clkdiv_frag / 16
+ * baudrate = uart_clk / div
+ */
+static int esp32_uart_setbrg(void __iomem *base,
+			     const struct esp32_uart_soc_data *data,
+			     u32 clock_rate, int baudrate)
+{
+	u32 div, int_div, frag;
+
+	if (!clock_rate || baudrate <= 0)
+		return -EINVAL;
+	if (clock_rate > (UINT_MAX >> 4))
+		return -EINVAL;
+
+	/* shifting left by 4 bits to preserve frag field */
+	div = (clock_rate << 4) / baudrate;
+	int_div = div >> 4;
+	frag = div & UART_CLKDIV_FRAG_MASK;
+
+	if (!int_div || int_div > data->clkdiv_mask)
+		return -EINVAL;
+
+	esp32_uart_write(base, UART_CLKDIV,
+			 int_div | (frag << UART_CLKDIV_FRAG_SHIFT));
+
+	return esp32_uart_update(base, data);
+}
+
+static int esp32_uart_init(void __iomem *base,
+			   const struct esp32_uart_soc_data *data)
+{
+	u32 conf0;
+
+	esp32_uart_write(base, UART_INT_ENA, 0);
+	esp32_uart_write(base, UART_INT_CLR, 0xffffffff);
+
+	conf0 = esp32_uart_read(base, UART_CONF0);
+	conf0 &= ~(UART_PARITY | UART_PARITY_EN |
+		   UART_BIT_NUM_MASK | UART_STOP_BIT_MASK |
+		   UART_LOOPBACK | UART_TX_FLOW_EN);
+	conf0 |= UART_BIT_NUM_8 | UART_STOP_BIT_1;
+	esp32_uart_write(base, UART_CONF0, conf0);
+
+	return esp32_uart_reset_fifo(base, data);
+}
+
+static int esp32_serial_setbrg(struct udevice *dev, int baudrate)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	return esp32_uart_setbrg(plat->base, plat->data, plat->clock_rate,
+				 baudrate);
+}
+
+static int esp32_serial_getc(struct udevice *dev)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (!esp32_uart_rx_fifo_count(plat->base, plat->data))
+		return -EAGAIN;
+
+	return esp32_uart_read(plat->base, UART_FIFO) & 0xff;
+}
+
+static int esp32_serial_putc(struct udevice *dev, const char ch)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (esp32_uart_tx_fifo_count(plat->base, plat->data) >= UART_FIFO_LEN)
+		return -EAGAIN;
+
+	esp32_uart_write(plat->base, UART_FIFO, ch);
+
+	return 0;
+}
+
+static int esp32_serial_pending(struct udevice *dev, bool input)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+
+	if (input)
+		return esp32_uart_rx_fifo_count(plat->base, plat->data);
+
+	return esp32_uart_tx_fifo_count(plat->base, plat->data) ? 1 : 0;
+}
+
+static int esp32_serial_probe(struct udevice *dev)
+{
+	struct esp32_uart_plat *plat = dev_get_plat(dev);
+	const struct esp32_uart_soc_data *data;
+
+	data = (const struct esp32_uart_soc_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+	plat->data = data;
+
+	return esp32_uart_init(plat->base, data);
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
+
+#ifdef CONFIG_DEBUG_UART_ESP32
+static inline const struct esp32_uart_soc_data *
+esp32_debug_uart_data(void)
+{
+#if defined(CONFIG_ESPRESSIF_ESP32S31)
+	return &esp32s31_uart_data;
+#elif defined(CONFIG_ESPRESSIF_ESP32S3)
+	return &esp32s3_uart_data;
+#else
+	return &esp32_uart_data;
+#endif
+}
+
+static inline void _debug_uart_init(void)
+{
+	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
+	const struct esp32_uart_soc_data *data = esp32_debug_uart_data();
+
+	esp32_uart_setbrg(base, data,
+			CONFIG_DEBUG_UART_CLOCK,
+			CONFIG_BAUDRATE);
+	esp32_uart_init(base, data);
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	void __iomem *base = (void __iomem *)CONFIG_VAL(DEBUG_UART_BASE);
+	const struct esp32_uart_soc_data *data =
+			esp32_debug_uart_data();
+
+	while (esp32_uart_tx_fifo_count(base, data)
+				>= UART_FIFO_LEN)
+		;
+	esp32_uart_write(base, UART_FIFO, ch);
+}
+
+DEBUG_UART_FUNCS
+#endif
-- 
2.34.1

