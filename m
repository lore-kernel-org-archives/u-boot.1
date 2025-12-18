Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03ED6E2DD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56ABB835FD;
	Thu, 18 Dec 2025 20:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NV08HrWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344038003E; Thu, 18 Dec 2025 19:53:24 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB586800AB
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 19:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so925615a91.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766083995; x=1766688795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dUzH1TUdd1NyIwfreeKloVBUgv8T7MWItnK5pehBTY=;
 b=NV08HrWtg/a92ja6KYnYxPbsg9hyGtQxnwNodtKCgyQ96iM628xhJpbxFJC/EHNiQT
 6jg6UF0Vw9hDbvo2teY3ZGJ2WBEicdoUZHdL5pKr32Ek41g88vtpPKXH42kCmkaBP4y+
 73CbILVXhga3SwgLhp12X3Ccs9yPZ/6e5W0L635MluLBPqkUcps0VRGHBy651PW34Oy2
 BLxHkyVYCXAXKp/YvgOow9/2Y6Sq1zHyRkE2hmi5dtt2nvniRjOHSujvBjhz482HQ13G
 ZZ8Sv8gUsIWrC4Ri/P65RTt/8I+0y8zhEk40D7OBOsdjeohjRhGn+hd7RNh0R9A7hAoG
 aoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766083995; x=1766688795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6dUzH1TUdd1NyIwfreeKloVBUgv8T7MWItnK5pehBTY=;
 b=V/WdZ7IhdBNS2OG5VXsN7DBDn3mXFDox1MsNI5VaG8upJIRMg6j+T9+FKGVSXtPKCG
 nPh3YCIwyenkBe1GceusDVBiR89XDMjdwqBtfY1apz8EbV6YN75/77ELAZRbZjgL0EYW
 UbL/X1yr2I/52pyDLOp+v3ma2Va/TXg1DXc7y8vdtUtKC/9Gpy6qDPahy+c7oRgOSvfI
 qlj37NmJfTk9wpn6WE7fQMNLBZucNJq72dNUWQUHOa/zobOAwJlEG35+JB6g7d71yY0e
 e+hi/5F5WWwsXtCq0DI15DzcpilvEnm4A4Iv0GJ6zwdVCM3G63u7m7mRZNFa6zuY9e68
 inrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgtt1IDwpmrX8dUVt70gxQTD0XqoA62hUeU/dcWx5rAOgPyNdGIm2XdEKiNoyZMbYGEZpqvxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyDg6GN/odLlNiXzkl8Lm9MVb3qApVIwKQa1nUUJh65X6gP9jl5
 JhYdv7MV/bge5HdFCc9utCCV0e+ciQcS5/sfl/6L6If+VfjgF2ON6nug
X-Gm-Gg: AY/fxX64pJn2UWKcNdIERHp+MLPl+g9C2s/5H2NrQOPM+fnHZkTQC1oYRiwf0b9DiU/
 8/QURyTiZ4zyu2uRI/WmOuTT8L62kPec+DG2KEfLA6SweU+z0RLdF70piq/QYkB4HKsvq4rM8GL
 QEvGa2XW2kxYn5gzvMZOWCKopytr814taSwrYdVHQFJXx77VX1LriBYV+D+sNyBBUxNkytmS3XV
 5zXlqVpy8P8M8DyfTt0byQD2RtAtAgOCwtj40hCapC0FCnrwRc6uvycAze6t37UaT3AdLNc7uXi
 3HaQUebBBV90QCHW2VlWrRgKTg7A5spN6XJbLwP0p/qq6QQbJEyWu2i/air1ahWiBHjqr5Vggdo
 Nx6Qe9GC+413ZEonKh/5I4clQfRzRHwvvM2yZNXWULmWAErSsrOSD1ZIZmxQW7zVAxZoXNQH26n
 lCgMuW3AjhvqpI3RbYELSvlpP82xC2+iGI5bJg9H4BP0YMqDBDmk/u/+FQiQcd9fAbj9KT9jV9d
 HPjFp5opJDtwQp2BNFyaRjCxQWuArGa
X-Google-Smtp-Source: AGHT+IFb7Vs7cw+ellO097L2UGjJ8HZfdc6fNBMpDwHyYY99FXf3r8u4sD0ZrKAuiIyl+zlIgu7EhA==
X-Received: by 2002:a17:90b:53c7:b0:34a:adf1:6781 with SMTP id
 98e67ed59e1d1-34e92143b39mr264895a91.9.1766083995187; 
 Thu, 18 Dec 2025 10:53:15 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d65653sm3136275a91.5.2025.12.18.10.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:53:14 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/3] serial: Add Goldfish TTY driver
Date: Thu, 18 Dec 2025 18:52:50 +0000
Message-ID: <20251218185252.957388-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
In-Reply-To: <20251218185252.957388-1-visitorckw@gmail.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 20:05:51 +0100
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

