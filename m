Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BAC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B83888D06;
	Wed, 25 Sep 2024 14:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LbBXl8Ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1B988BB2; Wed, 25 Sep 2024 14:25:48 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513CD88C60
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 40575A441D9;
 Wed, 25 Sep 2024 12:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0231EC4CEC7;
 Wed, 25 Sep 2024 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727267126;
 bh=vO46czpdfm61R/La7MOBckscYX4MPCXdzWZOlBdw7a0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=LbBXl8NgbgFFS0I68IpHoMa/uMB8mkUJ3zOhJ5Lu/8KZ/dbtOJWxeLqjB2HjvOUim
 lMaNde21uRsh04Q0z1bXwLLRM9/2qrkbwpypK9pVx2SLcRj5djMzxac0s+AEf2SdCs
 pGMXWbAvrQ2lbdYzXOFLWAk+kHYADnXpY2q7goWwV46llH8PkT9mV8VMzhyOt9XBxe
 dV2yZ0ZKuB4QocFZ+vbGsnI8MQCN7conAJVCcZBX4tBJ66gAQuAdJQn4dIRpbfM+O2
 mpm424uT1jq1elkwe7cOqym42ixq6LLyKrmKoMvsz2pNGgvKb8dC1PECdoHYwU9dfN
 foJitdv3fJftQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E665DC369D7;
 Wed, 25 Sep 2024 12:25:25 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Wed, 25 Sep 2024 13:25:11 +0100
Subject: [PATCH v2 01/11] pinctrl: Add support for ADI SC5XX-family pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-sc5xx-driver-series-v2-1-ad9287c25c08@analog.com>
References: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
In-Reply-To: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727267113; l=7920;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=4YNQ4PaVdrya+HmUBsJl7cS1ad9ZhmYIZnFWXc8qk5o=;
 b=3cxdBj997M64d2A45jeiIn6WmBTXuMtYmvOtvW0DftiBPhJOG/LuvmWDJchWAeGtuSNm7L6eC
 fCP+ji1+ef7Bv1/JQO+Y8d9iz1PwIeeQP9xypPcTQAx+CKYQtjnvRgj
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

This adds support for pin configuration on the Analog Devices SC5XX SoC
family. This commit is largely a port of the Linux driver, which has not
yet been submitted upstream.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 MAINTAINERS                            |   1 +
 drivers/pinctrl/Kconfig                |   8 ++
 drivers/pinctrl/Makefile               |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c     | 156 +++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/adi-adsp.h |  21 +++++
 5 files changed, 187 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f4eee367d..9810ccc3e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -612,6 +612,7 @@ F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
+F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	include/configs/sc5*
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a1d53cfbdb..a88a444218 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -170,6 +170,14 @@ config PINCTRL_APPLE
 	  both the GPIO definitions and pin control functions for each
 	  available multiplex function.
 
