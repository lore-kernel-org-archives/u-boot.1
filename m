Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709AFEE498F
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961E683F8E;
	Tue, 30 Dec 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V4azJlSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CEA83F70; Tue, 30 Dec 2025 17:01:36 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3605383F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so7465691b3a.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110492; x=1767715292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNNOfk+FlYazTY8tAZ8wOGfNJrOxqTbuaCxP9p6h7js=;
 b=V4azJlSF4plRvXrokTTsPOmy+ZO/+Ho6uoPUMswUG2i9gnagLAvg7U3iYGSSIfyqcl
 fFG3PEOF3eSGcYP/Gs6preuzqbgKdvjQcwQ7J3D40oXj/b+YubQtYzFN7Nk+4+bE7pu0
 anDuoy0YtiL1mnrcj7RYWOdVsAPFkmFA+CTOhRt/aHYG8/4hOYOaVVYoIFOKIYKu+nJJ
 /TpAxUqd+QN7HoOST13h+GlA+bcoYDH4pLghR/zVubm8TKxbgL6ZEPhr4BsollfksWjL
 lOaL/L76Gd86XNQh0rmMzKP6gZSE8U59hB0tUYXuQ7nBIOBMBxVMPw5ScieSAKbaWSgi
 zM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110492; x=1767715292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNNOfk+FlYazTY8tAZ8wOGfNJrOxqTbuaCxP9p6h7js=;
 b=nAb8HSvk4OaUaLKylQVjlpZRHLQL6x15ABP6dh6MY9fjtTxd1nJSjHpltPn64mRCj7
 ccokGCxLsmJYNn3c/Qju5XDiEdHwLiuJFcK5rUHZoDGlETvm20DYIUnBYA4eMfJ4Iozd
 lFylnSZyWJ1pAo4k44aYx832kDZ6lY2VUI5VmFPNFI4aB9ySRg7Y02pXHDkRNB5u8WEc
 5XOjsIu4vl8HiTV/a/Mnc07DflaCRTGBIwq7Ny5DCEtGa8qAmy/CjFShDkxhd6Eo5rVS
 0OLeKLwa6DmVMF2fVZTq5kgEYLk+Rrct4QNvQafa95rs4mmrXYr2ueFGxSV5WcMGd65n
 k23Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWan412ROlWAVQqCmwFKI8ScCp/ICqXQK8ILosa6xHkizauUmD3yMwvdtoLrnPpplGT7R/XxAM=@lists.denx.de
X-Gm-Message-State: AOJu0YwdY2IfhXaRUCCJOe5od7YO65X12yP0J70gdiI3b13UkPXX0uBY
 tJD+SbrPphVHXX8qpHd3sVRMLwsS99NeampNdG7YFhq9wT8rTAt0Y0vB
X-Gm-Gg: AY/fxX63yWTPEEf0aernJzxUmye94lVvsatxsWziUyCJI7GK9QsEyZhJ0nAg6+Qmo0J
 25awv1I3EIzfiO5cKlzrW+pNF3k/urRSrnrthVi1Fv2ntXARZqWRqjPon1e1iYcilqHvLgpi9/3
 5qByTXeqOjs22X9K6UEWASIj6x7cQImSutlUycWbd+Wfsd4T7eFT/Ewu64NItQc/AGgNhDf8Pc7
 R4+R4gD8wvuELd5GpIPJCyw/8BTONIDBoveUK9OV3XYXovwFIdkq+ArJZutxDs5Lo6W5rzO1NRS
 VmCX7W1eK9B1V8oYJg6K936CD5XfDw83sNFLPxyVBjOCSavorv1lzpGcLGMrryLnAcQH5mfCXbE
 qDlxC54lEPLZ5FZYrTOkUR4l51r+jPgK2BxmAOJb0lwlXAZNiK4OsHqURVcOqTkrIUGtH52B2Qz
 j7cAjM/rUtSx3wJcelKd38w8dKGpiqo9ai+j6c6xwGEO2QXVMO4pD09iWoO9fXPNauDy+fxLCdM
 G2O6RBDKadQp676OIAveA==
X-Google-Smtp-Source: AGHT+IFgyYdByGMEH902unEzY3SphE7cNhcLRbCGXZ4N6aIHRziC1WDJ2zX+tZi9DBPr1RaCBKRMZA==
X-Received: by 2002:a05:6a00:4392:b0:7f6:4922:89cc with SMTP id
 d2e1a72fcca58-7ff67258ed1mr28639993b3a.57.1767110491308; 
 Tue, 30 Dec 2025 08:01:31 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:31 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 1/6] serial: Add Goldfish TTY driver
Date: Tue, 30 Dec 2025 16:01:07 +0000
Message-ID: <20251230160112.3045527-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230160112.3045527-1-visitorckw@gmail.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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
Changes in v3:
- Remove unnecessary type casts for MMIO register access.

 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 102 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 ++++++
 5 files changed, 135 insertions(+)
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
index 00000000000..1d2977d809d
--- /dev/null
+++ b/drivers/serial/serial_goldfish.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ * Goldfish TTY driver for U-Boot
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <goldfish_tty.h>
+#include <linux/types.h>
+#include <serial.h>
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
+	u8 rx_buf;
+};
+
+static int goldfish_serial_getc(struct udevice *dev)
+{
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+	unsigned long paddr;
+	u32 count;
+
+	count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
+	if (count == 0)
+		return -EAGAIN;
+
+	paddr = virt_to_phys((void *)&priv->rx_buf);
+
+	__raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
+	__raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
+	__raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
+	__raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
+
+	return priv->rx_buf;
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
index 00000000000..8777da4942d
--- /dev/null
+++ b/include/goldfish_tty.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
2.52.0.358.g0dd7633a29-goog