Add support for the Google Goldfish TTY serial device. This virtual
device is commonly used in QEMU virtual machines (such as the m68k
virt machine) and Android emulators.

The driver implements basic console output and input polling using the
Goldfish MMIO interface.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 112 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 +++++
 5 files changed, 145 insertions(+)
 create mode 100644 drivers/serial/serial_goldfish.c
 create mode 100644 include/goldfish_tty.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ce0bbce13d..da4a6e4d518 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1259,6 +1259,12 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+GOLDFISH SERIAL DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/serial/serial_goldfish.c
+F:	include/goldfish_tty.h
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 371d7aa5bba..b84cb9ec781 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1193,4 +1193,12 @@ config SYS_SDMR
 	depends on MPC8XX_CONS
 	default 0x0
 
+config SERIAL_GOLDFISH
+	bool "Goldfish TTY support"
+	depends on DM_SERIAL
+	help
+	  Select this to enable support for the Goldfish TTY serial port.
+	  This virtual device is commonly used by QEMU virtual machines
+	  (e.g. m68k virt) for console output.
+
 endif
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 8eaae62b0fc..fe8d23be512 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
 obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 
 obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
+obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
new file mode 100644
index 00000000000..85d2a93b6ff
--- /dev/null
+++ b/drivers/serial/serial_goldfish.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ * Goldfish TTY driver for U-Boot
+ */
+
+#include <dm.h>
+#include <serial.h>
+#include <goldfish_tty.h>
+#include <asm/io.h>
+#include <linux/types.h>
+
+/* Goldfish TTY Register Offsets */
+#define GOLDFISH_TTY_PUT_CHAR       0x00
+#define GOLDFISH_TTY_BYTES_READY    0x04
+#define GOLDFISH_TTY_CMD            0x08
+#define GOLDFISH_TTY_DATA_PTR       0x10
+#define GOLDFISH_TTY_DATA_LEN       0x14
+#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
+#define GOLDFISH_TTY_VERSION        0x20
+
+/* Commands */
+#define CMD_WRITE_BUFFER   2
+#define CMD_READ_BUFFER    3
+
+struct goldfish_tty_priv {
+	void __iomem *base;
+};
+
+static int goldfish_serial_getc(struct udevice *dev)
+{
+	static u8 rx_buf[4];
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+	unsigned long base = (unsigned long)priv->base;
+	unsigned long paddr;
+	u32 count;
+
+	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
+	if (count == 0)
+		return -EAGAIN;
+
+	if (count > sizeof(rx_buf))
+		count = sizeof(rx_buf);
+
+	paddr = virt_to_phys((void *)rx_buf);
+
+	rx_buf[0] = 0xAA;
+
+	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
+	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
+	__raw_writel(count, (void *)(base + GOLDFISH_TTY_DATA_LEN));
+
+	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
+
+	if (rx_buf[0] == 0xAA)
+		return -EAGAIN;
+
+	return rx_buf[0];
+}
+
+static int goldfish_serial_putc(struct udevice *dev, const char ch)
+{
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+
+	__raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
+
+	return 0;
+}
+
+static int goldfish_serial_pending(struct udevice *dev, bool input)
+{
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+
+	if (input)
+		return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
+
+	return 0;
+}
+
+static int goldfish_serial_probe(struct udevice *dev)
+{
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+	struct goldfish_tty_plat *plat = dev_get_plat(dev);
+
+	if (!plat)
+		return -EINVAL;
+
+	priv->base = plat->base;
+
+	return 0;
+}
+
+static const struct dm_serial_ops goldfish_serial_ops = {
+	.putc = goldfish_serial_putc,
+	.pending = goldfish_serial_pending,
+	.getc = goldfish_serial_getc,
+};
+
+static const struct udevice_id goldfish_serial_ids[] = {
+	{ .compatible = "google,goldfish-tty" },
+	{ }
+};
+
+U_BOOT_DRIVER(serial_goldfish) = {
+	.name	= "serial_goldfish",
+	.id	= UCLASS_SERIAL,
+	.of_match = goldfish_serial_ids,
+	.probe	= goldfish_serial_probe,
+	.ops	= &goldfish_serial_ops,
+	.priv_auto = sizeof(struct goldfish_tty_priv),
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
new file mode 100644
index 00000000000..5a74bdcd87d
--- /dev/null
+++ b/include/goldfish_tty.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef _GOLDFISH_TTY_H_
+#define _GOLDFISH_TTY_H_
+
+#include <linux/types.h>
+
+/* Platform data for the Goldfish TTY driver
+ * Used to pass hardware base address from Board to Driver
+ */
+struct goldfish_tty_plat {
+	void __iomem *base;
+};
+
+#endif /* _GOLDFISH_TTY_H_ */
-- 
2.52.0.322.g1dd061c0dc-goog

