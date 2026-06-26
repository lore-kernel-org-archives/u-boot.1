Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607A4CDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 03:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84D7847C8;
	Fri, 26 Jun 2026 05:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bb0uhslO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F214B84974; Fri, 26 Jun 2026 05:09:20 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEBE847C8
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 05:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so257006a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782443357; x=1783048157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OFUtPEZyxNdqzMb6nYZxIiZNhzjH8hj5do6e7npd4h8=;
 b=bb0uhslO+Oyihkih8+HTJfdqIsCfyoiFxQYdvU1/xIA1tFEF/AKH8KrNjkeydTlz8q
 fJtqYzqYZ9jiWMuuINw9T0fQlFT/uZQJ3W/9R0Vkf7wLdTYXb9Xby47RqD4T+J2wGi4O
 1sCkAaCBxSGrf2RVBsLGGk7xK3SyNA1AbtEUBe/44o8SIRLgjy7GRw9KypJvEdP979og
 MADg6r52bW+KR4XTmwEtKPDZUUUjyn0JdpNHAp6VC5jplPQiYv/4BvCZzCqKCMlSrq5a
 bqsven+q7E6WCxxAhhNI7imcZowJAUFTtDO8HLDJkyigFRCz04RuSfYXVun9XyGmG7Vd
 2Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782443357; x=1783048157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFUtPEZyxNdqzMb6nYZxIiZNhzjH8hj5do6e7npd4h8=;
 b=NLfOFDd1BZT/Wfg10tayBzY9N+g3awmgvX3a/FscxglaQR0ZM5V/rcFS0/qEofP+dS
 MgUMXqA+dE7TwrQqSNXtU0vztR6+wjU9bAI9sRDg3bvLOWc9wODtscOTyg8ctOWbszf2
 mb8xHJMUsI2xXV9HfBBoNyNSakN9NTdyCC0wLuS7Zj72iXwKWCPiR7zt/8+ITtYo7nbt
 om5I3lGB+QIVGgayUMxfzQdps/TU1MK8l2iu+ftpLVc1LjWXIPRAvTetq/KRNCdxmq6W
 nidP758wkaOFKWYGe1M30h8a3JGpuhft3uG0zHYhImqRPjEad6wODogw1jJSS3kg1E8d
 r8nw==
X-Gm-Message-State: AOJu0YxRuBsyXLciQ5VBgVvYgKyxGHLmsrQRPEvxUWxRsy13qajkREhv
 UtIBaQ+OK4pmpYkp0YcO+i8ffwgzt/p7DZOdkDLJDaVtNfDeEFRXiYsMaKE2jxLhPHI=
X-Gm-Gg: AfdE7ckxyHBR3Odq+iTrGbN6r/SJD4stmbuSsRqp1WHa5GDeponBvSaCzr+GmoVIQqs
 NQ1Pqy9O7bMuVB8ZAkenOEvAsTvk9qvQqi9BXepHkcVFK94jfXioIMqFH0UO/HQUGFgxc++gK4B
 nPXGY3znbR0aQ/rm1Fh9qWruSZ1yeRpm+8YlnWp+hjnyB++Vffo5bivooHcFZiNxYOW2Idc4c/+
 u10+QAgOLZOm3oz5fle91i1xd4vfOlYaiAa6gY3gDV4Q76tZl8xExl2t+Jg2v9qaYGpd5cCrC3e
 PAC+Hr8fhn24QDPw2YKkwXG9m/tdp9lF6l7PKHhXLMjLyund8fGsw5M8Ndvh5FZjRLeUEIJl14D
 zuCPkx1EhE+Yqp8vY/yUet+Sr5cO9pzrlsgHP4yZeMmGLYI2ZbZKoZi4J8FS1sWofOpoWEP2NdT
 cAvsCKAyY8jM6qoAS9QSrb98mKj+6Hx+VUJAIZgJGoz5St2QyCUVjMg8Laxv+my2ufEVAbs6Mqe
 u1up1lf/AR/DN8lRHL/NMSFNTeCmymfEz4bM3vbkWRb40ubngTORAkn3dEEK8OOcdkXCU00zvwl
 v8DfQYwZG9uJ2Ww=
