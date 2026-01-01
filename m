Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41252EEE25C
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA5083B03;
	Thu,  1 Jan 2026 22:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYwgnpp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD9283C4B; Thu,  1 Jan 2026 18:54:45 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE2383BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso104078815ad.3
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290082; x=1767894882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e5K28yBZTz+4WWHhjGMG45JPH6B8Il+ULpnpllEBp4=;
 b=LYwgnpp+yeTuzOnpUP1SANVTLNAQvS1yDuCwkef+Vxsz0E5PjzNX5qxEa6vMKU0uMK
 J1N2Zou2sOlq1X2sPfkFn8HtkSSIoy94N70AkhrimioDZ5TN/GIHgP7vVY/mw15S8pSG
 fS4xCTlY9TURPmKQPGVn5pACAwPs0pFfTKSQs0cI4ta0KNDa5wgjt7MUOojoNGAyt4iW
 i03Zdh55c1wmiWL9URmSF72fMnnbJAlO/I4G9rAri9WPg0a/rPQPJuOEj71/S3V7yEu3
 GwezBcjGhht68Oa4TLP/UoEn9Nap1xvgMTOkp2r1eMfKTufBBoEmeJ7mA6l1dzAN69Bq
 eJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290082; x=1767894882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0e5K28yBZTz+4WWHhjGMG45JPH6B8Il+ULpnpllEBp4=;
 b=swKCWn3kxylTIwUNoiGzYLssU/rwEe6a1tmhBAUvazfP0zExSh/GZBHeqZHccwiNzT
 jeq6MSLZcdIfFyrmFOL+6vm7yGuX+fTga9IoBpzQ8qlsRW/XhFe1YB7zHWnNZUn05QfX
 nQAkE/MGs/w2EvOpnCmK+7vOXnDjwax5NJ5oKc25Xih6a4YAP50pVU11fIMYOYXiXm/P
 yhtycrmZHjckZkCQdPOk7vmtdTgVBVBL3A7mByCXmDF5jzQYIugNIxelIOvZ9zomkBOq
 i07yqbhN37LJFmJ7G2N1PV64h9ey9zacMtECB2tAdik2D0UPABZzqrl4oNcTQA21Nz1u
 KNfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ncX6cQZiUFMYEE8ybGoAmDfpkUAelMi6wG9S3aGO7HWQXFOfqxkRMs/Q4ADdiNZDIUr5VEI=@lists.denx.de
X-Gm-Message-State: AOJu0YwHrZeFazValGe34t0nm4ePQFeOwtPuLznhA8/3LGC8T6TZIbGU
 DQpxQMnaEtBwGOeQfwklgPD9cq06OTdTD8QSEfB6ieBuCMWnMRawRHUL
X-Gm-Gg: AY/fxX4fIbgrt1WQ8j/d7YM3bcJZDPvwlqW5/UoAe9cb7z7stYuXEhl27v1O3kdPn8n
 IkOwPJlV8FzUex6KEv/wB+185bmedqZ35DHibmYxiO38FKUUCVzb6kZnkqBIFAQYxWXKhF87Ze+
 d3BAPJS65F2XaF/6YRmDUikGOuZnZ9An2f/NFo38QGwLYah8oG2iB5YZ7EkcPK+KJwH8MIqEboG
 A3yWbV/6IqOCgOvygLHG2UPpGigdqmbjM7p3M/iuohJjxl+vjXDxJVK/TWy0Kk3YYuzzLA1gC7q
 +NZ7GL8iZnx4k3ONIz6DGXoBUfNWHtx2BxgccroRlTMVmMyzu6gcHwGDjjW+MbXYoFpfRZ+g919
 NVL0H5rVpIDjnYo9KguX1vB4VzR+bE2iWmefDvpA8nYbBOAgPiNkMSiIHaB2i2tPeUONtUiFw/9
 yuXFlzwzhYybvmFcxoXAGMNmRb0CQNpfmY4agLSOHNYrAbfyiZ4mPPz17MDLJusBkmFwKVHn23A
 S38rNicevmB+BUgmroUXg==
X-Google-Smtp-Source: AGHT+IFdlM+Mco8YMTHzfSNYAvVnana4lyfyWZppTC8i5sHhrawUfKSD2xlOjytw+noV9TJIh2l17g==
X-Received: by 2002:a17:902:e846:b0:246:7a43:3f66 with SMTP id
 d9443c01a7336-2a2f220d878mr428416665ad.7.1767290081939; 
 Thu, 01 Jan 2026 09:54:41 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:41 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 2/6] timer: Add Goldfish timer driver
Date: Thu,  1 Jan 2026 17:54:16 +0000
Message-ID: <20260101175420.4118024-3-visitorckw@gmail.com>
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
---
Changes in v4:
- Sort headers alphabetically.
- Add comment explaining read latching behavior.
- Support DT probing with platform data as a fallback.

 MAINTAINERS                    |  6 +++
 drivers/timer/Kconfig          |  8 ++++
 drivers/timer/Makefile         |  1 +
 drivers/timer/goldfish_timer.c | 81 ++++++++++++++++++++++++++++++++++
 include/goldfish_timer.h       | 13 ++++++
 5 files changed, 109 insertions(+)
 create mode 100644 drivers/timer/goldfish_timer.c
 create mode 100644 include/goldfish_timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da4a6e4d518..fcc437a53ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1265,6 +1265,12 @@ S:	Maintained
 F:	drivers/serial/serial_goldfish.c
 F:	include/goldfish_tty.h
 
+GOLDFISH TIMER DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/timer/goldfish_timer.c
+F:	include/goldfish_timer.h
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
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
index 00000000000..63946b9ed97
--- /dev/null
+++ b/drivers/timer/goldfish_timer.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * Goldfish Timer driver
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <goldfish_timer.h>
+#include <linux/errno.h>
+#include <mapmem.h>
+#include <timer.h>
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
+static int goldfish_timer_probe(struct udevice *dev)
+{
+	struct goldfish_timer_priv *priv = dev_get_priv(dev);
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct goldfish_timer_plat *plat;
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr != FDT_ADDR_T_NONE) {
+		priv->base = map_sysmem(addr, 0x20);
+	} else {
+		plat = dev_get_plat(dev);
+		if (!plat)
+			return -EINVAL;
+		priv->base = plat->base;
+	}
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
+	.ops	= &goldfish_timer_ops,
+	.probe	= goldfish_timer_probe,
+	.priv_auto = sizeof(struct goldfish_timer_priv),
+};
diff --git a/include/goldfish_timer.h b/include/goldfish_timer.h
new file mode 100644
index 00000000000..2ea28170759
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
+	void __iomem *base;
+};
+
+#endif /* _GOLDFISH_TIMER_H_ */
-- 
2.52.0.358.g0dd7633a29-goog

