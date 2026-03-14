Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E43A107BCEB
	for <u-boot@archiver.kernel.org>; Sat, 14 Mar 2026 06:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC1084332;
	Sat, 14 Mar 2026 07:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y6ro/QCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F37E841D5; Sat, 14 Mar 2026 07:03:13 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9383084319
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 07:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-46703fb602fso1179057b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773468188; x=1774072988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ixg+l2JiwH0VVWjEEdYyHxrlFm64w7/wOUJYEUVyxp4=;
 b=Y6ro/QCYS/SwhBfNSQaVrr+mZddj+clc4CAt8gfAVe+Mj0yC+Njocl7c+FQEvi0J8M
 lqB0xVWCEX9TrNqSoxsUbcrV39wNbA5acWeDUGOEMMX76zpLVhOcfQzV0Q/SokSpXx3k
 soCXhsV1XJZqnCH8duj4IXdjNzL+RY/+IkGbrKR9AENcddQGWW7aSirUVZ43wQ83CyDr
 g1ph0N7iEwzAZmrPkQ90u5ffRKs06i9FHmkwqooQSa1RsA4+lpv7bL7kpANgDDdgD+tt
 gKCr4vxu1P70RJ/upnAsNPNQ1aGO3/WcVmRLzRNeVwVEYU3mheBpxWoj6uaCuI5QWaFX
 RoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773468188; x=1774072988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ixg+l2JiwH0VVWjEEdYyHxrlFm64w7/wOUJYEUVyxp4=;
 b=BfWRnREMHzgodLJNp4eDbkRKwDxBLYt8gLPb1R0r8WL1JUPye7lNyNQThq2V1Uj2Op
 iHxqnTNc65ZiFdJx2E8N98WfNwNgTwSdAuB4fR5DcsSO3gIyt0hm9f4CMsk1Ty7p7wbm
 aEEadTWaLRrpXnSDAdXYl3Ieo7qgZHPYJTdPcJJzjHM12RFBRYEEkZ+jwIqCo18DZGkO
 exHbOYe+j/VFUucynhmRkXzBOUxmxtTsgcpWGvg0hXCpYZNltL0YFl1qMq4X/uT4mQcH
 59A7e4qNTImWfQysgXBZFd25bYDjfaS4GbZMaUhr7pzepoZoWNf0OTr1m8HWAHWN0oMD
 cvAw==
X-Gm-Message-State: AOJu0Yxj+JAWTdKc5PnPdiFUfNtcrjFFROkxceb4784pV5FOD2rAGEFg
 LKrmw9i1/gADQruHt1T5vW+NKiHn7vOXmglhV1iueSbc20VRs0d8/GpZtxLF+g==
X-Gm-Gg: ATEYQzyJFPyYuQ7CDPEMQJOROWgcqk/Rlg8D943ycvTTgZMkhWycI8ixeyKwrVWeSIh
 7c5RnM7P3nukQd+Yvas4ifXem0X88nmtHW8FW15NdW5luexAz2OsMf9wWJHDODopC4a1eVPNrQG
 sBup9RO3OW8cpHE47E9Tx36kRr82ngl83yVed9lOSSmKjK45aJmh+OH/QjYuhtj2kzOmSxdgzVy
 /zP4YDg30N5xa9mmbX+gtaeSlty4lDsyu4Cpunnky77p1HypZ8OZCJmIdB8883uiFiNwrnwW/K8
 5jwKWSHHHlNRgE3FEav3H2ofsZQ1Y3R4380FYGPqXJaS4XmTcsT5nRnHzHWevArqKE7uzQGb1vk
 2Yflhz/fJf1Yt+gvLQVcUVHNvbFcUnvyLABeo89SnSlBPOJQnkXACZ5P9Gg9JgQtKZJIbsVkvVp
 yr4ej/BzwrItw7GE1Qsq9BQu/AO5Zr1Y1KNl1mGmoppY2K2a2cVTimvmgpYJXmUTwk/n2JQMI1c
 T/6QRaVn58pWEmLDCwXUzKVdGtTWO5zO5KYYaEJ2XHhc/DnaPh8dFXy15jq
X-Received: by 2002:a05:6808:1508:b0:45f:481c:e258 with SMTP id
 5614622812f47-467570a2cf4mr3305322b6e.16.1773468187329; 
 Fri, 13 Mar 2026 23:03:07 -0700 (PDT)
Received: from james-x399.localdomain (71-33-158-51.hlrn.qwest.net.
 [71.33.158.51]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734160cebsm6051301b6e.7.2026.03.13.23.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 23:03:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>, Alexander Graf <agraf@csgraf.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v2 2/2] sunxi: h616: support DRAM profiles selected by GPIO
 straps
Date: Sat, 14 Mar 2026 00:02:49 -0600
Message-ID: <20260314060256.381642-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314060256.381642-1-james.hilliard1@gmail.com>
References: <20260314060256.381642-1-james.hilliard1@gmail.com>
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

Some H616 boards use different DRAM types across hardware revisions and
select the matching boot0 parameters from strap GPIOs. Add an H616 DRAM
profile source choice so SPL can either keep using the existing fixed
Kconfig profile or read a profile ID from the U-Boot device tree at
boot.

When GPIO-based selection is enabled, SPL decodes the profile ID from
the allwinner,dram-coding-gpios property in /dram-profiles and loads the
matching profile from that node. Profiles can either describe the DRAM
parameters directly or reference a shared parameter block through the
allwinner,dram-params phandle, which avoids duplicating identical tables
for multiple hardware revisions.

Refactor the H616 timing code around per-type backends so the common
controller flow stays in one place while type-specific PHY init data,
mode register programming, and timing setup live in the corresponding
backend files. Fixed-profile builds still link only the selected backend,
while GPIO-selected builds can dispatch at runtime based on the loaded
profile.

Keep the fixed-profile Kconfig flow as the default and hide its prompts
when GPIO-based profile selection is enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h |  42 +-
 arch/arm/mach-sunxi/Kconfig                   |  49 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 698 +++++++++---------
 arch/arm/mach-sunxi/dram_timings/Makefile     |   4 +
 arch/arm/mach-sunxi/dram_timings/h616.c       |  37 +
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  | 149 +++-
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c | 129 +++-
 .../dram_timings/h616_lpddr4_2133.c           | 120 ++-
 8 files changed, 839 insertions(+), 389 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616.c

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index a8fdda124a0..793809bba40 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -168,13 +168,49 @@ struct dram_config {
 	u8 bus_full_width;
 };
 
