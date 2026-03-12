Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D349D106ACF3
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 23:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6A784166;
	Fri, 13 Mar 2026 00:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+oNKg9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197F084167; Thu, 12 Mar 2026 21:49:52 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE4983F14
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 21:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50917417efbso13194771cf.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773348587; x=1773953387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+eVG8E5Q5GW/LvVrK9XeDo1h4OXsNNbOqpGEOnk4q0=;
 b=U+oNKg9k+zL6nSuCsZqbcpM812V5Xu4nwdUFxJlFBIo1ma3oQuDlEQqaFrLUrzuB9K
 S1++kA6m4QukDoMZApkDkE8v0zz08k6SlgxYXjocJ4/G7k6O3qx61bWrBZ80eN/be/T4
 UCHLe0E4GifLsy17+9InVC6JmNK6xXmSnQn70ZOR7Wma5FEerV8iJTufNtyqTCxXXiEb
 1KZjj5wXQh95JCQul4UX0vmtyBF5pQKNSqGz01YorSSY1yQTXFrQ1+WstYwnO9U80mid
 0OpGvEs6L63vDWkEBTcGHdRfJTT7QcFU823a/vRIEqHQ+loFL9MM+vxi4MQc9LWfDe/1
 u3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773348587; x=1773953387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+eVG8E5Q5GW/LvVrK9XeDo1h4OXsNNbOqpGEOnk4q0=;
 b=rMhEHhZzuneK5As64IvkjynGwk7/NDmsnaektp4hXwLIAjMhSaoJcTkEMBxC9Utllb
 zVLyS0E/uSvrZUGStEb92NOfv4TW9CmdwLKXhOPvHFJW13x1rSKQcP3NAsML3Lv1qILe
 k87bMtsYYC2+kEsXpJPPhOsFSrWWu1GdSw8YGc46iEzMa1W3sPPxozCepdQ8w8T1lYES
 KTIHkrCUU1grpRaMFDhgyjnDvGva3qzYsoRtm+93Rpk+IeCF8kY7eMSpEdr95vKRcvc+
 U1nG649iwQUDw+SJZSpVcz5TLm87QiwycwpD7sppuBwzqplzRgmb0qU6geejBL0C2UIO
 MNCw==
X-Gm-Message-State: AOJu0YzEpLL7s2Df/vihjes9PsLBED+inkkFAt3gAHlTgJaZbIbJUG97
 +qskQjJI1B4W8SHsVMVboXmbWb5ARsmw0Ojd8ffhIZ2V8ssqQT7BSHMDPAI9YQ==
X-Gm-Gg: ATEYQzw4gCt7k5wNWY8V3i5VnJqhnOX/bTiAklsilighSXBka7iYcA7TIU6LzUHjAv9
 L34vxhQDOoFPV0Icxa2rvJIYALfWP5Qy14rW5ljeuVuB1OIkPag0QN4yHh+0gFJ3tMn6gf+uuFI
 n7uOdrrIgptut9q5GIIBZZUDOtLg9aM28Bd+A6CSpqKtIoabTTtFOXNtM0HBr/iAJsNUvn7kU2+
 2FoDAFLjdood2E4dGU0GSaI4WI1sYAUByVKEc0SmC1biuBjfONZSud9TSQs6P3iMdVT2eUruip4
 dHvU/Y1k6f8i41EZHQLVoembiqowo8UVWq6ePr26SJOq3gPakgABm4WRwCyFHdCXE37tEqIWt1q
 CIMIdPLzVWSjCKGL2T8w+hw8godqPOKMU/t3e/vPtHwPjAETOA3tJ2NbRiFcBUIfS+RN5jboCUN
 wNiHkcmkj49NNTtEdxkCSmvjSZP/mE1Qfu2N0R2W6ZT7unpX4WX74cxlNKnPamW0DqIoVf9Dcav
 t9EmHD/SCXohho3ziQBzWOSJpljEfhGTU3jKwg+LYP/SCPzIylnRpYzapGY
