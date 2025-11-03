Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6049CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 19:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692008391B;
	Mon,  3 Nov 2025 20:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9DE838EC; Mon,  3 Nov 2025 20:15:14 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE7948331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 20:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d0h9r3jQcz9tWH;
 Mon,  3 Nov 2025 20:15:12 +0100 (CET)
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Ian Roberts <ian.roberts@timesys.com>,
 =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH v2 1/2] gpio: s5p_gpio: Add config option for s5p_gpio driver
Date: Mon,  3 Nov 2025 20:10:35 +0100
Message-ID: <20251103191427.2410755-2-uboot@timmermann.space>
In-Reply-To: <20251103191427.2410755-1-uboot@timmermann.space>
References: <20251103191427.2410755-1-uboot@timmermann.space>
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

This config option is required to make use of a newer pinctrl driver on
exynos 5 platforms. It is enabled per default to ensure older devices
can still use this driver.

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
---

Changes since v1:
- Reworded comment for Kconfig (@Hendrik)

 arch/arm/mach-exynos/pinmux.c | 18 ++++++++++++++++++
 drivers/gpio/Kconfig          |  7 +++++++
 drivers/gpio/Makefile         |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index ed46ea03355..2665aeee6d2 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -934,3 +934,21 @@ int pinmux_decode_periph_id(const void *blob, int node)
 	return PERIPH_ID_NONE;
 }
 #endif
+
+#if !CONFIG_IS_ENABLED(S5P_GPIO)
+
+/* Add stub functions if s5p_gpio driver isn't enabled */
+
+void gpio_set_pull(int pin, int pull)
+{
+}
+
+void gpio_set_drv(int pin, int drv)
+{
+}
+
+void gpio_cfg_pin(int pin, int cfg)
+{
+}
+
+#endif
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..8c93a850611 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -718,5 +718,12 @@ config MPFS_GPIO
 	depends on DM_GPIO
 	help
 		Enable to support the GPIO driver on Polarfire SoC
+config S5P_GPIO
+	default y
+	bool "Samsung S5P GPIO driver"
+	depends on DM_GPIO && S5P
+	help
+	  Support GPIO controllers on Samsung Exynos SoCs.
+	  This driver does not support upstream Linux device tree bindings.
 
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 73c94329e36..a26ef5a0371 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_PCA953X)		+= pca953x.o
 obj-$(CONFIG_ROCKCHIP_GPIO)	+= rk_gpio.o
 obj-$(CONFIG_RCAR_GPIO)		+= gpio-rcar.o
 obj-$(CONFIG_RZA1_GPIO)		+= gpio-rza1.o
-obj-$(CONFIG_S5P)		+= s5p_gpio.o
+obj-$(CONFIG_S5P_GPIO)		+= s5p_gpio.o
 obj-$(CONFIG_SANDBOX_GPIO)	+= sandbox.o sandbox_test.o
 obj-$(CONFIG_TEGRA_GPIO)	+= tegra_gpio.o
 obj-$(CONFIG_TEGRA186_GPIO)	+= tegra186_gpio.o
-- 
2.51.2

