Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F3D0D16C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01132840CB;
	Wed,  7 Jan 2026 21:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RaPh4VyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B171483A1E; Wed,  7 Jan 2026 21:19:11 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017BA84082
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so1636343a12.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817147; x=1768421947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VwTZ6Snli322SFpGgz2hFjKWAyeaAIF0ayvaSDD8qo=;
 b=RaPh4VyKoURa/zAAz2a2ZshTBDodvKe22zqlIxRg4EIJyjpDJLwWD2vmfl5pKQdcMI
 yCzlJpwfhO7CtHKFIhMXNxnnybDrG6lxPkqvyc2fsqSlb8Mr8OOy7bct8vwPAKasigCt
 QeYLk2zGp3Nqq8fQV7GBp0cnvWaOnD9to1RG+N4i+i8K8U9Y7nCk5KNImOs3BND12toP
 0vtN8C0XvIQQBAU3EFPQY9l8Ca6/GJwjZbmNIS8ZgwUmHbY5YywEisQzAQ0xRhUtRBdH
 kdxQntclyZgunoFWHj7HTjak58aH8zDAtNTtIqvE+mu103hdtcuoNPisPvUMVXJ0mhsZ
 huxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817147; x=1768421947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4VwTZ6Snli322SFpGgz2hFjKWAyeaAIF0ayvaSDD8qo=;
 b=cH6m3W4OTB0OATUtYoQteG13nug/GMBWeEbZYAV1+dj44lTjCbkto9KlmYpm3Jwz8z
 l7PdYljR6Nn89dlUwZhT7/3sVMDNIKMPoyDN7Yi9Dh8iRvz4EbTJYQPtP9jj35oqfxj3
 gOWGJe8qVlHFxtLRlKLXl3fYDl6Fhfc5XfYcDxLLNv0GsXYa+jC8aAySPiADic9PD8s8
 8vwPDQBO1Cg2n8Gmg5i/ZxxoMvpHAVTByaBIQL4pEl1wE88TyEtAcyEixj6XFt/OWfzC
 J2qWtgmeB/n/fpOYczgqJyz/xwvfUU22qRa5vakQftd64ARr4vxk3pcHfMS+DklQP99X
 V6DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhspWS7jsAu8lgnFL6vBjxO8c8SZnkaLeeqYcZz5n+GpnjF3I6J6bDmaEDJbOodnj/tO7Q3pg=@lists.denx.de
X-Gm-Message-State: AOJu0YwaOFQUa2H0xRiwfESSWFKGCYB6oCjO9KG0OYq8rapZEJDIN/h0
 dsIMeOkDiT9dvp0ibZzccBXP8md3Wjq5fheBW43wqCR6lSklKxzjGVWR4ntRyQ==
X-Gm-Gg: AY/fxX5e/xqvQkupu8bWyQyoYbW8EbKe30sBYOwQpasJ3W+G6iXXOyJr5MAAOvE3ohs
 VTNAQV+Xex5aj8TS4TOEXQa/VFen5dwWdzSElpicg9Q6UlFEQ6HWgfgFPFUdzCbtdwbKqLZddy4
 xRf104jQpTlvwq59M93z5qrfBZm/S+r3IFxJqnPol3DMSi8HdwDtfJ2lnk/oK3tzYAqZ5m2n4ol
 1iKaTvtgbitQrpglkVnKTNqCbotIHMOXMVTqlcCPSVsrjANF+jBLBVg24fVKNjqdvjYvA7dFg6/
 njkyDaS8u5lU5UOwoK+oSmzmJcGLZeQfWnv93QU76Bw6RofQ3dygJtagjPGCkWEZzM5g9wULbVy
 8e6KTPpfOt4bsW1eApEWaAkt/X/0SG21C4PivmpMNFP8AST2yR3g1aC8bMWgQbqEMFX0n2G4hr0
 C3u8JBoVSIWcexDwLrfTxRobMzb9kxwBZpKCGrnV8Euhfp3eX/t7KghltnBRtWozahBH2HBxfhc
 OiK73AsYsARJ5bWnexU9Q==
X-Google-Smtp-Source: AGHT+IE7UDOMmHKjRtj5NjHJ6ybOI6nGxPzbPl05RcDUA+0DtImYGoR39WqOn5826DPLlDtEguJWYQ==
X-Received: by 2002:a17:90b:2711:b0:34f:62e7:4cfd with SMTP id
 98e67ed59e1d1-34f68cbe5e1mr2841638a91.24.1767817147422; 
 Wed, 07 Jan 2026 12:19:07 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:07 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v6 2/8] timer: Add Goldfish timer driver
Date: Wed,  7 Jan 2026 20:18:31 +0000
Message-ID: <20260107201838.3448806-3-visitorckw@gmail.com>
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

Add support for the Goldfish timer driver. This driver utilizes the
Goldfish RTC hardware to provide a nanosecond-resolution timer. This
virtual device is commonly found in QEMU virtual machines (such as the
m68k virt machine) and Android emulators.

