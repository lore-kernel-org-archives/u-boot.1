Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7318CD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D1A84A06;
	Thu, 11 Jun 2026 04:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Azwa9o67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E704084979; Thu, 11 Jun 2026 00:13:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1C080517
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 00:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joaofl@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so48676625e9.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781129585; x=1781734385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3JqYj0RMpLdbgyi62L4YyPe/G3675mq6ljRWMJpWeo=;
 b=Azwa9o67kK3VqSxElv1dIRW4+1kRx04IX6vvIA4DQzvNm/3AmHfL8+2mMEYlhXYcY5
 20IFt2KLEOczWuldIttbqA1EUJEfGH63wSRGqdFhK39gJbI44OtwZSG8n66gqTYOCGHk
 lYpNgs65L4UEc2ANwVLHqxO5X8bvzNHaTZLpdcGPp+tv7X8RFRsYdroKLxE/9/ZGuChq
 4k2M12Spg3ImlI6k7vRdRvJBNelswSlSQAyHA9hcHR7M8Usq/wDk45STQqKVL3Lxz1kX
 WGzo505TZVsy1xl8vVRF/c8sI8ZpUMMSK4pvih/ilbLtRwPcXqCUcAQLJ3nXqUO0qbMr
 PM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781129585; x=1781734385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B3JqYj0RMpLdbgyi62L4YyPe/G3675mq6ljRWMJpWeo=;
 b=ni8Oh5iEs74U8kZn3Ewy0fc+jX68TZ0ni55RBF54vPk+tt1W6LeshvdZ7l6P55zB42
 7ZWmCeqrtM3MnhbRSj4ZWZVmhSP5lbVx0MjbkH10LWkVUlbdVUcLv75rAzen7nZYDLPC
 okEBLNlXInNerNYUca/TxEpQ0kJ5m5qBfgO+fttEssdIvFxNrf0AZ48moJOiYo2xa7lE
 vFXabjtdWN5eTe3dJ54tXYiLaujPjpwmDITSVW0yjpbckyWWr2O7D1WYtELVXqPDXJ6f
 +cEkixuj3Hx0FjarsmLoN1ZqRNApxOv+TexUZx5/jJk/LSclvySA6IdWtoI8LFJw0rHf
 m/Dg==
X-Gm-Message-State: AOJu0YzDfZylT7dZP1Ypru7Q/HSFiRBtfDmD82v2Z5OQ9T7NzU0m2bKM
 jETSe/BNZhEP1Oq/g+6NcnABhslmP4NUrM8Lzswer8LsswD2i6kh1sZLDKUYSQ==
X-Gm-Gg: Acq92OG1tMe5cJVx9z3lTuxaTbbzy5aSNAfMIE/kHKDbxdOmXaXN7smm73NhdsC9HMi
 MftItJb4xPEClpZf0hMUcnIjarNkADBP9yJ43EFJlqdzYCeYs06JFf9iycXZbc94sotwIBKUcY5
 lZS48LKBRDVFFJE8nHjfx/vzE7BfuNx0W2EQJtAJ9PVe+gXM5IvKdRKfdDjm/NJ6jd707QPmL+d
 lay3ye319Xq7YHUEpP01/13xg02kWJWM2cqAvXebzyIMF/RhHwT3WNQf4hIySOLF8nOSJC6zVxA
 cqna8vcj1WiyQ6UkM2ir/ScILoV9d54Sk4spTtuXNMuUcLVW3Ls2OiYIFGqQHGaXPP++Z6nnHPZ
 23VqNDo7LLk6ZeMxCNZ41zkhSOVZ1eqt8iH9IfAHTjXF0R+Yhmc3RlT0PhXWmWjlS1xh12FeXgg
 TTkQu/c3fZIz0JezYq0fKmlbJfy+VC90Cnc+coYBUPVYiuoWST041tuo8rP5gZ7yUHhG6FBkawD
 z1sK3Plq9UWzGdJcIJcdn5ZsyB3qEWoKOEIpXDb5PgsP5SrmawRqOI=
