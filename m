Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C002C001CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DFB87EDF;
	Fri, 12 Apr 2024 01:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="tyNcSIgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AECF87D50; Fri, 12 Apr 2024 01:40:51 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B77C8821D
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-617e6c873f3so3506127b3.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712878846; x=1713483646;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tmjaI4dMrt1WGXODIcoGm2vbyuVVVDfhM1PZt3/LpY=;
 b=tyNcSIgGbWBWNvy68ZePHcIMYdGXUWCRVKQawqKvd9ruG3Fzn1/iUVXAlFDudCuek1
 mSEmQ4HGq6C77xaKBupMZKFYLLznI2/+g/tvXGVyGYl6oPXo4kjLIL1bOZYqS/a4Z9by
 bfl5MBJIAtGRnIesqQnUu8FpZPz+04bSSvTqm3+ASMzCvP+ZDcb72QAjC/qmt/+nrcuw
 YPgxsiNE6HHRWp0KyUqt2i1FccZbfWIfHOQnCmDPfCV7aBUhvO1zFiykDxWd6qdjOO6D
 V9ax4kHk3RRxDlVkAvdEX+2ulcPZlMGk65Zz6vifogwtuPe+dl4FtFOKeJDzuF1dFIds
 Aiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712878846; x=1713483646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tmjaI4dMrt1WGXODIcoGm2vbyuVVVDfhM1PZt3/LpY=;
 b=BH2pz5YbBtqdcA9hkjV34c7OEb8elj68yXlL4gXaqNZg8R2NQXpIFoLr4oUJucIrFw
 PfEKbCsU8f+lPxIB+vXMuqPHxMBBayVpUKz/rhc4VuYCRppCTS43kMz08+zu6PyyPbVv
 bT511NqsTW82+qgzn0SQrVo8gEv4QaSkKkVdqXbvDGN9OcKJ9oav+3qXsPM2uM/LPKve
 hHovcw7cBL0J1Bi1fxtJ0gy7smA2t9i3WysqYXQtfdVPafQf0BnZE298ar9SzYHmXW9M
 +kVXV0AkVXAGLF1l9eOuraIyuHG89qLk2srCQg1XjZgXkpmE4j5gXV6JvhsI6QWlwVBU
 /PHg==
X-Gm-Message-State: AOJu0Yy69BRf5T8jcZle4dr31q3t8IdpQ8rT47VOCTfkOFg+g3yTVXoB
 G179kSk4ovlx7oq6+Zt9YulwRQlqOMOcmrOvN3mXScqFISWtQ4nwijs78LQvDJkA430KMqZqkGQ
 pxA==
X-Google-Smtp-Source: AGHT+IFd6z0PjbqNJQYs6+ImL+XncEgT1h3bTMLiaWFH6GqqGGq5NZOI4oEzZSUlTM2qQsdawkaZ7A==
X-Received: by 2002:a05:690c:3804:b0:618:7f77:bd7c with SMTP id
 jx4-20020a05690c380400b006187f77bd7cmr317660ywb.3.1712878845859; 
 Thu, 11 Apr 2024 16:40:45 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a81ec13000000b00617b17f8572sm533855ywm.104.2024.04.11.16.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 16:40:45 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] drivers: serial: Add in UART for ADI SC5XX-family
 processors
Date: Thu, 11 Apr 2024 19:37:30 -0400
Message-ID: <20240411234021.14534-4-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411234021.14534-1-greg.malysa@timesys.com>
References: <20240411234021.14534-1-greg.malysa@timesys.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS                       |   1 +
 drivers/serial/Makefile           |   1 +
 drivers/serial/serial_adi_uart4.c | 228 ++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/serial/serial_adi_uart4.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a9f52a6c7e..b1f206bb05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/serial/serial_adi_uart4.c
 F:	include/configs/sc_adi_common.h
 
 ARM SNAPDRAGON
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 403ab1ded6..dbe598b740 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 ifndef CONFIG_SPL_BUILD
 obj-$(CONFIG_USB_TTY) += usbtty.o
 endif
+obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
diff --git a/drivers/serial/serial_adi_uart4.c b/drivers/serial/serial_adi_uart4.c
new file mode 100644
index 0000000000..b92ce3ddd1
--- /dev/null
+++ b/drivers/serial/serial_adi_uart4.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Converted to driver model by Nathan Barrett-Morrison
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <post.h>
+#include <watchdog.h>
+#include <serial.h>
+#include <asm/io.h>
+#include <linux/compiler.h>
+#include <linux/bitops.h>
+#include <clk.h>
+
+/*
+ * UART4 Masks
+ */
+
+/* UART_CONTROL */
+#define UEN			BIT(0)
+#define LOOP_ENA		BIT(1)
+#define UMOD			(3 << 4)
+#define UMOD_UART		(0 << 4)
+#define UMOD_MDB		BIT(4)
+#define UMOD_IRDA		BIT(4)
+#define WLS			(3 << 8)
+#define WLS_5			(0 << 8)
+#define WLS_6			BIT(8)
+#define WLS_7			(2 << 8)
+#define WLS_8			(3 << 8)
+#define STB			BIT(12)
+#define STBH			BIT(13)
+#define PEN			BIT(14)
+#define EPS			BIT(15)
+#define STP			BIT(16)
+#define FPE			BIT(17)
+#define FFE			BIT(18)
+#define SB			BIT(19)
+#define FCPOL			BIT(22)
+#define RPOLC			BIT(23)
+#define TPOLC			BIT(24)
+#define MRTS			BIT(25)
+#define XOFF			BIT(26)
+#define ARTS			BIT(27)
+#define ACTS			BIT(28)
+#define RFIT			BIT(29)
+#define RFRT			BIT(30)
+
+/* UART_STATUS */
+#define DR			BIT(0)
+#define OE			BIT(1)
+#define PE			BIT(2)
+#define FE			BIT(3)
+#define BI			BIT(4)
+#define THRE			BIT(5)
+#define TEMT			BIT(7)
+#define TFI			BIT(8)
+#define ASTKY			BIT(9)
+#define ADDR			BIT(10)
+#define RO			BIT(11)
+#define SCTS			BIT(12)
+#define CTS			BIT(16)
+#define RFCS			BIT(17)
+
+/* UART_EMASK */
+#define ERBFI			BIT(0)
+#define ETBEI			BIT(1)
+#define ELSI			BIT(2)
+#define EDSSI			BIT(3)
+#define EDTPTI			BIT(4)
+#define ETFI			BIT(5)
+#define ERFCI			BIT(6)
+#define EAWI			BIT(7)
+#define ERXS			BIT(8)
+#define ETXS			BIT(9)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct uart4_reg {
+	u32 revid;
+	u32 control;
+	u32 status;
+	u32 scr;
+	u32 clock;
+	u32 emask;
+	u32 emaskst;
+	u32 emaskcl;
+	u32 rbr;
+	u32 thr;
+	u32 taip;
+	u32 tsr;
+	u32 rsr;
+	u32 txdiv_cnt;
+	u32 rxdiv_cnt;
+};
+
+struct adi_uart4_platdata {
+	// Hardware registers
+	struct uart4_reg *regs;
+
+	// Enable divide-by-one baud rate setting
+	bool edbo;
+};
+
+static int adi_uart4_set_brg(struct udevice *dev, int baudrate)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	struct uart4_reg *regs = plat->regs;
+	u32 divisor, uart_base_clk_rate;
+	struct clk uart_base_clk;
+
+	if (clk_get_by_index(dev, 0, &uart_base_clk)) {
+		printf("%s: Could not get UART base clock\n", dev->name);
+		return -1;
+	}
+
+	uart_base_clk_rate = clk_get_rate(&uart_base_clk);
+
+	if (plat->edbo) {
+		u16 divisor16 = (uart_base_clk_rate + (baudrate / 2)) / baudrate;
+
+		divisor = divisor16 | BIT(31);
+	} else {
+		// Divisor is only 16 bits
+		divisor = 0x0000ffff & ((uart_base_clk_rate + (baudrate * 8)) / (baudrate * 16));
+	}
+
+	writel(divisor, &regs->clock);
+	return 0;
+}
+
+static int adi_uart4_pending(struct udevice *dev, bool input)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	struct uart4_reg *regs = plat->regs;
+
+	if (input)
+		return (readl(&regs->status) & DR) ? 1 : 0;
+	else
+		return (readl(&regs->status) & THRE) ? 0 : 1;
+}
+
+static int adi_uart4_getc(struct udevice *dev)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	struct uart4_reg *regs = plat->regs;
+	int uart_rbr_val;
+
+	if (!adi_uart4_pending(dev, true))
+		return -EAGAIN;
+
+	uart_rbr_val = readl(&regs->rbr);
+	writel(-1, &regs->status);
+
+	return uart_rbr_val;
+}
+
+static int adi_uart4_putc(struct udevice *dev, const char ch)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	struct uart4_reg *regs = plat->regs;
+
+	if (adi_uart4_pending(dev, false))
+		return -EAGAIN;
+
+	writel(ch, &regs->thr);
+	return 0;
+}
+
+static const struct dm_serial_ops adi_uart4_serial_ops = {
+	.setbrg = adi_uart4_set_brg,
+	.getc = adi_uart4_getc,
+	.putc = adi_uart4_putc,
+	.pending = adi_uart4_pending,
+};
+
+static int adi_uart4_of_to_plat(struct udevice *dev)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->regs = (struct uart4_reg *)addr;
+	plat->edbo = dev_read_bool(dev, "adi,enable-edbo");
+
+	return 0;
+}
+
+static int adi_uart4_probe(struct udevice *dev)
+{
+	struct adi_uart4_platdata *plat = dev_get_plat(dev);
+	struct uart4_reg *regs = plat->regs;
+
+	/* always enable UART to 8-bit mode */
+	writel(UEN | UMOD_UART | WLS_8, &regs->control);
+
+	writel(-1, &regs->status);
+
+	return 0;
+}
+
+static const struct udevice_id adi_uart4_serial_ids[] = {
+	{ .compatible = "adi,uart4" },
+	{ }
+};
+
+U_BOOT_DRIVER(serial_adi_uart4) = {
+	.name = "serial_adi_uart4",
+	.id = UCLASS_SERIAL,
+	.of_match = adi_uart4_serial_ids,
+	.of_to_plat = adi_uart4_of_to_plat,
+	.plat_auto = sizeof(struct adi_uart4_platdata),
+	.probe = adi_uart4_probe,
+	.ops = &adi_uart4_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.2

