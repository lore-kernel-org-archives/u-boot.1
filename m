Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C25FEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A8F688E4C;
	Thu, 12 Sep 2024 08:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ia0FThPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D182988DC7; Thu, 12 Sep 2024 08:07:02 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9551888DAC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c40965d3bdso89671a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121219; x=1726726019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG9LpmQWfLveuM5csyrJBInQSCoRGdA9pvVjccUyTXY=;
 b=ia0FThPHtdnuFi6fH5VsbCtTu+y9Prh+bgWpewz2YuhAOPmW3OaWJNQ0Q71qKEcEjx
 xB+VY0/wLoB8HlVmubc2pYzCUUIp6XaaG1bYhdtxI4RNZnzqftcy6Ac1cMxoqLMajiC4
 +Oe1cQIcY3sGiwCYjpuVSSI6/LxRjMN62Iot78jsb+vV4Ze9ddOaOHnc/dGZdYpuzYtU
 IRuYNU03ksO512ftf0FNfu7fUgUhtn6G+zpF5pRxroKi+vvj8C/dUUCbDa8CiJ1mRtF4
 Y12L4AGJEIxfX2YPp05myrmJnz8rmdW9YPtpTVKwHSBtwWsBsAGo8L2RamHbw4f/vuj1
 hrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121219; x=1726726019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG9LpmQWfLveuM5csyrJBInQSCoRGdA9pvVjccUyTXY=;
 b=CIgufN5mW3PcJMzyaGjJjnW73ZLRTWttGJw1KVhaK00jaSqzcQRRA/G/qZOVBYgnL+
 X7kz1Fiizdzp89g0LzUfZhlUqE/2R1j2UwpmfZWiFWYqeEMdkH8Q1AS1KZ8uvrLWJ2My
 FqZRvUay4Rpft5UYUKPdnvyu8V86iUjQapgSb+tH7V2c/8/VU6xRflaXtes596Rv3P1H
 iNJ60zS7z405CrSSNME3nsJfvwKuhoKkEhcB8zUE4UTP/hTnmBj7RjVsDEmb8VAuxEC+
 61qxaAgS3padyhNZ0HLvT1QAnz/qnbhx7cal0x0XHmWHV0DhUbUTWi9uuwUv+c9pQPUF
 imvg==
X-Gm-Message-State: AOJu0Yy5fpFseZqowu9bEwesiZY9BdFFgdnkFHwXHhL101RGHG2g43Bb
 BrDxomlrYwNrFxrMrGSLf3zdYts8Xo7p0G5qE3QjQoVMrmiYMRPij1nPBA==
X-Google-Smtp-Source: AGHT+IH1ST5yG/6zQzeRuVuJM0r3Ot2K7xb2jMdqPTLfyd9b2pCBv7I/78oa1LruWwwKxN09tPwhkQ==
X-Received: by 2002:a17:907:9724:b0:a7a:b895:6571 with SMTP id
 a640c23a62f3a-a9029612b9dmr65677466b.9.1726121218752; 
 Wed, 11 Sep 2024 23:06:58 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 8/9] ARM: socfpga: add si5338 clock generator support
Date: Thu, 12 Sep 2024 06:06:48 +0000
Message-Id: <20240912060649.190-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

The si5338 clock generator is needed on some Enclustra Socfpga SoMs.
Introduce minimal support of this device.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/clk/Kconfig                          |   1 +
 drivers/clk/Makefile                         |   1 +
 drivers/clk/skyworks/Kconfig                 |  10 +
 drivers/clk/skyworks/Makefile                |   3 +
 drivers/clk/skyworks/Si5338-RevB-Registers.h | 441 +++++++++++++++++++
 drivers/clk/skyworks/si5338_clkgen.c         | 177 ++++++++
 drivers/clk/skyworks/si5338_clkgen.h         |  18 +
 7 files changed, 651 insertions(+)
 create mode 100644 drivers/clk/skyworks/Kconfig
 create mode 100644 drivers/clk/skyworks/Makefile
 create mode 100644 drivers/clk/skyworks/Si5338-RevB-Registers.h
 create mode 100644 drivers/clk/skyworks/si5338_clkgen.c
 create mode 100644 drivers/clk/skyworks/si5338_clkgen.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9acbc47fe8..5d2053623c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -259,6 +259,7 @@ source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sifive/Kconfig"
