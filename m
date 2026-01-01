Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41837EEE25C
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9651B83C4B;
	Thu,  1 Jan 2026 22:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ii9Op5aa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43F683C4B; Thu,  1 Jan 2026 18:54:42 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B4583AAD
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso157819955ad.1
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290079; x=1767894879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQhVlCwRsPhLe8z0MHp2cSQZnAjMEKfs8xOYRh/Qnqk=;
 b=ii9Op5aajQ19d+kENsGxdRTgWcOuQif2J50NG25SF0g5JEx4jsOENo6edKhe0MH8h3
 gS3DOq53wGwrpZuR4nSzPtcjszo2JJhCiRV4q+K0RNW+99YSyk9guOkytepanbwYx6m7
 3JDc0na7EtYj/8hHdpsaBIyZWEL8SqraWeVX2mhIWmP4yHYJ93Lv3tGiav301AdYbGsG
 H+or7UgcsvnmVjQHfQiZ0bxkYWk6jYza/LUL/mCWFKWyEDqMbNrWQx8fNMyuj9jFDm4j
 NavSOkqJ6vi7x/kKS8d2WdtKqSFwL6OAIAWJgrr/U1TNpUmUJ17r28GlVVT+31QOJxn5
 MNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290079; x=1767894879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQhVlCwRsPhLe8z0MHp2cSQZnAjMEKfs8xOYRh/Qnqk=;
 b=E+lunexsKVRm8hA5AGS0nyPVowfdfKlbaQzjcCI2ep1UTMZ0hVCbgvxkYCIJgn0Hx8
 sKLN0hS6imxKEcUKJbP5w2GjVbzlxyrjDQEeNs4J0mXmgxTjzUmntkiRBdwN60sjoGfQ
 NlNJenxQVDNOSwJhW2BTwgIvCWDLTsENPq+XUTGR3xWLuqr9XNii4VA8srke/vHYoe87
 Qz1VDsohPSmjP+qEO4HsXVlEYF7Sr76jwr15p47A8j/Ql9QMCh5VbX64Kpu2/rDRg/qD
 lHC73jTxeCcJ5jxk6ZQIUzvWQaso7cp4LUhpTU0rATCoYqvLSYa2FAPVwWxB+daTs2rj
 dFog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYRquyPwgvesd+uOv3f5CDJZ2n/CAb7gFKjbMmzXIo23bbDA+jlLV7Fe+BdMA0Lfm68qZ6kDQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1i6DcK84XEGqygcx39+CE43YWMvW5HgrzJfSuyQqg1gzQg2Ta
 MSOJIFrl/aMllusnHiHqktSrpf/PF/0XgAqBeCgqZD0jEmpQVHPvxALV
X-Gm-Gg: AY/fxX47AvZITbjl8OaiUibXdgBs/0YZHIneQ/ulXy+VvPEdk4smt4HkJ1lD3MUbyqX
 08r9zjnrJd9K0kt0zCIx1kY7g1soJdQAAvpz/rf6xI9zhjgUAeOwPUwt9cjQ7gPtiiaYpUoBxRa
 OsMVt3TtvY9nDV05gW2ILmVfJwEu32ShZ/qfz6pe481jJsOCKKEXMGi2k1qMlZPS1d9ybos9FFQ
 86+rp4krozFbzDJoY4D2txLxJm6FWBDsYtRbjPl73Dtfg5JlnMjGt58rBBS2Xn2kr0oVtUU8mP5
 I3AfXK4zupN9iSWbEEayI6AWv6ctwTldETJ0G+2f75x3jTHSBxNgwAzEgWkXuqR6u2+MI6Xd3An
 2khLIZcTDHO4G1GxIpzD+bgD4Sg8+MEPGb468UoeTFTwpUswsBaE9VjFLlJpiVNTAcfkPHXLUT+
 pVpnlZAaAksZBHgoQ5Mv1RBEoeaYaPSaVbWkoGsPQKuuToQXtR7KcE1ibzMojaFYm9x3/83S4BN
 q6A/k1UH6WOV9F7GmddUA==
X-Google-Smtp-Source: AGHT+IF4iOBNZVPWYOYdlq63sFVwoHyI3yjebXVABF09dRoR8M5i/881Y1inLjthsbHcm28s5f2Cbw==
X-Received: by 2002:a17:903:228b:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-2a2f2c56453mr380334005ad.61.1767290078898; 
 Thu, 01 Jan 2026 09:54:38 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:38 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Date: Thu,  1 Jan 2026 17:54:15 +0000
Message-ID: <20260101175420.4118024-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260101175420.4118024-1-visitorckw@gmail.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Jan 2026 22:15:35 +0100
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
Reviewed-by: Yao Zi <me@ziyao.cc>
Tested-by: Daniel Palmer <daniel@0x0f.com>
---
Changes in v4:
- Support DT probing with platform data as a fallback.

 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 +++++
 5 files changed, 142 insertions(+)
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
index 00000000000..278d0cf3e0d
--- /dev/null
+++ b/drivers/serial/serial_goldfish.c
@@ -0,0 +1,109 @@
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
+#include <mapmem.h>
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
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr != FDT_ADDR_T_NONE) {
+		priv->base = map_sysmem(addr, 0x1000);
+	} else {
+		plat = dev_get_plat(dev);
+		if (!plat)
+			return -EINVAL;
+		priv->base = plat->base;
+	}
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

