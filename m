Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E0110F286A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0ADC84035;
	Fri, 27 Mar 2026 21:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0AMeU1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30628394E; Fri, 27 Mar 2026 21:10:13 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B1184011
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso2056455a34.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774642208; x=1775247008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boRa9EB3nNDKSQiiSPwyuXq3dhSXlUmamQXgNWw9v7A=;
 b=M0AMeU1DLSsg7MPFRUHfpLNypWnqyE0lKHcA2iTlbsZ5ZMe9OP4enxxgIzSCQwzllS
 dL0tgj0a801ebh7FPn2ectjUFxVb5Pq2MJP9CBMvtS0ghc2NTuFHpMLn7a7qVTejIPvp
 bD/RX3qbuSoTYrwukgvDSoX5lKGTdh4E85Aex8rWTCCI8/0ERtB7nJ1KDZycKJ+ndZP9
 YykXHoLvvgcK91XHROPmclPf/AXS4p7M8NP5k7u+JXiaUQ1TUtc04OBl37Ty99tDHt2M
 iyZLggbgcgXWcbd08nwJIyFmgog5keUjibcBYkcqbOIAFT2CNXXoqv0ZqA04b5px0oml
 GQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774642208; x=1775247008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=boRa9EB3nNDKSQiiSPwyuXq3dhSXlUmamQXgNWw9v7A=;
 b=lTNKNdBeUB6Wn+BH1jfMDBrRHjLFmPeHgx7RnNcxrBdxmpKT34rSsDZysW8xSH3C9Q
 eN3T+r6p2XufQ3WynNXYc1L8jIbpKVk5NjyY8GN04SL3w22No8saHpu/1eO8RtHXT6uw
 dUrygoxk+UiED7yGjzEJfqQmiZwp8+BCxW7hwvRf4fS/IHodnTgU9vRjSBQqVDdaTp5p
 OfCJ9E1Gq/EtxwY4BcNy4HuksxJXNFgj3LuwIrQMEMnKoK2/VNtRuu2JzbvXC2RzUXlT
 jRMm90JczO45HlPtaRuprYTvYHp0BQ1+zB5dpnExP8nCux65q0R75yd/GJD7vSafMQRl
 o14w==
X-Gm-Message-State: AOJu0YzCY2yaNzVPnKAtbF5ckLpV1VmAqZrY1/4vkT9uVe8yS/JOoJY1
 Utye7EfMqEleYZlzFukO9r8zjwF77co+xED4R1FlyvatL2GdbKD2C8jyMtiOJQf7
X-Gm-Gg: ATEYQzyBwsYkd9fQoQBZtBjKJsw1JfSdZSP0yeheWn5L9KpUE9qg6eJOTs9gr+WUSWt
 IoL2YLBK1yYQH/GtwtkvW/9Wrxuf7KzwbOJeg4fjGMKowbNyvzKqKhhKbV46hWKMn5iMvD1r6oA
 vnEpMxQTJGpeXgm0E/J+81WRDYOXK4bIk5FBoewW8oTrgkQA/werAl5BMXLzozzgO24/kti8n8B
 bbqmQRp/Z6RnMUVpYztJ2bCSlbacIMnkegh2qjDd8p+2EmxQRZj0f9+/x1Xd+uMNPHbFlfUTAPm
 PHJznILEKC3MeK55QR9A1q37i1+iFzKku8o/3ODR/mBzZaQUCNniaZ4QubvoM9gkWTkXIET13oT
 rcJVJOifQvl5IcKqh5QGV2882aPY0vhogOEUq7805HBNdod4iMiyYFWOrfT7XA4KgugCfOPbfn9
 /fC1A5myqu6Q1QqrS3pEGak1H2J/sYD7jvAC57DOCk5spZujQnAbSH1/xdx4gpLArsoeDtoUOi/
 JqnAanH8G0ArM68zMGgC/dZ2pWj++XiZO1B9No+psvMvEK5Fs4jkGWAltpy
X-Received: by 2002:a05:6830:6d11:b0:7d7:b683:c279 with SMTP id
 46e09a7af769-7d9fad9b3c8mr2086326a34.3.1774642207813; 
 Fri, 27 Mar 2026 13:10:07 -0700 (PDT)