X-Received: by 2002:a05:6000:4a02:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-46067598b31mr128404f8f.10.1781129584599; 
 Wed, 10 Jun 2026 15:13:04 -0700 (PDT)
Received: from lap.lan (212-51-142-79.fiber7.init7.net. [212.51.142.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc577sm76673426f8f.3.2026.06.10.15.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 15:13:03 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v3 1/2] spi: Introduce initial EEPROM driver mode support
Date: Thu, 11 Jun 2026 00:11:59 +0200
Message-ID: <20260610221200.167711-2-joaofl@gmail.com>
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

This patch introduces the initial SPI EEPROM driver mode support
analogous to the I2C EEPROM driver mode support. The SPI EEPROM
driver mode support is enabled by default in the sandbox_defconfig.

Signed-off-by: João Loureiro <joaofl@gmail.com>
---
Changes in v3:
- Resolve all checkpatch errors and warnings (the driver was previously
  indented with spaces instead of tabs)
- Drop the no-op write stub that silently returned success; writes now
  return -ENOSYS via the uclass wrapper
- Remove unused spi_eeprom_drv_data fields and the empty bind hook
- Drop the bogus spi_slave_of_to_plat() call; the SPI uclass already
  parses the slave platform data
- Fix the read bounds check (reject negative offset/size and overflow)
- Make probe fail only on a real transfer error instead of treating a
  0xff status as "device not found"
- Correct the AT25160 geometry to 2048 bytes / 32-byte page
- Use kernel u8 types and mirror include/i2c_eeprom.h
- Add a MAINTAINERS entry
- Rebase on current master and resend from a personal address (the
  original Philips address is no longer reachable)

 MAINTAINERS               |   6 ++
 configs/sandbox_defconfig |   1 +
 drivers/misc/Kconfig      |   6 ++
 drivers/misc/Makefile     |   1 +
 drivers/misc/spi_eeprom.c | 185 ++++++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h    |   1 +
 include/spi_eeprom.h      |  91 +++++++++++++++++++
 7 files changed, 291 insertions(+)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 include/spi_eeprom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..3a99307051c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1772,6 +1772,12 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-spi.git
 F:	drivers/spi/
 F:	include/spi*
 
+SPI EEPROM
+M:	João Loureiro <joaofl@gmail.com>
+S:	Maintained
+F:	drivers/misc/spi_eeprom.c
+F:	include/spi_eeprom.h
+
 SPI NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..b13f236636f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -262,6 +262,7 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_SANDBOX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SYS_NAND_PAGE_SIZE=0x200
+CONFIG_SPI_EEPROM=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..f7336d3c7f0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -567,6 +567,12 @@ config I2C_EEPROM
 	help
 	  Enable a generic driver for EEPROMs attached via I2C.
 
+config SPI_EEPROM
+	bool "SPI EEPROM support"
+	depends on MISC
+	help
+	  Enable support for SPI EEPROM devices.
+	  Currently with only read access.
 
 config SPL_I2C_EEPROM
 	bool "Enable driver for generic I2C-attached EEPROMs for SPL"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..8c9f8eb9cfa 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
 obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
+obj-$(CONFIG_$(PHASE_)SPI_EEPROM) += spi_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
new file mode 100644
index 00000000000..67685c24771
--- /dev/null
+++ b/drivers/misc/spi_eeprom.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ */
+
+#define LOG_CATEGORY UCLASS_SPI_EEPROM
+
+#include <dm.h>
+#include <spi.h>
+#include <spi_eeprom.h>
+#include <linux/err.h>
+
+struct spi_eeprom_drv_data {
+	u32 size;		/* total capacity in bytes */
+	u32 pagesize;		/* page size in bytes */
+	u8 cmd_read_data;	/* opcode to read the memory array */
+	u8 cmd_read_status;	/* opcode to read the status register */
+};
+
+int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf, int size)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->read)
+		return -ENOSYS;
+
+	return ops->read(dev, offset, buf, size);
+}
+
+int spi_eeprom_write(struct udevice *dev, int offset, const u8 *buf, int size)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->write)
+		return -ENOSYS;
+
+	return ops->write(dev, offset, buf, size);
+}
+
+int spi_eeprom_size(struct udevice *dev)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->size)
+		return -ENOSYS;
+
+	return ops->size(dev);
+}
+
+static int spi_eeprom_read_cmd(struct udevice *dev, u8 *buf, int size,
+			       const u8 *cmd, int cmd_size)
+{
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	int ret;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret) {
+		log_err("Failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	/* Send the command, keeping the transaction open */
+	ret = spi_xfer(slave, cmd_size * 8, cmd, NULL, SPI_XFER_BEGIN);
+	if (ret) {
+		log_err("Failed to send command: %d\n", ret);
+		goto release;
+	}
+
+	/* Read the data back and close the transaction */
+	ret = spi_xfer(slave, size * 8, NULL, buf, SPI_XFER_END);
+	if (ret)
+		log_err("Failed to read data: %d\n", ret);
+
+release:
+	dm_spi_release_bus(dev);
+	return ret;
+}
+
+/*
+ * Read the status register. Returns the register value on success or a
+ * negative error code on failure.
+ *
+ * Status register layout (AT25-style devices):
+ *   Bit 0    Ready/Busy: 1 while an internal write cycle is in progress
+ *   Bit 1    Write Enable Latch
+ *   Bits 2-3 Block write protection
+ *   Bits 4-6 Reserved
+ *   Bit 7    Write-protect enable
+ */
+static int spi_eeprom_read_status(struct udevice *dev, u8 *status)
+{
+	const struct spi_eeprom_drv_data *data =
+		(const struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+	u8 cmd = data->cmd_read_status;
+
+	return spi_eeprom_read_cmd(dev, status, 1, &cmd, 1);
+}
+
+static int spi_eeprom_std_read(struct udevice *dev, int offset, u8 *buf,
+			       int size)
+{
+	const struct spi_eeprom_drv_data *data =
+		(const struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+	struct spi_eeprom *priv = dev_get_priv(dev);
+	u8 cmd[SPI_EEPROM_CMD_SIZE];
+
+	if (offset < 0 || size < 0 || offset + size > priv->size) {
+		log_err("Read out of bounds (offset %d, size %d, max %lu)\n",
+			offset, size, priv->size);
+		return -EINVAL;
+	}
+
+	cmd[0] = data->cmd_read_data;
+	cmd[1] = (offset >> 8) & 0xff;
+	cmd[2] = offset & 0xff;
+
+	return spi_eeprom_read_cmd(dev, buf, size, cmd, sizeof(cmd));
+}
+
+static int spi_eeprom_std_size(struct udevice *dev)
+{
+	struct spi_eeprom *priv = dev_get_priv(dev);
+
+	return priv->size;
+}
+
+static const struct spi_eeprom_ops spi_eeprom_std_ops = {
+	.read	= spi_eeprom_std_read,
+	.size	= spi_eeprom_std_size,
+};
+
+static int spi_eeprom_std_of_to_plat(struct udevice *dev)
+{
+	const struct spi_eeprom_drv_data *data =
+		(const struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+	struct spi_eeprom *priv = dev_get_priv(dev);
+
+	priv->size = dev_read_u32_default(dev, "size", data->size);
+	priv->pagesize = dev_read_u32_default(dev, "pagesize", data->pagesize);
+
+	return 0;
+}
+
+static int spi_eeprom_std_probe(struct udevice *dev)
+{
+	u8 status;
+	int ret;
+
+	ret = spi_eeprom_read_status(dev, &status);
+	if (ret) {
+		log_err("Failed to read status register: %d\n", ret);
+		return ret;
+	}
+
+	log_debug("status register: 0x%02x\n", status);
+
+	return 0;
+}
+
+static const struct spi_eeprom_drv_data atmel25_data = {
+	.size			= 2048,
+	.pagesize		= 32,
+	.cmd_read_data		= AT25_CMD_READ_DATA,
+	.cmd_read_status	= AT25_CMD_READ_STATUS,
+};
+
+static const struct udevice_id spi_eeprom_std_ids[] = {
+	{ .compatible = "microchip,at25160bn", .data = (ulong)&atmel25_data },
+	{ }
+};
+
+U_BOOT_DRIVER(spi_eeprom_std) = {
+	.name		= "spi_eeprom",
+	.id		= UCLASS_SPI_EEPROM,
+	.of_match	= spi_eeprom_std_ids,
+	.probe		= spi_eeprom_std_probe,
+	.of_to_plat	= spi_eeprom_std_of_to_plat,
+	.priv_auto	= sizeof(struct spi_eeprom),
+	.ops		= &spi_eeprom_std_ops,
+};
+
+UCLASS_DRIVER(spi_eeprom) = {
+	.id	= UCLASS_SPI_EEPROM,
+	.name	= "spi_eeprom",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304..d24b4a1a121 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -138,6 +138,7 @@ enum uclass_id {
 	UCLASS_SOC,		/* SOC Device */
 	UCLASS_SOUND,		/* Playing simple sounds */
 	UCLASS_SPI,		/* SPI bus */
+	UCLASS_SPI_EEPROM,	/* SPI EEPROM device */
 	UCLASS_SPI_FLASH,	/* SPI flash */
 	UCLASS_SPI_GENERIC,	/* Generic SPI flash target */
 	UCLASS_SPMI,		/* System Power Management Interface bus */
diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h
new file mode 100644
index 00000000000..e50daa64634
--- /dev/null
+++ b/include/spi_eeprom.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ */
+
+#ifndef __SPI_EEPROM
+#define __SPI_EEPROM
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/* AT25-style command set */
+#define AT25_CMD_READ_DATA	0x03	/* Read data from memory array */
+#define AT25_CMD_READ_STATUS	0x05	/* Read status register */
+
+/* 1 command byte followed by a 16-bit address */
+#define SPI_EEPROM_CMD_SIZE	3
+
+struct udevice;
+
+struct spi_eeprom_ops {
+	int (*read)(struct udevice *dev, int offset, u8 *buf, int size);
+	int (*write)(struct udevice *dev, int offset, const u8 *buf,
+		     int size);
+	int (*size)(struct udevice *dev);
+};
+
+struct spi_eeprom {
+	/* The EEPROM's page size in bytes */
+	unsigned long pagesize;
+	/* The EEPROM's capacity in bytes */
+	unsigned long size;
+};
+
+#if CONFIG_IS_ENABLED(SPI_EEPROM)
+/*
+ * spi_eeprom_read() - read bytes from an SPI EEPROM chip
+ *
+ * @dev:	Chip to read from
+ * @offset:	Offset within chip to start reading
+ * @buf:	Place to put data
+ * @size:	Number of bytes to read
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf, int size);
+
+/*
+ * spi_eeprom_write() - write bytes to an SPI EEPROM chip
+ *
+ * @dev:	Chip to write to
+ * @offset:	Offset within chip to start writing
+ * @buf:	Buffer containing data to write
+ * @size:	Number of bytes to write
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_write(struct udevice *dev, int offset, const u8 *buf,
+		     int size);
+
+/*
+ * spi_eeprom_size() - get size of SPI EEPROM chip
+ *
+ * @dev:	Chip to query
+ *
+ * Return: +ve size in bytes on success, -ve on failure
+ */
+int spi_eeprom_size(struct udevice *dev);
+
+#else /* !SPI_EEPROM */
+
+static inline int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf,
+				  int size)
+{
+	return -ENOSYS;
+}
+
+static inline int spi_eeprom_write(struct udevice *dev, int offset,
+				   const u8 *buf, int size)
+{
+	return -ENOSYS;
+}
+
+static inline int spi_eeprom_size(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
+#endif /* SPI_EEPROM */
+
+#endif
-- 
2.54.0