X-Received: by 2002:ac8:7e86:0:b0:4ee:1bdb:a547 with SMTP id
 d75a77b69052e-509471bf5b5mr66627701cf.14.1773348586799; 
 Thu, 12 Mar 2026 13:49:46 -0700 (PDT)
Received: from james-x399.localdomain (71-33-158-51.hlrn.qwest.net.
 [71.33.158.51]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5093a0f3ae0sm39273371cf.20.2026.03.12.13.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:49:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH 1/1] sunxi: h616: add GPIO-selected DRAM profiles
Date: Thu, 12 Mar 2026 14:49:06 -0600
Message-ID: <20260312204909.2865983-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 00:03:43 +0100
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

Add an H616 profile-source choice so SPL can either use the existing
fixed Kconfig profile or load a DRAM profile selected by GPIO straps
from the U-Boot device tree. The GPIO-selected path decodes up to four
allwinner,dram-coding-gpios bits and loads the matching profile from
/dram-profiles.

Refactor the H616 DRAM code so the PHY init tables and timing backend are
selected at runtime from para->type, and switch the H616 timing helpers
to use para->clk instead of CONFIG_DRAM_CLK. This allows a single SPL
build to support multiple H616 DRAM types selected at boot while keeping
fixed-profile mode as the default.

Hide the fixed H616 Kconfig timing and parameter prompts when GPIO-based
selection is enabled, since those settings are not used in that mode.
The selector name stays H616-specific because this only models the BSP
GPIO strap flow, not the GPADC-based variants.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h |   7 +-
 arch/arm/mach-sunxi/Kconfig                   |  47 ++-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 367 ++++++++++++++++--
 arch/arm/mach-sunxi/dram_timings/Makefile     |   5 +-
 arch/arm/mach-sunxi/dram_timings/h616.c       |  27 ++
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  |  32 +-
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c |  32 +-
 .../dram_timings/h616_lpddr4_2133.c           |  32 +-
 8 files changed, 463 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616.c

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index a8fdda124a0..ea64f997fbf 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -168,13 +168,16 @@ struct dram_config {
 	u8 bus_full_width;
 };
 
