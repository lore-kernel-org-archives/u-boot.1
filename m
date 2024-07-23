Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20153888A1;
	Tue, 23 Jul 2024 20:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BuvTVjW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BA388747; Tue, 23 Jul 2024 20:14:53 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03BB88845
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7044c085338so3306267a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758483; x=1722363283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JwyOCcRX4UXF8qd2zTrPr78vJRSQmf5Ie5aRukRNk4=;
 b=BuvTVjW1NJdeM4ih9EZTg6gvNbvDKUBIEc4RajWpuHcw2hA64/zk5U0/gL3AEtw8bQ
 fIjOVBM2AYyxUbAn/EivIUrY1ojKWLJJgh1xTFK80rvHZvlI6rwL+/QlODxZKnlM9nie
 iFYIRY7/pcDSUy8k9g85hg0W/XrvxfSko4zCJU45ANwN+YApx3xUOYBC9lCtqXUflGUm
 hY8GJ80IOM0wbUzuerFN2fs6H5W2C828uZAk8kwmUXQEdBbT1u7lMmn8ON0qxSbCnY6i
 F1tovP7VngBg+tBXiH8GydnHc4U5jn1pQFoR242OeJP+081Dz+sY0uLvJtOYyvAW8R5B
 sdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758483; x=1722363283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JwyOCcRX4UXF8qd2zTrPr78vJRSQmf5Ie5aRukRNk4=;
 b=bqoj2OcNyq0mB2ym+TCdRcyHcJQig/hx5Il/Y543iDY/BljiTX34ZV2MRSJ1kkKnkt
 ckVm7GwJFCLXhc0MYX720u1BSmthSrGSCAMm7nokAevQbEaDn4T5W3YS+SHmuiMgroty
 Wl6yNZswk3gqjm/WnMvPxiWVZSqb+yUpN7Z0zQ4xdjh99DnXSidfdNgMJpd/+TZ9nWcV
 sY+LKvHIPjDVohiw+KDDVu3IyN2aT0fl2Wd18EvGdH2018X6UFSSxEmMUsosi1dpptfM
 lOdK6mmZVwNHZi4nCgbzsP1gY1lerYXK/hTn3mm/7pxhTkZrzCaNfVWhedMp3IaPnMDI
 OX6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUme3D51sYpYDWeFeEwb1MdH3e4/ju3Me6WU0LFnlBVibRFlK8czrtbFszQwEcctVVQ1jkNrkQcH7vcaAMqGRO/PWx0ew==
X-Gm-Message-State: AOJu0YzB8yxc9uc+ynKyf6Z6K9qkP2O/9aQN1ML217N2nxNq2bf9bctS
 AuM6MqfV++QKhdZKPECEofO2kwnJhd6hX3lC23JSCGjk8AGgCcosbVdB0d6yo1s=
X-Google-Smtp-Source: AGHT+IGoyTJvtKWL57efMKB2X7zhJlMwTeY0aOq2TqWAhKGcQ96c9Im3IopcaHNldPKpUlPcR0AVvA==
X-Received: by 2002:a05:6830:6212:b0:704:4d82:1fed with SMTP id
 46e09a7af769-709234c91efmr698164a34.31.1721758483378; 
 Tue, 23 Jul 2024 11:14:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60c3ba0sm2109641a34.27.2024.07.23.11.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 4/5] rng: Add Exynos TRNG driver
Date: Tue, 23 Jul 2024 13:14:38 -0500
Message-Id: <20240723181439.7089-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
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

Add True Random Number Generator (TRNG) driver for Exynos chips. This
implementation is heavily based on Linux kernel's counterpart [1]. It
also follows upstream dt-bindings [2].

TRNG block is usually a part of SSS (Security Sub System) IP-core on
Exynos chips. Because SSS access on Exynos850 is protected by TZPC
(TrustZone Protection Control), it's not possible to read/write TRNG
registers from U-Boot, as it's running in EL1 mode. Instead, the
corresponding SMC calls should be used to make the secure software
running in EL3 mode access it for us. Those SMC calls are handled by
LDFW (Loadable Firmware), which has to be loaded first. For example, for
E850-96 board it's done in its board_init(), so by the time RNG
capabilities are needed the LDFW should be already loaded and TRNG
should be functional.