-static inline int ns_to_t(int nanoseconds)
+#define H616_PHY_INIT_LEN	27
+
+struct h616_dram_phy_cfg {
+	u32 training_reg14;
+	u32 training_reg1c;
+	u32 write_leveling_reg0c;
+	u32 write_leveling_reg10;
+	u32 dx_dri_hi;
+	u32 dx_odt_lo;
+	u32 dx_odt_hi;
+	u32 tpr6_val;
+	u32 phy_mode;
+	bool clear_phy_ctl_0x4_80;
+	bool set_lpddr4_dx_odt_mode;
+	bool clear_read_training_regs;
+};
+
+struct h616_dram_backend {
+	u32 mstr_flags;
+	u32 odtcfg;
+	bool set_com_ctl_0x50;
+	const u8 *(*get_phy_init)(void);
+	void (*set_timing_params)(const struct dram_para *para);
+	void (*get_phy_cfg)(const struct dram_para *para,
+			    struct h616_dram_phy_cfg *phy_cfg);
+	void (*program_mode_registers)(const struct dram_para *para,
+				       struct sunxi_mctl_ctl_reg *mctl_ctl);
+	void (*ca_bit_delay_compensation)(const struct dram_para *para,
+					  const struct dram_config *config,
+					  u32 val);
+};
+
+static inline int h616_ns_to_t(const struct dram_para *para, int nanoseconds)
 {
-	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
+	const unsigned int ctrl_freq = para->clk / 2;
 
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
-void mctl_set_timing_params(const struct dram_para *para);
+extern const struct h616_dram_backend h616_ddr3_backend;
+extern const struct h616_dram_backend h616_lpddr3_backend;
+extern const struct h616_dram_backend h616_lpddr4_backend;
+
+const struct h616_dram_backend *h616_get_dram_backend(const struct dram_para *para);
 
 #endif /* _SUNXI_DRAM_SUN50I_H616_H */
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..9d6493bd3e5 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -62,7 +62,43 @@ config DRAM_SUN55I_A523
 	help
 	  Select this DRAM controller driver for A523/T527 SoCs.
 
-if DRAM_SUN50I_H616 || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
+if DRAM_SUN50I_H616
+choice
+	prompt "H616 DRAM profile source"
+	default SUNXI_DRAM_H616_FIXED_PROFILE
+	help
+	  Select whether SPL uses the fixed H616 Kconfig DRAM settings or
+	  loads an H616 DRAM profile from the device tree at boot.
+
+config SUNXI_DRAM_H616_FIXED_PROFILE
+	bool "Fixed build-time DRAM profile"
+	help
+	  Use a single H616 DRAM profile selected at build time.
+	  This keeps the existing Kconfig-based timing selection flow.
+
+config SUNXI_DRAM_H616_GPIO_SELECT
+	bool "GPIO-selected DRAM profile"
+	select GPIO
+	select OF_CONTROL
+	select SPL_OF_CONTROL
+	select SPL_GPIO
+	help
+	  Enable runtime H616 DRAM profile selection using GPIO strap bits
+	  described in the U-Boot device tree.
+
+	  SPL reads the allwinner,dram-coding-gpios property from the
+	  /dram-profiles node, decodes up to four strap bits into a profile
+	  ID, and loads the matching profile from /dram-profiles instead of
+	  using a fixed build-time H616 DRAM profile.
+
+	  Each profile must either provide the H616 DRAM parameters used by
+	  the driver directly or reference a shared parameter node with the
+	  allwinner,dram-params phandle property. Supported dram-type values
+	  are DDR3, LPDDR3, and LPDDR4.
+endchoice
+endif
+
+if (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
 config DRAM_SUNXI_DX_ODT
 	hex "DRAM DX ODT parameter"
 	help
@@ -608,6 +644,7 @@ config SUNXI_DRAM_DDR4
 
 choice
 	prompt "DRAM Type and Timing"
+	depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
 	default SUNXI_DRAM_A523_LPDDR4 if MACH_SUN55I_A523
 	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
 	default SUNXI_DRAM_DDR2_V3S if MACH_SUN8I_V3S
@@ -647,7 +684,8 @@ config SUNXI_DRAM_H6_DDR3_1333
 config SUNXI_DRAM_H616_LPDDR3
 	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
 	select SUNXI_DRAM_LPDDR3
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the LPDDR3 timing used by the stock boot0 by
 	  Allwinner.
@@ -655,7 +693,8 @@ config SUNXI_DRAM_H616_LPDDR3
 config SUNXI_DRAM_H616_LPDDR4
 	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
 	select SUNXI_DRAM_LPDDR4
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the LPDDR4 timing used by the stock boot0 by
 	  Allwinner.
@@ -663,7 +702,8 @@ config SUNXI_DRAM_H616_LPDDR4
 config SUNXI_DRAM_H616_DDR3_1333
 	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
 	select SUNXI_DRAM_DDR3
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the DDR3 timing used by the boot0 on H616 TV boxes
 	  which use a DDR3-1333 timing.
@@ -719,6 +759,7 @@ config DRAM_TYPE
 
 config DRAM_CLK
 	int "sunxi dram clock speed"
+	depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
 	default 792 if MACH_SUN9I
 	default 648 if MACH_SUN8I_R40
 	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..beedf349799 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -15,6 +15,16 @@
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
+
+#define H616_GPIO_SELECT_ENABLED	IS_ENABLED(CONFIG_SUNXI_DRAM_H616_GPIO_SELECT)
+
+#if H616_GPIO_SELECT_ENABLED
+#include <asm-generic/gpio.h>
+#include <asm/global_data.h>
+#include <errno.h>
+#include <sunxi_gpio.h>
+#include <linux/libfdt.h>
+#endif
 #include <asm/arch/clock.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/dram_dw_helpers.h>
@@ -23,6 +33,12 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
+#define H616_DRAM_STRAP_GPIO_COUNT	4
+
+#if H616_GPIO_SELECT_ENABLED
+DECLARE_GLOBAL_DATA_PTR;
+#endif
+
 enum {
 	MBUS_QOS_LOWEST = 0,
 	MBUS_QOS_LOW,
@@ -227,47 +243,9 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-#ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
-	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
-	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
-	0x06, 0x09, 0x0f
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
-	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
-	0x08, 0x01, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
-	0x18, 0x04, 0x1a
-#endif
-};
-#else /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
-	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
-	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
-	0x09, 0x05, 0x18
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
-	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
-	0x17, 0x19, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
-	0x18, 0x03, 0x1a
-#endif
-};
-#endif /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
 #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
-static void mctl_phy_configure_odt(const struct dram_para *para)
+static void mctl_phy_configure_odt(const struct dram_para *para,
+				   const struct h616_dram_phy_cfg *phy_cfg)
 {
 	uint32_t val_lo, val_hi;
 
@@ -276,7 +254,7 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	 * usually found in LPDDR4 bootloaders. Therefore, we will leave
 	 * only for this type of memory.
 	 */
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
+	if (phy_cfg->set_lpddr4_dx_odt_mode) {
 		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x390, BIT(5), BIT(4));
 		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3d0, BIT(5), BIT(4));
 		clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x410, BIT(5), BIT(4));
@@ -284,7 +262,7 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	}
 
 	val_lo = para->dx_dri;
-	val_hi = (para->type == SUNXI_DRAM_TYPE_LPDDR4) ? 0x04040404 : para->dx_dri;
+	val_hi = phy_cfg->dx_dri_hi;
 	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x388);
 	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x38c);
 	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c8);
@@ -301,8 +279,8 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x348);
 	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x34c);
 
-	val_lo = (para->type == SUNXI_DRAM_TYPE_LPDDR3) ? 0 : para->dx_odt;
-	val_hi = (para->type == SUNXI_DRAM_TYPE_LPDDR4) ? 0 : para->dx_odt;
+	val_lo = phy_cfg->dx_odt_lo;
+	val_hi = phy_cfg->dx_odt_hi;
 	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x380);
 	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x384);
 	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c0);
@@ -315,7 +293,7 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
 	dmb();
 }
 
