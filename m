Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B64C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642A887922;
	Thu, 14 Dec 2023 15:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="VlDwxxUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AD68781C; Thu, 14 Dec 2023 15:09:48 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D092887A40
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zong.li@sifive.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so6897988a12.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702562984; x=1703167784; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nujxWMa3ITkmrzkdYaPiObsT12GVY/e0KwkxJA4F+P8=;
 b=VlDwxxUzTJYXk8fHvjolGBMolVzdLDwqz5IO8sa4CpVP4fzypV2wsCiBl6iy2JHSPz
 zzTlK0Krrgq1RA54/F74DOrelFX2iW48k2dSq/m+WOzF9WqtrnOZFkmfoH+nqJTknEfX
 sPt2R70e57vmqq2Ti1OYW3aL3mRFeSFtE/M5pmX2knxpxwrUpmtRFjuw5X/MVFqxQ1+p
 pbZqnUrJksI2yE40iXGx/WJ9zPT8ELZGWF7uWKcPNqUlZt7ZoK40cyMaZESzcMNTc0Yc
 Okt5+thcHnJQBnjgbOA4r+lwGrp/wzS4582bzRsV7z+bUtGKlGJmix67j54sRA1ODmQf
 ZTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702562984; x=1703167784;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nujxWMa3ITkmrzkdYaPiObsT12GVY/e0KwkxJA4F+P8=;
 b=LgVgK45/fl0sDjxIm4EEqo70wJ/JeEPbEBMDK0zWWyqwxN5dgHEyi5usNN8CSGGJYs
 W3lm1Cc9+F3284o2h52YFmibFvpzho+xuUI+lS5YfZaThSBvT8P9eCLFsRwjK94GYE1W
 cme2k+Xd8v4lJq9jrLlkM3+w0skvx0iYf5FTN68+gOBqdzvF131QsnNaBSUvm5sF/Cbn
 gottd9+dU8ms1kkrfssO2bk7u+xhZYh0aoe9nNjLxyAOtPeCDp1bzG70rmkNrYXTj+LF
 7b+5LTNmNsFOqaEiHv9t7LPk3PRHRw7a/2+dx1TJXvNhB9bCOzqO1FGJOoh1NyQVHWMz
 bZqQ==
X-Gm-Message-State: AOJu0YyzCIJ4wHBG1Wpdhy0diVsZRM9Ewi7rUp4nQUXdgWq6WXUndBmF
 OarSCfbT7Pr9Dgin6o35pNqKqQ==
X-Google-Smtp-Source: AGHT+IEOBYXAsmz1NUtDHuWNEqihwgRq4S0GE0V7dGy5xLnjosqnzHyIm0buiS+x82OLgY1hTqPIng==
X-Received: by 2002:a05:6a21:625:b0:18f:97c:8a4a with SMTP id
 ll37-20020a056a21062500b0018f097c8a4amr9358461pzb.117.1702562984167; 
 Thu, 14 Dec 2023 06:09:44 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 16-20020a056a00071000b006ce921da705sm11800644pfl.136.2023.12.14.06.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:09:43 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: rick@andestech.com, ycliang@andestech.com, peterlin@andestech.com,
 u-boot@lists.denx.de
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/2] cache: add sifive private L2 cache driver
Date: Thu, 14 Dec 2023 14:09:36 +0000
Message-Id: <20231214140937.27784-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214140937.27784-1-zong.li@sifive.com>
References: <20231214140937.27784-1-zong.li@sifive.com>
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

This driver is currently responsible for enabling the clock gating
feature of SiFive pre core's private L2 cache.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/cache/Kconfig            |  7 +++++
 drivers/cache/Makefile           |  1 +
 drivers/cache/cache-sifive-pl2.c | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/cache/cache-sifive-pl2.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 6cb8c3e980..26c2d80a1c 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -45,4 +45,11 @@ config SIFIVE_CCACHE
 	  This driver is for SiFive Composable L2/L3 cache. It enables cache
 	  ways of composable cache.
 
+config SIFIVE_PL2
+	bool "SiFive private L2 cache"
+	select CACHE
+	help
+	  This driver is for SiFive Private L2 cache. It configures registers
+	  to enable the clock gating feature.
+
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index ad765774e3..78e673d09e 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_L2X0_CACHE) += cache-l2x0.o
 obj-$(CONFIG_NCORE_CACHE) += cache-ncore.o
 obj-$(CONFIG_V5L2_CACHE) += cache-v5l2.o
 obj-$(CONFIG_SIFIVE_CCACHE) += cache-sifive-ccache.o
+obj-$(CONFIG_SIFIVE_PL2) += cache-sifive-pl2.o
diff --git a/drivers/cache/cache-sifive-pl2.c b/drivers/cache/cache-sifive-pl2.c
new file mode 100644
index 0000000000..ae689e18ed
--- /dev/null
+++ b/drivers/cache/cache-sifive-pl2.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#include <cache.h>
+#include <dm.h>
+#include <malloc.h>
+#include <asm/io.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+
+#define	SIFIVE_PL2CHICKENBIT_OFFSET			0x1000
+#define	SIFIVE_PL2CHICKENBIT_REGIONCLOCKDISABLE_MASK	BIT(3)
+
+static int sifive_pl2_probe(struct udevice *dev)
+{
+	fdt_addr_t base;
+	u32 val;
+
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	/* Enable regionClockDisable bit */
+	val = readl((void __iomem *)(base + SIFIVE_PL2CHICKENBIT_OFFSET));
+	writel(val & ~SIFIVE_PL2CHICKENBIT_REGIONCLOCKDISABLE_MASK,
+	       (void __iomem *)(base + SIFIVE_PL2CHICKENBIT_OFFSET));
+
+	return 0;
+}
+
+static const struct udevice_id sifive_pl2_ids[] = {
+	{ .compatible = "sifive,pl2cache0" },
+	{ .compatible = "sifive,pl2cache1" },
+	{}
+};
+
+U_BOOT_DRIVER(sifive_pl2) = {
+	.name = "sifive_pl2",
+	.id = UCLASS_CACHE,
+	.of_match = sifive_pl2_ids,
+	.probe = sifive_pl2_probe,
+};
-- 
2.17.1