[1] drivers/char/hw_random/exynos-trng.c
[2] dts/upstream/Bindings/rng/samsung,exynos5250-trng.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Mentioned LDFW firmware in help section for RNG_EXYNOS config option
  - Renamed struct exynos_trng -> struct exynos_trng_priv
  - Added kernel-doc comments for struct exynos_trng_priv
  - Added kernel-doc comments for struct exynos_trng_variant
  - Fixed error codes in exynos_trng_of_to_plat()
  - Renamed 'err' variable to 'ret' in exynos_trng_probe()

 drivers/rng/Kconfig       |  13 ++
 drivers/rng/Makefile      |   1 +
 drivers/rng/exynos-trng.c | 291 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/rng/exynos-trng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 5758ae192a66..b35d8c66b9c6 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -120,4 +120,17 @@ config RNG_TURRIS_RWTM
 	  on other Armada-3700 devices (like EspressoBin) if Secure
 	  Firmware from CZ.NIC is used.
 
+config RNG_EXYNOS
+	bool "Samsung Exynos True Random Number Generator support"
+	depends on DM_RNG
+	help
+	  Enable support for True Random Number Generator (TRNG) available on
+	  Exynos SoCs.
+
+	  On some chips (like Exynos850) TRNG registers are protected with TZPC
+	  (TrustZone Protection Control). For such chips the driver provides an
+	  implementation based on SMC calls to EL3 monitor program. In that
+	  case the LDFW (Loadable Firmware) has to be loaded first, as it
+	  actually implements TRNG SMC calls.
+
 endif
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index c1f1c616e009..30553c9d6e99 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_RNG_ARM_RNDR) += arm_rndr.o
 obj-$(CONFIG_TPM_RNG) += tpm_rng.o
 obj-$(CONFIG_RNG_JH7110) += jh7110_rng.o
 obj-$(CONFIG_RNG_TURRIS_RWTM) += turris_rwtm_rng.o
