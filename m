Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F4C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 12:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44DC87595;
	Thu, 30 Nov 2023 13:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E31F8713D; Thu, 30 Nov 2023 13:07:52 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB65286B9A
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 13:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AUC7dwr039651;
 Thu, 30 Nov 2023 20:07:39 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 30 Nov 2023
 20:07:35 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>, CL Wang <cl634@andestech.com>
Subject: [PATCH V2 1/2] drivers: watchdog: add andes atcwdt200 support
Date: Thu, 30 Nov 2023 20:07:28 +0800
Message-ID: <20231130120729.1362747-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AUC7dwr039651
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

This patch adds an implementation of the Andes watchdog ATCWDT200 driver.

Signed-off-by: CL Wang <cl634@andestech.com>
Signed-off-by: Randolph <randolph@andestech.com>
---
 drivers/watchdog/Kconfig         |   6 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/atcwdt200_wdt.c | 220 +++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/watchdog/atcwdt200_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 07fc4940e9..6b0f77dd3f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -130,6 +130,12 @@ config WDT_AT91
 	  Select this to enable Microchip watchdog timer, which can be found on
 	  some AT91 devices.
 
+config WDT_ATCWDT200
+	bool "Andes watchdog timer support"
+	depends on WDT
+	help
+	  Select this to enable Andes ATCWDT200 watchdog timer
+
 config WDT_BCM6345
 	bool "BCM6345 watchdog timer support"
 	depends on WDT && (ARCH_BMIPS || BCM6856 || \
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index eef786f5e7..1750ebbb1f 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_WDT_ARM_SMC) += arm_smc_wdt.o
 obj-$(CONFIG_WDT_ARMADA_37XX) += armada-37xx-wdt.o
 obj-$(CONFIG_WDT_ASPEED) += ast_wdt.o
 obj-$(CONFIG_WDT_AST2600) += ast2600_wdt.o
+obj-$(CONFIG_WDT_ATCWDT200) += atcwdt200_wdt.o
 obj-$(CONFIG_WDT_BCM2835) += bcm2835_wdt.o
 obj-$(CONFIG_WDT_BCM6345) += bcm6345_wdt.o
 obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
