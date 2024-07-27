Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C80C3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 17:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C1A88722;
	Sat, 27 Jul 2024 19:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QSP/tbHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C078688753; Sat, 27 Jul 2024 19:41:19 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB6A88722
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 19:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso447378266b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722102077; x=1722706877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vunRTbsMKhwySYjpBj9DUawyk1WY3hlznNL7qESOsY=;
 b=QSP/tbHRXRgwvchiwBZb1A8nt4ijwaQ6U1JVdRTC7df3o9vwrrQJ4KgXm4cRevaCKr
 M4jleAhUR+sIQ1uPOSHQF+JIV3h3FXoH5+vZHm3UEmD5slf7EeMZbXYjuwqrAk4GCKf1
 jFJJvtQJgp2wwIq0Vz2yC6YJja3C3vDAT2Pvf+Q8LZofnSGnopl3o5GTA8xl/BD5JaNq
 eM2+NhYzDhUOhuCDHLcYmy8YQTGYFTbIKnQMBnoOrR6n9qiwl/GUSyN+wOAmUMsxhRDX
 A0uiXNxx9VzKamCi0J2wol70FMS5xXERRH96cbvS7AcdRQr+uVzTt8nRWqNN57FhIVb+
 w3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722102077; x=1722706877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vunRTbsMKhwySYjpBj9DUawyk1WY3hlznNL7qESOsY=;
 b=hSMTQ25XSY/GoBDR0BIs93JDTVYPgZ1A+0AANXaJe7Dt84UDDnwWNlYwHTysxmqMqU
 MAfnucgw00Z6NDEWdwDLDmEo3C5Vu8bnkMl+4ST0EG6Is1WfRsIGp8SVaDxK7bFac4LA
 Z6b3oPzB22VPpXAZnR2+fqUL6nozR+i143cqPUMOKF/I5xautCfmAcaVMcZ8EpgBGxsO
 wL565RgZlTQkuXb+48vlVZfMzdmLh7HajIzBIDCcyl7RXigjTdSNgwtO423d99LUoW98
 qPBYt+wYTP4mQRsS+07bTwqujVEMu4trai8BgA4MaW7zTfOmLWsLFSXwoUwHDBr1zT7N
 t5dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy7F3e+FkU0l1DMRUUv3apbVD+9QciYGLy6Nwt//CIF5kJ8RCVKAVCRuh78OPXvH9LuDF0hT2qNxVzFN1GkxFPO+gLvg==
X-Gm-Message-State: AOJu0YwKRk2y6NW8OpbXIyEVWnUAQsKGPzcDapJ0re8ooarcCdAkG2ns
 93zBwMo3ZBb8ofAJIBoS0/66yhTDIfOo6hU2847/IrgbtZdKousE
X-Google-Smtp-Source: AGHT+IFZFzPuXdcYebyT7OhlOuEwMxOKOrul9oR4uSEHSH9CRAakvC8OirfaGuwEHbdpZYnHiV4UPw==
X-Received: by 2002:a17:906:7311:b0:a72:5f3f:27a2 with SMTP id
 a640c23a62f3a-a7d3fa3f9f4mr319769066b.26.1722102076353; 
 Sat, 27 Jul 2024 10:41:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8361sm299927466b.207.2024.07.27.10.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 10:41:16 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 David Virag <virag.david003@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] i2c: samsung: Support platforms other than EXYNOS4 and
 EXYNOS5
Date: Sat, 27 Jul 2024 19:41:48 +0200
Message-ID: <20240727174152.306827-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727174152.306827-1-virag.david003@gmail.com>
References: <20240727174152.306827-1-virag.david003@gmail.com>
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

Newer Samsung SoCs (including newer Exynos, ExynosAuto, Google Tensor)
still use these IPs, or slightly newer versions of it.

Make these drivers available on these platforms by guarding
EXYNOS4/EXYNOS5 specific code behind their configs, and using CCF for
clocks on other platforms.

