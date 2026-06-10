Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89426CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39AB84A0E;
	Thu, 11 Jun 2026 04:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pUrFI9sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A7E8498C; Thu, 11 Jun 2026 00:13:15 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DDE80517
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 00:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joaofl@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-46066e640easo55318f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781129593; x=1781734393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fghOCEwHcVu9FV7LN+z3nNH3x6ppnzyf5LptErsX6Sg=;
 b=pUrFI9sxbHijcpa9XK4RCToDtabTotutaNVTwqeWO/oOZ70PeRZe9Y+2p/u6qeSoMk
 vUHp2BYTh9IVDXhDytV+WP/EAkKobPo8/+S1Xk2GG8y8QkeuTE9Mfjdpb0JxuyFfBTUU
 KZ4hZYAWhfhn9vzgN77sLUYDjqWd9Jndzs80T9HWFa/qgIffUVP4DsFgipLsorHkpKof
 bpxK6XuYSGwPl5F1IvF4KRy7ZKLjo4dml6MkeKmWTX5v7CyF65CGffs1kwmjKCqPjIvh
 Yfj2An353J+kVk2DtPphfF36ZJ7CrcFQG4VdcF0X97qkmencHmaLUN1h+0hs4vyJdIsD
 f2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781129593; x=1781734393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fghOCEwHcVu9FV7LN+z3nNH3x6ppnzyf5LptErsX6Sg=;
 b=K2siGKzLWmh5y+ZF4QFJC8G2mZ79d3nyVyHn53+j1QHLAEWHhl76f16one47S4nFXK
 tf2+BdMeQHK6/D5tRuy/XJNp0QgcciAFP6oxEnZ0Q/1apNoiFQiMD4pnRA319G7vWURW
 1xR7iE7Yip3A7+6Be3N4ppO9IXKtHoO//i4U12v5nQ2o2t0KCjmIm8vRCplF61ipGuCS
 mGk5xJQaoG2mjIewpTAeAd2WIFsmg/B12+c8+4naKlOMX8naXFtWV+ExOEIove1SaMRS
 5cJz5siMZ8bSV+7M5InpT5QPwHGlx9KvKFe+k2LNIeKaS1QzAKxM06zH5lsUbJa66dXK
 RHkw==
X-Gm-Message-State: AOJu0YwmdwDhCcGOPWPTb9L0ssZdxP5jqJy1Fmib8Q60h/FGN4k4Q6RL
 HurpX0C623sK6tNv6yk5z5sXt44zd6yVWSFbybrsAGS1EPTO3EiJv0VtylTyGg==
X-Gm-Gg: Acq92OGbrfVE7hHreepfeFd68Drpf7sGhAgs/9Wb4q/O71lon+WXDif74O9nSJPI1sA
 O/hwouqyE2jzO3wxsbs8RgoUgTkwjC4kwraPpM8girLQM/v1T7rxVp6qwfXP5cESnczAAnq+O9V
 Na06NG6j03Qc9yZOw745uPPIyl5rmEIR+YJHQsVQN+NjRhFtwdjXL+nEsf87jQN0iz3tQ6JKThG
 dsJm18v8RjK9MxdYKB4FAqfuwwv0PNi0p5l5NGACdEbWFIO8h5LJkfmZKRMwHQXn5/Cl+3Zv4BQ
 Ynrlh1k0xFLpZKDxwjVXi1IpIpLDf2JDl+/IrBU28Z8f8qJ7bIG1T97zK0ElurJp0P/fjad3cqJ
 vgBjuvdujlbe2ZRM6O2ZrZEFXhEG2FTSQWSa6djhbmsM0HJMWYnw/RcTPvPY6WVgl4290xvkmso
 ULBn0IWN4bmntNEnBPC3uPQxEiuTFeTV4eeyfJtZBud53ezSnR8v+hwE7OVc8bbONxRLxtP+Ub7
 kl5fU7xQrmwgiTCV10rTKHXqLrTHoK6zSZ5O5blu5VL
X-Received: by 2002:a05:6000:144a:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-460677e6049mr105896f8f.40.1781129592841; 
 Wed, 10 Jun 2026 15:13:12 -0700 (PDT)