-static bool mctl_phy_write_leveling(const struct dram_para *para,
+static bool mctl_phy_write_leveling(const struct h616_dram_phy_cfg *phy_cfg,
 				    const struct dram_config *config)
 {
 	bool result = true;
@@ -323,14 +301,8 @@ static bool mctl_phy_write_leveling(const struct dram_para *para,
 
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
 
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
-		/* MR2 value */
-		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
-		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
-	} else {
-		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
-		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
-	}
+	writel(phy_cfg->write_leveling_reg0c, SUNXI_DRAM_PHY0_BASE + 0xc);
+	writel(phy_cfg->write_leveling_reg10, SUNXI_DRAM_PHY0_BASE + 0x10);
 
 	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
 
@@ -437,14 +409,14 @@ static bool mctl_phy_read_calibration(const struct dram_config *config)
 	return result;
 }
 
-static bool mctl_phy_read_training(const struct dram_para *para,
-			   const struct dram_config *config)
+static bool mctl_phy_read_training(const struct h616_dram_phy_cfg *phy_cfg,
+				   const struct dram_config *config)
 {
 	u32 val1, val2, *ptr1, *ptr2;
 	bool result = true;
 	int i;
 
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
+	if (phy_cfg->clear_read_training_regs) {
 		writel(0, SUNXI_DRAM_PHY0_BASE + 0x800);
 		writel(0, SUNXI_DRAM_PHY0_BASE + 0x81c);
 	}
@@ -620,7 +592,8 @@ static bool mctl_phy_write_training(const struct dram_config *config)
 	return result;
 }
 
-static void mctl_phy_bit_delay_compensation(const struct dram_para *para)
+static void mctl_phy_bit_delay_compensation(const struct dram_para *para,
+					    const struct h616_dram_phy_cfg *phy_cfg)
 {
 	u32 *ptr, val;
 	int i;
@@ -629,7 +602,7 @@ static void mctl_phy_bit_delay_compensation(const struct dram_para *para)
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 1);
 		setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 8);
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x190, 0x10);
-		if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+		if (phy_cfg->clear_phy_ctl_0x4_80)
 			clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4, 0x80);
 
 		if (para->tpr10 & BIT(30))
@@ -823,10 +796,13 @@ static void mctl_phy_bit_delay_compensation(const struct dram_para *para)
 	}
 }
 
-static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
-					       const struct dram_config *config)
+static void
+mctl_phy_ca_bit_delay_compensation(const struct h616_dram_backend *backend,
+				   const struct dram_para *para,
+				   const struct dram_config *config)
 {
-	u32 val, *ptr;
+	u32 val;
+	u32 *ptr;
 	int i;
 
 	if (para->tpr0 & BIT(30))
@@ -845,73 +821,25 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
 	writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f4);
 
 	val = (para->tpr10 >> 7) & 0x1e;
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		if (para->tpr2 & 1) {
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
-			if (config->ranks == 2) {
-				val = (para->tpr10 >> 11) & 0x1e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e4);
-			}
-			if (para->tpr0 & BIT(31)) {
-				val = (para->tpr0 << 1) & 0x3e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x790);
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7cc);
-			}
-		} else {
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7d4);
-			if (config->ranks == 2) {
-				val = (para->tpr10 >> 11) & 0x1e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x79c);
-			}
-			if (para->tpr0 & BIT(31)) {
-				val = (para->tpr0 << 1) & 0x3e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x78c);
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a4);
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
-			}
-		}
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		if (para->tpr2 & 1) {
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a0);
-			if (config->ranks == 2) {
-				val = (para->tpr10 >> 11) & 0x1e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x79c);
-			}
-		} else {
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e8);
-			if (config->ranks == 2) {
-				val = (para->tpr10 >> 11) & 0x1e;
-				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f8);
-			}
-		}
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
-		if (config->ranks == 2) {
-			val = (para->tpr10 >> 11) & 0x1e;
-			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
-		};
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
+	backend->ca_bit_delay_compensation(para, config, val);
 }
 
-static bool mctl_phy_init(const struct dram_para *para,
+static bool mctl_phy_init(const struct h616_dram_backend *backend,
+			  const struct dram_para *para,
 			  const struct dram_config *config)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-	u32 val, val2, *ptr, mr0, mr2;
+	struct h616_dram_phy_cfg phy_cfg;
+	const u8 *phy_init = backend->get_phy_init();
+	u32 val, *ptr;
 	int i;
 
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+	backend->get_phy_cfg(para, &phy_cfg);
+
+	if (phy_cfg.clear_phy_ctl_0x4_80)
 		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4,0x80);
 
 	if (config->bus_full_width)
@@ -920,91 +848,33 @@ static bool mctl_phy_init(const struct dram_para *para,
 		val = 3;
 	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3c, 0xf, val);
 
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		if (para->tpr2 & 0x100) {
-			val = 9;
-			val2 = 7;
-		} else {
-			val = 13;
-			val2 = 9;
-		}
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		if (para->tpr2 & 0x100) {
-			val = 12;
-			val2 = 6;
-		} else {
-			val = 14;
-			val2 = 8;
-		}
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		val = 20;
-		val2 = 10;
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
-
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x14);
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x35c);
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x368);
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x374);
+	writel(phy_cfg.training_reg14, SUNXI_DRAM_PHY0_BASE + 0x14);
+	writel(phy_cfg.training_reg14, SUNXI_DRAM_PHY0_BASE + 0x35c);
+	writel(phy_cfg.training_reg14, SUNXI_DRAM_PHY0_BASE + 0x368);
+	writel(phy_cfg.training_reg14, SUNXI_DRAM_PHY0_BASE + 0x374);
 
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x18);
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x360);
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x36c);
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x378);
 
-	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x1c);
-	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x364);
-	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x370);
-	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
+	writel(phy_cfg.training_reg1c, SUNXI_DRAM_PHY0_BASE + 0x1c);
+	writel(phy_cfg.training_reg1c, SUNXI_DRAM_PHY0_BASE + 0x364);
+	writel(phy_cfg.training_reg1c, SUNXI_DRAM_PHY0_BASE + 0x370);
+	writel(phy_cfg.training_reg1c, SUNXI_DRAM_PHY0_BASE + 0x37c);
 
 	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
-	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
+	for (i = 0; i < H616_PHY_INIT_LEN; i++)
 		writel(phy_init[i], &ptr[i]);
 
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
-		mctl_phy_ca_bit_delay_compensation(para, config);
+		mctl_phy_ca_bit_delay_compensation(backend, para, config);
 
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		val = para->tpr6 & 0xff;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = para->tpr6 >> 8 & 0xff;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		val = para->tpr6 >> 24 & 0xff;
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
+	writel(phy_cfg.tpr6_val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
+	writel(phy_cfg.tpr6_val, SUNXI_DRAM_PHY0_BASE + 0x45c);
 
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
-	writel(val, SUNXI_DRAM_PHY0_BASE + 0x45c);
-
-	mctl_phy_configure_odt(para);
-
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		val = 0x0a;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = 0x0b;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		val = 0x0d;
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
-	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x7, val);
+	mctl_phy_configure_odt(para, &phy_cfg);
+	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x7, phy_cfg.phy_mode);
 
 	if (para->clk <= 672)
 		writel(0xf, SUNXI_DRAM_PHY0_BASE + 0x20);
@@ -1052,97 +922,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(1, &mctl_ctl->swctl);
 	mctl_await_completion(&mctl_ctl->swstat, 1, 1);
 
