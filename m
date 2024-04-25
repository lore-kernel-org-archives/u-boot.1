Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE2C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 00:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF3A88726;
	Thu, 25 Apr 2024 02:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="EkR63qBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC6D8869A; Thu, 25 Apr 2024 02:06:13 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B1488727
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 02:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-61b2218ab6fso3507097b3.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 17:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714003566; x=1714608366;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCBw9PnZLVxhHkoKN86oaCaM8A0bBbBL/S8tJb0CQmU=;
 b=EkR63qBN5o20CuJ/rfG6kOIfPym1IDA+raedJE8cDQqx/hUPLXCRR5G2yiWKy9KG/V
 39+swdlZwyfT75TGysYrKzz82e9IMMVA75Ibdr5OzsUV696pDmMm1QL8JjlcZ6rRq/oD
 8cd7x5o33UHqhDfhxZ+Yu1EBKAOfInRWRR/TMfpWrMIQvKSg87RjkWyEMqZq6ehARzWM
 VOByTuIZ5zCwR79OZ3Zm+YL8VvPxpI3ACz8QexopmTM19T14FtYW8uXSrEUOS8wxor6o
 Kbgysg6GmpdrW5lR57oNk+Uqjh9iZbQypdQm0Je8O1oW6wgKITZEz3Au63V6y09e6Vgf
 zQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003566; x=1714608366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCBw9PnZLVxhHkoKN86oaCaM8A0bBbBL/S8tJb0CQmU=;
 b=oRXbiDIqGm2Gr8HnMiSHQlkcwNInwfOHWSJj3HM1hEquBntG+b/SGY8ZQ8DbB8Frpn
 gM7+6GpVzeyl6PU6jp0TcxxX9iq+J2JdBiFaw/DAQT5ZLcYoZrFl6fR9vi4N37uA4yon
 lJ0Kubx/zXuJDU47cVn/FIRoQhsCozUvkTGZgYZxSchXZh9TkJfF11WClAYiykgBNYNV
 2qJ0GYrcnpuKQ3OunEAMvW+HZwYNuEAmwNUSjnmcf3BYbxHl45jBHt9eU5Qwzsw+GFCL
 aabO9dNZ6XUixnPBVY/xCzL/F2+S28Zx/0G8g3mueXkG1iTvFXJpQJeu6W2DAKdy56IF
 6p0A==
X-Gm-Message-State: AOJu0YyJWnfsoROZt7sfh/Qjf7bxOQjPOhr6xPf1lVVjonulOhI1+p5V
 hdXLiRze4my0sqL1KaB7+lY7sLlKC9d3AWwL8lOugHO67o5AEAdULFMHRMA6DQBCIm0KVJ8n2l7
 KoQ==
X-Google-Smtp-Source: AGHT+IG9YeytSVxc6aBA7qwYAKXlw6K1r+vfbsdarQuXdPkabUQwDCEd8WX4kDGG1DOq+pVohlkCnw==
X-Received: by 2002:a05:690c:6ac9:b0:615:39fb:ec with SMTP id
 ij9-20020a05690c6ac900b0061539fb00ecmr4186406ywb.50.1714003566146; 
 Wed, 24 Apr 2024 17:06:06 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 t201-20020a8183d2000000b0061870c6e41csm3291753ywf.6.2024.04.24.17.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:06:05 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/4] drivers: serial: Add in UART for ADI SC5XX-family
 processors
Date: Wed, 24 Apr 2024 20:04:02 -0400
Message-ID: <20240425000515.21896-4-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
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

(no changes since v1)

 MAINTAINERS                       |   1 +
 drivers/serial/Makefile           |   1 +
 drivers/serial/serial_adi_uart4.c | 225 ++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/serial/serial_adi_uart4.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 78e3d59f96..74310c8f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/serial/serial_adi_uart4.c
 F:	include/env/adi/
 
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
index 0000000000..45f8315d0a
--- /dev/null
+++ b/drivers/serial/serial_adi_uart4.c
@@ -0,0 +1,225 @@
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
+#include <clk.h>
+#include <dm.h>
+#include <serial.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
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
+		dev_err(dev, "Could not get UART base clock\n");
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