X-Received: by 2002:a05:6830:608b:b0:7e7:352:2f74 with SMTP id
 46e09a7af769-7e99c18d2f3mr4874501a34.13.1782443356943; 
 Thu, 25 Jun 2026 20:09:16 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9aa5d3554sm687966a34.9.2026.06.25.20.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:09:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] sunxi: spl: support DM I2C PMIC bus
Date: Thu, 25 Jun 2026 21:09:07 -0600
Message-ID: <20260626030909.2020462-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sunxi_board_init() may need to configure AXP regulators before DRAM is
available. The legacy I2C SPL path calls i2c_init_board() before
sunxi_board_init(), which enables the TWI clock/reset and pinmux. Do the
same when SPL DM I2C is enabled, but keep i2c_init() limited to the
legacy I2C path.

Expose i2c_init_board() to DM I2C callers through the I2C header instead
of adding a local sunxi prototype.

The AXP PMIC bus helper path used when SPL_PMIC_AXP is disabled also
still used the legacy I2C accessors. Add a DM I2C path by resolving the
PMIC bus and chip address from the control FDT, then using dm_i2c_read()
and dm_i2c_write(). Return an error if the PMIC node is not present in
the control FDT rather than guessing at the first I2C bus.

Do not cache the DM bus in static storage: this path runs before DRAM
init in SPL, and SPL BSS may live in DRAM. Resolve the bus locally
instead so the early PMIC path does not depend on pre-DRAM BSS.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm/mach-sunxi/board.c    |   5 +-
 arch/arm/mach-sunxi/pmic_bus.c | 127 +++++++++++++++++++++++++++++++++
 include/i2c.h                  |   3 +-
 3 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..aed50ecbf48 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -483,10 +483,13 @@ void board_init_f(ulong dummy)
 	spl_init();
 	preloader_console_init();
 
-#if CONFIG_IS_ENABLED(I2C) && CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
+#if CONFIG_IS_ENABLED(I2C) && \
+	(CONFIG_IS_ENABLED(SYS_I2C_LEGACY) || CONFIG_IS_ENABLED(DM_I2C))
 	/* Needed early by sunxi_board_init if PMU is enabled */
 	i2c_init_board();
+#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	i2c_init(CONFIG_SYS_I2C_SPEED, CONFIG_SYS_I2C_SLAVE);
+#endif
 #endif
 	sunxi_board_init();
 }
diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index c77dc538456..52594e7896f 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -10,6 +10,9 @@
 
 #include <axp_pmic.h>
 #include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <errno.h>
 #include <asm/arch/p2wi.h>
 #include <asm/arch/rsb.h>
 #include <i2c.h>
@@ -22,6 +25,102 @@
 static struct udevice *pmic;
 #endif
 
