Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B1CC79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD3083F36;
	Mon,  5 Jan 2026 19:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hgtzbQ0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3180083DEE; Mon,  5 Jan 2026 17:53:13 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C0083D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso1031965ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631961; x=1768236761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRbH3mFptp7GM4kVFS40Hw0p2MRIzB+9Tu+JTLG0ZM8=;
 b=hgtzbQ0i6bcLxCQKwiPugAaP0OMg5wls1U8dY/h7GVTxnMfPYZebyPC4ncYV98JQsN
 K9J3jZI9JXuuWW+pDcduUka19afnR4VOQD/Jlhtxruhj8V04ZI4GU14O3L3HywzNZYbS
 Lbuguxr9rWwM2H9Xy4LU8CRRNMPR3ngNmVQoN+cOi1V2w5KM9gQqFLIs4gF9uoVDksAi
 Npsy7rhhpEvSrfjNMdoNxcokvcWkFDqdtsPtnnzRRdY9wRHiCGfiwQFa9nHvnz190Sdk
 t3sr7aYRbh1Ttny93Lt3jzTYYj3nG99PjJWgbW11/HY4NhTNkv3RE5v4ibTPHiNEcqkq
 VG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631961; x=1768236761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZRbH3mFptp7GM4kVFS40Hw0p2MRIzB+9Tu+JTLG0ZM8=;
 b=NZeleXnga9S8aW10Er8Bm/tQRL9TBexnqjAjEgHIvX0PFAnoHXR0tfWkZSsJerku94
 c9KO8lg0LoZMApKrZr60m5tHMKdP62vc+9SiBR2VeRjYunHjp0ARiDs0MBtrjfgYRsNR
 L0Tx7+/VVFdqKkAGjbwnDa09T+/oNesQzFMATTMztjtkyZtFsGGRto6Q0WDpKuBmxbjO
 U4Dq5I9oCUZHSVOoZDR8+EQdtC97qEM1t/S2kHhztVQn1vSF+7UUywoQMMxebHwXdmpw
 qblNQvytBjmGgRRVa0vGCi2SfAoEQ9y+UxYgjdO/F1F4vhf/FwME5fACUrLAG4iS3Nr2
 ANAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUldkuBZnliIG15ugYg6nPRRJFMkbpnJjSgfUDrAgDszroWSF6Rq3SAVdWPKbKF4Xo4EHgFwY=@lists.denx.de
X-Gm-Message-State: AOJu0Yws487q86Q37sfIumE7LOtmfv1k9NouuJDDoFIVvsi/vNJTf6u4
 qAuyP+yYPnZ9FuzMDZWd0SenZy8mzvP4WBiGuBddsb3i/TmonFSUf2ID
X-Gm-Gg: AY/fxX4JbtEgqyPVros7pAt9Et8/8Kvib3PrsqIoxndyd5Se5UOG7PVUU+gMD8L7RL6
 13hA5TvUTwRieXG5rOZsEJTiqLPfvsdrZQju//8IIhlKBVLkrRwnMN0yZ7L82IU/qel1psIKjvq
 vRuyx4olhl351Ote5M0MfaYzpFzA2HCbZKOpaaH4sT7DGD2iNyw8NKF0sdaSI5m3EA0oNG9azD9
 hdc8LnPyPhNQ09PZQxPH1UEUw5Z/1vqfcH1JZB2O+8QO2ifbHspb+uMdQs6r8NL5OvO1swi9sV2
 R37QRcrVM3TlzomPY4fCkDeGdE4xoOyXzwtacGIuMYCDtWLLCImxIU0EC7imVR2MQIAVkgEjLid
 O4DIg8878/v67mVkNYyEsa7Vjo+rNEFyyaQc8z1qzN8A5TueQOYDuNt79VG9mD1UHG2W0ntt5Lu
 YkRbbt6SXzcuuiu7kzBUpF8g4GSbv8BXUlyh+yzcs1XAh1sy54vTHrJhmedBswLAbWbf+v/sEpl
 d4LVVn148Ar1zAD+bZLfA==
X-Google-Smtp-Source: AGHT+IGV8KRU9WQvN3NzlxX9/5vfZFTPlTfq8nyacefWAIkttZRF3Rt6pgdtm5vrF7Rp90kM1k9HVg==
X-Received: by 2002:a17:903:2342:b0:298:3aa6:c03d with SMTP id
 d9443c01a7336-2a3e2e26937mr2623845ad.57.1767631961188; 
 Mon, 05 Jan 2026 08:52:41 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:52:40 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 1/7] serial: Add Goldfish TTY driver
Date: Mon,  5 Jan 2026 16:52:15 +0000
Message-ID: <20260105165221.1816070-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260105165221.1816070-1-visitorckw@gmail.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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
---
Changes in v5:
- Rebase on u-boot/next branch.

 MAINTAINERS                      |   6 ++
 drivers/serial/Kconfig           |   8 +++
 drivers/serial/Makefile          |   1 +
 drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
 include/goldfish_tty.h           |  18 +++++
 5 files changed, 142 insertions(+)
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

