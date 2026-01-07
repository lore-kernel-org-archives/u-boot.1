Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB9FD0D16D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B66840B1;
	Wed,  7 Jan 2026 21:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BfRsFll9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10BBC83A2D; Wed,  7 Jan 2026 21:19:07 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6904083A1E
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c0ec27cad8cso1143235a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817143; x=1768421943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1EuWg7yyjMG1vbapWbadC2fe37R3CHN1BM+VvlTbZE=;
 b=BfRsFll9VwJkvvpIuyOJBFxNnsXyP3waJ2ylGxnRueXwwkXPKp3olsVspe+hoWguHA
 52j9r3oEYu3qJqEtRhAz4cTR3/j1jIJpRDt9KojtKii+TMgW2byYMZl/NsQRWxXWUkTk
 mfNZv9uXaARMxc3+S+YLKvKa/pvx1ftUProhycRSo41dXiTNup8QINmQxjNbvdd7+JVg
 rD6hqLDUvYi7i/s0YUs7jkd1tWFv9azpitKasSwcgqFA9UrjuTOQJPti7hhEIeNnvFk4
 ICQFU1Z2YmQ7FS0U6WshHHpA+fliR29PTIp3ZQJV/pBqVTo5MkkskrRbKoKMigQR6O3E
 wgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817143; x=1768421943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1EuWg7yyjMG1vbapWbadC2fe37R3CHN1BM+VvlTbZE=;
 b=tH6rXzO88FCWM9VQWgjjmIs137p40ZXtns+uBxg04/unF51jhxRTnTmfhGvFz3c4Y7
 eriytFhqAlD3kaWFQiv14LgzIG5nZH5xG9NAsbObwTC5xlvcJMuqutwvRJE0t7ZmkmLY
 WqNSULJdFXUJw8txJVmeHech4FYa0CpGeCGd6iiDkwC0Ju/SdUGJgF+MVxjLB6uCVrnc
 Y+rPVsMJBMflsuOr9SijAfpKnA9g9LWkZb3Yawgk+p+wepC6KWuNBxpOTDA6HNwOIXQV
 uvtIVbuj4/UKGANoIvQ6hoCc+qqBB5LUO49+KCau34o1YqPrjZSiJYJsySr5/u119K5c
 faHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP5XMPw2bD3lvkpVT4tHCWr+0CiWXky02/jLYHmd0oCz6ap5MvexMP7ui5StnpaAHA9+IfCuA=@lists.denx.de
X-Gm-Message-State: AOJu0YxIhEr8AKiHNnjOjWfRvPxs/ULrHbMZ3AQnCKrrV/roFVjYmQtk
 Ujb8JiloiAO/dyDnhAnlaylPt+Yz7nt/I+IIw7nmeDDNc4o9Kj1/lbec
X-Gm-Gg: AY/fxX6HKRva3atf4HJObCtx6rWeozk8xp5zPlxCq5KEQZlK+Nk0fcfjLAfPsdHthMC
 /j9A0DpoShfF39LXxRJqIUk466tWRj9ei3aV17IaF9t2DKYWd/2ZPDdDrINl/JywxfwwhE1kjr9
 hhI+NRpP+SQfhtUTkUv+3XgN/tawzHSeQS+ckjNvAboUgC+Yjow4KWh5dkID8zv7ESDdxLX4fP6
 IgZhn37etbAYXZadFHSnYEXpx9bfwo6BhhWGiAaLGnkgw44TtZHV9TIEcuWHbl1TWpJGhOxdTaw
 u989eG/x2R74rs0uMsAuW5/XF2F/oMH33gXDRD/uUIQAaABIt7r+mF9NSv1LyLo5kR+2jg6YH1n
 6HXnnhGcaw3HqdDYaMpqx0+c7ksnox3KgtWcx1VVkSRvii6iAf4Tgikdn7/gZ/fz2dreHGtQg7I
 LoY4SOK5ZF2icbO0B01s+tHr5UMCzRHBCj5pTYAuK3Ck8Macpduh0/meRZkZElTVSHAM0fJIgpG
 YfdxLYW7kwpPBm96zwpPA==
X-Google-Smtp-Source: AGHT+IGyNGAJ4FY8kP6LaunYbtxaTWLNPYWnI1r2BvdIzqvZGsE1XKzPD0319x+yWsGftZ7HBDefPg==
X-Received: by 2002:a17:90a:c107:b0:34e:5aa2:cf68 with SMTP id
 98e67ed59e1d1-34f68c27d59mr3064447a91.30.1767817142793; 
 Wed, 07 Jan 2026 12:19:02 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:02 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v6 1/8] serial: Add Goldfish TTY driver
Date: Wed,  7 Jan 2026 20:18:30 +0000
Message-ID: <20260107201838.3448806-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:27 +0100
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
Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes in v6:
- Refactor driver to separate device tree reading into .of_to_plat.
- Rename platform data member from 'base' to 'reg' (phys_addr_t).
- Update header includes to follow U-Boot coding style.

 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 117 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 +++++
 5 files changed, 150 insertions(+)
 create mode 100644 drivers/serial/serial_goldfish.c
 create mode 100644 include/goldfish_tty.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ce73d83f4..8f884ff495a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,6 +1260,12 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+GOLDFISH SERIAL DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/serial/serial_goldfish.c
+F:	include/goldfish_tty.h
+
 INTERCONNECT:
 M:	Neil Armstrong <neil.armstrong@linaro.org>
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
index 00000000000..4ac2cfb6231
--- /dev/null
+++ b/drivers/serial/serial_goldfish.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ * Goldfish TTY driver for U-Boot
+ */
+
+#include <dm.h>
+#include <goldfish_tty.h>
+#include <mapmem.h>
+#include <serial.h>
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
+static int goldfish_serial_of_to_plat(struct udevice *dev)
+{
+	struct goldfish_tty_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr != FDT_ADDR_T_NONE)
+		plat->reg = addr;
+
+	return 0;
+}
+
+static int goldfish_serial_probe(struct udevice *dev)
+{
+	struct goldfish_tty_plat *plat = dev_get_plat(dev);
+	struct goldfish_tty_priv *priv = dev_get_priv(dev);
+
+	if (!plat->reg)
+		return -EINVAL;
+
+	priv->base = map_sysmem(plat->reg, 0x1000);
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
+	.of_to_plat = goldfish_serial_of_to_plat,
+	.plat_auto = sizeof(struct goldfish_tty_plat),
+	.probe	= goldfish_serial_probe,
+	.ops	= &goldfish_serial_ops,
+	.priv_auto = sizeof(struct goldfish_tty_priv),
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
new file mode 100644
index 00000000000..db49c8d6344
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
+	phys_addr_t reg;
+};
+
+#endif /* _GOLDFISH_TTY_H_ */
-- 
2.52.0.457.g6b5491de43-goog