-static inline int ns_to_t(int nanoseconds)
+static inline int h616_ns_to_t(const struct dram_para *para, int nanoseconds)
 {
-	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
+	const unsigned int ctrl_freq = para->clk / 2;
 
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
+void h616_ddr3_set_timing_params(const struct dram_para *para);
+void h616_lpddr3_set_timing_params(const struct dram_para *para);
+void h616_lpddr4_set_timing_params(const struct dram_para *para);
 void mctl_set_timing_params(const struct dram_para *para);
 
 #endif /* _SUNXI_DRAM_SUN50I_H616_H */
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..f8cb0a96182 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -62,7 +62,41 @@ config DRAM_SUN55I_A523
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
+	  Each profile must provide the H616 DRAM parameters used by the
+	  driver. Supported dram-type values are DDR3, LPDDR3, and LPDDR4.
+endchoice
+endif
+
+if (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
 config DRAM_SUNXI_DX_ODT
 	hex "DRAM DX ODT parameter"
 	help
@@ -608,6 +642,7 @@ config SUNXI_DRAM_DDR4
 
 choice
 	prompt "DRAM Type and Timing"
+	depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
 	default SUNXI_DRAM_A523_LPDDR4 if MACH_SUN55I_A523
 	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
 	default SUNXI_DRAM_DDR2_V3S if MACH_SUN8I_V3S
@@ -647,7 +682,8 @@ config SUNXI_DRAM_H6_DDR3_1333
 config SUNXI_DRAM_H616_LPDDR3
 	bool "LPDDR3 DRAM chips on the H616 DRAM controller"
 	select SUNXI_DRAM_LPDDR3
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the LPDDR3 timing used by the stock boot0 by
 	  Allwinner.
@@ -655,7 +691,8 @@ config SUNXI_DRAM_H616_LPDDR3
 config SUNXI_DRAM_H616_LPDDR4
 	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
 	select SUNXI_DRAM_LPDDR4
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the LPDDR4 timing used by the stock boot0 by
 	  Allwinner.
@@ -663,7 +700,8 @@ config SUNXI_DRAM_H616_LPDDR4
 config SUNXI_DRAM_H616_DDR3_1333
 	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
 	select SUNXI_DRAM_DDR3
-	depends on DRAM_SUN50I_H616 || DRAM_SUN50I_A133
+	depends on (DRAM_SUN50I_H616 && SUNXI_DRAM_H616_FIXED_PROFILE) || \
+		   DRAM_SUN50I_A133
 	help
 	  This option is the DDR3 timing used by the boot0 on H616 TV boxes
 	  which use a DDR3-1333 timing.
@@ -719,6 +757,7 @@ config DRAM_TYPE
 
 config DRAM_CLK
 	int "sunxi dram clock speed"
+	depends on !DRAM_SUN50I_H616 || SUNXI_DRAM_H616_FIXED_PROFILE
 	default 792 if MACH_SUN9I
 	default 648 if MACH_SUN8I_R40
 	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..f72c1e0f38c 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -15,6 +15,17 @@
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
+#include <linux/string.h>
+#endif
 #include <asm/arch/clock.h>
 #include <asm/arch/dram.h>
 #include <asm/arch/dram_dw_helpers.h>
@@ -23,6 +34,12 @@
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
@@ -227,45 +244,67 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
+#define H616_PHY_INIT_LEN	27
+
 #ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
+static const u8 phy_init_ddr3[H616_PHY_INIT_LEN] = {
 	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
 	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
 	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
 	0x06, 0x09, 0x0f
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
+};
+
+static const u8 phy_init_lpddr3[H616_PHY_INIT_LEN] = {
 	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
 	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
 	0x08, 0x01, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+};
+
+static const u8 phy_init_lpddr4[H616_PHY_INIT_LEN] = {
 	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
 	0x18, 0x04, 0x1a
-#endif
 };
-#else /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
+#else
+static const u8 phy_init_ddr3[H616_PHY_INIT_LEN] = {
 	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
 	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
 	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
 	0x09, 0x05, 0x18
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
+};
+
+static const u8 phy_init_lpddr3[H616_PHY_INIT_LEN] = {
 	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
 	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
 	0x17, 0x19, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+};
+
+static const u8 phy_init_lpddr4[H616_PHY_INIT_LEN] = {
 	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
 	0x18, 0x03, 0x1a
-#endif
 };
-#endif /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
+#endif
+
+static const u8 *h616_get_phy_init(const struct dram_para *para)
+{
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		return phy_init_ddr3;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		return phy_init_lpddr3;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		return phy_init_lpddr4;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("Unsupported H616 DRAM type: %u\n", para->type);
+	}
+}
+
 #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
 static void mctl_phy_configure_odt(const struct dram_para *para)
 {
@@ -908,6 +947,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+	const u8 *phy_init = h616_get_phy_init(para);
 	u32 val, val2, *ptr, mr0, mr2;
 	int i;
 
@@ -964,7 +1004,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
 
 	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
-	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
+	for (i = 0; i < H616_PHY_INIT_LEN; i++)
 		writel(phy_init[i], &ptr[i]);
 
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
@@ -1319,33 +1359,302 @@ bool mctl_core_init(const struct dram_para *para,
 	return mctl_ctrl_init(para, config);
 }
 
-static const struct dram_para para = {
-	.clk = CONFIG_DRAM_CLK,
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
+static int h616_fdt_read_dram_type(const void *blob, int node, u32 *val)
+{
+	const char *prop;
+	int len;
+
+	prop = fdt_getprop(blob, node, "allwinner,dram-type", &len);
+	if (!prop)
+		return -EINVAL;
+
+	if (len == sizeof(fdt32_t)) {
+		*val = fdt32_to_cpu(*(const fdt32_t *)prop);
+		return 0;
+	}
+
+	if (len <= 0 || prop[len - 1] != '\0')
+		return -EINVAL;
+
+	if (!strcmp(prop, "ddr3")) {
+		*val = SUNXI_DRAM_TYPE_DDR3;
+		return 0;
+	}
+	if (!strcmp(prop, "ddr4")) {
+		*val = SUNXI_DRAM_TYPE_DDR4;
+		return 0;
+	}
+	if (!strcmp(prop, "lpddr3")) {
+		*val = SUNXI_DRAM_TYPE_LPDDR3;
+		return 0;
+	}
+	if (!strcmp(prop, "lpddr4")) {
+		*val = SUNXI_DRAM_TYPE_LPDDR4;
+		return 0;
+	}
+
+	return -EINVAL;
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
+
+		pos += cells;
+	}
+
+	return -ENOENT;
+}
+
+static int h616_parse_dram_para(const void *blob, int node,
+				struct dram_para *para)
+{
+	u32 val;
+
+	if (h616_fdt_read_u32(blob, node, "allwinner,dram-clk", &para->clk))
+		return -EINVAL;
+	if (h616_fdt_read_dram_type(blob, node, &val))
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
+}
+
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
index 5de9fd5aab4..34d46f2864a 100644
--- a/arch/arm/mach-sunxi/dram_timings/Makefile
+++ b/arch/arm/mach-sunxi/dram_timings/Makefile
@@ -3,9 +3,8 @@ obj-$(CONFIG_SUNXI_DRAM_LPDDR3_STOCK)	+= lpddr3_stock.o
 obj-$(CONFIG_SUNXI_DRAM_DDR2_V3S)	+= ddr2_v3s.o
 obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)	+= h6_lpddr3.o
 obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+= h6_ddr3_1333.o
-obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+= h616_ddr3_1333.o
-obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+= h616_lpddr3.o
-obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+= h616_lpddr4_2133.o
+obj-$(CONFIG_DRAM_SUN50I_H616)		+= h616.o h616_ddr3_1333.o
+obj-$(CONFIG_DRAM_SUN50I_H616)		+= h616_lpddr3.o h616_lpddr4_2133.o
 obj-$(CONFIG_SUNXI_DRAM_A133_DDR4)	+= a133_ddr4.o
 obj-$(CONFIG_SUNXI_DRAM_A133_LPDDR4)	+= a133_lpddr4.o
 obj-$(CONFIG_SUNXI_DRAM_A523_DDR3)	+= a523_ddr3.o
diff --git a/arch/arm/mach-sunxi/dram_timings/h616.c b/arch/arm/mach-sunxi/dram_timings/h616.c
new file mode 100644
index 00000000000..d05d528cc57
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_timings/h616.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * sun50i H616 DRAM timing dispatcher
+ *
+ * Build all H616 timing backends and select the appropriate one at runtime.
+ */
+
+#include <asm/arch/dram.h>
+#include <vsprintf.h>
+
+void mctl_set_timing_params(const struct dram_para *para)
+{
+	switch (para->type) {
+	case SUNXI_DRAM_TYPE_DDR3:
+		h616_ddr3_set_timing_params(para);
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR3:
+		h616_lpddr3_set_timing_params(para);
+		break;
+	case SUNXI_DRAM_TYPE_LPDDR4:
+		h616_lpddr4_set_timing_params(para);
+		break;
+	case SUNXI_DRAM_TYPE_DDR4:
+	default:
+		panic("Unsupported H616 DRAM type: %u\n", para->type);
+	}
+}
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd97..4fde0a81a0a 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -14,33 +14,33 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_ddr3_set_timing_params(const struct dram_para *para)
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
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index ce2ffa7a020..d5106765b05 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -14,33 +14,33 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_lpddr3_set_timing_params(const struct dram_para *para)
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
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index 6f5c4acbd62..e1ea41f7a3e 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -12,30 +12,30 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_lpddr4_set_timing_params(const struct dram_para *para)
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
@@ -49,7 +49,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 
 	u8 twtp		= 24;
 	u8 twr2rd	= max(trrd, (u8)4) + 14;
-	u8 trd2wr	= (ns_to_t(4) + 17) - ns_to_t(1);
+	u8 trd2wr	= (h616_ns_to_t(para, 4) + 17) - h616_ns_to_t(para, 1);
 
 	/* set DRAM timing */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
-- 
2.43.0