-	if (para->tpr2 & 0x100) {
-		mr0 = 0x1b50;
-		mr2 = 0x10;
-	} else {
-		mr0 = 0x1f14;
-		mr2 = 0x20;
-	}
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		writel(mr0, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(4, &mctl_ctl->mrctrl1);
-		writel(0x80001030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(mr2, &mctl_ctl->mrctrl1);
-		writel(0x80002030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0, &mctl_ctl->mrctrl1);
-		writel(0x80003030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		/* MR0 is read-only */
-		/* MR1: nWR=14, BL8 */
-		writel(0x183, &mctl_ctl->mrctrl1);
-		writel(0x800000f0, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		/* MR2: no WR leveling, WL set A, use nWR>9, nRL=14/nWL=8 */
-		writel(0x21c, &mctl_ctl->mrctrl1);
-		writel(0x800000f0, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		/* MR3: 34.3 Ohm pull-up/pull-down resistor */
-		writel(0x301, &mctl_ctl->mrctrl1);
-		writel(0x800000f0, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		writel(0x0, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0x134, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0x21b, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0x333, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0x403, &mctl_ctl->mrctrl1);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0xb04, &mctl_ctl->mrctrl1);
-		udelay(10);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		udelay(10);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0xc72, &mctl_ctl->mrctrl1);
-		udelay(10);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		udelay(10);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0xe09, &mctl_ctl->mrctrl1);
-		udelay(10);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		udelay(10);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-
-		writel(0x1624, &mctl_ctl->mrctrl1);
-		udelay(10);
-		writel(0x80000030, &mctl_ctl->mrctrl0);
-		udelay(10);
-		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
+	backend->program_mode_registers(para, mctl_ctl);
 
 	writel(0, SUNXI_DRAM_PHY0_BASE + 0x54);
 
@@ -1152,7 +932,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 
 	if (para->tpr10 & TPR10_WRITE_LEVELING) {
 		for (i = 0; i < 5; i++)
-			if (mctl_phy_write_leveling(para, config))
+			if (mctl_phy_write_leveling(&phy_cfg, config))
 				break;
 		if (i == 5) {
 			debug("write leveling failed!\n");
@@ -1172,7 +952,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 
 	if (para->tpr10 & TPR10_READ_TRAINING) {
 		for (i = 0; i < 5; i++)
-			if (mctl_phy_read_training(para, config))
+			if (mctl_phy_read_training(&phy_cfg, config))
 				break;
 		if (i == 5) {
 			debug("read training failed!\n");
@@ -1190,14 +970,15 @@ static bool mctl_phy_init(const struct dram_para *para,
 		}
 	}
 
-	mctl_phy_bit_delay_compensation(para);
+	mctl_phy_bit_delay_compensation(para, &phy_cfg);
 
 	clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x60, 4);
 
 	return true;
 }
 
-static bool mctl_ctrl_init(const struct dram_para *para,
+static bool mctl_ctrl_init(const struct h616_dram_backend *backend,
+			   const struct dram_para *para,
 			   const struct dram_config *config)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
@@ -1211,7 +992,7 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 
 	setbits_le32(&mctl_com->unk_0x008, 0xff00);
 
-	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
+	if (backend->set_com_ctl_0x50)
 		writel(1, SUNXI_DRAM_COM_BASE + 0x50);
 	clrsetbits_le32(&mctl_ctl->sched[0], 0xff00, 0x3000);
 
@@ -1220,20 +1001,7 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	setbits_le32(&mctl_com->unk_0x008, 0xff00);
 
 	reg_val = MSTR_ACTIVE_RANKS(config->ranks);
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		reg_val |= MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		reg_val |= MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_LPDDR3;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		reg_val |= MSTR_BURST_LENGTH(16) | MSTR_DEVICETYPE_LPDDR4;
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
+	reg_val |= backend->mstr_flags;
 	if (config->bus_full_width)
 		reg_val |= MSTR_BUSWIDTH_FULL;
 	else
@@ -1245,20 +1013,7 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	else
 		writel(0x0201, &mctl_ctl->odtmap);
 
-	switch (para->type) {
-	case SUNXI_DRAM_TYPE_DDR3:
-		reg_val = 0x06000400;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR3:
-		reg_val = 0x09020400;
-		break;
-	case SUNXI_DRAM_TYPE_LPDDR4:
-		reg_val = 0x04000400;
-		break;
-	case SUNXI_DRAM_TYPE_DDR4:
-	default:
-		panic("This DRAM setup is currently not supported.\n");
-	};
+	reg_val = backend->odtcfg;
 	writel(reg_val, &mctl_ctl->odtcfg);
 	writel(reg_val, &mctl_ctl->unk_0x2240);
 	writel(reg_val, &mctl_ctl->unk_0x3240);
@@ -1268,7 +1023,7 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 
 	mctl_set_addrmap(config);
 
-	mctl_set_timing_params(para);
+	backend->set_timing_params(para);
 
 	writel(0, &mctl_ctl->pwrctl);
 
@@ -1294,7 +1049,7 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	setbits_le32(&mctl_com->unk_0x500, BIT(24));
 	udelay(1);
 
-	if (!mctl_phy_init(para, config))
+	if (!mctl_phy_init(backend, para, config))
 		return false;
 
 	writel(0, &mctl_ctl->swctl);
@@ -1311,41 +1066,316 @@ static bool mctl_ctrl_init(const struct dram_para *para,
 	return true;
 }
 
+static bool h616_mctl_core_init(const struct dram_para *para,
+				const struct h616_dram_backend *backend,
+				const struct dram_config *config)
+{
+	mctl_sys_init(para->clk);
+
+	return mctl_ctrl_init(backend, para, config);
+}
+
 bool mctl_core_init(const struct dram_para *para,
 		    const struct dram_config *config)
 {
-	mctl_sys_init(para->clk);
+	return h616_mctl_core_init(para, h616_get_dram_backend(para), config);
+}
+
+#if H616_GPIO_SELECT_ENABLED
+static int h616_fdt_read_u32(const void *blob, int node, const char *prop_name,
+			     u32 *val)
+{
+	const fdt32_t *prop;
+	int len;
+
+	prop = fdt_getprop(blob, node, prop_name, &len);
+	if (!prop || len != sizeof(*prop))
+		return -EINVAL;
+
+	*val = fdt32_to_cpu(*prop);
+
+	return 0;
+}
+
+static int h616_fdt_read_phandle_node(const void *blob, int node,
+				      const char *prop_name, int *target_node)
+{
+	const fdt32_t *prop;
+	int len;
+
+	prop = fdt_getprop(blob, node, prop_name, &len);
+	if (!prop)
+		return -ENOENT;
+	if (len != sizeof(*prop))
+		return -EINVAL;
+
+	*target_node = fdt_node_offset_by_phandle(blob, fdt32_to_cpu(*prop));
+
+	return *target_node < 0 ? *target_node : 0;
+}
+
+static int h616_get_strap_gpio(u32 bank, u32 pin)
+{
+	if (pin >= SUNXI_GPIOS_PER_BANK)
+		return -EINVAL;
+
+	switch (bank) {
+	case SUNXI_GPIO_A:
+		return SUNXI_GPA(pin);
+	case SUNXI_GPIO_B:
+		return SUNXI_GPB(pin);
+	case SUNXI_GPIO_C:
+		return SUNXI_GPC(pin);
+	case SUNXI_GPIO_D:
+		return SUNXI_GPD(pin);
+	case SUNXI_GPIO_E:
+		return SUNXI_GPE(pin);
+	case SUNXI_GPIO_F:
+		return SUNXI_GPF(pin);
+	case SUNXI_GPIO_G:
+		return SUNXI_GPG(pin);
+	case SUNXI_GPIO_H:
+		return SUNXI_GPH(pin);
+	case SUNXI_GPIO_I:
+		return SUNXI_GPI(pin);
+	case SUNXI_GPIO_L:
+		return SUNXI_GPL(pin);
+	case SUNXI_GPIO_M:
+		return SUNXI_GPM(pin);
+	case SUNXI_GPIO_N:
+		return SUNXI_GPN(pin);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int h616_fdt_get_gpio_spec(const void *blob, int node,
+				  const char *prop_name, int index,
+				  u32 *bank, u32 *pin)
+{
+	const fdt32_t *prop;
+	int entries, gpio_node, i, len, pos;
+	u32 cells, phandle;
+
+	prop = fdt_getprop(blob, node, prop_name, &len);
+	if (!prop)
+		return -ENOENT;
+	if (len % sizeof(*prop))
+		return -EINVAL;
+
+	entries = len / sizeof(*prop);
+	for (i = 0, pos = 0; pos < entries; i++) {
+		phandle = fdt32_to_cpu(prop[pos++]);
+		if (!phandle)
+			break;
+
+		gpio_node = fdt_node_offset_by_phandle(blob, phandle);
+		if (gpio_node < 0)
+			return gpio_node;
+		if (h616_fdt_read_u32(blob, gpio_node, "#gpio-cells", &cells))
+			return -EINVAL;
+		if (cells < 2 || pos + cells > entries)
+			return -EINVAL;
+
+		if (i == index) {
+			*bank = fdt32_to_cpu(prop[pos]);
+			*pin = fdt32_to_cpu(prop[pos + 1]);
+			return 0;
+		}
 
-	return mctl_ctrl_init(para, config);
+		pos += cells;
+	}
+
+	return -ENOENT;
+}
+
+static int h616_parse_dram_para(const void *blob, int node,
+				struct dram_para *para)
+{
+	int params_node;
+	int ret;
+	u32 val;
+
+	params_node = node;
+	ret = h616_fdt_read_phandle_node(blob, node, "allwinner,dram-params",
+					 &params_node);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,dram-clk",
+			      &para->clk))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,dram-type", &val))
+		return -EINVAL;
+
+	switch (val) {
+	case SUNXI_DRAM_TYPE_DDR3:
+	case SUNXI_DRAM_TYPE_LPDDR3:
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		para->type = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,dx-odt",
+			      &para->dx_odt))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,dx-dri",
+			      &para->dx_dri))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,ca-dri",
+			      &para->ca_dri))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,odt-en",
+			      &para->odt_en))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr0",
+			      &para->tpr0))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr2",
+			      &para->tpr2))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr6",
+			      &para->tpr6))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr10",
+			      &para->tpr10))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr11",
+			      &para->tpr11))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, params_node, "allwinner,tpr12",
+			      &para->tpr12))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int h616_load_dram_profile(u32 profile_id, struct dram_para *para)
+{
+	const void *blob = gd->fdt_blob;
+	int node, profiles;
+	u32 reg;
+
+	profiles = fdt_path_offset(blob, "/dram-profiles");
+	if (profiles < 0)
+		return profiles;
+
+	for (node = fdt_first_subnode(blob, profiles);
+	     node >= 0;
+	     node = fdt_next_subnode(blob, node)) {
+		if (h616_fdt_read_u32(blob, node, "reg", &reg))
+			continue;
+		if (reg != profile_id)
+			continue;
+
+		return h616_parse_dram_para(blob, node, para);
+	}
+
+	return -ENOENT;
 }
 
