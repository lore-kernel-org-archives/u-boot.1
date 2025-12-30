Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63094EE498F
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B3583F95;
	Tue, 30 Dec 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Baow7uUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD3B83F70; Tue, 30 Dec 2025 17:01:39 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF8083F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7f1243792f2so6746153b3a.1
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110495; x=1767715295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k05dlRgwx4NWz/cN62LjJevS5zuxD5l8gaNrOk7T5XI=;
 b=Baow7uUuOZ67reeyx7t0DCX+6oqu/xzOxG4w9KR00zwSrrtmA/AFbeGYQDD2aWzWYL
 Sb6A/i8aJWgEUOSaGSgNAVSsa/y6qGa/3XHQqKGy9NBCIJz7e6CvhrVNuNoZCUTd+sjk
 p2mcCBoP86LQqQ3wpL8iTDporw+kcxLEUcFxHmykpSNPwrH5M0+Owv5O09qcb5GFVhba
 GyUY7WclC3yzJE2ec02zt808rsdhsdaXiPl0nJp1x0l3OXcriGDBpLQ7F0OIK0VK9pU0
 vA9q0Doc1HSTh5aaxEOWKteFUS6bvOuQUBvEGDQPQeJeH8/hs4rUMWFj72j1sBmiqzY0
 kihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110495; x=1767715295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k05dlRgwx4NWz/cN62LjJevS5zuxD5l8gaNrOk7T5XI=;
 b=dgFGQxJll81Lq2EPR9YbgF+nQVcFZ4Aa+z8l6mFr60PuYehhs0WLD+jxj1DBB9aCQI
 ZKAEAfuQtEVUCNwnU7L3vGMl550q8SXfRlLgFYnBu2T7zKtpSpWWKoUjvSSQOHss6QA3
 c55BQeaGyi6gfX4ivzOYGmW4g81E6p8ZdMdYeA5dJrPX/+SLm9B95P2/IlP+LcF5VYoz
 6DUxycmMfRQcWCQR5sHrOoaaCJTLZr0SKEmo41EVz7o7sI4eccmbSUOhQCDccfy2vgFA
 JJ95WqGi95rx8RP/b/Ih9jPTWNmWiul+qV31lXXJaAZQDzMy3rKbtreE36DqVEYPqQK0
 oABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNwPS7CglNBPGy5ftVAkjTicE5Jb/WTD3S/q/AjXnSGubnq1z18gXH4yKfHNuqiRzyZ4NnASw=@lists.denx.de
X-Gm-Message-State: AOJu0YyrN+6RvSXkBOaF9ijfUsRaletUd2zsv3RDS8c20F5O+oLn8o8p
 9Y8kb0rX/8D/EIjAcyr32gV4DhpUxgMG/f5nMkfyp8mRIdfyA24GcnMx
X-Gm-Gg: AY/fxX7CHg5jbKJhrDNe2SFHz9BvYXH33qWthJYuxQr80a2zi9/qlSCNgB95auRNvrC
 sh40iBJSG4RuStr3fMNK6pBwUbwVtsriYbw6H7iM6477v3aMcEJz4+wyZrobskZKWTGzgJyQ/d8
 EZ36K40lprvWBb9O2BOBeurmXJiXxI0iBdm4xfDLm35HGJK/NWgUMWb4eOKIzO+AnS9MEBTf3SN
 N1RQirSH7z3jl1A0YerFb09NnWk9Gp3ymR/6GSXh0Te00RJ9oud9XZqU4UaKlY3Q3VqhmEcL4yp
 KfYt/mODIAgLIHHWlor/FXgVGjTc1ed4o+PCKjsN74ZojxbkdMX7mxISD/Shwzau2GgEZuHypR3
 WQWSR/ZeFh3llVyw2+P+seZzCOe7VtYwVaShLcx7K4wlfKkZe7GOK+9fYD+XoKpmJ+Etap6f3I3
 bCjZGsWj0LeNZMICU5J9yTJ38E9+do26MjkT2dkQCB+484Oh+UeowWf2bYrrA2TIcZB9PE6lIP+
 NoDb5Y9RdQL9EMmz384RA==
X-Google-Smtp-Source: AGHT+IHRnK9v6akXT6uvb9HOi1VO7TqVlGUPqJKu3QaUzGtzKH5AvqWzBG4DSJHtE2OwRN2Bdk9DAQ==
X-Received: by 2002:a05:6a21:3290:b0:35e:3d4b:4cfe with SMTP id
 adf61e73a8af0-376a94c773bmr28308143637.39.1767110494789; 
 Tue, 30 Dec 2025 08:01:34 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:34 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 2/6] timer: Add Goldfish timer driver
Date: Tue, 30 Dec 2025 16:01:08 +0000
Message-ID: <20251230160112.3045527-3-visitorckw@gmail.com>
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

Add support for the Goldfish timer driver. This driver utilizes the
Goldfish RTC hardware to provide a nanosecond-resolution timer. This
virtual device is commonly found in QEMU virtual machines (such as the
m68k virt machine) and Android emulators.

The driver implements the standard U-Boot timer UCLASS interface,
exposing a 64-bit monotonically increasing counter with a 1GHz clock
rate derived from the RTC registers.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- New patch.

The link provided by Daniel [1] returned a 404 error.
Since the implementation is straightforward, I wrote this driver from
scratch.

[1]: https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c

 MAINTAINERS                    |  6 ++++
 drivers/timer/Kconfig          |  8 +++++
 drivers/timer/Makefile         |  1 +
 drivers/timer/goldfish_timer.c | 60 ++++++++++++++++++++++++++++++++++
 include/goldfish_timer.h       | 13 ++++++++
 5 files changed, 88 insertions(+)
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
index 00000000000..8205ac77853
--- /dev/null
+++ b/drivers/timer/goldfish_timer.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * Goldfish Timer driver
+ */
+
+#include <dm.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+#include <goldfish_timer.h>
+
+/* Goldfish RTC registers used as Timer */
+#define TIMER_TIME_LOW	0x00
+#define TIMER_TIME_HIGH	0x04
+
+static u64 goldfish_timer_get_count(struct udevice *dev)
+{
+	struct goldfish_timer_plat *plat = dev_get_plat(dev);
+	u32 low, high;
+	u64 time;
+
+	/*
+	 * Goldfish RTC provides time in nanoseconds.
+	 * We read the high 32-bits and low 32-bits to construct the 64-bit value.
+	 */
+	low = readl(plat->base + TIMER_TIME_LOW);
+	high = readl(plat->base + TIMER_TIME_HIGH);
+
+	time = ((u64)high << 32) | low;
+
+	return time;
+}
+
+static int goldfish_timer_probe(struct udevice *dev)
+{
+	struct goldfish_timer_plat *plat = dev_get_plat(dev);
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (!plat || !plat->base)
+		return -EINVAL;
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
+U_BOOT_DRIVER(goldfish_timer) = {
+	.name	= "goldfish_timer",
+	.id	= UCLASS_TIMER,
+	.ops	= &goldfish_timer_ops,
+	.probe	= goldfish_timer_probe,
+	.plat_auto = sizeof(struct goldfish_timer_plat),
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