Received: from lap.lan (212-51-142-79.fiber7.init7.net. [212.51.142.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc577sm76673426f8f.3.2026.06.10.15.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 15:13:12 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v3 2/2] sandbox: spi: Add SPI EEPROM emulator and DM test
Date: Thu, 11 Jun 2026 00:12:00 +0200
Message-ID: <20260610221200.167711-3-joaofl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610221200.167711-1-joaofl@gmail.com>
References: <AM9P122MB0281B24BE5B8A8E6A3F2D343F2CB2@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
 <20260610221200.167711-1-joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

Add a sandbox emulator for an AT25-style SPI EEPROM so the new SPI
EEPROM uclass can be exercised without real hardware.

The sandbox SPI controller previously always bound the SPI flash
emulator for every chip select. Allow a slave node to select its own
emulator through a sandbox,emul phandle (mirroring the sandbox I2C
bus), falling back to the SPI flash emulator when none is given so that
existing behaviour is preserved.

A test EEPROM is wired up on chip select 3 of the sandbox SPI bus and a
test/dm test verifies size reporting, patterned reads, out-of-bounds
rejection and the unimplemented write path.

Signed-off-by: João Loureiro <joaofl@gmail.com>
---
Changes in v3:
- New patch, added to provide sandbox coverage for the new uclass

 MAINTAINERS                    |   2 +
 arch/sandbox/dts/test.dts      |  13 +++-
 drivers/misc/Makefile          |   1 +
 drivers/misc/spi_eeprom_emul.c | 118 +++++++++++++++++++++++++++++++++
 drivers/spi/sandbox_spi.c      |  31 ++++++++-
 test/dm/Makefile               |   1 +
 test/dm/spi_eeprom.c           |  45 +++++++++++++
 7 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/spi_eeprom_emul.c
 create mode 100644 test/dm/spi_eeprom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a99307051c..173f83a9cb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1776,7 +1776,9 @@ SPI EEPROM
 M:	João Loureiro <joaofl@gmail.com>
 S:	Maintained
 F:	drivers/misc/spi_eeprom.c
+F:	drivers/misc/spi_eeprom_emul.c
 F:	include/spi_eeprom.h
+F:	test/dm/spi_eeprom.c
 
 SPI NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..4ccb6984a68 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1602,7 +1602,7 @@
 		#size-cells = <0>;
 		reg = <0 1>;
 		compatible = "sandbox,spi";
-		cs-gpios = <0>, <0>, <&gpio_a 0>;
+		cs-gpios = <0>, <0>, <&gpio_a 0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_spi0_pins>;
 
@@ -1620,6 +1620,17 @@
 			spi-cpol;
 			spi-cpha;
 		};