+source "drivers/clk/skyworks/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/stm32/Kconfig"
 source "drivers/clk/tegra/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 847b9b2911..daa70112ac 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
+obj-$(CONFIG_CLK_SKYWORKS_SI5338) += skyworks/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
 obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
diff --git a/drivers/clk/skyworks/Kconfig b/drivers/clk/skyworks/Kconfig
new file mode 100644
index 0000000000..dd041f603a
--- /dev/null
+++ b/drivers/clk/skyworks/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config CLK_SKYWORKS_SI5338
+	bool "Skyworks SI5338 clock generator"
+	depends on CLK
+	depends on DM_I2C
+	depends on SPL_I2C
+	help
+	  Configure the SI5338 clock generator device. The SI5338 is needed on
+	  some Enclustra Socfpga SoMs.
diff --git a/drivers/clk/skyworks/Makefile b/drivers/clk/skyworks/Makefile
new file mode 100644
index 0000000000..c676b6ef94
--- /dev/null
+++ b/drivers/clk/skyworks/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CLK_SKYWORKS_SI5338) += si5338_clkgen.o
diff --git a/drivers/clk/skyworks/Si5338-RevB-Registers.h b/drivers/clk/skyworks/Si5338-RevB-Registers.h
new file mode 100644
index 0000000000..e1754cd807
--- /dev/null
+++ b/drivers/clk/skyworks/Si5338-RevB-Registers.h
@@ -0,0 +1,441 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#ifndef __SI5338_REVB_REGISTERS_H
+#define __SI5338_REVB_REGISTERS_H
+
+#include "si5338_clkgen.h"
+
+/*
+ * Register map for use with AN428 (JumpStart)
+ * http://www.skyworksinc.com/timing
+ * #BEGIN_HEADER
+ * Date = Friday, June 09, 2023 5:03 PM
+ * File version = 3
+ * Software Name = ClockBuilder Pro
+ * Software version = 4.9.0.0
+ * Software date = 4 24, 2023
+ * Chip = Si533x
+ * Part Number = Si533x
+ * #END_HEADER
+ * Input Frequency (MHz) = 24.000000000
+ * Input Type = CMOS_SSTL_HSTL
+ * P1 = 1
+ * Input Mux = RefClk
+ * FDBK Input Frequency (MHz) = 24.000000000
+ * FDBK Input Type = OFF
+ * P2 = 1
+ * FDBK Mux = NoClk
+ * PFD Input Frequency (MHz) = 24.000000000
+ * VCO Frequency (GHz) = 2.500000
+ * N = 104  1/6  (104.1667)
+ * Internal feedback enabled
+ * Output Clock 0
+ *  Output Frequency (MHz) = 125.000000000
+ *  Mux Selection = IDn
+ *  MultiSynth = 20  (20.0000)
+ *  R = 1
+ * Output Clock 1
+ *  Output is off
+ * Output Clock 2
+ *  Output is off
+ * Output Clock 3
+ *  Output Frequency (MHz) = 100.000000000
+ *  Mux Selection = IDn
+ *  MultiSynth = 25  (25.0000)
+ *  R = 1
+ * Driver 0
+ *  Enabled
+ *  Powered on
+ *  Output voltage = 3.30
+ *  Output type = 3.3V LVDS
+ *  Output state when disabled = Tristate
+ * Driver 1
+ *  Disabled
+ *  Powered off
+ *  Output voltage = 3.30
+ *  Output type = 3.3V LVDS
+ *  Output state when disabled = StopLow
+ * Driver 2
+ *  Disabled
+ *  Powered off
+ *  Output voltage = 3.30
+ *  Output type = 3.3V LVDS
+ *  Output state when disabled = StopLow
+ * Driver 3
+ *  Enabled
+ *  Powered on
+ *  Output voltage = 3.30
+ *  Output type = 3.3V CMOS on A
+ *  Output state when disabled = Tristate
+ * Clock 0 phase inc/dec step size (ns) = 0.000
+ * Clock 1 phase inc/dec step size (ns) = 0.000
+ * Clock 2 phase inc/dec step size (ns) = 0.000
+ * Clock 3 phase inc/dec step size (ns) = 0.000
+ * Phase increment and decrement pin control is off
+ * Frequency increment and decrement pin control is off
+ * Frequency increment and decrement is disabled
+ * Initial phase offset 0 (ns) = 0.000
+ * Initial phase offset 1 (ns) = 0.000
+ * Initial phase offset 2 (ns) = 0.000
+ * Initial phase offset 3 (ns) = 0.000
+ * SSC is disabled
+ */
+
+#define NUM_REGS_MAX 350
+
+struct reg_data const reg_store[NUM_REGS_MAX] = {
+	{  0, 0x00, 0x00},
+	{  1, 0x00, 0x00},
+	{  2, 0x00, 0x00},
+	{  3, 0x00, 0x00},
+	{  4, 0x00, 0x00},
+	{  5, 0x00, 0x00},
+	{  6, 0x08, 0x1D},
+	{  7, 0x00, 0x00},
+	{  8, 0x70, 0x00},
+	{  9, 0x0F, 0x00},
+	{ 10, 0x00, 0x00},
+	{ 11, 0x00, 0x00},
+	{ 12, 0x00, 0x00},
+	{ 13, 0x00, 0x00},
+	{ 14, 0x00, 0x00},
+	{ 15, 0x00, 0x00},
+	{ 16, 0x00, 0x00},
+	{ 17, 0x00, 0x00},
+	{ 18, 0x00, 0x00},
+	{ 19, 0x00, 0x00},
+	{ 20, 0x00, 0x00},
+	{ 21, 0x00, 0x00},
+	{ 22, 0x00, 0x00},
+	{ 23, 0x00, 0x00},
+	{ 24, 0x00, 0x00},
+	{ 25, 0x00, 0x00},
+	{ 26, 0x00, 0x00},
+	{ 27, 0x70, 0x80},
+	{ 28, 0x0B, 0xFF},
+	{ 29, 0x08, 0xFF},
+	{ 30, 0xB0, 0xFF},
+	{ 31, 0xC0, 0xFF},
+	{ 32, 0xE3, 0xFF},
+	{ 33, 0xE3, 0xFF},
+	{ 34, 0xC0, 0xFF},
+	{ 35, 0x00, 0xFF},
+	{ 36, 0x06, 0x1F},
+	{ 37, 0x00, 0x1F},
+	{ 38, 0x00, 0x1F},
+	{ 39, 0x01, 0x1F},
+	{ 40, 0x63, 0xFF},
+	{ 41, 0x0C, 0x7F},
+	{ 42, 0x37, 0x3F},
+	{ 43, 0x00, 0x00},
+	{ 44, 0x00, 0x00},
+	{ 45, 0x00, 0xFF},
+	{ 46, 0x00, 0xFF},
+	{ 47, 0x14, 0x3F},
+	{ 48, 0x3C, 0xFF},
+	{ 49, 0x00, 0xFF},
+	{ 50, 0xC4, 0xFF},
+	{ 51, 0x07, 0xFF},
+	{ 52, 0x10, 0xFF},
+	{ 53, 0x00, 0xFF},
+	{ 54, 0x08, 0xFF},
+	{ 55, 0x00, 0xFF},
+	{ 56, 0x00, 0xFF},
+	{ 57, 0x00, 0xFF},
+	{ 58, 0x00, 0xFF},
+	{ 59, 0x01, 0xFF},
+	{ 60, 0x00, 0xFF},
+	{ 61, 0x00, 0xFF},
+	{ 62, 0x00, 0x3F},
+	{ 63, 0x10, 0xFF},
+	{ 64, 0x00, 0xFF},
+	{ 65, 0x00, 0xFF},
+	{ 66, 0x00, 0xFF},
+	{ 67, 0x00, 0xFF},
+	{ 68, 0x00, 0xFF},
+	{ 69, 0x00, 0xFF},
+	{ 70, 0x00, 0xFF},
+	{ 71, 0x00, 0xFF},
+	{ 72, 0x00, 0xFF},
+	{ 73, 0x00, 0x3F},
+	{ 74, 0x10, 0xFF},
+	{ 75, 0x00, 0xFF},
+	{ 76, 0x00, 0xFF},
+	{ 77, 0x00, 0xFF},
+	{ 78, 0x00, 0xFF},
+	{ 79, 0x00, 0xFF},
+	{ 80, 0x00, 0xFF},
+	{ 81, 0x00, 0xFF},
+	{ 82, 0x00, 0xFF},
+	{ 83, 0x00, 0xFF},
+	{ 84, 0x00, 0x3F},
+	{ 85, 0x10, 0xFF},
+	{ 86, 0x80, 0xFF},
+	{ 87, 0x0A, 0xFF},
+	{ 88, 0x00, 0xFF},
+	{ 89, 0x00, 0xFF},
+	{ 90, 0x00, 0xFF},
+	{ 91, 0x00, 0xFF},
+	{ 92, 0x01, 0xFF},
+	{ 93, 0x00, 0xFF},
+	{ 94, 0x00, 0xFF},
+	{ 95, 0x00, 0x3F},
+	{ 96, 0x10, 0x00},
+	{ 97, 0x15, 0xFF},
+	{ 98, 0x32, 0xFF},
+	{ 99, 0x08, 0xFF},
+	{100, 0x00, 0xFF},
+	{101, 0x00, 0xFF},
+	{102, 0x00, 0xFF},
+	{103, 0x06, 0xFF},
+	{104, 0x00, 0xFF},
+	{105, 0x00, 0xFF},
+	{106, 0x80, 0xBF},
+	{107, 0x00, 0xFF},
+	{108, 0x00, 0xFF},
+	{109, 0x00, 0xFF},
+	{110, 0x00, 0xFF},
+	{111, 0x00, 0xFF},
+	{112, 0x00, 0xFF},
+	{113, 0x00, 0xFF},
+	{114, 0x40, 0xFF},
+	{115, 0x00, 0xFF},
+	{116, 0x80, 0xFF},
+	{117, 0x00, 0xFF},
+	{118, 0x40, 0xFF},
+	{119, 0x00, 0xFF},
+	{120, 0x00, 0xFF},
+	{121, 0x00, 0xFF},
+	{122, 0x00, 0xFF},
+	{123, 0x00, 0xFF},
+	{124, 0x00, 0xFF},
+	{125, 0x00, 0xFF},
+	{126, 0x00, 0xFF},
+	{127, 0x00, 0xFF},
+	{128, 0x00, 0xFF},
+	{129, 0x00, 0x0F},
+	{130, 0x00, 0x0F},
+	{131, 0x00, 0xFF},
+	{132, 0x00, 0xFF},
+	{133, 0x00, 0xFF},
+	{134, 0x00, 0xFF},
+	{135, 0x00, 0xFF},
+	{136, 0x00, 0xFF},
+	{137, 0x00, 0xFF},
+	{138, 0x00, 0xFF},
+	{139, 0x00, 0xFF},
+	{140, 0x00, 0xFF},
+	{141, 0x00, 0xFF},
+	{142, 0x00, 0xFF},
+	{143, 0x00, 0xFF},
+	{144, 0x00, 0xFF},
+	{145, 0x00, 0x00},
+	{146, 0xFF, 0x00},
+	{147, 0x00, 0x00},
+	{148, 0x00, 0x00},
+	{149, 0x00, 0x00},
+	{150, 0x00, 0x00},
+	{151, 0x00, 0x00},
+	{152, 0x00, 0xFF},
+	{153, 0x00, 0xFF},
+	{154, 0x00, 0xFF},
+	{155, 0x00, 0xFF},
+	{156, 0x00, 0xFF},
+	{157, 0x00, 0xFF},
+	{158, 0x00, 0x0F},
+	{159, 0x00, 0x0F},
+	{160, 0x00, 0xFF},
+	{161, 0x00, 0xFF},
+	{162, 0x00, 0xFF},
+	{163, 0x00, 0xFF},
+	{164, 0x00, 0xFF},
+	{165, 0x00, 0xFF},
+	{166, 0x00, 0xFF},
+	{167, 0x00, 0xFF},
+	{168, 0x00, 0xFF},
+	{169, 0x00, 0xFF},
+	{170, 0x00, 0xFF},
+	{171, 0x00, 0xFF},
+	{172, 0x00, 0xFF},
+	{173, 0x00, 0xFF},
+	{174, 0x00, 0xFF},
+	{175, 0x00, 0xFF},
+	{176, 0x00, 0xFF},
+	{177, 0x00, 0xFF},
+	{178, 0x00, 0xFF},
+	{179, 0x00, 0xFF},
+	{180, 0x00, 0xFF},
+	{181, 0x00, 0x0F},
+	{182, 0x00, 0xFF},
+	{183, 0x00, 0xFF},
+	{184, 0x00, 0xFF},
+	{185, 0x00, 0xFF},
+	{186, 0x00, 0xFF},
+	{187, 0x00, 0xFF},
+	{188, 0x00, 0xFF},
+	{189, 0x00, 0xFF},
+	{190, 0x00, 0xFF},
+	{191, 0x00, 0xFF},
+	{192, 0x00, 0xFF},
+	{193, 0x00, 0xFF},
+	{194, 0x00, 0xFF},
+	{195, 0x00, 0xFF},
+	{196, 0x00, 0xFF},
+	{197, 0x00, 0xFF},
+	{198, 0x00, 0xFF},
+	{199, 0x00, 0xFF},
+	{200, 0x00, 0xFF},
+	{201, 0x00, 0xFF},
+	{202, 0x00, 0xFF},
+	{203, 0x00, 0x0F},
+	{204, 0x00, 0xFF},
+	{205, 0x00, 0xFF},
+	{206, 0x00, 0xFF},
+	{207, 0x00, 0xFF},
+	{208, 0x00, 0xFF},
+	{209, 0x00, 0xFF},
+	{210, 0x00, 0xFF},
+	{211, 0x00, 0xFF},
+	{212, 0x00, 0xFF},
+	{213, 0x00, 0xFF},
+	{214, 0x00, 0xFF},
+	{215, 0x00, 0xFF},
+	{216, 0x00, 0xFF},
+	{217, 0x00, 0xFF},
+	{218, 0x00, 0x00},
+	{219, 0x00, 0x00},
+	{220, 0x00, 0x00},
+	{221, 0x0D, 0x00},
+	{222, 0x00, 0x00},
+	{223, 0x00, 0x00},
+	{224, 0xF4, 0x00},
+	{225, 0xF0, 0x00},
+	{226, 0x00, 0x00},
+	{227, 0x00, 0x00},
+	{228, 0x00, 0x00},
+	{229, 0x00, 0x00},
+	{231, 0x00, 0x00},
+	{232, 0x00, 0x00},
+	{233, 0x00, 0x00},
+	{234, 0x00, 0x00},
+	{235, 0x00, 0x00},
+	{236, 0x00, 0x00},
+	{237, 0x00, 0x00},
+	{238, 0x14, 0x00},
+	{239, 0x00, 0x00},
+	{240, 0x00, 0x00},
+	{242, 0x02, 0x02},
+	{243, 0xF0, 0x00},
+	{244, 0x00, 0x00},
+	{245, 0x00, 0x00},
+	{247, 0x00, 0x00},
+	{248, 0x00, 0x00},
+	{249, 0xA8, 0x00},
+	{250, 0x00, 0x00},
+	{251, 0x84, 0x00},
+	{252, 0x00, 0x00},
+	{253, 0x00, 0x00},
+	{254, 0x00, 0x00},
+	{255,    1, 0xFF}, // set page bit to 1
+	{  0, 0x00, 0x00},
+	{  1, 0x00, 0x00},
+	{  2, 0x00, 0x00},
+	{  3, 0x00, 0x00},
+	{  4, 0x00, 0x00},
+	{  5, 0x00, 0x00},
+	{  6, 0x00, 0x00},
+	{  7, 0x00, 0x00},
+	{  8, 0x00, 0x00},
+	{  9, 0x00, 0x00},
+	{ 10, 0x00, 0x00},
+	{ 11, 0x00, 0x00},
+	{ 12, 0x00, 0x00},
+	{ 13, 0x00, 0x00},
+	{ 14, 0x00, 0x00},
+	{ 15, 0x00, 0x00},
+	{ 16, 0x00, 0x00},
+	{ 17, 0x01, 0x00},
+	{ 18, 0x00, 0x00},
+	{ 19, 0x00, 0x00},
+	{ 20, 0x90, 0x00},
+	{ 21, 0x31, 0x00},
+	{ 22, 0x00, 0x00},
+	{ 23, 0x00, 0x00},
+	{ 24, 0x01, 0x00},
+	{ 25, 0x00, 0x00},
+	{ 26, 0x00, 0x00},
+	{ 27, 0x00, 0x00},
+	{ 28, 0x00, 0x00},
+	{ 29, 0x00, 0x00},
+	{ 30, 0x00, 0x00},
+	{ 31, 0x00, 0xFF},
+	{ 32, 0x00, 0xFF},
+	{ 33, 0x01, 0xFF},
+	{ 34, 0x00, 0xFF},
+	{ 35, 0x00, 0xFF},
+	{ 36, 0x90, 0xFF},
+	{ 37, 0x31, 0xFF},
+	{ 38, 0x00, 0xFF},
+	{ 39, 0x00, 0xFF},
+	{ 40, 0x01, 0xFF},
+	{ 41, 0x00, 0xFF},
+	{ 42, 0x00, 0xFF},
+	{ 43, 0x00, 0x0F},
+	{ 44, 0x00, 0x00},
+	{ 45, 0x00, 0x00},
+	{ 46, 0x00, 0x00},
+	{ 47, 0x00, 0xFF},
+	{ 48, 0x00, 0xFF},
+	{ 49, 0x01, 0xFF},
+	{ 50, 0x00, 0xFF},
+	{ 51, 0x00, 0xFF},
+	{ 52, 0x90, 0xFF},
+	{ 53, 0x31, 0xFF},
+	{ 54, 0x00, 0xFF},
+	{ 55, 0x00, 0xFF},
+	{ 56, 0x01, 0xFF},
+	{ 57, 0x00, 0xFF},
+	{ 58, 0x00, 0xFF},
+	{ 59, 0x00, 0x0F},
+	{ 60, 0x00, 0x00},
+	{ 61, 0x00, 0x00},
+	{ 62, 0x00, 0x00},
+	{ 63, 0x00, 0xFF},
+	{ 64, 0x00, 0xFF},
+	{ 65, 0x01, 0xFF},
+	{ 66, 0x00, 0xFF},
+	{ 67, 0x00, 0xFF},
+	{ 68, 0x90, 0xFF},
+	{ 69, 0x31, 0xFF},
+	{ 70, 0x00, 0xFF},
+	{ 71, 0x00, 0xFF},
+	{ 72, 0x01, 0xFF},
+	{ 73, 0x00, 0xFF},
+	{ 74, 0x00, 0xFF},
+	{ 75, 0x00, 0x0F},
+	{ 76, 0x00, 0x00},
+	{ 77, 0x00, 0x00},
+	{ 78, 0x00, 0x00},
+	{ 79, 0x00, 0xFF},
+	{ 80, 0x00, 0xFF},
+	{ 81, 0x00, 0xFF},
+	{ 82, 0x00, 0xFF},
+	{ 83, 0x00, 0xFF},
+	{ 84, 0x90, 0xFF},
+	{ 85, 0x31, 0xFF},
+	{ 86, 0x00, 0xFF},
+	{ 87, 0x00, 0xFF},
+	{ 88, 0x01, 0xFF},
+	{ 89, 0x00, 0xFF},
+	{ 90, 0x00, 0xFF},
+	{ 91, 0x00, 0x0F},
+	{ 92, 0x00, 0x00},
+	{ 93, 0x00, 0x00},
+	{ 94, 0x00, 0x00},
+	{255,    0, 0xFF} }; // set page bit to 0
+
+#endif /* __SI5338_REVB_REGISTERS_H */
diff --git a/drivers/clk/skyworks/si5338_clkgen.c b/drivers/clk/skyworks/si5338_clkgen.c
new file mode 100644
index 0000000000..903dd05d5d
--- /dev/null
+++ b/drivers/clk/skyworks/si5338_clkgen.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ *
+ * SI5338 - A I2C programmable any-frequency, any-output quad clock generator.
+ */
+
+#include <linux/compat.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+
+#include "si5338_clkgen.h"
+
+#include "Si5338-RevB-Registers.h"
+
+int i2c_write_simple(struct udevice *dev, u8 addr, u8 data)
+{
+	unsigned char buf[1];
+
+	buf[0] = data;
+	if (dm_i2c_write(dev, addr, buf, 1) != 0) {
+		printf("SI5338 I2C write failed: %02x, %02x\n", addr, data);
+		return -1;
+	}
+	return 0;
+}
+
+int i2c_write_masked(struct udevice *dev, u8 addr, u8 data, u8 mask)
+{
+	unsigned char buf[1];
+
+	if (mask == 0x00)
+		return 0;
+
+	if (mask == 0xff)
+		return i2c_write_simple(dev, addr, data);
+
+	if (dm_i2c_read(dev, addr, buf, 1) != 0) {
+		printf("SI5338 I2C read failed\n");
+		return -1;
+	}
+	buf[0] &= ~mask;
+	buf[0] |= data & mask;
+	if (dm_i2c_write(dev, addr, buf, 1) != 0) {
+		printf("SI5338 I2C write failed: %02x, %02x, %02x\n",
+		       addr, data, mask);
+		return -1;
+	}
+	return 0;
+}
+
+int si5338_init(void)
+{
+	unsigned char buf[1];
+	struct udevice *dev;
+	int try = 0;
+	int i;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, 0x70, 1, &dev);
+	if (ret) {
+		printf("SI5338 I2C init failed\n");
+		return -ENODEV;
+	}
+
+	/* Set page to 0 */
+	if (i2c_write_simple(dev, 255, 0x00))
+		return -EFAULT;
+
+	/* Disable outputs */
+	if (i2c_write_masked(dev, 230, 0x10, 0x10))
+		return -EFAULT;
+
+	/* Pause */
+	if (i2c_write_masked(dev, 241, 0x80, 0x80))
+		return -EFAULT;
+
+	/* Write new configuration */
+	for (i = 0; i < NUM_REGS_MAX; i++) {
+		if (i2c_write_masked(dev, reg_store[i].reg_addr,
+				     reg_store[i].reg_val,
+				     reg_store[i].reg_mask)) {
+			return -EFAULT;
+		}
+	}
+
+	/* Validate input clock status */
+	do {
+		if (dm_i2c_read(dev, 218, buf, 1) != 0) {
+			printf("SI5338 I2C read failed\n");
+			return -EFAULT;
+		}
+	} while ((buf[0] & 0x04) != 0);
+
+	/* Configure PLL for locking */
+	if (i2c_write_masked(dev, 49, 0, 0x80))
+		return -EFAULT;
+
+	/* Initiate locking of PLL */
+	if (i2c_write_simple(dev, 246, 0x02))
+		return -EFAULT;
+
+	/* Wait 25ms (100ms to be on the safe side) */
+	mdelay(100);
+
+	/* Restart */
+	if (i2c_write_masked(dev, 241, 0x65, 0xff))
+		return -EFAULT;
+
+	/* Confirm PLL lock status */
+	do {
+		if (dm_i2c_read(dev, 218, buf, 1) != 0) {
+			printf("SI5338 I2C read failed\n");
+			return -EFAULT;
+		}
+		mdelay(100);
+		try++;
+		if (try > 10) {
+			printf("SI5338 PLL is not locking\n");
+			return -EFAULT;
+		}
+	} while ((buf[0] & 0x15) != 0);
+
+	/* Copy fcal values to active registers */
+	if (dm_i2c_read(dev, 237, buf, 1) != 0) {
+		printf("SI5338 I2C failed\n");
+		return -EFAULT;
+	}
+
+	if (i2c_write_masked(dev, 47, buf[0], 0x03))
+		return -EFAULT;
+
+	if (dm_i2c_read(dev, 236, buf, 1) != 0) {
+		printf("SI5338 I2C failed\n");
+		return -EFAULT;
+	}
+
+	if (i2c_write_masked(dev, 46, buf[0], 0xFF))
+		return -EFAULT;
+
+	if (dm_i2c_read(dev, 235, buf, 1) != 0) {
+		printf("SI5338 I2C failed\n");
+		return -EFAULT;
+	}
+
+	if (i2c_write_simple(dev, 45, buf[0]))
+		return -EFAULT;
+
+	if (i2c_write_masked(dev, 47, 0x14, 0xFC))
+		return -EFAULT;
+
+	/* Set PLL to use FCAL values */
+	if (i2c_write_masked(dev, 49, 0x80, 0x80))
+		return -EFAULT;
+
+	/* Enable outputs */
+	if (i2c_write_simple(dev, 230, 0x00))
+		return -EFAULT;
+
+	printf("SI5338 init successful\n");
+
+	return 0;
+}
+
+static int si5338_clk_probe(struct udevice *dev)
+{
+	return si5338_init();
+}
+
+U_BOOT_DRIVER(si5338_clkgen) = {
+	.name = "si5338_clkgen",
+	.id = UCLASS_CLK,
+	.probe = si5338_clk_probe,
+};
diff --git a/drivers/clk/skyworks/si5338_clkgen.h b/drivers/clk/skyworks/si5338_clkgen.h
new file mode 100644
index 0000000000..98c6ff1960
--- /dev/null
+++ b/drivers/clk/skyworks/si5338_clkgen.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Enclustra GmbH
+ * <info@enclustra.com>
+ */
+
+#ifndef __SI5338_CLKGEN_H
+#define __SI5338_CLKGEN_H
+
+int si5338_init(void);
+
+struct reg_data {
+	unsigned char reg_addr;
+	unsigned char reg_val;
+	unsigned char reg_mask;
+};
+
+#endif /* __SI5338_CLKGEN_H */
-- 
2.25.1