The driver implements the standard U-Boot timer UCLASS interface,
exposing a 64-bit monotonically increasing counter with a 1GHz clock
rate derived from the RTC registers.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes in v6:
- Refactor driver to separate device tree reading into .of_to_plat.
- Rename platform data member from 'base' to 'reg' (phys_addr_t).
- Update header includes to follow U-Boot coding style.

 MAINTAINERS                    |  6 +++
 drivers/timer/Kconfig          |  8 +++
 drivers/timer/Makefile         |  1 +
 drivers/timer/goldfish_timer.c | 89 ++++++++++++++++++++++++++++++++++
 include/goldfish_timer.h       | 13 +++++
 5 files changed, 117 insertions(+)
 create mode 100644 drivers/timer/goldfish_timer.c
 create mode 100644 include/goldfish_timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f884ff495a..efecb213be7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1266,6 +1266,12 @@ S:	Maintained
 F:	drivers/serial/serial_goldfish.c
 F:	include/goldfish_tty.h
 
+GOLDFISH TIMER DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/timer/goldfish_timer.c
+F:	include/goldfish_timer.h
+
 INTERCONNECT:
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index f9511503b02..a84a0dc0539 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -340,4 +340,12 @@ config STARFIVE_TIMER
 	  Select this to enable support for the timer found on
 	  Starfive SoC.
 
+config GOLDFISH_TIMER
+	bool "Goldfish Timer support"
+	depends on TIMER
+	help
+	  Select this to enable support for the Goldfish Timer.
+	  It uses the Goldfish RTC hardware to provide a nanosecond-resolution
+	  timer, commonly found in QEMU virt machines.
+
 endmenu
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index a72e411fb2f..d8b3f2b65d4 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_MCHP_PIT64B_TIMER)	+= mchp-pit64b-timer.o
 obj-$(CONFIG_IMX_GPT_TIMER)	+= imx-gpt-timer.o
 obj-$(CONFIG_XILINX_TIMER)	+= xilinx-timer.o
 obj-$(CONFIG_STARFIVE_TIMER)	+= starfive-timer.o
+obj-$(CONFIG_GOLDFISH_TIMER)	+= goldfish_timer.o
diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
new file mode 100644
index 00000000000..70673bbd93c
--- /dev/null
+++ b/drivers/timer/goldfish_timer.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * Goldfish Timer driver
+ */
+
+#include <dm.h>
+#include <goldfish_timer.h>
+#include <mapmem.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+
+struct goldfish_timer_priv {
+	void __iomem *base;
+};
+
+/* Goldfish RTC registers used as Timer */
+#define TIMER_TIME_LOW	0x00
+#define TIMER_TIME_HIGH	0x04
+
+static u64 goldfish_timer_get_count(struct udevice *dev)
+{
+	struct goldfish_timer_priv *priv = dev_get_priv(dev);
+	u32 low, high;
+	u64 time;
+
+	/*
+	 * TIMER_TIME_HIGH is only updated when TIMER_TIME_LOW is read.
+	 * We must read LOW before HIGH to latch the high 32-bit value
+	 * and ensure a consistent 64-bit timestamp.
+	 */
+	low = readl(priv->base + TIMER_TIME_LOW);
+	high = readl(priv->base + TIMER_TIME_HIGH);
+
+	time = ((u64)high << 32) | low;
+
+	return time;
+}
+
+static int goldfish_timer_of_to_plat(struct udevice *dev)
+{
+	struct goldfish_timer_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr != FDT_ADDR_T_NONE)
+		plat->reg = addr;
+
+	return 0;
+}
+
+static int goldfish_timer_probe(struct udevice *dev)
+{
+	struct goldfish_timer_plat *plat = dev_get_plat(dev);
+	struct goldfish_timer_priv *priv = dev_get_priv(dev);
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (!plat->reg)
+		return -EINVAL;
+
+	priv->base = map_sysmem(plat->reg, 0x20);
+
+	/* Goldfish RTC counts in nanoseconds, so the rate is 1GHz */
+	uc_priv->clock_rate = 1000000000;
+
+	return 0;
+}
+
+static const struct timer_ops goldfish_timer_ops = {
+	.get_count = goldfish_timer_get_count,
+};
+
+static const struct udevice_id goldfish_timer_ids[] = {
+	{ .compatible = "google,goldfish-rtc" },
+	{ }
+};
+
+U_BOOT_DRIVER(goldfish_timer) = {
+	.name	= "goldfish_timer",
+	.id	= UCLASS_TIMER,
+	.of_match = goldfish_timer_ids,
+	.of_to_plat = goldfish_timer_of_to_plat,
+	.plat_auto  = sizeof(struct goldfish_timer_plat),
+	.ops	= &goldfish_timer_ops,
+	.probe	= goldfish_timer_probe,
+	.priv_auto = sizeof(struct goldfish_timer_priv),
+};
diff --git a/include/goldfish_timer.h b/include/goldfish_timer.h
new file mode 100644
index 00000000000..acd3e460c5a
--- /dev/null
+++ b/include/goldfish_timer.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef _GOLDFISH_TIMER_H_
+#define _GOLDFISH_TIMER_H_
+
+struct goldfish_timer_plat {
+	phys_addr_t reg;
+};
+
+#endif /* _GOLDFISH_TIMER_H_ */
-- 
2.52.0.457.g6b5491de43-goog