+obj-$(CONFIG_RNG_EXYNOS) += exynos-trng.o
diff --git a/drivers/rng/exynos-trng.c b/drivers/rng/exynos-trng.c
new file mode 100644
index 000000000000..d2479d244ed5
--- /dev/null
+++ b/drivers/rng/exynos-trng.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Samsung Exynos TRNG driver (True Random Number Generator).
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <rng.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <asm/io.h>
+#include <linux/arm-smccc.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/time.h>
+
+#define EXYNOS_TRNG_CLKDIV		0x0
+#define EXYNOS_TRNG_CLKDIV_MASK		GENMASK(15, 0)
+#define EXYNOS_TRNG_CLOCK_RATE		500000
+
+#define EXYNOS_TRNG_CTRL		0x20
+#define EXYNOS_TRNG_CTRL_RNGEN		BIT(31)
+
+#define EXYNOS_TRNG_POST_CTRL		0x30
+#define EXYNOS_TRNG_ONLINE_CTRL		0x40
+#define EXYNOS_TRNG_ONLINE_STAT		0x44
+#define EXYNOS_TRNG_ONLINE_MAXCHI2	0x48
+#define EXYNOS_TRNG_FIFO_CTRL		0x50
+#define EXYNOS_TRNG_FIFO_0		0x80
+#define EXYNOS_TRNG_FIFO_1		0x84
+#define EXYNOS_TRNG_FIFO_2		0x88
+#define EXYNOS_TRNG_FIFO_3		0x8c
+#define EXYNOS_TRNG_FIFO_4		0x90
+#define EXYNOS_TRNG_FIFO_5		0x94
+#define EXYNOS_TRNG_FIFO_6		0x98
+#define EXYNOS_TRNG_FIFO_7		0x9c
+#define EXYNOS_TRNG_FIFO_LEN		8
+#define EXYNOS_TRNG_FIFO_TIMEOUT	(1 * USEC_PER_SEC)
+
+#define EXYNOS_SMC_CALL_VAL(func_num)			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   func_num)
+
+/* SMC command for DTRNG access */
+#define SMC_CMD_RANDOM			EXYNOS_SMC_CALL_VAL(0x1012)
+
+/* SMC_CMD_RANDOM: arguments */
+#define HWRNG_INIT			0x0
+#define HWRNG_EXIT			0x1
+#define HWRNG_GET_DATA			0x2
+
+/* SMC_CMD_RANDOM: return values */
+#define HWRNG_RET_OK			0x0
+#define HWRNG_RET_RETRY_ERROR		0x2
+
+#define HWRNG_MAX_TRIES			100
+
+/**
+ * struct exynos_trng_variant - Chip specific data
+ *
+ * @smc: Set "true" if TRNG block has to be accessed via SMC calls
+ * @init: (Optional) TRNG initialization function to call on probe
+ * @exit: (Optional) TRNG deinitialization function to call on remove
+ * @read: Function to read the random data from TRNG block
+ */
+struct exynos_trng_variant {
+	bool smc;
+	int (*init)(struct udevice *dev);
+	void (*exit)(struct udevice *dev);
+	int (*read)(struct udevice *dev, void *data, size_t len);
+};
+
+/**
+ * struct exynos_trng_priv - Driver's private data
+ *
+ * @base: Base address of MMIO registers of TRNG block
+ * @clk: Operating clock (needed for TRNG block functioning)
+ * @pclk: Bus clock (needed for interfacing the TRNG block registers)
+ * @data: Chip specific data
+ */
+struct exynos_trng_priv {
+	void __iomem *base;
+	struct clk *clk;
+	struct clk *pclk;
+	const struct exynos_trng_variant *data;
+};
+
+static int exynos_trng_read_reg(struct udevice *dev, void *data, size_t len)
+{
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+	int val;
+
+	len = min_t(size_t, len, EXYNOS_TRNG_FIFO_LEN * 4);
+	writel_relaxed(len * 8, trng->base + EXYNOS_TRNG_FIFO_CTRL);
+	val = readl_poll_timeout(trng->base + EXYNOS_TRNG_FIFO_CTRL, val,
+				 val == 0, EXYNOS_TRNG_FIFO_TIMEOUT);
+	if (val < 0)
+		return val;
+
+	memcpy_fromio(data, trng->base + EXYNOS_TRNG_FIFO_0, len);
+
+	return 0;
+}
+
+static int exynos_trng_read_smc(struct udevice *dev, void *data, size_t len)
+{
+	struct arm_smccc_res res;
+	unsigned int copied = 0;
+	u32 *buf = data;
+	int tries = 0;
+
+	while (copied < len) {
+		arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_GET_DATA, 0, 0, 0, 0, 0, 0,
+			      &res);
+		switch (res.a0) {
+		case HWRNG_RET_OK:
+			*buf++ = res.a2;
+			*buf++ = res.a3;
+			copied += 8;
+			tries = 0;
+			break;
+		case HWRNG_RET_RETRY_ERROR:
+			if (++tries >= HWRNG_MAX_TRIES)
+				return -EIO;
+			udelay(10);
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int exynos_trng_init_reg(struct udevice *dev)
+{
+	const u32 max_div = EXYNOS_TRNG_CLKDIV_MASK;
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+	unsigned long sss_rate;
+	u32 div;
+
+	sss_rate = clk_get_rate(trng->clk);
+
+	/*
+	 * For most TRNG circuits the clock frequency of under 500 kHz is safe.
+	 * The clock divider should be an even number.
+	 */
+	div = sss_rate / EXYNOS_TRNG_CLOCK_RATE;
+	div -= div % 2; /* make sure it's even */
+	if (div > max_div) {
+		dev_err(dev, "Clock divider too large: %u", div);
+		return -ERANGE;
+	}
+	writel_relaxed(div, trng->base + EXYNOS_TRNG_CLKDIV);
+
+	/* Enable the generator */
+	writel_relaxed(EXYNOS_TRNG_CTRL_RNGEN, trng->base + EXYNOS_TRNG_CTRL);
+
+	/* Disable post-processing */
+	writel_relaxed(0, trng->base + EXYNOS_TRNG_POST_CTRL);
+
+	return 0;
+}
+
+static int exynos_trng_init_smc(struct udevice *dev)
+{
+	struct arm_smccc_res res;
+	int ret = 0;
+
+	arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_INIT, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != HWRNG_RET_OK) {
+		dev_err(dev, "SMC command for TRNG init failed (%d)\n",
+			(int)res.a0);
+		ret = -EIO;
+	}
+	if ((int)res.a0 == -1)
+		dev_info(dev, "Make sure LDFW is loaded\n");
+
+	return ret;
+}
+
+static void exynos_trng_exit_smc(struct udevice *dev)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_CMD_RANDOM, HWRNG_EXIT, 0, 0, 0, 0, 0, 0, &res);
+}
+
+static int exynos_trng_read(struct udevice *dev, void *data, size_t len)
+{
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+
+	return trng->data->read(dev, data, len);
+}
+
+static int exynos_trng_of_to_plat(struct udevice *dev)
+{
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+
+	trng->data = (struct exynos_trng_variant *)dev_get_driver_data(dev);
+	if (!trng->data->smc) {
+		trng->base = dev_read_addr_ptr(dev);
+		if (!trng->base)
+			return -EINVAL;
+	}
+
+	trng->clk = devm_clk_get(dev, "secss");
+	if (IS_ERR(trng->clk))
+		return PTR_ERR(trng->clk);
+
+	trng->pclk = devm_clk_get_optional(dev, "pclk");
+	if (IS_ERR(trng->pclk))
+		return PTR_ERR(trng->pclk);
+
+	return 0;
+}
+
+static int exynos_trng_probe(struct udevice *dev)
+{
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_enable(trng->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(trng->clk);
+	if (ret)
+		return ret;
+
+	if (trng->data->init)
+		ret = trng->data->init(dev);
+
+	return ret;
+}
+
+static int exynos_trng_remove(struct udevice *dev)
+{
+	struct exynos_trng_priv *trng = dev_get_priv(dev);
+
+	if (trng->data->exit)
+		trng->data->exit(dev);
+
+	/* Keep SSS clocks enabled, they are needed for EL3_MON and kernel */
+
+	return 0;
+}
+
+static const struct dm_rng_ops exynos_trng_ops = {
+	.read	= exynos_trng_read,
+};
+
+static const struct exynos_trng_variant exynos5250_trng_data = {
+	.init	= exynos_trng_init_reg,
+	.read	= exynos_trng_read_reg,
+};
+
+static const struct exynos_trng_variant exynos850_trng_data = {
+	.smc	= true,
+	.init	= exynos_trng_init_smc,
+	.exit	= exynos_trng_exit_smc,
+	.read	= exynos_trng_read_smc,
+};
+
+static const struct udevice_id exynos_trng_match[] = {
+	{
+		.compatible = "samsung,exynos5250-trng",
+		.data = (ulong)&exynos5250_trng_data,
+	}, {
+		.compatible = "samsung,exynos850-trng",
+		.data = (ulong)&exynos850_trng_data,
+	},
+	{ },
+};
+
+U_BOOT_DRIVER(exynos_trng) = {
+	.name		= "exynos-trng",
+	.id		= UCLASS_RNG,
+	.of_match	= exynos_trng_match,
+	.of_to_plat	= exynos_trng_of_to_plat,
+	.probe		= exynos_trng_probe,
+	.remove		= exynos_trng_remove,
+	.ops		= &exynos_trng_ops,
+	.priv_auto	= sizeof(struct exynos_trng_priv),
+};
-- 
2.39.2