+#if !CONFIG_IS_ENABLED(PMIC_AXP) && CONFIG_IS_ENABLED(DM_I2C)
+static int pmic_bus_get_i2c_bus(struct udevice **busp, ofnode *nodep)
+{
+	static const char * const compatibles[] = {
+#if defined(CONFIG_AXP152_POWER)
+		"x-powers,axp152",
+#endif
+#if defined(CONFIG_AXP209_POWER)
+		"x-powers,axp202",
+		"x-powers,axp209",
+#endif
+#if defined(CONFIG_AXP221_POWER)
+		"x-powers,axp221",
+		"x-powers,axp223",
+#endif
+#if defined(CONFIG_AXP305_POWER)
+		"x-powers,axp305",
+#endif
+#if defined(CONFIG_AXP313_POWER)
+		"x-powers,axp313a",
+		"x-powers,axp323",
+#endif
+#if defined(CONFIG_AXP318W_POWER)
+		"x-powers,axp318w",
+#endif
+#if defined(CONFIG_AXP717_POWER)
+		"x-powers,axp717",
+#endif
+#if defined(CONFIG_AXP803_POWER)
+		"x-powers,axp803",
+#endif
+#if defined(CONFIG_AXP809_POWER)
+		"x-powers,axp809",
+		"x-powers,axp806",
+#endif
+#if defined(CONFIG_AXP818_POWER)
+		"x-powers,axp818",
+		"x-powers,axp813",
+#endif
+	};
+	struct udevice *bus;
+	ofnode node;
+	int i, ret;
+
+	for (i = 0, node = ofnode_null(); i < ARRAY_SIZE(compatibles); i++) {
+		node = ofnode_by_compatible(ofnode_null(), compatibles[i]);
+		if (ofnode_valid(node))
+			break;
+	}
+
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C, ofnode_get_parent(node),
+					  &bus);
+	if (ret)
+		return ret;
+
+	*busp = bus;
+	if (nodep)
+		*nodep = node;
+
+	return 0;
+}
+
+static int pmic_bus_get_i2c_chip(struct udevice **devp)
+{
+	struct udevice *bus;
+	ofnode node;
+	u32 addr;
+	int ret;
+
+	ret = pmic_bus_get_i2c_bus(&bus, &node);
+	if (ret)
+		return ret;
+
+	ret = ofnode_read_u32(node, "reg", &addr);
+	if (ret)
+		return ret;
+
+	return i2c_get_chip(bus, addr, 1, devp);
+}
+
+static int pmic_bus_init_i2c(void)
+{
+	struct udevice *bus;
+
+	return pmic_bus_get_i2c_bus(&bus, NULL);
+}
+#else
+static int __maybe_unused pmic_bus_init_i2c(void)
+{
+	return -ENODEV;
+}
+#endif
+
 int pmic_bus_init(void)
 {
 	/* This cannot be 0 because it is used in SPL before BSS is ready */
@@ -47,6 +146,8 @@ int pmic_bus_init(void)
 
 		ret = rsb_set_device_address(AXP_PMIC_PRI_DEVICE_ADDR,
 					     AXP_PMIC_PRI_RUNTIME_ADDR);
+	} else if (CONFIG_IS_ENABLED(DM_I2C)) {
+		ret = pmic_bus_init_i2c();
 	}
 #endif
 
@@ -60,13 +161,26 @@ int pmic_bus_read(u8 reg, u8 *data)
 #if CONFIG_IS_ENABLED(PMIC_AXP)
 	return pmic_read(pmic, reg, data, 1);
 #else
+#if CONFIG_IS_ENABLED(DM_I2C)
+	struct udevice *dev;
+	int ret;
+#endif
+
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN6I_P2WI))
 		return p2wi_read(reg, data);
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
 		return rsb_read(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
 
+#if CONFIG_IS_ENABLED(DM_I2C)
+	ret = pmic_bus_get_i2c_chip(&dev);
+	if (ret)
+		return ret;
+
+	return dm_i2c_read(dev, reg, data, 1);
+#else
 	return i2c_read(CONFIG_AXP_I2C_ADDRESS, reg, 1, data, 1);
 #endif
+#endif
 }
 
 int pmic_bus_write(u8 reg, u8 data)
@@ -74,13 +188,26 @@ int pmic_bus_write(u8 reg, u8 data)
 #if CONFIG_IS_ENABLED(PMIC_AXP)
 	return pmic_write(pmic, reg, &data, 1);
 #else
+#if CONFIG_IS_ENABLED(DM_I2C)
+	struct udevice *dev;
+	int ret;
+#endif
+
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN6I_P2WI))
 		return p2wi_write(reg, data);
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
 		return rsb_write(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
 
+#if CONFIG_IS_ENABLED(DM_I2C)
+	ret = pmic_bus_get_i2c_chip(&dev);
+	if (ret)
+		return ret;
+
+	return dm_i2c_write(dev, reg, &data, 1);
+#else
 	return i2c_write(CONFIG_AXP_I2C_ADDRESS, reg, 1, &data, 1);
 #endif
+#endif
 }
 
 int pmic_bus_setbits(u8 reg, u8 bits)
diff --git a/include/i2c.h b/include/i2c.h
index b2572076236..00f33c9e8e2 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -613,6 +613,8 @@ int acpi_i2c_of_to_plat(struct udevice *dev);
 void i2c_early_init_f(void);
 #endif
 
+void i2c_init_board(void);
+
 #if !CONFIG_IS_ENABLED(DM_I2C)
 
 /*
@@ -700,7 +702,6 @@ struct i2c_adapter *i2c_get_adapter(int index);
  * repeatedly to change the speed and slave addresses.
  */
 void i2c_init(int speed, int slaveaddr);
-void i2c_init_board(void);
 
 #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 /*
-- 
2.53.0