+config PINCTRL_ADI
+	bool "ADI pinctrl driver"
+	depends on DM && ARCH_SC5XX
+	help
+	  This driver enables pinctrl support on SC5xx processors. This
+	  driver covers only the pin configuration functionality, and
+	  GPIO functionality is contained in the separate GPIO driver.
+
 config PINCTRL_AR933X
 	bool "QCA/Athores ar933x pin control driver"
 	depends on DM && SOC_AR933X
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6d7b7cd905..7dd56774bd 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,6 +3,7 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(SPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
diff --git a/drivers/pinctrl/pinctrl-adi-adsp.c b/drivers/pinctrl/pinctrl-adi-adsp.c
new file mode 100644
index 0000000000..717ac8e005
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-adi-adsp.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ *
+ * dm pinctrl implementation for ADI ADSP SoCs
+ *
+ */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+#define ADSP_PORT_MMIO_SIZE		0x80
+#define ADSP_PORT_PIN_SIZE		16
+
+#define ADSP_PORT_PORT_MUX_BITS		2
+#define ADSP_PORT_PORT_MUX_MASK		0x03
+#define ADSP_PINCTRL_FUNCTION_COUNT 4
+
+#define ADSP_PORT_REG_FER			0x00
+#define ADSP_PORT_REG_FER_SET		0x04
+#define ADSP_PORT_REG_FER_CLEAR		0x08
+#define ADSP_PORT_REG_DATA			0x0c
+#define ADSP_PORT_REG_DATA_SET		0x10
+#define ADSP_PORT_REG_DATA_CLEAR	0x14
+#define ADSP_PORT_REG_DIR			0x18
+#define ADSP_PORT_REG_DIR_SET		0x1c
+#define ADSP_PORT_REG_DIR_CLEAR		0x20
+#define ADSP_PORT_REG_INEN			0x24
+#define ADSP_PORT_REG_INEN_SET		0x28
+#define ADSP_PORT_REG_INEN_CLEAR	0x2c
+#define ADSP_PORT_REG_PORT_MUX		0x30
+#define ADSP_PORT_REG_DATA_TGL		0x34
+#define ADSP_PORT_REG_POLAR			0x38
+#define ADSP_PORT_REG_POLAR_SET		0x3c
+#define ADSP_PORT_REG_POLAR_CLEAR	0x40
+#define ADSP_PORT_REG_LOCK			0x44
+#define ADSP_PORT_REG_TRIG_TGL		0x48
+
+struct adsp_pinctrl_priv {
+	void __iomem *base;
+	int npins;
+	char pinbuf[16];
+};
+
+static u32 get_port(unsigned int pin)
+{
+	return pin / ADSP_PORT_PIN_SIZE;
+}
+
+static u32 get_offset(unsigned int pin)
+{
+	return pin % ADSP_PORT_PIN_SIZE;
+}
+
+static int adsp_pinctrl_pinmux_set(struct udevice *udev, unsigned int pin, unsigned int func)
+{
+	struct adsp_pinctrl_priv *priv = dev_get_priv(udev);
+	void __iomem *portbase;
+	u32 port, offset;
+	u32 val;
+
+	if (pin >= priv->npins)
+		return -ENODEV;
+
+	if (func >= ADSP_PINCTRL_FUNCTION_COUNT)
+		return -EINVAL;
+
+	port = get_port(pin);
+	offset = get_offset(pin);
+	portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+	val = ioread32(portbase + ADSP_PORT_REG_PORT_MUX);
+	val &= ~(ADSP_PORT_PORT_MUX_MASK << (ADSP_PORT_PORT_MUX_BITS * offset));
+	val |= func << (ADSP_PORT_PORT_MUX_BITS * offset);
+	iowrite32(val, portbase + ADSP_PORT_REG_PORT_MUX);
+
+	iowrite32(BIT(offset), portbase + ADSP_PORT_REG_FER_SET);
+	return 0;
+}
+
+static int adsp_pinctrl_set_state(struct udevice *udev, struct udevice *config)
+{
+	const struct fdt_property *pinlist;
+	int length = 0;
+	int ret, i;
+	u32 pin, function;
+
+	pinlist = dev_read_prop(config, "adi,pins", &length);
+	if (!pinlist) {
+		dev_err(udev, "missing adi,pins property in pinctrl config node\n");
+		return -EINVAL;
+	}
+
+	if (length % (sizeof(uint32_t) * 2)) {
+		dev_err(udev, "adi,pins property must be a multiple of two uint32_ts\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < length / sizeof(uint32_t); i += 2) {
+		ret = dev_read_u32_index(config, "adi,pins", i, &pin);
+		if (ret)
+			return ret;
+
+		ret = dev_read_u32_index(config, "adi,pins", i + 1, &function);
+		if (ret)
+			return ret;
+
+		ret = adsp_pinctrl_pinmux_set(udev, pin, function);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+const struct pinctrl_ops adsp_pinctrl_ops = {
+	.set_state = adsp_pinctrl_set_state,
+};
+
+static int adsp_pinctrl_probe(struct udevice *udev)
+{
+	struct adsp_pinctrl_priv *priv = dev_get_priv(udev);
+
+	priv->base = dev_read_addr_ptr(udev);
+	priv->npins = dev_read_u32_default(udev, "adi,npins", 0);
+
+	if (!priv->npins) {
+		dev_err(udev, "Missing adi,npins property!\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id adsp_pinctrl_match[] = {
+	{ .compatible = "adi,adsp-pinctrl" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_adsp_pinctrl) = {
+	.name = "adi_adsp_pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = adsp_pinctrl_match,
+	.probe = adsp_pinctrl_probe,
+	.priv_auto = sizeof(struct adsp_pinctrl_priv),
+	.ops = &adsp_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/dt-bindings/pinctrl/adi-adsp.h b/include/dt-bindings/pinctrl/adi-adsp.h
new file mode 100644
index 0000000000..7dc8a1ef5c
--- /dev/null
+++ b/include/dt-bindings/pinctrl/adi-adsp.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ */
+
+#ifndef DT_BINDINGS_PINCTRL_ADI_ADSP
+#define DT_BINDINGS_PINCTRL_ADI_ADSP
+
+#define ADI_ADSP_PIN(port, pin) (16 * ((port) - 'A') + (pin))
+#define ADI_ADSP_PINFUNC_ALT0 0
+#define ADI_ADSP_PINFUNC_ALT1 1
+#define ADI_ADSP_PINFUNC_ALT2 2
+#define ADI_ADSP_PINFUNC_ALT3 3
+
+#endif

-- 
2.34.1