Received: from james-x399.localdomain (71-33-142-50.hlrn.qwest.net.
 [71.33.142.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b5b41sm166102a34.15.2026.03.27.13.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:10:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v4 5/5] sunxi: h616: support a default DRAM profile from the
 device tree
Date: Fri, 27 Mar 2026 14:09:16 -0600
Message-ID: <20260327200932.2016910-5-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327200932.2016910-1-james.hilliard1@gmail.com>
References: <20260327200932.2016910-1-james.hilliard1@gmail.com>
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

Add a second H616 profile source mode which loads the DRAM
parameters from /dram-profiles/default in the U-Boot device tree.

In this mode SPL builds all supported H616 timing backends and selects
the matching one from the dram-type property at boot. This provides the
simplest device-tree-driven parameter flow for boards that need runtime
selection later, while keeping the existing fixed-profile path in the
main H616 driver.

Add a small device-tree DRAM parameter loader for the default profile
and use hidden H616 backend symbols so fixed-profile mode builds one
backend while device-tree profile mode builds all of them, without
reusing the visible timing choice symbols as build plumbing. Also make
SUNXI_DRAM_FIXED_PARAMS a derived hidden symbol so the fixed H616 timing
choice and H616 fixed-parameter prompts are hidden automatically when
device-tree profiles are enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h | 31 ++++++-
 arch/arm/mach-sunxi/Kconfig                   | 78 +++++++++++++---
 arch/arm/mach-sunxi/Makefile                  |  1 +
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 55 +++++++----
 arch/arm/mach-sunxi/dram_sun50i_h616_dt.c     | 93 +++++++++++++++++++
 arch/arm/mach-sunxi/dram_timings/Makefile     |  6 +-
 6 files changed, 227 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_sun50i_h616_dt.c

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index 6dab3b4832b..9593409b465 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -170,6 +170,8 @@ struct dram_config {
 
 #define H616_PHY_INIT_LEN	27
 
+void h616_get_dram_para_dt(struct dram_para *para);
+
 static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 {
 	const unsigned int ctrl_freq = para->clk / 2;
@@ -187,6 +189,22 @@ const u8 *h616_lpddr4_get_phy_init(void);
 
 static inline void mctl_set_timing_params(const struct dram_para *para)
 {
+	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_DT_PROFILE)) {
+		switch (para->type) {
+		case SUNXI_DRAM_TYPE_DDR3:
+			h616_ddr3_set_timing_params(para);
+			return;
+		case SUNXI_DRAM_TYPE_LPDDR3:
+			h616_lpddr3_set_timing_params(para);
+			return;
+		case SUNXI_DRAM_TYPE_LPDDR4:
+			h616_lpddr4_set_timing_params(para);
+			return;
+		default:
+			return;
+		}
+	}
+
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
 	h616_ddr3_set_timing_params(para);
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
@@ -198,7 +216,18 @@ static inline void mctl_set_timing_params(const struct dram_para *para)
 
 static inline const u8 *h616_get_phy_init(const struct dram_para *para)
 {
-	(void)para;
+	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_DT_PROFILE)) {
+		switch (para->type) {
+		case SUNXI_DRAM_TYPE_DDR3:
+			return h616_ddr3_get_phy_init();
+		case SUNXI_DRAM_TYPE_LPDDR3:
+			return h616_lpddr3_get_phy_init();
+		case SUNXI_DRAM_TYPE_LPDDR4:
+			return h616_lpddr4_get_phy_init();
+		default:
+			return NULL;
+		}
+	}
 
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
 	return h616_ddr3_get_phy_init();
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..e403ef67a0b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -62,24 +62,74 @@ config DRAM_SUN55I_A523
 	help
 	  Select this DRAM controller driver for A523/T527 SoCs.
 
+if DRAM_SUN50I_H616
+choice
+	prompt "H616 DRAM profile source"
+	default SUNXI_DRAM_H616_FIXED_PROFILE
+	help
+	  Select whether SPL uses the fixed H616 Kconfig DRAM settings or
+	  loads a default H616 DRAM profile from the device tree at boot.
+
+config SUNXI_DRAM_H616_FIXED_PROFILE
+	bool "Fixed build-time DRAM profile"
+	help
+	  Use a single H616 DRAM profile selected at build time.
+	  This keeps the existing Kconfig-based timing selection flow.
+
+config DRAM_SUN50I_H616_DT_PROFILE
+	bool "Default device tree DRAM profile"
+	select OF_CONTROL
+	select SPL_OF_CONTROL
+	help
+	  Load the H616 DRAM parameters from /dram-profiles/default in the
+	  U-Boot device tree at boot.
+
+	  The node must provide the H616 DRAM parameters used by the driver,
+	  including dram-type.
+endchoice
+
+config SUNXI_DRAM_H616_BACKEND_DDR3
+	bool
+	default y if DRAM_SUN50I_H616_DT_PROFILE
+	default y if SUNXI_DRAM_H616_DDR3_1333
+
+config SUNXI_DRAM_H616_BACKEND_LPDDR3
+	bool
+	default y if DRAM_SUN50I_H616_DT_PROFILE
+	default y if SUNXI_DRAM_H616_LPDDR3
+
+config SUNXI_DRAM_H616_BACKEND_LPDDR4
+	bool
+	default y if DRAM_SUN50I_H616_DT_PROFILE
+	default y if SUNXI_DRAM_H616_LPDDR4
+endif
+
+config SUNXI_DRAM_FIXED_PARAMS
+	bool
+	default y if !DRAM_SUN50I_H616
+	default y if DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE
+
 if DRAM_SUN50I_H616 || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
 config DRAM_SUNXI_DX_ODT
-	hex "DRAM DX ODT parameter"
+	hex "DRAM DX ODT parameter" if SUNXI_DRAM_FIXED_PARAMS
+	default 0x0 if !SUNXI_DRAM_FIXED_PARAMS
 	help
 	  DX ODT value from vendor DRAM settings.
 
 config DRAM_SUNXI_DX_DRI
-	hex "DRAM DX DRI parameter"
+	hex "DRAM DX DRI parameter" if SUNXI_DRAM_FIXED_PARAMS
+	default 0x0 if !SUNXI_DRAM_FIXED_PARAMS
 	help
 	  DX DRI value from vendor DRAM settings.
 
 config DRAM_SUNXI_CA_DRI
-	hex "DRAM CA DRI parameter"
+	hex "DRAM CA DRI parameter" if SUNXI_DRAM_FIXED_PARAMS
+	default 0x0 if !SUNXI_DRAM_FIXED_PARAMS
 	help
 	  CA DRI value from vendor DRAM settings.
 
 config DRAM_SUNXI_ODT_EN
-	hex "DRAM ODT EN parameter"
+	hex "DRAM ODT EN parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x1
 	help
 	  ODT EN value from vendor DRAM settings.
@@ -119,49 +169,50 @@ config DRAM_SUNXI_MR14
 	  MR14 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR0
-	hex "DRAM TPR0 parameter"
+	hex "DRAM TPR0 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR0 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR1
-	hex "DRAM TPR1 parameter"
+	hex "DRAM TPR1 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR1 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR2
-	hex "DRAM TPR2 parameter"
+	hex "DRAM TPR2 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR2 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR3
-	hex "DRAM TPR3 parameter"
+	hex "DRAM TPR3 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR3 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR6
-	hex "DRAM TPR6 parameter"
+	hex "DRAM TPR6 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x3300c080
 	help
 	  TPR6 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR10
-	hex "DRAM TPR10 parameter"
+	hex "DRAM TPR10 parameter" if SUNXI_DRAM_FIXED_PARAMS
+	default 0x0 if !SUNXI_DRAM_FIXED_PARAMS
 	help
 	  TPR10 value from vendor DRAM settings. It tells which features
 	  should be configured, like write leveling, read calibration, etc.
 
 config DRAM_SUNXI_TPR11
-	hex "DRAM TPR11 parameter"
+	hex "DRAM TPR11 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR11 value from vendor DRAM settings.
 
 config DRAM_SUNXI_TPR12
-	hex "DRAM TPR12 parameter"
+	hex "DRAM TPR12 parameter" if SUNXI_DRAM_FIXED_PARAMS
 	default 0x0
 	help
 	  TPR12 value from vendor DRAM settings.
@@ -608,6 +659,7 @@ config SUNXI_DRAM_DDR4
 
 choice
 	prompt "DRAM Type and Timing"
+	depends on SUNXI_DRAM_FIXED_PARAMS
 	default SUNXI_DRAM_A523_LPDDR4 if MACH_SUN55I_A523
 	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
 	default SUNXI_DRAM_DDR2_V3S if MACH_SUN8I_V3S
@@ -718,7 +770,7 @@ config DRAM_TYPE
 	Set the dram type, 3: DDR3, 7: LPDDR3
 
 config DRAM_CLK
-	int "sunxi dram clock speed"
+	int "sunxi dram clock speed" if SUNXI_DRAM_FIXED_PARAMS
 	default 792 if MACH_SUN9I
 	default 648 if MACH_SUN8I_R40
 	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 9c79b55abf3..862386cf6f0 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SUNXI_DRAM_DW)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_sun50i_h6.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN50I_H6)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_sun50i_h616.o dram_dw_helpers.o