Tested S3C I2C driver on Exynos7885.
This along with extended clock driver should enable S3C I2C on
Exynos850.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/i2c/Kconfig         |  2 +-
 drivers/i2c/exynos_hs_i2c.c | 25 +++++++++++++++++++++++--
 drivers/i2c/s3c24x0_i2c.c   | 30 +++++++++++++++++++++++++++---
 drivers/i2c/s3c24x0_i2c.h   |  2 ++
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index cba7f84894..52067fa7c1 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -650,7 +650,7 @@ config SYS_I2C_GENI
 
 config SYS_I2C_S3C24X0
 	bool "Samsung I2C driver"
-	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && DM_I2C
+	depends on DM_I2C
 	help
 	  Support for Samsung I2C controller as Samsung SoCs.
 
diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
index 189ce6d509..1b07e18b27 100644
--- a/drivers/i2c/exynos_hs_i2c.c
+++ b/drivers/i2c/exynos_hs_i2c.c
@@ -9,11 +9,15 @@
 #include <dm.h>
 #include <i2c.h>
 #include <log.h>
+#if !(IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5))
 #include <asm/arch/clk.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/pinmux.h>
+#endif
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <linux/delay.h>
+#include <clk.h>
 #include "s3c24x0_i2c.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -137,15 +141,26 @@ static int hsi2c_wait_for_trx(struct exynos5_hsi2c *i2c)
 	return I2C_NOK_TOUT;
 }
 
-static int hsi2c_get_clk_details(struct s3c24x0_i2c_bus *i2c_bus)
+static int hsi2c_get_clk_details(struct udevice *dev)
 {
+	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
 	struct exynos5_hsi2c *hsregs = i2c_bus->hsregs;
 	ulong clkin;
 	unsigned int op_clk = i2c_bus->clock_frequency;
 	unsigned int i = 0, utemp0 = 0, utemp1 = 0;
 	unsigned int t_ftl_cycle;
 
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	clkin = get_i2c_clk();
+#else
+	struct clk clk;
+	int ret;
+
+	ret = clk_get_by_name(dev, "hsi2c", &clk);
+	if (ret < 0)
+		return ret;
+	clkin = clk_get_rate(&clk);
+#endif
 	/* FPCLK / FI2C =
 	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 * FLT_CYCLE
 	 * uTemp0 = (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
@@ -487,7 +502,7 @@ static int s3c24x0_i2c_set_bus_speed(struct udevice *dev, unsigned int speed)
 
 	i2c_bus->clock_frequency = speed;
 
-	if (hsi2c_get_clk_details(i2c_bus))
+	if (hsi2c_get_clk_details(dev))
 		return -EFAULT;
 	hsi2c_ch_init(i2c_bus);
 
@@ -514,7 +529,9 @@ static int s3c24x0_i2c_probe(struct udevice *dev, uint chip, uint chip_flags)
 
 static int s3c_i2c_of_to_plat(struct udevice *dev)
 {
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	const void *blob = gd->fdt_blob;
+#endif
 	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
 	int node;
 
@@ -522,7 +539,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
 
 	i2c_bus->hsregs = dev_read_addr_ptr(dev);
 
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	i2c_bus->id = pinmux_decode_periph_id(blob, node);
+#endif
 
 	i2c_bus->clock_frequency =
 		dev_read_u32_default(dev, "clock-frequency",
@@ -530,7 +549,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
 	i2c_bus->node = node;
 	i2c_bus->bus_num = dev_seq(dev);
 
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	exynos_pinmux_config(i2c_bus->id, PINMUX_FLAG_HS_MODE);
+#endif
 
 	i2c_bus->active = true;
 
diff --git a/drivers/i2c/s3c24x0_i2c.c b/drivers/i2c/s3c24x0_i2c.c
index ae3a801cad..9132c6ebac 100644
--- a/drivers/i2c/s3c24x0_i2c.c
+++ b/drivers/i2c/s3c24x0_i2c.c
@@ -9,12 +9,15 @@
 #include <fdtdec.h>
 #include <time.h>
 #include <log.h>
+#if !(IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5))
 #include <asm/arch/clk.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/pinmux.h>
+#endif
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <i2c.h>
+#include <clk.h>
 #include "s3c24x0_i2c.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -46,10 +49,23 @@ static void read_write_byte(struct s3c24x0_i2c *i2c)
 	clrbits_le32(&i2c->iiccon, I2CCON_IRPND);
 }
 
-static void i2c_ch_init(struct s3c24x0_i2c *i2c, int speed, int slaveadd)
+static int i2c_ch_init(struct udevice *dev, int speed, int slaveadd)
 {
+	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
+	struct s3c24x0_i2c *i2c = i2c_bus->regs;
 	ulong freq, pres = 16, div;
+
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
 	freq = get_i2c_clk();
+#else
+	struct clk clk;
+	int ret;
+
+	ret = clk_get_by_name(dev, "i2c", &clk);
+	if (ret < 0)
+		return ret;
+	freq = clk_get_rate(&clk);
+#endif
 	/* calculate prescaler and divisor values */
 	if ((freq / pres / (16 + 1)) > speed)
 		/* set prescaler to 512 */
@@ -67,6 +83,7 @@ static void i2c_ch_init(struct s3c24x0_i2c *i2c, int speed, int slaveadd)
 	writel(slaveadd, &i2c->iicadd);
 	/* program Master Transmit (and implicit STOP) */
 	writel(I2C_MODE_MT | I2C_TXRX_ENA, &i2c->iicstat);
+	return 0;
 }
 
 #define SYS_I2C_S3C24X0_SLAVE_ADDR	0