+		eeprom@3 {
+			reg = <3>;
+			compatible = "microchip,at25160bn";
+			spi-max-frequency = <1000000>;
+			sandbox,emul = <&spi_eeprom_emul>;
+		};
+	};
+
+	spi_eeprom_emul: spi-eeprom-emul {
+		compatible = "sandbox,spi-eeprom";
+		sandbox,size = <2048>;
 	};
 
 	syscon0: syscon@0 {
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 8c9f8eb9cfa..8fa0fe75b53 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_$(PHASE_)SPI_EEPROM) += spi_eeprom.o
+obj-$(CONFIG_SANDBOX) += spi_eeprom_emul.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
diff --git a/drivers/misc/spi_eeprom_emul.c b/drivers/misc/spi_eeprom_emul.c
new file mode 100644
index 00000000000..1504c7e1de8
--- /dev/null
+++ b/drivers/misc/spi_eeprom_emul.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sandbox emulation of an AT25-style SPI EEPROM.
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ */
+
+#define LOG_CATEGORY UCLASS_SPI_EMUL
+
+#include <dm.h>
+#include <malloc.h>
+#include <spi.h>
+#include <spi_eeprom.h>
+#include <linux/err.h>
+
+#define SANDBOX_SPI_EEPROM_SIZE		2048
+
+/**
+ * struct sandbox_spi_eeprom - state of the emulated EEPROM
+ *
+ * @data:	Backing store for the memory array
+ * @size:	Size of the memory array in bytes
+ * @cmd:	Opcode of the command currently being processed
+ * @cmd_len:	Number of command/address bytes consumed so far
+ * @addr:	Byte address decoded from the command
+ */
+struct sandbox_spi_eeprom {
+	u8 *data;
+	uint size;
+	u8 cmd;
+	uint cmd_len;
+	uint addr;
+};
+
+static int sandbox_spi_eeprom_xfer(struct udevice *dev, uint bitlen,
+				   const void *dout, void *din, ulong flags)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	const u8 *tx = dout;
+	u8 *rx = din;
+	uint bytes = bitlen / 8;
+	uint i;
+
+	if (bitlen % 8)
+		return -EINVAL;
+
+	/* A new transaction starts with the command/address phase */
+	if (flags & SPI_XFER_BEGIN) {
+		priv->cmd = 0;
+		priv->cmd_len = 0;
+		priv->addr = 0;
+	}
+
+	for (i = 0; i < bytes; i++) {
+		if (tx) {
+			/* Command phase: first byte is the opcode */
+			if (priv->cmd_len == 0)
+				priv->cmd = tx[i];
+			else if (priv->cmd == AT25_CMD_READ_DATA)
+				priv->addr = (priv->addr << 8) | tx[i];
+			priv->cmd_len++;
+		} else if (rx) {
+			/* Data phase: serve the requested register/array */
+			switch (priv->cmd) {
+			case AT25_CMD_READ_STATUS:
+				/* Ready, write disabled, not protected */
+				rx[i] = 0x00;
+				break;
+			case AT25_CMD_READ_DATA:
+				rx[i] = priv->addr < priv->size ?
+					priv->data[priv->addr] : 0xff;
+				priv->addr++;
+				break;
+			default:
+				rx[i] = 0xff;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int sandbox_spi_eeprom_probe(struct udevice *dev)
+{
+	struct sandbox_spi_eeprom *priv = dev_get_priv(dev);
+	uint i;
+
+	priv->size = dev_read_u32_default(dev, "sandbox,size",
+					  SANDBOX_SPI_EEPROM_SIZE);
+	priv->data = calloc(1, priv->size);
+	if (!priv->data)
+		return -ENOMEM;
+
+	/* Fill with a known pattern so reads can be verified */
+	for (i = 0; i < priv->size; i++)
+		priv->data[i] = i & 0xff;
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_spi_eeprom_ops = {
+	.xfer	= sandbox_spi_eeprom_xfer,
+};
+
+static const struct udevice_id sandbox_spi_eeprom_ids[] = {
+	{ .compatible = "sandbox,spi-eeprom" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_spi_eeprom) = {
+	.name		= "sandbox_spi_eeprom",
+	.id		= UCLASS_SPI_EMUL,
+	.of_match	= sandbox_spi_eeprom_ids,
+	.probe		= sandbox_spi_eeprom_probe,
+	.priv_auto	= sizeof(struct sandbox_spi_eeprom),
+	.ops		= &sandbox_spi_eeprom_ops,
+};
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 3ee97d67f4a..619368243ed 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -77,6 +77,35 @@ static int sandbox_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
 	return 0;
 }
 
+/**
+ * sandbox_spi_emul_get() - find the emulator for a SPI slave
+ *
+ * A slave can name a dedicated emulator through a "sandbox,emul" phandle (for
+ * example an SPI EEPROM). When no such phandle is present we fall back to the
+ * built-in SPI flash emulator, preserving the previous behaviour.
+ */
+static int sandbox_spi_emul_get(struct sandbox_state *state, struct udevice *bus,
+				struct udevice *slave, struct udevice **emulp)
+{
+	struct sandbox_spi_info *info;
+	int ret;
+
+	info = &state->spi[dev_seq(bus)][spi_chip_select(slave)];
+	if (info->emul) {
+		*emulp = info->emul;
+		return 0;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_SPI_EMUL, slave, "sandbox,emul",
+					   emulp);
+	if (!ret) {
+		info->emul = *emulp;
+		return 0;
+	}
+
+	return sandbox_spi_get_emul(state, bus, slave, emulp);
+}
+
 static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			    const void *dout, void *din, unsigned long flags)
 {
@@ -106,7 +135,7 @@ static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 		       busnum, cs);
 		return -ENOENT;
 	}
-	ret = sandbox_spi_get_emul(state, bus, slave, &emul);
+	ret = sandbox_spi_emul_get(state, bus, slave, &emul);
 	if (ret) {
 		printf("%s: busnum=%u, cs=%u: no emulation available (err=%d)\n",
 		       __func__, busnum, cs, ret);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66..df8e0c1011e 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_SMEM) += smem.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
+obj-$(CONFIG_SPI_EEPROM) += spi_eeprom.o
 obj-$(CONFIG_SPMI) += spmi.o
 obj-y += syscon.o
 obj-$(CONFIG_RESET_SYSCON) += syscon-reset.o
diff --git a/test/dm/spi_eeprom.c b/test/dm/spi_eeprom.c
new file mode 100644
index 00000000000..2601b9254b4
--- /dev/null
+++ b/test/dm/spi_eeprom.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Tests for the SPI EEPROM uclass
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ */
+
+#include <dm.h>
+#include <spi_eeprom.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Read from the emulated SPI EEPROM and check the uclass operations */
+static int dm_test_spi_eeprom(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[16];
+	int i;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_EEPROM, "eeprom@3",
+					      &dev));
+
+	/* The emulator advertises a 2 KiB array */
+	ut_asserteq(2048, spi_eeprom_size(dev));
+
+	/* The backing store is filled with a (addr & 0xff) pattern */
+	ut_assertok(spi_eeprom_read(dev, 0, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq(i & 0xff, buf[i]);
+
+	/* Reads honour the requested offset */
+	ut_assertok(spi_eeprom_read(dev, 0x100, buf, sizeof(buf)));
+	for (i = 0; i < sizeof(buf); i++)
+		ut_asserteq((0x100 + i) & 0xff, buf[i]);
+
+	/* Reads past the end of the array are rejected */
+	ut_asserteq(-EINVAL, spi_eeprom_read(dev, 2040, buf, sizeof(buf)));
+
+	/* Writing is not implemented yet */
+	ut_asserteq(-ENOSYS, spi_eeprom_write(dev, 0, buf, 1));
+
+	return 0;
+}
+DM_TEST(dm_test_spi_eeprom, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.54.0