-static const struct dram_para para = {
-	.clk = CONFIG_DRAM_CLK,
+static int h616_get_dram_profile_id(u32 *profile_id)
+{
+	const void *blob = gd->fdt_blob;
+	int gpio, i, profiles, ret, value;
+	u32 bank, pin;
+
+	profiles = fdt_path_offset(blob, "/dram-profiles");
+	if (profiles < 0)
+		return profiles;
+
+	*profile_id = 0;
+	for (i = 0; i < H616_DRAM_STRAP_GPIO_COUNT; i++) {
+		ret = h616_fdt_get_gpio_spec(blob, profiles,
+					     "allwinner,dram-coding-gpios",
+					     i, &bank, &pin);
+		if (ret == -ENOENT)
+			return i ? 0 : -ENOENT;
+		if (ret)
+			return ret;
+
+		gpio = h616_get_strap_gpio(bank, pin);
+		if (gpio < 0)
+			return gpio;
+
+		ret = gpio_request(gpio, "h616_dram_sel");
+		if (ret)
+			return ret;
+
+		ret = gpio_direction_input(gpio);
+		if (ret) {
+			gpio_free(gpio);
+			return ret;
+		}
+
+		value = gpio_get_value(gpio);
+		gpio_free(gpio);
+		if (value < 0)
+			return value;
+
+		*profile_id |= !!value << i;
+	}
+
+	return 0;
+}
+
+static void h616_get_dram_para(struct dram_para *para)
+{
+	u32 profile_id;
+	int ret;
+
+	ret = h616_get_dram_profile_id(&profile_id);
+	if (ret)
+		panic("H616 GPIO DRAM profile selection could not determine a profile\n");
+
+	ret = h616_load_dram_profile(profile_id, para);
+	if (ret)
+		panic("H616 GPIO DRAM profile selection failed to load profile %u\n",
+		      profile_id);
+}
+#else
+static enum sunxi_dram_type h616_get_fixed_dram_type(void)
+{
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	.type = SUNXI_DRAM_TYPE_DDR3,
+	return SUNXI_DRAM_TYPE_DDR3;
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	.type = SUNXI_DRAM_TYPE_LPDDR3,
+	return SUNXI_DRAM_TYPE_LPDDR3;
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	.type = SUNXI_DRAM_TYPE_LPDDR4,
+	return SUNXI_DRAM_TYPE_LPDDR4;
+#endif
+	panic("No fixed H616 DRAM type selected\n");
+}
+
+static void h616_get_dram_para(struct dram_para *para)
+{
+	*para = (struct dram_para) {
+		.clk = CONFIG_DRAM_CLK,
+		.type = h616_get_fixed_dram_type(),
+		.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
+		.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
+		.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
+		.odt_en = CONFIG_DRAM_SUNXI_ODT_EN,
+		.tpr0 = CONFIG_DRAM_SUNXI_TPR0,
+		.tpr2 = CONFIG_DRAM_SUNXI_TPR2,
+		.tpr6 = CONFIG_DRAM_SUNXI_TPR6,
+		.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
+		.tpr11 = CONFIG_DRAM_SUNXI_TPR11,
+		.tpr12 = CONFIG_DRAM_SUNXI_TPR12,
+	};
+}
 #endif
-	.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
-	.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
-	.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
-	.odt_en = CONFIG_DRAM_SUNXI_ODT_EN,
-	.tpr0 = CONFIG_DRAM_SUNXI_TPR0,
-	.tpr2 = CONFIG_DRAM_SUNXI_TPR2,
-	.tpr6 = CONFIG_DRAM_SUNXI_TPR6,
-	.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
-	.tpr11 = CONFIG_DRAM_SUNXI_TPR11,
-	.tpr12 = CONFIG_DRAM_SUNXI_TPR12,
-};
 
 unsigned long sunxi_dram_init(void)
 {
 	void *const prcm = (void *)SUNXI_PRCM_BASE;
+	struct dram_para para;
 	struct dram_config config;
 	unsigned long size;
 
+	h616_get_dram_para(&para);
+
 	setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, BIT(8));
 	clrbits_le32(prcm + CCU_PRCM_OHMS240, 0x3f);
 
diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-sunxi/dram_timings/Makefile
index 5de9fd5aab4..6843b9d323e 100644
--- a/arch/arm/mach-sunxi/dram_timings/Makefile
+++ b/arch/arm/mach-sunxi/dram_timings/Makefile
@@ -3,6 +3,10 @@ obj-$(CONFIG_SUNXI_DRAM_LPDDR3_STOCK)	+= lpddr3_stock.o
 obj-$(CONFIG_SUNXI_DRAM_DDR2_V3S)	+= ddr2_v3s.o
 obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)	+= h6_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
+obj-$(CONFIG_DRAM_SUN50I_H616)		+= h616.o
+obj-$(CONFIG_SUNXI_DRAM_H616_GPIO_SELECT)	+= h616_ddr3_1333.o
+obj-$(CONFIG_SUNXI_DRAM_H616_GPIO_SELECT)	+= h616_lpddr3.o
+obj-$(CONFIG_SUNXI_DRAM_H616_GPIO_SELECT)	+= h616_lpddr4_2133.o
 obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
 obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
diff --git a/arch/arm/mach-sunxi/dram_timings/h616.c b/arch/arm/mach-sunxi/dram_timings/h616.c
new file mode 100644
index 00000000000..10d7858a71d
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_timings/h616.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * sun50i H616 DRAM backend dispatcher
+ *
+ * Select the appropriate H616 DRAM backend at compile time for fixed-profile
+ * builds and at runtime when GPIO profile selection is enabled.
+ */
+
+#include <asm/arch/dram.h>
+#include <vsprintf.h>
+
+const struct h616_dram_backend *h616_get_dram_backend(const struct dram_para *para)
+{
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_GPIO_SELECT)) {
+		switch (para->type) {
+		case SUNXI_DRAM_TYPE_DDR3:
+			return &h616_ddr3_backend;
+		case SUNXI_DRAM_TYPE_LPDDR3:
+			return &h616_lpddr3_backend;
+		case SUNXI_DRAM_TYPE_LPDDR4:
+			return &h616_lpddr4_backend;
+		case SUNXI_DRAM_TYPE_DDR4:
+		default:
+			panic("Unsupported H616 DRAM type: %u\n", para->type);
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_DDR3_1333))
+		return &h616_ddr3_backend;
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_LPDDR3))
+		return &h616_lpddr3_backend;
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_LPDDR4))
+		return &h616_lpddr4_backend;
+
+	panic("No H616 DRAM backend selected\n");
+	return NULL;
+}
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd97..96dc23964bc 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -14,33 +14,55 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+static const u8 h616_ddr3_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
+	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
+	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
+	0x09, 0x05, 0x18
+};
+
+static const u8 h616_ddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
+	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
+	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
+	0x06, 0x09, 0x0f
+};
+
+static const u8 *h616_ddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_ddr3_phy_init_addr_map_1;
+
+	return h616_ddr3_phy_init_default;
+}
+
+static void h616_ddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 2;			/* JEDEC: 4nCK */
-	u8 tfaw		= ns_to_t(50);		/* JEDEC: 30 ns w/ 1K pages */
-	u8 trrd		= max(ns_to_t(6), 4);	/* JEDEC: max(6 ns, 4nCK) */
-	u8 trcd		= ns_to_t(15);		/* JEDEC: 13.5 ns */
-	u8 trc		= ns_to_t(53);		/* JEDEC: 49.5 ns */
-	u8 txp		= max(ns_to_t(6), 3);	/* JEDEC: max(6 ns, 3nCK) */
-	u8 trtp		= max(ns_to_t(8), 2);	/* JEDEC: max(7.5 ns, 4nCK) */
-	u8 trp		= ns_to_t(15);		/* JEDEC: >= 13.75 ns */
-	u8 tras		= ns_to_t(38);		/* JEDEC >= 36 ns, <= 9*trefi */
-	u16 trefi	= ns_to_t(7800) / 32;	/* JEDEC: 7.8us@Tcase <= 85C */
-	u16 trfc	= ns_to_t(350);		/* JEDEC: 160 ns for 2Gb */
+	u8 tfaw		= h616_ns_to_t(para, 50);    /* JEDEC: 30 ns w/ 1K pages */
+	u8 trrd		= max(h616_ns_to_t(para, 6), 4); /* JEDEC: max(6 ns, 4nCK) */
+	u8 trcd		= h616_ns_to_t(para, 15);    /* JEDEC: 13.5 ns */
+	u8 trc		= h616_ns_to_t(para, 53);    /* JEDEC: 49.5 ns */
+	u8 txp		= max(h616_ns_to_t(para, 6), 3); /* JEDEC: max(6 ns, 3nCK) */
+	u8 trtp		= max(h616_ns_to_t(para, 8), 2); /* JEDEC: max(7.5 ns, 4nCK) */
+	u8 trp		= h616_ns_to_t(para, 15);    /* JEDEC: >= 13.75 ns */
+	u8 tras		= h616_ns_to_t(para, 38);    /* JEDEC >= 36 ns, <= 9*trefi */
+	u16 trefi	= h616_ns_to_t(para, 7800) / 32; /* JEDEC: 7.8us@Tcase <= 85C */
+	u16 trfc	= h616_ns_to_t(para, 350);   /* JEDEC: 160 ns for 2Gb */
 	u16 txsr	= 4;			/* ? */
 
 	u8 tmrw		= 0;			/* ? */
 	u8 tmrd		= 4;			/* JEDEC: 4nCK */
-	u8 tmod		= max(ns_to_t(15), 12);	/* JEDEC: max(15 ns, 12nCK) */
-	u8 tcke		= max(ns_to_t(6), 3);	/* JEDEC: max(5.625 ns, 3nCK) */
-	u8 tcksrx	= max(ns_to_t(10), 4);	/* JEDEC: max(10 ns, 5nCK) */
-	u8 tcksre	= max(ns_to_t(10), 4);	/* JEDEC: max(10 ns, 5nCK) */
+	u8 tmod		= max(h616_ns_to_t(para, 15), 12); /* JEDEC: max(15 ns, 12nCK) */
+	u8 tcke		= max(h616_ns_to_t(para, 6), 3);   /* JEDEC: max(5.625 ns, 3nCK) */
+	u8 tcksrx	= max(h616_ns_to_t(para, 10), 4);  /* JEDEC: max(10 ns, 5nCK) */
+	u8 tcksre	= max(h616_ns_to_t(para, 10), 4);  /* JEDEC: max(10 ns, 5nCK) */
 	u8 tckesr	= tcke + 1;		/* JEDEC: tCKE(min) + 1nCK */
 	u8 trasmax	= (para->clk / 2) / 15;	/* JEDEC: tREFI * 9 */
-	u8 txs		= ns_to_t(360) / 32;	/* JEDEC: max(5nCK,tRFC+10ns) */
+	u8 txs		= h616_ns_to_t(para, 360) / 32; /* JEDEC: max(5nCK,tRFC+10ns) */
 	u8 txsdll	= 16;			/* JEDEC: 512 nCK */
 	u8 txsabort	= 4;			/* ? */
 	u8 txsfast	= 4;			/* ? */
@@ -103,3 +125,98 @@ void mctl_set_timing_params(const struct dram_para *para)
 	/* set refresh timing */
 	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
 }