@@ -77,8 +94,9 @@ static int s3c24x0_i2c_set_bus_speed(struct udevice *dev, unsigned int speed)
 
 	i2c_bus->clock_frequency = speed;
 
-	i2c_ch_init(i2c_bus->regs, i2c_bus->clock_frequency,
-		    SYS_I2C_S3C24X0_SLAVE_ADDR);
+	if (i2c_ch_init(dev, i2c_bus->clock_frequency,
+			SYS_I2C_S3C24X0_SLAVE_ADDR))
+		return -EFAULT;
 
 	return 0;
 }
@@ -293,7 +311,9 @@ static int s3c24x0_i2c_xfer(struct udevice *dev, struct i2c_msg *msg,
 
 static int s3c_i2c_of_to_plat(struct udevice *dev)
 {
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	const void *blob = gd->fdt_blob;
+#endif
 	struct s3c24x0_i2c_bus *i2c_bus = dev_get_priv(dev);
 	int node;
 
@@ -301,7 +321,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
 
 	i2c_bus->regs = dev_read_addr_ptr(dev);
 
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	i2c_bus->id = pinmux_decode_periph_id(blob, node);
+#endif
 
 	i2c_bus->clock_frequency =
 		dev_read_u32_default(dev, "clock-frequency",
@@ -309,7 +331,9 @@ static int s3c_i2c_of_to_plat(struct udevice *dev)
 	i2c_bus->node = node;
 	i2c_bus->bus_num = dev_seq(dev);
 
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	exynos_pinmux_config(i2c_bus->id, 0);
+#endif
 
 	i2c_bus->active = true;
 
diff --git a/drivers/i2c/s3c24x0_i2c.h b/drivers/i2c/s3c24x0_i2c.h
index ec8f1acaef..12249d5c14 100644
--- a/drivers/i2c/s3c24x0_i2c.h
+++ b/drivers/i2c/s3c24x0_i2c.h
@@ -54,7 +54,9 @@ struct s3c24x0_i2c_bus {
 	struct exynos5_hsi2c *hsregs;
 	int is_highspeed;	/* High speed type, rather than I2C */
 	unsigned clock_frequency;
+#if IS_ENABLED(CONFIG_ARCH_EXYNOS4) || IS_ENABLED(CONFIG_ARCH_EXYNOS5)
 	int id;
+#endif
 	unsigned clk_cycle;
 	unsigned clk_div;
 };
-- 
2.45.2

