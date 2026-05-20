Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E354FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0D484859;
	Wed, 20 May 2026 00:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="qlPwWdCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC9284862; Wed, 20 May 2026 00:50:04 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7ABD8056B
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso2471304a91.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230998; x=1779835798;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=utRsetnkywN+y5gL4pk4qW9TYxjQSaT3p9kSqlyEX9Q=;
 b=qlPwWdCPo3P43XZfIb9X4LSaXKId5GF2CHcA9bw/qBMqgIYCqUhDiqdnJQ527WMhT4
 YM7kXUz9KH7v8DSDI12YpDVdaHmKpTUqLkJRMQNqIhevohrdCwTi122Il6CAb3+Zu+2K
 1lLelJZjhhqM/ZZSiY6EdAI6ZGZmZyVYsUHwc8oLrWaF7gSbD433lhGA2kMIsOmEwqQt
 avGTkPCoxREXXIA6I2y9WS1oguvOOaCb+Upo+2CtW4iSxQYVBsYAS2dhNnQo/t9EGzr6
 rRhS2HbP+UuOPTTTK9OrV4paSw2vVylZqJDxaHPQDzIztuj1asUO5qJqSQg6E9okcqM8
 C4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230998; x=1779835798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=utRsetnkywN+y5gL4pk4qW9TYxjQSaT3p9kSqlyEX9Q=;
 b=lCZ+kHKU+WVTB4Bi/y1mA2JYm5fVu4mtfeU1KAklCIPIm0dRhE7vl2vd6JeSqGCIZC
 YVoGfFbmj3ecKZQ34moa+rJgtizuU5vBe2bNwm1y3fQhRDgI1/82xVmj4lX0XyDuR1LP
 wIMpArfG/PkpaYlN6DPD11Xrq3Soc66QDydtddD2hy9UlLQ/AGvwqO485NvgxOi10AFo
 cfQurMFtujvHU/mBDbodtMJMmwEJO8ctOi2QTsPjQqGcS+5qbIVV/UjBVeo00lpklvgN
 /NBmCjWbXMM+frTxbxnuCMrTZxnZ4X9bHPpXlQTL91omSj2R1UDkJm36DhFyyJvKmuIL
 NfCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xp5OgXjQrftURt9Q5lCtPUShALHxZ7x43nd/zkAD/q6PPmtbsiKDZU0BbwrIyP4dIH5huMVM=@lists.denx.de
X-Gm-Message-State: AOJu0YwO4w15oMNii15aZD07hKqk15WOhi3loU48ooyURpMI3R4nrKEL
 laJx20UQ2f7y/4tm6BbY+lFSZEwHA+kKD5sWZ1hmjtSqHAjbV1DwbGkx8klJLQDBz+w=
X-Gm-Gg: Acq92OH2Gq8ZjooTHERIe6VOnnr+TE7TD2uKJEBa+tSj3Pn6JKrMHnQC4mwYRRrRjLd
 7Bdc3boZhqdFfB34fy5l966gCVL7AvuepzG42u555zzsqj613wKCODcMTQkoJktCwfIRX4O4qpI
 nvnXxyJbX4SMoeQBRx5trvtddLPdvFgcpKHF2eargyYppL1qYVLgvtrfdHHQIIldcg/DwVa18NE
 4koNbp7TtfWM2IwkfwSv0+tXDquoY0w8XVpm6abVPPkoUfT+0nI3+P/xN1jL6AyXYo2N8AopxN5
 Mg1AgacV4t4RcfkkkMx5U72GtwWcxKSEt1Ox29UP3HWYYvreJPMLaDOtQHzqOsLctIsXn91wBUy
 07ztN8ZPZ6SVNoWO+0YaC8eChAsnnjWBOp6uNpuPGaGaTJm7a5I+HW11elBXVoxAc3C9KzmEJ8x
 ZAaQZg02+yL5KpVYERjSpKy7P0J42+ONAPv7PKFEXLz+8=
X-Received: by 2002:a17:90b:2f0c:b0:369:c5f4:9681 with SMTP id
 98e67ed59e1d1-369c5f4a117mr9055456a91.22.1779230998340; 
 Tue, 19 May 2026 15:49:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:49:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:52 -0400
Subject: [PATCH v2 8/9] gpio: add gpio driver for Spacemit K1 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-8-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable gpio driver for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- Add .request and .rfree ops: delegate to pinctrl's
  gpio_request_enable / gpio_disable_free.