+
+static void h616_ddr3_get_phy_cfg(const struct dram_para *para,
+				  struct h616_dram_phy_cfg *phy_cfg)
+{
+	if (para->tpr2 & 0x100) {
+		phy_cfg->training_reg14 = 9;
+		phy_cfg->training_reg1c = 7;
+	} else {
+		phy_cfg->training_reg14 = 13;
+		phy_cfg->training_reg1c = 9;
+	}
+
+	phy_cfg->write_leveling_reg0c = 4;
+	phy_cfg->write_leveling_reg10 = 0x40;
+	phy_cfg->dx_dri_hi = para->dx_dri;
+	phy_cfg->dx_odt_lo = para->dx_odt;
+	phy_cfg->dx_odt_hi = para->dx_odt;
+	phy_cfg->tpr6_val = para->tpr6 & 0xff;
+	phy_cfg->phy_mode = 0x0a;
+	phy_cfg->clear_phy_ctl_0x4_80 = false;
+	phy_cfg->set_lpddr4_dx_odt_mode = false;
+	phy_cfg->clear_read_training_regs = false;
+}
+
+static void h616_ddr3_program_mode_registers(const struct dram_para *para,
+					     struct sunxi_mctl_ctl_reg *mctl_ctl)
+{
+	u32 mr0, mr2;
+
+	if (para->tpr2 & 0x100) {
+		mr0 = 0x1b50;
+		mr2 = 0x10;
+	} else {
+		mr0 = 0x1f14;
+		mr2 = 0x20;
+	}
+
+	writel(mr0, &mctl_ctl->mrctrl1);
+	writel(0x80000030, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+	writel(4, &mctl_ctl->mrctrl1);
+	writel(0x80001030, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+	writel(mr2, &mctl_ctl->mrctrl1);
+	writel(0x80002030, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+	writel(0, &mctl_ctl->mrctrl1);
+	writel(0x80003030, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+}
+
+static void h616_ddr3_ca_bit_delay_compensation(const struct dram_para *para,
+						const struct dram_config *config,
+						u32 val)
+{
+	if (para->tpr2 & 1) {
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
+		if (config->ranks == 2) {
+			val = (para->tpr10 >> 11) & 0x1e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e4);
+		}
+		if (para->tpr0 & BIT(31)) {
+			val = (para->tpr0 << 1) & 0x3e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x790);
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7cc);
+		}
+	} else {
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x7d4);
+		if (config->ranks == 2) {
+			val = (para->tpr10 >> 11) & 0x1e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x79c);
+		}
+		if (para->tpr0 & BIT(31)) {
+			val = (para->tpr0 << 1) & 0x3e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x78c);
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a4);
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
+		}
+	}
+}
+
+const struct h616_dram_backend h616_ddr3_backend = {
+	.mstr_flags = MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE,
+	.odtcfg = 0x06000400,
+	.set_com_ctl_0x50 = false,
+	.get_phy_init = h616_ddr3_get_phy_init,
+	.set_timing_params = h616_ddr3_set_timing_params,
+	.get_phy_cfg = h616_ddr3_get_phy_cfg,
+	.program_mode_registers = h616_ddr3_program_mode_registers,
+	.ca_bit_delay_compensation = h616_ddr3_ca_bit_delay_compensation,
+};
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index ce2ffa7a020..cb5c83f0518 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -14,33 +14,55 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+static const u8 h616_lpddr3_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
+	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+	0x17, 0x19, 0x1a
+};
+
+static const u8 h616_lpddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
+	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+	0x08, 0x01, 0x1a
+};
+
+static const u8 *h616_lpddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr3_phy_init_addr_map_1;
+
+	return h616_lpddr3_phy_init_default;
+}
+
+static void h616_lpddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 2;
-	u8 tfaw		= ns_to_t(50);
-	u8 trrd		= max(ns_to_t(6), 4);
-	u8 trcd		= ns_to_t(24);
-	u8 trc		= ns_to_t(70);
-	u8 txp		= max(ns_to_t(8), 3);
-	u8 trtp		= max(ns_to_t(8), 2);
-	u8 trp		= ns_to_t(27);
-	u8 tras		= ns_to_t(41);
-	u16 trefi	= ns_to_t(7800) / 64;
-	u16 trfc	= ns_to_t(210);
+	u8 tfaw		= h616_ns_to_t(para, 50);
+	u8 trrd		= max(h616_ns_to_t(para, 6), 4);
+	u8 trcd		= h616_ns_to_t(para, 24);
+	u8 trc		= h616_ns_to_t(para, 70);
+	u8 txp		= max(h616_ns_to_t(para, 8), 3);
+	u8 trtp		= max(h616_ns_to_t(para, 8), 2);
+	u8 trp		= h616_ns_to_t(para, 27);
+	u8 tras		= h616_ns_to_t(para, 41);
+	u16 trefi	= h616_ns_to_t(para, 7800) / 64;
+	u16 trfc	= h616_ns_to_t(para, 210);
 	u16 txsr	= 88;
 
 	u8 tmrw		= 5;
 	u8 tmrd		= 5;
-	u8 tmod		= max(ns_to_t(15), 12);
-	u8 tcke		= max(ns_to_t(6), 3);
-	u8 tcksrx	= max(ns_to_t(12), 4);
-	u8 tcksre	= max(ns_to_t(12), 4);
+	u8 tmod		= max(h616_ns_to_t(para, 15), 12);
+	u8 tcke		= max(h616_ns_to_t(para, 6), 3);
+	u8 tcksrx	= max(h616_ns_to_t(para, 12), 4);
+	u8 tcksre	= max(h616_ns_to_t(para, 12), 4);
 	u8 tckesr	= tcke + 2;
 	u8 trasmax	= (para->clk / 2) / 16;
-	u8 txs		= ns_to_t(360) / 32;
+	u8 txs		= h616_ns_to_t(para, 360) / 32;
 	u8 txsdll	= 16;
 	u8 txsabort	= 4;
 	u8 txsfast	= 4;
@@ -92,3 +114,78 @@ void mctl_set_timing_params(const struct dram_para *para)
 	/* set refresh timing */
 	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
 }