+obj-$(CONFIG_DRAM_SUN50I_H616_DT_PROFILE) += dram_sun50i_h616_dt.o
 obj-$(CONFIG_DRAM_SUN50I_H616)	+= dram_timings/
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index c3e1286fb35..96d84398eee 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1281,33 +1281,48 @@ bool mctl_core_init(const struct dram_para *para,
 	return mctl_ctrl_init(para, config);
 }
 
-static const struct dram_para para = {
-	.clk = CONFIG_DRAM_CLK,
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	.type = SUNXI_DRAM_TYPE_DDR3,
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	.type = SUNXI_DRAM_TYPE_LPDDR3,
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	.type = SUNXI_DRAM_TYPE_LPDDR4,
-#endif
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
+static enum sunxi_dram_type h616_get_fixed_dram_type(void)
+{
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_DDR3_1333))
+		return SUNXI_DRAM_TYPE_DDR3;
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_LPDDR3))
+		return SUNXI_DRAM_TYPE_LPDDR3;
+	if (IS_ENABLED(CONFIG_SUNXI_DRAM_H616_LPDDR4))
+		return SUNXI_DRAM_TYPE_LPDDR4;
+
+	panic("No fixed H616 DRAM type selected\n");
+}
+
+static void h616_get_fixed_dram_para(struct dram_para *para)
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
 
 unsigned long sunxi_dram_init(void)
 {
 	void *const prcm = (void *)SUNXI_PRCM_BASE;
+	struct dram_para para;
 	struct dram_config config;
 	unsigned long size;
 
+	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_DT_PROFILE))
+		h616_get_dram_para_dt(&para);
+	else
+		h616_get_fixed_dram_para(&para);
+
 	setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, BIT(8));
 	clrbits_le32(prcm + CCU_PRCM_OHMS240, 0x3f);
 
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616_dt.c b/arch/arm/mach-sunxi/dram_sun50i_h616_dt.c
new file mode 100644
index 00000000000..2620e24b41a
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616_dt.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * H616 DRAM parameter loading from the device tree
+ */
+
+#include <errno.h>
+#include <vsprintf.h>
+#include <asm/global_data.h>
+#include <asm/arch/dram.h>
+#include <linux/libfdt.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
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
+static int h616_get_dram_type(u32 val, enum sunxi_dram_type *type)
+{
+	switch (val) {
+	case SUNXI_DRAM_TYPE_DDR3:
+	case SUNXI_DRAM_TYPE_LPDDR3:
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		*type = val;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int h616_parse_dram_para(const void *blob, int node,
+				struct dram_para *para)
+{
+	u32 val;
+
+	if (h616_fdt_read_u32(blob, node, "allwinner,dram-clk", &para->clk))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,dram-type", &val))
+		return -EINVAL;
+	if (h616_get_dram_type(val, &para->type))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,dx-odt", &para->dx_odt))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,dx-dri", &para->dx_dri))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,ca-dri", &para->ca_dri))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,odt-en", &para->odt_en))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr0", &para->tpr0))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr2", &para->tpr2))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr6", &para->tpr6))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr10", &para->tpr10))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr11", &para->tpr11))
+		return -EINVAL;
+	if (h616_fdt_read_u32(blob, node, "allwinner,tpr12", &para->tpr12))
+		return -EINVAL;
+
+	return 0;
+}
+
+void h616_get_dram_para_dt(struct dram_para *para)
+{
+	const void *blob = gd->fdt_blob;
+	int node, profiles, ret;
+
+	profiles = fdt_path_offset(blob, "/dram-profiles");
+	if (profiles < 0)
+		panic("H616 DT DRAM profile selection failed: %d\n", profiles);
+
+	node = fdt_subnode_offset(blob, profiles, "default");
+	if (node < 0)
+		panic("H616 DT DRAM profile selection failed: %d\n", node);
+
+	ret = h616_parse_dram_para(blob, node, para);
+	if (ret)
+		panic("H616 DT DRAM profile selection failed: %d\n", ret);
+}
diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-sunxi/dram_timings/Makefile
index 5de9fd5aab4..165f6123cb4 100644
--- a/arch/arm/mach-sunxi/dram_timings/Makefile
+++ b/arch/arm/mach-sunxi/dram_timings/Makefile
@@ -3,9 +3,9 @@ obj-$(CONFIG_SUNXI_DRAM_LPDDR3_STOCK)	+= lpddr3_stock.o
 obj-$(CONFIG_SUNXI_DRAM_DDR2_V3S)	+= ddr2_v3s.o
 obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)	+= h6_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
-obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
-obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
-obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
+obj-$(CONFIG_SUNXI_DRAM_H616_BACKEND_DDR3) += h616_ddr3_1333.o
+obj-$(CONFIG_SUNXI_DRAM_H616_BACKEND_LPDDR3) += h616_lpddr3.o
+obj-$(CONFIG_SUNXI_DRAM_H616_BACKEND_LPDDR4) += h616_lpddr4_2133.o
 obj-$(CONFIG_SUNXI_DRAM_A133_DDR4)	+= a133_ddr4.o
 obj-$(CONFIG_SUNXI_DRAM_A133_LPDDR4)	+= a133_lpddr4.o
 obj-$(CONFIG_SUNXI_DRAM_A523_DDR3)	+= a523_ddr3.o
-- 
2.43.0