- xlate(): use gpio_flags_xlate() instead of raw flags.
---
 drivers/gpio/Kconfig         |   8 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/spacemit_gpio.c | 253 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0b5466b39b8..fe6379f0e01 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -449,6 +449,14 @@ config SANDBOX_GPIO_COUNT
 	  of 'anonymous' GPIOs that do not belong to any device or bank.
 	  Select a suitable value depending on your needs.
 
+config SPACEMIT_GPIO
+	bool "Spacemit K1 GPIO driver"
+	depends on DM_GPIO && TARGET_SPACEMIT_K1
+	help
+	  Support the GPIO device in Spacemit SoCs. The GPIOs are arranged
+	  into a number of banks (different for each SoC type) each with 32
+	  GPIOs.
+
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
 	depends on ARCH_SUNXI
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 863557e45ce..020e23c7252 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
 obj-$(CONFIG_$(PHASE_)PCF8575_GPIO)	+= pcf8575_gpio.o
 obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o qcom_spmi_gpio.o
+obj-$(CONFIG_$(PHASE_)SPACEMIT_GPIO)	+= spacemit_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
 obj-$(CONFIG_MSCC_SGPIO)	+= mscc_sgpio.o
diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
new file mode 100644
index 00000000000..de71880df15
--- /dev/null
+++ b/drivers/gpio/spacemit_gpio.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025-2026 RISCstar Ltd.
+ */
+
+#include <asm/gpio.h>
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <dm/read.h>
+#include <dm/uclass.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <log.h>
+
+#define GPIO_BANK_SIZE		32
+#define GPIO_TO_BANK(pin)	((pin) / GPIO_BANK_SIZE)
+#define GPIO_TO_BIT(pin)	((pin) % GPIO_BANK_SIZE)
+
+static inline int gpio_to_reg_offset(unsigned int pin)
+{
+	unsigned int bank = GPIO_TO_BANK(pin);
+
+	if (bank == 0)
+		return 0;
+	else if (bank == 1)
+		return 4;
+	else if (bank == 2)
+		return 8;
+	else if (bank == 3)
+		return 0x100;
+	log_warning("Use default GPIO bank for an invalid GPIO[%d].\n", pin);
+	return 0;
+}
+
+#define REG_PLR(pin)		(0x00 + gpio_to_reg_offset(pin))
+#define REG_PDR(pin)		(0x0c + gpio_to_reg_offset(pin))
+#define REG_PSR(pin)		(0x18 + gpio_to_reg_offset(pin))
+#define REG_PCR(pin)		(0x24 + gpio_to_reg_offset(pin))
+#define REG_SDR(pin)		(0x54 + gpio_to_reg_offset(pin))
+#define REG_CDR(pin)		(0x60 + gpio_to_reg_offset(pin))
+
+struct spacemit_gpio_data {
+	u16	gpio_base;
+	u16	gpio_count;
+	u8	num_banks;
+};
+
+struct spacemit_gpio_priv {
+	void __iomem *regs;
+};
+
+static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
+			       struct ofnode_phandle_args *args)
+{
+	struct spacemit_gpio_data *data;
+	u32 bank, offset, flags;
+
+	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
+	if (args->args_count < 3) {
+		dev_err(dev, "Invalid args count: %d, expected 3\n",
+			args->args_count);
+		return -EINVAL;
+	}
+	bank = args->args[0];
+	offset = args->args[1];
+	flags = args->args[2];
+
+	if (bank >= data->num_banks) {
+		dev_err(dev, "Invalid gpio bank: %u (max %u)\n",
+			bank, data->num_banks - 1);
+		return -EINVAL;
+	}
+	if (offset >= GPIO_BANK_SIZE) {
+		dev_err(dev, "Invalid offset: %u (max 31)\n", offset);
+		return -EINVAL;
+	}
+	desc->offset = bank * GPIO_BANK_SIZE + offset;
+	desc->flags = gpio_flags_xlate(flags);
+	return 0;
+}
+
+static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	u32 value, mask;
+
+	addr = priv->regs + REG_PLR(offset);
+	value = readl(addr);
+	mask = 1 << GPIO_TO_BIT(offset);
+	return !!(value & mask);
+}
+
+static int spacemit_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	u32 value, mask;
+
+	addr = priv->regs + REG_PDR(offset);
+	value = readl(addr);
+	mask = 1 << GPIO_TO_BIT(offset);
+	if (value & mask)
+		return GPIOF_OUTPUT;
+	return GPIOF_INPUT;
+}
+
+static int spacemit_gpio_get_flags(struct udevice *dev, unsigned int offset,
+				   ulong *flagsp)
+{
+	ulong flags = 0;
+	u32 dir;
+
+	dir = spacemit_gpio_get_function(dev, offset);
+	if (dir) {
+		flags |= GPIOD_IS_OUT;
+		if (spacemit_gpio_get_value(dev, offset))
+			flags |= GPIOD_IS_OUT_ACTIVE;
+	} else {
+		flags |= GPIOD_IS_IN;
+	}
+	*flagsp = flags;
+	return 0;
+}
+
+static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
+				   ulong flags)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	int value;
+
+	value = (flags & GPIOD_IS_OUT_ACTIVE) ? 1 : 0;
+	if (flags & GPIOD_IS_IN) {
+		addr = priv->regs + REG_CDR(offset);
+		writel(1 << GPIO_TO_BIT(offset), addr);
+	}
+	if (flags & GPIOD_IS_OUT) {
+		if (value) {
+			addr = priv->regs + REG_PSR(offset);
+			writel(1 << GPIO_TO_BIT(offset), addr);
+		} else {
+			addr = priv->regs + REG_PCR(offset);
+			writel(1 << GPIO_TO_BIT(offset), addr);
+		}
+		addr = priv->regs + REG_SDR(offset);
+		writel(1 << GPIO_TO_BIT(offset), addr);
+	}
+	return 0;
+}
+
+static int spacemit_gpio_request(struct udevice *dev, unsigned int offset,
+				 const char *label)
+{
+	const struct pinctrl_ops *ops;
+	struct udevice *pctldev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_PINCTRL, &pctldev);
+	if (ret)
+		return ret;
+
+	ops = pinctrl_get_ops(pctldev);
+	if (!ops->gpio_request_enable)
+		return -ENOSYS;
+
+	return ops->gpio_request_enable(pctldev, offset);
+}
+
+static int spacemit_gpio_rfree(struct udevice *dev, unsigned int offset)
+{
+	const struct pinctrl_ops *ops;
+	struct udevice *pctldev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_PINCTRL, &pctldev);
+	if (ret)
+		return ret;
+
+	ops = pinctrl_get_ops(pctldev);
+	if (!ops->gpio_disable_free)
+		return -ENOSYS;
+
+	return ops->gpio_disable_free(pctldev, offset);
+}
+
+static const struct dm_gpio_ops spacemit_gpio_ops = {
+	.request	= spacemit_gpio_request,
+	.rfree		= spacemit_gpio_rfree,
+	.xlate		= spacemit_gpio_xlate,
+	.get_value	= spacemit_gpio_get_value,
+	.get_function	= spacemit_gpio_get_function,
+	.get_flags	= spacemit_gpio_get_flags,
+	.set_flags	= spacemit_gpio_set_flags,
+};
+
+static int spacemit_gpio_probe(struct udevice *dev)
+{
+	struct spacemit_gpio_priv *priv;
+	struct spacemit_gpio_data *data;
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct clk_bulk clks;
+	int ret;
+
+	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs) {
+		dev_err(dev, "Fail to get base address\n");
+		return -EINVAL;
+	}
+	uc_priv->bank_name = "GPIO";
+	uc_priv->gpio_count = data->gpio_count;
+	uc_priv->gpio_base = data->gpio_base;
+
+	ret = clk_get_bulk(dev, &clks);
+	if (ret) {
+		dev_err(dev, "Fail to get bulk clks\n");
+		return ret;
+	}
+	ret = clk_enable_bulk(&clks);
+	if (ret) {
+		dev_err(dev, "Fail to enable bulk clks\n");
+		goto out;
+	}
+	return 0;
+out:
+	clk_release_bulk(&clks);
+	return ret;
+}
+
+static const struct spacemit_gpio_data k1_gpio_data = {
+	.num_banks	= 4,
+	.gpio_count	= 128,
+	.gpio_base	= 0,
+};
+
+static const struct udevice_id spacemit_gpio_ids[] = {
+	{ .compatible = "spacemit,k1-gpio", .data = (uintptr_t)&k1_gpio_data, },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(k1_gpio) = {
+	.name		= "spacemit_k1_gpio",
+	.id		= UCLASS_GPIO,
+	.of_match	= spacemit_gpio_ids,
+	.ops		= &spacemit_gpio_ops,
+	.priv_auto	= sizeof(struct spacemit_gpio_priv),
+	.probe		= spacemit_gpio_probe,
+};

-- 
2.43.0