new file mode 100644
index 0000000000..2a456d7a46
--- /dev/null
+++ b/drivers/watchdog/atcwdt200_wdt.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C)  2023 Andes Technology Corporation.
+ *
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <hang.h>
+#include <linux/bitops.h>
+#include <wdt.h>
+
+#define NODE_NOT_FOUND     0xFFFFFFFF
+
+#define WDT_WP_MAGIC       0x5aa5
+#define WDT_RESTART_MAGIC  0xcafe
+
+/* Control Register */
+#define REG_WDT_ID         0x00
+#define REG_WDT_CFG        0x10
+#define REG_WDT_RS         0x14
+#define REG_WDT_WE         0x18
+#define REG_WDT_STA        0x1C
+
+#define RST_TIME_OFF       8
+#define RST_TIME_MSK       (0x7 << RST_TIME_OFF)
+#define RST_CLK_128        (0 << RST_TIME_OFF)
+#define RST_CLK_256        (1 << RST_TIME_OFF)
+#define RST_CLK_512        (2 << RST_TIME_OFF)
+#define RST_CLK_1024       (3 << RST_TIME_OFF)
+#define INT_TIME_OFF       4
+#define INT_TIME_MSK       (0xf << INT_TIME_OFF)
+#define INT_CLK_2_6        (0 << INT_TIME_OFF)  /* clk period*2^6  */
+#define INT_CLK_2_8        (1 << INT_TIME_OFF)  /* clk period*2^8  */
+#define INT_CLK_2_10       (2 << INT_TIME_OFF)  /* clk period*2^10 */
+#define INT_CLK_2_11       (3 << INT_TIME_OFF)  /* clk period*2^11 */
+#define INT_CLK_2_12       (4 << INT_TIME_OFF)  /* clk period*2^12 */
+#define INT_CLK_2_13       (5 << INT_TIME_OFF)  /* clk period*2^13 */
+#define INT_CLK_2_14       (6 << INT_TIME_OFF)  /* clk period*2^14 */
+#define INT_CLK_2_15       (7 << INT_TIME_OFF)  /* clk period*2^15 */
+#define INT_CLK_2_17       (8 << INT_TIME_OFF)  /* clk period*2^17 */
+#define INT_CLK_2_19       (9 << INT_TIME_OFF)  /* clk period*2^19 */
+#define INT_CLK_2_21       (10 << INT_TIME_OFF) /* clk period*2^21 */
+#define INT_CLK_2_23       (11 << INT_TIME_OFF) /* clk period*2^23 */
+#define INT_CLK_2_25       (12 << INT_TIME_OFF) /* clk period*2^25 */
+#define INT_CLK_2_27       (13 << INT_TIME_OFF) /* clk period*2^27 */
+#define INT_CLK_2_29       (14 << INT_TIME_OFF) /* clk period*2^29 */
+#define INT_CLK_2_31       (15 << INT_TIME_OFF) /* clk period*2^31 */
+#define INT_CLK_MIN        0x0
+#define INT_CLK_MAX_16B    0x7
+#define INT_CLK_MAX_32B    0xF
+#define RST_EN             BIT(3)
+#define INT_EN             BIT(2)
+#define CLK_PCLK           BIT(1)
+#define WDT_EN             BIT(0)
+#define INT_EXPIRED        BIT(0)
+
+#define INT_TIME_ARRAY     16
+#define RST_TIME_ARRAY     8
+
+struct wdt_priv {
+	void __iomem *base;
+	u32 wdt_clk_src;
+	u32 clk_freq;
+	u8  max_clk;
+};
+
+static inline u8 atcwdt_get_2_power_of_n(u8 index, u8 type)
+{
+	const u8 div_int[INT_TIME_ARRAY] = {6, 8, 10, 11, 12, 13, 14, 15,
+					    17, 19, 21, 23, 25, 27, 29, 31};
+	const u8 div_rst[RST_TIME_ARRAY] = {7, 8, 9, 10, 11, 12, 13, 14};
+	u8 *pdiv;
+
+	if (type == RST_TIME_ARRAY)
+		pdiv = div_rst;
+	else
+		pdiv = div_int;
+
+	if (index >= type)
+		index = type - 1;
+
+	return pdiv[index];
+}
+
+static u8 atwdt_search_msb(u64 freq_ms, u8 type)
+{
+	u64 result;
+	u64 freq_sec;
+	u8 index;
+
+	freq_sec = freq_ms / 1000;
+	for (index = 0; index < type; index++) {
+		result = freq_sec >> atcwdt_get_2_power_of_n(index, type);
+
+		if (result <= 1)
+			break;
+	}
+
+	return index;
+}
+
+static int atcwdt_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct wdt_priv *priv = dev_get_priv(dev);
+	u64 rst_max_count;
+	u32 rst_max_time_ms;
+	u64 rst_time_ms;
+	u64 int_time_ms;
+	u8  rst_time;
+	u8  int_time;
+
+	rst_max_count = 1 << atcwdt_get_2_power_of_n(RST_TIME_ARRAY, RST_TIME_ARRAY);
+	rst_max_time_ms = (rst_max_count * 1000) / priv->clk_freq;
+
+	if (timeout > rst_max_time_ms) {
+		int_time_ms = timeout - rst_max_time_ms;
+		rst_time_ms = rst_max_time_ms;
+	} else {
+		int_time_ms = 0;
+		rst_time_ms = timeout;
+	}
+
+	rst_time = atwdt_search_msb(rst_time_ms * priv->clk_freq, RST_TIME_ARRAY);
+
+	if (int_time_ms) {
+		int_time = atwdt_search_msb(int_time_ms * priv->clk_freq, INT_TIME_ARRAY);
+		if (int_time > priv->max_clk)
+			int_time = priv->max_clk;
+	} else {
+		int_time = 0;
+	}
+
+	writel(WDT_WP_MAGIC, priv->base + REG_WDT_WE);
+	writel(((rst_time << RST_TIME_OFF) & RST_TIME_MSK) | ((int_time << INT_TIME_OFF) &
+		INT_TIME_MSK) | INT_EN | RST_EN | priv->wdt_clk_src | WDT_EN,
+		priv->base + REG_WDT_CFG);
+
+	return 0;
+}
+
+static int atcwdt_wdt_stop(struct udevice *dev)
+{
+	struct wdt_priv *priv = dev_get_priv(dev);
+
+	writel(WDT_WP_MAGIC, priv->base + REG_WDT_WE);
+	writel(0, priv->base + REG_WDT_CFG);
+
+	return 0;
+}
+
+static int atcwdt_wdt_restart(struct udevice *dev)
+{
+	struct wdt_priv *priv = dev_get_priv(dev);
+
+	writel(WDT_WP_MAGIC, priv->base + REG_WDT_WE);
+	writel(WDT_RESTART_MAGIC, priv->base + REG_WDT_RS);
+	setbits_le32(priv->base + REG_WDT_STA, INT_EXPIRED);
+
+	return 0;
+}
+
+static int atcwdt_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	atcwdt_wdt_start(dev, 0, 0);
+	hang();
+
+	return 0;
+}
+
+static int atcwdt_wdt_probe(struct udevice *dev)
+{
+	struct wdt_priv *priv = dev_get_priv(dev);
+	int timer_16bit;
+
+	priv->base = dev_remap_addr_index(dev, 0);
+	if (!priv->base)
+		return -EFAULT;
+
+	priv->wdt_clk_src = dev_read_u32_default(dev, "clock-source", NODE_NOT_FOUND);
+	if (priv->wdt_clk_src == NODE_NOT_FOUND || priv->wdt_clk_src > 1)
+		priv->wdt_clk_src = CLK_PCLK;
+
+	timer_16bit = dev_read_u32_default(dev, "16bit_timer", NODE_NOT_FOUND);
+	if (timer_16bit == 1 || timer_16bit == NODE_NOT_FOUND)
+		priv->max_clk = INT_CLK_MAX_16B;
+	else
+		priv->max_clk = INT_CLK_MAX_32B;
+
+	priv->clk_freq = dev_read_u32_default(dev, "clock-frequency", NODE_NOT_FOUND);
+	if (priv->clk_freq == NODE_NOT_FOUND) {
+		printf("atcwdt200: Please provide a valid \"clock-frequency\" in DTB\n");
+		return -EINVAL;
+	}
+
+	atcwdt_wdt_stop(dev);
+
+	return 0;
+}
+
+static const struct wdt_ops atcwdt_wdt_ops = {
+	.start = atcwdt_wdt_start,
+	.reset = atcwdt_wdt_restart,
+	.stop = atcwdt_wdt_stop,
+	.expire_now = atcwdt_wdt_expire_now,
+};
+
+static const struct udevice_id atcwdt_wdt_ids[] = {
+	{.compatible = "andestech,atcwdt200"},
+	{}
+};
+
+U_BOOT_DRIVER(atcwdt) = {
+	.name = "atc_wdt",
+	.id = UCLASS_WDT,
+	.probe = atcwdt_wdt_probe,
+	.of_match = atcwdt_wdt_ids,
+	.ops = &atcwdt_wdt_ops,
+	.priv_auto = sizeof(struct wdt_priv),
+};
-- 
2.34.1

