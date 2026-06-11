Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0111ACD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E03A848E2;
	Thu, 11 Jun 2026 16:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N9T8tv0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3D1841C2; Thu, 11 Jun 2026 16:18:51 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5167A83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5177b1a7441so110434451cf.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187528; x=1781792328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9QThpu0cylOVZzko69gNeJ5jORRhrv5YiBkxN8OCEA=;
 b=N9T8tv0CmbXBhv/n5rmwCabelSsPJ6Lk68S+j475zRUoTq6DhcNVOJtI6NNEs2etQR
 E+j3E9xPHkTIOLHK4nBkDdPVWRQl/QiH4Q3JL7Iy7F+F6TVAbw4HXU43nkY9EhUGIJfd
 o+dFZWkjadLHYJdXwGIqpKHD0spCrWYXZ08d2sl91DDE0ped9z2k8sANTdu17FZgTUaX
 RXL7zPFrMC1jyjxBfVGS3uDyBhLB7uChlHJlAjT5bgfNA7NDkgtS16Y6JG/ENtwTd/t5
 sCNQ+OYiX0dgqyys9A0WQW/4Frij0ZhBzGGLBzbdYdsQMlrxxFWlDmkrtBfkj3HSOBI0
 Mbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187528; x=1781792328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9QThpu0cylOVZzko69gNeJ5jORRhrv5YiBkxN8OCEA=;
 b=dH+Wdd3j6npUQwBYcT/KmsMtCqN4GGYvmaEOBD/ut6mqShZ+kvIlUPU6+JCQhbHRBu
 mODq1zD7hBuS2mD76NM3/CFQatJmhuGGNbkL6EvcuI2Z0oRkxGBnxxj9ZSGROfh+z9V0
 Q9AJjqDheWcco2sNFp0lYdxmsJO1BsindXg9g/wGPqImNYT3lHBAzY9a/J2srEaNa7Rc
 tcfLMK4wE9VWv37F2s0IjtsoEr8qVN+DcfdHx+ixT09P1B802VqMGLUyx33KP1ZsSxGM
 m5ZzGMa1CyxT8MgiYjj1drm3CfxqQYNCChmib4r1+bN7eHu8vJ8C/UVNQzgpL50OTfXA
 Il/g==
X-Gm-Message-State: AOJu0Yxu3v2FwFJEIIS6ApFwwBJLiGVglkKGRabhk/8H7HVCkFr93qiD
 EGExg4XtY6xeQuOvTExrnSHGZ1+D5CgPCPQyZGbVeB4aPIWAnTjQkyQApw91MreW
X-Gm-Gg: Acq92OEQqDQ/NGgMOACU/oUuhWTiNsDvsC+uMWlFGb0CWwQkmgiYP3Cyi+EZzvPbBaj
 tE+SQQ72HBpLjGD+aLAAm+7QElR6zsRhbDvqCBWNZtDuaooLnPBIq3E2enFGZzeG0hnF+u/spj6
 oV5NqYZxs+8rBRc7ukpwOB+xVXWwKNlP0bqFRDkn5Hx7H3CAmyE6unTSTGw5KPDHroOyjNA0Cna
 v8xWlaT+UhIzSisvnRWebX4kolqOTZkekcJaJmZw4rM6tT7jpmaP0Ub/13FoM6F5XOrNefwEuvG
 54Jorl+1c2pvRDkM+Gg4o9v5SDi73DcjZjPm253fUTk71sKk1tUE3HE6w8rKI2VfD33i8RTZiS3
 Ks/Xgx4JaX6ZgQWkITkGJT5c7V+z/lXZ674JUn2SguNl+vsWdeqnaqYWYKA5UBoKfDayOL4OZ1I
 1oQ2BVgUTM5ygMNXCuBgdL72jNFTRvSRaEZASq8LEsU4UKRmOiu74p3ZHjc8HMRaF3MZKXCFQW9
 BPkEkLkuX3gE0CrWzE=
X-Received: by 2002:a05:622a:5598:b0:517:6350:ed4b with SMTP id
 d75a77b69052e-517ee233d2fmr52629531cf.36.1781187527709; 
 Thu, 11 Jun 2026 07:18:47 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:47 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 8/9] gpio: add gpio driver for Spacemit K1 SoC
Date: Thu, 11 Jun 2026 10:18:10 -0400
Message-Id: <20260611141811.68904-9-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable gpio driver for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- Add .request and .rfree ops: delegate to pinctrl's
  gpio_request_enable / gpio_disable_free.
- xlate(): use gpio_flags_xlate() instead of raw flags.
Changes in v3:
- None.

 drivers/gpio/Kconfig         |   8 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/spacemit_gpio.c | 253 +++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/gpio/spacemit_gpio.c

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
2.25.1

