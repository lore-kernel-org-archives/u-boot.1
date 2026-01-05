Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61FC79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F8983E9F;
	Mon,  5 Jan 2026 19:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M89VCpD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBCD83DEE; Mon,  5 Jan 2026 17:52:48 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C18983DEE
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0fe77d141so1161105ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631964; x=1768236764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXTiv3RisK6diasNktOewKMh4DbdRaQjTMk0YXAJSrA=;
 b=M89VCpD7u0Bcno8hEGnBgLSrxoVoUxl54dm40ZivRf5vdRutCoRosgYKstN6M1oeJg
 z6pGCdx9wXArIimS4PkMCd0M9WAnAMGSUCy4bsA5GwXuJAyfGna9KsyfsE2sY4OEK2KH
 BDyz8u5fkUbNDKcfW57M2oy1c1BqfpEOg2M23mi6hoe/6THRRolwgdACUobgD6O/3gw+
 RyRak8t91qPBcXtl0/KSTgLTbObc0MV1syWpzN9kTmOUczqMiky5BOAk/QIz7OcCqrks
 ICCj/TohDPqQWAvvrKMCmCuSF4A7iOD8JSn1/RcJ+80T88DIxsAfrVn0xvbZymyR5Waf
 8c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631964; x=1768236764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXTiv3RisK6diasNktOewKMh4DbdRaQjTMk0YXAJSrA=;
 b=sITNA+9ekvfBnHH+GJfc93M1Gj6oKONvE0pA7QDZF2TfdtOUodfwja1Z5P5EB1LCmo
 MGd1j7JPJc1w+mZYPizDTimTJrJVgIilWf1yXJOK23oXQWjaMlgaW7pez1dPVZzN6+aA
 N5n60Dh+1rutojbTIhzZ4zZvyRkzC2hDO1JNwFRmbpy9vrm7+9mvNjtHmoq3ifbBGhpl
 xk1aG+vhet1tDMOET8CWSmhjw1XtmSGmWNFmVT77uAQ+jGy136Yx/2Jfxqd5otqBWVVT
 oEbR9UtET0xSxS51SC1RUJVQcgikcMV37qvrAdWL+OCSU+Pi7SkYw/SNvbNsxfV8bD7D
 Ue6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt5/m/wlANiLf9bXfPOAn1KowAQg59a8xpVCJxXKE9BvO5lLUB9oIwhcSOzZEVqpFekecfyCg=@lists.denx.de
X-Gm-Message-State: AOJu0YynYXIaz+yVR4Pig1Ycpvcj2F5j+W5a4xmfujr3gI2MH3y+PW55
 zyMcLvSRfD9uobgKVk/iEVS88tOCZqJ8UD1oTvrmDC5kpAlJO6g+HxNU
X-Gm-Gg: AY/fxX65lSmC+RDww9gckL6GFEKQmMRNDMoeT/p2dsvyt5eKt4T0Uu7dKCH4POI3Og1
 opGxB2BE1/dG4ZrdXkBOzMSr84Rftja1kU8gAhTvmT3qe5xpzx9nqb2/ty+iYaU97bQIrh6pnb+
 ppnSOKFPhCh8wUmuOD1KwRYVQETlpgBZealWk6RsO75Mshvw8WTtxszJSkOfDfxGNf5KzlL1Arf
 KQSRDvFAeB6Ok+LL5mrTbwaR3e7lXpdh7PDsye2khs8TpYSVG2vQ9uacSLMZeTFblqyGbUvevst
 pnYfJwiJpukTTp4sJ40UXWKM5Q4VbptoJnEFNggfK7HbCOInTA60BiFiTsA+sUtB2ZMy+0REla4
 6s2rFTqLU4Y/apzYRw9g9frkUhy4kEdzBuJak6bferJkcLNgsrzXKdRXARSYkuTS9NzH2J64Zg/
 qDakwVTOHOcE1rY2KGP5wjrmx6NxL3cNZmXMrwrFdhiBuJ5EtBT1FMvgg/YbIXGWWO1tl/eAzRP
 WHjhIsCvfD8M/kKmVwR0w==
X-Google-Smtp-Source: AGHT+IGyizd9ByOOqmyz15fjYHQg1PyyZGbrKCrYk4HmX3IBagUFvu+4VKMHQOoRIgrkkGNfQW1oMA==
X-Received: by 2002:a17:902:ce91:b0:2a0:bb3b:4193 with SMTP id
 d9443c01a7336-2a3e2d07e29mr3184205ad.40.1767631964514; 
 Mon, 05 Jan 2026 08:52:44 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:52:44 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 2/7] timer: Add Goldfish timer driver
Date: Mon,  5 Jan 2026 16:52:16 +0000
Message-ID: <20260105165221.1816070-3-visitorckw@gmail.com>
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
Changes in v5:
- Rebase on u-boot/next branch.

 MAINTAINERS                    |  6 +++
 drivers/timer/Kconfig          |  8 ++++
 drivers/timer/Makefile         |  1 +
 drivers/timer/goldfish_timer.c | 81 ++++++++++++++++++++++++++++++++++
 include/goldfish_timer.h       | 13 ++++++
 5 files changed, 109 insertions(+)
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

