Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB425E8FDB8
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 23:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BCE83AED;
	Sat, 27 Dec 2025 00:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmfgXI8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77E8839FA; Fri, 26 Dec 2025 18:54:26 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684E5838FA
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 18:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so8339423b3a.1
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766771663; x=1767376463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJRhgZhJco4Dbtut/rPo88zSQmgZXi8DS476u4qxSdc=;
 b=dmfgXI8H/uCFBJ643UbDzRMelM0EePIEpNSUirOCCYpAp8ro4+AFvAYtEVmK9iTSvS
 4sjgi6+ok/XWIPTYLffsdTFbD0oChl1VuDWPubo2ujzK4Tr5y+3hDvckZgJQbkS7p1bL
 5PmvzeXyI+LgF6uoBLl1HvRmyTX9Xw9S6TT5HULx2im0fdm7e59szW+UR/4GA9QxHQzB
 9fA6B0ttrGdyFGXCPkemUGX+SsC80N5x0AnINEKwqyWUj9rNO1e2qAlfkIw/Mqpr2G5y
 R3qY5zJCePAt02bfES29kXuoLy5JQgpxLbWS80cSdZFedz04rGDTl4EHPI/LUkJCI/gu
 lpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766771663; x=1767376463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJRhgZhJco4Dbtut/rPo88zSQmgZXi8DS476u4qxSdc=;
 b=AntHNFBif2gJ78tueTK5/8RfGgCMHZwyMOTJ6J3SYkStTHHRJmzcFd3GJcLCt96vsM
 /0RQ2/0ET5HUfNjHsuXttiwj55J7bu+fQtNRCCjwxDaG4iXW3U9mQ93ANyV5YRhuI7NI
 Enqs06lRhTj1hiUUsf62Hqhm3a8A1bacW6vi9TpA0TmyKJE0OcjjyseuFu/+nZ7TL1kq
 Xy2dj8k/pzhmdIsanCcZt2cGmz0jeb5tKlcJ/sJ85f7tjJS5acWDhNHyTikcn7/fpx9w
 wFvkbK9N4L5DqpZrv2gjl+LLlxUo6mcANC2gb0Fqvhr4aMQ4gZ2mx7Kzi4454g9kGICC
 VvVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqmkmlp7zijRD0dTJ0Htg7jB3Qi6kSe0AoNXlcxohwt8XGlbzHmNQh6eIPRUUdew25L1Bhcbk=@lists.denx.de
X-Gm-Message-State: AOJu0YzUbnWyUreqqwQwPEjsqetabh3Fo1CnmiNIij4SAquPKJiCxIkq
 Ir/l9sfxEPr/EpcngWW9xHbnfqniyR7QnwShNVTvyE4GWCV1C/Wxg9n+
X-Gm-Gg: AY/fxX7pI9CMdwdrfZ6EozEqSvu4Tj1CqBI8Tnz2+RpLQfFtNs7zcGE3hMtFiK8s9uG
 5vYoNsO4/LR8COvA0TB9QWIGiX/fYtu9Bw6MioT25+nq7MT7S6u3efk1iky7hf0URlQ4mL6blMc
 k7dvvs0DhSJHgLmcoIqqwdNLW5R+nCVNx1Tf4WcMOfUf9xgqZ03EBPhmzPPsAlFC1No1we2Gtcd
 PRoEprNBCX7CZnxyk8EKFgUgwvLFmjEdoE5xBUr6IvnMc8Ej6arZ4UJI4PpjDbz+0SWZW+TZU1Y
 rU0HW/tWezaQESa9Dalyl7T+SFgAk2vKgVpfgw9CSLJDq4O3ht2p0XVpCbh0DmT3vbp5i5VIwyu
 JGnRt9Qowi9nPJ5/eWQw7YOOrtnvUTMJK+/pG+NavxyTPWeAXn99JmQmA4EP0e281OWJ5qP4D0n
 ln9dgnvFe6anE5UwW8QGwFCM8S/mUDISfcgofRjQhyFCBaCc9xCnd9+pGlIWU2xUERPZJ8mxECJ
 OmlP5Jmcitdy4esikRfxg==
X-Google-Smtp-Source: AGHT+IGGmOkGkSQco6pjGOkiFXRfqkq1AhDEIZdEDTvjlKTxpl8ydQwODZJqSDEiX3TdeXRRHWn25Q==
X-Received: by 2002:a05:6a00:39a1:b0:7ff:9fe7:9811 with SMTP id
 d2e1a72fcca58-7ff9fe7a134mr19767008b3a.31.1766771662803; 
 Fri, 26 Dec 2025 09:54:22 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a0595sm22463704b3a.44.2025.12.26.09.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 09:54:22 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org
Cc: trini@konsulko.com, me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/4] serial: Add Goldfish TTY driver
Date: Fri, 26 Dec 2025 17:53:57 +0000
Message-ID: <20251226175400.1154417-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251226175400.1154417-1-visitorckw@gmail.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Dec 2025 00:03:47 +0100
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
Changes in v2:
- Update SPDX license identifier to GPL-2.0-or-later.
- Sort header inclusions alphabetically.
- Move RX buffer into goldfish_tty_priv instead of using a static buffer.
- Make sure getc only read a single byte at a time.

 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 104 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 ++++++
 5 files changed, 137 insertions(+)
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
index 00000000000..ce5bff6bf4c
--- /dev/null
+++ b/drivers/serial/serial_goldfish.c
@@ -0,0 +1,104 @@
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
+	unsigned long base = (unsigned long)priv->base;
+	unsigned long paddr;
+	u32 count;
+
+	count = __raw_readl((void *)(base + GOLDFISH_TTY_BYTES_READY));
+	if (count == 0)
+		return -EAGAIN;
+
+	paddr = virt_to_phys((void *)&priv->rx_buf);
+
+	__raw_writel(0, (void *)(base + GOLDFISH_TTY_DATA_PTR_HIGH));
+	__raw_writel(paddr, (void *)(base + GOLDFISH_TTY_DATA_PTR));
+	__raw_writel(1, (void *)(base + GOLDFISH_TTY_DATA_LEN));
+
+	__raw_writel(CMD_READ_BUFFER, (void *)(base + GOLDFISH_TTY_CMD));
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