+
+static void h616_lpddr3_get_phy_cfg(const struct dram_para *para,
+				    struct h616_dram_phy_cfg *phy_cfg)
+{
+	if (para->tpr2 & 0x100) {
+		phy_cfg->training_reg14 = 12;
+		phy_cfg->training_reg1c = 6;
+	} else {
+		phy_cfg->training_reg14 = 14;
+		phy_cfg->training_reg1c = 8;
+	}
+
+	phy_cfg->write_leveling_reg0c = 4;
+	phy_cfg->write_leveling_reg10 = 0x40;
+	phy_cfg->dx_dri_hi = para->dx_dri;
+	phy_cfg->dx_odt_lo = 0;
+	phy_cfg->dx_odt_hi = para->dx_odt;
+	phy_cfg->tpr6_val = (para->tpr6 >> 8) & 0xff;
+	phy_cfg->phy_mode = 0x0b;
+	phy_cfg->clear_phy_ctl_0x4_80 = false;
+	phy_cfg->set_lpddr4_dx_odt_mode = false;
+	phy_cfg->clear_read_training_regs = false;
+}
+
+static void h616_lpddr3_program_mode_registers(const struct dram_para *para,
+					       struct sunxi_mctl_ctl_reg *mctl_ctl)
+{
+	(void)para;
+
+	/* MR0 is read-only */
+	/* MR1: nWR=14, BL8 */
+	writel(0x183, &mctl_ctl->mrctrl1);
+	writel(0x800000f0, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+	/* MR2: no WR leveling, WL set A, use nWR>9, nRL=14/nWL=8 */
+	writel(0x21c, &mctl_ctl->mrctrl1);
+	writel(0x800000f0, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+
+	/* MR3: 34.3 Ohm pull-up/pull-down resistor */
+	writel(0x301, &mctl_ctl->mrctrl1);
+	writel(0x800000f0, &mctl_ctl->mrctrl0);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+}
+
+static void h616_lpddr3_ca_bit_delay_compensation(const struct dram_para *para,
+						  const struct dram_config *config,
+						  u32 val)
+{
+	if (para->tpr2 & 1) {
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a0);
+		if (config->ranks == 2) {
+			val = (para->tpr10 >> 11) & 0x1e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x79c);
+		}
+	} else {
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e8);
+		if (config->ranks == 2) {
+			val = (para->tpr10 >> 11) & 0x1e;
+			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f8);
+		}
+	}
+}
+
+const struct h616_dram_backend h616_lpddr3_backend = {
+	.mstr_flags = MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_LPDDR3,
+	.odtcfg = 0x09020400,
+	.set_com_ctl_0x50 = false,
+	.get_phy_init = h616_lpddr3_get_phy_init,
+	.set_timing_params = h616_lpddr3_set_timing_params,
+	.get_phy_cfg = h616_lpddr3_get_phy_cfg,
+	.program_mode_registers = h616_lpddr3_program_mode_registers,
+	.ca_bit_delay_compensation = h616_lpddr3_ca_bit_delay_compensation,
+};
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index 6f5c4acbd62..9b765a12047 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -11,31 +11,54 @@
 
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
+#include <linux/delay.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+static const u8 h616_lpddr4_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x03, 0x1a
+};
+
+static const u8 h616_lpddr4_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x04, 0x1a
+};
+
+static const u8 *h616_lpddr4_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr4_phy_init_addr_map_1;
+
+	return h616_lpddr4_phy_init_default;
+}
+
+static void h616_lpddr4_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 4;
-	u8 tfaw		= ns_to_t(40);
-	u8 trrd		= max(ns_to_t(10), 2);
-	u8 trcd		= max(ns_to_t(18), 2);
-	u8 trc		= ns_to_t(65);
-	u8 txp		= max(ns_to_t(8), 2);
+	u8 tfaw		= h616_ns_to_t(para, 40);
+	u8 trrd		= max(h616_ns_to_t(para, 10), 2);
+	u8 trcd		= max(h616_ns_to_t(para, 18), 2);
+	u8 trc		= h616_ns_to_t(para, 65);
+	u8 txp		= max(h616_ns_to_t(para, 8), 2);
 	u8 trtp		= 4;
-	u8 trp		= ns_to_t(21);
-	u8 tras		= ns_to_t(42);
-	u16 trefi	= ns_to_t(3904) / 32;
-	u16 trfc	= ns_to_t(280);
-	u16 txsr	= ns_to_t(190);
+	u8 trp		= h616_ns_to_t(para, 21);
+	u8 tras		= h616_ns_to_t(para, 42);
+	u16 trefi	= h616_ns_to_t(para, 3904) / 32;
+	u16 trfc	= h616_ns_to_t(para, 280);
+	u16 txsr	= h616_ns_to_t(para, 190);
 
-	u8 tmrw		= max(ns_to_t(14), 5);
+	u8 tmrw		= max(h616_ns_to_t(para, 14), 5);
 	u8 tmrd		= tmrw;
 	u8 tmod		= 12;
-	u8 tcke		= max(ns_to_t(15), 2);
-	u8 tcksrx	= max(ns_to_t(2), 2);
-	u8 tcksre	= max(ns_to_t(5), 2);
+	u8 tcke		= max(h616_ns_to_t(para, 15), 2);
+	u8 tcksrx	= max(h616_ns_to_t(para, 2), 2);
+	u8 tcksre	= max(h616_ns_to_t(para, 5), 2);
 	u8 tckesr	= tcke;
 	u8 trasmax	= (trefi * 9) / 32;
 	u8 txs		= 4;
@@ -49,7 +72,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 
 	u8 twtp		= 24;
 	u8 twr2rd	= max(trrd, (u8)4) + 14;
-	u8 trd2wr	= (ns_to_t(4) + 17) - ns_to_t(1);
+	u8 trd2wr	= (h616_ns_to_t(para, 4) + 17) - h616_ns_to_t(para, 1);
 
 	/* set DRAM timing */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
@@ -92,3 +115,68 @@ void mctl_set_timing_params(const struct dram_para *para)
 	/* set refresh timing */
 	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
 }
+
+static void h616_lpddr4_get_phy_cfg(const struct dram_para *para,
+				    struct h616_dram_phy_cfg *phy_cfg)
+{
+	phy_cfg->training_reg14 = 20;
+	phy_cfg->training_reg1c = 10;
+	phy_cfg->write_leveling_reg0c = 0x1b;
+	phy_cfg->write_leveling_reg10 = 0;
+	phy_cfg->dx_dri_hi = 0x04040404;
+	phy_cfg->dx_odt_lo = para->dx_odt;
+	phy_cfg->dx_odt_hi = 0;
+	phy_cfg->tpr6_val = (para->tpr6 >> 24) & 0xff;
+	phy_cfg->phy_mode = 0x0d;
+	phy_cfg->clear_phy_ctl_0x4_80 = true;
+	phy_cfg->set_lpddr4_dx_odt_mode = true;
+	phy_cfg->clear_read_training_regs = true;
+}
+
+static void h616_lpddr4_mr_write(struct sunxi_mctl_ctl_reg *mctl_ctl,
+				 u32 mrctrl1)
+{
+	writel(mrctrl1, &mctl_ctl->mrctrl1);
+	udelay(10);
+	writel(0x80000030, &mctl_ctl->mrctrl0);
+	udelay(10);
+	mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
+}
+
+static void h616_lpddr4_program_mode_registers(const struct dram_para *para,
+					       struct sunxi_mctl_ctl_reg *mctl_ctl)
+{
+	(void)para;
+
+	h616_lpddr4_mr_write(mctl_ctl, 0x0);
+	h616_lpddr4_mr_write(mctl_ctl, 0x134);
+	h616_lpddr4_mr_write(mctl_ctl, 0x21b);
+	h616_lpddr4_mr_write(mctl_ctl, 0x333);
+	h616_lpddr4_mr_write(mctl_ctl, 0x403);
+	h616_lpddr4_mr_write(mctl_ctl, 0xb04);
+	h616_lpddr4_mr_write(mctl_ctl, 0xc72);
+	h616_lpddr4_mr_write(mctl_ctl, 0xe09);
+	h616_lpddr4_mr_write(mctl_ctl, 0x1624);
+}
+
+static void h616_lpddr4_ca_bit_delay_compensation(const struct dram_para *para,
+						  const struct dram_config *config,
+						  u32 val)
+{
+	writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
+	if (config->ranks == 2) {
+		val = (para->tpr10 >> 11) & 0x1e;
+		writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
+	}
+}
+
+const struct h616_dram_backend h616_lpddr4_backend = {
+	.mstr_flags = MSTR_BURST_LENGTH(16) | MSTR_DEVICETYPE_LPDDR4,
+	.odtcfg = 0x04000400,
+	.set_com_ctl_0x50 = true,
+	.get_phy_init = h616_lpddr4_get_phy_init,
+	.set_timing_params = h616_lpddr4_set_timing_params,
+	.get_phy_cfg = h616_lpddr4_get_phy_cfg,
+	.program_mode_registers = h616_lpddr4_program_mode_registers,
+	.ca_bit_delay_compensation = h616_lpddr4_ca_bit_delay_compensation,
+};
-- 
2.43.0

